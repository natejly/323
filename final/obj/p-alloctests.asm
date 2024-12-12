
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
  2c001a:	e8 67 06 00 00       	call   2c0686 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001f:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0024:	e8 15 03 00 00       	call   2c033e <malloc>
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
  2c0043:	e8 0a 03 00 00       	call   2c0352 <realloc>
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
  2c006b:	e8 d8 02 00 00       	call   2c0348 <calloc>
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
  2c008a:	e8 d2 02 00 00       	call   2c0361 <heap_info>
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
  2c00bb:	48 8d 15 ae 13 00 00 	lea    0x13ae(%rip),%rdx        # 2c1470 <console_clear+0x4a>
  2c00c2:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c7:	48 8d 3d b0 13 00 00 	lea    0x13b0(%rip),%rdi        # 2c147e <console_clear+0x58>
  2c00ce:	e8 31 02 00 00       	call   2c0304 <assert_fail>
	assert(array2[i] == 0);
  2c00d3:	48 8d 15 ba 13 00 00 	lea    0x13ba(%rip),%rdx        # 2c1494 <console_clear+0x6e>
  2c00da:	be 21 00 00 00       	mov    $0x21,%esi
  2c00df:	48 8d 3d 98 13 00 00 	lea    0x1398(%rip),%rdi        # 2c147e <console_clear+0x58>
  2c00e6:	e8 19 02 00 00       	call   2c0304 <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00eb:	48 8d 15 c6 13 00 00 	lea    0x13c6(%rip),%rdx        # 2c14b8 <console_clear+0x92>
  2c00f2:	be 28 00 00 00       	mov    $0x28,%esi
  2c00f7:	48 8d 3d 80 13 00 00 	lea    0x1380(%rip),%rdi        # 2c147e <console_clear+0x58>
  2c00fe:	e8 01 02 00 00       	call   2c0304 <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c0103:	48 8d 35 99 13 00 00 	lea    0x1399(%rip),%rsi        # 2c14a3 <console_clear+0x7d>
  2c010a:	bf 00 00 00 00       	mov    $0x0,%edi
  2c010f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0114:	e8 7b 00 00 00       	call   2c0194 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0119:	4c 89 ef             	mov    %r13,%rdi
  2c011c:	e8 18 02 00 00       	call   2c0339 <free>
    free(array2);
  2c0121:	4c 89 f7             	mov    %r14,%rdi
  2c0124:	e8 10 02 00 00       	call   2c0339 <free>

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
  2c0142:	e8 f7 01 00 00       	call   2c033e <malloc>
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
  2c017c:	48 8d 35 65 13 00 00 	lea    0x1365(%rip),%rsi        # 2c14e8 <console_clear+0xc2>
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
  2c01e0:	48 8d 05 66 13 00 00 	lea    0x1366(%rip),%rax        # 2c154d <col.0>
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
  2c0212:	e8 1d 10 00 00       	call   2c1234 <console_vprintf>
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
  2c0276:	48 8d 35 9b 12 00 00 	lea    0x129b(%rip),%rsi        # 2c1518 <console_clear+0xf2>
  2c027d:	e8 e9 00 00 00       	call   2c036b <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0282:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0286:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c028d:	48 89 da             	mov    %rbx,%rdx
  2c0290:	be 99 00 00 00       	mov    $0x99,%esi
  2c0295:	e8 be 10 00 00       	call   2c1358 <vsnprintf>
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
  2c02ba:	48 8d 15 5f 12 00 00 	lea    0x125f(%rip),%rdx        # 2c1520 <console_clear+0xfa>
  2c02c1:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02c6:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02cb:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02d0:	e8 db 0f 00 00       	call   2c12b0 <console_printf>
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
  2c02f6:	48 8d 35 b6 11 00 00 	lea    0x11b6(%rip),%rsi        # 2c14b3 <console_clear+0x8d>
  2c02fd:	e8 2a 02 00 00       	call   2c052c <strcpy>
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
  2c0315:	48 8d 15 0c 12 00 00 	lea    0x120c(%rip),%rdx        # 2c1528 <console_clear+0x102>
  2c031c:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0321:	bf 30 07 00 00       	mov    $0x730,%edi
  2c0326:	b8 00 00 00 00       	mov    $0x0,%eax
  2c032b:	e8 80 0f 00 00       	call   2c12b0 <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0330:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0335:	cd 30                	int    $0x30
 loop: goto loop;
  2c0337:	eb fe                	jmp    2c0337 <assert_fail+0x33>

00000000002c0339 <free>:
#include "malloc.h"

void free(void *firstbyte) {
  2c0339:	f3 0f 1e fa          	endbr64 
    return;
}
  2c033d:	c3                   	ret    

00000000002c033e <malloc>:

void *malloc(uint64_t numbytes) {
  2c033e:	f3 0f 1e fa          	endbr64 
    return 0 ;
}
  2c0342:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0347:	c3                   	ret    

00000000002c0348 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  2c0348:	f3 0f 1e fa          	endbr64 
    return 0;
}
  2c034c:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0351:	c3                   	ret    

00000000002c0352 <realloc>:

void * realloc(void * ptr, uint64_t sz) {
  2c0352:	f3 0f 1e fa          	endbr64 
    return 0;
}
  2c0356:	b8 00 00 00 00       	mov    $0x0,%eax
  2c035b:	c3                   	ret    

00000000002c035c <defrag>:

void defrag() {
  2c035c:	f3 0f 1e fa          	endbr64 
}
  2c0360:	c3                   	ret    

00000000002c0361 <heap_info>:

int heap_info(heap_info_struct * info) {
  2c0361:	f3 0f 1e fa          	endbr64 
    return 0;
}
  2c0365:	b8 00 00 00 00       	mov    $0x0,%eax
  2c036a:	c3                   	ret    

00000000002c036b <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c036b:	f3 0f 1e fa          	endbr64 
  2c036f:	55                   	push   %rbp
  2c0370:	48 89 e5             	mov    %rsp,%rbp
  2c0373:	48 83 ec 28          	sub    $0x28,%rsp
  2c0377:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c037b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c037f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0383:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0387:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c038b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c038f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0393:	eb 1c                	jmp    2c03b1 <memcpy+0x46>
        *d = *s;
  2c0395:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0399:	0f b6 10             	movzbl (%rax),%edx
  2c039c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c03a0:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c03a2:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c03a7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c03ac:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c03b1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c03b6:	75 dd                	jne    2c0395 <memcpy+0x2a>
    }
    return dst;
  2c03b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c03bc:	c9                   	leave  
  2c03bd:	c3                   	ret    

