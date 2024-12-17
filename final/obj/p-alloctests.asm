
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	f3 0f 1e fa          	endbr64 
  2c0004:	55                   	push   %rbp
  2c0005:	48 89 e5             	mov    %rsp,%rbp
  2c0008:	41 56                	push   %r14
  2c000a:	41 55                	push   %r13
  2c000c:	41 54                	push   %r12
  2c000e:	53                   	push   %rbx
  2c000f:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c0013:	cd 31                	int    $0x31
  2c0015:	41 89 c4             	mov    %eax,%r12d
    
    pid_t p = getpid();
    srand(p);
  2c0018:	89 c7                	mov    %eax,%edi
  2c001a:	e8 15 09 00 00       	call   2c0934 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001f:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0024:	e8 76 04 00 00       	call   2c049f <malloc>
  2c0029:	48 89 c7             	mov    %rax,%rdi
  2c002c:	ba 00 00 00 00       	mov    $0x0,%edx
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  2c0031:	89 14 97             	mov    %edx,(%rdi,%rdx,4)
    for(int  i = 0 ; i < 10; i++){
  2c0034:	48 83 c2 01          	add    $0x1,%rdx
  2c0038:	48 83 fa 0a          	cmp    $0xa,%rdx
  2c003c:	75 f3                	jne    2c0031 <process_main+0x31>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c003e:	be 50 00 00 00       	mov    $0x50,%esi
  2c0043:	e8 ee 04 00 00       	call   2c0536 <realloc>
  2c0048:	49 89 c5             	mov    %rax,%r13
  2c004b:	b8 00 00 00 00       	mov    $0x0,%eax

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c0050:	41 39 44 85 00       	cmp    %eax,0x0(%r13,%rax,4)
  2c0055:	75 64                	jne    2c00bb <process_main+0xbb>
    for(int i = 0 ; i < 10 ; i++){
  2c0057:	48 83 c0 01          	add    $0x1,%rax
  2c005b:	48 83 f8 0a          	cmp    $0xa,%rax
  2c005f:	75 ef                	jne    2c0050 <process_main+0x50>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c0061:	be 04 00 00 00       	mov    $0x4,%esi
  2c0066:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c006b:	e8 8f 04 00 00       	call   2c04ff <calloc>
  2c0070:	49 89 c6             	mov    %rax,%r14

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c0073:	48 8d 50 78          	lea    0x78(%rax),%rdx
	assert(array2[i] == 0);
  2c0077:	8b 18                	mov    (%rax),%ebx
  2c0079:	85 db                	test   %ebx,%ebx
  2c007b:	75 56                	jne    2c00d3 <process_main+0xd3>
    for(int i = 0 ; i < 30; i++){
  2c007d:	48 83 c0 04          	add    $0x4,%rax
  2c0081:	48 39 d0             	cmp    %rdx,%rax
  2c0084:	75 f1                	jne    2c0077 <process_main+0x77>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c0086:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  2c008a:	e8 80 05 00 00       	call   2c060f <heap_info>
  2c008f:	85 c0                	test   %eax,%eax
  2c0091:	75 70                	jne    2c0103 <process_main+0x103>
	// check if allocations are in sorted order
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c0093:	8b 55 c0             	mov    -0x40(%rbp),%edx
  2c0096:	83 fa 01             	cmp    $0x1,%edx
  2c0099:	7e 7e                	jle    2c0119 <process_main+0x119>
  2c009b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c009f:	8d 52 fe             	lea    -0x2(%rdx),%edx
  2c00a2:	48 8d 54 d0 08       	lea    0x8(%rax,%rdx,8),%rdx
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00a7:	48 8b 30             	mov    (%rax),%rsi
  2c00aa:	48 39 70 08          	cmp    %rsi,0x8(%rax)
  2c00ae:	7d 3b                	jge    2c00eb <process_main+0xeb>
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c00b0:	48 83 c0 08          	add    $0x8,%rax
  2c00b4:	48 39 d0             	cmp    %rdx,%rax
  2c00b7:	75 ee                	jne    2c00a7 <process_main+0xa7>
  2c00b9:	eb 5e                	jmp    2c0119 <process_main+0x119>
	assert(array[i] == i);
  2c00bb:	48 8d 15 5e 16 00 00 	lea    0x165e(%rip),%rdx        # 2c1720 <console_clear+0x4c>
  2c00c2:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c7:	48 8d 3d 60 16 00 00 	lea    0x1660(%rip),%rdi        # 2c172e <console_clear+0x5a>
  2c00ce:	e8 31 02 00 00       	call   2c0304 <assert_fail>
	assert(array2[i] == 0);
  2c00d3:	48 8d 15 6a 16 00 00 	lea    0x166a(%rip),%rdx        # 2c1744 <console_clear+0x70>
  2c00da:	be 21 00 00 00       	mov    $0x21,%esi
  2c00df:	48 8d 3d 48 16 00 00 	lea    0x1648(%rip),%rdi        # 2c172e <console_clear+0x5a>
  2c00e6:	e8 19 02 00 00       	call   2c0304 <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00eb:	48 8d 15 76 16 00 00 	lea    0x1676(%rip),%rdx        # 2c1768 <console_clear+0x94>
  2c00f2:	be 28 00 00 00       	mov    $0x28,%esi
  2c00f7:	48 8d 3d 30 16 00 00 	lea    0x1630(%rip),%rdi        # 2c172e <console_clear+0x5a>
  2c00fe:	e8 01 02 00 00       	call   2c0304 <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c0103:	48 8d 35 49 16 00 00 	lea    0x1649(%rip),%rsi        # 2c1753 <console_clear+0x7f>
  2c010a:	bf 00 00 00 00       	mov    $0x0,%edi
  2c010f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0114:	e8 7b 00 00 00       	call   2c0194 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0119:	4c 89 ef             	mov    %r13,%rdi
  2c011c:	e8 5f 03 00 00       	call   2c0480 <free>
    free(array2);
  2c0121:	4c 89 f7             	mov    %r14,%rdi
  2c0124:	e8 57 03 00 00       	call   2c0480 <free>

    uint64_t total_time = 0;
  2c0129:	41 bd 00 00 00 00    	mov    $0x0,%r13d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c012f:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c0131:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0135:	89 c0                	mov    %eax,%eax
  2c0137:	48 09 c2             	or     %rax,%rdx
  2c013a:	49 89 d6             	mov    %rdx,%r14
    int total_pages = 0;
    
    // allocate pages till no more memory
    while (1) {
	uint64_t time = rdtsc();
	void * ptr = malloc(PAGESIZE);
  2c013d:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c0142:	e8 58 03 00 00       	call   2c049f <malloc>
  2c0147:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c014a:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  2c014c:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0150:	89 c0                	mov    %eax,%eax
  2c0152:	48 09 c2             	or     %rax,%rdx
	total_time += (rdtsc() - time);
  2c0155:	4c 29 f2             	sub    %r14,%rdx
  2c0158:	49 01 d5             	add    %rdx,%r13
	if(ptr == NULL)
  2c015b:	48 85 c9             	test   %rcx,%rcx
  2c015e:	74 08                	je     2c0168 <process_main+0x168>
	    break;
	total_pages++;
  2c0160:	83 c3 01             	add    $0x1,%ebx
	*((int *)ptr) = p; // check write access
  2c0163:	44 89 21             	mov    %r12d,(%rcx)
    while (1) {
  2c0166:	eb c7                	jmp    2c012f <process_main+0x12f>
    }

    app_printf(p, "Total_time taken to alloc: %d Average time: %d\n", total_time, total_time/total_pages);
  2c0168:	48 63 db             	movslq %ebx,%rbx
  2c016b:	4c 89 e8             	mov    %r13,%rax
  2c016e:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0173:	48 f7 f3             	div    %rbx
  2c0176:	48 89 c1             	mov    %rax,%rcx
  2c0179:	4c 89 ea             	mov    %r13,%rdx
  2c017c:	48 8d 35 15 16 00 00 	lea    0x1615(%rip),%rsi        # 2c1798 <console_clear+0xc4>
  2c0183:	44 89 e7             	mov    %r12d,%edi
  2c0186:	b8 00 00 00 00       	mov    $0x0,%eax
  2c018b:	e8 04 00 00 00       	call   2c0194 <app_printf>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  2c0190:	cd 32                	int    $0x32
  2c0192:	eb fc                	jmp    2c0190 <process_main+0x190>

00000000002c0194 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c0194:	f3 0f 1e fa          	endbr64 
  2c0198:	55                   	push   %rbp
  2c0199:	48 89 e5             	mov    %rsp,%rbp
  2c019c:	48 83 ec 50          	sub    $0x50,%rsp
  2c01a0:	49 89 f2             	mov    %rsi,%r10
  2c01a3:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c01a7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c01ab:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c01af:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c01b3:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  2c01b8:	85 ff                	test   %edi,%edi
  2c01ba:	78 32                	js     2c01ee <app_printf+0x5a>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c01bc:	48 63 ff             	movslq %edi,%rdi
  2c01bf:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c01c6:	cc cc cc 
  2c01c9:	48 89 f8             	mov    %rdi,%rax
  2c01cc:	48 f7 e2             	mul    %rdx
  2c01cf:	48 89 d0             	mov    %rdx,%rax
  2c01d2:	48 c1 e8 02          	shr    $0x2,%rax
  2c01d6:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c01da:	48 01 c2             	add    %rax,%rdx
  2c01dd:	48 29 d7             	sub    %rdx,%rdi
  2c01e0:	48 8d 05 16 16 00 00 	lea    0x1616(%rip),%rax        # 2c17fd <col.0>
  2c01e7:	0f b6 34 38          	movzbl (%rax,%rdi,1),%esi
  2c01eb:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  2c01ee:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c01f5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c01f9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c01fd:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c0201:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c0205:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c0209:	4c 89 d2             	mov    %r10,%rdx
  2c020c:	8b 3d ea 8d df ff    	mov    -0x207216(%rip),%edi        # b8ffc <cursorpos>
  2c0212:	e8 cb 12 00 00       	call   2c14e2 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c0217:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c021c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0221:	0f 4d c2             	cmovge %edx,%eax
  2c0224:	89 05 d2 8d df ff    	mov    %eax,-0x20722e(%rip)        # b8ffc <cursorpos>
    }
}
  2c022a:	c9                   	leave  
  2c022b:	c3                   	ret    

00000000002c022c <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  2c022c:	f3 0f 1e fa          	endbr64 
  2c0230:	55                   	push   %rbp
  2c0231:	48 89 e5             	mov    %rsp,%rbp
  2c0234:	53                   	push   %rbx
  2c0235:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c023c:	48 89 fb             	mov    %rdi,%rbx
  2c023f:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c0243:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c0247:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c024b:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c024f:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c0253:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c025a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c025e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c0262:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c0266:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c026a:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c0271:	ba 07 00 00 00       	mov    $0x7,%edx
  2c0276:	48 8d 35 4b 15 00 00 	lea    0x154b(%rip),%rsi        # 2c17c8 <console_clear+0xf4>
  2c027d:	e8 97 03 00 00       	call   2c0619 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0282:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0286:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c028d:	48 89 da             	mov    %rbx,%rdx
  2c0290:	be 99 00 00 00       	mov    $0x99,%esi
  2c0295:	e8 6c 13 00 00       	call   2c1606 <vsnprintf>
  2c029a:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c029d:	85 d2                	test   %edx,%edx
  2c029f:	7e 0f                	jle    2c02b0 <kernel_panic+0x84>
  2c02a1:	83 c0 06             	add    $0x6,%eax
  2c02a4:	48 98                	cltq   
  2c02a6:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c02ad:	0a 
  2c02ae:	75 2c                	jne    2c02dc <kernel_panic+0xb0>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c02b0:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c02b7:	48 89 d9             	mov    %rbx,%rcx
  2c02ba:	48 8d 15 0f 15 00 00 	lea    0x150f(%rip),%rdx        # 2c17d0 <console_clear+0xfc>
  2c02c1:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02c6:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02cb:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02d0:	e8 89 12 00 00       	call   2c155e <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  2c02d5:	48 89 df             	mov    %rbx,%rdi
  2c02d8:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  2c02da:	eb fe                	jmp    2c02da <kernel_panic+0xae>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c02dc:	48 63 c2             	movslq %edx,%rax
  2c02df:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c02e5:	0f 94 c2             	sete   %dl
  2c02e8:	0f b6 d2             	movzbl %dl,%edx
  2c02eb:	48 29 d0             	sub    %rdx,%rax
  2c02ee:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c02f5:	ff 
  2c02f6:	48 8d 35 66 14 00 00 	lea    0x1466(%rip),%rsi        # 2c1763 <console_clear+0x8f>
  2c02fd:	e8 d8 04 00 00       	call   2c07da <strcpy>
  2c0302:	eb ac                	jmp    2c02b0 <kernel_panic+0x84>

00000000002c0304 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c0304:	f3 0f 1e fa          	endbr64 
  2c0308:	55                   	push   %rbp
  2c0309:	48 89 e5             	mov    %rsp,%rbp
  2c030c:	48 89 f9             	mov    %rdi,%rcx
  2c030f:	41 89 f0             	mov    %esi,%r8d
  2c0312:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c0315:	48 8d 15 bc 14 00 00 	lea    0x14bc(%rip),%rdx        # 2c17d8 <console_clear+0x104>
  2c031c:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0321:	bf 30 07 00 00       	mov    $0x730,%edi
  2c0326:	b8 00 00 00 00       	mov    $0x0,%eax
  2c032b:	e8 2e 12 00 00       	call   2c155e <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0330:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0335:	cd 30                	int    $0x30
 loop: goto loop;
  2c0337:	eb fe                	jmp    2c0337 <assert_fail+0x33>

00000000002c0339 <algn>:
block* new_block(size_t size);
block* split_block(block* block, size_t size);
void add_to_free_list(block *b);
void remove_from_free_list(block *b);

size_t algn(size_t size){
  2c0339:	f3 0f 1e fa          	endbr64 
    return (size + 7) / 8 * 8;
  2c033d:	48 8d 47 07          	lea    0x7(%rdi),%rax
  2c0341:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
}
  2c0345:	c3                   	ret    

00000000002c0346 <new_block>:

block* new_block(size_t size){
  2c0346:	f3 0f 1e fa          	endbr64 
  2c034a:	48 89 fa             	mov    %rdi,%rdx
    void *bptr = sbrk(size + BLOCKSIZE);
  2c034d:	48 8d 7f 28          	lea    0x28(%rdi),%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c0351:	cd 3a                	int    $0x3a
  2c0353:	48 89 05 a6 1c 00 00 	mov    %rax,0x1ca6(%rip)        # 2c2000 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  2c035a:	48 89 c1             	mov    %rax,%rcx
    if (bptr == (void*) -1) {
  2c035d:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c0361:	74 26                	je     2c0389 <new_block+0x43>
        return NULL;
    }
    block* nblock = (block*)bptr;
    nblock->next = NULL;
  2c0363:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c036a:	00 
    nblock->size = size;
  2c036b:	48 89 10             	mov    %rdx,(%rax)
    nblock->free = 0;
  2c036e:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
    nblock->free_next = NULL;
  2c0375:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
  2c037c:	00 
    nblock->free_prev = NULL;
  2c037d:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
  2c0384:	00 
    return nblock;
}
  2c0385:	48 89 c8             	mov    %rcx,%rax
  2c0388:	c3                   	ret    
        return NULL;
  2c0389:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c038e:	eb f5                	jmp    2c0385 <new_block+0x3f>

00000000002c0390 <find_block>:

block* find_block(size_t size) {
  2c0390:	f3 0f 1e fa          	endbr64 
    block* curr = free_head;
  2c0394:	48 8b 05 6d 1c 00 00 	mov    0x1c6d(%rip),%rax        # 2c2008 <free_head>
    while (curr) {
  2c039b:	48 85 c0             	test   %rax,%rax
  2c039e:	74 0e                	je     2c03ae <find_block+0x1e>
        if (curr->size >= size) {
  2c03a0:	48 39 38             	cmp    %rdi,(%rax)
  2c03a3:	73 09                	jae    2c03ae <find_block+0x1e>
            return curr;
        }
        curr = curr->free_next;
  2c03a5:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (curr) {
  2c03a9:	48 85 c0             	test   %rax,%rax
  2c03ac:	75 f2                	jne    2c03a0 <find_block+0x10>
    }
    return NULL;
}
  2c03ae:	c3                   	ret    

00000000002c03af <add_to_free_list>:

    add_to_free_list(new);
    return new;
}

void add_to_free_list(block *b) {
  2c03af:	f3 0f 1e fa          	endbr64 
    b->free = 1;
  2c03b3:	c7 47 10 01 00 00 00 	movl   $0x1,0x10(%rdi)
    b->free_next = free_head;
  2c03ba:	48 8b 05 47 1c 00 00 	mov    0x1c47(%rip),%rax        # 2c2008 <free_head>
  2c03c1:	48 89 47 18          	mov    %rax,0x18(%rdi)
    b->free_prev = NULL;
  2c03c5:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  2c03cc:	00 
    if (free_head) {
  2c03cd:	48 85 c0             	test   %rax,%rax
  2c03d0:	74 04                	je     2c03d6 <add_to_free_list+0x27>
        free_head->free_prev = b;
  2c03d2:	48 89 78 20          	mov    %rdi,0x20(%rax)
    }
    free_head = b;
  2c03d6:	48 89 3d 2b 1c 00 00 	mov    %rdi,0x1c2b(%rip)        # 2c2008 <free_head>
}
  2c03dd:	c3                   	ret    

00000000002c03de <split_block>:
block* split_block(block* b, size_t size){
  2c03de:	f3 0f 1e fa          	endbr64 
  2c03e2:	55                   	push   %rbp
  2c03e3:	48 89 e5             	mov    %rsp,%rbp
  2c03e6:	53                   	push   %rbx
  2c03e7:	48 83 ec 08          	sub    $0x8,%rsp
    if (b->size < size + BLOCKSIZE) {
  2c03eb:	48 8b 07             	mov    (%rdi),%rax
  2c03ee:	48 8d 56 28          	lea    0x28(%rsi),%rdx
        return NULL;
  2c03f2:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (b->size < size + BLOCKSIZE) {
  2c03f7:	48 39 d0             	cmp    %rdx,%rax
  2c03fa:	72 30                	jb     2c042c <split_block+0x4e>
    void* nptr = (void*)b + BLOCKSIZE + size;
  2c03fc:	48 8d 1c 17          	lea    (%rdi,%rdx,1),%rbx
    new->size = b->size - size - BLOCKSIZE;
  2c0400:	48 29 f0             	sub    %rsi,%rax
  2c0403:	48 8d 40 d8          	lea    -0x28(%rax),%rax
  2c0407:	48 89 03             	mov    %rax,(%rbx)
    new->free = 1;
  2c040a:	c7 43 10 01 00 00 00 	movl   $0x1,0x10(%rbx)
    new->free_next = NULL;
  2c0411:	48 c7 43 18 00 00 00 	movq   $0x0,0x18(%rbx)
  2c0418:	00 
    new->free_prev = NULL;
  2c0419:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  2c0420:	00 
    b->size = size;
  2c0421:	48 89 37             	mov    %rsi,(%rdi)
    add_to_free_list(new);
  2c0424:	48 89 df             	mov    %rbx,%rdi
  2c0427:	e8 83 ff ff ff       	call   2c03af <add_to_free_list>
}
  2c042c:	48 89 d8             	mov    %rbx,%rax
  2c042f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0433:	c9                   	leave  
  2c0434:	c3                   	ret    

00000000002c0435 <remove_from_free_list>:

void remove_from_free_list(block *b) {
  2c0435:	f3 0f 1e fa          	endbr64 
    if (b->free_prev) {
  2c0439:	48 8b 47 20          	mov    0x20(%rdi),%rax
  2c043d:	48 85 c0             	test   %rax,%rax
  2c0440:	74 31                	je     2c0473 <remove_from_free_list+0x3e>
        b->free_prev->free_next = b->free_next;
  2c0442:	48 8b 57 18          	mov    0x18(%rdi),%rdx
  2c0446:	48 89 50 18          	mov    %rdx,0x18(%rax)
    } else {
        free_head = b->free_next;
    }
    if (b->free_next) {
  2c044a:	48 8b 47 18          	mov    0x18(%rdi),%rax
  2c044e:	48 85 c0             	test   %rax,%rax
  2c0451:	74 08                	je     2c045b <remove_from_free_list+0x26>
        b->free_next->free_prev = b->free_prev;
  2c0453:	48 8b 57 20          	mov    0x20(%rdi),%rdx
  2c0457:	48 89 50 20          	mov    %rdx,0x20(%rax)
    }
    b->free = 0;
  2c045b:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->free_next = NULL;
  2c0462:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  2c0469:	00 
    b->free_prev = NULL;
  2c046a:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  2c0471:	00 
}
  2c0472:	c3                   	ret    
        free_head = b->free_next;
  2c0473:	48 8b 47 18          	mov    0x18(%rdi),%rax
  2c0477:	48 89 05 8a 1b 00 00 	mov    %rax,0x1b8a(%rip)        # 2c2008 <free_head>
  2c047e:	eb ca                	jmp    2c044a <remove_from_free_list+0x15>

00000000002c0480 <free>:

void free(void *firstbyte) {
  2c0480:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  2c0484:	48 85 ff             	test   %rdi,%rdi
  2c0487:	74 06                	je     2c048f <free+0xf>
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; // Prevent double-free
  2c0489:	83 7f e8 00          	cmpl   $0x0,-0x18(%rdi)
  2c048d:	74 01                	je     2c0490 <free+0x10>
  2c048f:	c3                   	ret    
void free(void *firstbyte) {
  2c0490:	55                   	push   %rbp
  2c0491:	48 89 e5             	mov    %rsp,%rbp
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
  2c0494:	48 83 ef 28          	sub    $0x28,%rdi
    add_to_free_list(b);
  2c0498:	e8 12 ff ff ff       	call   2c03af <add_to_free_list>
    // defrag();
}
  2c049d:	5d                   	pop    %rbp
  2c049e:	c3                   	ret    

00000000002c049f <malloc>:

void *malloc(uint64_t numbytes) {
  2c049f:	f3 0f 1e fa          	endbr64 
  2c04a3:	55                   	push   %rbp
  2c04a4:	48 89 e5             	mov    %rsp,%rbp
  2c04a7:	41 54                	push   %r12
  2c04a9:	53                   	push   %rbx
    return (size + 7) / 8 * 8;
  2c04aa:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  2c04ae:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    size_t size = algn(numbytes);
    block *b = find_block(size);
  2c04b2:	4c 89 e7             	mov    %r12,%rdi
  2c04b5:	e8 d6 fe ff ff       	call   2c0390 <find_block>
    if (b == NULL) {
  2c04ba:	48 85 c0             	test   %rax,%rax
  2c04bd:	74 21                	je     2c04e0 <malloc+0x41>
  2c04bf:	48 89 c3             	mov    %rax,%rbx
        b = new_block(size);
        if (b == NULL) {
            return NULL;
        }
    } else {
        remove_from_free_list(b);
  2c04c2:	48 89 c7             	mov    %rax,%rdi
  2c04c5:	e8 6b ff ff ff       	call   2c0435 <remove_from_free_list>
        if (b->size > size + BLOCKSIZE) {
  2c04ca:	49 8d 44 24 28       	lea    0x28(%r12),%rax
  2c04cf:	48 39 03             	cmp    %rax,(%rbx)
  2c04d2:	77 1e                	ja     2c04f2 <malloc+0x53>
            split_block(b, size);
        }
    }
    return (void*)((void*)b + BLOCKSIZE);
  2c04d4:	48 83 c3 28          	add    $0x28,%rbx
}
  2c04d8:	48 89 d8             	mov    %rbx,%rax
  2c04db:	5b                   	pop    %rbx
  2c04dc:	41 5c                	pop    %r12
  2c04de:	5d                   	pop    %rbp
  2c04df:	c3                   	ret    
        b = new_block(size);
  2c04e0:	4c 89 e7             	mov    %r12,%rdi
  2c04e3:	e8 5e fe ff ff       	call   2c0346 <new_block>
  2c04e8:	48 89 c3             	mov    %rax,%rbx
        if (b == NULL) {
  2c04eb:	48 85 c0             	test   %rax,%rax
  2c04ee:	75 e4                	jne    2c04d4 <malloc+0x35>
  2c04f0:	eb e6                	jmp    2c04d8 <malloc+0x39>
            split_block(b, size);
  2c04f2:	4c 89 e6             	mov    %r12,%rsi
  2c04f5:	48 89 df             	mov    %rbx,%rdi
  2c04f8:	e8 e1 fe ff ff       	call   2c03de <split_block>
  2c04fd:	eb d5                	jmp    2c04d4 <malloc+0x35>

00000000002c04ff <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  2c04ff:	f3 0f 1e fa          	endbr64 
  2c0503:	55                   	push   %rbp
  2c0504:	48 89 e5             	mov    %rsp,%rbp
  2c0507:	41 54                	push   %r12
  2c0509:	53                   	push   %rbx
    uint64_t total = num * sz;
  2c050a:	48 0f af fe          	imul   %rsi,%rdi
  2c050e:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  2c0511:	e8 89 ff ff ff       	call   2c049f <malloc>
  2c0516:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  2c0519:	48 85 c0             	test   %rax,%rax
  2c051c:	74 10                	je     2c052e <calloc+0x2f>
        memset(ptr, 0, total);
  2c051e:	4c 89 e2             	mov    %r12,%rdx
  2c0521:	be 00 00 00 00       	mov    $0x0,%esi
  2c0526:	48 89 c7             	mov    %rax,%rdi
  2c0529:	e8 f1 01 00 00       	call   2c071f <memset>
    }
    return ptr;
}
  2c052e:	48 89 d8             	mov    %rbx,%rax
  2c0531:	5b                   	pop    %rbx
  2c0532:	41 5c                	pop    %r12
  2c0534:	5d                   	pop    %rbp
  2c0535:	c3                   	ret    

00000000002c0536 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c0536:	f3 0f 1e fa          	endbr64 
  2c053a:	55                   	push   %rbp
  2c053b:	48 89 e5             	mov    %rsp,%rbp
  2c053e:	41 54                	push   %r12
  2c0540:	53                   	push   %rbx
  2c0541:	48 89 fb             	mov    %rdi,%rbx
  2c0544:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  2c0547:	48 85 db             	test   %rbx,%rbx
  2c054a:	74 2d                	je     2c0579 <realloc+0x43>
        return malloc(sz);
    }
    if (sz == 0) {
  2c054c:	48 85 f6             	test   %rsi,%rsi
  2c054f:	74 32                	je     2c0583 <realloc+0x4d>
    return (size + 7) / 8 * 8;
  2c0551:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  2c0555:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi
        return NULL;
    }
    block *b = (block*)((void*)ptr - BLOCKSIZE);
    size_t aligned_size = algn(sz);

    if (b->size >= aligned_size) {
  2c0559:	48 8b 43 d8          	mov    -0x28(%rbx),%rax
  2c055d:	48 39 f0             	cmp    %rsi,%rax
  2c0560:	72 31                	jb     2c0593 <realloc+0x5d>
        if (b->size > aligned_size + BLOCKSIZE) {
  2c0562:	48 8d 56 28          	lea    0x28(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr;
  2c0566:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  2c0569:	48 39 d0             	cmp    %rdx,%rax
  2c056c:	76 49                	jbe    2c05b7 <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE);
  2c056e:	48 8d 7b d8          	lea    -0x28(%rbx),%rdi
            split_block(b, aligned_size);
  2c0572:	e8 67 fe ff ff       	call   2c03de <split_block>
  2c0577:	eb 3e                	jmp    2c05b7 <realloc+0x81>
        return malloc(sz);
  2c0579:	e8 21 ff ff ff       	call   2c049f <malloc>
  2c057e:	49 89 c4             	mov    %rax,%r12
  2c0581:	eb 34                	jmp    2c05b7 <realloc+0x81>
        free(ptr);
  2c0583:	48 89 df             	mov    %rbx,%rdi
  2c0586:	e8 f5 fe ff ff       	call   2c0480 <free>
        return NULL;
  2c058b:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0591:	eb 24                	jmp    2c05b7 <realloc+0x81>
    }

    void *new_ptr = malloc(sz);
  2c0593:	e8 07 ff ff ff       	call   2c049f <malloc>
  2c0598:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  2c059b:	48 85 c0             	test   %rax,%rax
  2c059e:	74 17                	je     2c05b7 <realloc+0x81>
        return NULL;
    }
    memcpy(new_ptr, ptr, b->size);
  2c05a0:	48 8b 53 d8          	mov    -0x28(%rbx),%rdx
  2c05a4:	48 89 de             	mov    %rbx,%rsi
  2c05a7:	48 89 c7             	mov    %rax,%rdi
  2c05aa:	e8 6a 00 00 00       	call   2c0619 <memcpy>
    free(ptr);
  2c05af:	48 89 df             	mov    %rbx,%rdi
  2c05b2:	e8 c9 fe ff ff       	call   2c0480 <free>
    return new_ptr;
}
  2c05b7:	4c 89 e0             	mov    %r12,%rax
  2c05ba:	5b                   	pop    %rbx
  2c05bb:	41 5c                	pop    %r12
  2c05bd:	5d                   	pop    %rbp
  2c05be:	c3                   	ret    

00000000002c05bf <defrag>:

void defrag() {
  2c05bf:	f3 0f 1e fa          	endbr64 
  2c05c3:	55                   	push   %rbp
  2c05c4:	48 89 e5             	mov    %rsp,%rbp
  2c05c7:	41 54                	push   %r12
  2c05c9:	53                   	push   %rbx
    block *b = free_head;
  2c05ca:	48 8b 1d 37 1a 00 00 	mov    0x1a37(%rip),%rbx        # 2c2008 <free_head>
    while (b && b->free_next) {
  2c05d1:	48 85 db             	test   %rbx,%rbx
  2c05d4:	74 34                	je     2c060a <defrag+0x4b>
  2c05d6:	4c 8b 63 18          	mov    0x18(%rbx),%r12
  2c05da:	4d 85 e4             	test   %r12,%r12
  2c05dd:	74 2b                	je     2c060a <defrag+0x4b>
        if ((void*)b + BLOCKSIZE + b->size == (void*)b->free_next) {
  2c05df:	48 8b 03             	mov    (%rbx),%rax
  2c05e2:	48 8d 44 03 28       	lea    0x28(%rbx,%rax,1),%rax
  2c05e7:	49 39 c4             	cmp    %rax,%r12
  2c05ea:	74 05                	je     2c05f1 <defrag+0x32>
    while (b && b->free_next) {
  2c05ec:	4c 89 e3             	mov    %r12,%rbx
  2c05ef:	eb e0                	jmp    2c05d1 <defrag+0x12>
            block *next = b->free_next;
            remove_from_free_list(next);
  2c05f1:	4c 89 e7             	mov    %r12,%rdi
  2c05f4:	e8 3c fe ff ff       	call   2c0435 <remove_from_free_list>
            b->size += BLOCKSIZE + next->size;
  2c05f9:	48 8b 13             	mov    (%rbx),%rdx
  2c05fc:	49 8b 04 24          	mov    (%r12),%rax
  2c0600:	48 8d 44 02 28       	lea    0x28(%rdx,%rax,1),%rax
  2c0605:	48 89 03             	mov    %rax,(%rbx)
  2c0608:	eb c7                	jmp    2c05d1 <defrag+0x12>
        } else {
            b = b->free_next;
        }
    }
}
  2c060a:	5b                   	pop    %rbx
  2c060b:	41 5c                	pop    %r12
  2c060d:	5d                   	pop    %rbp
  2c060e:	c3                   	ret    

00000000002c060f <heap_info>:

int heap_info(heap_info_struct * info) {
  2c060f:	f3 0f 1e fa          	endbr64 
    return 0;
  2c0613:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0618:	c3                   	ret    

00000000002c0619 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0619:	f3 0f 1e fa          	endbr64 
  2c061d:	55                   	push   %rbp
  2c061e:	48 89 e5             	mov    %rsp,%rbp
  2c0621:	48 83 ec 28          	sub    $0x28,%rsp
  2c0625:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0629:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c062d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0631:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0635:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0639:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c063d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0641:	eb 1c                	jmp    2c065f <memcpy+0x46>
        *d = *s;
  2c0643:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0647:	0f b6 10             	movzbl (%rax),%edx
  2c064a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c064e:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0650:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0655:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c065a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c065f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0664:	75 dd                	jne    2c0643 <memcpy+0x2a>
    }
    return dst;
  2c0666:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c066a:	c9                   	leave  
  2c066b:	c3                   	ret    

00000000002c066c <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c066c:	f3 0f 1e fa          	endbr64 
  2c0670:	55                   	push   %rbp
  2c0671:	48 89 e5             	mov    %rsp,%rbp
  2c0674:	48 83 ec 28          	sub    $0x28,%rsp
  2c0678:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c067c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0680:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0684:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0688:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c068c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0690:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0694:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0698:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c069c:	73 6a                	jae    2c0708 <memmove+0x9c>
  2c069e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c06a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c06a6:	48 01 d0             	add    %rdx,%rax
  2c06a9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c06ad:	73 59                	jae    2c0708 <memmove+0x9c>
        s += n, d += n;
  2c06af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c06b3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c06b7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c06bb:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c06bf:	eb 17                	jmp    2c06d8 <memmove+0x6c>
            *--d = *--s;
  2c06c1:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c06c6:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c06cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06cf:	0f b6 10             	movzbl (%rax),%edx
  2c06d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c06d6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c06d8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c06dc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c06e0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c06e4:	48 85 c0             	test   %rax,%rax
  2c06e7:	75 d8                	jne    2c06c1 <memmove+0x55>
    if (s < d && s + n > d) {
  2c06e9:	eb 2e                	jmp    2c0719 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c06eb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c06ef:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c06f3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c06f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c06fb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c06ff:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0703:	0f b6 12             	movzbl (%rdx),%edx
  2c0706:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0708:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c070c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0710:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0714:	48 85 c0             	test   %rax,%rax
  2c0717:	75 d2                	jne    2c06eb <memmove+0x7f>
        }
    }
    return dst;
  2c0719:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c071d:	c9                   	leave  
  2c071e:	c3                   	ret    

00000000002c071f <memset>:

void* memset(void* v, int c, size_t n) {
  2c071f:	f3 0f 1e fa          	endbr64 
  2c0723:	55                   	push   %rbp
  2c0724:	48 89 e5             	mov    %rsp,%rbp
  2c0727:	48 83 ec 28          	sub    $0x28,%rsp
  2c072b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c072f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0732:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0736:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c073a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c073e:	eb 15                	jmp    2c0755 <memset+0x36>
        *p = c;
  2c0740:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0743:	89 c2                	mov    %eax,%edx
  2c0745:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0749:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c074b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0750:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0755:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c075a:	75 e4                	jne    2c0740 <memset+0x21>
    }
    return v;
  2c075c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0760:	c9                   	leave  
  2c0761:	c3                   	ret    

00000000002c0762 <strlen>:

size_t strlen(const char* s) {
  2c0762:	f3 0f 1e fa          	endbr64 
  2c0766:	55                   	push   %rbp
  2c0767:	48 89 e5             	mov    %rsp,%rbp
  2c076a:	48 83 ec 18          	sub    $0x18,%rsp
  2c076e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0772:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0779:	00 
  2c077a:	eb 0a                	jmp    2c0786 <strlen+0x24>
        ++n;
  2c077c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0781:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0786:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c078a:	0f b6 00             	movzbl (%rax),%eax
  2c078d:	84 c0                	test   %al,%al
  2c078f:	75 eb                	jne    2c077c <strlen+0x1a>
    }
    return n;
  2c0791:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0795:	c9                   	leave  
  2c0796:	c3                   	ret    

00000000002c0797 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0797:	f3 0f 1e fa          	endbr64 
  2c079b:	55                   	push   %rbp
  2c079c:	48 89 e5             	mov    %rsp,%rbp
  2c079f:	48 83 ec 20          	sub    $0x20,%rsp
  2c07a3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c07a7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c07ab:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c07b2:	00 
  2c07b3:	eb 0a                	jmp    2c07bf <strnlen+0x28>
        ++n;
  2c07b5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c07ba:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c07bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07c3:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c07c7:	74 0b                	je     2c07d4 <strnlen+0x3d>
  2c07c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c07cd:	0f b6 00             	movzbl (%rax),%eax
  2c07d0:	84 c0                	test   %al,%al
  2c07d2:	75 e1                	jne    2c07b5 <strnlen+0x1e>
    }
    return n;
  2c07d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c07d8:	c9                   	leave  
  2c07d9:	c3                   	ret    

00000000002c07da <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c07da:	f3 0f 1e fa          	endbr64 
  2c07de:	55                   	push   %rbp
  2c07df:	48 89 e5             	mov    %rsp,%rbp
  2c07e2:	48 83 ec 20          	sub    $0x20,%rsp
  2c07e6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c07ea:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c07ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c07f2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c07f6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c07fa:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c07fe:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0802:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0806:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c080a:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c080e:	0f b6 12             	movzbl (%rdx),%edx
  2c0811:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0813:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0817:	48 83 e8 01          	sub    $0x1,%rax
  2c081b:	0f b6 00             	movzbl (%rax),%eax
  2c081e:	84 c0                	test   %al,%al
  2c0820:	75 d4                	jne    2c07f6 <strcpy+0x1c>
    return dst;
  2c0822:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0826:	c9                   	leave  
  2c0827:	c3                   	ret    

00000000002c0828 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0828:	f3 0f 1e fa          	endbr64 
  2c082c:	55                   	push   %rbp
  2c082d:	48 89 e5             	mov    %rsp,%rbp
  2c0830:	48 83 ec 10          	sub    $0x10,%rsp
  2c0834:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0838:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c083c:	eb 0a                	jmp    2c0848 <strcmp+0x20>
        ++a, ++b;
  2c083e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0843:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0848:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c084c:	0f b6 00             	movzbl (%rax),%eax
  2c084f:	84 c0                	test   %al,%al
  2c0851:	74 1d                	je     2c0870 <strcmp+0x48>
  2c0853:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0857:	0f b6 00             	movzbl (%rax),%eax
  2c085a:	84 c0                	test   %al,%al
  2c085c:	74 12                	je     2c0870 <strcmp+0x48>
  2c085e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0862:	0f b6 10             	movzbl (%rax),%edx
  2c0865:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0869:	0f b6 00             	movzbl (%rax),%eax
  2c086c:	38 c2                	cmp    %al,%dl
  2c086e:	74 ce                	je     2c083e <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0870:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0874:	0f b6 00             	movzbl (%rax),%eax
  2c0877:	89 c2                	mov    %eax,%edx
  2c0879:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c087d:	0f b6 00             	movzbl (%rax),%eax
  2c0880:	38 c2                	cmp    %al,%dl
  2c0882:	0f 97 c0             	seta   %al
  2c0885:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0888:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c088c:	0f b6 00             	movzbl (%rax),%eax
  2c088f:	89 c1                	mov    %eax,%ecx
  2c0891:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0895:	0f b6 00             	movzbl (%rax),%eax
  2c0898:	38 c1                	cmp    %al,%cl
  2c089a:	0f 92 c0             	setb   %al
  2c089d:	0f b6 c8             	movzbl %al,%ecx
  2c08a0:	89 d0                	mov    %edx,%eax
  2c08a2:	29 c8                	sub    %ecx,%eax
}
  2c08a4:	c9                   	leave  
  2c08a5:	c3                   	ret    

