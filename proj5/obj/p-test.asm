
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
"Leia Organa of Aldernaan, Senator"
"--  George Lucas, Prologue to Star Wars";

// similar to p-fork but with large global memory 

void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	41 56                	push   %r14
  10000a:	41 55                	push   %r13
  10000c:	41 54                	push   %r12
  10000e:	53                   	push   %rbx
// sys_fork()
//    Fork the current process. On success, return the child's process ID to
//    the parent, and return 0 to the child. On failure, return -1.
static inline pid_t sys_fork(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000f:	cd 34                	int    $0x34
    // Fork a total of three new copies.
    pid_t p1 = sys_fork();
    assert(p1 >= 0);
  100011:	85 c0                	test   %eax,%eax
  100013:	78 5a                	js     10006f <process_main+0x6f>
  100015:	41 89 c4             	mov    %eax,%r12d
  100018:	cd 34                	int    $0x34
  10001a:	41 89 c6             	mov    %eax,%r14d
    pid_t p2 = sys_fork();
    assert(p2 >= 0);
  10001d:	85 c0                	test   %eax,%eax
  10001f:	78 66                	js     100087 <process_main+0x87>
    asm volatile ("int %1" : "=a" (result)
  100021:	cd 31                	int    $0x31

    // Check fork return values: fork should return 0 to child.
    if (sys_getpid() == 1) {
  100023:	83 f8 01             	cmp    $0x1,%eax
  100026:	74 77                	je     10009f <process_main+0x9f>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
    } else {
        assert(p1 == 0 || p2 == 0);
  100028:	45 85 e4             	test   %r12d,%r12d
  10002b:	74 09                	je     100036 <process_main+0x36>
  10002d:	45 85 f6             	test   %r14d,%r14d
  100030:	0f 85 96 00 00 00    	jne    1000cc <process_main+0xcc>
  100036:	cd 31                	int    $0x31
  100038:	89 c3                	mov    %eax,%ebx
    }

    // The rest of this code is like p-allocator.c.

    pid_t p = sys_getpid();
    srand(p);
  10003a:	89 c7                	mov    %eax,%edi
  10003c:	e8 eb 05 00 00       	call   10062c <srand>

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100041:	48 8d 05 ef 3f 00 00 	lea    0x3fef(%rip),%rax        # 104037 <end+0xfff>
  100048:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10004e:	48 89 05 d3 2f 00 00 	mov    %rax,0x2fd3(%rip)        # 103028 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100055:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100058:	48 83 e8 01          	sub    $0x1,%rax
  10005c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100062:	48 89 05 b7 2f 00 00 	mov    %rax,0x2fb7(%rip)        # 103020 <stack_bottom>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
                break;
            }
            *heap_top = p;      /* check we have write access to new page */
            heap_top += PAGESIZE;
            padding_page[0] = p1 + preamble[(uint8_t)p1];
  100069:	45 0f b6 ec          	movzbl %r12b,%r13d
  10006d:	eb 77                	jmp    1000e6 <process_main+0xe6>
    assert(p1 >= 0);
  10006f:	48 8d 15 aa 13 00 00 	lea    0x13aa(%rip),%rdx        # 101420 <console_clear+0x54>
  100076:	be 3a 00 00 00       	mov    $0x3a,%esi
  10007b:	48 8d 3d a6 13 00 00 	lea    0x13a6(%rip),%rdi        # 101428 <console_clear+0x5c>
  100082:	e8 55 02 00 00       	call   1002dc <assert_fail>
    assert(p2 >= 0);
  100087:	48 8d 15 aa 13 00 00 	lea    0x13aa(%rip),%rdx        # 101438 <console_clear+0x6c>
  10008e:	be 3c 00 00 00       	mov    $0x3c,%esi
  100093:	48 8d 3d 8e 13 00 00 	lea    0x138e(%rip),%rdi        # 101428 <console_clear+0x5c>
  10009a:	e8 3d 02 00 00       	call   1002dc <assert_fail>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
  10009f:	45 85 f6             	test   %r14d,%r14d
  1000a2:	0f 94 c0             	sete   %al
  1000a5:	45 39 f4             	cmp    %r14d,%r12d
  1000a8:	0f 94 c2             	sete   %dl
  1000ab:	08 d0                	or     %dl,%al
  1000ad:	75 05                	jne    1000b4 <process_main+0xb4>
  1000af:	45 85 e4             	test   %r12d,%r12d
  1000b2:	75 82                	jne    100036 <process_main+0x36>
  1000b4:	48 8d 15 b5 13 00 00 	lea    0x13b5(%rip),%rdx        # 101470 <console_clear+0xa4>
  1000bb:	be 40 00 00 00       	mov    $0x40,%esi
  1000c0:	48 8d 3d 61 13 00 00 	lea    0x1361(%rip),%rdi        # 101428 <console_clear+0x5c>
  1000c7:	e8 10 02 00 00       	call   1002dc <assert_fail>
        assert(p1 == 0 || p2 == 0);
  1000cc:	48 8d 15 6d 13 00 00 	lea    0x136d(%rip),%rdx        # 101440 <console_clear+0x74>
  1000d3:	be 42 00 00 00       	mov    $0x42,%esi
  1000d8:	48 8d 3d 49 13 00 00 	lea    0x1349(%rip),%rdi        # 101428 <console_clear+0x5c>
  1000df:	e8 f8 01 00 00       	call   1002dc <assert_fail>
    asm volatile ("int %0" : /* no result */
  1000e4:	cd 32                	int    $0x32
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  1000e6:	e8 01 05 00 00       	call   1005ec <rand>
  1000eb:	48 63 d0             	movslq %eax,%rdx
  1000ee:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1000f5:	48 c1 fa 25          	sar    $0x25,%rdx
  1000f9:	89 c1                	mov    %eax,%ecx
  1000fb:	c1 f9 1f             	sar    $0x1f,%ecx
  1000fe:	29 ca                	sub    %ecx,%edx
  100100:	6b d2 64             	imul   $0x64,%edx,%edx
  100103:	29 d0                	sub    %edx,%eax
  100105:	39 d8                	cmp    %ebx,%eax
  100107:	7d db                	jge    1000e4 <process_main+0xe4>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  100109:	48 8b 3d 18 2f 00 00 	mov    0x2f18(%rip),%rdi        # 103028 <heap_top>
  100110:	48 3b 3d 09 2f 00 00 	cmp    0x2f09(%rip),%rdi        # 103020 <stack_bottom>
  100117:	74 31                	je     10014a <process_main+0x14a>
    asm volatile ("int %1" : "=a" (result)
  100119:	cd 33                	int    $0x33
  10011b:	85 c0                	test   %eax,%eax
  10011d:	78 2b                	js     10014a <process_main+0x14a>
            *heap_top = p;      /* check we have write access to new page */
  10011f:	48 8b 05 02 2f 00 00 	mov    0x2f02(%rip),%rax        # 103028 <heap_top>
  100126:	88 18                	mov    %bl,(%rax)
            heap_top += PAGESIZE;
  100128:	48 81 05 f5 2e 00 00 	addq   $0x1000,0x2ef5(%rip)        # 103028 <heap_top>
  10012f:	00 10 00 00 
            padding_page[0] = p1 + preamble[(uint8_t)p1];
  100133:	48 8b 05 c6 1e 00 00 	mov    0x1ec6(%rip),%rax        # 102000 <preamble>
  10013a:	44 89 e6             	mov    %r12d,%esi
  10013d:	42 02 34 28          	add    (%rax,%r13,1),%sil
  100141:	40 88 35 d8 1e 00 00 	mov    %sil,0x1ed8(%rip)        # 102020 <padding_page>
  100148:	eb 9a                	jmp    1000e4 <process_main+0xe4>
    asm volatile ("int %0" : /* no result */
  10014a:	cd 32                	int    $0x32
  10014c:	cd 32                	int    $0x32
        sys_yield();
    }

    sys_yield();
    sys_yield();
    if(p1 != 0 && p2 != 0) // parent
  10014e:	45 85 e4             	test   %r12d,%r12d
  100151:	74 05                	je     100158 <process_main+0x158>
  100153:	45 85 f6             	test   %r14d,%r14d
  100156:	75 04                	jne    10015c <process_main+0x15c>
  100158:	cd 32                	int    $0x32
  10015a:	eb fc                	jmp    100158 <process_main+0x158>
        TEST_PASS();
  10015c:	48 8d 3d f0 12 00 00 	lea    0x12f0(%rip),%rdi        # 101453 <console_clear+0x87>
  100163:	b8 00 00 00 00       	mov    $0x0,%eax
  100168:	e8 98 00 00 00       	call   100205 <panic>

000000000010016d <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  10016d:	f3 0f 1e fa          	endbr64 
  100171:	55                   	push   %rbp
  100172:	48 89 e5             	mov    %rsp,%rbp
  100175:	48 83 ec 50          	sub    $0x50,%rsp
  100179:	49 89 f2             	mov    %rsi,%r10
  10017c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100180:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100184:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100188:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  10018c:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100191:	85 ff                	test   %edi,%edi
  100193:	78 32                	js     1001c7 <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100195:	48 63 ff             	movslq %edi,%rdi
  100198:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  10019f:	cc cc cc 
  1001a2:	48 89 f8             	mov    %rdi,%rax
  1001a5:	48 f7 e2             	mul    %rdx
  1001a8:	48 89 d0             	mov    %rdx,%rax
  1001ab:	48 c1 e8 02          	shr    $0x2,%rax
  1001af:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1001b3:	48 01 c2             	add    %rax,%rdx
  1001b6:	48 29 d7             	sub    %rdx,%rdi
  1001b9:	48 8d 05 7d 1b 00 00 	lea    0x1b7d(%rip),%rax        # 101d3d <col.0>
  1001c0:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  1001c4:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1001c7:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1001ce:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001d2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1001d6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1001da:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1001de:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1001e2:	4c 89 d2             	mov    %r10,%rdx
  1001e5:	8b 3d 11 8e fb ff    	mov    -0x471ef(%rip),%edi        # b8ffc <cursorpos>
  1001eb:	e8 ea 0f 00 00       	call   1011da <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1001f0:	3d 30 07 00 00       	cmp    $0x730,%eax
  1001f5:	ba 00 00 00 00       	mov    $0x0,%edx
  1001fa:	0f 4d c2             	cmovge %edx,%eax
  1001fd:	89 05 f9 8d fb ff    	mov    %eax,-0x47207(%rip)        # b8ffc <cursorpos>
    }
}
  100203:	c9                   	leave  
  100204:	c3                   	ret    

0000000000100205 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  100205:	f3 0f 1e fa          	endbr64 
  100209:	55                   	push   %rbp
  10020a:	48 89 e5             	mov    %rsp,%rbp
  10020d:	53                   	push   %rbx
  10020e:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100215:	48 89 fb             	mov    %rdi,%rbx
  100218:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10021c:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100220:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100224:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100228:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  10022c:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100233:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100237:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  10023b:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  10023f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100243:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  10024a:	ba 07 00 00 00       	mov    $0x7,%edx
  10024f:	48 8d 35 b3 1a 00 00 	lea    0x1ab3(%rip),%rsi        # 101d09 <console_clear+0x93d>
  100256:	e8 b6 00 00 00       	call   100311 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  10025b:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  10025f:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100266:	48 89 da             	mov    %rbx,%rdx
  100269:	be 99 00 00 00       	mov    $0x99,%esi
  10026e:	e8 8b 10 00 00       	call   1012fe <vsnprintf>
  100273:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100276:	85 d2                	test   %edx,%edx
  100278:	7e 0f                	jle    100289 <panic+0x84>
  10027a:	83 c0 06             	add    $0x6,%eax
  10027d:	48 98                	cltq   
  10027f:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100286:	0a 
  100287:	75 2b                	jne    1002b4 <panic+0xaf>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100289:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  100290:	48 8d 15 7c 1a 00 00 	lea    0x1a7c(%rip),%rdx        # 101d13 <console_clear+0x947>
  100297:	be 00 c0 00 00       	mov    $0xc000,%esi
  10029c:	bf 30 07 00 00       	mov    $0x730,%edi
  1002a1:	b8 00 00 00 00       	mov    $0x0,%eax
  1002a6:	e8 ab 0f 00 00       	call   101256 <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  1002ab:	bf 00 00 00 00       	mov    $0x0,%edi
  1002b0:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  1002b2:	eb fe                	jmp    1002b2 <panic+0xad>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1002b4:	48 63 c2             	movslq %edx,%rax
  1002b7:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1002bd:	0f 94 c2             	sete   %dl
  1002c0:	0f b6 d2             	movzbl %dl,%edx
  1002c3:	48 29 d0             	sub    %rdx,%rax
  1002c6:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1002cd:	ff 
  1002ce:	48 8d 35 3c 1a 00 00 	lea    0x1a3c(%rip),%rsi        # 101d11 <console_clear+0x945>
  1002d5:	e8 f8 01 00 00       	call   1004d2 <strcpy>
  1002da:	eb ad                	jmp    100289 <panic+0x84>

00000000001002dc <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1002dc:	f3 0f 1e fa          	endbr64 
  1002e0:	55                   	push   %rbp
  1002e1:	48 89 e5             	mov    %rsp,%rbp
  1002e4:	48 89 f9             	mov    %rdi,%rcx
  1002e7:	41 89 f0             	mov    %esi,%r8d
  1002ea:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1002ed:	48 8d 15 24 1a 00 00 	lea    0x1a24(%rip),%rdx        # 101d18 <console_clear+0x94c>
  1002f4:	be 00 c0 00 00       	mov    $0xc000,%esi
  1002f9:	bf 30 07 00 00       	mov    $0x730,%edi
  1002fe:	b8 00 00 00 00       	mov    $0x0,%eax
  100303:	e8 4e 0f 00 00       	call   101256 <console_printf>
    asm volatile ("int %0" : /* no result */
  100308:	bf 00 00 00 00       	mov    $0x0,%edi
  10030d:	cd 30                	int    $0x30
 loop: goto loop;
  10030f:	eb fe                	jmp    10030f <assert_fail+0x33>

0000000000100311 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100311:	f3 0f 1e fa          	endbr64 
  100315:	55                   	push   %rbp
  100316:	48 89 e5             	mov    %rsp,%rbp
  100319:	48 83 ec 28          	sub    $0x28,%rsp
  10031d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100321:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100325:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100329:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10032d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100331:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100335:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100339:	eb 1c                	jmp    100357 <memcpy+0x46>
        *d = *s;
  10033b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10033f:	0f b6 10             	movzbl (%rax),%edx
  100342:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100346:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100348:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10034d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100352:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100357:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10035c:	75 dd                	jne    10033b <memcpy+0x2a>
    }
    return dst;
  10035e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100362:	c9                   	leave  
  100363:	c3                   	ret    

0000000000100364 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100364:	f3 0f 1e fa          	endbr64 
  100368:	55                   	push   %rbp
  100369:	48 89 e5             	mov    %rsp,%rbp
  10036c:	48 83 ec 28          	sub    $0x28,%rsp
  100370:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100374:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100378:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10037c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100380:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100384:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100388:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  10038c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100390:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100394:	73 6a                	jae    100400 <memmove+0x9c>
  100396:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10039a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10039e:	48 01 d0             	add    %rdx,%rax
  1003a1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1003a5:	73 59                	jae    100400 <memmove+0x9c>
        s += n, d += n;
  1003a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003ab:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1003af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003b3:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1003b7:	eb 17                	jmp    1003d0 <memmove+0x6c>
            *--d = *--s;
  1003b9:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1003be:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1003c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003c7:	0f b6 10             	movzbl (%rax),%edx
  1003ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003ce:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003d0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003d4:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003d8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003dc:	48 85 c0             	test   %rax,%rax
  1003df:	75 d8                	jne    1003b9 <memmove+0x55>
    if (s < d && s + n > d) {
  1003e1:	eb 2e                	jmp    100411 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1003e3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1003e7:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003f3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003f7:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1003fb:	0f b6 12             	movzbl (%rdx),%edx
  1003fe:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100400:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100404:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100408:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10040c:	48 85 c0             	test   %rax,%rax
  10040f:	75 d2                	jne    1003e3 <memmove+0x7f>
        }
    }
    return dst;
  100411:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100415:	c9                   	leave  
  100416:	c3                   	ret    

