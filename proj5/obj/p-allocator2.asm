
obj/p-allocator2.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000140000 <process_main>:
uint8_t* stack_bottom;

// Program that starts allocating page by page from its heap
// till it reaches stack OR runs out of memory

void process_main(void) {
  140000:	f3 0f 1e fa          	endbr64 
  140004:	55                   	push   %rbp
  140005:	48 89 e5             	mov    %rsp,%rbp
  140008:	53                   	push   %rbx
  140009:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  14000d:	cd 31                	int    $0x31
  14000f:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  140011:	89 c7                	mov    %eax,%edi
  140013:	e8 9a 03 00 00       	call   1403b2 <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  140018:	48 8d 05 f8 2f 00 00 	lea    0x2ff8(%rip),%rax        # 143017 <end+0xfff>
  14001f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  140025:	48 89 05 dc 1f 00 00 	mov    %rax,0x1fdc(%rip)        # 142008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  14002c:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  14002f:	48 83 e8 01          	sub    $0x1,%rax
  140033:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  140039:	48 89 05 c0 1f 00 00 	mov    %rax,0x1fc0(%rip)        # 142000 <stack_bottom>
  140040:	eb 02                	jmp    140044 <process_main+0x44>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  140042:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  140044:	e8 29 03 00 00       	call   140372 <rand>
  140049:	48 63 d0             	movslq %eax,%rdx
  14004c:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  140053:	48 c1 fa 25          	sar    $0x25,%rdx
  140057:	89 c1                	mov    %eax,%ecx
  140059:	c1 f9 1f             	sar    $0x1f,%ecx
  14005c:	29 ca                	sub    %ecx,%edx
  14005e:	6b d2 64             	imul   $0x64,%edx,%edx
  140061:	29 d0                	sub    %edx,%eax
  140063:	39 d8                	cmp    %ebx,%eax
  140065:	7d db                	jge    140042 <process_main+0x42>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  140067:	48 8b 3d 9a 1f 00 00 	mov    0x1f9a(%rip),%rdi        # 142008 <heap_top>
  14006e:	48 3b 3d 8b 1f 00 00 	cmp    0x1f8b(%rip),%rdi        # 142000 <stack_bottom>
  140075:	74 1c                	je     140093 <process_main+0x93>
//    Allocate a page of memory at address `addr` and allow process to
//    write to it. `Addr` must be page-aligned (i.e., a multiple of
//    PAGESIZE == 4096). Returns 0 on success and -1 on failure.
static inline int sys_page_alloc(void* addr) {
    int result;
    asm volatile ("int %1" : "=a" (result)
  140077:	cd 33                	int    $0x33
  140079:	85 c0                	test   %eax,%eax
  14007b:	78 16                	js     140093 <process_main+0x93>
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
  14007d:	48 8b 05 84 1f 00 00 	mov    0x1f84(%rip),%rax        # 142008 <heap_top>
  140084:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  140086:	48 81 05 77 1f 00 00 	addq   $0x1000,0x1f77(%rip)        # 142008 <heap_top>
  14008d:	00 10 00 00 
  140091:	eb af                	jmp    140042 <process_main+0x42>
    asm volatile ("int %0" : /* no result */
  140093:	cd 32                	int    $0x32
  140095:	eb fc                	jmp    140093 <process_main+0x93>

0000000000140097 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  140097:	f3 0f 1e fa          	endbr64 
  14009b:	55                   	push   %rbp
  14009c:	48 89 e5             	mov    %rsp,%rbp
  14009f:	48 83 ec 28          	sub    $0x28,%rsp
  1400a3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1400a7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1400ab:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1400af:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1400b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1400b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1400bb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1400bf:	eb 1c                	jmp    1400dd <memcpy+0x46>
        *d = *s;
  1400c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1400c5:	0f b6 10             	movzbl (%rax),%edx
  1400c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1400cc:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1400ce:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1400d3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1400d8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1400dd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1400e2:	75 dd                	jne    1400c1 <memcpy+0x2a>
    }
    return dst;
  1400e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1400e8:	c9                   	leave  
  1400e9:	c3                   	ret    

00000000001400ea <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1400ea:	f3 0f 1e fa          	endbr64 
  1400ee:	55                   	push   %rbp
  1400ef:	48 89 e5             	mov    %rsp,%rbp
  1400f2:	48 83 ec 28          	sub    $0x28,%rsp
  1400f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1400fa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1400fe:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  140102:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  140106:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  14010a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  14010e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  140112:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  140116:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  14011a:	73 6a                	jae    140186 <memmove+0x9c>
  14011c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  140120:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  140124:	48 01 d0             	add    %rdx,%rax
  140127:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  14012b:	73 59                	jae    140186 <memmove+0x9c>
        s += n, d += n;
  14012d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  140131:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  140135:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  140139:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  14013d:	eb 17                	jmp    140156 <memmove+0x6c>
            *--d = *--s;
  14013f:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  140144:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  140149:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  14014d:	0f b6 10             	movzbl (%rax),%edx
  140150:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  140154:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  140156:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  14015a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  14015e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  140162:	48 85 c0             	test   %rax,%rax
  140165:	75 d8                	jne    14013f <memmove+0x55>
    if (s < d && s + n > d) {
  140167:	eb 2e                	jmp    140197 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  140169:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  14016d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  140171:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  140175:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  140179:	48 8d 48 01          	lea    0x1(%rax),%rcx
  14017d:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  140181:	0f b6 12             	movzbl (%rdx),%edx
  140184:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  140186:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  14018a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  14018e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  140192:	48 85 c0             	test   %rax,%rax
  140195:	75 d2                	jne    140169 <memmove+0x7f>
        }
    }
    return dst;
  140197:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  14019b:	c9                   	leave  
  14019c:	c3                   	ret    

000000000014019d <memset>:

void* memset(void* v, int c, size_t n) {
  14019d:	f3 0f 1e fa          	endbr64 
  1401a1:	55                   	push   %rbp
  1401a2:	48 89 e5             	mov    %rsp,%rbp
  1401a5:	48 83 ec 28          	sub    $0x28,%rsp
  1401a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1401ad:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1401b0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1401b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1401b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1401bc:	eb 15                	jmp    1401d3 <memset+0x36>
        *p = c;
  1401be:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1401c1:	89 c2                	mov    %eax,%edx
  1401c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1401c7:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1401c9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1401ce:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1401d3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1401d8:	75 e4                	jne    1401be <memset+0x21>
    }
    return v;
  1401da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1401de:	c9                   	leave  
  1401df:	c3                   	ret    

00000000001401e0 <strlen>:

size_t strlen(const char* s) {
  1401e0:	f3 0f 1e fa          	endbr64 
  1401e4:	55                   	push   %rbp
  1401e5:	48 89 e5             	mov    %rsp,%rbp
  1401e8:	48 83 ec 18          	sub    $0x18,%rsp
  1401ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1401f0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1401f7:	00 
  1401f8:	eb 0a                	jmp    140204 <strlen+0x24>
        ++n;
  1401fa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1401ff:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  140204:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  140208:	0f b6 00             	movzbl (%rax),%eax
  14020b:	84 c0                	test   %al,%al
  14020d:	75 eb                	jne    1401fa <strlen+0x1a>
    }
    return n;
  14020f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  140213:	c9                   	leave  
  140214:	c3                   	ret    

0000000000140215 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  140215:	f3 0f 1e fa          	endbr64 
  140219:	55                   	push   %rbp
  14021a:	48 89 e5             	mov    %rsp,%rbp
  14021d:	48 83 ec 20          	sub    $0x20,%rsp
  140221:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  140225:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  140229:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  140230:	00 
  140231:	eb 0a                	jmp    14023d <strnlen+0x28>
        ++n;
  140233:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  140238:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  14023d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  140241:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  140245:	74 0b                	je     140252 <strnlen+0x3d>
  140247:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  14024b:	0f b6 00             	movzbl (%rax),%eax
  14024e:	84 c0                	test   %al,%al
  140250:	75 e1                	jne    140233 <strnlen+0x1e>
    }
    return n;
  140252:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  140256:	c9                   	leave  
  140257:	c3                   	ret    

0000000000140258 <strcpy>:

char* strcpy(char* dst, const char* src) {
  140258:	f3 0f 1e fa          	endbr64 
  14025c:	55                   	push   %rbp
  14025d:	48 89 e5             	mov    %rsp,%rbp
  140260:	48 83 ec 20          	sub    $0x20,%rsp
  140264:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  140268:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  14026c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  140270:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  140274:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  140278:	48 8d 42 01          	lea    0x1(%rdx),%rax
  14027c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  140280:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  140284:	48 8d 48 01          	lea    0x1(%rax),%rcx
  140288:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  14028c:	0f b6 12             	movzbl (%rdx),%edx
  14028f:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  140291:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  140295:	48 83 e8 01          	sub    $0x1,%rax
  140299:	0f b6 00             	movzbl (%rax),%eax
  14029c:	84 c0                	test   %al,%al
  14029e:	75 d4                	jne    140274 <strcpy+0x1c>
    return dst;
  1402a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1402a4:	c9                   	leave  
  1402a5:	c3                   	ret    

00000000001402a6 <strcmp>:

int strcmp(const char* a, const char* b) {
  1402a6:	f3 0f 1e fa          	endbr64 
  1402aa:	55                   	push   %rbp
  1402ab:	48 89 e5             	mov    %rsp,%rbp
  1402ae:	48 83 ec 10          	sub    $0x10,%rsp
  1402b2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1402b6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1402ba:	eb 0a                	jmp    1402c6 <strcmp+0x20>
        ++a, ++b;
  1402bc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1402c1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1402c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1402ca:	0f b6 00             	movzbl (%rax),%eax
  1402cd:	84 c0                	test   %al,%al
  1402cf:	74 1d                	je     1402ee <strcmp+0x48>
  1402d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1402d5:	0f b6 00             	movzbl (%rax),%eax
  1402d8:	84 c0                	test   %al,%al
  1402da:	74 12                	je     1402ee <strcmp+0x48>
  1402dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1402e0:	0f b6 10             	movzbl (%rax),%edx
  1402e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1402e7:	0f b6 00             	movzbl (%rax),%eax
  1402ea:	38 c2                	cmp    %al,%dl
  1402ec:	74 ce                	je     1402bc <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1402ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1402f2:	0f b6 00             	movzbl (%rax),%eax
  1402f5:	89 c2                	mov    %eax,%edx
  1402f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1402fb:	0f b6 00             	movzbl (%rax),%eax
  1402fe:	38 c2                	cmp    %al,%dl
  140300:	0f 97 c0             	seta   %al
  140303:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  140306:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  14030a:	0f b6 00             	movzbl (%rax),%eax
  14030d:	89 c1                	mov    %eax,%ecx
  14030f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  140313:	0f b6 00             	movzbl (%rax),%eax
  140316:	38 c1                	cmp    %al,%cl
  140318:	0f 92 c0             	setb   %al
  14031b:	0f b6 c8             	movzbl %al,%ecx
  14031e:	89 d0                	mov    %edx,%eax
  140320:	29 c8                	sub    %ecx,%eax
}
  140322:	c9                   	leave  
  140323:	c3                   	ret    

0000000000140324 <strchr>:

char* strchr(const char* s, int c) {
  140324:	f3 0f 1e fa          	endbr64 
  140328:	55                   	push   %rbp
  140329:	48 89 e5             	mov    %rsp,%rbp
  14032c:	48 83 ec 10          	sub    $0x10,%rsp
  140330:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  140334:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  140337:	eb 05                	jmp    14033e <strchr+0x1a>
        ++s;
  140339:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  14033e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  140342:	0f b6 00             	movzbl (%rax),%eax
  140345:	84 c0                	test   %al,%al
  140347:	74 0e                	je     140357 <strchr+0x33>
  140349:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  14034d:	0f b6 00             	movzbl (%rax),%eax
  140350:	8b 55 f4             	mov    -0xc(%rbp),%edx
  140353:	38 d0                	cmp    %dl,%al
  140355:	75 e2                	jne    140339 <strchr+0x15>
    }
    if (*s == (char) c) {
  140357:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  14035b:	0f b6 00             	movzbl (%rax),%eax
  14035e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  140361:	38 d0                	cmp    %dl,%al
  140363:	75 06                	jne    14036b <strchr+0x47>
        return (char*) s;
  140365:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  140369:	eb 05                	jmp    140370 <strchr+0x4c>
    } else {
        return NULL;
  14036b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  140370:	c9                   	leave  
  140371:	c3                   	ret    

0000000000140372 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  140372:	f3 0f 1e fa          	endbr64 
  140376:	55                   	push   %rbp
  140377:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  14037a:	8b 05 90 1c 00 00    	mov    0x1c90(%rip),%eax        # 142010 <rand_seed_set>
  140380:	85 c0                	test   %eax,%eax
  140382:	75 0a                	jne    14038e <rand+0x1c>
        srand(819234718U);
  140384:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  140389:	e8 24 00 00 00       	call   1403b2 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  14038e:	8b 05 80 1c 00 00    	mov    0x1c80(%rip),%eax        # 142014 <rand_seed>
  140394:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  14039a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  14039f:	89 05 6f 1c 00 00    	mov    %eax,0x1c6f(%rip)        # 142014 <rand_seed>
    return rand_seed & RAND_MAX;
  1403a5:	8b 05 69 1c 00 00    	mov    0x1c69(%rip),%eax        # 142014 <rand_seed>
  1403ab:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1403b0:	5d                   	pop    %rbp
  1403b1:	c3                   	ret    

00000000001403b2 <srand>:

void srand(unsigned seed) {
  1403b2:	f3 0f 1e fa          	endbr64 
  1403b6:	55                   	push   %rbp
  1403b7:	48 89 e5             	mov    %rsp,%rbp
  1403ba:	48 83 ec 08          	sub    $0x8,%rsp
  1403be:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1403c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1403c4:	89 05 4a 1c 00 00    	mov    %eax,0x1c4a(%rip)        # 142014 <rand_seed>
    rand_seed_set = 1;
  1403ca:	c7 05 3c 1c 00 00 01 	movl   $0x1,0x1c3c(%rip)        # 142010 <rand_seed_set>
  1403d1:	00 00 00 
}
  1403d4:	90                   	nop
  1403d5:	c9                   	leave  
  1403d6:	c3                   	ret    

00000000001403d7 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1403d7:	f3 0f 1e fa          	endbr64 
  1403db:	55                   	push   %rbp
  1403dc:	48 89 e5             	mov    %rsp,%rbp
  1403df:	48 83 ec 28          	sub    $0x28,%rsp
  1403e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1403e7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1403eb:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1403ee:	48 8d 05 ab 0e 00 00 	lea    0xeab(%rip),%rax        # 1412a0 <upper_digits.1>
  1403f5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  1403f9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1403fd:	79 0e                	jns    14040d <fill_numbuf+0x36>
        digits = lower_digits;
  1403ff:	48 8d 05 ba 0e 00 00 	lea    0xeba(%rip),%rax        # 1412c0 <lower_digits.0>
  140406:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  14040a:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  14040d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  140412:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  140416:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  140419:	8b 45 dc             	mov    -0x24(%rbp),%eax
  14041c:	48 63 c8             	movslq %eax,%rcx
  14041f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  140423:	ba 00 00 00 00       	mov    $0x0,%edx
  140428:	48 f7 f1             	div    %rcx
  14042b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  14042f:	48 01 d0             	add    %rdx,%rax
  140432:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  140437:	0f b6 10             	movzbl (%rax),%edx
  14043a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  14043e:	88 10                	mov    %dl,(%rax)
        val /= base;
  140440:	8b 45 dc             	mov    -0x24(%rbp),%eax
  140443:	48 63 f0             	movslq %eax,%rsi
  140446:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  14044a:	ba 00 00 00 00       	mov    $0x0,%edx
  14044f:	48 f7 f6             	div    %rsi
  140452:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  140456:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  14045b:	75 bc                	jne    140419 <fill_numbuf+0x42>
    return numbuf_end;
  14045d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  140461:	c9                   	leave  
  140462:	c3                   	ret    

0000000000140463 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  140463:	f3 0f 1e fa          	endbr64 
  140467:	55                   	push   %rbp
  140468:	48 89 e5             	mov    %rsp,%rbp
  14046b:	53                   	push   %rbx
  14046c:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  140473:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  14047a:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  140480:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  140487:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  14048e:	e9 bd 09 00 00       	jmp    140e50 <printer_vprintf+0x9ed>
        if (*format != '%') {
  140493:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  14049a:	0f b6 00             	movzbl (%rax),%eax
  14049d:	3c 25                	cmp    $0x25,%al
  14049f:	74 31                	je     1404d2 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  1404a1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1404a8:	4c 8b 00             	mov    (%rax),%r8
  1404ab:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1404b2:	0f b6 00             	movzbl (%rax),%eax
  1404b5:	0f b6 c8             	movzbl %al,%ecx
  1404b8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1404be:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1404c5:	89 ce                	mov    %ecx,%esi
  1404c7:	48 89 c7             	mov    %rax,%rdi
  1404ca:	41 ff d0             	call   *%r8
            continue;
  1404cd:	e9 76 09 00 00       	jmp    140e48 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  1404d2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1404d9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1404e0:	01 
  1404e1:	eb 4d                	jmp    140530 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  1404e3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1404ea:	0f b6 00             	movzbl (%rax),%eax
  1404ed:	0f be c0             	movsbl %al,%eax
  1404f0:	89 c6                	mov    %eax,%esi
  1404f2:	48 8d 05 a7 0c 00 00 	lea    0xca7(%rip),%rax        # 1411a0 <flag_chars>
  1404f9:	48 89 c7             	mov    %rax,%rdi
  1404fc:	e8 23 fe ff ff       	call   140324 <strchr>
  140501:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  140505:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  14050a:	74 34                	je     140540 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  14050c:	48 8d 15 8d 0c 00 00 	lea    0xc8d(%rip),%rdx        # 1411a0 <flag_chars>
  140513:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  140517:	48 29 d0             	sub    %rdx,%rax
  14051a:	ba 01 00 00 00       	mov    $0x1,%edx
  14051f:	89 c1                	mov    %eax,%ecx
  140521:	d3 e2                	shl    %cl,%edx
  140523:	89 d0                	mov    %edx,%eax
  140525:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  140528:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  14052f:	01 
  140530:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  140537:	0f b6 00             	movzbl (%rax),%eax
  14053a:	84 c0                	test   %al,%al
  14053c:	75 a5                	jne    1404e3 <printer_vprintf+0x80>
  14053e:	eb 01                	jmp    140541 <printer_vprintf+0xde>
            } else {
                break;
  140540:	90                   	nop
            }
        }

        // process width
        int width = -1;
  140541:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  140548:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  14054f:	0f b6 00             	movzbl (%rax),%eax
  140552:	3c 30                	cmp    $0x30,%al
  140554:	7e 67                	jle    1405bd <printer_vprintf+0x15a>
  140556:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  14055d:	0f b6 00             	movzbl (%rax),%eax
  140560:	3c 39                	cmp    $0x39,%al
  140562:	7f 59                	jg     1405bd <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  140564:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  14056b:	eb 2e                	jmp    14059b <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  14056d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  140570:	89 d0                	mov    %edx,%eax
  140572:	c1 e0 02             	shl    $0x2,%eax
  140575:	01 d0                	add    %edx,%eax
  140577:	01 c0                	add    %eax,%eax
  140579:	89 c1                	mov    %eax,%ecx
  14057b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  140582:	48 8d 50 01          	lea    0x1(%rax),%rdx
  140586:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  14058d:	0f b6 00             	movzbl (%rax),%eax
  140590:	0f be c0             	movsbl %al,%eax
  140593:	01 c8                	add    %ecx,%eax
  140595:	83 e8 30             	sub    $0x30,%eax
  140598:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  14059b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1405a2:	0f b6 00             	movzbl (%rax),%eax
  1405a5:	3c 2f                	cmp    $0x2f,%al
  1405a7:	0f 8e 85 00 00 00    	jle    140632 <printer_vprintf+0x1cf>
  1405ad:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1405b4:	0f b6 00             	movzbl (%rax),%eax
  1405b7:	3c 39                	cmp    $0x39,%al
  1405b9:	7e b2                	jle    14056d <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  1405bb:	eb 75                	jmp    140632 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  1405bd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1405c4:	0f b6 00             	movzbl (%rax),%eax
  1405c7:	3c 2a                	cmp    $0x2a,%al
  1405c9:	75 68                	jne    140633 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  1405cb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1405d2:	8b 00                	mov    (%rax),%eax
  1405d4:	83 f8 2f             	cmp    $0x2f,%eax
  1405d7:	77 30                	ja     140609 <printer_vprintf+0x1a6>
  1405d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1405e0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1405e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1405eb:	8b 00                	mov    (%rax),%eax
  1405ed:	89 c0                	mov    %eax,%eax
  1405ef:	48 01 d0             	add    %rdx,%rax
  1405f2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1405f9:	8b 12                	mov    (%rdx),%edx
  1405fb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1405fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140605:	89 0a                	mov    %ecx,(%rdx)
  140607:	eb 1a                	jmp    140623 <printer_vprintf+0x1c0>
  140609:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140610:	48 8b 40 08          	mov    0x8(%rax),%rax
  140614:	48 8d 48 08          	lea    0x8(%rax),%rcx
  140618:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  14061f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  140623:	8b 00                	mov    (%rax),%eax
  140625:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  140628:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  14062f:	01 
  140630:	eb 01                	jmp    140633 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  140632:	90                   	nop
        }

        // process precision
        int precision = -1;
  140633:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  14063a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  140641:	0f b6 00             	movzbl (%rax),%eax
  140644:	3c 2e                	cmp    $0x2e,%al
  140646:	0f 85 00 01 00 00    	jne    14074c <printer_vprintf+0x2e9>
            ++format;
  14064c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  140653:	01 
            if (*format >= '0' && *format <= '9') {
  140654:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  14065b:	0f b6 00             	movzbl (%rax),%eax
  14065e:	3c 2f                	cmp    $0x2f,%al
  140660:	7e 67                	jle    1406c9 <printer_vprintf+0x266>
  140662:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  140669:	0f b6 00             	movzbl (%rax),%eax
  14066c:	3c 39                	cmp    $0x39,%al
  14066e:	7f 59                	jg     1406c9 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  140670:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  140677:	eb 2e                	jmp    1406a7 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  140679:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  14067c:	89 d0                	mov    %edx,%eax
  14067e:	c1 e0 02             	shl    $0x2,%eax
  140681:	01 d0                	add    %edx,%eax
  140683:	01 c0                	add    %eax,%eax
  140685:	89 c1                	mov    %eax,%ecx
  140687:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  14068e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  140692:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  140699:	0f b6 00             	movzbl (%rax),%eax
  14069c:	0f be c0             	movsbl %al,%eax
  14069f:	01 c8                	add    %ecx,%eax
  1406a1:	83 e8 30             	sub    $0x30,%eax
  1406a4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1406a7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1406ae:	0f b6 00             	movzbl (%rax),%eax
  1406b1:	3c 2f                	cmp    $0x2f,%al
  1406b3:	0f 8e 85 00 00 00    	jle    14073e <printer_vprintf+0x2db>
  1406b9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1406c0:	0f b6 00             	movzbl (%rax),%eax
  1406c3:	3c 39                	cmp    $0x39,%al
  1406c5:	7e b2                	jle    140679 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  1406c7:	eb 75                	jmp    14073e <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  1406c9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1406d0:	0f b6 00             	movzbl (%rax),%eax
  1406d3:	3c 2a                	cmp    $0x2a,%al
  1406d5:	75 68                	jne    14073f <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  1406d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1406de:	8b 00                	mov    (%rax),%eax
  1406e0:	83 f8 2f             	cmp    $0x2f,%eax
  1406e3:	77 30                	ja     140715 <printer_vprintf+0x2b2>
  1406e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1406ec:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1406f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1406f7:	8b 00                	mov    (%rax),%eax
  1406f9:	89 c0                	mov    %eax,%eax
  1406fb:	48 01 d0             	add    %rdx,%rax
  1406fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140705:	8b 12                	mov    (%rdx),%edx
  140707:	8d 4a 08             	lea    0x8(%rdx),%ecx
  14070a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140711:	89 0a                	mov    %ecx,(%rdx)
  140713:	eb 1a                	jmp    14072f <printer_vprintf+0x2cc>
  140715:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  14071c:	48 8b 40 08          	mov    0x8(%rax),%rax
  140720:	48 8d 48 08          	lea    0x8(%rax),%rcx
  140724:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  14072b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  14072f:	8b 00                	mov    (%rax),%eax
  140731:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  140734:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  14073b:	01 
  14073c:	eb 01                	jmp    14073f <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  14073e:	90                   	nop
            }
            if (precision < 0) {
  14073f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  140743:	79 07                	jns    14074c <printer_vprintf+0x2e9>
                precision = 0;
  140745:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  14074c:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  140753:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  14075a:	00 
        int length = 0;
  14075b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  140762:	48 8d 05 3d 0a 00 00 	lea    0xa3d(%rip),%rax        # 1411a6 <flag_chars+0x6>
  140769:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  14076d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  140774:	0f b6 00             	movzbl (%rax),%eax
  140777:	0f be c0             	movsbl %al,%eax
  14077a:	83 e8 43             	sub    $0x43,%eax
  14077d:	83 f8 37             	cmp    $0x37,%eax
  140780:	0f 87 b6 03 00 00    	ja     140b3c <printer_vprintf+0x6d9>
  140786:	89 c0                	mov    %eax,%eax
  140788:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  14078f:	00 
  140790:	48 8d 05 1d 0a 00 00 	lea    0xa1d(%rip),%rax        # 1411b4 <flag_chars+0x14>
  140797:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  14079a:	48 98                	cltq   
  14079c:	48 8d 15 11 0a 00 00 	lea    0xa11(%rip),%rdx        # 1411b4 <flag_chars+0x14>
  1407a3:	48 01 d0             	add    %rdx,%rax
  1407a6:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  1407a9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1407b0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1407b7:	01 
            goto again;
  1407b8:	eb b3                	jmp    14076d <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1407ba:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1407be:	74 5d                	je     14081d <printer_vprintf+0x3ba>
  1407c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1407c7:	8b 00                	mov    (%rax),%eax
  1407c9:	83 f8 2f             	cmp    $0x2f,%eax
  1407cc:	77 30                	ja     1407fe <printer_vprintf+0x39b>
  1407ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1407d5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1407d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1407e0:	8b 00                	mov    (%rax),%eax
  1407e2:	89 c0                	mov    %eax,%eax
  1407e4:	48 01 d0             	add    %rdx,%rax
  1407e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1407ee:	8b 12                	mov    (%rdx),%edx
  1407f0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1407f3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1407fa:	89 0a                	mov    %ecx,(%rdx)
  1407fc:	eb 1a                	jmp    140818 <printer_vprintf+0x3b5>
  1407fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140805:	48 8b 40 08          	mov    0x8(%rax),%rax
  140809:	48 8d 48 08          	lea    0x8(%rax),%rcx
  14080d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140814:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  140818:	48 8b 00             	mov    (%rax),%rax
  14081b:	eb 5c                	jmp    140879 <printer_vprintf+0x416>
  14081d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140824:	8b 00                	mov    (%rax),%eax
  140826:	83 f8 2f             	cmp    $0x2f,%eax
  140829:	77 30                	ja     14085b <printer_vprintf+0x3f8>
  14082b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140832:	48 8b 50 10          	mov    0x10(%rax),%rdx
  140836:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  14083d:	8b 00                	mov    (%rax),%eax
  14083f:	89 c0                	mov    %eax,%eax
  140841:	48 01 d0             	add    %rdx,%rax
  140844:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  14084b:	8b 12                	mov    (%rdx),%edx
  14084d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  140850:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140857:	89 0a                	mov    %ecx,(%rdx)
  140859:	eb 1a                	jmp    140875 <printer_vprintf+0x412>
  14085b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140862:	48 8b 40 08          	mov    0x8(%rax),%rax
  140866:	48 8d 48 08          	lea    0x8(%rax),%rcx
  14086a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140871:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  140875:	8b 00                	mov    (%rax),%eax
  140877:	48 98                	cltq   
  140879:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  14087d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  140881:	48 c1 f8 38          	sar    $0x38,%rax
  140885:	25 80 00 00 00       	and    $0x80,%eax
  14088a:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  14088d:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  140891:	74 09                	je     14089c <printer_vprintf+0x439>
  140893:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  140897:	48 f7 d8             	neg    %rax
  14089a:	eb 04                	jmp    1408a0 <printer_vprintf+0x43d>
  14089c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1408a0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1408a4:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  1408a7:	83 c8 60             	or     $0x60,%eax
  1408aa:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  1408ad:	e9 cf 02 00 00       	jmp    140b81 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1408b2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1408b6:	74 5d                	je     140915 <printer_vprintf+0x4b2>
  1408b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1408bf:	8b 00                	mov    (%rax),%eax
  1408c1:	83 f8 2f             	cmp    $0x2f,%eax
  1408c4:	77 30                	ja     1408f6 <printer_vprintf+0x493>
  1408c6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1408cd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1408d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1408d8:	8b 00                	mov    (%rax),%eax
  1408da:	89 c0                	mov    %eax,%eax
  1408dc:	48 01 d0             	add    %rdx,%rax
  1408df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1408e6:	8b 12                	mov    (%rdx),%edx
  1408e8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1408eb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1408f2:	89 0a                	mov    %ecx,(%rdx)
  1408f4:	eb 1a                	jmp    140910 <printer_vprintf+0x4ad>
  1408f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1408fd:	48 8b 40 08          	mov    0x8(%rax),%rax
  140901:	48 8d 48 08          	lea    0x8(%rax),%rcx
  140905:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  14090c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  140910:	48 8b 00             	mov    (%rax),%rax
  140913:	eb 5c                	jmp    140971 <printer_vprintf+0x50e>
  140915:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  14091c:	8b 00                	mov    (%rax),%eax
  14091e:	83 f8 2f             	cmp    $0x2f,%eax
  140921:	77 30                	ja     140953 <printer_vprintf+0x4f0>
  140923:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  14092a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  14092e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140935:	8b 00                	mov    (%rax),%eax
  140937:	89 c0                	mov    %eax,%eax
  140939:	48 01 d0             	add    %rdx,%rax
  14093c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140943:	8b 12                	mov    (%rdx),%edx
  140945:	8d 4a 08             	lea    0x8(%rdx),%ecx
  140948:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  14094f:	89 0a                	mov    %ecx,(%rdx)
  140951:	eb 1a                	jmp    14096d <printer_vprintf+0x50a>
  140953:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  14095a:	48 8b 40 08          	mov    0x8(%rax),%rax
  14095e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  140962:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140969:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  14096d:	8b 00                	mov    (%rax),%eax
  14096f:	89 c0                	mov    %eax,%eax
  140971:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  140975:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  140979:	e9 03 02 00 00       	jmp    140b81 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  14097e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  140985:	e9 28 ff ff ff       	jmp    1408b2 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  14098a:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  140991:	e9 1c ff ff ff       	jmp    1408b2 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  140996:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  14099d:	8b 00                	mov    (%rax),%eax
  14099f:	83 f8 2f             	cmp    $0x2f,%eax
  1409a2:	77 30                	ja     1409d4 <printer_vprintf+0x571>
  1409a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1409ab:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1409af:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1409b6:	8b 00                	mov    (%rax),%eax
  1409b8:	89 c0                	mov    %eax,%eax
  1409ba:	48 01 d0             	add    %rdx,%rax
  1409bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1409c4:	8b 12                	mov    (%rdx),%edx
  1409c6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1409c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1409d0:	89 0a                	mov    %ecx,(%rdx)
  1409d2:	eb 1a                	jmp    1409ee <printer_vprintf+0x58b>
  1409d4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1409db:	48 8b 40 08          	mov    0x8(%rax),%rax
  1409df:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1409e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1409ea:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1409ee:	48 8b 00             	mov    (%rax),%rax
  1409f1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1409f5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1409fc:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  140a03:	e9 79 01 00 00       	jmp    140b81 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  140a08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140a0f:	8b 00                	mov    (%rax),%eax
  140a11:	83 f8 2f             	cmp    $0x2f,%eax
  140a14:	77 30                	ja     140a46 <printer_vprintf+0x5e3>
  140a16:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140a1d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  140a21:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140a28:	8b 00                	mov    (%rax),%eax
  140a2a:	89 c0                	mov    %eax,%eax
  140a2c:	48 01 d0             	add    %rdx,%rax
  140a2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140a36:	8b 12                	mov    (%rdx),%edx
  140a38:	8d 4a 08             	lea    0x8(%rdx),%ecx
  140a3b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140a42:	89 0a                	mov    %ecx,(%rdx)
  140a44:	eb 1a                	jmp    140a60 <printer_vprintf+0x5fd>
  140a46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140a4d:	48 8b 40 08          	mov    0x8(%rax),%rax
  140a51:	48 8d 48 08          	lea    0x8(%rax),%rcx
  140a55:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140a5c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  140a60:	48 8b 00             	mov    (%rax),%rax
  140a63:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  140a67:	e9 15 01 00 00       	jmp    140b81 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  140a6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140a73:	8b 00                	mov    (%rax),%eax
  140a75:	83 f8 2f             	cmp    $0x2f,%eax
  140a78:	77 30                	ja     140aaa <printer_vprintf+0x647>
  140a7a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140a81:	48 8b 50 10          	mov    0x10(%rax),%rdx
  140a85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140a8c:	8b 00                	mov    (%rax),%eax
  140a8e:	89 c0                	mov    %eax,%eax
  140a90:	48 01 d0             	add    %rdx,%rax
  140a93:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140a9a:	8b 12                	mov    (%rdx),%edx
  140a9c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  140a9f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140aa6:	89 0a                	mov    %ecx,(%rdx)
  140aa8:	eb 1a                	jmp    140ac4 <printer_vprintf+0x661>
  140aaa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140ab1:	48 8b 40 08          	mov    0x8(%rax),%rax
  140ab5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  140ab9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140ac0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  140ac4:	8b 00                	mov    (%rax),%eax
  140ac6:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  140acc:	e9 77 03 00 00       	jmp    140e48 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  140ad1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  140ad5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  140ad9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140ae0:	8b 00                	mov    (%rax),%eax
  140ae2:	83 f8 2f             	cmp    $0x2f,%eax
  140ae5:	77 30                	ja     140b17 <printer_vprintf+0x6b4>
  140ae7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140aee:	48 8b 50 10          	mov    0x10(%rax),%rdx
  140af2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140af9:	8b 00                	mov    (%rax),%eax
  140afb:	89 c0                	mov    %eax,%eax
  140afd:	48 01 d0             	add    %rdx,%rax
  140b00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140b07:	8b 12                	mov    (%rdx),%edx
  140b09:	8d 4a 08             	lea    0x8(%rdx),%ecx
  140b0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140b13:	89 0a                	mov    %ecx,(%rdx)
  140b15:	eb 1a                	jmp    140b31 <printer_vprintf+0x6ce>
  140b17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  140b1e:	48 8b 40 08          	mov    0x8(%rax),%rax
  140b22:	48 8d 48 08          	lea    0x8(%rax),%rcx
  140b26:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  140b2d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  140b31:	8b 00                	mov    (%rax),%eax
  140b33:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  140b36:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  140b3a:	eb 45                	jmp    140b81 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  140b3c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  140b40:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  140b44:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  140b4b:	0f b6 00             	movzbl (%rax),%eax
  140b4e:	84 c0                	test   %al,%al
  140b50:	74 0c                	je     140b5e <printer_vprintf+0x6fb>
  140b52:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  140b59:	0f b6 00             	movzbl (%rax),%eax
  140b5c:	eb 05                	jmp    140b63 <printer_vprintf+0x700>
  140b5e:	b8 25 00 00 00       	mov    $0x25,%eax
  140b63:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  140b66:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  140b6a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  140b71:	0f b6 00             	movzbl (%rax),%eax
  140b74:	84 c0                	test   %al,%al
  140b76:	75 08                	jne    140b80 <printer_vprintf+0x71d>
                format--;
  140b78:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  140b7f:	01 
            }
            break;
  140b80:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  140b81:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140b84:	83 e0 20             	and    $0x20,%eax
  140b87:	85 c0                	test   %eax,%eax
  140b89:	74 1e                	je     140ba9 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  140b8b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  140b8f:	48 83 c0 18          	add    $0x18,%rax
  140b93:	8b 55 e0             	mov    -0x20(%rbp),%edx
  140b96:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  140b9a:	48 89 ce             	mov    %rcx,%rsi
  140b9d:	48 89 c7             	mov    %rax,%rdi
  140ba0:	e8 32 f8 ff ff       	call   1403d7 <fill_numbuf>
  140ba5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  140ba9:	48 8d 05 f6 05 00 00 	lea    0x5f6(%rip),%rax        # 1411a6 <flag_chars+0x6>
  140bb0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  140bb4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140bb7:	83 e0 20             	and    $0x20,%eax
  140bba:	85 c0                	test   %eax,%eax
  140bbc:	74 51                	je     140c0f <printer_vprintf+0x7ac>
  140bbe:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140bc1:	83 e0 40             	and    $0x40,%eax
  140bc4:	85 c0                	test   %eax,%eax
  140bc6:	74 47                	je     140c0f <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  140bc8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140bcb:	25 80 00 00 00       	and    $0x80,%eax
  140bd0:	85 c0                	test   %eax,%eax
  140bd2:	74 0d                	je     140be1 <printer_vprintf+0x77e>
                prefix = "-";
  140bd4:	48 8d 05 cc 05 00 00 	lea    0x5cc(%rip),%rax        # 1411a7 <flag_chars+0x7>
  140bdb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  140bdf:	eb 7d                	jmp    140c5e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  140be1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140be4:	83 e0 10             	and    $0x10,%eax
  140be7:	85 c0                	test   %eax,%eax
  140be9:	74 0d                	je     140bf8 <printer_vprintf+0x795>
                prefix = "+";
  140beb:	48 8d 05 b7 05 00 00 	lea    0x5b7(%rip),%rax        # 1411a9 <flag_chars+0x9>
  140bf2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  140bf6:	eb 66                	jmp    140c5e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  140bf8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140bfb:	83 e0 08             	and    $0x8,%eax
  140bfe:	85 c0                	test   %eax,%eax
  140c00:	74 5c                	je     140c5e <printer_vprintf+0x7fb>
                prefix = " ";
  140c02:	48 8d 05 a2 05 00 00 	lea    0x5a2(%rip),%rax        # 1411ab <flag_chars+0xb>
  140c09:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  140c0d:	eb 4f                	jmp    140c5e <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  140c0f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140c12:	83 e0 20             	and    $0x20,%eax
  140c15:	85 c0                	test   %eax,%eax
  140c17:	74 46                	je     140c5f <printer_vprintf+0x7fc>
  140c19:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140c1c:	83 e0 01             	and    $0x1,%eax
  140c1f:	85 c0                	test   %eax,%eax
  140c21:	74 3c                	je     140c5f <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  140c23:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  140c27:	74 06                	je     140c2f <printer_vprintf+0x7cc>
  140c29:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  140c2d:	75 30                	jne    140c5f <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  140c2f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  140c34:	75 0c                	jne    140c42 <printer_vprintf+0x7df>
  140c36:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140c39:	25 00 01 00 00       	and    $0x100,%eax
  140c3e:	85 c0                	test   %eax,%eax
  140c40:	74 1d                	je     140c5f <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  140c42:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  140c46:	75 09                	jne    140c51 <printer_vprintf+0x7ee>
  140c48:	48 8d 05 5e 05 00 00 	lea    0x55e(%rip),%rax        # 1411ad <flag_chars+0xd>
  140c4f:	eb 07                	jmp    140c58 <printer_vprintf+0x7f5>
  140c51:	48 8d 05 58 05 00 00 	lea    0x558(%rip),%rax        # 1411b0 <flag_chars+0x10>
  140c58:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  140c5c:	eb 01                	jmp    140c5f <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  140c5e:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  140c5f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  140c63:	78 24                	js     140c89 <printer_vprintf+0x826>
  140c65:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140c68:	83 e0 20             	and    $0x20,%eax
  140c6b:	85 c0                	test   %eax,%eax
  140c6d:	75 1a                	jne    140c89 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  140c6f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  140c72:	48 63 d0             	movslq %eax,%rdx
  140c75:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  140c79:	48 89 d6             	mov    %rdx,%rsi
  140c7c:	48 89 c7             	mov    %rax,%rdi
  140c7f:	e8 91 f5 ff ff       	call   140215 <strnlen>
  140c84:	89 45 bc             	mov    %eax,-0x44(%rbp)
  140c87:	eb 0f                	jmp    140c98 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  140c89:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  140c8d:	48 89 c7             	mov    %rax,%rdi
  140c90:	e8 4b f5 ff ff       	call   1401e0 <strlen>
  140c95:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  140c98:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140c9b:	83 e0 20             	and    $0x20,%eax
  140c9e:	85 c0                	test   %eax,%eax
  140ca0:	74 20                	je     140cc2 <printer_vprintf+0x85f>
  140ca2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  140ca6:	78 1a                	js     140cc2 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  140ca8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  140cab:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  140cae:	7e 08                	jle    140cb8 <printer_vprintf+0x855>
  140cb0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  140cb3:	2b 45 bc             	sub    -0x44(%rbp),%eax
  140cb6:	eb 05                	jmp    140cbd <printer_vprintf+0x85a>
  140cb8:	b8 00 00 00 00       	mov    $0x0,%eax
  140cbd:	89 45 b8             	mov    %eax,-0x48(%rbp)
  140cc0:	eb 5c                	jmp    140d1e <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  140cc2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140cc5:	83 e0 20             	and    $0x20,%eax
  140cc8:	85 c0                	test   %eax,%eax
  140cca:	74 4b                	je     140d17 <printer_vprintf+0x8b4>
  140ccc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140ccf:	83 e0 02             	and    $0x2,%eax
  140cd2:	85 c0                	test   %eax,%eax
  140cd4:	74 41                	je     140d17 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  140cd6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140cd9:	83 e0 04             	and    $0x4,%eax
  140cdc:	85 c0                	test   %eax,%eax
  140cde:	75 37                	jne    140d17 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  140ce0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  140ce4:	48 89 c7             	mov    %rax,%rdi
  140ce7:	e8 f4 f4 ff ff       	call   1401e0 <strlen>
  140cec:	89 c2                	mov    %eax,%edx
  140cee:	8b 45 bc             	mov    -0x44(%rbp),%eax
  140cf1:	01 d0                	add    %edx,%eax
  140cf3:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  140cf6:	7e 1f                	jle    140d17 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  140cf8:	8b 45 e8             	mov    -0x18(%rbp),%eax
  140cfb:	2b 45 bc             	sub    -0x44(%rbp),%eax
  140cfe:	89 c3                	mov    %eax,%ebx
  140d00:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  140d04:	48 89 c7             	mov    %rax,%rdi
  140d07:	e8 d4 f4 ff ff       	call   1401e0 <strlen>
  140d0c:	89 c2                	mov    %eax,%edx
  140d0e:	89 d8                	mov    %ebx,%eax
  140d10:	29 d0                	sub    %edx,%eax
  140d12:	89 45 b8             	mov    %eax,-0x48(%rbp)
  140d15:	eb 07                	jmp    140d1e <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  140d17:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  140d1e:	8b 55 bc             	mov    -0x44(%rbp),%edx
  140d21:	8b 45 b8             	mov    -0x48(%rbp),%eax
  140d24:	01 d0                	add    %edx,%eax
  140d26:	48 63 d8             	movslq %eax,%rbx
  140d29:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  140d2d:	48 89 c7             	mov    %rax,%rdi
  140d30:	e8 ab f4 ff ff       	call   1401e0 <strlen>
  140d35:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  140d39:	8b 45 e8             	mov    -0x18(%rbp),%eax
  140d3c:	29 d0                	sub    %edx,%eax
  140d3e:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  140d41:	eb 25                	jmp    140d68 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  140d43:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  140d4a:	48 8b 08             	mov    (%rax),%rcx
  140d4d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  140d53:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  140d5a:	be 20 00 00 00       	mov    $0x20,%esi
  140d5f:	48 89 c7             	mov    %rax,%rdi
  140d62:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  140d64:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  140d68:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140d6b:	83 e0 04             	and    $0x4,%eax
  140d6e:	85 c0                	test   %eax,%eax
  140d70:	75 36                	jne    140da8 <printer_vprintf+0x945>
  140d72:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  140d76:	7f cb                	jg     140d43 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  140d78:	eb 2e                	jmp    140da8 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  140d7a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  140d81:	4c 8b 00             	mov    (%rax),%r8
  140d84:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  140d88:	0f b6 00             	movzbl (%rax),%eax
  140d8b:	0f b6 c8             	movzbl %al,%ecx
  140d8e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  140d94:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  140d9b:	89 ce                	mov    %ecx,%esi
  140d9d:	48 89 c7             	mov    %rax,%rdi
  140da0:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  140da3:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  140da8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  140dac:	0f b6 00             	movzbl (%rax),%eax
  140daf:	84 c0                	test   %al,%al
  140db1:	75 c7                	jne    140d7a <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  140db3:	eb 25                	jmp    140dda <printer_vprintf+0x977>
            p->putc(p, '0', color);
  140db5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  140dbc:	48 8b 08             	mov    (%rax),%rcx
  140dbf:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  140dc5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  140dcc:	be 30 00 00 00       	mov    $0x30,%esi
  140dd1:	48 89 c7             	mov    %rax,%rdi
  140dd4:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  140dd6:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  140dda:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  140dde:	7f d5                	jg     140db5 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  140de0:	eb 32                	jmp    140e14 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  140de2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  140de9:	4c 8b 00             	mov    (%rax),%r8
  140dec:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  140df0:	0f b6 00             	movzbl (%rax),%eax
  140df3:	0f b6 c8             	movzbl %al,%ecx
  140df6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  140dfc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  140e03:	89 ce                	mov    %ecx,%esi
  140e05:	48 89 c7             	mov    %rax,%rdi
  140e08:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  140e0b:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  140e10:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  140e14:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  140e18:	7f c8                	jg     140de2 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  140e1a:	eb 25                	jmp    140e41 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  140e1c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  140e23:	48 8b 08             	mov    (%rax),%rcx
  140e26:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  140e2c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  140e33:	be 20 00 00 00       	mov    $0x20,%esi
  140e38:	48 89 c7             	mov    %rax,%rdi
  140e3b:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  140e3d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  140e41:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  140e45:	7f d5                	jg     140e1c <printer_vprintf+0x9b9>
        }
    done: ;
  140e47:	90                   	nop
    for (; *format; ++format) {
  140e48:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  140e4f:	01 
  140e50:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  140e57:	0f b6 00             	movzbl (%rax),%eax
  140e5a:	84 c0                	test   %al,%al
  140e5c:	0f 85 31 f6 ff ff    	jne    140493 <printer_vprintf+0x30>
    }
}
  140e62:	90                   	nop
  140e63:	90                   	nop
  140e64:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  140e68:	c9                   	leave  
  140e69:	c3                   	ret    

