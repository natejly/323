
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:

uint8_t * heap_top;
uint8_t * heap_bottom;
uint8_t * stack_bottom;

void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000c:	cd 31                	int    $0x31
  10000e:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  100010:	e8 05 06 00 00       	call   10061a <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100015:	48 8d 05 0b 30 00 00 	lea    0x300b(%rip),%rax        # 103027 <end+0xfff>
  10001c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100022:	48 89 05 e7 1f 00 00 	mov    %rax,0x1fe7(%rip)        # 102010 <heap_top>
  100029:	48 89 05 d8 1f 00 00 	mov    %rax,0x1fd8(%rip)        # 102008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100030:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100033:	48 83 e8 01          	sub    $0x1,%rax
  100037:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10003d:	48 89 05 bc 1f 00 00 	mov    %rax,0x1fbc(%rip)        # 102000 <stack_bottom>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100044:	bf 00 54 00 00       	mov    $0x5400,%edi
  100049:	cd 3a                	int    $0x3a
  10004b:	48 89 05 c6 1f 00 00 	mov    %rax,0x1fc6(%rip)        # 102018 <result.0>

    /* move the break forward by 21KB -> ~5 pages */
    assert(sbrk(1024*21) == heap_bottom);
  100052:	48 39 05 af 1f 00 00 	cmp    %rax,0x1faf(%rip)        # 102008 <heap_bottom>
  100059:	74 18                	je     100073 <process_main+0x73>
  10005b:	48 8d 15 9e 13 00 00 	lea    0x139e(%rip),%rdx        # 101400 <console_clear+0x46>
  100062:	be 14 00 00 00       	mov    $0x14,%esi
  100067:	48 8d 3d af 13 00 00 	lea    0x13af(%rip),%rdi        # 10141d <console_clear+0x63>
  10006e:	e8 57 02 00 00       	call   1002ca <assert_fail>
  100073:	bf 00 00 00 00       	mov    $0x0,%edi
  100078:	cd 3a                	int    $0x3a
  10007a:	48 89 05 97 1f 00 00 	mov    %rax,0x1f97(%rip)        # 102018 <result.0>

    /* get the new break */
    heap_top = (uint8_t *)sbrk(0);
  100081:	48 89 05 88 1f 00 00 	mov    %rax,0x1f88(%rip)        # 102010 <heap_top>

    /* force the pages to be allocated */
    for(size_t i = 0; i < (uintptr_t)(heap_top - heap_bottom); ++i) {
  100088:	48 8b 15 79 1f 00 00 	mov    0x1f79(%rip),%rdx        # 102008 <heap_bottom>
  10008f:	48 39 d0             	cmp    %rdx,%rax
  100092:	74 29                	je     1000bd <process_main+0xbd>
  100094:	b8 00 00 00 00       	mov    $0x0,%eax
        heap_bottom[i] = 'A';
  100099:	c6 04 02 41          	movb   $0x41,(%rdx,%rax,1)
        assert(heap_bottom[i] == 'A');
  10009d:	48 8b 15 64 1f 00 00 	mov    0x1f64(%rip),%rdx        # 102008 <heap_bottom>
  1000a4:	80 3c 02 41          	cmpb   $0x41,(%rdx,%rax,1)
  1000a8:	75 47                	jne    1000f1 <process_main+0xf1>
    for(size_t i = 0; i < (uintptr_t)(heap_top - heap_bottom); ++i) {
  1000aa:	48 83 c0 01          	add    $0x1,%rax
  1000ae:	48 8b 0d 5b 1f 00 00 	mov    0x1f5b(%rip),%rcx        # 102010 <heap_top>
  1000b5:	48 29 d1             	sub    %rdx,%rcx
  1000b8:	48 39 c1             	cmp    %rax,%rcx
  1000bb:	77 dc                	ja     100099 <process_main+0x99>
  1000bd:	48 c7 c7 00 ac ff ff 	mov    $0xffffffffffffac00,%rdi
  1000c4:	cd 3a                	int    $0x3a
  1000c6:	48 89 05 4b 1f 00 00 	mov    %rax,0x1f4b(%rip)        # 102018 <result.0>
    }

    /* Break unmodied after optimistic allocation, move it back 21KB. */
    assert(sbrk(-1024*21) == heap_top);
  1000cd:	48 8b 15 3c 1f 00 00 	mov    0x1f3c(%rip),%rdx        # 102010 <heap_top>
  1000d4:	48 39 c2             	cmp    %rax,%rdx
  1000d7:	74 30                	je     100109 <process_main+0x109>
  1000d9:	48 8d 15 63 13 00 00 	lea    0x1363(%rip),%rdx        # 101443 <console_clear+0x89>
  1000e0:	be 20 00 00 00       	mov    $0x20,%esi
  1000e5:	48 8d 3d 31 13 00 00 	lea    0x1331(%rip),%rdi        # 10141d <console_clear+0x63>
  1000ec:	e8 d9 01 00 00       	call   1002ca <assert_fail>
        assert(heap_bottom[i] == 'A');
  1000f1:	48 8d 15 35 13 00 00 	lea    0x1335(%rip),%rdx        # 10142d <console_clear+0x73>
  1000f8:	be 1c 00 00 00       	mov    $0x1c,%esi
  1000fd:	48 8d 3d 19 13 00 00 	lea    0x1319(%rip),%rdi        # 10141d <console_clear+0x63>
  100104:	e8 c1 01 00 00       	call   1002ca <assert_fail>

    /* check that pages were deallocated */
    for(uintptr_t va = (uintptr_t)heap_bottom; va < (uintptr_t)heap_top; va += 4096) {
  100109:	48 8b 35 f8 1e 00 00 	mov    0x1ef8(%rip),%rsi        # 102008 <heap_bottom>
  100110:	48 39 f2             	cmp    %rsi,%rdx
  100113:	76 1c                	jbe    100131 <process_main+0x131>
    asm volatile ("int %0" : /* no result */
  100115:	48 8d 7d e8          	lea    -0x18(%rbp),%rdi
  100119:	cd 36                	int    $0x36
        vamapping map;
        mapping(va, &map);
	assert(!(map.perm & PTE_P));
  10011b:	f6 45 f8 01          	testb  $0x1,-0x8(%rbp)
  10011f:	75 21                	jne    100142 <process_main+0x142>
    for(uintptr_t va = (uintptr_t)heap_bottom; va < (uintptr_t)heap_top; va += 4096) {
  100121:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
  100128:	48 39 35 e1 1e 00 00 	cmp    %rsi,0x1ee1(%rip)        # 102010 <heap_top>
  10012f:	77 e8                	ja     100119 <process_main+0x119>
    }
    TEST_PASS();
  100131:	48 8d 3d 3a 13 00 00 	lea    0x133a(%rip),%rdi        # 101472 <console_clear+0xb8>
  100138:	b8 00 00 00 00       	mov    $0x0,%eax
  10013d:	e8 b0 00 00 00       	call   1001f2 <kernel_panic>
	assert(!(map.perm & PTE_P));
  100142:	48 8d 15 15 13 00 00 	lea    0x1315(%rip),%rdx        # 10145e <console_clear+0xa4>
  100149:	be 26 00 00 00       	mov    $0x26,%esi
  10014e:	48 8d 3d c8 12 00 00 	lea    0x12c8(%rip),%rdi        # 10141d <console_clear+0x63>
  100155:	e8 70 01 00 00       	call   1002ca <assert_fail>

000000000010015a <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  10015a:	f3 0f 1e fa          	endbr64 
  10015e:	55                   	push   %rbp
  10015f:	48 89 e5             	mov    %rsp,%rbp
  100162:	48 83 ec 50          	sub    $0x50,%rsp
  100166:	49 89 f2             	mov    %rsi,%r10
  100169:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10016d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100171:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100175:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100179:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  10017e:	85 ff                	test   %edi,%edi
  100180:	78 32                	js     1001b4 <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100182:	48 63 ff             	movslq %edi,%rdi
  100185:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  10018c:	cc cc cc 
  10018f:	48 89 f8             	mov    %rdi,%rax
  100192:	48 f7 e2             	mul    %rdx
  100195:	48 89 d0             	mov    %rdx,%rax
  100198:	48 c1 e8 02          	shr    $0x2,%rax
  10019c:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1001a0:	48 01 c2             	add    %rax,%rdx
  1001a3:	48 29 d7             	sub    %rdx,%rdi
  1001a6:	48 8d 05 18 13 00 00 	lea    0x1318(%rip),%rax        # 1014c5 <col.0>
  1001ad:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  1001b1:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1001b4:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1001bb:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001bf:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1001c3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1001c7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1001cb:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1001cf:	4c 89 d2             	mov    %r10,%rdx
  1001d2:	8b 3d 24 8e fb ff    	mov    -0x471dc(%rip),%edi        # b8ffc <cursorpos>
  1001d8:	e8 eb 0f 00 00       	call   1011c8 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1001dd:	3d 30 07 00 00       	cmp    $0x730,%eax
  1001e2:	ba 00 00 00 00       	mov    $0x0,%edx
  1001e7:	0f 4d c2             	cmovge %edx,%eax
  1001ea:	89 05 0c 8e fb ff    	mov    %eax,-0x471f4(%rip)        # b8ffc <cursorpos>
    }
}
  1001f0:	c9                   	leave  
  1001f1:	c3                   	ret    

00000000001001f2 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  1001f2:	f3 0f 1e fa          	endbr64 
  1001f6:	55                   	push   %rbp
  1001f7:	48 89 e5             	mov    %rsp,%rbp
  1001fa:	53                   	push   %rbx
  1001fb:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100202:	48 89 fb             	mov    %rdi,%rbx
  100205:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100209:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10020d:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100211:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100215:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100219:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100220:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100224:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100228:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  10022c:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100230:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100237:	ba 07 00 00 00       	mov    $0x7,%edx
  10023c:	48 8d 35 4a 12 00 00 	lea    0x124a(%rip),%rsi        # 10148d <console_clear+0xd3>
  100243:	e8 b7 00 00 00       	call   1002ff <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100248:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  10024c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100253:	48 89 da             	mov    %rbx,%rdx
  100256:	be 99 00 00 00       	mov    $0x99,%esi
  10025b:	e8 8c 10 00 00       	call   1012ec <vsnprintf>
  100260:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100263:	85 d2                	test   %edx,%edx
  100265:	7e 0f                	jle    100276 <kernel_panic+0x84>
  100267:	83 c0 06             	add    $0x6,%eax
  10026a:	48 98                	cltq   
  10026c:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100273:	0a 
  100274:	75 2c                	jne    1002a2 <kernel_panic+0xb0>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100276:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  10027d:	48 89 d9             	mov    %rbx,%rcx
  100280:	48 8d 15 10 12 00 00 	lea    0x1210(%rip),%rdx        # 101497 <console_clear+0xdd>
  100287:	be 00 c0 00 00       	mov    $0xc000,%esi
  10028c:	bf 30 07 00 00       	mov    $0x730,%edi
  100291:	b8 00 00 00 00       	mov    $0x0,%eax
  100296:	e8 a9 0f 00 00       	call   101244 <console_printf>
    asm volatile ("int %0" : /* no result */
  10029b:	48 89 df             	mov    %rbx,%rdi
  10029e:	cd 30                	int    $0x30
 loop: goto loop;
  1002a0:	eb fe                	jmp    1002a0 <kernel_panic+0xae>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1002a2:	48 63 c2             	movslq %edx,%rax
  1002a5:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1002ab:	0f 94 c2             	sete   %dl
  1002ae:	0f b6 d2             	movzbl %dl,%edx
  1002b1:	48 29 d0             	sub    %rdx,%rax
  1002b4:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1002bb:	ff 
  1002bc:	48 8d 35 d2 11 00 00 	lea    0x11d2(%rip),%rsi        # 101495 <console_clear+0xdb>
  1002c3:	e8 f8 01 00 00       	call   1004c0 <strcpy>
  1002c8:	eb ac                	jmp    100276 <kernel_panic+0x84>

00000000001002ca <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1002ca:	f3 0f 1e fa          	endbr64 
  1002ce:	55                   	push   %rbp
  1002cf:	48 89 e5             	mov    %rsp,%rbp
  1002d2:	48 89 f9             	mov    %rdi,%rcx
  1002d5:	41 89 f0             	mov    %esi,%r8d
  1002d8:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1002db:	48 8d 15 be 11 00 00 	lea    0x11be(%rip),%rdx        # 1014a0 <console_clear+0xe6>
  1002e2:	be 00 c0 00 00       	mov    $0xc000,%esi
  1002e7:	bf 30 07 00 00       	mov    $0x730,%edi
  1002ec:	b8 00 00 00 00       	mov    $0x0,%eax
  1002f1:	e8 4e 0f 00 00       	call   101244 <console_printf>
    asm volatile ("int %0" : /* no result */
  1002f6:	bf 00 00 00 00       	mov    $0x0,%edi
  1002fb:	cd 30                	int    $0x30
 loop: goto loop;
  1002fd:	eb fe                	jmp    1002fd <assert_fail+0x33>

00000000001002ff <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1002ff:	f3 0f 1e fa          	endbr64 
  100303:	55                   	push   %rbp
  100304:	48 89 e5             	mov    %rsp,%rbp
  100307:	48 83 ec 28          	sub    $0x28,%rsp
  10030b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10030f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100313:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100317:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10031b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10031f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100323:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100327:	eb 1c                	jmp    100345 <memcpy+0x46>
        *d = *s;
  100329:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10032d:	0f b6 10             	movzbl (%rax),%edx
  100330:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100334:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100336:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10033b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100340:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100345:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10034a:	75 dd                	jne    100329 <memcpy+0x2a>
    }
    return dst;
  10034c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100350:	c9                   	leave  
  100351:	c3                   	ret    

0000000000100352 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100352:	f3 0f 1e fa          	endbr64 
  100356:	55                   	push   %rbp
  100357:	48 89 e5             	mov    %rsp,%rbp
  10035a:	48 83 ec 28          	sub    $0x28,%rsp
  10035e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100362:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100366:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10036a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10036e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100372:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100376:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  10037a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10037e:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100382:	73 6a                	jae    1003ee <memmove+0x9c>
  100384:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100388:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10038c:	48 01 d0             	add    %rdx,%rax
  10038f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100393:	73 59                	jae    1003ee <memmove+0x9c>
        s += n, d += n;
  100395:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100399:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  10039d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003a1:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1003a5:	eb 17                	jmp    1003be <memmove+0x6c>
            *--d = *--s;
  1003a7:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1003ac:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1003b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003b5:	0f b6 10             	movzbl (%rax),%edx
  1003b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003bc:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003be:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003c2:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003c6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003ca:	48 85 c0             	test   %rax,%rax
  1003cd:	75 d8                	jne    1003a7 <memmove+0x55>
    if (s < d && s + n > d) {
  1003cf:	eb 2e                	jmp    1003ff <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1003d1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1003d5:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003d9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003e1:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003e5:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1003e9:	0f b6 12             	movzbl (%rdx),%edx
  1003ec:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003f2:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003f6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003fa:	48 85 c0             	test   %rax,%rax
  1003fd:	75 d2                	jne    1003d1 <memmove+0x7f>
        }
    }
    return dst;
  1003ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100403:	c9                   	leave  
  100404:	c3                   	ret    

0000000000100405 <memset>:

void* memset(void* v, int c, size_t n) {
  100405:	f3 0f 1e fa          	endbr64 
  100409:	55                   	push   %rbp
  10040a:	48 89 e5             	mov    %rsp,%rbp
  10040d:	48 83 ec 28          	sub    $0x28,%rsp
  100411:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100415:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100418:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10041c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100420:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100424:	eb 15                	jmp    10043b <memset+0x36>
        *p = c;
  100426:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100429:	89 c2                	mov    %eax,%edx
  10042b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10042f:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100431:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100436:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10043b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100440:	75 e4                	jne    100426 <memset+0x21>
    }
    return v;
  100442:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100446:	c9                   	leave  
  100447:	c3                   	ret    

0000000000100448 <strlen>:

size_t strlen(const char* s) {
  100448:	f3 0f 1e fa          	endbr64 
  10044c:	55                   	push   %rbp
  10044d:	48 89 e5             	mov    %rsp,%rbp
  100450:	48 83 ec 18          	sub    $0x18,%rsp
  100454:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100458:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10045f:	00 
  100460:	eb 0a                	jmp    10046c <strlen+0x24>
        ++n;
  100462:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100467:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10046c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100470:	0f b6 00             	movzbl (%rax),%eax
  100473:	84 c0                	test   %al,%al
  100475:	75 eb                	jne    100462 <strlen+0x1a>
    }
    return n;
  100477:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  10047b:	c9                   	leave  
  10047c:	c3                   	ret    

000000000010047d <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  10047d:	f3 0f 1e fa          	endbr64 
  100481:	55                   	push   %rbp
  100482:	48 89 e5             	mov    %rsp,%rbp
  100485:	48 83 ec 20          	sub    $0x20,%rsp
  100489:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10048d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100491:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100498:	00 
  100499:	eb 0a                	jmp    1004a5 <strnlen+0x28>
        ++n;
  10049b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1004a0:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1004a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004a9:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1004ad:	74 0b                	je     1004ba <strnlen+0x3d>
  1004af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004b3:	0f b6 00             	movzbl (%rax),%eax
  1004b6:	84 c0                	test   %al,%al
  1004b8:	75 e1                	jne    10049b <strnlen+0x1e>
    }
    return n;
  1004ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1004be:	c9                   	leave  
  1004bf:	c3                   	ret    

