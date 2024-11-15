
obj/p-allocator3.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000180000 <process_main>:
uint8_t* stack_bottom;

// Program that starts allocating page by page from its heap
// till it reaches stack OR runs out of memory

void process_main(void) {
  180000:	f3 0f 1e fa          	endbr64 
  180004:	55                   	push   %rbp
  180005:	48 89 e5             	mov    %rsp,%rbp
  180008:	53                   	push   %rbx
  180009:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  18000d:	cd 31                	int    $0x31
  18000f:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  180011:	89 c7                	mov    %eax,%edi
  180013:	e8 9a 03 00 00       	call   1803b2 <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  180018:	48 8d 05 f8 2f 00 00 	lea    0x2ff8(%rip),%rax        # 183017 <end+0xfff>
  18001f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  180025:	48 89 05 dc 1f 00 00 	mov    %rax,0x1fdc(%rip)        # 182008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  18002c:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  18002f:	48 83 e8 01          	sub    $0x1,%rax
  180033:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  180039:	48 89 05 c0 1f 00 00 	mov    %rax,0x1fc0(%rip)        # 182000 <stack_bottom>
  180040:	eb 02                	jmp    180044 <process_main+0x44>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  180042:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  180044:	e8 29 03 00 00       	call   180372 <rand>
  180049:	48 63 d0             	movslq %eax,%rdx
  18004c:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  180053:	48 c1 fa 25          	sar    $0x25,%rdx
  180057:	89 c1                	mov    %eax,%ecx
  180059:	c1 f9 1f             	sar    $0x1f,%ecx
  18005c:	29 ca                	sub    %ecx,%edx
  18005e:	6b d2 64             	imul   $0x64,%edx,%edx
  180061:	29 d0                	sub    %edx,%eax
  180063:	39 d8                	cmp    %ebx,%eax
  180065:	7d db                	jge    180042 <process_main+0x42>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  180067:	48 8b 3d 9a 1f 00 00 	mov    0x1f9a(%rip),%rdi        # 182008 <heap_top>
  18006e:	48 3b 3d 8b 1f 00 00 	cmp    0x1f8b(%rip),%rdi        # 182000 <stack_bottom>
  180075:	74 1c                	je     180093 <process_main+0x93>
//    Allocate a page of memory at address `addr` and allow process to
//    write to it. `Addr` must be page-aligned (i.e., a multiple of
//    PAGESIZE == 4096). Returns 0 on success and -1 on failure.
static inline int sys_page_alloc(void* addr) {
    int result;
    asm volatile ("int %1" : "=a" (result)
  180077:	cd 33                	int    $0x33
  180079:	85 c0                	test   %eax,%eax
  18007b:	78 16                	js     180093 <process_main+0x93>
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
  18007d:	48 8b 05 84 1f 00 00 	mov    0x1f84(%rip),%rax        # 182008 <heap_top>
  180084:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  180086:	48 81 05 77 1f 00 00 	addq   $0x1000,0x1f77(%rip)        # 182008 <heap_top>
  18008d:	00 10 00 00 
  180091:	eb af                	jmp    180042 <process_main+0x42>
    asm volatile ("int %0" : /* no result */
  180093:	cd 32                	int    $0x32
  180095:	eb fc                	jmp    180093 <process_main+0x93>

0000000000180097 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  180097:	f3 0f 1e fa          	endbr64 
  18009b:	55                   	push   %rbp
  18009c:	48 89 e5             	mov    %rsp,%rbp
  18009f:	48 83 ec 28          	sub    $0x28,%rsp
  1800a3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1800a7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1800ab:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1800af:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1800b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1800b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1800bb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1800bf:	eb 1c                	jmp    1800dd <memcpy+0x46>
        *d = *s;
  1800c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1800c5:	0f b6 10             	movzbl (%rax),%edx
  1800c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1800cc:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1800ce:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1800d3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1800d8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1800dd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1800e2:	75 dd                	jne    1800c1 <memcpy+0x2a>
    }
    return dst;
  1800e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1800e8:	c9                   	leave  
  1800e9:	c3                   	ret    

00000000001800ea <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1800ea:	f3 0f 1e fa          	endbr64 
  1800ee:	55                   	push   %rbp
  1800ef:	48 89 e5             	mov    %rsp,%rbp
  1800f2:	48 83 ec 28          	sub    $0x28,%rsp
  1800f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1800fa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1800fe:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  180102:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  180106:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  18010a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  18010e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  180112:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  180116:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  18011a:	73 6a                	jae    180186 <memmove+0x9c>
  18011c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  180120:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  180124:	48 01 d0             	add    %rdx,%rax
  180127:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  18012b:	73 59                	jae    180186 <memmove+0x9c>
        s += n, d += n;
  18012d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  180131:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  180135:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  180139:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  18013d:	eb 17                	jmp    180156 <memmove+0x6c>
            *--d = *--s;
  18013f:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  180144:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  180149:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  18014d:	0f b6 10             	movzbl (%rax),%edx
  180150:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  180154:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  180156:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  18015a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  18015e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  180162:	48 85 c0             	test   %rax,%rax
  180165:	75 d8                	jne    18013f <memmove+0x55>
    if (s < d && s + n > d) {
  180167:	eb 2e                	jmp    180197 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  180169:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  18016d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  180171:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  180175:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  180179:	48 8d 48 01          	lea    0x1(%rax),%rcx
  18017d:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  180181:	0f b6 12             	movzbl (%rdx),%edx
  180184:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  180186:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  18018a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  18018e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  180192:	48 85 c0             	test   %rax,%rax
  180195:	75 d2                	jne    180169 <memmove+0x7f>
        }
    }
    return dst;
  180197:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  18019b:	c9                   	leave  
  18019c:	c3                   	ret    

000000000018019d <memset>:

void* memset(void* v, int c, size_t n) {
  18019d:	f3 0f 1e fa          	endbr64 
  1801a1:	55                   	push   %rbp
  1801a2:	48 89 e5             	mov    %rsp,%rbp
  1801a5:	48 83 ec 28          	sub    $0x28,%rsp
  1801a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1801ad:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1801b0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1801b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1801b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1801bc:	eb 15                	jmp    1801d3 <memset+0x36>
        *p = c;
  1801be:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1801c1:	89 c2                	mov    %eax,%edx
  1801c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1801c7:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1801c9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1801ce:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1801d3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1801d8:	75 e4                	jne    1801be <memset+0x21>
    }
    return v;
  1801da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1801de:	c9                   	leave  
  1801df:	c3                   	ret    

00000000001801e0 <strlen>:

size_t strlen(const char* s) {
  1801e0:	f3 0f 1e fa          	endbr64 
  1801e4:	55                   	push   %rbp
  1801e5:	48 89 e5             	mov    %rsp,%rbp
  1801e8:	48 83 ec 18          	sub    $0x18,%rsp
  1801ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1801f0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1801f7:	00 
  1801f8:	eb 0a                	jmp    180204 <strlen+0x24>
        ++n;
  1801fa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1801ff:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  180204:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  180208:	0f b6 00             	movzbl (%rax),%eax
  18020b:	84 c0                	test   %al,%al
  18020d:	75 eb                	jne    1801fa <strlen+0x1a>
    }
    return n;
  18020f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  180213:	c9                   	leave  
  180214:	c3                   	ret    

0000000000180215 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  180215:	f3 0f 1e fa          	endbr64 
  180219:	55                   	push   %rbp
  18021a:	48 89 e5             	mov    %rsp,%rbp
  18021d:	48 83 ec 20          	sub    $0x20,%rsp
  180221:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  180225:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  180229:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  180230:	00 
  180231:	eb 0a                	jmp    18023d <strnlen+0x28>
        ++n;
  180233:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  180238:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  18023d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  180241:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  180245:	74 0b                	je     180252 <strnlen+0x3d>
  180247:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  18024b:	0f b6 00             	movzbl (%rax),%eax
  18024e:	84 c0                	test   %al,%al
  180250:	75 e1                	jne    180233 <strnlen+0x1e>
    }
    return n;
  180252:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  180256:	c9                   	leave  
  180257:	c3                   	ret    

0000000000180258 <strcpy>:

char* strcpy(char* dst, const char* src) {
  180258:	f3 0f 1e fa          	endbr64 
  18025c:	55                   	push   %rbp
  18025d:	48 89 e5             	mov    %rsp,%rbp
  180260:	48 83 ec 20          	sub    $0x20,%rsp
  180264:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  180268:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  18026c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  180270:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  180274:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  180278:	48 8d 42 01          	lea    0x1(%rdx),%rax
  18027c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  180280:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  180284:	48 8d 48 01          	lea    0x1(%rax),%rcx
  180288:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  18028c:	0f b6 12             	movzbl (%rdx),%edx
  18028f:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  180291:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  180295:	48 83 e8 01          	sub    $0x1,%rax
  180299:	0f b6 00             	movzbl (%rax),%eax
  18029c:	84 c0                	test   %al,%al
  18029e:	75 d4                	jne    180274 <strcpy+0x1c>
    return dst;
  1802a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1802a4:	c9                   	leave  
  1802a5:	c3                   	ret    

00000000001802a6 <strcmp>:

int strcmp(const char* a, const char* b) {
  1802a6:	f3 0f 1e fa          	endbr64 
  1802aa:	55                   	push   %rbp
  1802ab:	48 89 e5             	mov    %rsp,%rbp
  1802ae:	48 83 ec 10          	sub    $0x10,%rsp
  1802b2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1802b6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1802ba:	eb 0a                	jmp    1802c6 <strcmp+0x20>
        ++a, ++b;
  1802bc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1802c1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1802c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1802ca:	0f b6 00             	movzbl (%rax),%eax
  1802cd:	84 c0                	test   %al,%al
  1802cf:	74 1d                	je     1802ee <strcmp+0x48>
  1802d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1802d5:	0f b6 00             	movzbl (%rax),%eax
  1802d8:	84 c0                	test   %al,%al
  1802da:	74 12                	je     1802ee <strcmp+0x48>
  1802dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1802e0:	0f b6 10             	movzbl (%rax),%edx
  1802e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1802e7:	0f b6 00             	movzbl (%rax),%eax
  1802ea:	38 c2                	cmp    %al,%dl
  1802ec:	74 ce                	je     1802bc <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1802ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1802f2:	0f b6 00             	movzbl (%rax),%eax
  1802f5:	89 c2                	mov    %eax,%edx
  1802f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1802fb:	0f b6 00             	movzbl (%rax),%eax
  1802fe:	38 c2                	cmp    %al,%dl
  180300:	0f 97 c0             	seta   %al
  180303:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  180306:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  18030a:	0f b6 00             	movzbl (%rax),%eax
  18030d:	89 c1                	mov    %eax,%ecx
  18030f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  180313:	0f b6 00             	movzbl (%rax),%eax
  180316:	38 c1                	cmp    %al,%cl
  180318:	0f 92 c0             	setb   %al
  18031b:	0f b6 c8             	movzbl %al,%ecx
  18031e:	89 d0                	mov    %edx,%eax
  180320:	29 c8                	sub    %ecx,%eax
}
  180322:	c9                   	leave  
  180323:	c3                   	ret    

0000000000180324 <strchr>:

char* strchr(const char* s, int c) {
  180324:	f3 0f 1e fa          	endbr64 
  180328:	55                   	push   %rbp
  180329:	48 89 e5             	mov    %rsp,%rbp
  18032c:	48 83 ec 10          	sub    $0x10,%rsp
  180330:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  180334:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  180337:	eb 05                	jmp    18033e <strchr+0x1a>
        ++s;
  180339:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  18033e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  180342:	0f b6 00             	movzbl (%rax),%eax
  180345:	84 c0                	test   %al,%al
  180347:	74 0e                	je     180357 <strchr+0x33>
  180349:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  18034d:	0f b6 00             	movzbl (%rax),%eax
  180350:	8b 55 f4             	mov    -0xc(%rbp),%edx
  180353:	38 d0                	cmp    %dl,%al
  180355:	75 e2                	jne    180339 <strchr+0x15>
    }
    if (*s == (char) c) {
  180357:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  18035b:	0f b6 00             	movzbl (%rax),%eax
  18035e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  180361:	38 d0                	cmp    %dl,%al
  180363:	75 06                	jne    18036b <strchr+0x47>
        return (char*) s;
  180365:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  180369:	eb 05                	jmp    180370 <strchr+0x4c>
    } else {
        return NULL;
  18036b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  180370:	c9                   	leave  
  180371:	c3                   	ret    

0000000000180372 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  180372:	f3 0f 1e fa          	endbr64 
  180376:	55                   	push   %rbp
  180377:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  18037a:	8b 05 90 1c 00 00    	mov    0x1c90(%rip),%eax        # 182010 <rand_seed_set>
  180380:	85 c0                	test   %eax,%eax
  180382:	75 0a                	jne    18038e <rand+0x1c>
        srand(819234718U);
  180384:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  180389:	e8 24 00 00 00       	call   1803b2 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  18038e:	8b 05 80 1c 00 00    	mov    0x1c80(%rip),%eax        # 182014 <rand_seed>
  180394:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  18039a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  18039f:	89 05 6f 1c 00 00    	mov    %eax,0x1c6f(%rip)        # 182014 <rand_seed>
    return rand_seed & RAND_MAX;
  1803a5:	8b 05 69 1c 00 00    	mov    0x1c69(%rip),%eax        # 182014 <rand_seed>
  1803ab:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1803b0:	5d                   	pop    %rbp
  1803b1:	c3                   	ret    

00000000001803b2 <srand>:

void srand(unsigned seed) {
  1803b2:	f3 0f 1e fa          	endbr64 
  1803b6:	55                   	push   %rbp
  1803b7:	48 89 e5             	mov    %rsp,%rbp
  1803ba:	48 83 ec 08          	sub    $0x8,%rsp
  1803be:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1803c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1803c4:	89 05 4a 1c 00 00    	mov    %eax,0x1c4a(%rip)        # 182014 <rand_seed>
    rand_seed_set = 1;
  1803ca:	c7 05 3c 1c 00 00 01 	movl   $0x1,0x1c3c(%rip)        # 182010 <rand_seed_set>
  1803d1:	00 00 00 
}
  1803d4:	90                   	nop
  1803d5:	c9                   	leave  
  1803d6:	c3                   	ret    

00000000001803d7 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1803d7:	f3 0f 1e fa          	endbr64 
  1803db:	55                   	push   %rbp
  1803dc:	48 89 e5             	mov    %rsp,%rbp
  1803df:	48 83 ec 28          	sub    $0x28,%rsp
  1803e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1803e7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1803eb:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1803ee:	48 8d 05 ab 0e 00 00 	lea    0xeab(%rip),%rax        # 1812a0 <upper_digits.1>
  1803f5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  1803f9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1803fd:	79 0e                	jns    18040d <fill_numbuf+0x36>
        digits = lower_digits;
  1803ff:	48 8d 05 ba 0e 00 00 	lea    0xeba(%rip),%rax        # 1812c0 <lower_digits.0>
  180406:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  18040a:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  18040d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  180412:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  180416:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  180419:	8b 45 dc             	mov    -0x24(%rbp),%eax
  18041c:	48 63 c8             	movslq %eax,%rcx
  18041f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  180423:	ba 00 00 00 00       	mov    $0x0,%edx
  180428:	48 f7 f1             	div    %rcx
  18042b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  18042f:	48 01 d0             	add    %rdx,%rax
  180432:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  180437:	0f b6 10             	movzbl (%rax),%edx
  18043a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  18043e:	88 10                	mov    %dl,(%rax)
        val /= base;
  180440:	8b 45 dc             	mov    -0x24(%rbp),%eax
  180443:	48 63 f0             	movslq %eax,%rsi
  180446:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  18044a:	ba 00 00 00 00       	mov    $0x0,%edx
  18044f:	48 f7 f6             	div    %rsi
  180452:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  180456:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  18045b:	75 bc                	jne    180419 <fill_numbuf+0x42>
    return numbuf_end;
  18045d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  180461:	c9                   	leave  
  180462:	c3                   	ret    

0000000000180463 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  180463:	f3 0f 1e fa          	endbr64 
  180467:	55                   	push   %rbp
  180468:	48 89 e5             	mov    %rsp,%rbp
  18046b:	53                   	push   %rbx
  18046c:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  180473:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  18047a:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  180480:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  180487:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  18048e:	e9 bd 09 00 00       	jmp    180e50 <printer_vprintf+0x9ed>
        if (*format != '%') {
  180493:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  18049a:	0f b6 00             	movzbl (%rax),%eax
  18049d:	3c 25                	cmp    $0x25,%al
  18049f:	74 31                	je     1804d2 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  1804a1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1804a8:	4c 8b 00             	mov    (%rax),%r8
  1804ab:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1804b2:	0f b6 00             	movzbl (%rax),%eax
  1804b5:	0f b6 c8             	movzbl %al,%ecx
  1804b8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1804be:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1804c5:	89 ce                	mov    %ecx,%esi
  1804c7:	48 89 c7             	mov    %rax,%rdi
  1804ca:	41 ff d0             	call   *%r8
            continue;
  1804cd:	e9 76 09 00 00       	jmp    180e48 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  1804d2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1804d9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1804e0:	01 
  1804e1:	eb 4d                	jmp    180530 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  1804e3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1804ea:	0f b6 00             	movzbl (%rax),%eax
  1804ed:	0f be c0             	movsbl %al,%eax
  1804f0:	89 c6                	mov    %eax,%esi
  1804f2:	48 8d 05 a7 0c 00 00 	lea    0xca7(%rip),%rax        # 1811a0 <flag_chars>
  1804f9:	48 89 c7             	mov    %rax,%rdi
  1804fc:	e8 23 fe ff ff       	call   180324 <strchr>
  180501:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  180505:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  18050a:	74 34                	je     180540 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  18050c:	48 8d 15 8d 0c 00 00 	lea    0xc8d(%rip),%rdx        # 1811a0 <flag_chars>
  180513:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  180517:	48 29 d0             	sub    %rdx,%rax
  18051a:	ba 01 00 00 00       	mov    $0x1,%edx
  18051f:	89 c1                	mov    %eax,%ecx
  180521:	d3 e2                	shl    %cl,%edx
  180523:	89 d0                	mov    %edx,%eax
  180525:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  180528:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  18052f:	01 
  180530:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  180537:	0f b6 00             	movzbl (%rax),%eax
  18053a:	84 c0                	test   %al,%al
  18053c:	75 a5                	jne    1804e3 <printer_vprintf+0x80>
  18053e:	eb 01                	jmp    180541 <printer_vprintf+0xde>
            } else {
                break;
  180540:	90                   	nop
            }
        }

        // process width
        int width = -1;
  180541:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  180548:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  18054f:	0f b6 00             	movzbl (%rax),%eax
  180552:	3c 30                	cmp    $0x30,%al
  180554:	7e 67                	jle    1805bd <printer_vprintf+0x15a>
  180556:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  18055d:	0f b6 00             	movzbl (%rax),%eax
  180560:	3c 39                	cmp    $0x39,%al
  180562:	7f 59                	jg     1805bd <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  180564:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  18056b:	eb 2e                	jmp    18059b <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  18056d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  180570:	89 d0                	mov    %edx,%eax
  180572:	c1 e0 02             	shl    $0x2,%eax
  180575:	01 d0                	add    %edx,%eax
  180577:	01 c0                	add    %eax,%eax
  180579:	89 c1                	mov    %eax,%ecx
  18057b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  180582:	48 8d 50 01          	lea    0x1(%rax),%rdx
  180586:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  18058d:	0f b6 00             	movzbl (%rax),%eax
  180590:	0f be c0             	movsbl %al,%eax
  180593:	01 c8                	add    %ecx,%eax
  180595:	83 e8 30             	sub    $0x30,%eax
  180598:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  18059b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1805a2:	0f b6 00             	movzbl (%rax),%eax
  1805a5:	3c 2f                	cmp    $0x2f,%al
  1805a7:	0f 8e 85 00 00 00    	jle    180632 <printer_vprintf+0x1cf>
  1805ad:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1805b4:	0f b6 00             	movzbl (%rax),%eax
  1805b7:	3c 39                	cmp    $0x39,%al
  1805b9:	7e b2                	jle    18056d <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  1805bb:	eb 75                	jmp    180632 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  1805bd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1805c4:	0f b6 00             	movzbl (%rax),%eax
  1805c7:	3c 2a                	cmp    $0x2a,%al
  1805c9:	75 68                	jne    180633 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  1805cb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1805d2:	8b 00                	mov    (%rax),%eax
  1805d4:	83 f8 2f             	cmp    $0x2f,%eax
  1805d7:	77 30                	ja     180609 <printer_vprintf+0x1a6>
  1805d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1805e0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1805e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1805eb:	8b 00                	mov    (%rax),%eax
  1805ed:	89 c0                	mov    %eax,%eax
  1805ef:	48 01 d0             	add    %rdx,%rax
  1805f2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1805f9:	8b 12                	mov    (%rdx),%edx
  1805fb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1805fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180605:	89 0a                	mov    %ecx,(%rdx)
  180607:	eb 1a                	jmp    180623 <printer_vprintf+0x1c0>
  180609:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180610:	48 8b 40 08          	mov    0x8(%rax),%rax
  180614:	48 8d 48 08          	lea    0x8(%rax),%rcx
  180618:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  18061f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  180623:	8b 00                	mov    (%rax),%eax
  180625:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  180628:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  18062f:	01 
  180630:	eb 01                	jmp    180633 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  180632:	90                   	nop
        }

        // process precision
        int precision = -1;
  180633:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  18063a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  180641:	0f b6 00             	movzbl (%rax),%eax
  180644:	3c 2e                	cmp    $0x2e,%al
  180646:	0f 85 00 01 00 00    	jne    18074c <printer_vprintf+0x2e9>
            ++format;
  18064c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  180653:	01 
            if (*format >= '0' && *format <= '9') {
  180654:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  18065b:	0f b6 00             	movzbl (%rax),%eax
  18065e:	3c 2f                	cmp    $0x2f,%al
  180660:	7e 67                	jle    1806c9 <printer_vprintf+0x266>
  180662:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  180669:	0f b6 00             	movzbl (%rax),%eax
  18066c:	3c 39                	cmp    $0x39,%al
  18066e:	7f 59                	jg     1806c9 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  180670:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  180677:	eb 2e                	jmp    1806a7 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  180679:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  18067c:	89 d0                	mov    %edx,%eax
  18067e:	c1 e0 02             	shl    $0x2,%eax
  180681:	01 d0                	add    %edx,%eax
  180683:	01 c0                	add    %eax,%eax
  180685:	89 c1                	mov    %eax,%ecx
  180687:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  18068e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  180692:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  180699:	0f b6 00             	movzbl (%rax),%eax
  18069c:	0f be c0             	movsbl %al,%eax
  18069f:	01 c8                	add    %ecx,%eax
  1806a1:	83 e8 30             	sub    $0x30,%eax
  1806a4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1806a7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1806ae:	0f b6 00             	movzbl (%rax),%eax
  1806b1:	3c 2f                	cmp    $0x2f,%al
  1806b3:	0f 8e 85 00 00 00    	jle    18073e <printer_vprintf+0x2db>
  1806b9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1806c0:	0f b6 00             	movzbl (%rax),%eax
  1806c3:	3c 39                	cmp    $0x39,%al
  1806c5:	7e b2                	jle    180679 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  1806c7:	eb 75                	jmp    18073e <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  1806c9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1806d0:	0f b6 00             	movzbl (%rax),%eax
  1806d3:	3c 2a                	cmp    $0x2a,%al
  1806d5:	75 68                	jne    18073f <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  1806d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1806de:	8b 00                	mov    (%rax),%eax
  1806e0:	83 f8 2f             	cmp    $0x2f,%eax
  1806e3:	77 30                	ja     180715 <printer_vprintf+0x2b2>
  1806e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1806ec:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1806f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1806f7:	8b 00                	mov    (%rax),%eax
  1806f9:	89 c0                	mov    %eax,%eax
  1806fb:	48 01 d0             	add    %rdx,%rax
  1806fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180705:	8b 12                	mov    (%rdx),%edx
  180707:	8d 4a 08             	lea    0x8(%rdx),%ecx
  18070a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180711:	89 0a                	mov    %ecx,(%rdx)
  180713:	eb 1a                	jmp    18072f <printer_vprintf+0x2cc>
  180715:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  18071c:	48 8b 40 08          	mov    0x8(%rax),%rax
  180720:	48 8d 48 08          	lea    0x8(%rax),%rcx
  180724:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  18072b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  18072f:	8b 00                	mov    (%rax),%eax
  180731:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  180734:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  18073b:	01 
  18073c:	eb 01                	jmp    18073f <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  18073e:	90                   	nop
            }
            if (precision < 0) {
  18073f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  180743:	79 07                	jns    18074c <printer_vprintf+0x2e9>
                precision = 0;
  180745:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  18074c:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  180753:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  18075a:	00 
        int length = 0;
  18075b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  180762:	48 8d 05 3d 0a 00 00 	lea    0xa3d(%rip),%rax        # 1811a6 <flag_chars+0x6>
  180769:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  18076d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  180774:	0f b6 00             	movzbl (%rax),%eax
  180777:	0f be c0             	movsbl %al,%eax
  18077a:	83 e8 43             	sub    $0x43,%eax
  18077d:	83 f8 37             	cmp    $0x37,%eax
  180780:	0f 87 b6 03 00 00    	ja     180b3c <printer_vprintf+0x6d9>
  180786:	89 c0                	mov    %eax,%eax
  180788:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  18078f:	00 
  180790:	48 8d 05 1d 0a 00 00 	lea    0xa1d(%rip),%rax        # 1811b4 <flag_chars+0x14>
  180797:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  18079a:	48 98                	cltq   
  18079c:	48 8d 15 11 0a 00 00 	lea    0xa11(%rip),%rdx        # 1811b4 <flag_chars+0x14>
  1807a3:	48 01 d0             	add    %rdx,%rax
  1807a6:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  1807a9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1807b0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1807b7:	01 
            goto again;
  1807b8:	eb b3                	jmp    18076d <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1807ba:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1807be:	74 5d                	je     18081d <printer_vprintf+0x3ba>
  1807c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1807c7:	8b 00                	mov    (%rax),%eax
  1807c9:	83 f8 2f             	cmp    $0x2f,%eax
  1807cc:	77 30                	ja     1807fe <printer_vprintf+0x39b>
  1807ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1807d5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1807d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1807e0:	8b 00                	mov    (%rax),%eax
  1807e2:	89 c0                	mov    %eax,%eax
  1807e4:	48 01 d0             	add    %rdx,%rax
  1807e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1807ee:	8b 12                	mov    (%rdx),%edx
  1807f0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1807f3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1807fa:	89 0a                	mov    %ecx,(%rdx)
  1807fc:	eb 1a                	jmp    180818 <printer_vprintf+0x3b5>
  1807fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180805:	48 8b 40 08          	mov    0x8(%rax),%rax
  180809:	48 8d 48 08          	lea    0x8(%rax),%rcx
  18080d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180814:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  180818:	48 8b 00             	mov    (%rax),%rax
  18081b:	eb 5c                	jmp    180879 <printer_vprintf+0x416>
  18081d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180824:	8b 00                	mov    (%rax),%eax
  180826:	83 f8 2f             	cmp    $0x2f,%eax
  180829:	77 30                	ja     18085b <printer_vprintf+0x3f8>
  18082b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180832:	48 8b 50 10          	mov    0x10(%rax),%rdx
  180836:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  18083d:	8b 00                	mov    (%rax),%eax
  18083f:	89 c0                	mov    %eax,%eax
  180841:	48 01 d0             	add    %rdx,%rax
  180844:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  18084b:	8b 12                	mov    (%rdx),%edx
  18084d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  180850:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180857:	89 0a                	mov    %ecx,(%rdx)
  180859:	eb 1a                	jmp    180875 <printer_vprintf+0x412>
  18085b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180862:	48 8b 40 08          	mov    0x8(%rax),%rax
  180866:	48 8d 48 08          	lea    0x8(%rax),%rcx
  18086a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180871:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  180875:	8b 00                	mov    (%rax),%eax
  180877:	48 98                	cltq   
  180879:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  18087d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  180881:	48 c1 f8 38          	sar    $0x38,%rax
  180885:	25 80 00 00 00       	and    $0x80,%eax
  18088a:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  18088d:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  180891:	74 09                	je     18089c <printer_vprintf+0x439>
  180893:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  180897:	48 f7 d8             	neg    %rax
  18089a:	eb 04                	jmp    1808a0 <printer_vprintf+0x43d>
  18089c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1808a0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1808a4:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  1808a7:	83 c8 60             	or     $0x60,%eax
  1808aa:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  1808ad:	e9 cf 02 00 00       	jmp    180b81 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1808b2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1808b6:	74 5d                	je     180915 <printer_vprintf+0x4b2>
  1808b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1808bf:	8b 00                	mov    (%rax),%eax
  1808c1:	83 f8 2f             	cmp    $0x2f,%eax
  1808c4:	77 30                	ja     1808f6 <printer_vprintf+0x493>
  1808c6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1808cd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1808d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1808d8:	8b 00                	mov    (%rax),%eax
  1808da:	89 c0                	mov    %eax,%eax
  1808dc:	48 01 d0             	add    %rdx,%rax
  1808df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1808e6:	8b 12                	mov    (%rdx),%edx
  1808e8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1808eb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1808f2:	89 0a                	mov    %ecx,(%rdx)
  1808f4:	eb 1a                	jmp    180910 <printer_vprintf+0x4ad>
  1808f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1808fd:	48 8b 40 08          	mov    0x8(%rax),%rax
  180901:	48 8d 48 08          	lea    0x8(%rax),%rcx
  180905:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  18090c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  180910:	48 8b 00             	mov    (%rax),%rax
  180913:	eb 5c                	jmp    180971 <printer_vprintf+0x50e>
  180915:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  18091c:	8b 00                	mov    (%rax),%eax
  18091e:	83 f8 2f             	cmp    $0x2f,%eax
  180921:	77 30                	ja     180953 <printer_vprintf+0x4f0>
  180923:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  18092a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  18092e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180935:	8b 00                	mov    (%rax),%eax
  180937:	89 c0                	mov    %eax,%eax
  180939:	48 01 d0             	add    %rdx,%rax
  18093c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180943:	8b 12                	mov    (%rdx),%edx
  180945:	8d 4a 08             	lea    0x8(%rdx),%ecx
  180948:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  18094f:	89 0a                	mov    %ecx,(%rdx)
  180951:	eb 1a                	jmp    18096d <printer_vprintf+0x50a>
  180953:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  18095a:	48 8b 40 08          	mov    0x8(%rax),%rax
  18095e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  180962:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180969:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  18096d:	8b 00                	mov    (%rax),%eax
  18096f:	89 c0                	mov    %eax,%eax
  180971:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  180975:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  180979:	e9 03 02 00 00       	jmp    180b81 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  18097e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  180985:	e9 28 ff ff ff       	jmp    1808b2 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  18098a:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  180991:	e9 1c ff ff ff       	jmp    1808b2 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  180996:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  18099d:	8b 00                	mov    (%rax),%eax
  18099f:	83 f8 2f             	cmp    $0x2f,%eax
  1809a2:	77 30                	ja     1809d4 <printer_vprintf+0x571>
  1809a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1809ab:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1809af:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1809b6:	8b 00                	mov    (%rax),%eax
  1809b8:	89 c0                	mov    %eax,%eax
  1809ba:	48 01 d0             	add    %rdx,%rax
  1809bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1809c4:	8b 12                	mov    (%rdx),%edx
  1809c6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1809c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1809d0:	89 0a                	mov    %ecx,(%rdx)
  1809d2:	eb 1a                	jmp    1809ee <printer_vprintf+0x58b>
  1809d4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1809db:	48 8b 40 08          	mov    0x8(%rax),%rax
  1809df:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1809e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1809ea:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1809ee:	48 8b 00             	mov    (%rax),%rax
  1809f1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1809f5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1809fc:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  180a03:	e9 79 01 00 00       	jmp    180b81 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  180a08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180a0f:	8b 00                	mov    (%rax),%eax
  180a11:	83 f8 2f             	cmp    $0x2f,%eax
  180a14:	77 30                	ja     180a46 <printer_vprintf+0x5e3>
  180a16:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180a1d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  180a21:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180a28:	8b 00                	mov    (%rax),%eax
  180a2a:	89 c0                	mov    %eax,%eax
  180a2c:	48 01 d0             	add    %rdx,%rax
  180a2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180a36:	8b 12                	mov    (%rdx),%edx
  180a38:	8d 4a 08             	lea    0x8(%rdx),%ecx
  180a3b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180a42:	89 0a                	mov    %ecx,(%rdx)
  180a44:	eb 1a                	jmp    180a60 <printer_vprintf+0x5fd>
  180a46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180a4d:	48 8b 40 08          	mov    0x8(%rax),%rax
  180a51:	48 8d 48 08          	lea    0x8(%rax),%rcx
  180a55:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180a5c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  180a60:	48 8b 00             	mov    (%rax),%rax
  180a63:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  180a67:	e9 15 01 00 00       	jmp    180b81 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  180a6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180a73:	8b 00                	mov    (%rax),%eax
  180a75:	83 f8 2f             	cmp    $0x2f,%eax
  180a78:	77 30                	ja     180aaa <printer_vprintf+0x647>
  180a7a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180a81:	48 8b 50 10          	mov    0x10(%rax),%rdx
  180a85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180a8c:	8b 00                	mov    (%rax),%eax
  180a8e:	89 c0                	mov    %eax,%eax
  180a90:	48 01 d0             	add    %rdx,%rax
  180a93:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180a9a:	8b 12                	mov    (%rdx),%edx
  180a9c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  180a9f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180aa6:	89 0a                	mov    %ecx,(%rdx)
  180aa8:	eb 1a                	jmp    180ac4 <printer_vprintf+0x661>
  180aaa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180ab1:	48 8b 40 08          	mov    0x8(%rax),%rax
  180ab5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  180ab9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180ac0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  180ac4:	8b 00                	mov    (%rax),%eax
  180ac6:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  180acc:	e9 77 03 00 00       	jmp    180e48 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  180ad1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  180ad5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  180ad9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180ae0:	8b 00                	mov    (%rax),%eax
  180ae2:	83 f8 2f             	cmp    $0x2f,%eax
  180ae5:	77 30                	ja     180b17 <printer_vprintf+0x6b4>
  180ae7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180aee:	48 8b 50 10          	mov    0x10(%rax),%rdx
  180af2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180af9:	8b 00                	mov    (%rax),%eax
  180afb:	89 c0                	mov    %eax,%eax
  180afd:	48 01 d0             	add    %rdx,%rax
  180b00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180b07:	8b 12                	mov    (%rdx),%edx
  180b09:	8d 4a 08             	lea    0x8(%rdx),%ecx
  180b0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180b13:	89 0a                	mov    %ecx,(%rdx)
  180b15:	eb 1a                	jmp    180b31 <printer_vprintf+0x6ce>
  180b17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  180b1e:	48 8b 40 08          	mov    0x8(%rax),%rax
  180b22:	48 8d 48 08          	lea    0x8(%rax),%rcx
  180b26:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  180b2d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  180b31:	8b 00                	mov    (%rax),%eax
  180b33:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  180b36:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  180b3a:	eb 45                	jmp    180b81 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  180b3c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  180b40:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  180b44:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  180b4b:	0f b6 00             	movzbl (%rax),%eax
  180b4e:	84 c0                	test   %al,%al
  180b50:	74 0c                	je     180b5e <printer_vprintf+0x6fb>
  180b52:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  180b59:	0f b6 00             	movzbl (%rax),%eax
  180b5c:	eb 05                	jmp    180b63 <printer_vprintf+0x700>
  180b5e:	b8 25 00 00 00       	mov    $0x25,%eax
  180b63:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  180b66:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  180b6a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  180b71:	0f b6 00             	movzbl (%rax),%eax
  180b74:	84 c0                	test   %al,%al
  180b76:	75 08                	jne    180b80 <printer_vprintf+0x71d>
                format--;
  180b78:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  180b7f:	01 
            }
            break;
  180b80:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  180b81:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180b84:	83 e0 20             	and    $0x20,%eax
  180b87:	85 c0                	test   %eax,%eax
  180b89:	74 1e                	je     180ba9 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  180b8b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  180b8f:	48 83 c0 18          	add    $0x18,%rax
  180b93:	8b 55 e0             	mov    -0x20(%rbp),%edx
  180b96:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  180b9a:	48 89 ce             	mov    %rcx,%rsi
  180b9d:	48 89 c7             	mov    %rax,%rdi
  180ba0:	e8 32 f8 ff ff       	call   1803d7 <fill_numbuf>
  180ba5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  180ba9:	48 8d 05 f6 05 00 00 	lea    0x5f6(%rip),%rax        # 1811a6 <flag_chars+0x6>
  180bb0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  180bb4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180bb7:	83 e0 20             	and    $0x20,%eax
  180bba:	85 c0                	test   %eax,%eax
  180bbc:	74 51                	je     180c0f <printer_vprintf+0x7ac>
  180bbe:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180bc1:	83 e0 40             	and    $0x40,%eax
  180bc4:	85 c0                	test   %eax,%eax
  180bc6:	74 47                	je     180c0f <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  180bc8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180bcb:	25 80 00 00 00       	and    $0x80,%eax
  180bd0:	85 c0                	test   %eax,%eax
  180bd2:	74 0d                	je     180be1 <printer_vprintf+0x77e>
                prefix = "-";
  180bd4:	48 8d 05 cc 05 00 00 	lea    0x5cc(%rip),%rax        # 1811a7 <flag_chars+0x7>
  180bdb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  180bdf:	eb 7d                	jmp    180c5e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  180be1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180be4:	83 e0 10             	and    $0x10,%eax
  180be7:	85 c0                	test   %eax,%eax
  180be9:	74 0d                	je     180bf8 <printer_vprintf+0x795>
                prefix = "+";
  180beb:	48 8d 05 b7 05 00 00 	lea    0x5b7(%rip),%rax        # 1811a9 <flag_chars+0x9>
  180bf2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  180bf6:	eb 66                	jmp    180c5e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  180bf8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180bfb:	83 e0 08             	and    $0x8,%eax
  180bfe:	85 c0                	test   %eax,%eax
  180c00:	74 5c                	je     180c5e <printer_vprintf+0x7fb>
                prefix = " ";
  180c02:	48 8d 05 a2 05 00 00 	lea    0x5a2(%rip),%rax        # 1811ab <flag_chars+0xb>
  180c09:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  180c0d:	eb 4f                	jmp    180c5e <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  180c0f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180c12:	83 e0 20             	and    $0x20,%eax
  180c15:	85 c0                	test   %eax,%eax
  180c17:	74 46                	je     180c5f <printer_vprintf+0x7fc>
  180c19:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180c1c:	83 e0 01             	and    $0x1,%eax
  180c1f:	85 c0                	test   %eax,%eax
  180c21:	74 3c                	je     180c5f <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  180c23:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  180c27:	74 06                	je     180c2f <printer_vprintf+0x7cc>
  180c29:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  180c2d:	75 30                	jne    180c5f <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  180c2f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  180c34:	75 0c                	jne    180c42 <printer_vprintf+0x7df>
  180c36:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180c39:	25 00 01 00 00       	and    $0x100,%eax
  180c3e:	85 c0                	test   %eax,%eax
  180c40:	74 1d                	je     180c5f <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  180c42:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  180c46:	75 09                	jne    180c51 <printer_vprintf+0x7ee>
  180c48:	48 8d 05 5e 05 00 00 	lea    0x55e(%rip),%rax        # 1811ad <flag_chars+0xd>
  180c4f:	eb 07                	jmp    180c58 <printer_vprintf+0x7f5>
  180c51:	48 8d 05 58 05 00 00 	lea    0x558(%rip),%rax        # 1811b0 <flag_chars+0x10>
  180c58:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  180c5c:	eb 01                	jmp    180c5f <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  180c5e:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  180c5f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  180c63:	78 24                	js     180c89 <printer_vprintf+0x826>
  180c65:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180c68:	83 e0 20             	and    $0x20,%eax
  180c6b:	85 c0                	test   %eax,%eax
  180c6d:	75 1a                	jne    180c89 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  180c6f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  180c72:	48 63 d0             	movslq %eax,%rdx
  180c75:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  180c79:	48 89 d6             	mov    %rdx,%rsi
  180c7c:	48 89 c7             	mov    %rax,%rdi
  180c7f:	e8 91 f5 ff ff       	call   180215 <strnlen>
  180c84:	89 45 bc             	mov    %eax,-0x44(%rbp)
  180c87:	eb 0f                	jmp    180c98 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  180c89:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  180c8d:	48 89 c7             	mov    %rax,%rdi
  180c90:	e8 4b f5 ff ff       	call   1801e0 <strlen>
  180c95:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  180c98:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180c9b:	83 e0 20             	and    $0x20,%eax
  180c9e:	85 c0                	test   %eax,%eax
  180ca0:	74 20                	je     180cc2 <printer_vprintf+0x85f>
  180ca2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  180ca6:	78 1a                	js     180cc2 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  180ca8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  180cab:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  180cae:	7e 08                	jle    180cb8 <printer_vprintf+0x855>
  180cb0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  180cb3:	2b 45 bc             	sub    -0x44(%rbp),%eax
  180cb6:	eb 05                	jmp    180cbd <printer_vprintf+0x85a>
  180cb8:	b8 00 00 00 00       	mov    $0x0,%eax
  180cbd:	89 45 b8             	mov    %eax,-0x48(%rbp)
  180cc0:	eb 5c                	jmp    180d1e <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  180cc2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180cc5:	83 e0 20             	and    $0x20,%eax
  180cc8:	85 c0                	test   %eax,%eax
  180cca:	74 4b                	je     180d17 <printer_vprintf+0x8b4>
  180ccc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180ccf:	83 e0 02             	and    $0x2,%eax
  180cd2:	85 c0                	test   %eax,%eax
  180cd4:	74 41                	je     180d17 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  180cd6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180cd9:	83 e0 04             	and    $0x4,%eax
  180cdc:	85 c0                	test   %eax,%eax
  180cde:	75 37                	jne    180d17 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  180ce0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  180ce4:	48 89 c7             	mov    %rax,%rdi
  180ce7:	e8 f4 f4 ff ff       	call   1801e0 <strlen>
  180cec:	89 c2                	mov    %eax,%edx
  180cee:	8b 45 bc             	mov    -0x44(%rbp),%eax
  180cf1:	01 d0                	add    %edx,%eax
  180cf3:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  180cf6:	7e 1f                	jle    180d17 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  180cf8:	8b 45 e8             	mov    -0x18(%rbp),%eax
  180cfb:	2b 45 bc             	sub    -0x44(%rbp),%eax
  180cfe:	89 c3                	mov    %eax,%ebx
  180d00:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  180d04:	48 89 c7             	mov    %rax,%rdi
  180d07:	e8 d4 f4 ff ff       	call   1801e0 <strlen>
  180d0c:	89 c2                	mov    %eax,%edx
  180d0e:	89 d8                	mov    %ebx,%eax
  180d10:	29 d0                	sub    %edx,%eax
  180d12:	89 45 b8             	mov    %eax,-0x48(%rbp)
  180d15:	eb 07                	jmp    180d1e <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  180d17:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  180d1e:	8b 55 bc             	mov    -0x44(%rbp),%edx
  180d21:	8b 45 b8             	mov    -0x48(%rbp),%eax
  180d24:	01 d0                	add    %edx,%eax
  180d26:	48 63 d8             	movslq %eax,%rbx
  180d29:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  180d2d:	48 89 c7             	mov    %rax,%rdi
  180d30:	e8 ab f4 ff ff       	call   1801e0 <strlen>
  180d35:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  180d39:	8b 45 e8             	mov    -0x18(%rbp),%eax
  180d3c:	29 d0                	sub    %edx,%eax
  180d3e:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  180d41:	eb 25                	jmp    180d68 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  180d43:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  180d4a:	48 8b 08             	mov    (%rax),%rcx
  180d4d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  180d53:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  180d5a:	be 20 00 00 00       	mov    $0x20,%esi
  180d5f:	48 89 c7             	mov    %rax,%rdi
  180d62:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  180d64:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  180d68:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180d6b:	83 e0 04             	and    $0x4,%eax
  180d6e:	85 c0                	test   %eax,%eax
  180d70:	75 36                	jne    180da8 <printer_vprintf+0x945>
  180d72:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  180d76:	7f cb                	jg     180d43 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  180d78:	eb 2e                	jmp    180da8 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  180d7a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  180d81:	4c 8b 00             	mov    (%rax),%r8
  180d84:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  180d88:	0f b6 00             	movzbl (%rax),%eax
  180d8b:	0f b6 c8             	movzbl %al,%ecx
  180d8e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  180d94:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  180d9b:	89 ce                	mov    %ecx,%esi
  180d9d:	48 89 c7             	mov    %rax,%rdi
  180da0:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  180da3:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  180da8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  180dac:	0f b6 00             	movzbl (%rax),%eax
  180daf:	84 c0                	test   %al,%al
  180db1:	75 c7                	jne    180d7a <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  180db3:	eb 25                	jmp    180dda <printer_vprintf+0x977>
            p->putc(p, '0', color);
  180db5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  180dbc:	48 8b 08             	mov    (%rax),%rcx
  180dbf:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  180dc5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  180dcc:	be 30 00 00 00       	mov    $0x30,%esi
  180dd1:	48 89 c7             	mov    %rax,%rdi
  180dd4:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  180dd6:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  180dda:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  180dde:	7f d5                	jg     180db5 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  180de0:	eb 32                	jmp    180e14 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  180de2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  180de9:	4c 8b 00             	mov    (%rax),%r8
  180dec:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  180df0:	0f b6 00             	movzbl (%rax),%eax
  180df3:	0f b6 c8             	movzbl %al,%ecx
  180df6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  180dfc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  180e03:	89 ce                	mov    %ecx,%esi
  180e05:	48 89 c7             	mov    %rax,%rdi
  180e08:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  180e0b:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  180e10:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  180e14:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  180e18:	7f c8                	jg     180de2 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  180e1a:	eb 25                	jmp    180e41 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  180e1c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  180e23:	48 8b 08             	mov    (%rax),%rcx
  180e26:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  180e2c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  180e33:	be 20 00 00 00       	mov    $0x20,%esi
  180e38:	48 89 c7             	mov    %rax,%rdi
  180e3b:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  180e3d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  180e41:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  180e45:	7f d5                	jg     180e1c <printer_vprintf+0x9b9>
        }
    done: ;
  180e47:	90                   	nop
    for (; *format; ++format) {
  180e48:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  180e4f:	01 
  180e50:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  180e57:	0f b6 00             	movzbl (%rax),%eax
  180e5a:	84 c0                	test   %al,%al
  180e5c:	0f 85 31 f6 ff ff    	jne    180493 <printer_vprintf+0x30>
    }
}
  180e62:	90                   	nop
  180e63:	90                   	nop
  180e64:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  180e68:	c9                   	leave  
  180e69:	c3                   	ret    

