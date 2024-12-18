
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	53                   	push   %rbx
  100009:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000d:	cd 31                	int    $0x31
  10000f:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100011:	48 8d 05 1f 30 00 00 	lea    0x301f(%rip),%rax        # 103037 <end+0xfff>
  100018:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001e:	48 89 05 e3 1f 00 00 	mov    %rax,0x1fe3(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100025:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100028:	48 83 e8 01          	sub    $0x1,%rax
  10002c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100032:	48 89 05 c7 1f 00 00 	mov    %rax,0x1fc7(%rip)        # 102000 <stack_bottom>
  100039:	eb 02                	jmp    10003d <process_main+0x3d>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  10003b:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  10003d:	e8 26 0d 00 00       	call   100d68 <rand>
  100042:	48 63 d0             	movslq %eax,%rdx
  100045:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  10004c:	48 c1 fa 25          	sar    $0x25,%rdx
  100050:	89 c1                	mov    %eax,%ecx
  100052:	c1 f9 1f             	sar    $0x1f,%ecx
  100055:	29 ca                	sub    %ecx,%edx
  100057:	6b d2 64             	imul   $0x64,%edx,%edx
  10005a:	29 d0                	sub    %edx,%eax
  10005c:	39 d8                	cmp    %ebx,%eax
  10005e:	7d db                	jge    10003b <process_main+0x3b>
	    void * ret = malloc(PAGESIZE);
  100060:	bf 00 10 00 00       	mov    $0x1000,%edi
  100065:	e8 56 06 00 00       	call   1006c0 <malloc>
	    if(ret == NULL)
  10006a:	48 85 c0             	test   %rax,%rax
  10006d:	74 04                	je     100073 <process_main+0x73>
		break;
	    *((int*)ret) = p;       // check we have write access
  10006f:	89 18                	mov    %ebx,(%rax)
  100071:	eb c8                	jmp    10003b <process_main+0x3b>
  100073:	cd 32                	int    $0x32
  100075:	eb fc                	jmp    100073 <process_main+0x73>

0000000000100077 <ptr_comparator1>:
        }
    }
    }
}
int ptr_comparator1(const void *a, const void *b);
int ptr_comparator1(const void *a, const void *b) {
  100077:	f3 0f 1e fa          	endbr64 
    ptr_with_size *a_ptr = (ptr_with_size *)a;
    ptr_with_size *b_ptr = (ptr_with_size *)b;

    // Sort by size in descending order
    return (int)b_ptr->size - (int)a_ptr->size;
  10007b:	48 8b 46 08          	mov    0x8(%rsi),%rax
  10007f:	2b 47 08             	sub    0x8(%rdi),%eax
}
  100082:	c3                   	ret    

0000000000100083 <_quicksort1>:
{
  100083:	f3 0f 1e fa          	endbr64 
  100087:	55                   	push   %rbp
  100088:	48 89 e5             	mov    %rsp,%rbp
  10008b:	41 57                	push   %r15
  10008d:	41 56                	push   %r14
  10008f:	41 55                	push   %r13
  100091:	41 54                	push   %r12
  100093:	53                   	push   %rbx
  100094:	48 81 ec 48 04 00 00 	sub    $0x448,%rsp
  10009b:	48 89 bd a0 fb ff ff 	mov    %rdi,-0x460(%rbp)
  1000a2:	48 89 b5 98 fb ff ff 	mov    %rsi,-0x468(%rbp)
  1000a9:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
    if (total_elems == 0)
  1000b0:	48 85 f6             	test   %rsi,%rsi
  1000b3:	0f 84 94 03 00 00    	je     10044d <_quicksort1+0x3ca>
  1000b9:	48 89 f0             	mov    %rsi,%rax
  1000bc:	48 89 cb             	mov    %rcx,%rbx
    const size_t max_thresh = MAX_THRESH * size;
  1000bf:	48 8d 0c 95 00 00 00 	lea    0x0(,%rdx,4),%rcx
  1000c6:	00 
  1000c7:	48 89 8d a8 fb ff ff 	mov    %rcx,-0x458(%rbp)
    if (total_elems > MAX_THRESH)
  1000ce:	48 83 fe 04          	cmp    $0x4,%rsi
  1000d2:	0f 86 bd 02 00 00    	jbe    100395 <_quicksort1+0x312>
    char *hi = &lo[size * (total_elems - 1)];
  1000d8:	48 83 e8 01          	sub    $0x1,%rax
  1000dc:	48 0f af c2          	imul   %rdx,%rax
  1000e0:	48 01 f8             	add    %rdi,%rax
  1000e3:	48 89 85 c0 fb ff ff 	mov    %rax,-0x440(%rbp)
    PUSH (NULL, NULL);
  1000ea:	48 c7 85 d0 fb ff ff 	movq   $0x0,-0x430(%rbp)
  1000f1:	00 00 00 00 
  1000f5:	48 c7 85 d8 fb ff ff 	movq   $0x0,-0x428(%rbp)
  1000fc:	00 00 00 00 
    char *lo = base_ptr;
  100100:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
    PUSH (NULL, NULL);
  100107:	48 8d 85 e0 fb ff ff 	lea    -0x420(%rbp),%rax
  10010e:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
      right_ptr = hi - size;
  100115:	48 f7 da             	neg    %rdx
  100118:	49 89 d7             	mov    %rdx,%r15
  10011b:	e9 8c 01 00 00       	jmp    1002ac <_quicksort1+0x229>
  100120:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100127:	49 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%rdi
        if ((*cmp) ((void *) mid, (void *) lo) < 0)
  10012c:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
        SWAP (mid, lo, size);
  100133:	4c 89 e8             	mov    %r13,%rax
  100136:	0f b6 08             	movzbl (%rax),%ecx
  100139:	48 83 c0 01          	add    $0x1,%rax
  10013d:	0f b6 32             	movzbl (%rdx),%esi
  100140:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  100144:	48 83 c2 01          	add    $0x1,%rdx
  100148:	88 4a ff             	mov    %cl,-0x1(%rdx)
  10014b:	48 39 c7             	cmp    %rax,%rdi
  10014e:	75 e6                	jne    100136 <_quicksort1+0xb3>
  100150:	e9 92 01 00 00       	jmp    1002e7 <_quicksort1+0x264>
  100155:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  10015c:	4d 8d 64 05 00       	lea    0x0(%r13,%rax,1),%r12
        if ((*cmp) ((void *) hi, (void *) mid) < 0)
  100161:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
        SWAP (mid, hi, size);
  100168:	4c 89 e8             	mov    %r13,%rax
  10016b:	0f b6 08             	movzbl (%rax),%ecx
  10016e:	48 83 c0 01          	add    $0x1,%rax
  100172:	0f b6 32             	movzbl (%rdx),%esi
  100175:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  100179:	48 83 c2 01          	add    $0x1,%rdx
  10017d:	88 4a ff             	mov    %cl,-0x1(%rdx)
  100180:	49 39 c4             	cmp    %rax,%r12
  100183:	75 e6                	jne    10016b <_quicksort1+0xe8>
        if ((*cmp) ((void *) mid, (void *) lo) < 0)
  100185:	48 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%rsi
  10018c:	4c 89 ef             	mov    %r13,%rdi
  10018f:	ff d3                	call   *%rbx
  100191:	85 c0                	test   %eax,%eax
  100193:	0f 89 62 01 00 00    	jns    1002fb <_quicksort1+0x278>
  100199:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
        SWAP (mid, lo, size);
  1001a0:	4c 89 e8             	mov    %r13,%rax
  1001a3:	0f b6 08             	movzbl (%rax),%ecx
  1001a6:	48 83 c0 01          	add    $0x1,%rax
  1001aa:	0f b6 32             	movzbl (%rdx),%esi
  1001ad:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  1001b1:	48 83 c2 01          	add    $0x1,%rdx
  1001b5:	88 4a ff             	mov    %cl,-0x1(%rdx)
  1001b8:	49 39 c4             	cmp    %rax,%r12
  1001bb:	75 e6                	jne    1001a3 <_quicksort1+0x120>
jump_over:;
  1001bd:	e9 39 01 00 00       	jmp    1002fb <_quicksort1+0x278>
          right_ptr -= size;
  1001c2:	4d 01 fc             	add    %r15,%r12
          while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
  1001c5:	4c 89 e6             	mov    %r12,%rsi
  1001c8:	4c 89 ef             	mov    %r13,%rdi
  1001cb:	ff d3                	call   *%rbx
  1001cd:	85 c0                	test   %eax,%eax
  1001cf:	78 f1                	js     1001c2 <_quicksort1+0x13f>
          if (left_ptr < right_ptr)
  1001d1:	4d 39 e6             	cmp    %r12,%r14
  1001d4:	72 1c                	jb     1001f2 <_quicksort1+0x16f>
          else if (left_ptr == right_ptr)
  1001d6:	74 5e                	je     100236 <_quicksort1+0x1b3>
      while (left_ptr <= right_ptr);
  1001d8:	4d 39 e6             	cmp    %r12,%r14
  1001db:	77 63                	ja     100240 <_quicksort1+0x1bd>
          while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
  1001dd:	4c 89 ee             	mov    %r13,%rsi
  1001e0:	4c 89 f7             	mov    %r14,%rdi
  1001e3:	ff d3                	call   *%rbx
  1001e5:	85 c0                	test   %eax,%eax
  1001e7:	79 dc                	jns    1001c5 <_quicksort1+0x142>
          left_ptr += size;
  1001e9:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  1001f0:	eb eb                	jmp    1001dd <_quicksort1+0x15a>
  1001f2:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  1001f9:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
          if (left_ptr < right_ptr)
  1001fd:	4c 89 e2             	mov    %r12,%rdx
  100200:	4c 89 f0             	mov    %r14,%rax
          SWAP (left_ptr, right_ptr, size);
  100203:	0f b6 08             	movzbl (%rax),%ecx
  100206:	48 83 c0 01          	add    $0x1,%rax
  10020a:	0f b6 32             	movzbl (%rdx),%esi
  10020d:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  100211:	48 83 c2 01          	add    $0x1,%rdx
  100215:	88 4a ff             	mov    %cl,-0x1(%rdx)
  100218:	48 39 f8             	cmp    %rdi,%rax
  10021b:	75 e6                	jne    100203 <_quicksort1+0x180>
          if (mid == left_ptr)
  10021d:	4d 39 ee             	cmp    %r13,%r14
  100220:	74 0f                	je     100231 <_quicksort1+0x1ae>
          else if (mid == right_ptr)
  100222:	4d 39 ec             	cmp    %r13,%r12
  100225:	4d 0f 44 ee          	cmove  %r14,%r13
          right_ptr -= size;
  100229:	4d 01 fc             	add    %r15,%r12
          left_ptr += size;
  10022c:	49 89 fe             	mov    %rdi,%r14
  10022f:	eb a7                	jmp    1001d8 <_quicksort1+0x155>
  100231:	4d 89 e5             	mov    %r12,%r13
  100234:	eb f3                	jmp    100229 <_quicksort1+0x1a6>
          left_ptr += size;
  100236:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
          right_ptr -= size;
  10023d:	4d 01 fc             	add    %r15,%r12
      if ((size_t) (right_ptr - lo) <= max_thresh)
  100240:	4c 89 e0             	mov    %r12,%rax
  100243:	48 2b 85 b8 fb ff ff 	sub    -0x448(%rbp),%rax
  10024a:	48 8b bd a8 fb ff ff 	mov    -0x458(%rbp),%rdi
  100251:	48 39 f8             	cmp    %rdi,%rax
  100254:	0f 87 bf 00 00 00    	ja     100319 <_quicksort1+0x296>
          if ((size_t) (hi - left_ptr) <= max_thresh)
  10025a:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  100261:	4c 29 f0             	sub    %r14,%rax
          lo = left_ptr;
  100264:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
          if ((size_t) (hi - left_ptr) <= max_thresh)
  10026b:	48 39 f8             	cmp    %rdi,%rax
  10026e:	77 28                	ja     100298 <_quicksort1+0x215>
          POP (lo, hi);
  100270:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  100277:	48 8b 78 f0          	mov    -0x10(%rax),%rdi
  10027b:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
  100282:	48 8b 78 f8          	mov    -0x8(%rax),%rdi
  100286:	48 89 bd c0 fb ff ff 	mov    %rdi,-0x440(%rbp)
  10028d:	48 8d 40 f0          	lea    -0x10(%rax),%rax
  100291:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
    while (STACK_NOT_EMPTY)
  100298:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  10029f:	48 39 85 b0 fb ff ff 	cmp    %rax,-0x450(%rbp)
  1002a6:	0f 86 e9 00 00 00    	jbe    100395 <_quicksort1+0x312>
        char *mid = lo + size * ((hi - lo) / size >> 1);
  1002ac:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  1002b3:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  1002ba:	48 29 f8             	sub    %rdi,%rax
  1002bd:	48 8b 8d c8 fb ff ff 	mov    -0x438(%rbp),%rcx
  1002c4:	ba 00 00 00 00       	mov    $0x0,%edx
  1002c9:	48 f7 f1             	div    %rcx
  1002cc:	48 d1 e8             	shr    %rax
  1002cf:	48 0f af c1          	imul   %rcx,%rax
  1002d3:	4c 8d 2c 07          	lea    (%rdi,%rax,1),%r13
        if ((*cmp) ((void *) mid, (void *) lo) < 0)
  1002d7:	48 89 fe             	mov    %rdi,%rsi
  1002da:	4c 89 ef             	mov    %r13,%rdi
  1002dd:	ff d3                	call   *%rbx
  1002df:	85 c0                	test   %eax,%eax
  1002e1:	0f 88 39 fe ff ff    	js     100120 <_quicksort1+0x9d>
        if ((*cmp) ((void *) hi, (void *) mid) < 0)
  1002e7:	4c 89 ee             	mov    %r13,%rsi
  1002ea:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  1002f1:	ff d3                	call   *%rbx
  1002f3:	85 c0                	test   %eax,%eax
  1002f5:	0f 88 5a fe ff ff    	js     100155 <_quicksort1+0xd2>
      left_ptr  = lo + size;
  1002fb:	4c 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%r14
  100302:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
      right_ptr = hi - size;
  100309:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  100310:	4e 8d 24 38          	lea    (%rax,%r15,1),%r12
  100314:	e9 c4 fe ff ff       	jmp    1001dd <_quicksort1+0x15a>
      else if ((size_t) (hi - left_ptr) <= max_thresh)
  100319:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
  100320:	4c 29 f2             	sub    %r14,%rdx
  100323:	48 3b 95 a8 fb ff ff 	cmp    -0x458(%rbp),%rdx
  10032a:	76 5d                	jbe    100389 <_quicksort1+0x306>
      else if ((right_ptr - lo) > (hi - left_ptr))
  10032c:	48 39 d0             	cmp    %rdx,%rax
  10032f:	7e 2c                	jle    10035d <_quicksort1+0x2da>
          PUSH (lo, right_ptr);
  100331:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  100338:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  10033f:	48 89 38             	mov    %rdi,(%rax)
  100342:	4c 89 60 08          	mov    %r12,0x8(%rax)
  100346:	48 83 c0 10          	add    $0x10,%rax
  10034a:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
          lo = left_ptr;
  100351:	4c 89 b5 b8 fb ff ff 	mov    %r14,-0x448(%rbp)
  100358:	e9 3b ff ff ff       	jmp    100298 <_quicksort1+0x215>
          PUSH (left_ptr, hi);
  10035d:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  100364:	4c 89 30             	mov    %r14,(%rax)
  100367:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  10036e:	48 89 78 08          	mov    %rdi,0x8(%rax)
  100372:	48 83 c0 10          	add    $0x10,%rax
  100376:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
          hi = right_ptr;
  10037d:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  100384:	e9 0f ff ff ff       	jmp    100298 <_quicksort1+0x215>
          hi = right_ptr;
  100389:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  100390:	e9 03 ff ff ff       	jmp    100298 <_quicksort1+0x215>
    char *const end_ptr = &base_ptr[size * (total_elems - 1)];
  100395:	4c 8b bd 98 fb ff ff 	mov    -0x468(%rbp),%r15
  10039c:	49 83 ef 01          	sub    $0x1,%r15
  1003a0:	48 8b bd c8 fb ff ff 	mov    -0x438(%rbp),%rdi
  1003a7:	4c 0f af ff          	imul   %rdi,%r15
  1003ab:	4c 8b ad a0 fb ff ff 	mov    -0x460(%rbp),%r13
  1003b2:	4d 01 ef             	add    %r13,%r15
    char *thresh = min(end_ptr, base_ptr + max_thresh);
  1003b5:	48 8b 85 a8 fb ff ff 	mov    -0x458(%rbp),%rax
  1003bc:	4c 01 e8             	add    %r13,%rax
  1003bf:	49 39 c7             	cmp    %rax,%r15
  1003c2:	49 0f 46 c7          	cmovbe %r15,%rax
    for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  1003c6:	4d 89 ec             	mov    %r13,%r12
  1003c9:	49 01 fc             	add    %rdi,%r12
  1003cc:	4c 39 e0             	cmp    %r12,%rax
  1003cf:	72 66                	jb     100437 <_quicksort1+0x3b4>
  1003d1:	4d 89 e6             	mov    %r12,%r14
    char *tmp_ptr = base_ptr;
  1003d4:	4c 89 a5 c0 fb ff ff 	mov    %r12,-0x440(%rbp)
  1003db:	49 89 c4             	mov    %rax,%r12
        if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  1003de:	4c 89 ee             	mov    %r13,%rsi
  1003e1:	4c 89 f7             	mov    %r14,%rdi
  1003e4:	ff d3                	call   *%rbx
  1003e6:	85 c0                	test   %eax,%eax
  1003e8:	4d 0f 48 ee          	cmovs  %r14,%r13
    for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  1003ec:	4c 03 b5 c8 fb ff ff 	add    -0x438(%rbp),%r14
  1003f3:	4d 39 f4             	cmp    %r14,%r12
  1003f6:	73 e6                	jae    1003de <_quicksort1+0x35b>
  1003f8:	4c 8b a5 c0 fb ff ff 	mov    -0x440(%rbp),%r12
    if (tmp_ptr != base_ptr)
  1003ff:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100406:	49 8d 4c 05 00       	lea    0x0(%r13,%rax,1),%rcx
  10040b:	48 8b 85 a0 fb ff ff 	mov    -0x460(%rbp),%rax
  100412:	4c 3b ad a0 fb ff ff 	cmp    -0x460(%rbp),%r13
  100419:	74 1c                	je     100437 <_quicksort1+0x3b4>
        SWAP (tmp_ptr, base_ptr, size);
  10041b:	41 0f b6 55 00       	movzbl 0x0(%r13),%edx
  100420:	49 83 c5 01          	add    $0x1,%r13
  100424:	0f b6 30             	movzbl (%rax),%esi
  100427:	41 88 75 ff          	mov    %sil,-0x1(%r13)
  10042b:	48 83 c0 01          	add    $0x1,%rax
  10042f:	88 50 ff             	mov    %dl,-0x1(%rax)
  100432:	49 39 cd             	cmp    %rcx,%r13
  100435:	75 e4                	jne    10041b <_quicksort1+0x398>
    while ((run_ptr += size) <= end_ptr)
  100437:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  10043e:	4d 8d 34 04          	lea    (%r12,%rax,1),%r14
        tmp_ptr = run_ptr - size;
  100442:	48 f7 d8             	neg    %rax
  100445:	49 89 c5             	mov    %rax,%r13
    while ((run_ptr += size) <= end_ptr)
  100448:	4d 39 f7             	cmp    %r14,%r15
  10044b:	73 15                	jae    100462 <_quicksort1+0x3df>
}
  10044d:	48 81 c4 48 04 00 00 	add    $0x448,%rsp
  100454:	5b                   	pop    %rbx
  100455:	41 5c                	pop    %r12
  100457:	41 5d                	pop    %r13
  100459:	41 5e                	pop    %r14
  10045b:	41 5f                	pop    %r15
  10045d:	5d                   	pop    %rbp
  10045e:	c3                   	ret    
        tmp_ptr -= size;
  10045f:	4d 01 ec             	add    %r13,%r12
        while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100462:	4c 89 e6             	mov    %r12,%rsi
  100465:	4c 89 f7             	mov    %r14,%rdi
  100468:	ff d3                	call   *%rbx
  10046a:	85 c0                	test   %eax,%eax
  10046c:	78 f1                	js     10045f <_quicksort1+0x3dc>
        tmp_ptr += size;
  10046e:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100475:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
        if (tmp_ptr != run_ptr)
  100479:	4c 39 f6             	cmp    %r14,%rsi
  10047c:	75 17                	jne    100495 <_quicksort1+0x412>
    while ((run_ptr += size) <= end_ptr)
  10047e:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100485:	4c 01 f0             	add    %r14,%rax
  100488:	4d 89 f4             	mov    %r14,%r12
  10048b:	49 39 c7             	cmp    %rax,%r15
  10048e:	72 bd                	jb     10044d <_quicksort1+0x3ca>
  100490:	49 89 c6             	mov    %rax,%r14
        while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100493:	eb cd                	jmp    100462 <_quicksort1+0x3df>
        while (--trav >= run_ptr)
  100495:	49 8d 7c 06 ff       	lea    -0x1(%r14,%rax,1),%rdi
  10049a:	4c 39 f7             	cmp    %r14,%rdi
  10049d:	72 df                	jb     10047e <_quicksort1+0x3fb>
  10049f:	4d 8d 46 ff          	lea    -0x1(%r14),%r8
  1004a3:	4d 89 c2             	mov    %r8,%r10
  1004a6:	eb 13                	jmp    1004bb <_quicksort1+0x438>
            for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  1004a8:	48 89 f9             	mov    %rdi,%rcx
            *hi = c;
  1004ab:	44 88 09             	mov    %r9b,(%rcx)
        while (--trav >= run_ptr)
  1004ae:	48 83 ef 01          	sub    $0x1,%rdi
  1004b2:	49 83 e8 01          	sub    $0x1,%r8
  1004b6:	49 39 fa             	cmp    %rdi,%r10
  1004b9:	74 c3                	je     10047e <_quicksort1+0x3fb>
            char c = *trav;
  1004bb:	44 0f b6 0f          	movzbl (%rdi),%r9d
            for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  1004bf:	4c 89 c0             	mov    %r8,%rax
  1004c2:	4c 39 c6             	cmp    %r8,%rsi
  1004c5:	77 e1                	ja     1004a8 <_quicksort1+0x425>
  1004c7:	48 89 fa             	mov    %rdi,%rdx
            *hi = *lo;
  1004ca:	0f b6 08             	movzbl (%rax),%ecx
  1004cd:	88 0a                	mov    %cl,(%rdx)
            for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  1004cf:	48 89 c1             	mov    %rax,%rcx
  1004d2:	4c 01 e8             	add    %r13,%rax
  1004d5:	48 2b 95 c8 fb ff ff 	sub    -0x438(%rbp),%rdx
  1004dc:	48 39 c6             	cmp    %rax,%rsi
  1004df:	76 e9                	jbe    1004ca <_quicksort1+0x447>
  1004e1:	eb c8                	jmp    1004ab <_quicksort1+0x428>

