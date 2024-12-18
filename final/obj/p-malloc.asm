
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
  100011:	48 8d 05 1f 30 00 00 	lea    0x301f(%rip),%rax        # 103037 <end+0xfff>
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
  10003d:	e8 e0 07 00 00       	call   100822 <rand>
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
  100065:	e8 e9 01 00 00       	call   100253 <malloc>
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
void add_to_free_list(block *b);
void remove_from_free_list(block *b);
void add_to_malloc_list(block *b);
void remove_from_malloclist(block *b);

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
  10008b:	48 8d 7f 18          	lea    0x18(%rdi),%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  10008f:	cd 3a                	int    $0x3a
  100091:	48 89 05 80 1f 00 00 	mov    %rax,0x1f80(%rip)        # 102018 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100098:	48 89 c1             	mov    %rax,%rcx
    if (bptr == (void*) -1) {
  10009b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10009f:	74 16                	je     1000b7 <new_block+0x33>
        return NULL;
    }
    block* nblock = (block*)bptr;
    nblock->size = size;
  1000a1:	48 89 10             	mov    %rdx,(%rax)
    nblock->free = 0;
  1000a4:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
    nblock->next = NULL;
  1000ab:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1000b2:	00 
    return nblock;
}
  1000b3:	48 89 c8             	mov    %rcx,%rax
  1000b6:	c3                   	ret    
        return NULL;
  1000b7:	b9 00 00 00 00       	mov    $0x0,%ecx
  1000bc:	eb f5                	jmp    1000b3 <new_block+0x2f>

00000000001000be <find_block>:

block* find_block(size_t size) {
  1000be:	f3 0f 1e fa          	endbr64 
    block* curr = free_head;
  1000c2:	48 8b 05 5f 1f 00 00 	mov    0x1f5f(%rip),%rax        # 102028 <free_head>
    while (curr) {
  1000c9:	48 85 c0             	test   %rax,%rax
  1000cc:	74 0e                	je     1000dc <find_block+0x1e>
        if (curr->size >= size) {
  1000ce:	48 39 38             	cmp    %rdi,(%rax)
  1000d1:	73 09                	jae    1000dc <find_block+0x1e>
            return curr;
        }
        curr = curr->next;
  1000d3:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (curr) {
  1000d7:	48 85 c0             	test   %rax,%rax
  1000da:	75 f2                	jne    1000ce <find_block+0x10>
    }
    return NULL;
}
  1000dc:	c3                   	ret    

00000000001000dd <add_to_free_list>:
    b->size = size;
    add_to_free_list(new);
    return new;
}

void add_to_free_list(block *b) {
  1000dd:	f3 0f 1e fa          	endbr64 
    // insert in order of address
    if (!free_head) {
  1000e1:	48 8b 05 40 1f 00 00 	mov    0x1f40(%rip),%rax        # 102028 <free_head>
  1000e8:	48 85 c0             	test   %rax,%rax
  1000eb:	74 1f                	je     10010c <add_to_free_list+0x2f>
        free_head = b;
        return;
    }
    if (b < free_head) {
  1000ed:	48 39 f8             	cmp    %rdi,%rax
  1000f0:	77 22                	ja     100114 <add_to_free_list+0x37>
        b->next = free_head;
        free_head = b;
        return;
    }
    block *curr = free_head;
    while (curr->next && curr->next < b) {
  1000f2:	48 89 c2             	mov    %rax,%rdx
  1000f5:	48 8b 40 08          	mov    0x8(%rax),%rax
  1000f9:	48 39 f8             	cmp    %rdi,%rax
  1000fc:	73 05                	jae    100103 <add_to_free_list+0x26>
  1000fe:	48 85 c0             	test   %rax,%rax
  100101:	75 ef                	jne    1000f2 <add_to_free_list+0x15>
        curr = curr->next;
    }
    b->next = curr->next;
  100103:	48 89 47 08          	mov    %rax,0x8(%rdi)
    curr->next = b;
  100107:	48 89 7a 08          	mov    %rdi,0x8(%rdx)



}
  10010b:	c3                   	ret    
        free_head = b;
  10010c:	48 89 3d 15 1f 00 00 	mov    %rdi,0x1f15(%rip)        # 102028 <free_head>
        return;
  100113:	c3                   	ret    
        b->next = free_head;
  100114:	48 89 47 08          	mov    %rax,0x8(%rdi)
        free_head = b;
  100118:	48 89 3d 09 1f 00 00 	mov    %rdi,0x1f09(%rip)        # 102028 <free_head>
        return;
  10011f:	c3                   	ret    

