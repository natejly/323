
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t* stack_bottom;

// Parent: continuously forks/yields without exiting
// Child: continuously allocates in a row, then exits

void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	41 54                	push   %r12
  10000a:	53                   	push   %rbx

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000b:	cd 31                	int    $0x31
  10000d:	41 89 c4             	mov    %eax,%r12d

    pid_t parent = sys_getpid();
    app_printf(parent, "Parent pid is %d\n", parent);
  100010:	89 c2                	mov    %eax,%edx
  100012:	48 8d 35 f7 13 00 00 	lea    0x13f7(%rip),%rsi        # 101410 <console_clear+0x4a>
  100019:	89 c7                	mov    %eax,%edi
  10001b:	b8 00 00 00 00       	mov    $0x0,%eax
  100020:	e8 42 01 00 00       	call   100167 <app_printf>
// sys_fork()
//    Fork the current process. On success, return the child's process ID to
//    the parent, and return 0 to the child. On failure, return -1.
static inline pid_t sys_fork(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100025:	cd 34                	int    $0x34
    pid_t fork = sys_fork();
    assert(fork >= 0);
  100027:	85 c0                	test   %eax,%eax
  100029:	78 46                	js     100071 <process_main+0x71>
  10002b:	89 c3                	mov    %eax,%ebx

    srand(parent);
  10002d:	44 89 e7             	mov    %r12d,%edi
  100030:	e8 f1 05 00 00       	call   100626 <srand>
    if(fork != 0){
  100035:	85 db                	test   %ebx,%ebx
  100037:	75 50                	jne    100089 <process_main+0x89>
    asm volatile ("int %1" : "=a" (result)
  100039:	cd 31                	int    $0x31
  10003b:	89 c3                	mov    %eax,%ebx
    }
    else
    {
child:;
        pid_t p = sys_getpid();
        srand(p);
  10003d:	89 c7                	mov    %eax,%edi
  10003f:	e8 e2 05 00 00       	call   100626 <srand>

        // The heap starts on the page right after the 'end' symbol,
        // whose address is the first address not allocated to process code
        // or data.
        heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100044:	48 8d 05 cc 2f 00 00 	lea    0x2fcc(%rip),%rax        # 103017 <end+0xfff>
  10004b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100051:	48 89 05 b0 1f 00 00 	mov    %rax,0x1fb0(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100058:	48 89 e0             	mov    %rsp,%rax

        // The bottom of the stack is the first address on the current
        // stack page (this process never needs more than one stack page).
        stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  10005b:	48 83 e8 01          	sub    $0x1,%rax
  10005f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100065:	48 89 05 94 1f 00 00 	mov    %rax,0x1f94(%rip)        # 102000 <stack_bottom>
  10006c:	e9 a0 00 00 00       	jmp    100111 <process_main+0x111>
    assert(fork >= 0);
  100071:	48 8d 15 aa 13 00 00 	lea    0x13aa(%rip),%rdx        # 101422 <console_clear+0x5c>
  100078:	be 13 00 00 00       	mov    $0x13,%esi
  10007d:	48 8d 3d a8 13 00 00 	lea    0x13a8(%rip),%rdi        # 10142c <console_clear+0x66>
  100084:	e8 4d 02 00 00       	call   1002d6 <assert_fail>
        app_printf(parent, "%dp\n", parent);
  100089:	44 89 e2             	mov    %r12d,%edx
  10008c:	48 8d 35 a9 13 00 00 	lea    0x13a9(%rip),%rsi        # 10143c <console_clear+0x76>
  100093:	44 89 e7             	mov    %r12d,%edi
  100096:	b8 00 00 00 00       	mov    $0x0,%eax
  10009b:	e8 c7 00 00 00       	call   100167 <app_printf>
  1000a0:	eb 08                	jmp    1000aa <process_main+0xaa>
    asm volatile ("int %1" : "=a" (result)
  1000a2:	cd 34                	int    $0x34
                if(fork_new == 0){
  1000a4:	85 c0                	test   %eax,%eax
  1000a6:	74 91                	je     100039 <process_main+0x39>
    asm volatile ("int %0" : /* no result */
  1000a8:	cd 32                	int    $0x32
            if(rand() % ALLOC_SLOWDOWN == parent){
  1000aa:	e8 37 05 00 00       	call   1005e6 <rand>
  1000af:	48 63 d0             	movslq %eax,%rdx
  1000b2:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1000b9:	48 c1 fa 25          	sar    $0x25,%rdx
  1000bd:	89 c1                	mov    %eax,%ecx
  1000bf:	c1 f9 1f             	sar    $0x1f,%ecx
  1000c2:	29 ca                	sub    %ecx,%edx
  1000c4:	6b d2 64             	imul   $0x64,%edx,%edx
  1000c7:	29 d0                	sub    %edx,%eax
  1000c9:	44 39 e0             	cmp    %r12d,%eax
  1000cc:	74 d4                	je     1000a2 <process_main+0xa2>
  1000ce:	cd 32                	int    $0x32
}
  1000d0:	eb d8                	jmp    1000aa <process_main+0xaa>

        // Allocate heap pages until (1) hit the stack (out of address space)
        // or (2) allocation fails (out of physical memory).
        while (1) {
            if ((rand() % ALLOC_SLOWDOWN) < p) {
                assert(sys_getpid() != parent);
  1000d2:	48 8d 15 68 13 00 00 	lea    0x1368(%rip),%rdx        # 101441 <console_clear+0x7b>
  1000d9:	be 39 00 00 00       	mov    $0x39,%esi
  1000de:	48 8d 3d 47 13 00 00 	lea    0x1347(%rip),%rdi        # 10142c <console_clear+0x66>
  1000e5:	e8 ec 01 00 00       	call   1002d6 <assert_fail>
void process_main(void) {
  1000ea:	b8 0a 00 00 00       	mov    $0xa,%eax
    asm volatile ("int %0" : /* no result */
  1000ef:	cd 32                	int    $0x32
            sys_yield();
        }

        // After running out of memory, make an exit after 10 yields
        int i = 10;
        while(i--){
  1000f1:	83 e8 01             	sub    $0x1,%eax
  1000f4:	75 f9                	jne    1000ef <process_main+0xef>
            sys_yield();
        }
        app_printf(p, "%d\n", p);
  1000f6:	89 da                	mov    %ebx,%edx
  1000f8:	48 8d 35 1f 13 00 00 	lea    0x131f(%rip),%rsi        # 10141e <console_clear+0x58>
  1000ff:	89 df                	mov    %ebx,%edi
  100101:	b8 00 00 00 00       	mov    $0x0,%eax
  100106:	e8 5c 00 00 00       	call   100167 <app_printf>

// sys_exit()
//    Exit this process. Does not return.
static inline void sys_exit(void) __attribute__((noreturn));
static inline void sys_exit(void) {
    asm volatile ("int %0" : /* no result */
  10010b:	cd 35                	int    $0x35
                  : "i" (INT_SYS_EXIT)
                  : "cc", "memory");
 spinloop: goto spinloop;       // should never get here
  10010d:	eb fe                	jmp    10010d <process_main+0x10d>
    asm volatile ("int %0" : /* no result */
  10010f:	cd 32                	int    $0x32
            if ((rand() % ALLOC_SLOWDOWN) < p) {
  100111:	e8 d0 04 00 00       	call   1005e6 <rand>
  100116:	48 63 d0             	movslq %eax,%rdx
  100119:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100120:	48 c1 fa 25          	sar    $0x25,%rdx
  100124:	89 c1                	mov    %eax,%ecx
  100126:	c1 f9 1f             	sar    $0x1f,%ecx
  100129:	29 ca                	sub    %ecx,%edx
  10012b:	6b d2 64             	imul   $0x64,%edx,%edx
  10012e:	29 d0                	sub    %edx,%eax
  100130:	39 d8                	cmp    %ebx,%eax
  100132:	7d db                	jge    10010f <process_main+0x10f>
    asm volatile ("int %1" : "=a" (result)
  100134:	cd 31                	int    $0x31
                assert(sys_getpid() != parent);
  100136:	41 39 c4             	cmp    %eax,%r12d
  100139:	74 97                	je     1000d2 <process_main+0xd2>
                if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  10013b:	48 8b 3d c6 1e 00 00 	mov    0x1ec6(%rip),%rdi        # 102008 <heap_top>
  100142:	48 3b 3d b7 1e 00 00 	cmp    0x1eb7(%rip),%rdi        # 102000 <stack_bottom>
  100149:	74 9f                	je     1000ea <process_main+0xea>
    asm volatile ("int %1" : "=a" (result)
  10014b:	cd 33                	int    $0x33
  10014d:	85 c0                	test   %eax,%eax
  10014f:	78 99                	js     1000ea <process_main+0xea>
                *heap_top = p;      /* check we have write access to new page */
  100151:	48 8b 05 b0 1e 00 00 	mov    0x1eb0(%rip),%rax        # 102008 <heap_top>
  100158:	88 18                	mov    %bl,(%rax)
                heap_top += PAGESIZE;
  10015a:	48 81 05 a3 1e 00 00 	addq   $0x1000,0x1ea3(%rip)        # 102008 <heap_top>
  100161:	00 10 00 00 
  100165:	eb a8                	jmp    10010f <process_main+0x10f>

0000000000100167 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100167:	f3 0f 1e fa          	endbr64 
  10016b:	55                   	push   %rbp
  10016c:	48 89 e5             	mov    %rsp,%rbp
  10016f:	48 83 ec 50          	sub    $0x50,%rsp
  100173:	49 89 f2             	mov    %rsi,%r10
  100176:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10017a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10017e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100182:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100186:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  10018b:	85 ff                	test   %edi,%edi
  10018d:	78 32                	js     1001c1 <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  10018f:	48 63 ff             	movslq %edi,%rdi
  100192:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100199:	cc cc cc 
  10019c:	48 89 f8             	mov    %rdi,%rax
  10019f:	48 f7 e2             	mul    %rdx
  1001a2:	48 89 d0             	mov    %rdx,%rax
  1001a5:	48 c1 e8 02          	shr    $0x2,%rax
  1001a9:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1001ad:	48 01 c2             	add    %rax,%rdx
  1001b0:	48 29 d7             	sub    %rdx,%rdi
  1001b3:	48 8d 05 d3 12 00 00 	lea    0x12d3(%rip),%rax        # 10148d <col.0>
  1001ba:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  1001be:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1001c1:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1001c8:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001cc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1001d0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1001d4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1001d8:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1001dc:	4c 89 d2             	mov    %r10,%rdx
  1001df:	8b 3d 17 8e fb ff    	mov    -0x471e9(%rip),%edi        # b8ffc <cursorpos>
  1001e5:	e8 ea 0f 00 00       	call   1011d4 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1001ea:	3d 30 07 00 00       	cmp    $0x730,%eax
  1001ef:	ba 00 00 00 00       	mov    $0x0,%edx
  1001f4:	0f 4d c2             	cmovge %edx,%eax
  1001f7:	89 05 ff 8d fb ff    	mov    %eax,-0x47201(%rip)        # b8ffc <cursorpos>
    }
}
  1001fd:	c9                   	leave  
  1001fe:	c3                   	ret    

00000000001001ff <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  1001ff:	f3 0f 1e fa          	endbr64 
  100203:	55                   	push   %rbp
  100204:	48 89 e5             	mov    %rsp,%rbp
  100207:	53                   	push   %rbx
  100208:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  10020f:	48 89 fb             	mov    %rdi,%rbx
  100212:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100216:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10021a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  10021e:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100222:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100226:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  10022d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100231:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100235:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100239:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  10023d:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100244:	ba 07 00 00 00       	mov    $0x7,%edx
  100249:	48 8d 35 08 12 00 00 	lea    0x1208(%rip),%rsi        # 101458 <console_clear+0x92>
  100250:	e8 b6 00 00 00       	call   10030b <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100255:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100259:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100260:	48 89 da             	mov    %rbx,%rdx
  100263:	be 99 00 00 00       	mov    $0x99,%esi
  100268:	e8 8b 10 00 00       	call   1012f8 <vsnprintf>
  10026d:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100270:	85 d2                	test   %edx,%edx
  100272:	7e 0f                	jle    100283 <panic+0x84>
  100274:	83 c0 06             	add    $0x6,%eax
  100277:	48 98                	cltq   
  100279:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100280:	0a 
  100281:	75 2b                	jne    1002ae <panic+0xaf>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100283:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  10028a:	48 8d 15 cf 11 00 00 	lea    0x11cf(%rip),%rdx        # 101460 <console_clear+0x9a>
  100291:	be 00 c0 00 00       	mov    $0xc000,%esi
  100296:	bf 30 07 00 00       	mov    $0x730,%edi
  10029b:	b8 00 00 00 00       	mov    $0x0,%eax
  1002a0:	e8 ab 0f 00 00       	call   101250 <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  1002a5:	bf 00 00 00 00       	mov    $0x0,%edi
  1002aa:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  1002ac:	eb fe                	jmp    1002ac <panic+0xad>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1002ae:	48 63 c2             	movslq %edx,%rax
  1002b1:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1002b7:	0f 94 c2             	sete   %dl
  1002ba:	0f b6 d2             	movzbl %dl,%edx
  1002bd:	48 29 d0             	sub    %rdx,%rax
  1002c0:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1002c7:	ff 
  1002c8:	48 8d 35 51 11 00 00 	lea    0x1151(%rip),%rsi        # 101420 <console_clear+0x5a>
  1002cf:	e8 f8 01 00 00       	call   1004cc <strcpy>
  1002d4:	eb ad                	jmp    100283 <panic+0x84>

00000000001002d6 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1002d6:	f3 0f 1e fa          	endbr64 
  1002da:	55                   	push   %rbp
  1002db:	48 89 e5             	mov    %rsp,%rbp
  1002de:	48 89 f9             	mov    %rdi,%rcx
  1002e1:	41 89 f0             	mov    %esi,%r8d
  1002e4:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1002e7:	48 8d 15 7a 11 00 00 	lea    0x117a(%rip),%rdx        # 101468 <console_clear+0xa2>
  1002ee:	be 00 c0 00 00       	mov    $0xc000,%esi
  1002f3:	bf 30 07 00 00       	mov    $0x730,%edi
  1002f8:	b8 00 00 00 00       	mov    $0x0,%eax
  1002fd:	e8 4e 0f 00 00       	call   101250 <console_printf>
    asm volatile ("int %0" : /* no result */
  100302:	bf 00 00 00 00       	mov    $0x0,%edi
  100307:	cd 30                	int    $0x30
 loop: goto loop;
  100309:	eb fe                	jmp    100309 <assert_fail+0x33>

000000000010030b <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10030b:	f3 0f 1e fa          	endbr64 
  10030f:	55                   	push   %rbp
  100310:	48 89 e5             	mov    %rsp,%rbp
  100313:	48 83 ec 28          	sub    $0x28,%rsp
  100317:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10031b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10031f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100323:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100327:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10032b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10032f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100333:	eb 1c                	jmp    100351 <memcpy+0x46>
        *d = *s;
  100335:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100339:	0f b6 10             	movzbl (%rax),%edx
  10033c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100340:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100342:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100347:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10034c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100351:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100356:	75 dd                	jne    100335 <memcpy+0x2a>
    }
    return dst;
  100358:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10035c:	c9                   	leave  
  10035d:	c3                   	ret    

000000000010035e <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  10035e:	f3 0f 1e fa          	endbr64 
  100362:	55                   	push   %rbp
  100363:	48 89 e5             	mov    %rsp,%rbp
  100366:	48 83 ec 28          	sub    $0x28,%rsp
  10036a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10036e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100372:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100376:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10037a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10037e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100382:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100386:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10038a:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10038e:	73 6a                	jae    1003fa <memmove+0x9c>
  100390:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100394:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100398:	48 01 d0             	add    %rdx,%rax
  10039b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  10039f:	73 59                	jae    1003fa <memmove+0x9c>
        s += n, d += n;
  1003a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003a5:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1003a9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003ad:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1003b1:	eb 17                	jmp    1003ca <memmove+0x6c>
            *--d = *--s;
  1003b3:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1003b8:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1003bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003c1:	0f b6 10             	movzbl (%rax),%edx
  1003c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003c8:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003ce:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003d2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003d6:	48 85 c0             	test   %rax,%rax
  1003d9:	75 d8                	jne    1003b3 <memmove+0x55>
    if (s < d && s + n > d) {
  1003db:	eb 2e                	jmp    10040b <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1003dd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1003e1:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003e5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003ed:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003f1:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1003f5:	0f b6 12             	movzbl (%rdx),%edx
  1003f8:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003fe:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100402:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100406:	48 85 c0             	test   %rax,%rax
  100409:	75 d2                	jne    1003dd <memmove+0x7f>
        }
    }
    return dst;
  10040b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10040f:	c9                   	leave  
  100410:	c3                   	ret    

0000000000100411 <memset>:

void* memset(void* v, int c, size_t n) {
  100411:	f3 0f 1e fa          	endbr64 
  100415:	55                   	push   %rbp
  100416:	48 89 e5             	mov    %rsp,%rbp
  100419:	48 83 ec 28          	sub    $0x28,%rsp
  10041d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100421:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100424:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100428:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10042c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100430:	eb 15                	jmp    100447 <memset+0x36>
        *p = c;
  100432:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100435:	89 c2                	mov    %eax,%edx
  100437:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10043b:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10043d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100442:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100447:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10044c:	75 e4                	jne    100432 <memset+0x21>
    }
    return v;
  10044e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100452:	c9                   	leave  
  100453:	c3                   	ret    

0000000000100454 <strlen>:

size_t strlen(const char* s) {
  100454:	f3 0f 1e fa          	endbr64 
  100458:	55                   	push   %rbp
  100459:	48 89 e5             	mov    %rsp,%rbp
  10045c:	48 83 ec 18          	sub    $0x18,%rsp
  100460:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100464:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10046b:	00 
  10046c:	eb 0a                	jmp    100478 <strlen+0x24>
        ++n;
  10046e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100473:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100478:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10047c:	0f b6 00             	movzbl (%rax),%eax
  10047f:	84 c0                	test   %al,%al
  100481:	75 eb                	jne    10046e <strlen+0x1a>
    }
    return n;
  100483:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100487:	c9                   	leave  
  100488:	c3                   	ret    

0000000000100489 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100489:	f3 0f 1e fa          	endbr64 
  10048d:	55                   	push   %rbp
  10048e:	48 89 e5             	mov    %rsp,%rbp
  100491:	48 83 ec 20          	sub    $0x20,%rsp
  100495:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100499:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10049d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1004a4:	00 
  1004a5:	eb 0a                	jmp    1004b1 <strnlen+0x28>
        ++n;
  1004a7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1004ac:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1004b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004b5:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1004b9:	74 0b                	je     1004c6 <strnlen+0x3d>
  1004bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004bf:	0f b6 00             	movzbl (%rax),%eax
  1004c2:	84 c0                	test   %al,%al
  1004c4:	75 e1                	jne    1004a7 <strnlen+0x1e>
    }
    return n;
  1004c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1004ca:	c9                   	leave  
  1004cb:	c3                   	ret    

00000000001004cc <strcpy>:

char* strcpy(char* dst, const char* src) {
  1004cc:	f3 0f 1e fa          	endbr64 
  1004d0:	55                   	push   %rbp
  1004d1:	48 89 e5             	mov    %rsp,%rbp
  1004d4:	48 83 ec 20          	sub    $0x20,%rsp
  1004d8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004dc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1004e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1004e8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1004ec:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004f0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1004f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004f8:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004fc:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100500:	0f b6 12             	movzbl (%rdx),%edx
  100503:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100505:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100509:	48 83 e8 01          	sub    $0x1,%rax
  10050d:	0f b6 00             	movzbl (%rax),%eax
  100510:	84 c0                	test   %al,%al
  100512:	75 d4                	jne    1004e8 <strcpy+0x1c>
    return dst;
  100514:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100518:	c9                   	leave  
  100519:	c3                   	ret    

000000000010051a <strcmp>:

int strcmp(const char* a, const char* b) {
  10051a:	f3 0f 1e fa          	endbr64 
  10051e:	55                   	push   %rbp
  10051f:	48 89 e5             	mov    %rsp,%rbp
  100522:	48 83 ec 10          	sub    $0x10,%rsp
  100526:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10052a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10052e:	eb 0a                	jmp    10053a <strcmp+0x20>
        ++a, ++b;
  100530:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100535:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10053a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10053e:	0f b6 00             	movzbl (%rax),%eax
  100541:	84 c0                	test   %al,%al
  100543:	74 1d                	je     100562 <strcmp+0x48>
  100545:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100549:	0f b6 00             	movzbl (%rax),%eax
  10054c:	84 c0                	test   %al,%al
  10054e:	74 12                	je     100562 <strcmp+0x48>
  100550:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100554:	0f b6 10             	movzbl (%rax),%edx
  100557:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10055b:	0f b6 00             	movzbl (%rax),%eax
  10055e:	38 c2                	cmp    %al,%dl
  100560:	74 ce                	je     100530 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100562:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100566:	0f b6 00             	movzbl (%rax),%eax
  100569:	89 c2                	mov    %eax,%edx
  10056b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10056f:	0f b6 00             	movzbl (%rax),%eax
  100572:	38 c2                	cmp    %al,%dl
  100574:	0f 97 c0             	seta   %al
  100577:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  10057a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10057e:	0f b6 00             	movzbl (%rax),%eax
  100581:	89 c1                	mov    %eax,%ecx
  100583:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100587:	0f b6 00             	movzbl (%rax),%eax
  10058a:	38 c1                	cmp    %al,%cl
  10058c:	0f 92 c0             	setb   %al
  10058f:	0f b6 c8             	movzbl %al,%ecx
  100592:	89 d0                	mov    %edx,%eax
  100594:	29 c8                	sub    %ecx,%eax
}
  100596:	c9                   	leave  
  100597:	c3                   	ret    

0000000000100598 <strchr>:

char* strchr(const char* s, int c) {
  100598:	f3 0f 1e fa          	endbr64 
  10059c:	55                   	push   %rbp
  10059d:	48 89 e5             	mov    %rsp,%rbp
  1005a0:	48 83 ec 10          	sub    $0x10,%rsp
  1005a4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1005a8:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1005ab:	eb 05                	jmp    1005b2 <strchr+0x1a>
        ++s;
  1005ad:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1005b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005b6:	0f b6 00             	movzbl (%rax),%eax
  1005b9:	84 c0                	test   %al,%al
  1005bb:	74 0e                	je     1005cb <strchr+0x33>
  1005bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005c1:	0f b6 00             	movzbl (%rax),%eax
  1005c4:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1005c7:	38 d0                	cmp    %dl,%al
  1005c9:	75 e2                	jne    1005ad <strchr+0x15>
    }
    if (*s == (char) c) {
  1005cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005cf:	0f b6 00             	movzbl (%rax),%eax
  1005d2:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1005d5:	38 d0                	cmp    %dl,%al
  1005d7:	75 06                	jne    1005df <strchr+0x47>
        return (char*) s;
  1005d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005dd:	eb 05                	jmp    1005e4 <strchr+0x4c>
    } else {
        return NULL;
  1005df:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1005e4:	c9                   	leave  
  1005e5:	c3                   	ret    

00000000001005e6 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1005e6:	f3 0f 1e fa          	endbr64 
  1005ea:	55                   	push   %rbp
  1005eb:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1005ee:	8b 05 1c 1a 00 00    	mov    0x1a1c(%rip),%eax        # 102010 <rand_seed_set>
  1005f4:	85 c0                	test   %eax,%eax
  1005f6:	75 0a                	jne    100602 <rand+0x1c>
        srand(819234718U);
  1005f8:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1005fd:	e8 24 00 00 00       	call   100626 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100602:	8b 05 0c 1a 00 00    	mov    0x1a0c(%rip),%eax        # 102014 <rand_seed>
  100608:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  10060e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100613:	89 05 fb 19 00 00    	mov    %eax,0x19fb(%rip)        # 102014 <rand_seed>
    return rand_seed & RAND_MAX;
  100619:	8b 05 f5 19 00 00    	mov    0x19f5(%rip),%eax        # 102014 <rand_seed>
  10061f:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100624:	5d                   	pop    %rbp
  100625:	c3                   	ret    

0000000000100626 <srand>:

void srand(unsigned seed) {
  100626:	f3 0f 1e fa          	endbr64 
  10062a:	55                   	push   %rbp
  10062b:	48 89 e5             	mov    %rsp,%rbp
  10062e:	48 83 ec 08          	sub    $0x8,%rsp
  100632:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100635:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100638:	89 05 d6 19 00 00    	mov    %eax,0x19d6(%rip)        # 102014 <rand_seed>
    rand_seed_set = 1;
  10063e:	c7 05 c8 19 00 00 01 	movl   $0x1,0x19c8(%rip)        # 102010 <rand_seed_set>
  100645:	00 00 00 
}
  100648:	90                   	nop
  100649:	c9                   	leave  
  10064a:	c3                   	ret    

000000000010064b <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10064b:	f3 0f 1e fa          	endbr64 
  10064f:	55                   	push   %rbp
  100650:	48 89 e5             	mov    %rsp,%rbp
  100653:	48 83 ec 28          	sub    $0x28,%rsp
  100657:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10065b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10065f:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100662:	48 8d 05 37 0f 00 00 	lea    0xf37(%rip),%rax        # 1015a0 <upper_digits.1>
  100669:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  10066d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100671:	79 0e                	jns    100681 <fill_numbuf+0x36>
        digits = lower_digits;
  100673:	48 8d 05 46 0f 00 00 	lea    0xf46(%rip),%rax        # 1015c0 <lower_digits.0>
  10067a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  10067e:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100681:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100686:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10068a:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  10068d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100690:	48 63 c8             	movslq %eax,%rcx
  100693:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100697:	ba 00 00 00 00       	mov    $0x0,%edx
  10069c:	48 f7 f1             	div    %rcx
  10069f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006a3:	48 01 d0             	add    %rdx,%rax
  1006a6:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1006ab:	0f b6 10             	movzbl (%rax),%edx
  1006ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006b2:	88 10                	mov    %dl,(%rax)
        val /= base;
  1006b4:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1006b7:	48 63 f0             	movslq %eax,%rsi
  1006ba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1006be:	ba 00 00 00 00       	mov    $0x0,%edx
  1006c3:	48 f7 f6             	div    %rsi
  1006c6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1006ca:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1006cf:	75 bc                	jne    10068d <fill_numbuf+0x42>
    return numbuf_end;
  1006d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1006d5:	c9                   	leave  
  1006d6:	c3                   	ret    

00000000001006d7 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1006d7:	f3 0f 1e fa          	endbr64 
  1006db:	55                   	push   %rbp
  1006dc:	48 89 e5             	mov    %rsp,%rbp
  1006df:	53                   	push   %rbx
  1006e0:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1006e7:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1006ee:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1006f4:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1006fb:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100702:	e9 bd 09 00 00       	jmp    1010c4 <printer_vprintf+0x9ed>
        if (*format != '%') {
  100707:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10070e:	0f b6 00             	movzbl (%rax),%eax
  100711:	3c 25                	cmp    $0x25,%al
  100713:	74 31                	je     100746 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  100715:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10071c:	4c 8b 00             	mov    (%rax),%r8
  10071f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100726:	0f b6 00             	movzbl (%rax),%eax
  100729:	0f b6 c8             	movzbl %al,%ecx
  10072c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100732:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100739:	89 ce                	mov    %ecx,%esi
  10073b:	48 89 c7             	mov    %rax,%rdi
  10073e:	41 ff d0             	call   *%r8
            continue;
  100741:	e9 76 09 00 00       	jmp    1010bc <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  100746:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  10074d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100754:	01 
  100755:	eb 4d                	jmp    1007a4 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  100757:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10075e:	0f b6 00             	movzbl (%rax),%eax
  100761:	0f be c0             	movsbl %al,%eax
  100764:	89 c6                	mov    %eax,%esi
  100766:	48 8d 05 33 0d 00 00 	lea    0xd33(%rip),%rax        # 1014a0 <flag_chars>
  10076d:	48 89 c7             	mov    %rax,%rdi
  100770:	e8 23 fe ff ff       	call   100598 <strchr>
  100775:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100779:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10077e:	74 34                	je     1007b4 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  100780:	48 8d 15 19 0d 00 00 	lea    0xd19(%rip),%rdx        # 1014a0 <flag_chars>
  100787:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  10078b:	48 29 d0             	sub    %rdx,%rax
  10078e:	ba 01 00 00 00       	mov    $0x1,%edx
  100793:	89 c1                	mov    %eax,%ecx
  100795:	d3 e2                	shl    %cl,%edx
  100797:	89 d0                	mov    %edx,%eax
  100799:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  10079c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007a3:	01 
  1007a4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007ab:	0f b6 00             	movzbl (%rax),%eax
  1007ae:	84 c0                	test   %al,%al
  1007b0:	75 a5                	jne    100757 <printer_vprintf+0x80>
  1007b2:	eb 01                	jmp    1007b5 <printer_vprintf+0xde>
            } else {
                break;
  1007b4:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1007b5:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1007bc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007c3:	0f b6 00             	movzbl (%rax),%eax
  1007c6:	3c 30                	cmp    $0x30,%al
  1007c8:	7e 67                	jle    100831 <printer_vprintf+0x15a>
  1007ca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007d1:	0f b6 00             	movzbl (%rax),%eax
  1007d4:	3c 39                	cmp    $0x39,%al
  1007d6:	7f 59                	jg     100831 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1007d8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1007df:	eb 2e                	jmp    10080f <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  1007e1:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1007e4:	89 d0                	mov    %edx,%eax
  1007e6:	c1 e0 02             	shl    $0x2,%eax
  1007e9:	01 d0                	add    %edx,%eax
  1007eb:	01 c0                	add    %eax,%eax
  1007ed:	89 c1                	mov    %eax,%ecx
  1007ef:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007f6:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1007fa:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100801:	0f b6 00             	movzbl (%rax),%eax
  100804:	0f be c0             	movsbl %al,%eax
  100807:	01 c8                	add    %ecx,%eax
  100809:	83 e8 30             	sub    $0x30,%eax
  10080c:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10080f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100816:	0f b6 00             	movzbl (%rax),%eax
  100819:	3c 2f                	cmp    $0x2f,%al
  10081b:	0f 8e 85 00 00 00    	jle    1008a6 <printer_vprintf+0x1cf>
  100821:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100828:	0f b6 00             	movzbl (%rax),%eax
  10082b:	3c 39                	cmp    $0x39,%al
  10082d:	7e b2                	jle    1007e1 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  10082f:	eb 75                	jmp    1008a6 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  100831:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100838:	0f b6 00             	movzbl (%rax),%eax
  10083b:	3c 2a                	cmp    $0x2a,%al
  10083d:	75 68                	jne    1008a7 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  10083f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100846:	8b 00                	mov    (%rax),%eax
  100848:	83 f8 2f             	cmp    $0x2f,%eax
  10084b:	77 30                	ja     10087d <printer_vprintf+0x1a6>
  10084d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100854:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100858:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10085f:	8b 00                	mov    (%rax),%eax
  100861:	89 c0                	mov    %eax,%eax
  100863:	48 01 d0             	add    %rdx,%rax
  100866:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10086d:	8b 12                	mov    (%rdx),%edx
  10086f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100872:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100879:	89 0a                	mov    %ecx,(%rdx)
  10087b:	eb 1a                	jmp    100897 <printer_vprintf+0x1c0>
  10087d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100884:	48 8b 40 08          	mov    0x8(%rax),%rax
  100888:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10088c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100893:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100897:	8b 00                	mov    (%rax),%eax
  100899:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  10089c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008a3:	01 
  1008a4:	eb 01                	jmp    1008a7 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  1008a6:	90                   	nop
        }

        // process precision
        int precision = -1;
  1008a7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1008ae:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008b5:	0f b6 00             	movzbl (%rax),%eax
  1008b8:	3c 2e                	cmp    $0x2e,%al
  1008ba:	0f 85 00 01 00 00    	jne    1009c0 <printer_vprintf+0x2e9>
            ++format;
  1008c0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008c7:	01 
            if (*format >= '0' && *format <= '9') {
  1008c8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008cf:	0f b6 00             	movzbl (%rax),%eax
  1008d2:	3c 2f                	cmp    $0x2f,%al
  1008d4:	7e 67                	jle    10093d <printer_vprintf+0x266>
  1008d6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008dd:	0f b6 00             	movzbl (%rax),%eax
  1008e0:	3c 39                	cmp    $0x39,%al
  1008e2:	7f 59                	jg     10093d <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008e4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1008eb:	eb 2e                	jmp    10091b <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  1008ed:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1008f0:	89 d0                	mov    %edx,%eax
  1008f2:	c1 e0 02             	shl    $0x2,%eax
  1008f5:	01 d0                	add    %edx,%eax
  1008f7:	01 c0                	add    %eax,%eax
  1008f9:	89 c1                	mov    %eax,%ecx
  1008fb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100902:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100906:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10090d:	0f b6 00             	movzbl (%rax),%eax
  100910:	0f be c0             	movsbl %al,%eax
  100913:	01 c8                	add    %ecx,%eax
  100915:	83 e8 30             	sub    $0x30,%eax
  100918:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10091b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100922:	0f b6 00             	movzbl (%rax),%eax
  100925:	3c 2f                	cmp    $0x2f,%al
  100927:	0f 8e 85 00 00 00    	jle    1009b2 <printer_vprintf+0x2db>
  10092d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100934:	0f b6 00             	movzbl (%rax),%eax
  100937:	3c 39                	cmp    $0x39,%al
  100939:	7e b2                	jle    1008ed <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  10093b:	eb 75                	jmp    1009b2 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  10093d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100944:	0f b6 00             	movzbl (%rax),%eax
  100947:	3c 2a                	cmp    $0x2a,%al
  100949:	75 68                	jne    1009b3 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  10094b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100952:	8b 00                	mov    (%rax),%eax
  100954:	83 f8 2f             	cmp    $0x2f,%eax
  100957:	77 30                	ja     100989 <printer_vprintf+0x2b2>
  100959:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100960:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100964:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10096b:	8b 00                	mov    (%rax),%eax
  10096d:	89 c0                	mov    %eax,%eax
  10096f:	48 01 d0             	add    %rdx,%rax
  100972:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100979:	8b 12                	mov    (%rdx),%edx
  10097b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10097e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100985:	89 0a                	mov    %ecx,(%rdx)
  100987:	eb 1a                	jmp    1009a3 <printer_vprintf+0x2cc>
  100989:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100990:	48 8b 40 08          	mov    0x8(%rax),%rax
  100994:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100998:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10099f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009a3:	8b 00                	mov    (%rax),%eax
  1009a5:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1009a8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009af:	01 
  1009b0:	eb 01                	jmp    1009b3 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  1009b2:	90                   	nop
            }
            if (precision < 0) {
  1009b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1009b7:	79 07                	jns    1009c0 <printer_vprintf+0x2e9>
                precision = 0;
  1009b9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  1009c0:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  1009c7:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  1009ce:	00 
        int length = 0;
  1009cf:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  1009d6:	48 8d 05 c9 0a 00 00 	lea    0xac9(%rip),%rax        # 1014a6 <flag_chars+0x6>
  1009dd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  1009e1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009e8:	0f b6 00             	movzbl (%rax),%eax
  1009eb:	0f be c0             	movsbl %al,%eax
  1009ee:	83 e8 43             	sub    $0x43,%eax
  1009f1:	83 f8 37             	cmp    $0x37,%eax
  1009f4:	0f 87 b6 03 00 00    	ja     100db0 <printer_vprintf+0x6d9>
  1009fa:	89 c0                	mov    %eax,%eax
  1009fc:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  100a03:	00 
  100a04:	48 8d 05 a9 0a 00 00 	lea    0xaa9(%rip),%rax        # 1014b4 <flag_chars+0x14>
  100a0b:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  100a0e:	48 98                	cltq   
  100a10:	48 8d 15 9d 0a 00 00 	lea    0xa9d(%rip),%rdx        # 1014b4 <flag_chars+0x14>
  100a17:	48 01 d0             	add    %rdx,%rax
  100a1a:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  100a1d:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100a24:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a2b:	01 
            goto again;
  100a2c:	eb b3                	jmp    1009e1 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100a2e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100a32:	74 5d                	je     100a91 <printer_vprintf+0x3ba>
  100a34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a3b:	8b 00                	mov    (%rax),%eax
  100a3d:	83 f8 2f             	cmp    $0x2f,%eax
  100a40:	77 30                	ja     100a72 <printer_vprintf+0x39b>
  100a42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a49:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a54:	8b 00                	mov    (%rax),%eax
  100a56:	89 c0                	mov    %eax,%eax
  100a58:	48 01 d0             	add    %rdx,%rax
  100a5b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a62:	8b 12                	mov    (%rdx),%edx
  100a64:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a67:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a6e:	89 0a                	mov    %ecx,(%rdx)
  100a70:	eb 1a                	jmp    100a8c <printer_vprintf+0x3b5>
  100a72:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a79:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a7d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a88:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a8c:	48 8b 00             	mov    (%rax),%rax
  100a8f:	eb 5c                	jmp    100aed <printer_vprintf+0x416>
  100a91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a98:	8b 00                	mov    (%rax),%eax
  100a9a:	83 f8 2f             	cmp    $0x2f,%eax
  100a9d:	77 30                	ja     100acf <printer_vprintf+0x3f8>
  100a9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aa6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100aaa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ab1:	8b 00                	mov    (%rax),%eax
  100ab3:	89 c0                	mov    %eax,%eax
  100ab5:	48 01 d0             	add    %rdx,%rax
  100ab8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100abf:	8b 12                	mov    (%rdx),%edx
  100ac1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ac4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100acb:	89 0a                	mov    %ecx,(%rdx)
  100acd:	eb 1a                	jmp    100ae9 <printer_vprintf+0x412>
  100acf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ad6:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ada:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ade:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ae5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ae9:	8b 00                	mov    (%rax),%eax
  100aeb:	48 98                	cltq   
  100aed:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100af1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100af5:	48 c1 f8 38          	sar    $0x38,%rax
  100af9:	25 80 00 00 00       	and    $0x80,%eax
  100afe:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100b01:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100b05:	74 09                	je     100b10 <printer_vprintf+0x439>
  100b07:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100b0b:	48 f7 d8             	neg    %rax
  100b0e:	eb 04                	jmp    100b14 <printer_vprintf+0x43d>
  100b10:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100b14:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100b18:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100b1b:	83 c8 60             	or     $0x60,%eax
  100b1e:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100b21:	e9 cf 02 00 00       	jmp    100df5 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100b26:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100b2a:	74 5d                	je     100b89 <printer_vprintf+0x4b2>
  100b2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b33:	8b 00                	mov    (%rax),%eax
  100b35:	83 f8 2f             	cmp    $0x2f,%eax
  100b38:	77 30                	ja     100b6a <printer_vprintf+0x493>
  100b3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b41:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b4c:	8b 00                	mov    (%rax),%eax
  100b4e:	89 c0                	mov    %eax,%eax
  100b50:	48 01 d0             	add    %rdx,%rax
  100b53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b5a:	8b 12                	mov    (%rdx),%edx
  100b5c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b66:	89 0a                	mov    %ecx,(%rdx)
  100b68:	eb 1a                	jmp    100b84 <printer_vprintf+0x4ad>
  100b6a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b71:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b75:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b79:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b80:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b84:	48 8b 00             	mov    (%rax),%rax
  100b87:	eb 5c                	jmp    100be5 <printer_vprintf+0x50e>
  100b89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b90:	8b 00                	mov    (%rax),%eax
  100b92:	83 f8 2f             	cmp    $0x2f,%eax
  100b95:	77 30                	ja     100bc7 <printer_vprintf+0x4f0>
  100b97:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b9e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ba2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ba9:	8b 00                	mov    (%rax),%eax
  100bab:	89 c0                	mov    %eax,%eax
  100bad:	48 01 d0             	add    %rdx,%rax
  100bb0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bb7:	8b 12                	mov    (%rdx),%edx
  100bb9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bbc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bc3:	89 0a                	mov    %ecx,(%rdx)
  100bc5:	eb 1a                	jmp    100be1 <printer_vprintf+0x50a>
  100bc7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bce:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bd2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bd6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bdd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100be1:	8b 00                	mov    (%rax),%eax
  100be3:	89 c0                	mov    %eax,%eax
  100be5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100be9:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100bed:	e9 03 02 00 00       	jmp    100df5 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100bf2:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100bf9:	e9 28 ff ff ff       	jmp    100b26 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100bfe:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100c05:	e9 1c ff ff ff       	jmp    100b26 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100c0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c11:	8b 00                	mov    (%rax),%eax
  100c13:	83 f8 2f             	cmp    $0x2f,%eax
  100c16:	77 30                	ja     100c48 <printer_vprintf+0x571>
  100c18:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c1f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c23:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c2a:	8b 00                	mov    (%rax),%eax
  100c2c:	89 c0                	mov    %eax,%eax
  100c2e:	48 01 d0             	add    %rdx,%rax
  100c31:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c38:	8b 12                	mov    (%rdx),%edx
  100c3a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c3d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c44:	89 0a                	mov    %ecx,(%rdx)
  100c46:	eb 1a                	jmp    100c62 <printer_vprintf+0x58b>
  100c48:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c4f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c53:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c57:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c5e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c62:	48 8b 00             	mov    (%rax),%rax
  100c65:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100c69:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100c70:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100c77:	e9 79 01 00 00       	jmp    100df5 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100c7c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c83:	8b 00                	mov    (%rax),%eax
  100c85:	83 f8 2f             	cmp    $0x2f,%eax
  100c88:	77 30                	ja     100cba <printer_vprintf+0x5e3>
  100c8a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c91:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c9c:	8b 00                	mov    (%rax),%eax
  100c9e:	89 c0                	mov    %eax,%eax
  100ca0:	48 01 d0             	add    %rdx,%rax
  100ca3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100caa:	8b 12                	mov    (%rdx),%edx
  100cac:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100caf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cb6:	89 0a                	mov    %ecx,(%rdx)
  100cb8:	eb 1a                	jmp    100cd4 <printer_vprintf+0x5fd>
  100cba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cc1:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cc5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cc9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cd0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cd4:	48 8b 00             	mov    (%rax),%rax
  100cd7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100cdb:	e9 15 01 00 00       	jmp    100df5 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100ce0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ce7:	8b 00                	mov    (%rax),%eax
  100ce9:	83 f8 2f             	cmp    $0x2f,%eax
  100cec:	77 30                	ja     100d1e <printer_vprintf+0x647>
  100cee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cf5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cf9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d00:	8b 00                	mov    (%rax),%eax
  100d02:	89 c0                	mov    %eax,%eax
  100d04:	48 01 d0             	add    %rdx,%rax
  100d07:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d0e:	8b 12                	mov    (%rdx),%edx
  100d10:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d13:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d1a:	89 0a                	mov    %ecx,(%rdx)
  100d1c:	eb 1a                	jmp    100d38 <printer_vprintf+0x661>
  100d1e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d25:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d29:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d2d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d34:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d38:	8b 00                	mov    (%rax),%eax
  100d3a:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100d40:	e9 77 03 00 00       	jmp    1010bc <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100d45:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d49:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100d4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d54:	8b 00                	mov    (%rax),%eax
  100d56:	83 f8 2f             	cmp    $0x2f,%eax
  100d59:	77 30                	ja     100d8b <printer_vprintf+0x6b4>
  100d5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d62:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d66:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d6d:	8b 00                	mov    (%rax),%eax
  100d6f:	89 c0                	mov    %eax,%eax
  100d71:	48 01 d0             	add    %rdx,%rax
  100d74:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d7b:	8b 12                	mov    (%rdx),%edx
  100d7d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d80:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d87:	89 0a                	mov    %ecx,(%rdx)
  100d89:	eb 1a                	jmp    100da5 <printer_vprintf+0x6ce>
  100d8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d92:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d96:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d9a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100da1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100da5:	8b 00                	mov    (%rax),%eax
  100da7:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100daa:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100dae:	eb 45                	jmp    100df5 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100db0:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100db4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100db8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dbf:	0f b6 00             	movzbl (%rax),%eax
  100dc2:	84 c0                	test   %al,%al
  100dc4:	74 0c                	je     100dd2 <printer_vprintf+0x6fb>
  100dc6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dcd:	0f b6 00             	movzbl (%rax),%eax
  100dd0:	eb 05                	jmp    100dd7 <printer_vprintf+0x700>
  100dd2:	b8 25 00 00 00       	mov    $0x25,%eax
  100dd7:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100dda:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100dde:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100de5:	0f b6 00             	movzbl (%rax),%eax
  100de8:	84 c0                	test   %al,%al
  100dea:	75 08                	jne    100df4 <printer_vprintf+0x71d>
                format--;
  100dec:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100df3:	01 
            }
            break;
  100df4:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100df5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100df8:	83 e0 20             	and    $0x20,%eax
  100dfb:	85 c0                	test   %eax,%eax
  100dfd:	74 1e                	je     100e1d <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100dff:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100e03:	48 83 c0 18          	add    $0x18,%rax
  100e07:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100e0a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100e0e:	48 89 ce             	mov    %rcx,%rsi
  100e11:	48 89 c7             	mov    %rax,%rdi
  100e14:	e8 32 f8 ff ff       	call   10064b <fill_numbuf>
  100e19:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100e1d:	48 8d 05 82 06 00 00 	lea    0x682(%rip),%rax        # 1014a6 <flag_chars+0x6>
  100e24:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100e28:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e2b:	83 e0 20             	and    $0x20,%eax
  100e2e:	85 c0                	test   %eax,%eax
  100e30:	74 51                	je     100e83 <printer_vprintf+0x7ac>
  100e32:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e35:	83 e0 40             	and    $0x40,%eax
  100e38:	85 c0                	test   %eax,%eax
  100e3a:	74 47                	je     100e83 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100e3c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e3f:	25 80 00 00 00       	and    $0x80,%eax
  100e44:	85 c0                	test   %eax,%eax
  100e46:	74 0d                	je     100e55 <printer_vprintf+0x77e>
                prefix = "-";
  100e48:	48 8d 05 58 06 00 00 	lea    0x658(%rip),%rax        # 1014a7 <flag_chars+0x7>
  100e4f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e53:	eb 7d                	jmp    100ed2 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100e55:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e58:	83 e0 10             	and    $0x10,%eax
  100e5b:	85 c0                	test   %eax,%eax
  100e5d:	74 0d                	je     100e6c <printer_vprintf+0x795>
                prefix = "+";
  100e5f:	48 8d 05 43 06 00 00 	lea    0x643(%rip),%rax        # 1014a9 <flag_chars+0x9>
  100e66:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e6a:	eb 66                	jmp    100ed2 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100e6c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e6f:	83 e0 08             	and    $0x8,%eax
  100e72:	85 c0                	test   %eax,%eax
  100e74:	74 5c                	je     100ed2 <printer_vprintf+0x7fb>
                prefix = " ";
  100e76:	48 8d 05 2e 06 00 00 	lea    0x62e(%rip),%rax        # 1014ab <flag_chars+0xb>
  100e7d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e81:	eb 4f                	jmp    100ed2 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100e83:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e86:	83 e0 20             	and    $0x20,%eax
  100e89:	85 c0                	test   %eax,%eax
  100e8b:	74 46                	je     100ed3 <printer_vprintf+0x7fc>
  100e8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e90:	83 e0 01             	and    $0x1,%eax
  100e93:	85 c0                	test   %eax,%eax
  100e95:	74 3c                	je     100ed3 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100e97:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100e9b:	74 06                	je     100ea3 <printer_vprintf+0x7cc>
  100e9d:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100ea1:	75 30                	jne    100ed3 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100ea3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100ea8:	75 0c                	jne    100eb6 <printer_vprintf+0x7df>
  100eaa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ead:	25 00 01 00 00       	and    $0x100,%eax
  100eb2:	85 c0                	test   %eax,%eax
  100eb4:	74 1d                	je     100ed3 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100eb6:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100eba:	75 09                	jne    100ec5 <printer_vprintf+0x7ee>
  100ebc:	48 8d 05 ea 05 00 00 	lea    0x5ea(%rip),%rax        # 1014ad <flag_chars+0xd>
  100ec3:	eb 07                	jmp    100ecc <printer_vprintf+0x7f5>
  100ec5:	48 8d 05 e4 05 00 00 	lea    0x5e4(%rip),%rax        # 1014b0 <flag_chars+0x10>
  100ecc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100ed0:	eb 01                	jmp    100ed3 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100ed2:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100ed3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ed7:	78 24                	js     100efd <printer_vprintf+0x826>
  100ed9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100edc:	83 e0 20             	and    $0x20,%eax
  100edf:	85 c0                	test   %eax,%eax
  100ee1:	75 1a                	jne    100efd <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100ee3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100ee6:	48 63 d0             	movslq %eax,%rdx
  100ee9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100eed:	48 89 d6             	mov    %rdx,%rsi
  100ef0:	48 89 c7             	mov    %rax,%rdi
  100ef3:	e8 91 f5 ff ff       	call   100489 <strnlen>
  100ef8:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100efb:	eb 0f                	jmp    100f0c <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100efd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100f01:	48 89 c7             	mov    %rax,%rdi
  100f04:	e8 4b f5 ff ff       	call   100454 <strlen>
  100f09:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100f0c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f0f:	83 e0 20             	and    $0x20,%eax
  100f12:	85 c0                	test   %eax,%eax
  100f14:	74 20                	je     100f36 <printer_vprintf+0x85f>
  100f16:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100f1a:	78 1a                	js     100f36 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100f1c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f1f:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100f22:	7e 08                	jle    100f2c <printer_vprintf+0x855>
  100f24:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f27:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100f2a:	eb 05                	jmp    100f31 <printer_vprintf+0x85a>
  100f2c:	b8 00 00 00 00       	mov    $0x0,%eax
  100f31:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f34:	eb 5c                	jmp    100f92 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100f36:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f39:	83 e0 20             	and    $0x20,%eax
  100f3c:	85 c0                	test   %eax,%eax
  100f3e:	74 4b                	je     100f8b <printer_vprintf+0x8b4>
  100f40:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f43:	83 e0 02             	and    $0x2,%eax
  100f46:	85 c0                	test   %eax,%eax
  100f48:	74 41                	je     100f8b <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100f4a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f4d:	83 e0 04             	and    $0x4,%eax
  100f50:	85 c0                	test   %eax,%eax
  100f52:	75 37                	jne    100f8b <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100f54:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f58:	48 89 c7             	mov    %rax,%rdi
  100f5b:	e8 f4 f4 ff ff       	call   100454 <strlen>
  100f60:	89 c2                	mov    %eax,%edx
  100f62:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100f65:	01 d0                	add    %edx,%eax
  100f67:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100f6a:	7e 1f                	jle    100f8b <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100f6c:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f6f:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100f72:	89 c3                	mov    %eax,%ebx
  100f74:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f78:	48 89 c7             	mov    %rax,%rdi
  100f7b:	e8 d4 f4 ff ff       	call   100454 <strlen>
  100f80:	89 c2                	mov    %eax,%edx
  100f82:	89 d8                	mov    %ebx,%eax
  100f84:	29 d0                	sub    %edx,%eax
  100f86:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f89:	eb 07                	jmp    100f92 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100f8b:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100f92:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100f95:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100f98:	01 d0                	add    %edx,%eax
  100f9a:	48 63 d8             	movslq %eax,%rbx
  100f9d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fa1:	48 89 c7             	mov    %rax,%rdi
  100fa4:	e8 ab f4 ff ff       	call   100454 <strlen>
  100fa9:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100fad:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100fb0:	29 d0                	sub    %edx,%eax
  100fb2:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100fb5:	eb 25                	jmp    100fdc <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  100fb7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fbe:	48 8b 08             	mov    (%rax),%rcx
  100fc1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fc7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fce:	be 20 00 00 00       	mov    $0x20,%esi
  100fd3:	48 89 c7             	mov    %rax,%rdi
  100fd6:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100fd8:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100fdc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fdf:	83 e0 04             	and    $0x4,%eax
  100fe2:	85 c0                	test   %eax,%eax
  100fe4:	75 36                	jne    10101c <printer_vprintf+0x945>
  100fe6:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100fea:	7f cb                	jg     100fb7 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  100fec:	eb 2e                	jmp    10101c <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  100fee:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ff5:	4c 8b 00             	mov    (%rax),%r8
  100ff8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ffc:	0f b6 00             	movzbl (%rax),%eax
  100fff:	0f b6 c8             	movzbl %al,%ecx
  101002:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101008:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10100f:	89 ce                	mov    %ecx,%esi
  101011:	48 89 c7             	mov    %rax,%rdi
  101014:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101017:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  10101c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101020:	0f b6 00             	movzbl (%rax),%eax
  101023:	84 c0                	test   %al,%al
  101025:	75 c7                	jne    100fee <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  101027:	eb 25                	jmp    10104e <printer_vprintf+0x977>
            p->putc(p, '0', color);
  101029:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101030:	48 8b 08             	mov    (%rax),%rcx
  101033:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101039:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101040:	be 30 00 00 00       	mov    $0x30,%esi
  101045:	48 89 c7             	mov    %rax,%rdi
  101048:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  10104a:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  10104e:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101052:	7f d5                	jg     101029 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  101054:	eb 32                	jmp    101088 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  101056:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10105d:	4c 8b 00             	mov    (%rax),%r8
  101060:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101064:	0f b6 00             	movzbl (%rax),%eax
  101067:	0f b6 c8             	movzbl %al,%ecx
  10106a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101070:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101077:	89 ce                	mov    %ecx,%esi
  101079:	48 89 c7             	mov    %rax,%rdi
  10107c:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  10107f:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101084:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101088:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10108c:	7f c8                	jg     101056 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  10108e:	eb 25                	jmp    1010b5 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  101090:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101097:	48 8b 08             	mov    (%rax),%rcx
  10109a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1010a0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1010a7:	be 20 00 00 00       	mov    $0x20,%esi
  1010ac:	48 89 c7             	mov    %rax,%rdi
  1010af:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1010b1:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1010b5:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1010b9:	7f d5                	jg     101090 <printer_vprintf+0x9b9>
        }
    done: ;
  1010bb:	90                   	nop
    for (; *format; ++format) {
  1010bc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1010c3:	01 
  1010c4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010cb:	0f b6 00             	movzbl (%rax),%eax
  1010ce:	84 c0                	test   %al,%al
  1010d0:	0f 85 31 f6 ff ff    	jne    100707 <printer_vprintf+0x30>
    }
}
  1010d6:	90                   	nop
  1010d7:	90                   	nop
  1010d8:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1010dc:	c9                   	leave  
  1010dd:	c3                   	ret    

00000000001010de <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1010de:	f3 0f 1e fa          	endbr64 
  1010e2:	55                   	push   %rbp
  1010e3:	48 89 e5             	mov    %rsp,%rbp
  1010e6:	48 83 ec 20          	sub    $0x20,%rsp
  1010ea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1010ee:	89 f0                	mov    %esi,%eax
  1010f0:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1010f3:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1010f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1010fa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1010fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101102:	48 8b 40 08          	mov    0x8(%rax),%rax
  101106:	48 8d 15 93 7e fb ff 	lea    -0x4816d(%rip),%rdx        # b8fa0 <console+0xfa0>
  10110d:	48 39 d0             	cmp    %rdx,%rax
  101110:	72 0f                	jb     101121 <console_putc+0x43>
        cp->cursor = console;
  101112:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101116:	48 8d 15 e3 6e fb ff 	lea    -0x4911d(%rip),%rdx        # b8000 <console>
  10111d:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  101121:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101125:	0f 85 82 00 00 00    	jne    1011ad <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  10112b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10112f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101133:	48 8d 15 c6 6e fb ff 	lea    -0x4913a(%rip),%rdx        # b8000 <console>
  10113a:	48 29 d0             	sub    %rdx,%rax
  10113d:	48 d1 f8             	sar    %rax
  101140:	48 89 c1             	mov    %rax,%rcx
  101143:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10114a:	66 66 66 
  10114d:	48 89 c8             	mov    %rcx,%rax
  101150:	48 f7 ea             	imul   %rdx
  101153:	48 89 d0             	mov    %rdx,%rax
  101156:	48 c1 f8 05          	sar    $0x5,%rax
  10115a:	48 89 ce             	mov    %rcx,%rsi
  10115d:	48 c1 fe 3f          	sar    $0x3f,%rsi
  101161:	48 29 f0             	sub    %rsi,%rax
  101164:	48 89 c2             	mov    %rax,%rdx
  101167:	48 89 d0             	mov    %rdx,%rax
  10116a:	48 c1 e0 02          	shl    $0x2,%rax
  10116e:	48 01 d0             	add    %rdx,%rax
  101171:	48 c1 e0 04          	shl    $0x4,%rax
  101175:	48 29 c1             	sub    %rax,%rcx
  101178:	48 89 ca             	mov    %rcx,%rdx
  10117b:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  10117e:	eb 25                	jmp    1011a5 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  101180:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101183:	83 c8 20             	or     $0x20,%eax
  101186:	89 c6                	mov    %eax,%esi
  101188:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10118c:	48 8b 40 08          	mov    0x8(%rax),%rax
  101190:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101194:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101198:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10119c:	89 f2                	mov    %esi,%edx
  10119e:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1011a1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1011a5:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1011a9:	75 d5                	jne    101180 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1011ab:	eb 24                	jmp    1011d1 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  1011ad:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1011b1:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1011b4:	89 d6                	mov    %edx,%esi
  1011b6:	09 c6                	or     %eax,%esi
  1011b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011bc:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011c0:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1011c4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1011c8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011cc:	89 f2                	mov    %esi,%edx
  1011ce:	66 89 10             	mov    %dx,(%rax)
}
  1011d1:	90                   	nop
  1011d2:	c9                   	leave  
  1011d3:	c3                   	ret    

00000000001011d4 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1011d4:	f3 0f 1e fa          	endbr64 
  1011d8:	55                   	push   %rbp
  1011d9:	48 89 e5             	mov    %rsp,%rbp
  1011dc:	48 83 ec 30          	sub    $0x30,%rsp
  1011e0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1011e3:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1011e6:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1011ea:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1011ee:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 1010de <console_putc>
  1011f5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1011f9:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1011fd:	78 09                	js     101208 <console_vprintf+0x34>
  1011ff:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101206:	7e 07                	jle    10120f <console_vprintf+0x3b>
        cpos = 0;
  101208:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10120f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101212:	48 98                	cltq   
  101214:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101218:	48 8d 05 e1 6d fb ff 	lea    -0x4921f(%rip),%rax        # b8000 <console>
  10121f:	48 01 d0             	add    %rdx,%rax
  101222:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101226:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10122a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10122e:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101231:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101235:	48 89 c7             	mov    %rax,%rdi
  101238:	e8 9a f4 ff ff       	call   1006d7 <printer_vprintf>
    return cp.cursor - console;
  10123d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101241:	48 8d 15 b8 6d fb ff 	lea    -0x49248(%rip),%rdx        # b8000 <console>
  101248:	48 29 d0             	sub    %rdx,%rax
  10124b:	48 d1 f8             	sar    %rax
}
  10124e:	c9                   	leave  
  10124f:	c3                   	ret    

0000000000101250 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101250:	f3 0f 1e fa          	endbr64 
  101254:	55                   	push   %rbp
  101255:	48 89 e5             	mov    %rsp,%rbp
  101258:	48 83 ec 60          	sub    $0x60,%rsp
  10125c:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10125f:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101262:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101266:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10126a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10126e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101272:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101279:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10127d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101281:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101285:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101289:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10128d:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101291:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101294:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101297:	89 c7                	mov    %eax,%edi
  101299:	e8 36 ff ff ff       	call   1011d4 <console_vprintf>
  10129e:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1012a1:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1012a4:	c9                   	leave  
  1012a5:	c3                   	ret    

00000000001012a6 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1012a6:	f3 0f 1e fa          	endbr64 
  1012aa:	55                   	push   %rbp
  1012ab:	48 89 e5             	mov    %rsp,%rbp
  1012ae:	48 83 ec 20          	sub    $0x20,%rsp
  1012b2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1012b6:	89 f0                	mov    %esi,%eax
  1012b8:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1012bb:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1012be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1012c2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1012c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012ca:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1012ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012d2:	48 8b 40 10          	mov    0x10(%rax),%rax
  1012d6:	48 39 c2             	cmp    %rax,%rdx
  1012d9:	73 1a                	jae    1012f5 <string_putc+0x4f>
        *sp->s++ = c;
  1012db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012df:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012e3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1012e7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1012eb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012ef:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1012f3:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1012f5:	90                   	nop
  1012f6:	c9                   	leave  
  1012f7:	c3                   	ret    

00000000001012f8 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1012f8:	f3 0f 1e fa          	endbr64 
  1012fc:	55                   	push   %rbp
  1012fd:	48 89 e5             	mov    %rsp,%rbp
  101300:	48 83 ec 40          	sub    $0x40,%rsp
  101304:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101308:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10130c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101310:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101314:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 1012a6 <string_putc>
  10131b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  10131f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101323:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101327:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  10132c:	74 33                	je     101361 <vsnprintf+0x69>
        sp.end = s + size - 1;
  10132e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101332:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101336:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10133a:	48 01 d0             	add    %rdx,%rax
  10133d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101341:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101345:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101349:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  10134d:	be 00 00 00 00       	mov    $0x0,%esi
  101352:	48 89 c7             	mov    %rax,%rdi
  101355:	e8 7d f3 ff ff       	call   1006d7 <printer_vprintf>
        *sp.s = 0;
  10135a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10135e:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101361:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101365:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101369:	c9                   	leave  
  10136a:	c3                   	ret    

000000000010136b <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  10136b:	f3 0f 1e fa          	endbr64 
  10136f:	55                   	push   %rbp
  101370:	48 89 e5             	mov    %rsp,%rbp
  101373:	48 83 ec 70          	sub    $0x70,%rsp
  101377:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  10137b:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10137f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101383:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101387:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10138b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10138f:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101396:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10139a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10139e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1013a2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1013a6:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1013aa:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1013ae:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1013b2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1013b6:	48 89 c7             	mov    %rax,%rdi
  1013b9:	e8 3a ff ff ff       	call   1012f8 <vsnprintf>
  1013be:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1013c1:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1013c4:	c9                   	leave  
  1013c5:	c3                   	ret    

00000000001013c6 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1013c6:	f3 0f 1e fa          	endbr64 
  1013ca:	55                   	push   %rbp
  1013cb:	48 89 e5             	mov    %rsp,%rbp
  1013ce:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1013d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1013d9:	eb 1a                	jmp    1013f5 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  1013db:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1013de:	48 98                	cltq   
  1013e0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1013e4:	48 8d 05 15 6c fb ff 	lea    -0x493eb(%rip),%rax        # b8000 <console>
  1013eb:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1013f1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1013f5:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1013fc:	7e dd                	jle    1013db <console_clear+0x15>
    }
    cursorpos = 0;
  1013fe:	c7 05 f4 7b fb ff 00 	movl   $0x0,-0x4840c(%rip)        # b8ffc <cursorpos>
  101405:	00 00 00 
}
  101408:	90                   	nop
  101409:	c9                   	leave  
  10140a:	c3                   	ret    