00000000001004e3 <algn>:
void add_to_free_list(block *b);
void remove_from_free_list(block *b);
void add_to_malloc_list(block *b);
void remove_from_malloclist(block *b);

size_t algn(size_t size){
  1004e3:	f3 0f 1e fa          	endbr64 
    return (size + 7) / 8 * 8;
  1004e7:	48 8d 47 07          	lea    0x7(%rdi),%rax
  1004eb:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
}
  1004ef:	c3                   	ret    

00000000001004f0 <new_block>:
// sbrk increment of size and return the new block
block* new_block(size_t size){
  1004f0:	f3 0f 1e fa          	endbr64 
  1004f4:	48 89 fa             	mov    %rdi,%rdx
    void *bptr = sbrk(size + BLOCKSIZE);
  1004f7:	48 8d 7f 18          	lea    0x18(%rdi),%rdi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1004fb:	cd 3a                	int    $0x3a
  1004fd:	48 89 05 14 1b 00 00 	mov    %rax,0x1b14(%rip)        # 102018 <result.0>
                  : "i" (INT_SYS_SBRK), "D" /* %rdi */ (increment)
                  : "cc", "memory");
    return result;
  100504:	48 89 c1             	mov    %rax,%rcx
    if (bptr == (void*) -1) {
  100507:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10050b:	74 16                	je     100523 <new_block+0x33>
        return NULL;
    }
    block* nblock = (block*)bptr;
    nblock->size = size;
  10050d:	48 89 10             	mov    %rdx,(%rax)
    nblock->free = 0;
  100510:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%rax)
    nblock->next = NULL;
  100517:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  10051e:	00 
    return nblock;
}
  10051f:	48 89 c8             	mov    %rcx,%rax
  100522:	c3                   	ret    
        return NULL;
  100523:	b9 00 00 00 00       	mov    $0x0,%ecx
  100528:	eb f5                	jmp    10051f <new_block+0x2f>

000000000010052a <find_block>:
// check free list to see if we have a block that can fit the size
block* find_block(size_t size) {
  10052a:	f3 0f 1e fa          	endbr64 
    block* curr = free_head;
  10052e:	48 8b 05 f3 1a 00 00 	mov    0x1af3(%rip),%rax        # 102028 <free_head>
    while (curr) {
  100535:	48 85 c0             	test   %rax,%rax
  100538:	74 0e                	je     100548 <find_block+0x1e>
        if (curr->size >= size) {
  10053a:	48 39 38             	cmp    %rdi,(%rax)
  10053d:	73 09                	jae    100548 <find_block+0x1e>
            return curr;
        }
        curr = curr->next;
  10053f:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (curr) {
  100543:	48 85 c0             	test   %rax,%rax
  100546:	75 f2                	jne    10053a <find_block+0x10>
    }
    return NULL;
}
  100548:	c3                   	ret    

0000000000100549 <add_to_free_list>:
    b->size = size;
    add_to_free_list(new);
    return new;
}

