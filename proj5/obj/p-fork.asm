
obj/p-fork.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
// Program that forks thrice to produce a total of 4 processes
// Each process keeps allocating memory till stack bottom is reached
// OR system is out of memory
// after that, each process loops forever

void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	53                   	push   %rbx
  100009:	48 83 ec 08          	sub    $0x8,%rsp
// sys_fork()
//    Fork the current process. On success, return the child's process ID to
//    the parent, and return 0 to the child. On failure, return -1.
static inline pid_t sys_fork(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000d:	cd 34                	int    $0x34
    // Fork a total of three new copies.
    pid_t p1 = sys_fork();
    assert(p1 >= 0);
  10000f:	85 c0                	test   %eax,%eax
  100011:	78 52                	js     100065 <process_main+0x65>
  100013:	89 c2                	mov    %eax,%edx
  100015:	cd 34                	int    $0x34
  100017:	89 c1                	mov    %eax,%ecx
    pid_t p2 = sys_fork();
    assert(p2 >= 0);
  100019:	85 c0                	test   %eax,%eax
  10001b:	78 60                	js     10007d <process_main+0x7d>
    asm volatile ("int %1" : "=a" (result)
  10001d:	cd 31                	int    $0x31

    // Check fork return values: fork should return 0 to child.
    if (sys_getpid() == 1) {
  10001f:	83 f8 01             	cmp    $0x1,%eax
  100022:	74 71                	je     100095 <process_main+0x95>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
    } else {
        assert(p1 == 0 || p2 == 0);
  100024:	85 d2                	test   %edx,%edx
  100026:	74 08                	je     100030 <process_main+0x30>
  100028:	85 c9                	test   %ecx,%ecx
  10002a:	0f 85 8f 00 00 00    	jne    1000bf <process_main+0xbf>
  100030:	cd 31                	int    $0x31
  100032:	89 c3                	mov    %eax,%ebx
    }

    // The rest of this code is like p-allocator.c.

    pid_t p = sys_getpid();
    srand(p);
  100034:	89 c7                	mov    %eax,%edi
  100036:	e8 b0 05 00 00       	call   1005eb <srand>

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10003b:	48 8d 05 d5 2f 00 00 	lea    0x2fd5(%rip),%rax        # 103017 <end+0xfff>
  100042:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100048:	48 89 05 b9 1f 00 00 	mov    %rax,0x1fb9(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10004f:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100052:	48 83 e8 01          	sub    $0x1,%rax
  100056:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10005c:	48 89 05 9d 1f 00 00 	mov    %rax,0x1f9d(%rip)        # 102000 <stack_bottom>
  100063:	eb 74                	jmp    1000d9 <process_main+0xd9>
    assert(p1 >= 0);
  100065:	48 8d 15 64 13 00 00 	lea    0x1364(%rip),%rdx        # 1013d0 <console_clear+0x45>
  10006c:	be 12 00 00 00       	mov    $0x12,%esi
  100071:	48 8d 3d 60 13 00 00 	lea    0x1360(%rip),%rdi        # 1013d8 <console_clear+0x4d>
  100078:	e8 1e 02 00 00       	call   10029b <assert_fail>
    assert(p2 >= 0);
  10007d:	48 8d 15 64 13 00 00 	lea    0x1364(%rip),%rdx        # 1013e8 <console_clear+0x5d>
  100084:	be 14 00 00 00       	mov    $0x14,%esi
  100089:	48 8d 3d 48 13 00 00 	lea    0x1348(%rip),%rdi        # 1013d8 <console_clear+0x4d>
  100090:	e8 06 02 00 00       	call   10029b <assert_fail>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
  100095:	85 c9                	test   %ecx,%ecx
  100097:	0f 94 c0             	sete   %al
  10009a:	39 ca                	cmp    %ecx,%edx
  10009c:	0f 94 c1             	sete   %cl
  10009f:	08 c8                	or     %cl,%al
  1000a1:	75 04                	jne    1000a7 <process_main+0xa7>
  1000a3:	85 d2                	test   %edx,%edx
  1000a5:	75 89                	jne    100030 <process_main+0x30>
  1000a7:	48 8d 15 5a 13 00 00 	lea    0x135a(%rip),%rdx        # 101408 <console_clear+0x7d>
  1000ae:	be 18 00 00 00       	mov    $0x18,%esi
  1000b3:	48 8d 3d 1e 13 00 00 	lea    0x131e(%rip),%rdi        # 1013d8 <console_clear+0x4d>
  1000ba:	e8 dc 01 00 00       	call   10029b <assert_fail>
        assert(p1 == 0 || p2 == 0);
  1000bf:	48 8d 15 2a 13 00 00 	lea    0x132a(%rip),%rdx        # 1013f0 <console_clear+0x65>
  1000c6:	be 1a 00 00 00       	mov    $0x1a,%esi
  1000cb:	48 8d 3d 06 13 00 00 	lea    0x1306(%rip),%rdi        # 1013d8 <console_clear+0x4d>
  1000d2:	e8 c4 01 00 00       	call   10029b <assert_fail>
    asm volatile ("int %0" : /* no result */
  1000d7:	cd 32                	int    $0x32

    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  1000d9:	e8 cd 04 00 00       	call   1005ab <rand>
  1000de:	48 63 d0             	movslq %eax,%rdx
  1000e1:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1000e8:	48 c1 fa 25          	sar    $0x25,%rdx
  1000ec:	89 c1                	mov    %eax,%ecx
  1000ee:	c1 f9 1f             	sar    $0x1f,%ecx
  1000f1:	29 ca                	sub    %ecx,%edx
  1000f3:	6b d2 64             	imul   $0x64,%edx,%edx
  1000f6:	29 d0                	sub    %edx,%eax
  1000f8:	39 d8                	cmp    %ebx,%eax
  1000fa:	7d db                	jge    1000d7 <process_main+0xd7>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  1000fc:	48 8b 3d 05 1f 00 00 	mov    0x1f05(%rip),%rdi        # 102008 <heap_top>
  100103:	48 3b 3d f6 1e 00 00 	cmp    0x1ef6(%rip),%rdi        # 102000 <stack_bottom>
  10010a:	74 1c                	je     100128 <process_main+0x128>
    asm volatile ("int %1" : "=a" (result)
  10010c:	cd 33                	int    $0x33
  10010e:	85 c0                	test   %eax,%eax
  100110:	78 16                	js     100128 <process_main+0x128>
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
  100112:	48 8b 05 ef 1e 00 00 	mov    0x1eef(%rip),%rax        # 102008 <heap_top>
  100119:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  10011b:	48 81 05 e2 1e 00 00 	addq   $0x1000,0x1ee2(%rip)        # 102008 <heap_top>
  100122:	00 10 00 00 
  100126:	eb af                	jmp    1000d7 <process_main+0xd7>
    asm volatile ("int %0" : /* no result */
  100128:	cd 32                	int    $0x32
  10012a:	eb fc                	jmp    100128 <process_main+0x128>

000000000010012c <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  10012c:	f3 0f 1e fa          	endbr64 
  100130:	55                   	push   %rbp
  100131:	48 89 e5             	mov    %rsp,%rbp
  100134:	48 83 ec 50          	sub    $0x50,%rsp
  100138:	49 89 f2             	mov    %rsi,%r10
  10013b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10013f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100143:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100147:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  10014b:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100150:	85 ff                	test   %edi,%edi
  100152:	78 32                	js     100186 <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100154:	48 63 ff             	movslq %edi,%rdi
  100157:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  10015e:	cc cc cc 
  100161:	48 89 f8             	mov    %rdi,%rax
  100164:	48 f7 e2             	mul    %rdx
  100167:	48 89 d0             	mov    %rdx,%rax
  10016a:	48 c1 e8 02          	shr    $0x2,%rax
  10016e:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100172:	48 01 c2             	add    %rax,%rdx
  100175:	48 29 d7             	sub    %rdx,%rdi
  100178:	48 8d 05 de 12 00 00 	lea    0x12de(%rip),%rax        # 10145d <col.0>
  10017f:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  100183:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100186:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  10018d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100191:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100195:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100199:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  10019d:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1001a1:	4c 89 d2             	mov    %r10,%rdx
  1001a4:	8b 3d 52 8e fb ff    	mov    -0x471ae(%rip),%edi        # b8ffc <cursorpos>
  1001aa:	e8 ea 0f 00 00       	call   101199 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1001af:	3d 30 07 00 00       	cmp    $0x730,%eax
  1001b4:	ba 00 00 00 00       	mov    $0x0,%edx
  1001b9:	0f 4d c2             	cmovge %edx,%eax
  1001bc:	89 05 3a 8e fb ff    	mov    %eax,-0x471c6(%rip)        # b8ffc <cursorpos>
    }
}
  1001c2:	c9                   	leave  
  1001c3:	c3                   	ret    

00000000001001c4 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  1001c4:	f3 0f 1e fa          	endbr64 
  1001c8:	55                   	push   %rbp
  1001c9:	48 89 e5             	mov    %rsp,%rbp
  1001cc:	53                   	push   %rbx
  1001cd:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  1001d4:	48 89 fb             	mov    %rdi,%rbx
  1001d7:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  1001db:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  1001df:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  1001e3:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  1001e7:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  1001eb:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1001f2:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001f6:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1001fa:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1001fe:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100202:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100209:	ba 07 00 00 00       	mov    $0x7,%edx
  10020e:	48 8d 35 12 12 00 00 	lea    0x1212(%rip),%rsi        # 101427 <console_clear+0x9c>
  100215:	e8 b6 00 00 00       	call   1002d0 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  10021a:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  10021e:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100225:	48 89 da             	mov    %rbx,%rdx
  100228:	be 99 00 00 00       	mov    $0x99,%esi
  10022d:	e8 8b 10 00 00       	call   1012bd <vsnprintf>
  100232:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100235:	85 d2                	test   %edx,%edx
  100237:	7e 0f                	jle    100248 <panic+0x84>
  100239:	83 c0 06             	add    $0x6,%eax
  10023c:	48 98                	cltq   
  10023e:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100245:	0a 
  100246:	75 2b                	jne    100273 <panic+0xaf>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100248:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  10024f:	48 8d 15 db 11 00 00 	lea    0x11db(%rip),%rdx        # 101431 <console_clear+0xa6>
  100256:	be 00 c0 00 00       	mov    $0xc000,%esi
  10025b:	bf 30 07 00 00       	mov    $0x730,%edi
  100260:	b8 00 00 00 00       	mov    $0x0,%eax
  100265:	e8 ab 0f 00 00       	call   101215 <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  10026a:	bf 00 00 00 00       	mov    $0x0,%edi
  10026f:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  100271:	eb fe                	jmp    100271 <panic+0xad>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100273:	48 63 c2             	movslq %edx,%rax
  100276:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  10027c:	0f 94 c2             	sete   %dl
  10027f:	0f b6 d2             	movzbl %dl,%edx
  100282:	48 29 d0             	sub    %rdx,%rax
  100285:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  10028c:	ff 
  10028d:	48 8d 35 9b 11 00 00 	lea    0x119b(%rip),%rsi        # 10142f <console_clear+0xa4>
  100294:	e8 f8 01 00 00       	call   100491 <strcpy>
  100299:	eb ad                	jmp    100248 <panic+0x84>

000000000010029b <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  10029b:	f3 0f 1e fa          	endbr64 
  10029f:	55                   	push   %rbp
  1002a0:	48 89 e5             	mov    %rsp,%rbp
  1002a3:	48 89 f9             	mov    %rdi,%rcx
  1002a6:	41 89 f0             	mov    %esi,%r8d
  1002a9:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1002ac:	48 8d 15 85 11 00 00 	lea    0x1185(%rip),%rdx        # 101438 <console_clear+0xad>
  1002b3:	be 00 c0 00 00       	mov    $0xc000,%esi
  1002b8:	bf 30 07 00 00       	mov    $0x730,%edi
  1002bd:	b8 00 00 00 00       	mov    $0x0,%eax
  1002c2:	e8 4e 0f 00 00       	call   101215 <console_printf>
    asm volatile ("int %0" : /* no result */
  1002c7:	bf 00 00 00 00       	mov    $0x0,%edi
  1002cc:	cd 30                	int    $0x30
 loop: goto loop;
  1002ce:	eb fe                	jmp    1002ce <assert_fail+0x33>

00000000001002d0 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1002d0:	f3 0f 1e fa          	endbr64 
  1002d4:	55                   	push   %rbp
  1002d5:	48 89 e5             	mov    %rsp,%rbp
  1002d8:	48 83 ec 28          	sub    $0x28,%rsp
  1002dc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002e0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1002e4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002e8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002ec:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002f4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1002f8:	eb 1c                	jmp    100316 <memcpy+0x46>
        *d = *s;
  1002fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002fe:	0f b6 10             	movzbl (%rax),%edx
  100301:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100305:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100307:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10030c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100311:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100316:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10031b:	75 dd                	jne    1002fa <memcpy+0x2a>
    }
    return dst;
  10031d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100321:	c9                   	leave  
  100322:	c3                   	ret    

0000000000100323 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100323:	f3 0f 1e fa          	endbr64 
  100327:	55                   	push   %rbp
  100328:	48 89 e5             	mov    %rsp,%rbp
  10032b:	48 83 ec 28          	sub    $0x28,%rsp
  10032f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100333:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100337:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10033b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10033f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100343:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100347:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  10034b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10034f:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100353:	73 6a                	jae    1003bf <memmove+0x9c>
  100355:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100359:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10035d:	48 01 d0             	add    %rdx,%rax
  100360:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100364:	73 59                	jae    1003bf <memmove+0x9c>
        s += n, d += n;
  100366:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10036a:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  10036e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100372:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100376:	eb 17                	jmp    10038f <memmove+0x6c>
            *--d = *--s;
  100378:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  10037d:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100382:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100386:	0f b6 10             	movzbl (%rax),%edx
  100389:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10038d:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10038f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100393:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100397:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10039b:	48 85 c0             	test   %rax,%rax
  10039e:	75 d8                	jne    100378 <memmove+0x55>
    if (s < d && s + n > d) {
  1003a0:	eb 2e                	jmp    1003d0 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1003a2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1003a6:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003b2:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003b6:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1003ba:	0f b6 12             	movzbl (%rdx),%edx
  1003bd:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003bf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003c3:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003c7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003cb:	48 85 c0             	test   %rax,%rax
  1003ce:	75 d2                	jne    1003a2 <memmove+0x7f>
        }
    }
    return dst;
  1003d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003d4:	c9                   	leave  
  1003d5:	c3                   	ret    

00000000001003d6 <memset>:

void* memset(void* v, int c, size_t n) {
  1003d6:	f3 0f 1e fa          	endbr64 
  1003da:	55                   	push   %rbp
  1003db:	48 89 e5             	mov    %rsp,%rbp
  1003de:	48 83 ec 28          	sub    $0x28,%rsp
  1003e2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003e6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1003e9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003f1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003f5:	eb 15                	jmp    10040c <memset+0x36>
        *p = c;
  1003f7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1003fa:	89 c2                	mov    %eax,%edx
  1003fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100400:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100402:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100407:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10040c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100411:	75 e4                	jne    1003f7 <memset+0x21>
    }
    return v;
  100413:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100417:	c9                   	leave  
  100418:	c3                   	ret    

0000000000100419 <strlen>:

size_t strlen(const char* s) {
  100419:	f3 0f 1e fa          	endbr64 
  10041d:	55                   	push   %rbp
  10041e:	48 89 e5             	mov    %rsp,%rbp
  100421:	48 83 ec 18          	sub    $0x18,%rsp
  100425:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100429:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100430:	00 
  100431:	eb 0a                	jmp    10043d <strlen+0x24>
        ++n;
  100433:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100438:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10043d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100441:	0f b6 00             	movzbl (%rax),%eax
  100444:	84 c0                	test   %al,%al
  100446:	75 eb                	jne    100433 <strlen+0x1a>
    }
    return n;
  100448:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10044c:	c9                   	leave  
  10044d:	c3                   	ret    

000000000010044e <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  10044e:	f3 0f 1e fa          	endbr64 
  100452:	55                   	push   %rbp
  100453:	48 89 e5             	mov    %rsp,%rbp
  100456:	48 83 ec 20          	sub    $0x20,%rsp
  10045a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10045e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100462:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100469:	00 
  10046a:	eb 0a                	jmp    100476 <strnlen+0x28>
        ++n;
  10046c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100471:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100476:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10047a:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  10047e:	74 0b                	je     10048b <strnlen+0x3d>
  100480:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100484:	0f b6 00             	movzbl (%rax),%eax
  100487:	84 c0                	test   %al,%al
  100489:	75 e1                	jne    10046c <strnlen+0x1e>
    }
    return n;
  10048b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10048f:	c9                   	leave  
  100490:	c3                   	ret    

0000000000100491 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100491:	f3 0f 1e fa          	endbr64 
  100495:	55                   	push   %rbp
  100496:	48 89 e5             	mov    %rsp,%rbp
  100499:	48 83 ec 20          	sub    $0x20,%rsp
  10049d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004a1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1004a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004a9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1004ad:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1004b1:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004b5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1004b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004bd:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004c1:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1004c5:	0f b6 12             	movzbl (%rdx),%edx
  1004c8:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1004ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004ce:	48 83 e8 01          	sub    $0x1,%rax
  1004d2:	0f b6 00             	movzbl (%rax),%eax
  1004d5:	84 c0                	test   %al,%al
  1004d7:	75 d4                	jne    1004ad <strcpy+0x1c>
    return dst;
  1004d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1004dd:	c9                   	leave  
  1004de:	c3                   	ret    

00000000001004df <strcmp>:

int strcmp(const char* a, const char* b) {
  1004df:	f3 0f 1e fa          	endbr64 
  1004e3:	55                   	push   %rbp
  1004e4:	48 89 e5             	mov    %rsp,%rbp
  1004e7:	48 83 ec 10          	sub    $0x10,%rsp
  1004eb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004ef:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004f3:	eb 0a                	jmp    1004ff <strcmp+0x20>
        ++a, ++b;
  1004f5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1004fa:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100503:	0f b6 00             	movzbl (%rax),%eax
  100506:	84 c0                	test   %al,%al
  100508:	74 1d                	je     100527 <strcmp+0x48>
  10050a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10050e:	0f b6 00             	movzbl (%rax),%eax
  100511:	84 c0                	test   %al,%al
  100513:	74 12                	je     100527 <strcmp+0x48>
  100515:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100519:	0f b6 10             	movzbl (%rax),%edx
  10051c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100520:	0f b6 00             	movzbl (%rax),%eax
  100523:	38 c2                	cmp    %al,%dl
  100525:	74 ce                	je     1004f5 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100527:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10052b:	0f b6 00             	movzbl (%rax),%eax
  10052e:	89 c2                	mov    %eax,%edx
  100530:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100534:	0f b6 00             	movzbl (%rax),%eax
  100537:	38 c2                	cmp    %al,%dl
  100539:	0f 97 c0             	seta   %al
  10053c:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  10053f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100543:	0f b6 00             	movzbl (%rax),%eax
  100546:	89 c1                	mov    %eax,%ecx
  100548:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10054c:	0f b6 00             	movzbl (%rax),%eax
  10054f:	38 c1                	cmp    %al,%cl
  100551:	0f 92 c0             	setb   %al
  100554:	0f b6 c8             	movzbl %al,%ecx
  100557:	89 d0                	mov    %edx,%eax
  100559:	29 c8                	sub    %ecx,%eax
}
  10055b:	c9                   	leave  
  10055c:	c3                   	ret    

000000000010055d <strchr>:

char* strchr(const char* s, int c) {
  10055d:	f3 0f 1e fa          	endbr64 
  100561:	55                   	push   %rbp
  100562:	48 89 e5             	mov    %rsp,%rbp
  100565:	48 83 ec 10          	sub    $0x10,%rsp
  100569:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10056d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100570:	eb 05                	jmp    100577 <strchr+0x1a>
        ++s;
  100572:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100577:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10057b:	0f b6 00             	movzbl (%rax),%eax
  10057e:	84 c0                	test   %al,%al
  100580:	74 0e                	je     100590 <strchr+0x33>
  100582:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100586:	0f b6 00             	movzbl (%rax),%eax
  100589:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10058c:	38 d0                	cmp    %dl,%al
  10058e:	75 e2                	jne    100572 <strchr+0x15>
    }
    if (*s == (char) c) {
  100590:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100594:	0f b6 00             	movzbl (%rax),%eax
  100597:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10059a:	38 d0                	cmp    %dl,%al
  10059c:	75 06                	jne    1005a4 <strchr+0x47>
        return (char*) s;
  10059e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005a2:	eb 05                	jmp    1005a9 <strchr+0x4c>
    } else {
        return NULL;
  1005a4:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1005a9:	c9                   	leave  
  1005aa:	c3                   	ret    

00000000001005ab <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1005ab:	f3 0f 1e fa          	endbr64 
  1005af:	55                   	push   %rbp
  1005b0:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1005b3:	8b 05 57 1a 00 00    	mov    0x1a57(%rip),%eax        # 102010 <rand_seed_set>
  1005b9:	85 c0                	test   %eax,%eax
  1005bb:	75 0a                	jne    1005c7 <rand+0x1c>
        srand(819234718U);
  1005bd:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1005c2:	e8 24 00 00 00       	call   1005eb <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1005c7:	8b 05 47 1a 00 00    	mov    0x1a47(%rip),%eax        # 102014 <rand_seed>
  1005cd:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1005d3:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1005d8:	89 05 36 1a 00 00    	mov    %eax,0x1a36(%rip)        # 102014 <rand_seed>
    return rand_seed & RAND_MAX;
  1005de:	8b 05 30 1a 00 00    	mov    0x1a30(%rip),%eax        # 102014 <rand_seed>
  1005e4:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1005e9:	5d                   	pop    %rbp
  1005ea:	c3                   	ret    

00000000001005eb <srand>:

void srand(unsigned seed) {
  1005eb:	f3 0f 1e fa          	endbr64 
  1005ef:	55                   	push   %rbp
  1005f0:	48 89 e5             	mov    %rsp,%rbp
  1005f3:	48 83 ec 08          	sub    $0x8,%rsp
  1005f7:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1005fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1005fd:	89 05 11 1a 00 00    	mov    %eax,0x1a11(%rip)        # 102014 <rand_seed>
    rand_seed_set = 1;
  100603:	c7 05 03 1a 00 00 01 	movl   $0x1,0x1a03(%rip)        # 102010 <rand_seed_set>
  10060a:	00 00 00 
}
  10060d:	90                   	nop
  10060e:	c9                   	leave  
  10060f:	c3                   	ret    

0000000000100610 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100610:	f3 0f 1e fa          	endbr64 
  100614:	55                   	push   %rbp
  100615:	48 89 e5             	mov    %rsp,%rbp
  100618:	48 83 ec 28          	sub    $0x28,%rsp
  10061c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100620:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100624:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100627:	48 8d 05 42 0f 00 00 	lea    0xf42(%rip),%rax        # 101570 <upper_digits.1>
  10062e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  100632:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100636:	79 0e                	jns    100646 <fill_numbuf+0x36>
        digits = lower_digits;
  100638:	48 8d 05 51 0f 00 00 	lea    0xf51(%rip),%rax        # 101590 <lower_digits.0>
  10063f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  100643:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100646:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10064b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10064f:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100652:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100655:	48 63 c8             	movslq %eax,%rcx
  100658:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10065c:	ba 00 00 00 00       	mov    $0x0,%edx
  100661:	48 f7 f1             	div    %rcx
  100664:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100668:	48 01 d0             	add    %rdx,%rax
  10066b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100670:	0f b6 10             	movzbl (%rax),%edx
  100673:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100677:	88 10                	mov    %dl,(%rax)
        val /= base;
  100679:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10067c:	48 63 f0             	movslq %eax,%rsi
  10067f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100683:	ba 00 00 00 00       	mov    $0x0,%edx
  100688:	48 f7 f6             	div    %rsi
  10068b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  10068f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100694:	75 bc                	jne    100652 <fill_numbuf+0x42>
    return numbuf_end;
  100696:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10069a:	c9                   	leave  
  10069b:	c3                   	ret    

000000000010069c <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10069c:	f3 0f 1e fa          	endbr64 
  1006a0:	55                   	push   %rbp
  1006a1:	48 89 e5             	mov    %rsp,%rbp
  1006a4:	53                   	push   %rbx
  1006a5:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1006ac:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1006b3:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1006b9:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1006c0:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1006c7:	e9 bd 09 00 00       	jmp    101089 <printer_vprintf+0x9ed>
        if (*format != '%') {
  1006cc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006d3:	0f b6 00             	movzbl (%rax),%eax
  1006d6:	3c 25                	cmp    $0x25,%al
  1006d8:	74 31                	je     10070b <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  1006da:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006e1:	4c 8b 00             	mov    (%rax),%r8
  1006e4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006eb:	0f b6 00             	movzbl (%rax),%eax
  1006ee:	0f b6 c8             	movzbl %al,%ecx
  1006f1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1006f7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006fe:	89 ce                	mov    %ecx,%esi
  100700:	48 89 c7             	mov    %rax,%rdi
  100703:	41 ff d0             	call   *%r8
            continue;
  100706:	e9 76 09 00 00       	jmp    101081 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  10070b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100712:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100719:	01 
  10071a:	eb 4d                	jmp    100769 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  10071c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100723:	0f b6 00             	movzbl (%rax),%eax
  100726:	0f be c0             	movsbl %al,%eax
  100729:	89 c6                	mov    %eax,%esi
  10072b:	48 8d 05 3e 0d 00 00 	lea    0xd3e(%rip),%rax        # 101470 <flag_chars>
  100732:	48 89 c7             	mov    %rax,%rdi
  100735:	e8 23 fe ff ff       	call   10055d <strchr>
  10073a:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  10073e:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100743:	74 34                	je     100779 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  100745:	48 8d 15 24 0d 00 00 	lea    0xd24(%rip),%rdx        # 101470 <flag_chars>
  10074c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100750:	48 29 d0             	sub    %rdx,%rax
  100753:	ba 01 00 00 00       	mov    $0x1,%edx
  100758:	89 c1                	mov    %eax,%ecx
  10075a:	d3 e2                	shl    %cl,%edx
  10075c:	89 d0                	mov    %edx,%eax
  10075e:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100761:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100768:	01 
  100769:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100770:	0f b6 00             	movzbl (%rax),%eax
  100773:	84 c0                	test   %al,%al
  100775:	75 a5                	jne    10071c <printer_vprintf+0x80>
  100777:	eb 01                	jmp    10077a <printer_vprintf+0xde>
            } else {
                break;
  100779:	90                   	nop
            }
        }

        // process width
        int width = -1;
  10077a:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100781:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100788:	0f b6 00             	movzbl (%rax),%eax
  10078b:	3c 30                	cmp    $0x30,%al
  10078d:	7e 67                	jle    1007f6 <printer_vprintf+0x15a>
  10078f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100796:	0f b6 00             	movzbl (%rax),%eax
  100799:	3c 39                	cmp    $0x39,%al
  10079b:	7f 59                	jg     1007f6 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10079d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1007a4:	eb 2e                	jmp    1007d4 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  1007a6:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1007a9:	89 d0                	mov    %edx,%eax
  1007ab:	c1 e0 02             	shl    $0x2,%eax
  1007ae:	01 d0                	add    %edx,%eax
  1007b0:	01 c0                	add    %eax,%eax
  1007b2:	89 c1                	mov    %eax,%ecx
  1007b4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007bb:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1007bf:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007c6:	0f b6 00             	movzbl (%rax),%eax
  1007c9:	0f be c0             	movsbl %al,%eax
  1007cc:	01 c8                	add    %ecx,%eax
  1007ce:	83 e8 30             	sub    $0x30,%eax
  1007d1:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1007d4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007db:	0f b6 00             	movzbl (%rax),%eax
  1007de:	3c 2f                	cmp    $0x2f,%al
  1007e0:	0f 8e 85 00 00 00    	jle    10086b <printer_vprintf+0x1cf>
  1007e6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007ed:	0f b6 00             	movzbl (%rax),%eax
  1007f0:	3c 39                	cmp    $0x39,%al
  1007f2:	7e b2                	jle    1007a6 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  1007f4:	eb 75                	jmp    10086b <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  1007f6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007fd:	0f b6 00             	movzbl (%rax),%eax
  100800:	3c 2a                	cmp    $0x2a,%al
  100802:	75 68                	jne    10086c <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  100804:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10080b:	8b 00                	mov    (%rax),%eax
  10080d:	83 f8 2f             	cmp    $0x2f,%eax
  100810:	77 30                	ja     100842 <printer_vprintf+0x1a6>
  100812:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100819:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10081d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100824:	8b 00                	mov    (%rax),%eax
  100826:	89 c0                	mov    %eax,%eax
  100828:	48 01 d0             	add    %rdx,%rax
  10082b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100832:	8b 12                	mov    (%rdx),%edx
  100834:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100837:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10083e:	89 0a                	mov    %ecx,(%rdx)
  100840:	eb 1a                	jmp    10085c <printer_vprintf+0x1c0>
  100842:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100849:	48 8b 40 08          	mov    0x8(%rax),%rax
  10084d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100851:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100858:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10085c:	8b 00                	mov    (%rax),%eax
  10085e:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100861:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100868:	01 
  100869:	eb 01                	jmp    10086c <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  10086b:	90                   	nop
        }

        // process precision
        int precision = -1;
  10086c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100873:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10087a:	0f b6 00             	movzbl (%rax),%eax
  10087d:	3c 2e                	cmp    $0x2e,%al
  10087f:	0f 85 00 01 00 00    	jne    100985 <printer_vprintf+0x2e9>
            ++format;
  100885:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10088c:	01 
            if (*format >= '0' && *format <= '9') {
  10088d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100894:	0f b6 00             	movzbl (%rax),%eax
  100897:	3c 2f                	cmp    $0x2f,%al
  100899:	7e 67                	jle    100902 <printer_vprintf+0x266>
  10089b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008a2:	0f b6 00             	movzbl (%rax),%eax
  1008a5:	3c 39                	cmp    $0x39,%al
  1008a7:	7f 59                	jg     100902 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008a9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1008b0:	eb 2e                	jmp    1008e0 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  1008b2:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1008b5:	89 d0                	mov    %edx,%eax
  1008b7:	c1 e0 02             	shl    $0x2,%eax
  1008ba:	01 d0                	add    %edx,%eax
  1008bc:	01 c0                	add    %eax,%eax
  1008be:	89 c1                	mov    %eax,%ecx
  1008c0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008c7:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1008cb:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008d2:	0f b6 00             	movzbl (%rax),%eax
  1008d5:	0f be c0             	movsbl %al,%eax
  1008d8:	01 c8                	add    %ecx,%eax
  1008da:	83 e8 30             	sub    $0x30,%eax
  1008dd:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008e0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008e7:	0f b6 00             	movzbl (%rax),%eax
  1008ea:	3c 2f                	cmp    $0x2f,%al
  1008ec:	0f 8e 85 00 00 00    	jle    100977 <printer_vprintf+0x2db>
  1008f2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008f9:	0f b6 00             	movzbl (%rax),%eax
  1008fc:	3c 39                	cmp    $0x39,%al
  1008fe:	7e b2                	jle    1008b2 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  100900:	eb 75                	jmp    100977 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  100902:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100909:	0f b6 00             	movzbl (%rax),%eax
  10090c:	3c 2a                	cmp    $0x2a,%al
  10090e:	75 68                	jne    100978 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  100910:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100917:	8b 00                	mov    (%rax),%eax
  100919:	83 f8 2f             	cmp    $0x2f,%eax
  10091c:	77 30                	ja     10094e <printer_vprintf+0x2b2>
  10091e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100925:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100929:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100930:	8b 00                	mov    (%rax),%eax
  100932:	89 c0                	mov    %eax,%eax
  100934:	48 01 d0             	add    %rdx,%rax
  100937:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10093e:	8b 12                	mov    (%rdx),%edx
  100940:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100943:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10094a:	89 0a                	mov    %ecx,(%rdx)
  10094c:	eb 1a                	jmp    100968 <printer_vprintf+0x2cc>
  10094e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100955:	48 8b 40 08          	mov    0x8(%rax),%rax
  100959:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10095d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100964:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100968:	8b 00                	mov    (%rax),%eax
  10096a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  10096d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100974:	01 
  100975:	eb 01                	jmp    100978 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  100977:	90                   	nop
            }
            if (precision < 0) {
  100978:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10097c:	79 07                	jns    100985 <printer_vprintf+0x2e9>
                precision = 0;
  10097e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100985:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  10098c:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100993:	00 
        int length = 0;
  100994:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  10099b:	48 8d 05 d4 0a 00 00 	lea    0xad4(%rip),%rax        # 101476 <flag_chars+0x6>
  1009a2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  1009a6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009ad:	0f b6 00             	movzbl (%rax),%eax
  1009b0:	0f be c0             	movsbl %al,%eax
  1009b3:	83 e8 43             	sub    $0x43,%eax
  1009b6:	83 f8 37             	cmp    $0x37,%eax
  1009b9:	0f 87 b6 03 00 00    	ja     100d75 <printer_vprintf+0x6d9>
  1009bf:	89 c0                	mov    %eax,%eax
  1009c1:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  1009c8:	00 
  1009c9:	48 8d 05 b4 0a 00 00 	lea    0xab4(%rip),%rax        # 101484 <flag_chars+0x14>
  1009d0:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  1009d3:	48 98                	cltq   
  1009d5:	48 8d 15 a8 0a 00 00 	lea    0xaa8(%rip),%rdx        # 101484 <flag_chars+0x14>
  1009dc:	48 01 d0             	add    %rdx,%rax
  1009df:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  1009e2:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1009e9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009f0:	01 
            goto again;
  1009f1:	eb b3                	jmp    1009a6 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1009f3:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1009f7:	74 5d                	je     100a56 <printer_vprintf+0x3ba>
  1009f9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a00:	8b 00                	mov    (%rax),%eax
  100a02:	83 f8 2f             	cmp    $0x2f,%eax
  100a05:	77 30                	ja     100a37 <printer_vprintf+0x39b>
  100a07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a0e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a19:	8b 00                	mov    (%rax),%eax
  100a1b:	89 c0                	mov    %eax,%eax
  100a1d:	48 01 d0             	add    %rdx,%rax
  100a20:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a27:	8b 12                	mov    (%rdx),%edx
  100a29:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a2c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a33:	89 0a                	mov    %ecx,(%rdx)
  100a35:	eb 1a                	jmp    100a51 <printer_vprintf+0x3b5>
  100a37:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a3e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a42:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a46:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a4d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a51:	48 8b 00             	mov    (%rax),%rax
  100a54:	eb 5c                	jmp    100ab2 <printer_vprintf+0x416>
  100a56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a5d:	8b 00                	mov    (%rax),%eax
  100a5f:	83 f8 2f             	cmp    $0x2f,%eax
  100a62:	77 30                	ja     100a94 <printer_vprintf+0x3f8>
  100a64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a6b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a6f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a76:	8b 00                	mov    (%rax),%eax
  100a78:	89 c0                	mov    %eax,%eax
  100a7a:	48 01 d0             	add    %rdx,%rax
  100a7d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a84:	8b 12                	mov    (%rdx),%edx
  100a86:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a89:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a90:	89 0a                	mov    %ecx,(%rdx)
  100a92:	eb 1a                	jmp    100aae <printer_vprintf+0x412>
  100a94:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a9b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a9f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100aa3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aaa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aae:	8b 00                	mov    (%rax),%eax
  100ab0:	48 98                	cltq   
  100ab2:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100ab6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100aba:	48 c1 f8 38          	sar    $0x38,%rax
  100abe:	25 80 00 00 00       	and    $0x80,%eax
  100ac3:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100ac6:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100aca:	74 09                	je     100ad5 <printer_vprintf+0x439>
  100acc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ad0:	48 f7 d8             	neg    %rax
  100ad3:	eb 04                	jmp    100ad9 <printer_vprintf+0x43d>
  100ad5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ad9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100add:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100ae0:	83 c8 60             	or     $0x60,%eax
  100ae3:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100ae6:	e9 cf 02 00 00       	jmp    100dba <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100aeb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100aef:	74 5d                	je     100b4e <printer_vprintf+0x4b2>
  100af1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af8:	8b 00                	mov    (%rax),%eax
  100afa:	83 f8 2f             	cmp    $0x2f,%eax
  100afd:	77 30                	ja     100b2f <printer_vprintf+0x493>
  100aff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b06:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b11:	8b 00                	mov    (%rax),%eax
  100b13:	89 c0                	mov    %eax,%eax
  100b15:	48 01 d0             	add    %rdx,%rax
  100b18:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b1f:	8b 12                	mov    (%rdx),%edx
  100b21:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b24:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b2b:	89 0a                	mov    %ecx,(%rdx)
  100b2d:	eb 1a                	jmp    100b49 <printer_vprintf+0x4ad>
  100b2f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b36:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b3a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b45:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b49:	48 8b 00             	mov    (%rax),%rax
  100b4c:	eb 5c                	jmp    100baa <printer_vprintf+0x50e>
  100b4e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b55:	8b 00                	mov    (%rax),%eax
  100b57:	83 f8 2f             	cmp    $0x2f,%eax
  100b5a:	77 30                	ja     100b8c <printer_vprintf+0x4f0>
  100b5c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b63:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b67:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b6e:	8b 00                	mov    (%rax),%eax
  100b70:	89 c0                	mov    %eax,%eax
  100b72:	48 01 d0             	add    %rdx,%rax
  100b75:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b7c:	8b 12                	mov    (%rdx),%edx
  100b7e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b88:	89 0a                	mov    %ecx,(%rdx)
  100b8a:	eb 1a                	jmp    100ba6 <printer_vprintf+0x50a>
  100b8c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b93:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b97:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ba2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ba6:	8b 00                	mov    (%rax),%eax
  100ba8:	89 c0                	mov    %eax,%eax
  100baa:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100bae:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100bb2:	e9 03 02 00 00       	jmp    100dba <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100bb7:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100bbe:	e9 28 ff ff ff       	jmp    100aeb <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100bc3:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100bca:	e9 1c ff ff ff       	jmp    100aeb <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100bcf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bd6:	8b 00                	mov    (%rax),%eax
  100bd8:	83 f8 2f             	cmp    $0x2f,%eax
  100bdb:	77 30                	ja     100c0d <printer_vprintf+0x571>
  100bdd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100be4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100be8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bef:	8b 00                	mov    (%rax),%eax
  100bf1:	89 c0                	mov    %eax,%eax
  100bf3:	48 01 d0             	add    %rdx,%rax
  100bf6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bfd:	8b 12                	mov    (%rdx),%edx
  100bff:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c02:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c09:	89 0a                	mov    %ecx,(%rdx)
  100c0b:	eb 1a                	jmp    100c27 <printer_vprintf+0x58b>
  100c0d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c14:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c18:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c1c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c23:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c27:	48 8b 00             	mov    (%rax),%rax
  100c2a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100c2e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100c35:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100c3c:	e9 79 01 00 00       	jmp    100dba <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100c41:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c48:	8b 00                	mov    (%rax),%eax
  100c4a:	83 f8 2f             	cmp    $0x2f,%eax
  100c4d:	77 30                	ja     100c7f <printer_vprintf+0x5e3>
  100c4f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c56:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c5a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c61:	8b 00                	mov    (%rax),%eax
  100c63:	89 c0                	mov    %eax,%eax
  100c65:	48 01 d0             	add    %rdx,%rax
  100c68:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c6f:	8b 12                	mov    (%rdx),%edx
  100c71:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c74:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c7b:	89 0a                	mov    %ecx,(%rdx)
  100c7d:	eb 1a                	jmp    100c99 <printer_vprintf+0x5fd>
  100c7f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c86:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c8a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c8e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c95:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c99:	48 8b 00             	mov    (%rax),%rax
  100c9c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100ca0:	e9 15 01 00 00       	jmp    100dba <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100ca5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cac:	8b 00                	mov    (%rax),%eax
  100cae:	83 f8 2f             	cmp    $0x2f,%eax
  100cb1:	77 30                	ja     100ce3 <printer_vprintf+0x647>
  100cb3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cba:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cbe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cc5:	8b 00                	mov    (%rax),%eax
  100cc7:	89 c0                	mov    %eax,%eax
  100cc9:	48 01 d0             	add    %rdx,%rax
  100ccc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cd3:	8b 12                	mov    (%rdx),%edx
  100cd5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cd8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cdf:	89 0a                	mov    %ecx,(%rdx)
  100ce1:	eb 1a                	jmp    100cfd <printer_vprintf+0x661>
  100ce3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cea:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cee:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cf2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cf9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cfd:	8b 00                	mov    (%rax),%eax
  100cff:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100d05:	e9 77 03 00 00       	jmp    101081 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100d0a:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d0e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100d12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d19:	8b 00                	mov    (%rax),%eax
  100d1b:	83 f8 2f             	cmp    $0x2f,%eax
  100d1e:	77 30                	ja     100d50 <printer_vprintf+0x6b4>
  100d20:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d27:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d2b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d32:	8b 00                	mov    (%rax),%eax
  100d34:	89 c0                	mov    %eax,%eax
  100d36:	48 01 d0             	add    %rdx,%rax
  100d39:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d40:	8b 12                	mov    (%rdx),%edx
  100d42:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d45:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d4c:	89 0a                	mov    %ecx,(%rdx)
  100d4e:	eb 1a                	jmp    100d6a <printer_vprintf+0x6ce>
  100d50:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d57:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d5b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d66:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d6a:	8b 00                	mov    (%rax),%eax
  100d6c:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d6f:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100d73:	eb 45                	jmp    100dba <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100d75:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d79:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100d7d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d84:	0f b6 00             	movzbl (%rax),%eax
  100d87:	84 c0                	test   %al,%al
  100d89:	74 0c                	je     100d97 <printer_vprintf+0x6fb>
  100d8b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d92:	0f b6 00             	movzbl (%rax),%eax
  100d95:	eb 05                	jmp    100d9c <printer_vprintf+0x700>
  100d97:	b8 25 00 00 00       	mov    $0x25,%eax
  100d9c:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d9f:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100da3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100daa:	0f b6 00             	movzbl (%rax),%eax
  100dad:	84 c0                	test   %al,%al
  100daf:	75 08                	jne    100db9 <printer_vprintf+0x71d>
                format--;
  100db1:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100db8:	01 
            }
            break;
  100db9:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100dba:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dbd:	83 e0 20             	and    $0x20,%eax
  100dc0:	85 c0                	test   %eax,%eax
  100dc2:	74 1e                	je     100de2 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100dc4:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100dc8:	48 83 c0 18          	add    $0x18,%rax
  100dcc:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100dcf:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100dd3:	48 89 ce             	mov    %rcx,%rsi
  100dd6:	48 89 c7             	mov    %rax,%rdi
  100dd9:	e8 32 f8 ff ff       	call   100610 <fill_numbuf>
  100dde:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100de2:	48 8d 05 8d 06 00 00 	lea    0x68d(%rip),%rax        # 101476 <flag_chars+0x6>
  100de9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100ded:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100df0:	83 e0 20             	and    $0x20,%eax
  100df3:	85 c0                	test   %eax,%eax
  100df5:	74 51                	je     100e48 <printer_vprintf+0x7ac>
  100df7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dfa:	83 e0 40             	and    $0x40,%eax
  100dfd:	85 c0                	test   %eax,%eax
  100dff:	74 47                	je     100e48 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100e01:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e04:	25 80 00 00 00       	and    $0x80,%eax
  100e09:	85 c0                	test   %eax,%eax
  100e0b:	74 0d                	je     100e1a <printer_vprintf+0x77e>
                prefix = "-";
  100e0d:	48 8d 05 63 06 00 00 	lea    0x663(%rip),%rax        # 101477 <flag_chars+0x7>
  100e14:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e18:	eb 7d                	jmp    100e97 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100e1a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e1d:	83 e0 10             	and    $0x10,%eax
  100e20:	85 c0                	test   %eax,%eax
  100e22:	74 0d                	je     100e31 <printer_vprintf+0x795>
                prefix = "+";
  100e24:	48 8d 05 4e 06 00 00 	lea    0x64e(%rip),%rax        # 101479 <flag_chars+0x9>
  100e2b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e2f:	eb 66                	jmp    100e97 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100e31:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e34:	83 e0 08             	and    $0x8,%eax
  100e37:	85 c0                	test   %eax,%eax
  100e39:	74 5c                	je     100e97 <printer_vprintf+0x7fb>
                prefix = " ";
  100e3b:	48 8d 05 39 06 00 00 	lea    0x639(%rip),%rax        # 10147b <flag_chars+0xb>
  100e42:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e46:	eb 4f                	jmp    100e97 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100e48:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e4b:	83 e0 20             	and    $0x20,%eax
  100e4e:	85 c0                	test   %eax,%eax
  100e50:	74 46                	je     100e98 <printer_vprintf+0x7fc>
  100e52:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e55:	83 e0 01             	and    $0x1,%eax
  100e58:	85 c0                	test   %eax,%eax
  100e5a:	74 3c                	je     100e98 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100e5c:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100e60:	74 06                	je     100e68 <printer_vprintf+0x7cc>
  100e62:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e66:	75 30                	jne    100e98 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100e68:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100e6d:	75 0c                	jne    100e7b <printer_vprintf+0x7df>
  100e6f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e72:	25 00 01 00 00       	and    $0x100,%eax
  100e77:	85 c0                	test   %eax,%eax
  100e79:	74 1d                	je     100e98 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100e7b:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e7f:	75 09                	jne    100e8a <printer_vprintf+0x7ee>
  100e81:	48 8d 05 f5 05 00 00 	lea    0x5f5(%rip),%rax        # 10147d <flag_chars+0xd>
  100e88:	eb 07                	jmp    100e91 <printer_vprintf+0x7f5>
  100e8a:	48 8d 05 ef 05 00 00 	lea    0x5ef(%rip),%rax        # 101480 <flag_chars+0x10>
  100e91:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100e95:	eb 01                	jmp    100e98 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100e97:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100e98:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e9c:	78 24                	js     100ec2 <printer_vprintf+0x826>
  100e9e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ea1:	83 e0 20             	and    $0x20,%eax
  100ea4:	85 c0                	test   %eax,%eax
  100ea6:	75 1a                	jne    100ec2 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100ea8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100eab:	48 63 d0             	movslq %eax,%rdx
  100eae:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100eb2:	48 89 d6             	mov    %rdx,%rsi
  100eb5:	48 89 c7             	mov    %rax,%rdi
  100eb8:	e8 91 f5 ff ff       	call   10044e <strnlen>
  100ebd:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100ec0:	eb 0f                	jmp    100ed1 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100ec2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ec6:	48 89 c7             	mov    %rax,%rdi
  100ec9:	e8 4b f5 ff ff       	call   100419 <strlen>
  100ece:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100ed1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ed4:	83 e0 20             	and    $0x20,%eax
  100ed7:	85 c0                	test   %eax,%eax
  100ed9:	74 20                	je     100efb <printer_vprintf+0x85f>
  100edb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100edf:	78 1a                	js     100efb <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100ee1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100ee4:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100ee7:	7e 08                	jle    100ef1 <printer_vprintf+0x855>
  100ee9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100eec:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100eef:	eb 05                	jmp    100ef6 <printer_vprintf+0x85a>
  100ef1:	b8 00 00 00 00       	mov    $0x0,%eax
  100ef6:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100ef9:	eb 5c                	jmp    100f57 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100efb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100efe:	83 e0 20             	and    $0x20,%eax
  100f01:	85 c0                	test   %eax,%eax
  100f03:	74 4b                	je     100f50 <printer_vprintf+0x8b4>
  100f05:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f08:	83 e0 02             	and    $0x2,%eax
  100f0b:	85 c0                	test   %eax,%eax
  100f0d:	74 41                	je     100f50 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100f0f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f12:	83 e0 04             	and    $0x4,%eax
  100f15:	85 c0                	test   %eax,%eax
  100f17:	75 37                	jne    100f50 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100f19:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f1d:	48 89 c7             	mov    %rax,%rdi
  100f20:	e8 f4 f4 ff ff       	call   100419 <strlen>
  100f25:	89 c2                	mov    %eax,%edx
  100f27:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100f2a:	01 d0                	add    %edx,%eax
  100f2c:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100f2f:	7e 1f                	jle    100f50 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100f31:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f34:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100f37:	89 c3                	mov    %eax,%ebx
  100f39:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f3d:	48 89 c7             	mov    %rax,%rdi
  100f40:	e8 d4 f4 ff ff       	call   100419 <strlen>
  100f45:	89 c2                	mov    %eax,%edx
  100f47:	89 d8                	mov    %ebx,%eax
  100f49:	29 d0                	sub    %edx,%eax
  100f4b:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f4e:	eb 07                	jmp    100f57 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100f50:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100f57:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100f5a:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100f5d:	01 d0                	add    %edx,%eax
  100f5f:	48 63 d8             	movslq %eax,%rbx
  100f62:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f66:	48 89 c7             	mov    %rax,%rdi
  100f69:	e8 ab f4 ff ff       	call   100419 <strlen>
  100f6e:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100f72:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f75:	29 d0                	sub    %edx,%eax
  100f77:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f7a:	eb 25                	jmp    100fa1 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  100f7c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f83:	48 8b 08             	mov    (%rax),%rcx
  100f86:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f8c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f93:	be 20 00 00 00       	mov    $0x20,%esi
  100f98:	48 89 c7             	mov    %rax,%rdi
  100f9b:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f9d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100fa1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fa4:	83 e0 04             	and    $0x4,%eax
  100fa7:	85 c0                	test   %eax,%eax
  100fa9:	75 36                	jne    100fe1 <printer_vprintf+0x945>
  100fab:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100faf:	7f cb                	jg     100f7c <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  100fb1:	eb 2e                	jmp    100fe1 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  100fb3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fba:	4c 8b 00             	mov    (%rax),%r8
  100fbd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fc1:	0f b6 00             	movzbl (%rax),%eax
  100fc4:	0f b6 c8             	movzbl %al,%ecx
  100fc7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fcd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fd4:	89 ce                	mov    %ecx,%esi
  100fd6:	48 89 c7             	mov    %rax,%rdi
  100fd9:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100fdc:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100fe1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fe5:	0f b6 00             	movzbl (%rax),%eax
  100fe8:	84 c0                	test   %al,%al
  100fea:	75 c7                	jne    100fb3 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  100fec:	eb 25                	jmp    101013 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  100fee:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ff5:	48 8b 08             	mov    (%rax),%rcx
  100ff8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ffe:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101005:	be 30 00 00 00       	mov    $0x30,%esi
  10100a:	48 89 c7             	mov    %rax,%rdi
  10100d:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  10100f:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101013:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101017:	7f d5                	jg     100fee <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  101019:	eb 32                	jmp    10104d <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  10101b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101022:	4c 8b 00             	mov    (%rax),%r8
  101025:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101029:	0f b6 00             	movzbl (%rax),%eax
  10102c:	0f b6 c8             	movzbl %al,%ecx
  10102f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101035:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10103c:	89 ce                	mov    %ecx,%esi
  10103e:	48 89 c7             	mov    %rax,%rdi
  101041:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101044:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101049:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10104d:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101051:	7f c8                	jg     10101b <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  101053:	eb 25                	jmp    10107a <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  101055:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10105c:	48 8b 08             	mov    (%rax),%rcx
  10105f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101065:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10106c:	be 20 00 00 00       	mov    $0x20,%esi
  101071:	48 89 c7             	mov    %rax,%rdi
  101074:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101076:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10107a:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10107e:	7f d5                	jg     101055 <printer_vprintf+0x9b9>
        }
    done: ;
  101080:	90                   	nop
    for (; *format; ++format) {
  101081:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101088:	01 
  101089:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101090:	0f b6 00             	movzbl (%rax),%eax
  101093:	84 c0                	test   %al,%al
  101095:	0f 85 31 f6 ff ff    	jne    1006cc <printer_vprintf+0x30>
    }
}
  10109b:	90                   	nop
  10109c:	90                   	nop
  10109d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1010a1:	c9                   	leave  
  1010a2:	c3                   	ret    

