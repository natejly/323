
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
   400be:	e8 26 09 00 00       	call   409e9 <exception>

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
   40177:	e8 fd 1b 00 00       	call   41d79 <hardware_init>
    pageinfo_init();
   4017c:	e8 fd 10 00 00       	call   4127e <pageinfo_init>
    console_clear();
   40181:	e8 4f 49 00 00       	call   44ad5 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 51 21 00 00       	call   422e1 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 7f 1e 01 00 	lea    0x11e7f(%rip),%rax        # 52020 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 77 39 00 00       	call   43b20 <memset>
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
   40210:	48 8d 15 09 49 00 00 	lea    0x4909(%rip),%rdx        # 44b20 <console_clear+0x4b>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 07 3a 00 00       	call   43c29 <strcmp>
   40222:	85 c0                	test   %eax,%eax
   40224:	75 14                	jne    4023a <kernel+0xd3>
        process_setup(1, 4);
   40226:	be 04 00 00 00       	mov    $0x4,%esi
   4022b:	bf 01 00 00 00       	mov    $0x1,%edi
   40230:	e8 67 03 00 00       	call   4059c <process_setup>
   40235:	e9 d1 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4023a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4023f:	74 2e                	je     4026f <kernel+0x108>
   40241:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40245:	48 8d 15 d9 48 00 00 	lea    0x48d9(%rip),%rdx        # 44b25 <console_clear+0x50>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 d2 39 00 00       	call   43c29 <strcmp>
   40257:	85 c0                	test   %eax,%eax
   40259:	75 14                	jne    4026f <kernel+0x108>
        process_setup(1, 5);
   4025b:	be 05 00 00 00       	mov    $0x5,%esi
   40260:	bf 01 00 00 00       	mov    $0x1,%edi
   40265:	e8 32 03 00 00       	call   4059c <process_setup>
   4026a:	e9 9c 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test") == 0) {
   4026f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40274:	74 2b                	je     402a1 <kernel+0x13a>
   40276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4027a:	48 8d 15 ad 48 00 00 	lea    0x48ad(%rip),%rdx        # 44b2e <console_clear+0x59>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 9d 39 00 00       	call   43c29 <strcmp>
   4028c:	85 c0                	test   %eax,%eax
   4028e:	75 11                	jne    402a1 <kernel+0x13a>
        process_setup(1, 6);
   40290:	be 06 00 00 00       	mov    $0x6,%esi
   40295:	bf 01 00 00 00       	mov    $0x1,%edi
   4029a:	e8 fd 02 00 00       	call   4059c <process_setup>
   4029f:	eb 6a                	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test2") == 0) {
   402a1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a6:	74 3e                	je     402e6 <kernel+0x17f>
   402a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402ac:	48 8d 15 80 48 00 00 	lea    0x4880(%rip),%rdx        # 44b33 <console_clear+0x5e>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 6b 39 00 00       	call   43c29 <strcmp>
   402be:	85 c0                	test   %eax,%eax
   402c0:	75 24                	jne    402e6 <kernel+0x17f>
        for (pid_t i = 1; i <= 2; ++i) {
   402c2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402c9:	eb 13                	jmp    402de <kernel+0x177>
            process_setup(i, 6);
   402cb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402ce:	be 06 00 00 00       	mov    $0x6,%esi
   402d3:	89 c7                	mov    %eax,%edi
   402d5:	e8 c2 02 00 00       	call   4059c <process_setup>
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
   402fc:	e8 9b 02 00 00       	call   4059c <process_setup>
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
   4032a:	e8 1f 2e 00 00       	call   4314e <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   4032f:	48 8d 15 ca 7c 07 00 	lea    0x77cca(%rip),%rdx        # b8000 <console>
   40336:	48 8d 35 c3 7c 07 00 	lea    0x77cc3(%rip),%rsi        # b8000 <console>
   4033d:	48 8b 05 bc 4c 01 00 	mov    0x14cbc(%rip),%rax        # 55000 <kernel_pagetable>
   40344:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4034a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4034f:	48 89 c7             	mov    %rax,%rdi
   40352:	e8 f7 2d 00 00       	call   4314e <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    // Switch to the first process using run()
    run(&processes[1]);
   40357:	48 8d 05 a2 1d 01 00 	lea    0x11da2(%rip),%rax        # 52100 <processes+0xe0>
   4035e:	48 89 c7             	mov    %rax,%rdi
   40361:	e8 ad 0e 00 00       	call   41213 <run>

0000000000040366 <reserve_page>:
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

// helper function for reserving pages which returns return its page address

x86_64_pagetable* reserve_page(int8_t owner) {
   40366:	f3 0f 1e fa          	endbr64 
   4036a:	55                   	push   %rbp
   4036b:	48 89 e5             	mov    %rsp,%rbp
   4036e:	48 83 ec 20          	sub    $0x20,%rsp
   40372:	89 f8                	mov    %edi,%eax
   40374:	88 45 ec             	mov    %al,-0x14(%rbp)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40377:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4037e:	00 
   4037f:	eb 72                	jmp    403f3 <reserve_page+0x8d>
        int pn = PAGENUMBER(addr);
   40381:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40385:	48 c1 e8 0c          	shr    $0xc,%rax
   40389:	89 45 f4             	mov    %eax,-0xc(%rbp)

        if (pageinfo[pn].refcount == 0) {
   4038c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4038f:	48 98                	cltq   
   40391:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40395:	48 8d 05 a5 2a 01 00 	lea    0x12aa5(%rip),%rax        # 52e41 <pageinfo+0x1>
   4039c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   403a0:	84 c0                	test   %al,%al
   403a2:	75 47                	jne    403eb <reserve_page+0x85>
            pageinfo[pn].owner = owner;
   403a4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   403a7:	48 98                	cltq   
   403a9:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   403ad:	48 8d 15 8c 2a 01 00 	lea    0x12a8c(%rip),%rdx        # 52e40 <pageinfo>
   403b4:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
   403b8:	88 04 11             	mov    %al,(%rcx,%rdx,1)
            pageinfo[pn].refcount = 1;
   403bb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   403be:	48 98                	cltq   
   403c0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   403c4:	48 8d 05 76 2a 01 00 	lea    0x12a76(%rip),%rax        # 52e41 <pageinfo+0x1>
   403cb:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
            memset((void*) addr, 0, PAGESIZE);
   403cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403d3:	ba 00 10 00 00       	mov    $0x1000,%edx
   403d8:	be 00 00 00 00       	mov    $0x0,%esi
   403dd:	48 89 c7             	mov    %rax,%rdi
   403e0:	e8 3b 37 00 00       	call   43b20 <memset>
            return (x86_64_pagetable*) addr; 
   403e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403e9:	eb 17                	jmp    40402 <reserve_page+0x9c>
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   403eb:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   403f2:	00 
   403f3:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403fa:	00 
   403fb:	76 84                	jbe    40381 <reserve_page+0x1b>
        }
    }
    return NULL;
   403fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40402:	c9                   	leave  
   40403:	c3                   	ret    

0000000000040404 <find_page>:
uintptr_t find_page(int8_t owner) {
   40404:	f3 0f 1e fa          	endbr64 
   40408:	55                   	push   %rbp
   40409:	48 89 e5             	mov    %rsp,%rbp
   4040c:	48 83 ec 18          	sub    $0x18,%rsp
   40410:	89 f8                	mov    %edi,%eax
   40412:	88 45 ec             	mov    %al,-0x14(%rbp)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40415:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4041c:	00 
   4041d:	eb 5c                	jmp    4047b <find_page+0x77>
        int pn = PAGENUMBER(addr);
   4041f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40423:	48 c1 e8 0c          	shr    $0xc,%rax
   40427:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (pageinfo[pn].refcount == 0) {
   4042a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4042d:	48 98                	cltq   
   4042f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40433:	48 8d 05 07 2a 01 00 	lea    0x12a07(%rip),%rax        # 52e41 <pageinfo+0x1>
   4043a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4043e:	84 c0                	test   %al,%al
   40440:	75 31                	jne    40473 <find_page+0x6f>
            pageinfo[pn].owner = owner;
   40442:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40445:	48 98                	cltq   
   40447:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4044b:	48 8d 15 ee 29 01 00 	lea    0x129ee(%rip),%rdx        # 52e40 <pageinfo>
   40452:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
   40456:	88 04 11             	mov    %al,(%rcx,%rdx,1)
            pageinfo[pn].refcount = 1;
   40459:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4045c:	48 98                	cltq   
   4045e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40462:	48 8d 05 d8 29 01 00 	lea    0x129d8(%rip),%rax        # 52e41 <pageinfo+0x1>
   40469:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
            return addr; 
   4046d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40471:	eb 17                	jmp    4048a <find_page+0x86>
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40473:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4047a:	00 
   4047b:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40482:	00 
   40483:	76 9a                	jbe    4041f <find_page+0x1b>
        }
    }
    return 0; 
   40485:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4048a:	c9                   	leave  
   4048b:	c3                   	ret    

000000000004048c <make_pages>:



x86_64_pagetable* make_pages(pid_t pid){
   4048c:	f3 0f 1e fa          	endbr64 
   40490:	55                   	push   %rbp
   40491:	48 89 e5             	mov    %rsp,%rbp
   40494:	48 83 ec 60          	sub    $0x60,%rsp
   40498:	89 7d ac             	mov    %edi,-0x54(%rbp)
    x86_64_pagetable *l4 = reserve_page(pid);
   4049b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4049e:	0f be c0             	movsbl %al,%eax
   404a1:	89 c7                	mov    %eax,%edi
   404a3:	e8 be fe ff ff       	call   40366 <reserve_page>
   404a8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    x86_64_pagetable *l3 = reserve_page(pid);
   404ac:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404af:	0f be c0             	movsbl %al,%eax
   404b2:	89 c7                	mov    %eax,%edi
   404b4:	e8 ad fe ff ff       	call   40366 <reserve_page>
   404b9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    x86_64_pagetable *l2 = reserve_page(pid);
   404bd:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404c0:	0f be c0             	movsbl %al,%eax
   404c3:	89 c7                	mov    %eax,%edi
   404c5:	e8 9c fe ff ff       	call   40366 <reserve_page>
   404ca:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    x86_64_pagetable *l1_1 = reserve_page(pid);
   404ce:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404d1:	0f be c0             	movsbl %al,%eax
   404d4:	89 c7                	mov    %eax,%edi
   404d6:	e8 8b fe ff ff       	call   40366 <reserve_page>
   404db:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    x86_64_pagetable *l1_0 = reserve_page(pid);
   404df:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404e2:	0f be c0             	movsbl %al,%eax
   404e5:	89 c7                	mov    %eax,%edi
   404e7:	e8 7a fe ff ff       	call   40366 <reserve_page>
   404ec:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

    l4->entry[0] = (x86_64_pageentry_t)l3 | PTE_P | PTE_W | PTE_U;
   404f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404f4:	48 83 c8 07          	or     $0x7,%rax
   404f8:	48 89 c2             	mov    %rax,%rdx
   404fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   404ff:	48 89 10             	mov    %rdx,(%rax)
    l3->entry[0] = (x86_64_pageentry_t)l2 | PTE_P | PTE_W | PTE_U;
   40502:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40506:	48 83 c8 07          	or     $0x7,%rax
   4050a:	48 89 c2             	mov    %rax,%rdx
   4050d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40511:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[0] = (x86_64_pageentry_t)l1_0 | PTE_P | PTE_W | PTE_U;
   40514:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40518:	48 83 c8 07          	or     $0x7,%rax
   4051c:	48 89 c2             	mov    %rax,%rdx
   4051f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40523:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[1] = (x86_64_pageentry_t)l1_1 | PTE_P | PTE_W | PTE_U;
   40526:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4052a:	48 83 c8 07          	or     $0x7,%rax
   4052e:	48 89 c2             	mov    %rax,%rdx
   40531:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40535:	48 89 50 08          	mov    %rdx,0x8(%rax)

    for (uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE) {
   40539:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40540:	00 
   40541:	eb 49                	jmp    4058c <make_pages+0x100>
        vamapping vam = virtual_memory_lookup(kernel_pagetable, va);
   40543:	48 8b 0d b6 4a 01 00 	mov    0x14ab6(%rip),%rcx        # 55000 <kernel_pagetable>
   4054a:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4054e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40552:	48 89 ce             	mov    %rcx,%rsi
   40555:	48 89 c7             	mov    %rax,%rdi
   40558:	e8 3b 30 00 00       	call   43598 <virtual_memory_lookup>
        if (vam.pn != -1) {
   4055d:	8b 45 b8             	mov    -0x48(%rbp),%eax
   40560:	83 f8 ff             	cmp    $0xffffffff,%eax
   40563:	74 1f                	je     40584 <make_pages+0xf8>
            virtual_memory_map(l4, va, vam.pa, PAGESIZE, PTE_P | PTE_W );
   40565:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   40569:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4056d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40571:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40577:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4057c:	48 89 c7             	mov    %rax,%rdi
   4057f:	e8 ca 2b 00 00       	call   4314e <virtual_memory_map>
    for (uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE) {
   40584:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4058b:	00 
   4058c:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   40593:	00 
   40594:	76 ad                	jbe    40543 <make_pages+0xb7>
        }
    }
    return l4;
   40596:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
   4059a:	c9                   	leave  
   4059b:	c3                   	ret    

000000000004059c <process_setup>:

void process_setup(pid_t pid, int program_number) {
   4059c:	f3 0f 1e fa          	endbr64 
   405a0:	55                   	push   %rbp
   405a1:	48 89 e5             	mov    %rsp,%rbp
   405a4:	48 83 ec 20          	sub    $0x20,%rsp
   405a8:	89 7d ec             	mov    %edi,-0x14(%rbp)
   405ab:	89 75 e8             	mov    %esi,-0x18(%rbp)
    process_init(&processes[pid], 0);
   405ae:	8b 45 ec             	mov    -0x14(%rbp),%eax
   405b1:	48 63 d0             	movslq %eax,%rdx
   405b4:	48 89 d0             	mov    %rdx,%rax
   405b7:	48 c1 e0 03          	shl    $0x3,%rax
   405bb:	48 29 d0             	sub    %rdx,%rax
   405be:	48 c1 e0 05          	shl    $0x5,%rax
   405c2:	48 8d 15 57 1a 01 00 	lea    0x11a57(%rip),%rdx        # 52020 <processes>
   405c9:	48 01 d0             	add    %rdx,%rax
   405cc:	be 00 00 00 00       	mov    $0x0,%esi
   405d1:	48 89 c7             	mov    %rax,%rdi
   405d4:	e8 bb 1f 00 00       	call   42594 <process_init>

    x86_64_pagetable *l4 = make_pages(pid);
   405d9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   405dc:	89 c7                	mov    %eax,%edi
   405de:	e8 a9 fe ff ff       	call   4048c <make_pages>
   405e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

    processes[pid].p_pagetable = l4;
   405e7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   405ea:	48 63 d0             	movslq %eax,%rdx
   405ed:	48 89 d0             	mov    %rdx,%rax
   405f0:	48 c1 e0 03          	shl    $0x3,%rax
   405f4:	48 29 d0             	sub    %rdx,%rax
   405f7:	48 c1 e0 05          	shl    $0x5,%rax
   405fb:	48 89 c1             	mov    %rax,%rcx
   405fe:	48 8d 15 eb 1a 01 00 	lea    0x11aeb(%rip),%rdx        # 520f0 <processes+0xd0>
   40605:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40609:	48 89 04 11          	mov    %rax,(%rcx,%rdx,1)
    // FIXME
    // virtual_memory_map(l4, 0, 0,
    //                PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(l4, CONSOLE_ADDR, CONSOLE_ADDR,
   4060d:	48 8d 15 ec 79 07 00 	lea    0x779ec(%rip),%rdx        # b8000 <console>
   40614:	48 8d 35 e5 79 07 00 	lea    0x779e5(%rip),%rsi        # b8000 <console>
   4061b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4061f:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40625:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4062a:	48 89 c7             	mov    %rax,%rdi
   4062d:	e8 1c 2b 00 00       	call   4314e <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    int r = program_load(&processes[pid], program_number, NULL);
   40632:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40635:	48 63 d0             	movslq %eax,%rdx
   40638:	48 89 d0             	mov    %rdx,%rax
   4063b:	48 c1 e0 03          	shl    $0x3,%rax
   4063f:	48 29 d0             	sub    %rdx,%rax
   40642:	48 c1 e0 05          	shl    $0x5,%rax
   40646:	48 8d 15 d3 19 01 00 	lea    0x119d3(%rip),%rdx        # 52020 <processes>
   4064d:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
   40651:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40654:	ba 00 00 00 00       	mov    $0x0,%edx
   40659:	89 c6                	mov    %eax,%esi
   4065b:	48 89 cf             	mov    %rcx,%rdi
   4065e:	e8 30 30 00 00       	call   43693 <program_load>
   40663:	89 45 f4             	mov    %eax,-0xc(%rbp)
    assert(r >= 0);
   40666:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4066a:	79 1e                	jns    4068a <process_setup+0xee>
   4066c:	48 8d 05 c6 44 00 00 	lea    0x44c6(%rip),%rax        # 44b39 <console_clear+0x64>
   40673:	48 89 c2             	mov    %rax,%rdx
   40676:	be c0 00 00 00       	mov    $0xc0,%esi
   4067b:	48 8d 05 be 44 00 00 	lea    0x44be(%rip),%rax        # 44b40 <console_clear+0x6b>
   40682:	48 89 c7             	mov    %rax,%rdi
   40685:	e8 40 27 00 00       	call   42dca <assert_fail>

    virtual_memory_map(l4, MEMSIZE_VIRTUAL - PAGESIZE, find_page(pid), PAGESIZE, PTE_P | PTE_W | PTE_U);
   4068a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4068d:	0f be c0             	movsbl %al,%eax
   40690:	89 c7                	mov    %eax,%edi
   40692:	e8 6d fd ff ff       	call   40404 <find_page>
   40697:	48 89 c2             	mov    %rax,%rdx
   4069a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4069e:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   406a4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   406a9:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   406ae:	48 89 c7             	mov    %rax,%rdi
   406b1:	e8 98 2a 00 00       	call   4314e <virtual_memory_map>
    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL;
   406b6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   406b9:	48 63 d0             	movslq %eax,%rdx
   406bc:	48 89 d0             	mov    %rdx,%rax
   406bf:	48 c1 e0 03          	shl    $0x3,%rax
   406c3:	48 29 d0             	sub    %rdx,%rax
   406c6:	48 c1 e0 05          	shl    $0x5,%rax
   406ca:	48 89 c2             	mov    %rax,%rdx
   406cd:	48 8d 05 04 1a 01 00 	lea    0x11a04(%rip),%rax        # 520d8 <processes+0xb8>
   406d4:	48 c7 04 02 00 00 30 	movq   $0x300000,(%rdx,%rax,1)
   406db:	00 

    processes[pid].p_state = P_RUNNABLE;
   406dc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   406df:	48 63 d0             	movslq %eax,%rdx
   406e2:	48 89 d0             	mov    %rdx,%rax
   406e5:	48 c1 e0 03          	shl    $0x3,%rax
   406e9:	48 29 d0             	sub    %rdx,%rax
   406ec:	48 c1 e0 05          	shl    $0x5,%rax
   406f0:	48 89 c2             	mov    %rax,%rdx
   406f3:	48 8d 05 ee 19 01 00 	lea    0x119ee(%rip),%rax        # 520e8 <processes+0xc8>
   406fa:	c7 04 02 01 00 00 00 	movl   $0x1,(%rdx,%rax,1)
}
   40701:	90                   	nop
   40702:	c9                   	leave  
   40703:	c3                   	ret    

0000000000040704 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40704:	f3 0f 1e fa          	endbr64 
   40708:	55                   	push   %rbp
   40709:	48 89 e5             	mov    %rsp,%rbp
   4070c:	48 83 ec 10          	sub    $0x10,%rsp
   40710:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40714:	89 f0                	mov    %esi,%eax
   40716:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   40719:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4071d:	25 ff 0f 00 00       	and    $0xfff,%eax
   40722:	48 85 c0             	test   %rax,%rax
   40725:	75 27                	jne    4074e <assign_physical_page+0x4a>
        || addr >= MEMSIZE_PHYSICAL
   40727:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4072e:	00 
   4072f:	77 1d                	ja     4074e <assign_physical_page+0x4a>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40731:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40735:	48 c1 e8 0c          	shr    $0xc,%rax
   40739:	48 98                	cltq   
   4073b:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4073f:	48 8d 05 fb 26 01 00 	lea    0x126fb(%rip),%rax        # 52e41 <pageinfo+0x1>
   40746:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4074a:	84 c0                	test   %al,%al
   4074c:	74 07                	je     40755 <assign_physical_page+0x51>
        return -1;
   4074e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40753:	eb 3a                	jmp    4078f <assign_physical_page+0x8b>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   40755:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40759:	48 c1 e8 0c          	shr    $0xc,%rax
   4075d:	48 98                	cltq   
   4075f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40763:	48 8d 05 d7 26 01 00 	lea    0x126d7(%rip),%rax        # 52e41 <pageinfo+0x1>
   4076a:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4076e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40772:	48 c1 e8 0c          	shr    $0xc,%rax
   40776:	48 98                	cltq   
   40778:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4077c:	48 8d 15 bd 26 01 00 	lea    0x126bd(%rip),%rdx        # 52e40 <pageinfo>
   40783:	0f b6 45 f4          	movzbl -0xc(%rbp),%eax
   40787:	88 04 11             	mov    %al,(%rcx,%rdx,1)
        return 0;
   4078a:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   4078f:	c9                   	leave  
   40790:	c3                   	ret    

0000000000040791 <syscall_mapping>:

void syscall_mapping(proc* p){
   40791:	f3 0f 1e fa          	endbr64 
   40795:	55                   	push   %rbp
   40796:	48 89 e5             	mov    %rsp,%rbp
   40799:	48 83 ec 70          	sub    $0x70,%rsp
   4079d:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   407a1:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407a5:	48 8b 40 38          	mov    0x38(%rax),%rax
   407a9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   407ad:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407b1:	48 8b 40 30          	mov    0x30(%rax),%rax
   407b5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   407b9:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407bd:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407c4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   407c8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407cc:	48 89 ce             	mov    %rcx,%rsi
   407cf:	48 89 c7             	mov    %rax,%rdi
   407d2:	e8 c1 2d 00 00       	call   43598 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   407d7:	8b 45 e0             	mov    -0x20(%rbp),%eax
   407da:	48 98                	cltq   
   407dc:	83 e0 06             	and    $0x6,%eax
   407df:	48 83 f8 06          	cmp    $0x6,%rax
   407e3:	75 73                	jne    40858 <syscall_mapping+0xc7>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   407e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407e9:	48 83 c0 17          	add    $0x17,%rax
   407ed:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   407f1:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407f5:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407fc:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40800:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40804:	48 89 ce             	mov    %rcx,%rsi
   40807:	48 89 c7             	mov    %rax,%rdi
   4080a:	e8 89 2d 00 00       	call   43598 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   4080f:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40812:	48 98                	cltq   
   40814:	83 e0 03             	and    $0x3,%eax
   40817:	48 83 f8 03          	cmp    $0x3,%rax
   4081b:	75 3e                	jne    4085b <syscall_mapping+0xca>
        return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   4081d:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40821:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40828:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4082c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40830:	48 89 ce             	mov    %rcx,%rsi
   40833:	48 89 c7             	mov    %rax,%rdi
   40836:	e8 5d 2d 00 00       	call   43598 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   4083b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4083f:	48 89 c1             	mov    %rax,%rcx
   40842:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40846:	ba 18 00 00 00       	mov    $0x18,%edx
   4084b:	48 89 c6             	mov    %rax,%rsi
   4084e:	48 89 cf             	mov    %rcx,%rdi
   40851:	e8 c4 31 00 00       	call   43a1a <memcpy>
   40856:	eb 04                	jmp    4085c <syscall_mapping+0xcb>
        return;
   40858:	90                   	nop
   40859:	eb 01                	jmp    4085c <syscall_mapping+0xcb>
        return;
   4085b:	90                   	nop
}
   4085c:	c9                   	leave  
   4085d:	c3                   	ret    

000000000004085e <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   4085e:	f3 0f 1e fa          	endbr64 
   40862:	55                   	push   %rbp
   40863:	48 89 e5             	mov    %rsp,%rbp
   40866:	48 83 ec 18          	sub    $0x18,%rsp
   4086a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   4086e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40872:	48 8b 40 38          	mov    0x38(%rax),%rax
   40876:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40879:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4087d:	75 14                	jne    40893 <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   4087f:	0f b6 05 7a 57 00 00 	movzbl 0x577a(%rip),%eax        # 46000 <disp_global>
   40886:	84 c0                	test   %al,%al
   40888:	0f 94 c0             	sete   %al
   4088b:	88 05 6f 57 00 00    	mov    %al,0x576f(%rip)        # 46000 <disp_global>
   40891:	eb 36                	jmp    408c9 <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40893:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40897:	78 2f                	js     408c8 <syscall_mem_tog+0x6a>
   40899:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4089d:	7f 29                	jg     408c8 <syscall_mem_tog+0x6a>
   4089f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408a3:	8b 00                	mov    (%rax),%eax
   408a5:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   408a8:	75 1e                	jne    408c8 <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   408aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408ae:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   408b5:	84 c0                	test   %al,%al
   408b7:	0f 94 c0             	sete   %al
   408ba:	89 c2                	mov    %eax,%edx
   408bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408c0:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   408c6:	eb 01                	jmp    408c9 <syscall_mem_tog+0x6b>
            return;
   408c8:	90                   	nop
    }
}
   408c9:	c9                   	leave  
   408ca:	c3                   	ret    

00000000000408cb <exit>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exit(pid_t pid){
   408cb:	f3 0f 1e fa          	endbr64 
   408cf:	55                   	push   %rbp
   408d0:	48 89 e5             	mov    %rsp,%rbp
   408d3:	48 83 ec 30          	sub    $0x30,%rsp
   408d7:	89 7d dc             	mov    %edi,-0x24(%rbp)
        for (uintptr_t addr = 0; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE){
   408da:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   408e1:	00 
   408e2:	e9 cc 00 00 00       	jmp    409b3 <exit+0xe8>
            vamapping vam = virtual_memory_lookup(kernel_pagetable, addr);
   408e7:	48 8b 0d 12 47 01 00 	mov    0x14712(%rip),%rcx        # 55000 <kernel_pagetable>
   408ee:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   408f2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   408f6:	48 89 ce             	mov    %rcx,%rsi
   408f9:	48 89 c7             	mov    %rax,%rdi
   408fc:	e8 97 2c 00 00       	call   43598 <virtual_memory_lookup>
            // free pages owned by pid
            if (pageinfo[vam.pn].owner == pid){
   40901:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40904:	48 98                	cltq   
   40906:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4090a:	48 8d 05 2f 25 01 00 	lea    0x1252f(%rip),%rax        # 52e40 <pageinfo>
   40911:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40915:	0f be c0             	movsbl %al,%eax
   40918:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   4091b:	75 2a                	jne    40947 <exit+0x7c>
                pageinfo[vam.pn].owner = PO_FREE;
   4091d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40920:	48 98                	cltq   
   40922:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40926:	48 8d 05 13 25 01 00 	lea    0x12513(%rip),%rax        # 52e40 <pageinfo>
   4092d:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[vam.pn].refcount = 0;
   40931:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40934:	48 98                	cltq   
   40936:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4093a:	48 8d 05 00 25 01 00 	lea    0x12500(%rip),%rax        # 52e41 <pageinfo+0x1>
   40941:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
   40945:	eb 64                	jmp    409ab <exit+0xe0>
            }
            // decrease ref to shared pages 
        else if (pageinfo[vam.pn].refcount > 1 && pageinfo[vam.pn].owner > 0 
   40947:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4094a:	48 98                	cltq   
   4094c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40950:	48 8d 05 ea 24 01 00 	lea    0x124ea(%rip),%rax        # 52e41 <pageinfo+0x1>
   40957:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4095b:	3c 01                	cmp    $0x1,%al
   4095d:	7e 4c                	jle    409ab <exit+0xe0>
   4095f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40962:	48 98                	cltq   
   40964:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40968:	48 8d 05 d1 24 01 00 	lea    0x124d1(%rip),%rax        # 52e40 <pageinfo>
   4096f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40973:	84 c0                	test   %al,%al
   40975:	7e 34                	jle    409ab <exit+0xe0>
                        && addr == PROC_START_ADDR) {
   40977:	48 81 7d f8 00 00 10 	cmpq   $0x100000,-0x8(%rbp)
   4097e:	00 
   4097f:	75 2a                	jne    409ab <exit+0xe0>
	           pageinfo[vam.pn].refcount--;
   40981:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40984:	48 63 d0             	movslq %eax,%rdx
   40987:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   4098b:	48 8d 15 af 24 01 00 	lea    0x124af(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40992:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40996:	83 ea 01             	sub    $0x1,%edx
   40999:	89 d1                	mov    %edx,%ecx
   4099b:	48 98                	cltq   
   4099d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   409a1:	48 8d 05 99 24 01 00 	lea    0x12499(%rip),%rax        # 52e41 <pageinfo+0x1>
   409a8:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        for (uintptr_t addr = 0; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE){
   409ab:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   409b2:	00 
   409b3:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   409ba:	00 
   409bb:	0f 86 26 ff ff ff    	jbe    408e7 <exit+0x1c>
	       }  
        }
    processes[pid].p_state = P_FREE;
   409c1:	8b 45 dc             	mov    -0x24(%rbp),%eax
   409c4:	48 63 d0             	movslq %eax,%rdx
   409c7:	48 89 d0             	mov    %rdx,%rax
   409ca:	48 c1 e0 03          	shl    $0x3,%rax
   409ce:	48 29 d0             	sub    %rdx,%rax
   409d1:	48 c1 e0 05          	shl    $0x5,%rax
   409d5:	48 89 c2             	mov    %rax,%rdx
   409d8:	48 8d 05 09 17 01 00 	lea    0x11709(%rip),%rax        # 520e8 <processes+0xc8>
   409df:	c7 04 02 00 00 00 00 	movl   $0x0,(%rdx,%rax,1)
        
}
   409e6:	90                   	nop
   409e7:	c9                   	leave  
   409e8:	c3                   	ret    

00000000000409e9 <exception>:

void exception(x86_64_registers* reg) {
   409e9:	f3 0f 1e fa          	endbr64 
   409ed:	55                   	push   %rbp
   409ee:	48 89 e5             	mov    %rsp,%rbp
   409f1:	48 81 ec 80 01 00 00 	sub    $0x180,%rsp
   409f8:	48 89 bd 88 fe ff ff 	mov    %rdi,-0x178(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   409ff:	48 8b 05 fa 15 01 00 	mov    0x115fa(%rip),%rax        # 52000 <current>
   40a06:	48 8b 95 88 fe ff ff 	mov    -0x178(%rbp),%rdx
   40a0d:	48 83 c0 08          	add    $0x8,%rax
   40a11:	48 89 d6             	mov    %rdx,%rsi
   40a14:	ba 18 00 00 00       	mov    $0x18,%edx
   40a19:	48 89 c7             	mov    %rax,%rdi
   40a1c:	48 89 d1             	mov    %rdx,%rcx
   40a1f:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40a22:	48 8b 05 d7 45 01 00 	mov    0x145d7(%rip),%rax        # 55000 <kernel_pagetable>
   40a29:	48 89 c7             	mov    %rax,%rdi
   40a2c:	e8 ab 25 00 00       	call   42fdc <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40a31:	8b 05 c5 85 07 00    	mov    0x785c5(%rip),%eax        # b8ffc <cursorpos>
   40a37:	89 c7                	mov    %eax,%edi
   40a39:	e8 24 1c 00 00       	call   42662 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40a3e:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40a45:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40a4c:	48 83 f8 0e          	cmp    $0xe,%rax
   40a50:	74 14                	je     40a66 <exception+0x7d>
   40a52:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40a59:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40a60:	48 83 f8 0d          	cmp    $0xd,%rax
   40a64:	75 16                	jne    40a7c <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40a66:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40a6d:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a74:	83 e0 04             	and    $0x4,%eax
   40a77:	48 85 c0             	test   %rax,%rax
   40a7a:	74 1a                	je     40a96 <exception+0xad>
    {
        check_virtual_memory();
   40a7c:	e8 27 0c 00 00       	call   416a8 <check_virtual_memory>
        if(disp_global){
   40a81:	0f b6 05 78 55 00 00 	movzbl 0x5578(%rip),%eax        # 46000 <disp_global>
   40a88:	84 c0                	test   %al,%al
   40a8a:	74 0a                	je     40a96 <exception+0xad>
            memshow_physical();
   40a8c:	e8 e0 0d 00 00       	call   41871 <memshow_physical>
            memshow_virtual_animate();
   40a91:	e8 7d 11 00 00       	call   41c13 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40a96:	e8 dd 20 00 00       	call   42b78 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40a9b:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40aa2:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40aa9:	48 83 e8 0e          	sub    $0xe,%rax
   40aad:	48 83 f8 2a          	cmp    $0x2a,%rax
   40ab1:	0f 87 a4 06 00 00    	ja     4115b <exception+0x772>
   40ab7:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   40abe:	00 
   40abf:	48 8d 05 1a 41 00 00 	lea    0x411a(%rip),%rax        # 44be0 <console_clear+0x10b>
   40ac6:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40ac9:	48 98                	cltq   
   40acb:	48 8d 15 0e 41 00 00 	lea    0x410e(%rip),%rdx        # 44be0 <console_clear+0x10b>
   40ad2:	48 01 d0             	add    %rdx,%rax
   40ad5:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40ad8:	48 8b 05 21 15 01 00 	mov    0x11521(%rip),%rax        # 52000 <current>
   40adf:	48 8b 40 38          	mov    0x38(%rax),%rax
   40ae3:	48 89 45 98          	mov    %rax,-0x68(%rbp)
		if((void *)addr == NULL)
   40ae7:	48 83 7d 98 00       	cmpq   $0x0,-0x68(%rbp)
   40aec:	75 0f                	jne    40afd <exception+0x114>
		    panic(NULL);
   40aee:	bf 00 00 00 00       	mov    $0x0,%edi
   40af3:	b8 00 00 00 00       	mov    $0x0,%eax
   40af8:	e8 dd 21 00 00       	call   42cda <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40afd:	48 8b 05 fc 14 01 00 	mov    0x114fc(%rip),%rax        # 52000 <current>
   40b04:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40b0b:	48 8d 85 60 ff ff ff 	lea    -0xa0(%rbp),%rax
   40b12:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   40b16:	48 89 ce             	mov    %rcx,%rsi
   40b19:	48 89 c7             	mov    %rax,%rdi
   40b1c:	e8 77 2a 00 00       	call   43598 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40b21:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   40b28:	48 89 c1             	mov    %rax,%rcx
   40b2b:	48 8d 85 90 fe ff ff 	lea    -0x170(%rbp),%rax
   40b32:	ba a0 00 00 00       	mov    $0xa0,%edx
   40b37:	48 89 ce             	mov    %rcx,%rsi
   40b3a:	48 89 c7             	mov    %rax,%rdi
   40b3d:	e8 d8 2e 00 00       	call   43a1a <memcpy>
		panic(msg);
   40b42:	48 8d 85 90 fe ff ff 	lea    -0x170(%rbp),%rax
   40b49:	48 89 c7             	mov    %rax,%rdi
   40b4c:	b8 00 00 00 00       	mov    $0x0,%eax
   40b51:	e8 84 21 00 00       	call   42cda <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40b56:	48 8b 05 a3 14 01 00 	mov    0x114a3(%rip),%rax        # 52000 <current>
   40b5d:	8b 10                	mov    (%rax),%edx
   40b5f:	48 8b 05 9a 14 01 00 	mov    0x1149a(%rip),%rax        # 52000 <current>
   40b66:	48 63 d2             	movslq %edx,%rdx
   40b69:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40b6d:	e9 f9 05 00 00       	jmp    4116b <exception+0x782>

    case INT_SYS_YIELD:
        schedule();
   40b72:	e8 1d 06 00 00       	call   41194 <schedule>
        break;                  /* will not be reached */
   40b77:	e9 ef 05 00 00       	jmp    4116b <exception+0x782>

case INT_SYS_PAGE_ALLOC: {
    uintptr_t va = current->p_registers.reg_rdi;
   40b7c:	48 8b 05 7d 14 01 00 	mov    0x1147d(%rip),%rax        # 52000 <current>
   40b83:	48 8b 40 38          	mov    0x38(%rax),%rax
   40b87:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    // check allignment and bounds
    if (va % PAGESIZE != 0) {
   40b8b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40b8f:	25 ff 0f 00 00       	and    $0xfff,%eax
   40b94:	48 85 c0             	test   %rax,%rax
   40b97:	74 14                	je     40bad <exception+0x1c4>
        current->p_registers.reg_rax = -1; 
   40b99:	48 8b 05 60 14 01 00 	mov    0x11460(%rip),%rax        # 52000 <current>
   40ba0:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40ba7:	ff 
        break;
   40ba8:	e9 be 05 00 00       	jmp    4116b <exception+0x782>
    }
    if (va >= MEMSIZE_VIRTUAL) {
   40bad:	48 81 7d b0 ff ff 2f 	cmpq   $0x2fffff,-0x50(%rbp)
   40bb4:	00 
   40bb5:	76 14                	jbe    40bcb <exception+0x1e2>
        current->p_registers.reg_rax = -1; 
   40bb7:	48 8b 05 42 14 01 00 	mov    0x11442(%rip),%rax        # 52000 <current>
   40bbe:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40bc5:	ff 
        break;
   40bc6:	e9 a0 05 00 00       	jmp    4116b <exception+0x782>
    }
    if (va < PROC_START_ADDR) {
   40bcb:	48 81 7d b0 ff ff 0f 	cmpq   $0xfffff,-0x50(%rbp)
   40bd2:	00 
   40bd3:	77 14                	ja     40be9 <exception+0x200>
        current->p_registers.reg_rax = -1; 
   40bd5:	48 8b 05 24 14 01 00 	mov    0x11424(%rip),%rax        # 52000 <current>
   40bdc:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40be3:	ff 
        break;
   40be4:	e9 82 05 00 00       	jmp    4116b <exception+0x782>
    }   
    uintptr_t pa = find_page(current->p_pid);
   40be9:	48 8b 05 10 14 01 00 	mov    0x11410(%rip),%rax        # 52000 <current>
   40bf0:	8b 00                	mov    (%rax),%eax
   40bf2:	0f be c0             	movsbl %al,%eax
   40bf5:	89 c7                	mov    %eax,%edi
   40bf7:	e8 08 f8 ff ff       	call   40404 <find_page>
   40bfc:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    if (pa == 0) {
   40c00:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   40c05:	75 14                	jne    40c1b <exception+0x232>
        current->p_registers.reg_rax = -1; 
   40c07:	48 8b 05 f2 13 01 00 	mov    0x113f2(%rip),%rax        # 52000 <current>
   40c0e:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40c15:	ff 
        break;
   40c16:	e9 50 05 00 00       	jmp    4116b <exception+0x782>
    }
    int perm = PTE_P | PTE_W | PTE_U;
   40c1b:	c7 45 a4 07 00 00 00 	movl   $0x7,-0x5c(%rbp)

    int r = virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, perm);
   40c22:	48 8b 05 d7 13 01 00 	mov    0x113d7(%rip),%rax        # 52000 <current>
   40c29:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40c30:	8b 4d a4             	mov    -0x5c(%rbp),%ecx
   40c33:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   40c37:	48 8b 75 b0          	mov    -0x50(%rbp),%rsi
   40c3b:	41 89 c8             	mov    %ecx,%r8d
   40c3e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40c43:	48 89 c7             	mov    %rax,%rdi
   40c46:	e8 03 25 00 00       	call   4314e <virtual_memory_map>
   40c4b:	89 45 a0             	mov    %eax,-0x60(%rbp)

    if (r != 0) {
   40c4e:	83 7d a0 00          	cmpl   $0x0,-0x60(%rbp)
   40c52:	74 46                	je     40c9a <exception+0x2b1>
        // If mapping fails, free the physical page
        pageinfo[PAGENUMBER(pa)].refcount = 0;
   40c54:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40c58:	48 c1 e8 0c          	shr    $0xc,%rax
   40c5c:	48 98                	cltq   
   40c5e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40c62:	48 8d 05 d8 21 01 00 	lea    0x121d8(%rip),%rax        # 52e41 <pageinfo+0x1>
   40c69:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(pa)].owner = PO_FREE;
   40c6d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40c71:	48 c1 e8 0c          	shr    $0xc,%rax
   40c75:	48 98                	cltq   
   40c77:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40c7b:	48 8d 05 be 21 01 00 	lea    0x121be(%rip),%rax        # 52e40 <pageinfo>
   40c82:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        current->p_registers.reg_rax = -1;
   40c86:	48 8b 05 73 13 01 00 	mov    0x11373(%rip),%rax        # 52000 <current>
   40c8d:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40c94:	ff 
        break;
   40c95:	e9 d1 04 00 00       	jmp    4116b <exception+0x782>
    }

    // Success: Return 0
    current->p_registers.reg_rax = 0;
   40c9a:	48 8b 05 5f 13 01 00 	mov    0x1135f(%rip),%rax        # 52000 <current>
   40ca1:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40ca8:	00 
    break;
   40ca9:	e9 bd 04 00 00       	jmp    4116b <exception+0x782>
}
// was helped by ULA's on SYS_FORK
case INT_SYS_FORK: {
    // find free
    pid_t child_pid = -1;
   40cae:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    for (pid_t i = 1; i < NPROC; ++i) {
   40cb5:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   40cbc:	eb 40                	jmp    40cfe <exception+0x315>
        if (processes[i].p_state == P_FREE) {
   40cbe:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40cc1:	48 63 d0             	movslq %eax,%rdx
   40cc4:	48 89 d0             	mov    %rdx,%rax
   40cc7:	48 c1 e0 03          	shl    $0x3,%rax
   40ccb:	48 29 d0             	sub    %rdx,%rax
   40cce:	48 c1 e0 05          	shl    $0x5,%rax
   40cd2:	48 89 c2             	mov    %rax,%rdx
   40cd5:	48 8d 05 0c 14 01 00 	lea    0x1140c(%rip),%rax        # 520e8 <processes+0xc8>
   40cdc:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40cdf:	85 c0                	test   %eax,%eax
   40ce1:	75 17                	jne    40cfa <exception+0x311>
            child_pid = i;
   40ce3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ce6:	89 45 fc             	mov    %eax,-0x4(%rbp)
            current->p_registers.reg_rax = -1;
   40ce9:	48 8b 05 10 13 01 00 	mov    0x11310(%rip),%rax        # 52000 <current>
   40cf0:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40cf7:	ff 
            break;
   40cf8:	eb 0a                	jmp    40d04 <exception+0x31b>
    for (pid_t i = 1; i < NPROC; ++i) {
   40cfa:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40cfe:	83 7d f8 0f          	cmpl   $0xf,-0x8(%rbp)
   40d02:	7e ba                	jle    40cbe <exception+0x2d5>
        }
    }

    // no ree
    if (child_pid == -1) {
   40d04:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40d08:	75 14                	jne    40d1e <exception+0x335>
        current->p_registers.reg_rax = -1;
   40d0a:	48 8b 05 ef 12 01 00 	mov    0x112ef(%rip),%rax        # 52000 <current>
   40d11:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40d18:	ff 
        break;
   40d19:	e9 4d 04 00 00       	jmp    4116b <exception+0x782>
    }

    // reserve
    proc* parent = current;
   40d1e:	48 8b 05 db 12 01 00 	mov    0x112db(%rip),%rax        # 52000 <current>
   40d25:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    proc* child = &processes[child_pid];
   40d29:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d2c:	48 63 d0             	movslq %eax,%rdx
   40d2f:	48 89 d0             	mov    %rdx,%rax
   40d32:	48 c1 e0 03          	shl    $0x3,%rax
   40d36:	48 29 d0             	sub    %rdx,%rax
   40d39:	48 c1 e0 05          	shl    $0x5,%rax
   40d3d:	48 8d 15 dc 12 01 00 	lea    0x112dc(%rip),%rdx        # 52020 <processes>
   40d44:	48 01 d0             	add    %rdx,%rax
   40d47:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    process_init(child, child_pid);
   40d4b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40d4e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40d52:	89 d6                	mov    %edx,%esi
   40d54:	48 89 c7             	mov    %rax,%rdi
   40d57:	e8 38 18 00 00       	call   42594 <process_init>

    //allocate
    x86_64_pagetable* child_table = make_pages(child_pid);
   40d5c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d5f:	89 c7                	mov    %eax,%edi
   40d61:	e8 26 f7 ff ff       	call   4048c <make_pages>
   40d66:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    if (!child_table) {
   40d6a:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40d6f:	75 0f                	jne    40d80 <exception+0x397>
        exit(child_pid);
   40d71:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d74:	89 c7                	mov    %eax,%edi
   40d76:	e8 50 fb ff ff       	call   408cb <exit>
        break;
   40d7b:	e9 eb 03 00 00       	jmp    4116b <exception+0x782>
    }
    child->p_pagetable = child_table;
   40d80:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40d84:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40d88:	48 89 90 d0 00 00 00 	mov    %rdx,0xd0(%rax)
    int failed = 0;
   40d8f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    // map console

    vamapping console_mapping = virtual_memory_lookup(parent->p_pagetable, CONSOLE_ADDR);
   40d96:	48 8d 15 63 72 07 00 	lea    0x77263(%rip),%rdx        # b8000 <console>
   40d9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40da1:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40da8:	48 8d 85 48 ff ff ff 	lea    -0xb8(%rbp),%rax
   40daf:	48 89 ce             	mov    %rcx,%rsi
   40db2:	48 89 c7             	mov    %rax,%rdi
   40db5:	e8 de 27 00 00       	call   43598 <virtual_memory_lookup>
        if (console_mapping.pn != -1) {
   40dba:	8b 85 48 ff ff ff    	mov    -0xb8(%rbp),%eax
   40dc0:	83 f8 ff             	cmp    $0xffffffff,%eax
   40dc3:	74 65                	je     40e2a <exception+0x441>
            pageinfo[console_mapping.pn].refcount++;
   40dc5:	8b 85 48 ff ff ff    	mov    -0xb8(%rbp),%eax
   40dcb:	48 63 d0             	movslq %eax,%rdx
   40dce:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40dd2:	48 8d 15 68 20 01 00 	lea    0x12068(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40dd9:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40ddd:	83 c2 01             	add    $0x1,%edx
   40de0:	89 d1                	mov    %edx,%ecx
   40de2:	48 98                	cltq   
   40de4:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40de8:	48 8d 05 52 20 01 00 	lea    0x12052(%rip),%rax        # 52e41 <pageinfo+0x1>
   40def:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
            if (virtual_memory_map(child_table, CONSOLE_ADDR, CONSOLE_ADDR, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   40df2:	48 8d 15 07 72 07 00 	lea    0x77207(%rip),%rdx        # b8000 <console>
   40df9:	48 8d 35 00 72 07 00 	lea    0x77200(%rip),%rsi        # b8000 <console>
   40e00:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e04:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40e0a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40e0f:	48 89 c7             	mov    %rax,%rdi
   40e12:	e8 37 23 00 00       	call   4314e <virtual_memory_map>
   40e17:	85 c0                	test   %eax,%eax
   40e19:	79 0f                	jns    40e2a <exception+0x441>
                            exit(child_pid);
   40e1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e1e:	89 c7                	mov    %eax,%edi
   40e20:	e8 a6 fa ff ff       	call   408cb <exit>
            break;
   40e25:	e9 41 03 00 00       	jmp    4116b <exception+0x782>
            }
    }

    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40e2a:	48 c7 45 e8 00 00 10 	movq   $0x100000,-0x18(%rbp)
   40e31:	00 
   40e32:	e9 45 01 00 00       	jmp    40f7c <exception+0x593>
        vamapping parent_mapping = virtual_memory_lookup(parent->p_pagetable, va);
   40e37:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40e3b:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40e42:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
   40e49:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40e4d:	48 89 ce             	mov    %rcx,%rsi
   40e50:	48 89 c7             	mov    %rax,%rdi
   40e53:	e8 40 27 00 00       	call   43598 <virtual_memory_lookup>
        // skip console and nonexistent pages
        if (va == CONSOLE_ADDR || parent_mapping.pn == -1) {
   40e58:	48 8d 05 a1 71 07 00 	lea    0x771a1(%rip),%rax        # b8000 <console>
   40e5f:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40e63:	0f 84 0a 01 00 00    	je     40f73 <exception+0x58a>
   40e69:	8b 85 30 ff ff ff    	mov    -0xd0(%rbp),%eax
   40e6f:	83 f8 ff             	cmp    $0xffffffff,%eax
   40e72:	0f 84 fb 00 00 00    	je     40f73 <exception+0x58a>
            continue; 
        }

        if (parent_mapping.perm & PTE_W) {
   40e78:	8b 85 40 ff ff ff    	mov    -0xc0(%rbp),%eax
   40e7e:	48 98                	cltq   
   40e80:	83 e0 02             	and    $0x2,%eax
   40e83:	48 85 c0             	test   %rax,%rax
   40e86:	74 79                	je     40f01 <exception+0x518>
        // Allocate a new physical page for the child
            uintptr_t new_pa = find_page(child_pid);
   40e88:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e8b:	0f be c0             	movsbl %al,%eax
   40e8e:	89 c7                	mov    %eax,%edi
   40e90:	e8 6f f5 ff ff       	call   40404 <find_page>
   40e95:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (!new_pa) {
   40e99:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   40e9e:	75 0c                	jne    40eac <exception+0x4c3>
                failed = 1;
   40ea0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
                break;
   40ea7:	e9 de 00 00 00       	jmp    40f8a <exception+0x5a1>
            }
            memcpy((void*) new_pa, (void*) parent_mapping.pa, PAGESIZE);
   40eac:	48 8b 85 38 ff ff ff 	mov    -0xc8(%rbp),%rax
   40eb3:	48 89 c1             	mov    %rax,%rcx
   40eb6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40eba:	ba 00 10 00 00       	mov    $0x1000,%edx
   40ebf:	48 89 ce             	mov    %rcx,%rsi
   40ec2:	48 89 c7             	mov    %rax,%rdi
   40ec5:	e8 50 2b 00 00       	call   43a1a <memcpy>

            int r = virtual_memory_map(child_table, va, new_pa, PAGESIZE, parent_mapping.perm);
   40eca:	8b 8d 40 ff ff ff    	mov    -0xc0(%rbp),%ecx
   40ed0:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   40ed4:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40ed8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40edc:	41 89 c8             	mov    %ecx,%r8d
   40edf:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40ee4:	48 89 c7             	mov    %rax,%rdi
   40ee7:	e8 62 22 00 00       	call   4314e <virtual_memory_map>
   40eec:	89 45 bc             	mov    %eax,-0x44(%rbp)
            if (r < 0) {
   40eef:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   40ef3:	79 7f                	jns    40f74 <exception+0x58b>
                failed = 1;
   40ef5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
                // pageinfo[PAGENUMBER(new_pa)].refcount = 0; 
                // pageinfo[PAGENUMBER(new_pa)].owner = PO_FREE;
                break;
   40efc:	e9 89 00 00 00       	jmp    40f8a <exception+0x5a1>
            }
        } else if (((parent_mapping.perm & (PTE_P | PTE_U)) == (PTE_P | PTE_U))) {
   40f01:	8b 85 40 ff ff ff    	mov    -0xc0(%rbp),%eax
   40f07:	48 98                	cltq   
   40f09:	83 e0 05             	and    $0x5,%eax
   40f0c:	48 83 f8 05          	cmp    $0x5,%rax
   40f10:	75 62                	jne    40f74 <exception+0x58b>
                
            if (virtual_memory_map(child_table, va, parent_mapping.pa, PAGESIZE, parent_mapping.perm) < 0) {
   40f12:	8b 8d 40 ff ff ff    	mov    -0xc0(%rbp),%ecx
   40f18:	48 8b 95 38 ff ff ff 	mov    -0xc8(%rbp),%rdx
   40f1f:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40f23:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f27:	41 89 c8             	mov    %ecx,%r8d
   40f2a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40f2f:	48 89 c7             	mov    %rax,%rdi
   40f32:	e8 17 22 00 00       	call   4314e <virtual_memory_map>
   40f37:	85 c0                	test   %eax,%eax
   40f39:	79 09                	jns    40f44 <exception+0x55b>
                failed = 1;
   40f3b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
                break;
   40f42:	eb 46                	jmp    40f8a <exception+0x5a1>
            }
            pageinfo[parent_mapping.pn].refcount++;
   40f44:	8b 85 30 ff ff ff    	mov    -0xd0(%rbp),%eax
   40f4a:	48 63 d0             	movslq %eax,%rdx
   40f4d:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40f51:	48 8d 15 e9 1e 01 00 	lea    0x11ee9(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40f58:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40f5c:	83 c2 01             	add    $0x1,%edx
   40f5f:	89 d1                	mov    %edx,%ecx
   40f61:	48 98                	cltq   
   40f63:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40f67:	48 8d 05 d3 1e 01 00 	lea    0x11ed3(%rip),%rax        # 52e41 <pageinfo+0x1>
   40f6e:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
            continue;
   40f71:	eb 01                	jmp    40f74 <exception+0x58b>
            continue; 
   40f73:	90                   	nop
    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40f74:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   40f7b:	00 
   40f7c:	48 81 7d e8 ff ff 2f 	cmpq   $0x2fffff,-0x18(%rbp)
   40f83:	00 
   40f84:	0f 86 ad fe ff ff    	jbe    40e37 <exception+0x44e>
        }
    }

        if (failed != 0) {
   40f8a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40f8e:	74 0f                	je     40f9f <exception+0x5b6>
            exit(child_pid);
   40f90:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f93:	89 c7                	mov    %eax,%edi
   40f95:	e8 31 f9 ff ff       	call   408cb <exit>
            break;
   40f9a:	e9 cc 01 00 00       	jmp    4116b <exception+0x782>
        }

    child->p_registers = parent->p_registers;
   40f9f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40fa3:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40fa7:	48 83 c0 08          	add    $0x8,%rax
   40fab:	48 83 c2 08          	add    $0x8,%rdx
   40faf:	b9 18 00 00 00       	mov    $0x18,%ecx
   40fb4:	48 89 c7             	mov    %rax,%rdi
   40fb7:	48 89 d6             	mov    %rdx,%rsi
   40fba:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    child->p_registers.reg_rax = 0; 
   40fbd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40fc1:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40fc8:	00 
    child->p_state = P_RUNNABLE;
   40fc9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40fcd:	c7 80 c8 00 00 00 01 	movl   $0x1,0xc8(%rax)
   40fd4:	00 00 00 
    current->p_registers.reg_rax = child_pid;
   40fd7:	48 8b 05 22 10 01 00 	mov    0x11022(%rip),%rax        # 52000 <current>
   40fde:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40fe1:	48 63 d2             	movslq %edx,%rdx
   40fe4:	48 89 50 08          	mov    %rdx,0x8(%rax)
    break;
   40fe8:	e9 7e 01 00 00       	jmp    4116b <exception+0x782>

    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40fed:	48 8b 05 0c 10 01 00 	mov    0x1100c(%rip),%rax        # 52000 <current>
   40ff4:	48 89 c7             	mov    %rax,%rdi
   40ff7:	e8 95 f7 ff ff       	call   40791 <syscall_mapping>
            break;
   40ffc:	e9 6a 01 00 00       	jmp    4116b <exception+0x782>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   41001:	48 8b 05 f8 0f 01 00 	mov    0x10ff8(%rip),%rax        # 52000 <current>
   41008:	48 89 c7             	mov    %rax,%rdi
   4100b:	e8 4e f8 ff ff       	call   4085e <syscall_mem_tog>
	    break;
   41010:	e9 56 01 00 00       	jmp    4116b <exception+0x782>
	}

    case INT_TIMER:
        ++ticks;
   41015:	8b 05 05 1e 01 00    	mov    0x11e05(%rip),%eax        # 52e20 <ticks>
   4101b:	83 c0 01             	add    $0x1,%eax
   4101e:	89 05 fc 1d 01 00    	mov    %eax,0x11dfc(%rip)        # 52e20 <ticks>
        schedule();
   41024:	e8 6b 01 00 00       	call   41194 <schedule>
        break;                  /* will not be reached */
   41029:	e9 3d 01 00 00       	jmp    4116b <exception+0x782>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   4102e:	0f 20 d0             	mov    %cr2,%rax
   41031:	48 89 85 78 ff ff ff 	mov    %rax,-0x88(%rbp)
    return val;
   41038:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   4103f:	48 89 45 90          	mov    %rax,-0x70(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   41043:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   4104a:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   41051:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   41054:	48 85 c0             	test   %rax,%rax
   41057:	74 09                	je     41062 <exception+0x679>
   41059:	48 8d 05 f0 3a 00 00 	lea    0x3af0(%rip),%rax        # 44b50 <console_clear+0x7b>
   41060:	eb 07                	jmp    41069 <exception+0x680>
   41062:	48 8d 05 ed 3a 00 00 	lea    0x3aed(%rip),%rax        # 44b56 <console_clear+0x81>
        const char* operation = reg->reg_err & PFERR_WRITE
   41069:	48 89 45 88          	mov    %rax,-0x78(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   4106d:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   41074:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4107b:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   4107e:	48 85 c0             	test   %rax,%rax
   41081:	74 09                	je     4108c <exception+0x6a3>
   41083:	48 8d 05 d1 3a 00 00 	lea    0x3ad1(%rip),%rax        # 44b5b <console_clear+0x86>
   4108a:	eb 07                	jmp    41093 <exception+0x6aa>
   4108c:	48 8d 05 db 3a 00 00 	lea    0x3adb(%rip),%rax        # 44b6e <console_clear+0x99>
        const char* problem = reg->reg_err & PFERR_PRESENT
   41093:	48 89 45 80          	mov    %rax,-0x80(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   41097:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   4109e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   410a5:	83 e0 04             	and    $0x4,%eax
   410a8:	48 85 c0             	test   %rax,%rax
   410ab:	75 34                	jne    410e1 <exception+0x6f8>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   410ad:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   410b4:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   410bb:	48 8b 4d 80          	mov    -0x80(%rbp),%rcx
   410bf:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   410c3:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   410c7:	49 89 f0             	mov    %rsi,%r8
   410ca:	48 89 c6             	mov    %rax,%rsi
   410cd:	48 8d 05 ac 3a 00 00 	lea    0x3aac(%rip),%rax        # 44b80 <console_clear+0xab>
   410d4:	48 89 c7             	mov    %rax,%rdi
   410d7:	b8 00 00 00 00       	mov    $0x0,%eax
   410dc:	e8 f9 1b 00 00       	call   42cda <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   410e1:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   410e8:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   410ef:	48 8b 05 0a 0f 01 00 	mov    0x10f0a(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   410f6:	8b 00                	mov    (%rax),%eax
   410f8:	48 8b 75 88          	mov    -0x78(%rbp),%rsi
   410fc:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   41100:	52                   	push   %rdx
   41101:	ff 75 80             	push   -0x80(%rbp)
   41104:	49 89 f1             	mov    %rsi,%r9
   41107:	49 89 c8             	mov    %rcx,%r8
   4110a:	89 c1                	mov    %eax,%ecx
   4110c:	48 8d 05 9d 3a 00 00 	lea    0x3a9d(%rip),%rax        # 44bb0 <console_clear+0xdb>
   41113:	48 89 c2             	mov    %rax,%rdx
   41116:	be 00 0c 00 00       	mov    $0xc00,%esi
   4111b:	bf 80 07 00 00       	mov    $0x780,%edi
   41120:	b8 00 00 00 00       	mov    $0x0,%eax
   41125:	e8 35 38 00 00       	call   4495f <console_printf>
   4112a:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   4112e:	48 8b 05 cb 0e 01 00 	mov    0x10ecb(%rip),%rax        # 52000 <current>
   41135:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   4113c:	00 00 00 
        break;
   4113f:	eb 2a                	jmp    4116b <exception+0x782>
    }

case INT_SYS_EXIT: {
    proc *p = current;
   41141:	48 8b 05 b8 0e 01 00 	mov    0x10eb8(%rip),%rax        # 52000 <current>
   41148:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    exit(p->p_pid);
   4114c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41150:	8b 00                	mov    (%rax),%eax
   41152:	89 c7                	mov    %eax,%edi
   41154:	e8 72 f7 ff ff       	call   408cb <exit>
    // current->p_registers.reg_rax = -1; 

    break;
   41159:	eb 10                	jmp    4116b <exception+0x782>
}



    default:
        default_exception(current);
   4115b:	48 8b 05 9e 0e 01 00 	mov    0x10e9e(%rip),%rax        # 52000 <current>
   41162:	48 89 c7             	mov    %rax,%rdi
   41165:	e8 99 1c 00 00       	call   42e03 <default_exception>
        break;                  /* will not be reached */
   4116a:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   4116b:	48 8b 05 8e 0e 01 00 	mov    0x10e8e(%rip),%rax        # 52000 <current>
   41172:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41178:	83 f8 01             	cmp    $0x1,%eax
   4117b:	75 0f                	jne    4118c <exception+0x7a3>
        run(current);
   4117d:	48 8b 05 7c 0e 01 00 	mov    0x10e7c(%rip),%rax        # 52000 <current>
   41184:	48 89 c7             	mov    %rax,%rdi
   41187:	e8 87 00 00 00       	call   41213 <run>
    } else {
        schedule();
   4118c:	e8 03 00 00 00       	call   41194 <schedule>
    }
}
   41191:	90                   	nop
   41192:	c9                   	leave  
   41193:	c3                   	ret    

0000000000041194 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   41194:	f3 0f 1e fa          	endbr64 
   41198:	55                   	push   %rbp
   41199:	48 89 e5             	mov    %rsp,%rbp
   4119c:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   411a0:	48 8b 05 59 0e 01 00 	mov    0x10e59(%rip),%rax        # 52000 <current>
   411a7:	8b 00                	mov    (%rax),%eax
   411a9:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   411ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411af:	83 c0 01             	add    $0x1,%eax
   411b2:	99                   	cltd   
   411b3:	c1 ea 1c             	shr    $0x1c,%edx
   411b6:	01 d0                	add    %edx,%eax
   411b8:	83 e0 0f             	and    $0xf,%eax
   411bb:	29 d0                	sub    %edx,%eax
   411bd:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   411c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411c3:	48 63 d0             	movslq %eax,%rdx
   411c6:	48 89 d0             	mov    %rdx,%rax
   411c9:	48 c1 e0 03          	shl    $0x3,%rax
   411cd:	48 29 d0             	sub    %rdx,%rax
   411d0:	48 c1 e0 05          	shl    $0x5,%rax
   411d4:	48 89 c2             	mov    %rax,%rdx
   411d7:	48 8d 05 0a 0f 01 00 	lea    0x10f0a(%rip),%rax        # 520e8 <processes+0xc8>
   411de:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   411e1:	83 f8 01             	cmp    $0x1,%eax
   411e4:	75 26                	jne    4120c <schedule+0x78>
            run(&processes[pid]);
   411e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411e9:	48 63 d0             	movslq %eax,%rdx
   411ec:	48 89 d0             	mov    %rdx,%rax
   411ef:	48 c1 e0 03          	shl    $0x3,%rax
   411f3:	48 29 d0             	sub    %rdx,%rax
   411f6:	48 c1 e0 05          	shl    $0x5,%rax
   411fa:	48 8d 15 1f 0e 01 00 	lea    0x10e1f(%rip),%rdx        # 52020 <processes>
   41201:	48 01 d0             	add    %rdx,%rax
   41204:	48 89 c7             	mov    %rax,%rdi
   41207:	e8 07 00 00 00       	call   41213 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   4120c:	e8 67 19 00 00       	call   42b78 <check_keyboard>
        pid = (pid + 1) % NPROC;
   41211:	eb 99                	jmp    411ac <schedule+0x18>

0000000000041213 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   41213:	f3 0f 1e fa          	endbr64 
   41217:	55                   	push   %rbp
   41218:	48 89 e5             	mov    %rsp,%rbp
   4121b:	48 83 ec 10          	sub    $0x10,%rsp
   4121f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   41223:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41227:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   4122d:	83 f8 01             	cmp    $0x1,%eax
   41230:	74 1e                	je     41250 <run+0x3d>
   41232:	48 8d 05 53 3a 00 00 	lea    0x3a53(%rip),%rax        # 44c8c <console_clear+0x1b7>
   41239:	48 89 c2             	mov    %rax,%rdx
   4123c:	be 20 02 00 00       	mov    $0x220,%esi
   41241:	48 8d 05 f8 38 00 00 	lea    0x38f8(%rip),%rax        # 44b40 <console_clear+0x6b>
   41248:	48 89 c7             	mov    %rax,%rdi
   4124b:	e8 7a 1b 00 00       	call   42dca <assert_fail>
    current = p;
   41250:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41254:	48 89 05 a5 0d 01 00 	mov    %rax,0x10da5(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   4125b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4125f:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   41266:	48 89 c7             	mov    %rax,%rdi
   41269:	e8 6e 1d 00 00       	call   42fdc <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   4126e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41272:	48 83 c0 08          	add    $0x8,%rax
   41276:	48 89 c7             	mov    %rax,%rdi
   41279:	e8 45 ee ff ff       	call   400c3 <exception_return>

000000000004127e <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   4127e:	f3 0f 1e fa          	endbr64 
   41282:	55                   	push   %rbp
   41283:	48 89 e5             	mov    %rsp,%rbp
   41286:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4128a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41291:	00 
   41292:	e9 93 00 00 00       	jmp    4132a <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   41297:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4129b:	48 89 c7             	mov    %rax,%rdi
   4129e:	e8 0f 11 00 00       	call   423b2 <physical_memory_isreserved>
   412a3:	85 c0                	test   %eax,%eax
   412a5:	74 09                	je     412b0 <pageinfo_init+0x32>
            owner = PO_RESERVED;
   412a7:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   412ae:	eb 31                	jmp    412e1 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   412b0:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   412b7:	00 
   412b8:	76 0d                	jbe    412c7 <pageinfo_init+0x49>
   412ba:	48 8d 05 47 9d 01 00 	lea    0x19d47(%rip),%rax        # 5b008 <end>
   412c1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   412c5:	72 0a                	jb     412d1 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   412c7:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   412ce:	00 
   412cf:	75 09                	jne    412da <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   412d1:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   412d8:	eb 07                	jmp    412e1 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   412da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   412e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412e5:	48 c1 e8 0c          	shr    $0xc,%rax
   412e9:	89 c2                	mov    %eax,%edx
   412eb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   412ee:	89 c1                	mov    %eax,%ecx
   412f0:	48 63 c2             	movslq %edx,%rax
   412f3:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   412f7:	48 8d 05 42 1b 01 00 	lea    0x11b42(%rip),%rax        # 52e40 <pageinfo>
   412fe:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   41301:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41305:	0f 95 c2             	setne  %dl
   41308:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4130c:	48 c1 e8 0c          	shr    $0xc,%rax
   41310:	89 d1                	mov    %edx,%ecx
   41312:	48 98                	cltq   
   41314:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41318:	48 8d 05 22 1b 01 00 	lea    0x11b22(%rip),%rax        # 52e41 <pageinfo+0x1>
   4131f:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   41322:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41329:	00 
   4132a:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   41331:	00 
   41332:	0f 86 5f ff ff ff    	jbe    41297 <pageinfo_init+0x19>
    }
}
   41338:	90                   	nop
   41339:	90                   	nop
   4133a:	c9                   	leave  
   4133b:	c3                   	ret    

000000000004133c <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   4133c:	f3 0f 1e fa          	endbr64 
   41340:	55                   	push   %rbp
   41341:	48 89 e5             	mov    %rsp,%rbp
   41344:	48 83 ec 50          	sub    $0x50,%rsp
   41348:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   4134c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   41350:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41356:	48 89 c2             	mov    %rax,%rdx
   41359:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4135d:	48 39 c2             	cmp    %rax,%rdx
   41360:	74 1e                	je     41380 <check_page_table_mappings+0x44>
   41362:	48 8d 05 3f 39 00 00 	lea    0x393f(%rip),%rax        # 44ca8 <console_clear+0x1d3>
   41369:	48 89 c2             	mov    %rax,%rdx
   4136c:	be 4a 02 00 00       	mov    $0x24a,%esi
   41371:	48 8d 05 c8 37 00 00 	lea    0x37c8(%rip),%rax        # 44b40 <console_clear+0x6b>
   41378:	48 89 c7             	mov    %rax,%rdi
   4137b:	e8 4a 1a 00 00       	call   42dca <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41380:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   41387:	00 
   41388:	e9 b5 00 00 00       	jmp    41442 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   4138d:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   41391:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41395:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41399:	48 89 ce             	mov    %rcx,%rsi
   4139c:	48 89 c7             	mov    %rax,%rdi
   4139f:	e8 f4 21 00 00       	call   43598 <virtual_memory_lookup>
        if (vam.pa != va) {
   413a4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   413a8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413ac:	74 2c                	je     413da <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   413ae:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   413b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413b6:	49 89 d0             	mov    %rdx,%r8
   413b9:	48 89 c1             	mov    %rax,%rcx
   413bc:	48 8d 05 04 39 00 00 	lea    0x3904(%rip),%rax        # 44cc7 <console_clear+0x1f2>
   413c3:	48 89 c2             	mov    %rax,%rdx
   413c6:	be 00 c0 00 00       	mov    $0xc000,%esi
   413cb:	bf e0 06 00 00       	mov    $0x6e0,%edi
   413d0:	b8 00 00 00 00       	mov    $0x0,%eax
   413d5:	e8 85 35 00 00       	call   4495f <console_printf>
        }
        assert(vam.pa == va);
   413da:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   413de:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413e2:	74 1e                	je     41402 <check_page_table_mappings+0xc6>
   413e4:	48 8d 05 e6 38 00 00 	lea    0x38e6(%rip),%rax        # 44cd1 <console_clear+0x1fc>
   413eb:	48 89 c2             	mov    %rax,%rdx
   413ee:	be 53 02 00 00       	mov    $0x253,%esi
   413f3:	48 8d 05 46 37 00 00 	lea    0x3746(%rip),%rax        # 44b40 <console_clear+0x6b>
   413fa:	48 89 c7             	mov    %rax,%rdi
   413fd:	e8 c8 19 00 00       	call   42dca <assert_fail>
        if (va >= (uintptr_t) start_data) {
   41402:	48 8d 05 f7 4b 00 00 	lea    0x4bf7(%rip),%rax        # 46000 <disp_global>
   41409:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4140d:	72 2b                	jb     4143a <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   4140f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41412:	48 98                	cltq   
   41414:	83 e0 02             	and    $0x2,%eax
   41417:	48 85 c0             	test   %rax,%rax
   4141a:	75 1e                	jne    4143a <check_page_table_mappings+0xfe>
   4141c:	48 8d 05 bb 38 00 00 	lea    0x38bb(%rip),%rax        # 44cde <console_clear+0x209>
   41423:	48 89 c2             	mov    %rax,%rdx
   41426:	be 55 02 00 00       	mov    $0x255,%esi
   4142b:	48 8d 05 0e 37 00 00 	lea    0x370e(%rip),%rax        # 44b40 <console_clear+0x6b>
   41432:	48 89 c7             	mov    %rax,%rdi
   41435:	e8 90 19 00 00       	call   42dca <assert_fail>
         va += PAGESIZE) {
   4143a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41441:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41442:	48 8d 05 bf 9b 01 00 	lea    0x19bbf(%rip),%rax        # 5b008 <end>
   41449:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4144d:	0f 82 3a ff ff ff    	jb     4138d <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41453:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   4145a:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   4145b:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   4145f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41463:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41467:	48 89 ce             	mov    %rcx,%rsi
   4146a:	48 89 c7             	mov    %rax,%rdi
   4146d:	e8 26 21 00 00       	call   43598 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   41472:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41476:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4147a:	74 1e                	je     4149a <check_page_table_mappings+0x15e>
   4147c:	48 8d 05 6c 38 00 00 	lea    0x386c(%rip),%rax        # 44cef <console_clear+0x21a>
   41483:	48 89 c2             	mov    %rax,%rdx
   41486:	be 5c 02 00 00       	mov    $0x25c,%esi
   4148b:	48 8d 05 ae 36 00 00 	lea    0x36ae(%rip),%rax        # 44b40 <console_clear+0x6b>
   41492:	48 89 c7             	mov    %rax,%rdi
   41495:	e8 30 19 00 00       	call   42dca <assert_fail>
    assert(vam.perm & PTE_W);
   4149a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4149d:	48 98                	cltq   
   4149f:	83 e0 02             	and    $0x2,%eax
   414a2:	48 85 c0             	test   %rax,%rax
   414a5:	75 1e                	jne    414c5 <check_page_table_mappings+0x189>
   414a7:	48 8d 05 30 38 00 00 	lea    0x3830(%rip),%rax        # 44cde <console_clear+0x209>
   414ae:	48 89 c2             	mov    %rax,%rdx
   414b1:	be 5d 02 00 00       	mov    $0x25d,%esi
   414b6:	48 8d 05 83 36 00 00 	lea    0x3683(%rip),%rax        # 44b40 <console_clear+0x6b>
   414bd:	48 89 c7             	mov    %rax,%rdi
   414c0:	e8 05 19 00 00       	call   42dca <assert_fail>
}
   414c5:	90                   	nop
   414c6:	c9                   	leave  
   414c7:	c3                   	ret    

00000000000414c8 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   414c8:	f3 0f 1e fa          	endbr64 
   414cc:	55                   	push   %rbp
   414cd:	48 89 e5             	mov    %rsp,%rbp
   414d0:	48 83 ec 20          	sub    $0x20,%rsp
   414d4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   414d8:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   414db:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   414de:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   414e1:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   414e8:	48 8b 05 11 3b 01 00 	mov    0x13b11(%rip),%rax        # 55000 <kernel_pagetable>
   414ef:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   414f3:	75 71                	jne    41566 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   414f5:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   414fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41503:	eb 5b                	jmp    41560 <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   41505:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41508:	48 63 d0             	movslq %eax,%rdx
   4150b:	48 89 d0             	mov    %rdx,%rax
   4150e:	48 c1 e0 03          	shl    $0x3,%rax
   41512:	48 29 d0             	sub    %rdx,%rax
   41515:	48 c1 e0 05          	shl    $0x5,%rax
   41519:	48 89 c2             	mov    %rax,%rdx
   4151c:	48 8d 05 c5 0b 01 00 	lea    0x10bc5(%rip),%rax        # 520e8 <processes+0xc8>
   41523:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41526:	85 c0                	test   %eax,%eax
   41528:	74 32                	je     4155c <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   4152a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4152d:	48 63 d0             	movslq %eax,%rdx
   41530:	48 89 d0             	mov    %rdx,%rax
   41533:	48 c1 e0 03          	shl    $0x3,%rax
   41537:	48 29 d0             	sub    %rdx,%rax
   4153a:	48 c1 e0 05          	shl    $0x5,%rax
   4153e:	48 89 c2             	mov    %rax,%rdx
   41541:	48 8d 05 a8 0b 01 00 	lea    0x10ba8(%rip),%rax        # 520f0 <processes+0xd0>
   41548:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   4154c:	48 8b 05 ad 3a 01 00 	mov    0x13aad(%rip),%rax        # 55000 <kernel_pagetable>
   41553:	48 39 c2             	cmp    %rax,%rdx
   41556:	75 04                	jne    4155c <check_page_table_ownership+0x94>
                ++expected_refcount;
   41558:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4155c:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41560:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41564:	7e 9f                	jle    41505 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41566:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41569:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4156c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41570:	be 00 00 00 00       	mov    $0x0,%esi
   41575:	48 89 c7             	mov    %rax,%rdi
   41578:	e8 03 00 00 00       	call   41580 <check_page_table_ownership_level>
}
   4157d:	90                   	nop
   4157e:	c9                   	leave  
   4157f:	c3                   	ret    

0000000000041580 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   41580:	f3 0f 1e fa          	endbr64 
   41584:	55                   	push   %rbp
   41585:	48 89 e5             	mov    %rsp,%rbp
   41588:	48 83 ec 30          	sub    $0x30,%rsp
   4158c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41590:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41593:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41596:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41599:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4159d:	48 c1 e8 0c          	shr    $0xc,%rax
   415a1:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   415a6:	7e 1e                	jle    415c6 <check_page_table_ownership_level+0x46>
   415a8:	48 8d 05 51 37 00 00 	lea    0x3751(%rip),%rax        # 44d00 <console_clear+0x22b>
   415af:	48 89 c2             	mov    %rax,%rdx
   415b2:	be 7a 02 00 00       	mov    $0x27a,%esi
   415b7:	48 8d 05 82 35 00 00 	lea    0x3582(%rip),%rax        # 44b40 <console_clear+0x6b>
   415be:	48 89 c7             	mov    %rax,%rdi
   415c1:	e8 04 18 00 00       	call   42dca <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   415c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   415ca:	48 c1 e8 0c          	shr    $0xc,%rax
   415ce:	48 98                	cltq   
   415d0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   415d4:	48 8d 05 65 18 01 00 	lea    0x11865(%rip),%rax        # 52e40 <pageinfo>
   415db:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   415df:	0f be c0             	movsbl %al,%eax
   415e2:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   415e5:	74 1e                	je     41605 <check_page_table_ownership_level+0x85>
   415e7:	48 8d 05 2a 37 00 00 	lea    0x372a(%rip),%rax        # 44d18 <console_clear+0x243>
   415ee:	48 89 c2             	mov    %rax,%rdx
   415f1:	be 7b 02 00 00       	mov    $0x27b,%esi
   415f6:	48 8d 05 43 35 00 00 	lea    0x3543(%rip),%rax        # 44b40 <console_clear+0x6b>
   415fd:	48 89 c7             	mov    %rax,%rdi
   41600:	e8 c5 17 00 00       	call   42dca <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41605:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41609:	48 c1 e8 0c          	shr    $0xc,%rax
   4160d:	48 98                	cltq   
   4160f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41613:	48 8d 05 27 18 01 00 	lea    0x11827(%rip),%rax        # 52e41 <pageinfo+0x1>
   4161a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4161e:	0f be c0             	movsbl %al,%eax
   41621:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41624:	74 1e                	je     41644 <check_page_table_ownership_level+0xc4>
   41626:	48 8d 05 13 37 00 00 	lea    0x3713(%rip),%rax        # 44d40 <console_clear+0x26b>
   4162d:	48 89 c2             	mov    %rax,%rdx
   41630:	be 7c 02 00 00       	mov    $0x27c,%esi
   41635:	48 8d 05 04 35 00 00 	lea    0x3504(%rip),%rax        # 44b40 <console_clear+0x6b>
   4163c:	48 89 c7             	mov    %rax,%rdi
   4163f:	e8 86 17 00 00       	call   42dca <assert_fail>
    if (level < 3) {
   41644:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41648:	7f 5b                	jg     416a5 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4164a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41651:	eb 49                	jmp    4169c <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   41653:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41657:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4165a:	48 63 d2             	movslq %edx,%rdx
   4165d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41661:	48 85 c0             	test   %rax,%rax
   41664:	74 32                	je     41698 <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41666:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4166a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4166d:	48 63 d2             	movslq %edx,%rdx
   41670:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41674:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4167a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4167e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41681:	8d 70 01             	lea    0x1(%rax),%esi
   41684:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41687:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4168b:	b9 01 00 00 00       	mov    $0x1,%ecx
   41690:	48 89 c7             	mov    %rax,%rdi
   41693:	e8 e8 fe ff ff       	call   41580 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41698:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4169c:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   416a3:	7e ae                	jle    41653 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   416a5:	90                   	nop
   416a6:	c9                   	leave  
   416a7:	c3                   	ret    

00000000000416a8 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   416a8:	f3 0f 1e fa          	endbr64 
   416ac:	55                   	push   %rbp
   416ad:	48 89 e5             	mov    %rsp,%rbp
   416b0:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   416b4:	8b 05 2e 0a 01 00    	mov    0x10a2e(%rip),%eax        # 520e8 <processes+0xc8>
   416ba:	85 c0                	test   %eax,%eax
   416bc:	74 1e                	je     416dc <check_virtual_memory+0x34>
   416be:	48 8d 05 ab 36 00 00 	lea    0x36ab(%rip),%rax        # 44d70 <console_clear+0x29b>
   416c5:	48 89 c2             	mov    %rax,%rdx
   416c8:	be 8f 02 00 00       	mov    $0x28f,%esi
   416cd:	48 8d 05 6c 34 00 00 	lea    0x346c(%rip),%rax        # 44b40 <console_clear+0x6b>
   416d4:	48 89 c7             	mov    %rax,%rdi
   416d7:	e8 ee 16 00 00       	call   42dca <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   416dc:	48 8b 05 1d 39 01 00 	mov    0x1391d(%rip),%rax        # 55000 <kernel_pagetable>
   416e3:	48 89 c7             	mov    %rax,%rdi
   416e6:	e8 51 fc ff ff       	call   4133c <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   416eb:	48 8b 05 0e 39 01 00 	mov    0x1390e(%rip),%rax        # 55000 <kernel_pagetable>
   416f2:	be ff ff ff ff       	mov    $0xffffffff,%esi
   416f7:	48 89 c7             	mov    %rax,%rdi
   416fa:	e8 c9 fd ff ff       	call   414c8 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   416ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41706:	e9 b4 00 00 00       	jmp    417bf <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   4170b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4170e:	48 63 d0             	movslq %eax,%rdx
   41711:	48 89 d0             	mov    %rdx,%rax
   41714:	48 c1 e0 03          	shl    $0x3,%rax
   41718:	48 29 d0             	sub    %rdx,%rax
   4171b:	48 c1 e0 05          	shl    $0x5,%rax
   4171f:	48 89 c2             	mov    %rax,%rdx
   41722:	48 8d 05 bf 09 01 00 	lea    0x109bf(%rip),%rax        # 520e8 <processes+0xc8>
   41729:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4172c:	85 c0                	test   %eax,%eax
   4172e:	0f 84 87 00 00 00    	je     417bb <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41734:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41737:	48 63 d0             	movslq %eax,%rdx
   4173a:	48 89 d0             	mov    %rdx,%rax
   4173d:	48 c1 e0 03          	shl    $0x3,%rax
   41741:	48 29 d0             	sub    %rdx,%rax
   41744:	48 c1 e0 05          	shl    $0x5,%rax
   41748:	48 89 c2             	mov    %rax,%rdx
   4174b:	48 8d 05 9e 09 01 00 	lea    0x1099e(%rip),%rax        # 520f0 <processes+0xd0>
   41752:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   41756:	48 8b 05 a3 38 01 00 	mov    0x138a3(%rip),%rax        # 55000 <kernel_pagetable>
   4175d:	48 39 c2             	cmp    %rax,%rdx
   41760:	74 59                	je     417bb <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   41762:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41765:	48 63 d0             	movslq %eax,%rdx
   41768:	48 89 d0             	mov    %rdx,%rax
   4176b:	48 c1 e0 03          	shl    $0x3,%rax
   4176f:	48 29 d0             	sub    %rdx,%rax
   41772:	48 c1 e0 05          	shl    $0x5,%rax
   41776:	48 89 c2             	mov    %rax,%rdx
   41779:	48 8d 05 70 09 01 00 	lea    0x10970(%rip),%rax        # 520f0 <processes+0xd0>
   41780:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41784:	48 89 c7             	mov    %rax,%rdi
   41787:	e8 b0 fb ff ff       	call   4133c <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4178c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4178f:	48 63 d0             	movslq %eax,%rdx
   41792:	48 89 d0             	mov    %rdx,%rax
   41795:	48 c1 e0 03          	shl    $0x3,%rax
   41799:	48 29 d0             	sub    %rdx,%rax
   4179c:	48 c1 e0 05          	shl    $0x5,%rax
   417a0:	48 89 c2             	mov    %rax,%rdx
   417a3:	48 8d 05 46 09 01 00 	lea    0x10946(%rip),%rax        # 520f0 <processes+0xd0>
   417aa:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   417ae:	8b 55 fc             	mov    -0x4(%rbp),%edx
   417b1:	89 d6                	mov    %edx,%esi
   417b3:	48 89 c7             	mov    %rax,%rdi
   417b6:	e8 0d fd ff ff       	call   414c8 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   417bb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   417bf:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   417c3:	0f 8e 42 ff ff ff    	jle    4170b <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   417c9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   417d0:	e9 8b 00 00 00       	jmp    41860 <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   417d5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   417d8:	48 98                	cltq   
   417da:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   417de:	48 8d 05 5c 16 01 00 	lea    0x1165c(%rip),%rax        # 52e41 <pageinfo+0x1>
   417e5:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   417e9:	84 c0                	test   %al,%al
   417eb:	7e 6f                	jle    4185c <check_virtual_memory+0x1b4>
   417ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
   417f0:	48 98                	cltq   
   417f2:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   417f6:	48 8d 05 43 16 01 00 	lea    0x11643(%rip),%rax        # 52e40 <pageinfo>
   417fd:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41801:	84 c0                	test   %al,%al
   41803:	78 57                	js     4185c <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41805:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41808:	48 98                	cltq   
   4180a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4180e:	48 8d 05 2b 16 01 00 	lea    0x1162b(%rip),%rax        # 52e40 <pageinfo>
   41815:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41819:	0f be c0             	movsbl %al,%eax
   4181c:	48 63 d0             	movslq %eax,%rdx
   4181f:	48 89 d0             	mov    %rdx,%rax
   41822:	48 c1 e0 03          	shl    $0x3,%rax
   41826:	48 29 d0             	sub    %rdx,%rax
   41829:	48 c1 e0 05          	shl    $0x5,%rax
   4182d:	48 89 c2             	mov    %rax,%rdx
   41830:	48 8d 05 b1 08 01 00 	lea    0x108b1(%rip),%rax        # 520e8 <processes+0xc8>
   41837:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4183a:	85 c0                	test   %eax,%eax
   4183c:	75 1e                	jne    4185c <check_virtual_memory+0x1b4>
   4183e:	48 8d 05 4b 35 00 00 	lea    0x354b(%rip),%rax        # 44d90 <console_clear+0x2bb>
   41845:	48 89 c2             	mov    %rax,%rdx
   41848:	be a6 02 00 00       	mov    $0x2a6,%esi
   4184d:	48 8d 05 ec 32 00 00 	lea    0x32ec(%rip),%rax        # 44b40 <console_clear+0x6b>
   41854:	48 89 c7             	mov    %rax,%rdi
   41857:	e8 6e 15 00 00       	call   42dca <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4185c:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41860:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41867:	0f 8e 68 ff ff ff    	jle    417d5 <check_virtual_memory+0x12d>
        }
    }
}
   4186d:	90                   	nop
   4186e:	90                   	nop
   4186f:	c9                   	leave  
   41870:	c3                   	ret    

0000000000041871 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41871:	f3 0f 1e fa          	endbr64 
   41875:	55                   	push   %rbp
   41876:	48 89 e5             	mov    %rsp,%rbp
   41879:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4187d:	48 8d 05 62 35 00 00 	lea    0x3562(%rip),%rax        # 44de6 <memstate_colors+0x26>
   41884:	48 89 c2             	mov    %rax,%rdx
   41887:	be 00 0f 00 00       	mov    $0xf00,%esi
   4188c:	bf 20 00 00 00       	mov    $0x20,%edi
   41891:	b8 00 00 00 00       	mov    $0x0,%eax
   41896:	e8 c4 30 00 00       	call   4495f <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4189b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   418a2:	e9 1b 01 00 00       	jmp    419c2 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   418a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418aa:	83 e0 3f             	and    $0x3f,%eax
   418ad:	85 c0                	test   %eax,%eax
   418af:	75 40                	jne    418f1 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   418b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418b4:	c1 e0 0c             	shl    $0xc,%eax
   418b7:	89 c2                	mov    %eax,%edx
   418b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418bc:	8d 48 3f             	lea    0x3f(%rax),%ecx
   418bf:	85 c0                	test   %eax,%eax
   418c1:	0f 48 c1             	cmovs  %ecx,%eax
   418c4:	c1 f8 06             	sar    $0x6,%eax
   418c7:	8d 48 01             	lea    0x1(%rax),%ecx
   418ca:	89 c8                	mov    %ecx,%eax
   418cc:	c1 e0 02             	shl    $0x2,%eax
   418cf:	01 c8                	add    %ecx,%eax
   418d1:	c1 e0 04             	shl    $0x4,%eax
   418d4:	83 c0 03             	add    $0x3,%eax
   418d7:	89 d1                	mov    %edx,%ecx
   418d9:	48 8d 15 16 35 00 00 	lea    0x3516(%rip),%rdx        # 44df6 <memstate_colors+0x36>
   418e0:	be 00 0f 00 00       	mov    $0xf00,%esi
   418e5:	89 c7                	mov    %eax,%edi
   418e7:	b8 00 00 00 00       	mov    $0x0,%eax
   418ec:	e8 6e 30 00 00       	call   4495f <console_printf>
        }

        int owner = pageinfo[pn].owner;
   418f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418f4:	48 98                	cltq   
   418f6:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   418fa:	48 8d 05 3f 15 01 00 	lea    0x1153f(%rip),%rax        # 52e40 <pageinfo>
   41901:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41905:	0f be c0             	movsbl %al,%eax
   41908:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   4190b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4190e:	48 98                	cltq   
   41910:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41914:	48 8d 05 26 15 01 00 	lea    0x11526(%rip),%rax        # 52e41 <pageinfo+0x1>
   4191b:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4191f:	84 c0                	test   %al,%al
   41921:	75 07                	jne    4192a <memshow_physical+0xb9>
            owner = PO_FREE;
   41923:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4192a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4192d:	83 c0 02             	add    $0x2,%eax
   41930:	48 98                	cltq   
   41932:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41936:	48 8d 05 83 34 00 00 	lea    0x3483(%rip),%rax        # 44dc0 <memstate_colors>
   4193d:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41941:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41945:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41948:	48 98                	cltq   
   4194a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4194e:	48 8d 05 ec 14 01 00 	lea    0x114ec(%rip),%rax        # 52e41 <pageinfo+0x1>
   41955:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41959:	3c 01                	cmp    $0x1,%al
   4195b:	7e 1c                	jle    41979 <memshow_physical+0x108>
   4195d:	48 8d 05 9c 66 07 00 	lea    0x7669c(%rip),%rax        # b8000 <console>
   41964:	48 c1 e8 0c          	shr    $0xc,%rax
   41968:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4196b:	74 0c                	je     41979 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4196d:	b8 53 00 00 00       	mov    $0x53,%eax
   41972:	80 cc 0f             	or     $0xf,%ah
   41975:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41979:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4197c:	8d 50 3f             	lea    0x3f(%rax),%edx
   4197f:	85 c0                	test   %eax,%eax
   41981:	0f 48 c2             	cmovs  %edx,%eax
   41984:	c1 f8 06             	sar    $0x6,%eax
   41987:	8d 50 01             	lea    0x1(%rax),%edx
   4198a:	89 d0                	mov    %edx,%eax
   4198c:	c1 e0 02             	shl    $0x2,%eax
   4198f:	01 d0                	add    %edx,%eax
   41991:	c1 e0 04             	shl    $0x4,%eax
   41994:	89 c1                	mov    %eax,%ecx
   41996:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41999:	99                   	cltd   
   4199a:	c1 ea 1a             	shr    $0x1a,%edx
   4199d:	01 d0                	add    %edx,%eax
   4199f:	83 e0 3f             	and    $0x3f,%eax
   419a2:	29 d0                	sub    %edx,%eax
   419a4:	83 c0 0c             	add    $0xc,%eax
   419a7:	01 c8                	add    %ecx,%eax
   419a9:	48 98                	cltq   
   419ab:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   419af:	48 8d 15 4a 66 07 00 	lea    0x7664a(%rip),%rdx        # b8000 <console>
   419b6:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419ba:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   419be:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   419c2:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   419c9:	0f 8e d8 fe ff ff    	jle    418a7 <memshow_physical+0x36>
    }
}
   419cf:	90                   	nop
   419d0:	90                   	nop
   419d1:	c9                   	leave  
   419d2:	c3                   	ret    

00000000000419d3 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   419d3:	f3 0f 1e fa          	endbr64 
   419d7:	55                   	push   %rbp
   419d8:	48 89 e5             	mov    %rsp,%rbp
   419db:	48 83 ec 40          	sub    $0x40,%rsp
   419df:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   419e3:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   419e7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   419eb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   419f1:	48 89 c2             	mov    %rax,%rdx
   419f4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   419f8:	48 39 c2             	cmp    %rax,%rdx
   419fb:	74 1e                	je     41a1b <memshow_virtual+0x48>
   419fd:	48 8d 05 fc 33 00 00 	lea    0x33fc(%rip),%rax        # 44e00 <memstate_colors+0x40>
   41a04:	48 89 c2             	mov    %rax,%rdx
   41a07:	be d7 02 00 00       	mov    $0x2d7,%esi
   41a0c:	48 8d 05 2d 31 00 00 	lea    0x312d(%rip),%rax        # 44b40 <console_clear+0x6b>
   41a13:	48 89 c7             	mov    %rax,%rdi
   41a16:	e8 af 13 00 00       	call   42dca <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41a1b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41a1f:	48 89 c1             	mov    %rax,%rcx
   41a22:	48 8d 05 04 34 00 00 	lea    0x3404(%rip),%rax        # 44e2d <memstate_colors+0x6d>
   41a29:	48 89 c2             	mov    %rax,%rdx
   41a2c:	be 00 0f 00 00       	mov    $0xf00,%esi
   41a31:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41a36:	b8 00 00 00 00       	mov    $0x0,%eax
   41a3b:	e8 1f 2f 00 00       	call   4495f <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41a40:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41a47:	00 
   41a48:	e9 b4 01 00 00       	jmp    41c01 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41a4d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41a51:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41a55:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41a59:	48 89 ce             	mov    %rcx,%rsi
   41a5c:	48 89 c7             	mov    %rax,%rdi
   41a5f:	e8 34 1b 00 00       	call   43598 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41a64:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41a67:	85 c0                	test   %eax,%eax
   41a69:	79 0b                	jns    41a76 <memshow_virtual+0xa3>
            color = ' ';
   41a6b:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41a71:	e9 ff 00 00 00       	jmp    41b75 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41a76:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41a7a:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41a80:	76 1e                	jbe    41aa0 <memshow_virtual+0xcd>
   41a82:	48 8d 05 c1 33 00 00 	lea    0x33c1(%rip),%rax        # 44e4a <memstate_colors+0x8a>
   41a89:	48 89 c2             	mov    %rax,%rdx
   41a8c:	be e0 02 00 00       	mov    $0x2e0,%esi
   41a91:	48 8d 05 a8 30 00 00 	lea    0x30a8(%rip),%rax        # 44b40 <console_clear+0x6b>
   41a98:	48 89 c7             	mov    %rax,%rdi
   41a9b:	e8 2a 13 00 00       	call   42dca <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41aa0:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41aa3:	48 98                	cltq   
   41aa5:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41aa9:	48 8d 05 90 13 01 00 	lea    0x11390(%rip),%rax        # 52e40 <pageinfo>
   41ab0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41ab4:	0f be c0             	movsbl %al,%eax
   41ab7:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41aba:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41abd:	48 98                	cltq   
   41abf:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41ac3:	48 8d 05 77 13 01 00 	lea    0x11377(%rip),%rax        # 52e41 <pageinfo+0x1>
   41aca:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41ace:	84 c0                	test   %al,%al
   41ad0:	75 07                	jne    41ad9 <memshow_virtual+0x106>
                owner = PO_FREE;
   41ad2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41ad9:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41adc:	83 c0 02             	add    $0x2,%eax
   41adf:	48 98                	cltq   
   41ae1:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41ae5:	48 8d 05 d4 32 00 00 	lea    0x32d4(%rip),%rax        # 44dc0 <memstate_colors>
   41aec:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41af0:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41af4:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41af7:	48 98                	cltq   
   41af9:	83 e0 04             	and    $0x4,%eax
   41afc:	48 85 c0             	test   %rax,%rax
   41aff:	74 27                	je     41b28 <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41b01:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41b05:	c1 e0 04             	shl    $0x4,%eax
   41b08:	66 25 00 f0          	and    $0xf000,%ax
   41b0c:	89 c2                	mov    %eax,%edx
   41b0e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41b12:	c1 f8 04             	sar    $0x4,%eax
   41b15:	66 25 00 0f          	and    $0xf00,%ax
   41b19:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41b1b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41b1f:	0f b6 c0             	movzbl %al,%eax
   41b22:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41b24:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41b28:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41b2b:	48 98                	cltq   
   41b2d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41b31:	48 8d 05 09 13 01 00 	lea    0x11309(%rip),%rax        # 52e41 <pageinfo+0x1>
   41b38:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41b3c:	3c 01                	cmp    $0x1,%al
   41b3e:	7e 35                	jle    41b75 <memshow_virtual+0x1a2>
   41b40:	48 8d 05 b9 64 07 00 	lea    0x764b9(%rip),%rax        # b8000 <console>
   41b47:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41b4b:	74 28                	je     41b75 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41b4d:	b8 53 00 00 00       	mov    $0x53,%eax
   41b52:	89 c2                	mov    %eax,%edx
   41b54:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41b58:	66 25 00 f0          	and    $0xf000,%ax
   41b5c:	09 d0                	or     %edx,%eax
   41b5e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41b62:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41b65:	48 98                	cltq   
   41b67:	83 e0 04             	and    $0x4,%eax
   41b6a:	48 85 c0             	test   %rax,%rax
   41b6d:	75 06                	jne    41b75 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   41b6f:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41b75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b79:	48 c1 e8 0c          	shr    $0xc,%rax
   41b7d:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41b80:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41b83:	83 e0 3f             	and    $0x3f,%eax
   41b86:	85 c0                	test   %eax,%eax
   41b88:	75 39                	jne    41bc3 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41b8a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41b8d:	c1 e8 06             	shr    $0x6,%eax
   41b90:	89 c2                	mov    %eax,%edx
   41b92:	89 d0                	mov    %edx,%eax
   41b94:	c1 e0 02             	shl    $0x2,%eax
   41b97:	01 d0                	add    %edx,%eax
   41b99:	c1 e0 04             	shl    $0x4,%eax
   41b9c:	05 73 03 00 00       	add    $0x373,%eax
   41ba1:	89 c7                	mov    %eax,%edi
   41ba3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ba7:	48 89 c1             	mov    %rax,%rcx
   41baa:	48 8d 05 45 32 00 00 	lea    0x3245(%rip),%rax        # 44df6 <memstate_colors+0x36>
   41bb1:	48 89 c2             	mov    %rax,%rdx
   41bb4:	be 00 0f 00 00       	mov    $0xf00,%esi
   41bb9:	b8 00 00 00 00       	mov    $0x0,%eax
   41bbe:	e8 9c 2d 00 00       	call   4495f <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41bc3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41bc6:	c1 e8 06             	shr    $0x6,%eax
   41bc9:	89 c2                	mov    %eax,%edx
   41bcb:	89 d0                	mov    %edx,%eax
   41bcd:	c1 e0 02             	shl    $0x2,%eax
   41bd0:	01 d0                	add    %edx,%eax
   41bd2:	c1 e0 04             	shl    $0x4,%eax
   41bd5:	89 c2                	mov    %eax,%edx
   41bd7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41bda:	83 e0 3f             	and    $0x3f,%eax
   41bdd:	01 d0                	add    %edx,%eax
   41bdf:	05 7c 03 00 00       	add    $0x37c,%eax
   41be4:	89 c0                	mov    %eax,%eax
   41be6:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41bea:	48 8d 15 0f 64 07 00 	lea    0x7640f(%rip),%rdx        # b8000 <console>
   41bf1:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41bf5:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41bf9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41c00:	00 
   41c01:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41c08:	00 
   41c09:	0f 86 3e fe ff ff    	jbe    41a4d <memshow_virtual+0x7a>
    }
}
   41c0f:	90                   	nop
   41c10:	90                   	nop
   41c11:	c9                   	leave  
   41c12:	c3                   	ret    