0000000000100417 <memset>:

void* memset(void* v, int c, size_t n) {
  100417:	f3 0f 1e fa          	endbr64 
  10041b:	55                   	push   %rbp
  10041c:	48 89 e5             	mov    %rsp,%rbp
  10041f:	48 83 ec 28          	sub    $0x28,%rsp
  100423:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100427:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  10042a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10042e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100432:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100436:	eb 15                	jmp    10044d <memset+0x36>
        *p = c;
  100438:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10043b:	89 c2                	mov    %eax,%edx
  10043d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100441:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100443:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100448:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10044d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100452:	75 e4                	jne    100438 <memset+0x21>
    }
    return v;
  100454:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100458:	c9                   	leave  
  100459:	c3                   	ret    

000000000010045a <strlen>:

size_t strlen(const char* s) {
  10045a:	f3 0f 1e fa          	endbr64 
  10045e:	55                   	push   %rbp
  10045f:	48 89 e5             	mov    %rsp,%rbp
  100462:	48 83 ec 18          	sub    $0x18,%rsp
  100466:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10046a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100471:	00 
  100472:	eb 0a                	jmp    10047e <strlen+0x24>
        ++n;
  100474:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100479:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10047e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100482:	0f b6 00             	movzbl (%rax),%eax
  100485:	84 c0                	test   %al,%al
  100487:	75 eb                	jne    100474 <strlen+0x1a>
    }
    return n;
  100489:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10048d:	c9                   	leave  
  10048e:	c3                   	ret    

