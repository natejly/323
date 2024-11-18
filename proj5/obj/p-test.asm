
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t* stack_bottom;

// checks if multiple processes can allocate at the same Virtual Memory Address
// (run at least two instances)

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
  100013:	e8 4d 05 00 00       	call   100565 <srand>
    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100018:	48 8d 05 f8 2f 00 00 	lea    0x2ff8(%rip),%rax        # 103017 <end+0xfff>
  10001f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100025:	48 89 05 dc 1f 00 00 	mov    %rax,0x1fdc(%rip)        # 102008 <heap_top>

    app_printf(p, "Make sure you are running this test with at least 2 processes running by hitting 2!\n");
  10002c:	48 8d 35 1d 13 00 00 	lea    0x131d(%rip),%rsi        # 101350 <console_clear+0x4b>
  100033:	89 df                	mov    %ebx,%edi
  100035:	b8 00 00 00 00       	mov    $0x0,%eax
  10003a:	e8 67 00 00 00       	call   1000a6 <app_printf>
//    Allocate a page of memory at address `addr` and allow process to
//    write to it. `Addr` must be page-aligned (i.e., a multiple of
//    PAGESIZE == 4096). Returns 0 on success and -1 on failure.
static inline int sys_page_alloc(void* addr) {
    int result;
    asm volatile ("int %1" : "=a" (result)
  10003f:	48 8b 3d c2 1f 00 00 	mov    0x1fc2(%rip),%rdi        # 102008 <heap_top>
  100046:	cd 33                	int    $0x33

    // check if process can access each others memory

    int x = sys_page_alloc((void *) (heap_top));

    if(x != 0)
  100048:	85 c0                	test   %eax,%eax
  10004a:	75 38                	jne    100084 <process_main+0x84>
    asm volatile ("int %0" : /* no result */
  10004c:	cd 32                	int    $0x32

    // yield to make sure other process also runs before continuing
    sys_yield();

    // write to allocd page
    *heap_top = p;
  10004e:	48 8b 05 b3 1f 00 00 	mov    0x1fb3(%rip),%rax        # 102008 <heap_top>
  100055:	88 18                	mov    %bl,(%rax)
  100057:	cd 32                	int    $0x32
  100059:	b8 64 00 00 00       	mov    $0x64,%eax

    sys_yield();

    // Now, test at least 100 times to see if values will ever change
    for(int i = 0 ; i < 100 ; i++){
        if(*heap_top != p)
  10005e:	48 8b 15 a3 1f 00 00 	mov    0x1fa3(%rip),%rdx        # 102008 <heap_top>
  100065:	0f b6 12             	movzbl (%rdx),%edx
  100068:	39 da                	cmp    %ebx,%edx
  10006a:	75 29                	jne    100095 <process_main+0x95>
  10006c:	cd 32                	int    $0x32
    for(int i = 0 ; i < 100 ; i++){
  10006e:	83 e8 01             	sub    $0x1,%eax
  100071:	75 eb                	jne    10005e <process_main+0x5e>
            panic("Error, value changed! process memory not isolated!\n");
        sys_yield();
    }

    TEST_PASS();
  100073:	48 8d 3d 92 13 00 00 	lea    0x1392(%rip),%rdi        # 10140c <console_clear+0x107>
  10007a:	b8 00 00 00 00       	mov    $0x0,%eax
  10007f:	e8 ba 00 00 00       	call   10013e <panic>
        panic("Error, couldn't allocate same memory location!\n");
  100084:	48 8d 3d 1d 13 00 00 	lea    0x131d(%rip),%rdi        # 1013a8 <console_clear+0xa3>
  10008b:	b8 00 00 00 00       	mov    $0x0,%eax
  100090:	e8 a9 00 00 00       	call   10013e <panic>
            panic("Error, value changed! process memory not isolated!\n");
  100095:	48 8d 3d 3c 13 00 00 	lea    0x133c(%rip),%rdi        # 1013d8 <console_clear+0xd3>
  10009c:	b8 00 00 00 00       	mov    $0x0,%eax
  1000a1:	e8 98 00 00 00       	call   10013e <panic>

00000000001000a6 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1000a6:	f3 0f 1e fa          	endbr64 
  1000aa:	55                   	push   %rbp
  1000ab:	48 89 e5             	mov    %rsp,%rbp
  1000ae:	48 83 ec 50          	sub    $0x50,%rsp
  1000b2:	49 89 f2             	mov    %rsi,%r10
  1000b5:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1000b9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1000bd:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1000c1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1000c5:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  1000ca:	85 ff                	test   %edi,%edi
  1000cc:	78 32                	js     100100 <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1000ce:	48 63 ff             	movslq %edi,%rdi
  1000d1:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1000d8:	cc cc cc 
  1000db:	48 89 f8             	mov    %rdi,%rax
  1000de:	48 f7 e2             	mul    %rdx
  1000e1:	48 89 d0             	mov    %rdx,%rax
  1000e4:	48 c1 e8 02          	shr    $0x2,%rax
  1000e8:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1000ec:	48 01 c2             	add    %rax,%rdx
  1000ef:	48 29 d7             	sub    %rdx,%rdi
  1000f2:	48 8d 05 64 13 00 00 	lea    0x1364(%rip),%rax        # 10145d <col.0>
  1000f9:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  1000fd:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100100:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100107:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10010b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10010f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100113:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100117:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10011b:	4c 89 d2             	mov    %r10,%rdx
  10011e:	8b 3d d8 8e fb ff    	mov    -0x47128(%rip),%edi        # b8ffc <cursorpos>
  100124:	e8 ea 0f 00 00       	call   101113 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100129:	3d 30 07 00 00       	cmp    $0x730,%eax
  10012e:	ba 00 00 00 00       	mov    $0x0,%edx
  100133:	0f 4d c2             	cmovge %edx,%eax
  100136:	89 05 c0 8e fb ff    	mov    %eax,-0x47140(%rip)        # b8ffc <cursorpos>
    }
}
  10013c:	c9                   	leave  
  10013d:	c3                   	ret    

000000000010013e <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  10013e:	f3 0f 1e fa          	endbr64 
  100142:	55                   	push   %rbp
  100143:	48 89 e5             	mov    %rsp,%rbp
  100146:	53                   	push   %rbx
  100147:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  10014e:	48 89 fb             	mov    %rdi,%rbx
  100151:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100155:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100159:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  10015d:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100161:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100165:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  10016c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100170:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100174:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100178:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  10017c:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100183:	ba 07 00 00 00       	mov    $0x7,%edx
  100188:	48 8d 35 98 12 00 00 	lea    0x1298(%rip),%rsi        # 101427 <console_clear+0x122>
  10018f:	e8 b6 00 00 00       	call   10024a <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100194:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100198:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  10019f:	48 89 da             	mov    %rbx,%rdx
  1001a2:	be 99 00 00 00       	mov    $0x99,%esi
  1001a7:	e8 8b 10 00 00       	call   101237 <vsnprintf>
  1001ac:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  1001af:	85 d2                	test   %edx,%edx
  1001b1:	7e 0f                	jle    1001c2 <panic+0x84>
  1001b3:	83 c0 06             	add    $0x6,%eax
  1001b6:	48 98                	cltq   
  1001b8:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1001bf:	0a 
  1001c0:	75 2b                	jne    1001ed <panic+0xaf>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1001c2:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  1001c9:	48 8d 15 61 12 00 00 	lea    0x1261(%rip),%rdx        # 101431 <console_clear+0x12c>
  1001d0:	be 00 c0 00 00       	mov    $0xc000,%esi
  1001d5:	bf 30 07 00 00       	mov    $0x730,%edi
  1001da:	b8 00 00 00 00       	mov    $0x0,%eax
  1001df:	e8 ab 0f 00 00       	call   10118f <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  1001e4:	bf 00 00 00 00       	mov    $0x0,%edi
  1001e9:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  1001eb:	eb fe                	jmp    1001eb <panic+0xad>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1001ed:	48 63 c2             	movslq %edx,%rax
  1001f0:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1001f6:	0f 94 c2             	sete   %dl
  1001f9:	0f b6 d2             	movzbl %dl,%edx
  1001fc:	48 29 d0             	sub    %rdx,%rax
  1001ff:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100206:	ff 
  100207:	48 8d 35 21 12 00 00 	lea    0x1221(%rip),%rsi        # 10142f <console_clear+0x12a>
  10020e:	e8 f8 01 00 00       	call   10040b <strcpy>
  100213:	eb ad                	jmp    1001c2 <panic+0x84>

0000000000100215 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100215:	f3 0f 1e fa          	endbr64 
  100219:	55                   	push   %rbp
  10021a:	48 89 e5             	mov    %rsp,%rbp
  10021d:	48 89 f9             	mov    %rdi,%rcx
  100220:	41 89 f0             	mov    %esi,%r8d
  100223:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100226:	48 8d 15 0b 12 00 00 	lea    0x120b(%rip),%rdx        # 101438 <console_clear+0x133>
  10022d:	be 00 c0 00 00       	mov    $0xc000,%esi
  100232:	bf 30 07 00 00       	mov    $0x730,%edi
  100237:	b8 00 00 00 00       	mov    $0x0,%eax
  10023c:	e8 4e 0f 00 00       	call   10118f <console_printf>
    asm volatile ("int %0" : /* no result */
  100241:	bf 00 00 00 00       	mov    $0x0,%edi
  100246:	cd 30                	int    $0x30
 loop: goto loop;
  100248:	eb fe                	jmp    100248 <assert_fail+0x33>

000000000010024a <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  10024a:	f3 0f 1e fa          	endbr64 
  10024e:	55                   	push   %rbp
  10024f:	48 89 e5             	mov    %rsp,%rbp
  100252:	48 83 ec 28          	sub    $0x28,%rsp
  100256:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10025a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10025e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100262:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100266:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10026a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10026e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100272:	eb 1c                	jmp    100290 <memcpy+0x46>
        *d = *s;
  100274:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100278:	0f b6 10             	movzbl (%rax),%edx
  10027b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10027f:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100281:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100286:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10028b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100290:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100295:	75 dd                	jne    100274 <memcpy+0x2a>
    }
    return dst;
  100297:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10029b:	c9                   	leave  
  10029c:	c3                   	ret    

000000000010029d <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  10029d:	f3 0f 1e fa          	endbr64 
  1002a1:	55                   	push   %rbp
  1002a2:	48 89 e5             	mov    %rsp,%rbp
  1002a5:	48 83 ec 28          	sub    $0x28,%rsp
  1002a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002ad:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1002b1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002b5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1002bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002c1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1002c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002c9:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1002cd:	73 6a                	jae    100339 <memmove+0x9c>
  1002cf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1002d3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002d7:	48 01 d0             	add    %rdx,%rax
  1002da:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1002de:	73 59                	jae    100339 <memmove+0x9c>
        s += n, d += n;
  1002e0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002e4:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1002e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1002ec:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1002f0:	eb 17                	jmp    100309 <memmove+0x6c>
            *--d = *--s;
  1002f2:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1002f7:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1002fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100300:	0f b6 10             	movzbl (%rax),%edx
  100303:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100307:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100309:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10030d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100311:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100315:	48 85 c0             	test   %rax,%rax
  100318:	75 d8                	jne    1002f2 <memmove+0x55>
    if (s < d && s + n > d) {
  10031a:	eb 2e                	jmp    10034a <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  10031c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100320:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100324:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100328:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10032c:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100330:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100334:	0f b6 12             	movzbl (%rdx),%edx
  100337:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100339:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10033d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100341:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100345:	48 85 c0             	test   %rax,%rax
  100348:	75 d2                	jne    10031c <memmove+0x7f>
        }
    }
    return dst;
  10034a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10034e:	c9                   	leave  
  10034f:	c3                   	ret    

0000000000100350 <memset>:

void* memset(void* v, int c, size_t n) {
  100350:	f3 0f 1e fa          	endbr64 
  100354:	55                   	push   %rbp
  100355:	48 89 e5             	mov    %rsp,%rbp
  100358:	48 83 ec 28          	sub    $0x28,%rsp
  10035c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100360:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100363:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100367:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10036b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10036f:	eb 15                	jmp    100386 <memset+0x36>
        *p = c;
  100371:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100374:	89 c2                	mov    %eax,%edx
  100376:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10037a:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10037c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100381:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100386:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10038b:	75 e4                	jne    100371 <memset+0x21>
    }
    return v;
  10038d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100391:	c9                   	leave  
  100392:	c3                   	ret    

0000000000100393 <strlen>:

size_t strlen(const char* s) {
  100393:	f3 0f 1e fa          	endbr64 
  100397:	55                   	push   %rbp
  100398:	48 89 e5             	mov    %rsp,%rbp
  10039b:	48 83 ec 18          	sub    $0x18,%rsp
  10039f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1003a3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1003aa:	00 
  1003ab:	eb 0a                	jmp    1003b7 <strlen+0x24>
        ++n;
  1003ad:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1003b2:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1003b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003bb:	0f b6 00             	movzbl (%rax),%eax
  1003be:	84 c0                	test   %al,%al
  1003c0:	75 eb                	jne    1003ad <strlen+0x1a>
    }
    return n;
  1003c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1003c6:	c9                   	leave  
  1003c7:	c3                   	ret    

00000000001003c8 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1003c8:	f3 0f 1e fa          	endbr64 
  1003cc:	55                   	push   %rbp
  1003cd:	48 89 e5             	mov    %rsp,%rbp
  1003d0:	48 83 ec 20          	sub    $0x20,%rsp
  1003d4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003d8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1003dc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1003e3:	00 
  1003e4:	eb 0a                	jmp    1003f0 <strnlen+0x28>
        ++n;
  1003e6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1003eb:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1003f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003f4:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1003f8:	74 0b                	je     100405 <strnlen+0x3d>
  1003fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003fe:	0f b6 00             	movzbl (%rax),%eax
  100401:	84 c0                	test   %al,%al
  100403:	75 e1                	jne    1003e6 <strnlen+0x1e>
    }
    return n;
  100405:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100409:	c9                   	leave  
  10040a:	c3                   	ret    

