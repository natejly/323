
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
  2c001a:	e8 2a 10 00 00       	call   2c1049 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001f:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0024:	e8 58 09 00 00       	call   2c0981 <malloc>
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
  2c0043:	e8 df 09 00 00       	call   2c0a27 <realloc>
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
  2c006b:	e8 80 09 00 00       	call   2c09f0 <calloc>
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
  2c008a:	e8 6a 0b 00 00       	call   2c0bf9 <heap_info>
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
  2c00bb:	48 8d 15 6e 1d 00 00 	lea    0x1d6e(%rip),%rdx        # 2c1e30 <console_clear+0x47>
  2c00c2:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c7:	48 8d 3d 70 1d 00 00 	lea    0x1d70(%rip),%rdi        # 2c1e3e <console_clear+0x55>
  2c00ce:	e8 31 02 00 00       	call   2c0304 <assert_fail>
	assert(array2[i] == 0);
  2c00d3:	48 8d 15 7a 1d 00 00 	lea    0x1d7a(%rip),%rdx        # 2c1e54 <console_clear+0x6b>
  2c00da:	be 21 00 00 00       	mov    $0x21,%esi
  2c00df:	48 8d 3d 58 1d 00 00 	lea    0x1d58(%rip),%rdi        # 2c1e3e <console_clear+0x55>
  2c00e6:	e8 19 02 00 00       	call   2c0304 <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00eb:	48 8d 15 86 1d 00 00 	lea    0x1d86(%rip),%rdx        # 2c1e78 <console_clear+0x8f>
  2c00f2:	be 28 00 00 00       	mov    $0x28,%esi
  2c00f7:	48 8d 3d 40 1d 00 00 	lea    0x1d40(%rip),%rdi        # 2c1e3e <console_clear+0x55>
  2c00fe:	e8 01 02 00 00       	call   2c0304 <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c0103:	48 8d 35 59 1d 00 00 	lea    0x1d59(%rip),%rsi        # 2c1e63 <console_clear+0x7a>
  2c010a:	bf 00 00 00 00       	mov    $0x0,%edi
  2c010f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0114:	e8 7b 00 00 00       	call   2c0194 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0119:	4c 89 ef             	mov    %r13,%rdi
  2c011c:	e8 26 08 00 00       	call   2c0947 <free>
    free(array2);
  2c0121:	4c 89 f7             	mov    %r14,%rdi
  2c0124:	e8 1e 08 00 00       	call   2c0947 <free>

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
  2c0142:	e8 3a 08 00 00       	call   2c0981 <malloc>
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
  2c017c:	48 8d 35 25 1d 00 00 	lea    0x1d25(%rip),%rsi        # 2c1ea8 <console_clear+0xbf>
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
  2c01e0:	48 8d 05 26 1d 00 00 	lea    0x1d26(%rip),%rax        # 2c1f0d <col.0>
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
  2c0212:	e8 e0 19 00 00       	call   2c1bf7 <console_vprintf>
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
  2c0276:	48 8d 35 5b 1c 00 00 	lea    0x1c5b(%rip),%rsi        # 2c1ed8 <console_clear+0xef>
  2c027d:	e8 ac 0a 00 00       	call   2c0d2e <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0282:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0286:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c028d:	48 89 da             	mov    %rbx,%rdx
  2c0290:	be 99 00 00 00       	mov    $0x99,%esi
  2c0295:	e8 81 1a 00 00       	call   2c1d1b <vsnprintf>
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
  2c02ba:	48 8d 15 1f 1c 00 00 	lea    0x1c1f(%rip),%rdx        # 2c1ee0 <console_clear+0xf7>
  2c02c1:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02c6:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02cb:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02d0:	e8 9e 19 00 00       	call   2c1c73 <console_printf>
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
  2c02f6:	48 8d 35 76 1b 00 00 	lea    0x1b76(%rip),%rsi        # 2c1e73 <console_clear+0x8a>
  2c02fd:	e8 ed 0b 00 00       	call   2c0eef <strcpy>
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
  2c0315:	48 8d 15 cc 1b 00 00 	lea    0x1bcc(%rip),%rdx        # 2c1ee8 <console_clear+0xff>
  2c031c:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0321:	bf 30 07 00 00       	mov    $0x730,%edi
  2c0326:	b8 00 00 00 00       	mov    $0x0,%eax
  2c032b:	e8 43 19 00 00       	call   2c1c73 <console_printf>
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
    if (b < free_head) {
  2c081b:	48 39 f8             	cmp    %rdi,%rax
  2c081e:	77 22                	ja     2c0842 <add_to_free_list+0x37>
        b->next = free_head;
        free_head = b;
        return;
    }
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
    if (b->size < size + BLOCKSIZE) {
  2c085b:	48 8b 07             	mov    (%rdi),%rax
  2c085e:	48 8d 56 18          	lea    0x18(%rsi),%rdx
        return NULL;
  2c0862:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (b->size < size + BLOCKSIZE) {
  2c0867:	48 39 d0             	cmp    %rdx,%rax
  2c086a:	72 28                	jb     2c0894 <split_block+0x46>
    void* nptr = (void*)b + BLOCKSIZE + size;
  2c086c:	48 8d 1c 17          	lea    (%rdi,%rdx,1),%rbx
    new->size = b->size - size - BLOCKSIZE;
  2c0870:	48 29 f0             	sub    %rsi,%rax
  2c0873:	48 8d 40 e8          	lea    -0x18(%rax),%rax
  2c0877:	48 89 03             	mov    %rax,(%rbx)
    new->free = 1;
  2c087a:	c7 43 10 01 00 00 00 	movl   $0x1,0x10(%rbx)
    new->next = NULL;
  2c0881:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  2c0888:	00 
    b->size = size;
  2c0889:	48 89 37             	mov    %rsi,(%rdi)
    add_to_free_list(new);
  2c088c:	48 89 df             	mov    %rbx,%rdi
  2c088f:	e8 77 ff ff ff       	call   2c080b <add_to_free_list>
}
  2c0894:	48 89 d8             	mov    %rbx,%rax
  2c0897:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c089b:	c9                   	leave  
  2c089c:	c3                   	ret    

00000000002c089d <remove_from_free_list>:

void remove_from_free_list(block *b) {
  2c089d:	f3 0f 1e fa          	endbr64 
    if (free_head == b) {
  2c08a1:	48 8b 05 70 27 00 00 	mov    0x2770(%rip),%rax        # 2c3018 <free_head>
  2c08a8:	48 39 f8             	cmp    %rdi,%rax
  2c08ab:	75 10                	jne    2c08bd <remove_from_free_list+0x20>
        free_head = b->next;
  2c08ad:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c08b1:	48 89 05 60 27 00 00 	mov    %rax,0x2760(%rip)        # 2c3018 <free_head>
  2c08b8:	eb 19                	jmp    2c08d3 <remove_from_free_list+0x36>
    } else {
        block *curr = free_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  2c08ba:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  2c08bd:	48 85 c0             	test   %rax,%rax
  2c08c0:	74 11                	je     2c08d3 <remove_from_free_list+0x36>
  2c08c2:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c08c6:	48 39 fa             	cmp    %rdi,%rdx
  2c08c9:	75 ef                	jne    2c08ba <remove_from_free_list+0x1d>
        }
        if (curr) {
            curr->next = b->next;
  2c08cb:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c08cf:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 0;
  2c08d3:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = NULL;
  2c08da:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c08e1:	00 
}
  2c08e2:	c3                   	ret    

00000000002c08e3 <add_to_malloc_list>:
void add_to_malloc_list(block *b) {
  2c08e3:	f3 0f 1e fa          	endbr64 
    b->free = 0; 
  2c08e7:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = malloc_head;
  2c08ee:	48 8b 05 1b 27 00 00 	mov    0x271b(%rip),%rax        # 2c3010 <malloc_head>
  2c08f5:	48 89 47 08          	mov    %rax,0x8(%rdi)
    malloc_head = b; 
  2c08f9:	48 89 3d 10 27 00 00 	mov    %rdi,0x2710(%rip)        # 2c3010 <malloc_head>
}
  2c0900:	c3                   	ret    

00000000002c0901 <remove_from_malloc_list>:

void remove_from_malloc_list(block *b) {
  2c0901:	f3 0f 1e fa          	endbr64 
    if (malloc_head == b) {
  2c0905:	48 8b 05 04 27 00 00 	mov    0x2704(%rip),%rax        # 2c3010 <malloc_head>
  2c090c:	48 39 f8             	cmp    %rdi,%rax
  2c090f:	75 10                	jne    2c0921 <remove_from_malloc_list+0x20>
        malloc_head = b->next; 
  2c0911:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0915:	48 89 05 f4 26 00 00 	mov    %rax,0x26f4(%rip)        # 2c3010 <malloc_head>
  2c091c:	eb 19                	jmp    2c0937 <remove_from_malloc_list+0x36>
    } else {
        block *curr = malloc_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  2c091e:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  2c0921:	48 85 c0             	test   %rax,%rax
  2c0924:	74 11                	je     2c0937 <remove_from_malloc_list+0x36>
  2c0926:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c092a:	48 39 fa             	cmp    %rdi,%rdx
  2c092d:	75 ef                	jne    2c091e <remove_from_malloc_list+0x1d>
        }
        if (curr) {
            curr->next = b->next; 
  2c092f:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c0933:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 1; 
  2c0937:	c7 47 10 01 00 00 00 	movl   $0x1,0x10(%rdi)
    b->next = NULL; 
  2c093e:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c0945:	00 
}
  2c0946:	c3                   	ret    

00000000002c0947 <free>:

void free(void *firstbyte) {
  2c0947:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  2c094b:	48 85 ff             	test   %rdi,%rdi
  2c094e:	74 06                	je     2c0956 <free+0xf>
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; 
  2c0950:	83 7f f8 00          	cmpl   $0x0,-0x8(%rdi)
  2c0954:	74 01                	je     2c0957 <free+0x10>
  2c0956:	c3                   	ret    
void free(void *firstbyte) {
  2c0957:	55                   	push   %rbp
  2c0958:	48 89 e5             	mov    %rsp,%rbp
  2c095b:	53                   	push   %rbx
  2c095c:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
  2c0960:	48 8d 5f e8          	lea    -0x18(%rdi),%rbx
    num_allocs--;
  2c0964:	83 2d 95 26 00 00 01 	subl   $0x1,0x2695(%rip)        # 2c3000 <num_allocs>
    remove_from_malloc_list(b); 
  2c096b:	48 89 df             	mov    %rbx,%rdi
  2c096e:	e8 8e ff ff ff       	call   2c0901 <remove_from_malloc_list>
    add_to_free_list(b);
  2c0973:	48 89 df             	mov    %rbx,%rdi
  2c0976:	e8 90 fe ff ff       	call   2c080b <add_to_free_list>
}
  2c097b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c097f:	c9                   	leave  
  2c0980:	c3                   	ret    

00000000002c0981 <malloc>:

void *malloc(uint64_t numbytes) {
  2c0981:	f3 0f 1e fa          	endbr64 
  2c0985:	55                   	push   %rbp
  2c0986:	48 89 e5             	mov    %rsp,%rbp
  2c0989:	41 54                	push   %r12
  2c098b:	53                   	push   %rbx
    return (size + 7) / 8 * 8;
  2c098c:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  2c0990:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    size_t size = algn(numbytes);
    block *b = find_block(size);
  2c0994:	4c 89 e7             	mov    %r12,%rdi
  2c0997:	e8 50 fe ff ff       	call   2c07ec <find_block>
  2c099c:	48 89 c3             	mov    %rax,%rbx
    if (b == NULL) {
  2c099f:	48 85 c0             	test   %rax,%rax
  2c09a2:	74 2d                	je     2c09d1 <malloc+0x50>
        b = new_block(size);
        if (b == NULL) {
            return NULL;
        }
    }
        remove_from_free_list(b);
  2c09a4:	48 89 df             	mov    %rbx,%rdi
  2c09a7:	e8 f1 fe ff ff       	call   2c089d <remove_from_free_list>
        if (b->size > size + BLOCKSIZE) {
  2c09ac:	49 8d 44 24 18       	lea    0x18(%r12),%rax
  2c09b1:	48 39 03             	cmp    %rax,(%rbx)
  2c09b4:	77 2d                	ja     2c09e3 <malloc+0x62>
            split_block(b, size);
        }
    add_to_malloc_list(b);
  2c09b6:	48 89 df             	mov    %rbx,%rdi
  2c09b9:	e8 25 ff ff ff       	call   2c08e3 <add_to_malloc_list>
    num_allocs++;
  2c09be:	83 05 3b 26 00 00 01 	addl   $0x1,0x263b(%rip)        # 2c3000 <num_allocs>
    return (void*)((void*)b + BLOCKSIZE);
  2c09c5:	48 83 c3 18          	add    $0x18,%rbx
}
  2c09c9:	48 89 d8             	mov    %rbx,%rax
  2c09cc:	5b                   	pop    %rbx
  2c09cd:	41 5c                	pop    %r12
  2c09cf:	5d                   	pop    %rbp
  2c09d0:	c3                   	ret    
        b = new_block(size);
  2c09d1:	4c 89 e7             	mov    %r12,%rdi
  2c09d4:	e8 d9 fd ff ff       	call   2c07b2 <new_block>
  2c09d9:	48 89 c3             	mov    %rax,%rbx
        if (b == NULL) {
  2c09dc:	48 85 c0             	test   %rax,%rax
  2c09df:	75 c3                	jne    2c09a4 <malloc+0x23>
  2c09e1:	eb e6                	jmp    2c09c9 <malloc+0x48>
            split_block(b, size);
  2c09e3:	4c 89 e6             	mov    %r12,%rsi
  2c09e6:	48 89 df             	mov    %rbx,%rdi
  2c09e9:	e8 60 fe ff ff       	call   2c084e <split_block>
  2c09ee:	eb c6                	jmp    2c09b6 <malloc+0x35>

00000000002c09f0 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  2c09f0:	f3 0f 1e fa          	endbr64 
  2c09f4:	55                   	push   %rbp
  2c09f5:	48 89 e5             	mov    %rsp,%rbp
  2c09f8:	41 54                	push   %r12
  2c09fa:	53                   	push   %rbx
    uint64_t total = num * sz;
  2c09fb:	48 0f af fe          	imul   %rsi,%rdi
  2c09ff:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  2c0a02:	e8 7a ff ff ff       	call   2c0981 <malloc>
  2c0a07:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  2c0a0a:	48 85 c0             	test   %rax,%rax
  2c0a0d:	74 10                	je     2c0a1f <calloc+0x2f>
        memset(ptr, 0, total);
  2c0a0f:	4c 89 e2             	mov    %r12,%rdx
  2c0a12:	be 00 00 00 00       	mov    $0x0,%esi
  2c0a17:	48 89 c7             	mov    %rax,%rdi
  2c0a1a:	e8 15 04 00 00       	call   2c0e34 <memset>
    }
    return ptr;
}
  2c0a1f:	48 89 d8             	mov    %rbx,%rax
  2c0a22:	5b                   	pop    %rbx
  2c0a23:	41 5c                	pop    %r12
  2c0a25:	5d                   	pop    %rbp
  2c0a26:	c3                   	ret    

00000000002c0a27 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c0a27:	f3 0f 1e fa          	endbr64 
  2c0a2b:	55                   	push   %rbp
  2c0a2c:	48 89 e5             	mov    %rsp,%rbp
  2c0a2f:	41 54                	push   %r12
  2c0a31:	53                   	push   %rbx
  2c0a32:	48 89 fb             	mov    %rdi,%rbx
  2c0a35:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  2c0a38:	48 85 db             	test   %rbx,%rbx
  2c0a3b:	74 2d                	je     2c0a6a <realloc+0x43>
        return malloc(sz);
    }
    if (sz == 0) {
  2c0a3d:	48 85 f6             	test   %rsi,%rsi
  2c0a40:	74 32                	je     2c0a74 <realloc+0x4d>
    return (size + 7) / 8 * 8;
  2c0a42:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  2c0a46:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi
        return NULL;
    }
    block *b = (block*)((void*)ptr - BLOCKSIZE);
    size_t aligned_size = algn(sz);

    if (b->size >= aligned_size) {
  2c0a4a:	48 8b 43 e8          	mov    -0x18(%rbx),%rax
  2c0a4e:	48 39 f0             	cmp    %rsi,%rax
  2c0a51:	72 31                	jb     2c0a84 <realloc+0x5d>
        if (b->size > aligned_size + BLOCKSIZE) {
  2c0a53:	48 8d 56 18          	lea    0x18(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr;
  2c0a57:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  2c0a5a:	48 39 d0             	cmp    %rdx,%rax
  2c0a5d:	76 49                	jbe    2c0aa8 <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE);
  2c0a5f:	48 8d 7b e8          	lea    -0x18(%rbx),%rdi
            split_block(b, aligned_size);
  2c0a63:	e8 e6 fd ff ff       	call   2c084e <split_block>
  2c0a68:	eb 3e                	jmp    2c0aa8 <realloc+0x81>
        return malloc(sz);
  2c0a6a:	e8 12 ff ff ff       	call   2c0981 <malloc>
  2c0a6f:	49 89 c4             	mov    %rax,%r12
  2c0a72:	eb 34                	jmp    2c0aa8 <realloc+0x81>
        free(ptr);
  2c0a74:	48 89 df             	mov    %rbx,%rdi
  2c0a77:	e8 cb fe ff ff       	call   2c0947 <free>
        return NULL;
  2c0a7c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0a82:	eb 24                	jmp    2c0aa8 <realloc+0x81>
    }

    void *new_ptr = malloc(sz);
  2c0a84:	e8 f8 fe ff ff       	call   2c0981 <malloc>
  2c0a89:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  2c0a8c:	48 85 c0             	test   %rax,%rax
  2c0a8f:	74 17                	je     2c0aa8 <realloc+0x81>
        return NULL;
    }
    memcpy(new_ptr, ptr, b->size);
  2c0a91:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  2c0a95:	48 89 de             	mov    %rbx,%rsi
  2c0a98:	48 89 c7             	mov    %rax,%rdi
  2c0a9b:	e8 8e 02 00 00       	call   2c0d2e <memcpy>
    free(ptr);
  2c0aa0:	48 89 df             	mov    %rbx,%rdi
  2c0aa3:	e8 9f fe ff ff       	call   2c0947 <free>
    return new_ptr;
}
  2c0aa8:	4c 89 e0             	mov    %r12,%rax
  2c0aab:	5b                   	pop    %rbx
  2c0aac:	41 5c                	pop    %r12
  2c0aae:	5d                   	pop    %rbp
  2c0aaf:	c3                   	ret    

00000000002c0ab0 <defrag>:

void defrag() {
  2c0ab0:	f3 0f 1e fa          	endbr64 
  2c0ab4:	55                   	push   %rbp
  2c0ab5:	48 89 e5             	mov    %rsp,%rbp
  2c0ab8:	53                   	push   %rbx
  2c0ab9:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = free_head;
  2c0abd:	48 8b 1d 54 25 00 00 	mov    0x2554(%rip),%rbx        # 2c3018 <free_head>

    while (b && b->next) { 
  2c0ac4:	48 85 db             	test   %rbx,%rbx
  2c0ac7:	74 33                	je     2c0afc <defrag+0x4c>
  2c0ac9:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
  2c0acd:	48 85 ff             	test   %rdi,%rdi
  2c0ad0:	74 2a                	je     2c0afc <defrag+0x4c>
        block *next = b->next;

        if ((char *)b + b->size + BLOCKSIZE == (char *)next) {
  2c0ad2:	48 8b 03             	mov    (%rbx),%rax
  2c0ad5:	48 83 c0 18          	add    $0x18,%rax
  2c0ad9:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c0add:	48 39 d7             	cmp    %rdx,%rdi
  2c0ae0:	74 05                	je     2c0ae7 <defrag+0x37>
    while (b && b->next) { 
  2c0ae2:	48 89 fb             	mov    %rdi,%rbx
  2c0ae5:	eb dd                	jmp    2c0ac4 <defrag+0x14>
            b->size += next->size + BLOCKSIZE;
  2c0ae7:	48 03 07             	add    (%rdi),%rax
  2c0aea:	48 89 03             	mov    %rax,(%rbx)
            b->next = next->next; 
  2c0aed:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0af1:	48 89 43 08          	mov    %rax,0x8(%rbx)
            remove_from_free_list(next);
  2c0af5:	e8 a3 fd ff ff       	call   2c089d <remove_from_free_list>
  2c0afa:	eb c8                	jmp    2c0ac4 <defrag+0x14>
        } else {
            b = b->next;
        }
    }
}
  2c0afc:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0b00:	c9                   	leave  
  2c0b01:	c3                   	ret    

00000000002c0b02 <sort_ptr_with_size>:

void sort_ptr_with_size(void **ptr_array, long *size_array, int allocs) {
  2c0b02:	f3 0f 1e fa          	endbr64 
  2c0b06:	55                   	push   %rbp
  2c0b07:	48 89 e5             	mov    %rsp,%rbp
  2c0b0a:	41 57                	push   %r15
  2c0b0c:	41 56                	push   %r14
  2c0b0e:	41 55                	push   %r13
  2c0b10:	41 54                	push   %r12
  2c0b12:	53                   	push   %rbx
  2c0b13:	48 83 ec 18          	sub    $0x18,%rsp
  2c0b17:	49 89 fd             	mov    %rdi,%r13
  2c0b1a:	49 89 f6             	mov    %rsi,%r14
  2c0b1d:	41 89 d4             	mov    %edx,%r12d
    // Create an array of ptr_with_size structs
    ptr_with_size *combined_array = (ptr_with_size *)malloc(allocs * sizeof(ptr_with_size));
  2c0b20:	4c 63 fa             	movslq %edx,%r15
  2c0b23:	4c 89 ff             	mov    %r15,%rdi
  2c0b26:	48 c1 e7 04          	shl    $0x4,%rdi
  2c0b2a:	e8 52 fe ff ff       	call   2c0981 <malloc>
    if (!combined_array) return; // Handle allocation failure
  2c0b2f:	48 85 c0             	test   %rax,%rax
  2c0b32:	0f 84 99 00 00 00    	je     2c0bd1 <sort_ptr_with_size+0xcf>
  2c0b38:	48 89 c3             	mov    %rax,%rbx
    // manually remove
    block *b = (block *)((char *)combined_array - BLOCKSIZE);
  2c0b3b:	48 8d 40 e8          	lea    -0x18(%rax),%rax
  2c0b3f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    remove_from_malloc_list(b);
  2c0b43:	48 89 c7             	mov    %rax,%rdi
  2c0b46:	e8 b6 fd ff ff       	call   2c0901 <remove_from_malloc_list>
    num_allocs--;
  2c0b4b:	83 2d ae 24 00 00 01 	subl   $0x1,0x24ae(%rip)        # 2c3000 <num_allocs>

    for (int i = 0; i < allocs; i++) {
  2c0b52:	45 85 e4             	test   %r12d,%r12d
  2c0b55:	0f 8e 85 00 00 00    	jle    2c0be0 <sort_ptr_with_size+0xde>
  2c0b5b:	45 89 e4             	mov    %r12d,%r12d
  2c0b5e:	49 c1 e4 03          	shl    $0x3,%r12
  2c0b62:	b8 00 00 00 00       	mov    $0x0,%eax
        combined_array[i].ptr = ptr_array[i];
  2c0b67:	49 8b 54 05 00       	mov    0x0(%r13,%rax,1),%rdx
  2c0b6c:	48 89 14 43          	mov    %rdx,(%rbx,%rax,2)
        combined_array[i].size = size_array[i];
  2c0b70:	49 8b 14 06          	mov    (%r14,%rax,1),%rdx
  2c0b74:	48 89 54 43 08       	mov    %rdx,0x8(%rbx,%rax,2)
    for (int i = 0; i < allocs; i++) {
  2c0b79:	48 83 c0 08          	add    $0x8,%rax
  2c0b7d:	4c 39 e0             	cmp    %r12,%rax
  2c0b80:	75 e5                	jne    2c0b67 <sort_ptr_with_size+0x65>
    }
    _quicksort1(combined_array, allocs, sizeof(ptr_with_size), ptr_comparator1);
  2c0b82:	48 8d 0d b0 f7 ff ff 	lea    -0x850(%rip),%rcx        # 2c0339 <ptr_comparator1>
  2c0b89:	ba 10 00 00 00       	mov    $0x10,%edx
  2c0b8e:	4c 89 fe             	mov    %r15,%rsi
  2c0b91:	48 89 df             	mov    %rbx,%rdi
  2c0b94:	e8 ac f7 ff ff       	call   2c0345 <_quicksort1>
  2c0b99:	b8 00 00 00 00       	mov    $0x0,%eax

    for (int i = 0; i < allocs; i++) {
        ptr_array[i] = combined_array[i].ptr;
  2c0b9e:	48 8b 14 43          	mov    (%rbx,%rax,2),%rdx
  2c0ba2:	49 89 54 05 00       	mov    %rdx,0x0(%r13,%rax,1)
        size_array[i] = combined_array[i].size;
  2c0ba7:	48 8b 54 43 08       	mov    0x8(%rbx,%rax,2),%rdx
  2c0bac:	49 89 14 06          	mov    %rdx,(%r14,%rax,1)
    for (int i = 0; i < allocs; i++) {
  2c0bb0:	48 83 c0 08          	add    $0x8,%rax
  2c0bb4:	4c 39 e0             	cmp    %r12,%rax
  2c0bb7:	75 e5                	jne    2c0b9e <sort_ptr_with_size+0x9c>
    }
    free(combined_array);
  2c0bb9:	48 89 df             	mov    %rbx,%rdi
  2c0bbc:	e8 86 fd ff ff       	call   2c0947 <free>
    // manually remove from free list
    remove_from_free_list(b);
  2c0bc1:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  2c0bc5:	e8 d3 fc ff ff       	call   2c089d <remove_from_free_list>
    num_allocs++;
  2c0bca:	83 05 2f 24 00 00 01 	addl   $0x1,0x242f(%rip)        # 2c3000 <num_allocs>
}
  2c0bd1:	48 83 c4 18          	add    $0x18,%rsp
  2c0bd5:	5b                   	pop    %rbx
  2c0bd6:	41 5c                	pop    %r12
  2c0bd8:	41 5d                	pop    %r13
  2c0bda:	41 5e                	pop    %r14
  2c0bdc:	41 5f                	pop    %r15
  2c0bde:	5d                   	pop    %rbp
  2c0bdf:	c3                   	ret    
    _quicksort1(combined_array, allocs, sizeof(ptr_with_size), ptr_comparator1);
  2c0be0:	48 8d 0d 52 f7 ff ff 	lea    -0x8ae(%rip),%rcx        # 2c0339 <ptr_comparator1>
  2c0be7:	ba 10 00 00 00       	mov    $0x10,%edx
  2c0bec:	4c 89 fe             	mov    %r15,%rsi
  2c0bef:	48 89 df             	mov    %rbx,%rdi
  2c0bf2:	e8 4e f7 ff ff       	call   2c0345 <_quicksort1>
    for (int i = 0; i < allocs; i++) {
  2c0bf7:	eb c0                	jmp    2c0bb9 <sort_ptr_with_size+0xb7>

00000000002c0bf9 <heap_info>:

int heap_info(heap_info_struct * info) {
  2c0bf9:	f3 0f 1e fa          	endbr64 
  2c0bfd:	55                   	push   %rbp
  2c0bfe:	48 89 e5             	mov    %rsp,%rbp
  2c0c01:	41 57                	push   %r15
  2c0c03:	41 56                	push   %r14
  2c0c05:	41 55                	push   %r13
  2c0c07:	41 54                	push   %r12
  2c0c09:	53                   	push   %rbx
  2c0c0a:	48 83 ec 08          	sub    $0x8,%rsp
  2c0c0e:	49 89 fd             	mov    %rdi,%r13
    if (num_allocs == 0) {
  2c0c11:	8b 05 e9 23 00 00    	mov    0x23e9(%rip),%eax        # 2c3000 <num_allocs>
  2c0c17:	85 c0                	test   %eax,%eax
  2c0c19:	75 2d                	jne    2c0c48 <heap_info+0x4f>
    info->size_array = NULL;
  2c0c1b:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c0c22:	00 
    info->ptr_array = NULL;
  2c0c23:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  2c0c2a:	00 
    info->free_space = 0;
  2c0c2b:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
    info->largest_free_chunk = 0;
  2c0c32:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)
    info->size_array = size_array;
    info->ptr_array = ptr_array;
    info->free_space = (int)free_space;
    info->largest_free_chunk = (int)largest_free_chunk;
    return 0;
  2c0c39:	48 83 c4 08          	add    $0x8,%rsp
  2c0c3d:	5b                   	pop    %rbx
  2c0c3e:	41 5c                	pop    %r12
  2c0c40:	41 5d                	pop    %r13
  2c0c42:	41 5e                	pop    %r14
  2c0c44:	41 5f                	pop    %r15
  2c0c46:	5d                   	pop    %rbp
  2c0c47:	c3                   	ret    
    info->num_allocs = num_allocs;
  2c0c48:	89 07                	mov    %eax,(%rdi)
    long *size_array = (long*)malloc((num_allocs) * sizeof(long));
  2c0c4a:	48 98                	cltq   
  2c0c4c:	48 8d 3c c5 00 00 00 	lea    0x0(,%rax,8),%rdi
  2c0c53:	00 
  2c0c54:	e8 28 fd ff ff       	call   2c0981 <malloc>
  2c0c59:	49 89 c6             	mov    %rax,%r14
    void **ptr_array = (void**)malloc((num_allocs) * sizeof(void*));
  2c0c5c:	48 63 3d 9d 23 00 00 	movslq 0x239d(%rip),%rdi        # 2c3000 <num_allocs>
  2c0c63:	48 c1 e7 03          	shl    $0x3,%rdi
  2c0c67:	e8 15 fd ff ff       	call   2c0981 <malloc>
  2c0c6c:	49 89 c7             	mov    %rax,%r15
    if (!size_array || !ptr_array) {
  2c0c6f:	4d 85 f6             	test   %r14,%r14
  2c0c72:	0f 84 ac 00 00 00    	je     2c0d24 <heap_info+0x12b>
  2c0c78:	48 85 c0             	test   %rax,%rax
  2c0c7b:	0f 84 a3 00 00 00    	je     2c0d24 <heap_info+0x12b>
    block *bf = free_head;
  2c0c81:	48 8b 05 90 23 00 00 	mov    0x2390(%rip),%rax        # 2c3018 <free_head>
    while (bf) {
  2c0c88:	48 85 c0             	test   %rax,%rax
  2c0c8b:	0f 84 86 00 00 00    	je     2c0d17 <heap_info+0x11e>
    size_t largest_free_chunk = 0;
  2c0c91:	bb 00 00 00 00       	mov    $0x0,%ebx
    size_t free_space = 0;
  2c0c96:	41 bc 00 00 00 00    	mov    $0x0,%r12d
        free_space += bf->size + BLOCKSIZE;
  2c0c9c:	48 8b 10             	mov    (%rax),%rdx
  2c0c9f:	4e 8d 64 22 18       	lea    0x18(%rdx,%r12,1),%r12
        if (bf->size > largest_free_chunk) {
  2c0ca4:	48 39 d3             	cmp    %rdx,%rbx
  2c0ca7:	48 0f 42 da          	cmovb  %rdx,%rbx
        bf = bf->next;
  2c0cab:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bf) {
  2c0caf:	48 85 c0             	test   %rax,%rax
  2c0cb2:	75 e8                	jne    2c0c9c <heap_info+0xa3>
    block *bm = malloc_head->next->next;
  2c0cb4:	48 8b 05 55 23 00 00 	mov    0x2355(%rip),%rax        # 2c3010 <malloc_head>
  2c0cbb:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0cbf:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bm) {
  2c0cc3:	48 85 c0             	test   %rax,%rax
  2c0cc6:	74 21                	je     2c0ce9 <heap_info+0xf0>
  2c0cc8:	ba 00 00 00 00       	mov    $0x0,%edx
        size_array[x] = bm->size;
  2c0ccd:	48 8b 08             	mov    (%rax),%rcx
  2c0cd0:	49 89 0c 16          	mov    %rcx,(%r14,%rdx,1)
        ptr_array[x] = (void*)((void*)bm + BLOCKSIZE);
  2c0cd4:	48 8d 48 18          	lea    0x18(%rax),%rcx
  2c0cd8:	49 89 0c 17          	mov    %rcx,(%r15,%rdx,1)
        bm = bm->next;
  2c0cdc:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bm) {
  2c0ce0:	48 83 c2 08          	add    $0x8,%rdx
  2c0ce4:	48 85 c0             	test   %rax,%rax
  2c0ce7:	75 e4                	jne    2c0ccd <heap_info+0xd4>
    sort_ptr_with_size(ptr_array, size_array, num_allocs-2);
  2c0ce9:	8b 05 11 23 00 00    	mov    0x2311(%rip),%eax        # 2c3000 <num_allocs>
  2c0cef:	8d 50 fe             	lea    -0x2(%rax),%edx
  2c0cf2:	4c 89 f6             	mov    %r14,%rsi
  2c0cf5:	4c 89 ff             	mov    %r15,%rdi
  2c0cf8:	e8 05 fe ff ff       	call   2c0b02 <sort_ptr_with_size>
    info->size_array = size_array;
  2c0cfd:	4d 89 75 08          	mov    %r14,0x8(%r13)
    info->ptr_array = ptr_array;
  2c0d01:	4d 89 7d 10          	mov    %r15,0x10(%r13)
    info->free_space = (int)free_space;
  2c0d05:	45 89 65 18          	mov    %r12d,0x18(%r13)
    info->largest_free_chunk = (int)largest_free_chunk;
  2c0d09:	41 89 5d 1c          	mov    %ebx,0x1c(%r13)
    return 0;
  2c0d0d:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0d12:	e9 22 ff ff ff       	jmp    2c0c39 <heap_info+0x40>
    size_t largest_free_chunk = 0;
  2c0d17:	bb 00 00 00 00       	mov    $0x0,%ebx
    size_t free_space = 0;
  2c0d1c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0d22:	eb 90                	jmp    2c0cb4 <heap_info+0xbb>
        return -1;
  2c0d24:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0d29:	e9 0b ff ff ff       	jmp    2c0c39 <heap_info+0x40>

00000000002c0d2e <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c0d2e:	f3 0f 1e fa          	endbr64 
  2c0d32:	55                   	push   %rbp
  2c0d33:	48 89 e5             	mov    %rsp,%rbp
  2c0d36:	48 83 ec 28          	sub    $0x28,%rsp
  2c0d3a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0d3e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0d42:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0d46:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0d4a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0d4e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0d52:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c0d56:	eb 1c                	jmp    2c0d74 <memcpy+0x46>
        *d = *s;
  2c0d58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0d5c:	0f b6 10             	movzbl (%rax),%edx
  2c0d5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0d63:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0d65:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0d6a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0d6f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0d74:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0d79:	75 dd                	jne    2c0d58 <memcpy+0x2a>
    }
    return dst;
  2c0d7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0d7f:	c9                   	leave  
  2c0d80:	c3                   	ret    

00000000002c0d81 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0d81:	f3 0f 1e fa          	endbr64 
  2c0d85:	55                   	push   %rbp
  2c0d86:	48 89 e5             	mov    %rsp,%rbp
  2c0d89:	48 83 ec 28          	sub    $0x28,%rsp
  2c0d8d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0d91:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0d95:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0d99:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0d9d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0da1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0da5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0da9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0dad:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0db1:	73 6a                	jae    2c0e1d <memmove+0x9c>
  2c0db3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0db7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0dbb:	48 01 d0             	add    %rdx,%rax
  2c0dbe:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0dc2:	73 59                	jae    2c0e1d <memmove+0x9c>
        s += n, d += n;
  2c0dc4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0dc8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0dcc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0dd0:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0dd4:	eb 17                	jmp    2c0ded <memmove+0x6c>
            *--d = *--s;
  2c0dd6:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0ddb:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0de0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0de4:	0f b6 10             	movzbl (%rax),%edx
  2c0de7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0deb:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0ded:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0df1:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0df5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0df9:	48 85 c0             	test   %rax,%rax
  2c0dfc:	75 d8                	jne    2c0dd6 <memmove+0x55>
    if (s < d && s + n > d) {
  2c0dfe:	eb 2e                	jmp    2c0e2e <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0e00:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0e04:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0e08:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0e0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0e10:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0e14:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0e18:	0f b6 12             	movzbl (%rdx),%edx
  2c0e1b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0e1d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0e21:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0e25:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0e29:	48 85 c0             	test   %rax,%rax
  2c0e2c:	75 d2                	jne    2c0e00 <memmove+0x7f>
        }
    }
    return dst;
  2c0e2e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0e32:	c9                   	leave  
  2c0e33:	c3                   	ret    

00000000002c0e34 <memset>:

void* memset(void* v, int c, size_t n) {
  2c0e34:	f3 0f 1e fa          	endbr64 
  2c0e38:	55                   	push   %rbp
  2c0e39:	48 89 e5             	mov    %rsp,%rbp
  2c0e3c:	48 83 ec 28          	sub    $0x28,%rsp
  2c0e40:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0e44:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0e47:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0e4b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0e4f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0e53:	eb 15                	jmp    2c0e6a <memset+0x36>
        *p = c;
  2c0e55:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0e58:	89 c2                	mov    %eax,%edx
  2c0e5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0e5e:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0e60:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0e65:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0e6a:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0e6f:	75 e4                	jne    2c0e55 <memset+0x21>
    }
    return v;
  2c0e71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0e75:	c9                   	leave  
  2c0e76:	c3                   	ret    

00000000002c0e77 <strlen>:

size_t strlen(const char* s) {
  2c0e77:	f3 0f 1e fa          	endbr64 
  2c0e7b:	55                   	push   %rbp
  2c0e7c:	48 89 e5             	mov    %rsp,%rbp
  2c0e7f:	48 83 ec 18          	sub    $0x18,%rsp
  2c0e83:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0e87:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0e8e:	00 
  2c0e8f:	eb 0a                	jmp    2c0e9b <strlen+0x24>
        ++n;
  2c0e91:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0e96:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0e9b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0e9f:	0f b6 00             	movzbl (%rax),%eax
  2c0ea2:	84 c0                	test   %al,%al
  2c0ea4:	75 eb                	jne    2c0e91 <strlen+0x1a>
    }
    return n;
  2c0ea6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0eaa:	c9                   	leave  
  2c0eab:	c3                   	ret    

00000000002c0eac <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0eac:	f3 0f 1e fa          	endbr64 
  2c0eb0:	55                   	push   %rbp
  2c0eb1:	48 89 e5             	mov    %rsp,%rbp
  2c0eb4:	48 83 ec 20          	sub    $0x20,%rsp
  2c0eb8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0ebc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0ec0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0ec7:	00 
  2c0ec8:	eb 0a                	jmp    2c0ed4 <strnlen+0x28>
        ++n;
  2c0eca:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0ecf:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0ed4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ed8:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0edc:	74 0b                	je     2c0ee9 <strnlen+0x3d>
  2c0ede:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0ee2:	0f b6 00             	movzbl (%rax),%eax
  2c0ee5:	84 c0                	test   %al,%al
  2c0ee7:	75 e1                	jne    2c0eca <strnlen+0x1e>
    }
    return n;
  2c0ee9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0eed:	c9                   	leave  
  2c0eee:	c3                   	ret    

00000000002c0eef <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0eef:	f3 0f 1e fa          	endbr64 
  2c0ef3:	55                   	push   %rbp
  2c0ef4:	48 89 e5             	mov    %rsp,%rbp
  2c0ef7:	48 83 ec 20          	sub    $0x20,%rsp
  2c0efb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0eff:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0f03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0f07:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0f0b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0f0f:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0f13:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0f17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f1b:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0f1f:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0f23:	0f b6 12             	movzbl (%rdx),%edx
  2c0f26:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0f28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f2c:	48 83 e8 01          	sub    $0x1,%rax
  2c0f30:	0f b6 00             	movzbl (%rax),%eax
  2c0f33:	84 c0                	test   %al,%al
  2c0f35:	75 d4                	jne    2c0f0b <strcpy+0x1c>
    return dst;
  2c0f37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0f3b:	c9                   	leave  
  2c0f3c:	c3                   	ret    

00000000002c0f3d <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0f3d:	f3 0f 1e fa          	endbr64 
  2c0f41:	55                   	push   %rbp
  2c0f42:	48 89 e5             	mov    %rsp,%rbp
  2c0f45:	48 83 ec 10          	sub    $0x10,%rsp
  2c0f49:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0f4d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0f51:	eb 0a                	jmp    2c0f5d <strcmp+0x20>
        ++a, ++b;
  2c0f53:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0f58:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0f5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f61:	0f b6 00             	movzbl (%rax),%eax
  2c0f64:	84 c0                	test   %al,%al
  2c0f66:	74 1d                	je     2c0f85 <strcmp+0x48>
  2c0f68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0f6c:	0f b6 00             	movzbl (%rax),%eax
  2c0f6f:	84 c0                	test   %al,%al
  2c0f71:	74 12                	je     2c0f85 <strcmp+0x48>
  2c0f73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f77:	0f b6 10             	movzbl (%rax),%edx
  2c0f7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0f7e:	0f b6 00             	movzbl (%rax),%eax
  2c0f81:	38 c2                	cmp    %al,%dl
  2c0f83:	74 ce                	je     2c0f53 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0f85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0f89:	0f b6 00             	movzbl (%rax),%eax
  2c0f8c:	89 c2                	mov    %eax,%edx
  2c0f8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0f92:	0f b6 00             	movzbl (%rax),%eax
  2c0f95:	38 c2                	cmp    %al,%dl
  2c0f97:	0f 97 c0             	seta   %al
  2c0f9a:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0f9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0fa1:	0f b6 00             	movzbl (%rax),%eax
  2c0fa4:	89 c1                	mov    %eax,%ecx
  2c0fa6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0faa:	0f b6 00             	movzbl (%rax),%eax
  2c0fad:	38 c1                	cmp    %al,%cl
  2c0faf:	0f 92 c0             	setb   %al
  2c0fb2:	0f b6 c8             	movzbl %al,%ecx
  2c0fb5:	89 d0                	mov    %edx,%eax
  2c0fb7:	29 c8                	sub    %ecx,%eax
}
  2c0fb9:	c9                   	leave  
  2c0fba:	c3                   	ret    

00000000002c0fbb <strchr>:

char* strchr(const char* s, int c) {
  2c0fbb:	f3 0f 1e fa          	endbr64 
  2c0fbf:	55                   	push   %rbp
  2c0fc0:	48 89 e5             	mov    %rsp,%rbp
  2c0fc3:	48 83 ec 10          	sub    $0x10,%rsp
  2c0fc7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0fcb:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0fce:	eb 05                	jmp    2c0fd5 <strchr+0x1a>
        ++s;
  2c0fd0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0fd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0fd9:	0f b6 00             	movzbl (%rax),%eax
  2c0fdc:	84 c0                	test   %al,%al
  2c0fde:	74 0e                	je     2c0fee <strchr+0x33>
  2c0fe0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0fe4:	0f b6 00             	movzbl (%rax),%eax
  2c0fe7:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0fea:	38 d0                	cmp    %dl,%al
  2c0fec:	75 e2                	jne    2c0fd0 <strchr+0x15>
    }
    if (*s == (char) c) {
  2c0fee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ff2:	0f b6 00             	movzbl (%rax),%eax
  2c0ff5:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0ff8:	38 d0                	cmp    %dl,%al
  2c0ffa:	75 06                	jne    2c1002 <strchr+0x47>
        return (char*) s;
  2c0ffc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1000:	eb 05                	jmp    2c1007 <strchr+0x4c>
    } else {
        return NULL;
  2c1002:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c1007:	c9                   	leave  
  2c1008:	c3                   	ret    

00000000002c1009 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c1009:	f3 0f 1e fa          	endbr64 
  2c100d:	55                   	push   %rbp
  2c100e:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c1011:	8b 05 09 20 00 00    	mov    0x2009(%rip),%eax        # 2c3020 <rand_seed_set>
  2c1017:	85 c0                	test   %eax,%eax
  2c1019:	75 0a                	jne    2c1025 <rand+0x1c>
        srand(819234718U);
  2c101b:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c1020:	e8 24 00 00 00       	call   2c1049 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c1025:	8b 05 f9 1f 00 00    	mov    0x1ff9(%rip),%eax        # 2c3024 <rand_seed>
  2c102b:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c1031:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c1036:	89 05 e8 1f 00 00    	mov    %eax,0x1fe8(%rip)        # 2c3024 <rand_seed>
    return rand_seed & RAND_MAX;
  2c103c:	8b 05 e2 1f 00 00    	mov    0x1fe2(%rip),%eax        # 2c3024 <rand_seed>
  2c1042:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c1047:	5d                   	pop    %rbp
  2c1048:	c3                   	ret    

00000000002c1049 <srand>:

void srand(unsigned seed) {
  2c1049:	f3 0f 1e fa          	endbr64 
  2c104d:	55                   	push   %rbp
  2c104e:	48 89 e5             	mov    %rsp,%rbp
  2c1051:	48 83 ec 08          	sub    $0x8,%rsp
  2c1055:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c1058:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c105b:	89 05 c3 1f 00 00    	mov    %eax,0x1fc3(%rip)        # 2c3024 <rand_seed>
    rand_seed_set = 1;
  2c1061:	c7 05 b5 1f 00 00 01 	movl   $0x1,0x1fb5(%rip)        # 2c3020 <rand_seed_set>
  2c1068:	00 00 00 
}
  2c106b:	90                   	nop
  2c106c:	c9                   	leave  
  2c106d:	c3                   	ret    

00000000002c106e <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c106e:	f3 0f 1e fa          	endbr64 
  2c1072:	55                   	push   %rbp
  2c1073:	48 89 e5             	mov    %rsp,%rbp
  2c1076:	48 83 ec 28          	sub    $0x28,%rsp
  2c107a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c107e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c1082:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c1085:	48 8d 05 94 0f 00 00 	lea    0xf94(%rip),%rax        # 2c2020 <upper_digits.1>
  2c108c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  2c1090:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c1094:	79 0e                	jns    2c10a4 <fill_numbuf+0x36>
        digits = lower_digits;
  2c1096:	48 8d 05 a3 0f 00 00 	lea    0xfa3(%rip),%rax        # 2c2040 <lower_digits.0>
  2c109d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  2c10a1:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c10a4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c10a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c10ad:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c10b0:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c10b3:	48 63 c8             	movslq %eax,%rcx
  2c10b6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c10ba:	ba 00 00 00 00       	mov    $0x0,%edx
  2c10bf:	48 f7 f1             	div    %rcx
  2c10c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c10c6:	48 01 d0             	add    %rdx,%rax
  2c10c9:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c10ce:	0f b6 10             	movzbl (%rax),%edx
  2c10d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c10d5:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c10d7:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c10da:	48 63 f0             	movslq %eax,%rsi
  2c10dd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c10e1:	ba 00 00 00 00       	mov    $0x0,%edx
  2c10e6:	48 f7 f6             	div    %rsi
  2c10e9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c10ed:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c10f2:	75 bc                	jne    2c10b0 <fill_numbuf+0x42>
    return numbuf_end;
  2c10f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c10f8:	c9                   	leave  
  2c10f9:	c3                   	ret    

00000000002c10fa <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c10fa:	f3 0f 1e fa          	endbr64 
  2c10fe:	55                   	push   %rbp
  2c10ff:	48 89 e5             	mov    %rsp,%rbp
  2c1102:	53                   	push   %rbx
  2c1103:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c110a:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c1111:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c1117:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c111e:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c1125:	e9 bd 09 00 00       	jmp    2c1ae7 <printer_vprintf+0x9ed>
        if (*format != '%') {
  2c112a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1131:	0f b6 00             	movzbl (%rax),%eax
  2c1134:	3c 25                	cmp    $0x25,%al
  2c1136:	74 31                	je     2c1169 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  2c1138:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c113f:	4c 8b 00             	mov    (%rax),%r8
  2c1142:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1149:	0f b6 00             	movzbl (%rax),%eax
  2c114c:	0f b6 c8             	movzbl %al,%ecx
  2c114f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1155:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c115c:	89 ce                	mov    %ecx,%esi
  2c115e:	48 89 c7             	mov    %rax,%rdi
  2c1161:	41 ff d0             	call   *%r8
            continue;
  2c1164:	e9 76 09 00 00       	jmp    2c1adf <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  2c1169:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c1170:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1177:	01 
  2c1178:	eb 4d                	jmp    2c11c7 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  2c117a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1181:	0f b6 00             	movzbl (%rax),%eax
  2c1184:	0f be c0             	movsbl %al,%eax
  2c1187:	89 c6                	mov    %eax,%esi
  2c1189:	48 8d 05 90 0d 00 00 	lea    0xd90(%rip),%rax        # 2c1f20 <flag_chars>
  2c1190:	48 89 c7             	mov    %rax,%rdi
  2c1193:	e8 23 fe ff ff       	call   2c0fbb <strchr>
  2c1198:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c119c:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c11a1:	74 34                	je     2c11d7 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  2c11a3:	48 8d 15 76 0d 00 00 	lea    0xd76(%rip),%rdx        # 2c1f20 <flag_chars>
  2c11aa:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c11ae:	48 29 d0             	sub    %rdx,%rax
  2c11b1:	ba 01 00 00 00       	mov    $0x1,%edx
  2c11b6:	89 c1                	mov    %eax,%ecx
  2c11b8:	d3 e2                	shl    %cl,%edx
  2c11ba:	89 d0                	mov    %edx,%eax
  2c11bc:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c11bf:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c11c6:	01 
  2c11c7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11ce:	0f b6 00             	movzbl (%rax),%eax
  2c11d1:	84 c0                	test   %al,%al
  2c11d3:	75 a5                	jne    2c117a <printer_vprintf+0x80>
  2c11d5:	eb 01                	jmp    2c11d8 <printer_vprintf+0xde>
            } else {
                break;
  2c11d7:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c11d8:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c11df:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11e6:	0f b6 00             	movzbl (%rax),%eax
  2c11e9:	3c 30                	cmp    $0x30,%al
  2c11eb:	7e 67                	jle    2c1254 <printer_vprintf+0x15a>
  2c11ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c11f4:	0f b6 00             	movzbl (%rax),%eax
  2c11f7:	3c 39                	cmp    $0x39,%al
  2c11f9:	7f 59                	jg     2c1254 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c11fb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c1202:	eb 2e                	jmp    2c1232 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  2c1204:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c1207:	89 d0                	mov    %edx,%eax
  2c1209:	c1 e0 02             	shl    $0x2,%eax
  2c120c:	01 d0                	add    %edx,%eax
  2c120e:	01 c0                	add    %eax,%eax
  2c1210:	89 c1                	mov    %eax,%ecx
  2c1212:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1219:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c121d:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c1224:	0f b6 00             	movzbl (%rax),%eax
  2c1227:	0f be c0             	movsbl %al,%eax
  2c122a:	01 c8                	add    %ecx,%eax
  2c122c:	83 e8 30             	sub    $0x30,%eax
  2c122f:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c1232:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1239:	0f b6 00             	movzbl (%rax),%eax
  2c123c:	3c 2f                	cmp    $0x2f,%al
  2c123e:	0f 8e 85 00 00 00    	jle    2c12c9 <printer_vprintf+0x1cf>
  2c1244:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c124b:	0f b6 00             	movzbl (%rax),%eax
  2c124e:	3c 39                	cmp    $0x39,%al
  2c1250:	7e b2                	jle    2c1204 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  2c1252:	eb 75                	jmp    2c12c9 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  2c1254:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c125b:	0f b6 00             	movzbl (%rax),%eax
  2c125e:	3c 2a                	cmp    $0x2a,%al
  2c1260:	75 68                	jne    2c12ca <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  2c1262:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1269:	8b 00                	mov    (%rax),%eax
  2c126b:	83 f8 2f             	cmp    $0x2f,%eax
  2c126e:	77 30                	ja     2c12a0 <printer_vprintf+0x1a6>
  2c1270:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1277:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c127b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1282:	8b 00                	mov    (%rax),%eax
  2c1284:	89 c0                	mov    %eax,%eax
  2c1286:	48 01 d0             	add    %rdx,%rax
  2c1289:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1290:	8b 12                	mov    (%rdx),%edx
  2c1292:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1295:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c129c:	89 0a                	mov    %ecx,(%rdx)
  2c129e:	eb 1a                	jmp    2c12ba <printer_vprintf+0x1c0>
  2c12a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12a7:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c12ab:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c12af:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12b6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c12ba:	8b 00                	mov    (%rax),%eax
  2c12bc:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c12bf:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c12c6:	01 
  2c12c7:	eb 01                	jmp    2c12ca <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  2c12c9:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c12ca:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c12d1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c12d8:	0f b6 00             	movzbl (%rax),%eax
  2c12db:	3c 2e                	cmp    $0x2e,%al
  2c12dd:	0f 85 00 01 00 00    	jne    2c13e3 <printer_vprintf+0x2e9>
            ++format;
  2c12e3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c12ea:	01 
            if (*format >= '0' && *format <= '9') {
  2c12eb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c12f2:	0f b6 00             	movzbl (%rax),%eax
  2c12f5:	3c 2f                	cmp    $0x2f,%al
  2c12f7:	7e 67                	jle    2c1360 <printer_vprintf+0x266>
  2c12f9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1300:	0f b6 00             	movzbl (%rax),%eax
  2c1303:	3c 39                	cmp    $0x39,%al
  2c1305:	7f 59                	jg     2c1360 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c1307:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c130e:	eb 2e                	jmp    2c133e <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  2c1310:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c1313:	89 d0                	mov    %edx,%eax
  2c1315:	c1 e0 02             	shl    $0x2,%eax
  2c1318:	01 d0                	add    %edx,%eax
  2c131a:	01 c0                	add    %eax,%eax
  2c131c:	89 c1                	mov    %eax,%ecx
  2c131e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1325:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c1329:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c1330:	0f b6 00             	movzbl (%rax),%eax
  2c1333:	0f be c0             	movsbl %al,%eax
  2c1336:	01 c8                	add    %ecx,%eax
  2c1338:	83 e8 30             	sub    $0x30,%eax
  2c133b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c133e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1345:	0f b6 00             	movzbl (%rax),%eax
  2c1348:	3c 2f                	cmp    $0x2f,%al
  2c134a:	0f 8e 85 00 00 00    	jle    2c13d5 <printer_vprintf+0x2db>
  2c1350:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1357:	0f b6 00             	movzbl (%rax),%eax
  2c135a:	3c 39                	cmp    $0x39,%al
  2c135c:	7e b2                	jle    2c1310 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  2c135e:	eb 75                	jmp    2c13d5 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  2c1360:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1367:	0f b6 00             	movzbl (%rax),%eax
  2c136a:	3c 2a                	cmp    $0x2a,%al
  2c136c:	75 68                	jne    2c13d6 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  2c136e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1375:	8b 00                	mov    (%rax),%eax
  2c1377:	83 f8 2f             	cmp    $0x2f,%eax
  2c137a:	77 30                	ja     2c13ac <printer_vprintf+0x2b2>
  2c137c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1383:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1387:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c138e:	8b 00                	mov    (%rax),%eax
  2c1390:	89 c0                	mov    %eax,%eax
  2c1392:	48 01 d0             	add    %rdx,%rax
  2c1395:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c139c:	8b 12                	mov    (%rdx),%edx
  2c139e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c13a1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13a8:	89 0a                	mov    %ecx,(%rdx)
  2c13aa:	eb 1a                	jmp    2c13c6 <printer_vprintf+0x2cc>
  2c13ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13b3:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c13b7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c13bb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13c2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c13c6:	8b 00                	mov    (%rax),%eax
  2c13c8:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c13cb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c13d2:	01 
  2c13d3:	eb 01                	jmp    2c13d6 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  2c13d5:	90                   	nop
            }
            if (precision < 0) {
  2c13d6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c13da:	79 07                	jns    2c13e3 <printer_vprintf+0x2e9>
                precision = 0;
  2c13dc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c13e3:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c13ea:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c13f1:	00 
        int length = 0;
  2c13f2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c13f9:	48 8d 05 26 0b 00 00 	lea    0xb26(%rip),%rax        # 2c1f26 <flag_chars+0x6>
  2c1400:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  2c1404:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c140b:	0f b6 00             	movzbl (%rax),%eax
  2c140e:	0f be c0             	movsbl %al,%eax
  2c1411:	83 e8 43             	sub    $0x43,%eax
  2c1414:	83 f8 37             	cmp    $0x37,%eax
  2c1417:	0f 87 b6 03 00 00    	ja     2c17d3 <printer_vprintf+0x6d9>
  2c141d:	89 c0                	mov    %eax,%eax
  2c141f:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  2c1426:	00 
  2c1427:	48 8d 05 06 0b 00 00 	lea    0xb06(%rip),%rax        # 2c1f34 <flag_chars+0x14>
  2c142e:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  2c1431:	48 98                	cltq   
  2c1433:	48 8d 15 fa 0a 00 00 	lea    0xafa(%rip),%rdx        # 2c1f34 <flag_chars+0x14>
  2c143a:	48 01 d0             	add    %rdx,%rax
  2c143d:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  2c1440:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c1447:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c144e:	01 
            goto again;
  2c144f:	eb b3                	jmp    2c1404 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c1451:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c1455:	74 5d                	je     2c14b4 <printer_vprintf+0x3ba>
  2c1457:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c145e:	8b 00                	mov    (%rax),%eax
  2c1460:	83 f8 2f             	cmp    $0x2f,%eax
  2c1463:	77 30                	ja     2c1495 <printer_vprintf+0x39b>
  2c1465:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c146c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1470:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1477:	8b 00                	mov    (%rax),%eax
  2c1479:	89 c0                	mov    %eax,%eax
  2c147b:	48 01 d0             	add    %rdx,%rax
  2c147e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1485:	8b 12                	mov    (%rdx),%edx
  2c1487:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c148a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1491:	89 0a                	mov    %ecx,(%rdx)
  2c1493:	eb 1a                	jmp    2c14af <printer_vprintf+0x3b5>
  2c1495:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c149c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14a0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c14a4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c14ab:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c14af:	48 8b 00             	mov    (%rax),%rax
  2c14b2:	eb 5c                	jmp    2c1510 <printer_vprintf+0x416>
  2c14b4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14bb:	8b 00                	mov    (%rax),%eax
  2c14bd:	83 f8 2f             	cmp    $0x2f,%eax
  2c14c0:	77 30                	ja     2c14f2 <printer_vprintf+0x3f8>
  2c14c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14c9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c14cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14d4:	8b 00                	mov    (%rax),%eax
  2c14d6:	89 c0                	mov    %eax,%eax
  2c14d8:	48 01 d0             	add    %rdx,%rax
  2c14db:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c14e2:	8b 12                	mov    (%rdx),%edx
  2c14e4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c14e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c14ee:	89 0a                	mov    %ecx,(%rdx)
  2c14f0:	eb 1a                	jmp    2c150c <printer_vprintf+0x412>
  2c14f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c14f9:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c14fd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1501:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1508:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c150c:	8b 00                	mov    (%rax),%eax
  2c150e:	48 98                	cltq   
  2c1510:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c1514:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1518:	48 c1 f8 38          	sar    $0x38,%rax
  2c151c:	25 80 00 00 00       	and    $0x80,%eax
  2c1521:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c1524:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c1528:	74 09                	je     2c1533 <printer_vprintf+0x439>
  2c152a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c152e:	48 f7 d8             	neg    %rax
  2c1531:	eb 04                	jmp    2c1537 <printer_vprintf+0x43d>
  2c1533:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1537:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c153b:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c153e:	83 c8 60             	or     $0x60,%eax
  2c1541:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c1544:	e9 cf 02 00 00       	jmp    2c1818 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c1549:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c154d:	74 5d                	je     2c15ac <printer_vprintf+0x4b2>
  2c154f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1556:	8b 00                	mov    (%rax),%eax
  2c1558:	83 f8 2f             	cmp    $0x2f,%eax
  2c155b:	77 30                	ja     2c158d <printer_vprintf+0x493>
  2c155d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1564:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1568:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c156f:	8b 00                	mov    (%rax),%eax
  2c1571:	89 c0                	mov    %eax,%eax
  2c1573:	48 01 d0             	add    %rdx,%rax
  2c1576:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c157d:	8b 12                	mov    (%rdx),%edx
  2c157f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1582:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1589:	89 0a                	mov    %ecx,(%rdx)
  2c158b:	eb 1a                	jmp    2c15a7 <printer_vprintf+0x4ad>
  2c158d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1594:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1598:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c159c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c15a3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c15a7:	48 8b 00             	mov    (%rax),%rax
  2c15aa:	eb 5c                	jmp    2c1608 <printer_vprintf+0x50e>
  2c15ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15b3:	8b 00                	mov    (%rax),%eax
  2c15b5:	83 f8 2f             	cmp    $0x2f,%eax
  2c15b8:	77 30                	ja     2c15ea <printer_vprintf+0x4f0>
  2c15ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15c1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c15c5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15cc:	8b 00                	mov    (%rax),%eax
  2c15ce:	89 c0                	mov    %eax,%eax
  2c15d0:	48 01 d0             	add    %rdx,%rax
  2c15d3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c15da:	8b 12                	mov    (%rdx),%edx
  2c15dc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c15df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c15e6:	89 0a                	mov    %ecx,(%rdx)
  2c15e8:	eb 1a                	jmp    2c1604 <printer_vprintf+0x50a>
  2c15ea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c15f1:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c15f5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c15f9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1600:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1604:	8b 00                	mov    (%rax),%eax
  2c1606:	89 c0                	mov    %eax,%eax
  2c1608:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c160c:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c1610:	e9 03 02 00 00       	jmp    2c1818 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  2c1615:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c161c:	e9 28 ff ff ff       	jmp    2c1549 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  2c1621:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c1628:	e9 1c ff ff ff       	jmp    2c1549 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c162d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1634:	8b 00                	mov    (%rax),%eax
  2c1636:	83 f8 2f             	cmp    $0x2f,%eax
  2c1639:	77 30                	ja     2c166b <printer_vprintf+0x571>
  2c163b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1642:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1646:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c164d:	8b 00                	mov    (%rax),%eax
  2c164f:	89 c0                	mov    %eax,%eax
  2c1651:	48 01 d0             	add    %rdx,%rax
  2c1654:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c165b:	8b 12                	mov    (%rdx),%edx
  2c165d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1660:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1667:	89 0a                	mov    %ecx,(%rdx)
  2c1669:	eb 1a                	jmp    2c1685 <printer_vprintf+0x58b>
  2c166b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1672:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1676:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c167a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1681:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1685:	48 8b 00             	mov    (%rax),%rax
  2c1688:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c168c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c1693:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c169a:	e9 79 01 00 00       	jmp    2c1818 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  2c169f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16a6:	8b 00                	mov    (%rax),%eax
  2c16a8:	83 f8 2f             	cmp    $0x2f,%eax
  2c16ab:	77 30                	ja     2c16dd <printer_vprintf+0x5e3>
  2c16ad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16b4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c16b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16bf:	8b 00                	mov    (%rax),%eax
  2c16c1:	89 c0                	mov    %eax,%eax
  2c16c3:	48 01 d0             	add    %rdx,%rax
  2c16c6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16cd:	8b 12                	mov    (%rdx),%edx
  2c16cf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c16d2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16d9:	89 0a                	mov    %ecx,(%rdx)
  2c16db:	eb 1a                	jmp    2c16f7 <printer_vprintf+0x5fd>
  2c16dd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c16e4:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c16e8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c16ec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c16f3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c16f7:	48 8b 00             	mov    (%rax),%rax
  2c16fa:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c16fe:	e9 15 01 00 00       	jmp    2c1818 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  2c1703:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c170a:	8b 00                	mov    (%rax),%eax
  2c170c:	83 f8 2f             	cmp    $0x2f,%eax
  2c170f:	77 30                	ja     2c1741 <printer_vprintf+0x647>
  2c1711:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1718:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c171c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1723:	8b 00                	mov    (%rax),%eax
  2c1725:	89 c0                	mov    %eax,%eax
  2c1727:	48 01 d0             	add    %rdx,%rax
  2c172a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1731:	8b 12                	mov    (%rdx),%edx
  2c1733:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1736:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c173d:	89 0a                	mov    %ecx,(%rdx)
  2c173f:	eb 1a                	jmp    2c175b <printer_vprintf+0x661>
  2c1741:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1748:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c174c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1750:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1757:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c175b:	8b 00                	mov    (%rax),%eax
  2c175d:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c1763:	e9 77 03 00 00       	jmp    2c1adf <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  2c1768:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c176c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c1770:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1777:	8b 00                	mov    (%rax),%eax
  2c1779:	83 f8 2f             	cmp    $0x2f,%eax
  2c177c:	77 30                	ja     2c17ae <printer_vprintf+0x6b4>
  2c177e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1785:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1789:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1790:	8b 00                	mov    (%rax),%eax
  2c1792:	89 c0                	mov    %eax,%eax
  2c1794:	48 01 d0             	add    %rdx,%rax
  2c1797:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c179e:	8b 12                	mov    (%rdx),%edx
  2c17a0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c17a3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c17aa:	89 0a                	mov    %ecx,(%rdx)
  2c17ac:	eb 1a                	jmp    2c17c8 <printer_vprintf+0x6ce>
  2c17ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c17b5:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c17b9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c17bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c17c4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c17c8:	8b 00                	mov    (%rax),%eax
  2c17ca:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c17cd:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c17d1:	eb 45                	jmp    2c1818 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  2c17d3:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c17d7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c17db:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c17e2:	0f b6 00             	movzbl (%rax),%eax
  2c17e5:	84 c0                	test   %al,%al
  2c17e7:	74 0c                	je     2c17f5 <printer_vprintf+0x6fb>
  2c17e9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c17f0:	0f b6 00             	movzbl (%rax),%eax
  2c17f3:	eb 05                	jmp    2c17fa <printer_vprintf+0x700>
  2c17f5:	b8 25 00 00 00       	mov    $0x25,%eax
  2c17fa:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c17fd:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c1801:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1808:	0f b6 00             	movzbl (%rax),%eax
  2c180b:	84 c0                	test   %al,%al
  2c180d:	75 08                	jne    2c1817 <printer_vprintf+0x71d>
                format--;
  2c180f:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c1816:	01 
            }
            break;
  2c1817:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c1818:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c181b:	83 e0 20             	and    $0x20,%eax
  2c181e:	85 c0                	test   %eax,%eax
  2c1820:	74 1e                	je     2c1840 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c1822:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1826:	48 83 c0 18          	add    $0x18,%rax
  2c182a:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c182d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1831:	48 89 ce             	mov    %rcx,%rsi
  2c1834:	48 89 c7             	mov    %rax,%rdi
  2c1837:	e8 32 f8 ff ff       	call   2c106e <fill_numbuf>
  2c183c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c1840:	48 8d 05 df 06 00 00 	lea    0x6df(%rip),%rax        # 2c1f26 <flag_chars+0x6>
  2c1847:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c184b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c184e:	83 e0 20             	and    $0x20,%eax
  2c1851:	85 c0                	test   %eax,%eax
  2c1853:	74 51                	je     2c18a6 <printer_vprintf+0x7ac>
  2c1855:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1858:	83 e0 40             	and    $0x40,%eax
  2c185b:	85 c0                	test   %eax,%eax
  2c185d:	74 47                	je     2c18a6 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  2c185f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1862:	25 80 00 00 00       	and    $0x80,%eax
  2c1867:	85 c0                	test   %eax,%eax
  2c1869:	74 0d                	je     2c1878 <printer_vprintf+0x77e>
                prefix = "-";
  2c186b:	48 8d 05 b5 06 00 00 	lea    0x6b5(%rip),%rax        # 2c1f27 <flag_chars+0x7>
  2c1872:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c1876:	eb 7d                	jmp    2c18f5 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c1878:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c187b:	83 e0 10             	and    $0x10,%eax
  2c187e:	85 c0                	test   %eax,%eax
  2c1880:	74 0d                	je     2c188f <printer_vprintf+0x795>
                prefix = "+";
  2c1882:	48 8d 05 a0 06 00 00 	lea    0x6a0(%rip),%rax        # 2c1f29 <flag_chars+0x9>
  2c1889:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c188d:	eb 66                	jmp    2c18f5 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c188f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1892:	83 e0 08             	and    $0x8,%eax
  2c1895:	85 c0                	test   %eax,%eax
  2c1897:	74 5c                	je     2c18f5 <printer_vprintf+0x7fb>
                prefix = " ";
  2c1899:	48 8d 05 8b 06 00 00 	lea    0x68b(%rip),%rax        # 2c1f2b <flag_chars+0xb>
  2c18a0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  2c18a4:	eb 4f                	jmp    2c18f5 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c18a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18a9:	83 e0 20             	and    $0x20,%eax
  2c18ac:	85 c0                	test   %eax,%eax
  2c18ae:	74 46                	je     2c18f6 <printer_vprintf+0x7fc>
  2c18b0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18b3:	83 e0 01             	and    $0x1,%eax
  2c18b6:	85 c0                	test   %eax,%eax
  2c18b8:	74 3c                	je     2c18f6 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  2c18ba:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c18be:	74 06                	je     2c18c6 <printer_vprintf+0x7cc>
  2c18c0:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c18c4:	75 30                	jne    2c18f6 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  2c18c6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c18cb:	75 0c                	jne    2c18d9 <printer_vprintf+0x7df>
  2c18cd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18d0:	25 00 01 00 00       	and    $0x100,%eax
  2c18d5:	85 c0                	test   %eax,%eax
  2c18d7:	74 1d                	je     2c18f6 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  2c18d9:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c18dd:	75 09                	jne    2c18e8 <printer_vprintf+0x7ee>
  2c18df:	48 8d 05 47 06 00 00 	lea    0x647(%rip),%rax        # 2c1f2d <flag_chars+0xd>
  2c18e6:	eb 07                	jmp    2c18ef <printer_vprintf+0x7f5>
  2c18e8:	48 8d 05 41 06 00 00 	lea    0x641(%rip),%rax        # 2c1f30 <flag_chars+0x10>
  2c18ef:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c18f3:	eb 01                	jmp    2c18f6 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  2c18f5:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c18f6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c18fa:	78 24                	js     2c1920 <printer_vprintf+0x826>
  2c18fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c18ff:	83 e0 20             	and    $0x20,%eax
  2c1902:	85 c0                	test   %eax,%eax
  2c1904:	75 1a                	jne    2c1920 <printer_vprintf+0x826>
            len = strnlen(data, precision);
  2c1906:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1909:	48 63 d0             	movslq %eax,%rdx
  2c190c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1910:	48 89 d6             	mov    %rdx,%rsi
  2c1913:	48 89 c7             	mov    %rax,%rdi
  2c1916:	e8 91 f5 ff ff       	call   2c0eac <strnlen>
  2c191b:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c191e:	eb 0f                	jmp    2c192f <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  2c1920:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1924:	48 89 c7             	mov    %rax,%rdi
  2c1927:	e8 4b f5 ff ff       	call   2c0e77 <strlen>
  2c192c:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c192f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1932:	83 e0 20             	and    $0x20,%eax
  2c1935:	85 c0                	test   %eax,%eax
  2c1937:	74 20                	je     2c1959 <printer_vprintf+0x85f>
  2c1939:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c193d:	78 1a                	js     2c1959 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  2c193f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1942:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c1945:	7e 08                	jle    2c194f <printer_vprintf+0x855>
  2c1947:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c194a:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c194d:	eb 05                	jmp    2c1954 <printer_vprintf+0x85a>
  2c194f:	b8 00 00 00 00       	mov    $0x0,%eax
  2c1954:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1957:	eb 5c                	jmp    2c19b5 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c1959:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c195c:	83 e0 20             	and    $0x20,%eax
  2c195f:	85 c0                	test   %eax,%eax
  2c1961:	74 4b                	je     2c19ae <printer_vprintf+0x8b4>
  2c1963:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1966:	83 e0 02             	and    $0x2,%eax
  2c1969:	85 c0                	test   %eax,%eax
  2c196b:	74 41                	je     2c19ae <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c196d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1970:	83 e0 04             	and    $0x4,%eax
  2c1973:	85 c0                	test   %eax,%eax
  2c1975:	75 37                	jne    2c19ae <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  2c1977:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c197b:	48 89 c7             	mov    %rax,%rdi
  2c197e:	e8 f4 f4 ff ff       	call   2c0e77 <strlen>
  2c1983:	89 c2                	mov    %eax,%edx
  2c1985:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c1988:	01 d0                	add    %edx,%eax
  2c198a:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c198d:	7e 1f                	jle    2c19ae <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  2c198f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c1992:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1995:	89 c3                	mov    %eax,%ebx
  2c1997:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c199b:	48 89 c7             	mov    %rax,%rdi
  2c199e:	e8 d4 f4 ff ff       	call   2c0e77 <strlen>
  2c19a3:	89 c2                	mov    %eax,%edx
  2c19a5:	89 d8                	mov    %ebx,%eax
  2c19a7:	29 d0                	sub    %edx,%eax
  2c19a9:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c19ac:	eb 07                	jmp    2c19b5 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  2c19ae:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c19b5:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c19b8:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c19bb:	01 d0                	add    %edx,%eax
  2c19bd:	48 63 d8             	movslq %eax,%rbx
  2c19c0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c19c4:	48 89 c7             	mov    %rax,%rdi
  2c19c7:	e8 ab f4 ff ff       	call   2c0e77 <strlen>
  2c19cc:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c19d0:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c19d3:	29 d0                	sub    %edx,%eax
  2c19d5:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c19d8:	eb 25                	jmp    2c19ff <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  2c19da:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c19e1:	48 8b 08             	mov    (%rax),%rcx
  2c19e4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c19ea:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c19f1:	be 20 00 00 00       	mov    $0x20,%esi
  2c19f6:	48 89 c7             	mov    %rax,%rdi
  2c19f9:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c19fb:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c19ff:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1a02:	83 e0 04             	and    $0x4,%eax
  2c1a05:	85 c0                	test   %eax,%eax
  2c1a07:	75 36                	jne    2c1a3f <printer_vprintf+0x945>
  2c1a09:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1a0d:	7f cb                	jg     2c19da <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  2c1a0f:	eb 2e                	jmp    2c1a3f <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  2c1a11:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a18:	4c 8b 00             	mov    (%rax),%r8
  2c1a1b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1a1f:	0f b6 00             	movzbl (%rax),%eax
  2c1a22:	0f b6 c8             	movzbl %al,%ecx
  2c1a25:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1a2b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a32:	89 ce                	mov    %ecx,%esi
  2c1a34:	48 89 c7             	mov    %rax,%rdi
  2c1a37:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1a3a:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c1a3f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1a43:	0f b6 00             	movzbl (%rax),%eax
  2c1a46:	84 c0                	test   %al,%al
  2c1a48:	75 c7                	jne    2c1a11 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  2c1a4a:	eb 25                	jmp    2c1a71 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  2c1a4c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a53:	48 8b 08             	mov    (%rax),%rcx
  2c1a56:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1a5c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a63:	be 30 00 00 00       	mov    $0x30,%esi
  2c1a68:	48 89 c7             	mov    %rax,%rdi
  2c1a6b:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c1a6d:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c1a71:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c1a75:	7f d5                	jg     2c1a4c <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  2c1a77:	eb 32                	jmp    2c1aab <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  2c1a79:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a80:	4c 8b 00             	mov    (%rax),%r8
  2c1a83:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c1a87:	0f b6 00             	movzbl (%rax),%eax
  2c1a8a:	0f b6 c8             	movzbl %al,%ecx
  2c1a8d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1a93:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1a9a:	89 ce                	mov    %ecx,%esi
  2c1a9c:	48 89 c7             	mov    %rax,%rdi
  2c1a9f:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c1aa2:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c1aa7:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c1aab:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c1aaf:	7f c8                	jg     2c1a79 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  2c1ab1:	eb 25                	jmp    2c1ad8 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  2c1ab3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1aba:	48 8b 08             	mov    (%rax),%rcx
  2c1abd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1ac3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1aca:	be 20 00 00 00       	mov    $0x20,%esi
  2c1acf:	48 89 c7             	mov    %rax,%rdi
  2c1ad2:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c1ad4:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1ad8:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1adc:	7f d5                	jg     2c1ab3 <printer_vprintf+0x9b9>
        }
    done: ;
  2c1ade:	90                   	nop
    for (; *format; ++format) {
  2c1adf:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1ae6:	01 
  2c1ae7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1aee:	0f b6 00             	movzbl (%rax),%eax
  2c1af1:	84 c0                	test   %al,%al
  2c1af3:	0f 85 31 f6 ff ff    	jne    2c112a <printer_vprintf+0x30>
    }
}
  2c1af9:	90                   	nop
  2c1afa:	90                   	nop
  2c1afb:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c1aff:	c9                   	leave  
  2c1b00:	c3                   	ret    

00000000002c1b01 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c1b01:	f3 0f 1e fa          	endbr64 
  2c1b05:	55                   	push   %rbp
  2c1b06:	48 89 e5             	mov    %rsp,%rbp
  2c1b09:	48 83 ec 20          	sub    $0x20,%rsp
  2c1b0d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1b11:	89 f0                	mov    %esi,%eax
  2c1b13:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1b16:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1b19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1b1d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1b21:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1b25:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1b29:	48 8d 15 70 74 df ff 	lea    -0x208b90(%rip),%rdx        # b8fa0 <console+0xfa0>
  2c1b30:	48 39 d0             	cmp    %rdx,%rax
  2c1b33:	72 0f                	jb     2c1b44 <console_putc+0x43>
        cp->cursor = console;
  2c1b35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1b39:	48 8d 15 c0 64 df ff 	lea    -0x209b40(%rip),%rdx        # b8000 <console>
  2c1b40:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  2c1b44:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c1b48:	0f 85 82 00 00 00    	jne    2c1bd0 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  2c1b4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1b52:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1b56:	48 8d 15 a3 64 df ff 	lea    -0x209b5d(%rip),%rdx        # b8000 <console>
  2c1b5d:	48 29 d0             	sub    %rdx,%rax
  2c1b60:	48 d1 f8             	sar    %rax
  2c1b63:	48 89 c1             	mov    %rax,%rcx
  2c1b66:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1b6d:	66 66 66 
  2c1b70:	48 89 c8             	mov    %rcx,%rax
  2c1b73:	48 f7 ea             	imul   %rdx
  2c1b76:	48 89 d0             	mov    %rdx,%rax
  2c1b79:	48 c1 f8 05          	sar    $0x5,%rax
  2c1b7d:	48 89 ce             	mov    %rcx,%rsi
  2c1b80:	48 c1 fe 3f          	sar    $0x3f,%rsi
  2c1b84:	48 29 f0             	sub    %rsi,%rax
  2c1b87:	48 89 c2             	mov    %rax,%rdx
  2c1b8a:	48 89 d0             	mov    %rdx,%rax
  2c1b8d:	48 c1 e0 02          	shl    $0x2,%rax
  2c1b91:	48 01 d0             	add    %rdx,%rax
  2c1b94:	48 c1 e0 04          	shl    $0x4,%rax
  2c1b98:	48 29 c1             	sub    %rax,%rcx
  2c1b9b:	48 89 ca             	mov    %rcx,%rdx
  2c1b9e:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c1ba1:	eb 25                	jmp    2c1bc8 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  2c1ba3:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1ba6:	83 c8 20             	or     $0x20,%eax
  2c1ba9:	89 c6                	mov    %eax,%esi
  2c1bab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1baf:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1bb3:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1bb7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1bbb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1bbf:	89 f2                	mov    %esi,%edx
  2c1bc1:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c1bc4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1bc8:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c1bcc:	75 d5                	jne    2c1ba3 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c1bce:	eb 24                	jmp    2c1bf4 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  2c1bd0:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1bd4:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c1bd7:	89 d6                	mov    %edx,%esi
  2c1bd9:	09 c6                	or     %eax,%esi
  2c1bdb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1bdf:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1be3:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c1be7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c1beb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1bef:	89 f2                	mov    %esi,%edx
  2c1bf1:	66 89 10             	mov    %dx,(%rax)
}
  2c1bf4:	90                   	nop
  2c1bf5:	c9                   	leave  
  2c1bf6:	c3                   	ret    

00000000002c1bf7 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c1bf7:	f3 0f 1e fa          	endbr64 
  2c1bfb:	55                   	push   %rbp
  2c1bfc:	48 89 e5             	mov    %rsp,%rbp
  2c1bff:	48 83 ec 30          	sub    $0x30,%rsp
  2c1c03:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c1c06:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1c09:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c1c0d:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1c11:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 2c1b01 <console_putc>
  2c1c18:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1c1c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c1c20:	78 09                	js     2c1c2b <console_vprintf+0x34>
  2c1c22:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1c29:	7e 07                	jle    2c1c32 <console_vprintf+0x3b>
        cpos = 0;
  2c1c2b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c1c32:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1c35:	48 98                	cltq   
  2c1c37:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c1c3b:	48 8d 05 be 63 df ff 	lea    -0x209c42(%rip),%rax        # b8000 <console>
  2c1c42:	48 01 d0             	add    %rdx,%rax
  2c1c45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1c49:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1c4d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c1c51:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c1c54:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1c58:	48 89 c7             	mov    %rax,%rdi
  2c1c5b:	e8 9a f4 ff ff       	call   2c10fa <printer_vprintf>
    return cp.cursor - console;
  2c1c60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1c64:	48 8d 15 95 63 df ff 	lea    -0x209c6b(%rip),%rdx        # b8000 <console>
  2c1c6b:	48 29 d0             	sub    %rdx,%rax
  2c1c6e:	48 d1 f8             	sar    %rax
}
  2c1c71:	c9                   	leave  
  2c1c72:	c3                   	ret    

00000000002c1c73 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c1c73:	f3 0f 1e fa          	endbr64 
  2c1c77:	55                   	push   %rbp
  2c1c78:	48 89 e5             	mov    %rsp,%rbp
  2c1c7b:	48 83 ec 60          	sub    $0x60,%rsp
  2c1c7f:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c1c82:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c1c85:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1c89:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1c8d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1c91:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1c95:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c1c9c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1ca0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1ca4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1ca8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c1cac:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c1cb0:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c1cb4:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c1cb7:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c1cba:	89 c7                	mov    %eax,%edi
  2c1cbc:	e8 36 ff ff ff       	call   2c1bf7 <console_vprintf>
  2c1cc1:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c1cc4:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c1cc7:	c9                   	leave  
  2c1cc8:	c3                   	ret    

00000000002c1cc9 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c1cc9:	f3 0f 1e fa          	endbr64 
  2c1ccd:	55                   	push   %rbp
  2c1cce:	48 89 e5             	mov    %rsp,%rbp
  2c1cd1:	48 83 ec 20          	sub    $0x20,%rsp
  2c1cd5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1cd9:	89 f0                	mov    %esi,%eax
  2c1cdb:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c1cde:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c1ce1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1ce5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c1ce9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1ced:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c1cf1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1cf5:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c1cf9:	48 39 c2             	cmp    %rax,%rdx
  2c1cfc:	73 1a                	jae    2c1d18 <string_putc+0x4f>
        *sp->s++ = c;
  2c1cfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1d02:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1d06:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c1d0a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c1d0e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1d12:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1d16:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1d18:	90                   	nop
  2c1d19:	c9                   	leave  
  2c1d1a:	c3                   	ret    

00000000002c1d1b <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1d1b:	f3 0f 1e fa          	endbr64 
  2c1d1f:	55                   	push   %rbp
  2c1d20:	48 89 e5             	mov    %rsp,%rbp
  2c1d23:	48 83 ec 40          	sub    $0x40,%rsp
  2c1d27:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1d2b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c1d2f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c1d33:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c1d37:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 2c1cc9 <string_putc>
  2c1d3e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  2c1d42:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1d46:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c1d4a:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1d4f:	74 33                	je     2c1d84 <vsnprintf+0x69>
        sp.end = s + size - 1;
  2c1d51:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c1d55:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c1d59:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1d5d:	48 01 d0             	add    %rdx,%rax
  2c1d60:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c1d64:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c1d68:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c1d6c:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c1d70:	be 00 00 00 00       	mov    $0x0,%esi
  2c1d75:	48 89 c7             	mov    %rax,%rdi
  2c1d78:	e8 7d f3 ff ff       	call   2c10fa <printer_vprintf>
        *sp.s = 0;
  2c1d7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1d81:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c1d84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1d88:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c1d8c:	c9                   	leave  
  2c1d8d:	c3                   	ret    

00000000002c1d8e <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1d8e:	f3 0f 1e fa          	endbr64 
  2c1d92:	55                   	push   %rbp
  2c1d93:	48 89 e5             	mov    %rsp,%rbp
  2c1d96:	48 83 ec 70          	sub    $0x70,%rsp
  2c1d9a:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c1d9e:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c1da2:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1da6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c1daa:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1dae:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1db2:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c1db9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c1dbd:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c1dc1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1dc5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c1dc9:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c1dcd:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c1dd1:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c1dd5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1dd9:	48 89 c7             	mov    %rax,%rdi
  2c1ddc:	e8 3a ff ff ff       	call   2c1d1b <vsnprintf>
  2c1de1:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c1de4:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c1de7:	c9                   	leave  
  2c1de8:	c3                   	ret    

00000000002c1de9 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c1de9:	f3 0f 1e fa          	endbr64 
  2c1ded:	55                   	push   %rbp
  2c1dee:	48 89 e5             	mov    %rsp,%rbp
  2c1df1:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1df5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c1dfc:	eb 1a                	jmp    2c1e18 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  2c1dfe:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c1e01:	48 98                	cltq   
  2c1e03:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  2c1e07:	48 8d 05 f2 61 df ff 	lea    -0x209e0e(%rip),%rax        # b8000 <console>
  2c1e0e:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c1e14:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c1e18:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1e1f:	7e dd                	jle    2c1dfe <console_clear+0x15>
    }
    cursorpos = 0;
  2c1e21:	c7 05 d1 71 df ff 00 	movl   $0x0,-0x208e2f(%rip)        # b8ffc <cursorpos>
  2c1e28:	00 00 00 
}
  2c1e2b:	90                   	nop
  2c1e2c:	c9                   	leave  
  2c1e2d:	c3                   	ret    