00000000001004c0 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1004c0:	f3 0f 1e fa          	endbr64 
  1004c4:	55                   	push   %rbp
  1004c5:	48 89 e5             	mov    %rsp,%rbp
  1004c8:	48 83 ec 20          	sub    $0x20,%rsp
  1004cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1004d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1004d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004d8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1004dc:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1004e0:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004e4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1004e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004ec:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004f0:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1004f4:	0f b6 12             	movzbl (%rdx),%edx
  1004f7:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1004f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004fd:	48 83 e8 01          	sub    $0x1,%rax
  100501:	0f b6 00             	movzbl (%rax),%eax
  100504:	84 c0                	test   %al,%al
  100506:	75 d4                	jne    1004dc <strcpy+0x1c>
    return dst;
  100508:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10050c:	c9                   	leave  
  10050d:	c3                   	ret    

000000000010050e <strcmp>:

int strcmp(const char* a, const char* b) {
  10050e:	f3 0f 1e fa          	endbr64 
  100512:	55                   	push   %rbp
  100513:	48 89 e5             	mov    %rsp,%rbp
  100516:	48 83 ec 10          	sub    $0x10,%rsp
  10051a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10051e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100522:	eb 0a                	jmp    10052e <strcmp+0x20>
        ++a, ++b;
  100524:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100529:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10052e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100532:	0f b6 00             	movzbl (%rax),%eax
  100535:	84 c0                	test   %al,%al
  100537:	74 1d                	je     100556 <strcmp+0x48>
  100539:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10053d:	0f b6 00             	movzbl (%rax),%eax
  100540:	84 c0                	test   %al,%al
  100542:	74 12                	je     100556 <strcmp+0x48>
  100544:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100548:	0f b6 10             	movzbl (%rax),%edx
  10054b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10054f:	0f b6 00             	movzbl (%rax),%eax
  100552:	38 c2                	cmp    %al,%dl
  100554:	74 ce                	je     100524 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100556:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10055a:	0f b6 00             	movzbl (%rax),%eax
  10055d:	89 c2                	mov    %eax,%edx
  10055f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100563:	0f b6 00             	movzbl (%rax),%eax
  100566:	38 c2                	cmp    %al,%dl
  100568:	0f 97 c0             	seta   %al
  10056b:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  10056e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100572:	0f b6 00             	movzbl (%rax),%eax
  100575:	89 c1                	mov    %eax,%ecx
  100577:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10057b:	0f b6 00             	movzbl (%rax),%eax
  10057e:	38 c1                	cmp    %al,%cl
  100580:	0f 92 c0             	setb   %al
  100583:	0f b6 c8             	movzbl %al,%ecx
  100586:	89 d0                	mov    %edx,%eax
  100588:	29 c8                	sub    %ecx,%eax
}
  10058a:	c9                   	leave  
  10058b:	c3                   	ret    