000000000010040b <strcpy>:

char* strcpy(char* dst, const char* src) {
  10040b:	f3 0f 1e fa          	endbr64 
  10040f:	55                   	push   %rbp
  100410:	48 89 e5             	mov    %rsp,%rbp
  100413:	48 83 ec 20          	sub    $0x20,%rsp
  100417:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10041b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  10041f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100423:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100427:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10042b:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10042f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100433:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100437:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10043b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  10043f:	0f b6 12             	movzbl (%rdx),%edx
  100442:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100444:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100448:	48 83 e8 01          	sub    $0x1,%rax
  10044c:	0f b6 00             	movzbl (%rax),%eax
  10044f:	84 c0                	test   %al,%al
  100451:	75 d4                	jne    100427 <strcpy+0x1c>
    return dst;
  100453:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100457:	c9                   	leave  
  100458:	c3                   	ret    

0000000000100459 <strcmp>:

int strcmp(const char* a, const char* b) {
  100459:	f3 0f 1e fa          	endbr64 
  10045d:	55                   	push   %rbp
  10045e:	48 89 e5             	mov    %rsp,%rbp
  100461:	48 83 ec 10          	sub    $0x10,%rsp
  100465:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100469:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10046d:	eb 0a                	jmp    100479 <strcmp+0x20>
        ++a, ++b;
  10046f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100474:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100479:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10047d:	0f b6 00             	movzbl (%rax),%eax
  100480:	84 c0                	test   %al,%al
  100482:	74 1d                	je     1004a1 <strcmp+0x48>
  100484:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100488:	0f b6 00             	movzbl (%rax),%eax
  10048b:	84 c0                	test   %al,%al
  10048d:	74 12                	je     1004a1 <strcmp+0x48>
  10048f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100493:	0f b6 10             	movzbl (%rax),%edx
  100496:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10049a:	0f b6 00             	movzbl (%rax),%eax
  10049d:	38 c2                	cmp    %al,%dl
  10049f:	74 ce                	je     10046f <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1004a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004a5:	0f b6 00             	movzbl (%rax),%eax
  1004a8:	89 c2                	mov    %eax,%edx
  1004aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004ae:	0f b6 00             	movzbl (%rax),%eax
  1004b1:	38 c2                	cmp    %al,%dl
  1004b3:	0f 97 c0             	seta   %al
  1004b6:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1004b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004bd:	0f b6 00             	movzbl (%rax),%eax
  1004c0:	89 c1                	mov    %eax,%ecx
  1004c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1004c6:	0f b6 00             	movzbl (%rax),%eax
  1004c9:	38 c1                	cmp    %al,%cl
  1004cb:	0f 92 c0             	setb   %al
  1004ce:	0f b6 c8             	movzbl %al,%ecx
  1004d1:	89 d0                	mov    %edx,%eax
  1004d3:	29 c8                	sub    %ecx,%eax
}
  1004d5:	c9                   	leave  
  1004d6:	c3                   	ret    

00000000001004d7 <strchr>:

char* strchr(const char* s, int c) {
  1004d7:	f3 0f 1e fa          	endbr64 
  1004db:	55                   	push   %rbp
  1004dc:	48 89 e5             	mov    %rsp,%rbp
  1004df:	48 83 ec 10          	sub    $0x10,%rsp
  1004e3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004e7:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1004ea:	eb 05                	jmp    1004f1 <strchr+0x1a>
        ++s;
  1004ec:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1004f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004f5:	0f b6 00             	movzbl (%rax),%eax
  1004f8:	84 c0                	test   %al,%al
  1004fa:	74 0e                	je     10050a <strchr+0x33>
  1004fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100500:	0f b6 00             	movzbl (%rax),%eax
  100503:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100506:	38 d0                	cmp    %dl,%al
  100508:	75 e2                	jne    1004ec <strchr+0x15>
    }
    if (*s == (char) c) {
  10050a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10050e:	0f b6 00             	movzbl (%rax),%eax
  100511:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100514:	38 d0                	cmp    %dl,%al
  100516:	75 06                	jne    10051e <strchr+0x47>
        return (char*) s;
  100518:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10051c:	eb 05                	jmp    100523 <strchr+0x4c>
    } else {
        return NULL;
  10051e:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100523:	c9                   	leave  
  100524:	c3                   	ret    

0000000000100525 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100525:	f3 0f 1e fa          	endbr64 
  100529:	55                   	push   %rbp
  10052a:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  10052d:	8b 05 dd 1a 00 00    	mov    0x1add(%rip),%eax        # 102010 <rand_seed_set>
  100533:	85 c0                	test   %eax,%eax
  100535:	75 0a                	jne    100541 <rand+0x1c>
        srand(819234718U);
  100537:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  10053c:	e8 24 00 00 00       	call   100565 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100541:	8b 05 cd 1a 00 00    	mov    0x1acd(%rip),%eax        # 102014 <rand_seed>
  100547:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  10054d:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100552:	89 05 bc 1a 00 00    	mov    %eax,0x1abc(%rip)        # 102014 <rand_seed>
    return rand_seed & RAND_MAX;
  100558:	8b 05 b6 1a 00 00    	mov    0x1ab6(%rip),%eax        # 102014 <rand_seed>
  10055e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100563:	5d                   	pop    %rbp
  100564:	c3                   	ret    

0000000000100565 <srand>:

void srand(unsigned seed) {
  100565:	f3 0f 1e fa          	endbr64 
  100569:	55                   	push   %rbp
  10056a:	48 89 e5             	mov    %rsp,%rbp
  10056d:	48 83 ec 08          	sub    $0x8,%rsp
  100571:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100574:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100577:	89 05 97 1a 00 00    	mov    %eax,0x1a97(%rip)        # 102014 <rand_seed>
    rand_seed_set = 1;
  10057d:	c7 05 89 1a 00 00 01 	movl   $0x1,0x1a89(%rip)        # 102010 <rand_seed_set>
  100584:	00 00 00 
}
  100587:	90                   	nop
  100588:	c9                   	leave  
  100589:	c3                   	ret    

000000000010058a <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10058a:	f3 0f 1e fa          	endbr64 
  10058e:	55                   	push   %rbp
  10058f:	48 89 e5             	mov    %rsp,%rbp
  100592:	48 83 ec 28          	sub    $0x28,%rsp
  100596:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10059a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10059e:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1005a1:	48 8d 05 c8 0f 00 00 	lea    0xfc8(%rip),%rax        # 101570 <upper_digits.1>
  1005a8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  1005ac:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1005b0:	79 0e                	jns    1005c0 <fill_numbuf+0x36>
        digits = lower_digits;
  1005b2:	48 8d 05 d7 0f 00 00 	lea    0xfd7(%rip),%rax        # 101590 <lower_digits.0>
  1005b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  1005bd:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1005c0:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1005c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005c9:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1005cc:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1005cf:	48 63 c8             	movslq %eax,%rcx
  1005d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1005d6:	ba 00 00 00 00       	mov    $0x0,%edx
  1005db:	48 f7 f1             	div    %rcx
  1005de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005e2:	48 01 d0             	add    %rdx,%rax
  1005e5:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1005ea:	0f b6 10             	movzbl (%rax),%edx
  1005ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1005f1:	88 10                	mov    %dl,(%rax)
        val /= base;
  1005f3:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1005f6:	48 63 f0             	movslq %eax,%rsi
  1005f9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1005fd:	ba 00 00 00 00       	mov    $0x0,%edx
  100602:	48 f7 f6             	div    %rsi
  100605:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100609:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  10060e:	75 bc                	jne    1005cc <fill_numbuf+0x42>
    return numbuf_end;
  100610:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100614:	c9                   	leave  
  100615:	c3                   	ret    

0000000000100616 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100616:	f3 0f 1e fa          	endbr64 
  10061a:	55                   	push   %rbp
  10061b:	48 89 e5             	mov    %rsp,%rbp
  10061e:	53                   	push   %rbx
  10061f:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100626:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  10062d:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100633:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10063a:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100641:	e9 bd 09 00 00       	jmp    101003 <printer_vprintf+0x9ed>
        if (*format != '%') {
  100646:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10064d:	0f b6 00             	movzbl (%rax),%eax
  100650:	3c 25                	cmp    $0x25,%al
  100652:	74 31                	je     100685 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  100654:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10065b:	4c 8b 00             	mov    (%rax),%r8
  10065e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100665:	0f b6 00             	movzbl (%rax),%eax
  100668:	0f b6 c8             	movzbl %al,%ecx
  10066b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100671:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100678:	89 ce                	mov    %ecx,%esi
  10067a:	48 89 c7             	mov    %rax,%rdi
  10067d:	41 ff d0             	call   *%r8
            continue;
  100680:	e9 76 09 00 00       	jmp    100ffb <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  100685:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  10068c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100693:	01 
  100694:	eb 4d                	jmp    1006e3 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  100696:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10069d:	0f b6 00             	movzbl (%rax),%eax
  1006a0:	0f be c0             	movsbl %al,%eax
  1006a3:	89 c6                	mov    %eax,%esi
  1006a5:	48 8d 05 c4 0d 00 00 	lea    0xdc4(%rip),%rax        # 101470 <flag_chars>
  1006ac:	48 89 c7             	mov    %rax,%rdi
  1006af:	e8 23 fe ff ff       	call   1004d7 <strchr>
  1006b4:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1006b8:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1006bd:	74 34                	je     1006f3 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  1006bf:	48 8d 15 aa 0d 00 00 	lea    0xdaa(%rip),%rdx        # 101470 <flag_chars>
  1006c6:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1006ca:	48 29 d0             	sub    %rdx,%rax
  1006cd:	ba 01 00 00 00       	mov    $0x1,%edx
  1006d2:	89 c1                	mov    %eax,%ecx
  1006d4:	d3 e2                	shl    %cl,%edx
  1006d6:	89 d0                	mov    %edx,%eax
  1006d8:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1006db:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1006e2:	01 
  1006e3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006ea:	0f b6 00             	movzbl (%rax),%eax
  1006ed:	84 c0                	test   %al,%al
  1006ef:	75 a5                	jne    100696 <printer_vprintf+0x80>
  1006f1:	eb 01                	jmp    1006f4 <printer_vprintf+0xde>
            } else {
                break;
  1006f3:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1006f4:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1006fb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100702:	0f b6 00             	movzbl (%rax),%eax
  100705:	3c 30                	cmp    $0x30,%al
  100707:	7e 67                	jle    100770 <printer_vprintf+0x15a>
  100709:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100710:	0f b6 00             	movzbl (%rax),%eax
  100713:	3c 39                	cmp    $0x39,%al
  100715:	7f 59                	jg     100770 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100717:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  10071e:	eb 2e                	jmp    10074e <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  100720:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100723:	89 d0                	mov    %edx,%eax
  100725:	c1 e0 02             	shl    $0x2,%eax
  100728:	01 d0                	add    %edx,%eax
  10072a:	01 c0                	add    %eax,%eax
  10072c:	89 c1                	mov    %eax,%ecx
  10072e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100735:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100739:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100740:	0f b6 00             	movzbl (%rax),%eax
  100743:	0f be c0             	movsbl %al,%eax
  100746:	01 c8                	add    %ecx,%eax
  100748:	83 e8 30             	sub    $0x30,%eax
  10074b:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10074e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100755:	0f b6 00             	movzbl (%rax),%eax
  100758:	3c 2f                	cmp    $0x2f,%al
  10075a:	0f 8e 85 00 00 00    	jle    1007e5 <printer_vprintf+0x1cf>
  100760:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100767:	0f b6 00             	movzbl (%rax),%eax
  10076a:	3c 39                	cmp    $0x39,%al
  10076c:	7e b2                	jle    100720 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  10076e:	eb 75                	jmp    1007e5 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  100770:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100777:	0f b6 00             	movzbl (%rax),%eax
  10077a:	3c 2a                	cmp    $0x2a,%al
  10077c:	75 68                	jne    1007e6 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  10077e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100785:	8b 00                	mov    (%rax),%eax
  100787:	83 f8 2f             	cmp    $0x2f,%eax
  10078a:	77 30                	ja     1007bc <printer_vprintf+0x1a6>
  10078c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100793:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100797:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10079e:	8b 00                	mov    (%rax),%eax
  1007a0:	89 c0                	mov    %eax,%eax
  1007a2:	48 01 d0             	add    %rdx,%rax
  1007a5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007ac:	8b 12                	mov    (%rdx),%edx
  1007ae:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1007b1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007b8:	89 0a                	mov    %ecx,(%rdx)
  1007ba:	eb 1a                	jmp    1007d6 <printer_vprintf+0x1c0>
  1007bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007c3:	48 8b 40 08          	mov    0x8(%rax),%rax
  1007c7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1007cb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1007d2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1007d6:	8b 00                	mov    (%rax),%eax
  1007d8:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1007db:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007e2:	01 
  1007e3:	eb 01                	jmp    1007e6 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  1007e5:	90                   	nop
        }

        // process precision
        int precision = -1;
  1007e6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1007ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007f4:	0f b6 00             	movzbl (%rax),%eax
  1007f7:	3c 2e                	cmp    $0x2e,%al
  1007f9:	0f 85 00 01 00 00    	jne    1008ff <printer_vprintf+0x2e9>
            ++format;
  1007ff:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100806:	01 
            if (*format >= '0' && *format <= '9') {
  100807:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10080e:	0f b6 00             	movzbl (%rax),%eax
  100811:	3c 2f                	cmp    $0x2f,%al
  100813:	7e 67                	jle    10087c <printer_vprintf+0x266>
  100815:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10081c:	0f b6 00             	movzbl (%rax),%eax
  10081f:	3c 39                	cmp    $0x39,%al
  100821:	7f 59                	jg     10087c <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100823:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  10082a:	eb 2e                	jmp    10085a <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  10082c:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  10082f:	89 d0                	mov    %edx,%eax
  100831:	c1 e0 02             	shl    $0x2,%eax
  100834:	01 d0                	add    %edx,%eax
  100836:	01 c0                	add    %eax,%eax
  100838:	89 c1                	mov    %eax,%ecx
  10083a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100841:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100845:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10084c:	0f b6 00             	movzbl (%rax),%eax
  10084f:	0f be c0             	movsbl %al,%eax
  100852:	01 c8                	add    %ecx,%eax
  100854:	83 e8 30             	sub    $0x30,%eax
  100857:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10085a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100861:	0f b6 00             	movzbl (%rax),%eax
  100864:	3c 2f                	cmp    $0x2f,%al
  100866:	0f 8e 85 00 00 00    	jle    1008f1 <printer_vprintf+0x2db>
  10086c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100873:	0f b6 00             	movzbl (%rax),%eax
  100876:	3c 39                	cmp    $0x39,%al
  100878:	7e b2                	jle    10082c <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  10087a:	eb 75                	jmp    1008f1 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  10087c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100883:	0f b6 00             	movzbl (%rax),%eax
  100886:	3c 2a                	cmp    $0x2a,%al
  100888:	75 68                	jne    1008f2 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  10088a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100891:	8b 00                	mov    (%rax),%eax
  100893:	83 f8 2f             	cmp    $0x2f,%eax
  100896:	77 30                	ja     1008c8 <printer_vprintf+0x2b2>
  100898:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10089f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1008a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008aa:	8b 00                	mov    (%rax),%eax
  1008ac:	89 c0                	mov    %eax,%eax
  1008ae:	48 01 d0             	add    %rdx,%rax
  1008b1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008b8:	8b 12                	mov    (%rdx),%edx
  1008ba:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1008bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008c4:	89 0a                	mov    %ecx,(%rdx)
  1008c6:	eb 1a                	jmp    1008e2 <printer_vprintf+0x2cc>
  1008c8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008cf:	48 8b 40 08          	mov    0x8(%rax),%rax
  1008d3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1008d7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008de:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1008e2:	8b 00                	mov    (%rax),%eax
  1008e4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1008e7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008ee:	01 
  1008ef:	eb 01                	jmp    1008f2 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  1008f1:	90                   	nop
            }
            if (precision < 0) {
  1008f2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1008f6:	79 07                	jns    1008ff <printer_vprintf+0x2e9>
                precision = 0;
  1008f8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  1008ff:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100906:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  10090d:	00 
        int length = 0;
  10090e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100915:	48 8d 05 5a 0b 00 00 	lea    0xb5a(%rip),%rax        # 101476 <flag_chars+0x6>
  10091c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  100920:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100927:	0f b6 00             	movzbl (%rax),%eax
  10092a:	0f be c0             	movsbl %al,%eax
  10092d:	83 e8 43             	sub    $0x43,%eax
  100930:	83 f8 37             	cmp    $0x37,%eax
  100933:	0f 87 b6 03 00 00    	ja     100cef <printer_vprintf+0x6d9>
  100939:	89 c0                	mov    %eax,%eax
  10093b:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  100942:	00 
  100943:	48 8d 05 3a 0b 00 00 	lea    0xb3a(%rip),%rax        # 101484 <flag_chars+0x14>
  10094a:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  10094d:	48 98                	cltq   
  10094f:	48 8d 15 2e 0b 00 00 	lea    0xb2e(%rip),%rdx        # 101484 <flag_chars+0x14>
  100956:	48 01 d0             	add    %rdx,%rax
  100959:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  10095c:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100963:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10096a:	01 
            goto again;
  10096b:	eb b3                	jmp    100920 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10096d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100971:	74 5d                	je     1009d0 <printer_vprintf+0x3ba>
  100973:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10097a:	8b 00                	mov    (%rax),%eax
  10097c:	83 f8 2f             	cmp    $0x2f,%eax
  10097f:	77 30                	ja     1009b1 <printer_vprintf+0x39b>
  100981:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100988:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10098c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100993:	8b 00                	mov    (%rax),%eax
  100995:	89 c0                	mov    %eax,%eax
  100997:	48 01 d0             	add    %rdx,%rax
  10099a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009a1:	8b 12                	mov    (%rdx),%edx
  1009a3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009a6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009ad:	89 0a                	mov    %ecx,(%rdx)
  1009af:	eb 1a                	jmp    1009cb <printer_vprintf+0x3b5>
  1009b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009b8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009bc:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009c0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009c7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1009cb:	48 8b 00             	mov    (%rax),%rax
  1009ce:	eb 5c                	jmp    100a2c <printer_vprintf+0x416>
  1009d0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009d7:	8b 00                	mov    (%rax),%eax
  1009d9:	83 f8 2f             	cmp    $0x2f,%eax
  1009dc:	77 30                	ja     100a0e <printer_vprintf+0x3f8>
  1009de:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009e5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f0:	8b 00                	mov    (%rax),%eax
  1009f2:	89 c0                	mov    %eax,%eax
  1009f4:	48 01 d0             	add    %rdx,%rax
  1009f7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009fe:	8b 12                	mov    (%rdx),%edx
  100a00:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a03:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a0a:	89 0a                	mov    %ecx,(%rdx)
  100a0c:	eb 1a                	jmp    100a28 <printer_vprintf+0x412>
  100a0e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a15:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a19:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a1d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a24:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a28:	8b 00                	mov    (%rax),%eax
  100a2a:	48 98                	cltq   
  100a2c:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100a30:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a34:	48 c1 f8 38          	sar    $0x38,%rax
  100a38:	25 80 00 00 00       	and    $0x80,%eax
  100a3d:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100a40:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100a44:	74 09                	je     100a4f <printer_vprintf+0x439>
  100a46:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a4a:	48 f7 d8             	neg    %rax
  100a4d:	eb 04                	jmp    100a53 <printer_vprintf+0x43d>
  100a4f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100a53:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100a57:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100a5a:	83 c8 60             	or     $0x60,%eax
  100a5d:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100a60:	e9 cf 02 00 00       	jmp    100d34 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100a65:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100a69:	74 5d                	je     100ac8 <printer_vprintf+0x4b2>
  100a6b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a72:	8b 00                	mov    (%rax),%eax
  100a74:	83 f8 2f             	cmp    $0x2f,%eax
  100a77:	77 30                	ja     100aa9 <printer_vprintf+0x493>
  100a79:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a80:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a84:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a8b:	8b 00                	mov    (%rax),%eax
  100a8d:	89 c0                	mov    %eax,%eax
  100a8f:	48 01 d0             	add    %rdx,%rax
  100a92:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a99:	8b 12                	mov    (%rdx),%edx
  100a9b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a9e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aa5:	89 0a                	mov    %ecx,(%rdx)
  100aa7:	eb 1a                	jmp    100ac3 <printer_vprintf+0x4ad>
  100aa9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ab0:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ab4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ab8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100abf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ac3:	48 8b 00             	mov    (%rax),%rax
  100ac6:	eb 5c                	jmp    100b24 <printer_vprintf+0x50e>
  100ac8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100acf:	8b 00                	mov    (%rax),%eax
  100ad1:	83 f8 2f             	cmp    $0x2f,%eax
  100ad4:	77 30                	ja     100b06 <printer_vprintf+0x4f0>
  100ad6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100add:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ae1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ae8:	8b 00                	mov    (%rax),%eax
  100aea:	89 c0                	mov    %eax,%eax
  100aec:	48 01 d0             	add    %rdx,%rax
  100aef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100af6:	8b 12                	mov    (%rdx),%edx
  100af8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100afb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b02:	89 0a                	mov    %ecx,(%rdx)
  100b04:	eb 1a                	jmp    100b20 <printer_vprintf+0x50a>
  100b06:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b0d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b11:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b15:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b1c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b20:	8b 00                	mov    (%rax),%eax
  100b22:	89 c0                	mov    %eax,%eax
  100b24:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100b28:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100b2c:	e9 03 02 00 00       	jmp    100d34 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100b31:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100b38:	e9 28 ff ff ff       	jmp    100a65 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100b3d:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100b44:	e9 1c ff ff ff       	jmp    100a65 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100b49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b50:	8b 00                	mov    (%rax),%eax
  100b52:	83 f8 2f             	cmp    $0x2f,%eax
  100b55:	77 30                	ja     100b87 <printer_vprintf+0x571>
  100b57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b5e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b62:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b69:	8b 00                	mov    (%rax),%eax
  100b6b:	89 c0                	mov    %eax,%eax
  100b6d:	48 01 d0             	add    %rdx,%rax
  100b70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b77:	8b 12                	mov    (%rdx),%edx
  100b79:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b7c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b83:	89 0a                	mov    %ecx,(%rdx)
  100b85:	eb 1a                	jmp    100ba1 <printer_vprintf+0x58b>
  100b87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b8e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b92:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b96:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b9d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ba1:	48 8b 00             	mov    (%rax),%rax
  100ba4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100ba8:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100baf:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100bb6:	e9 79 01 00 00       	jmp    100d34 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100bbb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bc2:	8b 00                	mov    (%rax),%eax
  100bc4:	83 f8 2f             	cmp    $0x2f,%eax
  100bc7:	77 30                	ja     100bf9 <printer_vprintf+0x5e3>
  100bc9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bd0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bd4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bdb:	8b 00                	mov    (%rax),%eax
  100bdd:	89 c0                	mov    %eax,%eax
  100bdf:	48 01 d0             	add    %rdx,%rax
  100be2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100be9:	8b 12                	mov    (%rdx),%edx
  100beb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bf5:	89 0a                	mov    %ecx,(%rdx)
  100bf7:	eb 1a                	jmp    100c13 <printer_vprintf+0x5fd>
  100bf9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c00:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c04:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c08:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c0f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c13:	48 8b 00             	mov    (%rax),%rax
  100c16:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100c1a:	e9 15 01 00 00       	jmp    100d34 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100c1f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c26:	8b 00                	mov    (%rax),%eax
  100c28:	83 f8 2f             	cmp    $0x2f,%eax
  100c2b:	77 30                	ja     100c5d <printer_vprintf+0x647>
  100c2d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c34:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c38:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c3f:	8b 00                	mov    (%rax),%eax
  100c41:	89 c0                	mov    %eax,%eax
  100c43:	48 01 d0             	add    %rdx,%rax
  100c46:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c4d:	8b 12                	mov    (%rdx),%edx
  100c4f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c52:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c59:	89 0a                	mov    %ecx,(%rdx)
  100c5b:	eb 1a                	jmp    100c77 <printer_vprintf+0x661>
  100c5d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c64:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c68:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c6c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c73:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c77:	8b 00                	mov    (%rax),%eax
  100c79:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100c7f:	e9 77 03 00 00       	jmp    100ffb <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100c84:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100c88:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100c8c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c93:	8b 00                	mov    (%rax),%eax
  100c95:	83 f8 2f             	cmp    $0x2f,%eax
  100c98:	77 30                	ja     100cca <printer_vprintf+0x6b4>
  100c9a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ca1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ca5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cac:	8b 00                	mov    (%rax),%eax
  100cae:	89 c0                	mov    %eax,%eax
  100cb0:	48 01 d0             	add    %rdx,%rax
  100cb3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cba:	8b 12                	mov    (%rdx),%edx
  100cbc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cbf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cc6:	89 0a                	mov    %ecx,(%rdx)
  100cc8:	eb 1a                	jmp    100ce4 <printer_vprintf+0x6ce>
  100cca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cd1:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cd5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cd9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ce0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ce4:	8b 00                	mov    (%rax),%eax
  100ce6:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100ce9:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100ced:	eb 45                	jmp    100d34 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100cef:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100cf3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100cf7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cfe:	0f b6 00             	movzbl (%rax),%eax
  100d01:	84 c0                	test   %al,%al
  100d03:	74 0c                	je     100d11 <printer_vprintf+0x6fb>
  100d05:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d0c:	0f b6 00             	movzbl (%rax),%eax
  100d0f:	eb 05                	jmp    100d16 <printer_vprintf+0x700>
  100d11:	b8 25 00 00 00       	mov    $0x25,%eax
  100d16:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d19:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100d1d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d24:	0f b6 00             	movzbl (%rax),%eax
  100d27:	84 c0                	test   %al,%al
  100d29:	75 08                	jne    100d33 <printer_vprintf+0x71d>
                format--;
  100d2b:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100d32:	01 
            }
            break;
  100d33:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100d34:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d37:	83 e0 20             	and    $0x20,%eax
  100d3a:	85 c0                	test   %eax,%eax
  100d3c:	74 1e                	je     100d5c <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100d3e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d42:	48 83 c0 18          	add    $0x18,%rax
  100d46:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100d49:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100d4d:	48 89 ce             	mov    %rcx,%rsi
  100d50:	48 89 c7             	mov    %rax,%rdi
  100d53:	e8 32 f8 ff ff       	call   10058a <fill_numbuf>
  100d58:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100d5c:	48 8d 05 13 07 00 00 	lea    0x713(%rip),%rax        # 101476 <flag_chars+0x6>
  100d63:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100d67:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d6a:	83 e0 20             	and    $0x20,%eax
  100d6d:	85 c0                	test   %eax,%eax
  100d6f:	74 51                	je     100dc2 <printer_vprintf+0x7ac>
  100d71:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d74:	83 e0 40             	and    $0x40,%eax
  100d77:	85 c0                	test   %eax,%eax
  100d79:	74 47                	je     100dc2 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100d7b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d7e:	25 80 00 00 00       	and    $0x80,%eax
  100d83:	85 c0                	test   %eax,%eax
  100d85:	74 0d                	je     100d94 <printer_vprintf+0x77e>
                prefix = "-";
  100d87:	48 8d 05 e9 06 00 00 	lea    0x6e9(%rip),%rax        # 101477 <flag_chars+0x7>
  100d8e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100d92:	eb 7d                	jmp    100e11 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100d94:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d97:	83 e0 10             	and    $0x10,%eax
  100d9a:	85 c0                	test   %eax,%eax
  100d9c:	74 0d                	je     100dab <printer_vprintf+0x795>
                prefix = "+";
  100d9e:	48 8d 05 d4 06 00 00 	lea    0x6d4(%rip),%rax        # 101479 <flag_chars+0x9>
  100da5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100da9:	eb 66                	jmp    100e11 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100dab:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dae:	83 e0 08             	and    $0x8,%eax
  100db1:	85 c0                	test   %eax,%eax
  100db3:	74 5c                	je     100e11 <printer_vprintf+0x7fb>
                prefix = " ";
  100db5:	48 8d 05 bf 06 00 00 	lea    0x6bf(%rip),%rax        # 10147b <flag_chars+0xb>
  100dbc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100dc0:	eb 4f                	jmp    100e11 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100dc2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dc5:	83 e0 20             	and    $0x20,%eax
  100dc8:	85 c0                	test   %eax,%eax
  100dca:	74 46                	je     100e12 <printer_vprintf+0x7fc>
  100dcc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dcf:	83 e0 01             	and    $0x1,%eax
  100dd2:	85 c0                	test   %eax,%eax
  100dd4:	74 3c                	je     100e12 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100dd6:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100dda:	74 06                	je     100de2 <printer_vprintf+0x7cc>
  100ddc:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100de0:	75 30                	jne    100e12 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100de2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100de7:	75 0c                	jne    100df5 <printer_vprintf+0x7df>
  100de9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dec:	25 00 01 00 00       	and    $0x100,%eax
  100df1:	85 c0                	test   %eax,%eax
  100df3:	74 1d                	je     100e12 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100df5:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100df9:	75 09                	jne    100e04 <printer_vprintf+0x7ee>
  100dfb:	48 8d 05 7b 06 00 00 	lea    0x67b(%rip),%rax        # 10147d <flag_chars+0xd>
  100e02:	eb 07                	jmp    100e0b <printer_vprintf+0x7f5>
  100e04:	48 8d 05 75 06 00 00 	lea    0x675(%rip),%rax        # 101480 <flag_chars+0x10>
  100e0b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100e0f:	eb 01                	jmp    100e12 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100e11:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100e12:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e16:	78 24                	js     100e3c <printer_vprintf+0x826>
  100e18:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e1b:	83 e0 20             	and    $0x20,%eax
  100e1e:	85 c0                	test   %eax,%eax
  100e20:	75 1a                	jne    100e3c <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100e22:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e25:	48 63 d0             	movslq %eax,%rdx
  100e28:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e2c:	48 89 d6             	mov    %rdx,%rsi
  100e2f:	48 89 c7             	mov    %rax,%rdi
  100e32:	e8 91 f5 ff ff       	call   1003c8 <strnlen>
  100e37:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100e3a:	eb 0f                	jmp    100e4b <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100e3c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e40:	48 89 c7             	mov    %rax,%rdi
  100e43:	e8 4b f5 ff ff       	call   100393 <strlen>
  100e48:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100e4b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e4e:	83 e0 20             	and    $0x20,%eax
  100e51:	85 c0                	test   %eax,%eax
  100e53:	74 20                	je     100e75 <printer_vprintf+0x85f>
  100e55:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e59:	78 1a                	js     100e75 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100e5b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e5e:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100e61:	7e 08                	jle    100e6b <printer_vprintf+0x855>
  100e63:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100e66:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100e69:	eb 05                	jmp    100e70 <printer_vprintf+0x85a>
  100e6b:	b8 00 00 00 00       	mov    $0x0,%eax
  100e70:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100e73:	eb 5c                	jmp    100ed1 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100e75:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e78:	83 e0 20             	and    $0x20,%eax
  100e7b:	85 c0                	test   %eax,%eax
  100e7d:	74 4b                	je     100eca <printer_vprintf+0x8b4>
  100e7f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e82:	83 e0 02             	and    $0x2,%eax
  100e85:	85 c0                	test   %eax,%eax
  100e87:	74 41                	je     100eca <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100e89:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e8c:	83 e0 04             	and    $0x4,%eax
  100e8f:	85 c0                	test   %eax,%eax
  100e91:	75 37                	jne    100eca <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100e93:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100e97:	48 89 c7             	mov    %rax,%rdi
  100e9a:	e8 f4 f4 ff ff       	call   100393 <strlen>
  100e9f:	89 c2                	mov    %eax,%edx
  100ea1:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100ea4:	01 d0                	add    %edx,%eax
  100ea6:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100ea9:	7e 1f                	jle    100eca <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100eab:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100eae:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100eb1:	89 c3                	mov    %eax,%ebx
  100eb3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100eb7:	48 89 c7             	mov    %rax,%rdi
  100eba:	e8 d4 f4 ff ff       	call   100393 <strlen>
  100ebf:	89 c2                	mov    %eax,%edx
  100ec1:	89 d8                	mov    %ebx,%eax
  100ec3:	29 d0                	sub    %edx,%eax
  100ec5:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100ec8:	eb 07                	jmp    100ed1 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100eca:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100ed1:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100ed4:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100ed7:	01 d0                	add    %edx,%eax
  100ed9:	48 63 d8             	movslq %eax,%rbx
  100edc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ee0:	48 89 c7             	mov    %rax,%rdi
  100ee3:	e8 ab f4 ff ff       	call   100393 <strlen>
  100ee8:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100eec:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100eef:	29 d0                	sub    %edx,%eax
  100ef1:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100ef4:	eb 25                	jmp    100f1b <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  100ef6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100efd:	48 8b 08             	mov    (%rax),%rcx
  100f00:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f06:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f0d:	be 20 00 00 00       	mov    $0x20,%esi
  100f12:	48 89 c7             	mov    %rax,%rdi
  100f15:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f17:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100f1b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f1e:	83 e0 04             	and    $0x4,%eax
  100f21:	85 c0                	test   %eax,%eax
  100f23:	75 36                	jne    100f5b <printer_vprintf+0x945>
  100f25:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100f29:	7f cb                	jg     100ef6 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  100f2b:	eb 2e                	jmp    100f5b <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  100f2d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f34:	4c 8b 00             	mov    (%rax),%r8
  100f37:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f3b:	0f b6 00             	movzbl (%rax),%eax
  100f3e:	0f b6 c8             	movzbl %al,%ecx
  100f41:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f47:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f4e:	89 ce                	mov    %ecx,%esi
  100f50:	48 89 c7             	mov    %rax,%rdi
  100f53:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100f56:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100f5b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f5f:	0f b6 00             	movzbl (%rax),%eax
  100f62:	84 c0                	test   %al,%al
  100f64:	75 c7                	jne    100f2d <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  100f66:	eb 25                	jmp    100f8d <printer_vprintf+0x977>
            p->putc(p, '0', color);
  100f68:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f6f:	48 8b 08             	mov    (%rax),%rcx
  100f72:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f78:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f7f:	be 30 00 00 00       	mov    $0x30,%esi
  100f84:	48 89 c7             	mov    %rax,%rdi
  100f87:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100f89:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100f8d:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100f91:	7f d5                	jg     100f68 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  100f93:	eb 32                	jmp    100fc7 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  100f95:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f9c:	4c 8b 00             	mov    (%rax),%r8
  100f9f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100fa3:	0f b6 00             	movzbl (%rax),%eax
  100fa6:	0f b6 c8             	movzbl %al,%ecx
  100fa9:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100faf:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fb6:	89 ce                	mov    %ecx,%esi
  100fb8:	48 89 c7             	mov    %rax,%rdi
  100fbb:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100fbe:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100fc3:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100fc7:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100fcb:	7f c8                	jg     100f95 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  100fcd:	eb 25                	jmp    100ff4 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  100fcf:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fd6:	48 8b 08             	mov    (%rax),%rcx
  100fd9:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fdf:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fe6:	be 20 00 00 00       	mov    $0x20,%esi
  100feb:	48 89 c7             	mov    %rax,%rdi
  100fee:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100ff0:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100ff4:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100ff8:	7f d5                	jg     100fcf <printer_vprintf+0x9b9>
        }
    done: ;
  100ffa:	90                   	nop
    for (; *format; ++format) {
  100ffb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101002:	01 
  101003:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10100a:	0f b6 00             	movzbl (%rax),%eax
  10100d:	84 c0                	test   %al,%al
  10100f:	0f 85 31 f6 ff ff    	jne    100646 <printer_vprintf+0x30>
    }
}
  101015:	90                   	nop
  101016:	90                   	nop
  101017:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10101b:	c9                   	leave  
  10101c:	c3                   	ret    

