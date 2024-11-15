
obj/p-allocator4.full:     file format elf64-x86-64


Disassembly of section .text:

00000000001c0000 <process_main>:
uint8_t* stack_bottom;

// Program that starts allocating page by page from its heap
// till it reaches stack OR runs out of memory

void process_main(void) {
  1c0000:	f3 0f 1e fa          	endbr64 
  1c0004:	55                   	push   %rbp
  1c0005:	48 89 e5             	mov    %rsp,%rbp
  1c0008:	53                   	push   %rbx
  1c0009:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  1c000d:	cd 31                	int    $0x31
  1c000f:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  1c0011:	89 c7                	mov    %eax,%edi
  1c0013:	e8 9a 03 00 00       	call   1c03b2 <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  1c0018:	48 8d 05 f8 2f 00 00 	lea    0x2ff8(%rip),%rax        # 1c3017 <end+0xfff>
  1c001f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  1c0025:	48 89 05 dc 1f 00 00 	mov    %rax,0x1fdc(%rip)        # 1c2008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  1c002c:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  1c002f:	48 83 e8 01          	sub    $0x1,%rax
  1c0033:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  1c0039:	48 89 05 c0 1f 00 00 	mov    %rax,0x1fc0(%rip)        # 1c2000 <stack_bottom>
  1c0040:	eb 02                	jmp    1c0044 <process_main+0x44>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  1c0042:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  1c0044:	e8 29 03 00 00       	call   1c0372 <rand>
  1c0049:	48 63 d0             	movslq %eax,%rdx
  1c004c:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1c0053:	48 c1 fa 25          	sar    $0x25,%rdx
  1c0057:	89 c1                	mov    %eax,%ecx
  1c0059:	c1 f9 1f             	sar    $0x1f,%ecx
  1c005c:	29 ca                	sub    %ecx,%edx
  1c005e:	6b d2 64             	imul   $0x64,%edx,%edx
  1c0061:	29 d0                	sub    %edx,%eax
  1c0063:	39 d8                	cmp    %ebx,%eax
  1c0065:	7d db                	jge    1c0042 <process_main+0x42>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  1c0067:	48 8b 3d 9a 1f 00 00 	mov    0x1f9a(%rip),%rdi        # 1c2008 <heap_top>
  1c006e:	48 3b 3d 8b 1f 00 00 	cmp    0x1f8b(%rip),%rdi        # 1c2000 <stack_bottom>
  1c0075:	74 1c                	je     1c0093 <process_main+0x93>
//    Allocate a page of memory at address `addr` and allow process to
//    write to it. `Addr` must be page-aligned (i.e., a multiple of
//    PAGESIZE == 4096). Returns 0 on success and -1 on failure.
static inline int sys_page_alloc(void* addr) {
    int result;
    asm volatile ("int %1" : "=a" (result)
  1c0077:	cd 33                	int    $0x33
  1c0079:	85 c0                	test   %eax,%eax
  1c007b:	78 16                	js     1c0093 <process_main+0x93>
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
  1c007d:	48 8b 05 84 1f 00 00 	mov    0x1f84(%rip),%rax        # 1c2008 <heap_top>
  1c0084:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  1c0086:	48 81 05 77 1f 00 00 	addq   $0x1000,0x1f77(%rip)        # 1c2008 <heap_top>
  1c008d:	00 10 00 00 
  1c0091:	eb af                	jmp    1c0042 <process_main+0x42>
    asm volatile ("int %0" : /* no result */
  1c0093:	cd 32                	int    $0x32
  1c0095:	eb fc                	jmp    1c0093 <process_main+0x93>

00000000001c0097 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1c0097:	f3 0f 1e fa          	endbr64 
  1c009b:	55                   	push   %rbp
  1c009c:	48 89 e5             	mov    %rsp,%rbp
  1c009f:	48 83 ec 28          	sub    $0x28,%rsp
  1c00a3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c00a7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1c00ab:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1c00af:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1c00b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1c00b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c00bb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1c00bf:	eb 1c                	jmp    1c00dd <memcpy+0x46>
        *d = *s;
  1c00c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c00c5:	0f b6 10             	movzbl (%rax),%edx
  1c00c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c00cc:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1c00ce:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1c00d3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1c00d8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1c00dd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1c00e2:	75 dd                	jne    1c00c1 <memcpy+0x2a>
    }
    return dst;
  1c00e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1c00e8:	c9                   	leave  
  1c00e9:	c3                   	ret    

00000000001c00ea <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1c00ea:	f3 0f 1e fa          	endbr64 
  1c00ee:	55                   	push   %rbp
  1c00ef:	48 89 e5             	mov    %rsp,%rbp
  1c00f2:	48 83 ec 28          	sub    $0x28,%rsp
  1c00f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c00fa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1c00fe:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1c0102:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1c0106:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1c010a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c010e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1c0112:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0116:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1c011a:	73 6a                	jae    1c0186 <memmove+0x9c>
  1c011c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1c0120:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c0124:	48 01 d0             	add    %rdx,%rax
  1c0127:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1c012b:	73 59                	jae    1c0186 <memmove+0x9c>
        s += n, d += n;
  1c012d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c0131:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1c0135:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c0139:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1c013d:	eb 17                	jmp    1c0156 <memmove+0x6c>
            *--d = *--s;
  1c013f:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1c0144:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1c0149:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c014d:	0f b6 10             	movzbl (%rax),%edx
  1c0150:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0154:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1c0156:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c015a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1c015e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1c0162:	48 85 c0             	test   %rax,%rax
  1c0165:	75 d8                	jne    1c013f <memmove+0x55>
    if (s < d && s + n > d) {
  1c0167:	eb 2e                	jmp    1c0197 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1c0169:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1c016d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1c0171:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1c0175:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0179:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1c017d:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1c0181:	0f b6 12             	movzbl (%rdx),%edx
  1c0184:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1c0186:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c018a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1c018e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1c0192:	48 85 c0             	test   %rax,%rax
  1c0195:	75 d2                	jne    1c0169 <memmove+0x7f>
        }
    }
    return dst;
  1c0197:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1c019b:	c9                   	leave  
  1c019c:	c3                   	ret    

00000000001c019d <memset>:

void* memset(void* v, int c, size_t n) {
  1c019d:	f3 0f 1e fa          	endbr64 
  1c01a1:	55                   	push   %rbp
  1c01a2:	48 89 e5             	mov    %rsp,%rbp
  1c01a5:	48 83 ec 28          	sub    $0x28,%rsp
  1c01a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c01ad:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1c01b0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1c01b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c01b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1c01bc:	eb 15                	jmp    1c01d3 <memset+0x36>
        *p = c;
  1c01be:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1c01c1:	89 c2                	mov    %eax,%edx
  1c01c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c01c7:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1c01c9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1c01ce:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1c01d3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1c01d8:	75 e4                	jne    1c01be <memset+0x21>
    }
    return v;
  1c01da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1c01de:	c9                   	leave  
  1c01df:	c3                   	ret    

00000000001c01e0 <strlen>:

size_t strlen(const char* s) {
  1c01e0:	f3 0f 1e fa          	endbr64 
  1c01e4:	55                   	push   %rbp
  1c01e5:	48 89 e5             	mov    %rsp,%rbp
  1c01e8:	48 83 ec 18          	sub    $0x18,%rsp
  1c01ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1c01f0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1c01f7:	00 
  1c01f8:	eb 0a                	jmp    1c0204 <strlen+0x24>
        ++n;
  1c01fa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1c01ff:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1c0204:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c0208:	0f b6 00             	movzbl (%rax),%eax
  1c020b:	84 c0                	test   %al,%al
  1c020d:	75 eb                	jne    1c01fa <strlen+0x1a>
    }
    return n;
  1c020f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1c0213:	c9                   	leave  
  1c0214:	c3                   	ret    

00000000001c0215 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1c0215:	f3 0f 1e fa          	endbr64 
  1c0219:	55                   	push   %rbp
  1c021a:	48 89 e5             	mov    %rsp,%rbp
  1c021d:	48 83 ec 20          	sub    $0x20,%rsp
  1c0221:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c0225:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1c0229:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1c0230:	00 
  1c0231:	eb 0a                	jmp    1c023d <strnlen+0x28>
        ++n;
  1c0233:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1c0238:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1c023d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0241:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1c0245:	74 0b                	je     1c0252 <strnlen+0x3d>
  1c0247:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c024b:	0f b6 00             	movzbl (%rax),%eax
  1c024e:	84 c0                	test   %al,%al
  1c0250:	75 e1                	jne    1c0233 <strnlen+0x1e>
    }
    return n;
  1c0252:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1c0256:	c9                   	leave  
  1c0257:	c3                   	ret    

00000000001c0258 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1c0258:	f3 0f 1e fa          	endbr64 
  1c025c:	55                   	push   %rbp
  1c025d:	48 89 e5             	mov    %rsp,%rbp
  1c0260:	48 83 ec 20          	sub    $0x20,%rsp
  1c0264:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c0268:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1c026c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c0270:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1c0274:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1c0278:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1c027c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1c0280:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0284:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1c0288:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1c028c:	0f b6 12             	movzbl (%rdx),%edx
  1c028f:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1c0291:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0295:	48 83 e8 01          	sub    $0x1,%rax
  1c0299:	0f b6 00             	movzbl (%rax),%eax
  1c029c:	84 c0                	test   %al,%al
  1c029e:	75 d4                	jne    1c0274 <strcpy+0x1c>
    return dst;
  1c02a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1c02a4:	c9                   	leave  
  1c02a5:	c3                   	ret    

00000000001c02a6 <strcmp>:

int strcmp(const char* a, const char* b) {
  1c02a6:	f3 0f 1e fa          	endbr64 
  1c02aa:	55                   	push   %rbp
  1c02ab:	48 89 e5             	mov    %rsp,%rbp
  1c02ae:	48 83 ec 10          	sub    $0x10,%rsp
  1c02b2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1c02b6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1c02ba:	eb 0a                	jmp    1c02c6 <strcmp+0x20>
        ++a, ++b;
  1c02bc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1c02c1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1c02c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c02ca:	0f b6 00             	movzbl (%rax),%eax
  1c02cd:	84 c0                	test   %al,%al
  1c02cf:	74 1d                	je     1c02ee <strcmp+0x48>
  1c02d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c02d5:	0f b6 00             	movzbl (%rax),%eax
  1c02d8:	84 c0                	test   %al,%al
  1c02da:	74 12                	je     1c02ee <strcmp+0x48>
  1c02dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c02e0:	0f b6 10             	movzbl (%rax),%edx
  1c02e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c02e7:	0f b6 00             	movzbl (%rax),%eax
  1c02ea:	38 c2                	cmp    %al,%dl
  1c02ec:	74 ce                	je     1c02bc <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1c02ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c02f2:	0f b6 00             	movzbl (%rax),%eax
  1c02f5:	89 c2                	mov    %eax,%edx
  1c02f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c02fb:	0f b6 00             	movzbl (%rax),%eax
  1c02fe:	38 c2                	cmp    %al,%dl
  1c0300:	0f 97 c0             	seta   %al
  1c0303:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1c0306:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c030a:	0f b6 00             	movzbl (%rax),%eax
  1c030d:	89 c1                	mov    %eax,%ecx
  1c030f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0313:	0f b6 00             	movzbl (%rax),%eax
  1c0316:	38 c1                	cmp    %al,%cl
  1c0318:	0f 92 c0             	setb   %al
  1c031b:	0f b6 c8             	movzbl %al,%ecx
  1c031e:	89 d0                	mov    %edx,%eax
  1c0320:	29 c8                	sub    %ecx,%eax
}
  1c0322:	c9                   	leave  
  1c0323:	c3                   	ret    

00000000001c0324 <strchr>:

char* strchr(const char* s, int c) {
  1c0324:	f3 0f 1e fa          	endbr64 
  1c0328:	55                   	push   %rbp
  1c0329:	48 89 e5             	mov    %rsp,%rbp
  1c032c:	48 83 ec 10          	sub    $0x10,%rsp
  1c0330:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1c0334:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1c0337:	eb 05                	jmp    1c033e <strchr+0x1a>
        ++s;
  1c0339:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1c033e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0342:	0f b6 00             	movzbl (%rax),%eax
  1c0345:	84 c0                	test   %al,%al
  1c0347:	74 0e                	je     1c0357 <strchr+0x33>
  1c0349:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c034d:	0f b6 00             	movzbl (%rax),%eax
  1c0350:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1c0353:	38 d0                	cmp    %dl,%al
  1c0355:	75 e2                	jne    1c0339 <strchr+0x15>
    }
    if (*s == (char) c) {
  1c0357:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c035b:	0f b6 00             	movzbl (%rax),%eax
  1c035e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1c0361:	38 d0                	cmp    %dl,%al
  1c0363:	75 06                	jne    1c036b <strchr+0x47>
        return (char*) s;
  1c0365:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0369:	eb 05                	jmp    1c0370 <strchr+0x4c>
    } else {
        return NULL;
  1c036b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1c0370:	c9                   	leave  
  1c0371:	c3                   	ret    

00000000001c0372 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1c0372:	f3 0f 1e fa          	endbr64 
  1c0376:	55                   	push   %rbp
  1c0377:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1c037a:	8b 05 90 1c 00 00    	mov    0x1c90(%rip),%eax        # 1c2010 <rand_seed_set>
  1c0380:	85 c0                	test   %eax,%eax
  1c0382:	75 0a                	jne    1c038e <rand+0x1c>
        srand(819234718U);
  1c0384:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1c0389:	e8 24 00 00 00       	call   1c03b2 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1c038e:	8b 05 80 1c 00 00    	mov    0x1c80(%rip),%eax        # 1c2014 <rand_seed>
  1c0394:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1c039a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1c039f:	89 05 6f 1c 00 00    	mov    %eax,0x1c6f(%rip)        # 1c2014 <rand_seed>
    return rand_seed & RAND_MAX;
  1c03a5:	8b 05 69 1c 00 00    	mov    0x1c69(%rip),%eax        # 1c2014 <rand_seed>
  1c03ab:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1c03b0:	5d                   	pop    %rbp
  1c03b1:	c3                   	ret    

00000000001c03b2 <srand>:

void srand(unsigned seed) {
  1c03b2:	f3 0f 1e fa          	endbr64 
  1c03b6:	55                   	push   %rbp
  1c03b7:	48 89 e5             	mov    %rsp,%rbp
  1c03ba:	48 83 ec 08          	sub    $0x8,%rsp
  1c03be:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1c03c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1c03c4:	89 05 4a 1c 00 00    	mov    %eax,0x1c4a(%rip)        # 1c2014 <rand_seed>
    rand_seed_set = 1;
  1c03ca:	c7 05 3c 1c 00 00 01 	movl   $0x1,0x1c3c(%rip)        # 1c2010 <rand_seed_set>
  1c03d1:	00 00 00 
}
  1c03d4:	90                   	nop
  1c03d5:	c9                   	leave  
  1c03d6:	c3                   	ret    

00000000001c03d7 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1c03d7:	f3 0f 1e fa          	endbr64 
  1c03db:	55                   	push   %rbp
  1c03dc:	48 89 e5             	mov    %rsp,%rbp
  1c03df:	48 83 ec 28          	sub    $0x28,%rsp
  1c03e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c03e7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1c03eb:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1c03ee:	48 8d 05 ab 0e 00 00 	lea    0xeab(%rip),%rax        # 1c12a0 <upper_digits.1>
  1c03f5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  1c03f9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1c03fd:	79 0e                	jns    1c040d <fill_numbuf+0x36>
        digits = lower_digits;
  1c03ff:	48 8d 05 ba 0e 00 00 	lea    0xeba(%rip),%rax        # 1c12c0 <lower_digits.0>
  1c0406:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  1c040a:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1c040d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1c0412:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c0416:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1c0419:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1c041c:	48 63 c8             	movslq %eax,%rcx
  1c041f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1c0423:	ba 00 00 00 00       	mov    $0x0,%edx
  1c0428:	48 f7 f1             	div    %rcx
  1c042b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c042f:	48 01 d0             	add    %rdx,%rax
  1c0432:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1c0437:	0f b6 10             	movzbl (%rax),%edx
  1c043a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c043e:	88 10                	mov    %dl,(%rax)
        val /= base;
  1c0440:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1c0443:	48 63 f0             	movslq %eax,%rsi
  1c0446:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1c044a:	ba 00 00 00 00       	mov    $0x0,%edx
  1c044f:	48 f7 f6             	div    %rsi
  1c0452:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1c0456:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1c045b:	75 bc                	jne    1c0419 <fill_numbuf+0x42>
    return numbuf_end;
  1c045d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1c0461:	c9                   	leave  
  1c0462:	c3                   	ret    

00000000001c0463 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1c0463:	f3 0f 1e fa          	endbr64 
  1c0467:	55                   	push   %rbp
  1c0468:	48 89 e5             	mov    %rsp,%rbp
  1c046b:	53                   	push   %rbx
  1c046c:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1c0473:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1c047a:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1c0480:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1c0487:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1c048e:	e9 bd 09 00 00       	jmp    1c0e50 <printer_vprintf+0x9ed>
        if (*format != '%') {
  1c0493:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c049a:	0f b6 00             	movzbl (%rax),%eax
  1c049d:	3c 25                	cmp    $0x25,%al
  1c049f:	74 31                	je     1c04d2 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  1c04a1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c04a8:	4c 8b 00             	mov    (%rax),%r8
  1c04ab:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c04b2:	0f b6 00             	movzbl (%rax),%eax
  1c04b5:	0f b6 c8             	movzbl %al,%ecx
  1c04b8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c04be:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c04c5:	89 ce                	mov    %ecx,%esi
  1c04c7:	48 89 c7             	mov    %rax,%rdi
  1c04ca:	41 ff d0             	call   *%r8
            continue;
  1c04cd:	e9 76 09 00 00       	jmp    1c0e48 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  1c04d2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1c04d9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c04e0:	01 
  1c04e1:	eb 4d                	jmp    1c0530 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  1c04e3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c04ea:	0f b6 00             	movzbl (%rax),%eax
  1c04ed:	0f be c0             	movsbl %al,%eax
  1c04f0:	89 c6                	mov    %eax,%esi
  1c04f2:	48 8d 05 a7 0c 00 00 	lea    0xca7(%rip),%rax        # 1c11a0 <flag_chars>
  1c04f9:	48 89 c7             	mov    %rax,%rdi
  1c04fc:	e8 23 fe ff ff       	call   1c0324 <strchr>
  1c0501:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1c0505:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1c050a:	74 34                	je     1c0540 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  1c050c:	48 8d 15 8d 0c 00 00 	lea    0xc8d(%rip),%rdx        # 1c11a0 <flag_chars>
  1c0513:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1c0517:	48 29 d0             	sub    %rdx,%rax
  1c051a:	ba 01 00 00 00       	mov    $0x1,%edx
  1c051f:	89 c1                	mov    %eax,%ecx
  1c0521:	d3 e2                	shl    %cl,%edx
  1c0523:	89 d0                	mov    %edx,%eax
  1c0525:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1c0528:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c052f:	01 
  1c0530:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0537:	0f b6 00             	movzbl (%rax),%eax
  1c053a:	84 c0                	test   %al,%al
  1c053c:	75 a5                	jne    1c04e3 <printer_vprintf+0x80>
  1c053e:	eb 01                	jmp    1c0541 <printer_vprintf+0xde>
            } else {
                break;
  1c0540:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1c0541:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1c0548:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c054f:	0f b6 00             	movzbl (%rax),%eax
  1c0552:	3c 30                	cmp    $0x30,%al
  1c0554:	7e 67                	jle    1c05bd <printer_vprintf+0x15a>
  1c0556:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c055d:	0f b6 00             	movzbl (%rax),%eax
  1c0560:	3c 39                	cmp    $0x39,%al
  1c0562:	7f 59                	jg     1c05bd <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1c0564:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1c056b:	eb 2e                	jmp    1c059b <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  1c056d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1c0570:	89 d0                	mov    %edx,%eax
  1c0572:	c1 e0 02             	shl    $0x2,%eax
  1c0575:	01 d0                	add    %edx,%eax
  1c0577:	01 c0                	add    %eax,%eax
  1c0579:	89 c1                	mov    %eax,%ecx
  1c057b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0582:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1c0586:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1c058d:	0f b6 00             	movzbl (%rax),%eax
  1c0590:	0f be c0             	movsbl %al,%eax
  1c0593:	01 c8                	add    %ecx,%eax
  1c0595:	83 e8 30             	sub    $0x30,%eax
  1c0598:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1c059b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c05a2:	0f b6 00             	movzbl (%rax),%eax
  1c05a5:	3c 2f                	cmp    $0x2f,%al
  1c05a7:	0f 8e 85 00 00 00    	jle    1c0632 <printer_vprintf+0x1cf>
  1c05ad:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c05b4:	0f b6 00             	movzbl (%rax),%eax
  1c05b7:	3c 39                	cmp    $0x39,%al
  1c05b9:	7e b2                	jle    1c056d <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  1c05bb:	eb 75                	jmp    1c0632 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  1c05bd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c05c4:	0f b6 00             	movzbl (%rax),%eax
  1c05c7:	3c 2a                	cmp    $0x2a,%al
  1c05c9:	75 68                	jne    1c0633 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  1c05cb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c05d2:	8b 00                	mov    (%rax),%eax
  1c05d4:	83 f8 2f             	cmp    $0x2f,%eax
  1c05d7:	77 30                	ja     1c0609 <printer_vprintf+0x1a6>
  1c05d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c05e0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c05e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c05eb:	8b 00                	mov    (%rax),%eax
  1c05ed:	89 c0                	mov    %eax,%eax
  1c05ef:	48 01 d0             	add    %rdx,%rax
  1c05f2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c05f9:	8b 12                	mov    (%rdx),%edx
  1c05fb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c05fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0605:	89 0a                	mov    %ecx,(%rdx)
  1c0607:	eb 1a                	jmp    1c0623 <printer_vprintf+0x1c0>
  1c0609:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0610:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0614:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0618:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c061f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0623:	8b 00                	mov    (%rax),%eax
  1c0625:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1c0628:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c062f:	01 
  1c0630:	eb 01                	jmp    1c0633 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  1c0632:	90                   	nop
        }

        // process precision
        int precision = -1;
  1c0633:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1c063a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0641:	0f b6 00             	movzbl (%rax),%eax
  1c0644:	3c 2e                	cmp    $0x2e,%al
  1c0646:	0f 85 00 01 00 00    	jne    1c074c <printer_vprintf+0x2e9>
            ++format;
  1c064c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c0653:	01 
            if (*format >= '0' && *format <= '9') {
  1c0654:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c065b:	0f b6 00             	movzbl (%rax),%eax
  1c065e:	3c 2f                	cmp    $0x2f,%al
  1c0660:	7e 67                	jle    1c06c9 <printer_vprintf+0x266>
  1c0662:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0669:	0f b6 00             	movzbl (%rax),%eax
  1c066c:	3c 39                	cmp    $0x39,%al
  1c066e:	7f 59                	jg     1c06c9 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1c0670:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1c0677:	eb 2e                	jmp    1c06a7 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  1c0679:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1c067c:	89 d0                	mov    %edx,%eax
  1c067e:	c1 e0 02             	shl    $0x2,%eax
  1c0681:	01 d0                	add    %edx,%eax
  1c0683:	01 c0                	add    %eax,%eax
  1c0685:	89 c1                	mov    %eax,%ecx
  1c0687:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c068e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1c0692:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1c0699:	0f b6 00             	movzbl (%rax),%eax
  1c069c:	0f be c0             	movsbl %al,%eax
  1c069f:	01 c8                	add    %ecx,%eax
  1c06a1:	83 e8 30             	sub    $0x30,%eax
  1c06a4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1c06a7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c06ae:	0f b6 00             	movzbl (%rax),%eax
  1c06b1:	3c 2f                	cmp    $0x2f,%al
  1c06b3:	0f 8e 85 00 00 00    	jle    1c073e <printer_vprintf+0x2db>
  1c06b9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c06c0:	0f b6 00             	movzbl (%rax),%eax
  1c06c3:	3c 39                	cmp    $0x39,%al
  1c06c5:	7e b2                	jle    1c0679 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  1c06c7:	eb 75                	jmp    1c073e <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  1c06c9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c06d0:	0f b6 00             	movzbl (%rax),%eax
  1c06d3:	3c 2a                	cmp    $0x2a,%al
  1c06d5:	75 68                	jne    1c073f <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  1c06d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c06de:	8b 00                	mov    (%rax),%eax
  1c06e0:	83 f8 2f             	cmp    $0x2f,%eax
  1c06e3:	77 30                	ja     1c0715 <printer_vprintf+0x2b2>
  1c06e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c06ec:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c06f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c06f7:	8b 00                	mov    (%rax),%eax
  1c06f9:	89 c0                	mov    %eax,%eax
  1c06fb:	48 01 d0             	add    %rdx,%rax
  1c06fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0705:	8b 12                	mov    (%rdx),%edx
  1c0707:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c070a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0711:	89 0a                	mov    %ecx,(%rdx)
  1c0713:	eb 1a                	jmp    1c072f <printer_vprintf+0x2cc>
  1c0715:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c071c:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0720:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0724:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c072b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c072f:	8b 00                	mov    (%rax),%eax
  1c0731:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1c0734:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c073b:	01 
  1c073c:	eb 01                	jmp    1c073f <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  1c073e:	90                   	nop
            }
            if (precision < 0) {
  1c073f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1c0743:	79 07                	jns    1c074c <printer_vprintf+0x2e9>
                precision = 0;
  1c0745:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  1c074c:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  1c0753:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  1c075a:	00 
        int length = 0;
  1c075b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  1c0762:	48 8d 05 3d 0a 00 00 	lea    0xa3d(%rip),%rax        # 1c11a6 <flag_chars+0x6>
  1c0769:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  1c076d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0774:	0f b6 00             	movzbl (%rax),%eax
  1c0777:	0f be c0             	movsbl %al,%eax
  1c077a:	83 e8 43             	sub    $0x43,%eax
  1c077d:	83 f8 37             	cmp    $0x37,%eax
  1c0780:	0f 87 b6 03 00 00    	ja     1c0b3c <printer_vprintf+0x6d9>
  1c0786:	89 c0                	mov    %eax,%eax
  1c0788:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  1c078f:	00 
  1c0790:	48 8d 05 1d 0a 00 00 	lea    0xa1d(%rip),%rax        # 1c11b4 <flag_chars+0x14>
  1c0797:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  1c079a:	48 98                	cltq   
  1c079c:	48 8d 15 11 0a 00 00 	lea    0xa11(%rip),%rdx        # 1c11b4 <flag_chars+0x14>
  1c07a3:	48 01 d0             	add    %rdx,%rax
  1c07a6:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  1c07a9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1c07b0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c07b7:	01 
            goto again;
  1c07b8:	eb b3                	jmp    1c076d <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1c07ba:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1c07be:	74 5d                	je     1c081d <printer_vprintf+0x3ba>
  1c07c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c07c7:	8b 00                	mov    (%rax),%eax
  1c07c9:	83 f8 2f             	cmp    $0x2f,%eax
  1c07cc:	77 30                	ja     1c07fe <printer_vprintf+0x39b>
  1c07ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c07d5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c07d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c07e0:	8b 00                	mov    (%rax),%eax
  1c07e2:	89 c0                	mov    %eax,%eax
  1c07e4:	48 01 d0             	add    %rdx,%rax
  1c07e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c07ee:	8b 12                	mov    (%rdx),%edx
  1c07f0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c07f3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c07fa:	89 0a                	mov    %ecx,(%rdx)
  1c07fc:	eb 1a                	jmp    1c0818 <printer_vprintf+0x3b5>
  1c07fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0805:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0809:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c080d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0814:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0818:	48 8b 00             	mov    (%rax),%rax
  1c081b:	eb 5c                	jmp    1c0879 <printer_vprintf+0x416>
  1c081d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0824:	8b 00                	mov    (%rax),%eax
  1c0826:	83 f8 2f             	cmp    $0x2f,%eax
  1c0829:	77 30                	ja     1c085b <printer_vprintf+0x3f8>
  1c082b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0832:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0836:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c083d:	8b 00                	mov    (%rax),%eax
  1c083f:	89 c0                	mov    %eax,%eax
  1c0841:	48 01 d0             	add    %rdx,%rax
  1c0844:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c084b:	8b 12                	mov    (%rdx),%edx
  1c084d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c0850:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0857:	89 0a                	mov    %ecx,(%rdx)
  1c0859:	eb 1a                	jmp    1c0875 <printer_vprintf+0x412>
  1c085b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0862:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0866:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c086a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0871:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0875:	8b 00                	mov    (%rax),%eax
  1c0877:	48 98                	cltq   
  1c0879:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1c087d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1c0881:	48 c1 f8 38          	sar    $0x38,%rax
  1c0885:	25 80 00 00 00       	and    $0x80,%eax
  1c088a:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  1c088d:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  1c0891:	74 09                	je     1c089c <printer_vprintf+0x439>
  1c0893:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1c0897:	48 f7 d8             	neg    %rax
  1c089a:	eb 04                	jmp    1c08a0 <printer_vprintf+0x43d>
  1c089c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1c08a0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1c08a4:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  1c08a7:	83 c8 60             	or     $0x60,%eax
  1c08aa:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  1c08ad:	e9 cf 02 00 00       	jmp    1c0b81 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1c08b2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1c08b6:	74 5d                	je     1c0915 <printer_vprintf+0x4b2>
  1c08b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c08bf:	8b 00                	mov    (%rax),%eax
  1c08c1:	83 f8 2f             	cmp    $0x2f,%eax
  1c08c4:	77 30                	ja     1c08f6 <printer_vprintf+0x493>
  1c08c6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c08cd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c08d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c08d8:	8b 00                	mov    (%rax),%eax
  1c08da:	89 c0                	mov    %eax,%eax
  1c08dc:	48 01 d0             	add    %rdx,%rax
  1c08df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c08e6:	8b 12                	mov    (%rdx),%edx
  1c08e8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c08eb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c08f2:	89 0a                	mov    %ecx,(%rdx)
  1c08f4:	eb 1a                	jmp    1c0910 <printer_vprintf+0x4ad>
  1c08f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c08fd:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0901:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0905:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c090c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0910:	48 8b 00             	mov    (%rax),%rax
  1c0913:	eb 5c                	jmp    1c0971 <printer_vprintf+0x50e>
  1c0915:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c091c:	8b 00                	mov    (%rax),%eax
  1c091e:	83 f8 2f             	cmp    $0x2f,%eax
  1c0921:	77 30                	ja     1c0953 <printer_vprintf+0x4f0>
  1c0923:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c092a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c092e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0935:	8b 00                	mov    (%rax),%eax
  1c0937:	89 c0                	mov    %eax,%eax
  1c0939:	48 01 d0             	add    %rdx,%rax
  1c093c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0943:	8b 12                	mov    (%rdx),%edx
  1c0945:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c0948:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c094f:	89 0a                	mov    %ecx,(%rdx)
  1c0951:	eb 1a                	jmp    1c096d <printer_vprintf+0x50a>
  1c0953:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c095a:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c095e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0962:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0969:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c096d:	8b 00                	mov    (%rax),%eax
  1c096f:	89 c0                	mov    %eax,%eax
  1c0971:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  1c0975:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  1c0979:	e9 03 02 00 00       	jmp    1c0b81 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  1c097e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  1c0985:	e9 28 ff ff ff       	jmp    1c08b2 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  1c098a:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  1c0991:	e9 1c ff ff ff       	jmp    1c08b2 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  1c0996:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c099d:	8b 00                	mov    (%rax),%eax
  1c099f:	83 f8 2f             	cmp    $0x2f,%eax
  1c09a2:	77 30                	ja     1c09d4 <printer_vprintf+0x571>
  1c09a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c09ab:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c09af:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c09b6:	8b 00                	mov    (%rax),%eax
  1c09b8:	89 c0                	mov    %eax,%eax
  1c09ba:	48 01 d0             	add    %rdx,%rax
  1c09bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c09c4:	8b 12                	mov    (%rdx),%edx
  1c09c6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c09c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c09d0:	89 0a                	mov    %ecx,(%rdx)
  1c09d2:	eb 1a                	jmp    1c09ee <printer_vprintf+0x58b>
  1c09d4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c09db:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c09df:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c09e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c09ea:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c09ee:	48 8b 00             	mov    (%rax),%rax
  1c09f1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1c09f5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1c09fc:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  1c0a03:	e9 79 01 00 00       	jmp    1c0b81 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  1c0a08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0a0f:	8b 00                	mov    (%rax),%eax
  1c0a11:	83 f8 2f             	cmp    $0x2f,%eax
  1c0a14:	77 30                	ja     1c0a46 <printer_vprintf+0x5e3>
  1c0a16:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0a1d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0a21:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0a28:	8b 00                	mov    (%rax),%eax
  1c0a2a:	89 c0                	mov    %eax,%eax
  1c0a2c:	48 01 d0             	add    %rdx,%rax
  1c0a2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0a36:	8b 12                	mov    (%rdx),%edx
  1c0a38:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c0a3b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0a42:	89 0a                	mov    %ecx,(%rdx)
  1c0a44:	eb 1a                	jmp    1c0a60 <printer_vprintf+0x5fd>
  1c0a46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0a4d:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0a51:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0a55:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0a5c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0a60:	48 8b 00             	mov    (%rax),%rax
  1c0a63:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  1c0a67:	e9 15 01 00 00       	jmp    1c0b81 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  1c0a6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0a73:	8b 00                	mov    (%rax),%eax
  1c0a75:	83 f8 2f             	cmp    $0x2f,%eax
  1c0a78:	77 30                	ja     1c0aaa <printer_vprintf+0x647>
  1c0a7a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0a81:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0a85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0a8c:	8b 00                	mov    (%rax),%eax
  1c0a8e:	89 c0                	mov    %eax,%eax
  1c0a90:	48 01 d0             	add    %rdx,%rax
  1c0a93:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0a9a:	8b 12                	mov    (%rdx),%edx
  1c0a9c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c0a9f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0aa6:	89 0a                	mov    %ecx,(%rdx)
  1c0aa8:	eb 1a                	jmp    1c0ac4 <printer_vprintf+0x661>
  1c0aaa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0ab1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0ab5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0ab9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0ac0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0ac4:	8b 00                	mov    (%rax),%eax
  1c0ac6:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  1c0acc:	e9 77 03 00 00       	jmp    1c0e48 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  1c0ad1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1c0ad5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  1c0ad9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0ae0:	8b 00                	mov    (%rax),%eax
  1c0ae2:	83 f8 2f             	cmp    $0x2f,%eax
  1c0ae5:	77 30                	ja     1c0b17 <printer_vprintf+0x6b4>
  1c0ae7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0aee:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0af2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0af9:	8b 00                	mov    (%rax),%eax
  1c0afb:	89 c0                	mov    %eax,%eax
  1c0afd:	48 01 d0             	add    %rdx,%rax
  1c0b00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0b07:	8b 12                	mov    (%rdx),%edx
  1c0b09:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c0b0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0b13:	89 0a                	mov    %ecx,(%rdx)
  1c0b15:	eb 1a                	jmp    1c0b31 <printer_vprintf+0x6ce>
  1c0b17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0b1e:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0b22:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0b26:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0b2d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0b31:	8b 00                	mov    (%rax),%eax
  1c0b33:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1c0b36:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  1c0b3a:	eb 45                	jmp    1c0b81 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  1c0b3c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1c0b40:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  1c0b44:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0b4b:	0f b6 00             	movzbl (%rax),%eax
  1c0b4e:	84 c0                	test   %al,%al
  1c0b50:	74 0c                	je     1c0b5e <printer_vprintf+0x6fb>
  1c0b52:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0b59:	0f b6 00             	movzbl (%rax),%eax
  1c0b5c:	eb 05                	jmp    1c0b63 <printer_vprintf+0x700>
  1c0b5e:	b8 25 00 00 00       	mov    $0x25,%eax
  1c0b63:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1c0b66:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  1c0b6a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0b71:	0f b6 00             	movzbl (%rax),%eax
  1c0b74:	84 c0                	test   %al,%al
  1c0b76:	75 08                	jne    1c0b80 <printer_vprintf+0x71d>
                format--;
  1c0b78:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  1c0b7f:	01 
            }
            break;
  1c0b80:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  1c0b81:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0b84:	83 e0 20             	and    $0x20,%eax
  1c0b87:	85 c0                	test   %eax,%eax
  1c0b89:	74 1e                	je     1c0ba9 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  1c0b8b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1c0b8f:	48 83 c0 18          	add    $0x18,%rax
  1c0b93:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1c0b96:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1c0b9a:	48 89 ce             	mov    %rcx,%rsi
  1c0b9d:	48 89 c7             	mov    %rax,%rdi
  1c0ba0:	e8 32 f8 ff ff       	call   1c03d7 <fill_numbuf>
  1c0ba5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  1c0ba9:	48 8d 05 f6 05 00 00 	lea    0x5f6(%rip),%rax        # 1c11a6 <flag_chars+0x6>
  1c0bb0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1c0bb4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0bb7:	83 e0 20             	and    $0x20,%eax
  1c0bba:	85 c0                	test   %eax,%eax
  1c0bbc:	74 51                	je     1c0c0f <printer_vprintf+0x7ac>
  1c0bbe:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0bc1:	83 e0 40             	and    $0x40,%eax
  1c0bc4:	85 c0                	test   %eax,%eax
  1c0bc6:	74 47                	je     1c0c0f <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  1c0bc8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0bcb:	25 80 00 00 00       	and    $0x80,%eax
  1c0bd0:	85 c0                	test   %eax,%eax
  1c0bd2:	74 0d                	je     1c0be1 <printer_vprintf+0x77e>
                prefix = "-";
  1c0bd4:	48 8d 05 cc 05 00 00 	lea    0x5cc(%rip),%rax        # 1c11a7 <flag_chars+0x7>
  1c0bdb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1c0bdf:	eb 7d                	jmp    1c0c5e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1c0be1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0be4:	83 e0 10             	and    $0x10,%eax
  1c0be7:	85 c0                	test   %eax,%eax
  1c0be9:	74 0d                	je     1c0bf8 <printer_vprintf+0x795>
                prefix = "+";
  1c0beb:	48 8d 05 b7 05 00 00 	lea    0x5b7(%rip),%rax        # 1c11a9 <flag_chars+0x9>
  1c0bf2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1c0bf6:	eb 66                	jmp    1c0c5e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  1c0bf8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0bfb:	83 e0 08             	and    $0x8,%eax
  1c0bfe:	85 c0                	test   %eax,%eax
  1c0c00:	74 5c                	je     1c0c5e <printer_vprintf+0x7fb>
                prefix = " ";
  1c0c02:	48 8d 05 a2 05 00 00 	lea    0x5a2(%rip),%rax        # 1c11ab <flag_chars+0xb>
  1c0c09:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1c0c0d:	eb 4f                	jmp    1c0c5e <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1c0c0f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0c12:	83 e0 20             	and    $0x20,%eax
  1c0c15:	85 c0                	test   %eax,%eax
  1c0c17:	74 46                	je     1c0c5f <printer_vprintf+0x7fc>
  1c0c19:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0c1c:	83 e0 01             	and    $0x1,%eax
  1c0c1f:	85 c0                	test   %eax,%eax
  1c0c21:	74 3c                	je     1c0c5f <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  1c0c23:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1c0c27:	74 06                	je     1c0c2f <printer_vprintf+0x7cc>
  1c0c29:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1c0c2d:	75 30                	jne    1c0c5f <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  1c0c2f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1c0c34:	75 0c                	jne    1c0c42 <printer_vprintf+0x7df>
  1c0c36:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0c39:	25 00 01 00 00       	and    $0x100,%eax
  1c0c3e:	85 c0                	test   %eax,%eax
  1c0c40:	74 1d                	je     1c0c5f <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  1c0c42:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1c0c46:	75 09                	jne    1c0c51 <printer_vprintf+0x7ee>
  1c0c48:	48 8d 05 5e 05 00 00 	lea    0x55e(%rip),%rax        # 1c11ad <flag_chars+0xd>
  1c0c4f:	eb 07                	jmp    1c0c58 <printer_vprintf+0x7f5>
  1c0c51:	48 8d 05 58 05 00 00 	lea    0x558(%rip),%rax        # 1c11b0 <flag_chars+0x10>
  1c0c58:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1c0c5c:	eb 01                	jmp    1c0c5f <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  1c0c5e:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1c0c5f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1c0c63:	78 24                	js     1c0c89 <printer_vprintf+0x826>
  1c0c65:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0c68:	83 e0 20             	and    $0x20,%eax
  1c0c6b:	85 c0                	test   %eax,%eax
  1c0c6d:	75 1a                	jne    1c0c89 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  1c0c6f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1c0c72:	48 63 d0             	movslq %eax,%rdx
  1c0c75:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1c0c79:	48 89 d6             	mov    %rdx,%rsi
  1c0c7c:	48 89 c7             	mov    %rax,%rdi
  1c0c7f:	e8 91 f5 ff ff       	call   1c0215 <strnlen>
  1c0c84:	89 45 bc             	mov    %eax,-0x44(%rbp)
  1c0c87:	eb 0f                	jmp    1c0c98 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  1c0c89:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1c0c8d:	48 89 c7             	mov    %rax,%rdi
  1c0c90:	e8 4b f5 ff ff       	call   1c01e0 <strlen>
  1c0c95:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1c0c98:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0c9b:	83 e0 20             	and    $0x20,%eax
  1c0c9e:	85 c0                	test   %eax,%eax
  1c0ca0:	74 20                	je     1c0cc2 <printer_vprintf+0x85f>
  1c0ca2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1c0ca6:	78 1a                	js     1c0cc2 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  1c0ca8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1c0cab:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  1c0cae:	7e 08                	jle    1c0cb8 <printer_vprintf+0x855>
  1c0cb0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1c0cb3:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1c0cb6:	eb 05                	jmp    1c0cbd <printer_vprintf+0x85a>
  1c0cb8:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0cbd:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1c0cc0:	eb 5c                	jmp    1c0d1e <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1c0cc2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0cc5:	83 e0 20             	and    $0x20,%eax
  1c0cc8:	85 c0                	test   %eax,%eax
  1c0cca:	74 4b                	je     1c0d17 <printer_vprintf+0x8b4>
  1c0ccc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0ccf:	83 e0 02             	and    $0x2,%eax
  1c0cd2:	85 c0                	test   %eax,%eax
  1c0cd4:	74 41                	je     1c0d17 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1c0cd6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0cd9:	83 e0 04             	and    $0x4,%eax
  1c0cdc:	85 c0                	test   %eax,%eax
  1c0cde:	75 37                	jne    1c0d17 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  1c0ce0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1c0ce4:	48 89 c7             	mov    %rax,%rdi
  1c0ce7:	e8 f4 f4 ff ff       	call   1c01e0 <strlen>
  1c0cec:	89 c2                	mov    %eax,%edx
  1c0cee:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1c0cf1:	01 d0                	add    %edx,%eax
  1c0cf3:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  1c0cf6:	7e 1f                	jle    1c0d17 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  1c0cf8:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1c0cfb:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1c0cfe:	89 c3                	mov    %eax,%ebx
  1c0d00:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1c0d04:	48 89 c7             	mov    %rax,%rdi
  1c0d07:	e8 d4 f4 ff ff       	call   1c01e0 <strlen>
  1c0d0c:	89 c2                	mov    %eax,%edx
  1c0d0e:	89 d8                	mov    %ebx,%eax
  1c0d10:	29 d0                	sub    %edx,%eax
  1c0d12:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1c0d15:	eb 07                	jmp    1c0d1e <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  1c0d17:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  1c0d1e:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1c0d21:	8b 45 b8             	mov    -0x48(%rbp),%eax
  1c0d24:	01 d0                	add    %edx,%eax
  1c0d26:	48 63 d8             	movslq %eax,%rbx
  1c0d29:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1c0d2d:	48 89 c7             	mov    %rax,%rdi
  1c0d30:	e8 ab f4 ff ff       	call   1c01e0 <strlen>
  1c0d35:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1c0d39:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1c0d3c:	29 d0                	sub    %edx,%eax
  1c0d3e:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1c0d41:	eb 25                	jmp    1c0d68 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  1c0d43:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0d4a:	48 8b 08             	mov    (%rax),%rcx
  1c0d4d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c0d53:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0d5a:	be 20 00 00 00       	mov    $0x20,%esi
  1c0d5f:	48 89 c7             	mov    %rax,%rdi
  1c0d62:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1c0d64:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1c0d68:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0d6b:	83 e0 04             	and    $0x4,%eax
  1c0d6e:	85 c0                	test   %eax,%eax
  1c0d70:	75 36                	jne    1c0da8 <printer_vprintf+0x945>
  1c0d72:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1c0d76:	7f cb                	jg     1c0d43 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  1c0d78:	eb 2e                	jmp    1c0da8 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  1c0d7a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0d81:	4c 8b 00             	mov    (%rax),%r8
  1c0d84:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1c0d88:	0f b6 00             	movzbl (%rax),%eax
  1c0d8b:	0f b6 c8             	movzbl %al,%ecx
  1c0d8e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c0d94:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0d9b:	89 ce                	mov    %ecx,%esi
  1c0d9d:	48 89 c7             	mov    %rax,%rdi
  1c0da0:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1c0da3:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1c0da8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1c0dac:	0f b6 00             	movzbl (%rax),%eax
  1c0daf:	84 c0                	test   %al,%al
  1c0db1:	75 c7                	jne    1c0d7a <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  1c0db3:	eb 25                	jmp    1c0dda <printer_vprintf+0x977>
            p->putc(p, '0', color);
  1c0db5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0dbc:	48 8b 08             	mov    (%rax),%rcx
  1c0dbf:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c0dc5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0dcc:	be 30 00 00 00       	mov    $0x30,%esi
  1c0dd1:	48 89 c7             	mov    %rax,%rdi
  1c0dd4:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1c0dd6:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1c0dda:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1c0dde:	7f d5                	jg     1c0db5 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  1c0de0:	eb 32                	jmp    1c0e14 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  1c0de2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0de9:	4c 8b 00             	mov    (%rax),%r8
  1c0dec:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1c0df0:	0f b6 00             	movzbl (%rax),%eax
  1c0df3:	0f b6 c8             	movzbl %al,%ecx
  1c0df6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c0dfc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0e03:	89 ce                	mov    %ecx,%esi
  1c0e05:	48 89 c7             	mov    %rax,%rdi
  1c0e08:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  1c0e0b:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  1c0e10:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  1c0e14:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  1c0e18:	7f c8                	jg     1c0de2 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  1c0e1a:	eb 25                	jmp    1c0e41 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  1c0e1c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0e23:	48 8b 08             	mov    (%rax),%rcx
  1c0e26:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c0e2c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0e33:	be 20 00 00 00       	mov    $0x20,%esi
  1c0e38:	48 89 c7             	mov    %rax,%rdi
  1c0e3b:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1c0e3d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1c0e41:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1c0e45:	7f d5                	jg     1c0e1c <printer_vprintf+0x9b9>
        }
    done: ;
  1c0e47:	90                   	nop
    for (; *format; ++format) {
  1c0e48:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c0e4f:	01 
  1c0e50:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0e57:	0f b6 00             	movzbl (%rax),%eax
  1c0e5a:	84 c0                	test   %al,%al
  1c0e5c:	0f 85 31 f6 ff ff    	jne    1c0493 <printer_vprintf+0x30>
    }
}
  1c0e62:	90                   	nop
  1c0e63:	90                   	nop
  1c0e64:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1c0e68:	c9                   	leave  
  1c0e69:	c3                   	ret    

