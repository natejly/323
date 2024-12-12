
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t *heap_bottom;
uint8_t *stack_bottom;



void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	41 56                	push   %r14
  10000a:	41 55                	push   %r13
  10000c:	41 54                	push   %r12
  10000e:	53                   	push   %rbx

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000f:	cd 31                	int    $0x31
  100011:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  100013:	e8 ca 05 00 00       	call   1005e2 <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100018:	48 8d 05 00 30 00 00 	lea    0x3000(%rip),%rax        # 10301f <end+0xfff>
  10001f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100025:	48 89 05 e4 1f 00 00 	mov    %rax,0x1fe4(%rip)        # 102010 <heap_top>
  10002c:	48 89 05 d5 1f 00 00 	mov    %rax,0x1fd5(%rip)        # 102008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100033:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100036:	48 83 e8 01          	sub    $0x1,%rax
  10003a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100040:	48 89 05 b9 1f 00 00 	mov    %rax,0x1fb9(%rip)        # 102000 <stack_bottom>
  100047:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  10004d:	45 89 ee             	mov    %r13d,%r14d
void process_main(void) {
  100050:	44 89 eb             	mov    %r13d,%ebx
  100053:	41 bc 01 00 00 00    	mov    $0x1,%r12d

    /* Single elements on heap of varying sizes */
    for(int i = 1; i < 64; ++i) {
        for(int j = 1; j < 64; ++j) {
            void *ptr = calloc(i,j);
  100059:	4c 89 e6             	mov    %r12,%rsi
  10005c:	4c 89 ef             	mov    %r13,%rdi
  10005f:	e8 40 02 00 00       	call   1002a4 <calloc>
  100064:	48 89 c7             	mov    %rax,%rdi
            assert(ptr != NULL);
  100067:	48 85 c0             	test   %rax,%rax
  10006a:	74 54                	je     1000c0 <process_main+0xc0>

            for(int k = 0; k < i*j; ++k) {
  10006c:	85 db                	test   %ebx,%ebx
  10006e:	7e 19                	jle    100089 <process_main+0x89>
  100070:	48 89 c2             	mov    %rax,%rdx
  100073:	8d 43 ff             	lea    -0x1(%rbx),%eax
  100076:	48 8d 4c 07 01       	lea    0x1(%rdi,%rax,1),%rcx
                assert(((char *)ptr)[k] == 0);
  10007b:	80 3a 00             	cmpb   $0x0,(%rdx)
  10007e:	75 58                	jne    1000d8 <process_main+0xd8>
            for(int k = 0; k < i*j; ++k) {
  100080:	48 83 c2 01          	add    $0x1,%rdx
  100084:	48 39 ca             	cmp    %rcx,%rdx
  100087:	75 f2                	jne    10007b <process_main+0x7b>
            }

            free(ptr);
  100089:	e8 07 02 00 00       	call   100295 <free>
        for(int j = 1; j < 64; ++j) {
  10008e:	49 83 c4 01          	add    $0x1,%r12
  100092:	44 01 f3             	add    %r14d,%ebx
  100095:	49 83 fc 40          	cmp    $0x40,%r12
  100099:	75 be                	jne    100059 <process_main+0x59>
        }
	defrag();
  10009b:	b8 00 00 00 00       	mov    $0x0,%eax
  1000a0:	e8 13 02 00 00       	call   1002b8 <defrag>
    for(int i = 1; i < 64; ++i) {
  1000a5:	49 83 c5 01          	add    $0x1,%r13
  1000a9:	49 83 fd 40          	cmp    $0x40,%r13
  1000ad:	75 9e                	jne    10004d <process_main+0x4d>
    }

    TEST_PASS();
  1000af:	48 8d 3d 4c 13 00 00 	lea    0x134c(%rip),%rdi        # 101402 <console_clear+0x80>
  1000b6:	b8 00 00 00 00       	mov    $0x0,%eax
  1000bb:	e8 c8 00 00 00       	call   100188 <kernel_panic>
            assert(ptr != NULL);
  1000c0:	48 8d 15 09 13 00 00 	lea    0x1309(%rip),%rdx        # 1013d0 <console_clear+0x4e>
  1000c7:	be 19 00 00 00       	mov    $0x19,%esi
  1000cc:	48 8d 3d 09 13 00 00 	lea    0x1309(%rip),%rdi        # 1013dc <console_clear+0x5a>
  1000d3:	e8 88 01 00 00       	call   100260 <assert_fail>
                assert(((char *)ptr)[k] == 0);
  1000d8:	48 8d 15 0d 13 00 00 	lea    0x130d(%rip),%rdx        # 1013ec <console_clear+0x6a>
  1000df:	be 1c 00 00 00       	mov    $0x1c,%esi
  1000e4:	48 8d 3d f1 12 00 00 	lea    0x12f1(%rip),%rdi        # 1013dc <console_clear+0x5a>
  1000eb:	e8 70 01 00 00       	call   100260 <assert_fail>

00000000001000f0 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1000f0:	f3 0f 1e fa          	endbr64 
  1000f4:	55                   	push   %rbp
  1000f5:	48 89 e5             	mov    %rsp,%rbp
  1000f8:	48 83 ec 50          	sub    $0x50,%rsp
  1000fc:	49 89 f2             	mov    %rsi,%r10
  1000ff:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100103:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100107:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10010b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  10010f:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100114:	85 ff                	test   %edi,%edi
  100116:	78 32                	js     10014a <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100118:	48 63 ff             	movslq %edi,%rdi
  10011b:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100122:	cc cc cc 
  100125:	48 89 f8             	mov    %rdi,%rax
  100128:	48 f7 e2             	mul    %rdx
  10012b:	48 89 d0             	mov    %rdx,%rax
  10012e:	48 c1 e8 02          	shr    $0x2,%rax
  100132:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100136:	48 01 c2             	add    %rax,%rdx
  100139:	48 29 d7             	sub    %rdx,%rdi
  10013c:	48 8d 05 12 13 00 00 	lea    0x1312(%rip),%rax        # 101455 <col.0>
  100143:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  100147:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  10014a:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100151:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100155:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100159:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10015d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100161:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100165:	4c 89 d2             	mov    %r10,%rdx
  100168:	8b 3d 8e 8e fb ff    	mov    -0x47172(%rip),%edi        # b8ffc <cursorpos>
  10016e:	e8 1d 10 00 00       	call   101190 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100173:	3d 30 07 00 00       	cmp    $0x730,%eax
  100178:	ba 00 00 00 00       	mov    $0x0,%edx
  10017d:	0f 4d c2             	cmovge %edx,%eax
  100180:	89 05 76 8e fb ff    	mov    %eax,-0x4718a(%rip)        # b8ffc <cursorpos>
    }
}
  100186:	c9                   	leave  
  100187:	c3                   	ret    

0000000000100188 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  100188:	f3 0f 1e fa          	endbr64 
  10018c:	55                   	push   %rbp
  10018d:	48 89 e5             	mov    %rsp,%rbp
  100190:	53                   	push   %rbx
  100191:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100198:	48 89 fb             	mov    %rdi,%rbx
  10019b:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10019f:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  1001a3:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  1001a7:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  1001ab:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  1001af:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1001b6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001ba:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1001be:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1001c2:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  1001c6:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1001cd:	ba 07 00 00 00       	mov    $0x7,%edx
  1001d2:	48 8d 35 44 12 00 00 	lea    0x1244(%rip),%rsi        # 10141d <console_clear+0x9b>
  1001d9:	e8 e9 00 00 00       	call   1002c7 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  1001de:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  1001e2:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  1001e9:	48 89 da             	mov    %rbx,%rdx
  1001ec:	be 99 00 00 00       	mov    $0x99,%esi
  1001f1:	e8 be 10 00 00       	call   1012b4 <vsnprintf>
  1001f6:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  1001f9:	85 d2                	test   %edx,%edx
  1001fb:	7e 0f                	jle    10020c <kernel_panic+0x84>
  1001fd:	83 c0 06             	add    $0x6,%eax
  100200:	48 98                	cltq   
  100202:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100209:	0a 
  10020a:	75 2c                	jne    100238 <kernel_panic+0xb0>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  10020c:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  100213:	48 89 d9             	mov    %rbx,%rcx
  100216:	48 8d 15 0a 12 00 00 	lea    0x120a(%rip),%rdx        # 101427 <console_clear+0xa5>
  10021d:	be 00 c0 00 00       	mov    $0xc000,%esi
  100222:	bf 30 07 00 00       	mov    $0x730,%edi
  100227:	b8 00 00 00 00       	mov    $0x0,%eax
  10022c:	e8 db 0f 00 00       	call   10120c <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100231:	48 89 df             	mov    %rbx,%rdi
  100234:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  100236:	eb fe                	jmp    100236 <kernel_panic+0xae>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100238:	48 63 c2             	movslq %edx,%rax
  10023b:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100241:	0f 94 c2             	sete   %dl
  100244:	0f b6 d2             	movzbl %dl,%edx
  100247:	48 29 d0             	sub    %rdx,%rax
  10024a:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100251:	ff 
  100252:	48 8d 35 cc 11 00 00 	lea    0x11cc(%rip),%rsi        # 101425 <console_clear+0xa3>
  100259:	e8 2a 02 00 00       	call   100488 <strcpy>
  10025e:	eb ac                	jmp    10020c <kernel_panic+0x84>

0000000000100260 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100260:	f3 0f 1e fa          	endbr64 
  100264:	55                   	push   %rbp
  100265:	48 89 e5             	mov    %rsp,%rbp
  100268:	48 89 f9             	mov    %rdi,%rcx
  10026b:	41 89 f0             	mov    %esi,%r8d
  10026e:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100271:	48 8d 15 b8 11 00 00 	lea    0x11b8(%rip),%rdx        # 101430 <console_clear+0xae>
  100278:	be 00 c0 00 00       	mov    $0xc000,%esi
  10027d:	bf 30 07 00 00       	mov    $0x730,%edi
  100282:	b8 00 00 00 00       	mov    $0x0,%eax
  100287:	e8 80 0f 00 00       	call   10120c <console_printf>
    asm volatile ("int %0" : /* no result */
  10028c:	bf 00 00 00 00       	mov    $0x0,%edi
  100291:	cd 30                	int    $0x30
 loop: goto loop;
  100293:	eb fe                	jmp    100293 <assert_fail+0x33>

0000000000100295 <free>:
#include "malloc.h"

void free(void *firstbyte) {
  100295:	f3 0f 1e fa          	endbr64 
    return;
}
  100299:	c3                   	ret    

000000000010029a <malloc>:

void *malloc(uint64_t numbytes) {
  10029a:	f3 0f 1e fa          	endbr64 
    return 0 ;
}
  10029e:	b8 00 00 00 00       	mov    $0x0,%eax
  1002a3:	c3                   	ret    

00000000001002a4 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  1002a4:	f3 0f 1e fa          	endbr64 
    return 0;
}
  1002a8:	b8 00 00 00 00       	mov    $0x0,%eax
  1002ad:	c3                   	ret    

00000000001002ae <realloc>:

void * realloc(void * ptr, uint64_t sz) {
  1002ae:	f3 0f 1e fa          	endbr64 
    return 0;
}
  1002b2:	b8 00 00 00 00       	mov    $0x0,%eax
  1002b7:	c3                   	ret    

00000000001002b8 <defrag>:

void defrag() {
  1002b8:	f3 0f 1e fa          	endbr64 
}
  1002bc:	c3                   	ret    

00000000001002bd <heap_info>:

int heap_info(heap_info_struct * info) {
  1002bd:	f3 0f 1e fa          	endbr64 
    return 0;
}
  1002c1:	b8 00 00 00 00       	mov    $0x0,%eax
  1002c6:	c3                   	ret    

00000000001002c7 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1002c7:	f3 0f 1e fa          	endbr64 
  1002cb:	55                   	push   %rbp
  1002cc:	48 89 e5             	mov    %rsp,%rbp
  1002cf:	48 83 ec 28          	sub    $0x28,%rsp
  1002d3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1002d7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1002db:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1002df:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1002e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1002eb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1002ef:	eb 1c                	jmp    10030d <memcpy+0x46>
        *d = *s;
  1002f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002f5:	0f b6 10             	movzbl (%rax),%edx
  1002f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002fc:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002fe:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100303:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100308:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  10030d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100312:	75 dd                	jne    1002f1 <memcpy+0x2a>
    }
    return dst;
  100314:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100318:	c9                   	leave  
  100319:	c3                   	ret    

000000000010031a <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  10031a:	f3 0f 1e fa          	endbr64 
  10031e:	55                   	push   %rbp
  10031f:	48 89 e5             	mov    %rsp,%rbp
  100322:	48 83 ec 28          	sub    $0x28,%rsp
  100326:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10032a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10032e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100332:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100336:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10033a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10033e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100342:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100346:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10034a:	73 6a                	jae    1003b6 <memmove+0x9c>
  10034c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100350:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100354:	48 01 d0             	add    %rdx,%rax
  100357:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  10035b:	73 59                	jae    1003b6 <memmove+0x9c>
        s += n, d += n;
  10035d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100361:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100365:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100369:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  10036d:	eb 17                	jmp    100386 <memmove+0x6c>
            *--d = *--s;
  10036f:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100374:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100379:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10037d:	0f b6 10             	movzbl (%rax),%edx
  100380:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100384:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100386:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10038a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  10038e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100392:	48 85 c0             	test   %rax,%rax
  100395:	75 d8                	jne    10036f <memmove+0x55>
    if (s < d && s + n > d) {
  100397:	eb 2e                	jmp    1003c7 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100399:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10039d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1003a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1003a9:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1003ad:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1003b1:	0f b6 12             	movzbl (%rdx),%edx
  1003b4:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1003b6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1003ba:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1003be:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1003c2:	48 85 c0             	test   %rax,%rax
  1003c5:	75 d2                	jne    100399 <memmove+0x7f>
        }
    }
    return dst;
  1003c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1003cb:	c9                   	leave  
  1003cc:	c3                   	ret    