0000000000140e6a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  140e6a:	f3 0f 1e fa          	endbr64 
  140e6e:	55                   	push   %rbp
  140e6f:	48 89 e5             	mov    %rsp,%rbp
  140e72:	48 83 ec 20          	sub    $0x20,%rsp
  140e76:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  140e7a:	89 f0                	mov    %esi,%eax
  140e7c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  140e7f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  140e82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  140e86:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  140e8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  140e8e:	48 8b 40 08          	mov    0x8(%rax),%rax
  140e92:	48 8d 15 07 81 f7 ff 	lea    -0x87ef9(%rip),%rdx        # b8fa0 <console+0xfa0>
  140e99:	48 39 d0             	cmp    %rdx,%rax
  140e9c:	72 0f                	jb     140ead <console_putc+0x43>
        cp->cursor = console;
  140e9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  140ea2:	48 8d 15 57 71 f7 ff 	lea    -0x88ea9(%rip),%rdx        # b8000 <console>
  140ea9:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  140ead:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  140eb1:	0f 85 82 00 00 00    	jne    140f39 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  140eb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  140ebb:	48 8b 40 08          	mov    0x8(%rax),%rax
  140ebf:	48 8d 15 3a 71 f7 ff 	lea    -0x88ec6(%rip),%rdx        # b8000 <console>
  140ec6:	48 29 d0             	sub    %rdx,%rax
  140ec9:	48 d1 f8             	sar    %rax
  140ecc:	48 89 c1             	mov    %rax,%rcx
  140ecf:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  140ed6:	66 66 66 
  140ed9:	48 89 c8             	mov    %rcx,%rax
  140edc:	48 f7 ea             	imul   %rdx
  140edf:	48 89 d0             	mov    %rdx,%rax
  140ee2:	48 c1 f8 05          	sar    $0x5,%rax
  140ee6:	48 89 ce             	mov    %rcx,%rsi
  140ee9:	48 c1 fe 3f          	sar    $0x3f,%rsi
  140eed:	48 29 f0             	sub    %rsi,%rax
  140ef0:	48 89 c2             	mov    %rax,%rdx
  140ef3:	48 89 d0             	mov    %rdx,%rax
  140ef6:	48 c1 e0 02          	shl    $0x2,%rax
  140efa:	48 01 d0             	add    %rdx,%rax
  140efd:	48 c1 e0 04          	shl    $0x4,%rax
  140f01:	48 29 c1             	sub    %rax,%rcx
  140f04:	48 89 ca             	mov    %rcx,%rdx
  140f07:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  140f0a:	eb 25                	jmp    140f31 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  140f0c:	8b 45 e0             	mov    -0x20(%rbp),%eax
  140f0f:	83 c8 20             	or     $0x20,%eax
  140f12:	89 c6                	mov    %eax,%esi
  140f14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  140f18:	48 8b 40 08          	mov    0x8(%rax),%rax
  140f1c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  140f20:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  140f24:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  140f28:	89 f2                	mov    %esi,%edx
  140f2a:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  140f2d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  140f31:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  140f35:	75 d5                	jne    140f0c <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  140f37:	eb 24                	jmp    140f5d <console_putc+0xf3>
        *cp->cursor++ = c | color;
  140f39:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  140f3d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  140f40:	89 d6                	mov    %edx,%esi
  140f42:	09 c6                	or     %eax,%esi
  140f44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  140f48:	48 8b 40 08          	mov    0x8(%rax),%rax
  140f4c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  140f50:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  140f54:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  140f58:	89 f2                	mov    %esi,%edx
  140f5a:	66 89 10             	mov    %dx,(%rax)
}
  140f5d:	90                   	nop
  140f5e:	c9                   	leave  
  140f5f:	c3                   	ret    

