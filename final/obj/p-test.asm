
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
  100008:	41 55                	push   %r13
  10000a:	41 54                	push   %r12
  10000c:	53                   	push   %rbx
  10000d:	48 83 ec 68          	sub    $0x68,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100011:	cd 31                	int    $0x31
  100013:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  100015:	e8 0a 08 00 00       	call   100824 <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10001a:	48 8d 05 0e 30 00 00 	lea    0x300e(%rip),%rax        # 10302f <end+0xfff>
  100021:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100027:	48 89 05 e2 1f 00 00 	mov    %rax,0x1fe2(%rip)        # 102010 <heap_top>
  10002e:	48 89 05 d3 1f 00 00 	mov    %rax,0x1fd3(%rip)        # 102008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100035:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100038:	48 83 e8 01          	sub    $0x1,%rax
  10003c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100042:	48 89 05 b7 1f 00 00 	mov    %rax,0x1fb7(%rip)        # 102000 <stack_bottom>


    heap_info_struct h1, h2, h3;

    void* ptr = malloc(16384);
  100049:	bf 00 40 00 00       	mov    $0x4000,%edi
  10004e:	e8 48 03 00 00       	call   10039b <malloc>
  100053:	49 89 c5             	mov    %rax,%r13
    void * ptr2 = malloc(10);
  100056:	bf 0a 00 00 00       	mov    $0xa,%edi
  10005b:	e8 3b 03 00 00       	call   10039b <malloc>
  100060:	49 89 c4             	mov    %rax,%r12
    void * ptr3 = malloc(10);
  100063:	bf 0a 00 00 00       	mov    $0xa,%edi
  100068:	e8 2e 03 00 00       	call   10039b <malloc>
  10006d:	48 89 c3             	mov    %rax,%rbx

    heap_info(&h1);
  100070:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  100074:	e8 86 04 00 00       	call   1004ff <heap_info>

    free(ptr);
  100079:	4c 89 ef             	mov    %r13,%rdi
  10007c:	e8 09 03 00 00       	call   10038a <free>
    free(ptr2);
  100081:	4c 89 e7             	mov    %r12,%rdi
  100084:	e8 01 03 00 00       	call   10038a <free>
    free(ptr3);
  100089:	48 89 df             	mov    %rbx,%rdi
  10008c:	e8 f9 02 00 00       	call   10038a <free>

    free(h1.size_array);
  100091:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  100095:	e8 f0 02 00 00       	call   10038a <free>
    free(h1.ptr_array);
  10009a:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
  10009e:	e8 e7 02 00 00       	call   10038a <free>
    
    heap_info(&h2);
  1000a3:	48 8d 7d a0          	lea    -0x60(%rbp),%rdi
  1000a7:	e8 53 04 00 00       	call   1004ff <heap_info>

    free(h2.size_array);
  1000ac:	48 8b 7d a8          	mov    -0x58(%rbp),%rdi
  1000b0:	e8 d5 02 00 00       	call   10038a <free>
    free(h2.ptr_array);
  1000b5:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
  1000b9:	e8 cc 02 00 00       	call   10038a <free>

    defrag();
  1000be:	b8 00 00 00 00       	mov    $0x0,%eax
  1000c3:	e8 f2 03 00 00       	call   1004ba <defrag>
    heap_info(&h3);
  1000c8:	48 8d 7d 80          	lea    -0x80(%rbp),%rdi
  1000cc:	e8 2e 04 00 00       	call   1004ff <heap_info>

    assert(h3.largest_free_chunk > h2.largest_free_chunk);
  1000d1:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1000d4:	39 45 9c             	cmp    %eax,-0x64(%rbp)
  1000d7:	7f 18                	jg     1000f1 <process_main+0xf1>
  1000d9:	48 8d 15 30 15 00 00 	lea    0x1530(%rip),%rdx        # 101610 <console_clear+0x4c>
  1000e0:	be 29 00 00 00       	mov    $0x29,%esi
  1000e5:	48 8d 3d 52 15 00 00 	lea    0x1552(%rip),%rdi        # 10163e <console_clear+0x7a>
  1000ec:	e8 97 01 00 00       	call   100288 <assert_fail>

    app_printf(0, "DEFRAG PASS\n");
  1000f1:	48 8d 35 56 15 00 00 	lea    0x1556(%rip),%rsi        # 10164e <console_clear+0x8a>
  1000f8:	bf 00 00 00 00       	mov    $0x0,%edi
  1000fd:	b8 00 00 00 00       	mov    $0x0,%eax
  100102:	e8 11 00 00 00       	call   100118 <app_printf>
    TEST_PASS();
  100107:	48 8d 3d 4d 15 00 00 	lea    0x154d(%rip),%rdi        # 10165b <console_clear+0x97>
  10010e:	b8 00 00 00 00       	mov    $0x0,%eax
  100113:	e8 98 00 00 00       	call   1001b0 <kernel_panic>

0000000000100118 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100118:	f3 0f 1e fa          	endbr64 
  10011c:	55                   	push   %rbp
  10011d:	48 89 e5             	mov    %rsp,%rbp
  100120:	48 83 ec 50          	sub    $0x50,%rsp
  100124:	49 89 f2             	mov    %rsi,%r10
  100127:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10012b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10012f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100133:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100137:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  10013c:	85 ff                	test   %edi,%edi
  10013e:	78 32                	js     100172 <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100140:	48 63 ff             	movslq %edi,%rdi
  100143:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  10014a:	cc cc cc 
  10014d:	48 89 f8             	mov    %rdi,%rax
  100150:	48 f7 e2             	mul    %rdx
  100153:	48 89 d0             	mov    %rdx,%rax
  100156:	48 c1 e8 02          	shr    $0x2,%rax
  10015a:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  10015e:	48 01 c2             	add    %rax,%rdx
  100161:	48 29 d7             	sub    %rdx,%rdi
  100164:	48 8d 05 42 15 00 00 	lea    0x1542(%rip),%rax        # 1016ad <col.0>
  10016b:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  10016f:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100172:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100179:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10017d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100181:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100185:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100189:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10018d:	4c 89 d2             	mov    %r10,%rdx
  100190:	8b 3d 66 8e fb ff    	mov    -0x4719a(%rip),%edi        # b8ffc <cursorpos>
  100196:	e8 37 12 00 00       	call   1013d2 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  10019b:	3d 30 07 00 00       	cmp    $0x730,%eax
  1001a0:	ba 00 00 00 00       	mov    $0x0,%edx
  1001a5:	0f 4d c2             	cmovge %edx,%eax
  1001a8:	89 05 4e 8e fb ff    	mov    %eax,-0x471b2(%rip)        # b8ffc <cursorpos>
    }
}
  1001ae:	c9                   	leave  
  1001af:	c3                   	ret    

00000000001001b0 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  1001b0:	f3 0f 1e fa          	endbr64 
  1001b4:	55                   	push   %rbp
  1001b5:	48 89 e5             	mov    %rsp,%rbp
  1001b8:	53                   	push   %rbx
  1001b9:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  1001c0:	48 89 fb             	mov    %rdi,%rbx
  1001c3:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  1001c7:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  1001cb:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  1001cf:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  1001d3:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  1001d7:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1001de:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1001e2:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1001e6:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1001ea:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  1001ee:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1001f5:	ba 07 00 00 00       	mov    $0x7,%edx
  1001fa:	48 8d 35 75 14 00 00 	lea    0x1475(%rip),%rsi        # 101676 <console_clear+0xb2>
  100201:	e8 03 03 00 00       	call   100509 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100206:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  10020a:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100211:	48 89 da             	mov    %rbx,%rdx
  100214:	be 99 00 00 00       	mov    $0x99,%esi
  100219:	e8 d8 12 00 00       	call   1014f6 <vsnprintf>
  10021e:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100221:	85 d2                	test   %edx,%edx
  100223:	7e 0f                	jle    100234 <kernel_panic+0x84>
  100225:	83 c0 06             	add    $0x6,%eax
  100228:	48 98                	cltq   
  10022a:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100231:	0a 
  100232:	75 2c                	jne    100260 <kernel_panic+0xb0>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100234:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  10023b:	48 89 d9             	mov    %rbx,%rcx
  10023e:	48 8d 15 39 14 00 00 	lea    0x1439(%rip),%rdx        # 10167e <console_clear+0xba>
  100245:	be 00 c0 00 00       	mov    $0xc000,%esi
  10024a:	bf 30 07 00 00       	mov    $0x730,%edi
  10024f:	b8 00 00 00 00       	mov    $0x0,%eax
  100254:	e8 f5 11 00 00       	call   10144e <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100259:	48 89 df             	mov    %rbx,%rdi
  10025c:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  10025e:	eb fe                	jmp    10025e <kernel_panic+0xae>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100260:	48 63 c2             	movslq %edx,%rax
  100263:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100269:	0f 94 c2             	sete   %dl
  10026c:	0f b6 d2             	movzbl %dl,%edx
  10026f:	48 29 d0             	sub    %rdx,%rax
  100272:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100279:	ff 
  10027a:	48 8d 35 d8 13 00 00 	lea    0x13d8(%rip),%rsi        # 101659 <console_clear+0x95>
  100281:	e8 44 04 00 00       	call   1006ca <strcpy>
  100286:	eb ac                	jmp    100234 <kernel_panic+0x84>

