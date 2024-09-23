#define M61_DISABLE 1
#include "dmalloc.hh"
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cinttypes>
#include <cassert>

// You may write code here.
// (Helper functions, types, structs, macros, globals, etc.)
// struct for header and underflow and overflow
struct meta {
    char* file;
    long line;
    bool allocated;
    size_t size;
    void* underflow;
    void* payload;
    void* overflow;
    meta* next;
};

struct metalist {
    meta* head;
    metalist() : head(nullptr) {}
};

metalist list;
void insert(metalist* list, meta* node){
    if (list->head == nullptr) {
        list->head = node;
    } else {
    meta* temp = list->head;
    list->head = node;
    node->next = temp;
    }
}

meta* remove(metalist* list, meta* node){
    // head is nullptr
    if (list->head == nullptr) {
        return nullptr;
    }
    // head is the node
    if (list->head == node) {
        list->head = node->next;
        return node;
    }
    // traverse
    meta* temp = list->head;
    while (temp != nullptr && temp->next != node) {
        temp = temp->next;
    }
    // if found and not at end of list
    if (temp != nullptr && temp->next == node) {
        temp->next = node->next;
        return node;
    }
    return nullptr;

}

static dmalloc_statistics gstats= {0, 0, 0, 0, 0, 0, 0, 0};


/// dmalloc_malloc(sz, file, line)
///    Return a pointer to `sz` bytes of newly-allocated dynamic memory.
///    The memory is not initialized. If `sz == 0`, then dmalloc_malloc must
///    return a unique, newly-allocated pointer value. The allocation
///    request was at location `file`:`line`.
// innit to 0


void* dmalloc_malloc(size_t sz, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings

    if (sz > (SIZE_MAX - (sizeof(meta) + 2 * sizeof(uint64_t)))) {
        gstats.nfail++;
        gstats.fail_size += sz;
        return nullptr;
    }

    meta* header = (meta*) base_malloc(sz + sizeof(meta) + 2 * sizeof(uint64_t));

    if (header == nullptr) {
        gstats.nfail++;
        gstats.fail_size += sz;
        return nullptr;
    }
    insert(&list, header);
    

    uint64_t* underflow_canary = (uint64_t*) ((uintptr_t) header + sizeof(meta));

    header->payload = (void*) ((uintptr_t) underflow_canary + sizeof(uint64_t));

    uint64_t* overflow_canary = (uint64_t*) ((uintptr_t) header->payload + sz);
    
    // I love me some steaks
    *underflow_canary = 0xDEADBEEFDEADBEEF;
    *overflow_canary = 0xDEADBEEFDEADBEEF;

    // Initialize header fields
    header->size = sz;
    header->underflow = underflow_canary;
    header->overflow = overflow_canary;
    header->file = (char*) file;
    header->line = line;
    header->allocated = true;

    // Update stats
    gstats.nactive++;
    gstats.active_size += sz;
    gstats.ntotal++;
    gstats.total_size += sz;

    // Update min and max with l and r being edges
    uintptr_t l = (uintptr_t) header->payload;  // Start of user-allocated memory
    uintptr_t r = (uintptr_t) header->payload + header->size;  // End of user-allocated memory


    if (gstats.heap_min == 0 || l < gstats.heap_min) {
        gstats.heap_min = l;
    }
    if (gstats.heap_max == 0 || r > gstats.heap_max) {
        gstats.heap_max = r;
    }

    return header->payload;
}


/// dmalloc_free(ptr, file, line)
///    Free the memory space pointed to by `ptr`, which must have been
///    returned by a previous call to dmalloc_malloc. If `ptr == NULL`,
///    does nothing. The free was called at location `file`:`line`.

