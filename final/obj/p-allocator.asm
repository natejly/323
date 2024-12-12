
obj/p-allocator.full:     file format elf64-x86-64


Disassembly of section .text:

00000000001c0000 <process_main>:
uint8_t *heap_bottom;
uint8_t *stack_bottom;



void process_main(void) {
  1c0000:	f3 0f 1e fa          	endbr64 
  1c0004:	55                   	push   %rbp
  1c0005:	48 89 e5             	mov    %rsp,%rbp
  1c0008:	53                   	push   %rbx
  1c0009:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  1c000d:	cd 31                	int    $0x31
  1c000f:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();
    srand(p);
  1c0011:	89 c7                	mov    %eax,%edi
  1c0013:	e8 46 05 00 00       	call   1c055e <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  1c0018:	48 8d 05 08 30 00 00 	lea    0x3008(%rip),%rax        # 1c3027 <end+0xfff>
  1c001f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  1c0025:	48 89 05 e4 1f 00 00 	mov    %rax,0x1fe4(%rip)        # 1c2010 <heap_top>
  1c002c:	48 89 05 d5 1f 00 00 	mov    %rax,0x1fd5(%rip)        # 1c2008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  1c0033:	48 89 e2             	mov    %rsp,%rdx
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  1c0036:	48 83 ea 01          	sub    $0x1,%rdx
  1c003a:	48 81 e2 00 f0 ff ff 	and    $0xfffffffffffff000,%rdx
  1c0041:	48 89 15 b8 1f 00 00 	mov    %rdx,0x1fb8(%rip)        # 1c2000 <stack_bottom>

    while(heap_top + PAGESIZE < stack_bottom) {
  1c0048:	48 05 00 10 00 00    	add    $0x1000,%rax
  1c004e:	48 39 c2             	cmp    %rax,%rdx
  1c0051:	76 3a                	jbe    1c008d <process_main+0x8d>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1c0053:	bf 00 10 00 00       	mov    $0x1000,%edi
  1c0058:	cd 3a                	int    $0x3a
  1c005a:	48 89 05 b7 1f 00 00 	mov    %rax,0x1fb7(%rip)        # 1c2018 <result.0>

        void * ret = sbrk(PAGESIZE);
        if(ret == (void *) -1) break;
  1c0061:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1c0065:	74 26                	je     1c008d <process_main+0x8d>

        *heap_top = p;      /* check we have write access to new page */
  1c0067:	48 8b 15 a2 1f 00 00 	mov    0x1fa2(%rip),%rdx        # 1c2010 <heap_top>
  1c006e:	88 1a                	mov    %bl,(%rdx)
        heap_top = (uint8_t *)ret + PAGESIZE;
  1c0070:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
  1c0077:	48 89 15 92 1f 00 00 	mov    %rdx,0x1f92(%rip)        # 1c2010 <heap_top>
    while(heap_top + PAGESIZE < stack_bottom) {
  1c007e:	48 05 00 20 00 00    	add    $0x2000,%rax
  1c0084:	48 39 05 75 1f 00 00 	cmp    %rax,0x1f75(%rip)        # 1c2000 <stack_bottom>
  1c008b:	77 cb                	ja     1c0058 <process_main+0x58>
    }

    TEST_PASS();
  1c008d:	48 8d 3d bc 12 00 00 	lea    0x12bc(%rip),%rdi        # 1c1350 <console_clear+0x52>
  1c0094:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0099:	e8 98 00 00 00       	call   1c0136 <kernel_panic>

00000000001c009e <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1c009e:	f3 0f 1e fa          	endbr64 
  1c00a2:	55                   	push   %rbp
  1c00a3:	48 89 e5             	mov    %rsp,%rbp
  1c00a6:	48 83 ec 50          	sub    $0x50,%rsp
  1c00aa:	49 89 f2             	mov    %rsi,%r10
  1c00ad:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1c00b1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1c00b5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1c00b9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1c00bd:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  1c00c2:	85 ff                	test   %edi,%edi
  1c00c4:	78 32                	js     1c00f8 <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1c00c6:	48 63 ff             	movslq %edi,%rdi
  1c00c9:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1c00d0:	cc cc cc 
  1c00d3:	48 89 f8             	mov    %rdi,%rax
  1c00d6:	48 f7 e2             	mul    %rdx
  1c00d9:	48 89 d0             	mov    %rdx,%rax
  1c00dc:	48 c1 e8 02          	shr    $0x2,%rax
  1c00e0:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1c00e4:	48 01 c2             	add    %rax,%rdx
  1c00e7:	48 29 d7             	sub    %rdx,%rdi
  1c00ea:	48 8d 05 b4 12 00 00 	lea    0x12b4(%rip),%rax        # 1c13a5 <col.0>
  1c00f1:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  1c00f5:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1c00f8:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1c00ff:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1c0103:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1c0107:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1c010b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1c010f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1c0113:	4c 89 d2             	mov    %r10,%rdx
  1c0116:	8b 3d e0 8e ef ff    	mov    -0x107120(%rip),%edi        # b8ffc <cursorpos>
  1c011c:	e8 eb 0f 00 00       	call   1c110c <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1c0121:	3d 30 07 00 00       	cmp    $0x730,%eax
  1c0126:	ba 00 00 00 00       	mov    $0x0,%edx
  1c012b:	0f 4d c2             	cmovge %edx,%eax
  1c012e:	89 05 c8 8e ef ff    	mov    %eax,-0x107138(%rip)        # b8ffc <cursorpos>
    }
}
  1c0134:	c9                   	leave  
  1c0135:	c3                   	ret    

