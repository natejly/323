
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t *heap_bottom;
uint8_t *stack_bottom;



void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	41 54                	push   %r12
  10000a:	53                   	push   %rbx

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000b:	cd 31                	int    $0x31
  10000d:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  10000f:	e8 7c 09 00 00       	call   100990 <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100014:	48 8d 05 1c 40 00 00 	lea    0x401c(%rip),%rax        # 104037 <end+0xfff>
  10001b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100021:	48 89 05 e8 1f 00 00 	mov    %rax,0x1fe8(%rip)        # 102010 <heap_top>
  100028:	48 89 05 d9 1f 00 00 	mov    %rax,0x1fd9(%rip)        # 102008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10002f:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100032:	48 83 e8 01          	sub    $0x1,%rax
  100036:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10003c:	48 89 05 bd 1f 00 00 	mov    %rax,0x1fbd(%rip)        # 102000 <stack_bottom>

    void *ptr;

    /* Single elements on heap of varying sizes */
    for(int i = 0; i < 512; ++i) {
        ptr = malloc(i);
  100043:	bf 00 00 00 00       	mov    $0x0,%edi
  100048:	e8 ba 04 00 00       	call   100507 <malloc>
  10004d:	48 89 c7             	mov    %rax,%rdi
  100050:	bb 01 00 00 00       	mov    $0x1,%ebx
        assert(ptr != NULL || i == 0);
        assert((uintptr_t)ptr % 8 == 0);
  100055:	49 89 fc             	mov    %rdi,%r12
  100058:	41 83 e4 07          	and    $0x7,%r12d
  10005c:	75 44                	jne    1000a2 <process_main+0xa2>
        free(ptr);
  10005e:	e8 93 04 00 00       	call   1004f6 <free>
    for(int i = 0; i < 512; ++i) {
  100063:	48 81 fb 00 02 00 00 	cmp    $0x200,%rbx
  10006a:	74 4e                	je     1000ba <process_main+0xba>
        ptr = malloc(i);
  10006c:	48 89 df             	mov    %rbx,%rdi
  10006f:	e8 93 04 00 00       	call   100507 <malloc>
  100074:	48 89 c7             	mov    %rax,%rdi
        assert(ptr != NULL || i == 0);
  100077:	48 85 c0             	test   %rax,%rax
  10007a:	0f 94 c2             	sete   %dl
  10007d:	85 db                	test   %ebx,%ebx
  10007f:	0f 95 c0             	setne  %al
  100082:	48 83 c3 01          	add    $0x1,%rbx
  100086:	84 c2                	test   %al,%dl
  100088:	74 cb                	je     100055 <process_main+0x55>
  10008a:	48 8d 15 ef 16 00 00 	lea    0x16ef(%rip),%rdx        # 101780 <console_clear+0x50>
  100091:	be 1a 00 00 00       	mov    $0x1a,%esi
  100096:	48 8d 3d f9 16 00 00 	lea    0x16f9(%rip),%rdi        # 101796 <console_clear+0x66>
  10009d:	e8 52 03 00 00       	call   1003f4 <assert_fail>
        assert((uintptr_t)ptr % 8 == 0);
  1000a2:	48 8d 15 fd 16 00 00 	lea    0x16fd(%rip),%rdx        # 1017a6 <console_clear+0x76>
  1000a9:	be 1b 00 00 00       	mov    $0x1b,%esi
  1000ae:	48 8d 3d e1 16 00 00 	lea    0x16e1(%rip),%rdi        # 101796 <console_clear+0x66>
  1000b5:	e8 3a 03 00 00       	call   1003f4 <assert_fail>

    /* Many things allocated at the same time */
    static char *ptrs[512];

    for(size_t i = 0; i < sizeof(ptrs)/sizeof(ptrs[0]); ++i) {
        ptrs[i] = (char *) malloc(i+1);
  1000ba:	48 8d 1d 57 1f 00 00 	lea    0x1f57(%rip),%rbx        # 102018 <heap_top+0x8>
  1000c1:	49 83 c4 01          	add    $0x1,%r12
  1000c5:	4c 89 e7             	mov    %r12,%rdi
  1000c8:	e8 3a 04 00 00       	call   100507 <malloc>
  1000cd:	4a 89 04 e3          	mov    %rax,(%rbx,%r12,8)
        assert(ptrs[i] != NULL);
  1000d1:	48 85 c0             	test   %rax,%rax
  1000d4:	0f 84 8e 00 00 00    	je     100168 <process_main+0x168>
        assert((uintptr_t)ptrs[i] % 8 == 0);
  1000da:	a8 07                	test   $0x7,%al
  1000dc:	0f 85 9e 00 00 00    	jne    100180 <process_main+0x180>
    for(size_t i = 0; i < sizeof(ptrs)/sizeof(ptrs[0]); ++i) {
  1000e2:	49 81 fc 00 02 00 00 	cmp    $0x200,%r12
  1000e9:	75 d6                	jne    1000c1 <process_main+0xc1>
  1000eb:	48 8d 1d 2e 1f 00 00 	lea    0x1f2e(%rip),%rbx        # 102020 <ptrs.0>
  1000f2:	4c 8d a3 00 10 00 00 	lea    0x1000(%rbx),%r12
    }

    for(size_t i = 0; i < sizeof(ptrs)/sizeof(ptrs[0]); ++i) {
        free((void *)ptrs[i]);
  1000f9:	48 8b 3b             	mov    (%rbx),%rdi
  1000fc:	e8 f5 03 00 00       	call   1004f6 <free>
    for(size_t i = 0; i < sizeof(ptrs)/sizeof(ptrs[0]); ++i) {
  100101:	48 83 c3 08          	add    $0x8,%rbx
  100105:	4c 39 e3             	cmp    %r12,%rbx
  100108:	75 ef                	jne    1000f9 <process_main+0xf9>
    }

    /* Single elements on heap of varying sizes,
     * in reverse size order, leading to small splitting of free blocks. */
    for(size_t i = 4096; i > 0; --i) {
  10010a:	bb 00 10 00 00       	mov    $0x1000,%ebx
        ptr = malloc(i);
  10010f:	48 89 df             	mov    %rbx,%rdi
  100112:	e8 f0 03 00 00       	call   100507 <malloc>
  100117:	48 89 c7             	mov    %rax,%rdi
        assert(ptr != NULL);
  10011a:	48 85 c0             	test   %rax,%rax
  10011d:	74 79                	je     100198 <process_main+0x198>
        assert((uintptr_t)ptr % 8 == 0);
  10011f:	a8 07                	test   $0x7,%al
  100121:	0f 85 89 00 00 00    	jne    1001b0 <process_main+0x1b0>

        /* Check that we can write */
        free(ptr);
  100127:	e8 ca 03 00 00       	call   1004f6 <free>
    for(size_t i = 4096; i > 0; --i) {
  10012c:	48 83 eb 01          	sub    $0x1,%rbx
  100130:	75 dd                	jne    10010f <process_main+0x10f>
    }

    ptr = malloc(25);
  100132:	bf 19 00 00 00       	mov    $0x19,%edi
  100137:	e8 cb 03 00 00       	call   100507 <malloc>
  10013c:	48 89 c7             	mov    %rax,%rdi
    assert(ptr != NULL);
  10013f:	48 85 c0             	test   %rax,%rax
  100142:	0f 84 80 00 00 00    	je     1001c8 <process_main+0x1c8>
    assert((uintptr_t)ptr % 8 == 0);
  100148:	a8 07                	test   $0x7,%al
  10014a:	0f 84 90 00 00 00    	je     1001e0 <process_main+0x1e0>
  100150:	48 8d 15 4f 16 00 00 	lea    0x164f(%rip),%rdx        # 1017a6 <console_clear+0x76>
  100157:	be 39 00 00 00       	mov    $0x39,%esi
  10015c:	48 8d 3d 33 16 00 00 	lea    0x1633(%rip),%rdi        # 101796 <console_clear+0x66>
  100163:	e8 8c 02 00 00       	call   1003f4 <assert_fail>
        assert(ptrs[i] != NULL);
  100168:	48 8d 15 4f 16 00 00 	lea    0x164f(%rip),%rdx        # 1017be <console_clear+0x8e>
  10016f:	be 24 00 00 00       	mov    $0x24,%esi
  100174:	48 8d 3d 1b 16 00 00 	lea    0x161b(%rip),%rdi        # 101796 <console_clear+0x66>
  10017b:	e8 74 02 00 00       	call   1003f4 <assert_fail>
        assert((uintptr_t)ptrs[i] % 8 == 0);
  100180:	48 8d 15 47 16 00 00 	lea    0x1647(%rip),%rdx        # 1017ce <console_clear+0x9e>
  100187:	be 25 00 00 00       	mov    $0x25,%esi
  10018c:	48 8d 3d 03 16 00 00 	lea    0x1603(%rip),%rdi        # 101796 <console_clear+0x66>
  100193:	e8 5c 02 00 00       	call   1003f4 <assert_fail>
        assert(ptr != NULL);
  100198:	48 8d 15 4b 16 00 00 	lea    0x164b(%rip),%rdx        # 1017ea <console_clear+0xba>
  10019f:	be 30 00 00 00       	mov    $0x30,%esi
  1001a4:	48 8d 3d eb 15 00 00 	lea    0x15eb(%rip),%rdi        # 101796 <console_clear+0x66>
  1001ab:	e8 44 02 00 00       	call   1003f4 <assert_fail>
        assert((uintptr_t)ptr % 8 == 0);
  1001b0:	48 8d 15 ef 15 00 00 	lea    0x15ef(%rip),%rdx        # 1017a6 <console_clear+0x76>
  1001b7:	be 31 00 00 00       	mov    $0x31,%esi
  1001bc:	48 8d 3d d3 15 00 00 	lea    0x15d3(%rip),%rdi        # 101796 <console_clear+0x66>
  1001c3:	e8 2c 02 00 00       	call   1003f4 <assert_fail>
    assert(ptr != NULL);
  1001c8:	48 8d 15 1b 16 00 00 	lea    0x161b(%rip),%rdx        # 1017ea <console_clear+0xba>
  1001cf:	be 38 00 00 00       	mov    $0x38,%esi
  1001d4:	48 8d 3d bb 15 00 00 	lea    0x15bb(%rip),%rdi        # 101796 <console_clear+0x66>
  1001db:	e8 14 02 00 00       	call   1003f4 <assert_fail>

    ptr = realloc(ptr, 25000);
  1001e0:	be a8 61 00 00       	mov    $0x61a8,%esi
  1001e5:	e8 b3 03 00 00       	call   10059d <realloc>
  1001ea:	48 89 c7             	mov    %rax,%rdi
    assert(ptr != NULL);
  1001ed:	48 85 c0             	test   %rax,%rax
  1001f0:	74 1c                	je     10020e <process_main+0x20e>
    assert((uintptr_t)ptr % 8 == 0);
  1001f2:	a8 07                	test   $0x7,%al
  1001f4:	74 30                	je     100226 <process_main+0x226>
  1001f6:	48 8d 15 a9 15 00 00 	lea    0x15a9(%rip),%rdx        # 1017a6 <console_clear+0x76>
  1001fd:	be 3d 00 00 00       	mov    $0x3d,%esi
  100202:	48 8d 3d 8d 15 00 00 	lea    0x158d(%rip),%rdi        # 101796 <console_clear+0x66>
  100209:	e8 e6 01 00 00       	call   1003f4 <assert_fail>
    assert(ptr != NULL);
  10020e:	48 8d 15 d5 15 00 00 	lea    0x15d5(%rip),%rdx        # 1017ea <console_clear+0xba>
  100215:	be 3c 00 00 00       	mov    $0x3c,%esi
  10021a:	48 8d 3d 75 15 00 00 	lea    0x1575(%rip),%rdi        # 101796 <console_clear+0x66>
  100221:	e8 ce 01 00 00       	call   1003f4 <assert_fail>

    free(ptr);
  100226:	e8 cb 02 00 00       	call   1004f6 <free>

    ptr = calloc(10,10);
  10022b:	be 0a 00 00 00       	mov    $0xa,%esi
  100230:	bf 0a 00 00 00       	mov    $0xa,%edi
  100235:	e8 2c 03 00 00       	call   100566 <calloc>
    assert(ptr != NULL);
  10023a:	48 85 c0             	test   %rax,%rax
  10023d:	74 1c                	je     10025b <process_main+0x25b>
    assert((uintptr_t)ptr % 8 == 0);
  10023f:	a8 07                	test   $0x7,%al
  100241:	74 30                	je     100273 <process_main+0x273>
  100243:	48 8d 15 5c 15 00 00 	lea    0x155c(%rip),%rdx        # 1017a6 <console_clear+0x76>
  10024a:	be 43 00 00 00       	mov    $0x43,%esi
  10024f:	48 8d 3d 40 15 00 00 	lea    0x1540(%rip),%rdi        # 101796 <console_clear+0x66>
  100256:	e8 99 01 00 00       	call   1003f4 <assert_fail>
    assert(ptr != NULL);
  10025b:	48 8d 15 88 15 00 00 	lea    0x1588(%rip),%rdx        # 1017ea <console_clear+0xba>
  100262:	be 42 00 00 00       	mov    $0x42,%esi
  100267:	48 8d 3d 28 15 00 00 	lea    0x1528(%rip),%rdi        # 101796 <console_clear+0x66>
  10026e:	e8 81 01 00 00       	call   1003f4 <assert_fail>

    TEST_PASS();
  100273:	48 8d 3d 7c 15 00 00 	lea    0x157c(%rip),%rdi        # 1017f6 <console_clear+0xc6>
  10027a:	b8 00 00 00 00       	mov    $0x0,%eax
  10027f:	e8 98 00 00 00       	call   10031c <kernel_panic>

0000000000100284 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100284:	f3 0f 1e fa          	endbr64 
  100288:	55                   	push   %rbp
  100289:	48 89 e5             	mov    %rsp,%rbp
  10028c:	48 83 ec 50          	sub    $0x50,%rsp
  100290:	49 89 f2             	mov    %rsi,%r10
  100293:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100297:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10029b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10029f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1002a3:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  1002a8:	85 ff                	test   %edi,%edi
  1002aa:	78 32                	js     1002de <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1002ac:	48 63 ff             	movslq %edi,%rdi
  1002af:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1002b6:	cc cc cc 
  1002b9:	48 89 f8             	mov    %rdi,%rax
  1002bc:	48 f7 e2             	mul    %rdx
  1002bf:	48 89 d0             	mov    %rdx,%rax
  1002c2:	48 c1 e8 02          	shr    $0x2,%rax
  1002c6:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1002ca:	48 01 c2             	add    %rax,%rdx
  1002cd:	48 29 d7             	sub    %rdx,%rdi
  1002d0:	48 8d 05 6e 15 00 00 	lea    0x156e(%rip),%rax        # 101845 <col.0>
  1002d7:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  1002db:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1002de:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1002e5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1002e9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1002ed:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1002f1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1002f5:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1002f9:	4c 89 d2             	mov    %r10,%rdx
  1002fc:	8b 3d fa 8c fb ff    	mov    -0x47306(%rip),%edi        # b8ffc <cursorpos>
  100302:	e8 37 12 00 00       	call   10153e <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100307:	3d 30 07 00 00       	cmp    $0x730,%eax
  10030c:	ba 00 00 00 00       	mov    $0x0,%edx
  100311:	0f 4d c2             	cmovge %edx,%eax
  100314:	89 05 e2 8c fb ff    	mov    %eax,-0x4731e(%rip)        # b8ffc <cursorpos>
    }
}
  10031a:	c9                   	leave  
  10031b:	c3                   	ret    

000000000010031c <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  10031c:	f3 0f 1e fa          	endbr64 
  100320:	55                   	push   %rbp
  100321:	48 89 e5             	mov    %rsp,%rbp
  100324:	53                   	push   %rbx
  100325:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  10032c:	48 89 fb             	mov    %rdi,%rbx
  10032f:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100333:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100337:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  10033b:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  10033f:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100343:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  10034a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10034e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100352:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100356:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  10035a:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100361:	ba 07 00 00 00       	mov    $0x7,%edx
  100366:	48 8d 35 a4 14 00 00 	lea    0x14a4(%rip),%rsi        # 101811 <console_clear+0xe1>
  10036d:	e8 03 03 00 00       	call   100675 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100372:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100376:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  10037d:	48 89 da             	mov    %rbx,%rdx
  100380:	be 99 00 00 00       	mov    $0x99,%esi
  100385:	e8 d8 12 00 00       	call   101662 <vsnprintf>
  10038a:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  10038d:	85 d2                	test   %edx,%edx
  10038f:	7e 0f                	jle    1003a0 <kernel_panic+0x84>
  100391:	83 c0 06             	add    $0x6,%eax
  100394:	48 98                	cltq   
  100396:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  10039d:	0a 
  10039e:	75 2c                	jne    1003cc <kernel_panic+0xb0>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1003a0:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1003a7:	48 89 d9             	mov    %rbx,%rcx
  1003aa:	48 8d 15 6a 14 00 00 	lea    0x146a(%rip),%rdx        # 10181b <console_clear+0xeb>
  1003b1:	be 00 c0 00 00       	mov    $0xc000,%esi
  1003b6:	bf 30 07 00 00       	mov    $0x730,%edi
  1003bb:	b8 00 00 00 00       	mov    $0x0,%eax
  1003c0:	e8 f5 11 00 00       	call   1015ba <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  1003c5:	48 89 df             	mov    %rbx,%rdi
  1003c8:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  1003ca:	eb fe                	jmp    1003ca <kernel_panic+0xae>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1003cc:	48 63 c2             	movslq %edx,%rax
  1003cf:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1003d5:	0f 94 c2             	sete   %dl
  1003d8:	0f b6 d2             	movzbl %dl,%edx
  1003db:	48 29 d0             	sub    %rdx,%rax
  1003de:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1003e5:	ff 
  1003e6:	48 8d 35 2c 14 00 00 	lea    0x142c(%rip),%rsi        # 101819 <console_clear+0xe9>
  1003ed:	e8 44 04 00 00       	call   100836 <strcpy>
  1003f2:	eb ac                	jmp    1003a0 <kernel_panic+0x84>

00000000001003f4 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1003f4:	f3 0f 1e fa          	endbr64 
  1003f8:	55                   	push   %rbp
  1003f9:	48 89 e5             	mov    %rsp,%rbp
  1003fc:	48 89 f9             	mov    %rdi,%rcx
  1003ff:	41 89 f0             	mov    %esi,%r8d
  100402:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100405:	48 8d 15 14 14 00 00 	lea    0x1414(%rip),%rdx        # 101820 <console_clear+0xf0>
  10040c:	be 00 c0 00 00       	mov    $0xc000,%esi
  100411:	bf 30 07 00 00       	mov    $0x730,%edi
  100416:	b8 00 00 00 00       	mov    $0x0,%eax
  10041b:	e8 9a 11 00 00       	call   1015ba <console_printf>
    asm volatile ("int %0" : /* no result */
  100420:	bf 00 00 00 00       	mov    $0x0,%edi
  100425:	cd 30                	int    $0x30
 loop: goto loop;
  100427:	eb fe                	jmp    100427 <assert_fail+0x33>

0000000000100429 <algn>:
block* find_block(size_t size);
block* new_block(size_t size);
block* split_block(block* block, size_t size);


size_t algn(size_t size){
  100429:	f3 0f 1e fa          	endbr64 
    return (size + 7) / 8 * 8;
  10042d:	48 8d 47 07          	lea    0x7(%rdi),%rax
  100431:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
}
  100435:	c3                   	ret    

0000000000100436 <new_block>:
block* new_block(size_t size){
  100436:	f3 0f 1e fa          	endbr64 
  10043a:	48 89 fa             	mov    %rdi,%rdx
    // get program break
    void *bptr = sbrk(size + BLOCKSIZE);
  10043d:	48 8d 7f 18          	lea    0x18(%rdi),%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100441:	cd 3a                	int    $0x3a
  100443:	48 89 05 d6 2b 00 00 	mov    %rax,0x2bd6(%rip)        # 103020 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  10044a:	48 89 c6             	mov    %rax,%rsi
    if (bptr == (void*) -1) {
  10044d:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100451:	74 3b                	je     10048e <new_block+0x58>
    return NULL;
    }
    block* nblock = (block*)bptr;
    // add to linked list 

    nblock->next = NULL;
  100453:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  10045a:	00 
    nblock->size = size;
  10045b:	48 89 10             	mov    %rdx,(%rax)
    nblock->free = 0;
  10045e:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
    // add to linked list 
    if (head == NULL) {
  100465:	48 8b 15 bc 2b 00 00 	mov    0x2bbc(%rip),%rdx        # 103028 <head>
  10046c:	48 85 d2             	test   %rdx,%rdx
  10046f:	74 14                	je     100485 <new_block+0x4f>
        head = nblock;
    } else {
        block *curr = head;
        while (curr->next != NULL) {
  100471:	48 89 d1             	mov    %rdx,%rcx
  100474:	48 8b 52 08          	mov    0x8(%rdx),%rdx
  100478:	48 85 d2             	test   %rdx,%rdx
  10047b:	75 f4                	jne    100471 <new_block+0x3b>
            curr = curr->next;
        }
        curr->next = nblock;
  10047d:	48 89 41 08          	mov    %rax,0x8(%rcx)
    }
    return nblock;
}
  100481:	48 89 f0             	mov    %rsi,%rax
  100484:	c3                   	ret    
        head = nblock;
  100485:	48 89 05 9c 2b 00 00 	mov    %rax,0x2b9c(%rip)        # 103028 <head>
  10048c:	eb f3                	jmp    100481 <new_block+0x4b>
    return NULL;
  10048e:	be 00 00 00 00       	mov    $0x0,%esi
  100493:	eb ec                	jmp    100481 <new_block+0x4b>

0000000000100495 <find_block>:
block* find_block(size_t size) {
  100495:	f3 0f 1e fa          	endbr64 
    block* curr = head;
  100499:	48 8b 05 88 2b 00 00 	mov    0x2b88(%rip),%rax        # 103028 <head>
    while (curr) {
  1004a0:	48 85 c0             	test   %rax,%rax
  1004a3:	75 0b                	jne    1004b0 <find_block+0x1b>
  1004a5:	eb 14                	jmp    1004bb <find_block+0x26>
        if (curr->free && curr->size >= size) {
            return curr;
        }
        curr = curr->next;
  1004a7:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (curr) {
  1004ab:	48 85 c0             	test   %rax,%rax
  1004ae:	74 0b                	je     1004bb <find_block+0x26>
        if (curr->free && curr->size >= size) {
  1004b0:	83 78 10 00          	cmpl   $0x0,0x10(%rax)
  1004b4:	74 f1                	je     1004a7 <find_block+0x12>
  1004b6:	48 39 38             	cmp    %rdi,(%rax)
  1004b9:	72 ec                	jb     1004a7 <find_block+0x12>
    }
    return NULL;
}
  1004bb:	c3                   	ret    

00000000001004bc <split_block>:

block* split_block(block* b, size_t size){
  1004bc:	f3 0f 1e fa          	endbr64 
    if(b->size < size + BLOCKSIZE){
  1004c0:	48 8b 17             	mov    (%rdi),%rdx
  1004c3:	48 8d 46 18          	lea    0x18(%rsi),%rax
  1004c7:	48 39 c2             	cmp    %rax,%rdx
  1004ca:	72 24                	jb     1004f0 <split_block+0x34>
        return NULL;
    }
    void* nptr = (void*)b + BLOCKSIZE + size;
  1004cc:	48 01 f8             	add    %rdi,%rax
    block *new = (block*)nptr;

    new->size = b->size - size - BLOCKSIZE;
  1004cf:	48 29 f2             	sub    %rsi,%rdx
  1004d2:	48 8d 52 e8          	lea    -0x18(%rdx),%rdx
  1004d6:	48 89 10             	mov    %rdx,(%rax)
    new->next = b->next;
  1004d9:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1004dd:	48 89 50 08          	mov    %rdx,0x8(%rax)
    new->free = 1; // New block is free
  1004e1:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%rax)

    // Update the original block
    b->size = size;
  1004e8:	48 89 37             	mov    %rsi,(%rdi)
    b->next = new;
  1004eb:	48 89 47 08          	mov    %rax,0x8(%rdi)

    return new;
  1004ef:	c3                   	ret    
        return NULL;
  1004f0:	b8 00 00 00 00       	mov    $0x0,%eax

}
  1004f5:	c3                   	ret    

00000000001004f6 <free>:


void free(void *firstbyte) {
  1004f6:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  1004fa:	48 85 ff             	test   %rdi,%rdi
  1004fd:	74 07                	je     100506 <free+0x10>
    return;
  }
      block *b = (block *)((char *)firstbyte - BLOCKSIZE);

    // Mark the block as free
    b->free = 1;
  1004ff:	c7 47 f8 01 00 00 00 	movl   $0x1,-0x8(%rdi)
  

}
  100506:	c3                   	ret    

0000000000100507 <malloc>:

void *malloc(uint64_t numbytes) {
  100507:	f3 0f 1e fa          	endbr64 
  10050b:	55                   	push   %rbp
  10050c:	48 89 e5             	mov    %rsp,%rbp
  10050f:	41 54                	push   %r12
  100511:	53                   	push   %rbx
    return (size + 7) / 8 * 8;
  100512:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  100516:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    size_t size = algn(numbytes);
    block *b = find_block(size);
  10051a:	4c 89 e7             	mov    %r12,%rdi
  10051d:	e8 73 ff ff ff       	call   100495 <find_block>
    if (b == NULL){
  100522:	48 85 c0             	test   %rax,%rax
  100525:	74 20                	je     100547 <malloc+0x40>
  100527:	48 89 c3             	mov    %rax,%rbx
        if (b==NULL){
            //alloc fail
            return NULL;
        }
    } else {
        b->free = 0;
  10052a:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
        // check split
        if (b->size > size + BLOCKSIZE) {
  100531:	49 8d 44 24 18       	lea    0x18(%r12),%rax
  100536:	48 39 03             	cmp    %rax,(%rbx)
  100539:	77 1e                	ja     100559 <malloc+0x52>
            split_block(b, size);
        }
    }
    return (void*)((void*)b + BLOCKSIZE);
  10053b:	48 83 c3 18          	add    $0x18,%rbx

}
  10053f:	48 89 d8             	mov    %rbx,%rax
  100542:	5b                   	pop    %rbx
  100543:	41 5c                	pop    %r12
  100545:	5d                   	pop    %rbp
  100546:	c3                   	ret    
        b = new_block(size);
  100547:	4c 89 e7             	mov    %r12,%rdi
  10054a:	e8 e7 fe ff ff       	call   100436 <new_block>
  10054f:	48 89 c3             	mov    %rax,%rbx
        if (b==NULL){
  100552:	48 85 c0             	test   %rax,%rax
  100555:	75 e4                	jne    10053b <malloc+0x34>
  100557:	eb e6                	jmp    10053f <malloc+0x38>
            split_block(b, size);
  100559:	4c 89 e6             	mov    %r12,%rsi
  10055c:	48 89 df             	mov    %rbx,%rdi
  10055f:	e8 58 ff ff ff       	call   1004bc <split_block>
  100564:	eb d5                	jmp    10053b <malloc+0x34>

0000000000100566 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  100566:	f3 0f 1e fa          	endbr64 
  10056a:	55                   	push   %rbp
  10056b:	48 89 e5             	mov    %rsp,%rbp
  10056e:	41 54                	push   %r12
  100570:	53                   	push   %rbx
    uint64_t total = num * sz;
  100571:	48 0f af fe          	imul   %rsi,%rdi
  100575:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  100578:	e8 8a ff ff ff       	call   100507 <malloc>
  10057d:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  100580:	48 85 c0             	test   %rax,%rax
  100583:	74 10                	je     100595 <calloc+0x2f>
        memset(ptr, 0, total);
  100585:	4c 89 e2             	mov    %r12,%rdx
  100588:	be 00 00 00 00       	mov    $0x0,%esi
  10058d:	48 89 c7             	mov    %rax,%rdi
  100590:	e8 e6 01 00 00       	call   10077b <memset>
    }
    return ptr;
}
  100595:	48 89 d8             	mov    %rbx,%rax
  100598:	5b                   	pop    %rbx
  100599:	41 5c                	pop    %r12
  10059b:	5d                   	pop    %rbp
  10059c:	c3                   	ret    

000000000010059d <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  10059d:	f3 0f 1e fa          	endbr64 
  1005a1:	55                   	push   %rbp
  1005a2:	48 89 e5             	mov    %rsp,%rbp
  1005a5:	41 54                	push   %r12
  1005a7:	53                   	push   %rbx
  1005a8:	48 89 fb             	mov    %rdi,%rbx
  1005ab:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  1005ae:	48 85 db             	test   %rbx,%rbx
  1005b1:	74 2d                	je     1005e0 <realloc+0x43>
        return malloc(sz); // Equivalent to malloc if `ptr` is NULL
    }

    if (sz == 0) {
  1005b3:	48 85 f6             	test   %rsi,%rsi
  1005b6:	74 32                	je     1005ea <realloc+0x4d>
    return (size + 7) / 8 * 8;
  1005b8:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  1005bc:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi

    block *b = (block*)((void*)ptr - BLOCKSIZE); // Get the block metadata
    size_t aligned_size = algn(sz);

    // If the current block is already large enough
    if (b->size >= aligned_size) {
  1005c0:	48 8b 43 e8          	mov    -0x18(%rbx),%rax
  1005c4:	48 39 f0             	cmp    %rsi,%rax
  1005c7:	72 31                	jb     1005fa <realloc+0x5d>
        // Split the block if it has excess space
        if (b->size > aligned_size + BLOCKSIZE) {
  1005c9:	48 8d 56 18          	lea    0x18(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr; // Return the same pointer if resizing in place
  1005cd:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  1005d0:	48 39 d0             	cmp    %rdx,%rax
  1005d3:	76 49                	jbe    10061e <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE); // Get the block metadata
  1005d5:	48 8d 7b e8          	lea    -0x18(%rbx),%rdi
            split_block(b, aligned_size);
  1005d9:	e8 de fe ff ff       	call   1004bc <split_block>
  1005de:	eb 3e                	jmp    10061e <realloc+0x81>
        return malloc(sz); // Equivalent to malloc if `ptr` is NULL
  1005e0:	e8 22 ff ff ff       	call   100507 <malloc>
  1005e5:	49 89 c4             	mov    %rax,%r12
  1005e8:	eb 34                	jmp    10061e <realloc+0x81>
        free(ptr); // Equivalent to free if size is 0
  1005ea:	48 89 df             	mov    %rbx,%rdi
  1005ed:	e8 04 ff ff ff       	call   1004f6 <free>
        return NULL;
  1005f2:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  1005f8:	eb 24                	jmp    10061e <realloc+0x81>
    }

    // If the current block is too small, allocate a new block
    void *new_ptr = malloc(sz);
  1005fa:	e8 08 ff ff ff       	call   100507 <malloc>
  1005ff:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  100602:	48 85 c0             	test   %rax,%rax
  100605:	74 17                	je     10061e <realloc+0x81>
        return NULL; // Allocation failed
    }

    // Copy data from the old block to the new block
    memcpy(new_ptr, ptr, b->size);
  100607:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  10060b:	48 89 de             	mov    %rbx,%rsi
  10060e:	48 89 c7             	mov    %rax,%rdi
  100611:	e8 5f 00 00 00       	call   100675 <memcpy>

    // Free the old block
    free(ptr);
  100616:	48 89 df             	mov    %rbx,%rdi
  100619:	e8 d8 fe ff ff       	call   1004f6 <free>

    return new_ptr;
}
  10061e:	4c 89 e0             	mov    %r12,%rax
  100621:	5b                   	pop    %rbx
  100622:	41 5c                	pop    %r12
  100624:	5d                   	pop    %rbp
  100625:	c3                   	ret    

0000000000100626 <defrag>:


void defrag() {
  100626:	f3 0f 1e fa          	endbr64 
    block *b = head;
  10062a:	48 8b 15 f7 29 00 00 	mov    0x29f7(%rip),%rdx        # 103028 <head>

    while (b && b->next) {
  100631:	48 85 d2             	test   %rdx,%rdx
  100634:	75 04                	jne    10063a <defrag+0x14>
  100636:	c3                   	ret    
        if (b->free && b->next->free) {
            // Merge the current block with the next block
            b->size += BLOCKSIZE + b->next->size;
            b->next = b->next->next;  // Skip the next block after merging
  100637:	48 89 c2             	mov    %rax,%rdx
    while (b && b->next) {
  10063a:	48 8b 42 08          	mov    0x8(%rdx),%rax
  10063e:	48 85 c0             	test   %rax,%rax
  100641:	74 27                	je     10066a <defrag+0x44>
        if (b->free && b->next->free) {
  100643:	83 7a 10 00          	cmpl   $0x0,0x10(%rdx)
  100647:	74 ee                	je     100637 <defrag+0x11>
  100649:	83 78 10 00          	cmpl   $0x0,0x10(%rax)
  10064d:	74 e8                	je     100637 <defrag+0x11>
            b->size += BLOCKSIZE + b->next->size;
  10064f:	48 8b 32             	mov    (%rdx),%rsi
  100652:	48 8b 08             	mov    (%rax),%rcx
  100655:	48 8d 4c 0e 18       	lea    0x18(%rsi,%rcx,1),%rcx
  10065a:	48 89 0a             	mov    %rcx,(%rdx)
            b->next = b->next->next;  // Skip the next block after merging
  10065d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100661:	48 89 42 08          	mov    %rax,0x8(%rdx)
  100665:	48 89 d0             	mov    %rdx,%rax
  100668:	eb cd                	jmp    100637 <defrag+0x11>

        } else {
            b = b->next;  // Advance to the next block if no merge occurred
        }
    }
}
  10066a:	c3                   	ret    

000000000010066b <heap_info>:

int heap_info(heap_info_struct * info) {
  10066b:	f3 0f 1e fa          	endbr64 
    return 0;
  10066f:	b8 00 00 00 00       	mov    $0x0,%eax
  100674:	c3                   	ret    

0000000000100675 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100675:	f3 0f 1e fa          	endbr64 
  100679:	55                   	push   %rbp
  10067a:	48 89 e5             	mov    %rsp,%rbp
  10067d:	48 83 ec 28          	sub    $0x28,%rsp
  100681:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100685:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100689:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10068d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100691:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100695:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100699:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10069d:	eb 1c                	jmp    1006bb <memcpy+0x46>
        *d = *s;
  10069f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006a3:	0f b6 10             	movzbl (%rax),%edx
  1006a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006aa:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1006ac:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1006b1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1006b6:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1006bb:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1006c0:	75 dd                	jne    10069f <memcpy+0x2a>
    }
    return dst;
  1006c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1006c6:	c9                   	leave  
  1006c7:	c3                   	ret    

00000000001006c8 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1006c8:	f3 0f 1e fa          	endbr64 
  1006cc:	55                   	push   %rbp
  1006cd:	48 89 e5             	mov    %rsp,%rbp
  1006d0:	48 83 ec 28          	sub    $0x28,%rsp
  1006d4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1006d8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1006dc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1006e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1006e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1006e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1006f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006f4:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1006f8:	73 6a                	jae    100764 <memmove+0x9c>
  1006fa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1006fe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100702:	48 01 d0             	add    %rdx,%rax
  100705:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100709:	73 59                	jae    100764 <memmove+0x9c>
        s += n, d += n;
  10070b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10070f:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100713:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100717:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  10071b:	eb 17                	jmp    100734 <memmove+0x6c>
            *--d = *--s;
  10071d:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100722:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100727:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10072b:	0f b6 10             	movzbl (%rax),%edx
  10072e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100732:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100734:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100738:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10073c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100740:	48 85 c0             	test   %rax,%rax
  100743:	75 d8                	jne    10071d <memmove+0x55>
    if (s < d && s + n > d) {
  100745:	eb 2e                	jmp    100775 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100747:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10074b:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10074f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100753:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100757:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10075b:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  10075f:	0f b6 12             	movzbl (%rdx),%edx
  100762:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100764:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100768:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10076c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100770:	48 85 c0             	test   %rax,%rax
  100773:	75 d2                	jne    100747 <memmove+0x7f>
        }
    }
    return dst;
  100775:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100779:	c9                   	leave  
  10077a:	c3                   	ret    

000000000010077b <memset>:

void* memset(void* v, int c, size_t n) {
  10077b:	f3 0f 1e fa          	endbr64 
  10077f:	55                   	push   %rbp
  100780:	48 89 e5             	mov    %rsp,%rbp
  100783:	48 83 ec 28          	sub    $0x28,%rsp
  100787:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10078b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  10078e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100792:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100796:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10079a:	eb 15                	jmp    1007b1 <memset+0x36>
        *p = c;
  10079c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10079f:	89 c2                	mov    %eax,%edx
  1007a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007a5:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1007a7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1007ac:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1007b1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1007b6:	75 e4                	jne    10079c <memset+0x21>
    }
    return v;
  1007b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1007bc:	c9                   	leave  
  1007bd:	c3                   	ret    

00000000001007be <strlen>:

size_t strlen(const char* s) {
  1007be:	f3 0f 1e fa          	endbr64 
  1007c2:	55                   	push   %rbp
  1007c3:	48 89 e5             	mov    %rsp,%rbp
  1007c6:	48 83 ec 18          	sub    $0x18,%rsp
  1007ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1007ce:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1007d5:	00 
  1007d6:	eb 0a                	jmp    1007e2 <strlen+0x24>
        ++n;
  1007d8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1007dd:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1007e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007e6:	0f b6 00             	movzbl (%rax),%eax
  1007e9:	84 c0                	test   %al,%al
  1007eb:	75 eb                	jne    1007d8 <strlen+0x1a>
    }
    return n;
  1007ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1007f1:	c9                   	leave  
  1007f2:	c3                   	ret    

00000000001007f3 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1007f3:	f3 0f 1e fa          	endbr64 
  1007f7:	55                   	push   %rbp
  1007f8:	48 89 e5             	mov    %rsp,%rbp
  1007fb:	48 83 ec 20          	sub    $0x20,%rsp
  1007ff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100803:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100807:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10080e:	00 
  10080f:	eb 0a                	jmp    10081b <strnlen+0x28>
        ++n;
  100811:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100816:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10081b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10081f:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100823:	74 0b                	je     100830 <strnlen+0x3d>
  100825:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100829:	0f b6 00             	movzbl (%rax),%eax
  10082c:	84 c0                	test   %al,%al
  10082e:	75 e1                	jne    100811 <strnlen+0x1e>
    }
    return n;
  100830:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100834:	c9                   	leave  
  100835:	c3                   	ret    

0000000000100836 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100836:	f3 0f 1e fa          	endbr64 
  10083a:	55                   	push   %rbp
  10083b:	48 89 e5             	mov    %rsp,%rbp
  10083e:	48 83 ec 20          	sub    $0x20,%rsp
  100842:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100846:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  10084a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10084e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100852:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100856:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10085a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  10085e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100862:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100866:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  10086a:	0f b6 12             	movzbl (%rdx),%edx
  10086d:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  10086f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100873:	48 83 e8 01          	sub    $0x1,%rax
  100877:	0f b6 00             	movzbl (%rax),%eax
  10087a:	84 c0                	test   %al,%al
  10087c:	75 d4                	jne    100852 <strcpy+0x1c>
    return dst;
  10087e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100882:	c9                   	leave  
  100883:	c3                   	ret    

0000000000100884 <strcmp>:

int strcmp(const char* a, const char* b) {
  100884:	f3 0f 1e fa          	endbr64 
  100888:	55                   	push   %rbp
  100889:	48 89 e5             	mov    %rsp,%rbp
  10088c:	48 83 ec 10          	sub    $0x10,%rsp
  100890:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100894:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100898:	eb 0a                	jmp    1008a4 <strcmp+0x20>
        ++a, ++b;
  10089a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10089f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1008a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008a8:	0f b6 00             	movzbl (%rax),%eax
  1008ab:	84 c0                	test   %al,%al
  1008ad:	74 1d                	je     1008cc <strcmp+0x48>
  1008af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008b3:	0f b6 00             	movzbl (%rax),%eax
  1008b6:	84 c0                	test   %al,%al
  1008b8:	74 12                	je     1008cc <strcmp+0x48>
  1008ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008be:	0f b6 10             	movzbl (%rax),%edx
  1008c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008c5:	0f b6 00             	movzbl (%rax),%eax
  1008c8:	38 c2                	cmp    %al,%dl
  1008ca:	74 ce                	je     10089a <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1008cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008d0:	0f b6 00             	movzbl (%rax),%eax
  1008d3:	89 c2                	mov    %eax,%edx
  1008d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008d9:	0f b6 00             	movzbl (%rax),%eax
  1008dc:	38 c2                	cmp    %al,%dl
  1008de:	0f 97 c0             	seta   %al
  1008e1:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1008e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008e8:	0f b6 00             	movzbl (%rax),%eax
  1008eb:	89 c1                	mov    %eax,%ecx
  1008ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1008f1:	0f b6 00             	movzbl (%rax),%eax
  1008f4:	38 c1                	cmp    %al,%cl
  1008f6:	0f 92 c0             	setb   %al
  1008f9:	0f b6 c8             	movzbl %al,%ecx
  1008fc:	89 d0                	mov    %edx,%eax
  1008fe:	29 c8                	sub    %ecx,%eax
}
  100900:	c9                   	leave  
  100901:	c3                   	ret    

0000000000100902 <strchr>:

char* strchr(const char* s, int c) {
  100902:	f3 0f 1e fa          	endbr64 
  100906:	55                   	push   %rbp
  100907:	48 89 e5             	mov    %rsp,%rbp
  10090a:	48 83 ec 10          	sub    $0x10,%rsp
  10090e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100912:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100915:	eb 05                	jmp    10091c <strchr+0x1a>
        ++s;
  100917:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  10091c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100920:	0f b6 00             	movzbl (%rax),%eax
  100923:	84 c0                	test   %al,%al
  100925:	74 0e                	je     100935 <strchr+0x33>
  100927:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10092b:	0f b6 00             	movzbl (%rax),%eax
  10092e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100931:	38 d0                	cmp    %dl,%al
  100933:	75 e2                	jne    100917 <strchr+0x15>
    }
    if (*s == (char) c) {
  100935:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100939:	0f b6 00             	movzbl (%rax),%eax
  10093c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  10093f:	38 d0                	cmp    %dl,%al
  100941:	75 06                	jne    100949 <strchr+0x47>
        return (char*) s;
  100943:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100947:	eb 05                	jmp    10094e <strchr+0x4c>
    } else {
        return NULL;
  100949:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  10094e:	c9                   	leave  
  10094f:	c3                   	ret    

0000000000100950 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100950:	f3 0f 1e fa          	endbr64 
  100954:	55                   	push   %rbp
  100955:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100958:	8b 05 d2 26 00 00    	mov    0x26d2(%rip),%eax        # 103030 <rand_seed_set>
  10095e:	85 c0                	test   %eax,%eax
  100960:	75 0a                	jne    10096c <rand+0x1c>
        srand(819234718U);
  100962:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100967:	e8 24 00 00 00       	call   100990 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  10096c:	8b 05 c2 26 00 00    	mov    0x26c2(%rip),%eax        # 103034 <rand_seed>
  100972:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100978:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10097d:	89 05 b1 26 00 00    	mov    %eax,0x26b1(%rip)        # 103034 <rand_seed>
    return rand_seed & RAND_MAX;
  100983:	8b 05 ab 26 00 00    	mov    0x26ab(%rip),%eax        # 103034 <rand_seed>
  100989:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10098e:	5d                   	pop    %rbp
  10098f:	c3                   	ret    

0000000000100990 <srand>:

void srand(unsigned seed) {
  100990:	f3 0f 1e fa          	endbr64 
  100994:	55                   	push   %rbp
  100995:	48 89 e5             	mov    %rsp,%rbp
  100998:	48 83 ec 08          	sub    $0x8,%rsp
  10099c:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  10099f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1009a2:	89 05 8c 26 00 00    	mov    %eax,0x268c(%rip)        # 103034 <rand_seed>
    rand_seed_set = 1;
  1009a8:	c7 05 7e 26 00 00 01 	movl   $0x1,0x267e(%rip)        # 103030 <rand_seed_set>
  1009af:	00 00 00 
}
  1009b2:	90                   	nop
  1009b3:	c9                   	leave  
  1009b4:	c3                   	ret    

00000000001009b5 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1009b5:	f3 0f 1e fa          	endbr64 
  1009b9:	55                   	push   %rbp
  1009ba:	48 89 e5             	mov    %rsp,%rbp
  1009bd:	48 83 ec 28          	sub    $0x28,%rsp
  1009c1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1009c5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1009c9:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1009cc:	48 8d 05 7d 0f 00 00 	lea    0xf7d(%rip),%rax        # 101950 <upper_digits.1>
  1009d3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  1009d7:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1009db:	79 0e                	jns    1009eb <fill_numbuf+0x36>
        digits = lower_digits;
  1009dd:	48 8d 05 8c 0f 00 00 	lea    0xf8c(%rip),%rax        # 101970 <lower_digits.0>
  1009e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  1009e8:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1009eb:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1009f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009f4:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1009f7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1009fa:	48 63 c8             	movslq %eax,%rcx
  1009fd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a01:	ba 00 00 00 00       	mov    $0x0,%edx
  100a06:	48 f7 f1             	div    %rcx
  100a09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a0d:	48 01 d0             	add    %rdx,%rax
  100a10:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100a15:	0f b6 10             	movzbl (%rax),%edx
  100a18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a1c:	88 10                	mov    %dl,(%rax)
        val /= base;
  100a1e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100a21:	48 63 f0             	movslq %eax,%rsi
  100a24:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a28:	ba 00 00 00 00       	mov    $0x0,%edx
  100a2d:	48 f7 f6             	div    %rsi
  100a30:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100a34:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100a39:	75 bc                	jne    1009f7 <fill_numbuf+0x42>
    return numbuf_end;
  100a3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100a3f:	c9                   	leave  
  100a40:	c3                   	ret    

0000000000100a41 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100a41:	f3 0f 1e fa          	endbr64 
  100a45:	55                   	push   %rbp
  100a46:	48 89 e5             	mov    %rsp,%rbp
  100a49:	53                   	push   %rbx
  100a4a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100a51:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100a58:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100a5e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100a65:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100a6c:	e9 bd 09 00 00       	jmp    10142e <printer_vprintf+0x9ed>
        if (*format != '%') {
  100a71:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a78:	0f b6 00             	movzbl (%rax),%eax
  100a7b:	3c 25                	cmp    $0x25,%al
  100a7d:	74 31                	je     100ab0 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  100a7f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100a86:	4c 8b 00             	mov    (%rax),%r8
  100a89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a90:	0f b6 00             	movzbl (%rax),%eax
  100a93:	0f b6 c8             	movzbl %al,%ecx
  100a96:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100a9c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100aa3:	89 ce                	mov    %ecx,%esi
  100aa5:	48 89 c7             	mov    %rax,%rdi
  100aa8:	41 ff d0             	call   *%r8
            continue;
  100aab:	e9 76 09 00 00       	jmp    101426 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  100ab0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100ab7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100abe:	01 
  100abf:	eb 4d                	jmp    100b0e <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  100ac1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ac8:	0f b6 00             	movzbl (%rax),%eax
  100acb:	0f be c0             	movsbl %al,%eax
  100ace:	89 c6                	mov    %eax,%esi
  100ad0:	48 8d 05 79 0d 00 00 	lea    0xd79(%rip),%rax        # 101850 <flag_chars>
  100ad7:	48 89 c7             	mov    %rax,%rdi
  100ada:	e8 23 fe ff ff       	call   100902 <strchr>
  100adf:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100ae3:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100ae8:	74 34                	je     100b1e <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  100aea:	48 8d 15 5f 0d 00 00 	lea    0xd5f(%rip),%rdx        # 101850 <flag_chars>
  100af1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100af5:	48 29 d0             	sub    %rdx,%rax
  100af8:	ba 01 00 00 00       	mov    $0x1,%edx
  100afd:	89 c1                	mov    %eax,%ecx
  100aff:	d3 e2                	shl    %cl,%edx
  100b01:	89 d0                	mov    %edx,%eax
  100b03:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100b06:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b0d:	01 
  100b0e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b15:	0f b6 00             	movzbl (%rax),%eax
  100b18:	84 c0                	test   %al,%al
  100b1a:	75 a5                	jne    100ac1 <printer_vprintf+0x80>
  100b1c:	eb 01                	jmp    100b1f <printer_vprintf+0xde>
            } else {
                break;
  100b1e:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100b1f:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100b26:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b2d:	0f b6 00             	movzbl (%rax),%eax
  100b30:	3c 30                	cmp    $0x30,%al
  100b32:	7e 67                	jle    100b9b <printer_vprintf+0x15a>
  100b34:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b3b:	0f b6 00             	movzbl (%rax),%eax
  100b3e:	3c 39                	cmp    $0x39,%al
  100b40:	7f 59                	jg     100b9b <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100b42:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100b49:	eb 2e                	jmp    100b79 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  100b4b:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100b4e:	89 d0                	mov    %edx,%eax
  100b50:	c1 e0 02             	shl    $0x2,%eax
  100b53:	01 d0                	add    %edx,%eax
  100b55:	01 c0                	add    %eax,%eax
  100b57:	89 c1                	mov    %eax,%ecx
  100b59:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b60:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100b64:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100b6b:	0f b6 00             	movzbl (%rax),%eax
  100b6e:	0f be c0             	movsbl %al,%eax
  100b71:	01 c8                	add    %ecx,%eax
  100b73:	83 e8 30             	sub    $0x30,%eax
  100b76:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100b79:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b80:	0f b6 00             	movzbl (%rax),%eax
  100b83:	3c 2f                	cmp    $0x2f,%al
  100b85:	0f 8e 85 00 00 00    	jle    100c10 <printer_vprintf+0x1cf>
  100b8b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b92:	0f b6 00             	movzbl (%rax),%eax
  100b95:	3c 39                	cmp    $0x39,%al
  100b97:	7e b2                	jle    100b4b <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  100b99:	eb 75                	jmp    100c10 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  100b9b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ba2:	0f b6 00             	movzbl (%rax),%eax
  100ba5:	3c 2a                	cmp    $0x2a,%al
  100ba7:	75 68                	jne    100c11 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  100ba9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bb0:	8b 00                	mov    (%rax),%eax
  100bb2:	83 f8 2f             	cmp    $0x2f,%eax
  100bb5:	77 30                	ja     100be7 <printer_vprintf+0x1a6>
  100bb7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bbe:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bc2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bc9:	8b 00                	mov    (%rax),%eax
  100bcb:	89 c0                	mov    %eax,%eax
  100bcd:	48 01 d0             	add    %rdx,%rax
  100bd0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bd7:	8b 12                	mov    (%rdx),%edx
  100bd9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bdc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100be3:	89 0a                	mov    %ecx,(%rdx)
  100be5:	eb 1a                	jmp    100c01 <printer_vprintf+0x1c0>
  100be7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bee:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bf2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bf6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bfd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c01:	8b 00                	mov    (%rax),%eax
  100c03:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100c06:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c0d:	01 
  100c0e:	eb 01                	jmp    100c11 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  100c10:	90                   	nop
        }

        // process precision
        int precision = -1;
  100c11:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100c18:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c1f:	0f b6 00             	movzbl (%rax),%eax
  100c22:	3c 2e                	cmp    $0x2e,%al
  100c24:	0f 85 00 01 00 00    	jne    100d2a <printer_vprintf+0x2e9>
            ++format;
  100c2a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c31:	01 
            if (*format >= '0' && *format <= '9') {
  100c32:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c39:	0f b6 00             	movzbl (%rax),%eax
  100c3c:	3c 2f                	cmp    $0x2f,%al
  100c3e:	7e 67                	jle    100ca7 <printer_vprintf+0x266>
  100c40:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c47:	0f b6 00             	movzbl (%rax),%eax
  100c4a:	3c 39                	cmp    $0x39,%al
  100c4c:	7f 59                	jg     100ca7 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100c4e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100c55:	eb 2e                	jmp    100c85 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  100c57:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100c5a:	89 d0                	mov    %edx,%eax
  100c5c:	c1 e0 02             	shl    $0x2,%eax
  100c5f:	01 d0                	add    %edx,%eax
  100c61:	01 c0                	add    %eax,%eax
  100c63:	89 c1                	mov    %eax,%ecx
  100c65:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c6c:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100c70:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100c77:	0f b6 00             	movzbl (%rax),%eax
  100c7a:	0f be c0             	movsbl %al,%eax
  100c7d:	01 c8                	add    %ecx,%eax
  100c7f:	83 e8 30             	sub    $0x30,%eax
  100c82:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100c85:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c8c:	0f b6 00             	movzbl (%rax),%eax
  100c8f:	3c 2f                	cmp    $0x2f,%al
  100c91:	0f 8e 85 00 00 00    	jle    100d1c <printer_vprintf+0x2db>
  100c97:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c9e:	0f b6 00             	movzbl (%rax),%eax
  100ca1:	3c 39                	cmp    $0x39,%al
  100ca3:	7e b2                	jle    100c57 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  100ca5:	eb 75                	jmp    100d1c <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  100ca7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cae:	0f b6 00             	movzbl (%rax),%eax
  100cb1:	3c 2a                	cmp    $0x2a,%al
  100cb3:	75 68                	jne    100d1d <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  100cb5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cbc:	8b 00                	mov    (%rax),%eax
  100cbe:	83 f8 2f             	cmp    $0x2f,%eax
  100cc1:	77 30                	ja     100cf3 <printer_vprintf+0x2b2>
  100cc3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cca:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cd5:	8b 00                	mov    (%rax),%eax
  100cd7:	89 c0                	mov    %eax,%eax
  100cd9:	48 01 d0             	add    %rdx,%rax
  100cdc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ce3:	8b 12                	mov    (%rdx),%edx
  100ce5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ce8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cef:	89 0a                	mov    %ecx,(%rdx)
  100cf1:	eb 1a                	jmp    100d0d <printer_vprintf+0x2cc>
  100cf3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cfa:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cfe:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d02:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d09:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d0d:	8b 00                	mov    (%rax),%eax
  100d0f:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100d12:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100d19:	01 
  100d1a:	eb 01                	jmp    100d1d <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  100d1c:	90                   	nop
            }
            if (precision < 0) {
  100d1d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100d21:	79 07                	jns    100d2a <printer_vprintf+0x2e9>
                precision = 0;
  100d23:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100d2a:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100d31:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100d38:	00 
        int length = 0;
  100d39:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100d40:	48 8d 05 0f 0b 00 00 	lea    0xb0f(%rip),%rax        # 101856 <flag_chars+0x6>
  100d47:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  100d4b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d52:	0f b6 00             	movzbl (%rax),%eax
  100d55:	0f be c0             	movsbl %al,%eax
  100d58:	83 e8 43             	sub    $0x43,%eax
  100d5b:	83 f8 37             	cmp    $0x37,%eax
  100d5e:	0f 87 b6 03 00 00    	ja     10111a <printer_vprintf+0x6d9>
  100d64:	89 c0                	mov    %eax,%eax
  100d66:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  100d6d:	00 
  100d6e:	48 8d 05 ef 0a 00 00 	lea    0xaef(%rip),%rax        # 101864 <flag_chars+0x14>
  100d75:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  100d78:	48 98                	cltq   
  100d7a:	48 8d 15 e3 0a 00 00 	lea    0xae3(%rip),%rdx        # 101864 <flag_chars+0x14>
  100d81:	48 01 d0             	add    %rdx,%rax
  100d84:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  100d87:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100d8e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100d95:	01 
            goto again;
  100d96:	eb b3                	jmp    100d4b <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100d98:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100d9c:	74 5d                	je     100dfb <printer_vprintf+0x3ba>
  100d9e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100da5:	8b 00                	mov    (%rax),%eax
  100da7:	83 f8 2f             	cmp    $0x2f,%eax
  100daa:	77 30                	ja     100ddc <printer_vprintf+0x39b>
  100dac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100db3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100db7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dbe:	8b 00                	mov    (%rax),%eax
  100dc0:	89 c0                	mov    %eax,%eax
  100dc2:	48 01 d0             	add    %rdx,%rax
  100dc5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dcc:	8b 12                	mov    (%rdx),%edx
  100dce:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100dd1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dd8:	89 0a                	mov    %ecx,(%rdx)
  100dda:	eb 1a                	jmp    100df6 <printer_vprintf+0x3b5>
  100ddc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100de3:	48 8b 40 08          	mov    0x8(%rax),%rax
  100de7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100deb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100df2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100df6:	48 8b 00             	mov    (%rax),%rax
  100df9:	eb 5c                	jmp    100e57 <printer_vprintf+0x416>
  100dfb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e02:	8b 00                	mov    (%rax),%eax
  100e04:	83 f8 2f             	cmp    $0x2f,%eax
  100e07:	77 30                	ja     100e39 <printer_vprintf+0x3f8>
  100e09:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e10:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e14:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e1b:	8b 00                	mov    (%rax),%eax
  100e1d:	89 c0                	mov    %eax,%eax
  100e1f:	48 01 d0             	add    %rdx,%rax
  100e22:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e29:	8b 12                	mov    (%rdx),%edx
  100e2b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e2e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e35:	89 0a                	mov    %ecx,(%rdx)
  100e37:	eb 1a                	jmp    100e53 <printer_vprintf+0x412>
  100e39:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e40:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e44:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e48:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e4f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e53:	8b 00                	mov    (%rax),%eax
  100e55:	48 98                	cltq   
  100e57:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100e5b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e5f:	48 c1 f8 38          	sar    $0x38,%rax
  100e63:	25 80 00 00 00       	and    $0x80,%eax
  100e68:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100e6b:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100e6f:	74 09                	je     100e7a <printer_vprintf+0x439>
  100e71:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e75:	48 f7 d8             	neg    %rax
  100e78:	eb 04                	jmp    100e7e <printer_vprintf+0x43d>
  100e7a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100e7e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100e82:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100e85:	83 c8 60             	or     $0x60,%eax
  100e88:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100e8b:	e9 cf 02 00 00       	jmp    10115f <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100e90:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100e94:	74 5d                	je     100ef3 <printer_vprintf+0x4b2>
  100e96:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e9d:	8b 00                	mov    (%rax),%eax
  100e9f:	83 f8 2f             	cmp    $0x2f,%eax
  100ea2:	77 30                	ja     100ed4 <printer_vprintf+0x493>
  100ea4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eab:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100eaf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100eb6:	8b 00                	mov    (%rax),%eax
  100eb8:	89 c0                	mov    %eax,%eax
  100eba:	48 01 d0             	add    %rdx,%rax
  100ebd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ec4:	8b 12                	mov    (%rdx),%edx
  100ec6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ec9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ed0:	89 0a                	mov    %ecx,(%rdx)
  100ed2:	eb 1a                	jmp    100eee <printer_vprintf+0x4ad>
  100ed4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100edb:	48 8b 40 08          	mov    0x8(%rax),%rax
  100edf:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ee3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100eea:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100eee:	48 8b 00             	mov    (%rax),%rax
  100ef1:	eb 5c                	jmp    100f4f <printer_vprintf+0x50e>
  100ef3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100efa:	8b 00                	mov    (%rax),%eax
  100efc:	83 f8 2f             	cmp    $0x2f,%eax
  100eff:	77 30                	ja     100f31 <printer_vprintf+0x4f0>
  100f01:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f08:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f0c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f13:	8b 00                	mov    (%rax),%eax
  100f15:	89 c0                	mov    %eax,%eax
  100f17:	48 01 d0             	add    %rdx,%rax
  100f1a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f21:	8b 12                	mov    (%rdx),%edx
  100f23:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f26:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f2d:	89 0a                	mov    %ecx,(%rdx)
  100f2f:	eb 1a                	jmp    100f4b <printer_vprintf+0x50a>
  100f31:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f38:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f3c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f40:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f47:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f4b:	8b 00                	mov    (%rax),%eax
  100f4d:	89 c0                	mov    %eax,%eax
  100f4f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100f53:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100f57:	e9 03 02 00 00       	jmp    10115f <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100f5c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100f63:	e9 28 ff ff ff       	jmp    100e90 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100f68:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100f6f:	e9 1c ff ff ff       	jmp    100e90 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100f74:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f7b:	8b 00                	mov    (%rax),%eax
  100f7d:	83 f8 2f             	cmp    $0x2f,%eax
  100f80:	77 30                	ja     100fb2 <printer_vprintf+0x571>
  100f82:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f89:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f8d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f94:	8b 00                	mov    (%rax),%eax
  100f96:	89 c0                	mov    %eax,%eax
  100f98:	48 01 d0             	add    %rdx,%rax
  100f9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fa2:	8b 12                	mov    (%rdx),%edx
  100fa4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fa7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fae:	89 0a                	mov    %ecx,(%rdx)
  100fb0:	eb 1a                	jmp    100fcc <printer_vprintf+0x58b>
  100fb2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb9:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fbd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fc1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fc8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fcc:	48 8b 00             	mov    (%rax),%rax
  100fcf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100fd3:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100fda:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100fe1:	e9 79 01 00 00       	jmp    10115f <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100fe6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fed:	8b 00                	mov    (%rax),%eax
  100fef:	83 f8 2f             	cmp    $0x2f,%eax
  100ff2:	77 30                	ja     101024 <printer_vprintf+0x5e3>
  100ff4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ffb:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101006:	8b 00                	mov    (%rax),%eax
  101008:	89 c0                	mov    %eax,%eax
  10100a:	48 01 d0             	add    %rdx,%rax
  10100d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101014:	8b 12                	mov    (%rdx),%edx
  101016:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101019:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101020:	89 0a                	mov    %ecx,(%rdx)
  101022:	eb 1a                	jmp    10103e <printer_vprintf+0x5fd>
  101024:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10102b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10102f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101033:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10103a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10103e:	48 8b 00             	mov    (%rax),%rax
  101041:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  101045:	e9 15 01 00 00       	jmp    10115f <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  10104a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101051:	8b 00                	mov    (%rax),%eax
  101053:	83 f8 2f             	cmp    $0x2f,%eax
  101056:	77 30                	ja     101088 <printer_vprintf+0x647>
  101058:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10105f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101063:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10106a:	8b 00                	mov    (%rax),%eax
  10106c:	89 c0                	mov    %eax,%eax
  10106e:	48 01 d0             	add    %rdx,%rax
  101071:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101078:	8b 12                	mov    (%rdx),%edx
  10107a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10107d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101084:	89 0a                	mov    %ecx,(%rdx)
  101086:	eb 1a                	jmp    1010a2 <printer_vprintf+0x661>
  101088:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10108f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101093:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101097:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10109e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010a2:	8b 00                	mov    (%rax),%eax
  1010a4:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  1010aa:	e9 77 03 00 00       	jmp    101426 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  1010af:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1010b3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  1010b7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010be:	8b 00                	mov    (%rax),%eax
  1010c0:	83 f8 2f             	cmp    $0x2f,%eax
  1010c3:	77 30                	ja     1010f5 <printer_vprintf+0x6b4>
  1010c5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010cc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010d0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010d7:	8b 00                	mov    (%rax),%eax
  1010d9:	89 c0                	mov    %eax,%eax
  1010db:	48 01 d0             	add    %rdx,%rax
  1010de:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010e5:	8b 12                	mov    (%rdx),%edx
  1010e7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010ea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010f1:	89 0a                	mov    %ecx,(%rdx)
  1010f3:	eb 1a                	jmp    10110f <printer_vprintf+0x6ce>
  1010f5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010fc:	48 8b 40 08          	mov    0x8(%rax),%rax
  101100:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101104:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10110b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10110f:	8b 00                	mov    (%rax),%eax
  101111:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101114:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  101118:	eb 45                	jmp    10115f <printer_vprintf+0x71e>
        default:
            data = numbuf;
  10111a:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10111e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  101122:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101129:	0f b6 00             	movzbl (%rax),%eax
  10112c:	84 c0                	test   %al,%al
  10112e:	74 0c                	je     10113c <printer_vprintf+0x6fb>
  101130:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101137:	0f b6 00             	movzbl (%rax),%eax
  10113a:	eb 05                	jmp    101141 <printer_vprintf+0x700>
  10113c:	b8 25 00 00 00       	mov    $0x25,%eax
  101141:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101144:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  101148:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10114f:	0f b6 00             	movzbl (%rax),%eax
  101152:	84 c0                	test   %al,%al
  101154:	75 08                	jne    10115e <printer_vprintf+0x71d>
                format--;
  101156:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  10115d:	01 
            }
            break;
  10115e:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  10115f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101162:	83 e0 20             	and    $0x20,%eax
  101165:	85 c0                	test   %eax,%eax
  101167:	74 1e                	je     101187 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101169:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10116d:	48 83 c0 18          	add    $0x18,%rax
  101171:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101174:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101178:	48 89 ce             	mov    %rcx,%rsi
  10117b:	48 89 c7             	mov    %rax,%rdi
  10117e:	e8 32 f8 ff ff       	call   1009b5 <fill_numbuf>
  101183:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  101187:	48 8d 05 c8 06 00 00 	lea    0x6c8(%rip),%rax        # 101856 <flag_chars+0x6>
  10118e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  101192:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101195:	83 e0 20             	and    $0x20,%eax
  101198:	85 c0                	test   %eax,%eax
  10119a:	74 51                	je     1011ed <printer_vprintf+0x7ac>
  10119c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10119f:	83 e0 40             	and    $0x40,%eax
  1011a2:	85 c0                	test   %eax,%eax
  1011a4:	74 47                	je     1011ed <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  1011a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011a9:	25 80 00 00 00       	and    $0x80,%eax
  1011ae:	85 c0                	test   %eax,%eax
  1011b0:	74 0d                	je     1011bf <printer_vprintf+0x77e>
                prefix = "-";
  1011b2:	48 8d 05 9e 06 00 00 	lea    0x69e(%rip),%rax        # 101857 <flag_chars+0x7>
  1011b9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1011bd:	eb 7d                	jmp    10123c <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1011bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011c2:	83 e0 10             	and    $0x10,%eax
  1011c5:	85 c0                	test   %eax,%eax
  1011c7:	74 0d                	je     1011d6 <printer_vprintf+0x795>
                prefix = "+";
  1011c9:	48 8d 05 89 06 00 00 	lea    0x689(%rip),%rax        # 101859 <flag_chars+0x9>
  1011d0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1011d4:	eb 66                	jmp    10123c <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  1011d6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011d9:	83 e0 08             	and    $0x8,%eax
  1011dc:	85 c0                	test   %eax,%eax
  1011de:	74 5c                	je     10123c <printer_vprintf+0x7fb>
                prefix = " ";
  1011e0:	48 8d 05 74 06 00 00 	lea    0x674(%rip),%rax        # 10185b <flag_chars+0xb>
  1011e7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1011eb:	eb 4f                	jmp    10123c <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1011ed:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011f0:	83 e0 20             	and    $0x20,%eax
  1011f3:	85 c0                	test   %eax,%eax
  1011f5:	74 46                	je     10123d <printer_vprintf+0x7fc>
  1011f7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011fa:	83 e0 01             	and    $0x1,%eax
  1011fd:	85 c0                	test   %eax,%eax
  1011ff:	74 3c                	je     10123d <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  101201:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  101205:	74 06                	je     10120d <printer_vprintf+0x7cc>
  101207:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  10120b:	75 30                	jne    10123d <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  10120d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  101212:	75 0c                	jne    101220 <printer_vprintf+0x7df>
  101214:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101217:	25 00 01 00 00       	and    $0x100,%eax
  10121c:	85 c0                	test   %eax,%eax
  10121e:	74 1d                	je     10123d <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  101220:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101224:	75 09                	jne    10122f <printer_vprintf+0x7ee>
  101226:	48 8d 05 30 06 00 00 	lea    0x630(%rip),%rax        # 10185d <flag_chars+0xd>
  10122d:	eb 07                	jmp    101236 <printer_vprintf+0x7f5>
  10122f:	48 8d 05 2a 06 00 00 	lea    0x62a(%rip),%rax        # 101860 <flag_chars+0x10>
  101236:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10123a:	eb 01                	jmp    10123d <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  10123c:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  10123d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101241:	78 24                	js     101267 <printer_vprintf+0x826>
  101243:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101246:	83 e0 20             	and    $0x20,%eax
  101249:	85 c0                	test   %eax,%eax
  10124b:	75 1a                	jne    101267 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  10124d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101250:	48 63 d0             	movslq %eax,%rdx
  101253:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101257:	48 89 d6             	mov    %rdx,%rsi
  10125a:	48 89 c7             	mov    %rax,%rdi
  10125d:	e8 91 f5 ff ff       	call   1007f3 <strnlen>
  101262:	89 45 bc             	mov    %eax,-0x44(%rbp)
  101265:	eb 0f                	jmp    101276 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  101267:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10126b:	48 89 c7             	mov    %rax,%rdi
  10126e:	e8 4b f5 ff ff       	call   1007be <strlen>
  101273:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  101276:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101279:	83 e0 20             	and    $0x20,%eax
  10127c:	85 c0                	test   %eax,%eax
  10127e:	74 20                	je     1012a0 <printer_vprintf+0x85f>
  101280:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101284:	78 1a                	js     1012a0 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  101286:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101289:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  10128c:	7e 08                	jle    101296 <printer_vprintf+0x855>
  10128e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101291:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101294:	eb 05                	jmp    10129b <printer_vprintf+0x85a>
  101296:	b8 00 00 00 00       	mov    $0x0,%eax
  10129b:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10129e:	eb 5c                	jmp    1012fc <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1012a0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012a3:	83 e0 20             	and    $0x20,%eax
  1012a6:	85 c0                	test   %eax,%eax
  1012a8:	74 4b                	je     1012f5 <printer_vprintf+0x8b4>
  1012aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012ad:	83 e0 02             	and    $0x2,%eax
  1012b0:	85 c0                	test   %eax,%eax
  1012b2:	74 41                	je     1012f5 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1012b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012b7:	83 e0 04             	and    $0x4,%eax
  1012ba:	85 c0                	test   %eax,%eax
  1012bc:	75 37                	jne    1012f5 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  1012be:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012c2:	48 89 c7             	mov    %rax,%rdi
  1012c5:	e8 f4 f4 ff ff       	call   1007be <strlen>
  1012ca:	89 c2                	mov    %eax,%edx
  1012cc:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1012cf:	01 d0                	add    %edx,%eax
  1012d1:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  1012d4:	7e 1f                	jle    1012f5 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  1012d6:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1012d9:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1012dc:	89 c3                	mov    %eax,%ebx
  1012de:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012e2:	48 89 c7             	mov    %rax,%rdi
  1012e5:	e8 d4 f4 ff ff       	call   1007be <strlen>
  1012ea:	89 c2                	mov    %eax,%edx
  1012ec:	89 d8                	mov    %ebx,%eax
  1012ee:	29 d0                	sub    %edx,%eax
  1012f0:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1012f3:	eb 07                	jmp    1012fc <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  1012f5:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  1012fc:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1012ff:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101302:	01 d0                	add    %edx,%eax
  101304:	48 63 d8             	movslq %eax,%rbx
  101307:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10130b:	48 89 c7             	mov    %rax,%rdi
  10130e:	e8 ab f4 ff ff       	call   1007be <strlen>
  101313:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  101317:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10131a:	29 d0                	sub    %edx,%eax
  10131c:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10131f:	eb 25                	jmp    101346 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  101321:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101328:	48 8b 08             	mov    (%rax),%rcx
  10132b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101331:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101338:	be 20 00 00 00       	mov    $0x20,%esi
  10133d:	48 89 c7             	mov    %rax,%rdi
  101340:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101342:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101346:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101349:	83 e0 04             	and    $0x4,%eax
  10134c:	85 c0                	test   %eax,%eax
  10134e:	75 36                	jne    101386 <printer_vprintf+0x945>
  101350:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101354:	7f cb                	jg     101321 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  101356:	eb 2e                	jmp    101386 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  101358:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10135f:	4c 8b 00             	mov    (%rax),%r8
  101362:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101366:	0f b6 00             	movzbl (%rax),%eax
  101369:	0f b6 c8             	movzbl %al,%ecx
  10136c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101372:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101379:	89 ce                	mov    %ecx,%esi
  10137b:	48 89 c7             	mov    %rax,%rdi
  10137e:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101381:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101386:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10138a:	0f b6 00             	movzbl (%rax),%eax
  10138d:	84 c0                	test   %al,%al
  10138f:	75 c7                	jne    101358 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  101391:	eb 25                	jmp    1013b8 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  101393:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10139a:	48 8b 08             	mov    (%rax),%rcx
  10139d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1013a3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013aa:	be 30 00 00 00       	mov    $0x30,%esi
  1013af:	48 89 c7             	mov    %rax,%rdi
  1013b2:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1013b4:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1013b8:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1013bc:	7f d5                	jg     101393 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  1013be:	eb 32                	jmp    1013f2 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  1013c0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013c7:	4c 8b 00             	mov    (%rax),%r8
  1013ca:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1013ce:	0f b6 00             	movzbl (%rax),%eax
  1013d1:	0f b6 c8             	movzbl %al,%ecx
  1013d4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1013da:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013e1:	89 ce                	mov    %ecx,%esi
  1013e3:	48 89 c7             	mov    %rax,%rdi
  1013e6:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  1013e9:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  1013ee:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  1013f2:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  1013f6:	7f c8                	jg     1013c0 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  1013f8:	eb 25                	jmp    10141f <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  1013fa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101401:	48 8b 08             	mov    (%rax),%rcx
  101404:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10140a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101411:	be 20 00 00 00       	mov    $0x20,%esi
  101416:	48 89 c7             	mov    %rax,%rdi
  101419:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  10141b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10141f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101423:	7f d5                	jg     1013fa <printer_vprintf+0x9b9>
        }
    done: ;
  101425:	90                   	nop
    for (; *format; ++format) {
  101426:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10142d:	01 
  10142e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101435:	0f b6 00             	movzbl (%rax),%eax
  101438:	84 c0                	test   %al,%al
  10143a:	0f 85 31 f6 ff ff    	jne    100a71 <printer_vprintf+0x30>
    }
}
  101440:	90                   	nop
  101441:	90                   	nop
  101442:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101446:	c9                   	leave  
  101447:	c3                   	ret    

0000000000101448 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101448:	f3 0f 1e fa          	endbr64 
  10144c:	55                   	push   %rbp
  10144d:	48 89 e5             	mov    %rsp,%rbp
  101450:	48 83 ec 20          	sub    $0x20,%rsp
  101454:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101458:	89 f0                	mov    %esi,%eax
  10145a:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10145d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101460:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101464:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101468:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10146c:	48 8b 40 08          	mov    0x8(%rax),%rax
  101470:	48 8d 15 29 7b fb ff 	lea    -0x484d7(%rip),%rdx        # b8fa0 <console+0xfa0>
  101477:	48 39 d0             	cmp    %rdx,%rax
  10147a:	72 0f                	jb     10148b <console_putc+0x43>
        cp->cursor = console;
  10147c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101480:	48 8d 15 79 6b fb ff 	lea    -0x49487(%rip),%rdx        # b8000 <console>
  101487:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  10148b:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  10148f:	0f 85 82 00 00 00    	jne    101517 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  101495:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101499:	48 8b 40 08          	mov    0x8(%rax),%rax
  10149d:	48 8d 15 5c 6b fb ff 	lea    -0x494a4(%rip),%rdx        # b8000 <console>
  1014a4:	48 29 d0             	sub    %rdx,%rax
  1014a7:	48 d1 f8             	sar    %rax
  1014aa:	48 89 c1             	mov    %rax,%rcx
  1014ad:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1014b4:	66 66 66 
  1014b7:	48 89 c8             	mov    %rcx,%rax
  1014ba:	48 f7 ea             	imul   %rdx
  1014bd:	48 89 d0             	mov    %rdx,%rax
  1014c0:	48 c1 f8 05          	sar    $0x5,%rax
  1014c4:	48 89 ce             	mov    %rcx,%rsi
  1014c7:	48 c1 fe 3f          	sar    $0x3f,%rsi
  1014cb:	48 29 f0             	sub    %rsi,%rax
  1014ce:	48 89 c2             	mov    %rax,%rdx
  1014d1:	48 89 d0             	mov    %rdx,%rax
  1014d4:	48 c1 e0 02          	shl    $0x2,%rax
  1014d8:	48 01 d0             	add    %rdx,%rax
  1014db:	48 c1 e0 04          	shl    $0x4,%rax
  1014df:	48 29 c1             	sub    %rax,%rcx
  1014e2:	48 89 ca             	mov    %rcx,%rdx
  1014e5:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1014e8:	eb 25                	jmp    10150f <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  1014ea:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1014ed:	83 c8 20             	or     $0x20,%eax
  1014f0:	89 c6                	mov    %eax,%esi
  1014f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1014f6:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014fa:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1014fe:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101502:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101506:	89 f2                	mov    %esi,%edx
  101508:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10150b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10150f:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101513:	75 d5                	jne    1014ea <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101515:	eb 24                	jmp    10153b <console_putc+0xf3>
        *cp->cursor++ = c | color;
  101517:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10151b:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10151e:	89 d6                	mov    %edx,%esi
  101520:	09 c6                	or     %eax,%esi
  101522:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101526:	48 8b 40 08          	mov    0x8(%rax),%rax
  10152a:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10152e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101532:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101536:	89 f2                	mov    %esi,%edx
  101538:	66 89 10             	mov    %dx,(%rax)
}
  10153b:	90                   	nop
  10153c:	c9                   	leave  
  10153d:	c3                   	ret    