00000000002c08a6 <strchr>:

char* strchr(const char* s, int c) {
  2c08a6:	f3 0f 1e fa          	endbr64 
  2c08aa:	55                   	push   %rbp
  2c08ab:	48 89 e5             	mov    %rsp,%rbp
  2c08ae:	48 83 ec 10          	sub    $0x10,%rsp
  2c08b2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c08b6:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c08b9:	eb 05                	jmp    2c08c0 <strchr+0x1a>
        ++s;
  2c08bb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c08c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08c4:	0f b6 00             	movzbl (%rax),%eax
  2c08c7:	84 c0                	test   %al,%al
  2c08c9:	74 0e                	je     2c08d9 <strchr+0x33>
  2c08cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08cf:	0f b6 00             	movzbl (%rax),%eax
  2c08d2:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c08d5:	38 d0                	cmp    %dl,%al
  2c08d7:	75 e2                	jne    2c08bb <strchr+0x15>
    }
    if (*s == (char) c) {
  2c08d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08dd:	0f b6 00             	movzbl (%rax),%eax
  2c08e0:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c08e3:	38 d0                	cmp    %dl,%al
  2c08e5:	75 06                	jne    2c08ed <strchr+0x47>
        return (char*) s;
  2c08e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08eb:	eb 05                	jmp    2c08f2 <strchr+0x4c>
    } else {
        return NULL;
  2c08ed:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c08f2:	c9                   	leave  
  2c08f3:	c3                   	ret    

00000000002c08f4 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c08f4:	f3 0f 1e fa          	endbr64 
  2c08f8:	55                   	push   %rbp
  2c08f9:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c08fc:	8b 05 0e 17 00 00    	mov    0x170e(%rip),%eax        # 2c2010 <rand_seed_set>
  2c0902:	85 c0                	test   %eax,%eax
  2c0904:	75 0a                	jne    2c0910 <rand+0x1c>
        srand(819234718U);
  2c0906:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c090b:	e8 24 00 00 00       	call   2c0934 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0910:	8b 05 fe 16 00 00    	mov    0x16fe(%rip),%eax        # 2c2014 <rand_seed>
  2c0916:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c091c:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0921:	89 05 ed 16 00 00    	mov    %eax,0x16ed(%rip)        # 2c2014 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0927:	8b 05 e7 16 00 00    	mov    0x16e7(%rip),%eax        # 2c2014 <rand_seed>
  2c092d:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0932:	5d                   	pop    %rbp
  2c0933:	c3                   	ret    

00000000002c0934 <srand>:

void srand(unsigned seed) {
  2c0934:	f3 0f 1e fa          	endbr64 
  2c0938:	55                   	push   %rbp
  2c0939:	48 89 e5             	mov    %rsp,%rbp
  2c093c:	48 83 ec 08          	sub    $0x8,%rsp
  2c0940:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0943:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0946:	89 05 c8 16 00 00    	mov    %eax,0x16c8(%rip)        # 2c2014 <rand_seed>
    rand_seed_set = 1;
  2c094c:	c7 05 ba 16 00 00 01 	movl   $0x1,0x16ba(%rip)        # 2c2010 <rand_seed_set>
  2c0953:	00 00 00 
}
  2c0956:	90                   	nop
  2c0957:	c9                   	leave  
  2c0958:	c3                   	ret    

00000000002c0959 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0959:	f3 0f 1e fa          	endbr64 
  2c095d:	55                   	push   %rbp
  2c095e:	48 89 e5             	mov    %rsp,%rbp
  2c0961:	48 83 ec 28          	sub    $0x28,%rsp
  2c0965:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0969:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c096d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0970:	48 8d 05 99 0f 00 00 	lea    0xf99(%rip),%rax        # 2c1910 <upper_digits.1>
  2c0977:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  2c097b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c097f:	79 0e                	jns    2c098f <fill_numbuf+0x36>
        digits = lower_digits;
  2c0981:	48 8d 05 a8 0f 00 00 	lea    0xfa8(%rip),%rax        # 2c1930 <lower_digits.0>
  2c0988:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  2c098c:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c098f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0994:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0998:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c099b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c099e:	48 63 c8             	movslq %eax,%rcx
  2c09a1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c09a5:	ba 00 00 00 00       	mov    $0x0,%edx
  2c09aa:	48 f7 f1             	div    %rcx
  2c09ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09b1:	48 01 d0             	add    %rdx,%rax
  2c09b4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c09b9:	0f b6 10             	movzbl (%rax),%edx
  2c09bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c09c0:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c09c2:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c09c5:	48 63 f0             	movslq %eax,%rsi
  2c09c8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c09cc:	ba 00 00 00 00       	mov    $0x0,%edx
  2c09d1:	48 f7 f6             	div    %rsi
  2c09d4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c09d8:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c09dd:	75 bc                	jne    2c099b <fill_numbuf+0x42>
    return numbuf_end;
  2c09df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c09e3:	c9                   	leave  
  2c09e4:	c3                   	ret    

00000000002c09e5 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c09e5:	f3 0f 1e fa          	endbr64 
  2c09e9:	55                   	push   %rbp
  2c09ea:	48 89 e5             	mov    %rsp,%rbp
  2c09ed:	53                   	push   %rbx
  2c09ee:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c09f5:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c09fc:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0a02:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0a09:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0a10:	e9 bd 09 00 00       	jmp    2c13d2 <printer_vprintf+0x9ed>
        if (*format != '%') {
  2c0a15:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a1c:	0f b6 00             	movzbl (%rax),%eax
  2c0a1f:	3c 25                	cmp    $0x25,%al
  2c0a21:	74 31                	je     2c0a54 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  2c0a23:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0a2a:	4c 8b 00             	mov    (%rax),%r8
  2c0a2d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a34:	0f b6 00             	movzbl (%rax),%eax
  2c0a37:	0f b6 c8             	movzbl %al,%ecx
  2c0a3a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0a40:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0a47:	89 ce                	mov    %ecx,%esi
  2c0a49:	48 89 c7             	mov    %rax,%rdi
  2c0a4c:	41 ff d0             	call   *%r8
            continue;
  2c0a4f:	e9 76 09 00 00       	jmp    2c13ca <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  2c0a54:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0a5b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0a62:	01 
  2c0a63:	eb 4d                	jmp    2c0ab2 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  2c0a65:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a6c:	0f b6 00             	movzbl (%rax),%eax
  2c0a6f:	0f be c0             	movsbl %al,%eax
  2c0a72:	89 c6                	mov    %eax,%esi
  2c0a74:	48 8d 05 95 0d 00 00 	lea    0xd95(%rip),%rax        # 2c1810 <flag_chars>
  2c0a7b:	48 89 c7             	mov    %rax,%rdi
  2c0a7e:	e8 23 fe ff ff       	call   2c08a6 <strchr>
  2c0a83:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0a87:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0a8c:	74 34                	je     2c0ac2 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  2c0a8e:	48 8d 15 7b 0d 00 00 	lea    0xd7b(%rip),%rdx        # 2c1810 <flag_chars>
  2c0a95:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0a99:	48 29 d0             	sub    %rdx,%rax
  2c0a9c:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0aa1:	89 c1                	mov    %eax,%ecx
  2c0aa3:	d3 e2                	shl    %cl,%edx
  2c0aa5:	89 d0                	mov    %edx,%eax
  2c0aa7:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0aaa:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0ab1:	01 
  2c0ab2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ab9:	0f b6 00             	movzbl (%rax),%eax
  2c0abc:	84 c0                	test   %al,%al
  2c0abe:	75 a5                	jne    2c0a65 <printer_vprintf+0x80>
  2c0ac0:	eb 01                	jmp    2c0ac3 <printer_vprintf+0xde>
            } else {
                break;
  2c0ac2:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0ac3:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0aca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ad1:	0f b6 00             	movzbl (%rax),%eax
  2c0ad4:	3c 30                	cmp    $0x30,%al
  2c0ad6:	7e 67                	jle    2c0b3f <printer_vprintf+0x15a>
  2c0ad8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0adf:	0f b6 00             	movzbl (%rax),%eax
  2c0ae2:	3c 39                	cmp    $0x39,%al
  2c0ae4:	7f 59                	jg     2c0b3f <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0ae6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0aed:	eb 2e                	jmp    2c0b1d <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  2c0aef:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0af2:	89 d0                	mov    %edx,%eax
  2c0af4:	c1 e0 02             	shl    $0x2,%eax
  2c0af7:	01 d0                	add    %edx,%eax
  2c0af9:	01 c0                	add    %eax,%eax
  2c0afb:	89 c1                	mov    %eax,%ecx
  2c0afd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b04:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0b08:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0b0f:	0f b6 00             	movzbl (%rax),%eax
  2c0b12:	0f be c0             	movsbl %al,%eax
  2c0b15:	01 c8                	add    %ecx,%eax
  2c0b17:	83 e8 30             	sub    $0x30,%eax
  2c0b1a:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0b1d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b24:	0f b6 00             	movzbl (%rax),%eax
  2c0b27:	3c 2f                	cmp    $0x2f,%al
  2c0b29:	0f 8e 85 00 00 00    	jle    2c0bb4 <printer_vprintf+0x1cf>
  2c0b2f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b36:	0f b6 00             	movzbl (%rax),%eax
  2c0b39:	3c 39                	cmp    $0x39,%al
  2c0b3b:	7e b2                	jle    2c0aef <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  2c0b3d:	eb 75                	jmp    2c0bb4 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  2c0b3f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b46:	0f b6 00             	movzbl (%rax),%eax
  2c0b49:	3c 2a                	cmp    $0x2a,%al
  2c0b4b:	75 68                	jne    2c0bb5 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  2c0b4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b54:	8b 00                	mov    (%rax),%eax
  2c0b56:	83 f8 2f             	cmp    $0x2f,%eax
  2c0b59:	77 30                	ja     2c0b8b <printer_vprintf+0x1a6>
  2c0b5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b62:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0b66:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b6d:	8b 00                	mov    (%rax),%eax
  2c0b6f:	89 c0                	mov    %eax,%eax
  2c0b71:	48 01 d0             	add    %rdx,%rax
  2c0b74:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b7b:	8b 12                	mov    (%rdx),%edx
  2c0b7d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0b80:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b87:	89 0a                	mov    %ecx,(%rdx)
  2c0b89:	eb 1a                	jmp    2c0ba5 <printer_vprintf+0x1c0>
  2c0b8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b92:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0b96:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0b9a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ba1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ba5:	8b 00                	mov    (%rax),%eax
  2c0ba7:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0baa:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0bb1:	01 
  2c0bb2:	eb 01                	jmp    2c0bb5 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  2c0bb4:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0bb5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0bbc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0bc3:	0f b6 00             	movzbl (%rax),%eax
  2c0bc6:	3c 2e                	cmp    $0x2e,%al
  2c0bc8:	0f 85 00 01 00 00    	jne    2c0cce <printer_vprintf+0x2e9>
            ++format;
  2c0bce:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0bd5:	01 
            if (*format >= '0' && *format <= '9') {
  2c0bd6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0bdd:	0f b6 00             	movzbl (%rax),%eax
  2c0be0:	3c 2f                	cmp    $0x2f,%al
  2c0be2:	7e 67                	jle    2c0c4b <printer_vprintf+0x266>
  2c0be4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0beb:	0f b6 00             	movzbl (%rax),%eax
  2c0bee:	3c 39                	cmp    $0x39,%al
  2c0bf0:	7f 59                	jg     2c0c4b <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0bf2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0bf9:	eb 2e                	jmp    2c0c29 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  2c0bfb:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0bfe:	89 d0                	mov    %edx,%eax
  2c0c00:	c1 e0 02             	shl    $0x2,%eax
  2c0c03:	01 d0                	add    %edx,%eax
  2c0c05:	01 c0                	add    %eax,%eax
  2c0c07:	89 c1                	mov    %eax,%ecx
  2c0c09:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c10:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0c14:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0c1b:	0f b6 00             	movzbl (%rax),%eax
  2c0c1e:	0f be c0             	movsbl %al,%eax
  2c0c21:	01 c8                	add    %ecx,%eax
  2c0c23:	83 e8 30             	sub    $0x30,%eax
  2c0c26:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0c29:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c30:	0f b6 00             	movzbl (%rax),%eax
  2c0c33:	3c 2f                	cmp    $0x2f,%al
  2c0c35:	0f 8e 85 00 00 00    	jle    2c0cc0 <printer_vprintf+0x2db>
  2c0c3b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c42:	0f b6 00             	movzbl (%rax),%eax
  2c0c45:	3c 39                	cmp    $0x39,%al
  2c0c47:	7e b2                	jle    2c0bfb <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  2c0c49:	eb 75                	jmp    2c0cc0 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  2c0c4b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c52:	0f b6 00             	movzbl (%rax),%eax
  2c0c55:	3c 2a                	cmp    $0x2a,%al
  2c0c57:	75 68                	jne    2c0cc1 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  2c0c59:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c60:	8b 00                	mov    (%rax),%eax
  2c0c62:	83 f8 2f             	cmp    $0x2f,%eax
  2c0c65:	77 30                	ja     2c0c97 <printer_vprintf+0x2b2>
  2c0c67:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c6e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0c72:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c79:	8b 00                	mov    (%rax),%eax
  2c0c7b:	89 c0                	mov    %eax,%eax
  2c0c7d:	48 01 d0             	add    %rdx,%rax
  2c0c80:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c87:	8b 12                	mov    (%rdx),%edx
  2c0c89:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0c8c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c93:	89 0a                	mov    %ecx,(%rdx)
  2c0c95:	eb 1a                	jmp    2c0cb1 <printer_vprintf+0x2cc>
  2c0c97:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c9e:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ca2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ca6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cad:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0cb1:	8b 00                	mov    (%rax),%eax
  2c0cb3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0cb6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0cbd:	01 
  2c0cbe:	eb 01                	jmp    2c0cc1 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  2c0cc0:	90                   	nop
            }
            if (precision < 0) {
  2c0cc1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0cc5:	79 07                	jns    2c0cce <printer_vprintf+0x2e9>
                precision = 0;
  2c0cc7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0cce:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0cd5:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0cdc:	00 
        int length = 0;
  2c0cdd:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0ce4:	48 8d 05 2b 0b 00 00 	lea    0xb2b(%rip),%rax        # 2c1816 <flag_chars+0x6>
  2c0ceb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  2c0cef:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0cf6:	0f b6 00             	movzbl (%rax),%eax
  2c0cf9:	0f be c0             	movsbl %al,%eax
  2c0cfc:	83 e8 43             	sub    $0x43,%eax
  2c0cff:	83 f8 37             	cmp    $0x37,%eax
  2c0d02:	0f 87 b6 03 00 00    	ja     2c10be <printer_vprintf+0x6d9>
  2c0d08:	89 c0                	mov    %eax,%eax
  2c0d0a:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  2c0d11:	00 
  2c0d12:	48 8d 05 0b 0b 00 00 	lea    0xb0b(%rip),%rax        # 2c1824 <flag_chars+0x14>
  2c0d19:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  2c0d1c:	48 98                	cltq   
  2c0d1e:	48 8d 15 ff 0a 00 00 	lea    0xaff(%rip),%rdx        # 2c1824 <flag_chars+0x14>
  2c0d25:	48 01 d0             	add    %rdx,%rax
  2c0d28:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0d2b:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0d32:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0d39:	01 
            goto again;
  2c0d3a:	eb b3                	jmp    2c0cef <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0d3c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0d40:	74 5d                	je     2c0d9f <printer_vprintf+0x3ba>
  2c0d42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d49:	8b 00                	mov    (%rax),%eax
  2c0d4b:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d4e:	77 30                	ja     2c0d80 <printer_vprintf+0x39b>
  2c0d50:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d57:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0d5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d62:	8b 00                	mov    (%rax),%eax
  2c0d64:	89 c0                	mov    %eax,%eax
  2c0d66:	48 01 d0             	add    %rdx,%rax
  2c0d69:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d70:	8b 12                	mov    (%rdx),%edx
  2c0d72:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0d75:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d7c:	89 0a                	mov    %ecx,(%rdx)
  2c0d7e:	eb 1a                	jmp    2c0d9a <printer_vprintf+0x3b5>
  2c0d80:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d87:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d8b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d8f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d96:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d9a:	48 8b 00             	mov    (%rax),%rax
  2c0d9d:	eb 5c                	jmp    2c0dfb <printer_vprintf+0x416>
  2c0d9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0da6:	8b 00                	mov    (%rax),%eax
  2c0da8:	83 f8 2f             	cmp    $0x2f,%eax
  2c0dab:	77 30                	ja     2c0ddd <printer_vprintf+0x3f8>
  2c0dad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0db4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0db8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dbf:	8b 00                	mov    (%rax),%eax
  2c0dc1:	89 c0                	mov    %eax,%eax
  2c0dc3:	48 01 d0             	add    %rdx,%rax
  2c0dc6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dcd:	8b 12                	mov    (%rdx),%edx
  2c0dcf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0dd2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dd9:	89 0a                	mov    %ecx,(%rdx)
  2c0ddb:	eb 1a                	jmp    2c0df7 <printer_vprintf+0x412>
  2c0ddd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0de4:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0de8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0dec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0df3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0df7:	8b 00                	mov    (%rax),%eax
  2c0df9:	48 98                	cltq   
  2c0dfb:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0dff:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e03:	48 c1 f8 38          	sar    $0x38,%rax
  2c0e07:	25 80 00 00 00       	and    $0x80,%eax
  2c0e0c:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0e0f:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0e13:	74 09                	je     2c0e1e <printer_vprintf+0x439>
  2c0e15:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e19:	48 f7 d8             	neg    %rax
  2c0e1c:	eb 04                	jmp    2c0e22 <printer_vprintf+0x43d>
  2c0e1e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0e22:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0e26:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0e29:	83 c8 60             	or     $0x60,%eax
  2c0e2c:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0e2f:	e9 cf 02 00 00       	jmp    2c1103 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0e34:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0e38:	74 5d                	je     2c0e97 <printer_vprintf+0x4b2>
  2c0e3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e41:	8b 00                	mov    (%rax),%eax
  2c0e43:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e46:	77 30                	ja     2c0e78 <printer_vprintf+0x493>
  2c0e48:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e4f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e53:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e5a:	8b 00                	mov    (%rax),%eax
  2c0e5c:	89 c0                	mov    %eax,%eax
  2c0e5e:	48 01 d0             	add    %rdx,%rax
  2c0e61:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e68:	8b 12                	mov    (%rdx),%edx
  2c0e6a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0e6d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e74:	89 0a                	mov    %ecx,(%rdx)
  2c0e76:	eb 1a                	jmp    2c0e92 <printer_vprintf+0x4ad>
  2c0e78:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e7f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e83:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e87:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e8e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e92:	48 8b 00             	mov    (%rax),%rax
  2c0e95:	eb 5c                	jmp    2c0ef3 <printer_vprintf+0x50e>
  2c0e97:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e9e:	8b 00                	mov    (%rax),%eax
  2c0ea0:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ea3:	77 30                	ja     2c0ed5 <printer_vprintf+0x4f0>
  2c0ea5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0eac:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0eb0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0eb7:	8b 00                	mov    (%rax),%eax
  2c0eb9:	89 c0                	mov    %eax,%eax
  2c0ebb:	48 01 d0             	add    %rdx,%rax
  2c0ebe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ec5:	8b 12                	mov    (%rdx),%edx
  2c0ec7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0eca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ed1:	89 0a                	mov    %ecx,(%rdx)
  2c0ed3:	eb 1a                	jmp    2c0eef <printer_vprintf+0x50a>
  2c0ed5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0edc:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ee0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ee4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0eeb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0eef:	8b 00                	mov    (%rax),%eax
  2c0ef1:	89 c0                	mov    %eax,%eax
  2c0ef3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c0ef7:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c0efb:	e9 03 02 00 00       	jmp    2c1103 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  2c0f00:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c0f07:	e9 28 ff ff ff       	jmp    2c0e34 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  2c0f0c:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c0f13:	e9 1c ff ff ff       	jmp    2c0e34 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c0f18:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f1f:	8b 00                	mov    (%rax),%eax
  2c0f21:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f24:	77 30                	ja     2c0f56 <printer_vprintf+0x571>
  2c0f26:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f2d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f31:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f38:	8b 00                	mov    (%rax),%eax
  2c0f3a:	89 c0                	mov    %eax,%eax
  2c0f3c:	48 01 d0             	add    %rdx,%rax
  2c0f3f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f46:	8b 12                	mov    (%rdx),%edx
  2c0f48:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f4b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f52:	89 0a                	mov    %ecx,(%rdx)
  2c0f54:	eb 1a                	jmp    2c0f70 <printer_vprintf+0x58b>
  2c0f56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f5d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f61:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f65:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f6c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f70:	48 8b 00             	mov    (%rax),%rax
  2c0f73:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c0f77:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c0f7e:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c0f85:	e9 79 01 00 00       	jmp    2c1103 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  2c0f8a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f91:	8b 00                	mov    (%rax),%eax
  2c0f93:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f96:	77 30                	ja     2c0fc8 <printer_vprintf+0x5e3>
  2c0f98:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f9f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0fa3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0faa:	8b 00                	mov    (%rax),%eax
  2c0fac:	89 c0                	mov    %eax,%eax
  2c0fae:	48 01 d0             	add    %rdx,%rax
  2c0fb1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fb8:	8b 12                	mov    (%rdx),%edx
  2c0fba:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0fbd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fc4:	89 0a                	mov    %ecx,(%rdx)
  2c0fc6:	eb 1a                	jmp    2c0fe2 <printer_vprintf+0x5fd>
  2c0fc8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fcf:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0fd3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0fd7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fde:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0fe2:	48 8b 00             	mov    (%rax),%rax
  2c0fe5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c0fe9:	e9 15 01 00 00       	jmp    2c1103 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  2c0fee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ff5:	8b 00                	mov    (%rax),%eax
  2c0ff7:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ffa:	77 30                	ja     2c102c <printer_vprintf+0x647>
  2c0ffc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1003:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1007:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c100e:	8b 00                	mov    (%rax),%eax
  2c1010:	89 c0                	mov    %eax,%eax
  2c1012:	48 01 d0             	add    %rdx,%rax
  2c1015:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c101c:	8b 12                	mov    (%rdx),%edx
  2c101e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1021:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1028:	89 0a                	mov    %ecx,(%rdx)
  2c102a:	eb 1a                	jmp    2c1046 <printer_vprintf+0x661>
  2c102c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1033:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1037:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c103b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1042:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1046:	8b 00                	mov    (%rax),%eax
  2c1048:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c104e:	e9 77 03 00 00       	jmp    2c13ca <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  2c1053:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1057:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c105b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1062:	8b 00                	mov    (%rax),%eax
  2c1064:	83 f8 2f             	cmp    $0x2f,%eax
  2c1067:	77 30                	ja     2c1099 <printer_vprintf+0x6b4>
  2c1069:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1070:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1074:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c107b:	8b 00                	mov    (%rax),%eax
  2c107d:	89 c0                	mov    %eax,%eax
  2c107f:	48 01 d0             	add    %rdx,%rax
  2c1082:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1089:	8b 12                	mov    (%rdx),%edx
  2c108b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c108e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1095:	89 0a                	mov    %ecx,(%rdx)
  2c1097:	eb 1a                	jmp    2c10b3 <printer_vprintf+0x6ce>
  2c1099:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10a0:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c10a4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c10a8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10af:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c10b3:	8b 00                	mov    (%rax),%eax
  2c10b5:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c10b8:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c10bc:	eb 45                	jmp    2c1103 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  2c10be:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c10c2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c10c6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c10cd:	0f b6 00             	movzbl (%rax),%eax
  2c10d0:	84 c0                	test   %al,%al
  2c10d2:	74 0c                	je     2c10e0 <printer_vprintf+0x6fb>
  2c10d4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c10db:	0f b6 00             	movzbl (%rax),%eax
  2c10de:	eb 05                	jmp    2c10e5 <printer_vprintf+0x700>
  2c10e0:	b8 25 00 00 00       	mov    $0x25,%eax
  2c10e5:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c10e8:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c10ec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c10f3:	0f b6 00             	movzbl (%rax),%eax
  2c10f6:	84 c0                	test   %al,%al
  2c10f8:	75 08                	jne    2c1102 <printer_vprintf+0x71d>
                format--;
  2c10fa:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c1101:	01 
            }
            break;
  2c1102:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c1103:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1106:	83 e0 20             	and    $0x20,%eax
  2c1109:	85 c0                	test   %eax,%eax
  2c110b:	74 1e                	je     2c112b <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c110d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1111:	48 83 c0 18          	add    $0x18,%rax
  2c1115:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1118:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c111c:	48 89 ce             	mov    %rcx,%rsi
  2c111f:	48 89 c7             	mov    %rax,%rdi
  2c1122:	e8 32 f8 ff ff       	call   2c0959 <fill_numbuf>
  2c1127:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c112b:	48 8d 05 e4 06 00 00 	lea    0x6e4(%rip),%rax        # 2c1816 <flag_chars+0x6>
  2c1132:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c1136:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1139:	83 e0 20             	and    $0x20,%eax
  2c113c:	85 c0                	test   %eax,%eax
  2c113e:	74 51                	je     2c1191 <printer_vprintf+0x7ac>
  2c1140:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1143:	83 e0 40             	and    $0x40,%eax
  2c1146:	85 c0                	test   %eax,%eax
  2c1148:	74 47                	je     2c1191 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  2c114a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c114d:	25 80 00 00 00       	and    $0x80,%eax
  2c1152:	85 c0                	test   %eax,%eax
  2c1154:	74 0d                	je     2c1163 <printer_vprintf+0x77e>
                prefix = "-";
  2c1156:	48 8d 05 ba 06 00 00 	lea    0x6ba(%rip),%rax        # 2c1817 <flag_chars+0x7>
  2c115d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c1161:	eb 7d                	jmp    2c11e0 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c1163:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1166:	83 e0 10             	and    $0x10,%eax
  2c1169:	85 c0                	test   %eax,%eax
  2c116b:	74 0d                	je     2c117a <printer_vprintf+0x795>
                prefix = "+";
  2c116d:	48 8d 05 a5 06 00 00 	lea    0x6a5(%rip),%rax        # 2c1819 <flag_chars+0x9>
  2c1174:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c1178:	eb 66                	jmp    2c11e0 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c117a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c117d:	83 e0 08             	and    $0x8,%eax
  2c1180:	85 c0                	test   %eax,%eax
  2c1182:	74 5c                	je     2c11e0 <printer_vprintf+0x7fb>
                prefix = " ";
  2c1184:	48 8d 05 90 06 00 00 	lea    0x690(%rip),%rax        # 2c181b <flag_chars+0xb>
  2c118b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c118f:	eb 4f                	jmp    2c11e0 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c1191:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1194:	83 e0 20             	and    $0x20,%eax
  2c1197:	85 c0                	test   %eax,%eax
  2c1199:	74 46                	je     2c11e1 <printer_vprintf+0x7fc>
  2c119b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c119e:	83 e0 01             	and    $0x1,%eax
  2c11a1:	85 c0                	test   %eax,%eax
  2c11a3:	74 3c                	je     2c11e1 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  2c11a5:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c11a9:	74 06                	je     2c11b1 <printer_vprintf+0x7cc>
  2c11ab:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c11af:	75 30                	jne    2c11e1 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  2c11b1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c11b6:	75 0c                	jne    2c11c4 <printer_vprintf+0x7df>
  2c11b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11bb:	25 00 01 00 00       	and    $0x100,%eax
  2c11c0:	85 c0                	test   %eax,%eax
  2c11c2:	74 1d                	je     2c11e1 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  2c11c4:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c11c8:	75 09                	jne    2c11d3 <printer_vprintf+0x7ee>
  2c11ca:	48 8d 05 4c 06 00 00 	lea    0x64c(%rip),%rax        # 2c181d <flag_chars+0xd>
  2c11d1:	eb 07                	jmp    2c11da <printer_vprintf+0x7f5>
  2c11d3:	48 8d 05 46 06 00 00 	lea    0x646(%rip),%rax        # 2c1820 <flag_chars+0x10>
  2c11da:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c11de:	eb 01                	jmp    2c11e1 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  2c11e0:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c11e1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c11e5:	78 24                	js     2c120b <printer_vprintf+0x826>
  2c11e7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11ea:	83 e0 20             	and    $0x20,%eax
  2c11ed:	85 c0                	test   %eax,%eax
  2c11ef:	75 1a                	jne    2c120b <printer_vprintf+0x826>
            len = strnlen(data, precision);
  2c11f1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c11f4:	48 63 d0             	movslq %eax,%rdx
  2c11f7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c11fb:	48 89 d6             	mov    %rdx,%rsi
  2c11fe:	48 89 c7             	mov    %rax,%rdi
  2c1201:	e8 91 f5 ff ff       	call   2c0797 <strnlen>
  2c1206:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c1209:	eb 0f                	jmp    2c121a <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  2c120b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c120f:	48 89 c7             	mov    %rax,%rdi
  2c1212:	e8 4b f5 ff ff       	call   2c0762 <strlen>
  2c1217:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c121a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c121d:	83 e0 20             	and    $0x20,%eax
  2c1220:	85 c0                	test   %eax,%eax
  2c1222:	74 20                	je     2c1244 <printer_vprintf+0x85f>
  2c1224:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1228:	78 1a                	js     2c1244 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  2c122a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c122d:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c1230:	7e 08                	jle    2c123a <printer_vprintf+0x855>
  2c1232:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1235:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1238:	eb 05                	jmp    2c123f <printer_vprintf+0x85a>
  2c123a:	b8 00 00 00 00       	mov    $0x0,%eax
  2c123f:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1242:	eb 5c                	jmp    2c12a0 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c1244:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1247:	83 e0 20             	and    $0x20,%eax
  2c124a:	85 c0                	test   %eax,%eax
  2c124c:	74 4b                	je     2c1299 <printer_vprintf+0x8b4>
  2c124e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1251:	83 e0 02             	and    $0x2,%eax
  2c1254:	85 c0                	test   %eax,%eax
  2c1256:	74 41                	je     2c1299 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c1258:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c125b:	83 e0 04             	and    $0x4,%eax
  2c125e:	85 c0                	test   %eax,%eax
  2c1260:	75 37                	jne    2c1299 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  2c1262:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1266:	48 89 c7             	mov    %rax,%rdi
  2c1269:	e8 f4 f4 ff ff       	call   2c0762 <strlen>
  2c126e:	89 c2                	mov    %eax,%edx
  2c1270:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c1273:	01 d0                	add    %edx,%eax
  2c1275:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c1278:	7e 1f                	jle    2c1299 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  2c127a:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c127d:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1280:	89 c3                	mov    %eax,%ebx
  2c1282:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1286:	48 89 c7             	mov    %rax,%rdi
  2c1289:	e8 d4 f4 ff ff       	call   2c0762 <strlen>
  2c128e:	89 c2                	mov    %eax,%edx
  2c1290:	89 d8                	mov    %ebx,%eax
  2c1292:	29 d0                	sub    %edx,%eax
  2c1294:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1297:	eb 07                	jmp    2c12a0 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  2c1299:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c12a0:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c12a3:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c12a6:	01 d0                	add    %edx,%eax
  2c12a8:	48 63 d8             	movslq %eax,%rbx
  2c12ab:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c12af:	48 89 c7             	mov    %rax,%rdi
  2c12b2:	e8 ab f4 ff ff       	call   2c0762 <strlen>
  2c12b7:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c12bb:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c12be:	29 d0                	sub    %edx,%eax
  2c12c0:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c12c3:	eb 25                	jmp    2c12ea <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  2c12c5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c12cc:	48 8b 08             	mov    (%rax),%rcx
  2c12cf:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c12d5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c12dc:	be 20 00 00 00       	mov    $0x20,%esi
  2c12e1:	48 89 c7             	mov    %rax,%rdi
  2c12e4:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c12e6:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c12ea:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c12ed:	83 e0 04             	and    $0x4,%eax
  2c12f0:	85 c0                	test   %eax,%eax
  2c12f2:	75 36                	jne    2c132a <printer_vprintf+0x945>
  2c12f4:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c12f8:	7f cb                	jg     2c12c5 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  2c12fa:	eb 2e                	jmp    2c132a <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  2c12fc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1303:	4c 8b 00             	mov    (%rax),%r8
  2c1306:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c130a:	0f b6 00             	movzbl (%rax),%eax
  2c130d:	0f b6 c8             	movzbl %al,%ecx
  2c1310:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1316:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c131d:	89 ce                	mov    %ecx,%esi
  2c131f:	48 89 c7             	mov    %rax,%rdi
  2c1322:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1325:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c132a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c132e:	0f b6 00             	movzbl (%rax),%eax
  2c1331:	84 c0                	test   %al,%al
  2c1333:	75 c7                	jne    2c12fc <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  2c1335:	eb 25                	jmp    2c135c <printer_vprintf+0x977>
            p->putc(p, '0', color);
  2c1337:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c133e:	48 8b 08             	mov    (%rax),%rcx
  2c1341:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1347:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c134e:	be 30 00 00 00       	mov    $0x30,%esi
  2c1353:	48 89 c7             	mov    %rax,%rdi
  2c1356:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c1358:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c135c:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c1360:	7f d5                	jg     2c1337 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  2c1362:	eb 32                	jmp    2c1396 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  2c1364:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c136b:	4c 8b 00             	mov    (%rax),%r8
  2c136e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1372:	0f b6 00             	movzbl (%rax),%eax
  2c1375:	0f b6 c8             	movzbl %al,%ecx
  2c1378:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c137e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1385:	89 ce                	mov    %ecx,%esi
  2c1387:	48 89 c7             	mov    %rax,%rdi
  2c138a:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c138d:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c1392:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c1396:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c139a:	7f c8                	jg     2c1364 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  2c139c:	eb 25                	jmp    2c13c3 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  2c139e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13a5:	48 8b 08             	mov    (%rax),%rcx
  2c13a8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c13ae:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c13b5:	be 20 00 00 00       	mov    $0x20,%esi
  2c13ba:	48 89 c7             	mov    %rax,%rdi
  2c13bd:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c13bf:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c13c3:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c13c7:	7f d5                	jg     2c139e <printer_vprintf+0x9b9>
        }
    done: ;
  2c13c9:	90                   	nop
    for (; *format; ++format) {
  2c13ca:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c13d1:	01 
  2c13d2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c13d9:	0f b6 00             	movzbl (%rax),%eax
  2c13dc:	84 c0                	test   %al,%al
  2c13de:	0f 85 31 f6 ff ff    	jne    2c0a15 <printer_vprintf+0x30>
    }
}
  2c13e4:	90                   	nop
  2c13e5:	90                   	nop
  2c13e6:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c13ea:	c9                   	leave  
  2c13eb:	c3                   	ret    

