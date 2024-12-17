#include "malloc.h"
// used https://danluu.com/malloc-tutorial/
typedef struct block {
    size_t size;
    struct block *next;
    int free;
    struct block *free_next; 
    struct block *free_prev;
} block;


#define ARRAY_SIZE 100
#define BLOCKSIZE algn(sizeof(block))

static block *free_head = NULL;    
int num_allocs = 0;
long * size_array = NULL;
void ** ptr_array = NULL;
int free_space = 0;
int largest_free_chunk = 0;

void update_largest_free_chunk();
void update_free_space();
void add_alloc(block* b);    
void remove_alloc(block* b);

size_t algn(size_t size);
block* find_block(size_t size);
block* new_block(size_t size);
block* split_block(block* block, size_t size);
void add_to_free_list(block *b);
void remove_from_free_list(block *b);
void heap_init();

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
void update_largest_free_chunk() {
    largest_free_chunk = 0; // Reset the value
    block *b = free_head;
    int size;
    // Traverse the free list to find the largest free chunk
    while (b) {
        size = (int)b->size;
        if (size > largest_free_chunk) {
            largest_free_chunk = size;
        }
        b = b->free_next;
    }
}

void free(void *firstbyte) {
    if (!firstbyte) {
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; // Prevent double-free
    add_to_free_list(b);
    remove_alloc(b); // Remove from size_array and ptr_array
    update_free_space();         // Update free space
    update_largest_free_chunk(); // Update largest free chunk

}

void *malloc(uint64_t numbytes) {
    if (size_array == NULL) { 
        heap_init();
    }
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
            update_free_space();         

        }
    }
    add_alloc(b); 
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
    update_free_space();         // Update free space
    update_largest_free_chunk(); // Update largest free chunk

}
void heap_init() {
    size_array = (long*) sbrk(sizeof(long) * ARRAY_SIZE);
    ptr_array = (void**) sbrk(sizeof(void*) * ARRAY_SIZE);
    if (size_array == (void*)-1 || ptr_array == (void*)-1) {
        // Handle sbrk failure
        size_array = NULL;
        ptr_array = NULL;
    }
    num_allocs = 0;
    free_space = 0;
    largest_free_chunk = 0;
}

void update_free_space() {
    free_space = 0; // Reset the free space counter
    block *b = free_head;

    // Traverse the free list and sum up the size of free blocks
    while (b) {
        free_space += b->size + BLOCKSIZE; // Add block size + metadata size
        b = b->free_next;
    }
}

void add_alloc(block* b){
    size_array[num_allocs] = b->size;
    ptr_array[num_allocs] = (void*)((void*)b + BLOCKSIZE);
} 
void remove_alloc(block* b){
    num_allocs--;
    size_array[num_allocs] = 0;
    // ptr_array[num_allocs] = NULL;
}


int heap_info(heap_info_struct * info) {
    info->num_allocs = num_allocs;
    info->free_space = free_space;             
    info->largest_free_chunk = largest_free_chunk;

    info->size_array = size_array;
    info->ptr_array = ptr_array;
    return 0;
}


// qsort stuff stolen from heapinfo.c
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
/* Discontinue quicksort algorithm when partition gets below this size.
   This particular magic number was chosen to work best on a Sun 4/260. */
#define MAX_THRESH 4
/* Stack node declarations used to store unfulfilled partition obligations. */
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

void
_quicksort (void *const pbase, size_t total_elems, size_t size,
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

int ptr_comparator( const void * a, const void * b){
    ptr_with_size * a_ptr = (ptr_with_size *) a;
    ptr_with_size * b_ptr = (ptr_with_size *) b;

    return (int)b_ptr->size - (int)a_ptr->size;
}