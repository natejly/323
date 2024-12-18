#include "malloc.h"

typedef struct block {
    size_t size;
    struct block *next;
    int free;
} block;

#define BLOCKSIZE algn(sizeof(block))

static block *free_head = NULL;    
static block *malloc_head = NULL;
int num_allocs = 0;
size_t algn(size_t size);
block* find_block(size_t size);
block* new_block(size_t size);
block* split_block(block* block, size_t size);
void add_to_free_list(block *b);
void remove_from_free_list(block *b);
void add_to_malloc_list(block *b);
void remove_from_malloclist(block *b);

size_t algn(size_t size){
    return (size + 7) / 8 * 8;
}

block* new_block(size_t size){
    void *bptr = sbrk(size + BLOCKSIZE);
    if (bptr == (void*) -1) {
        return NULL;
    }
    block* nblock = (block*)bptr;
    nblock->size = size;
    nblock->free = 0;
    nblock->next = NULL;
    return nblock;
}

block* find_block(size_t size) {
    block* curr = free_head;
    while (curr) {
        if (curr->size >= size) {
            return curr;
        }
        curr = curr->next;
    }
    return NULL;
}

block* split_block(block* b, size_t size){
    if (b->size < size + BLOCKSIZE) {
        return NULL;
    }
    void* nptr = (void*)b + BLOCKSIZE + size;
    block *new = (block*)nptr;

    new->size = b->size - size - BLOCKSIZE;
    new->free = 1;
    new->next = NULL;
    b->size = size;
    add_to_free_list(new);
    return new;
}

void add_to_free_list(block *b) {
    // insert in order of address
    if (!free_head) {
        free_head = b;
        return;
    }
    if (b < free_head) {
        b->next = free_head;
        free_head = b;
        return;
    }
    block *curr = free_head;
    while (curr->next && curr->next < b) {
        curr = curr->next;
    }
    b->next = curr->next;
    curr->next = b;



}

void remove_from_free_list(block *b) {
    if (free_head == b) {
        free_head = b->next;
    } else {
        block *curr = free_head;
        while (curr && curr->next != b) {
            curr = curr->next;
        }
        if (curr) {
            curr->next = b->next;
        }
    }
    b->free = 0;
    b->next = NULL;
}
void add_to_malloc_list(block *b) {
    b->free = 0; // Mark as allocated
    b->next = malloc_head;
    malloc_head = b; // Add to the malloc list
}

void remove_from_malloc_list(block *b) {
    if (malloc_head == b) {
        malloc_head = b->next; // Remove from the head of the malloc list
    } else {
        block *curr = malloc_head;
        while (curr && curr->next != b) {
            curr = curr->next;
        }
        if (curr) {
            curr->next = b->next; 
        }
    }
    b->free = 1; // Mark as free
    b->next = NULL; 
}

void free(void *firstbyte) {
    if (!firstbyte) {
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; // Prevent double-free
    num_allocs--;
    remove_from_malloc_list(b); // Remove from malloc list
    add_to_free_list(b);
}

void *malloc(uint64_t numbytes) {
    size_t size = algn(numbytes);
    block *b = find_block(size);
    if (b == NULL) {
        b = new_block(size);
        if (b == NULL) {
            return NULL;
        }
    }
        remove_from_free_list(b);
        if (b->size > size + BLOCKSIZE) {
            split_block(b, size);
        }
    add_to_malloc_list(b);
    num_allocs++;
    return (void*)((void*)b + BLOCKSIZE);
}

void *calloc(uint64_t num, uint64_t sz) {
    uint64_t total = num * sz;
    void *ptr = malloc(total);
    if (ptr) {
        memset(ptr, 0, total);
    }
    return ptr;
}

void *realloc(void *ptr, uint64_t sz) {
    if (ptr == NULL) {
        return malloc(sz);
    }
    if (sz == 0) {
        free(ptr);
        return NULL;
    }
    block *b = (block*)((void*)ptr - BLOCKSIZE);
    size_t aligned_size = algn(sz);

    if (b->size >= aligned_size) {
        if (b->size > aligned_size + BLOCKSIZE) {
            split_block(b, aligned_size);
        }
        return ptr;
    }

    void *new_ptr = malloc(sz);
    if (!new_ptr) {
        return NULL;
    }
    memcpy(new_ptr, ptr, b->size);
    free(ptr);
    return new_ptr;
}

void defrag() {
    block *b = free_head;

    while (b && b->next) { // Ensure there are at least two blocks to compare
        block *next = b->next;

        // Check if b and next are adjacent
        if ((char *)b + b->size + BLOCKSIZE == (char *)next) {
            // Coalesce next into b
            b->size += next->size + BLOCKSIZE;
            b->next = next->next; // Remove next from the free list
            remove_from_free_list(next);
        } else {
            // Move to the next block if no merge happens
            b = b->next;
        }
    }
}




int heap_info(heap_info_struct * info) {
    info->num_allocs = num_allocs;
    long *size_array = (long*)malloc((num_allocs) * sizeof(long));
    void **ptr_array = (void**)malloc((num_allocs) * sizeof(void*));

    if (!size_array || !ptr_array) {
        return -1;
    }
    // calculate free space and largest free chunk including block size
    block *bf = free_head;
    size_t free_space = 0;
    size_t largest_free_chunk = 0;
    while (bf) {
        free_space += bf->size + BLOCKSIZE;
        if (bf->size > largest_free_chunk) {
            largest_free_chunk = bf->size;
        }
        bf = bf->next;
    }

    block *bm = malloc_head->next->next;
    int x = 0;
    while (bm) {
        size_array[x] = bm->size;
        ptr_array[x] = (void*)((void*)bm + BLOCKSIZE);
        bm = bm->next;
        x++;
    }
    // TODO: change this to a qsort
    for (int i = 0; i < num_allocs-2; i++) {
        for (int j = i + 1; j < num_allocs-2; j++) {
            if (size_array[i] < size_array[j]) {
                long temp = size_array[i];
                size_array[i] = size_array[j];
                size_array[j] = temp;
                void *temp_ptr = ptr_array[i];
                ptr_array[i] = ptr_array[j];
                ptr_array[j] = temp_ptr;
            }
        }
    }

    if (num_allocs == 0) {
        info->size_array = NULL;
        info->ptr_array = NULL;
        return 0;
    }else{
        info->size_array = size_array;
        info->ptr_array = ptr_array;
    }
    info->free_space = (int)free_space;
    info->largest_free_chunk = (int)largest_free_chunk;
    return 0;
}