00000000001c0136 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  1c0136:	f3 0f 1e fa          	endbr64 
  1c013a:	55                   	push   %rbp
  1c013b:	48 89 e5             	mov    %rsp,%rbp
  1c013e:	53                   	push   %rbx
  1c013f:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  1c0146:	48 89 fb             	mov    %rdi,%rbx
  1c0149:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  1c014d:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  1c0151:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  1c0155:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  1c0159:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  1c015d:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1c0164:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1c0168:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1c016c:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1c0170:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  1c0174:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1c017b:	ba 07 00 00 00       	mov    $0x7,%edx
  1c0180:	48 8d 35 e9 11 00 00 	lea    0x11e9(%rip),%rsi        # 1c1370 <console_clear+0x72>
  1c0187:	e8 b7 00 00 00       	call   1c0243 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  1c018c:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  1c0190:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  1c0197:	48 89 da             	mov    %rbx,%rdx
  1c019a:	be 99 00 00 00       	mov    $0x99,%esi
  1c019f:	e8 8c 10 00 00       	call   1c1230 <vsnprintf>
  1c01a4:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  1c01a7:	85 d2                	test   %edx,%edx
  1c01a9:	7e 0f                	jle    1c01ba <kernel_panic+0x84>
  1c01ab:	83 c0 06             	add    $0x6,%eax
  1c01ae:	48 98                	cltq   
  1c01b0:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1c01b7:	0a 
  1c01b8:	75 2c                	jne    1c01e6 <kernel_panic+0xb0>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1c01ba:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1c01c1:	48 89 d9             	mov    %rbx,%rcx
  1c01c4:	48 8d 15 af 11 00 00 	lea    0x11af(%rip),%rdx        # 1c137a <console_clear+0x7c>
  1c01cb:	be 00 c0 00 00       	mov    $0xc000,%esi
  1c01d0:	bf 30 07 00 00       	mov    $0x730,%edi
  1c01d5:	b8 00 00 00 00       	mov    $0x0,%eax
  1c01da:	e8 a9 0f 00 00       	call   1c1188 <console_printf>
    asm volatile ("int %0" : /* no result */
  1c01df:	48 89 df             	mov    %rbx,%rdi
  1c01e2:	cd 30                	int    $0x30
 loop: goto loop;
  1c01e4:	eb fe                	jmp    1c01e4 <kernel_panic+0xae>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1c01e6:	48 63 c2             	movslq %edx,%rax
  1c01e9:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1c01ef:	0f 94 c2             	sete   %dl
  1c01f2:	0f b6 d2             	movzbl %dl,%edx
  1c01f5:	48 29 d0             	sub    %rdx,%rax
  1c01f8:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1c01ff:	ff 
  1c0200:	48 8d 35 71 11 00 00 	lea    0x1171(%rip),%rsi        # 1c1378 <console_clear+0x7a>
  1c0207:	e8 f8 01 00 00       	call   1c0404 <strcpy>
  1c020c:	eb ac                	jmp    1c01ba <kernel_panic+0x84>

00000000001c020e <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1c020e:	f3 0f 1e fa          	endbr64 
  1c0212:	55                   	push   %rbp
  1c0213:	48 89 e5             	mov    %rsp,%rbp
  1c0216:	48 89 f9             	mov    %rdi,%rcx
  1c0219:	41 89 f0             	mov    %esi,%r8d
  1c021c:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1c021f:	48 8d 15 5a 11 00 00 	lea    0x115a(%rip),%rdx        # 1c1380 <console_clear+0x82>
  1c0226:	be 00 c0 00 00       	mov    $0xc000,%esi
  1c022b:	bf 30 07 00 00       	mov    $0x730,%edi
  1c0230:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0235:	e8 4e 0f 00 00       	call   1c1188 <console_printf>
    asm volatile ("int %0" : /* no result */
  1c023a:	bf 00 00 00 00       	mov    $0x0,%edi
  1c023f:	cd 30                	int    $0x30
 loop: goto loop;
  1c0241:	eb fe                	jmp    1c0241 <assert_fail+0x33>

00000000001c0243 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1c0243:	f3 0f 1e fa          	endbr64 
  1c0247:	55                   	push   %rbp
  1c0248:	48 89 e5             	mov    %rsp,%rbp
  1c024b:	48 83 ec 28          	sub    $0x28,%rsp
  1c024f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c0253:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1c0257:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1c025b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1c025f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1c0263:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c0267:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1c026b:	eb 1c                	jmp    1c0289 <memcpy+0x46>
        *d = *s;
  1c026d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0271:	0f b6 10             	movzbl (%rax),%edx
  1c0274:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0278:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1c027a:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1c027f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1c0284:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1c0289:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1c028e:	75 dd                	jne    1c026d <memcpy+0x2a>
    }
    return dst;
  1c0290:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1c0294:	c9                   	leave  
  1c0295:	c3                   	ret    

00000000001c0296 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1c0296:	f3 0f 1e fa          	endbr64 
  1c029a:	55                   	push   %rbp
  1c029b:	48 89 e5             	mov    %rsp,%rbp
  1c029e:	48 83 ec 28          	sub    $0x28,%rsp
  1c02a2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c02a6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1c02aa:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1c02ae:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1c02b2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1c02b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c02ba:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1c02be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c02c2:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1c02c6:	73 6a                	jae    1c0332 <memmove+0x9c>
  1c02c8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1c02cc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c02d0:	48 01 d0             	add    %rdx,%rax
  1c02d3:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1c02d7:	73 59                	jae    1c0332 <memmove+0x9c>
        s += n, d += n;
  1c02d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c02dd:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1c02e1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c02e5:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1c02e9:	eb 17                	jmp    1c0302 <memmove+0x6c>
            *--d = *--s;
  1c02eb:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1c02f0:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1c02f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c02f9:	0f b6 10             	movzbl (%rax),%edx
  1c02fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0300:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1c0302:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c0306:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1c030a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1c030e:	48 85 c0             	test   %rax,%rax
  1c0311:	75 d8                	jne    1c02eb <memmove+0x55>
    if (s < d && s + n > d) {
  1c0313:	eb 2e                	jmp    1c0343 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1c0315:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1c0319:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1c031d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1c0321:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0325:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1c0329:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1c032d:	0f b6 12             	movzbl (%rdx),%edx
  1c0330:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1c0332:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c0336:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1c033a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1c033e:	48 85 c0             	test   %rax,%rax
  1c0341:	75 d2                	jne    1c0315 <memmove+0x7f>
        }
    }
    return dst;
  1c0343:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1c0347:	c9                   	leave  
  1c0348:	c3                   	ret    

00000000001c0349 <memset>:

void* memset(void* v, int c, size_t n) {
  1c0349:	f3 0f 1e fa          	endbr64 
  1c034d:	55                   	push   %rbp
  1c034e:	48 89 e5             	mov    %rsp,%rbp
  1c0351:	48 83 ec 28          	sub    $0x28,%rsp
  1c0355:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c0359:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1c035c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1c0360:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c0364:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1c0368:	eb 15                	jmp    1c037f <memset+0x36>
        *p = c;
  1c036a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1c036d:	89 c2                	mov    %eax,%edx
  1c036f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0373:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1c0375:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1c037a:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1c037f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1c0384:	75 e4                	jne    1c036a <memset+0x21>
    }
    return v;
  1c0386:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1c038a:	c9                   	leave  
  1c038b:	c3                   	ret    

00000000001c038c <strlen>:

size_t strlen(const char* s) {
  1c038c:	f3 0f 1e fa          	endbr64 
  1c0390:	55                   	push   %rbp
  1c0391:	48 89 e5             	mov    %rsp,%rbp
  1c0394:	48 83 ec 18          	sub    $0x18,%rsp
  1c0398:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  1c039c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1c03a3:	00 
  1c03a4:	eb 0a                	jmp    1c03b0 <strlen+0x24>
        ++n;
  1c03a6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  1c03ab:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1c03b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c03b4:	0f b6 00             	movzbl (%rax),%eax
  1c03b7:	84 c0                	test   %al,%al
  1c03b9:	75 eb                	jne    1c03a6 <strlen+0x1a>
    }
    return n;
  1c03bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1c03bf:	c9                   	leave  
  1c03c0:	c3                   	ret    

00000000001c03c1 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1c03c1:	f3 0f 1e fa          	endbr64 
  1c03c5:	55                   	push   %rbp
  1c03c6:	48 89 e5             	mov    %rsp,%rbp
  1c03c9:	48 83 ec 20          	sub    $0x20,%rsp
  1c03cd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c03d1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1c03d5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1c03dc:	00 
  1c03dd:	eb 0a                	jmp    1c03e9 <strnlen+0x28>
        ++n;
  1c03df:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1c03e4:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1c03e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c03ed:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1c03f1:	74 0b                	je     1c03fe <strnlen+0x3d>
  1c03f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c03f7:	0f b6 00             	movzbl (%rax),%eax
  1c03fa:	84 c0                	test   %al,%al
  1c03fc:	75 e1                	jne    1c03df <strnlen+0x1e>
    }
    return n;
  1c03fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1c0402:	c9                   	leave  
  1c0403:	c3                   	ret    

00000000001c0404 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1c0404:	f3 0f 1e fa          	endbr64 
  1c0408:	55                   	push   %rbp
  1c0409:	48 89 e5             	mov    %rsp,%rbp
  1c040c:	48 83 ec 20          	sub    $0x20,%rsp
  1c0410:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c0414:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1c0418:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c041c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1c0420:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1c0424:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1c0428:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1c042c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0430:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1c0434:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1c0438:	0f b6 12             	movzbl (%rdx),%edx
  1c043b:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1c043d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0441:	48 83 e8 01          	sub    $0x1,%rax
  1c0445:	0f b6 00             	movzbl (%rax),%eax
  1c0448:	84 c0                	test   %al,%al
  1c044a:	75 d4                	jne    1c0420 <strcpy+0x1c>
    return dst;
  1c044c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1c0450:	c9                   	leave  
  1c0451:	c3                   	ret    

00000000001c0452 <strcmp>:

int strcmp(const char* a, const char* b) {
  1c0452:	f3 0f 1e fa          	endbr64 
  1c0456:	55                   	push   %rbp
  1c0457:	48 89 e5             	mov    %rsp,%rbp
  1c045a:	48 83 ec 10          	sub    $0x10,%rsp
  1c045e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1c0462:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1c0466:	eb 0a                	jmp    1c0472 <strcmp+0x20>
        ++a, ++b;
  1c0468:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1c046d:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1c0472:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0476:	0f b6 00             	movzbl (%rax),%eax
  1c0479:	84 c0                	test   %al,%al
  1c047b:	74 1d                	je     1c049a <strcmp+0x48>
  1c047d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0481:	0f b6 00             	movzbl (%rax),%eax
  1c0484:	84 c0                	test   %al,%al
  1c0486:	74 12                	je     1c049a <strcmp+0x48>
  1c0488:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c048c:	0f b6 10             	movzbl (%rax),%edx
  1c048f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c0493:	0f b6 00             	movzbl (%rax),%eax
  1c0496:	38 c2                	cmp    %al,%dl
  1c0498:	74 ce                	je     1c0468 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  1c049a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c049e:	0f b6 00             	movzbl (%rax),%eax
  1c04a1:	89 c2                	mov    %eax,%edx
  1c04a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c04a7:	0f b6 00             	movzbl (%rax),%eax
  1c04aa:	38 c2                	cmp    %al,%dl
  1c04ac:	0f 97 c0             	seta   %al
  1c04af:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  1c04b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c04b6:	0f b6 00             	movzbl (%rax),%eax
  1c04b9:	89 c1                	mov    %eax,%ecx
  1c04bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c04bf:	0f b6 00             	movzbl (%rax),%eax
  1c04c2:	38 c1                	cmp    %al,%cl
  1c04c4:	0f 92 c0             	setb   %al
  1c04c7:	0f b6 c8             	movzbl %al,%ecx
  1c04ca:	89 d0                	mov    %edx,%eax
  1c04cc:	29 c8                	sub    %ecx,%eax
}
  1c04ce:	c9                   	leave  
  1c04cf:	c3                   	ret    

00000000001c04d0 <strchr>:

char* strchr(const char* s, int c) {
  1c04d0:	f3 0f 1e fa          	endbr64 
  1c04d4:	55                   	push   %rbp
  1c04d5:	48 89 e5             	mov    %rsp,%rbp
  1c04d8:	48 83 ec 10          	sub    $0x10,%rsp
  1c04dc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1c04e0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1c04e3:	eb 05                	jmp    1c04ea <strchr+0x1a>
        ++s;
  1c04e5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1c04ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c04ee:	0f b6 00             	movzbl (%rax),%eax
  1c04f1:	84 c0                	test   %al,%al
  1c04f3:	74 0e                	je     1c0503 <strchr+0x33>
  1c04f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c04f9:	0f b6 00             	movzbl (%rax),%eax
  1c04fc:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1c04ff:	38 d0                	cmp    %dl,%al
  1c0501:	75 e2                	jne    1c04e5 <strchr+0x15>
    }
    if (*s == (char) c) {
  1c0503:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0507:	0f b6 00             	movzbl (%rax),%eax
  1c050a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1c050d:	38 d0                	cmp    %dl,%al
  1c050f:	75 06                	jne    1c0517 <strchr+0x47>
        return (char*) s;
  1c0511:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0515:	eb 05                	jmp    1c051c <strchr+0x4c>
    } else {
        return NULL;
  1c0517:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1c051c:	c9                   	leave  
  1c051d:	c3                   	ret    

00000000001c051e <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1c051e:	f3 0f 1e fa          	endbr64 
  1c0522:	55                   	push   %rbp
  1c0523:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1c0526:	8b 05 f4 1a 00 00    	mov    0x1af4(%rip),%eax        # 1c2020 <rand_seed_set>
  1c052c:	85 c0                	test   %eax,%eax
  1c052e:	75 0a                	jne    1c053a <rand+0x1c>
        srand(819234718U);
  1c0530:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1c0535:	e8 24 00 00 00       	call   1c055e <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1c053a:	8b 05 e4 1a 00 00    	mov    0x1ae4(%rip),%eax        # 1c2024 <rand_seed>
  1c0540:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1c0546:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1c054b:	89 05 d3 1a 00 00    	mov    %eax,0x1ad3(%rip)        # 1c2024 <rand_seed>
    return rand_seed & RAND_MAX;
  1c0551:	8b 05 cd 1a 00 00    	mov    0x1acd(%rip),%eax        # 1c2024 <rand_seed>
  1c0557:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1c055c:	5d                   	pop    %rbp
  1c055d:	c3                   	ret    

00000000001c055e <srand>:

void srand(unsigned seed) {
  1c055e:	f3 0f 1e fa          	endbr64 
  1c0562:	55                   	push   %rbp
  1c0563:	48 89 e5             	mov    %rsp,%rbp
  1c0566:	48 83 ec 08          	sub    $0x8,%rsp
  1c056a:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1c056d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1c0570:	89 05 ae 1a 00 00    	mov    %eax,0x1aae(%rip)        # 1c2024 <rand_seed>
    rand_seed_set = 1;
  1c0576:	c7 05 a0 1a 00 00 01 	movl   $0x1,0x1aa0(%rip)        # 1c2020 <rand_seed_set>
  1c057d:	00 00 00 
}
  1c0580:	90                   	nop
  1c0581:	c9                   	leave  
  1c0582:	c3                   	ret    

00000000001c0583 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1c0583:	f3 0f 1e fa          	endbr64 
  1c0587:	55                   	push   %rbp
  1c0588:	48 89 e5             	mov    %rsp,%rbp
  1c058b:	48 83 ec 28          	sub    $0x28,%rsp
  1c058f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c0593:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1c0597:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1c059a:	48 8d 05 0f 0f 00 00 	lea    0xf0f(%rip),%rax        # 1c14b0 <upper_digits.1>
  1c05a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  1c05a5:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1c05a9:	79 0e                	jns    1c05b9 <fill_numbuf+0x36>
        digits = lower_digits;
  1c05ab:	48 8d 05 1e 0f 00 00 	lea    0xf1e(%rip),%rax        # 1c14d0 <lower_digits.0>
  1c05b2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  1c05b6:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  1c05b9:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1c05be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c05c2:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  1c05c5:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1c05c8:	48 63 c8             	movslq %eax,%rcx
  1c05cb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1c05cf:	ba 00 00 00 00       	mov    $0x0,%edx
  1c05d4:	48 f7 f1             	div    %rcx
  1c05d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c05db:	48 01 d0             	add    %rdx,%rax
  1c05de:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1c05e3:	0f b6 10             	movzbl (%rax),%edx
  1c05e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c05ea:	88 10                	mov    %dl,(%rax)
        val /= base;
  1c05ec:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1c05ef:	48 63 f0             	movslq %eax,%rsi
  1c05f2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1c05f6:	ba 00 00 00 00       	mov    $0x0,%edx
  1c05fb:	48 f7 f6             	div    %rsi
  1c05fe:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1c0602:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1c0607:	75 bc                	jne    1c05c5 <fill_numbuf+0x42>
    return numbuf_end;
  1c0609:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1c060d:	c9                   	leave  
  1c060e:	c3                   	ret    

00000000001c060f <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1c060f:	f3 0f 1e fa          	endbr64 
  1c0613:	55                   	push   %rbp
  1c0614:	48 89 e5             	mov    %rsp,%rbp
  1c0617:	53                   	push   %rbx
  1c0618:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1c061f:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1c0626:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1c062c:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1c0633:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1c063a:	e9 bd 09 00 00       	jmp    1c0ffc <printer_vprintf+0x9ed>
        if (*format != '%') {
  1c063f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0646:	0f b6 00             	movzbl (%rax),%eax
  1c0649:	3c 25                	cmp    $0x25,%al
  1c064b:	74 31                	je     1c067e <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  1c064d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0654:	4c 8b 00             	mov    (%rax),%r8
  1c0657:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c065e:	0f b6 00             	movzbl (%rax),%eax
  1c0661:	0f b6 c8             	movzbl %al,%ecx
  1c0664:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c066a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0671:	89 ce                	mov    %ecx,%esi
  1c0673:	48 89 c7             	mov    %rax,%rdi
  1c0676:	41 ff d0             	call   *%r8
            continue;
  1c0679:	e9 76 09 00 00       	jmp    1c0ff4 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  1c067e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1c0685:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c068c:	01 
  1c068d:	eb 4d                	jmp    1c06dc <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  1c068f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0696:	0f b6 00             	movzbl (%rax),%eax
  1c0699:	0f be c0             	movsbl %al,%eax
  1c069c:	89 c6                	mov    %eax,%esi
  1c069e:	48 8d 05 0b 0d 00 00 	lea    0xd0b(%rip),%rax        # 1c13b0 <flag_chars>
  1c06a5:	48 89 c7             	mov    %rax,%rdi
  1c06a8:	e8 23 fe ff ff       	call   1c04d0 <strchr>
  1c06ad:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1c06b1:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1c06b6:	74 34                	je     1c06ec <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  1c06b8:	48 8d 15 f1 0c 00 00 	lea    0xcf1(%rip),%rdx        # 1c13b0 <flag_chars>
  1c06bf:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1c06c3:	48 29 d0             	sub    %rdx,%rax
  1c06c6:	ba 01 00 00 00       	mov    $0x1,%edx
  1c06cb:	89 c1                	mov    %eax,%ecx
  1c06cd:	d3 e2                	shl    %cl,%edx
  1c06cf:	89 d0                	mov    %edx,%eax
  1c06d1:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1c06d4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c06db:	01 
  1c06dc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c06e3:	0f b6 00             	movzbl (%rax),%eax
  1c06e6:	84 c0                	test   %al,%al
  1c06e8:	75 a5                	jne    1c068f <printer_vprintf+0x80>
  1c06ea:	eb 01                	jmp    1c06ed <printer_vprintf+0xde>
            } else {
                break;
  1c06ec:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1c06ed:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1c06f4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c06fb:	0f b6 00             	movzbl (%rax),%eax
  1c06fe:	3c 30                	cmp    $0x30,%al
  1c0700:	7e 67                	jle    1c0769 <printer_vprintf+0x15a>
  1c0702:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0709:	0f b6 00             	movzbl (%rax),%eax
  1c070c:	3c 39                	cmp    $0x39,%al
  1c070e:	7f 59                	jg     1c0769 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1c0710:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1c0717:	eb 2e                	jmp    1c0747 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  1c0719:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1c071c:	89 d0                	mov    %edx,%eax
  1c071e:	c1 e0 02             	shl    $0x2,%eax
  1c0721:	01 d0                	add    %edx,%eax
  1c0723:	01 c0                	add    %eax,%eax
  1c0725:	89 c1                	mov    %eax,%ecx
  1c0727:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c072e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1c0732:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1c0739:	0f b6 00             	movzbl (%rax),%eax
  1c073c:	0f be c0             	movsbl %al,%eax
  1c073f:	01 c8                	add    %ecx,%eax
  1c0741:	83 e8 30             	sub    $0x30,%eax
  1c0744:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1c0747:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c074e:	0f b6 00             	movzbl (%rax),%eax
  1c0751:	3c 2f                	cmp    $0x2f,%al
  1c0753:	0f 8e 85 00 00 00    	jle    1c07de <printer_vprintf+0x1cf>
  1c0759:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0760:	0f b6 00             	movzbl (%rax),%eax
  1c0763:	3c 39                	cmp    $0x39,%al
  1c0765:	7e b2                	jle    1c0719 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  1c0767:	eb 75                	jmp    1c07de <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  1c0769:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0770:	0f b6 00             	movzbl (%rax),%eax
  1c0773:	3c 2a                	cmp    $0x2a,%al
  1c0775:	75 68                	jne    1c07df <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  1c0777:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c077e:	8b 00                	mov    (%rax),%eax
  1c0780:	83 f8 2f             	cmp    $0x2f,%eax
  1c0783:	77 30                	ja     1c07b5 <printer_vprintf+0x1a6>
  1c0785:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c078c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0790:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0797:	8b 00                	mov    (%rax),%eax
  1c0799:	89 c0                	mov    %eax,%eax
  1c079b:	48 01 d0             	add    %rdx,%rax
  1c079e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c07a5:	8b 12                	mov    (%rdx),%edx
  1c07a7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c07aa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c07b1:	89 0a                	mov    %ecx,(%rdx)
  1c07b3:	eb 1a                	jmp    1c07cf <printer_vprintf+0x1c0>
  1c07b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c07bc:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c07c0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c07c4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c07cb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c07cf:	8b 00                	mov    (%rax),%eax
  1c07d1:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1c07d4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c07db:	01 
  1c07dc:	eb 01                	jmp    1c07df <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  1c07de:	90                   	nop
        }

        // process precision
        int precision = -1;
  1c07df:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  1c07e6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c07ed:	0f b6 00             	movzbl (%rax),%eax
  1c07f0:	3c 2e                	cmp    $0x2e,%al
  1c07f2:	0f 85 00 01 00 00    	jne    1c08f8 <printer_vprintf+0x2e9>
            ++format;
  1c07f8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c07ff:	01 
            if (*format >= '0' && *format <= '9') {
  1c0800:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0807:	0f b6 00             	movzbl (%rax),%eax
  1c080a:	3c 2f                	cmp    $0x2f,%al
  1c080c:	7e 67                	jle    1c0875 <printer_vprintf+0x266>
  1c080e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0815:	0f b6 00             	movzbl (%rax),%eax
  1c0818:	3c 39                	cmp    $0x39,%al
  1c081a:	7f 59                	jg     1c0875 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1c081c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1c0823:	eb 2e                	jmp    1c0853 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  1c0825:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1c0828:	89 d0                	mov    %edx,%eax
  1c082a:	c1 e0 02             	shl    $0x2,%eax
  1c082d:	01 d0                	add    %edx,%eax
  1c082f:	01 c0                	add    %eax,%eax
  1c0831:	89 c1                	mov    %eax,%ecx
  1c0833:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c083a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1c083e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1c0845:	0f b6 00             	movzbl (%rax),%eax
  1c0848:	0f be c0             	movsbl %al,%eax
  1c084b:	01 c8                	add    %ecx,%eax
  1c084d:	83 e8 30             	sub    $0x30,%eax
  1c0850:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1c0853:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c085a:	0f b6 00             	movzbl (%rax),%eax
  1c085d:	3c 2f                	cmp    $0x2f,%al
  1c085f:	0f 8e 85 00 00 00    	jle    1c08ea <printer_vprintf+0x2db>
  1c0865:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c086c:	0f b6 00             	movzbl (%rax),%eax
  1c086f:	3c 39                	cmp    $0x39,%al
  1c0871:	7e b2                	jle    1c0825 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  1c0873:	eb 75                	jmp    1c08ea <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  1c0875:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c087c:	0f b6 00             	movzbl (%rax),%eax
  1c087f:	3c 2a                	cmp    $0x2a,%al
  1c0881:	75 68                	jne    1c08eb <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  1c0883:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c088a:	8b 00                	mov    (%rax),%eax
  1c088c:	83 f8 2f             	cmp    $0x2f,%eax
  1c088f:	77 30                	ja     1c08c1 <printer_vprintf+0x2b2>
  1c0891:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0898:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c089c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c08a3:	8b 00                	mov    (%rax),%eax
  1c08a5:	89 c0                	mov    %eax,%eax
  1c08a7:	48 01 d0             	add    %rdx,%rax
  1c08aa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c08b1:	8b 12                	mov    (%rdx),%edx
  1c08b3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c08b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c08bd:	89 0a                	mov    %ecx,(%rdx)
  1c08bf:	eb 1a                	jmp    1c08db <printer_vprintf+0x2cc>
  1c08c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c08c8:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c08cc:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c08d0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c08d7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c08db:	8b 00                	mov    (%rax),%eax
  1c08dd:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  1c08e0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c08e7:	01 
  1c08e8:	eb 01                	jmp    1c08eb <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  1c08ea:	90                   	nop
            }
            if (precision < 0) {
  1c08eb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1c08ef:	79 07                	jns    1c08f8 <printer_vprintf+0x2e9>
                precision = 0;
  1c08f1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  1c08f8:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  1c08ff:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  1c0906:	00 
        int length = 0;
  1c0907:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  1c090e:	48 8d 05 a1 0a 00 00 	lea    0xaa1(%rip),%rax        # 1c13b6 <flag_chars+0x6>
  1c0915:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  1c0919:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0920:	0f b6 00             	movzbl (%rax),%eax
  1c0923:	0f be c0             	movsbl %al,%eax
  1c0926:	83 e8 43             	sub    $0x43,%eax
  1c0929:	83 f8 37             	cmp    $0x37,%eax
  1c092c:	0f 87 b6 03 00 00    	ja     1c0ce8 <printer_vprintf+0x6d9>
  1c0932:	89 c0                	mov    %eax,%eax
  1c0934:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  1c093b:	00 
  1c093c:	48 8d 05 81 0a 00 00 	lea    0xa81(%rip),%rax        # 1c13c4 <flag_chars+0x14>
  1c0943:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  1c0946:	48 98                	cltq   
  1c0948:	48 8d 15 75 0a 00 00 	lea    0xa75(%rip),%rdx        # 1c13c4 <flag_chars+0x14>
  1c094f:	48 01 d0             	add    %rdx,%rax
  1c0952:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  1c0955:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1c095c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c0963:	01 
            goto again;
  1c0964:	eb b3                	jmp    1c0919 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1c0966:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1c096a:	74 5d                	je     1c09c9 <printer_vprintf+0x3ba>
  1c096c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0973:	8b 00                	mov    (%rax),%eax
  1c0975:	83 f8 2f             	cmp    $0x2f,%eax
  1c0978:	77 30                	ja     1c09aa <printer_vprintf+0x39b>
  1c097a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0981:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0985:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c098c:	8b 00                	mov    (%rax),%eax
  1c098e:	89 c0                	mov    %eax,%eax
  1c0990:	48 01 d0             	add    %rdx,%rax
  1c0993:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c099a:	8b 12                	mov    (%rdx),%edx
  1c099c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c099f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c09a6:	89 0a                	mov    %ecx,(%rdx)
  1c09a8:	eb 1a                	jmp    1c09c4 <printer_vprintf+0x3b5>
  1c09aa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c09b1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c09b5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c09b9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c09c0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c09c4:	48 8b 00             	mov    (%rax),%rax
  1c09c7:	eb 5c                	jmp    1c0a25 <printer_vprintf+0x416>
  1c09c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c09d0:	8b 00                	mov    (%rax),%eax
  1c09d2:	83 f8 2f             	cmp    $0x2f,%eax
  1c09d5:	77 30                	ja     1c0a07 <printer_vprintf+0x3f8>
  1c09d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c09de:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c09e2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c09e9:	8b 00                	mov    (%rax),%eax
  1c09eb:	89 c0                	mov    %eax,%eax
  1c09ed:	48 01 d0             	add    %rdx,%rax
  1c09f0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c09f7:	8b 12                	mov    (%rdx),%edx
  1c09f9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c09fc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0a03:	89 0a                	mov    %ecx,(%rdx)
  1c0a05:	eb 1a                	jmp    1c0a21 <printer_vprintf+0x412>
  1c0a07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0a0e:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0a12:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0a16:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0a1d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0a21:	8b 00                	mov    (%rax),%eax
  1c0a23:	48 98                	cltq   
  1c0a25:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1c0a29:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1c0a2d:	48 c1 f8 38          	sar    $0x38,%rax
  1c0a31:	25 80 00 00 00       	and    $0x80,%eax
  1c0a36:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  1c0a39:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  1c0a3d:	74 09                	je     1c0a48 <printer_vprintf+0x439>
  1c0a3f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1c0a43:	48 f7 d8             	neg    %rax
  1c0a46:	eb 04                	jmp    1c0a4c <printer_vprintf+0x43d>
  1c0a48:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1c0a4c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1c0a50:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  1c0a53:	83 c8 60             	or     $0x60,%eax
  1c0a56:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  1c0a59:	e9 cf 02 00 00       	jmp    1c0d2d <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1c0a5e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1c0a62:	74 5d                	je     1c0ac1 <printer_vprintf+0x4b2>
  1c0a64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0a6b:	8b 00                	mov    (%rax),%eax
  1c0a6d:	83 f8 2f             	cmp    $0x2f,%eax
  1c0a70:	77 30                	ja     1c0aa2 <printer_vprintf+0x493>
  1c0a72:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0a79:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0a7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0a84:	8b 00                	mov    (%rax),%eax
  1c0a86:	89 c0                	mov    %eax,%eax
  1c0a88:	48 01 d0             	add    %rdx,%rax
  1c0a8b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0a92:	8b 12                	mov    (%rdx),%edx
  1c0a94:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c0a97:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0a9e:	89 0a                	mov    %ecx,(%rdx)
  1c0aa0:	eb 1a                	jmp    1c0abc <printer_vprintf+0x4ad>
  1c0aa2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0aa9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0aad:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0ab1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0ab8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0abc:	48 8b 00             	mov    (%rax),%rax
  1c0abf:	eb 5c                	jmp    1c0b1d <printer_vprintf+0x50e>
  1c0ac1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0ac8:	8b 00                	mov    (%rax),%eax
  1c0aca:	83 f8 2f             	cmp    $0x2f,%eax
  1c0acd:	77 30                	ja     1c0aff <printer_vprintf+0x4f0>
  1c0acf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0ad6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0ada:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0ae1:	8b 00                	mov    (%rax),%eax
  1c0ae3:	89 c0                	mov    %eax,%eax
  1c0ae5:	48 01 d0             	add    %rdx,%rax
  1c0ae8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0aef:	8b 12                	mov    (%rdx),%edx
  1c0af1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c0af4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0afb:	89 0a                	mov    %ecx,(%rdx)
  1c0afd:	eb 1a                	jmp    1c0b19 <printer_vprintf+0x50a>
  1c0aff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0b06:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0b0a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0b0e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0b15:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0b19:	8b 00                	mov    (%rax),%eax
  1c0b1b:	89 c0                	mov    %eax,%eax
  1c0b1d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  1c0b21:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  1c0b25:	e9 03 02 00 00       	jmp    1c0d2d <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  1c0b2a:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  1c0b31:	e9 28 ff ff ff       	jmp    1c0a5e <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  1c0b36:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  1c0b3d:	e9 1c ff ff ff       	jmp    1c0a5e <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  1c0b42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0b49:	8b 00                	mov    (%rax),%eax
  1c0b4b:	83 f8 2f             	cmp    $0x2f,%eax
  1c0b4e:	77 30                	ja     1c0b80 <printer_vprintf+0x571>
  1c0b50:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0b57:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0b5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0b62:	8b 00                	mov    (%rax),%eax
  1c0b64:	89 c0                	mov    %eax,%eax
  1c0b66:	48 01 d0             	add    %rdx,%rax
  1c0b69:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0b70:	8b 12                	mov    (%rdx),%edx
  1c0b72:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c0b75:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0b7c:	89 0a                	mov    %ecx,(%rdx)
  1c0b7e:	eb 1a                	jmp    1c0b9a <printer_vprintf+0x58b>
  1c0b80:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0b87:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0b8b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0b8f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0b96:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0b9a:	48 8b 00             	mov    (%rax),%rax
  1c0b9d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1c0ba1:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1c0ba8:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  1c0baf:	e9 79 01 00 00       	jmp    1c0d2d <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  1c0bb4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0bbb:	8b 00                	mov    (%rax),%eax
  1c0bbd:	83 f8 2f             	cmp    $0x2f,%eax
  1c0bc0:	77 30                	ja     1c0bf2 <printer_vprintf+0x5e3>
  1c0bc2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0bc9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0bcd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0bd4:	8b 00                	mov    (%rax),%eax
  1c0bd6:	89 c0                	mov    %eax,%eax
  1c0bd8:	48 01 d0             	add    %rdx,%rax
  1c0bdb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0be2:	8b 12                	mov    (%rdx),%edx
  1c0be4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c0be7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0bee:	89 0a                	mov    %ecx,(%rdx)
  1c0bf0:	eb 1a                	jmp    1c0c0c <printer_vprintf+0x5fd>
  1c0bf2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0bf9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0bfd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0c01:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0c08:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0c0c:	48 8b 00             	mov    (%rax),%rax
  1c0c0f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  1c0c13:	e9 15 01 00 00       	jmp    1c0d2d <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  1c0c18:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0c1f:	8b 00                	mov    (%rax),%eax
  1c0c21:	83 f8 2f             	cmp    $0x2f,%eax
  1c0c24:	77 30                	ja     1c0c56 <printer_vprintf+0x647>
  1c0c26:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0c2d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0c31:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0c38:	8b 00                	mov    (%rax),%eax
  1c0c3a:	89 c0                	mov    %eax,%eax
  1c0c3c:	48 01 d0             	add    %rdx,%rax
  1c0c3f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0c46:	8b 12                	mov    (%rdx),%edx
  1c0c48:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c0c4b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0c52:	89 0a                	mov    %ecx,(%rdx)
  1c0c54:	eb 1a                	jmp    1c0c70 <printer_vprintf+0x661>
  1c0c56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0c5d:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0c61:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0c65:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0c6c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0c70:	8b 00                	mov    (%rax),%eax
  1c0c72:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  1c0c78:	e9 77 03 00 00       	jmp    1c0ff4 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  1c0c7d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1c0c81:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  1c0c85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0c8c:	8b 00                	mov    (%rax),%eax
  1c0c8e:	83 f8 2f             	cmp    $0x2f,%eax
  1c0c91:	77 30                	ja     1c0cc3 <printer_vprintf+0x6b4>
  1c0c93:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0c9a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1c0c9e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0ca5:	8b 00                	mov    (%rax),%eax
  1c0ca7:	89 c0                	mov    %eax,%eax
  1c0ca9:	48 01 d0             	add    %rdx,%rax
  1c0cac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0cb3:	8b 12                	mov    (%rdx),%edx
  1c0cb5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1c0cb8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0cbf:	89 0a                	mov    %ecx,(%rdx)
  1c0cc1:	eb 1a                	jmp    1c0cdd <printer_vprintf+0x6ce>
  1c0cc3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1c0cca:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c0cce:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1c0cd2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1c0cd9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c0cdd:	8b 00                	mov    (%rax),%eax
  1c0cdf:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1c0ce2:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  1c0ce6:	eb 45                	jmp    1c0d2d <printer_vprintf+0x71e>
        default:
            data = numbuf;
  1c0ce8:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1c0cec:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  1c0cf0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0cf7:	0f b6 00             	movzbl (%rax),%eax
  1c0cfa:	84 c0                	test   %al,%al
  1c0cfc:	74 0c                	je     1c0d0a <printer_vprintf+0x6fb>
  1c0cfe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0d05:	0f b6 00             	movzbl (%rax),%eax
  1c0d08:	eb 05                	jmp    1c0d0f <printer_vprintf+0x700>
  1c0d0a:	b8 25 00 00 00       	mov    $0x25,%eax
  1c0d0f:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1c0d12:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  1c0d16:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c0d1d:	0f b6 00             	movzbl (%rax),%eax
  1c0d20:	84 c0                	test   %al,%al
  1c0d22:	75 08                	jne    1c0d2c <printer_vprintf+0x71d>
                format--;
  1c0d24:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  1c0d2b:	01 
            }
            break;
  1c0d2c:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  1c0d2d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0d30:	83 e0 20             	and    $0x20,%eax
  1c0d33:	85 c0                	test   %eax,%eax
  1c0d35:	74 1e                	je     1c0d55 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  1c0d37:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1c0d3b:	48 83 c0 18          	add    $0x18,%rax
  1c0d3f:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1c0d42:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1c0d46:	48 89 ce             	mov    %rcx,%rsi
  1c0d49:	48 89 c7             	mov    %rax,%rdi
  1c0d4c:	e8 32 f8 ff ff       	call   1c0583 <fill_numbuf>
  1c0d51:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  1c0d55:	48 8d 05 5a 06 00 00 	lea    0x65a(%rip),%rax        # 1c13b6 <flag_chars+0x6>
  1c0d5c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1c0d60:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0d63:	83 e0 20             	and    $0x20,%eax
  1c0d66:	85 c0                	test   %eax,%eax
  1c0d68:	74 51                	je     1c0dbb <printer_vprintf+0x7ac>
  1c0d6a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0d6d:	83 e0 40             	and    $0x40,%eax
  1c0d70:	85 c0                	test   %eax,%eax
  1c0d72:	74 47                	je     1c0dbb <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  1c0d74:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0d77:	25 80 00 00 00       	and    $0x80,%eax
  1c0d7c:	85 c0                	test   %eax,%eax
  1c0d7e:	74 0d                	je     1c0d8d <printer_vprintf+0x77e>
                prefix = "-";
  1c0d80:	48 8d 05 30 06 00 00 	lea    0x630(%rip),%rax        # 1c13b7 <flag_chars+0x7>
  1c0d87:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1c0d8b:	eb 7d                	jmp    1c0e0a <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1c0d8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0d90:	83 e0 10             	and    $0x10,%eax
  1c0d93:	85 c0                	test   %eax,%eax
  1c0d95:	74 0d                	je     1c0da4 <printer_vprintf+0x795>
                prefix = "+";
  1c0d97:	48 8d 05 1b 06 00 00 	lea    0x61b(%rip),%rax        # 1c13b9 <flag_chars+0x9>
  1c0d9e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1c0da2:	eb 66                	jmp    1c0e0a <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  1c0da4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0da7:	83 e0 08             	and    $0x8,%eax
  1c0daa:	85 c0                	test   %eax,%eax
  1c0dac:	74 5c                	je     1c0e0a <printer_vprintf+0x7fb>
                prefix = " ";
  1c0dae:	48 8d 05 06 06 00 00 	lea    0x606(%rip),%rax        # 1c13bb <flag_chars+0xb>
  1c0db5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1c0db9:	eb 4f                	jmp    1c0e0a <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1c0dbb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0dbe:	83 e0 20             	and    $0x20,%eax
  1c0dc1:	85 c0                	test   %eax,%eax
  1c0dc3:	74 46                	je     1c0e0b <printer_vprintf+0x7fc>
  1c0dc5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0dc8:	83 e0 01             	and    $0x1,%eax
  1c0dcb:	85 c0                	test   %eax,%eax
  1c0dcd:	74 3c                	je     1c0e0b <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  1c0dcf:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1c0dd3:	74 06                	je     1c0ddb <printer_vprintf+0x7cc>
  1c0dd5:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1c0dd9:	75 30                	jne    1c0e0b <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  1c0ddb:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1c0de0:	75 0c                	jne    1c0dee <printer_vprintf+0x7df>
  1c0de2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0de5:	25 00 01 00 00       	and    $0x100,%eax
  1c0dea:	85 c0                	test   %eax,%eax
  1c0dec:	74 1d                	je     1c0e0b <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  1c0dee:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1c0df2:	75 09                	jne    1c0dfd <printer_vprintf+0x7ee>
  1c0df4:	48 8d 05 c2 05 00 00 	lea    0x5c2(%rip),%rax        # 1c13bd <flag_chars+0xd>
  1c0dfb:	eb 07                	jmp    1c0e04 <printer_vprintf+0x7f5>
  1c0dfd:	48 8d 05 bc 05 00 00 	lea    0x5bc(%rip),%rax        # 1c13c0 <flag_chars+0x10>
  1c0e04:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1c0e08:	eb 01                	jmp    1c0e0b <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  1c0e0a:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1c0e0b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1c0e0f:	78 24                	js     1c0e35 <printer_vprintf+0x826>
  1c0e11:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0e14:	83 e0 20             	and    $0x20,%eax
  1c0e17:	85 c0                	test   %eax,%eax
  1c0e19:	75 1a                	jne    1c0e35 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  1c0e1b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1c0e1e:	48 63 d0             	movslq %eax,%rdx
  1c0e21:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1c0e25:	48 89 d6             	mov    %rdx,%rsi
  1c0e28:	48 89 c7             	mov    %rax,%rdi
  1c0e2b:	e8 91 f5 ff ff       	call   1c03c1 <strnlen>
  1c0e30:	89 45 bc             	mov    %eax,-0x44(%rbp)
  1c0e33:	eb 0f                	jmp    1c0e44 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  1c0e35:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1c0e39:	48 89 c7             	mov    %rax,%rdi
  1c0e3c:	e8 4b f5 ff ff       	call   1c038c <strlen>
  1c0e41:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1c0e44:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0e47:	83 e0 20             	and    $0x20,%eax
  1c0e4a:	85 c0                	test   %eax,%eax
  1c0e4c:	74 20                	je     1c0e6e <printer_vprintf+0x85f>
  1c0e4e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1c0e52:	78 1a                	js     1c0e6e <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  1c0e54:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1c0e57:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  1c0e5a:	7e 08                	jle    1c0e64 <printer_vprintf+0x855>
  1c0e5c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1c0e5f:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1c0e62:	eb 05                	jmp    1c0e69 <printer_vprintf+0x85a>
  1c0e64:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0e69:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1c0e6c:	eb 5c                	jmp    1c0eca <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1c0e6e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0e71:	83 e0 20             	and    $0x20,%eax
  1c0e74:	85 c0                	test   %eax,%eax
  1c0e76:	74 4b                	je     1c0ec3 <printer_vprintf+0x8b4>
  1c0e78:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0e7b:	83 e0 02             	and    $0x2,%eax
  1c0e7e:	85 c0                	test   %eax,%eax
  1c0e80:	74 41                	je     1c0ec3 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1c0e82:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0e85:	83 e0 04             	and    $0x4,%eax
  1c0e88:	85 c0                	test   %eax,%eax
  1c0e8a:	75 37                	jne    1c0ec3 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  1c0e8c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1c0e90:	48 89 c7             	mov    %rax,%rdi
  1c0e93:	e8 f4 f4 ff ff       	call   1c038c <strlen>
  1c0e98:	89 c2                	mov    %eax,%edx
  1c0e9a:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1c0e9d:	01 d0                	add    %edx,%eax
  1c0e9f:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  1c0ea2:	7e 1f                	jle    1c0ec3 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  1c0ea4:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1c0ea7:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1c0eaa:	89 c3                	mov    %eax,%ebx
  1c0eac:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1c0eb0:	48 89 c7             	mov    %rax,%rdi
  1c0eb3:	e8 d4 f4 ff ff       	call   1c038c <strlen>
  1c0eb8:	89 c2                	mov    %eax,%edx
  1c0eba:	89 d8                	mov    %ebx,%eax
  1c0ebc:	29 d0                	sub    %edx,%eax
  1c0ebe:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1c0ec1:	eb 07                	jmp    1c0eca <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  1c0ec3:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  1c0eca:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1c0ecd:	8b 45 b8             	mov    -0x48(%rbp),%eax
  1c0ed0:	01 d0                	add    %edx,%eax
  1c0ed2:	48 63 d8             	movslq %eax,%rbx
  1c0ed5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1c0ed9:	48 89 c7             	mov    %rax,%rdi
  1c0edc:	e8 ab f4 ff ff       	call   1c038c <strlen>
  1c0ee1:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1c0ee5:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1c0ee8:	29 d0                	sub    %edx,%eax
  1c0eea:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1c0eed:	eb 25                	jmp    1c0f14 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  1c0eef:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0ef6:	48 8b 08             	mov    (%rax),%rcx
  1c0ef9:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c0eff:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0f06:	be 20 00 00 00       	mov    $0x20,%esi
  1c0f0b:	48 89 c7             	mov    %rax,%rdi
  1c0f0e:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1c0f10:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1c0f14:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c0f17:	83 e0 04             	and    $0x4,%eax
  1c0f1a:	85 c0                	test   %eax,%eax
  1c0f1c:	75 36                	jne    1c0f54 <printer_vprintf+0x945>
  1c0f1e:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1c0f22:	7f cb                	jg     1c0eef <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  1c0f24:	eb 2e                	jmp    1c0f54 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  1c0f26:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0f2d:	4c 8b 00             	mov    (%rax),%r8
  1c0f30:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1c0f34:	0f b6 00             	movzbl (%rax),%eax
  1c0f37:	0f b6 c8             	movzbl %al,%ecx
  1c0f3a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c0f40:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0f47:	89 ce                	mov    %ecx,%esi
  1c0f49:	48 89 c7             	mov    %rax,%rdi
  1c0f4c:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1c0f4f:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1c0f54:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1c0f58:	0f b6 00             	movzbl (%rax),%eax
  1c0f5b:	84 c0                	test   %al,%al
  1c0f5d:	75 c7                	jne    1c0f26 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  1c0f5f:	eb 25                	jmp    1c0f86 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  1c0f61:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0f68:	48 8b 08             	mov    (%rax),%rcx
  1c0f6b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c0f71:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0f78:	be 30 00 00 00       	mov    $0x30,%esi
  1c0f7d:	48 89 c7             	mov    %rax,%rdi
  1c0f80:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1c0f82:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1c0f86:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1c0f8a:	7f d5                	jg     1c0f61 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  1c0f8c:	eb 32                	jmp    1c0fc0 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  1c0f8e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0f95:	4c 8b 00             	mov    (%rax),%r8
  1c0f98:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1c0f9c:	0f b6 00             	movzbl (%rax),%eax
  1c0f9f:	0f b6 c8             	movzbl %al,%ecx
  1c0fa2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c0fa8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0faf:	89 ce                	mov    %ecx,%esi
  1c0fb1:	48 89 c7             	mov    %rax,%rdi
  1c0fb4:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  1c0fb7:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  1c0fbc:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  1c0fc0:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  1c0fc4:	7f c8                	jg     1c0f8e <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  1c0fc6:	eb 25                	jmp    1c0fed <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  1c0fc8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0fcf:	48 8b 08             	mov    (%rax),%rcx
  1c0fd2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1c0fd8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1c0fdf:	be 20 00 00 00       	mov    $0x20,%esi
  1c0fe4:	48 89 c7             	mov    %rax,%rdi
  1c0fe7:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1c0fe9:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1c0fed:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1c0ff1:	7f d5                	jg     1c0fc8 <printer_vprintf+0x9b9>
        }
    done: ;
  1c0ff3:	90                   	nop
    for (; *format; ++format) {
  1c0ff4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1c0ffb:	01 
  1c0ffc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1c1003:	0f b6 00             	movzbl (%rax),%eax
  1c1006:	84 c0                	test   %al,%al
  1c1008:	0f 85 31 f6 ff ff    	jne    1c063f <printer_vprintf+0x30>
    }
}
  1c100e:	90                   	nop
  1c100f:	90                   	nop
  1c1010:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1c1014:	c9                   	leave  
  1c1015:	c3                   	ret    