0000000000100120 <split_block>:
block* split_block(block* b, size_t size){
  100120:	f3 0f 1e fa          	endbr64 
  100124:	55                   	push   %rbp
  100125:	48 89 e5             	mov    %rsp,%rbp
  100128:	53                   	push   %rbx
  100129:	48 83 ec 08          	sub    $0x8,%rsp
    if (b->size < size + BLOCKSIZE) {
  10012d:	48 8b 07             	mov    (%rdi),%rax
  100130:	48 8d 56 18          	lea    0x18(%rsi),%rdx
        return NULL;
  100134:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (b->size < size + BLOCKSIZE) {
  100139:	48 39 d0             	cmp    %rdx,%rax
  10013c:	72 28                	jb     100166 <split_block+0x46>
    void* nptr = (void*)b + BLOCKSIZE + size;
  10013e:	48 8d 1c 17          	lea    (%rdi,%rdx,1),%rbx
    new->size = b->size - size - BLOCKSIZE;
  100142:	48 29 f0             	sub    %rsi,%rax
  100145:	48 8d 40 e8          	lea    -0x18(%rax),%rax
  100149:	48 89 03             	mov    %rax,(%rbx)
    new->free = 1;
  10014c:	c7 43 10 01 00 00 00 	movl   $0x1,0x10(%rbx)
    new->next = NULL;
  100153:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  10015a:	00 
    b->size = size;
  10015b:	48 89 37             	mov    %rsi,(%rdi)
    add_to_free_list(new);
  10015e:	48 89 df             	mov    %rbx,%rdi
  100161:	e8 77 ff ff ff       	call   1000dd <add_to_free_list>
}
  100166:	48 89 d8             	mov    %rbx,%rax
  100169:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10016d:	c9                   	leave  
  10016e:	c3                   	ret    

000000000010016f <remove_from_free_list>:

void remove_from_free_list(block *b) {
  10016f:	f3 0f 1e fa          	endbr64 
    if (free_head == b) {
  100173:	48 8b 05 ae 1e 00 00 	mov    0x1eae(%rip),%rax        # 102028 <free_head>
  10017a:	48 39 f8             	cmp    %rdi,%rax
  10017d:	75 10                	jne    10018f <remove_from_free_list+0x20>
        free_head = b->next;
  10017f:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100183:	48 89 05 9e 1e 00 00 	mov    %rax,0x1e9e(%rip)        # 102028 <free_head>
  10018a:	eb 19                	jmp    1001a5 <remove_from_free_list+0x36>
    } else {
        block *curr = free_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  10018c:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  10018f:	48 85 c0             	test   %rax,%rax
  100192:	74 11                	je     1001a5 <remove_from_free_list+0x36>
  100194:	48 8b 50 08          	mov    0x8(%rax),%rdx
  100198:	48 39 fa             	cmp    %rdi,%rdx
  10019b:	75 ef                	jne    10018c <remove_from_free_list+0x1d>
        }
        if (curr) {
            curr->next = b->next;
  10019d:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1001a1:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 0;
  1001a5:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = NULL;
  1001ac:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  1001b3:	00 
}
  1001b4:	c3                   	ret    

00000000001001b5 <add_to_malloc_list>:
void add_to_malloc_list(block *b) {
  1001b5:	f3 0f 1e fa          	endbr64 
    b->free = 0; // Mark as allocated
  1001b9:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = malloc_head;
  1001c0:	48 8b 05 59 1e 00 00 	mov    0x1e59(%rip),%rax        # 102020 <malloc_head>
  1001c7:	48 89 47 08          	mov    %rax,0x8(%rdi)
    malloc_head = b; // Add to the malloc list
  1001cb:	48 89 3d 4e 1e 00 00 	mov    %rdi,0x1e4e(%rip)        # 102020 <malloc_head>
}
  1001d2:	c3                   	ret    

00000000001001d3 <remove_from_malloc_list>:

void remove_from_malloc_list(block *b) {
  1001d3:	f3 0f 1e fa          	endbr64 
    if (malloc_head == b) {
  1001d7:	48 8b 05 42 1e 00 00 	mov    0x1e42(%rip),%rax        # 102020 <malloc_head>
  1001de:	48 39 f8             	cmp    %rdi,%rax
  1001e1:	75 10                	jne    1001f3 <remove_from_malloc_list+0x20>
        malloc_head = b->next; // Remove from the head of the malloc list
  1001e3:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1001e7:	48 89 05 32 1e 00 00 	mov    %rax,0x1e32(%rip)        # 102020 <malloc_head>
  1001ee:	eb 19                	jmp    100209 <remove_from_malloc_list+0x36>
    } else {
        block *curr = malloc_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  1001f0:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  1001f3:	48 85 c0             	test   %rax,%rax
  1001f6:	74 11                	je     100209 <remove_from_malloc_list+0x36>
  1001f8:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1001fc:	48 39 fa             	cmp    %rdi,%rdx
  1001ff:	75 ef                	jne    1001f0 <remove_from_malloc_list+0x1d>
        }
        if (curr) {
            curr->next = b->next; 
  100201:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100205:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 1; // Mark as free
  100209:	c7 47 10 01 00 00 00 	movl   $0x1,0x10(%rdi)
    b->next = NULL; 
  100210:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  100217:	00 
}
  100218:	c3                   	ret    

0000000000100219 <free>:

void free(void *firstbyte) {
  100219:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  10021d:	48 85 ff             	test   %rdi,%rdi
  100220:	74 06                	je     100228 <free+0xf>
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; // Prevent double-free
  100222:	83 7f f8 00          	cmpl   $0x0,-0x8(%rdi)
  100226:	74 01                	je     100229 <free+0x10>
  100228:	c3                   	ret    
void free(void *firstbyte) {
  100229:	55                   	push   %rbp
  10022a:	48 89 e5             	mov    %rsp,%rbp
  10022d:	53                   	push   %rbx
  10022e:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
  100232:	48 8d 5f e8          	lea    -0x18(%rdi),%rbx
    num_allocs--;
  100236:	83 2d d3 1d 00 00 01 	subl   $0x1,0x1dd3(%rip)        # 102010 <num_allocs>
    remove_from_malloc_list(b); // Remove from malloc list
  10023d:	48 89 df             	mov    %rbx,%rdi
  100240:	e8 8e ff ff ff       	call   1001d3 <remove_from_malloc_list>
    add_to_free_list(b);
  100245:	48 89 df             	mov    %rbx,%rdi
  100248:	e8 90 fe ff ff       	call   1000dd <add_to_free_list>
}
  10024d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100251:	c9                   	leave  
  100252:	c3                   	ret    

0000000000100253 <malloc>:

void *malloc(uint64_t numbytes) {
  100253:	f3 0f 1e fa          	endbr64 
  100257:	55                   	push   %rbp
  100258:	48 89 e5             	mov    %rsp,%rbp
  10025b:	41 54                	push   %r12
  10025d:	53                   	push   %rbx
    return (size + 7) / 8 * 8;
  10025e:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  100262:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    size_t size = algn(numbytes);
    block *b = find_block(size);
  100266:	4c 89 e7             	mov    %r12,%rdi
  100269:	e8 50 fe ff ff       	call   1000be <find_block>
  10026e:	48 89 c3             	mov    %rax,%rbx
    if (b == NULL) {
  100271:	48 85 c0             	test   %rax,%rax
  100274:	74 2d                	je     1002a3 <malloc+0x50>
        b = new_block(size);
        if (b == NULL) {
            return NULL;
        }
    }
        remove_from_free_list(b);
  100276:	48 89 df             	mov    %rbx,%rdi
  100279:	e8 f1 fe ff ff       	call   10016f <remove_from_free_list>
        if (b->size > size + BLOCKSIZE) {
  10027e:	49 8d 44 24 18       	lea    0x18(%r12),%rax
  100283:	48 39 03             	cmp    %rax,(%rbx)
  100286:	77 2d                	ja     1002b5 <malloc+0x62>
            split_block(b, size);
        }
    add_to_malloc_list(b);
  100288:	48 89 df             	mov    %rbx,%rdi
  10028b:	e8 25 ff ff ff       	call   1001b5 <add_to_malloc_list>
    num_allocs++;
  100290:	83 05 79 1d 00 00 01 	addl   $0x1,0x1d79(%rip)        # 102010 <num_allocs>
    return (void*)((void*)b + BLOCKSIZE);
  100297:	48 83 c3 18          	add    $0x18,%rbx
}
  10029b:	48 89 d8             	mov    %rbx,%rax
  10029e:	5b                   	pop    %rbx
  10029f:	41 5c                	pop    %r12
  1002a1:	5d                   	pop    %rbp
  1002a2:	c3                   	ret    
        b = new_block(size);
  1002a3:	4c 89 e7             	mov    %r12,%rdi
  1002a6:	e8 d9 fd ff ff       	call   100084 <new_block>
  1002ab:	48 89 c3             	mov    %rax,%rbx
        if (b == NULL) {
  1002ae:	48 85 c0             	test   %rax,%rax
  1002b1:	75 c3                	jne    100276 <malloc+0x23>
  1002b3:	eb e6                	jmp    10029b <malloc+0x48>
            split_block(b, size);
  1002b5:	4c 89 e6             	mov    %r12,%rsi
  1002b8:	48 89 df             	mov    %rbx,%rdi
  1002bb:	e8 60 fe ff ff       	call   100120 <split_block>
  1002c0:	eb c6                	jmp    100288 <malloc+0x35>

00000000001002c2 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  1002c2:	f3 0f 1e fa          	endbr64 
  1002c6:	55                   	push   %rbp
  1002c7:	48 89 e5             	mov    %rsp,%rbp
  1002ca:	41 54                	push   %r12
  1002cc:	53                   	push   %rbx
    uint64_t total = num * sz;
  1002cd:	48 0f af fe          	imul   %rsi,%rdi
  1002d1:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  1002d4:	e8 7a ff ff ff       	call   100253 <malloc>
  1002d9:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  1002dc:	48 85 c0             	test   %rax,%rax
  1002df:	74 10                	je     1002f1 <calloc+0x2f>
        memset(ptr, 0, total);
  1002e1:	4c 89 e2             	mov    %r12,%rdx
  1002e4:	be 00 00 00 00       	mov    $0x0,%esi
  1002e9:	48 89 c7             	mov    %rax,%rdi
  1002ec:	e8 5c 03 00 00       	call   10064d <memset>
    }
    return ptr;
}
  1002f1:	48 89 d8             	mov    %rbx,%rax
  1002f4:	5b                   	pop    %rbx
  1002f5:	41 5c                	pop    %r12
  1002f7:	5d                   	pop    %rbp
  1002f8:	c3                   	ret    

00000000001002f9 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  1002f9:	f3 0f 1e fa          	endbr64 
  1002fd:	55                   	push   %rbp
  1002fe:	48 89 e5             	mov    %rsp,%rbp
  100301:	41 54                	push   %r12
  100303:	53                   	push   %rbx
  100304:	48 89 fb             	mov    %rdi,%rbx
  100307:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  10030a:	48 85 db             	test   %rbx,%rbx
  10030d:	74 2d                	je     10033c <realloc+0x43>
        return malloc(sz);
    }
    if (sz == 0) {
  10030f:	48 85 f6             	test   %rsi,%rsi
  100312:	74 32                	je     100346 <realloc+0x4d>
    return (size + 7) / 8 * 8;
  100314:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  100318:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi
        return NULL;
    }
    block *b = (block*)((void*)ptr - BLOCKSIZE);
    size_t aligned_size = algn(sz);

    if (b->size >= aligned_size) {
  10031c:	48 8b 43 e8          	mov    -0x18(%rbx),%rax
  100320:	48 39 f0             	cmp    %rsi,%rax
  100323:	72 31                	jb     100356 <realloc+0x5d>
        if (b->size > aligned_size + BLOCKSIZE) {
  100325:	48 8d 56 18          	lea    0x18(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr;
  100329:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  10032c:	48 39 d0             	cmp    %rdx,%rax
  10032f:	76 49                	jbe    10037a <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE);
  100331:	48 8d 7b e8          	lea    -0x18(%rbx),%rdi
            split_block(b, aligned_size);
  100335:	e8 e6 fd ff ff       	call   100120 <split_block>
  10033a:	eb 3e                	jmp    10037a <realloc+0x81>
        return malloc(sz);
  10033c:	e8 12 ff ff ff       	call   100253 <malloc>
  100341:	49 89 c4             	mov    %rax,%r12
  100344:	eb 34                	jmp    10037a <realloc+0x81>
        free(ptr);
  100346:	48 89 df             	mov    %rbx,%rdi
  100349:	e8 cb fe ff ff       	call   100219 <free>
        return NULL;
  10034e:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100354:	eb 24                	jmp    10037a <realloc+0x81>
    }

    void *new_ptr = malloc(sz);
  100356:	e8 f8 fe ff ff       	call   100253 <malloc>
  10035b:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  10035e:	48 85 c0             	test   %rax,%rax
  100361:	74 17                	je     10037a <realloc+0x81>
        return NULL;
    }
    memcpy(new_ptr, ptr, b->size);
  100363:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  100367:	48 89 de             	mov    %rbx,%rsi
  10036a:	48 89 c7             	mov    %rax,%rdi
  10036d:	e8 d5 01 00 00       	call   100547 <memcpy>
    free(ptr);
  100372:	48 89 df             	mov    %rbx,%rdi
  100375:	e8 9f fe ff ff       	call   100219 <free>
    return new_ptr;
}
  10037a:	4c 89 e0             	mov    %r12,%rax
  10037d:	5b                   	pop    %rbx
  10037e:	41 5c                	pop    %r12
  100380:	5d                   	pop    %rbp
  100381:	c3                   	ret    

0000000000100382 <defrag>:

void defrag() {
  100382:	f3 0f 1e fa          	endbr64 
  100386:	55                   	push   %rbp
  100387:	48 89 e5             	mov    %rsp,%rbp
  10038a:	53                   	push   %rbx
  10038b:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = free_head;
  10038f:	48 8b 1d 92 1c 00 00 	mov    0x1c92(%rip),%rbx        # 102028 <free_head>

    while (b && b->next) { // Ensure there are at least two blocks to compare
  100396:	48 85 db             	test   %rbx,%rbx
  100399:	74 33                	je     1003ce <defrag+0x4c>
  10039b:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
  10039f:	48 85 ff             	test   %rdi,%rdi
  1003a2:	74 2a                	je     1003ce <defrag+0x4c>
        block *next = b->next;

        // Check if b and next are adjacent
        if ((char *)b + b->size + BLOCKSIZE == (char *)next) {
  1003a4:	48 8b 03             	mov    (%rbx),%rax
  1003a7:	48 83 c0 18          	add    $0x18,%rax
  1003ab:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1003af:	48 39 d7             	cmp    %rdx,%rdi
  1003b2:	74 05                	je     1003b9 <defrag+0x37>
    while (b && b->next) { // Ensure there are at least two blocks to compare
  1003b4:	48 89 fb             	mov    %rdi,%rbx
  1003b7:	eb dd                	jmp    100396 <defrag+0x14>
            // Coalesce next into b
            b->size += next->size + BLOCKSIZE;
  1003b9:	48 03 07             	add    (%rdi),%rax
  1003bc:	48 89 03             	mov    %rax,(%rbx)
            b->next = next->next; // Remove next from the free list
  1003bf:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1003c3:	48 89 43 08          	mov    %rax,0x8(%rbx)
            remove_from_free_list(next);
  1003c7:	e8 a3 fd ff ff       	call   10016f <remove_from_free_list>
  1003cc:	eb c8                	jmp    100396 <defrag+0x14>
        } else {
            // Move to the next block if no merge happens
            b = b->next;
        }
    }
}
  1003ce:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1003d2:	c9                   	leave  
  1003d3:	c3                   	ret    

00000000001003d4 <heap_info>:




int heap_info(heap_info_struct * info) {
  1003d4:	f3 0f 1e fa          	endbr64 
  1003d8:	55                   	push   %rbp
  1003d9:	48 89 e5             	mov    %rsp,%rbp
  1003dc:	41 54                	push   %r12
  1003de:	53                   	push   %rbx
  1003df:	49 89 fc             	mov    %rdi,%r12
    info->num_allocs = num_allocs;
  1003e2:	8b 05 28 1c 00 00    	mov    0x1c28(%rip),%eax        # 102010 <num_allocs>
  1003e8:	89 07                	mov    %eax,(%rdi)
    long *size_array = (long*)malloc((num_allocs) * sizeof(long));
  1003ea:	48 98                	cltq   
  1003ec:	48 8d 3c c5 00 00 00 	lea    0x0(,%rax,8),%rdi
  1003f3:	00 
  1003f4:	e8 5a fe ff ff       	call   100253 <malloc>
  1003f9:	48 89 c3             	mov    %rax,%rbx
    void **ptr_array = (void**)malloc((num_allocs) * sizeof(void*));
  1003fc:	48 63 3d 0d 1c 00 00 	movslq 0x1c0d(%rip),%rdi        # 102010 <num_allocs>
  100403:	48 c1 e7 03          	shl    $0x3,%rdi
  100407:	e8 47 fe ff ff       	call   100253 <malloc>

    if (!size_array || !ptr_array) {
  10040c:	48 85 db             	test   %rbx,%rbx
  10040f:	0f 84 2b 01 00 00    	je     100540 <heap_info+0x16c>
  100415:	49 89 c0             	mov    %rax,%r8
  100418:	48 85 c0             	test   %rax,%rax
  10041b:	0f 84 1f 01 00 00    	je     100540 <heap_info+0x16c>
        return -1;
    }
    // calculate free space and largest free chunk including block size
    block *bf = free_head;
  100421:	48 8b 05 00 1c 00 00 	mov    0x1c00(%rip),%rax        # 102028 <free_head>
    size_t free_space = 0;
    size_t largest_free_chunk = 0;
    while (bf) {
  100428:	48 85 c0             	test   %rax,%rax
  10042b:	74 72                	je     10049f <heap_info+0xcb>
    size_t largest_free_chunk = 0;
  10042d:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    size_t free_space = 0;
  100433:	41 bb 00 00 00 00    	mov    $0x0,%r11d
        free_space += bf->size + BLOCKSIZE;
  100439:	48 8b 10             	mov    (%rax),%rdx
  10043c:	4e 8d 5c 1a 18       	lea    0x18(%rdx,%r11,1),%r11
        if (bf->size > largest_free_chunk) {
  100441:	49 39 d2             	cmp    %rdx,%r10
  100444:	4c 0f 42 d2          	cmovb  %rdx,%r10
            largest_free_chunk = bf->size;
        }
        bf = bf->next;
  100448:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bf) {
  10044c:	48 85 c0             	test   %rax,%rax
  10044f:	75 e8                	jne    100439 <heap_info+0x65>
    }

    block *bm = malloc_head->next->next;
  100451:	48 8b 05 c8 1b 00 00 	mov    0x1bc8(%rip),%rax        # 102020 <malloc_head>
  100458:	48 8b 40 08          	mov    0x8(%rax),%rax
  10045c:	48 8b 40 08          	mov    0x8(%rax),%rax
    int x = 0;
    while (bm) {
  100460:	48 85 c0             	test   %rax,%rax
  100463:	74 21                	je     100486 <heap_info+0xb2>
  100465:	ba 00 00 00 00       	mov    $0x0,%edx
        size_array[x] = bm->size;
  10046a:	48 8b 08             	mov    (%rax),%rcx
  10046d:	48 89 0c 13          	mov    %rcx,(%rbx,%rdx,1)
        ptr_array[x] = (void*)((void*)bm + BLOCKSIZE);
  100471:	48 8d 48 18          	lea    0x18(%rax),%rcx
  100475:	49 89 0c 10          	mov    %rcx,(%r8,%rdx,1)
        bm = bm->next;
  100479:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bm) {
  10047d:	48 83 c2 08          	add    $0x8,%rdx
  100481:	48 85 c0             	test   %rax,%rax
  100484:	75 e4                	jne    10046a <heap_info+0x96>
        x++;
    }
    // // sort size and poitner array by size in descending order
    for (int i = 0; i < num_allocs-2; i++) {
  100486:	8b 15 84 1b 00 00    	mov    0x1b84(%rip),%edx        # 102010 <num_allocs>
  10048c:	83 fa 02             	cmp    $0x2,%edx
  10048f:	7e 77                	jle    100508 <heap_info+0x134>
  100491:	48 89 de             	mov    %rbx,%rsi
  100494:	4c 89 c7             	mov    %r8,%rdi
  100497:	41 b9 01 00 00 00    	mov    $0x1,%r9d
  10049d:	eb 56                	jmp    1004f5 <heap_info+0x121>
    size_t largest_free_chunk = 0;
  10049f:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    size_t free_space = 0;
  1004a5:	41 bb 00 00 00 00    	mov    $0x0,%r11d
  1004ab:	eb a4                	jmp    100451 <heap_info+0x7d>
        for (int j = i + 1; j < num_allocs-2; j++) {
  1004ad:	8b 15 5d 1b 00 00    	mov    0x1b5d(%rip),%edx        # 102010 <num_allocs>
  1004b3:	8d 4a fe             	lea    -0x2(%rdx),%ecx
  1004b6:	48 83 c0 01          	add    $0x1,%rax
  1004ba:	39 c1                	cmp    %eax,%ecx
  1004bc:	7e 23                	jle    1004e1 <heap_info+0x10d>
            if (size_array[i] < size_array[j]) {
  1004be:	48 8b 16             	mov    (%rsi),%rdx
  1004c1:	48 8b 0c c3          	mov    (%rbx,%rax,8),%rcx
  1004c5:	48 39 ca             	cmp    %rcx,%rdx
  1004c8:	7d e3                	jge    1004ad <heap_info+0xd9>
                long temp = size_array[i];
                size_array[i] = size_array[j];
  1004ca:	48 89 0e             	mov    %rcx,(%rsi)
                size_array[j] = temp;
  1004cd:	48 89 14 c3          	mov    %rdx,(%rbx,%rax,8)
                void *temp_ptr = ptr_array[i];
  1004d1:	48 8b 17             	mov    (%rdi),%rdx
                ptr_array[i] = ptr_array[j];
  1004d4:	49 8b 0c c0          	mov    (%r8,%rax,8),%rcx
  1004d8:	48 89 0f             	mov    %rcx,(%rdi)
                ptr_array[j] = temp_ptr;
  1004db:	49 89 14 c0          	mov    %rdx,(%r8,%rax,8)
  1004df:	eb cc                	jmp    1004ad <heap_info+0xd9>
    for (int i = 0; i < num_allocs-2; i++) {
  1004e1:	49 83 c1 01          	add    $0x1,%r9
  1004e5:	48 83 c6 08          	add    $0x8,%rsi
  1004e9:	48 83 c7 08          	add    $0x8,%rdi
  1004ed:	41 8d 41 ff          	lea    -0x1(%r9),%eax
  1004f1:	39 c1                	cmp    %eax,%ecx
  1004f3:	7e 13                	jle    100508 <heap_info+0x134>
        for (int j = i + 1; j < num_allocs-2; j++) {
  1004f5:	8b 15 15 1b 00 00    	mov    0x1b15(%rip),%edx        # 102010 <num_allocs>
  1004fb:	8d 42 fe             	lea    -0x2(%rdx),%eax
  1004fe:	44 39 c8             	cmp    %r9d,%eax
  100501:	7e 05                	jle    100508 <heap_info+0x134>
  100503:	4c 89 c8             	mov    %r9,%rax
  100506:	eb b6                	jmp    1004be <heap_info+0xea>
            }
        }
    }

    if (num_allocs == 0) {
  100508:	85 d2                	test   %edx,%edx
  10050a:	74 20                	je     10052c <heap_info+0x158>
        info->size_array = NULL;
        info->ptr_array = NULL;
        return 0;
    }else{
        info->size_array = size_array;
  10050c:	49 89 5c 24 08       	mov    %rbx,0x8(%r12)
        info->ptr_array = ptr_array;
  100511:	4d 89 44 24 10       	mov    %r8,0x10(%r12)
    }
    info->free_space = (int)free_space;
  100516:	45 89 5c 24 18       	mov    %r11d,0x18(%r12)
    info->largest_free_chunk = (int)largest_free_chunk;
  10051b:	45 89 54 24 1c       	mov    %r10d,0x1c(%r12)
    return 0;
  100520:	ba 00 00 00 00       	mov    $0x0,%edx
  100525:	89 d0                	mov    %edx,%eax
  100527:	5b                   	pop    %rbx
  100528:	41 5c                	pop    %r12
  10052a:	5d                   	pop    %rbp
  10052b:	c3                   	ret    
        info->size_array = NULL;
  10052c:	49 c7 44 24 08 00 00 	movq   $0x0,0x8(%r12)
  100533:	00 00 
        info->ptr_array = NULL;
  100535:	49 c7 44 24 10 00 00 	movq   $0x0,0x10(%r12)
  10053c:	00 00 
        return 0;
  10053e:	eb e5                	jmp    100525 <heap_info+0x151>
        return -1;
  100540:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  100545:	eb de                	jmp    100525 <heap_info+0x151>

0000000000100547 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100547:	f3 0f 1e fa          	endbr64 
  10054b:	55                   	push   %rbp
  10054c:	48 89 e5             	mov    %rsp,%rbp
  10054f:	48 83 ec 28          	sub    $0x28,%rsp
  100553:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100557:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10055b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10055f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100563:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100567:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10056b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10056f:	eb 1c                	jmp    10058d <memcpy+0x46>
        *d = *s;
  100571:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100575:	0f b6 10             	movzbl (%rax),%edx
  100578:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10057c:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10057e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100583:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100588:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  10058d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100592:	75 dd                	jne    100571 <memcpy+0x2a>
    }
    return dst;
  100594:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100598:	c9                   	leave  
  100599:	c3                   	ret    

000000000010059a <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  10059a:	f3 0f 1e fa          	endbr64 
  10059e:	55                   	push   %rbp
  10059f:	48 89 e5             	mov    %rsp,%rbp
  1005a2:	48 83 ec 28          	sub    $0x28,%rsp
  1005a6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1005aa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1005ae:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1005b2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1005b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1005ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005be:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1005c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005c6:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1005ca:	73 6a                	jae    100636 <memmove+0x9c>
  1005cc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1005d0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1005d4:	48 01 d0             	add    %rdx,%rax
  1005d7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1005db:	73 59                	jae    100636 <memmove+0x9c>
        s += n, d += n;
  1005dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1005e1:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1005e5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1005e9:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1005ed:	eb 17                	jmp    100606 <memmove+0x6c>
            *--d = *--s;
  1005ef:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1005f4:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1005f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005fd:	0f b6 10             	movzbl (%rax),%edx
  100600:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100604:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100606:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10060a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10060e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100612:	48 85 c0             	test   %rax,%rax
  100615:	75 d8                	jne    1005ef <memmove+0x55>
    if (s < d && s + n > d) {
  100617:	eb 2e                	jmp    100647 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100619:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10061d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100621:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100625:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100629:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10062d:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100631:	0f b6 12             	movzbl (%rdx),%edx
  100634:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100636:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10063a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10063e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100642:	48 85 c0             	test   %rax,%rax
  100645:	75 d2                	jne    100619 <memmove+0x7f>
        }
    }
    return dst;
  100647:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10064b:	c9                   	leave  
  10064c:	c3                   	ret    

000000000010064d <memset>:

void* memset(void* v, int c, size_t n) {
  10064d:	f3 0f 1e fa          	endbr64 
  100651:	55                   	push   %rbp
  100652:	48 89 e5             	mov    %rsp,%rbp
  100655:	48 83 ec 28          	sub    $0x28,%rsp
  100659:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10065d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100660:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100664:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100668:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10066c:	eb 15                	jmp    100683 <memset+0x36>
        *p = c;
  10066e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100671:	89 c2                	mov    %eax,%edx
  100673:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100677:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100679:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10067e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100683:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100688:	75 e4                	jne    10066e <memset+0x21>
    }
    return v;
  10068a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10068e:	c9                   	leave  
  10068f:	c3                   	ret    

0000000000100690 <strlen>:

size_t strlen(const char* s) {
  100690:	f3 0f 1e fa          	endbr64 
  100694:	55                   	push   %rbp
  100695:	48 89 e5             	mov    %rsp,%rbp
  100698:	48 83 ec 18          	sub    $0x18,%rsp
  10069c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1006a0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1006a7:	00 
  1006a8:	eb 0a                	jmp    1006b4 <strlen+0x24>
        ++n;
  1006aa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1006af:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1006b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006b8:	0f b6 00             	movzbl (%rax),%eax
  1006bb:	84 c0                	test   %al,%al
  1006bd:	75 eb                	jne    1006aa <strlen+0x1a>
    }
    return n;
  1006bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1006c3:	c9                   	leave  
  1006c4:	c3                   	ret    

00000000001006c5 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1006c5:	f3 0f 1e fa          	endbr64 
  1006c9:	55                   	push   %rbp
  1006ca:	48 89 e5             	mov    %rsp,%rbp
  1006cd:	48 83 ec 20          	sub    $0x20,%rsp
  1006d1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1006d5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1006d9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1006e0:	00 
  1006e1:	eb 0a                	jmp    1006ed <strnlen+0x28>
        ++n;
  1006e3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1006e8:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1006ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006f1:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1006f5:	74 0b                	je     100702 <strnlen+0x3d>
  1006f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006fb:	0f b6 00             	movzbl (%rax),%eax
  1006fe:	84 c0                	test   %al,%al
  100700:	75 e1                	jne    1006e3 <strnlen+0x1e>
    }
    return n;
  100702:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100706:	c9                   	leave  
  100707:	c3                   	ret    

0000000000100708 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100708:	f3 0f 1e fa          	endbr64 
  10070c:	55                   	push   %rbp
  10070d:	48 89 e5             	mov    %rsp,%rbp
  100710:	48 83 ec 20          	sub    $0x20,%rsp
  100714:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100718:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  10071c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100720:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100724:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100728:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10072c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100730:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100734:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100738:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  10073c:	0f b6 12             	movzbl (%rdx),%edx
  10073f:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100741:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100745:	48 83 e8 01          	sub    $0x1,%rax
  100749:	0f b6 00             	movzbl (%rax),%eax
  10074c:	84 c0                	test   %al,%al
  10074e:	75 d4                	jne    100724 <strcpy+0x1c>
    return dst;
  100750:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100754:	c9                   	leave  
  100755:	c3                   	ret    

0000000000100756 <strcmp>:

int strcmp(const char* a, const char* b) {
  100756:	f3 0f 1e fa          	endbr64 
  10075a:	55                   	push   %rbp
  10075b:	48 89 e5             	mov    %rsp,%rbp
  10075e:	48 83 ec 10          	sub    $0x10,%rsp
  100762:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100766:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10076a:	eb 0a                	jmp    100776 <strcmp+0x20>
        ++a, ++b;
  10076c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100771:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100776:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10077a:	0f b6 00             	movzbl (%rax),%eax
  10077d:	84 c0                	test   %al,%al
  10077f:	74 1d                	je     10079e <strcmp+0x48>
  100781:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100785:	0f b6 00             	movzbl (%rax),%eax
  100788:	84 c0                	test   %al,%al
  10078a:	74 12                	je     10079e <strcmp+0x48>
  10078c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100790:	0f b6 10             	movzbl (%rax),%edx
  100793:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100797:	0f b6 00             	movzbl (%rax),%eax
  10079a:	38 c2                	cmp    %al,%dl
  10079c:	74 ce                	je     10076c <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  10079e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007a2:	0f b6 00             	movzbl (%rax),%eax
  1007a5:	89 c2                	mov    %eax,%edx
  1007a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1007ab:	0f b6 00             	movzbl (%rax),%eax
  1007ae:	38 c2                	cmp    %al,%dl
  1007b0:	0f 97 c0             	seta   %al
  1007b3:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1007b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007ba:	0f b6 00             	movzbl (%rax),%eax
  1007bd:	89 c1                	mov    %eax,%ecx
  1007bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1007c3:	0f b6 00             	movzbl (%rax),%eax
  1007c6:	38 c1                	cmp    %al,%cl
  1007c8:	0f 92 c0             	setb   %al
  1007cb:	0f b6 c8             	movzbl %al,%ecx
  1007ce:	89 d0                	mov    %edx,%eax
  1007d0:	29 c8                	sub    %ecx,%eax
}
  1007d2:	c9                   	leave  
  1007d3:	c3                   	ret    

00000000001007d4 <strchr>:

char* strchr(const char* s, int c) {
  1007d4:	f3 0f 1e fa          	endbr64 
  1007d8:	55                   	push   %rbp
  1007d9:	48 89 e5             	mov    %rsp,%rbp
  1007dc:	48 83 ec 10          	sub    $0x10,%rsp
  1007e0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1007e4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1007e7:	eb 05                	jmp    1007ee <strchr+0x1a>
        ++s;
  1007e9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1007ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007f2:	0f b6 00             	movzbl (%rax),%eax
  1007f5:	84 c0                	test   %al,%al
  1007f7:	74 0e                	je     100807 <strchr+0x33>
  1007f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007fd:	0f b6 00             	movzbl (%rax),%eax
  100800:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100803:	38 d0                	cmp    %dl,%al
  100805:	75 e2                	jne    1007e9 <strchr+0x15>
    }
    if (*s == (char) c) {
  100807:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10080b:	0f b6 00             	movzbl (%rax),%eax
  10080e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100811:	38 d0                	cmp    %dl,%al
  100813:	75 06                	jne    10081b <strchr+0x47>
        return (char*) s;
  100815:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100819:	eb 05                	jmp    100820 <strchr+0x4c>
    } else {
        return NULL;
  10081b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100820:	c9                   	leave  
  100821:	c3                   	ret    

0000000000100822 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100822:	f3 0f 1e fa          	endbr64 
  100826:	55                   	push   %rbp
  100827:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  10082a:	8b 05 00 18 00 00    	mov    0x1800(%rip),%eax        # 102030 <rand_seed_set>
  100830:	85 c0                	test   %eax,%eax
  100832:	75 0a                	jne    10083e <rand+0x1c>
        srand(819234718U);
  100834:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100839:	e8 24 00 00 00       	call   100862 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  10083e:	8b 05 f0 17 00 00    	mov    0x17f0(%rip),%eax        # 102034 <rand_seed>
  100844:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  10084a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10084f:	89 05 df 17 00 00    	mov    %eax,0x17df(%rip)        # 102034 <rand_seed>
    return rand_seed & RAND_MAX;
  100855:	8b 05 d9 17 00 00    	mov    0x17d9(%rip),%eax        # 102034 <rand_seed>
  10085b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100860:	5d                   	pop    %rbp
  100861:	c3                   	ret    

0000000000100862 <srand>:

void srand(unsigned seed) {
  100862:	f3 0f 1e fa          	endbr64 
  100866:	55                   	push   %rbp
  100867:	48 89 e5             	mov    %rsp,%rbp
  10086a:	48 83 ec 08          	sub    $0x8,%rsp
  10086e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100871:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100874:	89 05 ba 17 00 00    	mov    %eax,0x17ba(%rip)        # 102034 <rand_seed>
    rand_seed_set = 1;
  10087a:	c7 05 ac 17 00 00 01 	movl   $0x1,0x17ac(%rip)        # 102030 <rand_seed_set>
  100881:	00 00 00 
}
  100884:	90                   	nop
  100885:	c9                   	leave  
  100886:	c3                   	ret    

0000000000100887 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100887:	f3 0f 1e fa          	endbr64 
  10088b:	55                   	push   %rbp
  10088c:	48 89 e5             	mov    %rsp,%rbp
  10088f:	48 83 ec 28          	sub    $0x28,%rsp
  100893:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100897:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10089b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  10089e:	48 8d 05 ab 0e 00 00 	lea    0xeab(%rip),%rax        # 101750 <upper_digits.1>
  1008a5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  1008a9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1008ad:	79 0e                	jns    1008bd <fill_numbuf+0x36>
        digits = lower_digits;
  1008af:	48 8d 05 ba 0e 00 00 	lea    0xeba(%rip),%rax        # 101770 <lower_digits.0>
  1008b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  1008ba:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1008bd:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1008c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1008c6:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1008c9:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1008cc:	48 63 c8             	movslq %eax,%rcx
  1008cf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1008d3:	ba 00 00 00 00       	mov    $0x0,%edx
  1008d8:	48 f7 f1             	div    %rcx
  1008db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008df:	48 01 d0             	add    %rdx,%rax
  1008e2:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1008e7:	0f b6 10             	movzbl (%rax),%edx
  1008ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1008ee:	88 10                	mov    %dl,(%rax)
        val /= base;
  1008f0:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1008f3:	48 63 f0             	movslq %eax,%rsi
  1008f6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1008fa:	ba 00 00 00 00       	mov    $0x0,%edx
  1008ff:	48 f7 f6             	div    %rsi
  100902:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100906:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  10090b:	75 bc                	jne    1008c9 <fill_numbuf+0x42>
    return numbuf_end;
  10090d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100911:	c9                   	leave  
  100912:	c3                   	ret    

0000000000100913 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100913:	f3 0f 1e fa          	endbr64 
  100917:	55                   	push   %rbp
  100918:	48 89 e5             	mov    %rsp,%rbp
  10091b:	53                   	push   %rbx
  10091c:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100923:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  10092a:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100930:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100937:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  10093e:	e9 bd 09 00 00       	jmp    101300 <printer_vprintf+0x9ed>
        if (*format != '%') {
  100943:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10094a:	0f b6 00             	movzbl (%rax),%eax
  10094d:	3c 25                	cmp    $0x25,%al
  10094f:	74 31                	je     100982 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  100951:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100958:	4c 8b 00             	mov    (%rax),%r8
  10095b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100962:	0f b6 00             	movzbl (%rax),%eax
  100965:	0f b6 c8             	movzbl %al,%ecx
  100968:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10096e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100975:	89 ce                	mov    %ecx,%esi
  100977:	48 89 c7             	mov    %rax,%rdi
  10097a:	41 ff d0             	call   *%r8
            continue;
  10097d:	e9 76 09 00 00       	jmp    1012f8 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  100982:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100989:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100990:	01 
  100991:	eb 4d                	jmp    1009e0 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  100993:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10099a:	0f b6 00             	movzbl (%rax),%eax
  10099d:	0f be c0             	movsbl %al,%eax
  1009a0:	89 c6                	mov    %eax,%esi
  1009a2:	48 8d 05 a7 0c 00 00 	lea    0xca7(%rip),%rax        # 101650 <flag_chars>
  1009a9:	48 89 c7             	mov    %rax,%rdi
  1009ac:	e8 23 fe ff ff       	call   1007d4 <strchr>
  1009b1:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1009b5:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1009ba:	74 34                	je     1009f0 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  1009bc:	48 8d 15 8d 0c 00 00 	lea    0xc8d(%rip),%rdx        # 101650 <flag_chars>
  1009c3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1009c7:	48 29 d0             	sub    %rdx,%rax
  1009ca:	ba 01 00 00 00       	mov    $0x1,%edx
  1009cf:	89 c1                	mov    %eax,%ecx
  1009d1:	d3 e2                	shl    %cl,%edx
  1009d3:	89 d0                	mov    %edx,%eax
  1009d5:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1009d8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009df:	01 
  1009e0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009e7:	0f b6 00             	movzbl (%rax),%eax
  1009ea:	84 c0                	test   %al,%al
  1009ec:	75 a5                	jne    100993 <printer_vprintf+0x80>
  1009ee:	eb 01                	jmp    1009f1 <printer_vprintf+0xde>
            } else {
                break;
  1009f0:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1009f1:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1009f8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009ff:	0f b6 00             	movzbl (%rax),%eax
  100a02:	3c 30                	cmp    $0x30,%al
  100a04:	7e 67                	jle    100a6d <printer_vprintf+0x15a>
  100a06:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a0d:	0f b6 00             	movzbl (%rax),%eax
  100a10:	3c 39                	cmp    $0x39,%al
  100a12:	7f 59                	jg     100a6d <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100a14:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100a1b:	eb 2e                	jmp    100a4b <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  100a1d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100a20:	89 d0                	mov    %edx,%eax
  100a22:	c1 e0 02             	shl    $0x2,%eax
  100a25:	01 d0                	add    %edx,%eax
  100a27:	01 c0                	add    %eax,%eax
  100a29:	89 c1                	mov    %eax,%ecx
  100a2b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a32:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100a36:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100a3d:	0f b6 00             	movzbl (%rax),%eax
  100a40:	0f be c0             	movsbl %al,%eax
  100a43:	01 c8                	add    %ecx,%eax
  100a45:	83 e8 30             	sub    $0x30,%eax
  100a48:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100a4b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a52:	0f b6 00             	movzbl (%rax),%eax
  100a55:	3c 2f                	cmp    $0x2f,%al
  100a57:	0f 8e 85 00 00 00    	jle    100ae2 <printer_vprintf+0x1cf>
  100a5d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a64:	0f b6 00             	movzbl (%rax),%eax
  100a67:	3c 39                	cmp    $0x39,%al
  100a69:	7e b2                	jle    100a1d <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  100a6b:	eb 75                	jmp    100ae2 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  100a6d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a74:	0f b6 00             	movzbl (%rax),%eax
  100a77:	3c 2a                	cmp    $0x2a,%al
  100a79:	75 68                	jne    100ae3 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  100a7b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a82:	8b 00                	mov    (%rax),%eax
  100a84:	83 f8 2f             	cmp    $0x2f,%eax
  100a87:	77 30                	ja     100ab9 <printer_vprintf+0x1a6>
  100a89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a90:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a94:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a9b:	8b 00                	mov    (%rax),%eax
  100a9d:	89 c0                	mov    %eax,%eax
  100a9f:	48 01 d0             	add    %rdx,%rax
  100aa2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aa9:	8b 12                	mov    (%rdx),%edx
  100aab:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100aae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ab5:	89 0a                	mov    %ecx,(%rdx)
  100ab7:	eb 1a                	jmp    100ad3 <printer_vprintf+0x1c0>
  100ab9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ac0:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ac4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ac8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100acf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ad3:	8b 00                	mov    (%rax),%eax
  100ad5:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100ad8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100adf:	01 
  100ae0:	eb 01                	jmp    100ae3 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  100ae2:	90                   	nop
        }

        // process precision
        int precision = -1;
  100ae3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100aea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100af1:	0f b6 00             	movzbl (%rax),%eax
  100af4:	3c 2e                	cmp    $0x2e,%al
  100af6:	0f 85 00 01 00 00    	jne    100bfc <printer_vprintf+0x2e9>
            ++format;
  100afc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b03:	01 
            if (*format >= '0' && *format <= '9') {
  100b04:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b0b:	0f b6 00             	movzbl (%rax),%eax
  100b0e:	3c 2f                	cmp    $0x2f,%al
  100b10:	7e 67                	jle    100b79 <printer_vprintf+0x266>
  100b12:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b19:	0f b6 00             	movzbl (%rax),%eax
  100b1c:	3c 39                	cmp    $0x39,%al
  100b1e:	7f 59                	jg     100b79 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100b20:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100b27:	eb 2e                	jmp    100b57 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  100b29:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100b2c:	89 d0                	mov    %edx,%eax
  100b2e:	c1 e0 02             	shl    $0x2,%eax
  100b31:	01 d0                	add    %edx,%eax
  100b33:	01 c0                	add    %eax,%eax
  100b35:	89 c1                	mov    %eax,%ecx
  100b37:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b3e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100b42:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100b49:	0f b6 00             	movzbl (%rax),%eax
  100b4c:	0f be c0             	movsbl %al,%eax
  100b4f:	01 c8                	add    %ecx,%eax
  100b51:	83 e8 30             	sub    $0x30,%eax
  100b54:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100b57:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b5e:	0f b6 00             	movzbl (%rax),%eax
  100b61:	3c 2f                	cmp    $0x2f,%al
  100b63:	0f 8e 85 00 00 00    	jle    100bee <printer_vprintf+0x2db>
  100b69:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b70:	0f b6 00             	movzbl (%rax),%eax
  100b73:	3c 39                	cmp    $0x39,%al
  100b75:	7e b2                	jle    100b29 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  100b77:	eb 75                	jmp    100bee <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  100b79:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b80:	0f b6 00             	movzbl (%rax),%eax
  100b83:	3c 2a                	cmp    $0x2a,%al
  100b85:	75 68                	jne    100bef <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  100b87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b8e:	8b 00                	mov    (%rax),%eax
  100b90:	83 f8 2f             	cmp    $0x2f,%eax
  100b93:	77 30                	ja     100bc5 <printer_vprintf+0x2b2>
  100b95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b9c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ba0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ba7:	8b 00                	mov    (%rax),%eax
  100ba9:	89 c0                	mov    %eax,%eax
  100bab:	48 01 d0             	add    %rdx,%rax
  100bae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bb5:	8b 12                	mov    (%rdx),%edx
  100bb7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bc1:	89 0a                	mov    %ecx,(%rdx)
  100bc3:	eb 1a                	jmp    100bdf <printer_vprintf+0x2cc>
  100bc5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bcc:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bd0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bd4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bdb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bdf:	8b 00                	mov    (%rax),%eax
  100be1:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100be4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100beb:	01 
  100bec:	eb 01                	jmp    100bef <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  100bee:	90                   	nop
            }
            if (precision < 0) {
  100bef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100bf3:	79 07                	jns    100bfc <printer_vprintf+0x2e9>
                precision = 0;
  100bf5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100bfc:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100c03:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100c0a:	00 
        int length = 0;
  100c0b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100c12:	48 8d 05 3d 0a 00 00 	lea    0xa3d(%rip),%rax        # 101656 <flag_chars+0x6>
  100c19:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  100c1d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c24:	0f b6 00             	movzbl (%rax),%eax
  100c27:	0f be c0             	movsbl %al,%eax
  100c2a:	83 e8 43             	sub    $0x43,%eax
  100c2d:	83 f8 37             	cmp    $0x37,%eax
  100c30:	0f 87 b6 03 00 00    	ja     100fec <printer_vprintf+0x6d9>
  100c36:	89 c0                	mov    %eax,%eax
  100c38:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  100c3f:	00 
  100c40:	48 8d 05 1d 0a 00 00 	lea    0xa1d(%rip),%rax        # 101664 <flag_chars+0x14>
  100c47:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  100c4a:	48 98                	cltq   
  100c4c:	48 8d 15 11 0a 00 00 	lea    0xa11(%rip),%rdx        # 101664 <flag_chars+0x14>
  100c53:	48 01 d0             	add    %rdx,%rax
  100c56:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  100c59:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100c60:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c67:	01 
            goto again;
  100c68:	eb b3                	jmp    100c1d <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100c6a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100c6e:	74 5d                	je     100ccd <printer_vprintf+0x3ba>
  100c70:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c77:	8b 00                	mov    (%rax),%eax
  100c79:	83 f8 2f             	cmp    $0x2f,%eax
  100c7c:	77 30                	ja     100cae <printer_vprintf+0x39b>
  100c7e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c85:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c90:	8b 00                	mov    (%rax),%eax
  100c92:	89 c0                	mov    %eax,%eax
  100c94:	48 01 d0             	add    %rdx,%rax
  100c97:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c9e:	8b 12                	mov    (%rdx),%edx
  100ca0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ca3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100caa:	89 0a                	mov    %ecx,(%rdx)
  100cac:	eb 1a                	jmp    100cc8 <printer_vprintf+0x3b5>
  100cae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cb5:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cb9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cbd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cc4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cc8:	48 8b 00             	mov    (%rax),%rax
  100ccb:	eb 5c                	jmp    100d29 <printer_vprintf+0x416>
  100ccd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cd4:	8b 00                	mov    (%rax),%eax
  100cd6:	83 f8 2f             	cmp    $0x2f,%eax
  100cd9:	77 30                	ja     100d0b <printer_vprintf+0x3f8>
  100cdb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ce2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ce6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ced:	8b 00                	mov    (%rax),%eax
  100cef:	89 c0                	mov    %eax,%eax
  100cf1:	48 01 d0             	add    %rdx,%rax
  100cf4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cfb:	8b 12                	mov    (%rdx),%edx
  100cfd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d07:	89 0a                	mov    %ecx,(%rdx)
  100d09:	eb 1a                	jmp    100d25 <printer_vprintf+0x412>
  100d0b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d12:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d16:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d1a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d21:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d25:	8b 00                	mov    (%rax),%eax
  100d27:	48 98                	cltq   
  100d29:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100d2d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100d31:	48 c1 f8 38          	sar    $0x38,%rax
  100d35:	25 80 00 00 00       	and    $0x80,%eax
  100d3a:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100d3d:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100d41:	74 09                	je     100d4c <printer_vprintf+0x439>
  100d43:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100d47:	48 f7 d8             	neg    %rax
  100d4a:	eb 04                	jmp    100d50 <printer_vprintf+0x43d>
  100d4c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100d50:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100d54:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100d57:	83 c8 60             	or     $0x60,%eax
  100d5a:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100d5d:	e9 cf 02 00 00       	jmp    101031 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100d62:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100d66:	74 5d                	je     100dc5 <printer_vprintf+0x4b2>
  100d68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d6f:	8b 00                	mov    (%rax),%eax
  100d71:	83 f8 2f             	cmp    $0x2f,%eax
  100d74:	77 30                	ja     100da6 <printer_vprintf+0x493>
  100d76:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d7d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d81:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d88:	8b 00                	mov    (%rax),%eax
  100d8a:	89 c0                	mov    %eax,%eax
  100d8c:	48 01 d0             	add    %rdx,%rax
  100d8f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d96:	8b 12                	mov    (%rdx),%edx
  100d98:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100da2:	89 0a                	mov    %ecx,(%rdx)
  100da4:	eb 1a                	jmp    100dc0 <printer_vprintf+0x4ad>
  100da6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dad:	48 8b 40 08          	mov    0x8(%rax),%rax
  100db1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100db5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dbc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100dc0:	48 8b 00             	mov    (%rax),%rax
  100dc3:	eb 5c                	jmp    100e21 <printer_vprintf+0x50e>
  100dc5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dcc:	8b 00                	mov    (%rax),%eax
  100dce:	83 f8 2f             	cmp    $0x2f,%eax
  100dd1:	77 30                	ja     100e03 <printer_vprintf+0x4f0>
  100dd3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dda:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100dde:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100de5:	8b 00                	mov    (%rax),%eax
  100de7:	89 c0                	mov    %eax,%eax
  100de9:	48 01 d0             	add    %rdx,%rax
  100dec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100df3:	8b 12                	mov    (%rdx),%edx
  100df5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100df8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dff:	89 0a                	mov    %ecx,(%rdx)
  100e01:	eb 1a                	jmp    100e1d <printer_vprintf+0x50a>
  100e03:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e0a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e0e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e12:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e19:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e1d:	8b 00                	mov    (%rax),%eax
  100e1f:	89 c0                	mov    %eax,%eax
  100e21:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100e25:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100e29:	e9 03 02 00 00       	jmp    101031 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100e2e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100e35:	e9 28 ff ff ff       	jmp    100d62 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100e3a:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100e41:	e9 1c ff ff ff       	jmp    100d62 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100e46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e4d:	8b 00                	mov    (%rax),%eax
  100e4f:	83 f8 2f             	cmp    $0x2f,%eax
  100e52:	77 30                	ja     100e84 <printer_vprintf+0x571>
  100e54:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e5b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e5f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e66:	8b 00                	mov    (%rax),%eax
  100e68:	89 c0                	mov    %eax,%eax
  100e6a:	48 01 d0             	add    %rdx,%rax
  100e6d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e74:	8b 12                	mov    (%rdx),%edx
  100e76:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e79:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e80:	89 0a                	mov    %ecx,(%rdx)
  100e82:	eb 1a                	jmp    100e9e <printer_vprintf+0x58b>
  100e84:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e8b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e8f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e93:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e9a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e9e:	48 8b 00             	mov    (%rax),%rax
  100ea1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100ea5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100eac:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100eb3:	e9 79 01 00 00       	jmp    101031 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100eb8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ebf:	8b 00                	mov    (%rax),%eax
  100ec1:	83 f8 2f             	cmp    $0x2f,%eax
  100ec4:	77 30                	ja     100ef6 <printer_vprintf+0x5e3>
  100ec6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ecd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ed1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ed8:	8b 00                	mov    (%rax),%eax
  100eda:	89 c0                	mov    %eax,%eax
  100edc:	48 01 d0             	add    %rdx,%rax
  100edf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ee6:	8b 12                	mov    (%rdx),%edx
  100ee8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100eeb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ef2:	89 0a                	mov    %ecx,(%rdx)
  100ef4:	eb 1a                	jmp    100f10 <printer_vprintf+0x5fd>
  100ef6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100efd:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f01:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f05:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f0c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f10:	48 8b 00             	mov    (%rax),%rax
  100f13:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100f17:	e9 15 01 00 00       	jmp    101031 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100f1c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f23:	8b 00                	mov    (%rax),%eax
  100f25:	83 f8 2f             	cmp    $0x2f,%eax
  100f28:	77 30                	ja     100f5a <printer_vprintf+0x647>
  100f2a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f31:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f35:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f3c:	8b 00                	mov    (%rax),%eax
  100f3e:	89 c0                	mov    %eax,%eax
  100f40:	48 01 d0             	add    %rdx,%rax
  100f43:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f4a:	8b 12                	mov    (%rdx),%edx
  100f4c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f4f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f56:	89 0a                	mov    %ecx,(%rdx)
  100f58:	eb 1a                	jmp    100f74 <printer_vprintf+0x661>
  100f5a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f61:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f65:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f69:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f70:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f74:	8b 00                	mov    (%rax),%eax
  100f76:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100f7c:	e9 77 03 00 00       	jmp    1012f8 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100f81:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100f85:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100f89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f90:	8b 00                	mov    (%rax),%eax
  100f92:	83 f8 2f             	cmp    $0x2f,%eax
  100f95:	77 30                	ja     100fc7 <printer_vprintf+0x6b4>
  100f97:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f9e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fa2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fa9:	8b 00                	mov    (%rax),%eax
  100fab:	89 c0                	mov    %eax,%eax
  100fad:	48 01 d0             	add    %rdx,%rax
  100fb0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fb7:	8b 12                	mov    (%rdx),%edx
  100fb9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fbc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fc3:	89 0a                	mov    %ecx,(%rdx)
  100fc5:	eb 1a                	jmp    100fe1 <printer_vprintf+0x6ce>
  100fc7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fce:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fd2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fd6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fdd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fe1:	8b 00                	mov    (%rax),%eax
  100fe3:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100fe6:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100fea:	eb 45                	jmp    101031 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100fec:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100ff0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100ff4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ffb:	0f b6 00             	movzbl (%rax),%eax
  100ffe:	84 c0                	test   %al,%al
  101000:	74 0c                	je     10100e <printer_vprintf+0x6fb>
  101002:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101009:	0f b6 00             	movzbl (%rax),%eax
  10100c:	eb 05                	jmp    101013 <printer_vprintf+0x700>
  10100e:	b8 25 00 00 00       	mov    $0x25,%eax
  101013:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101016:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  10101a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101021:	0f b6 00             	movzbl (%rax),%eax
  101024:	84 c0                	test   %al,%al
  101026:	75 08                	jne    101030 <printer_vprintf+0x71d>
                format--;
  101028:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  10102f:	01 
            }
            break;
  101030:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  101031:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101034:	83 e0 20             	and    $0x20,%eax
  101037:	85 c0                	test   %eax,%eax
  101039:	74 1e                	je     101059 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  10103b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10103f:	48 83 c0 18          	add    $0x18,%rax
  101043:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101046:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10104a:	48 89 ce             	mov    %rcx,%rsi
  10104d:	48 89 c7             	mov    %rax,%rdi
  101050:	e8 32 f8 ff ff       	call   100887 <fill_numbuf>
  101055:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  101059:	48 8d 05 f6 05 00 00 	lea    0x5f6(%rip),%rax        # 101656 <flag_chars+0x6>
  101060:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  101064:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101067:	83 e0 20             	and    $0x20,%eax
  10106a:	85 c0                	test   %eax,%eax
  10106c:	74 51                	je     1010bf <printer_vprintf+0x7ac>
  10106e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101071:	83 e0 40             	and    $0x40,%eax
  101074:	85 c0                	test   %eax,%eax
  101076:	74 47                	je     1010bf <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  101078:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10107b:	25 80 00 00 00       	and    $0x80,%eax
  101080:	85 c0                	test   %eax,%eax
  101082:	74 0d                	je     101091 <printer_vprintf+0x77e>
                prefix = "-";
  101084:	48 8d 05 cc 05 00 00 	lea    0x5cc(%rip),%rax        # 101657 <flag_chars+0x7>
  10108b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  10108f:	eb 7d                	jmp    10110e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101091:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101094:	83 e0 10             	and    $0x10,%eax
  101097:	85 c0                	test   %eax,%eax
  101099:	74 0d                	je     1010a8 <printer_vprintf+0x795>
                prefix = "+";
  10109b:	48 8d 05 b7 05 00 00 	lea    0x5b7(%rip),%rax        # 101659 <flag_chars+0x9>
  1010a2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1010a6:	eb 66                	jmp    10110e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  1010a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010ab:	83 e0 08             	and    $0x8,%eax
  1010ae:	85 c0                	test   %eax,%eax
  1010b0:	74 5c                	je     10110e <printer_vprintf+0x7fb>
                prefix = " ";
  1010b2:	48 8d 05 a2 05 00 00 	lea    0x5a2(%rip),%rax        # 10165b <flag_chars+0xb>
  1010b9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1010bd:	eb 4f                	jmp    10110e <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1010bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010c2:	83 e0 20             	and    $0x20,%eax
  1010c5:	85 c0                	test   %eax,%eax
  1010c7:	74 46                	je     10110f <printer_vprintf+0x7fc>
  1010c9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010cc:	83 e0 01             	and    $0x1,%eax
  1010cf:	85 c0                	test   %eax,%eax
  1010d1:	74 3c                	je     10110f <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  1010d3:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1010d7:	74 06                	je     1010df <printer_vprintf+0x7cc>
  1010d9:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1010dd:	75 30                	jne    10110f <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  1010df:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1010e4:	75 0c                	jne    1010f2 <printer_vprintf+0x7df>
  1010e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010e9:	25 00 01 00 00       	and    $0x100,%eax
  1010ee:	85 c0                	test   %eax,%eax
  1010f0:	74 1d                	je     10110f <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  1010f2:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1010f6:	75 09                	jne    101101 <printer_vprintf+0x7ee>
  1010f8:	48 8d 05 5e 05 00 00 	lea    0x55e(%rip),%rax        # 10165d <flag_chars+0xd>
  1010ff:	eb 07                	jmp    101108 <printer_vprintf+0x7f5>
  101101:	48 8d 05 58 05 00 00 	lea    0x558(%rip),%rax        # 101660 <flag_chars+0x10>
  101108:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10110c:	eb 01                	jmp    10110f <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  10110e:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  10110f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101113:	78 24                	js     101139 <printer_vprintf+0x826>
  101115:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101118:	83 e0 20             	and    $0x20,%eax
  10111b:	85 c0                	test   %eax,%eax
  10111d:	75 1a                	jne    101139 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  10111f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101122:	48 63 d0             	movslq %eax,%rdx
  101125:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101129:	48 89 d6             	mov    %rdx,%rsi
  10112c:	48 89 c7             	mov    %rax,%rdi
  10112f:	e8 91 f5 ff ff       	call   1006c5 <strnlen>
  101134:	89 45 bc             	mov    %eax,-0x44(%rbp)
  101137:	eb 0f                	jmp    101148 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  101139:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10113d:	48 89 c7             	mov    %rax,%rdi
  101140:	e8 4b f5 ff ff       	call   100690 <strlen>
  101145:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  101148:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10114b:	83 e0 20             	and    $0x20,%eax
  10114e:	85 c0                	test   %eax,%eax
  101150:	74 20                	je     101172 <printer_vprintf+0x85f>
  101152:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101156:	78 1a                	js     101172 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  101158:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10115b:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  10115e:	7e 08                	jle    101168 <printer_vprintf+0x855>
  101160:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101163:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101166:	eb 05                	jmp    10116d <printer_vprintf+0x85a>
  101168:	b8 00 00 00 00       	mov    $0x0,%eax
  10116d:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101170:	eb 5c                	jmp    1011ce <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  101172:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101175:	83 e0 20             	and    $0x20,%eax
  101178:	85 c0                	test   %eax,%eax
  10117a:	74 4b                	je     1011c7 <printer_vprintf+0x8b4>
  10117c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10117f:	83 e0 02             	and    $0x2,%eax
  101182:	85 c0                	test   %eax,%eax
  101184:	74 41                	je     1011c7 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  101186:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101189:	83 e0 04             	and    $0x4,%eax
  10118c:	85 c0                	test   %eax,%eax
  10118e:	75 37                	jne    1011c7 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  101190:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101194:	48 89 c7             	mov    %rax,%rdi
  101197:	e8 f4 f4 ff ff       	call   100690 <strlen>
  10119c:	89 c2                	mov    %eax,%edx
  10119e:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1011a1:	01 d0                	add    %edx,%eax
  1011a3:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  1011a6:	7e 1f                	jle    1011c7 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  1011a8:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1011ab:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1011ae:	89 c3                	mov    %eax,%ebx
  1011b0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1011b4:	48 89 c7             	mov    %rax,%rdi
  1011b7:	e8 d4 f4 ff ff       	call   100690 <strlen>
  1011bc:	89 c2                	mov    %eax,%edx
  1011be:	89 d8                	mov    %ebx,%eax
  1011c0:	29 d0                	sub    %edx,%eax
  1011c2:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1011c5:	eb 07                	jmp    1011ce <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  1011c7:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  1011ce:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1011d1:	8b 45 b8             	mov    -0x48(%rbp),%eax
  1011d4:	01 d0                	add    %edx,%eax
  1011d6:	48 63 d8             	movslq %eax,%rbx
  1011d9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1011dd:	48 89 c7             	mov    %rax,%rdi
  1011e0:	e8 ab f4 ff ff       	call   100690 <strlen>
  1011e5:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1011e9:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1011ec:	29 d0                	sub    %edx,%eax
  1011ee:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1011f1:	eb 25                	jmp    101218 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  1011f3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1011fa:	48 8b 08             	mov    (%rax),%rcx
  1011fd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101203:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10120a:	be 20 00 00 00       	mov    $0x20,%esi
  10120f:	48 89 c7             	mov    %rax,%rdi
  101212:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101214:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101218:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10121b:	83 e0 04             	and    $0x4,%eax
  10121e:	85 c0                	test   %eax,%eax
  101220:	75 36                	jne    101258 <printer_vprintf+0x945>
  101222:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101226:	7f cb                	jg     1011f3 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  101228:	eb 2e                	jmp    101258 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  10122a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101231:	4c 8b 00             	mov    (%rax),%r8
  101234:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101238:	0f b6 00             	movzbl (%rax),%eax
  10123b:	0f b6 c8             	movzbl %al,%ecx
  10123e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101244:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10124b:	89 ce                	mov    %ecx,%esi
  10124d:	48 89 c7             	mov    %rax,%rdi
  101250:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101253:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101258:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10125c:	0f b6 00             	movzbl (%rax),%eax
  10125f:	84 c0                	test   %al,%al
  101261:	75 c7                	jne    10122a <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  101263:	eb 25                	jmp    10128a <printer_vprintf+0x977>
            p->putc(p, '0', color);
  101265:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10126c:	48 8b 08             	mov    (%rax),%rcx
  10126f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101275:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10127c:	be 30 00 00 00       	mov    $0x30,%esi
  101281:	48 89 c7             	mov    %rax,%rdi
  101284:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101286:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  10128a:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  10128e:	7f d5                	jg     101265 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  101290:	eb 32                	jmp    1012c4 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  101292:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101299:	4c 8b 00             	mov    (%rax),%r8
  10129c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1012a0:	0f b6 00             	movzbl (%rax),%eax
  1012a3:	0f b6 c8             	movzbl %al,%ecx
  1012a6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012ac:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012b3:	89 ce                	mov    %ecx,%esi
  1012b5:	48 89 c7             	mov    %rax,%rdi
  1012b8:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  1012bb:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  1012c0:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  1012c4:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  1012c8:	7f c8                	jg     101292 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  1012ca:	eb 25                	jmp    1012f1 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  1012cc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012d3:	48 8b 08             	mov    (%rax),%rcx
  1012d6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012dc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012e3:	be 20 00 00 00       	mov    $0x20,%esi
  1012e8:	48 89 c7             	mov    %rax,%rdi
  1012eb:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1012ed:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1012f1:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1012f5:	7f d5                	jg     1012cc <printer_vprintf+0x9b9>
        }
    done: ;
  1012f7:	90                   	nop
    for (; *format; ++format) {
  1012f8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1012ff:	01 
  101300:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101307:	0f b6 00             	movzbl (%rax),%eax
  10130a:	84 c0                	test   %al,%al
  10130c:	0f 85 31 f6 ff ff    	jne    100943 <printer_vprintf+0x30>
    }
}
  101312:	90                   	nop
  101313:	90                   	nop
  101314:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101318:	c9                   	leave  
  101319:	c3                   	ret    

000000000010131a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  10131a:	f3 0f 1e fa          	endbr64 
  10131e:	55                   	push   %rbp
  10131f:	48 89 e5             	mov    %rsp,%rbp
  101322:	48 83 ec 20          	sub    $0x20,%rsp
  101326:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10132a:	89 f0                	mov    %esi,%eax
  10132c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10132f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101332:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101336:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10133a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10133e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101342:	48 8d 15 57 7c fb ff 	lea    -0x483a9(%rip),%rdx        # b8fa0 <console+0xfa0>
  101349:	48 39 d0             	cmp    %rdx,%rax
  10134c:	72 0f                	jb     10135d <console_putc+0x43>
        cp->cursor = console;
  10134e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101352:	48 8d 15 a7 6c fb ff 	lea    -0x49359(%rip),%rdx        # b8000 <console>
  101359:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  10135d:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101361:	0f 85 82 00 00 00    	jne    1013e9 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  101367:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10136b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10136f:	48 8d 15 8a 6c fb ff 	lea    -0x49376(%rip),%rdx        # b8000 <console>
  101376:	48 29 d0             	sub    %rdx,%rax
  101379:	48 d1 f8             	sar    %rax
  10137c:	48 89 c1             	mov    %rax,%rcx
  10137f:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101386:	66 66 66 
  101389:	48 89 c8             	mov    %rcx,%rax
  10138c:	48 f7 ea             	imul   %rdx
  10138f:	48 89 d0             	mov    %rdx,%rax
  101392:	48 c1 f8 05          	sar    $0x5,%rax
  101396:	48 89 ce             	mov    %rcx,%rsi
  101399:	48 c1 fe 3f          	sar    $0x3f,%rsi
  10139d:	48 29 f0             	sub    %rsi,%rax
  1013a0:	48 89 c2             	mov    %rax,%rdx
  1013a3:	48 89 d0             	mov    %rdx,%rax
  1013a6:	48 c1 e0 02          	shl    $0x2,%rax
  1013aa:	48 01 d0             	add    %rdx,%rax
  1013ad:	48 c1 e0 04          	shl    $0x4,%rax
  1013b1:	48 29 c1             	sub    %rax,%rcx
  1013b4:	48 89 ca             	mov    %rcx,%rdx
  1013b7:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1013ba:	eb 25                	jmp    1013e1 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  1013bc:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1013bf:	83 c8 20             	or     $0x20,%eax
  1013c2:	89 c6                	mov    %eax,%esi
  1013c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013c8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013cc:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1013d0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1013d4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1013d8:	89 f2                	mov    %esi,%edx
  1013da:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1013dd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1013e1:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1013e5:	75 d5                	jne    1013bc <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1013e7:	eb 24                	jmp    10140d <console_putc+0xf3>
        *cp->cursor++ = c | color;
  1013e9:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1013ed:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1013f0:	89 d6                	mov    %edx,%esi
  1013f2:	09 c6                	or     %eax,%esi
  1013f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013f8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013fc:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101400:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101404:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101408:	89 f2                	mov    %esi,%edx
  10140a:	66 89 10             	mov    %dx,(%rax)
}
  10140d:	90                   	nop
  10140e:	c9                   	leave  
  10140f:	c3                   	ret    

0000000000101410 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101410:	f3 0f 1e fa          	endbr64 
  101414:	55                   	push   %rbp
  101415:	48 89 e5             	mov    %rsp,%rbp
  101418:	48 83 ec 30          	sub    $0x30,%rsp
  10141c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10141f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101422:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101426:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  10142a:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 10131a <console_putc>
  101431:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101435:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101439:	78 09                	js     101444 <console_vprintf+0x34>
  10143b:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101442:	7e 07                	jle    10144b <console_vprintf+0x3b>
        cpos = 0;
  101444:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10144b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10144e:	48 98                	cltq   
  101450:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101454:	48 8d 05 a5 6b fb ff 	lea    -0x4945b(%rip),%rax        # b8000 <console>
  10145b:	48 01 d0             	add    %rdx,%rax
  10145e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101462:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101466:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10146a:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10146d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101471:	48 89 c7             	mov    %rax,%rdi
  101474:	e8 9a f4 ff ff       	call   100913 <printer_vprintf>
    return cp.cursor - console;
  101479:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10147d:	48 8d 15 7c 6b fb ff 	lea    -0x49484(%rip),%rdx        # b8000 <console>
  101484:	48 29 d0             	sub    %rdx,%rax
  101487:	48 d1 f8             	sar    %rax
}
  10148a:	c9                   	leave  
  10148b:	c3                   	ret    

