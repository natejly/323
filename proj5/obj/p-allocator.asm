
obj/p-allocator.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t* stack_bottom;

// Program that starts allocating page by page from its heap
// till it reaches stack OR runs out of memory

void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	53                   	push   %rbx
  100009:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000d:	cd 31                	int    $0x31
  10000f:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  100011:	89 c7                	mov    %eax,%edi
  100013:	e8 9a 03 00 00       	call   1003b2 <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100018:	48 8d 05 f8 2f 00 00 	lea    0x2ff8(%rip),%rax        # 103017 <end+0xfff>
  10001f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100025:	48 89 05 dc 1f 00 00 	mov    %rax,0x1fdc(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10002c:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  10002f:	48 83 e8 01          	sub    $0x1,%rax
  100033:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100039:	48 89 05 c0 1f 00 00 	mov    %rax,0x1fc0(%rip)        # 102000 <stack_bottom>
  100040:	eb 02                	jmp    100044 <process_main+0x44>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  100042:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  100044:	e8 29 03 00 00       	call   100372 <rand>
  100049:	48 63 d0             	movslq %eax,%rdx
  10004c:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100053:	48 c1 fa 25          	sar    $0x25,%rdx
  100057:	89 c1                	mov    %eax,%ecx
  100059:	c1 f9 1f             	sar    $0x1f,%ecx
  10005c:	29 ca                	sub    %ecx,%edx
  10005e:	6b d2 64             	imul   $0x64,%edx,%edx
  100061:	29 d0                	sub    %edx,%eax
  100063:	39 d8                	cmp    %ebx,%eax
  100065:	7d db                	jge    100042 <process_main+0x42>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  100067:	48 8b 3d 9a 1f 00 00 	mov    0x1f9a(%rip),%rdi        # 102008 <heap_top>
  10006e:	48 3b 3d 8b 1f 00 00 	cmp    0x1f8b(%rip),%rdi        # 102000 <stack_bottom>
  100075:	74 1c                	je     100093 <process_main+0x93>
//    Allocate a page of memory at address `addr` and allow process to
//    write to it. `Addr` must be page-aligned (i.e., a multiple of
//    PAGESIZE == 4096). Returns 0 on success and -1 on failure.
static inline int sys_page_alloc(void* addr) {
    int result;
    asm volatile ("int %1" : "=a" (result)
  100077:	cd 33                	int    $0x33
  100079:	85 c0                	test   %eax,%eax
  10007b:	78 16                	js     100093 <process_main+0x93>
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
  10007d:	48 8b 05 84 1f 00 00 	mov    0x1f84(%rip),%rax        # 102008 <heap_top>
  100084:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  100086:	48 81 05 77 1f 00 00 	addq   $0x1000,0x1f77(%rip)        # 102008 <heap_top>
  10008d:	00 10 00 00 
  100091:	eb af                	jmp    100042 <process_main+0x42>
    asm volatile ("int %0" : /* no result */
  100093:	cd 32                	int    $0x32
  100095:	eb fc                	jmp    100093 <process_main+0x93>

0000000000100097 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100097:	f3 0f 1e fa          	endbr64 
  10009b:	55                   	push   %rbp
  10009c:	48 89 e5             	mov    %rsp,%rbp
  10009f:	48 83 ec 28          	sub    $0x28,%rsp
  1000a3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1000a7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1000ab:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1000af:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1000b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1000b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1000bb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1000bf:	eb 1c                	jmp    1000dd <memcpy+0x46>
        *d = *s;
  1000c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1000c5:	0f b6 10             	movzbl (%rax),%edx
  1000c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1000cc:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1000ce:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1000d3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1000d8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1000dd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1000e2:	75 dd                	jne    1000c1 <memcpy+0x2a>
    }
    return dst;
  1000e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1000e8:	c9                   	leave  
  1000e9:	c3                   	ret    

00000000001000ea <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1000ea:	f3 0f 1e fa          	endbr64 
  1000ee:	55                   	push   %rbp
  1000ef:	48 89 e5             	mov    %rsp,%rbp
  1000f2:	48 83 ec 28          	sub    $0x28,%rsp
  1000f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1000fa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1000fe:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100102:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100106:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10010a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10010e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100112:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100116:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10011a:	73 6a                	jae    100186 <memmove+0x9c>
  10011c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100120:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100124:	48 01 d0             	add    %rdx,%rax
  100127:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  10012b:	73 59                	jae    100186 <memmove+0x9c>
        s += n, d += n;
  10012d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100131:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100135:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100139:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  10013d:	eb 17                	jmp    100156 <memmove+0x6c>
            *--d = *--s;
  10013f:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100144:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100149:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10014d:	0f b6 10             	movzbl (%rax),%edx
  100150:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100154:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100156:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10015a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10015e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100162:	48 85 c0             	test   %rax,%rax
  100165:	75 d8                	jne    10013f <memmove+0x55>
    if (s < d && s + n > d) {
  100167:	eb 2e                	jmp    100197 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100169:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10016d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100171:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100175:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100179:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10017d:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100181:	0f b6 12             	movzbl (%rdx),%edx
  100184:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100186:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10018a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10018e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100192:	48 85 c0             	test   %rax,%rax
  100195:	75 d2                	jne    100169 <memmove+0x7f>
        }
    }
    return dst;
  100197:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10019b:	c9                   	leave  
  10019c:	c3                   	ret    

000000000010019d <memset>:

void* memset(void* v, int c, size_t n) {
  10019d:	f3 0f 1e fa          	endbr64 
  1001a1:	55                   	push   %rbp
  1001a2:	48 89 e5             	mov    %rsp,%rbp
  1001a5:	48 83 ec 28          	sub    $0x28,%rsp
  1001a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1001ad:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1001b0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1001b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1001b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1001bc:	eb 15                	jmp    1001d3 <memset+0x36>
        *p = c;
  1001be:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1001c1:	89 c2                	mov    %eax,%edx
  1001c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1001c7:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1001c9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1001ce:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1001d3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1001d8:	75 e4                	jne    1001be <memset+0x21>
    }
    return v;
  1001da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1001de:	c9                   	leave  
  1001df:	c3                   	ret    

00000000001001e0 <strlen>:

size_t strlen(const char* s) {
  1001e0:	f3 0f 1e fa          	endbr64 
  1001e4:	55                   	push   %rbp
  1001e5:	48 89 e5             	mov    %rsp,%rbp
  1001e8:	48 83 ec 18          	sub    $0x18,%rsp
  1001ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1001f0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1001f7:	00 
  1001f8:	eb 0a                	jmp    100204 <strlen+0x24>
        ++n;
  1001fa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1001ff:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100204:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100208:	0f b6 00             	movzbl (%rax),%eax
  10020b:	84 c0                	test   %al,%al
  10020d:	75 eb                	jne    1001fa <strlen+0x1a>
    }
    return n;
  10020f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100213:	c9                   	leave  
  100214:	c3                   	ret    

0000000000100215 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100215:	f3 0f 1e fa          	endbr64 
  100219:	55                   	push   %rbp
  10021a:	48 89 e5             	mov    %rsp,%rbp
  10021d:	48 83 ec 20          	sub    $0x20,%rsp
  100221:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100225:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100229:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100230:	00 
  100231:	eb 0a                	jmp    10023d <strnlen+0x28>
        ++n;
  100233:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100238:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10023d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100241:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100245:	74 0b                	je     100252 <strnlen+0x3d>
  100247:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10024b:	0f b6 00             	movzbl (%rax),%eax
  10024e:	84 c0                	test   %al,%al
  100250:	75 e1                	jne    100233 <strnlen+0x1e>
    }
    return n;
  100252:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100256:	c9                   	leave  
  100257:	c3                   	ret    

0000000000100258 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100258:	f3 0f 1e fa          	endbr64 
  10025c:	55                   	push   %rbp
  10025d:	48 89 e5             	mov    %rsp,%rbp
  100260:	48 83 ec 20          	sub    $0x20,%rsp
  100264:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100268:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  10026c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100270:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100274:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100278:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10027c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100280:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100284:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100288:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  10028c:	0f b6 12             	movzbl (%rdx),%edx
  10028f:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100291:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100295:	48 83 e8 01          	sub    $0x1,%rax
  100299:	0f b6 00             	movzbl (%rax),%eax
  10029c:	84 c0                	test   %al,%al
  10029e:	75 d4                	jne    100274 <strcpy+0x1c>
    return dst;
  1002a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1002a4:	c9                   	leave  
  1002a5:	c3                   	ret    

00000000001002a6 <strcmp>:

int strcmp(const char* a, const char* b) {
  1002a6:	f3 0f 1e fa          	endbr64 
  1002aa:	55                   	push   %rbp
  1002ab:	48 89 e5             	mov    %rsp,%rbp
  1002ae:	48 83 ec 10          	sub    $0x10,%rsp
  1002b2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1002b6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1002ba:	eb 0a                	jmp    1002c6 <strcmp+0x20>
        ++a, ++b;
  1002bc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1002c1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1002c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002ca:	0f b6 00             	movzbl (%rax),%eax
  1002cd:	84 c0                	test   %al,%al
  1002cf:	74 1d                	je     1002ee <strcmp+0x48>
  1002d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002d5:	0f b6 00             	movzbl (%rax),%eax
  1002d8:	84 c0                	test   %al,%al
  1002da:	74 12                	je     1002ee <strcmp+0x48>
  1002dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002e0:	0f b6 10             	movzbl (%rax),%edx
  1002e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002e7:	0f b6 00             	movzbl (%rax),%eax
  1002ea:	38 c2                	cmp    %al,%dl
  1002ec:	74 ce                	je     1002bc <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1002ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002f2:	0f b6 00             	movzbl (%rax),%eax
  1002f5:	89 c2                	mov    %eax,%edx
  1002f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002fb:	0f b6 00             	movzbl (%rax),%eax
  1002fe:	38 c2                	cmp    %al,%dl
  100300:	0f 97 c0             	seta   %al
  100303:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100306:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10030a:	0f b6 00             	movzbl (%rax),%eax
  10030d:	89 c1                	mov    %eax,%ecx
  10030f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100313:	0f b6 00             	movzbl (%rax),%eax
  100316:	38 c1                	cmp    %al,%cl
  100318:	0f 92 c0             	setb   %al
  10031b:	0f b6 c8             	movzbl %al,%ecx
  10031e:	89 d0                	mov    %edx,%eax
  100320:	29 c8                	sub    %ecx,%eax
}
  100322:	c9                   	leave  
  100323:	c3                   	ret    

0000000000100324 <strchr>:

char* strchr(const char* s, int c) {
  100324:	f3 0f 1e fa          	endbr64 
  100328:	55                   	push   %rbp
  100329:	48 89 e5             	mov    %rsp,%rbp
  10032c:	48 83 ec 10          	sub    $0x10,%rsp
  100330:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100334:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100337:	eb 05                	jmp    10033e <strchr+0x1a>
        ++s;
  100339:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  10033e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100342:	0f b6 00             	movzbl (%rax),%eax
  100345:	84 c0                	test   %al,%al
  100347:	74 0e                	je     100357 <strchr+0x33>
  100349:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10034d:	0f b6 00             	movzbl (%rax),%eax
  100350:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100353:	38 d0                	cmp    %dl,%al
  100355:	75 e2                	jne    100339 <strchr+0x15>
    }
    if (*s == (char) c) {
  100357:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10035b:	0f b6 00             	movzbl (%rax),%eax
  10035e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100361:	38 d0                	cmp    %dl,%al
  100363:	75 06                	jne    10036b <strchr+0x47>
        return (char*) s;
  100365:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100369:	eb 05                	jmp    100370 <strchr+0x4c>
    } else {
        return NULL;
  10036b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100370:	c9                   	leave  
  100371:	c3                   	ret    

0000000000100372 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100372:	f3 0f 1e fa          	endbr64 
  100376:	55                   	push   %rbp
  100377:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  10037a:	8b 05 90 1c 00 00    	mov    0x1c90(%rip),%eax        # 102010 <rand_seed_set>
  100380:	85 c0                	test   %eax,%eax
  100382:	75 0a                	jne    10038e <rand+0x1c>
        srand(819234718U);
  100384:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100389:	e8 24 00 00 00       	call   1003b2 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  10038e:	8b 05 80 1c 00 00    	mov    0x1c80(%rip),%eax        # 102014 <rand_seed>
  100394:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  10039a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10039f:	89 05 6f 1c 00 00    	mov    %eax,0x1c6f(%rip)        # 102014 <rand_seed>
    return rand_seed & RAND_MAX;
  1003a5:	8b 05 69 1c 00 00    	mov    0x1c69(%rip),%eax        # 102014 <rand_seed>
  1003ab:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1003b0:	5d                   	pop    %rbp
  1003b1:	c3                   	ret    

00000000001003b2 <srand>:

void srand(unsigned seed) {
  1003b2:	f3 0f 1e fa          	endbr64 
  1003b6:	55                   	push   %rbp
  1003b7:	48 89 e5             	mov    %rsp,%rbp
  1003ba:	48 83 ec 08          	sub    $0x8,%rsp
  1003be:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1003c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1003c4:	89 05 4a 1c 00 00    	mov    %eax,0x1c4a(%rip)        # 102014 <rand_seed>
    rand_seed_set = 1;
  1003ca:	c7 05 3c 1c 00 00 01 	movl   $0x1,0x1c3c(%rip)        # 102010 <rand_seed_set>
  1003d1:	00 00 00 
}
  1003d4:	90                   	nop
  1003d5:	c9                   	leave  
  1003d6:	c3                   	ret    

00000000001003d7 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1003d7:	f3 0f 1e fa          	endbr64 
  1003db:	55                   	push   %rbp
  1003dc:	48 89 e5             	mov    %rsp,%rbp
  1003df:	48 83 ec 28          	sub    $0x28,%rsp
  1003e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003e7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1003eb:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1003ee:	48 8d 05 ab 0e 00 00 	lea    0xeab(%rip),%rax        # 1012a0 <upper_digits.1>
  1003f5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  1003f9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1003fd:	79 0e                	jns    10040d <fill_numbuf+0x36>
        digits = lower_digits;
  1003ff:	48 8d 05 ba 0e 00 00 	lea    0xeba(%rip),%rax        # 1012c0 <lower_digits.0>
  100406:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  10040a:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  10040d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100412:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100416:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100419:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10041c:	48 63 c8             	movslq %eax,%rcx
  10041f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100423:	ba 00 00 00 00       	mov    $0x0,%edx
  100428:	48 f7 f1             	div    %rcx
  10042b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10042f:	48 01 d0             	add    %rdx,%rax
  100432:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100437:	0f b6 10             	movzbl (%rax),%edx
  10043a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10043e:	88 10                	mov    %dl,(%rax)
        val /= base;
  100440:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100443:	48 63 f0             	movslq %eax,%rsi
  100446:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10044a:	ba 00 00 00 00       	mov    $0x0,%edx
  10044f:	48 f7 f6             	div    %rsi
  100452:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100456:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  10045b:	75 bc                	jne    100419 <fill_numbuf+0x42>
    return numbuf_end;
  10045d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100461:	c9                   	leave  
  100462:	c3                   	ret    

0000000000100463 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100463:	f3 0f 1e fa          	endbr64 
  100467:	55                   	push   %rbp
  100468:	48 89 e5             	mov    %rsp,%rbp
  10046b:	53                   	push   %rbx
  10046c:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100473:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  10047a:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100480:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100487:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  10048e:	e9 bd 09 00 00       	jmp    100e50 <printer_vprintf+0x9ed>
        if (*format != '%') {
  100493:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10049a:	0f b6 00             	movzbl (%rax),%eax
  10049d:	3c 25                	cmp    $0x25,%al
  10049f:	74 31                	je     1004d2 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  1004a1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1004a8:	4c 8b 00             	mov    (%rax),%r8
  1004ab:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1004b2:	0f b6 00             	movzbl (%rax),%eax
  1004b5:	0f b6 c8             	movzbl %al,%ecx
  1004b8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1004be:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1004c5:	89 ce                	mov    %ecx,%esi
  1004c7:	48 89 c7             	mov    %rax,%rdi
  1004ca:	41 ff d0             	call   *%r8
            continue;
  1004cd:	e9 76 09 00 00       	jmp    100e48 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  1004d2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1004d9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1004e0:	01 
  1004e1:	eb 4d                	jmp    100530 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  1004e3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1004ea:	0f b6 00             	movzbl (%rax),%eax
  1004ed:	0f be c0             	movsbl %al,%eax
  1004f0:	89 c6                	mov    %eax,%esi
  1004f2:	48 8d 05 a7 0c 00 00 	lea    0xca7(%rip),%rax        # 1011a0 <flag_chars>
  1004f9:	48 89 c7             	mov    %rax,%rdi
  1004fc:	e8 23 fe ff ff       	call   100324 <strchr>
  100501:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100505:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10050a:	74 34                	je     100540 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  10050c:	48 8d 15 8d 0c 00 00 	lea    0xc8d(%rip),%rdx        # 1011a0 <flag_chars>
  100513:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100517:	48 29 d0             	sub    %rdx,%rax
  10051a:	ba 01 00 00 00       	mov    $0x1,%edx
  10051f:	89 c1                	mov    %eax,%ecx
  100521:	d3 e2                	shl    %cl,%edx
  100523:	89 d0                	mov    %edx,%eax
  100525:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100528:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10052f:	01 
  100530:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100537:	0f b6 00             	movzbl (%rax),%eax
  10053a:	84 c0                	test   %al,%al
  10053c:	75 a5                	jne    1004e3 <printer_vprintf+0x80>
  10053e:	eb 01                	jmp    100541 <printer_vprintf+0xde>
            } else {
                break;
  100540:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100541:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100548:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10054f:	0f b6 00             	movzbl (%rax),%eax
  100552:	3c 30                	cmp    $0x30,%al
  100554:	7e 67                	jle    1005bd <printer_vprintf+0x15a>
  100556:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10055d:	0f b6 00             	movzbl (%rax),%eax
  100560:	3c 39                	cmp    $0x39,%al
  100562:	7f 59                	jg     1005bd <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100564:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  10056b:	eb 2e                	jmp    10059b <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  10056d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100570:	89 d0                	mov    %edx,%eax
  100572:	c1 e0 02             	shl    $0x2,%eax
  100575:	01 d0                	add    %edx,%eax
  100577:	01 c0                	add    %eax,%eax
  100579:	89 c1                	mov    %eax,%ecx
  10057b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100582:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100586:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10058d:	0f b6 00             	movzbl (%rax),%eax
  100590:	0f be c0             	movsbl %al,%eax
  100593:	01 c8                	add    %ecx,%eax
  100595:	83 e8 30             	sub    $0x30,%eax
  100598:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10059b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005a2:	0f b6 00             	movzbl (%rax),%eax
  1005a5:	3c 2f                	cmp    $0x2f,%al
  1005a7:	0f 8e 85 00 00 00    	jle    100632 <printer_vprintf+0x1cf>
  1005ad:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005b4:	0f b6 00             	movzbl (%rax),%eax
  1005b7:	3c 39                	cmp    $0x39,%al
  1005b9:	7e b2                	jle    10056d <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  1005bb:	eb 75                	jmp    100632 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  1005bd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005c4:	0f b6 00             	movzbl (%rax),%eax
  1005c7:	3c 2a                	cmp    $0x2a,%al
  1005c9:	75 68                	jne    100633 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  1005cb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1005d2:	8b 00                	mov    (%rax),%eax
  1005d4:	83 f8 2f             	cmp    $0x2f,%eax
  1005d7:	77 30                	ja     100609 <printer_vprintf+0x1a6>
  1005d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1005e0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1005e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1005eb:	8b 00                	mov    (%rax),%eax
  1005ed:	89 c0                	mov    %eax,%eax
  1005ef:	48 01 d0             	add    %rdx,%rax
  1005f2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1005f9:	8b 12                	mov    (%rdx),%edx
  1005fb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1005fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100605:	89 0a                	mov    %ecx,(%rdx)
  100607:	eb 1a                	jmp    100623 <printer_vprintf+0x1c0>
  100609:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100610:	48 8b 40 08          	mov    0x8(%rax),%rax
  100614:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100618:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10061f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100623:	8b 00                	mov    (%rax),%eax
  100625:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100628:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10062f:	01 
  100630:	eb 01                	jmp    100633 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  100632:	90                   	nop
        }

        // process precision
        int precision = -1;
  100633:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  10063a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100641:	0f b6 00             	movzbl (%rax),%eax
  100644:	3c 2e                	cmp    $0x2e,%al
  100646:	0f 85 00 01 00 00    	jne    10074c <printer_vprintf+0x2e9>
            ++format;
  10064c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100653:	01 
            if (*format >= '0' && *format <= '9') {
  100654:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10065b:	0f b6 00             	movzbl (%rax),%eax
  10065e:	3c 2f                	cmp    $0x2f,%al
  100660:	7e 67                	jle    1006c9 <printer_vprintf+0x266>
  100662:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100669:	0f b6 00             	movzbl (%rax),%eax
  10066c:	3c 39                	cmp    $0x39,%al
  10066e:	7f 59                	jg     1006c9 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100670:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100677:	eb 2e                	jmp    1006a7 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  100679:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  10067c:	89 d0                	mov    %edx,%eax
  10067e:	c1 e0 02             	shl    $0x2,%eax
  100681:	01 d0                	add    %edx,%eax
  100683:	01 c0                	add    %eax,%eax
  100685:	89 c1                	mov    %eax,%ecx
  100687:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10068e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100692:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100699:	0f b6 00             	movzbl (%rax),%eax
  10069c:	0f be c0             	movsbl %al,%eax
  10069f:	01 c8                	add    %ecx,%eax
  1006a1:	83 e8 30             	sub    $0x30,%eax
  1006a4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1006a7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006ae:	0f b6 00             	movzbl (%rax),%eax
  1006b1:	3c 2f                	cmp    $0x2f,%al
  1006b3:	0f 8e 85 00 00 00    	jle    10073e <printer_vprintf+0x2db>
  1006b9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006c0:	0f b6 00             	movzbl (%rax),%eax
  1006c3:	3c 39                	cmp    $0x39,%al
  1006c5:	7e b2                	jle    100679 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  1006c7:	eb 75                	jmp    10073e <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  1006c9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006d0:	0f b6 00             	movzbl (%rax),%eax
  1006d3:	3c 2a                	cmp    $0x2a,%al
  1006d5:	75 68                	jne    10073f <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  1006d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006de:	8b 00                	mov    (%rax),%eax
  1006e0:	83 f8 2f             	cmp    $0x2f,%eax
  1006e3:	77 30                	ja     100715 <printer_vprintf+0x2b2>
  1006e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006ec:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1006f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006f7:	8b 00                	mov    (%rax),%eax
  1006f9:	89 c0                	mov    %eax,%eax
  1006fb:	48 01 d0             	add    %rdx,%rax
  1006fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100705:	8b 12                	mov    (%rdx),%edx
  100707:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10070a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100711:	89 0a                	mov    %ecx,(%rdx)
  100713:	eb 1a                	jmp    10072f <printer_vprintf+0x2cc>
  100715:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10071c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100720:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100724:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10072b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10072f:	8b 00                	mov    (%rax),%eax
  100731:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100734:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10073b:	01 
  10073c:	eb 01                	jmp    10073f <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  10073e:	90                   	nop
            }
            if (precision < 0) {
  10073f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100743:	79 07                	jns    10074c <printer_vprintf+0x2e9>
                precision = 0;
  100745:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  10074c:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100753:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  10075a:	00 
        int length = 0;
  10075b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100762:	48 8d 05 3d 0a 00 00 	lea    0xa3d(%rip),%rax        # 1011a6 <flag_chars+0x6>
  100769:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  10076d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100774:	0f b6 00             	movzbl (%rax),%eax
  100777:	0f be c0             	movsbl %al,%eax
  10077a:	83 e8 43             	sub    $0x43,%eax
  10077d:	83 f8 37             	cmp    $0x37,%eax
  100780:	0f 87 b6 03 00 00    	ja     100b3c <printer_vprintf+0x6d9>
  100786:	89 c0                	mov    %eax,%eax
  100788:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  10078f:	00 
  100790:	48 8d 05 1d 0a 00 00 	lea    0xa1d(%rip),%rax        # 1011b4 <flag_chars+0x14>
  100797:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  10079a:	48 98                	cltq   
  10079c:	48 8d 15 11 0a 00 00 	lea    0xa11(%rip),%rdx        # 1011b4 <flag_chars+0x14>
  1007a3:	48 01 d0             	add    %rdx,%rax
  1007a6:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  1007a9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1007b0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007b7:	01 
            goto again;
  1007b8:	eb b3                	jmp    10076d <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1007ba:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1007be:	74 5d                	je     10081d <printer_vprintf+0x3ba>
  1007c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007c7:	8b 00                	mov    (%rax),%eax
  1007c9:	83 f8 2f             	cmp    $0x2f,%eax
  1007cc:	77 30                	ja     1007fe <printer_vprintf+0x39b>
  1007ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007d5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1007d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007e0:	8b 00                	mov    (%rax),%eax
  1007e2:	89 c0                	mov    %eax,%eax
  1007e4:	48 01 d0             	add    %rdx,%rax
  1007e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007ee:	8b 12                	mov    (%rdx),%edx
  1007f0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1007f3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007fa:	89 0a                	mov    %ecx,(%rdx)
  1007fc:	eb 1a                	jmp    100818 <printer_vprintf+0x3b5>
  1007fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100805:	48 8b 40 08          	mov    0x8(%rax),%rax
  100809:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10080d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100814:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100818:	48 8b 00             	mov    (%rax),%rax
  10081b:	eb 5c                	jmp    100879 <printer_vprintf+0x416>
  10081d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100824:	8b 00                	mov    (%rax),%eax
  100826:	83 f8 2f             	cmp    $0x2f,%eax
  100829:	77 30                	ja     10085b <printer_vprintf+0x3f8>
  10082b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100832:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100836:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10083d:	8b 00                	mov    (%rax),%eax
  10083f:	89 c0                	mov    %eax,%eax
  100841:	48 01 d0             	add    %rdx,%rax
  100844:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10084b:	8b 12                	mov    (%rdx),%edx
  10084d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100850:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100857:	89 0a                	mov    %ecx,(%rdx)
  100859:	eb 1a                	jmp    100875 <printer_vprintf+0x412>
  10085b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100862:	48 8b 40 08          	mov    0x8(%rax),%rax
  100866:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10086a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100871:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100875:	8b 00                	mov    (%rax),%eax
  100877:	48 98                	cltq   
  100879:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  10087d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100881:	48 c1 f8 38          	sar    $0x38,%rax
  100885:	25 80 00 00 00       	and    $0x80,%eax
  10088a:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  10088d:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100891:	74 09                	je     10089c <printer_vprintf+0x439>
  100893:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100897:	48 f7 d8             	neg    %rax
  10089a:	eb 04                	jmp    1008a0 <printer_vprintf+0x43d>
  10089c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1008a0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1008a4:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  1008a7:	83 c8 60             	or     $0x60,%eax
  1008aa:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  1008ad:	e9 cf 02 00 00       	jmp    100b81 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1008b2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1008b6:	74 5d                	je     100915 <printer_vprintf+0x4b2>
  1008b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008bf:	8b 00                	mov    (%rax),%eax
  1008c1:	83 f8 2f             	cmp    $0x2f,%eax
  1008c4:	77 30                	ja     1008f6 <printer_vprintf+0x493>
  1008c6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008cd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1008d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008d8:	8b 00                	mov    (%rax),%eax
  1008da:	89 c0                	mov    %eax,%eax
  1008dc:	48 01 d0             	add    %rdx,%rax
  1008df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008e6:	8b 12                	mov    (%rdx),%edx
  1008e8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1008eb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008f2:	89 0a                	mov    %ecx,(%rdx)
  1008f4:	eb 1a                	jmp    100910 <printer_vprintf+0x4ad>
  1008f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008fd:	48 8b 40 08          	mov    0x8(%rax),%rax
  100901:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100905:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10090c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100910:	48 8b 00             	mov    (%rax),%rax
  100913:	eb 5c                	jmp    100971 <printer_vprintf+0x50e>
  100915:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10091c:	8b 00                	mov    (%rax),%eax
  10091e:	83 f8 2f             	cmp    $0x2f,%eax
  100921:	77 30                	ja     100953 <printer_vprintf+0x4f0>
  100923:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10092a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10092e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100935:	8b 00                	mov    (%rax),%eax
  100937:	89 c0                	mov    %eax,%eax
  100939:	48 01 d0             	add    %rdx,%rax
  10093c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100943:	8b 12                	mov    (%rdx),%edx
  100945:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100948:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10094f:	89 0a                	mov    %ecx,(%rdx)
  100951:	eb 1a                	jmp    10096d <printer_vprintf+0x50a>
  100953:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10095a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10095e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100962:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100969:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10096d:	8b 00                	mov    (%rax),%eax
  10096f:	89 c0                	mov    %eax,%eax
  100971:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100975:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100979:	e9 03 02 00 00       	jmp    100b81 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  10097e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100985:	e9 28 ff ff ff       	jmp    1008b2 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  10098a:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100991:	e9 1c ff ff ff       	jmp    1008b2 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100996:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10099d:	8b 00                	mov    (%rax),%eax
  10099f:	83 f8 2f             	cmp    $0x2f,%eax
  1009a2:	77 30                	ja     1009d4 <printer_vprintf+0x571>
  1009a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009ab:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009af:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009b6:	8b 00                	mov    (%rax),%eax
  1009b8:	89 c0                	mov    %eax,%eax
  1009ba:	48 01 d0             	add    %rdx,%rax
  1009bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009c4:	8b 12                	mov    (%rdx),%edx
  1009c6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009d0:	89 0a                	mov    %ecx,(%rdx)
  1009d2:	eb 1a                	jmp    1009ee <printer_vprintf+0x58b>
  1009d4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009db:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009df:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009ea:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009ee:	48 8b 00             	mov    (%rax),%rax
  1009f1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1009f5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1009fc:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100a03:	e9 79 01 00 00       	jmp    100b81 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100a08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a0f:	8b 00                	mov    (%rax),%eax
  100a11:	83 f8 2f             	cmp    $0x2f,%eax
  100a14:	77 30                	ja     100a46 <printer_vprintf+0x5e3>
  100a16:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a1d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a21:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a28:	8b 00                	mov    (%rax),%eax
  100a2a:	89 c0                	mov    %eax,%eax
  100a2c:	48 01 d0             	add    %rdx,%rax
  100a2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a36:	8b 12                	mov    (%rdx),%edx
  100a38:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a3b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a42:	89 0a                	mov    %ecx,(%rdx)
  100a44:	eb 1a                	jmp    100a60 <printer_vprintf+0x5fd>
  100a46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a4d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a51:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a55:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a5c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a60:	48 8b 00             	mov    (%rax),%rax
  100a63:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100a67:	e9 15 01 00 00       	jmp    100b81 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100a6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a73:	8b 00                	mov    (%rax),%eax
  100a75:	83 f8 2f             	cmp    $0x2f,%eax
  100a78:	77 30                	ja     100aaa <printer_vprintf+0x647>
  100a7a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a81:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a8c:	8b 00                	mov    (%rax),%eax
  100a8e:	89 c0                	mov    %eax,%eax
  100a90:	48 01 d0             	add    %rdx,%rax
  100a93:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a9a:	8b 12                	mov    (%rdx),%edx
  100a9c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a9f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aa6:	89 0a                	mov    %ecx,(%rdx)
  100aa8:	eb 1a                	jmp    100ac4 <printer_vprintf+0x661>
  100aaa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ab1:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ab5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ab9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ac0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ac4:	8b 00                	mov    (%rax),%eax
  100ac6:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100acc:	e9 77 03 00 00       	jmp    100e48 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100ad1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100ad5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100ad9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ae0:	8b 00                	mov    (%rax),%eax
  100ae2:	83 f8 2f             	cmp    $0x2f,%eax
  100ae5:	77 30                	ja     100b17 <printer_vprintf+0x6b4>
  100ae7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aee:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100af2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af9:	8b 00                	mov    (%rax),%eax
  100afb:	89 c0                	mov    %eax,%eax
  100afd:	48 01 d0             	add    %rdx,%rax
  100b00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b07:	8b 12                	mov    (%rdx),%edx
  100b09:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b13:	89 0a                	mov    %ecx,(%rdx)
  100b15:	eb 1a                	jmp    100b31 <printer_vprintf+0x6ce>
  100b17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b1e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b22:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b26:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b2d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b31:	8b 00                	mov    (%rax),%eax
  100b33:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100b36:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100b3a:	eb 45                	jmp    100b81 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100b3c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100b40:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100b44:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b4b:	0f b6 00             	movzbl (%rax),%eax
  100b4e:	84 c0                	test   %al,%al
  100b50:	74 0c                	je     100b5e <printer_vprintf+0x6fb>
  100b52:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b59:	0f b6 00             	movzbl (%rax),%eax
  100b5c:	eb 05                	jmp    100b63 <printer_vprintf+0x700>
  100b5e:	b8 25 00 00 00       	mov    $0x25,%eax
  100b63:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100b66:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100b6a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b71:	0f b6 00             	movzbl (%rax),%eax
  100b74:	84 c0                	test   %al,%al
  100b76:	75 08                	jne    100b80 <printer_vprintf+0x71d>
                format--;
  100b78:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100b7f:	01 
            }
            break;
  100b80:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100b81:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100b84:	83 e0 20             	and    $0x20,%eax
  100b87:	85 c0                	test   %eax,%eax
  100b89:	74 1e                	je     100ba9 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100b8b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100b8f:	48 83 c0 18          	add    $0x18,%rax
  100b93:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100b96:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100b9a:	48 89 ce             	mov    %rcx,%rsi
  100b9d:	48 89 c7             	mov    %rax,%rdi
  100ba0:	e8 32 f8 ff ff       	call   1003d7 <fill_numbuf>
  100ba5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100ba9:	48 8d 05 f6 05 00 00 	lea    0x5f6(%rip),%rax        # 1011a6 <flag_chars+0x6>
  100bb0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100bb4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100bb7:	83 e0 20             	and    $0x20,%eax
  100bba:	85 c0                	test   %eax,%eax
  100bbc:	74 51                	je     100c0f <printer_vprintf+0x7ac>
  100bbe:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100bc1:	83 e0 40             	and    $0x40,%eax
  100bc4:	85 c0                	test   %eax,%eax
  100bc6:	74 47                	je     100c0f <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100bc8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100bcb:	25 80 00 00 00       	and    $0x80,%eax
  100bd0:	85 c0                	test   %eax,%eax
  100bd2:	74 0d                	je     100be1 <printer_vprintf+0x77e>
                prefix = "-";
  100bd4:	48 8d 05 cc 05 00 00 	lea    0x5cc(%rip),%rax        # 1011a7 <flag_chars+0x7>
  100bdb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100bdf:	eb 7d                	jmp    100c5e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100be1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100be4:	83 e0 10             	and    $0x10,%eax
  100be7:	85 c0                	test   %eax,%eax
  100be9:	74 0d                	je     100bf8 <printer_vprintf+0x795>
                prefix = "+";
  100beb:	48 8d 05 b7 05 00 00 	lea    0x5b7(%rip),%rax        # 1011a9 <flag_chars+0x9>
  100bf2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100bf6:	eb 66                	jmp    100c5e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100bf8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100bfb:	83 e0 08             	and    $0x8,%eax
  100bfe:	85 c0                	test   %eax,%eax
  100c00:	74 5c                	je     100c5e <printer_vprintf+0x7fb>
                prefix = " ";
  100c02:	48 8d 05 a2 05 00 00 	lea    0x5a2(%rip),%rax        # 1011ab <flag_chars+0xb>
  100c09:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100c0d:	eb 4f                	jmp    100c5e <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100c0f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c12:	83 e0 20             	and    $0x20,%eax
  100c15:	85 c0                	test   %eax,%eax
  100c17:	74 46                	je     100c5f <printer_vprintf+0x7fc>
  100c19:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c1c:	83 e0 01             	and    $0x1,%eax
  100c1f:	85 c0                	test   %eax,%eax
  100c21:	74 3c                	je     100c5f <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100c23:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100c27:	74 06                	je     100c2f <printer_vprintf+0x7cc>
  100c29:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100c2d:	75 30                	jne    100c5f <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100c2f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100c34:	75 0c                	jne    100c42 <printer_vprintf+0x7df>
  100c36:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c39:	25 00 01 00 00       	and    $0x100,%eax
  100c3e:	85 c0                	test   %eax,%eax
  100c40:	74 1d                	je     100c5f <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100c42:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100c46:	75 09                	jne    100c51 <printer_vprintf+0x7ee>
  100c48:	48 8d 05 5e 05 00 00 	lea    0x55e(%rip),%rax        # 1011ad <flag_chars+0xd>
  100c4f:	eb 07                	jmp    100c58 <printer_vprintf+0x7f5>
  100c51:	48 8d 05 58 05 00 00 	lea    0x558(%rip),%rax        # 1011b0 <flag_chars+0x10>
  100c58:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100c5c:	eb 01                	jmp    100c5f <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100c5e:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100c5f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100c63:	78 24                	js     100c89 <printer_vprintf+0x826>
  100c65:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c68:	83 e0 20             	and    $0x20,%eax
  100c6b:	85 c0                	test   %eax,%eax
  100c6d:	75 1a                	jne    100c89 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100c6f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100c72:	48 63 d0             	movslq %eax,%rdx
  100c75:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100c79:	48 89 d6             	mov    %rdx,%rsi
  100c7c:	48 89 c7             	mov    %rax,%rdi
  100c7f:	e8 91 f5 ff ff       	call   100215 <strnlen>
  100c84:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100c87:	eb 0f                	jmp    100c98 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100c89:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100c8d:	48 89 c7             	mov    %rax,%rdi
  100c90:	e8 4b f5 ff ff       	call   1001e0 <strlen>
  100c95:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100c98:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c9b:	83 e0 20             	and    $0x20,%eax
  100c9e:	85 c0                	test   %eax,%eax
  100ca0:	74 20                	je     100cc2 <printer_vprintf+0x85f>
  100ca2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ca6:	78 1a                	js     100cc2 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100ca8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100cab:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100cae:	7e 08                	jle    100cb8 <printer_vprintf+0x855>
  100cb0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100cb3:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100cb6:	eb 05                	jmp    100cbd <printer_vprintf+0x85a>
  100cb8:	b8 00 00 00 00       	mov    $0x0,%eax
  100cbd:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100cc0:	eb 5c                	jmp    100d1e <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100cc2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cc5:	83 e0 20             	and    $0x20,%eax
  100cc8:	85 c0                	test   %eax,%eax
  100cca:	74 4b                	je     100d17 <printer_vprintf+0x8b4>
  100ccc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ccf:	83 e0 02             	and    $0x2,%eax
  100cd2:	85 c0                	test   %eax,%eax
  100cd4:	74 41                	je     100d17 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100cd6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cd9:	83 e0 04             	and    $0x4,%eax
  100cdc:	85 c0                	test   %eax,%eax
  100cde:	75 37                	jne    100d17 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100ce0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ce4:	48 89 c7             	mov    %rax,%rdi
  100ce7:	e8 f4 f4 ff ff       	call   1001e0 <strlen>
  100cec:	89 c2                	mov    %eax,%edx
  100cee:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100cf1:	01 d0                	add    %edx,%eax
  100cf3:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100cf6:	7e 1f                	jle    100d17 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100cf8:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100cfb:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100cfe:	89 c3                	mov    %eax,%ebx
  100d00:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100d04:	48 89 c7             	mov    %rax,%rdi
  100d07:	e8 d4 f4 ff ff       	call   1001e0 <strlen>
  100d0c:	89 c2                	mov    %eax,%edx
  100d0e:	89 d8                	mov    %ebx,%eax
  100d10:	29 d0                	sub    %edx,%eax
  100d12:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100d15:	eb 07                	jmp    100d1e <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100d17:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100d1e:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100d21:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100d24:	01 d0                	add    %edx,%eax
  100d26:	48 63 d8             	movslq %eax,%rbx
  100d29:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100d2d:	48 89 c7             	mov    %rax,%rdi
  100d30:	e8 ab f4 ff ff       	call   1001e0 <strlen>
  100d35:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100d39:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100d3c:	29 d0                	sub    %edx,%eax
  100d3e:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100d41:	eb 25                	jmp    100d68 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  100d43:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d4a:	48 8b 08             	mov    (%rax),%rcx
  100d4d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100d53:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d5a:	be 20 00 00 00       	mov    $0x20,%esi
  100d5f:	48 89 c7             	mov    %rax,%rdi
  100d62:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100d64:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100d68:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d6b:	83 e0 04             	and    $0x4,%eax
  100d6e:	85 c0                	test   %eax,%eax
  100d70:	75 36                	jne    100da8 <printer_vprintf+0x945>
  100d72:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100d76:	7f cb                	jg     100d43 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  100d78:	eb 2e                	jmp    100da8 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  100d7a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d81:	4c 8b 00             	mov    (%rax),%r8
  100d84:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100d88:	0f b6 00             	movzbl (%rax),%eax
  100d8b:	0f b6 c8             	movzbl %al,%ecx
  100d8e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100d94:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d9b:	89 ce                	mov    %ecx,%esi
  100d9d:	48 89 c7             	mov    %rax,%rdi
  100da0:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100da3:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100da8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100dac:	0f b6 00             	movzbl (%rax),%eax
  100daf:	84 c0                	test   %al,%al
  100db1:	75 c7                	jne    100d7a <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  100db3:	eb 25                	jmp    100dda <printer_vprintf+0x977>
            p->putc(p, '0', color);
  100db5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100dbc:	48 8b 08             	mov    (%rax),%rcx
  100dbf:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100dc5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100dcc:	be 30 00 00 00       	mov    $0x30,%esi
  100dd1:	48 89 c7             	mov    %rax,%rdi
  100dd4:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100dd6:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100dda:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100dde:	7f d5                	jg     100db5 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  100de0:	eb 32                	jmp    100e14 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  100de2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100de9:	4c 8b 00             	mov    (%rax),%r8
  100dec:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100df0:	0f b6 00             	movzbl (%rax),%eax
  100df3:	0f b6 c8             	movzbl %al,%ecx
  100df6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100dfc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e03:	89 ce                	mov    %ecx,%esi
  100e05:	48 89 c7             	mov    %rax,%rdi
  100e08:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100e0b:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100e10:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100e14:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100e18:	7f c8                	jg     100de2 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  100e1a:	eb 25                	jmp    100e41 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  100e1c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e23:	48 8b 08             	mov    (%rax),%rcx
  100e26:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e2c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e33:	be 20 00 00 00       	mov    $0x20,%esi
  100e38:	48 89 c7             	mov    %rax,%rdi
  100e3b:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100e3d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100e41:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100e45:	7f d5                	jg     100e1c <printer_vprintf+0x9b9>
        }
    done: ;
  100e47:	90                   	nop
    for (; *format; ++format) {
  100e48:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100e4f:	01 
  100e50:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e57:	0f b6 00             	movzbl (%rax),%eax
  100e5a:	84 c0                	test   %al,%al
  100e5c:	0f 85 31 f6 ff ff    	jne    100493 <printer_vprintf+0x30>
    }
}
  100e62:	90                   	nop
  100e63:	90                   	nop
  100e64:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100e68:	c9                   	leave  
  100e69:	c3                   	ret    

