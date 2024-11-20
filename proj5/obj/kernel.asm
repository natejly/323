
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	push   $0x0
        popfq
   4000c:	9d                   	popf   
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmp    40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	push   $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	push   $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	push   $0x0
        pushq $32
   40038:	6a 20                	push   $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	push   $0x0
        pushq $48
   4003e:	6a 30                	push   $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	push   $0x0
        pushq $49
   40044:	6a 31                	push   $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	push   $0x0
        pushq $50
   4004a:	6a 32                	push   $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	push   $0x0
        pushq $51
   40050:	6a 33                	push   $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	push   $0x0
        pushq $52
   40056:	6a 34                	push   $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	push   $0x0
        pushq $53
   4005c:	6a 35                	push   $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	push   $0x0
        pushq $54
   40062:	6a 36                	push   $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	push   $0x0
        pushq $55
   40068:	6a 37                	push   $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	push   $0x0
        pushq $56
   4006e:	6a 38                	push   $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	push   $0x0
        pushq $57
   40074:	6a 39                	push   $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	push   $0x0
        pushq $58
   4007a:	6a 3a                	push   $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	push   $0x0
        pushq $59
   40080:	6a 3b                	push   $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	push   $0x0
        pushq $60
   40086:	6a 3c                	push   $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	push   $0x0
        pushq $61
   4008c:	6a 3d                	push   $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	push   $0x0
        pushq $62
   40092:	6a 3e                	push   $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	push   $0x0
        pushq $63
   40098:	6a 3f                	push   $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	push   $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	push   %gs
        pushq %fs
   400a2:	0f a0                	push   %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 d5 0c 00 00       	call   40d98 <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	pop    %fs
        popq %gs
   400df:	0f a9                	pop    %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

static void process_setup(pid_t pid, int program_number);

void kernel(const char* command) {
   40167:	f3 0f 1e fa          	endbr64 
   4016b:	55                   	push   %rbp
   4016c:	48 89 e5             	mov    %rsp,%rbp
   4016f:	48 83 ec 20          	sub    $0x20,%rsp
   40173:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40177:	e8 6a 1c 00 00       	call   41de6 <hardware_init>
    pageinfo_init();
   4017c:	e8 6a 11 00 00       	call   412eb <pageinfo_init>
    console_clear();
   40181:	e8 bc 49 00 00       	call   44b42 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 be 21 00 00       	call   4234e <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 7f 1e 01 00 	lea    0x11e7f(%rip),%rax        # 52020 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 e4 39 00 00       	call   43b8d <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401b0:	eb 4d                	jmp    401ff <kernel+0x98>
        processes[i].p_pid = i;
   401b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401b5:	48 63 d0             	movslq %eax,%rdx
   401b8:	48 89 d0             	mov    %rdx,%rax
   401bb:	48 c1 e0 03          	shl    $0x3,%rax
   401bf:	48 29 d0             	sub    %rdx,%rax
   401c2:	48 c1 e0 05          	shl    $0x5,%rax
   401c6:	48 89 c1             	mov    %rax,%rcx
   401c9:	48 8d 15 50 1e 01 00 	lea    0x11e50(%rip),%rdx        # 52020 <processes>
   401d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401d3:	89 04 11             	mov    %eax,(%rcx,%rdx,1)
        processes[i].p_state = P_FREE;
   401d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401d9:	48 63 d0             	movslq %eax,%rdx
   401dc:	48 89 d0             	mov    %rdx,%rax
   401df:	48 c1 e0 03          	shl    $0x3,%rax
   401e3:	48 29 d0             	sub    %rdx,%rax
   401e6:	48 c1 e0 05          	shl    $0x5,%rax
   401ea:	48 89 c2             	mov    %rax,%rdx
   401ed:	48 8d 05 f4 1e 01 00 	lea    0x11ef4(%rip),%rax        # 520e8 <processes+0xc8>
   401f4:	c7 04 02 00 00 00 00 	movl   $0x0,(%rdx,%rax,1)
    for (pid_t i = 0; i < NPROC; i++) {
   401fb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ff:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40203:	7e ad                	jle    401b2 <kernel+0x4b>
    }

    if (command && strcmp(command, "fork") == 0) {
   40205:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4020a:	74 2e                	je     4023a <kernel+0xd3>
   4020c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40210:	48 8d 15 89 49 00 00 	lea    0x4989(%rip),%rdx        # 44ba0 <console_clear+0x5e>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 74 3a 00 00       	call   43c96 <strcmp>
   40222:	85 c0                	test   %eax,%eax
   40224:	75 14                	jne    4023a <kernel+0xd3>
        process_setup(1, 4);
   40226:	be 04 00 00 00       	mov    $0x4,%esi
   4022b:	bf 01 00 00 00       	mov    $0x1,%edi
   40230:	e8 5c 03 00 00       	call   40591 <process_setup>
   40235:	e9 d1 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4023a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4023f:	74 2e                	je     4026f <kernel+0x108>
   40241:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40245:	48 8d 15 59 49 00 00 	lea    0x4959(%rip),%rdx        # 44ba5 <console_clear+0x63>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 3f 3a 00 00       	call   43c96 <strcmp>
   40257:	85 c0                	test   %eax,%eax
   40259:	75 14                	jne    4026f <kernel+0x108>
        process_setup(1, 5);
   4025b:	be 05 00 00 00       	mov    $0x5,%esi
   40260:	bf 01 00 00 00       	mov    $0x1,%edi
   40265:	e8 27 03 00 00       	call   40591 <process_setup>
   4026a:	e9 9c 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test") == 0) {
   4026f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40274:	74 2b                	je     402a1 <kernel+0x13a>
   40276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4027a:	48 8d 15 2d 49 00 00 	lea    0x492d(%rip),%rdx        # 44bae <console_clear+0x6c>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 0a 3a 00 00       	call   43c96 <strcmp>
   4028c:	85 c0                	test   %eax,%eax
   4028e:	75 11                	jne    402a1 <kernel+0x13a>
        process_setup(1, 6);
   40290:	be 06 00 00 00       	mov    $0x6,%esi
   40295:	bf 01 00 00 00       	mov    $0x1,%edi
   4029a:	e8 f2 02 00 00       	call   40591 <process_setup>
   4029f:	eb 6a                	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test2") == 0) {
   402a1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a6:	74 3e                	je     402e6 <kernel+0x17f>
   402a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402ac:	48 8d 15 00 49 00 00 	lea    0x4900(%rip),%rdx        # 44bb3 <console_clear+0x71>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 d8 39 00 00       	call   43c96 <strcmp>
   402be:	85 c0                	test   %eax,%eax
   402c0:	75 24                	jne    402e6 <kernel+0x17f>
        for (pid_t i = 1; i <= 2; ++i) {
   402c2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402c9:	eb 13                	jmp    402de <kernel+0x177>
            process_setup(i, 6);
   402cb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402ce:	be 06 00 00 00       	mov    $0x6,%esi
   402d3:	89 c7                	mov    %eax,%edi
   402d5:	e8 b7 02 00 00       	call   40591 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402da:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402de:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402e2:	7e e7                	jle    402cb <kernel+0x164>
   402e4:	eb 25                	jmp    4030b <kernel+0x1a4>
        }
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
   402e6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
   402ed:	eb 16                	jmp    40305 <kernel+0x19e>
            process_setup(i, i - 1);
   402ef:	8b 45 f4             	mov    -0xc(%rbp),%eax
   402f2:	8d 50 ff             	lea    -0x1(%rax),%edx
   402f5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   402f8:	89 d6                	mov    %edx,%esi
   402fa:	89 c7                	mov    %eax,%edi
   402fc:	e8 90 02 00 00       	call   40591 <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   40301:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40305:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   40309:	7e e4                	jle    402ef <kernel+0x188>
        }
    }