0000000000140f60 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  140f60:	f3 0f 1e fa          	endbr64 
  140f64:	55                   	push   %rbp
  140f65:	48 89 e5             	mov    %rsp,%rbp
  140f68:	48 83 ec 30          	sub    $0x30,%rsp
  140f6c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  140f6f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  140f72:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  140f76:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  140f7a:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 140e6a <console_putc>
  140f81:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  140f85:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  140f89:	78 09                	js     140f94 <console_vprintf+0x34>
  140f8b:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  140f92:	7e 07                	jle    140f9b <console_vprintf+0x3b>
        cpos = 0;
  140f94:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  140f9b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  140f9e:	48 98                	cltq   
  140fa0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  140fa4:	48 8d 05 55 70 f7 ff 	lea    -0x88fab(%rip),%rax        # b8000 <console>
  140fab:	48 01 d0             	add    %rdx,%rax
  140fae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  140fb2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  140fb6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  140fba:	8b 75 e8             	mov    -0x18(%rbp),%esi
  140fbd:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  140fc1:	48 89 c7             	mov    %rax,%rdi
  140fc4:	e8 9a f4 ff ff       	call   140463 <printer_vprintf>
    return cp.cursor - console;
  140fc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  140fcd:	48 8d 15 2c 70 f7 ff 	lea    -0x88fd4(%rip),%rdx        # b8000 <console>
  140fd4:	48 29 d0             	sub    %rdx,%rax
  140fd7:	48 d1 f8             	sar    %rax
}
  140fda:	c9                   	leave  
  140fdb:	c3                   	ret    

