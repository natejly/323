
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
  2c001a:	e8 81 08 00 00       	call   2c08a0 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001f:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0024:	e8 ee 03 00 00       	call   2c0417 <malloc>
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
  2c0043:	e8 65 04 00 00       	call   2c04ad <realloc>
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
  2c006b:	e8 06 04 00 00       	call   2c0476 <calloc>
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
  2c008a:	e8 ec 04 00 00       	call   2c057b <heap_info>
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
  2c00bb:	48 8d 15 ce 15 00 00 	lea    0x15ce(%rip),%rdx        # 2c1690 <console_clear+0x50>
  2c00c2:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c7:	48 8d 3d d0 15 00 00 	lea    0x15d0(%rip),%rdi        # 2c169e <console_clear+0x5e>
  2c00ce:	e8 31 02 00 00       	call   2c0304 <assert_fail>
	assert(array2[i] == 0);
  2c00d3:	48 8d 15 da 15 00 00 	lea    0x15da(%rip),%rdx        # 2c16b4 <console_clear+0x74>
  2c00da:	be 21 00 00 00       	mov    $0x21,%esi
  2c00df:	48 8d 3d b8 15 00 00 	lea    0x15b8(%rip),%rdi        # 2c169e <console_clear+0x5e>
  2c00e6:	e8 19 02 00 00       	call   2c0304 <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00eb:	48 8d 15 e6 15 00 00 	lea    0x15e6(%rip),%rdx        # 2c16d8 <console_clear+0x98>
  2c00f2:	be 28 00 00 00       	mov    $0x28,%esi
  2c00f7:	48 8d 3d a0 15 00 00 	lea    0x15a0(%rip),%rdi        # 2c169e <console_clear+0x5e>
  2c00fe:	e8 01 02 00 00       	call   2c0304 <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c0103:	48 8d 35 b9 15 00 00 	lea    0x15b9(%rip),%rsi        # 2c16c3 <console_clear+0x83>
  2c010a:	bf 00 00 00 00       	mov    $0x0,%edi
  2c010f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0114:	e8 7b 00 00 00       	call   2c0194 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0119:	4c 89 ef             	mov    %r13,%rdi
  2c011c:	e8 e5 02 00 00       	call   2c0406 <free>
    free(array2);
  2c0121:	4c 89 f7             	mov    %r14,%rdi
  2c0124:	e8 dd 02 00 00       	call   2c0406 <free>

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
  2c0142:	e8 d0 02 00 00       	call   2c0417 <malloc>
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
  2c017c:	48 8d 35 85 15 00 00 	lea    0x1585(%rip),%rsi        # 2c1708 <console_clear+0xc8>
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
  2c01e0:	48 8d 05 86 15 00 00 	lea    0x1586(%rip),%rax        # 2c176d <col.0>
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
  2c0212:	e8 37 12 00 00       	call   2c144e <console_vprintf>
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
  2c0276:	48 8d 35 bb 14 00 00 	lea    0x14bb(%rip),%rsi        # 2c1738 <console_clear+0xf8>
  2c027d:	e8 03 03 00 00       	call   2c0585 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0282:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0286:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c028d:	48 89 da             	mov    %rbx,%rdx
  2c0290:	be 99 00 00 00       	mov    $0x99,%esi
  2c0295:	e8 d8 12 00 00       	call   2c1572 <vsnprintf>
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
  2c02ba:	48 8d 15 7f 14 00 00 	lea    0x147f(%rip),%rdx        # 2c1740 <console_clear+0x100>
  2c02c1:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02c6:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02cb:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02d0:	e8 f5 11 00 00       	call   2c14ca <console_printf>
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
  2c02f6:	48 8d 35 d6 13 00 00 	lea    0x13d6(%rip),%rsi        # 2c16d3 <console_clear+0x93>
  2c02fd:	e8 44 04 00 00       	call   2c0746 <strcpy>
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
  2c0315:	48 8d 15 2c 14 00 00 	lea    0x142c(%rip),%rdx        # 2c1748 <console_clear+0x108>
  2c031c:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0321:	bf 30 07 00 00       	mov    $0x730,%edi
  2c0326:	b8 00 00 00 00       	mov    $0x0,%eax
  2c032b:	e8 9a 11 00 00       	call   2c14ca <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0330:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0335:	cd 30                	int    $0x30
 loop: goto loop;
  2c0337:	eb fe                	jmp    2c0337 <assert_fail+0x33>

00000000002c0339 <algn>:
block* find_block(size_t size);
block* new_block(size_t size);
block* split_block(block* block, size_t size);


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
    // get program break
    void *bptr = sbrk(size + sizeof(block));
  2c034d:	48 8d 7f 18          	lea    0x18(%rdi),%rdi
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
  2c035a:	48 89 c6             	mov    %rax,%rsi
    if (bptr == (void*) -1) {
  2c035d:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c0361:	74 3b                	je     2c039e <new_block+0x58>
    return NULL;
    }
    block* nblock = (block*)bptr;
    // add to linked list 

    nblock->next = NULL;
  2c0363:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c036a:	00 
    nblock->size = size;
  2c036b:	48 89 10             	mov    %rdx,(%rax)
    nblock->free = 0;
  2c036e:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
    // add to linked list 
    if (head == NULL) {
  2c0375:	48 8b 15 8c 1c 00 00 	mov    0x1c8c(%rip),%rdx        # 2c2008 <head>
  2c037c:	48 85 d2             	test   %rdx,%rdx
  2c037f:	74 14                	je     2c0395 <new_block+0x4f>
        head = nblock;
    } else {
        block *curr = head;
        while (curr->next != NULL) {
  2c0381:	48 89 d1             	mov    %rdx,%rcx
  2c0384:	48 8b 52 08          	mov    0x8(%rdx),%rdx
  2c0388:	48 85 d2             	test   %rdx,%rdx
  2c038b:	75 f4                	jne    2c0381 <new_block+0x3b>
            curr = curr->next;
        }
        curr->next = nblock;
  2c038d:	48 89 41 08          	mov    %rax,0x8(%rcx)
    }
    return nblock;
}
  2c0391:	48 89 f0             	mov    %rsi,%rax
  2c0394:	c3                   	ret    
        head = nblock;
  2c0395:	48 89 05 6c 1c 00 00 	mov    %rax,0x1c6c(%rip)        # 2c2008 <head>
  2c039c:	eb f3                	jmp    2c0391 <new_block+0x4b>
    return NULL;
  2c039e:	be 00 00 00 00       	mov    $0x0,%esi
  2c03a3:	eb ec                	jmp    2c0391 <new_block+0x4b>

00000000002c03a5 <find_block>:
block* find_block(size_t size) {
  2c03a5:	f3 0f 1e fa          	endbr64 
    block* curr = head;
  2c03a9:	48 8b 05 58 1c 00 00 	mov    0x1c58(%rip),%rax        # 2c2008 <head>
    while (curr) {
  2c03b0:	48 85 c0             	test   %rax,%rax
  2c03b3:	75 0b                	jne    2c03c0 <find_block+0x1b>
  2c03b5:	eb 14                	jmp    2c03cb <find_block+0x26>
        if (curr->free && curr->size >= size) {
            return curr;
        }
        curr = curr->next;
  2c03b7:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (curr) {
  2c03bb:	48 85 c0             	test   %rax,%rax
  2c03be:	74 0b                	je     2c03cb <find_block+0x26>
        if (curr->free && curr->size >= size) {
  2c03c0:	83 78 10 00          	cmpl   $0x0,0x10(%rax)
  2c03c4:	74 f1                	je     2c03b7 <find_block+0x12>
  2c03c6:	48 39 38             	cmp    %rdi,(%rax)
  2c03c9:	72 ec                	jb     2c03b7 <find_block+0x12>
    }
    return NULL;
}
  2c03cb:	c3                   	ret    

00000000002c03cc <split_block>:

block* split_block(block* b, size_t size){
  2c03cc:	f3 0f 1e fa          	endbr64 
    if(b->size < size + sizeof(block)){
  2c03d0:	48 8b 17             	mov    (%rdi),%rdx
  2c03d3:	48 8d 46 18          	lea    0x18(%rsi),%rax
  2c03d7:	48 39 c2             	cmp    %rax,%rdx
  2c03da:	72 24                	jb     2c0400 <split_block+0x34>
        return NULL;
    }
    void* nptr = (void*)b + sizeof(block) + size;
  2c03dc:	48 01 f8             	add    %rdi,%rax
    block *new = (block*)nptr;

    new->size = b->size - size - sizeof(block);
  2c03df:	48 29 f2             	sub    %rsi,%rdx
  2c03e2:	48 8d 52 e8          	lea    -0x18(%rdx),%rdx
  2c03e6:	48 89 10             	mov    %rdx,(%rax)
    new->next = b->next;
  2c03e9:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c03ed:	48 89 50 08          	mov    %rdx,0x8(%rax)
    new->free = 1; // New block is free
  2c03f1:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%rax)

    // Update the original block
    b->size = size;
  2c03f8:	48 89 37             	mov    %rsi,(%rdi)
    b->next = new;
  2c03fb:	48 89 47 08          	mov    %rax,0x8(%rdi)

    return new;
  2c03ff:	c3                   	ret    
        return NULL;
  2c0400:	b8 00 00 00 00       	mov    $0x0,%eax

}
  2c0405:	c3                   	ret    

00000000002c0406 <free>:


void free(void *firstbyte) {
  2c0406:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  2c040a:	48 85 ff             	test   %rdi,%rdi
  2c040d:	74 07                	je     2c0416 <free+0x10>
    return;
  }
    block* ptr = (block*)firstbyte;
    ptr->free = 1;
  2c040f:	c7 47 10 01 00 00 00 	movl   $0x1,0x10(%rdi)
}
  2c0416:	c3                   	ret    