00000000001c0e6a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1c0e6a:	f3 0f 1e fa          	endbr64 
  1c0e6e:	55                   	push   %rbp
  1c0e6f:	48 89 e5             	mov    %rsp,%rbp
  1c0e72:	48 83 ec 20          	sub    $0x20,%rsp
  1c0e76:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c0e7a:	89 f0                	mov    %esi,%eax
  1c0e7c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1c0e7f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1c0e82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c0e86:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1c0e8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0e8e:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0e92:	48 8d 15 07 81 ef ff 	lea    -0x107ef9(%rip),%rdx        # b8fa0 <console+0xfa0>
  1c0e99:	48 39 d0             	cmp    %rdx,%rax
  1c0e9c:	72 0f                	jb     1c0ead <console_putc+0x43>
        cp->cursor = console;
  1c0e9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0ea2:	48 8d 15 57 71 ef ff 	lea    -0x108ea9(%rip),%rdx        # b8000 <console>
  1c0ea9:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  1c0ead:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1c0eb1:	0f 85 82 00 00 00    	jne    1c0f39 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  1c0eb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0ebb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0ebf:	48 8d 15 3a 71 ef ff 	lea    -0x108ec6(%rip),%rdx        # b8000 <console>
  1c0ec6:	48 29 d0             	sub    %rdx,%rax
  1c0ec9:	48 d1 f8             	sar    %rax
  1c0ecc:	48 89 c1             	mov    %rax,%rcx
  1c0ecf:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1c0ed6:	66 66 66 
  1c0ed9:	48 89 c8             	mov    %rcx,%rax
  1c0edc:	48 f7 ea             	imul   %rdx
  1c0edf:	48 89 d0             	mov    %rdx,%rax
  1c0ee2:	48 c1 f8 05          	sar    $0x5,%rax
  1c0ee6:	48 89 ce             	mov    %rcx,%rsi
  1c0ee9:	48 c1 fe 3f          	sar    $0x3f,%rsi
  1c0eed:	48 29 f0             	sub    %rsi,%rax
  1c0ef0:	48 89 c2             	mov    %rax,%rdx
  1c0ef3:	48 89 d0             	mov    %rdx,%rax
  1c0ef6:	48 c1 e0 02          	shl    $0x2,%rax
  1c0efa:	48 01 d0             	add    %rdx,%rax
  1c0efd:	48 c1 e0 04          	shl    $0x4,%rax
  1c0f01:	48 29 c1             	sub    %rax,%rcx
  1c0f04:	48 89 ca             	mov    %rcx,%rdx
  1c0f07:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1c0f0a:	eb 25                	jmp    1c0f31 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  1c0f0c:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1c0f0f:	83 c8 20             	or     $0x20,%eax
  1c0f12:	89 c6                	mov    %eax,%esi
  1c0f14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0f18:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0f1c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1c0f20:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1c0f24:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0f28:	89 f2                	mov    %esi,%edx
  1c0f2a:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1c0f2d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1c0f31:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1c0f35:	75 d5                	jne    1c0f0c <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1c0f37:	eb 24                	jmp    1c0f5d <console_putc+0xf3>
        *cp->cursor++ = c | color;
  1c0f39:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1c0f3d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1c0f40:	89 d6                	mov    %edx,%esi
  1c0f42:	09 c6                	or     %eax,%esi
  1c0f44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0f48:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0f4c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1c0f50:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1c0f54:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0f58:	89 f2                	mov    %esi,%edx
  1c0f5a:	66 89 10             	mov    %dx,(%rax)
}
  1c0f5d:	90                   	nop
  1c0f5e:	c9                   	leave  
  1c0f5f:	c3                   	ret    