00000000002c13ec <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c13ec:	f3 0f 1e fa          	endbr64 
  2c13f0:	55                   	push   %rbp
  2c13f1:	48 89 e5             	mov    %rsp,%rbp
  2c13f4:	48 83 ec 20          	sub    $0x20,%rsp
  2c13f8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c13fc:	89 f0                	mov    %esi,%eax
  2c13fe:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1401:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1404:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1408:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c140c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1410:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1414:	48 8d 15 85 7b df ff 	lea    -0x20847b(%rip),%rdx        # b8fa0 <console+0xfa0>
  2c141b:	48 39 d0             	cmp    %rdx,%rax
  2c141e:	72 0f                	jb     2c142f <console_putc+0x43>
        cp->cursor = console;
  2c1420:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1424:	48 8d 15 d5 6b df ff 	lea    -0x20942b(%rip),%rdx        # b8000 <console>
  2c142b:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  2c142f:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c1433:	0f 85 82 00 00 00    	jne    2c14bb <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  2c1439:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c143d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1441:	48 8d 15 b8 6b df ff 	lea    -0x209448(%rip),%rdx        # b8000 <console>
  2c1448:	48 29 d0             	sub    %rdx,%rax
  2c144b:	48 d1 f8             	sar    %rax
  2c144e:	48 89 c1             	mov    %rax,%rcx
  2c1451:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1458:	66 66 66 
  2c145b:	48 89 c8             	mov    %rcx,%rax
  2c145e:	48 f7 ea             	imul   %rdx
  2c1461:	48 89 d0             	mov    %rdx,%rax
  2c1464:	48 c1 f8 05          	sar    $0x5,%rax
  2c1468:	48 89 ce             	mov    %rcx,%rsi
  2c146b:	48 c1 fe 3f          	sar    $0x3f,%rsi
  2c146f:	48 29 f0             	sub    %rsi,%rax
  2c1472:	48 89 c2             	mov    %rax,%rdx
  2c1475:	48 89 d0             	mov    %rdx,%rax
  2c1478:	48 c1 e0 02          	shl    $0x2,%rax
  2c147c:	48 01 d0             	add    %rdx,%rax
  2c147f:	48 c1 e0 04          	shl    $0x4,%rax
  2c1483:	48 29 c1             	sub    %rax,%rcx
  2c1486:	48 89 ca             	mov    %rcx,%rdx
  2c1489:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c148c:	eb 25                	jmp    2c14b3 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  2c148e:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1491:	83 c8 20             	or     $0x20,%eax
  2c1494:	89 c6                	mov    %eax,%esi
  2c1496:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c149a:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c149e:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c14a2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c14a6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14aa:	89 f2                	mov    %esi,%edx
  2c14ac:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c14af:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c14b3:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c14b7:	75 d5                	jne    2c148e <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c14b9:	eb 24                	jmp    2c14df <console_putc+0xf3>
        *cp->cursor++ = c | color;
  2c14bb:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c14bf:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c14c2:	89 d6                	mov    %edx,%esi
  2c14c4:	09 c6                	or     %eax,%esi
  2c14c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c14ca:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14ce:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c14d2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c14d6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14da:	89 f2                	mov    %esi,%edx
  2c14dc:	66 89 10             	mov    %dx,(%rax)
}
  2c14df:	90                   	nop
  2c14e0:	c9                   	leave  
  2c14e1:	c3                   	ret    

