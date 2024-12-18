
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
  2c001a:	e8 05 0b 00 00       	call   2c0b24 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001f:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0024:	e8 ec 04 00 00       	call   2c0515 <malloc>
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
  2c0043:	e8 73 05 00 00       	call   2c05bb <realloc>
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
  2c006b:	e8 14 05 00 00       	call   2c0584 <calloc>
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
  2c008a:	e8 07 06 00 00       	call   2c0696 <heap_info>
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
  2c00bb:	48 8d 15 4e 18 00 00 	lea    0x184e(%rip),%rdx        # 2c1910 <console_clear+0x4c>
  2c00c2:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c7:	48 8d 3d 50 18 00 00 	lea    0x1850(%rip),%rdi        # 2c191e <console_clear+0x5a>
  2c00ce:	e8 31 02 00 00       	call   2c0304 <assert_fail>
	assert(array2[i] == 0);
  2c00d3:	48 8d 15 5a 18 00 00 	lea    0x185a(%rip),%rdx        # 2c1934 <console_clear+0x70>
  2c00da:	be 21 00 00 00       	mov    $0x21,%esi
  2c00df:	48 8d 3d 38 18 00 00 	lea    0x1838(%rip),%rdi        # 2c191e <console_clear+0x5a>
  2c00e6:	e8 19 02 00 00       	call   2c0304 <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00eb:	48 8d 15 66 18 00 00 	lea    0x1866(%rip),%rdx        # 2c1958 <console_clear+0x94>
  2c00f2:	be 28 00 00 00       	mov    $0x28,%esi
  2c00f7:	48 8d 3d 20 18 00 00 	lea    0x1820(%rip),%rdi        # 2c191e <console_clear+0x5a>
  2c00fe:	e8 01 02 00 00       	call   2c0304 <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c0103:	48 8d 35 39 18 00 00 	lea    0x1839(%rip),%rsi        # 2c1943 <console_clear+0x7f>
  2c010a:	bf 00 00 00 00       	mov    $0x0,%edi
  2c010f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0114:	e8 7b 00 00 00       	call   2c0194 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0119:	4c 89 ef             	mov    %r13,%rdi
  2c011c:	e8 ba 03 00 00       	call   2c04db <free>
    free(array2);
  2c0121:	4c 89 f7             	mov    %r14,%rdi
  2c0124:	e8 b2 03 00 00       	call   2c04db <free>

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
  2c0142:	e8 ce 03 00 00       	call   2c0515 <malloc>
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
  2c017c:	48 8d 35 05 18 00 00 	lea    0x1805(%rip),%rsi        # 2c1988 <console_clear+0xc4>
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
  2c01e0:	48 8d 05 06 18 00 00 	lea    0x1806(%rip),%rax        # 2c19ed <col.0>
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
  2c0212:	e8 bb 14 00 00       	call   2c16d2 <console_vprintf>
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
  2c0276:	48 8d 35 3b 17 00 00 	lea    0x173b(%rip),%rsi        # 2c19b8 <console_clear+0xf4>
  2c027d:	e8 87 05 00 00       	call   2c0809 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0282:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0286:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c028d:	48 89 da             	mov    %rbx,%rdx
  2c0290:	be 99 00 00 00       	mov    $0x99,%esi
  2c0295:	e8 5c 15 00 00       	call   2c17f6 <vsnprintf>
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
  2c02ba:	48 8d 15 ff 16 00 00 	lea    0x16ff(%rip),%rdx        # 2c19c0 <console_clear+0xfc>
  2c02c1:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02c6:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02cb:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02d0:	e8 79 14 00 00       	call   2c174e <console_printf>
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
  2c02f6:	48 8d 35 56 16 00 00 	lea    0x1656(%rip),%rsi        # 2c1953 <console_clear+0x8f>
  2c02fd:	e8 c8 06 00 00       	call   2c09ca <strcpy>
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
  2c0315:	48 8d 15 ac 16 00 00 	lea    0x16ac(%rip),%rdx        # 2c19c8 <console_clear+0x104>
  2c031c:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0321:	bf 30 07 00 00       	mov    $0x730,%edi
  2c0326:	b8 00 00 00 00       	mov    $0x0,%eax
  2c032b:	e8 1e 14 00 00       	call   2c174e <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0330:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0335:	cd 30                	int    $0x30
 loop: goto loop;
  2c0337:	eb fe                	jmp    2c0337 <assert_fail+0x33>

00000000002c0339 <algn>:
void add_to_free_list(block *b);
void remove_from_free_list(block *b);
void add_to_malloc_list(block *b);
void remove_from_malloclist(block *b);

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
  2c034d:	48 8d 7f 18          	lea    0x18(%rdi),%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c0351:	cd 3a                	int    $0x3a
  2c0353:	48 89 05 ae 1c 00 00 	mov    %rax,0x1cae(%rip)        # 2c2008 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  2c035a:	48 89 c1             	mov    %rax,%rcx
    if (bptr == (void*) -1) {
  2c035d:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c0361:	74 16                	je     2c0379 <new_block+0x33>
        return NULL;
    }
    block* nblock = (block*)bptr;
    nblock->size = size;
  2c0363:	48 89 10             	mov    %rdx,(%rax)
    nblock->free = 0;
  2c0366:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
    nblock->next = NULL;
  2c036d:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c0374:	00 
    return nblock;
}
  2c0375:	48 89 c8             	mov    %rcx,%rax
  2c0378:	c3                   	ret    
        return NULL;
  2c0379:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c037e:	eb f5                	jmp    2c0375 <new_block+0x2f>

00000000002c0380 <find_block>:

block* find_block(size_t size) {
  2c0380:	f3 0f 1e fa          	endbr64 
    block* curr = free_head;
  2c0384:	48 8b 05 8d 1c 00 00 	mov    0x1c8d(%rip),%rax        # 2c2018 <free_head>
    while (curr) {
  2c038b:	48 85 c0             	test   %rax,%rax
  2c038e:	74 0e                	je     2c039e <find_block+0x1e>
        if (curr->size >= size) {
  2c0390:	48 39 38             	cmp    %rdi,(%rax)
  2c0393:	73 09                	jae    2c039e <find_block+0x1e>
            return curr;
        }
        curr = curr->next;
  2c0395:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (curr) {
  2c0399:	48 85 c0             	test   %rax,%rax
  2c039c:	75 f2                	jne    2c0390 <find_block+0x10>
    }
    return NULL;
}
  2c039e:	c3                   	ret    

00000000002c039f <add_to_free_list>:
    b->size = size;
    add_to_free_list(new);
    return new;
}

void add_to_free_list(block *b) {
  2c039f:	f3 0f 1e fa          	endbr64 
    // insert in order of address
    if (!free_head) {
  2c03a3:	48 8b 05 6e 1c 00 00 	mov    0x1c6e(%rip),%rax        # 2c2018 <free_head>
  2c03aa:	48 85 c0             	test   %rax,%rax
  2c03ad:	74 1f                	je     2c03ce <add_to_free_list+0x2f>
        free_head = b;
        return;
    }
    if (b < free_head) {
  2c03af:	48 39 f8             	cmp    %rdi,%rax
  2c03b2:	77 22                	ja     2c03d6 <add_to_free_list+0x37>
        b->next = free_head;
        free_head = b;
        return;
    }
    block *curr = free_head;
    while (curr->next && curr->next < b) {
  2c03b4:	48 89 c2             	mov    %rax,%rdx
  2c03b7:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c03bb:	48 39 f8             	cmp    %rdi,%rax
  2c03be:	73 05                	jae    2c03c5 <add_to_free_list+0x26>
  2c03c0:	48 85 c0             	test   %rax,%rax
  2c03c3:	75 ef                	jne    2c03b4 <add_to_free_list+0x15>
        curr = curr->next;
    }
    b->next = curr->next;
  2c03c5:	48 89 47 08          	mov    %rax,0x8(%rdi)
    curr->next = b;
  2c03c9:	48 89 7a 08          	mov    %rdi,0x8(%rdx)



}
  2c03cd:	c3                   	ret    
        free_head = b;
  2c03ce:	48 89 3d 43 1c 00 00 	mov    %rdi,0x1c43(%rip)        # 2c2018 <free_head>
        return;
  2c03d5:	c3                   	ret    
        b->next = free_head;
  2c03d6:	48 89 47 08          	mov    %rax,0x8(%rdi)
        free_head = b;
  2c03da:	48 89 3d 37 1c 00 00 	mov    %rdi,0x1c37(%rip)        # 2c2018 <free_head>
        return;
  2c03e1:	c3                   	ret    