000000000010101d <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  10101d:	f3 0f 1e fa          	endbr64 
  101021:	55                   	push   %rbp
  101022:	48 89 e5             	mov    %rsp,%rbp
  101025:	48 83 ec 20          	sub    $0x20,%rsp
  101029:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10102d:	89 f0                	mov    %esi,%eax
  10102f:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101032:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101035:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101039:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10103d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101041:	48 8b 40 08          	mov    0x8(%rax),%rax
  101045:	48 8d 15 54 7f fb ff 	lea    -0x480ac(%rip),%rdx        # b8fa0 <console+0xfa0>
  10104c:	48 39 d0             	cmp    %rdx,%rax
  10104f:	72 0f                	jb     101060 <console_putc+0x43>
        cp->cursor = console;
  101051:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101055:	48 8d 15 a4 6f fb ff 	lea    -0x4905c(%rip),%rdx        # b8000 <console>
  10105c:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  101060:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101064:	0f 85 82 00 00 00    	jne    1010ec <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  10106a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10106e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101072:	48 8d 15 87 6f fb ff 	lea    -0x49079(%rip),%rdx        # b8000 <console>
  101079:	48 29 d0             	sub    %rdx,%rax
  10107c:	48 d1 f8             	sar    %rax
  10107f:	48 89 c1             	mov    %rax,%rcx
  101082:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101089:	66 66 66 
  10108c:	48 89 c8             	mov    %rcx,%rax
  10108f:	48 f7 ea             	imul   %rdx
  101092:	48 89 d0             	mov    %rdx,%rax
  101095:	48 c1 f8 05          	sar    $0x5,%rax
  101099:	48 89 ce             	mov    %rcx,%rsi
  10109c:	48 c1 fe 3f          	sar    $0x3f,%rsi
  1010a0:	48 29 f0             	sub    %rsi,%rax
  1010a3:	48 89 c2             	mov    %rax,%rdx
  1010a6:	48 89 d0             	mov    %rdx,%rax
  1010a9:	48 c1 e0 02          	shl    $0x2,%rax
  1010ad:	48 01 d0             	add    %rdx,%rax
  1010b0:	48 c1 e0 04          	shl    $0x4,%rax
  1010b4:	48 29 c1             	sub    %rax,%rcx
  1010b7:	48 89 ca             	mov    %rcx,%rdx
  1010ba:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1010bd:	eb 25                	jmp    1010e4 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  1010bf:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1010c2:	83 c8 20             	or     $0x20,%eax
  1010c5:	89 c6                	mov    %eax,%esi
  1010c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010cb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010cf:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1010d3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1010d7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010db:	89 f2                	mov    %esi,%edx
  1010dd:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1010e0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1010e4:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1010e8:	75 d5                	jne    1010bf <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1010ea:	eb 24                	jmp    101110 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  1010ec:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1010f0:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1010f3:	89 d6                	mov    %edx,%esi
  1010f5:	09 c6                	or     %eax,%esi
  1010f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010fb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010ff:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101103:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101107:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10110b:	89 f2                	mov    %esi,%edx
  10110d:	66 89 10             	mov    %dx,(%rax)
}
  101110:	90                   	nop
  101111:	c9                   	leave  
  101112:	c3                   	ret    