0000000000100e6a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100e6a:	f3 0f 1e fa          	endbr64 
  100e6e:	55                   	push   %rbp
  100e6f:	48 89 e5             	mov    %rsp,%rbp
  100e72:	48 83 ec 20          	sub    $0x20,%rsp
  100e76:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100e7a:	89 f0                	mov    %esi,%eax
  100e7c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  100e7f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  100e82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100e86:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100e8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100e8e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e92:	48 8d 15 07 81 fb ff 	lea    -0x47ef9(%rip),%rdx        # b8fa0 <console+0xfa0>
  100e99:	48 39 d0             	cmp    %rdx,%rax
  100e9c:	72 0f                	jb     100ead <console_putc+0x43>
        cp->cursor = console;
  100e9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ea2:	48 8d 15 57 71 fb ff 	lea    -0x48ea9(%rip),%rdx        # b8000 <console>
  100ea9:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  100ead:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  100eb1:	0f 85 82 00 00 00    	jne    100f39 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  100eb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ebb:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ebf:	48 8d 15 3a 71 fb ff 	lea    -0x48ec6(%rip),%rdx        # b8000 <console>
  100ec6:	48 29 d0             	sub    %rdx,%rax
  100ec9:	48 d1 f8             	sar    %rax
  100ecc:	48 89 c1             	mov    %rax,%rcx
  100ecf:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100ed6:	66 66 66 
  100ed9:	48 89 c8             	mov    %rcx,%rax
  100edc:	48 f7 ea             	imul   %rdx
  100edf:	48 89 d0             	mov    %rdx,%rax
  100ee2:	48 c1 f8 05          	sar    $0x5,%rax
  100ee6:	48 89 ce             	mov    %rcx,%rsi
  100ee9:	48 c1 fe 3f          	sar    $0x3f,%rsi
  100eed:	48 29 f0             	sub    %rsi,%rax
  100ef0:	48 89 c2             	mov    %rax,%rdx
  100ef3:	48 89 d0             	mov    %rdx,%rax
  100ef6:	48 c1 e0 02          	shl    $0x2,%rax
  100efa:	48 01 d0             	add    %rdx,%rax
  100efd:	48 c1 e0 04          	shl    $0x4,%rax
  100f01:	48 29 c1             	sub    %rax,%rcx
  100f04:	48 89 ca             	mov    %rcx,%rdx
  100f07:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  100f0a:	eb 25                	jmp    100f31 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  100f0c:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100f0f:	83 c8 20             	or     $0x20,%eax
  100f12:	89 c6                	mov    %eax,%esi
  100f14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f18:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f1c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  100f20:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  100f24:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f28:	89 f2                	mov    %esi,%edx
  100f2a:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  100f2d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  100f31:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  100f35:	75 d5                	jne    100f0c <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  100f37:	eb 24                	jmp    100f5d <console_putc+0xf3>
        *cp->cursor++ = c | color;
  100f39:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  100f3d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100f40:	89 d6                	mov    %edx,%esi
  100f42:	09 c6                	or     %eax,%esi
  100f44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f48:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f4c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  100f50:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  100f54:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f58:	89 f2                	mov    %esi,%edx
  100f5a:	66 89 10             	mov    %dx,(%rax)
}
  100f5d:	90                   	nop
  100f5e:	c9                   	leave  
  100f5f:	c3                   	ret    