00000000002c14e2 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c14e2:	f3 0f 1e fa          	endbr64 
  2c14e6:	55                   	push   %rbp
  2c14e7:	48 89 e5             	mov    %rsp,%rbp
  2c14ea:	48 83 ec 30          	sub    $0x30,%rsp
  2c14ee:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c14f1:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c14f4:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c14f8:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c14fc:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 2c13ec <console_putc>
  2c1503:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1507:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c150b:	78 09                	js     2c1516 <console_vprintf+0x34>
  2c150d:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1514:	7e 07                	jle    2c151d <console_vprintf+0x3b>
        cpos = 0;
  2c1516:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c151d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1520:	48 98                	cltq   
  2c1522:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c1526:	48 8d 05 d3 6a df ff 	lea    -0x20952d(%rip),%rax        # b8000 <console>
  2c152d:	48 01 d0             	add    %rdx,%rax
  2c1530:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1534:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1538:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c153c:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c153f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1543:	48 89 c7             	mov    %rax,%rdi
  2c1546:	e8 9a f4 ff ff       	call   2c09e5 <printer_vprintf>
    return cp.cursor - console;
  2c154b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c154f:	48 8d 15 aa 6a df ff 	lea    -0x209556(%rip),%rdx        # b8000 <console>
  2c1556:	48 29 d0             	sub    %rdx,%rax
  2c1559:	48 d1 f8             	sar    %rax
}
  2c155c:	c9                   	leave  
  2c155d:	c3                   	ret    