000000000010058c <strchr>:

char* strchr(const char* s, int c) {
  10058c:	f3 0f 1e fa          	endbr64 
  100590:	55                   	push   %rbp
  100591:	48 89 e5             	mov    %rsp,%rbp
  100594:	48 83 ec 10          	sub    $0x10,%rsp
  100598:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  10059c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  10059f:	eb 05                	jmp    1005a6 <strchr+0x1a>
        ++s;
  1005a1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1005a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005aa:	0f b6 00             	movzbl (%rax),%eax
  1005ad:	84 c0                	test   %al,%al
  1005af:	74 0e                	je     1005bf <strchr+0x33>
  1005b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005b5:	0f b6 00             	movzbl (%rax),%eax
  1005b8:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1005bb:	38 d0                	cmp    %dl,%al
  1005bd:	75 e2                	jne    1005a1 <strchr+0x15>
    }
    if (*s == (char) c) {
  1005bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005c3:	0f b6 00             	movzbl (%rax),%eax
  1005c6:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1005c9:	38 d0                	cmp    %dl,%al
  1005cb:	75 06                	jne    1005d3 <strchr+0x47>
        return (char*) s;
  1005cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005d1:	eb 05                	jmp    1005d8 <strchr+0x4c>
    } else {
        return NULL;
  1005d3:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1005d8:	c9                   	leave  
  1005d9:	c3                   	ret    

00000000001005da <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1005da:	f3 0f 1e fa          	endbr64 
  1005de:	55                   	push   %rbp
  1005df:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1005e2:	8b 05 38 1a 00 00    	mov    0x1a38(%rip),%eax        # 102020 <rand_seed_set>
  1005e8:	85 c0                	test   %eax,%eax
  1005ea:	75 0a                	jne    1005f6 <rand+0x1c>
        srand(819234718U);
  1005ec:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1005f1:	e8 24 00 00 00       	call   10061a <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1005f6:	8b 05 28 1a 00 00    	mov    0x1a28(%rip),%eax        # 102024 <rand_seed>
  1005fc:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100602:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100607:	89 05 17 1a 00 00    	mov    %eax,0x1a17(%rip)        # 102024 <rand_seed>
    return rand_seed & RAND_MAX;
  10060d:	8b 05 11 1a 00 00    	mov    0x1a11(%rip),%eax        # 102024 <rand_seed>
  100613:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100618:	5d                   	pop    %rbp
  100619:	c3                   	ret    

000000000010061a <srand>:

void srand(unsigned seed) {
  10061a:	f3 0f 1e fa          	endbr64 
  10061e:	55                   	push   %rbp
  10061f:	48 89 e5             	mov    %rsp,%rbp
  100622:	48 83 ec 08          	sub    $0x8,%rsp
  100626:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100629:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10062c:	89 05 f2 19 00 00    	mov    %eax,0x19f2(%rip)        # 102024 <rand_seed>
    rand_seed_set = 1;
  100632:	c7 05 e4 19 00 00 01 	movl   $0x1,0x19e4(%rip)        # 102020 <rand_seed_set>
  100639:	00 00 00 
}
  10063c:	90                   	nop
  10063d:	c9                   	leave  
  10063e:	c3                   	ret    

000000000010063f <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10063f:	f3 0f 1e fa          	endbr64 
  100643:	55                   	push   %rbp
  100644:	48 89 e5             	mov    %rsp,%rbp
  100647:	48 83 ec 28          	sub    $0x28,%rsp
  10064b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10064f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100653:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100656:	48 8d 05 73 0f 00 00 	lea    0xf73(%rip),%rax        # 1015d0 <upper_digits.1>
  10065d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  100661:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100665:	79 0e                	jns    100675 <fill_numbuf+0x36>
        digits = lower_digits;
  100667:	48 8d 05 82 0f 00 00 	lea    0xf82(%rip),%rax        # 1015f0 <lower_digits.0>
  10066e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  100672:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100675:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10067a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10067e:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100681:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100684:	48 63 c8             	movslq %eax,%rcx
  100687:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10068b:	ba 00 00 00 00       	mov    $0x0,%edx
  100690:	48 f7 f1             	div    %rcx
  100693:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100697:	48 01 d0             	add    %rdx,%rax
  10069a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10069f:	0f b6 10             	movzbl (%rax),%edx
  1006a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006a6:	88 10                	mov    %dl,(%rax)
        val /= base;
  1006a8:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1006ab:	48 63 f0             	movslq %eax,%rsi
  1006ae:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1006b2:	ba 00 00 00 00       	mov    $0x0,%edx
  1006b7:	48 f7 f6             	div    %rsi
  1006ba:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1006be:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1006c3:	75 bc                	jne    100681 <fill_numbuf+0x42>
    return numbuf_end;
  1006c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1006c9:	c9                   	leave  
  1006ca:	c3                   	ret    

00000000001006cb <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1006cb:	f3 0f 1e fa          	endbr64 
  1006cf:	55                   	push   %rbp
  1006d0:	48 89 e5             	mov    %rsp,%rbp
  1006d3:	53                   	push   %rbx
  1006d4:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1006db:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1006e2:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1006e8:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1006ef:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1006f6:	e9 bd 09 00 00       	jmp    1010b8 <printer_vprintf+0x9ed>
        if (*format != '%') {
  1006fb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100702:	0f b6 00             	movzbl (%rax),%eax
  100705:	3c 25                	cmp    $0x25,%al
  100707:	74 31                	je     10073a <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  100709:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100710:	4c 8b 00             	mov    (%rax),%r8
  100713:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10071a:	0f b6 00             	movzbl (%rax),%eax
  10071d:	0f b6 c8             	movzbl %al,%ecx
  100720:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100726:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10072d:	89 ce                	mov    %ecx,%esi
  10072f:	48 89 c7             	mov    %rax,%rdi
  100732:	41 ff d0             	call   *%r8
            continue;
  100735:	e9 76 09 00 00       	jmp    1010b0 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  10073a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100741:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100748:	01 
  100749:	eb 4d                	jmp    100798 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  10074b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100752:	0f b6 00             	movzbl (%rax),%eax
  100755:	0f be c0             	movsbl %al,%eax
  100758:	89 c6                	mov    %eax,%esi
  10075a:	48 8d 05 6f 0d 00 00 	lea    0xd6f(%rip),%rax        # 1014d0 <flag_chars>
  100761:	48 89 c7             	mov    %rax,%rdi
  100764:	e8 23 fe ff ff       	call   10058c <strchr>
  100769:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  10076d:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100772:	74 34                	je     1007a8 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  100774:	48 8d 15 55 0d 00 00 	lea    0xd55(%rip),%rdx        # 1014d0 <flag_chars>
  10077b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  10077f:	48 29 d0             	sub    %rdx,%rax
  100782:	ba 01 00 00 00       	mov    $0x1,%edx
  100787:	89 c1                	mov    %eax,%ecx
  100789:	d3 e2                	shl    %cl,%edx
  10078b:	89 d0                	mov    %edx,%eax
  10078d:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100790:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100797:	01 
  100798:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10079f:	0f b6 00             	movzbl (%rax),%eax
  1007a2:	84 c0                	test   %al,%al
  1007a4:	75 a5                	jne    10074b <printer_vprintf+0x80>
  1007a6:	eb 01                	jmp    1007a9 <printer_vprintf+0xde>
            } else {
                break;
  1007a8:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1007a9:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1007b0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007b7:	0f b6 00             	movzbl (%rax),%eax
  1007ba:	3c 30                	cmp    $0x30,%al
  1007bc:	7e 67                	jle    100825 <printer_vprintf+0x15a>
  1007be:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007c5:	0f b6 00             	movzbl (%rax),%eax
  1007c8:	3c 39                	cmp    $0x39,%al
  1007ca:	7f 59                	jg     100825 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1007cc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1007d3:	eb 2e                	jmp    100803 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  1007d5:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1007d8:	89 d0                	mov    %edx,%eax
  1007da:	c1 e0 02             	shl    $0x2,%eax
  1007dd:	01 d0                	add    %edx,%eax
  1007df:	01 c0                	add    %eax,%eax
  1007e1:	89 c1                	mov    %eax,%ecx
  1007e3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007ea:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1007ee:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007f5:	0f b6 00             	movzbl (%rax),%eax
  1007f8:	0f be c0             	movsbl %al,%eax
  1007fb:	01 c8                	add    %ecx,%eax
  1007fd:	83 e8 30             	sub    $0x30,%eax
  100800:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100803:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10080a:	0f b6 00             	movzbl (%rax),%eax
  10080d:	3c 2f                	cmp    $0x2f,%al
  10080f:	0f 8e 85 00 00 00    	jle    10089a <printer_vprintf+0x1cf>
  100815:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10081c:	0f b6 00             	movzbl (%rax),%eax
  10081f:	3c 39                	cmp    $0x39,%al
  100821:	7e b2                	jle    1007d5 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  100823:	eb 75                	jmp    10089a <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  100825:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10082c:	0f b6 00             	movzbl (%rax),%eax
  10082f:	3c 2a                	cmp    $0x2a,%al
  100831:	75 68                	jne    10089b <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  100833:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10083a:	8b 00                	mov    (%rax),%eax
  10083c:	83 f8 2f             	cmp    $0x2f,%eax
  10083f:	77 30                	ja     100871 <printer_vprintf+0x1a6>
  100841:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100848:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10084c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100853:	8b 00                	mov    (%rax),%eax
  100855:	89 c0                	mov    %eax,%eax
  100857:	48 01 d0             	add    %rdx,%rax
  10085a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100861:	8b 12                	mov    (%rdx),%edx
  100863:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100866:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10086d:	89 0a                	mov    %ecx,(%rdx)
  10086f:	eb 1a                	jmp    10088b <printer_vprintf+0x1c0>
  100871:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100878:	48 8b 40 08          	mov    0x8(%rax),%rax
  10087c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100880:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100887:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10088b:	8b 00                	mov    (%rax),%eax
  10088d:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100890:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100897:	01 
  100898:	eb 01                	jmp    10089b <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  10089a:	90                   	nop
        }

        // process precision
        int precision = -1;
  10089b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1008a2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008a9:	0f b6 00             	movzbl (%rax),%eax
  1008ac:	3c 2e                	cmp    $0x2e,%al
  1008ae:	0f 85 00 01 00 00    	jne    1009b4 <printer_vprintf+0x2e9>
            ++format;
  1008b4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1008bb:	01 
            if (*format >= '0' && *format <= '9') {
  1008bc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008c3:	0f b6 00             	movzbl (%rax),%eax
  1008c6:	3c 2f                	cmp    $0x2f,%al
  1008c8:	7e 67                	jle    100931 <printer_vprintf+0x266>
  1008ca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008d1:	0f b6 00             	movzbl (%rax),%eax
  1008d4:	3c 39                	cmp    $0x39,%al
  1008d6:	7f 59                	jg     100931 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008d8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1008df:	eb 2e                	jmp    10090f <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  1008e1:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1008e4:	89 d0                	mov    %edx,%eax
  1008e6:	c1 e0 02             	shl    $0x2,%eax
  1008e9:	01 d0                	add    %edx,%eax
  1008eb:	01 c0                	add    %eax,%eax
  1008ed:	89 c1                	mov    %eax,%ecx
  1008ef:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008f6:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1008fa:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100901:	0f b6 00             	movzbl (%rax),%eax
  100904:	0f be c0             	movsbl %al,%eax
  100907:	01 c8                	add    %ecx,%eax
  100909:	83 e8 30             	sub    $0x30,%eax
  10090c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10090f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100916:	0f b6 00             	movzbl (%rax),%eax
  100919:	3c 2f                	cmp    $0x2f,%al
  10091b:	0f 8e 85 00 00 00    	jle    1009a6 <printer_vprintf+0x2db>
  100921:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100928:	0f b6 00             	movzbl (%rax),%eax
  10092b:	3c 39                	cmp    $0x39,%al
  10092d:	7e b2                	jle    1008e1 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  10092f:	eb 75                	jmp    1009a6 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  100931:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100938:	0f b6 00             	movzbl (%rax),%eax
  10093b:	3c 2a                	cmp    $0x2a,%al
  10093d:	75 68                	jne    1009a7 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  10093f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100946:	8b 00                	mov    (%rax),%eax
  100948:	83 f8 2f             	cmp    $0x2f,%eax
  10094b:	77 30                	ja     10097d <printer_vprintf+0x2b2>
  10094d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100954:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100958:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10095f:	8b 00                	mov    (%rax),%eax
  100961:	89 c0                	mov    %eax,%eax
  100963:	48 01 d0             	add    %rdx,%rax
  100966:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10096d:	8b 12                	mov    (%rdx),%edx
  10096f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100972:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100979:	89 0a                	mov    %ecx,(%rdx)
  10097b:	eb 1a                	jmp    100997 <printer_vprintf+0x2cc>
  10097d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100984:	48 8b 40 08          	mov    0x8(%rax),%rax
  100988:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10098c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100993:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100997:	8b 00                	mov    (%rax),%eax
  100999:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  10099c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009a3:	01 
  1009a4:	eb 01                	jmp    1009a7 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  1009a6:	90                   	nop
            }
            if (precision < 0) {
  1009a7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1009ab:	79 07                	jns    1009b4 <printer_vprintf+0x2e9>
                precision = 0;
  1009ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  1009b4:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  1009bb:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  1009c2:	00 
        int length = 0;
  1009c3:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  1009ca:	48 8d 05 05 0b 00 00 	lea    0xb05(%rip),%rax        # 1014d6 <flag_chars+0x6>
  1009d1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  1009d5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009dc:	0f b6 00             	movzbl (%rax),%eax
  1009df:	0f be c0             	movsbl %al,%eax
  1009e2:	83 e8 43             	sub    $0x43,%eax
  1009e5:	83 f8 37             	cmp    $0x37,%eax
  1009e8:	0f 87 b6 03 00 00    	ja     100da4 <printer_vprintf+0x6d9>
  1009ee:	89 c0                	mov    %eax,%eax
  1009f0:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  1009f7:	00 
  1009f8:	48 8d 05 e5 0a 00 00 	lea    0xae5(%rip),%rax        # 1014e4 <flag_chars+0x14>
  1009ff:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  100a02:	48 98                	cltq   
  100a04:	48 8d 15 d9 0a 00 00 	lea    0xad9(%rip),%rdx        # 1014e4 <flag_chars+0x14>
  100a0b:	48 01 d0             	add    %rdx,%rax
  100a0e:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  100a11:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100a18:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a1f:	01 
            goto again;
  100a20:	eb b3                	jmp    1009d5 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100a22:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100a26:	74 5d                	je     100a85 <printer_vprintf+0x3ba>
  100a28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a2f:	8b 00                	mov    (%rax),%eax
  100a31:	83 f8 2f             	cmp    $0x2f,%eax
  100a34:	77 30                	ja     100a66 <printer_vprintf+0x39b>
  100a36:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a3d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a41:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a48:	8b 00                	mov    (%rax),%eax
  100a4a:	89 c0                	mov    %eax,%eax
  100a4c:	48 01 d0             	add    %rdx,%rax
  100a4f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a56:	8b 12                	mov    (%rdx),%edx
  100a58:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a5b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a62:	89 0a                	mov    %ecx,(%rdx)
  100a64:	eb 1a                	jmp    100a80 <printer_vprintf+0x3b5>
  100a66:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a6d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a71:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a75:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a7c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a80:	48 8b 00             	mov    (%rax),%rax
  100a83:	eb 5c                	jmp    100ae1 <printer_vprintf+0x416>
  100a85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a8c:	8b 00                	mov    (%rax),%eax
  100a8e:	83 f8 2f             	cmp    $0x2f,%eax
  100a91:	77 30                	ja     100ac3 <printer_vprintf+0x3f8>
  100a93:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a9a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a9e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aa5:	8b 00                	mov    (%rax),%eax
  100aa7:	89 c0                	mov    %eax,%eax
  100aa9:	48 01 d0             	add    %rdx,%rax
  100aac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ab3:	8b 12                	mov    (%rdx),%edx
  100ab5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ab8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100abf:	89 0a                	mov    %ecx,(%rdx)
  100ac1:	eb 1a                	jmp    100add <printer_vprintf+0x412>
  100ac3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aca:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ace:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ad2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ad9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100add:	8b 00                	mov    (%rax),%eax
  100adf:	48 98                	cltq   
  100ae1:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100ae5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ae9:	48 c1 f8 38          	sar    $0x38,%rax
  100aed:	25 80 00 00 00       	and    $0x80,%eax
  100af2:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100af5:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100af9:	74 09                	je     100b04 <printer_vprintf+0x439>
  100afb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100aff:	48 f7 d8             	neg    %rax
  100b02:	eb 04                	jmp    100b08 <printer_vprintf+0x43d>
  100b04:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100b08:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100b0c:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100b0f:	83 c8 60             	or     $0x60,%eax
  100b12:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100b15:	e9 cf 02 00 00       	jmp    100de9 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100b1a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100b1e:	74 5d                	je     100b7d <printer_vprintf+0x4b2>
  100b20:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b27:	8b 00                	mov    (%rax),%eax
  100b29:	83 f8 2f             	cmp    $0x2f,%eax
  100b2c:	77 30                	ja     100b5e <printer_vprintf+0x493>
  100b2e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b35:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b39:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b40:	8b 00                	mov    (%rax),%eax
  100b42:	89 c0                	mov    %eax,%eax
  100b44:	48 01 d0             	add    %rdx,%rax
  100b47:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b4e:	8b 12                	mov    (%rdx),%edx
  100b50:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b5a:	89 0a                	mov    %ecx,(%rdx)
  100b5c:	eb 1a                	jmp    100b78 <printer_vprintf+0x4ad>
  100b5e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b65:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b69:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b6d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b74:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b78:	48 8b 00             	mov    (%rax),%rax
  100b7b:	eb 5c                	jmp    100bd9 <printer_vprintf+0x50e>
  100b7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b84:	8b 00                	mov    (%rax),%eax
  100b86:	83 f8 2f             	cmp    $0x2f,%eax
  100b89:	77 30                	ja     100bbb <printer_vprintf+0x4f0>
  100b8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b92:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b96:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b9d:	8b 00                	mov    (%rax),%eax
  100b9f:	89 c0                	mov    %eax,%eax
  100ba1:	48 01 d0             	add    %rdx,%rax
  100ba4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bab:	8b 12                	mov    (%rdx),%edx
  100bad:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bb0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bb7:	89 0a                	mov    %ecx,(%rdx)
  100bb9:	eb 1a                	jmp    100bd5 <printer_vprintf+0x50a>
  100bbb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bc2:	48 8b 40 08          	mov    0x8(%rax),%rax
  100bc6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100bca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bd1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100bd5:	8b 00                	mov    (%rax),%eax
  100bd7:	89 c0                	mov    %eax,%eax
  100bd9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100bdd:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100be1:	e9 03 02 00 00       	jmp    100de9 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100be6:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100bed:	e9 28 ff ff ff       	jmp    100b1a <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100bf2:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100bf9:	e9 1c ff ff ff       	jmp    100b1a <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100bfe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c05:	8b 00                	mov    (%rax),%eax
  100c07:	83 f8 2f             	cmp    $0x2f,%eax
  100c0a:	77 30                	ja     100c3c <printer_vprintf+0x571>
  100c0c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c13:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c1e:	8b 00                	mov    (%rax),%eax
  100c20:	89 c0                	mov    %eax,%eax
  100c22:	48 01 d0             	add    %rdx,%rax
  100c25:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c2c:	8b 12                	mov    (%rdx),%edx
  100c2e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c31:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c38:	89 0a                	mov    %ecx,(%rdx)
  100c3a:	eb 1a                	jmp    100c56 <printer_vprintf+0x58b>
  100c3c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c43:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c47:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c4b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c52:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c56:	48 8b 00             	mov    (%rax),%rax
  100c59:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100c5d:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100c64:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100c6b:	e9 79 01 00 00       	jmp    100de9 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100c70:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c77:	8b 00                	mov    (%rax),%eax
  100c79:	83 f8 2f             	cmp    $0x2f,%eax
  100c7c:	77 30                	ja     100cae <printer_vprintf+0x5e3>
  100c7e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c85:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c90:	8b 00                	mov    (%rax),%eax
  100c92:	89 c0                	mov    %eax,%eax
  100c94:	48 01 d0             	add    %rdx,%rax
  100c97:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c9e:	8b 12                	mov    (%rdx),%edx
  100ca0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ca3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100caa:	89 0a                	mov    %ecx,(%rdx)
  100cac:	eb 1a                	jmp    100cc8 <printer_vprintf+0x5fd>
  100cae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cb5:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cb9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cbd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cc4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cc8:	48 8b 00             	mov    (%rax),%rax
  100ccb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100ccf:	e9 15 01 00 00       	jmp    100de9 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100cd4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cdb:	8b 00                	mov    (%rax),%eax
  100cdd:	83 f8 2f             	cmp    $0x2f,%eax
  100ce0:	77 30                	ja     100d12 <printer_vprintf+0x647>
  100ce2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ce9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ced:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cf4:	8b 00                	mov    (%rax),%eax
  100cf6:	89 c0                	mov    %eax,%eax
  100cf8:	48 01 d0             	add    %rdx,%rax
  100cfb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d02:	8b 12                	mov    (%rdx),%edx
  100d04:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d07:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d0e:	89 0a                	mov    %ecx,(%rdx)
  100d10:	eb 1a                	jmp    100d2c <printer_vprintf+0x661>
  100d12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d19:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d1d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d28:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d2c:	8b 00                	mov    (%rax),%eax
  100d2e:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100d34:	e9 77 03 00 00       	jmp    1010b0 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100d39:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d3d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100d41:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d48:	8b 00                	mov    (%rax),%eax
  100d4a:	83 f8 2f             	cmp    $0x2f,%eax
  100d4d:	77 30                	ja     100d7f <printer_vprintf+0x6b4>
  100d4f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d56:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d5a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d61:	8b 00                	mov    (%rax),%eax
  100d63:	89 c0                	mov    %eax,%eax
  100d65:	48 01 d0             	add    %rdx,%rax
  100d68:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d6f:	8b 12                	mov    (%rdx),%edx
  100d71:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d74:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d7b:	89 0a                	mov    %ecx,(%rdx)
  100d7d:	eb 1a                	jmp    100d99 <printer_vprintf+0x6ce>
  100d7f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d86:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d8a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d8e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d95:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d99:	8b 00                	mov    (%rax),%eax
  100d9b:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d9e:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100da2:	eb 45                	jmp    100de9 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100da4:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100da8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100dac:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100db3:	0f b6 00             	movzbl (%rax),%eax
  100db6:	84 c0                	test   %al,%al
  100db8:	74 0c                	je     100dc6 <printer_vprintf+0x6fb>
  100dba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dc1:	0f b6 00             	movzbl (%rax),%eax
  100dc4:	eb 05                	jmp    100dcb <printer_vprintf+0x700>
  100dc6:	b8 25 00 00 00       	mov    $0x25,%eax
  100dcb:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100dce:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100dd2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dd9:	0f b6 00             	movzbl (%rax),%eax
  100ddc:	84 c0                	test   %al,%al
  100dde:	75 08                	jne    100de8 <printer_vprintf+0x71d>
                format--;
  100de0:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100de7:	01 
            }
            break;
  100de8:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100de9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dec:	83 e0 20             	and    $0x20,%eax
  100def:	85 c0                	test   %eax,%eax
  100df1:	74 1e                	je     100e11 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100df3:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100df7:	48 83 c0 18          	add    $0x18,%rax
  100dfb:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100dfe:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100e02:	48 89 ce             	mov    %rcx,%rsi
  100e05:	48 89 c7             	mov    %rax,%rdi
  100e08:	e8 32 f8 ff ff       	call   10063f <fill_numbuf>
  100e0d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100e11:	48 8d 05 be 06 00 00 	lea    0x6be(%rip),%rax        # 1014d6 <flag_chars+0x6>
  100e18:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100e1c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e1f:	83 e0 20             	and    $0x20,%eax
  100e22:	85 c0                	test   %eax,%eax
  100e24:	74 51                	je     100e77 <printer_vprintf+0x7ac>
  100e26:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e29:	83 e0 40             	and    $0x40,%eax
  100e2c:	85 c0                	test   %eax,%eax
  100e2e:	74 47                	je     100e77 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100e30:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e33:	25 80 00 00 00       	and    $0x80,%eax
  100e38:	85 c0                	test   %eax,%eax
  100e3a:	74 0d                	je     100e49 <printer_vprintf+0x77e>
                prefix = "-";
  100e3c:	48 8d 05 94 06 00 00 	lea    0x694(%rip),%rax        # 1014d7 <flag_chars+0x7>
  100e43:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e47:	eb 7d                	jmp    100ec6 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100e49:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e4c:	83 e0 10             	and    $0x10,%eax
  100e4f:	85 c0                	test   %eax,%eax
  100e51:	74 0d                	je     100e60 <printer_vprintf+0x795>
                prefix = "+";
  100e53:	48 8d 05 7f 06 00 00 	lea    0x67f(%rip),%rax        # 1014d9 <flag_chars+0x9>
  100e5a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e5e:	eb 66                	jmp    100ec6 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100e60:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e63:	83 e0 08             	and    $0x8,%eax
  100e66:	85 c0                	test   %eax,%eax
  100e68:	74 5c                	je     100ec6 <printer_vprintf+0x7fb>
                prefix = " ";
  100e6a:	48 8d 05 6a 06 00 00 	lea    0x66a(%rip),%rax        # 1014db <flag_chars+0xb>
  100e71:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e75:	eb 4f                	jmp    100ec6 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100e77:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e7a:	83 e0 20             	and    $0x20,%eax
  100e7d:	85 c0                	test   %eax,%eax
  100e7f:	74 46                	je     100ec7 <printer_vprintf+0x7fc>
  100e81:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e84:	83 e0 01             	and    $0x1,%eax
  100e87:	85 c0                	test   %eax,%eax
  100e89:	74 3c                	je     100ec7 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100e8b:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100e8f:	74 06                	je     100e97 <printer_vprintf+0x7cc>
  100e91:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e95:	75 30                	jne    100ec7 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100e97:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100e9c:	75 0c                	jne    100eaa <printer_vprintf+0x7df>
  100e9e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ea1:	25 00 01 00 00       	and    $0x100,%eax
  100ea6:	85 c0                	test   %eax,%eax
  100ea8:	74 1d                	je     100ec7 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100eaa:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100eae:	75 09                	jne    100eb9 <printer_vprintf+0x7ee>
  100eb0:	48 8d 05 26 06 00 00 	lea    0x626(%rip),%rax        # 1014dd <flag_chars+0xd>
  100eb7:	eb 07                	jmp    100ec0 <printer_vprintf+0x7f5>
  100eb9:	48 8d 05 20 06 00 00 	lea    0x620(%rip),%rax        # 1014e0 <flag_chars+0x10>
  100ec0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100ec4:	eb 01                	jmp    100ec7 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100ec6:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100ec7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ecb:	78 24                	js     100ef1 <printer_vprintf+0x826>
  100ecd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ed0:	83 e0 20             	and    $0x20,%eax
  100ed3:	85 c0                	test   %eax,%eax
  100ed5:	75 1a                	jne    100ef1 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100ed7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100eda:	48 63 d0             	movslq %eax,%rdx
  100edd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ee1:	48 89 d6             	mov    %rdx,%rsi
  100ee4:	48 89 c7             	mov    %rax,%rdi
  100ee7:	e8 91 f5 ff ff       	call   10047d <strnlen>
  100eec:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100eef:	eb 0f                	jmp    100f00 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100ef1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ef5:	48 89 c7             	mov    %rax,%rdi
  100ef8:	e8 4b f5 ff ff       	call   100448 <strlen>
  100efd:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100f00:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f03:	83 e0 20             	and    $0x20,%eax
  100f06:	85 c0                	test   %eax,%eax
  100f08:	74 20                	je     100f2a <printer_vprintf+0x85f>
  100f0a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100f0e:	78 1a                	js     100f2a <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100f10:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f13:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100f16:	7e 08                	jle    100f20 <printer_vprintf+0x855>
  100f18:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100f1b:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100f1e:	eb 05                	jmp    100f25 <printer_vprintf+0x85a>
  100f20:	b8 00 00 00 00       	mov    $0x0,%eax
  100f25:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f28:	eb 5c                	jmp    100f86 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100f2a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f2d:	83 e0 20             	and    $0x20,%eax
  100f30:	85 c0                	test   %eax,%eax
  100f32:	74 4b                	je     100f7f <printer_vprintf+0x8b4>
  100f34:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f37:	83 e0 02             	and    $0x2,%eax
  100f3a:	85 c0                	test   %eax,%eax
  100f3c:	74 41                	je     100f7f <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100f3e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f41:	83 e0 04             	and    $0x4,%eax
  100f44:	85 c0                	test   %eax,%eax
  100f46:	75 37                	jne    100f7f <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100f48:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f4c:	48 89 c7             	mov    %rax,%rdi
  100f4f:	e8 f4 f4 ff ff       	call   100448 <strlen>
  100f54:	89 c2                	mov    %eax,%edx
  100f56:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100f59:	01 d0                	add    %edx,%eax
  100f5b:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100f5e:	7e 1f                	jle    100f7f <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100f60:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f63:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100f66:	89 c3                	mov    %eax,%ebx
  100f68:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f6c:	48 89 c7             	mov    %rax,%rdi
  100f6f:	e8 d4 f4 ff ff       	call   100448 <strlen>
  100f74:	89 c2                	mov    %eax,%edx
  100f76:	89 d8                	mov    %ebx,%eax
  100f78:	29 d0                	sub    %edx,%eax
  100f7a:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f7d:	eb 07                	jmp    100f86 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100f7f:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100f86:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100f89:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100f8c:	01 d0                	add    %edx,%eax
  100f8e:	48 63 d8             	movslq %eax,%rbx
  100f91:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f95:	48 89 c7             	mov    %rax,%rdi
  100f98:	e8 ab f4 ff ff       	call   100448 <strlen>
  100f9d:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100fa1:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100fa4:	29 d0                	sub    %edx,%eax
  100fa6:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100fa9:	eb 25                	jmp    100fd0 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  100fab:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fb2:	48 8b 08             	mov    (%rax),%rcx
  100fb5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fbb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fc2:	be 20 00 00 00       	mov    $0x20,%esi
  100fc7:	48 89 c7             	mov    %rax,%rdi
  100fca:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100fcc:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100fd0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fd3:	83 e0 04             	and    $0x4,%eax
  100fd6:	85 c0                	test   %eax,%eax
  100fd8:	75 36                	jne    101010 <printer_vprintf+0x945>
  100fda:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100fde:	7f cb                	jg     100fab <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  100fe0:	eb 2e                	jmp    101010 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  100fe2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fe9:	4c 8b 00             	mov    (%rax),%r8
  100fec:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100ff0:	0f b6 00             	movzbl (%rax),%eax
  100ff3:	0f b6 c8             	movzbl %al,%ecx
  100ff6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ffc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101003:	89 ce                	mov    %ecx,%esi
  101005:	48 89 c7             	mov    %rax,%rdi
  101008:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  10100b:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101010:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101014:	0f b6 00             	movzbl (%rax),%eax
  101017:	84 c0                	test   %al,%al
  101019:	75 c7                	jne    100fe2 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  10101b:	eb 25                	jmp    101042 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  10101d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101024:	48 8b 08             	mov    (%rax),%rcx
  101027:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10102d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101034:	be 30 00 00 00       	mov    $0x30,%esi
  101039:	48 89 c7             	mov    %rax,%rdi
  10103c:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  10103e:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101042:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101046:	7f d5                	jg     10101d <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  101048:	eb 32                	jmp    10107c <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  10104a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101051:	4c 8b 00             	mov    (%rax),%r8
  101054:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101058:	0f b6 00             	movzbl (%rax),%eax
  10105b:	0f b6 c8             	movzbl %al,%ecx
  10105e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101064:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10106b:	89 ce                	mov    %ecx,%esi
  10106d:	48 89 c7             	mov    %rax,%rdi
  101070:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101073:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101078:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10107c:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101080:	7f c8                	jg     10104a <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  101082:	eb 25                	jmp    1010a9 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  101084:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10108b:	48 8b 08             	mov    (%rax),%rcx
  10108e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101094:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10109b:	be 20 00 00 00       	mov    $0x20,%esi
  1010a0:	48 89 c7             	mov    %rax,%rdi
  1010a3:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1010a5:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1010a9:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1010ad:	7f d5                	jg     101084 <printer_vprintf+0x9b9>
        }
    done: ;
  1010af:	90                   	nop
    for (; *format; ++format) {
  1010b0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1010b7:	01 
  1010b8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010bf:	0f b6 00             	movzbl (%rax),%eax
  1010c2:	84 c0                	test   %al,%al
  1010c4:	0f 85 31 f6 ff ff    	jne    1006fb <printer_vprintf+0x30>
    }
}
  1010ca:	90                   	nop
  1010cb:	90                   	nop
  1010cc:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1010d0:	c9                   	leave  
  1010d1:	c3                   	ret    