00000000001003cd <memset>:

void* memset(void* v, int c, size_t n) {
  1003cd:	f3 0f 1e fa          	endbr64 
  1003d1:	55                   	push   %rbp
  1003d2:	48 89 e5             	mov    %rsp,%rbp
  1003d5:	48 83 ec 28          	sub    $0x28,%rsp
  1003d9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003dd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1003e0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1003e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1003ec:	eb 15                	jmp    100403 <memset+0x36>
        *p = c;
  1003ee:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1003f1:	89 c2                	mov    %eax,%edx
  1003f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1003f7:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1003f9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1003fe:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100403:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100408:	75 e4                	jne    1003ee <memset+0x21>
    }
    return v;
  10040a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10040e:	c9                   	leave  
  10040f:	c3                   	ret    

0000000000100410 <strlen>:

size_t strlen(const char* s) {
  100410:	f3 0f 1e fa          	endbr64 
  100414:	55                   	push   %rbp
  100415:	48 89 e5             	mov    %rsp,%rbp
  100418:	48 83 ec 18          	sub    $0x18,%rsp
  10041c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100420:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100427:	00 
  100428:	eb 0a                	jmp    100434 <strlen+0x24>
        ++n;
  10042a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10042f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100434:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100438:	0f b6 00             	movzbl (%rax),%eax
  10043b:	84 c0                	test   %al,%al
  10043d:	75 eb                	jne    10042a <strlen+0x1a>
    }
    return n;
  10043f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100443:	c9                   	leave  
  100444:	c3                   	ret    

