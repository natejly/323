
obj/p-forkexit.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
// Parent program: keeps forking till infinity, never exits
// Child program: randomly forks and allocates memory
// till stack bottom is reached or runs out of memory
// after which it randomly exits or sleeps

void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	41 55                	push   %r13
  10000a:	41 54                	push   %r12
  10000c:	53                   	push   %rbx
  10000d:	48 83 ec 08          	sub    $0x8,%rsp
  100011:	eb 02                	jmp    100015 <process_main+0x15>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  100013:	cd 32                	int    $0x32
    while (1) {
        if (rand() % ALLOC_SLOWDOWN == 0) {
  100015:	e8 14 04 00 00       	call   10042e <rand>
  10001a:	48 63 d0             	movslq %eax,%rdx
  10001d:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100024:	48 c1 fa 25          	sar    $0x25,%rdx
  100028:	89 c1                	mov    %eax,%ecx
  10002a:	c1 f9 1f             	sar    $0x1f,%ecx
  10002d:	29 ca                	sub    %ecx,%edx
  10002f:	6b d2 64             	imul   $0x64,%edx,%edx
  100032:	39 d0                	cmp    %edx,%eax
  100034:	75 dd                	jne    100013 <process_main+0x13>
// sys_fork()
//    Fork the current process. On success, return the child's process ID to
//    the parent, and return 0 to the child. On failure, return -1.
static inline pid_t sys_fork(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100036:	cd 34                	int    $0x34
            if (sys_fork() == 0) {
  100038:	85 c0                	test   %eax,%eax
  10003a:	75 d9                	jne    100015 <process_main+0x15>
    asm volatile ("int %1" : "=a" (result)
  10003c:	cd 31                	int    $0x31
  10003e:	89 c7                	mov    %eax,%edi
  100040:	89 c3                	mov    %eax,%ebx
            sys_yield();
        }
    }

    pid_t p = sys_getpid();
    srand(p);
  100042:	e8 27 04 00 00       	call   10046e <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100047:	48 8d 05 c9 2f 00 00 	lea    0x2fc9(%rip),%rax        # 103017 <end+0xfff>
  10004e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100054:	48 89 05 ad 1f 00 00 	mov    %rax,0x1fad(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10005b:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  10005e:	48 83 e8 01          	sub    $0x1,%rax
  100062:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100068:	48 89 05 91 1f 00 00 	mov    %rax,0x1f91(%rip)        # 102000 <stack_bottom>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
            heap_top += PAGESIZE;
            if (console[CPOS(24, 0)]) {
  10006f:	4c 8d 25 8a 7f fb ff 	lea    -0x48076(%rip),%r12        # b8000 <console>
                /* clear "Out of physical memory" msg */
                console_printf(CPOS(24, 0), 0, "\n");
  100076:	4c 8d 2d e3 11 00 00 	lea    0x11e3(%rip),%r13        # 101260 <console_clear+0x52>
  10007d:	eb 13                	jmp    100092 <process_main+0x92>
            }
        } else if (x == 8 * p) {
  10007f:	0f 84 8b 00 00 00    	je     100110 <process_main+0x110>
            if (sys_fork() == 0) {
                p = sys_getpid();
            }
        } else if (x == 8 * p + 1) {
  100085:	83 c0 01             	add    $0x1,%eax
  100088:	39 d0                	cmp    %edx,%eax
  10008a:	0f 84 93 00 00 00    	je     100123 <process_main+0x123>
    asm volatile ("int %0" : /* no result */
  100090:	cd 32                	int    $0x32
        int x = rand() % (8 * ALLOC_SLOWDOWN);
  100092:	e8 97 03 00 00       	call   10042e <rand>
  100097:	48 63 d0             	movslq %eax,%rdx
  10009a:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1000a1:	48 c1 fa 28          	sar    $0x28,%rdx
  1000a5:	89 c1                	mov    %eax,%ecx
  1000a7:	c1 f9 1f             	sar    $0x1f,%ecx
  1000aa:	29 ca                	sub    %ecx,%edx
  1000ac:	69 ca 20 03 00 00    	imul   $0x320,%edx,%ecx
  1000b2:	29 c8                	sub    %ecx,%eax
  1000b4:	89 c2                	mov    %eax,%edx
        if (x < 8 * p) {
  1000b6:	8d 04 dd 00 00 00 00 	lea    0x0(,%rbx,8),%eax
  1000bd:	39 d0                	cmp    %edx,%eax
  1000bf:	7e be                	jle    10007f <process_main+0x7f>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  1000c1:	48 8b 3d 40 1f 00 00 	mov    0x1f40(%rip),%rdi        # 102008 <heap_top>
  1000c8:	48 3b 3d 31 1f 00 00 	cmp    0x1f31(%rip),%rdi        # 102000 <stack_bottom>
  1000cf:	74 56                	je     100127 <process_main+0x127>
    asm volatile ("int %1" : "=a" (result)
  1000d1:	cd 33                	int    $0x33
  1000d3:	85 c0                	test   %eax,%eax
  1000d5:	78 50                	js     100127 <process_main+0x127>
            *heap_top = p;      /* check we have write access to new page */
  1000d7:	48 8b 05 2a 1f 00 00 	mov    0x1f2a(%rip),%rax        # 102008 <heap_top>
  1000de:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  1000e0:	48 81 05 1d 1f 00 00 	addq   $0x1000,0x1f1d(%rip)        # 102008 <heap_top>
  1000e7:	00 10 00 00 
            if (console[CPOS(24, 0)]) {
  1000eb:	66 41 83 bc 24 00 0f 	cmpw   $0x0,0xf00(%r12)
  1000f2:	00 00 00 
  1000f5:	74 9b                	je     100092 <process_main+0x92>
                console_printf(CPOS(24, 0), 0, "\n");
  1000f7:	4c 89 ea             	mov    %r13,%rdx
  1000fa:	be 00 00 00 00       	mov    $0x0,%esi
  1000ff:	bf 80 07 00 00       	mov    $0x780,%edi
  100104:	b8 00 00 00 00       	mov    $0x0,%eax
  100109:	e8 8a 0f 00 00       	call   101098 <console_printf>
  10010e:	eb 82                	jmp    100092 <process_main+0x92>
    asm volatile ("int %1" : "=a" (result)
  100110:	cd 34                	int    $0x34
            if (sys_fork() == 0) {
  100112:	85 c0                	test   %eax,%eax
  100114:	0f 85 78 ff ff ff    	jne    100092 <process_main+0x92>
    asm volatile ("int %1" : "=a" (result)
  10011a:	cd 31                	int    $0x31
  10011c:	89 c3                	mov    %eax,%ebx
    return result;
  10011e:	e9 6f ff ff ff       	jmp    100092 <process_main+0x92>

// sys_exit()
//    Exit this process. Does not return.
static inline void sys_exit(void) __attribute__((noreturn));
static inline void sys_exit(void) {
    asm volatile ("int %0" : /* no result */
  100123:	cd 35                	int    $0x35
                  : "i" (INT_SYS_EXIT)
                  : "cc", "memory");
 spinloop: goto spinloop;       // should never get here
  100125:	eb fe                	jmp    100125 <process_main+0x125>
        }
    }

    // After running out of memory
    while (1) {
        if (rand() % (2 * ALLOC_SLOWDOWN) == 0) {
  100127:	e8 02 03 00 00       	call   10042e <rand>
  10012c:	48 63 d0             	movslq %eax,%rdx
  10012f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100136:	48 c1 fa 26          	sar    $0x26,%rdx
  10013a:	89 c1                	mov    %eax,%ecx
  10013c:	c1 f9 1f             	sar    $0x1f,%ecx
  10013f:	29 ca                	sub    %ecx,%edx
  100141:	69 d2 c8 00 00 00    	imul   $0xc8,%edx,%edx
  100147:	39 d0                	cmp    %edx,%eax
  100149:	74 04                	je     10014f <process_main+0x14f>
    asm volatile ("int %0" : /* no result */
  10014b:	cd 32                	int    $0x32
}
  10014d:	eb d8                	jmp    100127 <process_main+0x127>
    asm volatile ("int %0" : /* no result */
  10014f:	cd 35                	int    $0x35
 spinloop: goto spinloop;       // should never get here
  100151:	eb fe                	jmp    100151 <process_main+0x151>

0000000000100153 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100153:	f3 0f 1e fa          	endbr64 
  100157:	55                   	push   %rbp
  100158:	48 89 e5             	mov    %rsp,%rbp
  10015b:	48 83 ec 28          	sub    $0x28,%rsp
  10015f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100163:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100167:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10016b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10016f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100173:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100177:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10017b:	eb 1c                	jmp    100199 <memcpy+0x46>
        *d = *s;
  10017d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100181:	0f b6 10             	movzbl (%rax),%edx
  100184:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100188:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10018a:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10018f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100194:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100199:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10019e:	75 dd                	jne    10017d <memcpy+0x2a>
    }
    return dst;
  1001a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1001a4:	c9                   	leave  
  1001a5:	c3                   	ret    

00000000001001a6 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1001a6:	f3 0f 1e fa          	endbr64 
  1001aa:	55                   	push   %rbp
  1001ab:	48 89 e5             	mov    %rsp,%rbp
  1001ae:	48 83 ec 28          	sub    $0x28,%rsp
  1001b2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1001b6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1001ba:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1001be:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1001c2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1001c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1001ca:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1001ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1001d2:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1001d6:	73 6a                	jae    100242 <memmove+0x9c>
  1001d8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1001dc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1001e0:	48 01 d0             	add    %rdx,%rax
  1001e3:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1001e7:	73 59                	jae    100242 <memmove+0x9c>
        s += n, d += n;
  1001e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1001ed:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1001f1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1001f5:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1001f9:	eb 17                	jmp    100212 <memmove+0x6c>
            *--d = *--s;
  1001fb:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100200:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100205:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100209:	0f b6 10             	movzbl (%rax),%edx
  10020c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100210:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100212:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100216:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10021a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10021e:	48 85 c0             	test   %rax,%rax
  100221:	75 d8                	jne    1001fb <memmove+0x55>
    if (s < d && s + n > d) {
  100223:	eb 2e                	jmp    100253 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100225:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100229:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10022d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100231:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100235:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100239:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  10023d:	0f b6 12             	movzbl (%rdx),%edx
  100240:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100242:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100246:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10024a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10024e:	48 85 c0             	test   %rax,%rax
  100251:	75 d2                	jne    100225 <memmove+0x7f>
        }
    }
    return dst;
  100253:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100257:	c9                   	leave  
  100258:	c3                   	ret    

0000000000100259 <memset>:

void* memset(void* v, int c, size_t n) {
  100259:	f3 0f 1e fa          	endbr64 
  10025d:	55                   	push   %rbp
  10025e:	48 89 e5             	mov    %rsp,%rbp
  100261:	48 83 ec 28          	sub    $0x28,%rsp
  100265:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100269:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  10026c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100270:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100274:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100278:	eb 15                	jmp    10028f <memset+0x36>
        *p = c;
  10027a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10027d:	89 c2                	mov    %eax,%edx
  10027f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100283:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100285:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10028a:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10028f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100294:	75 e4                	jne    10027a <memset+0x21>
    }
    return v;
  100296:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10029a:	c9                   	leave  
  10029b:	c3                   	ret    

000000000010029c <strlen>:

size_t strlen(const char* s) {
  10029c:	f3 0f 1e fa          	endbr64 
  1002a0:	55                   	push   %rbp
  1002a1:	48 89 e5             	mov    %rsp,%rbp
  1002a4:	48 83 ec 18          	sub    $0x18,%rsp
  1002a8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1002ac:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1002b3:	00 
  1002b4:	eb 0a                	jmp    1002c0 <strlen+0x24>
        ++n;
  1002b6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1002bb:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1002c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002c4:	0f b6 00             	movzbl (%rax),%eax
  1002c7:	84 c0                	test   %al,%al
  1002c9:	75 eb                	jne    1002b6 <strlen+0x1a>
    }
    return n;
  1002cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1002cf:	c9                   	leave  
  1002d0:	c3                   	ret    

00000000001002d1 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1002d1:	f3 0f 1e fa          	endbr64 
  1002d5:	55                   	push   %rbp
  1002d6:	48 89 e5             	mov    %rsp,%rbp
  1002d9:	48 83 ec 20          	sub    $0x20,%rsp
  1002dd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002e1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1002e5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1002ec:	00 
  1002ed:	eb 0a                	jmp    1002f9 <strnlen+0x28>
        ++n;
  1002ef:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1002f4:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1002f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002fd:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100301:	74 0b                	je     10030e <strnlen+0x3d>
  100303:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100307:	0f b6 00             	movzbl (%rax),%eax
  10030a:	84 c0                	test   %al,%al
  10030c:	75 e1                	jne    1002ef <strnlen+0x1e>
    }
    return n;
  10030e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100312:	c9                   	leave  
  100313:	c3                   	ret    

0000000000100314 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100314:	f3 0f 1e fa          	endbr64 
  100318:	55                   	push   %rbp
  100319:	48 89 e5             	mov    %rsp,%rbp
  10031c:	48 83 ec 20          	sub    $0x20,%rsp
  100320:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100324:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100328:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10032c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100330:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100334:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100338:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  10033c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100340:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100344:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100348:	0f b6 12             	movzbl (%rdx),%edx
  10034b:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  10034d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100351:	48 83 e8 01          	sub    $0x1,%rax
  100355:	0f b6 00             	movzbl (%rax),%eax
  100358:	84 c0                	test   %al,%al
  10035a:	75 d4                	jne    100330 <strcpy+0x1c>
    return dst;
  10035c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100360:	c9                   	leave  
  100361:	c3                   	ret    

0000000000100362 <strcmp>:

int strcmp(const char* a, const char* b) {
  100362:	f3 0f 1e fa          	endbr64 
  100366:	55                   	push   %rbp
  100367:	48 89 e5             	mov    %rsp,%rbp
  10036a:	48 83 ec 10          	sub    $0x10,%rsp
  10036e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100372:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100376:	eb 0a                	jmp    100382 <strcmp+0x20>
        ++a, ++b;
  100378:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10037d:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100382:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100386:	0f b6 00             	movzbl (%rax),%eax
  100389:	84 c0                	test   %al,%al
  10038b:	74 1d                	je     1003aa <strcmp+0x48>
  10038d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100391:	0f b6 00             	movzbl (%rax),%eax
  100394:	84 c0                	test   %al,%al
  100396:	74 12                	je     1003aa <strcmp+0x48>
  100398:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10039c:	0f b6 10             	movzbl (%rax),%edx
  10039f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003a3:	0f b6 00             	movzbl (%rax),%eax
  1003a6:	38 c2                	cmp    %al,%dl
  1003a8:	74 ce                	je     100378 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1003aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003ae:	0f b6 00             	movzbl (%rax),%eax
  1003b1:	89 c2                	mov    %eax,%edx
  1003b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003b7:	0f b6 00             	movzbl (%rax),%eax
  1003ba:	38 c2                	cmp    %al,%dl
  1003bc:	0f 97 c0             	seta   %al
  1003bf:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1003c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003c6:	0f b6 00             	movzbl (%rax),%eax
  1003c9:	89 c1                	mov    %eax,%ecx
  1003cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003cf:	0f b6 00             	movzbl (%rax),%eax
  1003d2:	38 c1                	cmp    %al,%cl
  1003d4:	0f 92 c0             	setb   %al
  1003d7:	0f b6 c8             	movzbl %al,%ecx
  1003da:	89 d0                	mov    %edx,%eax
  1003dc:	29 c8                	sub    %ecx,%eax
}
  1003de:	c9                   	leave  
  1003df:	c3                   	ret    

00000000001003e0 <strchr>:

char* strchr(const char* s, int c) {
  1003e0:	f3 0f 1e fa          	endbr64 
  1003e4:	55                   	push   %rbp
  1003e5:	48 89 e5             	mov    %rsp,%rbp
  1003e8:	48 83 ec 10          	sub    $0x10,%rsp
  1003ec:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1003f0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1003f3:	eb 05                	jmp    1003fa <strchr+0x1a>
        ++s;
  1003f5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1003fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003fe:	0f b6 00             	movzbl (%rax),%eax
  100401:	84 c0                	test   %al,%al
  100403:	74 0e                	je     100413 <strchr+0x33>
  100405:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100409:	0f b6 00             	movzbl (%rax),%eax
  10040c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10040f:	38 d0                	cmp    %dl,%al
  100411:	75 e2                	jne    1003f5 <strchr+0x15>
    }
    if (*s == (char) c) {
  100413:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100417:	0f b6 00             	movzbl (%rax),%eax
  10041a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10041d:	38 d0                	cmp    %dl,%al
  10041f:	75 06                	jne    100427 <strchr+0x47>
        return (char*) s;
  100421:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100425:	eb 05                	jmp    10042c <strchr+0x4c>
    } else {
        return NULL;
  100427:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  10042c:	c9                   	leave  
  10042d:	c3                   	ret    

000000000010042e <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  10042e:	f3 0f 1e fa          	endbr64 
  100432:	55                   	push   %rbp
  100433:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100436:	8b 05 d4 1b 00 00    	mov    0x1bd4(%rip),%eax        # 102010 <rand_seed_set>
  10043c:	85 c0                	test   %eax,%eax
  10043e:	75 0a                	jne    10044a <rand+0x1c>
        srand(819234718U);
  100440:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100445:	e8 24 00 00 00       	call   10046e <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  10044a:	8b 05 c4 1b 00 00    	mov    0x1bc4(%rip),%eax        # 102014 <rand_seed>
  100450:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100456:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10045b:	89 05 b3 1b 00 00    	mov    %eax,0x1bb3(%rip)        # 102014 <rand_seed>
    return rand_seed & RAND_MAX;
  100461:	8b 05 ad 1b 00 00    	mov    0x1bad(%rip),%eax        # 102014 <rand_seed>
  100467:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10046c:	5d                   	pop    %rbp
  10046d:	c3                   	ret    

000000000010046e <srand>:

void srand(unsigned seed) {
  10046e:	f3 0f 1e fa          	endbr64 
  100472:	55                   	push   %rbp
  100473:	48 89 e5             	mov    %rsp,%rbp
  100476:	48 83 ec 08          	sub    $0x8,%rsp
  10047a:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  10047d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100480:	89 05 8e 1b 00 00    	mov    %eax,0x1b8e(%rip)        # 102014 <rand_seed>
    rand_seed_set = 1;
  100486:	c7 05 80 1b 00 00 01 	movl   $0x1,0x1b80(%rip)        # 102010 <rand_seed_set>
  10048d:	00 00 00 
}
  100490:	90                   	nop
  100491:	c9                   	leave  
  100492:	c3                   	ret    

0000000000100493 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100493:	f3 0f 1e fa          	endbr64 
  100497:	55                   	push   %rbp
  100498:	48 89 e5             	mov    %rsp,%rbp
  10049b:	48 83 ec 28          	sub    $0x28,%rsp
  10049f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004a3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1004a7:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1004aa:	48 8d 05 bf 0e 00 00 	lea    0xebf(%rip),%rax        # 101370 <upper_digits.1>
  1004b1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  1004b5:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1004b9:	79 0e                	jns    1004c9 <fill_numbuf+0x36>
        digits = lower_digits;
  1004bb:	48 8d 05 ce 0e 00 00 	lea    0xece(%rip),%rax        # 101390 <lower_digits.0>
  1004c2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  1004c6:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1004c9:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1004ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004d2:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1004d5:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1004d8:	48 63 c8             	movslq %eax,%rcx
  1004db:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1004df:	ba 00 00 00 00       	mov    $0x0,%edx
  1004e4:	48 f7 f1             	div    %rcx
  1004e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004eb:	48 01 d0             	add    %rdx,%rax
  1004ee:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1004f3:	0f b6 10             	movzbl (%rax),%edx
  1004f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004fa:	88 10                	mov    %dl,(%rax)
        val /= base;
  1004fc:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1004ff:	48 63 f0             	movslq %eax,%rsi
  100502:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100506:	ba 00 00 00 00       	mov    $0x0,%edx
  10050b:	48 f7 f6             	div    %rsi
  10050e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100512:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100517:	75 bc                	jne    1004d5 <fill_numbuf+0x42>
    return numbuf_end;
  100519:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10051d:	c9                   	leave  
  10051e:	c3                   	ret    

000000000010051f <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10051f:	f3 0f 1e fa          	endbr64 
  100523:	55                   	push   %rbp
  100524:	48 89 e5             	mov    %rsp,%rbp
  100527:	53                   	push   %rbx
  100528:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  10052f:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100536:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  10053c:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100543:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  10054a:	e9 bd 09 00 00       	jmp    100f0c <printer_vprintf+0x9ed>
        if (*format != '%') {
  10054f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100556:	0f b6 00             	movzbl (%rax),%eax
  100559:	3c 25                	cmp    $0x25,%al
  10055b:	74 31                	je     10058e <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  10055d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100564:	4c 8b 00             	mov    (%rax),%r8
  100567:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10056e:	0f b6 00             	movzbl (%rax),%eax
  100571:	0f b6 c8             	movzbl %al,%ecx
  100574:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10057a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100581:	89 ce                	mov    %ecx,%esi
  100583:	48 89 c7             	mov    %rax,%rdi
  100586:	41 ff d0             	call   *%r8
            continue;
  100589:	e9 76 09 00 00       	jmp    100f04 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  10058e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100595:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10059c:	01 
  10059d:	eb 4d                	jmp    1005ec <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  10059f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005a6:	0f b6 00             	movzbl (%rax),%eax
  1005a9:	0f be c0             	movsbl %al,%eax
  1005ac:	89 c6                	mov    %eax,%esi
  1005ae:	48 8d 05 bb 0c 00 00 	lea    0xcbb(%rip),%rax        # 101270 <flag_chars>
  1005b5:	48 89 c7             	mov    %rax,%rdi
  1005b8:	e8 23 fe ff ff       	call   1003e0 <strchr>
  1005bd:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1005c1:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1005c6:	74 34                	je     1005fc <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  1005c8:	48 8d 15 a1 0c 00 00 	lea    0xca1(%rip),%rdx        # 101270 <flag_chars>
  1005cf:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1005d3:	48 29 d0             	sub    %rdx,%rax
  1005d6:	ba 01 00 00 00       	mov    $0x1,%edx
  1005db:	89 c1                	mov    %eax,%ecx
  1005dd:	d3 e2                	shl    %cl,%edx
  1005df:	89 d0                	mov    %edx,%eax
  1005e1:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1005e4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1005eb:	01 
  1005ec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005f3:	0f b6 00             	movzbl (%rax),%eax
  1005f6:	84 c0                	test   %al,%al
  1005f8:	75 a5                	jne    10059f <printer_vprintf+0x80>
  1005fa:	eb 01                	jmp    1005fd <printer_vprintf+0xde>
            } else {
                break;
  1005fc:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1005fd:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100604:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10060b:	0f b6 00             	movzbl (%rax),%eax
  10060e:	3c 30                	cmp    $0x30,%al
  100610:	7e 67                	jle    100679 <printer_vprintf+0x15a>
  100612:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100619:	0f b6 00             	movzbl (%rax),%eax
  10061c:	3c 39                	cmp    $0x39,%al
  10061e:	7f 59                	jg     100679 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100620:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100627:	eb 2e                	jmp    100657 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  100629:	8b 55 e8             	mov    -0x18(%rbp),%edx
  10062c:	89 d0                	mov    %edx,%eax
  10062e:	c1 e0 02             	shl    $0x2,%eax
  100631:	01 d0                	add    %edx,%eax
  100633:	01 c0                	add    %eax,%eax
  100635:	89 c1                	mov    %eax,%ecx
  100637:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10063e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100642:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100649:	0f b6 00             	movzbl (%rax),%eax
  10064c:	0f be c0             	movsbl %al,%eax
  10064f:	01 c8                	add    %ecx,%eax
  100651:	83 e8 30             	sub    $0x30,%eax
  100654:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100657:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10065e:	0f b6 00             	movzbl (%rax),%eax
  100661:	3c 2f                	cmp    $0x2f,%al
  100663:	0f 8e 85 00 00 00    	jle    1006ee <printer_vprintf+0x1cf>
  100669:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100670:	0f b6 00             	movzbl (%rax),%eax
  100673:	3c 39                	cmp    $0x39,%al
  100675:	7e b2                	jle    100629 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  100677:	eb 75                	jmp    1006ee <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  100679:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100680:	0f b6 00             	movzbl (%rax),%eax
  100683:	3c 2a                	cmp    $0x2a,%al
  100685:	75 68                	jne    1006ef <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  100687:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10068e:	8b 00                	mov    (%rax),%eax
  100690:	83 f8 2f             	cmp    $0x2f,%eax
  100693:	77 30                	ja     1006c5 <printer_vprintf+0x1a6>
  100695:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10069c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1006a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006a7:	8b 00                	mov    (%rax),%eax
  1006a9:	89 c0                	mov    %eax,%eax
  1006ab:	48 01 d0             	add    %rdx,%rax
  1006ae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1006b5:	8b 12                	mov    (%rdx),%edx
  1006b7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1006ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1006c1:	89 0a                	mov    %ecx,(%rdx)
  1006c3:	eb 1a                	jmp    1006df <printer_vprintf+0x1c0>
  1006c5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006cc:	48 8b 40 08          	mov    0x8(%rax),%rax
  1006d0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1006d4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1006db:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1006df:	8b 00                	mov    (%rax),%eax
  1006e1:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1006e4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006eb:	01 
  1006ec:	eb 01                	jmp    1006ef <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  1006ee:	90                   	nop
        }

        // process precision
        int precision = -1;
  1006ef:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1006f6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006fd:	0f b6 00             	movzbl (%rax),%eax
  100700:	3c 2e                	cmp    $0x2e,%al
  100702:	0f 85 00 01 00 00    	jne    100808 <printer_vprintf+0x2e9>
            ++format;
  100708:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10070f:	01 
            if (*format >= '0' && *format <= '9') {
  100710:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100717:	0f b6 00             	movzbl (%rax),%eax
  10071a:	3c 2f                	cmp    $0x2f,%al
  10071c:	7e 67                	jle    100785 <printer_vprintf+0x266>
  10071e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100725:	0f b6 00             	movzbl (%rax),%eax
  100728:	3c 39                	cmp    $0x39,%al
  10072a:	7f 59                	jg     100785 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10072c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100733:	eb 2e                	jmp    100763 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  100735:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100738:	89 d0                	mov    %edx,%eax
  10073a:	c1 e0 02             	shl    $0x2,%eax
  10073d:	01 d0                	add    %edx,%eax
  10073f:	01 c0                	add    %eax,%eax
  100741:	89 c1                	mov    %eax,%ecx
  100743:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10074a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10074e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100755:	0f b6 00             	movzbl (%rax),%eax
  100758:	0f be c0             	movsbl %al,%eax
  10075b:	01 c8                	add    %ecx,%eax
  10075d:	83 e8 30             	sub    $0x30,%eax
  100760:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100763:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10076a:	0f b6 00             	movzbl (%rax),%eax
  10076d:	3c 2f                	cmp    $0x2f,%al
  10076f:	0f 8e 85 00 00 00    	jle    1007fa <printer_vprintf+0x2db>
  100775:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10077c:	0f b6 00             	movzbl (%rax),%eax
  10077f:	3c 39                	cmp    $0x39,%al
  100781:	7e b2                	jle    100735 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  100783:	eb 75                	jmp    1007fa <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  100785:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10078c:	0f b6 00             	movzbl (%rax),%eax
  10078f:	3c 2a                	cmp    $0x2a,%al
  100791:	75 68                	jne    1007fb <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  100793:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10079a:	8b 00                	mov    (%rax),%eax
  10079c:	83 f8 2f             	cmp    $0x2f,%eax
  10079f:	77 30                	ja     1007d1 <printer_vprintf+0x2b2>
  1007a1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007a8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1007ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007b3:	8b 00                	mov    (%rax),%eax
  1007b5:	89 c0                	mov    %eax,%eax
  1007b7:	48 01 d0             	add    %rdx,%rax
  1007ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007c1:	8b 12                	mov    (%rdx),%edx
  1007c3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1007c6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007cd:	89 0a                	mov    %ecx,(%rdx)
  1007cf:	eb 1a                	jmp    1007eb <printer_vprintf+0x2cc>
  1007d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007d8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1007dc:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1007e0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007e7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1007eb:	8b 00                	mov    (%rax),%eax
  1007ed:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1007f0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007f7:	01 
  1007f8:	eb 01                	jmp    1007fb <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  1007fa:	90                   	nop
            }
            if (precision < 0) {
  1007fb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1007ff:	79 07                	jns    100808 <printer_vprintf+0x2e9>
                precision = 0;
  100801:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100808:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  10080f:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100816:	00 
        int length = 0;
  100817:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  10081e:	48 8d 05 51 0a 00 00 	lea    0xa51(%rip),%rax        # 101276 <flag_chars+0x6>
  100825:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  100829:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100830:	0f b6 00             	movzbl (%rax),%eax
  100833:	0f be c0             	movsbl %al,%eax
  100836:	83 e8 43             	sub    $0x43,%eax
  100839:	83 f8 37             	cmp    $0x37,%eax
  10083c:	0f 87 b6 03 00 00    	ja     100bf8 <printer_vprintf+0x6d9>
  100842:	89 c0                	mov    %eax,%eax
  100844:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  10084b:	00 
  10084c:	48 8d 05 31 0a 00 00 	lea    0xa31(%rip),%rax        # 101284 <flag_chars+0x14>
  100853:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  100856:	48 98                	cltq   
  100858:	48 8d 15 25 0a 00 00 	lea    0xa25(%rip),%rdx        # 101284 <flag_chars+0x14>
  10085f:	48 01 d0             	add    %rdx,%rax
  100862:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  100865:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  10086c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100873:	01 
            goto again;
  100874:	eb b3                	jmp    100829 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100876:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  10087a:	74 5d                	je     1008d9 <printer_vprintf+0x3ba>
  10087c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100883:	8b 00                	mov    (%rax),%eax
  100885:	83 f8 2f             	cmp    $0x2f,%eax
  100888:	77 30                	ja     1008ba <printer_vprintf+0x39b>
  10088a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100891:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100895:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10089c:	8b 00                	mov    (%rax),%eax
  10089e:	89 c0                	mov    %eax,%eax
  1008a0:	48 01 d0             	add    %rdx,%rax
  1008a3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008aa:	8b 12                	mov    (%rdx),%edx
  1008ac:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1008af:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008b6:	89 0a                	mov    %ecx,(%rdx)
  1008b8:	eb 1a                	jmp    1008d4 <printer_vprintf+0x3b5>
  1008ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008c1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1008c5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1008c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008d0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1008d4:	48 8b 00             	mov    (%rax),%rax
  1008d7:	eb 5c                	jmp    100935 <printer_vprintf+0x416>
  1008d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008e0:	8b 00                	mov    (%rax),%eax
  1008e2:	83 f8 2f             	cmp    $0x2f,%eax
  1008e5:	77 30                	ja     100917 <printer_vprintf+0x3f8>
  1008e7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008ee:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1008f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008f9:	8b 00                	mov    (%rax),%eax
  1008fb:	89 c0                	mov    %eax,%eax
  1008fd:	48 01 d0             	add    %rdx,%rax
  100900:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100907:	8b 12                	mov    (%rdx),%edx
  100909:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10090c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100913:	89 0a                	mov    %ecx,(%rdx)
  100915:	eb 1a                	jmp    100931 <printer_vprintf+0x412>
  100917:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10091e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100922:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100926:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10092d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100931:	8b 00                	mov    (%rax),%eax
  100933:	48 98                	cltq   
  100935:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100939:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10093d:	48 c1 f8 38          	sar    $0x38,%rax
  100941:	25 80 00 00 00       	and    $0x80,%eax
  100946:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100949:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  10094d:	74 09                	je     100958 <printer_vprintf+0x439>
  10094f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100953:	48 f7 d8             	neg    %rax
  100956:	eb 04                	jmp    10095c <printer_vprintf+0x43d>
  100958:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10095c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100960:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100963:	83 c8 60             	or     $0x60,%eax
  100966:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100969:	e9 cf 02 00 00       	jmp    100c3d <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10096e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100972:	74 5d                	je     1009d1 <printer_vprintf+0x4b2>
  100974:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10097b:	8b 00                	mov    (%rax),%eax
  10097d:	83 f8 2f             	cmp    $0x2f,%eax
  100980:	77 30                	ja     1009b2 <printer_vprintf+0x493>
  100982:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100989:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10098d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100994:	8b 00                	mov    (%rax),%eax
  100996:	89 c0                	mov    %eax,%eax
  100998:	48 01 d0             	add    %rdx,%rax
  10099b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009a2:	8b 12                	mov    (%rdx),%edx
  1009a4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009a7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009ae:	89 0a                	mov    %ecx,(%rdx)
  1009b0:	eb 1a                	jmp    1009cc <printer_vprintf+0x4ad>
  1009b2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009b9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009bd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009c1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009c8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009cc:	48 8b 00             	mov    (%rax),%rax
  1009cf:	eb 5c                	jmp    100a2d <printer_vprintf+0x50e>
  1009d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009d8:	8b 00                	mov    (%rax),%eax
  1009da:	83 f8 2f             	cmp    $0x2f,%eax
  1009dd:	77 30                	ja     100a0f <printer_vprintf+0x4f0>
  1009df:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009e6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009ea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f1:	8b 00                	mov    (%rax),%eax
  1009f3:	89 c0                	mov    %eax,%eax
  1009f5:	48 01 d0             	add    %rdx,%rax
  1009f8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009ff:	8b 12                	mov    (%rdx),%edx
  100a01:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a04:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a0b:	89 0a                	mov    %ecx,(%rdx)
  100a0d:	eb 1a                	jmp    100a29 <printer_vprintf+0x50a>
  100a0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a16:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a1a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a1e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a25:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a29:	8b 00                	mov    (%rax),%eax
  100a2b:	89 c0                	mov    %eax,%eax
  100a2d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100a31:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100a35:	e9 03 02 00 00       	jmp    100c3d <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100a3a:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100a41:	e9 28 ff ff ff       	jmp    10096e <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100a46:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100a4d:	e9 1c ff ff ff       	jmp    10096e <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100a52:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a59:	8b 00                	mov    (%rax),%eax
  100a5b:	83 f8 2f             	cmp    $0x2f,%eax
  100a5e:	77 30                	ja     100a90 <printer_vprintf+0x571>
  100a60:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a67:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a6b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a72:	8b 00                	mov    (%rax),%eax
  100a74:	89 c0                	mov    %eax,%eax
  100a76:	48 01 d0             	add    %rdx,%rax
  100a79:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a80:	8b 12                	mov    (%rdx),%edx
  100a82:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a85:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a8c:	89 0a                	mov    %ecx,(%rdx)
  100a8e:	eb 1a                	jmp    100aaa <printer_vprintf+0x58b>
  100a90:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a97:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a9b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a9f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aa6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aaa:	48 8b 00             	mov    (%rax),%rax
  100aad:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100ab1:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100ab8:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100abf:	e9 79 01 00 00       	jmp    100c3d <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100ac4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100acb:	8b 00                	mov    (%rax),%eax
  100acd:	83 f8 2f             	cmp    $0x2f,%eax
  100ad0:	77 30                	ja     100b02 <printer_vprintf+0x5e3>
  100ad2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ad9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100add:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ae4:	8b 00                	mov    (%rax),%eax
  100ae6:	89 c0                	mov    %eax,%eax
  100ae8:	48 01 d0             	add    %rdx,%rax
  100aeb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100af2:	8b 12                	mov    (%rdx),%edx
  100af4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100af7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100afe:	89 0a                	mov    %ecx,(%rdx)
  100b00:	eb 1a                	jmp    100b1c <printer_vprintf+0x5fd>
  100b02:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b09:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b0d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b11:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b18:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b1c:	48 8b 00             	mov    (%rax),%rax
  100b1f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100b23:	e9 15 01 00 00       	jmp    100c3d <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100b28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b2f:	8b 00                	mov    (%rax),%eax
  100b31:	83 f8 2f             	cmp    $0x2f,%eax
  100b34:	77 30                	ja     100b66 <printer_vprintf+0x647>
  100b36:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b3d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b41:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b48:	8b 00                	mov    (%rax),%eax
  100b4a:	89 c0                	mov    %eax,%eax
  100b4c:	48 01 d0             	add    %rdx,%rax
  100b4f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b56:	8b 12                	mov    (%rdx),%edx
  100b58:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b5b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b62:	89 0a                	mov    %ecx,(%rdx)
  100b64:	eb 1a                	jmp    100b80 <printer_vprintf+0x661>
  100b66:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b6d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b71:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b75:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b7c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b80:	8b 00                	mov    (%rax),%eax
  100b82:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100b88:	e9 77 03 00 00       	jmp    100f04 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100b8d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100b91:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100b95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b9c:	8b 00                	mov    (%rax),%eax
  100b9e:	83 f8 2f             	cmp    $0x2f,%eax
  100ba1:	77 30                	ja     100bd3 <printer_vprintf+0x6b4>
  100ba3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100baa:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bb5:	8b 00                	mov    (%rax),%eax
  100bb7:	89 c0                	mov    %eax,%eax
  100bb9:	48 01 d0             	add    %rdx,%rax
  100bbc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bc3:	8b 12                	mov    (%rdx),%edx
  100bc5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bc8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bcf:	89 0a                	mov    %ecx,(%rdx)
  100bd1:	eb 1a                	jmp    100bed <printer_vprintf+0x6ce>
  100bd3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bda:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bde:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100be2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100be9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bed:	8b 00                	mov    (%rax),%eax
  100bef:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100bf2:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100bf6:	eb 45                	jmp    100c3d <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100bf8:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100bfc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100c00:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c07:	0f b6 00             	movzbl (%rax),%eax
  100c0a:	84 c0                	test   %al,%al
  100c0c:	74 0c                	je     100c1a <printer_vprintf+0x6fb>
  100c0e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c15:	0f b6 00             	movzbl (%rax),%eax
  100c18:	eb 05                	jmp    100c1f <printer_vprintf+0x700>
  100c1a:	b8 25 00 00 00       	mov    $0x25,%eax
  100c1f:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100c22:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100c26:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c2d:	0f b6 00             	movzbl (%rax),%eax
  100c30:	84 c0                	test   %al,%al
  100c32:	75 08                	jne    100c3c <printer_vprintf+0x71d>
                format--;
  100c34:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100c3b:	01 
            }
            break;
  100c3c:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100c3d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c40:	83 e0 20             	and    $0x20,%eax
  100c43:	85 c0                	test   %eax,%eax
  100c45:	74 1e                	je     100c65 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100c47:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c4b:	48 83 c0 18          	add    $0x18,%rax
  100c4f:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100c52:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100c56:	48 89 ce             	mov    %rcx,%rsi
  100c59:	48 89 c7             	mov    %rax,%rdi
  100c5c:	e8 32 f8 ff ff       	call   100493 <fill_numbuf>
  100c61:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100c65:	48 8d 05 0a 06 00 00 	lea    0x60a(%rip),%rax        # 101276 <flag_chars+0x6>
  100c6c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100c70:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c73:	83 e0 20             	and    $0x20,%eax
  100c76:	85 c0                	test   %eax,%eax
  100c78:	74 51                	je     100ccb <printer_vprintf+0x7ac>
  100c7a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c7d:	83 e0 40             	and    $0x40,%eax
  100c80:	85 c0                	test   %eax,%eax
  100c82:	74 47                	je     100ccb <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100c84:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c87:	25 80 00 00 00       	and    $0x80,%eax
  100c8c:	85 c0                	test   %eax,%eax
  100c8e:	74 0d                	je     100c9d <printer_vprintf+0x77e>
                prefix = "-";
  100c90:	48 8d 05 e0 05 00 00 	lea    0x5e0(%rip),%rax        # 101277 <flag_chars+0x7>
  100c97:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100c9b:	eb 7d                	jmp    100d1a <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100c9d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ca0:	83 e0 10             	and    $0x10,%eax
  100ca3:	85 c0                	test   %eax,%eax
  100ca5:	74 0d                	je     100cb4 <printer_vprintf+0x795>
                prefix = "+";
  100ca7:	48 8d 05 cb 05 00 00 	lea    0x5cb(%rip),%rax        # 101279 <flag_chars+0x9>
  100cae:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100cb2:	eb 66                	jmp    100d1a <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100cb4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cb7:	83 e0 08             	and    $0x8,%eax
  100cba:	85 c0                	test   %eax,%eax
  100cbc:	74 5c                	je     100d1a <printer_vprintf+0x7fb>
                prefix = " ";
  100cbe:	48 8d 05 b6 05 00 00 	lea    0x5b6(%rip),%rax        # 10127b <flag_chars+0xb>
  100cc5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100cc9:	eb 4f                	jmp    100d1a <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100ccb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cce:	83 e0 20             	and    $0x20,%eax
  100cd1:	85 c0                	test   %eax,%eax
  100cd3:	74 46                	je     100d1b <printer_vprintf+0x7fc>
  100cd5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cd8:	83 e0 01             	and    $0x1,%eax
  100cdb:	85 c0                	test   %eax,%eax
  100cdd:	74 3c                	je     100d1b <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100cdf:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100ce3:	74 06                	je     100ceb <printer_vprintf+0x7cc>
  100ce5:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100ce9:	75 30                	jne    100d1b <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100ceb:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100cf0:	75 0c                	jne    100cfe <printer_vprintf+0x7df>
  100cf2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cf5:	25 00 01 00 00       	and    $0x100,%eax
  100cfa:	85 c0                	test   %eax,%eax
  100cfc:	74 1d                	je     100d1b <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100cfe:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100d02:	75 09                	jne    100d0d <printer_vprintf+0x7ee>
  100d04:	48 8d 05 72 05 00 00 	lea    0x572(%rip),%rax        # 10127d <flag_chars+0xd>
  100d0b:	eb 07                	jmp    100d14 <printer_vprintf+0x7f5>
  100d0d:	48 8d 05 6c 05 00 00 	lea    0x56c(%rip),%rax        # 101280 <flag_chars+0x10>
  100d14:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100d18:	eb 01                	jmp    100d1b <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100d1a:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100d1b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100d1f:	78 24                	js     100d45 <printer_vprintf+0x826>
  100d21:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d24:	83 e0 20             	and    $0x20,%eax
  100d27:	85 c0                	test   %eax,%eax
  100d29:	75 1a                	jne    100d45 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100d2b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100d2e:	48 63 d0             	movslq %eax,%rdx
  100d31:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100d35:	48 89 d6             	mov    %rdx,%rsi
  100d38:	48 89 c7             	mov    %rax,%rdi
  100d3b:	e8 91 f5 ff ff       	call   1002d1 <strnlen>
  100d40:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100d43:	eb 0f                	jmp    100d54 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100d45:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100d49:	48 89 c7             	mov    %rax,%rdi
  100d4c:	e8 4b f5 ff ff       	call   10029c <strlen>
  100d51:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100d54:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d57:	83 e0 20             	and    $0x20,%eax
  100d5a:	85 c0                	test   %eax,%eax
  100d5c:	74 20                	je     100d7e <printer_vprintf+0x85f>
  100d5e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100d62:	78 1a                	js     100d7e <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100d64:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100d67:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100d6a:	7e 08                	jle    100d74 <printer_vprintf+0x855>
  100d6c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100d6f:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100d72:	eb 05                	jmp    100d79 <printer_vprintf+0x85a>
  100d74:	b8 00 00 00 00       	mov    $0x0,%eax
  100d79:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100d7c:	eb 5c                	jmp    100dda <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100d7e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d81:	83 e0 20             	and    $0x20,%eax
  100d84:	85 c0                	test   %eax,%eax
  100d86:	74 4b                	je     100dd3 <printer_vprintf+0x8b4>
  100d88:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d8b:	83 e0 02             	and    $0x2,%eax
  100d8e:	85 c0                	test   %eax,%eax
  100d90:	74 41                	je     100dd3 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100d92:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d95:	83 e0 04             	and    $0x4,%eax
  100d98:	85 c0                	test   %eax,%eax
  100d9a:	75 37                	jne    100dd3 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100d9c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100da0:	48 89 c7             	mov    %rax,%rdi
  100da3:	e8 f4 f4 ff ff       	call   10029c <strlen>
  100da8:	89 c2                	mov    %eax,%edx
  100daa:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100dad:	01 d0                	add    %edx,%eax
  100daf:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100db2:	7e 1f                	jle    100dd3 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100db4:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100db7:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100dba:	89 c3                	mov    %eax,%ebx
  100dbc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100dc0:	48 89 c7             	mov    %rax,%rdi
  100dc3:	e8 d4 f4 ff ff       	call   10029c <strlen>
  100dc8:	89 c2                	mov    %eax,%edx
  100dca:	89 d8                	mov    %ebx,%eax
  100dcc:	29 d0                	sub    %edx,%eax
  100dce:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100dd1:	eb 07                	jmp    100dda <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100dd3:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100dda:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100ddd:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100de0:	01 d0                	add    %edx,%eax
  100de2:	48 63 d8             	movslq %eax,%rbx
  100de5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100de9:	48 89 c7             	mov    %rax,%rdi
  100dec:	e8 ab f4 ff ff       	call   10029c <strlen>
  100df1:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100df5:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100df8:	29 d0                	sub    %edx,%eax
  100dfa:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100dfd:	eb 25                	jmp    100e24 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  100dff:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e06:	48 8b 08             	mov    (%rax),%rcx
  100e09:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e0f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e16:	be 20 00 00 00       	mov    $0x20,%esi
  100e1b:	48 89 c7             	mov    %rax,%rdi
  100e1e:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100e20:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100e24:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e27:	83 e0 04             	and    $0x4,%eax
  100e2a:	85 c0                	test   %eax,%eax
  100e2c:	75 36                	jne    100e64 <printer_vprintf+0x945>
  100e2e:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100e32:	7f cb                	jg     100dff <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  100e34:	eb 2e                	jmp    100e64 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  100e36:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e3d:	4c 8b 00             	mov    (%rax),%r8
  100e40:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e44:	0f b6 00             	movzbl (%rax),%eax
  100e47:	0f b6 c8             	movzbl %al,%ecx
  100e4a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e50:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e57:	89 ce                	mov    %ecx,%esi
  100e59:	48 89 c7             	mov    %rax,%rdi
  100e5c:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100e5f:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100e64:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e68:	0f b6 00             	movzbl (%rax),%eax
  100e6b:	84 c0                	test   %al,%al
  100e6d:	75 c7                	jne    100e36 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  100e6f:	eb 25                	jmp    100e96 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  100e71:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e78:	48 8b 08             	mov    (%rax),%rcx
  100e7b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e81:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e88:	be 30 00 00 00       	mov    $0x30,%esi
  100e8d:	48 89 c7             	mov    %rax,%rdi
  100e90:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100e92:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100e96:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100e9a:	7f d5                	jg     100e71 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  100e9c:	eb 32                	jmp    100ed0 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  100e9e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ea5:	4c 8b 00             	mov    (%rax),%r8
  100ea8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100eac:	0f b6 00             	movzbl (%rax),%eax
  100eaf:	0f b6 c8             	movzbl %al,%ecx
  100eb2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100eb8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ebf:	89 ce                	mov    %ecx,%esi
  100ec1:	48 89 c7             	mov    %rax,%rdi
  100ec4:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100ec7:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100ecc:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100ed0:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100ed4:	7f c8                	jg     100e9e <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  100ed6:	eb 25                	jmp    100efd <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  100ed8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100edf:	48 8b 08             	mov    (%rax),%rcx
  100ee2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ee8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100eef:	be 20 00 00 00       	mov    $0x20,%esi
  100ef4:	48 89 c7             	mov    %rax,%rdi
  100ef7:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100ef9:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100efd:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100f01:	7f d5                	jg     100ed8 <printer_vprintf+0x9b9>
        }
    done: ;
  100f03:	90                   	nop
    for (; *format; ++format) {
  100f04:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f0b:	01 
  100f0c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f13:	0f b6 00             	movzbl (%rax),%eax
  100f16:	84 c0                	test   %al,%al
  100f18:	0f 85 31 f6 ff ff    	jne    10054f <printer_vprintf+0x30>
    }
}
  100f1e:	90                   	nop
  100f1f:	90                   	nop
  100f20:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100f24:	c9                   	leave  
  100f25:	c3                   	ret    

0000000000100f26 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100f26:	f3 0f 1e fa          	endbr64 
  100f2a:	55                   	push   %rbp
  100f2b:	48 89 e5             	mov    %rsp,%rbp
  100f2e:	48 83 ec 20          	sub    $0x20,%rsp
  100f32:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100f36:	89 f0                	mov    %esi,%eax
  100f38:	89 55 e0             	mov    %edx,-0x20(%rbp)
  100f3b:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  100f3e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100f42:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100f46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f4a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f4e:	48 8d 15 4b 80 fb ff 	lea    -0x47fb5(%rip),%rdx        # b8fa0 <console+0xfa0>
  100f55:	48 39 d0             	cmp    %rdx,%rax
  100f58:	72 0f                	jb     100f69 <console_putc+0x43>
        cp->cursor = console;
  100f5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f5e:	48 8d 15 9b 70 fb ff 	lea    -0x48f65(%rip),%rdx        # b8000 <console>
  100f65:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  100f69:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  100f6d:	0f 85 82 00 00 00    	jne    100ff5 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  100f73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f77:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f7b:	48 8d 15 7e 70 fb ff 	lea    -0x48f82(%rip),%rdx        # b8000 <console>
  100f82:	48 29 d0             	sub    %rdx,%rax
  100f85:	48 d1 f8             	sar    %rax
  100f88:	48 89 c1             	mov    %rax,%rcx
  100f8b:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100f92:	66 66 66 
  100f95:	48 89 c8             	mov    %rcx,%rax
  100f98:	48 f7 ea             	imul   %rdx
  100f9b:	48 89 d0             	mov    %rdx,%rax
  100f9e:	48 c1 f8 05          	sar    $0x5,%rax
  100fa2:	48 89 ce             	mov    %rcx,%rsi
  100fa5:	48 c1 fe 3f          	sar    $0x3f,%rsi
  100fa9:	48 29 f0             	sub    %rsi,%rax
  100fac:	48 89 c2             	mov    %rax,%rdx
  100faf:	48 89 d0             	mov    %rdx,%rax
  100fb2:	48 c1 e0 02          	shl    $0x2,%rax
  100fb6:	48 01 d0             	add    %rdx,%rax
  100fb9:	48 c1 e0 04          	shl    $0x4,%rax
  100fbd:	48 29 c1             	sub    %rax,%rcx
  100fc0:	48 89 ca             	mov    %rcx,%rdx
  100fc3:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  100fc6:	eb 25                	jmp    100fed <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  100fc8:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100fcb:	83 c8 20             	or     $0x20,%eax
  100fce:	89 c6                	mov    %eax,%esi
  100fd0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100fd4:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fd8:	48 8d 48 02          	lea    0x2(%rax),%rcx
  100fdc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  100fe0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fe4:	89 f2                	mov    %esi,%edx
  100fe6:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  100fe9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  100fed:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  100ff1:	75 d5                	jne    100fc8 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  100ff3:	eb 24                	jmp    101019 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  100ff5:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  100ff9:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100ffc:	89 d6                	mov    %edx,%esi
  100ffe:	09 c6                	or     %eax,%esi
  101000:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101004:	48 8b 40 08          	mov    0x8(%rax),%rax
  101008:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10100c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101010:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101014:	89 f2                	mov    %esi,%edx
  101016:	66 89 10             	mov    %dx,(%rax)
}
  101019:	90                   	nop
  10101a:	c9                   	leave  
  10101b:	c3                   	ret    

000000000010101c <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10101c:	f3 0f 1e fa          	endbr64 
  101020:	55                   	push   %rbp
  101021:	48 89 e5             	mov    %rsp,%rbp
  101024:	48 83 ec 30          	sub    $0x30,%rsp
  101028:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10102b:	89 75 e8             	mov    %esi,-0x18(%rbp)
  10102e:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101032:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101036:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 100f26 <console_putc>
  10103d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101041:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101045:	78 09                	js     101050 <console_vprintf+0x34>
  101047:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  10104e:	7e 07                	jle    101057 <console_vprintf+0x3b>
        cpos = 0;
  101050:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101057:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10105a:	48 98                	cltq   
  10105c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101060:	48 8d 05 99 6f fb ff 	lea    -0x49067(%rip),%rax        # b8000 <console>
  101067:	48 01 d0             	add    %rdx,%rax
  10106a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  10106e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101072:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101076:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101079:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  10107d:	48 89 c7             	mov    %rax,%rdi
  101080:	e8 9a f4 ff ff       	call   10051f <printer_vprintf>
    return cp.cursor - console;
  101085:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101089:	48 8d 15 70 6f fb ff 	lea    -0x49090(%rip),%rdx        # b8000 <console>
  101090:	48 29 d0             	sub    %rdx,%rax
  101093:	48 d1 f8             	sar    %rax
}
  101096:	c9                   	leave  
  101097:	c3                   	ret    

0000000000101098 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101098:	f3 0f 1e fa          	endbr64 
  10109c:	55                   	push   %rbp
  10109d:	48 89 e5             	mov    %rsp,%rbp
  1010a0:	48 83 ec 60          	sub    $0x60,%rsp
  1010a4:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1010a7:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1010aa:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1010ae:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1010b2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1010b6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1010ba:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1010c1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1010c5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1010c9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1010cd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1010d1:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1010d5:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1010d9:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1010dc:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1010df:	89 c7                	mov    %eax,%edi
  1010e1:	e8 36 ff ff ff       	call   10101c <console_vprintf>
  1010e6:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1010e9:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1010ec:	c9                   	leave  
  1010ed:	c3                   	ret    

00000000001010ee <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1010ee:	f3 0f 1e fa          	endbr64 
  1010f2:	55                   	push   %rbp
  1010f3:	48 89 e5             	mov    %rsp,%rbp
  1010f6:	48 83 ec 20          	sub    $0x20,%rsp
  1010fa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1010fe:	89 f0                	mov    %esi,%eax
  101100:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101103:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101106:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10110a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  10110e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101112:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101116:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10111a:	48 8b 40 10          	mov    0x10(%rax),%rax
  10111e:	48 39 c2             	cmp    %rax,%rdx
  101121:	73 1a                	jae    10113d <string_putc+0x4f>
        *sp->s++ = c;
  101123:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101127:	48 8b 40 08          	mov    0x8(%rax),%rax
  10112b:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10112f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101133:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101137:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10113b:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  10113d:	90                   	nop
  10113e:	c9                   	leave  
  10113f:	c3                   	ret    

0000000000101140 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101140:	f3 0f 1e fa          	endbr64 
  101144:	55                   	push   %rbp
  101145:	48 89 e5             	mov    %rsp,%rbp
  101148:	48 83 ec 40          	sub    $0x40,%rsp
  10114c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101150:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101154:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101158:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10115c:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 1010ee <string_putc>
  101163:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  101167:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10116b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  10116f:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101174:	74 33                	je     1011a9 <vsnprintf+0x69>
        sp.end = s + size - 1;
  101176:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  10117a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10117e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101182:	48 01 d0             	add    %rdx,%rax
  101185:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101189:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  10118d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101191:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101195:	be 00 00 00 00       	mov    $0x0,%esi
  10119a:	48 89 c7             	mov    %rax,%rdi
  10119d:	e8 7d f3 ff ff       	call   10051f <printer_vprintf>
        *sp.s = 0;
  1011a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011a6:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1011a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011ad:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1011b1:	c9                   	leave  
  1011b2:	c3                   	ret    

00000000001011b3 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1011b3:	f3 0f 1e fa          	endbr64 
  1011b7:	55                   	push   %rbp
  1011b8:	48 89 e5             	mov    %rsp,%rbp
  1011bb:	48 83 ec 70          	sub    $0x70,%rsp
  1011bf:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1011c3:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1011c7:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1011cb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1011cf:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1011d3:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1011d7:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1011de:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1011e2:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1011e6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1011ea:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1011ee:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1011f2:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1011f6:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1011fa:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1011fe:	48 89 c7             	mov    %rax,%rdi
  101201:	e8 3a ff ff ff       	call   101140 <vsnprintf>
  101206:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101209:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10120c:	c9                   	leave  
  10120d:	c3                   	ret    

000000000010120e <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10120e:	f3 0f 1e fa          	endbr64 
  101212:	55                   	push   %rbp
  101213:	48 89 e5             	mov    %rsp,%rbp
  101216:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10121a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101221:	eb 1a                	jmp    10123d <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101223:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101226:	48 98                	cltq   
  101228:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  10122c:	48 8d 05 cd 6d fb ff 	lea    -0x49233(%rip),%rax        # b8000 <console>
  101233:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101239:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10123d:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101244:	7e dd                	jle    101223 <console_clear+0x15>
    }
    cursorpos = 0;
  101246:	c7 05 ac 7d fb ff 00 	movl   $0x0,-0x48254(%rip)        # b8ffc <cursorpos>
  10124d:	00 00 00 
}
  101250:	90                   	nop
  101251:	c9                   	leave  
  101252:	c3                   	ret    