0000000000101113 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101113:	f3 0f 1e fa          	endbr64 
  101117:	55                   	push   %rbp
  101118:	48 89 e5             	mov    %rsp,%rbp
  10111b:	48 83 ec 30          	sub    $0x30,%rsp
  10111f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101122:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101125:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101129:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  10112d:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 10101d <console_putc>
  101134:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101138:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  10113c:	78 09                	js     101147 <console_vprintf+0x34>
  10113e:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101145:	7e 07                	jle    10114e <console_vprintf+0x3b>
        cpos = 0;
  101147:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10114e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101151:	48 98                	cltq   
  101153:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101157:	48 8d 05 a2 6e fb ff 	lea    -0x4915e(%rip),%rax        # b8000 <console>
  10115e:	48 01 d0             	add    %rdx,%rax
  101161:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101165:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101169:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10116d:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101170:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101174:	48 89 c7             	mov    %rax,%rdi
  101177:	e8 9a f4 ff ff       	call   100616 <printer_vprintf>
    return cp.cursor - console;
  10117c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101180:	48 8d 15 79 6e fb ff 	lea    -0x49187(%rip),%rdx        # b8000 <console>
  101187:	48 29 d0             	sub    %rdx,%rax
  10118a:	48 d1 f8             	sar    %rax
}
  10118d:	c9                   	leave  
  10118e:	c3                   	ret    

