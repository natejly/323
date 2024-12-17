
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	53                   	push   %rbx
  100009:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000d:	cd 31                	int    $0x31
  10000f:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100011:	48 8d 05 0f 30 00 00 	lea    0x300f(%rip),%rax        # 103027 <end+0xfff>
  100018:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001e:	48 89 05 e3 1f 00 00 	mov    %rax,0x1fe3(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100025:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100028:	48 83 e8 01          	sub    $0x1,%rax
  10002c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100032:	48 89 05 c7 1f 00 00 	mov    %rax,0x1fc7(%rip)        # 102000 <stack_bottom>
  100039:	eb 02                	jmp    10003d <process_main+0x3d>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  10003b:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  10003d:	e8 5c 05 00 00       	call   10059e <rand>
  100042:	48 63 d0             	movslq %eax,%rdx
  100045:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  10004c:	48 c1 fa 25          	sar    $0x25,%rdx
  100050:	89 c1                	mov    %eax,%ecx
  100052:	c1 f9 1f             	sar    $0x1f,%ecx
  100055:	29 ca                	sub    %ecx,%edx
  100057:	6b d2 64             	imul   $0x64,%edx,%edx
  10005a:	29 d0                	sub    %edx,%eax
  10005c:	39 d8                	cmp    %ebx,%eax
  10005e:	7d db                	jge    10003b <process_main+0x3b>
	    void * ret = malloc(PAGESIZE);
  100060:	bf 00 10 00 00       	mov    $0x1000,%edi
  100065:	e8 eb 00 00 00       	call   100155 <malloc>
	    if(ret == NULL)
  10006a:	48 85 c0             	test   %rax,%rax
  10006d:	74 04                	je     100073 <process_main+0x73>
		break;
	    *((int*)ret) = p;       // check we have write access
  10006f:	89 18                	mov    %ebx,(%rax)
  100071:	eb c8                	jmp    10003b <process_main+0x3b>
  100073:	cd 32                	int    $0x32
  100075:	eb fc                	jmp    100073 <process_main+0x73>

0000000000100077 <algn>:
block* find_block(size_t size);
block* new_block(size_t size);
block* split_block(block* block, size_t size);


size_t algn(size_t size){
  100077:	f3 0f 1e fa          	endbr64 
    return (size + 7) / 8 * 8;
  10007b:	48 8d 47 07          	lea    0x7(%rdi),%rax
  10007f:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
}
  100083:	c3                   	ret    

0000000000100084 <new_block>:
block* new_block(size_t size){
  100084:	f3 0f 1e fa          	endbr64 
  100088:	48 89 fa             	mov    %rdi,%rdx
    // get program break
    void *bptr = sbrk(size + BLOCKSIZE);
  10008b:	48 8d 7f 18          	lea    0x18(%rdi),%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  10008f:	cd 3a                	int    $0x3a
  100091:	48 89 05 78 1f 00 00 	mov    %rax,0x1f78(%rip)        # 102010 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100098:	48 89 c6             	mov    %rax,%rsi
    if (bptr == (void*) -1) {
  10009b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10009f:	74 3b                	je     1000dc <new_block+0x58>
    return NULL;
    }
    block* nblock = (block*)bptr;
    // add to linked list 

    nblock->next = NULL;
  1000a1:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1000a8:	00 
    nblock->size = size;
  1000a9:	48 89 10             	mov    %rdx,(%rax)
    nblock->free = 0;
  1000ac:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
    // add to linked list 
    if (head == NULL) {
  1000b3:	48 8b 15 5e 1f 00 00 	mov    0x1f5e(%rip),%rdx        # 102018 <head>
  1000ba:	48 85 d2             	test   %rdx,%rdx
  1000bd:	74 14                	je     1000d3 <new_block+0x4f>
        head = nblock;
    } else {
        block *curr = head;
        while (curr->next != NULL) {
  1000bf:	48 89 d1             	mov    %rdx,%rcx
  1000c2:	48 8b 52 08          	mov    0x8(%rdx),%rdx
  1000c6:	48 85 d2             	test   %rdx,%rdx
  1000c9:	75 f4                	jne    1000bf <new_block+0x3b>
            curr = curr->next;
        }
        curr->next = nblock;
  1000cb:	48 89 41 08          	mov    %rax,0x8(%rcx)
    }
    return nblock;
}
  1000cf:	48 89 f0             	mov    %rsi,%rax
  1000d2:	c3                   	ret    
        head = nblock;
  1000d3:	48 89 05 3e 1f 00 00 	mov    %rax,0x1f3e(%rip)        # 102018 <head>
  1000da:	eb f3                	jmp    1000cf <new_block+0x4b>
    return NULL;
  1000dc:	be 00 00 00 00       	mov    $0x0,%esi
  1000e1:	eb ec                	jmp    1000cf <new_block+0x4b>

00000000001000e3 <find_block>:
block* find_block(size_t size) {
  1000e3:	f3 0f 1e fa          	endbr64 
    block* curr = head;
  1000e7:	48 8b 05 2a 1f 00 00 	mov    0x1f2a(%rip),%rax        # 102018 <head>
    while (curr) {
  1000ee:	48 85 c0             	test   %rax,%rax
  1000f1:	75 0b                	jne    1000fe <find_block+0x1b>
  1000f3:	eb 14                	jmp    100109 <find_block+0x26>
        if (curr->free && curr->size >= size) {
            return curr;
        }
        curr = curr->next;
  1000f5:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (curr) {
  1000f9:	48 85 c0             	test   %rax,%rax
  1000fc:	74 0b                	je     100109 <find_block+0x26>
        if (curr->free && curr->size >= size) {
  1000fe:	83 78 10 00          	cmpl   $0x0,0x10(%rax)
  100102:	74 f1                	je     1000f5 <find_block+0x12>
  100104:	48 39 38             	cmp    %rdi,(%rax)
  100107:	72 ec                	jb     1000f5 <find_block+0x12>
    }
    return NULL;
}
  100109:	c3                   	ret    

000000000010010a <split_block>:

block* split_block(block* b, size_t size){
  10010a:	f3 0f 1e fa          	endbr64 
    if(b->size < size + BLOCKSIZE){
  10010e:	48 8b 17             	mov    (%rdi),%rdx
  100111:	48 8d 46 18          	lea    0x18(%rsi),%rax
  100115:	48 39 c2             	cmp    %rax,%rdx
  100118:	72 24                	jb     10013e <split_block+0x34>
        return NULL;
    }
    void* nptr = (void*)b + BLOCKSIZE + size;
  10011a:	48 01 f8             	add    %rdi,%rax
    block *new = (block*)nptr;

    new->size = b->size - size - BLOCKSIZE;
  10011d:	48 29 f2             	sub    %rsi,%rdx
  100120:	48 8d 52 e8          	lea    -0x18(%rdx),%rdx
  100124:	48 89 10             	mov    %rdx,(%rax)
    new->next = b->next;
  100127:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10012b:	48 89 50 08          	mov    %rdx,0x8(%rax)
    new->free = 1; // New block is free
  10012f:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%rax)

    // Update the original block
    b->size = size;
  100136:	48 89 37             	mov    %rsi,(%rdi)
    b->next = new;
  100139:	48 89 47 08          	mov    %rax,0x8(%rdi)

    return new;
  10013d:	c3                   	ret    
        return NULL;
  10013e:	b8 00 00 00 00       	mov    $0x0,%eax

}
  100143:	c3                   	ret    

0000000000100144 <free>:


void free(void *firstbyte) {
  100144:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  100148:	48 85 ff             	test   %rdi,%rdi
  10014b:	74 07                	je     100154 <free+0x10>
    return;
  }
      block *b = (block *)((char *)firstbyte - BLOCKSIZE);

    // Mark the block as free
    b->free = 1;
  10014d:	c7 47 f8 01 00 00 00 	movl   $0x1,-0x8(%rdi)
  

}
  100154:	c3                   	ret    

0000000000100155 <malloc>:

void *malloc(uint64_t numbytes) {
  100155:	f3 0f 1e fa          	endbr64 
  100159:	55                   	push   %rbp
  10015a:	48 89 e5             	mov    %rsp,%rbp
  10015d:	41 54                	push   %r12
  10015f:	53                   	push   %rbx
    return (size + 7) / 8 * 8;
  100160:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  100164:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    size_t size = algn(numbytes);
    block *b = find_block(size);
  100168:	4c 89 e7             	mov    %r12,%rdi
  10016b:	e8 73 ff ff ff       	call   1000e3 <find_block>
    if (b == NULL){
  100170:	48 85 c0             	test   %rax,%rax
  100173:	74 20                	je     100195 <malloc+0x40>
  100175:	48 89 c3             	mov    %rax,%rbx
        if (b==NULL){
            //alloc fail
            return NULL;
        }
    } else {
        b->free = 0;
  100178:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
        // check split
        if (b->size > size + BLOCKSIZE) {
  10017f:	49 8d 44 24 18       	lea    0x18(%r12),%rax
  100184:	48 39 03             	cmp    %rax,(%rbx)
  100187:	77 1e                	ja     1001a7 <malloc+0x52>
            split_block(b, size);
        }
    }
    return (void*)((void*)b + BLOCKSIZE);
  100189:	48 83 c3 18          	add    $0x18,%rbx

}
  10018d:	48 89 d8             	mov    %rbx,%rax
  100190:	5b                   	pop    %rbx
  100191:	41 5c                	pop    %r12
  100193:	5d                   	pop    %rbp
  100194:	c3                   	ret    
        b = new_block(size);
  100195:	4c 89 e7             	mov    %r12,%rdi
  100198:	e8 e7 fe ff ff       	call   100084 <new_block>
  10019d:	48 89 c3             	mov    %rax,%rbx
        if (b==NULL){
  1001a0:	48 85 c0             	test   %rax,%rax
  1001a3:	75 e4                	jne    100189 <malloc+0x34>
  1001a5:	eb e6                	jmp    10018d <malloc+0x38>
            split_block(b, size);
  1001a7:	4c 89 e6             	mov    %r12,%rsi
  1001aa:	48 89 df             	mov    %rbx,%rdi
  1001ad:	e8 58 ff ff ff       	call   10010a <split_block>
  1001b2:	eb d5                	jmp    100189 <malloc+0x34>

00000000001001b4 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  1001b4:	f3 0f 1e fa          	endbr64 
  1001b8:	55                   	push   %rbp
  1001b9:	48 89 e5             	mov    %rsp,%rbp
  1001bc:	41 54                	push   %r12
  1001be:	53                   	push   %rbx
    uint64_t total = num * sz;
  1001bf:	48 0f af fe          	imul   %rsi,%rdi
  1001c3:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  1001c6:	e8 8a ff ff ff       	call   100155 <malloc>
  1001cb:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  1001ce:	48 85 c0             	test   %rax,%rax
  1001d1:	74 10                	je     1001e3 <calloc+0x2f>
        memset(ptr, 0, total);
  1001d3:	4c 89 e2             	mov    %r12,%rdx
  1001d6:	be 00 00 00 00       	mov    $0x0,%esi
  1001db:	48 89 c7             	mov    %rax,%rdi
  1001de:	e8 e6 01 00 00       	call   1003c9 <memset>
    }
    return ptr;
}
  1001e3:	48 89 d8             	mov    %rbx,%rax
  1001e6:	5b                   	pop    %rbx
  1001e7:	41 5c                	pop    %r12
  1001e9:	5d                   	pop    %rbp
  1001ea:	c3                   	ret    

