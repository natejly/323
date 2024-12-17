#include "malloc.h"

typedef struct block {
    size_t size;
    struct block *next;
    int free;
    struct block *free_next; 
    struct block *free_prev;
} block;

#define BLOCKSIZE algn(sizeof(block))

static block *free_head = NULL;    

size_t algn(size_t size);
block* find_block(size_t size);
block* new_block(size_t size);
block* split_block(block* block, size_t size);
void add_to_free_list(block *b);
void remove_from_free_list(block *b);

size_t algn(size_t size){
    return (size + 7) / 8 * 8;
}

block* new_block(size_t size){
    void *bptr = sbrk(size + BLOCKSIZE);
    if (bptr == (void*) -1) {
        return NULL;
    }
    block* nblock = (block*)bptr;
    nblock->next = NULL;
    nblock->size = size;
    nblock->free = 0;
    nblock->free_next = NULL;
    nblock->free_prev = NULL;
    return nblock;
}

block* find_block(size_t size) {
    block* curr = free_head;
    while (curr) {
        if (curr->size >= size) {
            return curr;
        }
        curr = curr->free_next;
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
    new->free_next = NULL;
    new->free_prev = NULL;

    b->size = size;

    add_to_free_list(new);
    return new;
}

void add_to_free_list(block *b) {
    b->free = 1;
    b->free_next = free_head;
    b->free_prev = NULL;
    if (free_head) {
        free_head->free_prev = b;
    }
    free_head = b;
}

void remove_from_free_list(block *b) {
    if (b->free_prev) {
        b->free_prev->free_next = b->free_next;
    } else {
        free_head = b->free_next;
    }
    if (b->free_next) {
        b->free_next->free_prev = b->free_prev;
    }
    b->free = 0;
    b->free_next = NULL;
    b->free_prev = NULL;
}

void free(void *firstbyte) {
    if (!firstbyte) {
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; // Prevent double-free
    add_to_free_list(b);
    // defrag();
}

void *malloc(uint64_t numbytes) {
    size_t size = algn(numbytes);
    block *b = find_block(size);
    if (b == NULL) {
        b = new_block(size);
        if (b == NULL) {
            return NULL;
        }
    } else {
        remove_from_free_list(b);
        if (b->size > size + BLOCKSIZE) {
            split_block(b, size);
        }
    }
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
    while (b && b->free_next) {
        if ((void*)b + BLOCKSIZE + b->size == (void*)b->free_next) {
            block *next = b->free_next;
            remove_from_free_list(next);
            b->size += BLOCKSIZE + next->size;
        } else {
            b = b->free_next;
        }
    }
}

int heap_info(heap_info_struct * info) {
    return 0;
}