000000000010148c <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10148c:	f3 0f 1e fa          	endbr64 
  101490:	55                   	push   %rbp
  101491:	48 89 e5             	mov    %rsp,%rbp
  101494:	48 83 ec 60          	sub    $0x60,%rsp
  101498:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10149b:	89 75 a8             	mov    %esi,-0x58(%rbp)
  10149e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1014a2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1014a6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1014aa:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1014ae:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1014b5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1014b9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1014bd:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1014c1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1014c5:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1014c9:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1014cd:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1014d0:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1014d3:	89 c7                	mov    %eax,%edi
  1014d5:	e8 36 ff ff ff       	call   101410 <console_vprintf>
  1014da:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1014dd:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1014e0:	c9                   	leave  
  1014e1:	c3                   	ret    

00000000001014e2 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1014e2:	f3 0f 1e fa          	endbr64 
  1014e6:	55                   	push   %rbp
  1014e7:	48 89 e5             	mov    %rsp,%rbp
  1014ea:	48 83 ec 20          	sub    $0x20,%rsp
  1014ee:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1014f2:	89 f0                	mov    %esi,%eax
  1014f4:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1014f7:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1014fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1014fe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101502:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101506:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10150a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10150e:	48 8b 40 10          	mov    0x10(%rax),%rax
  101512:	48 39 c2             	cmp    %rax,%rdx
  101515:	73 1a                	jae    101531 <string_putc+0x4f>
        *sp->s++ = c;
  101517:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10151b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10151f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101523:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101527:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10152b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10152f:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101531:	90                   	nop
  101532:	c9                   	leave  
  101533:	c3                   	ret    