0000000000100288 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100288:	f3 0f 1e fa          	endbr64 
  10028c:	55                   	push   %rbp
  10028d:	48 89 e5             	mov    %rsp,%rbp
  100290:	48 89 f9             	mov    %rdi,%rcx
  100293:	41 89 f0             	mov    %esi,%r8d
  100296:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100299:	48 8d 15 e8 13 00 00 	lea    0x13e8(%rip),%rdx        # 101688 <console_clear+0xc4>
  1002a0:	be 00 c0 00 00       	mov    $0xc000,%esi
  1002a5:	bf 30 07 00 00       	mov    $0x730,%edi
  1002aa:	b8 00 00 00 00       	mov    $0x0,%eax
  1002af:	e8 9a 11 00 00       	call   10144e <console_printf>
    asm volatile ("int %0" : /* no result */
  1002b4:	bf 00 00 00 00       	mov    $0x0,%edi
  1002b9:	cd 30                	int    $0x30
 loop: goto loop;
  1002bb:	eb fe                	jmp    1002bb <assert_fail+0x33>

00000000001002bd <algn>:
block* find_block(size_t size);
block* new_block(size_t size);
block* split_block(block* block, size_t size);


size_t algn(size_t size){
  1002bd:	f3 0f 1e fa          	endbr64 
    return (size + 7) / 8 * 8;
  1002c1:	48 8d 47 07          	lea    0x7(%rdi),%rax
  1002c5:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
}
  1002c9:	c3                   	ret    

00000000001002ca <new_block>:
block* new_block(size_t size){
  1002ca:	f3 0f 1e fa          	endbr64 
  1002ce:	48 89 fa             	mov    %rdi,%rdx
    // get program break
    void *bptr = sbrk(size + sizeof(block));
  1002d1:	48 8d 7f 18          	lea    0x18(%rdi),%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1002d5:	cd 3a                	int    $0x3a
  1002d7:	48 89 05 3a 1d 00 00 	mov    %rax,0x1d3a(%rip)        # 102018 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  1002de:	48 89 c6             	mov    %rax,%rsi
    if (bptr == (void*) -1) {
  1002e1:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1002e5:	74 3b                	je     100322 <new_block+0x58>
    return NULL;
    }
    block* nblock = (block*)bptr;
    // add to linked list 

    nblock->next = NULL;
  1002e7:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1002ee:	00 
    nblock->size = size;
  1002ef:	48 89 10             	mov    %rdx,(%rax)
    nblock->free = 0;
  1002f2:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
    // add to linked list 
    if (head == NULL) {
  1002f9:	48 8b 15 20 1d 00 00 	mov    0x1d20(%rip),%rdx        # 102020 <head>
  100300:	48 85 d2             	test   %rdx,%rdx
  100303:	74 14                	je     100319 <new_block+0x4f>
        head = nblock;
    } else {
        block *curr = head;
        while (curr->next != NULL) {
  100305:	48 89 d1             	mov    %rdx,%rcx
  100308:	48 8b 52 08          	mov    0x8(%rdx),%rdx
  10030c:	48 85 d2             	test   %rdx,%rdx
  10030f:	75 f4                	jne    100305 <new_block+0x3b>
            curr = curr->next;
        }
        curr->next = nblock;
  100311:	48 89 41 08          	mov    %rax,0x8(%rcx)
    }
    return nblock;
}
  100315:	48 89 f0             	mov    %rsi,%rax
  100318:	c3                   	ret    
        head = nblock;
  100319:	48 89 05 00 1d 00 00 	mov    %rax,0x1d00(%rip)        # 102020 <head>
  100320:	eb f3                	jmp    100315 <new_block+0x4b>
    return NULL;
  100322:	be 00 00 00 00       	mov    $0x0,%esi
  100327:	eb ec                	jmp    100315 <new_block+0x4b>

0000000000100329 <find_block>:
block* find_block(size_t size) {
  100329:	f3 0f 1e fa          	endbr64 
    block* curr = head;
  10032d:	48 8b 05 ec 1c 00 00 	mov    0x1cec(%rip),%rax        # 102020 <head>
    while (curr) {
  100334:	48 85 c0             	test   %rax,%rax
  100337:	75 0b                	jne    100344 <find_block+0x1b>
  100339:	eb 14                	jmp    10034f <find_block+0x26>
        if (curr->free && curr->size >= size) {
            return curr;
        }
        curr = curr->next;
  10033b:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (curr) {
  10033f:	48 85 c0             	test   %rax,%rax
  100342:	74 0b                	je     10034f <find_block+0x26>
        if (curr->free && curr->size >= size) {
  100344:	83 78 10 00          	cmpl   $0x0,0x10(%rax)
  100348:	74 f1                	je     10033b <find_block+0x12>
  10034a:	48 39 38             	cmp    %rdi,(%rax)
  10034d:	72 ec                	jb     10033b <find_block+0x12>
    }
    return NULL;
}
  10034f:	c3                   	ret    

0000000000100350 <split_block>:

block* split_block(block* b, size_t size){
  100350:	f3 0f 1e fa          	endbr64 
    if(b->size < size + sizeof(block)){
  100354:	48 8b 17             	mov    (%rdi),%rdx
  100357:	48 8d 46 18          	lea    0x18(%rsi),%rax
  10035b:	48 39 c2             	cmp    %rax,%rdx
  10035e:	72 24                	jb     100384 <split_block+0x34>
        return NULL;
    }
    void* nptr = (void*)b + sizeof(block) + size;
  100360:	48 01 f8             	add    %rdi,%rax
    block *new = (block*)nptr;

    new->size = b->size - size - sizeof(block);
  100363:	48 29 f2             	sub    %rsi,%rdx
  100366:	48 8d 52 e8          	lea    -0x18(%rdx),%rdx
  10036a:	48 89 10             	mov    %rdx,(%rax)
    new->next = b->next;
  10036d:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100371:	48 89 50 08          	mov    %rdx,0x8(%rax)
    new->free = 1; // New block is free
  100375:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%rax)

    // Update the original block
    b->size = size;
  10037c:	48 89 37             	mov    %rsi,(%rdi)
    b->next = new;
  10037f:	48 89 47 08          	mov    %rax,0x8(%rdi)

    return new;
  100383:	c3                   	ret    
        return NULL;
  100384:	b8 00 00 00 00       	mov    $0x0,%eax

}
  100389:	c3                   	ret    

000000000010038a <free>:


void free(void *firstbyte) {
  10038a:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  10038e:	48 85 ff             	test   %rdi,%rdi
  100391:	74 07                	je     10039a <free+0x10>
    return;
  }
    block* ptr = (block*)firstbyte;
    ptr->free = 1;
  100393:	c7 47 10 01 00 00 00 	movl   $0x1,0x10(%rdi)
}
  10039a:	c3                   	ret    

000000000010039b <malloc>:

void *malloc(uint64_t numbytes) {
  10039b:	f3 0f 1e fa          	endbr64 
  10039f:	55                   	push   %rbp
  1003a0:	48 89 e5             	mov    %rsp,%rbp
  1003a3:	41 54                	push   %r12
  1003a5:	53                   	push   %rbx
    return (size + 7) / 8 * 8;
  1003a6:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  1003aa:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    size_t size = algn(numbytes);
    block *b = find_block(size);
  1003ae:	4c 89 e7             	mov    %r12,%rdi
  1003b1:	e8 73 ff ff ff       	call   100329 <find_block>
    if (b == NULL){
  1003b6:	48 85 c0             	test   %rax,%rax
  1003b9:	74 20                	je     1003db <malloc+0x40>
  1003bb:	48 89 c3             	mov    %rax,%rbx
        if (b==NULL){
            //alloc fail
            return NULL;
        }
    } else {
        b->free = 0;
  1003be:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
        // check split
        if (b->size > size + sizeof(block)) {
  1003c5:	49 8d 44 24 18       	lea    0x18(%r12),%rax
  1003ca:	48 39 03             	cmp    %rax,(%rbx)
  1003cd:	77 1e                	ja     1003ed <malloc+0x52>
            split_block(b, size);
        }
    }
    return (void*)((void*)b + sizeof(block));
  1003cf:	48 83 c3 18          	add    $0x18,%rbx

}
  1003d3:	48 89 d8             	mov    %rbx,%rax
  1003d6:	5b                   	pop    %rbx
  1003d7:	41 5c                	pop    %r12
  1003d9:	5d                   	pop    %rbp
  1003da:	c3                   	ret    
        b = new_block(size);
  1003db:	4c 89 e7             	mov    %r12,%rdi
  1003de:	e8 e7 fe ff ff       	call   1002ca <new_block>
  1003e3:	48 89 c3             	mov    %rax,%rbx
        if (b==NULL){
  1003e6:	48 85 c0             	test   %rax,%rax
  1003e9:	75 e4                	jne    1003cf <malloc+0x34>
  1003eb:	eb e6                	jmp    1003d3 <malloc+0x38>
            split_block(b, size);
  1003ed:	4c 89 e6             	mov    %r12,%rsi
  1003f0:	48 89 df             	mov    %rbx,%rdi
  1003f3:	e8 58 ff ff ff       	call   100350 <split_block>
  1003f8:	eb d5                	jmp    1003cf <malloc+0x34>

00000000001003fa <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  1003fa:	f3 0f 1e fa          	endbr64 
  1003fe:	55                   	push   %rbp
  1003ff:	48 89 e5             	mov    %rsp,%rbp
  100402:	41 54                	push   %r12
  100404:	53                   	push   %rbx
    uint64_t total = num * sz;
  100405:	48 0f af fe          	imul   %rsi,%rdi
  100409:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  10040c:	e8 8a ff ff ff       	call   10039b <malloc>
  100411:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  100414:	48 85 c0             	test   %rax,%rax
  100417:	74 10                	je     100429 <calloc+0x2f>
        memset(ptr, 0, total);
  100419:	4c 89 e2             	mov    %r12,%rdx
  10041c:	be 00 00 00 00       	mov    $0x0,%esi
  100421:	48 89 c7             	mov    %rax,%rdi
  100424:	e8 e6 01 00 00       	call   10060f <memset>
    }
    return ptr;
}
  100429:	48 89 d8             	mov    %rbx,%rax
  10042c:	5b                   	pop    %rbx
  10042d:	41 5c                	pop    %r12
  10042f:	5d                   	pop    %rbp
  100430:	c3                   	ret    

