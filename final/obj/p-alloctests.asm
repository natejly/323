
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
  2c001a:	e8 4b 10 00 00       	call   2c106a <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001f:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0024:	e8 59 09 00 00       	call   2c0982 <malloc>
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
  2c0043:	e8 ea 09 00 00       	call   2c0a32 <realloc>
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
  2c006b:	e8 8b 09 00 00       	call   2c09fb <calloc>
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
  2c008a:	e8 75 0b 00 00       	call   2c0c04 <heap_info>
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
  2c00bb:	48 8d 15 8e 1d 00 00 	lea    0x1d8e(%rip),%rdx        # 2c1e50 <console_clear+0x46>
  2c00c2:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c7:	48 8d 3d 90 1d 00 00 	lea    0x1d90(%rip),%rdi        # 2c1e5e <console_clear+0x54>
  2c00ce:	e8 31 02 00 00       	call   2c0304 <assert_fail>
	assert(array2[i] == 0);
  2c00d3:	48 8d 15 9a 1d 00 00 	lea    0x1d9a(%rip),%rdx        # 2c1e74 <console_clear+0x6a>
  2c00da:	be 21 00 00 00       	mov    $0x21,%esi
  2c00df:	48 8d 3d 78 1d 00 00 	lea    0x1d78(%rip),%rdi        # 2c1e5e <console_clear+0x54>
  2c00e6:	e8 19 02 00 00       	call   2c0304 <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00eb:	48 8d 15 a6 1d 00 00 	lea    0x1da6(%rip),%rdx        # 2c1e98 <console_clear+0x8e>
  2c00f2:	be 28 00 00 00       	mov    $0x28,%esi
  2c00f7:	48 8d 3d 60 1d 00 00 	lea    0x1d60(%rip),%rdi        # 2c1e5e <console_clear+0x54>
  2c00fe:	e8 01 02 00 00       	call   2c0304 <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c0103:	48 8d 35 79 1d 00 00 	lea    0x1d79(%rip),%rsi        # 2c1e83 <console_clear+0x79>
  2c010a:	bf 00 00 00 00       	mov    $0x0,%edi
  2c010f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0114:	e8 7b 00 00 00       	call   2c0194 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0119:	4c 89 ef             	mov    %r13,%rdi
  2c011c:	e8 27 08 00 00       	call   2c0948 <free>
    free(array2);
  2c0121:	4c 89 f7             	mov    %r14,%rdi
  2c0124:	e8 1f 08 00 00       	call   2c0948 <free>

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
  2c0142:	e8 3b 08 00 00       	call   2c0982 <malloc>
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
  2c017c:	48 8d 35 45 1d 00 00 	lea    0x1d45(%rip),%rsi        # 2c1ec8 <console_clear+0xbe>
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
  2c01e0:	48 8d 05 46 1d 00 00 	lea    0x1d46(%rip),%rax        # 2c1f2d <col.0>
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
  2c0212:	e8 01 1a 00 00       	call   2c1c18 <console_vprintf>
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
  2c0276:	48 8d 35 7b 1c 00 00 	lea    0x1c7b(%rip),%rsi        # 2c1ef8 <console_clear+0xee>
  2c027d:	e8 cd 0a 00 00       	call   2c0d4f <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0282:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0286:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c028d:	48 89 da             	mov    %rbx,%rdx
  2c0290:	be 99 00 00 00       	mov    $0x99,%esi
  2c0295:	e8 a2 1a 00 00       	call   2c1d3c <vsnprintf>
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
  2c02ba:	48 8d 15 3f 1c 00 00 	lea    0x1c3f(%rip),%rdx        # 2c1f00 <console_clear+0xf6>
  2c02c1:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02c6:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02cb:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02d0:	e8 bf 19 00 00       	call   2c1c94 <console_printf>
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
  2c02f6:	48 8d 35 96 1b 00 00 	lea    0x1b96(%rip),%rsi        # 2c1e93 <console_clear+0x89>
  2c02fd:	e8 0e 0c 00 00       	call   2c0f10 <strcpy>
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
  2c0315:	48 8d 15 ec 1b 00 00 	lea    0x1bec(%rip),%rdx        # 2c1f08 <console_clear+0xfe>
  2c031c:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0321:	bf 30 07 00 00       	mov    $0x730,%edi
  2c0326:	b8 00 00 00 00       	mov    $0x0,%eax
  2c032b:	e8 64 19 00 00       	call   2c1c94 <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0330:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0335:	cd 30                	int    $0x30
 loop: goto loop;
  2c0337:	eb fe                	jmp    2c0337 <assert_fail+0x33>

00000000002c0339 <ptr_comparator1>:
        }
    }
    }
}
int ptr_comparator1(const void *a, const void *b);
int ptr_comparator1(const void *a, const void *b) {
  2c0339:	f3 0f 1e fa          	endbr64 
    ptr_with_size *a_ptr = (ptr_with_size *)a;
    ptr_with_size *b_ptr = (ptr_with_size *)b;

    // Sort by size in descending order
    return (int)b_ptr->size - (int)a_ptr->size;
  2c033d:	48 8b 46 08          	mov    0x8(%rsi),%rax
  2c0341:	2b 47 08             	sub    0x8(%rdi),%eax
}
  2c0344:	c3                   	ret    