0000000000180e6a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  180e6a:	f3 0f 1e fa          	endbr64 
  180e6e:	55                   	push   %rbp
  180e6f:	48 89 e5             	mov    %rsp,%rbp
  180e72:	48 83 ec 20          	sub    $0x20,%rsp
  180e76:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  180e7a:	89 f0                	mov    %esi,%eax
  180e7c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  180e7f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  180e82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  180e86:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  180e8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  180e8e:	48 8b 40 08          	mov    0x8(%rax),%rax
  180e92:	48 8d 15 07 81 f3 ff 	lea    -0xc7ef9(%rip),%rdx        # b8fa0 <console+0xfa0>
  180e99:	48 39 d0             	cmp    %rdx,%rax
  180e9c:	72 0f                	jb     180ead <console_putc+0x43>
        cp->cursor = console;
  180e9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  180ea2:	48 8d 15 57 71 f3 ff 	lea    -0xc8ea9(%rip),%rdx        # b8000 <console>
  180ea9:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  180ead:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  180eb1:	0f 85 82 00 00 00    	jne    180f39 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  180eb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  180ebb:	48 8b 40 08          	mov    0x8(%rax),%rax
  180ebf:	48 8d 15 3a 71 f3 ff 	lea    -0xc8ec6(%rip),%rdx        # b8000 <console>
  180ec6:	48 29 d0             	sub    %rdx,%rax
  180ec9:	48 d1 f8             	sar    %rax
  180ecc:	48 89 c1             	mov    %rax,%rcx
  180ecf:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  180ed6:	66 66 66 
  180ed9:	48 89 c8             	mov    %rcx,%rax
  180edc:	48 f7 ea             	imul   %rdx
  180edf:	48 89 d0             	mov    %rdx,%rax
  180ee2:	48 c1 f8 05          	sar    $0x5,%rax
  180ee6:	48 89 ce             	mov    %rcx,%rsi
  180ee9:	48 c1 fe 3f          	sar    $0x3f,%rsi
  180eed:	48 29 f0             	sub    %rsi,%rax
  180ef0:	48 89 c2             	mov    %rax,%rdx
  180ef3:	48 89 d0             	mov    %rdx,%rax
  180ef6:	48 c1 e0 02          	shl    $0x2,%rax
  180efa:	48 01 d0             	add    %rdx,%rax
  180efd:	48 c1 e0 04          	shl    $0x4,%rax
  180f01:	48 29 c1             	sub    %rax,%rcx
  180f04:	48 89 ca             	mov    %rcx,%rdx
  180f07:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  180f0a:	eb 25                	jmp    180f31 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  180f0c:	8b 45 e0             	mov    -0x20(%rbp),%eax
  180f0f:	83 c8 20             	or     $0x20,%eax
  180f12:	89 c6                	mov    %eax,%esi
  180f14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  180f18:	48 8b 40 08          	mov    0x8(%rax),%rax
  180f1c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  180f20:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  180f24:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  180f28:	89 f2                	mov    %esi,%edx
  180f2a:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  180f2d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  180f31:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  180f35:	75 d5                	jne    180f0c <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  180f37:	eb 24                	jmp    180f5d <console_putc+0xf3>
        *cp->cursor++ = c | color;
  180f39:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  180f3d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  180f40:	89 d6                	mov    %edx,%esi
  180f42:	09 c6                	or     %eax,%esi
  180f44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  180f48:	48 8b 40 08          	mov    0x8(%rax),%rax
  180f4c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  180f50:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  180f54:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  180f58:	89 f2                	mov    %esi,%edx
  180f5a:	66 89 10             	mov    %dx,(%rax)
}
  180f5d:	90                   	nop
  180f5e:	c9                   	leave  
  180f5f:	c3                   	ret    