void add_to_free_list(block *b) {
  100549:	f3 0f 1e fa          	endbr64 
    // insert in order of address
    if (!free_head) {
  10054d:	48 8b 05 d4 1a 00 00 	mov    0x1ad4(%rip),%rax        # 102028 <free_head>
  100554:	48 85 c0             	test   %rax,%rax
  100557:	74 1f                	je     100578 <add_to_free_list+0x2f>
        free_head = b;
        return;
    }
    // add to head if smallest
    if (b < free_head) {
  100559:	48 39 f8             	cmp    %rdi,%rax
  10055c:	77 22                	ja     100580 <add_to_free_list+0x37>
        free_head = b;
        return;
    }
    // else insert in order
    block *curr = free_head;
    while (curr->next && curr->next < b) {
  10055e:	48 89 c2             	mov    %rax,%rdx
  100561:	48 8b 40 08          	mov    0x8(%rax),%rax
  100565:	48 39 f8             	cmp    %rdi,%rax
  100568:	73 05                	jae    10056f <add_to_free_list+0x26>
  10056a:	48 85 c0             	test   %rax,%rax
  10056d:	75 ef                	jne    10055e <add_to_free_list+0x15>
        curr = curr->next;
    }
    b->next = curr->next;
  10056f:	48 89 47 08          	mov    %rax,0x8(%rdi)
    curr->next = b;
  100573:	48 89 7a 08          	mov    %rdi,0x8(%rdx)
}
  100577:	c3                   	ret    
        free_head = b;
  100578:	48 89 3d a9 1a 00 00 	mov    %rdi,0x1aa9(%rip)        # 102028 <free_head>
        return;
  10057f:	c3                   	ret    
        b->next = free_head;
  100580:	48 89 47 08          	mov    %rax,0x8(%rdi)
        free_head = b;
  100584:	48 89 3d 9d 1a 00 00 	mov    %rdi,0x1a9d(%rip)        # 102028 <free_head>
        return;
  10058b:	c3                   	ret    