00000000001010d2 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1010d2:	f3 0f 1e fa          	endbr64 
  1010d6:	55                   	push   %rbp
  1010d7:	48 89 e5             	mov    %rsp,%rbp
  1010da:	48 83 ec 20          	sub    $0x20,%rsp
  1010de:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1010e2:	89 f0                	mov    %esi,%eax
  1010e4:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1010e7:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1010ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1010ee:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1010f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010f6:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010fa:	48 8d 15 9f 7e fb ff 	lea    -0x48161(%rip),%rdx        # b8fa0 <console+0xfa0>
  101101:	48 39 d0             	cmp    %rdx,%rax
  101104:	72 0f                	jb     101115 <console_putc+0x43>
        cp->cursor = console;
  101106:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10110a:	48 8d 15 ef 6e fb ff 	lea    -0x49111(%rip),%rdx        # b8000 <console>
  101111:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  101115:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101119:	0f 85 82 00 00 00    	jne    1011a1 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  10111f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101123:	48 8b 40 08          	mov    0x8(%rax),%rax
  101127:	48 8d 15 d2 6e fb ff 	lea    -0x4912e(%rip),%rdx        # b8000 <console>
  10112e:	48 29 d0             	sub    %rdx,%rax
  101131:	48 d1 f8             	sar    %rax
  101134:	48 89 c1             	mov    %rax,%rcx
  101137:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  10113e:	66 66 66 
  101141:	48 89 c8             	mov    %rcx,%rax
  101144:	48 f7 ea             	imul   %rdx
  101147:	48 89 d0             	mov    %rdx,%rax
  10114a:	48 c1 f8 05          	sar    $0x5,%rax
  10114e:	48 89 ce             	mov    %rcx,%rsi
  101151:	48 c1 fe 3f          	sar    $0x3f,%rsi
  101155:	48 29 f0             	sub    %rsi,%rax
  101158:	48 89 c2             	mov    %rax,%rdx
  10115b:	48 89 d0             	mov    %rdx,%rax
  10115e:	48 c1 e0 02          	shl    $0x2,%rax
  101162:	48 01 d0             	add    %rdx,%rax
  101165:	48 c1 e0 04          	shl    $0x4,%rax
  101169:	48 29 c1             	sub    %rax,%rcx
  10116c:	48 89 ca             	mov    %rcx,%rdx
  10116f:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101172:	eb 25                	jmp    101199 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  101174:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101177:	83 c8 20             	or     $0x20,%eax
  10117a:	89 c6                	mov    %eax,%esi
  10117c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101180:	48 8b 40 08          	mov    0x8(%rax),%rax
  101184:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101188:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10118c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101190:	89 f2                	mov    %esi,%edx
  101192:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101195:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101199:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  10119d:	75 d5                	jne    101174 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  10119f:	eb 24                	jmp    1011c5 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  1011a1:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1011a5:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1011a8:	89 d6                	mov    %edx,%esi
  1011aa:	09 c6                	or     %eax,%esi
  1011ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011b0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011b4:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1011b8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1011bc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011c0:	89 f2                	mov    %esi,%edx
  1011c2:	66 89 10             	mov    %dx,(%rax)
}
  1011c5:	90                   	nop
  1011c6:	c9                   	leave  
  1011c7:	c3                   	ret    