0000000000100445 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100445:	f3 0f 1e fa          	endbr64 
  100449:	55                   	push   %rbp
  10044a:	48 89 e5             	mov    %rsp,%rbp
  10044d:	48 83 ec 20          	sub    $0x20,%rsp
  100451:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100455:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100459:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100460:	00 
  100461:	eb 0a                	jmp    10046d <strnlen+0x28>
        ++n;
  100463:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100468:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10046d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100471:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100475:	74 0b                	je     100482 <strnlen+0x3d>
  100477:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10047b:	0f b6 00             	movzbl (%rax),%eax
  10047e:	84 c0                	test   %al,%al
  100480:	75 e1                	jne    100463 <strnlen+0x1e>
    }
    return n;
  100482:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100486:	c9                   	leave  
  100487:	c3                   	ret    

0000000000100488 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100488:	f3 0f 1e fa          	endbr64 
  10048c:	55                   	push   %rbp
  10048d:	48 89 e5             	mov    %rsp,%rbp
  100490:	48 83 ec 20          	sub    $0x20,%rsp
  100494:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100498:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  10049c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1004a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1004a4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1004a8:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1004ac:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1004b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004b4:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1004b8:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1004bc:	0f b6 12             	movzbl (%rdx),%edx
  1004bf:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1004c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004c5:	48 83 e8 01          	sub    $0x1,%rax
  1004c9:	0f b6 00             	movzbl (%rax),%eax
  1004cc:	84 c0                	test   %al,%al
  1004ce:	75 d4                	jne    1004a4 <strcpy+0x1c>
    return dst;
  1004d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1004d4:	c9                   	leave  
  1004d5:	c3                   	ret    

00000000001004d6 <strcmp>:

int strcmp(const char* a, const char* b) {
  1004d6:	f3 0f 1e fa          	endbr64 
  1004da:	55                   	push   %rbp
  1004db:	48 89 e5             	mov    %rsp,%rbp
  1004de:	48 83 ec 10          	sub    $0x10,%rsp
  1004e2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1004e6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004ea:	eb 0a                	jmp    1004f6 <strcmp+0x20>
        ++a, ++b;
  1004ec:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1004f1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1004f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1004fa:	0f b6 00             	movzbl (%rax),%eax
  1004fd:	84 c0                	test   %al,%al
  1004ff:	74 1d                	je     10051e <strcmp+0x48>
  100501:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100505:	0f b6 00             	movzbl (%rax),%eax
  100508:	84 c0                	test   %al,%al
  10050a:	74 12                	je     10051e <strcmp+0x48>
  10050c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100510:	0f b6 10             	movzbl (%rax),%edx
  100513:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100517:	0f b6 00             	movzbl (%rax),%eax
  10051a:	38 c2                	cmp    %al,%dl
  10051c:	74 ce                	je     1004ec <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  10051e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100522:	0f b6 00             	movzbl (%rax),%eax
  100525:	89 c2                	mov    %eax,%edx
  100527:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10052b:	0f b6 00             	movzbl (%rax),%eax
  10052e:	38 c2                	cmp    %al,%dl
  100530:	0f 97 c0             	seta   %al
  100533:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100536:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10053a:	0f b6 00             	movzbl (%rax),%eax
  10053d:	89 c1                	mov    %eax,%ecx
  10053f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100543:	0f b6 00             	movzbl (%rax),%eax
  100546:	38 c1                	cmp    %al,%cl
  100548:	0f 92 c0             	setb   %al
  10054b:	0f b6 c8             	movzbl %al,%ecx
  10054e:	89 d0                	mov    %edx,%eax
  100550:	29 c8                	sub    %ecx,%eax
}
  100552:	c9                   	leave  
  100553:	c3                   	ret    

0000000000100554 <strchr>:

char* strchr(const char* s, int c) {
  100554:	f3 0f 1e fa          	endbr64 
  100558:	55                   	push   %rbp
  100559:	48 89 e5             	mov    %rsp,%rbp
  10055c:	48 83 ec 10          	sub    $0x10,%rsp
  100560:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100564:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100567:	eb 05                	jmp    10056e <strchr+0x1a>
        ++s;
  100569:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  10056e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100572:	0f b6 00             	movzbl (%rax),%eax
  100575:	84 c0                	test   %al,%al
  100577:	74 0e                	je     100587 <strchr+0x33>
  100579:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10057d:	0f b6 00             	movzbl (%rax),%eax
  100580:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100583:	38 d0                	cmp    %dl,%al
  100585:	75 e2                	jne    100569 <strchr+0x15>
    }
    if (*s == (char) c) {
  100587:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10058b:	0f b6 00             	movzbl (%rax),%eax
  10058e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100591:	38 d0                	cmp    %dl,%al
  100593:	75 06                	jne    10059b <strchr+0x47>
        return (char*) s;
  100595:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100599:	eb 05                	jmp    1005a0 <strchr+0x4c>
    } else {
        return NULL;
  10059b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1005a0:	c9                   	leave  
  1005a1:	c3                   	ret    

00000000001005a2 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1005a2:	f3 0f 1e fa          	endbr64 
  1005a6:	55                   	push   %rbp
  1005a7:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1005aa:	8b 05 68 1a 00 00    	mov    0x1a68(%rip),%eax        # 102018 <rand_seed_set>
  1005b0:	85 c0                	test   %eax,%eax
  1005b2:	75 0a                	jne    1005be <rand+0x1c>
        srand(819234718U);
  1005b4:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1005b9:	e8 24 00 00 00       	call   1005e2 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1005be:	8b 05 58 1a 00 00    	mov    0x1a58(%rip),%eax        # 10201c <rand_seed>
  1005c4:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1005ca:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1005cf:	89 05 47 1a 00 00    	mov    %eax,0x1a47(%rip)        # 10201c <rand_seed>
    return rand_seed & RAND_MAX;
  1005d5:	8b 05 41 1a 00 00    	mov    0x1a41(%rip),%eax        # 10201c <rand_seed>
  1005db:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1005e0:	5d                   	pop    %rbp
  1005e1:	c3                   	ret    

00000000001005e2 <srand>:

void srand(unsigned seed) {
  1005e2:	f3 0f 1e fa          	endbr64 
  1005e6:	55                   	push   %rbp
  1005e7:	48 89 e5             	mov    %rsp,%rbp
  1005ea:	48 83 ec 08          	sub    $0x8,%rsp
  1005ee:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1005f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1005f4:	89 05 22 1a 00 00    	mov    %eax,0x1a22(%rip)        # 10201c <rand_seed>
    rand_seed_set = 1;
  1005fa:	c7 05 14 1a 00 00 01 	movl   $0x1,0x1a14(%rip)        # 102018 <rand_seed_set>
  100601:	00 00 00 
}
  100604:	90                   	nop
  100605:	c9                   	leave  
  100606:	c3                   	ret    

0000000000100607 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100607:	f3 0f 1e fa          	endbr64 
  10060b:	55                   	push   %rbp
  10060c:	48 89 e5             	mov    %rsp,%rbp
  10060f:	48 83 ec 28          	sub    $0x28,%rsp
  100613:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100617:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10061b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  10061e:	48 8d 05 3b 0f 00 00 	lea    0xf3b(%rip),%rax        # 101560 <upper_digits.1>
  100625:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  100629:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10062d:	79 0e                	jns    10063d <fill_numbuf+0x36>
        digits = lower_digits;
  10062f:	48 8d 05 4a 0f 00 00 	lea    0xf4a(%rip),%rax        # 101580 <lower_digits.0>
  100636:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  10063a:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  10063d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100642:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100646:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100649:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10064c:	48 63 c8             	movslq %eax,%rcx
  10064f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100653:	ba 00 00 00 00       	mov    $0x0,%edx
  100658:	48 f7 f1             	div    %rcx
  10065b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10065f:	48 01 d0             	add    %rdx,%rax
  100662:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100667:	0f b6 10             	movzbl (%rax),%edx
  10066a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10066e:	88 10                	mov    %dl,(%rax)
        val /= base;
  100670:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100673:	48 63 f0             	movslq %eax,%rsi
  100676:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10067a:	ba 00 00 00 00       	mov    $0x0,%edx
  10067f:	48 f7 f6             	div    %rsi
  100682:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100686:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  10068b:	75 bc                	jne    100649 <fill_numbuf+0x42>
    return numbuf_end;
  10068d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100691:	c9                   	leave  
  100692:	c3                   	ret    

0000000000100693 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100693:	f3 0f 1e fa          	endbr64 
  100697:	55                   	push   %rbp
  100698:	48 89 e5             	mov    %rsp,%rbp
  10069b:	53                   	push   %rbx
  10069c:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1006a3:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1006aa:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1006b0:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1006b7:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1006be:	e9 bd 09 00 00       	jmp    101080 <printer_vprintf+0x9ed>
        if (*format != '%') {
  1006c3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006ca:	0f b6 00             	movzbl (%rax),%eax
  1006cd:	3c 25                	cmp    $0x25,%al
  1006cf:	74 31                	je     100702 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  1006d1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006d8:	4c 8b 00             	mov    (%rax),%r8
  1006db:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006e2:	0f b6 00             	movzbl (%rax),%eax
  1006e5:	0f b6 c8             	movzbl %al,%ecx
  1006e8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1006ee:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1006f5:	89 ce                	mov    %ecx,%esi
  1006f7:	48 89 c7             	mov    %rax,%rdi
  1006fa:	41 ff d0             	call   *%r8
            continue;
  1006fd:	e9 76 09 00 00       	jmp    101078 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  100702:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100709:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100710:	01 
  100711:	eb 4d                	jmp    100760 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  100713:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10071a:	0f b6 00             	movzbl (%rax),%eax
  10071d:	0f be c0             	movsbl %al,%eax
  100720:	89 c6                	mov    %eax,%esi
  100722:	48 8d 05 37 0d 00 00 	lea    0xd37(%rip),%rax        # 101460 <flag_chars>
  100729:	48 89 c7             	mov    %rax,%rdi
  10072c:	e8 23 fe ff ff       	call   100554 <strchr>
  100731:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100735:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10073a:	74 34                	je     100770 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  10073c:	48 8d 15 1d 0d 00 00 	lea    0xd1d(%rip),%rdx        # 101460 <flag_chars>
  100743:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100747:	48 29 d0             	sub    %rdx,%rax
  10074a:	ba 01 00 00 00       	mov    $0x1,%edx
  10074f:	89 c1                	mov    %eax,%ecx
  100751:	d3 e2                	shl    %cl,%edx
  100753:	89 d0                	mov    %edx,%eax
  100755:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100758:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10075f:	01 
  100760:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100767:	0f b6 00             	movzbl (%rax),%eax
  10076a:	84 c0                	test   %al,%al
  10076c:	75 a5                	jne    100713 <printer_vprintf+0x80>
  10076e:	eb 01                	jmp    100771 <printer_vprintf+0xde>
            } else {
                break;
  100770:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100771:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100778:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10077f:	0f b6 00             	movzbl (%rax),%eax
  100782:	3c 30                	cmp    $0x30,%al
  100784:	7e 67                	jle    1007ed <printer_vprintf+0x15a>
  100786:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10078d:	0f b6 00             	movzbl (%rax),%eax
  100790:	3c 39                	cmp    $0x39,%al
  100792:	7f 59                	jg     1007ed <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100794:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  10079b:	eb 2e                	jmp    1007cb <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  10079d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1007a0:	89 d0                	mov    %edx,%eax
  1007a2:	c1 e0 02             	shl    $0x2,%eax
  1007a5:	01 d0                	add    %edx,%eax
  1007a7:	01 c0                	add    %eax,%eax
  1007a9:	89 c1                	mov    %eax,%ecx
  1007ab:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007b2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1007b6:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1007bd:	0f b6 00             	movzbl (%rax),%eax
  1007c0:	0f be c0             	movsbl %al,%eax
  1007c3:	01 c8                	add    %ecx,%eax
  1007c5:	83 e8 30             	sub    $0x30,%eax
  1007c8:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1007cb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007d2:	0f b6 00             	movzbl (%rax),%eax
  1007d5:	3c 2f                	cmp    $0x2f,%al
  1007d7:	0f 8e 85 00 00 00    	jle    100862 <printer_vprintf+0x1cf>
  1007dd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007e4:	0f b6 00             	movzbl (%rax),%eax
  1007e7:	3c 39                	cmp    $0x39,%al
  1007e9:	7e b2                	jle    10079d <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  1007eb:	eb 75                	jmp    100862 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  1007ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1007f4:	0f b6 00             	movzbl (%rax),%eax
  1007f7:	3c 2a                	cmp    $0x2a,%al
  1007f9:	75 68                	jne    100863 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  1007fb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100802:	8b 00                	mov    (%rax),%eax
  100804:	83 f8 2f             	cmp    $0x2f,%eax
  100807:	77 30                	ja     100839 <printer_vprintf+0x1a6>
  100809:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100810:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100814:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10081b:	8b 00                	mov    (%rax),%eax
  10081d:	89 c0                	mov    %eax,%eax
  10081f:	48 01 d0             	add    %rdx,%rax
  100822:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100829:	8b 12                	mov    (%rdx),%edx
  10082b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10082e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100835:	89 0a                	mov    %ecx,(%rdx)
  100837:	eb 1a                	jmp    100853 <printer_vprintf+0x1c0>
  100839:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100840:	48 8b 40 08          	mov    0x8(%rax),%rax
  100844:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100848:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10084f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100853:	8b 00                	mov    (%rax),%eax
  100855:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100858:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10085f:	01 
  100860:	eb 01                	jmp    100863 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  100862:	90                   	nop
        }

        // process precision
        int precision = -1;
  100863:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  10086a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100871:	0f b6 00             	movzbl (%rax),%eax
  100874:	3c 2e                	cmp    $0x2e,%al
  100876:	0f 85 00 01 00 00    	jne    10097c <printer_vprintf+0x2e9>
            ++format;
  10087c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100883:	01 
            if (*format >= '0' && *format <= '9') {
  100884:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10088b:	0f b6 00             	movzbl (%rax),%eax
  10088e:	3c 2f                	cmp    $0x2f,%al
  100890:	7e 67                	jle    1008f9 <printer_vprintf+0x266>
  100892:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100899:	0f b6 00             	movzbl (%rax),%eax
  10089c:	3c 39                	cmp    $0x39,%al
  10089e:	7f 59                	jg     1008f9 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008a0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  1008a7:	eb 2e                	jmp    1008d7 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  1008a9:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  1008ac:	89 d0                	mov    %edx,%eax
  1008ae:	c1 e0 02             	shl    $0x2,%eax
  1008b1:	01 d0                	add    %edx,%eax
  1008b3:	01 c0                	add    %eax,%eax
  1008b5:	89 c1                	mov    %eax,%ecx
  1008b7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008be:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1008c2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008c9:	0f b6 00             	movzbl (%rax),%eax
  1008cc:	0f be c0             	movsbl %al,%eax
  1008cf:	01 c8                	add    %ecx,%eax
  1008d1:	83 e8 30             	sub    $0x30,%eax
  1008d4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1008d7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008de:	0f b6 00             	movzbl (%rax),%eax
  1008e1:	3c 2f                	cmp    $0x2f,%al
  1008e3:	0f 8e 85 00 00 00    	jle    10096e <printer_vprintf+0x2db>
  1008e9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1008f0:	0f b6 00             	movzbl (%rax),%eax
  1008f3:	3c 39                	cmp    $0x39,%al
  1008f5:	7e b2                	jle    1008a9 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  1008f7:	eb 75                	jmp    10096e <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  1008f9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100900:	0f b6 00             	movzbl (%rax),%eax
  100903:	3c 2a                	cmp    $0x2a,%al
  100905:	75 68                	jne    10096f <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  100907:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10090e:	8b 00                	mov    (%rax),%eax
  100910:	83 f8 2f             	cmp    $0x2f,%eax
  100913:	77 30                	ja     100945 <printer_vprintf+0x2b2>
  100915:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10091c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100920:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100927:	8b 00                	mov    (%rax),%eax
  100929:	89 c0                	mov    %eax,%eax
  10092b:	48 01 d0             	add    %rdx,%rax
  10092e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100935:	8b 12                	mov    (%rdx),%edx
  100937:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10093a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100941:	89 0a                	mov    %ecx,(%rdx)
  100943:	eb 1a                	jmp    10095f <printer_vprintf+0x2cc>
  100945:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10094c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100950:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100954:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10095b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10095f:	8b 00                	mov    (%rax),%eax
  100961:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100964:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10096b:	01 
  10096c:	eb 01                	jmp    10096f <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  10096e:	90                   	nop
            }
            if (precision < 0) {
  10096f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100973:	79 07                	jns    10097c <printer_vprintf+0x2e9>
                precision = 0;
  100975:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  10097c:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100983:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  10098a:	00 
        int length = 0;
  10098b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100992:	48 8d 05 cd 0a 00 00 	lea    0xacd(%rip),%rax        # 101466 <flag_chars+0x6>
  100999:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  10099d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009a4:	0f b6 00             	movzbl (%rax),%eax
  1009a7:	0f be c0             	movsbl %al,%eax
  1009aa:	83 e8 43             	sub    $0x43,%eax
  1009ad:	83 f8 37             	cmp    $0x37,%eax
  1009b0:	0f 87 b6 03 00 00    	ja     100d6c <printer_vprintf+0x6d9>
  1009b6:	89 c0                	mov    %eax,%eax
  1009b8:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  1009bf:	00 
  1009c0:	48 8d 05 ad 0a 00 00 	lea    0xaad(%rip),%rax        # 101474 <flag_chars+0x14>
  1009c7:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  1009ca:	48 98                	cltq   
  1009cc:	48 8d 15 a1 0a 00 00 	lea    0xaa1(%rip),%rdx        # 101474 <flag_chars+0x14>
  1009d3:	48 01 d0             	add    %rdx,%rax
  1009d6:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  1009d9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1009e0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009e7:	01 
            goto again;
  1009e8:	eb b3                	jmp    10099d <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1009ea:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1009ee:	74 5d                	je     100a4d <printer_vprintf+0x3ba>
  1009f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009f7:	8b 00                	mov    (%rax),%eax
  1009f9:	83 f8 2f             	cmp    $0x2f,%eax
  1009fc:	77 30                	ja     100a2e <printer_vprintf+0x39b>
  1009fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a05:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a09:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a10:	8b 00                	mov    (%rax),%eax
  100a12:	89 c0                	mov    %eax,%eax
  100a14:	48 01 d0             	add    %rdx,%rax
  100a17:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a1e:	8b 12                	mov    (%rdx),%edx
  100a20:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a23:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a2a:	89 0a                	mov    %ecx,(%rdx)
  100a2c:	eb 1a                	jmp    100a48 <printer_vprintf+0x3b5>
  100a2e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a35:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a39:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a3d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a44:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a48:	48 8b 00             	mov    (%rax),%rax
  100a4b:	eb 5c                	jmp    100aa9 <printer_vprintf+0x416>
  100a4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a54:	8b 00                	mov    (%rax),%eax
  100a56:	83 f8 2f             	cmp    $0x2f,%eax
  100a59:	77 30                	ja     100a8b <printer_vprintf+0x3f8>
  100a5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a62:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a66:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a6d:	8b 00                	mov    (%rax),%eax
  100a6f:	89 c0                	mov    %eax,%eax
  100a71:	48 01 d0             	add    %rdx,%rax
  100a74:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a7b:	8b 12                	mov    (%rdx),%edx
  100a7d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a80:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a87:	89 0a                	mov    %ecx,(%rdx)
  100a89:	eb 1a                	jmp    100aa5 <printer_vprintf+0x412>
  100a8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a92:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a96:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a9a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aa1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100aa5:	8b 00                	mov    (%rax),%eax
  100aa7:	48 98                	cltq   
  100aa9:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100aad:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ab1:	48 c1 f8 38          	sar    $0x38,%rax
  100ab5:	25 80 00 00 00       	and    $0x80,%eax
  100aba:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100abd:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100ac1:	74 09                	je     100acc <printer_vprintf+0x439>
  100ac3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ac7:	48 f7 d8             	neg    %rax
  100aca:	eb 04                	jmp    100ad0 <printer_vprintf+0x43d>
  100acc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ad0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100ad4:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100ad7:	83 c8 60             	or     $0x60,%eax
  100ada:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100add:	e9 cf 02 00 00       	jmp    100db1 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100ae2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100ae6:	74 5d                	je     100b45 <printer_vprintf+0x4b2>
  100ae8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100aef:	8b 00                	mov    (%rax),%eax
  100af1:	83 f8 2f             	cmp    $0x2f,%eax
  100af4:	77 30                	ja     100b26 <printer_vprintf+0x493>
  100af6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100afd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b01:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b08:	8b 00                	mov    (%rax),%eax
  100b0a:	89 c0                	mov    %eax,%eax
  100b0c:	48 01 d0             	add    %rdx,%rax
  100b0f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b16:	8b 12                	mov    (%rdx),%edx
  100b18:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b1b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b22:	89 0a                	mov    %ecx,(%rdx)
  100b24:	eb 1a                	jmp    100b40 <printer_vprintf+0x4ad>
  100b26:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b2d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b31:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b35:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b3c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b40:	48 8b 00             	mov    (%rax),%rax
  100b43:	eb 5c                	jmp    100ba1 <printer_vprintf+0x50e>
  100b45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b4c:	8b 00                	mov    (%rax),%eax
  100b4e:	83 f8 2f             	cmp    $0x2f,%eax
  100b51:	77 30                	ja     100b83 <printer_vprintf+0x4f0>
  100b53:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b5a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b5e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b65:	8b 00                	mov    (%rax),%eax
  100b67:	89 c0                	mov    %eax,%eax
  100b69:	48 01 d0             	add    %rdx,%rax
  100b6c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b73:	8b 12                	mov    (%rdx),%edx
  100b75:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b78:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b7f:	89 0a                	mov    %ecx,(%rdx)
  100b81:	eb 1a                	jmp    100b9d <printer_vprintf+0x50a>
  100b83:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b8a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b8e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b92:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b99:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b9d:	8b 00                	mov    (%rax),%eax
  100b9f:	89 c0                	mov    %eax,%eax
  100ba1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100ba5:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100ba9:	e9 03 02 00 00       	jmp    100db1 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100bae:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100bb5:	e9 28 ff ff ff       	jmp    100ae2 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100bba:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100bc1:	e9 1c ff ff ff       	jmp    100ae2 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100bc6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bcd:	8b 00                	mov    (%rax),%eax
  100bcf:	83 f8 2f             	cmp    $0x2f,%eax
  100bd2:	77 30                	ja     100c04 <printer_vprintf+0x571>
  100bd4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100bdb:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100bdf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100be6:	8b 00                	mov    (%rax),%eax
  100be8:	89 c0                	mov    %eax,%eax
  100bea:	48 01 d0             	add    %rdx,%rax
  100bed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100bf4:	8b 12                	mov    (%rdx),%edx
  100bf6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100bf9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c00:	89 0a                	mov    %ecx,(%rdx)
  100c02:	eb 1a                	jmp    100c1e <printer_vprintf+0x58b>
  100c04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c0b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c0f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c13:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c1a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c1e:	48 8b 00             	mov    (%rax),%rax
  100c21:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100c25:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100c2c:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100c33:	e9 79 01 00 00       	jmp    100db1 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100c38:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c3f:	8b 00                	mov    (%rax),%eax
  100c41:	83 f8 2f             	cmp    $0x2f,%eax
  100c44:	77 30                	ja     100c76 <printer_vprintf+0x5e3>
  100c46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c4d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c51:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c58:	8b 00                	mov    (%rax),%eax
  100c5a:	89 c0                	mov    %eax,%eax
  100c5c:	48 01 d0             	add    %rdx,%rax
  100c5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c66:	8b 12                	mov    (%rdx),%edx
  100c68:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c6b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c72:	89 0a                	mov    %ecx,(%rdx)
  100c74:	eb 1a                	jmp    100c90 <printer_vprintf+0x5fd>
  100c76:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c7d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c81:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c85:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c8c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c90:	48 8b 00             	mov    (%rax),%rax
  100c93:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100c97:	e9 15 01 00 00       	jmp    100db1 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100c9c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ca3:	8b 00                	mov    (%rax),%eax
  100ca5:	83 f8 2f             	cmp    $0x2f,%eax
  100ca8:	77 30                	ja     100cda <printer_vprintf+0x647>
  100caa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cb1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100cb5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cbc:	8b 00                	mov    (%rax),%eax
  100cbe:	89 c0                	mov    %eax,%eax
  100cc0:	48 01 d0             	add    %rdx,%rax
  100cc3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cca:	8b 12                	mov    (%rdx),%edx
  100ccc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ccf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cd6:	89 0a                	mov    %ecx,(%rdx)
  100cd8:	eb 1a                	jmp    100cf4 <printer_vprintf+0x661>
  100cda:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ce1:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ce5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ce9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cf0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100cf4:	8b 00                	mov    (%rax),%eax
  100cf6:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100cfc:	e9 77 03 00 00       	jmp    101078 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100d01:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d05:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100d09:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d10:	8b 00                	mov    (%rax),%eax
  100d12:	83 f8 2f             	cmp    $0x2f,%eax
  100d15:	77 30                	ja     100d47 <printer_vprintf+0x6b4>
  100d17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d1e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d22:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d29:	8b 00                	mov    (%rax),%eax
  100d2b:	89 c0                	mov    %eax,%eax
  100d2d:	48 01 d0             	add    %rdx,%rax
  100d30:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d37:	8b 12                	mov    (%rdx),%edx
  100d39:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d3c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d43:	89 0a                	mov    %ecx,(%rdx)
  100d45:	eb 1a                	jmp    100d61 <printer_vprintf+0x6ce>
  100d47:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d4e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d52:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d56:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d5d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d61:	8b 00                	mov    (%rax),%eax
  100d63:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d66:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100d6a:	eb 45                	jmp    100db1 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100d6c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100d70:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100d74:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d7b:	0f b6 00             	movzbl (%rax),%eax
  100d7e:	84 c0                	test   %al,%al
  100d80:	74 0c                	je     100d8e <printer_vprintf+0x6fb>
  100d82:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d89:	0f b6 00             	movzbl (%rax),%eax
  100d8c:	eb 05                	jmp    100d93 <printer_vprintf+0x700>
  100d8e:	b8 25 00 00 00       	mov    $0x25,%eax
  100d93:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100d96:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100d9a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100da1:	0f b6 00             	movzbl (%rax),%eax
  100da4:	84 c0                	test   %al,%al
  100da6:	75 08                	jne    100db0 <printer_vprintf+0x71d>
                format--;
  100da8:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100daf:	01 
            }
            break;
  100db0:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100db1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100db4:	83 e0 20             	and    $0x20,%eax
  100db7:	85 c0                	test   %eax,%eax
  100db9:	74 1e                	je     100dd9 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100dbb:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100dbf:	48 83 c0 18          	add    $0x18,%rax
  100dc3:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100dc6:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100dca:	48 89 ce             	mov    %rcx,%rsi
  100dcd:	48 89 c7             	mov    %rax,%rdi
  100dd0:	e8 32 f8 ff ff       	call   100607 <fill_numbuf>
  100dd5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100dd9:	48 8d 05 86 06 00 00 	lea    0x686(%rip),%rax        # 101466 <flag_chars+0x6>
  100de0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100de4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100de7:	83 e0 20             	and    $0x20,%eax
  100dea:	85 c0                	test   %eax,%eax
  100dec:	74 51                	je     100e3f <printer_vprintf+0x7ac>
  100dee:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100df1:	83 e0 40             	and    $0x40,%eax
  100df4:	85 c0                	test   %eax,%eax
  100df6:	74 47                	je     100e3f <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100df8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100dfb:	25 80 00 00 00       	and    $0x80,%eax
  100e00:	85 c0                	test   %eax,%eax
  100e02:	74 0d                	je     100e11 <printer_vprintf+0x77e>
                prefix = "-";
  100e04:	48 8d 05 5c 06 00 00 	lea    0x65c(%rip),%rax        # 101467 <flag_chars+0x7>
  100e0b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e0f:	eb 7d                	jmp    100e8e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100e11:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e14:	83 e0 10             	and    $0x10,%eax
  100e17:	85 c0                	test   %eax,%eax
  100e19:	74 0d                	je     100e28 <printer_vprintf+0x795>
                prefix = "+";
  100e1b:	48 8d 05 47 06 00 00 	lea    0x647(%rip),%rax        # 101469 <flag_chars+0x9>
  100e22:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e26:	eb 66                	jmp    100e8e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100e28:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e2b:	83 e0 08             	and    $0x8,%eax
  100e2e:	85 c0                	test   %eax,%eax
  100e30:	74 5c                	je     100e8e <printer_vprintf+0x7fb>
                prefix = " ";
  100e32:	48 8d 05 32 06 00 00 	lea    0x632(%rip),%rax        # 10146b <flag_chars+0xb>
  100e39:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100e3d:	eb 4f                	jmp    100e8e <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100e3f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e42:	83 e0 20             	and    $0x20,%eax
  100e45:	85 c0                	test   %eax,%eax
  100e47:	74 46                	je     100e8f <printer_vprintf+0x7fc>
  100e49:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e4c:	83 e0 01             	and    $0x1,%eax
  100e4f:	85 c0                	test   %eax,%eax
  100e51:	74 3c                	je     100e8f <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100e53:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100e57:	74 06                	je     100e5f <printer_vprintf+0x7cc>
  100e59:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e5d:	75 30                	jne    100e8f <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100e5f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100e64:	75 0c                	jne    100e72 <printer_vprintf+0x7df>
  100e66:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e69:	25 00 01 00 00       	and    $0x100,%eax
  100e6e:	85 c0                	test   %eax,%eax
  100e70:	74 1d                	je     100e8f <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100e72:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100e76:	75 09                	jne    100e81 <printer_vprintf+0x7ee>
  100e78:	48 8d 05 ee 05 00 00 	lea    0x5ee(%rip),%rax        # 10146d <flag_chars+0xd>
  100e7f:	eb 07                	jmp    100e88 <printer_vprintf+0x7f5>
  100e81:	48 8d 05 e8 05 00 00 	lea    0x5e8(%rip),%rax        # 101470 <flag_chars+0x10>
  100e88:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100e8c:	eb 01                	jmp    100e8f <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100e8e:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100e8f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100e93:	78 24                	js     100eb9 <printer_vprintf+0x826>
  100e95:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100e98:	83 e0 20             	and    $0x20,%eax
  100e9b:	85 c0                	test   %eax,%eax
  100e9d:	75 1a                	jne    100eb9 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100e9f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100ea2:	48 63 d0             	movslq %eax,%rdx
  100ea5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ea9:	48 89 d6             	mov    %rdx,%rsi
  100eac:	48 89 c7             	mov    %rax,%rdi
  100eaf:	e8 91 f5 ff ff       	call   100445 <strnlen>
  100eb4:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100eb7:	eb 0f                	jmp    100ec8 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100eb9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100ebd:	48 89 c7             	mov    %rax,%rdi
  100ec0:	e8 4b f5 ff ff       	call   100410 <strlen>
  100ec5:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100ec8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ecb:	83 e0 20             	and    $0x20,%eax
  100ece:	85 c0                	test   %eax,%eax
  100ed0:	74 20                	je     100ef2 <printer_vprintf+0x85f>
  100ed2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ed6:	78 1a                	js     100ef2 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100ed8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100edb:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100ede:	7e 08                	jle    100ee8 <printer_vprintf+0x855>
  100ee0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100ee3:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100ee6:	eb 05                	jmp    100eed <printer_vprintf+0x85a>
  100ee8:	b8 00 00 00 00       	mov    $0x0,%eax
  100eed:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100ef0:	eb 5c                	jmp    100f4e <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100ef2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ef5:	83 e0 20             	and    $0x20,%eax
  100ef8:	85 c0                	test   %eax,%eax
  100efa:	74 4b                	je     100f47 <printer_vprintf+0x8b4>
  100efc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100eff:	83 e0 02             	and    $0x2,%eax
  100f02:	85 c0                	test   %eax,%eax
  100f04:	74 41                	je     100f47 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100f06:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f09:	83 e0 04             	and    $0x4,%eax
  100f0c:	85 c0                	test   %eax,%eax
  100f0e:	75 37                	jne    100f47 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100f10:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f14:	48 89 c7             	mov    %rax,%rdi
  100f17:	e8 f4 f4 ff ff       	call   100410 <strlen>
  100f1c:	89 c2                	mov    %eax,%edx
  100f1e:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100f21:	01 d0                	add    %edx,%eax
  100f23:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100f26:	7e 1f                	jle    100f47 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100f28:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f2b:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100f2e:	89 c3                	mov    %eax,%ebx
  100f30:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f34:	48 89 c7             	mov    %rax,%rdi
  100f37:	e8 d4 f4 ff ff       	call   100410 <strlen>
  100f3c:	89 c2                	mov    %eax,%edx
  100f3e:	89 d8                	mov    %ebx,%eax
  100f40:	29 d0                	sub    %edx,%eax
  100f42:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100f45:	eb 07                	jmp    100f4e <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100f47:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100f4e:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100f51:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100f54:	01 d0                	add    %edx,%eax
  100f56:	48 63 d8             	movslq %eax,%rbx
  100f59:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100f5d:	48 89 c7             	mov    %rax,%rdi
  100f60:	e8 ab f4 ff ff       	call   100410 <strlen>
  100f65:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100f69:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100f6c:	29 d0                	sub    %edx,%eax
  100f6e:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f71:	eb 25                	jmp    100f98 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  100f73:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f7a:	48 8b 08             	mov    (%rax),%rcx
  100f7d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100f83:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100f8a:	be 20 00 00 00       	mov    $0x20,%esi
  100f8f:	48 89 c7             	mov    %rax,%rdi
  100f92:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100f94:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100f98:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100f9b:	83 e0 04             	and    $0x4,%eax
  100f9e:	85 c0                	test   %eax,%eax
  100fa0:	75 36                	jne    100fd8 <printer_vprintf+0x945>
  100fa2:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100fa6:	7f cb                	jg     100f73 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  100fa8:	eb 2e                	jmp    100fd8 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  100faa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fb1:	4c 8b 00             	mov    (%rax),%r8
  100fb4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fb8:	0f b6 00             	movzbl (%rax),%eax
  100fbb:	0f b6 c8             	movzbl %al,%ecx
  100fbe:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100fc4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fcb:	89 ce                	mov    %ecx,%esi
  100fcd:	48 89 c7             	mov    %rax,%rdi
  100fd0:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100fd3:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100fd8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100fdc:	0f b6 00             	movzbl (%rax),%eax
  100fdf:	84 c0                	test   %al,%al
  100fe1:	75 c7                	jne    100faa <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  100fe3:	eb 25                	jmp    10100a <printer_vprintf+0x977>
            p->putc(p, '0', color);
  100fe5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100fec:	48 8b 08             	mov    (%rax),%rcx
  100fef:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100ff5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ffc:	be 30 00 00 00       	mov    $0x30,%esi
  101001:	48 89 c7             	mov    %rax,%rdi
  101004:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101006:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  10100a:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  10100e:	7f d5                	jg     100fe5 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  101010:	eb 32                	jmp    101044 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  101012:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101019:	4c 8b 00             	mov    (%rax),%r8
  10101c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101020:	0f b6 00             	movzbl (%rax),%eax
  101023:	0f b6 c8             	movzbl %al,%ecx
  101026:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10102c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101033:	89 ce                	mov    %ecx,%esi
  101035:	48 89 c7             	mov    %rax,%rdi
  101038:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  10103b:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101040:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101044:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101048:	7f c8                	jg     101012 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  10104a:	eb 25                	jmp    101071 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  10104c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101053:	48 8b 08             	mov    (%rax),%rcx
  101056:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10105c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101063:	be 20 00 00 00       	mov    $0x20,%esi
  101068:	48 89 c7             	mov    %rax,%rdi
  10106b:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  10106d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101071:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101075:	7f d5                	jg     10104c <printer_vprintf+0x9b9>
        }
    done: ;
  101077:	90                   	nop
    for (; *format; ++format) {
  101078:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10107f:	01 
  101080:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101087:	0f b6 00             	movzbl (%rax),%eax
  10108a:	84 c0                	test   %al,%al
  10108c:	0f 85 31 f6 ff ff    	jne    1006c3 <printer_vprintf+0x30>
    }
}
  101092:	90                   	nop
  101093:	90                   	nop
  101094:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101098:	c9                   	leave  
  101099:	c3                   	ret    