0000000000100431 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  100431:	f3 0f 1e fa          	endbr64 
  100435:	55                   	push   %rbp
  100436:	48 89 e5             	mov    %rsp,%rbp
  100439:	41 54                	push   %r12
  10043b:	53                   	push   %rbx
  10043c:	48 89 fb             	mov    %rdi,%rbx
  10043f:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  100442:	48 85 db             	test   %rbx,%rbx
  100445:	74 2d                	je     100474 <realloc+0x43>
        return malloc(sz); // Equivalent to malloc if `ptr` is NULL
    }

    if (sz == 0) {
  100447:	48 85 f6             	test   %rsi,%rsi
  10044a:	74 32                	je     10047e <realloc+0x4d>
    return (size + 7) / 8 * 8;
  10044c:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  100450:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi

    block *b = (block*)((void*)ptr - sizeof(block)); // Get the block metadata
    size_t aligned_size = algn(sz);

    // If the current block is already large enough
    if (b->size >= aligned_size) {
  100454:	48 8b 43 e8          	mov    -0x18(%rbx),%rax
  100458:	48 39 f0             	cmp    %rsi,%rax
  10045b:	72 31                	jb     10048e <realloc+0x5d>
        // Split the block if it has excess space
        if (b->size > aligned_size + sizeof(block)) {
  10045d:	48 8d 56 18          	lea    0x18(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr; // Return the same pointer if resizing in place
  100461:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + sizeof(block)) {
  100464:	48 39 d0             	cmp    %rdx,%rax
  100467:	76 49                	jbe    1004b2 <realloc+0x81>
    block *b = (block*)((void*)ptr - sizeof(block)); // Get the block metadata
  100469:	48 8d 7b e8          	lea    -0x18(%rbx),%rdi
            split_block(b, aligned_size);
  10046d:	e8 de fe ff ff       	call   100350 <split_block>
  100472:	eb 3e                	jmp    1004b2 <realloc+0x81>
        return malloc(sz); // Equivalent to malloc if `ptr` is NULL
  100474:	e8 22 ff ff ff       	call   10039b <malloc>
  100479:	49 89 c4             	mov    %rax,%r12
  10047c:	eb 34                	jmp    1004b2 <realloc+0x81>
        free(ptr); // Equivalent to free if size is 0
  10047e:	48 89 df             	mov    %rbx,%rdi
  100481:	e8 04 ff ff ff       	call   10038a <free>
        return NULL;
  100486:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  10048c:	eb 24                	jmp    1004b2 <realloc+0x81>
    }

    // If the current block is too small, allocate a new block
    void *new_ptr = malloc(sz);
  10048e:	e8 08 ff ff ff       	call   10039b <malloc>
  100493:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  100496:	48 85 c0             	test   %rax,%rax
  100499:	74 17                	je     1004b2 <realloc+0x81>
        return NULL; // Allocation failed
    }

    // Copy data from the old block to the new block
    memcpy(new_ptr, ptr, b->size);
  10049b:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  10049f:	48 89 de             	mov    %rbx,%rsi
  1004a2:	48 89 c7             	mov    %rax,%rdi
  1004a5:	e8 5f 00 00 00       	call   100509 <memcpy>

    // Free the old block
    free(ptr);
  1004aa:	48 89 df             	mov    %rbx,%rdi
  1004ad:	e8 d8 fe ff ff       	call   10038a <free>

    return new_ptr;
}
  1004b2:	4c 89 e0             	mov    %r12,%rax
  1004b5:	5b                   	pop    %rbx
  1004b6:	41 5c                	pop    %r12
  1004b8:	5d                   	pop    %rbp
  1004b9:	c3                   	ret    

00000000001004ba <defrag>:


void defrag() {
  1004ba:	f3 0f 1e fa          	endbr64 
    block *b = head;
  1004be:	48 8b 15 5b 1b 00 00 	mov    0x1b5b(%rip),%rdx        # 102020 <head>

    while (b && b->next) {
  1004c5:	48 85 d2             	test   %rdx,%rdx
  1004c8:	75 04                	jne    1004ce <defrag+0x14>
  1004ca:	c3                   	ret    
        if (b->free && b->next->free) {
            // Merge the current block with the next block
            b->size += sizeof(block) + b->next->size;
            b->next = b->next->next;  // Skip the next block after merging
  1004cb:	48 89 c2             	mov    %rax,%rdx
    while (b && b->next) {
  1004ce:	48 8b 42 08          	mov    0x8(%rdx),%rax
  1004d2:	48 85 c0             	test   %rax,%rax
  1004d5:	74 27                	je     1004fe <defrag+0x44>
        if (b->free && b->next->free) {
  1004d7:	83 7a 10 00          	cmpl   $0x0,0x10(%rdx)
  1004db:	74 ee                	je     1004cb <defrag+0x11>
  1004dd:	83 78 10 00          	cmpl   $0x0,0x10(%rax)
  1004e1:	74 e8                	je     1004cb <defrag+0x11>
            b->size += sizeof(block) + b->next->size;
  1004e3:	48 8b 32             	mov    (%rdx),%rsi
  1004e6:	48 8b 08             	mov    (%rax),%rcx
  1004e9:	48 8d 4c 0e 18       	lea    0x18(%rsi,%rcx,1),%rcx
  1004ee:	48 89 0a             	mov    %rcx,(%rdx)
            b->next = b->next->next;  // Skip the next block after merging
  1004f1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1004f5:	48 89 42 08          	mov    %rax,0x8(%rdx)
  1004f9:	48 89 d0             	mov    %rdx,%rax
  1004fc:	eb cd                	jmp    1004cb <defrag+0x11>

        } else {
            b = b->next;  // Advance to the next block if no merge occurred
        }
    }
}
  1004fe:	c3                   	ret    

00000000001004ff <heap_info>:

int heap_info(heap_info_struct * info) {
  1004ff:	f3 0f 1e fa          	endbr64 
    return 0;
}
  100503:	b8 00 00 00 00       	mov    $0x0,%eax
  100508:	c3                   	ret    

0000000000100509 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100509:	f3 0f 1e fa          	endbr64 
  10050d:	55                   	push   %rbp
  10050e:	48 89 e5             	mov    %rsp,%rbp
  100511:	48 83 ec 28          	sub    $0x28,%rsp
  100515:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100519:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10051d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100521:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100525:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100529:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10052d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100531:	eb 1c                	jmp    10054f <memcpy+0x46>
        *d = *s;
  100533:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100537:	0f b6 10             	movzbl (%rax),%edx
  10053a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10053e:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100540:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100545:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  10054a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  10054f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100554:	75 dd                	jne    100533 <memcpy+0x2a>
    }
    return dst;
  100556:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10055a:	c9                   	leave  
  10055b:	c3                   	ret    

000000000010055c <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  10055c:	f3 0f 1e fa          	endbr64 
  100560:	55                   	push   %rbp
  100561:	48 89 e5             	mov    %rsp,%rbp
  100564:	48 83 ec 28          	sub    $0x28,%rsp
  100568:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10056c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100570:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100574:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100578:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10057c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100580:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100584:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100588:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10058c:	73 6a                	jae    1005f8 <memmove+0x9c>
  10058e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100592:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100596:	48 01 d0             	add    %rdx,%rax
  100599:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  10059d:	73 59                	jae    1005f8 <memmove+0x9c>
        s += n, d += n;
  10059f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1005a3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1005a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1005ab:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1005af:	eb 17                	jmp    1005c8 <memmove+0x6c>
            *--d = *--s;
  1005b1:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1005b6:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1005bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1005bf:	0f b6 10             	movzbl (%rax),%edx
  1005c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1005c6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1005c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1005cc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1005d0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1005d4:	48 85 c0             	test   %rax,%rax
  1005d7:	75 d8                	jne    1005b1 <memmove+0x55>
    if (s < d && s + n > d) {
  1005d9:	eb 2e                	jmp    100609 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1005db:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1005df:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1005e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1005e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1005eb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1005ef:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1005f3:	0f b6 12             	movzbl (%rdx),%edx
  1005f6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1005f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1005fc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100600:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100604:	48 85 c0             	test   %rax,%rax
  100607:	75 d2                	jne    1005db <memmove+0x7f>
        }
    }
    return dst;
  100609:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10060d:	c9                   	leave  
  10060e:	c3                   	ret    

000000000010060f <memset>:

void* memset(void* v, int c, size_t n) {
  10060f:	f3 0f 1e fa          	endbr64 
  100613:	55                   	push   %rbp
  100614:	48 89 e5             	mov    %rsp,%rbp
  100617:	48 83 ec 28          	sub    $0x28,%rsp
  10061b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10061f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100622:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100626:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10062a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10062e:	eb 15                	jmp    100645 <memset+0x36>
        *p = c;
  100630:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100633:	89 c2                	mov    %eax,%edx
  100635:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100639:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10063b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100640:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100645:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10064a:	75 e4                	jne    100630 <memset+0x21>
    }
    return v;
  10064c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100650:	c9                   	leave  
  100651:	c3                   	ret    

0000000000100652 <strlen>:

size_t strlen(const char* s) {
  100652:	f3 0f 1e fa          	endbr64 
  100656:	55                   	push   %rbp
  100657:	48 89 e5             	mov    %rsp,%rbp
  10065a:	48 83 ec 18          	sub    $0x18,%rsp
  10065e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100662:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100669:	00 
  10066a:	eb 0a                	jmp    100676 <strlen+0x24>
        ++n;
  10066c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100671:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100676:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10067a:	0f b6 00             	movzbl (%rax),%eax
  10067d:	84 c0                	test   %al,%al
  10067f:	75 eb                	jne    10066c <strlen+0x1a>
    }
    return n;
  100681:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100685:	c9                   	leave  
  100686:	c3                   	ret    

0000000000100687 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100687:	f3 0f 1e fa          	endbr64 
  10068b:	55                   	push   %rbp
  10068c:	48 89 e5             	mov    %rsp,%rbp
  10068f:	48 83 ec 20          	sub    $0x20,%rsp
  100693:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100697:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10069b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1006a2:	00 
  1006a3:	eb 0a                	jmp    1006af <strnlen+0x28>
        ++n;
  1006a5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1006aa:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1006af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006b3:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1006b7:	74 0b                	je     1006c4 <strnlen+0x3d>
  1006b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006bd:	0f b6 00             	movzbl (%rax),%eax
  1006c0:	84 c0                	test   %al,%al
  1006c2:	75 e1                	jne    1006a5 <strnlen+0x1e>
    }
    return n;
  1006c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1006c8:	c9                   	leave  
  1006c9:	c3                   	ret    