000000000010118f <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10118f:	f3 0f 1e fa          	endbr64 
  101193:	55                   	push   %rbp
  101194:	48 89 e5             	mov    %rsp,%rbp
  101197:	48 83 ec 60          	sub    $0x60,%rsp
  10119b:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10119e:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1011a1:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1011a5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1011a9:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1011ad:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1011b1:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1011b8:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1011bc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1011c0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1011c4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1011c8:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1011cc:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1011d0:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1011d3:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1011d6:	89 c7                	mov    %eax,%edi
  1011d8:	e8 36 ff ff ff       	call   101113 <console_vprintf>
  1011dd:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1011e0:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1011e3:	c9                   	leave  
  1011e4:	c3                   	ret    

00000000001011e5 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1011e5:	f3 0f 1e fa          	endbr64 
  1011e9:	55                   	push   %rbp
  1011ea:	48 89 e5             	mov    %rsp,%rbp
  1011ed:	48 83 ec 20          	sub    $0x20,%rsp
  1011f1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1011f5:	89 f0                	mov    %esi,%eax
  1011f7:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1011fa:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1011fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101201:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101205:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101209:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10120d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101211:	48 8b 40 10          	mov    0x10(%rax),%rax
  101215:	48 39 c2             	cmp    %rax,%rdx
  101218:	73 1a                	jae    101234 <string_putc+0x4f>
        *sp->s++ = c;
  10121a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10121e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101222:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101226:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10122a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10122e:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101232:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101234:	90                   	nop
  101235:	c9                   	leave  
  101236:	c3                   	ret    