0000000000041c13 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41c13:	f3 0f 1e fa          	endbr64 
   41c17:	55                   	push   %rbp
   41c18:	48 89 e5             	mov    %rsp,%rbp
   41c1b:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41c1f:	8b 05 1b 16 01 00    	mov    0x1161b(%rip),%eax        # 53240 <last_ticks.1>
   41c25:	85 c0                	test   %eax,%eax
   41c27:	74 13                	je     41c3c <memshow_virtual_animate+0x29>
   41c29:	8b 05 f1 11 01 00    	mov    0x111f1(%rip),%eax        # 52e20 <ticks>
   41c2f:	8b 15 0b 16 01 00    	mov    0x1160b(%rip),%edx        # 53240 <last_ticks.1>
   41c35:	29 d0                	sub    %edx,%eax
   41c37:	83 f8 31             	cmp    $0x31,%eax
   41c3a:	76 2c                	jbe    41c68 <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   41c3c:	8b 05 de 11 01 00    	mov    0x111de(%rip),%eax        # 52e20 <ticks>
   41c42:	89 05 f8 15 01 00    	mov    %eax,0x115f8(%rip)        # 53240 <last_ticks.1>
        ++showing;
   41c48:	8b 05 b6 43 00 00    	mov    0x43b6(%rip),%eax        # 46004 <showing.0>
   41c4e:	83 c0 01             	add    $0x1,%eax
   41c51:	89 05 ad 43 00 00    	mov    %eax,0x43ad(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41c57:	eb 0f                	jmp    41c68 <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41c59:	8b 05 a5 43 00 00    	mov    0x43a5(%rip),%eax        # 46004 <showing.0>
   41c5f:	83 c0 01             	add    $0x1,%eax
   41c62:	89 05 9c 43 00 00    	mov    %eax,0x439c(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41c68:	8b 05 96 43 00 00    	mov    0x4396(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41c6e:	83 f8 20             	cmp    $0x20,%eax
   41c71:	7f 6b                	jg     41cde <memshow_virtual_animate+0xcb>
   41c73:	8b 05 8b 43 00 00    	mov    0x438b(%rip),%eax        # 46004 <showing.0>
   41c79:	99                   	cltd   
   41c7a:	c1 ea 1c             	shr    $0x1c,%edx
   41c7d:	01 d0                	add    %edx,%eax
   41c7f:	83 e0 0f             	and    $0xf,%eax
   41c82:	29 d0                	sub    %edx,%eax
   41c84:	48 63 d0             	movslq %eax,%rdx
   41c87:	48 89 d0             	mov    %rdx,%rax
   41c8a:	48 c1 e0 03          	shl    $0x3,%rax
   41c8e:	48 29 d0             	sub    %rdx,%rax
   41c91:	48 c1 e0 05          	shl    $0x5,%rax
   41c95:	48 89 c2             	mov    %rax,%rdx
   41c98:	48 8d 05 49 04 01 00 	lea    0x10449(%rip),%rax        # 520e8 <processes+0xc8>
   41c9f:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41ca2:	85 c0                	test   %eax,%eax
   41ca4:	74 b3                	je     41c59 <memshow_virtual_animate+0x46>
   41ca6:	8b 05 58 43 00 00    	mov    0x4358(%rip),%eax        # 46004 <showing.0>
   41cac:	99                   	cltd   
   41cad:	c1 ea 1c             	shr    $0x1c,%edx
   41cb0:	01 d0                	add    %edx,%eax
   41cb2:	83 e0 0f             	and    $0xf,%eax
   41cb5:	29 d0                	sub    %edx,%eax
   41cb7:	48 63 d0             	movslq %eax,%rdx
   41cba:	48 89 d0             	mov    %rdx,%rax
   41cbd:	48 c1 e0 03          	shl    $0x3,%rax
   41cc1:	48 29 d0             	sub    %rdx,%rax
   41cc4:	48 c1 e0 05          	shl    $0x5,%rax
   41cc8:	48 89 c2             	mov    %rax,%rdx
   41ccb:	48 8d 05 26 04 01 00 	lea    0x10426(%rip),%rax        # 520f8 <processes+0xd8>
   41cd2:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41cd6:	84 c0                	test   %al,%al
   41cd8:	0f 84 7b ff ff ff    	je     41c59 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   41cde:	8b 05 20 43 00 00    	mov    0x4320(%rip),%eax        # 46004 <showing.0>
   41ce4:	99                   	cltd   
   41ce5:	c1 ea 1c             	shr    $0x1c,%edx
   41ce8:	01 d0                	add    %edx,%eax
   41cea:	83 e0 0f             	and    $0xf,%eax
   41ced:	29 d0                	sub    %edx,%eax
   41cef:	89 05 0f 43 00 00    	mov    %eax,0x430f(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41cf5:	8b 05 09 43 00 00    	mov    0x4309(%rip),%eax        # 46004 <showing.0>
   41cfb:	48 63 d0             	movslq %eax,%rdx
   41cfe:	48 89 d0             	mov    %rdx,%rax
   41d01:	48 c1 e0 03          	shl    $0x3,%rax
   41d05:	48 29 d0             	sub    %rdx,%rax
   41d08:	48 c1 e0 05          	shl    $0x5,%rax
   41d0c:	48 89 c2             	mov    %rax,%rdx
   41d0f:	48 8d 05 d2 03 01 00 	lea    0x103d2(%rip),%rax        # 520e8 <processes+0xc8>
   41d16:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41d19:	85 c0                	test   %eax,%eax
   41d1b:	74 59                	je     41d76 <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41d1d:	8b 15 e1 42 00 00    	mov    0x42e1(%rip),%edx        # 46004 <showing.0>
   41d23:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41d27:	89 d1                	mov    %edx,%ecx
   41d29:	48 8d 15 34 31 00 00 	lea    0x3134(%rip),%rdx        # 44e64 <memstate_colors+0xa4>
   41d30:	be 04 00 00 00       	mov    $0x4,%esi
   41d35:	48 89 c7             	mov    %rax,%rdi
   41d38:	b8 00 00 00 00       	mov    $0x0,%eax
   41d3d:	e8 38 2d 00 00       	call   44a7a <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41d42:	8b 05 bc 42 00 00    	mov    0x42bc(%rip),%eax        # 46004 <showing.0>
   41d48:	48 63 d0             	movslq %eax,%rdx
   41d4b:	48 89 d0             	mov    %rdx,%rax
   41d4e:	48 c1 e0 03          	shl    $0x3,%rax
   41d52:	48 29 d0             	sub    %rdx,%rax
   41d55:	48 c1 e0 05          	shl    $0x5,%rax
   41d59:	48 89 c2             	mov    %rax,%rdx
   41d5c:	48 8d 05 8d 03 01 00 	lea    0x1038d(%rip),%rax        # 520f0 <processes+0xd0>
   41d63:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41d67:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41d6b:	48 89 d6             	mov    %rdx,%rsi
   41d6e:	48 89 c7             	mov    %rax,%rdi
   41d71:	e8 5d fc ff ff       	call   419d3 <memshow_virtual>
    }
}
   41d76:	90                   	nop
   41d77:	c9                   	leave  
   41d78:	c3                   	ret    

0000000000041d79 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41d79:	f3 0f 1e fa          	endbr64 
   41d7d:	55                   	push   %rbp
   41d7e:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41d81:	e8 5f 01 00 00       	call   41ee5 <segments_init>
    interrupt_init();
   41d86:	e8 44 04 00 00       	call   421cf <interrupt_init>
    virtual_memory_init();
   41d8b:	e8 11 11 00 00       	call   42ea1 <virtual_memory_init>
}
   41d90:	90                   	nop
   41d91:	5d                   	pop    %rbp
   41d92:	c3                   	ret    

0000000000041d93 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41d93:	f3 0f 1e fa          	endbr64 
   41d97:	55                   	push   %rbp
   41d98:	48 89 e5             	mov    %rsp,%rbp
   41d9b:	48 83 ec 18          	sub    $0x18,%rsp
   41d9f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41da3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41da7:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41daa:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41dad:	48 98                	cltq   
   41daf:	48 c1 e0 2d          	shl    $0x2d,%rax
   41db3:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41db7:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41dbe:	90 00 00 
   41dc1:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41dc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dc8:	48 89 10             	mov    %rdx,(%rax)
}
   41dcb:	90                   	nop
   41dcc:	c9                   	leave  
   41dcd:	c3                   	ret    