00000000002c03e2 <split_block>:
block* split_block(block* b, size_t size){
  2c03e2:	f3 0f 1e fa          	endbr64 
  2c03e6:	55                   	push   %rbp
  2c03e7:	48 89 e5             	mov    %rsp,%rbp
  2c03ea:	53                   	push   %rbx
  2c03eb:	48 83 ec 08          	sub    $0x8,%rsp
    if (b->size < size + BLOCKSIZE) {
  2c03ef:	48 8b 07             	mov    (%rdi),%rax
  2c03f2:	48 8d 56 18          	lea    0x18(%rsi),%rdx
        return NULL;
  2c03f6:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (b->size < size + BLOCKSIZE) {
  2c03fb:	48 39 d0             	cmp    %rdx,%rax
  2c03fe:	72 28                	jb     2c0428 <split_block+0x46>
    void* nptr = (void*)b + BLOCKSIZE + size;
  2c0400:	48 8d 1c 17          	lea    (%rdi,%rdx,1),%rbx
    new->size = b->size - size - BLOCKSIZE;
  2c0404:	48 29 f0             	sub    %rsi,%rax
  2c0407:	48 8d 40 e8          	lea    -0x18(%rax),%rax
  2c040b:	48 89 03             	mov    %rax,(%rbx)
    new->free = 1;
  2c040e:	c7 43 10 01 00 00 00 	movl   $0x1,0x10(%rbx)
    new->next = NULL;
  2c0415:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  2c041c:	00 
    b->size = size;
  2c041d:	48 89 37             	mov    %rsi,(%rdi)
    add_to_free_list(new);
  2c0420:	48 89 df             	mov    %rbx,%rdi
  2c0423:	e8 77 ff ff ff       	call   2c039f <add_to_free_list>
}
  2c0428:	48 89 d8             	mov    %rbx,%rax
  2c042b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c042f:	c9                   	leave  
  2c0430:	c3                   	ret    

00000000002c0431 <remove_from_free_list>:

void remove_from_free_list(block *b) {
  2c0431:	f3 0f 1e fa          	endbr64 
    if (free_head == b) {
  2c0435:	48 8b 05 dc 1b 00 00 	mov    0x1bdc(%rip),%rax        # 2c2018 <free_head>
  2c043c:	48 39 f8             	cmp    %rdi,%rax
  2c043f:	75 10                	jne    2c0451 <remove_from_free_list+0x20>
        free_head = b->next;
  2c0441:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0445:	48 89 05 cc 1b 00 00 	mov    %rax,0x1bcc(%rip)        # 2c2018 <free_head>
  2c044c:	eb 19                	jmp    2c0467 <remove_from_free_list+0x36>
    } else {
        block *curr = free_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  2c044e:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  2c0451:	48 85 c0             	test   %rax,%rax
  2c0454:	74 11                	je     2c0467 <remove_from_free_list+0x36>
  2c0456:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c045a:	48 39 fa             	cmp    %rdi,%rdx
  2c045d:	75 ef                	jne    2c044e <remove_from_free_list+0x1d>
        }
        if (curr) {
            curr->next = b->next;
  2c045f:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c0463:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 0;
  2c0467:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = NULL;
  2c046e:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c0475:	00 
}
  2c0476:	c3                   	ret    

00000000002c0477 <add_to_malloc_list>:
void add_to_malloc_list(block *b) {
  2c0477:	f3 0f 1e fa          	endbr64 
    b->free = 0; // Mark as allocated
  2c047b:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = malloc_head;
  2c0482:	48 8b 05 87 1b 00 00 	mov    0x1b87(%rip),%rax        # 2c2010 <malloc_head>
  2c0489:	48 89 47 08          	mov    %rax,0x8(%rdi)
    malloc_head = b; // Add to the malloc list
  2c048d:	48 89 3d 7c 1b 00 00 	mov    %rdi,0x1b7c(%rip)        # 2c2010 <malloc_head>
}
  2c0494:	c3                   	ret    

00000000002c0495 <remove_from_malloc_list>:

void remove_from_malloc_list(block *b) {
  2c0495:	f3 0f 1e fa          	endbr64 
    if (malloc_head == b) {
  2c0499:	48 8b 05 70 1b 00 00 	mov    0x1b70(%rip),%rax        # 2c2010 <malloc_head>
  2c04a0:	48 39 f8             	cmp    %rdi,%rax
  2c04a3:	75 10                	jne    2c04b5 <remove_from_malloc_list+0x20>
        malloc_head = b->next; // Remove from the head of the malloc list
  2c04a5:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c04a9:	48 89 05 60 1b 00 00 	mov    %rax,0x1b60(%rip)        # 2c2010 <malloc_head>
  2c04b0:	eb 19                	jmp    2c04cb <remove_from_malloc_list+0x36>
    } else {
        block *curr = malloc_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  2c04b2:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  2c04b5:	48 85 c0             	test   %rax,%rax
  2c04b8:	74 11                	je     2c04cb <remove_from_malloc_list+0x36>
  2c04ba:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c04be:	48 39 fa             	cmp    %rdi,%rdx
  2c04c1:	75 ef                	jne    2c04b2 <remove_from_malloc_list+0x1d>
        }
        if (curr) {
            curr->next = b->next; 
  2c04c3:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c04c7:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 1; // Mark as free
  2c04cb:	c7 47 10 01 00 00 00 	movl   $0x1,0x10(%rdi)
    b->next = NULL; 
  2c04d2:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c04d9:	00 
}
  2c04da:	c3                   	ret    

00000000002c04db <free>:

void free(void *firstbyte) {
  2c04db:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  2c04df:	48 85 ff             	test   %rdi,%rdi
  2c04e2:	74 06                	je     2c04ea <free+0xf>
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; // Prevent double-free
  2c04e4:	83 7f f8 00          	cmpl   $0x0,-0x8(%rdi)
  2c04e8:	74 01                	je     2c04eb <free+0x10>
  2c04ea:	c3                   	ret    
void free(void *firstbyte) {
  2c04eb:	55                   	push   %rbp
  2c04ec:	48 89 e5             	mov    %rsp,%rbp
  2c04ef:	53                   	push   %rbx
  2c04f0:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
  2c04f4:	48 8d 5f e8          	lea    -0x18(%rdi),%rbx
    num_allocs--;
  2c04f8:	83 2d 01 1b 00 00 01 	subl   $0x1,0x1b01(%rip)        # 2c2000 <num_allocs>
    remove_from_malloc_list(b); // Remove from malloc list
  2c04ff:	48 89 df             	mov    %rbx,%rdi
  2c0502:	e8 8e ff ff ff       	call   2c0495 <remove_from_malloc_list>
    add_to_free_list(b);
  2c0507:	48 89 df             	mov    %rbx,%rdi
  2c050a:	e8 90 fe ff ff       	call   2c039f <add_to_free_list>
}
  2c050f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0513:	c9                   	leave  
  2c0514:	c3                   	ret    

00000000002c0515 <malloc>:

void *malloc(uint64_t numbytes) {
  2c0515:	f3 0f 1e fa          	endbr64 
  2c0519:	55                   	push   %rbp
  2c051a:	48 89 e5             	mov    %rsp,%rbp
  2c051d:	41 54                	push   %r12
  2c051f:	53                   	push   %rbx
    return (size + 7) / 8 * 8;
  2c0520:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  2c0524:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    size_t size = algn(numbytes);
    block *b = find_block(size);
  2c0528:	4c 89 e7             	mov    %r12,%rdi
  2c052b:	e8 50 fe ff ff       	call   2c0380 <find_block>
  2c0530:	48 89 c3             	mov    %rax,%rbx
    if (b == NULL) {
  2c0533:	48 85 c0             	test   %rax,%rax
  2c0536:	74 2d                	je     2c0565 <malloc+0x50>
        b = new_block(size);
        if (b == NULL) {
            return NULL;
        }
    }
        remove_from_free_list(b);
  2c0538:	48 89 df             	mov    %rbx,%rdi
  2c053b:	e8 f1 fe ff ff       	call   2c0431 <remove_from_free_list>
        if (b->size > size + BLOCKSIZE) {
  2c0540:	49 8d 44 24 18       	lea    0x18(%r12),%rax
  2c0545:	48 39 03             	cmp    %rax,(%rbx)
  2c0548:	77 2d                	ja     2c0577 <malloc+0x62>
            split_block(b, size);
        }
    add_to_malloc_list(b);
  2c054a:	48 89 df             	mov    %rbx,%rdi
  2c054d:	e8 25 ff ff ff       	call   2c0477 <add_to_malloc_list>
    num_allocs++;
  2c0552:	83 05 a7 1a 00 00 01 	addl   $0x1,0x1aa7(%rip)        # 2c2000 <num_allocs>
    return (void*)((void*)b + BLOCKSIZE);
  2c0559:	48 83 c3 18          	add    $0x18,%rbx
}
  2c055d:	48 89 d8             	mov    %rbx,%rax
  2c0560:	5b                   	pop    %rbx
  2c0561:	41 5c                	pop    %r12
  2c0563:	5d                   	pop    %rbp
  2c0564:	c3                   	ret    
        b = new_block(size);
  2c0565:	4c 89 e7             	mov    %r12,%rdi
  2c0568:	e8 d9 fd ff ff       	call   2c0346 <new_block>
  2c056d:	48 89 c3             	mov    %rax,%rbx
        if (b == NULL) {
  2c0570:	48 85 c0             	test   %rax,%rax
  2c0573:	75 c3                	jne    2c0538 <malloc+0x23>
  2c0575:	eb e6                	jmp    2c055d <malloc+0x48>
            split_block(b, size);
  2c0577:	4c 89 e6             	mov    %r12,%rsi
  2c057a:	48 89 df             	mov    %rbx,%rdi
  2c057d:	e8 60 fe ff ff       	call   2c03e2 <split_block>
  2c0582:	eb c6                	jmp    2c054a <malloc+0x35>

00000000002c0584 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  2c0584:	f3 0f 1e fa          	endbr64 
  2c0588:	55                   	push   %rbp
  2c0589:	48 89 e5             	mov    %rsp,%rbp
  2c058c:	41 54                	push   %r12
  2c058e:	53                   	push   %rbx
    uint64_t total = num * sz;
  2c058f:	48 0f af fe          	imul   %rsi,%rdi
  2c0593:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  2c0596:	e8 7a ff ff ff       	call   2c0515 <malloc>
  2c059b:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  2c059e:	48 85 c0             	test   %rax,%rax
  2c05a1:	74 10                	je     2c05b3 <calloc+0x2f>
        memset(ptr, 0, total);
  2c05a3:	4c 89 e2             	mov    %r12,%rdx
  2c05a6:	be 00 00 00 00       	mov    $0x0,%esi
  2c05ab:	48 89 c7             	mov    %rax,%rdi
  2c05ae:	e8 5c 03 00 00       	call   2c090f <memset>
    }
    return ptr;
}
  2c05b3:	48 89 d8             	mov    %rbx,%rax
  2c05b6:	5b                   	pop    %rbx
  2c05b7:	41 5c                	pop    %r12
  2c05b9:	5d                   	pop    %rbp
  2c05ba:	c3                   	ret    

00000000002c05bb <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c05bb:	f3 0f 1e fa          	endbr64 
  2c05bf:	55                   	push   %rbp
  2c05c0:	48 89 e5             	mov    %rsp,%rbp
  2c05c3:	41 54                	push   %r12
  2c05c5:	53                   	push   %rbx
  2c05c6:	48 89 fb             	mov    %rdi,%rbx
  2c05c9:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  2c05cc:	48 85 db             	test   %rbx,%rbx
  2c05cf:	74 2d                	je     2c05fe <realloc+0x43>
        return malloc(sz);
    }
    if (sz == 0) {
  2c05d1:	48 85 f6             	test   %rsi,%rsi
  2c05d4:	74 32                	je     2c0608 <realloc+0x4d>
    return (size + 7) / 8 * 8;
  2c05d6:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  2c05da:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi
        return NULL;
    }
    block *b = (block*)((void*)ptr - BLOCKSIZE);
    size_t aligned_size = algn(sz);

    if (b->size >= aligned_size) {
  2c05de:	48 8b 43 e8          	mov    -0x18(%rbx),%rax
  2c05e2:	48 39 f0             	cmp    %rsi,%rax
  2c05e5:	72 31                	jb     2c0618 <realloc+0x5d>
        if (b->size > aligned_size + BLOCKSIZE) {
  2c05e7:	48 8d 56 18          	lea    0x18(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr;
  2c05eb:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  2c05ee:	48 39 d0             	cmp    %rdx,%rax
  2c05f1:	76 49                	jbe    2c063c <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE);
  2c05f3:	48 8d 7b e8          	lea    -0x18(%rbx),%rdi
            split_block(b, aligned_size);
  2c05f7:	e8 e6 fd ff ff       	call   2c03e2 <split_block>
  2c05fc:	eb 3e                	jmp    2c063c <realloc+0x81>
        return malloc(sz);
  2c05fe:	e8 12 ff ff ff       	call   2c0515 <malloc>
  2c0603:	49 89 c4             	mov    %rax,%r12
  2c0606:	eb 34                	jmp    2c063c <realloc+0x81>
        free(ptr);
  2c0608:	48 89 df             	mov    %rbx,%rdi
  2c060b:	e8 cb fe ff ff       	call   2c04db <free>
        return NULL;
  2c0610:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0616:	eb 24                	jmp    2c063c <realloc+0x81>
    }

    void *new_ptr = malloc(sz);
  2c0618:	e8 f8 fe ff ff       	call   2c0515 <malloc>
  2c061d:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  2c0620:	48 85 c0             	test   %rax,%rax
  2c0623:	74 17                	je     2c063c <realloc+0x81>
        return NULL;
    }
    memcpy(new_ptr, ptr, b->size);
  2c0625:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  2c0629:	48 89 de             	mov    %rbx,%rsi
  2c062c:	48 89 c7             	mov    %rax,%rdi
  2c062f:	e8 d5 01 00 00       	call   2c0809 <memcpy>
    free(ptr);
  2c0634:	48 89 df             	mov    %rbx,%rdi
  2c0637:	e8 9f fe ff ff       	call   2c04db <free>
    return new_ptr;
}
  2c063c:	4c 89 e0             	mov    %r12,%rax
  2c063f:	5b                   	pop    %rbx
  2c0640:	41 5c                	pop    %r12
  2c0642:	5d                   	pop    %rbp
  2c0643:	c3                   	ret    

00000000002c0644 <defrag>:

void defrag() {
  2c0644:	f3 0f 1e fa          	endbr64 
  2c0648:	55                   	push   %rbp
  2c0649:	48 89 e5             	mov    %rsp,%rbp
  2c064c:	53                   	push   %rbx
  2c064d:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = free_head;
  2c0651:	48 8b 1d c0 19 00 00 	mov    0x19c0(%rip),%rbx        # 2c2018 <free_head>

    while (b && b->next) { // Ensure there are at least two blocks to compare
  2c0658:	48 85 db             	test   %rbx,%rbx
  2c065b:	74 33                	je     2c0690 <defrag+0x4c>
  2c065d:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
  2c0661:	48 85 ff             	test   %rdi,%rdi
  2c0664:	74 2a                	je     2c0690 <defrag+0x4c>
        block *next = b->next;

        // Check if b and next are adjacent
        if ((char *)b + b->size + BLOCKSIZE == (char *)next) {
  2c0666:	48 8b 03             	mov    (%rbx),%rax
  2c0669:	48 83 c0 18          	add    $0x18,%rax
  2c066d:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c0671:	48 39 d7             	cmp    %rdx,%rdi
  2c0674:	74 05                	je     2c067b <defrag+0x37>
    while (b && b->next) { // Ensure there are at least two blocks to compare
  2c0676:	48 89 fb             	mov    %rdi,%rbx
  2c0679:	eb dd                	jmp    2c0658 <defrag+0x14>
            // Coalesce next into b
            b->size += next->size + BLOCKSIZE;
  2c067b:	48 03 07             	add    (%rdi),%rax
  2c067e:	48 89 03             	mov    %rax,(%rbx)
            b->next = next->next; // Remove next from the free list
  2c0681:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0685:	48 89 43 08          	mov    %rax,0x8(%rbx)
            remove_from_free_list(next);
  2c0689:	e8 a3 fd ff ff       	call   2c0431 <remove_from_free_list>
  2c068e:	eb c8                	jmp    2c0658 <defrag+0x14>
        } else {
            // Move to the next block if no merge happens
            b = b->next;
        }
    }
}
  2c0690:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0694:	c9                   	leave  
  2c0695:	c3                   	ret    

00000000002c0696 <heap_info>:




int heap_info(heap_info_struct * info) {
  2c0696:	f3 0f 1e fa          	endbr64 
  2c069a:	55                   	push   %rbp
  2c069b:	48 89 e5             	mov    %rsp,%rbp
  2c069e:	41 54                	push   %r12
  2c06a0:	53                   	push   %rbx
  2c06a1:	49 89 fc             	mov    %rdi,%r12
    info->num_allocs = num_allocs;
  2c06a4:	8b 05 56 19 00 00    	mov    0x1956(%rip),%eax        # 2c2000 <num_allocs>
  2c06aa:	89 07                	mov    %eax,(%rdi)
    long *size_array = (long*)malloc((num_allocs) * sizeof(long));
  2c06ac:	48 98                	cltq   
  2c06ae:	48 8d 3c c5 00 00 00 	lea    0x0(,%rax,8),%rdi
  2c06b5:	00 
  2c06b6:	e8 5a fe ff ff       	call   2c0515 <malloc>
  2c06bb:	48 89 c3             	mov    %rax,%rbx
    void **ptr_array = (void**)malloc((num_allocs) * sizeof(void*));
  2c06be:	48 63 3d 3b 19 00 00 	movslq 0x193b(%rip),%rdi        # 2c2000 <num_allocs>
  2c06c5:	48 c1 e7 03          	shl    $0x3,%rdi
  2c06c9:	e8 47 fe ff ff       	call   2c0515 <malloc>

    if (!size_array || !ptr_array) {
  2c06ce:	48 85 db             	test   %rbx,%rbx
  2c06d1:	0f 84 2b 01 00 00    	je     2c0802 <heap_info+0x16c>
  2c06d7:	49 89 c0             	mov    %rax,%r8
  2c06da:	48 85 c0             	test   %rax,%rax
  2c06dd:	0f 84 1f 01 00 00    	je     2c0802 <heap_info+0x16c>
        return -1;
    }
    // calculate free space and largest free chunk including block size
    block *bf = free_head;
  2c06e3:	48 8b 05 2e 19 00 00 	mov    0x192e(%rip),%rax        # 2c2018 <free_head>
    size_t free_space = 0;
    size_t largest_free_chunk = 0;
    while (bf) {
  2c06ea:	48 85 c0             	test   %rax,%rax
  2c06ed:	74 72                	je     2c0761 <heap_info+0xcb>
    size_t largest_free_chunk = 0;
  2c06ef:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    size_t free_space = 0;
  2c06f5:	41 bb 00 00 00 00    	mov    $0x0,%r11d
        free_space += bf->size + BLOCKSIZE;
  2c06fb:	48 8b 10             	mov    (%rax),%rdx
  2c06fe:	4e 8d 5c 1a 18       	lea    0x18(%rdx,%r11,1),%r11
        if (bf->size > largest_free_chunk) {
  2c0703:	49 39 d2             	cmp    %rdx,%r10
  2c0706:	4c 0f 42 d2          	cmovb  %rdx,%r10
            largest_free_chunk = bf->size;
        }
        bf = bf->next;
  2c070a:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bf) {
  2c070e:	48 85 c0             	test   %rax,%rax
  2c0711:	75 e8                	jne    2c06fb <heap_info+0x65>
    }

    block *bm = malloc_head->next->next;
  2c0713:	48 8b 05 f6 18 00 00 	mov    0x18f6(%rip),%rax        # 2c2010 <malloc_head>
  2c071a:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c071e:	48 8b 40 08          	mov    0x8(%rax),%rax
    int x = 0;
    while (bm) {
  2c0722:	48 85 c0             	test   %rax,%rax
  2c0725:	74 21                	je     2c0748 <heap_info+0xb2>
  2c0727:	ba 00 00 00 00       	mov    $0x0,%edx
        size_array[x] = bm->size;
  2c072c:	48 8b 08             	mov    (%rax),%rcx
  2c072f:	48 89 0c 13          	mov    %rcx,(%rbx,%rdx,1)
        ptr_array[x] = (void*)((void*)bm + BLOCKSIZE);
  2c0733:	48 8d 48 18          	lea    0x18(%rax),%rcx
  2c0737:	49 89 0c 10          	mov    %rcx,(%r8,%rdx,1)
        bm = bm->next;
  2c073b:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bm) {
  2c073f:	48 83 c2 08          	add    $0x8,%rdx
  2c0743:	48 85 c0             	test   %rax,%rax
  2c0746:	75 e4                	jne    2c072c <heap_info+0x96>
        x++;
    }
    // // sort size and poitner array by size in descending order
    for (int i = 0; i < num_allocs-2; i++) {
  2c0748:	8b 15 b2 18 00 00    	mov    0x18b2(%rip),%edx        # 2c2000 <num_allocs>
  2c074e:	83 fa 02             	cmp    $0x2,%edx
  2c0751:	7e 77                	jle    2c07ca <heap_info+0x134>
  2c0753:	48 89 de             	mov    %rbx,%rsi
  2c0756:	4c 89 c7             	mov    %r8,%rdi
  2c0759:	41 b9 01 00 00 00    	mov    $0x1,%r9d
  2c075f:	eb 56                	jmp    2c07b7 <heap_info+0x121>
    size_t largest_free_chunk = 0;
  2c0761:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    size_t free_space = 0;
  2c0767:	41 bb 00 00 00 00    	mov    $0x0,%r11d
  2c076d:	eb a4                	jmp    2c0713 <heap_info+0x7d>
        for (int j = i + 1; j < num_allocs-2; j++) {
  2c076f:	8b 15 8b 18 00 00    	mov    0x188b(%rip),%edx        # 2c2000 <num_allocs>
  2c0775:	8d 4a fe             	lea    -0x2(%rdx),%ecx
  2c0778:	48 83 c0 01          	add    $0x1,%rax
  2c077c:	39 c1                	cmp    %eax,%ecx
  2c077e:	7e 23                	jle    2c07a3 <heap_info+0x10d>
            if (size_array[i] < size_array[j]) {
  2c0780:	48 8b 16             	mov    (%rsi),%rdx
  2c0783:	48 8b 0c c3          	mov    (%rbx,%rax,8),%rcx
  2c0787:	48 39 ca             	cmp    %rcx,%rdx
  2c078a:	7d e3                	jge    2c076f <heap_info+0xd9>
                long temp = size_array[i];
                size_array[i] = size_array[j];
  2c078c:	48 89 0e             	mov    %rcx,(%rsi)
                size_array[j] = temp;
  2c078f:	48 89 14 c3          	mov    %rdx,(%rbx,%rax,8)
                void *temp_ptr = ptr_array[i];
  2c0793:	48 8b 17             	mov    (%rdi),%rdx
                ptr_array[i] = ptr_array[j];
  2c0796:	49 8b 0c c0          	mov    (%r8,%rax,8),%rcx
  2c079a:	48 89 0f             	mov    %rcx,(%rdi)
                ptr_array[j] = temp_ptr;
  2c079d:	49 89 14 c0          	mov    %rdx,(%r8,%rax,8)
  2c07a1:	eb cc                	jmp    2c076f <heap_info+0xd9>
    for (int i = 0; i < num_allocs-2; i++) {
  2c07a3:	49 83 c1 01          	add    $0x1,%r9
  2c07a7:	48 83 c6 08          	add    $0x8,%rsi
  2c07ab:	48 83 c7 08          	add    $0x8,%rdi
  2c07af:	41 8d 41 ff          	lea    -0x1(%r9),%eax
  2c07b3:	39 c1                	cmp    %eax,%ecx
  2c07b5:	7e 13                	jle    2c07ca <heap_info+0x134>
        for (int j = i + 1; j < num_allocs-2; j++) {
  2c07b7:	8b 15 43 18 00 00    	mov    0x1843(%rip),%edx        # 2c2000 <num_allocs>
  2c07bd:	8d 42 fe             	lea    -0x2(%rdx),%eax
  2c07c0:	44 39 c8             	cmp    %r9d,%eax
  2c07c3:	7e 05                	jle    2c07ca <heap_info+0x134>
  2c07c5:	4c 89 c8             	mov    %r9,%rax
  2c07c8:	eb b6                	jmp    2c0780 <heap_info+0xea>
            }
        }
    }

    if (num_allocs == 0) {
  2c07ca:	85 d2                	test   %edx,%edx
  2c07cc:	74 20                	je     2c07ee <heap_info+0x158>
        info->size_array = NULL;
        info->ptr_array = NULL;
        return 0;
    }else{
        info->size_array = size_array;
  2c07ce:	49 89 5c 24 08       	mov    %rbx,0x8(%r12)
        info->ptr_array = ptr_array;
  2c07d3:	4d 89 44 24 10       	mov    %r8,0x10(%r12)
    }
    info->free_space = (int)free_space;
  2c07d8:	45 89 5c 24 18       	mov    %r11d,0x18(%r12)
    info->largest_free_chunk = (int)largest_free_chunk;
  2c07dd:	45 89 54 24 1c       	mov    %r10d,0x1c(%r12)
    return 0;
  2c07e2:	ba 00 00 00 00       	mov    $0x0,%edx
  2c07e7:	89 d0                	mov    %edx,%eax
  2c07e9:	5b                   	pop    %rbx
  2c07ea:	41 5c                	pop    %r12
  2c07ec:	5d                   	pop    %rbp
  2c07ed:	c3                   	ret    
        info->size_array = NULL;
  2c07ee:	49 c7 44 24 08 00 00 	movq   $0x0,0x8(%r12)
  2c07f5:	00 00 
        info->ptr_array = NULL;
  2c07f7:	49 c7 44 24 10 00 00 	movq   $0x0,0x10(%r12)
  2c07fe:	00 00 
        return 0;
  2c0800:	eb e5                	jmp    2c07e7 <heap_info+0x151>
        return -1;
  2c0802:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  2c0807:	eb de                	jmp    2c07e7 <heap_info+0x151>

00000000002c0809 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0809:	f3 0f 1e fa          	endbr64 
  2c080d:	55                   	push   %rbp
  2c080e:	48 89 e5             	mov    %rsp,%rbp
  2c0811:	48 83 ec 28          	sub    $0x28,%rsp
  2c0815:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0819:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c081d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0821:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0825:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0829:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c082d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0831:	eb 1c                	jmp    2c084f <memcpy+0x46>
        *d = *s;
  2c0833:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0837:	0f b6 10             	movzbl (%rax),%edx
  2c083a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c083e:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0840:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0845:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c084a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c084f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0854:	75 dd                	jne    2c0833 <memcpy+0x2a>
    }
    return dst;
  2c0856:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c085a:	c9                   	leave  
  2c085b:	c3                   	ret    

00000000002c085c <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c085c:	f3 0f 1e fa          	endbr64 
  2c0860:	55                   	push   %rbp
  2c0861:	48 89 e5             	mov    %rsp,%rbp
  2c0864:	48 83 ec 28          	sub    $0x28,%rsp
  2c0868:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c086c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0870:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0874:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0878:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c087c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0880:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0884:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0888:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c088c:	73 6a                	jae    2c08f8 <memmove+0x9c>
  2c088e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0892:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0896:	48 01 d0             	add    %rdx,%rax
  2c0899:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c089d:	73 59                	jae    2c08f8 <memmove+0x9c>
        s += n, d += n;
  2c089f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c08a3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c08a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c08ab:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c08af:	eb 17                	jmp    2c08c8 <memmove+0x6c>
            *--d = *--s;
  2c08b1:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c08b6:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c08bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08bf:	0f b6 10             	movzbl (%rax),%edx
  2c08c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c08c6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c08c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c08cc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c08d0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c08d4:	48 85 c0             	test   %rax,%rax
  2c08d7:	75 d8                	jne    2c08b1 <memmove+0x55>
    if (s < d && s + n > d) {
  2c08d9:	eb 2e                	jmp    2c0909 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c08db:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c08df:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c08e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c08e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c08eb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c08ef:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c08f3:	0f b6 12             	movzbl (%rdx),%edx
  2c08f6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c08f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c08fc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0900:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0904:	48 85 c0             	test   %rax,%rax
  2c0907:	75 d2                	jne    2c08db <memmove+0x7f>
        }
    }
    return dst;
  2c0909:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c090d:	c9                   	leave  
  2c090e:	c3                   	ret    

00000000002c090f <memset>:

void* memset(void* v, int c, size_t n) {
  2c090f:	f3 0f 1e fa          	endbr64 
  2c0913:	55                   	push   %rbp
  2c0914:	48 89 e5             	mov    %rsp,%rbp
  2c0917:	48 83 ec 28          	sub    $0x28,%rsp
  2c091b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c091f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0922:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0926:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c092a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c092e:	eb 15                	jmp    2c0945 <memset+0x36>
        *p = c;
  2c0930:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0933:	89 c2                	mov    %eax,%edx
  2c0935:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0939:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c093b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0940:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0945:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c094a:	75 e4                	jne    2c0930 <memset+0x21>
    }
    return v;
  2c094c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0950:	c9                   	leave  
  2c0951:	c3                   	ret    

00000000002c0952 <strlen>:

size_t strlen(const char* s) {
  2c0952:	f3 0f 1e fa          	endbr64 
  2c0956:	55                   	push   %rbp
  2c0957:	48 89 e5             	mov    %rsp,%rbp
  2c095a:	48 83 ec 18          	sub    $0x18,%rsp
  2c095e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0962:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0969:	00 
  2c096a:	eb 0a                	jmp    2c0976 <strlen+0x24>
        ++n;
  2c096c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0971:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0976:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c097a:	0f b6 00             	movzbl (%rax),%eax
  2c097d:	84 c0                	test   %al,%al
  2c097f:	75 eb                	jne    2c096c <strlen+0x1a>
    }
    return n;
  2c0981:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0985:	c9                   	leave  
  2c0986:	c3                   	ret    

00000000002c0987 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0987:	f3 0f 1e fa          	endbr64 
  2c098b:	55                   	push   %rbp
  2c098c:	48 89 e5             	mov    %rsp,%rbp
  2c098f:	48 83 ec 20          	sub    $0x20,%rsp
  2c0993:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0997:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c099b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c09a2:	00 
  2c09a3:	eb 0a                	jmp    2c09af <strnlen+0x28>
        ++n;
  2c09a5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c09aa:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c09af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09b3:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c09b7:	74 0b                	je     2c09c4 <strnlen+0x3d>
  2c09b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c09bd:	0f b6 00             	movzbl (%rax),%eax
  2c09c0:	84 c0                	test   %al,%al
  2c09c2:	75 e1                	jne    2c09a5 <strnlen+0x1e>
    }
    return n;
  2c09c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c09c8:	c9                   	leave  
  2c09c9:	c3                   	ret    

00000000002c09ca <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c09ca:	f3 0f 1e fa          	endbr64 
  2c09ce:	55                   	push   %rbp
  2c09cf:	48 89 e5             	mov    %rsp,%rbp
  2c09d2:	48 83 ec 20          	sub    $0x20,%rsp
  2c09d6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c09da:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c09de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c09e2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c09e6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c09ea:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c09ee:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c09f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09f6:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c09fa:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c09fe:	0f b6 12             	movzbl (%rdx),%edx
  2c0a01:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0a03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a07:	48 83 e8 01          	sub    $0x1,%rax
  2c0a0b:	0f b6 00             	movzbl (%rax),%eax
  2c0a0e:	84 c0                	test   %al,%al
  2c0a10:	75 d4                	jne    2c09e6 <strcpy+0x1c>
    return dst;
  2c0a12:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0a16:	c9                   	leave  
  2c0a17:	c3                   	ret    

00000000002c0a18 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0a18:	f3 0f 1e fa          	endbr64 
  2c0a1c:	55                   	push   %rbp
  2c0a1d:	48 89 e5             	mov    %rsp,%rbp
  2c0a20:	48 83 ec 10          	sub    $0x10,%rsp
  2c0a24:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0a28:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0a2c:	eb 0a                	jmp    2c0a38 <strcmp+0x20>
        ++a, ++b;
  2c0a2e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0a33:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0a38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a3c:	0f b6 00             	movzbl (%rax),%eax
  2c0a3f:	84 c0                	test   %al,%al
  2c0a41:	74 1d                	je     2c0a60 <strcmp+0x48>
  2c0a43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0a47:	0f b6 00             	movzbl (%rax),%eax
  2c0a4a:	84 c0                	test   %al,%al
  2c0a4c:	74 12                	je     2c0a60 <strcmp+0x48>
  2c0a4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a52:	0f b6 10             	movzbl (%rax),%edx
  2c0a55:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0a59:	0f b6 00             	movzbl (%rax),%eax
  2c0a5c:	38 c2                	cmp    %al,%dl
  2c0a5e:	74 ce                	je     2c0a2e <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0a60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a64:	0f b6 00             	movzbl (%rax),%eax
  2c0a67:	89 c2                	mov    %eax,%edx
  2c0a69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0a6d:	0f b6 00             	movzbl (%rax),%eax
  2c0a70:	38 c2                	cmp    %al,%dl
  2c0a72:	0f 97 c0             	seta   %al
  2c0a75:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0a78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a7c:	0f b6 00             	movzbl (%rax),%eax
  2c0a7f:	89 c1                	mov    %eax,%ecx
  2c0a81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0a85:	0f b6 00             	movzbl (%rax),%eax
  2c0a88:	38 c1                	cmp    %al,%cl
  2c0a8a:	0f 92 c0             	setb   %al
  2c0a8d:	0f b6 c8             	movzbl %al,%ecx
  2c0a90:	89 d0                	mov    %edx,%eax
  2c0a92:	29 c8                	sub    %ecx,%eax
}
  2c0a94:	c9                   	leave  
  2c0a95:	c3                   	ret    

00000000002c0a96 <strchr>:

char* strchr(const char* s, int c) {
  2c0a96:	f3 0f 1e fa          	endbr64 
  2c0a9a:	55                   	push   %rbp
  2c0a9b:	48 89 e5             	mov    %rsp,%rbp
  2c0a9e:	48 83 ec 10          	sub    $0x10,%rsp
  2c0aa2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0aa6:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0aa9:	eb 05                	jmp    2c0ab0 <strchr+0x1a>
        ++s;
  2c0aab:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0ab0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ab4:	0f b6 00             	movzbl (%rax),%eax
  2c0ab7:	84 c0                	test   %al,%al
  2c0ab9:	74 0e                	je     2c0ac9 <strchr+0x33>
  2c0abb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0abf:	0f b6 00             	movzbl (%rax),%eax
  2c0ac2:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0ac5:	38 d0                	cmp    %dl,%al
  2c0ac7:	75 e2                	jne    2c0aab <strchr+0x15>
    }
    if (*s == (char) c) {
  2c0ac9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0acd:	0f b6 00             	movzbl (%rax),%eax
  2c0ad0:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0ad3:	38 d0                	cmp    %dl,%al
  2c0ad5:	75 06                	jne    2c0add <strchr+0x47>
        return (char*) s;
  2c0ad7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0adb:	eb 05                	jmp    2c0ae2 <strchr+0x4c>
    } else {
        return NULL;
  2c0add:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0ae2:	c9                   	leave  
  2c0ae3:	c3                   	ret    

00000000002c0ae4 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0ae4:	f3 0f 1e fa          	endbr64 
  2c0ae8:	55                   	push   %rbp
  2c0ae9:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0aec:	8b 05 2e 15 00 00    	mov    0x152e(%rip),%eax        # 2c2020 <rand_seed_set>
  2c0af2:	85 c0                	test   %eax,%eax
  2c0af4:	75 0a                	jne    2c0b00 <rand+0x1c>
        srand(819234718U);
  2c0af6:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0afb:	e8 24 00 00 00       	call   2c0b24 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0b00:	8b 05 1e 15 00 00    	mov    0x151e(%rip),%eax        # 2c2024 <rand_seed>
  2c0b06:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0b0c:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0b11:	89 05 0d 15 00 00    	mov    %eax,0x150d(%rip)        # 2c2024 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0b17:	8b 05 07 15 00 00    	mov    0x1507(%rip),%eax        # 2c2024 <rand_seed>
  2c0b1d:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0b22:	5d                   	pop    %rbp
  2c0b23:	c3                   	ret    

00000000002c0b24 <srand>:

void srand(unsigned seed) {
  2c0b24:	f3 0f 1e fa          	endbr64 
  2c0b28:	55                   	push   %rbp
  2c0b29:	48 89 e5             	mov    %rsp,%rbp
  2c0b2c:	48 83 ec 08          	sub    $0x8,%rsp
  2c0b30:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0b33:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0b36:	89 05 e8 14 00 00    	mov    %eax,0x14e8(%rip)        # 2c2024 <rand_seed>
    rand_seed_set = 1;
  2c0b3c:	c7 05 da 14 00 00 01 	movl   $0x1,0x14da(%rip)        # 2c2020 <rand_seed_set>
  2c0b43:	00 00 00 
}
  2c0b46:	90                   	nop
  2c0b47:	c9                   	leave  
  2c0b48:	c3                   	ret    

00000000002c0b49 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0b49:	f3 0f 1e fa          	endbr64 
  2c0b4d:	55                   	push   %rbp
  2c0b4e:	48 89 e5             	mov    %rsp,%rbp
  2c0b51:	48 83 ec 28          	sub    $0x28,%rsp
  2c0b55:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0b59:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0b5d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0b60:	48 8d 05 99 0f 00 00 	lea    0xf99(%rip),%rax        # 2c1b00 <upper_digits.1>
  2c0b67:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  2c0b6b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c0b6f:	79 0e                	jns    2c0b7f <fill_numbuf+0x36>
        digits = lower_digits;
  2c0b71:	48 8d 05 a8 0f 00 00 	lea    0xfa8(%rip),%rax        # 2c1b20 <lower_digits.0>
  2c0b78:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  2c0b7c:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c0b7f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0b84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0b88:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0b8b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0b8e:	48 63 c8             	movslq %eax,%rcx
  2c0b91:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0b95:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0b9a:	48 f7 f1             	div    %rcx
  2c0b9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ba1:	48 01 d0             	add    %rdx,%rax
  2c0ba4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0ba9:	0f b6 10             	movzbl (%rax),%edx
  2c0bac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0bb0:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0bb2:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0bb5:	48 63 f0             	movslq %eax,%rsi
  2c0bb8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0bbc:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0bc1:	48 f7 f6             	div    %rsi
  2c0bc4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0bc8:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0bcd:	75 bc                	jne    2c0b8b <fill_numbuf+0x42>
    return numbuf_end;
  2c0bcf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0bd3:	c9                   	leave  
  2c0bd4:	c3                   	ret    

00000000002c0bd5 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0bd5:	f3 0f 1e fa          	endbr64 
  2c0bd9:	55                   	push   %rbp
  2c0bda:	48 89 e5             	mov    %rsp,%rbp
  2c0bdd:	53                   	push   %rbx
  2c0bde:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0be5:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0bec:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0bf2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0bf9:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0c00:	e9 bd 09 00 00       	jmp    2c15c2 <printer_vprintf+0x9ed>
        if (*format != '%') {
  2c0c05:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c0c:	0f b6 00             	movzbl (%rax),%eax
  2c0c0f:	3c 25                	cmp    $0x25,%al
  2c0c11:	74 31                	je     2c0c44 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  2c0c13:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0c1a:	4c 8b 00             	mov    (%rax),%r8
  2c0c1d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c24:	0f b6 00             	movzbl (%rax),%eax
  2c0c27:	0f b6 c8             	movzbl %al,%ecx
  2c0c2a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0c30:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0c37:	89 ce                	mov    %ecx,%esi
  2c0c39:	48 89 c7             	mov    %rax,%rdi
  2c0c3c:	41 ff d0             	call   *%r8
            continue;
  2c0c3f:	e9 76 09 00 00       	jmp    2c15ba <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  2c0c44:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0c4b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0c52:	01 
  2c0c53:	eb 4d                	jmp    2c0ca2 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  2c0c55:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c5c:	0f b6 00             	movzbl (%rax),%eax
  2c0c5f:	0f be c0             	movsbl %al,%eax
  2c0c62:	89 c6                	mov    %eax,%esi
  2c0c64:	48 8d 05 95 0d 00 00 	lea    0xd95(%rip),%rax        # 2c1a00 <flag_chars>
  2c0c6b:	48 89 c7             	mov    %rax,%rdi
  2c0c6e:	e8 23 fe ff ff       	call   2c0a96 <strchr>
  2c0c73:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0c77:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0c7c:	74 34                	je     2c0cb2 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  2c0c7e:	48 8d 15 7b 0d 00 00 	lea    0xd7b(%rip),%rdx        # 2c1a00 <flag_chars>
  2c0c85:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0c89:	48 29 d0             	sub    %rdx,%rax
  2c0c8c:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0c91:	89 c1                	mov    %eax,%ecx
  2c0c93:	d3 e2                	shl    %cl,%edx
  2c0c95:	89 d0                	mov    %edx,%eax
  2c0c97:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0c9a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0ca1:	01 
  2c0ca2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ca9:	0f b6 00             	movzbl (%rax),%eax
  2c0cac:	84 c0                	test   %al,%al
  2c0cae:	75 a5                	jne    2c0c55 <printer_vprintf+0x80>
  2c0cb0:	eb 01                	jmp    2c0cb3 <printer_vprintf+0xde>
            } else {
                break;
  2c0cb2:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0cb3:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0cba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0cc1:	0f b6 00             	movzbl (%rax),%eax
  2c0cc4:	3c 30                	cmp    $0x30,%al
  2c0cc6:	7e 67                	jle    2c0d2f <printer_vprintf+0x15a>
  2c0cc8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ccf:	0f b6 00             	movzbl (%rax),%eax
  2c0cd2:	3c 39                	cmp    $0x39,%al
  2c0cd4:	7f 59                	jg     2c0d2f <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0cd6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0cdd:	eb 2e                	jmp    2c0d0d <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  2c0cdf:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0ce2:	89 d0                	mov    %edx,%eax
  2c0ce4:	c1 e0 02             	shl    $0x2,%eax
  2c0ce7:	01 d0                	add    %edx,%eax
  2c0ce9:	01 c0                	add    %eax,%eax
  2c0ceb:	89 c1                	mov    %eax,%ecx
  2c0ced:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0cf4:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0cf8:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0cff:	0f b6 00             	movzbl (%rax),%eax
  2c0d02:	0f be c0             	movsbl %al,%eax
  2c0d05:	01 c8                	add    %ecx,%eax
  2c0d07:	83 e8 30             	sub    $0x30,%eax
  2c0d0a:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0d0d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d14:	0f b6 00             	movzbl (%rax),%eax
  2c0d17:	3c 2f                	cmp    $0x2f,%al
  2c0d19:	0f 8e 85 00 00 00    	jle    2c0da4 <printer_vprintf+0x1cf>
  2c0d1f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d26:	0f b6 00             	movzbl (%rax),%eax
  2c0d29:	3c 39                	cmp    $0x39,%al
  2c0d2b:	7e b2                	jle    2c0cdf <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  2c0d2d:	eb 75                	jmp    2c0da4 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  2c0d2f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d36:	0f b6 00             	movzbl (%rax),%eax
  2c0d39:	3c 2a                	cmp    $0x2a,%al
  2c0d3b:	75 68                	jne    2c0da5 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  2c0d3d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d44:	8b 00                	mov    (%rax),%eax
  2c0d46:	83 f8 2f             	cmp    $0x2f,%eax
  2c0d49:	77 30                	ja     2c0d7b <printer_vprintf+0x1a6>
  2c0d4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d52:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0d56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d5d:	8b 00                	mov    (%rax),%eax
  2c0d5f:	89 c0                	mov    %eax,%eax
  2c0d61:	48 01 d0             	add    %rdx,%rax
  2c0d64:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d6b:	8b 12                	mov    (%rdx),%edx
  2c0d6d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0d70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d77:	89 0a                	mov    %ecx,(%rdx)
  2c0d79:	eb 1a                	jmp    2c0d95 <printer_vprintf+0x1c0>
  2c0d7b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0d82:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0d86:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0d8a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0d91:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0d95:	8b 00                	mov    (%rax),%eax
  2c0d97:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0d9a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0da1:	01 
  2c0da2:	eb 01                	jmp    2c0da5 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  2c0da4:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0da5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0dac:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0db3:	0f b6 00             	movzbl (%rax),%eax
  2c0db6:	3c 2e                	cmp    $0x2e,%al
  2c0db8:	0f 85 00 01 00 00    	jne    2c0ebe <printer_vprintf+0x2e9>
            ++format;
  2c0dbe:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0dc5:	01 
            if (*format >= '0' && *format <= '9') {
  2c0dc6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0dcd:	0f b6 00             	movzbl (%rax),%eax
  2c0dd0:	3c 2f                	cmp    $0x2f,%al
  2c0dd2:	7e 67                	jle    2c0e3b <printer_vprintf+0x266>
  2c0dd4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ddb:	0f b6 00             	movzbl (%rax),%eax
  2c0dde:	3c 39                	cmp    $0x39,%al
  2c0de0:	7f 59                	jg     2c0e3b <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0de2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0de9:	eb 2e                	jmp    2c0e19 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  2c0deb:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0dee:	89 d0                	mov    %edx,%eax
  2c0df0:	c1 e0 02             	shl    $0x2,%eax
  2c0df3:	01 d0                	add    %edx,%eax
  2c0df5:	01 c0                	add    %eax,%eax
  2c0df7:	89 c1                	mov    %eax,%ecx
  2c0df9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e00:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0e04:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0e0b:	0f b6 00             	movzbl (%rax),%eax
  2c0e0e:	0f be c0             	movsbl %al,%eax
  2c0e11:	01 c8                	add    %ecx,%eax
  2c0e13:	83 e8 30             	sub    $0x30,%eax
  2c0e16:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0e19:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e20:	0f b6 00             	movzbl (%rax),%eax
  2c0e23:	3c 2f                	cmp    $0x2f,%al
  2c0e25:	0f 8e 85 00 00 00    	jle    2c0eb0 <printer_vprintf+0x2db>
  2c0e2b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e32:	0f b6 00             	movzbl (%rax),%eax
  2c0e35:	3c 39                	cmp    $0x39,%al
  2c0e37:	7e b2                	jle    2c0deb <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  2c0e39:	eb 75                	jmp    2c0eb0 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  2c0e3b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e42:	0f b6 00             	movzbl (%rax),%eax
  2c0e45:	3c 2a                	cmp    $0x2a,%al
  2c0e47:	75 68                	jne    2c0eb1 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  2c0e49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e50:	8b 00                	mov    (%rax),%eax
  2c0e52:	83 f8 2f             	cmp    $0x2f,%eax
  2c0e55:	77 30                	ja     2c0e87 <printer_vprintf+0x2b2>
  2c0e57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e5e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0e62:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e69:	8b 00                	mov    (%rax),%eax
  2c0e6b:	89 c0                	mov    %eax,%eax
  2c0e6d:	48 01 d0             	add    %rdx,%rax
  2c0e70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e77:	8b 12                	mov    (%rdx),%edx
  2c0e79:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0e7c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e83:	89 0a                	mov    %ecx,(%rdx)
  2c0e85:	eb 1a                	jmp    2c0ea1 <printer_vprintf+0x2cc>
  2c0e87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e8e:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e92:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e96:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e9d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ea1:	8b 00                	mov    (%rax),%eax
  2c0ea3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0ea6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0ead:	01 
  2c0eae:	eb 01                	jmp    2c0eb1 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  2c0eb0:	90                   	nop
            }
            if (precision < 0) {
  2c0eb1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0eb5:	79 07                	jns    2c0ebe <printer_vprintf+0x2e9>
                precision = 0;
  2c0eb7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0ebe:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0ec5:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0ecc:	00 
        int length = 0;
  2c0ecd:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0ed4:	48 8d 05 2b 0b 00 00 	lea    0xb2b(%rip),%rax        # 2c1a06 <flag_chars+0x6>
  2c0edb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  2c0edf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ee6:	0f b6 00             	movzbl (%rax),%eax
  2c0ee9:	0f be c0             	movsbl %al,%eax
  2c0eec:	83 e8 43             	sub    $0x43,%eax
  2c0eef:	83 f8 37             	cmp    $0x37,%eax
  2c0ef2:	0f 87 b6 03 00 00    	ja     2c12ae <printer_vprintf+0x6d9>
  2c0ef8:	89 c0                	mov    %eax,%eax
  2c0efa:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  2c0f01:	00 
  2c0f02:	48 8d 05 0b 0b 00 00 	lea    0xb0b(%rip),%rax        # 2c1a14 <flag_chars+0x14>
  2c0f09:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  2c0f0c:	48 98                	cltq   
  2c0f0e:	48 8d 15 ff 0a 00 00 	lea    0xaff(%rip),%rdx        # 2c1a14 <flag_chars+0x14>
  2c0f15:	48 01 d0             	add    %rdx,%rax
  2c0f18:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0f1b:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0f22:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0f29:	01 
            goto again;
  2c0f2a:	eb b3                	jmp    2c0edf <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0f2c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0f30:	74 5d                	je     2c0f8f <printer_vprintf+0x3ba>
  2c0f32:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f39:	8b 00                	mov    (%rax),%eax
  2c0f3b:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f3e:	77 30                	ja     2c0f70 <printer_vprintf+0x39b>
  2c0f40:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f47:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0f4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f52:	8b 00                	mov    (%rax),%eax
  2c0f54:	89 c0                	mov    %eax,%eax
  2c0f56:	48 01 d0             	add    %rdx,%rax
  2c0f59:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f60:	8b 12                	mov    (%rdx),%edx
  2c0f62:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f65:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f6c:	89 0a                	mov    %ecx,(%rdx)
  2c0f6e:	eb 1a                	jmp    2c0f8a <printer_vprintf+0x3b5>
  2c0f70:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f77:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f7b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f7f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f86:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f8a:	48 8b 00             	mov    (%rax),%rax
  2c0f8d:	eb 5c                	jmp    2c0feb <printer_vprintf+0x416>
  2c0f8f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f96:	8b 00                	mov    (%rax),%eax
  2c0f98:	83 f8 2f             	cmp    $0x2f,%eax
  2c0f9b:	77 30                	ja     2c0fcd <printer_vprintf+0x3f8>
  2c0f9d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fa4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0fa8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0faf:	8b 00                	mov    (%rax),%eax
  2c0fb1:	89 c0                	mov    %eax,%eax
  2c0fb3:	48 01 d0             	add    %rdx,%rax
  2c0fb6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fbd:	8b 12                	mov    (%rdx),%edx
  2c0fbf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0fc2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fc9:	89 0a                	mov    %ecx,(%rdx)
  2c0fcb:	eb 1a                	jmp    2c0fe7 <printer_vprintf+0x412>
  2c0fcd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fd4:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0fd8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0fdc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fe3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0fe7:	8b 00                	mov    (%rax),%eax
  2c0fe9:	48 98                	cltq   
  2c0feb:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0fef:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0ff3:	48 c1 f8 38          	sar    $0x38,%rax
  2c0ff7:	25 80 00 00 00       	and    $0x80,%eax
  2c0ffc:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c0fff:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c1003:	74 09                	je     2c100e <printer_vprintf+0x439>
  2c1005:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1009:	48 f7 d8             	neg    %rax
  2c100c:	eb 04                	jmp    2c1012 <printer_vprintf+0x43d>
  2c100e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1012:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c1016:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c1019:	83 c8 60             	or     $0x60,%eax
  2c101c:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c101f:	e9 cf 02 00 00       	jmp    2c12f3 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c1024:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c1028:	74 5d                	je     2c1087 <printer_vprintf+0x4b2>
  2c102a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1031:	8b 00                	mov    (%rax),%eax
  2c1033:	83 f8 2f             	cmp    $0x2f,%eax
  2c1036:	77 30                	ja     2c1068 <printer_vprintf+0x493>
  2c1038:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c103f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1043:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c104a:	8b 00                	mov    (%rax),%eax
  2c104c:	89 c0                	mov    %eax,%eax
  2c104e:	48 01 d0             	add    %rdx,%rax
  2c1051:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1058:	8b 12                	mov    (%rdx),%edx
  2c105a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c105d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1064:	89 0a                	mov    %ecx,(%rdx)
  2c1066:	eb 1a                	jmp    2c1082 <printer_vprintf+0x4ad>
  2c1068:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c106f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1073:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1077:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c107e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1082:	48 8b 00             	mov    (%rax),%rax
  2c1085:	eb 5c                	jmp    2c10e3 <printer_vprintf+0x50e>
  2c1087:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c108e:	8b 00                	mov    (%rax),%eax
  2c1090:	83 f8 2f             	cmp    $0x2f,%eax
  2c1093:	77 30                	ja     2c10c5 <printer_vprintf+0x4f0>
  2c1095:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c109c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c10a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10a7:	8b 00                	mov    (%rax),%eax
  2c10a9:	89 c0                	mov    %eax,%eax
  2c10ab:	48 01 d0             	add    %rdx,%rax
  2c10ae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10b5:	8b 12                	mov    (%rdx),%edx
  2c10b7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c10ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10c1:	89 0a                	mov    %ecx,(%rdx)
  2c10c3:	eb 1a                	jmp    2c10df <printer_vprintf+0x50a>
  2c10c5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10cc:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c10d0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c10d4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10db:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c10df:	8b 00                	mov    (%rax),%eax
  2c10e1:	89 c0                	mov    %eax,%eax
  2c10e3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c10e7:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c10eb:	e9 03 02 00 00       	jmp    2c12f3 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  2c10f0:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c10f7:	e9 28 ff ff ff       	jmp    2c1024 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  2c10fc:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c1103:	e9 1c ff ff ff       	jmp    2c1024 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c1108:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c110f:	8b 00                	mov    (%rax),%eax
  2c1111:	83 f8 2f             	cmp    $0x2f,%eax
  2c1114:	77 30                	ja     2c1146 <printer_vprintf+0x571>
  2c1116:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c111d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1121:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1128:	8b 00                	mov    (%rax),%eax
  2c112a:	89 c0                	mov    %eax,%eax
  2c112c:	48 01 d0             	add    %rdx,%rax
  2c112f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1136:	8b 12                	mov    (%rdx),%edx
  2c1138:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c113b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1142:	89 0a                	mov    %ecx,(%rdx)
  2c1144:	eb 1a                	jmp    2c1160 <printer_vprintf+0x58b>
  2c1146:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c114d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1151:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1155:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c115c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1160:	48 8b 00             	mov    (%rax),%rax
  2c1163:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c1167:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c116e:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c1175:	e9 79 01 00 00       	jmp    2c12f3 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  2c117a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1181:	8b 00                	mov    (%rax),%eax
  2c1183:	83 f8 2f             	cmp    $0x2f,%eax
  2c1186:	77 30                	ja     2c11b8 <printer_vprintf+0x5e3>
  2c1188:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c118f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1193:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c119a:	8b 00                	mov    (%rax),%eax
  2c119c:	89 c0                	mov    %eax,%eax
  2c119e:	48 01 d0             	add    %rdx,%rax
  2c11a1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11a8:	8b 12                	mov    (%rdx),%edx
  2c11aa:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c11ad:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11b4:	89 0a                	mov    %ecx,(%rdx)
  2c11b6:	eb 1a                	jmp    2c11d2 <printer_vprintf+0x5fd>
  2c11b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11bf:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c11c3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c11c7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11ce:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c11d2:	48 8b 00             	mov    (%rax),%rax
  2c11d5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c11d9:	e9 15 01 00 00       	jmp    2c12f3 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  2c11de:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11e5:	8b 00                	mov    (%rax),%eax
  2c11e7:	83 f8 2f             	cmp    $0x2f,%eax
  2c11ea:	77 30                	ja     2c121c <printer_vprintf+0x647>
  2c11ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11f3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c11f7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11fe:	8b 00                	mov    (%rax),%eax
  2c1200:	89 c0                	mov    %eax,%eax
  2c1202:	48 01 d0             	add    %rdx,%rax
  2c1205:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c120c:	8b 12                	mov    (%rdx),%edx
  2c120e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1211:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1218:	89 0a                	mov    %ecx,(%rdx)
  2c121a:	eb 1a                	jmp    2c1236 <printer_vprintf+0x661>
  2c121c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1223:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1227:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c122b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1232:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1236:	8b 00                	mov    (%rax),%eax
  2c1238:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c123e:	e9 77 03 00 00       	jmp    2c15ba <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  2c1243:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1247:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c124b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1252:	8b 00                	mov    (%rax),%eax
  2c1254:	83 f8 2f             	cmp    $0x2f,%eax
  2c1257:	77 30                	ja     2c1289 <printer_vprintf+0x6b4>
  2c1259:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1260:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1264:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c126b:	8b 00                	mov    (%rax),%eax
  2c126d:	89 c0                	mov    %eax,%eax
  2c126f:	48 01 d0             	add    %rdx,%rax
  2c1272:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1279:	8b 12                	mov    (%rdx),%edx
  2c127b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c127e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1285:	89 0a                	mov    %ecx,(%rdx)
  2c1287:	eb 1a                	jmp    2c12a3 <printer_vprintf+0x6ce>
  2c1289:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1290:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1294:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1298:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c129f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c12a3:	8b 00                	mov    (%rax),%eax
  2c12a5:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c12a8:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c12ac:	eb 45                	jmp    2c12f3 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  2c12ae:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c12b2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c12b6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c12bd:	0f b6 00             	movzbl (%rax),%eax
  2c12c0:	84 c0                	test   %al,%al
  2c12c2:	74 0c                	je     2c12d0 <printer_vprintf+0x6fb>
  2c12c4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c12cb:	0f b6 00             	movzbl (%rax),%eax
  2c12ce:	eb 05                	jmp    2c12d5 <printer_vprintf+0x700>
  2c12d0:	b8 25 00 00 00       	mov    $0x25,%eax
  2c12d5:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c12d8:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c12dc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c12e3:	0f b6 00             	movzbl (%rax),%eax
  2c12e6:	84 c0                	test   %al,%al
  2c12e8:	75 08                	jne    2c12f2 <printer_vprintf+0x71d>
                format--;
  2c12ea:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c12f1:	01 
            }
            break;
  2c12f2:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c12f3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c12f6:	83 e0 20             	and    $0x20,%eax
  2c12f9:	85 c0                	test   %eax,%eax
  2c12fb:	74 1e                	je     2c131b <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c12fd:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1301:	48 83 c0 18          	add    $0x18,%rax
  2c1305:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1308:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c130c:	48 89 ce             	mov    %rcx,%rsi
  2c130f:	48 89 c7             	mov    %rax,%rdi
  2c1312:	e8 32 f8 ff ff       	call   2c0b49 <fill_numbuf>
  2c1317:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c131b:	48 8d 05 e4 06 00 00 	lea    0x6e4(%rip),%rax        # 2c1a06 <flag_chars+0x6>
  2c1322:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c1326:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1329:	83 e0 20             	and    $0x20,%eax
  2c132c:	85 c0                	test   %eax,%eax
  2c132e:	74 51                	je     2c1381 <printer_vprintf+0x7ac>
  2c1330:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1333:	83 e0 40             	and    $0x40,%eax
  2c1336:	85 c0                	test   %eax,%eax
  2c1338:	74 47                	je     2c1381 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  2c133a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c133d:	25 80 00 00 00       	and    $0x80,%eax
  2c1342:	85 c0                	test   %eax,%eax
  2c1344:	74 0d                	je     2c1353 <printer_vprintf+0x77e>
                prefix = "-";
  2c1346:	48 8d 05 ba 06 00 00 	lea    0x6ba(%rip),%rax        # 2c1a07 <flag_chars+0x7>
  2c134d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c1351:	eb 7d                	jmp    2c13d0 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c1353:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1356:	83 e0 10             	and    $0x10,%eax
  2c1359:	85 c0                	test   %eax,%eax
  2c135b:	74 0d                	je     2c136a <printer_vprintf+0x795>
                prefix = "+";
  2c135d:	48 8d 05 a5 06 00 00 	lea    0x6a5(%rip),%rax        # 2c1a09 <flag_chars+0x9>
  2c1364:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c1368:	eb 66                	jmp    2c13d0 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c136a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c136d:	83 e0 08             	and    $0x8,%eax
  2c1370:	85 c0                	test   %eax,%eax
  2c1372:	74 5c                	je     2c13d0 <printer_vprintf+0x7fb>
                prefix = " ";
  2c1374:	48 8d 05 90 06 00 00 	lea    0x690(%rip),%rax        # 2c1a0b <flag_chars+0xb>
  2c137b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c137f:	eb 4f                	jmp    2c13d0 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c1381:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1384:	83 e0 20             	and    $0x20,%eax
  2c1387:	85 c0                	test   %eax,%eax
  2c1389:	74 46                	je     2c13d1 <printer_vprintf+0x7fc>
  2c138b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c138e:	83 e0 01             	and    $0x1,%eax
  2c1391:	85 c0                	test   %eax,%eax
  2c1393:	74 3c                	je     2c13d1 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  2c1395:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c1399:	74 06                	je     2c13a1 <printer_vprintf+0x7cc>
  2c139b:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c139f:	75 30                	jne    2c13d1 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  2c13a1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c13a6:	75 0c                	jne    2c13b4 <printer_vprintf+0x7df>
  2c13a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c13ab:	25 00 01 00 00       	and    $0x100,%eax
  2c13b0:	85 c0                	test   %eax,%eax
  2c13b2:	74 1d                	je     2c13d1 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  2c13b4:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c13b8:	75 09                	jne    2c13c3 <printer_vprintf+0x7ee>
  2c13ba:	48 8d 05 4c 06 00 00 	lea    0x64c(%rip),%rax        # 2c1a0d <flag_chars+0xd>
  2c13c1:	eb 07                	jmp    2c13ca <printer_vprintf+0x7f5>
  2c13c3:	48 8d 05 46 06 00 00 	lea    0x646(%rip),%rax        # 2c1a10 <flag_chars+0x10>
  2c13ca:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c13ce:	eb 01                	jmp    2c13d1 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  2c13d0:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c13d1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c13d5:	78 24                	js     2c13fb <printer_vprintf+0x826>
  2c13d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c13da:	83 e0 20             	and    $0x20,%eax
  2c13dd:	85 c0                	test   %eax,%eax
  2c13df:	75 1a                	jne    2c13fb <printer_vprintf+0x826>
            len = strnlen(data, precision);
  2c13e1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c13e4:	48 63 d0             	movslq %eax,%rdx
  2c13e7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c13eb:	48 89 d6             	mov    %rdx,%rsi
  2c13ee:	48 89 c7             	mov    %rax,%rdi
  2c13f1:	e8 91 f5 ff ff       	call   2c0987 <strnlen>
  2c13f6:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c13f9:	eb 0f                	jmp    2c140a <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  2c13fb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c13ff:	48 89 c7             	mov    %rax,%rdi
  2c1402:	e8 4b f5 ff ff       	call   2c0952 <strlen>
  2c1407:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c140a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c140d:	83 e0 20             	and    $0x20,%eax
  2c1410:	85 c0                	test   %eax,%eax
  2c1412:	74 20                	je     2c1434 <printer_vprintf+0x85f>
  2c1414:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1418:	78 1a                	js     2c1434 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  2c141a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c141d:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c1420:	7e 08                	jle    2c142a <printer_vprintf+0x855>
  2c1422:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1425:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1428:	eb 05                	jmp    2c142f <printer_vprintf+0x85a>
  2c142a:	b8 00 00 00 00       	mov    $0x0,%eax
  2c142f:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1432:	eb 5c                	jmp    2c1490 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c1434:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1437:	83 e0 20             	and    $0x20,%eax
  2c143a:	85 c0                	test   %eax,%eax
  2c143c:	74 4b                	je     2c1489 <printer_vprintf+0x8b4>
  2c143e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1441:	83 e0 02             	and    $0x2,%eax
  2c1444:	85 c0                	test   %eax,%eax
  2c1446:	74 41                	je     2c1489 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c1448:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c144b:	83 e0 04             	and    $0x4,%eax
  2c144e:	85 c0                	test   %eax,%eax
  2c1450:	75 37                	jne    2c1489 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  2c1452:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1456:	48 89 c7             	mov    %rax,%rdi
  2c1459:	e8 f4 f4 ff ff       	call   2c0952 <strlen>
  2c145e:	89 c2                	mov    %eax,%edx
  2c1460:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c1463:	01 d0                	add    %edx,%eax
  2c1465:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c1468:	7e 1f                	jle    2c1489 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  2c146a:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c146d:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1470:	89 c3                	mov    %eax,%ebx
  2c1472:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1476:	48 89 c7             	mov    %rax,%rdi
  2c1479:	e8 d4 f4 ff ff       	call   2c0952 <strlen>
  2c147e:	89 c2                	mov    %eax,%edx
  2c1480:	89 d8                	mov    %ebx,%eax
  2c1482:	29 d0                	sub    %edx,%eax
  2c1484:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1487:	eb 07                	jmp    2c1490 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  2c1489:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c1490:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c1493:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c1496:	01 d0                	add    %edx,%eax
  2c1498:	48 63 d8             	movslq %eax,%rbx
  2c149b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c149f:	48 89 c7             	mov    %rax,%rdi
  2c14a2:	e8 ab f4 ff ff       	call   2c0952 <strlen>
  2c14a7:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c14ab:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c14ae:	29 d0                	sub    %edx,%eax
  2c14b0:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c14b3:	eb 25                	jmp    2c14da <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  2c14b5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c14bc:	48 8b 08             	mov    (%rax),%rcx
  2c14bf:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c14c5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c14cc:	be 20 00 00 00       	mov    $0x20,%esi
  2c14d1:	48 89 c7             	mov    %rax,%rdi
  2c14d4:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c14d6:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c14da:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14dd:	83 e0 04             	and    $0x4,%eax
  2c14e0:	85 c0                	test   %eax,%eax
  2c14e2:	75 36                	jne    2c151a <printer_vprintf+0x945>
  2c14e4:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c14e8:	7f cb                	jg     2c14b5 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  2c14ea:	eb 2e                	jmp    2c151a <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  2c14ec:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c14f3:	4c 8b 00             	mov    (%rax),%r8
  2c14f6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c14fa:	0f b6 00             	movzbl (%rax),%eax
  2c14fd:	0f b6 c8             	movzbl %al,%ecx
  2c1500:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1506:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c150d:	89 ce                	mov    %ecx,%esi
  2c150f:	48 89 c7             	mov    %rax,%rdi
  2c1512:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1515:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c151a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c151e:	0f b6 00             	movzbl (%rax),%eax
  2c1521:	84 c0                	test   %al,%al
  2c1523:	75 c7                	jne    2c14ec <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  2c1525:	eb 25                	jmp    2c154c <printer_vprintf+0x977>
            p->putc(p, '0', color);
  2c1527:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c152e:	48 8b 08             	mov    (%rax),%rcx
  2c1531:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1537:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c153e:	be 30 00 00 00       	mov    $0x30,%esi
  2c1543:	48 89 c7             	mov    %rax,%rdi
  2c1546:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c1548:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c154c:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c1550:	7f d5                	jg     2c1527 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  2c1552:	eb 32                	jmp    2c1586 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  2c1554:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c155b:	4c 8b 00             	mov    (%rax),%r8
  2c155e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1562:	0f b6 00             	movzbl (%rax),%eax
  2c1565:	0f b6 c8             	movzbl %al,%ecx
  2c1568:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c156e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1575:	89 ce                	mov    %ecx,%esi
  2c1577:	48 89 c7             	mov    %rax,%rdi
  2c157a:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c157d:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c1582:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c1586:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c158a:	7f c8                	jg     2c1554 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  2c158c:	eb 25                	jmp    2c15b3 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  2c158e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1595:	48 8b 08             	mov    (%rax),%rcx
  2c1598:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c159e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c15a5:	be 20 00 00 00       	mov    $0x20,%esi
  2c15aa:	48 89 c7             	mov    %rax,%rdi
  2c15ad:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c15af:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c15b3:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c15b7:	7f d5                	jg     2c158e <printer_vprintf+0x9b9>
        }
    done: ;
  2c15b9:	90                   	nop
    for (; *format; ++format) {
  2c15ba:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c15c1:	01 
  2c15c2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c15c9:	0f b6 00             	movzbl (%rax),%eax
  2c15cc:	84 c0                	test   %al,%al
  2c15ce:	0f 85 31 f6 ff ff    	jne    2c0c05 <printer_vprintf+0x30>
    }
}
  2c15d4:	90                   	nop
  2c15d5:	90                   	nop
  2c15d6:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c15da:	c9                   	leave  
  2c15db:	c3                   	ret    

00000000002c15dc <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c15dc:	f3 0f 1e fa          	endbr64 
  2c15e0:	55                   	push   %rbp
  2c15e1:	48 89 e5             	mov    %rsp,%rbp
  2c15e4:	48 83 ec 20          	sub    $0x20,%rsp
  2c15e8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c15ec:	89 f0                	mov    %esi,%eax
  2c15ee:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c15f1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c15f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c15f8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c15fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1600:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1604:	48 8d 15 95 79 df ff 	lea    -0x20866b(%rip),%rdx        # b8fa0 <console+0xfa0>
  2c160b:	48 39 d0             	cmp    %rdx,%rax
  2c160e:	72 0f                	jb     2c161f <console_putc+0x43>
        cp->cursor = console;
  2c1610:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1614:	48 8d 15 e5 69 df ff 	lea    -0x20961b(%rip),%rdx        # b8000 <console>
  2c161b:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  2c161f:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c1623:	0f 85 82 00 00 00    	jne    2c16ab <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  2c1629:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c162d:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1631:	48 8d 15 c8 69 df ff 	lea    -0x209638(%rip),%rdx        # b8000 <console>
  2c1638:	48 29 d0             	sub    %rdx,%rax
  2c163b:	48 d1 f8             	sar    %rax
  2c163e:	48 89 c1             	mov    %rax,%rcx
  2c1641:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1648:	66 66 66 
  2c164b:	48 89 c8             	mov    %rcx,%rax
  2c164e:	48 f7 ea             	imul   %rdx
  2c1651:	48 89 d0             	mov    %rdx,%rax
  2c1654:	48 c1 f8 05          	sar    $0x5,%rax
  2c1658:	48 89 ce             	mov    %rcx,%rsi
  2c165b:	48 c1 fe 3f          	sar    $0x3f,%rsi
  2c165f:	48 29 f0             	sub    %rsi,%rax
  2c1662:	48 89 c2             	mov    %rax,%rdx
  2c1665:	48 89 d0             	mov    %rdx,%rax
  2c1668:	48 c1 e0 02          	shl    $0x2,%rax
  2c166c:	48 01 d0             	add    %rdx,%rax
  2c166f:	48 c1 e0 04          	shl    $0x4,%rax
  2c1673:	48 29 c1             	sub    %rax,%rcx
  2c1676:	48 89 ca             	mov    %rcx,%rdx
  2c1679:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c167c:	eb 25                	jmp    2c16a3 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  2c167e:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1681:	83 c8 20             	or     $0x20,%eax
  2c1684:	89 c6                	mov    %eax,%esi
  2c1686:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c168a:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c168e:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1692:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1696:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c169a:	89 f2                	mov    %esi,%edx
  2c169c:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c169f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c16a3:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c16a7:	75 d5                	jne    2c167e <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c16a9:	eb 24                	jmp    2c16cf <console_putc+0xf3>
        *cp->cursor++ = c | color;
  2c16ab:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c16af:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c16b2:	89 d6                	mov    %edx,%esi
  2c16b4:	09 c6                	or     %eax,%esi
  2c16b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c16ba:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c16be:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c16c2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c16c6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c16ca:	89 f2                	mov    %esi,%edx
  2c16cc:	66 89 10             	mov    %dx,(%rax)
}
  2c16cf:	90                   	nop
  2c16d0:	c9                   	leave  
  2c16d1:	c3                   	ret    

00000000002c16d2 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c16d2:	f3 0f 1e fa          	endbr64 
  2c16d6:	55                   	push   %rbp
  2c16d7:	48 89 e5             	mov    %rsp,%rbp
  2c16da:	48 83 ec 30          	sub    $0x30,%rsp
  2c16de:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c16e1:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c16e4:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c16e8:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c16ec:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 2c15dc <console_putc>
  2c16f3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c16f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c16fb:	78 09                	js     2c1706 <console_vprintf+0x34>
  2c16fd:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1704:	7e 07                	jle    2c170d <console_vprintf+0x3b>
        cpos = 0;
  2c1706:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c170d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1710:	48 98                	cltq   
  2c1712:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c1716:	48 8d 05 e3 68 df ff 	lea    -0x20971d(%rip),%rax        # b8000 <console>
  2c171d:	48 01 d0             	add    %rdx,%rax
  2c1720:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1724:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1728:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c172c:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c172f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1733:	48 89 c7             	mov    %rax,%rdi
  2c1736:	e8 9a f4 ff ff       	call   2c0bd5 <printer_vprintf>
    return cp.cursor - console;
  2c173b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c173f:	48 8d 15 ba 68 df ff 	lea    -0x209746(%rip),%rdx        # b8000 <console>
  2c1746:	48 29 d0             	sub    %rdx,%rax
  2c1749:	48 d1 f8             	sar    %rax
}
  2c174c:	c9                   	leave  
  2c174d:	c3                   	ret    