000000000010153e <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10153e:	f3 0f 1e fa          	endbr64 
  101542:	55                   	push   %rbp
  101543:	48 89 e5             	mov    %rsp,%rbp
  101546:	48 83 ec 30          	sub    $0x30,%rsp
  10154a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10154d:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101550:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101554:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101558:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 101448 <console_putc>
  10155f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101563:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101567:	78 09                	js     101572 <console_vprintf+0x34>
  101569:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101570:	7e 07                	jle    101579 <console_vprintf+0x3b>
        cpos = 0;
  101572:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101579:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10157c:	48 98                	cltq   
  10157e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101582:	48 8d 05 77 6a fb ff 	lea    -0x49589(%rip),%rax        # b8000 <console>
  101589:	48 01 d0             	add    %rdx,%rax
  10158c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101590:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101594:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101598:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10159b:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  10159f:	48 89 c7             	mov    %rax,%rdi
  1015a2:	e8 9a f4 ff ff       	call   100a41 <printer_vprintf>
    return cp.cursor - console;
  1015a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1015ab:	48 8d 15 4e 6a fb ff 	lea    -0x495b2(%rip),%rdx        # b8000 <console>
  1015b2:	48 29 d0             	sub    %rdx,%rax
  1015b5:	48 d1 f8             	sar    %rax
}
  1015b8:	c9                   	leave  
  1015b9:	c3                   	ret    