0000000000041dce <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41dce:	f3 0f 1e fa          	endbr64 
   41dd2:	55                   	push   %rbp
   41dd3:	48 89 e5             	mov    %rsp,%rbp
   41dd6:	48 83 ec 28          	sub    $0x28,%rsp
   41dda:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41dde:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41de2:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41de5:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41de9:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41ded:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41df1:	48 c1 e0 10          	shl    $0x10,%rax
   41df5:	48 89 c2             	mov    %rax,%rdx
   41df8:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41dff:	00 00 00 
   41e02:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41e05:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41e09:	48 c1 e0 20          	shl    $0x20,%rax
   41e0d:	48 89 c1             	mov    %rax,%rcx
   41e10:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41e17:	00 00 ff 
   41e1a:	48 21 c8             	and    %rcx,%rax
   41e1d:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41e20:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41e24:	48 83 e8 01          	sub    $0x1,%rax
   41e28:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41e2b:	48 09 d0             	or     %rdx,%rax
        | type
   41e2e:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41e32:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41e35:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41e38:	48 98                	cltq   
   41e3a:	48 c1 e0 2d          	shl    $0x2d,%rax
   41e3e:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41e41:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41e48:	80 00 00 
   41e4b:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41e4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e52:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41e55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e59:	48 83 c0 08          	add    $0x8,%rax
   41e5d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41e61:	48 c1 ea 20          	shr    $0x20,%rdx
   41e65:	48 89 10             	mov    %rdx,(%rax)
}
   41e68:	90                   	nop
   41e69:	c9                   	leave  
   41e6a:	c3                   	ret    