0000000000100f60 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100f60:	f3 0f 1e fa          	endbr64 
  100f64:	55                   	push   %rbp
  100f65:	48 89 e5             	mov    %rsp,%rbp
  100f68:	48 83 ec 30          	sub    $0x30,%rsp
  100f6c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  100f6f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  100f72:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100f76:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  100f7a:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 100e6a <console_putc>
  100f81:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100f85:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  100f89:	78 09                	js     100f94 <console_vprintf+0x34>
  100f8b:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  100f92:	7e 07                	jle    100f9b <console_vprintf+0x3b>
        cpos = 0;
  100f94:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  100f9b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f9e:	48 98                	cltq   
  100fa0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  100fa4:	48 8d 05 55 70 fb ff 	lea    -0x48fab(%rip),%rax        # b8000 <console>
  100fab:	48 01 d0             	add    %rdx,%rax
  100fae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100fb2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100fb6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100fba:	8b 75 e8             	mov    -0x18(%rbp),%esi
  100fbd:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  100fc1:	48 89 c7             	mov    %rax,%rdi
  100fc4:	e8 9a f4 ff ff       	call   100463 <printer_vprintf>
    return cp.cursor - console;
  100fc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100fcd:	48 8d 15 2c 70 fb ff 	lea    -0x48fd4(%rip),%rdx        # b8000 <console>
  100fd4:	48 29 d0             	sub    %rdx,%rax
  100fd7:	48 d1 f8             	sar    %rax
}
  100fda:	c9                   	leave  
  100fdb:	c3                   	ret    

