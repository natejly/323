
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:

uint8_t *heap_top;
uint8_t *heap_bottom;
uint8_t *stack_bottom;

void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	41 54                	push   %r12
  10000a:	53                   	push   %rbx
  10000b:	48 83 ec 60          	sub    $0x60,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000f:	cd 31                	int    $0x31
  100011:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  100013:	e8 6e 0f 00 00       	call   100f86 <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100018:	48 8d 05 30 30 00 00 	lea    0x3030(%rip),%rax        # 10304f <end+0xfff>
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

    malloc(10);
  100047:	bf 0a 00 00 00       	mov    $0xa,%edi
  10004c:	e8 bd 05 00 00       	call   10060e <malloc>
    void* ptr2 = malloc(200);
  100051:	bf c8 00 00 00       	mov    $0xc8,%edi
  100056:	e8 b3 05 00 00       	call   10060e <malloc>
  10005b:	48 89 c3             	mov    %rax,%rbx


    heap_info_struct h1, h2, h3;
    heap_info(&h1);
  10005e:	48 8d 7d d0          	lea    -0x30(%rbp),%rdi
  100062:	e8 5e 07 00 00       	call   1007c5 <heap_info>


    void* ptr = malloc(16384);
  100067:	bf 00 40 00 00       	mov    $0x4000,%edi
  10006c:	e8 9d 05 00 00       	call   10060e <malloc>
  100071:	49 89 c4             	mov    %rax,%r12
    malloc(10);
  100074:	bf 0a 00 00 00       	mov    $0xa,%edi
  100079:	e8 90 05 00 00       	call   10060e <malloc>
    malloc(10);
  10007e:	bf 0a 00 00 00       	mov    $0xa,%edi
  100083:	e8 86 05 00 00       	call   10060e <malloc>

    heap_info(&h2);
  100088:	48 8d 7d b0          	lea    -0x50(%rbp),%rdi
  10008c:	e8 34 07 00 00       	call   1007c5 <heap_info>

    free(ptr);
  100091:	4c 89 e7             	mov    %r12,%rdi
  100094:	e8 5c 06 00 00       	call   1006f5 <free>
    free(ptr2);  // free ptr2 after ptr to allow explicit freelists with first fit strategies
  100099:	48 89 df             	mov    %rbx,%rdi
  10009c:	e8 54 06 00 00       	call   1006f5 <free>

    heap_info(&h3);
  1000a1:	48 8d 7d 90          	lea    -0x70(%rbp),%rdi
  1000a5:	e8 1b 07 00 00       	call   1007c5 <heap_info>

    assert(h1.size_array != NULL);
  1000aa:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
  1000ae:	48 85 ff             	test   %rdi,%rdi
  1000b1:	74 46                	je     1000f9 <process_main+0xf9>
    assert(h2.size_array != NULL);
  1000b3:	48 83 7d b8 00       	cmpq   $0x0,-0x48(%rbp)
  1000b8:	74 57                	je     100111 <process_main+0x111>
    assert(h1.ptr_array != NULL);
  1000ba:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1000bf:	74 68                	je     100129 <process_main+0x129>
    assert(h2.ptr_array != NULL);
  1000c1:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
  1000c6:	74 79                	je     100141 <process_main+0x141>


    assert(h3.free_space > h2.free_space);
  1000c8:	8b 45 c8             	mov    -0x38(%rbp),%eax
  1000cb:	39 45 a8             	cmp    %eax,-0x58(%rbp)
  1000ce:	0f 8e 85 00 00 00    	jle    100159 <process_main+0x159>
    assert(h3.largest_free_chunk >= 16384);
  1000d4:	81 7d ac ff 3f 00 00 	cmpl   $0x3fff,-0x54(%rbp)
  1000db:	0f 8f 90 00 00 00    	jg     100171 <process_main+0x171>
  1000e1:	48 8d 15 40 1d 00 00 	lea    0x1d40(%rip),%rdx        # 101e28 <console_clear+0x102>
  1000e8:	be 2b 00 00 00       	mov    $0x2b,%esi
  1000ed:	48 8d 3d 92 1c 00 00 	lea    0x1c92(%rip),%rdi        # 101d86 <console_clear+0x60>
  1000f4:	e8 2f 02 00 00       	call   100328 <assert_fail>
    assert(h1.size_array != NULL);
  1000f9:	48 8d 15 70 1c 00 00 	lea    0x1c70(%rip),%rdx        # 101d70 <console_clear+0x4a>
  100100:	be 24 00 00 00       	mov    $0x24,%esi
  100105:	48 8d 3d 7a 1c 00 00 	lea    0x1c7a(%rip),%rdi        # 101d86 <console_clear+0x60>
  10010c:	e8 17 02 00 00       	call   100328 <assert_fail>
    assert(h2.size_array != NULL);
  100111:	48 8d 15 7e 1c 00 00 	lea    0x1c7e(%rip),%rdx        # 101d96 <console_clear+0x70>
  100118:	be 25 00 00 00       	mov    $0x25,%esi
  10011d:	48 8d 3d 62 1c 00 00 	lea    0x1c62(%rip),%rdi        # 101d86 <console_clear+0x60>
  100124:	e8 ff 01 00 00       	call   100328 <assert_fail>
    assert(h1.ptr_array != NULL);
  100129:	48 8d 15 7c 1c 00 00 	lea    0x1c7c(%rip),%rdx        # 101dac <console_clear+0x86>
  100130:	be 26 00 00 00       	mov    $0x26,%esi
  100135:	48 8d 3d 4a 1c 00 00 	lea    0x1c4a(%rip),%rdi        # 101d86 <console_clear+0x60>
  10013c:	e8 e7 01 00 00       	call   100328 <assert_fail>
    assert(h2.ptr_array != NULL);
  100141:	48 8d 15 79 1c 00 00 	lea    0x1c79(%rip),%rdx        # 101dc1 <console_clear+0x9b>
  100148:	be 27 00 00 00       	mov    $0x27,%esi
  10014d:	48 8d 3d 32 1c 00 00 	lea    0x1c32(%rip),%rdi        # 101d86 <console_clear+0x60>
  100154:	e8 cf 01 00 00       	call   100328 <assert_fail>
    assert(h3.free_space > h2.free_space);
  100159:	48 8d 15 76 1c 00 00 	lea    0x1c76(%rip),%rdx        # 101dd6 <console_clear+0xb0>
  100160:	be 2a 00 00 00       	mov    $0x2a,%esi
  100165:	48 8d 3d 1a 1c 00 00 	lea    0x1c1a(%rip),%rdi        # 101d86 <console_clear+0x60>
  10016c:	e8 b7 01 00 00       	call   100328 <assert_fail>


    free(h1.size_array);
  100171:	e8 7f 05 00 00       	call   1006f5 <free>
    free(h2.size_array);
  100176:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
  10017a:	e8 76 05 00 00       	call   1006f5 <free>

    free(h1.ptr_array);
  10017f:	48 8b 7d e0          	mov    -0x20(%rbp),%rdi
  100183:	e8 6d 05 00 00       	call   1006f5 <free>
    free(h2.ptr_array);
  100188:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
  10018c:	e8 64 05 00 00       	call   1006f5 <free>

    app_printf(0, "HEAP FREE SPACE PASS\n");
  100191:	48 8d 35 5c 1c 00 00 	lea    0x1c5c(%rip),%rsi        # 101df4 <console_clear+0xce>
  100198:	bf 00 00 00 00       	mov    $0x0,%edi
  10019d:	b8 00 00 00 00       	mov    $0x0,%eax
  1001a2:	e8 11 00 00 00       	call   1001b8 <app_printf>
    TEST_PASS();
  1001a7:	48 8d 3d 5c 1c 00 00 	lea    0x1c5c(%rip),%rdi        # 101e0a <console_clear+0xe4>
  1001ae:	b8 00 00 00 00       	mov    $0x0,%eax
  1001b3:	e8 98 00 00 00       	call   100250 <kernel_panic>

00000000001001b8 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1001b8:	f3 0f 1e fa          	endbr64 
  1001bc:	55                   	push   %rbp
  1001bd:	48 89 e5             	mov    %rsp,%rbp
  1001c0:	48 83 ec 50          	sub    $0x50,%rsp
  1001c4:	49 89 f2             	mov    %rsi,%r10
  1001c7:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1001cb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1001cf:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1001d3:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1001d7:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  1001dc:	85 ff                	test   %edi,%edi
  1001de:	78 32                	js     100212 <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1001e0:	48 63 ff             	movslq %edi,%rdi
  1001e3:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1001ea:	cc cc cc 
  1001ed:	48 89 f8             	mov    %rdi,%rax
  1001f0:	48 f7 e2             	mul    %rdx
  1001f3:	48 89 d0             	mov    %rdx,%rax
  1001f6:	48 c1 e8 02          	shr    $0x2,%rax
  1001fa:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1001fe:	48 01 c2             	add    %rax,%rdx
  100201:	48 29 d7             	sub    %rdx,%rdi
  100204:	48 8d 05 72 1c 00 00 	lea    0x1c72(%rip),%rax        # 101e7d <col.0>
  10020b:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  10020f:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100212:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100219:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10021d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100221:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100225:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100229:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10022d:	4c 89 d2             	mov    %r10,%rdx
  100230:	8b 3d c6 8d fb ff    	mov    -0x4723a(%rip),%edi        # b8ffc <cursorpos>
  100236:	e8 f9 18 00 00       	call   101b34 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  10023b:	3d 30 07 00 00       	cmp    $0x730,%eax
  100240:	ba 00 00 00 00       	mov    $0x0,%edx
  100245:	0f 4d c2             	cmovge %edx,%eax
  100248:	89 05 ae 8d fb ff    	mov    %eax,-0x47252(%rip)        # b8ffc <cursorpos>
    }
}
  10024e:	c9                   	leave  
  10024f:	c3                   	ret    

0000000000100250 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  100250:	f3 0f 1e fa          	endbr64 
  100254:	55                   	push   %rbp
  100255:	48 89 e5             	mov    %rsp,%rbp
  100258:	53                   	push   %rbx
  100259:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100260:	48 89 fb             	mov    %rdi,%rbx
  100263:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100267:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10026b:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  10026f:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100273:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100277:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  10027e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100282:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100286:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  10028a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  10028e:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100295:	ba 07 00 00 00       	mov    $0x7,%edx
  10029a:	48 8d 35 a6 1b 00 00 	lea    0x1ba6(%rip),%rsi        # 101e47 <console_clear+0x121>
  1002a1:	e8 c5 09 00 00       	call   100c6b <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  1002a6:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  1002aa:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  1002b1:	48 89 da             	mov    %rbx,%rdx
  1002b4:	be 99 00 00 00       	mov    $0x99,%esi
  1002b9:	e8 9a 19 00 00       	call   101c58 <vsnprintf>
  1002be:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  1002c1:	85 d2                	test   %edx,%edx
  1002c3:	7e 0f                	jle    1002d4 <kernel_panic+0x84>
  1002c5:	83 c0 06             	add    $0x6,%eax
  1002c8:	48 98                	cltq   
  1002ca:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1002d1:	0a 
  1002d2:	75 2c                	jne    100300 <kernel_panic+0xb0>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1002d4:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1002db:	48 89 d9             	mov    %rbx,%rcx
  1002de:	48 8d 15 6a 1b 00 00 	lea    0x1b6a(%rip),%rdx        # 101e4f <console_clear+0x129>
  1002e5:	be 00 c0 00 00       	mov    $0xc000,%esi
  1002ea:	bf 30 07 00 00       	mov    $0x730,%edi
  1002ef:	b8 00 00 00 00       	mov    $0x0,%eax
  1002f4:	e8 b7 18 00 00       	call   101bb0 <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  1002f9:	48 89 df             	mov    %rbx,%rdi
  1002fc:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  1002fe:	eb fe                	jmp    1002fe <kernel_panic+0xae>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100300:	48 63 c2             	movslq %edx,%rax
  100303:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100309:	0f 94 c2             	sete   %dl
  10030c:	0f b6 d2             	movzbl %dl,%edx
  10030f:	48 29 d0             	sub    %rdx,%rax
  100312:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100319:	ff 
  10031a:	48 8d 35 e7 1a 00 00 	lea    0x1ae7(%rip),%rsi        # 101e08 <console_clear+0xe2>
  100321:	e8 06 0b 00 00       	call   100e2c <strcpy>
  100326:	eb ac                	jmp    1002d4 <kernel_panic+0x84>