0000000000041e6b <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41e6b:	f3 0f 1e fa          	endbr64 
   41e6f:	55                   	push   %rbp
   41e70:	48 89 e5             	mov    %rsp,%rbp
   41e73:	48 83 ec 20          	sub    $0x20,%rsp
   41e77:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e7b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41e7f:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41e82:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41e86:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41e8a:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41e8d:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41e91:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41e94:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41e97:	48 98                	cltq   
   41e99:	48 c1 e0 2d          	shl    $0x2d,%rax
   41e9d:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41ea0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41ea4:	48 c1 e0 20          	shl    $0x20,%rax
   41ea8:	48 89 c1             	mov    %rax,%rcx
   41eab:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41eb2:	00 ff ff 
   41eb5:	48 21 c8             	and    %rcx,%rax
   41eb8:	48 09 c2             	or     %rax,%rdx
   41ebb:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41ec2:	80 00 00 
   41ec5:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41ec8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ecc:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41ecf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41ed3:	48 c1 e8 20          	shr    $0x20,%rax
   41ed7:	48 89 c2             	mov    %rax,%rdx
   41eda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ede:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41ee2:	90                   	nop
   41ee3:	c9                   	leave  
   41ee4:	c3                   	ret    

0000000000041ee5 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41ee5:	f3 0f 1e fa          	endbr64 
   41ee9:	55                   	push   %rbp
   41eea:	48 89 e5             	mov    %rsp,%rbp
   41eed:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41ef1:	48 c7 05 64 13 01 00 	movq   $0x0,0x11364(%rip)        # 53260 <segments>
   41ef8:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41efc:	ba 00 00 00 00       	mov    $0x0,%edx
   41f01:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41f08:	08 20 00 
   41f0b:	48 89 c6             	mov    %rax,%rsi
   41f0e:	48 8d 05 53 13 01 00 	lea    0x11353(%rip),%rax        # 53268 <segments+0x8>
   41f15:	48 89 c7             	mov    %rax,%rdi
   41f18:	e8 76 fe ff ff       	call   41d93 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41f1d:	ba 03 00 00 00       	mov    $0x3,%edx
   41f22:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41f29:	08 20 00 
   41f2c:	48 89 c6             	mov    %rax,%rsi
   41f2f:	48 8d 05 3a 13 01 00 	lea    0x1133a(%rip),%rax        # 53270 <segments+0x10>
   41f36:	48 89 c7             	mov    %rax,%rdi
   41f39:	e8 55 fe ff ff       	call   41d93 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41f3e:	ba 00 00 00 00       	mov    $0x0,%edx
   41f43:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41f4a:	02 00 00 
   41f4d:	48 89 c6             	mov    %rax,%rsi
   41f50:	48 8d 05 21 13 01 00 	lea    0x11321(%rip),%rax        # 53278 <segments+0x18>
   41f57:	48 89 c7             	mov    %rax,%rdi
   41f5a:	e8 34 fe ff ff       	call   41d93 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41f5f:	ba 03 00 00 00       	mov    $0x3,%edx
   41f64:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41f6b:	02 00 00 
   41f6e:	48 89 c6             	mov    %rax,%rsi
   41f71:	48 8d 05 08 13 01 00 	lea    0x11308(%rip),%rax        # 53280 <segments+0x20>
   41f78:	48 89 c7             	mov    %rax,%rdi
   41f7b:	e8 13 fe ff ff       	call   41d93 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41f80:	48 8d 05 19 23 01 00 	lea    0x12319(%rip),%rax        # 542a0 <kernel_task_descriptor>
   41f87:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41f8d:	48 89 c1             	mov    %rax,%rcx
   41f90:	ba 00 00 00 00       	mov    $0x0,%edx
   41f95:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41f9c:	09 00 00 
   41f9f:	48 89 c6             	mov    %rax,%rsi
   41fa2:	48 8d 05 df 12 01 00 	lea    0x112df(%rip),%rax        # 53288 <segments+0x28>
   41fa9:	48 89 c7             	mov    %rax,%rdi
   41fac:	e8 1d fe ff ff       	call   41dce <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41fb1:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41fb7:	48 8d 05 a2 12 01 00 	lea    0x112a2(%rip),%rax        # 53260 <segments>
   41fbe:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41fc2:	ba 60 00 00 00       	mov    $0x60,%edx
   41fc7:	be 00 00 00 00       	mov    $0x0,%esi
   41fcc:	48 8d 05 cd 22 01 00 	lea    0x122cd(%rip),%rax        # 542a0 <kernel_task_descriptor>
   41fd3:	48 89 c7             	mov    %rax,%rdi
   41fd6:	e8 45 1b 00 00       	call   43b20 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41fdb:	48 c7 05 be 22 01 00 	movq   $0x80000,0x122be(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41fe2:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41fe6:	ba 00 10 00 00       	mov    $0x1000,%edx
   41feb:	be 00 00 00 00       	mov    $0x0,%esi
   41ff0:	48 8d 05 a9 12 01 00 	lea    0x112a9(%rip),%rax        # 532a0 <interrupt_descriptors>
   41ff7:	48 89 c7             	mov    %rax,%rdi
   41ffa:	e8 21 1b 00 00       	call   43b20 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41fff:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   42006:	eb 3c                	jmp    42044 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   42008:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   4200f:	48 89 c2             	mov    %rax,%rdx
   42012:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42015:	48 c1 e0 04          	shl    $0x4,%rax
   42019:	48 89 c1             	mov    %rax,%rcx
   4201c:	48 8d 05 7d 12 01 00 	lea    0x1127d(%rip),%rax        # 532a0 <interrupt_descriptors>
   42023:	48 01 c8             	add    %rcx,%rax
   42026:	48 89 d1             	mov    %rdx,%rcx
   42029:	ba 00 00 00 00       	mov    $0x0,%edx
   4202e:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   42035:	0e 00 00 
   42038:	48 89 c7             	mov    %rax,%rdi
   4203b:	e8 2b fe ff ff       	call   41e6b <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   42040:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42044:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   4204b:	76 bb                	jbe    42008 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   4204d:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   42054:	48 89 c1             	mov    %rax,%rcx
   42057:	ba 00 00 00 00       	mov    $0x0,%edx
   4205c:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   42063:	0e 00 00 
   42066:	48 89 c6             	mov    %rax,%rsi
   42069:	48 8d 05 30 14 01 00 	lea    0x11430(%rip),%rax        # 534a0 <interrupt_descriptors+0x200>
   42070:	48 89 c7             	mov    %rax,%rdi
   42073:	e8 f3 fd ff ff       	call   41e6b <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   42078:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   4207f:	48 89 c1             	mov    %rax,%rcx
   42082:	ba 00 00 00 00       	mov    $0x0,%edx
   42087:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4208e:	0e 00 00 
   42091:	48 89 c6             	mov    %rax,%rsi
   42094:	48 8d 05 d5 12 01 00 	lea    0x112d5(%rip),%rax        # 53370 <interrupt_descriptors+0xd0>
   4209b:	48 89 c7             	mov    %rax,%rdi
   4209e:	e8 c8 fd ff ff       	call   41e6b <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   420a3:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   420aa:	48 89 c1             	mov    %rax,%rcx
   420ad:	ba 00 00 00 00       	mov    $0x0,%edx
   420b2:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   420b9:	0e 00 00 
   420bc:	48 89 c6             	mov    %rax,%rsi
   420bf:	48 8d 05 ba 12 01 00 	lea    0x112ba(%rip),%rax        # 53380 <interrupt_descriptors+0xe0>
   420c6:	48 89 c7             	mov    %rax,%rdi
   420c9:	e8 9d fd ff ff       	call   41e6b <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   420ce:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   420d5:	eb 50                	jmp    42127 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   420d7:	8b 45 f8             	mov    -0x8(%rbp),%eax
   420da:	83 e8 30             	sub    $0x30,%eax
   420dd:	89 c0                	mov    %eax,%eax
   420df:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   420e6:	00 
   420e7:	48 8d 05 f9 df ff ff 	lea    -0x2007(%rip),%rax        # 400e7 <sys_int_handlers>
   420ee:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   420f2:	48 89 c2             	mov    %rax,%rdx
   420f5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   420f8:	48 c1 e0 04          	shl    $0x4,%rax
   420fc:	48 89 c1             	mov    %rax,%rcx
   420ff:	48 8d 05 9a 11 01 00 	lea    0x1119a(%rip),%rax        # 532a0 <interrupt_descriptors>
   42106:	48 01 c8             	add    %rcx,%rax
   42109:	48 89 d1             	mov    %rdx,%rcx
   4210c:	ba 03 00 00 00       	mov    $0x3,%edx
   42111:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   42118:	0e 00 00 
   4211b:	48 89 c7             	mov    %rax,%rdi
   4211e:	e8 48 fd ff ff       	call   41e6b <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   42123:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42127:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   4212b:	76 aa                	jbe    420d7 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4212d:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   42133:	48 8d 05 66 11 01 00 	lea    0x11166(%rip),%rax        # 532a0 <interrupt_descriptors>
   4213a:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   4213e:	b8 28 00 00 00       	mov    $0x28,%eax
   42143:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   42147:	0f 00 d8             	ltr    %ax
   4214a:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4214e:	0f 20 c0             	mov    %cr0,%rax
   42151:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   42155:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   42159:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   4215c:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   42163:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42166:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   42169:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4216c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   42170:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42174:	0f 22 c0             	mov    %rax,%cr0
}
   42177:	90                   	nop
    lcr0(cr0);
}
   42178:	90                   	nop
   42179:	c9                   	leave  
   4217a:	c3                   	ret    

000000000004217b <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   4217b:	f3 0f 1e fa          	endbr64 
   4217f:	55                   	push   %rbp
   42180:	48 89 e5             	mov    %rsp,%rbp
   42183:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   42187:	0f b7 05 72 21 01 00 	movzwl 0x12172(%rip),%eax        # 54300 <interrupts_enabled>
   4218e:	f7 d0                	not    %eax
   42190:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   42194:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   42198:	0f b6 c0             	movzbl %al,%eax
   4219b:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   421a2:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421a5:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   421a9:	8b 55 f0             	mov    -0x10(%rbp),%edx
   421ac:	ee                   	out    %al,(%dx)
}
   421ad:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   421ae:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   421b2:	66 c1 e8 08          	shr    $0x8,%ax
   421b6:	0f b6 c0             	movzbl %al,%eax
   421b9:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   421c0:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421c3:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   421c7:	8b 55 f8             	mov    -0x8(%rbp),%edx
   421ca:	ee                   	out    %al,(%dx)
}
   421cb:	90                   	nop
}
   421cc:	90                   	nop
   421cd:	c9                   	leave  
   421ce:	c3                   	ret    

00000000000421cf <interrupt_init>:

void interrupt_init(void) {
   421cf:	f3 0f 1e fa          	endbr64 
   421d3:	55                   	push   %rbp
   421d4:	48 89 e5             	mov    %rsp,%rbp
   421d7:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   421db:	66 c7 05 1c 21 01 00 	movw   $0x0,0x1211c(%rip)        # 54300 <interrupts_enabled>
   421e2:	00 00 
    interrupt_mask();
   421e4:	e8 92 ff ff ff       	call   4217b <interrupt_mask>
   421e9:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   421f0:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421f4:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   421f8:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   421fb:	ee                   	out    %al,(%dx)
}
   421fc:	90                   	nop
   421fd:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   42204:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42208:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   4220c:	8b 55 ac             	mov    -0x54(%rbp),%edx
   4220f:	ee                   	out    %al,(%dx)
}
   42210:	90                   	nop
   42211:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   42218:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4221c:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   42220:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   42223:	ee                   	out    %al,(%dx)
}
   42224:	90                   	nop
   42225:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   4222c:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42230:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   42234:	8b 55 bc             	mov    -0x44(%rbp),%edx
   42237:	ee                   	out    %al,(%dx)
}
   42238:	90                   	nop
   42239:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   42240:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42244:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   42248:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   4224b:	ee                   	out    %al,(%dx)
}
   4224c:	90                   	nop
   4224d:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   42254:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42258:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   4225c:	8b 55 cc             	mov    -0x34(%rbp),%edx
   4225f:	ee                   	out    %al,(%dx)
}
   42260:	90                   	nop
   42261:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   42268:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4226c:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   42270:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   42273:	ee                   	out    %al,(%dx)
}
   42274:	90                   	nop
   42275:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   4227c:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42280:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   42284:	8b 55 dc             	mov    -0x24(%rbp),%edx
   42287:	ee                   	out    %al,(%dx)
}
   42288:	90                   	nop
   42289:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   42290:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42294:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42298:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4229b:	ee                   	out    %al,(%dx)
}
   4229c:	90                   	nop
   4229d:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   422a4:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422a8:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   422ac:	8b 55 ec             	mov    -0x14(%rbp),%edx
   422af:	ee                   	out    %al,(%dx)
}
   422b0:	90                   	nop
   422b1:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   422b8:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422bc:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   422c0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   422c3:	ee                   	out    %al,(%dx)
}
   422c4:	90                   	nop
   422c5:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   422cc:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422d0:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   422d4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   422d7:	ee                   	out    %al,(%dx)
}
   422d8:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   422d9:	e8 9d fe ff ff       	call   4217b <interrupt_mask>
}
   422de:	90                   	nop
   422df:	c9                   	leave  
   422e0:	c3                   	ret    

00000000000422e1 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   422e1:	f3 0f 1e fa          	endbr64 
   422e5:	55                   	push   %rbp
   422e6:	48 89 e5             	mov    %rsp,%rbp
   422e9:	48 83 ec 28          	sub    $0x28,%rsp
   422ed:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   422f0:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   422f4:	0f 8e 9f 00 00 00    	jle    42399 <timer_init+0xb8>
   422fa:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   42301:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42305:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42309:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4230c:	ee                   	out    %al,(%dx)
}
   4230d:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   4230e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42311:	89 c2                	mov    %eax,%edx
   42313:	c1 ea 1f             	shr    $0x1f,%edx
   42316:	01 d0                	add    %edx,%eax
   42318:	d1 f8                	sar    %eax
   4231a:	05 de 34 12 00       	add    $0x1234de,%eax
   4231f:	99                   	cltd   
   42320:	f7 7d dc             	idivl  -0x24(%rbp)
   42323:	89 c2                	mov    %eax,%edx
   42325:	89 d0                	mov    %edx,%eax
   42327:	c1 f8 1f             	sar    $0x1f,%eax
   4232a:	c1 e8 18             	shr    $0x18,%eax
   4232d:	89 c1                	mov    %eax,%ecx
   4232f:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   42332:	0f b6 c0             	movzbl %al,%eax
   42335:	29 c8                	sub    %ecx,%eax
   42337:	0f b6 c0             	movzbl %al,%eax
   4233a:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   42341:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42344:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42348:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4234b:	ee                   	out    %al,(%dx)
}
   4234c:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   4234d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42350:	89 c2                	mov    %eax,%edx
   42352:	c1 ea 1f             	shr    $0x1f,%edx
   42355:	01 d0                	add    %edx,%eax
   42357:	d1 f8                	sar    %eax
   42359:	05 de 34 12 00       	add    $0x1234de,%eax
   4235e:	99                   	cltd   
   4235f:	f7 7d dc             	idivl  -0x24(%rbp)
   42362:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42368:	85 c0                	test   %eax,%eax
   4236a:	0f 48 c2             	cmovs  %edx,%eax
   4236d:	c1 f8 08             	sar    $0x8,%eax
   42370:	0f b6 c0             	movzbl %al,%eax
   42373:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   4237a:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4237d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42381:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42384:	ee                   	out    %al,(%dx)
}
   42385:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   42386:	0f b7 05 73 1f 01 00 	movzwl 0x11f73(%rip),%eax        # 54300 <interrupts_enabled>
   4238d:	83 c8 01             	or     $0x1,%eax
   42390:	66 89 05 69 1f 01 00 	mov    %ax,0x11f69(%rip)        # 54300 <interrupts_enabled>
   42397:	eb 11                	jmp    423aa <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   42399:	0f b7 05 60 1f 01 00 	movzwl 0x11f60(%rip),%eax        # 54300 <interrupts_enabled>
   423a0:	83 e0 fe             	and    $0xfffffffe,%eax
   423a3:	66 89 05 56 1f 01 00 	mov    %ax,0x11f56(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   423aa:	e8 cc fd ff ff       	call   4217b <interrupt_mask>
}
   423af:	90                   	nop
   423b0:	c9                   	leave  
   423b1:	c3                   	ret    

