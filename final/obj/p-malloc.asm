
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
  10003d:	e8 f0 05 00 00       	call   100632 <rand>
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
  100065:	e8 73 01 00 00       	call   1001dd <malloc>
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
block* new_block(size_t size);
block* split_block(block* block, size_t size);
void add_to_free_list(block *b);
void remove_from_free_list(block *b);

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
  100091:	48 89 05 78 1f 00 00 	mov    %rax,0x1f78(%rip)        # 102010 <result.0>
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
  1000d2:	48 8b 05 3f 1f 00 00 	mov    0x1f3f(%rip),%rax        # 102018 <free_head>
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
  1000f8:	48 8b 05 19 1f 00 00 	mov    0x1f19(%rip),%rax        # 102018 <free_head>
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
  100114:	48 89 3d fd 1e 00 00 	mov    %rdi,0x1efd(%rip)        # 102018 <free_head>
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
  1001b5:	48 89 05 5c 1e 00 00 	mov    %rax,0x1e5c(%rip)        # 102018 <free_head>
  1001bc:	eb ca                	jmp    100188 <remove_from_free_list+0x15>

00000000001001be <free>:

void free(void *firstbyte) {
  1001be:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  1001c2:	48 85 ff             	test   %rdi,%rdi
  1001c5:	74 06                	je     1001cd <free+0xf>
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; // Prevent double-free
  1001c7:	83 7f e8 00          	cmpl   $0x0,-0x18(%rdi)
  1001cb:	74 01                	je     1001ce <free+0x10>
  1001cd:	c3                   	ret    
void free(void *firstbyte) {
  1001ce:	55                   	push   %rbp
  1001cf:	48 89 e5             	mov    %rsp,%rbp
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
  1001d2:	48 83 ef 28          	sub    $0x28,%rdi
    add_to_free_list(b);
  1001d6:	e8 12 ff ff ff       	call   1000ed <add_to_free_list>
    // defrag();
}
  1001db:	5d                   	pop    %rbp
  1001dc:	c3                   	ret    

00000000001001dd <malloc>:

void *malloc(uint64_t numbytes) {
  1001dd:	f3 0f 1e fa          	endbr64 
  1001e1:	55                   	push   %rbp
  1001e2:	48 89 e5             	mov    %rsp,%rbp
  1001e5:	41 54                	push   %r12
  1001e7:	53                   	push   %rbx
    return (size + 7) / 8 * 8;
  1001e8:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  1001ec:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    size_t size = algn(numbytes);
    block *b = find_block(size);
  1001f0:	4c 89 e7             	mov    %r12,%rdi
  1001f3:	e8 d6 fe ff ff       	call   1000ce <find_block>
    if (b == NULL) {
  1001f8:	48 85 c0             	test   %rax,%rax
  1001fb:	74 21                	je     10021e <malloc+0x41>
  1001fd:	48 89 c3             	mov    %rax,%rbx
        b = new_block(size);
        if (b == NULL) {
            return NULL;
        }
    } else {
        remove_from_free_list(b);
  100200:	48 89 c7             	mov    %rax,%rdi
  100203:	e8 6b ff ff ff       	call   100173 <remove_from_free_list>
        if (b->size > size + BLOCKSIZE) {
  100208:	49 8d 44 24 28       	lea    0x28(%r12),%rax
  10020d:	48 39 03             	cmp    %rax,(%rbx)
  100210:	77 1e                	ja     100230 <malloc+0x53>
            split_block(b, size);
        }
    }
    return (void*)((void*)b + BLOCKSIZE);
  100212:	48 83 c3 28          	add    $0x28,%rbx
}
  100216:	48 89 d8             	mov    %rbx,%rax
  100219:	5b                   	pop    %rbx
  10021a:	41 5c                	pop    %r12
  10021c:	5d                   	pop    %rbp
  10021d:	c3                   	ret    
        b = new_block(size);
  10021e:	4c 89 e7             	mov    %r12,%rdi
  100221:	e8 5e fe ff ff       	call   100084 <new_block>
  100226:	48 89 c3             	mov    %rax,%rbx
        if (b == NULL) {
  100229:	48 85 c0             	test   %rax,%rax
  10022c:	75 e4                	jne    100212 <malloc+0x35>
  10022e:	eb e6                	jmp    100216 <malloc+0x39>
            split_block(b, size);
  100230:	4c 89 e6             	mov    %r12,%rsi
  100233:	48 89 df             	mov    %rbx,%rdi
  100236:	e8 e1 fe ff ff       	call   10011c <split_block>
  10023b:	eb d5                	jmp    100212 <malloc+0x35>

000000000010023d <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  10023d:	f3 0f 1e fa          	endbr64 
  100241:	55                   	push   %rbp
  100242:	48 89 e5             	mov    %rsp,%rbp
  100245:	41 54                	push   %r12
  100247:	53                   	push   %rbx
    uint64_t total = num * sz;
  100248:	48 0f af fe          	imul   %rsi,%rdi
  10024c:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  10024f:	e8 89 ff ff ff       	call   1001dd <malloc>
  100254:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  100257:	48 85 c0             	test   %rax,%rax
  10025a:	74 10                	je     10026c <calloc+0x2f>
        memset(ptr, 0, total);
  10025c:	4c 89 e2             	mov    %r12,%rdx
  10025f:	be 00 00 00 00       	mov    $0x0,%esi
  100264:	48 89 c7             	mov    %rax,%rdi
  100267:	e8 f1 01 00 00       	call   10045d <memset>
    }
    return ptr;
}
  10026c:	48 89 d8             	mov    %rbx,%rax
  10026f:	5b                   	pop    %rbx
  100270:	41 5c                	pop    %r12
  100272:	5d                   	pop    %rbp
  100273:	c3                   	ret    

0000000000100274 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  100274:	f3 0f 1e fa          	endbr64 
  100278:	55                   	push   %rbp
  100279:	48 89 e5             	mov    %rsp,%rbp
  10027c:	41 54                	push   %r12
  10027e:	53                   	push   %rbx
  10027f:	48 89 fb             	mov    %rdi,%rbx
  100282:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  100285:	48 85 db             	test   %rbx,%rbx
  100288:	74 2d                	je     1002b7 <realloc+0x43>
        return malloc(sz);
    }
    if (sz == 0) {
  10028a:	48 85 f6             	test   %rsi,%rsi
  10028d:	74 32                	je     1002c1 <realloc+0x4d>
    return (size + 7) / 8 * 8;
  10028f:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  100293:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi
        return NULL;
    }
    block *b = (block*)((void*)ptr - BLOCKSIZE);
    size_t aligned_size = algn(sz);

    if (b->size >= aligned_size) {
  100297:	48 8b 43 d8          	mov    -0x28(%rbx),%rax
  10029b:	48 39 f0             	cmp    %rsi,%rax
  10029e:	72 31                	jb     1002d1 <realloc+0x5d>
        if (b->size > aligned_size + BLOCKSIZE) {
  1002a0:	48 8d 56 28          	lea    0x28(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr;
  1002a4:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  1002a7:	48 39 d0             	cmp    %rdx,%rax
  1002aa:	76 49                	jbe    1002f5 <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE);
  1002ac:	48 8d 7b d8          	lea    -0x28(%rbx),%rdi
            split_block(b, aligned_size);
  1002b0:	e8 67 fe ff ff       	call   10011c <split_block>
  1002b5:	eb 3e                	jmp    1002f5 <realloc+0x81>
        return malloc(sz);
  1002b7:	e8 21 ff ff ff       	call   1001dd <malloc>
  1002bc:	49 89 c4             	mov    %rax,%r12
  1002bf:	eb 34                	jmp    1002f5 <realloc+0x81>
        free(ptr);
  1002c1:	48 89 df             	mov    %rbx,%rdi
  1002c4:	e8 f5 fe ff ff       	call   1001be <free>
        return NULL;
  1002c9:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  1002cf:	eb 24                	jmp    1002f5 <realloc+0x81>
    }

    void *new_ptr = malloc(sz);
  1002d1:	e8 07 ff ff ff       	call   1001dd <malloc>
  1002d6:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  1002d9:	48 85 c0             	test   %rax,%rax
  1002dc:	74 17                	je     1002f5 <realloc+0x81>
        return NULL;
    }
    memcpy(new_ptr, ptr, b->size);
  1002de:	48 8b 53 d8          	mov    -0x28(%rbx),%rdx
  1002e2:	48 89 de             	mov    %rbx,%rsi
  1002e5:	48 89 c7             	mov    %rax,%rdi
  1002e8:	e8 6a 00 00 00       	call   100357 <memcpy>
    free(ptr);
  1002ed:	48 89 df             	mov    %rbx,%rdi
  1002f0:	e8 c9 fe ff ff       	call   1001be <free>
    return new_ptr;
}
  1002f5:	4c 89 e0             	mov    %r12,%rax
  1002f8:	5b                   	pop    %rbx
  1002f9:	41 5c                	pop    %r12
  1002fb:	5d                   	pop    %rbp
  1002fc:	c3                   	ret    