00000000002c03be <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c03be:	f3 0f 1e fa          	endbr64 
  2c03c2:	55                   	push   %rbp
  2c03c3:	48 89 e5             	mov    %rsp,%rbp
  2c03c6:	48 83 ec 28          	sub    $0x28,%rsp
  2c03ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c03ce:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c03d2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c03d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c03da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c03de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c03e2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c03e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c03ea:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c03ee:	73 6a                	jae    2c045a <memmove+0x9c>
  2c03f0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c03f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c03f8:	48 01 d0             	add    %rdx,%rax
  2c03fb:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c03ff:	73 59                	jae    2c045a <memmove+0x9c>
        s += n, d += n;
  2c0401:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0405:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0409:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c040d:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0411:	eb 17                	jmp    2c042a <memmove+0x6c>
            *--d = *--s;
  2c0413:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0418:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c041d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0421:	0f b6 10             	movzbl (%rax),%edx
  2c0424:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0428:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c042a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c042e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0432:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0436:	48 85 c0             	test   %rax,%rax
  2c0439:	75 d8                	jne    2c0413 <memmove+0x55>
    if (s < d && s + n > d) {
  2c043b:	eb 2e                	jmp    2c046b <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c043d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0441:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0445:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0449:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c044d:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0451:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0455:	0f b6 12             	movzbl (%rdx),%edx
  2c0458:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c045a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c045e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0462:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0466:	48 85 c0             	test   %rax,%rax
  2c0469:	75 d2                	jne    2c043d <memmove+0x7f>
        }
    }
    return dst;
  2c046b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c046f:	c9                   	leave  
  2c0470:	c3                   	ret    

00000000002c0471 <memset>:

void* memset(void* v, int c, size_t n) {
  2c0471:	f3 0f 1e fa          	endbr64 
  2c0475:	55                   	push   %rbp
  2c0476:	48 89 e5             	mov    %rsp,%rbp
  2c0479:	48 83 ec 28          	sub    $0x28,%rsp
  2c047d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0481:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0484:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0488:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c048c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0490:	eb 15                	jmp    2c04a7 <memset+0x36>
        *p = c;
  2c0492:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0495:	89 c2                	mov    %eax,%edx
  2c0497:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c049b:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c049d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c04a2:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c04a7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c04ac:	75 e4                	jne    2c0492 <memset+0x21>
    }
    return v;
  2c04ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c04b2:	c9                   	leave  
  2c04b3:	c3                   	ret    

00000000002c04b4 <strlen>:

size_t strlen(const char* s) {
  2c04b4:	f3 0f 1e fa          	endbr64 
  2c04b8:	55                   	push   %rbp
  2c04b9:	48 89 e5             	mov    %rsp,%rbp
  2c04bc:	48 83 ec 18          	sub    $0x18,%rsp
  2c04c0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c04c4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c04cb:	00 
  2c04cc:	eb 0a                	jmp    2c04d8 <strlen+0x24>
        ++n;
  2c04ce:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c04d3:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c04d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c04dc:	0f b6 00             	movzbl (%rax),%eax
  2c04df:	84 c0                	test   %al,%al
  2c04e1:	75 eb                	jne    2c04ce <strlen+0x1a>
    }
    return n;
  2c04e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c04e7:	c9                   	leave  
  2c04e8:	c3                   	ret    

00000000002c04e9 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c04e9:	f3 0f 1e fa          	endbr64 
  2c04ed:	55                   	push   %rbp
  2c04ee:	48 89 e5             	mov    %rsp,%rbp
  2c04f1:	48 83 ec 20          	sub    $0x20,%rsp
  2c04f5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c04f9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c04fd:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0504:	00 
  2c0505:	eb 0a                	jmp    2c0511 <strnlen+0x28>
        ++n;
  2c0507:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c050c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0511:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0515:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0519:	74 0b                	je     2c0526 <strnlen+0x3d>
  2c051b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c051f:	0f b6 00             	movzbl (%rax),%eax
  2c0522:	84 c0                	test   %al,%al
  2c0524:	75 e1                	jne    2c0507 <strnlen+0x1e>
    }
    return n;
  2c0526:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c052a:	c9                   	leave  
  2c052b:	c3                   	ret    

00000000002c052c <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c052c:	f3 0f 1e fa          	endbr64 
  2c0530:	55                   	push   %rbp
  2c0531:	48 89 e5             	mov    %rsp,%rbp
  2c0534:	48 83 ec 20          	sub    $0x20,%rsp
  2c0538:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c053c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0540:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0544:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0548:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c054c:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0550:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0554:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0558:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c055c:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0560:	0f b6 12             	movzbl (%rdx),%edx
  2c0563:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0565:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0569:	48 83 e8 01          	sub    $0x1,%rax
  2c056d:	0f b6 00             	movzbl (%rax),%eax
  2c0570:	84 c0                	test   %al,%al
  2c0572:	75 d4                	jne    2c0548 <strcpy+0x1c>
    return dst;
  2c0574:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0578:	c9                   	leave  
  2c0579:	c3                   	ret    

00000000002c057a <strcmp>:

int strcmp(const char* a, const char* b) {
  2c057a:	f3 0f 1e fa          	endbr64 
  2c057e:	55                   	push   %rbp
  2c057f:	48 89 e5             	mov    %rsp,%rbp
  2c0582:	48 83 ec 10          	sub    $0x10,%rsp
  2c0586:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c058a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c058e:	eb 0a                	jmp    2c059a <strcmp+0x20>
        ++a, ++b;
  2c0590:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0595:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c059a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c059e:	0f b6 00             	movzbl (%rax),%eax
  2c05a1:	84 c0                	test   %al,%al
  2c05a3:	74 1d                	je     2c05c2 <strcmp+0x48>
  2c05a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c05a9:	0f b6 00             	movzbl (%rax),%eax
  2c05ac:	84 c0                	test   %al,%al
  2c05ae:	74 12                	je     2c05c2 <strcmp+0x48>
  2c05b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05b4:	0f b6 10             	movzbl (%rax),%edx
  2c05b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c05bb:	0f b6 00             	movzbl (%rax),%eax
  2c05be:	38 c2                	cmp    %al,%dl
  2c05c0:	74 ce                	je     2c0590 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c05c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05c6:	0f b6 00             	movzbl (%rax),%eax
  2c05c9:	89 c2                	mov    %eax,%edx
  2c05cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c05cf:	0f b6 00             	movzbl (%rax),%eax
  2c05d2:	38 c2                	cmp    %al,%dl
  2c05d4:	0f 97 c0             	seta   %al
  2c05d7:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c05da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c05de:	0f b6 00             	movzbl (%rax),%eax
  2c05e1:	89 c1                	mov    %eax,%ecx
  2c05e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c05e7:	0f b6 00             	movzbl (%rax),%eax
  2c05ea:	38 c1                	cmp    %al,%cl
  2c05ec:	0f 92 c0             	setb   %al
  2c05ef:	0f b6 c8             	movzbl %al,%ecx
  2c05f2:	89 d0                	mov    %edx,%eax
  2c05f4:	29 c8                	sub    %ecx,%eax
}
  2c05f6:	c9                   	leave  
  2c05f7:	c3                   	ret    

00000000002c05f8 <strchr>:

char* strchr(const char* s, int c) {
  2c05f8:	f3 0f 1e fa          	endbr64 
  2c05fc:	55                   	push   %rbp
  2c05fd:	48 89 e5             	mov    %rsp,%rbp
  2c0600:	48 83 ec 10          	sub    $0x10,%rsp
  2c0604:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0608:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c060b:	eb 05                	jmp    2c0612 <strchr+0x1a>
        ++s;
  2c060d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0612:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0616:	0f b6 00             	movzbl (%rax),%eax
  2c0619:	84 c0                	test   %al,%al
  2c061b:	74 0e                	je     2c062b <strchr+0x33>
  2c061d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0621:	0f b6 00             	movzbl (%rax),%eax
  2c0624:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0627:	38 d0                	cmp    %dl,%al
  2c0629:	75 e2                	jne    2c060d <strchr+0x15>
    }
    if (*s == (char) c) {
  2c062b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c062f:	0f b6 00             	movzbl (%rax),%eax
  2c0632:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0635:	38 d0                	cmp    %dl,%al
  2c0637:	75 06                	jne    2c063f <strchr+0x47>
        return (char*) s;
  2c0639:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c063d:	eb 05                	jmp    2c0644 <strchr+0x4c>
    } else {
        return NULL;
  2c063f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0644:	c9                   	leave  
  2c0645:	c3                   	ret    

00000000002c0646 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0646:	f3 0f 1e fa          	endbr64 
  2c064a:	55                   	push   %rbp
  2c064b:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c064e:	8b 05 ac 19 00 00    	mov    0x19ac(%rip),%eax        # 2c2000 <rand_seed_set>
  2c0654:	85 c0                	test   %eax,%eax
  2c0656:	75 0a                	jne    2c0662 <rand+0x1c>
        srand(819234718U);
  2c0658:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c065d:	e8 24 00 00 00       	call   2c0686 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0662:	8b 05 9c 19 00 00    	mov    0x199c(%rip),%eax        # 2c2004 <rand_seed>
  2c0668:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c066e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0673:	89 05 8b 19 00 00    	mov    %eax,0x198b(%rip)        # 2c2004 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0679:	8b 05 85 19 00 00    	mov    0x1985(%rip),%eax        # 2c2004 <rand_seed>
  2c067f:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0684:	5d                   	pop    %rbp
  2c0685:	c3                   	ret    

00000000002c0686 <srand>:

void srand(unsigned seed) {
  2c0686:	f3 0f 1e fa          	endbr64 
  2c068a:	55                   	push   %rbp
  2c068b:	48 89 e5             	mov    %rsp,%rbp
  2c068e:	48 83 ec 08          	sub    $0x8,%rsp
  2c0692:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0695:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0698:	89 05 66 19 00 00    	mov    %eax,0x1966(%rip)        # 2c2004 <rand_seed>
    rand_seed_set = 1;
  2c069e:	c7 05 58 19 00 00 01 	movl   $0x1,0x1958(%rip)        # 2c2000 <rand_seed_set>
  2c06a5:	00 00 00 
}
  2c06a8:	90                   	nop
  2c06a9:	c9                   	leave  
  2c06aa:	c3                   	ret    

00000000002c06ab <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c06ab:	f3 0f 1e fa          	endbr64 
  2c06af:	55                   	push   %rbp
  2c06b0:	48 89 e5             	mov    %rsp,%rbp
  2c06b3:	48 83 ec 28          	sub    $0x28,%rsp
  2c06b7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c06bb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c06bf:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c06c2:	48 8d 05 97 0f 00 00 	lea    0xf97(%rip),%rax        # 2c1660 <upper_digits.1>
  2c06c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  2c06cd:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c06d1:	79 0e                	jns    2c06e1 <fill_numbuf+0x36>
        digits = lower_digits;
  2c06d3:	48 8d 05 a6 0f 00 00 	lea    0xfa6(%rip),%rax        # 2c1680 <lower_digits.0>
  2c06da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  2c06de:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c06e1:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c06e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c06ea:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c06ed:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c06f0:	48 63 c8             	movslq %eax,%rcx
  2c06f3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c06f7:	ba 00 00 00 00       	mov    $0x0,%edx
  2c06fc:	48 f7 f1             	div    %rcx
  2c06ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0703:	48 01 d0             	add    %rdx,%rax
  2c0706:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c070b:	0f b6 10             	movzbl (%rax),%edx
  2c070e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0712:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0714:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0717:	48 63 f0             	movslq %eax,%rsi
  2c071a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c071e:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0723:	48 f7 f6             	div    %rsi
  2c0726:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c072a:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c072f:	75 bc                	jne    2c06ed <fill_numbuf+0x42>
    return numbuf_end;
  2c0731:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0735:	c9                   	leave  
  2c0736:	c3                   	ret    

00000000002c0737 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0737:	f3 0f 1e fa          	endbr64 
  2c073b:	55                   	push   %rbp
  2c073c:	48 89 e5             	mov    %rsp,%rbp
  2c073f:	53                   	push   %rbx
  2c0740:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0747:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c074e:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0754:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c075b:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0762:	e9 bd 09 00 00       	jmp    2c1124 <printer_vprintf+0x9ed>
        if (*format != '%') {
  2c0767:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c076e:	0f b6 00             	movzbl (%rax),%eax
  2c0771:	3c 25                	cmp    $0x25,%al
  2c0773:	74 31                	je     2c07a6 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  2c0775:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c077c:	4c 8b 00             	mov    (%rax),%r8
  2c077f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0786:	0f b6 00             	movzbl (%rax),%eax
  2c0789:	0f b6 c8             	movzbl %al,%ecx
  2c078c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0792:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0799:	89 ce                	mov    %ecx,%esi
  2c079b:	48 89 c7             	mov    %rax,%rdi
  2c079e:	41 ff d0             	call   *%r8
            continue;
  2c07a1:	e9 76 09 00 00       	jmp    2c111c <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  2c07a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c07ad:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c07b4:	01 
  2c07b5:	eb 4d                	jmp    2c0804 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  2c07b7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c07be:	0f b6 00             	movzbl (%rax),%eax
  2c07c1:	0f be c0             	movsbl %al,%eax
  2c07c4:	89 c6                	mov    %eax,%esi
  2c07c6:	48 8d 05 93 0d 00 00 	lea    0xd93(%rip),%rax        # 2c1560 <flag_chars>
  2c07cd:	48 89 c7             	mov    %rax,%rdi
  2c07d0:	e8 23 fe ff ff       	call   2c05f8 <strchr>
  2c07d5:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c07d9:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c07de:	74 34                	je     2c0814 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  2c07e0:	48 8d 15 79 0d 00 00 	lea    0xd79(%rip),%rdx        # 2c1560 <flag_chars>
  2c07e7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c07eb:	48 29 d0             	sub    %rdx,%rax
  2c07ee:	ba 01 00 00 00       	mov    $0x1,%edx
  2c07f3:	89 c1                	mov    %eax,%ecx
  2c07f5:	d3 e2                	shl    %cl,%edx
  2c07f7:	89 d0                	mov    %edx,%eax
  2c07f9:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c07fc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0803:	01 
  2c0804:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c080b:	0f b6 00             	movzbl (%rax),%eax
  2c080e:	84 c0                	test   %al,%al
  2c0810:	75 a5                	jne    2c07b7 <printer_vprintf+0x80>
  2c0812:	eb 01                	jmp    2c0815 <printer_vprintf+0xde>
            } else {
                break;
  2c0814:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0815:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c081c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0823:	0f b6 00             	movzbl (%rax),%eax
  2c0826:	3c 30                	cmp    $0x30,%al
  2c0828:	7e 67                	jle    2c0891 <printer_vprintf+0x15a>
  2c082a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0831:	0f b6 00             	movzbl (%rax),%eax
  2c0834:	3c 39                	cmp    $0x39,%al
  2c0836:	7f 59                	jg     2c0891 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0838:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c083f:	eb 2e                	jmp    2c086f <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  2c0841:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0844:	89 d0                	mov    %edx,%eax
  2c0846:	c1 e0 02             	shl    $0x2,%eax
  2c0849:	01 d0                	add    %edx,%eax
  2c084b:	01 c0                	add    %eax,%eax
  2c084d:	89 c1                	mov    %eax,%ecx
  2c084f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0856:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c085a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0861:	0f b6 00             	movzbl (%rax),%eax
  2c0864:	0f be c0             	movsbl %al,%eax
  2c0867:	01 c8                	add    %ecx,%eax
  2c0869:	83 e8 30             	sub    $0x30,%eax
  2c086c:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c086f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0876:	0f b6 00             	movzbl (%rax),%eax
  2c0879:	3c 2f                	cmp    $0x2f,%al
  2c087b:	0f 8e 85 00 00 00    	jle    2c0906 <printer_vprintf+0x1cf>
  2c0881:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0888:	0f b6 00             	movzbl (%rax),%eax
  2c088b:	3c 39                	cmp    $0x39,%al
  2c088d:	7e b2                	jle    2c0841 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  2c088f:	eb 75                	jmp    2c0906 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  2c0891:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0898:	0f b6 00             	movzbl (%rax),%eax
  2c089b:	3c 2a                	cmp    $0x2a,%al
  2c089d:	75 68                	jne    2c0907 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  2c089f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c08a6:	8b 00                	mov    (%rax),%eax
  2c08a8:	83 f8 2f             	cmp    $0x2f,%eax
  2c08ab:	77 30                	ja     2c08dd <printer_vprintf+0x1a6>
  2c08ad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c08b4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c08b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c08bf:	8b 00                	mov    (%rax),%eax
  2c08c1:	89 c0                	mov    %eax,%eax
  2c08c3:	48 01 d0             	add    %rdx,%rax
  2c08c6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c08cd:	8b 12                	mov    (%rdx),%edx
  2c08cf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c08d2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c08d9:	89 0a                	mov    %ecx,(%rdx)
  2c08db:	eb 1a                	jmp    2c08f7 <printer_vprintf+0x1c0>
  2c08dd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c08e4:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c08e8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c08ec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c08f3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c08f7:	8b 00                	mov    (%rax),%eax
  2c08f9:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c08fc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0903:	01 
  2c0904:	eb 01                	jmp    2c0907 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  2c0906:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0907:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c090e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0915:	0f b6 00             	movzbl (%rax),%eax
  2c0918:	3c 2e                	cmp    $0x2e,%al
  2c091a:	0f 85 00 01 00 00    	jne    2c0a20 <printer_vprintf+0x2e9>
            ++format;
  2c0920:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0927:	01 
            if (*format >= '0' && *format <= '9') {
  2c0928:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c092f:	0f b6 00             	movzbl (%rax),%eax
  2c0932:	3c 2f                	cmp    $0x2f,%al
  2c0934:	7e 67                	jle    2c099d <printer_vprintf+0x266>
  2c0936:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c093d:	0f b6 00             	movzbl (%rax),%eax
  2c0940:	3c 39                	cmp    $0x39,%al
  2c0942:	7f 59                	jg     2c099d <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0944:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c094b:	eb 2e                	jmp    2c097b <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  2c094d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0950:	89 d0                	mov    %edx,%eax
  2c0952:	c1 e0 02             	shl    $0x2,%eax
  2c0955:	01 d0                	add    %edx,%eax
  2c0957:	01 c0                	add    %eax,%eax
  2c0959:	89 c1                	mov    %eax,%ecx
  2c095b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0962:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0966:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c096d:	0f b6 00             	movzbl (%rax),%eax
  2c0970:	0f be c0             	movsbl %al,%eax
  2c0973:	01 c8                	add    %ecx,%eax
  2c0975:	83 e8 30             	sub    $0x30,%eax
  2c0978:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c097b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0982:	0f b6 00             	movzbl (%rax),%eax
  2c0985:	3c 2f                	cmp    $0x2f,%al
  2c0987:	0f 8e 85 00 00 00    	jle    2c0a12 <printer_vprintf+0x2db>
  2c098d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0994:	0f b6 00             	movzbl (%rax),%eax
  2c0997:	3c 39                	cmp    $0x39,%al
  2c0999:	7e b2                	jle    2c094d <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  2c099b:	eb 75                	jmp    2c0a12 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  2c099d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c09a4:	0f b6 00             	movzbl (%rax),%eax
  2c09a7:	3c 2a                	cmp    $0x2a,%al
  2c09a9:	75 68                	jne    2c0a13 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  2c09ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c09b2:	8b 00                	mov    (%rax),%eax
  2c09b4:	83 f8 2f             	cmp    $0x2f,%eax
  2c09b7:	77 30                	ja     2c09e9 <printer_vprintf+0x2b2>
  2c09b9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c09c0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c09c4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c09cb:	8b 00                	mov    (%rax),%eax
  2c09cd:	89 c0                	mov    %eax,%eax
  2c09cf:	48 01 d0             	add    %rdx,%rax
  2c09d2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c09d9:	8b 12                	mov    (%rdx),%edx
  2c09db:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c09de:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c09e5:	89 0a                	mov    %ecx,(%rdx)
  2c09e7:	eb 1a                	jmp    2c0a03 <printer_vprintf+0x2cc>
  2c09e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c09f0:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c09f4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c09f8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c09ff:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0a03:	8b 00                	mov    (%rax),%eax
  2c0a05:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0a08:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0a0f:	01 
  2c0a10:	eb 01                	jmp    2c0a13 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  2c0a12:	90                   	nop
            }
            if (precision < 0) {
  2c0a13:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0a17:	79 07                	jns    2c0a20 <printer_vprintf+0x2e9>
                precision = 0;
  2c0a19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0a20:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0a27:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0a2e:	00 
        int length = 0;
  2c0a2f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0a36:	48 8d 05 29 0b 00 00 	lea    0xb29(%rip),%rax        # 2c1566 <flag_chars+0x6>
  2c0a3d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  2c0a41:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0a48:	0f b6 00             	movzbl (%rax),%eax
  2c0a4b:	0f be c0             	movsbl %al,%eax
  2c0a4e:	83 e8 43             	sub    $0x43,%eax
  2c0a51:	83 f8 37             	cmp    $0x37,%eax
  2c0a54:	0f 87 b6 03 00 00    	ja     2c0e10 <printer_vprintf+0x6d9>
  2c0a5a:	89 c0                	mov    %eax,%eax
  2c0a5c:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  2c0a63:	00 
  2c0a64:	48 8d 05 09 0b 00 00 	lea    0xb09(%rip),%rax        # 2c1574 <flag_chars+0x14>
  2c0a6b:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  2c0a6e:	48 98                	cltq   
  2c0a70:	48 8d 15 fd 0a 00 00 	lea    0xafd(%rip),%rdx        # 2c1574 <flag_chars+0x14>
  2c0a77:	48 01 d0             	add    %rdx,%rax
  2c0a7a:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0a7d:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0a84:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0a8b:	01 
            goto again;
  2c0a8c:	eb b3                	jmp    2c0a41 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0a8e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0a92:	74 5d                	je     2c0af1 <printer_vprintf+0x3ba>
  2c0a94:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0a9b:	8b 00                	mov    (%rax),%eax
  2c0a9d:	83 f8 2f             	cmp    $0x2f,%eax
  2c0aa0:	77 30                	ja     2c0ad2 <printer_vprintf+0x39b>
  2c0aa2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0aa9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0aad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ab4:	8b 00                	mov    (%rax),%eax
  2c0ab6:	89 c0                	mov    %eax,%eax
  2c0ab8:	48 01 d0             	add    %rdx,%rax
  2c0abb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ac2:	8b 12                	mov    (%rdx),%edx
  2c0ac4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0ac7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ace:	89 0a                	mov    %ecx,(%rdx)
  2c0ad0:	eb 1a                	jmp    2c0aec <printer_vprintf+0x3b5>
  2c0ad2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ad9:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0add:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0ae1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ae8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0aec:	48 8b 00             	mov    (%rax),%rax
  2c0aef:	eb 5c                	jmp    2c0b4d <printer_vprintf+0x416>
  2c0af1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0af8:	8b 00                	mov    (%rax),%eax
  2c0afa:	83 f8 2f             	cmp    $0x2f,%eax
  2c0afd:	77 30                	ja     2c0b2f <printer_vprintf+0x3f8>
  2c0aff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b06:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0b0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b11:	8b 00                	mov    (%rax),%eax
  2c0b13:	89 c0                	mov    %eax,%eax
  2c0b15:	48 01 d0             	add    %rdx,%rax
  2c0b18:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b1f:	8b 12                	mov    (%rdx),%edx
  2c0b21:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0b24:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b2b:	89 0a                	mov    %ecx,(%rdx)
  2c0b2d:	eb 1a                	jmp    2c0b49 <printer_vprintf+0x412>
  2c0b2f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b36:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0b3a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0b3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0b45:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0b49:	8b 00                	mov    (%rax),%eax
  2c0b4b:	48 98                	cltq   
  2c0b4d:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0b51:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0b55:	48 c1 f8 38          	sar    $0x38,%rax
  2c0b59:	25 80 00 00 00       	and    $0x80,%eax
  2c0b5e:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0b61:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c0b65:	74 09                	je     2c0b70 <printer_vprintf+0x439>
  2c0b67:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0b6b:	48 f7 d8             	neg    %rax
  2c0b6e:	eb 04                	jmp    2c0b74 <printer_vprintf+0x43d>
  2c0b70:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0b74:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c0b78:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c0b7b:	83 c8 60             	or     $0x60,%eax
  2c0b7e:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c0b81:	e9 cf 02 00 00       	jmp    2c0e55 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0b86:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0b8a:	74 5d                	je     2c0be9 <printer_vprintf+0x4b2>
  2c0b8c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0b93:	8b 00                	mov    (%rax),%eax
  2c0b95:	83 f8 2f             	cmp    $0x2f,%eax
  2c0b98:	77 30                	ja     2c0bca <printer_vprintf+0x493>
  2c0b9a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ba1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0ba5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bac:	8b 00                	mov    (%rax),%eax
  2c0bae:	89 c0                	mov    %eax,%eax
  2c0bb0:	48 01 d0             	add    %rdx,%rax
  2c0bb3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bba:	8b 12                	mov    (%rdx),%edx
  2c0bbc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0bbf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0bc6:	89 0a                	mov    %ecx,(%rdx)
  2c0bc8:	eb 1a                	jmp    2c0be4 <printer_vprintf+0x4ad>
  2c0bca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bd1:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0bd5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0bd9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0be0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0be4:	48 8b 00             	mov    (%rax),%rax
  2c0be7:	eb 5c                	jmp    2c0c45 <printer_vprintf+0x50e>
  2c0be9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bf0:	8b 00                	mov    (%rax),%eax
  2c0bf2:	83 f8 2f             	cmp    $0x2f,%eax
  2c0bf5:	77 30                	ja     2c0c27 <printer_vprintf+0x4f0>
  2c0bf7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0bfe:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0c02:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c09:	8b 00                	mov    (%rax),%eax
  2c0c0b:	89 c0                	mov    %eax,%eax
  2c0c0d:	48 01 d0             	add    %rdx,%rax
  2c0c10:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c17:	8b 12                	mov    (%rdx),%edx
  2c0c19:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0c1c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c23:	89 0a                	mov    %ecx,(%rdx)
  2c0c25:	eb 1a                	jmp    2c0c41 <printer_vprintf+0x50a>
  2c0c27:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c2e:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0c32:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0c36:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c3d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0c41:	8b 00                	mov    (%rax),%eax
  2c0c43:	89 c0                	mov    %eax,%eax
  2c0c45:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c0c49:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c0c4d:	e9 03 02 00 00       	jmp    2c0e55 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  2c0c52:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c0c59:	e9 28 ff ff ff       	jmp    2c0b86 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  2c0c5e:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c0c65:	e9 1c ff ff ff       	jmp    2c0b86 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c0c6a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c71:	8b 00                	mov    (%rax),%eax
  2c0c73:	83 f8 2f             	cmp    $0x2f,%eax
  2c0c76:	77 30                	ja     2c0ca8 <printer_vprintf+0x571>
  2c0c78:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c7f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0c83:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0c8a:	8b 00                	mov    (%rax),%eax
  2c0c8c:	89 c0                	mov    %eax,%eax
  2c0c8e:	48 01 d0             	add    %rdx,%rax
  2c0c91:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0c98:	8b 12                	mov    (%rdx),%edx
  2c0c9a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0c9d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ca4:	89 0a                	mov    %ecx,(%rdx)
  2c0ca6:	eb 1a                	jmp    2c0cc2 <printer_vprintf+0x58b>
  2c0ca8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0caf:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0cb3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0cb7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0cbe:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0cc2:	48 8b 00             	mov    (%rax),%rax
  2c0cc5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c0cc9:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c0cd0:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c0cd7:	e9 79 01 00 00       	jmp    2c0e55 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  2c0cdc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ce3:	8b 00                	mov    (%rax),%eax
  2c0ce5:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ce8:	77 30                	ja     2c0d1a <printer_vprintf+0x5e3>
  2c0cea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cf1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0cf5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0cfc:	8b 00                	mov    (%rax),%eax
  2c0cfe:	89 c0                	mov    %eax,%eax
  2c0d00:	48 01 d0             	add    %rdx,%rax
  2c0d03:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d0a:	8b 12                	mov    (%rdx),%edx
  2c0d0c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0d0f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d16:	89 0a                	mov    %ecx,(%rdx)
  2c0d18:	eb 1a                	jmp    2c0d34 <printer_vprintf+0x5fd>
  2c0d1a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d21:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d25:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d30:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d34:	48 8b 00             	mov    (%rax),%rax
  2c0d37:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c0d3b:	e9 15 01 00 00       	jmp    2c0e55 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  2c0d40:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d47:	8b 00                	mov    (%rax),%eax
  2c0d49:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d4c:	77 30                	ja     2c0d7e <printer_vprintf+0x647>
  2c0d4e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d55:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0d59:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d60:	8b 00                	mov    (%rax),%eax
  2c0d62:	89 c0                	mov    %eax,%eax
  2c0d64:	48 01 d0             	add    %rdx,%rax
  2c0d67:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d6e:	8b 12                	mov    (%rdx),%edx
  2c0d70:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0d73:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d7a:	89 0a                	mov    %ecx,(%rdx)
  2c0d7c:	eb 1a                	jmp    2c0d98 <printer_vprintf+0x661>
  2c0d7e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d85:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d89:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d8d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d94:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d98:	8b 00                	mov    (%rax),%eax
  2c0d9a:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c0da0:	e9 77 03 00 00       	jmp    2c111c <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  2c0da5:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0da9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c0dad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0db4:	8b 00                	mov    (%rax),%eax
  2c0db6:	83 f8 2f             	cmp    $0x2f,%eax
  2c0db9:	77 30                	ja     2c0deb <printer_vprintf+0x6b4>
  2c0dbb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dc2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0dc6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dcd:	8b 00                	mov    (%rax),%eax
  2c0dcf:	89 c0                	mov    %eax,%eax
  2c0dd1:	48 01 d0             	add    %rdx,%rax
  2c0dd4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ddb:	8b 12                	mov    (%rdx),%edx
  2c0ddd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0de0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0de7:	89 0a                	mov    %ecx,(%rdx)
  2c0de9:	eb 1a                	jmp    2c0e05 <printer_vprintf+0x6ce>
  2c0deb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0df2:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0df6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0dfa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e01:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e05:	8b 00                	mov    (%rax),%eax
  2c0e07:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c0e0a:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c0e0e:	eb 45                	jmp    2c0e55 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  2c0e10:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0e14:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c0e18:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e1f:	0f b6 00             	movzbl (%rax),%eax
  2c0e22:	84 c0                	test   %al,%al
  2c0e24:	74 0c                	je     2c0e32 <printer_vprintf+0x6fb>
  2c0e26:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e2d:	0f b6 00             	movzbl (%rax),%eax
  2c0e30:	eb 05                	jmp    2c0e37 <printer_vprintf+0x700>
  2c0e32:	b8 25 00 00 00       	mov    $0x25,%eax
  2c0e37:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c0e3a:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c0e3e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e45:	0f b6 00             	movzbl (%rax),%eax
  2c0e48:	84 c0                	test   %al,%al
  2c0e4a:	75 08                	jne    2c0e54 <printer_vprintf+0x71d>
                format--;
  2c0e4c:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c0e53:	01 
            }
            break;
  2c0e54:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c0e55:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0e58:	83 e0 20             	and    $0x20,%eax
  2c0e5b:	85 c0                	test   %eax,%eax
  2c0e5d:	74 1e                	je     2c0e7d <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c0e5f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c0e63:	48 83 c0 18          	add    $0x18,%rax
  2c0e67:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c0e6a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c0e6e:	48 89 ce             	mov    %rcx,%rsi
  2c0e71:	48 89 c7             	mov    %rax,%rdi
  2c0e74:	e8 32 f8 ff ff       	call   2c06ab <fill_numbuf>
  2c0e79:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c0e7d:	48 8d 05 e2 06 00 00 	lea    0x6e2(%rip),%rax        # 2c1566 <flag_chars+0x6>
  2c0e84:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c0e88:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0e8b:	83 e0 20             	and    $0x20,%eax
  2c0e8e:	85 c0                	test   %eax,%eax
  2c0e90:	74 51                	je     2c0ee3 <printer_vprintf+0x7ac>
  2c0e92:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0e95:	83 e0 40             	and    $0x40,%eax
  2c0e98:	85 c0                	test   %eax,%eax
  2c0e9a:	74 47                	je     2c0ee3 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  2c0e9c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0e9f:	25 80 00 00 00       	and    $0x80,%eax
  2c0ea4:	85 c0                	test   %eax,%eax
  2c0ea6:	74 0d                	je     2c0eb5 <printer_vprintf+0x77e>
                prefix = "-";
  2c0ea8:	48 8d 05 b8 06 00 00 	lea    0x6b8(%rip),%rax        # 2c1567 <flag_chars+0x7>
  2c0eaf:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c0eb3:	eb 7d                	jmp    2c0f32 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c0eb5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0eb8:	83 e0 10             	and    $0x10,%eax
  2c0ebb:	85 c0                	test   %eax,%eax
  2c0ebd:	74 0d                	je     2c0ecc <printer_vprintf+0x795>
                prefix = "+";
  2c0ebf:	48 8d 05 a3 06 00 00 	lea    0x6a3(%rip),%rax        # 2c1569 <flag_chars+0x9>
  2c0ec6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c0eca:	eb 66                	jmp    2c0f32 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c0ecc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0ecf:	83 e0 08             	and    $0x8,%eax
  2c0ed2:	85 c0                	test   %eax,%eax
  2c0ed4:	74 5c                	je     2c0f32 <printer_vprintf+0x7fb>
                prefix = " ";
  2c0ed6:	48 8d 05 8e 06 00 00 	lea    0x68e(%rip),%rax        # 2c156b <flag_chars+0xb>
  2c0edd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c0ee1:	eb 4f                	jmp    2c0f32 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c0ee3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0ee6:	83 e0 20             	and    $0x20,%eax
  2c0ee9:	85 c0                	test   %eax,%eax
  2c0eeb:	74 46                	je     2c0f33 <printer_vprintf+0x7fc>
  2c0eed:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0ef0:	83 e0 01             	and    $0x1,%eax
  2c0ef3:	85 c0                	test   %eax,%eax
  2c0ef5:	74 3c                	je     2c0f33 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  2c0ef7:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c0efb:	74 06                	je     2c0f03 <printer_vprintf+0x7cc>
  2c0efd:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c0f01:	75 30                	jne    2c0f33 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  2c0f03:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0f08:	75 0c                	jne    2c0f16 <printer_vprintf+0x7df>
  2c0f0a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f0d:	25 00 01 00 00       	and    $0x100,%eax
  2c0f12:	85 c0                	test   %eax,%eax
  2c0f14:	74 1d                	je     2c0f33 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  2c0f16:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c0f1a:	75 09                	jne    2c0f25 <printer_vprintf+0x7ee>
  2c0f1c:	48 8d 05 4a 06 00 00 	lea    0x64a(%rip),%rax        # 2c156d <flag_chars+0xd>
  2c0f23:	eb 07                	jmp    2c0f2c <printer_vprintf+0x7f5>
  2c0f25:	48 8d 05 44 06 00 00 	lea    0x644(%rip),%rax        # 2c1570 <flag_chars+0x10>
  2c0f2c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0f30:	eb 01                	jmp    2c0f33 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  2c0f32:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c0f33:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0f37:	78 24                	js     2c0f5d <printer_vprintf+0x826>
  2c0f39:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f3c:	83 e0 20             	and    $0x20,%eax
  2c0f3f:	85 c0                	test   %eax,%eax
  2c0f41:	75 1a                	jne    2c0f5d <printer_vprintf+0x826>
            len = strnlen(data, precision);
  2c0f43:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0f46:	48 63 d0             	movslq %eax,%rdx
  2c0f49:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c0f4d:	48 89 d6             	mov    %rdx,%rsi
  2c0f50:	48 89 c7             	mov    %rax,%rdi
  2c0f53:	e8 91 f5 ff ff       	call   2c04e9 <strnlen>
  2c0f58:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c0f5b:	eb 0f                	jmp    2c0f6c <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  2c0f5d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c0f61:	48 89 c7             	mov    %rax,%rdi
  2c0f64:	e8 4b f5 ff ff       	call   2c04b4 <strlen>
  2c0f69:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c0f6c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f6f:	83 e0 20             	and    $0x20,%eax
  2c0f72:	85 c0                	test   %eax,%eax
  2c0f74:	74 20                	je     2c0f96 <printer_vprintf+0x85f>
  2c0f76:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0f7a:	78 1a                	js     2c0f96 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  2c0f7c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0f7f:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c0f82:	7e 08                	jle    2c0f8c <printer_vprintf+0x855>
  2c0f84:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0f87:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c0f8a:	eb 05                	jmp    2c0f91 <printer_vprintf+0x85a>
  2c0f8c:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0f91:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c0f94:	eb 5c                	jmp    2c0ff2 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c0f96:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0f99:	83 e0 20             	and    $0x20,%eax
  2c0f9c:	85 c0                	test   %eax,%eax
  2c0f9e:	74 4b                	je     2c0feb <printer_vprintf+0x8b4>
  2c0fa0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0fa3:	83 e0 02             	and    $0x2,%eax
  2c0fa6:	85 c0                	test   %eax,%eax
  2c0fa8:	74 41                	je     2c0feb <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c0faa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c0fad:	83 e0 04             	and    $0x4,%eax
  2c0fb0:	85 c0                	test   %eax,%eax
  2c0fb2:	75 37                	jne    2c0feb <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  2c0fb4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c0fb8:	48 89 c7             	mov    %rax,%rdi
  2c0fbb:	e8 f4 f4 ff ff       	call   2c04b4 <strlen>
  2c0fc0:	89 c2                	mov    %eax,%edx
  2c0fc2:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c0fc5:	01 d0                	add    %edx,%eax
  2c0fc7:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c0fca:	7e 1f                	jle    2c0feb <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  2c0fcc:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c0fcf:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c0fd2:	89 c3                	mov    %eax,%ebx
  2c0fd4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c0fd8:	48 89 c7             	mov    %rax,%rdi
  2c0fdb:	e8 d4 f4 ff ff       	call   2c04b4 <strlen>
  2c0fe0:	89 c2                	mov    %eax,%edx
  2c0fe2:	89 d8                	mov    %ebx,%eax
  2c0fe4:	29 d0                	sub    %edx,%eax
  2c0fe6:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c0fe9:	eb 07                	jmp    2c0ff2 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  2c0feb:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c0ff2:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c0ff5:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c0ff8:	01 d0                	add    %edx,%eax
  2c0ffa:	48 63 d8             	movslq %eax,%rbx
  2c0ffd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1001:	48 89 c7             	mov    %rax,%rdi
  2c1004:	e8 ab f4 ff ff       	call   2c04b4 <strlen>
  2c1009:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c100d:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c1010:	29 d0                	sub    %edx,%eax
  2c1012:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1015:	eb 25                	jmp    2c103c <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  2c1017:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c101e:	48 8b 08             	mov    (%rax),%rcx
  2c1021:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1027:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c102e:	be 20 00 00 00       	mov    $0x20,%esi
  2c1033:	48 89 c7             	mov    %rax,%rdi
  2c1036:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1038:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c103c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c103f:	83 e0 04             	and    $0x4,%eax
  2c1042:	85 c0                	test   %eax,%eax
  2c1044:	75 36                	jne    2c107c <printer_vprintf+0x945>
  2c1046:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c104a:	7f cb                	jg     2c1017 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  2c104c:	eb 2e                	jmp    2c107c <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  2c104e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1055:	4c 8b 00             	mov    (%rax),%r8
  2c1058:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c105c:	0f b6 00             	movzbl (%rax),%eax
  2c105f:	0f b6 c8             	movzbl %al,%ecx
  2c1062:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1068:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c106f:	89 ce                	mov    %ecx,%esi
  2c1071:	48 89 c7             	mov    %rax,%rdi
  2c1074:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1077:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c107c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1080:	0f b6 00             	movzbl (%rax),%eax
  2c1083:	84 c0                	test   %al,%al
  2c1085:	75 c7                	jne    2c104e <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  2c1087:	eb 25                	jmp    2c10ae <printer_vprintf+0x977>
            p->putc(p, '0', color);
  2c1089:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1090:	48 8b 08             	mov    (%rax),%rcx
  2c1093:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1099:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c10a0:	be 30 00 00 00       	mov    $0x30,%esi
  2c10a5:	48 89 c7             	mov    %rax,%rdi
  2c10a8:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c10aa:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c10ae:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c10b2:	7f d5                	jg     2c1089 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  2c10b4:	eb 32                	jmp    2c10e8 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  2c10b6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c10bd:	4c 8b 00             	mov    (%rax),%r8
  2c10c0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c10c4:	0f b6 00             	movzbl (%rax),%eax
  2c10c7:	0f b6 c8             	movzbl %al,%ecx
  2c10ca:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c10d0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c10d7:	89 ce                	mov    %ecx,%esi
  2c10d9:	48 89 c7             	mov    %rax,%rdi
  2c10dc:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c10df:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c10e4:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c10e8:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c10ec:	7f c8                	jg     2c10b6 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  2c10ee:	eb 25                	jmp    2c1115 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  2c10f0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c10f7:	48 8b 08             	mov    (%rax),%rcx
  2c10fa:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1100:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1107:	be 20 00 00 00       	mov    $0x20,%esi
  2c110c:	48 89 c7             	mov    %rax,%rdi
  2c110f:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c1111:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1115:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1119:	7f d5                	jg     2c10f0 <printer_vprintf+0x9b9>
        }
    done: ;
  2c111b:	90                   	nop
    for (; *format; ++format) {
  2c111c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1123:	01 
  2c1124:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c112b:	0f b6 00             	movzbl (%rax),%eax
  2c112e:	84 c0                	test   %al,%al
  2c1130:	0f 85 31 f6 ff ff    	jne    2c0767 <printer_vprintf+0x30>
    }
}
  2c1136:	90                   	nop
  2c1137:	90                   	nop
  2c1138:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c113c:	c9                   	leave  
  2c113d:	c3                   	ret    