virtual_memory_map(kernel_pagetable, 0, 0,
   4030b:	48 8b 05 ee 4c 01 00 	mov    0x14cee(%rip),%rax        # 55000 <kernel_pagetable>
   40312:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40318:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4031d:	ba 00 00 00 00       	mov    $0x0,%edx
   40322:	be 00 00 00 00       	mov    $0x0,%esi
   40327:	48 89 c7             	mov    %rax,%rdi
   4032a:	e8 8c 2e 00 00       	call   431bb <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   4032f:	48 8d 15 ca 7c 07 00 	lea    0x77cca(%rip),%rdx        # b8000 <console>
   40336:	48 8d 35 c3 7c 07 00 	lea    0x77cc3(%rip),%rsi        # b8000 <console>
   4033d:	48 8b 05 bc 4c 01 00 	mov    0x14cbc(%rip),%rax        # 55000 <kernel_pagetable>
   40344:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4034a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4034f:	48 89 c7             	mov    %rax,%rdi
   40352:	e8 64 2e 00 00       	call   431bb <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    virtual_memory_map(kernel_pagetable, 
   40357:	48 8b 05 a2 4c 01 00 	mov    0x14ca2(%rip),%rax        # 55000 <kernel_pagetable>
   4035e:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40364:	b9 00 00 10 00       	mov    $0x100000,%ecx
   40369:	ba 00 00 10 00       	mov    $0x100000,%edx
   4036e:	be 00 00 10 00       	mov    $0x100000,%esi
   40373:	48 89 c7             	mov    %rax,%rdi
   40376:	e8 40 2e 00 00       	call   431bb <virtual_memory_map>
                    PROC_START_ADDR, PROC_START_ADDR,
                    MEMSIZE_PHYSICAL - PROC_START_ADDR,
                    PTE_P | PTE_W | PTE_U);
    // Switch to the first process using run()
    run(&processes[1]);
   4037b:	48 8d 05 7e 1d 01 00 	lea    0x11d7e(%rip),%rax        # 52100 <processes+0xe0>
   40382:	48 89 c7             	mov    %rax,%rdi
   40385:	e8 f6 0e 00 00       	call   41280 <run>

000000000004038a <reserve_page>:
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

// helper function for reserving pages which returns return its page address

x86_64_pagetable* reserve_page(int8_t owner) {
   4038a:	f3 0f 1e fa          	endbr64 
   4038e:	55                   	push   %rbp
   4038f:	48 89 e5             	mov    %rsp,%rbp
   40392:	48 83 ec 18          	sub    $0x18,%rsp
   40396:	89 f8                	mov    %edi,%eax
   40398:	88 45 ec             	mov    %al,-0x14(%rbp)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4039b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   403a2:	00 
   403a3:	eb 5c                	jmp    40401 <reserve_page+0x77>
        int pn = PAGENUMBER(addr);
   403a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403a9:	48 c1 e8 0c          	shr    $0xc,%rax
   403ad:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (pageinfo[pn].refcount == 0) {
   403b0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   403b3:	48 98                	cltq   
   403b5:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   403b9:	48 8d 05 81 2a 01 00 	lea    0x12a81(%rip),%rax        # 52e41 <pageinfo+0x1>
   403c0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   403c4:	84 c0                	test   %al,%al
   403c6:	75 31                	jne    403f9 <reserve_page+0x6f>
            pageinfo[pn].owner = owner;
   403c8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   403cb:	48 98                	cltq   
   403cd:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   403d1:	48 8d 15 68 2a 01 00 	lea    0x12a68(%rip),%rdx        # 52e40 <pageinfo>
   403d8:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
   403dc:	88 04 11             	mov    %al,(%rcx,%rdx,1)
            pageinfo[pn].refcount = 1;
   403df:	8b 45 f4             	mov    -0xc(%rbp),%eax
   403e2:	48 98                	cltq   
   403e4:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   403e8:	48 8d 05 52 2a 01 00 	lea    0x12a52(%rip),%rax        # 52e41 <pageinfo+0x1>
   403ef:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
            // memset((void*) addr, 0, PAGESIZE);
            return (x86_64_pagetable*) addr; 
   403f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403f7:	eb 17                	jmp    40410 <reserve_page+0x86>
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   403f9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40400:	00 
   40401:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40408:	00 
   40409:	76 9a                	jbe    403a5 <reserve_page+0x1b>
        }
    }
    return NULL;
   4040b:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40410:	c9                   	leave  
   40411:	c3                   	ret    

0000000000040412 <find_page>:
uintptr_t find_page(int8_t owner) {
   40412:	f3 0f 1e fa          	endbr64 
   40416:	55                   	push   %rbp
   40417:	48 89 e5             	mov    %rsp,%rbp
   4041a:	48 83 ec 20          	sub    $0x20,%rsp
   4041e:	89 f8                	mov    %edi,%eax
   40420:	88 45 ec             	mov    %al,-0x14(%rbp)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40423:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4042a:	00 
   4042b:	eb 43                	jmp    40470 <find_page+0x5e>
        int pn = PAGENUMBER(addr);
   4042d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40431:	48 c1 e8 0c          	shr    $0xc,%rax
   40435:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (pageinfo[pn].refcount == 0) {
   40438:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4043b:	48 98                	cltq   
   4043d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40441:	48 8d 05 f9 29 01 00 	lea    0x129f9(%rip),%rax        # 52e41 <pageinfo+0x1>
   40448:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4044c:	84 c0                	test   %al,%al
   4044e:	75 18                	jne    40468 <find_page+0x56>
            assign_physical_page(addr, owner);
   40450:	0f be 55 ec          	movsbl -0x14(%rbp),%edx
   40454:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40458:	89 d6                	mov    %edx,%esi
   4045a:	48 89 c7             	mov    %rax,%rdi
   4045d:	e8 97 02 00 00       	call   406f9 <assign_physical_page>
            return addr; 
   40462:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40466:	eb 17                	jmp    4047f <find_page+0x6d>
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40468:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4046f:	00 
   40470:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40477:	00 
   40478:	76 b3                	jbe    4042d <find_page+0x1b>
        }
    }
    return 0; 
   4047a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4047f:	c9                   	leave  
   40480:	c3                   	ret    

0000000000040481 <make_pages>:

x86_64_pagetable* make_pages(pid_t pid){
   40481:	f3 0f 1e fa          	endbr64 
   40485:	55                   	push   %rbp
   40486:	48 89 e5             	mov    %rsp,%rbp
   40489:	48 83 ec 60          	sub    $0x60,%rsp
   4048d:	89 7d ac             	mov    %edi,-0x54(%rbp)
    x86_64_pagetable *l4 = reserve_page(pid);
   40490:	8b 45 ac             	mov    -0x54(%rbp),%eax
   40493:	0f be c0             	movsbl %al,%eax
   40496:	89 c7                	mov    %eax,%edi
   40498:	e8 ed fe ff ff       	call   4038a <reserve_page>
   4049d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    x86_64_pagetable *l3 = reserve_page(pid);
   404a1:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404a4:	0f be c0             	movsbl %al,%eax
   404a7:	89 c7                	mov    %eax,%edi
   404a9:	e8 dc fe ff ff       	call   4038a <reserve_page>
   404ae:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    x86_64_pagetable *l2 = reserve_page(pid);
   404b2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404b5:	0f be c0             	movsbl %al,%eax
   404b8:	89 c7                	mov    %eax,%edi
   404ba:	e8 cb fe ff ff       	call   4038a <reserve_page>
   404bf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    x86_64_pagetable *l1_1 = reserve_page(pid);
   404c3:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404c6:	0f be c0             	movsbl %al,%eax
   404c9:	89 c7                	mov    %eax,%edi
   404cb:	e8 ba fe ff ff       	call   4038a <reserve_page>
   404d0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    x86_64_pagetable *l1_0 = reserve_page(pid);
   404d4:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404d7:	0f be c0             	movsbl %al,%eax
   404da:	89 c7                	mov    %eax,%edi
   404dc:	e8 a9 fe ff ff       	call   4038a <reserve_page>
   404e1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

    l4->entry[0] = (x86_64_pageentry_t)l3 | PTE_P | PTE_W | PTE_U;
   404e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404e9:	48 83 c8 07          	or     $0x7,%rax
   404ed:	48 89 c2             	mov    %rax,%rdx
   404f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   404f4:	48 89 10             	mov    %rdx,(%rax)
    l3->entry[0] = (x86_64_pageentry_t)l2 | PTE_P | PTE_W | PTE_U;
   404f7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   404fb:	48 83 c8 07          	or     $0x7,%rax
   404ff:	48 89 c2             	mov    %rax,%rdx
   40502:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40506:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[0] = (x86_64_pageentry_t)l1_0 | PTE_P | PTE_W | PTE_U;
   40509:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4050d:	48 83 c8 07          	or     $0x7,%rax
   40511:	48 89 c2             	mov    %rax,%rdx
   40514:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40518:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[1] = (x86_64_pageentry_t)l1_1 | PTE_P | PTE_W | PTE_U;
   4051b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4051f:	48 83 c8 07          	or     $0x7,%rax
   40523:	48 89 c2             	mov    %rax,%rdx
   40526:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4052a:	48 89 50 08          	mov    %rdx,0x8(%rax)

    for (uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE) {
   4052e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40535:	00 
   40536:	eb 49                	jmp    40581 <make_pages+0x100>
        vamapping vam = virtual_memory_lookup(kernel_pagetable, va);
   40538:	48 8b 0d c1 4a 01 00 	mov    0x14ac1(%rip),%rcx        # 55000 <kernel_pagetable>
   4053f:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40543:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40547:	48 89 ce             	mov    %rcx,%rsi
   4054a:	48 89 c7             	mov    %rax,%rdi
   4054d:	e8 b3 30 00 00       	call   43605 <virtual_memory_lookup>
        if (vam.pn != -1) {
   40552:	8b 45 b8             	mov    -0x48(%rbp),%eax
   40555:	83 f8 ff             	cmp    $0xffffffff,%eax
   40558:	74 1f                	je     40579 <make_pages+0xf8>
            virtual_memory_map(l4, va, vam.pa, PAGESIZE, PTE_P | PTE_W );
   4055a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4055e:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40562:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40566:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   4056c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40571:	48 89 c7             	mov    %rax,%rdi
   40574:	e8 42 2c 00 00       	call   431bb <virtual_memory_map>
    for (uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE) {
   40579:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40580:	00 
   40581:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   40588:	00 
   40589:	76 ad                	jbe    40538 <make_pages+0xb7>
        }
    }
    return l4;
   4058b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
   4058f:	c9                   	leave  
   40590:	c3                   	ret    

0000000000040591 <process_setup>:

void process_setup(pid_t pid, int program_number) {
   40591:	f3 0f 1e fa          	endbr64 
   40595:	55                   	push   %rbp
   40596:	48 89 e5             	mov    %rsp,%rbp
   40599:	48 83 ec 20          	sub    $0x20,%rsp
   4059d:	89 7d ec             	mov    %edi,-0x14(%rbp)
   405a0:	89 75 e8             	mov    %esi,-0x18(%rbp)
    process_init(&processes[pid], 0);
   405a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   405a6:	48 63 d0             	movslq %eax,%rdx
   405a9:	48 89 d0             	mov    %rdx,%rax
   405ac:	48 c1 e0 03          	shl    $0x3,%rax
   405b0:	48 29 d0             	sub    %rdx,%rax
   405b3:	48 c1 e0 05          	shl    $0x5,%rax
   405b7:	48 8d 15 62 1a 01 00 	lea    0x11a62(%rip),%rdx        # 52020 <processes>
   405be:	48 01 d0             	add    %rdx,%rax
   405c1:	be 00 00 00 00       	mov    $0x0,%esi
   405c6:	48 89 c7             	mov    %rax,%rdi
   405c9:	e8 33 20 00 00       	call   42601 <process_init>

    x86_64_pagetable *l4 = make_pages(pid);
   405ce:	8b 45 ec             	mov    -0x14(%rbp),%eax
   405d1:	89 c7                	mov    %eax,%edi
   405d3:	e8 a9 fe ff ff       	call   40481 <make_pages>
   405d8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

    processes[pid].p_pagetable = l4;
   405dc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   405df:	48 63 d0             	movslq %eax,%rdx
   405e2:	48 89 d0             	mov    %rdx,%rax
   405e5:	48 c1 e0 03          	shl    $0x3,%rax
   405e9:	48 29 d0             	sub    %rdx,%rax
   405ec:	48 c1 e0 05          	shl    $0x5,%rax
   405f0:	48 89 c1             	mov    %rax,%rcx
   405f3:	48 8d 15 f6 1a 01 00 	lea    0x11af6(%rip),%rdx        # 520f0 <processes+0xd0>
   405fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405fe:	48 89 04 11          	mov    %rax,(%rcx,%rdx,1)
    // FIXME
    // virtual_memory_map(l4, 0, 0,
    //                PROC_START_ADDR, PTE_P | PTE_W); 
    virtual_memory_map(l4, CONSOLE_ADDR, CONSOLE_ADDR,
   40602:	48 8d 15 f7 79 07 00 	lea    0x779f7(%rip),%rdx        # b8000 <console>
   40609:	48 8d 35 f0 79 07 00 	lea    0x779f0(%rip),%rsi        # b8000 <console>
   40610:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40614:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4061a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4061f:	48 89 c7             	mov    %rax,%rdi
   40622:	e8 94 2b 00 00       	call   431bb <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    int r = program_load(&processes[pid], program_number, NULL);
   40627:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4062a:	48 63 d0             	movslq %eax,%rdx
   4062d:	48 89 d0             	mov    %rdx,%rax
   40630:	48 c1 e0 03          	shl    $0x3,%rax
   40634:	48 29 d0             	sub    %rdx,%rax
   40637:	48 c1 e0 05          	shl    $0x5,%rax
   4063b:	48 8d 15 de 19 01 00 	lea    0x119de(%rip),%rdx        # 52020 <processes>
   40642:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
   40646:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40649:	ba 00 00 00 00       	mov    $0x0,%edx
   4064e:	89 c6                	mov    %eax,%esi
   40650:	48 89 cf             	mov    %rcx,%rdi
   40653:	e8 a8 30 00 00       	call   43700 <program_load>
   40658:	89 45 f4             	mov    %eax,-0xc(%rbp)
    assert(r >= 0);
   4065b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4065f:	79 1e                	jns    4067f <process_setup+0xee>
   40661:	48 8d 05 51 45 00 00 	lea    0x4551(%rip),%rax        # 44bb9 <console_clear+0x77>
   40668:	48 89 c2             	mov    %rax,%rdx
   4066b:	be be 00 00 00       	mov    $0xbe,%esi
   40670:	48 8d 05 49 45 00 00 	lea    0x4549(%rip),%rax        # 44bc0 <console_clear+0x7e>
   40677:	48 89 c7             	mov    %rax,%rdi
   4067a:	e8 b8 27 00 00       	call   42e37 <assert_fail>

    virtual_memory_map(l4, MEMSIZE_VIRTUAL - PAGESIZE, find_page(pid), PAGESIZE, PTE_P | PTE_W | PTE_U);
   4067f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40682:	0f be c0             	movsbl %al,%eax
   40685:	89 c7                	mov    %eax,%edi
   40687:	e8 86 fd ff ff       	call   40412 <find_page>
   4068c:	48 89 c2             	mov    %rax,%rdx
   4068f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40693:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40699:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4069e:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   406a3:	48 89 c7             	mov    %rax,%rdi
   406a6:	e8 10 2b 00 00       	call   431bb <virtual_memory_map>
    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL;
   406ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
   406ae:	48 63 d0             	movslq %eax,%rdx
   406b1:	48 89 d0             	mov    %rdx,%rax
   406b4:	48 c1 e0 03          	shl    $0x3,%rax
   406b8:	48 29 d0             	sub    %rdx,%rax
   406bb:	48 c1 e0 05          	shl    $0x5,%rax
   406bf:	48 89 c2             	mov    %rax,%rdx
   406c2:	48 8d 05 0f 1a 01 00 	lea    0x11a0f(%rip),%rax        # 520d8 <processes+0xb8>
   406c9:	48 c7 04 02 00 00 30 	movq   $0x300000,(%rdx,%rax,1)
   406d0:	00 

    processes[pid].p_state = P_RUNNABLE;
   406d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   406d4:	48 63 d0             	movslq %eax,%rdx
   406d7:	48 89 d0             	mov    %rdx,%rax
   406da:	48 c1 e0 03          	shl    $0x3,%rax
   406de:	48 29 d0             	sub    %rdx,%rax
   406e1:	48 c1 e0 05          	shl    $0x5,%rax
   406e5:	48 89 c2             	mov    %rax,%rdx
   406e8:	48 8d 05 f9 19 01 00 	lea    0x119f9(%rip),%rax        # 520e8 <processes+0xc8>
   406ef:	c7 04 02 01 00 00 00 	movl   $0x1,(%rdx,%rax,1)
}
   406f6:	90                   	nop
   406f7:	c9                   	leave  
   406f8:	c3                   	ret    

00000000000406f9 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   406f9:	f3 0f 1e fa          	endbr64 
   406fd:	55                   	push   %rbp
   406fe:	48 89 e5             	mov    %rsp,%rbp
   40701:	48 83 ec 10          	sub    $0x10,%rsp
   40705:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40709:	89 f0                	mov    %esi,%eax
   4070b:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   4070e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40712:	25 ff 0f 00 00       	and    $0xfff,%eax
   40717:	48 85 c0             	test   %rax,%rax
   4071a:	75 27                	jne    40743 <assign_physical_page+0x4a>
        || addr >= MEMSIZE_PHYSICAL
   4071c:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40723:	00 
   40724:	77 1d                	ja     40743 <assign_physical_page+0x4a>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40726:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4072a:	48 c1 e8 0c          	shr    $0xc,%rax
   4072e:	48 98                	cltq   
   40730:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40734:	48 8d 05 06 27 01 00 	lea    0x12706(%rip),%rax        # 52e41 <pageinfo+0x1>
   4073b:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4073f:	84 c0                	test   %al,%al
   40741:	74 07                	je     4074a <assign_physical_page+0x51>
        return -1;
   40743:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40748:	eb 3a                	jmp    40784 <assign_physical_page+0x8b>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   4074a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4074e:	48 c1 e8 0c          	shr    $0xc,%rax
   40752:	48 98                	cltq   
   40754:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40758:	48 8d 05 e2 26 01 00 	lea    0x126e2(%rip),%rax        # 52e41 <pageinfo+0x1>
   4075f:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40763:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40767:	48 c1 e8 0c          	shr    $0xc,%rax
   4076b:	48 98                	cltq   
   4076d:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40771:	48 8d 15 c8 26 01 00 	lea    0x126c8(%rip),%rdx        # 52e40 <pageinfo>
   40778:	0f b6 45 f4          	movzbl -0xc(%rbp),%eax
   4077c:	88 04 11             	mov    %al,(%rcx,%rdx,1)
        return 0;
   4077f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40784:	c9                   	leave  
   40785:	c3                   	ret    

0000000000040786 <syscall_mapping>:

void syscall_mapping(proc* p){
   40786:	f3 0f 1e fa          	endbr64 
   4078a:	55                   	push   %rbp
   4078b:	48 89 e5             	mov    %rsp,%rbp
   4078e:	48 83 ec 70          	sub    $0x70,%rsp
   40792:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40796:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4079a:	48 8b 40 38          	mov    0x38(%rax),%rax
   4079e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   407a2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407a6:	48 8b 40 30          	mov    0x30(%rax),%rax
   407aa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   407ae:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407b2:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407b9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   407bd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407c1:	48 89 ce             	mov    %rcx,%rsi
   407c4:	48 89 c7             	mov    %rax,%rdi
   407c7:	e8 39 2e 00 00       	call   43605 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   407cc:	8b 45 e0             	mov    -0x20(%rbp),%eax
   407cf:	48 98                	cltq   
   407d1:	83 e0 06             	and    $0x6,%eax
   407d4:	48 83 f8 06          	cmp    $0x6,%rax
   407d8:	75 73                	jne    4084d <syscall_mapping+0xc7>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   407da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407de:	48 83 c0 17          	add    $0x17,%rax
   407e2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   407e6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407ea:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407f1:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   407f5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   407f9:	48 89 ce             	mov    %rcx,%rsi
   407fc:	48 89 c7             	mov    %rax,%rdi
   407ff:	e8 01 2e 00 00       	call   43605 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40804:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40807:	48 98                	cltq   
   40809:	83 e0 03             	and    $0x3,%eax
   4080c:	48 83 f8 03          	cmp    $0x3,%rax
   40810:	75 3e                	jne    40850 <syscall_mapping+0xca>
        return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40812:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40816:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4081d:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40821:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40825:	48 89 ce             	mov    %rcx,%rsi
   40828:	48 89 c7             	mov    %rax,%rdi
   4082b:	e8 d5 2d 00 00       	call   43605 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40830:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40834:	48 89 c1             	mov    %rax,%rcx
   40837:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4083b:	ba 18 00 00 00       	mov    $0x18,%edx
   40840:	48 89 c6             	mov    %rax,%rsi
   40843:	48 89 cf             	mov    %rcx,%rdi
   40846:	e8 3c 32 00 00       	call   43a87 <memcpy>
   4084b:	eb 04                	jmp    40851 <syscall_mapping+0xcb>
        return;
   4084d:	90                   	nop
   4084e:	eb 01                	jmp    40851 <syscall_mapping+0xcb>
        return;
   40850:	90                   	nop
}
   40851:	c9                   	leave  
   40852:	c3                   	ret    

0000000000040853 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40853:	f3 0f 1e fa          	endbr64 
   40857:	55                   	push   %rbp
   40858:	48 89 e5             	mov    %rsp,%rbp
   4085b:	48 83 ec 18          	sub    $0x18,%rsp
   4085f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40863:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40867:	48 8b 40 38          	mov    0x38(%rax),%rax
   4086b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   4086e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40872:	75 14                	jne    40888 <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   40874:	0f b6 05 85 57 00 00 	movzbl 0x5785(%rip),%eax        # 46000 <disp_global>
   4087b:	84 c0                	test   %al,%al
   4087d:	0f 94 c0             	sete   %al
   40880:	88 05 7a 57 00 00    	mov    %al,0x577a(%rip)        # 46000 <disp_global>
   40886:	eb 36                	jmp    408be <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40888:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4088c:	78 2f                	js     408bd <syscall_mem_tog+0x6a>
   4088e:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40892:	7f 29                	jg     408bd <syscall_mem_tog+0x6a>
   40894:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40898:	8b 00                	mov    (%rax),%eax
   4089a:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4089d:	75 1e                	jne    408bd <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   4089f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408a3:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   408aa:	84 c0                	test   %al,%al
   408ac:	0f 94 c0             	sete   %al
   408af:	89 c2                	mov    %eax,%edx
   408b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408b5:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   408bb:	eb 01                	jmp    408be <syscall_mem_tog+0x6b>
            return;
   408bd:	90                   	nop
    }
}
   408be:	c9                   	leave  
   408bf:	c3                   	ret    

00000000000408c0 <exit1>:
//    the kernel's stack, then jumping to kernel assembly code (in
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.
void exit1(proc* p){
   408c0:	f3 0f 1e fa          	endbr64 
   408c4:	55                   	push   %rbp
   408c5:	48 89 e5             	mov    %rsp,%rbp
   408c8:	48 83 ec 60          	sub    $0x60,%rsp
   408cc:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
        for (uintptr_t addr = PROC_START_ADDR; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE){
   408d0:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   408d7:	00 
   408d8:	e9 86 00 00 00       	jmp    40963 <exit1+0xa3>
            vamapping vam = virtual_memory_lookup(p->p_pagetable, addr);
   408dd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   408e1:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   408e8:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   408ec:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   408f0:	48 89 ce             	mov    %rcx,%rsi
   408f3:	48 89 c7             	mov    %rax,%rdi
   408f6:	e8 0a 2d 00 00       	call   43605 <virtual_memory_lookup>
            // if (vam.pa == (uintptr_t) -1 ){
            //     continue;
            // }
            if (vam.pn < 0){
   408fb:	8b 45 b0             	mov    -0x50(%rbp),%eax
   408fe:	85 c0                	test   %eax,%eax
   40900:	78 58                	js     4095a <exit1+0x9a>
                continue;
            }
            pageinfo[vam.pn].refcount--;
   40902:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40905:	48 63 d0             	movslq %eax,%rdx
   40908:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   4090c:	48 8d 15 2e 25 01 00 	lea    0x1252e(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40913:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40917:	83 ea 01             	sub    $0x1,%edx
   4091a:	89 d1                	mov    %edx,%ecx
   4091c:	48 98                	cltq   
   4091e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40922:	48 8d 05 18 25 01 00 	lea    0x12518(%rip),%rax        # 52e41 <pageinfo+0x1>
   40929:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
            if (pageinfo[vam.pn].refcount == 0)
   4092c:	8b 45 b0             	mov    -0x50(%rbp),%eax
   4092f:	48 98                	cltq   
   40931:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40935:	48 8d 05 05 25 01 00 	lea    0x12505(%rip),%rax        # 52e41 <pageinfo+0x1>
   4093c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40940:	84 c0                	test   %al,%al
   40942:	75 17                	jne    4095b <exit1+0x9b>
                {
                pageinfo[vam.pn].owner = PO_FREE;
   40944:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40947:	48 98                	cltq   
   40949:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4094d:	48 8d 05 ec 24 01 00 	lea    0x124ec(%rip),%rax        # 52e40 <pageinfo>
   40954:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
   40958:	eb 01                	jmp    4095b <exit1+0x9b>
                continue;
   4095a:	90                   	nop
        for (uintptr_t addr = PROC_START_ADDR; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE){
   4095b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40962:	00 
   40963:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4096a:	00 
   4096b:	0f 86 6c ff ff ff    	jbe    408dd <exit1+0x1d>
            }
        }
        x86_64_pagetable* page_tables[5];

        page_tables[0] = p->p_pagetable;
   40971:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40975:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4097c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        page_tables[1] = (x86_64_pagetable*) PTE_ADDR(page_tables[0]->entry[0]); // L3 
   40980:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40984:	48 8b 00             	mov    (%rax),%rax
   40987:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4098d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        page_tables[2] = (x86_64_pagetable*) PTE_ADDR(page_tables[1]->entry[0]); // L2
   40991:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40995:	48 8b 00             	mov    (%rax),%rax
   40998:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4099e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        page_tables[3] = (x86_64_pagetable*) PTE_ADDR(page_tables[2]->entry[0]); // L1_0
   409a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   409a6:	48 8b 00             	mov    (%rax),%rax
   409a9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   409af:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        page_tables[4] = (x86_64_pagetable*) PTE_ADDR(page_tables[2]->entry[1]); // L1_1
   409b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   409b7:	48 8b 40 08          	mov    0x8(%rax),%rax
   409bb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   409c1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    
        for (int i = 0; i < 5; ++i) {
   409c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   409cc:	eb 4c                	jmp    40a1a <exit1+0x15a>
        if (page_tables[i]) {
   409ce:	8b 45 f4             	mov    -0xc(%rbp),%eax
   409d1:	48 98                	cltq   
   409d3:	48 8b 44 c5 c8       	mov    -0x38(%rbp,%rax,8),%rax
   409d8:	48 85 c0             	test   %rax,%rax
   409db:	74 39                	je     40a16 <exit1+0x156>
            int pn = PAGENUMBER(page_tables[i]);
   409dd:	8b 45 f4             	mov    -0xc(%rbp),%eax
   409e0:	48 98                	cltq   
   409e2:	48 8b 44 c5 c8       	mov    -0x38(%rbp,%rax,8),%rax
   409e7:	48 c1 e8 0c          	shr    $0xc,%rax
   409eb:	89 45 f0             	mov    %eax,-0x10(%rbp)
                pageinfo[pn].owner = PO_FREE;
   409ee:	8b 45 f0             	mov    -0x10(%rbp),%eax
   409f1:	48 98                	cltq   
   409f3:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   409f7:	48 8d 05 42 24 01 00 	lea    0x12442(%rip),%rax        # 52e40 <pageinfo>
   409fe:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[pn].refcount = 0;
   40a02:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40a05:	48 98                	cltq   
   40a07:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40a0b:	48 8d 05 2f 24 01 00 	lea    0x1242f(%rip),%rax        # 52e41 <pageinfo+0x1>
   40a12:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        for (int i = 0; i < 5; ++i) {
   40a16:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40a1a:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   40a1e:	7e ae                	jle    409ce <exit1+0x10e>
        }
    }
            p->p_state = P_FREE;
   40a20:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40a24:	c7 80 c8 00 00 00 00 	movl   $0x0,0xc8(%rax)
   40a2b:	00 00 00 

}
   40a2e:	90                   	nop
   40a2f:	c9                   	leave  
   40a30:	c3                   	ret    

0000000000040a31 <fork1>:
int fork1(void){
   40a31:	f3 0f 1e fa          	endbr64 
   40a35:	55                   	push   %rbp
   40a36:	48 89 e5             	mov    %rsp,%rbp
   40a39:	48 83 ec 70          	sub    $0x70,%rsp
    // find free
    pid_t child_pid = -1;
   40a3d:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)

    for (pid_t i = 1; i < NPROC; i++) {
   40a44:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   40a4b:	eb 31                	jmp    40a7e <fork1+0x4d>
        if (processes[i].p_state == P_FREE) {
   40a4d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40a50:	48 63 d0             	movslq %eax,%rdx
   40a53:	48 89 d0             	mov    %rdx,%rax
   40a56:	48 c1 e0 03          	shl    $0x3,%rax
   40a5a:	48 29 d0             	sub    %rdx,%rax
   40a5d:	48 c1 e0 05          	shl    $0x5,%rax
   40a61:	48 89 c2             	mov    %rax,%rdx
   40a64:	48 8d 05 7d 16 01 00 	lea    0x1167d(%rip),%rax        # 520e8 <processes+0xc8>
   40a6b:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40a6e:	85 c0                	test   %eax,%eax
   40a70:	75 08                	jne    40a7a <fork1+0x49>
            child_pid = i;
   40a72:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40a75:	89 45 fc             	mov    %eax,-0x4(%rbp)
            // current->p_registers.reg_rax = -1;
            break;
   40a78:	eb 0a                	jmp    40a84 <fork1+0x53>
    for (pid_t i = 1; i < NPROC; i++) {
   40a7a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40a7e:	83 7d f8 0f          	cmpl   $0xf,-0x8(%rbp)
   40a82:	7e c9                	jle    40a4d <fork1+0x1c>
        }
    }
    // no ree
    if (child_pid == -1) {
   40a84:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40a88:	75 1b                	jne    40aa5 <fork1+0x74>
        current->p_registers.reg_rax = child_pid;
   40a8a:	48 8b 05 6f 15 01 00 	mov    0x1156f(%rip),%rax        # 52000 <current>
   40a91:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40a94:	48 63 d2             	movslq %edx,%rdx
   40a97:	48 89 50 08          	mov    %rdx,0x8(%rax)
        return -1;
   40a9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40aa0:	e9 f1 02 00 00       	jmp    40d96 <fork1+0x365>
    }

    // reserve
    proc* parent = current;
   40aa5:	48 8b 05 54 15 01 00 	mov    0x11554(%rip),%rax        # 52000 <current>
   40aac:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    proc* child = &processes[child_pid];
   40ab0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ab3:	48 63 d0             	movslq %eax,%rdx
   40ab6:	48 89 d0             	mov    %rdx,%rax
   40ab9:	48 c1 e0 03          	shl    $0x3,%rax
   40abd:	48 29 d0             	sub    %rdx,%rax
   40ac0:	48 c1 e0 05          	shl    $0x5,%rax
   40ac4:	48 8d 15 55 15 01 00 	lea    0x11555(%rip),%rdx        # 52020 <processes>
   40acb:	48 01 d0             	add    %rdx,%rax
   40ace:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    process_init(child, 0);
   40ad2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40ad6:	be 00 00 00 00       	mov    $0x0,%esi
   40adb:	48 89 c7             	mov    %rax,%rdi
   40ade:	e8 1e 1b 00 00       	call   42601 <process_init>

    //allocate
    x86_64_pagetable* child_table = make_pages(child_pid);
   40ae3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ae6:	89 c7                	mov    %eax,%edi
   40ae8:	e8 94 f9 ff ff       	call   40481 <make_pages>
   40aed:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    if (!child_table) {
   40af1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   40af6:	75 25                	jne    40b1d <fork1+0xec>
        exit1(child);
   40af8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40afc:	48 89 c7             	mov    %rax,%rdi
   40aff:	e8 bc fd ff ff       	call   408c0 <exit1>
        current->p_registers.reg_rax = -1;
   40b04:	48 8b 05 f5 14 01 00 	mov    0x114f5(%rip),%rax        # 52000 <current>
   40b0b:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b12:	ff 
        return -1;
   40b13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40b18:	e9 79 02 00 00       	jmp    40d96 <fork1+0x365>
    }
    child->p_pagetable = child_table;
   40b1d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40b21:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40b25:	48 89 90 d0 00 00 00 	mov    %rdx,0xd0(%rax)
    // map console

    vamapping console_mapping = virtual_memory_lookup(parent->p_pagetable, CONSOLE_ADDR);
   40b2c:	48 8d 15 cd 74 07 00 	lea    0x774cd(%rip),%rdx        # b8000 <console>
   40b33:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40b37:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40b3e:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40b42:	48 89 ce             	mov    %rcx,%rsi
   40b45:	48 89 c7             	mov    %rax,%rdi
   40b48:	e8 b8 2a 00 00       	call   43605 <virtual_memory_lookup>
        if (console_mapping.pn != -1) {
   40b4d:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40b50:	83 f8 ff             	cmp    $0xffffffff,%eax
   40b53:	74 70                	je     40bc5 <fork1+0x194>
            pageinfo[console_mapping.pn].refcount++;
   40b55:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40b58:	48 63 d0             	movslq %eax,%rdx
   40b5b:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40b5f:	48 8d 15 db 22 01 00 	lea    0x122db(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40b66:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40b6a:	83 c2 01             	add    $0x1,%edx
   40b6d:	89 d1                	mov    %edx,%ecx
   40b6f:	48 98                	cltq   
   40b71:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40b75:	48 8d 05 c5 22 01 00 	lea    0x122c5(%rip),%rax        # 52e41 <pageinfo+0x1>
   40b7c:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
            if (virtual_memory_map(child_table, CONSOLE_ADDR, CONSOLE_ADDR, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   40b7f:	48 8d 15 7a 74 07 00 	lea    0x7747a(%rip),%rdx        # b8000 <console>
   40b86:	48 8d 35 73 74 07 00 	lea    0x77473(%rip),%rsi        # b8000 <console>
   40b8d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40b91:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40b97:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40b9c:	48 89 c7             	mov    %rax,%rdi
   40b9f:	e8 17 26 00 00       	call   431bb <virtual_memory_map>
   40ba4:	85 c0                	test   %eax,%eax
   40ba6:	79 1d                	jns    40bc5 <fork1+0x194>
            exit1(child);
   40ba8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40bac:	48 89 c7             	mov    %rax,%rdi
   40baf:	e8 0c fd ff ff       	call   408c0 <exit1>
            child_pid = -1;
   40bb4:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
            return -1;
   40bbb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40bc0:	e9 d1 01 00 00       	jmp    40d96 <fork1+0x365>
            }
    }
    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40bc5:	48 c7 45 f0 00 00 10 	movq   $0x100000,-0x10(%rbp)
   40bcc:	00 
   40bcd:	e9 68 01 00 00       	jmp    40d3a <fork1+0x309>
        vamapping parent_mapping = virtual_memory_lookup(parent->p_pagetable, va);
   40bd2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40bd6:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40bdd:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   40be1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40be5:	48 89 ce             	mov    %rcx,%rsi
   40be8:	48 89 c7             	mov    %rax,%rdi
   40beb:	e8 15 2a 00 00       	call   43605 <virtual_memory_lookup>
        // skip console and nonexistent pages
        if (va == CONSOLE_ADDR || parent_mapping.pn == -1) {
   40bf0:	48 8d 05 09 74 07 00 	lea    0x77409(%rip),%rax        # b8000 <console>
   40bf7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40bfb:	0f 84 30 01 00 00    	je     40d31 <fork1+0x300>
   40c01:	8b 45 98             	mov    -0x68(%rbp),%eax
   40c04:	83 f8 ff             	cmp    $0xffffffff,%eax
   40c07:	0f 84 24 01 00 00    	je     40d31 <fork1+0x300>
            continue; 
        }
        if (parent_mapping.perm & PTE_W) {
   40c0d:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40c10:	48 98                	cltq   
   40c12:	83 e0 02             	and    $0x2,%eax
   40c15:	48 85 c0             	test   %rax,%rax
   40c18:	0f 84 99 00 00 00    	je     40cb7 <fork1+0x286>
        // Allocate a new physical page for the child
            uintptr_t new_pa = find_page(child_pid);
   40c1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c21:	0f be c0             	movsbl %al,%eax
   40c24:	89 c7                	mov    %eax,%edi
   40c26:	e8 e7 f7 ff ff       	call   40412 <find_page>
   40c2b:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
            if (!new_pa) {
   40c2f:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   40c34:	75 1d                	jne    40c53 <fork1+0x222>
            exit1(child);
   40c36:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40c3a:	48 89 c7             	mov    %rax,%rdi
   40c3d:	e8 7e fc ff ff       	call   408c0 <exit1>
            child_pid = -1;
   40c42:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
            return -1;
   40c49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40c4e:	e9 43 01 00 00       	jmp    40d96 <fork1+0x365>
            }
            memcpy((void*) new_pa, (void*) parent_mapping.pa, PAGESIZE);
   40c53:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   40c57:	48 89 c1             	mov    %rax,%rcx
   40c5a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40c5e:	ba 00 10 00 00       	mov    $0x1000,%edx
   40c63:	48 89 ce             	mov    %rcx,%rsi
   40c66:	48 89 c7             	mov    %rax,%rdi
   40c69:	e8 19 2e 00 00       	call   43a87 <memcpy>
            int r = virtual_memory_map(child_table, va, new_pa, PAGESIZE, parent_mapping.perm);
   40c6e:	8b 4d a8             	mov    -0x58(%rbp),%ecx
   40c71:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40c75:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40c79:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40c7d:	41 89 c8             	mov    %ecx,%r8d
   40c80:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40c85:	48 89 c7             	mov    %rax,%rdi
   40c88:	e8 2e 25 00 00       	call   431bb <virtual_memory_map>
   40c8d:	89 45 cc             	mov    %eax,-0x34(%rbp)
            if (r < 0) {
   40c90:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
   40c94:	0f 89 98 00 00 00    	jns    40d32 <fork1+0x301>
                exit1(child);
   40c9a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40c9e:	48 89 c7             	mov    %rax,%rdi
   40ca1:	e8 1a fc ff ff       	call   408c0 <exit1>
                child_pid = -1;
   40ca6:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
                return -1;
   40cad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40cb2:	e9 df 00 00 00       	jmp    40d96 <fork1+0x365>

            }
        } else if (((parent_mapping.perm & (PTE_P | PTE_U)) == (PTE_P | PTE_U))) {
   40cb7:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40cba:	48 98                	cltq   
   40cbc:	83 e0 05             	and    $0x5,%eax
   40cbf:	48 83 f8 05          	cmp    $0x5,%rax
   40cc3:	75 6d                	jne    40d32 <fork1+0x301>
                
            if (virtual_memory_map(child_table, va, parent_mapping.pa, PAGESIZE, parent_mapping.perm) < 0) {
   40cc5:	8b 4d a8             	mov    -0x58(%rbp),%ecx
   40cc8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   40ccc:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40cd0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40cd4:	41 89 c8             	mov    %ecx,%r8d
   40cd7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40cdc:	48 89 c7             	mov    %rax,%rdi
   40cdf:	e8 d7 24 00 00       	call   431bb <virtual_memory_map>
   40ce4:	85 c0                	test   %eax,%eax
   40ce6:	79 1d                	jns    40d05 <fork1+0x2d4>
                exit1(child);            
   40ce8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40cec:	48 89 c7             	mov    %rax,%rdi
   40cef:	e8 cc fb ff ff       	call   408c0 <exit1>
                child_pid = -1;
   40cf4:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
                return -1;
   40cfb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40d00:	e9 91 00 00 00       	jmp    40d96 <fork1+0x365>
            }
            pageinfo[parent_mapping.pn].refcount++;
   40d05:	8b 45 98             	mov    -0x68(%rbp),%eax
   40d08:	48 63 d0             	movslq %eax,%rdx
   40d0b:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40d0f:	48 8d 15 2b 21 01 00 	lea    0x1212b(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40d16:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40d1a:	83 c2 01             	add    $0x1,%edx
   40d1d:	89 d1                	mov    %edx,%ecx
   40d1f:	48 98                	cltq   
   40d21:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40d25:	48 8d 05 15 21 01 00 	lea    0x12115(%rip),%rax        # 52e41 <pageinfo+0x1>
   40d2c:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
   40d2f:	eb 01                	jmp    40d32 <fork1+0x301>
            continue; 
   40d31:	90                   	nop
    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40d32:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   40d39:	00 
   40d3a:	48 81 7d f0 ff ff 2f 	cmpq   $0x2fffff,-0x10(%rbp)
   40d41:	00 
   40d42:	0f 86 8a fe ff ff    	jbe    40bd2 <fork1+0x1a1>
            // continue;
        }
    }
    child->p_registers = parent->p_registers;
   40d48:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d4c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40d50:	48 83 c0 08          	add    $0x8,%rax
   40d54:	48 83 c2 08          	add    $0x8,%rdx
   40d58:	b9 18 00 00 00       	mov    $0x18,%ecx
   40d5d:	48 89 c7             	mov    %rax,%rdi
   40d60:	48 89 d6             	mov    %rdx,%rsi
   40d63:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    child->p_registers.reg_rax = 0; 
   40d66:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d6a:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40d71:	00 
    child->p_state = P_RUNNABLE;
   40d72:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d76:	c7 80 c8 00 00 00 01 	movl   $0x1,0xc8(%rax)
   40d7d:	00 00 00 
    current->p_registers.reg_rax = child_pid;
   40d80:	48 8b 05 79 12 01 00 	mov    0x11279(%rip),%rax        # 52000 <current>
   40d87:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40d8a:	48 63 d2             	movslq %edx,%rdx
   40d8d:	48 89 50 08          	mov    %rdx,0x8(%rax)
    return 0;
   40d91:	b8 00 00 00 00       	mov    $0x0,%eax



}
   40d96:	c9                   	leave  
   40d97:	c3                   	ret    

0000000000040d98 <exception>:
void exception(x86_64_registers* reg) {
   40d98:	f3 0f 1e fa          	endbr64 
   40d9c:	55                   	push   %rbp
   40d9d:	48 89 e5             	mov    %rsp,%rbp
   40da0:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   40da7:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40dae:	48 8b 05 4b 12 01 00 	mov    0x1124b(%rip),%rax        # 52000 <current>
   40db5:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   40dbc:	48 83 c0 08          	add    $0x8,%rax
   40dc0:	48 89 d6             	mov    %rdx,%rsi
   40dc3:	ba 18 00 00 00       	mov    $0x18,%edx
   40dc8:	48 89 c7             	mov    %rax,%rdi
   40dcb:	48 89 d1             	mov    %rdx,%rcx
   40dce:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40dd1:	48 8b 05 28 42 01 00 	mov    0x14228(%rip),%rax        # 55000 <kernel_pagetable>
   40dd8:	48 89 c7             	mov    %rax,%rdi
   40ddb:	e8 69 22 00 00       	call   43049 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40de0:	8b 05 16 82 07 00    	mov    0x78216(%rip),%eax        # b8ffc <cursorpos>
   40de6:	89 c7                	mov    %eax,%edi
   40de8:	e8 e2 18 00 00       	call   426cf <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40ded:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40df4:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40dfb:	48 83 f8 0e          	cmp    $0xe,%rax
   40dff:	74 14                	je     40e15 <exception+0x7d>
   40e01:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40e08:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40e0f:	48 83 f8 0d          	cmp    $0xd,%rax
   40e13:	75 16                	jne    40e2b <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40e15:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40e1c:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40e23:	83 e0 04             	and    $0x4,%eax
   40e26:	48 85 c0             	test   %rax,%rax
   40e29:	74 1a                	je     40e45 <exception+0xad>
    {
        check_virtual_memory();
   40e2b:	e8 e5 08 00 00       	call   41715 <check_virtual_memory>
        if(disp_global){
   40e30:	0f b6 05 c9 51 00 00 	movzbl 0x51c9(%rip),%eax        # 46000 <disp_global>
   40e37:	84 c0                	test   %al,%al
   40e39:	74 0a                	je     40e45 <exception+0xad>
            memshow_physical();
   40e3b:	e8 9e 0a 00 00       	call   418de <memshow_physical>
            memshow_virtual_animate();
   40e40:	e8 3b 0e 00 00       	call   41c80 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40e45:	e8 9b 1d 00 00       	call   42be5 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40e4a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40e51:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40e58:	48 83 e8 0e          	sub    $0xe,%rax
   40e5c:	48 83 f8 2a          	cmp    $0x2a,%rax
   40e60:	0f 87 62 03 00 00    	ja     411c8 <exception+0x430>
   40e66:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   40e6d:	00 
   40e6e:	48 8d 05 eb 3d 00 00 	lea    0x3deb(%rip),%rax        # 44c60 <console_clear+0x11e>
   40e75:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40e78:	48 98                	cltq   
   40e7a:	48 8d 15 df 3d 00 00 	lea    0x3ddf(%rip),%rdx        # 44c60 <console_clear+0x11e>
   40e81:	48 01 d0             	add    %rdx,%rax
   40e84:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40e87:	48 8b 05 72 11 01 00 	mov    0x11172(%rip),%rax        # 52000 <current>
   40e8e:	48 8b 40 38          	mov    0x38(%rax),%rax
   40e92:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
		if((void *)addr == NULL)
   40e96:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   40e9b:	75 0f                	jne    40eac <exception+0x114>
		    panic(NULL);
   40e9d:	bf 00 00 00 00       	mov    $0x0,%edi
   40ea2:	b8 00 00 00 00       	mov    $0x0,%eax
   40ea7:	e8 9b 1e 00 00       	call   42d47 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40eac:	48 8b 05 4d 11 01 00 	mov    0x1114d(%rip),%rax        # 52000 <current>
   40eb3:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40eba:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40ebe:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40ec2:	48 89 ce             	mov    %rcx,%rsi
   40ec5:	48 89 c7             	mov    %rax,%rdi
   40ec8:	e8 38 27 00 00       	call   43605 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40ecd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40ed1:	48 89 c1             	mov    %rax,%rcx
   40ed4:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
   40edb:	ba a0 00 00 00       	mov    $0xa0,%edx
   40ee0:	48 89 ce             	mov    %rcx,%rsi
   40ee3:	48 89 c7             	mov    %rax,%rdi
   40ee6:	e8 9c 2b 00 00       	call   43a87 <memcpy>
		panic(msg);
   40eeb:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
   40ef2:	48 89 c7             	mov    %rax,%rdi
   40ef5:	b8 00 00 00 00       	mov    $0x0,%eax
   40efa:	e8 48 1e 00 00       	call   42d47 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40eff:	48 8b 05 fa 10 01 00 	mov    0x110fa(%rip),%rax        # 52000 <current>
   40f06:	8b 10                	mov    (%rax),%edx
   40f08:	48 8b 05 f1 10 01 00 	mov    0x110f1(%rip),%rax        # 52000 <current>
   40f0f:	48 63 d2             	movslq %edx,%rdx
   40f12:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40f16:	e9 bd 02 00 00       	jmp    411d8 <exception+0x440>

    case INT_SYS_YIELD:
        schedule();
   40f1b:	e8 e1 02 00 00       	call   41201 <schedule>
        break;                  /* will not be reached */
   40f20:	e9 b3 02 00 00       	jmp    411d8 <exception+0x440>

case INT_SYS_PAGE_ALLOC: {
    uintptr_t va = current->p_registers.reg_rdi;
   40f25:	48 8b 05 d4 10 01 00 	mov    0x110d4(%rip),%rax        # 52000 <current>
   40f2c:	48 8b 40 38          	mov    0x38(%rax),%rax
   40f30:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    // check allignment and bounds
    if (va % PAGESIZE != 0) {
   40f34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f38:	25 ff 0f 00 00       	and    $0xfff,%eax
   40f3d:	48 85 c0             	test   %rax,%rax
   40f40:	74 14                	je     40f56 <exception+0x1be>
        current->p_registers.reg_rax = -1; 
   40f42:	48 8b 05 b7 10 01 00 	mov    0x110b7(%rip),%rax        # 52000 <current>
   40f49:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40f50:	ff 
        break;
   40f51:	e9 82 02 00 00       	jmp    411d8 <exception+0x440>
    }
    if (va >= MEMSIZE_VIRTUAL) {
   40f56:	48 81 7d f0 ff ff 2f 	cmpq   $0x2fffff,-0x10(%rbp)
   40f5d:	00 
   40f5e:	76 14                	jbe    40f74 <exception+0x1dc>
        current->p_registers.reg_rax = -1; 
   40f60:	48 8b 05 99 10 01 00 	mov    0x11099(%rip),%rax        # 52000 <current>
   40f67:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40f6e:	ff 
        break;
   40f6f:	e9 64 02 00 00       	jmp    411d8 <exception+0x440>
    }
    if (va < PROC_START_ADDR) {
   40f74:	48 81 7d f0 ff ff 0f 	cmpq   $0xfffff,-0x10(%rbp)
   40f7b:	00 
   40f7c:	77 14                	ja     40f92 <exception+0x1fa>
        current->p_registers.reg_rax = -1; 
   40f7e:	48 8b 05 7b 10 01 00 	mov    0x1107b(%rip),%rax        # 52000 <current>
   40f85:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40f8c:	ff 
        break;
   40f8d:	e9 46 02 00 00       	jmp    411d8 <exception+0x440>
    }   
    uintptr_t pa = find_page(current->p_pid);
   40f92:	48 8b 05 67 10 01 00 	mov    0x11067(%rip),%rax        # 52000 <current>
   40f99:	8b 00                	mov    (%rax),%eax
   40f9b:	0f be c0             	movsbl %al,%eax
   40f9e:	89 c7                	mov    %eax,%edi
   40fa0:	e8 6d f4 ff ff       	call   40412 <find_page>
   40fa5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (pa == 0) {
   40fa9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40fae:	75 14                	jne    40fc4 <exception+0x22c>
        current->p_registers.reg_rax = -1; 
   40fb0:	48 8b 05 49 10 01 00 	mov    0x11049(%rip),%rax        # 52000 <current>
   40fb7:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40fbe:	ff 
        break;
   40fbf:	e9 14 02 00 00       	jmp    411d8 <exception+0x440>
    }
    int perm = PTE_P | PTE_W | PTE_U;
   40fc4:	c7 45 e4 07 00 00 00 	movl   $0x7,-0x1c(%rbp)

    int r = virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, perm);
   40fcb:	48 8b 05 2e 10 01 00 	mov    0x1102e(%rip),%rax        # 52000 <current>
   40fd2:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40fd9:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   40fdc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40fe0:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40fe4:	41 89 c8             	mov    %ecx,%r8d
   40fe7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40fec:	48 89 c7             	mov    %rax,%rdi
   40fef:	e8 c7 21 00 00       	call   431bb <virtual_memory_map>
   40ff4:	89 45 e0             	mov    %eax,-0x20(%rbp)

    if (r != 0) {
   40ff7:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
   40ffb:	74 46                	je     41043 <exception+0x2ab>
        // If mapping fails, free the physical page
        pageinfo[PAGENUMBER(pa)].refcount = 0;
   40ffd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41001:	48 c1 e8 0c          	shr    $0xc,%rax
   41005:	48 98                	cltq   
   41007:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4100b:	48 8d 05 2f 1e 01 00 	lea    0x11e2f(%rip),%rax        # 52e41 <pageinfo+0x1>
   41012:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(pa)].owner = PO_FREE;
   41016:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4101a:	48 c1 e8 0c          	shr    $0xc,%rax
   4101e:	48 98                	cltq   
   41020:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41024:	48 8d 05 15 1e 01 00 	lea    0x11e15(%rip),%rax        # 52e40 <pageinfo>
   4102b:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        current->p_registers.reg_rax = -1;
   4102f:	48 8b 05 ca 0f 01 00 	mov    0x10fca(%rip),%rax        # 52000 <current>
   41036:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   4103d:	ff 
        break;
   4103e:	e9 95 01 00 00       	jmp    411d8 <exception+0x440>
    }

    // Success: Return 0
    current->p_registers.reg_rax = 0;
   41043:	48 8b 05 b6 0f 01 00 	mov    0x10fb6(%rip),%rax        # 52000 <current>
   4104a:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   41051:	00 
    break;
   41052:	e9 81 01 00 00       	jmp    411d8 <exception+0x440>
}
// was helped by ULA's on SYS_FORK
case INT_SYS_FORK: {
    
    fork1();
   41057:	e8 d5 f9 ff ff       	call   40a31 <fork1>
    break;
   4105c:	e9 77 01 00 00       	jmp    411d8 <exception+0x440>

    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   41061:	48 8b 05 98 0f 01 00 	mov    0x10f98(%rip),%rax        # 52000 <current>
   41068:	48 89 c7             	mov    %rax,%rdi
   4106b:	e8 16 f7 ff ff       	call   40786 <syscall_mapping>
            break;
   41070:	e9 63 01 00 00       	jmp    411d8 <exception+0x440>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   41075:	48 8b 05 84 0f 01 00 	mov    0x10f84(%rip),%rax        # 52000 <current>
   4107c:	48 89 c7             	mov    %rax,%rdi
   4107f:	e8 cf f7 ff ff       	call   40853 <syscall_mem_tog>
	    break;
   41084:	e9 4f 01 00 00       	jmp    411d8 <exception+0x440>
	}

    case INT_TIMER:
        ++ticks;
   41089:	8b 05 91 1d 01 00    	mov    0x11d91(%rip),%eax        # 52e20 <ticks>
   4108f:	83 c0 01             	add    $0x1,%eax
   41092:	89 05 88 1d 01 00    	mov    %eax,0x11d88(%rip)        # 52e20 <ticks>
        schedule();
   41098:	e8 64 01 00 00       	call   41201 <schedule>
        break;                  /* will not be reached */
   4109d:	e9 36 01 00 00       	jmp    411d8 <exception+0x440>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   410a2:	0f 20 d0             	mov    %cr2,%rax
   410a5:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    return val;
   410a9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   410ad:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   410b1:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   410b8:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   410bf:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   410c2:	48 85 c0             	test   %rax,%rax
   410c5:	74 09                	je     410d0 <exception+0x338>
   410c7:	48 8d 05 02 3b 00 00 	lea    0x3b02(%rip),%rax        # 44bd0 <console_clear+0x8e>
   410ce:	eb 07                	jmp    410d7 <exception+0x33f>
   410d0:	48 8d 05 ff 3a 00 00 	lea    0x3aff(%rip),%rax        # 44bd6 <console_clear+0x94>
        const char* operation = reg->reg_err & PFERR_WRITE
   410d7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   410db:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   410e2:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   410e9:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   410ec:	48 85 c0             	test   %rax,%rax
   410ef:	74 09                	je     410fa <exception+0x362>
   410f1:	48 8d 05 e3 3a 00 00 	lea    0x3ae3(%rip),%rax        # 44bdb <console_clear+0x99>
   410f8:	eb 07                	jmp    41101 <exception+0x369>
   410fa:	48 8d 05 ed 3a 00 00 	lea    0x3aed(%rip),%rax        # 44bee <console_clear+0xac>
        const char* problem = reg->reg_err & PFERR_PRESENT
   41101:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   41105:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   4110c:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   41113:	83 e0 04             	and    $0x4,%eax
   41116:	48 85 c0             	test   %rax,%rax
   41119:	75 34                	jne    4114f <exception+0x3b7>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   4111b:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   41122:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   41129:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   4112d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   41131:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   41135:	49 89 f0             	mov    %rsi,%r8
   41138:	48 89 c6             	mov    %rax,%rsi
   4113b:	48 8d 05 be 3a 00 00 	lea    0x3abe(%rip),%rax        # 44c00 <console_clear+0xbe>
   41142:	48 89 c7             	mov    %rax,%rdi
   41145:	b8 00 00 00 00       	mov    $0x0,%eax
   4114a:	e8 f8 1b 00 00       	call   42d47 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   4114f:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   41156:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   4115d:	48 8b 05 9c 0e 01 00 	mov    0x10e9c(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   41164:	8b 00                	mov    (%rax),%eax
   41166:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
   4116a:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   4116e:	52                   	push   %rdx
   4116f:	ff 75 c0             	push   -0x40(%rbp)
   41172:	49 89 f1             	mov    %rsi,%r9
   41175:	49 89 c8             	mov    %rcx,%r8
   41178:	89 c1                	mov    %eax,%ecx
   4117a:	48 8d 05 af 3a 00 00 	lea    0x3aaf(%rip),%rax        # 44c30 <console_clear+0xee>
   41181:	48 89 c2             	mov    %rax,%rdx
   41184:	be 00 0c 00 00       	mov    $0xc00,%esi
   41189:	bf 80 07 00 00       	mov    $0x780,%edi
   4118e:	b8 00 00 00 00       	mov    $0x0,%eax
   41193:	e8 34 38 00 00       	call   449cc <console_printf>
   41198:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   4119c:	48 8b 05 5d 0e 01 00 	mov    0x10e5d(%rip),%rax        # 52000 <current>
   411a3:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   411aa:	00 00 00 
        break;
   411ad:	eb 29                	jmp    411d8 <exception+0x440>
    }

case INT_SYS_EXIT: {
    proc *p = current;
   411af:	48 8b 05 4a 0e 01 00 	mov    0x10e4a(%rip),%rax        # 52000 <current>
   411b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    exit1(p);
   411ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411be:	48 89 c7             	mov    %rax,%rdi
   411c1:	e8 fa f6 ff ff       	call   408c0 <exit1>
    // current->p_registers.reg_rax = -1; 

    break;
   411c6:	eb 10                	jmp    411d8 <exception+0x440>
}



    default:
        default_exception(current);
   411c8:	48 8b 05 31 0e 01 00 	mov    0x10e31(%rip),%rax        # 52000 <current>
   411cf:	48 89 c7             	mov    %rax,%rdi
   411d2:	e8 99 1c 00 00       	call   42e70 <default_exception>
        break;                  /* will not be reached */
   411d7:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   411d8:	48 8b 05 21 0e 01 00 	mov    0x10e21(%rip),%rax        # 52000 <current>
   411df:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   411e5:	83 f8 01             	cmp    $0x1,%eax
   411e8:	75 0f                	jne    411f9 <exception+0x461>
        run(current);
   411ea:	48 8b 05 0f 0e 01 00 	mov    0x10e0f(%rip),%rax        # 52000 <current>
   411f1:	48 89 c7             	mov    %rax,%rdi
   411f4:	e8 87 00 00 00       	call   41280 <run>
    } else {
        schedule();
   411f9:	e8 03 00 00 00       	call   41201 <schedule>
    }
}
   411fe:	90                   	nop
   411ff:	c9                   	leave  
   41200:	c3                   	ret    

0000000000041201 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   41201:	f3 0f 1e fa          	endbr64 
   41205:	55                   	push   %rbp
   41206:	48 89 e5             	mov    %rsp,%rbp
   41209:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   4120d:	48 8b 05 ec 0d 01 00 	mov    0x10dec(%rip),%rax        # 52000 <current>
   41214:	8b 00                	mov    (%rax),%eax
   41216:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   41219:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4121c:	83 c0 01             	add    $0x1,%eax
   4121f:	99                   	cltd   
   41220:	c1 ea 1c             	shr    $0x1c,%edx
   41223:	01 d0                	add    %edx,%eax
   41225:	83 e0 0f             	and    $0xf,%eax
   41228:	29 d0                	sub    %edx,%eax
   4122a:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   4122d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41230:	48 63 d0             	movslq %eax,%rdx
   41233:	48 89 d0             	mov    %rdx,%rax
   41236:	48 c1 e0 03          	shl    $0x3,%rax
   4123a:	48 29 d0             	sub    %rdx,%rax
   4123d:	48 c1 e0 05          	shl    $0x5,%rax
   41241:	48 89 c2             	mov    %rax,%rdx
   41244:	48 8d 05 9d 0e 01 00 	lea    0x10e9d(%rip),%rax        # 520e8 <processes+0xc8>
   4124b:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4124e:	83 f8 01             	cmp    $0x1,%eax
   41251:	75 26                	jne    41279 <schedule+0x78>
            run(&processes[pid]);
   41253:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41256:	48 63 d0             	movslq %eax,%rdx
   41259:	48 89 d0             	mov    %rdx,%rax
   4125c:	48 c1 e0 03          	shl    $0x3,%rax
   41260:	48 29 d0             	sub    %rdx,%rax
   41263:	48 c1 e0 05          	shl    $0x5,%rax
   41267:	48 8d 15 b2 0d 01 00 	lea    0x10db2(%rip),%rdx        # 52020 <processes>
   4126e:	48 01 d0             	add    %rdx,%rax
   41271:	48 89 c7             	mov    %rax,%rdi
   41274:	e8 07 00 00 00       	call   41280 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   41279:	e8 67 19 00 00       	call   42be5 <check_keyboard>
        pid = (pid + 1) % NPROC;
   4127e:	eb 99                	jmp    41219 <schedule+0x18>

0000000000041280 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   41280:	f3 0f 1e fa          	endbr64 
   41284:	55                   	push   %rbp
   41285:	48 89 e5             	mov    %rsp,%rbp
   41288:	48 83 ec 10          	sub    $0x10,%rsp
   4128c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   41290:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41294:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   4129a:	83 f8 01             	cmp    $0x1,%eax
   4129d:	74 1e                	je     412bd <run+0x3d>
   4129f:	48 8d 05 66 3a 00 00 	lea    0x3a66(%rip),%rax        # 44d0c <console_clear+0x1ca>
   412a6:	48 89 c2             	mov    %rax,%rdx
   412a9:	be 2e 02 00 00       	mov    $0x22e,%esi
   412ae:	48 8d 05 0b 39 00 00 	lea    0x390b(%rip),%rax        # 44bc0 <console_clear+0x7e>
   412b5:	48 89 c7             	mov    %rax,%rdi
   412b8:	e8 7a 1b 00 00       	call   42e37 <assert_fail>
    current = p;
   412bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412c1:	48 89 05 38 0d 01 00 	mov    %rax,0x10d38(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   412c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412cc:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   412d3:	48 89 c7             	mov    %rax,%rdi
   412d6:	e8 6e 1d 00 00       	call   43049 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   412db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412df:	48 83 c0 08          	add    $0x8,%rax
   412e3:	48 89 c7             	mov    %rax,%rdi
   412e6:	e8 d8 ed ff ff       	call   400c3 <exception_return>

00000000000412eb <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   412eb:	f3 0f 1e fa          	endbr64 
   412ef:	55                   	push   %rbp
   412f0:	48 89 e5             	mov    %rsp,%rbp
   412f3:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   412f7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   412fe:	00 
   412ff:	e9 93 00 00 00       	jmp    41397 <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   41304:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41308:	48 89 c7             	mov    %rax,%rdi
   4130b:	e8 0f 11 00 00       	call   4241f <physical_memory_isreserved>
   41310:	85 c0                	test   %eax,%eax
   41312:	74 09                	je     4131d <pageinfo_init+0x32>
            owner = PO_RESERVED;
   41314:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   4131b:	eb 31                	jmp    4134e <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   4131d:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   41324:	00 
   41325:	76 0d                	jbe    41334 <pageinfo_init+0x49>
   41327:	48 8d 05 da 9c 01 00 	lea    0x19cda(%rip),%rax        # 5b008 <end>
   4132e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41332:	72 0a                	jb     4133e <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   41334:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   4133b:	00 
   4133c:	75 09                	jne    41347 <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   4133e:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   41345:	eb 07                	jmp    4134e <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   41347:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4134e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41352:	48 c1 e8 0c          	shr    $0xc,%rax
   41356:	89 c2                	mov    %eax,%edx
   41358:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4135b:	89 c1                	mov    %eax,%ecx
   4135d:	48 63 c2             	movslq %edx,%rax
   41360:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41364:	48 8d 05 d5 1a 01 00 	lea    0x11ad5(%rip),%rax        # 52e40 <pageinfo>
   4136b:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   4136e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41372:	0f 95 c2             	setne  %dl
   41375:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41379:	48 c1 e8 0c          	shr    $0xc,%rax
   4137d:	89 d1                	mov    %edx,%ecx
   4137f:	48 98                	cltq   
   41381:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41385:	48 8d 05 b5 1a 01 00 	lea    0x11ab5(%rip),%rax        # 52e41 <pageinfo+0x1>
   4138c:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4138f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41396:	00 
   41397:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4139e:	00 
   4139f:	0f 86 5f ff ff ff    	jbe    41304 <pageinfo_init+0x19>
    }
}
   413a5:	90                   	nop
   413a6:	90                   	nop
   413a7:	c9                   	leave  
   413a8:	c3                   	ret    

00000000000413a9 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   413a9:	f3 0f 1e fa          	endbr64 
   413ad:	55                   	push   %rbp
   413ae:	48 89 e5             	mov    %rsp,%rbp
   413b1:	48 83 ec 50          	sub    $0x50,%rsp
   413b5:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   413b9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   413bd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   413c3:	48 89 c2             	mov    %rax,%rdx
   413c6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   413ca:	48 39 c2             	cmp    %rax,%rdx
   413cd:	74 1e                	je     413ed <check_page_table_mappings+0x44>
   413cf:	48 8d 05 52 39 00 00 	lea    0x3952(%rip),%rax        # 44d28 <console_clear+0x1e6>
   413d6:	48 89 c2             	mov    %rax,%rdx
   413d9:	be 58 02 00 00       	mov    $0x258,%esi
   413de:	48 8d 05 db 37 00 00 	lea    0x37db(%rip),%rax        # 44bc0 <console_clear+0x7e>
   413e5:	48 89 c7             	mov    %rax,%rdi
   413e8:	e8 4a 1a 00 00       	call   42e37 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   413ed:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   413f4:	00 
   413f5:	e9 b5 00 00 00       	jmp    414af <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   413fa:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   413fe:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41402:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41406:	48 89 ce             	mov    %rcx,%rsi
   41409:	48 89 c7             	mov    %rax,%rdi
   4140c:	e8 f4 21 00 00       	call   43605 <virtual_memory_lookup>
        if (vam.pa != va) {
   41411:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41415:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41419:	74 2c                	je     41447 <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   4141b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4141f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41423:	49 89 d0             	mov    %rdx,%r8
   41426:	48 89 c1             	mov    %rax,%rcx
   41429:	48 8d 05 17 39 00 00 	lea    0x3917(%rip),%rax        # 44d47 <console_clear+0x205>
   41430:	48 89 c2             	mov    %rax,%rdx
   41433:	be 00 c0 00 00       	mov    $0xc000,%esi
   41438:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4143d:	b8 00 00 00 00       	mov    $0x0,%eax
   41442:	e8 85 35 00 00       	call   449cc <console_printf>
        }
        assert(vam.pa == va);
   41447:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4144b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4144f:	74 1e                	je     4146f <check_page_table_mappings+0xc6>
   41451:	48 8d 05 f9 38 00 00 	lea    0x38f9(%rip),%rax        # 44d51 <console_clear+0x20f>
   41458:	48 89 c2             	mov    %rax,%rdx
   4145b:	be 61 02 00 00       	mov    $0x261,%esi
   41460:	48 8d 05 59 37 00 00 	lea    0x3759(%rip),%rax        # 44bc0 <console_clear+0x7e>
   41467:	48 89 c7             	mov    %rax,%rdi
   4146a:	e8 c8 19 00 00       	call   42e37 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   4146f:	48 8d 05 8a 4b 00 00 	lea    0x4b8a(%rip),%rax        # 46000 <disp_global>
   41476:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4147a:	72 2b                	jb     414a7 <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   4147c:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4147f:	48 98                	cltq   
   41481:	83 e0 02             	and    $0x2,%eax
   41484:	48 85 c0             	test   %rax,%rax
   41487:	75 1e                	jne    414a7 <check_page_table_mappings+0xfe>
   41489:	48 8d 05 ce 38 00 00 	lea    0x38ce(%rip),%rax        # 44d5e <console_clear+0x21c>
   41490:	48 89 c2             	mov    %rax,%rdx
   41493:	be 63 02 00 00       	mov    $0x263,%esi
   41498:	48 8d 05 21 37 00 00 	lea    0x3721(%rip),%rax        # 44bc0 <console_clear+0x7e>
   4149f:	48 89 c7             	mov    %rax,%rdi
   414a2:	e8 90 19 00 00       	call   42e37 <assert_fail>
         va += PAGESIZE) {
   414a7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   414ae:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   414af:	48 8d 05 52 9b 01 00 	lea    0x19b52(%rip),%rax        # 5b008 <end>
   414b6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   414ba:	0f 82 3a ff ff ff    	jb     413fa <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   414c0:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   414c7:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   414c8:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   414cc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   414d0:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   414d4:	48 89 ce             	mov    %rcx,%rsi
   414d7:	48 89 c7             	mov    %rax,%rdi
   414da:	e8 26 21 00 00       	call   43605 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   414df:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414e3:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   414e7:	74 1e                	je     41507 <check_page_table_mappings+0x15e>
   414e9:	48 8d 05 7f 38 00 00 	lea    0x387f(%rip),%rax        # 44d6f <console_clear+0x22d>
   414f0:	48 89 c2             	mov    %rax,%rdx
   414f3:	be 6a 02 00 00       	mov    $0x26a,%esi
   414f8:	48 8d 05 c1 36 00 00 	lea    0x36c1(%rip),%rax        # 44bc0 <console_clear+0x7e>
   414ff:	48 89 c7             	mov    %rax,%rdi
   41502:	e8 30 19 00 00       	call   42e37 <assert_fail>
    assert(vam.perm & PTE_W);
   41507:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4150a:	48 98                	cltq   
   4150c:	83 e0 02             	and    $0x2,%eax
   4150f:	48 85 c0             	test   %rax,%rax
   41512:	75 1e                	jne    41532 <check_page_table_mappings+0x189>
   41514:	48 8d 05 43 38 00 00 	lea    0x3843(%rip),%rax        # 44d5e <console_clear+0x21c>
   4151b:	48 89 c2             	mov    %rax,%rdx
   4151e:	be 6b 02 00 00       	mov    $0x26b,%esi
   41523:	48 8d 05 96 36 00 00 	lea    0x3696(%rip),%rax        # 44bc0 <console_clear+0x7e>
   4152a:	48 89 c7             	mov    %rax,%rdi
   4152d:	e8 05 19 00 00       	call   42e37 <assert_fail>
}
   41532:	90                   	nop
   41533:	c9                   	leave  
   41534:	c3                   	ret    

0000000000041535 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   41535:	f3 0f 1e fa          	endbr64 
   41539:	55                   	push   %rbp
   4153a:	48 89 e5             	mov    %rsp,%rbp
   4153d:	48 83 ec 20          	sub    $0x20,%rsp
   41541:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41545:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   41548:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4154b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   4154e:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41555:	48 8b 05 a4 3a 01 00 	mov    0x13aa4(%rip),%rax        # 55000 <kernel_pagetable>
   4155c:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41560:	75 71                	jne    415d3 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   41562:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41569:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41570:	eb 5b                	jmp    415cd <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   41572:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41575:	48 63 d0             	movslq %eax,%rdx
   41578:	48 89 d0             	mov    %rdx,%rax
   4157b:	48 c1 e0 03          	shl    $0x3,%rax
   4157f:	48 29 d0             	sub    %rdx,%rax
   41582:	48 c1 e0 05          	shl    $0x5,%rax
   41586:	48 89 c2             	mov    %rax,%rdx
   41589:	48 8d 05 58 0b 01 00 	lea    0x10b58(%rip),%rax        # 520e8 <processes+0xc8>
   41590:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41593:	85 c0                	test   %eax,%eax
   41595:	74 32                	je     415c9 <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41597:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4159a:	48 63 d0             	movslq %eax,%rdx
   4159d:	48 89 d0             	mov    %rdx,%rax
   415a0:	48 c1 e0 03          	shl    $0x3,%rax
   415a4:	48 29 d0             	sub    %rdx,%rax
   415a7:	48 c1 e0 05          	shl    $0x5,%rax
   415ab:	48 89 c2             	mov    %rax,%rdx
   415ae:	48 8d 05 3b 0b 01 00 	lea    0x10b3b(%rip),%rax        # 520f0 <processes+0xd0>
   415b5:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   415b9:	48 8b 05 40 3a 01 00 	mov    0x13a40(%rip),%rax        # 55000 <kernel_pagetable>
   415c0:	48 39 c2             	cmp    %rax,%rdx
   415c3:	75 04                	jne    415c9 <check_page_table_ownership+0x94>
                ++expected_refcount;
   415c5:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   415c9:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   415cd:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   415d1:	7e 9f                	jle    41572 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   415d3:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   415d6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   415d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   415dd:	be 00 00 00 00       	mov    $0x0,%esi
   415e2:	48 89 c7             	mov    %rax,%rdi
   415e5:	e8 03 00 00 00       	call   415ed <check_page_table_ownership_level>
}
   415ea:	90                   	nop
   415eb:	c9                   	leave  
   415ec:	c3                   	ret    

00000000000415ed <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   415ed:	f3 0f 1e fa          	endbr64 
   415f1:	55                   	push   %rbp
   415f2:	48 89 e5             	mov    %rsp,%rbp
   415f5:	48 83 ec 30          	sub    $0x30,%rsp
   415f9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   415fd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41600:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41603:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41606:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4160a:	48 c1 e8 0c          	shr    $0xc,%rax
   4160e:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41613:	7e 1e                	jle    41633 <check_page_table_ownership_level+0x46>
   41615:	48 8d 05 64 37 00 00 	lea    0x3764(%rip),%rax        # 44d80 <console_clear+0x23e>
   4161c:	48 89 c2             	mov    %rax,%rdx
   4161f:	be 88 02 00 00       	mov    $0x288,%esi
   41624:	48 8d 05 95 35 00 00 	lea    0x3595(%rip),%rax        # 44bc0 <console_clear+0x7e>
   4162b:	48 89 c7             	mov    %rax,%rdi
   4162e:	e8 04 18 00 00       	call   42e37 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41633:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41637:	48 c1 e8 0c          	shr    $0xc,%rax
   4163b:	48 98                	cltq   
   4163d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41641:	48 8d 05 f8 17 01 00 	lea    0x117f8(%rip),%rax        # 52e40 <pageinfo>
   41648:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4164c:	0f be c0             	movsbl %al,%eax
   4164f:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41652:	74 1e                	je     41672 <check_page_table_ownership_level+0x85>
   41654:	48 8d 05 3d 37 00 00 	lea    0x373d(%rip),%rax        # 44d98 <console_clear+0x256>
   4165b:	48 89 c2             	mov    %rax,%rdx
   4165e:	be 89 02 00 00       	mov    $0x289,%esi
   41663:	48 8d 05 56 35 00 00 	lea    0x3556(%rip),%rax        # 44bc0 <console_clear+0x7e>
   4166a:	48 89 c7             	mov    %rax,%rdi
   4166d:	e8 c5 17 00 00       	call   42e37 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41672:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41676:	48 c1 e8 0c          	shr    $0xc,%rax
   4167a:	48 98                	cltq   
   4167c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41680:	48 8d 05 ba 17 01 00 	lea    0x117ba(%rip),%rax        # 52e41 <pageinfo+0x1>
   41687:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4168b:	0f be c0             	movsbl %al,%eax
   4168e:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41691:	74 1e                	je     416b1 <check_page_table_ownership_level+0xc4>
   41693:	48 8d 05 26 37 00 00 	lea    0x3726(%rip),%rax        # 44dc0 <console_clear+0x27e>
   4169a:	48 89 c2             	mov    %rax,%rdx
   4169d:	be 8a 02 00 00       	mov    $0x28a,%esi
   416a2:	48 8d 05 17 35 00 00 	lea    0x3517(%rip),%rax        # 44bc0 <console_clear+0x7e>
   416a9:	48 89 c7             	mov    %rax,%rdi
   416ac:	e8 86 17 00 00       	call   42e37 <assert_fail>
    if (level < 3) {
   416b1:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   416b5:	7f 5b                	jg     41712 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   416b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   416be:	eb 49                	jmp    41709 <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   416c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   416c4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   416c7:	48 63 d2             	movslq %edx,%rdx
   416ca:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   416ce:	48 85 c0             	test   %rax,%rax
   416d1:	74 32                	je     41705 <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   416d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   416d7:	8b 55 fc             	mov    -0x4(%rbp),%edx
   416da:	48 63 d2             	movslq %edx,%rdx
   416dd:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   416e1:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   416e7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   416eb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   416ee:	8d 70 01             	lea    0x1(%rax),%esi
   416f1:	8b 55 e0             	mov    -0x20(%rbp),%edx
   416f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   416f8:	b9 01 00 00 00       	mov    $0x1,%ecx
   416fd:	48 89 c7             	mov    %rax,%rdi
   41700:	e8 e8 fe ff ff       	call   415ed <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41705:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41709:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41710:	7e ae                	jle    416c0 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   41712:	90                   	nop
   41713:	c9                   	leave  
   41714:	c3                   	ret    

0000000000041715 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41715:	f3 0f 1e fa          	endbr64 
   41719:	55                   	push   %rbp
   4171a:	48 89 e5             	mov    %rsp,%rbp
   4171d:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41721:	8b 05 c1 09 01 00    	mov    0x109c1(%rip),%eax        # 520e8 <processes+0xc8>
   41727:	85 c0                	test   %eax,%eax
   41729:	74 1e                	je     41749 <check_virtual_memory+0x34>
   4172b:	48 8d 05 be 36 00 00 	lea    0x36be(%rip),%rax        # 44df0 <console_clear+0x2ae>
   41732:	48 89 c2             	mov    %rax,%rdx
   41735:	be 9d 02 00 00       	mov    $0x29d,%esi
   4173a:	48 8d 05 7f 34 00 00 	lea    0x347f(%rip),%rax        # 44bc0 <console_clear+0x7e>
   41741:	48 89 c7             	mov    %rax,%rdi
   41744:	e8 ee 16 00 00       	call   42e37 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41749:	48 8b 05 b0 38 01 00 	mov    0x138b0(%rip),%rax        # 55000 <kernel_pagetable>
   41750:	48 89 c7             	mov    %rax,%rdi
   41753:	e8 51 fc ff ff       	call   413a9 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41758:	48 8b 05 a1 38 01 00 	mov    0x138a1(%rip),%rax        # 55000 <kernel_pagetable>
   4175f:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41764:	48 89 c7             	mov    %rax,%rdi
   41767:	e8 c9 fd ff ff       	call   41535 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   4176c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41773:	e9 b4 00 00 00       	jmp    4182c <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   41778:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4177b:	48 63 d0             	movslq %eax,%rdx
   4177e:	48 89 d0             	mov    %rdx,%rax
   41781:	48 c1 e0 03          	shl    $0x3,%rax
   41785:	48 29 d0             	sub    %rdx,%rax
   41788:	48 c1 e0 05          	shl    $0x5,%rax
   4178c:	48 89 c2             	mov    %rax,%rdx
   4178f:	48 8d 05 52 09 01 00 	lea    0x10952(%rip),%rax        # 520e8 <processes+0xc8>
   41796:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41799:	85 c0                	test   %eax,%eax
   4179b:	0f 84 87 00 00 00    	je     41828 <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   417a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417a4:	48 63 d0             	movslq %eax,%rdx
   417a7:	48 89 d0             	mov    %rdx,%rax
   417aa:	48 c1 e0 03          	shl    $0x3,%rax
   417ae:	48 29 d0             	sub    %rdx,%rax
   417b1:	48 c1 e0 05          	shl    $0x5,%rax
   417b5:	48 89 c2             	mov    %rax,%rdx
   417b8:	48 8d 05 31 09 01 00 	lea    0x10931(%rip),%rax        # 520f0 <processes+0xd0>
   417bf:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   417c3:	48 8b 05 36 38 01 00 	mov    0x13836(%rip),%rax        # 55000 <kernel_pagetable>
   417ca:	48 39 c2             	cmp    %rax,%rdx
   417cd:	74 59                	je     41828 <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   417cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417d2:	48 63 d0             	movslq %eax,%rdx
   417d5:	48 89 d0             	mov    %rdx,%rax
   417d8:	48 c1 e0 03          	shl    $0x3,%rax
   417dc:	48 29 d0             	sub    %rdx,%rax
   417df:	48 c1 e0 05          	shl    $0x5,%rax
   417e3:	48 89 c2             	mov    %rax,%rdx
   417e6:	48 8d 05 03 09 01 00 	lea    0x10903(%rip),%rax        # 520f0 <processes+0xd0>
   417ed:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   417f1:	48 89 c7             	mov    %rax,%rdi
   417f4:	e8 b0 fb ff ff       	call   413a9 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   417f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417fc:	48 63 d0             	movslq %eax,%rdx
   417ff:	48 89 d0             	mov    %rdx,%rax
   41802:	48 c1 e0 03          	shl    $0x3,%rax
   41806:	48 29 d0             	sub    %rdx,%rax
   41809:	48 c1 e0 05          	shl    $0x5,%rax
   4180d:	48 89 c2             	mov    %rax,%rdx
   41810:	48 8d 05 d9 08 01 00 	lea    0x108d9(%rip),%rax        # 520f0 <processes+0xd0>
   41817:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4181b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4181e:	89 d6                	mov    %edx,%esi
   41820:	48 89 c7             	mov    %rax,%rdi
   41823:	e8 0d fd ff ff       	call   41535 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41828:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4182c:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41830:	0f 8e 42 ff ff ff    	jle    41778 <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41836:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4183d:	e9 8b 00 00 00       	jmp    418cd <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41842:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41845:	48 98                	cltq   
   41847:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4184b:	48 8d 05 ef 15 01 00 	lea    0x115ef(%rip),%rax        # 52e41 <pageinfo+0x1>
   41852:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41856:	84 c0                	test   %al,%al
   41858:	7e 6f                	jle    418c9 <check_virtual_memory+0x1b4>
   4185a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4185d:	48 98                	cltq   
   4185f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41863:	48 8d 05 d6 15 01 00 	lea    0x115d6(%rip),%rax        # 52e40 <pageinfo>
   4186a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4186e:	84 c0                	test   %al,%al
   41870:	78 57                	js     418c9 <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41872:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41875:	48 98                	cltq   
   41877:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4187b:	48 8d 05 be 15 01 00 	lea    0x115be(%rip),%rax        # 52e40 <pageinfo>
   41882:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41886:	0f be c0             	movsbl %al,%eax
   41889:	48 63 d0             	movslq %eax,%rdx
   4188c:	48 89 d0             	mov    %rdx,%rax
   4188f:	48 c1 e0 03          	shl    $0x3,%rax
   41893:	48 29 d0             	sub    %rdx,%rax
   41896:	48 c1 e0 05          	shl    $0x5,%rax
   4189a:	48 89 c2             	mov    %rax,%rdx
   4189d:	48 8d 05 44 08 01 00 	lea    0x10844(%rip),%rax        # 520e8 <processes+0xc8>
   418a4:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   418a7:	85 c0                	test   %eax,%eax
   418a9:	75 1e                	jne    418c9 <check_virtual_memory+0x1b4>
   418ab:	48 8d 05 5e 35 00 00 	lea    0x355e(%rip),%rax        # 44e10 <console_clear+0x2ce>
   418b2:	48 89 c2             	mov    %rax,%rdx
   418b5:	be b4 02 00 00       	mov    $0x2b4,%esi
   418ba:	48 8d 05 ff 32 00 00 	lea    0x32ff(%rip),%rax        # 44bc0 <console_clear+0x7e>
   418c1:	48 89 c7             	mov    %rax,%rdi
   418c4:	e8 6e 15 00 00       	call   42e37 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   418c9:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   418cd:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   418d4:	0f 8e 68 ff ff ff    	jle    41842 <check_virtual_memory+0x12d>
        }
    }
}
   418da:	90                   	nop
   418db:	90                   	nop
   418dc:	c9                   	leave  
   418dd:	c3                   	ret    

00000000000418de <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   418de:	f3 0f 1e fa          	endbr64 
   418e2:	55                   	push   %rbp
   418e3:	48 89 e5             	mov    %rsp,%rbp
   418e6:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   418ea:	48 8d 05 75 35 00 00 	lea    0x3575(%rip),%rax        # 44e66 <memstate_colors+0x26>
   418f1:	48 89 c2             	mov    %rax,%rdx
   418f4:	be 00 0f 00 00       	mov    $0xf00,%esi
   418f9:	bf 20 00 00 00       	mov    $0x20,%edi
   418fe:	b8 00 00 00 00       	mov    $0x0,%eax
   41903:	e8 c4 30 00 00       	call   449cc <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41908:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4190f:	e9 1b 01 00 00       	jmp    41a2f <memshow_physical+0x151>
        if (pn % 64 == 0) {
   41914:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41917:	83 e0 3f             	and    $0x3f,%eax
   4191a:	85 c0                	test   %eax,%eax
   4191c:	75 40                	jne    4195e <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   4191e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41921:	c1 e0 0c             	shl    $0xc,%eax
   41924:	89 c2                	mov    %eax,%edx
   41926:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41929:	8d 48 3f             	lea    0x3f(%rax),%ecx
   4192c:	85 c0                	test   %eax,%eax
   4192e:	0f 48 c1             	cmovs  %ecx,%eax
   41931:	c1 f8 06             	sar    $0x6,%eax
   41934:	8d 48 01             	lea    0x1(%rax),%ecx
   41937:	89 c8                	mov    %ecx,%eax
   41939:	c1 e0 02             	shl    $0x2,%eax
   4193c:	01 c8                	add    %ecx,%eax
   4193e:	c1 e0 04             	shl    $0x4,%eax
   41941:	83 c0 03             	add    $0x3,%eax
   41944:	89 d1                	mov    %edx,%ecx
   41946:	48 8d 15 29 35 00 00 	lea    0x3529(%rip),%rdx        # 44e76 <memstate_colors+0x36>
   4194d:	be 00 0f 00 00       	mov    $0xf00,%esi
   41952:	89 c7                	mov    %eax,%edi
   41954:	b8 00 00 00 00       	mov    $0x0,%eax
   41959:	e8 6e 30 00 00       	call   449cc <console_printf>
        }

        int owner = pageinfo[pn].owner;
   4195e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41961:	48 98                	cltq   
   41963:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41967:	48 8d 05 d2 14 01 00 	lea    0x114d2(%rip),%rax        # 52e40 <pageinfo>
   4196e:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41972:	0f be c0             	movsbl %al,%eax
   41975:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41978:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4197b:	48 98                	cltq   
   4197d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41981:	48 8d 05 b9 14 01 00 	lea    0x114b9(%rip),%rax        # 52e41 <pageinfo+0x1>
   41988:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4198c:	84 c0                	test   %al,%al
   4198e:	75 07                	jne    41997 <memshow_physical+0xb9>
            owner = PO_FREE;
   41990:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41997:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4199a:	83 c0 02             	add    $0x2,%eax
   4199d:	48 98                	cltq   
   4199f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   419a3:	48 8d 05 96 34 00 00 	lea    0x3496(%rip),%rax        # 44e40 <memstate_colors>
   419aa:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   419ae:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   419b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419b5:	48 98                	cltq   
   419b7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   419bb:	48 8d 05 7f 14 01 00 	lea    0x1147f(%rip),%rax        # 52e41 <pageinfo+0x1>
   419c2:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   419c6:	3c 01                	cmp    $0x1,%al
   419c8:	7e 1c                	jle    419e6 <memshow_physical+0x108>
   419ca:	48 8d 05 2f 66 07 00 	lea    0x7662f(%rip),%rax        # b8000 <console>
   419d1:	48 c1 e8 0c          	shr    $0xc,%rax
   419d5:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   419d8:	74 0c                	je     419e6 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   419da:	b8 53 00 00 00       	mov    $0x53,%eax
   419df:	80 cc 0f             	or     $0xf,%ah
   419e2:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   419e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419e9:	8d 50 3f             	lea    0x3f(%rax),%edx
   419ec:	85 c0                	test   %eax,%eax
   419ee:	0f 48 c2             	cmovs  %edx,%eax
   419f1:	c1 f8 06             	sar    $0x6,%eax
   419f4:	8d 50 01             	lea    0x1(%rax),%edx
   419f7:	89 d0                	mov    %edx,%eax
   419f9:	c1 e0 02             	shl    $0x2,%eax
   419fc:	01 d0                	add    %edx,%eax
   419fe:	c1 e0 04             	shl    $0x4,%eax
   41a01:	89 c1                	mov    %eax,%ecx
   41a03:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a06:	99                   	cltd   
   41a07:	c1 ea 1a             	shr    $0x1a,%edx
   41a0a:	01 d0                	add    %edx,%eax
   41a0c:	83 e0 3f             	and    $0x3f,%eax
   41a0f:	29 d0                	sub    %edx,%eax
   41a11:	83 c0 0c             	add    $0xc,%eax
   41a14:	01 c8                	add    %ecx,%eax
   41a16:	48 98                	cltq   
   41a18:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41a1c:	48 8d 15 dd 65 07 00 	lea    0x765dd(%rip),%rdx        # b8000 <console>
   41a23:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41a27:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41a2b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41a2f:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41a36:	0f 8e d8 fe ff ff    	jle    41914 <memshow_physical+0x36>
    }
}
   41a3c:	90                   	nop
   41a3d:	90                   	nop
   41a3e:	c9                   	leave  
   41a3f:	c3                   	ret    