00000000001002fd <defrag>:

void defrag() {
  1002fd:	f3 0f 1e fa          	endbr64 
  100301:	55                   	push   %rbp
  100302:	48 89 e5             	mov    %rsp,%rbp
  100305:	41 54                	push   %r12
  100307:	53                   	push   %rbx
    block *b = free_head;
  100308:	48 8b 1d 09 1d 00 00 	mov    0x1d09(%rip),%rbx        # 102018 <free_head>
    while (b && b->free_next) {
  10030f:	48 85 db             	test   %rbx,%rbx
  100312:	74 34                	je     100348 <defrag+0x4b>
  100314:	4c 8b 63 18          	mov    0x18(%rbx),%r12
  100318:	4d 85 e4             	test   %r12,%r12
  10031b:	74 2b                	je     100348 <defrag+0x4b>
        if ((void*)b + BLOCKSIZE + b->size == (void*)b->free_next) {
  10031d:	48 8b 03             	mov    (%rbx),%rax
  100320:	48 8d 44 03 28       	lea    0x28(%rbx,%rax,1),%rax
  100325:	49 39 c4             	cmp    %rax,%r12
  100328:	74 05                	je     10032f <defrag+0x32>
    while (b && b->free_next) {
  10032a:	4c 89 e3             	mov    %r12,%rbx
  10032d:	eb e0                	jmp    10030f <defrag+0x12>
            block *next = b->free_next;
            remove_from_free_list(next);
  10032f:	4c 89 e7             	mov    %r12,%rdi
  100332:	e8 3c fe ff ff       	call   100173 <remove_from_free_list>
            b->size += BLOCKSIZE + next->size;
  100337:	48 8b 13             	mov    (%rbx),%rdx
  10033a:	49 8b 04 24          	mov    (%r12),%rax
  10033e:	48 8d 44 02 28       	lea    0x28(%rdx,%rax,1),%rax
  100343:	48 89 03             	mov    %rax,(%rbx)
  100346:	eb c7                	jmp    10030f <defrag+0x12>
        } else {
            b = b->free_next;
        }
    }
}
  100348:	5b                   	pop    %rbx
  100349:	41 5c                	pop    %r12
  10034b:	5d                   	pop    %rbp
  10034c:	c3                   	ret    

000000000010034d <heap_info>:

int heap_info(heap_info_struct * info) {
  10034d:	f3 0f 1e fa          	endbr64 
    return 0;
  100351:	b8 00 00 00 00       	mov    $0x0,%eax
  100356:	c3                   	ret    

0000000000100357 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100357:	f3 0f 1e fa          	endbr64 
  10035b:	55                   	push   %rbp
  10035c:	48 89 e5             	mov    %rsp,%rbp
  10035f:	48 83 ec 28          	sub    $0x28,%rsp
  100363:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100367:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10036b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10036f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100373:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100377:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10037b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10037f:	eb 1c                	jmp    10039d <memcpy+0x46>
        *d = *s;
  100381:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100385:	0f b6 10             	movzbl (%rax),%edx
  100388:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10038c:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10038e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100393:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100398:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  10039d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1003a2:	75 dd                	jne    100381 <memcpy+0x2a>
    }
    return dst;
  1003a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003a8:	c9                   	leave  
  1003a9:	c3                   	ret    

00000000001003aa <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1003aa:	f3 0f 1e fa          	endbr64 
  1003ae:	55                   	push   %rbp
  1003af:	48 89 e5             	mov    %rsp,%rbp
  1003b2:	48 83 ec 28          	sub    $0x28,%rsp
  1003b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003ba:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1003be:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1003c2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1003c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1003ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003ce:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1003d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003d6:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1003da:	73 6a                	jae    100446 <memmove+0x9c>
  1003dc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1003e0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003e4:	48 01 d0             	add    %rdx,%rax
  1003e7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1003eb:	73 59                	jae    100446 <memmove+0x9c>
        s += n, d += n;
  1003ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003f1:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1003f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003f9:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1003fd:	eb 17                	jmp    100416 <memmove+0x6c>
            *--d = *--s;
  1003ff:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100404:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100409:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10040d:	0f b6 10             	movzbl (%rax),%edx
  100410:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100414:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100416:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10041a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10041e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100422:	48 85 c0             	test   %rax,%rax
  100425:	75 d8                	jne    1003ff <memmove+0x55>
    if (s < d && s + n > d) {
  100427:	eb 2e                	jmp    100457 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100429:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10042d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100431:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100435:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100439:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10043d:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100441:	0f b6 12             	movzbl (%rdx),%edx
  100444:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100446:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10044a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10044e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100452:	48 85 c0             	test   %rax,%rax
  100455:	75 d2                	jne    100429 <memmove+0x7f>
        }
    }
    return dst;
  100457:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10045b:	c9                   	leave  
  10045c:	c3                   	ret    

000000000010045d <memset>:

void* memset(void* v, int c, size_t n) {
  10045d:	f3 0f 1e fa          	endbr64 
  100461:	55                   	push   %rbp
  100462:	48 89 e5             	mov    %rsp,%rbp
  100465:	48 83 ec 28          	sub    $0x28,%rsp
  100469:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10046d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100470:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100474:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100478:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10047c:	eb 15                	jmp    100493 <memset+0x36>
        *p = c;
  10047e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100481:	89 c2                	mov    %eax,%edx
  100483:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100487:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100489:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10048e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100493:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100498:	75 e4                	jne    10047e <memset+0x21>
    }
    return v;
  10049a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10049e:	c9                   	leave  
  10049f:	c3                   	ret    

00000000001004a0 <strlen>:

size_t strlen(const char* s) {
  1004a0:	f3 0f 1e fa          	endbr64 
  1004a4:	55                   	push   %rbp
  1004a5:	48 89 e5             	mov    %rsp,%rbp
  1004a8:	48 83 ec 18          	sub    $0x18,%rsp
  1004ac:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1004b0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1004b7:	00 
  1004b8:	eb 0a                	jmp    1004c4 <strlen+0x24>
        ++n;
  1004ba:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1004bf:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1004c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004c8:	0f b6 00             	movzbl (%rax),%eax
  1004cb:	84 c0                	test   %al,%al
  1004cd:	75 eb                	jne    1004ba <strlen+0x1a>
    }
    return n;
  1004cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1004d3:	c9                   	leave  
  1004d4:	c3                   	ret    