00000000000423b2 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   423b2:	f3 0f 1e fa          	endbr64 
   423b6:	55                   	push   %rbp
   423b7:	48 89 e5             	mov    %rsp,%rbp
   423ba:	48 83 ec 08          	sub    $0x8,%rsp
   423be:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   423c2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   423c7:	74 14                	je     423dd <physical_memory_isreserved+0x2b>
   423c9:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   423d0:	00 
   423d1:	76 11                	jbe    423e4 <physical_memory_isreserved+0x32>
   423d3:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   423da:	00 
   423db:	77 07                	ja     423e4 <physical_memory_isreserved+0x32>
   423dd:	b8 01 00 00 00       	mov    $0x1,%eax
   423e2:	eb 05                	jmp    423e9 <physical_memory_isreserved+0x37>
   423e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
   423e9:	c9                   	leave  
   423ea:	c3                   	ret    

00000000000423eb <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   423eb:	f3 0f 1e fa          	endbr64 
   423ef:	55                   	push   %rbp
   423f0:	48 89 e5             	mov    %rsp,%rbp
   423f3:	48 83 ec 10          	sub    $0x10,%rsp
   423f7:	89 7d fc             	mov    %edi,-0x4(%rbp)
   423fa:	89 75 f8             	mov    %esi,-0x8(%rbp)
   423fd:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   42400:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42403:	c1 e0 10             	shl    $0x10,%eax
   42406:	89 c2                	mov    %eax,%edx
   42408:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4240b:	c1 e0 0b             	shl    $0xb,%eax
   4240e:	09 c2                	or     %eax,%edx
   42410:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42413:	c1 e0 08             	shl    $0x8,%eax
   42416:	09 d0                	or     %edx,%eax
}
   42418:	c9                   	leave  
   42419:	c3                   	ret    

000000000004241a <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   4241a:	f3 0f 1e fa          	endbr64 
   4241e:	55                   	push   %rbp
   4241f:	48 89 e5             	mov    %rsp,%rbp
   42422:	48 83 ec 18          	sub    $0x18,%rsp
   42426:	89 7d ec             	mov    %edi,-0x14(%rbp)
   42429:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   4242c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4242f:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42432:	09 d0                	or     %edx,%eax
   42434:	0d 00 00 00 80       	or     $0x80000000,%eax
   42439:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   42440:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42443:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42446:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42449:	ef                   	out    %eax,(%dx)
}
   4244a:	90                   	nop
   4244b:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42452:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42455:	89 c2                	mov    %eax,%edx
   42457:	ed                   	in     (%dx),%eax
   42458:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   4245b:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   4245e:	c9                   	leave  
   4245f:	c3                   	ret    

0000000000042460 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   42460:	f3 0f 1e fa          	endbr64 
   42464:	55                   	push   %rbp
   42465:	48 89 e5             	mov    %rsp,%rbp
   42468:	48 83 ec 28          	sub    $0x28,%rsp
   4246c:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4246f:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42472:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42479:	eb 73                	jmp    424ee <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   4247b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   42482:	eb 60                	jmp    424e4 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   42484:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4248b:	eb 4a                	jmp    424d7 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   4248d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42490:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   42493:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42496:	89 ce                	mov    %ecx,%esi
   42498:	89 c7                	mov    %eax,%edi
   4249a:	e8 4c ff ff ff       	call   423eb <pci_make_configaddr>
   4249f:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   424a2:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424a5:	be 00 00 00 00       	mov    $0x0,%esi
   424aa:	89 c7                	mov    %eax,%edi
   424ac:	e8 69 ff ff ff       	call   4241a <pci_config_readl>
   424b1:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   424b4:	8b 45 d8             	mov    -0x28(%rbp),%eax
   424b7:	c1 e0 10             	shl    $0x10,%eax
   424ba:	0b 45 dc             	or     -0x24(%rbp),%eax
   424bd:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   424c0:	75 05                	jne    424c7 <pci_find_device+0x67>
                    return configaddr;
   424c2:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424c5:	eb 35                	jmp    424fc <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   424c7:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   424cb:	75 06                	jne    424d3 <pci_find_device+0x73>
   424cd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   424d1:	74 0c                	je     424df <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   424d3:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   424d7:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   424db:	75 b0                	jne    4248d <pci_find_device+0x2d>
   424dd:	eb 01                	jmp    424e0 <pci_find_device+0x80>
                    break;
   424df:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   424e0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   424e4:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   424e8:	75 9a                	jne    42484 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   424ea:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   424ee:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   424f5:	75 84                	jne    4247b <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   424f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   424fc:	c9                   	leave  
   424fd:	c3                   	ret    

00000000000424fe <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   424fe:	f3 0f 1e fa          	endbr64 
   42502:	55                   	push   %rbp
   42503:	48 89 e5             	mov    %rsp,%rbp
   42506:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   4250a:	be 13 71 00 00       	mov    $0x7113,%esi
   4250f:	bf 86 80 00 00       	mov    $0x8086,%edi
   42514:	e8 47 ff ff ff       	call   42460 <pci_find_device>
   42519:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   4251c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   42520:	78 30                	js     42552 <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   42522:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42525:	be 40 00 00 00       	mov    $0x40,%esi
   4252a:	89 c7                	mov    %eax,%edi
   4252c:	e8 e9 fe ff ff       	call   4241a <pci_config_readl>
   42531:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42536:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42539:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4253c:	83 c0 04             	add    $0x4,%eax
   4253f:	89 45 f4             	mov    %eax,-0xc(%rbp)
   42542:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42548:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   4254c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4254f:	66 ef                	out    %ax,(%dx)
}
   42551:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42552:	48 8d 05 27 29 00 00 	lea    0x2927(%rip),%rax        # 44e80 <memstate_colors+0xc0>
   42559:	48 89 c2             	mov    %rax,%rdx
   4255c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42561:	bf 80 07 00 00       	mov    $0x780,%edi
   42566:	b8 00 00 00 00       	mov    $0x0,%eax
   4256b:	e8 ef 23 00 00       	call   4495f <console_printf>
 spinloop: goto spinloop;
   42570:	eb fe                	jmp    42570 <poweroff+0x72>

0000000000042572 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   42572:	f3 0f 1e fa          	endbr64 
   42576:	55                   	push   %rbp
   42577:	48 89 e5             	mov    %rsp,%rbp
   4257a:	48 83 ec 10          	sub    $0x10,%rsp
   4257e:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42585:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42589:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4258d:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42590:	ee                   	out    %al,(%dx)
}
   42591:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   42592:	eb fe                	jmp    42592 <reboot+0x20>

0000000000042594 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42594:	f3 0f 1e fa          	endbr64 
   42598:	55                   	push   %rbp
   42599:	48 89 e5             	mov    %rsp,%rbp
   4259c:	48 83 ec 10          	sub    $0x10,%rsp
   425a0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425a4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   425a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425ab:	48 83 c0 08          	add    $0x8,%rax
   425af:	ba c0 00 00 00       	mov    $0xc0,%edx
   425b4:	be 00 00 00 00       	mov    $0x0,%esi
   425b9:	48 89 c7             	mov    %rax,%rdi
   425bc:	e8 5f 15 00 00       	call   43b20 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   425c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425c5:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   425cc:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   425ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425d2:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   425d9:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   425dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425e1:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   425e8:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   425ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425f0:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   425f7:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   425f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425fd:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   42604:	00 02 00 00 
    p->display_status = 1;
   42608:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4260c:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42613:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42616:	83 e0 01             	and    $0x1,%eax
   42619:	85 c0                	test   %eax,%eax
   4261b:	74 1c                	je     42639 <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4261d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42621:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42628:	80 cc 30             	or     $0x30,%ah
   4262b:	48 89 c2             	mov    %rax,%rdx
   4262e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42632:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42639:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4263c:	83 e0 02             	and    $0x2,%eax
   4263f:	85 c0                	test   %eax,%eax
   42641:	74 1c                	je     4265f <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42643:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42647:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4264e:	80 e4 fd             	and    $0xfd,%ah
   42651:	48 89 c2             	mov    %rax,%rdx
   42654:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42658:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   4265f:	90                   	nop
   42660:	c9                   	leave  
   42661:	c3                   	ret    

0000000000042662 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42662:	f3 0f 1e fa          	endbr64 
   42666:	55                   	push   %rbp
   42667:	48 89 e5             	mov    %rsp,%rbp
   4266a:	48 83 ec 28          	sub    $0x28,%rsp
   4266e:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42671:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42675:	78 09                	js     42680 <console_show_cursor+0x1e>
   42677:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4267e:	7e 07                	jle    42687 <console_show_cursor+0x25>
        cpos = 0;
   42680:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42687:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4268e:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42692:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42696:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42699:	ee                   	out    %al,(%dx)
}
   4269a:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   4269b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4269e:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   426a4:	85 c0                	test   %eax,%eax
   426a6:	0f 48 c2             	cmovs  %edx,%eax
   426a9:	c1 f8 08             	sar    $0x8,%eax
   426ac:	0f b6 c0             	movzbl %al,%eax
   426af:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   426b6:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426b9:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   426bd:	8b 55 ec             	mov    -0x14(%rbp),%edx
   426c0:	ee                   	out    %al,(%dx)
}
   426c1:	90                   	nop
   426c2:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   426c9:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426cd:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   426d1:	8b 55 f4             	mov    -0xc(%rbp),%edx
   426d4:	ee                   	out    %al,(%dx)
}
   426d5:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   426d6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   426d9:	99                   	cltd   
   426da:	c1 ea 18             	shr    $0x18,%edx
   426dd:	01 d0                	add    %edx,%eax
   426df:	0f b6 c0             	movzbl %al,%eax
   426e2:	29 d0                	sub    %edx,%eax
   426e4:	0f b6 c0             	movzbl %al,%eax
   426e7:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   426ee:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426f1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   426f5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   426f8:	ee                   	out    %al,(%dx)
}
   426f9:	90                   	nop
}
   426fa:	90                   	nop
   426fb:	c9                   	leave  
   426fc:	c3                   	ret    

00000000000426fd <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   426fd:	f3 0f 1e fa          	endbr64 
   42701:	55                   	push   %rbp
   42702:	48 89 e5             	mov    %rsp,%rbp
   42705:	48 83 ec 20          	sub    $0x20,%rsp
   42709:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42710:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42713:	89 c2                	mov    %eax,%edx
   42715:	ec                   	in     (%dx),%al
   42716:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42719:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   4271d:	0f b6 c0             	movzbl %al,%eax
   42720:	83 e0 01             	and    $0x1,%eax
   42723:	85 c0                	test   %eax,%eax
   42725:	75 0a                	jne    42731 <keyboard_readc+0x34>
        return -1;
   42727:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4272c:	e9 fd 01 00 00       	jmp    4292e <keyboard_readc+0x231>
   42731:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42738:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4273b:	89 c2                	mov    %eax,%edx
   4273d:	ec                   	in     (%dx),%al
   4273e:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42741:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42745:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42748:	0f b6 05 b3 1b 01 00 	movzbl 0x11bb3(%rip),%eax        # 54302 <last_escape.2>
   4274f:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42752:	c6 05 a9 1b 01 00 00 	movb   $0x0,0x11ba9(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42759:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4275d:	75 11                	jne    42770 <keyboard_readc+0x73>
        last_escape = 0x80;
   4275f:	c6 05 9c 1b 01 00 80 	movb   $0x80,0x11b9c(%rip)        # 54302 <last_escape.2>
        return 0;
   42766:	b8 00 00 00 00       	mov    $0x0,%eax
   4276b:	e9 be 01 00 00       	jmp    4292e <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42770:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42774:	84 c0                	test   %al,%al
   42776:	79 64                	jns    427dc <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   42778:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4277c:	83 e0 7f             	and    $0x7f,%eax
   4277f:	89 c2                	mov    %eax,%edx
   42781:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42785:	09 d0                	or     %edx,%eax
   42787:	48 98                	cltq   
   42789:	48 8d 15 10 27 00 00 	lea    0x2710(%rip),%rdx        # 44ea0 <keymap>
   42790:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42794:	0f b6 c0             	movzbl %al,%eax
   42797:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   4279a:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   427a1:	7e 2f                	jle    427d2 <keyboard_readc+0xd5>
   427a3:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   427aa:	7f 26                	jg     427d2 <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   427ac:	8b 45 f4             	mov    -0xc(%rbp),%eax
   427af:	2d fa 00 00 00       	sub    $0xfa,%eax
   427b4:	ba 01 00 00 00       	mov    $0x1,%edx
   427b9:	89 c1                	mov    %eax,%ecx
   427bb:	d3 e2                	shl    %cl,%edx
   427bd:	89 d0                	mov    %edx,%eax
   427bf:	f7 d0                	not    %eax
   427c1:	89 c2                	mov    %eax,%edx
   427c3:	0f b6 05 39 1b 01 00 	movzbl 0x11b39(%rip),%eax        # 54303 <modifiers.1>
   427ca:	21 d0                	and    %edx,%eax
   427cc:	88 05 31 1b 01 00    	mov    %al,0x11b31(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   427d2:	b8 00 00 00 00       	mov    $0x0,%eax
   427d7:	e9 52 01 00 00       	jmp    4292e <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   427dc:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   427e0:	0a 45 fa             	or     -0x6(%rbp),%al
   427e3:	0f b6 c0             	movzbl %al,%eax
   427e6:	48 98                	cltq   
   427e8:	48 8d 15 b1 26 00 00 	lea    0x26b1(%rip),%rdx        # 44ea0 <keymap>
   427ef:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   427f3:	0f b6 c0             	movzbl %al,%eax
   427f6:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   427f9:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   427fd:	7e 57                	jle    42856 <keyboard_readc+0x159>
   427ff:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42803:	7f 51                	jg     42856 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   42805:	0f b6 05 f7 1a 01 00 	movzbl 0x11af7(%rip),%eax        # 54303 <modifiers.1>
   4280c:	0f b6 c0             	movzbl %al,%eax
   4280f:	83 e0 02             	and    $0x2,%eax
   42812:	85 c0                	test   %eax,%eax
   42814:	74 09                	je     4281f <keyboard_readc+0x122>
            ch -= 0x60;
   42816:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4281a:	e9 0b 01 00 00       	jmp    4292a <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4281f:	0f b6 05 dd 1a 01 00 	movzbl 0x11add(%rip),%eax        # 54303 <modifiers.1>
   42826:	0f b6 c0             	movzbl %al,%eax
   42829:	83 e0 01             	and    $0x1,%eax
   4282c:	85 c0                	test   %eax,%eax
   4282e:	0f 94 c2             	sete   %dl
   42831:	0f b6 05 cb 1a 01 00 	movzbl 0x11acb(%rip),%eax        # 54303 <modifiers.1>
   42838:	0f b6 c0             	movzbl %al,%eax
   4283b:	83 e0 08             	and    $0x8,%eax
   4283e:	85 c0                	test   %eax,%eax
   42840:	0f 94 c0             	sete   %al
   42843:	31 d0                	xor    %edx,%eax
   42845:	84 c0                	test   %al,%al
   42847:	0f 84 dd 00 00 00    	je     4292a <keyboard_readc+0x22d>
            ch -= 0x20;
   4284d:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42851:	e9 d4 00 00 00       	jmp    4292a <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42856:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4285d:	7e 30                	jle    4288f <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4285f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42862:	2d fa 00 00 00       	sub    $0xfa,%eax
   42867:	ba 01 00 00 00       	mov    $0x1,%edx
   4286c:	89 c1                	mov    %eax,%ecx
   4286e:	d3 e2                	shl    %cl,%edx
   42870:	89 d0                	mov    %edx,%eax
   42872:	89 c2                	mov    %eax,%edx
   42874:	0f b6 05 88 1a 01 00 	movzbl 0x11a88(%rip),%eax        # 54303 <modifiers.1>
   4287b:	31 d0                	xor    %edx,%eax
   4287d:	88 05 80 1a 01 00    	mov    %al,0x11a80(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42883:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4288a:	e9 9c 00 00 00       	jmp    4292b <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   4288f:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42896:	7e 2d                	jle    428c5 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42898:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4289b:	2d fa 00 00 00       	sub    $0xfa,%eax
   428a0:	ba 01 00 00 00       	mov    $0x1,%edx
   428a5:	89 c1                	mov    %eax,%ecx
   428a7:	d3 e2                	shl    %cl,%edx
   428a9:	89 d0                	mov    %edx,%eax
   428ab:	89 c2                	mov    %eax,%edx
   428ad:	0f b6 05 4f 1a 01 00 	movzbl 0x11a4f(%rip),%eax        # 54303 <modifiers.1>
   428b4:	09 d0                	or     %edx,%eax
   428b6:	88 05 47 1a 01 00    	mov    %al,0x11a47(%rip)        # 54303 <modifiers.1>
        ch = 0;
   428bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   428c3:	eb 66                	jmp    4292b <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   428c5:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   428c9:	7e 3f                	jle    4290a <keyboard_readc+0x20d>
   428cb:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   428d2:	7f 36                	jg     4290a <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   428d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   428d7:	8d 50 80             	lea    -0x80(%rax),%edx
   428da:	0f b6 05 22 1a 01 00 	movzbl 0x11a22(%rip),%eax        # 54303 <modifiers.1>
   428e1:	0f b6 c0             	movzbl %al,%eax
   428e4:	83 e0 03             	and    $0x3,%eax
   428e7:	48 63 c8             	movslq %eax,%rcx
   428ea:	48 63 c2             	movslq %edx,%rax
   428ed:	48 c1 e0 02          	shl    $0x2,%rax
   428f1:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   428f5:	48 8d 05 a4 26 00 00 	lea    0x26a4(%rip),%rax        # 44fa0 <complex_keymap>
   428fc:	48 01 d0             	add    %rdx,%rax
   428ff:	0f b6 00             	movzbl (%rax),%eax
   42902:	0f b6 c0             	movzbl %al,%eax
   42905:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42908:	eb 21                	jmp    4292b <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   4290a:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4290e:	7f 1b                	jg     4292b <keyboard_readc+0x22e>
   42910:	0f b6 05 ec 19 01 00 	movzbl 0x119ec(%rip),%eax        # 54303 <modifiers.1>
   42917:	0f b6 c0             	movzbl %al,%eax
   4291a:	83 e0 02             	and    $0x2,%eax
   4291d:	85 c0                	test   %eax,%eax
   4291f:	74 0a                	je     4292b <keyboard_readc+0x22e>
        ch = 0;
   42921:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42928:	eb 01                	jmp    4292b <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   4292a:	90                   	nop
    }

    return ch;
   4292b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4292e:	c9                   	leave  
   4292f:	c3                   	ret    

0000000000042930 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42930:	f3 0f 1e fa          	endbr64 
   42934:	55                   	push   %rbp
   42935:	48 89 e5             	mov    %rsp,%rbp
   42938:	48 83 ec 20          	sub    $0x20,%rsp
   4293c:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42943:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42946:	89 c2                	mov    %eax,%edx
   42948:	ec                   	in     (%dx),%al
   42949:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4294c:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42953:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42956:	89 c2                	mov    %eax,%edx
   42958:	ec                   	in     (%dx),%al
   42959:	88 45 eb             	mov    %al,-0x15(%rbp)
   4295c:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42963:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42966:	89 c2                	mov    %eax,%edx
   42968:	ec                   	in     (%dx),%al
   42969:	88 45 f3             	mov    %al,-0xd(%rbp)
   4296c:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42973:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42976:	89 c2                	mov    %eax,%edx
   42978:	ec                   	in     (%dx),%al
   42979:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4297c:	90                   	nop
   4297d:	c9                   	leave  
   4297e:	c3                   	ret    

000000000004297f <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4297f:	f3 0f 1e fa          	endbr64 
   42983:	55                   	push   %rbp
   42984:	48 89 e5             	mov    %rsp,%rbp
   42987:	48 83 ec 40          	sub    $0x40,%rsp
   4298b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4298f:	89 f0                	mov    %esi,%eax
   42991:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42994:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42997:	8b 05 67 19 01 00    	mov    0x11967(%rip),%eax        # 54304 <initialized.0>
   4299d:	85 c0                	test   %eax,%eax
   4299f:	75 1e                	jne    429bf <parallel_port_putc+0x40>
   429a1:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   429a8:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   429ac:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   429b0:	8b 55 f8             	mov    -0x8(%rbp),%edx
   429b3:	ee                   	out    %al,(%dx)
}
   429b4:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   429b5:	c7 05 45 19 01 00 01 	movl   $0x1,0x11945(%rip)        # 54304 <initialized.0>
   429bc:	00 00 00 
    }

    for (int i = 0;
   429bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   429c6:	eb 09                	jmp    429d1 <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   429c8:	e8 63 ff ff ff       	call   42930 <delay>
         ++i) {
   429cd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   429d1:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   429d8:	7f 18                	jg     429f2 <parallel_port_putc+0x73>
   429da:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   429e1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   429e4:	89 c2                	mov    %eax,%edx
   429e6:	ec                   	in     (%dx),%al
   429e7:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   429ea:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   429ee:	84 c0                	test   %al,%al
   429f0:	79 d6                	jns    429c8 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   429f2:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   429f6:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   429fd:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42a00:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42a04:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42a07:	ee                   	out    %al,(%dx)
}
   42a08:	90                   	nop
   42a09:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42a10:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42a14:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42a18:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42a1b:	ee                   	out    %al,(%dx)
}
   42a1c:	90                   	nop
   42a1d:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42a24:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42a28:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42a2c:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42a2f:	ee                   	out    %al,(%dx)
}
   42a30:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42a31:	90                   	nop
   42a32:	c9                   	leave  
   42a33:	c3                   	ret    

0000000000042a34 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42a34:	f3 0f 1e fa          	endbr64 
   42a38:	55                   	push   %rbp
   42a39:	48 89 e5             	mov    %rsp,%rbp
   42a3c:	48 83 ec 20          	sub    $0x20,%rsp
   42a40:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42a44:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42a48:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 4297f <parallel_port_putc>
   42a4f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   42a53:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42a57:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42a5b:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42a5f:	be 00 00 00 00       	mov    $0x0,%esi
   42a64:	48 89 c7             	mov    %rax,%rdi
   42a67:	e8 7a 13 00 00       	call   43de6 <printer_vprintf>
}
   42a6c:	90                   	nop
   42a6d:	c9                   	leave  
   42a6e:	c3                   	ret    

0000000000042a6f <log_printf>:

void log_printf(const char* format, ...) {
   42a6f:	f3 0f 1e fa          	endbr64 
   42a73:	55                   	push   %rbp
   42a74:	48 89 e5             	mov    %rsp,%rbp
   42a77:	48 83 ec 60          	sub    $0x60,%rsp
   42a7b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42a7f:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42a83:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42a87:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42a8b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42a8f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42a93:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42a9a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42a9e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42aa2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42aa6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42aaa:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42aae:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ab2:	48 89 d6             	mov    %rdx,%rsi
   42ab5:	48 89 c7             	mov    %rax,%rdi
   42ab8:	e8 77 ff ff ff       	call   42a34 <log_vprintf>
    va_end(val);
}
   42abd:	90                   	nop
   42abe:	c9                   	leave  
   42abf:	c3                   	ret    

0000000000042ac0 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42ac0:	f3 0f 1e fa          	endbr64 
   42ac4:	55                   	push   %rbp
   42ac5:	48 89 e5             	mov    %rsp,%rbp
   42ac8:	48 83 ec 40          	sub    $0x40,%rsp
   42acc:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42acf:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42ad2:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42ad6:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42ada:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42ade:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42ae2:	48 8b 0a             	mov    (%rdx),%rcx
   42ae5:	48 89 08             	mov    %rcx,(%rax)
   42ae8:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42aec:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42af0:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42af4:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42af8:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42afc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b00:	48 89 d6             	mov    %rdx,%rsi
   42b03:	48 89 c7             	mov    %rax,%rdi
   42b06:	e8 29 ff ff ff       	call   42a34 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42b0b:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42b0f:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42b13:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42b16:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42b19:	89 c7                	mov    %eax,%edi
   42b1b:	e8 c3 1d 00 00       	call   448e3 <console_vprintf>
}
   42b20:	c9                   	leave  
   42b21:	c3                   	ret    

0000000000042b22 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42b22:	f3 0f 1e fa          	endbr64 
   42b26:	55                   	push   %rbp
   42b27:	48 89 e5             	mov    %rsp,%rbp
   42b2a:	48 83 ec 60          	sub    $0x60,%rsp
   42b2e:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42b31:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42b34:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42b38:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42b3c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42b40:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42b44:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42b4b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42b4f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42b53:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42b57:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42b5b:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42b5f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42b63:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42b66:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b69:	89 c7                	mov    %eax,%edi
   42b6b:	e8 50 ff ff ff       	call   42ac0 <error_vprintf>
   42b70:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42b73:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42b76:	c9                   	leave  
   42b77:	c3                   	ret    

0000000000042b78 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42b78:	f3 0f 1e fa          	endbr64 
   42b7c:	55                   	push   %rbp
   42b7d:	48 89 e5             	mov    %rsp,%rbp
   42b80:	53                   	push   %rbx
   42b81:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42b85:	e8 73 fb ff ff       	call   426fd <keyboard_readc>
   42b8a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42b8d:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42b91:	74 1c                	je     42baf <check_keyboard+0x37>
   42b93:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42b97:	74 16                	je     42baf <check_keyboard+0x37>
   42b99:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42b9d:	74 10                	je     42baf <check_keyboard+0x37>
   42b9f:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42ba3:	74 0a                	je     42baf <check_keyboard+0x37>
   42ba5:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42ba9:	0f 85 02 01 00 00    	jne    42cb1 <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42baf:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42bb6:	00 
        memset(pt, 0, PAGESIZE * 3);
   42bb7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bbb:	ba 00 30 00 00       	mov    $0x3000,%edx
   42bc0:	be 00 00 00 00       	mov    $0x0,%esi
   42bc5:	48 89 c7             	mov    %rax,%rdi
   42bc8:	e8 53 0f 00 00       	call   43b20 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42bcd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bd1:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42bd8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bdc:	48 05 00 10 00 00    	add    $0x1000,%rax
   42be2:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42be9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bed:	48 05 00 20 00 00    	add    $0x2000,%rax
   42bf3:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42bfa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bfe:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42c02:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c06:	0f 22 d8             	mov    %rax,%cr3
}
   42c09:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42c0a:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42c11:	48 8d 05 e0 23 00 00 	lea    0x23e0(%rip),%rax        # 44ff8 <complex_keymap+0x58>
   42c18:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   42c1c:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42c20:	75 0d                	jne    42c2f <check_keyboard+0xb7>
            argument = "allocator";
   42c22:	48 8d 05 d4 23 00 00 	lea    0x23d4(%rip),%rax        # 44ffd <complex_keymap+0x5d>
   42c29:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42c2d:	eb 37                	jmp    42c66 <check_keyboard+0xee>
        } else if (c == 'e') {
   42c2f:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42c33:	75 0d                	jne    42c42 <check_keyboard+0xca>
            argument = "forkexit";
   42c35:	48 8d 05 cb 23 00 00 	lea    0x23cb(%rip),%rax        # 45007 <complex_keymap+0x67>
   42c3c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42c40:	eb 24                	jmp    42c66 <check_keyboard+0xee>
        }
        else if (c == 't'){
   42c42:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42c46:	75 0d                	jne    42c55 <check_keyboard+0xdd>
            argument = "test";
   42c48:	48 8d 05 c1 23 00 00 	lea    0x23c1(%rip),%rax        # 45010 <complex_keymap+0x70>
   42c4f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42c53:	eb 11                	jmp    42c66 <check_keyboard+0xee>
        }
        else if(c == '2'){
   42c55:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42c59:	75 0b                	jne    42c66 <check_keyboard+0xee>
            argument = "test2";
   42c5b:	48 8d 05 b3 23 00 00 	lea    0x23b3(%rip),%rax        # 45015 <complex_keymap+0x75>
   42c62:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42c66:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c6a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42c6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c73:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42c77:	76 1e                	jbe    42c97 <check_keyboard+0x11f>
   42c79:	48 8d 05 9b 23 00 00 	lea    0x239b(%rip),%rax        # 4501b <complex_keymap+0x7b>
   42c80:	48 89 c2             	mov    %rax,%rdx
   42c83:	be 5d 02 00 00       	mov    $0x25d,%esi
   42c88:	48 8d 05 a8 23 00 00 	lea    0x23a8(%rip),%rax        # 45037 <complex_keymap+0x97>
   42c8f:	48 89 c7             	mov    %rax,%rdi
   42c92:	e8 33 01 00 00       	call   42dca <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42c97:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c9b:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42c9e:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42ca2:	48 89 c3             	mov    %rax,%rbx
   42ca5:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42caa:	e9 51 d3 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42caf:	eb 11                	jmp    42cc2 <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42cb1:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42cb5:	74 06                	je     42cbd <check_keyboard+0x145>
   42cb7:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42cbb:	75 05                	jne    42cc2 <check_keyboard+0x14a>
        poweroff();
   42cbd:	e8 3c f8 ff ff       	call   424fe <poweroff>
    }
    return c;
   42cc2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42cc5:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42cc9:	c9                   	leave  
   42cca:	c3                   	ret    

0000000000042ccb <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42ccb:	f3 0f 1e fa          	endbr64 
   42ccf:	55                   	push   %rbp
   42cd0:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42cd3:	e8 a0 fe ff ff       	call   42b78 <check_keyboard>
   42cd8:	eb f9                	jmp    42cd3 <fail+0x8>