0000000000180f60 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  180f60:	f3 0f 1e fa          	endbr64 
  180f64:	55                   	push   %rbp
  180f65:	48 89 e5             	mov    %rsp,%rbp
  180f68:	48 83 ec 30          	sub    $0x30,%rsp
  180f6c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  180f6f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  180f72:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  180f76:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  180f7a:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 180e6a <console_putc>
  180f81:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  180f85:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  180f89:	78 09                	js     180f94 <console_vprintf+0x34>
  180f8b:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  180f92:	7e 07                	jle    180f9b <console_vprintf+0x3b>
        cpos = 0;
  180f94:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  180f9b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  180f9e:	48 98                	cltq   
  180fa0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  180fa4:	48 8d 05 55 70 f3 ff 	lea    -0xc8fab(%rip),%rax        # b8000 <console>
  180fab:	48 01 d0             	add    %rdx,%rax
  180fae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  180fb2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  180fb6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  180fba:	8b 75 e8             	mov    -0x18(%rbp),%esi
  180fbd:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  180fc1:	48 89 c7             	mov    %rax,%rdi
  180fc4:	e8 9a f4 ff ff       	call   180463 <printer_vprintf>
    return cp.cursor - console;
  180fc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  180fcd:	48 8d 15 2c 70 f3 ff 	lea    -0xc8fd4(%rip),%rdx        # b8000 <console>
  180fd4:	48 29 d0             	sub    %rdx,%rax
  180fd7:	48 d1 f8             	sar    %rax
}
  180fda:	c9                   	leave  
  180fdb:	c3                   	ret    