00000000001001eb <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  1001eb:	f3 0f 1e fa          	endbr64 
  1001ef:	55                   	push   %rbp
  1001f0:	48 89 e5             	mov    %rsp,%rbp
  1001f3:	41 54                	push   %r12
  1001f5:	53                   	push   %rbx
  1001f6:	48 89 fb             	mov    %rdi,%rbx
  1001f9:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  1001fc:	48 85 db             	test   %rbx,%rbx
  1001ff:	74 2d                	je     10022e <realloc+0x43>
        return malloc(sz); // Equivalent to malloc if `ptr` is NULL
    }

    if (sz == 0) {
  100201:	48 85 f6             	test   %rsi,%rsi
  100204:	74 32                	je     100238 <realloc+0x4d>
    return (size + 7) / 8 * 8;
  100206:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  10020a:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi

    block *b = (block*)((void*)ptr - BLOCKSIZE); // Get the block metadata
    size_t aligned_size = algn(sz);

    // If the current block is already large enough
    if (b->size >= aligned_size) {
  10020e:	48 8b 43 e8          	mov    -0x18(%rbx),%rax
  100212:	48 39 f0             	cmp    %rsi,%rax
  100215:	72 31                	jb     100248 <realloc+0x5d>
        // Split the block if it has excess space
        if (b->size > aligned_size + BLOCKSIZE) {
  100217:	48 8d 56 18          	lea    0x18(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr; // Return the same pointer if resizing in place
  10021b:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  10021e:	48 39 d0             	cmp    %rdx,%rax
  100221:	76 49                	jbe    10026c <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE); // Get the block metadata
  100223:	48 8d 7b e8          	lea    -0x18(%rbx),%rdi
            split_block(b, aligned_size);
  100227:	e8 de fe ff ff       	call   10010a <split_block>
  10022c:	eb 3e                	jmp    10026c <realloc+0x81>
        return malloc(sz); // Equivalent to malloc if `ptr` is NULL
  10022e:	e8 22 ff ff ff       	call   100155 <malloc>
  100233:	49 89 c4             	mov    %rax,%r12
  100236:	eb 34                	jmp    10026c <realloc+0x81>
        free(ptr); // Equivalent to free if size is 0
  100238:	48 89 df             	mov    %rbx,%rdi
  10023b:	e8 04 ff ff ff       	call   100144 <free>
        return NULL;
  100240:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100246:	eb 24                	jmp    10026c <realloc+0x81>
    }

    // If the current block is too small, allocate a new block
    void *new_ptr = malloc(sz);
  100248:	e8 08 ff ff ff       	call   100155 <malloc>
  10024d:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  100250:	48 85 c0             	test   %rax,%rax
  100253:	74 17                	je     10026c <realloc+0x81>
        return NULL; // Allocation failed
    }

    // Copy data from the old block to the new block
    memcpy(new_ptr, ptr, b->size);
  100255:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  100259:	48 89 de             	mov    %rbx,%rsi
  10025c:	48 89 c7             	mov    %rax,%rdi
  10025f:	e8 5f 00 00 00       	call   1002c3 <memcpy>

    // Free the old block
    free(ptr);
  100264:	48 89 df             	mov    %rbx,%rdi
  100267:	e8 d8 fe ff ff       	call   100144 <free>

    return new_ptr;
}
  10026c:	4c 89 e0             	mov    %r12,%rax
  10026f:	5b                   	pop    %rbx
  100270:	41 5c                	pop    %r12
  100272:	5d                   	pop    %rbp
  100273:	c3                   	ret    

0000000000100274 <defrag>:


void defrag() {
  100274:	f3 0f 1e fa          	endbr64 
    block *b = head;
  100278:	48 8b 15 99 1d 00 00 	mov    0x1d99(%rip),%rdx        # 102018 <head>

    while (b && b->next) {
  10027f:	48 85 d2             	test   %rdx,%rdx
  100282:	75 04                	jne    100288 <defrag+0x14>
  100284:	c3                   	ret    
        if (b->free && b->next->free) {
            // Merge the current block with the next block
            b->size += BLOCKSIZE + b->next->size;
            b->next = b->next->next;  // Skip the next block after merging
  100285:	48 89 c2             	mov    %rax,%rdx
    while (b && b->next) {
  100288:	48 8b 42 08          	mov    0x8(%rdx),%rax
  10028c:	48 85 c0             	test   %rax,%rax
  10028f:	74 27                	je     1002b8 <defrag+0x44>
        if (b->free && b->next->free) {
  100291:	83 7a 10 00          	cmpl   $0x0,0x10(%rdx)
  100295:	74 ee                	je     100285 <defrag+0x11>
  100297:	83 78 10 00          	cmpl   $0x0,0x10(%rax)
  10029b:	74 e8                	je     100285 <defrag+0x11>
            b->size += BLOCKSIZE + b->next->size;
  10029d:	48 8b 32             	mov    (%rdx),%rsi
  1002a0:	48 8b 08             	mov    (%rax),%rcx
  1002a3:	48 8d 4c 0e 18       	lea    0x18(%rsi,%rcx,1),%rcx
  1002a8:	48 89 0a             	mov    %rcx,(%rdx)
            b->next = b->next->next;  // Skip the next block after merging
  1002ab:	48 8b 40 08          	mov    0x8(%rax),%rax
  1002af:	48 89 42 08          	mov    %rax,0x8(%rdx)
  1002b3:	48 89 d0             	mov    %rdx,%rax
  1002b6:	eb cd                	jmp    100285 <defrag+0x11>

        } else {
            b = b->next;  // Advance to the next block if no merge occurred
        }
    }
}
  1002b8:	c3                   	ret    

00000000001002b9 <heap_info>:

int heap_info(heap_info_struct * info) {
  1002b9:	f3 0f 1e fa          	endbr64 
    return 0;
  1002bd:	b8 00 00 00 00       	mov    $0x0,%eax
  1002c2:	c3                   	ret    

00000000001002c3 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1002c3:	f3 0f 1e fa          	endbr64 
  1002c7:	55                   	push   %rbp
  1002c8:	48 89 e5             	mov    %rsp,%rbp
  1002cb:	48 83 ec 28          	sub    $0x28,%rsp
  1002cf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002d3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1002d7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002db:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002e7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1002eb:	eb 1c                	jmp    100309 <memcpy+0x46>
        *d = *s;
  1002ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002f1:	0f b6 10             	movzbl (%rax),%edx
  1002f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002f8:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002fa:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1002ff:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100304:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100309:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10030e:	75 dd                	jne    1002ed <memcpy+0x2a>
    }
    return dst;
  100310:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100314:	c9                   	leave  
  100315:	c3                   	ret    

0000000000100316 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100316:	f3 0f 1e fa          	endbr64 
  10031a:	55                   	push   %rbp
  10031b:	48 89 e5             	mov    %rsp,%rbp
  10031e:	48 83 ec 28          	sub    $0x28,%rsp
  100322:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100326:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10032a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10032e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100332:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100336:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10033a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  10033e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100342:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100346:	73 6a                	jae    1003b2 <memmove+0x9c>
  100348:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10034c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100350:	48 01 d0             	add    %rdx,%rax
  100353:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100357:	73 59                	jae    1003b2 <memmove+0x9c>
        s += n, d += n;
  100359:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10035d:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100361:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100365:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100369:	eb 17                	jmp    100382 <memmove+0x6c>
            *--d = *--s;
  10036b:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100370:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100375:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100379:	0f b6 10             	movzbl (%rax),%edx
  10037c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100380:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100382:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100386:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10038a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10038e:	48 85 c0             	test   %rax,%rax
  100391:	75 d8                	jne    10036b <memmove+0x55>
    if (s < d && s + n > d) {
  100393:	eb 2e                	jmp    1003c3 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100395:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100399:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10039d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003a5:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003a9:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1003ad:	0f b6 12             	movzbl (%rdx),%edx
  1003b0:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003b6:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003ba:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003be:	48 85 c0             	test   %rax,%rax
  1003c1:	75 d2                	jne    100395 <memmove+0x7f>
        }
    }
    return dst;
  1003c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003c7:	c9                   	leave  
  1003c8:	c3                   	ret    

00000000001003c9 <memset>:

void* memset(void* v, int c, size_t n) {
  1003c9:	f3 0f 1e fa          	endbr64 
  1003cd:	55                   	push   %rbp
  1003ce:	48 89 e5             	mov    %rsp,%rbp
  1003d1:	48 83 ec 28          	sub    $0x28,%rsp
  1003d5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003d9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1003dc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003e8:	eb 15                	jmp    1003ff <memset+0x36>
        *p = c;
  1003ea:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1003ed:	89 c2                	mov    %eax,%edx
  1003ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003f3:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003f5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1003fa:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1003ff:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100404:	75 e4                	jne    1003ea <memset+0x21>
    }
    return v;
  100406:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10040a:	c9                   	leave  
  10040b:	c3                   	ret    

000000000010040c <strlen>:

size_t strlen(const char* s) {
  10040c:	f3 0f 1e fa          	endbr64 
  100410:	55                   	push   %rbp
  100411:	48 89 e5             	mov    %rsp,%rbp
  100414:	48 83 ec 18          	sub    $0x18,%rsp
  100418:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10041c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100423:	00 
  100424:	eb 0a                	jmp    100430 <strlen+0x24>
        ++n;
  100426:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10042b:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100430:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100434:	0f b6 00             	movzbl (%rax),%eax
  100437:	84 c0                	test   %al,%al
  100439:	75 eb                	jne    100426 <strlen+0x1a>
    }
    return n;
  10043b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10043f:	c9                   	leave  
  100440:	c3                   	ret    

0000000000100441 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100441:	f3 0f 1e fa          	endbr64 
  100445:	55                   	push   %rbp
  100446:	48 89 e5             	mov    %rsp,%rbp
  100449:	48 83 ec 20          	sub    $0x20,%rsp
  10044d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100451:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100455:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10045c:	00 
  10045d:	eb 0a                	jmp    100469 <strnlen+0x28>
        ++n;
  10045f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100464:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100469:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10046d:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100471:	74 0b                	je     10047e <strnlen+0x3d>
  100473:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100477:	0f b6 00             	movzbl (%rax),%eax
  10047a:	84 c0                	test   %al,%al
  10047c:	75 e1                	jne    10045f <strnlen+0x1e>
    }
    return n;
  10047e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100482:	c9                   	leave  
  100483:	c3                   	ret    

0000000000100484 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100484:	f3 0f 1e fa          	endbr64 
  100488:	55                   	push   %rbp
  100489:	48 89 e5             	mov    %rsp,%rbp
  10048c:	48 83 ec 20          	sub    $0x20,%rsp
  100490:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100494:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100498:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10049c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1004a0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1004a4:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004a8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1004ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004b0:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004b4:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1004b8:	0f b6 12             	movzbl (%rdx),%edx
  1004bb:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1004bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004c1:	48 83 e8 01          	sub    $0x1,%rax
  1004c5:	0f b6 00             	movzbl (%rax),%eax
  1004c8:	84 c0                	test   %al,%al
  1004ca:	75 d4                	jne    1004a0 <strcpy+0x1c>
    return dst;
  1004cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1004d0:	c9                   	leave  
  1004d1:	c3                   	ret    

00000000001004d2 <strcmp>:

int strcmp(const char* a, const char* b) {
  1004d2:	f3 0f 1e fa          	endbr64 
  1004d6:	55                   	push   %rbp
  1004d7:	48 89 e5             	mov    %rsp,%rbp
  1004da:	48 83 ec 10          	sub    $0x10,%rsp
  1004de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004e2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004e6:	eb 0a                	jmp    1004f2 <strcmp+0x20>
        ++a, ++b;
  1004e8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1004ed:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004f6:	0f b6 00             	movzbl (%rax),%eax
  1004f9:	84 c0                	test   %al,%al
  1004fb:	74 1d                	je     10051a <strcmp+0x48>
  1004fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100501:	0f b6 00             	movzbl (%rax),%eax
  100504:	84 c0                	test   %al,%al
  100506:	74 12                	je     10051a <strcmp+0x48>
  100508:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10050c:	0f b6 10             	movzbl (%rax),%edx
  10050f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100513:	0f b6 00             	movzbl (%rax),%eax
  100516:	38 c2                	cmp    %al,%dl
  100518:	74 ce                	je     1004e8 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  10051a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10051e:	0f b6 00             	movzbl (%rax),%eax
  100521:	89 c2                	mov    %eax,%edx
  100523:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100527:	0f b6 00             	movzbl (%rax),%eax
  10052a:	38 c2                	cmp    %al,%dl
  10052c:	0f 97 c0             	seta   %al
  10052f:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100532:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100536:	0f b6 00             	movzbl (%rax),%eax
  100539:	89 c1                	mov    %eax,%ecx
  10053b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10053f:	0f b6 00             	movzbl (%rax),%eax
  100542:	38 c1                	cmp    %al,%cl
  100544:	0f 92 c0             	setb   %al
  100547:	0f b6 c8             	movzbl %al,%ecx
  10054a:	89 d0                	mov    %edx,%eax
  10054c:	29 c8                	sub    %ecx,%eax
}
  10054e:	c9                   	leave  
  10054f:	c3                   	ret    

0000000000100550 <strchr>:

char* strchr(const char* s, int c) {
  100550:	f3 0f 1e fa          	endbr64 
  100554:	55                   	push   %rbp
  100555:	48 89 e5             	mov    %rsp,%rbp
  100558:	48 83 ec 10          	sub    $0x10,%rsp
  10055c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100560:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100563:	eb 05                	jmp    10056a <strchr+0x1a>
        ++s;
  100565:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  10056a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10056e:	0f b6 00             	movzbl (%rax),%eax
  100571:	84 c0                	test   %al,%al
  100573:	74 0e                	je     100583 <strchr+0x33>
  100575:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100579:	0f b6 00             	movzbl (%rax),%eax
  10057c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10057f:	38 d0                	cmp    %dl,%al
  100581:	75 e2                	jne    100565 <strchr+0x15>
    }
    if (*s == (char) c) {
  100583:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100587:	0f b6 00             	movzbl (%rax),%eax
  10058a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10058d:	38 d0                	cmp    %dl,%al
  10058f:	75 06                	jne    100597 <strchr+0x47>
        return (char*) s;
  100591:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100595:	eb 05                	jmp    10059c <strchr+0x4c>
    } else {
        return NULL;
  100597:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  10059c:	c9                   	leave  
  10059d:	c3                   	ret    

000000000010059e <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  10059e:	f3 0f 1e fa          	endbr64 
  1005a2:	55                   	push   %rbp
  1005a3:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1005a6:	8b 05 74 1a 00 00    	mov    0x1a74(%rip),%eax        # 102020 <rand_seed_set>
  1005ac:	85 c0                	test   %eax,%eax
  1005ae:	75 0a                	jne    1005ba <rand+0x1c>
        srand(819234718U);
  1005b0:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1005b5:	e8 24 00 00 00       	call   1005de <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1005ba:	8b 05 64 1a 00 00    	mov    0x1a64(%rip),%eax        # 102024 <rand_seed>
  1005c0:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1005c6:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1005cb:	89 05 53 1a 00 00    	mov    %eax,0x1a53(%rip)        # 102024 <rand_seed>
    return rand_seed & RAND_MAX;
  1005d1:	8b 05 4d 1a 00 00    	mov    0x1a4d(%rip),%eax        # 102024 <rand_seed>
  1005d7:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1005dc:	5d                   	pop    %rbp
  1005dd:	c3                   	ret    

00000000001005de <srand>:

void srand(unsigned seed) {
  1005de:	f3 0f 1e fa          	endbr64 
  1005e2:	55                   	push   %rbp
  1005e3:	48 89 e5             	mov    %rsp,%rbp
  1005e6:	48 83 ec 08          	sub    $0x8,%rsp
  1005ea:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1005ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1005f0:	89 05 2e 1a 00 00    	mov    %eax,0x1a2e(%rip)        # 102024 <rand_seed>
    rand_seed_set = 1;
  1005f6:	c7 05 20 1a 00 00 01 	movl   $0x1,0x1a20(%rip)        # 102020 <rand_seed_set>
  1005fd:	00 00 00 
}
  100600:	90                   	nop
  100601:	c9                   	leave  
  100602:	c3                   	ret    

0000000000100603 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100603:	f3 0f 1e fa          	endbr64 
  100607:	55                   	push   %rbp
  100608:	48 89 e5             	mov    %rsp,%rbp
  10060b:	48 83 ec 28          	sub    $0x28,%rsp
  10060f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100613:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100617:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  10061a:	48 8d 05 af 0e 00 00 	lea    0xeaf(%rip),%rax        # 1014d0 <upper_digits.1>
  100621:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  100625:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100629:	79 0e                	jns    100639 <fill_numbuf+0x36>
        digits = lower_digits;
  10062b:	48 8d 05 be 0e 00 00 	lea    0xebe(%rip),%rax        # 1014f0 <lower_digits.0>
  100632:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  100636:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100639:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10063e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100642:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100645:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100648:	48 63 c8             	movslq %eax,%rcx
  10064b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10064f:	ba 00 00 00 00       	mov    $0x0,%edx
  100654:	48 f7 f1             	div    %rcx
  100657:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10065b:	48 01 d0             	add    %rdx,%rax
  10065e:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100663:	0f b6 10             	movzbl (%rax),%edx
  100666:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10066a:	88 10                	mov    %dl,(%rax)
        val /= base;
  10066c:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10066f:	48 63 f0             	movslq %eax,%rsi
  100672:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100676:	ba 00 00 00 00       	mov    $0x0,%edx
  10067b:	48 f7 f6             	div    %rsi
  10067e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100682:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100687:	75 bc                	jne    100645 <fill_numbuf+0x42>
    return numbuf_end;
  100689:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10068d:	c9                   	leave  
  10068e:	c3                   	ret    

000000000010068f <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10068f:	f3 0f 1e fa          	endbr64 
  100693:	55                   	push   %rbp
  100694:	48 89 e5             	mov    %rsp,%rbp
  100697:	53                   	push   %rbx
  100698:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  10069f:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1006a6:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1006ac:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1006b3:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1006ba:	e9 bd 09 00 00       	jmp    10107c <printer_vprintf+0x9ed>
        if (*format != '%') {
  1006bf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006c6:	0f b6 00             	movzbl (%rax),%eax
  1006c9:	3c 25                	cmp    $0x25,%al
  1006cb:	74 31                	je     1006fe <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  1006cd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006d4:	4c 8b 00             	mov    (%rax),%r8
  1006d7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006de:	0f b6 00             	movzbl (%rax),%eax
  1006e1:	0f b6 c8             	movzbl %al,%ecx
  1006e4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1006ea:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006f1:	89 ce                	mov    %ecx,%esi
  1006f3:	48 89 c7             	mov    %rax,%rdi
  1006f6:	41 ff d0             	call   *%r8
            continue;
  1006f9:	e9 76 09 00 00       	jmp    101074 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  1006fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100705:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10070c:	01 
  10070d:	eb 4d                	jmp    10075c <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  10070f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100716:	0f b6 00             	movzbl (%rax),%eax
  100719:	0f be c0             	movsbl %al,%eax
  10071c:	89 c6                	mov    %eax,%esi
  10071e:	48 8d 05 ab 0c 00 00 	lea    0xcab(%rip),%rax        # 1013d0 <flag_chars>
  100725:	48 89 c7             	mov    %rax,%rdi
  100728:	e8 23 fe ff ff       	call   100550 <strchr>
  10072d:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100731:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100736:	74 34                	je     10076c <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  100738:	48 8d 15 91 0c 00 00 	lea    0xc91(%rip),%rdx        # 1013d0 <flag_chars>
  10073f:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100743:	48 29 d0             	sub    %rdx,%rax
  100746:	ba 01 00 00 00       	mov    $0x1,%edx
  10074b:	89 c1                	mov    %eax,%ecx
  10074d:	d3 e2                	shl    %cl,%edx
  10074f:	89 d0                	mov    %edx,%eax
  100751:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100754:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10075b:	01 
  10075c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100763:	0f b6 00             	movzbl (%rax),%eax
  100766:	84 c0                	test   %al,%al
  100768:	75 a5                	jne    10070f <printer_vprintf+0x80>
  10076a:	eb 01                	jmp    10076d <printer_vprintf+0xde>
            } else {
                break;
  10076c:	90                   	nop
            }
        }

        // process width
        int width = -1;
  10076d:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100774:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10077b:	0f b6 00             	movzbl (%rax),%eax
  10077e:	3c 30                	cmp    $0x30,%al
  100780:	7e 67                	jle    1007e9 <printer_vprintf+0x15a>
  100782:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100789:	0f b6 00             	movzbl (%rax),%eax
  10078c:	3c 39                	cmp    $0x39,%al
  10078e:	7f 59                	jg     1007e9 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100790:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100797:	eb 2e                	jmp    1007c7 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  100799:	8b 55 e8             	mov    -0x18(%rbp),%edx
  10079c:	89 d0                	mov    %edx,%eax
  10079e:	c1 e0 02             	shl    $0x2,%eax
  1007a1:	01 d0                	add    %edx,%eax
  1007a3:	01 c0                	add    %eax,%eax
  1007a5:	89 c1                	mov    %eax,%ecx
  1007a7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007ae:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1007b2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007b9:	0f b6 00             	movzbl (%rax),%eax
  1007bc:	0f be c0             	movsbl %al,%eax
  1007bf:	01 c8                	add    %ecx,%eax
  1007c1:	83 e8 30             	sub    $0x30,%eax
  1007c4:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1007c7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007ce:	0f b6 00             	movzbl (%rax),%eax
  1007d1:	3c 2f                	cmp    $0x2f,%al
  1007d3:	0f 8e 85 00 00 00    	jle    10085e <printer_vprintf+0x1cf>
  1007d9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007e0:	0f b6 00             	movzbl (%rax),%eax
  1007e3:	3c 39                	cmp    $0x39,%al
  1007e5:	7e b2                	jle    100799 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  1007e7:	eb 75                	jmp    10085e <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  1007e9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007f0:	0f b6 00             	movzbl (%rax),%eax
  1007f3:	3c 2a                	cmp    $0x2a,%al
  1007f5:	75 68                	jne    10085f <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  1007f7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007fe:	8b 00                	mov    (%rax),%eax
  100800:	83 f8 2f             	cmp    $0x2f,%eax
  100803:	77 30                	ja     100835 <printer_vprintf+0x1a6>
  100805:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10080c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100810:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100817:	8b 00                	mov    (%rax),%eax
  100819:	89 c0                	mov    %eax,%eax
  10081b:	48 01 d0             	add    %rdx,%rax
  10081e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100825:	8b 12                	mov    (%rdx),%edx
  100827:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10082a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100831:	89 0a                	mov    %ecx,(%rdx)
  100833:	eb 1a                	jmp    10084f <printer_vprintf+0x1c0>
  100835:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10083c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100840:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100844:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10084b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10084f:	8b 00                	mov    (%rax),%eax
  100851:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100854:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10085b:	01 
  10085c:	eb 01                	jmp    10085f <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  10085e:	90                   	nop
        }

        // process precision
        int precision = -1;
  10085f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100866:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10086d:	0f b6 00             	movzbl (%rax),%eax
  100870:	3c 2e                	cmp    $0x2e,%al
  100872:	0f 85 00 01 00 00    	jne    100978 <printer_vprintf+0x2e9>
            ++format;
  100878:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10087f:	01 
            if (*format >= '0' && *format <= '9') {
  100880:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100887:	0f b6 00             	movzbl (%rax),%eax
  10088a:	3c 2f                	cmp    $0x2f,%al
  10088c:	7e 67                	jle    1008f5 <printer_vprintf+0x266>
  10088e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100895:	0f b6 00             	movzbl (%rax),%eax
  100898:	3c 39                	cmp    $0x39,%al
  10089a:	7f 59                	jg     1008f5 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10089c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1008a3:	eb 2e                	jmp    1008d3 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  1008a5:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1008a8:	89 d0                	mov    %edx,%eax
  1008aa:	c1 e0 02             	shl    $0x2,%eax
  1008ad:	01 d0                	add    %edx,%eax
  1008af:	01 c0                	add    %eax,%eax
  1008b1:	89 c1                	mov    %eax,%ecx
  1008b3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008ba:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1008be:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008c5:	0f b6 00             	movzbl (%rax),%eax
  1008c8:	0f be c0             	movsbl %al,%eax
  1008cb:	01 c8                	add    %ecx,%eax
  1008cd:	83 e8 30             	sub    $0x30,%eax
  1008d0:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008d3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008da:	0f b6 00             	movzbl (%rax),%eax
  1008dd:	3c 2f                	cmp    $0x2f,%al
  1008df:	0f 8e 85 00 00 00    	jle    10096a <printer_vprintf+0x2db>
  1008e5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008ec:	0f b6 00             	movzbl (%rax),%eax
  1008ef:	3c 39                	cmp    $0x39,%al
  1008f1:	7e b2                	jle    1008a5 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  1008f3:	eb 75                	jmp    10096a <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  1008f5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008fc:	0f b6 00             	movzbl (%rax),%eax
  1008ff:	3c 2a                	cmp    $0x2a,%al
  100901:	75 68                	jne    10096b <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  100903:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10090a:	8b 00                	mov    (%rax),%eax
  10090c:	83 f8 2f             	cmp    $0x2f,%eax
  10090f:	77 30                	ja     100941 <printer_vprintf+0x2b2>
  100911:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100918:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10091c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100923:	8b 00                	mov    (%rax),%eax
  100925:	89 c0                	mov    %eax,%eax
  100927:	48 01 d0             	add    %rdx,%rax
  10092a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100931:	8b 12                	mov    (%rdx),%edx
  100933:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100936:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10093d:	89 0a                	mov    %ecx,(%rdx)
  10093f:	eb 1a                	jmp    10095b <printer_vprintf+0x2cc>
  100941:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100948:	48 8b 40 08          	mov    0x8(%rax),%rax
  10094c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100950:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100957:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10095b:	8b 00                	mov    (%rax),%eax
  10095d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100960:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100967:	01 
  100968:	eb 01                	jmp    10096b <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  10096a:	90                   	nop
            }
            if (precision < 0) {
  10096b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10096f:	79 07                	jns    100978 <printer_vprintf+0x2e9>
                precision = 0;
  100971:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100978:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  10097f:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100986:	00 
        int length = 0;
  100987:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  10098e:	48 8d 05 41 0a 00 00 	lea    0xa41(%rip),%rax        # 1013d6 <flag_chars+0x6>
  100995:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  100999:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009a0:	0f b6 00             	movzbl (%rax),%eax
  1009a3:	0f be c0             	movsbl %al,%eax
  1009a6:	83 e8 43             	sub    $0x43,%eax
  1009a9:	83 f8 37             	cmp    $0x37,%eax
  1009ac:	0f 87 b6 03 00 00    	ja     100d68 <printer_vprintf+0x6d9>
  1009b2:	89 c0                	mov    %eax,%eax
  1009b4:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  1009bb:	00 
  1009bc:	48 8d 05 21 0a 00 00 	lea    0xa21(%rip),%rax        # 1013e4 <flag_chars+0x14>
  1009c3:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  1009c6:	48 98                	cltq   
  1009c8:	48 8d 15 15 0a 00 00 	lea    0xa15(%rip),%rdx        # 1013e4 <flag_chars+0x14>
  1009cf:	48 01 d0             	add    %rdx,%rax
  1009d2:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  1009d5:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1009dc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009e3:	01 
            goto again;
  1009e4:	eb b3                	jmp    100999 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1009e6:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1009ea:	74 5d                	je     100a49 <printer_vprintf+0x3ba>
  1009ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f3:	8b 00                	mov    (%rax),%eax
  1009f5:	83 f8 2f             	cmp    $0x2f,%eax
  1009f8:	77 30                	ja     100a2a <printer_vprintf+0x39b>
  1009fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a01:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a05:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a0c:	8b 00                	mov    (%rax),%eax
  100a0e:	89 c0                	mov    %eax,%eax
  100a10:	48 01 d0             	add    %rdx,%rax
  100a13:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a1a:	8b 12                	mov    (%rdx),%edx
  100a1c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a1f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a26:	89 0a                	mov    %ecx,(%rdx)
  100a28:	eb 1a                	jmp    100a44 <printer_vprintf+0x3b5>
  100a2a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a31:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a35:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a39:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a40:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a44:	48 8b 00             	mov    (%rax),%rax
  100a47:	eb 5c                	jmp    100aa5 <printer_vprintf+0x416>
  100a49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a50:	8b 00                	mov    (%rax),%eax
  100a52:	83 f8 2f             	cmp    $0x2f,%eax
  100a55:	77 30                	ja     100a87 <printer_vprintf+0x3f8>
  100a57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a5e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a62:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a69:	8b 00                	mov    (%rax),%eax
  100a6b:	89 c0                	mov    %eax,%eax
  100a6d:	48 01 d0             	add    %rdx,%rax
  100a70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a77:	8b 12                	mov    (%rdx),%edx
  100a79:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a7c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a83:	89 0a                	mov    %ecx,(%rdx)
  100a85:	eb 1a                	jmp    100aa1 <printer_vprintf+0x412>
  100a87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a8e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a92:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a96:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a9d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aa1:	8b 00                	mov    (%rax),%eax
  100aa3:	48 98                	cltq   
  100aa5:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100aa9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100aad:	48 c1 f8 38          	sar    $0x38,%rax
  100ab1:	25 80 00 00 00       	and    $0x80,%eax
  100ab6:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100ab9:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100abd:	74 09                	je     100ac8 <printer_vprintf+0x439>
  100abf:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ac3:	48 f7 d8             	neg    %rax
  100ac6:	eb 04                	jmp    100acc <printer_vprintf+0x43d>
  100ac8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100acc:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100ad0:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100ad3:	83 c8 60             	or     $0x60,%eax
  100ad6:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100ad9:	e9 cf 02 00 00       	jmp    100dad <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100ade:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100ae2:	74 5d                	je     100b41 <printer_vprintf+0x4b2>
  100ae4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aeb:	8b 00                	mov    (%rax),%eax
  100aed:	83 f8 2f             	cmp    $0x2f,%eax
  100af0:	77 30                	ja     100b22 <printer_vprintf+0x493>
  100af2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100afd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b04:	8b 00                	mov    (%rax),%eax
  100b06:	89 c0                	mov    %eax,%eax
  100b08:	48 01 d0             	add    %rdx,%rax
  100b0b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b12:	8b 12                	mov    (%rdx),%edx
  100b14:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b17:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b1e:	89 0a                	mov    %ecx,(%rdx)
  100b20:	eb 1a                	jmp    100b3c <printer_vprintf+0x4ad>
  100b22:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b29:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b2d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b31:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b38:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b3c:	48 8b 00             	mov    (%rax),%rax
  100b3f:	eb 5c                	jmp    100b9d <printer_vprintf+0x50e>
  100b41:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b48:	8b 00                	mov    (%rax),%eax
  100b4a:	83 f8 2f             	cmp    $0x2f,%eax
  100b4d:	77 30                	ja     100b7f <printer_vprintf+0x4f0>
  100b4f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b56:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b5a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b61:	8b 00                	mov    (%rax),%eax
  100b63:	89 c0                	mov    %eax,%eax
  100b65:	48 01 d0             	add    %rdx,%rax
  100b68:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b6f:	8b 12                	mov    (%rdx),%edx
  100b71:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b74:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b7b:	89 0a                	mov    %ecx,(%rdx)
  100b7d:	eb 1a                	jmp    100b99 <printer_vprintf+0x50a>
  100b7f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b86:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b8a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b8e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b95:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b99:	8b 00                	mov    (%rax),%eax
  100b9b:	89 c0                	mov    %eax,%eax
  100b9d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100ba1:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100ba5:	e9 03 02 00 00       	jmp    100dad <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100baa:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100bb1:	e9 28 ff ff ff       	jmp    100ade <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100bb6:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100bbd:	e9 1c ff ff ff       	jmp    100ade <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100bc2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bc9:	8b 00                	mov    (%rax),%eax
  100bcb:	83 f8 2f             	cmp    $0x2f,%eax
  100bce:	77 30                	ja     100c00 <printer_vprintf+0x571>
  100bd0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bd7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bdb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100be2:	8b 00                	mov    (%rax),%eax
  100be4:	89 c0                	mov    %eax,%eax
  100be6:	48 01 d0             	add    %rdx,%rax
  100be9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bf0:	8b 12                	mov    (%rdx),%edx
  100bf2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bf5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bfc:	89 0a                	mov    %ecx,(%rdx)
  100bfe:	eb 1a                	jmp    100c1a <printer_vprintf+0x58b>
  100c00:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c07:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c0b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c0f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c16:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c1a:	48 8b 00             	mov    (%rax),%rax
  100c1d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100c21:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100c28:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100c2f:	e9 79 01 00 00       	jmp    100dad <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100c34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c3b:	8b 00                	mov    (%rax),%eax
  100c3d:	83 f8 2f             	cmp    $0x2f,%eax
  100c40:	77 30                	ja     100c72 <printer_vprintf+0x5e3>
  100c42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c49:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c54:	8b 00                	mov    (%rax),%eax
  100c56:	89 c0                	mov    %eax,%eax
  100c58:	48 01 d0             	add    %rdx,%rax
  100c5b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c62:	8b 12                	mov    (%rdx),%edx
  100c64:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c67:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c6e:	89 0a                	mov    %ecx,(%rdx)
  100c70:	eb 1a                	jmp    100c8c <printer_vprintf+0x5fd>
  100c72:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c79:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c7d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c88:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c8c:	48 8b 00             	mov    (%rax),%rax
  100c8f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100c93:	e9 15 01 00 00       	jmp    100dad <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100c98:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c9f:	8b 00                	mov    (%rax),%eax
  100ca1:	83 f8 2f             	cmp    $0x2f,%eax
  100ca4:	77 30                	ja     100cd6 <printer_vprintf+0x647>
  100ca6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cad:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cb1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cb8:	8b 00                	mov    (%rax),%eax
  100cba:	89 c0                	mov    %eax,%eax
  100cbc:	48 01 d0             	add    %rdx,%rax
  100cbf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cc6:	8b 12                	mov    (%rdx),%edx
  100cc8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ccb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cd2:	89 0a                	mov    %ecx,(%rdx)
  100cd4:	eb 1a                	jmp    100cf0 <printer_vprintf+0x661>
  100cd6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cdd:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ce1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ce5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cec:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cf0:	8b 00                	mov    (%rax),%eax
  100cf2:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100cf8:	e9 77 03 00 00       	jmp    101074 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100cfd:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d01:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100d05:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d0c:	8b 00                	mov    (%rax),%eax
  100d0e:	83 f8 2f             	cmp    $0x2f,%eax
  100d11:	77 30                	ja     100d43 <printer_vprintf+0x6b4>
  100d13:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d1a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d1e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d25:	8b 00                	mov    (%rax),%eax
  100d27:	89 c0                	mov    %eax,%eax
  100d29:	48 01 d0             	add    %rdx,%rax
  100d2c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d33:	8b 12                	mov    (%rdx),%edx
  100d35:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d38:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d3f:	89 0a                	mov    %ecx,(%rdx)
  100d41:	eb 1a                	jmp    100d5d <printer_vprintf+0x6ce>
  100d43:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d4a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d4e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d52:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d59:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d5d:	8b 00                	mov    (%rax),%eax
  100d5f:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d62:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100d66:	eb 45                	jmp    100dad <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100d68:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d6c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100d70:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d77:	0f b6 00             	movzbl (%rax),%eax
  100d7a:	84 c0                	test   %al,%al
  100d7c:	74 0c                	je     100d8a <printer_vprintf+0x6fb>
  100d7e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d85:	0f b6 00             	movzbl (%rax),%eax
  100d88:	eb 05                	jmp    100d8f <printer_vprintf+0x700>
  100d8a:	b8 25 00 00 00       	mov    $0x25,%eax
  100d8f:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d92:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100d96:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d9d:	0f b6 00             	movzbl (%rax),%eax
  100da0:	84 c0                	test   %al,%al
  100da2:	75 08                	jne    100dac <printer_vprintf+0x71d>
                format--;
  100da4:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100dab:	01 
            }
            break;
  100dac:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100dad:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100db0:	83 e0 20             	and    $0x20,%eax
  100db3:	85 c0                	test   %eax,%eax
  100db5:	74 1e                	je     100dd5 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100db7:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100dbb:	48 83 c0 18          	add    $0x18,%rax
  100dbf:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100dc2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100dc6:	48 89 ce             	mov    %rcx,%rsi
  100dc9:	48 89 c7             	mov    %rax,%rdi
  100dcc:	e8 32 f8 ff ff       	call   100603 <fill_numbuf>
  100dd1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100dd5:	48 8d 05 fa 05 00 00 	lea    0x5fa(%rip),%rax        # 1013d6 <flag_chars+0x6>
  100ddc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100de0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100de3:	83 e0 20             	and    $0x20,%eax
  100de6:	85 c0                	test   %eax,%eax
  100de8:	74 51                	je     100e3b <printer_vprintf+0x7ac>
  100dea:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ded:	83 e0 40             	and    $0x40,%eax
  100df0:	85 c0                	test   %eax,%eax
  100df2:	74 47                	je     100e3b <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100df4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100df7:	25 80 00 00 00       	and    $0x80,%eax
  100dfc:	85 c0                	test   %eax,%eax
  100dfe:	74 0d                	je     100e0d <printer_vprintf+0x77e>
                prefix = "-";
  100e00:	48 8d 05 d0 05 00 00 	lea    0x5d0(%rip),%rax        # 1013d7 <flag_chars+0x7>
  100e07:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e0b:	eb 7d                	jmp    100e8a <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100e0d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e10:	83 e0 10             	and    $0x10,%eax
  100e13:	85 c0                	test   %eax,%eax
  100e15:	74 0d                	je     100e24 <printer_vprintf+0x795>
                prefix = "+";
  100e17:	48 8d 05 bb 05 00 00 	lea    0x5bb(%rip),%rax        # 1013d9 <flag_chars+0x9>
  100e1e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e22:	eb 66                	jmp    100e8a <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100e24:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e27:	83 e0 08             	and    $0x8,%eax
  100e2a:	85 c0                	test   %eax,%eax
  100e2c:	74 5c                	je     100e8a <printer_vprintf+0x7fb>
                prefix = " ";
  100e2e:	48 8d 05 a6 05 00 00 	lea    0x5a6(%rip),%rax        # 1013db <flag_chars+0xb>
  100e35:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e39:	eb 4f                	jmp    100e8a <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100e3b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e3e:	83 e0 20             	and    $0x20,%eax
  100e41:	85 c0                	test   %eax,%eax
  100e43:	74 46                	je     100e8b <printer_vprintf+0x7fc>
  100e45:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e48:	83 e0 01             	and    $0x1,%eax
  100e4b:	85 c0                	test   %eax,%eax
  100e4d:	74 3c                	je     100e8b <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100e4f:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100e53:	74 06                	je     100e5b <printer_vprintf+0x7cc>
  100e55:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e59:	75 30                	jne    100e8b <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100e5b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100e60:	75 0c                	jne    100e6e <printer_vprintf+0x7df>
  100e62:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e65:	25 00 01 00 00       	and    $0x100,%eax
  100e6a:	85 c0                	test   %eax,%eax
  100e6c:	74 1d                	je     100e8b <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100e6e:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e72:	75 09                	jne    100e7d <printer_vprintf+0x7ee>
  100e74:	48 8d 05 62 05 00 00 	lea    0x562(%rip),%rax        # 1013dd <flag_chars+0xd>
  100e7b:	eb 07                	jmp    100e84 <printer_vprintf+0x7f5>
  100e7d:	48 8d 05 5c 05 00 00 	lea    0x55c(%rip),%rax        # 1013e0 <flag_chars+0x10>
  100e84:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100e88:	eb 01                	jmp    100e8b <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100e8a:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100e8b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e8f:	78 24                	js     100eb5 <printer_vprintf+0x826>
  100e91:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e94:	83 e0 20             	and    $0x20,%eax
  100e97:	85 c0                	test   %eax,%eax
  100e99:	75 1a                	jne    100eb5 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100e9b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e9e:	48 63 d0             	movslq %eax,%rdx
  100ea1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ea5:	48 89 d6             	mov    %rdx,%rsi
  100ea8:	48 89 c7             	mov    %rax,%rdi
  100eab:	e8 91 f5 ff ff       	call   100441 <strnlen>
  100eb0:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100eb3:	eb 0f                	jmp    100ec4 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100eb5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100eb9:	48 89 c7             	mov    %rax,%rdi
  100ebc:	e8 4b f5 ff ff       	call   10040c <strlen>
  100ec1:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100ec4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ec7:	83 e0 20             	and    $0x20,%eax
  100eca:	85 c0                	test   %eax,%eax
  100ecc:	74 20                	je     100eee <printer_vprintf+0x85f>
  100ece:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ed2:	78 1a                	js     100eee <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100ed4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100ed7:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100eda:	7e 08                	jle    100ee4 <printer_vprintf+0x855>
  100edc:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100edf:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100ee2:	eb 05                	jmp    100ee9 <printer_vprintf+0x85a>
  100ee4:	b8 00 00 00 00       	mov    $0x0,%eax
  100ee9:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100eec:	eb 5c                	jmp    100f4a <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100eee:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ef1:	83 e0 20             	and    $0x20,%eax
  100ef4:	85 c0                	test   %eax,%eax
  100ef6:	74 4b                	je     100f43 <printer_vprintf+0x8b4>
  100ef8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100efb:	83 e0 02             	and    $0x2,%eax
  100efe:	85 c0                	test   %eax,%eax
  100f00:	74 41                	je     100f43 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100f02:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f05:	83 e0 04             	and    $0x4,%eax
  100f08:	85 c0                	test   %eax,%eax
  100f0a:	75 37                	jne    100f43 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100f0c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f10:	48 89 c7             	mov    %rax,%rdi
  100f13:	e8 f4 f4 ff ff       	call   10040c <strlen>
  100f18:	89 c2                	mov    %eax,%edx
  100f1a:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100f1d:	01 d0                	add    %edx,%eax
  100f1f:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100f22:	7e 1f                	jle    100f43 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100f24:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f27:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100f2a:	89 c3                	mov    %eax,%ebx
  100f2c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f30:	48 89 c7             	mov    %rax,%rdi
  100f33:	e8 d4 f4 ff ff       	call   10040c <strlen>
  100f38:	89 c2                	mov    %eax,%edx
  100f3a:	89 d8                	mov    %ebx,%eax
  100f3c:	29 d0                	sub    %edx,%eax
  100f3e:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f41:	eb 07                	jmp    100f4a <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100f43:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100f4a:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100f4d:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100f50:	01 d0                	add    %edx,%eax
  100f52:	48 63 d8             	movslq %eax,%rbx
  100f55:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f59:	48 89 c7             	mov    %rax,%rdi
  100f5c:	e8 ab f4 ff ff       	call   10040c <strlen>
  100f61:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100f65:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f68:	29 d0                	sub    %edx,%eax
  100f6a:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f6d:	eb 25                	jmp    100f94 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  100f6f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f76:	48 8b 08             	mov    (%rax),%rcx
  100f79:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f7f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f86:	be 20 00 00 00       	mov    $0x20,%esi
  100f8b:	48 89 c7             	mov    %rax,%rdi
  100f8e:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f90:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100f94:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f97:	83 e0 04             	and    $0x4,%eax
  100f9a:	85 c0                	test   %eax,%eax
  100f9c:	75 36                	jne    100fd4 <printer_vprintf+0x945>
  100f9e:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100fa2:	7f cb                	jg     100f6f <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  100fa4:	eb 2e                	jmp    100fd4 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  100fa6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fad:	4c 8b 00             	mov    (%rax),%r8
  100fb0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fb4:	0f b6 00             	movzbl (%rax),%eax
  100fb7:	0f b6 c8             	movzbl %al,%ecx
  100fba:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fc0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fc7:	89 ce                	mov    %ecx,%esi
  100fc9:	48 89 c7             	mov    %rax,%rdi
  100fcc:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100fcf:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100fd4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fd8:	0f b6 00             	movzbl (%rax),%eax
  100fdb:	84 c0                	test   %al,%al
  100fdd:	75 c7                	jne    100fa6 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  100fdf:	eb 25                	jmp    101006 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  100fe1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fe8:	48 8b 08             	mov    (%rax),%rcx
  100feb:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ff1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ff8:	be 30 00 00 00       	mov    $0x30,%esi
  100ffd:	48 89 c7             	mov    %rax,%rdi
  101000:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101002:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101006:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  10100a:	7f d5                	jg     100fe1 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  10100c:	eb 32                	jmp    101040 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  10100e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101015:	4c 8b 00             	mov    (%rax),%r8
  101018:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10101c:	0f b6 00             	movzbl (%rax),%eax
  10101f:	0f b6 c8             	movzbl %al,%ecx
  101022:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101028:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10102f:	89 ce                	mov    %ecx,%esi
  101031:	48 89 c7             	mov    %rax,%rdi
  101034:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101037:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  10103c:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101040:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101044:	7f c8                	jg     10100e <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  101046:	eb 25                	jmp    10106d <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  101048:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10104f:	48 8b 08             	mov    (%rax),%rcx
  101052:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101058:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10105f:	be 20 00 00 00       	mov    $0x20,%esi
  101064:	48 89 c7             	mov    %rax,%rdi
  101067:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101069:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10106d:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101071:	7f d5                	jg     101048 <printer_vprintf+0x9b9>
        }
    done: ;
  101073:	90                   	nop
    for (; *format; ++format) {
  101074:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10107b:	01 
  10107c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101083:	0f b6 00             	movzbl (%rax),%eax
  101086:	84 c0                	test   %al,%al
  101088:	0f 85 31 f6 ff ff    	jne    1006bf <printer_vprintf+0x30>
    }
}
  10108e:	90                   	nop
  10108f:	90                   	nop
  101090:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101094:	c9                   	leave  
  101095:	c3                   	ret    