000000000010058c <split_block>:
block* split_block(block* b, size_t size){
  10058c:	f3 0f 1e fa          	endbr64 
  100590:	55                   	push   %rbp
  100591:	48 89 e5             	mov    %rsp,%rbp
  100594:	53                   	push   %rbx
  100595:	48 83 ec 08          	sub    $0x8,%rsp
    if (b->size < size + BLOCKSIZE + BLOCKSIZE) {
  100599:	48 8b 07             	mov    (%rdi),%rax
  10059c:	48 8d 56 30          	lea    0x30(%rsi),%rdx
        return NULL;
  1005a0:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (b->size < size + BLOCKSIZE + BLOCKSIZE) {
  1005a5:	48 39 d0             	cmp    %rdx,%rax
  1005a8:	72 29                	jb     1005d3 <split_block+0x47>
    void* nptr = (void*)b + BLOCKSIZE + size;
  1005aa:	48 8d 5c 37 18       	lea    0x18(%rdi,%rsi,1),%rbx
    new->size = b->size - size - BLOCKSIZE;
  1005af:	48 29 f0             	sub    %rsi,%rax
  1005b2:	48 8d 40 e8          	lea    -0x18(%rax),%rax
  1005b6:	48 89 03             	mov    %rax,(%rbx)
    new->free = 1;
  1005b9:	c7 43 10 01 00 00 00 	movl   $0x1,0x10(%rbx)
    new->next = NULL;
  1005c0:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  1005c7:	00 
    b->size = size;
  1005c8:	48 89 37             	mov    %rsi,(%rdi)
    add_to_free_list(new);
  1005cb:	48 89 df             	mov    %rbx,%rdi
  1005ce:	e8 76 ff ff ff       	call   100549 <add_to_free_list>
}
  1005d3:	48 89 d8             	mov    %rbx,%rax
  1005d6:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1005da:	c9                   	leave  
  1005db:	c3                   	ret    

00000000001005dc <remove_from_free_list>:

void remove_from_free_list(block *b) {
  1005dc:	f3 0f 1e fa          	endbr64 
    // if is head
    if (free_head == b) {
  1005e0:	48 8b 05 41 1a 00 00 	mov    0x1a41(%rip),%rax        # 102028 <free_head>
  1005e7:	48 39 f8             	cmp    %rdi,%rax
  1005ea:	75 10                	jne    1005fc <remove_from_free_list+0x20>
        free_head = b->next;
  1005ec:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1005f0:	48 89 05 31 1a 00 00 	mov    %rax,0x1a31(%rip)        # 102028 <free_head>
  1005f7:	eb 19                	jmp    100612 <remove_from_free_list+0x36>
    } else {
        // itterate and merge
        block *curr = free_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  1005f9:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  1005fc:	48 85 c0             	test   %rax,%rax
  1005ff:	74 11                	je     100612 <remove_from_free_list+0x36>
  100601:	48 8b 50 08          	mov    0x8(%rax),%rdx
  100605:	48 39 fa             	cmp    %rdi,%rdx
  100608:	75 ef                	jne    1005f9 <remove_from_free_list+0x1d>
        }
        if (curr) {
            curr->next = b->next;
  10060a:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10060e:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 0;
  100612:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = NULL;
  100619:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  100620:	00 
}
  100621:	c3                   	ret    

0000000000100622 <add_to_malloc_list>:
void add_to_malloc_list(block *b) {
  100622:	f3 0f 1e fa          	endbr64 
    // add to head
    b->free = 0; 
  100626:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = malloc_head;
  10062d:	48 8b 05 ec 19 00 00 	mov    0x19ec(%rip),%rax        # 102020 <malloc_head>
  100634:	48 89 47 08          	mov    %rax,0x8(%rdi)
    malloc_head = b; 
  100638:	48 89 3d e1 19 00 00 	mov    %rdi,0x19e1(%rip)        # 102020 <malloc_head>
}
  10063f:	c3                   	ret    

0000000000100640 <remove_from_malloc_list>:

void remove_from_malloc_list(block *b) {
  100640:	f3 0f 1e fa          	endbr64 
    if (malloc_head == b) {
  100644:	48 8b 05 d5 19 00 00 	mov    0x19d5(%rip),%rax        # 102020 <malloc_head>
  10064b:	48 39 f8             	cmp    %rdi,%rax
  10064e:	75 10                	jne    100660 <remove_from_malloc_list+0x20>
        malloc_head = b->next; 
  100650:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100654:	48 89 05 c5 19 00 00 	mov    %rax,0x19c5(%rip)        # 102020 <malloc_head>
  10065b:	eb 19                	jmp    100676 <remove_from_malloc_list+0x36>
    } else {
        block *curr = malloc_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  10065d:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  100660:	48 85 c0             	test   %rax,%rax
  100663:	74 11                	je     100676 <remove_from_malloc_list+0x36>
  100665:	48 8b 50 08          	mov    0x8(%rax),%rdx
  100669:	48 39 fa             	cmp    %rdi,%rdx
  10066c:	75 ef                	jne    10065d <remove_from_malloc_list+0x1d>
        }
        if (curr) {
            curr->next = b->next; 
  10066e:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100672:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 1; 
  100676:	c7 47 10 01 00 00 00 	movl   $0x1,0x10(%rdi)
    b->next = NULL; 
  10067d:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  100684:	00 
}
  100685:	c3                   	ret    

0000000000100686 <free>:

void free(void *firstbyte) {
  100686:	f3 0f 1e fa          	endbr64 
    if (firstbyte == NULL) {
  10068a:	48 85 ff             	test   %rdi,%rdi
  10068d:	74 06                	je     100695 <free+0xf>
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; 
  10068f:	83 7f f8 00          	cmpl   $0x0,-0x8(%rdi)
  100693:	74 01                	je     100696 <free+0x10>
  100695:	c3                   	ret    
void free(void *firstbyte) {
  100696:	55                   	push   %rbp
  100697:	48 89 e5             	mov    %rsp,%rbp
  10069a:	53                   	push   %rbx
  10069b:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
  10069f:	48 8d 5f e8          	lea    -0x18(%rdi),%rbx
    num_allocs--;
  1006a3:	83 2d 66 19 00 00 01 	subl   $0x1,0x1966(%rip)        # 102010 <num_allocs>
    // switch lists
    remove_from_malloc_list(b); 
  1006aa:	48 89 df             	mov    %rbx,%rdi
  1006ad:	e8 8e ff ff ff       	call   100640 <remove_from_malloc_list>
    add_to_free_list(b);
  1006b2:	48 89 df             	mov    %rbx,%rdi
  1006b5:	e8 8f fe ff ff       	call   100549 <add_to_free_list>
}
  1006ba:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1006be:	c9                   	leave  
  1006bf:	c3                   	ret    

00000000001006c0 <malloc>:

void *malloc(uint64_t numbytes) {
  1006c0:	f3 0f 1e fa          	endbr64 
  1006c4:	55                   	push   %rbp
  1006c5:	48 89 e5             	mov    %rsp,%rbp
  1006c8:	41 54                	push   %r12
  1006ca:	53                   	push   %rbx
    if (numbytes == 0) {
        return NULL;
  1006cb:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (numbytes == 0) {
  1006d0:	48 85 ff             	test   %rdi,%rdi
  1006d3:	74 3d                	je     100712 <malloc+0x52>
    return (size + 7) / 8 * 8;
  1006d5:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  1006d9:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    }
    size_t size = algn(numbytes);
    // check if we have a block that can fit
    block *b = find_block(size);
  1006dd:	4c 89 e7             	mov    %r12,%rdi
  1006e0:	e8 45 fe ff ff       	call   10052a <find_block>
  1006e5:	48 89 c3             	mov    %rax,%rbx
    if (b == NULL) {
  1006e8:	48 85 c0             	test   %rax,%rax
  1006eb:	74 2d                	je     10071a <malloc+0x5a>
        b = new_block(size);
        if (b == NULL) {
            return NULL;
        }
    }
        remove_from_free_list(b);
  1006ed:	48 89 df             	mov    %rbx,%rdi
  1006f0:	e8 e7 fe ff ff       	call   1005dc <remove_from_free_list>
        if (b->size > size + BLOCKSIZE) {
  1006f5:	49 8d 44 24 18       	lea    0x18(%r12),%rax
  1006fa:	48 39 03             	cmp    %rax,(%rbx)
  1006fd:	77 2d                	ja     10072c <malloc+0x6c>
            split_block(b, size);
        }
    add_to_malloc_list(b);
  1006ff:	48 89 df             	mov    %rbx,%rdi
  100702:	e8 1b ff ff ff       	call   100622 <add_to_malloc_list>
    num_allocs++;
  100707:	83 05 02 19 00 00 01 	addl   $0x1,0x1902(%rip)        # 102010 <num_allocs>
    return (void*)((void*)b + BLOCKSIZE);
  10070e:	48 83 c3 18          	add    $0x18,%rbx
}
  100712:	48 89 d8             	mov    %rbx,%rax
  100715:	5b                   	pop    %rbx
  100716:	41 5c                	pop    %r12
  100718:	5d                   	pop    %rbp
  100719:	c3                   	ret    
        b = new_block(size);
  10071a:	4c 89 e7             	mov    %r12,%rdi
  10071d:	e8 ce fd ff ff       	call   1004f0 <new_block>
  100722:	48 89 c3             	mov    %rax,%rbx
        if (b == NULL) {
  100725:	48 85 c0             	test   %rax,%rax
  100728:	75 c3                	jne    1006ed <malloc+0x2d>
  10072a:	eb e6                	jmp    100712 <malloc+0x52>
            split_block(b, size);
  10072c:	4c 89 e6             	mov    %r12,%rsi
  10072f:	48 89 df             	mov    %rbx,%rdi
  100732:	e8 55 fe ff ff       	call   10058c <split_block>
  100737:	eb c6                	jmp    1006ff <malloc+0x3f>

0000000000100739 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  100739:	f3 0f 1e fa          	endbr64 
  10073d:	55                   	push   %rbp
  10073e:	48 89 e5             	mov    %rsp,%rbp
  100741:	41 54                	push   %r12
  100743:	53                   	push   %rbx
    uint64_t total = num * sz;
  100744:	48 0f af fe          	imul   %rsi,%rdi
  100748:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  10074b:	e8 70 ff ff ff       	call   1006c0 <malloc>
  100750:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  100753:	48 85 c0             	test   %rax,%rax
  100756:	74 10                	je     100768 <calloc+0x2f>
        memset(ptr, 0, total);
  100758:	4c 89 e2             	mov    %r12,%rdx
  10075b:	be 00 00 00 00       	mov    $0x0,%esi
  100760:	48 89 c7             	mov    %rax,%rdi
  100763:	e8 2b 04 00 00       	call   100b93 <memset>
    }
    return ptr;
}
  100768:	48 89 d8             	mov    %rbx,%rax
  10076b:	5b                   	pop    %rbx
  10076c:	41 5c                	pop    %r12
  10076e:	5d                   	pop    %rbp
  10076f:	c3                   	ret    

0000000000100770 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  100770:	f3 0f 1e fa          	endbr64 
  100774:	55                   	push   %rbp
  100775:	48 89 e5             	mov    %rsp,%rbp
  100778:	41 54                	push   %r12
  10077a:	53                   	push   %rbx
  10077b:	48 89 fb             	mov    %rdi,%rbx
  10077e:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  100781:	48 85 db             	test   %rbx,%rbx
  100784:	74 2d                	je     1007b3 <realloc+0x43>
        return malloc(sz);
    }
    if (sz == 0 && ptr != NULL) {
  100786:	48 85 f6             	test   %rsi,%rsi
  100789:	74 32                	je     1007bd <realloc+0x4d>
    return (size + 7) / 8 * 8;
  10078b:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  10078f:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi
    }
    // make sure to align the size
    block *b = (block*)((void*)ptr - BLOCKSIZE);
    size_t aligned_size = algn(sz);
    // check if can fit in current block
    if (b->size >= aligned_size) {
  100793:	48 8b 43 e8          	mov    -0x18(%rbx),%rax
  100797:	48 39 f0             	cmp    %rsi,%rax
  10079a:	72 31                	jb     1007cd <realloc+0x5d>
        if (b->size > aligned_size + BLOCKSIZE) {
  10079c:	48 8d 56 18          	lea    0x18(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr;
  1007a0:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  1007a3:	48 39 d0             	cmp    %rdx,%rax
  1007a6:	76 49                	jbe    1007f1 <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE);
  1007a8:	48 8d 7b e8          	lea    -0x18(%rbx),%rdi
            split_block(b, aligned_size);
  1007ac:	e8 db fd ff ff       	call   10058c <split_block>
  1007b1:	eb 3e                	jmp    1007f1 <realloc+0x81>
        return malloc(sz);
  1007b3:	e8 08 ff ff ff       	call   1006c0 <malloc>
  1007b8:	49 89 c4             	mov    %rax,%r12
  1007bb:	eb 34                	jmp    1007f1 <realloc+0x81>
        free(ptr);
  1007bd:	48 89 df             	mov    %rbx,%rdi
  1007c0:	e8 c1 fe ff ff       	call   100686 <free>
        return NULL;
  1007c5:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  1007cb:	eb 24                	jmp    1007f1 <realloc+0x81>
    }

    void *new_ptr = malloc(sz);
  1007cd:	e8 ee fe ff ff       	call   1006c0 <malloc>
  1007d2:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  1007d5:	48 85 c0             	test   %rax,%rax
  1007d8:	74 17                	je     1007f1 <realloc+0x81>
        return NULL;
    }
    memcpy(new_ptr, ptr, b->size);
  1007da:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  1007de:	48 89 de             	mov    %rbx,%rsi
  1007e1:	48 89 c7             	mov    %rax,%rdi
  1007e4:	e8 a4 02 00 00       	call   100a8d <memcpy>
    free(ptr);
  1007e9:	48 89 df             	mov    %rbx,%rdi
  1007ec:	e8 95 fe ff ff       	call   100686 <free>
    return new_ptr;
}
  1007f1:	4c 89 e0             	mov    %r12,%rax
  1007f4:	5b                   	pop    %rbx
  1007f5:	41 5c                	pop    %r12
  1007f7:	5d                   	pop    %rbp
  1007f8:	c3                   	ret    

00000000001007f9 <defrag>:

void defrag() {
  1007f9:	f3 0f 1e fa          	endbr64 
  1007fd:	55                   	push   %rbp
  1007fe:	48 89 e5             	mov    %rsp,%rbp
  100801:	53                   	push   %rbx
  100802:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = free_head;
  100806:	48 8b 1d 1b 18 00 00 	mov    0x181b(%rip),%rbx        # 102028 <free_head>
    // merge free blocks that are next to each other
    while (b && b->next) { 
  10080d:	48 85 db             	test   %rbx,%rbx
  100810:	74 33                	je     100845 <defrag+0x4c>
  100812:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
  100816:	48 85 ff             	test   %rdi,%rdi
  100819:	74 2a                	je     100845 <defrag+0x4c>
        block *next = b->next;
        if ((char *)b + b->size + BLOCKSIZE == (char *)next) {
  10081b:	48 8b 03             	mov    (%rbx),%rax
  10081e:	48 83 c0 18          	add    $0x18,%rax
  100822:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100826:	48 39 d7             	cmp    %rdx,%rdi
  100829:	74 05                	je     100830 <defrag+0x37>
    while (b && b->next) { 
  10082b:	48 89 fb             	mov    %rdi,%rbx
  10082e:	eb dd                	jmp    10080d <defrag+0x14>
            b->size += next->size + BLOCKSIZE;
  100830:	48 03 07             	add    (%rdi),%rax
  100833:	48 89 03             	mov    %rax,(%rbx)
            b->next = next->next; 
  100836:	48 8b 47 08          	mov    0x8(%rdi),%rax
  10083a:	48 89 43 08          	mov    %rax,0x8(%rbx)
            // remove 2nd one
            remove_from_free_list(next);
  10083e:	e8 99 fd ff ff       	call   1005dc <remove_from_free_list>
  100843:	eb c8                	jmp    10080d <defrag+0x14>
        } else {
            b = b->next;
        }
    }
}
  100845:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100849:	c9                   	leave  
  10084a:	c3                   	ret    

000000000010084b <sort_ptr_with_size>:

void sort_ptr_with_size(void **ptr_array, long *size_array, int allocs) {
  10084b:	f3 0f 1e fa          	endbr64 
  10084f:	55                   	push   %rbp
  100850:	48 89 e5             	mov    %rsp,%rbp
  100853:	41 57                	push   %r15
  100855:	41 56                	push   %r14
  100857:	41 55                	push   %r13
  100859:	41 54                	push   %r12
  10085b:	53                   	push   %rbx
  10085c:	48 83 ec 18          	sub    $0x18,%rsp
  100860:	49 89 fd             	mov    %rdi,%r13
  100863:	49 89 f6             	mov    %rsi,%r14
  100866:	41 89 d4             	mov    %edx,%r12d
    ptr_with_size *combined_array = (ptr_with_size *)malloc(allocs * sizeof(ptr_with_size));
  100869:	4c 63 fa             	movslq %edx,%r15
  10086c:	4c 89 ff             	mov    %r15,%rdi
  10086f:	48 c1 e7 04          	shl    $0x4,%rdi
  100873:	e8 48 fe ff ff       	call   1006c0 <malloc>
    if (!combined_array) return; 
  100878:	48 85 c0             	test   %rax,%rax
  10087b:	0f 84 99 00 00 00    	je     10091a <sort_ptr_with_size+0xcf>
  100881:	48 89 c3             	mov    %rax,%rbx
    // janky way to avoid getting combined array in heapinfo stats
    block *b = (block *)((char *)combined_array - BLOCKSIZE);
  100884:	48 8d 40 e8          	lea    -0x18(%rax),%rax
  100888:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    remove_from_malloc_list(b);
  10088c:	48 89 c7             	mov    %rax,%rdi
  10088f:	e8 ac fd ff ff       	call   100640 <remove_from_malloc_list>
    num_allocs--;
  100894:	83 2d 75 17 00 00 01 	subl   $0x1,0x1775(%rip)        # 102010 <num_allocs>

    for (int i = 0; i < allocs; i++) {
  10089b:	45 85 e4             	test   %r12d,%r12d
  10089e:	0f 8e 85 00 00 00    	jle    100929 <sort_ptr_with_size+0xde>
  1008a4:	45 89 e4             	mov    %r12d,%r12d
  1008a7:	49 c1 e4 03          	shl    $0x3,%r12
  1008ab:	b8 00 00 00 00       	mov    $0x0,%eax
        combined_array[i].ptr = ptr_array[i];
  1008b0:	49 8b 54 05 00       	mov    0x0(%r13,%rax,1),%rdx
  1008b5:	48 89 14 43          	mov    %rdx,(%rbx,%rax,2)
        combined_array[i].size = size_array[i];
  1008b9:	49 8b 14 06          	mov    (%r14,%rax,1),%rdx
  1008bd:	48 89 54 43 08       	mov    %rdx,0x8(%rbx,%rax,2)
    for (int i = 0; i < allocs; i++) {
  1008c2:	48 83 c0 08          	add    $0x8,%rax
  1008c6:	4c 39 e0             	cmp    %r12,%rax
  1008c9:	75 e5                	jne    1008b0 <sort_ptr_with_size+0x65>
    }
    _quicksort1(combined_array, allocs, sizeof(ptr_with_size), ptr_comparator1);
  1008cb:	48 8d 0d a5 f7 ff ff 	lea    -0x85b(%rip),%rcx        # 100077 <ptr_comparator1>
  1008d2:	ba 10 00 00 00       	mov    $0x10,%edx
  1008d7:	4c 89 fe             	mov    %r15,%rsi
  1008da:	48 89 df             	mov    %rbx,%rdi
  1008dd:	e8 a1 f7 ff ff       	call   100083 <_quicksort1>
  1008e2:	b8 00 00 00 00       	mov    $0x0,%eax

    for (int i = 0; i < allocs; i++) {
        ptr_array[i] = combined_array[i].ptr;
  1008e7:	48 8b 14 43          	mov    (%rbx,%rax,2),%rdx
  1008eb:	49 89 54 05 00       	mov    %rdx,0x0(%r13,%rax,1)
        size_array[i] = combined_array[i].size;
  1008f0:	48 8b 54 43 08       	mov    0x8(%rbx,%rax,2),%rdx
  1008f5:	49 89 14 06          	mov    %rdx,(%r14,%rax,1)
    for (int i = 0; i < allocs; i++) {
  1008f9:	48 83 c0 08          	add    $0x8,%rax
  1008fd:	4c 39 e0             	cmp    %r12,%rax
  100900:	75 e5                	jne    1008e7 <sort_ptr_with_size+0x9c>
    }
    free(combined_array);
  100902:	48 89 df             	mov    %rbx,%rdi
  100905:	e8 7c fd ff ff       	call   100686 <free>
    // manually remove from free list
    remove_from_free_list(b);
  10090a:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  10090e:	e8 c9 fc ff ff       	call   1005dc <remove_from_free_list>
    num_allocs++;
  100913:	83 05 f6 16 00 00 01 	addl   $0x1,0x16f6(%rip)        # 102010 <num_allocs>
}
  10091a:	48 83 c4 18          	add    $0x18,%rsp
  10091e:	5b                   	pop    %rbx
  10091f:	41 5c                	pop    %r12
  100921:	41 5d                	pop    %r13
  100923:	41 5e                	pop    %r14
  100925:	41 5f                	pop    %r15
  100927:	5d                   	pop    %rbp
  100928:	c3                   	ret    
    _quicksort1(combined_array, allocs, sizeof(ptr_with_size), ptr_comparator1);
  100929:	48 8d 0d 47 f7 ff ff 	lea    -0x8b9(%rip),%rcx        # 100077 <ptr_comparator1>
  100930:	ba 10 00 00 00       	mov    $0x10,%edx
  100935:	4c 89 fe             	mov    %r15,%rsi
  100938:	48 89 df             	mov    %rbx,%rdi
  10093b:	e8 43 f7 ff ff       	call   100083 <_quicksort1>
    for (int i = 0; i < allocs; i++) {
  100940:	eb c0                	jmp    100902 <sort_ptr_with_size+0xb7>

0000000000100942 <heap_info>:

int heap_info(heap_info_struct * info) {
  100942:	f3 0f 1e fa          	endbr64 
  100946:	55                   	push   %rbp
  100947:	48 89 e5             	mov    %rsp,%rbp
  10094a:	41 57                	push   %r15
  10094c:	41 56                	push   %r14
  10094e:	41 55                	push   %r13
  100950:	41 54                	push   %r12
  100952:	53                   	push   %rbx
  100953:	48 83 ec 08          	sub    $0x8,%rsp
  100957:	49 89 fd             	mov    %rdi,%r13
    // if no allocations
    if (num_allocs == 0) {
  10095a:	8b 05 b0 16 00 00    	mov    0x16b0(%rip),%eax        # 102010 <num_allocs>
  100960:	85 c0                	test   %eax,%eax
  100962:	75 2d                	jne    100991 <heap_info+0x4f>
    info->size_array = NULL;
  100964:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10096b:	00 
    info->ptr_array = NULL;
  10096c:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  100973:	00 
    info->free_space = 0;
  100974:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
    info->largest_free_chunk = 0;
  10097b:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)
    info->size_array = size_array;
    info->ptr_array = ptr_array;
    info->free_space = (int)free_space;
    info->largest_free_chunk = (int)largest_free_chunk + BLOCKSIZE;
    return 0;
  100982:	48 83 c4 08          	add    $0x8,%rsp
  100986:	5b                   	pop    %rbx
  100987:	41 5c                	pop    %r12
  100989:	41 5d                	pop    %r13
  10098b:	41 5e                	pop    %r14
  10098d:	41 5f                	pop    %r15
  10098f:	5d                   	pop    %rbp
  100990:	c3                   	ret    
    info->num_allocs = num_allocs;
  100991:	89 07                	mov    %eax,(%rdi)
    long *size_array = (long*)malloc((num_allocs) * sizeof(long));
  100993:	48 98                	cltq   
  100995:	48 8d 3c c5 00 00 00 	lea    0x0(,%rax,8),%rdi
  10099c:	00 
  10099d:	e8 1e fd ff ff       	call   1006c0 <malloc>
  1009a2:	49 89 c7             	mov    %rax,%r15
    void **ptr_array = (void**)malloc((num_allocs) * sizeof(void*));
  1009a5:	48 63 3d 64 16 00 00 	movslq 0x1664(%rip),%rdi        # 102010 <num_allocs>
  1009ac:	48 c1 e7 03          	shl    $0x3,%rdi
  1009b0:	e8 0b fd ff ff       	call   1006c0 <malloc>
  1009b5:	49 89 c6             	mov    %rax,%r14
    if (!size_array || !ptr_array) {
  1009b8:	4d 85 ff             	test   %r15,%r15
  1009bb:	0f 84 a2 00 00 00    	je     100a63 <heap_info+0x121>
  1009c1:	48 85 c0             	test   %rax,%rax
  1009c4:	0f 84 99 00 00 00    	je     100a63 <heap_info+0x121>
    block *bf = free_head;
  1009ca:	48 8b 05 57 16 00 00 	mov    0x1657(%rip),%rax        # 102028 <free_head>
    while (bf) {
  1009d1:	48 85 c0             	test   %rax,%rax
  1009d4:	0f 84 a3 00 00 00    	je     100a7d <heap_info+0x13b>
    size_t largest_free_chunk = 0;
  1009da:	bb 00 00 00 00       	mov    $0x0,%ebx
    size_t free_space = 0;
  1009df:	41 bc 00 00 00 00    	mov    $0x0,%r12d
        free_space += bf->size + BLOCKSIZE;
  1009e5:	48 8b 10             	mov    (%rax),%rdx
  1009e8:	4e 8d 64 22 18       	lea    0x18(%rdx,%r12,1),%r12
        if (bf->size > largest_free_chunk) {
  1009ed:	48 39 d3             	cmp    %rdx,%rbx
  1009f0:	48 0f 42 da          	cmovb  %rdx,%rbx
        bf = bf->next;
  1009f4:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bf) {
  1009f8:	48 85 c0             	test   %rax,%rax
  1009fb:	75 e8                	jne    1009e5 <heap_info+0xa3>
    block *bm = malloc_head->next->next;
  1009fd:	48 8b 05 1c 16 00 00 	mov    0x161c(%rip),%rax        # 102020 <malloc_head>
  100a04:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a08:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bm) {
  100a0c:	48 85 c0             	test   %rax,%rax
  100a0f:	74 21                	je     100a32 <heap_info+0xf0>
  100a11:	ba 00 00 00 00       	mov    $0x0,%edx
        size_array[x] = bm->size;
  100a16:	48 8b 08             	mov    (%rax),%rcx
  100a19:	49 89 0c 17          	mov    %rcx,(%r15,%rdx,1)
        ptr_array[x] = (void*)((void*)bm + BLOCKSIZE);
  100a1d:	48 8d 48 18          	lea    0x18(%rax),%rcx
  100a21:	49 89 0c 16          	mov    %rcx,(%r14,%rdx,1)
        bm = bm->next;
  100a25:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bm) {
  100a29:	48 83 c2 08          	add    $0x8,%rdx
  100a2d:	48 85 c0             	test   %rax,%rax
  100a30:	75 e4                	jne    100a16 <heap_info+0xd4>
    sort_ptr_with_size(ptr_array, size_array, num_allocs-2);
  100a32:	8b 05 d8 15 00 00    	mov    0x15d8(%rip),%eax        # 102010 <num_allocs>
  100a38:	8d 50 fe             	lea    -0x2(%rax),%edx
  100a3b:	4c 89 fe             	mov    %r15,%rsi
  100a3e:	4c 89 f7             	mov    %r14,%rdi
  100a41:	e8 05 fe ff ff       	call   10084b <sort_ptr_with_size>
    info->size_array = size_array;
  100a46:	4d 89 7d 08          	mov    %r15,0x8(%r13)
    info->ptr_array = ptr_array;
  100a4a:	4d 89 75 10          	mov    %r14,0x10(%r13)
    info->free_space = (int)free_space;
  100a4e:	45 89 65 18          	mov    %r12d,0x18(%r13)
    info->largest_free_chunk = (int)largest_free_chunk + BLOCKSIZE;
  100a52:	83 c3 18             	add    $0x18,%ebx
  100a55:	41 89 5d 1c          	mov    %ebx,0x1c(%r13)
    return 0;
  100a59:	b8 00 00 00 00       	mov    $0x0,%eax
  100a5e:	e9 1f ff ff ff       	jmp    100982 <heap_info+0x40>
        free(size_array);
  100a63:	4c 89 ff             	mov    %r15,%rdi
  100a66:	e8 1b fc ff ff       	call   100686 <free>
        free(ptr_array);
  100a6b:	4c 89 f7             	mov    %r14,%rdi
  100a6e:	e8 13 fc ff ff       	call   100686 <free>
        return -1;
  100a73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100a78:	e9 05 ff ff ff       	jmp    100982 <heap_info+0x40>
    size_t largest_free_chunk = 0;
  100a7d:	bb 00 00 00 00       	mov    $0x0,%ebx
    size_t free_space = 0;
  100a82:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100a88:	e9 70 ff ff ff       	jmp    1009fd <heap_info+0xbb>

0000000000100a8d <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100a8d:	f3 0f 1e fa          	endbr64 
  100a91:	55                   	push   %rbp
  100a92:	48 89 e5             	mov    %rsp,%rbp
  100a95:	48 83 ec 28          	sub    $0x28,%rsp
  100a99:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100a9d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100aa1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100aa5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100aa9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100aad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100ab1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100ab5:	eb 1c                	jmp    100ad3 <memcpy+0x46>
        *d = *s;
  100ab7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100abb:	0f b6 10             	movzbl (%rax),%edx
  100abe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ac2:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100ac4:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100ac9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100ace:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100ad3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100ad8:	75 dd                	jne    100ab7 <memcpy+0x2a>
    }
    return dst;
  100ada:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100ade:	c9                   	leave  
  100adf:	c3                   	ret    

0000000000100ae0 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100ae0:	f3 0f 1e fa          	endbr64 
  100ae4:	55                   	push   %rbp
  100ae5:	48 89 e5             	mov    %rsp,%rbp
  100ae8:	48 83 ec 28          	sub    $0x28,%rsp
  100aec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100af0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100af4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100af8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100afc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100b00:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100b04:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100b08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b0c:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100b10:	73 6a                	jae    100b7c <memmove+0x9c>
  100b12:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100b16:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b1a:	48 01 d0             	add    %rdx,%rax
  100b1d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100b21:	73 59                	jae    100b7c <memmove+0x9c>
        s += n, d += n;
  100b23:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b27:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100b2b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b2f:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100b33:	eb 17                	jmp    100b4c <memmove+0x6c>
            *--d = *--s;
  100b35:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100b3a:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100b3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b43:	0f b6 10             	movzbl (%rax),%edx
  100b46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b4a:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100b4c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b50:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100b54:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100b58:	48 85 c0             	test   %rax,%rax
  100b5b:	75 d8                	jne    100b35 <memmove+0x55>
    if (s < d && s + n > d) {
  100b5d:	eb 2e                	jmp    100b8d <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100b5f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100b63:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100b67:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100b6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b6f:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100b73:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100b77:	0f b6 12             	movzbl (%rdx),%edx
  100b7a:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100b7c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b80:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100b84:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100b88:	48 85 c0             	test   %rax,%rax
  100b8b:	75 d2                	jne    100b5f <memmove+0x7f>
        }
    }
    return dst;
  100b8d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100b91:	c9                   	leave  
  100b92:	c3                   	ret    

0000000000100b93 <memset>:

void* memset(void* v, int c, size_t n) {
  100b93:	f3 0f 1e fa          	endbr64 
  100b97:	55                   	push   %rbp
  100b98:	48 89 e5             	mov    %rsp,%rbp
  100b9b:	48 83 ec 28          	sub    $0x28,%rsp
  100b9f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100ba3:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100ba6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100baa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100bae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100bb2:	eb 15                	jmp    100bc9 <memset+0x36>
        *p = c;
  100bb4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100bb7:	89 c2                	mov    %eax,%edx
  100bb9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bbd:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100bbf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100bc4:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100bc9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100bce:	75 e4                	jne    100bb4 <memset+0x21>
    }
    return v;
  100bd0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100bd4:	c9                   	leave  
  100bd5:	c3                   	ret    

0000000000100bd6 <strlen>:

size_t strlen(const char* s) {
  100bd6:	f3 0f 1e fa          	endbr64 
  100bda:	55                   	push   %rbp
  100bdb:	48 89 e5             	mov    %rsp,%rbp
  100bde:	48 83 ec 18          	sub    $0x18,%rsp
  100be2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100be6:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100bed:	00 
  100bee:	eb 0a                	jmp    100bfa <strlen+0x24>
        ++n;
  100bf0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100bf5:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100bfa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100bfe:	0f b6 00             	movzbl (%rax),%eax
  100c01:	84 c0                	test   %al,%al
  100c03:	75 eb                	jne    100bf0 <strlen+0x1a>
    }
    return n;
  100c05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100c09:	c9                   	leave  
  100c0a:	c3                   	ret    

0000000000100c0b <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100c0b:	f3 0f 1e fa          	endbr64 
  100c0f:	55                   	push   %rbp
  100c10:	48 89 e5             	mov    %rsp,%rbp
  100c13:	48 83 ec 20          	sub    $0x20,%rsp
  100c17:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100c1b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100c1f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100c26:	00 
  100c27:	eb 0a                	jmp    100c33 <strnlen+0x28>
        ++n;
  100c29:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100c2e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100c33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c37:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100c3b:	74 0b                	je     100c48 <strnlen+0x3d>
  100c3d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100c41:	0f b6 00             	movzbl (%rax),%eax
  100c44:	84 c0                	test   %al,%al
  100c46:	75 e1                	jne    100c29 <strnlen+0x1e>
    }
    return n;
  100c48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100c4c:	c9                   	leave  
  100c4d:	c3                   	ret    

0000000000100c4e <strcpy>:

char* strcpy(char* dst, const char* src) {
  100c4e:	f3 0f 1e fa          	endbr64 
  100c52:	55                   	push   %rbp
  100c53:	48 89 e5             	mov    %rsp,%rbp
  100c56:	48 83 ec 20          	sub    $0x20,%rsp
  100c5a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100c5e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100c62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100c66:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100c6a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100c6e:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100c72:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100c76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c7a:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100c7e:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100c82:	0f b6 12             	movzbl (%rdx),%edx
  100c85:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100c87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c8b:	48 83 e8 01          	sub    $0x1,%rax
  100c8f:	0f b6 00             	movzbl (%rax),%eax
  100c92:	84 c0                	test   %al,%al
  100c94:	75 d4                	jne    100c6a <strcpy+0x1c>
    return dst;
  100c96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100c9a:	c9                   	leave  
  100c9b:	c3                   	ret    

0000000000100c9c <strcmp>:

int strcmp(const char* a, const char* b) {
  100c9c:	f3 0f 1e fa          	endbr64 
  100ca0:	55                   	push   %rbp
  100ca1:	48 89 e5             	mov    %rsp,%rbp
  100ca4:	48 83 ec 10          	sub    $0x10,%rsp
  100ca8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100cac:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100cb0:	eb 0a                	jmp    100cbc <strcmp+0x20>
        ++a, ++b;
  100cb2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100cb7:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100cbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100cc0:	0f b6 00             	movzbl (%rax),%eax
  100cc3:	84 c0                	test   %al,%al
  100cc5:	74 1d                	je     100ce4 <strcmp+0x48>
  100cc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ccb:	0f b6 00             	movzbl (%rax),%eax
  100cce:	84 c0                	test   %al,%al
  100cd0:	74 12                	je     100ce4 <strcmp+0x48>
  100cd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100cd6:	0f b6 10             	movzbl (%rax),%edx
  100cd9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100cdd:	0f b6 00             	movzbl (%rax),%eax
  100ce0:	38 c2                	cmp    %al,%dl
  100ce2:	74 ce                	je     100cb2 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100ce4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ce8:	0f b6 00             	movzbl (%rax),%eax
  100ceb:	89 c2                	mov    %eax,%edx
  100ced:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100cf1:	0f b6 00             	movzbl (%rax),%eax
  100cf4:	38 c2                	cmp    %al,%dl
  100cf6:	0f 97 c0             	seta   %al
  100cf9:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100cfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d00:	0f b6 00             	movzbl (%rax),%eax
  100d03:	89 c1                	mov    %eax,%ecx
  100d05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100d09:	0f b6 00             	movzbl (%rax),%eax
  100d0c:	38 c1                	cmp    %al,%cl
  100d0e:	0f 92 c0             	setb   %al
  100d11:	0f b6 c8             	movzbl %al,%ecx
  100d14:	89 d0                	mov    %edx,%eax
  100d16:	29 c8                	sub    %ecx,%eax
}
  100d18:	c9                   	leave  
  100d19:	c3                   	ret    

0000000000100d1a <strchr>:

char* strchr(const char* s, int c) {
  100d1a:	f3 0f 1e fa          	endbr64 
  100d1e:	55                   	push   %rbp
  100d1f:	48 89 e5             	mov    %rsp,%rbp
  100d22:	48 83 ec 10          	sub    $0x10,%rsp
  100d26:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100d2a:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100d2d:	eb 05                	jmp    100d34 <strchr+0x1a>
        ++s;
  100d2f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100d34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d38:	0f b6 00             	movzbl (%rax),%eax
  100d3b:	84 c0                	test   %al,%al
  100d3d:	74 0e                	je     100d4d <strchr+0x33>
  100d3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d43:	0f b6 00             	movzbl (%rax),%eax
  100d46:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100d49:	38 d0                	cmp    %dl,%al
  100d4b:	75 e2                	jne    100d2f <strchr+0x15>
    }
    if (*s == (char) c) {
  100d4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d51:	0f b6 00             	movzbl (%rax),%eax
  100d54:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100d57:	38 d0                	cmp    %dl,%al
  100d59:	75 06                	jne    100d61 <strchr+0x47>
        return (char*) s;
  100d5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d5f:	eb 05                	jmp    100d66 <strchr+0x4c>
    } else {
        return NULL;
  100d61:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100d66:	c9                   	leave  
  100d67:	c3                   	ret    

0000000000100d68 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100d68:	f3 0f 1e fa          	endbr64 
  100d6c:	55                   	push   %rbp
  100d6d:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100d70:	8b 05 ba 12 00 00    	mov    0x12ba(%rip),%eax        # 102030 <rand_seed_set>
  100d76:	85 c0                	test   %eax,%eax
  100d78:	75 0a                	jne    100d84 <rand+0x1c>
        srand(819234718U);
  100d7a:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100d7f:	e8 24 00 00 00       	call   100da8 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100d84:	8b 05 aa 12 00 00    	mov    0x12aa(%rip),%eax        # 102034 <rand_seed>
  100d8a:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100d90:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100d95:	89 05 99 12 00 00    	mov    %eax,0x1299(%rip)        # 102034 <rand_seed>
    return rand_seed & RAND_MAX;
  100d9b:	8b 05 93 12 00 00    	mov    0x1293(%rip),%eax        # 102034 <rand_seed>
  100da1:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100da6:	5d                   	pop    %rbp
  100da7:	c3                   	ret    

0000000000100da8 <srand>:

void srand(unsigned seed) {
  100da8:	f3 0f 1e fa          	endbr64 
  100dac:	55                   	push   %rbp
  100dad:	48 89 e5             	mov    %rsp,%rbp
  100db0:	48 83 ec 08          	sub    $0x8,%rsp
  100db4:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100db7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100dba:	89 05 74 12 00 00    	mov    %eax,0x1274(%rip)        # 102034 <rand_seed>
    rand_seed_set = 1;
  100dc0:	c7 05 66 12 00 00 01 	movl   $0x1,0x1266(%rip)        # 102030 <rand_seed_set>
  100dc7:	00 00 00 
}
  100dca:	90                   	nop
  100dcb:	c9                   	leave  
  100dcc:	c3                   	ret    

0000000000100dcd <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100dcd:	f3 0f 1e fa          	endbr64 
  100dd1:	55                   	push   %rbp
  100dd2:	48 89 e5             	mov    %rsp,%rbp
  100dd5:	48 83 ec 28          	sub    $0x28,%rsp
  100dd9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100ddd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100de1:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100de4:	48 8d 05 a5 0e 00 00 	lea    0xea5(%rip),%rax        # 101c90 <upper_digits.1>
  100deb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  100def:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100df3:	79 0e                	jns    100e03 <fill_numbuf+0x36>
        digits = lower_digits;
  100df5:	48 8d 05 b4 0e 00 00 	lea    0xeb4(%rip),%rax        # 101cb0 <lower_digits.0>
  100dfc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  100e00:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100e03:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100e08:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100e0c:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100e0f:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100e12:	48 63 c8             	movslq %eax,%rcx
  100e15:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100e19:	ba 00 00 00 00       	mov    $0x0,%edx
  100e1e:	48 f7 f1             	div    %rcx
  100e21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100e25:	48 01 d0             	add    %rdx,%rax
  100e28:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100e2d:	0f b6 10             	movzbl (%rax),%edx
  100e30:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100e34:	88 10                	mov    %dl,(%rax)
        val /= base;
  100e36:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100e39:	48 63 f0             	movslq %eax,%rsi
  100e3c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100e40:	ba 00 00 00 00       	mov    $0x0,%edx
  100e45:	48 f7 f6             	div    %rsi
  100e48:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100e4c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100e51:	75 bc                	jne    100e0f <fill_numbuf+0x42>
    return numbuf_end;
  100e53:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100e57:	c9                   	leave  
  100e58:	c3                   	ret    

0000000000100e59 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100e59:	f3 0f 1e fa          	endbr64 
  100e5d:	55                   	push   %rbp
  100e5e:	48 89 e5             	mov    %rsp,%rbp
  100e61:	53                   	push   %rbx
  100e62:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100e69:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100e70:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100e76:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100e7d:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100e84:	e9 bd 09 00 00       	jmp    101846 <printer_vprintf+0x9ed>
        if (*format != '%') {
  100e89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e90:	0f b6 00             	movzbl (%rax),%eax
  100e93:	3c 25                	cmp    $0x25,%al
  100e95:	74 31                	je     100ec8 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  100e97:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e9e:	4c 8b 00             	mov    (%rax),%r8
  100ea1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ea8:	0f b6 00             	movzbl (%rax),%eax
  100eab:	0f b6 c8             	movzbl %al,%ecx
  100eae:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100eb4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100ebb:	89 ce                	mov    %ecx,%esi
  100ebd:	48 89 c7             	mov    %rax,%rdi
  100ec0:	41 ff d0             	call   *%r8
            continue;
  100ec3:	e9 76 09 00 00       	jmp    10183e <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  100ec8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100ecf:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ed6:	01 
  100ed7:	eb 4d                	jmp    100f26 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  100ed9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ee0:	0f b6 00             	movzbl (%rax),%eax
  100ee3:	0f be c0             	movsbl %al,%eax
  100ee6:	89 c6                	mov    %eax,%esi
  100ee8:	48 8d 05 a1 0c 00 00 	lea    0xca1(%rip),%rax        # 101b90 <flag_chars>
  100eef:	48 89 c7             	mov    %rax,%rdi
  100ef2:	e8 23 fe ff ff       	call   100d1a <strchr>
  100ef7:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100efb:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100f00:	74 34                	je     100f36 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  100f02:	48 8d 15 87 0c 00 00 	lea    0xc87(%rip),%rdx        # 101b90 <flag_chars>
  100f09:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100f0d:	48 29 d0             	sub    %rdx,%rax
  100f10:	ba 01 00 00 00       	mov    $0x1,%edx
  100f15:	89 c1                	mov    %eax,%ecx
  100f17:	d3 e2                	shl    %cl,%edx
  100f19:	89 d0                	mov    %edx,%eax
  100f1b:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100f1e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f25:	01 
  100f26:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f2d:	0f b6 00             	movzbl (%rax),%eax
  100f30:	84 c0                	test   %al,%al
  100f32:	75 a5                	jne    100ed9 <printer_vprintf+0x80>
  100f34:	eb 01                	jmp    100f37 <printer_vprintf+0xde>
            } else {
                break;
  100f36:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100f37:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100f3e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f45:	0f b6 00             	movzbl (%rax),%eax
  100f48:	3c 30                	cmp    $0x30,%al
  100f4a:	7e 67                	jle    100fb3 <printer_vprintf+0x15a>
  100f4c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f53:	0f b6 00             	movzbl (%rax),%eax
  100f56:	3c 39                	cmp    $0x39,%al
  100f58:	7f 59                	jg     100fb3 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100f5a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100f61:	eb 2e                	jmp    100f91 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  100f63:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100f66:	89 d0                	mov    %edx,%eax
  100f68:	c1 e0 02             	shl    $0x2,%eax
  100f6b:	01 d0                	add    %edx,%eax
  100f6d:	01 c0                	add    %eax,%eax
  100f6f:	89 c1                	mov    %eax,%ecx
  100f71:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f78:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100f7c:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100f83:	0f b6 00             	movzbl (%rax),%eax
  100f86:	0f be c0             	movsbl %al,%eax
  100f89:	01 c8                	add    %ecx,%eax
  100f8b:	83 e8 30             	sub    $0x30,%eax
  100f8e:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100f91:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f98:	0f b6 00             	movzbl (%rax),%eax
  100f9b:	3c 2f                	cmp    $0x2f,%al
  100f9d:	0f 8e 85 00 00 00    	jle    101028 <printer_vprintf+0x1cf>
  100fa3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100faa:	0f b6 00             	movzbl (%rax),%eax
  100fad:	3c 39                	cmp    $0x39,%al
  100faf:	7e b2                	jle    100f63 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  100fb1:	eb 75                	jmp    101028 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  100fb3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100fba:	0f b6 00             	movzbl (%rax),%eax
  100fbd:	3c 2a                	cmp    $0x2a,%al
  100fbf:	75 68                	jne    101029 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  100fc1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fc8:	8b 00                	mov    (%rax),%eax
  100fca:	83 f8 2f             	cmp    $0x2f,%eax
  100fcd:	77 30                	ja     100fff <printer_vprintf+0x1a6>
  100fcf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fd6:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fda:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fe1:	8b 00                	mov    (%rax),%eax
  100fe3:	89 c0                	mov    %eax,%eax
  100fe5:	48 01 d0             	add    %rdx,%rax
  100fe8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fef:	8b 12                	mov    (%rdx),%edx
  100ff1:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ff4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ffb:	89 0a                	mov    %ecx,(%rdx)
  100ffd:	eb 1a                	jmp    101019 <printer_vprintf+0x1c0>
  100fff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101006:	48 8b 40 08          	mov    0x8(%rax),%rax
  10100a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10100e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101015:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101019:	8b 00                	mov    (%rax),%eax
  10101b:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  10101e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101025:	01 
  101026:	eb 01                	jmp    101029 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  101028:	90                   	nop
        }

        // process precision
        int precision = -1;
  101029:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  101030:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101037:	0f b6 00             	movzbl (%rax),%eax
  10103a:	3c 2e                	cmp    $0x2e,%al
  10103c:	0f 85 00 01 00 00    	jne    101142 <printer_vprintf+0x2e9>
            ++format;
  101042:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101049:	01 
            if (*format >= '0' && *format <= '9') {
  10104a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101051:	0f b6 00             	movzbl (%rax),%eax
  101054:	3c 2f                	cmp    $0x2f,%al
  101056:	7e 67                	jle    1010bf <printer_vprintf+0x266>
  101058:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10105f:	0f b6 00             	movzbl (%rax),%eax
  101062:	3c 39                	cmp    $0x39,%al
  101064:	7f 59                	jg     1010bf <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  101066:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  10106d:	eb 2e                	jmp    10109d <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  10106f:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  101072:	89 d0                	mov    %edx,%eax
  101074:	c1 e0 02             	shl    $0x2,%eax
  101077:	01 d0                	add    %edx,%eax
  101079:	01 c0                	add    %eax,%eax
  10107b:	89 c1                	mov    %eax,%ecx
  10107d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101084:	48 8d 50 01          	lea    0x1(%rax),%rdx
  101088:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10108f:	0f b6 00             	movzbl (%rax),%eax
  101092:	0f be c0             	movsbl %al,%eax
  101095:	01 c8                	add    %ecx,%eax
  101097:	83 e8 30             	sub    $0x30,%eax
  10109a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10109d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010a4:	0f b6 00             	movzbl (%rax),%eax
  1010a7:	3c 2f                	cmp    $0x2f,%al
  1010a9:	0f 8e 85 00 00 00    	jle    101134 <printer_vprintf+0x2db>
  1010af:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010b6:	0f b6 00             	movzbl (%rax),%eax
  1010b9:	3c 39                	cmp    $0x39,%al
  1010bb:	7e b2                	jle    10106f <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  1010bd:	eb 75                	jmp    101134 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  1010bf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010c6:	0f b6 00             	movzbl (%rax),%eax
  1010c9:	3c 2a                	cmp    $0x2a,%al
  1010cb:	75 68                	jne    101135 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  1010cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010d4:	8b 00                	mov    (%rax),%eax
  1010d6:	83 f8 2f             	cmp    $0x2f,%eax
  1010d9:	77 30                	ja     10110b <printer_vprintf+0x2b2>
  1010db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010e2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010ed:	8b 00                	mov    (%rax),%eax
  1010ef:	89 c0                	mov    %eax,%eax
  1010f1:	48 01 d0             	add    %rdx,%rax
  1010f4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010fb:	8b 12                	mov    (%rdx),%edx
  1010fd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101100:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101107:	89 0a                	mov    %ecx,(%rdx)
  101109:	eb 1a                	jmp    101125 <printer_vprintf+0x2cc>
  10110b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101112:	48 8b 40 08          	mov    0x8(%rax),%rax
  101116:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10111a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101121:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101125:	8b 00                	mov    (%rax),%eax
  101127:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  10112a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101131:	01 
  101132:	eb 01                	jmp    101135 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  101134:	90                   	nop
            }
            if (precision < 0) {
  101135:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101139:	79 07                	jns    101142 <printer_vprintf+0x2e9>
                precision = 0;
  10113b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  101142:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  101149:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  101150:	00 
        int length = 0;
  101151:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  101158:	48 8d 05 37 0a 00 00 	lea    0xa37(%rip),%rax        # 101b96 <flag_chars+0x6>
  10115f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  101163:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10116a:	0f b6 00             	movzbl (%rax),%eax
  10116d:	0f be c0             	movsbl %al,%eax
  101170:	83 e8 43             	sub    $0x43,%eax
  101173:	83 f8 37             	cmp    $0x37,%eax
  101176:	0f 87 b6 03 00 00    	ja     101532 <printer_vprintf+0x6d9>
  10117c:	89 c0                	mov    %eax,%eax
  10117e:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  101185:	00 
  101186:	48 8d 05 17 0a 00 00 	lea    0xa17(%rip),%rax        # 101ba4 <flag_chars+0x14>
  10118d:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  101190:	48 98                	cltq   
  101192:	48 8d 15 0b 0a 00 00 	lea    0xa0b(%rip),%rdx        # 101ba4 <flag_chars+0x14>
  101199:	48 01 d0             	add    %rdx,%rax
  10119c:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  10119f:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1011a6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1011ad:	01 
            goto again;
  1011ae:	eb b3                	jmp    101163 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1011b0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1011b4:	74 5d                	je     101213 <printer_vprintf+0x3ba>
  1011b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011bd:	8b 00                	mov    (%rax),%eax
  1011bf:	83 f8 2f             	cmp    $0x2f,%eax
  1011c2:	77 30                	ja     1011f4 <printer_vprintf+0x39b>
  1011c4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011cb:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1011cf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011d6:	8b 00                	mov    (%rax),%eax
  1011d8:	89 c0                	mov    %eax,%eax
  1011da:	48 01 d0             	add    %rdx,%rax
  1011dd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011e4:	8b 12                	mov    (%rdx),%edx
  1011e6:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1011e9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011f0:	89 0a                	mov    %ecx,(%rdx)
  1011f2:	eb 1a                	jmp    10120e <printer_vprintf+0x3b5>
  1011f4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011fb:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011ff:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101203:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10120a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10120e:	48 8b 00             	mov    (%rax),%rax
  101211:	eb 5c                	jmp    10126f <printer_vprintf+0x416>
  101213:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10121a:	8b 00                	mov    (%rax),%eax
  10121c:	83 f8 2f             	cmp    $0x2f,%eax
  10121f:	77 30                	ja     101251 <printer_vprintf+0x3f8>
  101221:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101228:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10122c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101233:	8b 00                	mov    (%rax),%eax
  101235:	89 c0                	mov    %eax,%eax
  101237:	48 01 d0             	add    %rdx,%rax
  10123a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101241:	8b 12                	mov    (%rdx),%edx
  101243:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101246:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10124d:	89 0a                	mov    %ecx,(%rdx)
  10124f:	eb 1a                	jmp    10126b <printer_vprintf+0x412>
  101251:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101258:	48 8b 40 08          	mov    0x8(%rax),%rax
  10125c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101260:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101267:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10126b:	8b 00                	mov    (%rax),%eax
  10126d:	48 98                	cltq   
  10126f:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  101273:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101277:	48 c1 f8 38          	sar    $0x38,%rax
  10127b:	25 80 00 00 00       	and    $0x80,%eax
  101280:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  101283:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  101287:	74 09                	je     101292 <printer_vprintf+0x439>
  101289:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10128d:	48 f7 d8             	neg    %rax
  101290:	eb 04                	jmp    101296 <printer_vprintf+0x43d>
  101292:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101296:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10129a:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  10129d:	83 c8 60             	or     $0x60,%eax
  1012a0:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  1012a3:	e9 cf 02 00 00       	jmp    101577 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1012a8:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1012ac:	74 5d                	je     10130b <printer_vprintf+0x4b2>
  1012ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012b5:	8b 00                	mov    (%rax),%eax
  1012b7:	83 f8 2f             	cmp    $0x2f,%eax
  1012ba:	77 30                	ja     1012ec <printer_vprintf+0x493>
  1012bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012c3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1012c7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012ce:	8b 00                	mov    (%rax),%eax
  1012d0:	89 c0                	mov    %eax,%eax
  1012d2:	48 01 d0             	add    %rdx,%rax
  1012d5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012dc:	8b 12                	mov    (%rdx),%edx
  1012de:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1012e1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012e8:	89 0a                	mov    %ecx,(%rdx)
  1012ea:	eb 1a                	jmp    101306 <printer_vprintf+0x4ad>
  1012ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012f3:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012f7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1012fb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101302:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101306:	48 8b 00             	mov    (%rax),%rax
  101309:	eb 5c                	jmp    101367 <printer_vprintf+0x50e>
  10130b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101312:	8b 00                	mov    (%rax),%eax
  101314:	83 f8 2f             	cmp    $0x2f,%eax
  101317:	77 30                	ja     101349 <printer_vprintf+0x4f0>
  101319:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101320:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101324:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10132b:	8b 00                	mov    (%rax),%eax
  10132d:	89 c0                	mov    %eax,%eax
  10132f:	48 01 d0             	add    %rdx,%rax
  101332:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101339:	8b 12                	mov    (%rdx),%edx
  10133b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10133e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101345:	89 0a                	mov    %ecx,(%rdx)
  101347:	eb 1a                	jmp    101363 <printer_vprintf+0x50a>
  101349:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101350:	48 8b 40 08          	mov    0x8(%rax),%rax
  101354:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101358:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10135f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101363:	8b 00                	mov    (%rax),%eax
  101365:	89 c0                	mov    %eax,%eax
  101367:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  10136b:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  10136f:	e9 03 02 00 00       	jmp    101577 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  101374:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  10137b:	e9 28 ff ff ff       	jmp    1012a8 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  101380:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  101387:	e9 1c ff ff ff       	jmp    1012a8 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  10138c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101393:	8b 00                	mov    (%rax),%eax
  101395:	83 f8 2f             	cmp    $0x2f,%eax
  101398:	77 30                	ja     1013ca <printer_vprintf+0x571>
  10139a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013a1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1013a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013ac:	8b 00                	mov    (%rax),%eax
  1013ae:	89 c0                	mov    %eax,%eax
  1013b0:	48 01 d0             	add    %rdx,%rax
  1013b3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013ba:	8b 12                	mov    (%rdx),%edx
  1013bc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1013bf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013c6:	89 0a                	mov    %ecx,(%rdx)
  1013c8:	eb 1a                	jmp    1013e4 <printer_vprintf+0x58b>
  1013ca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013d1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013d5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1013d9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013e0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1013e4:	48 8b 00             	mov    (%rax),%rax
  1013e7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1013eb:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1013f2:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  1013f9:	e9 79 01 00 00       	jmp    101577 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  1013fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101405:	8b 00                	mov    (%rax),%eax
  101407:	83 f8 2f             	cmp    $0x2f,%eax
  10140a:	77 30                	ja     10143c <printer_vprintf+0x5e3>
  10140c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101413:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101417:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10141e:	8b 00                	mov    (%rax),%eax
  101420:	89 c0                	mov    %eax,%eax
  101422:	48 01 d0             	add    %rdx,%rax
  101425:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10142c:	8b 12                	mov    (%rdx),%edx
  10142e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101431:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101438:	89 0a                	mov    %ecx,(%rdx)
  10143a:	eb 1a                	jmp    101456 <printer_vprintf+0x5fd>
  10143c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101443:	48 8b 40 08          	mov    0x8(%rax),%rax
  101447:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10144b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101452:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101456:	48 8b 00             	mov    (%rax),%rax
  101459:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  10145d:	e9 15 01 00 00       	jmp    101577 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  101462:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101469:	8b 00                	mov    (%rax),%eax
  10146b:	83 f8 2f             	cmp    $0x2f,%eax
  10146e:	77 30                	ja     1014a0 <printer_vprintf+0x647>
  101470:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101477:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10147b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101482:	8b 00                	mov    (%rax),%eax
  101484:	89 c0                	mov    %eax,%eax
  101486:	48 01 d0             	add    %rdx,%rax
  101489:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101490:	8b 12                	mov    (%rdx),%edx
  101492:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101495:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10149c:	89 0a                	mov    %ecx,(%rdx)
  10149e:	eb 1a                	jmp    1014ba <printer_vprintf+0x661>
  1014a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014a7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014ab:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1014af:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014b6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1014ba:	8b 00                	mov    (%rax),%eax
  1014bc:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  1014c2:	e9 77 03 00 00       	jmp    10183e <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  1014c7:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1014cb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  1014cf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014d6:	8b 00                	mov    (%rax),%eax
  1014d8:	83 f8 2f             	cmp    $0x2f,%eax
  1014db:	77 30                	ja     10150d <printer_vprintf+0x6b4>
  1014dd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014e4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1014e8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014ef:	8b 00                	mov    (%rax),%eax
  1014f1:	89 c0                	mov    %eax,%eax
  1014f3:	48 01 d0             	add    %rdx,%rax
  1014f6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014fd:	8b 12                	mov    (%rdx),%edx
  1014ff:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101502:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101509:	89 0a                	mov    %ecx,(%rdx)
  10150b:	eb 1a                	jmp    101527 <printer_vprintf+0x6ce>
  10150d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101514:	48 8b 40 08          	mov    0x8(%rax),%rax
  101518:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10151c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101523:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101527:	8b 00                	mov    (%rax),%eax
  101529:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10152c:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  101530:	eb 45                	jmp    101577 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  101532:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101536:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  10153a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101541:	0f b6 00             	movzbl (%rax),%eax
  101544:	84 c0                	test   %al,%al
  101546:	74 0c                	je     101554 <printer_vprintf+0x6fb>
  101548:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10154f:	0f b6 00             	movzbl (%rax),%eax
  101552:	eb 05                	jmp    101559 <printer_vprintf+0x700>
  101554:	b8 25 00 00 00       	mov    $0x25,%eax
  101559:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10155c:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  101560:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101567:	0f b6 00             	movzbl (%rax),%eax
  10156a:	84 c0                	test   %al,%al
  10156c:	75 08                	jne    101576 <printer_vprintf+0x71d>
                format--;
  10156e:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  101575:	01 
            }
            break;
  101576:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  101577:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10157a:	83 e0 20             	and    $0x20,%eax
  10157d:	85 c0                	test   %eax,%eax
  10157f:	74 1e                	je     10159f <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101581:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101585:	48 83 c0 18          	add    $0x18,%rax
  101589:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10158c:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101590:	48 89 ce             	mov    %rcx,%rsi
  101593:	48 89 c7             	mov    %rax,%rdi
  101596:	e8 32 f8 ff ff       	call   100dcd <fill_numbuf>
  10159b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  10159f:	48 8d 05 f0 05 00 00 	lea    0x5f0(%rip),%rax        # 101b96 <flag_chars+0x6>
  1015a6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1015aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015ad:	83 e0 20             	and    $0x20,%eax
  1015b0:	85 c0                	test   %eax,%eax
  1015b2:	74 51                	je     101605 <printer_vprintf+0x7ac>
  1015b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015b7:	83 e0 40             	and    $0x40,%eax
  1015ba:	85 c0                	test   %eax,%eax
  1015bc:	74 47                	je     101605 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  1015be:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015c1:	25 80 00 00 00       	and    $0x80,%eax
  1015c6:	85 c0                	test   %eax,%eax
  1015c8:	74 0d                	je     1015d7 <printer_vprintf+0x77e>
                prefix = "-";
  1015ca:	48 8d 05 c6 05 00 00 	lea    0x5c6(%rip),%rax        # 101b97 <flag_chars+0x7>
  1015d1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1015d5:	eb 7d                	jmp    101654 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1015d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015da:	83 e0 10             	and    $0x10,%eax
  1015dd:	85 c0                	test   %eax,%eax
  1015df:	74 0d                	je     1015ee <printer_vprintf+0x795>
                prefix = "+";
  1015e1:	48 8d 05 b1 05 00 00 	lea    0x5b1(%rip),%rax        # 101b99 <flag_chars+0x9>
  1015e8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1015ec:	eb 66                	jmp    101654 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  1015ee:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015f1:	83 e0 08             	and    $0x8,%eax
  1015f4:	85 c0                	test   %eax,%eax
  1015f6:	74 5c                	je     101654 <printer_vprintf+0x7fb>
                prefix = " ";
  1015f8:	48 8d 05 9c 05 00 00 	lea    0x59c(%rip),%rax        # 101b9b <flag_chars+0xb>
  1015ff:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  101603:	eb 4f                	jmp    101654 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  101605:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101608:	83 e0 20             	and    $0x20,%eax
  10160b:	85 c0                	test   %eax,%eax
  10160d:	74 46                	je     101655 <printer_vprintf+0x7fc>
  10160f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101612:	83 e0 01             	and    $0x1,%eax
  101615:	85 c0                	test   %eax,%eax
  101617:	74 3c                	je     101655 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  101619:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  10161d:	74 06                	je     101625 <printer_vprintf+0x7cc>
  10161f:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101623:	75 30                	jne    101655 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  101625:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10162a:	75 0c                	jne    101638 <printer_vprintf+0x7df>
  10162c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10162f:	25 00 01 00 00       	and    $0x100,%eax
  101634:	85 c0                	test   %eax,%eax
  101636:	74 1d                	je     101655 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  101638:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  10163c:	75 09                	jne    101647 <printer_vprintf+0x7ee>
  10163e:	48 8d 05 58 05 00 00 	lea    0x558(%rip),%rax        # 101b9d <flag_chars+0xd>
  101645:	eb 07                	jmp    10164e <printer_vprintf+0x7f5>
  101647:	48 8d 05 52 05 00 00 	lea    0x552(%rip),%rax        # 101ba0 <flag_chars+0x10>
  10164e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101652:	eb 01                	jmp    101655 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  101654:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  101655:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101659:	78 24                	js     10167f <printer_vprintf+0x826>
  10165b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10165e:	83 e0 20             	and    $0x20,%eax
  101661:	85 c0                	test   %eax,%eax
  101663:	75 1a                	jne    10167f <printer_vprintf+0x826>
            len = strnlen(data, precision);
  101665:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101668:	48 63 d0             	movslq %eax,%rdx
  10166b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10166f:	48 89 d6             	mov    %rdx,%rsi
  101672:	48 89 c7             	mov    %rax,%rdi
  101675:	e8 91 f5 ff ff       	call   100c0b <strnlen>
  10167a:	89 45 bc             	mov    %eax,-0x44(%rbp)
  10167d:	eb 0f                	jmp    10168e <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  10167f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101683:	48 89 c7             	mov    %rax,%rdi
  101686:	e8 4b f5 ff ff       	call   100bd6 <strlen>
  10168b:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  10168e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101691:	83 e0 20             	and    $0x20,%eax
  101694:	85 c0                	test   %eax,%eax
  101696:	74 20                	je     1016b8 <printer_vprintf+0x85f>
  101698:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10169c:	78 1a                	js     1016b8 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  10169e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1016a1:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  1016a4:	7e 08                	jle    1016ae <printer_vprintf+0x855>
  1016a6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1016a9:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1016ac:	eb 05                	jmp    1016b3 <printer_vprintf+0x85a>
  1016ae:	b8 00 00 00 00       	mov    $0x0,%eax
  1016b3:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1016b6:	eb 5c                	jmp    101714 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1016b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1016bb:	83 e0 20             	and    $0x20,%eax
  1016be:	85 c0                	test   %eax,%eax
  1016c0:	74 4b                	je     10170d <printer_vprintf+0x8b4>
  1016c2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1016c5:	83 e0 02             	and    $0x2,%eax
  1016c8:	85 c0                	test   %eax,%eax
  1016ca:	74 41                	je     10170d <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1016cc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1016cf:	83 e0 04             	and    $0x4,%eax
  1016d2:	85 c0                	test   %eax,%eax
  1016d4:	75 37                	jne    10170d <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  1016d6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1016da:	48 89 c7             	mov    %rax,%rdi
  1016dd:	e8 f4 f4 ff ff       	call   100bd6 <strlen>
  1016e2:	89 c2                	mov    %eax,%edx
  1016e4:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1016e7:	01 d0                	add    %edx,%eax
  1016e9:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  1016ec:	7e 1f                	jle    10170d <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  1016ee:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1016f1:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1016f4:	89 c3                	mov    %eax,%ebx
  1016f6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1016fa:	48 89 c7             	mov    %rax,%rdi
  1016fd:	e8 d4 f4 ff ff       	call   100bd6 <strlen>
  101702:	89 c2                	mov    %eax,%edx
  101704:	89 d8                	mov    %ebx,%eax
  101706:	29 d0                	sub    %edx,%eax
  101708:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10170b:	eb 07                	jmp    101714 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  10170d:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101714:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101717:	8b 45 b8             	mov    -0x48(%rbp),%eax
  10171a:	01 d0                	add    %edx,%eax
  10171c:	48 63 d8             	movslq %eax,%rbx
  10171f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101723:	48 89 c7             	mov    %rax,%rdi
  101726:	e8 ab f4 ff ff       	call   100bd6 <strlen>
  10172b:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  10172f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101732:	29 d0                	sub    %edx,%eax
  101734:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101737:	eb 25                	jmp    10175e <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  101739:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101740:	48 8b 08             	mov    (%rax),%rcx
  101743:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101749:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101750:	be 20 00 00 00       	mov    $0x20,%esi
  101755:	48 89 c7             	mov    %rax,%rdi
  101758:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10175a:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10175e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101761:	83 e0 04             	and    $0x4,%eax
  101764:	85 c0                	test   %eax,%eax
  101766:	75 36                	jne    10179e <printer_vprintf+0x945>
  101768:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10176c:	7f cb                	jg     101739 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  10176e:	eb 2e                	jmp    10179e <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  101770:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101777:	4c 8b 00             	mov    (%rax),%r8
  10177a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10177e:	0f b6 00             	movzbl (%rax),%eax
  101781:	0f b6 c8             	movzbl %al,%ecx
  101784:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10178a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101791:	89 ce                	mov    %ecx,%esi
  101793:	48 89 c7             	mov    %rax,%rdi
  101796:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101799:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  10179e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1017a2:	0f b6 00             	movzbl (%rax),%eax
  1017a5:	84 c0                	test   %al,%al
  1017a7:	75 c7                	jne    101770 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  1017a9:	eb 25                	jmp    1017d0 <printer_vprintf+0x977>
            p->putc(p, '0', color);
  1017ab:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1017b2:	48 8b 08             	mov    (%rax),%rcx
  1017b5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1017bb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1017c2:	be 30 00 00 00       	mov    $0x30,%esi
  1017c7:	48 89 c7             	mov    %rax,%rdi
  1017ca:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1017cc:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1017d0:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1017d4:	7f d5                	jg     1017ab <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  1017d6:	eb 32                	jmp    10180a <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  1017d8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1017df:	4c 8b 00             	mov    (%rax),%r8
  1017e2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1017e6:	0f b6 00             	movzbl (%rax),%eax
  1017e9:	0f b6 c8             	movzbl %al,%ecx
  1017ec:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1017f2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1017f9:	89 ce                	mov    %ecx,%esi
  1017fb:	48 89 c7             	mov    %rax,%rdi
  1017fe:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101801:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101806:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10180a:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10180e:	7f c8                	jg     1017d8 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  101810:	eb 25                	jmp    101837 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  101812:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101819:	48 8b 08             	mov    (%rax),%rcx
  10181c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101822:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101829:	be 20 00 00 00       	mov    $0x20,%esi
  10182e:	48 89 c7             	mov    %rax,%rdi
  101831:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101833:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101837:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10183b:	7f d5                	jg     101812 <printer_vprintf+0x9b9>
        }
    done: ;
  10183d:	90                   	nop
    for (; *format; ++format) {
  10183e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101845:	01 
  101846:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10184d:	0f b6 00             	movzbl (%rax),%eax
  101850:	84 c0                	test   %al,%al
  101852:	0f 85 31 f6 ff ff    	jne    100e89 <printer_vprintf+0x30>
    }
}
  101858:	90                   	nop
  101859:	90                   	nop
  10185a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10185e:	c9                   	leave  
  10185f:	c3                   	ret    

0000000000101860 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101860:	f3 0f 1e fa          	endbr64 
  101864:	55                   	push   %rbp
  101865:	48 89 e5             	mov    %rsp,%rbp
  101868:	48 83 ec 20          	sub    $0x20,%rsp
  10186c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101870:	89 f0                	mov    %esi,%eax
  101872:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101875:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101878:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10187c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101880:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101884:	48 8b 40 08          	mov    0x8(%rax),%rax
  101888:	48 8d 15 11 77 fb ff 	lea    -0x488ef(%rip),%rdx        # b8fa0 <console+0xfa0>
  10188f:	48 39 d0             	cmp    %rdx,%rax
  101892:	72 0f                	jb     1018a3 <console_putc+0x43>
        cp->cursor = console;
  101894:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101898:	48 8d 15 61 67 fb ff 	lea    -0x4989f(%rip),%rdx        # b8000 <console>
  10189f:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  1018a3:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1018a7:	0f 85 82 00 00 00    	jne    10192f <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  1018ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1018b1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1018b5:	48 8d 15 44 67 fb ff 	lea    -0x498bc(%rip),%rdx        # b8000 <console>
  1018bc:	48 29 d0             	sub    %rdx,%rax
  1018bf:	48 d1 f8             	sar    %rax
  1018c2:	48 89 c1             	mov    %rax,%rcx
  1018c5:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1018cc:	66 66 66 
  1018cf:	48 89 c8             	mov    %rcx,%rax
  1018d2:	48 f7 ea             	imul   %rdx
  1018d5:	48 89 d0             	mov    %rdx,%rax
  1018d8:	48 c1 f8 05          	sar    $0x5,%rax
  1018dc:	48 89 ce             	mov    %rcx,%rsi
  1018df:	48 c1 fe 3f          	sar    $0x3f,%rsi
  1018e3:	48 29 f0             	sub    %rsi,%rax
  1018e6:	48 89 c2             	mov    %rax,%rdx
  1018e9:	48 89 d0             	mov    %rdx,%rax
  1018ec:	48 c1 e0 02          	shl    $0x2,%rax
  1018f0:	48 01 d0             	add    %rdx,%rax
  1018f3:	48 c1 e0 04          	shl    $0x4,%rax
  1018f7:	48 29 c1             	sub    %rax,%rcx
  1018fa:	48 89 ca             	mov    %rcx,%rdx
  1018fd:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101900:	eb 25                	jmp    101927 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  101902:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101905:	83 c8 20             	or     $0x20,%eax
  101908:	89 c6                	mov    %eax,%esi
  10190a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10190e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101912:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101916:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10191a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10191e:	89 f2                	mov    %esi,%edx
  101920:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101923:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101927:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  10192b:	75 d5                	jne    101902 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  10192d:	eb 24                	jmp    101953 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  10192f:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101933:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101936:	89 d6                	mov    %edx,%esi
  101938:	09 c6                	or     %eax,%esi
  10193a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10193e:	48 8b 40 08          	mov    0x8(%rax),%rax
  101942:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101946:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  10194a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10194e:	89 f2                	mov    %esi,%edx
  101950:	66 89 10             	mov    %dx,(%rax)
}
  101953:	90                   	nop
  101954:	c9                   	leave  
  101955:	c3                   	ret    

0000000000101956 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101956:	f3 0f 1e fa          	endbr64 
  10195a:	55                   	push   %rbp
  10195b:	48 89 e5             	mov    %rsp,%rbp
  10195e:	48 83 ec 30          	sub    $0x30,%rsp
  101962:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101965:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101968:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10196c:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101970:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 101860 <console_putc>
  101977:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10197b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  10197f:	78 09                	js     10198a <console_vprintf+0x34>
  101981:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101988:	7e 07                	jle    101991 <console_vprintf+0x3b>
        cpos = 0;
  10198a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101991:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101994:	48 98                	cltq   
  101996:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  10199a:	48 8d 05 5f 66 fb ff 	lea    -0x499a1(%rip),%rax        # b8000 <console>
  1019a1:	48 01 d0             	add    %rdx,%rax
  1019a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1019a8:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1019ac:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1019b0:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1019b3:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1019b7:	48 89 c7             	mov    %rax,%rdi
  1019ba:	e8 9a f4 ff ff       	call   100e59 <printer_vprintf>
    return cp.cursor - console;
  1019bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1019c3:	48 8d 15 36 66 fb ff 	lea    -0x499ca(%rip),%rdx        # b8000 <console>
  1019ca:	48 29 d0             	sub    %rdx,%rax
  1019cd:	48 d1 f8             	sar    %rax
}
  1019d0:	c9                   	leave  
  1019d1:	c3                   	ret    

00000000001019d2 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1019d2:	f3 0f 1e fa          	endbr64 
  1019d6:	55                   	push   %rbp
  1019d7:	48 89 e5             	mov    %rsp,%rbp
  1019da:	48 83 ec 60          	sub    $0x60,%rsp
  1019de:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1019e1:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1019e4:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1019e8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1019ec:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1019f0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1019f4:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1019fb:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1019ff:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101a03:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101a07:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101a0b:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101a0f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101a13:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101a16:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101a19:	89 c7                	mov    %eax,%edi
  101a1b:	e8 36 ff ff ff       	call   101956 <console_vprintf>
  101a20:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101a23:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101a26:	c9                   	leave  
  101a27:	c3                   	ret    

0000000000101a28 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101a28:	f3 0f 1e fa          	endbr64 
  101a2c:	55                   	push   %rbp
  101a2d:	48 89 e5             	mov    %rsp,%rbp
  101a30:	48 83 ec 20          	sub    $0x20,%rsp
  101a34:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101a38:	89 f0                	mov    %esi,%eax
  101a3a:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101a3d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101a40:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101a44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101a48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101a4c:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101a50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101a54:	48 8b 40 10          	mov    0x10(%rax),%rax
  101a58:	48 39 c2             	cmp    %rax,%rdx
  101a5b:	73 1a                	jae    101a77 <string_putc+0x4f>
        *sp->s++ = c;
  101a5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101a61:	48 8b 40 08          	mov    0x8(%rax),%rax
  101a65:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101a69:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101a6d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101a71:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101a75:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101a77:	90                   	nop
  101a78:	c9                   	leave  
  101a79:	c3                   	ret    

0000000000101a7a <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101a7a:	f3 0f 1e fa          	endbr64 
  101a7e:	55                   	push   %rbp
  101a7f:	48 89 e5             	mov    %rsp,%rbp
  101a82:	48 83 ec 40          	sub    $0x40,%rsp
  101a86:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101a8a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101a8e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101a92:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101a96:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 101a28 <string_putc>
  101a9d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  101aa1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101aa5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101aa9:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101aae:	74 33                	je     101ae3 <vsnprintf+0x69>
        sp.end = s + size - 1;
  101ab0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101ab4:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101ab8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101abc:	48 01 d0             	add    %rdx,%rax
  101abf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101ac3:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101ac7:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101acb:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101acf:	be 00 00 00 00       	mov    $0x0,%esi
  101ad4:	48 89 c7             	mov    %rax,%rdi
  101ad7:	e8 7d f3 ff ff       	call   100e59 <printer_vprintf>
        *sp.s = 0;
  101adc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101ae0:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101ae3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101ae7:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101aeb:	c9                   	leave  
  101aec:	c3                   	ret    

0000000000101aed <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101aed:	f3 0f 1e fa          	endbr64 
  101af1:	55                   	push   %rbp
  101af2:	48 89 e5             	mov    %rsp,%rbp
  101af5:	48 83 ec 70          	sub    $0x70,%rsp
  101af9:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101afd:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101b01:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101b05:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101b09:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101b0d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101b11:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101b18:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101b1c:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101b20:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101b24:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101b28:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101b2c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101b30:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101b34:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101b38:	48 89 c7             	mov    %rax,%rdi
  101b3b:	e8 3a ff ff ff       	call   101a7a <vsnprintf>
  101b40:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101b43:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101b46:	c9                   	leave  
  101b47:	c3                   	ret    

0000000000101b48 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101b48:	f3 0f 1e fa          	endbr64 
  101b4c:	55                   	push   %rbp
  101b4d:	48 89 e5             	mov    %rsp,%rbp
  101b50:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101b54:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101b5b:	eb 1a                	jmp    101b77 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101b5d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101b60:	48 98                	cltq   
  101b62:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101b66:	48 8d 05 93 64 fb ff 	lea    -0x49b6d(%rip),%rax        # b8000 <console>
  101b6d:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101b73:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101b77:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101b7e:	7e dd                	jle    101b5d <console_clear+0x15>
    }
    cursorpos = 0;
  101b80:	c7 05 72 74 fb ff 00 	movl   $0x0,-0x48b8e(%rip)        # b8ffc <cursorpos>
  101b87:	00 00 00 
}
  101b8a:	90                   	nop
  101b8b:	c9                   	leave  
  101b8c:	c3                   	ret    