00000000002c0417 <malloc>:

void *malloc(uint64_t numbytes) {
  2c0417:	f3 0f 1e fa          	endbr64 
  2c041b:	55                   	push   %rbp
  2c041c:	48 89 e5             	mov    %rsp,%rbp
  2c041f:	41 54                	push   %r12
  2c0421:	53                   	push   %rbx
    return (size + 7) / 8 * 8;
  2c0422:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  2c0426:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    size_t size = algn(numbytes);
    block *b = find_block(size);
  2c042a:	4c 89 e7             	mov    %r12,%rdi
  2c042d:	e8 73 ff ff ff       	call   2c03a5 <find_block>
    if (b == NULL){
  2c0432:	48 85 c0             	test   %rax,%rax
  2c0435:	74 20                	je     2c0457 <malloc+0x40>
  2c0437:	48 89 c3             	mov    %rax,%rbx
        if (b==NULL){
            //alloc fail
            return NULL;
        }
    } else {
        b->free = 0;
  2c043a:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
        // check split
        if (b->size > size + sizeof(block)) {
  2c0441:	49 8d 44 24 18       	lea    0x18(%r12),%rax
  2c0446:	48 39 03             	cmp    %rax,(%rbx)
  2c0449:	77 1e                	ja     2c0469 <malloc+0x52>
            split_block(b, size);
        }
    }
    return (void*)((void*)b + sizeof(block));
  2c044b:	48 83 c3 18          	add    $0x18,%rbx

}
  2c044f:	48 89 d8             	mov    %rbx,%rax
  2c0452:	5b                   	pop    %rbx
  2c0453:	41 5c                	pop    %r12
  2c0455:	5d                   	pop    %rbp
  2c0456:	c3                   	ret    
        b = new_block(size);
  2c0457:	4c 89 e7             	mov    %r12,%rdi
  2c045a:	e8 e7 fe ff ff       	call   2c0346 <new_block>
  2c045f:	48 89 c3             	mov    %rax,%rbx
        if (b==NULL){
  2c0462:	48 85 c0             	test   %rax,%rax
  2c0465:	75 e4                	jne    2c044b <malloc+0x34>
  2c0467:	eb e6                	jmp    2c044f <malloc+0x38>
            split_block(b, size);
  2c0469:	4c 89 e6             	mov    %r12,%rsi
  2c046c:	48 89 df             	mov    %rbx,%rdi
  2c046f:	e8 58 ff ff ff       	call   2c03cc <split_block>
  2c0474:	eb d5                	jmp    2c044b <malloc+0x34>

00000000002c0476 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  2c0476:	f3 0f 1e fa          	endbr64 
  2c047a:	55                   	push   %rbp
  2c047b:	48 89 e5             	mov    %rsp,%rbp
  2c047e:	41 54                	push   %r12
  2c0480:	53                   	push   %rbx
    uint64_t total = num * sz;
  2c0481:	48 0f af fe          	imul   %rsi,%rdi
  2c0485:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  2c0488:	e8 8a ff ff ff       	call   2c0417 <malloc>
  2c048d:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  2c0490:	48 85 c0             	test   %rax,%rax
  2c0493:	74 10                	je     2c04a5 <calloc+0x2f>
        memset(ptr, 0, total);
  2c0495:	4c 89 e2             	mov    %r12,%rdx
  2c0498:	be 00 00 00 00       	mov    $0x0,%esi
  2c049d:	48 89 c7             	mov    %rax,%rdi
  2c04a0:	e8 e6 01 00 00       	call   2c068b <memset>
    }
    return ptr;
}
  2c04a5:	48 89 d8             	mov    %rbx,%rax
  2c04a8:	5b                   	pop    %rbx
  2c04a9:	41 5c                	pop    %r12
  2c04ab:	5d                   	pop    %rbp
  2c04ac:	c3                   	ret    