0000000000180fdc <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  180fdc:	f3 0f 1e fa          	endbr64 
  180fe0:	55                   	push   %rbp
  180fe1:	48 89 e5             	mov    %rsp,%rbp
  180fe4:	48 83 ec 60          	sub    $0x60,%rsp
  180fe8:	89 7d ac             	mov    %edi,-0x54(%rbp)
  180feb:	89 75 a8             	mov    %esi,-0x58(%rbp)
  180fee:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  180ff2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  180ff6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  180ffa:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  180ffe:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  181005:	48 8d 45 10          	lea    0x10(%rbp),%rax
  181009:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  18100d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  181011:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  181015:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  181019:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  18101d:	8b 75 a8             	mov    -0x58(%rbp),%esi
  181020:	8b 45 ac             	mov    -0x54(%rbp),%eax
  181023:	89 c7                	mov    %eax,%edi
  181025:	e8 36 ff ff ff       	call   180f60 <console_vprintf>
  18102a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  18102d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  181030:	c9                   	leave  
  181031:	c3                   	ret    

0000000000181032 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  181032:	f3 0f 1e fa          	endbr64 
  181036:	55                   	push   %rbp
  181037:	48 89 e5             	mov    %rsp,%rbp
  18103a:	48 83 ec 20          	sub    $0x20,%rsp
  18103e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  181042:	89 f0                	mov    %esi,%eax
  181044:	89 55 e0             	mov    %edx,-0x20(%rbp)
  181047:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  18104a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  18104e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  181052:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  181056:	48 8b 50 08          	mov    0x8(%rax),%rdx
  18105a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  18105e:	48 8b 40 10          	mov    0x10(%rax),%rax
  181062:	48 39 c2             	cmp    %rax,%rdx
  181065:	73 1a                	jae    181081 <string_putc+0x4f>
        *sp->s++ = c;
  181067:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  18106b:	48 8b 40 08          	mov    0x8(%rax),%rax
  18106f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  181073:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  181077:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  18107b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  18107f:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  181081:	90                   	nop
  181082:	c9                   	leave  
  181083:	c3                   	ret    