00000000001c0f60 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1c0f60:	f3 0f 1e fa          	endbr64 
  1c0f64:	55                   	push   %rbp
  1c0f65:	48 89 e5             	mov    %rsp,%rbp
  1c0f68:	48 83 ec 30          	sub    $0x30,%rsp
  1c0f6c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1c0f6f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1c0f72:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1c0f76:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1c0f7a:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 1c0e6a <console_putc>
  1c0f81:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1c0f85:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1c0f89:	78 09                	js     1c0f94 <console_vprintf+0x34>
  1c0f8b:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1c0f92:	7e 07                	jle    1c0f9b <console_vprintf+0x3b>
        cpos = 0;
  1c0f94:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1c0f9b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0f9e:	48 98                	cltq   
  1c0fa0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1c0fa4:	48 8d 05 55 70 ef ff 	lea    -0x108fab(%rip),%rax        # b8000 <console>
  1c0fab:	48 01 d0             	add    %rdx,%rax
  1c0fae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1c0fb2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1c0fb6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1c0fba:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1c0fbd:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1c0fc1:	48 89 c7             	mov    %rax,%rdi
  1c0fc4:	e8 9a f4 ff ff       	call   1c0463 <printer_vprintf>
    return cp.cursor - console;
  1c0fc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0fcd:	48 8d 15 2c 70 ef ff 	lea    -0x108fd4(%rip),%rdx        # b8000 <console>
  1c0fd4:	48 29 d0             	sub    %rdx,%rax
  1c0fd7:	48 d1 f8             	sar    %rax
}
  1c0fda:	c9                   	leave  
  1c0fdb:	c3                   	ret    