00000000001004d5 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1004d5:	f3 0f 1e fa          	endbr64 
  1004d9:	55                   	push   %rbp
  1004da:	48 89 e5             	mov    %rsp,%rbp
  1004dd:	48 83 ec 20          	sub    $0x20,%rsp
  1004e1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004e5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1004e9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1004f0:	00 
  1004f1:	eb 0a                	jmp    1004fd <strnlen+0x28>
        ++n;
  1004f3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1004f8:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1004fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100501:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100505:	74 0b                	je     100512 <strnlen+0x3d>
  100507:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10050b:	0f b6 00             	movzbl (%rax),%eax
  10050e:	84 c0                	test   %al,%al
  100510:	75 e1                	jne    1004f3 <strnlen+0x1e>
    }
    return n;
  100512:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100516:	c9                   	leave  
  100517:	c3                   	ret    

0000000000100518 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100518:	f3 0f 1e fa          	endbr64 
  10051c:	55                   	push   %rbp
  10051d:	48 89 e5             	mov    %rsp,%rbp
  100520:	48 83 ec 20          	sub    $0x20,%rsp
  100524:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100528:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  10052c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100530:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100534:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100538:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10053c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100540:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100544:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100548:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  10054c:	0f b6 12             	movzbl (%rdx),%edx
  10054f:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100551:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100555:	48 83 e8 01          	sub    $0x1,%rax
  100559:	0f b6 00             	movzbl (%rax),%eax
  10055c:	84 c0                	test   %al,%al
  10055e:	75 d4                	jne    100534 <strcpy+0x1c>
    return dst;
  100560:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100564:	c9                   	leave  
  100565:	c3                   	ret    

0000000000100566 <strcmp>:

int strcmp(const char* a, const char* b) {
  100566:	f3 0f 1e fa          	endbr64 
  10056a:	55                   	push   %rbp
  10056b:	48 89 e5             	mov    %rsp,%rbp
  10056e:	48 83 ec 10          	sub    $0x10,%rsp
  100572:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100576:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10057a:	eb 0a                	jmp    100586 <strcmp+0x20>
        ++a, ++b;
  10057c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100581:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100586:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10058a:	0f b6 00             	movzbl (%rax),%eax
  10058d:	84 c0                	test   %al,%al
  10058f:	74 1d                	je     1005ae <strcmp+0x48>
  100591:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100595:	0f b6 00             	movzbl (%rax),%eax
  100598:	84 c0                	test   %al,%al
  10059a:	74 12                	je     1005ae <strcmp+0x48>
  10059c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005a0:	0f b6 10             	movzbl (%rax),%edx
  1005a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1005a7:	0f b6 00             	movzbl (%rax),%eax
  1005aa:	38 c2                	cmp    %al,%dl
  1005ac:	74 ce                	je     10057c <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1005ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005b2:	0f b6 00             	movzbl (%rax),%eax
  1005b5:	89 c2                	mov    %eax,%edx
  1005b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1005bb:	0f b6 00             	movzbl (%rax),%eax
  1005be:	38 c2                	cmp    %al,%dl
  1005c0:	0f 97 c0             	seta   %al
  1005c3:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1005c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005ca:	0f b6 00             	movzbl (%rax),%eax
  1005cd:	89 c1                	mov    %eax,%ecx
  1005cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1005d3:	0f b6 00             	movzbl (%rax),%eax
  1005d6:	38 c1                	cmp    %al,%cl
  1005d8:	0f 92 c0             	setb   %al
  1005db:	0f b6 c8             	movzbl %al,%ecx
  1005de:	89 d0                	mov    %edx,%eax
  1005e0:	29 c8                	sub    %ecx,%eax
}
  1005e2:	c9                   	leave  
  1005e3:	c3                   	ret    

00000000001005e4 <strchr>:

char* strchr(const char* s, int c) {
  1005e4:	f3 0f 1e fa          	endbr64 
  1005e8:	55                   	push   %rbp
  1005e9:	48 89 e5             	mov    %rsp,%rbp
  1005ec:	48 83 ec 10          	sub    $0x10,%rsp
  1005f0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1005f4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1005f7:	eb 05                	jmp    1005fe <strchr+0x1a>
        ++s;
  1005f9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1005fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100602:	0f b6 00             	movzbl (%rax),%eax
  100605:	84 c0                	test   %al,%al
  100607:	74 0e                	je     100617 <strchr+0x33>
  100609:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10060d:	0f b6 00             	movzbl (%rax),%eax
  100610:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100613:	38 d0                	cmp    %dl,%al
  100615:	75 e2                	jne    1005f9 <strchr+0x15>
    }
    if (*s == (char) c) {
  100617:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10061b:	0f b6 00             	movzbl (%rax),%eax
  10061e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100621:	38 d0                	cmp    %dl,%al
  100623:	75 06                	jne    10062b <strchr+0x47>
        return (char*) s;
  100625:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100629:	eb 05                	jmp    100630 <strchr+0x4c>
    } else {
        return NULL;
  10062b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100630:	c9                   	leave  
  100631:	c3                   	ret    

0000000000100632 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100632:	f3 0f 1e fa          	endbr64 
  100636:	55                   	push   %rbp
  100637:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  10063a:	8b 05 e0 19 00 00    	mov    0x19e0(%rip),%eax        # 102020 <rand_seed_set>
  100640:	85 c0                	test   %eax,%eax
  100642:	75 0a                	jne    10064e <rand+0x1c>
        srand(819234718U);
  100644:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100649:	e8 24 00 00 00       	call   100672 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  10064e:	8b 05 d0 19 00 00    	mov    0x19d0(%rip),%eax        # 102024 <rand_seed>
  100654:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  10065a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10065f:	89 05 bf 19 00 00    	mov    %eax,0x19bf(%rip)        # 102024 <rand_seed>
    return rand_seed & RAND_MAX;
  100665:	8b 05 b9 19 00 00    	mov    0x19b9(%rip),%eax        # 102024 <rand_seed>
  10066b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100670:	5d                   	pop    %rbp
  100671:	c3                   	ret    

0000000000100672 <srand>:

void srand(unsigned seed) {
  100672:	f3 0f 1e fa          	endbr64 
  100676:	55                   	push   %rbp
  100677:	48 89 e5             	mov    %rsp,%rbp
  10067a:	48 83 ec 08          	sub    $0x8,%rsp
  10067e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100681:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100684:	89 05 9a 19 00 00    	mov    %eax,0x199a(%rip)        # 102024 <rand_seed>
    rand_seed_set = 1;
  10068a:	c7 05 8c 19 00 00 01 	movl   $0x1,0x198c(%rip)        # 102020 <rand_seed_set>
  100691:	00 00 00 
}
  100694:	90                   	nop
  100695:	c9                   	leave  
  100696:	c3                   	ret    

0000000000100697 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100697:	f3 0f 1e fa          	endbr64 
  10069b:	55                   	push   %rbp
  10069c:	48 89 e5             	mov    %rsp,%rbp
  10069f:	48 83 ec 28          	sub    $0x28,%rsp
  1006a3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1006a7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1006ab:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1006ae:	48 8d 05 ab 0e 00 00 	lea    0xeab(%rip),%rax        # 101560 <upper_digits.1>
  1006b5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  1006b9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1006bd:	79 0e                	jns    1006cd <fill_numbuf+0x36>
        digits = lower_digits;
  1006bf:	48 8d 05 ba 0e 00 00 	lea    0xeba(%rip),%rax        # 101580 <lower_digits.0>
  1006c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  1006ca:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1006cd:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1006d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006d6:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1006d9:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1006dc:	48 63 c8             	movslq %eax,%rcx
  1006df:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1006e3:	ba 00 00 00 00       	mov    $0x0,%edx
  1006e8:	48 f7 f1             	div    %rcx
  1006eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006ef:	48 01 d0             	add    %rdx,%rax
  1006f2:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1006f7:	0f b6 10             	movzbl (%rax),%edx
  1006fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006fe:	88 10                	mov    %dl,(%rax)
        val /= base;
  100700:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100703:	48 63 f0             	movslq %eax,%rsi
  100706:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10070a:	ba 00 00 00 00       	mov    $0x0,%edx
  10070f:	48 f7 f6             	div    %rsi
  100712:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100716:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  10071b:	75 bc                	jne    1006d9 <fill_numbuf+0x42>
    return numbuf_end;
  10071d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100721:	c9                   	leave  
  100722:	c3                   	ret    

0000000000100723 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100723:	f3 0f 1e fa          	endbr64 
  100727:	55                   	push   %rbp
  100728:	48 89 e5             	mov    %rsp,%rbp
  10072b:	53                   	push   %rbx
  10072c:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100733:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  10073a:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100740:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100747:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  10074e:	e9 bd 09 00 00       	jmp    101110 <printer_vprintf+0x9ed>
        if (*format != '%') {
  100753:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10075a:	0f b6 00             	movzbl (%rax),%eax
  10075d:	3c 25                	cmp    $0x25,%al
  10075f:	74 31                	je     100792 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  100761:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100768:	4c 8b 00             	mov    (%rax),%r8
  10076b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100772:	0f b6 00             	movzbl (%rax),%eax
  100775:	0f b6 c8             	movzbl %al,%ecx
  100778:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10077e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100785:	89 ce                	mov    %ecx,%esi
  100787:	48 89 c7             	mov    %rax,%rdi
  10078a:	41 ff d0             	call   *%r8
            continue;
  10078d:	e9 76 09 00 00       	jmp    101108 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  100792:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100799:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007a0:	01 
  1007a1:	eb 4d                	jmp    1007f0 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  1007a3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007aa:	0f b6 00             	movzbl (%rax),%eax
  1007ad:	0f be c0             	movsbl %al,%eax
  1007b0:	89 c6                	mov    %eax,%esi
  1007b2:	48 8d 05 a7 0c 00 00 	lea    0xca7(%rip),%rax        # 101460 <flag_chars>
  1007b9:	48 89 c7             	mov    %rax,%rdi
  1007bc:	e8 23 fe ff ff       	call   1005e4 <strchr>
  1007c1:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1007c5:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1007ca:	74 34                	je     100800 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  1007cc:	48 8d 15 8d 0c 00 00 	lea    0xc8d(%rip),%rdx        # 101460 <flag_chars>
  1007d3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1007d7:	48 29 d0             	sub    %rdx,%rax
  1007da:	ba 01 00 00 00       	mov    $0x1,%edx
  1007df:	89 c1                	mov    %eax,%ecx
  1007e1:	d3 e2                	shl    %cl,%edx
  1007e3:	89 d0                	mov    %edx,%eax
  1007e5:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1007e8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007ef:	01 
  1007f0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007f7:	0f b6 00             	movzbl (%rax),%eax
  1007fa:	84 c0                	test   %al,%al
  1007fc:	75 a5                	jne    1007a3 <printer_vprintf+0x80>
  1007fe:	eb 01                	jmp    100801 <printer_vprintf+0xde>
            } else {
                break;
  100800:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100801:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100808:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10080f:	0f b6 00             	movzbl (%rax),%eax
  100812:	3c 30                	cmp    $0x30,%al
  100814:	7e 67                	jle    10087d <printer_vprintf+0x15a>
  100816:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10081d:	0f b6 00             	movzbl (%rax),%eax
  100820:	3c 39                	cmp    $0x39,%al
  100822:	7f 59                	jg     10087d <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100824:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  10082b:	eb 2e                	jmp    10085b <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  10082d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100830:	89 d0                	mov    %edx,%eax
  100832:	c1 e0 02             	shl    $0x2,%eax
  100835:	01 d0                	add    %edx,%eax
  100837:	01 c0                	add    %eax,%eax
  100839:	89 c1                	mov    %eax,%ecx
  10083b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100842:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100846:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10084d:	0f b6 00             	movzbl (%rax),%eax
  100850:	0f be c0             	movsbl %al,%eax
  100853:	01 c8                	add    %ecx,%eax
  100855:	83 e8 30             	sub    $0x30,%eax
  100858:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10085b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100862:	0f b6 00             	movzbl (%rax),%eax
  100865:	3c 2f                	cmp    $0x2f,%al
  100867:	0f 8e 85 00 00 00    	jle    1008f2 <printer_vprintf+0x1cf>
  10086d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100874:	0f b6 00             	movzbl (%rax),%eax
  100877:	3c 39                	cmp    $0x39,%al
  100879:	7e b2                	jle    10082d <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  10087b:	eb 75                	jmp    1008f2 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  10087d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100884:	0f b6 00             	movzbl (%rax),%eax
  100887:	3c 2a                	cmp    $0x2a,%al
  100889:	75 68                	jne    1008f3 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  10088b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100892:	8b 00                	mov    (%rax),%eax
  100894:	83 f8 2f             	cmp    $0x2f,%eax
  100897:	77 30                	ja     1008c9 <printer_vprintf+0x1a6>
  100899:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008a0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1008a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008ab:	8b 00                	mov    (%rax),%eax
  1008ad:	89 c0                	mov    %eax,%eax
  1008af:	48 01 d0             	add    %rdx,%rax
  1008b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008b9:	8b 12                	mov    (%rdx),%edx
  1008bb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1008be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008c5:	89 0a                	mov    %ecx,(%rdx)
  1008c7:	eb 1a                	jmp    1008e3 <printer_vprintf+0x1c0>
  1008c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008d0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1008d4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1008d8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1008e3:	8b 00                	mov    (%rax),%eax
  1008e5:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1008e8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008ef:	01 
  1008f0:	eb 01                	jmp    1008f3 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  1008f2:	90                   	nop
        }

        // process precision
        int precision = -1;
  1008f3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1008fa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100901:	0f b6 00             	movzbl (%rax),%eax
  100904:	3c 2e                	cmp    $0x2e,%al
  100906:	0f 85 00 01 00 00    	jne    100a0c <printer_vprintf+0x2e9>
            ++format;
  10090c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100913:	01 
            if (*format >= '0' && *format <= '9') {
  100914:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10091b:	0f b6 00             	movzbl (%rax),%eax
  10091e:	3c 2f                	cmp    $0x2f,%al
  100920:	7e 67                	jle    100989 <printer_vprintf+0x266>
  100922:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100929:	0f b6 00             	movzbl (%rax),%eax
  10092c:	3c 39                	cmp    $0x39,%al
  10092e:	7f 59                	jg     100989 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100930:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100937:	eb 2e                	jmp    100967 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  100939:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  10093c:	89 d0                	mov    %edx,%eax
  10093e:	c1 e0 02             	shl    $0x2,%eax
  100941:	01 d0                	add    %edx,%eax
  100943:	01 c0                	add    %eax,%eax
  100945:	89 c1                	mov    %eax,%ecx
  100947:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10094e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100952:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100959:	0f b6 00             	movzbl (%rax),%eax
  10095c:	0f be c0             	movsbl %al,%eax
  10095f:	01 c8                	add    %ecx,%eax
  100961:	83 e8 30             	sub    $0x30,%eax
  100964:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100967:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10096e:	0f b6 00             	movzbl (%rax),%eax
  100971:	3c 2f                	cmp    $0x2f,%al
  100973:	0f 8e 85 00 00 00    	jle    1009fe <printer_vprintf+0x2db>
  100979:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100980:	0f b6 00             	movzbl (%rax),%eax
  100983:	3c 39                	cmp    $0x39,%al
  100985:	7e b2                	jle    100939 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  100987:	eb 75                	jmp    1009fe <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  100989:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100990:	0f b6 00             	movzbl (%rax),%eax
  100993:	3c 2a                	cmp    $0x2a,%al
  100995:	75 68                	jne    1009ff <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  100997:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10099e:	8b 00                	mov    (%rax),%eax
  1009a0:	83 f8 2f             	cmp    $0x2f,%eax
  1009a3:	77 30                	ja     1009d5 <printer_vprintf+0x2b2>
  1009a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009ac:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009b7:	8b 00                	mov    (%rax),%eax
  1009b9:	89 c0                	mov    %eax,%eax
  1009bb:	48 01 d0             	add    %rdx,%rax
  1009be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009c5:	8b 12                	mov    (%rdx),%edx
  1009c7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009ca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009d1:	89 0a                	mov    %ecx,(%rdx)
  1009d3:	eb 1a                	jmp    1009ef <printer_vprintf+0x2cc>
  1009d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009dc:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009e0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009e4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009eb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009ef:	8b 00                	mov    (%rax),%eax
  1009f1:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1009f4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009fb:	01 
  1009fc:	eb 01                	jmp    1009ff <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  1009fe:	90                   	nop
            }
            if (precision < 0) {
  1009ff:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100a03:	79 07                	jns    100a0c <printer_vprintf+0x2e9>
                precision = 0;
  100a05:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100a0c:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100a13:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100a1a:	00 
        int length = 0;
  100a1b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100a22:	48 8d 05 3d 0a 00 00 	lea    0xa3d(%rip),%rax        # 101466 <flag_chars+0x6>
  100a29:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  100a2d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a34:	0f b6 00             	movzbl (%rax),%eax
  100a37:	0f be c0             	movsbl %al,%eax
  100a3a:	83 e8 43             	sub    $0x43,%eax
  100a3d:	83 f8 37             	cmp    $0x37,%eax
  100a40:	0f 87 b6 03 00 00    	ja     100dfc <printer_vprintf+0x6d9>
  100a46:	89 c0                	mov    %eax,%eax
  100a48:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  100a4f:	00 
  100a50:	48 8d 05 1d 0a 00 00 	lea    0xa1d(%rip),%rax        # 101474 <flag_chars+0x14>
  100a57:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  100a5a:	48 98                	cltq   
  100a5c:	48 8d 15 11 0a 00 00 	lea    0xa11(%rip),%rdx        # 101474 <flag_chars+0x14>
  100a63:	48 01 d0             	add    %rdx,%rax
  100a66:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  100a69:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100a70:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a77:	01 
            goto again;
  100a78:	eb b3                	jmp    100a2d <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100a7a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100a7e:	74 5d                	je     100add <printer_vprintf+0x3ba>
  100a80:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a87:	8b 00                	mov    (%rax),%eax
  100a89:	83 f8 2f             	cmp    $0x2f,%eax
  100a8c:	77 30                	ja     100abe <printer_vprintf+0x39b>
  100a8e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a95:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aa0:	8b 00                	mov    (%rax),%eax
  100aa2:	89 c0                	mov    %eax,%eax
  100aa4:	48 01 d0             	add    %rdx,%rax
  100aa7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aae:	8b 12                	mov    (%rdx),%edx
  100ab0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ab3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aba:	89 0a                	mov    %ecx,(%rdx)
  100abc:	eb 1a                	jmp    100ad8 <printer_vprintf+0x3b5>
  100abe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ac5:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ac9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100acd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ad4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ad8:	48 8b 00             	mov    (%rax),%rax
  100adb:	eb 5c                	jmp    100b39 <printer_vprintf+0x416>
  100add:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ae4:	8b 00                	mov    (%rax),%eax
  100ae6:	83 f8 2f             	cmp    $0x2f,%eax
  100ae9:	77 30                	ja     100b1b <printer_vprintf+0x3f8>
  100aeb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100af6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100afd:	8b 00                	mov    (%rax),%eax
  100aff:	89 c0                	mov    %eax,%eax
  100b01:	48 01 d0             	add    %rdx,%rax
  100b04:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b0b:	8b 12                	mov    (%rdx),%edx
  100b0d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b10:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b17:	89 0a                	mov    %ecx,(%rdx)
  100b19:	eb 1a                	jmp    100b35 <printer_vprintf+0x412>
  100b1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b22:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b26:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b2a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b31:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b35:	8b 00                	mov    (%rax),%eax
  100b37:	48 98                	cltq   
  100b39:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100b3d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100b41:	48 c1 f8 38          	sar    $0x38,%rax
  100b45:	25 80 00 00 00       	and    $0x80,%eax
  100b4a:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100b4d:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100b51:	74 09                	je     100b5c <printer_vprintf+0x439>
  100b53:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100b57:	48 f7 d8             	neg    %rax
  100b5a:	eb 04                	jmp    100b60 <printer_vprintf+0x43d>
  100b5c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100b60:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100b64:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100b67:	83 c8 60             	or     $0x60,%eax
  100b6a:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100b6d:	e9 cf 02 00 00       	jmp    100e41 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100b72:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100b76:	74 5d                	je     100bd5 <printer_vprintf+0x4b2>
  100b78:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b7f:	8b 00                	mov    (%rax),%eax
  100b81:	83 f8 2f             	cmp    $0x2f,%eax
  100b84:	77 30                	ja     100bb6 <printer_vprintf+0x493>
  100b86:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b8d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b98:	8b 00                	mov    (%rax),%eax
  100b9a:	89 c0                	mov    %eax,%eax
  100b9c:	48 01 d0             	add    %rdx,%rax
  100b9f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ba6:	8b 12                	mov    (%rdx),%edx
  100ba8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bb2:	89 0a                	mov    %ecx,(%rdx)
  100bb4:	eb 1a                	jmp    100bd0 <printer_vprintf+0x4ad>
  100bb6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bbd:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bc1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bc5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bcc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bd0:	48 8b 00             	mov    (%rax),%rax
  100bd3:	eb 5c                	jmp    100c31 <printer_vprintf+0x50e>
  100bd5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bdc:	8b 00                	mov    (%rax),%eax
  100bde:	83 f8 2f             	cmp    $0x2f,%eax
  100be1:	77 30                	ja     100c13 <printer_vprintf+0x4f0>
  100be3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bea:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bf5:	8b 00                	mov    (%rax),%eax
  100bf7:	89 c0                	mov    %eax,%eax
  100bf9:	48 01 d0             	add    %rdx,%rax
  100bfc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c03:	8b 12                	mov    (%rdx),%edx
  100c05:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c08:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c0f:	89 0a                	mov    %ecx,(%rdx)
  100c11:	eb 1a                	jmp    100c2d <printer_vprintf+0x50a>
  100c13:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c1a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c1e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c22:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c29:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c2d:	8b 00                	mov    (%rax),%eax
  100c2f:	89 c0                	mov    %eax,%eax
  100c31:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100c35:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100c39:	e9 03 02 00 00       	jmp    100e41 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100c3e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100c45:	e9 28 ff ff ff       	jmp    100b72 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100c4a:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100c51:	e9 1c ff ff ff       	jmp    100b72 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100c56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c5d:	8b 00                	mov    (%rax),%eax
  100c5f:	83 f8 2f             	cmp    $0x2f,%eax
  100c62:	77 30                	ja     100c94 <printer_vprintf+0x571>
  100c64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c6b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c6f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c76:	8b 00                	mov    (%rax),%eax
  100c78:	89 c0                	mov    %eax,%eax
  100c7a:	48 01 d0             	add    %rdx,%rax
  100c7d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c84:	8b 12                	mov    (%rdx),%edx
  100c86:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c89:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c90:	89 0a                	mov    %ecx,(%rdx)
  100c92:	eb 1a                	jmp    100cae <printer_vprintf+0x58b>
  100c94:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c9b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c9f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ca3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100caa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cae:	48 8b 00             	mov    (%rax),%rax
  100cb1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100cb5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100cbc:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100cc3:	e9 79 01 00 00       	jmp    100e41 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100cc8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ccf:	8b 00                	mov    (%rax),%eax
  100cd1:	83 f8 2f             	cmp    $0x2f,%eax
  100cd4:	77 30                	ja     100d06 <printer_vprintf+0x5e3>
  100cd6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cdd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ce1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ce8:	8b 00                	mov    (%rax),%eax
  100cea:	89 c0                	mov    %eax,%eax
  100cec:	48 01 d0             	add    %rdx,%rax
  100cef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cf6:	8b 12                	mov    (%rdx),%edx
  100cf8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cfb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d02:	89 0a                	mov    %ecx,(%rdx)
  100d04:	eb 1a                	jmp    100d20 <printer_vprintf+0x5fd>
  100d06:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d0d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d11:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d15:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d1c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d20:	48 8b 00             	mov    (%rax),%rax
  100d23:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100d27:	e9 15 01 00 00       	jmp    100e41 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100d2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d33:	8b 00                	mov    (%rax),%eax
  100d35:	83 f8 2f             	cmp    $0x2f,%eax
  100d38:	77 30                	ja     100d6a <printer_vprintf+0x647>
  100d3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d41:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d4c:	8b 00                	mov    (%rax),%eax
  100d4e:	89 c0                	mov    %eax,%eax
  100d50:	48 01 d0             	add    %rdx,%rax
  100d53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d5a:	8b 12                	mov    (%rdx),%edx
  100d5c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d66:	89 0a                	mov    %ecx,(%rdx)
  100d68:	eb 1a                	jmp    100d84 <printer_vprintf+0x661>
  100d6a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d71:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d75:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d79:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d80:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d84:	8b 00                	mov    (%rax),%eax
  100d86:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100d8c:	e9 77 03 00 00       	jmp    101108 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100d91:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d95:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100d99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100da0:	8b 00                	mov    (%rax),%eax
  100da2:	83 f8 2f             	cmp    $0x2f,%eax
  100da5:	77 30                	ja     100dd7 <printer_vprintf+0x6b4>
  100da7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dae:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100db2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100db9:	8b 00                	mov    (%rax),%eax
  100dbb:	89 c0                	mov    %eax,%eax
  100dbd:	48 01 d0             	add    %rdx,%rax
  100dc0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dc7:	8b 12                	mov    (%rdx),%edx
  100dc9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100dcc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dd3:	89 0a                	mov    %ecx,(%rdx)
  100dd5:	eb 1a                	jmp    100df1 <printer_vprintf+0x6ce>
  100dd7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dde:	48 8b 40 08          	mov    0x8(%rax),%rax
  100de2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100de6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ded:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100df1:	8b 00                	mov    (%rax),%eax
  100df3:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100df6:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100dfa:	eb 45                	jmp    100e41 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100dfc:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e00:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100e04:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e0b:	0f b6 00             	movzbl (%rax),%eax
  100e0e:	84 c0                	test   %al,%al
  100e10:	74 0c                	je     100e1e <printer_vprintf+0x6fb>
  100e12:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e19:	0f b6 00             	movzbl (%rax),%eax
  100e1c:	eb 05                	jmp    100e23 <printer_vprintf+0x700>
  100e1e:	b8 25 00 00 00       	mov    $0x25,%eax
  100e23:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100e26:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100e2a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e31:	0f b6 00             	movzbl (%rax),%eax
  100e34:	84 c0                	test   %al,%al
  100e36:	75 08                	jne    100e40 <printer_vprintf+0x71d>
                format--;
  100e38:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100e3f:	01 
            }
            break;
  100e40:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100e41:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e44:	83 e0 20             	and    $0x20,%eax
  100e47:	85 c0                	test   %eax,%eax
  100e49:	74 1e                	je     100e69 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100e4b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e4f:	48 83 c0 18          	add    $0x18,%rax
  100e53:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100e56:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100e5a:	48 89 ce             	mov    %rcx,%rsi
  100e5d:	48 89 c7             	mov    %rax,%rdi
  100e60:	e8 32 f8 ff ff       	call   100697 <fill_numbuf>
  100e65:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100e69:	48 8d 05 f6 05 00 00 	lea    0x5f6(%rip),%rax        # 101466 <flag_chars+0x6>
  100e70:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100e74:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e77:	83 e0 20             	and    $0x20,%eax
  100e7a:	85 c0                	test   %eax,%eax
  100e7c:	74 51                	je     100ecf <printer_vprintf+0x7ac>
  100e7e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e81:	83 e0 40             	and    $0x40,%eax
  100e84:	85 c0                	test   %eax,%eax
  100e86:	74 47                	je     100ecf <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100e88:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e8b:	25 80 00 00 00       	and    $0x80,%eax
  100e90:	85 c0                	test   %eax,%eax
  100e92:	74 0d                	je     100ea1 <printer_vprintf+0x77e>
                prefix = "-";
  100e94:	48 8d 05 cc 05 00 00 	lea    0x5cc(%rip),%rax        # 101467 <flag_chars+0x7>
  100e9b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e9f:	eb 7d                	jmp    100f1e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100ea1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ea4:	83 e0 10             	and    $0x10,%eax
  100ea7:	85 c0                	test   %eax,%eax
  100ea9:	74 0d                	je     100eb8 <printer_vprintf+0x795>
                prefix = "+";
  100eab:	48 8d 05 b7 05 00 00 	lea    0x5b7(%rip),%rax        # 101469 <flag_chars+0x9>
  100eb2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100eb6:	eb 66                	jmp    100f1e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100eb8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ebb:	83 e0 08             	and    $0x8,%eax
  100ebe:	85 c0                	test   %eax,%eax
  100ec0:	74 5c                	je     100f1e <printer_vprintf+0x7fb>
                prefix = " ";
  100ec2:	48 8d 05 a2 05 00 00 	lea    0x5a2(%rip),%rax        # 10146b <flag_chars+0xb>
  100ec9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100ecd:	eb 4f                	jmp    100f1e <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100ecf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ed2:	83 e0 20             	and    $0x20,%eax
  100ed5:	85 c0                	test   %eax,%eax
  100ed7:	74 46                	je     100f1f <printer_vprintf+0x7fc>
  100ed9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100edc:	83 e0 01             	and    $0x1,%eax
  100edf:	85 c0                	test   %eax,%eax
  100ee1:	74 3c                	je     100f1f <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100ee3:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100ee7:	74 06                	je     100eef <printer_vprintf+0x7cc>
  100ee9:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100eed:	75 30                	jne    100f1f <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100eef:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100ef4:	75 0c                	jne    100f02 <printer_vprintf+0x7df>
  100ef6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ef9:	25 00 01 00 00       	and    $0x100,%eax
  100efe:	85 c0                	test   %eax,%eax
  100f00:	74 1d                	je     100f1f <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100f02:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100f06:	75 09                	jne    100f11 <printer_vprintf+0x7ee>
  100f08:	48 8d 05 5e 05 00 00 	lea    0x55e(%rip),%rax        # 10146d <flag_chars+0xd>
  100f0f:	eb 07                	jmp    100f18 <printer_vprintf+0x7f5>
  100f11:	48 8d 05 58 05 00 00 	lea    0x558(%rip),%rax        # 101470 <flag_chars+0x10>
  100f18:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100f1c:	eb 01                	jmp    100f1f <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100f1e:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100f1f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100f23:	78 24                	js     100f49 <printer_vprintf+0x826>
  100f25:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f28:	83 e0 20             	and    $0x20,%eax
  100f2b:	85 c0                	test   %eax,%eax
  100f2d:	75 1a                	jne    100f49 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100f2f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f32:	48 63 d0             	movslq %eax,%rdx
  100f35:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f39:	48 89 d6             	mov    %rdx,%rsi
  100f3c:	48 89 c7             	mov    %rax,%rdi
  100f3f:	e8 91 f5 ff ff       	call   1004d5 <strnlen>
  100f44:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100f47:	eb 0f                	jmp    100f58 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100f49:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f4d:	48 89 c7             	mov    %rax,%rdi
  100f50:	e8 4b f5 ff ff       	call   1004a0 <strlen>
  100f55:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100f58:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f5b:	83 e0 20             	and    $0x20,%eax
  100f5e:	85 c0                	test   %eax,%eax
  100f60:	74 20                	je     100f82 <printer_vprintf+0x85f>
  100f62:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100f66:	78 1a                	js     100f82 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100f68:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f6b:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100f6e:	7e 08                	jle    100f78 <printer_vprintf+0x855>
  100f70:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f73:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100f76:	eb 05                	jmp    100f7d <printer_vprintf+0x85a>
  100f78:	b8 00 00 00 00       	mov    $0x0,%eax
  100f7d:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f80:	eb 5c                	jmp    100fde <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100f82:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f85:	83 e0 20             	and    $0x20,%eax
  100f88:	85 c0                	test   %eax,%eax
  100f8a:	74 4b                	je     100fd7 <printer_vprintf+0x8b4>
  100f8c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f8f:	83 e0 02             	and    $0x2,%eax
  100f92:	85 c0                	test   %eax,%eax
  100f94:	74 41                	je     100fd7 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100f96:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f99:	83 e0 04             	and    $0x4,%eax
  100f9c:	85 c0                	test   %eax,%eax
  100f9e:	75 37                	jne    100fd7 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100fa0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fa4:	48 89 c7             	mov    %rax,%rdi
  100fa7:	e8 f4 f4 ff ff       	call   1004a0 <strlen>
  100fac:	89 c2                	mov    %eax,%edx
  100fae:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100fb1:	01 d0                	add    %edx,%eax
  100fb3:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100fb6:	7e 1f                	jle    100fd7 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100fb8:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100fbb:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100fbe:	89 c3                	mov    %eax,%ebx
  100fc0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fc4:	48 89 c7             	mov    %rax,%rdi
  100fc7:	e8 d4 f4 ff ff       	call   1004a0 <strlen>
  100fcc:	89 c2                	mov    %eax,%edx
  100fce:	89 d8                	mov    %ebx,%eax
  100fd0:	29 d0                	sub    %edx,%eax
  100fd2:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100fd5:	eb 07                	jmp    100fde <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100fd7:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100fde:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100fe1:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100fe4:	01 d0                	add    %edx,%eax
  100fe6:	48 63 d8             	movslq %eax,%rbx
  100fe9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fed:	48 89 c7             	mov    %rax,%rdi
  100ff0:	e8 ab f4 ff ff       	call   1004a0 <strlen>
  100ff5:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100ff9:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100ffc:	29 d0                	sub    %edx,%eax
  100ffe:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101001:	eb 25                	jmp    101028 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  101003:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10100a:	48 8b 08             	mov    (%rax),%rcx
  10100d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101013:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10101a:	be 20 00 00 00       	mov    $0x20,%esi
  10101f:	48 89 c7             	mov    %rax,%rdi
  101022:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101024:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101028:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10102b:	83 e0 04             	and    $0x4,%eax
  10102e:	85 c0                	test   %eax,%eax
  101030:	75 36                	jne    101068 <printer_vprintf+0x945>
  101032:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101036:	7f cb                	jg     101003 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  101038:	eb 2e                	jmp    101068 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  10103a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101041:	4c 8b 00             	mov    (%rax),%r8
  101044:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101048:	0f b6 00             	movzbl (%rax),%eax
  10104b:	0f b6 c8             	movzbl %al,%ecx
  10104e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101054:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10105b:	89 ce                	mov    %ecx,%esi
  10105d:	48 89 c7             	mov    %rax,%rdi
  101060:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101063:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101068:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10106c:	0f b6 00             	movzbl (%rax),%eax
  10106f:	84 c0                	test   %al,%al
  101071:	75 c7                	jne    10103a <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  101073:	eb 25                	jmp    10109a <printer_vprintf+0x977>
            p->putc(p, '0', color);
  101075:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10107c:	48 8b 08             	mov    (%rax),%rcx
  10107f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101085:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10108c:	be 30 00 00 00       	mov    $0x30,%esi
  101091:	48 89 c7             	mov    %rax,%rdi
  101094:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101096:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  10109a:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  10109e:	7f d5                	jg     101075 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  1010a0:	eb 32                	jmp    1010d4 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  1010a2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010a9:	4c 8b 00             	mov    (%rax),%r8
  1010ac:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1010b0:	0f b6 00             	movzbl (%rax),%eax
  1010b3:	0f b6 c8             	movzbl %al,%ecx
  1010b6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010bc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010c3:	89 ce                	mov    %ecx,%esi
  1010c5:	48 89 c7             	mov    %rax,%rdi
  1010c8:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  1010cb:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  1010d0:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  1010d4:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  1010d8:	7f c8                	jg     1010a2 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  1010da:	eb 25                	jmp    101101 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  1010dc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010e3:	48 8b 08             	mov    (%rax),%rcx
  1010e6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010ec:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010f3:	be 20 00 00 00       	mov    $0x20,%esi
  1010f8:	48 89 c7             	mov    %rax,%rdi
  1010fb:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1010fd:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101101:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101105:	7f d5                	jg     1010dc <printer_vprintf+0x9b9>
        }
    done: ;
  101107:	90                   	nop
    for (; *format; ++format) {
  101108:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10110f:	01 
  101110:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101117:	0f b6 00             	movzbl (%rax),%eax
  10111a:	84 c0                	test   %al,%al
  10111c:	0f 85 31 f6 ff ff    	jne    100753 <printer_vprintf+0x30>
    }
}
  101122:	90                   	nop
  101123:	90                   	nop
  101124:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101128:	c9                   	leave  
  101129:	c3                   	ret    