000000000010048f <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  10048f:	f3 0f 1e fa          	endbr64 
  100493:	55                   	push   %rbp
  100494:	48 89 e5             	mov    %rsp,%rbp
  100497:	48 83 ec 20          	sub    $0x20,%rsp
  10049b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10049f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1004a3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1004aa:	00 
  1004ab:	eb 0a                	jmp    1004b7 <strnlen+0x28>
        ++n;
  1004ad:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1004b2:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1004b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004bb:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1004bf:	74 0b                	je     1004cc <strnlen+0x3d>
  1004c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004c5:	0f b6 00             	movzbl (%rax),%eax
  1004c8:	84 c0                	test   %al,%al
  1004ca:	75 e1                	jne    1004ad <strnlen+0x1e>
    }
    return n;
  1004cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1004d0:	c9                   	leave  
  1004d1:	c3                   	ret    

00000000001004d2 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1004d2:	f3 0f 1e fa          	endbr64 
  1004d6:	55                   	push   %rbp
  1004d7:	48 89 e5             	mov    %rsp,%rbp
  1004da:	48 83 ec 20          	sub    $0x20,%rsp
  1004de:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004e2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1004e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004ea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1004ee:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1004f2:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004f6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1004fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004fe:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100502:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100506:	0f b6 12             	movzbl (%rdx),%edx
  100509:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  10050b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10050f:	48 83 e8 01          	sub    $0x1,%rax
  100513:	0f b6 00             	movzbl (%rax),%eax
  100516:	84 c0                	test   %al,%al
  100518:	75 d4                	jne    1004ee <strcpy+0x1c>
    return dst;
  10051a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10051e:	c9                   	leave  
  10051f:	c3                   	ret    

0000000000100520 <strcmp>:

int strcmp(const char* a, const char* b) {
  100520:	f3 0f 1e fa          	endbr64 
  100524:	55                   	push   %rbp
  100525:	48 89 e5             	mov    %rsp,%rbp
  100528:	48 83 ec 10          	sub    $0x10,%rsp
  10052c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100530:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100534:	eb 0a                	jmp    100540 <strcmp+0x20>
        ++a, ++b;
  100536:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10053b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100540:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100544:	0f b6 00             	movzbl (%rax),%eax
  100547:	84 c0                	test   %al,%al
  100549:	74 1d                	je     100568 <strcmp+0x48>
  10054b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10054f:	0f b6 00             	movzbl (%rax),%eax
  100552:	84 c0                	test   %al,%al
  100554:	74 12                	je     100568 <strcmp+0x48>
  100556:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10055a:	0f b6 10             	movzbl (%rax),%edx
  10055d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100561:	0f b6 00             	movzbl (%rax),%eax
  100564:	38 c2                	cmp    %al,%dl
  100566:	74 ce                	je     100536 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100568:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10056c:	0f b6 00             	movzbl (%rax),%eax
  10056f:	89 c2                	mov    %eax,%edx
  100571:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100575:	0f b6 00             	movzbl (%rax),%eax
  100578:	38 c2                	cmp    %al,%dl
  10057a:	0f 97 c0             	seta   %al
  10057d:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100580:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100584:	0f b6 00             	movzbl (%rax),%eax
  100587:	89 c1                	mov    %eax,%ecx
  100589:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10058d:	0f b6 00             	movzbl (%rax),%eax
  100590:	38 c1                	cmp    %al,%cl
  100592:	0f 92 c0             	setb   %al
  100595:	0f b6 c8             	movzbl %al,%ecx
  100598:	89 d0                	mov    %edx,%eax
  10059a:	29 c8                	sub    %ecx,%eax
}
  10059c:	c9                   	leave  
  10059d:	c3                   	ret    

000000000010059e <strchr>:

char* strchr(const char* s, int c) {
  10059e:	f3 0f 1e fa          	endbr64 
  1005a2:	55                   	push   %rbp
  1005a3:	48 89 e5             	mov    %rsp,%rbp
  1005a6:	48 83 ec 10          	sub    $0x10,%rsp
  1005aa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1005ae:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1005b1:	eb 05                	jmp    1005b8 <strchr+0x1a>
        ++s;
  1005b3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1005b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005bc:	0f b6 00             	movzbl (%rax),%eax
  1005bf:	84 c0                	test   %al,%al
  1005c1:	74 0e                	je     1005d1 <strchr+0x33>
  1005c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005c7:	0f b6 00             	movzbl (%rax),%eax
  1005ca:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1005cd:	38 d0                	cmp    %dl,%al
  1005cf:	75 e2                	jne    1005b3 <strchr+0x15>
    }
    if (*s == (char) c) {
  1005d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005d5:	0f b6 00             	movzbl (%rax),%eax
  1005d8:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1005db:	38 d0                	cmp    %dl,%al
  1005dd:	75 06                	jne    1005e5 <strchr+0x47>
        return (char*) s;
  1005df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005e3:	eb 05                	jmp    1005ea <strchr+0x4c>
    } else {
        return NULL;
  1005e5:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1005ea:	c9                   	leave  
  1005eb:	c3                   	ret    

00000000001005ec <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1005ec:	f3 0f 1e fa          	endbr64 
  1005f0:	55                   	push   %rbp
  1005f1:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1005f4:	8b 05 36 2a 00 00    	mov    0x2a36(%rip),%eax        # 103030 <rand_seed_set>
  1005fa:	85 c0                	test   %eax,%eax
  1005fc:	75 0a                	jne    100608 <rand+0x1c>
        srand(819234718U);
  1005fe:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100603:	e8 24 00 00 00       	call   10062c <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100608:	8b 05 26 2a 00 00    	mov    0x2a26(%rip),%eax        # 103034 <rand_seed>
  10060e:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100614:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100619:	89 05 15 2a 00 00    	mov    %eax,0x2a15(%rip)        # 103034 <rand_seed>
    return rand_seed & RAND_MAX;
  10061f:	8b 05 0f 2a 00 00    	mov    0x2a0f(%rip),%eax        # 103034 <rand_seed>
  100625:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10062a:	5d                   	pop    %rbp
  10062b:	c3                   	ret    

000000000010062c <srand>:

void srand(unsigned seed) {
  10062c:	f3 0f 1e fa          	endbr64 
  100630:	55                   	push   %rbp
  100631:	48 89 e5             	mov    %rsp,%rbp
  100634:	48 83 ec 08          	sub    $0x8,%rsp
  100638:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  10063b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10063e:	89 05 f0 29 00 00    	mov    %eax,0x29f0(%rip)        # 103034 <rand_seed>
    rand_seed_set = 1;
  100644:	c7 05 e2 29 00 00 01 	movl   $0x1,0x29e2(%rip)        # 103030 <rand_seed_set>
  10064b:	00 00 00 
}
  10064e:	90                   	nop
  10064f:	c9                   	leave  
  100650:	c3                   	ret    

0000000000100651 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100651:	f3 0f 1e fa          	endbr64 
  100655:	55                   	push   %rbp
  100656:	48 89 e5             	mov    %rsp,%rbp
  100659:	48 83 ec 28          	sub    $0x28,%rsp
  10065d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100661:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100665:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100668:	48 8d 05 e1 17 00 00 	lea    0x17e1(%rip),%rax        # 101e50 <upper_digits.1>
  10066f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  100673:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100677:	79 0e                	jns    100687 <fill_numbuf+0x36>
        digits = lower_digits;
  100679:	48 8d 05 f0 17 00 00 	lea    0x17f0(%rip),%rax        # 101e70 <lower_digits.0>
  100680:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  100684:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100687:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10068c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100690:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100693:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100696:	48 63 c8             	movslq %eax,%rcx
  100699:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10069d:	ba 00 00 00 00       	mov    $0x0,%edx
  1006a2:	48 f7 f1             	div    %rcx
  1006a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006a9:	48 01 d0             	add    %rdx,%rax
  1006ac:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1006b1:	0f b6 10             	movzbl (%rax),%edx
  1006b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006b8:	88 10                	mov    %dl,(%rax)
        val /= base;
  1006ba:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1006bd:	48 63 f0             	movslq %eax,%rsi
  1006c0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1006c4:	ba 00 00 00 00       	mov    $0x0,%edx
  1006c9:	48 f7 f6             	div    %rsi
  1006cc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1006d0:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1006d5:	75 bc                	jne    100693 <fill_numbuf+0x42>
    return numbuf_end;
  1006d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1006db:	c9                   	leave  
  1006dc:	c3                   	ret    

00000000001006dd <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1006dd:	f3 0f 1e fa          	endbr64 
  1006e1:	55                   	push   %rbp
  1006e2:	48 89 e5             	mov    %rsp,%rbp
  1006e5:	53                   	push   %rbx
  1006e6:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1006ed:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1006f4:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1006fa:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100701:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100708:	e9 bd 09 00 00       	jmp    1010ca <printer_vprintf+0x9ed>
        if (*format != '%') {
  10070d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100714:	0f b6 00             	movzbl (%rax),%eax
  100717:	3c 25                	cmp    $0x25,%al
  100719:	74 31                	je     10074c <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  10071b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100722:	4c 8b 00             	mov    (%rax),%r8
  100725:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10072c:	0f b6 00             	movzbl (%rax),%eax
  10072f:	0f b6 c8             	movzbl %al,%ecx
  100732:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100738:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10073f:	89 ce                	mov    %ecx,%esi
  100741:	48 89 c7             	mov    %rax,%rdi
  100744:	41 ff d0             	call   *%r8
            continue;
  100747:	e9 76 09 00 00       	jmp    1010c2 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  10074c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100753:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10075a:	01 
  10075b:	eb 4d                	jmp    1007aa <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  10075d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100764:	0f b6 00             	movzbl (%rax),%eax
  100767:	0f be c0             	movsbl %al,%eax
  10076a:	89 c6                	mov    %eax,%esi
  10076c:	48 8d 05 dd 15 00 00 	lea    0x15dd(%rip),%rax        # 101d50 <flag_chars>
  100773:	48 89 c7             	mov    %rax,%rdi
  100776:	e8 23 fe ff ff       	call   10059e <strchr>
  10077b:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  10077f:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100784:	74 34                	je     1007ba <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  100786:	48 8d 15 c3 15 00 00 	lea    0x15c3(%rip),%rdx        # 101d50 <flag_chars>
  10078d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100791:	48 29 d0             	sub    %rdx,%rax
  100794:	ba 01 00 00 00       	mov    $0x1,%edx
  100799:	89 c1                	mov    %eax,%ecx
  10079b:	d3 e2                	shl    %cl,%edx
  10079d:	89 d0                	mov    %edx,%eax
  10079f:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1007a2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007a9:	01 
  1007aa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007b1:	0f b6 00             	movzbl (%rax),%eax
  1007b4:	84 c0                	test   %al,%al
  1007b6:	75 a5                	jne    10075d <printer_vprintf+0x80>
  1007b8:	eb 01                	jmp    1007bb <printer_vprintf+0xde>
            } else {
                break;
  1007ba:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1007bb:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1007c2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007c9:	0f b6 00             	movzbl (%rax),%eax
  1007cc:	3c 30                	cmp    $0x30,%al
  1007ce:	7e 67                	jle    100837 <printer_vprintf+0x15a>
  1007d0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007d7:	0f b6 00             	movzbl (%rax),%eax
  1007da:	3c 39                	cmp    $0x39,%al
  1007dc:	7f 59                	jg     100837 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1007de:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1007e5:	eb 2e                	jmp    100815 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  1007e7:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1007ea:	89 d0                	mov    %edx,%eax
  1007ec:	c1 e0 02             	shl    $0x2,%eax
  1007ef:	01 d0                	add    %edx,%eax
  1007f1:	01 c0                	add    %eax,%eax
  1007f3:	89 c1                	mov    %eax,%ecx
  1007f5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007fc:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100800:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100807:	0f b6 00             	movzbl (%rax),%eax
  10080a:	0f be c0             	movsbl %al,%eax
  10080d:	01 c8                	add    %ecx,%eax
  10080f:	83 e8 30             	sub    $0x30,%eax
  100812:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100815:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10081c:	0f b6 00             	movzbl (%rax),%eax
  10081f:	3c 2f                	cmp    $0x2f,%al
  100821:	0f 8e 85 00 00 00    	jle    1008ac <printer_vprintf+0x1cf>
  100827:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10082e:	0f b6 00             	movzbl (%rax),%eax
  100831:	3c 39                	cmp    $0x39,%al
  100833:	7e b2                	jle    1007e7 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  100835:	eb 75                	jmp    1008ac <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  100837:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10083e:	0f b6 00             	movzbl (%rax),%eax
  100841:	3c 2a                	cmp    $0x2a,%al
  100843:	75 68                	jne    1008ad <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  100845:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10084c:	8b 00                	mov    (%rax),%eax
  10084e:	83 f8 2f             	cmp    $0x2f,%eax
  100851:	77 30                	ja     100883 <printer_vprintf+0x1a6>
  100853:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10085a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10085e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100865:	8b 00                	mov    (%rax),%eax
  100867:	89 c0                	mov    %eax,%eax
  100869:	48 01 d0             	add    %rdx,%rax
  10086c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100873:	8b 12                	mov    (%rdx),%edx
  100875:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100878:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10087f:	89 0a                	mov    %ecx,(%rdx)
  100881:	eb 1a                	jmp    10089d <printer_vprintf+0x1c0>
  100883:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10088a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10088e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100892:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100899:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10089d:	8b 00                	mov    (%rax),%eax
  10089f:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1008a2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008a9:	01 
  1008aa:	eb 01                	jmp    1008ad <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  1008ac:	90                   	nop
        }

        // process precision
        int precision = -1;
  1008ad:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1008b4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008bb:	0f b6 00             	movzbl (%rax),%eax
  1008be:	3c 2e                	cmp    $0x2e,%al
  1008c0:	0f 85 00 01 00 00    	jne    1009c6 <printer_vprintf+0x2e9>
            ++format;
  1008c6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008cd:	01 
            if (*format >= '0' && *format <= '9') {
  1008ce:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008d5:	0f b6 00             	movzbl (%rax),%eax
  1008d8:	3c 2f                	cmp    $0x2f,%al
  1008da:	7e 67                	jle    100943 <printer_vprintf+0x266>
  1008dc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008e3:	0f b6 00             	movzbl (%rax),%eax
  1008e6:	3c 39                	cmp    $0x39,%al
  1008e8:	7f 59                	jg     100943 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008ea:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1008f1:	eb 2e                	jmp    100921 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  1008f3:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1008f6:	89 d0                	mov    %edx,%eax
  1008f8:	c1 e0 02             	shl    $0x2,%eax
  1008fb:	01 d0                	add    %edx,%eax
  1008fd:	01 c0                	add    %eax,%eax
  1008ff:	89 c1                	mov    %eax,%ecx
  100901:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100908:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10090c:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100913:	0f b6 00             	movzbl (%rax),%eax
  100916:	0f be c0             	movsbl %al,%eax
  100919:	01 c8                	add    %ecx,%eax
  10091b:	83 e8 30             	sub    $0x30,%eax
  10091e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100921:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100928:	0f b6 00             	movzbl (%rax),%eax
  10092b:	3c 2f                	cmp    $0x2f,%al
  10092d:	0f 8e 85 00 00 00    	jle    1009b8 <printer_vprintf+0x2db>
  100933:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10093a:	0f b6 00             	movzbl (%rax),%eax
  10093d:	3c 39                	cmp    $0x39,%al
  10093f:	7e b2                	jle    1008f3 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  100941:	eb 75                	jmp    1009b8 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  100943:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10094a:	0f b6 00             	movzbl (%rax),%eax
  10094d:	3c 2a                	cmp    $0x2a,%al
  10094f:	75 68                	jne    1009b9 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  100951:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100958:	8b 00                	mov    (%rax),%eax
  10095a:	83 f8 2f             	cmp    $0x2f,%eax
  10095d:	77 30                	ja     10098f <printer_vprintf+0x2b2>
  10095f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100966:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10096a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100971:	8b 00                	mov    (%rax),%eax
  100973:	89 c0                	mov    %eax,%eax
  100975:	48 01 d0             	add    %rdx,%rax
  100978:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10097f:	8b 12                	mov    (%rdx),%edx
  100981:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100984:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10098b:	89 0a                	mov    %ecx,(%rdx)
  10098d:	eb 1a                	jmp    1009a9 <printer_vprintf+0x2cc>
  10098f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100996:	48 8b 40 08          	mov    0x8(%rax),%rax
  10099a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10099e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009a5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009a9:	8b 00                	mov    (%rax),%eax
  1009ab:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1009ae:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009b5:	01 
  1009b6:	eb 01                	jmp    1009b9 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  1009b8:	90                   	nop
            }
            if (precision < 0) {
  1009b9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1009bd:	79 07                	jns    1009c6 <printer_vprintf+0x2e9>
                precision = 0;
  1009bf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  1009c6:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  1009cd:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  1009d4:	00 
        int length = 0;
  1009d5:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  1009dc:	48 8d 05 73 13 00 00 	lea    0x1373(%rip),%rax        # 101d56 <flag_chars+0x6>
  1009e3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  1009e7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009ee:	0f b6 00             	movzbl (%rax),%eax
  1009f1:	0f be c0             	movsbl %al,%eax
  1009f4:	83 e8 43             	sub    $0x43,%eax
  1009f7:	83 f8 37             	cmp    $0x37,%eax
  1009fa:	0f 87 b6 03 00 00    	ja     100db6 <printer_vprintf+0x6d9>
  100a00:	89 c0                	mov    %eax,%eax
  100a02:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  100a09:	00 
  100a0a:	48 8d 05 53 13 00 00 	lea    0x1353(%rip),%rax        # 101d64 <flag_chars+0x14>
  100a11:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  100a14:	48 98                	cltq   
  100a16:	48 8d 15 47 13 00 00 	lea    0x1347(%rip),%rdx        # 101d64 <flag_chars+0x14>
  100a1d:	48 01 d0             	add    %rdx,%rax
  100a20:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  100a23:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100a2a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a31:	01 
            goto again;
  100a32:	eb b3                	jmp    1009e7 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100a34:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100a38:	74 5d                	je     100a97 <printer_vprintf+0x3ba>
  100a3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a41:	8b 00                	mov    (%rax),%eax
  100a43:	83 f8 2f             	cmp    $0x2f,%eax
  100a46:	77 30                	ja     100a78 <printer_vprintf+0x39b>
  100a48:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a4f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a53:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a5a:	8b 00                	mov    (%rax),%eax
  100a5c:	89 c0                	mov    %eax,%eax
  100a5e:	48 01 d0             	add    %rdx,%rax
  100a61:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a68:	8b 12                	mov    (%rdx),%edx
  100a6a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a6d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a74:	89 0a                	mov    %ecx,(%rdx)
  100a76:	eb 1a                	jmp    100a92 <printer_vprintf+0x3b5>
  100a78:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a7f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a83:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a87:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a8e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a92:	48 8b 00             	mov    (%rax),%rax
  100a95:	eb 5c                	jmp    100af3 <printer_vprintf+0x416>
  100a97:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a9e:	8b 00                	mov    (%rax),%eax
  100aa0:	83 f8 2f             	cmp    $0x2f,%eax
  100aa3:	77 30                	ja     100ad5 <printer_vprintf+0x3f8>
  100aa5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aac:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ab0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ab7:	8b 00                	mov    (%rax),%eax
  100ab9:	89 c0                	mov    %eax,%eax
  100abb:	48 01 d0             	add    %rdx,%rax
  100abe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ac5:	8b 12                	mov    (%rdx),%edx
  100ac7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100aca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ad1:	89 0a                	mov    %ecx,(%rdx)
  100ad3:	eb 1a                	jmp    100aef <printer_vprintf+0x412>
  100ad5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100adc:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ae0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ae4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aeb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aef:	8b 00                	mov    (%rax),%eax
  100af1:	48 98                	cltq   
  100af3:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100af7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100afb:	48 c1 f8 38          	sar    $0x38,%rax
  100aff:	25 80 00 00 00       	and    $0x80,%eax
  100b04:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100b07:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100b0b:	74 09                	je     100b16 <printer_vprintf+0x439>
  100b0d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100b11:	48 f7 d8             	neg    %rax
  100b14:	eb 04                	jmp    100b1a <printer_vprintf+0x43d>
  100b16:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100b1a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100b1e:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100b21:	83 c8 60             	or     $0x60,%eax
  100b24:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100b27:	e9 cf 02 00 00       	jmp    100dfb <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100b2c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100b30:	74 5d                	je     100b8f <printer_vprintf+0x4b2>
  100b32:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b39:	8b 00                	mov    (%rax),%eax
  100b3b:	83 f8 2f             	cmp    $0x2f,%eax
  100b3e:	77 30                	ja     100b70 <printer_vprintf+0x493>
  100b40:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b47:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b52:	8b 00                	mov    (%rax),%eax
  100b54:	89 c0                	mov    %eax,%eax
  100b56:	48 01 d0             	add    %rdx,%rax
  100b59:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b60:	8b 12                	mov    (%rdx),%edx
  100b62:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b65:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b6c:	89 0a                	mov    %ecx,(%rdx)
  100b6e:	eb 1a                	jmp    100b8a <printer_vprintf+0x4ad>
  100b70:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b77:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b7b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b7f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b86:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b8a:	48 8b 00             	mov    (%rax),%rax
  100b8d:	eb 5c                	jmp    100beb <printer_vprintf+0x50e>
  100b8f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b96:	8b 00                	mov    (%rax),%eax
  100b98:	83 f8 2f             	cmp    $0x2f,%eax
  100b9b:	77 30                	ja     100bcd <printer_vprintf+0x4f0>
  100b9d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ba4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ba8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100baf:	8b 00                	mov    (%rax),%eax
  100bb1:	89 c0                	mov    %eax,%eax
  100bb3:	48 01 d0             	add    %rdx,%rax
  100bb6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bbd:	8b 12                	mov    (%rdx),%edx
  100bbf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bc2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bc9:	89 0a                	mov    %ecx,(%rdx)
  100bcb:	eb 1a                	jmp    100be7 <printer_vprintf+0x50a>
  100bcd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bd4:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bd8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bdc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100be3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100be7:	8b 00                	mov    (%rax),%eax
  100be9:	89 c0                	mov    %eax,%eax
  100beb:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100bef:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100bf3:	e9 03 02 00 00       	jmp    100dfb <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100bf8:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100bff:	e9 28 ff ff ff       	jmp    100b2c <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100c04:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100c0b:	e9 1c ff ff ff       	jmp    100b2c <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100c10:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c17:	8b 00                	mov    (%rax),%eax
  100c19:	83 f8 2f             	cmp    $0x2f,%eax
  100c1c:	77 30                	ja     100c4e <printer_vprintf+0x571>
  100c1e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c25:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c30:	8b 00                	mov    (%rax),%eax
  100c32:	89 c0                	mov    %eax,%eax
  100c34:	48 01 d0             	add    %rdx,%rax
  100c37:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c3e:	8b 12                	mov    (%rdx),%edx
  100c40:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c43:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c4a:	89 0a                	mov    %ecx,(%rdx)
  100c4c:	eb 1a                	jmp    100c68 <printer_vprintf+0x58b>
  100c4e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c55:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c59:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c5d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c64:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c68:	48 8b 00             	mov    (%rax),%rax
  100c6b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100c6f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100c76:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100c7d:	e9 79 01 00 00       	jmp    100dfb <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100c82:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c89:	8b 00                	mov    (%rax),%eax
  100c8b:	83 f8 2f             	cmp    $0x2f,%eax
  100c8e:	77 30                	ja     100cc0 <printer_vprintf+0x5e3>
  100c90:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c97:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c9b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ca2:	8b 00                	mov    (%rax),%eax
  100ca4:	89 c0                	mov    %eax,%eax
  100ca6:	48 01 d0             	add    %rdx,%rax
  100ca9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cb0:	8b 12                	mov    (%rdx),%edx
  100cb2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cb5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cbc:	89 0a                	mov    %ecx,(%rdx)
  100cbe:	eb 1a                	jmp    100cda <printer_vprintf+0x5fd>
  100cc0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cc7:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ccb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ccf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cd6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cda:	48 8b 00             	mov    (%rax),%rax
  100cdd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100ce1:	e9 15 01 00 00       	jmp    100dfb <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100ce6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ced:	8b 00                	mov    (%rax),%eax
  100cef:	83 f8 2f             	cmp    $0x2f,%eax
  100cf2:	77 30                	ja     100d24 <printer_vprintf+0x647>
  100cf4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cfb:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d06:	8b 00                	mov    (%rax),%eax
  100d08:	89 c0                	mov    %eax,%eax
  100d0a:	48 01 d0             	add    %rdx,%rax
  100d0d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d14:	8b 12                	mov    (%rdx),%edx
  100d16:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d19:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d20:	89 0a                	mov    %ecx,(%rdx)
  100d22:	eb 1a                	jmp    100d3e <printer_vprintf+0x661>
  100d24:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d2b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d2f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d33:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d3a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d3e:	8b 00                	mov    (%rax),%eax
  100d40:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100d46:	e9 77 03 00 00       	jmp    1010c2 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100d4b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d4f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100d53:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d5a:	8b 00                	mov    (%rax),%eax
  100d5c:	83 f8 2f             	cmp    $0x2f,%eax
  100d5f:	77 30                	ja     100d91 <printer_vprintf+0x6b4>
  100d61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d68:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d73:	8b 00                	mov    (%rax),%eax
  100d75:	89 c0                	mov    %eax,%eax
  100d77:	48 01 d0             	add    %rdx,%rax
  100d7a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d81:	8b 12                	mov    (%rdx),%edx
  100d83:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d86:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d8d:	89 0a                	mov    %ecx,(%rdx)
  100d8f:	eb 1a                	jmp    100dab <printer_vprintf+0x6ce>
  100d91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d98:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d9c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100da0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100da7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100dab:	8b 00                	mov    (%rax),%eax
  100dad:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100db0:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100db4:	eb 45                	jmp    100dfb <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100db6:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100dba:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100dbe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dc5:	0f b6 00             	movzbl (%rax),%eax
  100dc8:	84 c0                	test   %al,%al
  100dca:	74 0c                	je     100dd8 <printer_vprintf+0x6fb>
  100dcc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dd3:	0f b6 00             	movzbl (%rax),%eax
  100dd6:	eb 05                	jmp    100ddd <printer_vprintf+0x700>
  100dd8:	b8 25 00 00 00       	mov    $0x25,%eax
  100ddd:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100de0:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100de4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100deb:	0f b6 00             	movzbl (%rax),%eax
  100dee:	84 c0                	test   %al,%al
  100df0:	75 08                	jne    100dfa <printer_vprintf+0x71d>
                format--;
  100df2:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100df9:	01 
            }
            break;
  100dfa:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100dfb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dfe:	83 e0 20             	and    $0x20,%eax
  100e01:	85 c0                	test   %eax,%eax
  100e03:	74 1e                	je     100e23 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100e05:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e09:	48 83 c0 18          	add    $0x18,%rax
  100e0d:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100e10:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100e14:	48 89 ce             	mov    %rcx,%rsi
  100e17:	48 89 c7             	mov    %rax,%rdi
  100e1a:	e8 32 f8 ff ff       	call   100651 <fill_numbuf>
  100e1f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100e23:	48 8d 05 2c 0f 00 00 	lea    0xf2c(%rip),%rax        # 101d56 <flag_chars+0x6>
  100e2a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100e2e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e31:	83 e0 20             	and    $0x20,%eax
  100e34:	85 c0                	test   %eax,%eax
  100e36:	74 51                	je     100e89 <printer_vprintf+0x7ac>
  100e38:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e3b:	83 e0 40             	and    $0x40,%eax
  100e3e:	85 c0                	test   %eax,%eax
  100e40:	74 47                	je     100e89 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100e42:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e45:	25 80 00 00 00       	and    $0x80,%eax
  100e4a:	85 c0                	test   %eax,%eax
  100e4c:	74 0d                	je     100e5b <printer_vprintf+0x77e>
                prefix = "-";
  100e4e:	48 8d 05 02 0f 00 00 	lea    0xf02(%rip),%rax        # 101d57 <flag_chars+0x7>
  100e55:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e59:	eb 7d                	jmp    100ed8 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100e5b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e5e:	83 e0 10             	and    $0x10,%eax
  100e61:	85 c0                	test   %eax,%eax
  100e63:	74 0d                	je     100e72 <printer_vprintf+0x795>
                prefix = "+";
  100e65:	48 8d 05 ed 0e 00 00 	lea    0xeed(%rip),%rax        # 101d59 <flag_chars+0x9>
  100e6c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e70:	eb 66                	jmp    100ed8 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100e72:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e75:	83 e0 08             	and    $0x8,%eax
  100e78:	85 c0                	test   %eax,%eax
  100e7a:	74 5c                	je     100ed8 <printer_vprintf+0x7fb>
                prefix = " ";
  100e7c:	48 8d 05 d8 0e 00 00 	lea    0xed8(%rip),%rax        # 101d5b <flag_chars+0xb>
  100e83:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e87:	eb 4f                	jmp    100ed8 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100e89:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e8c:	83 e0 20             	and    $0x20,%eax
  100e8f:	85 c0                	test   %eax,%eax
  100e91:	74 46                	je     100ed9 <printer_vprintf+0x7fc>
  100e93:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e96:	83 e0 01             	and    $0x1,%eax
  100e99:	85 c0                	test   %eax,%eax
  100e9b:	74 3c                	je     100ed9 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100e9d:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100ea1:	74 06                	je     100ea9 <printer_vprintf+0x7cc>
  100ea3:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100ea7:	75 30                	jne    100ed9 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100ea9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100eae:	75 0c                	jne    100ebc <printer_vprintf+0x7df>
  100eb0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100eb3:	25 00 01 00 00       	and    $0x100,%eax
  100eb8:	85 c0                	test   %eax,%eax
  100eba:	74 1d                	je     100ed9 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100ebc:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100ec0:	75 09                	jne    100ecb <printer_vprintf+0x7ee>
  100ec2:	48 8d 05 94 0e 00 00 	lea    0xe94(%rip),%rax        # 101d5d <flag_chars+0xd>
  100ec9:	eb 07                	jmp    100ed2 <printer_vprintf+0x7f5>
  100ecb:	48 8d 05 8e 0e 00 00 	lea    0xe8e(%rip),%rax        # 101d60 <flag_chars+0x10>
  100ed2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100ed6:	eb 01                	jmp    100ed9 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100ed8:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100ed9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100edd:	78 24                	js     100f03 <printer_vprintf+0x826>
  100edf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ee2:	83 e0 20             	and    $0x20,%eax
  100ee5:	85 c0                	test   %eax,%eax
  100ee7:	75 1a                	jne    100f03 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100ee9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100eec:	48 63 d0             	movslq %eax,%rdx
  100eef:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ef3:	48 89 d6             	mov    %rdx,%rsi
  100ef6:	48 89 c7             	mov    %rax,%rdi
  100ef9:	e8 91 f5 ff ff       	call   10048f <strnlen>
  100efe:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100f01:	eb 0f                	jmp    100f12 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100f03:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f07:	48 89 c7             	mov    %rax,%rdi
  100f0a:	e8 4b f5 ff ff       	call   10045a <strlen>
  100f0f:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100f12:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f15:	83 e0 20             	and    $0x20,%eax
  100f18:	85 c0                	test   %eax,%eax
  100f1a:	74 20                	je     100f3c <printer_vprintf+0x85f>
  100f1c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100f20:	78 1a                	js     100f3c <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100f22:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f25:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100f28:	7e 08                	jle    100f32 <printer_vprintf+0x855>
  100f2a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f2d:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100f30:	eb 05                	jmp    100f37 <printer_vprintf+0x85a>
  100f32:	b8 00 00 00 00       	mov    $0x0,%eax
  100f37:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f3a:	eb 5c                	jmp    100f98 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100f3c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f3f:	83 e0 20             	and    $0x20,%eax
  100f42:	85 c0                	test   %eax,%eax
  100f44:	74 4b                	je     100f91 <printer_vprintf+0x8b4>
  100f46:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f49:	83 e0 02             	and    $0x2,%eax
  100f4c:	85 c0                	test   %eax,%eax
  100f4e:	74 41                	je     100f91 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100f50:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f53:	83 e0 04             	and    $0x4,%eax
  100f56:	85 c0                	test   %eax,%eax
  100f58:	75 37                	jne    100f91 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100f5a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f5e:	48 89 c7             	mov    %rax,%rdi
  100f61:	e8 f4 f4 ff ff       	call   10045a <strlen>
  100f66:	89 c2                	mov    %eax,%edx
  100f68:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100f6b:	01 d0                	add    %edx,%eax
  100f6d:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100f70:	7e 1f                	jle    100f91 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100f72:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f75:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100f78:	89 c3                	mov    %eax,%ebx
  100f7a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f7e:	48 89 c7             	mov    %rax,%rdi
  100f81:	e8 d4 f4 ff ff       	call   10045a <strlen>
  100f86:	89 c2                	mov    %eax,%edx
  100f88:	89 d8                	mov    %ebx,%eax
  100f8a:	29 d0                	sub    %edx,%eax
  100f8c:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f8f:	eb 07                	jmp    100f98 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100f91:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100f98:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100f9b:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100f9e:	01 d0                	add    %edx,%eax
  100fa0:	48 63 d8             	movslq %eax,%rbx
  100fa3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fa7:	48 89 c7             	mov    %rax,%rdi
  100faa:	e8 ab f4 ff ff       	call   10045a <strlen>
  100faf:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100fb3:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100fb6:	29 d0                	sub    %edx,%eax
  100fb8:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100fbb:	eb 25                	jmp    100fe2 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  100fbd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fc4:	48 8b 08             	mov    (%rax),%rcx
  100fc7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fcd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fd4:	be 20 00 00 00       	mov    $0x20,%esi
  100fd9:	48 89 c7             	mov    %rax,%rdi
  100fdc:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100fde:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100fe2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fe5:	83 e0 04             	and    $0x4,%eax
  100fe8:	85 c0                	test   %eax,%eax
  100fea:	75 36                	jne    101022 <printer_vprintf+0x945>
  100fec:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100ff0:	7f cb                	jg     100fbd <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  100ff2:	eb 2e                	jmp    101022 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  100ff4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ffb:	4c 8b 00             	mov    (%rax),%r8
  100ffe:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101002:	0f b6 00             	movzbl (%rax),%eax
  101005:	0f b6 c8             	movzbl %al,%ecx
  101008:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10100e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101015:	89 ce                	mov    %ecx,%esi
  101017:	48 89 c7             	mov    %rax,%rdi
  10101a:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  10101d:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101022:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101026:	0f b6 00             	movzbl (%rax),%eax
  101029:	84 c0                	test   %al,%al
  10102b:	75 c7                	jne    100ff4 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  10102d:	eb 25                	jmp    101054 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  10102f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101036:	48 8b 08             	mov    (%rax),%rcx
  101039:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10103f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101046:	be 30 00 00 00       	mov    $0x30,%esi
  10104b:	48 89 c7             	mov    %rax,%rdi
  10104e:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101050:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101054:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101058:	7f d5                	jg     10102f <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  10105a:	eb 32                	jmp    10108e <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  10105c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101063:	4c 8b 00             	mov    (%rax),%r8
  101066:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10106a:	0f b6 00             	movzbl (%rax),%eax
  10106d:	0f b6 c8             	movzbl %al,%ecx
  101070:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101076:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10107d:	89 ce                	mov    %ecx,%esi
  10107f:	48 89 c7             	mov    %rax,%rdi
  101082:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101085:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  10108a:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10108e:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101092:	7f c8                	jg     10105c <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  101094:	eb 25                	jmp    1010bb <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  101096:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10109d:	48 8b 08             	mov    (%rax),%rcx
  1010a0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010a6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010ad:	be 20 00 00 00       	mov    $0x20,%esi
  1010b2:	48 89 c7             	mov    %rax,%rdi
  1010b5:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1010b7:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1010bb:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1010bf:	7f d5                	jg     101096 <printer_vprintf+0x9b9>
        }
    done: ;
  1010c1:	90                   	nop
    for (; *format; ++format) {
  1010c2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1010c9:	01 
  1010ca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010d1:	0f b6 00             	movzbl (%rax),%eax
  1010d4:	84 c0                	test   %al,%al
  1010d6:	0f 85 31 f6 ff ff    	jne    10070d <printer_vprintf+0x30>
    }
}
  1010dc:	90                   	nop
  1010dd:	90                   	nop
  1010de:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1010e2:	c9                   	leave  
  1010e3:	c3                   	ret    