0000000000100328 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100328:	f3 0f 1e fa          	endbr64 
  10032c:	55                   	push   %rbp
  10032d:	48 89 e5             	mov    %rsp,%rbp
  100330:	48 89 f9             	mov    %rdi,%rcx
  100333:	41 89 f0             	mov    %esi,%r8d
  100336:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100339:	48 8d 15 18 1b 00 00 	lea    0x1b18(%rip),%rdx        # 101e58 <console_clear+0x132>
  100340:	be 00 c0 00 00       	mov    $0xc000,%esi
  100345:	bf 30 07 00 00       	mov    $0x730,%edi
  10034a:	b8 00 00 00 00       	mov    $0x0,%eax
  10034f:	e8 5c 18 00 00       	call   101bb0 <console_printf>
    asm volatile ("int %0" : /* no result */
  100354:	bf 00 00 00 00       	mov    $0x0,%edi
  100359:	cd 30                	int    $0x30
 loop: goto loop;
  10035b:	eb fe                	jmp    10035b <assert_fail+0x33>

000000000010035d <algn>:
block* split_block(block* block, size_t size);
void add_to_free_list(block *b);
void remove_from_free_list(block *b);
void heap_init();

size_t algn(size_t size){
  10035d:	f3 0f 1e fa          	endbr64 
    return (size + 7) / 8 * 8;
  100361:	48 8d 47 07          	lea    0x7(%rdi),%rax
  100365:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
}
  100369:	c3                   	ret    

000000000010036a <new_block>:

block* new_block(size_t size){
  10036a:	f3 0f 1e fa          	endbr64 
  10036e:	48 89 fa             	mov    %rdi,%rdx
    void *bptr = sbrk(size + BLOCKSIZE);
  100371:	48 8d 7f 28          	lea    0x28(%rdi),%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100375:	cd 3a                	int    $0x3a
  100377:	48 89 05 ba 1c 00 00 	mov    %rax,0x1cba(%rip)        # 102038 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  10037e:	48 89 c1             	mov    %rax,%rcx
    if (bptr == (void*) -1) {
  100381:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100385:	74 26                	je     1003ad <new_block+0x43>
        return NULL;
    }
    block* nblock = (block*)bptr;
    nblock->next = NULL;
  100387:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  10038e:	00 
    nblock->size = size;
  10038f:	48 89 10             	mov    %rdx,(%rax)
    nblock->free = 0;
  100392:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
    nblock->free_next = NULL;
  100399:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  1003a0:	00 
    nblock->free_prev = NULL;
  1003a1:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
  1003a8:	00 
    return nblock;
}
  1003a9:	48 89 c8             	mov    %rcx,%rax
  1003ac:	c3                   	ret    
        return NULL;
  1003ad:	b9 00 00 00 00       	mov    $0x0,%ecx
  1003b2:	eb f5                	jmp    1003a9 <new_block+0x3f>

00000000001003b4 <find_block>:

block* find_block(size_t size) {
  1003b4:	f3 0f 1e fa          	endbr64 
    block* curr = free_head;
  1003b8:	48 8b 05 81 1c 00 00 	mov    0x1c81(%rip),%rax        # 102040 <free_head>
    while (curr) {
  1003bf:	48 85 c0             	test   %rax,%rax
  1003c2:	74 0e                	je     1003d2 <find_block+0x1e>
        if (curr->size >= size) {
  1003c4:	48 39 38             	cmp    %rdi,(%rax)
  1003c7:	73 09                	jae    1003d2 <find_block+0x1e>
            return curr;
        }
        curr = curr->free_next;
  1003c9:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (curr) {
  1003cd:	48 85 c0             	test   %rax,%rax
  1003d0:	75 f2                	jne    1003c4 <find_block+0x10>
    }
    return NULL;
}
  1003d2:	c3                   	ret    

00000000001003d3 <add_to_free_list>:

    add_to_free_list(new);
    return new;
}

void add_to_free_list(block *b) {
  1003d3:	f3 0f 1e fa          	endbr64 
    b->free = 1;
  1003d7:	c7 47 10 01 00 00 00 	movl   $0x1,0x10(%rdi)
    b->free_next = free_head;
  1003de:	48 8b 05 5b 1c 00 00 	mov    0x1c5b(%rip),%rax        # 102040 <free_head>
  1003e5:	48 89 47 18          	mov    %rax,0x18(%rdi)
    b->free_prev = NULL;
  1003e9:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  1003f0:	00 
    if (free_head) {
  1003f1:	48 85 c0             	test   %rax,%rax
  1003f4:	74 04                	je     1003fa <add_to_free_list+0x27>
        free_head->free_prev = b;
  1003f6:	48 89 78 20          	mov    %rdi,0x20(%rax)
    }
    free_head = b;
  1003fa:	48 89 3d 3f 1c 00 00 	mov    %rdi,0x1c3f(%rip)        # 102040 <free_head>
}
  100401:	c3                   	ret    

0000000000100402 <split_block>:
block* split_block(block* b, size_t size){
  100402:	f3 0f 1e fa          	endbr64 
  100406:	55                   	push   %rbp
  100407:	48 89 e5             	mov    %rsp,%rbp
  10040a:	53                   	push   %rbx
  10040b:	48 83 ec 08          	sub    $0x8,%rsp
    if (b->size < size + BLOCKSIZE) {
  10040f:	48 8b 07             	mov    (%rdi),%rax
  100412:	48 8d 56 28          	lea    0x28(%rsi),%rdx
        return NULL;
  100416:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (b->size < size + BLOCKSIZE) {
  10041b:	48 39 d0             	cmp    %rdx,%rax
  10041e:	72 30                	jb     100450 <split_block+0x4e>
    void* nptr = (void*)b + BLOCKSIZE + size;
  100420:	48 8d 1c 17          	lea    (%rdi,%rdx,1),%rbx
    new->size = b->size - size - BLOCKSIZE;
  100424:	48 29 f0             	sub    %rsi,%rax
  100427:	48 8d 40 d8          	lea    -0x28(%rax),%rax
  10042b:	48 89 03             	mov    %rax,(%rbx)
    new->free = 1;
  10042e:	c7 43 10 01 00 00 00 	movl   $0x1,0x10(%rbx)
    new->free_next = NULL;
  100435:	48 c7 43 18 00 00 00 	movq   $0x0,0x18(%rbx)
  10043c:	00 
    new->free_prev = NULL;
  10043d:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  100444:	00 
    b->size = size;
  100445:	48 89 37             	mov    %rsi,(%rdi)
    add_to_free_list(new);
  100448:	48 89 df             	mov    %rbx,%rdi
  10044b:	e8 83 ff ff ff       	call   1003d3 <add_to_free_list>
}
  100450:	48 89 d8             	mov    %rbx,%rax
  100453:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100457:	c9                   	leave  
  100458:	c3                   	ret    

0000000000100459 <remove_from_free_list>:

void remove_from_free_list(block *b) {
  100459:	f3 0f 1e fa          	endbr64 
    if (b->free_prev) {
  10045d:	48 8b 47 20          	mov    0x20(%rdi),%rax
  100461:	48 85 c0             	test   %rax,%rax
  100464:	74 31                	je     100497 <remove_from_free_list+0x3e>
        b->free_prev->free_next = b->free_next;
  100466:	48 8b 57 18          	mov    0x18(%rdi),%rdx
  10046a:	48 89 50 18          	mov    %rdx,0x18(%rax)
    } else {
        free_head = b->free_next;
    }
    if (b->free_next) {
  10046e:	48 8b 47 18          	mov    0x18(%rdi),%rax
  100472:	48 85 c0             	test   %rax,%rax
  100475:	74 08                	je     10047f <remove_from_free_list+0x26>
        b->free_next->free_prev = b->free_prev;
  100477:	48 8b 57 20          	mov    0x20(%rdi),%rdx
  10047b:	48 89 50 20          	mov    %rdx,0x20(%rax)
    }
    b->free = 0;
  10047f:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->free_next = NULL;
  100486:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  10048d:	00 
    b->free_prev = NULL;
  10048e:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  100495:	00 
}
  100496:	c3                   	ret    
        free_head = b->free_next;
  100497:	48 8b 47 18          	mov    0x18(%rdi),%rax
  10049b:	48 89 05 9e 1b 00 00 	mov    %rax,0x1b9e(%rip)        # 102040 <free_head>
  1004a2:	eb ca                	jmp    10046e <remove_from_free_list+0x15>

00000000001004a4 <update_largest_free_chunk>:
void update_largest_free_chunk() {
  1004a4:	f3 0f 1e fa          	endbr64 
    largest_free_chunk = 0; // Reset the value
  1004a8:	c7 05 66 1b 00 00 00 	movl   $0x0,0x1b66(%rip)        # 102018 <largest_free_chunk>
  1004af:	00 00 00 
    block *b = free_head;
  1004b2:	48 8b 05 87 1b 00 00 	mov    0x1b87(%rip),%rax        # 102040 <free_head>
    int size;
    // Traverse the free list to find the largest free chunk
    while (b) {
  1004b9:	48 85 c0             	test   %rax,%rax
  1004bc:	75 0a                	jne    1004c8 <update_largest_free_chunk+0x24>
        if (size > largest_free_chunk) {
            largest_free_chunk = size;
        }
        b = b->free_next;
    }
}
  1004be:	c3                   	ret    
        b = b->free_next;
  1004bf:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (b) {
  1004c3:	48 85 c0             	test   %rax,%rax
  1004c6:	74 f6                	je     1004be <update_largest_free_chunk+0x1a>
        size = (int)b->size;
  1004c8:	48 8b 10             	mov    (%rax),%rdx
        if (size > largest_free_chunk) {
  1004cb:	39 15 47 1b 00 00    	cmp    %edx,0x1b47(%rip)        # 102018 <largest_free_chunk>
  1004d1:	7d ec                	jge    1004bf <update_largest_free_chunk+0x1b>
            largest_free_chunk = size;
  1004d3:	89 15 3f 1b 00 00    	mov    %edx,0x1b3f(%rip)        # 102018 <largest_free_chunk>
  1004d9:	eb e4                	jmp    1004bf <update_largest_free_chunk+0x1b>

00000000001004db <heap_init>:
    }
    update_free_space();         // Update free space
    update_largest_free_chunk(); // Update largest free chunk

}
void heap_init() {
  1004db:	f3 0f 1e fa          	endbr64 
    asm volatile ("int %1" :  "=a" (result)
  1004df:	bf 20 03 00 00       	mov    $0x320,%edi
  1004e4:	cd 3a                	int    $0x3a
  1004e6:	48 89 05 4b 1b 00 00 	mov    %rax,0x1b4b(%rip)        # 102038 <result.0>
    size_array = (long*) sbrk(sizeof(long) * ARRAY_SIZE);
  1004ed:	48 89 05 34 1b 00 00 	mov    %rax,0x1b34(%rip)        # 102028 <size_array>
  1004f4:	cd 3a                	int    $0x3a
  1004f6:	48 89 05 3b 1b 00 00 	mov    %rax,0x1b3b(%rip)        # 102038 <result.0>
    ptr_array = (void**) sbrk(sizeof(void*) * ARRAY_SIZE);
  1004fd:	48 89 05 1c 1b 00 00 	mov    %rax,0x1b1c(%rip)        # 102020 <ptr_array>
    if (size_array == (void*)-1 || ptr_array == (void*)-1) {
  100504:	48 83 3d 1c 1b 00 00 	cmpq   $0xffffffffffffffff,0x1b1c(%rip)        # 102028 <size_array>
  10050b:	ff 
  10050c:	74 06                	je     100514 <heap_init+0x39>
  10050e:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100512:	75 16                	jne    10052a <heap_init+0x4f>
        // Handle sbrk failure
        size_array = NULL;
  100514:	48 c7 05 09 1b 00 00 	movq   $0x0,0x1b09(%rip)        # 102028 <size_array>
  10051b:	00 00 00 00 
        ptr_array = NULL;
  10051f:	48 c7 05 f6 1a 00 00 	movq   $0x0,0x1af6(%rip)        # 102020 <ptr_array>
  100526:	00 00 00 00 
    }
    num_allocs = 0;
  10052a:	c7 05 fc 1a 00 00 00 	movl   $0x0,0x1afc(%rip)        # 102030 <num_allocs>
  100531:	00 00 00 
    free_space = 0;
  100534:	c7 05 de 1a 00 00 00 	movl   $0x0,0x1ade(%rip)        # 10201c <free_space>
  10053b:	00 00 00 
    largest_free_chunk = 0;
  10053e:	c7 05 d0 1a 00 00 00 	movl   $0x0,0x1ad0(%rip)        # 102018 <largest_free_chunk>
  100545:	00 00 00 
}
  100548:	c3                   	ret    

0000000000100549 <update_free_space>:

void update_free_space() {
  100549:	f3 0f 1e fa          	endbr64 
    free_space = 0; // Reset the free space counter
  10054d:	c7 05 c5 1a 00 00 00 	movl   $0x0,0x1ac5(%rip)        # 10201c <free_space>
  100554:	00 00 00 
    block *b = free_head;
  100557:	48 8b 05 e2 1a 00 00 	mov    0x1ae2(%rip),%rax        # 102040 <free_head>

    // Traverse the free list and sum up the size of free blocks
    while (b) {
  10055e:	48 85 c0             	test   %rax,%rax
  100561:	74 16                	je     100579 <update_free_space+0x30>
        free_space += b->size + BLOCKSIZE; // Add block size + metadata size
  100563:	48 8b 08             	mov    (%rax),%rcx
  100566:	48 8d 51 28          	lea    0x28(%rcx),%rdx
  10056a:	01 15 ac 1a 00 00    	add    %edx,0x1aac(%rip)        # 10201c <free_space>
        b = b->free_next;
  100570:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (b) {
  100574:	48 85 c0             	test   %rax,%rax
  100577:	75 ea                	jne    100563 <update_free_space+0x1a>
    }
}
  100579:	c3                   	ret    

000000000010057a <defrag>:
void defrag() {
  10057a:	f3 0f 1e fa          	endbr64 
  10057e:	55                   	push   %rbp
  10057f:	48 89 e5             	mov    %rsp,%rbp
  100582:	41 54                	push   %r12
  100584:	53                   	push   %rbx
    block *b = free_head;
  100585:	48 8b 1d b4 1a 00 00 	mov    0x1ab4(%rip),%rbx        # 102040 <free_head>
    while (b && b->free_next) {
  10058c:	48 85 db             	test   %rbx,%rbx
  10058f:	74 34                	je     1005c5 <defrag+0x4b>
  100591:	4c 8b 63 18          	mov    0x18(%rbx),%r12
  100595:	4d 85 e4             	test   %r12,%r12
  100598:	74 2b                	je     1005c5 <defrag+0x4b>
        if ((void*)b + BLOCKSIZE + b->size == (void*)b->free_next) {
  10059a:	48 8b 03             	mov    (%rbx),%rax
  10059d:	48 8d 44 03 28       	lea    0x28(%rbx,%rax,1),%rax
  1005a2:	49 39 c4             	cmp    %rax,%r12
  1005a5:	74 05                	je     1005ac <defrag+0x32>
    while (b && b->free_next) {
  1005a7:	4c 89 e3             	mov    %r12,%rbx
  1005aa:	eb e0                	jmp    10058c <defrag+0x12>
            remove_from_free_list(next);
  1005ac:	4c 89 e7             	mov    %r12,%rdi
  1005af:	e8 a5 fe ff ff       	call   100459 <remove_from_free_list>
            b->size += BLOCKSIZE + next->size;
  1005b4:	48 8b 13             	mov    (%rbx),%rdx
  1005b7:	49 8b 04 24          	mov    (%r12),%rax
  1005bb:	48 8d 44 02 28       	lea    0x28(%rdx,%rax,1),%rax
  1005c0:	48 89 03             	mov    %rax,(%rbx)
  1005c3:	eb c7                	jmp    10058c <defrag+0x12>
    update_free_space();         // Update free space
  1005c5:	b8 00 00 00 00       	mov    $0x0,%eax
  1005ca:	e8 7a ff ff ff       	call   100549 <update_free_space>
    update_largest_free_chunk(); // Update largest free chunk
  1005cf:	b8 00 00 00 00       	mov    $0x0,%eax
  1005d4:	e8 cb fe ff ff       	call   1004a4 <update_largest_free_chunk>
}
  1005d9:	5b                   	pop    %rbx
  1005da:	41 5c                	pop    %r12
  1005dc:	5d                   	pop    %rbp
  1005dd:	c3                   	ret    

00000000001005de <add_alloc>:

void add_alloc(block* b){
  1005de:	f3 0f 1e fa          	endbr64 
    size_array[num_allocs] = b->size;
  1005e2:	48 63 15 47 1a 00 00 	movslq 0x1a47(%rip),%rdx        # 102030 <num_allocs>
  1005e9:	48 8b 0f             	mov    (%rdi),%rcx
  1005ec:	48 8b 05 35 1a 00 00 	mov    0x1a35(%rip),%rax        # 102028 <size_array>
  1005f3:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
    ptr_array[num_allocs] = (void*)((void*)b + BLOCKSIZE);
  1005f7:	48 63 15 32 1a 00 00 	movslq 0x1a32(%rip),%rdx        # 102030 <num_allocs>
  1005fe:	48 83 c7 28          	add    $0x28,%rdi
  100602:	48 8b 05 17 1a 00 00 	mov    0x1a17(%rip),%rax        # 102020 <ptr_array>
  100609:	48 89 3c d0          	mov    %rdi,(%rax,%rdx,8)
} 
  10060d:	c3                   	ret    

000000000010060e <malloc>:
void *malloc(uint64_t numbytes) {
  10060e:	f3 0f 1e fa          	endbr64 
  100612:	55                   	push   %rbp
  100613:	48 89 e5             	mov    %rsp,%rbp
  100616:	41 54                	push   %r12
  100618:	53                   	push   %rbx
  100619:	49 89 fc             	mov    %rdi,%r12
    if (size_array == NULL) { 
  10061c:	48 83 3d 04 1a 00 00 	cmpq   $0x0,0x1a04(%rip)        # 102028 <size_array>
  100623:	00 
  100624:	74 3e                	je     100664 <malloc+0x56>
    return (size + 7) / 8 * 8;
  100626:	49 83 c4 07          	add    $0x7,%r12
  10062a:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    block *b = find_block(size);
  10062e:	4c 89 e7             	mov    %r12,%rdi
  100631:	e8 7e fd ff ff       	call   1003b4 <find_block>
  100636:	48 89 c3             	mov    %rax,%rbx
    if (b == NULL) {
  100639:	48 85 c0             	test   %rax,%rax
  10063c:	74 32                	je     100670 <malloc+0x62>
        remove_from_free_list(b);
  10063e:	48 89 c7             	mov    %rax,%rdi
  100641:	e8 13 fe ff ff       	call   100459 <remove_from_free_list>
        if (b->size > size + BLOCKSIZE) {
  100646:	49 8d 44 24 28       	lea    0x28(%r12),%rax
  10064b:	48 39 03             	cmp    %rax,(%rbx)
  10064e:	77 32                	ja     100682 <malloc+0x74>
    add_alloc(b); 
  100650:	48 89 df             	mov    %rbx,%rdi
  100653:	e8 86 ff ff ff       	call   1005de <add_alloc>
    return (void*)((void*)b + BLOCKSIZE);
  100658:	48 83 c3 28          	add    $0x28,%rbx
}
  10065c:	48 89 d8             	mov    %rbx,%rax
  10065f:	5b                   	pop    %rbx
  100660:	41 5c                	pop    %r12
  100662:	5d                   	pop    %rbp
  100663:	c3                   	ret    
        heap_init();
  100664:	b8 00 00 00 00       	mov    $0x0,%eax
  100669:	e8 6d fe ff ff       	call   1004db <heap_init>
  10066e:	eb b6                	jmp    100626 <malloc+0x18>
        b = new_block(size);
  100670:	4c 89 e7             	mov    %r12,%rdi
  100673:	e8 f2 fc ff ff       	call   10036a <new_block>
  100678:	48 89 c3             	mov    %rax,%rbx
        if (b == NULL) {
  10067b:	48 85 c0             	test   %rax,%rax
  10067e:	75 d0                	jne    100650 <malloc+0x42>
  100680:	eb da                	jmp    10065c <malloc+0x4e>
            split_block(b, size);
  100682:	4c 89 e6             	mov    %r12,%rsi
  100685:	48 89 df             	mov    %rbx,%rdi
  100688:	e8 75 fd ff ff       	call   100402 <split_block>
            update_free_space();         
  10068d:	b8 00 00 00 00       	mov    $0x0,%eax
  100692:	e8 b2 fe ff ff       	call   100549 <update_free_space>
  100697:	eb b7                	jmp    100650 <malloc+0x42>

0000000000100699 <calloc>:
void *calloc(uint64_t num, uint64_t sz) {
  100699:	f3 0f 1e fa          	endbr64 
  10069d:	55                   	push   %rbp
  10069e:	48 89 e5             	mov    %rsp,%rbp
  1006a1:	41 54                	push   %r12
  1006a3:	53                   	push   %rbx
    uint64_t total = num * sz;
  1006a4:	48 0f af fe          	imul   %rsi,%rdi
  1006a8:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  1006ab:	e8 5e ff ff ff       	call   10060e <malloc>
  1006b0:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  1006b3:	48 85 c0             	test   %rax,%rax
  1006b6:	74 10                	je     1006c8 <calloc+0x2f>
        memset(ptr, 0, total);
  1006b8:	4c 89 e2             	mov    %r12,%rdx
  1006bb:	be 00 00 00 00       	mov    $0x0,%esi
  1006c0:	48 89 c7             	mov    %rax,%rdi
  1006c3:	e8 a9 06 00 00       	call   100d71 <memset>
}
  1006c8:	48 89 d8             	mov    %rbx,%rax
  1006cb:	5b                   	pop    %rbx
  1006cc:	41 5c                	pop    %r12
  1006ce:	5d                   	pop    %rbp
  1006cf:	c3                   	ret    

00000000001006d0 <remove_alloc>:
void remove_alloc(block* b){
  1006d0:	f3 0f 1e fa          	endbr64 
    num_allocs--;
  1006d4:	8b 05 56 19 00 00    	mov    0x1956(%rip),%eax        # 102030 <num_allocs>
  1006da:	83 e8 01             	sub    $0x1,%eax
  1006dd:	89 05 4d 19 00 00    	mov    %eax,0x194d(%rip)        # 102030 <num_allocs>
    size_array[num_allocs] = 0;
  1006e3:	48 98                	cltq   
  1006e5:	48 8b 15 3c 19 00 00 	mov    0x193c(%rip),%rdx        # 102028 <size_array>
  1006ec:	48 c7 04 c2 00 00 00 	movq   $0x0,(%rdx,%rax,8)
  1006f3:	00 
    // ptr_array[num_allocs] = NULL;
}
  1006f4:	c3                   	ret    

00000000001006f5 <free>:
void free(void *firstbyte) {
  1006f5:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  1006f9:	48 85 ff             	test   %rdi,%rdi
  1006fc:	74 06                	je     100704 <free+0xf>
    if (b->free) return; // Prevent double-free
  1006fe:	83 7f e8 00          	cmpl   $0x0,-0x18(%rdi)
  100702:	74 01                	je     100705 <free+0x10>
  100704:	c3                   	ret    
void free(void *firstbyte) {
  100705:	55                   	push   %rbp
  100706:	48 89 e5             	mov    %rsp,%rbp
  100709:	53                   	push   %rbx
  10070a:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
  10070e:	48 8d 5f d8          	lea    -0x28(%rdi),%rbx
    add_to_free_list(b);
  100712:	48 89 df             	mov    %rbx,%rdi
  100715:	e8 b9 fc ff ff       	call   1003d3 <add_to_free_list>
    remove_alloc(b); // Remove from size_array and ptr_array
  10071a:	48 89 df             	mov    %rbx,%rdi
  10071d:	e8 ae ff ff ff       	call   1006d0 <remove_alloc>
    update_free_space();         // Update free space
  100722:	b8 00 00 00 00       	mov    $0x0,%eax
  100727:	e8 1d fe ff ff       	call   100549 <update_free_space>
    update_largest_free_chunk(); // Update largest free chunk
  10072c:	b8 00 00 00 00       	mov    $0x0,%eax
  100731:	e8 6e fd ff ff       	call   1004a4 <update_largest_free_chunk>
}
  100736:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10073a:	c9                   	leave  
  10073b:	c3                   	ret    

000000000010073c <realloc>:
void *realloc(void *ptr, uint64_t sz) {
  10073c:	f3 0f 1e fa          	endbr64 
  100740:	55                   	push   %rbp
  100741:	48 89 e5             	mov    %rsp,%rbp
  100744:	41 54                	push   %r12
  100746:	53                   	push   %rbx
  100747:	48 89 fb             	mov    %rdi,%rbx
  10074a:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  10074d:	48 85 db             	test   %rbx,%rbx
  100750:	74 2d                	je     10077f <realloc+0x43>
    if (sz == 0) {
  100752:	48 85 f6             	test   %rsi,%rsi
  100755:	74 32                	je     100789 <realloc+0x4d>
    return (size + 7) / 8 * 8;
  100757:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  10075b:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi
    if (b->size >= aligned_size) {
  10075f:	48 8b 43 d8          	mov    -0x28(%rbx),%rax
  100763:	48 39 f0             	cmp    %rsi,%rax
  100766:	72 31                	jb     100799 <realloc+0x5d>
        if (b->size > aligned_size + BLOCKSIZE) {
  100768:	48 8d 56 28          	lea    0x28(%rsi),%rdx
        return ptr;
  10076c:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  10076f:	48 39 d0             	cmp    %rdx,%rax
  100772:	76 49                	jbe    1007bd <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE);
  100774:	48 8d 7b d8          	lea    -0x28(%rbx),%rdi
            split_block(b, aligned_size);
  100778:	e8 85 fc ff ff       	call   100402 <split_block>
  10077d:	eb 3e                	jmp    1007bd <realloc+0x81>
        return malloc(sz);
  10077f:	e8 8a fe ff ff       	call   10060e <malloc>
  100784:	49 89 c4             	mov    %rax,%r12
  100787:	eb 34                	jmp    1007bd <realloc+0x81>
        free(ptr);
  100789:	48 89 df             	mov    %rbx,%rdi
  10078c:	e8 64 ff ff ff       	call   1006f5 <free>
        return NULL;
  100791:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100797:	eb 24                	jmp    1007bd <realloc+0x81>
    void *new_ptr = malloc(sz);
  100799:	e8 70 fe ff ff       	call   10060e <malloc>
  10079e:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  1007a1:	48 85 c0             	test   %rax,%rax
  1007a4:	74 17                	je     1007bd <realloc+0x81>
    memcpy(new_ptr, ptr, b->size);
  1007a6:	48 8b 53 d8          	mov    -0x28(%rbx),%rdx
  1007aa:	48 89 de             	mov    %rbx,%rsi
  1007ad:	48 89 c7             	mov    %rax,%rdi
  1007b0:	e8 b6 04 00 00       	call   100c6b <memcpy>
    free(ptr);
  1007b5:	48 89 df             	mov    %rbx,%rdi
  1007b8:	e8 38 ff ff ff       	call   1006f5 <free>
}
  1007bd:	4c 89 e0             	mov    %r12,%rax
  1007c0:	5b                   	pop    %rbx
  1007c1:	41 5c                	pop    %r12
  1007c3:	5d                   	pop    %rbp
  1007c4:	c3                   	ret    

00000000001007c5 <heap_info>:


int heap_info(heap_info_struct * info) {
  1007c5:	f3 0f 1e fa          	endbr64 
    info->num_allocs = num_allocs;
  1007c9:	8b 05 61 18 00 00    	mov    0x1861(%rip),%eax        # 102030 <num_allocs>
  1007cf:	89 07                	mov    %eax,(%rdi)
    info->free_space = free_space;             
  1007d1:	8b 05 45 18 00 00    	mov    0x1845(%rip),%eax        # 10201c <free_space>
  1007d7:	89 47 18             	mov    %eax,0x18(%rdi)
    info->largest_free_chunk = largest_free_chunk;
  1007da:	8b 05 38 18 00 00    	mov    0x1838(%rip),%eax        # 102018 <largest_free_chunk>
  1007e0:	89 47 1c             	mov    %eax,0x1c(%rdi)

    info->size_array = size_array;
  1007e3:	48 8b 05 3e 18 00 00 	mov    0x183e(%rip),%rax        # 102028 <size_array>
  1007ea:	48 89 47 08          	mov    %rax,0x8(%rdi)
    info->ptr_array = ptr_array;
  1007ee:	48 8b 05 2b 18 00 00 	mov    0x182b(%rip),%rax        # 102020 <ptr_array>
  1007f5:	48 89 47 10          	mov    %rax,0x10(%rdi)
    return 0;
}
  1007f9:	b8 00 00 00 00       	mov    $0x0,%eax
  1007fe:	c3                   	ret    

00000000001007ff <_quicksort>:
typedef int (*__compar_fn_t) (const void *, const void *);

void
_quicksort (void *const pbase, size_t total_elems, size_t size,
            __compar_fn_t cmp)
{
  1007ff:	f3 0f 1e fa          	endbr64 
  100803:	55                   	push   %rbp
  100804:	48 89 e5             	mov    %rsp,%rbp
  100807:	41 57                	push   %r15
  100809:	41 56                	push   %r14
  10080b:	41 55                	push   %r13
  10080d:	41 54                	push   %r12
  10080f:	53                   	push   %rbx
  100810:	48 81 ec 48 04 00 00 	sub    $0x448,%rsp
  100817:	48 89 bd a0 fb ff ff 	mov    %rdi,-0x460(%rbp)
  10081e:	48 89 b5 98 fb ff ff 	mov    %rsi,-0x468(%rbp)
  100825:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
    char *base_ptr = (char *) pbase;
    const size_t max_thresh = MAX_THRESH * size;
    if (total_elems == 0)
  10082c:	48 85 f6             	test   %rsi,%rsi
  10082f:	0f 84 94 03 00 00    	je     100bc9 <_quicksort+0x3ca>
  100835:	48 89 f0             	mov    %rsi,%rax
  100838:	48 89 cb             	mov    %rcx,%rbx
    const size_t max_thresh = MAX_THRESH * size;
  10083b:	48 8d 0c 95 00 00 00 	lea    0x0(,%rdx,4),%rcx
  100842:	00 
  100843:	48 89 8d a8 fb ff ff 	mov    %rcx,-0x458(%rbp)
	/* Avoid lossage with unsigned arithmetic below.  */
	return;
    if (total_elems > MAX_THRESH)
  10084a:	48 83 fe 04          	cmp    $0x4,%rsi
  10084e:	0f 86 bd 02 00 00    	jbe    100b11 <_quicksort+0x312>
    {
	char *lo = base_ptr;
	char *hi = &lo[size * (total_elems - 1)];
  100854:	48 83 e8 01          	sub    $0x1,%rax
  100858:	48 0f af c2          	imul   %rdx,%rax
  10085c:	48 01 f8             	add    %rdi,%rax
  10085f:	48 89 85 c0 fb ff ff 	mov    %rax,-0x440(%rbp)
	stack_node stack[STACK_SIZE];
	stack_node *top = stack;
	PUSH (NULL, NULL);
  100866:	48 c7 85 d0 fb ff ff 	movq   $0x0,-0x430(%rbp)
  10086d:	00 00 00 00 
  100871:	48 c7 85 d8 fb ff ff 	movq   $0x0,-0x428(%rbp)
  100878:	00 00 00 00 
	char *lo = base_ptr;
  10087c:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
	PUSH (NULL, NULL);
  100883:	48 8d 85 e0 fb ff ff 	lea    -0x420(%rbp),%rax
  10088a:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
		goto jump_over;
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
		SWAP (mid, lo, size);
jump_over:;
	  left_ptr  = lo + size;
	  right_ptr = hi - size;
  100891:	48 f7 da             	neg    %rdx
  100894:	49 89 d7             	mov    %rdx,%r15
  100897:	e9 8c 01 00 00       	jmp    100a28 <_quicksort+0x229>
  10089c:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  1008a3:	49 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%rdi
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  1008a8:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  1008af:	4c 89 e8             	mov    %r13,%rax
  1008b2:	0f b6 08             	movzbl (%rax),%ecx
  1008b5:	48 83 c0 01          	add    $0x1,%rax
  1008b9:	0f b6 32             	movzbl (%rdx),%esi
  1008bc:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  1008c0:	48 83 c2 01          	add    $0x1,%rdx
  1008c4:	88 4a ff             	mov    %cl,-0x1(%rdx)
  1008c7:	48 39 c7             	cmp    %rax,%rdi
  1008ca:	75 e6                	jne    1008b2 <_quicksort+0xb3>
  1008cc:	e9 92 01 00 00       	jmp    100a63 <_quicksort+0x264>
  1008d1:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  1008d8:	4d 8d 64 05 00       	lea    0x0(%r13,%rax,1),%r12
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  1008dd:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
		SWAP (mid, hi, size);
  1008e4:	4c 89 e8             	mov    %r13,%rax
  1008e7:	0f b6 08             	movzbl (%rax),%ecx
  1008ea:	48 83 c0 01          	add    $0x1,%rax
  1008ee:	0f b6 32             	movzbl (%rdx),%esi
  1008f1:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  1008f5:	48 83 c2 01          	add    $0x1,%rdx
  1008f9:	88 4a ff             	mov    %cl,-0x1(%rdx)
  1008fc:	49 39 c4             	cmp    %rax,%r12
  1008ff:	75 e6                	jne    1008e7 <_quicksort+0xe8>
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  100901:	48 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%rsi
  100908:	4c 89 ef             	mov    %r13,%rdi
  10090b:	ff d3                	call   *%rbx
  10090d:	85 c0                	test   %eax,%eax
  10090f:	0f 89 62 01 00 00    	jns    100a77 <_quicksort+0x278>
  100915:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  10091c:	4c 89 e8             	mov    %r13,%rax
  10091f:	0f b6 08             	movzbl (%rax),%ecx
  100922:	48 83 c0 01          	add    $0x1,%rax
  100926:	0f b6 32             	movzbl (%rdx),%esi
  100929:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  10092d:	48 83 c2 01          	add    $0x1,%rdx
  100931:	88 4a ff             	mov    %cl,-0x1(%rdx)
  100934:	49 39 c4             	cmp    %rax,%r12
  100937:	75 e6                	jne    10091f <_quicksort+0x120>
jump_over:;
  100939:	e9 39 01 00 00       	jmp    100a77 <_quicksort+0x278>
	  do
	  {
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
		  left_ptr += size;
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
		  right_ptr -= size;
  10093e:	4d 01 fc             	add    %r15,%r12
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
  100941:	4c 89 e6             	mov    %r12,%rsi
  100944:	4c 89 ef             	mov    %r13,%rdi
  100947:	ff d3                	call   *%rbx
  100949:	85 c0                	test   %eax,%eax
  10094b:	78 f1                	js     10093e <_quicksort+0x13f>
	      if (left_ptr < right_ptr)
  10094d:	4d 39 e6             	cmp    %r12,%r14
  100950:	72 1c                	jb     10096e <_quicksort+0x16f>
		  else if (mid == right_ptr)
		      mid = left_ptr;
		  left_ptr += size;
		  right_ptr -= size;
	      }
	      else if (left_ptr == right_ptr)
  100952:	74 5e                	je     1009b2 <_quicksort+0x1b3>
		  left_ptr += size;
		  right_ptr -= size;
		  break;
	      }
	  }
	  while (left_ptr <= right_ptr);
  100954:	4d 39 e6             	cmp    %r12,%r14
  100957:	77 63                	ja     1009bc <_quicksort+0x1bd>
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
  100959:	4c 89 ee             	mov    %r13,%rsi
  10095c:	4c 89 f7             	mov    %r14,%rdi
  10095f:	ff d3                	call   *%rbx
  100961:	85 c0                	test   %eax,%eax
  100963:	79 dc                	jns    100941 <_quicksort+0x142>
		  left_ptr += size;
  100965:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  10096c:	eb eb                	jmp    100959 <_quicksort+0x15a>
  10096e:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100975:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
	      if (left_ptr < right_ptr)
  100979:	4c 89 e2             	mov    %r12,%rdx
  10097c:	4c 89 f0             	mov    %r14,%rax
		  SWAP (left_ptr, right_ptr, size);
  10097f:	0f b6 08             	movzbl (%rax),%ecx
  100982:	48 83 c0 01          	add    $0x1,%rax
  100986:	0f b6 32             	movzbl (%rdx),%esi
  100989:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  10098d:	48 83 c2 01          	add    $0x1,%rdx
  100991:	88 4a ff             	mov    %cl,-0x1(%rdx)
  100994:	48 39 f8             	cmp    %rdi,%rax
  100997:	75 e6                	jne    10097f <_quicksort+0x180>
		  if (mid == left_ptr)
  100999:	4d 39 ee             	cmp    %r13,%r14
  10099c:	74 0f                	je     1009ad <_quicksort+0x1ae>
		  else if (mid == right_ptr)
  10099e:	4d 39 ec             	cmp    %r13,%r12
  1009a1:	4d 0f 44 ee          	cmove  %r14,%r13
		  right_ptr -= size;
  1009a5:	4d 01 fc             	add    %r15,%r12
		  left_ptr += size;
  1009a8:	49 89 fe             	mov    %rdi,%r14
  1009ab:	eb a7                	jmp    100954 <_quicksort+0x155>
  1009ad:	4d 89 e5             	mov    %r12,%r13
  1009b0:	eb f3                	jmp    1009a5 <_quicksort+0x1a6>
		  left_ptr += size;
  1009b2:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
		  right_ptr -= size;
  1009b9:	4d 01 fc             	add    %r15,%r12
	  /* Set up pointers for next iteration.  First determine whether
	     left and right partitions are below the threshold size.  If so,
	     ignore one or both.  Otherwise, push the larger partition's
	     bounds on the stack and continue sorting the smaller one. */
	  if ((size_t) (right_ptr - lo) <= max_thresh)
  1009bc:	4c 89 e0             	mov    %r12,%rax
  1009bf:	48 2b 85 b8 fb ff ff 	sub    -0x448(%rbp),%rax
  1009c6:	48 8b bd a8 fb ff ff 	mov    -0x458(%rbp),%rdi
  1009cd:	48 39 f8             	cmp    %rdi,%rax
  1009d0:	0f 87 bf 00 00 00    	ja     100a95 <_quicksort+0x296>
	  {
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  1009d6:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  1009dd:	4c 29 f0             	sub    %r14,%rax
		  /* Ignore both small partitions. */
		  POP (lo, hi);
	      else
		  /* Ignore small left partition. */
		  lo = left_ptr;
  1009e0:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  1009e7:	48 39 f8             	cmp    %rdi,%rax
  1009ea:	77 28                	ja     100a14 <_quicksort+0x215>
		  POP (lo, hi);
  1009ec:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  1009f3:	48 8b 78 f0          	mov    -0x10(%rax),%rdi
  1009f7:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
  1009fe:	48 8b 78 f8          	mov    -0x8(%rax),%rdi
  100a02:	48 89 bd c0 fb ff ff 	mov    %rdi,-0x440(%rbp)
  100a09:	48 8d 40 f0          	lea    -0x10(%rax),%rax
  100a0d:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	while (STACK_NOT_EMPTY)
  100a14:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  100a1b:	48 39 85 b0 fb ff ff 	cmp    %rax,-0x450(%rbp)
  100a22:	0f 86 e9 00 00 00    	jbe    100b11 <_quicksort+0x312>
	    char *mid = lo + size * ((hi - lo) / size >> 1);
  100a28:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  100a2f:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  100a36:	48 29 f8             	sub    %rdi,%rax
  100a39:	48 8b 8d c8 fb ff ff 	mov    -0x438(%rbp),%rcx
  100a40:	ba 00 00 00 00       	mov    $0x0,%edx
  100a45:	48 f7 f1             	div    %rcx
  100a48:	48 d1 e8             	shr    %rax
  100a4b:	48 0f af c1          	imul   %rcx,%rax
  100a4f:	4c 8d 2c 07          	lea    (%rdi,%rax,1),%r13
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  100a53:	48 89 fe             	mov    %rdi,%rsi
  100a56:	4c 89 ef             	mov    %r13,%rdi
  100a59:	ff d3                	call   *%rbx
  100a5b:	85 c0                	test   %eax,%eax
  100a5d:	0f 88 39 fe ff ff    	js     10089c <_quicksort+0x9d>
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  100a63:	4c 89 ee             	mov    %r13,%rsi
  100a66:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  100a6d:	ff d3                	call   *%rbx
  100a6f:	85 c0                	test   %eax,%eax
  100a71:	0f 88 5a fe ff ff    	js     1008d1 <_quicksort+0xd2>
	  left_ptr  = lo + size;
  100a77:	4c 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%r14
  100a7e:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
	  right_ptr = hi - size;
  100a85:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  100a8c:	4e 8d 24 38          	lea    (%rax,%r15,1),%r12
  100a90:	e9 c4 fe ff ff       	jmp    100959 <_quicksort+0x15a>
	  }
	  else if ((size_t) (hi - left_ptr) <= max_thresh)
  100a95:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
  100a9c:	4c 29 f2             	sub    %r14,%rdx
  100a9f:	48 3b 95 a8 fb ff ff 	cmp    -0x458(%rbp),%rdx
  100aa6:	76 5d                	jbe    100b05 <_quicksort+0x306>
	      /* Ignore small right partition. */
	      hi = right_ptr;
	  else if ((right_ptr - lo) > (hi - left_ptr))
  100aa8:	48 39 d0             	cmp    %rdx,%rax
  100aab:	7e 2c                	jle    100ad9 <_quicksort+0x2da>
	  {
	      /* Push larger left partition indices. */
	      PUSH (lo, right_ptr);
  100aad:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  100ab4:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  100abb:	48 89 38             	mov    %rdi,(%rax)
  100abe:	4c 89 60 08          	mov    %r12,0x8(%rax)
  100ac2:	48 83 c0 10          	add    $0x10,%rax
  100ac6:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      lo = left_ptr;
  100acd:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
  100ad4:	e9 3b ff ff ff       	jmp    100a14 <_quicksort+0x215>
	  }
	  else
	  {
	      /* Push larger right partition indices. */
	      PUSH (left_ptr, hi);
  100ad9:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  100ae0:	4c 89 30             	mov    %r14,(%rax)
  100ae3:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  100aea:	48 89 78 08          	mov    %rdi,0x8(%rax)
  100aee:	48 83 c0 10          	add    $0x10,%rax
  100af2:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      hi = right_ptr;
  100af9:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  100b00:	e9 0f ff ff ff       	jmp    100a14 <_quicksort+0x215>
	      hi = right_ptr;
  100b05:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  100b0c:	e9 03 ff ff ff       	jmp    100a14 <_quicksort+0x215>
       for partitions below MAX_THRESH size. BASE_PTR points to the beginning
       of the array to sort, and END_PTR points at the very last element in
       the array (*not* one beyond it!). */
#define min(x, y) ((x) < (y) ? (x) : (y))
    {
	char *const end_ptr = &base_ptr[size * (total_elems - 1)];
  100b11:	4c 8b bd 98 fb ff ff 	mov    -0x468(%rbp),%r15
  100b18:	49 83 ef 01          	sub    $0x1,%r15
  100b1c:	48 8b bd c8 fb ff ff 	mov    -0x438(%rbp),%rdi
  100b23:	4c 0f af ff          	imul   %rdi,%r15
  100b27:	4c 8b ad a0 fb ff ff 	mov    -0x460(%rbp),%r13
  100b2e:	4d 01 ef             	add    %r13,%r15
	char *tmp_ptr = base_ptr;
	char *thresh = min(end_ptr, base_ptr + max_thresh);
  100b31:	48 8b 85 a8 fb ff ff 	mov    -0x458(%rbp),%rax
  100b38:	4c 01 e8             	add    %r13,%rax
  100b3b:	49 39 c7             	cmp    %rax,%r15
  100b3e:	49 0f 46 c7          	cmovbe %r15,%rax
	char *run_ptr;
	/* Find smallest element in first threshold and place it at the
	   array's beginning.  This is the smallest array element,
	   and the operation speeds up insertion sort's inner loop. */
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  100b42:	4d 89 ec             	mov    %r13,%r12
  100b45:	49 01 fc             	add    %rdi,%r12
  100b48:	4c 39 e0             	cmp    %r12,%rax
  100b4b:	72 66                	jb     100bb3 <_quicksort+0x3b4>
  100b4d:	4d 89 e6             	mov    %r12,%r14
	char *tmp_ptr = base_ptr;
  100b50:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  100b57:	49 89 c4             	mov    %rax,%r12
	    if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100b5a:	4c 89 ee             	mov    %r13,%rsi
  100b5d:	4c 89 f7             	mov    %r14,%rdi
  100b60:	ff d3                	call   *%rbx
  100b62:	85 c0                	test   %eax,%eax
  100b64:	4d 0f 48 ee          	cmovs  %r14,%r13
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  100b68:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  100b6f:	4d 39 f4             	cmp    %r14,%r12
  100b72:	73 e6                	jae    100b5a <_quicksort+0x35b>
  100b74:	4c 8b a5 c0 fb ff ff 	mov    -0x440(%rbp),%r12
		tmp_ptr = run_ptr;
	if (tmp_ptr != base_ptr)
  100b7b:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100b82:	49 8d 4c 05 00       	lea    0x0(%r13,%rax,1),%rcx
  100b87:	48 8b 85 a0 fb ff ff 	mov    -0x460(%rbp),%rax
  100b8e:	4c 3b ad a0 fb ff ff 	cmp    -0x460(%rbp),%r13
  100b95:	74 1c                	je     100bb3 <_quicksort+0x3b4>
	    SWAP (tmp_ptr, base_ptr, size);
  100b97:	41 0f b6 55 00       	movzbl 0x0(%r13),%edx
  100b9c:	49 83 c5 01          	add    $0x1,%r13
  100ba0:	0f b6 30             	movzbl (%rax),%esi
  100ba3:	41 88 75 ff          	mov    %sil,-0x1(%r13)
  100ba7:	48 83 c0 01          	add    $0x1,%rax
  100bab:	88 50 ff             	mov    %dl,-0x1(%rax)
  100bae:	49 39 cd             	cmp    %rcx,%r13
  100bb1:	75 e4                	jne    100b97 <_quicksort+0x398>
	/* Insertion sort, running from left-hand-side up to right-hand-side.  */
	run_ptr = base_ptr + size;
	while ((run_ptr += size) <= end_ptr)
  100bb3:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100bba:	4d 8d 34 04          	lea    (%r12,%rax,1),%r14
	{
	    tmp_ptr = run_ptr - size;
  100bbe:	48 f7 d8             	neg    %rax
  100bc1:	49 89 c5             	mov    %rax,%r13
	while ((run_ptr += size) <= end_ptr)
  100bc4:	4d 39 f7             	cmp    %r14,%r15
  100bc7:	73 15                	jae    100bde <_quicksort+0x3df>
		    *hi = c;
		}
	    }
	}
    }
}
  100bc9:	48 81 c4 48 04 00 00 	add    $0x448,%rsp
  100bd0:	5b                   	pop    %rbx
  100bd1:	41 5c                	pop    %r12
  100bd3:	41 5d                	pop    %r13
  100bd5:	41 5e                	pop    %r14
  100bd7:	41 5f                	pop    %r15
  100bd9:	5d                   	pop    %rbp
  100bda:	c3                   	ret    
		tmp_ptr -= size;
  100bdb:	4d 01 ec             	add    %r13,%r12
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100bde:	4c 89 e6             	mov    %r12,%rsi
  100be1:	4c 89 f7             	mov    %r14,%rdi
  100be4:	ff d3                	call   *%rbx
  100be6:	85 c0                	test   %eax,%eax
  100be8:	78 f1                	js     100bdb <_quicksort+0x3dc>
	    tmp_ptr += size;
  100bea:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100bf1:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
	    if (tmp_ptr != run_ptr)
  100bf5:	4c 39 f6             	cmp    %r14,%rsi
  100bf8:	75 17                	jne    100c11 <_quicksort+0x412>
	while ((run_ptr += size) <= end_ptr)
  100bfa:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100c01:	4c 01 f0             	add    %r14,%rax
  100c04:	4d 89 f4             	mov    %r14,%r12
  100c07:	49 39 c7             	cmp    %rax,%r15
  100c0a:	72 bd                	jb     100bc9 <_quicksort+0x3ca>
  100c0c:	49 89 c6             	mov    %rax,%r14
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100c0f:	eb cd                	jmp    100bde <_quicksort+0x3df>
		while (--trav >= run_ptr)
  100c11:	49 8d 7c 06 ff       	lea    -0x1(%r14,%rax,1),%rdi
  100c16:	4c 39 f7             	cmp    %r14,%rdi
  100c19:	72 df                	jb     100bfa <_quicksort+0x3fb>
  100c1b:	4d 8d 46 ff          	lea    -0x1(%r14),%r8
  100c1f:	4d 89 c2             	mov    %r8,%r10
  100c22:	eb 13                	jmp    100c37 <_quicksort+0x438>
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100c24:	48 89 f9             	mov    %rdi,%rcx
		    *hi = c;
  100c27:	44 88 09             	mov    %r9b,(%rcx)
		while (--trav >= run_ptr)
  100c2a:	48 83 ef 01          	sub    $0x1,%rdi
  100c2e:	49 83 e8 01          	sub    $0x1,%r8
  100c32:	49 39 fa             	cmp    %rdi,%r10
  100c35:	74 c3                	je     100bfa <_quicksort+0x3fb>
		    char c = *trav;
  100c37:	44 0f b6 0f          	movzbl (%rdi),%r9d
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100c3b:	4c 89 c0             	mov    %r8,%rax
  100c3e:	4c 39 c6             	cmp    %r8,%rsi
  100c41:	77 e1                	ja     100c24 <_quicksort+0x425>
  100c43:	48 89 fa             	mov    %rdi,%rdx
			*hi = *lo;
  100c46:	0f b6 08             	movzbl (%rax),%ecx
  100c49:	88 0a                	mov    %cl,(%rdx)
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100c4b:	48 89 c1             	mov    %rax,%rcx
  100c4e:	4c 01 e8             	add    %r13,%rax
  100c51:	48 2b 95 c8 fb ff ff 	sub    -0x438(%rbp),%rdx
  100c58:	48 39 c6             	cmp    %rax,%rsi
  100c5b:	76 e9                	jbe    100c46 <_quicksort+0x447>
  100c5d:	eb c8                	jmp    100c27 <_quicksort+0x428>

0000000000100c5f <ptr_comparator>:

int ptr_comparator( const void * a, const void * b){
  100c5f:	f3 0f 1e fa          	endbr64 
    ptr_with_size * a_ptr = (ptr_with_size *) a;
    ptr_with_size * b_ptr = (ptr_with_size *) b;

    return (int)b_ptr->size - (int)a_ptr->size;
  100c63:	48 8b 46 08          	mov    0x8(%rsi),%rax
  100c67:	2b 47 08             	sub    0x8(%rdi),%eax
  100c6a:	c3                   	ret    

0000000000100c6b <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100c6b:	f3 0f 1e fa          	endbr64 
  100c6f:	55                   	push   %rbp
  100c70:	48 89 e5             	mov    %rsp,%rbp
  100c73:	48 83 ec 28          	sub    $0x28,%rsp
  100c77:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100c7b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100c7f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100c83:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100c87:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100c8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100c8f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100c93:	eb 1c                	jmp    100cb1 <memcpy+0x46>
        *d = *s;
  100c95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c99:	0f b6 10             	movzbl (%rax),%edx
  100c9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ca0:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100ca2:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100ca7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100cac:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100cb1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100cb6:	75 dd                	jne    100c95 <memcpy+0x2a>
    }
    return dst;
  100cb8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100cbc:	c9                   	leave  
  100cbd:	c3                   	ret    

0000000000100cbe <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100cbe:	f3 0f 1e fa          	endbr64 
  100cc2:	55                   	push   %rbp
  100cc3:	48 89 e5             	mov    %rsp,%rbp
  100cc6:	48 83 ec 28          	sub    $0x28,%rsp
  100cca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100cce:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100cd2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100cd6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100cda:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100cde:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100ce2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100ce6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100cea:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100cee:	73 6a                	jae    100d5a <memmove+0x9c>
  100cf0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100cf4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100cf8:	48 01 d0             	add    %rdx,%rax
  100cfb:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100cff:	73 59                	jae    100d5a <memmove+0x9c>
        s += n, d += n;
  100d01:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100d05:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100d09:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100d0d:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100d11:	eb 17                	jmp    100d2a <memmove+0x6c>
            *--d = *--s;
  100d13:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100d18:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100d1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d21:	0f b6 10             	movzbl (%rax),%edx
  100d24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100d28:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100d2a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100d2e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100d32:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100d36:	48 85 c0             	test   %rax,%rax
  100d39:	75 d8                	jne    100d13 <memmove+0x55>
    if (s < d && s + n > d) {
  100d3b:	eb 2e                	jmp    100d6b <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100d3d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100d41:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100d45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100d49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100d4d:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100d51:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100d55:	0f b6 12             	movzbl (%rdx),%edx
  100d58:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100d5a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100d5e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100d62:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100d66:	48 85 c0             	test   %rax,%rax
  100d69:	75 d2                	jne    100d3d <memmove+0x7f>
        }
    }
    return dst;
  100d6b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100d6f:	c9                   	leave  
  100d70:	c3                   	ret    

0000000000100d71 <memset>:

void* memset(void* v, int c, size_t n) {
  100d71:	f3 0f 1e fa          	endbr64 
  100d75:	55                   	push   %rbp
  100d76:	48 89 e5             	mov    %rsp,%rbp
  100d79:	48 83 ec 28          	sub    $0x28,%rsp
  100d7d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100d81:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100d84:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100d88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100d8c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100d90:	eb 15                	jmp    100da7 <memset+0x36>
        *p = c;
  100d92:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100d95:	89 c2                	mov    %eax,%edx
  100d97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d9b:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100d9d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100da2:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100da7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100dac:	75 e4                	jne    100d92 <memset+0x21>
    }
    return v;
  100dae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100db2:	c9                   	leave  
  100db3:	c3                   	ret    

0000000000100db4 <strlen>:

size_t strlen(const char* s) {
  100db4:	f3 0f 1e fa          	endbr64 
  100db8:	55                   	push   %rbp
  100db9:	48 89 e5             	mov    %rsp,%rbp
  100dbc:	48 83 ec 18          	sub    $0x18,%rsp
  100dc0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100dc4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100dcb:	00 
  100dcc:	eb 0a                	jmp    100dd8 <strlen+0x24>
        ++n;
  100dce:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100dd3:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100dd8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100ddc:	0f b6 00             	movzbl (%rax),%eax
  100ddf:	84 c0                	test   %al,%al
  100de1:	75 eb                	jne    100dce <strlen+0x1a>
    }
    return n;
  100de3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100de7:	c9                   	leave  
  100de8:	c3                   	ret    

0000000000100de9 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100de9:	f3 0f 1e fa          	endbr64 
  100ded:	55                   	push   %rbp
  100dee:	48 89 e5             	mov    %rsp,%rbp
  100df1:	48 83 ec 20          	sub    $0x20,%rsp
  100df5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100df9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100dfd:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100e04:	00 
  100e05:	eb 0a                	jmp    100e11 <strnlen+0x28>
        ++n;
  100e07:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100e0c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100e11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100e15:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100e19:	74 0b                	je     100e26 <strnlen+0x3d>
  100e1b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100e1f:	0f b6 00             	movzbl (%rax),%eax
  100e22:	84 c0                	test   %al,%al
  100e24:	75 e1                	jne    100e07 <strnlen+0x1e>
    }
    return n;
  100e26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100e2a:	c9                   	leave  
  100e2b:	c3                   	ret    

0000000000100e2c <strcpy>:

char* strcpy(char* dst, const char* src) {
  100e2c:	f3 0f 1e fa          	endbr64 
  100e30:	55                   	push   %rbp
  100e31:	48 89 e5             	mov    %rsp,%rbp
  100e34:	48 83 ec 20          	sub    $0x20,%rsp
  100e38:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100e3c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100e40:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100e44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100e48:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100e4c:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100e50:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100e54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100e58:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100e5c:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100e60:	0f b6 12             	movzbl (%rdx),%edx
  100e63:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100e65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100e69:	48 83 e8 01          	sub    $0x1,%rax
  100e6d:	0f b6 00             	movzbl (%rax),%eax
  100e70:	84 c0                	test   %al,%al
  100e72:	75 d4                	jne    100e48 <strcpy+0x1c>
    return dst;
  100e74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100e78:	c9                   	leave  
  100e79:	c3                   	ret    

0000000000100e7a <strcmp>:

int strcmp(const char* a, const char* b) {
  100e7a:	f3 0f 1e fa          	endbr64 
  100e7e:	55                   	push   %rbp
  100e7f:	48 89 e5             	mov    %rsp,%rbp
  100e82:	48 83 ec 10          	sub    $0x10,%rsp
  100e86:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100e8a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100e8e:	eb 0a                	jmp    100e9a <strcmp+0x20>
        ++a, ++b;
  100e90:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100e95:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100e9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100e9e:	0f b6 00             	movzbl (%rax),%eax
  100ea1:	84 c0                	test   %al,%al
  100ea3:	74 1d                	je     100ec2 <strcmp+0x48>
  100ea5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ea9:	0f b6 00             	movzbl (%rax),%eax
  100eac:	84 c0                	test   %al,%al
  100eae:	74 12                	je     100ec2 <strcmp+0x48>
  100eb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100eb4:	0f b6 10             	movzbl (%rax),%edx
  100eb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ebb:	0f b6 00             	movzbl (%rax),%eax
  100ebe:	38 c2                	cmp    %al,%dl
  100ec0:	74 ce                	je     100e90 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100ec2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ec6:	0f b6 00             	movzbl (%rax),%eax
  100ec9:	89 c2                	mov    %eax,%edx
  100ecb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ecf:	0f b6 00             	movzbl (%rax),%eax
  100ed2:	38 c2                	cmp    %al,%dl
  100ed4:	0f 97 c0             	seta   %al
  100ed7:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100eda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ede:	0f b6 00             	movzbl (%rax),%eax
  100ee1:	89 c1                	mov    %eax,%ecx
  100ee3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ee7:	0f b6 00             	movzbl (%rax),%eax
  100eea:	38 c1                	cmp    %al,%cl
  100eec:	0f 92 c0             	setb   %al
  100eef:	0f b6 c8             	movzbl %al,%ecx
  100ef2:	89 d0                	mov    %edx,%eax
  100ef4:	29 c8                	sub    %ecx,%eax
}
  100ef6:	c9                   	leave  
  100ef7:	c3                   	ret    

0000000000100ef8 <strchr>:

char* strchr(const char* s, int c) {
  100ef8:	f3 0f 1e fa          	endbr64 
  100efc:	55                   	push   %rbp
  100efd:	48 89 e5             	mov    %rsp,%rbp
  100f00:	48 83 ec 10          	sub    $0x10,%rsp
  100f04:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100f08:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100f0b:	eb 05                	jmp    100f12 <strchr+0x1a>
        ++s;
  100f0d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100f12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100f16:	0f b6 00             	movzbl (%rax),%eax
  100f19:	84 c0                	test   %al,%al
  100f1b:	74 0e                	je     100f2b <strchr+0x33>
  100f1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100f21:	0f b6 00             	movzbl (%rax),%eax
  100f24:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100f27:	38 d0                	cmp    %dl,%al
  100f29:	75 e2                	jne    100f0d <strchr+0x15>
    }
    if (*s == (char) c) {
  100f2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100f2f:	0f b6 00             	movzbl (%rax),%eax
  100f32:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100f35:	38 d0                	cmp    %dl,%al
  100f37:	75 06                	jne    100f3f <strchr+0x47>
        return (char*) s;
  100f39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100f3d:	eb 05                	jmp    100f44 <strchr+0x4c>
    } else {
        return NULL;
  100f3f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100f44:	c9                   	leave  
  100f45:	c3                   	ret    

0000000000100f46 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100f46:	f3 0f 1e fa          	endbr64 
  100f4a:	55                   	push   %rbp
  100f4b:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100f4e:	8b 05 f4 10 00 00    	mov    0x10f4(%rip),%eax        # 102048 <rand_seed_set>
  100f54:	85 c0                	test   %eax,%eax
  100f56:	75 0a                	jne    100f62 <rand+0x1c>
        srand(819234718U);
  100f58:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100f5d:	e8 24 00 00 00       	call   100f86 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100f62:	8b 05 e4 10 00 00    	mov    0x10e4(%rip),%eax        # 10204c <rand_seed>
  100f68:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100f6e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100f73:	89 05 d3 10 00 00    	mov    %eax,0x10d3(%rip)        # 10204c <rand_seed>
    return rand_seed & RAND_MAX;
  100f79:	8b 05 cd 10 00 00    	mov    0x10cd(%rip),%eax        # 10204c <rand_seed>
  100f7f:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100f84:	5d                   	pop    %rbp
  100f85:	c3                   	ret    

0000000000100f86 <srand>:

void srand(unsigned seed) {
  100f86:	f3 0f 1e fa          	endbr64 
  100f8a:	55                   	push   %rbp
  100f8b:	48 89 e5             	mov    %rsp,%rbp
  100f8e:	48 83 ec 08          	sub    $0x8,%rsp
  100f92:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100f95:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100f98:	89 05 ae 10 00 00    	mov    %eax,0x10ae(%rip)        # 10204c <rand_seed>
    rand_seed_set = 1;
  100f9e:	c7 05 a0 10 00 00 01 	movl   $0x1,0x10a0(%rip)        # 102048 <rand_seed_set>
  100fa5:	00 00 00 
}
  100fa8:	90                   	nop
  100fa9:	c9                   	leave  
  100faa:	c3                   	ret    

0000000000100fab <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100fab:	f3 0f 1e fa          	endbr64 
  100faf:	55                   	push   %rbp
  100fb0:	48 89 e5             	mov    %rsp,%rbp
  100fb3:	48 83 ec 28          	sub    $0x28,%rsp
  100fb7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100fbb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100fbf:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100fc2:	48 8d 05 c7 0f 00 00 	lea    0xfc7(%rip),%rax        # 101f90 <upper_digits.1>
  100fc9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  100fcd:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100fd1:	79 0e                	jns    100fe1 <fill_numbuf+0x36>
        digits = lower_digits;
  100fd3:	48 8d 05 d6 0f 00 00 	lea    0xfd6(%rip),%rax        # 101fb0 <lower_digits.0>
  100fda:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  100fde:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100fe1:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100fe6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100fea:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100fed:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100ff0:	48 63 c8             	movslq %eax,%rcx
  100ff3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100ff7:	ba 00 00 00 00       	mov    $0x0,%edx
  100ffc:	48 f7 f1             	div    %rcx
  100fff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101003:	48 01 d0             	add    %rdx,%rax
  101006:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10100b:	0f b6 10             	movzbl (%rax),%edx
  10100e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101012:	88 10                	mov    %dl,(%rax)
        val /= base;
  101014:	8b 45 dc             	mov    -0x24(%rbp),%eax
  101017:	48 63 f0             	movslq %eax,%rsi
  10101a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10101e:	ba 00 00 00 00       	mov    $0x0,%edx
  101023:	48 f7 f6             	div    %rsi
  101026:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  10102a:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  10102f:	75 bc                	jne    100fed <fill_numbuf+0x42>
    return numbuf_end;
  101031:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  101035:	c9                   	leave  
  101036:	c3                   	ret    

0000000000101037 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  101037:	f3 0f 1e fa          	endbr64 
  10103b:	55                   	push   %rbp
  10103c:	48 89 e5             	mov    %rsp,%rbp
  10103f:	53                   	push   %rbx
  101040:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  101047:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  10104e:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  101054:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10105b:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  101062:	e9 bd 09 00 00       	jmp    101a24 <printer_vprintf+0x9ed>
        if (*format != '%') {
  101067:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10106e:	0f b6 00             	movzbl (%rax),%eax
  101071:	3c 25                	cmp    $0x25,%al
  101073:	74 31                	je     1010a6 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  101075:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10107c:	4c 8b 00             	mov    (%rax),%r8
  10107f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101086:	0f b6 00             	movzbl (%rax),%eax
  101089:	0f b6 c8             	movzbl %al,%ecx
  10108c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101092:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101099:	89 ce                	mov    %ecx,%esi
  10109b:	48 89 c7             	mov    %rax,%rdi
  10109e:	41 ff d0             	call   *%r8
            continue;
  1010a1:	e9 76 09 00 00       	jmp    101a1c <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  1010a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1010ad:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1010b4:	01 
  1010b5:	eb 4d                	jmp    101104 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  1010b7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010be:	0f b6 00             	movzbl (%rax),%eax
  1010c1:	0f be c0             	movsbl %al,%eax
  1010c4:	89 c6                	mov    %eax,%esi
  1010c6:	48 8d 05 c3 0d 00 00 	lea    0xdc3(%rip),%rax        # 101e90 <flag_chars>
  1010cd:	48 89 c7             	mov    %rax,%rdi
  1010d0:	e8 23 fe ff ff       	call   100ef8 <strchr>
  1010d5:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1010d9:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1010de:	74 34                	je     101114 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  1010e0:	48 8d 15 a9 0d 00 00 	lea    0xda9(%rip),%rdx        # 101e90 <flag_chars>
  1010e7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  1010eb:	48 29 d0             	sub    %rdx,%rax
  1010ee:	ba 01 00 00 00       	mov    $0x1,%edx
  1010f3:	89 c1                	mov    %eax,%ecx
  1010f5:	d3 e2                	shl    %cl,%edx
  1010f7:	89 d0                	mov    %edx,%eax
  1010f9:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  1010fc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101103:	01 
  101104:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10110b:	0f b6 00             	movzbl (%rax),%eax
  10110e:	84 c0                	test   %al,%al
  101110:	75 a5                	jne    1010b7 <printer_vprintf+0x80>
  101112:	eb 01                	jmp    101115 <printer_vprintf+0xde>
            } else {
                break;
  101114:	90                   	nop
            }
        }

        // process width
        int width = -1;
  101115:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  10111c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101123:	0f b6 00             	movzbl (%rax),%eax
  101126:	3c 30                	cmp    $0x30,%al
  101128:	7e 67                	jle    101191 <printer_vprintf+0x15a>
  10112a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101131:	0f b6 00             	movzbl (%rax),%eax
  101134:	3c 39                	cmp    $0x39,%al
  101136:	7f 59                	jg     101191 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  101138:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  10113f:	eb 2e                	jmp    10116f <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  101141:	8b 55 e8             	mov    -0x18(%rbp),%edx
  101144:	89 d0                	mov    %edx,%eax
  101146:	c1 e0 02             	shl    $0x2,%eax
  101149:	01 d0                	add    %edx,%eax
  10114b:	01 c0                	add    %eax,%eax
  10114d:	89 c1                	mov    %eax,%ecx
  10114f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101156:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10115a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  101161:	0f b6 00             	movzbl (%rax),%eax
  101164:	0f be c0             	movsbl %al,%eax
  101167:	01 c8                	add    %ecx,%eax
  101169:	83 e8 30             	sub    $0x30,%eax
  10116c:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10116f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101176:	0f b6 00             	movzbl (%rax),%eax
  101179:	3c 2f                	cmp    $0x2f,%al
  10117b:	0f 8e 85 00 00 00    	jle    101206 <printer_vprintf+0x1cf>
  101181:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101188:	0f b6 00             	movzbl (%rax),%eax
  10118b:	3c 39                	cmp    $0x39,%al
  10118d:	7e b2                	jle    101141 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  10118f:	eb 75                	jmp    101206 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  101191:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101198:	0f b6 00             	movzbl (%rax),%eax
  10119b:	3c 2a                	cmp    $0x2a,%al
  10119d:	75 68                	jne    101207 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  10119f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011a6:	8b 00                	mov    (%rax),%eax
  1011a8:	83 f8 2f             	cmp    $0x2f,%eax
  1011ab:	77 30                	ja     1011dd <printer_vprintf+0x1a6>
  1011ad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011b4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1011b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011bf:	8b 00                	mov    (%rax),%eax
  1011c1:	89 c0                	mov    %eax,%eax
  1011c3:	48 01 d0             	add    %rdx,%rax
  1011c6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011cd:	8b 12                	mov    (%rdx),%edx
  1011cf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1011d2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011d9:	89 0a                	mov    %ecx,(%rdx)
  1011db:	eb 1a                	jmp    1011f7 <printer_vprintf+0x1c0>
  1011dd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011e4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011e8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1011ec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011f3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011f7:	8b 00                	mov    (%rax),%eax
  1011f9:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  1011fc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101203:	01 
  101204:	eb 01                	jmp    101207 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  101206:	90                   	nop
        }

        // process precision
        int precision = -1;
  101207:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  10120e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101215:	0f b6 00             	movzbl (%rax),%eax
  101218:	3c 2e                	cmp    $0x2e,%al
  10121a:	0f 85 00 01 00 00    	jne    101320 <printer_vprintf+0x2e9>
            ++format;
  101220:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101227:	01 
            if (*format >= '0' && *format <= '9') {
  101228:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10122f:	0f b6 00             	movzbl (%rax),%eax
  101232:	3c 2f                	cmp    $0x2f,%al
  101234:	7e 67                	jle    10129d <printer_vprintf+0x266>
  101236:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10123d:	0f b6 00             	movzbl (%rax),%eax
  101240:	3c 39                	cmp    $0x39,%al
  101242:	7f 59                	jg     10129d <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  101244:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  10124b:	eb 2e                	jmp    10127b <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  10124d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  101250:	89 d0                	mov    %edx,%eax
  101252:	c1 e0 02             	shl    $0x2,%eax
  101255:	01 d0                	add    %edx,%eax
  101257:	01 c0                	add    %eax,%eax
  101259:	89 c1                	mov    %eax,%ecx
  10125b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101262:	48 8d 50 01          	lea    0x1(%rax),%rdx
  101266:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10126d:	0f b6 00             	movzbl (%rax),%eax
  101270:	0f be c0             	movsbl %al,%eax
  101273:	01 c8                	add    %ecx,%eax
  101275:	83 e8 30             	sub    $0x30,%eax
  101278:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10127b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101282:	0f b6 00             	movzbl (%rax),%eax
  101285:	3c 2f                	cmp    $0x2f,%al
  101287:	0f 8e 85 00 00 00    	jle    101312 <printer_vprintf+0x2db>
  10128d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101294:	0f b6 00             	movzbl (%rax),%eax
  101297:	3c 39                	cmp    $0x39,%al
  101299:	7e b2                	jle    10124d <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  10129b:	eb 75                	jmp    101312 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  10129d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1012a4:	0f b6 00             	movzbl (%rax),%eax
  1012a7:	3c 2a                	cmp    $0x2a,%al
  1012a9:	75 68                	jne    101313 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  1012ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012b2:	8b 00                	mov    (%rax),%eax
  1012b4:	83 f8 2f             	cmp    $0x2f,%eax
  1012b7:	77 30                	ja     1012e9 <printer_vprintf+0x2b2>
  1012b9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012c0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1012c4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012cb:	8b 00                	mov    (%rax),%eax
  1012cd:	89 c0                	mov    %eax,%eax
  1012cf:	48 01 d0             	add    %rdx,%rax
  1012d2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012d9:	8b 12                	mov    (%rdx),%edx
  1012db:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1012de:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012e5:	89 0a                	mov    %ecx,(%rdx)
  1012e7:	eb 1a                	jmp    101303 <printer_vprintf+0x2cc>
  1012e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012f0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012f4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1012f8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012ff:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101303:	8b 00                	mov    (%rax),%eax
  101305:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  101308:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10130f:	01 
  101310:	eb 01                	jmp    101313 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  101312:	90                   	nop
            }
            if (precision < 0) {
  101313:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101317:	79 07                	jns    101320 <printer_vprintf+0x2e9>
                precision = 0;
  101319:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  101320:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  101327:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  10132e:	00 
        int length = 0;
  10132f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  101336:	48 8d 05 59 0b 00 00 	lea    0xb59(%rip),%rax        # 101e96 <flag_chars+0x6>
  10133d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  101341:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101348:	0f b6 00             	movzbl (%rax),%eax
  10134b:	0f be c0             	movsbl %al,%eax
  10134e:	83 e8 43             	sub    $0x43,%eax
  101351:	83 f8 37             	cmp    $0x37,%eax
  101354:	0f 87 b6 03 00 00    	ja     101710 <printer_vprintf+0x6d9>
  10135a:	89 c0                	mov    %eax,%eax
  10135c:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  101363:	00 
  101364:	48 8d 05 39 0b 00 00 	lea    0xb39(%rip),%rax        # 101ea4 <flag_chars+0x14>
  10136b:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  10136e:	48 98                	cltq   
  101370:	48 8d 15 2d 0b 00 00 	lea    0xb2d(%rip),%rdx        # 101ea4 <flag_chars+0x14>
  101377:	48 01 d0             	add    %rdx,%rax
  10137a:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  10137d:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  101384:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10138b:	01 
            goto again;
  10138c:	eb b3                	jmp    101341 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10138e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  101392:	74 5d                	je     1013f1 <printer_vprintf+0x3ba>
  101394:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10139b:	8b 00                	mov    (%rax),%eax
  10139d:	83 f8 2f             	cmp    $0x2f,%eax
  1013a0:	77 30                	ja     1013d2 <printer_vprintf+0x39b>
  1013a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013a9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1013ad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013b4:	8b 00                	mov    (%rax),%eax
  1013b6:	89 c0                	mov    %eax,%eax
  1013b8:	48 01 d0             	add    %rdx,%rax
  1013bb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013c2:	8b 12                	mov    (%rdx),%edx
  1013c4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1013c7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013ce:	89 0a                	mov    %ecx,(%rdx)
  1013d0:	eb 1a                	jmp    1013ec <printer_vprintf+0x3b5>
  1013d2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013d9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013dd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1013e1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013e8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1013ec:	48 8b 00             	mov    (%rax),%rax
  1013ef:	eb 5c                	jmp    10144d <printer_vprintf+0x416>
  1013f1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013f8:	8b 00                	mov    (%rax),%eax
  1013fa:	83 f8 2f             	cmp    $0x2f,%eax
  1013fd:	77 30                	ja     10142f <printer_vprintf+0x3f8>
  1013ff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101406:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10140a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101411:	8b 00                	mov    (%rax),%eax
  101413:	89 c0                	mov    %eax,%eax
  101415:	48 01 d0             	add    %rdx,%rax
  101418:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10141f:	8b 12                	mov    (%rdx),%edx
  101421:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101424:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10142b:	89 0a                	mov    %ecx,(%rdx)
  10142d:	eb 1a                	jmp    101449 <printer_vprintf+0x412>
  10142f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101436:	48 8b 40 08          	mov    0x8(%rax),%rax
  10143a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10143e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101445:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101449:	8b 00                	mov    (%rax),%eax
  10144b:	48 98                	cltq   
  10144d:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  101451:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101455:	48 c1 f8 38          	sar    $0x38,%rax
  101459:	25 80 00 00 00       	and    $0x80,%eax
  10145e:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  101461:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  101465:	74 09                	je     101470 <printer_vprintf+0x439>
  101467:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10146b:	48 f7 d8             	neg    %rax
  10146e:	eb 04                	jmp    101474 <printer_vprintf+0x43d>
  101470:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101474:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  101478:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  10147b:	83 c8 60             	or     $0x60,%eax
  10147e:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  101481:	e9 cf 02 00 00       	jmp    101755 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  101486:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  10148a:	74 5d                	je     1014e9 <printer_vprintf+0x4b2>
  10148c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101493:	8b 00                	mov    (%rax),%eax
  101495:	83 f8 2f             	cmp    $0x2f,%eax
  101498:	77 30                	ja     1014ca <printer_vprintf+0x493>
  10149a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014a1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1014a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014ac:	8b 00                	mov    (%rax),%eax
  1014ae:	89 c0                	mov    %eax,%eax
  1014b0:	48 01 d0             	add    %rdx,%rax
  1014b3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014ba:	8b 12                	mov    (%rdx),%edx
  1014bc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1014bf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014c6:	89 0a                	mov    %ecx,(%rdx)
  1014c8:	eb 1a                	jmp    1014e4 <printer_vprintf+0x4ad>
  1014ca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014d1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014d5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1014d9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014e0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1014e4:	48 8b 00             	mov    (%rax),%rax
  1014e7:	eb 5c                	jmp    101545 <printer_vprintf+0x50e>
  1014e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014f0:	8b 00                	mov    (%rax),%eax
  1014f2:	83 f8 2f             	cmp    $0x2f,%eax
  1014f5:	77 30                	ja     101527 <printer_vprintf+0x4f0>
  1014f7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014fe:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101502:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101509:	8b 00                	mov    (%rax),%eax
  10150b:	89 c0                	mov    %eax,%eax
  10150d:	48 01 d0             	add    %rdx,%rax
  101510:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101517:	8b 12                	mov    (%rdx),%edx
  101519:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10151c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101523:	89 0a                	mov    %ecx,(%rdx)
  101525:	eb 1a                	jmp    101541 <printer_vprintf+0x50a>
  101527:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10152e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101532:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101536:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10153d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101541:	8b 00                	mov    (%rax),%eax
  101543:	89 c0                	mov    %eax,%eax
  101545:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  101549:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  10154d:	e9 03 02 00 00       	jmp    101755 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  101552:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  101559:	e9 28 ff ff ff       	jmp    101486 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  10155e:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  101565:	e9 1c ff ff ff       	jmp    101486 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  10156a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101571:	8b 00                	mov    (%rax),%eax
  101573:	83 f8 2f             	cmp    $0x2f,%eax
  101576:	77 30                	ja     1015a8 <printer_vprintf+0x571>
  101578:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10157f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101583:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10158a:	8b 00                	mov    (%rax),%eax
  10158c:	89 c0                	mov    %eax,%eax
  10158e:	48 01 d0             	add    %rdx,%rax
  101591:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101598:	8b 12                	mov    (%rdx),%edx
  10159a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10159d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1015a4:	89 0a                	mov    %ecx,(%rdx)
  1015a6:	eb 1a                	jmp    1015c2 <printer_vprintf+0x58b>
  1015a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1015af:	48 8b 40 08          	mov    0x8(%rax),%rax
  1015b3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1015b7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1015be:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1015c2:	48 8b 00             	mov    (%rax),%rax
  1015c5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1015c9:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1015d0:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  1015d7:	e9 79 01 00 00       	jmp    101755 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  1015dc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1015e3:	8b 00                	mov    (%rax),%eax
  1015e5:	83 f8 2f             	cmp    $0x2f,%eax
  1015e8:	77 30                	ja     10161a <printer_vprintf+0x5e3>
  1015ea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1015f1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1015f5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1015fc:	8b 00                	mov    (%rax),%eax
  1015fe:	89 c0                	mov    %eax,%eax
  101600:	48 01 d0             	add    %rdx,%rax
  101603:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10160a:	8b 12                	mov    (%rdx),%edx
  10160c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10160f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101616:	89 0a                	mov    %ecx,(%rdx)
  101618:	eb 1a                	jmp    101634 <printer_vprintf+0x5fd>
  10161a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101621:	48 8b 40 08          	mov    0x8(%rax),%rax
  101625:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101629:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101630:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101634:	48 8b 00             	mov    (%rax),%rax
  101637:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  10163b:	e9 15 01 00 00       	jmp    101755 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  101640:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101647:	8b 00                	mov    (%rax),%eax
  101649:	83 f8 2f             	cmp    $0x2f,%eax
  10164c:	77 30                	ja     10167e <printer_vprintf+0x647>
  10164e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101655:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101659:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101660:	8b 00                	mov    (%rax),%eax
  101662:	89 c0                	mov    %eax,%eax
  101664:	48 01 d0             	add    %rdx,%rax
  101667:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10166e:	8b 12                	mov    (%rdx),%edx
  101670:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101673:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10167a:	89 0a                	mov    %ecx,(%rdx)
  10167c:	eb 1a                	jmp    101698 <printer_vprintf+0x661>
  10167e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101685:	48 8b 40 08          	mov    0x8(%rax),%rax
  101689:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10168d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101694:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101698:	8b 00                	mov    (%rax),%eax
  10169a:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  1016a0:	e9 77 03 00 00       	jmp    101a1c <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  1016a5:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1016a9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  1016ad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1016b4:	8b 00                	mov    (%rax),%eax
  1016b6:	83 f8 2f             	cmp    $0x2f,%eax
  1016b9:	77 30                	ja     1016eb <printer_vprintf+0x6b4>
  1016bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1016c2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1016c6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1016cd:	8b 00                	mov    (%rax),%eax
  1016cf:	89 c0                	mov    %eax,%eax
  1016d1:	48 01 d0             	add    %rdx,%rax
  1016d4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1016db:	8b 12                	mov    (%rdx),%edx
  1016dd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1016e0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1016e7:	89 0a                	mov    %ecx,(%rdx)
  1016e9:	eb 1a                	jmp    101705 <printer_vprintf+0x6ce>
  1016eb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1016f2:	48 8b 40 08          	mov    0x8(%rax),%rax
  1016f6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1016fa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101701:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101705:	8b 00                	mov    (%rax),%eax
  101707:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10170a:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  10170e:	eb 45                	jmp    101755 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  101710:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101714:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  101718:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10171f:	0f b6 00             	movzbl (%rax),%eax
  101722:	84 c0                	test   %al,%al
  101724:	74 0c                	je     101732 <printer_vprintf+0x6fb>
  101726:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10172d:	0f b6 00             	movzbl (%rax),%eax
  101730:	eb 05                	jmp    101737 <printer_vprintf+0x700>
  101732:	b8 25 00 00 00       	mov    $0x25,%eax
  101737:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10173a:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  10173e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101745:	0f b6 00             	movzbl (%rax),%eax
  101748:	84 c0                	test   %al,%al
  10174a:	75 08                	jne    101754 <printer_vprintf+0x71d>
                format--;
  10174c:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  101753:	01 
            }
            break;
  101754:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  101755:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101758:	83 e0 20             	and    $0x20,%eax
  10175b:	85 c0                	test   %eax,%eax
  10175d:	74 1e                	je     10177d <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  10175f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101763:	48 83 c0 18          	add    $0x18,%rax
  101767:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10176a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10176e:	48 89 ce             	mov    %rcx,%rsi
  101771:	48 89 c7             	mov    %rax,%rdi
  101774:	e8 32 f8 ff ff       	call   100fab <fill_numbuf>
  101779:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  10177d:	48 8d 05 12 07 00 00 	lea    0x712(%rip),%rax        # 101e96 <flag_chars+0x6>
  101784:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  101788:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10178b:	83 e0 20             	and    $0x20,%eax
  10178e:	85 c0                	test   %eax,%eax
  101790:	74 51                	je     1017e3 <printer_vprintf+0x7ac>
  101792:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101795:	83 e0 40             	and    $0x40,%eax
  101798:	85 c0                	test   %eax,%eax
  10179a:	74 47                	je     1017e3 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  10179c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10179f:	25 80 00 00 00       	and    $0x80,%eax
  1017a4:	85 c0                	test   %eax,%eax
  1017a6:	74 0d                	je     1017b5 <printer_vprintf+0x77e>
                prefix = "-";
  1017a8:	48 8d 05 e8 06 00 00 	lea    0x6e8(%rip),%rax        # 101e97 <flag_chars+0x7>
  1017af:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1017b3:	eb 7d                	jmp    101832 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1017b5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1017b8:	83 e0 10             	and    $0x10,%eax
  1017bb:	85 c0                	test   %eax,%eax
  1017bd:	74 0d                	je     1017cc <printer_vprintf+0x795>
                prefix = "+";
  1017bf:	48 8d 05 d3 06 00 00 	lea    0x6d3(%rip),%rax        # 101e99 <flag_chars+0x9>
  1017c6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1017ca:	eb 66                	jmp    101832 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  1017cc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1017cf:	83 e0 08             	and    $0x8,%eax
  1017d2:	85 c0                	test   %eax,%eax
  1017d4:	74 5c                	je     101832 <printer_vprintf+0x7fb>
                prefix = " ";
  1017d6:	48 8d 05 be 06 00 00 	lea    0x6be(%rip),%rax        # 101e9b <flag_chars+0xb>
  1017dd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1017e1:	eb 4f                	jmp    101832 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1017e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1017e6:	83 e0 20             	and    $0x20,%eax
  1017e9:	85 c0                	test   %eax,%eax
  1017eb:	74 46                	je     101833 <printer_vprintf+0x7fc>
  1017ed:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1017f0:	83 e0 01             	and    $0x1,%eax
  1017f3:	85 c0                	test   %eax,%eax
  1017f5:	74 3c                	je     101833 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  1017f7:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1017fb:	74 06                	je     101803 <printer_vprintf+0x7cc>
  1017fd:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101801:	75 30                	jne    101833 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  101803:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  101808:	75 0c                	jne    101816 <printer_vprintf+0x7df>
  10180a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10180d:	25 00 01 00 00       	and    $0x100,%eax
  101812:	85 c0                	test   %eax,%eax
  101814:	74 1d                	je     101833 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  101816:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  10181a:	75 09                	jne    101825 <printer_vprintf+0x7ee>
  10181c:	48 8d 05 7a 06 00 00 	lea    0x67a(%rip),%rax        # 101e9d <flag_chars+0xd>
  101823:	eb 07                	jmp    10182c <printer_vprintf+0x7f5>
  101825:	48 8d 05 74 06 00 00 	lea    0x674(%rip),%rax        # 101ea0 <flag_chars+0x10>
  10182c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101830:	eb 01                	jmp    101833 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  101832:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  101833:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101837:	78 24                	js     10185d <printer_vprintf+0x826>
  101839:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10183c:	83 e0 20             	and    $0x20,%eax
  10183f:	85 c0                	test   %eax,%eax
  101841:	75 1a                	jne    10185d <printer_vprintf+0x826>
            len = strnlen(data, precision);
  101843:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101846:	48 63 d0             	movslq %eax,%rdx
  101849:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10184d:	48 89 d6             	mov    %rdx,%rsi
  101850:	48 89 c7             	mov    %rax,%rdi
  101853:	e8 91 f5 ff ff       	call   100de9 <strnlen>
  101858:	89 45 bc             	mov    %eax,-0x44(%rbp)
  10185b:	eb 0f                	jmp    10186c <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  10185d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101861:	48 89 c7             	mov    %rax,%rdi
  101864:	e8 4b f5 ff ff       	call   100db4 <strlen>
  101869:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  10186c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10186f:	83 e0 20             	and    $0x20,%eax
  101872:	85 c0                	test   %eax,%eax
  101874:	74 20                	je     101896 <printer_vprintf+0x85f>
  101876:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10187a:	78 1a                	js     101896 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  10187c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10187f:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101882:	7e 08                	jle    10188c <printer_vprintf+0x855>
  101884:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101887:	2b 45 bc             	sub    -0x44(%rbp),%eax
  10188a:	eb 05                	jmp    101891 <printer_vprintf+0x85a>
  10188c:	b8 00 00 00 00       	mov    $0x0,%eax
  101891:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101894:	eb 5c                	jmp    1018f2 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  101896:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101899:	83 e0 20             	and    $0x20,%eax
  10189c:	85 c0                	test   %eax,%eax
  10189e:	74 4b                	je     1018eb <printer_vprintf+0x8b4>
  1018a0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1018a3:	83 e0 02             	and    $0x2,%eax
  1018a6:	85 c0                	test   %eax,%eax
  1018a8:	74 41                	je     1018eb <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1018aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1018ad:	83 e0 04             	and    $0x4,%eax
  1018b0:	85 c0                	test   %eax,%eax
  1018b2:	75 37                	jne    1018eb <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  1018b4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1018b8:	48 89 c7             	mov    %rax,%rdi
  1018bb:	e8 f4 f4 ff ff       	call   100db4 <strlen>
  1018c0:	89 c2                	mov    %eax,%edx
  1018c2:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1018c5:	01 d0                	add    %edx,%eax
  1018c7:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  1018ca:	7e 1f                	jle    1018eb <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  1018cc:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1018cf:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1018d2:	89 c3                	mov    %eax,%ebx
  1018d4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1018d8:	48 89 c7             	mov    %rax,%rdi
  1018db:	e8 d4 f4 ff ff       	call   100db4 <strlen>
  1018e0:	89 c2                	mov    %eax,%edx
  1018e2:	89 d8                	mov    %ebx,%eax
  1018e4:	29 d0                	sub    %edx,%eax
  1018e6:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1018e9:	eb 07                	jmp    1018f2 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  1018eb:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  1018f2:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1018f5:	8b 45 b8             	mov    -0x48(%rbp),%eax
  1018f8:	01 d0                	add    %edx,%eax
  1018fa:	48 63 d8             	movslq %eax,%rbx
  1018fd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101901:	48 89 c7             	mov    %rax,%rdi
  101904:	e8 ab f4 ff ff       	call   100db4 <strlen>
  101909:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  10190d:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101910:	29 d0                	sub    %edx,%eax
  101912:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101915:	eb 25                	jmp    10193c <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  101917:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10191e:	48 8b 08             	mov    (%rax),%rcx
  101921:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101927:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10192e:	be 20 00 00 00       	mov    $0x20,%esi
  101933:	48 89 c7             	mov    %rax,%rdi
  101936:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101938:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10193c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10193f:	83 e0 04             	and    $0x4,%eax
  101942:	85 c0                	test   %eax,%eax
  101944:	75 36                	jne    10197c <printer_vprintf+0x945>
  101946:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10194a:	7f cb                	jg     101917 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  10194c:	eb 2e                	jmp    10197c <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  10194e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101955:	4c 8b 00             	mov    (%rax),%r8
  101958:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10195c:	0f b6 00             	movzbl (%rax),%eax
  10195f:	0f b6 c8             	movzbl %al,%ecx
  101962:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101968:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10196f:	89 ce                	mov    %ecx,%esi
  101971:	48 89 c7             	mov    %rax,%rdi
  101974:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101977:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  10197c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101980:	0f b6 00             	movzbl (%rax),%eax
  101983:	84 c0                	test   %al,%al
  101985:	75 c7                	jne    10194e <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  101987:	eb 25                	jmp    1019ae <printer_vprintf+0x977>
            p->putc(p, '0', color);
  101989:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101990:	48 8b 08             	mov    (%rax),%rcx
  101993:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101999:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1019a0:	be 30 00 00 00       	mov    $0x30,%esi
  1019a5:	48 89 c7             	mov    %rax,%rdi
  1019a8:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1019aa:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1019ae:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1019b2:	7f d5                	jg     101989 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  1019b4:	eb 32                	jmp    1019e8 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  1019b6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1019bd:	4c 8b 00             	mov    (%rax),%r8
  1019c0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1019c4:	0f b6 00             	movzbl (%rax),%eax
  1019c7:	0f b6 c8             	movzbl %al,%ecx
  1019ca:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1019d0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1019d7:	89 ce                	mov    %ecx,%esi
  1019d9:	48 89 c7             	mov    %rax,%rdi
  1019dc:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  1019df:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  1019e4:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  1019e8:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  1019ec:	7f c8                	jg     1019b6 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  1019ee:	eb 25                	jmp    101a15 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  1019f0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1019f7:	48 8b 08             	mov    (%rax),%rcx
  1019fa:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101a00:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101a07:	be 20 00 00 00       	mov    $0x20,%esi
  101a0c:	48 89 c7             	mov    %rax,%rdi
  101a0f:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101a11:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101a15:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101a19:	7f d5                	jg     1019f0 <printer_vprintf+0x9b9>
        }
    done: ;
  101a1b:	90                   	nop
    for (; *format; ++format) {
  101a1c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101a23:	01 
  101a24:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101a2b:	0f b6 00             	movzbl (%rax),%eax
  101a2e:	84 c0                	test   %al,%al
  101a30:	0f 85 31 f6 ff ff    	jne    101067 <printer_vprintf+0x30>
    }
}
  101a36:	90                   	nop
  101a37:	90                   	nop
  101a38:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101a3c:	c9                   	leave  
  101a3d:	c3                   	ret    

0000000000101a3e <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101a3e:	f3 0f 1e fa          	endbr64 
  101a42:	55                   	push   %rbp
  101a43:	48 89 e5             	mov    %rsp,%rbp
  101a46:	48 83 ec 20          	sub    $0x20,%rsp
  101a4a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101a4e:	89 f0                	mov    %esi,%eax
  101a50:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101a53:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101a56:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101a5a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101a5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101a62:	48 8b 40 08          	mov    0x8(%rax),%rax
  101a66:	48 8d 15 33 75 fb ff 	lea    -0x48acd(%rip),%rdx        # b8fa0 <console+0xfa0>
  101a6d:	48 39 d0             	cmp    %rdx,%rax
  101a70:	72 0f                	jb     101a81 <console_putc+0x43>
        cp->cursor = console;
  101a72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101a76:	48 8d 15 83 65 fb ff 	lea    -0x49a7d(%rip),%rdx        # b8000 <console>
  101a7d:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  101a81:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101a85:	0f 85 82 00 00 00    	jne    101b0d <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  101a8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101a8f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101a93:	48 8d 15 66 65 fb ff 	lea    -0x49a9a(%rip),%rdx        # b8000 <console>
  101a9a:	48 29 d0             	sub    %rdx,%rax
  101a9d:	48 d1 f8             	sar    %rax
  101aa0:	48 89 c1             	mov    %rax,%rcx
  101aa3:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101aaa:	66 66 66 
  101aad:	48 89 c8             	mov    %rcx,%rax
  101ab0:	48 f7 ea             	imul   %rdx
  101ab3:	48 89 d0             	mov    %rdx,%rax
  101ab6:	48 c1 f8 05          	sar    $0x5,%rax
  101aba:	48 89 ce             	mov    %rcx,%rsi
  101abd:	48 c1 fe 3f          	sar    $0x3f,%rsi
  101ac1:	48 29 f0             	sub    %rsi,%rax
  101ac4:	48 89 c2             	mov    %rax,%rdx
  101ac7:	48 89 d0             	mov    %rdx,%rax
  101aca:	48 c1 e0 02          	shl    $0x2,%rax
  101ace:	48 01 d0             	add    %rdx,%rax
  101ad1:	48 c1 e0 04          	shl    $0x4,%rax
  101ad5:	48 29 c1             	sub    %rax,%rcx
  101ad8:	48 89 ca             	mov    %rcx,%rdx
  101adb:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101ade:	eb 25                	jmp    101b05 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  101ae0:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101ae3:	83 c8 20             	or     $0x20,%eax
  101ae6:	89 c6                	mov    %eax,%esi
  101ae8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101aec:	48 8b 40 08          	mov    0x8(%rax),%rax
  101af0:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101af4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101af8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101afc:	89 f2                	mov    %esi,%edx
  101afe:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101b01:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101b05:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101b09:	75 d5                	jne    101ae0 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101b0b:	eb 24                	jmp    101b31 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  101b0d:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101b11:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101b14:	89 d6                	mov    %edx,%esi
  101b16:	09 c6                	or     %eax,%esi
  101b18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101b1c:	48 8b 40 08          	mov    0x8(%rax),%rax
  101b20:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101b24:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101b28:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101b2c:	89 f2                	mov    %esi,%edx
  101b2e:	66 89 10             	mov    %dx,(%rax)
}
  101b31:	90                   	nop
  101b32:	c9                   	leave  
  101b33:	c3                   	ret    

0000000000101b34 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101b34:	f3 0f 1e fa          	endbr64 
  101b38:	55                   	push   %rbp
  101b39:	48 89 e5             	mov    %rsp,%rbp
  101b3c:	48 83 ec 30          	sub    $0x30,%rsp
  101b40:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101b43:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101b46:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101b4a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101b4e:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 101a3e <console_putc>
  101b55:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101b59:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101b5d:	78 09                	js     101b68 <console_vprintf+0x34>
  101b5f:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101b66:	7e 07                	jle    101b6f <console_vprintf+0x3b>
        cpos = 0;
  101b68:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101b6f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101b72:	48 98                	cltq   
  101b74:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101b78:	48 8d 05 81 64 fb ff 	lea    -0x49b7f(%rip),%rax        # b8000 <console>
  101b7f:	48 01 d0             	add    %rdx,%rax
  101b82:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101b86:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101b8a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101b8e:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101b91:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101b95:	48 89 c7             	mov    %rax,%rdi
  101b98:	e8 9a f4 ff ff       	call   101037 <printer_vprintf>
    return cp.cursor - console;
  101b9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101ba1:	48 8d 15 58 64 fb ff 	lea    -0x49ba8(%rip),%rdx        # b8000 <console>
  101ba8:	48 29 d0             	sub    %rdx,%rax
  101bab:	48 d1 f8             	sar    %rax
}
  101bae:	c9                   	leave  
  101baf:	c3                   	ret    

0000000000101bb0 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101bb0:	f3 0f 1e fa          	endbr64 
  101bb4:	55                   	push   %rbp
  101bb5:	48 89 e5             	mov    %rsp,%rbp
  101bb8:	48 83 ec 60          	sub    $0x60,%rsp
  101bbc:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101bbf:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101bc2:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101bc6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101bca:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101bce:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101bd2:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101bd9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101bdd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101be1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101be5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101be9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101bed:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101bf1:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101bf4:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101bf7:	89 c7                	mov    %eax,%edi
  101bf9:	e8 36 ff ff ff       	call   101b34 <console_vprintf>
  101bfe:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101c01:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101c04:	c9                   	leave  
  101c05:	c3                   	ret    

0000000000101c06 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101c06:	f3 0f 1e fa          	endbr64 
  101c0a:	55                   	push   %rbp
  101c0b:	48 89 e5             	mov    %rsp,%rbp
  101c0e:	48 83 ec 20          	sub    $0x20,%rsp
  101c12:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101c16:	89 f0                	mov    %esi,%eax
  101c18:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101c1b:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101c1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101c22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101c26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101c2a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101c2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101c32:	48 8b 40 10          	mov    0x10(%rax),%rax
  101c36:	48 39 c2             	cmp    %rax,%rdx
  101c39:	73 1a                	jae    101c55 <string_putc+0x4f>
        *sp->s++ = c;
  101c3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101c3f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101c43:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101c47:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101c4b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101c4f:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101c53:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101c55:	90                   	nop
  101c56:	c9                   	leave  
  101c57:	c3                   	ret    

0000000000101c58 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101c58:	f3 0f 1e fa          	endbr64 
  101c5c:	55                   	push   %rbp
  101c5d:	48 89 e5             	mov    %rsp,%rbp
  101c60:	48 83 ec 40          	sub    $0x40,%rsp
  101c64:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101c68:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101c6c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101c70:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101c74:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 101c06 <string_putc>
  101c7b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  101c7f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101c83:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101c87:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101c8c:	74 33                	je     101cc1 <vsnprintf+0x69>
        sp.end = s + size - 1;
  101c8e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101c92:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101c96:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101c9a:	48 01 d0             	add    %rdx,%rax
  101c9d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101ca1:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101ca5:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101ca9:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101cad:	be 00 00 00 00       	mov    $0x0,%esi
  101cb2:	48 89 c7             	mov    %rax,%rdi
  101cb5:	e8 7d f3 ff ff       	call   101037 <printer_vprintf>
        *sp.s = 0;
  101cba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101cbe:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101cc1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101cc5:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101cc9:	c9                   	leave  
  101cca:	c3                   	ret    

0000000000101ccb <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101ccb:	f3 0f 1e fa          	endbr64 
  101ccf:	55                   	push   %rbp
  101cd0:	48 89 e5             	mov    %rsp,%rbp
  101cd3:	48 83 ec 70          	sub    $0x70,%rsp
  101cd7:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101cdb:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101cdf:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101ce3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101ce7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101ceb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101cef:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101cf6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101cfa:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101cfe:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101d02:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101d06:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101d0a:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101d0e:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101d12:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101d16:	48 89 c7             	mov    %rax,%rdi
  101d19:	e8 3a ff ff ff       	call   101c58 <vsnprintf>
  101d1e:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101d21:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101d24:	c9                   	leave  
  101d25:	c3                   	ret    

0000000000101d26 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101d26:	f3 0f 1e fa          	endbr64 
  101d2a:	55                   	push   %rbp
  101d2b:	48 89 e5             	mov    %rsp,%rbp
  101d2e:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101d32:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101d39:	eb 1a                	jmp    101d55 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101d3b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101d3e:	48 98                	cltq   
  101d40:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101d44:	48 8d 05 b5 62 fb ff 	lea    -0x49d4b(%rip),%rax        # b8000 <console>
  101d4b:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101d51:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101d55:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101d5c:	7e dd                	jle    101d3b <console_clear+0x15>
    }
    cursorpos = 0;
  101d5e:	c7 05 94 72 fb ff 00 	movl   $0x0,-0x48d6c(%rip)        # b8ffc <cursorpos>
  101d65:	00 00 00 
}
  101d68:	90                   	nop
  101d69:	c9                   	leave  
  101d6a:	c3                   	ret    
