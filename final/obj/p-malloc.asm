
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
  10003d:	e8 05 0d 00 00       	call   100d47 <rand>
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
  100065:	e8 55 06 00 00       	call   1006bf <malloc>
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
    if (b < free_head) {
  100559:	48 39 f8             	cmp    %rdi,%rax
  10055c:	77 22                	ja     100580 <add_to_free_list+0x37>
        b->next = free_head;
        free_head = b;
        return;
    }
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
    if (b->size < size + BLOCKSIZE) {
  100599:	48 8b 07             	mov    (%rdi),%rax
  10059c:	48 8d 56 18          	lea    0x18(%rsi),%rdx
        return NULL;
  1005a0:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (b->size < size + BLOCKSIZE) {
  1005a5:	48 39 d0             	cmp    %rdx,%rax
  1005a8:	72 28                	jb     1005d2 <split_block+0x46>
    void* nptr = (void*)b + BLOCKSIZE + size;
  1005aa:	48 8d 1c 17          	lea    (%rdi,%rdx,1),%rbx
    new->size = b->size - size - BLOCKSIZE;
  1005ae:	48 29 f0             	sub    %rsi,%rax
  1005b1:	48 8d 40 e8          	lea    -0x18(%rax),%rax
  1005b5:	48 89 03             	mov    %rax,(%rbx)
    new->free = 1;
  1005b8:	c7 43 10 01 00 00 00 	movl   $0x1,0x10(%rbx)
    new->next = NULL;
  1005bf:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  1005c6:	00 
    b->size = size;
  1005c7:	48 89 37             	mov    %rsi,(%rdi)
    add_to_free_list(new);
  1005ca:	48 89 df             	mov    %rbx,%rdi
  1005cd:	e8 77 ff ff ff       	call   100549 <add_to_free_list>
}
  1005d2:	48 89 d8             	mov    %rbx,%rax
  1005d5:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1005d9:	c9                   	leave  
  1005da:	c3                   	ret    

00000000001005db <remove_from_free_list>:

void remove_from_free_list(block *b) {
  1005db:	f3 0f 1e fa          	endbr64 
    if (free_head == b) {
  1005df:	48 8b 05 42 1a 00 00 	mov    0x1a42(%rip),%rax        # 102028 <free_head>
  1005e6:	48 39 f8             	cmp    %rdi,%rax
  1005e9:	75 10                	jne    1005fb <remove_from_free_list+0x20>
        free_head = b->next;
  1005eb:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1005ef:	48 89 05 32 1a 00 00 	mov    %rax,0x1a32(%rip)        # 102028 <free_head>
  1005f6:	eb 19                	jmp    100611 <remove_from_free_list+0x36>
    } else {
        block *curr = free_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  1005f8:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  1005fb:	48 85 c0             	test   %rax,%rax
  1005fe:	74 11                	je     100611 <remove_from_free_list+0x36>
  100600:	48 8b 50 08          	mov    0x8(%rax),%rdx
  100604:	48 39 fa             	cmp    %rdi,%rdx
  100607:	75 ef                	jne    1005f8 <remove_from_free_list+0x1d>
        }
        if (curr) {
            curr->next = b->next;
  100609:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10060d:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 0;
  100611:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = NULL;
  100618:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10061f:	00 
}
  100620:	c3                   	ret    

0000000000100621 <add_to_malloc_list>:
void add_to_malloc_list(block *b) {
  100621:	f3 0f 1e fa          	endbr64 
    b->free = 0; 
  100625:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%rdi)
    b->next = malloc_head;
  10062c:	48 8b 05 ed 19 00 00 	mov    0x19ed(%rip),%rax        # 102020 <malloc_head>
  100633:	48 89 47 08          	mov    %rax,0x8(%rdi)
    malloc_head = b; 
  100637:	48 89 3d e2 19 00 00 	mov    %rdi,0x19e2(%rip)        # 102020 <malloc_head>
}
  10063e:	c3                   	ret    

000000000010063f <remove_from_malloc_list>:

void remove_from_malloc_list(block *b) {
  10063f:	f3 0f 1e fa          	endbr64 
    if (malloc_head == b) {
  100643:	48 8b 05 d6 19 00 00 	mov    0x19d6(%rip),%rax        # 102020 <malloc_head>
  10064a:	48 39 f8             	cmp    %rdi,%rax
  10064d:	75 10                	jne    10065f <remove_from_malloc_list+0x20>
        malloc_head = b->next; 
  10064f:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100653:	48 89 05 c6 19 00 00 	mov    %rax,0x19c6(%rip)        # 102020 <malloc_head>
  10065a:	eb 19                	jmp    100675 <remove_from_malloc_list+0x36>
    } else {
        block *curr = malloc_head;
        while (curr && curr->next != b) {
            curr = curr->next;
  10065c:	48 89 d0             	mov    %rdx,%rax
        while (curr && curr->next != b) {
  10065f:	48 85 c0             	test   %rax,%rax
  100662:	74 11                	je     100675 <remove_from_malloc_list+0x36>
  100664:	48 8b 50 08          	mov    0x8(%rax),%rdx
  100668:	48 39 fa             	cmp    %rdi,%rdx
  10066b:	75 ef                	jne    10065c <remove_from_malloc_list+0x1d>
        }
        if (curr) {
            curr->next = b->next; 
  10066d:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100671:	48 89 50 08          	mov    %rdx,0x8(%rax)
        }
    }
    b->free = 1; 
  100675:	c7 47 10 01 00 00 00 	movl   $0x1,0x10(%rdi)
    b->next = NULL; 
  10067c:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  100683:	00 
}
  100684:	c3                   	ret    

0000000000100685 <free>:

void free(void *firstbyte) {
  100685:	f3 0f 1e fa          	endbr64 
    if (!firstbyte) {
  100689:	48 85 ff             	test   %rdi,%rdi
  10068c:	74 06                	je     100694 <free+0xf>
        return;
    }
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
    if (b->free) return; 
  10068e:	83 7f f8 00          	cmpl   $0x0,-0x8(%rdi)
  100692:	74 01                	je     100695 <free+0x10>
  100694:	c3                   	ret    
void free(void *firstbyte) {
  100695:	55                   	push   %rbp
  100696:	48 89 e5             	mov    %rsp,%rbp
  100699:	53                   	push   %rbx
  10069a:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = (block *)((char *)firstbyte - BLOCKSIZE);
  10069e:	48 8d 5f e8          	lea    -0x18(%rdi),%rbx
    num_allocs--;
  1006a2:	83 2d 67 19 00 00 01 	subl   $0x1,0x1967(%rip)        # 102010 <num_allocs>
    remove_from_malloc_list(b); 
  1006a9:	48 89 df             	mov    %rbx,%rdi
  1006ac:	e8 8e ff ff ff       	call   10063f <remove_from_malloc_list>
    add_to_free_list(b);
  1006b1:	48 89 df             	mov    %rbx,%rdi
  1006b4:	e8 90 fe ff ff       	call   100549 <add_to_free_list>
}
  1006b9:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1006bd:	c9                   	leave  
  1006be:	c3                   	ret    

00000000001006bf <malloc>:

void *malloc(uint64_t numbytes) {
  1006bf:	f3 0f 1e fa          	endbr64 
  1006c3:	55                   	push   %rbp
  1006c4:	48 89 e5             	mov    %rsp,%rbp
  1006c7:	41 54                	push   %r12
  1006c9:	53                   	push   %rbx
    return (size + 7) / 8 * 8;
  1006ca:	4c 8d 67 07          	lea    0x7(%rdi),%r12
  1006ce:	49 83 e4 f8          	and    $0xfffffffffffffff8,%r12
    size_t size = algn(numbytes);
    block *b = find_block(size);
  1006d2:	4c 89 e7             	mov    %r12,%rdi
  1006d5:	e8 50 fe ff ff       	call   10052a <find_block>
  1006da:	48 89 c3             	mov    %rax,%rbx
    if (b == NULL) {
  1006dd:	48 85 c0             	test   %rax,%rax
  1006e0:	74 2d                	je     10070f <malloc+0x50>
        b = new_block(size);
        if (b == NULL) {
            return NULL;
        }
    }
        remove_from_free_list(b);
  1006e2:	48 89 df             	mov    %rbx,%rdi
  1006e5:	e8 f1 fe ff ff       	call   1005db <remove_from_free_list>
        if (b->size > size + BLOCKSIZE) {
  1006ea:	49 8d 44 24 18       	lea    0x18(%r12),%rax
  1006ef:	48 39 03             	cmp    %rax,(%rbx)
  1006f2:	77 2d                	ja     100721 <malloc+0x62>
            split_block(b, size);
        }
    add_to_malloc_list(b);
  1006f4:	48 89 df             	mov    %rbx,%rdi
  1006f7:	e8 25 ff ff ff       	call   100621 <add_to_malloc_list>
    num_allocs++;
  1006fc:	83 05 0d 19 00 00 01 	addl   $0x1,0x190d(%rip)        # 102010 <num_allocs>
    return (void*)((void*)b + BLOCKSIZE);
  100703:	48 83 c3 18          	add    $0x18,%rbx
}
  100707:	48 89 d8             	mov    %rbx,%rax
  10070a:	5b                   	pop    %rbx
  10070b:	41 5c                	pop    %r12
  10070d:	5d                   	pop    %rbp
  10070e:	c3                   	ret    
        b = new_block(size);
  10070f:	4c 89 e7             	mov    %r12,%rdi
  100712:	e8 d9 fd ff ff       	call   1004f0 <new_block>
  100717:	48 89 c3             	mov    %rax,%rbx
        if (b == NULL) {
  10071a:	48 85 c0             	test   %rax,%rax
  10071d:	75 c3                	jne    1006e2 <malloc+0x23>
  10071f:	eb e6                	jmp    100707 <malloc+0x48>
            split_block(b, size);
  100721:	4c 89 e6             	mov    %r12,%rsi
  100724:	48 89 df             	mov    %rbx,%rdi
  100727:	e8 60 fe ff ff       	call   10058c <split_block>
  10072c:	eb c6                	jmp    1006f4 <malloc+0x35>

000000000010072e <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  10072e:	f3 0f 1e fa          	endbr64 
  100732:	55                   	push   %rbp
  100733:	48 89 e5             	mov    %rsp,%rbp
  100736:	41 54                	push   %r12
  100738:	53                   	push   %rbx
    uint64_t total = num * sz;
  100739:	48 0f af fe          	imul   %rsi,%rdi
  10073d:	49 89 fc             	mov    %rdi,%r12
    void *ptr = malloc(total);
  100740:	e8 7a ff ff ff       	call   1006bf <malloc>
  100745:	48 89 c3             	mov    %rax,%rbx
    if (ptr) {
  100748:	48 85 c0             	test   %rax,%rax
  10074b:	74 10                	je     10075d <calloc+0x2f>
        memset(ptr, 0, total);
  10074d:	4c 89 e2             	mov    %r12,%rdx
  100750:	be 00 00 00 00       	mov    $0x0,%esi
  100755:	48 89 c7             	mov    %rax,%rdi
  100758:	e8 15 04 00 00       	call   100b72 <memset>
    }
    return ptr;
}
  10075d:	48 89 d8             	mov    %rbx,%rax
  100760:	5b                   	pop    %rbx
  100761:	41 5c                	pop    %r12
  100763:	5d                   	pop    %rbp
  100764:	c3                   	ret    

0000000000100765 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  100765:	f3 0f 1e fa          	endbr64 
  100769:	55                   	push   %rbp
  10076a:	48 89 e5             	mov    %rsp,%rbp
  10076d:	41 54                	push   %r12
  10076f:	53                   	push   %rbx
  100770:	48 89 fb             	mov    %rdi,%rbx
  100773:	48 89 f7             	mov    %rsi,%rdi
    if (ptr == NULL) {
  100776:	48 85 db             	test   %rbx,%rbx
  100779:	74 2d                	je     1007a8 <realloc+0x43>
        return malloc(sz);
    }
    if (sz == 0) {
  10077b:	48 85 f6             	test   %rsi,%rsi
  10077e:	74 32                	je     1007b2 <realloc+0x4d>
    return (size + 7) / 8 * 8;
  100780:	48 8d 76 07          	lea    0x7(%rsi),%rsi
  100784:	48 83 e6 f8          	and    $0xfffffffffffffff8,%rsi
        return NULL;
    }
    block *b = (block*)((void*)ptr - BLOCKSIZE);
    size_t aligned_size = algn(sz);

    if (b->size >= aligned_size) {
  100788:	48 8b 43 e8          	mov    -0x18(%rbx),%rax
  10078c:	48 39 f0             	cmp    %rsi,%rax
  10078f:	72 31                	jb     1007c2 <realloc+0x5d>
        if (b->size > aligned_size + BLOCKSIZE) {
  100791:	48 8d 56 18          	lea    0x18(%rsi),%rdx
            split_block(b, aligned_size);
        }
        return ptr;
  100795:	49 89 dc             	mov    %rbx,%r12
        if (b->size > aligned_size + BLOCKSIZE) {
  100798:	48 39 d0             	cmp    %rdx,%rax
  10079b:	76 49                	jbe    1007e6 <realloc+0x81>
    block *b = (block*)((void*)ptr - BLOCKSIZE);
  10079d:	48 8d 7b e8          	lea    -0x18(%rbx),%rdi
            split_block(b, aligned_size);
  1007a1:	e8 e6 fd ff ff       	call   10058c <split_block>
  1007a6:	eb 3e                	jmp    1007e6 <realloc+0x81>
        return malloc(sz);
  1007a8:	e8 12 ff ff ff       	call   1006bf <malloc>
  1007ad:	49 89 c4             	mov    %rax,%r12
  1007b0:	eb 34                	jmp    1007e6 <realloc+0x81>
        free(ptr);
  1007b2:	48 89 df             	mov    %rbx,%rdi
  1007b5:	e8 cb fe ff ff       	call   100685 <free>
        return NULL;
  1007ba:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  1007c0:	eb 24                	jmp    1007e6 <realloc+0x81>
    }

    void *new_ptr = malloc(sz);
  1007c2:	e8 f8 fe ff ff       	call   1006bf <malloc>
  1007c7:	49 89 c4             	mov    %rax,%r12
    if (!new_ptr) {
  1007ca:	48 85 c0             	test   %rax,%rax
  1007cd:	74 17                	je     1007e6 <realloc+0x81>
        return NULL;
    }
    memcpy(new_ptr, ptr, b->size);
  1007cf:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  1007d3:	48 89 de             	mov    %rbx,%rsi
  1007d6:	48 89 c7             	mov    %rax,%rdi
  1007d9:	e8 8e 02 00 00       	call   100a6c <memcpy>
    free(ptr);
  1007de:	48 89 df             	mov    %rbx,%rdi
  1007e1:	e8 9f fe ff ff       	call   100685 <free>
    return new_ptr;
}
  1007e6:	4c 89 e0             	mov    %r12,%rax
  1007e9:	5b                   	pop    %rbx
  1007ea:	41 5c                	pop    %r12
  1007ec:	5d                   	pop    %rbp
  1007ed:	c3                   	ret    

00000000001007ee <defrag>:

void defrag() {
  1007ee:	f3 0f 1e fa          	endbr64 
  1007f2:	55                   	push   %rbp
  1007f3:	48 89 e5             	mov    %rsp,%rbp
  1007f6:	53                   	push   %rbx
  1007f7:	48 83 ec 08          	sub    $0x8,%rsp
    block *b = free_head;
  1007fb:	48 8b 1d 26 18 00 00 	mov    0x1826(%rip),%rbx        # 102028 <free_head>

    while (b && b->next) { 
  100802:	48 85 db             	test   %rbx,%rbx
  100805:	74 33                	je     10083a <defrag+0x4c>
  100807:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
  10080b:	48 85 ff             	test   %rdi,%rdi
  10080e:	74 2a                	je     10083a <defrag+0x4c>
        block *next = b->next;

        if ((char *)b + b->size + BLOCKSIZE == (char *)next) {
  100810:	48 8b 03             	mov    (%rbx),%rax
  100813:	48 83 c0 18          	add    $0x18,%rax
  100817:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  10081b:	48 39 d7             	cmp    %rdx,%rdi
  10081e:	74 05                	je     100825 <defrag+0x37>
    while (b && b->next) { 
  100820:	48 89 fb             	mov    %rdi,%rbx
  100823:	eb dd                	jmp    100802 <defrag+0x14>
            b->size += next->size + BLOCKSIZE;
  100825:	48 03 07             	add    (%rdi),%rax
  100828:	48 89 03             	mov    %rax,(%rbx)
            b->next = next->next; 
  10082b:	48 8b 47 08          	mov    0x8(%rdi),%rax
  10082f:	48 89 43 08          	mov    %rax,0x8(%rbx)
            remove_from_free_list(next);
  100833:	e8 a3 fd ff ff       	call   1005db <remove_from_free_list>
  100838:	eb c8                	jmp    100802 <defrag+0x14>
        } else {
            b = b->next;
        }
    }
}
  10083a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10083e:	c9                   	leave  
  10083f:	c3                   	ret    

0000000000100840 <sort_ptr_with_size>:

void sort_ptr_with_size(void **ptr_array, long *size_array, int allocs) {
  100840:	f3 0f 1e fa          	endbr64 
  100844:	55                   	push   %rbp
  100845:	48 89 e5             	mov    %rsp,%rbp
  100848:	41 57                	push   %r15
  10084a:	41 56                	push   %r14
  10084c:	41 55                	push   %r13
  10084e:	41 54                	push   %r12
  100850:	53                   	push   %rbx
  100851:	48 83 ec 18          	sub    $0x18,%rsp
  100855:	49 89 fd             	mov    %rdi,%r13
  100858:	49 89 f6             	mov    %rsi,%r14
  10085b:	41 89 d4             	mov    %edx,%r12d
    // Create an array of ptr_with_size structs
    ptr_with_size *combined_array = (ptr_with_size *)malloc(allocs * sizeof(ptr_with_size));
  10085e:	4c 63 fa             	movslq %edx,%r15
  100861:	4c 89 ff             	mov    %r15,%rdi
  100864:	48 c1 e7 04          	shl    $0x4,%rdi
  100868:	e8 52 fe ff ff       	call   1006bf <malloc>
    if (!combined_array) return; // Handle allocation failure
  10086d:	48 85 c0             	test   %rax,%rax
  100870:	0f 84 99 00 00 00    	je     10090f <sort_ptr_with_size+0xcf>
  100876:	48 89 c3             	mov    %rax,%rbx
    // manually remove
    block *b = (block *)((char *)combined_array - BLOCKSIZE);
  100879:	48 8d 40 e8          	lea    -0x18(%rax),%rax
  10087d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    remove_from_malloc_list(b);
  100881:	48 89 c7             	mov    %rax,%rdi
  100884:	e8 b6 fd ff ff       	call   10063f <remove_from_malloc_list>
    num_allocs--;
  100889:	83 2d 80 17 00 00 01 	subl   $0x1,0x1780(%rip)        # 102010 <num_allocs>

    for (int i = 0; i < allocs; i++) {
  100890:	45 85 e4             	test   %r12d,%r12d
  100893:	0f 8e 85 00 00 00    	jle    10091e <sort_ptr_with_size+0xde>
  100899:	45 89 e4             	mov    %r12d,%r12d
  10089c:	49 c1 e4 03          	shl    $0x3,%r12
  1008a0:	b8 00 00 00 00       	mov    $0x0,%eax
        combined_array[i].ptr = ptr_array[i];
  1008a5:	49 8b 54 05 00       	mov    0x0(%r13,%rax,1),%rdx
  1008aa:	48 89 14 43          	mov    %rdx,(%rbx,%rax,2)
        combined_array[i].size = size_array[i];
  1008ae:	49 8b 14 06          	mov    (%r14,%rax,1),%rdx
  1008b2:	48 89 54 43 08       	mov    %rdx,0x8(%rbx,%rax,2)
    for (int i = 0; i < allocs; i++) {
  1008b7:	48 83 c0 08          	add    $0x8,%rax
  1008bb:	4c 39 e0             	cmp    %r12,%rax
  1008be:	75 e5                	jne    1008a5 <sort_ptr_with_size+0x65>
    }
    _quicksort1(combined_array, allocs, sizeof(ptr_with_size), ptr_comparator1);
  1008c0:	48 8d 0d b0 f7 ff ff 	lea    -0x850(%rip),%rcx        # 100077 <ptr_comparator1>
  1008c7:	ba 10 00 00 00       	mov    $0x10,%edx
  1008cc:	4c 89 fe             	mov    %r15,%rsi
  1008cf:	48 89 df             	mov    %rbx,%rdi
  1008d2:	e8 ac f7 ff ff       	call   100083 <_quicksort1>
  1008d7:	b8 00 00 00 00       	mov    $0x0,%eax

    for (int i = 0; i < allocs; i++) {
        ptr_array[i] = combined_array[i].ptr;
  1008dc:	48 8b 14 43          	mov    (%rbx,%rax,2),%rdx
  1008e0:	49 89 54 05 00       	mov    %rdx,0x0(%r13,%rax,1)
        size_array[i] = combined_array[i].size;
  1008e5:	48 8b 54 43 08       	mov    0x8(%rbx,%rax,2),%rdx
  1008ea:	49 89 14 06          	mov    %rdx,(%r14,%rax,1)
    for (int i = 0; i < allocs; i++) {
  1008ee:	48 83 c0 08          	add    $0x8,%rax
  1008f2:	4c 39 e0             	cmp    %r12,%rax
  1008f5:	75 e5                	jne    1008dc <sort_ptr_with_size+0x9c>
    }
    free(combined_array);
  1008f7:	48 89 df             	mov    %rbx,%rdi
  1008fa:	e8 86 fd ff ff       	call   100685 <free>
    // manually remove from free list
    remove_from_free_list(b);
  1008ff:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  100903:	e8 d3 fc ff ff       	call   1005db <remove_from_free_list>
    num_allocs++;
  100908:	83 05 01 17 00 00 01 	addl   $0x1,0x1701(%rip)        # 102010 <num_allocs>
}
  10090f:	48 83 c4 18          	add    $0x18,%rsp
  100913:	5b                   	pop    %rbx
  100914:	41 5c                	pop    %r12
  100916:	41 5d                	pop    %r13
  100918:	41 5e                	pop    %r14
  10091a:	41 5f                	pop    %r15
  10091c:	5d                   	pop    %rbp
  10091d:	c3                   	ret    
    _quicksort1(combined_array, allocs, sizeof(ptr_with_size), ptr_comparator1);
  10091e:	48 8d 0d 52 f7 ff ff 	lea    -0x8ae(%rip),%rcx        # 100077 <ptr_comparator1>
  100925:	ba 10 00 00 00       	mov    $0x10,%edx
  10092a:	4c 89 fe             	mov    %r15,%rsi
  10092d:	48 89 df             	mov    %rbx,%rdi
  100930:	e8 4e f7 ff ff       	call   100083 <_quicksort1>
    for (int i = 0; i < allocs; i++) {
  100935:	eb c0                	jmp    1008f7 <sort_ptr_with_size+0xb7>

0000000000100937 <heap_info>:

int heap_info(heap_info_struct * info) {
  100937:	f3 0f 1e fa          	endbr64 
  10093b:	55                   	push   %rbp
  10093c:	48 89 e5             	mov    %rsp,%rbp
  10093f:	41 57                	push   %r15
  100941:	41 56                	push   %r14
  100943:	41 55                	push   %r13
  100945:	41 54                	push   %r12
  100947:	53                   	push   %rbx
  100948:	48 83 ec 08          	sub    $0x8,%rsp
  10094c:	49 89 fd             	mov    %rdi,%r13
    if (num_allocs == 0) {
  10094f:	8b 05 bb 16 00 00    	mov    0x16bb(%rip),%eax        # 102010 <num_allocs>
  100955:	85 c0                	test   %eax,%eax
  100957:	75 2d                	jne    100986 <heap_info+0x4f>
    info->size_array = NULL;
  100959:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  100960:	00 
    info->ptr_array = NULL;
  100961:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  100968:	00 
    info->free_space = 0;
  100969:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
    info->largest_free_chunk = 0;
  100970:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)
    info->size_array = size_array;
    info->ptr_array = ptr_array;
    info->free_space = (int)free_space;
    info->largest_free_chunk = (int)largest_free_chunk;
    return 0;
  100977:	48 83 c4 08          	add    $0x8,%rsp
  10097b:	5b                   	pop    %rbx
  10097c:	41 5c                	pop    %r12
  10097e:	41 5d                	pop    %r13
  100980:	41 5e                	pop    %r14
  100982:	41 5f                	pop    %r15
  100984:	5d                   	pop    %rbp
  100985:	c3                   	ret    
    info->num_allocs = num_allocs;
  100986:	89 07                	mov    %eax,(%rdi)
    long *size_array = (long*)malloc((num_allocs) * sizeof(long));
  100988:	48 98                	cltq   
  10098a:	48 8d 3c c5 00 00 00 	lea    0x0(,%rax,8),%rdi
  100991:	00 
  100992:	e8 28 fd ff ff       	call   1006bf <malloc>
  100997:	49 89 c6             	mov    %rax,%r14
    void **ptr_array = (void**)malloc((num_allocs) * sizeof(void*));
  10099a:	48 63 3d 6f 16 00 00 	movslq 0x166f(%rip),%rdi        # 102010 <num_allocs>
  1009a1:	48 c1 e7 03          	shl    $0x3,%rdi
  1009a5:	e8 15 fd ff ff       	call   1006bf <malloc>
  1009aa:	49 89 c7             	mov    %rax,%r15
    if (!size_array || !ptr_array) {
  1009ad:	4d 85 f6             	test   %r14,%r14
  1009b0:	0f 84 ac 00 00 00    	je     100a62 <heap_info+0x12b>
  1009b6:	48 85 c0             	test   %rax,%rax
  1009b9:	0f 84 a3 00 00 00    	je     100a62 <heap_info+0x12b>
    block *bf = free_head;
  1009bf:	48 8b 05 62 16 00 00 	mov    0x1662(%rip),%rax        # 102028 <free_head>
    while (bf) {
  1009c6:	48 85 c0             	test   %rax,%rax
  1009c9:	0f 84 86 00 00 00    	je     100a55 <heap_info+0x11e>
    size_t largest_free_chunk = 0;
  1009cf:	bb 00 00 00 00       	mov    $0x0,%ebx
    size_t free_space = 0;
  1009d4:	41 bc 00 00 00 00    	mov    $0x0,%r12d
        free_space += bf->size + BLOCKSIZE;
  1009da:	48 8b 10             	mov    (%rax),%rdx
  1009dd:	4e 8d 64 22 18       	lea    0x18(%rdx,%r12,1),%r12
        if (bf->size > largest_free_chunk) {
  1009e2:	48 39 d3             	cmp    %rdx,%rbx
  1009e5:	48 0f 42 da          	cmovb  %rdx,%rbx
        bf = bf->next;
  1009e9:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bf) {
  1009ed:	48 85 c0             	test   %rax,%rax
  1009f0:	75 e8                	jne    1009da <heap_info+0xa3>
    block *bm = malloc_head->next->next;
  1009f2:	48 8b 05 27 16 00 00 	mov    0x1627(%rip),%rax        # 102020 <malloc_head>
  1009f9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009fd:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bm) {
  100a01:	48 85 c0             	test   %rax,%rax
  100a04:	74 21                	je     100a27 <heap_info+0xf0>
  100a06:	ba 00 00 00 00       	mov    $0x0,%edx
        size_array[x] = bm->size;
  100a0b:	48 8b 08             	mov    (%rax),%rcx
  100a0e:	49 89 0c 16          	mov    %rcx,(%r14,%rdx,1)
        ptr_array[x] = (void*)((void*)bm + BLOCKSIZE);
  100a12:	48 8d 48 18          	lea    0x18(%rax),%rcx
  100a16:	49 89 0c 17          	mov    %rcx,(%r15,%rdx,1)
        bm = bm->next;
  100a1a:	48 8b 40 08          	mov    0x8(%rax),%rax
    while (bm) {
  100a1e:	48 83 c2 08          	add    $0x8,%rdx
  100a22:	48 85 c0             	test   %rax,%rax
  100a25:	75 e4                	jne    100a0b <heap_info+0xd4>
    sort_ptr_with_size(ptr_array, size_array, num_allocs-2);
  100a27:	8b 05 e3 15 00 00    	mov    0x15e3(%rip),%eax        # 102010 <num_allocs>
  100a2d:	8d 50 fe             	lea    -0x2(%rax),%edx
  100a30:	4c 89 f6             	mov    %r14,%rsi
  100a33:	4c 89 ff             	mov    %r15,%rdi
  100a36:	e8 05 fe ff ff       	call   100840 <sort_ptr_with_size>
    info->size_array = size_array;
  100a3b:	4d 89 75 08          	mov    %r14,0x8(%r13)
    info->ptr_array = ptr_array;
  100a3f:	4d 89 7d 10          	mov    %r15,0x10(%r13)
    info->free_space = (int)free_space;
  100a43:	45 89 65 18          	mov    %r12d,0x18(%r13)
    info->largest_free_chunk = (int)largest_free_chunk;
  100a47:	41 89 5d 1c          	mov    %ebx,0x1c(%r13)
    return 0;
  100a4b:	b8 00 00 00 00       	mov    $0x0,%eax
  100a50:	e9 22 ff ff ff       	jmp    100977 <heap_info+0x40>
    size_t largest_free_chunk = 0;
  100a55:	bb 00 00 00 00       	mov    $0x0,%ebx
    size_t free_space = 0;
  100a5a:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100a60:	eb 90                	jmp    1009f2 <heap_info+0xbb>
        return -1;
  100a62:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100a67:	e9 0b ff ff ff       	jmp    100977 <heap_info+0x40>

0000000000100a6c <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100a6c:	f3 0f 1e fa          	endbr64 
  100a70:	55                   	push   %rbp
  100a71:	48 89 e5             	mov    %rsp,%rbp
  100a74:	48 83 ec 28          	sub    $0x28,%rsp
  100a78:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100a7c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100a80:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100a84:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a88:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100a8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a90:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100a94:	eb 1c                	jmp    100ab2 <memcpy+0x46>
        *d = *s;
  100a96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a9a:	0f b6 10             	movzbl (%rax),%edx
  100a9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100aa1:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100aa3:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100aa8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100aad:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100ab2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100ab7:	75 dd                	jne    100a96 <memcpy+0x2a>
    }
    return dst;
  100ab9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100abd:	c9                   	leave  
  100abe:	c3                   	ret    

0000000000100abf <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100abf:	f3 0f 1e fa          	endbr64 
  100ac3:	55                   	push   %rbp
  100ac4:	48 89 e5             	mov    %rsp,%rbp
  100ac7:	48 83 ec 28          	sub    $0x28,%rsp
  100acb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100acf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100ad3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100ad7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100adb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100adf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100ae3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100ae7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100aeb:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  100aef:	73 6a                	jae    100b5b <memmove+0x9c>
  100af1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100af5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100af9:	48 01 d0             	add    %rdx,%rax
  100afc:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  100b00:	73 59                	jae    100b5b <memmove+0x9c>
        s += n, d += n;
  100b02:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b06:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100b0a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b0e:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  100b12:	eb 17                	jmp    100b2b <memmove+0x6c>
            *--d = *--s;
  100b14:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100b19:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  100b1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b22:	0f b6 10             	movzbl (%rax),%edx
  100b25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b29:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100b2b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b2f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100b33:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100b37:	48 85 c0             	test   %rax,%rax
  100b3a:	75 d8                	jne    100b14 <memmove+0x55>
    if (s < d && s + n > d) {
  100b3c:	eb 2e                	jmp    100b6c <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100b3e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100b42:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100b46:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100b4a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b4e:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100b52:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100b56:	0f b6 12             	movzbl (%rdx),%edx
  100b59:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100b5b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100b5f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100b63:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100b67:	48 85 c0             	test   %rax,%rax
  100b6a:	75 d2                	jne    100b3e <memmove+0x7f>
        }
    }
    return dst;
  100b6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100b70:	c9                   	leave  
  100b71:	c3                   	ret    

0000000000100b72 <memset>:

void* memset(void* v, int c, size_t n) {
  100b72:	f3 0f 1e fa          	endbr64 
  100b76:	55                   	push   %rbp
  100b77:	48 89 e5             	mov    %rsp,%rbp
  100b7a:	48 83 ec 28          	sub    $0x28,%rsp
  100b7e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100b82:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100b85:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100b89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100b8d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100b91:	eb 15                	jmp    100ba8 <memset+0x36>
        *p = c;
  100b93:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100b96:	89 c2                	mov    %eax,%edx
  100b98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b9c:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100b9e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100ba3:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100ba8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100bad:	75 e4                	jne    100b93 <memset+0x21>
    }
    return v;
  100baf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100bb3:	c9                   	leave  
  100bb4:	c3                   	ret    

0000000000100bb5 <strlen>:

size_t strlen(const char* s) {
  100bb5:	f3 0f 1e fa          	endbr64 
  100bb9:	55                   	push   %rbp
  100bba:	48 89 e5             	mov    %rsp,%rbp
  100bbd:	48 83 ec 18          	sub    $0x18,%rsp
  100bc1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100bc5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100bcc:	00 
  100bcd:	eb 0a                	jmp    100bd9 <strlen+0x24>
        ++n;
  100bcf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100bd4:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100bd9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100bdd:	0f b6 00             	movzbl (%rax),%eax
  100be0:	84 c0                	test   %al,%al
  100be2:	75 eb                	jne    100bcf <strlen+0x1a>
    }
    return n;
  100be4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100be8:	c9                   	leave  
  100be9:	c3                   	ret    

0000000000100bea <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100bea:	f3 0f 1e fa          	endbr64 
  100bee:	55                   	push   %rbp
  100bef:	48 89 e5             	mov    %rsp,%rbp
  100bf2:	48 83 ec 20          	sub    $0x20,%rsp
  100bf6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100bfa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100bfe:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100c05:	00 
  100c06:	eb 0a                	jmp    100c12 <strnlen+0x28>
        ++n;
  100c08:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100c0d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100c12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c16:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100c1a:	74 0b                	je     100c27 <strnlen+0x3d>
  100c1c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100c20:	0f b6 00             	movzbl (%rax),%eax
  100c23:	84 c0                	test   %al,%al
  100c25:	75 e1                	jne    100c08 <strnlen+0x1e>
    }
    return n;
  100c27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100c2b:	c9                   	leave  
  100c2c:	c3                   	ret    

0000000000100c2d <strcpy>:

char* strcpy(char* dst, const char* src) {
  100c2d:	f3 0f 1e fa          	endbr64 
  100c31:	55                   	push   %rbp
  100c32:	48 89 e5             	mov    %rsp,%rbp
  100c35:	48 83 ec 20          	sub    $0x20,%rsp
  100c39:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100c3d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100c41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100c45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100c49:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100c4d:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100c51:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100c55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c59:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100c5d:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100c61:	0f b6 12             	movzbl (%rdx),%edx
  100c64:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100c66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c6a:	48 83 e8 01          	sub    $0x1,%rax
  100c6e:	0f b6 00             	movzbl (%rax),%eax
  100c71:	84 c0                	test   %al,%al
  100c73:	75 d4                	jne    100c49 <strcpy+0x1c>
    return dst;
  100c75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100c79:	c9                   	leave  
  100c7a:	c3                   	ret    

0000000000100c7b <strcmp>:

int strcmp(const char* a, const char* b) {
  100c7b:	f3 0f 1e fa          	endbr64 
  100c7f:	55                   	push   %rbp
  100c80:	48 89 e5             	mov    %rsp,%rbp
  100c83:	48 83 ec 10          	sub    $0x10,%rsp
  100c87:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100c8b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100c8f:	eb 0a                	jmp    100c9b <strcmp+0x20>
        ++a, ++b;
  100c91:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100c96:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100c9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c9f:	0f b6 00             	movzbl (%rax),%eax
  100ca2:	84 c0                	test   %al,%al
  100ca4:	74 1d                	je     100cc3 <strcmp+0x48>
  100ca6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100caa:	0f b6 00             	movzbl (%rax),%eax
  100cad:	84 c0                	test   %al,%al
  100caf:	74 12                	je     100cc3 <strcmp+0x48>
  100cb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100cb5:	0f b6 10             	movzbl (%rax),%edx
  100cb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100cbc:	0f b6 00             	movzbl (%rax),%eax
  100cbf:	38 c2                	cmp    %al,%dl
  100cc1:	74 ce                	je     100c91 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100cc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100cc7:	0f b6 00             	movzbl (%rax),%eax
  100cca:	89 c2                	mov    %eax,%edx
  100ccc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100cd0:	0f b6 00             	movzbl (%rax),%eax
  100cd3:	38 c2                	cmp    %al,%dl
  100cd5:	0f 97 c0             	seta   %al
  100cd8:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100cdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100cdf:	0f b6 00             	movzbl (%rax),%eax
  100ce2:	89 c1                	mov    %eax,%ecx
  100ce4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ce8:	0f b6 00             	movzbl (%rax),%eax
  100ceb:	38 c1                	cmp    %al,%cl
  100ced:	0f 92 c0             	setb   %al
  100cf0:	0f b6 c8             	movzbl %al,%ecx
  100cf3:	89 d0                	mov    %edx,%eax
  100cf5:	29 c8                	sub    %ecx,%eax
}
  100cf7:	c9                   	leave  
  100cf8:	c3                   	ret    

0000000000100cf9 <strchr>:

char* strchr(const char* s, int c) {
  100cf9:	f3 0f 1e fa          	endbr64 
  100cfd:	55                   	push   %rbp
  100cfe:	48 89 e5             	mov    %rsp,%rbp
  100d01:	48 83 ec 10          	sub    $0x10,%rsp
  100d05:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100d09:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100d0c:	eb 05                	jmp    100d13 <strchr+0x1a>
        ++s;
  100d0e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100d13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d17:	0f b6 00             	movzbl (%rax),%eax
  100d1a:	84 c0                	test   %al,%al
  100d1c:	74 0e                	je     100d2c <strchr+0x33>
  100d1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d22:	0f b6 00             	movzbl (%rax),%eax
  100d25:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100d28:	38 d0                	cmp    %dl,%al
  100d2a:	75 e2                	jne    100d0e <strchr+0x15>
    }
    if (*s == (char) c) {
  100d2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d30:	0f b6 00             	movzbl (%rax),%eax
  100d33:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100d36:	38 d0                	cmp    %dl,%al
  100d38:	75 06                	jne    100d40 <strchr+0x47>
        return (char*) s;
  100d3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100d3e:	eb 05                	jmp    100d45 <strchr+0x4c>
    } else {
        return NULL;
  100d40:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100d45:	c9                   	leave  
  100d46:	c3                   	ret    

0000000000100d47 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100d47:	f3 0f 1e fa          	endbr64 
  100d4b:	55                   	push   %rbp
  100d4c:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100d4f:	8b 05 db 12 00 00    	mov    0x12db(%rip),%eax        # 102030 <rand_seed_set>
  100d55:	85 c0                	test   %eax,%eax
  100d57:	75 0a                	jne    100d63 <rand+0x1c>
        srand(819234718U);
  100d59:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100d5e:	e8 24 00 00 00       	call   100d87 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100d63:	8b 05 cb 12 00 00    	mov    0x12cb(%rip),%eax        # 102034 <rand_seed>
  100d69:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100d6f:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100d74:	89 05 ba 12 00 00    	mov    %eax,0x12ba(%rip)        # 102034 <rand_seed>
    return rand_seed & RAND_MAX;
  100d7a:	8b 05 b4 12 00 00    	mov    0x12b4(%rip),%eax        # 102034 <rand_seed>
  100d80:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100d85:	5d                   	pop    %rbp
  100d86:	c3                   	ret    

0000000000100d87 <srand>:

void srand(unsigned seed) {
  100d87:	f3 0f 1e fa          	endbr64 
  100d8b:	55                   	push   %rbp
  100d8c:	48 89 e5             	mov    %rsp,%rbp
  100d8f:	48 83 ec 08          	sub    $0x8,%rsp
  100d93:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100d96:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100d99:	89 05 95 12 00 00    	mov    %eax,0x1295(%rip)        # 102034 <rand_seed>
    rand_seed_set = 1;
  100d9f:	c7 05 87 12 00 00 01 	movl   $0x1,0x1287(%rip)        # 102030 <rand_seed_set>
  100da6:	00 00 00 
}
  100da9:	90                   	nop
  100daa:	c9                   	leave  
  100dab:	c3                   	ret    

0000000000100dac <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100dac:	f3 0f 1e fa          	endbr64 
  100db0:	55                   	push   %rbp
  100db1:	48 89 e5             	mov    %rsp,%rbp
  100db4:	48 83 ec 28          	sub    $0x28,%rsp
  100db8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100dbc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100dc0:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100dc3:	48 8d 05 a6 0e 00 00 	lea    0xea6(%rip),%rax        # 101c70 <upper_digits.1>
  100dca:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  100dce:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100dd2:	79 0e                	jns    100de2 <fill_numbuf+0x36>
        digits = lower_digits;
  100dd4:	48 8d 05 b5 0e 00 00 	lea    0xeb5(%rip),%rax        # 101c90 <lower_digits.0>
  100ddb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  100ddf:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100de2:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100de7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100deb:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100dee:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100df1:	48 63 c8             	movslq %eax,%rcx
  100df4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100df8:	ba 00 00 00 00       	mov    $0x0,%edx
  100dfd:	48 f7 f1             	div    %rcx
  100e00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100e04:	48 01 d0             	add    %rdx,%rax
  100e07:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100e0c:	0f b6 10             	movzbl (%rax),%edx
  100e0f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100e13:	88 10                	mov    %dl,(%rax)
        val /= base;
  100e15:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100e18:	48 63 f0             	movslq %eax,%rsi
  100e1b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100e1f:	ba 00 00 00 00       	mov    $0x0,%edx
  100e24:	48 f7 f6             	div    %rsi
  100e27:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100e2b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100e30:	75 bc                	jne    100dee <fill_numbuf+0x42>
    return numbuf_end;
  100e32:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100e36:	c9                   	leave  
  100e37:	c3                   	ret    

0000000000100e38 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100e38:	f3 0f 1e fa          	endbr64 
  100e3c:	55                   	push   %rbp
  100e3d:	48 89 e5             	mov    %rsp,%rbp
  100e40:	53                   	push   %rbx
  100e41:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100e48:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100e4f:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100e55:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100e5c:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100e63:	e9 bd 09 00 00       	jmp    101825 <printer_vprintf+0x9ed>
        if (*format != '%') {
  100e68:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e6f:	0f b6 00             	movzbl (%rax),%eax
  100e72:	3c 25                	cmp    $0x25,%al
  100e74:	74 31                	je     100ea7 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  100e76:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e7d:	4c 8b 00             	mov    (%rax),%r8
  100e80:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e87:	0f b6 00             	movzbl (%rax),%eax
  100e8a:	0f b6 c8             	movzbl %al,%ecx
  100e8d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e93:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e9a:	89 ce                	mov    %ecx,%esi
  100e9c:	48 89 c7             	mov    %rax,%rdi
  100e9f:	41 ff d0             	call   *%r8
            continue;
  100ea2:	e9 76 09 00 00       	jmp    10181d <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  100ea7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100eae:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100eb5:	01 
  100eb6:	eb 4d                	jmp    100f05 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  100eb8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ebf:	0f b6 00             	movzbl (%rax),%eax
  100ec2:	0f be c0             	movsbl %al,%eax
  100ec5:	89 c6                	mov    %eax,%esi
  100ec7:	48 8d 05 a2 0c 00 00 	lea    0xca2(%rip),%rax        # 101b70 <flag_chars>
  100ece:	48 89 c7             	mov    %rax,%rdi
  100ed1:	e8 23 fe ff ff       	call   100cf9 <strchr>
  100ed6:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100eda:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100edf:	74 34                	je     100f15 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  100ee1:	48 8d 15 88 0c 00 00 	lea    0xc88(%rip),%rdx        # 101b70 <flag_chars>
  100ee8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100eec:	48 29 d0             	sub    %rdx,%rax
  100eef:	ba 01 00 00 00       	mov    $0x1,%edx
  100ef4:	89 c1                	mov    %eax,%ecx
  100ef6:	d3 e2                	shl    %cl,%edx
  100ef8:	89 d0                	mov    %edx,%eax
  100efa:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100efd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f04:	01 
  100f05:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f0c:	0f b6 00             	movzbl (%rax),%eax
  100f0f:	84 c0                	test   %al,%al
  100f11:	75 a5                	jne    100eb8 <printer_vprintf+0x80>
  100f13:	eb 01                	jmp    100f16 <printer_vprintf+0xde>
            } else {
                break;
  100f15:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100f16:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100f1d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f24:	0f b6 00             	movzbl (%rax),%eax
  100f27:	3c 30                	cmp    $0x30,%al
  100f29:	7e 67                	jle    100f92 <printer_vprintf+0x15a>
  100f2b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f32:	0f b6 00             	movzbl (%rax),%eax
  100f35:	3c 39                	cmp    $0x39,%al
  100f37:	7f 59                	jg     100f92 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100f39:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100f40:	eb 2e                	jmp    100f70 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  100f42:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100f45:	89 d0                	mov    %edx,%eax
  100f47:	c1 e0 02             	shl    $0x2,%eax
  100f4a:	01 d0                	add    %edx,%eax
  100f4c:	01 c0                	add    %eax,%eax
  100f4e:	89 c1                	mov    %eax,%ecx
  100f50:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f57:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100f5b:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100f62:	0f b6 00             	movzbl (%rax),%eax
  100f65:	0f be c0             	movsbl %al,%eax
  100f68:	01 c8                	add    %ecx,%eax
  100f6a:	83 e8 30             	sub    $0x30,%eax
  100f6d:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100f70:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f77:	0f b6 00             	movzbl (%rax),%eax
  100f7a:	3c 2f                	cmp    $0x2f,%al
  100f7c:	0f 8e 85 00 00 00    	jle    101007 <printer_vprintf+0x1cf>
  100f82:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f89:	0f b6 00             	movzbl (%rax),%eax
  100f8c:	3c 39                	cmp    $0x39,%al
  100f8e:	7e b2                	jle    100f42 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  100f90:	eb 75                	jmp    101007 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  100f92:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f99:	0f b6 00             	movzbl (%rax),%eax
  100f9c:	3c 2a                	cmp    $0x2a,%al
  100f9e:	75 68                	jne    101008 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  100fa0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fa7:	8b 00                	mov    (%rax),%eax
  100fa9:	83 f8 2f             	cmp    $0x2f,%eax
  100fac:	77 30                	ja     100fde <printer_vprintf+0x1a6>
  100fae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fb9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fc0:	8b 00                	mov    (%rax),%eax
  100fc2:	89 c0                	mov    %eax,%eax
  100fc4:	48 01 d0             	add    %rdx,%rax
  100fc7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fce:	8b 12                	mov    (%rdx),%edx
  100fd0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fd3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fda:	89 0a                	mov    %ecx,(%rdx)
  100fdc:	eb 1a                	jmp    100ff8 <printer_vprintf+0x1c0>
  100fde:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fe5:	48 8b 40 08          	mov    0x8(%rax),%rax
  100fe9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ff4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ff8:	8b 00                	mov    (%rax),%eax
  100ffa:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100ffd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101004:	01 
  101005:	eb 01                	jmp    101008 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  101007:	90                   	nop
        }

        // process precision
        int precision = -1;
  101008:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  10100f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101016:	0f b6 00             	movzbl (%rax),%eax
  101019:	3c 2e                	cmp    $0x2e,%al
  10101b:	0f 85 00 01 00 00    	jne    101121 <printer_vprintf+0x2e9>
            ++format;
  101021:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101028:	01 
            if (*format >= '0' && *format <= '9') {
  101029:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101030:	0f b6 00             	movzbl (%rax),%eax
  101033:	3c 2f                	cmp    $0x2f,%al
  101035:	7e 67                	jle    10109e <printer_vprintf+0x266>
  101037:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10103e:	0f b6 00             	movzbl (%rax),%eax
  101041:	3c 39                	cmp    $0x39,%al
  101043:	7f 59                	jg     10109e <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  101045:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  10104c:	eb 2e                	jmp    10107c <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  10104e:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  101051:	89 d0                	mov    %edx,%eax
  101053:	c1 e0 02             	shl    $0x2,%eax
  101056:	01 d0                	add    %edx,%eax
  101058:	01 c0                	add    %eax,%eax
  10105a:	89 c1                	mov    %eax,%ecx
  10105c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101063:	48 8d 50 01          	lea    0x1(%rax),%rdx
  101067:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10106e:	0f b6 00             	movzbl (%rax),%eax
  101071:	0f be c0             	movsbl %al,%eax
  101074:	01 c8                	add    %ecx,%eax
  101076:	83 e8 30             	sub    $0x30,%eax
  101079:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10107c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101083:	0f b6 00             	movzbl (%rax),%eax
  101086:	3c 2f                	cmp    $0x2f,%al
  101088:	0f 8e 85 00 00 00    	jle    101113 <printer_vprintf+0x2db>
  10108e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101095:	0f b6 00             	movzbl (%rax),%eax
  101098:	3c 39                	cmp    $0x39,%al
  10109a:	7e b2                	jle    10104e <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  10109c:	eb 75                	jmp    101113 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  10109e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010a5:	0f b6 00             	movzbl (%rax),%eax
  1010a8:	3c 2a                	cmp    $0x2a,%al
  1010aa:	75 68                	jne    101114 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  1010ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010b3:	8b 00                	mov    (%rax),%eax
  1010b5:	83 f8 2f             	cmp    $0x2f,%eax
  1010b8:	77 30                	ja     1010ea <printer_vprintf+0x2b2>
  1010ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010c1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010c5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010cc:	8b 00                	mov    (%rax),%eax
  1010ce:	89 c0                	mov    %eax,%eax
  1010d0:	48 01 d0             	add    %rdx,%rax
  1010d3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010da:	8b 12                	mov    (%rdx),%edx
  1010dc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010e6:	89 0a                	mov    %ecx,(%rdx)
  1010e8:	eb 1a                	jmp    101104 <printer_vprintf+0x2cc>
  1010ea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010f1:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010f5:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010f9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101100:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101104:	8b 00                	mov    (%rax),%eax
  101106:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  101109:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101110:	01 
  101111:	eb 01                	jmp    101114 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  101113:	90                   	nop
            }
            if (precision < 0) {
  101114:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101118:	79 07                	jns    101121 <printer_vprintf+0x2e9>
                precision = 0;
  10111a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  101121:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  101128:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  10112f:	00 
        int length = 0;
  101130:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  101137:	48 8d 05 38 0a 00 00 	lea    0xa38(%rip),%rax        # 101b76 <flag_chars+0x6>
  10113e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  101142:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101149:	0f b6 00             	movzbl (%rax),%eax
  10114c:	0f be c0             	movsbl %al,%eax
  10114f:	83 e8 43             	sub    $0x43,%eax
  101152:	83 f8 37             	cmp    $0x37,%eax
  101155:	0f 87 b6 03 00 00    	ja     101511 <printer_vprintf+0x6d9>
  10115b:	89 c0                	mov    %eax,%eax
  10115d:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  101164:	00 
  101165:	48 8d 05 18 0a 00 00 	lea    0xa18(%rip),%rax        # 101b84 <flag_chars+0x14>
  10116c:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  10116f:	48 98                	cltq   
  101171:	48 8d 15 0c 0a 00 00 	lea    0xa0c(%rip),%rdx        # 101b84 <flag_chars+0x14>
  101178:	48 01 d0             	add    %rdx,%rax
  10117b:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  10117e:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  101185:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10118c:	01 
            goto again;
  10118d:	eb b3                	jmp    101142 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10118f:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  101193:	74 5d                	je     1011f2 <printer_vprintf+0x3ba>
  101195:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10119c:	8b 00                	mov    (%rax),%eax
  10119e:	83 f8 2f             	cmp    $0x2f,%eax
  1011a1:	77 30                	ja     1011d3 <printer_vprintf+0x39b>
  1011a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011aa:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1011ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011b5:	8b 00                	mov    (%rax),%eax
  1011b7:	89 c0                	mov    %eax,%eax
  1011b9:	48 01 d0             	add    %rdx,%rax
  1011bc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011c3:	8b 12                	mov    (%rdx),%edx
  1011c5:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1011c8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011cf:	89 0a                	mov    %ecx,(%rdx)
  1011d1:	eb 1a                	jmp    1011ed <printer_vprintf+0x3b5>
  1011d3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011da:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011de:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1011e2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011e9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011ed:	48 8b 00             	mov    (%rax),%rax
  1011f0:	eb 5c                	jmp    10124e <printer_vprintf+0x416>
  1011f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011f9:	8b 00                	mov    (%rax),%eax
  1011fb:	83 f8 2f             	cmp    $0x2f,%eax
  1011fe:	77 30                	ja     101230 <printer_vprintf+0x3f8>
  101200:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101207:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10120b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101212:	8b 00                	mov    (%rax),%eax
  101214:	89 c0                	mov    %eax,%eax
  101216:	48 01 d0             	add    %rdx,%rax
  101219:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101220:	8b 12                	mov    (%rdx),%edx
  101222:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101225:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10122c:	89 0a                	mov    %ecx,(%rdx)
  10122e:	eb 1a                	jmp    10124a <printer_vprintf+0x412>
  101230:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101237:	48 8b 40 08          	mov    0x8(%rax),%rax
  10123b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10123f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101246:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10124a:	8b 00                	mov    (%rax),%eax
  10124c:	48 98                	cltq   
  10124e:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  101252:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101256:	48 c1 f8 38          	sar    $0x38,%rax
  10125a:	25 80 00 00 00       	and    $0x80,%eax
  10125f:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  101262:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  101266:	74 09                	je     101271 <printer_vprintf+0x439>
  101268:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10126c:	48 f7 d8             	neg    %rax
  10126f:	eb 04                	jmp    101275 <printer_vprintf+0x43d>
  101271:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101275:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  101279:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  10127c:	83 c8 60             	or     $0x60,%eax
  10127f:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  101282:	e9 cf 02 00 00       	jmp    101556 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  101287:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  10128b:	74 5d                	je     1012ea <printer_vprintf+0x4b2>
  10128d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101294:	8b 00                	mov    (%rax),%eax
  101296:	83 f8 2f             	cmp    $0x2f,%eax
  101299:	77 30                	ja     1012cb <printer_vprintf+0x493>
  10129b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012a2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1012a6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012ad:	8b 00                	mov    (%rax),%eax
  1012af:	89 c0                	mov    %eax,%eax
  1012b1:	48 01 d0             	add    %rdx,%rax
  1012b4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012bb:	8b 12                	mov    (%rdx),%edx
  1012bd:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1012c0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012c7:	89 0a                	mov    %ecx,(%rdx)
  1012c9:	eb 1a                	jmp    1012e5 <printer_vprintf+0x4ad>
  1012cb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012d2:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012d6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1012da:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012e1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012e5:	48 8b 00             	mov    (%rax),%rax
  1012e8:	eb 5c                	jmp    101346 <printer_vprintf+0x50e>
  1012ea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012f1:	8b 00                	mov    (%rax),%eax
  1012f3:	83 f8 2f             	cmp    $0x2f,%eax
  1012f6:	77 30                	ja     101328 <printer_vprintf+0x4f0>
  1012f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012ff:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101303:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10130a:	8b 00                	mov    (%rax),%eax
  10130c:	89 c0                	mov    %eax,%eax
  10130e:	48 01 d0             	add    %rdx,%rax
  101311:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101318:	8b 12                	mov    (%rdx),%edx
  10131a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10131d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101324:	89 0a                	mov    %ecx,(%rdx)
  101326:	eb 1a                	jmp    101342 <printer_vprintf+0x50a>
  101328:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10132f:	48 8b 40 08          	mov    0x8(%rax),%rax
  101333:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101337:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10133e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101342:	8b 00                	mov    (%rax),%eax
  101344:	89 c0                	mov    %eax,%eax
  101346:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  10134a:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  10134e:	e9 03 02 00 00       	jmp    101556 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  101353:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  10135a:	e9 28 ff ff ff       	jmp    101287 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  10135f:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  101366:	e9 1c ff ff ff       	jmp    101287 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  10136b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101372:	8b 00                	mov    (%rax),%eax
  101374:	83 f8 2f             	cmp    $0x2f,%eax
  101377:	77 30                	ja     1013a9 <printer_vprintf+0x571>
  101379:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101380:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101384:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10138b:	8b 00                	mov    (%rax),%eax
  10138d:	89 c0                	mov    %eax,%eax
  10138f:	48 01 d0             	add    %rdx,%rax
  101392:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101399:	8b 12                	mov    (%rdx),%edx
  10139b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10139e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013a5:	89 0a                	mov    %ecx,(%rdx)
  1013a7:	eb 1a                	jmp    1013c3 <printer_vprintf+0x58b>
  1013a9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013b0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013b4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1013b8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1013bf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1013c3:	48 8b 00             	mov    (%rax),%rax
  1013c6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1013ca:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1013d1:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  1013d8:	e9 79 01 00 00       	jmp    101556 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  1013dd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013e4:	8b 00                	mov    (%rax),%eax
  1013e6:	83 f8 2f             	cmp    $0x2f,%eax
  1013e9:	77 30                	ja     10141b <printer_vprintf+0x5e3>
  1013eb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013f2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1013f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1013fd:	8b 00                	mov    (%rax),%eax
  1013ff:	89 c0                	mov    %eax,%eax
  101401:	48 01 d0             	add    %rdx,%rax
  101404:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10140b:	8b 12                	mov    (%rdx),%edx
  10140d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101410:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101417:	89 0a                	mov    %ecx,(%rdx)
  101419:	eb 1a                	jmp    101435 <printer_vprintf+0x5fd>
  10141b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101422:	48 8b 40 08          	mov    0x8(%rax),%rax
  101426:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10142a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101431:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101435:	48 8b 00             	mov    (%rax),%rax
  101438:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  10143c:	e9 15 01 00 00       	jmp    101556 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  101441:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101448:	8b 00                	mov    (%rax),%eax
  10144a:	83 f8 2f             	cmp    $0x2f,%eax
  10144d:	77 30                	ja     10147f <printer_vprintf+0x647>
  10144f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101456:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10145a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101461:	8b 00                	mov    (%rax),%eax
  101463:	89 c0                	mov    %eax,%eax
  101465:	48 01 d0             	add    %rdx,%rax
  101468:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10146f:	8b 12                	mov    (%rdx),%edx
  101471:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101474:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10147b:	89 0a                	mov    %ecx,(%rdx)
  10147d:	eb 1a                	jmp    101499 <printer_vprintf+0x661>
  10147f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101486:	48 8b 40 08          	mov    0x8(%rax),%rax
  10148a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10148e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101495:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101499:	8b 00                	mov    (%rax),%eax
  10149b:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  1014a1:	e9 77 03 00 00       	jmp    10181d <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  1014a6:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1014aa:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  1014ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014b5:	8b 00                	mov    (%rax),%eax
  1014b7:	83 f8 2f             	cmp    $0x2f,%eax
  1014ba:	77 30                	ja     1014ec <printer_vprintf+0x6b4>
  1014bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014c3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1014c7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014ce:	8b 00                	mov    (%rax),%eax
  1014d0:	89 c0                	mov    %eax,%eax
  1014d2:	48 01 d0             	add    %rdx,%rax
  1014d5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014dc:	8b 12                	mov    (%rdx),%edx
  1014de:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1014e1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014e8:	89 0a                	mov    %ecx,(%rdx)
  1014ea:	eb 1a                	jmp    101506 <printer_vprintf+0x6ce>
  1014ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014f3:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014f7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1014fb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101502:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101506:	8b 00                	mov    (%rax),%eax
  101508:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10150b:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  10150f:	eb 45                	jmp    101556 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  101511:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101515:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  101519:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101520:	0f b6 00             	movzbl (%rax),%eax
  101523:	84 c0                	test   %al,%al
  101525:	74 0c                	je     101533 <printer_vprintf+0x6fb>
  101527:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10152e:	0f b6 00             	movzbl (%rax),%eax
  101531:	eb 05                	jmp    101538 <printer_vprintf+0x700>
  101533:	b8 25 00 00 00       	mov    $0x25,%eax
  101538:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10153b:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  10153f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101546:	0f b6 00             	movzbl (%rax),%eax
  101549:	84 c0                	test   %al,%al
  10154b:	75 08                	jne    101555 <printer_vprintf+0x71d>
                format--;
  10154d:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  101554:	01 
            }
            break;
  101555:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  101556:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101559:	83 e0 20             	and    $0x20,%eax
  10155c:	85 c0                	test   %eax,%eax
  10155e:	74 1e                	je     10157e <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101560:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101564:	48 83 c0 18          	add    $0x18,%rax
  101568:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10156b:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10156f:	48 89 ce             	mov    %rcx,%rsi
  101572:	48 89 c7             	mov    %rax,%rdi
  101575:	e8 32 f8 ff ff       	call   100dac <fill_numbuf>
  10157a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  10157e:	48 8d 05 f1 05 00 00 	lea    0x5f1(%rip),%rax        # 101b76 <flag_chars+0x6>
  101585:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  101589:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10158c:	83 e0 20             	and    $0x20,%eax
  10158f:	85 c0                	test   %eax,%eax
  101591:	74 51                	je     1015e4 <printer_vprintf+0x7ac>
  101593:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101596:	83 e0 40             	and    $0x40,%eax
  101599:	85 c0                	test   %eax,%eax
  10159b:	74 47                	je     1015e4 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  10159d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015a0:	25 80 00 00 00       	and    $0x80,%eax
  1015a5:	85 c0                	test   %eax,%eax
  1015a7:	74 0d                	je     1015b6 <printer_vprintf+0x77e>
                prefix = "-";
  1015a9:	48 8d 05 c7 05 00 00 	lea    0x5c7(%rip),%rax        # 101b77 <flag_chars+0x7>
  1015b0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1015b4:	eb 7d                	jmp    101633 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1015b6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015b9:	83 e0 10             	and    $0x10,%eax
  1015bc:	85 c0                	test   %eax,%eax
  1015be:	74 0d                	je     1015cd <printer_vprintf+0x795>
                prefix = "+";
  1015c0:	48 8d 05 b2 05 00 00 	lea    0x5b2(%rip),%rax        # 101b79 <flag_chars+0x9>
  1015c7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1015cb:	eb 66                	jmp    101633 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  1015cd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015d0:	83 e0 08             	and    $0x8,%eax
  1015d3:	85 c0                	test   %eax,%eax
  1015d5:	74 5c                	je     101633 <printer_vprintf+0x7fb>
                prefix = " ";
  1015d7:	48 8d 05 9d 05 00 00 	lea    0x59d(%rip),%rax        # 101b7b <flag_chars+0xb>
  1015de:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  1015e2:	eb 4f                	jmp    101633 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1015e4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015e7:	83 e0 20             	and    $0x20,%eax
  1015ea:	85 c0                	test   %eax,%eax
  1015ec:	74 46                	je     101634 <printer_vprintf+0x7fc>
  1015ee:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015f1:	83 e0 01             	and    $0x1,%eax
  1015f4:	85 c0                	test   %eax,%eax
  1015f6:	74 3c                	je     101634 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  1015f8:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  1015fc:	74 06                	je     101604 <printer_vprintf+0x7cc>
  1015fe:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101602:	75 30                	jne    101634 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  101604:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  101609:	75 0c                	jne    101617 <printer_vprintf+0x7df>
  10160b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10160e:	25 00 01 00 00       	and    $0x100,%eax
  101613:	85 c0                	test   %eax,%eax
  101615:	74 1d                	je     101634 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  101617:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  10161b:	75 09                	jne    101626 <printer_vprintf+0x7ee>
  10161d:	48 8d 05 59 05 00 00 	lea    0x559(%rip),%rax        # 101b7d <flag_chars+0xd>
  101624:	eb 07                	jmp    10162d <printer_vprintf+0x7f5>
  101626:	48 8d 05 53 05 00 00 	lea    0x553(%rip),%rax        # 101b80 <flag_chars+0x10>
  10162d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101631:	eb 01                	jmp    101634 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  101633:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  101634:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101638:	78 24                	js     10165e <printer_vprintf+0x826>
  10163a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10163d:	83 e0 20             	and    $0x20,%eax
  101640:	85 c0                	test   %eax,%eax
  101642:	75 1a                	jne    10165e <printer_vprintf+0x826>
            len = strnlen(data, precision);
  101644:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101647:	48 63 d0             	movslq %eax,%rdx
  10164a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10164e:	48 89 d6             	mov    %rdx,%rsi
  101651:	48 89 c7             	mov    %rax,%rdi
  101654:	e8 91 f5 ff ff       	call   100bea <strnlen>
  101659:	89 45 bc             	mov    %eax,-0x44(%rbp)
  10165c:	eb 0f                	jmp    10166d <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  10165e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101662:	48 89 c7             	mov    %rax,%rdi
  101665:	e8 4b f5 ff ff       	call   100bb5 <strlen>
  10166a:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  10166d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101670:	83 e0 20             	and    $0x20,%eax
  101673:	85 c0                	test   %eax,%eax
  101675:	74 20                	je     101697 <printer_vprintf+0x85f>
  101677:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10167b:	78 1a                	js     101697 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  10167d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101680:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101683:	7e 08                	jle    10168d <printer_vprintf+0x855>
  101685:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101688:	2b 45 bc             	sub    -0x44(%rbp),%eax
  10168b:	eb 05                	jmp    101692 <printer_vprintf+0x85a>
  10168d:	b8 00 00 00 00       	mov    $0x0,%eax
  101692:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101695:	eb 5c                	jmp    1016f3 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  101697:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10169a:	83 e0 20             	and    $0x20,%eax
  10169d:	85 c0                	test   %eax,%eax
  10169f:	74 4b                	je     1016ec <printer_vprintf+0x8b4>
  1016a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1016a4:	83 e0 02             	and    $0x2,%eax
  1016a7:	85 c0                	test   %eax,%eax
  1016a9:	74 41                	je     1016ec <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1016ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1016ae:	83 e0 04             	and    $0x4,%eax
  1016b1:	85 c0                	test   %eax,%eax
  1016b3:	75 37                	jne    1016ec <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  1016b5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1016b9:	48 89 c7             	mov    %rax,%rdi
  1016bc:	e8 f4 f4 ff ff       	call   100bb5 <strlen>
  1016c1:	89 c2                	mov    %eax,%edx
  1016c3:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1016c6:	01 d0                	add    %edx,%eax
  1016c8:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  1016cb:	7e 1f                	jle    1016ec <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  1016cd:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1016d0:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1016d3:	89 c3                	mov    %eax,%ebx
  1016d5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1016d9:	48 89 c7             	mov    %rax,%rdi
  1016dc:	e8 d4 f4 ff ff       	call   100bb5 <strlen>
  1016e1:	89 c2                	mov    %eax,%edx
  1016e3:	89 d8                	mov    %ebx,%eax
  1016e5:	29 d0                	sub    %edx,%eax
  1016e7:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1016ea:	eb 07                	jmp    1016f3 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  1016ec:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  1016f3:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1016f6:	8b 45 b8             	mov    -0x48(%rbp),%eax
  1016f9:	01 d0                	add    %edx,%eax
  1016fb:	48 63 d8             	movslq %eax,%rbx
  1016fe:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101702:	48 89 c7             	mov    %rax,%rdi
  101705:	e8 ab f4 ff ff       	call   100bb5 <strlen>
  10170a:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  10170e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101711:	29 d0                	sub    %edx,%eax
  101713:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101716:	eb 25                	jmp    10173d <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  101718:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10171f:	48 8b 08             	mov    (%rax),%rcx
  101722:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101728:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10172f:	be 20 00 00 00       	mov    $0x20,%esi
  101734:	48 89 c7             	mov    %rax,%rdi
  101737:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101739:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10173d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101740:	83 e0 04             	and    $0x4,%eax
  101743:	85 c0                	test   %eax,%eax
  101745:	75 36                	jne    10177d <printer_vprintf+0x945>
  101747:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10174b:	7f cb                	jg     101718 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  10174d:	eb 2e                	jmp    10177d <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  10174f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101756:	4c 8b 00             	mov    (%rax),%r8
  101759:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10175d:	0f b6 00             	movzbl (%rax),%eax
  101760:	0f b6 c8             	movzbl %al,%ecx
  101763:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101769:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101770:	89 ce                	mov    %ecx,%esi
  101772:	48 89 c7             	mov    %rax,%rdi
  101775:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101778:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  10177d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101781:	0f b6 00             	movzbl (%rax),%eax
  101784:	84 c0                	test   %al,%al
  101786:	75 c7                	jne    10174f <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  101788:	eb 25                	jmp    1017af <printer_vprintf+0x977>
            p->putc(p, '0', color);
  10178a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101791:	48 8b 08             	mov    (%rax),%rcx
  101794:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10179a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1017a1:	be 30 00 00 00       	mov    $0x30,%esi
  1017a6:	48 89 c7             	mov    %rax,%rdi
  1017a9:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1017ab:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  1017af:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  1017b3:	7f d5                	jg     10178a <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  1017b5:	eb 32                	jmp    1017e9 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  1017b7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1017be:	4c 8b 00             	mov    (%rax),%r8
  1017c1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1017c5:	0f b6 00             	movzbl (%rax),%eax
  1017c8:	0f b6 c8             	movzbl %al,%ecx
  1017cb:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1017d1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1017d8:	89 ce                	mov    %ecx,%esi
  1017da:	48 89 c7             	mov    %rax,%rdi
  1017dd:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  1017e0:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  1017e5:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  1017e9:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  1017ed:	7f c8                	jg     1017b7 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  1017ef:	eb 25                	jmp    101816 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  1017f1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1017f8:	48 8b 08             	mov    (%rax),%rcx
  1017fb:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101801:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101808:	be 20 00 00 00       	mov    $0x20,%esi
  10180d:	48 89 c7             	mov    %rax,%rdi
  101810:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101812:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101816:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10181a:	7f d5                	jg     1017f1 <printer_vprintf+0x9b9>
        }
    done: ;
  10181c:	90                   	nop
    for (; *format; ++format) {
  10181d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101824:	01 
  101825:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10182c:	0f b6 00             	movzbl (%rax),%eax
  10182f:	84 c0                	test   %al,%al
  101831:	0f 85 31 f6 ff ff    	jne    100e68 <printer_vprintf+0x30>
    }
}
  101837:	90                   	nop
  101838:	90                   	nop
  101839:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10183d:	c9                   	leave  
  10183e:	c3                   	ret    

000000000010183f <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  10183f:	f3 0f 1e fa          	endbr64 
  101843:	55                   	push   %rbp
  101844:	48 89 e5             	mov    %rsp,%rbp
  101847:	48 83 ec 20          	sub    $0x20,%rsp
  10184b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10184f:	89 f0                	mov    %esi,%eax
  101851:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101854:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101857:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10185b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10185f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101863:	48 8b 40 08          	mov    0x8(%rax),%rax
  101867:	48 8d 15 32 77 fb ff 	lea    -0x488ce(%rip),%rdx        # b8fa0 <console+0xfa0>
  10186e:	48 39 d0             	cmp    %rdx,%rax
  101871:	72 0f                	jb     101882 <console_putc+0x43>
        cp->cursor = console;
  101873:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101877:	48 8d 15 82 67 fb ff 	lea    -0x4987e(%rip),%rdx        # b8000 <console>
  10187e:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  101882:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101886:	0f 85 82 00 00 00    	jne    10190e <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  10188c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101890:	48 8b 40 08          	mov    0x8(%rax),%rax
  101894:	48 8d 15 65 67 fb ff 	lea    -0x4989b(%rip),%rdx        # b8000 <console>
  10189b:	48 29 d0             	sub    %rdx,%rax
  10189e:	48 d1 f8             	sar    %rax
  1018a1:	48 89 c1             	mov    %rax,%rcx
  1018a4:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1018ab:	66 66 66 
  1018ae:	48 89 c8             	mov    %rcx,%rax
  1018b1:	48 f7 ea             	imul   %rdx
  1018b4:	48 89 d0             	mov    %rdx,%rax
  1018b7:	48 c1 f8 05          	sar    $0x5,%rax
  1018bb:	48 89 ce             	mov    %rcx,%rsi
  1018be:	48 c1 fe 3f          	sar    $0x3f,%rsi
  1018c2:	48 29 f0             	sub    %rsi,%rax
  1018c5:	48 89 c2             	mov    %rax,%rdx
  1018c8:	48 89 d0             	mov    %rdx,%rax
  1018cb:	48 c1 e0 02          	shl    $0x2,%rax
  1018cf:	48 01 d0             	add    %rdx,%rax
  1018d2:	48 c1 e0 04          	shl    $0x4,%rax
  1018d6:	48 29 c1             	sub    %rax,%rcx
  1018d9:	48 89 ca             	mov    %rcx,%rdx
  1018dc:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  1018df:	eb 25                	jmp    101906 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  1018e1:	8b 45 e0             	mov    -0x20(%rbp),%eax
  1018e4:	83 c8 20             	or     $0x20,%eax
  1018e7:	89 c6                	mov    %eax,%esi
  1018e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1018ed:	48 8b 40 08          	mov    0x8(%rax),%rax
  1018f1:	48 8d 48 02          	lea    0x2(%rax),%rcx
  1018f5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  1018f9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1018fd:	89 f2                	mov    %esi,%edx
  1018ff:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101902:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101906:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  10190a:	75 d5                	jne    1018e1 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  10190c:	eb 24                	jmp    101932 <console_putc+0xf3>
        *cp->cursor++ = c | color;
  10190e:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101912:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101915:	89 d6                	mov    %edx,%esi
  101917:	09 c6                	or     %eax,%esi
  101919:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10191d:	48 8b 40 08          	mov    0x8(%rax),%rax
  101921:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101925:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101929:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10192d:	89 f2                	mov    %esi,%edx
  10192f:	66 89 10             	mov    %dx,(%rax)
}
  101932:	90                   	nop
  101933:	c9                   	leave  
  101934:	c3                   	ret    

0000000000101935 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101935:	f3 0f 1e fa          	endbr64 
  101939:	55                   	push   %rbp
  10193a:	48 89 e5             	mov    %rsp,%rbp
  10193d:	48 83 ec 30          	sub    $0x30,%rsp
  101941:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101944:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101947:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  10194b:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  10194f:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 10183f <console_putc>
  101956:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10195a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  10195e:	78 09                	js     101969 <console_vprintf+0x34>
  101960:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101967:	7e 07                	jle    101970 <console_vprintf+0x3b>
        cpos = 0;
  101969:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101970:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101973:	48 98                	cltq   
  101975:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101979:	48 8d 05 80 66 fb ff 	lea    -0x49980(%rip),%rax        # b8000 <console>
  101980:	48 01 d0             	add    %rdx,%rax
  101983:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101987:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  10198b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10198f:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101992:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101996:	48 89 c7             	mov    %rax,%rdi
  101999:	e8 9a f4 ff ff       	call   100e38 <printer_vprintf>
    return cp.cursor - console;
  10199e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1019a2:	48 8d 15 57 66 fb ff 	lea    -0x499a9(%rip),%rdx        # b8000 <console>
  1019a9:	48 29 d0             	sub    %rdx,%rax
  1019ac:	48 d1 f8             	sar    %rax
}
  1019af:	c9                   	leave  
  1019b0:	c3                   	ret    

00000000001019b1 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1019b1:	f3 0f 1e fa          	endbr64 
  1019b5:	55                   	push   %rbp
  1019b6:	48 89 e5             	mov    %rsp,%rbp
  1019b9:	48 83 ec 60          	sub    $0x60,%rsp
  1019bd:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1019c0:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1019c3:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1019c7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1019cb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1019cf:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1019d3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1019da:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1019de:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1019e2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1019e6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1019ea:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1019ee:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  1019f2:	8b 75 a8             	mov    -0x58(%rbp),%esi
  1019f5:	8b 45 ac             	mov    -0x54(%rbp),%eax
  1019f8:	89 c7                	mov    %eax,%edi
  1019fa:	e8 36 ff ff ff       	call   101935 <console_vprintf>
  1019ff:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101a02:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101a05:	c9                   	leave  
  101a06:	c3                   	ret    

0000000000101a07 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101a07:	f3 0f 1e fa          	endbr64 
  101a0b:	55                   	push   %rbp
  101a0c:	48 89 e5             	mov    %rsp,%rbp
  101a0f:	48 83 ec 20          	sub    $0x20,%rsp
  101a13:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101a17:	89 f0                	mov    %esi,%eax
  101a19:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101a1c:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101a1f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101a23:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101a27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101a2b:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101a2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101a33:	48 8b 40 10          	mov    0x10(%rax),%rax
  101a37:	48 39 c2             	cmp    %rax,%rdx
  101a3a:	73 1a                	jae    101a56 <string_putc+0x4f>
        *sp->s++ = c;
  101a3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101a40:	48 8b 40 08          	mov    0x8(%rax),%rax
  101a44:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101a48:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101a4c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101a50:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101a54:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101a56:	90                   	nop
  101a57:	c9                   	leave  
  101a58:	c3                   	ret    

0000000000101a59 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101a59:	f3 0f 1e fa          	endbr64 
  101a5d:	55                   	push   %rbp
  101a5e:	48 89 e5             	mov    %rsp,%rbp
  101a61:	48 83 ec 40          	sub    $0x40,%rsp
  101a65:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101a69:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101a6d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101a71:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101a75:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 101a07 <string_putc>
  101a7c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  101a80:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101a84:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101a88:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101a8d:	74 33                	je     101ac2 <vsnprintf+0x69>
        sp.end = s + size - 1;
  101a8f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101a93:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101a97:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101a9b:	48 01 d0             	add    %rdx,%rax
  101a9e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101aa2:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101aa6:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101aaa:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101aae:	be 00 00 00 00       	mov    $0x0,%esi
  101ab3:	48 89 c7             	mov    %rax,%rdi
  101ab6:	e8 7d f3 ff ff       	call   100e38 <printer_vprintf>
        *sp.s = 0;
  101abb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101abf:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101ac2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101ac6:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101aca:	c9                   	leave  
  101acb:	c3                   	ret    

0000000000101acc <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101acc:	f3 0f 1e fa          	endbr64 
  101ad0:	55                   	push   %rbp
  101ad1:	48 89 e5             	mov    %rsp,%rbp
  101ad4:	48 83 ec 70          	sub    $0x70,%rsp
  101ad8:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101adc:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101ae0:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101ae4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101ae8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101aec:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101af0:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101af7:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101afb:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101aff:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101b03:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101b07:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101b0b:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101b0f:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101b13:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101b17:	48 89 c7             	mov    %rax,%rdi
  101b1a:	e8 3a ff ff ff       	call   101a59 <vsnprintf>
  101b1f:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101b22:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101b25:	c9                   	leave  
  101b26:	c3                   	ret    

0000000000101b27 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101b27:	f3 0f 1e fa          	endbr64 
  101b2b:	55                   	push   %rbp
  101b2c:	48 89 e5             	mov    %rsp,%rbp
  101b2f:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101b33:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101b3a:	eb 1a                	jmp    101b56 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101b3c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101b3f:	48 98                	cltq   
  101b41:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101b45:	48 8d 05 b4 64 fb ff 	lea    -0x49b4c(%rip),%rax        # b8000 <console>
  101b4c:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101b52:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101b56:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101b5d:	7e dd                	jle    101b3c <console_clear+0x15>
    }
    cursorpos = 0;
  101b5f:	c7 05 93 74 fb ff 00 	movl   $0x0,-0x48b6d(%rip)        # b8ffc <cursorpos>
  101b66:	00 00 00 
}
  101b69:	90                   	nop
  101b6a:	c9                   	leave  
  101b6b:	c3                   	ret    