0000000000181084 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  181084:	f3 0f 1e fa          	endbr64 
  181088:	55                   	push   %rbp
  181089:	48 89 e5             	mov    %rsp,%rbp
  18108c:	48 83 ec 40          	sub    $0x40,%rsp
  181090:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  181094:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  181098:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  18109c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1810a0:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 181032 <string_putc>
  1810a7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  1810ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1810af:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1810b3:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1810b8:	74 33                	je     1810ed <vsnprintf+0x69>
        sp.end = s + size - 1;
  1810ba:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1810be:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1810c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1810c6:	48 01 d0             	add    %rdx,%rax
  1810c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1810cd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1810d1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1810d5:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1810d9:	be 00 00 00 00       	mov    $0x0,%esi
  1810de:	48 89 c7             	mov    %rax,%rdi
  1810e1:	e8 7d f3 ff ff       	call   180463 <printer_vprintf>
        *sp.s = 0;
  1810e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1810ea:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1810ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1810f1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1810f5:	c9                   	leave  
  1810f6:	c3                   	ret    

00000000001810f7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1810f7:	f3 0f 1e fa          	endbr64 
  1810fb:	55                   	push   %rbp
  1810fc:	48 89 e5             	mov    %rsp,%rbp
  1810ff:	48 83 ec 70          	sub    $0x70,%rsp
  181103:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  181107:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  18110b:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  18110f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  181113:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  181117:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  18111b:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  181122:	48 8d 45 10          	lea    0x10(%rbp),%rax
  181126:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  18112a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  18112e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  181132:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  181136:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  18113a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  18113e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  181142:	48 89 c7             	mov    %rax,%rdi
  181145:	e8 3a ff ff ff       	call   181084 <vsnprintf>
  18114a:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  18114d:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  181150:	c9                   	leave  
  181151:	c3                   	ret    

0000000000181152 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  181152:	f3 0f 1e fa          	endbr64 
  181156:	55                   	push   %rbp
  181157:	48 89 e5             	mov    %rsp,%rbp
  18115a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  18115e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  181165:	eb 1a                	jmp    181181 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  181167:	8b 45 fc             	mov    -0x4(%rbp),%eax
  18116a:	48 98                	cltq   
  18116c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  181170:	48 8d 05 89 6e f3 ff 	lea    -0xc9177(%rip),%rax        # b8000 <console>
  181177:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  18117d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  181181:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  181188:	7e dd                	jle    181167 <console_clear+0x15>
    }
    cursorpos = 0;
  18118a:	c7 05 68 7e f3 ff 00 	movl   $0x0,-0xc8198(%rip)        # b8ffc <cursorpos>
  181191:	00 00 00 
}
  181194:	90                   	nop
  181195:	c9                   	leave  
  181196:	c3                   	ret    