0000000000100fdc <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  100fdc:	f3 0f 1e fa          	endbr64 
  100fe0:	55                   	push   %rbp
  100fe1:	48 89 e5             	mov    %rsp,%rbp
  100fe4:	48 83 ec 60          	sub    $0x60,%rsp
  100fe8:	89 7d ac             	mov    %edi,-0x54(%rbp)
  100feb:	89 75 a8             	mov    %esi,-0x58(%rbp)
  100fee:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  100ff2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100ff6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100ffa:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100ffe:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101005:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101009:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10100d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101011:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101015:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101019:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10101d:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101020:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101023:	89 c7                	mov    %eax,%edi
  101025:	e8 36 ff ff ff       	call   100f60 <console_vprintf>
  10102a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10102d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101030:	c9                   	leave  
  101031:	c3                   	ret    

0000000000101032 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101032:	f3 0f 1e fa          	endbr64 
  101036:	55                   	push   %rbp
  101037:	48 89 e5             	mov    %rsp,%rbp
  10103a:	48 83 ec 20          	sub    $0x20,%rsp
  10103e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101042:	89 f0                	mov    %esi,%eax
  101044:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101047:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10104a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10104e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101052:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101056:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10105a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10105e:	48 8b 40 10          	mov    0x10(%rax),%rax
  101062:	48 39 c2             	cmp    %rax,%rdx
  101065:	73 1a                	jae    101081 <string_putc+0x4f>
        *sp->s++ = c;
  101067:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10106b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10106f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101073:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101077:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10107b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10107f:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101081:	90                   	nop
  101082:	c9                   	leave  
  101083:	c3                   	ret    

