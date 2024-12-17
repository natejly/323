
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
  2c001a:	e8 43 0f 00 00       	call   2c0f62 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001f:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0024:	e8 c1 05 00 00       	call   2c05ea <malloc>
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
  2c0043:	e8 d0 06 00 00       	call   2c0718 <realloc>
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
  2c006b:	e8 05 06 00 00       	call   2c0675 <calloc>
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
  2c008a:	e8 12 07 00 00       	call   2c07a1 <heap_info>
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
  2c00bb:	48 8d 15 8e 1c 00 00 	lea    0x1c8e(%rip),%rdx        # 2c1d50 <console_clear+0x4e>
  2c00c2:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c7:	48 8d 3d 90 1c 00 00 	lea    0x1c90(%rip),%rdi        # 2c1d5e <console_clear+0x5c>
  2c00ce:	e8 31 02 00 00       	call   2c0304 <assert_fail>
	assert(array2[i] == 0);
  2c00d3:	48 8d 15 9a 1c 00 00 	lea    0x1c9a(%rip),%rdx        # 2c1d74 <console_clear+0x72>
  2c00da:	be 21 00 00 00       	mov    $0x21,%esi
  2c00df:	48 8d 3d 78 1c 00 00 	lea    0x1c78(%rip),%rdi        # 2c1d5e <console_clear+0x5c>
  2c00e6:	e8 19 02 00 00       	call   2c0304 <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00eb:	48 8d 15 a6 1c 00 00 	lea    0x1ca6(%rip),%rdx        # 2c1d98 <console_clear+0x96>
  2c00f2:	be 28 00 00 00       	mov    $0x28,%esi
  2c00f7:	48 8d 3d 60 1c 00 00 	lea    0x1c60(%rip),%rdi        # 2c1d5e <console_clear+0x5c>
  2c00fe:	e8 01 02 00 00       	call   2c0304 <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c0103:	48 8d 35 79 1c 00 00 	lea    0x1c79(%rip),%rsi        # 2c1d83 <console_clear+0x81>
  2c010a:	bf 00 00 00 00       	mov    $0x0,%edi
  2c010f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0114:	e8 7b 00 00 00       	call   2c0194 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0119:	4c 89 ef             	mov    %r13,%rdi
  2c011c:	e8 b0 05 00 00       	call   2c06d1 <free>
    free(array2);
  2c0121:	4c 89 f7             	mov    %r14,%rdi
  2c0124:	e8 a8 05 00 00       	call   2c06d1 <free>

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
  2c0142:	e8 a3 04 00 00       	call   2c05ea <malloc>
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
  2c017c:	48 8d 35 45 1c 00 00 	lea    0x1c45(%rip),%rsi        # 2c1dc8 <console_clear+0xc6>
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
  2c01e0:	48 8d 05 46 1c 00 00 	lea    0x1c46(%rip),%rax        # 2c1e2d <col.0>
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
  2c0212:	e8 f9 18 00 00       	call   2c1b10 <console_vprintf>
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
  2c0276:	48 8d 35 7b 1b 00 00 	lea    0x1b7b(%rip),%rsi        # 2c1df8 <console_clear+0xf6>
  2c027d:	e8 c5 09 00 00       	call   2c0c47 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0282:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0286:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c028d:	48 89 da             	mov    %rbx,%rdx
  2c0290:	be 99 00 00 00       	mov    $0x99,%esi
  2c0295:	e8 9a 19 00 00       	call   2c1c34 <vsnprintf>
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
  2c02ba:	48 8d 15 3f 1b 00 00 	lea    0x1b3f(%rip),%rdx        # 2c1e00 <console_clear+0xfe>
  2c02c1:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02c6:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02cb:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02d0:	e8 b7 18 00 00       	call   2c1b8c <console_printf>
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
  2c02f6:	48 8d 35 96 1a 00 00 	lea    0x1a96(%rip),%rsi        # 2c1d93 <console_clear+0x91>
  2c02fd:	e8 06 0b 00 00       	call   2c0e08 <strcpy>
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
  2c0315:	48 8d 15 ec 1a 00 00 	lea    0x1aec(%rip),%rdx        # 2c1e08 <console_clear+0x106>
  2c031c:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0321:	bf 30 07 00 00       	mov    $0x730,%edi
  2c0326:	b8 00 00 00 00       	mov    $0x0,%eax
  2c032b:	e8 5c 18 00 00       	call   2c1b8c <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0330:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0335:	cd 30                	int    $0x30
 loop: goto loop;
  2c0337:	eb fe                	jmp    2c0337 <assert_fail+0x33>

00000000002c0339 <algn>:
block* split_block(block* block, size_t size);
void add_to_free_list(block *b);
void remove_from_free_list(block *b);
void heap_init();

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
  2c0353:	48 89 05 c6 1c 00 00 	mov    %rax,0x1cc6(%rip)        # 2c2020 <result.0>
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
  2c0394:	48 8b 05 8d 1c 00 00 	mov    0x1c8d(%rip),%rax        # 2c2028 <free_head>
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
  2c03ba:	48 8b 05 67 1c 00 00 	mov    0x1c67(%rip),%rax        # 2c2028 <free_head>
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
  2c03d6:	48 89 3d 4b 1c 00 00 	mov    %rdi,0x1c4b(%rip)        # 2c2028 <free_head>
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
  2c0477:	48 89 05 aa 1b 00 00 	mov    %rax,0x1baa(%rip)        # 2c2028 <free_head>
  2c047e:	eb ca                	jmp    2c044a <remove_from_free_list+0x15>