00000000002c113e <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c113e:	f3 0f 1e fa          	endbr64 
  2c1142:	55                   	push   %rbp
  2c1143:	48 89 e5             	mov    %rsp,%rbp
  2c1146:	48 83 ec 20          	sub    $0x20,%rsp
  2c114a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c114e:	89 f0                	mov    %esi,%eax
  2c1150:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1153:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1156:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c115a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c115e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1162:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1166:	48 8d 15 33 7e df ff 	lea    -0x2081cd(%rip),%rdx        # b8fa0 <console+0xfa0>
  2c116d:	48 39 d0             	cmp    %rdx,%rax
  2c1170:	72 0f                	jb     2c1181 <console_putc+0x43>
        cp->cursor = console;
  2c1172:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1176:	48 8d 15 83 6e df ff 	lea    -0x20917d(%rip),%rdx        # b8000 <console>
  2c117d:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  2c1181:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c1185:	0f 85 82 00 00 00    	jne    2c120d <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  2c118b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c118f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1193:	48 8d 15 66 6e df ff 	lea    -0x20919a(%rip),%rdx        # b8000 <console>
  2c119a:	48 29 d0             	sub    %rdx,%rax
  2c119d:	48 d1 f8             	sar    %rax
  2c11a0:	48 89 c1             	mov    %rax,%rcx
  2c11a3:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c11aa:	66 66 66 
  2c11ad:	48 89 c8             	mov    %rcx,%rax
  2c11b0:	48 f7 ea             	imul   %rdx
  2c11b3:	48 89 d0             	mov    %rdx,%rax
  2c11b6:	48 c1 f8 05          	sar    $0x5,%rax
  2c11ba:	48 89 ce             	mov    %rcx,%rsi
  2c11bd:	48 c1 fe 3f          	sar    $0x3f,%rsi
  2c11c1:	48 29 f0             	sub    %rsi,%rax
  2c11c4:	48 89 c2             	mov    %rax,%rdx
  2c11c7:	48 89 d0             	mov    %rdx,%rax
  2c11ca:	48 c1 e0 02          	shl    $0x2,%rax
  2c11ce:	48 01 d0             	add    %rdx,%rax
  2c11d1:	48 c1 e0 04          	shl    $0x4,%rax
  2c11d5:	48 29 c1             	sub    %rax,%rcx
  2c11d8:	48 89 ca             	mov    %rcx,%rdx
  2c11db:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c11de:	eb 25                	jmp    2c1205 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  2c11e0:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c11e3:	83 c8 20             	or     $0x20,%eax
  2c11e6:	89 c6                	mov    %eax,%esi
  2c11e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c11ec:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c11f0:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c11f4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c11f8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c11fc:	89 f2                	mov    %esi,%edx
  2c11fe:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c1201:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1205:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c1209:	75 d5                	jne    2c11e0 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c120b:	eb 24                	jmp    2c1231 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  2c120d:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1211:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1214:	89 d6                	mov    %edx,%esi
  2c1216:	09 c6                	or     %eax,%esi
  2c1218:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c121c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1220:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1224:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1228:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c122c:	89 f2                	mov    %esi,%edx
  2c122e:	66 89 10             	mov    %dx,(%rax)
}
  2c1231:	90                   	nop
  2c1232:	c9                   	leave  
  2c1233:	c3                   	ret    