00000000002c04ad <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c04ad:	f3 0f 1e fa          	endbr64 
  2c04b1:	55                   	push   %rbp
  2c04b2:	48 89 e5             	mov    %rsp,%rbp
  2c04b5:	41 54                	push   %r12
  2c04b7:	53                   	push   %rbx
  2c04b8:	48 89 fb             	mov    %rdi,%rbx
  2c04bb:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  2c04be:	48 85 db             	test   %rbx,%rbx
  2c04c1:	74 2d                	je     2c04f0 <realloc+0x43>
        return malloc(sz); // Equivalent to malloc if `ptr` is NULL
    }

    if (sz == 0) {
  2c04c3:	48 85 f6             	test   %rsi,%rsi
  2c04c6:	74 32                	je     2c04fa <realloc+0x4d>
    return (size + 7) / 8 * 8;
  2c04c8:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  2c04cc:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi

    block *b = (block*)((void*)ptr - sizeof(block)); // Get the block metadata
    size_t aligned_size = algn(sz);

    // If the current block is already large enough
    if (b->size >= aligned_size) {
  2c04d0:	48 8b 43 e8          	mov    -0x18(%rbx),%rax
  2c04d4:	48 39 f0             	cmp    %rsi,%rax
  2c04d7:	72 31                	jb     2c050a <realloc+0x5d>
        // Split the block if it has excess space
        if (b->size > aligned_size + sizeof(block)) {
  2c04d9:	48 8d 56 18          	lea    0x18(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr; // Return the same pointer if resizing in place
  2c04dd:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + sizeof(block)) {
  2c04e0:	48 39 d0             	cmp    %rdx,%rax
  2c04e3:	76 49                	jbe    2c052e <realloc+0x81>
    block *b = (block*)((void*)ptr - sizeof(block)); // Get the block metadata
  2c04e5:	48 8d 7b e8          	lea    -0x18(%rbx),%rdi
            split_block(b, aligned_size);
  2c04e9:	e8 de fe ff ff       	call   2c03cc <split_block>
  2c04ee:	eb 3e                	jmp    2c052e <realloc+0x81>
        return malloc(sz); // Equivalent to malloc if `ptr` is NULL
  2c04f0:	e8 22 ff ff ff       	call   2c0417 <malloc>
  2c04f5:	49 89 c4             	mov    %rax,%r12
  2c04f8:	eb 34                	jmp    2c052e <realloc+0x81>
        free(ptr); // Equivalent to free if size is 0
  2c04fa:	48 89 df             	mov    %rbx,%rdi
  2c04fd:	e8 04 ff ff ff       	call   2c0406 <free>
        return NULL;
  2c0502:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0508:	eb 24                	jmp    2c052e <realloc+0x81>
    }

    // If the current block is too small, allocate a new block
    void *new_ptr = malloc(sz);
  2c050a:	e8 08 ff ff ff       	call   2c0417 <malloc>
  2c050f:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  2c0512:	48 85 c0             	test   %rax,%rax
  2c0515:	74 17                	je     2c052e <realloc+0x81>
        return NULL; // Allocation failed
    }

    // Copy data from the old block to the new block
    memcpy(new_ptr, ptr, b->size);
  2c0517:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  2c051b:	48 89 de             	mov    %rbx,%rsi
  2c051e:	48 89 c7             	mov    %rax,%rdi
  2c0521:	e8 5f 00 00 00       	call   2c0585 <memcpy>

    // Free the old block
    free(ptr);
  2c0526:	48 89 df             	mov    %rbx,%rdi
  2c0529:	e8 d8 fe ff ff       	call   2c0406 <free>

    return new_ptr;
}
  2c052e:	4c 89 e0             	mov    %r12,%rax
  2c0531:	5b                   	pop    %rbx
  2c0532:	41 5c                	pop    %r12
  2c0534:	5d                   	pop    %rbp
  2c0535:	c3                   	ret    

00000000002c0536 <defrag>:


void defrag() {
  2c0536:	f3 0f 1e fa          	endbr64 
    block *b = head;
  2c053a:	48 8b 15 c7 1a 00 00 	mov    0x1ac7(%rip),%rdx        # 2c2008 <head>

    while (b && b->next) {
  2c0541:	48 85 d2             	test   %rdx,%rdx
  2c0544:	75 04                	jne    2c054a <defrag+0x14>
  2c0546:	c3                   	ret    
        if (b->free && b->next->free) {
            // Merge the current block with the next block
            b->size += sizeof(block) + b->next->size;
            b->next = b->next->next;  // Skip the next block after merging
  2c0547:	48 89 c2             	mov    %rax,%rdx
    while (b && b->next) {
  2c054a:	48 8b 42 08          	mov    0x8(%rdx),%rax
  2c054e:	48 85 c0             	test   %rax,%rax
  2c0551:	74 27                	je     2c057a <defrag+0x44>
        if (b->free && b->next->free) {
  2c0553:	83 7a 10 00          	cmpl   $0x0,0x10(%rdx)
  2c0557:	74 ee                	je     2c0547 <defrag+0x11>
  2c0559:	83 78 10 00          	cmpl   $0x0,0x10(%rax)
  2c055d:	74 e8                	je     2c0547 <defrag+0x11>
            b->size += sizeof(block) + b->next->size;
  2c055f:	48 8b 32             	mov    (%rdx),%rsi
  2c0562:	48 8b 08             	mov    (%rax),%rcx
  2c0565:	48 8d 4c 0e 18       	lea    0x18(%rsi,%rcx,1),%rcx
  2c056a:	48 89 0a             	mov    %rcx,(%rdx)
            b->next = b->next->next;  // Skip the next block after merging
  2c056d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0571:	48 89 42 08          	mov    %rax,0x8(%rdx)
  2c0575:	48 89 d0             	mov    %rdx,%rax
  2c0578:	eb cd                	jmp    2c0547 <defrag+0x11>

        } else {
            b = b->next;  // Advance to the next block if no merge occurred
        }
    }
}
  2c057a:	c3                   	ret    

00000000002c057b <heap_info>:

int heap_info(heap_info_struct * info) {
  2c057b:	f3 0f 1e fa          	endbr64 
    return 0;
}
  2c057f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0584:	c3                   	ret    

00000000002c0585 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0585:	f3 0f 1e fa          	endbr64 
  2c0589:	55                   	push   %rbp
  2c058a:	48 89 e5             	mov    %rsp,%rbp
  2c058d:	48 83 ec 28          	sub    $0x28,%rsp
  2c0591:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0595:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0599:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c059d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c05a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c05a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c05a9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c05ad:	eb 1c                	jmp    2c05cb <memcpy+0x46>
        *d = *s;
  2c05af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05b3:	0f b6 10             	movzbl (%rax),%edx
  2c05b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c05ba:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c05bc:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c05c1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c05c6:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c05cb:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c05d0:	75 dd                	jne    2c05af <memcpy+0x2a>
    }
    return dst;
  2c05d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c05d6:	c9                   	leave  
  2c05d7:	c3                   	ret    

00000000002c05d8 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c05d8:	f3 0f 1e fa          	endbr64 
  2c05dc:	55                   	push   %rbp
  2c05dd:	48 89 e5             	mov    %rsp,%rbp
  2c05e0:	48 83 ec 28          	sub    $0x28,%rsp
  2c05e4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c05e8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c05ec:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c05f0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c05f4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c05f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c05fc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0600:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0604:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0608:	73 6a                	jae    2c0674 <memmove+0x9c>
  2c060a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c060e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0612:	48 01 d0             	add    %rdx,%rax
  2c0615:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0619:	73 59                	jae    2c0674 <memmove+0x9c>
        s += n, d += n;
  2c061b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c061f:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0623:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0627:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c062b:	eb 17                	jmp    2c0644 <memmove+0x6c>
            *--d = *--s;
  2c062d:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0632:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0637:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c063b:	0f b6 10             	movzbl (%rax),%edx
  2c063e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0642:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0644:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0648:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c064c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0650:	48 85 c0             	test   %rax,%rax
  2c0653:	75 d8                	jne    2c062d <memmove+0x55>
    if (s < d && s + n > d) {
  2c0655:	eb 2e                	jmp    2c0685 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0657:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c065b:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c065f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0663:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0667:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c066b:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c066f:	0f b6 12             	movzbl (%rdx),%edx
  2c0672:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0674:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0678:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c067c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0680:	48 85 c0             	test   %rax,%rax
  2c0683:	75 d2                	jne    2c0657 <memmove+0x7f>
        }
    }
    return dst;
  2c0685:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0689:	c9                   	leave  
  2c068a:	c3                   	ret    

00000000002c068b <memset>:

void* memset(void* v, int c, size_t n) {
  2c068b:	f3 0f 1e fa          	endbr64 
  2c068f:	55                   	push   %rbp
  2c0690:	48 89 e5             	mov    %rsp,%rbp
  2c0693:	48 83 ec 28          	sub    $0x28,%rsp
  2c0697:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c069b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c069e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c06a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c06a6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c06aa:	eb 15                	jmp    2c06c1 <memset+0x36>
        *p = c;
  2c06ac:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c06af:	89 c2                	mov    %eax,%edx
  2c06b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c06b5:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c06b7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c06bc:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c06c1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c06c6:	75 e4                	jne    2c06ac <memset+0x21>
    }
    return v;
  2c06c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c06cc:	c9                   	leave  
  2c06cd:	c3                   	ret    

00000000002c06ce <strlen>:

size_t strlen(const char* s) {
  2c06ce:	f3 0f 1e fa          	endbr64 
  2c06d2:	55                   	push   %rbp
  2c06d3:	48 89 e5             	mov    %rsp,%rbp
  2c06d6:	48 83 ec 18          	sub    $0x18,%rsp
  2c06da:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c06de:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c06e5:	00 
  2c06e6:	eb 0a                	jmp    2c06f2 <strlen+0x24>
        ++n;
  2c06e8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c06ed:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c06f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c06f6:	0f b6 00             	movzbl (%rax),%eax
  2c06f9:	84 c0                	test   %al,%al
  2c06fb:	75 eb                	jne    2c06e8 <strlen+0x1a>
    }
    return n;
  2c06fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0701:	c9                   	leave  
  2c0702:	c3                   	ret    

00000000002c0703 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0703:	f3 0f 1e fa          	endbr64 
  2c0707:	55                   	push   %rbp
  2c0708:	48 89 e5             	mov    %rsp,%rbp
  2c070b:	48 83 ec 20          	sub    $0x20,%rsp
  2c070f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0713:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0717:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c071e:	00 
  2c071f:	eb 0a                	jmp    2c072b <strnlen+0x28>
        ++n;
  2c0721:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0726:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c072b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c072f:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0733:	74 0b                	je     2c0740 <strnlen+0x3d>
  2c0735:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0739:	0f b6 00             	movzbl (%rax),%eax
  2c073c:	84 c0                	test   %al,%al
  2c073e:	75 e1                	jne    2c0721 <strnlen+0x1e>
    }
    return n;
  2c0740:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0744:	c9                   	leave  
  2c0745:	c3                   	ret    

00000000002c0746 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0746:	f3 0f 1e fa          	endbr64 
  2c074a:	55                   	push   %rbp
  2c074b:	48 89 e5             	mov    %rsp,%rbp
  2c074e:	48 83 ec 20          	sub    $0x20,%rsp
  2c0752:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0756:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c075a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c075e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0762:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0766:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c076a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c076e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0772:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0776:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c077a:	0f b6 12             	movzbl (%rdx),%edx
  2c077d:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c077f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0783:	48 83 e8 01          	sub    $0x1,%rax
  2c0787:	0f b6 00             	movzbl (%rax),%eax
  2c078a:	84 c0                	test   %al,%al
  2c078c:	75 d4                	jne    2c0762 <strcpy+0x1c>
    return dst;
  2c078e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0792:	c9                   	leave  
  2c0793:	c3                   	ret    

00000000002c0794 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0794:	f3 0f 1e fa          	endbr64 
  2c0798:	55                   	push   %rbp
  2c0799:	48 89 e5             	mov    %rsp,%rbp
  2c079c:	48 83 ec 10          	sub    $0x10,%rsp
  2c07a0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c07a4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c07a8:	eb 0a                	jmp    2c07b4 <strcmp+0x20>
        ++a, ++b;
  2c07aa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c07af:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c07b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07b8:	0f b6 00             	movzbl (%rax),%eax
  2c07bb:	84 c0                	test   %al,%al
  2c07bd:	74 1d                	je     2c07dc <strcmp+0x48>
  2c07bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c07c3:	0f b6 00             	movzbl (%rax),%eax
  2c07c6:	84 c0                	test   %al,%al
  2c07c8:	74 12                	je     2c07dc <strcmp+0x48>
  2c07ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07ce:	0f b6 10             	movzbl (%rax),%edx
  2c07d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c07d5:	0f b6 00             	movzbl (%rax),%eax
  2c07d8:	38 c2                	cmp    %al,%dl
  2c07da:	74 ce                	je     2c07aa <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c07dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07e0:	0f b6 00             	movzbl (%rax),%eax
  2c07e3:	89 c2                	mov    %eax,%edx
  2c07e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c07e9:	0f b6 00             	movzbl (%rax),%eax
  2c07ec:	38 c2                	cmp    %al,%dl
  2c07ee:	0f 97 c0             	seta   %al
  2c07f1:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c07f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c07f8:	0f b6 00             	movzbl (%rax),%eax
  2c07fb:	89 c1                	mov    %eax,%ecx
  2c07fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0801:	0f b6 00             	movzbl (%rax),%eax
  2c0804:	38 c1                	cmp    %al,%cl
  2c0806:	0f 92 c0             	setb   %al
  2c0809:	0f b6 c8             	movzbl %al,%ecx
  2c080c:	89 d0                	mov    %edx,%eax
  2c080e:	29 c8                	sub    %ecx,%eax
}
  2c0810:	c9                   	leave  
  2c0811:	c3                   	ret    