00000000001011c8 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1011c8:	f3 0f 1e fa          	endbr64 
  1011cc:	55                   	push   %rbp
  1011cd:	48 89 e5             	mov    %rsp,%rbp
  1011d0:	48 83 ec 30          	sub    $0x30,%rsp
  1011d4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1011d7:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1011da:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1011de:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1011e2:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 1010d2 <console_putc>
  1011e9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1011ed:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1011f1:	78 09                	js     1011fc <console_vprintf+0x34>
  1011f3:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1011fa:	7e 07                	jle    101203 <console_vprintf+0x3b>
        cpos = 0;
  1011fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101203:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101206:	48 98                	cltq   
  101208:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  10120c:	48 8d 05 ed 6d fb ff 	lea    -0x49213(%rip),%rax        # b8000 <console>
  101213:	48 01 d0             	add    %rdx,%rax
  101216:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  10121a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10121e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101222:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101225:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101229:	48 89 c7             	mov    %rax,%rdi
  10122c:	e8 9a f4 ff ff       	call   1006cb <printer_vprintf>
    return cp.cursor - console;
  101231:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101235:	48 8d 15 c4 6d fb ff 	lea    -0x4923c(%rip),%rdx        # b8000 <console>
  10123c:	48 29 d0             	sub    %rdx,%rax
  10123f:	48 d1 f8             	sar    %rax
}
  101242:	c9                   	leave  
  101243:	c3                   	ret    