00000000001010e4 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1010e4:	f3 0f 1e fa          	endbr64 
  1010e8:	55                   	push   %rbp
  1010e9:	48 89 e5             	mov    %rsp,%rbp
  1010ec:	48 83 ec 20          	sub    $0x20,%rsp
  1010f0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1010f4:	89 f0                	mov    %esi,%eax
  1010f6:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1010f9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1010fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101100:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101104:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101108:	48 8b 40 08          	mov    0x8(%rax),%rax
  10110c:	48 8d 15 8d 7e fb ff 	lea    -0x48173(%rip),%rdx        # b8fa0 <console+0xfa0>
  101113:	48 39 d0             	cmp    %rdx,%rax
  101116:	72 0f                	jb     101127 <console_putc+0x43>
        cp->cursor = console;
  101118:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10111c:	48 8d 15 dd 6e fb ff 	lea    -0x49123(%rip),%rdx        # b8000 <console>
  101123:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  101127:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10112b:	0f 85 82 00 00 00    	jne    1011b3 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  101131:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101135:	48 8b 40 08          	mov    0x8(%rax),%rax
  101139:	48 8d 15 c0 6e fb ff 	lea    -0x49140(%rip),%rdx        # b8000 <console>
  101140:	48 29 d0             	sub    %rdx,%rax
  101143:	48 d1 f8             	sar    %rax
  101146:	48 89 c1             	mov    %rax,%rcx
  101149:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101150:	66 66 66 
  101153:	48 89 c8             	mov    %rcx,%rax
  101156:	48 f7 ea             	imul   %rdx
  101159:	48 89 d0             	mov    %rdx,%rax
  10115c:	48 c1 f8 05          	sar    $0x5,%rax
  101160:	48 89 ce             	mov    %rcx,%rsi
  101163:	48 c1 fe 3f          	sar    $0x3f,%rsi
  101167:	48 29 f0             	sub    %rsi,%rax
  10116a:	48 89 c2             	mov    %rax,%rdx
  10116d:	48 89 d0             	mov    %rdx,%rax
  101170:	48 c1 e0 02          	shl    $0x2,%rax
  101174:	48 01 d0             	add    %rdx,%rax
  101177:	48 c1 e0 04          	shl    $0x4,%rax
  10117b:	48 29 c1             	sub    %rax,%rcx
  10117e:	48 89 ca             	mov    %rcx,%rdx
  101181:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101184:	eb 25                	jmp    1011ab <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  101186:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101189:	83 c8 20             	or     $0x20,%eax
  10118c:	89 c6                	mov    %eax,%esi
  10118e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101192:	48 8b 40 08          	mov    0x8(%rax),%rax
  101196:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10119a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10119e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011a2:	89 f2                	mov    %esi,%edx
  1011a4:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1011a7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1011ab:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1011af:	75 d5                	jne    101186 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1011b1:	eb 24                	jmp    1011d7 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  1011b3:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1011b7:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1011ba:	89 d6                	mov    %edx,%esi
  1011bc:	09 c6                	or     %eax,%esi
  1011be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011c2:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011c6:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1011ca:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1011ce:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011d2:	89 f2                	mov    %esi,%edx
  1011d4:	66 89 10             	mov    %dx,(%rax)
}
  1011d7:	90                   	nop
  1011d8:	c9                   	leave  
  1011d9:	c3                   	ret    

