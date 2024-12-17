
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
  100011:	48 8d 05 2f 30 00 00 	lea    0x302f(%rip),%rax        # 103047 <end+0xfff>
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
  10003d:	e8 1e 0c 00 00       	call   100c60 <rand>
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
  100065:	e8 be 02 00 00       	call   100328 <malloc>
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
block* split_block(block* block, size_t size);
void add_to_free_list(block *b);
void remove_from_free_list(block *b);
void heap_init();

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
    void *bptr = sbrk(size + BLOCKSIZE);
  10008b:	48 8d 7f 28          	lea    0x28(%rdi),%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  10008f:	cd 3a                	int    $0x3a
  100091:	48 89 05 98 1f 00 00 	mov    %rax,0x1f98(%rip)        # 102030 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100098:	48 89 c1             	mov    %rax,%rcx
    if (bptr == (void*) -1) {
  10009b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10009f:	74 26                	je     1000c7 <new_block+0x43>
        return NULL;
    }
    block* nblock = (block*)bptr;
    nblock->next = NULL;
  1000a1:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1000a8:	00 
    nblock->size = size;
  1000a9:	48 89 10             	mov    %rdx,(%rax)
    nblock->free = 0;
  1000ac:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
    nblock->free_next = NULL;
  1000b3:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  1000ba:	00 
    nblock->free_prev = NULL;
  1000bb:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
  1000c2:	00 
    return nblock;
}
  1000c3:	48 89 c8             	mov    %rcx,%rax
  1000c6:	c3                   	ret    
        return NULL;
  1000c7:	b9 00 00 00 00       	mov    $0x0,%ecx
  1000cc:	eb f5                	jmp    1000c3 <new_block+0x3f>

00000000001000ce <find_block>:

block* find_block(size_t size) {
  1000ce:	f3 0f 1e fa          	endbr64 
    block* curr = free_head;
  1000d2:	48 8b 05 5f 1f 00 00 	mov    0x1f5f(%rip),%rax        # 102038 <free_head>
    while (curr) {
  1000d9:	48 85 c0             	test   %rax,%rax
  1000dc:	74 0e                	je     1000ec <find_block+0x1e>
        if (curr->size >= size) {
  1000de:	48 39 38             	cmp    %rdi,(%rax)
  1000e1:	73 09                	jae    1000ec <find_block+0x1e>
            return curr;
        }
        curr = curr->free_next;
  1000e3:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (curr) {
  1000e7:	48 85 c0             	test   %rax,%rax
  1000ea:	75 f2                	jne    1000de <find_block+0x10>
    }
    return NULL;
}
  1000ec:	c3                   	ret    

00000000001000ed <add_to_free_list>:

    add_to_free_list(new);
    return new;
}

void add_to_free_list(block *b) {
  1000ed:	f3 0f 1e fa          	endbr64 
    b->free = 1;
  1000f1:	c7 47 10 01 00 00 00 	movl   $0x1,0x10(%rdi)
    b->free_next = free_head;
  1000f8:	48 8b 05 39 1f 00 00 	mov    0x1f39(%rip),%rax        # 102038 <free_head>
  1000ff:	48 89 47 18          	mov    %rax,0x18(%rdi)
    b->free_prev = NULL;
  100103:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  10010a:	00 
    if (free_head) {
  10010b:	48 85 c0             	test   %rax,%rax
  10010e:	74 04                	je     100114 <add_to_free_list+0x27>
        free_head->free_prev = b;
  100110:	48 89 78 20          	mov    %rdi,0x20(%rax)
    }
    free_head = b;
  100114:	48 89 3d 1d 1f 00 00 	mov    %rdi,0x1f1d(%rip)        # 102038 <free_head>
}
  10011b:	c3                   	ret    

