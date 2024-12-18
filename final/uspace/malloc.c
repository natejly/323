#include "malloc.h"

// https://www.geeksforgeeks.org/singly-linked-list-tutorial/#
//quick sort taken from heapinfo test
// also looked at https://danluu.com/malloc-tutorial/
typedef struct ptr_with_size{
    void * ptr;
    long size;
} ptr_with_size;
#define SWAP(a, b, size)                                                      \
  do                                                                              \
    {                                                                              \
      size_t __size = (size);                                                      \
      char *__a = (a), *__b = (b);                                              \
      do                                                                      \
        {                                                                      \
          char __tmp = *__a;                                                      \
          *__a++ = *__b;                                                      \
          *__b++ = __tmp;                                                      \
        } while (--__size > 0);                                                      \
    } while (0)
#define MAX_THRESH 4
typedef struct
  {
    char *lo;
    char *hi;
  } stack_node;
#  define CHAR_BIT        8
#define STACK_SIZE        (CHAR_BIT * sizeof (size_t))
#define PUSH(low, high)        ((void) ((top->lo = (low)), (top->hi = (high)), ++top))
#define        POP(low, high)        ((void) (--top, (low = top->lo), (high = top->hi)))
#define        STACK_NOT_EMPTY        (stack < top)
typedef int (*__compar_fn_t) (const void *, const void *);
void _quicksort1 (void *const pbase, size_t total_elems, size_t size,
            __compar_fn_t cmp);