000000000010112a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  10112a:	f3 0f 1e fa          	endbr64 
  10112e:	55                   	push   %rbp
  10112f:	48 89 e5             	mov    %rsp,%rbp
  101132:	48 83 ec 20          	sub    $0x20,%rsp
  101136:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10113a:	89 f0                	mov    %esi,%eax
  10113c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10113f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101142:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101146:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10114a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10114e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101152:	48 8d 15 47 7e fb ff 	lea    -0x481b9(%rip),%rdx        # b8fa0 <console+0xfa0>
  101159:	48 39 d0             	cmp    %rdx,%rax
  10115c:	72 0f                	jb     10116d <console_putc+0x43>
        cp->cursor = console;
  10115e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101162:	48 8d 15 97 6e fb ff 	lea    -0x49169(%rip),%rdx        # b8000 <console>
  101169:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  10116d:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101171:	0f 85 82 00 00 00    	jne    1011f9 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  101177:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10117b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10117f:	48 8d 15 7a 6e fb ff 	lea    -0x49186(%rip),%rdx        # b8000 <console>
  101186:	48 29 d0             	sub    %rdx,%rax
  101189:	48 d1 f8             	sar    %rax
  10118c:	48 89 c1             	mov    %rax,%rcx
  10118f:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101196:	66 66 66 
  101199:	48 89 c8             	mov    %rcx,%rax
  10119c:	48 f7 ea             	imul   %rdx
  10119f:	48 89 d0             	mov    %rdx,%rax
  1011a2:	48 c1 f8 05          	sar    $0x5,%rax
  1011a6:	48 89 ce             	mov    %rcx,%rsi
  1011a9:	48 c1 fe 3f          	sar    $0x3f,%rsi
  1011ad:	48 29 f0             	sub    %rsi,%rax
  1011b0:	48 89 c2             	mov    %rax,%rdx
  1011b3:	48 89 d0             	mov    %rdx,%rax
  1011b6:	48 c1 e0 02          	shl    $0x2,%rax
  1011ba:	48 01 d0             	add    %rdx,%rax
  1011bd:	48 c1 e0 04          	shl    $0x4,%rax
  1011c1:	48 29 c1             	sub    %rax,%rcx
  1011c4:	48 89 ca             	mov    %rcx,%rdx
  1011c7:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1011ca:	eb 25                	jmp    1011f1 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  1011cc:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1011cf:	83 c8 20             	or     $0x20,%eax
  1011d2:	89 c6                	mov    %eax,%esi
  1011d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011d8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011dc:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1011e0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1011e4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011e8:	89 f2                	mov    %esi,%edx
  1011ea:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1011ed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1011f1:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1011f5:	75 d5                	jne    1011cc <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1011f7:	eb 24                	jmp    10121d <console_putc+0xf3>
        *cp->cursor++ = c | color;
  1011f9:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1011fd:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101200:	89 d6                	mov    %edx,%esi
  101202:	09 c6                	or     %eax,%esi
  101204:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101208:	48 8b 40 08          	mov    0x8(%rax),%rax
  10120c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101210:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101214:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101218:	89 f2                	mov    %esi,%edx
  10121a:	66 89 10             	mov    %dx,(%rax)
}
  10121d:	90                   	nop
  10121e:	c9                   	leave  
  10121f:	c3                   	ret    