0000000000101096 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101096:	f3 0f 1e fa          	endbr64 
  10109a:	55                   	push   %rbp
  10109b:	48 89 e5             	mov    %rsp,%rbp
  10109e:	48 83 ec 20          	sub    $0x20,%rsp
  1010a2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1010a6:	89 f0                	mov    %esi,%eax
  1010a8:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1010ab:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1010ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1010b2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1010b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010ba:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010be:	48 8d 15 db 7e fb ff 	lea    -0x48125(%rip),%rdx        # b8fa0 <console+0xfa0>
  1010c5:	48 39 d0             	cmp    %rdx,%rax
  1010c8:	72 0f                	jb     1010d9 <console_putc+0x43>
        cp->cursor = console;
  1010ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010ce:	48 8d 15 2b 6f fb ff 	lea    -0x490d5(%rip),%rdx        # b8000 <console>
  1010d5:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  1010d9:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1010dd:	0f 85 82 00 00 00    	jne    101165 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  1010e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010e7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010eb:	48 8d 15 0e 6f fb ff 	lea    -0x490f2(%rip),%rdx        # b8000 <console>
  1010f2:	48 29 d0             	sub    %rdx,%rax
  1010f5:	48 d1 f8             	sar    %rax
  1010f8:	48 89 c1             	mov    %rax,%rcx
  1010fb:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101102:	66 66 66 
  101105:	48 89 c8             	mov    %rcx,%rax
  101108:	48 f7 ea             	imul   %rdx
  10110b:	48 89 d0             	mov    %rdx,%rax
  10110e:	48 c1 f8 05          	sar    $0x5,%rax
  101112:	48 89 ce             	mov    %rcx,%rsi
  101115:	48 c1 fe 3f          	sar    $0x3f,%rsi
  101119:	48 29 f0             	sub    %rsi,%rax
  10111c:	48 89 c2             	mov    %rax,%rdx
  10111f:	48 89 d0             	mov    %rdx,%rax
  101122:	48 c1 e0 02          	shl    $0x2,%rax
  101126:	48 01 d0             	add    %rdx,%rax
  101129:	48 c1 e0 04          	shl    $0x4,%rax
  10112d:	48 29 c1             	sub    %rax,%rcx
  101130:	48 89 ca             	mov    %rcx,%rdx
  101133:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101136:	eb 25                	jmp    10115d <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  101138:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10113b:	83 c8 20             	or     $0x20,%eax
  10113e:	89 c6                	mov    %eax,%esi
  101140:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101144:	48 8b 40 08          	mov    0x8(%rax),%rax
  101148:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10114c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101150:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101154:	89 f2                	mov    %esi,%edx
  101156:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101159:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10115d:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101161:	75 d5                	jne    101138 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101163:	eb 24                	jmp    101189 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  101165:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101169:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10116c:	89 d6                	mov    %edx,%esi
  10116e:	09 c6                	or     %eax,%esi
  101170:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101174:	48 8b 40 08          	mov    0x8(%rax),%rax
  101178:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10117c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101180:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101184:	89 f2                	mov    %esi,%edx
  101186:	66 89 10             	mov    %dx,(%rax)
}
  101189:	90                   	nop
  10118a:	c9                   	leave  
  10118b:	c3                   	ret    