00000000002c0812 <strchr>:

char* strchr(const char* s, int c) {
  2c0812:	f3 0f 1e fa          	endbr64 
  2c0816:	55                   	push   %rbp
  2c0817:	48 89 e5             	mov    %rsp,%rbp
  2c081a:	48 83 ec 10          	sub    $0x10,%rsp
  2c081e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0822:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0825:	eb 05                	jmp    2c082c <strchr+0x1a>
        ++s;
  2c0827:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c082c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0830:	0f b6 00             	movzbl (%rax),%eax
  2c0833:	84 c0                	test   %al,%al
  2c0835:	74 0e                	je     2c0845 <strchr+0x33>
  2c0837:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c083b:	0f b6 00             	movzbl (%rax),%eax
  2c083e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0841:	38 d0                	cmp    %dl,%al
  2c0843:	75 e2                	jne    2c0827 <strchr+0x15>
    }
    if (*s == (char) c) {
  2c0845:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0849:	0f b6 00             	movzbl (%rax),%eax
  2c084c:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c084f:	38 d0                	cmp    %dl,%al
  2c0851:	75 06                	jne    2c0859 <strchr+0x47>
        return (char*) s;
  2c0853:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0857:	eb 05                	jmp    2c085e <strchr+0x4c>
    } else {
        return NULL;
  2c0859:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c085e:	c9                   	leave  
  2c085f:	c3                   	ret    

00000000002c0860 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0860:	f3 0f 1e fa          	endbr64 
  2c0864:	55                   	push   %rbp
  2c0865:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0868:	8b 05 a2 17 00 00    	mov    0x17a2(%rip),%eax        # 2c2010 <rand_seed_set>
  2c086e:	85 c0                	test   %eax,%eax
  2c0870:	75 0a                	jne    2c087c <rand+0x1c>
        srand(819234718U);
  2c0872:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0877:	e8 24 00 00 00       	call   2c08a0 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c087c:	8b 05 92 17 00 00    	mov    0x1792(%rip),%eax        # 2c2014 <rand_seed>
  2c0882:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0888:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c088d:	89 05 81 17 00 00    	mov    %eax,0x1781(%rip)        # 2c2014 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0893:	8b 05 7b 17 00 00    	mov    0x177b(%rip),%eax        # 2c2014 <rand_seed>
  2c0899:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c089e:	5d                   	pop    %rbp
  2c089f:	c3                   	ret    

00000000002c08a0 <srand>:

void srand(unsigned seed) {
  2c08a0:	f3 0f 1e fa          	endbr64 
  2c08a4:	55                   	push   %rbp
  2c08a5:	48 89 e5             	mov    %rsp,%rbp
  2c08a8:	48 83 ec 08          	sub    $0x8,%rsp
  2c08ac:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c08af:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c08b2:	89 05 5c 17 00 00    	mov    %eax,0x175c(%rip)        # 2c2014 <rand_seed>
    rand_seed_set = 1;
  2c08b8:	c7 05 4e 17 00 00 01 	movl   $0x1,0x174e(%rip)        # 2c2010 <rand_seed_set>
  2c08bf:	00 00 00 
}
  2c08c2:	90                   	nop
  2c08c3:	c9                   	leave  
  2c08c4:	c3                   	ret    

00000000002c08c5 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c08c5:	f3 0f 1e fa          	endbr64 
  2c08c9:	55                   	push   %rbp
  2c08ca:	48 89 e5             	mov    %rsp,%rbp
  2c08cd:	48 83 ec 28          	sub    $0x28,%rsp
  2c08d1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c08d5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c08d9:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c08dc:	48 8d 05 9d 0f 00 00 	lea    0xf9d(%rip),%rax        # 2c1880 <upper_digits.1>
  2c08e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  2c08e7:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c08eb:	79 0e                	jns    2c08fb <fill_numbuf+0x36>
        digits = lower_digits;
  2c08ed:	48 8d 05 ac 0f 00 00 	lea    0xfac(%rip),%rax        # 2c18a0 <lower_digits.0>
  2c08f4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  2c08f8:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c08fb:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0900:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0904:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0907:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c090a:	48 63 c8             	movslq %eax,%rcx
  2c090d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0911:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0916:	48 f7 f1             	div    %rcx
  2c0919:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c091d:	48 01 d0             	add    %rdx,%rax
  2c0920:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0925:	0f b6 10             	movzbl (%rax),%edx
  2c0928:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c092c:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c092e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0931:	48 63 f0             	movslq %eax,%rsi
  2c0934:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0938:	ba 00 00 00 00       	mov    $0x0,%edx
  2c093d:	48 f7 f6             	div    %rsi
  2c0940:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0944:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0949:	75 bc                	jne    2c0907 <fill_numbuf+0x42>
    return numbuf_end;
  2c094b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c094f:	c9                   	leave  
  2c0950:	c3                   	ret    

00000000002c0951 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0951:	f3 0f 1e fa          	endbr64 
  2c0955:	55                   	push   %rbp
  2c0956:	48 89 e5             	mov    %rsp,%rbp
  2c0959:	53                   	push   %rbx
  2c095a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0961:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0968:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c096e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0975:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c097c:	e9 bd 09 00 00       	jmp    2c133e <printer_vprintf+0x9ed>
        if (*format != '%') {
  2c0981:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0988:	0f b6 00             	movzbl (%rax),%eax
  2c098b:	3c 25                	cmp    $0x25,%al
  2c098d:	74 31                	je     2c09c0 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  2c098f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0996:	4c 8b 00             	mov    (%rax),%r8
  2c0999:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09a0:	0f b6 00             	movzbl (%rax),%eax
  2c09a3:	0f b6 c8             	movzbl %al,%ecx
  2c09a6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c09ac:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c09b3:	89 ce                	mov    %ecx,%esi
  2c09b5:	48 89 c7             	mov    %rax,%rdi
  2c09b8:	41 ff d0             	call   *%r8
            continue;
  2c09bb:	e9 76 09 00 00       	jmp    2c1336 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  2c09c0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c09c7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c09ce:	01 
  2c09cf:	eb 4d                	jmp    2c0a1e <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  2c09d1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09d8:	0f b6 00             	movzbl (%rax),%eax
  2c09db:	0f be c0             	movsbl %al,%eax
  2c09de:	89 c6                	mov    %eax,%esi
  2c09e0:	48 8d 05 99 0d 00 00 	lea    0xd99(%rip),%rax        # 2c1780 <flag_chars>
  2c09e7:	48 89 c7             	mov    %rax,%rdi
  2c09ea:	e8 23 fe ff ff       	call   2c0812 <strchr>
  2c09ef:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c09f3:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c09f8:	74 34                	je     2c0a2e <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  2c09fa:	48 8d 15 7f 0d 00 00 	lea    0xd7f(%rip),%rdx        # 2c1780 <flag_chars>
  2c0a01:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0a05:	48 29 d0             	sub    %rdx,%rax
  2c0a08:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0a0d:	89 c1                	mov    %eax,%ecx
  2c0a0f:	d3 e2                	shl    %cl,%edx
  2c0a11:	89 d0                	mov    %edx,%eax
  2c0a13:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0a16:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0a1d:	01 
  2c0a1e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a25:	0f b6 00             	movzbl (%rax),%eax
  2c0a28:	84 c0                	test   %al,%al
  2c0a2a:	75 a5                	jne    2c09d1 <printer_vprintf+0x80>
  2c0a2c:	eb 01                	jmp    2c0a2f <printer_vprintf+0xde>
            } else {
                break;
  2c0a2e:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0a2f:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0a36:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a3d:	0f b6 00             	movzbl (%rax),%eax
  2c0a40:	3c 30                	cmp    $0x30,%al
  2c0a42:	7e 67                	jle    2c0aab <printer_vprintf+0x15a>
  2c0a44:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a4b:	0f b6 00             	movzbl (%rax),%eax
  2c0a4e:	3c 39                	cmp    $0x39,%al
  2c0a50:	7f 59                	jg     2c0aab <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0a52:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0a59:	eb 2e                	jmp    2c0a89 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  2c0a5b:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0a5e:	89 d0                	mov    %edx,%eax
  2c0a60:	c1 e0 02             	shl    $0x2,%eax
  2c0a63:	01 d0                	add    %edx,%eax
  2c0a65:	01 c0                	add    %eax,%eax
  2c0a67:	89 c1                	mov    %eax,%ecx
  2c0a69:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a70:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0a74:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0a7b:	0f b6 00             	movzbl (%rax),%eax
  2c0a7e:	0f be c0             	movsbl %al,%eax
  2c0a81:	01 c8                	add    %ecx,%eax
  2c0a83:	83 e8 30             	sub    $0x30,%eax
  2c0a86:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0a89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a90:	0f b6 00             	movzbl (%rax),%eax
  2c0a93:	3c 2f                	cmp    $0x2f,%al
  2c0a95:	0f 8e 85 00 00 00    	jle    2c0b20 <printer_vprintf+0x1cf>
  2c0a9b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0aa2:	0f b6 00             	movzbl (%rax),%eax
  2c0aa5:	3c 39                	cmp    $0x39,%al
  2c0aa7:	7e b2                	jle    2c0a5b <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  2c0aa9:	eb 75                	jmp    2c0b20 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  2c0aab:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ab2:	0f b6 00             	movzbl (%rax),%eax
  2c0ab5:	3c 2a                	cmp    $0x2a,%al
  2c0ab7:	75 68                	jne    2c0b21 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  2c0ab9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ac0:	8b 00                	mov    (%rax),%eax
  2c0ac2:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ac5:	77 30                	ja     2c0af7 <printer_vprintf+0x1a6>
  2c0ac7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ace:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0ad2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ad9:	8b 00                	mov    (%rax),%eax
  2c0adb:	89 c0                	mov    %eax,%eax
  2c0add:	48 01 d0             	add    %rdx,%rax
  2c0ae0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ae7:	8b 12                	mov    (%rdx),%edx
  2c0ae9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0aec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0af3:	89 0a                	mov    %ecx,(%rdx)
  2c0af5:	eb 1a                	jmp    2c0b11 <printer_vprintf+0x1c0>
  2c0af7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0afe:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0b02:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0b06:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b0d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0b11:	8b 00                	mov    (%rax),%eax
  2c0b13:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0b16:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0b1d:	01 
  2c0b1e:	eb 01                	jmp    2c0b21 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  2c0b20:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0b21:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0b28:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b2f:	0f b6 00             	movzbl (%rax),%eax
  2c0b32:	3c 2e                	cmp    $0x2e,%al
  2c0b34:	0f 85 00 01 00 00    	jne    2c0c3a <printer_vprintf+0x2e9>
            ++format;
  2c0b3a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0b41:	01 
            if (*format >= '0' && *format <= '9') {
  2c0b42:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b49:	0f b6 00             	movzbl (%rax),%eax
  2c0b4c:	3c 2f                	cmp    $0x2f,%al
  2c0b4e:	7e 67                	jle    2c0bb7 <printer_vprintf+0x266>
  2c0b50:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b57:	0f b6 00             	movzbl (%rax),%eax
  2c0b5a:	3c 39                	cmp    $0x39,%al
  2c0b5c:	7f 59                	jg     2c0bb7 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0b5e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0b65:	eb 2e                	jmp    2c0b95 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  2c0b67:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0b6a:	89 d0                	mov    %edx,%eax
  2c0b6c:	c1 e0 02             	shl    $0x2,%eax
  2c0b6f:	01 d0                	add    %edx,%eax
  2c0b71:	01 c0                	add    %eax,%eax
  2c0b73:	89 c1                	mov    %eax,%ecx
  2c0b75:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b7c:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0b80:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0b87:	0f b6 00             	movzbl (%rax),%eax
  2c0b8a:	0f be c0             	movsbl %al,%eax
  2c0b8d:	01 c8                	add    %ecx,%eax
  2c0b8f:	83 e8 30             	sub    $0x30,%eax
  2c0b92:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0b95:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0b9c:	0f b6 00             	movzbl (%rax),%eax
  2c0b9f:	3c 2f                	cmp    $0x2f,%al
  2c0ba1:	0f 8e 85 00 00 00    	jle    2c0c2c <printer_vprintf+0x2db>
  2c0ba7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0bae:	0f b6 00             	movzbl (%rax),%eax
  2c0bb1:	3c 39                	cmp    $0x39,%al
  2c0bb3:	7e b2                	jle    2c0b67 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  2c0bb5:	eb 75                	jmp    2c0c2c <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  2c0bb7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0bbe:	0f b6 00             	movzbl (%rax),%eax
  2c0bc1:	3c 2a                	cmp    $0x2a,%al
  2c0bc3:	75 68                	jne    2c0c2d <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  2c0bc5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bcc:	8b 00                	mov    (%rax),%eax
  2c0bce:	83 f8 2f             	cmp    $0x2f,%eax
  2c0bd1:	77 30                	ja     2c0c03 <printer_vprintf+0x2b2>
  2c0bd3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bda:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0bde:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0be5:	8b 00                	mov    (%rax),%eax
  2c0be7:	89 c0                	mov    %eax,%eax
  2c0be9:	48 01 d0             	add    %rdx,%rax
  2c0bec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bf3:	8b 12                	mov    (%rdx),%edx
  2c0bf5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0bf8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bff:	89 0a                	mov    %ecx,(%rdx)
  2c0c01:	eb 1a                	jmp    2c0c1d <printer_vprintf+0x2cc>
  2c0c03:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c0a:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0c0e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0c12:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c19:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0c1d:	8b 00                	mov    (%rax),%eax
  2c0c1f:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0c22:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0c29:	01 
  2c0c2a:	eb 01                	jmp    2c0c2d <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  2c0c2c:	90                   	nop
            }
            if (precision < 0) {
  2c0c2d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0c31:	79 07                	jns    2c0c3a <printer_vprintf+0x2e9>
                precision = 0;
  2c0c33:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0c3a:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0c41:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0c48:	00 
        int length = 0;
  2c0c49:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0c50:	48 8d 05 2f 0b 00 00 	lea    0xb2f(%rip),%rax        # 2c1786 <flag_chars+0x6>
  2c0c57:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  2c0c5b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c62:	0f b6 00             	movzbl (%rax),%eax
  2c0c65:	0f be c0             	movsbl %al,%eax
  2c0c68:	83 e8 43             	sub    $0x43,%eax
  2c0c6b:	83 f8 37             	cmp    $0x37,%eax
  2c0c6e:	0f 87 b6 03 00 00    	ja     2c102a <printer_vprintf+0x6d9>
  2c0c74:	89 c0                	mov    %eax,%eax
  2c0c76:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  2c0c7d:	00 
  2c0c7e:	48 8d 05 0f 0b 00 00 	lea    0xb0f(%rip),%rax        # 2c1794 <flag_chars+0x14>
  2c0c85:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  2c0c88:	48 98                	cltq   
  2c0c8a:	48 8d 15 03 0b 00 00 	lea    0xb03(%rip),%rdx        # 2c1794 <flag_chars+0x14>
  2c0c91:	48 01 d0             	add    %rdx,%rax
  2c0c94:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0c97:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0c9e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0ca5:	01 
            goto again;
  2c0ca6:	eb b3                	jmp    2c0c5b <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0ca8:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0cac:	74 5d                	je     2c0d0b <printer_vprintf+0x3ba>
  2c0cae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cb5:	8b 00                	mov    (%rax),%eax
  2c0cb7:	83 f8 2f             	cmp    $0x2f,%eax
  2c0cba:	77 30                	ja     2c0cec <printer_vprintf+0x39b>
  2c0cbc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cc3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0cc7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cce:	8b 00                	mov    (%rax),%eax
  2c0cd0:	89 c0                	mov    %eax,%eax
  2c0cd2:	48 01 d0             	add    %rdx,%rax
  2c0cd5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cdc:	8b 12                	mov    (%rdx),%edx
  2c0cde:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0ce1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ce8:	89 0a                	mov    %ecx,(%rdx)
  2c0cea:	eb 1a                	jmp    2c0d06 <printer_vprintf+0x3b5>
  2c0cec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cf3:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0cf7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0cfb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d02:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d06:	48 8b 00             	mov    (%rax),%rax
  2c0d09:	eb 5c                	jmp    2c0d67 <printer_vprintf+0x416>
  2c0d0b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d12:	8b 00                	mov    (%rax),%eax
  2c0d14:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d17:	77 30                	ja     2c0d49 <printer_vprintf+0x3f8>
  2c0d19:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d20:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0d24:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d2b:	8b 00                	mov    (%rax),%eax
  2c0d2d:	89 c0                	mov    %eax,%eax
  2c0d2f:	48 01 d0             	add    %rdx,%rax
  2c0d32:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d39:	8b 12                	mov    (%rdx),%edx
  2c0d3b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0d3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d45:	89 0a                	mov    %ecx,(%rdx)
  2c0d47:	eb 1a                	jmp    2c0d63 <printer_vprintf+0x412>
  2c0d49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d50:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d54:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d58:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d5f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d63:	8b 00                	mov    (%rax),%eax
  2c0d65:	48 98                	cltq   
  2c0d67:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0d6b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0d6f:	48 c1 f8 38          	sar    $0x38,%rax
  2c0d73:	25 80 00 00 00       	and    $0x80,%eax
  2c0d78:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0d7b:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0d7f:	74 09                	je     2c0d8a <printer_vprintf+0x439>
  2c0d81:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0d85:	48 f7 d8             	neg    %rax
  2c0d88:	eb 04                	jmp    2c0d8e <printer_vprintf+0x43d>
  2c0d8a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0d8e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0d92:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0d95:	83 c8 60             	or     $0x60,%eax
  2c0d98:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0d9b:	e9 cf 02 00 00       	jmp    2c106f <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0da0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0da4:	74 5d                	je     2c0e03 <printer_vprintf+0x4b2>
  2c0da6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dad:	8b 00                	mov    (%rax),%eax
  2c0daf:	83 f8 2f             	cmp    $0x2f,%eax
  2c0db2:	77 30                	ja     2c0de4 <printer_vprintf+0x493>
  2c0db4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dbb:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0dbf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dc6:	8b 00                	mov    (%rax),%eax
  2c0dc8:	89 c0                	mov    %eax,%eax
  2c0dca:	48 01 d0             	add    %rdx,%rax
  2c0dcd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dd4:	8b 12                	mov    (%rdx),%edx
  2c0dd6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0dd9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0de0:	89 0a                	mov    %ecx,(%rdx)
  2c0de2:	eb 1a                	jmp    2c0dfe <printer_vprintf+0x4ad>
  2c0de4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0deb:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0def:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0df3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0dfa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0dfe:	48 8b 00             	mov    (%rax),%rax
  2c0e01:	eb 5c                	jmp    2c0e5f <printer_vprintf+0x50e>
  2c0e03:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e0a:	8b 00                	mov    (%rax),%eax
  2c0e0c:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e0f:	77 30                	ja     2c0e41 <printer_vprintf+0x4f0>
  2c0e11:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e18:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e1c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e23:	8b 00                	mov    (%rax),%eax
  2c0e25:	89 c0                	mov    %eax,%eax
  2c0e27:	48 01 d0             	add    %rdx,%rax
  2c0e2a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e31:	8b 12                	mov    (%rdx),%edx
  2c0e33:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0e36:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e3d:	89 0a                	mov    %ecx,(%rdx)
  2c0e3f:	eb 1a                	jmp    2c0e5b <printer_vprintf+0x50a>
  2c0e41:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e48:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e4c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e50:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e57:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e5b:	8b 00                	mov    (%rax),%eax
  2c0e5d:	89 c0                	mov    %eax,%eax
  2c0e5f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c0e63:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c0e67:	e9 03 02 00 00       	jmp    2c106f <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  2c0e6c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c0e73:	e9 28 ff ff ff       	jmp    2c0da0 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  2c0e78:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c0e7f:	e9 1c ff ff ff       	jmp    2c0da0 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c0e84:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e8b:	8b 00                	mov    (%rax),%eax
  2c0e8d:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e90:	77 30                	ja     2c0ec2 <printer_vprintf+0x571>
  2c0e92:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e99:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e9d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ea4:	8b 00                	mov    (%rax),%eax
  2c0ea6:	89 c0                	mov    %eax,%eax
  2c0ea8:	48 01 d0             	add    %rdx,%rax
  2c0eab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0eb2:	8b 12                	mov    (%rdx),%edx
  2c0eb4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0eb7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ebe:	89 0a                	mov    %ecx,(%rdx)
  2c0ec0:	eb 1a                	jmp    2c0edc <printer_vprintf+0x58b>
  2c0ec2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ec9:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0ecd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ed1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ed8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0edc:	48 8b 00             	mov    (%rax),%rax
  2c0edf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c0ee3:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c0eea:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c0ef1:	e9 79 01 00 00       	jmp    2c106f <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  2c0ef6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0efd:	8b 00                	mov    (%rax),%eax
  2c0eff:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f02:	77 30                	ja     2c0f34 <printer_vprintf+0x5e3>
  2c0f04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f0b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f16:	8b 00                	mov    (%rax),%eax
  2c0f18:	89 c0                	mov    %eax,%eax
  2c0f1a:	48 01 d0             	add    %rdx,%rax
  2c0f1d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f24:	8b 12                	mov    (%rdx),%edx
  2c0f26:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f30:	89 0a                	mov    %ecx,(%rdx)
  2c0f32:	eb 1a                	jmp    2c0f4e <printer_vprintf+0x5fd>
  2c0f34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f3b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f3f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f43:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f4a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f4e:	48 8b 00             	mov    (%rax),%rax
  2c0f51:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c0f55:	e9 15 01 00 00       	jmp    2c106f <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  2c0f5a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f61:	8b 00                	mov    (%rax),%eax
  2c0f63:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f66:	77 30                	ja     2c0f98 <printer_vprintf+0x647>
  2c0f68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f6f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f73:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f7a:	8b 00                	mov    (%rax),%eax
  2c0f7c:	89 c0                	mov    %eax,%eax
  2c0f7e:	48 01 d0             	add    %rdx,%rax
  2c0f81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f88:	8b 12                	mov    (%rdx),%edx
  2c0f8a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f8d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f94:	89 0a                	mov    %ecx,(%rdx)
  2c0f96:	eb 1a                	jmp    2c0fb2 <printer_vprintf+0x661>
  2c0f98:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f9f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0fa3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0fa7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fae:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0fb2:	8b 00                	mov    (%rax),%eax
  2c0fb4:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c0fba:	e9 77 03 00 00       	jmp    2c1336 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  2c0fbf:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0fc3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c0fc7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fce:	8b 00                	mov    (%rax),%eax
  2c0fd0:	83 f8 2f             	cmp    $0x2f,%eax
  2c0fd3:	77 30                	ja     2c1005 <printer_vprintf+0x6b4>
  2c0fd5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fdc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0fe0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fe7:	8b 00                	mov    (%rax),%eax
  2c0fe9:	89 c0                	mov    %eax,%eax
  2c0feb:	48 01 d0             	add    %rdx,%rax
  2c0fee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ff5:	8b 12                	mov    (%rdx),%edx
  2c0ff7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0ffa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1001:	89 0a                	mov    %ecx,(%rdx)
  2c1003:	eb 1a                	jmp    2c101f <printer_vprintf+0x6ce>
  2c1005:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c100c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1010:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1014:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c101b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c101f:	8b 00                	mov    (%rax),%eax
  2c1021:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1024:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c1028:	eb 45                	jmp    2c106f <printer_vprintf+0x71e>
        default:
            data = numbuf;
  2c102a:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c102e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c1032:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1039:	0f b6 00             	movzbl (%rax),%eax
  2c103c:	84 c0                	test   %al,%al
  2c103e:	74 0c                	je     2c104c <printer_vprintf+0x6fb>
  2c1040:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1047:	0f b6 00             	movzbl (%rax),%eax
  2c104a:	eb 05                	jmp    2c1051 <printer_vprintf+0x700>
  2c104c:	b8 25 00 00 00       	mov    $0x25,%eax
  2c1051:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1054:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c1058:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c105f:	0f b6 00             	movzbl (%rax),%eax
  2c1062:	84 c0                	test   %al,%al
  2c1064:	75 08                	jne    2c106e <printer_vprintf+0x71d>
                format--;
  2c1066:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c106d:	01 
            }
            break;
  2c106e:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c106f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1072:	83 e0 20             	and    $0x20,%eax
  2c1075:	85 c0                	test   %eax,%eax
  2c1077:	74 1e                	je     2c1097 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c1079:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c107d:	48 83 c0 18          	add    $0x18,%rax
  2c1081:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1084:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1088:	48 89 ce             	mov    %rcx,%rsi
  2c108b:	48 89 c7             	mov    %rax,%rdi
  2c108e:	e8 32 f8 ff ff       	call   2c08c5 <fill_numbuf>
  2c1093:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c1097:	48 8d 05 e8 06 00 00 	lea    0x6e8(%rip),%rax        # 2c1786 <flag_chars+0x6>
  2c109e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c10a2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10a5:	83 e0 20             	and    $0x20,%eax
  2c10a8:	85 c0                	test   %eax,%eax
  2c10aa:	74 51                	je     2c10fd <printer_vprintf+0x7ac>
  2c10ac:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10af:	83 e0 40             	and    $0x40,%eax
  2c10b2:	85 c0                	test   %eax,%eax
  2c10b4:	74 47                	je     2c10fd <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  2c10b6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10b9:	25 80 00 00 00       	and    $0x80,%eax
  2c10be:	85 c0                	test   %eax,%eax
  2c10c0:	74 0d                	je     2c10cf <printer_vprintf+0x77e>
                prefix = "-";
  2c10c2:	48 8d 05 be 06 00 00 	lea    0x6be(%rip),%rax        # 2c1787 <flag_chars+0x7>
  2c10c9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c10cd:	eb 7d                	jmp    2c114c <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c10cf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10d2:	83 e0 10             	and    $0x10,%eax
  2c10d5:	85 c0                	test   %eax,%eax
  2c10d7:	74 0d                	je     2c10e6 <printer_vprintf+0x795>
                prefix = "+";
  2c10d9:	48 8d 05 a9 06 00 00 	lea    0x6a9(%rip),%rax        # 2c1789 <flag_chars+0x9>
  2c10e0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c10e4:	eb 66                	jmp    2c114c <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c10e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c10e9:	83 e0 08             	and    $0x8,%eax
  2c10ec:	85 c0                	test   %eax,%eax
  2c10ee:	74 5c                	je     2c114c <printer_vprintf+0x7fb>
                prefix = " ";
  2c10f0:	48 8d 05 94 06 00 00 	lea    0x694(%rip),%rax        # 2c178b <flag_chars+0xb>
  2c10f7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c10fb:	eb 4f                	jmp    2c114c <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c10fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1100:	83 e0 20             	and    $0x20,%eax
  2c1103:	85 c0                	test   %eax,%eax
  2c1105:	74 46                	je     2c114d <printer_vprintf+0x7fc>
  2c1107:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c110a:	83 e0 01             	and    $0x1,%eax
  2c110d:	85 c0                	test   %eax,%eax
  2c110f:	74 3c                	je     2c114d <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  2c1111:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c1115:	74 06                	je     2c111d <printer_vprintf+0x7cc>
  2c1117:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c111b:	75 30                	jne    2c114d <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  2c111d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c1122:	75 0c                	jne    2c1130 <printer_vprintf+0x7df>
  2c1124:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1127:	25 00 01 00 00       	and    $0x100,%eax
  2c112c:	85 c0                	test   %eax,%eax
  2c112e:	74 1d                	je     2c114d <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  2c1130:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1134:	75 09                	jne    2c113f <printer_vprintf+0x7ee>
  2c1136:	48 8d 05 50 06 00 00 	lea    0x650(%rip),%rax        # 2c178d <flag_chars+0xd>
  2c113d:	eb 07                	jmp    2c1146 <printer_vprintf+0x7f5>
  2c113f:	48 8d 05 4a 06 00 00 	lea    0x64a(%rip),%rax        # 2c1790 <flag_chars+0x10>
  2c1146:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c114a:	eb 01                	jmp    2c114d <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  2c114c:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c114d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1151:	78 24                	js     2c1177 <printer_vprintf+0x826>
  2c1153:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1156:	83 e0 20             	and    $0x20,%eax
  2c1159:	85 c0                	test   %eax,%eax
  2c115b:	75 1a                	jne    2c1177 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  2c115d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1160:	48 63 d0             	movslq %eax,%rdx
  2c1163:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1167:	48 89 d6             	mov    %rdx,%rsi
  2c116a:	48 89 c7             	mov    %rax,%rdi
  2c116d:	e8 91 f5 ff ff       	call   2c0703 <strnlen>
  2c1172:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c1175:	eb 0f                	jmp    2c1186 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  2c1177:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c117b:	48 89 c7             	mov    %rax,%rdi
  2c117e:	e8 4b f5 ff ff       	call   2c06ce <strlen>
  2c1183:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c1186:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1189:	83 e0 20             	and    $0x20,%eax
  2c118c:	85 c0                	test   %eax,%eax
  2c118e:	74 20                	je     2c11b0 <printer_vprintf+0x85f>
  2c1190:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1194:	78 1a                	js     2c11b0 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  2c1196:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1199:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c119c:	7e 08                	jle    2c11a6 <printer_vprintf+0x855>
  2c119e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c11a1:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c11a4:	eb 05                	jmp    2c11ab <printer_vprintf+0x85a>
  2c11a6:	b8 00 00 00 00       	mov    $0x0,%eax
  2c11ab:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c11ae:	eb 5c                	jmp    2c120c <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c11b0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11b3:	83 e0 20             	and    $0x20,%eax
  2c11b6:	85 c0                	test   %eax,%eax
  2c11b8:	74 4b                	je     2c1205 <printer_vprintf+0x8b4>
  2c11ba:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11bd:	83 e0 02             	and    $0x2,%eax
  2c11c0:	85 c0                	test   %eax,%eax
  2c11c2:	74 41                	je     2c1205 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c11c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c11c7:	83 e0 04             	and    $0x4,%eax
  2c11ca:	85 c0                	test   %eax,%eax
  2c11cc:	75 37                	jne    2c1205 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  2c11ce:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c11d2:	48 89 c7             	mov    %rax,%rdi
  2c11d5:	e8 f4 f4 ff ff       	call   2c06ce <strlen>
  2c11da:	89 c2                	mov    %eax,%edx
  2c11dc:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c11df:	01 d0                	add    %edx,%eax
  2c11e1:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c11e4:	7e 1f                	jle    2c1205 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  2c11e6:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c11e9:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c11ec:	89 c3                	mov    %eax,%ebx
  2c11ee:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c11f2:	48 89 c7             	mov    %rax,%rdi
  2c11f5:	e8 d4 f4 ff ff       	call   2c06ce <strlen>
  2c11fa:	89 c2                	mov    %eax,%edx
  2c11fc:	89 d8                	mov    %ebx,%eax
  2c11fe:	29 d0                	sub    %edx,%eax
  2c1200:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1203:	eb 07                	jmp    2c120c <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  2c1205:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c120c:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c120f:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c1212:	01 d0                	add    %edx,%eax
  2c1214:	48 63 d8             	movslq %eax,%rbx
  2c1217:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c121b:	48 89 c7             	mov    %rax,%rdi
  2c121e:	e8 ab f4 ff ff       	call   2c06ce <strlen>
  2c1223:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c1227:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c122a:	29 d0                	sub    %edx,%eax
  2c122c:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c122f:	eb 25                	jmp    2c1256 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  2c1231:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1238:	48 8b 08             	mov    (%rax),%rcx
  2c123b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1241:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1248:	be 20 00 00 00       	mov    $0x20,%esi
  2c124d:	48 89 c7             	mov    %rax,%rdi
  2c1250:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1252:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1256:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1259:	83 e0 04             	and    $0x4,%eax
  2c125c:	85 c0                	test   %eax,%eax
  2c125e:	75 36                	jne    2c1296 <printer_vprintf+0x945>
  2c1260:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1264:	7f cb                	jg     2c1231 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  2c1266:	eb 2e                	jmp    2c1296 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  2c1268:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c126f:	4c 8b 00             	mov    (%rax),%r8
  2c1272:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1276:	0f b6 00             	movzbl (%rax),%eax
  2c1279:	0f b6 c8             	movzbl %al,%ecx
  2c127c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1282:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1289:	89 ce                	mov    %ecx,%esi
  2c128b:	48 89 c7             	mov    %rax,%rdi
  2c128e:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1291:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c1296:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c129a:	0f b6 00             	movzbl (%rax),%eax
  2c129d:	84 c0                	test   %al,%al
  2c129f:	75 c7                	jne    2c1268 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  2c12a1:	eb 25                	jmp    2c12c8 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  2c12a3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c12aa:	48 8b 08             	mov    (%rax),%rcx
  2c12ad:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c12b3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c12ba:	be 30 00 00 00       	mov    $0x30,%esi
  2c12bf:	48 89 c7             	mov    %rax,%rdi
  2c12c2:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c12c4:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c12c8:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c12cc:	7f d5                	jg     2c12a3 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  2c12ce:	eb 32                	jmp    2c1302 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  2c12d0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c12d7:	4c 8b 00             	mov    (%rax),%r8
  2c12da:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c12de:	0f b6 00             	movzbl (%rax),%eax
  2c12e1:	0f b6 c8             	movzbl %al,%ecx
  2c12e4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c12ea:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c12f1:	89 ce                	mov    %ecx,%esi
  2c12f3:	48 89 c7             	mov    %rax,%rdi
  2c12f6:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c12f9:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c12fe:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c1302:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c1306:	7f c8                	jg     2c12d0 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  2c1308:	eb 25                	jmp    2c132f <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  2c130a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1311:	48 8b 08             	mov    (%rax),%rcx
  2c1314:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c131a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1321:	be 20 00 00 00       	mov    $0x20,%esi
  2c1326:	48 89 c7             	mov    %rax,%rdi
  2c1329:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c132b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c132f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1333:	7f d5                	jg     2c130a <printer_vprintf+0x9b9>
        }
    done: ;
  2c1335:	90                   	nop
    for (; *format; ++format) {
  2c1336:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c133d:	01 
  2c133e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1345:	0f b6 00             	movzbl (%rax),%eax
  2c1348:	84 c0                	test   %al,%al
  2c134a:	0f 85 31 f6 ff ff    	jne    2c0981 <printer_vprintf+0x30>
    }
}
  2c1350:	90                   	nop
  2c1351:	90                   	nop
  2c1352:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c1356:	c9                   	leave  
  2c1357:	c3                   	ret    