00000000002c0345 <_quicksort1>:
{
  2c0345:	f3 0f 1e fa          	endbr64 
  2c0349:	55                   	push   %rbp
  2c034a:	48 89 e5             	mov    %rsp,%rbp
  2c034d:	41 57                	push   %r15
  2c034f:	41 56                	push   %r14
  2c0351:	41 55                	push   %r13
  2c0353:	41 54                	push   %r12
  2c0355:	53                   	push   %rbx
  2c0356:	48 81 ec 48 04 00 00 	sub    $0x448,%rsp
  2c035d:	48 89 bd a0 fb ff ff 	mov    %rdi,-0x460(%rbp)
  2c0364:	48 89 b5 98 fb ff ff 	mov    %rsi,-0x468(%rbp)
  2c036b:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
    if (total_elems == 0)
  2c0372:	48 85 f6             	test   %rsi,%rsi
  2c0375:	0f 84 94 03 00 00    	je     2c070f <_quicksort1+0x3ca>
  2c037b:	48 89 f0             	mov    %rsi,%rax
  2c037e:	48 89 cb             	mov    %rcx,%rbx
    const size_t max_thresh = MAX_THRESH * size;
  2c0381:	48 8d 0c 95 00 00 00 	lea    0x0(,%rdx,4),%rcx
  2c0388:	00 
  2c0389:	48 89 8d a8 fb ff ff 	mov    %rcx,-0x458(%rbp)
    if (total_elems > MAX_THRESH)
  2c0390:	48 83 fe 04          	cmp    $0x4,%rsi
  2c0394:	0f 86 bd 02 00 00    	jbe    2c0657 <_quicksort1+0x312>
    char *hi = &lo[size * (total_elems - 1)];
  2c039a:	48 83 e8 01          	sub    $0x1,%rax
  2c039e:	48 0f af c2          	imul   %rdx,%rax
  2c03a2:	48 01 f8             	add    %rdi,%rax
  2c03a5:	48 89 85 c0 fb ff ff 	mov    %rax,-0x440(%rbp)
    PUSH (NULL, NULL);
  2c03ac:	48 c7 85 d0 fb ff ff 	movq   $0x0,-0x430(%rbp)
  2c03b3:	00 00 00 00 
  2c03b7:	48 c7 85 d8 fb ff ff 	movq   $0x0,-0x428(%rbp)
  2c03be:	00 00 00 00 
    char *lo = base_ptr;
  2c03c2:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
    PUSH (NULL, NULL);
  2c03c9:	48 8d 85 e0 fb ff ff 	lea    -0x420(%rbp),%rax
  2c03d0:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
      right_ptr = hi - size;
  2c03d7:	48 f7 da             	neg    %rdx
  2c03da:	49 89 d7             	mov    %rdx,%r15
  2c03dd:	e9 8c 01 00 00       	jmp    2c056e <_quicksort1+0x229>
  2c03e2:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c03e9:	49 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%rdi
        if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c03ee:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
        SWAP (mid, lo, size);
  2c03f5:	4c 89 e8             	mov    %r13,%rax
  2c03f8:	0f b6 08             	movzbl (%rax),%ecx
  2c03fb:	48 83 c0 01          	add    $0x1,%rax
  2c03ff:	0f b6 32             	movzbl (%rdx),%esi
  2c0402:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c0406:	48 83 c2 01          	add    $0x1,%rdx
  2c040a:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c040d:	48 39 c7             	cmp    %rax,%rdi
  2c0410:	75 e6                	jne    2c03f8 <_quicksort1+0xb3>
  2c0412:	e9 92 01 00 00       	jmp    2c05a9 <_quicksort1+0x264>
  2c0417:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c041e:	4d 8d 64 05 00       	lea    0x0(%r13,%rax,1),%r12
        if ((*cmp) ((void *) hi, (void *) mid) < 0)
  2c0423:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
        SWAP (mid, hi, size);
  2c042a:	4c 89 e8             	mov    %r13,%rax
  2c042d:	0f b6 08             	movzbl (%rax),%ecx
  2c0430:	48 83 c0 01          	add    $0x1,%rax
  2c0434:	0f b6 32             	movzbl (%rdx),%esi
  2c0437:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c043b:	48 83 c2 01          	add    $0x1,%rdx
  2c043f:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c0442:	49 39 c4             	cmp    %rax,%r12
  2c0445:	75 e6                	jne    2c042d <_quicksort1+0xe8>
        if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c0447:	48 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%rsi
  2c044e:	4c 89 ef             	mov    %r13,%rdi
  2c0451:	ff d3                	call   *%rbx
  2c0453:	85 c0                	test   %eax,%eax
  2c0455:	0f 89 62 01 00 00    	jns    2c05bd <_quicksort1+0x278>
  2c045b:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
        SWAP (mid, lo, size);
  2c0462:	4c 89 e8             	mov    %r13,%rax
  2c0465:	0f b6 08             	movzbl (%rax),%ecx
  2c0468:	48 83 c0 01          	add    $0x1,%rax
  2c046c:	0f b6 32             	movzbl (%rdx),%esi
  2c046f:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c0473:	48 83 c2 01          	add    $0x1,%rdx
  2c0477:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c047a:	49 39 c4             	cmp    %rax,%r12
  2c047d:	75 e6                	jne    2c0465 <_quicksort1+0x120>
jump_over:;
  2c047f:	e9 39 01 00 00       	jmp    2c05bd <_quicksort1+0x278>
          right_ptr -= size;
  2c0484:	4d 01 fc             	add    %r15,%r12
          while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
  2c0487:	4c 89 e6             	mov    %r12,%rsi
  2c048a:	4c 89 ef             	mov    %r13,%rdi
  2c048d:	ff d3                	call   *%rbx
  2c048f:	85 c0                	test   %eax,%eax
  2c0491:	78 f1                	js     2c0484 <_quicksort1+0x13f>
          if (left_ptr < right_ptr)
  2c0493:	4d 39 e6             	cmp    %r12,%r14
  2c0496:	72 1c                	jb     2c04b4 <_quicksort1+0x16f>
          else if (left_ptr == right_ptr)
  2c0498:	74 5e                	je     2c04f8 <_quicksort1+0x1b3>
      while (left_ptr <= right_ptr);
  2c049a:	4d 39 e6             	cmp    %r12,%r14
  2c049d:	77 63                	ja     2c0502 <_quicksort1+0x1bd>
          while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
  2c049f:	4c 89 ee             	mov    %r13,%rsi
  2c04a2:	4c 89 f7             	mov    %r14,%rdi
  2c04a5:	ff d3                	call   *%rbx
  2c04a7:	85 c0                	test   %eax,%eax
  2c04a9:	79 dc                	jns    2c0487 <_quicksort1+0x142>
          left_ptr += size;
  2c04ab:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  2c04b2:	eb eb                	jmp    2c049f <_quicksort1+0x15a>
  2c04b4:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c04bb:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
          if (left_ptr < right_ptr)
  2c04bf:	4c 89 e2             	mov    %r12,%rdx
  2c04c2:	4c 89 f0             	mov    %r14,%rax
          SWAP (left_ptr, right_ptr, size);
  2c04c5:	0f b6 08             	movzbl (%rax),%ecx
  2c04c8:	48 83 c0 01          	add    $0x1,%rax
  2c04cc:	0f b6 32             	movzbl (%rdx),%esi
  2c04cf:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  2c04d3:	48 83 c2 01          	add    $0x1,%rdx
  2c04d7:	88 4a ff             	mov    %cl,-0x1(%rdx)
  2c04da:	48 39 f8             	cmp    %rdi,%rax
  2c04dd:	75 e6                	jne    2c04c5 <_quicksort1+0x180>
          if (mid == left_ptr)
  2c04df:	4d 39 ee             	cmp    %r13,%r14
  2c04e2:	74 0f                	je     2c04f3 <_quicksort1+0x1ae>
          else if (mid == right_ptr)
  2c04e4:	4d 39 ec             	cmp    %r13,%r12
  2c04e7:	4d 0f 44 ee          	cmove  %r14,%r13
          right_ptr -= size;
  2c04eb:	4d 01 fc             	add    %r15,%r12
          left_ptr += size;
  2c04ee:	49 89 fe             	mov    %rdi,%r14
  2c04f1:	eb a7                	jmp    2c049a <_quicksort1+0x155>
  2c04f3:	4d 89 e5             	mov    %r12,%r13
  2c04f6:	eb f3                	jmp    2c04eb <_quicksort1+0x1a6>
          left_ptr += size;
  2c04f8:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
          right_ptr -= size;
  2c04ff:	4d 01 fc             	add    %r15,%r12
      if ((size_t) (right_ptr - lo) <= max_thresh)
  2c0502:	4c 89 e0             	mov    %r12,%rax
  2c0505:	48 2b 85 b8 fb ff ff 	sub    -0x448(%rbp),%rax
  2c050c:	48 8b bd a8 fb ff ff 	mov    -0x458(%rbp),%rdi
  2c0513:	48 39 f8             	cmp    %rdi,%rax
  2c0516:	0f 87 bf 00 00 00    	ja     2c05db <_quicksort1+0x296>
          if ((size_t) (hi - left_ptr) <= max_thresh)
  2c051c:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c0523:	4c 29 f0             	sub    %r14,%rax
          lo = left_ptr;
  2c0526:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
          if ((size_t) (hi - left_ptr) <= max_thresh)
  2c052d:	48 39 f8             	cmp    %rdi,%rax
  2c0530:	77 28                	ja     2c055a <_quicksort1+0x215>
          POP (lo, hi);
  2c0532:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c0539:	48 8b 78 f0          	mov    -0x10(%rax),%rdi
  2c053d:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
  2c0544:	48 8b 78 f8          	mov    -0x8(%rax),%rdi
  2c0548:	48 89 bd c0 fb ff ff 	mov    %rdi,-0x440(%rbp)
  2c054f:	48 8d 40 f0          	lea    -0x10(%rax),%rax
  2c0553:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
    while (STACK_NOT_EMPTY)
  2c055a:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  2c0561:	48 39 85 b0 fb ff ff 	cmp    %rax,-0x450(%rbp)
  2c0568:	0f 86 e9 00 00 00    	jbe    2c0657 <_quicksort1+0x312>
        char *mid = lo + size * ((hi - lo) / size >> 1);
  2c056e:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c0575:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  2c057c:	48 29 f8             	sub    %rdi,%rax
  2c057f:	48 8b 8d c8 fb ff ff 	mov    -0x438(%rbp),%rcx
  2c0586:	ba 00 00 00 00       	mov    $0x0,%edx
  2c058b:	48 f7 f1             	div    %rcx
  2c058e:	48 d1 e8             	shr    %rax
  2c0591:	48 0f af c1          	imul   %rcx,%rax
  2c0595:	4c 8d 2c 07          	lea    (%rdi,%rax,1),%r13
        if ((*cmp) ((void *) mid, (void *) lo) < 0)
  2c0599:	48 89 fe             	mov    %rdi,%rsi
  2c059c:	4c 89 ef             	mov    %r13,%rdi
  2c059f:	ff d3                	call   *%rbx
  2c05a1:	85 c0                	test   %eax,%eax
  2c05a3:	0f 88 39 fe ff ff    	js     2c03e2 <_quicksort1+0x9d>
        if ((*cmp) ((void *) hi, (void *) mid) < 0)
  2c05a9:	4c 89 ee             	mov    %r13,%rsi
  2c05ac:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  2c05b3:	ff d3                	call   *%rbx
  2c05b5:	85 c0                	test   %eax,%eax
  2c05b7:	0f 88 5a fe ff ff    	js     2c0417 <_quicksort1+0xd2>
      left_ptr  = lo + size;
  2c05bd:	4c 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%r14
  2c05c4:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
      right_ptr = hi - size;
  2c05cb:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  2c05d2:	4e 8d 24 38          	lea    (%rax,%r15,1),%r12
  2c05d6:	e9 c4 fe ff ff       	jmp    2c049f <_quicksort1+0x15a>
      else if ((size_t) (hi - left_ptr) <= max_thresh)
  2c05db:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
  2c05e2:	4c 29 f2             	sub    %r14,%rdx
  2c05e5:	48 3b 95 a8 fb ff ff 	cmp    -0x458(%rbp),%rdx
  2c05ec:	76 5d                	jbe    2c064b <_quicksort1+0x306>
      else if ((right_ptr - lo) > (hi - left_ptr))
  2c05ee:	48 39 d0             	cmp    %rdx,%rax
  2c05f1:	7e 2c                	jle    2c061f <_quicksort1+0x2da>
          PUSH (lo, right_ptr);
  2c05f3:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c05fa:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  2c0601:	48 89 38             	mov    %rdi,(%rax)
  2c0604:	4c 89 60 08          	mov    %r12,0x8(%rax)
  2c0608:	48 83 c0 10          	add    $0x10,%rax
  2c060c:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
          lo = left_ptr;
  2c0613:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
  2c061a:	e9 3b ff ff ff       	jmp    2c055a <_quicksort1+0x215>
          PUSH (left_ptr, hi);
  2c061f:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  2c0626:	4c 89 30             	mov    %r14,(%rax)
  2c0629:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  2c0630:	48 89 78 08          	mov    %rdi,0x8(%rax)
  2c0634:	48 83 c0 10          	add    $0x10,%rax
  2c0638:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
          hi = right_ptr;
  2c063f:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  2c0646:	e9 0f ff ff ff       	jmp    2c055a <_quicksort1+0x215>
          hi = right_ptr;
  2c064b:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  2c0652:	e9 03 ff ff ff       	jmp    2c055a <_quicksort1+0x215>
    char *const end_ptr = &base_ptr[size * (total_elems - 1)];
  2c0657:	4c 8b bd 98 fb ff ff 	mov    -0x468(%rbp),%r15
  2c065e:	49 83 ef 01          	sub    $0x1,%r15
  2c0662:	48 8b bd c8 fb ff ff 	mov    -0x438(%rbp),%rdi
  2c0669:	4c 0f af ff          	imul   %rdi,%r15
  2c066d:	4c 8b ad a0 fb ff ff 	mov    -0x460(%rbp),%r13
  2c0674:	4d 01 ef             	add    %r13,%r15
    char *thresh = min(end_ptr, base_ptr + max_thresh);
  2c0677:	48 8b 85 a8 fb ff ff 	mov    -0x458(%rbp),%rax
  2c067e:	4c 01 e8             	add    %r13,%rax
  2c0681:	49 39 c7             	cmp    %rax,%r15
  2c0684:	49 0f 46 c7          	cmovbe %r15,%rax
    for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  2c0688:	4d 89 ec             	mov    %r13,%r12
  2c068b:	49 01 fc             	add    %rdi,%r12
  2c068e:	4c 39 e0             	cmp    %r12,%rax
  2c0691:	72 66                	jb     2c06f9 <_quicksort1+0x3b4>
  2c0693:	4d 89 e6             	mov    %r12,%r14
    char *tmp_ptr = base_ptr;
  2c0696:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  2c069d:	49 89 c4             	mov    %rax,%r12
        if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c06a0:	4c 89 ee             	mov    %r13,%rsi
  2c06a3:	4c 89 f7             	mov    %r14,%rdi
  2c06a6:	ff d3                	call   *%rbx
  2c06a8:	85 c0                	test   %eax,%eax
  2c06aa:	4d 0f 48 ee          	cmovs  %r14,%r13
    for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  2c06ae:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  2c06b5:	4d 39 f4             	cmp    %r14,%r12
  2c06b8:	73 e6                	jae    2c06a0 <_quicksort1+0x35b>
  2c06ba:	4c 8b a5 c0 fb ff ff 	mov    -0x440(%rbp),%r12
    if (tmp_ptr != base_ptr)
  2c06c1:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c06c8:	49 8d 4c 05 00       	lea    0x0(%r13,%rax,1),%rcx
  2c06cd:	48 8b 85 a0 fb ff ff 	mov    -0x460(%rbp),%rax
  2c06d4:	4c 3b ad a0 fb ff ff 	cmp    -0x460(%rbp),%r13
  2c06db:	74 1c                	je     2c06f9 <_quicksort1+0x3b4>
        SWAP (tmp_ptr, base_ptr, size);
  2c06dd:	41 0f b6 55 00       	movzbl 0x0(%r13),%edx
  2c06e2:	49 83 c5 01          	add    $0x1,%r13
  2c06e6:	0f b6 30             	movzbl (%rax),%esi
  2c06e9:	41 88 75 ff          	mov    %sil,-0x1(%r13)
  2c06ed:	48 83 c0 01          	add    $0x1,%rax
  2c06f1:	88 50 ff             	mov    %dl,-0x1(%rax)
  2c06f4:	49 39 cd             	cmp    %rcx,%r13
  2c06f7:	75 e4                	jne    2c06dd <_quicksort1+0x398>
    while ((run_ptr += size) <= end_ptr)
  2c06f9:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0700:	4d 8d 34 04          	lea    (%r12,%rax,1),%r14
        tmp_ptr = run_ptr - size;
  2c0704:	48 f7 d8             	neg    %rax
  2c0707:	49 89 c5             	mov    %rax,%r13
    while ((run_ptr += size) <= end_ptr)
  2c070a:	4d 39 f7             	cmp    %r14,%r15
  2c070d:	73 15                	jae    2c0724 <_quicksort1+0x3df>
}
  2c070f:	48 81 c4 48 04 00 00 	add    $0x448,%rsp
  2c0716:	5b                   	pop    %rbx
  2c0717:	41 5c                	pop    %r12
  2c0719:	41 5d                	pop    %r13
  2c071b:	41 5e                	pop    %r14
  2c071d:	41 5f                	pop    %r15
  2c071f:	5d                   	pop    %rbp
  2c0720:	c3                   	ret    
        tmp_ptr -= size;
  2c0721:	4d 01 ec             	add    %r13,%r12
        while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c0724:	4c 89 e6             	mov    %r12,%rsi
  2c0727:	4c 89 f7             	mov    %r14,%rdi
  2c072a:	ff d3                	call   *%rbx
  2c072c:	85 c0                	test   %eax,%eax
  2c072e:	78 f1                	js     2c0721 <_quicksort1+0x3dc>
        tmp_ptr += size;
  2c0730:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0737:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
        if (tmp_ptr != run_ptr)
  2c073b:	4c 39 f6             	cmp    %r14,%rsi
  2c073e:	75 17                	jne    2c0757 <_quicksort1+0x412>
    while ((run_ptr += size) <= end_ptr)
  2c0740:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  2c0747:	4c 01 f0             	add    %r14,%rax
  2c074a:	4d 89 f4             	mov    %r14,%r12
  2c074d:	49 39 c7             	cmp    %rax,%r15
  2c0750:	72 bd                	jb     2c070f <_quicksort1+0x3ca>
  2c0752:	49 89 c6             	mov    %rax,%r14
        while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  2c0755:	eb cd                	jmp    2c0724 <_quicksort1+0x3df>
        while (--trav >= run_ptr)
  2c0757:	49 8d 7c 06 ff       	lea    -0x1(%r14,%rax,1),%rdi
  2c075c:	4c 39 f7             	cmp    %r14,%rdi
  2c075f:	72 df                	jb     2c0740 <_quicksort1+0x3fb>
  2c0761:	4d 8d 46 ff          	lea    -0x1(%r14),%r8
  2c0765:	4d 89 c2             	mov    %r8,%r10
  2c0768:	eb 13                	jmp    2c077d <_quicksort1+0x438>
            for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c076a:	48 89 f9             	mov    %rdi,%rcx
            *hi = c;
  2c076d:	44 88 09             	mov    %r9b,(%rcx)
        while (--trav >= run_ptr)
  2c0770:	48 83 ef 01          	sub    $0x1,%rdi
  2c0774:	49 83 e8 01          	sub    $0x1,%r8
  2c0778:	49 39 fa             	cmp    %rdi,%r10
  2c077b:	74 c3                	je     2c0740 <_quicksort1+0x3fb>
            char c = *trav;
  2c077d:	44 0f b6 0f          	movzbl (%rdi),%r9d
            for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c0781:	4c 89 c0             	mov    %r8,%rax
  2c0784:	4c 39 c6             	cmp    %r8,%rsi
  2c0787:	77 e1                	ja     2c076a <_quicksort1+0x425>
  2c0789:	48 89 fa             	mov    %rdi,%rdx
            *hi = *lo;
  2c078c:	0f b6 08             	movzbl (%rax),%ecx
  2c078f:	88 0a                	mov    %cl,(%rdx)
            for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  2c0791:	48 89 c1             	mov    %rax,%rcx
  2c0794:	4c 01 e8             	add    %r13,%rax
  2c0797:	48 2b 95 c8 fb ff ff 	sub    -0x438(%rbp),%rdx
  2c079e:	48 39 c6             	cmp    %rax,%rsi
  2c07a1:	76 e9                	jbe    2c078c <_quicksort1+0x447>
  2c07a3:	eb c8                	jmp    2c076d <_quicksort1+0x428>

00000000002c07a5 <algn>:
void add_to_free_list(block *b);
void remove_from_free_list(block *b);
void add_to_malloc_list(block *b);
void remove_from_malloclist(block *b);

size_t algn(size_t size){
  2c07a5:	f3 0f 1e fa          	endbr64 
    return (size + 7) / 8 * 8;
  2c07a9:	48 8d 47 07          	lea    0x7(%rdi),%rax
  2c07ad:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
}
  2c07b1:	c3                   	ret    

00000000002c07b2 <new_block>:
// sbrk increment of size and return the new block
block* new_block(size_t size){
  2c07b2:	f3 0f 1e fa          	endbr64 
  2c07b6:	48 89 fa             	mov    %rdi,%rdx
    void *bptr = sbrk(size + BLOCKSIZE);
  2c07b9:	48 8d 7f 18          	lea    0x18(%rdi),%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c07bd:	cd 3a                	int    $0x3a
  2c07bf:	48 89 05 42 28 00 00 	mov    %rax,0x2842(%rip)        # 2c3008 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  2c07c6:	48 89 c1             	mov    %rax,%rcx
    if (bptr == (void*) -1) {
  2c07c9:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c07cd:	74 16                	je     2c07e5 <new_block+0x33>
        return NULL;
    }
    block* nblock = (block*)bptr;
    nblock->size = size;
  2c07cf:	48 89 10             	mov    %rdx,(%rax)
    nblock->free = 0;
  2c07d2:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
    nblock->next = NULL;
  2c07d9:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c07e0:	00 
    return nblock;
}
  2c07e1:	48 89 c8             	mov    %rcx,%rax
  2c07e4:	c3                   	ret    
        return NULL;
  2c07e5:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c07ea:	eb f5                	jmp    2c07e1 <new_block+0x2f>

00000000002c07ec <find_block>:
// check free list to see if we have a block that can fit the size
block* find_block(size_t size) {
  2c07ec:	f3 0f 1e fa          	endbr64 
    block* curr = free_head;
  2c07f0:	48 8b 05 21 28 00 00 	mov    0x2821(%rip),%rax        # 2c3018 <free_head>
    while (curr) {
  2c07f7:	48 85 c0             	test   %rax,%rax
  2c07fa:	74 0e                	je     2c080a <find_block+0x1e>
        if (curr->size >= size) {
  2c07fc:	48 39 38             	cmp    %rdi,(%rax)
  2c07ff:	73 09                	jae    2c080a <find_block+0x1e>
            return curr;
        }
        curr = curr->next;
  2c0801:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (curr) {
  2c0805:	48 85 c0             	test   %rax,%rax
  2c0808:	75 f2                	jne    2c07fc <find_block+0x10>
    }
    return NULL;
}
  2c080a:	c3                   	ret    

00000000002c080b <add_to_free_list>:
    b->size = size;
    add_to_free_list(new);
    return new;
}