void _quicksort1 (void *const pbase, size_t total_elems, size_t size,
            __compar_fn_t cmp)
{
    char *base_ptr = (char *) pbase;
    const size_t max_thresh = MAX_THRESH * size;
    if (total_elems == 0)
    /* Avoid lossage with unsigned arithmetic below.  */
    return;
    if (total_elems > MAX_THRESH)
    {
    char *lo = base_ptr;
    char *hi = &lo[size * (total_elems - 1)];
    stack_node stack[STACK_SIZE];
    stack_node *top = stack;
    PUSH (NULL, NULL);
    while (STACK_NOT_EMPTY)
    {
        char *left_ptr;
        char *right_ptr;
        /* Select median value from among LO, MID, and HI. Rearrange
           LO and HI so the three values are sorted. This lowers the
           probability of picking a pathological pivot value and
           skips a comparison for both the LEFT_PTR and RIGHT_PTR in
           the while loops. */
        char *mid = lo + size * ((hi - lo) / size >> 1);
        if ((*cmp) ((void *) mid, (void *) lo) < 0)
        SWAP (mid, lo, size);
        if ((*cmp) ((void *) hi, (void *) mid) < 0)
        SWAP (mid, hi, size);
        else
        goto jump_over;
        if ((*cmp) ((void *) mid, (void *) lo) < 0)
        SWAP (mid, lo, size);
jump_over:;
      left_ptr  = lo + size;
      right_ptr = hi - size;
      /* Here's the famous ``collapse the walls'' section of quicksort.
         Gotta like those tight inner loops!  They are the main reason
         that this algorithm runs much faster than others. */
      do
      {
          while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
          left_ptr += size;
          while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
          right_ptr -= size;
          if (left_ptr < right_ptr)
          {
          SWAP (left_ptr, right_ptr, size);
          if (mid == left_ptr)
              mid = right_ptr;
          else if (mid == right_ptr)
              mid = left_ptr;
          left_ptr += size;
          right_ptr -= size;
          }
          else if (left_ptr == right_ptr)
          {
          left_ptr += size;
          right_ptr -= size;
          break;
          }
      }
      while (left_ptr <= right_ptr);
      /* Set up pointers for next iteration.  First determine whether
         left and right partitions are below the threshold size.  If so,
         ignore one or both.  Otherwise, push the larger partition's
         bounds on the stack and continue sorting the smaller one. */
      if ((size_t) (right_ptr - lo) <= max_thresh)
      {
          if ((size_t) (hi - left_ptr) <= max_thresh)
          /* Ignore both small partitions. */
          POP (lo, hi);
          else
          /* Ignore small left partition. */
          lo = left_ptr;
      }
      else if ((size_t) (hi - left_ptr) <= max_thresh)
          /* Ignore small right partition. */
          hi = right_ptr;
      else if ((right_ptr - lo) > (hi - left_ptr))
      {
          /* Push larger left partition indices. */
          PUSH (lo, right_ptr);
          lo = left_ptr;
      }
      else
      {
          /* Push larger right partition indices. */
          PUSH (left_ptr, hi);
          hi = right_ptr;
      }
    }
    }
    /* Once the BASE_PTR array is partially sorted by quicksort the rest
       is completely sorted using insertion sort, since this is efficient
       for partitions below MAX_THRESH size. BASE_PTR points to the beginning
       of the array to sort, and END_PTR points at the very last element in
       the array (*not* one beyond it!). */
#define min(x, y) ((x) < (y) ? (x) : (y))
    {
    char *const end_ptr = &base_ptr[size * (total_elems - 1)];
    char *tmp_ptr = base_ptr;
    char *thresh = min(end_ptr, base_ptr + max_thresh);
    char *run_ptr;
    /* Find smallest element in first threshold and place it at the
       array's beginning.  This is the smallest array element,
       and the operation speeds up insertion sort's inner loop. */
    for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
        if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
        tmp_ptr = run_ptr;
    if (tmp_ptr != base_ptr)
        SWAP (tmp_ptr, base_ptr, size);
    /* Insertion sort, running from left-hand-side up to right-hand-side.  */
    run_ptr = base_ptr + size;
    while ((run_ptr += size) <= end_ptr)
    {
        tmp_ptr = run_ptr - size;
        while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
        tmp_ptr -= size;
        tmp_ptr += size;
        if (tmp_ptr != run_ptr)
        {
        char *trav;
        trav = run_ptr + size;
        while (--trav >= run_ptr)
        {
            char c = *trav;
            char *hi, *lo;
            for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
            *hi = *lo;
            *hi = c;
        }
        }
    }
    }
}
int ptr_comparator1(const void *a, const void *b);
int ptr_comparator1(const void *a, const void *b) {
    ptr_with_size *a_ptr = (ptr_with_size *)a;
    ptr_with_size *b_ptr = (ptr_with_size *)b;

    // Sort by size in descending order
    return (int)b_ptr->size - (int)a_ptr->size;
}
//----------------------My Code Starts Here--------------------------------------------------
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
// sbrk increment of size and return the new block
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
// check free list to see if we have a block that can fit the size
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
// if we have enough left room over split
block* split_block(block* b, size_t size){
    if (b->size < size + BLOCKSIZE + BLOCKSIZE) {
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
    // add to head if smallest
    if (b < free_head) {
        b->next = free_head;
        free_head = b;
        return;
    }
    // else insert in order
    block *curr = free_head;
    while (curr->next && curr->next < b) {
        curr = curr->next;
    }
    b->next = curr->next;
    curr->next = b;
}

void remove_from_free_list(block *b) {
    // if is head
    if (free_head == b) {
        free_head = b->next;
    } else {
        // itterate and merge
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
    // add to head
    b->free = 0; 
    b->next = malloc_head;
    malloc_head = b; 
}

void remove_from_malloc_list(block *b) {
    if (malloc_head == b) {
        malloc_head = b->next; 
    } else {
        block *curr = malloc_head;
        while (curr && curr->next != b) {
            curr = curr->next;
        }
        if (curr) {
            curr->next = b->next; 
        }
    }
    b->free = 1; 
    b->next = NULL; 
}

void free(void *firstbyte) {
    if (firstbyte == NULL) {
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; 
    num_allocs--;
    // switch lists
    remove_from_malloc_list(b); 
    add_to_free_list(b);
}

void *malloc(uint64_t numbytes) {
    if (numbytes == 0) {
        return NULL;
    }
    size_t size = algn(numbytes);
    // check if we have a block that can fit
    block *b = find_block(size);
    if (b == NULL) {
        // if not then create a new block
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
    if (sz == 0 && ptr != NULL) {
        free(ptr);
        return NULL;
    }
    // make sure to align the size
    block *b = (block*)((void*)ptr - BLOCKSIZE);
    size_t aligned_size = algn(sz);
    // check if can fit in current block
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
    // merge free blocks that are next to each other
    while (b && b->next) { 
        block *next = b->next;
        if ((char *)b + b->size + BLOCKSIZE == (char *)next) {
            b->size += next->size + BLOCKSIZE;
            b->next = next->next; 
            // remove 2nd one
            remove_from_free_list(next);
        } else {
            b = b->next;
        }
    }
}

void sort_ptr_with_size(void **ptr_array, long *size_array, int allocs) {
    ptr_with_size *combined_array = (ptr_with_size *)malloc(allocs * sizeof(ptr_with_size));
    if (!combined_array) return; 
    // janky way to avoid getting combined array in heapinfo stats
    block *b = (block *)((char *)combined_array - BLOCKSIZE);
    remove_from_malloc_list(b);
    num_allocs--;

    for (int i = 0; i < allocs; i++) {
        combined_array[i].ptr = ptr_array[i];
        combined_array[i].size = size_array[i];
    }
    _quicksort1(combined_array, allocs, sizeof(ptr_with_size), ptr_comparator1);

    for (int i = 0; i < allocs; i++) {
        ptr_array[i] = combined_array[i].ptr;
        size_array[i] = combined_array[i].size;
    }
    free(combined_array);
    // manually remove from free list
    remove_from_free_list(b);
    num_allocs++;
}

int heap_info(heap_info_struct * info) {
    // if no allocations
    if (num_allocs == 0) {
    info->size_array = NULL;
    info->ptr_array = NULL;
    info->free_space = 0;
    info->largest_free_chunk = 0;
    return 0;
}
    info->num_allocs = num_allocs;
    long *size_array = (long*)malloc((num_allocs) * sizeof(long));
    void **ptr_array = (void**)malloc((num_allocs) * sizeof(void*));
    if (!size_array || !ptr_array) {
        free(size_array);
        free(ptr_array);
        return -1;
    }
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
    // skip the first two blocks b/c are arrays
    block *bm = malloc_head->next->next;
    int x = 0;
    // populate
    while (bm) {
        size_array[x] = bm->size;
        ptr_array[x] = (void*)((void*)bm + BLOCKSIZE);
        bm = bm->next;
        x++;
    }
    // TODO: change this to a qsort
    // for (int i = 0; i < num_allocs-2; i++) {
    //     for (int j = i + 1; j < num_allocs-2; j++) {
    //         if (size_array[i] < size_array[j]) {
    //             long temp = size_array[i];
    //             size_array[i] = size_array[j];
    //             size_array[j] = temp;
    //             void *temp_ptr = ptr_array[i];
    //             ptr_array[i] = ptr_array[j];
    //             ptr_array[j] = temp_ptr;
    //         }
    //     }
    // }

    sort_ptr_with_size(ptr_array, size_array, num_allocs-2);

    info->size_array = size_array;
    info->ptr_array = ptr_array;
    info->free_space = (int)free_space;
    info->largest_free_chunk = (int)largest_free_chunk + BLOCKSIZE;
    return 0;
}