00000000002c1358 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1358:	f3 0f 1e fa          	endbr64 
  2c135c:	55                   	push   %rbp
  2c135d:	48 89 e5             	mov    %rsp,%rbp
  2c1360:	48 83 ec 20          	sub    $0x20,%rsp
  2c1364:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1368:	89 f0                	mov    %esi,%eax
  2c136a:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c136d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1370:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1374:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1378:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c137c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1380:	48 8d 15 19 7c df ff 	lea    -0x2083e7(%rip),%rdx        # b8fa0 <console+0xfa0>
  2c1387:	48 39 d0             	cmp    %rdx,%rax
  2c138a:	72 0f                	jb     2c139b <console_putc+0x43>
        cp->cursor = console;
  2c138c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1390:	48 8d 15 69 6c df ff 	lea    -0x209397(%rip),%rdx        # b8000 <console>
  2c1397:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  2c139b:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c139f:	0f 85 82 00 00 00    	jne    2c1427 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  2c13a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c13a9:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c13ad:	48 8d 15 4c 6c df ff 	lea    -0x2093b4(%rip),%rdx        # b8000 <console>
  2c13b4:	48 29 d0             	sub    %rdx,%rax
  2c13b7:	48 d1 f8             	sar    %rax
  2c13ba:	48 89 c1             	mov    %rax,%rcx
  2c13bd:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c13c4:	66 66 66 
  2c13c7:	48 89 c8             	mov    %rcx,%rax
  2c13ca:	48 f7 ea             	imul   %rdx
  2c13cd:	48 89 d0             	mov    %rdx,%rax
  2c13d0:	48 c1 f8 05          	sar    $0x5,%rax
  2c13d4:	48 89 ce             	mov    %rcx,%rsi
  2c13d7:	48 c1 fe 3f          	sar    $0x3f,%rsi
  2c13db:	48 29 f0             	sub    %rsi,%rax
  2c13de:	48 89 c2             	mov    %rax,%rdx
  2c13e1:	48 89 d0             	mov    %rdx,%rax
  2c13e4:	48 c1 e0 02          	shl    $0x2,%rax
  2c13e8:	48 01 d0             	add    %rdx,%rax
  2c13eb:	48 c1 e0 04          	shl    $0x4,%rax
  2c13ef:	48 29 c1             	sub    %rax,%rcx
  2c13f2:	48 89 ca             	mov    %rcx,%rdx
  2c13f5:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c13f8:	eb 25                	jmp    2c141f <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  2c13fa:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c13fd:	83 c8 20             	or     $0x20,%eax
  2c1400:	89 c6                	mov    %eax,%esi
  2c1402:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1406:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c140a:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c140e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1412:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1416:	89 f2                	mov    %esi,%edx
  2c1418:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c141b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c141f:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c1423:	75 d5                	jne    2c13fa <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c1425:	eb 24                	jmp    2c144b <console_putc+0xf3>
        *cp->cursor++ = c | color;
  2c1427:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c142b:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c142e:	89 d6                	mov    %edx,%esi
  2c1430:	09 c6                	or     %eax,%esi
  2c1432:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1436:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c143a:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c143e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1442:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1446:	89 f2                	mov    %esi,%edx
  2c1448:	66 89 10             	mov    %dx,(%rax)
}
  2c144b:	90                   	nop
  2c144c:	c9                   	leave  
  2c144d:	c3                   	ret    

