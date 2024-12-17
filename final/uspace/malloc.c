#include "malloc.h"

typedef struct block {
    size_t size;
    struct block *next;
    int free;
} block;
#define BLOCKSIZE algn(sizeof(block))

static block *head = NULL;

size_t algn(size_t size);
block* find_block(size_t size);
block* new_block(size_t size);
block* split_block(block* block, size_t size);


size_t algn(size_t size){
    return (size + 7) / 8 * 8;
}
block* new_block(size_t size){
    // get program break
    void *bptr = sbrk(size + BLOCKSIZE);
    if (bptr == (void*) -1) {
        // alloc failure
    return NULL;
    }
    block* nblock = (block*)bptr;
    // add to linked list 

    nblock->next = NULL;
    nblock->size = size;
    nblock->free = 0;
    // add to linked list 
    if (head == NULL) {
        head = nblock;
    } else {
        block *curr = head;
        while (curr->next != NULL) {
            curr = curr->next;
        }
        curr->next = nblock;
    }
    return nblock;
}
block* find_block(size_t size) {
    block* curr = head;
    while (curr) {
        if (curr->free && curr->size >= size) {
            return curr;
        }
        curr = curr->next;
    }
    return NULL;
}

block* split_block(block* b, size_t size){
    if(b->size < size + BLOCKSIZE){
        return NULL;
    }
    void* nptr = (void*)b + BLOCKSIZE + size;
    block *new = (block*)nptr;

    new->size = b->size - size - BLOCKSIZE;
    new->next = b->next;
    new->free = 1; // New block is free

    // Update the original block
    b->size = size;
    b->next = new;

    return new;

}


void free(void *firstbyte) {
    if (!firstbyte) {
    return;
  }
      block *b = (block *)((char *)firstbyte - BLOCKSIZE);

    // Mark the block as free
    b->free = 1;
  

}

void *malloc(uint64_t numbytes) {
    size_t size = algn(numbytes);
    block *b = find_block(size);
    if (b == NULL){
        // get a new one
        b = new_block(size);
        if (b==NULL){
            //alloc fail
            return NULL;
        }
    } else {
        b->free = 0;
        // check split
        if (b->size > size + BLOCKSIZE) {
            split_block(b, size);
        }
    }
    return (void*)((void*)b + BLOCKSIZE);

}


void * calloc(uint64_t num, uint64_t sz) {
    uint64_t total = num * sz;
    void *ptr = malloc(total);
    if (ptr) {
        memset(ptr, 0, total);
    }
    return ptr;
}

void *realloc(void *ptr, uint64_t sz) {
    if (ptr == NULL) {
        return malloc(sz); // Equivalent to malloc if `ptr` is NULL
    }

    if (sz == 0) {
        free(ptr); // Equivalent to free if size is 0
        return NULL;
    }

    block *b = (block*)((void*)ptr - BLOCKSIZE); // Get the block metadata
    size_t aligned_size = algn(sz);

    // If the current block is already large enough
    if (b->size >= aligned_size) {
        // Split the block if it has excess space
        if (b->size > aligned_size + BLOCKSIZE) {
            split_block(b, aligned_size);
        }
        return ptr; // Return the same pointer if resizing in place
    }

    // If the current block is too small, allocate a new block
    void *new_ptr = malloc(sz);
    if (!new_ptr) {
        return NULL; // Allocation failed
    }

    // Copy data from the old block to the new block
    memcpy(new_ptr, ptr, b->size);

    // Free the old block
    free(ptr);

    return new_ptr;
}


void defrag() {
    block *b = head;

    while (b && b->next) {
        if (b->free && b->next->free) {
            // Merge the current block with the next block
            b->size += BLOCKSIZE + b->next->size;
            b->next = b->next->next;  // Skip the next block after merging

        } else {
            b = b->next;  // Advance to the next block if no merge occurred
        }
    }
}

int heap_info(heap_info_struct * info) {
    return 0;
}