00000000001006ca <strcpy>:

char* strcpy(char* dst, const char* src) {
  1006ca:	f3 0f 1e fa          	endbr64 
  1006ce:	55                   	push   %rbp
  1006cf:	48 89 e5             	mov    %rsp,%rbp
  1006d2:	48 83 ec 20          	sub    $0x20,%rsp
  1006d6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1006da:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1006de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006e2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1006e6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1006ea:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1006ee:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1006f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006f6:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1006fa:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1006fe:	0f b6 12             	movzbl (%rdx),%edx
  100701:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100703:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100707:	48 83 e8 01          	sub    $0x1,%rax
  10070b:	0f b6 00             	movzbl (%rax),%eax
  10070e:	84 c0                	test   %al,%al
  100710:	75 d4                	jne    1006e6 <strcpy+0x1c>
    return dst;
  100712:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100716:	c9                   	leave  
  100717:	c3                   	ret    

0000000000100718 <strcmp>:

int strcmp(const char* a, const char* b) {
  100718:	f3 0f 1e fa          	endbr64 
  10071c:	55                   	push   %rbp
  10071d:	48 89 e5             	mov    %rsp,%rbp
  100720:	48 83 ec 10          	sub    $0x10,%rsp
  100724:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100728:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10072c:	eb 0a                	jmp    100738 <strcmp+0x20>
        ++a, ++b;
  10072e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100733:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100738:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10073c:	0f b6 00             	movzbl (%rax),%eax
  10073f:	84 c0                	test   %al,%al
  100741:	74 1d                	je     100760 <strcmp+0x48>
  100743:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100747:	0f b6 00             	movzbl (%rax),%eax
  10074a:	84 c0                	test   %al,%al
  10074c:	74 12                	je     100760 <strcmp+0x48>
  10074e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100752:	0f b6 10             	movzbl (%rax),%edx
  100755:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100759:	0f b6 00             	movzbl (%rax),%eax
  10075c:	38 c2                	cmp    %al,%dl
  10075e:	74 ce                	je     10072e <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100760:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100764:	0f b6 00             	movzbl (%rax),%eax
  100767:	89 c2                	mov    %eax,%edx
  100769:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10076d:	0f b6 00             	movzbl (%rax),%eax
  100770:	38 c2                	cmp    %al,%dl
  100772:	0f 97 c0             	seta   %al
  100775:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100778:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10077c:	0f b6 00             	movzbl (%rax),%eax
  10077f:	89 c1                	mov    %eax,%ecx
  100781:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100785:	0f b6 00             	movzbl (%rax),%eax
  100788:	38 c1                	cmp    %al,%cl
  10078a:	0f 92 c0             	setb   %al
  10078d:	0f b6 c8             	movzbl %al,%ecx
  100790:	89 d0                	mov    %edx,%eax
  100792:	29 c8                	sub    %ecx,%eax
}
  100794:	c9                   	leave  
  100795:	c3                   	ret    

0000000000100796 <strchr>:

char* strchr(const char* s, int c) {
  100796:	f3 0f 1e fa          	endbr64 
  10079a:	55                   	push   %rbp
  10079b:	48 89 e5             	mov    %rsp,%rbp
  10079e:	48 83 ec 10          	sub    $0x10,%rsp
  1007a2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1007a6:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1007a9:	eb 05                	jmp    1007b0 <strchr+0x1a>
        ++s;
  1007ab:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1007b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007b4:	0f b6 00             	movzbl (%rax),%eax
  1007b7:	84 c0                	test   %al,%al
  1007b9:	74 0e                	je     1007c9 <strchr+0x33>
  1007bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007bf:	0f b6 00             	movzbl (%rax),%eax
  1007c2:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1007c5:	38 d0                	cmp    %dl,%al
  1007c7:	75 e2                	jne    1007ab <strchr+0x15>
    }
    if (*s == (char) c) {
  1007c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007cd:	0f b6 00             	movzbl (%rax),%eax
  1007d0:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1007d3:	38 d0                	cmp    %dl,%al
  1007d5:	75 06                	jne    1007dd <strchr+0x47>
        return (char*) s;
  1007d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007db:	eb 05                	jmp    1007e2 <strchr+0x4c>
    } else {
        return NULL;
  1007dd:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1007e2:	c9                   	leave  
  1007e3:	c3                   	ret    

00000000001007e4 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1007e4:	f3 0f 1e fa          	endbr64 
  1007e8:	55                   	push   %rbp
  1007e9:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1007ec:	8b 05 36 18 00 00    	mov    0x1836(%rip),%eax        # 102028 <rand_seed_set>
  1007f2:	85 c0                	test   %eax,%eax
  1007f4:	75 0a                	jne    100800 <rand+0x1c>
        srand(819234718U);
  1007f6:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1007fb:	e8 24 00 00 00       	call   100824 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100800:	8b 05 26 18 00 00    	mov    0x1826(%rip),%eax        # 10202c <rand_seed>
  100806:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  10080c:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100811:	89 05 15 18 00 00    	mov    %eax,0x1815(%rip)        # 10202c <rand_seed>
    return rand_seed & RAND_MAX;
  100817:	8b 05 0f 18 00 00    	mov    0x180f(%rip),%eax        # 10202c <rand_seed>
  10081d:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100822:	5d                   	pop    %rbp
  100823:	c3                   	ret    

0000000000100824 <srand>:

void srand(unsigned seed) {
  100824:	f3 0f 1e fa          	endbr64 
  100828:	55                   	push   %rbp
  100829:	48 89 e5             	mov    %rsp,%rbp
  10082c:	48 83 ec 08          	sub    $0x8,%rsp
  100830:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100833:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100836:	89 05 f0 17 00 00    	mov    %eax,0x17f0(%rip)        # 10202c <rand_seed>
    rand_seed_set = 1;
  10083c:	c7 05 e2 17 00 00 01 	movl   $0x1,0x17e2(%rip)        # 102028 <rand_seed_set>
  100843:	00 00 00 
}
  100846:	90                   	nop
  100847:	c9                   	leave  
  100848:	c3                   	ret    

0000000000100849 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100849:	f3 0f 1e fa          	endbr64 
  10084d:	55                   	push   %rbp
  10084e:	48 89 e5             	mov    %rsp,%rbp
  100851:	48 83 ec 28          	sub    $0x28,%rsp
  100855:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100859:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10085d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100860:	48 8d 05 59 0f 00 00 	lea    0xf59(%rip),%rax        # 1017c0 <upper_digits.1>
  100867:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  10086b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10086f:	79 0e                	jns    10087f <fill_numbuf+0x36>
        digits = lower_digits;
  100871:	48 8d 05 68 0f 00 00 	lea    0xf68(%rip),%rax        # 1017e0 <lower_digits.0>
  100878:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  10087c:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  10087f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100884:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100888:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  10088b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10088e:	48 63 c8             	movslq %eax,%rcx
  100891:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100895:	ba 00 00 00 00       	mov    $0x0,%edx
  10089a:	48 f7 f1             	div    %rcx
  10089d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008a1:	48 01 d0             	add    %rdx,%rax
  1008a4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1008a9:	0f b6 10             	movzbl (%rax),%edx
  1008ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1008b0:	88 10                	mov    %dl,(%rax)
        val /= base;
  1008b2:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1008b5:	48 63 f0             	movslq %eax,%rsi
  1008b8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1008bc:	ba 00 00 00 00       	mov    $0x0,%edx
  1008c1:	48 f7 f6             	div    %rsi
  1008c4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1008c8:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1008cd:	75 bc                	jne    10088b <fill_numbuf+0x42>
    return numbuf_end;
  1008cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1008d3:	c9                   	leave  
  1008d4:	c3                   	ret    

00000000001008d5 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1008d5:	f3 0f 1e fa          	endbr64 
  1008d9:	55                   	push   %rbp
  1008da:	48 89 e5             	mov    %rsp,%rbp
  1008dd:	53                   	push   %rbx
  1008de:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1008e5:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1008ec:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1008f2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1008f9:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100900:	e9 bd 09 00 00       	jmp    1012c2 <printer_vprintf+0x9ed>
        if (*format != '%') {
  100905:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10090c:	0f b6 00             	movzbl (%rax),%eax
  10090f:	3c 25                	cmp    $0x25,%al
  100911:	74 31                	je     100944 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  100913:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10091a:	4c 8b 00             	mov    (%rax),%r8
  10091d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100924:	0f b6 00             	movzbl (%rax),%eax
  100927:	0f b6 c8             	movzbl %al,%ecx
  10092a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100930:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100937:	89 ce                	mov    %ecx,%esi
  100939:	48 89 c7             	mov    %rax,%rdi
  10093c:	41 ff d0             	call   *%r8
            continue;
  10093f:	e9 76 09 00 00       	jmp    1012ba <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  100944:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  10094b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100952:	01 
  100953:	eb 4d                	jmp    1009a2 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  100955:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10095c:	0f b6 00             	movzbl (%rax),%eax
  10095f:	0f be c0             	movsbl %al,%eax
  100962:	89 c6                	mov    %eax,%esi
  100964:	48 8d 05 55 0d 00 00 	lea    0xd55(%rip),%rax        # 1016c0 <flag_chars>
  10096b:	48 89 c7             	mov    %rax,%rdi
  10096e:	e8 23 fe ff ff       	call   100796 <strchr>
  100973:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100977:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10097c:	74 34                	je     1009b2 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  10097e:	48 8d 15 3b 0d 00 00 	lea    0xd3b(%rip),%rdx        # 1016c0 <flag_chars>
  100985:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100989:	48 29 d0             	sub    %rdx,%rax
  10098c:	ba 01 00 00 00       	mov    $0x1,%edx
  100991:	89 c1                	mov    %eax,%ecx
  100993:	d3 e2                	shl    %cl,%edx
  100995:	89 d0                	mov    %edx,%eax
  100997:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  10099a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1009a1:	01 
  1009a2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009a9:	0f b6 00             	movzbl (%rax),%eax
  1009ac:	84 c0                	test   %al,%al
  1009ae:	75 a5                	jne    100955 <printer_vprintf+0x80>
  1009b0:	eb 01                	jmp    1009b3 <printer_vprintf+0xde>
            } else {
                break;
  1009b2:	90                   	nop
            }
        }

        // process width
        int width = -1;
  1009b3:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  1009ba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009c1:	0f b6 00             	movzbl (%rax),%eax
  1009c4:	3c 30                	cmp    $0x30,%al
  1009c6:	7e 67                	jle    100a2f <printer_vprintf+0x15a>
  1009c8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009cf:	0f b6 00             	movzbl (%rax),%eax
  1009d2:	3c 39                	cmp    $0x39,%al
  1009d4:	7f 59                	jg     100a2f <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1009d6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  1009dd:	eb 2e                	jmp    100a0d <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  1009df:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1009e2:	89 d0                	mov    %edx,%eax
  1009e4:	c1 e0 02             	shl    $0x2,%eax
  1009e7:	01 d0                	add    %edx,%eax
  1009e9:	01 c0                	add    %eax,%eax
  1009eb:	89 c1                	mov    %eax,%ecx
  1009ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1009f4:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1009f8:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1009ff:	0f b6 00             	movzbl (%rax),%eax
  100a02:	0f be c0             	movsbl %al,%eax
  100a05:	01 c8                	add    %ecx,%eax
  100a07:	83 e8 30             	sub    $0x30,%eax
  100a0a:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100a0d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a14:	0f b6 00             	movzbl (%rax),%eax
  100a17:	3c 2f                	cmp    $0x2f,%al
  100a19:	0f 8e 85 00 00 00    	jle    100aa4 <printer_vprintf+0x1cf>
  100a1f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a26:	0f b6 00             	movzbl (%rax),%eax
  100a29:	3c 39                	cmp    $0x39,%al
  100a2b:	7e b2                	jle    1009df <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  100a2d:	eb 75                	jmp    100aa4 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  100a2f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a36:	0f b6 00             	movzbl (%rax),%eax
  100a39:	3c 2a                	cmp    $0x2a,%al
  100a3b:	75 68                	jne    100aa5 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  100a3d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a44:	8b 00                	mov    (%rax),%eax
  100a46:	83 f8 2f             	cmp    $0x2f,%eax
  100a49:	77 30                	ja     100a7b <printer_vprintf+0x1a6>
  100a4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a52:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a5d:	8b 00                	mov    (%rax),%eax
  100a5f:	89 c0                	mov    %eax,%eax
  100a61:	48 01 d0             	add    %rdx,%rax
  100a64:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a6b:	8b 12                	mov    (%rdx),%edx
  100a6d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a77:	89 0a                	mov    %ecx,(%rdx)
  100a79:	eb 1a                	jmp    100a95 <printer_vprintf+0x1c0>
  100a7b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a82:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a86:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a8a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a91:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a95:	8b 00                	mov    (%rax),%eax
  100a97:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100a9a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100aa1:	01 
  100aa2:	eb 01                	jmp    100aa5 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  100aa4:	90                   	nop
        }

        // process precision
        int precision = -1;
  100aa5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100aac:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ab3:	0f b6 00             	movzbl (%rax),%eax
  100ab6:	3c 2e                	cmp    $0x2e,%al
  100ab8:	0f 85 00 01 00 00    	jne    100bbe <printer_vprintf+0x2e9>
            ++format;
  100abe:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ac5:	01 
            if (*format >= '0' && *format <= '9') {
  100ac6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100acd:	0f b6 00             	movzbl (%rax),%eax
  100ad0:	3c 2f                	cmp    $0x2f,%al
  100ad2:	7e 67                	jle    100b3b <printer_vprintf+0x266>
  100ad4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100adb:	0f b6 00             	movzbl (%rax),%eax
  100ade:	3c 39                	cmp    $0x39,%al
  100ae0:	7f 59                	jg     100b3b <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100ae2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100ae9:	eb 2e                	jmp    100b19 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  100aeb:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100aee:	89 d0                	mov    %edx,%eax
  100af0:	c1 e0 02             	shl    $0x2,%eax
  100af3:	01 d0                	add    %edx,%eax
  100af5:	01 c0                	add    %eax,%eax
  100af7:	89 c1                	mov    %eax,%ecx
  100af9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b00:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100b04:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100b0b:	0f b6 00             	movzbl (%rax),%eax
  100b0e:	0f be c0             	movsbl %al,%eax
  100b11:	01 c8                	add    %ecx,%eax
  100b13:	83 e8 30             	sub    $0x30,%eax
  100b16:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100b19:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b20:	0f b6 00             	movzbl (%rax),%eax
  100b23:	3c 2f                	cmp    $0x2f,%al
  100b25:	0f 8e 85 00 00 00    	jle    100bb0 <printer_vprintf+0x2db>
  100b2b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b32:	0f b6 00             	movzbl (%rax),%eax
  100b35:	3c 39                	cmp    $0x39,%al
  100b37:	7e b2                	jle    100aeb <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  100b39:	eb 75                	jmp    100bb0 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  100b3b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b42:	0f b6 00             	movzbl (%rax),%eax
  100b45:	3c 2a                	cmp    $0x2a,%al
  100b47:	75 68                	jne    100bb1 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  100b49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b50:	8b 00                	mov    (%rax),%eax
  100b52:	83 f8 2f             	cmp    $0x2f,%eax
  100b55:	77 30                	ja     100b87 <printer_vprintf+0x2b2>
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
  100b85:	eb 1a                	jmp    100ba1 <printer_vprintf+0x2cc>
  100b87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b8e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b92:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b96:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b9d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ba1:	8b 00                	mov    (%rax),%eax
  100ba3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100ba6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100bad:	01 
  100bae:	eb 01                	jmp    100bb1 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  100bb0:	90                   	nop
            }
            if (precision < 0) {
  100bb1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100bb5:	79 07                	jns    100bbe <printer_vprintf+0x2e9>
                precision = 0;
  100bb7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100bbe:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100bc5:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100bcc:	00 
        int length = 0;
  100bcd:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100bd4:	48 8d 05 eb 0a 00 00 	lea    0xaeb(%rip),%rax        # 1016c6 <flag_chars+0x6>
  100bdb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  100bdf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100be6:	0f b6 00             	movzbl (%rax),%eax
  100be9:	0f be c0             	movsbl %al,%eax
  100bec:	83 e8 43             	sub    $0x43,%eax
  100bef:	83 f8 37             	cmp    $0x37,%eax
  100bf2:	0f 87 b6 03 00 00    	ja     100fae <printer_vprintf+0x6d9>
  100bf8:	89 c0                	mov    %eax,%eax
  100bfa:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  100c01:	00 
  100c02:	48 8d 05 cb 0a 00 00 	lea    0xacb(%rip),%rax        # 1016d4 <flag_chars+0x14>
  100c09:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  100c0c:	48 98                	cltq   
  100c0e:	48 8d 15 bf 0a 00 00 	lea    0xabf(%rip),%rdx        # 1016d4 <flag_chars+0x14>
  100c15:	48 01 d0             	add    %rdx,%rax
  100c18:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  100c1b:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100c22:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c29:	01 
            goto again;
  100c2a:	eb b3                	jmp    100bdf <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100c2c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100c30:	74 5d                	je     100c8f <printer_vprintf+0x3ba>
  100c32:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c39:	8b 00                	mov    (%rax),%eax
  100c3b:	83 f8 2f             	cmp    $0x2f,%eax
  100c3e:	77 30                	ja     100c70 <printer_vprintf+0x39b>
  100c40:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c47:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c52:	8b 00                	mov    (%rax),%eax
  100c54:	89 c0                	mov    %eax,%eax
  100c56:	48 01 d0             	add    %rdx,%rax
  100c59:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c60:	8b 12                	mov    (%rdx),%edx
  100c62:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c65:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c6c:	89 0a                	mov    %ecx,(%rdx)
  100c6e:	eb 1a                	jmp    100c8a <printer_vprintf+0x3b5>
  100c70:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c77:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c7b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c7f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c86:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c8a:	48 8b 00             	mov    (%rax),%rax
  100c8d:	eb 5c                	jmp    100ceb <printer_vprintf+0x416>
  100c8f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c96:	8b 00                	mov    (%rax),%eax
  100c98:	83 f8 2f             	cmp    $0x2f,%eax
  100c9b:	77 30                	ja     100ccd <printer_vprintf+0x3f8>
  100c9d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ca4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ca8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100caf:	8b 00                	mov    (%rax),%eax
  100cb1:	89 c0                	mov    %eax,%eax
  100cb3:	48 01 d0             	add    %rdx,%rax
  100cb6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cbd:	8b 12                	mov    (%rdx),%edx
  100cbf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100cc2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100cc9:	89 0a                	mov    %ecx,(%rdx)
  100ccb:	eb 1a                	jmp    100ce7 <printer_vprintf+0x412>
  100ccd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100cd4:	48 8b 40 08          	mov    0x8(%rax),%rax
  100cd8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100cdc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ce3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ce7:	8b 00                	mov    (%rax),%eax
  100ce9:	48 98                	cltq   
  100ceb:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100cef:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100cf3:	48 c1 f8 38          	sar    $0x38,%rax
  100cf7:	25 80 00 00 00       	and    $0x80,%eax
  100cfc:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100cff:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100d03:	74 09                	je     100d0e <printer_vprintf+0x439>
  100d05:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100d09:	48 f7 d8             	neg    %rax
  100d0c:	eb 04                	jmp    100d12 <printer_vprintf+0x43d>
  100d0e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100d12:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100d16:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100d19:	83 c8 60             	or     $0x60,%eax
  100d1c:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100d1f:	e9 cf 02 00 00       	jmp    100ff3 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100d24:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100d28:	74 5d                	je     100d87 <printer_vprintf+0x4b2>
  100d2a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d31:	8b 00                	mov    (%rax),%eax
  100d33:	83 f8 2f             	cmp    $0x2f,%eax
  100d36:	77 30                	ja     100d68 <printer_vprintf+0x493>
  100d38:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d3f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d43:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d4a:	8b 00                	mov    (%rax),%eax
  100d4c:	89 c0                	mov    %eax,%eax
  100d4e:	48 01 d0             	add    %rdx,%rax
  100d51:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d58:	8b 12                	mov    (%rdx),%edx
  100d5a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d5d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d64:	89 0a                	mov    %ecx,(%rdx)
  100d66:	eb 1a                	jmp    100d82 <printer_vprintf+0x4ad>
  100d68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d6f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d73:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d77:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d7e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d82:	48 8b 00             	mov    (%rax),%rax
  100d85:	eb 5c                	jmp    100de3 <printer_vprintf+0x50e>
  100d87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d8e:	8b 00                	mov    (%rax),%eax
  100d90:	83 f8 2f             	cmp    $0x2f,%eax
  100d93:	77 30                	ja     100dc5 <printer_vprintf+0x4f0>
  100d95:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d9c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100da0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100da7:	8b 00                	mov    (%rax),%eax
  100da9:	89 c0                	mov    %eax,%eax
  100dab:	48 01 d0             	add    %rdx,%rax
  100dae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100db5:	8b 12                	mov    (%rdx),%edx
  100db7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100dba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100dc1:	89 0a                	mov    %ecx,(%rdx)
  100dc3:	eb 1a                	jmp    100ddf <printer_vprintf+0x50a>
  100dc5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dcc:	48 8b 40 08          	mov    0x8(%rax),%rax
  100dd0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100dd4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ddb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ddf:	8b 00                	mov    (%rax),%eax
  100de1:	89 c0                	mov    %eax,%eax
  100de3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100de7:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100deb:	e9 03 02 00 00       	jmp    100ff3 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100df0:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100df7:	e9 28 ff ff ff       	jmp    100d24 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  100dfc:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100e03:	e9 1c ff ff ff       	jmp    100d24 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100e08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e0f:	8b 00                	mov    (%rax),%eax
  100e11:	83 f8 2f             	cmp    $0x2f,%eax
  100e14:	77 30                	ja     100e46 <printer_vprintf+0x571>
  100e16:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e1d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e21:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e28:	8b 00                	mov    (%rax),%eax
  100e2a:	89 c0                	mov    %eax,%eax
  100e2c:	48 01 d0             	add    %rdx,%rax
  100e2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e36:	8b 12                	mov    (%rdx),%edx
  100e38:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e3b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e42:	89 0a                	mov    %ecx,(%rdx)
  100e44:	eb 1a                	jmp    100e60 <printer_vprintf+0x58b>
  100e46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e4d:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e51:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e55:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e5c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e60:	48 8b 00             	mov    (%rax),%rax
  100e63:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100e67:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100e6e:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100e75:	e9 79 01 00 00       	jmp    100ff3 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100e7a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e81:	8b 00                	mov    (%rax),%eax
  100e83:	83 f8 2f             	cmp    $0x2f,%eax
  100e86:	77 30                	ja     100eb8 <printer_vprintf+0x5e3>
  100e88:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e8f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e93:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e9a:	8b 00                	mov    (%rax),%eax
  100e9c:	89 c0                	mov    %eax,%eax
  100e9e:	48 01 d0             	add    %rdx,%rax
  100ea1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ea8:	8b 12                	mov    (%rdx),%edx
  100eaa:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ead:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100eb4:	89 0a                	mov    %ecx,(%rdx)
  100eb6:	eb 1a                	jmp    100ed2 <printer_vprintf+0x5fd>
  100eb8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ebf:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ec3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ec7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ece:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ed2:	48 8b 00             	mov    (%rax),%rax
  100ed5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100ed9:	e9 15 01 00 00       	jmp    100ff3 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100ede:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ee5:	8b 00                	mov    (%rax),%eax
  100ee7:	83 f8 2f             	cmp    $0x2f,%eax
  100eea:	77 30                	ja     100f1c <printer_vprintf+0x647>
  100eec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ef3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ef7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100efe:	8b 00                	mov    (%rax),%eax
  100f00:	89 c0                	mov    %eax,%eax
  100f02:	48 01 d0             	add    %rdx,%rax
  100f05:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f0c:	8b 12                	mov    (%rdx),%edx
  100f0e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f11:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f18:	89 0a                	mov    %ecx,(%rdx)
  100f1a:	eb 1a                	jmp    100f36 <printer_vprintf+0x661>
  100f1c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f23:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f27:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f2b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f32:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f36:	8b 00                	mov    (%rax),%eax
  100f38:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100f3e:	e9 77 03 00 00       	jmp    1012ba <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100f43:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100f47:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100f4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f52:	8b 00                	mov    (%rax),%eax
  100f54:	83 f8 2f             	cmp    $0x2f,%eax
  100f57:	77 30                	ja     100f89 <printer_vprintf+0x6b4>
  100f59:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f60:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f6b:	8b 00                	mov    (%rax),%eax
  100f6d:	89 c0                	mov    %eax,%eax
  100f6f:	48 01 d0             	add    %rdx,%rax
  100f72:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f79:	8b 12                	mov    (%rdx),%edx
  100f7b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f7e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f85:	89 0a                	mov    %ecx,(%rdx)
  100f87:	eb 1a                	jmp    100fa3 <printer_vprintf+0x6ce>
  100f89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f90:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f94:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f98:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f9f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fa3:	8b 00                	mov    (%rax),%eax
  100fa5:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100fa8:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100fac:	eb 45                	jmp    100ff3 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100fae:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100fb2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100fb6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100fbd:	0f b6 00             	movzbl (%rax),%eax
  100fc0:	84 c0                	test   %al,%al
  100fc2:	74 0c                	je     100fd0 <printer_vprintf+0x6fb>
  100fc4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100fcb:	0f b6 00             	movzbl (%rax),%eax
  100fce:	eb 05                	jmp    100fd5 <printer_vprintf+0x700>
  100fd0:	b8 25 00 00 00       	mov    $0x25,%eax
  100fd5:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100fd8:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100fdc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100fe3:	0f b6 00             	movzbl (%rax),%eax
  100fe6:	84 c0                	test   %al,%al
  100fe8:	75 08                	jne    100ff2 <printer_vprintf+0x71d>
                format--;
  100fea:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100ff1:	01 
            }
            break;
  100ff2:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100ff3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ff6:	83 e0 20             	and    $0x20,%eax
  100ff9:	85 c0                	test   %eax,%eax
  100ffb:	74 1e                	je     10101b <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100ffd:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101001:	48 83 c0 18          	add    $0x18,%rax
  101005:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101008:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10100c:	48 89 ce             	mov    %rcx,%rsi
  10100f:	48 89 c7             	mov    %rax,%rdi
  101012:	e8 32 f8 ff ff       	call   100849 <fill_numbuf>
  101017:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  10101b:	48 8d 05 a4 06 00 00 	lea    0x6a4(%rip),%rax        # 1016c6 <flag_chars+0x6>
  101022:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  101026:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101029:	83 e0 20             	and    $0x20,%eax
  10102c:	85 c0                	test   %eax,%eax
  10102e:	74 51                	je     101081 <printer_vprintf+0x7ac>
  101030:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101033:	83 e0 40             	and    $0x40,%eax
  101036:	85 c0                	test   %eax,%eax
  101038:	74 47                	je     101081 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  10103a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10103d:	25 80 00 00 00       	and    $0x80,%eax
  101042:	85 c0                	test   %eax,%eax
  101044:	74 0d                	je     101053 <printer_vprintf+0x77e>
                prefix = "-";
  101046:	48 8d 05 7a 06 00 00 	lea    0x67a(%rip),%rax        # 1016c7 <flag_chars+0x7>
  10104d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  101051:	eb 7d                	jmp    1010d0 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101053:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101056:	83 e0 10             	and    $0x10,%eax
  101059:	85 c0                	test   %eax,%eax
  10105b:	74 0d                	je     10106a <printer_vprintf+0x795>
                prefix = "+";
  10105d:	48 8d 05 65 06 00 00 	lea    0x665(%rip),%rax        # 1016c9 <flag_chars+0x9>
  101064:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  101068:	eb 66                	jmp    1010d0 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  10106a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10106d:	83 e0 08             	and    $0x8,%eax
  101070:	85 c0                	test   %eax,%eax
  101072:	74 5c                	je     1010d0 <printer_vprintf+0x7fb>
                prefix = " ";
  101074:	48 8d 05 50 06 00 00 	lea    0x650(%rip),%rax        # 1016cb <flag_chars+0xb>
  10107b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  10107f:	eb 4f                	jmp    1010d0 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  101081:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101084:	83 e0 20             	and    $0x20,%eax
  101087:	85 c0                	test   %eax,%eax
  101089:	74 46                	je     1010d1 <printer_vprintf+0x7fc>
  10108b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10108e:	83 e0 01             	and    $0x1,%eax
  101091:	85 c0                	test   %eax,%eax
  101093:	74 3c                	je     1010d1 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  101095:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  101099:	74 06                	je     1010a1 <printer_vprintf+0x7cc>
  10109b:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  10109f:	75 30                	jne    1010d1 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  1010a1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1010a6:	75 0c                	jne    1010b4 <printer_vprintf+0x7df>
  1010a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010ab:	25 00 01 00 00       	and    $0x100,%eax
  1010b0:	85 c0                	test   %eax,%eax
  1010b2:	74 1d                	je     1010d1 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  1010b4:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  1010b8:	75 09                	jne    1010c3 <printer_vprintf+0x7ee>
  1010ba:	48 8d 05 0c 06 00 00 	lea    0x60c(%rip),%rax        # 1016cd <flag_chars+0xd>
  1010c1:	eb 07                	jmp    1010ca <printer_vprintf+0x7f5>
  1010c3:	48 8d 05 06 06 00 00 	lea    0x606(%rip),%rax        # 1016d0 <flag_chars+0x10>
  1010ca:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1010ce:	eb 01                	jmp    1010d1 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  1010d0:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1010d1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1010d5:	78 24                	js     1010fb <printer_vprintf+0x826>
  1010d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010da:	83 e0 20             	and    $0x20,%eax
  1010dd:	85 c0                	test   %eax,%eax
  1010df:	75 1a                	jne    1010fb <printer_vprintf+0x826>
            len = strnlen(data, precision);
  1010e1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1010e4:	48 63 d0             	movslq %eax,%rdx
  1010e7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1010eb:	48 89 d6             	mov    %rdx,%rsi
  1010ee:	48 89 c7             	mov    %rax,%rdi
  1010f1:	e8 91 f5 ff ff       	call   100687 <strnlen>
  1010f6:	89 45 bc             	mov    %eax,-0x44(%rbp)
  1010f9:	eb 0f                	jmp    10110a <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  1010fb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1010ff:	48 89 c7             	mov    %rax,%rdi
  101102:	e8 4b f5 ff ff       	call   100652 <strlen>
  101107:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  10110a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10110d:	83 e0 20             	and    $0x20,%eax
  101110:	85 c0                	test   %eax,%eax
  101112:	74 20                	je     101134 <printer_vprintf+0x85f>
  101114:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101118:	78 1a                	js     101134 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  10111a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  10111d:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101120:	7e 08                	jle    10112a <printer_vprintf+0x855>
  101122:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101125:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101128:	eb 05                	jmp    10112f <printer_vprintf+0x85a>
  10112a:	b8 00 00 00 00       	mov    $0x0,%eax
  10112f:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101132:	eb 5c                	jmp    101190 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  101134:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101137:	83 e0 20             	and    $0x20,%eax
  10113a:	85 c0                	test   %eax,%eax
  10113c:	74 4b                	je     101189 <printer_vprintf+0x8b4>
  10113e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101141:	83 e0 02             	and    $0x2,%eax
  101144:	85 c0                	test   %eax,%eax
  101146:	74 41                	je     101189 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  101148:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10114b:	83 e0 04             	and    $0x4,%eax
  10114e:	85 c0                	test   %eax,%eax
  101150:	75 37                	jne    101189 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  101152:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101156:	48 89 c7             	mov    %rax,%rdi
  101159:	e8 f4 f4 ff ff       	call   100652 <strlen>
  10115e:	89 c2                	mov    %eax,%edx
  101160:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101163:	01 d0                	add    %edx,%eax
  101165:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101168:	7e 1f                	jle    101189 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  10116a:	8b 45 e8             	mov    -0x18(%rbp),%eax
  10116d:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101170:	89 c3                	mov    %eax,%ebx
  101172:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101176:	48 89 c7             	mov    %rax,%rdi
  101179:	e8 d4 f4 ff ff       	call   100652 <strlen>
  10117e:	89 c2                	mov    %eax,%edx
  101180:	89 d8                	mov    %ebx,%eax
  101182:	29 d0                	sub    %edx,%eax
  101184:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101187:	eb 07                	jmp    101190 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  101189:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101190:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101193:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101196:	01 d0                	add    %edx,%eax
  101198:	48 63 d8             	movslq %eax,%rbx
  10119b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10119f:	48 89 c7             	mov    %rax,%rdi
  1011a2:	e8 ab f4 ff ff       	call   100652 <strlen>
  1011a7:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  1011ab:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1011ae:	29 d0                	sub    %edx,%eax
  1011b0:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1011b3:	eb 25                	jmp    1011da <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  1011b5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1011bc:	48 8b 08             	mov    (%rax),%rcx
  1011bf:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1011c5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1011cc:	be 20 00 00 00       	mov    $0x20,%esi
  1011d1:	48 89 c7             	mov    %rax,%rdi
  1011d4:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1011d6:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1011da:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011dd:	83 e0 04             	and    $0x4,%eax
  1011e0:	85 c0                	test   %eax,%eax
  1011e2:	75 36                	jne    10121a <printer_vprintf+0x945>
  1011e4:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1011e8:	7f cb                	jg     1011b5 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  1011ea:	eb 2e                	jmp    10121a <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  1011ec:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1011f3:	4c 8b 00             	mov    (%rax),%r8
  1011f6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1011fa:	0f b6 00             	movzbl (%rax),%eax
  1011fd:	0f b6 c8             	movzbl %al,%ecx
  101200:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101206:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10120d:	89 ce                	mov    %ecx,%esi
  10120f:	48 89 c7             	mov    %rax,%rdi
  101212:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101215:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  10121a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10121e:	0f b6 00             	movzbl (%rax),%eax
  101221:	84 c0                	test   %al,%al
  101223:	75 c7                	jne    1011ec <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  101225:	eb 25                	jmp    10124c <printer_vprintf+0x977>
            p->putc(p, '0', color);
  101227:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10122e:	48 8b 08             	mov    (%rax),%rcx
  101231:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101237:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10123e:	be 30 00 00 00       	mov    $0x30,%esi
  101243:	48 89 c7             	mov    %rax,%rdi
  101246:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101248:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  10124c:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101250:	7f d5                	jg     101227 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  101252:	eb 32                	jmp    101286 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  101254:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10125b:	4c 8b 00             	mov    (%rax),%r8
  10125e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101262:	0f b6 00             	movzbl (%rax),%eax
  101265:	0f b6 c8             	movzbl %al,%ecx
  101268:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10126e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101275:	89 ce                	mov    %ecx,%esi
  101277:	48 89 c7             	mov    %rax,%rdi
  10127a:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  10127d:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101282:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101286:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10128a:	7f c8                	jg     101254 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  10128c:	eb 25                	jmp    1012b3 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  10128e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101295:	48 8b 08             	mov    (%rax),%rcx
  101298:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10129e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012a5:	be 20 00 00 00       	mov    $0x20,%esi
  1012aa:	48 89 c7             	mov    %rax,%rdi
  1012ad:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  1012af:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1012b3:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1012b7:	7f d5                	jg     10128e <printer_vprintf+0x9b9>
        }
    done: ;
  1012b9:	90                   	nop
    for (; *format; ++format) {
  1012ba:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1012c1:	01 
  1012c2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1012c9:	0f b6 00             	movzbl (%rax),%eax
  1012cc:	84 c0                	test   %al,%al
  1012ce:	0f 85 31 f6 ff ff    	jne    100905 <printer_vprintf+0x30>
    }
}
  1012d4:	90                   	nop
  1012d5:	90                   	nop
  1012d6:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1012da:	c9                   	leave  
  1012db:	c3                   	ret    