00000000002c144e <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c144e:	f3 0f 1e fa          	endbr64 
  2c1452:	55                   	push   %rbp
  2c1453:	48 89 e5             	mov    %rsp,%rbp
  2c1456:	48 83 ec 30          	sub    $0x30,%rsp
  2c145a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c145d:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1460:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1464:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1468:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 2c1358 <console_putc>
  2c146f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1473:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1477:	78 09                	js     2c1482 <console_vprintf+0x34>
  2c1479:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1480:	7e 07                	jle    2c1489 <console_vprintf+0x3b>
        cpos = 0;
  2c1482:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c1489:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c148c:	48 98                	cltq   
  2c148e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c1492:	48 8d 05 67 6b df ff 	lea    -0x209499(%rip),%rax        # b8000 <console>
  2c1499:	48 01 d0             	add    %rdx,%rax
  2c149c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c14a0:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c14a4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c14a8:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c14ab:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c14af:	48 89 c7             	mov    %rax,%rdi
  2c14b2:	e8 9a f4 ff ff       	call   2c0951 <printer_vprintf>
    return cp.cursor - console;
  2c14b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c14bb:	48 8d 15 3e 6b df ff 	lea    -0x2094c2(%rip),%rdx        # b8000 <console>
  2c14c2:	48 29 d0             	sub    %rdx,%rax
  2c14c5:	48 d1 f8             	sar    %rax
}
  2c14c8:	c9                   	leave  
  2c14c9:	c3                   	ret    