00000000001011da <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1011da:	f3 0f 1e fa          	endbr64 
  1011de:	55                   	push   %rbp
  1011df:	48 89 e5             	mov    %rsp,%rbp
  1011e2:	48 83 ec 30          	sub    $0x30,%rsp
  1011e6:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1011e9:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1011ec:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1011f0:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1011f4:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 1010e4 <console_putc>
  1011fb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1011ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101203:	78 09                	js     10120e <console_vprintf+0x34>
  101205:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  10120c:	7e 07                	jle    101215 <console_vprintf+0x3b>
        cpos = 0;
  10120e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101215:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101218:	48 98                	cltq   
  10121a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  10121e:	48 8d 05 db 6d fb ff 	lea    -0x49225(%rip),%rax        # b8000 <console>
  101225:	48 01 d0             	add    %rdx,%rax
  101228:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  10122c:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101230:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101234:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101237:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  10123b:	48 89 c7             	mov    %rax,%rdi
  10123e:	e8 9a f4 ff ff       	call   1006dd <printer_vprintf>
    return cp.cursor - console;
  101243:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101247:	48 8d 15 b2 6d fb ff 	lea    -0x4924e(%rip),%rdx        # b8000 <console>
  10124e:	48 29 d0             	sub    %rdx,%rax
  101251:	48 d1 f8             	sar    %rax
}
  101254:	c9                   	leave  
  101255:	c3                   	ret    