00000000001012dc <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1012dc:	f3 0f 1e fa          	endbr64 
  1012e0:	55                   	push   %rbp
  1012e1:	48 89 e5             	mov    %rsp,%rbp
  1012e4:	48 83 ec 20          	sub    $0x20,%rsp
  1012e8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1012ec:	89 f0                	mov    %esi,%eax
  1012ee:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1012f1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1012f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1012f8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1012fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101300:	48 8b 40 08          	mov    0x8(%rax),%rax
  101304:	48 8d 15 95 7c fb ff 	lea    -0x4836b(%rip),%rdx        # b8fa0 <console+0xfa0>
  10130b:	48 39 d0             	cmp    %rdx,%rax
  10130e:	72 0f                	jb     10131f <console_putc+0x43>
        cp->cursor = console;
  101310:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101314:	48 8d 15 e5 6c fb ff 	lea    -0x4931b(%rip),%rdx        # b8000 <console>
  10131b:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  10131f:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101323:	0f 85 82 00 00 00    	jne    1013ab <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  101329:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10132d:	48 8b 40 08          	mov    0x8(%rax),%rax
  101331:	48 8d 15 c8 6c fb ff 	lea    -0x49338(%rip),%rdx        # b8000 <console>
  101338:	48 29 d0             	sub    %rdx,%rax
  10133b:	48 d1 f8             	sar    %rax
  10133e:	48 89 c1             	mov    %rax,%rcx
  101341:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101348:	66 66 66 
  10134b:	48 89 c8             	mov    %rcx,%rax
  10134e:	48 f7 ea             	imul   %rdx
  101351:	48 89 d0             	mov    %rdx,%rax
  101354:	48 c1 f8 05          	sar    $0x5,%rax
  101358:	48 89 ce             	mov    %rcx,%rsi
  10135b:	48 c1 fe 3f          	sar    $0x3f,%rsi
  10135f:	48 29 f0             	sub    %rsi,%rax
  101362:	48 89 c2             	mov    %rax,%rdx
  101365:	48 89 d0             	mov    %rdx,%rax
  101368:	48 c1 e0 02          	shl    $0x2,%rax
  10136c:	48 01 d0             	add    %rdx,%rax
  10136f:	48 c1 e0 04          	shl    $0x4,%rax
  101373:	48 29 c1             	sub    %rax,%rcx
  101376:	48 89 ca             	mov    %rcx,%rdx
  101379:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  10137c:	eb 25                	jmp    1013a3 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  10137e:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101381:	83 c8 20             	or     $0x20,%eax
  101384:	89 c6                	mov    %eax,%esi
  101386:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10138a:	48 8b 40 08          	mov    0x8(%rax),%rax
  10138e:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101392:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101396:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10139a:	89 f2                	mov    %esi,%edx
  10139c:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10139f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1013a3:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  1013a7:	75 d5                	jne    10137e <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  1013a9:	eb 24                	jmp    1013cf <console_putc+0xf3>
        *cp->cursor++ = c | color;
  1013ab:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1013af:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1013b2:	89 d6                	mov    %edx,%esi
  1013b4:	09 c6                	or     %eax,%esi
  1013b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013ba:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013be:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1013c2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1013c6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1013ca:	89 f2                	mov    %esi,%edx
  1013cc:	66 89 10             	mov    %dx,(%rax)
}
  1013cf:	90                   	nop
  1013d0:	c9                   	leave  
  1013d1:	c3                   	ret    