0000000000101220 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101220:	f3 0f 1e fa          	endbr64 
  101224:	55                   	push   %rbp
  101225:	48 89 e5             	mov    %rsp,%rbp
  101228:	48 83 ec 30          	sub    $0x30,%rsp
  10122c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10122f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101232:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101236:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  10123a:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 10112a <console_putc>
  101241:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101245:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101249:	78 09                	js     101254 <console_vprintf+0x34>
  10124b:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101252:	7e 07                	jle    10125b <console_vprintf+0x3b>
        cpos = 0;
  101254:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10125b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10125e:	48 98                	cltq   
  101260:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101264:	48 8d 05 95 6d fb ff 	lea    -0x4926b(%rip),%rax        # b8000 <console>
  10126b:	48 01 d0             	add    %rdx,%rax
  10126e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101272:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101276:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10127a:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10127d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101281:	48 89 c7             	mov    %rax,%rdi
  101284:	e8 9a f4 ff ff       	call   100723 <printer_vprintf>
    return cp.cursor - console;
  101289:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10128d:	48 8d 15 6c 6d fb ff 	lea    -0x49294(%rip),%rdx        # b8000 <console>
  101294:	48 29 d0             	sub    %rdx,%rax
  101297:	48 d1 f8             	sar    %rax
}
  10129a:	c9                   	leave  
  10129b:	c3                   	ret    