000000000010109a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  10109a:	f3 0f 1e fa          	endbr64 
  10109e:	55                   	push   %rbp
  10109f:	48 89 e5             	mov    %rsp,%rbp
  1010a2:	48 83 ec 20          	sub    $0x20,%rsp
  1010a6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1010aa:	89 f0                	mov    %esi,%eax
  1010ac:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1010af:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1010b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1010b6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1010ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010be:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010c2:	48 8d 15 d7 7e fb ff 	lea    -0x48129(%rip),%rdx        # b8fa0 <console+0xfa0>
  1010c9:	48 39 d0             	cmp    %rdx,%rax
  1010cc:	72 0f                	jb     1010dd <console_putc+0x43>
        cp->cursor = console;
  1010ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010d2:	48 8d 15 27 6f fb ff 	lea    -0x490d9(%rip),%rdx        # b8000 <console>
  1010d9:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  1010dd:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1010e1:	0f 85 82 00 00 00    	jne    101169 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  1010e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010eb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010ef:	48 8d 15 0a 6f fb ff 	lea    -0x490f6(%rip),%rdx        # b8000 <console>
  1010f6:	48 29 d0             	sub    %rdx,%rax
  1010f9:	48 d1 f8             	sar    %rax
  1010fc:	48 89 c1             	mov    %rax,%rcx
  1010ff:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101106:	66 66 66 
  101109:	48 89 c8             	mov    %rcx,%rax
  10110c:	48 f7 ea             	imul   %rdx
  10110f:	48 89 d0             	mov    %rdx,%rax
  101112:	48 c1 f8 05          	sar    $0x5,%rax
  101116:	48 89 ce             	mov    %rcx,%rsi
  101119:	48 c1 fe 3f          	sar    $0x3f,%rsi
  10111d:	48 29 f0             	sub    %rsi,%rax
  101120:	48 89 c2             	mov    %rax,%rdx
  101123:	48 89 d0             	mov    %rdx,%rax
  101126:	48 c1 e0 02          	shl    $0x2,%rax
  10112a:	48 01 d0             	add    %rdx,%rax
  10112d:	48 c1 e0 04          	shl    $0x4,%rax
  101131:	48 29 c1             	sub    %rax,%rcx
  101134:	48 89 ca             	mov    %rcx,%rdx
  101137:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  10113a:	eb 25                	jmp    101161 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  10113c:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10113f:	83 c8 20             	or     $0x20,%eax
  101142:	89 c6                	mov    %eax,%esi
  101144:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101148:	48 8b 40 08          	mov    0x8(%rax),%rax
  10114c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101150:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101154:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101158:	89 f2                	mov    %esi,%edx
  10115a:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10115d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101161:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101165:	75 d5                	jne    10113c <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101167:	eb 24                	jmp    10118d <console_putc+0xf3>
        *cp->cursor++ = c | color;
  101169:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  10116d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101170:	89 d6                	mov    %edx,%esi
  101172:	09 c6                	or     %eax,%esi
  101174:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101178:	48 8b 40 08          	mov    0x8(%rax),%rax
  10117c:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101180:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101184:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101188:	89 f2                	mov    %esi,%edx
  10118a:	66 89 10             	mov    %dx,(%rax)
}
  10118d:	90                   	nop
  10118e:	c9                   	leave  
  10118f:	c3                   	ret    