00000000001c1016 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1c1016:	f3 0f 1e fa          	endbr64 
  1c101a:	55                   	push   %rbp
  1c101b:	48 89 e5             	mov    %rsp,%rbp
  1c101e:	48 83 ec 20          	sub    $0x20,%rsp
  1c1022:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c1026:	89 f0                	mov    %esi,%eax
  1c1028:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1c102b:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1c102e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c1032:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1c1036:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c103a:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c103e:	48 8d 15 5b 7f ef ff 	lea    -0x1080a5(%rip),%rdx        # b8fa0 <console+0xfa0>
  1c1045:	48 39 d0             	cmp    %rdx,%rax
  1c1048:	72 0f                	jb     1c1059 <console_putc+0x43>
        cp->cursor = console;
  1c104a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c104e:	48 8d 15 ab 6f ef ff 	lea    -0x109055(%rip),%rdx        # b8000 <console>
  1c1055:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  1c1059:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1c105d:	0f 85 82 00 00 00    	jne    1c10e5 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  1c1063:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c1067:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c106b:	48 8d 15 8e 6f ef ff 	lea    -0x109072(%rip),%rdx        # b8000 <console>
  1c1072:	48 29 d0             	sub    %rdx,%rax
  1c1075:	48 d1 f8             	sar    %rax
  1c1078:	48 89 c1             	mov    %rax,%rcx
  1c107b:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1c1082:	66 66 66 
  1c1085:	48 89 c8             	mov    %rcx,%rax
  1c1088:	48 f7 ea             	imul   %rdx
  1c108b:	48 89 d0             	mov    %rdx,%rax
  1c108e:	48 c1 f8 05          	sar    $0x5,%rax
  1c1092:	48 89 ce             	mov    %rcx,%rsi
  1c1095:	48 c1 fe 3f          	sar    $0x3f,%rsi
  1c1099:	48 29 f0             	sub    %rsi,%rax
  1c109c:	48 89 c2             	mov    %rax,%rdx
  1c109f:	48 89 d0             	mov    %rdx,%rax
  1c10a2:	48 c1 e0 02          	shl    $0x2,%rax
  1c10a6:	48 01 d0             	add    %rdx,%rax
  1c10a9:	48 c1 e0 04          	shl    $0x4,%rax
  1c10ad:	48 29 c1             	sub    %rax,%rcx
  1c10b0:	48 89 ca             	mov    %rcx,%rdx
  1c10b3:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1c10b6:	eb 25                	jmp    1c10dd <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  1c10b8:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1c10bb:	83 c8 20             	or     $0x20,%eax
  1c10be:	89 c6                	mov    %eax,%esi
  1c10c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c10c4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c10c8:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1c10cc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1c10d0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c10d4:	89 f2                	mov    %esi,%edx
  1c10d6:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  1c10d9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1c10dd:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1c10e1:	75 d5                	jne    1c10b8 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1c10e3:	eb 24                	jmp    1c1109 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  1c10e5:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1c10e9:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1c10ec:	89 d6                	mov    %edx,%esi
  1c10ee:	09 c6                	or     %eax,%esi
  1c10f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c10f4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c10f8:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1c10fc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1c1100:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c1104:	89 f2                	mov    %esi,%edx
  1c1106:	66 89 10             	mov    %dx,(%rax)
}
  1c1109:	90                   	nop
  1c110a:	c9                   	leave  
  1c110b:	c3                   	ret    