0000000000101256 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101256:	f3 0f 1e fa          	endbr64 
  10125a:	55                   	push   %rbp
  10125b:	48 89 e5             	mov    %rsp,%rbp
  10125e:	48 83 ec 60          	sub    $0x60,%rsp
  101262:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101265:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101268:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  10126c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101270:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101274:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101278:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  10127f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101283:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101287:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10128b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10128f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101293:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101297:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10129a:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10129d:	89 c7                	mov    %eax,%edi
  10129f:	e8 36 ff ff ff       	call   1011da <console_vprintf>
  1012a4:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1012a7:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1012aa:	c9                   	leave  
  1012ab:	c3                   	ret    

00000000001012ac <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1012ac:	f3 0f 1e fa          	endbr64 
  1012b0:	55                   	push   %rbp
  1012b1:	48 89 e5             	mov    %rsp,%rbp
  1012b4:	48 83 ec 20          	sub    $0x20,%rsp
  1012b8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1012bc:	89 f0                	mov    %esi,%eax
  1012be:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1012c1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1012c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1012c8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1012cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012d0:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1012d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012d8:	48 8b 40 10          	mov    0x10(%rax),%rax
  1012dc:	48 39 c2             	cmp    %rax,%rdx
  1012df:	73 1a                	jae    1012fb <string_putc+0x4f>
        *sp->s++ = c;
  1012e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012e5:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012e9:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1012ed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1012f1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012f5:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1012f9:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1012fb:	90                   	nop
  1012fc:	c9                   	leave  
  1012fd:	c3                   	ret    