00000000002c1234 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c1234:	f3 0f 1e fa          	endbr64 
  2c1238:	55                   	push   %rbp
  2c1239:	48 89 e5             	mov    %rsp,%rbp
  2c123c:	48 83 ec 30          	sub    $0x30,%rsp
  2c1240:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c1243:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1246:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c124a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c124e:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 2c113e <console_putc>
  2c1255:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1259:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c125d:	78 09                	js     2c1268 <console_vprintf+0x34>
  2c125f:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1266:	7e 07                	jle    2c126f <console_vprintf+0x3b>
        cpos = 0;
  2c1268:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c126f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1272:	48 98                	cltq   
  2c1274:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c1278:	48 8d 05 81 6d df ff 	lea    -0x20927f(%rip),%rax        # b8000 <console>
  2c127f:	48 01 d0             	add    %rdx,%rax
  2c1282:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1286:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c128a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c128e:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c1291:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1295:	48 89 c7             	mov    %rax,%rdi
  2c1298:	e8 9a f4 ff ff       	call   2c0737 <printer_vprintf>
    return cp.cursor - console;
  2c129d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c12a1:	48 8d 15 58 6d df ff 	lea    -0x2092a8(%rip),%rdx        # b8000 <console>
  2c12a8:	48 29 d0             	sub    %rdx,%rax
  2c12ab:	48 d1 f8             	sar    %rax
}
  2c12ae:	c9                   	leave  
  2c12af:	c3                   	ret    