void dmalloc_free(void* ptr, const char* file, long line) {
    (void) file, (void) line;   // Avoid unused variable warnings

    if (ptr == nullptr) {
        return;
    }
    uintptr_t addy = (uintptr_t) ptr;
    if (addy < gstats.heap_min || addy > gstats.heap_max) {
        // Invalid free: pointer is either not aligned or outside heap boundaries
        fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not in heap\n", file, line, ptr);
        exit(1);
    }
    meta* header = (meta*) ((uintptr_t) ptr - sizeof(meta) - sizeof(uint64_t));
    
    if (header == nullptr) {
        // Invalid free: pointer is not aligned
        fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not in heap\n", file, line, ptr);
        exit(1);
    }
    // check that ptr is the same as the payload
    if (header->payload != ptr || header == nullptr) {
        // Invalid free: pointer is not the same as the payload
        fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not allocated\n", file, line, ptr);

        meta* current = list.head;
        while (current != nullptr) {
            uintptr_t start = (uintptr_t) current->payload;
            uintptr_t end = start + current->size;
            
            // Check if the pointer is inside this block
            if (addy > start && addy < end) {
                size_t offset = addy - start;
                fprintf(stderr, "  %s:%ld: %p is %zu bytes inside a %zu byte region allocated here\n",
        current->file, current->line, ptr, offset, current->size);
                exit(1);
            }
            current = current->next;
        }
        exit(1);
    }

    // Check for double free (if the block was already freed)
    if (!header->allocated) {
        // Double free detected
        fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, double free\n", file, line, ptr);
        exit(1);
    }
    
    header->allocated = false;

    gstats.nactive--;
    gstats.active_size -= header->size;
    // Retrieve the header from the pointer

    // // Retrieve the canaries
    uint64_t* underflow_canary = (uint64_t*) ((uintptr_t) header + sizeof(meta));
    uint64_t* overflow_canary = (uint64_t*) ((uintptr_t) ptr + header->size);

    // check that underflow and overflow are still deadbeef
    if (*underflow_canary != 0xDEADBEEFDEADBEEF || *overflow_canary != 0xDEADBEEFDEADBEEF) {
        // Memory corruption detected
        fprintf(stderr, "MEMORY BUG: %s:%ld: detected wild write during free of pointer %p\n", file, line, ptr);
        exit(1);
    }
    remove(&list, header);


    base_free(header);

    // Note: You do not need to update gstats.ntotal or gstats.total_size
    //       as those represent total allocations, not the currently active allocations.
}

/// dmalloc_calloc(nmemb, sz, file, line)
///    Return a pointer to newly-allocated dynamic memory big enough to
///    hold an array of `nmemb` elements of `sz` bytes each. If `sz == 0`,
///    then must return a unique, newly-allocated pointer value. Returned
///    memory should be initialized to zero. The allocation request was at
///    location `file`:`line`.

void* dmalloc_calloc(size_t nmemb, size_t sz, const char* file, long line) {
    // multplication 
    if (nmemb != 0 && sz > (SIZE_MAX / nmemb)) {
        gstats.nfail++;
        gstats.fail_size += nmemb * sz;
        return nullptr;
    }
    void* ptr = dmalloc_malloc(nmemb * sz, file, line);
    if (ptr) {
        memset(ptr, 0, nmemb * sz);
    }
    return ptr;
}


/// dmalloc_get_statistics(stats)
///    Store the current memory statistics in `*stats`.

void dmalloc_get_statistics(dmalloc_statistics* stats) {
    if (stats != nullptr) {
        // Copy the global statistics to the provided stats structure
        *stats = gstats;
    }
}


/// dmalloc_print_statistics()
///    Print the current memory statistics.

void dmalloc_print_statistics() {
    dmalloc_statistics stats;
    dmalloc_get_statistics(&stats);

    printf("alloc count: active %10llu   total %10llu   fail %10llu\n",
           stats.nactive, stats.ntotal, stats.nfail);
    printf("alloc size:  active %10llu   total %10llu   fail %10llu\n",
           stats.active_size, stats.total_size, stats.fail_size);
}


/// dmalloc_print_leak_report()
///    Print a report of all currently-active allocated blocks of dynamic
///    memory.

void dmalloc_print_leak_report() {
   // run through list and print out the leaks
    meta* temp = list.head;
    while (temp != nullptr) {
        printf("LEAK CHECK: %s:%ld: allocated object %p with size %zu\n",
                   temp->file, temp->line, temp->payload, temp->size);        temp = temp->next;
    }
}


/// dmalloc_print_heavy_hitter_report()
///    Print a report of heavily-used allocation locations.

void dmalloc_print_heavy_hitter_report() {
    // Your heavy-hitters code here
}