00000000002c155e <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c155e:	f3 0f 1e fa          	endbr64 
  2c1562:	55                   	push   %rbp
  2c1563:	48 89 e5             	mov    %rsp,%rbp
  2c1566:	48 83 ec 60          	sub    $0x60,%rsp
  2c156a:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c156d:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c1570:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1574:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1578:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c157c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1580:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1587:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c158b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c158f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1593:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1597:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c159b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c159f:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c15a2:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c15a5:	89 c7                	mov    %eax,%edi
  2c15a7:	e8 36 ff ff ff       	call   2c14e2 <console_vprintf>
  2c15ac:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c15af:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c15b2:	c9                   	leave  
  2c15b3:	c3                   	ret    

00000000002c15b4 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c15b4:	f3 0f 1e fa          	endbr64 
  2c15b8:	55                   	push   %rbp
  2c15b9:	48 89 e5             	mov    %rsp,%rbp
  2c15bc:	48 83 ec 20          	sub    $0x20,%rsp
  2c15c0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c15c4:	89 f0                	mov    %esi,%eax
  2c15c6:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c15c9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c15cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c15d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c15d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15d8:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c15dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15e0:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c15e4:	48 39 c2             	cmp    %rax,%rdx
  2c15e7:	73 1a                	jae    2c1603 <string_putc+0x4f>
        *sp->s++ = c;
  2c15e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c15ed:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c15f1:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c15f5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c15f9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c15fd:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1601:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1603:	90                   	nop
  2c1604:	c9                   	leave  
  2c1605:	c3                   	ret    