0000000000101244 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101244:	f3 0f 1e fa          	endbr64 
  101248:	55                   	push   %rbp
  101249:	48 89 e5             	mov    %rsp,%rbp
  10124c:	48 83 ec 60          	sub    $0x60,%rsp
  101250:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101253:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101256:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  10125a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10125e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101262:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101266:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  10126d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101271:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101275:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101279:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  10127d:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101281:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101285:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101288:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10128b:	89 c7                	mov    %eax,%edi
  10128d:	e8 36 ff ff ff       	call   1011c8 <console_vprintf>
  101292:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101295:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101298:	c9                   	leave  
  101299:	c3                   	ret    

000000000010129a <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10129a:	f3 0f 1e fa          	endbr64 
  10129e:	55                   	push   %rbp
  10129f:	48 89 e5             	mov    %rsp,%rbp
  1012a2:	48 83 ec 20          	sub    $0x20,%rsp
  1012a6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1012aa:	89 f0                	mov    %esi,%eax
  1012ac:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1012af:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1012b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1012b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1012ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012be:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1012c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012c6:	48 8b 40 10          	mov    0x10(%rax),%rax
  1012ca:	48 39 c2             	cmp    %rax,%rdx
  1012cd:	73 1a                	jae    1012e9 <string_putc+0x4f>
        *sp->s++ = c;
  1012cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1012d3:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012d7:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1012db:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1012df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012e3:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1012e7:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1012e9:	90                   	nop
  1012ea:	c9                   	leave  
  1012eb:	c3                   	ret    