0000000000101534 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101534:	f3 0f 1e fa          	endbr64 
  101538:	55                   	push   %rbp
  101539:	48 89 e5             	mov    %rsp,%rbp
  10153c:	48 83 ec 40          	sub    $0x40,%rsp
  101540:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101544:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101548:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10154c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101550:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 1014e2 <string_putc>
  101557:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  10155b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10155f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101563:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101568:	74 33                	je     10159d <vsnprintf+0x69>
        sp.end = s + size - 1;
  10156a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  10156e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101572:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101576:	48 01 d0             	add    %rdx,%rax
  101579:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10157d:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101581:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101585:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101589:	be 00 00 00 00       	mov    $0x0,%esi
  10158e:	48 89 c7             	mov    %rax,%rdi
  101591:	e8 7d f3 ff ff       	call   100913 <printer_vprintf>
        *sp.s = 0;
  101596:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10159a:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10159d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1015a1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1015a5:	c9                   	leave  
  1015a6:	c3                   	ret    

00000000001015a7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1015a7:	f3 0f 1e fa          	endbr64 
  1015ab:	55                   	push   %rbp
  1015ac:	48 89 e5             	mov    %rsp,%rbp
  1015af:	48 83 ec 70          	sub    $0x70,%rsp
  1015b3:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1015b7:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1015bb:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1015bf:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1015c3:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1015c7:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1015cb:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1015d2:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1015d6:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1015da:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1015de:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1015e2:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1015e6:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1015ea:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1015ee:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1015f2:	48 89 c7             	mov    %rax,%rdi
  1015f5:	e8 3a ff ff ff       	call   101534 <vsnprintf>
  1015fa:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1015fd:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101600:	c9                   	leave  
  101601:	c3                   	ret    

0000000000101602 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101602:	f3 0f 1e fa          	endbr64 
  101606:	55                   	push   %rbp
  101607:	48 89 e5             	mov    %rsp,%rbp
  10160a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10160e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101615:	eb 1a                	jmp    101631 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101617:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10161a:	48 98                	cltq   
  10161c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101620:	48 8d 05 d9 69 fb ff 	lea    -0x49627(%rip),%rax        # b8000 <console>
  101627:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10162d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101631:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101638:	7e dd                	jle    101617 <console_clear+0x15>
    }
    cursorpos = 0;
  10163a:	c7 05 b8 79 fb ff 00 	movl   $0x0,-0x48648(%rip)        # b8ffc <cursorpos>
  101641:	00 00 00 
}
  101644:	90                   	nop
  101645:	c9                   	leave  
  101646:	c3                   	ret    