0000000000041a40 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41a40:	f3 0f 1e fa          	endbr64 
   41a44:	55                   	push   %rbp
   41a45:	48 89 e5             	mov    %rsp,%rbp
   41a48:	48 83 ec 40          	sub    $0x40,%rsp
   41a4c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41a50:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41a54:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41a58:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41a5e:	48 89 c2             	mov    %rax,%rdx
   41a61:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41a65:	48 39 c2             	cmp    %rax,%rdx
   41a68:	74 1e                	je     41a88 <memshow_virtual+0x48>
   41a6a:	48 8d 05 0f 34 00 00 	lea    0x340f(%rip),%rax        # 44e80 <memstate_colors+0x40>
   41a71:	48 89 c2             	mov    %rax,%rdx
   41a74:	be e5 02 00 00       	mov    $0x2e5,%esi
   41a79:	48 8d 05 40 31 00 00 	lea    0x3140(%rip),%rax        # 44bc0 <console_clear+0x7e>
   41a80:	48 89 c7             	mov    %rax,%rdi
   41a83:	e8 af 13 00 00       	call   42e37 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41a88:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41a8c:	48 89 c1             	mov    %rax,%rcx
   41a8f:	48 8d 05 17 34 00 00 	lea    0x3417(%rip),%rax        # 44ead <memstate_colors+0x6d>
   41a96:	48 89 c2             	mov    %rax,%rdx
   41a99:	be 00 0f 00 00       	mov    $0xf00,%esi
   41a9e:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41aa3:	b8 00 00 00 00       	mov    $0x0,%eax
   41aa8:	e8 1f 2f 00 00       	call   449cc <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41aad:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41ab4:	00 
   41ab5:	e9 b4 01 00 00       	jmp    41c6e <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41aba:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41abe:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41ac2:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41ac6:	48 89 ce             	mov    %rcx,%rsi
   41ac9:	48 89 c7             	mov    %rax,%rdi
   41acc:	e8 34 1b 00 00       	call   43605 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41ad1:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41ad4:	85 c0                	test   %eax,%eax
   41ad6:	79 0b                	jns    41ae3 <memshow_virtual+0xa3>
            color = ' ';
   41ad8:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41ade:	e9 ff 00 00 00       	jmp    41be2 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41ae3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41ae7:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41aed:	76 1e                	jbe    41b0d <memshow_virtual+0xcd>
   41aef:	48 8d 05 d4 33 00 00 	lea    0x33d4(%rip),%rax        # 44eca <memstate_colors+0x8a>
   41af6:	48 89 c2             	mov    %rax,%rdx
   41af9:	be ee 02 00 00       	mov    $0x2ee,%esi
   41afe:	48 8d 05 bb 30 00 00 	lea    0x30bb(%rip),%rax        # 44bc0 <console_clear+0x7e>
   41b05:	48 89 c7             	mov    %rax,%rdi
   41b08:	e8 2a 13 00 00       	call   42e37 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41b0d:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41b10:	48 98                	cltq   
   41b12:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41b16:	48 8d 05 23 13 01 00 	lea    0x11323(%rip),%rax        # 52e40 <pageinfo>
   41b1d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41b21:	0f be c0             	movsbl %al,%eax
   41b24:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41b27:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41b2a:	48 98                	cltq   
   41b2c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41b30:	48 8d 05 0a 13 01 00 	lea    0x1130a(%rip),%rax        # 52e41 <pageinfo+0x1>
   41b37:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41b3b:	84 c0                	test   %al,%al
   41b3d:	75 07                	jne    41b46 <memshow_virtual+0x106>
                owner = PO_FREE;
   41b3f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41b46:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41b49:	83 c0 02             	add    $0x2,%eax
   41b4c:	48 98                	cltq   
   41b4e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41b52:	48 8d 05 e7 32 00 00 	lea    0x32e7(%rip),%rax        # 44e40 <memstate_colors>
   41b59:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41b5d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41b61:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41b64:	48 98                	cltq   
   41b66:	83 e0 04             	and    $0x4,%eax
   41b69:	48 85 c0             	test   %rax,%rax
   41b6c:	74 27                	je     41b95 <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41b6e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41b72:	c1 e0 04             	shl    $0x4,%eax
   41b75:	66 25 00 f0          	and    $0xf000,%ax
   41b79:	89 c2                	mov    %eax,%edx
   41b7b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41b7f:	c1 f8 04             	sar    $0x4,%eax
   41b82:	66 25 00 0f          	and    $0xf00,%ax
   41b86:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41b88:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41b8c:	0f b6 c0             	movzbl %al,%eax
   41b8f:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41b91:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41b95:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41b98:	48 98                	cltq   
   41b9a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41b9e:	48 8d 05 9c 12 01 00 	lea    0x1129c(%rip),%rax        # 52e41 <pageinfo+0x1>
   41ba5:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41ba9:	3c 01                	cmp    $0x1,%al
   41bab:	7e 35                	jle    41be2 <memshow_virtual+0x1a2>
   41bad:	48 8d 05 4c 64 07 00 	lea    0x7644c(%rip),%rax        # b8000 <console>
   41bb4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41bb8:	74 28                	je     41be2 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41bba:	b8 53 00 00 00       	mov    $0x53,%eax
   41bbf:	89 c2                	mov    %eax,%edx
   41bc1:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41bc5:	66 25 00 f0          	and    $0xf000,%ax
   41bc9:	09 d0                	or     %edx,%eax
   41bcb:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41bcf:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41bd2:	48 98                	cltq   
   41bd4:	83 e0 04             	and    $0x4,%eax
   41bd7:	48 85 c0             	test   %rax,%rax
   41bda:	75 06                	jne    41be2 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   41bdc:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41be2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41be6:	48 c1 e8 0c          	shr    $0xc,%rax
   41bea:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41bed:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41bf0:	83 e0 3f             	and    $0x3f,%eax
   41bf3:	85 c0                	test   %eax,%eax
   41bf5:	75 39                	jne    41c30 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41bf7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41bfa:	c1 e8 06             	shr    $0x6,%eax
   41bfd:	89 c2                	mov    %eax,%edx
   41bff:	89 d0                	mov    %edx,%eax
   41c01:	c1 e0 02             	shl    $0x2,%eax
   41c04:	01 d0                	add    %edx,%eax
   41c06:	c1 e0 04             	shl    $0x4,%eax
   41c09:	05 73 03 00 00       	add    $0x373,%eax
   41c0e:	89 c7                	mov    %eax,%edi
   41c10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c14:	48 89 c1             	mov    %rax,%rcx
   41c17:	48 8d 05 58 32 00 00 	lea    0x3258(%rip),%rax        # 44e76 <memstate_colors+0x36>
   41c1e:	48 89 c2             	mov    %rax,%rdx
   41c21:	be 00 0f 00 00       	mov    $0xf00,%esi
   41c26:	b8 00 00 00 00       	mov    $0x0,%eax
   41c2b:	e8 9c 2d 00 00       	call   449cc <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41c30:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41c33:	c1 e8 06             	shr    $0x6,%eax
   41c36:	89 c2                	mov    %eax,%edx
   41c38:	89 d0                	mov    %edx,%eax
   41c3a:	c1 e0 02             	shl    $0x2,%eax
   41c3d:	01 d0                	add    %edx,%eax
   41c3f:	c1 e0 04             	shl    $0x4,%eax
   41c42:	89 c2                	mov    %eax,%edx
   41c44:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41c47:	83 e0 3f             	and    $0x3f,%eax
   41c4a:	01 d0                	add    %edx,%eax
   41c4c:	05 7c 03 00 00       	add    $0x37c,%eax
   41c51:	89 c0                	mov    %eax,%eax
   41c53:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41c57:	48 8d 15 a2 63 07 00 	lea    0x763a2(%rip),%rdx        # b8000 <console>
   41c5e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c62:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41c66:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41c6d:	00 
   41c6e:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41c75:	00 
   41c76:	0f 86 3e fe ff ff    	jbe    41aba <memshow_virtual+0x7a>
    }
}
   41c7c:	90                   	nop
   41c7d:	90                   	nop
   41c7e:	c9                   	leave  
   41c7f:	c3                   	ret    