0000000000101084 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101084:	f3 0f 1e fa          	endbr64 
  101088:	55                   	push   %rbp
  101089:	48 89 e5             	mov    %rsp,%rbp
  10108c:	48 83 ec 40          	sub    $0x40,%rsp
  101090:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101094:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101098:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10109c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1010a0:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 101032 <string_putc>
  1010a7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  1010ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1010af:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1010b3:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1010b8:	74 33                	je     1010ed <vsnprintf+0x69>
        sp.end = s + size - 1;
  1010ba:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1010be:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1010c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1010c6:	48 01 d0             	add    %rdx,%rax
  1010c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1010cd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1010d1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1010d5:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1010d9:	be 00 00 00 00       	mov    $0x0,%esi
  1010de:	48 89 c7             	mov    %rax,%rdi
  1010e1:	e8 7d f3 ff ff       	call   100463 <printer_vprintf>
        *sp.s = 0;
  1010e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010ea:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1010ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010f1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1010f5:	c9                   	leave  
  1010f6:	c3                   	ret    

00000000001010f7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1010f7:	f3 0f 1e fa          	endbr64 
  1010fb:	55                   	push   %rbp
  1010fc:	48 89 e5             	mov    %rsp,%rbp
  1010ff:	48 83 ec 70          	sub    $0x70,%rsp
  101103:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101107:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10110b:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  10110f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101113:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101117:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10111b:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101122:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101126:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10112a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10112e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101132:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101136:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10113a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10113e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101142:	48 89 c7             	mov    %rax,%rdi
  101145:	e8 3a ff ff ff       	call   101084 <vsnprintf>
  10114a:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10114d:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101150:	c9                   	leave  
  101151:	c3                   	ret    

0000000000101152 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101152:	f3 0f 1e fa          	endbr64 
  101156:	55                   	push   %rbp
  101157:	48 89 e5             	mov    %rsp,%rbp
  10115a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10115e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101165:	eb 1a                	jmp    101181 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101167:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10116a:	48 98                	cltq   
  10116c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101170:	48 8d 05 89 6e fb ff 	lea    -0x49177(%rip),%rax        # b8000 <console>
  101177:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10117d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101181:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101188:	7e dd                	jle    101167 <console_clear+0x15>
    }
    cursorpos = 0;
  10118a:	c7 05 68 7e fb ff 00 	movl   $0x0,-0x48198(%rip)        # b8ffc <cursorpos>
  101191:	00 00 00 
}
  101194:	90                   	nop
  101195:	c9                   	leave  
  101196:	c3                   	ret    