00000000001c110c <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1c110c:	f3 0f 1e fa          	endbr64 
  1c1110:	55                   	push   %rbp
  1c1111:	48 89 e5             	mov    %rsp,%rbp
  1c1114:	48 83 ec 30          	sub    $0x30,%rsp
  1c1118:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1c111b:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1c111e:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1c1122:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1c1126:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 1c1016 <console_putc>
  1c112d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1c1131:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1c1135:	78 09                	js     1c1140 <console_vprintf+0x34>
  1c1137:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1c113e:	7e 07                	jle    1c1147 <console_vprintf+0x3b>
        cpos = 0;
  1c1140:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1c1147:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1c114a:	48 98                	cltq   
  1c114c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1c1150:	48 8d 05 a9 6e ef ff 	lea    -0x109157(%rip),%rax        # b8000 <console>
  1c1157:	48 01 d0             	add    %rdx,%rax
  1c115a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1c115e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1c1162:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1c1166:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1c1169:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1c116d:	48 89 c7             	mov    %rax,%rdi
  1c1170:	e8 9a f4 ff ff       	call   1c060f <printer_vprintf>
    return cp.cursor - console;
  1c1175:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c1179:	48 8d 15 80 6e ef ff 	lea    -0x109180(%rip),%rdx        # b8000 <console>
  1c1180:	48 29 d0             	sub    %rdx,%rax
  1c1183:	48 d1 f8             	sar    %rax
}
  1c1186:	c9                   	leave  
  1c1187:	c3                   	ret    