0000000000101190 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101190:	f3 0f 1e fa          	endbr64 
  101194:	55                   	push   %rbp
  101195:	48 89 e5             	mov    %rsp,%rbp
  101198:	48 83 ec 30          	sub    $0x30,%rsp
  10119c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10119f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1011a2:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1011a6:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1011aa:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 10109a <console_putc>
  1011b1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1011b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1011b9:	78 09                	js     1011c4 <console_vprintf+0x34>
  1011bb:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1011c2:	7e 07                	jle    1011cb <console_vprintf+0x3b>
        cpos = 0;
  1011c4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1011cb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011ce:	48 98                	cltq   
  1011d0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1011d4:	48 8d 05 25 6e fb ff 	lea    -0x491db(%rip),%rax        # b8000 <console>
  1011db:	48 01 d0             	add    %rdx,%rax
  1011de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1011e2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1011e6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1011ea:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1011ed:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1011f1:	48 89 c7             	mov    %rax,%rdi
  1011f4:	e8 9a f4 ff ff       	call   100693 <printer_vprintf>
    return cp.cursor - console;
  1011f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011fd:	48 8d 15 fc 6d fb ff 	lea    -0x49204(%rip),%rdx        # b8000 <console>
  101204:	48 29 d0             	sub    %rdx,%rax
  101207:	48 d1 f8             	sar    %rax
}
  10120a:	c9                   	leave  
  10120b:	c3                   	ret    

