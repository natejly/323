
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <write_page>:

#define CANARY 0xDEADBEEF
#define MULT   0x000B0000

// write to entire page with `value`
void write_page(uint8_t *addr, uint32_t value){
  100000:	f3 0f 1e fa          	endbr64 
    uint32_t * int_addr = (uint32_t *) addr;
    for(unsigned long i = 0 ; i < PAGESIZE/sizeof(uint32_t) ; i++){
  100004:	48 89 f8             	mov    %rdi,%rax
  100007:	48 8d 97 00 10 00 00 	lea    0x1000(%rdi),%rdx
        int_addr[i] = value;
  10000e:	89 30                	mov    %esi,(%rax)
    for(unsigned long i = 0 ; i < PAGESIZE/sizeof(uint32_t) ; i++){
  100010:	48 83 c0 04          	add    $0x4,%rax
  100014:	48 39 d0             	cmp    %rdx,%rax
  100017:	75 f5                	jne    10000e <write_page+0xe>
    }
}
  100019:	c3                   	ret    

000000000010001a <assert_page>:

// check if enter page contains `value`
void assert_page(uint8_t * addr, uint32_t value){
  10001a:	f3 0f 1e fa          	endbr64 
    uint32_t * int_addr = (uint32_t *) addr;
    for(unsigned long i = 0 ; i < PAGESIZE/sizeof(uint32_t) ; i++){
  10001e:	48 89 f8             	mov    %rdi,%rax
  100021:	48 8d 97 00 10 00 00 	lea    0x1000(%rdi),%rdx
        assert(int_addr[i] == value && "Error: page was corrupted!");
  100028:	39 30                	cmp    %esi,(%rax)
  10002a:	75 0a                	jne    100036 <assert_page+0x1c>
    for(unsigned long i = 0 ; i < PAGESIZE/sizeof(uint32_t) ; i++){
  10002c:	48 83 c0 04          	add    $0x4,%rax
  100030:	48 39 d0             	cmp    %rdx,%rax
  100033:	75 f3                	jne    100028 <assert_page+0xe>
  100035:	c3                   	ret    
void assert_page(uint8_t * addr, uint32_t value){
  100036:	55                   	push   %rbp
  100037:	48 89 e5             	mov    %rsp,%rbp
        assert(int_addr[i] == value && "Error: page was corrupted!");
  10003a:	48 8d 15 9f 13 00 00 	lea    0x139f(%rip),%rdx        # 1013e0 <console_clear+0x4c>
  100041:	be 1a 00 00 00       	mov    $0x1a,%esi
  100046:	48 8d 3d c8 13 00 00 	lea    0x13c8(%rip),%rdi        # 101415 <console_clear+0x81>
  10004d:	e8 52 02 00 00       	call   1002a4 <assert_fail>

0000000000100052 <process_main>:
}

// Behaves similar to p-allocator.c, except it writes to the entire page
// and checks if the memory was untouched

void process_main(void) {
  100052:	f3 0f 1e fa          	endbr64 
  100056:	55                   	push   %rbp
  100057:	48 89 e5             	mov    %rsp,%rbp
  10005a:	41 55                	push   %r13
  10005c:	41 54                	push   %r12
  10005e:	53                   	push   %rbx
  10005f:	48 83 ec 08          	sub    $0x8,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100063:	cd 31                	int    $0x31
  100065:	41 89 c4             	mov    %eax,%r12d
    pid_t p = sys_getpid();
    srand(p);
  100068:	89 c7                	mov    %eax,%edi
  10006a:	e8 85 05 00 00       	call   1005f4 <srand>

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10006f:	48 8d 1d a1 2f 00 00 	lea    0x2fa1(%rip),%rbx        # 103017 <end+0xfff>
  100076:	48 81 e3 00 f0 ff ff 	and    $0xfffffffffffff000,%rbx
  10007d:	48 89 1d 84 1f 00 00 	mov    %rbx,0x1f84(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100084:	48 89 e0             	mov    %rsp,%rax
    uint8_t * heap_end = heap_top;

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100087:	48 83 e8 01          	sub    $0x1,%rax
  10008b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100091:	48 89 05 68 1f 00 00 	mov    %rax,0x1f68(%rip)        # 102000 <stack_bottom>
        if ((rand() % ALLOC_SLOWDOWN) < p) {
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
                break;
            }
            // write with random canary and process ID based unique value to check later
            write_page(heap_top, CANARY + p * MULT); 
  100098:	45 69 ec 00 00 0b 00 	imul   $0xb0000,%r12d,%r13d
  10009f:	41 81 ed 11 41 52 21 	sub    $0x21524111,%r13d
  1000a6:	eb 37                	jmp    1000df <process_main+0x8d>
            heap_top += PAGESIZE;
        }
        sys_yield();
    }
    //check all addresses so far
    while(heap_end < heap_top){
  1000a8:	4c 8b 2d 59 1f 00 00 	mov    0x1f59(%rip),%r13        # 102008 <heap_top>
  1000af:	4c 39 eb             	cmp    %r13,%rbx
  1000b2:	73 25                	jae    1000d9 <process_main+0x87>
        // for all alloc'd pages, check if page still contains same value
        assert_page(heap_end, CANARY + p * MULT);
  1000b4:	45 69 e4 00 00 0b 00 	imul   $0xb0000,%r12d,%r12d
  1000bb:	41 81 ec 11 41 52 21 	sub    $0x21524111,%r12d
  1000c2:	44 89 e6             	mov    %r12d,%esi
  1000c5:	48 89 df             	mov    %rbx,%rdi
  1000c8:	e8 4d ff ff ff       	call   10001a <assert_page>
        heap_end += PAGESIZE;
  1000cd:	48 81 c3 00 10 00 00 	add    $0x1000,%rbx
    while(heap_end < heap_top){
  1000d4:	4c 39 eb             	cmp    %r13,%rbx
  1000d7:	72 e9                	jb     1000c2 <process_main+0x70>

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  1000d9:	cd 32                	int    $0x32
  1000db:	eb fc                	jmp    1000d9 <process_main+0x87>
  1000dd:	cd 32                	int    $0x32
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  1000df:	e8 d0 04 00 00       	call   1005b4 <rand>
  1000e4:	48 63 d0             	movslq %eax,%rdx
  1000e7:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  1000ee:	48 c1 fa 25          	sar    $0x25,%rdx
  1000f2:	89 c1                	mov    %eax,%ecx
  1000f4:	c1 f9 1f             	sar    $0x1f,%ecx
  1000f7:	29 ca                	sub    %ecx,%edx
  1000f9:	6b d2 64             	imul   $0x64,%edx,%edx
  1000fc:	29 d0                	sub    %edx,%eax
  1000fe:	44 39 e0             	cmp    %r12d,%eax
  100101:	7d da                	jge    1000dd <process_main+0x8b>
            if (heap_top == stack_bottom || sys_page_alloc(heap_top) < 0) {
  100103:	48 8b 3d fe 1e 00 00 	mov    0x1efe(%rip),%rdi        # 102008 <heap_top>
  10010a:	48 3b 3d ef 1e 00 00 	cmp    0x1eef(%rip),%rdi        # 102000 <stack_bottom>
  100111:	74 95                	je     1000a8 <process_main+0x56>
//    Allocate a page of memory at address `addr` and allow process to
//    write to it. `Addr` must be page-aligned (i.e., a multiple of
//    PAGESIZE == 4096). Returns 0 on success and -1 on failure.
static inline int sys_page_alloc(void* addr) {
    int result;
    asm volatile ("int %1" : "=a" (result)
  100113:	cd 33                	int    $0x33
  100115:	85 c0                	test   %eax,%eax
  100117:	78 8f                	js     1000a8 <process_main+0x56>
            write_page(heap_top, CANARY + p * MULT); 
  100119:	44 89 ee             	mov    %r13d,%esi
  10011c:	48 8b 3d e5 1e 00 00 	mov    0x1ee5(%rip),%rdi        # 102008 <heap_top>
  100123:	e8 d8 fe ff ff       	call   100000 <write_page>
            heap_top += PAGESIZE;
  100128:	48 81 05 d5 1e 00 00 	addq   $0x1000,0x1ed5(%rip)        # 102008 <heap_top>
  10012f:	00 10 00 00 
  100133:	eb a8                	jmp    1000dd <process_main+0x8b>

0000000000100135 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100135:	f3 0f 1e fa          	endbr64 
  100139:	55                   	push   %rbp
  10013a:	48 89 e5             	mov    %rsp,%rbp
  10013d:	48 83 ec 50          	sub    $0x50,%rsp
  100141:	49 89 f2             	mov    %rsi,%r10
  100144:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100148:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10014c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100150:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100154:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100159:	85 ff                	test   %edi,%edi
  10015b:	78 32                	js     10018f <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  10015d:	48 63 ff             	movslq %edi,%rdi
  100160:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100167:	cc cc cc 
  10016a:	48 89 f8             	mov    %rdi,%rax
  10016d:	48 f7 e2             	mul    %rdx
  100170:	48 89 d0             	mov    %rdx,%rax
  100173:	48 c1 e8 02          	shr    $0x2,%rax
  100177:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  10017b:	48 01 c2             	add    %rax,%rdx
  10017e:	48 29 d7             	sub    %rdx,%rdi
  100181:	48 8d 05 d5 12 00 00 	lea    0x12d5(%rip),%rax        # 10145d <col.0>
  100188:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  10018c:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  10018f:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100196:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10019a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10019e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1001a2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1001a6:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1001aa:	4c 89 d2             	mov    %r10,%rdx
  1001ad:	8b 3d 49 8e fb ff    	mov    -0x471b7(%rip),%edi        # b8ffc <cursorpos>
  1001b3:	e8 ea 0f 00 00       	call   1011a2 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1001b8:	3d 30 07 00 00       	cmp    $0x730,%eax
  1001bd:	ba 00 00 00 00       	mov    $0x0,%edx
  1001c2:	0f 4d c2             	cmovge %edx,%eax
  1001c5:	89 05 31 8e fb ff    	mov    %eax,-0x471cf(%rip)        # b8ffc <cursorpos>
    }
}
  1001cb:	c9                   	leave  
  1001cc:	c3                   	ret    

00000000001001cd <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  1001cd:	f3 0f 1e fa          	endbr64 
  1001d1:	55                   	push   %rbp
  1001d2:	48 89 e5             	mov    %rsp,%rbp
  1001d5:	53                   	push   %rbx
  1001d6:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  1001dd:	48 89 fb             	mov    %rdi,%rbx
  1001e0:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  1001e4:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  1001e8:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  1001ec:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  1001f0:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  1001f4:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1001fb:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001ff:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100203:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100207:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  10020b:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100212:	ba 07 00 00 00       	mov    $0x7,%edx
  100217:	48 8d 35 07 12 00 00 	lea    0x1207(%rip),%rsi        # 101425 <console_clear+0x91>
  10021e:	e8 b6 00 00 00       	call   1002d9 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100223:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100227:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  10022e:	48 89 da             	mov    %rbx,%rdx
  100231:	be 99 00 00 00       	mov    $0x99,%esi
  100236:	e8 8b 10 00 00       	call   1012c6 <vsnprintf>
  10023b:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  10023e:	85 d2                	test   %edx,%edx
  100240:	7e 0f                	jle    100251 <panic+0x84>
  100242:	83 c0 06             	add    $0x6,%eax
  100245:	48 98                	cltq   
  100247:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  10024e:	0a 
  10024f:	75 2b                	jne    10027c <panic+0xaf>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100251:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  100258:	48 8d 15 d0 11 00 00 	lea    0x11d0(%rip),%rdx        # 10142f <console_clear+0x9b>
  10025f:	be 00 c0 00 00       	mov    $0xc000,%esi
  100264:	bf 30 07 00 00       	mov    $0x730,%edi
  100269:	b8 00 00 00 00       	mov    $0x0,%eax
  10026e:	e8 ab 0f 00 00       	call   10121e <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100273:	bf 00 00 00 00       	mov    $0x0,%edi
  100278:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  10027a:	eb fe                	jmp    10027a <panic+0xad>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  10027c:	48 63 c2             	movslq %edx,%rax
  10027f:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100285:	0f 94 c2             	sete   %dl
  100288:	0f b6 d2             	movzbl %dl,%edx
  10028b:	48 29 d0             	sub    %rdx,%rax
  10028e:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100295:	ff 
  100296:	48 8d 35 90 11 00 00 	lea    0x1190(%rip),%rsi        # 10142d <console_clear+0x99>
  10029d:	e8 f8 01 00 00       	call   10049a <strcpy>
  1002a2:	eb ad                	jmp    100251 <panic+0x84>

00000000001002a4 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1002a4:	f3 0f 1e fa          	endbr64 
  1002a8:	55                   	push   %rbp
  1002a9:	48 89 e5             	mov    %rsp,%rbp
  1002ac:	48 89 f9             	mov    %rdi,%rcx
  1002af:	41 89 f0             	mov    %esi,%r8d
  1002b2:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1002b5:	48 8d 15 7c 11 00 00 	lea    0x117c(%rip),%rdx        # 101438 <console_clear+0xa4>
  1002bc:	be 00 c0 00 00       	mov    $0xc000,%esi
  1002c1:	bf 30 07 00 00       	mov    $0x730,%edi
  1002c6:	b8 00 00 00 00       	mov    $0x0,%eax
  1002cb:	e8 4e 0f 00 00       	call   10121e <console_printf>
    asm volatile ("int %0" : /* no result */
  1002d0:	bf 00 00 00 00       	mov    $0x0,%edi
  1002d5:	cd 30                	int    $0x30
 loop: goto loop;
  1002d7:	eb fe                	jmp    1002d7 <assert_fail+0x33>

00000000001002d9 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1002d9:	f3 0f 1e fa          	endbr64 
  1002dd:	55                   	push   %rbp
  1002de:	48 89 e5             	mov    %rsp,%rbp
  1002e1:	48 83 ec 28          	sub    $0x28,%rsp
  1002e5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002e9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1002ed:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002f1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002f5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002fd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100301:	eb 1c                	jmp    10031f <memcpy+0x46>
        *d = *s;
  100303:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100307:	0f b6 10             	movzbl (%rax),%edx
  10030a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10030e:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100310:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100315:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10031a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  10031f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100324:	75 dd                	jne    100303 <memcpy+0x2a>
    }
    return dst;
  100326:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10032a:	c9                   	leave  
  10032b:	c3                   	ret    

000000000010032c <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  10032c:	f3 0f 1e fa          	endbr64 
  100330:	55                   	push   %rbp
  100331:	48 89 e5             	mov    %rsp,%rbp
  100334:	48 83 ec 28          	sub    $0x28,%rsp
  100338:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10033c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100340:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100344:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100348:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10034c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100350:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100354:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100358:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10035c:	73 6a                	jae    1003c8 <memmove+0x9c>
  10035e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100362:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100366:	48 01 d0             	add    %rdx,%rax
  100369:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  10036d:	73 59                	jae    1003c8 <memmove+0x9c>
        s += n, d += n;
  10036f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100373:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100377:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10037b:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  10037f:	eb 17                	jmp    100398 <memmove+0x6c>
            *--d = *--s;
  100381:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100386:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  10038b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10038f:	0f b6 10             	movzbl (%rax),%edx
  100392:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100396:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100398:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10039c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003a0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003a4:	48 85 c0             	test   %rax,%rax
  1003a7:	75 d8                	jne    100381 <memmove+0x55>
    if (s < d && s + n > d) {
  1003a9:	eb 2e                	jmp    1003d9 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1003ab:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1003af:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003bb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003bf:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1003c3:	0f b6 12             	movzbl (%rdx),%edx
  1003c6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003cc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003d0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003d4:	48 85 c0             	test   %rax,%rax
  1003d7:	75 d2                	jne    1003ab <memmove+0x7f>
        }
    }
    return dst;
  1003d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003dd:	c9                   	leave  
  1003de:	c3                   	ret    

00000000001003df <memset>:

void* memset(void* v, int c, size_t n) {
  1003df:	f3 0f 1e fa          	endbr64 
  1003e3:	55                   	push   %rbp
  1003e4:	48 89 e5             	mov    %rsp,%rbp
  1003e7:	48 83 ec 28          	sub    $0x28,%rsp
  1003eb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003ef:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1003f2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003fa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003fe:	eb 15                	jmp    100415 <memset+0x36>
        *p = c;
  100400:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100403:	89 c2                	mov    %eax,%edx
  100405:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100409:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10040b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100410:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100415:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10041a:	75 e4                	jne    100400 <memset+0x21>
    }
    return v;
  10041c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100420:	c9                   	leave  
  100421:	c3                   	ret    

0000000000100422 <strlen>:

size_t strlen(const char* s) {
  100422:	f3 0f 1e fa          	endbr64 
  100426:	55                   	push   %rbp
  100427:	48 89 e5             	mov    %rsp,%rbp
  10042a:	48 83 ec 18          	sub    $0x18,%rsp
  10042e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100432:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100439:	00 
  10043a:	eb 0a                	jmp    100446 <strlen+0x24>
        ++n;
  10043c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100441:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100446:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10044a:	0f b6 00             	movzbl (%rax),%eax
  10044d:	84 c0                	test   %al,%al
  10044f:	75 eb                	jne    10043c <strlen+0x1a>
    }
    return n;
  100451:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100455:	c9                   	leave  
  100456:	c3                   	ret    

0000000000100457 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100457:	f3 0f 1e fa          	endbr64 
  10045b:	55                   	push   %rbp
  10045c:	48 89 e5             	mov    %rsp,%rbp
  10045f:	48 83 ec 20          	sub    $0x20,%rsp
  100463:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100467:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10046b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100472:	00 
  100473:	eb 0a                	jmp    10047f <strnlen+0x28>
        ++n;
  100475:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10047a:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10047f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100483:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100487:	74 0b                	je     100494 <strnlen+0x3d>
  100489:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10048d:	0f b6 00             	movzbl (%rax),%eax
  100490:	84 c0                	test   %al,%al
  100492:	75 e1                	jne    100475 <strnlen+0x1e>
    }
    return n;
  100494:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100498:	c9                   	leave  
  100499:	c3                   	ret    

000000000010049a <strcpy>:

char* strcpy(char* dst, const char* src) {
  10049a:	f3 0f 1e fa          	endbr64 
  10049e:	55                   	push   %rbp
  10049f:	48 89 e5             	mov    %rsp,%rbp
  1004a2:	48 83 ec 20          	sub    $0x20,%rsp
  1004a6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004aa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1004ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004b2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1004b6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1004ba:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004be:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1004c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004c6:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004ca:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1004ce:	0f b6 12             	movzbl (%rdx),%edx
  1004d1:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1004d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004d7:	48 83 e8 01          	sub    $0x1,%rax
  1004db:	0f b6 00             	movzbl (%rax),%eax
  1004de:	84 c0                	test   %al,%al
  1004e0:	75 d4                	jne    1004b6 <strcpy+0x1c>
    return dst;
  1004e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1004e6:	c9                   	leave  
  1004e7:	c3                   	ret    

00000000001004e8 <strcmp>:

int strcmp(const char* a, const char* b) {
  1004e8:	f3 0f 1e fa          	endbr64 
  1004ec:	55                   	push   %rbp
  1004ed:	48 89 e5             	mov    %rsp,%rbp
  1004f0:	48 83 ec 10          	sub    $0x10,%rsp
  1004f4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004f8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004fc:	eb 0a                	jmp    100508 <strcmp+0x20>
        ++a, ++b;
  1004fe:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100503:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100508:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10050c:	0f b6 00             	movzbl (%rax),%eax
  10050f:	84 c0                	test   %al,%al
  100511:	74 1d                	je     100530 <strcmp+0x48>
  100513:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100517:	0f b6 00             	movzbl (%rax),%eax
  10051a:	84 c0                	test   %al,%al
  10051c:	74 12                	je     100530 <strcmp+0x48>
  10051e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100522:	0f b6 10             	movzbl (%rax),%edx
  100525:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100529:	0f b6 00             	movzbl (%rax),%eax
  10052c:	38 c2                	cmp    %al,%dl
  10052e:	74 ce                	je     1004fe <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100530:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100534:	0f b6 00             	movzbl (%rax),%eax
  100537:	89 c2                	mov    %eax,%edx
  100539:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10053d:	0f b6 00             	movzbl (%rax),%eax
  100540:	38 c2                	cmp    %al,%dl
  100542:	0f 97 c0             	seta   %al
  100545:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100548:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10054c:	0f b6 00             	movzbl (%rax),%eax
  10054f:	89 c1                	mov    %eax,%ecx
  100551:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100555:	0f b6 00             	movzbl (%rax),%eax
  100558:	38 c1                	cmp    %al,%cl
  10055a:	0f 92 c0             	setb   %al
  10055d:	0f b6 c8             	movzbl %al,%ecx
  100560:	89 d0                	mov    %edx,%eax
  100562:	29 c8                	sub    %ecx,%eax
}
  100564:	c9                   	leave  
  100565:	c3                   	ret    

0000000000100566 <strchr>:

char* strchr(const char* s, int c) {
  100566:	f3 0f 1e fa          	endbr64 
  10056a:	55                   	push   %rbp
  10056b:	48 89 e5             	mov    %rsp,%rbp
  10056e:	48 83 ec 10          	sub    $0x10,%rsp
  100572:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100576:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100579:	eb 05                	jmp    100580 <strchr+0x1a>
        ++s;
  10057b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100580:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100584:	0f b6 00             	movzbl (%rax),%eax
  100587:	84 c0                	test   %al,%al
  100589:	74 0e                	je     100599 <strchr+0x33>
  10058b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10058f:	0f b6 00             	movzbl (%rax),%eax
  100592:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100595:	38 d0                	cmp    %dl,%al
  100597:	75 e2                	jne    10057b <strchr+0x15>
    }
    if (*s == (char) c) {
  100599:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10059d:	0f b6 00             	movzbl (%rax),%eax
  1005a0:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1005a3:	38 d0                	cmp    %dl,%al
  1005a5:	75 06                	jne    1005ad <strchr+0x47>
        return (char*) s;
  1005a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005ab:	eb 05                	jmp    1005b2 <strchr+0x4c>
    } else {
        return NULL;
  1005ad:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1005b2:	c9                   	leave  
  1005b3:	c3                   	ret    

00000000001005b4 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1005b4:	f3 0f 1e fa          	endbr64 
  1005b8:	55                   	push   %rbp
  1005b9:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1005bc:	8b 05 4e 1a 00 00    	mov    0x1a4e(%rip),%eax        # 102010 <rand_seed_set>
  1005c2:	85 c0                	test   %eax,%eax
  1005c4:	75 0a                	jne    1005d0 <rand+0x1c>
        srand(819234718U);
  1005c6:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1005cb:	e8 24 00 00 00       	call   1005f4 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1005d0:	8b 05 3e 1a 00 00    	mov    0x1a3e(%rip),%eax        # 102014 <rand_seed>
  1005d6:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1005dc:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1005e1:	89 05 2d 1a 00 00    	mov    %eax,0x1a2d(%rip)        # 102014 <rand_seed>
    return rand_seed & RAND_MAX;
  1005e7:	8b 05 27 1a 00 00    	mov    0x1a27(%rip),%eax        # 102014 <rand_seed>
  1005ed:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1005f2:	5d                   	pop    %rbp
  1005f3:	c3                   	ret    

00000000001005f4 <srand>:

void srand(unsigned seed) {
  1005f4:	f3 0f 1e fa          	endbr64 
  1005f8:	55                   	push   %rbp
  1005f9:	48 89 e5             	mov    %rsp,%rbp
  1005fc:	48 83 ec 08          	sub    $0x8,%rsp
  100600:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100603:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100606:	89 05 08 1a 00 00    	mov    %eax,0x1a08(%rip)        # 102014 <rand_seed>
    rand_seed_set = 1;
  10060c:	c7 05 fa 19 00 00 01 	movl   $0x1,0x19fa(%rip)        # 102010 <rand_seed_set>
  100613:	00 00 00 
}
  100616:	90                   	nop
  100617:	c9                   	leave  
  100618:	c3                   	ret    

0000000000100619 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100619:	f3 0f 1e fa          	endbr64 
  10061d:	55                   	push   %rbp
  10061e:	48 89 e5             	mov    %rsp,%rbp
  100621:	48 83 ec 28          	sub    $0x28,%rsp
  100625:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100629:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10062d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100630:	48 8d 05 39 0f 00 00 	lea    0xf39(%rip),%rax        # 101570 <upper_digits.1>
  100637:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  10063b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10063f:	79 0e                	jns    10064f <fill_numbuf+0x36>
        digits = lower_digits;
  100641:	48 8d 05 48 0f 00 00 	lea    0xf48(%rip),%rax        # 101590 <lower_digits.0>
  100648:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  10064c:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  10064f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100654:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100658:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  10065b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10065e:	48 63 c8             	movslq %eax,%rcx
  100661:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100665:	ba 00 00 00 00       	mov    $0x0,%edx
  10066a:	48 f7 f1             	div    %rcx
  10066d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100671:	48 01 d0             	add    %rdx,%rax
  100674:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100679:	0f b6 10             	movzbl (%rax),%edx
  10067c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100680:	88 10                	mov    %dl,(%rax)
        val /= base;
  100682:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100685:	48 63 f0             	movslq %eax,%rsi
  100688:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10068c:	ba 00 00 00 00       	mov    $0x0,%edx
  100691:	48 f7 f6             	div    %rsi
  100694:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100698:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  10069d:	75 bc                	jne    10065b <fill_numbuf+0x42>
    return numbuf_end;
  10069f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1006a3:	c9                   	leave  
  1006a4:	c3                   	ret    

00000000001006a5 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1006a5:	f3 0f 1e fa          	endbr64 
  1006a9:	55                   	push   %rbp
  1006aa:	48 89 e5             	mov    %rsp,%rbp
  1006ad:	53                   	push   %rbx
  1006ae:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1006b5:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1006bc:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1006c2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1006c9:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1006d0:	e9 bd 09 00 00       	jmp    101092 <printer_vprintf+0x9ed>
        if (*format != '%') {
  1006d5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006dc:	0f b6 00             	movzbl (%rax),%eax
  1006df:	3c 25                	cmp    $0x25,%al
  1006e1:	74 31                	je     100714 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  1006e3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006ea:	4c 8b 00             	mov    (%rax),%r8
  1006ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006f4:	0f b6 00             	movzbl (%rax),%eax
  1006f7:	0f b6 c8             	movzbl %al,%ecx
  1006fa:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100700:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100707:	89 ce                	mov    %ecx,%esi
  100709:	48 89 c7             	mov    %rax,%rdi
  10070c:	41 ff d0             	call   *%r8
            continue;
  10070f:	e9 76 09 00 00       	jmp    10108a <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  100714:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  10071b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100722:	01 
  100723:	eb 4d                	jmp    100772 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  100725:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10072c:	0f b6 00             	movzbl (%rax),%eax
  10072f:	0f be c0             	movsbl %al,%eax
  100732:	89 c6                	mov    %eax,%esi
  100734:	48 8d 05 35 0d 00 00 	lea    0xd35(%rip),%rax        # 101470 <flag_chars>
  10073b:	48 89 c7             	mov    %rax,%rdi
  10073e:	e8 23 fe ff ff       	call   100566 <strchr>
  100743:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100747:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10074c:	74 34                	je     100782 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  10074e:	48 8d 15 1b 0d 00 00 	lea    0xd1b(%rip),%rdx        # 101470 <flag_chars>
  100755:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100759:	48 29 d0             	sub    %rdx,%rax
  10075c:	ba 01 00 00 00       	mov    $0x1,%edx
  100761:	89 c1                	mov    %eax,%ecx
  100763:	d3 e2                	shl    %cl,%edx
  100765:	89 d0                	mov    %edx,%eax
  100767:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  10076a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100771:	01 
  100772:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100779:	0f b6 00             	movzbl (%rax),%eax
  10077c:	84 c0                	test   %al,%al
  10077e:	75 a5                	jne    100725 <printer_vprintf+0x80>
  100780:	eb 01                	jmp    100783 <printer_vprintf+0xde>
            } else {
                break;
  100782:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100783:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  10078a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100791:	0f b6 00             	movzbl (%rax),%eax
  100794:	3c 30                	cmp    $0x30,%al
  100796:	7e 67                	jle    1007ff <printer_vprintf+0x15a>
  100798:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10079f:	0f b6 00             	movzbl (%rax),%eax
  1007a2:	3c 39                	cmp    $0x39,%al
  1007a4:	7f 59                	jg     1007ff <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1007a6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1007ad:	eb 2e                	jmp    1007dd <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  1007af:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1007b2:	89 d0                	mov    %edx,%eax
  1007b4:	c1 e0 02             	shl    $0x2,%eax
  1007b7:	01 d0                	add    %edx,%eax
  1007b9:	01 c0                	add    %eax,%eax
  1007bb:	89 c1                	mov    %eax,%ecx
  1007bd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007c4:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1007c8:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007cf:	0f b6 00             	movzbl (%rax),%eax
  1007d2:	0f be c0             	movsbl %al,%eax
  1007d5:	01 c8                	add    %ecx,%eax
  1007d7:	83 e8 30             	sub    $0x30,%eax
  1007da:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1007dd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007e4:	0f b6 00             	movzbl (%rax),%eax
  1007e7:	3c 2f                	cmp    $0x2f,%al
  1007e9:	0f 8e 85 00 00 00    	jle    100874 <printer_vprintf+0x1cf>
  1007ef:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007f6:	0f b6 00             	movzbl (%rax),%eax
  1007f9:	3c 39                	cmp    $0x39,%al
  1007fb:	7e b2                	jle    1007af <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  1007fd:	eb 75                	jmp    100874 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  1007ff:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100806:	0f b6 00             	movzbl (%rax),%eax
  100809:	3c 2a                	cmp    $0x2a,%al
  10080b:	75 68                	jne    100875 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  10080d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100814:	8b 00                	mov    (%rax),%eax
  100816:	83 f8 2f             	cmp    $0x2f,%eax
  100819:	77 30                	ja     10084b <printer_vprintf+0x1a6>
  10081b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100822:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100826:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10082d:	8b 00                	mov    (%rax),%eax
  10082f:	89 c0                	mov    %eax,%eax
  100831:	48 01 d0             	add    %rdx,%rax
  100834:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10083b:	8b 12                	mov    (%rdx),%edx
  10083d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100840:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100847:	89 0a                	mov    %ecx,(%rdx)
  100849:	eb 1a                	jmp    100865 <printer_vprintf+0x1c0>
  10084b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100852:	48 8b 40 08          	mov    0x8(%rax),%rax
  100856:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10085a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100861:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100865:	8b 00                	mov    (%rax),%eax
  100867:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  10086a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100871:	01 
  100872:	eb 01                	jmp    100875 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  100874:	90                   	nop
        }

        // process precision
        int precision = -1;
  100875:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  10087c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100883:	0f b6 00             	movzbl (%rax),%eax
  100886:	3c 2e                	cmp    $0x2e,%al
  100888:	0f 85 00 01 00 00    	jne    10098e <printer_vprintf+0x2e9>
            ++format;
  10088e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100895:	01 
            if (*format >= '0' && *format <= '9') {
  100896:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10089d:	0f b6 00             	movzbl (%rax),%eax
  1008a0:	3c 2f                	cmp    $0x2f,%al
  1008a2:	7e 67                	jle    10090b <printer_vprintf+0x266>
  1008a4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008ab:	0f b6 00             	movzbl (%rax),%eax
  1008ae:	3c 39                	cmp    $0x39,%al
  1008b0:	7f 59                	jg     10090b <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008b2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1008b9:	eb 2e                	jmp    1008e9 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  1008bb:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1008be:	89 d0                	mov    %edx,%eax
  1008c0:	c1 e0 02             	shl    $0x2,%eax
  1008c3:	01 d0                	add    %edx,%eax
  1008c5:	01 c0                	add    %eax,%eax
  1008c7:	89 c1                	mov    %eax,%ecx
  1008c9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008d0:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1008d4:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008db:	0f b6 00             	movzbl (%rax),%eax
  1008de:	0f be c0             	movsbl %al,%eax
  1008e1:	01 c8                	add    %ecx,%eax
  1008e3:	83 e8 30             	sub    $0x30,%eax
  1008e6:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008e9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008f0:	0f b6 00             	movzbl (%rax),%eax
  1008f3:	3c 2f                	cmp    $0x2f,%al
  1008f5:	0f 8e 85 00 00 00    	jle    100980 <printer_vprintf+0x2db>
  1008fb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100902:	0f b6 00             	movzbl (%rax),%eax
  100905:	3c 39                	cmp    $0x39,%al
  100907:	7e b2                	jle    1008bb <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  100909:	eb 75                	jmp    100980 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  10090b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100912:	0f b6 00             	movzbl (%rax),%eax
  100915:	3c 2a                	cmp    $0x2a,%al
  100917:	75 68                	jne    100981 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  100919:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100920:	8b 00                	mov    (%rax),%eax
  100922:	83 f8 2f             	cmp    $0x2f,%eax
  100925:	77 30                	ja     100957 <printer_vprintf+0x2b2>
  100927:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10092e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100932:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100939:	8b 00                	mov    (%rax),%eax
  10093b:	89 c0                	mov    %eax,%eax
  10093d:	48 01 d0             	add    %rdx,%rax
  100940:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100947:	8b 12                	mov    (%rdx),%edx
  100949:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10094c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100953:	89 0a                	mov    %ecx,(%rdx)
  100955:	eb 1a                	jmp    100971 <printer_vprintf+0x2cc>
  100957:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10095e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100962:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100966:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10096d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100971:	8b 00                	mov    (%rax),%eax
  100973:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100976:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10097d:	01 
  10097e:	eb 01                	jmp    100981 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  100980:	90                   	nop
            }
            if (precision < 0) {
  100981:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100985:	79 07                	jns    10098e <printer_vprintf+0x2e9>
                precision = 0;
  100987:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  10098e:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100995:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  10099c:	00 
        int length = 0;
  10099d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  1009a4:	48 8d 05 cb 0a 00 00 	lea    0xacb(%rip),%rax        # 101476 <flag_chars+0x6>
  1009ab:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  1009af:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009b6:	0f b6 00             	movzbl (%rax),%eax
  1009b9:	0f be c0             	movsbl %al,%eax
  1009bc:	83 e8 43             	sub    $0x43,%eax
  1009bf:	83 f8 37             	cmp    $0x37,%eax
  1009c2:	0f 87 b6 03 00 00    	ja     100d7e <printer_vprintf+0x6d9>
  1009c8:	89 c0                	mov    %eax,%eax
  1009ca:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  1009d1:	00 
  1009d2:	48 8d 05 ab 0a 00 00 	lea    0xaab(%rip),%rax        # 101484 <flag_chars+0x14>
  1009d9:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  1009dc:	48 98                	cltq   
  1009de:	48 8d 15 9f 0a 00 00 	lea    0xa9f(%rip),%rdx        # 101484 <flag_chars+0x14>
  1009e5:	48 01 d0             	add    %rdx,%rax
  1009e8:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  1009eb:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1009f2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009f9:	01 
            goto again;
  1009fa:	eb b3                	jmp    1009af <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1009fc:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100a00:	74 5d                	je     100a5f <printer_vprintf+0x3ba>
  100a02:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a09:	8b 00                	mov    (%rax),%eax
  100a0b:	83 f8 2f             	cmp    $0x2f,%eax
  100a0e:	77 30                	ja     100a40 <printer_vprintf+0x39b>
  100a10:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a17:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a22:	8b 00                	mov    (%rax),%eax
  100a24:	89 c0                	mov    %eax,%eax
  100a26:	48 01 d0             	add    %rdx,%rax
  100a29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a30:	8b 12                	mov    (%rdx),%edx
  100a32:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a35:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a3c:	89 0a                	mov    %ecx,(%rdx)
  100a3e:	eb 1a                	jmp    100a5a <printer_vprintf+0x3b5>
  100a40:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a47:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a4b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a4f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a56:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a5a:	48 8b 00             	mov    (%rax),%rax
  100a5d:	eb 5c                	jmp    100abb <printer_vprintf+0x416>
  100a5f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a66:	8b 00                	mov    (%rax),%eax
  100a68:	83 f8 2f             	cmp    $0x2f,%eax
  100a6b:	77 30                	ja     100a9d <printer_vprintf+0x3f8>
  100a6d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a74:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a78:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a7f:	8b 00                	mov    (%rax),%eax
  100a81:	89 c0                	mov    %eax,%eax
  100a83:	48 01 d0             	add    %rdx,%rax
  100a86:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a8d:	8b 12                	mov    (%rdx),%edx
  100a8f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a92:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a99:	89 0a                	mov    %ecx,(%rdx)
  100a9b:	eb 1a                	jmp    100ab7 <printer_vprintf+0x412>
  100a9d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aa4:	48 8b 40 08          	mov    0x8(%rax),%rax
  100aa8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100aac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ab3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ab7:	8b 00                	mov    (%rax),%eax
  100ab9:	48 98                	cltq   
  100abb:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100abf:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ac3:	48 c1 f8 38          	sar    $0x38,%rax
  100ac7:	25 80 00 00 00       	and    $0x80,%eax
  100acc:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100acf:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100ad3:	74 09                	je     100ade <printer_vprintf+0x439>
  100ad5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ad9:	48 f7 d8             	neg    %rax
  100adc:	eb 04                	jmp    100ae2 <printer_vprintf+0x43d>
  100ade:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ae2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100ae6:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100ae9:	83 c8 60             	or     $0x60,%eax
  100aec:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100aef:	e9 cf 02 00 00       	jmp    100dc3 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100af4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100af8:	74 5d                	je     100b57 <printer_vprintf+0x4b2>
  100afa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b01:	8b 00                	mov    (%rax),%eax
  100b03:	83 f8 2f             	cmp    $0x2f,%eax
  100b06:	77 30                	ja     100b38 <printer_vprintf+0x493>
  100b08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b0f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b13:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b1a:	8b 00                	mov    (%rax),%eax
  100b1c:	89 c0                	mov    %eax,%eax
  100b1e:	48 01 d0             	add    %rdx,%rax
  100b21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b28:	8b 12                	mov    (%rdx),%edx
  100b2a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b2d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b34:	89 0a                	mov    %ecx,(%rdx)
  100b36:	eb 1a                	jmp    100b52 <printer_vprintf+0x4ad>
  100b38:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b3f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b43:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b47:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b4e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b52:	48 8b 00             	mov    (%rax),%rax
  100b55:	eb 5c                	jmp    100bb3 <printer_vprintf+0x50e>
  100b57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b5e:	8b 00                	mov    (%rax),%eax
  100b60:	83 f8 2f             	cmp    $0x2f,%eax
  100b63:	77 30                	ja     100b95 <printer_vprintf+0x4f0>
  100b65:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b6c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b70:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b77:	8b 00                	mov    (%rax),%eax
  100b79:	89 c0                	mov    %eax,%eax
  100b7b:	48 01 d0             	add    %rdx,%rax
  100b7e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b85:	8b 12                	mov    (%rdx),%edx
  100b87:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b8a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b91:	89 0a                	mov    %ecx,(%rdx)
  100b93:	eb 1a                	jmp    100baf <printer_vprintf+0x50a>
  100b95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b9c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ba0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ba4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bab:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100baf:	8b 00                	mov    (%rax),%eax
  100bb1:	89 c0                	mov    %eax,%eax
  100bb3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100bb7:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100bbb:	e9 03 02 00 00       	jmp    100dc3 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100bc0:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100bc7:	e9 28 ff ff ff       	jmp    100af4 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100bcc:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100bd3:	e9 1c ff ff ff       	jmp    100af4 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100bd8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bdf:	8b 00                	mov    (%rax),%eax
  100be1:	83 f8 2f             	cmp    $0x2f,%eax
  100be4:	77 30                	ja     100c16 <printer_vprintf+0x571>
  100be6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bed:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bf1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bf8:	8b 00                	mov    (%rax),%eax
  100bfa:	89 c0                	mov    %eax,%eax
  100bfc:	48 01 d0             	add    %rdx,%rax
  100bff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c06:	8b 12                	mov    (%rdx),%edx
  100c08:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c0b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c12:	89 0a                	mov    %ecx,(%rdx)
  100c14:	eb 1a                	jmp    100c30 <printer_vprintf+0x58b>
  100c16:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c1d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c21:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c25:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c2c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c30:	48 8b 00             	mov    (%rax),%rax
  100c33:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100c37:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100c3e:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100c45:	e9 79 01 00 00       	jmp    100dc3 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100c4a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c51:	8b 00                	mov    (%rax),%eax
  100c53:	83 f8 2f             	cmp    $0x2f,%eax
  100c56:	77 30                	ja     100c88 <printer_vprintf+0x5e3>
  100c58:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c5f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c63:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c6a:	8b 00                	mov    (%rax),%eax
  100c6c:	89 c0                	mov    %eax,%eax
  100c6e:	48 01 d0             	add    %rdx,%rax
  100c71:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c78:	8b 12                	mov    (%rdx),%edx
  100c7a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c7d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c84:	89 0a                	mov    %ecx,(%rdx)
  100c86:	eb 1a                	jmp    100ca2 <printer_vprintf+0x5fd>
  100c88:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c8f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c93:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c97:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c9e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ca2:	48 8b 00             	mov    (%rax),%rax
  100ca5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100ca9:	e9 15 01 00 00       	jmp    100dc3 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100cae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cb5:	8b 00                	mov    (%rax),%eax
  100cb7:	83 f8 2f             	cmp    $0x2f,%eax
  100cba:	77 30                	ja     100cec <printer_vprintf+0x647>
  100cbc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cc3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cc7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cce:	8b 00                	mov    (%rax),%eax
  100cd0:	89 c0                	mov    %eax,%eax
  100cd2:	48 01 d0             	add    %rdx,%rax
  100cd5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cdc:	8b 12                	mov    (%rdx),%edx
  100cde:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ce1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ce8:	89 0a                	mov    %ecx,(%rdx)
  100cea:	eb 1a                	jmp    100d06 <printer_vprintf+0x661>
  100cec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cf3:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cf7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cfb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d02:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d06:	8b 00                	mov    (%rax),%eax
  100d08:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100d0e:	e9 77 03 00 00       	jmp    10108a <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100d13:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d17:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100d1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d22:	8b 00                	mov    (%rax),%eax
  100d24:	83 f8 2f             	cmp    $0x2f,%eax
  100d27:	77 30                	ja     100d59 <printer_vprintf+0x6b4>
  100d29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d30:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d3b:	8b 00                	mov    (%rax),%eax
  100d3d:	89 c0                	mov    %eax,%eax
  100d3f:	48 01 d0             	add    %rdx,%rax
  100d42:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d49:	8b 12                	mov    (%rdx),%edx
  100d4b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d4e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d55:	89 0a                	mov    %ecx,(%rdx)
  100d57:	eb 1a                	jmp    100d73 <printer_vprintf+0x6ce>
  100d59:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d60:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d64:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d68:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d6f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d73:	8b 00                	mov    (%rax),%eax
  100d75:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d78:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100d7c:	eb 45                	jmp    100dc3 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100d7e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d82:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100d86:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d8d:	0f b6 00             	movzbl (%rax),%eax
  100d90:	84 c0                	test   %al,%al
  100d92:	74 0c                	je     100da0 <printer_vprintf+0x6fb>
  100d94:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d9b:	0f b6 00             	movzbl (%rax),%eax
  100d9e:	eb 05                	jmp    100da5 <printer_vprintf+0x700>
  100da0:	b8 25 00 00 00       	mov    $0x25,%eax
  100da5:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100da8:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100dac:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100db3:	0f b6 00             	movzbl (%rax),%eax
  100db6:	84 c0                	test   %al,%al
  100db8:	75 08                	jne    100dc2 <printer_vprintf+0x71d>
                format--;
  100dba:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100dc1:	01 
            }
            break;
  100dc2:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100dc3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dc6:	83 e0 20             	and    $0x20,%eax
  100dc9:	85 c0                	test   %eax,%eax
  100dcb:	74 1e                	je     100deb <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100dcd:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100dd1:	48 83 c0 18          	add    $0x18,%rax
  100dd5:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100dd8:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100ddc:	48 89 ce             	mov    %rcx,%rsi
  100ddf:	48 89 c7             	mov    %rax,%rdi
  100de2:	e8 32 f8 ff ff       	call   100619 <fill_numbuf>
  100de7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100deb:	48 8d 05 84 06 00 00 	lea    0x684(%rip),%rax        # 101476 <flag_chars+0x6>
  100df2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100df6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100df9:	83 e0 20             	and    $0x20,%eax
  100dfc:	85 c0                	test   %eax,%eax
  100dfe:	74 51                	je     100e51 <printer_vprintf+0x7ac>
  100e00:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e03:	83 e0 40             	and    $0x40,%eax
  100e06:	85 c0                	test   %eax,%eax
  100e08:	74 47                	je     100e51 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100e0a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e0d:	25 80 00 00 00       	and    $0x80,%eax
  100e12:	85 c0                	test   %eax,%eax
  100e14:	74 0d                	je     100e23 <printer_vprintf+0x77e>
                prefix = "-";
  100e16:	48 8d 05 5a 06 00 00 	lea    0x65a(%rip),%rax        # 101477 <flag_chars+0x7>
  100e1d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e21:	eb 7d                	jmp    100ea0 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100e23:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e26:	83 e0 10             	and    $0x10,%eax
  100e29:	85 c0                	test   %eax,%eax
  100e2b:	74 0d                	je     100e3a <printer_vprintf+0x795>
                prefix = "+";
  100e2d:	48 8d 05 45 06 00 00 	lea    0x645(%rip),%rax        # 101479 <flag_chars+0x9>
  100e34:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e38:	eb 66                	jmp    100ea0 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100e3a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e3d:	83 e0 08             	and    $0x8,%eax
  100e40:	85 c0                	test   %eax,%eax
  100e42:	74 5c                	je     100ea0 <printer_vprintf+0x7fb>
                prefix = " ";
  100e44:	48 8d 05 30 06 00 00 	lea    0x630(%rip),%rax        # 10147b <flag_chars+0xb>
  100e4b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e4f:	eb 4f                	jmp    100ea0 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100e51:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e54:	83 e0 20             	and    $0x20,%eax
  100e57:	85 c0                	test   %eax,%eax
  100e59:	74 46                	je     100ea1 <printer_vprintf+0x7fc>
  100e5b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e5e:	83 e0 01             	and    $0x1,%eax
  100e61:	85 c0                	test   %eax,%eax
  100e63:	74 3c                	je     100ea1 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100e65:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100e69:	74 06                	je     100e71 <printer_vprintf+0x7cc>
  100e6b:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e6f:	75 30                	jne    100ea1 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100e71:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100e76:	75 0c                	jne    100e84 <printer_vprintf+0x7df>
  100e78:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e7b:	25 00 01 00 00       	and    $0x100,%eax
  100e80:	85 c0                	test   %eax,%eax
  100e82:	74 1d                	je     100ea1 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100e84:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e88:	75 09                	jne    100e93 <printer_vprintf+0x7ee>
  100e8a:	48 8d 05 ec 05 00 00 	lea    0x5ec(%rip),%rax        # 10147d <flag_chars+0xd>
  100e91:	eb 07                	jmp    100e9a <printer_vprintf+0x7f5>
  100e93:	48 8d 05 e6 05 00 00 	lea    0x5e6(%rip),%rax        # 101480 <flag_chars+0x10>
  100e9a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100e9e:	eb 01                	jmp    100ea1 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100ea0:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100ea1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ea5:	78 24                	js     100ecb <printer_vprintf+0x826>
  100ea7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100eaa:	83 e0 20             	and    $0x20,%eax
  100ead:	85 c0                	test   %eax,%eax
  100eaf:	75 1a                	jne    100ecb <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100eb1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100eb4:	48 63 d0             	movslq %eax,%rdx
  100eb7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ebb:	48 89 d6             	mov    %rdx,%rsi
  100ebe:	48 89 c7             	mov    %rax,%rdi
  100ec1:	e8 91 f5 ff ff       	call   100457 <strnlen>
  100ec6:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100ec9:	eb 0f                	jmp    100eda <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100ecb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ecf:	48 89 c7             	mov    %rax,%rdi
  100ed2:	e8 4b f5 ff ff       	call   100422 <strlen>
  100ed7:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100eda:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100edd:	83 e0 20             	and    $0x20,%eax
  100ee0:	85 c0                	test   %eax,%eax
  100ee2:	74 20                	je     100f04 <printer_vprintf+0x85f>
  100ee4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ee8:	78 1a                	js     100f04 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100eea:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100eed:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100ef0:	7e 08                	jle    100efa <printer_vprintf+0x855>
  100ef2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100ef5:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100ef8:	eb 05                	jmp    100eff <printer_vprintf+0x85a>
  100efa:	b8 00 00 00 00       	mov    $0x0,%eax
  100eff:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f02:	eb 5c                	jmp    100f60 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100f04:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f07:	83 e0 20             	and    $0x20,%eax
  100f0a:	85 c0                	test   %eax,%eax
  100f0c:	74 4b                	je     100f59 <printer_vprintf+0x8b4>
  100f0e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f11:	83 e0 02             	and    $0x2,%eax
  100f14:	85 c0                	test   %eax,%eax
  100f16:	74 41                	je     100f59 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100f18:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f1b:	83 e0 04             	and    $0x4,%eax
  100f1e:	85 c0                	test   %eax,%eax
  100f20:	75 37                	jne    100f59 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100f22:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f26:	48 89 c7             	mov    %rax,%rdi
  100f29:	e8 f4 f4 ff ff       	call   100422 <strlen>
  100f2e:	89 c2                	mov    %eax,%edx
  100f30:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100f33:	01 d0                	add    %edx,%eax
  100f35:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100f38:	7e 1f                	jle    100f59 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100f3a:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f3d:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100f40:	89 c3                	mov    %eax,%ebx
  100f42:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f46:	48 89 c7             	mov    %rax,%rdi
  100f49:	e8 d4 f4 ff ff       	call   100422 <strlen>
  100f4e:	89 c2                	mov    %eax,%edx
  100f50:	89 d8                	mov    %ebx,%eax
  100f52:	29 d0                	sub    %edx,%eax
  100f54:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f57:	eb 07                	jmp    100f60 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100f59:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100f60:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100f63:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100f66:	01 d0                	add    %edx,%eax
  100f68:	48 63 d8             	movslq %eax,%rbx
  100f6b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f6f:	48 89 c7             	mov    %rax,%rdi
  100f72:	e8 ab f4 ff ff       	call   100422 <strlen>
  100f77:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100f7b:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f7e:	29 d0                	sub    %edx,%eax
  100f80:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f83:	eb 25                	jmp    100faa <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  100f85:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f8c:	48 8b 08             	mov    (%rax),%rcx
  100f8f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f95:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f9c:	be 20 00 00 00       	mov    $0x20,%esi
  100fa1:	48 89 c7             	mov    %rax,%rdi
  100fa4:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100fa6:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100faa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fad:	83 e0 04             	and    $0x4,%eax
  100fb0:	85 c0                	test   %eax,%eax
  100fb2:	75 36                	jne    100fea <printer_vprintf+0x945>
  100fb4:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100fb8:	7f cb                	jg     100f85 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  100fba:	eb 2e                	jmp    100fea <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  100fbc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fc3:	4c 8b 00             	mov    (%rax),%r8
  100fc6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fca:	0f b6 00             	movzbl (%rax),%eax
  100fcd:	0f b6 c8             	movzbl %al,%ecx
  100fd0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fd6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fdd:	89 ce                	mov    %ecx,%esi
  100fdf:	48 89 c7             	mov    %rax,%rdi
  100fe2:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100fe5:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100fea:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fee:	0f b6 00             	movzbl (%rax),%eax
  100ff1:	84 c0                	test   %al,%al
  100ff3:	75 c7                	jne    100fbc <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  100ff5:	eb 25                	jmp    10101c <printer_vprintf+0x977>
            p->putc(p, '0', color);
  100ff7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ffe:	48 8b 08             	mov    (%rax),%rcx
  101001:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101007:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10100e:	be 30 00 00 00       	mov    $0x30,%esi
  101013:	48 89 c7             	mov    %rax,%rdi
  101016:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101018:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  10101c:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101020:	7f d5                	jg     100ff7 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  101022:	eb 32                	jmp    101056 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  101024:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10102b:	4c 8b 00             	mov    (%rax),%r8
  10102e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101032:	0f b6 00             	movzbl (%rax),%eax
  101035:	0f b6 c8             	movzbl %al,%ecx
  101038:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10103e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101045:	89 ce                	mov    %ecx,%esi
  101047:	48 89 c7             	mov    %rax,%rdi
  10104a:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  10104d:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101052:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101056:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10105a:	7f c8                	jg     101024 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  10105c:	eb 25                	jmp    101083 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  10105e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101065:	48 8b 08             	mov    (%rax),%rcx
  101068:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10106e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101075:	be 20 00 00 00       	mov    $0x20,%esi
  10107a:	48 89 c7             	mov    %rax,%rdi
  10107d:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  10107f:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101083:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101087:	7f d5                	jg     10105e <printer_vprintf+0x9b9>
        }
    done: ;
  101089:	90                   	nop
    for (; *format; ++format) {
  10108a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101091:	01 
  101092:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101099:	0f b6 00             	movzbl (%rax),%eax
  10109c:	84 c0                	test   %al,%al
  10109e:	0f 85 31 f6 ff ff    	jne    1006d5 <printer_vprintf+0x30>
    }
}
  1010a4:	90                   	nop
  1010a5:	90                   	nop
  1010a6:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1010aa:	c9                   	leave  
  1010ab:	c3                   	ret    

00000000001010ac <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1010ac:	f3 0f 1e fa          	endbr64 
  1010b0:	55                   	push   %rbp
  1010b1:	48 89 e5             	mov    %rsp,%rbp
  1010b4:	48 83 ec 20          	sub    $0x20,%rsp
  1010b8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1010bc:	89 f0                	mov    %esi,%eax
  1010be:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1010c1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1010c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1010c8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1010cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010d0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010d4:	48 8d 15 c5 7e fb ff 	lea    -0x4813b(%rip),%rdx        # b8fa0 <console+0xfa0>
  1010db:	48 39 d0             	cmp    %rdx,%rax
  1010de:	72 0f                	jb     1010ef <console_putc+0x43>
        cp->cursor = console;
  1010e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010e4:	48 8d 15 15 6f fb ff 	lea    -0x490eb(%rip),%rdx        # b8000 <console>
  1010eb:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  1010ef:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1010f3:	0f 85 82 00 00 00    	jne    10117b <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  1010f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010fd:	48 8b 40 08          	mov    0x8(%rax),%rax
  101101:	48 8d 15 f8 6e fb ff 	lea    -0x49108(%rip),%rdx        # b8000 <console>
  101108:	48 29 d0             	sub    %rdx,%rax
  10110b:	48 d1 f8             	sar    %rax
  10110e:	48 89 c1             	mov    %rax,%rcx
  101111:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101118:	66 66 66 
  10111b:	48 89 c8             	mov    %rcx,%rax
  10111e:	48 f7 ea             	imul   %rdx
  101121:	48 89 d0             	mov    %rdx,%rax
  101124:	48 c1 f8 05          	sar    $0x5,%rax
  101128:	48 89 ce             	mov    %rcx,%rsi
  10112b:	48 c1 fe 3f          	sar    $0x3f,%rsi
  10112f:	48 29 f0             	sub    %rsi,%rax
  101132:	48 89 c2             	mov    %rax,%rdx
  101135:	48 89 d0             	mov    %rdx,%rax
  101138:	48 c1 e0 02          	shl    $0x2,%rax
  10113c:	48 01 d0             	add    %rdx,%rax
  10113f:	48 c1 e0 04          	shl    $0x4,%rax
  101143:	48 29 c1             	sub    %rax,%rcx
  101146:	48 89 ca             	mov    %rcx,%rdx
  101149:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  10114c:	eb 25                	jmp    101173 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  10114e:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101151:	83 c8 20             	or     $0x20,%eax
  101154:	89 c6                	mov    %eax,%esi
  101156:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10115a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10115e:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101162:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101166:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10116a:	89 f2                	mov    %esi,%edx
  10116c:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10116f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101173:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101177:	75 d5                	jne    10114e <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101179:	eb 24                	jmp    10119f <console_putc+0xf3>
        *cp->cursor++ = c | color;
  10117b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10117f:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101182:	89 d6                	mov    %edx,%esi
  101184:	09 c6                	or     %eax,%esi
  101186:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10118a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10118e:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101192:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101196:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10119a:	89 f2                	mov    %esi,%edx
  10119c:	66 89 10             	mov    %dx,(%rax)
}
  10119f:	90                   	nop
  1011a0:	c9                   	leave  
  1011a1:	c3                   	ret    

00000000001011a2 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1011a2:	f3 0f 1e fa          	endbr64 
  1011a6:	55                   	push   %rbp
  1011a7:	48 89 e5             	mov    %rsp,%rbp
  1011aa:	48 83 ec 30          	sub    $0x30,%rsp
  1011ae:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1011b1:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1011b4:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1011b8:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1011bc:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 1010ac <console_putc>
  1011c3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1011c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1011cb:	78 09                	js     1011d6 <console_vprintf+0x34>
  1011cd:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1011d4:	7e 07                	jle    1011dd <console_vprintf+0x3b>
        cpos = 0;
  1011d6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1011dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011e0:	48 98                	cltq   
  1011e2:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1011e6:	48 8d 05 13 6e fb ff 	lea    -0x491ed(%rip),%rax        # b8000 <console>
  1011ed:	48 01 d0             	add    %rdx,%rax
  1011f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1011f4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1011f8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1011fc:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1011ff:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101203:	48 89 c7             	mov    %rax,%rdi
  101206:	e8 9a f4 ff ff       	call   1006a5 <printer_vprintf>
    return cp.cursor - console;
  10120b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10120f:	48 8d 15 ea 6d fb ff 	lea    -0x49216(%rip),%rdx        # b8000 <console>
  101216:	48 29 d0             	sub    %rdx,%rax
  101219:	48 d1 f8             	sar    %rax
}
  10121c:	c9                   	leave  
  10121d:	c3                   	ret    

000000000010121e <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10121e:	f3 0f 1e fa          	endbr64 
  101222:	55                   	push   %rbp
  101223:	48 89 e5             	mov    %rsp,%rbp
  101226:	48 83 ec 60          	sub    $0x60,%rsp
  10122a:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10122d:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101230:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101234:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101238:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10123c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101240:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101247:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10124b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10124f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101253:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101257:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10125b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10125f:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101262:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101265:	89 c7                	mov    %eax,%edi
  101267:	e8 36 ff ff ff       	call   1011a2 <console_vprintf>
  10126c:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10126f:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101272:	c9                   	leave  
  101273:	c3                   	ret    

0000000000101274 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101274:	f3 0f 1e fa          	endbr64 
  101278:	55                   	push   %rbp
  101279:	48 89 e5             	mov    %rsp,%rbp
  10127c:	48 83 ec 20          	sub    $0x20,%rsp
  101280:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101284:	89 f0                	mov    %esi,%eax
  101286:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101289:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10128c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101290:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101294:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101298:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10129c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012a0:	48 8b 40 10          	mov    0x10(%rax),%rax
  1012a4:	48 39 c2             	cmp    %rax,%rdx
  1012a7:	73 1a                	jae    1012c3 <string_putc+0x4f>
        *sp->s++ = c;
  1012a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012ad:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012b1:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1012b5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1012b9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012bd:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1012c1:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1012c3:	90                   	nop
  1012c4:	c9                   	leave  
  1012c5:	c3                   	ret    

00000000001012c6 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1012c6:	f3 0f 1e fa          	endbr64 
  1012ca:	55                   	push   %rbp
  1012cb:	48 89 e5             	mov    %rsp,%rbp
  1012ce:	48 83 ec 40          	sub    $0x40,%rsp
  1012d2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1012d6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1012da:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1012de:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1012e2:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 101274 <string_putc>
  1012e9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  1012ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1012f1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1012f5:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1012fa:	74 33                	je     10132f <vsnprintf+0x69>
        sp.end = s + size - 1;
  1012fc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101300:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101304:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101308:	48 01 d0             	add    %rdx,%rax
  10130b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10130f:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101313:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101317:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  10131b:	be 00 00 00 00       	mov    $0x0,%esi
  101320:	48 89 c7             	mov    %rax,%rdi
  101323:	e8 7d f3 ff ff       	call   1006a5 <printer_vprintf>
        *sp.s = 0;
  101328:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10132c:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10132f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101333:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101337:	c9                   	leave  
  101338:	c3                   	ret    

0000000000101339 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101339:	f3 0f 1e fa          	endbr64 
  10133d:	55                   	push   %rbp
  10133e:	48 89 e5             	mov    %rsp,%rbp
  101341:	48 83 ec 70          	sub    $0x70,%rsp
  101345:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101349:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10134d:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101351:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101355:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101359:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10135d:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101364:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101368:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10136c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101370:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101374:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101378:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10137c:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101380:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101384:	48 89 c7             	mov    %rax,%rdi
  101387:	e8 3a ff ff ff       	call   1012c6 <vsnprintf>
  10138c:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10138f:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101392:	c9                   	leave  
  101393:	c3                   	ret    

0000000000101394 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101394:	f3 0f 1e fa          	endbr64 
  101398:	55                   	push   %rbp
  101399:	48 89 e5             	mov    %rsp,%rbp
  10139c:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1013a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1013a7:	eb 1a                	jmp    1013c3 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  1013a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1013ac:	48 98                	cltq   
  1013ae:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1013b2:	48 8d 05 47 6c fb ff 	lea    -0x493b9(%rip),%rax        # b8000 <console>
  1013b9:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1013bf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1013c3:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1013ca:	7e dd                	jle    1013a9 <console_clear+0x15>
    }
    cursorpos = 0;
  1013cc:	c7 05 26 7c fb ff 00 	movl   $0x0,-0x483da(%rip)        # b8ffc <cursorpos>
  1013d3:	00 00 00 
}
  1013d6:	90                   	nop
  1013d7:	c9                   	leave  
  1013d8:	c3                   	ret    