00000000001012fe <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1012fe:	f3 0f 1e fa          	endbr64 
  101302:	55                   	push   %rbp
  101303:	48 89 e5             	mov    %rsp,%rbp
  101306:	48 83 ec 40          	sub    $0x40,%rsp
  10130a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  10130e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101312:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101316:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10131a:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 1012ac <string_putc>
  101321:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  101325:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101329:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  10132d:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101332:	74 33                	je     101367 <vsnprintf+0x69>
        sp.end = s + size - 1;
  101334:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101338:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10133c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101340:	48 01 d0             	add    %rdx,%rax
  101343:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101347:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  10134b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  10134f:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101353:	be 00 00 00 00       	mov    $0x0,%esi
  101358:	48 89 c7             	mov    %rax,%rdi
  10135b:	e8 7d f3 ff ff       	call   1006dd <printer_vprintf>
        *sp.s = 0;
  101360:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101364:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101367:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10136b:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  10136f:	c9                   	leave  
  101370:	c3                   	ret    

0000000000101371 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101371:	f3 0f 1e fa          	endbr64 
  101375:	55                   	push   %rbp
  101376:	48 89 e5             	mov    %rsp,%rbp
  101379:	48 83 ec 70          	sub    $0x70,%rsp
  10137d:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101381:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101385:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101389:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10138d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101391:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101395:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10139c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1013a0:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1013a4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1013a8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1013ac:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1013b0:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1013b4:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1013b8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1013bc:	48 89 c7             	mov    %rax,%rdi
  1013bf:	e8 3a ff ff ff       	call   1012fe <vsnprintf>
  1013c4:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1013c7:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1013ca:	c9                   	leave  
  1013cb:	c3                   	ret    

00000000001013cc <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1013cc:	f3 0f 1e fa          	endbr64 
  1013d0:	55                   	push   %rbp
  1013d1:	48 89 e5             	mov    %rsp,%rbp
  1013d4:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1013d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1013df:	eb 1a                	jmp    1013fb <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  1013e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1013e4:	48 98                	cltq   
  1013e6:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1013ea:	48 8d 05 0f 6c fb ff 	lea    -0x493f1(%rip),%rax        # b8000 <console>
  1013f1:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1013f7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1013fb:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101402:	7e dd                	jle    1013e1 <console_clear+0x15>
    }
    cursorpos = 0;
  101404:	c7 05 ee 7b fb ff 00 	movl   $0x0,-0x48412(%rip)        # b8ffc <cursorpos>
  10140b:	00 00 00 
}
  10140e:	90                   	nop
  10140f:	c9                   	leave  
  101410:	c3                   	ret    