00000000001013d2 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1013d2:	f3 0f 1e fa          	endbr64 
  1013d6:	55                   	push   %rbp
  1013d7:	48 89 e5             	mov    %rsp,%rbp
  1013da:	48 83 ec 30          	sub    $0x30,%rsp
  1013de:	89 7d ec             	mov    %edi,-0x14(%rbp)
  1013e1:	89 75 e8             	mov    %esi,-0x18(%rbp)
  1013e4:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1013e8:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  1013ec:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 1012dc <console_putc>
  1013f3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1013f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1013fb:	78 09                	js     101406 <console_vprintf+0x34>
  1013fd:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101404:	7e 07                	jle    10140d <console_vprintf+0x3b>
        cpos = 0;
  101406:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  10140d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101410:	48 98                	cltq   
  101412:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101416:	48 8d 05 e3 6b fb ff 	lea    -0x4941d(%rip),%rax        # b8000 <console>
  10141d:	48 01 d0             	add    %rdx,%rax
  101420:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101424:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101428:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10142c:	8b 75 e8             	mov    -0x18(%rbp),%esi
  10142f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101433:	48 89 c7             	mov    %rax,%rdi
  101436:	e8 9a f4 ff ff       	call   1008d5 <printer_vprintf>
    return cp.cursor - console;
  10143b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10143f:	48 8d 15 ba 6b fb ff 	lea    -0x49446(%rip),%rdx        # b8000 <console>
  101446:	48 29 d0             	sub    %rdx,%rax
  101449:	48 d1 f8             	sar    %rax
}
  10144c:	c9                   	leave  
  10144d:	c3                   	ret    