00000000001015ba <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1015ba:	f3 0f 1e fa          	endbr64 
  1015be:	55                   	push   %rbp
  1015bf:	48 89 e5             	mov    %rsp,%rbp
  1015c2:	48 83 ec 60          	sub    $0x60,%rsp
  1015c6:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1015c9:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1015cc:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1015d0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1015d4:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1015d8:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1015dc:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1015e3:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1015e7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1015eb:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1015ef:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1015f3:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1015f7:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1015fb:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1015fe:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101601:	89 c7                	mov    %eax,%edi
  101603:	e8 36 ff ff ff       	call   10153e <console_vprintf>
  101608:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10160b:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10160e:	c9                   	leave  
  10160f:	c3                   	ret    

0000000000101610 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101610:	f3 0f 1e fa          	endbr64 
  101614:	55                   	push   %rbp
  101615:	48 89 e5             	mov    %rsp,%rbp
  101618:	48 83 ec 20          	sub    $0x20,%rsp
  10161c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101620:	89 f0                	mov    %esi,%eax
  101622:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101625:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101628:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10162c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101630:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101634:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101638:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10163c:	48 8b 40 10          	mov    0x10(%rax),%rax
  101640:	48 39 c2             	cmp    %rax,%rdx
  101643:	73 1a                	jae    10165f <string_putc+0x4f>
        *sp->s++ = c;
  101645:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101649:	48 8b 40 08          	mov    0x8(%rax),%rax
  10164d:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101651:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101655:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101659:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10165d:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  10165f:	90                   	nop
  101660:	c9                   	leave  
  101661:	c3                   	ret    