00000000001010a3 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1010a3:	f3 0f 1e fa          	endbr64 
  1010a7:	55                   	push   %rbp
  1010a8:	48 89 e5             	mov    %rsp,%rbp
  1010ab:	48 83 ec 20          	sub    $0x20,%rsp
  1010af:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1010b3:	89 f0                	mov    %esi,%eax
  1010b5:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1010b8:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1010bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1010bf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1010c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010c7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010cb:	48 8d 15 ce 7e fb ff 	lea    -0x48132(%rip),%rdx        # b8fa0 <console+0xfa0>
  1010d2:	48 39 d0             	cmp    %rdx,%rax
  1010d5:	72 0f                	jb     1010e6 <console_putc+0x43>
        cp->cursor = console;
  1010d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010db:	48 8d 15 1e 6f fb ff 	lea    -0x490e2(%rip),%rdx        # b8000 <console>
  1010e2:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  1010e6:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1010ea:	0f 85 82 00 00 00    	jne    101172 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  1010f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010f4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010f8:	48 8d 15 01 6f fb ff 	lea    -0x490ff(%rip),%rdx        # b8000 <console>
  1010ff:	48 29 d0             	sub    %rdx,%rax
  101102:	48 d1 f8             	sar    %rax
  101105:	48 89 c1             	mov    %rax,%rcx
  101108:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10110f:	66 66 66 
  101112:	48 89 c8             	mov    %rcx,%rax
  101115:	48 f7 ea             	imul   %rdx
  101118:	48 89 d0             	mov    %rdx,%rax
  10111b:	48 c1 f8 05          	sar    $0x5,%rax
  10111f:	48 89 ce             	mov    %rcx,%rsi
  101122:	48 c1 fe 3f          	sar    $0x3f,%rsi
  101126:	48 29 f0             	sub    %rsi,%rax
  101129:	48 89 c2             	mov    %rax,%rdx
  10112c:	48 89 d0             	mov    %rdx,%rax
  10112f:	48 c1 e0 02          	shl    $0x2,%rax
  101133:	48 01 d0             	add    %rdx,%rax
  101136:	48 c1 e0 04          	shl    $0x4,%rax
  10113a:	48 29 c1             	sub    %rax,%rcx
  10113d:	48 89 ca             	mov    %rcx,%rdx
  101140:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101143:	eb 25                	jmp    10116a <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  101145:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101148:	83 c8 20             	or     $0x20,%eax
  10114b:	89 c6                	mov    %eax,%esi
  10114d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101151:	48 8b 40 08          	mov    0x8(%rax),%rax
  101155:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101159:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10115d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101161:	89 f2                	mov    %esi,%edx
  101163:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101166:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10116a:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  10116e:	75 d5                	jne    101145 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101170:	eb 24                	jmp    101196 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  101172:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101176:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101179:	89 d6                	mov    %edx,%esi
  10117b:	09 c6                	or     %eax,%esi
  10117d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101181:	48 8b 40 08          	mov    0x8(%rax),%rax
  101185:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101189:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10118d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101191:	89 f2                	mov    %esi,%edx
  101193:	66 89 10             	mov    %dx,(%rax)
}
  101196:	90                   	nop
  101197:	c9                   	leave  
  101198:	c3                   	ret    