void add_to_free_list(block *b) {
  2c080b:	f3 0f 1e fa          	endbr64 
    // insert in order of address
    if (!free_head) {
  2c080f:	48 8b 05 02 28 00 00 	mov    0x2802(%rip),%rax        # 2c3018 <free_head>
  2c0816:	48 85 c0             	test   %rax,%rax
  2c0819:	74 1f                	je     2c083a <add_to_free_list+0x2f>
        free_head = b;
        return;
    }
    // add to head if smallest
    if (b < free_head) {
  2c081b:	48 39 f8             	cmp    %rdi,%rax
  2c081e:	77 22                	ja     2c0842 <add_to_free_list+0x37>
        free_head = b;
        return;
    }
    // else insert in order
    block *curr = free_head;
    while (curr->next && curr->next < b) {
  2c0820:	48 89 c2             	mov    %rax,%rdx
  2c0823:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0827:	48 39 f8             	cmp    %rdi,%rax
  2c082a:	73 05                	jae    2c0831 <add_to_free_list+0x26>
  2c082c:	48 85 c0             	test   %rax,%rax
  2c082f:	75 ef                	jne    2c0820 <add_to_free_list+0x15>
        curr = curr->next;
    }
    b->next = curr->next;
  2c0831:	48 89 47 08          	mov    %rax,0x8(%rdi)
    curr->next = b;
  2c0835:	48 89 7a 08          	mov    %rdi,0x8(%rdx)
}
  2c0839:	c3                   	ret    
        free_head = b;
  2c083a:	48 89 3d d7 27 00 00 	mov    %rdi,0x27d7(%rip)        # 2c3018 <free_head>
        return;
  2c0841:	c3                   	ret    
        b->next = free_head;
  2c0842:	48 89 47 08          	mov    %rax,0x8(%rdi)
        free_head = b;
  2c0846:	48 89 3d cb 27 00 00 	mov    %rdi,0x27cb(%rip)        # 2c3018 <free_head>
        return;
  2c084d:	c3                   	ret    