000000000010120c <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10120c:	f3 0f 1e fa          	endbr64 
  101210:	55                   	push   %rbp
  101211:	48 89 e5             	mov    %rsp,%rbp
  101214:	48 83 ec 60          	sub    $0x60,%rsp
  101218:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10121b:	89 75 a8             	mov    %esi,-0x58(%rbp)
  10121e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101222:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101226:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10122a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10122e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101235:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101239:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10123d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101241:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101245:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101249:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10124d:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101250:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101253:	89 c7                	mov    %eax,%edi
  101255:	e8 36 ff ff ff       	call   101190 <console_vprintf>
  10125a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10125d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101260:	c9                   	leave  
  101261:	c3                   	ret    

0000000000101262 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101262:	f3 0f 1e fa          	endbr64 
  101266:	55                   	push   %rbp
  101267:	48 89 e5             	mov    %rsp,%rbp
  10126a:	48 83 ec 20          	sub    $0x20,%rsp
  10126e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101272:	89 f0                	mov    %esi,%eax
  101274:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101277:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10127a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10127e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101282:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101286:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10128a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10128e:	48 8b 40 10          	mov    0x10(%rax),%rax
  101292:	48 39 c2             	cmp    %rax,%rdx
  101295:	73 1a                	jae    1012b1 <string_putc+0x4f>
        *sp->s++ = c;
  101297:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10129b:	48 8b 40 08          	mov    0x8(%rax),%rax
  10129f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1012a3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1012a7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012ab:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1012af:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1012b1:	90                   	nop
  1012b2:	c9                   	leave  
  1012b3:	c3                   	ret    