000000000010011c <split_block>:
block* split_block(block* b, size_t size){
  10011c:	f3 0f 1e fa          	endbr64 
  100120:	55                   	push   %rbp
  100121:	48 89 e5             	mov    %rsp,%rbp
  100124:	53                   	push   %rbx
  100125:	48 83 ec 08          	sub    $0x8,%rsp
    if (b->size < size + BLOCKSIZE) {
  100129:	48 8b 07             	mov    (%rdi),%rax
  10012c:	48 8d 56 28          	lea    0x28(%rsi),%rdx
        return NULL;
  100130:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (b->size < size + BLOCKSIZE) {
  100135:	48 39 d0             	cmp    %rdx,%rax
  100138:	72 30                	jb     10016a <split_block+0x4e>
    void* nptr = (void*)b + BLOCKSIZE + size;
  10013a:	48 8d 1c 17          	lea    (%rdi,%rdx,1),%rbx
    new->size = b->size - size - BLOCKSIZE;
  10013e:	48 29 f0             	sub    %rsi,%rax
  100141:	48 8d 40 d8          	lea    -0x28(%rax),%rax
  100145:	48 89 03             	mov    %rax,(%rbx)
    new->free = 1;
  100148:	c7 43 10 01 00 00 00 	movl   $0x1,0x10(%rbx)
    new->free_next = NULL;
  10014f:	48 c7 43 18 00 00 00 	movq   $0x0,0x18(%rbx)
  100156:	00 
    new->free_prev = NULL;
  100157:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  10015e:	00 
    b->size = size;
  10015f:	48 89 37             	mov    %rsi,(%rdi)
    add_to_free_list(new);
  100162:	48 89 df             	mov    %rbx,%rdi
  100165:	e8 83 ff ff ff       	call   1000ed <add_to_free_list>
}
  10016a:	48 89 d8             	mov    %rbx,%rax
  10016d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100171:	c9                   	leave  
  100172:	c3                   	ret    

0000000000100173 <remove_from_free_list>:

void remove_from_free_list(block *b) {
  100173:	f3 0f 1e fa          	endbr64 
    if (b->free_prev) {
  100177:	48 8b 47 20          	mov    0x20(%rdi),%rax
  10017b:	48 85 c0             	test   %rax,%rax
  10017e:	74 31                	je     1001b1 <remove_from_free_list+0x3e>
        b->free_prev->free_next = b->free_next;
  100180:	48 8b 57 18          	mov    0x18(%rdi),%rdx
  100184:	48 89 50 18          	mov    %rdx,0x18(%rax)
    } else {
        free_head = b->free_next;
    }
    if (b->free_next) {
  100188:	48 8b 47 18          	mov    0x18(%rdi),%rax
  10018c:	48 85 c0             	test   %rax,%rax
  10018f:	74 08                	je     100199 <remove_from_free_list+0x26>
        b->free_next->free_prev = b->free_prev;
  100191:	48 8b 57 20          	mov    0x20(%rdi),%rdx
  100195:	48 89 50 20          	mov    %rdx,0x20(%rax)
    }
    b->free = 0;
  100199:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->free_next = NULL;
  1001a0:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  1001a7:	00 
    b->free_prev = NULL;
  1001a8:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  1001af:	00 
}
  1001b0:	c3                   	ret    
        free_head = b->free_next;
  1001b1:	48 8b 47 18          	mov    0x18(%rdi),%rax
  1001b5:	48 89 05 7c 1e 00 00 	mov    %rax,0x1e7c(%rip)        # 102038 <free_head>
  1001bc:	eb ca                	jmp    100188 <remove_from_free_list+0x15>

00000000001001be <update_largest_free_chunk>:
void update_largest_free_chunk() {
  1001be:	f3 0f 1e fa          	endbr64 
    largest_free_chunk = 0; // Reset the value
  1001c2:	c7 05 44 1e 00 00 00 	movl   $0x0,0x1e44(%rip)        # 102010 <largest_free_chunk>
  1001c9:	00 00 00 
    block *b = free_head;
  1001cc:	48 8b 05 65 1e 00 00 	mov    0x1e65(%rip),%rax        # 102038 <free_head>
    int size;
    // Traverse the free list to find the largest free chunk
    while (b) {
  1001d3:	48 85 c0             	test   %rax,%rax
  1001d6:	75 0a                	jne    1001e2 <update_largest_free_chunk+0x24>
        if (size > largest_free_chunk) {
            largest_free_chunk = size;
        }
        b = b->free_next;
    }
}
  1001d8:	c3                   	ret    
        b = b->free_next;
  1001d9:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (b) {
  1001dd:	48 85 c0             	test   %rax,%rax
  1001e0:	74 f6                	je     1001d8 <update_largest_free_chunk+0x1a>
        size = (int)b->size;
  1001e2:	48 8b 10             	mov    (%rax),%rdx
        if (size > largest_free_chunk) {
  1001e5:	39 15 25 1e 00 00    	cmp    %edx,0x1e25(%rip)        # 102010 <largest_free_chunk>
  1001eb:	7d ec                	jge    1001d9 <update_largest_free_chunk+0x1b>
            largest_free_chunk = size;
  1001ed:	89 15 1d 1e 00 00    	mov    %edx,0x1e1d(%rip)        # 102010 <largest_free_chunk>
  1001f3:	eb e4                	jmp    1001d9 <update_largest_free_chunk+0x1b>

00000000001001f5 <heap_init>:
    }
    update_free_space();         // Update free space
    update_largest_free_chunk(); // Update largest free chunk

}
void heap_init() {
  1001f5:	f3 0f 1e fa          	endbr64 
    asm volatile ("int %1" :  "=a" (result)
  1001f9:	bf 20 03 00 00       	mov    $0x320,%edi
  1001fe:	cd 3a                	int    $0x3a
  100200:	48 89 05 29 1e 00 00 	mov    %rax,0x1e29(%rip)        # 102030 <result.0>
    size_array = (long*) sbrk(sizeof(long) * ARRAY_SIZE);
  100207:	48 89 05 12 1e 00 00 	mov    %rax,0x1e12(%rip)        # 102020 <size_array>
  10020e:	cd 3a                	int    $0x3a
  100210:	48 89 05 19 1e 00 00 	mov    %rax,0x1e19(%rip)        # 102030 <result.0>
    ptr_array = (void**) sbrk(sizeof(void*) * ARRAY_SIZE);
  100217:	48 89 05 fa 1d 00 00 	mov    %rax,0x1dfa(%rip)        # 102018 <ptr_array>
    if (size_array == (void*)-1 || ptr_array == (void*)-1) {
  10021e:	48 83 3d fa 1d 00 00 	cmpq   $0xffffffffffffffff,0x1dfa(%rip)        # 102020 <size_array>
  100225:	ff 
  100226:	74 06                	je     10022e <heap_init+0x39>
  100228:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10022c:	75 16                	jne    100244 <heap_init+0x4f>
        // Handle sbrk failure
        size_array = NULL;
  10022e:	48 c7 05 e7 1d 00 00 	movq   $0x0,0x1de7(%rip)        # 102020 <size_array>
  100235:	00 00 00 00 
        ptr_array = NULL;
  100239:	48 c7 05 d4 1d 00 00 	movq   $0x0,0x1dd4(%rip)        # 102018 <ptr_array>
  100240:	00 00 00 00 
    }
    num_allocs = 0;
  100244:	c7 05 da 1d 00 00 00 	movl   $0x0,0x1dda(%rip)        # 102028 <num_allocs>
  10024b:	00 00 00 
    free_space = 0;
  10024e:	c7 05 bc 1d 00 00 00 	movl   $0x0,0x1dbc(%rip)        # 102014 <free_space>
  100255:	00 00 00 
    largest_free_chunk = 0;
  100258:	c7 05 ae 1d 00 00 00 	movl   $0x0,0x1dae(%rip)        # 102010 <largest_free_chunk>
  10025f:	00 00 00 
}
  100262:	c3                   	ret    

0000000000100263 <update_free_space>:

void update_free_space() {
  100263:	f3 0f 1e fa          	endbr64 
    free_space = 0; // Reset the free space counter
  100267:	c7 05 a3 1d 00 00 00 	movl   $0x0,0x1da3(%rip)        # 102014 <free_space>
  10026e:	00 00 00 
    block *b = free_head;
  100271:	48 8b 05 c0 1d 00 00 	mov    0x1dc0(%rip),%rax        # 102038 <free_head>

    // Traverse the free list and sum up the size of free blocks
    while (b) {
  100278:	48 85 c0             	test   %rax,%rax
  10027b:	74 16                	je     100293 <update_free_space+0x30>
        free_space += b->size + BLOCKSIZE; // Add block size + metadata size
  10027d:	48 8b 08             	mov    (%rax),%rcx
  100280:	48 8d 51 28          	lea    0x28(%rcx),%rdx
  100284:	01 15 8a 1d 00 00    	add    %edx,0x1d8a(%rip)        # 102014 <free_space>
        b = b->free_next;
  10028a:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (b) {
  10028e:	48 85 c0             	test   %rax,%rax
  100291:	75 ea                	jne    10027d <update_free_space+0x1a>
    }
}
  100293:	c3                   	ret    

0000000000100294 <defrag>:
void defrag() {
  100294:	f3 0f 1e fa          	endbr64 
  100298:	55                   	push   %rbp
  100299:	48 89 e5             	mov    %rsp,%rbp
  10029c:	41 54                	push   %r12
  10029e:	53                   	push   %rbx
    block *b = free_head;
  10029f:	48 8b 1d 92 1d 00 00 	mov    0x1d92(%rip),%rbx        # 102038 <free_head>
    while (b && b->free_next) {
  1002a6:	48 85 db             	test   %rbx,%rbx
  1002a9:	74 34                	je     1002df <defrag+0x4b>
  1002ab:	4c 8b 63 18          	mov    0x18(%rbx),%r12
  1002af:	4d 85 e4             	test   %r12,%r12
  1002b2:	74 2b                	je     1002df <defrag+0x4b>
        if ((void*)b + BLOCKSIZE + b->size == (void*)b->free_next) {
  1002b4:	48 8b 03             	mov    (%rbx),%rax
  1002b7:	48 8d 44 03 28       	lea    0x28(%rbx,%rax,1),%rax
  1002bc:	49 39 c4             	cmp    %rax,%r12
  1002bf:	74 05                	je     1002c6 <defrag+0x32>
    while (b && b->free_next) {
  1002c1:	4c 89 e3             	mov    %r12,%rbx
  1002c4:	eb e0                	jmp    1002a6 <defrag+0x12>
            remove_from_free_list(next);
  1002c6:	4c 89 e7             	mov    %r12,%rdi
  1002c9:	e8 a5 fe ff ff       	call   100173 <remove_from_free_list>
            b->size += BLOCKSIZE + next->size;
  1002ce:	48 8b 13             	mov    (%rbx),%rdx
  1002d1:	49 8b 04 24          	mov    (%r12),%rax
  1002d5:	48 8d 44 02 28       	lea    0x28(%rdx,%rax,1),%rax
  1002da:	48 89 03             	mov    %rax,(%rbx)
  1002dd:	eb c7                	jmp    1002a6 <defrag+0x12>
    update_free_space();         // Update free space
  1002df:	b8 00 00 00 00       	mov    $0x0,%eax
  1002e4:	e8 7a ff ff ff       	call   100263 <update_free_space>
    update_largest_free_chunk(); // Update largest free chunk
  1002e9:	b8 00 00 00 00       	mov    $0x0,%eax
  1002ee:	e8 cb fe ff ff       	call   1001be <update_largest_free_chunk>
}
  1002f3:	5b                   	pop    %rbx
  1002f4:	41 5c                	pop    %r12
  1002f6:	5d                   	pop    %rbp
  1002f7:	c3                   	ret    

00000000001002f8 <add_alloc>:

void add_alloc(block* b){
  1002f8:	f3 0f 1e fa          	endbr64 
    size_array[num_allocs] = b->size;
  1002fc:	48 63 15 25 1d 00 00 	movslq 0x1d25(%rip),%rdx        # 102028 <num_allocs>
  100303:	48 8b 0f             	mov    (%rdi),%rcx
  100306:	48 8b 05 13 1d 00 00 	mov    0x1d13(%rip),%rax        # 102020 <size_array>
  10030d:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
    ptr_array[num_allocs] = (void*)((void*)b + BLOCKSIZE);
  100311:	48 63 15 10 1d 00 00 	movslq 0x1d10(%rip),%rdx        # 102028 <num_allocs>
  100318:	48 83 c7 28          	add    $0x28,%rdi
  10031c:	48 8b 05 f5 1c 00 00 	mov    0x1cf5(%rip),%rax        # 102018 <ptr_array>
  100323:	48 89 3c d0          	mov    %rdi,(%rax,%rdx,8)
} 
  100327:	c3                   	ret    

0000000000100328 <malloc>:
void *malloc(uint64_t numbytes) {
  100328:	f3 0f 1e fa          	endbr64 
  10032c:	55                   	push   %rbp
  10032d:	48 89 e5             	mov    %rsp,%rbp
  100330:	41 54                	push   %r12
  100332:	53                   	push   %rbx
  100333:	49 89 fc             	mov    %rdi,%r12
    if (size_array == NULL) { 
  100336:	48 83 3d e2 1c 00 00 	cmpq   $0x0,0x1ce2(%rip)        # 102020 <size_array>
  10033d:	00 
  10033e:	74 3e                	je     10037e <malloc+0x56>
    return (size + 7) / 8 * 8;
  100340:	49 83 c4 07          	add    $0x7,%r12
  100344:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    block *b = find_block(size);
  100348:	4c 89 e7             	mov    %r12,%rdi
  10034b:	e8 7e fd ff ff       	call   1000ce <find_block>
  100350:	48 89 c3             	mov    %rax,%rbx
    if (b == NULL) {
  100353:	48 85 c0             	test   %rax,%rax
  100356:	74 32                	je     10038a <malloc+0x62>
        remove_from_free_list(b);
  100358:	48 89 c7             	mov    %rax,%rdi
  10035b:	e8 13 fe ff ff       	call   100173 <remove_from_free_list>
        if (b->size > size + BLOCKSIZE) {
  100360:	49 8d 44 24 28       	lea    0x28(%r12),%rax
  100365:	48 39 03             	cmp    %rax,(%rbx)
  100368:	77 32                	ja     10039c <malloc+0x74>
    add_alloc(b); 
  10036a:	48 89 df             	mov    %rbx,%rdi
  10036d:	e8 86 ff ff ff       	call   1002f8 <add_alloc>
    return (void*)((void*)b + BLOCKSIZE);
  100372:	48 83 c3 28          	add    $0x28,%rbx
}
  100376:	48 89 d8             	mov    %rbx,%rax
  100379:	5b                   	pop    %rbx
  10037a:	41 5c                	pop    %r12
  10037c:	5d                   	pop    %rbp
  10037d:	c3                   	ret    
        heap_init();
  10037e:	b8 00 00 00 00       	mov    $0x0,%eax
  100383:	e8 6d fe ff ff       	call   1001f5 <heap_init>
  100388:	eb b6                	jmp    100340 <malloc+0x18>
        b = new_block(size);
  10038a:	4c 89 e7             	mov    %r12,%rdi
  10038d:	e8 f2 fc ff ff       	call   100084 <new_block>
  100392:	48 89 c3             	mov    %rax,%rbx
        if (b == NULL) {
  100395:	48 85 c0             	test   %rax,%rax
  100398:	75 d0                	jne    10036a <malloc+0x42>
  10039a:	eb da                	jmp    100376 <malloc+0x4e>
            split_block(b, size);
  10039c:	4c 89 e6             	mov    %r12,%rsi
  10039f:	48 89 df             	mov    %rbx,%rdi
  1003a2:	e8 75 fd ff ff       	call   10011c <split_block>
            update_free_space();         
  1003a7:	b8 00 00 00 00       	mov    $0x0,%eax
  1003ac:	e8 b2 fe ff ff       	call   100263 <update_free_space>
  1003b1:	eb b7                	jmp    10036a <malloc+0x42>

00000000001003b3 <calloc>:
void *calloc(uint64_t num, uint64_t sz) {
  1003b3:	f3 0f 1e fa          	endbr64 
  1003b7:	55                   	push   %rbp
  1003b8:	48 89 e5             	mov    %rsp,%rbp
  1003bb:	41 54                	push   %r12
  1003bd:	53                   	push   %rbx
    uint64_t total = num * sz;
  1003be:	48 0f af fe          	imul   %rsi,%rdi
  1003c2:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  1003c5:	e8 5e ff ff ff       	call   100328 <malloc>
  1003ca:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  1003cd:	48 85 c0             	test   %rax,%rax
  1003d0:	74 10                	je     1003e2 <calloc+0x2f>
        memset(ptr, 0, total);
  1003d2:	4c 89 e2             	mov    %r12,%rdx
  1003d5:	be 00 00 00 00       	mov    $0x0,%esi
  1003da:	48 89 c7             	mov    %rax,%rdi
  1003dd:	e8 a9 06 00 00       	call   100a8b <memset>
}
  1003e2:	48 89 d8             	mov    %rbx,%rax
  1003e5:	5b                   	pop    %rbx
  1003e6:	41 5c                	pop    %r12
  1003e8:	5d                   	pop    %rbp
  1003e9:	c3                   	ret    

00000000001003ea <remove_alloc>:
void remove_alloc(block* b){
  1003ea:	f3 0f 1e fa          	endbr64 
    num_allocs--;
  1003ee:	8b 05 34 1c 00 00    	mov    0x1c34(%rip),%eax        # 102028 <num_allocs>
  1003f4:	83 e8 01             	sub    $0x1,%eax
  1003f7:	89 05 2b 1c 00 00    	mov    %eax,0x1c2b(%rip)        # 102028 <num_allocs>
    size_array[num_allocs] = 0;
  1003fd:	48 98                	cltq   
  1003ff:	48 8b 15 1a 1c 00 00 	mov    0x1c1a(%rip),%rdx        # 102020 <size_array>
  100406:	48 c7 04 c2 00 00 00 	movq   $0x0,(%rdx,%rax,8)
  10040d:	00 
    // ptr_array[num_allocs] = NULL;
}
  10040e:	c3                   	ret    

000000000010040f <free>:
void free(void *firstbyte) {
  10040f:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  100413:	48 85 ff             	test   %rdi,%rdi
  100416:	74 06                	je     10041e <free+0xf>
    if (b->free) return; // Prevent double-free
  100418:	83 7f e8 00          	cmpl   $0x0,-0x18(%rdi)
  10041c:	74 01                	je     10041f <free+0x10>
  10041e:	c3                   	ret    
void free(void *firstbyte) {
  10041f:	55                   	push   %rbp
  100420:	48 89 e5             	mov    %rsp,%rbp
  100423:	53                   	push   %rbx
  100424:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
  100428:	48 8d 5f d8          	lea    -0x28(%rdi),%rbx
    add_to_free_list(b);
  10042c:	48 89 df             	mov    %rbx,%rdi
  10042f:	e8 b9 fc ff ff       	call   1000ed <add_to_free_list>
    remove_alloc(b); // Remove from size_array and ptr_array
  100434:	48 89 df             	mov    %rbx,%rdi
  100437:	e8 ae ff ff ff       	call   1003ea <remove_alloc>
    update_free_space();         // Update free space
  10043c:	b8 00 00 00 00       	mov    $0x0,%eax
  100441:	e8 1d fe ff ff       	call   100263 <update_free_space>
    update_largest_free_chunk(); // Update largest free chunk
  100446:	b8 00 00 00 00       	mov    $0x0,%eax
  10044b:	e8 6e fd ff ff       	call   1001be <update_largest_free_chunk>
}
  100450:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100454:	c9                   	leave  
  100455:	c3                   	ret    

0000000000100456 <realloc>:
void *realloc(void *ptr, uint64_t sz) {
  100456:	f3 0f 1e fa          	endbr64 
  10045a:	55                   	push   %rbp
  10045b:	48 89 e5             	mov    %rsp,%rbp
  10045e:	41 54                	push   %r12
  100460:	53                   	push   %rbx
  100461:	48 89 fb             	mov    %rdi,%rbx
  100464:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  100467:	48 85 db             	test   %rbx,%rbx
  10046a:	74 2d                	je     100499 <realloc+0x43>
    if (sz == 0) {
  10046c:	48 85 f6             	test   %rsi,%rsi
  10046f:	74 32                	je     1004a3 <realloc+0x4d>
    return (size + 7) / 8 * 8;
  100471:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  100475:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi
    if (b->size >= aligned_size) {
  100479:	48 8b 43 d8          	mov    -0x28(%rbx),%rax
  10047d:	48 39 f0             	cmp    %rsi,%rax
  100480:	72 31                	jb     1004b3 <realloc+0x5d>
        if (b->size > aligned_size + BLOCKSIZE) {
  100482:	48 8d 56 28          	lea    0x28(%rsi),%rdx
        return ptr;
  100486:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  100489:	48 39 d0             	cmp    %rdx,%rax
  10048c:	76 49                	jbe    1004d7 <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE);
  10048e:	48 8d 7b d8          	lea    -0x28(%rbx),%rdi
            split_block(b, aligned_size);
  100492:	e8 85 fc ff ff       	call   10011c <split_block>
  100497:	eb 3e                	jmp    1004d7 <realloc+0x81>
        return malloc(sz);
  100499:	e8 8a fe ff ff       	call   100328 <malloc>
  10049e:	49 89 c4             	mov    %rax,%r12
  1004a1:	eb 34                	jmp    1004d7 <realloc+0x81>
        free(ptr);
  1004a3:	48 89 df             	mov    %rbx,%rdi
  1004a6:	e8 64 ff ff ff       	call   10040f <free>
        return NULL;
  1004ab:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  1004b1:	eb 24                	jmp    1004d7 <realloc+0x81>
    void *new_ptr = malloc(sz);
  1004b3:	e8 70 fe ff ff       	call   100328 <malloc>
  1004b8:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  1004bb:	48 85 c0             	test   %rax,%rax
  1004be:	74 17                	je     1004d7 <realloc+0x81>
    memcpy(new_ptr, ptr, b->size);
  1004c0:	48 8b 53 d8          	mov    -0x28(%rbx),%rdx
  1004c4:	48 89 de             	mov    %rbx,%rsi
  1004c7:	48 89 c7             	mov    %rax,%rdi
  1004ca:	e8 b6 04 00 00       	call   100985 <memcpy>
    free(ptr);
  1004cf:	48 89 df             	mov    %rbx,%rdi
  1004d2:	e8 38 ff ff ff       	call   10040f <free>
}
  1004d7:	4c 89 e0             	mov    %r12,%rax
  1004da:	5b                   	pop    %rbx
  1004db:	41 5c                	pop    %r12
  1004dd:	5d                   	pop    %rbp
  1004de:	c3                   	ret    

00000000001004df <heap_info>:


int heap_info(heap_info_struct * info) {
  1004df:	f3 0f 1e fa          	endbr64 
    info->num_allocs = num_allocs;
  1004e3:	8b 05 3f 1b 00 00    	mov    0x1b3f(%rip),%eax        # 102028 <num_allocs>
  1004e9:	89 07                	mov    %eax,(%rdi)
    info->free_space = free_space;             
  1004eb:	8b 05 23 1b 00 00    	mov    0x1b23(%rip),%eax        # 102014 <free_space>
  1004f1:	89 47 18             	mov    %eax,0x18(%rdi)
    info->largest_free_chunk = largest_free_chunk;
  1004f4:	8b 05 16 1b 00 00    	mov    0x1b16(%rip),%eax        # 102010 <largest_free_chunk>
  1004fa:	89 47 1c             	mov    %eax,0x1c(%rdi)

    info->size_array = size_array;
  1004fd:	48 8b 05 1c 1b 00 00 	mov    0x1b1c(%rip),%rax        # 102020 <size_array>
  100504:	48 89 47 08          	mov    %rax,0x8(%rdi)
    info->ptr_array = ptr_array;
  100508:	48 8b 05 09 1b 00 00 	mov    0x1b09(%rip),%rax        # 102018 <ptr_array>
  10050f:	48 89 47 10          	mov    %rax,0x10(%rdi)
    return 0;
}
  100513:	b8 00 00 00 00       	mov    $0x0,%eax
  100518:	c3                   	ret    

0000000000100519 <_quicksort>:
typedef int (*__compar_fn_t) (const void *, const void *);

void
_quicksort (void *const pbase, size_t total_elems, size_t size,
            __compar_fn_t cmp)
{
  100519:	f3 0f 1e fa          	endbr64 
  10051d:	55                   	push   %rbp
  10051e:	48 89 e5             	mov    %rsp,%rbp
  100521:	41 57                	push   %r15
  100523:	41 56                	push   %r14
  100525:	41 55                	push   %r13
  100527:	41 54                	push   %r12
  100529:	53                   	push   %rbx
  10052a:	48 81 ec 48 04 00 00 	sub    $0x448,%rsp
  100531:	48 89 bd a0 fb ff ff 	mov    %rdi,-0x460(%rbp)
  100538:	48 89 b5 98 fb ff ff 	mov    %rsi,-0x468(%rbp)
  10053f:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
    char *base_ptr = (char *) pbase;
    const size_t max_thresh = MAX_THRESH * size;
    if (total_elems == 0)
  100546:	48 85 f6             	test   %rsi,%rsi
  100549:	0f 84 94 03 00 00    	je     1008e3 <_quicksort+0x3ca>
  10054f:	48 89 f0             	mov    %rsi,%rax
  100552:	48 89 cb             	mov    %rcx,%rbx
    const size_t max_thresh = MAX_THRESH * size;
  100555:	48 8d 0c 95 00 00 00 	lea    0x0(,%rdx,4),%rcx
  10055c:	00 
  10055d:	48 89 8d a8 fb ff ff 	mov    %rcx,-0x458(%rbp)
	/* Avoid lossage with unsigned arithmetic below.  */
	return;
    if (total_elems > MAX_THRESH)
  100564:	48 83 fe 04          	cmp    $0x4,%rsi
  100568:	0f 86 bd 02 00 00    	jbe    10082b <_quicksort+0x312>
    {
	char *lo = base_ptr;
	char *hi = &lo[size * (total_elems - 1)];
  10056e:	48 83 e8 01          	sub    $0x1,%rax
  100572:	48 0f af c2          	imul   %rdx,%rax
  100576:	48 01 f8             	add    %rdi,%rax
  100579:	48 89 85 c0 fb ff ff 	mov    %rax,-0x440(%rbp)
	stack_node stack[STACK_SIZE];
	stack_node *top = stack;
	PUSH (NULL, NULL);
  100580:	48 c7 85 d0 fb ff ff 	movq   $0x0,-0x430(%rbp)
  100587:	00 00 00 00 
  10058b:	48 c7 85 d8 fb ff ff 	movq   $0x0,-0x428(%rbp)
  100592:	00 00 00 00 
	char *lo = base_ptr;
  100596:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
	PUSH (NULL, NULL);
  10059d:	48 8d 85 e0 fb ff ff 	lea    -0x420(%rbp),%rax
  1005a4:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
		goto jump_over;
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
		SWAP (mid, lo, size);
jump_over:;
	  left_ptr  = lo + size;
	  right_ptr = hi - size;
  1005ab:	48 f7 da             	neg    %rdx
  1005ae:	49 89 d7             	mov    %rdx,%r15
  1005b1:	e9 8c 01 00 00       	jmp    100742 <_quicksort+0x229>
  1005b6:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  1005bd:	49 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%rdi
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  1005c2:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  1005c9:	4c 89 e8             	mov    %r13,%rax
  1005cc:	0f b6 08             	movzbl (%rax),%ecx
  1005cf:	48 83 c0 01          	add    $0x1,%rax
  1005d3:	0f b6 32             	movzbl (%rdx),%esi
  1005d6:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  1005da:	48 83 c2 01          	add    $0x1,%rdx
  1005de:	88 4a ff             	mov    %cl,-0x1(%rdx)
  1005e1:	48 39 c7             	cmp    %rax,%rdi
  1005e4:	75 e6                	jne    1005cc <_quicksort+0xb3>
  1005e6:	e9 92 01 00 00       	jmp    10077d <_quicksort+0x264>
  1005eb:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  1005f2:	4d 8d 64 05 00       	lea    0x0(%r13,%rax,1),%r12
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  1005f7:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
		SWAP (mid, hi, size);
  1005fe:	4c 89 e8             	mov    %r13,%rax
  100601:	0f b6 08             	movzbl (%rax),%ecx
  100604:	48 83 c0 01          	add    $0x1,%rax
  100608:	0f b6 32             	movzbl (%rdx),%esi
  10060b:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  10060f:	48 83 c2 01          	add    $0x1,%rdx
  100613:	88 4a ff             	mov    %cl,-0x1(%rdx)
  100616:	49 39 c4             	cmp    %rax,%r12
  100619:	75 e6                	jne    100601 <_quicksort+0xe8>
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  10061b:	48 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%rsi
  100622:	4c 89 ef             	mov    %r13,%rdi
  100625:	ff d3                	call   *%rbx
  100627:	85 c0                	test   %eax,%eax
  100629:	0f 89 62 01 00 00    	jns    100791 <_quicksort+0x278>
  10062f:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  100636:	4c 89 e8             	mov    %r13,%rax
  100639:	0f b6 08             	movzbl (%rax),%ecx
  10063c:	48 83 c0 01          	add    $0x1,%rax
  100640:	0f b6 32             	movzbl (%rdx),%esi
  100643:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  100647:	48 83 c2 01          	add    $0x1,%rdx
  10064b:	88 4a ff             	mov    %cl,-0x1(%rdx)
  10064e:	49 39 c4             	cmp    %rax,%r12
  100651:	75 e6                	jne    100639 <_quicksort+0x120>
jump_over:;
  100653:	e9 39 01 00 00       	jmp    100791 <_quicksort+0x278>
	  do
	  {
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
		  left_ptr += size;
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
		  right_ptr -= size;
  100658:	4d 01 fc             	add    %r15,%r12
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
  10065b:	4c 89 e6             	mov    %r12,%rsi
  10065e:	4c 89 ef             	mov    %r13,%rdi
  100661:	ff d3                	call   *%rbx
  100663:	85 c0                	test   %eax,%eax
  100665:	78 f1                	js     100658 <_quicksort+0x13f>
	      if (left_ptr < right_ptr)
  100667:	4d 39 e6             	cmp    %r12,%r14
  10066a:	72 1c                	jb     100688 <_quicksort+0x16f>
		  else if (mid == right_ptr)
		      mid = left_ptr;
		  left_ptr += size;
		  right_ptr -= size;
	      }
	      else if (left_ptr == right_ptr)
  10066c:	74 5e                	je     1006cc <_quicksort+0x1b3>
		  left_ptr += size;
		  right_ptr -= size;
		  break;
	      }
	  }
	  while (left_ptr <= right_ptr);
  10066e:	4d 39 e6             	cmp    %r12,%r14
  100671:	77 63                	ja     1006d6 <_quicksort+0x1bd>
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
  100673:	4c 89 ee             	mov    %r13,%rsi
  100676:	4c 89 f7             	mov    %r14,%rdi
  100679:	ff d3                	call   *%rbx
  10067b:	85 c0                	test   %eax,%eax
  10067d:	79 dc                	jns    10065b <_quicksort+0x142>
		  left_ptr += size;
  10067f:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  100686:	eb eb                	jmp    100673 <_quicksort+0x15a>
  100688:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  10068f:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
	      if (left_ptr < right_ptr)
  100693:	4c 89 e2             	mov    %r12,%rdx
  100696:	4c 89 f0             	mov    %r14,%rax
		  SWAP (left_ptr, right_ptr, size);
  100699:	0f b6 08             	movzbl (%rax),%ecx
  10069c:	48 83 c0 01          	add    $0x1,%rax
  1006a0:	0f b6 32             	movzbl (%rdx),%esi
  1006a3:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  1006a7:	48 83 c2 01          	add    $0x1,%rdx
  1006ab:	88 4a ff             	mov    %cl,-0x1(%rdx)
  1006ae:	48 39 f8             	cmp    %rdi,%rax
  1006b1:	75 e6                	jne    100699 <_quicksort+0x180>
		  if (mid == left_ptr)
  1006b3:	4d 39 ee             	cmp    %r13,%r14
  1006b6:	74 0f                	je     1006c7 <_quicksort+0x1ae>
		  else if (mid == right_ptr)
  1006b8:	4d 39 ec             	cmp    %r13,%r12
  1006bb:	4d 0f 44 ee          	cmove  %r14,%r13
		  right_ptr -= size;
  1006bf:	4d 01 fc             	add    %r15,%r12
		  left_ptr += size;
  1006c2:	49 89 fe             	mov    %rdi,%r14
  1006c5:	eb a7                	jmp    10066e <_quicksort+0x155>
  1006c7:	4d 89 e5             	mov    %r12,%r13
  1006ca:	eb f3                	jmp    1006bf <_quicksort+0x1a6>
		  left_ptr += size;
  1006cc:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
		  right_ptr -= size;
  1006d3:	4d 01 fc             	add    %r15,%r12
	  /* Set up pointers for next iteration.  First determine whether
	     left and right partitions are below the threshold size.  If so,
	     ignore one or both.  Otherwise, push the larger partition's
	     bounds on the stack and continue sorting the smaller one. */
	  if ((size_t) (right_ptr - lo) <= max_thresh)
  1006d6:	4c 89 e0             	mov    %r12,%rax
  1006d9:	48 2b 85 b8 fb ff ff 	sub    -0x448(%rbp),%rax
  1006e0:	48 8b bd a8 fb ff ff 	mov    -0x458(%rbp),%rdi
  1006e7:	48 39 f8             	cmp    %rdi,%rax
  1006ea:	0f 87 bf 00 00 00    	ja     1007af <_quicksort+0x296>
	  {
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  1006f0:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  1006f7:	4c 29 f0             	sub    %r14,%rax
		  /* Ignore both small partitions. */
		  POP (lo, hi);
	      else
		  /* Ignore small left partition. */
		  lo = left_ptr;
  1006fa:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  100701:	48 39 f8             	cmp    %rdi,%rax
  100704:	77 28                	ja     10072e <_quicksort+0x215>
		  POP (lo, hi);
  100706:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  10070d:	48 8b 78 f0          	mov    -0x10(%rax),%rdi
  100711:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
  100718:	48 8b 78 f8          	mov    -0x8(%rax),%rdi
  10071c:	48 89 bd c0 fb ff ff 	mov    %rdi,-0x440(%rbp)
  100723:	48 8d 40 f0          	lea    -0x10(%rax),%rax
  100727:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	while (STACK_NOT_EMPTY)
  10072e:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  100735:	48 39 85 b0 fb ff ff 	cmp    %rax,-0x450(%rbp)
  10073c:	0f 86 e9 00 00 00    	jbe    10082b <_quicksort+0x312>
	    char *mid = lo + size * ((hi - lo) / size >> 1);
  100742:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  100749:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  100750:	48 29 f8             	sub    %rdi,%rax
  100753:	48 8b 8d c8 fb ff ff 	mov    -0x438(%rbp),%rcx
  10075a:	ba 00 00 00 00       	mov    $0x0,%edx
  10075f:	48 f7 f1             	div    %rcx
  100762:	48 d1 e8             	shr    %rax
  100765:	48 0f af c1          	imul   %rcx,%rax
  100769:	4c 8d 2c 07          	lea    (%rdi,%rax,1),%r13
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  10076d:	48 89 fe             	mov    %rdi,%rsi
  100770:	4c 89 ef             	mov    %r13,%rdi
  100773:	ff d3                	call   *%rbx
  100775:	85 c0                	test   %eax,%eax
  100777:	0f 88 39 fe ff ff    	js     1005b6 <_quicksort+0x9d>
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  10077d:	4c 89 ee             	mov    %r13,%rsi
  100780:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  100787:	ff d3                	call   *%rbx
  100789:	85 c0                	test   %eax,%eax
  10078b:	0f 88 5a fe ff ff    	js     1005eb <_quicksort+0xd2>
	  left_ptr  = lo + size;
  100791:	4c 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%r14
  100798:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
	  right_ptr = hi - size;
  10079f:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  1007a6:	4e 8d 24 38          	lea    (%rax,%r15,1),%r12
  1007aa:	e9 c4 fe ff ff       	jmp    100673 <_quicksort+0x15a>
	  }
	  else if ((size_t) (hi - left_ptr) <= max_thresh)
  1007af:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
  1007b6:	4c 29 f2             	sub    %r14,%rdx
  1007b9:	48 3b 95 a8 fb ff ff 	cmp    -0x458(%rbp),%rdx
  1007c0:	76 5d                	jbe    10081f <_quicksort+0x306>
	      /* Ignore small right partition. */
	      hi = right_ptr;
	  else if ((right_ptr - lo) > (hi - left_ptr))
  1007c2:	48 39 d0             	cmp    %rdx,%rax
  1007c5:	7e 2c                	jle    1007f3 <_quicksort+0x2da>
	  {
	      /* Push larger left partition indices. */
	      PUSH (lo, right_ptr);
  1007c7:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  1007ce:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  1007d5:	48 89 38             	mov    %rdi,(%rax)
  1007d8:	4c 89 60 08          	mov    %r12,0x8(%rax)
  1007dc:	48 83 c0 10          	add    $0x10,%rax
  1007e0:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      lo = left_ptr;
  1007e7:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
  1007ee:	e9 3b ff ff ff       	jmp    10072e <_quicksort+0x215>
	  }
	  else
	  {
	      /* Push larger right partition indices. */
	      PUSH (left_ptr, hi);
  1007f3:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  1007fa:	4c 89 30             	mov    %r14,(%rax)
  1007fd:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  100804:	48 89 78 08          	mov    %rdi,0x8(%rax)
  100808:	48 83 c0 10          	add    $0x10,%rax
  10080c:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      hi = right_ptr;
  100813:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  10081a:	e9 0f ff ff ff       	jmp    10072e <_quicksort+0x215>
	      hi = right_ptr;
  10081f:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  100826:	e9 03 ff ff ff       	jmp    10072e <_quicksort+0x215>
       for partitions below MAX_THRESH size. BASE_PTR points to the beginning
       of the array to sort, and END_PTR points at the very last element in
       the array (*not* one beyond it!). */
#define min(x, y) ((x) < (y) ? (x) : (y))
    {
	char *const end_ptr = &base_ptr[size * (total_elems - 1)];
  10082b:	4c 8b bd 98 fb ff ff 	mov    -0x468(%rbp),%r15
  100832:	49 83 ef 01          	sub    $0x1,%r15
  100836:	48 8b bd c8 fb ff ff 	mov    -0x438(%rbp),%rdi
  10083d:	4c 0f af ff          	imul   %rdi,%r15
  100841:	4c 8b ad a0 fb ff ff 	mov    -0x460(%rbp),%r13
  100848:	4d 01 ef             	add    %r13,%r15
	char *tmp_ptr = base_ptr;
	char *thresh = min(end_ptr, base_ptr + max_thresh);
  10084b:	48 8b 85 a8 fb ff ff 	mov    -0x458(%rbp),%rax
  100852:	4c 01 e8             	add    %r13,%rax
  100855:	49 39 c7             	cmp    %rax,%r15
  100858:	49 0f 46 c7          	cmovbe %r15,%rax
	char *run_ptr;
	/* Find smallest element in first threshold and place it at the
	   array's beginning.  This is the smallest array element,
	   and the operation speeds up insertion sort's inner loop. */
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  10085c:	4d 89 ec             	mov    %r13,%r12
  10085f:	49 01 fc             	add    %rdi,%r12
  100862:	4c 39 e0             	cmp    %r12,%rax
  100865:	72 66                	jb     1008cd <_quicksort+0x3b4>
  100867:	4d 89 e6             	mov    %r12,%r14
	char *tmp_ptr = base_ptr;
  10086a:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  100871:	49 89 c4             	mov    %rax,%r12
	    if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100874:	4c 89 ee             	mov    %r13,%rsi
  100877:	4c 89 f7             	mov    %r14,%rdi
  10087a:	ff d3                	call   *%rbx
  10087c:	85 c0                	test   %eax,%eax
  10087e:	4d 0f 48 ee          	cmovs  %r14,%r13
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  100882:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  100889:	4d 39 f4             	cmp    %r14,%r12
  10088c:	73 e6                	jae    100874 <_quicksort+0x35b>
  10088e:	4c 8b a5 c0 fb ff ff 	mov    -0x440(%rbp),%r12
		tmp_ptr = run_ptr;
	if (tmp_ptr != base_ptr)
  100895:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  10089c:	49 8d 4c 05 00       	lea    0x0(%r13,%rax,1),%rcx
  1008a1:	48 8b 85 a0 fb ff ff 	mov    -0x460(%rbp),%rax
  1008a8:	4c 3b ad a0 fb ff ff 	cmp    -0x460(%rbp),%r13
  1008af:	74 1c                	je     1008cd <_quicksort+0x3b4>
	    SWAP (tmp_ptr, base_ptr, size);
  1008b1:	41 0f b6 55 00       	movzbl 0x0(%r13),%edx
  1008b6:	49 83 c5 01          	add    $0x1,%r13
  1008ba:	0f b6 30             	movzbl (%rax),%esi
  1008bd:	41 88 75 ff          	mov    %sil,-0x1(%r13)
  1008c1:	48 83 c0 01          	add    $0x1,%rax
  1008c5:	88 50 ff             	mov    %dl,-0x1(%rax)
  1008c8:	49 39 cd             	cmp    %rcx,%r13
  1008cb:	75 e4                	jne    1008b1 <_quicksort+0x398>
	/* Insertion sort, running from left-hand-side up to right-hand-side.  */
	run_ptr = base_ptr + size;
	while ((run_ptr += size) <= end_ptr)
  1008cd:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  1008d4:	4d 8d 34 04          	lea    (%r12,%rax,1),%r14
	{
	    tmp_ptr = run_ptr - size;
  1008d8:	48 f7 d8             	neg    %rax
  1008db:	49 89 c5             	mov    %rax,%r13
	while ((run_ptr += size) <= end_ptr)
  1008de:	4d 39 f7             	cmp    %r14,%r15
  1008e1:	73 15                	jae    1008f8 <_quicksort+0x3df>
		    *hi = c;
		}
	    }
	}
    }
}
  1008e3:	48 81 c4 48 04 00 00 	add    $0x448,%rsp
  1008ea:	5b                   	pop    %rbx
  1008eb:	41 5c                	pop    %r12
  1008ed:	41 5d                	pop    %r13
  1008ef:	41 5e                	pop    %r14
  1008f1:	41 5f                	pop    %r15
  1008f3:	5d                   	pop    %rbp
  1008f4:	c3                   	ret    
		tmp_ptr -= size;
  1008f5:	4d 01 ec             	add    %r13,%r12
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  1008f8:	4c 89 e6             	mov    %r12,%rsi
  1008fb:	4c 89 f7             	mov    %r14,%rdi
  1008fe:	ff d3                	call   *%rbx
  100900:	85 c0                	test   %eax,%eax
  100902:	78 f1                	js     1008f5 <_quicksort+0x3dc>
	    tmp_ptr += size;
  100904:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  10090b:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
	    if (tmp_ptr != run_ptr)
  10090f:	4c 39 f6             	cmp    %r14,%rsi
  100912:	75 17                	jne    10092b <_quicksort+0x412>
	while ((run_ptr += size) <= end_ptr)
  100914:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  10091b:	4c 01 f0             	add    %r14,%rax
  10091e:	4d 89 f4             	mov    %r14,%r12
  100921:	49 39 c7             	cmp    %rax,%r15
  100924:	72 bd                	jb     1008e3 <_quicksort+0x3ca>
  100926:	49 89 c6             	mov    %rax,%r14
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100929:	eb cd                	jmp    1008f8 <_quicksort+0x3df>
		while (--trav >= run_ptr)
  10092b:	49 8d 7c 06 ff       	lea    -0x1(%r14,%rax,1),%rdi
  100930:	4c 39 f7             	cmp    %r14,%rdi
  100933:	72 df                	jb     100914 <_quicksort+0x3fb>
  100935:	4d 8d 46 ff          	lea    -0x1(%r14),%r8
  100939:	4d 89 c2             	mov    %r8,%r10
  10093c:	eb 13                	jmp    100951 <_quicksort+0x438>
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  10093e:	48 89 f9             	mov    %rdi,%rcx
		    *hi = c;
  100941:	44 88 09             	mov    %r9b,(%rcx)
		while (--trav >= run_ptr)
  100944:	48 83 ef 01          	sub    $0x1,%rdi
  100948:	49 83 e8 01          	sub    $0x1,%r8
  10094c:	49 39 fa             	cmp    %rdi,%r10
  10094f:	74 c3                	je     100914 <_quicksort+0x3fb>
		    char c = *trav;
  100951:	44 0f b6 0f          	movzbl (%rdi),%r9d
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100955:	4c 89 c0             	mov    %r8,%rax
  100958:	4c 39 c6             	cmp    %r8,%rsi
  10095b:	77 e1                	ja     10093e <_quicksort+0x425>
  10095d:	48 89 fa             	mov    %rdi,%rdx
			*hi = *lo;
  100960:	0f b6 08             	movzbl (%rax),%ecx
  100963:	88 0a                	mov    %cl,(%rdx)
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100965:	48 89 c1             	mov    %rax,%rcx
  100968:	4c 01 e8             	add    %r13,%rax
  10096b:	48 2b 95 c8 fb ff ff 	sub    -0x438(%rbp),%rdx
  100972:	48 39 c6             	cmp    %rax,%rsi
  100975:	76 e9                	jbe    100960 <_quicksort+0x447>
  100977:	eb c8                	jmp    100941 <_quicksort+0x428>

0000000000100979 <ptr_comparator>:

int ptr_comparator( const void * a, const void * b){
  100979:	f3 0f 1e fa          	endbr64 
    ptr_with_size * a_ptr = (ptr_with_size *) a;
    ptr_with_size * b_ptr = (ptr_with_size *) b;

    return (int)b_ptr->size - (int)a_ptr->size;
  10097d:	48 8b 46 08          	mov    0x8(%rsi),%rax
  100981:	2b 47 08             	sub    0x8(%rdi),%eax
  100984:	c3                   	ret    

0000000000100985 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100985:	f3 0f 1e fa          	endbr64 
  100989:	55                   	push   %rbp
  10098a:	48 89 e5             	mov    %rsp,%rbp
  10098d:	48 83 ec 28          	sub    $0x28,%rsp
  100991:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100995:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100999:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10099d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1009a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1009a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009a9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1009ad:	eb 1c                	jmp    1009cb <memcpy+0x46>
        *d = *s;
  1009af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009b3:	0f b6 10             	movzbl (%rax),%edx
  1009b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1009ba:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1009bc:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1009c1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1009c6:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1009cb:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1009d0:	75 dd                	jne    1009af <memcpy+0x2a>
    }
    return dst;
  1009d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1009d6:	c9                   	leave  
  1009d7:	c3                   	ret    

00000000001009d8 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1009d8:	f3 0f 1e fa          	endbr64 
  1009dc:	55                   	push   %rbp
  1009dd:	48 89 e5             	mov    %rsp,%rbp
  1009e0:	48 83 ec 28          	sub    $0x28,%rsp
  1009e4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1009e8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1009ec:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1009f0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1009f4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1009f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009fc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100a00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a04:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100a08:	73 6a                	jae    100a74 <memmove+0x9c>
  100a0a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100a0e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a12:	48 01 d0             	add    %rdx,%rax
  100a15:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100a19:	73 59                	jae    100a74 <memmove+0x9c>
        s += n, d += n;
  100a1b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a1f:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100a23:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a27:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100a2b:	eb 17                	jmp    100a44 <memmove+0x6c>
            *--d = *--s;
  100a2d:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100a32:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100a37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a3b:	0f b6 10             	movzbl (%rax),%edx
  100a3e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100a42:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100a44:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a48:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100a4c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100a50:	48 85 c0             	test   %rax,%rax
  100a53:	75 d8                	jne    100a2d <memmove+0x55>
    if (s < d && s + n > d) {
  100a55:	eb 2e                	jmp    100a85 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100a57:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100a5b:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100a5f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100a63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100a67:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100a6b:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100a6f:	0f b6 12             	movzbl (%rdx),%edx
  100a72:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100a74:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a78:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100a7c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100a80:	48 85 c0             	test   %rax,%rax
  100a83:	75 d2                	jne    100a57 <memmove+0x7f>
        }
    }
    return dst;
  100a85:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100a89:	c9                   	leave  
  100a8a:	c3                   	ret    

0000000000100a8b <memset>:

void* memset(void* v, int c, size_t n) {
  100a8b:	f3 0f 1e fa          	endbr64 
  100a8f:	55                   	push   %rbp
  100a90:	48 89 e5             	mov    %rsp,%rbp
  100a93:	48 83 ec 28          	sub    $0x28,%rsp
  100a97:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100a9b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100a9e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100aa2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100aa6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100aaa:	eb 15                	jmp    100ac1 <memset+0x36>
        *p = c;
  100aac:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100aaf:	89 c2                	mov    %eax,%edx
  100ab1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ab5:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100ab7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100abc:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100ac1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100ac6:	75 e4                	jne    100aac <memset+0x21>
    }
    return v;
  100ac8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100acc:	c9                   	leave  
  100acd:	c3                   	ret    

0000000000100ace <strlen>:

size_t strlen(const char* s) {
  100ace:	f3 0f 1e fa          	endbr64 
  100ad2:	55                   	push   %rbp
  100ad3:	48 89 e5             	mov    %rsp,%rbp
  100ad6:	48 83 ec 18          	sub    $0x18,%rsp
  100ada:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100ade:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100ae5:	00 
  100ae6:	eb 0a                	jmp    100af2 <strlen+0x24>
        ++n;
  100ae8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100aed:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100af2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100af6:	0f b6 00             	movzbl (%rax),%eax
  100af9:	84 c0                	test   %al,%al
  100afb:	75 eb                	jne    100ae8 <strlen+0x1a>
    }
    return n;
  100afd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100b01:	c9                   	leave  
  100b02:	c3                   	ret    

0000000000100b03 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100b03:	f3 0f 1e fa          	endbr64 
  100b07:	55                   	push   %rbp
  100b08:	48 89 e5             	mov    %rsp,%rbp
  100b0b:	48 83 ec 20          	sub    $0x20,%rsp
  100b0f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100b13:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100b17:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100b1e:	00 
  100b1f:	eb 0a                	jmp    100b2b <strnlen+0x28>
        ++n;
  100b21:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100b26:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100b2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b2f:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100b33:	74 0b                	je     100b40 <strnlen+0x3d>
  100b35:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100b39:	0f b6 00             	movzbl (%rax),%eax
  100b3c:	84 c0                	test   %al,%al
  100b3e:	75 e1                	jne    100b21 <strnlen+0x1e>
    }
    return n;
  100b40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100b44:	c9                   	leave  
  100b45:	c3                   	ret    

0000000000100b46 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100b46:	f3 0f 1e fa          	endbr64 
  100b4a:	55                   	push   %rbp
  100b4b:	48 89 e5             	mov    %rsp,%rbp
  100b4e:	48 83 ec 20          	sub    $0x20,%rsp
  100b52:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100b56:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100b5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100b5e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100b62:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100b66:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100b6a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100b6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b72:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100b76:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100b7a:	0f b6 12             	movzbl (%rdx),%edx
  100b7d:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100b7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b83:	48 83 e8 01          	sub    $0x1,%rax
  100b87:	0f b6 00             	movzbl (%rax),%eax
  100b8a:	84 c0                	test   %al,%al
  100b8c:	75 d4                	jne    100b62 <strcpy+0x1c>
    return dst;
  100b8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100b92:	c9                   	leave  
  100b93:	c3                   	ret    

0000000000100b94 <strcmp>:

int strcmp(const char* a, const char* b) {
  100b94:	f3 0f 1e fa          	endbr64 
  100b98:	55                   	push   %rbp
  100b99:	48 89 e5             	mov    %rsp,%rbp
  100b9c:	48 83 ec 10          	sub    $0x10,%rsp
  100ba0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100ba4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100ba8:	eb 0a                	jmp    100bb4 <strcmp+0x20>
        ++a, ++b;
  100baa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100baf:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100bb4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bb8:	0f b6 00             	movzbl (%rax),%eax
  100bbb:	84 c0                	test   %al,%al
  100bbd:	74 1d                	je     100bdc <strcmp+0x48>
  100bbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100bc3:	0f b6 00             	movzbl (%rax),%eax
  100bc6:	84 c0                	test   %al,%al
  100bc8:	74 12                	je     100bdc <strcmp+0x48>
  100bca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bce:	0f b6 10             	movzbl (%rax),%edx
  100bd1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100bd5:	0f b6 00             	movzbl (%rax),%eax
  100bd8:	38 c2                	cmp    %al,%dl
  100bda:	74 ce                	je     100baa <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100bdc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100be0:	0f b6 00             	movzbl (%rax),%eax
  100be3:	89 c2                	mov    %eax,%edx
  100be5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100be9:	0f b6 00             	movzbl (%rax),%eax
  100bec:	38 c2                	cmp    %al,%dl
  100bee:	0f 97 c0             	seta   %al
  100bf1:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100bf4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bf8:	0f b6 00             	movzbl (%rax),%eax
  100bfb:	89 c1                	mov    %eax,%ecx
  100bfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100c01:	0f b6 00             	movzbl (%rax),%eax
  100c04:	38 c1                	cmp    %al,%cl
  100c06:	0f 92 c0             	setb   %al
  100c09:	0f b6 c8             	movzbl %al,%ecx
  100c0c:	89 d0                	mov    %edx,%eax
  100c0e:	29 c8                	sub    %ecx,%eax
}
  100c10:	c9                   	leave  
  100c11:	c3                   	ret    

0000000000100c12 <strchr>:

char* strchr(const char* s, int c) {
  100c12:	f3 0f 1e fa          	endbr64 
  100c16:	55                   	push   %rbp
  100c17:	48 89 e5             	mov    %rsp,%rbp
  100c1a:	48 83 ec 10          	sub    $0x10,%rsp
  100c1e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100c22:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100c25:	eb 05                	jmp    100c2c <strchr+0x1a>
        ++s;
  100c27:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100c2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c30:	0f b6 00             	movzbl (%rax),%eax
  100c33:	84 c0                	test   %al,%al
  100c35:	74 0e                	je     100c45 <strchr+0x33>
  100c37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c3b:	0f b6 00             	movzbl (%rax),%eax
  100c3e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100c41:	38 d0                	cmp    %dl,%al
  100c43:	75 e2                	jne    100c27 <strchr+0x15>
    }
    if (*s == (char) c) {
  100c45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c49:	0f b6 00             	movzbl (%rax),%eax
  100c4c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100c4f:	38 d0                	cmp    %dl,%al
  100c51:	75 06                	jne    100c59 <strchr+0x47>
        return (char*) s;
  100c53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c57:	eb 05                	jmp    100c5e <strchr+0x4c>
    } else {
        return NULL;
  100c59:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100c5e:	c9                   	leave  
  100c5f:	c3                   	ret    

0000000000100c60 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100c60:	f3 0f 1e fa          	endbr64 
  100c64:	55                   	push   %rbp
  100c65:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100c68:	8b 05 d2 13 00 00    	mov    0x13d2(%rip),%eax        # 102040 <rand_seed_set>
  100c6e:	85 c0                	test   %eax,%eax
  100c70:	75 0a                	jne    100c7c <rand+0x1c>
        srand(819234718U);
  100c72:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100c77:	e8 24 00 00 00       	call   100ca0 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100c7c:	8b 05 c2 13 00 00    	mov    0x13c2(%rip),%eax        # 102044 <rand_seed>
  100c82:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100c88:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100c8d:	89 05 b1 13 00 00    	mov    %eax,0x13b1(%rip)        # 102044 <rand_seed>
    return rand_seed & RAND_MAX;
  100c93:	8b 05 ab 13 00 00    	mov    0x13ab(%rip),%eax        # 102044 <rand_seed>
  100c99:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100c9e:	5d                   	pop    %rbp
  100c9f:	c3                   	ret    

0000000000100ca0 <srand>:

void srand(unsigned seed) {
  100ca0:	f3 0f 1e fa          	endbr64 
  100ca4:	55                   	push   %rbp
  100ca5:	48 89 e5             	mov    %rsp,%rbp
  100ca8:	48 83 ec 08          	sub    $0x8,%rsp
  100cac:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100caf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100cb2:	89 05 8c 13 00 00    	mov    %eax,0x138c(%rip)        # 102044 <rand_seed>
    rand_seed_set = 1;
  100cb8:	c7 05 7e 13 00 00 01 	movl   $0x1,0x137e(%rip)        # 102040 <rand_seed_set>
  100cbf:	00 00 00 
}
  100cc2:	90                   	nop
  100cc3:	c9                   	leave  
  100cc4:	c3                   	ret    

0000000000100cc5 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100cc5:	f3 0f 1e fa          	endbr64 
  100cc9:	55                   	push   %rbp
  100cca:	48 89 e5             	mov    %rsp,%rbp
  100ccd:	48 83 ec 28          	sub    $0x28,%rsp
  100cd1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100cd5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100cd9:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100cdc:	48 8d 05 ad 0e 00 00 	lea    0xead(%rip),%rax        # 101b90 <upper_digits.1>
  100ce3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  100ce7:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100ceb:	79 0e                	jns    100cfb <fill_numbuf+0x36>
        digits = lower_digits;
  100ced:	48 8d 05 bc 0e 00 00 	lea    0xebc(%rip),%rax        # 101bb0 <lower_digits.0>
  100cf4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  100cf8:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100cfb:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100d00:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100d04:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100d07:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100d0a:	48 63 c8             	movslq %eax,%rcx
  100d0d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100d11:	ba 00 00 00 00       	mov    $0x0,%edx
  100d16:	48 f7 f1             	div    %rcx
  100d19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d1d:	48 01 d0             	add    %rdx,%rax
  100d20:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100d25:	0f b6 10             	movzbl (%rax),%edx
  100d28:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100d2c:	88 10                	mov    %dl,(%rax)
        val /= base;
  100d2e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100d31:	48 63 f0             	movslq %eax,%rsi
  100d34:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100d38:	ba 00 00 00 00       	mov    $0x0,%edx
  100d3d:	48 f7 f6             	div    %rsi
  100d40:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100d44:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100d49:	75 bc                	jne    100d07 <fill_numbuf+0x42>
    return numbuf_end;
  100d4b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100d4f:	c9                   	leave  
  100d50:	c3                   	ret    

0000000000100d51 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100d51:	f3 0f 1e fa          	endbr64 
  100d55:	55                   	push   %rbp
  100d56:	48 89 e5             	mov    %rsp,%rbp
  100d59:	53                   	push   %rbx
  100d5a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100d61:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100d68:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100d6e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100d75:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100d7c:	e9 bd 09 00 00       	jmp    10173e <printer_vprintf+0x9ed>
        if (*format != '%') {
  100d81:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d88:	0f b6 00             	movzbl (%rax),%eax
  100d8b:	3c 25                	cmp    $0x25,%al
  100d8d:	74 31                	je     100dc0 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  100d8f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d96:	4c 8b 00             	mov    (%rax),%r8
  100d99:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100da0:	0f b6 00             	movzbl (%rax),%eax
  100da3:	0f b6 c8             	movzbl %al,%ecx
  100da6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100dac:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100db3:	89 ce                	mov    %ecx,%esi
  100db5:	48 89 c7             	mov    %rax,%rdi
  100db8:	41 ff d0             	call   *%r8
            continue;
  100dbb:	e9 76 09 00 00       	jmp    101736 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  100dc0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100dc7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100dce:	01 
  100dcf:	eb 4d                	jmp    100e1e <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  100dd1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dd8:	0f b6 00             	movzbl (%rax),%eax
  100ddb:	0f be c0             	movsbl %al,%eax
  100dde:	89 c6                	mov    %eax,%esi
  100de0:	48 8d 05 a9 0c 00 00 	lea    0xca9(%rip),%rax        # 101a90 <flag_chars>
  100de7:	48 89 c7             	mov    %rax,%rdi
  100dea:	e8 23 fe ff ff       	call   100c12 <strchr>
  100def:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100df3:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100df8:	74 34                	je     100e2e <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  100dfa:	48 8d 15 8f 0c 00 00 	lea    0xc8f(%rip),%rdx        # 101a90 <flag_chars>
  100e01:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100e05:	48 29 d0             	sub    %rdx,%rax
  100e08:	ba 01 00 00 00       	mov    $0x1,%edx
  100e0d:	89 c1                	mov    %eax,%ecx
  100e0f:	d3 e2                	shl    %cl,%edx
  100e11:	89 d0                	mov    %edx,%eax
  100e13:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100e16:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100e1d:	01 
  100e1e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e25:	0f b6 00             	movzbl (%rax),%eax
  100e28:	84 c0                	test   %al,%al
  100e2a:	75 a5                	jne    100dd1 <printer_vprintf+0x80>
  100e2c:	eb 01                	jmp    100e2f <printer_vprintf+0xde>
            } else {
                break;
  100e2e:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100e2f:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100e36:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e3d:	0f b6 00             	movzbl (%rax),%eax
  100e40:	3c 30                	cmp    $0x30,%al
  100e42:	7e 67                	jle    100eab <printer_vprintf+0x15a>
  100e44:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e4b:	0f b6 00             	movzbl (%rax),%eax
  100e4e:	3c 39                	cmp    $0x39,%al
  100e50:	7f 59                	jg     100eab <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100e52:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100e59:	eb 2e                	jmp    100e89 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  100e5b:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100e5e:	89 d0                	mov    %edx,%eax
  100e60:	c1 e0 02             	shl    $0x2,%eax
  100e63:	01 d0                	add    %edx,%eax
  100e65:	01 c0                	add    %eax,%eax
  100e67:	89 c1                	mov    %eax,%ecx
  100e69:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e70:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100e74:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100e7b:	0f b6 00             	movzbl (%rax),%eax
  100e7e:	0f be c0             	movsbl %al,%eax
  100e81:	01 c8                	add    %ecx,%eax
  100e83:	83 e8 30             	sub    $0x30,%eax
  100e86:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100e89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e90:	0f b6 00             	movzbl (%rax),%eax
  100e93:	3c 2f                	cmp    $0x2f,%al
  100e95:	0f 8e 85 00 00 00    	jle    100f20 <printer_vprintf+0x1cf>
  100e9b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ea2:	0f b6 00             	movzbl (%rax),%eax
  100ea5:	3c 39                	cmp    $0x39,%al
  100ea7:	7e b2                	jle    100e5b <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  100ea9:	eb 75                	jmp    100f20 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  100eab:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100eb2:	0f b6 00             	movzbl (%rax),%eax
  100eb5:	3c 2a                	cmp    $0x2a,%al
  100eb7:	75 68                	jne    100f21 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  100eb9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ec0:	8b 00                	mov    (%rax),%eax
  100ec2:	83 f8 2f             	cmp    $0x2f,%eax
  100ec5:	77 30                	ja     100ef7 <printer_vprintf+0x1a6>
  100ec7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ece:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ed2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ed9:	8b 00                	mov    (%rax),%eax
  100edb:	89 c0                	mov    %eax,%eax
  100edd:	48 01 d0             	add    %rdx,%rax
  100ee0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ee7:	8b 12                	mov    (%rdx),%edx
  100ee9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100eec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ef3:	89 0a                	mov    %ecx,(%rdx)
  100ef5:	eb 1a                	jmp    100f11 <printer_vprintf+0x1c0>
  100ef7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100efe:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f02:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f06:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f0d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f11:	8b 00                	mov    (%rax),%eax
  100f13:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100f16:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f1d:	01 
  100f1e:	eb 01                	jmp    100f21 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  100f20:	90                   	nop
        }

        // process precision
        int precision = -1;
  100f21:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100f28:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f2f:	0f b6 00             	movzbl (%rax),%eax
  100f32:	3c 2e                	cmp    $0x2e,%al
  100f34:	0f 85 00 01 00 00    	jne    10103a <printer_vprintf+0x2e9>
            ++format;
  100f3a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f41:	01 
            if (*format >= '0' && *format <= '9') {
  100f42:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f49:	0f b6 00             	movzbl (%rax),%eax
  100f4c:	3c 2f                	cmp    $0x2f,%al
  100f4e:	7e 67                	jle    100fb7 <printer_vprintf+0x266>
  100f50:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f57:	0f b6 00             	movzbl (%rax),%eax
  100f5a:	3c 39                	cmp    $0x39,%al
  100f5c:	7f 59                	jg     100fb7 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100f5e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100f65:	eb 2e                	jmp    100f95 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  100f67:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100f6a:	89 d0                	mov    %edx,%eax
  100f6c:	c1 e0 02             	shl    $0x2,%eax
  100f6f:	01 d0                	add    %edx,%eax
  100f71:	01 c0                	add    %eax,%eax
  100f73:	89 c1                	mov    %eax,%ecx
  100f75:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f7c:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100f80:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100f87:	0f b6 00             	movzbl (%rax),%eax
  100f8a:	0f be c0             	movsbl %al,%eax
  100f8d:	01 c8                	add    %ecx,%eax
  100f8f:	83 e8 30             	sub    $0x30,%eax
  100f92:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100f95:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f9c:	0f b6 00             	movzbl (%rax),%eax
  100f9f:	3c 2f                	cmp    $0x2f,%al
  100fa1:	0f 8e 85 00 00 00    	jle    10102c <printer_vprintf+0x2db>
  100fa7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100fae:	0f b6 00             	movzbl (%rax),%eax
  100fb1:	3c 39                	cmp    $0x39,%al
  100fb3:	7e b2                	jle    100f67 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  100fb5:	eb 75                	jmp    10102c <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  100fb7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100fbe:	0f b6 00             	movzbl (%rax),%eax
  100fc1:	3c 2a                	cmp    $0x2a,%al
  100fc3:	75 68                	jne    10102d <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  100fc5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fcc:	8b 00                	mov    (%rax),%eax
  100fce:	83 f8 2f             	cmp    $0x2f,%eax
  100fd1:	77 30                	ja     101003 <printer_vprintf+0x2b2>
  100fd3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fda:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fde:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fe5:	8b 00                	mov    (%rax),%eax
  100fe7:	89 c0                	mov    %eax,%eax
  100fe9:	48 01 d0             	add    %rdx,%rax
  100fec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ff3:	8b 12                	mov    (%rdx),%edx
  100ff5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ff8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fff:	89 0a                	mov    %ecx,(%rdx)
  101001:	eb 1a                	jmp    10101d <printer_vprintf+0x2cc>
  101003:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10100a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10100e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101012:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101019:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10101d:	8b 00                	mov    (%rax),%eax
  10101f:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  101022:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101029:	01 
  10102a:	eb 01                	jmp    10102d <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  10102c:	90                   	nop
            }
            if (precision < 0) {
  10102d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101031:	79 07                	jns    10103a <printer_vprintf+0x2e9>
                precision = 0;
  101033:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  10103a:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  101041:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  101048:	00 
        int length = 0;
  101049:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  101050:	48 8d 05 3f 0a 00 00 	lea    0xa3f(%rip),%rax        # 101a96 <flag_chars+0x6>
  101057:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  10105b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101062:	0f b6 00             	movzbl (%rax),%eax
  101065:	0f be c0             	movsbl %al,%eax
  101068:	83 e8 43             	sub    $0x43,%eax
  10106b:	83 f8 37             	cmp    $0x37,%eax
  10106e:	0f 87 b6 03 00 00    	ja     10142a <printer_vprintf+0x6d9>
  101074:	89 c0                	mov    %eax,%eax
  101076:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  10107d:	00 
  10107e:	48 8d 05 1f 0a 00 00 	lea    0xa1f(%rip),%rax        # 101aa4 <flag_chars+0x14>
  101085:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  101088:	48 98                	cltq   
  10108a:	48 8d 15 13 0a 00 00 	lea    0xa13(%rip),%rdx        # 101aa4 <flag_chars+0x14>
  101091:	48 01 d0             	add    %rdx,%rax
  101094:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  101097:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  10109e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1010a5:	01 
            goto again;
  1010a6:	eb b3                	jmp    10105b <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1010a8:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1010ac:	74 5d                	je     10110b <printer_vprintf+0x3ba>
  1010ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010b5:	8b 00                	mov    (%rax),%eax
  1010b7:	83 f8 2f             	cmp    $0x2f,%eax
  1010ba:	77 30                	ja     1010ec <printer_vprintf+0x39b>
  1010bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010c3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010c7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010ce:	8b 00                	mov    (%rax),%eax
  1010d0:	89 c0                	mov    %eax,%eax
  1010d2:	48 01 d0             	add    %rdx,%rax
  1010d5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010dc:	8b 12                	mov    (%rdx),%edx
  1010de:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010e1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010e8:	89 0a                	mov    %ecx,(%rdx)
  1010ea:	eb 1a                	jmp    101106 <printer_vprintf+0x3b5>
  1010ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010f3:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010f7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010fb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101102:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101106:	48 8b 00             	mov    (%rax),%rax
  101109:	eb 5c                	jmp    101167 <printer_vprintf+0x416>
  10110b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101112:	8b 00                	mov    (%rax),%eax
  101114:	83 f8 2f             	cmp    $0x2f,%eax
  101117:	77 30                	ja     101149 <printer_vprintf+0x3f8>
  101119:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101120:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101124:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10112b:	8b 00                	mov    (%rax),%eax
  10112d:	89 c0                	mov    %eax,%eax
  10112f:	48 01 d0             	add    %rdx,%rax
  101132:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101139:	8b 12                	mov    (%rdx),%edx
  10113b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10113e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101145:	89 0a                	mov    %ecx,(%rdx)
  101147:	eb 1a                	jmp    101163 <printer_vprintf+0x412>
  101149:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101150:	48 8b 40 08          	mov    0x8(%rax),%rax
  101154:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101158:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10115f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101163:	8b 00                	mov    (%rax),%eax
  101165:	48 98                	cltq   
  101167:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  10116b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10116f:	48 c1 f8 38          	sar    $0x38,%rax
  101173:	25 80 00 00 00       	and    $0x80,%eax
  101178:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  10117b:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  10117f:	74 09                	je     10118a <printer_vprintf+0x439>
  101181:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101185:	48 f7 d8             	neg    %rax
  101188:	eb 04                	jmp    10118e <printer_vprintf+0x43d>
  10118a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10118e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  101192:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  101195:	83 c8 60             	or     $0x60,%eax
  101198:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  10119b:	e9 cf 02 00 00       	jmp    10146f <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1011a0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1011a4:	74 5d                	je     101203 <printer_vprintf+0x4b2>
  1011a6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011ad:	8b 00                	mov    (%rax),%eax
  1011af:	83 f8 2f             	cmp    $0x2f,%eax
  1011b2:	77 30                	ja     1011e4 <printer_vprintf+0x493>
  1011b4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011bb:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1011bf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011c6:	8b 00                	mov    (%rax),%eax
  1011c8:	89 c0                	mov    %eax,%eax
  1011ca:	48 01 d0             	add    %rdx,%rax
  1011cd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011d4:	8b 12                	mov    (%rdx),%edx
  1011d6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1011d9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011e0:	89 0a                	mov    %ecx,(%rdx)
  1011e2:	eb 1a                	jmp    1011fe <printer_vprintf+0x4ad>
  1011e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011eb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011ef:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1011f3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011fa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011fe:	48 8b 00             	mov    (%rax),%rax
  101201:	eb 5c                	jmp    10125f <printer_vprintf+0x50e>
  101203:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10120a:	8b 00                	mov    (%rax),%eax
  10120c:	83 f8 2f             	cmp    $0x2f,%eax
  10120f:	77 30                	ja     101241 <printer_vprintf+0x4f0>
  101211:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101218:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10121c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101223:	8b 00                	mov    (%rax),%eax
  101225:	89 c0                	mov    %eax,%eax
  101227:	48 01 d0             	add    %rdx,%rax
  10122a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101231:	8b 12                	mov    (%rdx),%edx
  101233:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101236:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10123d:	89 0a                	mov    %ecx,(%rdx)
  10123f:	eb 1a                	jmp    10125b <printer_vprintf+0x50a>
  101241:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101248:	48 8b 40 08          	mov    0x8(%rax),%rax
  10124c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101250:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101257:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10125b:	8b 00                	mov    (%rax),%eax
  10125d:	89 c0                	mov    %eax,%eax
  10125f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  101263:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  101267:	e9 03 02 00 00       	jmp    10146f <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  10126c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  101273:	e9 28 ff ff ff       	jmp    1011a0 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  101278:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  10127f:	e9 1c ff ff ff       	jmp    1011a0 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  101284:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10128b:	8b 00                	mov    (%rax),%eax
  10128d:	83 f8 2f             	cmp    $0x2f,%eax
  101290:	77 30                	ja     1012c2 <printer_vprintf+0x571>
  101292:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101299:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10129d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012a4:	8b 00                	mov    (%rax),%eax
  1012a6:	89 c0                	mov    %eax,%eax
  1012a8:	48 01 d0             	add    %rdx,%rax
  1012ab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012b2:	8b 12                	mov    (%rdx),%edx
  1012b4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1012b7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012be:	89 0a                	mov    %ecx,(%rdx)
  1012c0:	eb 1a                	jmp    1012dc <printer_vprintf+0x58b>
  1012c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012c9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012cd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1012d1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012d8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012dc:	48 8b 00             	mov    (%rax),%rax
  1012df:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1012e3:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1012ea:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  1012f1:	e9 79 01 00 00       	jmp    10146f <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  1012f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012fd:	8b 00                	mov    (%rax),%eax
  1012ff:	83 f8 2f             	cmp    $0x2f,%eax
  101302:	77 30                	ja     101334 <printer_vprintf+0x5e3>
  101304:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10130b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10130f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101316:	8b 00                	mov    (%rax),%eax
  101318:	89 c0                	mov    %eax,%eax
  10131a:	48 01 d0             	add    %rdx,%rax
  10131d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101324:	8b 12                	mov    (%rdx),%edx
  101326:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101329:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101330:	89 0a                	mov    %ecx,(%rdx)
  101332:	eb 1a                	jmp    10134e <printer_vprintf+0x5fd>
  101334:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10133b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10133f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101343:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10134a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10134e:	48 8b 00             	mov    (%rax),%rax
  101351:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  101355:	e9 15 01 00 00       	jmp    10146f <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  10135a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101361:	8b 00                	mov    (%rax),%eax
  101363:	83 f8 2f             	cmp    $0x2f,%eax
  101366:	77 30                	ja     101398 <printer_vprintf+0x647>
  101368:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10136f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101373:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10137a:	8b 00                	mov    (%rax),%eax
  10137c:	89 c0                	mov    %eax,%eax
  10137e:	48 01 d0             	add    %rdx,%rax
  101381:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101388:	8b 12                	mov    (%rdx),%edx
  10138a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10138d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101394:	89 0a                	mov    %ecx,(%rdx)
  101396:	eb 1a                	jmp    1013b2 <printer_vprintf+0x661>
  101398:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10139f:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013a3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1013a7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013ae:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1013b2:	8b 00                	mov    (%rax),%eax
  1013b4:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  1013ba:	e9 77 03 00 00       	jmp    101736 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  1013bf:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1013c3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  1013c7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013ce:	8b 00                	mov    (%rax),%eax
  1013d0:	83 f8 2f             	cmp    $0x2f,%eax
  1013d3:	77 30                	ja     101405 <printer_vprintf+0x6b4>
  1013d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013dc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1013e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013e7:	8b 00                	mov    (%rax),%eax
  1013e9:	89 c0                	mov    %eax,%eax
  1013eb:	48 01 d0             	add    %rdx,%rax
  1013ee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013f5:	8b 12                	mov    (%rdx),%edx
  1013f7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1013fa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101401:	89 0a                	mov    %ecx,(%rdx)
  101403:	eb 1a                	jmp    10141f <printer_vprintf+0x6ce>
  101405:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10140c:	48 8b 40 08          	mov    0x8(%rax),%rax
  101410:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101414:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10141b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10141f:	8b 00                	mov    (%rax),%eax
  101421:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101424:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  101428:	eb 45                	jmp    10146f <printer_vprintf+0x71e>
        default:
            data = numbuf;
  10142a:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10142e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  101432:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101439:	0f b6 00             	movzbl (%rax),%eax
  10143c:	84 c0                	test   %al,%al
  10143e:	74 0c                	je     10144c <printer_vprintf+0x6fb>
  101440:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101447:	0f b6 00             	movzbl (%rax),%eax
  10144a:	eb 05                	jmp    101451 <printer_vprintf+0x700>
  10144c:	b8 25 00 00 00       	mov    $0x25,%eax
  101451:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101454:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  101458:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10145f:	0f b6 00             	movzbl (%rax),%eax
  101462:	84 c0                	test   %al,%al
  101464:	75 08                	jne    10146e <printer_vprintf+0x71d>
                format--;
  101466:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  10146d:	01 
            }
            break;
  10146e:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  10146f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101472:	83 e0 20             	and    $0x20,%eax
  101475:	85 c0                	test   %eax,%eax
  101477:	74 1e                	je     101497 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101479:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10147d:	48 83 c0 18          	add    $0x18,%rax
  101481:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101484:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101488:	48 89 ce             	mov    %rcx,%rsi
  10148b:	48 89 c7             	mov    %rax,%rdi
  10148e:	e8 32 f8 ff ff       	call   100cc5 <fill_numbuf>
  101493:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  101497:	48 8d 05 f8 05 00 00 	lea    0x5f8(%rip),%rax        # 101a96 <flag_chars+0x6>
  10149e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1014a2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014a5:	83 e0 20             	and    $0x20,%eax
  1014a8:	85 c0                	test   %eax,%eax
  1014aa:	74 51                	je     1014fd <printer_vprintf+0x7ac>
  1014ac:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014af:	83 e0 40             	and    $0x40,%eax
  1014b2:	85 c0                	test   %eax,%eax
  1014b4:	74 47                	je     1014fd <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  1014b6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014b9:	25 80 00 00 00       	and    $0x80,%eax
  1014be:	85 c0                	test   %eax,%eax
  1014c0:	74 0d                	je     1014cf <printer_vprintf+0x77e>
                prefix = "-";
  1014c2:	48 8d 05 ce 05 00 00 	lea    0x5ce(%rip),%rax        # 101a97 <flag_chars+0x7>
  1014c9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1014cd:	eb 7d                	jmp    10154c <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1014cf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014d2:	83 e0 10             	and    $0x10,%eax
  1014d5:	85 c0                	test   %eax,%eax
  1014d7:	74 0d                	je     1014e6 <printer_vprintf+0x795>
                prefix = "+";
  1014d9:	48 8d 05 b9 05 00 00 	lea    0x5b9(%rip),%rax        # 101a99 <flag_chars+0x9>
  1014e0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1014e4:	eb 66                	jmp    10154c <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  1014e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014e9:	83 e0 08             	and    $0x8,%eax
  1014ec:	85 c0                	test   %eax,%eax
  1014ee:	74 5c                	je     10154c <printer_vprintf+0x7fb>
                prefix = " ";
  1014f0:	48 8d 05 a4 05 00 00 	lea    0x5a4(%rip),%rax        # 101a9b <flag_chars+0xb>
  1014f7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1014fb:	eb 4f                	jmp    10154c <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1014fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101500:	83 e0 20             	and    $0x20,%eax
  101503:	85 c0                	test   %eax,%eax
  101505:	74 46                	je     10154d <printer_vprintf+0x7fc>
  101507:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10150a:	83 e0 01             	and    $0x1,%eax
  10150d:	85 c0                	test   %eax,%eax
  10150f:	74 3c                	je     10154d <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  101511:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  101515:	74 06                	je     10151d <printer_vprintf+0x7cc>
  101517:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  10151b:	75 30                	jne    10154d <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  10151d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  101522:	75 0c                	jne    101530 <printer_vprintf+0x7df>
  101524:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101527:	25 00 01 00 00       	and    $0x100,%eax
  10152c:	85 c0                	test   %eax,%eax
  10152e:	74 1d                	je     10154d <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  101530:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101534:	75 09                	jne    10153f <printer_vprintf+0x7ee>
  101536:	48 8d 05 60 05 00 00 	lea    0x560(%rip),%rax        # 101a9d <flag_chars+0xd>
  10153d:	eb 07                	jmp    101546 <printer_vprintf+0x7f5>
  10153f:	48 8d 05 5a 05 00 00 	lea    0x55a(%rip),%rax        # 101aa0 <flag_chars+0x10>
  101546:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10154a:	eb 01                	jmp    10154d <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  10154c:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  10154d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101551:	78 24                	js     101577 <printer_vprintf+0x826>
  101553:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101556:	83 e0 20             	and    $0x20,%eax
  101559:	85 c0                	test   %eax,%eax
  10155b:	75 1a                	jne    101577 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  10155d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101560:	48 63 d0             	movslq %eax,%rdx
  101563:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101567:	48 89 d6             	mov    %rdx,%rsi
  10156a:	48 89 c7             	mov    %rax,%rdi
  10156d:	e8 91 f5 ff ff       	call   100b03 <strnlen>
  101572:	89 45 bc             	mov    %eax,-0x44(%rbp)
  101575:	eb 0f                	jmp    101586 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  101577:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10157b:	48 89 c7             	mov    %rax,%rdi
  10157e:	e8 4b f5 ff ff       	call   100ace <strlen>
  101583:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  101586:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101589:	83 e0 20             	and    $0x20,%eax
  10158c:	85 c0                	test   %eax,%eax
  10158e:	74 20                	je     1015b0 <printer_vprintf+0x85f>
  101590:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101594:	78 1a                	js     1015b0 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  101596:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101599:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  10159c:	7e 08                	jle    1015a6 <printer_vprintf+0x855>
  10159e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1015a1:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1015a4:	eb 05                	jmp    1015ab <printer_vprintf+0x85a>
  1015a6:	b8 00 00 00 00       	mov    $0x0,%eax
  1015ab:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1015ae:	eb 5c                	jmp    10160c <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1015b0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015b3:	83 e0 20             	and    $0x20,%eax
  1015b6:	85 c0                	test   %eax,%eax
  1015b8:	74 4b                	je     101605 <printer_vprintf+0x8b4>
  1015ba:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015bd:	83 e0 02             	and    $0x2,%eax
  1015c0:	85 c0                	test   %eax,%eax
  1015c2:	74 41                	je     101605 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1015c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015c7:	83 e0 04             	and    $0x4,%eax
  1015ca:	85 c0                	test   %eax,%eax
  1015cc:	75 37                	jne    101605 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  1015ce:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1015d2:	48 89 c7             	mov    %rax,%rdi
  1015d5:	e8 f4 f4 ff ff       	call   100ace <strlen>
  1015da:	89 c2                	mov    %eax,%edx
  1015dc:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1015df:	01 d0                	add    %edx,%eax
  1015e1:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  1015e4:	7e 1f                	jle    101605 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  1015e6:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1015e9:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1015ec:	89 c3                	mov    %eax,%ebx
  1015ee:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1015f2:	48 89 c7             	mov    %rax,%rdi
  1015f5:	e8 d4 f4 ff ff       	call   100ace <strlen>
  1015fa:	89 c2                	mov    %eax,%edx
  1015fc:	89 d8                	mov    %ebx,%eax
  1015fe:	29 d0                	sub    %edx,%eax
  101600:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101603:	eb 07                	jmp    10160c <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  101605:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  10160c:	8b 55 bc             	mov    -0x44(%rbp),%edx
  10160f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101612:	01 d0                	add    %edx,%eax
  101614:	48 63 d8             	movslq %eax,%rbx
  101617:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10161b:	48 89 c7             	mov    %rax,%rdi
  10161e:	e8 ab f4 ff ff       	call   100ace <strlen>
  101623:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  101627:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10162a:	29 d0                	sub    %edx,%eax
  10162c:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10162f:	eb 25                	jmp    101656 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  101631:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101638:	48 8b 08             	mov    (%rax),%rcx
  10163b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101641:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101648:	be 20 00 00 00       	mov    $0x20,%esi
  10164d:	48 89 c7             	mov    %rax,%rdi
  101650:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101652:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101656:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101659:	83 e0 04             	and    $0x4,%eax
  10165c:	85 c0                	test   %eax,%eax
  10165e:	75 36                	jne    101696 <printer_vprintf+0x945>
  101660:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101664:	7f cb                	jg     101631 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  101666:	eb 2e                	jmp    101696 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  101668:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10166f:	4c 8b 00             	mov    (%rax),%r8
  101672:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101676:	0f b6 00             	movzbl (%rax),%eax
  101679:	0f b6 c8             	movzbl %al,%ecx
  10167c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101682:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101689:	89 ce                	mov    %ecx,%esi
  10168b:	48 89 c7             	mov    %rax,%rdi
  10168e:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101691:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101696:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10169a:	0f b6 00             	movzbl (%rax),%eax
  10169d:	84 c0                	test   %al,%al
  10169f:	75 c7                	jne    101668 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  1016a1:	eb 25                	jmp    1016c8 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  1016a3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1016aa:	48 8b 08             	mov    (%rax),%rcx
  1016ad:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1016b3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1016ba:	be 30 00 00 00       	mov    $0x30,%esi
  1016bf:	48 89 c7             	mov    %rax,%rdi
  1016c2:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1016c4:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1016c8:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1016cc:	7f d5                	jg     1016a3 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  1016ce:	eb 32                	jmp    101702 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  1016d0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1016d7:	4c 8b 00             	mov    (%rax),%r8
  1016da:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1016de:	0f b6 00             	movzbl (%rax),%eax
  1016e1:	0f b6 c8             	movzbl %al,%ecx
  1016e4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1016ea:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1016f1:	89 ce                	mov    %ecx,%esi
  1016f3:	48 89 c7             	mov    %rax,%rdi
  1016f6:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  1016f9:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  1016fe:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101702:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101706:	7f c8                	jg     1016d0 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  101708:	eb 25                	jmp    10172f <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  10170a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101711:	48 8b 08             	mov    (%rax),%rcx
  101714:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10171a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101721:	be 20 00 00 00       	mov    $0x20,%esi
  101726:	48 89 c7             	mov    %rax,%rdi
  101729:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  10172b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10172f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101733:	7f d5                	jg     10170a <printer_vprintf+0x9b9>
        }
    done: ;
  101735:	90                   	nop
    for (; *format; ++format) {
  101736:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10173d:	01 
  10173e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101745:	0f b6 00             	movzbl (%rax),%eax
  101748:	84 c0                	test   %al,%al
  10174a:	0f 85 31 f6 ff ff    	jne    100d81 <printer_vprintf+0x30>
    }
}
  101750:	90                   	nop
  101751:	90                   	nop
  101752:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101756:	c9                   	leave  
  101757:	c3                   	ret    

0000000000101758 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101758:	f3 0f 1e fa          	endbr64 
  10175c:	55                   	push   %rbp
  10175d:	48 89 e5             	mov    %rsp,%rbp
  101760:	48 83 ec 20          	sub    $0x20,%rsp
  101764:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101768:	89 f0                	mov    %esi,%eax
  10176a:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10176d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101770:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101774:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101778:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10177c:	48 8b 40 08          	mov    0x8(%rax),%rax
  101780:	48 8d 15 19 78 fb ff 	lea    -0x487e7(%rip),%rdx        # b8fa0 <console+0xfa0>
  101787:	48 39 d0             	cmp    %rdx,%rax
  10178a:	72 0f                	jb     10179b <console_putc+0x43>
        cp->cursor = console;
  10178c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101790:	48 8d 15 69 68 fb ff 	lea    -0x49797(%rip),%rdx        # b8000 <console>
  101797:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  10179b:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10179f:	0f 85 82 00 00 00    	jne    101827 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  1017a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1017a9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1017ad:	48 8d 15 4c 68 fb ff 	lea    -0x497b4(%rip),%rdx        # b8000 <console>
  1017b4:	48 29 d0             	sub    %rdx,%rax
  1017b7:	48 d1 f8             	sar    %rax
  1017ba:	48 89 c1             	mov    %rax,%rcx
  1017bd:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1017c4:	66 66 66 
  1017c7:	48 89 c8             	mov    %rcx,%rax
  1017ca:	48 f7 ea             	imul   %rdx
  1017cd:	48 89 d0             	mov    %rdx,%rax
  1017d0:	48 c1 f8 05          	sar    $0x5,%rax
  1017d4:	48 89 ce             	mov    %rcx,%rsi
  1017d7:	48 c1 fe 3f          	sar    $0x3f,%rsi
  1017db:	48 29 f0             	sub    %rsi,%rax
  1017de:	48 89 c2             	mov    %rax,%rdx
  1017e1:	48 89 d0             	mov    %rdx,%rax
  1017e4:	48 c1 e0 02          	shl    $0x2,%rax
  1017e8:	48 01 d0             	add    %rdx,%rax
  1017eb:	48 c1 e0 04          	shl    $0x4,%rax
  1017ef:	48 29 c1             	sub    %rax,%rcx
  1017f2:	48 89 ca             	mov    %rcx,%rdx
  1017f5:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1017f8:	eb 25                	jmp    10181f <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  1017fa:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1017fd:	83 c8 20             	or     $0x20,%eax
  101800:	89 c6                	mov    %eax,%esi
  101802:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101806:	48 8b 40 08          	mov    0x8(%rax),%rax
  10180a:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10180e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101812:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101816:	89 f2                	mov    %esi,%edx
  101818:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10181b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10181f:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101823:	75 d5                	jne    1017fa <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101825:	eb 24                	jmp    10184b <console_putc+0xf3>
        *cp->cursor++ = c | color;
  101827:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10182b:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10182e:	89 d6                	mov    %edx,%esi
  101830:	09 c6                	or     %eax,%esi
  101832:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101836:	48 8b 40 08          	mov    0x8(%rax),%rax
  10183a:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10183e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101842:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101846:	89 f2                	mov    %esi,%edx
  101848:	66 89 10             	mov    %dx,(%rax)
}
  10184b:	90                   	nop
  10184c:	c9                   	leave  
  10184d:	c3                   	ret    

000000000010184e <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10184e:	f3 0f 1e fa          	endbr64 
  101852:	55                   	push   %rbp
  101853:	48 89 e5             	mov    %rsp,%rbp
  101856:	48 83 ec 30          	sub    $0x30,%rsp
  10185a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10185d:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101860:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101864:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101868:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 101758 <console_putc>
  10186f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101873:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101877:	78 09                	js     101882 <console_vprintf+0x34>
  101879:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101880:	7e 07                	jle    101889 <console_vprintf+0x3b>
        cpos = 0;
  101882:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101889:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10188c:	48 98                	cltq   
  10188e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101892:	48 8d 05 67 67 fb ff 	lea    -0x49899(%rip),%rax        # b8000 <console>
  101899:	48 01 d0             	add    %rdx,%rax
  10189c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1018a0:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1018a4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1018a8:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1018ab:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1018af:	48 89 c7             	mov    %rax,%rdi
  1018b2:	e8 9a f4 ff ff       	call   100d51 <printer_vprintf>
    return cp.cursor - console;
  1018b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1018bb:	48 8d 15 3e 67 fb ff 	lea    -0x498c2(%rip),%rdx        # b8000 <console>
  1018c2:	48 29 d0             	sub    %rdx,%rax
  1018c5:	48 d1 f8             	sar    %rax
}
  1018c8:	c9                   	leave  
  1018c9:	c3                   	ret    

00000000001018ca <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1018ca:	f3 0f 1e fa          	endbr64 
  1018ce:	55                   	push   %rbp
  1018cf:	48 89 e5             	mov    %rsp,%rbp
  1018d2:	48 83 ec 60          	sub    $0x60,%rsp
  1018d6:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1018d9:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1018dc:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1018e0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1018e4:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1018e8:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1018ec:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1018f3:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1018f7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1018fb:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1018ff:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101903:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101907:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10190b:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10190e:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101911:	89 c7                	mov    %eax,%edi
  101913:	e8 36 ff ff ff       	call   10184e <console_vprintf>
  101918:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10191b:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10191e:	c9                   	leave  
  10191f:	c3                   	ret    

0000000000101920 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101920:	f3 0f 1e fa          	endbr64 
  101924:	55                   	push   %rbp
  101925:	48 89 e5             	mov    %rsp,%rbp
  101928:	48 83 ec 20          	sub    $0x20,%rsp
  10192c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101930:	89 f0                	mov    %esi,%eax
  101932:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101935:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101938:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10193c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101940:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101944:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101948:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10194c:	48 8b 40 10          	mov    0x10(%rax),%rax
  101950:	48 39 c2             	cmp    %rax,%rdx
  101953:	73 1a                	jae    10196f <string_putc+0x4f>
        *sp->s++ = c;
  101955:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101959:	48 8b 40 08          	mov    0x8(%rax),%rax
  10195d:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101961:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101965:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101969:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10196d:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  10196f:	90                   	nop
  101970:	c9                   	leave  
  101971:	c3                   	ret    

0000000000101972 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101972:	f3 0f 1e fa          	endbr64 
  101976:	55                   	push   %rbp
  101977:	48 89 e5             	mov    %rsp,%rbp
  10197a:	48 83 ec 40          	sub    $0x40,%rsp
  10197e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101982:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101986:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10198a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10198e:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 101920 <string_putc>
  101995:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  101999:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10199d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1019a1:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1019a6:	74 33                	je     1019db <vsnprintf+0x69>
        sp.end = s + size - 1;
  1019a8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1019ac:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1019b0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1019b4:	48 01 d0             	add    %rdx,%rax
  1019b7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1019bb:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1019bf:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1019c3:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1019c7:	be 00 00 00 00       	mov    $0x0,%esi
  1019cc:	48 89 c7             	mov    %rax,%rdi
  1019cf:	e8 7d f3 ff ff       	call   100d51 <printer_vprintf>
        *sp.s = 0;
  1019d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1019d8:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1019db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1019df:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1019e3:	c9                   	leave  
  1019e4:	c3                   	ret    

00000000001019e5 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1019e5:	f3 0f 1e fa          	endbr64 
  1019e9:	55                   	push   %rbp
  1019ea:	48 89 e5             	mov    %rsp,%rbp
  1019ed:	48 83 ec 70          	sub    $0x70,%rsp
  1019f1:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1019f5:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1019f9:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1019fd:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101a01:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101a05:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101a09:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101a10:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101a14:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101a18:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101a1c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101a20:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101a24:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101a28:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101a2c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101a30:	48 89 c7             	mov    %rax,%rdi
  101a33:	e8 3a ff ff ff       	call   101972 <vsnprintf>
  101a38:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101a3b:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101a3e:	c9                   	leave  
  101a3f:	c3                   	ret    

0000000000101a40 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101a40:	f3 0f 1e fa          	endbr64 
  101a44:	55                   	push   %rbp
  101a45:	48 89 e5             	mov    %rsp,%rbp
  101a48:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101a4c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101a53:	eb 1a                	jmp    101a6f <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101a55:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101a58:	48 98                	cltq   
  101a5a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101a5e:	48 8d 05 9b 65 fb ff 	lea    -0x49a65(%rip),%rax        # b8000 <console>
  101a65:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101a6b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101a6f:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101a76:	7e dd                	jle    101a55 <console_clear+0x15>
    }
    cursorpos = 0;
  101a78:	c7 05 7a 75 fb ff 00 	movl   $0x0,-0x48a86(%rip)        # b8ffc <cursorpos>
  101a7f:	00 00 00 
}
  101a82:	90                   	nop
  101a83:	c9                   	leave  
  101a84:	c3                   	ret    