00000000002c174e <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c174e:	f3 0f 1e fa          	endbr64 
  2c1752:	55                   	push   %rbp
  2c1753:	48 89 e5             	mov    %rsp,%rbp
  2c1756:	48 83 ec 60          	sub    $0x60,%rsp
  2c175a:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c175d:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c1760:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1764:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1768:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c176c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1770:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1777:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c177b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c177f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1783:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1787:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c178b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c178f:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c1792:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c1795:	89 c7                	mov    %eax,%edi
  2c1797:	e8 36 ff ff ff       	call   2c16d2 <console_vprintf>
  2c179c:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c179f:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c17a2:	c9                   	leave  
  2c17a3:	c3                   	ret    

00000000002c17a4 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c17a4:	f3 0f 1e fa          	endbr64 
  2c17a8:	55                   	push   %rbp
  2c17a9:	48 89 e5             	mov    %rsp,%rbp
  2c17ac:	48 83 ec 20          	sub    $0x20,%rsp
  2c17b0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c17b4:	89 f0                	mov    %esi,%eax
  2c17b6:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c17b9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c17bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c17c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c17c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c17c8:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c17cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c17d0:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c17d4:	48 39 c2             	cmp    %rax,%rdx
  2c17d7:	73 1a                	jae    2c17f3 <string_putc+0x4f>
        *sp->s++ = c;
  2c17d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c17dd:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c17e1:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c17e5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c17e9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c17ed:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c17f1:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c17f3:	90                   	nop
  2c17f4:	c9                   	leave  
  2c17f5:	c3                   	ret    