000000000010118c <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10118c:	f3 0f 1e fa          	endbr64 
  101190:	55                   	push   %rbp
  101191:	48 89 e5             	mov    %rsp,%rbp
  101194:	48 83 ec 30          	sub    $0x30,%rsp
  101198:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10119b:	89 75 e8             	mov    %esi,-0x18(%rbp)
  10119e:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1011a2:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1011a6:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 101096 <console_putc>
  1011ad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1011b1:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1011b5:	78 09                	js     1011c0 <console_vprintf+0x34>
  1011b7:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1011be:	7e 07                	jle    1011c7 <console_vprintf+0x3b>
        cpos = 0;
  1011c0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1011c7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011ca:	48 98                	cltq   
  1011cc:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1011d0:	48 8d 05 29 6e fb ff 	lea    -0x491d7(%rip),%rax        # b8000 <console>
  1011d7:	48 01 d0             	add    %rdx,%rax
  1011da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1011de:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1011e2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1011e6:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1011e9:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1011ed:	48 89 c7             	mov    %rax,%rdi
  1011f0:	e8 9a f4 ff ff       	call   10068f <printer_vprintf>
    return cp.cursor - console;
  1011f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011f9:	48 8d 15 00 6e fb ff 	lea    -0x49200(%rip),%rdx        # b8000 <console>
  101200:	48 29 d0             	sub    %rdx,%rax
  101203:	48 d1 f8             	sar    %rax
}
  101206:	c9                   	leave  
  101207:	c3                   	ret    