00000000002c1606 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1606:	f3 0f 1e fa          	endbr64 
  2c160a:	55                   	push   %rbp
  2c160b:	48 89 e5             	mov    %rsp,%rbp
  2c160e:	48 83 ec 40          	sub    $0x40,%rsp
  2c1612:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1616:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c161a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c161e:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1622:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 2c15b4 <string_putc>
  2c1629:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  2c162d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1631:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1635:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c163a:	74 33                	je     2c166f <vsnprintf+0x69>
        sp.end = s + size - 1;
  2c163c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1640:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c1644:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1648:	48 01 d0             	add    %rdx,%rax
  2c164b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c164f:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c1653:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c1657:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c165b:	be 00 00 00 00       	mov    $0x0,%esi
  2c1660:	48 89 c7             	mov    %rax,%rdi
  2c1663:	e8 7d f3 ff ff       	call   2c09e5 <printer_vprintf>
        *sp.s = 0;
  2c1668:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c166c:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c166f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1673:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c1677:	c9                   	leave  
  2c1678:	c3                   	ret    

00000000002c1679 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1679:	f3 0f 1e fa          	endbr64 
  2c167d:	55                   	push   %rbp
  2c167e:	48 89 e5             	mov    %rsp,%rbp
  2c1681:	48 83 ec 70          	sub    $0x70,%rsp
  2c1685:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c1689:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c168d:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1691:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1695:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1699:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c169d:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c16a4:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c16a8:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c16ac:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c16b0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c16b4:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c16b8:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c16bc:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c16c0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c16c4:	48 89 c7             	mov    %rax,%rdi
  2c16c7:	e8 3a ff ff ff       	call   2c1606 <vsnprintf>
  2c16cc:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c16cf:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c16d2:	c9                   	leave  
  2c16d3:	c3                   	ret    

00000000002c16d4 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c16d4:	f3 0f 1e fa          	endbr64 
  2c16d8:	55                   	push   %rbp
  2c16d9:	48 89 e5             	mov    %rsp,%rbp
  2c16dc:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c16e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c16e7:	eb 1a                	jmp    2c1703 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  2c16e9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c16ec:	48 98                	cltq   
  2c16ee:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c16f2:	48 8d 05 07 69 df ff 	lea    -0x2096f9(%rip),%rax        # b8000 <console>
  2c16f9:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c16ff:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1703:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c170a:	7e dd                	jle    2c16e9 <console_clear+0x15>
    }
    cursorpos = 0;
  2c170c:	c7 05 e6 78 df ff 00 	movl   $0x0,-0x20871a(%rip)        # b8ffc <cursorpos>
  2c1713:	00 00 00 
}
  2c1716:	90                   	nop
  2c1717:	c9                   	leave  
  2c1718:	c3                   	ret    