00000000001c0fdc <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1c0fdc:	f3 0f 1e fa          	endbr64 
  1c0fe0:	55                   	push   %rbp
  1c0fe1:	48 89 e5             	mov    %rsp,%rbp
  1c0fe4:	48 83 ec 60          	sub    $0x60,%rsp
  1c0fe8:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1c0feb:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1c0fee:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1c0ff2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1c0ff6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1c0ffa:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1c0ffe:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1c1005:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1c1009:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1c100d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1c1011:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1c1015:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1c1019:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1c101d:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1c1020:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1c1023:	89 c7                	mov    %eax,%edi
  1c1025:	e8 36 ff ff ff       	call   1c0f60 <console_vprintf>
  1c102a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1c102d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1c1030:	c9                   	leave  
  1c1031:	c3                   	ret    

00000000001c1032 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1c1032:	f3 0f 1e fa          	endbr64 
  1c1036:	55                   	push   %rbp
  1c1037:	48 89 e5             	mov    %rsp,%rbp
  1c103a:	48 83 ec 20          	sub    $0x20,%rsp
  1c103e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c1042:	89 f0                	mov    %esi,%eax
  1c1044:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1c1047:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1c104a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c104e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1c1052:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c1056:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1c105a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c105e:	48 8b 40 10          	mov    0x10(%rax),%rax
  1c1062:	48 39 c2             	cmp    %rax,%rdx
  1c1065:	73 1a                	jae    1c1081 <string_putc+0x4f>
        *sp->s++ = c;
  1c1067:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c106b:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c106f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1c1073:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1c1077:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c107b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1c107f:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1c1081:	90                   	nop
  1c1082:	c9                   	leave  
  1c1083:	c3                   	ret    