000000000010129c <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10129c:	f3 0f 1e fa          	endbr64 
  1012a0:	55                   	push   %rbp
  1012a1:	48 89 e5             	mov    %rsp,%rbp
  1012a4:	48 83 ec 60          	sub    $0x60,%rsp
  1012a8:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1012ab:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1012ae:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1012b2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1012b6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1012ba:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1012be:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1012c5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1012c9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1012cd:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1012d1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1012d5:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1012d9:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1012dd:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1012e0:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1012e3:	89 c7                	mov    %eax,%edi
  1012e5:	e8 36 ff ff ff       	call   101220 <console_vprintf>
  1012ea:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1012ed:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1012f0:	c9                   	leave  
  1012f1:	c3                   	ret    

00000000001012f2 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1012f2:	f3 0f 1e fa          	endbr64 
  1012f6:	55                   	push   %rbp
  1012f7:	48 89 e5             	mov    %rsp,%rbp
  1012fa:	48 83 ec 20          	sub    $0x20,%rsp
  1012fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101302:	89 f0                	mov    %esi,%eax
  101304:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101307:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10130a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10130e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101312:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101316:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10131a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10131e:	48 8b 40 10          	mov    0x10(%rax),%rax
  101322:	48 39 c2             	cmp    %rax,%rdx
  101325:	73 1a                	jae    101341 <string_putc+0x4f>
        *sp->s++ = c;
  101327:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10132b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10132f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101333:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101337:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10133b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10133f:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101341:	90                   	nop
  101342:	c9                   	leave  
  101343:	c3                   	ret    