00000000002c17f6 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c17f6:	f3 0f 1e fa          	endbr64 
  2c17fa:	55                   	push   %rbp
  2c17fb:	48 89 e5             	mov    %rsp,%rbp
  2c17fe:	48 83 ec 40          	sub    $0x40,%rsp
  2c1802:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1806:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c180a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c180e:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1812:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 2c17a4 <string_putc>
  2c1819:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  2c181d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1821:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1825:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c182a:	74 33                	je     2c185f <vsnprintf+0x69>
        sp.end = s + size - 1;
  2c182c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1830:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c1834:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1838:	48 01 d0             	add    %rdx,%rax
  2c183b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c183f:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c1843:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c1847:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c184b:	be 00 00 00 00       	mov    $0x0,%esi
  2c1850:	48 89 c7             	mov    %rax,%rdi
  2c1853:	e8 7d f3 ff ff       	call   2c0bd5 <printer_vprintf>
        *sp.s = 0;
  2c1858:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c185c:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c185f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1863:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c1867:	c9                   	leave  
  2c1868:	c3                   	ret    

00000000002c1869 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1869:	f3 0f 1e fa          	endbr64 
  2c186d:	55                   	push   %rbp
  2c186e:	48 89 e5             	mov    %rsp,%rbp
  2c1871:	48 83 ec 70          	sub    $0x70,%rsp
  2c1875:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c1879:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c187d:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1881:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1885:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1889:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c188d:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c1894:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1898:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c189c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c18a0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c18a4:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c18a8:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c18ac:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c18b0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c18b4:	48 89 c7             	mov    %rax,%rdi
  2c18b7:	e8 3a ff ff ff       	call   2c17f6 <vsnprintf>
  2c18bc:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c18bf:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c18c2:	c9                   	leave  
  2c18c3:	c3                   	ret    

00000000002c18c4 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c18c4:	f3 0f 1e fa          	endbr64 
  2c18c8:	55                   	push   %rbp
  2c18c9:	48 89 e5             	mov    %rsp,%rbp
  2c18cc:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c18d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c18d7:	eb 1a                	jmp    2c18f3 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  2c18d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c18dc:	48 98                	cltq   
  2c18de:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c18e2:	48 8d 05 17 67 df ff 	lea    -0x2098e9(%rip),%rax        # b8000 <console>
  2c18e9:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c18ef:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c18f3:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c18fa:	7e dd                	jle    2c18d9 <console_clear+0x15>
    }
    cursorpos = 0;
  2c18fc:	c7 05 f6 76 df ff 00 	movl   $0x0,-0x20890a(%rip)        # b8ffc <cursorpos>
  2c1903:	00 00 00 
}
  2c1906:	90                   	nop
  2c1907:	c9                   	leave  
  2c1908:	c3                   	ret    