00000000001c1188 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1c1188:	f3 0f 1e fa          	endbr64 
  1c118c:	55                   	push   %rbp
  1c118d:	48 89 e5             	mov    %rsp,%rbp
  1c1190:	48 83 ec 60          	sub    $0x60,%rsp
  1c1194:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1c1197:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1c119a:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1c119e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1c11a2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1c11a6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1c11aa:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1c11b1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1c11b5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1c11b9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1c11bd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1c11c1:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1c11c5:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1c11c9:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1c11cc:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1c11cf:	89 c7                	mov    %eax,%edi
  1c11d1:	e8 36 ff ff ff       	call   1c110c <console_vprintf>
  1c11d6:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  1c11d9:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1c11dc:	c9                   	leave  
  1c11dd:	c3                   	ret    

00000000001c11de <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1c11de:	f3 0f 1e fa          	endbr64 
  1c11e2:	55                   	push   %rbp
  1c11e3:	48 89 e5             	mov    %rsp,%rbp
  1c11e6:	48 83 ec 20          	sub    $0x20,%rsp
  1c11ea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1c11ee:	89 f0                	mov    %esi,%eax
  1c11f0:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1c11f3:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1c11f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1c11fa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1c11fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c1202:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1c1206:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c120a:	48 8b 40 10          	mov    0x10(%rax),%rax
  1c120e:	48 39 c2             	cmp    %rax,%rdx
  1c1211:	73 1a                	jae    1c122d <string_putc+0x4f>
        *sp->s++ = c;
  1c1213:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c1217:	48 8b 40 08          	mov    0x8(%rax),%rax
  1c121b:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1c121f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1c1223:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1c1227:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1c122b:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1c122d:	90                   	nop
  1c122e:	c9                   	leave  
  1c122f:	c3                   	ret    