00000000002c12b0 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c12b0:	f3 0f 1e fa          	endbr64 
  2c12b4:	55                   	push   %rbp
  2c12b5:	48 89 e5             	mov    %rsp,%rbp
  2c12b8:	48 83 ec 60          	sub    $0x60,%rsp
  2c12bc:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c12bf:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c12c2:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c12c6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c12ca:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c12ce:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c12d2:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c12d9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c12dd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c12e1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c12e5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c12e9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c12ed:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c12f1:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c12f4:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c12f7:	89 c7                	mov    %eax,%edi
  2c12f9:	e8 36 ff ff ff       	call   2c1234 <console_vprintf>
  2c12fe:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c1301:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c1304:	c9                   	leave  
  2c1305:	c3                   	ret    

00000000002c1306 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c1306:	f3 0f 1e fa          	endbr64 
  2c130a:	55                   	push   %rbp
  2c130b:	48 89 e5             	mov    %rsp,%rbp
  2c130e:	48 83 ec 20          	sub    $0x20,%rsp
  2c1312:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1316:	89 f0                	mov    %esi,%eax
  2c1318:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c131b:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c131e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1322:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c1326:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c132a:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c132e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1332:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c1336:	48 39 c2             	cmp    %rax,%rdx
  2c1339:	73 1a                	jae    2c1355 <string_putc+0x4f>
        *sp->s++ = c;
  2c133b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c133f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1343:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c1347:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c134b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c134f:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1353:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1355:	90                   	nop
  2c1356:	c9                   	leave  
  2c1357:	c3                   	ret    