0000000000041c80 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41c80:	f3 0f 1e fa          	endbr64 
   41c84:	55                   	push   %rbp
   41c85:	48 89 e5             	mov    %rsp,%rbp
   41c88:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41c8c:	8b 05 ae 15 01 00    	mov    0x115ae(%rip),%eax        # 53240 <last_ticks.1>
   41c92:	85 c0                	test   %eax,%eax
   41c94:	74 13                	je     41ca9 <memshow_virtual_animate+0x29>
   41c96:	8b 05 84 11 01 00    	mov    0x11184(%rip),%eax        # 52e20 <ticks>
   41c9c:	8b 15 9e 15 01 00    	mov    0x1159e(%rip),%edx        # 53240 <last_ticks.1>
   41ca2:	29 d0                	sub    %edx,%eax
   41ca4:	83 f8 31             	cmp    $0x31,%eax
   41ca7:	76 2c                	jbe    41cd5 <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   41ca9:	8b 05 71 11 01 00    	mov    0x11171(%rip),%eax        # 52e20 <ticks>
   41caf:	89 05 8b 15 01 00    	mov    %eax,0x1158b(%rip)        # 53240 <last_ticks.1>
        ++showing;
   41cb5:	8b 05 49 43 00 00    	mov    0x4349(%rip),%eax        # 46004 <showing.0>
   41cbb:	83 c0 01             	add    $0x1,%eax
   41cbe:	89 05 40 43 00 00    	mov    %eax,0x4340(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41cc4:	eb 0f                	jmp    41cd5 <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41cc6:	8b 05 38 43 00 00    	mov    0x4338(%rip),%eax        # 46004 <showing.0>
   41ccc:	83 c0 01             	add    $0x1,%eax
   41ccf:	89 05 2f 43 00 00    	mov    %eax,0x432f(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41cd5:	8b 05 29 43 00 00    	mov    0x4329(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41cdb:	83 f8 20             	cmp    $0x20,%eax
   41cde:	7f 6b                	jg     41d4b <memshow_virtual_animate+0xcb>
   41ce0:	8b 05 1e 43 00 00    	mov    0x431e(%rip),%eax        # 46004 <showing.0>
   41ce6:	99                   	cltd   
   41ce7:	c1 ea 1c             	shr    $0x1c,%edx
   41cea:	01 d0                	add    %edx,%eax
   41cec:	83 e0 0f             	and    $0xf,%eax
   41cef:	29 d0                	sub    %edx,%eax
   41cf1:	48 63 d0             	movslq %eax,%rdx
   41cf4:	48 89 d0             	mov    %rdx,%rax
   41cf7:	48 c1 e0 03          	shl    $0x3,%rax
   41cfb:	48 29 d0             	sub    %rdx,%rax
   41cfe:	48 c1 e0 05          	shl    $0x5,%rax
   41d02:	48 89 c2             	mov    %rax,%rdx
   41d05:	48 8d 05 dc 03 01 00 	lea    0x103dc(%rip),%rax        # 520e8 <processes+0xc8>
   41d0c:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41d0f:	85 c0                	test   %eax,%eax
   41d11:	74 b3                	je     41cc6 <memshow_virtual_animate+0x46>
   41d13:	8b 05 eb 42 00 00    	mov    0x42eb(%rip),%eax        # 46004 <showing.0>
   41d19:	99                   	cltd   
   41d1a:	c1 ea 1c             	shr    $0x1c,%edx
   41d1d:	01 d0                	add    %edx,%eax
   41d1f:	83 e0 0f             	and    $0xf,%eax
   41d22:	29 d0                	sub    %edx,%eax
   41d24:	48 63 d0             	movslq %eax,%rdx
   41d27:	48 89 d0             	mov    %rdx,%rax
   41d2a:	48 c1 e0 03          	shl    $0x3,%rax
   41d2e:	48 29 d0             	sub    %rdx,%rax
   41d31:	48 c1 e0 05          	shl    $0x5,%rax
   41d35:	48 89 c2             	mov    %rax,%rdx
   41d38:	48 8d 05 b9 03 01 00 	lea    0x103b9(%rip),%rax        # 520f8 <processes+0xd8>
   41d3f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41d43:	84 c0                	test   %al,%al
   41d45:	0f 84 7b ff ff ff    	je     41cc6 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   41d4b:	8b 05 b3 42 00 00    	mov    0x42b3(%rip),%eax        # 46004 <showing.0>
   41d51:	99                   	cltd   
   41d52:	c1 ea 1c             	shr    $0x1c,%edx
   41d55:	01 d0                	add    %edx,%eax
   41d57:	83 e0 0f             	and    $0xf,%eax
   41d5a:	29 d0                	sub    %edx,%eax
   41d5c:	89 05 a2 42 00 00    	mov    %eax,0x42a2(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41d62:	8b 05 9c 42 00 00    	mov    0x429c(%rip),%eax        # 46004 <showing.0>
   41d68:	48 63 d0             	movslq %eax,%rdx
   41d6b:	48 89 d0             	mov    %rdx,%rax
   41d6e:	48 c1 e0 03          	shl    $0x3,%rax
   41d72:	48 29 d0             	sub    %rdx,%rax
   41d75:	48 c1 e0 05          	shl    $0x5,%rax
   41d79:	48 89 c2             	mov    %rax,%rdx
   41d7c:	48 8d 05 65 03 01 00 	lea    0x10365(%rip),%rax        # 520e8 <processes+0xc8>
   41d83:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41d86:	85 c0                	test   %eax,%eax
   41d88:	74 59                	je     41de3 <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41d8a:	8b 15 74 42 00 00    	mov    0x4274(%rip),%edx        # 46004 <showing.0>
   41d90:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41d94:	89 d1                	mov    %edx,%ecx
   41d96:	48 8d 15 47 31 00 00 	lea    0x3147(%rip),%rdx        # 44ee4 <memstate_colors+0xa4>
   41d9d:	be 04 00 00 00       	mov    $0x4,%esi
   41da2:	48 89 c7             	mov    %rax,%rdi
   41da5:	b8 00 00 00 00       	mov    $0x0,%eax
   41daa:	e8 38 2d 00 00       	call   44ae7 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41daf:	8b 05 4f 42 00 00    	mov    0x424f(%rip),%eax        # 46004 <showing.0>
   41db5:	48 63 d0             	movslq %eax,%rdx
   41db8:	48 89 d0             	mov    %rdx,%rax
   41dbb:	48 c1 e0 03          	shl    $0x3,%rax
   41dbf:	48 29 d0             	sub    %rdx,%rax
   41dc2:	48 c1 e0 05          	shl    $0x5,%rax
   41dc6:	48 89 c2             	mov    %rax,%rdx
   41dc9:	48 8d 05 20 03 01 00 	lea    0x10320(%rip),%rax        # 520f0 <processes+0xd0>
   41dd0:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41dd4:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41dd8:	48 89 d6             	mov    %rdx,%rsi
   41ddb:	48 89 c7             	mov    %rax,%rdi
   41dde:	e8 5d fc ff ff       	call   41a40 <memshow_virtual>
    }
}
   41de3:	90                   	nop
   41de4:	c9                   	leave  
   41de5:	c3                   	ret    

0000000000041de6 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41de6:	f3 0f 1e fa          	endbr64 
   41dea:	55                   	push   %rbp
   41deb:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41dee:	e8 5f 01 00 00       	call   41f52 <segments_init>
    interrupt_init();
   41df3:	e8 44 04 00 00       	call   4223c <interrupt_init>
    virtual_memory_init();
   41df8:	e8 11 11 00 00       	call   42f0e <virtual_memory_init>
}
   41dfd:	90                   	nop
   41dfe:	5d                   	pop    %rbp
   41dff:	c3                   	ret    

0000000000041e00 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41e00:	f3 0f 1e fa          	endbr64 
   41e04:	55                   	push   %rbp
   41e05:	48 89 e5             	mov    %rsp,%rbp
   41e08:	48 83 ec 18          	sub    $0x18,%rsp
   41e0c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e10:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41e14:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41e17:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41e1a:	48 98                	cltq   
   41e1c:	48 c1 e0 2d          	shl    $0x2d,%rax
   41e20:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41e24:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41e2b:	90 00 00 
   41e2e:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41e31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e35:	48 89 10             	mov    %rdx,(%rax)
}
   41e38:	90                   	nop
   41e39:	c9                   	leave  
   41e3a:	c3                   	ret    

0000000000041e3b <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41e3b:	f3 0f 1e fa          	endbr64 
   41e3f:	55                   	push   %rbp
   41e40:	48 89 e5             	mov    %rsp,%rbp
   41e43:	48 83 ec 28          	sub    $0x28,%rsp
   41e47:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e4b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41e4f:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41e52:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41e56:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41e5a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41e5e:	48 c1 e0 10          	shl    $0x10,%rax
   41e62:	48 89 c2             	mov    %rax,%rdx
   41e65:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41e6c:	00 00 00 
   41e6f:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41e72:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41e76:	48 c1 e0 20          	shl    $0x20,%rax
   41e7a:	48 89 c1             	mov    %rax,%rcx
   41e7d:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41e84:	00 00 ff 
   41e87:	48 21 c8             	and    %rcx,%rax
   41e8a:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41e8d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41e91:	48 83 e8 01          	sub    $0x1,%rax
   41e95:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41e98:	48 09 d0             	or     %rdx,%rax
        | type
   41e9b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41e9f:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41ea2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41ea5:	48 98                	cltq   
   41ea7:	48 c1 e0 2d          	shl    $0x2d,%rax
   41eab:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41eae:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41eb5:	80 00 00 
   41eb8:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41ebb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ebf:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41ec2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ec6:	48 83 c0 08          	add    $0x8,%rax
   41eca:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41ece:	48 c1 ea 20          	shr    $0x20,%rdx
   41ed2:	48 89 10             	mov    %rdx,(%rax)
}
   41ed5:	90                   	nop
   41ed6:	c9                   	leave  
   41ed7:	c3                   	ret    

0000000000041ed8 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41ed8:	f3 0f 1e fa          	endbr64 
   41edc:	55                   	push   %rbp
   41edd:	48 89 e5             	mov    %rsp,%rbp
   41ee0:	48 83 ec 20          	sub    $0x20,%rsp
   41ee4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41ee8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41eec:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41eef:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41ef3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41ef7:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41efa:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41efe:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41f01:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41f04:	48 98                	cltq   
   41f06:	48 c1 e0 2d          	shl    $0x2d,%rax
   41f0a:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41f0d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41f11:	48 c1 e0 20          	shl    $0x20,%rax
   41f15:	48 89 c1             	mov    %rax,%rcx
   41f18:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41f1f:	00 ff ff 
   41f22:	48 21 c8             	and    %rcx,%rax
   41f25:	48 09 c2             	or     %rax,%rdx
   41f28:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41f2f:	80 00 00 
   41f32:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41f35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f39:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41f3c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41f40:	48 c1 e8 20          	shr    $0x20,%rax
   41f44:	48 89 c2             	mov    %rax,%rdx
   41f47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f4b:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41f4f:	90                   	nop
   41f50:	c9                   	leave  
   41f51:	c3                   	ret    

0000000000041f52 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41f52:	f3 0f 1e fa          	endbr64 
   41f56:	55                   	push   %rbp
   41f57:	48 89 e5             	mov    %rsp,%rbp
   41f5a:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41f5e:	48 c7 05 f7 12 01 00 	movq   $0x0,0x112f7(%rip)        # 53260 <segments>
   41f65:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41f69:	ba 00 00 00 00       	mov    $0x0,%edx
   41f6e:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41f75:	08 20 00 
   41f78:	48 89 c6             	mov    %rax,%rsi
   41f7b:	48 8d 05 e6 12 01 00 	lea    0x112e6(%rip),%rax        # 53268 <segments+0x8>
   41f82:	48 89 c7             	mov    %rax,%rdi
   41f85:	e8 76 fe ff ff       	call   41e00 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41f8a:	ba 03 00 00 00       	mov    $0x3,%edx
   41f8f:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41f96:	08 20 00 
   41f99:	48 89 c6             	mov    %rax,%rsi
   41f9c:	48 8d 05 cd 12 01 00 	lea    0x112cd(%rip),%rax        # 53270 <segments+0x10>
   41fa3:	48 89 c7             	mov    %rax,%rdi
   41fa6:	e8 55 fe ff ff       	call   41e00 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41fab:	ba 00 00 00 00       	mov    $0x0,%edx
   41fb0:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41fb7:	02 00 00 
   41fba:	48 89 c6             	mov    %rax,%rsi
   41fbd:	48 8d 05 b4 12 01 00 	lea    0x112b4(%rip),%rax        # 53278 <segments+0x18>
   41fc4:	48 89 c7             	mov    %rax,%rdi
   41fc7:	e8 34 fe ff ff       	call   41e00 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41fcc:	ba 03 00 00 00       	mov    $0x3,%edx
   41fd1:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41fd8:	02 00 00 
   41fdb:	48 89 c6             	mov    %rax,%rsi
   41fde:	48 8d 05 9b 12 01 00 	lea    0x1129b(%rip),%rax        # 53280 <segments+0x20>
   41fe5:	48 89 c7             	mov    %rax,%rdi
   41fe8:	e8 13 fe ff ff       	call   41e00 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41fed:	48 8d 05 ac 22 01 00 	lea    0x122ac(%rip),%rax        # 542a0 <kernel_task_descriptor>
   41ff4:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41ffa:	48 89 c1             	mov    %rax,%rcx
   41ffd:	ba 00 00 00 00       	mov    $0x0,%edx
   42002:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   42009:	09 00 00 
   4200c:	48 89 c6             	mov    %rax,%rsi
   4200f:	48 8d 05 72 12 01 00 	lea    0x11272(%rip),%rax        # 53288 <segments+0x28>
   42016:	48 89 c7             	mov    %rax,%rdi
   42019:	e8 1d fe ff ff       	call   41e3b <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   4201e:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   42024:	48 8d 05 35 12 01 00 	lea    0x11235(%rip),%rax        # 53260 <segments>
   4202b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   4202f:	ba 60 00 00 00       	mov    $0x60,%edx
   42034:	be 00 00 00 00       	mov    $0x0,%esi
   42039:	48 8d 05 60 22 01 00 	lea    0x12260(%rip),%rax        # 542a0 <kernel_task_descriptor>
   42040:	48 89 c7             	mov    %rax,%rdi
   42043:	e8 45 1b 00 00       	call   43b8d <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   42048:	48 c7 05 51 22 01 00 	movq   $0x80000,0x12251(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   4204f:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   42053:	ba 00 10 00 00       	mov    $0x1000,%edx
   42058:	be 00 00 00 00       	mov    $0x0,%esi
   4205d:	48 8d 05 3c 12 01 00 	lea    0x1123c(%rip),%rax        # 532a0 <interrupt_descriptors>
   42064:	48 89 c7             	mov    %rax,%rdi
   42067:	e8 21 1b 00 00       	call   43b8d <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4206c:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   42073:	eb 3c                	jmp    420b1 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   42075:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   4207c:	48 89 c2             	mov    %rax,%rdx
   4207f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42082:	48 c1 e0 04          	shl    $0x4,%rax
   42086:	48 89 c1             	mov    %rax,%rcx
   42089:	48 8d 05 10 12 01 00 	lea    0x11210(%rip),%rax        # 532a0 <interrupt_descriptors>
   42090:	48 01 c8             	add    %rcx,%rax
   42093:	48 89 d1             	mov    %rdx,%rcx
   42096:	ba 00 00 00 00       	mov    $0x0,%edx
   4209b:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   420a2:	0e 00 00 
   420a5:	48 89 c7             	mov    %rax,%rdi
   420a8:	e8 2b fe ff ff       	call   41ed8 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   420ad:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   420b1:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   420b8:	76 bb                	jbe    42075 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   420ba:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   420c1:	48 89 c1             	mov    %rax,%rcx
   420c4:	ba 00 00 00 00       	mov    $0x0,%edx
   420c9:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   420d0:	0e 00 00 
   420d3:	48 89 c6             	mov    %rax,%rsi
   420d6:	48 8d 05 c3 13 01 00 	lea    0x113c3(%rip),%rax        # 534a0 <interrupt_descriptors+0x200>
   420dd:	48 89 c7             	mov    %rax,%rdi
   420e0:	e8 f3 fd ff ff       	call   41ed8 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   420e5:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   420ec:	48 89 c1             	mov    %rax,%rcx
   420ef:	ba 00 00 00 00       	mov    $0x0,%edx
   420f4:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   420fb:	0e 00 00 
   420fe:	48 89 c6             	mov    %rax,%rsi
   42101:	48 8d 05 68 12 01 00 	lea    0x11268(%rip),%rax        # 53370 <interrupt_descriptors+0xd0>
   42108:	48 89 c7             	mov    %rax,%rdi
   4210b:	e8 c8 fd ff ff       	call   41ed8 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   42110:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   42117:	48 89 c1             	mov    %rax,%rcx
   4211a:	ba 00 00 00 00       	mov    $0x0,%edx
   4211f:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   42126:	0e 00 00 
   42129:	48 89 c6             	mov    %rax,%rsi
   4212c:	48 8d 05 4d 12 01 00 	lea    0x1124d(%rip),%rax        # 53380 <interrupt_descriptors+0xe0>
   42133:	48 89 c7             	mov    %rax,%rdi
   42136:	e8 9d fd ff ff       	call   41ed8 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4213b:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   42142:	eb 50                	jmp    42194 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   42144:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42147:	83 e8 30             	sub    $0x30,%eax
   4214a:	89 c0                	mov    %eax,%eax
   4214c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   42153:	00 
   42154:	48 8d 05 8c df ff ff 	lea    -0x2074(%rip),%rax        # 400e7 <sys_int_handlers>
   4215b:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   4215f:	48 89 c2             	mov    %rax,%rdx
   42162:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42165:	48 c1 e0 04          	shl    $0x4,%rax
   42169:	48 89 c1             	mov    %rax,%rcx
   4216c:	48 8d 05 2d 11 01 00 	lea    0x1112d(%rip),%rax        # 532a0 <interrupt_descriptors>
   42173:	48 01 c8             	add    %rcx,%rax
   42176:	48 89 d1             	mov    %rdx,%rcx
   42179:	ba 03 00 00 00       	mov    $0x3,%edx
   4217e:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   42185:	0e 00 00 
   42188:	48 89 c7             	mov    %rax,%rdi
   4218b:	e8 48 fd ff ff       	call   41ed8 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   42190:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42194:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   42198:	76 aa                	jbe    42144 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4219a:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   421a0:	48 8d 05 f9 10 01 00 	lea    0x110f9(%rip),%rax        # 532a0 <interrupt_descriptors>
   421a7:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   421ab:	b8 28 00 00 00       	mov    $0x28,%eax
   421b0:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   421b4:	0f 00 d8             	ltr    %ax
   421b7:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   421bb:	0f 20 c0             	mov    %cr0,%rax
   421be:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   421c2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   421c6:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   421c9:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   421d0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   421d3:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   421d6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421d9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   421dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   421e1:	0f 22 c0             	mov    %rax,%cr0
}
   421e4:	90                   	nop
    lcr0(cr0);
}
   421e5:	90                   	nop
   421e6:	c9                   	leave  
   421e7:	c3                   	ret    

00000000000421e8 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   421e8:	f3 0f 1e fa          	endbr64 
   421ec:	55                   	push   %rbp
   421ed:	48 89 e5             	mov    %rsp,%rbp
   421f0:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   421f4:	0f b7 05 05 21 01 00 	movzwl 0x12105(%rip),%eax        # 54300 <interrupts_enabled>
   421fb:	f7 d0                	not    %eax
   421fd:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   42201:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   42205:	0f b6 c0             	movzbl %al,%eax
   42208:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   4220f:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42212:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42216:	8b 55 f0             	mov    -0x10(%rbp),%edx
   42219:	ee                   	out    %al,(%dx)
}
   4221a:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   4221b:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   4221f:	66 c1 e8 08          	shr    $0x8,%ax
   42223:	0f b6 c0             	movzbl %al,%eax
   42226:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   4222d:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42230:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42234:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42237:	ee                   	out    %al,(%dx)
}
   42238:	90                   	nop
}
   42239:	90                   	nop
   4223a:	c9                   	leave  
   4223b:	c3                   	ret    

000000000004223c <interrupt_init>:

void interrupt_init(void) {
   4223c:	f3 0f 1e fa          	endbr64 
   42240:	55                   	push   %rbp
   42241:	48 89 e5             	mov    %rsp,%rbp
   42244:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   42248:	66 c7 05 af 20 01 00 	movw   $0x0,0x120af(%rip)        # 54300 <interrupts_enabled>
   4224f:	00 00 
    interrupt_mask();
   42251:	e8 92 ff ff ff       	call   421e8 <interrupt_mask>
   42256:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   4225d:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42261:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   42265:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   42268:	ee                   	out    %al,(%dx)
}
   42269:	90                   	nop
   4226a:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   42271:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42275:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   42279:	8b 55 ac             	mov    -0x54(%rbp),%edx
   4227c:	ee                   	out    %al,(%dx)
}
   4227d:	90                   	nop
   4227e:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   42285:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42289:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   4228d:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   42290:	ee                   	out    %al,(%dx)
}
   42291:	90                   	nop
   42292:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   42299:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4229d:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   422a1:	8b 55 bc             	mov    -0x44(%rbp),%edx
   422a4:	ee                   	out    %al,(%dx)
}
   422a5:	90                   	nop
   422a6:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   422ad:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422b1:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   422b5:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   422b8:	ee                   	out    %al,(%dx)
}
   422b9:	90                   	nop
   422ba:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   422c1:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422c5:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   422c9:	8b 55 cc             	mov    -0x34(%rbp),%edx
   422cc:	ee                   	out    %al,(%dx)
}
   422cd:	90                   	nop
   422ce:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   422d5:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422d9:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   422dd:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   422e0:	ee                   	out    %al,(%dx)
}
   422e1:	90                   	nop
   422e2:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   422e9:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422ed:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   422f1:	8b 55 dc             	mov    -0x24(%rbp),%edx
   422f4:	ee                   	out    %al,(%dx)
}
   422f5:	90                   	nop
   422f6:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   422fd:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42301:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42305:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42308:	ee                   	out    %al,(%dx)
}
   42309:	90                   	nop
   4230a:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   42311:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42315:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42319:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4231c:	ee                   	out    %al,(%dx)
}
   4231d:	90                   	nop
   4231e:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   42325:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42329:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4232d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42330:	ee                   	out    %al,(%dx)
}
   42331:	90                   	nop
   42332:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   42339:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4233d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42341:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42344:	ee                   	out    %al,(%dx)
}
   42345:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   42346:	e8 9d fe ff ff       	call   421e8 <interrupt_mask>
}
   4234b:	90                   	nop
   4234c:	c9                   	leave  
   4234d:	c3                   	ret    

