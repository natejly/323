#define M61_DISABLE 1
#include "dmalloc.hh"
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cinttypes>
#include <cassert>

// You may write code here.
// (Helper functions, types, structs, macros, globals, etc.)
struct dmalloc_statistics {
    unsigned long long nactive;     // number of active allocations [#malloc - #free]
    unsigned long long active_size; // number of bytes in active allocations
    unsigned long long ntotal;      // number of allocations, total
    unsigned long long total_size;  // number of bytes in allocations, total
    unsigned long long nfail;       // number of failed allocation attempts
    unsigned long long fail_size;   // number of bytes in failed allocation attempts
    uintptr_t heap_min;             // smallest address in any region ever allocated
    uintptr_t heap_max;             // largest address in any region ever allocated
};

/// dmalloc_malloc(sz, file, line)
///    Return a pointer to `sz` bytes of newly-allocated dynamic memory.
///    The memory is not initialized. If `sz == 0`, then dmalloc_malloc must
///    return a unique, newly-allocated pointer value. The allocation
///    request was at location `file`:`line`.

static dmalloc_statistics stats = {0, 0, 0, 0, 0, 0, 0, 0};
void* dmalloc_malloc(size_t sz, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings
    // Your code here.
    // wrap the base_malloc function
    if (sz == 0){
        // then we must return unique pointer so set sz to 1
        sz = 1;
        // somehting about allocation request being at file and line
    }
    void* pointer = base_malloc(sz);
    // if we have size 0

    if (pointer != nullptr){
        // then we have successfully allocated memory and will update the stats
        stats.nactive++;
        stats.active_size += sz;
        stats.ntotal++;
        stats.total_size += sz;
        // update the heap min and max
        unsigned long pt = (uintptr_t) pointer;
        // if values are 0 init
        if (stats.heap_min == 0){
            stats.heap_min = pt;
        }
        if (stats.heap_max == 0){
            stats.heap_max = pt;
        }
        if (pt < stats.heap_min){
            stats.heap_min = pt;
        }
        if (pt > stats.heap_max){
            stats.heap_max = pt;
        }
    } else {
        // then we have not allocated memory
        stats.nfail++;
        stats.fail_size += sz;
    }

    return base_malloc(sz);
}


/// dmalloc_free(ptr, file, line)
///    Free the memory space pointed to by `ptr`, which must have been
///    returned by a previous call to dmalloc_malloc. If `ptr == NULL`,
///    does nothing. The free was called at location `file`:`line`.

void dmalloc_free(void* ptr, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings
    // Your code here.

    base_free(ptr);
}


/// dmalloc_calloc(nmemb, sz, file, line)
///    Return a pointer to newly-allocated dynamic memory big enough to
///    hold an array of `nmemb` elements of `sz` bytes each. If `sz == 0`,
///    then must return a unique, newly-allocated pointer value. Returned
///    memory should be initialized to zero. The allocation request was at
///    location `file`:`line`.

void* dmalloc_calloc(size_t nmemb, size_t sz, const char* file, long line) {
    // Your code here (to fix test014).
    void* ptr = dmalloc_malloc(nmemb * sz, file, line);
    if (ptr) {
        memset(ptr, 0, nmemb * sz);
    }
    return ptr;
}


/// dmalloc_get_statistics(stats)
///    Store the current memory statistics in `*stats`.

void dmalloc_get_statistics(dmalloc_statistics* stats) {
    // Stub: set all statistics to enormous numbers
    memset(stats, 255, sizeof(dmalloc_statistics));
    // Your code here.
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
    // Your code here.
}


/// dmalloc_print_heavy_hitter_report()
///    Print a report of heavily-used allocation locations.

void dmalloc_print_heavy_hitter_report() {
    // Your heavy-hitters code here
}