0000000000101199 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101199:	f3 0f 1e fa          	endbr64 
  10119d:	55                   	push   %rbp
  10119e:	48 89 e5             	mov    %rsp,%rbp
  1011a1:	48 83 ec 30          	sub    $0x30,%rsp
  1011a5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1011a8:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1011ab:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1011af:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1011b3:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 1010a3 <console_putc>
  1011ba:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1011be:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1011c2:	78 09                	js     1011cd <console_vprintf+0x34>
  1011c4:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1011cb:	7e 07                	jle    1011d4 <console_vprintf+0x3b>
        cpos = 0;
  1011cd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1011d4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011d7:	48 98                	cltq   
  1011d9:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1011dd:	48 8d 05 1c 6e fb ff 	lea    -0x491e4(%rip),%rax        # b8000 <console>
  1011e4:	48 01 d0             	add    %rdx,%rax
  1011e7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1011eb:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1011ef:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1011f3:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1011f6:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1011fa:	48 89 c7             	mov    %rax,%rdi
  1011fd:	e8 9a f4 ff ff       	call   10069c <printer_vprintf>
    return cp.cursor - console;
  101202:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101206:	48 8d 15 f3 6d fb ff 	lea    -0x4920d(%rip),%rdx        # b8000 <console>
  10120d:	48 29 d0             	sub    %rdx,%rax
  101210:	48 d1 f8             	sar    %rax
}
  101213:	c9                   	leave  
  101214:	c3                   	ret    