00000000002c14ca <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c14ca:	f3 0f 1e fa          	endbr64 
  2c14ce:	55                   	push   %rbp
  2c14cf:	48 89 e5             	mov    %rsp,%rbp
  2c14d2:	48 83 ec 60          	sub    $0x60,%rsp
  2c14d6:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c14d9:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c14dc:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c14e0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c14e4:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c14e8:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c14ec:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c14f3:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c14f7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c14fb:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c14ff:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1503:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c1507:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c150b:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c150e:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c1511:	89 c7                	mov    %eax,%edi
  2c1513:	e8 36 ff ff ff       	call   2c144e <console_vprintf>
  2c1518:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c151b:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c151e:	c9                   	leave  
  2c151f:	c3                   	ret    

00000000002c1520 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c1520:	f3 0f 1e fa          	endbr64 
  2c1524:	55                   	push   %rbp
  2c1525:	48 89 e5             	mov    %rsp,%rbp
  2c1528:	48 83 ec 20          	sub    $0x20,%rsp
  2c152c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1530:	89 f0                	mov    %esi,%eax
  2c1532:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1535:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c1538:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c153c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c1540:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1544:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c1548:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c154c:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c1550:	48 39 c2             	cmp    %rax,%rdx
  2c1553:	73 1a                	jae    2c156f <string_putc+0x4f>
        *sp->s++ = c;
  2c1555:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1559:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c155d:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c1561:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c1565:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1569:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c156d:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c156f:	90                   	nop
  2c1570:	c9                   	leave  
  2c1571:	c3                   	ret    