000000000004234e <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   4234e:	f3 0f 1e fa          	endbr64 
   42352:	55                   	push   %rbp
   42353:	48 89 e5             	mov    %rsp,%rbp
   42356:	48 83 ec 28          	sub    $0x28,%rsp
   4235a:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   4235d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42361:	0f 8e 9f 00 00 00    	jle    42406 <timer_init+0xb8>
   42367:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   4236e:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42372:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42376:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42379:	ee                   	out    %al,(%dx)
}
   4237a:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   4237b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4237e:	89 c2                	mov    %eax,%edx
   42380:	c1 ea 1f             	shr    $0x1f,%edx
   42383:	01 d0                	add    %edx,%eax
   42385:	d1 f8                	sar    %eax
   42387:	05 de 34 12 00       	add    $0x1234de,%eax
   4238c:	99                   	cltd   
   4238d:	f7 7d dc             	idivl  -0x24(%rbp)
   42390:	89 c2                	mov    %eax,%edx
   42392:	89 d0                	mov    %edx,%eax
   42394:	c1 f8 1f             	sar    $0x1f,%eax
   42397:	c1 e8 18             	shr    $0x18,%eax
   4239a:	89 c1                	mov    %eax,%ecx
   4239c:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   4239f:	0f b6 c0             	movzbl %al,%eax
   423a2:	29 c8                	sub    %ecx,%eax
   423a4:	0f b6 c0             	movzbl %al,%eax
   423a7:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   423ae:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423b1:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   423b5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   423b8:	ee                   	out    %al,(%dx)
}
   423b9:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   423ba:	8b 45 dc             	mov    -0x24(%rbp),%eax
   423bd:	89 c2                	mov    %eax,%edx
   423bf:	c1 ea 1f             	shr    $0x1f,%edx
   423c2:	01 d0                	add    %edx,%eax
   423c4:	d1 f8                	sar    %eax
   423c6:	05 de 34 12 00       	add    $0x1234de,%eax
   423cb:	99                   	cltd   
   423cc:	f7 7d dc             	idivl  -0x24(%rbp)
   423cf:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   423d5:	85 c0                	test   %eax,%eax
   423d7:	0f 48 c2             	cmovs  %edx,%eax
   423da:	c1 f8 08             	sar    $0x8,%eax
   423dd:	0f b6 c0             	movzbl %al,%eax
   423e0:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   423e7:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423ea:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   423ee:	8b 55 fc             	mov    -0x4(%rbp),%edx
   423f1:	ee                   	out    %al,(%dx)
}
   423f2:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   423f3:	0f b7 05 06 1f 01 00 	movzwl 0x11f06(%rip),%eax        # 54300 <interrupts_enabled>
   423fa:	83 c8 01             	or     $0x1,%eax
   423fd:	66 89 05 fc 1e 01 00 	mov    %ax,0x11efc(%rip)        # 54300 <interrupts_enabled>
   42404:	eb 11                	jmp    42417 <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   42406:	0f b7 05 f3 1e 01 00 	movzwl 0x11ef3(%rip),%eax        # 54300 <interrupts_enabled>
   4240d:	83 e0 fe             	and    $0xfffffffe,%eax
   42410:	66 89 05 e9 1e 01 00 	mov    %ax,0x11ee9(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   42417:	e8 cc fd ff ff       	call   421e8 <interrupt_mask>
}
   4241c:	90                   	nop
   4241d:	c9                   	leave  
   4241e:	c3                   	ret    

000000000004241f <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   4241f:	f3 0f 1e fa          	endbr64 
   42423:	55                   	push   %rbp
   42424:	48 89 e5             	mov    %rsp,%rbp
   42427:	48 83 ec 08          	sub    $0x8,%rsp
   4242b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   4242f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   42434:	74 14                	je     4244a <physical_memory_isreserved+0x2b>
   42436:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   4243d:	00 
   4243e:	76 11                	jbe    42451 <physical_memory_isreserved+0x32>
   42440:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   42447:	00 
   42448:	77 07                	ja     42451 <physical_memory_isreserved+0x32>
   4244a:	b8 01 00 00 00       	mov    $0x1,%eax
   4244f:	eb 05                	jmp    42456 <physical_memory_isreserved+0x37>
   42451:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42456:	c9                   	leave  
   42457:	c3                   	ret    

0000000000042458 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   42458:	f3 0f 1e fa          	endbr64 
   4245c:	55                   	push   %rbp
   4245d:	48 89 e5             	mov    %rsp,%rbp
   42460:	48 83 ec 10          	sub    $0x10,%rsp
   42464:	89 7d fc             	mov    %edi,-0x4(%rbp)
   42467:	89 75 f8             	mov    %esi,-0x8(%rbp)
   4246a:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   4246d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42470:	c1 e0 10             	shl    $0x10,%eax
   42473:	89 c2                	mov    %eax,%edx
   42475:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42478:	c1 e0 0b             	shl    $0xb,%eax
   4247b:	09 c2                	or     %eax,%edx
   4247d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42480:	c1 e0 08             	shl    $0x8,%eax
   42483:	09 d0                	or     %edx,%eax
}
   42485:	c9                   	leave  
   42486:	c3                   	ret    

0000000000042487 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   42487:	f3 0f 1e fa          	endbr64 
   4248b:	55                   	push   %rbp
   4248c:	48 89 e5             	mov    %rsp,%rbp
   4248f:	48 83 ec 18          	sub    $0x18,%rsp
   42493:	89 7d ec             	mov    %edi,-0x14(%rbp)
   42496:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   42499:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4249c:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4249f:	09 d0                	or     %edx,%eax
   424a1:	0d 00 00 00 80       	or     $0x80000000,%eax
   424a6:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   424ad:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   424b0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424b3:	8b 55 f4             	mov    -0xc(%rbp),%edx
   424b6:	ef                   	out    %eax,(%dx)
}
   424b7:	90                   	nop
   424b8:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   424bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   424c2:	89 c2                	mov    %eax,%edx
   424c4:	ed                   	in     (%dx),%eax
   424c5:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   424c8:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   424cb:	c9                   	leave  
   424cc:	c3                   	ret    

00000000000424cd <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   424cd:	f3 0f 1e fa          	endbr64 
   424d1:	55                   	push   %rbp
   424d2:	48 89 e5             	mov    %rsp,%rbp
   424d5:	48 83 ec 28          	sub    $0x28,%rsp
   424d9:	89 7d dc             	mov    %edi,-0x24(%rbp)
   424dc:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   424df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   424e6:	eb 73                	jmp    4255b <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   424e8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   424ef:	eb 60                	jmp    42551 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   424f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   424f8:	eb 4a                	jmp    42544 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   424fa:	8b 55 f4             	mov    -0xc(%rbp),%edx
   424fd:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   42500:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42503:	89 ce                	mov    %ecx,%esi
   42505:	89 c7                	mov    %eax,%edi
   42507:	e8 4c ff ff ff       	call   42458 <pci_make_configaddr>
   4250c:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   4250f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42512:	be 00 00 00 00       	mov    $0x0,%esi
   42517:	89 c7                	mov    %eax,%edi
   42519:	e8 69 ff ff ff       	call   42487 <pci_config_readl>
   4251e:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   42521:	8b 45 d8             	mov    -0x28(%rbp),%eax
   42524:	c1 e0 10             	shl    $0x10,%eax
   42527:	0b 45 dc             	or     -0x24(%rbp),%eax
   4252a:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   4252d:	75 05                	jne    42534 <pci_find_device+0x67>
                    return configaddr;
   4252f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42532:	eb 35                	jmp    42569 <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   42534:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   42538:	75 06                	jne    42540 <pci_find_device+0x73>
   4253a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4253e:	74 0c                	je     4254c <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   42540:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42544:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   42548:	75 b0                	jne    424fa <pci_find_device+0x2d>
   4254a:	eb 01                	jmp    4254d <pci_find_device+0x80>
                    break;
   4254c:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   4254d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42551:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   42555:	75 9a                	jne    424f1 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   42557:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4255b:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42562:	75 84                	jne    424e8 <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   42564:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   42569:	c9                   	leave  
   4256a:	c3                   	ret    

000000000004256b <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   4256b:	f3 0f 1e fa          	endbr64 
   4256f:	55                   	push   %rbp
   42570:	48 89 e5             	mov    %rsp,%rbp
   42573:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42577:	be 13 71 00 00       	mov    $0x7113,%esi
   4257c:	bf 86 80 00 00       	mov    $0x8086,%edi
   42581:	e8 47 ff ff ff       	call   424cd <pci_find_device>
   42586:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   42589:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4258d:	78 30                	js     425bf <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   4258f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42592:	be 40 00 00 00       	mov    $0x40,%esi
   42597:	89 c7                	mov    %eax,%edi
   42599:	e8 e9 fe ff ff       	call   42487 <pci_config_readl>
   4259e:	25 c0 ff 00 00       	and    $0xffc0,%eax
   425a3:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   425a6:	8b 45 f8             	mov    -0x8(%rbp),%eax
   425a9:	83 c0 04             	add    $0x4,%eax
   425ac:	89 45 f4             	mov    %eax,-0xc(%rbp)
   425af:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   425b5:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   425b9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   425bc:	66 ef                	out    %ax,(%dx)
}
   425be:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   425bf:	48 8d 05 3a 29 00 00 	lea    0x293a(%rip),%rax        # 44f00 <memstate_colors+0xc0>
   425c6:	48 89 c2             	mov    %rax,%rdx
   425c9:	be 00 c0 00 00       	mov    $0xc000,%esi
   425ce:	bf 80 07 00 00       	mov    $0x780,%edi
   425d3:	b8 00 00 00 00       	mov    $0x0,%eax
   425d8:	e8 ef 23 00 00       	call   449cc <console_printf>
 spinloop: goto spinloop;
   425dd:	eb fe                	jmp    425dd <poweroff+0x72>

00000000000425df <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   425df:	f3 0f 1e fa          	endbr64 
   425e3:	55                   	push   %rbp
   425e4:	48 89 e5             	mov    %rsp,%rbp
   425e7:	48 83 ec 10          	sub    $0x10,%rsp
   425eb:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   425f2:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   425f6:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   425fa:	8b 55 fc             	mov    -0x4(%rbp),%edx
   425fd:	ee                   	out    %al,(%dx)
}
   425fe:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   425ff:	eb fe                	jmp    425ff <reboot+0x20>

0000000000042601 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42601:	f3 0f 1e fa          	endbr64 
   42605:	55                   	push   %rbp
   42606:	48 89 e5             	mov    %rsp,%rbp
   42609:	48 83 ec 10          	sub    $0x10,%rsp
   4260d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42611:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   42614:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42618:	48 83 c0 08          	add    $0x8,%rax
   4261c:	ba c0 00 00 00       	mov    $0xc0,%edx
   42621:	be 00 00 00 00       	mov    $0x0,%esi
   42626:	48 89 c7             	mov    %rax,%rdi
   42629:	e8 5f 15 00 00       	call   43b8d <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   4262e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42632:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   42639:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   4263b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4263f:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   42646:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   4264a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4264e:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   42655:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   42659:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4265d:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   42664:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   42666:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4266a:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   42671:	00 02 00 00 
    p->display_status = 1;
   42675:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42679:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42680:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42683:	83 e0 01             	and    $0x1,%eax
   42686:	85 c0                	test   %eax,%eax
   42688:	74 1c                	je     426a6 <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4268a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4268e:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42695:	80 cc 30             	or     $0x30,%ah
   42698:	48 89 c2             	mov    %rax,%rdx
   4269b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4269f:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   426a6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   426a9:	83 e0 02             	and    $0x2,%eax
   426ac:	85 c0                	test   %eax,%eax
   426ae:	74 1c                	je     426cc <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   426b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426b4:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   426bb:	80 e4 fd             	and    $0xfd,%ah
   426be:	48 89 c2             	mov    %rax,%rdx
   426c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426c5:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   426cc:	90                   	nop
   426cd:	c9                   	leave  
   426ce:	c3                   	ret    

00000000000426cf <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   426cf:	f3 0f 1e fa          	endbr64 
   426d3:	55                   	push   %rbp
   426d4:	48 89 e5             	mov    %rsp,%rbp
   426d7:	48 83 ec 28          	sub    $0x28,%rsp
   426db:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   426de:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   426e2:	78 09                	js     426ed <console_show_cursor+0x1e>
   426e4:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   426eb:	7e 07                	jle    426f4 <console_show_cursor+0x25>
        cpos = 0;
   426ed:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   426f4:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   426fb:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426ff:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42703:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42706:	ee                   	out    %al,(%dx)
}
   42707:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   42708:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4270b:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42711:	85 c0                	test   %eax,%eax
   42713:	0f 48 c2             	cmovs  %edx,%eax
   42716:	c1 f8 08             	sar    $0x8,%eax
   42719:	0f b6 c0             	movzbl %al,%eax
   4271c:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42723:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42726:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4272a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4272d:	ee                   	out    %al,(%dx)
}
   4272e:	90                   	nop
   4272f:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42736:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4273a:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4273e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42741:	ee                   	out    %al,(%dx)
}
   42742:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42743:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42746:	99                   	cltd   
   42747:	c1 ea 18             	shr    $0x18,%edx
   4274a:	01 d0                	add    %edx,%eax
   4274c:	0f b6 c0             	movzbl %al,%eax
   4274f:	29 d0                	sub    %edx,%eax
   42751:	0f b6 c0             	movzbl %al,%eax
   42754:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   4275b:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4275e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42762:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42765:	ee                   	out    %al,(%dx)
}
   42766:	90                   	nop
}
   42767:	90                   	nop
   42768:	c9                   	leave  
   42769:	c3                   	ret    

000000000004276a <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   4276a:	f3 0f 1e fa          	endbr64 
   4276e:	55                   	push   %rbp
   4276f:	48 89 e5             	mov    %rsp,%rbp
   42772:	48 83 ec 20          	sub    $0x20,%rsp
   42776:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4277d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42780:	89 c2                	mov    %eax,%edx
   42782:	ec                   	in     (%dx),%al
   42783:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42786:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   4278a:	0f b6 c0             	movzbl %al,%eax
   4278d:	83 e0 01             	and    $0x1,%eax
   42790:	85 c0                	test   %eax,%eax
   42792:	75 0a                	jne    4279e <keyboard_readc+0x34>
        return -1;
   42794:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42799:	e9 fd 01 00 00       	jmp    4299b <keyboard_readc+0x231>
   4279e:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   427a5:	8b 45 e8             	mov    -0x18(%rbp),%eax
   427a8:	89 c2                	mov    %eax,%edx
   427aa:	ec                   	in     (%dx),%al
   427ab:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   427ae:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   427b2:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   427b5:	0f b6 05 46 1b 01 00 	movzbl 0x11b46(%rip),%eax        # 54302 <last_escape.2>
   427bc:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   427bf:	c6 05 3c 1b 01 00 00 	movb   $0x0,0x11b3c(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   427c6:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   427ca:	75 11                	jne    427dd <keyboard_readc+0x73>
        last_escape = 0x80;
   427cc:	c6 05 2f 1b 01 00 80 	movb   $0x80,0x11b2f(%rip)        # 54302 <last_escape.2>
        return 0;
   427d3:	b8 00 00 00 00       	mov    $0x0,%eax
   427d8:	e9 be 01 00 00       	jmp    4299b <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   427dd:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   427e1:	84 c0                	test   %al,%al
   427e3:	79 64                	jns    42849 <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   427e5:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   427e9:	83 e0 7f             	and    $0x7f,%eax
   427ec:	89 c2                	mov    %eax,%edx
   427ee:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   427f2:	09 d0                	or     %edx,%eax
   427f4:	48 98                	cltq   
   427f6:	48 8d 15 23 27 00 00 	lea    0x2723(%rip),%rdx        # 44f20 <keymap>
   427fd:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42801:	0f b6 c0             	movzbl %al,%eax
   42804:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42807:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   4280e:	7e 2f                	jle    4283f <keyboard_readc+0xd5>
   42810:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42817:	7f 26                	jg     4283f <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42819:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4281c:	2d fa 00 00 00       	sub    $0xfa,%eax
   42821:	ba 01 00 00 00       	mov    $0x1,%edx
   42826:	89 c1                	mov    %eax,%ecx
   42828:	d3 e2                	shl    %cl,%edx
   4282a:	89 d0                	mov    %edx,%eax
   4282c:	f7 d0                	not    %eax
   4282e:	89 c2                	mov    %eax,%edx
   42830:	0f b6 05 cc 1a 01 00 	movzbl 0x11acc(%rip),%eax        # 54303 <modifiers.1>
   42837:	21 d0                	and    %edx,%eax
   42839:	88 05 c4 1a 01 00    	mov    %al,0x11ac4(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   4283f:	b8 00 00 00 00       	mov    $0x0,%eax
   42844:	e9 52 01 00 00       	jmp    4299b <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   42849:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4284d:	0a 45 fa             	or     -0x6(%rbp),%al
   42850:	0f b6 c0             	movzbl %al,%eax
   42853:	48 98                	cltq   
   42855:	48 8d 15 c4 26 00 00 	lea    0x26c4(%rip),%rdx        # 44f20 <keymap>
   4285c:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42860:	0f b6 c0             	movzbl %al,%eax
   42863:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42866:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4286a:	7e 57                	jle    428c3 <keyboard_readc+0x159>
   4286c:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42870:	7f 51                	jg     428c3 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   42872:	0f b6 05 8a 1a 01 00 	movzbl 0x11a8a(%rip),%eax        # 54303 <modifiers.1>
   42879:	0f b6 c0             	movzbl %al,%eax
   4287c:	83 e0 02             	and    $0x2,%eax
   4287f:	85 c0                	test   %eax,%eax
   42881:	74 09                	je     4288c <keyboard_readc+0x122>
            ch -= 0x60;
   42883:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42887:	e9 0b 01 00 00       	jmp    42997 <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4288c:	0f b6 05 70 1a 01 00 	movzbl 0x11a70(%rip),%eax        # 54303 <modifiers.1>
   42893:	0f b6 c0             	movzbl %al,%eax
   42896:	83 e0 01             	and    $0x1,%eax
   42899:	85 c0                	test   %eax,%eax
   4289b:	0f 94 c2             	sete   %dl
   4289e:	0f b6 05 5e 1a 01 00 	movzbl 0x11a5e(%rip),%eax        # 54303 <modifiers.1>
   428a5:	0f b6 c0             	movzbl %al,%eax
   428a8:	83 e0 08             	and    $0x8,%eax
   428ab:	85 c0                	test   %eax,%eax
   428ad:	0f 94 c0             	sete   %al
   428b0:	31 d0                	xor    %edx,%eax
   428b2:	84 c0                	test   %al,%al
   428b4:	0f 84 dd 00 00 00    	je     42997 <keyboard_readc+0x22d>
            ch -= 0x20;
   428ba:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   428be:	e9 d4 00 00 00       	jmp    42997 <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   428c3:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   428ca:	7e 30                	jle    428fc <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   428cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   428cf:	2d fa 00 00 00       	sub    $0xfa,%eax
   428d4:	ba 01 00 00 00       	mov    $0x1,%edx
   428d9:	89 c1                	mov    %eax,%ecx
   428db:	d3 e2                	shl    %cl,%edx
   428dd:	89 d0                	mov    %edx,%eax
   428df:	89 c2                	mov    %eax,%edx
   428e1:	0f b6 05 1b 1a 01 00 	movzbl 0x11a1b(%rip),%eax        # 54303 <modifiers.1>
   428e8:	31 d0                	xor    %edx,%eax
   428ea:	88 05 13 1a 01 00    	mov    %al,0x11a13(%rip)        # 54303 <modifiers.1>
        ch = 0;
   428f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   428f7:	e9 9c 00 00 00       	jmp    42998 <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   428fc:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42903:	7e 2d                	jle    42932 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42905:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42908:	2d fa 00 00 00       	sub    $0xfa,%eax
   4290d:	ba 01 00 00 00       	mov    $0x1,%edx
   42912:	89 c1                	mov    %eax,%ecx
   42914:	d3 e2                	shl    %cl,%edx
   42916:	89 d0                	mov    %edx,%eax
   42918:	89 c2                	mov    %eax,%edx
   4291a:	0f b6 05 e2 19 01 00 	movzbl 0x119e2(%rip),%eax        # 54303 <modifiers.1>
   42921:	09 d0                	or     %edx,%eax
   42923:	88 05 da 19 01 00    	mov    %al,0x119da(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42929:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42930:	eb 66                	jmp    42998 <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42932:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42936:	7e 3f                	jle    42977 <keyboard_readc+0x20d>
   42938:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   4293f:	7f 36                	jg     42977 <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42941:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42944:	8d 50 80             	lea    -0x80(%rax),%edx
   42947:	0f b6 05 b5 19 01 00 	movzbl 0x119b5(%rip),%eax        # 54303 <modifiers.1>
   4294e:	0f b6 c0             	movzbl %al,%eax
   42951:	83 e0 03             	and    $0x3,%eax
   42954:	48 63 c8             	movslq %eax,%rcx
   42957:	48 63 c2             	movslq %edx,%rax
   4295a:	48 c1 e0 02          	shl    $0x2,%rax
   4295e:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   42962:	48 8d 05 b7 26 00 00 	lea    0x26b7(%rip),%rax        # 45020 <complex_keymap>
   42969:	48 01 d0             	add    %rdx,%rax
   4296c:	0f b6 00             	movzbl (%rax),%eax
   4296f:	0f b6 c0             	movzbl %al,%eax
   42972:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42975:	eb 21                	jmp    42998 <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42977:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4297b:	7f 1b                	jg     42998 <keyboard_readc+0x22e>
   4297d:	0f b6 05 7f 19 01 00 	movzbl 0x1197f(%rip),%eax        # 54303 <modifiers.1>
   42984:	0f b6 c0             	movzbl %al,%eax
   42987:	83 e0 02             	and    $0x2,%eax
   4298a:	85 c0                	test   %eax,%eax
   4298c:	74 0a                	je     42998 <keyboard_readc+0x22e>
        ch = 0;
   4298e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42995:	eb 01                	jmp    42998 <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   42997:	90                   	nop
    }

    return ch;
   42998:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4299b:	c9                   	leave  
   4299c:	c3                   	ret    

000000000004299d <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   4299d:	f3 0f 1e fa          	endbr64 
   429a1:	55                   	push   %rbp
   429a2:	48 89 e5             	mov    %rsp,%rbp
   429a5:	48 83 ec 20          	sub    $0x20,%rsp
   429a9:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   429b0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   429b3:	89 c2                	mov    %eax,%edx
   429b5:	ec                   	in     (%dx),%al
   429b6:	88 45 e3             	mov    %al,-0x1d(%rbp)
   429b9:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   429c0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   429c3:	89 c2                	mov    %eax,%edx
   429c5:	ec                   	in     (%dx),%al
   429c6:	88 45 eb             	mov    %al,-0x15(%rbp)
   429c9:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   429d0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   429d3:	89 c2                	mov    %eax,%edx
   429d5:	ec                   	in     (%dx),%al
   429d6:	88 45 f3             	mov    %al,-0xd(%rbp)
   429d9:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   429e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   429e3:	89 c2                	mov    %eax,%edx
   429e5:	ec                   	in     (%dx),%al
   429e6:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   429e9:	90                   	nop
   429ea:	c9                   	leave  
   429eb:	c3                   	ret    

00000000000429ec <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   429ec:	f3 0f 1e fa          	endbr64 
   429f0:	55                   	push   %rbp
   429f1:	48 89 e5             	mov    %rsp,%rbp
   429f4:	48 83 ec 40          	sub    $0x40,%rsp
   429f8:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   429fc:	89 f0                	mov    %esi,%eax
   429fe:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42a01:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42a04:	8b 05 fa 18 01 00    	mov    0x118fa(%rip),%eax        # 54304 <initialized.0>
   42a0a:	85 c0                	test   %eax,%eax
   42a0c:	75 1e                	jne    42a2c <parallel_port_putc+0x40>
   42a0e:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42a15:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42a19:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42a1d:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42a20:	ee                   	out    %al,(%dx)
}
   42a21:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42a22:	c7 05 d8 18 01 00 01 	movl   $0x1,0x118d8(%rip)        # 54304 <initialized.0>
   42a29:	00 00 00 
    }

    for (int i = 0;
   42a2c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42a33:	eb 09                	jmp    42a3e <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42a35:	e8 63 ff ff ff       	call   4299d <delay>
         ++i) {
   42a3a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42a3e:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42a45:	7f 18                	jg     42a5f <parallel_port_putc+0x73>
   42a47:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42a4e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42a51:	89 c2                	mov    %eax,%edx
   42a53:	ec                   	in     (%dx),%al
   42a54:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42a57:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42a5b:	84 c0                	test   %al,%al
   42a5d:	79 d6                	jns    42a35 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   42a5f:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42a63:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42a6a:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42a6d:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42a71:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42a74:	ee                   	out    %al,(%dx)
}
   42a75:	90                   	nop
   42a76:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42a7d:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42a81:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42a85:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42a88:	ee                   	out    %al,(%dx)
}
   42a89:	90                   	nop
   42a8a:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42a91:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42a95:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42a99:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42a9c:	ee                   	out    %al,(%dx)
}
   42a9d:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42a9e:	90                   	nop
   42a9f:	c9                   	leave  
   42aa0:	c3                   	ret    

0000000000042aa1 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42aa1:	f3 0f 1e fa          	endbr64 
   42aa5:	55                   	push   %rbp
   42aa6:	48 89 e5             	mov    %rsp,%rbp
   42aa9:	48 83 ec 20          	sub    $0x20,%rsp
   42aad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42ab1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42ab5:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 429ec <parallel_port_putc>
   42abc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   42ac0:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42ac4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42ac8:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42acc:	be 00 00 00 00       	mov    $0x0,%esi
   42ad1:	48 89 c7             	mov    %rax,%rdi
   42ad4:	e8 7a 13 00 00       	call   43e53 <printer_vprintf>
}
   42ad9:	90                   	nop
   42ada:	c9                   	leave  
   42adb:	c3                   	ret    

0000000000042adc <log_printf>:

void log_printf(const char* format, ...) {
   42adc:	f3 0f 1e fa          	endbr64 
   42ae0:	55                   	push   %rbp
   42ae1:	48 89 e5             	mov    %rsp,%rbp
   42ae4:	48 83 ec 60          	sub    $0x60,%rsp
   42ae8:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42aec:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42af0:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42af4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42af8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42afc:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42b00:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42b07:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42b0b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42b0f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42b13:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42b17:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42b1b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42b1f:	48 89 d6             	mov    %rdx,%rsi
   42b22:	48 89 c7             	mov    %rax,%rdi
   42b25:	e8 77 ff ff ff       	call   42aa1 <log_vprintf>
    va_end(val);
}
   42b2a:	90                   	nop
   42b2b:	c9                   	leave  
   42b2c:	c3                   	ret    

0000000000042b2d <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42b2d:	f3 0f 1e fa          	endbr64 
   42b31:	55                   	push   %rbp
   42b32:	48 89 e5             	mov    %rsp,%rbp
   42b35:	48 83 ec 40          	sub    $0x40,%rsp
   42b39:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42b3c:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42b3f:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42b43:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42b47:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42b4b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42b4f:	48 8b 0a             	mov    (%rdx),%rcx
   42b52:	48 89 08             	mov    %rcx,(%rax)
   42b55:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42b59:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42b5d:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42b61:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42b65:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42b69:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b6d:	48 89 d6             	mov    %rdx,%rsi
   42b70:	48 89 c7             	mov    %rax,%rdi
   42b73:	e8 29 ff ff ff       	call   42aa1 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42b78:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42b7c:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42b80:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42b83:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42b86:	89 c7                	mov    %eax,%edi
   42b88:	e8 c3 1d 00 00       	call   44950 <console_vprintf>
}
   42b8d:	c9                   	leave  
   42b8e:	c3                   	ret    

0000000000042b8f <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42b8f:	f3 0f 1e fa          	endbr64 
   42b93:	55                   	push   %rbp
   42b94:	48 89 e5             	mov    %rsp,%rbp
   42b97:	48 83 ec 60          	sub    $0x60,%rsp
   42b9b:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42b9e:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42ba1:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42ba5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42ba9:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42bad:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42bb1:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42bb8:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42bbc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42bc0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42bc4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42bc8:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42bcc:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42bd0:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42bd3:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42bd6:	89 c7                	mov    %eax,%edi
   42bd8:	e8 50 ff ff ff       	call   42b2d <error_vprintf>
   42bdd:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42be0:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42be3:	c9                   	leave  
   42be4:	c3                   	ret    

0000000000042be5 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42be5:	f3 0f 1e fa          	endbr64 
   42be9:	55                   	push   %rbp
   42bea:	48 89 e5             	mov    %rsp,%rbp
   42bed:	53                   	push   %rbx
   42bee:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42bf2:	e8 73 fb ff ff       	call   4276a <keyboard_readc>
   42bf7:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42bfa:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42bfe:	74 1c                	je     42c1c <check_keyboard+0x37>
   42c00:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42c04:	74 16                	je     42c1c <check_keyboard+0x37>
   42c06:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42c0a:	74 10                	je     42c1c <check_keyboard+0x37>
   42c0c:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42c10:	74 0a                	je     42c1c <check_keyboard+0x37>
   42c12:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42c16:	0f 85 02 01 00 00    	jne    42d1e <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42c1c:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42c23:	00 
        memset(pt, 0, PAGESIZE * 3);
   42c24:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c28:	ba 00 30 00 00       	mov    $0x3000,%edx
   42c2d:	be 00 00 00 00       	mov    $0x0,%esi
   42c32:	48 89 c7             	mov    %rax,%rdi
   42c35:	e8 53 0f 00 00       	call   43b8d <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42c3a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c3e:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42c45:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c49:	48 05 00 10 00 00    	add    $0x1000,%rax
   42c4f:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42c56:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c5a:	48 05 00 20 00 00    	add    $0x2000,%rax
   42c60:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42c67:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c6b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42c6f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c73:	0f 22 d8             	mov    %rax,%cr3
}
   42c76:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42c77:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42c7e:	48 8d 05 f3 23 00 00 	lea    0x23f3(%rip),%rax        # 45078 <complex_keymap+0x58>
   42c85:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   42c89:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42c8d:	75 0d                	jne    42c9c <check_keyboard+0xb7>
            argument = "allocator";
   42c8f:	48 8d 05 e7 23 00 00 	lea    0x23e7(%rip),%rax        # 4507d <complex_keymap+0x5d>
   42c96:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42c9a:	eb 37                	jmp    42cd3 <check_keyboard+0xee>
        } else if (c == 'e') {
   42c9c:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42ca0:	75 0d                	jne    42caf <check_keyboard+0xca>
            argument = "forkexit";
   42ca2:	48 8d 05 de 23 00 00 	lea    0x23de(%rip),%rax        # 45087 <complex_keymap+0x67>
   42ca9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42cad:	eb 24                	jmp    42cd3 <check_keyboard+0xee>
        }
        else if (c == 't'){
   42caf:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42cb3:	75 0d                	jne    42cc2 <check_keyboard+0xdd>
            argument = "test";
   42cb5:	48 8d 05 d4 23 00 00 	lea    0x23d4(%rip),%rax        # 45090 <complex_keymap+0x70>
   42cbc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42cc0:	eb 11                	jmp    42cd3 <check_keyboard+0xee>
        }
        else if(c == '2'){
   42cc2:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42cc6:	75 0b                	jne    42cd3 <check_keyboard+0xee>
            argument = "test2";
   42cc8:	48 8d 05 c6 23 00 00 	lea    0x23c6(%rip),%rax        # 45095 <complex_keymap+0x75>
   42ccf:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42cd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cd7:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42cdb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42ce0:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42ce4:	76 1e                	jbe    42d04 <check_keyboard+0x11f>
   42ce6:	48 8d 05 ae 23 00 00 	lea    0x23ae(%rip),%rax        # 4509b <complex_keymap+0x7b>
   42ced:	48 89 c2             	mov    %rax,%rdx
   42cf0:	be 5d 02 00 00       	mov    $0x25d,%esi
   42cf5:	48 8d 05 bb 23 00 00 	lea    0x23bb(%rip),%rax        # 450b7 <complex_keymap+0x97>
   42cfc:	48 89 c7             	mov    %rax,%rdi
   42cff:	e8 33 01 00 00       	call   42e37 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42d04:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42d08:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42d0b:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42d0f:	48 89 c3             	mov    %rax,%rbx
   42d12:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42d17:	e9 e4 d2 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42d1c:	eb 11                	jmp    42d2f <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42d1e:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42d22:	74 06                	je     42d2a <check_keyboard+0x145>
   42d24:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42d28:	75 05                	jne    42d2f <check_keyboard+0x14a>
        poweroff();
   42d2a:	e8 3c f8 ff ff       	call   4256b <poweroff>
    }
    return c;
   42d2f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42d32:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42d36:	c9                   	leave  
   42d37:	c3                   	ret    