0000000000042cda <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42cda:	f3 0f 1e fa          	endbr64 
   42cde:	55                   	push   %rbp
   42cdf:	48 89 e5             	mov    %rsp,%rbp
   42ce2:	48 83 ec 60          	sub    $0x60,%rsp
   42ce6:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42cea:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42cee:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42cf2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42cf6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42cfa:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42cfe:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42d05:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42d09:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42d0d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42d11:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42d15:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42d1a:	0f 84 87 00 00 00    	je     42da7 <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42d20:	48 8d 05 24 23 00 00 	lea    0x2324(%rip),%rax        # 4504b <complex_keymap+0xab>
   42d27:	48 89 c2             	mov    %rax,%rdx
   42d2a:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d2f:	bf 30 07 00 00       	mov    $0x730,%edi
   42d34:	b8 00 00 00 00       	mov    $0x0,%eax
   42d39:	e8 e4 fd ff ff       	call   42b22 <error_printf>
   42d3e:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42d41:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42d45:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42d49:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d4c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d51:	89 c7                	mov    %eax,%edi
   42d53:	e8 68 fd ff ff       	call   42ac0 <error_vprintf>
   42d58:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42d5b:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42d5e:	48 63 c1             	movslq %ecx,%rax
   42d61:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42d68:	48 c1 e8 20          	shr    $0x20,%rax
   42d6c:	c1 f8 05             	sar    $0x5,%eax
   42d6f:	89 ce                	mov    %ecx,%esi
   42d71:	c1 fe 1f             	sar    $0x1f,%esi
   42d74:	29 f0                	sub    %esi,%eax
   42d76:	89 c2                	mov    %eax,%edx
   42d78:	89 d0                	mov    %edx,%eax
   42d7a:	c1 e0 02             	shl    $0x2,%eax
   42d7d:	01 d0                	add    %edx,%eax
   42d7f:	c1 e0 04             	shl    $0x4,%eax
   42d82:	29 c1                	sub    %eax,%ecx
   42d84:	89 ca                	mov    %ecx,%edx
   42d86:	85 d2                	test   %edx,%edx
   42d88:	74 3b                	je     42dc5 <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   42d8a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d8d:	48 8d 15 bf 22 00 00 	lea    0x22bf(%rip),%rdx        # 45053 <complex_keymap+0xb3>
   42d94:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d99:	89 c7                	mov    %eax,%edi
   42d9b:	b8 00 00 00 00       	mov    $0x0,%eax
   42da0:	e8 7d fd ff ff       	call   42b22 <error_printf>
   42da5:	eb 1e                	jmp    42dc5 <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42da7:	48 8d 05 a7 22 00 00 	lea    0x22a7(%rip),%rax        # 45055 <complex_keymap+0xb5>
   42dae:	48 89 c2             	mov    %rax,%rdx
   42db1:	be 00 c0 00 00       	mov    $0xc000,%esi
   42db6:	bf 30 07 00 00       	mov    $0x730,%edi
   42dbb:	b8 00 00 00 00       	mov    $0x0,%eax
   42dc0:	e8 5d fd ff ff       	call   42b22 <error_printf>
    }

    va_end(val);
    fail();
   42dc5:	e8 01 ff ff ff       	call   42ccb <fail>

0000000000042dca <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42dca:	f3 0f 1e fa          	endbr64 
   42dce:	55                   	push   %rbp
   42dcf:	48 89 e5             	mov    %rsp,%rbp
   42dd2:	48 83 ec 20          	sub    $0x20,%rsp
   42dd6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42dda:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42ddd:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42de1:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42de5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42de8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42dec:	48 89 c6             	mov    %rax,%rsi
   42def:	48 8d 05 65 22 00 00 	lea    0x2265(%rip),%rax        # 4505b <complex_keymap+0xbb>
   42df6:	48 89 c7             	mov    %rax,%rdi
   42df9:	b8 00 00 00 00       	mov    $0x0,%eax
   42dfe:	e8 d7 fe ff ff       	call   42cda <panic>

0000000000042e03 <default_exception>:
}

void default_exception(proc* p){
   42e03:	f3 0f 1e fa          	endbr64 
   42e07:	55                   	push   %rbp
   42e08:	48 89 e5             	mov    %rsp,%rbp
   42e0b:	48 83 ec 20          	sub    $0x20,%rsp
   42e0f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42e13:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e17:	48 83 c0 08          	add    $0x8,%rax
   42e1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42e1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e23:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42e2a:	48 89 c6             	mov    %rax,%rsi
   42e2d:	48 8d 05 45 22 00 00 	lea    0x2245(%rip),%rax        # 45079 <complex_keymap+0xd9>
   42e34:	48 89 c7             	mov    %rax,%rdi
   42e37:	b8 00 00 00 00       	mov    $0x0,%eax
   42e3c:	e8 99 fe ff ff       	call   42cda <panic>

0000000000042e41 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42e41:	55                   	push   %rbp
   42e42:	48 89 e5             	mov    %rsp,%rbp
   42e45:	48 83 ec 10          	sub    $0x10,%rsp
   42e49:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42e4d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42e50:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42e54:	78 06                	js     42e5c <pageindex+0x1b>
   42e56:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42e5a:	7e 1e                	jle    42e7a <pageindex+0x39>
   42e5c:	48 8d 05 35 22 00 00 	lea    0x2235(%rip),%rax        # 45098 <complex_keymap+0xf8>
   42e63:	48 89 c2             	mov    %rax,%rdx
   42e66:	be 1e 00 00 00       	mov    $0x1e,%esi
   42e6b:	48 8d 05 3f 22 00 00 	lea    0x223f(%rip),%rax        # 450b1 <complex_keymap+0x111>
   42e72:	48 89 c7             	mov    %rax,%rdi
   42e75:	e8 50 ff ff ff       	call   42dca <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42e7a:	b8 03 00 00 00       	mov    $0x3,%eax
   42e7f:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42e82:	89 c2                	mov    %eax,%edx
   42e84:	89 d0                	mov    %edx,%eax
   42e86:	c1 e0 03             	shl    $0x3,%eax
   42e89:	01 d0                	add    %edx,%eax
   42e8b:	83 c0 0c             	add    $0xc,%eax
   42e8e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e92:	89 c1                	mov    %eax,%ecx
   42e94:	48 d3 ea             	shr    %cl,%rdx
   42e97:	48 89 d0             	mov    %rdx,%rax
   42e9a:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42e9f:	c9                   	leave  
   42ea0:	c3                   	ret    

0000000000042ea1 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42ea1:	f3 0f 1e fa          	endbr64 
   42ea5:	55                   	push   %rbp
   42ea6:	48 89 e5             	mov    %rsp,%rbp
   42ea9:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42ead:	48 8d 05 4c 31 01 00 	lea    0x1314c(%rip),%rax        # 56000 <kernel_pagetables>
   42eb4:	48 89 05 45 21 01 00 	mov    %rax,0x12145(%rip)        # 55000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42ebb:	ba 00 50 00 00       	mov    $0x5000,%edx
   42ec0:	be 00 00 00 00       	mov    $0x0,%esi
   42ec5:	48 8d 05 34 31 01 00 	lea    0x13134(%rip),%rax        # 56000 <kernel_pagetables>
   42ecc:	48 89 c7             	mov    %rax,%rdi
   42ecf:	e8 4c 0c 00 00       	call   43b20 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42ed4:	48 8d 05 25 41 01 00 	lea    0x14125(%rip),%rax        # 57000 <kernel_pagetables+0x1000>
   42edb:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42edf:	48 89 05 1a 31 01 00 	mov    %rax,0x1311a(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42ee6:	48 8d 05 13 51 01 00 	lea    0x15113(%rip),%rax        # 58000 <kernel_pagetables+0x2000>
   42eed:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42ef1:	48 89 05 08 41 01 00 	mov    %rax,0x14108(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42ef8:	48 8d 05 01 61 01 00 	lea    0x16101(%rip),%rax        # 59000 <kernel_pagetables+0x3000>
   42eff:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42f03:	48 89 05 f6 50 01 00 	mov    %rax,0x150f6(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42f0a:	48 8d 05 ef 70 01 00 	lea    0x170ef(%rip),%rax        # 5a000 <kernel_pagetables+0x4000>
   42f11:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42f15:	48 89 05 ec 50 01 00 	mov    %rax,0x150ec(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42f1c:	48 8b 05 dd 20 01 00 	mov    0x120dd(%rip),%rax        # 55000 <kernel_pagetable>
   42f23:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42f29:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42f2e:	ba 00 00 00 00       	mov    $0x0,%edx
   42f33:	be 00 00 00 00       	mov    $0x0,%esi
   42f38:	48 89 c7             	mov    %rax,%rdi
   42f3b:	e8 0e 02 00 00       	call   4314e <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42f40:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42f47:	00 
   42f48:	eb 76                	jmp    42fc0 <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42f4a:	48 8b 0d af 20 01 00 	mov    0x120af(%rip),%rcx        # 55000 <kernel_pagetable>
   42f51:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42f55:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42f59:	48 89 ce             	mov    %rcx,%rsi
   42f5c:	48 89 c7             	mov    %rax,%rdi
   42f5f:	e8 34 06 00 00       	call   43598 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42f64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f68:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42f6c:	74 1e                	je     42f8c <virtual_memory_init+0xeb>
   42f6e:	48 8d 05 50 21 00 00 	lea    0x2150(%rip),%rax        # 450c5 <complex_keymap+0x125>
   42f75:	48 89 c2             	mov    %rax,%rdx
   42f78:	be 2d 00 00 00       	mov    $0x2d,%esi
   42f7d:	48 8d 05 51 21 00 00 	lea    0x2151(%rip),%rax        # 450d5 <complex_keymap+0x135>
   42f84:	48 89 c7             	mov    %rax,%rdi
   42f87:	e8 3e fe ff ff       	call   42dca <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42f8c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42f8f:	48 98                	cltq   
   42f91:	83 e0 03             	and    $0x3,%eax
   42f94:	48 83 f8 03          	cmp    $0x3,%rax
   42f98:	74 1e                	je     42fb8 <virtual_memory_init+0x117>
   42f9a:	48 8d 05 47 21 00 00 	lea    0x2147(%rip),%rax        # 450e8 <complex_keymap+0x148>
   42fa1:	48 89 c2             	mov    %rax,%rdx
   42fa4:	be 2e 00 00 00       	mov    $0x2e,%esi
   42fa9:	48 8d 05 25 21 00 00 	lea    0x2125(%rip),%rax        # 450d5 <complex_keymap+0x135>
   42fb0:	48 89 c7             	mov    %rax,%rdi
   42fb3:	e8 12 fe ff ff       	call   42dca <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42fb8:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42fbf:	00 
   42fc0:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42fc7:	00 
   42fc8:	76 80                	jbe    42f4a <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42fca:	48 8b 05 2f 20 01 00 	mov    0x1202f(%rip),%rax        # 55000 <kernel_pagetable>
   42fd1:	48 89 c7             	mov    %rax,%rdi
   42fd4:	e8 03 00 00 00       	call   42fdc <set_pagetable>
}
   42fd9:	90                   	nop
   42fda:	c9                   	leave  
   42fdb:	c3                   	ret    

0000000000042fdc <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42fdc:	f3 0f 1e fa          	endbr64 
   42fe0:	55                   	push   %rbp
   42fe1:	48 89 e5             	mov    %rsp,%rbp
   42fe4:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42fe8:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42fec:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42ff0:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ff5:	48 85 c0             	test   %rax,%rax
   42ff8:	74 1e                	je     43018 <set_pagetable+0x3c>
   42ffa:	48 8d 05 14 21 00 00 	lea    0x2114(%rip),%rax        # 45115 <complex_keymap+0x175>
   43001:	48 89 c2             	mov    %rax,%rdx
   43004:	be 3c 00 00 00       	mov    $0x3c,%esi
   43009:	48 8d 05 c5 20 00 00 	lea    0x20c5(%rip),%rax        # 450d5 <complex_keymap+0x135>
   43010:	48 89 c7             	mov    %rax,%rdi
   43013:	e8 b2 fd ff ff       	call   42dca <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   43018:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   4301f:	48 89 c2             	mov    %rax,%rdx
   43022:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   43026:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4302a:	48 89 ce             	mov    %rcx,%rsi
   4302d:	48 89 c7             	mov    %rax,%rdi
   43030:	e8 63 05 00 00       	call   43598 <virtual_memory_lookup>
   43035:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43039:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   43040:	48 39 d0             	cmp    %rdx,%rax
   43043:	74 1e                	je     43063 <set_pagetable+0x87>
   43045:	48 8d 05 e4 20 00 00 	lea    0x20e4(%rip),%rax        # 45130 <complex_keymap+0x190>
   4304c:	48 89 c2             	mov    %rax,%rdx
   4304f:	be 3e 00 00 00       	mov    $0x3e,%esi
   43054:	48 8d 05 7a 20 00 00 	lea    0x207a(%rip),%rax        # 450d5 <complex_keymap+0x135>
   4305b:	48 89 c7             	mov    %rax,%rdi
   4305e:	e8 67 fd ff ff       	call   42dca <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   43063:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   43067:	48 8b 0d 92 1f 01 00 	mov    0x11f92(%rip),%rcx        # 55000 <kernel_pagetable>
   4306e:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   43072:	48 89 ce             	mov    %rcx,%rsi
   43075:	48 89 c7             	mov    %rax,%rdi
   43078:	e8 1b 05 00 00       	call   43598 <virtual_memory_lookup>
   4307d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   43081:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43085:	48 39 c2             	cmp    %rax,%rdx
   43088:	74 1e                	je     430a8 <set_pagetable+0xcc>
   4308a:	48 8d 05 07 21 00 00 	lea    0x2107(%rip),%rax        # 45198 <complex_keymap+0x1f8>
   43091:	48 89 c2             	mov    %rax,%rdx
   43094:	be 40 00 00 00       	mov    $0x40,%esi
   43099:	48 8d 05 35 20 00 00 	lea    0x2035(%rip),%rax        # 450d5 <complex_keymap+0x135>
   430a0:	48 89 c7             	mov    %rax,%rdi
   430a3:	e8 22 fd ff ff       	call   42dca <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   430a8:	48 8b 05 51 1f 01 00 	mov    0x11f51(%rip),%rax        # 55000 <kernel_pagetable>
   430af:	48 89 c2             	mov    %rax,%rdx
   430b2:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   430b6:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   430ba:	48 89 ce             	mov    %rcx,%rsi
   430bd:	48 89 c7             	mov    %rax,%rdi
   430c0:	e8 d3 04 00 00       	call   43598 <virtual_memory_lookup>
   430c5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   430c9:	48 8b 15 30 1f 01 00 	mov    0x11f30(%rip),%rdx        # 55000 <kernel_pagetable>
   430d0:	48 39 d0             	cmp    %rdx,%rax
   430d3:	74 1e                	je     430f3 <set_pagetable+0x117>
   430d5:	48 8d 05 1c 21 00 00 	lea    0x211c(%rip),%rax        # 451f8 <complex_keymap+0x258>
   430dc:	48 89 c2             	mov    %rax,%rdx
   430df:	be 42 00 00 00       	mov    $0x42,%esi
   430e4:	48 8d 05 ea 1f 00 00 	lea    0x1fea(%rip),%rax        # 450d5 <complex_keymap+0x135>
   430eb:	48 89 c7             	mov    %rax,%rdi
   430ee:	e8 d7 fc ff ff       	call   42dca <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   430f3:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 4314e <virtual_memory_map>
   430fa:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   430fe:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43102:	48 89 ce             	mov    %rcx,%rsi
   43105:	48 89 c7             	mov    %rax,%rdi
   43108:	e8 8b 04 00 00       	call   43598 <virtual_memory_lookup>
   4310d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43111:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 4314e <virtual_memory_map>
   43118:	48 39 d0             	cmp    %rdx,%rax
   4311b:	74 1e                	je     4313b <set_pagetable+0x15f>
   4311d:	48 8d 05 3c 21 00 00 	lea    0x213c(%rip),%rax        # 45260 <complex_keymap+0x2c0>
   43124:	48 89 c2             	mov    %rax,%rdx
   43127:	be 44 00 00 00       	mov    $0x44,%esi
   4312c:	48 8d 05 a2 1f 00 00 	lea    0x1fa2(%rip),%rax        # 450d5 <complex_keymap+0x135>
   43133:	48 89 c7             	mov    %rax,%rdi
   43136:	e8 8f fc ff ff       	call   42dca <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   4313b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4313f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   43143:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43147:	0f 22 d8             	mov    %rax,%cr3
}
   4314a:	90                   	nop
}
   4314b:	90                   	nop
   4314c:	c9                   	leave  
   4314d:	c3                   	ret    

000000000004314e <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   4314e:	f3 0f 1e fa          	endbr64 
   43152:	55                   	push   %rbp
   43153:	48 89 e5             	mov    %rsp,%rbp
   43156:	48 83 ec 50          	sub    $0x50,%rsp
   4315a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4315e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43162:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43166:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   4316a:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4316e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43172:	25 ff 0f 00 00       	and    $0xfff,%eax
   43177:	48 85 c0             	test   %rax,%rax
   4317a:	74 1e                	je     4319a <virtual_memory_map+0x4c>
   4317c:	48 8d 05 43 21 00 00 	lea    0x2143(%rip),%rax        # 452c6 <complex_keymap+0x326>
   43183:	48 89 c2             	mov    %rax,%rdx
   43186:	be 65 00 00 00       	mov    $0x65,%esi
   4318b:	48 8d 05 43 1f 00 00 	lea    0x1f43(%rip),%rax        # 450d5 <complex_keymap+0x135>
   43192:	48 89 c7             	mov    %rax,%rdi
   43195:	e8 30 fc ff ff       	call   42dca <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   4319a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4319e:	25 ff 0f 00 00       	and    $0xfff,%eax
   431a3:	48 85 c0             	test   %rax,%rax
   431a6:	74 1e                	je     431c6 <virtual_memory_map+0x78>
   431a8:	48 8d 05 2a 21 00 00 	lea    0x212a(%rip),%rax        # 452d9 <complex_keymap+0x339>
   431af:	48 89 c2             	mov    %rax,%rdx
   431b2:	be 66 00 00 00       	mov    $0x66,%esi
   431b7:	48 8d 05 17 1f 00 00 	lea    0x1f17(%rip),%rax        # 450d5 <complex_keymap+0x135>
   431be:	48 89 c7             	mov    %rax,%rdi
   431c1:	e8 04 fc ff ff       	call   42dca <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   431c6:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   431ca:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   431ce:	48 01 d0             	add    %rdx,%rax
   431d1:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   431d5:	76 2e                	jbe    43205 <virtual_memory_map+0xb7>
   431d7:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   431db:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   431df:	48 01 d0             	add    %rdx,%rax
   431e2:	48 85 c0             	test   %rax,%rax
   431e5:	74 1e                	je     43205 <virtual_memory_map+0xb7>
   431e7:	48 8d 05 fe 20 00 00 	lea    0x20fe(%rip),%rax        # 452ec <complex_keymap+0x34c>
   431ee:	48 89 c2             	mov    %rax,%rdx
   431f1:	be 67 00 00 00       	mov    $0x67,%esi
   431f6:	48 8d 05 d8 1e 00 00 	lea    0x1ed8(%rip),%rax        # 450d5 <complex_keymap+0x135>
   431fd:	48 89 c7             	mov    %rax,%rdi
   43200:	e8 c5 fb ff ff       	call   42dca <assert_fail>
    if (perm & PTE_P) {
   43205:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43208:	48 98                	cltq   
   4320a:	83 e0 01             	and    $0x1,%eax
   4320d:	48 85 c0             	test   %rax,%rax
   43210:	0f 84 8c 00 00 00    	je     432a2 <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   43216:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4321a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4321f:	48 85 c0             	test   %rax,%rax
   43222:	74 1e                	je     43242 <virtual_memory_map+0xf4>
   43224:	48 8d 05 df 20 00 00 	lea    0x20df(%rip),%rax        # 4530a <complex_keymap+0x36a>
   4322b:	48 89 c2             	mov    %rax,%rdx
   4322e:	be 69 00 00 00       	mov    $0x69,%esi
   43233:	48 8d 05 9b 1e 00 00 	lea    0x1e9b(%rip),%rax        # 450d5 <complex_keymap+0x135>
   4323a:	48 89 c7             	mov    %rax,%rdi
   4323d:	e8 88 fb ff ff       	call   42dca <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   43242:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43246:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4324a:	48 01 d0             	add    %rdx,%rax
   4324d:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   43251:	76 1e                	jbe    43271 <virtual_memory_map+0x123>
   43253:	48 8d 05 c3 20 00 00 	lea    0x20c3(%rip),%rax        # 4531d <complex_keymap+0x37d>
   4325a:	48 89 c2             	mov    %rax,%rdx
   4325d:	be 6a 00 00 00       	mov    $0x6a,%esi
   43262:	48 8d 05 6c 1e 00 00 	lea    0x1e6c(%rip),%rax        # 450d5 <complex_keymap+0x135>
   43269:	48 89 c7             	mov    %rax,%rdi
   4326c:	e8 59 fb ff ff       	call   42dca <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   43271:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43275:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43279:	48 01 d0             	add    %rdx,%rax
   4327c:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   43282:	76 1e                	jbe    432a2 <virtual_memory_map+0x154>
   43284:	48 8d 05 a0 20 00 00 	lea    0x20a0(%rip),%rax        # 4532b <complex_keymap+0x38b>
   4328b:	48 89 c2             	mov    %rax,%rdx
   4328e:	be 6b 00 00 00       	mov    $0x6b,%esi
   43293:	48 8d 05 3b 1e 00 00 	lea    0x1e3b(%rip),%rax        # 450d5 <complex_keymap+0x135>
   4329a:	48 89 c7             	mov    %rax,%rdi
   4329d:	e8 28 fb ff ff       	call   42dca <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   432a2:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   432a6:	78 09                	js     432b1 <virtual_memory_map+0x163>
   432a8:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   432af:	7e 1e                	jle    432cf <virtual_memory_map+0x181>
   432b1:	48 8d 05 8f 20 00 00 	lea    0x208f(%rip),%rax        # 45347 <complex_keymap+0x3a7>
   432b8:	48 89 c2             	mov    %rax,%rdx
   432bb:	be 6d 00 00 00       	mov    $0x6d,%esi
   432c0:	48 8d 05 0e 1e 00 00 	lea    0x1e0e(%rip),%rax        # 450d5 <complex_keymap+0x135>
   432c7:	48 89 c7             	mov    %rax,%rdi
   432ca:	e8 fb fa ff ff       	call   42dca <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   432cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432d3:	25 ff 0f 00 00       	and    $0xfff,%eax
   432d8:	48 85 c0             	test   %rax,%rax
   432db:	74 1e                	je     432fb <virtual_memory_map+0x1ad>
   432dd:	48 8d 05 84 20 00 00 	lea    0x2084(%rip),%rax        # 45368 <complex_keymap+0x3c8>
   432e4:	48 89 c2             	mov    %rax,%rdx
   432e7:	be 6e 00 00 00       	mov    $0x6e,%esi
   432ec:	48 8d 05 e2 1d 00 00 	lea    0x1de2(%rip),%rax        # 450d5 <complex_keymap+0x135>
   432f3:	48 89 c7             	mov    %rax,%rdi
   432f6:	e8 cf fa ff ff       	call   42dca <assert_fail>

    int last_index123 = -1;
   432fb:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   43302:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   43309:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   4330a:	e9 ed 00 00 00       	jmp    433fc <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   4330f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43313:	48 c1 e8 15          	shr    $0x15,%rax
   43317:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   4331a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4331d:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   43320:	74 20                	je     43342 <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   43322:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43325:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   43329:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4332d:	48 89 ce             	mov    %rcx,%rsi
   43330:	48 89 c7             	mov    %rax,%rdi
   43333:	e8 d6 00 00 00       	call   4340e <lookup_l1pagetable>
   43338:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   4333c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4333f:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   43342:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43345:	48 98                	cltq   
   43347:	83 e0 01             	and    $0x1,%eax
   4334a:	48 85 c0             	test   %rax,%rax
   4334d:	74 37                	je     43386 <virtual_memory_map+0x238>
   4334f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43354:	74 30                	je     43386 <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   43356:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4335a:	be 03 00 00 00       	mov    $0x3,%esi
   4335f:	48 89 c7             	mov    %rax,%rdi
   43362:	e8 da fa ff ff       	call   42e41 <pageindex>
   43367:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   4336a:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4336d:	48 98                	cltq   
   4336f:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   43373:	48 89 c1             	mov    %rax,%rcx
   43376:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4337a:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4337d:	48 63 d2             	movslq %edx,%rdx
   43380:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   43384:	eb 5e                	jmp    433e4 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   43386:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4338b:	74 2a                	je     433b7 <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   4338d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43391:	be 03 00 00 00       	mov    $0x3,%esi
   43396:	48 89 c7             	mov    %rax,%rdi
   43399:	e8 a3 fa ff ff       	call   42e41 <pageindex>
   4339e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   433a1:	8b 45 bc             	mov    -0x44(%rbp),%eax
   433a4:	48 63 c8             	movslq %eax,%rcx
   433a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433ab:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   433ae:	48 63 d2             	movslq %edx,%rdx
   433b1:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   433b5:	eb 2d                	jmp    433e4 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   433b7:	8b 45 bc             	mov    -0x44(%rbp),%eax
   433ba:	48 98                	cltq   
   433bc:	83 e0 01             	and    $0x1,%eax
   433bf:	48 85 c0             	test   %rax,%rax
   433c2:	74 20                	je     433e4 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   433c4:	be 87 00 00 00       	mov    $0x87,%esi
   433c9:	48 8d 05 c0 1f 00 00 	lea    0x1fc0(%rip),%rax        # 45390 <complex_keymap+0x3f0>
   433d0:	48 89 c7             	mov    %rax,%rdi
   433d3:	b8 00 00 00 00       	mov    $0x0,%eax
   433d8:	e8 92 f6 ff ff       	call   42a6f <log_printf>
            return -1;
   433dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   433e2:	eb 28                	jmp    4340c <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   433e4:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   433eb:	00 
   433ec:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   433f3:	00 
   433f4:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   433fb:	00 
   433fc:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   43401:	0f 85 08 ff ff ff    	jne    4330f <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   43407:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4340c:	c9                   	leave  
   4340d:	c3                   	ret    

000000000004340e <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   4340e:	f3 0f 1e fa          	endbr64 
   43412:	55                   	push   %rbp
   43413:	48 89 e5             	mov    %rsp,%rbp
   43416:	48 83 ec 40          	sub    $0x40,%rsp
   4341a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4341e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43422:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   43425:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43429:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   4342d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   43434:	e9 4f 01 00 00       	jmp    43588 <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        int index = PAGEINDEX(va, i); // Get the index for the current level
   43439:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4343c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43440:	89 d6                	mov    %edx,%esi
   43442:	48 89 c7             	mov    %rax,%rdi
   43445:	e8 f7 f9 ff ff       	call   42e41 <pageindex>
   4344a:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   4344d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43451:	8b 55 f0             	mov    -0x10(%rbp),%edx
   43454:	48 63 d2             	movslq %edx,%rdx
   43457:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4345b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   4345f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43463:	83 e0 01             	and    $0x1,%eax
   43466:	48 85 c0             	test   %rax,%rax
   43469:	75 6d                	jne    434d8 <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   4346b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4346e:	8d 48 02             	lea    0x2(%rax),%ecx
   43471:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43475:	25 ff 0f 00 00       	and    $0xfff,%eax
   4347a:	48 89 c2             	mov    %rax,%rdx
   4347d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43481:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43487:	48 89 c6             	mov    %rax,%rsi
   4348a:	48 8d 05 47 1f 00 00 	lea    0x1f47(%rip),%rax        # 453d8 <complex_keymap+0x438>
   43491:	48 89 c7             	mov    %rax,%rdi
   43494:	b8 00 00 00 00       	mov    $0x0,%eax
   43499:	e8 d1 f5 ff ff       	call   42a6f <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   4349e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434a1:	48 98                	cltq   
   434a3:	83 e0 01             	and    $0x1,%eax
   434a6:	48 85 c0             	test   %rax,%rax
   434a9:	75 0a                	jne    434b5 <lookup_l1pagetable+0xa7>
                return NULL;
   434ab:	b8 00 00 00 00       	mov    $0x0,%eax
   434b0:	e9 e1 00 00 00       	jmp    43596 <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   434b5:	be ac 00 00 00       	mov    $0xac,%esi
   434ba:	48 8d 05 7f 1f 00 00 	lea    0x1f7f(%rip),%rax        # 45440 <complex_keymap+0x4a0>
   434c1:	48 89 c7             	mov    %rax,%rdi
   434c4:	b8 00 00 00 00       	mov    $0x0,%eax
   434c9:	e8 a1 f5 ff ff       	call   42a6f <log_printf>
            return NULL;
   434ce:	b8 00 00 00 00       	mov    $0x0,%eax
   434d3:	e9 be 00 00 00       	jmp    43596 <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   434d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434dc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   434e2:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   434e8:	76 1e                	jbe    43508 <lookup_l1pagetable+0xfa>
   434ea:	48 8d 05 97 1f 00 00 	lea    0x1f97(%rip),%rax        # 45488 <complex_keymap+0x4e8>
   434f1:	48 89 c2             	mov    %rax,%rdx
   434f4:	be b1 00 00 00       	mov    $0xb1,%esi
   434f9:	48 8d 05 d5 1b 00 00 	lea    0x1bd5(%rip),%rax        # 450d5 <complex_keymap+0x135>
   43500:	48 89 c7             	mov    %rax,%rdi
   43503:	e8 c2 f8 ff ff       	call   42dca <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   43508:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4350b:	48 98                	cltq   
   4350d:	83 e0 02             	and    $0x2,%eax
   43510:	48 85 c0             	test   %rax,%rax
   43513:	74 2a                	je     4353f <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   43515:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43519:	83 e0 02             	and    $0x2,%eax
   4351c:	48 85 c0             	test   %rax,%rax
   4351f:	75 1e                	jne    4353f <lookup_l1pagetable+0x131>
   43521:	48 8d 05 80 1f 00 00 	lea    0x1f80(%rip),%rax        # 454a8 <complex_keymap+0x508>
   43528:	48 89 c2             	mov    %rax,%rdx
   4352b:	be b3 00 00 00       	mov    $0xb3,%esi
   43530:	48 8d 05 9e 1b 00 00 	lea    0x1b9e(%rip),%rax        # 450d5 <complex_keymap+0x135>
   43537:	48 89 c7             	mov    %rax,%rdi
   4353a:	e8 8b f8 ff ff       	call   42dca <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   4353f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43542:	48 98                	cltq   
   43544:	83 e0 04             	and    $0x4,%eax
   43547:	48 85 c0             	test   %rax,%rax
   4354a:	74 2a                	je     43576 <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   4354c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43550:	83 e0 04             	and    $0x4,%eax
   43553:	48 85 c0             	test   %rax,%rax
   43556:	75 1e                	jne    43576 <lookup_l1pagetable+0x168>
   43558:	48 8d 05 54 1f 00 00 	lea    0x1f54(%rip),%rax        # 454b3 <complex_keymap+0x513>
   4355f:	48 89 c2             	mov    %rax,%rdx
   43562:	be b6 00 00 00       	mov    $0xb6,%esi
   43567:	48 8d 05 67 1b 00 00 	lea    0x1b67(%rip),%rax        # 450d5 <complex_keymap+0x135>
   4356e:	48 89 c7             	mov    %rax,%rdi
   43571:	e8 54 f8 ff ff       	call   42dca <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43576:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4357a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43580:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   43584:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   43588:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   4358c:	0f 8e a7 fe ff ff    	jle    43439 <lookup_l1pagetable+0x2b>
    }
    return pt;
   43592:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43596:	c9                   	leave  
   43597:	c3                   	ret    

0000000000043598 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   43598:	f3 0f 1e fa          	endbr64 
   4359c:	55                   	push   %rbp
   4359d:	48 89 e5             	mov    %rsp,%rbp
   435a0:	48 83 ec 50          	sub    $0x50,%rsp
   435a4:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   435a8:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   435ac:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   435b0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   435b4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   435b8:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   435bf:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   435c0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   435c7:	eb 41                	jmp    4360a <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   435c9:	8b 55 ec             	mov    -0x14(%rbp),%edx
   435cc:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   435d0:	89 d6                	mov    %edx,%esi
   435d2:	48 89 c7             	mov    %rax,%rdi
   435d5:	e8 67 f8 ff ff       	call   42e41 <pageindex>
   435da:	89 c2                	mov    %eax,%edx
   435dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435e0:	48 63 d2             	movslq %edx,%rdx
   435e3:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   435e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435eb:	83 e0 06             	and    $0x6,%eax
   435ee:	48 f7 d0             	not    %rax
   435f1:	48 21 d0             	and    %rdx,%rax
   435f4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   435f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435fc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43602:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43606:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   4360a:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4360e:	7f 0c                	jg     4361c <virtual_memory_lookup+0x84>
   43610:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43614:	83 e0 01             	and    $0x1,%eax
   43617:	48 85 c0             	test   %rax,%rax
   4361a:	75 ad                	jne    435c9 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   4361c:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43623:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   4362a:	ff 
   4362b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   43632:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43636:	83 e0 01             	and    $0x1,%eax
   43639:	48 85 c0             	test   %rax,%rax
   4363c:	74 34                	je     43672 <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   4363e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43642:	48 c1 e8 0c          	shr    $0xc,%rax
   43646:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43649:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4364d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43653:	48 89 c2             	mov    %rax,%rdx
   43656:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4365a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4365f:	48 09 d0             	or     %rdx,%rax
   43662:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   43666:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4366a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4366f:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   43672:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43676:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4367a:	48 89 10             	mov    %rdx,(%rax)
   4367d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   43681:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43685:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43689:	48 89 50 10          	mov    %rdx,0x10(%rax)
   4368d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43691:	c9                   	leave  
   43692:	c3                   	ret    

0000000000043693 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   43693:	f3 0f 1e fa          	endbr64 
   43697:	55                   	push   %rbp
   43698:	48 89 e5             	mov    %rsp,%rbp
   4369b:	48 83 ec 40          	sub    $0x40,%rsp
   4369f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   436a3:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   436a6:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   436aa:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   436b1:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   436b5:	78 08                	js     436bf <program_load+0x2c>
   436b7:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   436ba:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   436bd:	7c 1e                	jl     436dd <program_load+0x4a>
   436bf:	48 8d 05 fa 1d 00 00 	lea    0x1dfa(%rip),%rax        # 454c0 <complex_keymap+0x520>
   436c6:	48 89 c2             	mov    %rax,%rdx
   436c9:	be 37 00 00 00       	mov    $0x37,%esi
   436ce:	48 8d 05 1b 1e 00 00 	lea    0x1e1b(%rip),%rax        # 454f0 <complex_keymap+0x550>
   436d5:	48 89 c7             	mov    %rax,%rdi
   436d8:	e8 ed f6 ff ff       	call   42dca <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   436dd:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   436e0:	48 98                	cltq   
   436e2:	48 c1 e0 04          	shl    $0x4,%rax
   436e6:	48 89 c2             	mov    %rax,%rdx
   436e9:	48 8d 05 30 29 00 00 	lea    0x2930(%rip),%rax        # 46020 <ramimages>
   436f0:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   436f4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   436f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436fc:	8b 00                	mov    (%rax),%eax
   436fe:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43703:	74 1e                	je     43723 <program_load+0x90>
   43705:	48 8d 05 f6 1d 00 00 	lea    0x1df6(%rip),%rax        # 45502 <complex_keymap+0x562>
   4370c:	48 89 c2             	mov    %rax,%rdx
   4370f:	be 39 00 00 00       	mov    $0x39,%esi
   43714:	48 8d 05 d5 1d 00 00 	lea    0x1dd5(%rip),%rax        # 454f0 <complex_keymap+0x550>
   4371b:	48 89 c7             	mov    %rax,%rdi
   4371e:	e8 a7 f6 ff ff       	call   42dca <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43723:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43727:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4372b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4372f:	48 01 d0             	add    %rdx,%rax
   43732:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43736:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4373d:	e9 94 00 00 00       	jmp    437d6 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43742:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43745:	48 63 d0             	movslq %eax,%rdx
   43748:	48 89 d0             	mov    %rdx,%rax
   4374b:	48 c1 e0 03          	shl    $0x3,%rax
   4374f:	48 29 d0             	sub    %rdx,%rax
   43752:	48 c1 e0 03          	shl    $0x3,%rax
   43756:	48 89 c2             	mov    %rax,%rdx
   43759:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4375d:	48 01 d0             	add    %rdx,%rax
   43760:	8b 00                	mov    (%rax),%eax
   43762:	83 f8 01             	cmp    $0x1,%eax
   43765:	75 6b                	jne    437d2 <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   43767:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4376a:	48 63 d0             	movslq %eax,%rdx
   4376d:	48 89 d0             	mov    %rdx,%rax
   43770:	48 c1 e0 03          	shl    $0x3,%rax
   43774:	48 29 d0             	sub    %rdx,%rax
   43777:	48 c1 e0 03          	shl    $0x3,%rax
   4377b:	48 89 c2             	mov    %rax,%rdx
   4377e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43782:	48 01 d0             	add    %rdx,%rax
   43785:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43789:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4378d:	48 01 d0             	add    %rdx,%rax
   43790:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   43794:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43797:	48 63 d0             	movslq %eax,%rdx
   4379a:	48 89 d0             	mov    %rdx,%rax
   4379d:	48 c1 e0 03          	shl    $0x3,%rax
   437a1:	48 29 d0             	sub    %rdx,%rax
   437a4:	48 c1 e0 03          	shl    $0x3,%rax
   437a8:	48 89 c2             	mov    %rax,%rdx
   437ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437af:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   437b3:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   437b7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   437bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   437bf:	48 89 c7             	mov    %rax,%rdi
   437c2:	e8 3d 00 00 00       	call   43804 <program_load_segment>
   437c7:	85 c0                	test   %eax,%eax
   437c9:	79 07                	jns    437d2 <program_load+0x13f>
                return -1;
   437cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   437d0:	eb 30                	jmp    43802 <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   437d2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   437d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437da:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   437de:	0f b7 c0             	movzwl %ax,%eax
   437e1:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   437e4:	0f 8c 58 ff ff ff    	jl     43742 <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   437ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437ee:	48 8b 50 18          	mov    0x18(%rax),%rdx
   437f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   437f6:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   437fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43802:	c9                   	leave  
   43803:	c3                   	ret    

0000000000043804 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43804:	f3 0f 1e fa          	endbr64 
   43808:	55                   	push   %rbp
   43809:	48 89 e5             	mov    %rsp,%rbp
   4380c:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   43810:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   43814:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   43818:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   4381c:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   43820:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43824:	48 8b 40 10          	mov    0x10(%rax),%rax
   43828:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4382c:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43830:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43834:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43838:	48 01 d0             	add    %rdx,%rax
   4383b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4383f:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43843:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43847:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4384b:	48 01 d0             	add    %rdx,%rax
   4384e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43852:	48 81 65 e0 00 f0 ff 	andq   $0xfffffffffffff000,-0x20(%rbp)
   43859:	ff 

    int perms = PTE_P | PTE_W | PTE_U;
   4385a:	c7 45 fc 07 00 00 00 	movl   $0x7,-0x4(%rbp)
    if ((ph->p_flags & ELF_PFLAG_WRITE) == 0){
   43861:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43865:	8b 40 04             	mov    0x4(%rax),%eax
   43868:	83 e0 02             	and    $0x2,%eax
   4386b:	85 c0                	test   %eax,%eax
   4386d:	75 07                	jne    43876 <program_load_segment+0x72>
        perms = PTE_P | PTE_U;
   4386f:	c7 45 fc 05 00 00 00 	movl   $0x5,-0x4(%rbp)
    }
    uintptr_t pa = 0;
   43876:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
   4387d:	00 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4387e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43882:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43886:	eb 7d                	jmp    43905 <program_load_segment+0x101>
        pa = find_page(p->p_pid);
   43888:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4388c:	8b 00                	mov    (%rax),%eax
   4388e:	0f be c0             	movsbl %al,%eax
   43891:	89 c7                	mov    %eax,%edi
   43893:	e8 6c cb ff ff       	call   40404 <find_page>
   43898:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   4389c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   438a0:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   438a7:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   438ab:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   438af:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   438b5:	b9 00 10 00 00       	mov    $0x1000,%ecx
   438ba:	48 89 c7             	mov    %rax,%rdi
   438bd:	e8 8c f8 ff ff       	call   4314e <virtual_memory_map>
   438c2:	85 c0                	test   %eax,%eax
   438c4:	79 37                	jns    438fd <program_load_segment+0xf9>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   438c6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   438ca:	8b 00                	mov    (%rax),%eax
   438cc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   438d0:	49 89 d0             	mov    %rdx,%r8
   438d3:	89 c1                	mov    %eax,%ecx
   438d5:	48 8d 05 44 1c 00 00 	lea    0x1c44(%rip),%rax        # 45520 <complex_keymap+0x580>
   438dc:	48 89 c2             	mov    %rax,%rdx
   438df:	be 00 c0 00 00       	mov    $0xc000,%esi
   438e4:	bf e0 06 00 00       	mov    $0x6e0,%edi
   438e9:	b8 00 00 00 00       	mov    $0x0,%eax
   438ee:	e8 6c 10 00 00       	call   4495f <console_printf>
            return -1;
   438f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438f8:	e9 1b 01 00 00       	jmp    43a18 <program_load_segment+0x214>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   438fd:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43904:	00 
   43905:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43909:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4390d:	0f 82 75 ff ff ff    	jb     43888 <program_load_segment+0x84>
        }
    }
    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43913:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43917:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4391e:	48 89 c7             	mov    %rax,%rdi
   43921:	e8 b6 f6 ff ff       	call   42fdc <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43926:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4392a:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4392e:	48 89 c2             	mov    %rax,%rdx
   43931:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43935:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43939:	48 89 ce             	mov    %rcx,%rsi
   4393c:	48 89 c7             	mov    %rax,%rdi
   4393f:	e8 d6 00 00 00       	call   43a1a <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43944:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43948:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
   4394c:	48 89 c2             	mov    %rax,%rdx
   4394f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43953:	be 00 00 00 00       	mov    $0x0,%esi
   43958:	48 89 c7             	mov    %rax,%rdi
   4395b:	e8 c0 01 00 00       	call   43b20 <memset>
    
    // update perms
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43960:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43964:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43968:	e9 89 00 00 00       	jmp    439f6 <program_load_segment+0x1f2>
        vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   4396d:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43971:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   43978:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   4397c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   43980:	48 89 ce             	mov    %rcx,%rsi
   43983:	48 89 c7             	mov    %rax,%rdi
   43986:	e8 0d fc ff ff       	call   43598 <virtual_memory_lookup>
        int r = virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   4398b:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   4398f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43993:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4399a:	8b 4d fc             	mov    -0x4(%rbp),%ecx
   4399d:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   439a1:	41 89 c8             	mov    %ecx,%r8d
   439a4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   439a9:	48 89 c7             	mov    %rax,%rdi
   439ac:	e8 9d f7 ff ff       	call   4314e <virtual_memory_map>
   439b1:	89 45 c4             	mov    %eax,-0x3c(%rbp)
                                  perms);
        if (r < 0){
   439b4:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
   439b8:	79 34                	jns    439ee <program_load_segment+0x1ea>
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   439ba:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   439be:	8b 00                	mov    (%rax),%eax
   439c0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   439c4:	49 89 d0             	mov    %rdx,%r8
   439c7:	89 c1                	mov    %eax,%ecx
   439c9:	48 8d 05 50 1b 00 00 	lea    0x1b50(%rip),%rax        # 45520 <complex_keymap+0x580>
   439d0:	48 89 c2             	mov    %rax,%rdx
   439d3:	be 00 c0 00 00       	mov    $0xc000,%esi
   439d8:	bf e0 06 00 00       	mov    $0x6e0,%edi
   439dd:	b8 00 00 00 00       	mov    $0x0,%eax
   439e2:	e8 78 0f 00 00       	call   4495f <console_printf>
            return -1;
   439e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   439ec:	eb 2a                	jmp    43a18 <program_load_segment+0x214>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   439ee:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   439f5:	00 
   439f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439fa:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   439fe:	0f 82 69 ff ff ff    	jb     4396d <program_load_segment+0x169>
        }
        }


    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43a04:	48 8b 05 f5 15 01 00 	mov    0x115f5(%rip),%rax        # 55000 <kernel_pagetable>
   43a0b:	48 89 c7             	mov    %rax,%rdi
   43a0e:	e8 c9 f5 ff ff       	call   42fdc <set_pagetable>
    return 0;
   43a13:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43a18:	c9                   	leave  
   43a19:	c3                   	ret    