00000000002c1572 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1572:	f3 0f 1e fa          	endbr64 
  2c1576:	55                   	push   %rbp
  2c1577:	48 89 e5             	mov    %rsp,%rbp
  2c157a:	48 83 ec 40          	sub    $0x40,%rsp
  2c157e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1582:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c1586:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c158a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c158e:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 2c1520 <string_putc>
  2c1595:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  2c1599:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c159d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c15a1:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c15a6:	74 33                	je     2c15db <vsnprintf+0x69>
        sp.end = s + size - 1;
  2c15a8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c15ac:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c15b0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c15b4:	48 01 d0             	add    %rdx,%rax
  2c15b7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c15bb:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c15bf:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c15c3:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c15c7:	be 00 00 00 00       	mov    $0x0,%esi
  2c15cc:	48 89 c7             	mov    %rax,%rdi
  2c15cf:	e8 7d f3 ff ff       	call   2c0951 <printer_vprintf>
        *sp.s = 0;
  2c15d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c15d8:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c15db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c15df:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c15e3:	c9                   	leave  
  2c15e4:	c3                   	ret    

00000000002c15e5 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c15e5:	f3 0f 1e fa          	endbr64 
  2c15e9:	55                   	push   %rbp
  2c15ea:	48 89 e5             	mov    %rsp,%rbp
  2c15ed:	48 83 ec 70          	sub    $0x70,%rsp
  2c15f1:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c15f5:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c15f9:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c15fd:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1601:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1605:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1609:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c1610:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1614:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c1618:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c161c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1620:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c1624:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c1628:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c162c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1630:	48 89 c7             	mov    %rax,%rdi
  2c1633:	e8 3a ff ff ff       	call   2c1572 <vsnprintf>
  2c1638:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c163b:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c163e:	c9                   	leave  
  2c163f:	c3                   	ret    

00000000002c1640 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1640:	f3 0f 1e fa          	endbr64 
  2c1644:	55                   	push   %rbp
  2c1645:	48 89 e5             	mov    %rsp,%rbp
  2c1648:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c164c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1653:	eb 1a                	jmp    2c166f <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  2c1655:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c1658:	48 98                	cltq   
  2c165a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c165e:	48 8d 05 9b 69 df ff 	lea    -0x209665(%rip),%rax        # b8000 <console>
  2c1665:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c166b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c166f:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1676:	7e dd                	jle    2c1655 <console_clear+0x15>
    }
    cursorpos = 0;
  2c1678:	c7 05 7a 79 df ff 00 	movl   $0x0,-0x208686(%rip)        # b8ffc <cursorpos>
  2c167f:	00 00 00 
}
  2c1682:	90                   	nop
  2c1683:	c9                   	leave  
  2c1684:	c3                   	ret    