0000000000042d38 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42d38:	f3 0f 1e fa          	endbr64 
   42d3c:	55                   	push   %rbp
   42d3d:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42d40:	e8 a0 fe ff ff       	call   42be5 <check_keyboard>
   42d45:	eb f9                	jmp    42d40 <fail+0x8>

0000000000042d47 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42d47:	f3 0f 1e fa          	endbr64 
   42d4b:	55                   	push   %rbp
   42d4c:	48 89 e5             	mov    %rsp,%rbp
   42d4f:	48 83 ec 60          	sub    $0x60,%rsp
   42d53:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42d57:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42d5b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42d5f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42d63:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42d67:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42d6b:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42d72:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42d76:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42d7a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42d7e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42d82:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42d87:	0f 84 87 00 00 00    	je     42e14 <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42d8d:	48 8d 05 37 23 00 00 	lea    0x2337(%rip),%rax        # 450cb <complex_keymap+0xab>
   42d94:	48 89 c2             	mov    %rax,%rdx
   42d97:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d9c:	bf 30 07 00 00       	mov    $0x730,%edi
   42da1:	b8 00 00 00 00       	mov    $0x0,%eax
   42da6:	e8 e4 fd ff ff       	call   42b8f <error_printf>
   42dab:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42dae:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42db2:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42db6:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42db9:	be 00 c0 00 00       	mov    $0xc000,%esi
   42dbe:	89 c7                	mov    %eax,%edi
   42dc0:	e8 68 fd ff ff       	call   42b2d <error_vprintf>
   42dc5:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42dc8:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42dcb:	48 63 c1             	movslq %ecx,%rax
   42dce:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42dd5:	48 c1 e8 20          	shr    $0x20,%rax
   42dd9:	c1 f8 05             	sar    $0x5,%eax
   42ddc:	89 ce                	mov    %ecx,%esi
   42dde:	c1 fe 1f             	sar    $0x1f,%esi
   42de1:	29 f0                	sub    %esi,%eax
   42de3:	89 c2                	mov    %eax,%edx
   42de5:	89 d0                	mov    %edx,%eax
   42de7:	c1 e0 02             	shl    $0x2,%eax
   42dea:	01 d0                	add    %edx,%eax
   42dec:	c1 e0 04             	shl    $0x4,%eax
   42def:	29 c1                	sub    %eax,%ecx
   42df1:	89 ca                	mov    %ecx,%edx
   42df3:	85 d2                	test   %edx,%edx
   42df5:	74 3b                	je     42e32 <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   42df7:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42dfa:	48 8d 15 d2 22 00 00 	lea    0x22d2(%rip),%rdx        # 450d3 <complex_keymap+0xb3>
   42e01:	be 00 c0 00 00       	mov    $0xc000,%esi
   42e06:	89 c7                	mov    %eax,%edi
   42e08:	b8 00 00 00 00       	mov    $0x0,%eax
   42e0d:	e8 7d fd ff ff       	call   42b8f <error_printf>
   42e12:	eb 1e                	jmp    42e32 <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42e14:	48 8d 05 ba 22 00 00 	lea    0x22ba(%rip),%rax        # 450d5 <complex_keymap+0xb5>
   42e1b:	48 89 c2             	mov    %rax,%rdx
   42e1e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42e23:	bf 30 07 00 00       	mov    $0x730,%edi
   42e28:	b8 00 00 00 00       	mov    $0x0,%eax
   42e2d:	e8 5d fd ff ff       	call   42b8f <error_printf>
    }

    va_end(val);
    fail();
   42e32:	e8 01 ff ff ff       	call   42d38 <fail>

0000000000042e37 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42e37:	f3 0f 1e fa          	endbr64 
   42e3b:	55                   	push   %rbp
   42e3c:	48 89 e5             	mov    %rsp,%rbp
   42e3f:	48 83 ec 20          	sub    $0x20,%rsp
   42e43:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42e47:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42e4a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42e4e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42e52:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42e55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e59:	48 89 c6             	mov    %rax,%rsi
   42e5c:	48 8d 05 78 22 00 00 	lea    0x2278(%rip),%rax        # 450db <complex_keymap+0xbb>
   42e63:	48 89 c7             	mov    %rax,%rdi
   42e66:	b8 00 00 00 00       	mov    $0x0,%eax
   42e6b:	e8 d7 fe ff ff       	call   42d47 <panic>

0000000000042e70 <default_exception>:
}

void default_exception(proc* p){
   42e70:	f3 0f 1e fa          	endbr64 
   42e74:	55                   	push   %rbp
   42e75:	48 89 e5             	mov    %rsp,%rbp
   42e78:	48 83 ec 20          	sub    $0x20,%rsp
   42e7c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42e80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e84:	48 83 c0 08          	add    $0x8,%rax
   42e88:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42e8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e90:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42e97:	48 89 c6             	mov    %rax,%rsi
   42e9a:	48 8d 05 58 22 00 00 	lea    0x2258(%rip),%rax        # 450f9 <complex_keymap+0xd9>
   42ea1:	48 89 c7             	mov    %rax,%rdi
   42ea4:	b8 00 00 00 00       	mov    $0x0,%eax
   42ea9:	e8 99 fe ff ff       	call   42d47 <panic>

0000000000042eae <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42eae:	55                   	push   %rbp
   42eaf:	48 89 e5             	mov    %rsp,%rbp
   42eb2:	48 83 ec 10          	sub    $0x10,%rsp
   42eb6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42eba:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42ebd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42ec1:	78 06                	js     42ec9 <pageindex+0x1b>
   42ec3:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42ec7:	7e 1e                	jle    42ee7 <pageindex+0x39>
   42ec9:	48 8d 05 48 22 00 00 	lea    0x2248(%rip),%rax        # 45118 <complex_keymap+0xf8>
   42ed0:	48 89 c2             	mov    %rax,%rdx
   42ed3:	be 1e 00 00 00       	mov    $0x1e,%esi
   42ed8:	48 8d 05 52 22 00 00 	lea    0x2252(%rip),%rax        # 45131 <complex_keymap+0x111>
   42edf:	48 89 c7             	mov    %rax,%rdi
   42ee2:	e8 50 ff ff ff       	call   42e37 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42ee7:	b8 03 00 00 00       	mov    $0x3,%eax
   42eec:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42eef:	89 c2                	mov    %eax,%edx
   42ef1:	89 d0                	mov    %edx,%eax
   42ef3:	c1 e0 03             	shl    $0x3,%eax
   42ef6:	01 d0                	add    %edx,%eax
   42ef8:	83 c0 0c             	add    $0xc,%eax
   42efb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42eff:	89 c1                	mov    %eax,%ecx
   42f01:	48 d3 ea             	shr    %cl,%rdx
   42f04:	48 89 d0             	mov    %rdx,%rax
   42f07:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42f0c:	c9                   	leave  
   42f0d:	c3                   	ret    

0000000000042f0e <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42f0e:	f3 0f 1e fa          	endbr64 
   42f12:	55                   	push   %rbp
   42f13:	48 89 e5             	mov    %rsp,%rbp
   42f16:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42f1a:	48 8d 05 df 30 01 00 	lea    0x130df(%rip),%rax        # 56000 <kernel_pagetables>
   42f21:	48 89 05 d8 20 01 00 	mov    %rax,0x120d8(%rip)        # 55000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42f28:	ba 00 50 00 00       	mov    $0x5000,%edx
   42f2d:	be 00 00 00 00       	mov    $0x0,%esi
   42f32:	48 8d 05 c7 30 01 00 	lea    0x130c7(%rip),%rax        # 56000 <kernel_pagetables>
   42f39:	48 89 c7             	mov    %rax,%rdi
   42f3c:	e8 4c 0c 00 00       	call   43b8d <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42f41:	48 8d 05 b8 40 01 00 	lea    0x140b8(%rip),%rax        # 57000 <kernel_pagetables+0x1000>
   42f48:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42f4c:	48 89 05 ad 30 01 00 	mov    %rax,0x130ad(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42f53:	48 8d 05 a6 50 01 00 	lea    0x150a6(%rip),%rax        # 58000 <kernel_pagetables+0x2000>
   42f5a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42f5e:	48 89 05 9b 40 01 00 	mov    %rax,0x1409b(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42f65:	48 8d 05 94 60 01 00 	lea    0x16094(%rip),%rax        # 59000 <kernel_pagetables+0x3000>
   42f6c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42f70:	48 89 05 89 50 01 00 	mov    %rax,0x15089(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42f77:	48 8d 05 82 70 01 00 	lea    0x17082(%rip),%rax        # 5a000 <kernel_pagetables+0x4000>
   42f7e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42f82:	48 89 05 7f 50 01 00 	mov    %rax,0x1507f(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42f89:	48 8b 05 70 20 01 00 	mov    0x12070(%rip),%rax        # 55000 <kernel_pagetable>
   42f90:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42f96:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42f9b:	ba 00 00 00 00       	mov    $0x0,%edx
   42fa0:	be 00 00 00 00       	mov    $0x0,%esi
   42fa5:	48 89 c7             	mov    %rax,%rdi
   42fa8:	e8 0e 02 00 00       	call   431bb <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42fad:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42fb4:	00 
   42fb5:	eb 76                	jmp    4302d <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42fb7:	48 8b 0d 42 20 01 00 	mov    0x12042(%rip),%rcx        # 55000 <kernel_pagetable>
   42fbe:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42fc2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42fc6:	48 89 ce             	mov    %rcx,%rsi
   42fc9:	48 89 c7             	mov    %rax,%rdi
   42fcc:	e8 34 06 00 00       	call   43605 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42fd1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fd5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42fd9:	74 1e                	je     42ff9 <virtual_memory_init+0xeb>
   42fdb:	48 8d 05 63 21 00 00 	lea    0x2163(%rip),%rax        # 45145 <complex_keymap+0x125>
   42fe2:	48 89 c2             	mov    %rax,%rdx
   42fe5:	be 2d 00 00 00       	mov    $0x2d,%esi
   42fea:	48 8d 05 64 21 00 00 	lea    0x2164(%rip),%rax        # 45155 <complex_keymap+0x135>
   42ff1:	48 89 c7             	mov    %rax,%rdi
   42ff4:	e8 3e fe ff ff       	call   42e37 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42ff9:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42ffc:	48 98                	cltq   
   42ffe:	83 e0 03             	and    $0x3,%eax
   43001:	48 83 f8 03          	cmp    $0x3,%rax
   43005:	74 1e                	je     43025 <virtual_memory_init+0x117>
   43007:	48 8d 05 5a 21 00 00 	lea    0x215a(%rip),%rax        # 45168 <complex_keymap+0x148>
   4300e:	48 89 c2             	mov    %rax,%rdx
   43011:	be 2e 00 00 00       	mov    $0x2e,%esi
   43016:	48 8d 05 38 21 00 00 	lea    0x2138(%rip),%rax        # 45155 <complex_keymap+0x135>
   4301d:	48 89 c7             	mov    %rax,%rdi
   43020:	e8 12 fe ff ff       	call   42e37 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   43025:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4302c:	00 
   4302d:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   43034:	00 
   43035:	76 80                	jbe    42fb7 <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   43037:	48 8b 05 c2 1f 01 00 	mov    0x11fc2(%rip),%rax        # 55000 <kernel_pagetable>
   4303e:	48 89 c7             	mov    %rax,%rdi
   43041:	e8 03 00 00 00       	call   43049 <set_pagetable>
}
   43046:	90                   	nop
   43047:	c9                   	leave  
   43048:	c3                   	ret    

0000000000043049 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   43049:	f3 0f 1e fa          	endbr64 
   4304d:	55                   	push   %rbp
   4304e:	48 89 e5             	mov    %rsp,%rbp
   43051:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   43055:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   43059:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4305d:	25 ff 0f 00 00       	and    $0xfff,%eax
   43062:	48 85 c0             	test   %rax,%rax
   43065:	74 1e                	je     43085 <set_pagetable+0x3c>
   43067:	48 8d 05 27 21 00 00 	lea    0x2127(%rip),%rax        # 45195 <complex_keymap+0x175>
   4306e:	48 89 c2             	mov    %rax,%rdx
   43071:	be 3c 00 00 00       	mov    $0x3c,%esi
   43076:	48 8d 05 d8 20 00 00 	lea    0x20d8(%rip),%rax        # 45155 <complex_keymap+0x135>
   4307d:	48 89 c7             	mov    %rax,%rdi
   43080:	e8 b2 fd ff ff       	call   42e37 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   43085:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   4308c:	48 89 c2             	mov    %rax,%rdx
   4308f:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   43093:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43097:	48 89 ce             	mov    %rcx,%rsi
   4309a:	48 89 c7             	mov    %rax,%rdi
   4309d:	e8 63 05 00 00       	call   43605 <virtual_memory_lookup>
   430a2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   430a6:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   430ad:	48 39 d0             	cmp    %rdx,%rax
   430b0:	74 1e                	je     430d0 <set_pagetable+0x87>
   430b2:	48 8d 05 f7 20 00 00 	lea    0x20f7(%rip),%rax        # 451b0 <complex_keymap+0x190>
   430b9:	48 89 c2             	mov    %rax,%rdx
   430bc:	be 3e 00 00 00       	mov    $0x3e,%esi
   430c1:	48 8d 05 8d 20 00 00 	lea    0x208d(%rip),%rax        # 45155 <complex_keymap+0x135>
   430c8:	48 89 c7             	mov    %rax,%rdi
   430cb:	e8 67 fd ff ff       	call   42e37 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   430d0:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   430d4:	48 8b 0d 25 1f 01 00 	mov    0x11f25(%rip),%rcx        # 55000 <kernel_pagetable>
   430db:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   430df:	48 89 ce             	mov    %rcx,%rsi
   430e2:	48 89 c7             	mov    %rax,%rdi
   430e5:	e8 1b 05 00 00       	call   43605 <virtual_memory_lookup>
   430ea:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   430ee:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   430f2:	48 39 c2             	cmp    %rax,%rdx
   430f5:	74 1e                	je     43115 <set_pagetable+0xcc>
   430f7:	48 8d 05 1a 21 00 00 	lea    0x211a(%rip),%rax        # 45218 <complex_keymap+0x1f8>
   430fe:	48 89 c2             	mov    %rax,%rdx
   43101:	be 40 00 00 00       	mov    $0x40,%esi
   43106:	48 8d 05 48 20 00 00 	lea    0x2048(%rip),%rax        # 45155 <complex_keymap+0x135>
   4310d:	48 89 c7             	mov    %rax,%rdi
   43110:	e8 22 fd ff ff       	call   42e37 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   43115:	48 8b 05 e4 1e 01 00 	mov    0x11ee4(%rip),%rax        # 55000 <kernel_pagetable>
   4311c:	48 89 c2             	mov    %rax,%rdx
   4311f:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   43123:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43127:	48 89 ce             	mov    %rcx,%rsi
   4312a:	48 89 c7             	mov    %rax,%rdi
   4312d:	e8 d3 04 00 00       	call   43605 <virtual_memory_lookup>
   43132:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43136:	48 8b 15 c3 1e 01 00 	mov    0x11ec3(%rip),%rdx        # 55000 <kernel_pagetable>
   4313d:	48 39 d0             	cmp    %rdx,%rax
   43140:	74 1e                	je     43160 <set_pagetable+0x117>
   43142:	48 8d 05 2f 21 00 00 	lea    0x212f(%rip),%rax        # 45278 <complex_keymap+0x258>
   43149:	48 89 c2             	mov    %rax,%rdx
   4314c:	be 42 00 00 00       	mov    $0x42,%esi
   43151:	48 8d 05 fd 1f 00 00 	lea    0x1ffd(%rip),%rax        # 45155 <complex_keymap+0x135>
   43158:	48 89 c7             	mov    %rax,%rdi
   4315b:	e8 d7 fc ff ff       	call   42e37 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   43160:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 431bb <virtual_memory_map>
   43167:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4316b:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4316f:	48 89 ce             	mov    %rcx,%rsi
   43172:	48 89 c7             	mov    %rax,%rdi
   43175:	e8 8b 04 00 00       	call   43605 <virtual_memory_lookup>
   4317a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4317e:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 431bb <virtual_memory_map>
   43185:	48 39 d0             	cmp    %rdx,%rax
   43188:	74 1e                	je     431a8 <set_pagetable+0x15f>
   4318a:	48 8d 05 4f 21 00 00 	lea    0x214f(%rip),%rax        # 452e0 <complex_keymap+0x2c0>
   43191:	48 89 c2             	mov    %rax,%rdx
   43194:	be 44 00 00 00       	mov    $0x44,%esi
   43199:	48 8d 05 b5 1f 00 00 	lea    0x1fb5(%rip),%rax        # 45155 <complex_keymap+0x135>
   431a0:	48 89 c7             	mov    %rax,%rdi
   431a3:	e8 8f fc ff ff       	call   42e37 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   431a8:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   431ac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   431b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431b4:	0f 22 d8             	mov    %rax,%cr3
}
   431b7:	90                   	nop
}
   431b8:	90                   	nop
   431b9:	c9                   	leave  
   431ba:	c3                   	ret    

00000000000431bb <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   431bb:	f3 0f 1e fa          	endbr64 
   431bf:	55                   	push   %rbp
   431c0:	48 89 e5             	mov    %rsp,%rbp
   431c3:	48 83 ec 50          	sub    $0x50,%rsp
   431c7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   431cb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   431cf:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   431d3:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   431d7:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   431db:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431df:	25 ff 0f 00 00       	and    $0xfff,%eax
   431e4:	48 85 c0             	test   %rax,%rax
   431e7:	74 1e                	je     43207 <virtual_memory_map+0x4c>
   431e9:	48 8d 05 56 21 00 00 	lea    0x2156(%rip),%rax        # 45346 <complex_keymap+0x326>
   431f0:	48 89 c2             	mov    %rax,%rdx
   431f3:	be 65 00 00 00       	mov    $0x65,%esi
   431f8:	48 8d 05 56 1f 00 00 	lea    0x1f56(%rip),%rax        # 45155 <complex_keymap+0x135>
   431ff:	48 89 c7             	mov    %rax,%rdi
   43202:	e8 30 fc ff ff       	call   42e37 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   43207:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4320b:	25 ff 0f 00 00       	and    $0xfff,%eax
   43210:	48 85 c0             	test   %rax,%rax
   43213:	74 1e                	je     43233 <virtual_memory_map+0x78>
   43215:	48 8d 05 3d 21 00 00 	lea    0x213d(%rip),%rax        # 45359 <complex_keymap+0x339>
   4321c:	48 89 c2             	mov    %rax,%rdx
   4321f:	be 66 00 00 00       	mov    $0x66,%esi
   43224:	48 8d 05 2a 1f 00 00 	lea    0x1f2a(%rip),%rax        # 45155 <complex_keymap+0x135>
   4322b:	48 89 c7             	mov    %rax,%rdi
   4322e:	e8 04 fc ff ff       	call   42e37 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   43233:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43237:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4323b:	48 01 d0             	add    %rdx,%rax
   4323e:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   43242:	76 2e                	jbe    43272 <virtual_memory_map+0xb7>
   43244:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43248:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4324c:	48 01 d0             	add    %rdx,%rax
   4324f:	48 85 c0             	test   %rax,%rax
   43252:	74 1e                	je     43272 <virtual_memory_map+0xb7>
   43254:	48 8d 05 11 21 00 00 	lea    0x2111(%rip),%rax        # 4536c <complex_keymap+0x34c>
   4325b:	48 89 c2             	mov    %rax,%rdx
   4325e:	be 67 00 00 00       	mov    $0x67,%esi
   43263:	48 8d 05 eb 1e 00 00 	lea    0x1eeb(%rip),%rax        # 45155 <complex_keymap+0x135>
   4326a:	48 89 c7             	mov    %rax,%rdi
   4326d:	e8 c5 fb ff ff       	call   42e37 <assert_fail>
    if (perm & PTE_P) {
   43272:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43275:	48 98                	cltq   
   43277:	83 e0 01             	and    $0x1,%eax
   4327a:	48 85 c0             	test   %rax,%rax
   4327d:	0f 84 8c 00 00 00    	je     4330f <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   43283:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43287:	25 ff 0f 00 00       	and    $0xfff,%eax
   4328c:	48 85 c0             	test   %rax,%rax
   4328f:	74 1e                	je     432af <virtual_memory_map+0xf4>
   43291:	48 8d 05 f2 20 00 00 	lea    0x20f2(%rip),%rax        # 4538a <complex_keymap+0x36a>
   43298:	48 89 c2             	mov    %rax,%rdx
   4329b:	be 69 00 00 00       	mov    $0x69,%esi
   432a0:	48 8d 05 ae 1e 00 00 	lea    0x1eae(%rip),%rax        # 45155 <complex_keymap+0x135>
   432a7:	48 89 c7             	mov    %rax,%rdi
   432aa:	e8 88 fb ff ff       	call   42e37 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   432af:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   432b3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   432b7:	48 01 d0             	add    %rdx,%rax
   432ba:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   432be:	76 1e                	jbe    432de <virtual_memory_map+0x123>
   432c0:	48 8d 05 d6 20 00 00 	lea    0x20d6(%rip),%rax        # 4539d <complex_keymap+0x37d>
   432c7:	48 89 c2             	mov    %rax,%rdx
   432ca:	be 6a 00 00 00       	mov    $0x6a,%esi
   432cf:	48 8d 05 7f 1e 00 00 	lea    0x1e7f(%rip),%rax        # 45155 <complex_keymap+0x135>
   432d6:	48 89 c7             	mov    %rax,%rdi
   432d9:	e8 59 fb ff ff       	call   42e37 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   432de:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   432e2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   432e6:	48 01 d0             	add    %rdx,%rax
   432e9:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   432ef:	76 1e                	jbe    4330f <virtual_memory_map+0x154>
   432f1:	48 8d 05 b3 20 00 00 	lea    0x20b3(%rip),%rax        # 453ab <complex_keymap+0x38b>
   432f8:	48 89 c2             	mov    %rax,%rdx
   432fb:	be 6b 00 00 00       	mov    $0x6b,%esi
   43300:	48 8d 05 4e 1e 00 00 	lea    0x1e4e(%rip),%rax        # 45155 <complex_keymap+0x135>
   43307:	48 89 c7             	mov    %rax,%rdi
   4330a:	e8 28 fb ff ff       	call   42e37 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   4330f:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43313:	78 09                	js     4331e <virtual_memory_map+0x163>
   43315:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   4331c:	7e 1e                	jle    4333c <virtual_memory_map+0x181>
   4331e:	48 8d 05 a2 20 00 00 	lea    0x20a2(%rip),%rax        # 453c7 <complex_keymap+0x3a7>
   43325:	48 89 c2             	mov    %rax,%rdx
   43328:	be 6d 00 00 00       	mov    $0x6d,%esi
   4332d:	48 8d 05 21 1e 00 00 	lea    0x1e21(%rip),%rax        # 45155 <complex_keymap+0x135>
   43334:	48 89 c7             	mov    %rax,%rdi
   43337:	e8 fb fa ff ff       	call   42e37 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   4333c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43340:	25 ff 0f 00 00       	and    $0xfff,%eax
   43345:	48 85 c0             	test   %rax,%rax
   43348:	74 1e                	je     43368 <virtual_memory_map+0x1ad>
   4334a:	48 8d 05 97 20 00 00 	lea    0x2097(%rip),%rax        # 453e8 <complex_keymap+0x3c8>
   43351:	48 89 c2             	mov    %rax,%rdx
   43354:	be 6e 00 00 00       	mov    $0x6e,%esi
   43359:	48 8d 05 f5 1d 00 00 	lea    0x1df5(%rip),%rax        # 45155 <complex_keymap+0x135>
   43360:	48 89 c7             	mov    %rax,%rdi
   43363:	e8 cf fa ff ff       	call   42e37 <assert_fail>

    int last_index123 = -1;
   43368:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   4336f:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   43376:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43377:	e9 ed 00 00 00       	jmp    43469 <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   4337c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43380:	48 c1 e8 15          	shr    $0x15,%rax
   43384:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   43387:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4338a:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   4338d:	74 20                	je     433af <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   4338f:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43392:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   43396:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4339a:	48 89 ce             	mov    %rcx,%rsi
   4339d:	48 89 c7             	mov    %rax,%rdi
   433a0:	e8 d6 00 00 00       	call   4347b <lookup_l1pagetable>
   433a5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   433a9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   433ac:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   433af:	8b 45 bc             	mov    -0x44(%rbp),%eax
   433b2:	48 98                	cltq   
   433b4:	83 e0 01             	and    $0x1,%eax
   433b7:	48 85 c0             	test   %rax,%rax
   433ba:	74 37                	je     433f3 <virtual_memory_map+0x238>
   433bc:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   433c1:	74 30                	je     433f3 <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   433c3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   433c7:	be 03 00 00 00       	mov    $0x3,%esi
   433cc:	48 89 c7             	mov    %rax,%rdi
   433cf:	e8 da fa ff ff       	call   42eae <pageindex>
   433d4:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   433d7:	8b 45 bc             	mov    -0x44(%rbp),%eax
   433da:	48 98                	cltq   
   433dc:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   433e0:	48 89 c1             	mov    %rax,%rcx
   433e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433e7:	8b 55 e8             	mov    -0x18(%rbp),%edx
   433ea:	48 63 d2             	movslq %edx,%rdx
   433ed:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   433f1:	eb 5e                	jmp    43451 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   433f3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   433f8:	74 2a                	je     43424 <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   433fa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   433fe:	be 03 00 00 00       	mov    $0x3,%esi
   43403:	48 89 c7             	mov    %rax,%rdi
   43406:	e8 a3 fa ff ff       	call   42eae <pageindex>
   4340b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   4340e:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43411:	48 63 c8             	movslq %eax,%rcx
   43414:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43418:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4341b:	48 63 d2             	movslq %edx,%rdx
   4341e:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   43422:	eb 2d                	jmp    43451 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   43424:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43427:	48 98                	cltq   
   43429:	83 e0 01             	and    $0x1,%eax
   4342c:	48 85 c0             	test   %rax,%rax
   4342f:	74 20                	je     43451 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   43431:	be 87 00 00 00       	mov    $0x87,%esi
   43436:	48 8d 05 d3 1f 00 00 	lea    0x1fd3(%rip),%rax        # 45410 <complex_keymap+0x3f0>
   4343d:	48 89 c7             	mov    %rax,%rdi
   43440:	b8 00 00 00 00       	mov    $0x0,%eax
   43445:	e8 92 f6 ff ff       	call   42adc <log_printf>
            return -1;
   4344a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4344f:	eb 28                	jmp    43479 <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43451:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   43458:	00 
   43459:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   43460:	00 
   43461:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   43468:	00 
   43469:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   4346e:	0f 85 08 ff ff ff    	jne    4337c <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   43474:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43479:	c9                   	leave  
   4347a:	c3                   	ret    

000000000004347b <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   4347b:	f3 0f 1e fa          	endbr64 
   4347f:	55                   	push   %rbp
   43480:	48 89 e5             	mov    %rsp,%rbp
   43483:	48 83 ec 40          	sub    $0x40,%rsp
   43487:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4348b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4348f:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   43492:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43496:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   4349a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   434a1:	e9 4f 01 00 00       	jmp    435f5 <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        int index = PAGEINDEX(va, i); // Get the index for the current level
   434a6:	8b 55 f4             	mov    -0xc(%rbp),%edx
   434a9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434ad:	89 d6                	mov    %edx,%esi
   434af:	48 89 c7             	mov    %rax,%rdi
   434b2:	e8 f7 f9 ff ff       	call   42eae <pageindex>
   434b7:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   434ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434be:	8b 55 f0             	mov    -0x10(%rbp),%edx
   434c1:	48 63 d2             	movslq %edx,%rdx
   434c4:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   434c8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   434cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434d0:	83 e0 01             	and    $0x1,%eax
   434d3:	48 85 c0             	test   %rax,%rax
   434d6:	75 6d                	jne    43545 <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   434d8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   434db:	8d 48 02             	lea    0x2(%rax),%ecx
   434de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434e2:	25 ff 0f 00 00       	and    $0xfff,%eax
   434e7:	48 89 c2             	mov    %rax,%rdx
   434ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434ee:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   434f4:	48 89 c6             	mov    %rax,%rsi
   434f7:	48 8d 05 5a 1f 00 00 	lea    0x1f5a(%rip),%rax        # 45458 <complex_keymap+0x438>
   434fe:	48 89 c7             	mov    %rax,%rdi
   43501:	b8 00 00 00 00       	mov    $0x0,%eax
   43506:	e8 d1 f5 ff ff       	call   42adc <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   4350b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4350e:	48 98                	cltq   
   43510:	83 e0 01             	and    $0x1,%eax
   43513:	48 85 c0             	test   %rax,%rax
   43516:	75 0a                	jne    43522 <lookup_l1pagetable+0xa7>
                return NULL;
   43518:	b8 00 00 00 00       	mov    $0x0,%eax
   4351d:	e9 e1 00 00 00       	jmp    43603 <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   43522:	be ac 00 00 00       	mov    $0xac,%esi
   43527:	48 8d 05 92 1f 00 00 	lea    0x1f92(%rip),%rax        # 454c0 <complex_keymap+0x4a0>
   4352e:	48 89 c7             	mov    %rax,%rdi
   43531:	b8 00 00 00 00       	mov    $0x0,%eax
   43536:	e8 a1 f5 ff ff       	call   42adc <log_printf>
            return NULL;
   4353b:	b8 00 00 00 00       	mov    $0x0,%eax
   43540:	e9 be 00 00 00       	jmp    43603 <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   43545:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43549:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4354f:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   43555:	76 1e                	jbe    43575 <lookup_l1pagetable+0xfa>
   43557:	48 8d 05 aa 1f 00 00 	lea    0x1faa(%rip),%rax        # 45508 <complex_keymap+0x4e8>
   4355e:	48 89 c2             	mov    %rax,%rdx
   43561:	be b1 00 00 00       	mov    $0xb1,%esi
   43566:	48 8d 05 e8 1b 00 00 	lea    0x1be8(%rip),%rax        # 45155 <complex_keymap+0x135>
   4356d:	48 89 c7             	mov    %rax,%rdi
   43570:	e8 c2 f8 ff ff       	call   42e37 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   43575:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43578:	48 98                	cltq   
   4357a:	83 e0 02             	and    $0x2,%eax
   4357d:	48 85 c0             	test   %rax,%rax
   43580:	74 2a                	je     435ac <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   43582:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43586:	83 e0 02             	and    $0x2,%eax
   43589:	48 85 c0             	test   %rax,%rax
   4358c:	75 1e                	jne    435ac <lookup_l1pagetable+0x131>
   4358e:	48 8d 05 93 1f 00 00 	lea    0x1f93(%rip),%rax        # 45528 <complex_keymap+0x508>
   43595:	48 89 c2             	mov    %rax,%rdx
   43598:	be b3 00 00 00       	mov    $0xb3,%esi
   4359d:	48 8d 05 b1 1b 00 00 	lea    0x1bb1(%rip),%rax        # 45155 <complex_keymap+0x135>
   435a4:	48 89 c7             	mov    %rax,%rdi
   435a7:	e8 8b f8 ff ff       	call   42e37 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   435ac:	8b 45 cc             	mov    -0x34(%rbp),%eax
   435af:	48 98                	cltq   
   435b1:	83 e0 04             	and    $0x4,%eax
   435b4:	48 85 c0             	test   %rax,%rax
   435b7:	74 2a                	je     435e3 <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   435b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435bd:	83 e0 04             	and    $0x4,%eax
   435c0:	48 85 c0             	test   %rax,%rax
   435c3:	75 1e                	jne    435e3 <lookup_l1pagetable+0x168>
   435c5:	48 8d 05 67 1f 00 00 	lea    0x1f67(%rip),%rax        # 45533 <complex_keymap+0x513>
   435cc:	48 89 c2             	mov    %rax,%rdx
   435cf:	be b6 00 00 00       	mov    $0xb6,%esi
   435d4:	48 8d 05 7a 1b 00 00 	lea    0x1b7a(%rip),%rax        # 45155 <complex_keymap+0x135>
   435db:	48 89 c7             	mov    %rax,%rdi
   435de:	e8 54 f8 ff ff       	call   42e37 <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   435e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435e7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   435ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   435f1:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   435f5:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   435f9:	0f 8e a7 fe ff ff    	jle    434a6 <lookup_l1pagetable+0x2b>
    }
    return pt;
   435ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43603:	c9                   	leave  
   43604:	c3                   	ret    

0000000000043605 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   43605:	f3 0f 1e fa          	endbr64 
   43609:	55                   	push   %rbp
   4360a:	48 89 e5             	mov    %rsp,%rbp
   4360d:	48 83 ec 50          	sub    $0x50,%rsp
   43611:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43615:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   43619:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   4361d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43621:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   43625:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4362c:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4362d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   43634:	eb 41                	jmp    43677 <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   43636:	8b 55 ec             	mov    -0x14(%rbp),%edx
   43639:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4363d:	89 d6                	mov    %edx,%esi
   4363f:	48 89 c7             	mov    %rax,%rdi
   43642:	e8 67 f8 ff ff       	call   42eae <pageindex>
   43647:	89 c2                	mov    %eax,%edx
   43649:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4364d:	48 63 d2             	movslq %edx,%rdx
   43650:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43654:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43658:	83 e0 06             	and    $0x6,%eax
   4365b:	48 f7 d0             	not    %rax
   4365e:	48 21 d0             	and    %rdx,%rax
   43661:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43665:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43669:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4366f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43673:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43677:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4367b:	7f 0c                	jg     43689 <virtual_memory_lookup+0x84>
   4367d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43681:	83 e0 01             	and    $0x1,%eax
   43684:	48 85 c0             	test   %rax,%rax
   43687:	75 ad                	jne    43636 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   43689:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43690:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   43697:	ff 
   43698:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   4369f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436a3:	83 e0 01             	and    $0x1,%eax
   436a6:	48 85 c0             	test   %rax,%rax
   436a9:	74 34                	je     436df <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   436ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436af:	48 c1 e8 0c          	shr    $0xc,%rax
   436b3:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   436b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436ba:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   436c0:	48 89 c2             	mov    %rax,%rdx
   436c3:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   436c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   436cc:	48 09 d0             	or     %rdx,%rax
   436cf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   436d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436d7:	25 ff 0f 00 00       	and    $0xfff,%eax
   436dc:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   436df:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   436e3:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   436e7:	48 89 10             	mov    %rdx,(%rax)
   436ea:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   436ee:	48 89 50 08          	mov    %rdx,0x8(%rax)
   436f2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   436f6:	48 89 50 10          	mov    %rdx,0x10(%rax)
   436fa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   436fe:	c9                   	leave  
   436ff:	c3                   	ret    

0000000000043700 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   43700:	f3 0f 1e fa          	endbr64 
   43704:	55                   	push   %rbp
   43705:	48 89 e5             	mov    %rsp,%rbp
   43708:	48 83 ec 40          	sub    $0x40,%rsp
   4370c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43710:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   43713:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   43717:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   4371e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43722:	78 08                	js     4372c <program_load+0x2c>
   43724:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43727:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   4372a:	7c 1e                	jl     4374a <program_load+0x4a>
   4372c:	48 8d 05 0d 1e 00 00 	lea    0x1e0d(%rip),%rax        # 45540 <complex_keymap+0x520>
   43733:	48 89 c2             	mov    %rax,%rdx
   43736:	be 37 00 00 00       	mov    $0x37,%esi
   4373b:	48 8d 05 2e 1e 00 00 	lea    0x1e2e(%rip),%rax        # 45570 <complex_keymap+0x550>
   43742:	48 89 c7             	mov    %rax,%rdi
   43745:	e8 ed f6 ff ff       	call   42e37 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4374a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   4374d:	48 98                	cltq   
   4374f:	48 c1 e0 04          	shl    $0x4,%rax
   43753:	48 89 c2             	mov    %rax,%rdx
   43756:	48 8d 05 c3 28 00 00 	lea    0x28c3(%rip),%rax        # 46020 <ramimages>
   4375d:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   43761:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43765:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43769:	8b 00                	mov    (%rax),%eax
   4376b:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43770:	74 1e                	je     43790 <program_load+0x90>
   43772:	48 8d 05 09 1e 00 00 	lea    0x1e09(%rip),%rax        # 45582 <complex_keymap+0x562>
   43779:	48 89 c2             	mov    %rax,%rdx
   4377c:	be 39 00 00 00       	mov    $0x39,%esi
   43781:	48 8d 05 e8 1d 00 00 	lea    0x1de8(%rip),%rax        # 45570 <complex_keymap+0x550>
   43788:	48 89 c7             	mov    %rax,%rdi
   4378b:	e8 a7 f6 ff ff       	call   42e37 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43790:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43794:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43798:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4379c:	48 01 d0             	add    %rdx,%rax
   4379f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   437a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   437aa:	e9 94 00 00 00       	jmp    43843 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   437af:	8b 45 fc             	mov    -0x4(%rbp),%eax
   437b2:	48 63 d0             	movslq %eax,%rdx
   437b5:	48 89 d0             	mov    %rdx,%rax
   437b8:	48 c1 e0 03          	shl    $0x3,%rax
   437bc:	48 29 d0             	sub    %rdx,%rax
   437bf:	48 c1 e0 03          	shl    $0x3,%rax
   437c3:	48 89 c2             	mov    %rax,%rdx
   437c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437ca:	48 01 d0             	add    %rdx,%rax
   437cd:	8b 00                	mov    (%rax),%eax
   437cf:	83 f8 01             	cmp    $0x1,%eax
   437d2:	75 6b                	jne    4383f <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   437d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   437d7:	48 63 d0             	movslq %eax,%rdx
   437da:	48 89 d0             	mov    %rdx,%rax
   437dd:	48 c1 e0 03          	shl    $0x3,%rax
   437e1:	48 29 d0             	sub    %rdx,%rax
   437e4:	48 c1 e0 03          	shl    $0x3,%rax
   437e8:	48 89 c2             	mov    %rax,%rdx
   437eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437ef:	48 01 d0             	add    %rdx,%rax
   437f2:	48 8b 50 08          	mov    0x8(%rax),%rdx
   437f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437fa:	48 01 d0             	add    %rdx,%rax
   437fd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   43801:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43804:	48 63 d0             	movslq %eax,%rdx
   43807:	48 89 d0             	mov    %rdx,%rax
   4380a:	48 c1 e0 03          	shl    $0x3,%rax
   4380e:	48 29 d0             	sub    %rdx,%rax
   43811:	48 c1 e0 03          	shl    $0x3,%rax
   43815:	48 89 c2             	mov    %rax,%rdx
   43818:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4381c:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43820:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   43824:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43828:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4382c:	48 89 c7             	mov    %rax,%rdi
   4382f:	e8 3d 00 00 00       	call   43871 <program_load_segment>
   43834:	85 c0                	test   %eax,%eax
   43836:	79 07                	jns    4383f <program_load+0x13f>
                return -1;
   43838:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4383d:	eb 30                	jmp    4386f <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   4383f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43843:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43847:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   4384b:	0f b7 c0             	movzwl %ax,%eax
   4384e:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43851:	0f 8c 58 ff ff ff    	jl     437af <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   43857:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4385b:	48 8b 50 18          	mov    0x18(%rax),%rdx
   4385f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43863:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   4386a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4386f:	c9                   	leave  
   43870:	c3                   	ret    

0000000000043871 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43871:	f3 0f 1e fa          	endbr64 
   43875:	55                   	push   %rbp
   43876:	48 89 e5             	mov    %rsp,%rbp
   43879:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4387d:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   43881:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   43885:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   43889:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4388d:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43891:	48 8b 40 10          	mov    0x10(%rax),%rax
   43895:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   43899:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   4389d:	48 8b 50 20          	mov    0x20(%rax),%rdx
   438a1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   438a5:	48 01 d0             	add    %rdx,%rax
   438a8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   438ac:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   438b0:	48 8b 50 28          	mov    0x28(%rax),%rdx
   438b4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   438b8:	48 01 d0             	add    %rdx,%rax
   438bb:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   438bf:	48 81 65 e0 00 f0 ff 	andq   $0xfffffffffffff000,-0x20(%rbp)
   438c6:	ff 

    int perms = PTE_P | PTE_W | PTE_U;
   438c7:	c7 45 fc 07 00 00 00 	movl   $0x7,-0x4(%rbp)
    if ((ph->p_flags & ELF_PFLAG_WRITE) == 0){
   438ce:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   438d2:	8b 40 04             	mov    0x4(%rax),%eax
   438d5:	83 e0 02             	and    $0x2,%eax
   438d8:	85 c0                	test   %eax,%eax
   438da:	75 07                	jne    438e3 <program_load_segment+0x72>
        perms = PTE_P | PTE_U;
   438dc:	c7 45 fc 05 00 00 00 	movl   $0x5,-0x4(%rbp)
    }
    uintptr_t pa = 0;
   438e3:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
   438ea:	00 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   438eb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   438ef:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   438f3:	eb 7d                	jmp    43972 <program_load_segment+0x101>
        pa = find_page(p->p_pid);
   438f5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   438f9:	8b 00                	mov    (%rax),%eax
   438fb:	0f be c0             	movsbl %al,%eax
   438fe:	89 c7                	mov    %eax,%edi
   43900:	e8 0d cb ff ff       	call   40412 <find_page>
   43905:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   43909:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4390d:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43914:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43918:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   4391c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43922:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43927:	48 89 c7             	mov    %rax,%rdi
   4392a:	e8 8c f8 ff ff       	call   431bb <virtual_memory_map>
   4392f:	85 c0                	test   %eax,%eax
   43931:	79 37                	jns    4396a <program_load_segment+0xf9>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43933:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43937:	8b 00                	mov    (%rax),%eax
   43939:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4393d:	49 89 d0             	mov    %rdx,%r8
   43940:	89 c1                	mov    %eax,%ecx
   43942:	48 8d 05 57 1c 00 00 	lea    0x1c57(%rip),%rax        # 455a0 <complex_keymap+0x580>
   43949:	48 89 c2             	mov    %rax,%rdx
   4394c:	be 00 c0 00 00       	mov    $0xc000,%esi
   43951:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43956:	b8 00 00 00 00       	mov    $0x0,%eax
   4395b:	e8 6c 10 00 00       	call   449cc <console_printf>
            return -1;
   43960:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43965:	e9 1b 01 00 00       	jmp    43a85 <program_load_segment+0x214>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4396a:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43971:	00 
   43972:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43976:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4397a:	0f 82 75 ff ff ff    	jb     438f5 <program_load_segment+0x84>
        }
    }
    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43980:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43984:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4398b:	48 89 c7             	mov    %rax,%rdi
   4398e:	e8 b6 f6 ff ff       	call   43049 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43993:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43997:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4399b:	48 89 c2             	mov    %rax,%rdx
   4399e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   439a2:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   439a6:	48 89 ce             	mov    %rcx,%rsi
   439a9:	48 89 c7             	mov    %rax,%rdi
   439ac:	e8 d6 00 00 00       	call   43a87 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   439b1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   439b5:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
   439b9:	48 89 c2             	mov    %rax,%rdx
   439bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   439c0:	be 00 00 00 00       	mov    $0x0,%esi
   439c5:	48 89 c7             	mov    %rax,%rdi
   439c8:	e8 c0 01 00 00       	call   43b8d <memset>
    
    // update perms
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   439cd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   439d1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   439d5:	e9 89 00 00 00       	jmp    43a63 <program_load_segment+0x1f2>
        vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   439da:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   439de:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   439e5:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   439e9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   439ed:	48 89 ce             	mov    %rcx,%rsi
   439f0:	48 89 c7             	mov    %rax,%rdi
   439f3:	e8 0d fc ff ff       	call   43605 <virtual_memory_lookup>
        int r = virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   439f8:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   439fc:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43a00:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43a07:	8b 4d fc             	mov    -0x4(%rbp),%ecx
   43a0a:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   43a0e:	41 89 c8             	mov    %ecx,%r8d
   43a11:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a16:	48 89 c7             	mov    %rax,%rdi
   43a19:	e8 9d f7 ff ff       	call   431bb <virtual_memory_map>
   43a1e:	89 45 c4             	mov    %eax,-0x3c(%rbp)
                                  perms);
        if (r < 0){
   43a21:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
   43a25:	79 34                	jns    43a5b <program_load_segment+0x1ea>
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43a27:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43a2b:	8b 00                	mov    (%rax),%eax
   43a2d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   43a31:	49 89 d0             	mov    %rdx,%r8
   43a34:	89 c1                	mov    %eax,%ecx
   43a36:	48 8d 05 63 1b 00 00 	lea    0x1b63(%rip),%rax        # 455a0 <complex_keymap+0x580>
   43a3d:	48 89 c2             	mov    %rax,%rdx
   43a40:	be 00 c0 00 00       	mov    $0xc000,%esi
   43a45:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43a4a:	b8 00 00 00 00       	mov    $0x0,%eax
   43a4f:	e8 78 0f 00 00       	call   449cc <console_printf>
            return -1;
   43a54:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a59:	eb 2a                	jmp    43a85 <program_load_segment+0x214>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43a5b:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   43a62:	00 
   43a63:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a67:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   43a6b:	0f 82 69 ff ff ff    	jb     439da <program_load_segment+0x169>
        }
        }


    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43a71:	48 8b 05 88 15 01 00 	mov    0x11588(%rip),%rax        # 55000 <kernel_pagetable>
   43a78:	48 89 c7             	mov    %rax,%rdi
   43a7b:	e8 c9 f5 ff ff       	call   43049 <set_pagetable>
    return 0;
   43a80:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43a85:	c9                   	leave  
   43a86:	c3                   	ret    