00000000002c1358 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1358:	f3 0f 1e fa          	endbr64 
  2c135c:	55                   	push   %rbp
  2c135d:	48 89 e5             	mov    %rsp,%rbp
  2c1360:	48 83 ec 40          	sub    $0x40,%rsp
  2c1364:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1368:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c136c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1370:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1374:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 2c1306 <string_putc>
  2c137b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  2c137f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1383:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1387:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c138c:	74 33                	je     2c13c1 <vsnprintf+0x69>
        sp.end = s + size - 1;
  2c138e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1392:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c1396:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c139a:	48 01 d0             	add    %rdx,%rax
  2c139d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c13a1:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c13a5:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c13a9:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c13ad:	be 00 00 00 00       	mov    $0x0,%esi
  2c13b2:	48 89 c7             	mov    %rax,%rdi
  2c13b5:	e8 7d f3 ff ff       	call   2c0737 <printer_vprintf>
        *sp.s = 0;
  2c13ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c13be:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c13c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c13c5:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c13c9:	c9                   	leave  
  2c13ca:	c3                   	ret    

00000000002c13cb <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c13cb:	f3 0f 1e fa          	endbr64 
  2c13cf:	55                   	push   %rbp
  2c13d0:	48 89 e5             	mov    %rsp,%rbp
  2c13d3:	48 83 ec 70          	sub    $0x70,%rsp
  2c13d7:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c13db:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c13df:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c13e3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c13e7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c13eb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c13ef:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c13f6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c13fa:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c13fe:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1402:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1406:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c140a:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c140e:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c1412:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1416:	48 89 c7             	mov    %rax,%rdi
  2c1419:	e8 3a ff ff ff       	call   2c1358 <vsnprintf>
  2c141e:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c1421:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1424:	c9                   	leave  
  2c1425:	c3                   	ret    

00000000002c1426 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1426:	f3 0f 1e fa          	endbr64 
  2c142a:	55                   	push   %rbp
  2c142b:	48 89 e5             	mov    %rsp,%rbp
  2c142e:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1432:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1439:	eb 1a                	jmp    2c1455 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  2c143b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c143e:	48 98                	cltq   
  2c1440:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c1444:	48 8d 05 b5 6b df ff 	lea    -0x20944b(%rip),%rax        # b8000 <console>
  2c144b:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1451:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1455:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c145c:	7e dd                	jle    2c143b <console_clear+0x15>
    }
    cursorpos = 0;
  2c145e:	c7 05 94 7b df ff 00 	movl   $0x0,-0x20846c(%rip)        # b8ffc <cursorpos>
  2c1465:	00 00 00 
}
  2c1468:	90                   	nop
  2c1469:	c9                   	leave  
  2c146a:	c3                   	ret    