0000000000101215 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101215:	f3 0f 1e fa          	endbr64 
  101219:	55                   	push   %rbp
  10121a:	48 89 e5             	mov    %rsp,%rbp
  10121d:	48 83 ec 60          	sub    $0x60,%rsp
  101221:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101224:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101227:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  10122b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10122f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101233:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101237:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  10123e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101242:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101246:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10124a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10124e:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101252:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101256:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101259:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10125c:	89 c7                	mov    %eax,%edi
  10125e:	e8 36 ff ff ff       	call   101199 <console_vprintf>
  101263:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101266:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101269:	c9                   	leave  
  10126a:	c3                   	ret    

000000000010126b <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10126b:	f3 0f 1e fa          	endbr64 
  10126f:	55                   	push   %rbp
  101270:	48 89 e5             	mov    %rsp,%rbp
  101273:	48 83 ec 20          	sub    $0x20,%rsp
  101277:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10127b:	89 f0                	mov    %esi,%eax
  10127d:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101280:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101283:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101287:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  10128b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10128f:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101293:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101297:	48 8b 40 10          	mov    0x10(%rax),%rax
  10129b:	48 39 c2             	cmp    %rax,%rdx
  10129e:	73 1a                	jae    1012ba <string_putc+0x4f>
        *sp->s++ = c;
  1012a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012a4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012a8:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1012ac:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1012b0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012b4:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1012b8:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1012ba:	90                   	nop
  1012bb:	c9                   	leave  
  1012bc:	c3                   	ret    