0000000000140fdc <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  140fdc:	f3 0f 1e fa          	endbr64 
  140fe0:	55                   	push   %rbp
  140fe1:	48 89 e5             	mov    %rsp,%rbp
  140fe4:	48 83 ec 60          	sub    $0x60,%rsp
  140fe8:	89 7d ac             	mov    %edi,-0x54(%rbp)
  140feb:	89 75 a8             	mov    %esi,-0x58(%rbp)
  140fee:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  140ff2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  140ff6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  140ffa:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  140ffe:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  141005:	48 8d 45 10          	lea    0x10(%rbp),%rax
  141009:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  14100d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  141011:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  141015:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  141019:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  14101d:	8b 75 a8             	mov    -0x58(%rbp),%esi
  141020:	8b 45 ac             	mov    -0x54(%rbp),%eax
  141023:	89 c7                	mov    %eax,%edi
  141025:	e8 36 ff ff ff       	call   140f60 <console_vprintf>
  14102a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  14102d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  141030:	c9                   	leave  
  141031:	c3                   	ret    

0000000000141032 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  141032:	f3 0f 1e fa          	endbr64 
  141036:	55                   	push   %rbp
  141037:	48 89 e5             	mov    %rsp,%rbp
  14103a:	48 83 ec 20          	sub    $0x20,%rsp
  14103e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  141042:	89 f0                	mov    %esi,%eax
  141044:	89 55 e0             	mov    %edx,-0x20(%rbp)
  141047:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  14104a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  14104e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  141052:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  141056:	48 8b 50 08          	mov    0x8(%rax),%rdx
  14105a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  14105e:	48 8b 40 10          	mov    0x10(%rax),%rax
  141062:	48 39 c2             	cmp    %rax,%rdx
  141065:	73 1a                	jae    141081 <string_putc+0x4f>
        *sp->s++ = c;
  141067:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  14106b:	48 8b 40 08          	mov    0x8(%rax),%rax
  14106f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  141073:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  141077:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  14107b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  14107f:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  141081:	90                   	nop
  141082:	c9                   	leave  
  141083:	c3                   	ret    