00000000001c1230 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1c1230:	f3 0f 1e fa          	endbr64 
  1c1234:	55                   	push   %rbp
  1c1235:	48 89 e5             	mov    %rsp,%rbp
  1c1238:	48 83 ec 40          	sub    $0x40,%rsp
  1c123c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1c1240:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1c1244:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1c1248:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1c124c:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 1c11de <string_putc>
  1c1253:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  1c1257:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c125b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1c125f:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1c1264:	74 33                	je     1c1299 <vsnprintf+0x69>
        sp.end = s + size - 1;
  1c1266:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1c126a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1c126e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1c1272:	48 01 d0             	add    %rdx,%rax
  1c1275:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1c1279:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1c127d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1c1281:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1c1285:	be 00 00 00 00       	mov    $0x0,%esi
  1c128a:	48 89 c7             	mov    %rax,%rdi
  1c128d:	e8 7d f3 ff ff       	call   1c060f <printer_vprintf>
        *sp.s = 0;
  1c1292:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c1296:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1c1299:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1c129d:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1c12a1:	c9                   	leave  
  1c12a2:	c3                   	ret    

00000000001c12a3 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1c12a3:	f3 0f 1e fa          	endbr64 
  1c12a7:	55                   	push   %rbp
  1c12a8:	48 89 e5             	mov    %rsp,%rbp
  1c12ab:	48 83 ec 70          	sub    $0x70,%rsp
  1c12af:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1c12b3:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1c12b7:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1c12bb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1c12bf:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1c12c3:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1c12c7:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  1c12ce:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1c12d2:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  1c12d6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1c12da:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1c12de:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1c12e2:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1c12e6:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1c12ea:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1c12ee:	48 89 c7             	mov    %rax,%rdi
  1c12f1:	e8 3a ff ff ff       	call   1c1230 <vsnprintf>
  1c12f6:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1c12f9:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1c12fc:	c9                   	leave  
  1c12fd:	c3                   	ret    

00000000001c12fe <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1c12fe:	f3 0f 1e fa          	endbr64 
  1c1302:	55                   	push   %rbp
  1c1303:	48 89 e5             	mov    %rsp,%rbp
  1c1306:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1c130a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1c1311:	eb 1a                	jmp    1c132d <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  1c1313:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1c1316:	48 98                	cltq   
  1c1318:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1c131c:	48 8d 05 dd 6c ef ff 	lea    -0x109323(%rip),%rax        # b8000 <console>
  1c1323:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1c1329:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1c132d:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1c1334:	7e dd                	jle    1c1313 <console_clear+0x15>
    }
    cursorpos = 0;
  1c1336:	c7 05 bc 7c ef ff 00 	movl   $0x0,-0x108344(%rip)        # b8ffc <cursorpos>
  1c133d:	00 00 00 
}
  1c1340:	90                   	nop
  1c1341:	c9                   	leave  
  1c1342:	c3                   	ret    