00000000001012bd <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1012bd:	f3 0f 1e fa          	endbr64 
  1012c1:	55                   	push   %rbp
  1012c2:	48 89 e5             	mov    %rsp,%rbp
  1012c5:	48 83 ec 40          	sub    $0x40,%rsp
  1012c9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1012cd:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1012d1:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1012d5:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1012d9:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 10126b <string_putc>
  1012e0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  1012e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1012e8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1012ec:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1012f1:	74 33                	je     101326 <vsnprintf+0x69>
        sp.end = s + size - 1;
  1012f3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1012f7:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1012fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1012ff:	48 01 d0             	add    %rdx,%rax
  101302:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101306:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  10130a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  10130e:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101312:	be 00 00 00 00       	mov    $0x0,%esi
  101317:	48 89 c7             	mov    %rax,%rdi
  10131a:	e8 7d f3 ff ff       	call   10069c <printer_vprintf>
        *sp.s = 0;
  10131f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101323:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101326:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10132a:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  10132e:	c9                   	leave  
  10132f:	c3                   	ret    

0000000000101330 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101330:	f3 0f 1e fa          	endbr64 
  101334:	55                   	push   %rbp
  101335:	48 89 e5             	mov    %rsp,%rbp
  101338:	48 83 ec 70          	sub    $0x70,%rsp
  10133c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101340:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101344:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101348:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10134c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101350:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101354:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10135b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10135f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101363:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101367:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10136b:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  10136f:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101373:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101377:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10137b:	48 89 c7             	mov    %rax,%rdi
  10137e:	e8 3a ff ff ff       	call   1012bd <vsnprintf>
  101383:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101386:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101389:	c9                   	leave  
  10138a:	c3                   	ret    

000000000010138b <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10138b:	f3 0f 1e fa          	endbr64 
  10138f:	55                   	push   %rbp
  101390:	48 89 e5             	mov    %rsp,%rbp
  101393:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101397:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10139e:	eb 1a                	jmp    1013ba <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  1013a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1013a3:	48 98                	cltq   
  1013a5:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1013a9:	48 8d 05 50 6c fb ff 	lea    -0x493b0(%rip),%rax        # b8000 <console>
  1013b0:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1013b6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1013ba:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1013c1:	7e dd                	jle    1013a0 <console_clear+0x15>
    }
    cursorpos = 0;
  1013c3:	c7 05 2f 7c fb ff 00 	movl   $0x0,-0x483d1(%rip)        # b8ffc <cursorpos>
  1013ca:	00 00 00 
}
  1013cd:	90                   	nop
  1013ce:	c9                   	leave  
  1013cf:	c3                   	ret    