000000000010144e <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  10144e:	f3 0f 1e fa          	endbr64 
  101452:	55                   	push   %rbp
  101453:	48 89 e5             	mov    %rsp,%rbp
  101456:	48 83 ec 60          	sub    $0x60,%rsp
  10145a:	89 7d ac             	mov    %edi,-0x54(%rbp)
  10145d:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101460:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101464:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101468:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10146c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101470:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101477:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10147b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10147f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101483:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101487:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10148b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10148f:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101492:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101495:	89 c7                	mov    %eax,%edi
  101497:	e8 36 ff ff ff       	call   1013d2 <console_vprintf>
  10149c:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10149f:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  1014a2:	c9                   	leave  
  1014a3:	c3                   	ret    

00000000001014a4 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  1014a4:	f3 0f 1e fa          	endbr64 
  1014a8:	55                   	push   %rbp
  1014a9:	48 89 e5             	mov    %rsp,%rbp
  1014ac:	48 83 ec 20          	sub    $0x20,%rsp
  1014b0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1014b4:	89 f0                	mov    %esi,%eax
  1014b6:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1014b9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  1014bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1014c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  1014c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1014c8:	48 8b 50 08          	mov    0x8(%rax),%rdx
  1014cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1014d0:	48 8b 40 10          	mov    0x10(%rax),%rax
  1014d4:	48 39 c2             	cmp    %rax,%rdx
  1014d7:	73 1a                	jae    1014f3 <string_putc+0x4f>
        *sp->s++ = c;
  1014d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1014dd:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014e1:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1014e5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1014e9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1014ed:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  1014f1:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  1014f3:	90                   	nop
  1014f4:	c9                   	leave  
  1014f5:	c3                   	ret    