0000000000101662 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101662:	f3 0f 1e fa          	endbr64 
  101666:	55                   	push   %rbp
  101667:	48 89 e5             	mov    %rsp,%rbp
  10166a:	48 83 ec 40          	sub    $0x40,%rsp
  10166e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101672:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101676:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10167a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  10167e:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 101610 <string_putc>
  101685:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  101689:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10168d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101691:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101696:	74 33                	je     1016cb <vsnprintf+0x69>
        sp.end = s + size - 1;
  101698:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  10169c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1016a0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1016a4:	48 01 d0             	add    %rdx,%rax
  1016a7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1016ab:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1016af:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1016b3:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1016b7:	be 00 00 00 00       	mov    $0x0,%esi
  1016bc:	48 89 c7             	mov    %rax,%rdi
  1016bf:	e8 7d f3 ff ff       	call   100a41 <printer_vprintf>
        *sp.s = 0;
  1016c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1016c8:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1016cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1016cf:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1016d3:	c9                   	leave  
  1016d4:	c3                   	ret    

00000000001016d5 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1016d5:	f3 0f 1e fa          	endbr64 
  1016d9:	55                   	push   %rbp
  1016da:	48 89 e5             	mov    %rsp,%rbp
  1016dd:	48 83 ec 70          	sub    $0x70,%rsp
  1016e1:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1016e5:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1016e9:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1016ed:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1016f1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1016f5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1016f9:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101700:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101704:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101708:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10170c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101710:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101714:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101718:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10171c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101720:	48 89 c7             	mov    %rax,%rdi
  101723:	e8 3a ff ff ff       	call   101662 <vsnprintf>
  101728:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10172b:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10172e:	c9                   	leave  
  10172f:	c3                   	ret    

0000000000101730 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101730:	f3 0f 1e fa          	endbr64 
  101734:	55                   	push   %rbp
  101735:	48 89 e5             	mov    %rsp,%rbp
  101738:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10173c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101743:	eb 1a                	jmp    10175f <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101745:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101748:	48 98                	cltq   
  10174a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  10174e:	48 8d 05 ab 68 fb ff 	lea    -0x49755(%rip),%rax        # b8000 <console>
  101755:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10175b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  10175f:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101766:	7e dd                	jle    101745 <console_clear+0x15>
    }
    cursorpos = 0;
  101768:	c7 05 8a 78 fb ff 00 	movl   $0x0,-0x48776(%rip)        # b8ffc <cursorpos>
  10176f:	00 00 00 
}
  101772:	90                   	nop
  101773:	c9                   	leave  
  101774:	c3                   	ret    