0000000000101208 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101208:	f3 0f 1e fa          	endbr64 
  10120c:	55                   	push   %rbp
  10120d:	48 89 e5             	mov    %rsp,%rbp
  101210:	48 83 ec 60          	sub    $0x60,%rsp
  101214:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101217:	89 75 a8             	mov    %esi,-0x58(%rbp)
  10121a:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  10121e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101222:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101226:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10122a:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101231:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101235:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101239:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10123d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101241:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101245:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101249:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10124c:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10124f:	89 c7                	mov    %eax,%edi
  101251:	e8 36 ff ff ff       	call   10118c <console_vprintf>
  101256:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101259:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10125c:	c9                   	leave  
  10125d:	c3                   	ret    

000000000010125e <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10125e:	f3 0f 1e fa          	endbr64 
  101262:	55                   	push   %rbp
  101263:	48 89 e5             	mov    %rsp,%rbp
  101266:	48 83 ec 20          	sub    $0x20,%rsp
  10126a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10126e:	89 f0                	mov    %esi,%eax
  101270:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101273:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10127a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  10127e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101282:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101286:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10128a:	48 8b 40 10          	mov    0x10(%rax),%rax
  10128e:	48 39 c2             	cmp    %rax,%rdx
  101291:	73 1a                	jae    1012ad <string_putc+0x4f>
        *sp->s++ = c;
  101293:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101297:	48 8b 40 08          	mov    0x8(%rax),%rax
  10129b:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10129f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1012a3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012a7:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1012ab:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1012ad:	90                   	nop
  1012ae:	c9                   	leave  
  1012af:	c3                   	ret    