0000000000043a1a <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43a1a:	f3 0f 1e fa          	endbr64 
   43a1e:	55                   	push   %rbp
   43a1f:	48 89 e5             	mov    %rsp,%rbp
   43a22:	48 83 ec 28          	sub    $0x28,%rsp
   43a26:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43a2a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43a2e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43a32:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a36:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43a3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a3e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43a42:	eb 1c                	jmp    43a60 <memcpy+0x46>
        *d = *s;
   43a44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a48:	0f b6 10             	movzbl (%rax),%edx
   43a4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a4f:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43a51:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43a56:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43a5b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43a60:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43a65:	75 dd                	jne    43a44 <memcpy+0x2a>
    }
    return dst;
   43a67:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43a6b:	c9                   	leave  
   43a6c:	c3                   	ret    

0000000000043a6d <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43a6d:	f3 0f 1e fa          	endbr64 
   43a71:	55                   	push   %rbp
   43a72:	48 89 e5             	mov    %rsp,%rbp
   43a75:	48 83 ec 28          	sub    $0x28,%rsp
   43a79:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43a7d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43a81:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43a85:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a89:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43a8d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a91:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43a95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a99:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43a9d:	73 6a                	jae    43b09 <memmove+0x9c>
   43a9f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43aa3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43aa7:	48 01 d0             	add    %rdx,%rax
   43aaa:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43aae:	73 59                	jae    43b09 <memmove+0x9c>
        s += n, d += n;
   43ab0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43ab4:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43ab8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43abc:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43ac0:	eb 17                	jmp    43ad9 <memmove+0x6c>
            *--d = *--s;
   43ac2:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43ac7:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43acc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ad0:	0f b6 10             	movzbl (%rax),%edx
   43ad3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ad7:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43ad9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43add:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43ae1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43ae5:	48 85 c0             	test   %rax,%rax
   43ae8:	75 d8                	jne    43ac2 <memmove+0x55>
    if (s < d && s + n > d) {
   43aea:	eb 2e                	jmp    43b1a <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43aec:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43af0:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43af4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43af8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43afc:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43b00:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43b04:	0f b6 12             	movzbl (%rdx),%edx
   43b07:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43b09:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b0d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43b11:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43b15:	48 85 c0             	test   %rax,%rax
   43b18:	75 d2                	jne    43aec <memmove+0x7f>
        }
    }
    return dst;
   43b1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43b1e:	c9                   	leave  
   43b1f:	c3                   	ret    

0000000000043b20 <memset>:

void* memset(void* v, int c, size_t n) {
   43b20:	f3 0f 1e fa          	endbr64 
   43b24:	55                   	push   %rbp
   43b25:	48 89 e5             	mov    %rsp,%rbp
   43b28:	48 83 ec 28          	sub    $0x28,%rsp
   43b2c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b30:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43b33:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43b37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b3b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43b3f:	eb 15                	jmp    43b56 <memset+0x36>
        *p = c;
   43b41:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43b44:	89 c2                	mov    %eax,%edx
   43b46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b4a:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43b4c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43b51:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43b56:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43b5b:	75 e4                	jne    43b41 <memset+0x21>
    }
    return v;
   43b5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43b61:	c9                   	leave  
   43b62:	c3                   	ret    

0000000000043b63 <strlen>:

size_t strlen(const char* s) {
   43b63:	f3 0f 1e fa          	endbr64 
   43b67:	55                   	push   %rbp
   43b68:	48 89 e5             	mov    %rsp,%rbp
   43b6b:	48 83 ec 18          	sub    $0x18,%rsp
   43b6f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43b73:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43b7a:	00 
   43b7b:	eb 0a                	jmp    43b87 <strlen+0x24>
        ++n;
   43b7d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43b82:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43b87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b8b:	0f b6 00             	movzbl (%rax),%eax
   43b8e:	84 c0                	test   %al,%al
   43b90:	75 eb                	jne    43b7d <strlen+0x1a>
    }
    return n;
   43b92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43b96:	c9                   	leave  
   43b97:	c3                   	ret    

0000000000043b98 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43b98:	f3 0f 1e fa          	endbr64 
   43b9c:	55                   	push   %rbp
   43b9d:	48 89 e5             	mov    %rsp,%rbp
   43ba0:	48 83 ec 20          	sub    $0x20,%rsp
   43ba4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43ba8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43bac:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43bb3:	00 
   43bb4:	eb 0a                	jmp    43bc0 <strnlen+0x28>
        ++n;
   43bb6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43bbb:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43bc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bc4:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43bc8:	74 0b                	je     43bd5 <strnlen+0x3d>
   43bca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bce:	0f b6 00             	movzbl (%rax),%eax
   43bd1:	84 c0                	test   %al,%al
   43bd3:	75 e1                	jne    43bb6 <strnlen+0x1e>
    }
    return n;
   43bd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43bd9:	c9                   	leave  
   43bda:	c3                   	ret    

0000000000043bdb <strcpy>:

char* strcpy(char* dst, const char* src) {
   43bdb:	f3 0f 1e fa          	endbr64 
   43bdf:	55                   	push   %rbp
   43be0:	48 89 e5             	mov    %rsp,%rbp
   43be3:	48 83 ec 20          	sub    $0x20,%rsp
   43be7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43beb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43bef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bf3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43bf7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43bfb:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43bff:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43c03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c07:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43c0b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43c0f:	0f b6 12             	movzbl (%rdx),%edx
   43c12:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43c14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c18:	48 83 e8 01          	sub    $0x1,%rax
   43c1c:	0f b6 00             	movzbl (%rax),%eax
   43c1f:	84 c0                	test   %al,%al
   43c21:	75 d4                	jne    43bf7 <strcpy+0x1c>
    return dst;
   43c23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43c27:	c9                   	leave  
   43c28:	c3                   	ret    

0000000000043c29 <strcmp>:

int strcmp(const char* a, const char* b) {
   43c29:	f3 0f 1e fa          	endbr64 
   43c2d:	55                   	push   %rbp
   43c2e:	48 89 e5             	mov    %rsp,%rbp
   43c31:	48 83 ec 10          	sub    $0x10,%rsp
   43c35:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43c39:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43c3d:	eb 0a                	jmp    43c49 <strcmp+0x20>
        ++a, ++b;
   43c3f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43c44:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43c49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c4d:	0f b6 00             	movzbl (%rax),%eax
   43c50:	84 c0                	test   %al,%al
   43c52:	74 1d                	je     43c71 <strcmp+0x48>
   43c54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c58:	0f b6 00             	movzbl (%rax),%eax
   43c5b:	84 c0                	test   %al,%al
   43c5d:	74 12                	je     43c71 <strcmp+0x48>
   43c5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c63:	0f b6 10             	movzbl (%rax),%edx
   43c66:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c6a:	0f b6 00             	movzbl (%rax),%eax
   43c6d:	38 c2                	cmp    %al,%dl
   43c6f:	74 ce                	je     43c3f <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43c71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c75:	0f b6 00             	movzbl (%rax),%eax
   43c78:	89 c2                	mov    %eax,%edx
   43c7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c7e:	0f b6 00             	movzbl (%rax),%eax
   43c81:	38 c2                	cmp    %al,%dl
   43c83:	0f 97 c0             	seta   %al
   43c86:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43c89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c8d:	0f b6 00             	movzbl (%rax),%eax
   43c90:	89 c1                	mov    %eax,%ecx
   43c92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c96:	0f b6 00             	movzbl (%rax),%eax
   43c99:	38 c1                	cmp    %al,%cl
   43c9b:	0f 92 c0             	setb   %al
   43c9e:	0f b6 c8             	movzbl %al,%ecx
   43ca1:	89 d0                	mov    %edx,%eax
   43ca3:	29 c8                	sub    %ecx,%eax
}
   43ca5:	c9                   	leave  
   43ca6:	c3                   	ret    

0000000000043ca7 <strchr>:

char* strchr(const char* s, int c) {
   43ca7:	f3 0f 1e fa          	endbr64 
   43cab:	55                   	push   %rbp
   43cac:	48 89 e5             	mov    %rsp,%rbp
   43caf:	48 83 ec 10          	sub    $0x10,%rsp
   43cb3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43cb7:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43cba:	eb 05                	jmp    43cc1 <strchr+0x1a>
        ++s;
   43cbc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43cc1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cc5:	0f b6 00             	movzbl (%rax),%eax
   43cc8:	84 c0                	test   %al,%al
   43cca:	74 0e                	je     43cda <strchr+0x33>
   43ccc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cd0:	0f b6 00             	movzbl (%rax),%eax
   43cd3:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43cd6:	38 d0                	cmp    %dl,%al
   43cd8:	75 e2                	jne    43cbc <strchr+0x15>
    }
    if (*s == (char) c) {
   43cda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cde:	0f b6 00             	movzbl (%rax),%eax
   43ce1:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43ce4:	38 d0                	cmp    %dl,%al
   43ce6:	75 06                	jne    43cee <strchr+0x47>
        return (char*) s;
   43ce8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cec:	eb 05                	jmp    43cf3 <strchr+0x4c>
    } else {
        return NULL;
   43cee:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43cf3:	c9                   	leave  
   43cf4:	c3                   	ret    

0000000000043cf5 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43cf5:	f3 0f 1e fa          	endbr64 
   43cf9:	55                   	push   %rbp
   43cfa:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43cfd:	8b 05 fd 72 01 00    	mov    0x172fd(%rip),%eax        # 5b000 <rand_seed_set>
   43d03:	85 c0                	test   %eax,%eax
   43d05:	75 0a                	jne    43d11 <rand+0x1c>
        srand(819234718U);
   43d07:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43d0c:	e8 24 00 00 00       	call   43d35 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43d11:	8b 05 ed 72 01 00    	mov    0x172ed(%rip),%eax        # 5b004 <rand_seed>
   43d17:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43d1d:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43d22:	89 05 dc 72 01 00    	mov    %eax,0x172dc(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   43d28:	8b 05 d6 72 01 00    	mov    0x172d6(%rip),%eax        # 5b004 <rand_seed>
   43d2e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43d33:	5d                   	pop    %rbp
   43d34:	c3                   	ret    

0000000000043d35 <srand>:

void srand(unsigned seed) {
   43d35:	f3 0f 1e fa          	endbr64 
   43d39:	55                   	push   %rbp
   43d3a:	48 89 e5             	mov    %rsp,%rbp
   43d3d:	48 83 ec 08          	sub    $0x8,%rsp
   43d41:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43d44:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43d47:	89 05 b7 72 01 00    	mov    %eax,0x172b7(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   43d4d:	c7 05 a9 72 01 00 01 	movl   $0x1,0x172a9(%rip)        # 5b000 <rand_seed_set>
   43d54:	00 00 00 
}
   43d57:	90                   	nop
   43d58:	c9                   	leave  
   43d59:	c3                   	ret    

0000000000043d5a <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43d5a:	f3 0f 1e fa          	endbr64 
   43d5e:	55                   	push   %rbp
   43d5f:	48 89 e5             	mov    %rsp,%rbp
   43d62:	48 83 ec 28          	sub    $0x28,%rsp
   43d66:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d6a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43d6e:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43d71:	48 8d 05 e8 18 00 00 	lea    0x18e8(%rip),%rax        # 45660 <upper_digits.1>
   43d78:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   43d7c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43d80:	79 0e                	jns    43d90 <fill_numbuf+0x36>
        digits = lower_digits;
   43d82:	48 8d 05 f7 18 00 00 	lea    0x18f7(%rip),%rax        # 45680 <lower_digits.0>
   43d89:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   43d8d:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43d90:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43d95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d99:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43d9c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43d9f:	48 63 c8             	movslq %eax,%rcx
   43da2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43da6:	ba 00 00 00 00       	mov    $0x0,%edx
   43dab:	48 f7 f1             	div    %rcx
   43dae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43db2:	48 01 d0             	add    %rdx,%rax
   43db5:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43dba:	0f b6 10             	movzbl (%rax),%edx
   43dbd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43dc1:	88 10                	mov    %dl,(%rax)
        val /= base;
   43dc3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43dc6:	48 63 f0             	movslq %eax,%rsi
   43dc9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43dcd:	ba 00 00 00 00       	mov    $0x0,%edx
   43dd2:	48 f7 f6             	div    %rsi
   43dd5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43dd9:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43dde:	75 bc                	jne    43d9c <fill_numbuf+0x42>
    return numbuf_end;
   43de0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43de4:	c9                   	leave  
   43de5:	c3                   	ret    

0000000000043de6 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43de6:	f3 0f 1e fa          	endbr64 
   43dea:	55                   	push   %rbp
   43deb:	48 89 e5             	mov    %rsp,%rbp
   43dee:	53                   	push   %rbx
   43def:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43df6:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43dfd:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43e03:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43e0a:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43e11:	e9 bd 09 00 00       	jmp    447d3 <printer_vprintf+0x9ed>
        if (*format != '%') {
   43e16:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e1d:	0f b6 00             	movzbl (%rax),%eax
   43e20:	3c 25                	cmp    $0x25,%al
   43e22:	74 31                	je     43e55 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   43e24:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43e2b:	4c 8b 00             	mov    (%rax),%r8
   43e2e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e35:	0f b6 00             	movzbl (%rax),%eax
   43e38:	0f b6 c8             	movzbl %al,%ecx
   43e3b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43e41:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43e48:	89 ce                	mov    %ecx,%esi
   43e4a:	48 89 c7             	mov    %rax,%rdi
   43e4d:	41 ff d0             	call   *%r8
            continue;
   43e50:	e9 76 09 00 00       	jmp    447cb <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   43e55:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43e5c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43e63:	01 
   43e64:	eb 4d                	jmp    43eb3 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   43e66:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e6d:	0f b6 00             	movzbl (%rax),%eax
   43e70:	0f be c0             	movsbl %al,%eax
   43e73:	89 c6                	mov    %eax,%esi
   43e75:	48 8d 05 e4 16 00 00 	lea    0x16e4(%rip),%rax        # 45560 <flag_chars>
   43e7c:	48 89 c7             	mov    %rax,%rdi
   43e7f:	e8 23 fe ff ff       	call   43ca7 <strchr>
   43e84:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43e88:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43e8d:	74 34                	je     43ec3 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   43e8f:	48 8d 15 ca 16 00 00 	lea    0x16ca(%rip),%rdx        # 45560 <flag_chars>
   43e96:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43e9a:	48 29 d0             	sub    %rdx,%rax
   43e9d:	ba 01 00 00 00       	mov    $0x1,%edx
   43ea2:	89 c1                	mov    %eax,%ecx
   43ea4:	d3 e2                	shl    %cl,%edx
   43ea6:	89 d0                	mov    %edx,%eax
   43ea8:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43eab:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43eb2:	01 
   43eb3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43eba:	0f b6 00             	movzbl (%rax),%eax
   43ebd:	84 c0                	test   %al,%al
   43ebf:	75 a5                	jne    43e66 <printer_vprintf+0x80>
   43ec1:	eb 01                	jmp    43ec4 <printer_vprintf+0xde>
            } else {
                break;
   43ec3:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43ec4:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43ecb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ed2:	0f b6 00             	movzbl (%rax),%eax
   43ed5:	3c 30                	cmp    $0x30,%al
   43ed7:	7e 67                	jle    43f40 <printer_vprintf+0x15a>
   43ed9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ee0:	0f b6 00             	movzbl (%rax),%eax
   43ee3:	3c 39                	cmp    $0x39,%al
   43ee5:	7f 59                	jg     43f40 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43ee7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43eee:	eb 2e                	jmp    43f1e <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   43ef0:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43ef3:	89 d0                	mov    %edx,%eax
   43ef5:	c1 e0 02             	shl    $0x2,%eax
   43ef8:	01 d0                	add    %edx,%eax
   43efa:	01 c0                	add    %eax,%eax
   43efc:	89 c1                	mov    %eax,%ecx
   43efe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f05:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43f09:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43f10:	0f b6 00             	movzbl (%rax),%eax
   43f13:	0f be c0             	movsbl %al,%eax
   43f16:	01 c8                	add    %ecx,%eax
   43f18:	83 e8 30             	sub    $0x30,%eax
   43f1b:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43f1e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f25:	0f b6 00             	movzbl (%rax),%eax
   43f28:	3c 2f                	cmp    $0x2f,%al
   43f2a:	0f 8e 85 00 00 00    	jle    43fb5 <printer_vprintf+0x1cf>
   43f30:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f37:	0f b6 00             	movzbl (%rax),%eax
   43f3a:	3c 39                	cmp    $0x39,%al
   43f3c:	7e b2                	jle    43ef0 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   43f3e:	eb 75                	jmp    43fb5 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   43f40:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f47:	0f b6 00             	movzbl (%rax),%eax
   43f4a:	3c 2a                	cmp    $0x2a,%al
   43f4c:	75 68                	jne    43fb6 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   43f4e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f55:	8b 00                	mov    (%rax),%eax
   43f57:	83 f8 2f             	cmp    $0x2f,%eax
   43f5a:	77 30                	ja     43f8c <printer_vprintf+0x1a6>
   43f5c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f63:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f67:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f6e:	8b 00                	mov    (%rax),%eax
   43f70:	89 c0                	mov    %eax,%eax
   43f72:	48 01 d0             	add    %rdx,%rax
   43f75:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f7c:	8b 12                	mov    (%rdx),%edx
   43f7e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f88:	89 0a                	mov    %ecx,(%rdx)
   43f8a:	eb 1a                	jmp    43fa6 <printer_vprintf+0x1c0>
   43f8c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f93:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f97:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fa2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43fa6:	8b 00                	mov    (%rax),%eax
   43fa8:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43fab:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fb2:	01 
   43fb3:	eb 01                	jmp    43fb6 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   43fb5:	90                   	nop
        }

        // process precision
        int precision = -1;
   43fb6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43fbd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fc4:	0f b6 00             	movzbl (%rax),%eax
   43fc7:	3c 2e                	cmp    $0x2e,%al
   43fc9:	0f 85 00 01 00 00    	jne    440cf <printer_vprintf+0x2e9>
            ++format;
   43fcf:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fd6:	01 
            if (*format >= '0' && *format <= '9') {
   43fd7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fde:	0f b6 00             	movzbl (%rax),%eax
   43fe1:	3c 2f                	cmp    $0x2f,%al
   43fe3:	7e 67                	jle    4404c <printer_vprintf+0x266>
   43fe5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fec:	0f b6 00             	movzbl (%rax),%eax
   43fef:	3c 39                	cmp    $0x39,%al
   43ff1:	7f 59                	jg     4404c <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43ff3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43ffa:	eb 2e                	jmp    4402a <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   43ffc:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43fff:	89 d0                	mov    %edx,%eax
   44001:	c1 e0 02             	shl    $0x2,%eax
   44004:	01 d0                	add    %edx,%eax
   44006:	01 c0                	add    %eax,%eax
   44008:	89 c1                	mov    %eax,%ecx
   4400a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44011:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44015:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4401c:	0f b6 00             	movzbl (%rax),%eax
   4401f:	0f be c0             	movsbl %al,%eax
   44022:	01 c8                	add    %ecx,%eax
   44024:	83 e8 30             	sub    $0x30,%eax
   44027:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4402a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44031:	0f b6 00             	movzbl (%rax),%eax
   44034:	3c 2f                	cmp    $0x2f,%al
   44036:	0f 8e 85 00 00 00    	jle    440c1 <printer_vprintf+0x2db>
   4403c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44043:	0f b6 00             	movzbl (%rax),%eax
   44046:	3c 39                	cmp    $0x39,%al
   44048:	7e b2                	jle    43ffc <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   4404a:	eb 75                	jmp    440c1 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   4404c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44053:	0f b6 00             	movzbl (%rax),%eax
   44056:	3c 2a                	cmp    $0x2a,%al
   44058:	75 68                	jne    440c2 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   4405a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44061:	8b 00                	mov    (%rax),%eax
   44063:	83 f8 2f             	cmp    $0x2f,%eax
   44066:	77 30                	ja     44098 <printer_vprintf+0x2b2>
   44068:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4406f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44073:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4407a:	8b 00                	mov    (%rax),%eax
   4407c:	89 c0                	mov    %eax,%eax
   4407e:	48 01 d0             	add    %rdx,%rax
   44081:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44088:	8b 12                	mov    (%rdx),%edx
   4408a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4408d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44094:	89 0a                	mov    %ecx,(%rdx)
   44096:	eb 1a                	jmp    440b2 <printer_vprintf+0x2cc>
   44098:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4409f:	48 8b 40 08          	mov    0x8(%rax),%rax
   440a3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   440a7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440ae:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440b2:	8b 00                	mov    (%rax),%eax
   440b4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   440b7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   440be:	01 
   440bf:	eb 01                	jmp    440c2 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   440c1:	90                   	nop
            }
            if (precision < 0) {
   440c2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   440c6:	79 07                	jns    440cf <printer_vprintf+0x2e9>
                precision = 0;
   440c8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   440cf:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   440d6:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   440dd:	00 
        int length = 0;
   440de:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   440e5:	48 8d 05 7a 14 00 00 	lea    0x147a(%rip),%rax        # 45566 <flag_chars+0x6>
   440ec:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   440f0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440f7:	0f b6 00             	movzbl (%rax),%eax
   440fa:	0f be c0             	movsbl %al,%eax
   440fd:	83 e8 43             	sub    $0x43,%eax
   44100:	83 f8 37             	cmp    $0x37,%eax
   44103:	0f 87 b6 03 00 00    	ja     444bf <printer_vprintf+0x6d9>
   44109:	89 c0                	mov    %eax,%eax
   4410b:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   44112:	00 
   44113:	48 8d 05 5a 14 00 00 	lea    0x145a(%rip),%rax        # 45574 <flag_chars+0x14>
   4411a:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4411d:	48 98                	cltq   
   4411f:	48 8d 15 4e 14 00 00 	lea    0x144e(%rip),%rdx        # 45574 <flag_chars+0x14>
   44126:	48 01 d0             	add    %rdx,%rax
   44129:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   4412c:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   44133:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4413a:	01 
            goto again;
   4413b:	eb b3                	jmp    440f0 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   4413d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44141:	74 5d                	je     441a0 <printer_vprintf+0x3ba>
   44143:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4414a:	8b 00                	mov    (%rax),%eax
   4414c:	83 f8 2f             	cmp    $0x2f,%eax
   4414f:	77 30                	ja     44181 <printer_vprintf+0x39b>
   44151:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44158:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4415c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44163:	8b 00                	mov    (%rax),%eax
   44165:	89 c0                	mov    %eax,%eax
   44167:	48 01 d0             	add    %rdx,%rax
   4416a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44171:	8b 12                	mov    (%rdx),%edx
   44173:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44176:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4417d:	89 0a                	mov    %ecx,(%rdx)
   4417f:	eb 1a                	jmp    4419b <printer_vprintf+0x3b5>
   44181:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44188:	48 8b 40 08          	mov    0x8(%rax),%rax
   4418c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44190:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44197:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4419b:	48 8b 00             	mov    (%rax),%rax
   4419e:	eb 5c                	jmp    441fc <printer_vprintf+0x416>
   441a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441a7:	8b 00                	mov    (%rax),%eax
   441a9:	83 f8 2f             	cmp    $0x2f,%eax
   441ac:	77 30                	ja     441de <printer_vprintf+0x3f8>
   441ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441b5:	48 8b 50 10          	mov    0x10(%rax),%rdx
   441b9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441c0:	8b 00                	mov    (%rax),%eax
   441c2:	89 c0                	mov    %eax,%eax
   441c4:	48 01 d0             	add    %rdx,%rax
   441c7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441ce:	8b 12                	mov    (%rdx),%edx
   441d0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   441d3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441da:	89 0a                	mov    %ecx,(%rdx)
   441dc:	eb 1a                	jmp    441f8 <printer_vprintf+0x412>
   441de:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441e5:	48 8b 40 08          	mov    0x8(%rax),%rax
   441e9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441ed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441f4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441f8:	8b 00                	mov    (%rax),%eax
   441fa:	48 98                	cltq   
   441fc:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   44200:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44204:	48 c1 f8 38          	sar    $0x38,%rax
   44208:	25 80 00 00 00       	and    $0x80,%eax
   4420d:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   44210:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   44214:	74 09                	je     4421f <printer_vprintf+0x439>
   44216:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4421a:	48 f7 d8             	neg    %rax
   4421d:	eb 04                	jmp    44223 <printer_vprintf+0x43d>
   4421f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44223:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   44227:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   4422a:	83 c8 60             	or     $0x60,%eax
   4422d:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   44230:	e9 cf 02 00 00       	jmp    44504 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   44235:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44239:	74 5d                	je     44298 <printer_vprintf+0x4b2>
   4423b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44242:	8b 00                	mov    (%rax),%eax
   44244:	83 f8 2f             	cmp    $0x2f,%eax
   44247:	77 30                	ja     44279 <printer_vprintf+0x493>
   44249:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44250:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44254:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4425b:	8b 00                	mov    (%rax),%eax
   4425d:	89 c0                	mov    %eax,%eax
   4425f:	48 01 d0             	add    %rdx,%rax
   44262:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44269:	8b 12                	mov    (%rdx),%edx
   4426b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4426e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44275:	89 0a                	mov    %ecx,(%rdx)
   44277:	eb 1a                	jmp    44293 <printer_vprintf+0x4ad>
   44279:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44280:	48 8b 40 08          	mov    0x8(%rax),%rax
   44284:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44288:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4428f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44293:	48 8b 00             	mov    (%rax),%rax
   44296:	eb 5c                	jmp    442f4 <printer_vprintf+0x50e>
   44298:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4429f:	8b 00                	mov    (%rax),%eax
   442a1:	83 f8 2f             	cmp    $0x2f,%eax
   442a4:	77 30                	ja     442d6 <printer_vprintf+0x4f0>
   442a6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442ad:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442b8:	8b 00                	mov    (%rax),%eax
   442ba:	89 c0                	mov    %eax,%eax
   442bc:	48 01 d0             	add    %rdx,%rax
   442bf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442c6:	8b 12                	mov    (%rdx),%edx
   442c8:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442cb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442d2:	89 0a                	mov    %ecx,(%rdx)
   442d4:	eb 1a                	jmp    442f0 <printer_vprintf+0x50a>
   442d6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442dd:	48 8b 40 08          	mov    0x8(%rax),%rax
   442e1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442e5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442ec:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442f0:	8b 00                	mov    (%rax),%eax
   442f2:	89 c0                	mov    %eax,%eax
   442f4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   442f8:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   442fc:	e9 03 02 00 00       	jmp    44504 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   44301:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   44308:	e9 28 ff ff ff       	jmp    44235 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   4430d:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   44314:	e9 1c ff ff ff       	jmp    44235 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44319:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44320:	8b 00                	mov    (%rax),%eax
   44322:	83 f8 2f             	cmp    $0x2f,%eax
   44325:	77 30                	ja     44357 <printer_vprintf+0x571>
   44327:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4432e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44332:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44339:	8b 00                	mov    (%rax),%eax
   4433b:	89 c0                	mov    %eax,%eax
   4433d:	48 01 d0             	add    %rdx,%rax
   44340:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44347:	8b 12                	mov    (%rdx),%edx
   44349:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4434c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44353:	89 0a                	mov    %ecx,(%rdx)
   44355:	eb 1a                	jmp    44371 <printer_vprintf+0x58b>
   44357:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4435e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44362:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44366:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4436d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44371:	48 8b 00             	mov    (%rax),%rax
   44374:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   44378:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   4437f:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   44386:	e9 79 01 00 00       	jmp    44504 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   4438b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44392:	8b 00                	mov    (%rax),%eax
   44394:	83 f8 2f             	cmp    $0x2f,%eax
   44397:	77 30                	ja     443c9 <printer_vprintf+0x5e3>
   44399:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443a0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   443a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ab:	8b 00                	mov    (%rax),%eax
   443ad:	89 c0                	mov    %eax,%eax
   443af:	48 01 d0             	add    %rdx,%rax
   443b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443b9:	8b 12                	mov    (%rdx),%edx
   443bb:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443c5:	89 0a                	mov    %ecx,(%rdx)
   443c7:	eb 1a                	jmp    443e3 <printer_vprintf+0x5fd>
   443c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443d0:	48 8b 40 08          	mov    0x8(%rax),%rax
   443d4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443d8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443e3:	48 8b 00             	mov    (%rax),%rax
   443e6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   443ea:	e9 15 01 00 00       	jmp    44504 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   443ef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443f6:	8b 00                	mov    (%rax),%eax
   443f8:	83 f8 2f             	cmp    $0x2f,%eax
   443fb:	77 30                	ja     4442d <printer_vprintf+0x647>
   443fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44404:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44408:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4440f:	8b 00                	mov    (%rax),%eax
   44411:	89 c0                	mov    %eax,%eax
   44413:	48 01 d0             	add    %rdx,%rax
   44416:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4441d:	8b 12                	mov    (%rdx),%edx
   4441f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44422:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44429:	89 0a                	mov    %ecx,(%rdx)
   4442b:	eb 1a                	jmp    44447 <printer_vprintf+0x661>
   4442d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44434:	48 8b 40 08          	mov    0x8(%rax),%rax
   44438:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4443c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44443:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44447:	8b 00                	mov    (%rax),%eax
   44449:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   4444f:	e9 77 03 00 00       	jmp    447cb <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   44454:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44458:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   4445c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44463:	8b 00                	mov    (%rax),%eax
   44465:	83 f8 2f             	cmp    $0x2f,%eax
   44468:	77 30                	ja     4449a <printer_vprintf+0x6b4>
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
   44498:	eb 1a                	jmp    444b4 <printer_vprintf+0x6ce>
   4449a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444a1:	48 8b 40 08          	mov    0x8(%rax),%rax
   444a5:	48 8d 48 08          	lea    0x8(%rax),%rcx
   444a9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444b0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444b4:	8b 00                	mov    (%rax),%eax
   444b6:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   444b9:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   444bd:	eb 45                	jmp    44504 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   444bf:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   444c3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   444c7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   444ce:	0f b6 00             	movzbl (%rax),%eax
   444d1:	84 c0                	test   %al,%al
   444d3:	74 0c                	je     444e1 <printer_vprintf+0x6fb>
   444d5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   444dc:	0f b6 00             	movzbl (%rax),%eax
   444df:	eb 05                	jmp    444e6 <printer_vprintf+0x700>
   444e1:	b8 25 00 00 00       	mov    $0x25,%eax
   444e6:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   444e9:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   444ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   444f4:	0f b6 00             	movzbl (%rax),%eax
   444f7:	84 c0                	test   %al,%al
   444f9:	75 08                	jne    44503 <printer_vprintf+0x71d>
                format--;
   444fb:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44502:	01 
            }
            break;
   44503:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44504:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44507:	83 e0 20             	and    $0x20,%eax
   4450a:	85 c0                	test   %eax,%eax
   4450c:	74 1e                	je     4452c <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   4450e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44512:	48 83 c0 18          	add    $0x18,%rax
   44516:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44519:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4451d:	48 89 ce             	mov    %rcx,%rsi
   44520:	48 89 c7             	mov    %rax,%rdi
   44523:	e8 32 f8 ff ff       	call   43d5a <fill_numbuf>
   44528:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   4452c:	48 8d 05 33 10 00 00 	lea    0x1033(%rip),%rax        # 45566 <flag_chars+0x6>
   44533:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44537:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4453a:	83 e0 20             	and    $0x20,%eax
   4453d:	85 c0                	test   %eax,%eax
   4453f:	74 51                	je     44592 <printer_vprintf+0x7ac>
   44541:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44544:	83 e0 40             	and    $0x40,%eax
   44547:	85 c0                	test   %eax,%eax
   44549:	74 47                	je     44592 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   4454b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4454e:	25 80 00 00 00       	and    $0x80,%eax
   44553:	85 c0                	test   %eax,%eax
   44555:	74 0d                	je     44564 <printer_vprintf+0x77e>
                prefix = "-";
   44557:	48 8d 05 09 10 00 00 	lea    0x1009(%rip),%rax        # 45567 <flag_chars+0x7>
   4455e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44562:	eb 7d                	jmp    445e1 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44564:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44567:	83 e0 10             	and    $0x10,%eax
   4456a:	85 c0                	test   %eax,%eax
   4456c:	74 0d                	je     4457b <printer_vprintf+0x795>
                prefix = "+";
   4456e:	48 8d 05 f4 0f 00 00 	lea    0xff4(%rip),%rax        # 45569 <flag_chars+0x9>
   44575:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44579:	eb 66                	jmp    445e1 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   4457b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4457e:	83 e0 08             	and    $0x8,%eax
   44581:	85 c0                	test   %eax,%eax
   44583:	74 5c                	je     445e1 <printer_vprintf+0x7fb>
                prefix = " ";
   44585:	48 8d 05 df 0f 00 00 	lea    0xfdf(%rip),%rax        # 4556b <flag_chars+0xb>
   4458c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44590:	eb 4f                	jmp    445e1 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44592:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44595:	83 e0 20             	and    $0x20,%eax
   44598:	85 c0                	test   %eax,%eax
   4459a:	74 46                	je     445e2 <printer_vprintf+0x7fc>
   4459c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4459f:	83 e0 01             	and    $0x1,%eax
   445a2:	85 c0                	test   %eax,%eax
   445a4:	74 3c                	je     445e2 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   445a6:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   445aa:	74 06                	je     445b2 <printer_vprintf+0x7cc>
   445ac:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   445b0:	75 30                	jne    445e2 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   445b2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   445b7:	75 0c                	jne    445c5 <printer_vprintf+0x7df>
   445b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   445bc:	25 00 01 00 00       	and    $0x100,%eax
   445c1:	85 c0                	test   %eax,%eax
   445c3:	74 1d                	je     445e2 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   445c5:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   445c9:	75 09                	jne    445d4 <printer_vprintf+0x7ee>
   445cb:	48 8d 05 9b 0f 00 00 	lea    0xf9b(%rip),%rax        # 4556d <flag_chars+0xd>
   445d2:	eb 07                	jmp    445db <printer_vprintf+0x7f5>
   445d4:	48 8d 05 95 0f 00 00 	lea    0xf95(%rip),%rax        # 45570 <flag_chars+0x10>
   445db:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   445df:	eb 01                	jmp    445e2 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   445e1:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   445e2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   445e6:	78 24                	js     4460c <printer_vprintf+0x826>
   445e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   445eb:	83 e0 20             	and    $0x20,%eax
   445ee:	85 c0                	test   %eax,%eax
   445f0:	75 1a                	jne    4460c <printer_vprintf+0x826>
            len = strnlen(data, precision);
   445f2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   445f5:	48 63 d0             	movslq %eax,%rdx
   445f8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   445fc:	48 89 d6             	mov    %rdx,%rsi
   445ff:	48 89 c7             	mov    %rax,%rdi
   44602:	e8 91 f5 ff ff       	call   43b98 <strnlen>
   44607:	89 45 bc             	mov    %eax,-0x44(%rbp)
   4460a:	eb 0f                	jmp    4461b <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   4460c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44610:	48 89 c7             	mov    %rax,%rdi
   44613:	e8 4b f5 ff ff       	call   43b63 <strlen>
   44618:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   4461b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4461e:	83 e0 20             	and    $0x20,%eax
   44621:	85 c0                	test   %eax,%eax
   44623:	74 20                	je     44645 <printer_vprintf+0x85f>
   44625:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44629:	78 1a                	js     44645 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   4462b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4462e:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44631:	7e 08                	jle    4463b <printer_vprintf+0x855>
   44633:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44636:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44639:	eb 05                	jmp    44640 <printer_vprintf+0x85a>
   4463b:	b8 00 00 00 00       	mov    $0x0,%eax
   44640:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44643:	eb 5c                	jmp    446a1 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44645:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44648:	83 e0 20             	and    $0x20,%eax
   4464b:	85 c0                	test   %eax,%eax
   4464d:	74 4b                	je     4469a <printer_vprintf+0x8b4>
   4464f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44652:	83 e0 02             	and    $0x2,%eax
   44655:	85 c0                	test   %eax,%eax
   44657:	74 41                	je     4469a <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44659:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4465c:	83 e0 04             	and    $0x4,%eax
   4465f:	85 c0                	test   %eax,%eax
   44661:	75 37                	jne    4469a <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   44663:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44667:	48 89 c7             	mov    %rax,%rdi
   4466a:	e8 f4 f4 ff ff       	call   43b63 <strlen>
   4466f:	89 c2                	mov    %eax,%edx
   44671:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44674:	01 d0                	add    %edx,%eax
   44676:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44679:	7e 1f                	jle    4469a <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   4467b:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4467e:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44681:	89 c3                	mov    %eax,%ebx
   44683:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44687:	48 89 c7             	mov    %rax,%rdi
   4468a:	e8 d4 f4 ff ff       	call   43b63 <strlen>
   4468f:	89 c2                	mov    %eax,%edx
   44691:	89 d8                	mov    %ebx,%eax
   44693:	29 d0                	sub    %edx,%eax
   44695:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44698:	eb 07                	jmp    446a1 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   4469a:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   446a1:	8b 55 bc             	mov    -0x44(%rbp),%edx
   446a4:	8b 45 b8             	mov    -0x48(%rbp),%eax
   446a7:	01 d0                	add    %edx,%eax
   446a9:	48 63 d8             	movslq %eax,%rbx
   446ac:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   446b0:	48 89 c7             	mov    %rax,%rdi
   446b3:	e8 ab f4 ff ff       	call   43b63 <strlen>
   446b8:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   446bc:	8b 45 e8             	mov    -0x18(%rbp),%eax
   446bf:	29 d0                	sub    %edx,%eax
   446c1:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   446c4:	eb 25                	jmp    446eb <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   446c6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   446cd:	48 8b 08             	mov    (%rax),%rcx
   446d0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   446d6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   446dd:	be 20 00 00 00       	mov    $0x20,%esi
   446e2:	48 89 c7             	mov    %rax,%rdi
   446e5:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   446e7:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   446eb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446ee:	83 e0 04             	and    $0x4,%eax
   446f1:	85 c0                	test   %eax,%eax
   446f3:	75 36                	jne    4472b <printer_vprintf+0x945>
   446f5:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   446f9:	7f cb                	jg     446c6 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   446fb:	eb 2e                	jmp    4472b <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   446fd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44704:	4c 8b 00             	mov    (%rax),%r8
   44707:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4470b:	0f b6 00             	movzbl (%rax),%eax
   4470e:	0f b6 c8             	movzbl %al,%ecx
   44711:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44717:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4471e:	89 ce                	mov    %ecx,%esi
   44720:	48 89 c7             	mov    %rax,%rdi
   44723:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44726:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   4472b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4472f:	0f b6 00             	movzbl (%rax),%eax
   44732:	84 c0                	test   %al,%al
   44734:	75 c7                	jne    446fd <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   44736:	eb 25                	jmp    4475d <printer_vprintf+0x977>
            p->putc(p, '0', color);
   44738:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4473f:	48 8b 08             	mov    (%rax),%rcx
   44742:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44748:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4474f:	be 30 00 00 00       	mov    $0x30,%esi
   44754:	48 89 c7             	mov    %rax,%rdi
   44757:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44759:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   4475d:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44761:	7f d5                	jg     44738 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   44763:	eb 32                	jmp    44797 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   44765:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4476c:	4c 8b 00             	mov    (%rax),%r8
   4476f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44773:	0f b6 00             	movzbl (%rax),%eax
   44776:	0f b6 c8             	movzbl %al,%ecx
   44779:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4477f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44786:	89 ce                	mov    %ecx,%esi
   44788:	48 89 c7             	mov    %rax,%rdi
   4478b:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   4478e:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44793:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44797:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   4479b:	7f c8                	jg     44765 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   4479d:	eb 25                	jmp    447c4 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   4479f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447a6:	48 8b 08             	mov    (%rax),%rcx
   447a9:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   447af:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447b6:	be 20 00 00 00       	mov    $0x20,%esi
   447bb:	48 89 c7             	mov    %rax,%rdi
   447be:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   447c0:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   447c4:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   447c8:	7f d5                	jg     4479f <printer_vprintf+0x9b9>
        }
    done: ;
   447ca:	90                   	nop
    for (; *format; ++format) {
   447cb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   447d2:	01 
   447d3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   447da:	0f b6 00             	movzbl (%rax),%eax
   447dd:	84 c0                	test   %al,%al
   447df:	0f 85 31 f6 ff ff    	jne    43e16 <printer_vprintf+0x30>
    }
}
   447e5:	90                   	nop
   447e6:	90                   	nop
   447e7:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   447eb:	c9                   	leave  
   447ec:	c3                   	ret    

00000000000447ed <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   447ed:	f3 0f 1e fa          	endbr64 
   447f1:	55                   	push   %rbp
   447f2:	48 89 e5             	mov    %rsp,%rbp
   447f5:	48 83 ec 20          	sub    $0x20,%rsp
   447f9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   447fd:	89 f0                	mov    %esi,%eax
   447ff:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44802:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44805:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44809:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4480d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44811:	48 8b 40 08          	mov    0x8(%rax),%rax
   44815:	48 8d 15 84 47 07 00 	lea    0x74784(%rip),%rdx        # b8fa0 <console+0xfa0>
   4481c:	48 39 d0             	cmp    %rdx,%rax
   4481f:	72 0f                	jb     44830 <console_putc+0x43>
        cp->cursor = console;
   44821:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44825:	48 8d 15 d4 37 07 00 	lea    0x737d4(%rip),%rdx        # b8000 <console>
   4482c:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   44830:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44834:	0f 85 82 00 00 00    	jne    448bc <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   4483a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4483e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44842:	48 8d 15 b7 37 07 00 	lea    0x737b7(%rip),%rdx        # b8000 <console>
   44849:	48 29 d0             	sub    %rdx,%rax
   4484c:	48 d1 f8             	sar    %rax
   4484f:	48 89 c1             	mov    %rax,%rcx
   44852:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44859:	66 66 66 
   4485c:	48 89 c8             	mov    %rcx,%rax
   4485f:	48 f7 ea             	imul   %rdx
   44862:	48 89 d0             	mov    %rdx,%rax
   44865:	48 c1 f8 05          	sar    $0x5,%rax
   44869:	48 89 ce             	mov    %rcx,%rsi
   4486c:	48 c1 fe 3f          	sar    $0x3f,%rsi
   44870:	48 29 f0             	sub    %rsi,%rax
   44873:	48 89 c2             	mov    %rax,%rdx
   44876:	48 89 d0             	mov    %rdx,%rax
   44879:	48 c1 e0 02          	shl    $0x2,%rax
   4487d:	48 01 d0             	add    %rdx,%rax
   44880:	48 c1 e0 04          	shl    $0x4,%rax
   44884:	48 29 c1             	sub    %rax,%rcx
   44887:	48 89 ca             	mov    %rcx,%rdx
   4488a:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   4488d:	eb 25                	jmp    448b4 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   4488f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44892:	83 c8 20             	or     $0x20,%eax
   44895:	89 c6                	mov    %eax,%esi
   44897:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4489b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4489f:	48 8d 48 02          	lea    0x2(%rax),%rcx
   448a3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   448a7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   448ab:	89 f2                	mov    %esi,%edx
   448ad:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   448b0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   448b4:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   448b8:	75 d5                	jne    4488f <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   448ba:	eb 24                	jmp    448e0 <console_putc+0xf3>
        *cp->cursor++ = c | color;
   448bc:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   448c0:	8b 45 e0             	mov    -0x20(%rbp),%eax
   448c3:	89 d6                	mov    %edx,%esi
   448c5:	09 c6                	or     %eax,%esi
   448c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   448cb:	48 8b 40 08          	mov    0x8(%rax),%rax
   448cf:	48 8d 48 02          	lea    0x2(%rax),%rcx
   448d3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   448d7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   448db:	89 f2                	mov    %esi,%edx
   448dd:	66 89 10             	mov    %dx,(%rax)
}
   448e0:	90                   	nop
   448e1:	c9                   	leave  
   448e2:	c3                   	ret    

00000000000448e3 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   448e3:	f3 0f 1e fa          	endbr64 
   448e7:	55                   	push   %rbp
   448e8:	48 89 e5             	mov    %rsp,%rbp
   448eb:	48 83 ec 30          	sub    $0x30,%rsp
   448ef:	89 7d ec             	mov    %edi,-0x14(%rbp)
   448f2:	89 75 e8             	mov    %esi,-0x18(%rbp)
   448f5:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   448f9:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   448fd:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 447ed <console_putc>
   44904:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44908:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   4490c:	78 09                	js     44917 <console_vprintf+0x34>
   4490e:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44915:	7e 07                	jle    4491e <console_vprintf+0x3b>
        cpos = 0;
   44917:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   4491e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44921:	48 98                	cltq   
   44923:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44927:	48 8d 05 d2 36 07 00 	lea    0x736d2(%rip),%rax        # b8000 <console>
   4492e:	48 01 d0             	add    %rdx,%rax
   44931:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44935:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44939:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4493d:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44940:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44944:	48 89 c7             	mov    %rax,%rdi
   44947:	e8 9a f4 ff ff       	call   43de6 <printer_vprintf>
    return cp.cursor - console;
   4494c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44950:	48 8d 15 a9 36 07 00 	lea    0x736a9(%rip),%rdx        # b8000 <console>
   44957:	48 29 d0             	sub    %rdx,%rax
   4495a:	48 d1 f8             	sar    %rax
}
   4495d:	c9                   	leave  
   4495e:	c3                   	ret    

000000000004495f <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   4495f:	f3 0f 1e fa          	endbr64 
   44963:	55                   	push   %rbp
   44964:	48 89 e5             	mov    %rsp,%rbp
   44967:	48 83 ec 60          	sub    $0x60,%rsp
   4496b:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4496e:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44971:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44975:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44979:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4497d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44981:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44988:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4498c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44990:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44994:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44998:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4499c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   449a0:	8b 75 a8             	mov    -0x58(%rbp),%esi
   449a3:	8b 45 ac             	mov    -0x54(%rbp),%eax
   449a6:	89 c7                	mov    %eax,%edi
   449a8:	e8 36 ff ff ff       	call   448e3 <console_vprintf>
   449ad:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   449b0:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   449b3:	c9                   	leave  
   449b4:	c3                   	ret    

00000000000449b5 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   449b5:	f3 0f 1e fa          	endbr64 
   449b9:	55                   	push   %rbp
   449ba:	48 89 e5             	mov    %rsp,%rbp
   449bd:	48 83 ec 20          	sub    $0x20,%rsp
   449c1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   449c5:	89 f0                	mov    %esi,%eax
   449c7:	89 55 e0             	mov    %edx,-0x20(%rbp)
   449ca:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   449cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   449d1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   449d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   449d9:	48 8b 50 08          	mov    0x8(%rax),%rdx
   449dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   449e1:	48 8b 40 10          	mov    0x10(%rax),%rax
   449e5:	48 39 c2             	cmp    %rax,%rdx
   449e8:	73 1a                	jae    44a04 <string_putc+0x4f>
        *sp->s++ = c;
   449ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   449ee:	48 8b 40 08          	mov    0x8(%rax),%rax
   449f2:	48 8d 48 01          	lea    0x1(%rax),%rcx
   449f6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   449fa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449fe:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44a02:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44a04:	90                   	nop
   44a05:	c9                   	leave  
   44a06:	c3                   	ret    

0000000000044a07 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44a07:	f3 0f 1e fa          	endbr64 
   44a0b:	55                   	push   %rbp
   44a0c:	48 89 e5             	mov    %rsp,%rbp
   44a0f:	48 83 ec 40          	sub    $0x40,%rsp
   44a13:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44a17:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44a1b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44a1f:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44a23:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 449b5 <string_putc>
   44a2a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   44a2e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44a32:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44a36:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44a3b:	74 33                	je     44a70 <vsnprintf+0x69>
        sp.end = s + size - 1;
   44a3d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44a41:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44a45:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44a49:	48 01 d0             	add    %rdx,%rax
   44a4c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44a50:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44a54:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44a58:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44a5c:	be 00 00 00 00       	mov    $0x0,%esi
   44a61:	48 89 c7             	mov    %rax,%rdi
   44a64:	e8 7d f3 ff ff       	call   43de6 <printer_vprintf>
        *sp.s = 0;
   44a69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a6d:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44a70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a74:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44a78:	c9                   	leave  
   44a79:	c3                   	ret    

0000000000044a7a <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44a7a:	f3 0f 1e fa          	endbr64 
   44a7e:	55                   	push   %rbp
   44a7f:	48 89 e5             	mov    %rsp,%rbp
   44a82:	48 83 ec 70          	sub    $0x70,%rsp
   44a86:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44a8a:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44a8e:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44a92:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44a96:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44a9a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44a9e:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44aa5:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44aa9:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44aad:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44ab1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44ab5:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44ab9:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44abd:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44ac1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44ac5:	48 89 c7             	mov    %rax,%rdi
   44ac8:	e8 3a ff ff ff       	call   44a07 <vsnprintf>
   44acd:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44ad0:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44ad3:	c9                   	leave  
   44ad4:	c3                   	ret    

0000000000044ad5 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44ad5:	f3 0f 1e fa          	endbr64 
   44ad9:	55                   	push   %rbp
   44ada:	48 89 e5             	mov    %rsp,%rbp
   44add:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44ae1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44ae8:	eb 1a                	jmp    44b04 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   44aea:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44aed:	48 98                	cltq   
   44aef:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44af3:	48 8d 05 06 35 07 00 	lea    0x73506(%rip),%rax        # b8000 <console>
   44afa:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44b00:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44b04:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44b0b:	7e dd                	jle    44aea <console_clear+0x15>
    }
    cursorpos = 0;
   44b0d:	c7 05 e5 44 07 00 00 	movl   $0x0,0x744e5(%rip)        # b8ffc <cursorpos>
   44b14:	00 00 00 
}
   44b17:	90                   	nop
   44b18:	c9                   	leave  
   44b19:	c3                   	ret    