0000000000101344 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101344:	f3 0f 1e fa          	endbr64 
  101348:	55                   	push   %rbp
  101349:	48 89 e5             	mov    %rsp,%rbp
  10134c:	48 83 ec 40          	sub    $0x40,%rsp
  101350:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101354:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101358:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10135c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101360:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 1012f2 <string_putc>
  101367:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  10136b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10136f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101373:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101378:	74 33                	je     1013ad <vsnprintf+0x69>
        sp.end = s + size - 1;
  10137a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  10137e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101382:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101386:	48 01 d0             	add    %rdx,%rax
  101389:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10138d:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101391:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101395:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101399:	be 00 00 00 00       	mov    $0x0,%esi
  10139e:	48 89 c7             	mov    %rax,%rdi
  1013a1:	e8 7d f3 ff ff       	call   100723 <printer_vprintf>
        *sp.s = 0;
  1013a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013aa:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1013ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013b1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1013b5:	c9                   	leave  
  1013b6:	c3                   	ret    

00000000001013b7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1013b7:	f3 0f 1e fa          	endbr64 
  1013bb:	55                   	push   %rbp
  1013bc:	48 89 e5             	mov    %rsp,%rbp
  1013bf:	48 83 ec 70          	sub    $0x70,%rsp
  1013c3:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1013c7:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1013cb:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1013cf:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1013d3:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1013d7:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1013db:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1013e2:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1013e6:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1013ea:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1013ee:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1013f2:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1013f6:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1013fa:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1013fe:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101402:	48 89 c7             	mov    %rax,%rdi
  101405:	e8 3a ff ff ff       	call   101344 <vsnprintf>
  10140a:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10140d:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101410:	c9                   	leave  
  101411:	c3                   	ret    

0000000000101412 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101412:	f3 0f 1e fa          	endbr64 
  101416:	55                   	push   %rbp
  101417:	48 89 e5             	mov    %rsp,%rbp
  10141a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10141e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101425:	eb 1a                	jmp    101441 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101427:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10142a:	48 98                	cltq   
  10142c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101430:	48 8d 05 c9 6b fb ff 	lea    -0x49437(%rip),%rax        # b8000 <console>
  101437:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10143d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101441:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101448:	7e dd                	jle    101427 <console_clear+0x15>
    }
    cursorpos = 0;
  10144a:	c7 05 a8 7b fb ff 00 	movl   $0x0,-0x48458(%rip)        # b8ffc <cursorpos>
  101451:	00 00 00 
}
  101454:	90                   	nop
  101455:	c9                   	leave  
  101456:	c3                   	ret    