00000000001012b0 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1012b0:	f3 0f 1e fa          	endbr64 
  1012b4:	55                   	push   %rbp
  1012b5:	48 89 e5             	mov    %rsp,%rbp
  1012b8:	48 83 ec 40          	sub    $0x40,%rsp
  1012bc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1012c0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1012c4:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1012c8:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1012cc:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 10125e <string_putc>
  1012d3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  1012d7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1012db:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1012df:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1012e4:	74 33                	je     101319 <vsnprintf+0x69>
        sp.end = s + size - 1;
  1012e6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1012ea:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1012ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1012f2:	48 01 d0             	add    %rdx,%rax
  1012f5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1012f9:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1012fd:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101301:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101305:	be 00 00 00 00       	mov    $0x0,%esi
  10130a:	48 89 c7             	mov    %rax,%rdi
  10130d:	e8 7d f3 ff ff       	call   10068f <printer_vprintf>
        *sp.s = 0;
  101312:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101316:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101319:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10131d:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101321:	c9                   	leave  
  101322:	c3                   	ret    

0000000000101323 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101323:	f3 0f 1e fa          	endbr64 
  101327:	55                   	push   %rbp
  101328:	48 89 e5             	mov    %rsp,%rbp
  10132b:	48 83 ec 70          	sub    $0x70,%rsp
  10132f:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101333:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101337:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  10133b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10133f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101343:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101347:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10134e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101352:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101356:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10135a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10135e:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101362:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101366:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10136a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10136e:	48 89 c7             	mov    %rax,%rdi
  101371:	e8 3a ff ff ff       	call   1012b0 <vsnprintf>
  101376:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101379:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10137c:	c9                   	leave  
  10137d:	c3                   	ret    

000000000010137e <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10137e:	f3 0f 1e fa          	endbr64 
  101382:	55                   	push   %rbp
  101383:	48 89 e5             	mov    %rsp,%rbp
  101386:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10138a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101391:	eb 1a                	jmp    1013ad <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101393:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101396:	48 98                	cltq   
  101398:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  10139c:	48 8d 05 5d 6c fb ff 	lea    -0x493a3(%rip),%rax        # b8000 <console>
  1013a3:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1013a9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1013ad:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1013b4:	7e dd                	jle    101393 <console_clear+0x15>
    }
    cursorpos = 0;
  1013b6:	c7 05 3c 7c fb ff 00 	movl   $0x0,-0x483c4(%rip)        # b8ffc <cursorpos>
  1013bd:	00 00 00 
}
  1013c0:	90                   	nop
  1013c1:	c9                   	leave  
  1013c2:	c3                   	ret    