00000000002c0480 <update_largest_free_chunk>:
void update_largest_free_chunk() {
  2c0480:	f3 0f 1e fa          	endbr64 
    largest_free_chunk = 0; // Reset the value
  2c0484:	c7 05 72 1b 00 00 00 	movl   $0x0,0x1b72(%rip)        # 2c2000 <largest_free_chunk>
  2c048b:	00 00 00 
    block *b = free_head;
  2c048e:	48 8b 05 93 1b 00 00 	mov    0x1b93(%rip),%rax        # 2c2028 <free_head>
    int size;
    // Traverse the free list to find the largest free chunk
    while (b) {
  2c0495:	48 85 c0             	test   %rax,%rax
  2c0498:	75 0a                	jne    2c04a4 <update_largest_free_chunk+0x24>
        if (size > largest_free_chunk) {
            largest_free_chunk = size;
        }
        b = b->free_next;
    }
}
  2c049a:	c3                   	ret    
        b = b->free_next;
  2c049b:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (b) {
  2c049f:	48 85 c0             	test   %rax,%rax
  2c04a2:	74 f6                	je     2c049a <update_largest_free_chunk+0x1a>
        size = (int)b->size;
  2c04a4:	48 8b 10             	mov    (%rax),%rdx
        if (size > largest_free_chunk) {
  2c04a7:	39 15 53 1b 00 00    	cmp    %edx,0x1b53(%rip)        # 2c2000 <largest_free_chunk>
  2c04ad:	7d ec                	jge    2c049b <update_largest_free_chunk+0x1b>
            largest_free_chunk = size;
  2c04af:	89 15 4b 1b 00 00    	mov    %edx,0x1b4b(%rip)        # 2c2000 <largest_free_chunk>
  2c04b5:	eb e4                	jmp    2c049b <update_largest_free_chunk+0x1b>

00000000002c04b7 <heap_init>:
    }
    update_free_space();         // Update free space
    update_largest_free_chunk(); // Update largest free chunk

}
void heap_init() {
  2c04b7:	f3 0f 1e fa          	endbr64 
    asm volatile ("int %1" :  "=a" (result)
  2c04bb:	bf 20 03 00 00       	mov    $0x320,%edi
  2c04c0:	cd 3a                	int    $0x3a
  2c04c2:	48 89 05 57 1b 00 00 	mov    %rax,0x1b57(%rip)        # 2c2020 <result.0>
    size_array = (long*) sbrk(sizeof(long) * ARRAY_SIZE);
  2c04c9:	48 89 05 40 1b 00 00 	mov    %rax,0x1b40(%rip)        # 2c2010 <size_array>
  2c04d0:	cd 3a                	int    $0x3a
  2c04d2:	48 89 05 47 1b 00 00 	mov    %rax,0x1b47(%rip)        # 2c2020 <result.0>
    ptr_array = (void**) sbrk(sizeof(void*) * ARRAY_SIZE);
  2c04d9:	48 89 05 28 1b 00 00 	mov    %rax,0x1b28(%rip)        # 2c2008 <ptr_array>
    if (size_array == (void*)-1 || ptr_array == (void*)-1) {
  2c04e0:	48 83 3d 28 1b 00 00 	cmpq   $0xffffffffffffffff,0x1b28(%rip)        # 2c2010 <size_array>
  2c04e7:	ff 
  2c04e8:	74 06                	je     2c04f0 <heap_init+0x39>
  2c04ea:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c04ee:	75 16                	jne    2c0506 <heap_init+0x4f>
        // Handle sbrk failure
        size_array = NULL;
  2c04f0:	48 c7 05 15 1b 00 00 	movq   $0x0,0x1b15(%rip)        # 2c2010 <size_array>
  2c04f7:	00 00 00 00 
        ptr_array = NULL;
  2c04fb:	48 c7 05 02 1b 00 00 	movq   $0x0,0x1b02(%rip)        # 2c2008 <ptr_array>
  2c0502:	00 00 00 00 
    }
    num_allocs = 0;
  2c0506:	c7 05 08 1b 00 00 00 	movl   $0x0,0x1b08(%rip)        # 2c2018 <num_allocs>
  2c050d:	00 00 00 
    free_space = 0;
  2c0510:	c7 05 ea 1a 00 00 00 	movl   $0x0,0x1aea(%rip)        # 2c2004 <free_space>
  2c0517:	00 00 00 
    largest_free_chunk = 0;
  2c051a:	c7 05 dc 1a 00 00 00 	movl   $0x0,0x1adc(%rip)        # 2c2000 <largest_free_chunk>
  2c0521:	00 00 00 
}
  2c0524:	c3                   	ret    

00000000002c0525 <update_free_space>:

void update_free_space() {
  2c0525:	f3 0f 1e fa          	endbr64 
    free_space = 0; // Reset the free space counter
  2c0529:	c7 05 d1 1a 00 00 00 	movl   $0x0,0x1ad1(%rip)        # 2c2004 <free_space>
  2c0530:	00 00 00 
    block *b = free_head;
  2c0533:	48 8b 05 ee 1a 00 00 	mov    0x1aee(%rip),%rax        # 2c2028 <free_head>

    // Traverse the free list and sum up the size of free blocks
    while (b) {
  2c053a:	48 85 c0             	test   %rax,%rax
  2c053d:	74 16                	je     2c0555 <update_free_space+0x30>
        free_space += b->size + BLOCKSIZE; // Add block size + metadata size
  2c053f:	48 8b 08             	mov    (%rax),%rcx
  2c0542:	48 8d 51 28          	lea    0x28(%rcx),%rdx
  2c0546:	01 15 b8 1a 00 00    	add    %edx,0x1ab8(%rip)        # 2c2004 <free_space>
        b = b->free_next;
  2c054c:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (b) {
  2c0550:	48 85 c0             	test   %rax,%rax
  2c0553:	75 ea                	jne    2c053f <update_free_space+0x1a>
    }
}
  2c0555:	c3                   	ret    

00000000002c0556 <defrag>:
void defrag() {
  2c0556:	f3 0f 1e fa          	endbr64 
  2c055a:	55                   	push   %rbp
  2c055b:	48 89 e5             	mov    %rsp,%rbp
  2c055e:	41 54                	push   %r12
  2c0560:	53                   	push   %rbx
    block *b = free_head;
  2c0561:	48 8b 1d c0 1a 00 00 	mov    0x1ac0(%rip),%rbx        # 2c2028 <free_head>
    while (b && b->free_next) {
  2c0568:	48 85 db             	test   %rbx,%rbx
  2c056b:	74 34                	je     2c05a1 <defrag+0x4b>
  2c056d:	4c 8b 63 18          	mov    0x18(%rbx),%r12
  2c0571:	4d 85 e4             	test   %r12,%r12
  2c0574:	74 2b                	je     2c05a1 <defrag+0x4b>
        if ((void*)b + BLOCKSIZE + b->size == (void*)b->free_next) {
  2c0576:	48 8b 03             	mov    (%rbx),%rax
  2c0579:	48 8d 44 03 28       	lea    0x28(%rbx,%rax,1),%rax
  2c057e:	49 39 c4             	cmp    %rax,%r12
  2c0581:	74 05                	je     2c0588 <defrag+0x32>
    while (b && b->free_next) {
  2c0583:	4c 89 e3             	mov    %r12,%rbx
  2c0586:	eb e0                	jmp    2c0568 <defrag+0x12>
            remove_from_free_list(next);
  2c0588:	4c 89 e7             	mov    %r12,%rdi
  2c058b:	e8 a5 fe ff ff       	call   2c0435 <remove_from_free_list>
            b->size += BLOCKSIZE + next->size;
  2c0590:	48 8b 13             	mov    (%rbx),%rdx
  2c0593:	49 8b 04 24          	mov    (%r12),%rax
  2c0597:	48 8d 44 02 28       	lea    0x28(%rdx,%rax,1),%rax
  2c059c:	48 89 03             	mov    %rax,(%rbx)
  2c059f:	eb c7                	jmp    2c0568 <defrag+0x12>
    update_free_space();         // Update free space
  2c05a1:	b8 00 00 00 00       	mov    $0x0,%eax
  2c05a6:	e8 7a ff ff ff       	call   2c0525 <update_free_space>
    update_largest_free_chunk(); // Update largest free chunk
  2c05ab:	b8 00 00 00 00       	mov    $0x0,%eax
  2c05b0:	e8 cb fe ff ff       	call   2c0480 <update_largest_free_chunk>
}
  2c05b5:	5b                   	pop    %rbx
  2c05b6:	41 5c                	pop    %r12
  2c05b8:	5d                   	pop    %rbp
  2c05b9:	c3                   	ret    

00000000002c05ba <add_alloc>:

void add_alloc(block* b){
  2c05ba:	f3 0f 1e fa          	endbr64 
    size_array[num_allocs] = b->size;
  2c05be:	48 63 15 53 1a 00 00 	movslq 0x1a53(%rip),%rdx        # 2c2018 <num_allocs>
  2c05c5:	48 8b 0f             	mov    (%rdi),%rcx
  2c05c8:	48 8b 05 41 1a 00 00 	mov    0x1a41(%rip),%rax        # 2c2010 <size_array>
  2c05cf:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
    ptr_array[num_allocs] = (void*)((void*)b + BLOCKSIZE);
  2c05d3:	48 63 15 3e 1a 00 00 	movslq 0x1a3e(%rip),%rdx        # 2c2018 <num_allocs>
  2c05da:	48 83 c7 28          	add    $0x28,%rdi
  2c05de:	48 8b 05 23 1a 00 00 	mov    0x1a23(%rip),%rax        # 2c2008 <ptr_array>
  2c05e5:	48 89 3c d0          	mov    %rdi,(%rax,%rdx,8)
} 
  2c05e9:	c3                   	ret    

00000000002c05ea <malloc>:
void *malloc(uint64_t numbytes) {
  2c05ea:	f3 0f 1e fa          	endbr64 
  2c05ee:	55                   	push   %rbp
  2c05ef:	48 89 e5             	mov    %rsp,%rbp
  2c05f2:	41 54                	push   %r12
  2c05f4:	53                   	push   %rbx
  2c05f5:	49 89 fc             	mov    %rdi,%r12
    if (size_array == NULL) { 
  2c05f8:	48 83 3d 10 1a 00 00 	cmpq   $0x0,0x1a10(%rip)        # 2c2010 <size_array>
  2c05ff:	00 
  2c0600:	74 3e                	je     2c0640 <malloc+0x56>
    return (size + 7) / 8 * 8;
  2c0602:	49 83 c4 07          	add    $0x7,%r12
  2c0606:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    block *b = find_block(size);
  2c060a:	4c 89 e7             	mov    %r12,%rdi
  2c060d:	e8 7e fd ff ff       	call   2c0390 <find_block>
  2c0612:	48 89 c3             	mov    %rax,%rbx
    if (b == NULL) {
  2c0615:	48 85 c0             	test   %rax,%rax
  2c0618:	74 32                	je     2c064c <malloc+0x62>
        remove_from_free_list(b);
  2c061a:	48 89 c7             	mov    %rax,%rdi
  2c061d:	e8 13 fe ff ff       	call   2c0435 <remove_from_free_list>
        if (b->size > size + BLOCKSIZE) {
  2c0622:	49 8d 44 24 28       	lea    0x28(%r12),%rax
  2c0627:	48 39 03             	cmp    %rax,(%rbx)
  2c062a:	77 32                	ja     2c065e <malloc+0x74>
    add_alloc(b); 
  2c062c:	48 89 df             	mov    %rbx,%rdi
  2c062f:	e8 86 ff ff ff       	call   2c05ba <add_alloc>
    return (void*)((void*)b + BLOCKSIZE);
  2c0634:	48 83 c3 28          	add    $0x28,%rbx
}
  2c0638:	48 89 d8             	mov    %rbx,%rax
  2c063b:	5b                   	pop    %rbx
  2c063c:	41 5c                	pop    %r12
  2c063e:	5d                   	pop    %rbp
  2c063f:	c3                   	ret    
        heap_init();
  2c0640:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0645:	e8 6d fe ff ff       	call   2c04b7 <heap_init>
  2c064a:	eb b6                	jmp    2c0602 <malloc+0x18>
        b = new_block(size);
  2c064c:	4c 89 e7             	mov    %r12,%rdi
  2c064f:	e8 f2 fc ff ff       	call   2c0346 <new_block>
  2c0654:	48 89 c3             	mov    %rax,%rbx
        if (b == NULL) {
  2c0657:	48 85 c0             	test   %rax,%rax
  2c065a:	75 d0                	jne    2c062c <malloc+0x42>
  2c065c:	eb da                	jmp    2c0638 <malloc+0x4e>
            split_block(b, size);
  2c065e:	4c 89 e6             	mov    %r12,%rsi
  2c0661:	48 89 df             	mov    %rbx,%rdi
  2c0664:	e8 75 fd ff ff       	call   2c03de <split_block>
            update_free_space();         
  2c0669:	b8 00 00 00 00       	mov    $0x0,%eax
  2c066e:	e8 b2 fe ff ff       	call   2c0525 <update_free_space>
  2c0673:	eb b7                	jmp    2c062c <malloc+0x42>

00000000002c0675 <calloc>:
void *calloc(uint64_t num, uint64_t sz) {
  2c0675:	f3 0f 1e fa          	endbr64 
  2c0679:	55                   	push   %rbp
  2c067a:	48 89 e5             	mov    %rsp,%rbp
  2c067d:	41 54                	push   %r12
  2c067f:	53                   	push   %rbx
    uint64_t total = num * sz;
  2c0680:	48 0f af fe          	imul   %rsi,%rdi
  2c0684:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  2c0687:	e8 5e ff ff ff       	call   2c05ea <malloc>
  2c068c:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  2c068f:	48 85 c0             	test   %rax,%rax
  2c0692:	74 10                	je     2c06a4 <calloc+0x2f>
        memset(ptr, 0, total);
  2c0694:	4c 89 e2             	mov    %r12,%rdx
  2c0697:	be 00 00 00 00       	mov    $0x0,%esi
  2c069c:	48 89 c7             	mov    %rax,%rdi
  2c069f:	e8 a9 06 00 00       	call   2c0d4d <memset>
}
  2c06a4:	48 89 d8             	mov    %rbx,%rax
  2c06a7:	5b                   	pop    %rbx
  2c06a8:	41 5c                	pop    %r12
  2c06aa:	5d                   	pop    %rbp
  2c06ab:	c3                   	ret    

00000000002c06ac <remove_alloc>:
void remove_alloc(block* b){
  2c06ac:	f3 0f 1e fa          	endbr64 
    num_allocs--;
  2c06b0:	8b 05 62 19 00 00    	mov    0x1962(%rip),%eax        # 2c2018 <num_allocs>
  2c06b6:	83 e8 01             	sub    $0x1,%eax
  2c06b9:	89 05 59 19 00 00    	mov    %eax,0x1959(%rip)        # 2c2018 <num_allocs>
    size_array[num_allocs] = 0;
  2c06bf:	48 98                	cltq   
  2c06c1:	48 8b 15 48 19 00 00 	mov    0x1948(%rip),%rdx        # 2c2010 <size_array>
  2c06c8:	48 c7 04 c2 00 00 00 	movq   $0x0,(%rdx,%rax,8)
  2c06cf:	00 
    // ptr_array[num_allocs] = NULL;
}
  2c06d0:	c3                   	ret    

00000000002c06d1 <free>:
void free(void *firstbyte) {
  2c06d1:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  2c06d5:	48 85 ff             	test   %rdi,%rdi
  2c06d8:	74 06                	je     2c06e0 <free+0xf>
    if (b->free) return; // Prevent double-free
  2c06da:	83 7f e8 00          	cmpl   $0x0,-0x18(%rdi)
  2c06de:	74 01                	je     2c06e1 <free+0x10>
  2c06e0:	c3                   	ret    
void free(void *firstbyte) {
  2c06e1:	55                   	push   %rbp
  2c06e2:	48 89 e5             	mov    %rsp,%rbp
  2c06e5:	53                   	push   %rbx
  2c06e6:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
  2c06ea:	48 8d 5f d8          	lea    -0x28(%rdi),%rbx
    add_to_free_list(b);
  2c06ee:	48 89 df             	mov    %rbx,%rdi
  2c06f1:	e8 b9 fc ff ff       	call   2c03af <add_to_free_list>
    remove_alloc(b); // Remove from size_array and ptr_array
  2c06f6:	48 89 df             	mov    %rbx,%rdi
  2c06f9:	e8 ae ff ff ff       	call   2c06ac <remove_alloc>
    update_free_space();         // Update free space
  2c06fe:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0703:	e8 1d fe ff ff       	call   2c0525 <update_free_space>
    update_largest_free_chunk(); // Update largest free chunk
  2c0708:	b8 00 00 00 00       	mov    $0x0,%eax
  2c070d:	e8 6e fd ff ff       	call   2c0480 <update_largest_free_chunk>
}
  2c0712:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0716:	c9                   	leave  
  2c0717:	c3                   	ret    

00000000002c0718 <realloc>:
void *realloc(void *ptr, uint64_t sz) {
  2c0718:	f3 0f 1e fa          	endbr64 
  2c071c:	55                   	push   %rbp
  2c071d:	48 89 e5             	mov    %rsp,%rbp
  2c0720:	41 54                	push   %r12
  2c0722:	53                   	push   %rbx
  2c0723:	48 89 fb             	mov    %rdi,%rbx
  2c0726:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  2c0729:	48 85 db             	test   %rbx,%rbx
  2c072c:	74 2d                	je     2c075b <realloc+0x43>
    if (sz == 0) {
  2c072e:	48 85 f6             	test   %rsi,%rsi
  2c0731:	74 32                	je     2c0765 <realloc+0x4d>
    return (size + 7) / 8 * 8;
  2c0733:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  2c0737:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi
    if (b->size >= aligned_size) {
  2c073b:	48 8b 43 d8          	mov    -0x28(%rbx),%rax
  2c073f:	48 39 f0             	cmp    %rsi,%rax
  2c0742:	72 31                	jb     2c0775 <realloc+0x5d>
        if (b->size > aligned_size + BLOCKSIZE) {
  2c0744:	48 8d 56 28          	lea    0x28(%rsi),%rdx
        return ptr;
  2c0748:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  2c074b:	48 39 d0             	cmp    %rdx,%rax
  2c074e:	76 49                	jbe    2c0799 <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE);
  2c0750:	48 8d 7b d8          	lea    -0x28(%rbx),%rdi
            split_block(b, aligned_size);
  2c0754:	e8 85 fc ff ff       	call   2c03de <split_block>
  2c0759:	eb 3e                	jmp    2c0799 <realloc+0x81>
        return malloc(sz);
  2c075b:	e8 8a fe ff ff       	call   2c05ea <malloc>
  2c0760:	49 89 c4             	mov    %rax,%r12
  2c0763:	eb 34                	jmp    2c0799 <realloc+0x81>
        free(ptr);
  2c0765:	48 89 df             	mov    %rbx,%rdi
  2c0768:	e8 64 ff ff ff       	call   2c06d1 <free>
        return NULL;
  2c076d:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0773:	eb 24                	jmp    2c0799 <realloc+0x81>
    void *new_ptr = malloc(sz);
  2c0775:	e8 70 fe ff ff       	call   2c05ea <malloc>
  2c077a:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  2c077d:	48 85 c0             	test   %rax,%rax
  2c0780:	74 17                	je     2c0799 <realloc+0x81>
    memcpy(new_ptr, ptr, b->size);
  2c0782:	48 8b 53 d8          	mov    -0x28(%rbx),%rdx
  2c0786:	48 89 de             	mov    %rbx,%rsi
  2c0789:	48 89 c7             	mov    %rax,%rdi
  2c078c:	e8 b6 04 00 00       	call   2c0c47 <memcpy>
    free(ptr);
  2c0791:	48 89 df             	mov    %rbx,%rdi
  2c0794:	e8 38 ff ff ff       	call   2c06d1 <free>
}
  2c0799:	4c 89 e0             	mov    %r12,%rax
  2c079c:	5b                   	pop    %rbx
  2c079d:	41 5c                	pop    %r12
  2c079f:	5d                   	pop    %rbp
  2c07a0:	c3                   	ret    

00000000002c07a1 <heap_info>:


int heap_info(heap_info_struct * info) {
  2c07a1:	f3 0f 1e fa          	endbr64 
    info->num_allocs = num_allocs;
  2c07a5:	8b 05 6d 18 00 00    	mov    0x186d(%rip),%eax        # 2c2018 <num_allocs>
  2c07ab:	89 07                	mov    %eax,(%rdi)
    info->free_space = free_space;             
  2c07ad:	8b 05 51 18 00 00    	mov    0x1851(%rip),%eax        # 2c2004 <free_space>
  2c07b3:	89 47 18             	mov    %eax,0x18(%rdi)
    info->largest_free_chunk = largest_free_chunk;
  2c07b6:	8b 05 44 18 00 00    	mov    0x1844(%rip),%eax        # 2c2000 <largest_free_chunk>
  2c07bc:	89 47 1c             	mov    %eax,0x1c(%rdi)

    info->size_array = size_array;
  2c07bf:	48 8b 05 4a 18 00 00 	mov    0x184a(%rip),%rax        # 2c2010 <size_array>
  2c07c6:	48 89 47 08          	mov    %rax,0x8(%rdi)
    info->ptr_array = ptr_array;
  2c07ca:	48 8b 05 37 18 00 00 	mov    0x1837(%rip),%rax        # 2c2008 <ptr_array>
  2c07d1:	48 89 47 10          	mov    %rax,0x10(%rdi)
    return 0;
}
  2c07d5:	b8 00 00 00 00       	mov    $0x0,%eax
  2c07da:	c3                   	ret    

00000000002c07db <_quicksort>:
typedef int (*__compar_fn_t) (const void *, const void *);

void
_quicksort (void *const pbase, size_t total_elems, size_t size,
            __compar_fn_t cmp)
{
  2c07db:	f3 0f 1e fa          	endbr64 
  2c07df:	55                   	push   %rbp
  2c07e0:	48 89 e5             	mov    %rsp,%rbp
  2c07e3:	41 57                	push   %r15
  2c07e5:	41 56                	push   %r14
  2c07e7:	41 55                	push   %r13
  2c07e9:	41 54                	push   %r12
  2c07eb:	53                   	push   %rbx
  2c07ec:	48 81 ec 48 04 00 00 	sub    $0x448,%rsp
  2c07f3:	48 89 bd a0 fb ff ff 	mov    %rdi,-0x460(%rbp)
  2c07fa:	48 89 b5 98 fb ff ff 	mov    %rsi,-0x468(%rbp)
  2c0801:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
    char *base_ptr = (char *) pbase;
    const size_t max_thresh = MAX_THRESH * size;
    if (total_elems == 0)
  2c0808:	48 85 f6             	test   %rsi,%rsi
  2c080b:	0f 84 94 03 00 00    	je     2c0ba5 <_quicksort+0x3ca>
  2c0811:	48 89 f0             	mov    %rsi,%rax
  2c0814:	48 89 cb             	mov    %rcx,%rbx
    const size_t max_thresh = MAX_THRESH * size;
  2c0817:	48 8d 0c 95 00 00 00 	lea    0x0(,%rdx,4),%rcx
  2c081e:	00 
  2c081f:	48 89 8d a8 fb ff ff 	mov    %rcx,-0x458(%rbp)
	/* Avoid lossage with unsigned arithmetic below.  */
	return;
    if (total_elems > MAX_THRESH)
  2c0826:	48 83 fe 04          	cmp    $0x4,%rsi
  2c082a:	0f 86 bd 02 00 00    	jbe    2c0aed <_quicksort+0x312>
    {
	char *lo = base_ptr;
	char *hi = &lo[size * (total_elems - 1)];
  2c0830:	48 83 e8 01          	sub    $0x1,%rax
  2c0834:	48 0f af c2          	imul   %rdx,%rax
  2c0838:	48 01 f8             	add    %rdi,%rax
  2c083b:	48 89 85 c0 fb ff ff 	mov    %rax,-0x440(%rbp)
	stack_node stack[STACK_SIZE];
	stack_node *top = stack;
	PUSH (NULL, NULL);
  2c0842:	48 c7 85 d0 fb ff ff 	movq   $0x0,-0x430(%rbp)
  2c0849:	00 00 00 00 
  2c084d:	48 c7 85 d8 fb ff ff 	movq   $0x0,-0x428(%rbp)
  2c0854:	00 00 00 00 
	char *lo = base_ptr;
  2c0858:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
	PUSH (NULL, NULL);
  2c085f:	48 8d 85 e0 fb ff ff 	lea    -0x420(%rbp),%rax
  2c0866:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
		goto jump_over;
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
		SWAP (mid, lo, size);
jump_over:;
	  left_ptr  = lo + size;
	  right_ptr = hi - size;
  2c086d:	48 f7 da             	neg    %rdx
  2c0870:	49 89 d7             	mov    %rdx,%r15
  2c0873:	e9 8c 01 00 00       	jmp    2c0a04 <_quicksort+0x229>
  2c0878:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c087f:	49 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%rdi
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c0884:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  2c088b:	4c 89 e8             	mov    %r13,%rax
  2c088e:	0f b6 08             	movzbl (%rax),%ecx
  2c0891:	48 83 c0 01          	add    $0x1,%rax
  2c0895:	0f b6 32             	movzbl (%rdx),%esi
  2c0898:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c089c:	48 83 c2 01          	add    $0x1,%rdx
  2c08a0:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c08a3:	48 39 c7             	cmp    %rax,%rdi
  2c08a6:	75 e6                	jne    2c088e <_quicksort+0xb3>
  2c08a8:	e9 92 01 00 00       	jmp    2c0a3f <_quicksort+0x264>
  2c08ad:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c08b4:	4d 8d 64 05 00       	lea    0x0(%r13,%rax,1),%r12
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  2c08b9:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
		SWAP (mid, hi, size);
  2c08c0:	4c 89 e8             	mov    %r13,%rax
  2c08c3:	0f b6 08             	movzbl (%rax),%ecx
  2c08c6:	48 83 c0 01          	add    $0x1,%rax
  2c08ca:	0f b6 32             	movzbl (%rdx),%esi
  2c08cd:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c08d1:	48 83 c2 01          	add    $0x1,%rdx
  2c08d5:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c08d8:	49 39 c4             	cmp    %rax,%r12
  2c08db:	75 e6                	jne    2c08c3 <_quicksort+0xe8>
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c08dd:	48 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%rsi
  2c08e4:	4c 89 ef             	mov    %r13,%rdi
  2c08e7:	ff d3                	call   *%rbx
  2c08e9:	85 c0                	test   %eax,%eax
  2c08eb:	0f 89 62 01 00 00    	jns    2c0a53 <_quicksort+0x278>
  2c08f1:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  2c08f8:	4c 89 e8             	mov    %r13,%rax
  2c08fb:	0f b6 08             	movzbl (%rax),%ecx
  2c08fe:	48 83 c0 01          	add    $0x1,%rax
  2c0902:	0f b6 32             	movzbl (%rdx),%esi
  2c0905:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c0909:	48 83 c2 01          	add    $0x1,%rdx
  2c090d:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c0910:	49 39 c4             	cmp    %rax,%r12
  2c0913:	75 e6                	jne    2c08fb <_quicksort+0x120>
jump_over:;
  2c0915:	e9 39 01 00 00       	jmp    2c0a53 <_quicksort+0x278>
	  do
	  {
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
		  left_ptr += size;
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
		  right_ptr -= size;
  2c091a:	4d 01 fc             	add    %r15,%r12
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
  2c091d:	4c 89 e6             	mov    %r12,%rsi
  2c0920:	4c 89 ef             	mov    %r13,%rdi
  2c0923:	ff d3                	call   *%rbx
  2c0925:	85 c0                	test   %eax,%eax
  2c0927:	78 f1                	js     2c091a <_quicksort+0x13f>
	      if (left_ptr < right_ptr)
  2c0929:	4d 39 e6             	cmp    %r12,%r14
  2c092c:	72 1c                	jb     2c094a <_quicksort+0x16f>
		  else if (mid == right_ptr)
		      mid = left_ptr;
		  left_ptr += size;
		  right_ptr -= size;
	      }
	      else if (left_ptr == right_ptr)
  2c092e:	74 5e                	je     2c098e <_quicksort+0x1b3>
		  left_ptr += size;
		  right_ptr -= size;
		  break;
	      }
	  }
	  while (left_ptr <= right_ptr);
  2c0930:	4d 39 e6             	cmp    %r12,%r14
  2c0933:	77 63                	ja     2c0998 <_quicksort+0x1bd>
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
  2c0935:	4c 89 ee             	mov    %r13,%rsi
  2c0938:	4c 89 f7             	mov    %r14,%rdi
  2c093b:	ff d3                	call   *%rbx
  2c093d:	85 c0                	test   %eax,%eax
  2c093f:	79 dc                	jns    2c091d <_quicksort+0x142>
		  left_ptr += size;
  2c0941:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  2c0948:	eb eb                	jmp    2c0935 <_quicksort+0x15a>
  2c094a:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0951:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
	      if (left_ptr < right_ptr)
  2c0955:	4c 89 e2             	mov    %r12,%rdx
  2c0958:	4c 89 f0             	mov    %r14,%rax
		  SWAP (left_ptr, right_ptr, size);
  2c095b:	0f b6 08             	movzbl (%rax),%ecx
  2c095e:	48 83 c0 01          	add    $0x1,%rax
  2c0962:	0f b6 32             	movzbl (%rdx),%esi
  2c0965:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c0969:	48 83 c2 01          	add    $0x1,%rdx
  2c096d:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c0970:	48 39 f8             	cmp    %rdi,%rax
  2c0973:	75 e6                	jne    2c095b <_quicksort+0x180>
		  if (mid == left_ptr)
  2c0975:	4d 39 ee             	cmp    %r13,%r14
  2c0978:	74 0f                	je     2c0989 <_quicksort+0x1ae>
		  else if (mid == right_ptr)
  2c097a:	4d 39 ec             	cmp    %r13,%r12
  2c097d:	4d 0f 44 ee          	cmove  %r14,%r13
		  right_ptr -= size;
  2c0981:	4d 01 fc             	add    %r15,%r12
		  left_ptr += size;
  2c0984:	49 89 fe             	mov    %rdi,%r14
  2c0987:	eb a7                	jmp    2c0930 <_quicksort+0x155>
  2c0989:	4d 89 e5             	mov    %r12,%r13
  2c098c:	eb f3                	jmp    2c0981 <_quicksort+0x1a6>
		  left_ptr += size;
  2c098e:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
		  right_ptr -= size;
  2c0995:	4d 01 fc             	add    %r15,%r12
	  /* Set up pointers for next iteration.  First determine whether
	     left and right partitions are below the threshold size.  If so,
	     ignore one or both.  Otherwise, push the larger partition's
	     bounds on the stack and continue sorting the smaller one. */
	  if ((size_t) (right_ptr - lo) <= max_thresh)
  2c0998:	4c 89 e0             	mov    %r12,%rax
  2c099b:	48 2b 85 b8 fb ff ff 	sub    -0x448(%rbp),%rax
  2c09a2:	48 8b bd a8 fb ff ff 	mov    -0x458(%rbp),%rdi
  2c09a9:	48 39 f8             	cmp    %rdi,%rax
  2c09ac:	0f 87 bf 00 00 00    	ja     2c0a71 <_quicksort+0x296>
	  {
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  2c09b2:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c09b9:	4c 29 f0             	sub    %r14,%rax
		  /* Ignore both small partitions. */
		  POP (lo, hi);
	      else
		  /* Ignore small left partition. */
		  lo = left_ptr;
  2c09bc:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  2c09c3:	48 39 f8             	cmp    %rdi,%rax
  2c09c6:	77 28                	ja     2c09f0 <_quicksort+0x215>
		  POP (lo, hi);
  2c09c8:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c09cf:	48 8b 78 f0          	mov    -0x10(%rax),%rdi
  2c09d3:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
  2c09da:	48 8b 78 f8          	mov    -0x8(%rax),%rdi
  2c09de:	48 89 bd c0 fb ff ff 	mov    %rdi,-0x440(%rbp)
  2c09e5:	48 8d 40 f0          	lea    -0x10(%rax),%rax
  2c09e9:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	while (STACK_NOT_EMPTY)
  2c09f0:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  2c09f7:	48 39 85 b0 fb ff ff 	cmp    %rax,-0x450(%rbp)
  2c09fe:	0f 86 e9 00 00 00    	jbe    2c0aed <_quicksort+0x312>
	    char *mid = lo + size * ((hi - lo) / size >> 1);
  2c0a04:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c0a0b:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  2c0a12:	48 29 f8             	sub    %rdi,%rax
  2c0a15:	48 8b 8d c8 fb ff ff 	mov    -0x438(%rbp),%rcx
  2c0a1c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0a21:	48 f7 f1             	div    %rcx
  2c0a24:	48 d1 e8             	shr    %rax
  2c0a27:	48 0f af c1          	imul   %rcx,%rax
  2c0a2b:	4c 8d 2c 07          	lea    (%rdi,%rax,1),%r13
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c0a2f:	48 89 fe             	mov    %rdi,%rsi
  2c0a32:	4c 89 ef             	mov    %r13,%rdi
  2c0a35:	ff d3                	call   *%rbx
  2c0a37:	85 c0                	test   %eax,%eax
  2c0a39:	0f 88 39 fe ff ff    	js     2c0878 <_quicksort+0x9d>
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  2c0a3f:	4c 89 ee             	mov    %r13,%rsi
  2c0a42:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  2c0a49:	ff d3                	call   *%rbx
  2c0a4b:	85 c0                	test   %eax,%eax
  2c0a4d:	0f 88 5a fe ff ff    	js     2c08ad <_quicksort+0xd2>
	  left_ptr  = lo + size;
  2c0a53:	4c 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%r14
  2c0a5a:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
	  right_ptr = hi - size;
  2c0a61:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c0a68:	4e 8d 24 38          	lea    (%rax,%r15,1),%r12
  2c0a6c:	e9 c4 fe ff ff       	jmp    2c0935 <_quicksort+0x15a>
	  }
	  else if ((size_t) (hi - left_ptr) <= max_thresh)
  2c0a71:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
  2c0a78:	4c 29 f2             	sub    %r14,%rdx
  2c0a7b:	48 3b 95 a8 fb ff ff 	cmp    -0x458(%rbp),%rdx
  2c0a82:	76 5d                	jbe    2c0ae1 <_quicksort+0x306>
	      /* Ignore small right partition. */
	      hi = right_ptr;
	  else if ((right_ptr - lo) > (hi - left_ptr))
  2c0a84:	48 39 d0             	cmp    %rdx,%rax
  2c0a87:	7e 2c                	jle    2c0ab5 <_quicksort+0x2da>
	  {
	      /* Push larger left partition indices. */
	      PUSH (lo, right_ptr);
  2c0a89:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c0a90:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  2c0a97:	48 89 38             	mov    %rdi,(%rax)
  2c0a9a:	4c 89 60 08          	mov    %r12,0x8(%rax)
  2c0a9e:	48 83 c0 10          	add    $0x10,%rax
  2c0aa2:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      lo = left_ptr;
  2c0aa9:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
  2c0ab0:	e9 3b ff ff ff       	jmp    2c09f0 <_quicksort+0x215>
	  }
	  else
	  {
	      /* Push larger right partition indices. */
	      PUSH (left_ptr, hi);
  2c0ab5:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c0abc:	4c 89 30             	mov    %r14,(%rax)
  2c0abf:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  2c0ac6:	48 89 78 08          	mov    %rdi,0x8(%rax)
  2c0aca:	48 83 c0 10          	add    $0x10,%rax
  2c0ace:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      hi = right_ptr;
  2c0ad5:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  2c0adc:	e9 0f ff ff ff       	jmp    2c09f0 <_quicksort+0x215>
	      hi = right_ptr;
  2c0ae1:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  2c0ae8:	e9 03 ff ff ff       	jmp    2c09f0 <_quicksort+0x215>
       for partitions below MAX_THRESH size. BASE_PTR points to the beginning
       of the array to sort, and END_PTR points at the very last element in
       the array (*not* one beyond it!). */
#define min(x, y) ((x) < (y) ? (x) : (y))
    {
	char *const end_ptr = &base_ptr[size * (total_elems - 1)];
  2c0aed:	4c 8b bd 98 fb ff ff 	mov    -0x468(%rbp),%r15
  2c0af4:	49 83 ef 01          	sub    $0x1,%r15
  2c0af8:	48 8b bd c8 fb ff ff 	mov    -0x438(%rbp),%rdi
  2c0aff:	4c 0f af ff          	imul   %rdi,%r15
  2c0b03:	4c 8b ad a0 fb ff ff 	mov    -0x460(%rbp),%r13
  2c0b0a:	4d 01 ef             	add    %r13,%r15
	char *tmp_ptr = base_ptr;
	char *thresh = min(end_ptr, base_ptr + max_thresh);
  2c0b0d:	48 8b 85 a8 fb ff ff 	mov    -0x458(%rbp),%rax
  2c0b14:	4c 01 e8             	add    %r13,%rax
  2c0b17:	49 39 c7             	cmp    %rax,%r15
  2c0b1a:	49 0f 46 c7          	cmovbe %r15,%rax
	char *run_ptr;
	/* Find smallest element in first threshold and place it at the
	   array's beginning.  This is the smallest array element,
	   and the operation speeds up insertion sort's inner loop. */
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  2c0b1e:	4d 89 ec             	mov    %r13,%r12
  2c0b21:	49 01 fc             	add    %rdi,%r12
  2c0b24:	4c 39 e0             	cmp    %r12,%rax
  2c0b27:	72 66                	jb     2c0b8f <_quicksort+0x3b4>
  2c0b29:	4d 89 e6             	mov    %r12,%r14
	char *tmp_ptr = base_ptr;
  2c0b2c:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  2c0b33:	49 89 c4             	mov    %rax,%r12
	    if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c0b36:	4c 89 ee             	mov    %r13,%rsi
  2c0b39:	4c 89 f7             	mov    %r14,%rdi
  2c0b3c:	ff d3                	call   *%rbx
  2c0b3e:	85 c0                	test   %eax,%eax
  2c0b40:	4d 0f 48 ee          	cmovs  %r14,%r13
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  2c0b44:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  2c0b4b:	4d 39 f4             	cmp    %r14,%r12
  2c0b4e:	73 e6                	jae    2c0b36 <_quicksort+0x35b>
  2c0b50:	4c 8b a5 c0 fb ff ff 	mov    -0x440(%rbp),%r12
		tmp_ptr = run_ptr;
	if (tmp_ptr != base_ptr)
  2c0b57:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0b5e:	49 8d 4c 05 00       	lea    0x0(%r13,%rax,1),%rcx
  2c0b63:	48 8b 85 a0 fb ff ff 	mov    -0x460(%rbp),%rax
  2c0b6a:	4c 3b ad a0 fb ff ff 	cmp    -0x460(%rbp),%r13
  2c0b71:	74 1c                	je     2c0b8f <_quicksort+0x3b4>
	    SWAP (tmp_ptr, base_ptr, size);
  2c0b73:	41 0f b6 55 00       	movzbl 0x0(%r13),%edx
  2c0b78:	49 83 c5 01          	add    $0x1,%r13
  2c0b7c:	0f b6 30             	movzbl (%rax),%esi
  2c0b7f:	41 88 75 ff          	mov    %sil,-0x1(%r13)
  2c0b83:	48 83 c0 01          	add    $0x1,%rax
  2c0b87:	88 50 ff             	mov    %dl,-0x1(%rax)
  2c0b8a:	49 39 cd             	cmp    %rcx,%r13
  2c0b8d:	75 e4                	jne    2c0b73 <_quicksort+0x398>
	/* Insertion sort, running from left-hand-side up to right-hand-side.  */
	run_ptr = base_ptr + size;
	while ((run_ptr += size) <= end_ptr)
  2c0b8f:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0b96:	4d 8d 34 04          	lea    (%r12,%rax,1),%r14
	{
	    tmp_ptr = run_ptr - size;
  2c0b9a:	48 f7 d8             	neg    %rax
  2c0b9d:	49 89 c5             	mov    %rax,%r13
	while ((run_ptr += size) <= end_ptr)
  2c0ba0:	4d 39 f7             	cmp    %r14,%r15
  2c0ba3:	73 15                	jae    2c0bba <_quicksort+0x3df>
		    *hi = c;
		}
	    }
	}
    }
}
  2c0ba5:	48 81 c4 48 04 00 00 	add    $0x448,%rsp
  2c0bac:	5b                   	pop    %rbx
  2c0bad:	41 5c                	pop    %r12
  2c0baf:	41 5d                	pop    %r13
  2c0bb1:	41 5e                	pop    %r14
  2c0bb3:	41 5f                	pop    %r15
  2c0bb5:	5d                   	pop    %rbp
  2c0bb6:	c3                   	ret    
		tmp_ptr -= size;
  2c0bb7:	4d 01 ec             	add    %r13,%r12
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c0bba:	4c 89 e6             	mov    %r12,%rsi
  2c0bbd:	4c 89 f7             	mov    %r14,%rdi
  2c0bc0:	ff d3                	call   *%rbx
  2c0bc2:	85 c0                	test   %eax,%eax
  2c0bc4:	78 f1                	js     2c0bb7 <_quicksort+0x3dc>
	    tmp_ptr += size;
  2c0bc6:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0bcd:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
	    if (tmp_ptr != run_ptr)
  2c0bd1:	4c 39 f6             	cmp    %r14,%rsi
  2c0bd4:	75 17                	jne    2c0bed <_quicksort+0x412>
	while ((run_ptr += size) <= end_ptr)
  2c0bd6:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0bdd:	4c 01 f0             	add    %r14,%rax
  2c0be0:	4d 89 f4             	mov    %r14,%r12
  2c0be3:	49 39 c7             	cmp    %rax,%r15
  2c0be6:	72 bd                	jb     2c0ba5 <_quicksort+0x3ca>
  2c0be8:	49 89 c6             	mov    %rax,%r14
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c0beb:	eb cd                	jmp    2c0bba <_quicksort+0x3df>
		while (--trav >= run_ptr)
  2c0bed:	49 8d 7c 06 ff       	lea    -0x1(%r14,%rax,1),%rdi
  2c0bf2:	4c 39 f7             	cmp    %r14,%rdi
  2c0bf5:	72 df                	jb     2c0bd6 <_quicksort+0x3fb>
  2c0bf7:	4d 8d 46 ff          	lea    -0x1(%r14),%r8
  2c0bfb:	4d 89 c2             	mov    %r8,%r10
  2c0bfe:	eb 13                	jmp    2c0c13 <_quicksort+0x438>
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c0c00:	48 89 f9             	mov    %rdi,%rcx
		    *hi = c;
  2c0c03:	44 88 09             	mov    %r9b,(%rcx)
		while (--trav >= run_ptr)
  2c0c06:	48 83 ef 01          	sub    $0x1,%rdi
  2c0c0a:	49 83 e8 01          	sub    $0x1,%r8
  2c0c0e:	49 39 fa             	cmp    %rdi,%r10
  2c0c11:	74 c3                	je     2c0bd6 <_quicksort+0x3fb>
		    char c = *trav;
  2c0c13:	44 0f b6 0f          	movzbl (%rdi),%r9d
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c0c17:	4c 89 c0             	mov    %r8,%rax
  2c0c1a:	4c 39 c6             	cmp    %r8,%rsi
  2c0c1d:	77 e1                	ja     2c0c00 <_quicksort+0x425>
  2c0c1f:	48 89 fa             	mov    %rdi,%rdx
			*hi = *lo;
  2c0c22:	0f b6 08             	movzbl (%rax),%ecx
  2c0c25:	88 0a                	mov    %cl,(%rdx)
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c0c27:	48 89 c1             	mov    %rax,%rcx
  2c0c2a:	4c 01 e8             	add    %r13,%rax
  2c0c2d:	48 2b 95 c8 fb ff ff 	sub    -0x438(%rbp),%rdx
  2c0c34:	48 39 c6             	cmp    %rax,%rsi
  2c0c37:	76 e9                	jbe    2c0c22 <_quicksort+0x447>
  2c0c39:	eb c8                	jmp    2c0c03 <_quicksort+0x428>

00000000002c0c3b <ptr_comparator>:

int ptr_comparator( const void * a, const void * b){
  2c0c3b:	f3 0f 1e fa          	endbr64 
    ptr_with_size * a_ptr = (ptr_with_size *) a;
    ptr_with_size * b_ptr = (ptr_with_size *) b;

    return (int)b_ptr->size - (int)a_ptr->size;
  2c0c3f:	48 8b 46 08          	mov    0x8(%rsi),%rax
  2c0c43:	2b 47 08             	sub    0x8(%rdi),%eax
  2c0c46:	c3                   	ret    

00000000002c0c47 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0c47:	f3 0f 1e fa          	endbr64 
  2c0c4b:	55                   	push   %rbp
  2c0c4c:	48 89 e5             	mov    %rsp,%rbp
  2c0c4f:	48 83 ec 28          	sub    $0x28,%rsp
  2c0c53:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0c57:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0c5b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0c5f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0c63:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0c67:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0c6b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0c6f:	eb 1c                	jmp    2c0c8d <memcpy+0x46>
        *d = *s;
  2c0c71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c75:	0f b6 10             	movzbl (%rax),%edx
  2c0c78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c7c:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0c7e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0c83:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0c88:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0c8d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0c92:	75 dd                	jne    2c0c71 <memcpy+0x2a>
    }
    return dst;
  2c0c94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0c98:	c9                   	leave  
  2c0c99:	c3                   	ret    

00000000002c0c9a <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0c9a:	f3 0f 1e fa          	endbr64 
  2c0c9e:	55                   	push   %rbp
  2c0c9f:	48 89 e5             	mov    %rsp,%rbp
  2c0ca2:	48 83 ec 28          	sub    $0x28,%rsp
  2c0ca6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0caa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0cae:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0cb2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0cb6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0cba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0cbe:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0cc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0cc6:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0cca:	73 6a                	jae    2c0d36 <memmove+0x9c>
  2c0ccc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0cd0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0cd4:	48 01 d0             	add    %rdx,%rax
  2c0cd7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0cdb:	73 59                	jae    2c0d36 <memmove+0x9c>
        s += n, d += n;
  2c0cdd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0ce1:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0ce5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0ce9:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0ced:	eb 17                	jmp    2c0d06 <memmove+0x6c>
            *--d = *--s;
  2c0cef:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0cf4:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0cf9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0cfd:	0f b6 10             	movzbl (%rax),%edx
  2c0d00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0d04:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0d06:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0d0a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0d0e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0d12:	48 85 c0             	test   %rax,%rax
  2c0d15:	75 d8                	jne    2c0cef <memmove+0x55>
    if (s < d && s + n > d) {
  2c0d17:	eb 2e                	jmp    2c0d47 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0d19:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0d1d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0d21:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0d25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0d29:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0d2d:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0d31:	0f b6 12             	movzbl (%rdx),%edx
  2c0d34:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0d36:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0d3a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0d3e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0d42:	48 85 c0             	test   %rax,%rax
  2c0d45:	75 d2                	jne    2c0d19 <memmove+0x7f>
        }
    }
    return dst;
  2c0d47:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0d4b:	c9                   	leave  
  2c0d4c:	c3                   	ret    

00000000002c0d4d <memset>:

void* memset(void* v, int c, size_t n) {
  2c0d4d:	f3 0f 1e fa          	endbr64 
  2c0d51:	55                   	push   %rbp
  2c0d52:	48 89 e5             	mov    %rsp,%rbp
  2c0d55:	48 83 ec 28          	sub    $0x28,%rsp
  2c0d59:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0d5d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0d60:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0d64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0d68:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0d6c:	eb 15                	jmp    2c0d83 <memset+0x36>
        *p = c;
  2c0d6e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0d71:	89 c2                	mov    %eax,%edx
  2c0d73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0d77:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0d79:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0d7e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0d83:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0d88:	75 e4                	jne    2c0d6e <memset+0x21>
    }
    return v;
  2c0d8a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0d8e:	c9                   	leave  
  2c0d8f:	c3                   	ret    

00000000002c0d90 <strlen>:

size_t strlen(const char* s) {
  2c0d90:	f3 0f 1e fa          	endbr64 
  2c0d94:	55                   	push   %rbp
  2c0d95:	48 89 e5             	mov    %rsp,%rbp
  2c0d98:	48 83 ec 18          	sub    $0x18,%rsp
  2c0d9c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0da0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0da7:	00 
  2c0da8:	eb 0a                	jmp    2c0db4 <strlen+0x24>
        ++n;
  2c0daa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0daf:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0db4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0db8:	0f b6 00             	movzbl (%rax),%eax
  2c0dbb:	84 c0                	test   %al,%al
  2c0dbd:	75 eb                	jne    2c0daa <strlen+0x1a>
    }
    return n;
  2c0dbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0dc3:	c9                   	leave  
  2c0dc4:	c3                   	ret    

00000000002c0dc5 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0dc5:	f3 0f 1e fa          	endbr64 
  2c0dc9:	55                   	push   %rbp
  2c0dca:	48 89 e5             	mov    %rsp,%rbp
  2c0dcd:	48 83 ec 20          	sub    $0x20,%rsp
  2c0dd1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0dd5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0dd9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0de0:	00 
  2c0de1:	eb 0a                	jmp    2c0ded <strnlen+0x28>
        ++n;
  2c0de3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0de8:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0ded:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0df1:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0df5:	74 0b                	je     2c0e02 <strnlen+0x3d>
  2c0df7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0dfb:	0f b6 00             	movzbl (%rax),%eax
  2c0dfe:	84 c0                	test   %al,%al
  2c0e00:	75 e1                	jne    2c0de3 <strnlen+0x1e>
    }
    return n;
  2c0e02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0e06:	c9                   	leave  
  2c0e07:	c3                   	ret    

00000000002c0e08 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0e08:	f3 0f 1e fa          	endbr64 
  2c0e0c:	55                   	push   %rbp
  2c0e0d:	48 89 e5             	mov    %rsp,%rbp
  2c0e10:	48 83 ec 20          	sub    $0x20,%rsp
  2c0e14:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0e18:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0e1c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0e20:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0e24:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0e28:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0e2c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0e30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0e34:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0e38:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0e3c:	0f b6 12             	movzbl (%rdx),%edx
  2c0e3f:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0e41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0e45:	48 83 e8 01          	sub    $0x1,%rax
  2c0e49:	0f b6 00             	movzbl (%rax),%eax
  2c0e4c:	84 c0                	test   %al,%al
  2c0e4e:	75 d4                	jne    2c0e24 <strcpy+0x1c>
    return dst;
  2c0e50:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0e54:	c9                   	leave  
  2c0e55:	c3                   	ret    

00000000002c0e56 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0e56:	f3 0f 1e fa          	endbr64 
  2c0e5a:	55                   	push   %rbp
  2c0e5b:	48 89 e5             	mov    %rsp,%rbp
  2c0e5e:	48 83 ec 10          	sub    $0x10,%rsp
  2c0e62:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0e66:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0e6a:	eb 0a                	jmp    2c0e76 <strcmp+0x20>
        ++a, ++b;
  2c0e6c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0e71:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0e76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0e7a:	0f b6 00             	movzbl (%rax),%eax
  2c0e7d:	84 c0                	test   %al,%al
  2c0e7f:	74 1d                	je     2c0e9e <strcmp+0x48>
  2c0e81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0e85:	0f b6 00             	movzbl (%rax),%eax
  2c0e88:	84 c0                	test   %al,%al
  2c0e8a:	74 12                	je     2c0e9e <strcmp+0x48>
  2c0e8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0e90:	0f b6 10             	movzbl (%rax),%edx
  2c0e93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0e97:	0f b6 00             	movzbl (%rax),%eax
  2c0e9a:	38 c2                	cmp    %al,%dl
  2c0e9c:	74 ce                	je     2c0e6c <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0e9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ea2:	0f b6 00             	movzbl (%rax),%eax
  2c0ea5:	89 c2                	mov    %eax,%edx
  2c0ea7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0eab:	0f b6 00             	movzbl (%rax),%eax
  2c0eae:	38 c2                	cmp    %al,%dl
  2c0eb0:	0f 97 c0             	seta   %al
  2c0eb3:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0eb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0eba:	0f b6 00             	movzbl (%rax),%eax
  2c0ebd:	89 c1                	mov    %eax,%ecx
  2c0ebf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0ec3:	0f b6 00             	movzbl (%rax),%eax
  2c0ec6:	38 c1                	cmp    %al,%cl
  2c0ec8:	0f 92 c0             	setb   %al
  2c0ecb:	0f b6 c8             	movzbl %al,%ecx
  2c0ece:	89 d0                	mov    %edx,%eax
  2c0ed0:	29 c8                	sub    %ecx,%eax
}
  2c0ed2:	c9                   	leave  
  2c0ed3:	c3                   	ret    

00000000002c0ed4 <strchr>:

char* strchr(const char* s, int c) {
  2c0ed4:	f3 0f 1e fa          	endbr64 
  2c0ed8:	55                   	push   %rbp
  2c0ed9:	48 89 e5             	mov    %rsp,%rbp
  2c0edc:	48 83 ec 10          	sub    $0x10,%rsp
  2c0ee0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0ee4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0ee7:	eb 05                	jmp    2c0eee <strchr+0x1a>
        ++s;
  2c0ee9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0eee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ef2:	0f b6 00             	movzbl (%rax),%eax
  2c0ef5:	84 c0                	test   %al,%al
  2c0ef7:	74 0e                	je     2c0f07 <strchr+0x33>
  2c0ef9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0efd:	0f b6 00             	movzbl (%rax),%eax
  2c0f00:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0f03:	38 d0                	cmp    %dl,%al
  2c0f05:	75 e2                	jne    2c0ee9 <strchr+0x15>
    }
    if (*s == (char) c) {
  2c0f07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f0b:	0f b6 00             	movzbl (%rax),%eax
  2c0f0e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0f11:	38 d0                	cmp    %dl,%al
  2c0f13:	75 06                	jne    2c0f1b <strchr+0x47>
        return (char*) s;
  2c0f15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f19:	eb 05                	jmp    2c0f20 <strchr+0x4c>
    } else {
        return NULL;
  2c0f1b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0f20:	c9                   	leave  
  2c0f21:	c3                   	ret    

00000000002c0f22 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0f22:	f3 0f 1e fa          	endbr64 
  2c0f26:	55                   	push   %rbp
  2c0f27:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0f2a:	8b 05 00 11 00 00    	mov    0x1100(%rip),%eax        # 2c2030 <rand_seed_set>
  2c0f30:	85 c0                	test   %eax,%eax
  2c0f32:	75 0a                	jne    2c0f3e <rand+0x1c>
        srand(819234718U);
  2c0f34:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0f39:	e8 24 00 00 00       	call   2c0f62 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0f3e:	8b 05 f0 10 00 00    	mov    0x10f0(%rip),%eax        # 2c2034 <rand_seed>
  2c0f44:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0f4a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0f4f:	89 05 df 10 00 00    	mov    %eax,0x10df(%rip)        # 2c2034 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0f55:	8b 05 d9 10 00 00    	mov    0x10d9(%rip),%eax        # 2c2034 <rand_seed>
  2c0f5b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0f60:	5d                   	pop    %rbp
  2c0f61:	c3                   	ret    

00000000002c0f62 <srand>:

void srand(unsigned seed) {
  2c0f62:	f3 0f 1e fa          	endbr64 
  2c0f66:	55                   	push   %rbp
  2c0f67:	48 89 e5             	mov    %rsp,%rbp
  2c0f6a:	48 83 ec 08          	sub    $0x8,%rsp
  2c0f6e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0f71:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0f74:	89 05 ba 10 00 00    	mov    %eax,0x10ba(%rip)        # 2c2034 <rand_seed>
    rand_seed_set = 1;
  2c0f7a:	c7 05 ac 10 00 00 01 	movl   $0x1,0x10ac(%rip)        # 2c2030 <rand_seed_set>
  2c0f81:	00 00 00 
}
  2c0f84:	90                   	nop
  2c0f85:	c9                   	leave  
  2c0f86:	c3                   	ret    

00000000002c0f87 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0f87:	f3 0f 1e fa          	endbr64 
  2c0f8b:	55                   	push   %rbp
  2c0f8c:	48 89 e5             	mov    %rsp,%rbp
  2c0f8f:	48 83 ec 28          	sub    $0x28,%rsp
  2c0f93:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0f97:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0f9b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0f9e:	48 8d 05 9b 0f 00 00 	lea    0xf9b(%rip),%rax        # 2c1f40 <upper_digits.1>
  2c0fa5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  2c0fa9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c0fad:	79 0e                	jns    2c0fbd <fill_numbuf+0x36>
        digits = lower_digits;
  2c0faf:	48 8d 05 aa 0f 00 00 	lea    0xfaa(%rip),%rax        # 2c1f60 <lower_digits.0>
  2c0fb6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  2c0fba:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c0fbd:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0fc2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0fc6:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0fc9:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0fcc:	48 63 c8             	movslq %eax,%rcx
  2c0fcf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0fd3:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0fd8:	48 f7 f1             	div    %rcx
  2c0fdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0fdf:	48 01 d0             	add    %rdx,%rax
  2c0fe2:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0fe7:	0f b6 10             	movzbl (%rax),%edx
  2c0fea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0fee:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0ff0:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0ff3:	48 63 f0             	movslq %eax,%rsi
  2c0ff6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0ffa:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0fff:	48 f7 f6             	div    %rsi
  2c1002:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c1006:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c100b:	75 bc                	jne    2c0fc9 <fill_numbuf+0x42>
    return numbuf_end;
  2c100d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c1011:	c9                   	leave  
  2c1012:	c3                   	ret    

00000000002c1013 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c1013:	f3 0f 1e fa          	endbr64 
  2c1017:	55                   	push   %rbp
  2c1018:	48 89 e5             	mov    %rsp,%rbp
  2c101b:	53                   	push   %rbx
  2c101c:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c1023:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c102a:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c1030:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c1037:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c103e:	e9 bd 09 00 00       	jmp    2c1a00 <printer_vprintf+0x9ed>
        if (*format != '%') {
  2c1043:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c104a:	0f b6 00             	movzbl (%rax),%eax
  2c104d:	3c 25                	cmp    $0x25,%al
  2c104f:	74 31                	je     2c1082 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  2c1051:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1058:	4c 8b 00             	mov    (%rax),%r8
  2c105b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1062:	0f b6 00             	movzbl (%rax),%eax
  2c1065:	0f b6 c8             	movzbl %al,%ecx
  2c1068:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c106e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1075:	89 ce                	mov    %ecx,%esi
  2c1077:	48 89 c7             	mov    %rax,%rdi
  2c107a:	41 ff d0             	call   *%r8
            continue;
  2c107d:	e9 76 09 00 00       	jmp    2c19f8 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  2c1082:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c1089:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1090:	01 
  2c1091:	eb 4d                	jmp    2c10e0 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  2c1093:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c109a:	0f b6 00             	movzbl (%rax),%eax
  2c109d:	0f be c0             	movsbl %al,%eax
  2c10a0:	89 c6                	mov    %eax,%esi
  2c10a2:	48 8d 05 97 0d 00 00 	lea    0xd97(%rip),%rax        # 2c1e40 <flag_chars>
  2c10a9:	48 89 c7             	mov    %rax,%rdi
  2c10ac:	e8 23 fe ff ff       	call   2c0ed4 <strchr>
  2c10b1:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c10b5:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c10ba:	74 34                	je     2c10f0 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  2c10bc:	48 8d 15 7d 0d 00 00 	lea    0xd7d(%rip),%rdx        # 2c1e40 <flag_chars>
  2c10c3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c10c7:	48 29 d0             	sub    %rdx,%rax
  2c10ca:	ba 01 00 00 00       	mov    $0x1,%edx
  2c10cf:	89 c1                	mov    %eax,%ecx
  2c10d1:	d3 e2                	shl    %cl,%edx
  2c10d3:	89 d0                	mov    %edx,%eax
  2c10d5:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c10d8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c10df:	01 
  2c10e0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c10e7:	0f b6 00             	movzbl (%rax),%eax
  2c10ea:	84 c0                	test   %al,%al
  2c10ec:	75 a5                	jne    2c1093 <printer_vprintf+0x80>
  2c10ee:	eb 01                	jmp    2c10f1 <printer_vprintf+0xde>
            } else {
                break;
  2c10f0:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c10f1:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c10f8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c10ff:	0f b6 00             	movzbl (%rax),%eax
  2c1102:	3c 30                	cmp    $0x30,%al
  2c1104:	7e 67                	jle    2c116d <printer_vprintf+0x15a>
  2c1106:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c110d:	0f b6 00             	movzbl (%rax),%eax
  2c1110:	3c 39                	cmp    $0x39,%al
  2c1112:	7f 59                	jg     2c116d <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c1114:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c111b:	eb 2e                	jmp    2c114b <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  2c111d:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c1120:	89 d0                	mov    %edx,%eax
  2c1122:	c1 e0 02             	shl    $0x2,%eax
  2c1125:	01 d0                	add    %edx,%eax
  2c1127:	01 c0                	add    %eax,%eax
  2c1129:	89 c1                	mov    %eax,%ecx
  2c112b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1132:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c1136:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c113d:	0f b6 00             	movzbl (%rax),%eax
  2c1140:	0f be c0             	movsbl %al,%eax
  2c1143:	01 c8                	add    %ecx,%eax
  2c1145:	83 e8 30             	sub    $0x30,%eax
  2c1148:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c114b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1152:	0f b6 00             	movzbl (%rax),%eax
  2c1155:	3c 2f                	cmp    $0x2f,%al
  2c1157:	0f 8e 85 00 00 00    	jle    2c11e2 <printer_vprintf+0x1cf>
  2c115d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1164:	0f b6 00             	movzbl (%rax),%eax
  2c1167:	3c 39                	cmp    $0x39,%al
  2c1169:	7e b2                	jle    2c111d <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  2c116b:	eb 75                	jmp    2c11e2 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  2c116d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1174:	0f b6 00             	movzbl (%rax),%eax
  2c1177:	3c 2a                	cmp    $0x2a,%al
  2c1179:	75 68                	jne    2c11e3 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  2c117b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1182:	8b 00                	mov    (%rax),%eax
  2c1184:	83 f8 2f             	cmp    $0x2f,%eax
  2c1187:	77 30                	ja     2c11b9 <printer_vprintf+0x1a6>
  2c1189:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1190:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1194:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c119b:	8b 00                	mov    (%rax),%eax
  2c119d:	89 c0                	mov    %eax,%eax
  2c119f:	48 01 d0             	add    %rdx,%rax
  2c11a2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11a9:	8b 12                	mov    (%rdx),%edx
  2c11ab:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c11ae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11b5:	89 0a                	mov    %ecx,(%rdx)
  2c11b7:	eb 1a                	jmp    2c11d3 <printer_vprintf+0x1c0>
  2c11b9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11c0:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c11c4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c11c8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11cf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c11d3:	8b 00                	mov    (%rax),%eax
  2c11d5:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c11d8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c11df:	01 
  2c11e0:	eb 01                	jmp    2c11e3 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  2c11e2:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c11e3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c11ea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11f1:	0f b6 00             	movzbl (%rax),%eax
  2c11f4:	3c 2e                	cmp    $0x2e,%al
  2c11f6:	0f 85 00 01 00 00    	jne    2c12fc <printer_vprintf+0x2e9>
            ++format;
  2c11fc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1203:	01 
            if (*format >= '0' && *format <= '9') {
  2c1204:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c120b:	0f b6 00             	movzbl (%rax),%eax
  2c120e:	3c 2f                	cmp    $0x2f,%al
  2c1210:	7e 67                	jle    2c1279 <printer_vprintf+0x266>
  2c1212:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1219:	0f b6 00             	movzbl (%rax),%eax
  2c121c:	3c 39                	cmp    $0x39,%al
  2c121e:	7f 59                	jg     2c1279 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c1220:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c1227:	eb 2e                	jmp    2c1257 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  2c1229:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c122c:	89 d0                	mov    %edx,%eax
  2c122e:	c1 e0 02             	shl    $0x2,%eax
  2c1231:	01 d0                	add    %edx,%eax
  2c1233:	01 c0                	add    %eax,%eax
  2c1235:	89 c1                	mov    %eax,%ecx
  2c1237:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c123e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c1242:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c1249:	0f b6 00             	movzbl (%rax),%eax
  2c124c:	0f be c0             	movsbl %al,%eax
  2c124f:	01 c8                	add    %ecx,%eax
  2c1251:	83 e8 30             	sub    $0x30,%eax
  2c1254:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c1257:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c125e:	0f b6 00             	movzbl (%rax),%eax
  2c1261:	3c 2f                	cmp    $0x2f,%al
  2c1263:	0f 8e 85 00 00 00    	jle    2c12ee <printer_vprintf+0x2db>
  2c1269:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1270:	0f b6 00             	movzbl (%rax),%eax
  2c1273:	3c 39                	cmp    $0x39,%al
  2c1275:	7e b2                	jle    2c1229 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  2c1277:	eb 75                	jmp    2c12ee <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  2c1279:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1280:	0f b6 00             	movzbl (%rax),%eax
  2c1283:	3c 2a                	cmp    $0x2a,%al
  2c1285:	75 68                	jne    2c12ef <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  2c1287:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c128e:	8b 00                	mov    (%rax),%eax
  2c1290:	83 f8 2f             	cmp    $0x2f,%eax
  2c1293:	77 30                	ja     2c12c5 <printer_vprintf+0x2b2>
  2c1295:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c129c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c12a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12a7:	8b 00                	mov    (%rax),%eax
  2c12a9:	89 c0                	mov    %eax,%eax
  2c12ab:	48 01 d0             	add    %rdx,%rax
  2c12ae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12b5:	8b 12                	mov    (%rdx),%edx
  2c12b7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c12ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12c1:	89 0a                	mov    %ecx,(%rdx)
  2c12c3:	eb 1a                	jmp    2c12df <printer_vprintf+0x2cc>
  2c12c5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12cc:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c12d0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c12d4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12db:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c12df:	8b 00                	mov    (%rax),%eax
  2c12e1:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c12e4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c12eb:	01 
  2c12ec:	eb 01                	jmp    2c12ef <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  2c12ee:	90                   	nop
            }
            if (precision < 0) {
  2c12ef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c12f3:	79 07                	jns    2c12fc <printer_vprintf+0x2e9>
                precision = 0;
  2c12f5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c12fc:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c1303:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c130a:	00 
        int length = 0;
  2c130b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c1312:	48 8d 05 2d 0b 00 00 	lea    0xb2d(%rip),%rax        # 2c1e46 <flag_chars+0x6>
  2c1319:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  2c131d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1324:	0f b6 00             	movzbl (%rax),%eax
  2c1327:	0f be c0             	movsbl %al,%eax
  2c132a:	83 e8 43             	sub    $0x43,%eax
  2c132d:	83 f8 37             	cmp    $0x37,%eax
  2c1330:	0f 87 b6 03 00 00    	ja     2c16ec <printer_vprintf+0x6d9>
  2c1336:	89 c0                	mov    %eax,%eax
  2c1338:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  2c133f:	00 
  2c1340:	48 8d 05 0d 0b 00 00 	lea    0xb0d(%rip),%rax        # 2c1e54 <flag_chars+0x14>
  2c1347:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  2c134a:	48 98                	cltq   
  2c134c:	48 8d 15 01 0b 00 00 	lea    0xb01(%rip),%rdx        # 2c1e54 <flag_chars+0x14>
  2c1353:	48 01 d0             	add    %rdx,%rax
  2c1356:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  2c1359:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c1360:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1367:	01 
            goto again;
  2c1368:	eb b3                	jmp    2c131d <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c136a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c136e:	74 5d                	je     2c13cd <printer_vprintf+0x3ba>
  2c1370:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1377:	8b 00                	mov    (%rax),%eax
  2c1379:	83 f8 2f             	cmp    $0x2f,%eax
  2c137c:	77 30                	ja     2c13ae <printer_vprintf+0x39b>
  2c137e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1385:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1389:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1390:	8b 00                	mov    (%rax),%eax
  2c1392:	89 c0                	mov    %eax,%eax
  2c1394:	48 01 d0             	add    %rdx,%rax
  2c1397:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c139e:	8b 12                	mov    (%rdx),%edx
  2c13a0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c13a3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13aa:	89 0a                	mov    %ecx,(%rdx)
  2c13ac:	eb 1a                	jmp    2c13c8 <printer_vprintf+0x3b5>
  2c13ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13b5:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c13b9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c13bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13c4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c13c8:	48 8b 00             	mov    (%rax),%rax
  2c13cb:	eb 5c                	jmp    2c1429 <printer_vprintf+0x416>
  2c13cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13d4:	8b 00                	mov    (%rax),%eax
  2c13d6:	83 f8 2f             	cmp    $0x2f,%eax
  2c13d9:	77 30                	ja     2c140b <printer_vprintf+0x3f8>
  2c13db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13e2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c13e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13ed:	8b 00                	mov    (%rax),%eax
  2c13ef:	89 c0                	mov    %eax,%eax
  2c13f1:	48 01 d0             	add    %rdx,%rax
  2c13f4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13fb:	8b 12                	mov    (%rdx),%edx
  2c13fd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1400:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1407:	89 0a                	mov    %ecx,(%rdx)
  2c1409:	eb 1a                	jmp    2c1425 <printer_vprintf+0x412>
  2c140b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1412:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1416:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c141a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1421:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1425:	8b 00                	mov    (%rax),%eax
  2c1427:	48 98                	cltq   
  2c1429:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c142d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1431:	48 c1 f8 38          	sar    $0x38,%rax
  2c1435:	25 80 00 00 00       	and    $0x80,%eax
  2c143a:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c143d:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c1441:	74 09                	je     2c144c <printer_vprintf+0x439>
  2c1443:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1447:	48 f7 d8             	neg    %rax
  2c144a:	eb 04                	jmp    2c1450 <printer_vprintf+0x43d>
  2c144c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1450:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c1454:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c1457:	83 c8 60             	or     $0x60,%eax
  2c145a:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c145d:	e9 cf 02 00 00       	jmp    2c1731 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c1462:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c1466:	74 5d                	je     2c14c5 <printer_vprintf+0x4b2>
  2c1468:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c146f:	8b 00                	mov    (%rax),%eax
  2c1471:	83 f8 2f             	cmp    $0x2f,%eax
  2c1474:	77 30                	ja     2c14a6 <printer_vprintf+0x493>
  2c1476:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c147d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1481:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1488:	8b 00                	mov    (%rax),%eax
  2c148a:	89 c0                	mov    %eax,%eax
  2c148c:	48 01 d0             	add    %rdx,%rax
  2c148f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1496:	8b 12                	mov    (%rdx),%edx
  2c1498:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c149b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c14a2:	89 0a                	mov    %ecx,(%rdx)
  2c14a4:	eb 1a                	jmp    2c14c0 <printer_vprintf+0x4ad>
  2c14a6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14ad:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14b1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c14b5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c14bc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14c0:	48 8b 00             	mov    (%rax),%rax
  2c14c3:	eb 5c                	jmp    2c1521 <printer_vprintf+0x50e>
  2c14c5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14cc:	8b 00                	mov    (%rax),%eax
  2c14ce:	83 f8 2f             	cmp    $0x2f,%eax
  2c14d1:	77 30                	ja     2c1503 <printer_vprintf+0x4f0>
  2c14d3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14da:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c14de:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14e5:	8b 00                	mov    (%rax),%eax
  2c14e7:	89 c0                	mov    %eax,%eax
  2c14e9:	48 01 d0             	add    %rdx,%rax
  2c14ec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c14f3:	8b 12                	mov    (%rdx),%edx
  2c14f5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c14f8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c14ff:	89 0a                	mov    %ecx,(%rdx)
  2c1501:	eb 1a                	jmp    2c151d <printer_vprintf+0x50a>
  2c1503:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c150a:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c150e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1512:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1519:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c151d:	8b 00                	mov    (%rax),%eax
  2c151f:	89 c0                	mov    %eax,%eax
  2c1521:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c1525:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c1529:	e9 03 02 00 00       	jmp    2c1731 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  2c152e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c1535:	e9 28 ff ff ff       	jmp    2c1462 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  2c153a:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c1541:	e9 1c ff ff ff       	jmp    2c1462 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c1546:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c154d:	8b 00                	mov    (%rax),%eax
  2c154f:	83 f8 2f             	cmp    $0x2f,%eax
  2c1552:	77 30                	ja     2c1584 <printer_vprintf+0x571>
  2c1554:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c155b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c155f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1566:	8b 00                	mov    (%rax),%eax
  2c1568:	89 c0                	mov    %eax,%eax
  2c156a:	48 01 d0             	add    %rdx,%rax
  2c156d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1574:	8b 12                	mov    (%rdx),%edx
  2c1576:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1579:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1580:	89 0a                	mov    %ecx,(%rdx)
  2c1582:	eb 1a                	jmp    2c159e <printer_vprintf+0x58b>
  2c1584:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c158b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c158f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1593:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c159a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c159e:	48 8b 00             	mov    (%rax),%rax
  2c15a1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c15a5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c15ac:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c15b3:	e9 79 01 00 00       	jmp    2c1731 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  2c15b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15bf:	8b 00                	mov    (%rax),%eax
  2c15c1:	83 f8 2f             	cmp    $0x2f,%eax
  2c15c4:	77 30                	ja     2c15f6 <printer_vprintf+0x5e3>
  2c15c6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15cd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c15d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15d8:	8b 00                	mov    (%rax),%eax
  2c15da:	89 c0                	mov    %eax,%eax
  2c15dc:	48 01 d0             	add    %rdx,%rax
  2c15df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c15e6:	8b 12                	mov    (%rdx),%edx
  2c15e8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c15eb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c15f2:	89 0a                	mov    %ecx,(%rdx)
  2c15f4:	eb 1a                	jmp    2c1610 <printer_vprintf+0x5fd>
  2c15f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15fd:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1601:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1605:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c160c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1610:	48 8b 00             	mov    (%rax),%rax
  2c1613:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c1617:	e9 15 01 00 00       	jmp    2c1731 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  2c161c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1623:	8b 00                	mov    (%rax),%eax
  2c1625:	83 f8 2f             	cmp    $0x2f,%eax
  2c1628:	77 30                	ja     2c165a <printer_vprintf+0x647>
  2c162a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1631:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1635:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c163c:	8b 00                	mov    (%rax),%eax
  2c163e:	89 c0                	mov    %eax,%eax
  2c1640:	48 01 d0             	add    %rdx,%rax
  2c1643:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c164a:	8b 12                	mov    (%rdx),%edx
  2c164c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c164f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1656:	89 0a                	mov    %ecx,(%rdx)
  2c1658:	eb 1a                	jmp    2c1674 <printer_vprintf+0x661>
  2c165a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1661:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1665:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1669:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1670:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1674:	8b 00                	mov    (%rax),%eax
  2c1676:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c167c:	e9 77 03 00 00       	jmp    2c19f8 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  2c1681:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1685:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c1689:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1690:	8b 00                	mov    (%rax),%eax
  2c1692:	83 f8 2f             	cmp    $0x2f,%eax
  2c1695:	77 30                	ja     2c16c7 <printer_vprintf+0x6b4>
  2c1697:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c169e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c16a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16a9:	8b 00                	mov    (%rax),%eax
  2c16ab:	89 c0                	mov    %eax,%eax
  2c16ad:	48 01 d0             	add    %rdx,%rax
  2c16b0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16b7:	8b 12                	mov    (%rdx),%edx
  2c16b9:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c16bc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16c3:	89 0a                	mov    %ecx,(%rdx)
  2c16c5:	eb 1a                	jmp    2c16e1 <printer_vprintf+0x6ce>
  2c16c7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16ce:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c16d2:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c16d6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16dd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c16e1:	8b 00                	mov    (%rax),%eax
  2c16e3:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c16e6:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c16ea:	eb 45                	jmp    2c1731 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  2c16ec:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c16f0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c16f4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c16fb:	0f b6 00             	movzbl (%rax),%eax
  2c16fe:	84 c0                	test   %al,%al
  2c1700:	74 0c                	je     2c170e <printer_vprintf+0x6fb>
  2c1702:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1709:	0f b6 00             	movzbl (%rax),%eax
  2c170c:	eb 05                	jmp    2c1713 <printer_vprintf+0x700>
  2c170e:	b8 25 00 00 00       	mov    $0x25,%eax
  2c1713:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1716:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c171a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1721:	0f b6 00             	movzbl (%rax),%eax
  2c1724:	84 c0                	test   %al,%al
  2c1726:	75 08                	jne    2c1730 <printer_vprintf+0x71d>
                format--;
  2c1728:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c172f:	01 
            }
            break;
  2c1730:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c1731:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1734:	83 e0 20             	and    $0x20,%eax
  2c1737:	85 c0                	test   %eax,%eax
  2c1739:	74 1e                	je     2c1759 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c173b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c173f:	48 83 c0 18          	add    $0x18,%rax
  2c1743:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1746:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c174a:	48 89 ce             	mov    %rcx,%rsi
  2c174d:	48 89 c7             	mov    %rax,%rdi
  2c1750:	e8 32 f8 ff ff       	call   2c0f87 <fill_numbuf>
  2c1755:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c1759:	48 8d 05 e6 06 00 00 	lea    0x6e6(%rip),%rax        # 2c1e46 <flag_chars+0x6>
  2c1760:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c1764:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1767:	83 e0 20             	and    $0x20,%eax
  2c176a:	85 c0                	test   %eax,%eax
  2c176c:	74 51                	je     2c17bf <printer_vprintf+0x7ac>
  2c176e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1771:	83 e0 40             	and    $0x40,%eax
  2c1774:	85 c0                	test   %eax,%eax
  2c1776:	74 47                	je     2c17bf <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  2c1778:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c177b:	25 80 00 00 00       	and    $0x80,%eax
  2c1780:	85 c0                	test   %eax,%eax
  2c1782:	74 0d                	je     2c1791 <printer_vprintf+0x77e>
                prefix = "-";
  2c1784:	48 8d 05 bc 06 00 00 	lea    0x6bc(%rip),%rax        # 2c1e47 <flag_chars+0x7>
  2c178b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c178f:	eb 7d                	jmp    2c180e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c1791:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1794:	83 e0 10             	and    $0x10,%eax
  2c1797:	85 c0                	test   %eax,%eax
  2c1799:	74 0d                	je     2c17a8 <printer_vprintf+0x795>
                prefix = "+";
  2c179b:	48 8d 05 a7 06 00 00 	lea    0x6a7(%rip),%rax        # 2c1e49 <flag_chars+0x9>
  2c17a2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c17a6:	eb 66                	jmp    2c180e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c17a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c17ab:	83 e0 08             	and    $0x8,%eax
  2c17ae:	85 c0                	test   %eax,%eax
  2c17b0:	74 5c                	je     2c180e <printer_vprintf+0x7fb>
                prefix = " ";
  2c17b2:	48 8d 05 92 06 00 00 	lea    0x692(%rip),%rax        # 2c1e4b <flag_chars+0xb>
  2c17b9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c17bd:	eb 4f                	jmp    2c180e <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c17bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c17c2:	83 e0 20             	and    $0x20,%eax
  2c17c5:	85 c0                	test   %eax,%eax
  2c17c7:	74 46                	je     2c180f <printer_vprintf+0x7fc>
  2c17c9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c17cc:	83 e0 01             	and    $0x1,%eax
  2c17cf:	85 c0                	test   %eax,%eax
  2c17d1:	74 3c                	je     2c180f <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  2c17d3:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c17d7:	74 06                	je     2c17df <printer_vprintf+0x7cc>
  2c17d9:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c17dd:	75 30                	jne    2c180f <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  2c17df:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c17e4:	75 0c                	jne    2c17f2 <printer_vprintf+0x7df>
  2c17e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c17e9:	25 00 01 00 00       	and    $0x100,%eax
  2c17ee:	85 c0                	test   %eax,%eax
  2c17f0:	74 1d                	je     2c180f <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  2c17f2:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c17f6:	75 09                	jne    2c1801 <printer_vprintf+0x7ee>
  2c17f8:	48 8d 05 4e 06 00 00 	lea    0x64e(%rip),%rax        # 2c1e4d <flag_chars+0xd>
  2c17ff:	eb 07                	jmp    2c1808 <printer_vprintf+0x7f5>
  2c1801:	48 8d 05 48 06 00 00 	lea    0x648(%rip),%rax        # 2c1e50 <flag_chars+0x10>
  2c1808:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c180c:	eb 01                	jmp    2c180f <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  2c180e:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c180f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1813:	78 24                	js     2c1839 <printer_vprintf+0x826>
  2c1815:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1818:	83 e0 20             	and    $0x20,%eax
  2c181b:	85 c0                	test   %eax,%eax
  2c181d:	75 1a                	jne    2c1839 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  2c181f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1822:	48 63 d0             	movslq %eax,%rdx
  2c1825:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1829:	48 89 d6             	mov    %rdx,%rsi
  2c182c:	48 89 c7             	mov    %rax,%rdi
  2c182f:	e8 91 f5 ff ff       	call   2c0dc5 <strnlen>
  2c1834:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c1837:	eb 0f                	jmp    2c1848 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  2c1839:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c183d:	48 89 c7             	mov    %rax,%rdi
  2c1840:	e8 4b f5 ff ff       	call   2c0d90 <strlen>
  2c1845:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c1848:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c184b:	83 e0 20             	and    $0x20,%eax
  2c184e:	85 c0                	test   %eax,%eax
  2c1850:	74 20                	je     2c1872 <printer_vprintf+0x85f>
  2c1852:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1856:	78 1a                	js     2c1872 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  2c1858:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c185b:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c185e:	7e 08                	jle    2c1868 <printer_vprintf+0x855>
  2c1860:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1863:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1866:	eb 05                	jmp    2c186d <printer_vprintf+0x85a>
  2c1868:	b8 00 00 00 00       	mov    $0x0,%eax
  2c186d:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1870:	eb 5c                	jmp    2c18ce <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c1872:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1875:	83 e0 20             	and    $0x20,%eax
  2c1878:	85 c0                	test   %eax,%eax
  2c187a:	74 4b                	je     2c18c7 <printer_vprintf+0x8b4>
  2c187c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c187f:	83 e0 02             	and    $0x2,%eax
  2c1882:	85 c0                	test   %eax,%eax
  2c1884:	74 41                	je     2c18c7 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c1886:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1889:	83 e0 04             	and    $0x4,%eax
  2c188c:	85 c0                	test   %eax,%eax
  2c188e:	75 37                	jne    2c18c7 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  2c1890:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1894:	48 89 c7             	mov    %rax,%rdi
  2c1897:	e8 f4 f4 ff ff       	call   2c0d90 <strlen>
  2c189c:	89 c2                	mov    %eax,%edx
  2c189e:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c18a1:	01 d0                	add    %edx,%eax
  2c18a3:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c18a6:	7e 1f                	jle    2c18c7 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  2c18a8:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c18ab:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c18ae:	89 c3                	mov    %eax,%ebx
  2c18b0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c18b4:	48 89 c7             	mov    %rax,%rdi
  2c18b7:	e8 d4 f4 ff ff       	call   2c0d90 <strlen>
  2c18bc:	89 c2                	mov    %eax,%edx
  2c18be:	89 d8                	mov    %ebx,%eax
  2c18c0:	29 d0                	sub    %edx,%eax
  2c18c2:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c18c5:	eb 07                	jmp    2c18ce <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  2c18c7:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c18ce:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c18d1:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c18d4:	01 d0                	add    %edx,%eax
  2c18d6:	48 63 d8             	movslq %eax,%rbx
  2c18d9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c18dd:	48 89 c7             	mov    %rax,%rdi
  2c18e0:	e8 ab f4 ff ff       	call   2c0d90 <strlen>
  2c18e5:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c18e9:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c18ec:	29 d0                	sub    %edx,%eax
  2c18ee:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c18f1:	eb 25                	jmp    2c1918 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  2c18f3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c18fa:	48 8b 08             	mov    (%rax),%rcx
  2c18fd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1903:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c190a:	be 20 00 00 00       	mov    $0x20,%esi
  2c190f:	48 89 c7             	mov    %rax,%rdi
  2c1912:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1914:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1918:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c191b:	83 e0 04             	and    $0x4,%eax
  2c191e:	85 c0                	test   %eax,%eax
  2c1920:	75 36                	jne    2c1958 <printer_vprintf+0x945>
  2c1922:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1926:	7f cb                	jg     2c18f3 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  2c1928:	eb 2e                	jmp    2c1958 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  2c192a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1931:	4c 8b 00             	mov    (%rax),%r8
  2c1934:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1938:	0f b6 00             	movzbl (%rax),%eax
  2c193b:	0f b6 c8             	movzbl %al,%ecx
  2c193e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1944:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c194b:	89 ce                	mov    %ecx,%esi
  2c194d:	48 89 c7             	mov    %rax,%rdi
  2c1950:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1953:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c1958:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c195c:	0f b6 00             	movzbl (%rax),%eax
  2c195f:	84 c0                	test   %al,%al
  2c1961:	75 c7                	jne    2c192a <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  2c1963:	eb 25                	jmp    2c198a <printer_vprintf+0x977>
            p->putc(p, '0', color);
  2c1965:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c196c:	48 8b 08             	mov    (%rax),%rcx
  2c196f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1975:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c197c:	be 30 00 00 00       	mov    $0x30,%esi
  2c1981:	48 89 c7             	mov    %rax,%rdi
  2c1984:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c1986:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c198a:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c198e:	7f d5                	jg     2c1965 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  2c1990:	eb 32                	jmp    2c19c4 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  2c1992:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1999:	4c 8b 00             	mov    (%rax),%r8
  2c199c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c19a0:	0f b6 00             	movzbl (%rax),%eax
  2c19a3:	0f b6 c8             	movzbl %al,%ecx
  2c19a6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c19ac:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c19b3:	89 ce                	mov    %ecx,%esi
  2c19b5:	48 89 c7             	mov    %rax,%rdi
  2c19b8:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c19bb:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c19c0:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c19c4:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c19c8:	7f c8                	jg     2c1992 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  2c19ca:	eb 25                	jmp    2c19f1 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  2c19cc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c19d3:	48 8b 08             	mov    (%rax),%rcx
  2c19d6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c19dc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c19e3:	be 20 00 00 00       	mov    $0x20,%esi
  2c19e8:	48 89 c7             	mov    %rax,%rdi
  2c19eb:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c19ed:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c19f1:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c19f5:	7f d5                	jg     2c19cc <printer_vprintf+0x9b9>
        }
    done: ;
  2c19f7:	90                   	nop
    for (; *format; ++format) {
  2c19f8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c19ff:	01 
  2c1a00:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1a07:	0f b6 00             	movzbl (%rax),%eax
  2c1a0a:	84 c0                	test   %al,%al
  2c1a0c:	0f 85 31 f6 ff ff    	jne    2c1043 <printer_vprintf+0x30>
    }
}
  2c1a12:	90                   	nop
  2c1a13:	90                   	nop
  2c1a14:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c1a18:	c9                   	leave  
  2c1a19:	c3                   	ret    

00000000002c1a1a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1a1a:	f3 0f 1e fa          	endbr64 
  2c1a1e:	55                   	push   %rbp
  2c1a1f:	48 89 e5             	mov    %rsp,%rbp
  2c1a22:	48 83 ec 20          	sub    $0x20,%rsp
  2c1a26:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1a2a:	89 f0                	mov    %esi,%eax
  2c1a2c:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1a2f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1a32:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1a36:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1a3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1a3e:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1a42:	48 8d 15 57 75 df ff 	lea    -0x208aa9(%rip),%rdx        # b8fa0 <console+0xfa0>
  2c1a49:	48 39 d0             	cmp    %rdx,%rax
  2c1a4c:	72 0f                	jb     2c1a5d <console_putc+0x43>
        cp->cursor = console;
  2c1a4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1a52:	48 8d 15 a7 65 df ff 	lea    -0x209a59(%rip),%rdx        # b8000 <console>
  2c1a59:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  2c1a5d:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c1a61:	0f 85 82 00 00 00    	jne    2c1ae9 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  2c1a67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1a6b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1a6f:	48 8d 15 8a 65 df ff 	lea    -0x209a76(%rip),%rdx        # b8000 <console>
  2c1a76:	48 29 d0             	sub    %rdx,%rax
  2c1a79:	48 d1 f8             	sar    %rax
  2c1a7c:	48 89 c1             	mov    %rax,%rcx
  2c1a7f:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1a86:	66 66 66 
  2c1a89:	48 89 c8             	mov    %rcx,%rax
  2c1a8c:	48 f7 ea             	imul   %rdx
  2c1a8f:	48 89 d0             	mov    %rdx,%rax
  2c1a92:	48 c1 f8 05          	sar    $0x5,%rax
  2c1a96:	48 89 ce             	mov    %rcx,%rsi
  2c1a99:	48 c1 fe 3f          	sar    $0x3f,%rsi
  2c1a9d:	48 29 f0             	sub    %rsi,%rax
  2c1aa0:	48 89 c2             	mov    %rax,%rdx
  2c1aa3:	48 89 d0             	mov    %rdx,%rax
  2c1aa6:	48 c1 e0 02          	shl    $0x2,%rax
  2c1aaa:	48 01 d0             	add    %rdx,%rax
  2c1aad:	48 c1 e0 04          	shl    $0x4,%rax
  2c1ab1:	48 29 c1             	sub    %rax,%rcx
  2c1ab4:	48 89 ca             	mov    %rcx,%rdx
  2c1ab7:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c1aba:	eb 25                	jmp    2c1ae1 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  2c1abc:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1abf:	83 c8 20             	or     $0x20,%eax
  2c1ac2:	89 c6                	mov    %eax,%esi
  2c1ac4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1ac8:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1acc:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1ad0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1ad4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1ad8:	89 f2                	mov    %esi,%edx
  2c1ada:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c1add:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1ae1:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c1ae5:	75 d5                	jne    2c1abc <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c1ae7:	eb 24                	jmp    2c1b0d <console_putc+0xf3>
        *cp->cursor++ = c | color;
  2c1ae9:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1aed:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1af0:	89 d6                	mov    %edx,%esi
  2c1af2:	09 c6                	or     %eax,%esi
  2c1af4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1af8:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1afc:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1b00:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1b04:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1b08:	89 f2                	mov    %esi,%edx
  2c1b0a:	66 89 10             	mov    %dx,(%rax)
}
  2c1b0d:	90                   	nop
  2c1b0e:	c9                   	leave  
  2c1b0f:	c3                   	ret    

00000000002c1b10 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c1b10:	f3 0f 1e fa          	endbr64 
  2c1b14:	55                   	push   %rbp
  2c1b15:	48 89 e5             	mov    %rsp,%rbp
  2c1b18:	48 83 ec 30          	sub    $0x30,%rsp
  2c1b1c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c1b1f:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1b22:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1b26:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1b2a:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 2c1a1a <console_putc>
  2c1b31:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1b35:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1b39:	78 09                	js     2c1b44 <console_vprintf+0x34>
  2c1b3b:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1b42:	7e 07                	jle    2c1b4b <console_vprintf+0x3b>
        cpos = 0;
  2c1b44:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c1b4b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1b4e:	48 98                	cltq   
  2c1b50:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c1b54:	48 8d 05 a5 64 df ff 	lea    -0x209b5b(%rip),%rax        # b8000 <console>
  2c1b5b:	48 01 d0             	add    %rdx,%rax
  2c1b5e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1b62:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1b66:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c1b6a:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c1b6d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1b71:	48 89 c7             	mov    %rax,%rdi
  2c1b74:	e8 9a f4 ff ff       	call   2c1013 <printer_vprintf>
    return cp.cursor - console;
  2c1b79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1b7d:	48 8d 15 7c 64 df ff 	lea    -0x209b84(%rip),%rdx        # b8000 <console>
  2c1b84:	48 29 d0             	sub    %rdx,%rax
  2c1b87:	48 d1 f8             	sar    %rax
}
  2c1b8a:	c9                   	leave  
  2c1b8b:	c3                   	ret    

00000000002c1b8c <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c1b8c:	f3 0f 1e fa          	endbr64 
  2c1b90:	55                   	push   %rbp
  2c1b91:	48 89 e5             	mov    %rsp,%rbp
  2c1b94:	48 83 ec 60          	sub    $0x60,%rsp
  2c1b98:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c1b9b:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c1b9e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1ba2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1ba6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1baa:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1bae:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1bb5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1bb9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1bbd:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1bc1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1bc5:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c1bc9:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c1bcd:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c1bd0:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c1bd3:	89 c7                	mov    %eax,%edi
  2c1bd5:	e8 36 ff ff ff       	call   2c1b10 <console_vprintf>
  2c1bda:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c1bdd:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c1be0:	c9                   	leave  
  2c1be1:	c3                   	ret    

00000000002c1be2 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c1be2:	f3 0f 1e fa          	endbr64 
  2c1be6:	55                   	push   %rbp
  2c1be7:	48 89 e5             	mov    %rsp,%rbp
  2c1bea:	48 83 ec 20          	sub    $0x20,%rsp
  2c1bee:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1bf2:	89 f0                	mov    %esi,%eax
  2c1bf4:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1bf7:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c1bfa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1bfe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c1c02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1c06:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c1c0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1c0e:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c1c12:	48 39 c2             	cmp    %rax,%rdx
  2c1c15:	73 1a                	jae    2c1c31 <string_putc+0x4f>
        *sp->s++ = c;
  2c1c17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1c1b:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1c1f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c1c23:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c1c27:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1c2b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1c2f:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1c31:	90                   	nop
  2c1c32:	c9                   	leave  
  2c1c33:	c3                   	ret    

00000000002c1c34 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1c34:	f3 0f 1e fa          	endbr64 
  2c1c38:	55                   	push   %rbp
  2c1c39:	48 89 e5             	mov    %rsp,%rbp
  2c1c3c:	48 83 ec 40          	sub    $0x40,%rsp
  2c1c40:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1c44:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c1c48:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1c4c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1c50:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 2c1be2 <string_putc>
  2c1c57:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  2c1c5b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1c5f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1c63:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1c68:	74 33                	je     2c1c9d <vsnprintf+0x69>
        sp.end = s + size - 1;
  2c1c6a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1c6e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c1c72:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1c76:	48 01 d0             	add    %rdx,%rax
  2c1c79:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c1c7d:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c1c81:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c1c85:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c1c89:	be 00 00 00 00       	mov    $0x0,%esi
  2c1c8e:	48 89 c7             	mov    %rax,%rdi
  2c1c91:	e8 7d f3 ff ff       	call   2c1013 <printer_vprintf>
        *sp.s = 0;
  2c1c96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1c9a:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c1c9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1ca1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c1ca5:	c9                   	leave  
  2c1ca6:	c3                   	ret    

00000000002c1ca7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1ca7:	f3 0f 1e fa          	endbr64 
  2c1cab:	55                   	push   %rbp
  2c1cac:	48 89 e5             	mov    %rsp,%rbp
  2c1caf:	48 83 ec 70          	sub    $0x70,%rsp
  2c1cb3:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c1cb7:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c1cbb:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1cbf:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1cc3:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1cc7:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1ccb:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c1cd2:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1cd6:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c1cda:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1cde:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1ce2:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c1ce6:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c1cea:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c1cee:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1cf2:	48 89 c7             	mov    %rax,%rdi
  2c1cf5:	e8 3a ff ff ff       	call   2c1c34 <vsnprintf>
  2c1cfa:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c1cfd:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1d00:	c9                   	leave  
  2c1d01:	c3                   	ret    

00000000002c1d02 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1d02:	f3 0f 1e fa          	endbr64 
  2c1d06:	55                   	push   %rbp
  2c1d07:	48 89 e5             	mov    %rsp,%rbp
  2c1d0a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1d0e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1d15:	eb 1a                	jmp    2c1d31 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  2c1d17:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c1d1a:	48 98                	cltq   
  2c1d1c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c1d20:	48 8d 05 d9 62 df ff 	lea    -0x209d27(%rip),%rax        # b8000 <console>
  2c1d27:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1d2d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1d31:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1d38:	7e dd                	jle    2c1d17 <console_clear+0x15>
    }
    cursorpos = 0;
  2c1d3a:	c7 05 b8 72 df ff 00 	movl   $0x0,-0x208d48(%rip)        # b8ffc <cursorpos>
  2c1d41:	00 00 00 
}
  2c1d44:	90                   	nop
  2c1d45:	c9                   	leave  
  2c1d46:	c3                   	ret    