00000000002c084e <split_block>:
block* split_block(block* b, size_t size){
  2c084e:	f3 0f 1e fa          	endbr64 
  2c0852:	55                   	push   %rbp
  2c0853:	48 89 e5             	mov    %rsp,%rbp
  2c0856:	53                   	push   %rbx
  2c0857:	48 83 ec 08          	sub    $0x8,%rsp
    if (b->size < size + BLOCKSIZE + BLOCKSIZE) {
  2c085b:	48 8b 07             	mov    (%rdi),%rax
  2c085e:	48 8d 56 30          	lea    0x30(%rsi),%rdx
        return NULL;
  2c0862:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (b->size < size + BLOCKSIZE + BLOCKSIZE) {
  2c0867:	48 39 d0             	cmp    %rdx,%rax
  2c086a:	72 29                	jb     2c0895 <split_block+0x47>
    void* nptr = (void*)b + BLOCKSIZE + size;
  2c086c:	48 8d 5c 37 18       	lea    0x18(%rdi,%rsi,1),%rbx
    new->size = b->size - size - BLOCKSIZE;
  2c0871:	48 29 f0             	sub    %rsi,%rax
  2c0874:	48 8d 40 e8          	lea    -0x18(%rax),%rax
  2c0878:	48 89 03             	mov    %rax,(%rbx)
    new->free = 1;
  2c087b:	c7 43 10 01 00 00 00 	movl   $0x1,0x10(%rbx)
    new->next = NULL;
  2c0882:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  2c0889:	00 
    b->size = size;
  2c088a:	48 89 37             	mov    %rsi,(%rdi)
    add_to_free_list(new);
  2c088d:	48 89 df             	mov    %rbx,%rdi
  2c0890:	e8 76 ff ff ff       	call   2c080b <add_to_free_list>
}
  2c0895:	48 89 d8             	mov    %rbx,%rax
  2c0898:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c089c:	c9                   	leave  
  2c089d:	c3                   	ret    

00000000002c089e <remove_from_free_list>:

void remove_from_free_list(block *b) {
  2c089e:	f3 0f 1e fa          	endbr64 
    // if is head
    if (free_head == b) {
  2c08a2:	48 8b 05 6f 27 00 00 	mov    0x276f(%rip),%rax        # 2c3018 <free_head>
  2c08a9:	48 39 f8             	cmp    %rdi,%rax
  2c08ac:	75 10                	jne    2c08be <remove_from_free_list+0x20>
        free_head = b->next;
  2c08ae:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c08b2:	48 89 05 5f 27 00 00 	mov    %rax,0x275f(%rip)        # 2c3018 <free_head>
  2c08b9:	eb 19                	jmp    2c08d4 <remove_from_free_list+0x36>
    } else {
        // itterate and merge
        block *curr = free_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  2c08bb:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  2c08be:	48 85 c0             	test   %rax,%rax
  2c08c1:	74 11                	je     2c08d4 <remove_from_free_list+0x36>
  2c08c3:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c08c7:	48 39 fa             	cmp    %rdi,%rdx
  2c08ca:	75 ef                	jne    2c08bb <remove_from_free_list+0x1d>
        }
        if (curr) {
            curr->next = b->next;
  2c08cc:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c08d0:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 0;
  2c08d4:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = NULL;
  2c08db:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c08e2:	00 
}
  2c08e3:	c3                   	ret    

00000000002c08e4 <add_to_malloc_list>:
void add_to_malloc_list(block *b) {
  2c08e4:	f3 0f 1e fa          	endbr64 
    // add to head
    b->free = 0; 
  2c08e8:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = malloc_head;
  2c08ef:	48 8b 05 1a 27 00 00 	mov    0x271a(%rip),%rax        # 2c3010 <malloc_head>
  2c08f6:	48 89 47 08          	mov    %rax,0x8(%rdi)
    malloc_head = b; 
  2c08fa:	48 89 3d 0f 27 00 00 	mov    %rdi,0x270f(%rip)        # 2c3010 <malloc_head>
}
  2c0901:	c3                   	ret    

00000000002c0902 <remove_from_malloc_list>:

void remove_from_malloc_list(block *b) {
  2c0902:	f3 0f 1e fa          	endbr64 
    if (malloc_head == b) {
  2c0906:	48 8b 05 03 27 00 00 	mov    0x2703(%rip),%rax        # 2c3010 <malloc_head>
  2c090d:	48 39 f8             	cmp    %rdi,%rax
  2c0910:	75 10                	jne    2c0922 <remove_from_malloc_list+0x20>
        malloc_head = b->next; 
  2c0912:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0916:	48 89 05 f3 26 00 00 	mov    %rax,0x26f3(%rip)        # 2c3010 <malloc_head>
  2c091d:	eb 19                	jmp    2c0938 <remove_from_malloc_list+0x36>
    } else {
        block *curr = malloc_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  2c091f:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  2c0922:	48 85 c0             	test   %rax,%rax
  2c0925:	74 11                	je     2c0938 <remove_from_malloc_list+0x36>
  2c0927:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c092b:	48 39 fa             	cmp    %rdi,%rdx
  2c092e:	75 ef                	jne    2c091f <remove_from_malloc_list+0x1d>
        }
        if (curr) {
            curr->next = b->next; 
  2c0930:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c0934:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 1; 
  2c0938:	c7 47 10 01 00 00 00 	movl   $0x1,0x10(%rdi)
    b->next = NULL; 
  2c093f:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c0946:	00 
}
  2c0947:	c3                   	ret    

00000000002c0948 <free>:

void free(void *firstbyte) {
  2c0948:	f3 0f 1e fa          	endbr64 
    if (firstbyte == NULL) {
  2c094c:	48 85 ff             	test   %rdi,%rdi
  2c094f:	74 06                	je     2c0957 <free+0xf>
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; 
  2c0951:	83 7f f8 00          	cmpl   $0x0,-0x8(%rdi)
  2c0955:	74 01                	je     2c0958 <free+0x10>
  2c0957:	c3                   	ret    
void free(void *firstbyte) {
  2c0958:	55                   	push   %rbp
  2c0959:	48 89 e5             	mov    %rsp,%rbp
  2c095c:	53                   	push   %rbx
  2c095d:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
  2c0961:	48 8d 5f e8          	lea    -0x18(%rdi),%rbx
    num_allocs--;
  2c0965:	83 2d 94 26 00 00 01 	subl   $0x1,0x2694(%rip)        # 2c3000 <num_allocs>
    // switch lists
    remove_from_malloc_list(b); 
  2c096c:	48 89 df             	mov    %rbx,%rdi
  2c096f:	e8 8e ff ff ff       	call   2c0902 <remove_from_malloc_list>
    add_to_free_list(b);
  2c0974:	48 89 df             	mov    %rbx,%rdi
  2c0977:	e8 8f fe ff ff       	call   2c080b <add_to_free_list>
}
  2c097c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0980:	c9                   	leave  
  2c0981:	c3                   	ret    

00000000002c0982 <malloc>:

void *malloc(uint64_t numbytes) {
  2c0982:	f3 0f 1e fa          	endbr64 
  2c0986:	55                   	push   %rbp
  2c0987:	48 89 e5             	mov    %rsp,%rbp
  2c098a:	41 54                	push   %r12
  2c098c:	53                   	push   %rbx
    if (numbytes == 0) {
        return NULL;
  2c098d:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (numbytes == 0) {
  2c0992:	48 85 ff             	test   %rdi,%rdi
  2c0995:	74 3d                	je     2c09d4 <malloc+0x52>
    return (size + 7) / 8 * 8;
  2c0997:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  2c099b:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    }
    size_t size = algn(numbytes);
    // check if we have a block that can fit
    block *b = find_block(size);
  2c099f:	4c 89 e7             	mov    %r12,%rdi
  2c09a2:	e8 45 fe ff ff       	call   2c07ec <find_block>
  2c09a7:	48 89 c3             	mov    %rax,%rbx
    if (b == NULL) {
  2c09aa:	48 85 c0             	test   %rax,%rax
  2c09ad:	74 2d                	je     2c09dc <malloc+0x5a>
        b = new_block(size);
        if (b == NULL) {
            return NULL;
        }
    }
        remove_from_free_list(b);
  2c09af:	48 89 df             	mov    %rbx,%rdi
  2c09b2:	e8 e7 fe ff ff       	call   2c089e <remove_from_free_list>
        if (b->size > size + BLOCKSIZE) {
  2c09b7:	49 8d 44 24 18       	lea    0x18(%r12),%rax
  2c09bc:	48 39 03             	cmp    %rax,(%rbx)
  2c09bf:	77 2d                	ja     2c09ee <malloc+0x6c>
            split_block(b, size);
        }
    add_to_malloc_list(b);
  2c09c1:	48 89 df             	mov    %rbx,%rdi
  2c09c4:	e8 1b ff ff ff       	call   2c08e4 <add_to_malloc_list>
    num_allocs++;
  2c09c9:	83 05 30 26 00 00 01 	addl   $0x1,0x2630(%rip)        # 2c3000 <num_allocs>
    return (void*)((void*)b + BLOCKSIZE);
  2c09d0:	48 83 c3 18          	add    $0x18,%rbx
}
  2c09d4:	48 89 d8             	mov    %rbx,%rax
  2c09d7:	5b                   	pop    %rbx
  2c09d8:	41 5c                	pop    %r12
  2c09da:	5d                   	pop    %rbp
  2c09db:	c3                   	ret    
        b = new_block(size);
  2c09dc:	4c 89 e7             	mov    %r12,%rdi
  2c09df:	e8 ce fd ff ff       	call   2c07b2 <new_block>
  2c09e4:	48 89 c3             	mov    %rax,%rbx
        if (b == NULL) {
  2c09e7:	48 85 c0             	test   %rax,%rax
  2c09ea:	75 c3                	jne    2c09af <malloc+0x2d>
  2c09ec:	eb e6                	jmp    2c09d4 <malloc+0x52>
            split_block(b, size);
  2c09ee:	4c 89 e6             	mov    %r12,%rsi
  2c09f1:	48 89 df             	mov    %rbx,%rdi
  2c09f4:	e8 55 fe ff ff       	call   2c084e <split_block>
  2c09f9:	eb c6                	jmp    2c09c1 <malloc+0x3f>

00000000002c09fb <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  2c09fb:	f3 0f 1e fa          	endbr64 
  2c09ff:	55                   	push   %rbp
  2c0a00:	48 89 e5             	mov    %rsp,%rbp
  2c0a03:	41 54                	push   %r12
  2c0a05:	53                   	push   %rbx
    uint64_t total = num * sz;
  2c0a06:	48 0f af fe          	imul   %rsi,%rdi
  2c0a0a:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  2c0a0d:	e8 70 ff ff ff       	call   2c0982 <malloc>
  2c0a12:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  2c0a15:	48 85 c0             	test   %rax,%rax
  2c0a18:	74 10                	je     2c0a2a <calloc+0x2f>
        memset(ptr, 0, total);
  2c0a1a:	4c 89 e2             	mov    %r12,%rdx
  2c0a1d:	be 00 00 00 00       	mov    $0x0,%esi
  2c0a22:	48 89 c7             	mov    %rax,%rdi
  2c0a25:	e8 2b 04 00 00       	call   2c0e55 <memset>
    }
    return ptr;
}
  2c0a2a:	48 89 d8             	mov    %rbx,%rax
  2c0a2d:	5b                   	pop    %rbx
  2c0a2e:	41 5c                	pop    %r12
  2c0a30:	5d                   	pop    %rbp
  2c0a31:	c3                   	ret    

00000000002c0a32 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c0a32:	f3 0f 1e fa          	endbr64 
  2c0a36:	55                   	push   %rbp
  2c0a37:	48 89 e5             	mov    %rsp,%rbp
  2c0a3a:	41 54                	push   %r12
  2c0a3c:	53                   	push   %rbx
  2c0a3d:	48 89 fb             	mov    %rdi,%rbx
  2c0a40:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  2c0a43:	48 85 db             	test   %rbx,%rbx
  2c0a46:	74 2d                	je     2c0a75 <realloc+0x43>
        return malloc(sz);
    }
    if (sz == 0 && ptr != NULL) {
  2c0a48:	48 85 f6             	test   %rsi,%rsi
  2c0a4b:	74 32                	je     2c0a7f <realloc+0x4d>
    return (size + 7) / 8 * 8;
  2c0a4d:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  2c0a51:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi
    }
    // make sure to align the size
    block *b = (block*)((void*)ptr - BLOCKSIZE);
    size_t aligned_size = algn(sz);
    // check if can fit in current block
    if (b->size >= aligned_size) {
  2c0a55:	48 8b 43 e8          	mov    -0x18(%rbx),%rax
  2c0a59:	48 39 f0             	cmp    %rsi,%rax
  2c0a5c:	72 31                	jb     2c0a8f <realloc+0x5d>
        if (b->size > aligned_size + BLOCKSIZE) {
  2c0a5e:	48 8d 56 18          	lea    0x18(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr;
  2c0a62:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  2c0a65:	48 39 d0             	cmp    %rdx,%rax
  2c0a68:	76 49                	jbe    2c0ab3 <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE);
  2c0a6a:	48 8d 7b e8          	lea    -0x18(%rbx),%rdi
            split_block(b, aligned_size);
  2c0a6e:	e8 db fd ff ff       	call   2c084e <split_block>
  2c0a73:	eb 3e                	jmp    2c0ab3 <realloc+0x81>
        return malloc(sz);
  2c0a75:	e8 08 ff ff ff       	call   2c0982 <malloc>
  2c0a7a:	49 89 c4             	mov    %rax,%r12
  2c0a7d:	eb 34                	jmp    2c0ab3 <realloc+0x81>
        free(ptr);
  2c0a7f:	48 89 df             	mov    %rbx,%rdi
  2c0a82:	e8 c1 fe ff ff       	call   2c0948 <free>
        return NULL;
  2c0a87:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0a8d:	eb 24                	jmp    2c0ab3 <realloc+0x81>
    }

    void *new_ptr = malloc(sz);
  2c0a8f:	e8 ee fe ff ff       	call   2c0982 <malloc>
  2c0a94:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  2c0a97:	48 85 c0             	test   %rax,%rax
  2c0a9a:	74 17                	je     2c0ab3 <realloc+0x81>
        return NULL;
    }
    memcpy(new_ptr, ptr, b->size);
  2c0a9c:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  2c0aa0:	48 89 de             	mov    %rbx,%rsi
  2c0aa3:	48 89 c7             	mov    %rax,%rdi
  2c0aa6:	e8 a4 02 00 00       	call   2c0d4f <memcpy>
    free(ptr);
  2c0aab:	48 89 df             	mov    %rbx,%rdi
  2c0aae:	e8 95 fe ff ff       	call   2c0948 <free>
    return new_ptr;
}
  2c0ab3:	4c 89 e0             	mov    %r12,%rax
  2c0ab6:	5b                   	pop    %rbx
  2c0ab7:	41 5c                	pop    %r12
  2c0ab9:	5d                   	pop    %rbp
  2c0aba:	c3                   	ret    

00000000002c0abb <defrag>:

void defrag() {
  2c0abb:	f3 0f 1e fa          	endbr64 
  2c0abf:	55                   	push   %rbp
  2c0ac0:	48 89 e5             	mov    %rsp,%rbp
  2c0ac3:	53                   	push   %rbx
  2c0ac4:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = free_head;
  2c0ac8:	48 8b 1d 49 25 00 00 	mov    0x2549(%rip),%rbx        # 2c3018 <free_head>
    // merge free blocks that are next to each other
    while (b && b->next) { 
  2c0acf:	48 85 db             	test   %rbx,%rbx
  2c0ad2:	74 33                	je     2c0b07 <defrag+0x4c>
  2c0ad4:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
  2c0ad8:	48 85 ff             	test   %rdi,%rdi
  2c0adb:	74 2a                	je     2c0b07 <defrag+0x4c>
        block *next = b->next;
        if ((char *)b + b->size + BLOCKSIZE == (char *)next) {
  2c0add:	48 8b 03             	mov    (%rbx),%rax
  2c0ae0:	48 83 c0 18          	add    $0x18,%rax
  2c0ae4:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c0ae8:	48 39 d7             	cmp    %rdx,%rdi
  2c0aeb:	74 05                	je     2c0af2 <defrag+0x37>
    while (b && b->next) { 
  2c0aed:	48 89 fb             	mov    %rdi,%rbx
  2c0af0:	eb dd                	jmp    2c0acf <defrag+0x14>
            b->size += next->size + BLOCKSIZE;
  2c0af2:	48 03 07             	add    (%rdi),%rax
  2c0af5:	48 89 03             	mov    %rax,(%rbx)
            b->next = next->next; 
  2c0af8:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0afc:	48 89 43 08          	mov    %rax,0x8(%rbx)
            // remove 2nd one
            remove_from_free_list(next);
  2c0b00:	e8 99 fd ff ff       	call   2c089e <remove_from_free_list>
  2c0b05:	eb c8                	jmp    2c0acf <defrag+0x14>
        } else {
            b = b->next;
        }
    }
}
  2c0b07:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0b0b:	c9                   	leave  
  2c0b0c:	c3                   	ret    

00000000002c0b0d <sort_ptr_with_size>:

void sort_ptr_with_size(void **ptr_array, long *size_array, int allocs) {
  2c0b0d:	f3 0f 1e fa          	endbr64 
  2c0b11:	55                   	push   %rbp
  2c0b12:	48 89 e5             	mov    %rsp,%rbp
  2c0b15:	41 57                	push   %r15
  2c0b17:	41 56                	push   %r14
  2c0b19:	41 55                	push   %r13
  2c0b1b:	41 54                	push   %r12
  2c0b1d:	53                   	push   %rbx
  2c0b1e:	48 83 ec 18          	sub    $0x18,%rsp
  2c0b22:	49 89 fd             	mov    %rdi,%r13
  2c0b25:	49 89 f6             	mov    %rsi,%r14
  2c0b28:	41 89 d4             	mov    %edx,%r12d
    ptr_with_size *combined_array = (ptr_with_size *)malloc(allocs * sizeof(ptr_with_size));
  2c0b2b:	4c 63 fa             	movslq %edx,%r15
  2c0b2e:	4c 89 ff             	mov    %r15,%rdi
  2c0b31:	48 c1 e7 04          	shl    $0x4,%rdi
  2c0b35:	e8 48 fe ff ff       	call   2c0982 <malloc>
    if (!combined_array) return; 
  2c0b3a:	48 85 c0             	test   %rax,%rax
  2c0b3d:	0f 84 99 00 00 00    	je     2c0bdc <sort_ptr_with_size+0xcf>
  2c0b43:	48 89 c3             	mov    %rax,%rbx
    // janky way to avoid getting combined array in heapinfo stats
    block *b = (block *)((char *)combined_array - BLOCKSIZE);
  2c0b46:	48 8d 40 e8          	lea    -0x18(%rax),%rax
  2c0b4a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    remove_from_malloc_list(b);
  2c0b4e:	48 89 c7             	mov    %rax,%rdi
  2c0b51:	e8 ac fd ff ff       	call   2c0902 <remove_from_malloc_list>
    num_allocs--;
  2c0b56:	83 2d a3 24 00 00 01 	subl   $0x1,0x24a3(%rip)        # 2c3000 <num_allocs>

    for (int i = 0; i < allocs; i++) {
  2c0b5d:	45 85 e4             	test   %r12d,%r12d
  2c0b60:	0f 8e 85 00 00 00    	jle    2c0beb <sort_ptr_with_size+0xde>
  2c0b66:	45 89 e4             	mov    %r12d,%r12d
  2c0b69:	49 c1 e4 03          	shl    $0x3,%r12
  2c0b6d:	b8 00 00 00 00       	mov    $0x0,%eax
        combined_array[i].ptr = ptr_array[i];
  2c0b72:	49 8b 54 05 00       	mov    0x0(%r13,%rax,1),%rdx
  2c0b77:	48 89 14 43          	mov    %rdx,(%rbx,%rax,2)
        combined_array[i].size = size_array[i];
  2c0b7b:	49 8b 14 06          	mov    (%r14,%rax,1),%rdx
  2c0b7f:	48 89 54 43 08       	mov    %rdx,0x8(%rbx,%rax,2)
    for (int i = 0; i < allocs; i++) {
  2c0b84:	48 83 c0 08          	add    $0x8,%rax
  2c0b88:	4c 39 e0             	cmp    %r12,%rax
  2c0b8b:	75 e5                	jne    2c0b72 <sort_ptr_with_size+0x65>
    }
    _quicksort1(combined_array, allocs, sizeof(ptr_with_size), ptr_comparator1);
  2c0b8d:	48 8d 0d a5 f7 ff ff 	lea    -0x85b(%rip),%rcx        # 2c0339 <ptr_comparator1>
  2c0b94:	ba 10 00 00 00       	mov    $0x10,%edx
  2c0b99:	4c 89 fe             	mov    %r15,%rsi
  2c0b9c:	48 89 df             	mov    %rbx,%rdi
  2c0b9f:	e8 a1 f7 ff ff       	call   2c0345 <_quicksort1>
  2c0ba4:	b8 00 00 00 00       	mov    $0x0,%eax

    for (int i = 0; i < allocs; i++) {
        ptr_array[i] = combined_array[i].ptr;
  2c0ba9:	48 8b 14 43          	mov    (%rbx,%rax,2),%rdx
  2c0bad:	49 89 54 05 00       	mov    %rdx,0x0(%r13,%rax,1)
        size_array[i] = combined_array[i].size;
  2c0bb2:	48 8b 54 43 08       	mov    0x8(%rbx,%rax,2),%rdx
  2c0bb7:	49 89 14 06          	mov    %rdx,(%r14,%rax,1)
    for (int i = 0; i < allocs; i++) {
  2c0bbb:	48 83 c0 08          	add    $0x8,%rax
  2c0bbf:	4c 39 e0             	cmp    %r12,%rax
  2c0bc2:	75 e5                	jne    2c0ba9 <sort_ptr_with_size+0x9c>
    }
    free(combined_array);
  2c0bc4:	48 89 df             	mov    %rbx,%rdi
  2c0bc7:	e8 7c fd ff ff       	call   2c0948 <free>
    // manually remove from free list
    remove_from_free_list(b);
  2c0bcc:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  2c0bd0:	e8 c9 fc ff ff       	call   2c089e <remove_from_free_list>
    num_allocs++;
  2c0bd5:	83 05 24 24 00 00 01 	addl   $0x1,0x2424(%rip)        # 2c3000 <num_allocs>
}
  2c0bdc:	48 83 c4 18          	add    $0x18,%rsp
  2c0be0:	5b                   	pop    %rbx
  2c0be1:	41 5c                	pop    %r12
  2c0be3:	41 5d                	pop    %r13
  2c0be5:	41 5e                	pop    %r14
  2c0be7:	41 5f                	pop    %r15
  2c0be9:	5d                   	pop    %rbp
  2c0bea:	c3                   	ret    
    _quicksort1(combined_array, allocs, sizeof(ptr_with_size), ptr_comparator1);
  2c0beb:	48 8d 0d 47 f7 ff ff 	lea    -0x8b9(%rip),%rcx        # 2c0339 <ptr_comparator1>
  2c0bf2:	ba 10 00 00 00       	mov    $0x10,%edx
  2c0bf7:	4c 89 fe             	mov    %r15,%rsi
  2c0bfa:	48 89 df             	mov    %rbx,%rdi
  2c0bfd:	e8 43 f7 ff ff       	call   2c0345 <_quicksort1>
    for (int i = 0; i < allocs; i++) {
  2c0c02:	eb c0                	jmp    2c0bc4 <sort_ptr_with_size+0xb7>

00000000002c0c04 <heap_info>:

int heap_info(heap_info_struct * info) {
  2c0c04:	f3 0f 1e fa          	endbr64 
  2c0c08:	55                   	push   %rbp
  2c0c09:	48 89 e5             	mov    %rsp,%rbp
  2c0c0c:	41 57                	push   %r15
  2c0c0e:	41 56                	push   %r14
  2c0c10:	41 55                	push   %r13
  2c0c12:	41 54                	push   %r12
  2c0c14:	53                   	push   %rbx
  2c0c15:	48 83 ec 08          	sub    $0x8,%rsp
  2c0c19:	49 89 fd             	mov    %rdi,%r13
    // if no allocations
    if (num_allocs == 0) {
  2c0c1c:	8b 05 de 23 00 00    	mov    0x23de(%rip),%eax        # 2c3000 <num_allocs>
  2c0c22:	85 c0                	test   %eax,%eax
  2c0c24:	75 2d                	jne    2c0c53 <heap_info+0x4f>
    info->size_array = NULL;
  2c0c26:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c0c2d:	00 
    info->ptr_array = NULL;
  2c0c2e:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  2c0c35:	00 
    info->free_space = 0;
  2c0c36:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
    info->largest_free_chunk = 0;
  2c0c3d:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)
    info->size_array = size_array;
    info->ptr_array = ptr_array;
    info->free_space = (int)free_space;
    info->largest_free_chunk = (int)largest_free_chunk + BLOCKSIZE;
    return 0;
  2c0c44:	48 83 c4 08          	add    $0x8,%rsp
  2c0c48:	5b                   	pop    %rbx
  2c0c49:	41 5c                	pop    %r12
  2c0c4b:	41 5d                	pop    %r13
  2c0c4d:	41 5e                	pop    %r14
  2c0c4f:	41 5f                	pop    %r15
  2c0c51:	5d                   	pop    %rbp
  2c0c52:	c3                   	ret    
    info->num_allocs = num_allocs;
  2c0c53:	89 07                	mov    %eax,(%rdi)
    long *size_array = (long*)malloc((num_allocs) * sizeof(long));
  2c0c55:	48 98                	cltq   
  2c0c57:	48 8d 3c c5 00 00 00 	lea    0x0(,%rax,8),%rdi
  2c0c5e:	00 
  2c0c5f:	e8 1e fd ff ff       	call   2c0982 <malloc>
  2c0c64:	49 89 c7             	mov    %rax,%r15
    void **ptr_array = (void**)malloc((num_allocs) * sizeof(void*));
  2c0c67:	48 63 3d 92 23 00 00 	movslq 0x2392(%rip),%rdi        # 2c3000 <num_allocs>
  2c0c6e:	48 c1 e7 03          	shl    $0x3,%rdi
  2c0c72:	e8 0b fd ff ff       	call   2c0982 <malloc>
  2c0c77:	49 89 c6             	mov    %rax,%r14
    if (!size_array || !ptr_array) {
  2c0c7a:	4d 85 ff             	test   %r15,%r15
  2c0c7d:	0f 84 a2 00 00 00    	je     2c0d25 <heap_info+0x121>
  2c0c83:	48 85 c0             	test   %rax,%rax
  2c0c86:	0f 84 99 00 00 00    	je     2c0d25 <heap_info+0x121>
    block *bf = free_head;
  2c0c8c:	48 8b 05 85 23 00 00 	mov    0x2385(%rip),%rax        # 2c3018 <free_head>
    while (bf) {
  2c0c93:	48 85 c0             	test   %rax,%rax
  2c0c96:	0f 84 a3 00 00 00    	je     2c0d3f <heap_info+0x13b>
    size_t largest_free_chunk = 0;
  2c0c9c:	bb 00 00 00 00       	mov    $0x0,%ebx
    size_t free_space = 0;
  2c0ca1:	41 bc 00 00 00 00    	mov    $0x0,%r12d
        free_space += bf->size + BLOCKSIZE;
  2c0ca7:	48 8b 10             	mov    (%rax),%rdx
  2c0caa:	4e 8d 64 22 18       	lea    0x18(%rdx,%r12,1),%r12
        if (bf->size > largest_free_chunk) {
  2c0caf:	48 39 d3             	cmp    %rdx,%rbx
  2c0cb2:	48 0f 42 da          	cmovb  %rdx,%rbx
        bf = bf->next;
  2c0cb6:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bf) {
  2c0cba:	48 85 c0             	test   %rax,%rax
  2c0cbd:	75 e8                	jne    2c0ca7 <heap_info+0xa3>
    block *bm = malloc_head->next->next;
  2c0cbf:	48 8b 05 4a 23 00 00 	mov    0x234a(%rip),%rax        # 2c3010 <malloc_head>
  2c0cc6:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0cca:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bm) {
  2c0cce:	48 85 c0             	test   %rax,%rax
  2c0cd1:	74 21                	je     2c0cf4 <heap_info+0xf0>
  2c0cd3:	ba 00 00 00 00       	mov    $0x0,%edx
        size_array[x] = bm->size;
  2c0cd8:	48 8b 08             	mov    (%rax),%rcx
  2c0cdb:	49 89 0c 17          	mov    %rcx,(%r15,%rdx,1)
        ptr_array[x] = (void*)((void*)bm + BLOCKSIZE);
  2c0cdf:	48 8d 48 18          	lea    0x18(%rax),%rcx
  2c0ce3:	49 89 0c 16          	mov    %rcx,(%r14,%rdx,1)
        bm = bm->next;
  2c0ce7:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bm) {
  2c0ceb:	48 83 c2 08          	add    $0x8,%rdx
  2c0cef:	48 85 c0             	test   %rax,%rax
  2c0cf2:	75 e4                	jne    2c0cd8 <heap_info+0xd4>
    sort_ptr_with_size(ptr_array, size_array, num_allocs-2);
  2c0cf4:	8b 05 06 23 00 00    	mov    0x2306(%rip),%eax        # 2c3000 <num_allocs>
  2c0cfa:	8d 50 fe             	lea    -0x2(%rax),%edx
  2c0cfd:	4c 89 fe             	mov    %r15,%rsi
  2c0d00:	4c 89 f7             	mov    %r14,%rdi
  2c0d03:	e8 05 fe ff ff       	call   2c0b0d <sort_ptr_with_size>
    info->size_array = size_array;
  2c0d08:	4d 89 7d 08          	mov    %r15,0x8(%r13)
    info->ptr_array = ptr_array;
  2c0d0c:	4d 89 75 10          	mov    %r14,0x10(%r13)
    info->free_space = (int)free_space;
  2c0d10:	45 89 65 18          	mov    %r12d,0x18(%r13)
    info->largest_free_chunk = (int)largest_free_chunk + BLOCKSIZE;
  2c0d14:	83 c3 18             	add    $0x18,%ebx
  2c0d17:	41 89 5d 1c          	mov    %ebx,0x1c(%r13)
    return 0;
  2c0d1b:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0d20:	e9 1f ff ff ff       	jmp    2c0c44 <heap_info+0x40>
        free(size_array);
  2c0d25:	4c 89 ff             	mov    %r15,%rdi
  2c0d28:	e8 1b fc ff ff       	call   2c0948 <free>
        free(ptr_array);
  2c0d2d:	4c 89 f7             	mov    %r14,%rdi
  2c0d30:	e8 13 fc ff ff       	call   2c0948 <free>
        return -1;
  2c0d35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0d3a:	e9 05 ff ff ff       	jmp    2c0c44 <heap_info+0x40>
    size_t largest_free_chunk = 0;
  2c0d3f:	bb 00 00 00 00       	mov    $0x0,%ebx
    size_t free_space = 0;
  2c0d44:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0d4a:	e9 70 ff ff ff       	jmp    2c0cbf <heap_info+0xbb>

00000000002c0d4f <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0d4f:	f3 0f 1e fa          	endbr64 
  2c0d53:	55                   	push   %rbp
  2c0d54:	48 89 e5             	mov    %rsp,%rbp
  2c0d57:	48 83 ec 28          	sub    $0x28,%rsp
  2c0d5b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0d5f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0d63:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0d67:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0d6b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0d6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0d73:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0d77:	eb 1c                	jmp    2c0d95 <memcpy+0x46>
        *d = *s;
  2c0d79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0d7d:	0f b6 10             	movzbl (%rax),%edx
  2c0d80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0d84:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0d86:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0d8b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0d90:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0d95:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0d9a:	75 dd                	jne    2c0d79 <memcpy+0x2a>
    }
    return dst;
  2c0d9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0da0:	c9                   	leave  
  2c0da1:	c3                   	ret    

00000000002c0da2 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0da2:	f3 0f 1e fa          	endbr64 
  2c0da6:	55                   	push   %rbp
  2c0da7:	48 89 e5             	mov    %rsp,%rbp
  2c0daa:	48 83 ec 28          	sub    $0x28,%rsp
  2c0dae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0db2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0db6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0dba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0dbe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0dc2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0dc6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0dca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0dce:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0dd2:	73 6a                	jae    2c0e3e <memmove+0x9c>
  2c0dd4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0dd8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0ddc:	48 01 d0             	add    %rdx,%rax
  2c0ddf:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0de3:	73 59                	jae    2c0e3e <memmove+0x9c>
        s += n, d += n;
  2c0de5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0de9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0ded:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0df1:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0df5:	eb 17                	jmp    2c0e0e <memmove+0x6c>
            *--d = *--s;
  2c0df7:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0dfc:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0e01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0e05:	0f b6 10             	movzbl (%rax),%edx
  2c0e08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0e0c:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0e0e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0e12:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0e16:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0e1a:	48 85 c0             	test   %rax,%rax
  2c0e1d:	75 d8                	jne    2c0df7 <memmove+0x55>
    if (s < d && s + n > d) {
  2c0e1f:	eb 2e                	jmp    2c0e4f <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0e21:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0e25:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0e29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0e2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0e31:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0e35:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0e39:	0f b6 12             	movzbl (%rdx),%edx
  2c0e3c:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0e3e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0e42:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0e46:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0e4a:	48 85 c0             	test   %rax,%rax
  2c0e4d:	75 d2                	jne    2c0e21 <memmove+0x7f>
        }
    }
    return dst;
  2c0e4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0e53:	c9                   	leave  
  2c0e54:	c3                   	ret    

00000000002c0e55 <memset>:

void* memset(void* v, int c, size_t n) {
  2c0e55:	f3 0f 1e fa          	endbr64 
  2c0e59:	55                   	push   %rbp
  2c0e5a:	48 89 e5             	mov    %rsp,%rbp
  2c0e5d:	48 83 ec 28          	sub    $0x28,%rsp
  2c0e61:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0e65:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0e68:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0e6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0e70:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0e74:	eb 15                	jmp    2c0e8b <memset+0x36>
        *p = c;
  2c0e76:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0e79:	89 c2                	mov    %eax,%edx
  2c0e7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0e7f:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0e81:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0e86:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0e8b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0e90:	75 e4                	jne    2c0e76 <memset+0x21>
    }
    return v;
  2c0e92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0e96:	c9                   	leave  
  2c0e97:	c3                   	ret    

00000000002c0e98 <strlen>:

size_t strlen(const char* s) {
  2c0e98:	f3 0f 1e fa          	endbr64 
  2c0e9c:	55                   	push   %rbp
  2c0e9d:	48 89 e5             	mov    %rsp,%rbp
  2c0ea0:	48 83 ec 18          	sub    $0x18,%rsp
  2c0ea4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0ea8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0eaf:	00 
  2c0eb0:	eb 0a                	jmp    2c0ebc <strlen+0x24>
        ++n;
  2c0eb2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0eb7:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0ebc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0ec0:	0f b6 00             	movzbl (%rax),%eax
  2c0ec3:	84 c0                	test   %al,%al
  2c0ec5:	75 eb                	jne    2c0eb2 <strlen+0x1a>
    }
    return n;
  2c0ec7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0ecb:	c9                   	leave  
  2c0ecc:	c3                   	ret    

00000000002c0ecd <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0ecd:	f3 0f 1e fa          	endbr64 
  2c0ed1:	55                   	push   %rbp
  2c0ed2:	48 89 e5             	mov    %rsp,%rbp
  2c0ed5:	48 83 ec 20          	sub    $0x20,%rsp
  2c0ed9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0edd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0ee1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0ee8:	00 
  2c0ee9:	eb 0a                	jmp    2c0ef5 <strnlen+0x28>
        ++n;
  2c0eeb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0ef0:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0ef5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ef9:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0efd:	74 0b                	je     2c0f0a <strnlen+0x3d>
  2c0eff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0f03:	0f b6 00             	movzbl (%rax),%eax
  2c0f06:	84 c0                	test   %al,%al
  2c0f08:	75 e1                	jne    2c0eeb <strnlen+0x1e>
    }
    return n;
  2c0f0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0f0e:	c9                   	leave  
  2c0f0f:	c3                   	ret    

00000000002c0f10 <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0f10:	f3 0f 1e fa          	endbr64 
  2c0f14:	55                   	push   %rbp
  2c0f15:	48 89 e5             	mov    %rsp,%rbp
  2c0f18:	48 83 ec 20          	sub    $0x20,%rsp
  2c0f1c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0f20:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0f24:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0f28:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0f2c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0f30:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0f34:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0f38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f3c:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0f40:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0f44:	0f b6 12             	movzbl (%rdx),%edx
  2c0f47:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0f49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f4d:	48 83 e8 01          	sub    $0x1,%rax
  2c0f51:	0f b6 00             	movzbl (%rax),%eax
  2c0f54:	84 c0                	test   %al,%al
  2c0f56:	75 d4                	jne    2c0f2c <strcpy+0x1c>
    return dst;
  2c0f58:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0f5c:	c9                   	leave  
  2c0f5d:	c3                   	ret    

00000000002c0f5e <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0f5e:	f3 0f 1e fa          	endbr64 
  2c0f62:	55                   	push   %rbp
  2c0f63:	48 89 e5             	mov    %rsp,%rbp
  2c0f66:	48 83 ec 10          	sub    $0x10,%rsp
  2c0f6a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0f6e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0f72:	eb 0a                	jmp    2c0f7e <strcmp+0x20>
        ++a, ++b;
  2c0f74:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0f79:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0f7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f82:	0f b6 00             	movzbl (%rax),%eax
  2c0f85:	84 c0                	test   %al,%al
  2c0f87:	74 1d                	je     2c0fa6 <strcmp+0x48>
  2c0f89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0f8d:	0f b6 00             	movzbl (%rax),%eax
  2c0f90:	84 c0                	test   %al,%al
  2c0f92:	74 12                	je     2c0fa6 <strcmp+0x48>
  2c0f94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f98:	0f b6 10             	movzbl (%rax),%edx
  2c0f9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0f9f:	0f b6 00             	movzbl (%rax),%eax
  2c0fa2:	38 c2                	cmp    %al,%dl
  2c0fa4:	74 ce                	je     2c0f74 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0fa6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0faa:	0f b6 00             	movzbl (%rax),%eax
  2c0fad:	89 c2                	mov    %eax,%edx
  2c0faf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0fb3:	0f b6 00             	movzbl (%rax),%eax
  2c0fb6:	38 c2                	cmp    %al,%dl
  2c0fb8:	0f 97 c0             	seta   %al
  2c0fbb:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0fbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0fc2:	0f b6 00             	movzbl (%rax),%eax
  2c0fc5:	89 c1                	mov    %eax,%ecx
  2c0fc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0fcb:	0f b6 00             	movzbl (%rax),%eax
  2c0fce:	38 c1                	cmp    %al,%cl
  2c0fd0:	0f 92 c0             	setb   %al
  2c0fd3:	0f b6 c8             	movzbl %al,%ecx
  2c0fd6:	89 d0                	mov    %edx,%eax
  2c0fd8:	29 c8                	sub    %ecx,%eax
}
  2c0fda:	c9                   	leave  
  2c0fdb:	c3                   	ret    

00000000002c0fdc <strchr>:

char* strchr(const char* s, int c) {
  2c0fdc:	f3 0f 1e fa          	endbr64 
  2c0fe0:	55                   	push   %rbp
  2c0fe1:	48 89 e5             	mov    %rsp,%rbp
  2c0fe4:	48 83 ec 10          	sub    $0x10,%rsp
  2c0fe8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0fec:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0fef:	eb 05                	jmp    2c0ff6 <strchr+0x1a>
        ++s;
  2c0ff1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0ff6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ffa:	0f b6 00             	movzbl (%rax),%eax
  2c0ffd:	84 c0                	test   %al,%al
  2c0fff:	74 0e                	je     2c100f <strchr+0x33>
  2c1001:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1005:	0f b6 00             	movzbl (%rax),%eax
  2c1008:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c100b:	38 d0                	cmp    %dl,%al
  2c100d:	75 e2                	jne    2c0ff1 <strchr+0x15>
    }
    if (*s == (char) c) {
  2c100f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1013:	0f b6 00             	movzbl (%rax),%eax
  2c1016:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c1019:	38 d0                	cmp    %dl,%al
  2c101b:	75 06                	jne    2c1023 <strchr+0x47>
        return (char*) s;
  2c101d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1021:	eb 05                	jmp    2c1028 <strchr+0x4c>
    } else {
        return NULL;
  2c1023:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c1028:	c9                   	leave  
  2c1029:	c3                   	ret    

00000000002c102a <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c102a:	f3 0f 1e fa          	endbr64 
  2c102e:	55                   	push   %rbp
  2c102f:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c1032:	8b 05 e8 1f 00 00    	mov    0x1fe8(%rip),%eax        # 2c3020 <rand_seed_set>
  2c1038:	85 c0                	test   %eax,%eax
  2c103a:	75 0a                	jne    2c1046 <rand+0x1c>
        srand(819234718U);
  2c103c:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c1041:	e8 24 00 00 00       	call   2c106a <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c1046:	8b 05 d8 1f 00 00    	mov    0x1fd8(%rip),%eax        # 2c3024 <rand_seed>
  2c104c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c1052:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c1057:	89 05 c7 1f 00 00    	mov    %eax,0x1fc7(%rip)        # 2c3024 <rand_seed>
    return rand_seed & RAND_MAX;
  2c105d:	8b 05 c1 1f 00 00    	mov    0x1fc1(%rip),%eax        # 2c3024 <rand_seed>
  2c1063:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c1068:	5d                   	pop    %rbp
  2c1069:	c3                   	ret    

00000000002c106a <srand>:

void srand(unsigned seed) {
  2c106a:	f3 0f 1e fa          	endbr64 
  2c106e:	55                   	push   %rbp
  2c106f:	48 89 e5             	mov    %rsp,%rbp
  2c1072:	48 83 ec 08          	sub    $0x8,%rsp
  2c1076:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c1079:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c107c:	89 05 a2 1f 00 00    	mov    %eax,0x1fa2(%rip)        # 2c3024 <rand_seed>
    rand_seed_set = 1;
  2c1082:	c7 05 94 1f 00 00 01 	movl   $0x1,0x1f94(%rip)        # 2c3020 <rand_seed_set>
  2c1089:	00 00 00 
}
  2c108c:	90                   	nop
  2c108d:	c9                   	leave  
  2c108e:	c3                   	ret    

00000000002c108f <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c108f:	f3 0f 1e fa          	endbr64 
  2c1093:	55                   	push   %rbp
  2c1094:	48 89 e5             	mov    %rsp,%rbp
  2c1097:	48 83 ec 28          	sub    $0x28,%rsp
  2c109b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c109f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c10a3:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c10a6:	48 8d 05 93 0f 00 00 	lea    0xf93(%rip),%rax        # 2c2040 <upper_digits.1>
  2c10ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  2c10b1:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c10b5:	79 0e                	jns    2c10c5 <fill_numbuf+0x36>
        digits = lower_digits;
  2c10b7:	48 8d 05 a2 0f 00 00 	lea    0xfa2(%rip),%rax        # 2c2060 <lower_digits.0>
  2c10be:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  2c10c2:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c10c5:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c10ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c10ce:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c10d1:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c10d4:	48 63 c8             	movslq %eax,%rcx
  2c10d7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c10db:	ba 00 00 00 00       	mov    $0x0,%edx
  2c10e0:	48 f7 f1             	div    %rcx
  2c10e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c10e7:	48 01 d0             	add    %rdx,%rax
  2c10ea:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c10ef:	0f b6 10             	movzbl (%rax),%edx
  2c10f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c10f6:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c10f8:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c10fb:	48 63 f0             	movslq %eax,%rsi
  2c10fe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c1102:	ba 00 00 00 00       	mov    $0x0,%edx
  2c1107:	48 f7 f6             	div    %rsi
  2c110a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c110e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c1113:	75 bc                	jne    2c10d1 <fill_numbuf+0x42>
    return numbuf_end;
  2c1115:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c1119:	c9                   	leave  
  2c111a:	c3                   	ret    

00000000002c111b <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c111b:	f3 0f 1e fa          	endbr64 
  2c111f:	55                   	push   %rbp
  2c1120:	48 89 e5             	mov    %rsp,%rbp
  2c1123:	53                   	push   %rbx
  2c1124:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c112b:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c1132:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c1138:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c113f:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c1146:	e9 bd 09 00 00       	jmp    2c1b08 <printer_vprintf+0x9ed>
        if (*format != '%') {
  2c114b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1152:	0f b6 00             	movzbl (%rax),%eax
  2c1155:	3c 25                	cmp    $0x25,%al
  2c1157:	74 31                	je     2c118a <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  2c1159:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1160:	4c 8b 00             	mov    (%rax),%r8
  2c1163:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c116a:	0f b6 00             	movzbl (%rax),%eax
  2c116d:	0f b6 c8             	movzbl %al,%ecx
  2c1170:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1176:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c117d:	89 ce                	mov    %ecx,%esi
  2c117f:	48 89 c7             	mov    %rax,%rdi
  2c1182:	41 ff d0             	call   *%r8
            continue;
  2c1185:	e9 76 09 00 00       	jmp    2c1b00 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  2c118a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c1191:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1198:	01 
  2c1199:	eb 4d                	jmp    2c11e8 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  2c119b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11a2:	0f b6 00             	movzbl (%rax),%eax
  2c11a5:	0f be c0             	movsbl %al,%eax
  2c11a8:	89 c6                	mov    %eax,%esi
  2c11aa:	48 8d 05 8f 0d 00 00 	lea    0xd8f(%rip),%rax        # 2c1f40 <flag_chars>
  2c11b1:	48 89 c7             	mov    %rax,%rdi
  2c11b4:	e8 23 fe ff ff       	call   2c0fdc <strchr>
  2c11b9:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c11bd:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c11c2:	74 34                	je     2c11f8 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  2c11c4:	48 8d 15 75 0d 00 00 	lea    0xd75(%rip),%rdx        # 2c1f40 <flag_chars>
  2c11cb:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c11cf:	48 29 d0             	sub    %rdx,%rax
  2c11d2:	ba 01 00 00 00       	mov    $0x1,%edx
  2c11d7:	89 c1                	mov    %eax,%ecx
  2c11d9:	d3 e2                	shl    %cl,%edx
  2c11db:	89 d0                	mov    %edx,%eax
  2c11dd:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c11e0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c11e7:	01 
  2c11e8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11ef:	0f b6 00             	movzbl (%rax),%eax
  2c11f2:	84 c0                	test   %al,%al
  2c11f4:	75 a5                	jne    2c119b <printer_vprintf+0x80>
  2c11f6:	eb 01                	jmp    2c11f9 <printer_vprintf+0xde>
            } else {
                break;
  2c11f8:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c11f9:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c1200:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1207:	0f b6 00             	movzbl (%rax),%eax
  2c120a:	3c 30                	cmp    $0x30,%al
  2c120c:	7e 67                	jle    2c1275 <printer_vprintf+0x15a>
  2c120e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1215:	0f b6 00             	movzbl (%rax),%eax
  2c1218:	3c 39                	cmp    $0x39,%al
  2c121a:	7f 59                	jg     2c1275 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c121c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c1223:	eb 2e                	jmp    2c1253 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  2c1225:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c1228:	89 d0                	mov    %edx,%eax
  2c122a:	c1 e0 02             	shl    $0x2,%eax
  2c122d:	01 d0                	add    %edx,%eax
  2c122f:	01 c0                	add    %eax,%eax
  2c1231:	89 c1                	mov    %eax,%ecx
  2c1233:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c123a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c123e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c1245:	0f b6 00             	movzbl (%rax),%eax
  2c1248:	0f be c0             	movsbl %al,%eax
  2c124b:	01 c8                	add    %ecx,%eax
  2c124d:	83 e8 30             	sub    $0x30,%eax
  2c1250:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c1253:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c125a:	0f b6 00             	movzbl (%rax),%eax
  2c125d:	3c 2f                	cmp    $0x2f,%al
  2c125f:	0f 8e 85 00 00 00    	jle    2c12ea <printer_vprintf+0x1cf>
  2c1265:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c126c:	0f b6 00             	movzbl (%rax),%eax
  2c126f:	3c 39                	cmp    $0x39,%al
  2c1271:	7e b2                	jle    2c1225 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  2c1273:	eb 75                	jmp    2c12ea <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  2c1275:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c127c:	0f b6 00             	movzbl (%rax),%eax
  2c127f:	3c 2a                	cmp    $0x2a,%al
  2c1281:	75 68                	jne    2c12eb <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  2c1283:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c128a:	8b 00                	mov    (%rax),%eax
  2c128c:	83 f8 2f             	cmp    $0x2f,%eax
  2c128f:	77 30                	ja     2c12c1 <printer_vprintf+0x1a6>
  2c1291:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1298:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c129c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12a3:	8b 00                	mov    (%rax),%eax
  2c12a5:	89 c0                	mov    %eax,%eax
  2c12a7:	48 01 d0             	add    %rdx,%rax
  2c12aa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12b1:	8b 12                	mov    (%rdx),%edx
  2c12b3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c12b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12bd:	89 0a                	mov    %ecx,(%rdx)
  2c12bf:	eb 1a                	jmp    2c12db <printer_vprintf+0x1c0>
  2c12c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12c8:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c12cc:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c12d0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12d7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c12db:	8b 00                	mov    (%rax),%eax
  2c12dd:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c12e0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c12e7:	01 
  2c12e8:	eb 01                	jmp    2c12eb <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  2c12ea:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c12eb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c12f2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c12f9:	0f b6 00             	movzbl (%rax),%eax
  2c12fc:	3c 2e                	cmp    $0x2e,%al
  2c12fe:	0f 85 00 01 00 00    	jne    2c1404 <printer_vprintf+0x2e9>
            ++format;
  2c1304:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c130b:	01 
            if (*format >= '0' && *format <= '9') {
  2c130c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1313:	0f b6 00             	movzbl (%rax),%eax
  2c1316:	3c 2f                	cmp    $0x2f,%al
  2c1318:	7e 67                	jle    2c1381 <printer_vprintf+0x266>
  2c131a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1321:	0f b6 00             	movzbl (%rax),%eax
  2c1324:	3c 39                	cmp    $0x39,%al
  2c1326:	7f 59                	jg     2c1381 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c1328:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c132f:	eb 2e                	jmp    2c135f <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  2c1331:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c1334:	89 d0                	mov    %edx,%eax
  2c1336:	c1 e0 02             	shl    $0x2,%eax
  2c1339:	01 d0                	add    %edx,%eax
  2c133b:	01 c0                	add    %eax,%eax
  2c133d:	89 c1                	mov    %eax,%ecx
  2c133f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1346:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c134a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c1351:	0f b6 00             	movzbl (%rax),%eax
  2c1354:	0f be c0             	movsbl %al,%eax
  2c1357:	01 c8                	add    %ecx,%eax
  2c1359:	83 e8 30             	sub    $0x30,%eax
  2c135c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c135f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1366:	0f b6 00             	movzbl (%rax),%eax
  2c1369:	3c 2f                	cmp    $0x2f,%al
  2c136b:	0f 8e 85 00 00 00    	jle    2c13f6 <printer_vprintf+0x2db>
  2c1371:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1378:	0f b6 00             	movzbl (%rax),%eax
  2c137b:	3c 39                	cmp    $0x39,%al
  2c137d:	7e b2                	jle    2c1331 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  2c137f:	eb 75                	jmp    2c13f6 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  2c1381:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1388:	0f b6 00             	movzbl (%rax),%eax
  2c138b:	3c 2a                	cmp    $0x2a,%al
  2c138d:	75 68                	jne    2c13f7 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  2c138f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1396:	8b 00                	mov    (%rax),%eax
  2c1398:	83 f8 2f             	cmp    $0x2f,%eax
  2c139b:	77 30                	ja     2c13cd <printer_vprintf+0x2b2>
  2c139d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13a4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c13a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13af:	8b 00                	mov    (%rax),%eax
  2c13b1:	89 c0                	mov    %eax,%eax
  2c13b3:	48 01 d0             	add    %rdx,%rax
  2c13b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13bd:	8b 12                	mov    (%rdx),%edx
  2c13bf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c13c2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13c9:	89 0a                	mov    %ecx,(%rdx)
  2c13cb:	eb 1a                	jmp    2c13e7 <printer_vprintf+0x2cc>
  2c13cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13d4:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c13d8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c13dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13e3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c13e7:	8b 00                	mov    (%rax),%eax
  2c13e9:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c13ec:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c13f3:	01 
  2c13f4:	eb 01                	jmp    2c13f7 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  2c13f6:	90                   	nop
            }
            if (precision < 0) {
  2c13f7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c13fb:	79 07                	jns    2c1404 <printer_vprintf+0x2e9>
                precision = 0;
  2c13fd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c1404:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c140b:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c1412:	00 
        int length = 0;
  2c1413:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c141a:	48 8d 05 25 0b 00 00 	lea    0xb25(%rip),%rax        # 2c1f46 <flag_chars+0x6>
  2c1421:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  2c1425:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c142c:	0f b6 00             	movzbl (%rax),%eax
  2c142f:	0f be c0             	movsbl %al,%eax
  2c1432:	83 e8 43             	sub    $0x43,%eax
  2c1435:	83 f8 37             	cmp    $0x37,%eax
  2c1438:	0f 87 b6 03 00 00    	ja     2c17f4 <printer_vprintf+0x6d9>
  2c143e:	89 c0                	mov    %eax,%eax
  2c1440:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  2c1447:	00 
  2c1448:	48 8d 05 05 0b 00 00 	lea    0xb05(%rip),%rax        # 2c1f54 <flag_chars+0x14>
  2c144f:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  2c1452:	48 98                	cltq   
  2c1454:	48 8d 15 f9 0a 00 00 	lea    0xaf9(%rip),%rdx        # 2c1f54 <flag_chars+0x14>
  2c145b:	48 01 d0             	add    %rdx,%rax
  2c145e:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  2c1461:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c1468:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c146f:	01 
            goto again;
  2c1470:	eb b3                	jmp    2c1425 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c1472:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c1476:	74 5d                	je     2c14d5 <printer_vprintf+0x3ba>
  2c1478:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c147f:	8b 00                	mov    (%rax),%eax
  2c1481:	83 f8 2f             	cmp    $0x2f,%eax
  2c1484:	77 30                	ja     2c14b6 <printer_vprintf+0x39b>
  2c1486:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c148d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1491:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1498:	8b 00                	mov    (%rax),%eax
  2c149a:	89 c0                	mov    %eax,%eax
  2c149c:	48 01 d0             	add    %rdx,%rax
  2c149f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c14a6:	8b 12                	mov    (%rdx),%edx
  2c14a8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c14ab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c14b2:	89 0a                	mov    %ecx,(%rdx)
  2c14b4:	eb 1a                	jmp    2c14d0 <printer_vprintf+0x3b5>
  2c14b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14bd:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14c1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c14c5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c14cc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14d0:	48 8b 00             	mov    (%rax),%rax
  2c14d3:	eb 5c                	jmp    2c1531 <printer_vprintf+0x416>
  2c14d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14dc:	8b 00                	mov    (%rax),%eax
  2c14de:	83 f8 2f             	cmp    $0x2f,%eax
  2c14e1:	77 30                	ja     2c1513 <printer_vprintf+0x3f8>
  2c14e3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14ea:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c14ee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14f5:	8b 00                	mov    (%rax),%eax
  2c14f7:	89 c0                	mov    %eax,%eax
  2c14f9:	48 01 d0             	add    %rdx,%rax
  2c14fc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1503:	8b 12                	mov    (%rdx),%edx
  2c1505:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1508:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c150f:	89 0a                	mov    %ecx,(%rdx)
  2c1511:	eb 1a                	jmp    2c152d <printer_vprintf+0x412>
  2c1513:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c151a:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c151e:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1522:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1529:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c152d:	8b 00                	mov    (%rax),%eax
  2c152f:	48 98                	cltq   
  2c1531:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c1535:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1539:	48 c1 f8 38          	sar    $0x38,%rax
  2c153d:	25 80 00 00 00       	and    $0x80,%eax
  2c1542:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c1545:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c1549:	74 09                	je     2c1554 <printer_vprintf+0x439>
  2c154b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c154f:	48 f7 d8             	neg    %rax
  2c1552:	eb 04                	jmp    2c1558 <printer_vprintf+0x43d>
  2c1554:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1558:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c155c:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c155f:	83 c8 60             	or     $0x60,%eax
  2c1562:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c1565:	e9 cf 02 00 00       	jmp    2c1839 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c156a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c156e:	74 5d                	je     2c15cd <printer_vprintf+0x4b2>
  2c1570:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1577:	8b 00                	mov    (%rax),%eax
  2c1579:	83 f8 2f             	cmp    $0x2f,%eax
  2c157c:	77 30                	ja     2c15ae <printer_vprintf+0x493>
  2c157e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1585:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1589:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1590:	8b 00                	mov    (%rax),%eax
  2c1592:	89 c0                	mov    %eax,%eax
  2c1594:	48 01 d0             	add    %rdx,%rax
  2c1597:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c159e:	8b 12                	mov    (%rdx),%edx
  2c15a0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c15a3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c15aa:	89 0a                	mov    %ecx,(%rdx)
  2c15ac:	eb 1a                	jmp    2c15c8 <printer_vprintf+0x4ad>
  2c15ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15b5:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c15b9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c15bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c15c4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c15c8:	48 8b 00             	mov    (%rax),%rax
  2c15cb:	eb 5c                	jmp    2c1629 <printer_vprintf+0x50e>
  2c15cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15d4:	8b 00                	mov    (%rax),%eax
  2c15d6:	83 f8 2f             	cmp    $0x2f,%eax
  2c15d9:	77 30                	ja     2c160b <printer_vprintf+0x4f0>
  2c15db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15e2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c15e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15ed:	8b 00                	mov    (%rax),%eax
  2c15ef:	89 c0                	mov    %eax,%eax
  2c15f1:	48 01 d0             	add    %rdx,%rax
  2c15f4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c15fb:	8b 12                	mov    (%rdx),%edx
  2c15fd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1600:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1607:	89 0a                	mov    %ecx,(%rdx)
  2c1609:	eb 1a                	jmp    2c1625 <printer_vprintf+0x50a>
  2c160b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1612:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1616:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c161a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1621:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1625:	8b 00                	mov    (%rax),%eax
  2c1627:	89 c0                	mov    %eax,%eax
  2c1629:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c162d:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c1631:	e9 03 02 00 00       	jmp    2c1839 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  2c1636:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c163d:	e9 28 ff ff ff       	jmp    2c156a <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  2c1642:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c1649:	e9 1c ff ff ff       	jmp    2c156a <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c164e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1655:	8b 00                	mov    (%rax),%eax
  2c1657:	83 f8 2f             	cmp    $0x2f,%eax
  2c165a:	77 30                	ja     2c168c <printer_vprintf+0x571>
  2c165c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1663:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1667:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c166e:	8b 00                	mov    (%rax),%eax
  2c1670:	89 c0                	mov    %eax,%eax
  2c1672:	48 01 d0             	add    %rdx,%rax
  2c1675:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c167c:	8b 12                	mov    (%rdx),%edx
  2c167e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1681:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1688:	89 0a                	mov    %ecx,(%rdx)
  2c168a:	eb 1a                	jmp    2c16a6 <printer_vprintf+0x58b>
  2c168c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1693:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1697:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c169b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16a2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c16a6:	48 8b 00             	mov    (%rax),%rax
  2c16a9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c16ad:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c16b4:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c16bb:	e9 79 01 00 00       	jmp    2c1839 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  2c16c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16c7:	8b 00                	mov    (%rax),%eax
  2c16c9:	83 f8 2f             	cmp    $0x2f,%eax
  2c16cc:	77 30                	ja     2c16fe <printer_vprintf+0x5e3>
  2c16ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16d5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c16d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16e0:	8b 00                	mov    (%rax),%eax
  2c16e2:	89 c0                	mov    %eax,%eax
  2c16e4:	48 01 d0             	add    %rdx,%rax
  2c16e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16ee:	8b 12                	mov    (%rdx),%edx
  2c16f0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c16f3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16fa:	89 0a                	mov    %ecx,(%rdx)
  2c16fc:	eb 1a                	jmp    2c1718 <printer_vprintf+0x5fd>
  2c16fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1705:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1709:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c170d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1714:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1718:	48 8b 00             	mov    (%rax),%rax
  2c171b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c171f:	e9 15 01 00 00       	jmp    2c1839 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  2c1724:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c172b:	8b 00                	mov    (%rax),%eax
  2c172d:	83 f8 2f             	cmp    $0x2f,%eax
  2c1730:	77 30                	ja     2c1762 <printer_vprintf+0x647>
  2c1732:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1739:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c173d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1744:	8b 00                	mov    (%rax),%eax
  2c1746:	89 c0                	mov    %eax,%eax
  2c1748:	48 01 d0             	add    %rdx,%rax
  2c174b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1752:	8b 12                	mov    (%rdx),%edx
  2c1754:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1757:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c175e:	89 0a                	mov    %ecx,(%rdx)
  2c1760:	eb 1a                	jmp    2c177c <printer_vprintf+0x661>
  2c1762:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1769:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c176d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1771:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1778:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c177c:	8b 00                	mov    (%rax),%eax
  2c177e:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c1784:	e9 77 03 00 00       	jmp    2c1b00 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  2c1789:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c178d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c1791:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1798:	8b 00                	mov    (%rax),%eax
  2c179a:	83 f8 2f             	cmp    $0x2f,%eax
  2c179d:	77 30                	ja     2c17cf <printer_vprintf+0x6b4>
  2c179f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c17a6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c17aa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c17b1:	8b 00                	mov    (%rax),%eax
  2c17b3:	89 c0                	mov    %eax,%eax
  2c17b5:	48 01 d0             	add    %rdx,%rax
  2c17b8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c17bf:	8b 12                	mov    (%rdx),%edx
  2c17c1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c17c4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c17cb:	89 0a                	mov    %ecx,(%rdx)
  2c17cd:	eb 1a                	jmp    2c17e9 <printer_vprintf+0x6ce>
  2c17cf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c17d6:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c17da:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c17de:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c17e5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c17e9:	8b 00                	mov    (%rax),%eax
  2c17eb:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c17ee:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c17f2:	eb 45                	jmp    2c1839 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  2c17f4:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c17f8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c17fc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1803:	0f b6 00             	movzbl (%rax),%eax
  2c1806:	84 c0                	test   %al,%al
  2c1808:	74 0c                	je     2c1816 <printer_vprintf+0x6fb>
  2c180a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1811:	0f b6 00             	movzbl (%rax),%eax
  2c1814:	eb 05                	jmp    2c181b <printer_vprintf+0x700>
  2c1816:	b8 25 00 00 00       	mov    $0x25,%eax
  2c181b:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c181e:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c1822:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1829:	0f b6 00             	movzbl (%rax),%eax
  2c182c:	84 c0                	test   %al,%al
  2c182e:	75 08                	jne    2c1838 <printer_vprintf+0x71d>
                format--;
  2c1830:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c1837:	01 
            }
            break;
  2c1838:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c1839:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c183c:	83 e0 20             	and    $0x20,%eax
  2c183f:	85 c0                	test   %eax,%eax
  2c1841:	74 1e                	je     2c1861 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c1843:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1847:	48 83 c0 18          	add    $0x18,%rax
  2c184b:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c184e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1852:	48 89 ce             	mov    %rcx,%rsi
  2c1855:	48 89 c7             	mov    %rax,%rdi
  2c1858:	e8 32 f8 ff ff       	call   2c108f <fill_numbuf>
  2c185d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c1861:	48 8d 05 de 06 00 00 	lea    0x6de(%rip),%rax        # 2c1f46 <flag_chars+0x6>
  2c1868:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c186c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c186f:	83 e0 20             	and    $0x20,%eax
  2c1872:	85 c0                	test   %eax,%eax
  2c1874:	74 51                	je     2c18c7 <printer_vprintf+0x7ac>
  2c1876:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1879:	83 e0 40             	and    $0x40,%eax
  2c187c:	85 c0                	test   %eax,%eax
  2c187e:	74 47                	je     2c18c7 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  2c1880:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1883:	25 80 00 00 00       	and    $0x80,%eax
  2c1888:	85 c0                	test   %eax,%eax
  2c188a:	74 0d                	je     2c1899 <printer_vprintf+0x77e>
                prefix = "-";
  2c188c:	48 8d 05 b4 06 00 00 	lea    0x6b4(%rip),%rax        # 2c1f47 <flag_chars+0x7>
  2c1893:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c1897:	eb 7d                	jmp    2c1916 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c1899:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c189c:	83 e0 10             	and    $0x10,%eax
  2c189f:	85 c0                	test   %eax,%eax
  2c18a1:	74 0d                	je     2c18b0 <printer_vprintf+0x795>
                prefix = "+";
  2c18a3:	48 8d 05 9f 06 00 00 	lea    0x69f(%rip),%rax        # 2c1f49 <flag_chars+0x9>
  2c18aa:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c18ae:	eb 66                	jmp    2c1916 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c18b0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18b3:	83 e0 08             	and    $0x8,%eax
  2c18b6:	85 c0                	test   %eax,%eax
  2c18b8:	74 5c                	je     2c1916 <printer_vprintf+0x7fb>
                prefix = " ";
  2c18ba:	48 8d 05 8a 06 00 00 	lea    0x68a(%rip),%rax        # 2c1f4b <flag_chars+0xb>
  2c18c1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c18c5:	eb 4f                	jmp    2c1916 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c18c7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18ca:	83 e0 20             	and    $0x20,%eax
  2c18cd:	85 c0                	test   %eax,%eax
  2c18cf:	74 46                	je     2c1917 <printer_vprintf+0x7fc>
  2c18d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18d4:	83 e0 01             	and    $0x1,%eax
  2c18d7:	85 c0                	test   %eax,%eax
  2c18d9:	74 3c                	je     2c1917 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  2c18db:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c18df:	74 06                	je     2c18e7 <printer_vprintf+0x7cc>
  2c18e1:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c18e5:	75 30                	jne    2c1917 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  2c18e7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c18ec:	75 0c                	jne    2c18fa <printer_vprintf+0x7df>
  2c18ee:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18f1:	25 00 01 00 00       	and    $0x100,%eax
  2c18f6:	85 c0                	test   %eax,%eax
  2c18f8:	74 1d                	je     2c1917 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  2c18fa:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c18fe:	75 09                	jne    2c1909 <printer_vprintf+0x7ee>
  2c1900:	48 8d 05 46 06 00 00 	lea    0x646(%rip),%rax        # 2c1f4d <flag_chars+0xd>
  2c1907:	eb 07                	jmp    2c1910 <printer_vprintf+0x7f5>
  2c1909:	48 8d 05 40 06 00 00 	lea    0x640(%rip),%rax        # 2c1f50 <flag_chars+0x10>
  2c1910:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1914:	eb 01                	jmp    2c1917 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  2c1916:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c1917:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c191b:	78 24                	js     2c1941 <printer_vprintf+0x826>
  2c191d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1920:	83 e0 20             	and    $0x20,%eax
  2c1923:	85 c0                	test   %eax,%eax
  2c1925:	75 1a                	jne    2c1941 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  2c1927:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c192a:	48 63 d0             	movslq %eax,%rdx
  2c192d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1931:	48 89 d6             	mov    %rdx,%rsi
  2c1934:	48 89 c7             	mov    %rax,%rdi
  2c1937:	e8 91 f5 ff ff       	call   2c0ecd <strnlen>
  2c193c:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c193f:	eb 0f                	jmp    2c1950 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  2c1941:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1945:	48 89 c7             	mov    %rax,%rdi
  2c1948:	e8 4b f5 ff ff       	call   2c0e98 <strlen>
  2c194d:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c1950:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1953:	83 e0 20             	and    $0x20,%eax
  2c1956:	85 c0                	test   %eax,%eax
  2c1958:	74 20                	je     2c197a <printer_vprintf+0x85f>
  2c195a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c195e:	78 1a                	js     2c197a <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  2c1960:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1963:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c1966:	7e 08                	jle    2c1970 <printer_vprintf+0x855>
  2c1968:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c196b:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c196e:	eb 05                	jmp    2c1975 <printer_vprintf+0x85a>
  2c1970:	b8 00 00 00 00       	mov    $0x0,%eax
  2c1975:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1978:	eb 5c                	jmp    2c19d6 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c197a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c197d:	83 e0 20             	and    $0x20,%eax
  2c1980:	85 c0                	test   %eax,%eax
  2c1982:	74 4b                	je     2c19cf <printer_vprintf+0x8b4>
  2c1984:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1987:	83 e0 02             	and    $0x2,%eax
  2c198a:	85 c0                	test   %eax,%eax
  2c198c:	74 41                	je     2c19cf <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c198e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1991:	83 e0 04             	and    $0x4,%eax
  2c1994:	85 c0                	test   %eax,%eax
  2c1996:	75 37                	jne    2c19cf <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  2c1998:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c199c:	48 89 c7             	mov    %rax,%rdi
  2c199f:	e8 f4 f4 ff ff       	call   2c0e98 <strlen>
  2c19a4:	89 c2                	mov    %eax,%edx
  2c19a6:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c19a9:	01 d0                	add    %edx,%eax
  2c19ab:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c19ae:	7e 1f                	jle    2c19cf <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  2c19b0:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c19b3:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c19b6:	89 c3                	mov    %eax,%ebx
  2c19b8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c19bc:	48 89 c7             	mov    %rax,%rdi
  2c19bf:	e8 d4 f4 ff ff       	call   2c0e98 <strlen>
  2c19c4:	89 c2                	mov    %eax,%edx
  2c19c6:	89 d8                	mov    %ebx,%eax
  2c19c8:	29 d0                	sub    %edx,%eax
  2c19ca:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c19cd:	eb 07                	jmp    2c19d6 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  2c19cf:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c19d6:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c19d9:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c19dc:	01 d0                	add    %edx,%eax
  2c19de:	48 63 d8             	movslq %eax,%rbx
  2c19e1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c19e5:	48 89 c7             	mov    %rax,%rdi
  2c19e8:	e8 ab f4 ff ff       	call   2c0e98 <strlen>
  2c19ed:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c19f1:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c19f4:	29 d0                	sub    %edx,%eax
  2c19f6:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c19f9:	eb 25                	jmp    2c1a20 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  2c19fb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a02:	48 8b 08             	mov    (%rax),%rcx
  2c1a05:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1a0b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a12:	be 20 00 00 00       	mov    $0x20,%esi
  2c1a17:	48 89 c7             	mov    %rax,%rdi
  2c1a1a:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1a1c:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1a20:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1a23:	83 e0 04             	and    $0x4,%eax
  2c1a26:	85 c0                	test   %eax,%eax
  2c1a28:	75 36                	jne    2c1a60 <printer_vprintf+0x945>
  2c1a2a:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1a2e:	7f cb                	jg     2c19fb <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  2c1a30:	eb 2e                	jmp    2c1a60 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  2c1a32:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a39:	4c 8b 00             	mov    (%rax),%r8
  2c1a3c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1a40:	0f b6 00             	movzbl (%rax),%eax
  2c1a43:	0f b6 c8             	movzbl %al,%ecx
  2c1a46:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1a4c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a53:	89 ce                	mov    %ecx,%esi
  2c1a55:	48 89 c7             	mov    %rax,%rdi
  2c1a58:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1a5b:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c1a60:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1a64:	0f b6 00             	movzbl (%rax),%eax
  2c1a67:	84 c0                	test   %al,%al
  2c1a69:	75 c7                	jne    2c1a32 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  2c1a6b:	eb 25                	jmp    2c1a92 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  2c1a6d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a74:	48 8b 08             	mov    (%rax),%rcx
  2c1a77:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1a7d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a84:	be 30 00 00 00       	mov    $0x30,%esi
  2c1a89:	48 89 c7             	mov    %rax,%rdi
  2c1a8c:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c1a8e:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c1a92:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c1a96:	7f d5                	jg     2c1a6d <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  2c1a98:	eb 32                	jmp    2c1acc <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  2c1a9a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1aa1:	4c 8b 00             	mov    (%rax),%r8
  2c1aa4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1aa8:	0f b6 00             	movzbl (%rax),%eax
  2c1aab:	0f b6 c8             	movzbl %al,%ecx
  2c1aae:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1ab4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1abb:	89 ce                	mov    %ecx,%esi
  2c1abd:	48 89 c7             	mov    %rax,%rdi
  2c1ac0:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c1ac3:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c1ac8:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c1acc:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c1ad0:	7f c8                	jg     2c1a9a <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  2c1ad2:	eb 25                	jmp    2c1af9 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  2c1ad4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1adb:	48 8b 08             	mov    (%rax),%rcx
  2c1ade:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1ae4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1aeb:	be 20 00 00 00       	mov    $0x20,%esi
  2c1af0:	48 89 c7             	mov    %rax,%rdi
  2c1af3:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c1af5:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1af9:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1afd:	7f d5                	jg     2c1ad4 <printer_vprintf+0x9b9>
        }
    done: ;
  2c1aff:	90                   	nop
    for (; *format; ++format) {
  2c1b00:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1b07:	01 
  2c1b08:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1b0f:	0f b6 00             	movzbl (%rax),%eax
  2c1b12:	84 c0                	test   %al,%al
  2c1b14:	0f 85 31 f6 ff ff    	jne    2c114b <printer_vprintf+0x30>
    }
}
  2c1b1a:	90                   	nop
  2c1b1b:	90                   	nop
  2c1b1c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c1b20:	c9                   	leave  
  2c1b21:	c3                   	ret    

00000000002c1b22 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1b22:	f3 0f 1e fa          	endbr64 
  2c1b26:	55                   	push   %rbp
  2c1b27:	48 89 e5             	mov    %rsp,%rbp
  2c1b2a:	48 83 ec 20          	sub    $0x20,%rsp
  2c1b2e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1b32:	89 f0                	mov    %esi,%eax
  2c1b34:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1b37:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1b3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1b3e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1b42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1b46:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1b4a:	48 8d 15 4f 74 df ff 	lea    -0x208bb1(%rip),%rdx        # b8fa0 <console+0xfa0>
  2c1b51:	48 39 d0             	cmp    %rdx,%rax
  2c1b54:	72 0f                	jb     2c1b65 <console_putc+0x43>
        cp->cursor = console;
  2c1b56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1b5a:	48 8d 15 9f 64 df ff 	lea    -0x209b61(%rip),%rdx        # b8000 <console>
  2c1b61:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  2c1b65:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c1b69:	0f 85 82 00 00 00    	jne    2c1bf1 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  2c1b6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1b73:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1b77:	48 8d 15 82 64 df ff 	lea    -0x209b7e(%rip),%rdx        # b8000 <console>
  2c1b7e:	48 29 d0             	sub    %rdx,%rax
  2c1b81:	48 d1 f8             	sar    %rax
  2c1b84:	48 89 c1             	mov    %rax,%rcx
  2c1b87:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1b8e:	66 66 66 
  2c1b91:	48 89 c8             	mov    %rcx,%rax
  2c1b94:	48 f7 ea             	imul   %rdx
  2c1b97:	48 89 d0             	mov    %rdx,%rax
  2c1b9a:	48 c1 f8 05          	sar    $0x5,%rax
  2c1b9e:	48 89 ce             	mov    %rcx,%rsi
  2c1ba1:	48 c1 fe 3f          	sar    $0x3f,%rsi
  2c1ba5:	48 29 f0             	sub    %rsi,%rax
  2c1ba8:	48 89 c2             	mov    %rax,%rdx
  2c1bab:	48 89 d0             	mov    %rdx,%rax
  2c1bae:	48 c1 e0 02          	shl    $0x2,%rax
  2c1bb2:	48 01 d0             	add    %rdx,%rax
  2c1bb5:	48 c1 e0 04          	shl    $0x4,%rax
  2c1bb9:	48 29 c1             	sub    %rax,%rcx
  2c1bbc:	48 89 ca             	mov    %rcx,%rdx
  2c1bbf:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c1bc2:	eb 25                	jmp    2c1be9 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  2c1bc4:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1bc7:	83 c8 20             	or     $0x20,%eax
  2c1bca:	89 c6                	mov    %eax,%esi
  2c1bcc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1bd0:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1bd4:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1bd8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1bdc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1be0:	89 f2                	mov    %esi,%edx
  2c1be2:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c1be5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1be9:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c1bed:	75 d5                	jne    2c1bc4 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c1bef:	eb 24                	jmp    2c1c15 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  2c1bf1:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1bf5:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1bf8:	89 d6                	mov    %edx,%esi
  2c1bfa:	09 c6                	or     %eax,%esi
  2c1bfc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1c00:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1c04:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1c08:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1c0c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1c10:	89 f2                	mov    %esi,%edx
  2c1c12:	66 89 10             	mov    %dx,(%rax)
}
  2c1c15:	90                   	nop
  2c1c16:	c9                   	leave  
  2c1c17:	c3                   	ret    

00000000002c1c18 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c1c18:	f3 0f 1e fa          	endbr64 
  2c1c1c:	55                   	push   %rbp
  2c1c1d:	48 89 e5             	mov    %rsp,%rbp
  2c1c20:	48 83 ec 30          	sub    $0x30,%rsp
  2c1c24:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c1c27:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1c2a:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1c2e:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1c32:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 2c1b22 <console_putc>
  2c1c39:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1c3d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1c41:	78 09                	js     2c1c4c <console_vprintf+0x34>
  2c1c43:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1c4a:	7e 07                	jle    2c1c53 <console_vprintf+0x3b>
        cpos = 0;
  2c1c4c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c1c53:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1c56:	48 98                	cltq   
  2c1c58:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c1c5c:	48 8d 05 9d 63 df ff 	lea    -0x209c63(%rip),%rax        # b8000 <console>
  2c1c63:	48 01 d0             	add    %rdx,%rax
  2c1c66:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1c6a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1c6e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c1c72:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c1c75:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1c79:	48 89 c7             	mov    %rax,%rdi
  2c1c7c:	e8 9a f4 ff ff       	call   2c111b <printer_vprintf>
    return cp.cursor - console;
  2c1c81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1c85:	48 8d 15 74 63 df ff 	lea    -0x209c8c(%rip),%rdx        # b8000 <console>
  2c1c8c:	48 29 d0             	sub    %rdx,%rax
  2c1c8f:	48 d1 f8             	sar    %rax
}
  2c1c92:	c9                   	leave  
  2c1c93:	c3                   	ret    

00000000002c1c94 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c1c94:	f3 0f 1e fa          	endbr64 
  2c1c98:	55                   	push   %rbp
  2c1c99:	48 89 e5             	mov    %rsp,%rbp
  2c1c9c:	48 83 ec 60          	sub    $0x60,%rsp
  2c1ca0:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c1ca3:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c1ca6:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1caa:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1cae:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1cb2:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1cb6:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1cbd:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1cc1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1cc5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1cc9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1ccd:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c1cd1:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c1cd5:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c1cd8:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c1cdb:	89 c7                	mov    %eax,%edi
  2c1cdd:	e8 36 ff ff ff       	call   2c1c18 <console_vprintf>
  2c1ce2:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c1ce5:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c1ce8:	c9                   	leave  
  2c1ce9:	c3                   	ret    

00000000002c1cea <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c1cea:	f3 0f 1e fa          	endbr64 
  2c1cee:	55                   	push   %rbp
  2c1cef:	48 89 e5             	mov    %rsp,%rbp
  2c1cf2:	48 83 ec 20          	sub    $0x20,%rsp
  2c1cf6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1cfa:	89 f0                	mov    %esi,%eax
  2c1cfc:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1cff:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c1d02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1d06:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c1d0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1d0e:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c1d12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1d16:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c1d1a:	48 39 c2             	cmp    %rax,%rdx
  2c1d1d:	73 1a                	jae    2c1d39 <string_putc+0x4f>
        *sp->s++ = c;
  2c1d1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1d23:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1d27:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c1d2b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c1d2f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1d33:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1d37:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1d39:	90                   	nop
  2c1d3a:	c9                   	leave  
  2c1d3b:	c3                   	ret    

00000000002c1d3c <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1d3c:	f3 0f 1e fa          	endbr64 
  2c1d40:	55                   	push   %rbp
  2c1d41:	48 89 e5             	mov    %rsp,%rbp
  2c1d44:	48 83 ec 40          	sub    $0x40,%rsp
  2c1d48:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1d4c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c1d50:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1d54:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1d58:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 2c1cea <string_putc>
  2c1d5f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  2c1d63:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1d67:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1d6b:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1d70:	74 33                	je     2c1da5 <vsnprintf+0x69>
        sp.end = s + size - 1;
  2c1d72:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1d76:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c1d7a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1d7e:	48 01 d0             	add    %rdx,%rax
  2c1d81:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c1d85:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c1d89:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c1d8d:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c1d91:	be 00 00 00 00       	mov    $0x0,%esi
  2c1d96:	48 89 c7             	mov    %rax,%rdi
  2c1d99:	e8 7d f3 ff ff       	call   2c111b <printer_vprintf>
        *sp.s = 0;
  2c1d9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1da2:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c1da5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1da9:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c1dad:	c9                   	leave  
  2c1dae:	c3                   	ret    

00000000002c1daf <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1daf:	f3 0f 1e fa          	endbr64 
  2c1db3:	55                   	push   %rbp
  2c1db4:	48 89 e5             	mov    %rsp,%rbp
  2c1db7:	48 83 ec 70          	sub    $0x70,%rsp
  2c1dbb:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c1dbf:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c1dc3:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1dc7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1dcb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1dcf:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1dd3:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c1dda:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1dde:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c1de2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1de6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1dea:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c1dee:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c1df2:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c1df6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1dfa:	48 89 c7             	mov    %rax,%rdi
  2c1dfd:	e8 3a ff ff ff       	call   2c1d3c <vsnprintf>
  2c1e02:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c1e05:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1e08:	c9                   	leave  
  2c1e09:	c3                   	ret    

00000000002c1e0a <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1e0a:	f3 0f 1e fa          	endbr64 
  2c1e0e:	55                   	push   %rbp
  2c1e0f:	48 89 e5             	mov    %rsp,%rbp
  2c1e12:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1e16:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1e1d:	eb 1a                	jmp    2c1e39 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  2c1e1f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c1e22:	48 98                	cltq   
  2c1e24:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c1e28:	48 8d 05 d1 61 df ff 	lea    -0x209e2f(%rip),%rax        # b8000 <console>
  2c1e2f:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1e35:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1e39:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1e40:	7e dd                	jle    2c1e1f <console_clear+0x15>
    }
    cursorpos = 0;
  2c1e42:	c7 05 b0 71 df ff 00 	movl   $0x0,-0x208e50(%rip)        # b8ffc <cursorpos>
  2c1e49:	00 00 00 
}
  2c1e4c:	90                   	nop
  2c1e4d:	c9                   	leave  
  2c1e4e:	c3                   	ret    