0000000000043a87 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43a87:	f3 0f 1e fa          	endbr64 
   43a8b:	55                   	push   %rbp
   43a8c:	48 89 e5             	mov    %rsp,%rbp
   43a8f:	48 83 ec 28          	sub    $0x28,%rsp
   43a93:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43a97:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43a9b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43a9f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43aa3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43aa7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43aab:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43aaf:	eb 1c                	jmp    43acd <memcpy+0x46>
        *d = *s;
   43ab1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ab5:	0f b6 10             	movzbl (%rax),%edx
   43ab8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43abc:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43abe:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43ac3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43ac8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43acd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43ad2:	75 dd                	jne    43ab1 <memcpy+0x2a>
    }
    return dst;
   43ad4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43ad8:	c9                   	leave  
   43ad9:	c3                   	ret    

0000000000043ada <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43ada:	f3 0f 1e fa          	endbr64 
   43ade:	55                   	push   %rbp
   43adf:	48 89 e5             	mov    %rsp,%rbp
   43ae2:	48 83 ec 28          	sub    $0x28,%rsp
   43ae6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43aea:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43aee:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43af2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43af6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43afa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43afe:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43b02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b06:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43b0a:	73 6a                	jae    43b76 <memmove+0x9c>
   43b0c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43b10:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b14:	48 01 d0             	add    %rdx,%rax
   43b17:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43b1b:	73 59                	jae    43b76 <memmove+0x9c>
        s += n, d += n;
   43b1d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b21:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43b25:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b29:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43b2d:	eb 17                	jmp    43b46 <memmove+0x6c>
            *--d = *--s;
   43b2f:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43b34:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43b39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b3d:	0f b6 10             	movzbl (%rax),%edx
   43b40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b44:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43b46:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b4a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43b4e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43b52:	48 85 c0             	test   %rax,%rax
   43b55:	75 d8                	jne    43b2f <memmove+0x55>
    if (s < d && s + n > d) {
   43b57:	eb 2e                	jmp    43b87 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43b59:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43b5d:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43b61:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43b65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b69:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43b6d:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43b71:	0f b6 12             	movzbl (%rdx),%edx
   43b74:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43b76:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b7a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43b7e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43b82:	48 85 c0             	test   %rax,%rax
   43b85:	75 d2                	jne    43b59 <memmove+0x7f>
        }
    }
    return dst;
   43b87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43b8b:	c9                   	leave  
   43b8c:	c3                   	ret    

0000000000043b8d <memset>:

void* memset(void* v, int c, size_t n) {
   43b8d:	f3 0f 1e fa          	endbr64 
   43b91:	55                   	push   %rbp
   43b92:	48 89 e5             	mov    %rsp,%rbp
   43b95:	48 83 ec 28          	sub    $0x28,%rsp
   43b99:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b9d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43ba0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43ba4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ba8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43bac:	eb 15                	jmp    43bc3 <memset+0x36>
        *p = c;
   43bae:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43bb1:	89 c2                	mov    %eax,%edx
   43bb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bb7:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43bb9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43bbe:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43bc3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43bc8:	75 e4                	jne    43bae <memset+0x21>
    }
    return v;
   43bca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43bce:	c9                   	leave  
   43bcf:	c3                   	ret    

0000000000043bd0 <strlen>:

size_t strlen(const char* s) {
   43bd0:	f3 0f 1e fa          	endbr64 
   43bd4:	55                   	push   %rbp
   43bd5:	48 89 e5             	mov    %rsp,%rbp
   43bd8:	48 83 ec 18          	sub    $0x18,%rsp
   43bdc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43be0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43be7:	00 
   43be8:	eb 0a                	jmp    43bf4 <strlen+0x24>
        ++n;
   43bea:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43bef:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43bf4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bf8:	0f b6 00             	movzbl (%rax),%eax
   43bfb:	84 c0                	test   %al,%al
   43bfd:	75 eb                	jne    43bea <strlen+0x1a>
    }
    return n;
   43bff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43c03:	c9                   	leave  
   43c04:	c3                   	ret    

0000000000043c05 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43c05:	f3 0f 1e fa          	endbr64 
   43c09:	55                   	push   %rbp
   43c0a:	48 89 e5             	mov    %rsp,%rbp
   43c0d:	48 83 ec 20          	sub    $0x20,%rsp
   43c11:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c15:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43c19:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43c20:	00 
   43c21:	eb 0a                	jmp    43c2d <strnlen+0x28>
        ++n;
   43c23:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43c28:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43c2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c31:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43c35:	74 0b                	je     43c42 <strnlen+0x3d>
   43c37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c3b:	0f b6 00             	movzbl (%rax),%eax
   43c3e:	84 c0                	test   %al,%al
   43c40:	75 e1                	jne    43c23 <strnlen+0x1e>
    }
    return n;
   43c42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43c46:	c9                   	leave  
   43c47:	c3                   	ret    

0000000000043c48 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43c48:	f3 0f 1e fa          	endbr64 
   43c4c:	55                   	push   %rbp
   43c4d:	48 89 e5             	mov    %rsp,%rbp
   43c50:	48 83 ec 20          	sub    $0x20,%rsp
   43c54:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c58:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43c5c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c60:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43c64:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43c68:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43c6c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43c70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c74:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43c78:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43c7c:	0f b6 12             	movzbl (%rdx),%edx
   43c7f:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43c81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c85:	48 83 e8 01          	sub    $0x1,%rax
   43c89:	0f b6 00             	movzbl (%rax),%eax
   43c8c:	84 c0                	test   %al,%al
   43c8e:	75 d4                	jne    43c64 <strcpy+0x1c>
    return dst;
   43c90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43c94:	c9                   	leave  
   43c95:	c3                   	ret    

0000000000043c96 <strcmp>:

int strcmp(const char* a, const char* b) {
   43c96:	f3 0f 1e fa          	endbr64 
   43c9a:	55                   	push   %rbp
   43c9b:	48 89 e5             	mov    %rsp,%rbp
   43c9e:	48 83 ec 10          	sub    $0x10,%rsp
   43ca2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43ca6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43caa:	eb 0a                	jmp    43cb6 <strcmp+0x20>
        ++a, ++b;
   43cac:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43cb1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43cb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cba:	0f b6 00             	movzbl (%rax),%eax
   43cbd:	84 c0                	test   %al,%al
   43cbf:	74 1d                	je     43cde <strcmp+0x48>
   43cc1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cc5:	0f b6 00             	movzbl (%rax),%eax
   43cc8:	84 c0                	test   %al,%al
   43cca:	74 12                	je     43cde <strcmp+0x48>
   43ccc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cd0:	0f b6 10             	movzbl (%rax),%edx
   43cd3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cd7:	0f b6 00             	movzbl (%rax),%eax
   43cda:	38 c2                	cmp    %al,%dl
   43cdc:	74 ce                	je     43cac <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43cde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ce2:	0f b6 00             	movzbl (%rax),%eax
   43ce5:	89 c2                	mov    %eax,%edx
   43ce7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ceb:	0f b6 00             	movzbl (%rax),%eax
   43cee:	38 c2                	cmp    %al,%dl
   43cf0:	0f 97 c0             	seta   %al
   43cf3:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43cf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cfa:	0f b6 00             	movzbl (%rax),%eax
   43cfd:	89 c1                	mov    %eax,%ecx
   43cff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d03:	0f b6 00             	movzbl (%rax),%eax
   43d06:	38 c1                	cmp    %al,%cl
   43d08:	0f 92 c0             	setb   %al
   43d0b:	0f b6 c8             	movzbl %al,%ecx
   43d0e:	89 d0                	mov    %edx,%eax
   43d10:	29 c8                	sub    %ecx,%eax
}
   43d12:	c9                   	leave  
   43d13:	c3                   	ret    

0000000000043d14 <strchr>:

char* strchr(const char* s, int c) {
   43d14:	f3 0f 1e fa          	endbr64 
   43d18:	55                   	push   %rbp
   43d19:	48 89 e5             	mov    %rsp,%rbp
   43d1c:	48 83 ec 10          	sub    $0x10,%rsp
   43d20:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43d24:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43d27:	eb 05                	jmp    43d2e <strchr+0x1a>
        ++s;
   43d29:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43d2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d32:	0f b6 00             	movzbl (%rax),%eax
   43d35:	84 c0                	test   %al,%al
   43d37:	74 0e                	je     43d47 <strchr+0x33>
   43d39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d3d:	0f b6 00             	movzbl (%rax),%eax
   43d40:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43d43:	38 d0                	cmp    %dl,%al
   43d45:	75 e2                	jne    43d29 <strchr+0x15>
    }
    if (*s == (char) c) {
   43d47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d4b:	0f b6 00             	movzbl (%rax),%eax
   43d4e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43d51:	38 d0                	cmp    %dl,%al
   43d53:	75 06                	jne    43d5b <strchr+0x47>
        return (char*) s;
   43d55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d59:	eb 05                	jmp    43d60 <strchr+0x4c>
    } else {
        return NULL;
   43d5b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43d60:	c9                   	leave  
   43d61:	c3                   	ret    

0000000000043d62 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43d62:	f3 0f 1e fa          	endbr64 
   43d66:	55                   	push   %rbp
   43d67:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43d6a:	8b 05 90 72 01 00    	mov    0x17290(%rip),%eax        # 5b000 <rand_seed_set>
   43d70:	85 c0                	test   %eax,%eax
   43d72:	75 0a                	jne    43d7e <rand+0x1c>
        srand(819234718U);
   43d74:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43d79:	e8 24 00 00 00       	call   43da2 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43d7e:	8b 05 80 72 01 00    	mov    0x17280(%rip),%eax        # 5b004 <rand_seed>
   43d84:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43d8a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43d8f:	89 05 6f 72 01 00    	mov    %eax,0x1726f(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   43d95:	8b 05 69 72 01 00    	mov    0x17269(%rip),%eax        # 5b004 <rand_seed>
   43d9b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43da0:	5d                   	pop    %rbp
   43da1:	c3                   	ret    

0000000000043da2 <srand>:

void srand(unsigned seed) {
   43da2:	f3 0f 1e fa          	endbr64 
   43da6:	55                   	push   %rbp
   43da7:	48 89 e5             	mov    %rsp,%rbp
   43daa:	48 83 ec 08          	sub    $0x8,%rsp
   43dae:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43db1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43db4:	89 05 4a 72 01 00    	mov    %eax,0x1724a(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   43dba:	c7 05 3c 72 01 00 01 	movl   $0x1,0x1723c(%rip)        # 5b000 <rand_seed_set>
   43dc1:	00 00 00 
}
   43dc4:	90                   	nop
   43dc5:	c9                   	leave  
   43dc6:	c3                   	ret    

0000000000043dc7 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43dc7:	f3 0f 1e fa          	endbr64 
   43dcb:	55                   	push   %rbp
   43dcc:	48 89 e5             	mov    %rsp,%rbp
   43dcf:	48 83 ec 28          	sub    $0x28,%rsp
   43dd3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43dd7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43ddb:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43dde:	48 8d 05 fb 18 00 00 	lea    0x18fb(%rip),%rax        # 456e0 <upper_digits.1>
   43de5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   43de9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43ded:	79 0e                	jns    43dfd <fill_numbuf+0x36>
        digits = lower_digits;
   43def:	48 8d 05 0a 19 00 00 	lea    0x190a(%rip),%rax        # 45700 <lower_digits.0>
   43df6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   43dfa:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43dfd:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43e02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e06:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43e09:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43e0c:	48 63 c8             	movslq %eax,%rcx
   43e0f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43e13:	ba 00 00 00 00       	mov    $0x0,%edx
   43e18:	48 f7 f1             	div    %rcx
   43e1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e1f:	48 01 d0             	add    %rdx,%rax
   43e22:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43e27:	0f b6 10             	movzbl (%rax),%edx
   43e2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e2e:	88 10                	mov    %dl,(%rax)
        val /= base;
   43e30:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43e33:	48 63 f0             	movslq %eax,%rsi
   43e36:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43e3a:	ba 00 00 00 00       	mov    $0x0,%edx
   43e3f:	48 f7 f6             	div    %rsi
   43e42:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43e46:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43e4b:	75 bc                	jne    43e09 <fill_numbuf+0x42>
    return numbuf_end;
   43e4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43e51:	c9                   	leave  
   43e52:	c3                   	ret    

0000000000043e53 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43e53:	f3 0f 1e fa          	endbr64 
   43e57:	55                   	push   %rbp
   43e58:	48 89 e5             	mov    %rsp,%rbp
   43e5b:	53                   	push   %rbx
   43e5c:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43e63:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43e6a:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43e70:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43e77:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43e7e:	e9 bd 09 00 00       	jmp    44840 <printer_vprintf+0x9ed>
        if (*format != '%') {
   43e83:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e8a:	0f b6 00             	movzbl (%rax),%eax
   43e8d:	3c 25                	cmp    $0x25,%al
   43e8f:	74 31                	je     43ec2 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   43e91:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43e98:	4c 8b 00             	mov    (%rax),%r8
   43e9b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ea2:	0f b6 00             	movzbl (%rax),%eax
   43ea5:	0f b6 c8             	movzbl %al,%ecx
   43ea8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43eae:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43eb5:	89 ce                	mov    %ecx,%esi
   43eb7:	48 89 c7             	mov    %rax,%rdi
   43eba:	41 ff d0             	call   *%r8
            continue;
   43ebd:	e9 76 09 00 00       	jmp    44838 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   43ec2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43ec9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43ed0:	01 
   43ed1:	eb 4d                	jmp    43f20 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   43ed3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43eda:	0f b6 00             	movzbl (%rax),%eax
   43edd:	0f be c0             	movsbl %al,%eax
   43ee0:	89 c6                	mov    %eax,%esi
   43ee2:	48 8d 05 f7 16 00 00 	lea    0x16f7(%rip),%rax        # 455e0 <flag_chars>
   43ee9:	48 89 c7             	mov    %rax,%rdi
   43eec:	e8 23 fe ff ff       	call   43d14 <strchr>
   43ef1:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43ef5:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43efa:	74 34                	je     43f30 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   43efc:	48 8d 15 dd 16 00 00 	lea    0x16dd(%rip),%rdx        # 455e0 <flag_chars>
   43f03:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43f07:	48 29 d0             	sub    %rdx,%rax
   43f0a:	ba 01 00 00 00       	mov    $0x1,%edx
   43f0f:	89 c1                	mov    %eax,%ecx
   43f11:	d3 e2                	shl    %cl,%edx
   43f13:	89 d0                	mov    %edx,%eax
   43f15:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43f18:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43f1f:	01 
   43f20:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f27:	0f b6 00             	movzbl (%rax),%eax
   43f2a:	84 c0                	test   %al,%al
   43f2c:	75 a5                	jne    43ed3 <printer_vprintf+0x80>
   43f2e:	eb 01                	jmp    43f31 <printer_vprintf+0xde>
            } else {
                break;
   43f30:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43f31:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43f38:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f3f:	0f b6 00             	movzbl (%rax),%eax
   43f42:	3c 30                	cmp    $0x30,%al
   43f44:	7e 67                	jle    43fad <printer_vprintf+0x15a>
   43f46:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f4d:	0f b6 00             	movzbl (%rax),%eax
   43f50:	3c 39                	cmp    $0x39,%al
   43f52:	7f 59                	jg     43fad <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43f54:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43f5b:	eb 2e                	jmp    43f8b <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   43f5d:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43f60:	89 d0                	mov    %edx,%eax
   43f62:	c1 e0 02             	shl    $0x2,%eax
   43f65:	01 d0                	add    %edx,%eax
   43f67:	01 c0                	add    %eax,%eax
   43f69:	89 c1                	mov    %eax,%ecx
   43f6b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f72:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43f76:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43f7d:	0f b6 00             	movzbl (%rax),%eax
   43f80:	0f be c0             	movsbl %al,%eax
   43f83:	01 c8                	add    %ecx,%eax
   43f85:	83 e8 30             	sub    $0x30,%eax
   43f88:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43f8b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f92:	0f b6 00             	movzbl (%rax),%eax
   43f95:	3c 2f                	cmp    $0x2f,%al
   43f97:	0f 8e 85 00 00 00    	jle    44022 <printer_vprintf+0x1cf>
   43f9d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fa4:	0f b6 00             	movzbl (%rax),%eax
   43fa7:	3c 39                	cmp    $0x39,%al
   43fa9:	7e b2                	jle    43f5d <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   43fab:	eb 75                	jmp    44022 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   43fad:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fb4:	0f b6 00             	movzbl (%rax),%eax
   43fb7:	3c 2a                	cmp    $0x2a,%al
   43fb9:	75 68                	jne    44023 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   43fbb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fc2:	8b 00                	mov    (%rax),%eax
   43fc4:	83 f8 2f             	cmp    $0x2f,%eax
   43fc7:	77 30                	ja     43ff9 <printer_vprintf+0x1a6>
   43fc9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fd0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43fd4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fdb:	8b 00                	mov    (%rax),%eax
   43fdd:	89 c0                	mov    %eax,%eax
   43fdf:	48 01 d0             	add    %rdx,%rax
   43fe2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fe9:	8b 12                	mov    (%rdx),%edx
   43feb:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43fee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ff5:	89 0a                	mov    %ecx,(%rdx)
   43ff7:	eb 1a                	jmp    44013 <printer_vprintf+0x1c0>
   43ff9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44000:	48 8b 40 08          	mov    0x8(%rax),%rax
   44004:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44008:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4400f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44013:	8b 00                	mov    (%rax),%eax
   44015:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   44018:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4401f:	01 
   44020:	eb 01                	jmp    44023 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   44022:	90                   	nop
        }

        // process precision
        int precision = -1;
   44023:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   4402a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44031:	0f b6 00             	movzbl (%rax),%eax
   44034:	3c 2e                	cmp    $0x2e,%al
   44036:	0f 85 00 01 00 00    	jne    4413c <printer_vprintf+0x2e9>
            ++format;
   4403c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44043:	01 
            if (*format >= '0' && *format <= '9') {
   44044:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4404b:	0f b6 00             	movzbl (%rax),%eax
   4404e:	3c 2f                	cmp    $0x2f,%al
   44050:	7e 67                	jle    440b9 <printer_vprintf+0x266>
   44052:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44059:	0f b6 00             	movzbl (%rax),%eax
   4405c:	3c 39                	cmp    $0x39,%al
   4405e:	7f 59                	jg     440b9 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44060:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   44067:	eb 2e                	jmp    44097 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   44069:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4406c:	89 d0                	mov    %edx,%eax
   4406e:	c1 e0 02             	shl    $0x2,%eax
   44071:	01 d0                	add    %edx,%eax
   44073:	01 c0                	add    %eax,%eax
   44075:	89 c1                	mov    %eax,%ecx
   44077:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4407e:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44082:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44089:	0f b6 00             	movzbl (%rax),%eax
   4408c:	0f be c0             	movsbl %al,%eax
   4408f:	01 c8                	add    %ecx,%eax
   44091:	83 e8 30             	sub    $0x30,%eax
   44094:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44097:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4409e:	0f b6 00             	movzbl (%rax),%eax
   440a1:	3c 2f                	cmp    $0x2f,%al
   440a3:	0f 8e 85 00 00 00    	jle    4412e <printer_vprintf+0x2db>
   440a9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440b0:	0f b6 00             	movzbl (%rax),%eax
   440b3:	3c 39                	cmp    $0x39,%al
   440b5:	7e b2                	jle    44069 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   440b7:	eb 75                	jmp    4412e <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   440b9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440c0:	0f b6 00             	movzbl (%rax),%eax
   440c3:	3c 2a                	cmp    $0x2a,%al
   440c5:	75 68                	jne    4412f <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   440c7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440ce:	8b 00                	mov    (%rax),%eax
   440d0:	83 f8 2f             	cmp    $0x2f,%eax
   440d3:	77 30                	ja     44105 <printer_vprintf+0x2b2>
   440d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440dc:	48 8b 50 10          	mov    0x10(%rax),%rdx
   440e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440e7:	8b 00                	mov    (%rax),%eax
   440e9:	89 c0                	mov    %eax,%eax
   440eb:	48 01 d0             	add    %rdx,%rax
   440ee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440f5:	8b 12                	mov    (%rdx),%edx
   440f7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   440fa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44101:	89 0a                	mov    %ecx,(%rdx)
   44103:	eb 1a                	jmp    4411f <printer_vprintf+0x2cc>
   44105:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4410c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44110:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44114:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4411b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4411f:	8b 00                	mov    (%rax),%eax
   44121:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   44124:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4412b:	01 
   4412c:	eb 01                	jmp    4412f <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   4412e:	90                   	nop
            }
            if (precision < 0) {
   4412f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44133:	79 07                	jns    4413c <printer_vprintf+0x2e9>
                precision = 0;
   44135:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   4413c:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   44143:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   4414a:	00 
        int length = 0;
   4414b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   44152:	48 8d 05 8d 14 00 00 	lea    0x148d(%rip),%rax        # 455e6 <flag_chars+0x6>
   44159:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   4415d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44164:	0f b6 00             	movzbl (%rax),%eax
   44167:	0f be c0             	movsbl %al,%eax
   4416a:	83 e8 43             	sub    $0x43,%eax
   4416d:	83 f8 37             	cmp    $0x37,%eax
   44170:	0f 87 b6 03 00 00    	ja     4452c <printer_vprintf+0x6d9>
   44176:	89 c0                	mov    %eax,%eax
   44178:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   4417f:	00 
   44180:	48 8d 05 6d 14 00 00 	lea    0x146d(%rip),%rax        # 455f4 <flag_chars+0x14>
   44187:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4418a:	48 98                	cltq   
   4418c:	48 8d 15 61 14 00 00 	lea    0x1461(%rip),%rdx        # 455f4 <flag_chars+0x14>
   44193:	48 01 d0             	add    %rdx,%rax
   44196:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   44199:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   441a0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   441a7:	01 
            goto again;
   441a8:	eb b3                	jmp    4415d <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   441aa:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   441ae:	74 5d                	je     4420d <printer_vprintf+0x3ba>
   441b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441b7:	8b 00                	mov    (%rax),%eax
   441b9:	83 f8 2f             	cmp    $0x2f,%eax
   441bc:	77 30                	ja     441ee <printer_vprintf+0x39b>
   441be:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441c5:	48 8b 50 10          	mov    0x10(%rax),%rdx
   441c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441d0:	8b 00                	mov    (%rax),%eax
   441d2:	89 c0                	mov    %eax,%eax
   441d4:	48 01 d0             	add    %rdx,%rax
   441d7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441de:	8b 12                	mov    (%rdx),%edx
   441e0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   441e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441ea:	89 0a                	mov    %ecx,(%rdx)
   441ec:	eb 1a                	jmp    44208 <printer_vprintf+0x3b5>
   441ee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441f5:	48 8b 40 08          	mov    0x8(%rax),%rax
   441f9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441fd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44204:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44208:	48 8b 00             	mov    (%rax),%rax
   4420b:	eb 5c                	jmp    44269 <printer_vprintf+0x416>
   4420d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44214:	8b 00                	mov    (%rax),%eax
   44216:	83 f8 2f             	cmp    $0x2f,%eax
   44219:	77 30                	ja     4424b <printer_vprintf+0x3f8>
   4421b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44222:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44226:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4422d:	8b 00                	mov    (%rax),%eax
   4422f:	89 c0                	mov    %eax,%eax
   44231:	48 01 d0             	add    %rdx,%rax
   44234:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4423b:	8b 12                	mov    (%rdx),%edx
   4423d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44240:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44247:	89 0a                	mov    %ecx,(%rdx)
   44249:	eb 1a                	jmp    44265 <printer_vprintf+0x412>
   4424b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44252:	48 8b 40 08          	mov    0x8(%rax),%rax
   44256:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4425a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44261:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44265:	8b 00                	mov    (%rax),%eax
   44267:	48 98                	cltq   
   44269:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4426d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44271:	48 c1 f8 38          	sar    $0x38,%rax
   44275:	25 80 00 00 00       	and    $0x80,%eax
   4427a:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   4427d:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   44281:	74 09                	je     4428c <printer_vprintf+0x439>
   44283:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44287:	48 f7 d8             	neg    %rax
   4428a:	eb 04                	jmp    44290 <printer_vprintf+0x43d>
   4428c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44290:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   44294:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   44297:	83 c8 60             	or     $0x60,%eax
   4429a:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   4429d:	e9 cf 02 00 00       	jmp    44571 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   442a2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   442a6:	74 5d                	je     44305 <printer_vprintf+0x4b2>
   442a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442af:	8b 00                	mov    (%rax),%eax
   442b1:	83 f8 2f             	cmp    $0x2f,%eax
   442b4:	77 30                	ja     442e6 <printer_vprintf+0x493>
   442b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442bd:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442c8:	8b 00                	mov    (%rax),%eax
   442ca:	89 c0                	mov    %eax,%eax
   442cc:	48 01 d0             	add    %rdx,%rax
   442cf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442d6:	8b 12                	mov    (%rdx),%edx
   442d8:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442db:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442e2:	89 0a                	mov    %ecx,(%rdx)
   442e4:	eb 1a                	jmp    44300 <printer_vprintf+0x4ad>
   442e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442ed:	48 8b 40 08          	mov    0x8(%rax),%rax
   442f1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442f5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442fc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44300:	48 8b 00             	mov    (%rax),%rax
   44303:	eb 5c                	jmp    44361 <printer_vprintf+0x50e>
   44305:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4430c:	8b 00                	mov    (%rax),%eax
   4430e:	83 f8 2f             	cmp    $0x2f,%eax
   44311:	77 30                	ja     44343 <printer_vprintf+0x4f0>
   44313:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4431a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4431e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44325:	8b 00                	mov    (%rax),%eax
   44327:	89 c0                	mov    %eax,%eax
   44329:	48 01 d0             	add    %rdx,%rax
   4432c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44333:	8b 12                	mov    (%rdx),%edx
   44335:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44338:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4433f:	89 0a                	mov    %ecx,(%rdx)
   44341:	eb 1a                	jmp    4435d <printer_vprintf+0x50a>
   44343:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4434a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4434e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44352:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44359:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4435d:	8b 00                	mov    (%rax),%eax
   4435f:	89 c0                	mov    %eax,%eax
   44361:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   44365:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44369:	e9 03 02 00 00       	jmp    44571 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   4436e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   44375:	e9 28 ff ff ff       	jmp    442a2 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   4437a:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   44381:	e9 1c ff ff ff       	jmp    442a2 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44386:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4438d:	8b 00                	mov    (%rax),%eax
   4438f:	83 f8 2f             	cmp    $0x2f,%eax
   44392:	77 30                	ja     443c4 <printer_vprintf+0x571>
   44394:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4439b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4439f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443a6:	8b 00                	mov    (%rax),%eax
   443a8:	89 c0                	mov    %eax,%eax
   443aa:	48 01 d0             	add    %rdx,%rax
   443ad:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443b4:	8b 12                	mov    (%rdx),%edx
   443b6:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443b9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443c0:	89 0a                	mov    %ecx,(%rdx)
   443c2:	eb 1a                	jmp    443de <printer_vprintf+0x58b>
   443c4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443cb:	48 8b 40 08          	mov    0x8(%rax),%rax
   443cf:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443d3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443da:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443de:	48 8b 00             	mov    (%rax),%rax
   443e1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   443e5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   443ec:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   443f3:	e9 79 01 00 00       	jmp    44571 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   443f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ff:	8b 00                	mov    (%rax),%eax
   44401:	83 f8 2f             	cmp    $0x2f,%eax
   44404:	77 30                	ja     44436 <printer_vprintf+0x5e3>
   44406:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4440d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44411:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44418:	8b 00                	mov    (%rax),%eax
   4441a:	89 c0                	mov    %eax,%eax
   4441c:	48 01 d0             	add    %rdx,%rax
   4441f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44426:	8b 12                	mov    (%rdx),%edx
   44428:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4442b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44432:	89 0a                	mov    %ecx,(%rdx)
   44434:	eb 1a                	jmp    44450 <printer_vprintf+0x5fd>
   44436:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4443d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44441:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44445:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4444c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44450:	48 8b 00             	mov    (%rax),%rax
   44453:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   44457:	e9 15 01 00 00       	jmp    44571 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   4445c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44463:	8b 00                	mov    (%rax),%eax
   44465:	83 f8 2f             	cmp    $0x2f,%eax
   44468:	77 30                	ja     4449a <printer_vprintf+0x647>
   4446a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44471:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44475:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4447c:	8b 00                	mov    (%rax),%eax
   4447e:	89 c0                	mov    %eax,%eax
   44480:	48 01 d0             	add    %rdx,%rax
   44483:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4448a:	8b 12                	mov    (%rdx),%edx
   4448c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4448f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44496:	89 0a                	mov    %ecx,(%rdx)
   44498:	eb 1a                	jmp    444b4 <printer_vprintf+0x661>
   4449a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444a1:	48 8b 40 08          	mov    0x8(%rax),%rax
   444a5:	48 8d 48 08          	lea    0x8(%rax),%rcx
   444a9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444b0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444b4:	8b 00                	mov    (%rax),%eax
   444b6:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   444bc:	e9 77 03 00 00       	jmp    44838 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   444c1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   444c5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   444c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444d0:	8b 00                	mov    (%rax),%eax
   444d2:	83 f8 2f             	cmp    $0x2f,%eax
   444d5:	77 30                	ja     44507 <printer_vprintf+0x6b4>
   444d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444de:	48 8b 50 10          	mov    0x10(%rax),%rdx
   444e2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444e9:	8b 00                	mov    (%rax),%eax
   444eb:	89 c0                	mov    %eax,%eax
   444ed:	48 01 d0             	add    %rdx,%rax
   444f0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444f7:	8b 12                	mov    (%rdx),%edx
   444f9:	8d 4a 08             	lea    0x8(%rdx),%ecx
   444fc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44503:	89 0a                	mov    %ecx,(%rdx)
   44505:	eb 1a                	jmp    44521 <printer_vprintf+0x6ce>
   44507:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4450e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44512:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44516:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4451d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44521:	8b 00                	mov    (%rax),%eax
   44523:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44526:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   4452a:	eb 45                	jmp    44571 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   4452c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44530:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   44534:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4453b:	0f b6 00             	movzbl (%rax),%eax
   4453e:	84 c0                	test   %al,%al
   44540:	74 0c                	je     4454e <printer_vprintf+0x6fb>
   44542:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44549:	0f b6 00             	movzbl (%rax),%eax
   4454c:	eb 05                	jmp    44553 <printer_vprintf+0x700>
   4454e:	b8 25 00 00 00       	mov    $0x25,%eax
   44553:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44556:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   4455a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44561:	0f b6 00             	movzbl (%rax),%eax
   44564:	84 c0                	test   %al,%al
   44566:	75 08                	jne    44570 <printer_vprintf+0x71d>
                format--;
   44568:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   4456f:	01 
            }
            break;
   44570:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44571:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44574:	83 e0 20             	and    $0x20,%eax
   44577:	85 c0                	test   %eax,%eax
   44579:	74 1e                	je     44599 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   4457b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4457f:	48 83 c0 18          	add    $0x18,%rax
   44583:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44586:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4458a:	48 89 ce             	mov    %rcx,%rsi
   4458d:	48 89 c7             	mov    %rax,%rdi
   44590:	e8 32 f8 ff ff       	call   43dc7 <fill_numbuf>
   44595:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44599:	48 8d 05 46 10 00 00 	lea    0x1046(%rip),%rax        # 455e6 <flag_chars+0x6>
   445a0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   445a4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   445a7:	83 e0 20             	and    $0x20,%eax
   445aa:	85 c0                	test   %eax,%eax
   445ac:	74 51                	je     445ff <printer_vprintf+0x7ac>
   445ae:	8b 45 ec             	mov    -0x14(%rbp),%eax
   445b1:	83 e0 40             	and    $0x40,%eax
   445b4:	85 c0                	test   %eax,%eax
   445b6:	74 47                	je     445ff <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   445b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   445bb:	25 80 00 00 00       	and    $0x80,%eax
   445c0:	85 c0                	test   %eax,%eax
   445c2:	74 0d                	je     445d1 <printer_vprintf+0x77e>
                prefix = "-";
   445c4:	48 8d 05 1c 10 00 00 	lea    0x101c(%rip),%rax        # 455e7 <flag_chars+0x7>
   445cb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   445cf:	eb 7d                	jmp    4464e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   445d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   445d4:	83 e0 10             	and    $0x10,%eax
   445d7:	85 c0                	test   %eax,%eax
   445d9:	74 0d                	je     445e8 <printer_vprintf+0x795>
                prefix = "+";
   445db:	48 8d 05 07 10 00 00 	lea    0x1007(%rip),%rax        # 455e9 <flag_chars+0x9>
   445e2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   445e6:	eb 66                	jmp    4464e <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   445e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   445eb:	83 e0 08             	and    $0x8,%eax
   445ee:	85 c0                	test   %eax,%eax
   445f0:	74 5c                	je     4464e <printer_vprintf+0x7fb>
                prefix = " ";
   445f2:	48 8d 05 f2 0f 00 00 	lea    0xff2(%rip),%rax        # 455eb <flag_chars+0xb>
   445f9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   445fd:	eb 4f                	jmp    4464e <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   445ff:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44602:	83 e0 20             	and    $0x20,%eax
   44605:	85 c0                	test   %eax,%eax
   44607:	74 46                	je     4464f <printer_vprintf+0x7fc>
   44609:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4460c:	83 e0 01             	and    $0x1,%eax
   4460f:	85 c0                	test   %eax,%eax
   44611:	74 3c                	je     4464f <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   44613:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   44617:	74 06                	je     4461f <printer_vprintf+0x7cc>
   44619:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4461d:	75 30                	jne    4464f <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   4461f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44624:	75 0c                	jne    44632 <printer_vprintf+0x7df>
   44626:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44629:	25 00 01 00 00       	and    $0x100,%eax
   4462e:	85 c0                	test   %eax,%eax
   44630:	74 1d                	je     4464f <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   44632:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44636:	75 09                	jne    44641 <printer_vprintf+0x7ee>
   44638:	48 8d 05 ae 0f 00 00 	lea    0xfae(%rip),%rax        # 455ed <flag_chars+0xd>
   4463f:	eb 07                	jmp    44648 <printer_vprintf+0x7f5>
   44641:	48 8d 05 a8 0f 00 00 	lea    0xfa8(%rip),%rax        # 455f0 <flag_chars+0x10>
   44648:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4464c:	eb 01                	jmp    4464f <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   4464e:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   4464f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44653:	78 24                	js     44679 <printer_vprintf+0x826>
   44655:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44658:	83 e0 20             	and    $0x20,%eax
   4465b:	85 c0                	test   %eax,%eax
   4465d:	75 1a                	jne    44679 <printer_vprintf+0x826>
            len = strnlen(data, precision);
   4465f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44662:	48 63 d0             	movslq %eax,%rdx
   44665:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44669:	48 89 d6             	mov    %rdx,%rsi
   4466c:	48 89 c7             	mov    %rax,%rdi
   4466f:	e8 91 f5 ff ff       	call   43c05 <strnlen>
   44674:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44677:	eb 0f                	jmp    44688 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   44679:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4467d:	48 89 c7             	mov    %rax,%rdi
   44680:	e8 4b f5 ff ff       	call   43bd0 <strlen>
   44685:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44688:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4468b:	83 e0 20             	and    $0x20,%eax
   4468e:	85 c0                	test   %eax,%eax
   44690:	74 20                	je     446b2 <printer_vprintf+0x85f>
   44692:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44696:	78 1a                	js     446b2 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   44698:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4469b:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   4469e:	7e 08                	jle    446a8 <printer_vprintf+0x855>
   446a0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   446a3:	2b 45 bc             	sub    -0x44(%rbp),%eax
   446a6:	eb 05                	jmp    446ad <printer_vprintf+0x85a>
   446a8:	b8 00 00 00 00       	mov    $0x0,%eax
   446ad:	89 45 b8             	mov    %eax,-0x48(%rbp)
   446b0:	eb 5c                	jmp    4470e <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   446b2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446b5:	83 e0 20             	and    $0x20,%eax
   446b8:	85 c0                	test   %eax,%eax
   446ba:	74 4b                	je     44707 <printer_vprintf+0x8b4>
   446bc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446bf:	83 e0 02             	and    $0x2,%eax
   446c2:	85 c0                	test   %eax,%eax
   446c4:	74 41                	je     44707 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   446c6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446c9:	83 e0 04             	and    $0x4,%eax
   446cc:	85 c0                	test   %eax,%eax
   446ce:	75 37                	jne    44707 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   446d0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   446d4:	48 89 c7             	mov    %rax,%rdi
   446d7:	e8 f4 f4 ff ff       	call   43bd0 <strlen>
   446dc:	89 c2                	mov    %eax,%edx
   446de:	8b 45 bc             	mov    -0x44(%rbp),%eax
   446e1:	01 d0                	add    %edx,%eax
   446e3:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   446e6:	7e 1f                	jle    44707 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   446e8:	8b 45 e8             	mov    -0x18(%rbp),%eax
   446eb:	2b 45 bc             	sub    -0x44(%rbp),%eax
   446ee:	89 c3                	mov    %eax,%ebx
   446f0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   446f4:	48 89 c7             	mov    %rax,%rdi
   446f7:	e8 d4 f4 ff ff       	call   43bd0 <strlen>
   446fc:	89 c2                	mov    %eax,%edx
   446fe:	89 d8                	mov    %ebx,%eax
   44700:	29 d0                	sub    %edx,%eax
   44702:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44705:	eb 07                	jmp    4470e <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   44707:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   4470e:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44711:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44714:	01 d0                	add    %edx,%eax
   44716:	48 63 d8             	movslq %eax,%rbx
   44719:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4471d:	48 89 c7             	mov    %rax,%rdi
   44720:	e8 ab f4 ff ff       	call   43bd0 <strlen>
   44725:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   44729:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4472c:	29 d0                	sub    %edx,%eax
   4472e:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44731:	eb 25                	jmp    44758 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   44733:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4473a:	48 8b 08             	mov    (%rax),%rcx
   4473d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44743:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4474a:	be 20 00 00 00       	mov    $0x20,%esi
   4474f:	48 89 c7             	mov    %rax,%rdi
   44752:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44754:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44758:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4475b:	83 e0 04             	and    $0x4,%eax
   4475e:	85 c0                	test   %eax,%eax
   44760:	75 36                	jne    44798 <printer_vprintf+0x945>
   44762:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44766:	7f cb                	jg     44733 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   44768:	eb 2e                	jmp    44798 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   4476a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44771:	4c 8b 00             	mov    (%rax),%r8
   44774:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44778:	0f b6 00             	movzbl (%rax),%eax
   4477b:	0f b6 c8             	movzbl %al,%ecx
   4477e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44784:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4478b:	89 ce                	mov    %ecx,%esi
   4478d:	48 89 c7             	mov    %rax,%rdi
   44790:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44793:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44798:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4479c:	0f b6 00             	movzbl (%rax),%eax
   4479f:	84 c0                	test   %al,%al
   447a1:	75 c7                	jne    4476a <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   447a3:	eb 25                	jmp    447ca <printer_vprintf+0x977>
            p->putc(p, '0', color);
   447a5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447ac:	48 8b 08             	mov    (%rax),%rcx
   447af:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   447b5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447bc:	be 30 00 00 00       	mov    $0x30,%esi
   447c1:	48 89 c7             	mov    %rax,%rdi
   447c4:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   447c6:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   447ca:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   447ce:	7f d5                	jg     447a5 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   447d0:	eb 32                	jmp    44804 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   447d2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447d9:	4c 8b 00             	mov    (%rax),%r8
   447dc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   447e0:	0f b6 00             	movzbl (%rax),%eax
   447e3:	0f b6 c8             	movzbl %al,%ecx
   447e6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   447ec:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447f3:	89 ce                	mov    %ecx,%esi
   447f5:	48 89 c7             	mov    %rax,%rdi
   447f8:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   447fb:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44800:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44804:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44808:	7f c8                	jg     447d2 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   4480a:	eb 25                	jmp    44831 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   4480c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44813:	48 8b 08             	mov    (%rax),%rcx
   44816:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4481c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44823:	be 20 00 00 00       	mov    $0x20,%esi
   44828:	48 89 c7             	mov    %rax,%rdi
   4482b:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   4482d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44831:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44835:	7f d5                	jg     4480c <printer_vprintf+0x9b9>
        }
    done: ;
   44837:	90                   	nop
    for (; *format; ++format) {
   44838:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4483f:	01 
   44840:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44847:	0f b6 00             	movzbl (%rax),%eax
   4484a:	84 c0                	test   %al,%al
   4484c:	0f 85 31 f6 ff ff    	jne    43e83 <printer_vprintf+0x30>
    }
}
   44852:	90                   	nop
   44853:	90                   	nop
   44854:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44858:	c9                   	leave  
   44859:	c3                   	ret    

000000000004485a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4485a:	f3 0f 1e fa          	endbr64 
   4485e:	55                   	push   %rbp
   4485f:	48 89 e5             	mov    %rsp,%rbp
   44862:	48 83 ec 20          	sub    $0x20,%rsp
   44866:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4486a:	89 f0                	mov    %esi,%eax
   4486c:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4486f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44872:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44876:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4487a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4487e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44882:	48 8d 15 17 47 07 00 	lea    0x74717(%rip),%rdx        # b8fa0 <console+0xfa0>
   44889:	48 39 d0             	cmp    %rdx,%rax
   4488c:	72 0f                	jb     4489d <console_putc+0x43>
        cp->cursor = console;
   4488e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44892:	48 8d 15 67 37 07 00 	lea    0x73767(%rip),%rdx        # b8000 <console>
   44899:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   4489d:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   448a1:	0f 85 82 00 00 00    	jne    44929 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   448a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   448ab:	48 8b 40 08          	mov    0x8(%rax),%rax
   448af:	48 8d 15 4a 37 07 00 	lea    0x7374a(%rip),%rdx        # b8000 <console>
   448b6:	48 29 d0             	sub    %rdx,%rax
   448b9:	48 d1 f8             	sar    %rax
   448bc:	48 89 c1             	mov    %rax,%rcx
   448bf:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   448c6:	66 66 66 
   448c9:	48 89 c8             	mov    %rcx,%rax
   448cc:	48 f7 ea             	imul   %rdx
   448cf:	48 89 d0             	mov    %rdx,%rax
   448d2:	48 c1 f8 05          	sar    $0x5,%rax
   448d6:	48 89 ce             	mov    %rcx,%rsi
   448d9:	48 c1 fe 3f          	sar    $0x3f,%rsi
   448dd:	48 29 f0             	sub    %rsi,%rax
   448e0:	48 89 c2             	mov    %rax,%rdx
   448e3:	48 89 d0             	mov    %rdx,%rax
   448e6:	48 c1 e0 02          	shl    $0x2,%rax
   448ea:	48 01 d0             	add    %rdx,%rax
   448ed:	48 c1 e0 04          	shl    $0x4,%rax
   448f1:	48 29 c1             	sub    %rax,%rcx
   448f4:	48 89 ca             	mov    %rcx,%rdx
   448f7:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   448fa:	eb 25                	jmp    44921 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   448fc:	8b 45 e0             	mov    -0x20(%rbp),%eax
   448ff:	83 c8 20             	or     $0x20,%eax
   44902:	89 c6                	mov    %eax,%esi
   44904:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44908:	48 8b 40 08          	mov    0x8(%rax),%rax
   4490c:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44910:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44914:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44918:	89 f2                	mov    %esi,%edx
   4491a:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   4491d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44921:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44925:	75 d5                	jne    448fc <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44927:	eb 24                	jmp    4494d <console_putc+0xf3>
        *cp->cursor++ = c | color;
   44929:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   4492d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44930:	89 d6                	mov    %edx,%esi
   44932:	09 c6                	or     %eax,%esi
   44934:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44938:	48 8b 40 08          	mov    0x8(%rax),%rax
   4493c:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44940:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44944:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44948:	89 f2                	mov    %esi,%edx
   4494a:	66 89 10             	mov    %dx,(%rax)
}
   4494d:	90                   	nop
   4494e:	c9                   	leave  
   4494f:	c3                   	ret    

0000000000044950 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44950:	f3 0f 1e fa          	endbr64 
   44954:	55                   	push   %rbp
   44955:	48 89 e5             	mov    %rsp,%rbp
   44958:	48 83 ec 30          	sub    $0x30,%rsp
   4495c:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4495f:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44962:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44966:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   4496a:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 4485a <console_putc>
   44971:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44975:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44979:	78 09                	js     44984 <console_vprintf+0x34>
   4497b:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44982:	7e 07                	jle    4498b <console_vprintf+0x3b>
        cpos = 0;
   44984:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   4498b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4498e:	48 98                	cltq   
   44990:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44994:	48 8d 05 65 36 07 00 	lea    0x73665(%rip),%rax        # b8000 <console>
   4499b:	48 01 d0             	add    %rdx,%rax
   4499e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   449a2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   449a6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   449aa:	8b 75 e8             	mov    -0x18(%rbp),%esi
   449ad:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   449b1:	48 89 c7             	mov    %rax,%rdi
   449b4:	e8 9a f4 ff ff       	call   43e53 <printer_vprintf>
    return cp.cursor - console;
   449b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   449bd:	48 8d 15 3c 36 07 00 	lea    0x7363c(%rip),%rdx        # b8000 <console>
   449c4:	48 29 d0             	sub    %rdx,%rax
   449c7:	48 d1 f8             	sar    %rax
}
   449ca:	c9                   	leave  
   449cb:	c3                   	ret    

00000000000449cc <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   449cc:	f3 0f 1e fa          	endbr64 
   449d0:	55                   	push   %rbp
   449d1:	48 89 e5             	mov    %rsp,%rbp
   449d4:	48 83 ec 60          	sub    $0x60,%rsp
   449d8:	89 7d ac             	mov    %edi,-0x54(%rbp)
   449db:	89 75 a8             	mov    %esi,-0x58(%rbp)
   449de:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   449e2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   449e6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   449ea:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   449ee:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   449f5:	48 8d 45 10          	lea    0x10(%rbp),%rax
   449f9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   449fd:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44a01:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44a05:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44a09:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44a0d:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44a10:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44a13:	89 c7                	mov    %eax,%edi
   44a15:	e8 36 ff ff ff       	call   44950 <console_vprintf>
   44a1a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44a1d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44a20:	c9                   	leave  
   44a21:	c3                   	ret    

0000000000044a22 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44a22:	f3 0f 1e fa          	endbr64 
   44a26:	55                   	push   %rbp
   44a27:	48 89 e5             	mov    %rsp,%rbp
   44a2a:	48 83 ec 20          	sub    $0x20,%rsp
   44a2e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44a32:	89 f0                	mov    %esi,%eax
   44a34:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44a37:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44a3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44a3e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44a42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44a46:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44a4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44a4e:	48 8b 40 10          	mov    0x10(%rax),%rax
   44a52:	48 39 c2             	cmp    %rax,%rdx
   44a55:	73 1a                	jae    44a71 <string_putc+0x4f>
        *sp->s++ = c;
   44a57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44a5b:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a5f:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44a63:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44a67:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a6b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44a6f:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44a71:	90                   	nop
   44a72:	c9                   	leave  
   44a73:	c3                   	ret    

0000000000044a74 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44a74:	f3 0f 1e fa          	endbr64 
   44a78:	55                   	push   %rbp
   44a79:	48 89 e5             	mov    %rsp,%rbp
   44a7c:	48 83 ec 40          	sub    $0x40,%rsp
   44a80:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44a84:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44a88:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44a8c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44a90:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 44a22 <string_putc>
   44a97:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   44a9b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44a9f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44aa3:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44aa8:	74 33                	je     44add <vsnprintf+0x69>
        sp.end = s + size - 1;
   44aaa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44aae:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44ab2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44ab6:	48 01 d0             	add    %rdx,%rax
   44ab9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44abd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44ac1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44ac5:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44ac9:	be 00 00 00 00       	mov    $0x0,%esi
   44ace:	48 89 c7             	mov    %rax,%rdi
   44ad1:	e8 7d f3 ff ff       	call   43e53 <printer_vprintf>
        *sp.s = 0;
   44ad6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44ada:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44add:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44ae1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44ae5:	c9                   	leave  
   44ae6:	c3                   	ret    

0000000000044ae7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44ae7:	f3 0f 1e fa          	endbr64 
   44aeb:	55                   	push   %rbp
   44aec:	48 89 e5             	mov    %rsp,%rbp
   44aef:	48 83 ec 70          	sub    $0x70,%rsp
   44af3:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44af7:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44afb:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44aff:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44b03:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44b07:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44b0b:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44b12:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44b16:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44b1a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44b1e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44b22:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44b26:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44b2a:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44b2e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44b32:	48 89 c7             	mov    %rax,%rdi
   44b35:	e8 3a ff ff ff       	call   44a74 <vsnprintf>
   44b3a:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44b3d:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44b40:	c9                   	leave  
   44b41:	c3                   	ret    

0000000000044b42 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44b42:	f3 0f 1e fa          	endbr64 
   44b46:	55                   	push   %rbp
   44b47:	48 89 e5             	mov    %rsp,%rbp
   44b4a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44b4e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44b55:	eb 1a                	jmp    44b71 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   44b57:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44b5a:	48 98                	cltq   
   44b5c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44b60:	48 8d 05 99 34 07 00 	lea    0x73499(%rip),%rax        # b8000 <console>
   44b67:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44b6d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44b71:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44b78:	7e dd                	jle    44b57 <console_clear+0x15>
    }
    cursorpos = 0;
   44b7a:	c7 05 78 44 07 00 00 	movl   $0x0,0x74478(%rip)        # b8ffc <cursorpos>
   44b81:	00 00 00 
}
   44b84:	90                   	nop
   44b85:	c9                   	leave  
   44b86:	c3                   	ret    