0000000000141084 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  141084:	f3 0f 1e fa          	endbr64 
  141088:	55                   	push   %rbp
  141089:	48 89 e5             	mov    %rsp,%rbp
  14108c:	48 83 ec 40          	sub    $0x40,%rsp
  141090:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  141094:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  141098:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  14109c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1410a0:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 141032 <string_putc>
  1410a7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  1410ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1410af:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1410b3:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1410b8:	74 33                	je     1410ed <vsnprintf+0x69>
        sp.end = s + size - 1;
  1410ba:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1410be:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1410c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1410c6:	48 01 d0             	add    %rdx,%rax
  1410c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1410cd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1410d1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1410d5:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1410d9:	be 00 00 00 00       	mov    $0x0,%esi
  1410de:	48 89 c7             	mov    %rax,%rdi
  1410e1:	e8 7d f3 ff ff       	call   140463 <printer_vprintf>
        *sp.s = 0;
  1410e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1410ea:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1410ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1410f1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1410f5:	c9                   	leave  
  1410f6:	c3                   	ret    

00000000001410f7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1410f7:	f3 0f 1e fa          	endbr64 
  1410fb:	55                   	push   %rbp
  1410fc:	48 89 e5             	mov    %rsp,%rbp
  1410ff:	48 83 ec 70          	sub    $0x70,%rsp
  141103:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  141107:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  14110b:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  14110f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  141113:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  141117:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  14111b:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  141122:	48 8d 45 10          	lea    0x10(%rbp),%rax
  141126:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  14112a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  14112e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  141132:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  141136:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  14113a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  14113e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  141142:	48 89 c7             	mov    %rax,%rdi
  141145:	e8 3a ff ff ff       	call   141084 <vsnprintf>
  14114a:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  14114d:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  141150:	c9                   	leave  
  141151:	c3                   	ret    

0000000000141152 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  141152:	f3 0f 1e fa          	endbr64 
  141156:	55                   	push   %rbp
  141157:	48 89 e5             	mov    %rsp,%rbp
  14115a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  14115e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  141165:	eb 1a                	jmp    141181 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  141167:	8b 45 fc             	mov    -0x4(%rbp),%eax
  14116a:	48 98                	cltq   
  14116c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  141170:	48 8d 05 89 6e f7 ff 	lea    -0x89177(%rip),%rax        # b8000 <console>
  141177:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  14117d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  141181:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  141188:	7e dd                	jle    141167 <console_clear+0x15>
    }
    cursorpos = 0;
  14118a:	c7 05 68 7e f7 ff 00 	movl   $0x0,-0x88198(%rip)        # b8ffc <cursorpos>
  141191:	00 00 00 
}
  141194:	90                   	nop
  141195:	c9                   	leave  
  141196:	c3                   	ret    