00000000001014f6 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1014f6:	f3 0f 1e fa          	endbr64 
  1014fa:	55                   	push   %rbp
  1014fb:	48 89 e5             	mov    %rsp,%rbp
  1014fe:	48 83 ec 40          	sub    $0x40,%rsp
  101502:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101506:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10150a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10150e:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101512:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 1014a4 <string_putc>
  101519:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  10151d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101521:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101525:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  10152a:	74 33                	je     10155f <vsnprintf+0x69>
        sp.end = s + size - 1;
  10152c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101530:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101534:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101538:	48 01 d0             	add    %rdx,%rax
  10153b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  10153f:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101543:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101547:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  10154b:	be 00 00 00 00       	mov    $0x0,%esi
  101550:	48 89 c7             	mov    %rax,%rdi
  101553:	e8 7d f3 ff ff       	call   1008d5 <printer_vprintf>
        *sp.s = 0;
  101558:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10155c:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  10155f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101563:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101567:	c9                   	leave  
  101568:	c3                   	ret    

0000000000101569 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101569:	f3 0f 1e fa          	endbr64 
  10156d:	55                   	push   %rbp
  10156e:	48 89 e5             	mov    %rsp,%rbp
  101571:	48 83 ec 70          	sub    $0x70,%rsp
  101575:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101579:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10157d:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101581:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101585:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101589:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10158d:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101594:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101598:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10159c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1015a0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  1015a4:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  1015a8:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  1015ac:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  1015b0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1015b4:	48 89 c7             	mov    %rax,%rdi
  1015b7:	e8 3a ff ff ff       	call   1014f6 <vsnprintf>
  1015bc:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  1015bf:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  1015c2:	c9                   	leave  
  1015c3:	c3                   	ret    

00000000001015c4 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  1015c4:	f3 0f 1e fa          	endbr64 
  1015c8:	55                   	push   %rbp
  1015c9:	48 89 e5             	mov    %rsp,%rbp
  1015cc:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1015d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  1015d7:	eb 1a                	jmp    1015f3 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  1015d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1015dc:	48 98                	cltq   
  1015de:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  1015e2:	48 8d 05 17 6a fb ff 	lea    -0x495e9(%rip),%rax        # b8000 <console>
  1015e9:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1015ef:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  1015f3:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  1015fa:	7e dd                	jle    1015d9 <console_clear+0x15>
    }
    cursorpos = 0;
  1015fc:	c7 05 f6 79 fb ff 00 	movl   $0x0,-0x4860a(%rip)        # b8ffc <cursorpos>
  101603:	00 00 00 
}
  101606:	90                   	nop
  101607:	c9                   	leave  
  101608:	c3                   	ret    