00000000001c1084 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1c1084:	f3 0f 1e fa          	endbr64 
  1c1088:	55                   	push   %rbp
  1c1089:	48 89 e5             	mov    %rsp,%rbp
  1c108c:	48 83 ec 40          	sub    $0x40,%rsp
  1c1090:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1c1094:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1c1098:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1c109c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1c10a0:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 1c1032 <string_putc>
  1c10a7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  1c10ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c10af:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1c10b3:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1c10b8:	74 33                	je     1c10ed <vsnprintf+0x69>
        sp.end = s + size - 1;
  1c10ba:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1c10be:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1c10c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c10c6:	48 01 d0             	add    %rdx,%rax
  1c10c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1c10cd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1c10d1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1c10d5:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1c10d9:	be 00 00 00 00       	mov    $0x0,%esi
  1c10de:	48 89 c7             	mov    %rax,%rdi
  1c10e1:	e8 7d f3 ff ff       	call   1c0463 <printer_vprintf>
        *sp.s = 0;
  1c10e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c10ea:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1c10ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c10f1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1c10f5:	c9                   	leave  
  1c10f6:	c3                   	ret    

00000000001c10f7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1c10f7:	f3 0f 1e fa          	endbr64 
  1c10fb:	55                   	push   %rbp
  1c10fc:	48 89 e5             	mov    %rsp,%rbp
  1c10ff:	48 83 ec 70          	sub    $0x70,%rsp
  1c1103:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1c1107:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1c110b:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1c110f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1c1113:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1c1117:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1c111b:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1c1122:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1c1126:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1c112a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1c112e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1c1132:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1c1136:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1c113a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1c113e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1c1142:	48 89 c7             	mov    %rax,%rdi
  1c1145:	e8 3a ff ff ff       	call   1c1084 <vsnprintf>
  1c114a:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1c114d:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1c1150:	c9                   	leave  
  1c1151:	c3                   	ret    

00000000001c1152 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1c1152:	f3 0f 1e fa          	endbr64 
  1c1156:	55                   	push   %rbp
  1c1157:	48 89 e5             	mov    %rsp,%rbp
  1c115a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1c115e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1c1165:	eb 1a                	jmp    1c1181 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  1c1167:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1c116a:	48 98                	cltq   
  1c116c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1c1170:	48 8d 05 89 6e ef ff 	lea    -0x109177(%rip),%rax        # b8000 <console>
  1c1177:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1c117d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1c1181:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1c1188:	7e dd                	jle    1c1167 <console_clear+0x15>
    }
    cursorpos = 0;
  1c118a:	c7 05 68 7e ef ff 00 	movl   $0x0,-0x108198(%rip)        # b8ffc <cursorpos>
  1c1191:	00 00 00 
}
  1c1194:	90                   	nop
  1c1195:	c9                   	leave  
  1c1196:	c3                   	ret    