0000000000101237 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101237:	f3 0f 1e fa          	endbr64 
  10123b:	55                   	push   %rbp
  10123c:	48 89 e5             	mov    %rsp,%rbp
  10123f:	48 83 ec 40          	sub    $0x40,%rsp
  101243:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101247:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10124b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10124f:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101253:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 1011e5 <string_putc>
  10125a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  10125e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101262:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101266:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  10126b:	74 33                	je     1012a0 <vsnprintf+0x69>
        sp.end = s + size - 1;
  10126d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101271:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101275:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101279:	48 01 d0             	add    %rdx,%rax
  10127c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101280:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101284:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101288:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  10128c:	be 00 00 00 00       	mov    $0x0,%esi
  101291:	48 89 c7             	mov    %rax,%rdi
  101294:	e8 7d f3 ff ff       	call   100616 <printer_vprintf>
        *sp.s = 0;
  101299:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10129d:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1012a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1012a4:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1012a8:	c9                   	leave  
  1012a9:	c3                   	ret    

00000000001012aa <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1012aa:	f3 0f 1e fa          	endbr64 
  1012ae:	55                   	push   %rbp
  1012af:	48 89 e5             	mov    %rsp,%rbp
  1012b2:	48 83 ec 70          	sub    $0x70,%rsp
  1012b6:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1012ba:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1012be:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1012c2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1012c6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1012ca:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1012ce:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1012d5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1012d9:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1012dd:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1012e1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1012e5:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1012e9:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1012ed:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1012f1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1012f5:	48 89 c7             	mov    %rax,%rdi
  1012f8:	e8 3a ff ff ff       	call   101237 <vsnprintf>
  1012fd:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101300:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101303:	c9                   	leave  
  101304:	c3                   	ret    

0000000000101305 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101305:	f3 0f 1e fa          	endbr64 
  101309:	55                   	push   %rbp
  10130a:	48 89 e5             	mov    %rsp,%rbp
  10130d:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101311:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101318:	eb 1a                	jmp    101334 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  10131a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10131d:	48 98                	cltq   
  10131f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101323:	48 8d 05 d6 6c fb ff 	lea    -0x4932a(%rip),%rax        # b8000 <console>
  10132a:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101330:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101334:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  10133b:	7e dd                	jle    10131a <console_clear+0x15>
    }
    cursorpos = 0;
  10133d:	c7 05 b5 7c fb ff 00 	movl   $0x0,-0x4834b(%rip)        # b8ffc <cursorpos>
  101344:	00 00 00 
}
  101347:	90                   	nop
  101348:	c9                   	leave  
  101349:	c3                   	ret    