00000000001012b4 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1012b4:	f3 0f 1e fa          	endbr64 
  1012b8:	55                   	push   %rbp
  1012b9:	48 89 e5             	mov    %rsp,%rbp
  1012bc:	48 83 ec 40          	sub    $0x40,%rsp
  1012c0:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1012c4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1012c8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1012cc:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1012d0:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 101262 <string_putc>
  1012d7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  1012db:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1012df:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1012e3:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1012e8:	74 33                	je     10131d <vsnprintf+0x69>
        sp.end = s + size - 1;
  1012ea:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1012ee:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1012f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1012f6:	48 01 d0             	add    %rdx,%rax
  1012f9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1012fd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101301:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101305:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101309:	be 00 00 00 00       	mov    $0x0,%esi
  10130e:	48 89 c7             	mov    %rax,%rdi
  101311:	e8 7d f3 ff ff       	call   100693 <printer_vprintf>
        *sp.s = 0;
  101316:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10131a:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10131d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101321:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101325:	c9                   	leave  
  101326:	c3                   	ret    

0000000000101327 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101327:	f3 0f 1e fa          	endbr64 
  10132b:	55                   	push   %rbp
  10132c:	48 89 e5             	mov    %rsp,%rbp
  10132f:	48 83 ec 70          	sub    $0x70,%rsp
  101333:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101337:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10133b:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  10133f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101343:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101347:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10134b:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101352:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101356:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10135a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10135e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101362:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101366:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10136a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10136e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101372:	48 89 c7             	mov    %rax,%rdi
  101375:	e8 3a ff ff ff       	call   1012b4 <vsnprintf>
  10137a:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10137d:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101380:	c9                   	leave  
  101381:	c3                   	ret    

0000000000101382 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101382:	f3 0f 1e fa          	endbr64 
  101386:	55                   	push   %rbp
  101387:	48 89 e5             	mov    %rsp,%rbp
  10138a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10138e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101395:	eb 1a                	jmp    1013b1 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101397:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10139a:	48 98                	cltq   
  10139c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1013a0:	48 8d 05 59 6c fb ff 	lea    -0x493a7(%rip),%rax        # b8000 <console>
  1013a7:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1013ad:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1013b1:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1013b8:	7e dd                	jle    101397 <console_clear+0x15>
    }
    cursorpos = 0;
  1013ba:	c7 05 38 7c fb ff 00 	movl   $0x0,-0x483c8(%rip)        # b8ffc <cursorpos>
  1013c1:	00 00 00 
}
  1013c4:	90                   	nop
  1013c5:	c9                   	leave  
  1013c6:	c3                   	ret    