00000000001012ec <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1012ec:	f3 0f 1e fa          	endbr64 
  1012f0:	55                   	push   %rbp
  1012f1:	48 89 e5             	mov    %rsp,%rbp
  1012f4:	48 83 ec 40          	sub    $0x40,%rsp
  1012f8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1012fc:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101300:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101304:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101308:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 10129a <string_putc>
  10130f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  101313:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101317:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  10131b:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101320:	74 33                	je     101355 <vsnprintf+0x69>
        sp.end = s + size - 1;
  101322:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101326:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10132a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10132e:	48 01 d0             	add    %rdx,%rax
  101331:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101335:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101339:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  10133d:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101341:	be 00 00 00 00       	mov    $0x0,%esi
  101346:	48 89 c7             	mov    %rax,%rdi
  101349:	e8 7d f3 ff ff       	call   1006cb <printer_vprintf>
        *sp.s = 0;
  10134e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101352:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101355:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101359:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  10135d:	c9                   	leave  
  10135e:	c3                   	ret    

000000000010135f <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  10135f:	f3 0f 1e fa          	endbr64 
  101363:	55                   	push   %rbp
  101364:	48 89 e5             	mov    %rsp,%rbp
  101367:	48 83 ec 70          	sub    $0x70,%rsp
  10136b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  10136f:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101373:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101377:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10137b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10137f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101383:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10138a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10138e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101392:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101396:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10139a:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  10139e:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1013a2:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1013a6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1013aa:	48 89 c7             	mov    %rax,%rdi
  1013ad:	e8 3a ff ff ff       	call   1012ec <vsnprintf>
  1013b2:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1013b5:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1013b8:	c9                   	leave  
  1013b9:	c3                   	ret    

00000000001013ba <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1013ba:	f3 0f 1e fa          	endbr64 
  1013be:	55                   	push   %rbp
  1013bf:	48 89 e5             	mov    %rsp,%rbp
  1013c2:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1013c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1013cd:	eb 1a                	jmp    1013e9 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  1013cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1013d2:	48 98                	cltq   
  1013d4:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1013d8:	48 8d 05 21 6c fb ff 	lea    -0x493df(%rip),%rax        # b8000 <console>
  1013df:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1013e5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1013e9:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1013f0:	7e dd                	jle    1013cf <console_clear+0x15>
    }
    cursorpos = 0;
  1013f2:	c7 05 00 7c fb ff 00 	movl   $0x0,-0x48400(%rip)        # b8ffc <cursorpos>
  1013f9:	00 00 00 
}
  1013fc:	90                   	nop
  1013fd:	c9                   	leave  
  1013fe:	c3                   	ret    
