
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
   400be:	e8 84 0d 00 00       	call   40e47 <exception>

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
   40177:	e8 1a 1d 00 00       	call   41e96 <hardware_init>
    pageinfo_init();
   4017c:	e8 1a 12 00 00       	call   4139b <pageinfo_init>
    console_clear();
   40181:	e8 6c 4a 00 00       	call   44bf2 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 6e 22 00 00       	call   423fe <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 7f 1e 01 00 	lea    0x11e7f(%rip),%rax        # 52020 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 94 3a 00 00       	call   43c3d <memset>
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
   40210:	48 8d 15 29 4a 00 00 	lea    0x4a29(%rip),%rdx        # 44c40 <console_clear+0x4e>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 24 3b 00 00       	call   43d46 <strcmp>
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
   40245:	48 8d 15 f9 49 00 00 	lea    0x49f9(%rip),%rdx        # 44c45 <console_clear+0x53>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 ef 3a 00 00       	call   43d46 <strcmp>
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
   4027a:	48 8d 15 cd 49 00 00 	lea    0x49cd(%rip),%rdx        # 44c4e <console_clear+0x5c>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 ba 3a 00 00       	call   43d46 <strcmp>
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
   402ac:	48 8d 15 a0 49 00 00 	lea    0x49a0(%rip),%rdx        # 44c53 <console_clear+0x61>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 88 3a 00 00       	call   43d46 <strcmp>
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
   4032a:	e8 3c 2f 00 00       	call   4326b <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   4032f:	48 8d 15 ca 7c 07 00 	lea    0x77cca(%rip),%rdx        # b8000 <console>
   40336:	48 8d 35 c3 7c 07 00 	lea    0x77cc3(%rip),%rsi        # b8000 <console>
   4033d:	48 8b 05 bc 4c 01 00 	mov    0x14cbc(%rip),%rax        # 55000 <kernel_pagetable>
   40344:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4034a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4034f:	48 89 c7             	mov    %rax,%rdi
   40352:	e8 14 2f 00 00       	call   4326b <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    // Switch to the first process using run()
    run(&processes[1]);
   40357:	48 8d 05 a2 1d 01 00 	lea    0x11da2(%rip),%rax        # 52100 <processes+0xe0>
   4035e:	48 89 c7             	mov    %rax,%rdi
   40361:	e8 ca 0f 00 00       	call   41330 <run>

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
   403e0:	e8 58 38 00 00       	call   43c3d <memset>
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
   40558:	e8 58 31 00 00       	call   436b5 <virtual_memory_lookup>
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
   4057f:	e8 e7 2c 00 00       	call   4326b <virtual_memory_map>
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
   405d4:	e8 d8 20 00 00       	call   426b1 <process_init>

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
   4062d:	e8 39 2c 00 00       	call   4326b <virtual_memory_map>
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
   4065e:	e8 4d 31 00 00       	call   437b0 <program_load>
   40663:	89 45 f4             	mov    %eax,-0xc(%rbp)
    assert(r >= 0);
   40666:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4066a:	79 1e                	jns    4068a <process_setup+0xee>
   4066c:	48 8d 05 e6 45 00 00 	lea    0x45e6(%rip),%rax        # 44c59 <console_clear+0x67>
   40673:	48 89 c2             	mov    %rax,%rdx
   40676:	be c0 00 00 00       	mov    $0xc0,%esi
   4067b:	48 8d 05 de 45 00 00 	lea    0x45de(%rip),%rax        # 44c60 <console_clear+0x6e>
   40682:	48 89 c7             	mov    %rax,%rdi
   40685:	e8 5d 28 00 00       	call   42ee7 <assert_fail>

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
   406b1:	e8 b5 2b 00 00       	call   4326b <virtual_memory_map>
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
   407d2:	e8 de 2e 00 00       	call   436b5 <virtual_memory_lookup>

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
   4080a:	e8 a6 2e 00 00       	call   436b5 <virtual_memory_lookup>
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
   40836:	e8 7a 2e 00 00       	call   436b5 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   4083b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4083f:	48 89 c1             	mov    %rax,%rcx
   40842:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40846:	ba 18 00 00 00       	mov    $0x18,%edx
   4084b:	48 89 c6             	mov    %rax,%rsi
   4084e:	48 89 cf             	mov    %rcx,%rdi
   40851:	e8 e1 32 00 00       	call   43b37 <memcpy>
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

00000000000408cb <exit1>:
//    the kernel's stack, then jumping to kernel assembly code (in
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.
void exit1(pid_t pid){
   408cb:	f3 0f 1e fa          	endbr64 
   408cf:	55                   	push   %rbp
   408d0:	48 89 e5             	mov    %rsp,%rbp
   408d3:	48 83 ec 70          	sub    $0x70,%rsp
   408d7:	89 7d 9c             	mov    %edi,-0x64(%rbp)

    x86_64_pagetable* page_tables[5];
    x86_64_pagetable* l4 = processes[pid].p_pagetable;
   408da:	8b 45 9c             	mov    -0x64(%rbp),%eax
   408dd:	48 63 d0             	movslq %eax,%rdx
   408e0:	48 89 d0             	mov    %rdx,%rax
   408e3:	48 c1 e0 03          	shl    $0x3,%rax
   408e7:	48 29 d0             	sub    %rdx,%rax
   408ea:	48 c1 e0 05          	shl    $0x5,%rax
   408ee:	48 89 c2             	mov    %rax,%rdx
   408f1:	48 8d 05 f8 17 01 00 	lea    0x117f8(%rip),%rax        # 520f0 <processes+0xd0>
   408f8:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   408fc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        page_tables[0] = l4;
   40900:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40904:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
        page_tables[1] = (x86_64_pagetable*) PTE_ADDR(l4->entry[0]); // L3 
   40908:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4090c:	48 8b 00             	mov    (%rax),%rax
   4090f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40915:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        page_tables[2] = (x86_64_pagetable*) PTE_ADDR(page_tables[1]->entry[0]); // L2
   40919:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4091d:	48 8b 00             	mov    (%rax),%rax
   40920:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40926:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        page_tables[3] = (x86_64_pagetable*) PTE_ADDR(page_tables[2]->entry[0]); // L1_0
   4092a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4092e:	48 8b 00             	mov    (%rax),%rax
   40931:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40937:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        page_tables[4] = (x86_64_pagetable*) PTE_ADDR(page_tables[2]->entry[1]); // L1_1
   4093b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4093f:	48 8b 40 08          	mov    0x8(%rax),%rax
   40943:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40949:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    
        for (uintptr_t addr = 0; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE){
   4094d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40954:	00 
   40955:	e9 db 00 00 00       	jmp    40a35 <exit1+0x16a>
            vamapping vam = virtual_memory_lookup(kernel_pagetable, addr);
   4095a:	48 8b 0d 9f 46 01 00 	mov    0x1469f(%rip),%rcx        # 55000 <kernel_pagetable>
   40961:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40965:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40969:	48 89 ce             	mov    %rcx,%rsi
   4096c:	48 89 c7             	mov    %rax,%rdi
   4096f:	e8 41 2d 00 00       	call   436b5 <virtual_memory_lookup>
            if (vam.pa == (uintptr_t) -1 ){
   40974:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40978:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
   4097c:	0f 84 aa 00 00 00    	je     40a2c <exit1+0x161>
                continue;
            }
            if (pageinfo[vam.pn].owner == pid){
   40982:	8b 45 a0             	mov    -0x60(%rbp),%eax
   40985:	48 98                	cltq   
   40987:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4098b:	48 8d 05 ae 24 01 00 	lea    0x124ae(%rip),%rax        # 52e40 <pageinfo>
   40992:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40996:	0f be c0             	movsbl %al,%eax
   40999:	39 45 9c             	cmp    %eax,-0x64(%rbp)
   4099c:	75 28                	jne    409c6 <exit1+0xfb>
                pageinfo[vam.pn].owner = PO_FREE;
   4099e:	8b 45 a0             	mov    -0x60(%rbp),%eax
   409a1:	48 98                	cltq   
   409a3:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   409a7:	48 8d 05 92 24 01 00 	lea    0x12492(%rip),%rax        # 52e40 <pageinfo>
   409ae:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[vam.pn].refcount = 0;
   409b2:	8b 45 a0             	mov    -0x60(%rbp),%eax
   409b5:	48 98                	cltq   
   409b7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   409bb:	48 8d 05 7f 24 01 00 	lea    0x1247f(%rip),%rax        # 52e41 <pageinfo+0x1>
   409c2:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
            }
                        // decrease ref to shared pages 
            if (pageinfo[vam.pn].refcount > 1 && pageinfo[vam.pn].owner > 0 
   409c6:	8b 45 a0             	mov    -0x60(%rbp),%eax
   409c9:	48 98                	cltq   
   409cb:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   409cf:	48 8d 05 6b 24 01 00 	lea    0x1246b(%rip),%rax        # 52e41 <pageinfo+0x1>
   409d6:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   409da:	3c 01                	cmp    $0x1,%al
   409dc:	7e 4f                	jle    40a2d <exit1+0x162>
   409de:	8b 45 a0             	mov    -0x60(%rbp),%eax
   409e1:	48 98                	cltq   
   409e3:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   409e7:	48 8d 05 52 24 01 00 	lea    0x12452(%rip),%rax        # 52e40 <pageinfo>
   409ee:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   409f2:	84 c0                	test   %al,%al
   409f4:	7e 37                	jle    40a2d <exit1+0x162>
                        && addr == PROC_START_ADDR) {
   409f6:	48 81 7d f8 00 00 10 	cmpq   $0x100000,-0x8(%rbp)
   409fd:	00 
   409fe:	75 2d                	jne    40a2d <exit1+0x162>
	           pageinfo[vam.pn].refcount--;
   40a00:	8b 45 a0             	mov    -0x60(%rbp),%eax
   40a03:	48 63 d0             	movslq %eax,%rdx
   40a06:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40a0a:	48 8d 15 30 24 01 00 	lea    0x12430(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40a11:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40a15:	83 ea 01             	sub    $0x1,%edx
   40a18:	89 d1                	mov    %edx,%ecx
   40a1a:	48 98                	cltq   
   40a1c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40a20:	48 8d 05 1a 24 01 00 	lea    0x1241a(%rip),%rax        # 52e41 <pageinfo+0x1>
   40a27:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
   40a2a:	eb 01                	jmp    40a2d <exit1+0x162>
                continue;
   40a2c:	90                   	nop
        for (uintptr_t addr = 0; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE){
   40a2d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40a34:	00 
   40a35:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40a3c:	00 
   40a3d:	0f 86 17 ff ff ff    	jbe    4095a <exit1+0x8f>
	       }  
        }
        for (int i = 0; i < 5; ++i) {
   40a43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40a4a:	eb 68                	jmp    40ab4 <exit1+0x1e9>
        if (page_tables[i]) {
   40a4c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40a4f:	48 98                	cltq   
   40a51:	48 8b 44 c5 b8       	mov    -0x48(%rbp,%rax,8),%rax
   40a56:	48 85 c0             	test   %rax,%rax
   40a59:	74 55                	je     40ab0 <exit1+0x1e5>
            int pn = PAGENUMBER((uintptr_t)page_tables[i]);
   40a5b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40a5e:	48 98                	cltq   
   40a60:	48 8b 44 c5 b8       	mov    -0x48(%rbp,%rax,8),%rax
   40a65:	48 c1 e8 0c          	shr    $0xc,%rax
   40a69:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            if (pageinfo[pn].owner == pid) {
   40a6c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40a6f:	48 98                	cltq   
   40a71:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40a75:	48 8d 05 c4 23 01 00 	lea    0x123c4(%rip),%rax        # 52e40 <pageinfo>
   40a7c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40a80:	0f be c0             	movsbl %al,%eax
   40a83:	39 45 9c             	cmp    %eax,-0x64(%rbp)
   40a86:	75 28                	jne    40ab0 <exit1+0x1e5>
                pageinfo[pn].owner = PO_FREE;
   40a88:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40a8b:	48 98                	cltq   
   40a8d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40a91:	48 8d 05 a8 23 01 00 	lea    0x123a8(%rip),%rax        # 52e40 <pageinfo>
   40a98:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[pn].refcount = 0;
   40a9c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40a9f:	48 98                	cltq   
   40aa1:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40aa5:	48 8d 05 95 23 01 00 	lea    0x12395(%rip),%rax        # 52e41 <pageinfo+0x1>
   40aac:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        for (int i = 0; i < 5; ++i) {
   40ab0:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40ab4:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   40ab8:	7e 92                	jle    40a4c <exit1+0x181>
            }
        }
    }

    processes[pid].p_state = P_FREE;
   40aba:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40abd:	48 63 d0             	movslq %eax,%rdx
   40ac0:	48 89 d0             	mov    %rdx,%rax
   40ac3:	48 c1 e0 03          	shl    $0x3,%rax
   40ac7:	48 29 d0             	sub    %rdx,%rax
   40aca:	48 c1 e0 05          	shl    $0x5,%rax
   40ace:	48 89 c2             	mov    %rax,%rdx
   40ad1:	48 8d 05 10 16 01 00 	lea    0x11610(%rip),%rax        # 520e8 <processes+0xc8>
   40ad8:	c7 04 02 00 00 00 00 	movl   $0x0,(%rdx,%rax,1)
}
   40adf:	90                   	nop
   40ae0:	c9                   	leave  
   40ae1:	c3                   	ret    

0000000000040ae2 <fork>:
int fork(void){
   40ae2:	f3 0f 1e fa          	endbr64 
   40ae6:	55                   	push   %rbp
   40ae7:	48 89 e5             	mov    %rsp,%rbp
   40aea:	48 83 ec 70          	sub    $0x70,%rsp
    // find free
    pid_t child_pid = -1;
   40aee:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    for (pid_t i = 1; i < NPROC; ++i) {
   40af5:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   40afc:	eb 40                	jmp    40b3e <fork+0x5c>
        if (processes[i].p_state == P_FREE) {
   40afe:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40b01:	48 63 d0             	movslq %eax,%rdx
   40b04:	48 89 d0             	mov    %rdx,%rax
   40b07:	48 c1 e0 03          	shl    $0x3,%rax
   40b0b:	48 29 d0             	sub    %rdx,%rax
   40b0e:	48 c1 e0 05          	shl    $0x5,%rax
   40b12:	48 89 c2             	mov    %rax,%rdx
   40b15:	48 8d 05 cc 15 01 00 	lea    0x115cc(%rip),%rax        # 520e8 <processes+0xc8>
   40b1c:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40b1f:	85 c0                	test   %eax,%eax
   40b21:	75 17                	jne    40b3a <fork+0x58>
            child_pid = i;
   40b23:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40b26:	89 45 fc             	mov    %eax,-0x4(%rbp)
            current->p_registers.reg_rax = -1;
   40b29:	48 8b 05 d0 14 01 00 	mov    0x114d0(%rip),%rax        # 52000 <current>
   40b30:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b37:	ff 
            break;
   40b38:	eb 0a                	jmp    40b44 <fork+0x62>
    for (pid_t i = 1; i < NPROC; ++i) {
   40b3a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40b3e:	83 7d f8 0f          	cmpl   $0xf,-0x8(%rbp)
   40b42:	7e ba                	jle    40afe <fork+0x1c>
        }
    }

    // no ree
    if (child_pid == -1) {
   40b44:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40b48:	75 19                	jne    40b63 <fork+0x81>
        current->p_registers.reg_rax = -1;
   40b4a:	48 8b 05 af 14 01 00 	mov    0x114af(%rip),%rax        # 52000 <current>
   40b51:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b58:	ff 
        return 1;
   40b59:	b8 01 00 00 00       	mov    $0x1,%eax
   40b5e:	e9 e2 02 00 00       	jmp    40e45 <fork+0x363>
    }

    // reserve
    proc* parent = current;
   40b63:	48 8b 05 96 14 01 00 	mov    0x11496(%rip),%rax        # 52000 <current>
   40b6a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    proc* child = &processes[child_pid];
   40b6e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b71:	48 63 d0             	movslq %eax,%rdx
   40b74:	48 89 d0             	mov    %rdx,%rax
   40b77:	48 c1 e0 03          	shl    $0x3,%rax
   40b7b:	48 29 d0             	sub    %rdx,%rax
   40b7e:	48 c1 e0 05          	shl    $0x5,%rax
   40b82:	48 8d 15 97 14 01 00 	lea    0x11497(%rip),%rdx        # 52020 <processes>
   40b89:	48 01 d0             	add    %rdx,%rax
   40b8c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    process_init(child, child_pid);
   40b90:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40b93:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40b97:	89 d6                	mov    %edx,%esi
   40b99:	48 89 c7             	mov    %rax,%rdi
   40b9c:	e8 10 1b 00 00       	call   426b1 <process_init>

    //allocate
    x86_64_pagetable* child_table = make_pages(child_pid);
   40ba1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ba4:	89 c7                	mov    %eax,%edi
   40ba6:	e8 e1 f8 ff ff       	call   4048c <make_pages>
   40bab:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    if (!child_table) {
   40baf:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   40bb4:	75 0a                	jne    40bc0 <fork+0xde>
        // exit1(child_pid);
        return 1;
   40bb6:	b8 01 00 00 00       	mov    $0x1,%eax
   40bbb:	e9 85 02 00 00       	jmp    40e45 <fork+0x363>
    }
    child->p_pagetable = child_table;
   40bc0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40bc4:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40bc8:	48 89 90 d0 00 00 00 	mov    %rdx,0xd0(%rax)
    // map console

    vamapping console_mapping = virtual_memory_lookup(parent->p_pagetable, CONSOLE_ADDR);
   40bcf:	48 8d 15 2a 74 07 00 	lea    0x7742a(%rip),%rdx        # b8000 <console>
   40bd6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40bda:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40be1:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40be5:	48 89 ce             	mov    %rcx,%rsi
   40be8:	48 89 c7             	mov    %rax,%rdi
   40beb:	e8 c5 2a 00 00       	call   436b5 <virtual_memory_lookup>
        if (console_mapping.pn != -1) {
   40bf0:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40bf3:	83 f8 ff             	cmp    $0xffffffff,%eax
   40bf6:	74 73                	je     40c6b <fork+0x189>
            pageinfo[console_mapping.pn].refcount++;
   40bf8:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40bfb:	48 63 d0             	movslq %eax,%rdx
   40bfe:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40c02:	48 8d 15 38 22 01 00 	lea    0x12238(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40c09:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40c0d:	83 c2 01             	add    $0x1,%edx
   40c10:	89 d1                	mov    %edx,%ecx
   40c12:	48 98                	cltq   
   40c14:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40c18:	48 8d 05 22 22 01 00 	lea    0x12222(%rip),%rax        # 52e41 <pageinfo+0x1>
   40c1f:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
            if (virtual_memory_map(child_table, CONSOLE_ADDR, CONSOLE_ADDR, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   40c22:	48 8d 15 d7 73 07 00 	lea    0x773d7(%rip),%rdx        # b8000 <console>
   40c29:	48 8d 35 d0 73 07 00 	lea    0x773d0(%rip),%rsi        # b8000 <console>
   40c30:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40c34:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40c3a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40c3f:	48 89 c7             	mov    %rax,%rdi
   40c42:	e8 24 26 00 00       	call   4326b <virtual_memory_map>
   40c47:	85 c0                	test   %eax,%eax
   40c49:	79 20                	jns    40c6b <fork+0x189>
            exit1(child_pid);
   40c4b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c4e:	89 c7                	mov    %eax,%edi
   40c50:	e8 76 fc ff ff       	call   408cb <exit1>
            child->p_registers.reg_rax = -1;
   40c55:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40c59:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40c60:	ff 
            return -1;
   40c61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40c66:	e9 da 01 00 00       	jmp    40e45 <fork+0x363>
            }
    }

    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40c6b:	48 c7 45 f0 00 00 10 	movq   $0x100000,-0x10(%rbp)
   40c72:	00 
   40c73:	e9 71 01 00 00       	jmp    40de9 <fork+0x307>
        vamapping parent_mapping = virtual_memory_lookup(parent->p_pagetable, va);
   40c78:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40c7c:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40c83:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   40c87:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40c8b:	48 89 ce             	mov    %rcx,%rsi
   40c8e:	48 89 c7             	mov    %rax,%rdi
   40c91:	e8 1f 2a 00 00       	call   436b5 <virtual_memory_lookup>
        // skip console and nonexistent pages
        if (va == CONSOLE_ADDR || parent_mapping.pn == -1) {
   40c96:	48 8d 05 63 73 07 00 	lea    0x77363(%rip),%rax        # b8000 <console>
   40c9d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40ca1:	0f 84 39 01 00 00    	je     40de0 <fork+0x2fe>
   40ca7:	8b 45 98             	mov    -0x68(%rbp),%eax
   40caa:	83 f8 ff             	cmp    $0xffffffff,%eax
   40cad:	0f 84 2d 01 00 00    	je     40de0 <fork+0x2fe>
            continue; 
        }

        if (parent_mapping.perm & PTE_W) {
   40cb3:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40cb6:	48 98                	cltq   
   40cb8:	83 e0 02             	and    $0x2,%eax
   40cbb:	48 85 c0             	test   %rax,%rax
   40cbe:	0f 84 9f 00 00 00    	je     40d63 <fork+0x281>
        // Allocate a new physical page for the child
            uintptr_t new_pa = find_page(child_pid);
   40cc4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cc7:	0f be c0             	movsbl %al,%eax
   40cca:	89 c7                	mov    %eax,%edi
   40ccc:	e8 33 f7 ff ff       	call   40404 <find_page>
   40cd1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
            if (!new_pa) {
   40cd5:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   40cda:	75 20                	jne    40cfc <fork+0x21a>
                exit1(child_pid);
   40cdc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cdf:	89 c7                	mov    %eax,%edi
   40ce1:	e8 e5 fb ff ff       	call   408cb <exit1>
                child->p_registers.reg_rax = -1;
   40ce6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40cea:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40cf1:	ff 
                return -1;
   40cf2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40cf7:	e9 49 01 00 00       	jmp    40e45 <fork+0x363>
            }
            memcpy((void*) new_pa, (void*) parent_mapping.pa, PAGESIZE);
   40cfc:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   40d00:	48 89 c1             	mov    %rax,%rcx
   40d03:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40d07:	ba 00 10 00 00       	mov    $0x1000,%edx
   40d0c:	48 89 ce             	mov    %rcx,%rsi
   40d0f:	48 89 c7             	mov    %rax,%rdi
   40d12:	e8 20 2e 00 00       	call   43b37 <memcpy>

            int r = virtual_memory_map(child_table, va, new_pa, PAGESIZE, parent_mapping.perm);
   40d17:	8b 4d a8             	mov    -0x58(%rbp),%ecx
   40d1a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40d1e:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40d22:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40d26:	41 89 c8             	mov    %ecx,%r8d
   40d29:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40d2e:	48 89 c7             	mov    %rax,%rdi
   40d31:	e8 35 25 00 00       	call   4326b <virtual_memory_map>
   40d36:	89 45 cc             	mov    %eax,-0x34(%rbp)
            if (r < 0) {
   40d39:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
   40d3d:	0f 89 9e 00 00 00    	jns    40de1 <fork+0x2ff>
                exit1(child_pid);
   40d43:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d46:	89 c7                	mov    %eax,%edi
   40d48:	e8 7e fb ff ff       	call   408cb <exit1>
                child->p_registers.reg_rax = -1;
   40d4d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d51:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40d58:	ff 
                return -1;
   40d59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40d5e:	e9 e2 00 00 00       	jmp    40e45 <fork+0x363>
            }
        } else if (((parent_mapping.perm & (PTE_P | PTE_U)) == (PTE_P | PTE_U))) {
   40d63:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40d66:	48 98                	cltq   
   40d68:	83 e0 05             	and    $0x5,%eax
   40d6b:	48 83 f8 05          	cmp    $0x5,%rax
   40d6f:	75 70                	jne    40de1 <fork+0x2ff>
                
            if (virtual_memory_map(child_table, va, parent_mapping.pa, PAGESIZE, parent_mapping.perm) < 0) {
   40d71:	8b 4d a8             	mov    -0x58(%rbp),%ecx
   40d74:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   40d78:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40d7c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40d80:	41 89 c8             	mov    %ecx,%r8d
   40d83:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40d88:	48 89 c7             	mov    %rax,%rdi
   40d8b:	e8 db 24 00 00       	call   4326b <virtual_memory_map>
   40d90:	85 c0                	test   %eax,%eax
   40d92:	79 20                	jns    40db4 <fork+0x2d2>
                exit1(child_pid);
   40d94:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d97:	89 c7                	mov    %eax,%edi
   40d99:	e8 2d fb ff ff       	call   408cb <exit1>
                child->p_registers.reg_rax = -1;
   40d9e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40da2:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40da9:	ff 
                return -1;
   40daa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40daf:	e9 91 00 00 00       	jmp    40e45 <fork+0x363>
            }
            pageinfo[parent_mapping.pn].refcount++;
   40db4:	8b 45 98             	mov    -0x68(%rbp),%eax
   40db7:	48 63 d0             	movslq %eax,%rdx
   40dba:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40dbe:	48 8d 15 7c 20 01 00 	lea    0x1207c(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40dc5:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40dc9:	83 c2 01             	add    $0x1,%edx
   40dcc:	89 d1                	mov    %edx,%ecx
   40dce:	48 98                	cltq   
   40dd0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40dd4:	48 8d 05 66 20 01 00 	lea    0x12066(%rip),%rax        # 52e41 <pageinfo+0x1>
   40ddb:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
   40dde:	eb 01                	jmp    40de1 <fork+0x2ff>
            continue; 
   40de0:	90                   	nop
    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40de1:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   40de8:	00 
   40de9:	48 81 7d f0 ff ff 2f 	cmpq   $0x2fffff,-0x10(%rbp)
   40df0:	00 
   40df1:	0f 86 81 fe ff ff    	jbe    40c78 <fork+0x196>
            // continue;
        }
    }


    child->p_registers = parent->p_registers;
   40df7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40dfb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40dff:	48 83 c0 08          	add    $0x8,%rax
   40e03:	48 83 c2 08          	add    $0x8,%rdx
   40e07:	b9 18 00 00 00       	mov    $0x18,%ecx
   40e0c:	48 89 c7             	mov    %rax,%rdi
   40e0f:	48 89 d6             	mov    %rdx,%rsi
   40e12:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    child->p_registers.reg_rax = 0; 
   40e15:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e19:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40e20:	00 
    child->p_state = P_RUNNABLE;
   40e21:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e25:	c7 80 c8 00 00 00 01 	movl   $0x1,0xc8(%rax)
   40e2c:	00 00 00 
    current->p_registers.reg_rax = child_pid;
   40e2f:	48 8b 05 ca 11 01 00 	mov    0x111ca(%rip),%rax        # 52000 <current>
   40e36:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40e39:	48 63 d2             	movslq %edx,%rdx
   40e3c:	48 89 50 08          	mov    %rdx,0x8(%rax)
    return 0;
   40e40:	b8 00 00 00 00       	mov    $0x0,%eax



}
   40e45:	c9                   	leave  
   40e46:	c3                   	ret    

0000000000040e47 <exception>:
void exception(x86_64_registers* reg) {
   40e47:	f3 0f 1e fa          	endbr64 
   40e4b:	55                   	push   %rbp
   40e4c:	48 89 e5             	mov    %rsp,%rbp
   40e4f:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   40e56:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40e5d:	48 8b 05 9c 11 01 00 	mov    0x1119c(%rip),%rax        # 52000 <current>
   40e64:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   40e6b:	48 83 c0 08          	add    $0x8,%rax
   40e6f:	48 89 d6             	mov    %rdx,%rsi
   40e72:	ba 18 00 00 00       	mov    $0x18,%edx
   40e77:	48 89 c7             	mov    %rax,%rdi
   40e7a:	48 89 d1             	mov    %rdx,%rcx
   40e7d:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40e80:	48 8b 05 79 41 01 00 	mov    0x14179(%rip),%rax        # 55000 <kernel_pagetable>
   40e87:	48 89 c7             	mov    %rax,%rdi
   40e8a:	e8 6a 22 00 00       	call   430f9 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40e8f:	8b 05 67 81 07 00    	mov    0x78167(%rip),%eax        # b8ffc <cursorpos>
   40e95:	89 c7                	mov    %eax,%edi
   40e97:	e8 e3 18 00 00       	call   4277f <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40e9c:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40ea3:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40eaa:	48 83 f8 0e          	cmp    $0xe,%rax
   40eae:	74 14                	je     40ec4 <exception+0x7d>
   40eb0:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40eb7:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40ebe:	48 83 f8 0d          	cmp    $0xd,%rax
   40ec2:	75 16                	jne    40eda <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40ec4:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40ecb:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ed2:	83 e0 04             	and    $0x4,%eax
   40ed5:	48 85 c0             	test   %rax,%rax
   40ed8:	74 1a                	je     40ef4 <exception+0xad>
    {
        check_virtual_memory();
   40eda:	e8 e6 08 00 00       	call   417c5 <check_virtual_memory>
        if(disp_global){
   40edf:	0f b6 05 1a 51 00 00 	movzbl 0x511a(%rip),%eax        # 46000 <disp_global>
   40ee6:	84 c0                	test   %al,%al
   40ee8:	74 0a                	je     40ef4 <exception+0xad>
            memshow_physical();
   40eea:	e8 9f 0a 00 00       	call   4198e <memshow_physical>
            memshow_virtual_animate();
   40eef:	e8 3c 0e 00 00       	call   41d30 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40ef4:	e8 9c 1d 00 00       	call   42c95 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40ef9:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40f00:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40f07:	48 83 e8 0e          	sub    $0xe,%rax
   40f0b:	48 83 f8 2a          	cmp    $0x2a,%rax
   40f0f:	0f 87 63 03 00 00    	ja     41278 <exception+0x431>
   40f15:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   40f1c:	00 
   40f1d:	48 8d 05 dc 3d 00 00 	lea    0x3ddc(%rip),%rax        # 44d00 <console_clear+0x10e>
   40f24:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40f27:	48 98                	cltq   
   40f29:	48 8d 15 d0 3d 00 00 	lea    0x3dd0(%rip),%rdx        # 44d00 <console_clear+0x10e>
   40f30:	48 01 d0             	add    %rdx,%rax
   40f33:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40f36:	48 8b 05 c3 10 01 00 	mov    0x110c3(%rip),%rax        # 52000 <current>
   40f3d:	48 8b 40 38          	mov    0x38(%rax),%rax
   40f41:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
		if((void *)addr == NULL)
   40f45:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   40f4a:	75 0f                	jne    40f5b <exception+0x114>
		    panic(NULL);
   40f4c:	bf 00 00 00 00       	mov    $0x0,%edi
   40f51:	b8 00 00 00 00       	mov    $0x0,%eax
   40f56:	e8 9c 1e 00 00       	call   42df7 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40f5b:	48 8b 05 9e 10 01 00 	mov    0x1109e(%rip),%rax        # 52000 <current>
   40f62:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40f69:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40f6d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40f71:	48 89 ce             	mov    %rcx,%rsi
   40f74:	48 89 c7             	mov    %rax,%rdi
   40f77:	e8 39 27 00 00       	call   436b5 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40f7c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40f80:	48 89 c1             	mov    %rax,%rcx
   40f83:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
   40f8a:	ba a0 00 00 00       	mov    $0xa0,%edx
   40f8f:	48 89 ce             	mov    %rcx,%rsi
   40f92:	48 89 c7             	mov    %rax,%rdi
   40f95:	e8 9d 2b 00 00       	call   43b37 <memcpy>
		panic(msg);
   40f9a:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
   40fa1:	48 89 c7             	mov    %rax,%rdi
   40fa4:	b8 00 00 00 00       	mov    $0x0,%eax
   40fa9:	e8 49 1e 00 00       	call   42df7 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40fae:	48 8b 05 4b 10 01 00 	mov    0x1104b(%rip),%rax        # 52000 <current>
   40fb5:	8b 10                	mov    (%rax),%edx
   40fb7:	48 8b 05 42 10 01 00 	mov    0x11042(%rip),%rax        # 52000 <current>
   40fbe:	48 63 d2             	movslq %edx,%rdx
   40fc1:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40fc5:	e9 be 02 00 00       	jmp    41288 <exception+0x441>

    case INT_SYS_YIELD:
        schedule();
   40fca:	e8 e2 02 00 00       	call   412b1 <schedule>
        break;                  /* will not be reached */
   40fcf:	e9 b4 02 00 00       	jmp    41288 <exception+0x441>

case INT_SYS_PAGE_ALLOC: {
    uintptr_t va = current->p_registers.reg_rdi;
   40fd4:	48 8b 05 25 10 01 00 	mov    0x11025(%rip),%rax        # 52000 <current>
   40fdb:	48 8b 40 38          	mov    0x38(%rax),%rax
   40fdf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    // check allignment and bounds
    if (va % PAGESIZE != 0) {
   40fe3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40fe7:	25 ff 0f 00 00       	and    $0xfff,%eax
   40fec:	48 85 c0             	test   %rax,%rax
   40fef:	74 14                	je     41005 <exception+0x1be>
        current->p_registers.reg_rax = -1; 
   40ff1:	48 8b 05 08 10 01 00 	mov    0x11008(%rip),%rax        # 52000 <current>
   40ff8:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40fff:	ff 
        break;
   41000:	e9 83 02 00 00       	jmp    41288 <exception+0x441>
    }
    if (va >= MEMSIZE_VIRTUAL) {
   41005:	48 81 7d f0 ff ff 2f 	cmpq   $0x2fffff,-0x10(%rbp)
   4100c:	00 
   4100d:	76 14                	jbe    41023 <exception+0x1dc>
        current->p_registers.reg_rax = -1; 
   4100f:	48 8b 05 ea 0f 01 00 	mov    0x10fea(%rip),%rax        # 52000 <current>
   41016:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   4101d:	ff 
        break;
   4101e:	e9 65 02 00 00       	jmp    41288 <exception+0x441>
    }
    if (va < PROC_START_ADDR) {
   41023:	48 81 7d f0 ff ff 0f 	cmpq   $0xfffff,-0x10(%rbp)
   4102a:	00 
   4102b:	77 14                	ja     41041 <exception+0x1fa>
        current->p_registers.reg_rax = -1; 
   4102d:	48 8b 05 cc 0f 01 00 	mov    0x10fcc(%rip),%rax        # 52000 <current>
   41034:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   4103b:	ff 
        break;
   4103c:	e9 47 02 00 00       	jmp    41288 <exception+0x441>
    }   
    uintptr_t pa = find_page(current->p_pid);
   41041:	48 8b 05 b8 0f 01 00 	mov    0x10fb8(%rip),%rax        # 52000 <current>
   41048:	8b 00                	mov    (%rax),%eax
   4104a:	0f be c0             	movsbl %al,%eax
   4104d:	89 c7                	mov    %eax,%edi
   4104f:	e8 b0 f3 ff ff       	call   40404 <find_page>
   41054:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (pa == 0) {
   41058:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4105d:	75 14                	jne    41073 <exception+0x22c>
        current->p_registers.reg_rax = -1; 
   4105f:	48 8b 05 9a 0f 01 00 	mov    0x10f9a(%rip),%rax        # 52000 <current>
   41066:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   4106d:	ff 
        break;
   4106e:	e9 15 02 00 00       	jmp    41288 <exception+0x441>
    }
    int perm = PTE_P | PTE_W | PTE_U;
   41073:	c7 45 e4 07 00 00 00 	movl   $0x7,-0x1c(%rbp)

    int r = virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, perm);
   4107a:	48 8b 05 7f 0f 01 00 	mov    0x10f7f(%rip),%rax        # 52000 <current>
   41081:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   41088:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   4108b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4108f:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   41093:	41 89 c8             	mov    %ecx,%r8d
   41096:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4109b:	48 89 c7             	mov    %rax,%rdi
   4109e:	e8 c8 21 00 00       	call   4326b <virtual_memory_map>
   410a3:	89 45 e0             	mov    %eax,-0x20(%rbp)

    if (r != 0) {
   410a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
   410aa:	74 46                	je     410f2 <exception+0x2ab>
        // If mapping fails, free the physical page
        pageinfo[PAGENUMBER(pa)].refcount = 0;
   410ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410b0:	48 c1 e8 0c          	shr    $0xc,%rax
   410b4:	48 98                	cltq   
   410b6:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   410ba:	48 8d 05 80 1d 01 00 	lea    0x11d80(%rip),%rax        # 52e41 <pageinfo+0x1>
   410c1:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(pa)].owner = PO_FREE;
   410c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410c9:	48 c1 e8 0c          	shr    $0xc,%rax
   410cd:	48 98                	cltq   
   410cf:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   410d3:	48 8d 05 66 1d 01 00 	lea    0x11d66(%rip),%rax        # 52e40 <pageinfo>
   410da:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        current->p_registers.reg_rax = -1;
   410de:	48 8b 05 1b 0f 01 00 	mov    0x10f1b(%rip),%rax        # 52000 <current>
   410e5:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   410ec:	ff 
        break;
   410ed:	e9 96 01 00 00       	jmp    41288 <exception+0x441>
    }

    // Success: Return 0
    current->p_registers.reg_rax = 0;
   410f2:	48 8b 05 07 0f 01 00 	mov    0x10f07(%rip),%rax        # 52000 <current>
   410f9:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   41100:	00 
    break;
   41101:	e9 82 01 00 00       	jmp    41288 <exception+0x441>
}
// was helped by ULA's on SYS_FORK
case INT_SYS_FORK: {
    
    fork();
   41106:	e8 d7 f9 ff ff       	call   40ae2 <fork>
    break;
   4110b:	e9 78 01 00 00       	jmp    41288 <exception+0x441>

    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   41110:	48 8b 05 e9 0e 01 00 	mov    0x10ee9(%rip),%rax        # 52000 <current>
   41117:	48 89 c7             	mov    %rax,%rdi
   4111a:	e8 72 f6 ff ff       	call   40791 <syscall_mapping>
            break;
   4111f:	e9 64 01 00 00       	jmp    41288 <exception+0x441>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   41124:	48 8b 05 d5 0e 01 00 	mov    0x10ed5(%rip),%rax        # 52000 <current>
   4112b:	48 89 c7             	mov    %rax,%rdi
   4112e:	e8 2b f7 ff ff       	call   4085e <syscall_mem_tog>
	    break;
   41133:	e9 50 01 00 00       	jmp    41288 <exception+0x441>
	}

    case INT_TIMER:
        ++ticks;
   41138:	8b 05 e2 1c 01 00    	mov    0x11ce2(%rip),%eax        # 52e20 <ticks>
   4113e:	83 c0 01             	add    $0x1,%eax
   41141:	89 05 d9 1c 01 00    	mov    %eax,0x11cd9(%rip)        # 52e20 <ticks>
        schedule();
   41147:	e8 65 01 00 00       	call   412b1 <schedule>
        break;                  /* will not be reached */
   4114c:	e9 37 01 00 00       	jmp    41288 <exception+0x441>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   41151:	0f 20 d0             	mov    %cr2,%rax
   41154:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    return val;
   41158:	48 8b 45 b8          	mov    -0x48(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   4115c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   41160:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   41167:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4116e:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   41171:	48 85 c0             	test   %rax,%rax
   41174:	74 09                	je     4117f <exception+0x338>
   41176:	48 8d 05 f3 3a 00 00 	lea    0x3af3(%rip),%rax        # 44c70 <console_clear+0x7e>
   4117d:	eb 07                	jmp    41186 <exception+0x33f>
   4117f:	48 8d 05 f0 3a 00 00 	lea    0x3af0(%rip),%rax        # 44c76 <console_clear+0x84>
        const char* operation = reg->reg_err & PFERR_WRITE
   41186:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   4118a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   41191:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   41198:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   4119b:	48 85 c0             	test   %rax,%rax
   4119e:	74 09                	je     411a9 <exception+0x362>
   411a0:	48 8d 05 d4 3a 00 00 	lea    0x3ad4(%rip),%rax        # 44c7b <console_clear+0x89>
   411a7:	eb 07                	jmp    411b0 <exception+0x369>
   411a9:	48 8d 05 de 3a 00 00 	lea    0x3ade(%rip),%rax        # 44c8e <console_clear+0x9c>
        const char* problem = reg->reg_err & PFERR_PRESENT
   411b0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   411b4:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   411bb:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   411c2:	83 e0 04             	and    $0x4,%eax
   411c5:	48 85 c0             	test   %rax,%rax
   411c8:	75 34                	jne    411fe <exception+0x3b7>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   411ca:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   411d1:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   411d8:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   411dc:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   411e0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   411e4:	49 89 f0             	mov    %rsi,%r8
   411e7:	48 89 c6             	mov    %rax,%rsi
   411ea:	48 8d 05 af 3a 00 00 	lea    0x3aaf(%rip),%rax        # 44ca0 <console_clear+0xae>
   411f1:	48 89 c7             	mov    %rax,%rdi
   411f4:	b8 00 00 00 00       	mov    $0x0,%eax
   411f9:	e8 f9 1b 00 00       	call   42df7 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   411fe:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   41205:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   4120c:	48 8b 05 ed 0d 01 00 	mov    0x10ded(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   41213:	8b 00                	mov    (%rax),%eax
   41215:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
   41219:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   4121d:	52                   	push   %rdx
   4121e:	ff 75 c0             	push   -0x40(%rbp)
   41221:	49 89 f1             	mov    %rsi,%r9
   41224:	49 89 c8             	mov    %rcx,%r8
   41227:	89 c1                	mov    %eax,%ecx
   41229:	48 8d 05 a0 3a 00 00 	lea    0x3aa0(%rip),%rax        # 44cd0 <console_clear+0xde>
   41230:	48 89 c2             	mov    %rax,%rdx
   41233:	be 00 0c 00 00       	mov    $0xc00,%esi
   41238:	bf 80 07 00 00       	mov    $0x780,%edi
   4123d:	b8 00 00 00 00       	mov    $0x0,%eax
   41242:	e8 35 38 00 00       	call   44a7c <console_printf>
   41247:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   4124b:	48 8b 05 ae 0d 01 00 	mov    0x10dae(%rip),%rax        # 52000 <current>
   41252:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   41259:	00 00 00 
        break;
   4125c:	eb 2a                	jmp    41288 <exception+0x441>
    }

case INT_SYS_EXIT: {
    proc *p = current;
   4125e:	48 8b 05 9b 0d 01 00 	mov    0x10d9b(%rip),%rax        # 52000 <current>
   41265:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    exit1(p->p_pid);
   41269:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4126d:	8b 00                	mov    (%rax),%eax
   4126f:	89 c7                	mov    %eax,%edi
   41271:	e8 55 f6 ff ff       	call   408cb <exit1>
    // current->p_registers.reg_rax = -1; 

    break;
   41276:	eb 10                	jmp    41288 <exception+0x441>
}



    default:
        default_exception(current);
   41278:	48 8b 05 81 0d 01 00 	mov    0x10d81(%rip),%rax        # 52000 <current>
   4127f:	48 89 c7             	mov    %rax,%rdi
   41282:	e8 99 1c 00 00       	call   42f20 <default_exception>
        break;                  /* will not be reached */
   41287:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   41288:	48 8b 05 71 0d 01 00 	mov    0x10d71(%rip),%rax        # 52000 <current>
   4128f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41295:	83 f8 01             	cmp    $0x1,%eax
   41298:	75 0f                	jne    412a9 <exception+0x462>
        run(current);
   4129a:	48 8b 05 5f 0d 01 00 	mov    0x10d5f(%rip),%rax        # 52000 <current>
   412a1:	48 89 c7             	mov    %rax,%rdi
   412a4:	e8 87 00 00 00       	call   41330 <run>
    } else {
        schedule();
   412a9:	e8 03 00 00 00       	call   412b1 <schedule>
    }
}
   412ae:	90                   	nop
   412af:	c9                   	leave  
   412b0:	c3                   	ret    

00000000000412b1 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   412b1:	f3 0f 1e fa          	endbr64 
   412b5:	55                   	push   %rbp
   412b6:	48 89 e5             	mov    %rsp,%rbp
   412b9:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   412bd:	48 8b 05 3c 0d 01 00 	mov    0x10d3c(%rip),%rax        # 52000 <current>
   412c4:	8b 00                	mov    (%rax),%eax
   412c6:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   412c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412cc:	83 c0 01             	add    $0x1,%eax
   412cf:	99                   	cltd   
   412d0:	c1 ea 1c             	shr    $0x1c,%edx
   412d3:	01 d0                	add    %edx,%eax
   412d5:	83 e0 0f             	and    $0xf,%eax
   412d8:	29 d0                	sub    %edx,%eax
   412da:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   412dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412e0:	48 63 d0             	movslq %eax,%rdx
   412e3:	48 89 d0             	mov    %rdx,%rax
   412e6:	48 c1 e0 03          	shl    $0x3,%rax
   412ea:	48 29 d0             	sub    %rdx,%rax
   412ed:	48 c1 e0 05          	shl    $0x5,%rax
   412f1:	48 89 c2             	mov    %rax,%rdx
   412f4:	48 8d 05 ed 0d 01 00 	lea    0x10ded(%rip),%rax        # 520e8 <processes+0xc8>
   412fb:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   412fe:	83 f8 01             	cmp    $0x1,%eax
   41301:	75 26                	jne    41329 <schedule+0x78>
            run(&processes[pid]);
   41303:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41306:	48 63 d0             	movslq %eax,%rdx
   41309:	48 89 d0             	mov    %rdx,%rax
   4130c:	48 c1 e0 03          	shl    $0x3,%rax
   41310:	48 29 d0             	sub    %rdx,%rax
   41313:	48 c1 e0 05          	shl    $0x5,%rax
   41317:	48 8d 15 02 0d 01 00 	lea    0x10d02(%rip),%rdx        # 52020 <processes>
   4131e:	48 01 d0             	add    %rdx,%rax
   41321:	48 89 c7             	mov    %rax,%rdi
   41324:	e8 07 00 00 00       	call   41330 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   41329:	e8 67 19 00 00       	call   42c95 <check_keyboard>
        pid = (pid + 1) % NPROC;
   4132e:	eb 99                	jmp    412c9 <schedule+0x18>

0000000000041330 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   41330:	f3 0f 1e fa          	endbr64 
   41334:	55                   	push   %rbp
   41335:	48 89 e5             	mov    %rsp,%rbp
   41338:	48 83 ec 10          	sub    $0x10,%rsp
   4133c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   41340:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41344:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   4134a:	83 f8 01             	cmp    $0x1,%eax
   4134d:	74 1e                	je     4136d <run+0x3d>
   4134f:	48 8d 05 56 3a 00 00 	lea    0x3a56(%rip),%rax        # 44dac <console_clear+0x1ba>
   41356:	48 89 c2             	mov    %rax,%rdx
   41359:	be 38 02 00 00       	mov    $0x238,%esi
   4135e:	48 8d 05 fb 38 00 00 	lea    0x38fb(%rip),%rax        # 44c60 <console_clear+0x6e>
   41365:	48 89 c7             	mov    %rax,%rdi
   41368:	e8 7a 1b 00 00       	call   42ee7 <assert_fail>
    current = p;
   4136d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41371:	48 89 05 88 0c 01 00 	mov    %rax,0x10c88(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   41378:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4137c:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   41383:	48 89 c7             	mov    %rax,%rdi
   41386:	e8 6e 1d 00 00       	call   430f9 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   4138b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4138f:	48 83 c0 08          	add    $0x8,%rax
   41393:	48 89 c7             	mov    %rax,%rdi
   41396:	e8 28 ed ff ff       	call   400c3 <exception_return>

000000000004139b <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   4139b:	f3 0f 1e fa          	endbr64 
   4139f:	55                   	push   %rbp
   413a0:	48 89 e5             	mov    %rsp,%rbp
   413a3:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   413a7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   413ae:	00 
   413af:	e9 93 00 00 00       	jmp    41447 <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   413b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413b8:	48 89 c7             	mov    %rax,%rdi
   413bb:	e8 0f 11 00 00       	call   424cf <physical_memory_isreserved>
   413c0:	85 c0                	test   %eax,%eax
   413c2:	74 09                	je     413cd <pageinfo_init+0x32>
            owner = PO_RESERVED;
   413c4:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   413cb:	eb 31                	jmp    413fe <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   413cd:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   413d4:	00 
   413d5:	76 0d                	jbe    413e4 <pageinfo_init+0x49>
   413d7:	48 8d 05 2a 9c 01 00 	lea    0x19c2a(%rip),%rax        # 5b008 <end>
   413de:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413e2:	72 0a                	jb     413ee <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   413e4:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   413eb:	00 
   413ec:	75 09                	jne    413f7 <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   413ee:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   413f5:	eb 07                	jmp    413fe <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   413f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   413fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41402:	48 c1 e8 0c          	shr    $0xc,%rax
   41406:	89 c2                	mov    %eax,%edx
   41408:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4140b:	89 c1                	mov    %eax,%ecx
   4140d:	48 63 c2             	movslq %edx,%rax
   41410:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41414:	48 8d 05 25 1a 01 00 	lea    0x11a25(%rip),%rax        # 52e40 <pageinfo>
   4141b:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   4141e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41422:	0f 95 c2             	setne  %dl
   41425:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41429:	48 c1 e8 0c          	shr    $0xc,%rax
   4142d:	89 d1                	mov    %edx,%ecx
   4142f:	48 98                	cltq   
   41431:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41435:	48 8d 05 05 1a 01 00 	lea    0x11a05(%rip),%rax        # 52e41 <pageinfo+0x1>
   4143c:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4143f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41446:	00 
   41447:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4144e:	00 
   4144f:	0f 86 5f ff ff ff    	jbe    413b4 <pageinfo_init+0x19>
    }
}
   41455:	90                   	nop
   41456:	90                   	nop
   41457:	c9                   	leave  
   41458:	c3                   	ret    

0000000000041459 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   41459:	f3 0f 1e fa          	endbr64 
   4145d:	55                   	push   %rbp
   4145e:	48 89 e5             	mov    %rsp,%rbp
   41461:	48 83 ec 50          	sub    $0x50,%rsp
   41465:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   41469:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4146d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41473:	48 89 c2             	mov    %rax,%rdx
   41476:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4147a:	48 39 c2             	cmp    %rax,%rdx
   4147d:	74 1e                	je     4149d <check_page_table_mappings+0x44>
   4147f:	48 8d 05 42 39 00 00 	lea    0x3942(%rip),%rax        # 44dc8 <console_clear+0x1d6>
   41486:	48 89 c2             	mov    %rax,%rdx
   41489:	be 62 02 00 00       	mov    $0x262,%esi
   4148e:	48 8d 05 cb 37 00 00 	lea    0x37cb(%rip),%rax        # 44c60 <console_clear+0x6e>
   41495:	48 89 c7             	mov    %rax,%rdi
   41498:	e8 4a 1a 00 00       	call   42ee7 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   4149d:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   414a4:	00 
   414a5:	e9 b5 00 00 00       	jmp    4155f <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   414aa:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   414ae:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   414b2:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   414b6:	48 89 ce             	mov    %rcx,%rsi
   414b9:	48 89 c7             	mov    %rax,%rdi
   414bc:	e8 f4 21 00 00       	call   436b5 <virtual_memory_lookup>
        if (vam.pa != va) {
   414c1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   414c5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   414c9:	74 2c                	je     414f7 <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   414cb:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   414cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414d3:	49 89 d0             	mov    %rdx,%r8
   414d6:	48 89 c1             	mov    %rax,%rcx
   414d9:	48 8d 05 07 39 00 00 	lea    0x3907(%rip),%rax        # 44de7 <console_clear+0x1f5>
   414e0:	48 89 c2             	mov    %rax,%rdx
   414e3:	be 00 c0 00 00       	mov    $0xc000,%esi
   414e8:	bf e0 06 00 00       	mov    $0x6e0,%edi
   414ed:	b8 00 00 00 00       	mov    $0x0,%eax
   414f2:	e8 85 35 00 00       	call   44a7c <console_printf>
        }
        assert(vam.pa == va);
   414f7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   414fb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   414ff:	74 1e                	je     4151f <check_page_table_mappings+0xc6>
   41501:	48 8d 05 e9 38 00 00 	lea    0x38e9(%rip),%rax        # 44df1 <console_clear+0x1ff>
   41508:	48 89 c2             	mov    %rax,%rdx
   4150b:	be 6b 02 00 00       	mov    $0x26b,%esi
   41510:	48 8d 05 49 37 00 00 	lea    0x3749(%rip),%rax        # 44c60 <console_clear+0x6e>
   41517:	48 89 c7             	mov    %rax,%rdi
   4151a:	e8 c8 19 00 00       	call   42ee7 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   4151f:	48 8d 05 da 4a 00 00 	lea    0x4ada(%rip),%rax        # 46000 <disp_global>
   41526:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4152a:	72 2b                	jb     41557 <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   4152c:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4152f:	48 98                	cltq   
   41531:	83 e0 02             	and    $0x2,%eax
   41534:	48 85 c0             	test   %rax,%rax
   41537:	75 1e                	jne    41557 <check_page_table_mappings+0xfe>
   41539:	48 8d 05 be 38 00 00 	lea    0x38be(%rip),%rax        # 44dfe <console_clear+0x20c>
   41540:	48 89 c2             	mov    %rax,%rdx
   41543:	be 6d 02 00 00       	mov    $0x26d,%esi
   41548:	48 8d 05 11 37 00 00 	lea    0x3711(%rip),%rax        # 44c60 <console_clear+0x6e>
   4154f:	48 89 c7             	mov    %rax,%rdi
   41552:	e8 90 19 00 00       	call   42ee7 <assert_fail>
         va += PAGESIZE) {
   41557:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4155e:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   4155f:	48 8d 05 a2 9a 01 00 	lea    0x19aa2(%rip),%rax        # 5b008 <end>
   41566:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4156a:	0f 82 3a ff ff ff    	jb     414aa <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41570:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   41577:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   41578:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   4157c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41580:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41584:	48 89 ce             	mov    %rcx,%rsi
   41587:	48 89 c7             	mov    %rax,%rdi
   4158a:	e8 26 21 00 00       	call   436b5 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   4158f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41593:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   41597:	74 1e                	je     415b7 <check_page_table_mappings+0x15e>
   41599:	48 8d 05 6f 38 00 00 	lea    0x386f(%rip),%rax        # 44e0f <console_clear+0x21d>
   415a0:	48 89 c2             	mov    %rax,%rdx
   415a3:	be 74 02 00 00       	mov    $0x274,%esi
   415a8:	48 8d 05 b1 36 00 00 	lea    0x36b1(%rip),%rax        # 44c60 <console_clear+0x6e>
   415af:	48 89 c7             	mov    %rax,%rdi
   415b2:	e8 30 19 00 00       	call   42ee7 <assert_fail>
    assert(vam.perm & PTE_W);
   415b7:	8b 45 e8             	mov    -0x18(%rbp),%eax
   415ba:	48 98                	cltq   
   415bc:	83 e0 02             	and    $0x2,%eax
   415bf:	48 85 c0             	test   %rax,%rax
   415c2:	75 1e                	jne    415e2 <check_page_table_mappings+0x189>
   415c4:	48 8d 05 33 38 00 00 	lea    0x3833(%rip),%rax        # 44dfe <console_clear+0x20c>
   415cb:	48 89 c2             	mov    %rax,%rdx
   415ce:	be 75 02 00 00       	mov    $0x275,%esi
   415d3:	48 8d 05 86 36 00 00 	lea    0x3686(%rip),%rax        # 44c60 <console_clear+0x6e>
   415da:	48 89 c7             	mov    %rax,%rdi
   415dd:	e8 05 19 00 00       	call   42ee7 <assert_fail>
}
   415e2:	90                   	nop
   415e3:	c9                   	leave  
   415e4:	c3                   	ret    

00000000000415e5 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   415e5:	f3 0f 1e fa          	endbr64 
   415e9:	55                   	push   %rbp
   415ea:	48 89 e5             	mov    %rsp,%rbp
   415ed:	48 83 ec 20          	sub    $0x20,%rsp
   415f1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   415f5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   415f8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   415fb:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   415fe:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41605:	48 8b 05 f4 39 01 00 	mov    0x139f4(%rip),%rax        # 55000 <kernel_pagetable>
   4160c:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41610:	75 71                	jne    41683 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   41612:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41619:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41620:	eb 5b                	jmp    4167d <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   41622:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41625:	48 63 d0             	movslq %eax,%rdx
   41628:	48 89 d0             	mov    %rdx,%rax
   4162b:	48 c1 e0 03          	shl    $0x3,%rax
   4162f:	48 29 d0             	sub    %rdx,%rax
   41632:	48 c1 e0 05          	shl    $0x5,%rax
   41636:	48 89 c2             	mov    %rax,%rdx
   41639:	48 8d 05 a8 0a 01 00 	lea    0x10aa8(%rip),%rax        # 520e8 <processes+0xc8>
   41640:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41643:	85 c0                	test   %eax,%eax
   41645:	74 32                	je     41679 <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41647:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4164a:	48 63 d0             	movslq %eax,%rdx
   4164d:	48 89 d0             	mov    %rdx,%rax
   41650:	48 c1 e0 03          	shl    $0x3,%rax
   41654:	48 29 d0             	sub    %rdx,%rax
   41657:	48 c1 e0 05          	shl    $0x5,%rax
   4165b:	48 89 c2             	mov    %rax,%rdx
   4165e:	48 8d 05 8b 0a 01 00 	lea    0x10a8b(%rip),%rax        # 520f0 <processes+0xd0>
   41665:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   41669:	48 8b 05 90 39 01 00 	mov    0x13990(%rip),%rax        # 55000 <kernel_pagetable>
   41670:	48 39 c2             	cmp    %rax,%rdx
   41673:	75 04                	jne    41679 <check_page_table_ownership+0x94>
                ++expected_refcount;
   41675:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41679:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4167d:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41681:	7e 9f                	jle    41622 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41683:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41686:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41689:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4168d:	be 00 00 00 00       	mov    $0x0,%esi
   41692:	48 89 c7             	mov    %rax,%rdi
   41695:	e8 03 00 00 00       	call   4169d <check_page_table_ownership_level>
}
   4169a:	90                   	nop
   4169b:	c9                   	leave  
   4169c:	c3                   	ret    

000000000004169d <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   4169d:	f3 0f 1e fa          	endbr64 
   416a1:	55                   	push   %rbp
   416a2:	48 89 e5             	mov    %rsp,%rbp
   416a5:	48 83 ec 30          	sub    $0x30,%rsp
   416a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   416ad:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   416b0:	89 55 e0             	mov    %edx,-0x20(%rbp)
   416b3:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   416b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   416ba:	48 c1 e8 0c          	shr    $0xc,%rax
   416be:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   416c3:	7e 1e                	jle    416e3 <check_page_table_ownership_level+0x46>
   416c5:	48 8d 05 54 37 00 00 	lea    0x3754(%rip),%rax        # 44e20 <console_clear+0x22e>
   416cc:	48 89 c2             	mov    %rax,%rdx
   416cf:	be 92 02 00 00       	mov    $0x292,%esi
   416d4:	48 8d 05 85 35 00 00 	lea    0x3585(%rip),%rax        # 44c60 <console_clear+0x6e>
   416db:	48 89 c7             	mov    %rax,%rdi
   416de:	e8 04 18 00 00       	call   42ee7 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   416e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   416e7:	48 c1 e8 0c          	shr    $0xc,%rax
   416eb:	48 98                	cltq   
   416ed:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   416f1:	48 8d 05 48 17 01 00 	lea    0x11748(%rip),%rax        # 52e40 <pageinfo>
   416f8:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   416fc:	0f be c0             	movsbl %al,%eax
   416ff:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41702:	74 1e                	je     41722 <check_page_table_ownership_level+0x85>
   41704:	48 8d 05 2d 37 00 00 	lea    0x372d(%rip),%rax        # 44e38 <console_clear+0x246>
   4170b:	48 89 c2             	mov    %rax,%rdx
   4170e:	be 93 02 00 00       	mov    $0x293,%esi
   41713:	48 8d 05 46 35 00 00 	lea    0x3546(%rip),%rax        # 44c60 <console_clear+0x6e>
   4171a:	48 89 c7             	mov    %rax,%rdi
   4171d:	e8 c5 17 00 00       	call   42ee7 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41722:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41726:	48 c1 e8 0c          	shr    $0xc,%rax
   4172a:	48 98                	cltq   
   4172c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41730:	48 8d 05 0a 17 01 00 	lea    0x1170a(%rip),%rax        # 52e41 <pageinfo+0x1>
   41737:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4173b:	0f be c0             	movsbl %al,%eax
   4173e:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41741:	74 1e                	je     41761 <check_page_table_ownership_level+0xc4>
   41743:	48 8d 05 16 37 00 00 	lea    0x3716(%rip),%rax        # 44e60 <console_clear+0x26e>
   4174a:	48 89 c2             	mov    %rax,%rdx
   4174d:	be 94 02 00 00       	mov    $0x294,%esi
   41752:	48 8d 05 07 35 00 00 	lea    0x3507(%rip),%rax        # 44c60 <console_clear+0x6e>
   41759:	48 89 c7             	mov    %rax,%rdi
   4175c:	e8 86 17 00 00       	call   42ee7 <assert_fail>
    if (level < 3) {
   41761:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41765:	7f 5b                	jg     417c2 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41767:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4176e:	eb 49                	jmp    417b9 <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   41770:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41774:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41777:	48 63 d2             	movslq %edx,%rdx
   4177a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4177e:	48 85 c0             	test   %rax,%rax
   41781:	74 32                	je     417b5 <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41783:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41787:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4178a:	48 63 d2             	movslq %edx,%rdx
   4178d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41791:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41797:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4179b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4179e:	8d 70 01             	lea    0x1(%rax),%esi
   417a1:	8b 55 e0             	mov    -0x20(%rbp),%edx
   417a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   417a8:	b9 01 00 00 00       	mov    $0x1,%ecx
   417ad:	48 89 c7             	mov    %rax,%rdi
   417b0:	e8 e8 fe ff ff       	call   4169d <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   417b5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   417b9:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   417c0:	7e ae                	jle    41770 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   417c2:	90                   	nop
   417c3:	c9                   	leave  
   417c4:	c3                   	ret    

00000000000417c5 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   417c5:	f3 0f 1e fa          	endbr64 
   417c9:	55                   	push   %rbp
   417ca:	48 89 e5             	mov    %rsp,%rbp
   417cd:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   417d1:	8b 05 11 09 01 00    	mov    0x10911(%rip),%eax        # 520e8 <processes+0xc8>
   417d7:	85 c0                	test   %eax,%eax
   417d9:	74 1e                	je     417f9 <check_virtual_memory+0x34>
   417db:	48 8d 05 ae 36 00 00 	lea    0x36ae(%rip),%rax        # 44e90 <console_clear+0x29e>
   417e2:	48 89 c2             	mov    %rax,%rdx
   417e5:	be a7 02 00 00       	mov    $0x2a7,%esi
   417ea:	48 8d 05 6f 34 00 00 	lea    0x346f(%rip),%rax        # 44c60 <console_clear+0x6e>
   417f1:	48 89 c7             	mov    %rax,%rdi
   417f4:	e8 ee 16 00 00       	call   42ee7 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   417f9:	48 8b 05 00 38 01 00 	mov    0x13800(%rip),%rax        # 55000 <kernel_pagetable>
   41800:	48 89 c7             	mov    %rax,%rdi
   41803:	e8 51 fc ff ff       	call   41459 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41808:	48 8b 05 f1 37 01 00 	mov    0x137f1(%rip),%rax        # 55000 <kernel_pagetable>
   4180f:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41814:	48 89 c7             	mov    %rax,%rdi
   41817:	e8 c9 fd ff ff       	call   415e5 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   4181c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41823:	e9 b4 00 00 00       	jmp    418dc <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   41828:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4182b:	48 63 d0             	movslq %eax,%rdx
   4182e:	48 89 d0             	mov    %rdx,%rax
   41831:	48 c1 e0 03          	shl    $0x3,%rax
   41835:	48 29 d0             	sub    %rdx,%rax
   41838:	48 c1 e0 05          	shl    $0x5,%rax
   4183c:	48 89 c2             	mov    %rax,%rdx
   4183f:	48 8d 05 a2 08 01 00 	lea    0x108a2(%rip),%rax        # 520e8 <processes+0xc8>
   41846:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41849:	85 c0                	test   %eax,%eax
   4184b:	0f 84 87 00 00 00    	je     418d8 <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41851:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41854:	48 63 d0             	movslq %eax,%rdx
   41857:	48 89 d0             	mov    %rdx,%rax
   4185a:	48 c1 e0 03          	shl    $0x3,%rax
   4185e:	48 29 d0             	sub    %rdx,%rax
   41861:	48 c1 e0 05          	shl    $0x5,%rax
   41865:	48 89 c2             	mov    %rax,%rdx
   41868:	48 8d 05 81 08 01 00 	lea    0x10881(%rip),%rax        # 520f0 <processes+0xd0>
   4186f:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   41873:	48 8b 05 86 37 01 00 	mov    0x13786(%rip),%rax        # 55000 <kernel_pagetable>
   4187a:	48 39 c2             	cmp    %rax,%rdx
   4187d:	74 59                	je     418d8 <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   4187f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41882:	48 63 d0             	movslq %eax,%rdx
   41885:	48 89 d0             	mov    %rdx,%rax
   41888:	48 c1 e0 03          	shl    $0x3,%rax
   4188c:	48 29 d0             	sub    %rdx,%rax
   4188f:	48 c1 e0 05          	shl    $0x5,%rax
   41893:	48 89 c2             	mov    %rax,%rdx
   41896:	48 8d 05 53 08 01 00 	lea    0x10853(%rip),%rax        # 520f0 <processes+0xd0>
   4189d:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   418a1:	48 89 c7             	mov    %rax,%rdi
   418a4:	e8 b0 fb ff ff       	call   41459 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   418a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418ac:	48 63 d0             	movslq %eax,%rdx
   418af:	48 89 d0             	mov    %rdx,%rax
   418b2:	48 c1 e0 03          	shl    $0x3,%rax
   418b6:	48 29 d0             	sub    %rdx,%rax
   418b9:	48 c1 e0 05          	shl    $0x5,%rax
   418bd:	48 89 c2             	mov    %rax,%rdx
   418c0:	48 8d 05 29 08 01 00 	lea    0x10829(%rip),%rax        # 520f0 <processes+0xd0>
   418c7:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   418cb:	8b 55 fc             	mov    -0x4(%rbp),%edx
   418ce:	89 d6                	mov    %edx,%esi
   418d0:	48 89 c7             	mov    %rax,%rdi
   418d3:	e8 0d fd ff ff       	call   415e5 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   418d8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   418dc:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   418e0:	0f 8e 42 ff ff ff    	jle    41828 <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   418e6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   418ed:	e9 8b 00 00 00       	jmp    4197d <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   418f2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   418f5:	48 98                	cltq   
   418f7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   418fb:	48 8d 05 3f 15 01 00 	lea    0x1153f(%rip),%rax        # 52e41 <pageinfo+0x1>
   41902:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41906:	84 c0                	test   %al,%al
   41908:	7e 6f                	jle    41979 <check_virtual_memory+0x1b4>
   4190a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4190d:	48 98                	cltq   
   4190f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41913:	48 8d 05 26 15 01 00 	lea    0x11526(%rip),%rax        # 52e40 <pageinfo>
   4191a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4191e:	84 c0                	test   %al,%al
   41920:	78 57                	js     41979 <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41922:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41925:	48 98                	cltq   
   41927:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4192b:	48 8d 05 0e 15 01 00 	lea    0x1150e(%rip),%rax        # 52e40 <pageinfo>
   41932:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41936:	0f be c0             	movsbl %al,%eax
   41939:	48 63 d0             	movslq %eax,%rdx
   4193c:	48 89 d0             	mov    %rdx,%rax
   4193f:	48 c1 e0 03          	shl    $0x3,%rax
   41943:	48 29 d0             	sub    %rdx,%rax
   41946:	48 c1 e0 05          	shl    $0x5,%rax
   4194a:	48 89 c2             	mov    %rax,%rdx
   4194d:	48 8d 05 94 07 01 00 	lea    0x10794(%rip),%rax        # 520e8 <processes+0xc8>
   41954:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41957:	85 c0                	test   %eax,%eax
   41959:	75 1e                	jne    41979 <check_virtual_memory+0x1b4>
   4195b:	48 8d 05 4e 35 00 00 	lea    0x354e(%rip),%rax        # 44eb0 <console_clear+0x2be>
   41962:	48 89 c2             	mov    %rax,%rdx
   41965:	be be 02 00 00       	mov    $0x2be,%esi
   4196a:	48 8d 05 ef 32 00 00 	lea    0x32ef(%rip),%rax        # 44c60 <console_clear+0x6e>
   41971:	48 89 c7             	mov    %rax,%rdi
   41974:	e8 6e 15 00 00       	call   42ee7 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41979:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4197d:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41984:	0f 8e 68 ff ff ff    	jle    418f2 <check_virtual_memory+0x12d>
        }
    }
}
   4198a:	90                   	nop
   4198b:	90                   	nop
   4198c:	c9                   	leave  
   4198d:	c3                   	ret    

000000000004198e <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   4198e:	f3 0f 1e fa          	endbr64 
   41992:	55                   	push   %rbp
   41993:	48 89 e5             	mov    %rsp,%rbp
   41996:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4199a:	48 8d 05 65 35 00 00 	lea    0x3565(%rip),%rax        # 44f06 <memstate_colors+0x26>
   419a1:	48 89 c2             	mov    %rax,%rdx
   419a4:	be 00 0f 00 00       	mov    $0xf00,%esi
   419a9:	bf 20 00 00 00       	mov    $0x20,%edi
   419ae:	b8 00 00 00 00       	mov    $0x0,%eax
   419b3:	e8 c4 30 00 00       	call   44a7c <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   419b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   419bf:	e9 1b 01 00 00       	jmp    41adf <memshow_physical+0x151>
        if (pn % 64 == 0) {
   419c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419c7:	83 e0 3f             	and    $0x3f,%eax
   419ca:	85 c0                	test   %eax,%eax
   419cc:	75 40                	jne    41a0e <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   419ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419d1:	c1 e0 0c             	shl    $0xc,%eax
   419d4:	89 c2                	mov    %eax,%edx
   419d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419d9:	8d 48 3f             	lea    0x3f(%rax),%ecx
   419dc:	85 c0                	test   %eax,%eax
   419de:	0f 48 c1             	cmovs  %ecx,%eax
   419e1:	c1 f8 06             	sar    $0x6,%eax
   419e4:	8d 48 01             	lea    0x1(%rax),%ecx
   419e7:	89 c8                	mov    %ecx,%eax
   419e9:	c1 e0 02             	shl    $0x2,%eax
   419ec:	01 c8                	add    %ecx,%eax
   419ee:	c1 e0 04             	shl    $0x4,%eax
   419f1:	83 c0 03             	add    $0x3,%eax
   419f4:	89 d1                	mov    %edx,%ecx
   419f6:	48 8d 15 19 35 00 00 	lea    0x3519(%rip),%rdx        # 44f16 <memstate_colors+0x36>
   419fd:	be 00 0f 00 00       	mov    $0xf00,%esi
   41a02:	89 c7                	mov    %eax,%edi
   41a04:	b8 00 00 00 00       	mov    $0x0,%eax
   41a09:	e8 6e 30 00 00       	call   44a7c <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41a0e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a11:	48 98                	cltq   
   41a13:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41a17:	48 8d 05 22 14 01 00 	lea    0x11422(%rip),%rax        # 52e40 <pageinfo>
   41a1e:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41a22:	0f be c0             	movsbl %al,%eax
   41a25:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41a28:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a2b:	48 98                	cltq   
   41a2d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41a31:	48 8d 05 09 14 01 00 	lea    0x11409(%rip),%rax        # 52e41 <pageinfo+0x1>
   41a38:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41a3c:	84 c0                	test   %al,%al
   41a3e:	75 07                	jne    41a47 <memshow_physical+0xb9>
            owner = PO_FREE;
   41a40:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41a47:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41a4a:	83 c0 02             	add    $0x2,%eax
   41a4d:	48 98                	cltq   
   41a4f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41a53:	48 8d 05 86 34 00 00 	lea    0x3486(%rip),%rax        # 44ee0 <memstate_colors>
   41a5a:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41a5e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41a62:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a65:	48 98                	cltq   
   41a67:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41a6b:	48 8d 05 cf 13 01 00 	lea    0x113cf(%rip),%rax        # 52e41 <pageinfo+0x1>
   41a72:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41a76:	3c 01                	cmp    $0x1,%al
   41a78:	7e 1c                	jle    41a96 <memshow_physical+0x108>
   41a7a:	48 8d 05 7f 65 07 00 	lea    0x7657f(%rip),%rax        # b8000 <console>
   41a81:	48 c1 e8 0c          	shr    $0xc,%rax
   41a85:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41a88:	74 0c                	je     41a96 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41a8a:	b8 53 00 00 00       	mov    $0x53,%eax
   41a8f:	80 cc 0f             	or     $0xf,%ah
   41a92:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41a96:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a99:	8d 50 3f             	lea    0x3f(%rax),%edx
   41a9c:	85 c0                	test   %eax,%eax
   41a9e:	0f 48 c2             	cmovs  %edx,%eax
   41aa1:	c1 f8 06             	sar    $0x6,%eax
   41aa4:	8d 50 01             	lea    0x1(%rax),%edx
   41aa7:	89 d0                	mov    %edx,%eax
   41aa9:	c1 e0 02             	shl    $0x2,%eax
   41aac:	01 d0                	add    %edx,%eax
   41aae:	c1 e0 04             	shl    $0x4,%eax
   41ab1:	89 c1                	mov    %eax,%ecx
   41ab3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ab6:	99                   	cltd   
   41ab7:	c1 ea 1a             	shr    $0x1a,%edx
   41aba:	01 d0                	add    %edx,%eax
   41abc:	83 e0 3f             	and    $0x3f,%eax
   41abf:	29 d0                	sub    %edx,%eax
   41ac1:	83 c0 0c             	add    $0xc,%eax
   41ac4:	01 c8                	add    %ecx,%eax
   41ac6:	48 98                	cltq   
   41ac8:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41acc:	48 8d 15 2d 65 07 00 	lea    0x7652d(%rip),%rdx        # b8000 <console>
   41ad3:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41ad7:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41adb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41adf:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41ae6:	0f 8e d8 fe ff ff    	jle    419c4 <memshow_physical+0x36>
    }
}
   41aec:	90                   	nop
   41aed:	90                   	nop
   41aee:	c9                   	leave  
   41aef:	c3                   	ret    

0000000000041af0 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41af0:	f3 0f 1e fa          	endbr64 
   41af4:	55                   	push   %rbp
   41af5:	48 89 e5             	mov    %rsp,%rbp
   41af8:	48 83 ec 40          	sub    $0x40,%rsp
   41afc:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41b00:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41b04:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41b08:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41b0e:	48 89 c2             	mov    %rax,%rdx
   41b11:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41b15:	48 39 c2             	cmp    %rax,%rdx
   41b18:	74 1e                	je     41b38 <memshow_virtual+0x48>
   41b1a:	48 8d 05 ff 33 00 00 	lea    0x33ff(%rip),%rax        # 44f20 <memstate_colors+0x40>
   41b21:	48 89 c2             	mov    %rax,%rdx
   41b24:	be ef 02 00 00       	mov    $0x2ef,%esi
   41b29:	48 8d 05 30 31 00 00 	lea    0x3130(%rip),%rax        # 44c60 <console_clear+0x6e>
   41b30:	48 89 c7             	mov    %rax,%rdi
   41b33:	e8 af 13 00 00       	call   42ee7 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41b38:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41b3c:	48 89 c1             	mov    %rax,%rcx
   41b3f:	48 8d 05 07 34 00 00 	lea    0x3407(%rip),%rax        # 44f4d <memstate_colors+0x6d>
   41b46:	48 89 c2             	mov    %rax,%rdx
   41b49:	be 00 0f 00 00       	mov    $0xf00,%esi
   41b4e:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41b53:	b8 00 00 00 00       	mov    $0x0,%eax
   41b58:	e8 1f 2f 00 00       	call   44a7c <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41b5d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41b64:	00 
   41b65:	e9 b4 01 00 00       	jmp    41d1e <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41b6a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41b6e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41b72:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41b76:	48 89 ce             	mov    %rcx,%rsi
   41b79:	48 89 c7             	mov    %rax,%rdi
   41b7c:	e8 34 1b 00 00       	call   436b5 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41b81:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41b84:	85 c0                	test   %eax,%eax
   41b86:	79 0b                	jns    41b93 <memshow_virtual+0xa3>
            color = ' ';
   41b88:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41b8e:	e9 ff 00 00 00       	jmp    41c92 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41b93:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41b97:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41b9d:	76 1e                	jbe    41bbd <memshow_virtual+0xcd>
   41b9f:	48 8d 05 c4 33 00 00 	lea    0x33c4(%rip),%rax        # 44f6a <memstate_colors+0x8a>
   41ba6:	48 89 c2             	mov    %rax,%rdx
   41ba9:	be f8 02 00 00       	mov    $0x2f8,%esi
   41bae:	48 8d 05 ab 30 00 00 	lea    0x30ab(%rip),%rax        # 44c60 <console_clear+0x6e>
   41bb5:	48 89 c7             	mov    %rax,%rdi
   41bb8:	e8 2a 13 00 00       	call   42ee7 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41bbd:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41bc0:	48 98                	cltq   
   41bc2:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41bc6:	48 8d 05 73 12 01 00 	lea    0x11273(%rip),%rax        # 52e40 <pageinfo>
   41bcd:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41bd1:	0f be c0             	movsbl %al,%eax
   41bd4:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41bd7:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41bda:	48 98                	cltq   
   41bdc:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41be0:	48 8d 05 5a 12 01 00 	lea    0x1125a(%rip),%rax        # 52e41 <pageinfo+0x1>
   41be7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41beb:	84 c0                	test   %al,%al
   41bed:	75 07                	jne    41bf6 <memshow_virtual+0x106>
                owner = PO_FREE;
   41bef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41bf6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41bf9:	83 c0 02             	add    $0x2,%eax
   41bfc:	48 98                	cltq   
   41bfe:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41c02:	48 8d 05 d7 32 00 00 	lea    0x32d7(%rip),%rax        # 44ee0 <memstate_colors>
   41c09:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41c0d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41c11:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41c14:	48 98                	cltq   
   41c16:	83 e0 04             	and    $0x4,%eax
   41c19:	48 85 c0             	test   %rax,%rax
   41c1c:	74 27                	je     41c45 <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41c1e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c22:	c1 e0 04             	shl    $0x4,%eax
   41c25:	66 25 00 f0          	and    $0xf000,%ax
   41c29:	89 c2                	mov    %eax,%edx
   41c2b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c2f:	c1 f8 04             	sar    $0x4,%eax
   41c32:	66 25 00 0f          	and    $0xf00,%ax
   41c36:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41c38:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c3c:	0f b6 c0             	movzbl %al,%eax
   41c3f:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41c41:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41c45:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41c48:	48 98                	cltq   
   41c4a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41c4e:	48 8d 05 ec 11 01 00 	lea    0x111ec(%rip),%rax        # 52e41 <pageinfo+0x1>
   41c55:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41c59:	3c 01                	cmp    $0x1,%al
   41c5b:	7e 35                	jle    41c92 <memshow_virtual+0x1a2>
   41c5d:	48 8d 05 9c 63 07 00 	lea    0x7639c(%rip),%rax        # b8000 <console>
   41c64:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41c68:	74 28                	je     41c92 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41c6a:	b8 53 00 00 00       	mov    $0x53,%eax
   41c6f:	89 c2                	mov    %eax,%edx
   41c71:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c75:	66 25 00 f0          	and    $0xf000,%ax
   41c79:	09 d0                	or     %edx,%eax
   41c7b:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41c7f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41c82:	48 98                	cltq   
   41c84:	83 e0 04             	and    $0x4,%eax
   41c87:	48 85 c0             	test   %rax,%rax
   41c8a:	75 06                	jne    41c92 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   41c8c:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41c92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c96:	48 c1 e8 0c          	shr    $0xc,%rax
   41c9a:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41c9d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41ca0:	83 e0 3f             	and    $0x3f,%eax
   41ca3:	85 c0                	test   %eax,%eax
   41ca5:	75 39                	jne    41ce0 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41ca7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41caa:	c1 e8 06             	shr    $0x6,%eax
   41cad:	89 c2                	mov    %eax,%edx
   41caf:	89 d0                	mov    %edx,%eax
   41cb1:	c1 e0 02             	shl    $0x2,%eax
   41cb4:	01 d0                	add    %edx,%eax
   41cb6:	c1 e0 04             	shl    $0x4,%eax
   41cb9:	05 73 03 00 00       	add    $0x373,%eax
   41cbe:	89 c7                	mov    %eax,%edi
   41cc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41cc4:	48 89 c1             	mov    %rax,%rcx
   41cc7:	48 8d 05 48 32 00 00 	lea    0x3248(%rip),%rax        # 44f16 <memstate_colors+0x36>
   41cce:	48 89 c2             	mov    %rax,%rdx
   41cd1:	be 00 0f 00 00       	mov    $0xf00,%esi
   41cd6:	b8 00 00 00 00       	mov    $0x0,%eax
   41cdb:	e8 9c 2d 00 00       	call   44a7c <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41ce0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41ce3:	c1 e8 06             	shr    $0x6,%eax
   41ce6:	89 c2                	mov    %eax,%edx
   41ce8:	89 d0                	mov    %edx,%eax
   41cea:	c1 e0 02             	shl    $0x2,%eax
   41ced:	01 d0                	add    %edx,%eax
   41cef:	c1 e0 04             	shl    $0x4,%eax
   41cf2:	89 c2                	mov    %eax,%edx
   41cf4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41cf7:	83 e0 3f             	and    $0x3f,%eax
   41cfa:	01 d0                	add    %edx,%eax
   41cfc:	05 7c 03 00 00       	add    $0x37c,%eax
   41d01:	89 c0                	mov    %eax,%eax
   41d03:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41d07:	48 8d 15 f2 62 07 00 	lea    0x762f2(%rip),%rdx        # b8000 <console>
   41d0e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41d12:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41d16:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41d1d:	00 
   41d1e:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41d25:	00 
   41d26:	0f 86 3e fe ff ff    	jbe    41b6a <memshow_virtual+0x7a>
    }
}
   41d2c:	90                   	nop
   41d2d:	90                   	nop
   41d2e:	c9                   	leave  
   41d2f:	c3                   	ret    

0000000000041d30 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41d30:	f3 0f 1e fa          	endbr64 
   41d34:	55                   	push   %rbp
   41d35:	48 89 e5             	mov    %rsp,%rbp
   41d38:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41d3c:	8b 05 fe 14 01 00    	mov    0x114fe(%rip),%eax        # 53240 <last_ticks.1>
   41d42:	85 c0                	test   %eax,%eax
   41d44:	74 13                	je     41d59 <memshow_virtual_animate+0x29>
   41d46:	8b 05 d4 10 01 00    	mov    0x110d4(%rip),%eax        # 52e20 <ticks>
   41d4c:	8b 15 ee 14 01 00    	mov    0x114ee(%rip),%edx        # 53240 <last_ticks.1>
   41d52:	29 d0                	sub    %edx,%eax
   41d54:	83 f8 31             	cmp    $0x31,%eax
   41d57:	76 2c                	jbe    41d85 <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   41d59:	8b 05 c1 10 01 00    	mov    0x110c1(%rip),%eax        # 52e20 <ticks>
   41d5f:	89 05 db 14 01 00    	mov    %eax,0x114db(%rip)        # 53240 <last_ticks.1>
        ++showing;
   41d65:	8b 05 99 42 00 00    	mov    0x4299(%rip),%eax        # 46004 <showing.0>
   41d6b:	83 c0 01             	add    $0x1,%eax
   41d6e:	89 05 90 42 00 00    	mov    %eax,0x4290(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41d74:	eb 0f                	jmp    41d85 <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41d76:	8b 05 88 42 00 00    	mov    0x4288(%rip),%eax        # 46004 <showing.0>
   41d7c:	83 c0 01             	add    $0x1,%eax
   41d7f:	89 05 7f 42 00 00    	mov    %eax,0x427f(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41d85:	8b 05 79 42 00 00    	mov    0x4279(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41d8b:	83 f8 20             	cmp    $0x20,%eax
   41d8e:	7f 6b                	jg     41dfb <memshow_virtual_animate+0xcb>
   41d90:	8b 05 6e 42 00 00    	mov    0x426e(%rip),%eax        # 46004 <showing.0>
   41d96:	99                   	cltd   
   41d97:	c1 ea 1c             	shr    $0x1c,%edx
   41d9a:	01 d0                	add    %edx,%eax
   41d9c:	83 e0 0f             	and    $0xf,%eax
   41d9f:	29 d0                	sub    %edx,%eax
   41da1:	48 63 d0             	movslq %eax,%rdx
   41da4:	48 89 d0             	mov    %rdx,%rax
   41da7:	48 c1 e0 03          	shl    $0x3,%rax
   41dab:	48 29 d0             	sub    %rdx,%rax
   41dae:	48 c1 e0 05          	shl    $0x5,%rax
   41db2:	48 89 c2             	mov    %rax,%rdx
   41db5:	48 8d 05 2c 03 01 00 	lea    0x1032c(%rip),%rax        # 520e8 <processes+0xc8>
   41dbc:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41dbf:	85 c0                	test   %eax,%eax
   41dc1:	74 b3                	je     41d76 <memshow_virtual_animate+0x46>
   41dc3:	8b 05 3b 42 00 00    	mov    0x423b(%rip),%eax        # 46004 <showing.0>
   41dc9:	99                   	cltd   
   41dca:	c1 ea 1c             	shr    $0x1c,%edx
   41dcd:	01 d0                	add    %edx,%eax
   41dcf:	83 e0 0f             	and    $0xf,%eax
   41dd2:	29 d0                	sub    %edx,%eax
   41dd4:	48 63 d0             	movslq %eax,%rdx
   41dd7:	48 89 d0             	mov    %rdx,%rax
   41dda:	48 c1 e0 03          	shl    $0x3,%rax
   41dde:	48 29 d0             	sub    %rdx,%rax
   41de1:	48 c1 e0 05          	shl    $0x5,%rax
   41de5:	48 89 c2             	mov    %rax,%rdx
   41de8:	48 8d 05 09 03 01 00 	lea    0x10309(%rip),%rax        # 520f8 <processes+0xd8>
   41def:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41df3:	84 c0                	test   %al,%al
   41df5:	0f 84 7b ff ff ff    	je     41d76 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   41dfb:	8b 05 03 42 00 00    	mov    0x4203(%rip),%eax        # 46004 <showing.0>
   41e01:	99                   	cltd   
   41e02:	c1 ea 1c             	shr    $0x1c,%edx
   41e05:	01 d0                	add    %edx,%eax
   41e07:	83 e0 0f             	and    $0xf,%eax
   41e0a:	29 d0                	sub    %edx,%eax
   41e0c:	89 05 f2 41 00 00    	mov    %eax,0x41f2(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41e12:	8b 05 ec 41 00 00    	mov    0x41ec(%rip),%eax        # 46004 <showing.0>
   41e18:	48 63 d0             	movslq %eax,%rdx
   41e1b:	48 89 d0             	mov    %rdx,%rax
   41e1e:	48 c1 e0 03          	shl    $0x3,%rax
   41e22:	48 29 d0             	sub    %rdx,%rax
   41e25:	48 c1 e0 05          	shl    $0x5,%rax
   41e29:	48 89 c2             	mov    %rax,%rdx
   41e2c:	48 8d 05 b5 02 01 00 	lea    0x102b5(%rip),%rax        # 520e8 <processes+0xc8>
   41e33:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41e36:	85 c0                	test   %eax,%eax
   41e38:	74 59                	je     41e93 <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41e3a:	8b 15 c4 41 00 00    	mov    0x41c4(%rip),%edx        # 46004 <showing.0>
   41e40:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41e44:	89 d1                	mov    %edx,%ecx
   41e46:	48 8d 15 37 31 00 00 	lea    0x3137(%rip),%rdx        # 44f84 <memstate_colors+0xa4>
   41e4d:	be 04 00 00 00       	mov    $0x4,%esi
   41e52:	48 89 c7             	mov    %rax,%rdi
   41e55:	b8 00 00 00 00       	mov    $0x0,%eax
   41e5a:	e8 38 2d 00 00       	call   44b97 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41e5f:	8b 05 9f 41 00 00    	mov    0x419f(%rip),%eax        # 46004 <showing.0>
   41e65:	48 63 d0             	movslq %eax,%rdx
   41e68:	48 89 d0             	mov    %rdx,%rax
   41e6b:	48 c1 e0 03          	shl    $0x3,%rax
   41e6f:	48 29 d0             	sub    %rdx,%rax
   41e72:	48 c1 e0 05          	shl    $0x5,%rax
   41e76:	48 89 c2             	mov    %rax,%rdx
   41e79:	48 8d 05 70 02 01 00 	lea    0x10270(%rip),%rax        # 520f0 <processes+0xd0>
   41e80:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41e84:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41e88:	48 89 d6             	mov    %rdx,%rsi
   41e8b:	48 89 c7             	mov    %rax,%rdi
   41e8e:	e8 5d fc ff ff       	call   41af0 <memshow_virtual>
    }
}
   41e93:	90                   	nop
   41e94:	c9                   	leave  
   41e95:	c3                   	ret    

0000000000041e96 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41e96:	f3 0f 1e fa          	endbr64 
   41e9a:	55                   	push   %rbp
   41e9b:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41e9e:	e8 5f 01 00 00       	call   42002 <segments_init>
    interrupt_init();
   41ea3:	e8 44 04 00 00       	call   422ec <interrupt_init>
    virtual_memory_init();
   41ea8:	e8 11 11 00 00       	call   42fbe <virtual_memory_init>
}
   41ead:	90                   	nop
   41eae:	5d                   	pop    %rbp
   41eaf:	c3                   	ret    

0000000000041eb0 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41eb0:	f3 0f 1e fa          	endbr64 
   41eb4:	55                   	push   %rbp
   41eb5:	48 89 e5             	mov    %rsp,%rbp
   41eb8:	48 83 ec 18          	sub    $0x18,%rsp
   41ebc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41ec0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41ec4:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41ec7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41eca:	48 98                	cltq   
   41ecc:	48 c1 e0 2d          	shl    $0x2d,%rax
   41ed0:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41ed4:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41edb:	90 00 00 
   41ede:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41ee1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ee5:	48 89 10             	mov    %rdx,(%rax)
}
   41ee8:	90                   	nop
   41ee9:	c9                   	leave  
   41eea:	c3                   	ret    

0000000000041eeb <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41eeb:	f3 0f 1e fa          	endbr64 
   41eef:	55                   	push   %rbp
   41ef0:	48 89 e5             	mov    %rsp,%rbp
   41ef3:	48 83 ec 28          	sub    $0x28,%rsp
   41ef7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41efb:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41eff:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41f02:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41f06:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41f0a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41f0e:	48 c1 e0 10          	shl    $0x10,%rax
   41f12:	48 89 c2             	mov    %rax,%rdx
   41f15:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41f1c:	00 00 00 
   41f1f:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41f22:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41f26:	48 c1 e0 20          	shl    $0x20,%rax
   41f2a:	48 89 c1             	mov    %rax,%rcx
   41f2d:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41f34:	00 00 ff 
   41f37:	48 21 c8             	and    %rcx,%rax
   41f3a:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41f3d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41f41:	48 83 e8 01          	sub    $0x1,%rax
   41f45:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41f48:	48 09 d0             	or     %rdx,%rax
        | type
   41f4b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41f4f:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41f52:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41f55:	48 98                	cltq   
   41f57:	48 c1 e0 2d          	shl    $0x2d,%rax
   41f5b:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41f5e:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41f65:	80 00 00 
   41f68:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41f6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f6f:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41f72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f76:	48 83 c0 08          	add    $0x8,%rax
   41f7a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41f7e:	48 c1 ea 20          	shr    $0x20,%rdx
   41f82:	48 89 10             	mov    %rdx,(%rax)
}
   41f85:	90                   	nop
   41f86:	c9                   	leave  
   41f87:	c3                   	ret    

0000000000041f88 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41f88:	f3 0f 1e fa          	endbr64 
   41f8c:	55                   	push   %rbp
   41f8d:	48 89 e5             	mov    %rsp,%rbp
   41f90:	48 83 ec 20          	sub    $0x20,%rsp
   41f94:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41f98:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41f9c:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41f9f:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41fa3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41fa7:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41faa:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41fae:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41fb1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41fb4:	48 98                	cltq   
   41fb6:	48 c1 e0 2d          	shl    $0x2d,%rax
   41fba:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41fbd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41fc1:	48 c1 e0 20          	shl    $0x20,%rax
   41fc5:	48 89 c1             	mov    %rax,%rcx
   41fc8:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41fcf:	00 ff ff 
   41fd2:	48 21 c8             	and    %rcx,%rax
   41fd5:	48 09 c2             	or     %rax,%rdx
   41fd8:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41fdf:	80 00 00 
   41fe2:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41fe5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fe9:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41fec:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41ff0:	48 c1 e8 20          	shr    $0x20,%rax
   41ff4:	48 89 c2             	mov    %rax,%rdx
   41ff7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ffb:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41fff:	90                   	nop
   42000:	c9                   	leave  
   42001:	c3                   	ret    

0000000000042002 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   42002:	f3 0f 1e fa          	endbr64 
   42006:	55                   	push   %rbp
   42007:	48 89 e5             	mov    %rsp,%rbp
   4200a:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   4200e:	48 c7 05 47 12 01 00 	movq   $0x0,0x11247(%rip)        # 53260 <segments>
   42015:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   42019:	ba 00 00 00 00       	mov    $0x0,%edx
   4201e:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   42025:	08 20 00 
   42028:	48 89 c6             	mov    %rax,%rsi
   4202b:	48 8d 05 36 12 01 00 	lea    0x11236(%rip),%rax        # 53268 <segments+0x8>
   42032:	48 89 c7             	mov    %rax,%rdi
   42035:	e8 76 fe ff ff       	call   41eb0 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   4203a:	ba 03 00 00 00       	mov    $0x3,%edx
   4203f:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   42046:	08 20 00 
   42049:	48 89 c6             	mov    %rax,%rsi
   4204c:	48 8d 05 1d 12 01 00 	lea    0x1121d(%rip),%rax        # 53270 <segments+0x10>
   42053:	48 89 c7             	mov    %rax,%rdi
   42056:	e8 55 fe ff ff       	call   41eb0 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4205b:	ba 00 00 00 00       	mov    $0x0,%edx
   42060:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   42067:	02 00 00 
   4206a:	48 89 c6             	mov    %rax,%rsi
   4206d:	48 8d 05 04 12 01 00 	lea    0x11204(%rip),%rax        # 53278 <segments+0x18>
   42074:	48 89 c7             	mov    %rax,%rdi
   42077:	e8 34 fe ff ff       	call   41eb0 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   4207c:	ba 03 00 00 00       	mov    $0x3,%edx
   42081:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   42088:	02 00 00 
   4208b:	48 89 c6             	mov    %rax,%rsi
   4208e:	48 8d 05 eb 11 01 00 	lea    0x111eb(%rip),%rax        # 53280 <segments+0x20>
   42095:	48 89 c7             	mov    %rax,%rdi
   42098:	e8 13 fe ff ff       	call   41eb0 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   4209d:	48 8d 05 fc 21 01 00 	lea    0x121fc(%rip),%rax        # 542a0 <kernel_task_descriptor>
   420a4:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   420aa:	48 89 c1             	mov    %rax,%rcx
   420ad:	ba 00 00 00 00       	mov    $0x0,%edx
   420b2:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   420b9:	09 00 00 
   420bc:	48 89 c6             	mov    %rax,%rsi
   420bf:	48 8d 05 c2 11 01 00 	lea    0x111c2(%rip),%rax        # 53288 <segments+0x28>
   420c6:	48 89 c7             	mov    %rax,%rdi
   420c9:	e8 1d fe ff ff       	call   41eeb <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   420ce:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   420d4:	48 8d 05 85 11 01 00 	lea    0x11185(%rip),%rax        # 53260 <segments>
   420db:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   420df:	ba 60 00 00 00       	mov    $0x60,%edx
   420e4:	be 00 00 00 00       	mov    $0x0,%esi
   420e9:	48 8d 05 b0 21 01 00 	lea    0x121b0(%rip),%rax        # 542a0 <kernel_task_descriptor>
   420f0:	48 89 c7             	mov    %rax,%rdi
   420f3:	e8 45 1b 00 00       	call   43c3d <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   420f8:	48 c7 05 a1 21 01 00 	movq   $0x80000,0x121a1(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   420ff:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   42103:	ba 00 10 00 00       	mov    $0x1000,%edx
   42108:	be 00 00 00 00       	mov    $0x0,%esi
   4210d:	48 8d 05 8c 11 01 00 	lea    0x1118c(%rip),%rax        # 532a0 <interrupt_descriptors>
   42114:	48 89 c7             	mov    %rax,%rdi
   42117:	e8 21 1b 00 00       	call   43c3d <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4211c:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   42123:	eb 3c                	jmp    42161 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   42125:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   4212c:	48 89 c2             	mov    %rax,%rdx
   4212f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42132:	48 c1 e0 04          	shl    $0x4,%rax
   42136:	48 89 c1             	mov    %rax,%rcx
   42139:	48 8d 05 60 11 01 00 	lea    0x11160(%rip),%rax        # 532a0 <interrupt_descriptors>
   42140:	48 01 c8             	add    %rcx,%rax
   42143:	48 89 d1             	mov    %rdx,%rcx
   42146:	ba 00 00 00 00       	mov    $0x0,%edx
   4214b:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   42152:	0e 00 00 
   42155:	48 89 c7             	mov    %rax,%rdi
   42158:	e8 2b fe ff ff       	call   41f88 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4215d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42161:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   42168:	76 bb                	jbe    42125 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   4216a:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   42171:	48 89 c1             	mov    %rax,%rcx
   42174:	ba 00 00 00 00       	mov    $0x0,%edx
   42179:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   42180:	0e 00 00 
   42183:	48 89 c6             	mov    %rax,%rsi
   42186:	48 8d 05 13 13 01 00 	lea    0x11313(%rip),%rax        # 534a0 <interrupt_descriptors+0x200>
   4218d:	48 89 c7             	mov    %rax,%rdi
   42190:	e8 f3 fd ff ff       	call   41f88 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   42195:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   4219c:	48 89 c1             	mov    %rax,%rcx
   4219f:	ba 00 00 00 00       	mov    $0x0,%edx
   421a4:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   421ab:	0e 00 00 
   421ae:	48 89 c6             	mov    %rax,%rsi
   421b1:	48 8d 05 b8 11 01 00 	lea    0x111b8(%rip),%rax        # 53370 <interrupt_descriptors+0xd0>
   421b8:	48 89 c7             	mov    %rax,%rdi
   421bb:	e8 c8 fd ff ff       	call   41f88 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   421c0:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   421c7:	48 89 c1             	mov    %rax,%rcx
   421ca:	ba 00 00 00 00       	mov    $0x0,%edx
   421cf:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   421d6:	0e 00 00 
   421d9:	48 89 c6             	mov    %rax,%rsi
   421dc:	48 8d 05 9d 11 01 00 	lea    0x1119d(%rip),%rax        # 53380 <interrupt_descriptors+0xe0>
   421e3:	48 89 c7             	mov    %rax,%rdi
   421e6:	e8 9d fd ff ff       	call   41f88 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   421eb:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   421f2:	eb 50                	jmp    42244 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   421f4:	8b 45 f8             	mov    -0x8(%rbp),%eax
   421f7:	83 e8 30             	sub    $0x30,%eax
   421fa:	89 c0                	mov    %eax,%eax
   421fc:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   42203:	00 
   42204:	48 8d 05 dc de ff ff 	lea    -0x2124(%rip),%rax        # 400e7 <sys_int_handlers>
   4220b:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   4220f:	48 89 c2             	mov    %rax,%rdx
   42212:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42215:	48 c1 e0 04          	shl    $0x4,%rax
   42219:	48 89 c1             	mov    %rax,%rcx
   4221c:	48 8d 05 7d 10 01 00 	lea    0x1107d(%rip),%rax        # 532a0 <interrupt_descriptors>
   42223:	48 01 c8             	add    %rcx,%rax
   42226:	48 89 d1             	mov    %rdx,%rcx
   42229:	ba 03 00 00 00       	mov    $0x3,%edx
   4222e:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   42235:	0e 00 00 
   42238:	48 89 c7             	mov    %rax,%rdi
   4223b:	e8 48 fd ff ff       	call   41f88 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   42240:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42244:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   42248:	76 aa                	jbe    421f4 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4224a:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   42250:	48 8d 05 49 10 01 00 	lea    0x11049(%rip),%rax        # 532a0 <interrupt_descriptors>
   42257:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   4225b:	b8 28 00 00 00       	mov    $0x28,%eax
   42260:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   42264:	0f 00 d8             	ltr    %ax
   42267:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4226b:	0f 20 c0             	mov    %cr0,%rax
   4226e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   42272:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   42276:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   42279:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   42280:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42283:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   42286:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42289:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   4228d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42291:	0f 22 c0             	mov    %rax,%cr0
}
   42294:	90                   	nop
    lcr0(cr0);
}
   42295:	90                   	nop
   42296:	c9                   	leave  
   42297:	c3                   	ret    

0000000000042298 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   42298:	f3 0f 1e fa          	endbr64 
   4229c:	55                   	push   %rbp
   4229d:	48 89 e5             	mov    %rsp,%rbp
   422a0:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   422a4:	0f b7 05 55 20 01 00 	movzwl 0x12055(%rip),%eax        # 54300 <interrupts_enabled>
   422ab:	f7 d0                	not    %eax
   422ad:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   422b1:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   422b5:	0f b6 c0             	movzbl %al,%eax
   422b8:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   422bf:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422c2:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   422c6:	8b 55 f0             	mov    -0x10(%rbp),%edx
   422c9:	ee                   	out    %al,(%dx)
}
   422ca:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   422cb:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   422cf:	66 c1 e8 08          	shr    $0x8,%ax
   422d3:	0f b6 c0             	movzbl %al,%eax
   422d6:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   422dd:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422e0:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   422e4:	8b 55 f8             	mov    -0x8(%rbp),%edx
   422e7:	ee                   	out    %al,(%dx)
}
   422e8:	90                   	nop
}
   422e9:	90                   	nop
   422ea:	c9                   	leave  
   422eb:	c3                   	ret    

00000000000422ec <interrupt_init>:

void interrupt_init(void) {
   422ec:	f3 0f 1e fa          	endbr64 
   422f0:	55                   	push   %rbp
   422f1:	48 89 e5             	mov    %rsp,%rbp
   422f4:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   422f8:	66 c7 05 ff 1f 01 00 	movw   $0x0,0x11fff(%rip)        # 54300 <interrupts_enabled>
   422ff:	00 00 
    interrupt_mask();
   42301:	e8 92 ff ff ff       	call   42298 <interrupt_mask>
   42306:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   4230d:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42311:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   42315:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   42318:	ee                   	out    %al,(%dx)
}
   42319:	90                   	nop
   4231a:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   42321:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42325:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   42329:	8b 55 ac             	mov    -0x54(%rbp),%edx
   4232c:	ee                   	out    %al,(%dx)
}
   4232d:	90                   	nop
   4232e:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   42335:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42339:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   4233d:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   42340:	ee                   	out    %al,(%dx)
}
   42341:	90                   	nop
   42342:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   42349:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4234d:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   42351:	8b 55 bc             	mov    -0x44(%rbp),%edx
   42354:	ee                   	out    %al,(%dx)
}
   42355:	90                   	nop
   42356:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   4235d:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42361:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   42365:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   42368:	ee                   	out    %al,(%dx)
}
   42369:	90                   	nop
   4236a:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   42371:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42375:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   42379:	8b 55 cc             	mov    -0x34(%rbp),%edx
   4237c:	ee                   	out    %al,(%dx)
}
   4237d:	90                   	nop
   4237e:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   42385:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42389:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   4238d:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   42390:	ee                   	out    %al,(%dx)
}
   42391:	90                   	nop
   42392:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   42399:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4239d:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   423a1:	8b 55 dc             	mov    -0x24(%rbp),%edx
   423a4:	ee                   	out    %al,(%dx)
}
   423a5:	90                   	nop
   423a6:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   423ad:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423b1:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   423b5:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   423b8:	ee                   	out    %al,(%dx)
}
   423b9:	90                   	nop
   423ba:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   423c1:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423c5:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   423c9:	8b 55 ec             	mov    -0x14(%rbp),%edx
   423cc:	ee                   	out    %al,(%dx)
}
   423cd:	90                   	nop
   423ce:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   423d5:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423d9:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   423dd:	8b 55 f4             	mov    -0xc(%rbp),%edx
   423e0:	ee                   	out    %al,(%dx)
}
   423e1:	90                   	nop
   423e2:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   423e9:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423ed:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   423f1:	8b 55 fc             	mov    -0x4(%rbp),%edx
   423f4:	ee                   	out    %al,(%dx)
}
   423f5:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   423f6:	e8 9d fe ff ff       	call   42298 <interrupt_mask>
}
   423fb:	90                   	nop
   423fc:	c9                   	leave  
   423fd:	c3                   	ret    

00000000000423fe <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   423fe:	f3 0f 1e fa          	endbr64 
   42402:	55                   	push   %rbp
   42403:	48 89 e5             	mov    %rsp,%rbp
   42406:	48 83 ec 28          	sub    $0x28,%rsp
   4240a:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   4240d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42411:	0f 8e 9f 00 00 00    	jle    424b6 <timer_init+0xb8>
   42417:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   4241e:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42422:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42426:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42429:	ee                   	out    %al,(%dx)
}
   4242a:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   4242b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4242e:	89 c2                	mov    %eax,%edx
   42430:	c1 ea 1f             	shr    $0x1f,%edx
   42433:	01 d0                	add    %edx,%eax
   42435:	d1 f8                	sar    %eax
   42437:	05 de 34 12 00       	add    $0x1234de,%eax
   4243c:	99                   	cltd   
   4243d:	f7 7d dc             	idivl  -0x24(%rbp)
   42440:	89 c2                	mov    %eax,%edx
   42442:	89 d0                	mov    %edx,%eax
   42444:	c1 f8 1f             	sar    $0x1f,%eax
   42447:	c1 e8 18             	shr    $0x18,%eax
   4244a:	89 c1                	mov    %eax,%ecx
   4244c:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   4244f:	0f b6 c0             	movzbl %al,%eax
   42452:	29 c8                	sub    %ecx,%eax
   42454:	0f b6 c0             	movzbl %al,%eax
   42457:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   4245e:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42461:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42465:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42468:	ee                   	out    %al,(%dx)
}
   42469:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   4246a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4246d:	89 c2                	mov    %eax,%edx
   4246f:	c1 ea 1f             	shr    $0x1f,%edx
   42472:	01 d0                	add    %edx,%eax
   42474:	d1 f8                	sar    %eax
   42476:	05 de 34 12 00       	add    $0x1234de,%eax
   4247b:	99                   	cltd   
   4247c:	f7 7d dc             	idivl  -0x24(%rbp)
   4247f:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42485:	85 c0                	test   %eax,%eax
   42487:	0f 48 c2             	cmovs  %edx,%eax
   4248a:	c1 f8 08             	sar    $0x8,%eax
   4248d:	0f b6 c0             	movzbl %al,%eax
   42490:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   42497:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4249a:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4249e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   424a1:	ee                   	out    %al,(%dx)
}
   424a2:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   424a3:	0f b7 05 56 1e 01 00 	movzwl 0x11e56(%rip),%eax        # 54300 <interrupts_enabled>
   424aa:	83 c8 01             	or     $0x1,%eax
   424ad:	66 89 05 4c 1e 01 00 	mov    %ax,0x11e4c(%rip)        # 54300 <interrupts_enabled>
   424b4:	eb 11                	jmp    424c7 <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   424b6:	0f b7 05 43 1e 01 00 	movzwl 0x11e43(%rip),%eax        # 54300 <interrupts_enabled>
   424bd:	83 e0 fe             	and    $0xfffffffe,%eax
   424c0:	66 89 05 39 1e 01 00 	mov    %ax,0x11e39(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   424c7:	e8 cc fd ff ff       	call   42298 <interrupt_mask>
}
   424cc:	90                   	nop
   424cd:	c9                   	leave  
   424ce:	c3                   	ret    

00000000000424cf <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   424cf:	f3 0f 1e fa          	endbr64 
   424d3:	55                   	push   %rbp
   424d4:	48 89 e5             	mov    %rsp,%rbp
   424d7:	48 83 ec 08          	sub    $0x8,%rsp
   424db:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   424df:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   424e4:	74 14                	je     424fa <physical_memory_isreserved+0x2b>
   424e6:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   424ed:	00 
   424ee:	76 11                	jbe    42501 <physical_memory_isreserved+0x32>
   424f0:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   424f7:	00 
   424f8:	77 07                	ja     42501 <physical_memory_isreserved+0x32>
   424fa:	b8 01 00 00 00       	mov    $0x1,%eax
   424ff:	eb 05                	jmp    42506 <physical_memory_isreserved+0x37>
   42501:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42506:	c9                   	leave  
   42507:	c3                   	ret    

0000000000042508 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   42508:	f3 0f 1e fa          	endbr64 
   4250c:	55                   	push   %rbp
   4250d:	48 89 e5             	mov    %rsp,%rbp
   42510:	48 83 ec 10          	sub    $0x10,%rsp
   42514:	89 7d fc             	mov    %edi,-0x4(%rbp)
   42517:	89 75 f8             	mov    %esi,-0x8(%rbp)
   4251a:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   4251d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42520:	c1 e0 10             	shl    $0x10,%eax
   42523:	89 c2                	mov    %eax,%edx
   42525:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42528:	c1 e0 0b             	shl    $0xb,%eax
   4252b:	09 c2                	or     %eax,%edx
   4252d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42530:	c1 e0 08             	shl    $0x8,%eax
   42533:	09 d0                	or     %edx,%eax
}
   42535:	c9                   	leave  
   42536:	c3                   	ret    

0000000000042537 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   42537:	f3 0f 1e fa          	endbr64 
   4253b:	55                   	push   %rbp
   4253c:	48 89 e5             	mov    %rsp,%rbp
   4253f:	48 83 ec 18          	sub    $0x18,%rsp
   42543:	89 7d ec             	mov    %edi,-0x14(%rbp)
   42546:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   42549:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4254c:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4254f:	09 d0                	or     %edx,%eax
   42551:	0d 00 00 00 80       	or     $0x80000000,%eax
   42556:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   4255d:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42560:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42563:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42566:	ef                   	out    %eax,(%dx)
}
   42567:	90                   	nop
   42568:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   4256f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42572:	89 c2                	mov    %eax,%edx
   42574:	ed                   	in     (%dx),%eax
   42575:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   42578:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   4257b:	c9                   	leave  
   4257c:	c3                   	ret    

000000000004257d <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   4257d:	f3 0f 1e fa          	endbr64 
   42581:	55                   	push   %rbp
   42582:	48 89 e5             	mov    %rsp,%rbp
   42585:	48 83 ec 28          	sub    $0x28,%rsp
   42589:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4258c:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   4258f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42596:	eb 73                	jmp    4260b <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   42598:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4259f:	eb 60                	jmp    42601 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   425a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   425a8:	eb 4a                	jmp    425f4 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   425aa:	8b 55 f4             	mov    -0xc(%rbp),%edx
   425ad:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   425b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   425b3:	89 ce                	mov    %ecx,%esi
   425b5:	89 c7                	mov    %eax,%edi
   425b7:	e8 4c ff ff ff       	call   42508 <pci_make_configaddr>
   425bc:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   425bf:	8b 45 f0             	mov    -0x10(%rbp),%eax
   425c2:	be 00 00 00 00       	mov    $0x0,%esi
   425c7:	89 c7                	mov    %eax,%edi
   425c9:	e8 69 ff ff ff       	call   42537 <pci_config_readl>
   425ce:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   425d1:	8b 45 d8             	mov    -0x28(%rbp),%eax
   425d4:	c1 e0 10             	shl    $0x10,%eax
   425d7:	0b 45 dc             	or     -0x24(%rbp),%eax
   425da:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   425dd:	75 05                	jne    425e4 <pci_find_device+0x67>
                    return configaddr;
   425df:	8b 45 f0             	mov    -0x10(%rbp),%eax
   425e2:	eb 35                	jmp    42619 <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   425e4:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   425e8:	75 06                	jne    425f0 <pci_find_device+0x73>
   425ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   425ee:	74 0c                	je     425fc <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   425f0:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   425f4:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   425f8:	75 b0                	jne    425aa <pci_find_device+0x2d>
   425fa:	eb 01                	jmp    425fd <pci_find_device+0x80>
                    break;
   425fc:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   425fd:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42601:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   42605:	75 9a                	jne    425a1 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   42607:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4260b:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42612:	75 84                	jne    42598 <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   42614:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   42619:	c9                   	leave  
   4261a:	c3                   	ret    

000000000004261b <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   4261b:	f3 0f 1e fa          	endbr64 
   4261f:	55                   	push   %rbp
   42620:	48 89 e5             	mov    %rsp,%rbp
   42623:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42627:	be 13 71 00 00       	mov    $0x7113,%esi
   4262c:	bf 86 80 00 00       	mov    $0x8086,%edi
   42631:	e8 47 ff ff ff       	call   4257d <pci_find_device>
   42636:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   42639:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4263d:	78 30                	js     4266f <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   4263f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42642:	be 40 00 00 00       	mov    $0x40,%esi
   42647:	89 c7                	mov    %eax,%edi
   42649:	e8 e9 fe ff ff       	call   42537 <pci_config_readl>
   4264e:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42653:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42656:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42659:	83 c0 04             	add    $0x4,%eax
   4265c:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4265f:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42665:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42669:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4266c:	66 ef                	out    %ax,(%dx)
}
   4266e:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   4266f:	48 8d 05 2a 29 00 00 	lea    0x292a(%rip),%rax        # 44fa0 <memstate_colors+0xc0>
   42676:	48 89 c2             	mov    %rax,%rdx
   42679:	be 00 c0 00 00       	mov    $0xc000,%esi
   4267e:	bf 80 07 00 00       	mov    $0x780,%edi
   42683:	b8 00 00 00 00       	mov    $0x0,%eax
   42688:	e8 ef 23 00 00       	call   44a7c <console_printf>
 spinloop: goto spinloop;
   4268d:	eb fe                	jmp    4268d <poweroff+0x72>

000000000004268f <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   4268f:	f3 0f 1e fa          	endbr64 
   42693:	55                   	push   %rbp
   42694:	48 89 e5             	mov    %rsp,%rbp
   42697:	48 83 ec 10          	sub    $0x10,%rsp
   4269b:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   426a2:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426a6:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   426aa:	8b 55 fc             	mov    -0x4(%rbp),%edx
   426ad:	ee                   	out    %al,(%dx)
}
   426ae:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   426af:	eb fe                	jmp    426af <reboot+0x20>

00000000000426b1 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   426b1:	f3 0f 1e fa          	endbr64 
   426b5:	55                   	push   %rbp
   426b6:	48 89 e5             	mov    %rsp,%rbp
   426b9:	48 83 ec 10          	sub    $0x10,%rsp
   426bd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   426c1:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   426c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426c8:	48 83 c0 08          	add    $0x8,%rax
   426cc:	ba c0 00 00 00       	mov    $0xc0,%edx
   426d1:	be 00 00 00 00       	mov    $0x0,%esi
   426d6:	48 89 c7             	mov    %rax,%rdi
   426d9:	e8 5f 15 00 00       	call   43c3d <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   426de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426e2:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   426e9:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   426eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426ef:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   426f6:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   426fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426fe:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   42705:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   42709:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4270d:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   42714:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   42716:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4271a:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   42721:	00 02 00 00 
    p->display_status = 1;
   42725:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42729:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42730:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42733:	83 e0 01             	and    $0x1,%eax
   42736:	85 c0                	test   %eax,%eax
   42738:	74 1c                	je     42756 <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4273a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4273e:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42745:	80 cc 30             	or     $0x30,%ah
   42748:	48 89 c2             	mov    %rax,%rdx
   4274b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4274f:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42756:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42759:	83 e0 02             	and    $0x2,%eax
   4275c:	85 c0                	test   %eax,%eax
   4275e:	74 1c                	je     4277c <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42760:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42764:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4276b:	80 e4 fd             	and    $0xfd,%ah
   4276e:	48 89 c2             	mov    %rax,%rdx
   42771:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42775:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   4277c:	90                   	nop
   4277d:	c9                   	leave  
   4277e:	c3                   	ret    

000000000004277f <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   4277f:	f3 0f 1e fa          	endbr64 
   42783:	55                   	push   %rbp
   42784:	48 89 e5             	mov    %rsp,%rbp
   42787:	48 83 ec 28          	sub    $0x28,%rsp
   4278b:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4278e:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42792:	78 09                	js     4279d <console_show_cursor+0x1e>
   42794:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4279b:	7e 07                	jle    427a4 <console_show_cursor+0x25>
        cpos = 0;
   4279d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   427a4:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   427ab:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427af:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   427b3:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   427b6:	ee                   	out    %al,(%dx)
}
   427b7:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   427b8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   427bb:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   427c1:	85 c0                	test   %eax,%eax
   427c3:	0f 48 c2             	cmovs  %edx,%eax
   427c6:	c1 f8 08             	sar    $0x8,%eax
   427c9:	0f b6 c0             	movzbl %al,%eax
   427cc:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   427d3:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427d6:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   427da:	8b 55 ec             	mov    -0x14(%rbp),%edx
   427dd:	ee                   	out    %al,(%dx)
}
   427de:	90                   	nop
   427df:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   427e6:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427ea:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   427ee:	8b 55 f4             	mov    -0xc(%rbp),%edx
   427f1:	ee                   	out    %al,(%dx)
}
   427f2:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   427f3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   427f6:	99                   	cltd   
   427f7:	c1 ea 18             	shr    $0x18,%edx
   427fa:	01 d0                	add    %edx,%eax
   427fc:	0f b6 c0             	movzbl %al,%eax
   427ff:	29 d0                	sub    %edx,%eax
   42801:	0f b6 c0             	movzbl %al,%eax
   42804:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   4280b:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4280e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42812:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42815:	ee                   	out    %al,(%dx)
}
   42816:	90                   	nop
}
   42817:	90                   	nop
   42818:	c9                   	leave  
   42819:	c3                   	ret    

000000000004281a <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   4281a:	f3 0f 1e fa          	endbr64 
   4281e:	55                   	push   %rbp
   4281f:	48 89 e5             	mov    %rsp,%rbp
   42822:	48 83 ec 20          	sub    $0x20,%rsp
   42826:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4282d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42830:	89 c2                	mov    %eax,%edx
   42832:	ec                   	in     (%dx),%al
   42833:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42836:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   4283a:	0f b6 c0             	movzbl %al,%eax
   4283d:	83 e0 01             	and    $0x1,%eax
   42840:	85 c0                	test   %eax,%eax
   42842:	75 0a                	jne    4284e <keyboard_readc+0x34>
        return -1;
   42844:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42849:	e9 fd 01 00 00       	jmp    42a4b <keyboard_readc+0x231>
   4284e:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42855:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42858:	89 c2                	mov    %eax,%edx
   4285a:	ec                   	in     (%dx),%al
   4285b:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   4285e:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42862:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42865:	0f b6 05 96 1a 01 00 	movzbl 0x11a96(%rip),%eax        # 54302 <last_escape.2>
   4286c:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   4286f:	c6 05 8c 1a 01 00 00 	movb   $0x0,0x11a8c(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42876:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4287a:	75 11                	jne    4288d <keyboard_readc+0x73>
        last_escape = 0x80;
   4287c:	c6 05 7f 1a 01 00 80 	movb   $0x80,0x11a7f(%rip)        # 54302 <last_escape.2>
        return 0;
   42883:	b8 00 00 00 00       	mov    $0x0,%eax
   42888:	e9 be 01 00 00       	jmp    42a4b <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4288d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42891:	84 c0                	test   %al,%al
   42893:	79 64                	jns    428f9 <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   42895:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42899:	83 e0 7f             	and    $0x7f,%eax
   4289c:	89 c2                	mov    %eax,%edx
   4289e:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   428a2:	09 d0                	or     %edx,%eax
   428a4:	48 98                	cltq   
   428a6:	48 8d 15 13 27 00 00 	lea    0x2713(%rip),%rdx        # 44fc0 <keymap>
   428ad:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   428b1:	0f b6 c0             	movzbl %al,%eax
   428b4:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   428b7:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   428be:	7e 2f                	jle    428ef <keyboard_readc+0xd5>
   428c0:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   428c7:	7f 26                	jg     428ef <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   428c9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   428cc:	2d fa 00 00 00       	sub    $0xfa,%eax
   428d1:	ba 01 00 00 00       	mov    $0x1,%edx
   428d6:	89 c1                	mov    %eax,%ecx
   428d8:	d3 e2                	shl    %cl,%edx
   428da:	89 d0                	mov    %edx,%eax
   428dc:	f7 d0                	not    %eax
   428de:	89 c2                	mov    %eax,%edx
   428e0:	0f b6 05 1c 1a 01 00 	movzbl 0x11a1c(%rip),%eax        # 54303 <modifiers.1>
   428e7:	21 d0                	and    %edx,%eax
   428e9:	88 05 14 1a 01 00    	mov    %al,0x11a14(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   428ef:	b8 00 00 00 00       	mov    $0x0,%eax
   428f4:	e9 52 01 00 00       	jmp    42a4b <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   428f9:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   428fd:	0a 45 fa             	or     -0x6(%rbp),%al
   42900:	0f b6 c0             	movzbl %al,%eax
   42903:	48 98                	cltq   
   42905:	48 8d 15 b4 26 00 00 	lea    0x26b4(%rip),%rdx        # 44fc0 <keymap>
   4290c:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42910:	0f b6 c0             	movzbl %al,%eax
   42913:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42916:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4291a:	7e 57                	jle    42973 <keyboard_readc+0x159>
   4291c:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42920:	7f 51                	jg     42973 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   42922:	0f b6 05 da 19 01 00 	movzbl 0x119da(%rip),%eax        # 54303 <modifiers.1>
   42929:	0f b6 c0             	movzbl %al,%eax
   4292c:	83 e0 02             	and    $0x2,%eax
   4292f:	85 c0                	test   %eax,%eax
   42931:	74 09                	je     4293c <keyboard_readc+0x122>
            ch -= 0x60;
   42933:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42937:	e9 0b 01 00 00       	jmp    42a47 <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4293c:	0f b6 05 c0 19 01 00 	movzbl 0x119c0(%rip),%eax        # 54303 <modifiers.1>
   42943:	0f b6 c0             	movzbl %al,%eax
   42946:	83 e0 01             	and    $0x1,%eax
   42949:	85 c0                	test   %eax,%eax
   4294b:	0f 94 c2             	sete   %dl
   4294e:	0f b6 05 ae 19 01 00 	movzbl 0x119ae(%rip),%eax        # 54303 <modifiers.1>
   42955:	0f b6 c0             	movzbl %al,%eax
   42958:	83 e0 08             	and    $0x8,%eax
   4295b:	85 c0                	test   %eax,%eax
   4295d:	0f 94 c0             	sete   %al
   42960:	31 d0                	xor    %edx,%eax
   42962:	84 c0                	test   %al,%al
   42964:	0f 84 dd 00 00 00    	je     42a47 <keyboard_readc+0x22d>
            ch -= 0x20;
   4296a:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4296e:	e9 d4 00 00 00       	jmp    42a47 <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42973:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4297a:	7e 30                	jle    429ac <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4297c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4297f:	2d fa 00 00 00       	sub    $0xfa,%eax
   42984:	ba 01 00 00 00       	mov    $0x1,%edx
   42989:	89 c1                	mov    %eax,%ecx
   4298b:	d3 e2                	shl    %cl,%edx
   4298d:	89 d0                	mov    %edx,%eax
   4298f:	89 c2                	mov    %eax,%edx
   42991:	0f b6 05 6b 19 01 00 	movzbl 0x1196b(%rip),%eax        # 54303 <modifiers.1>
   42998:	31 d0                	xor    %edx,%eax
   4299a:	88 05 63 19 01 00    	mov    %al,0x11963(%rip)        # 54303 <modifiers.1>
        ch = 0;
   429a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   429a7:	e9 9c 00 00 00       	jmp    42a48 <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   429ac:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   429b3:	7e 2d                	jle    429e2 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   429b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   429b8:	2d fa 00 00 00       	sub    $0xfa,%eax
   429bd:	ba 01 00 00 00       	mov    $0x1,%edx
   429c2:	89 c1                	mov    %eax,%ecx
   429c4:	d3 e2                	shl    %cl,%edx
   429c6:	89 d0                	mov    %edx,%eax
   429c8:	89 c2                	mov    %eax,%edx
   429ca:	0f b6 05 32 19 01 00 	movzbl 0x11932(%rip),%eax        # 54303 <modifiers.1>
   429d1:	09 d0                	or     %edx,%eax
   429d3:	88 05 2a 19 01 00    	mov    %al,0x1192a(%rip)        # 54303 <modifiers.1>
        ch = 0;
   429d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   429e0:	eb 66                	jmp    42a48 <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   429e2:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   429e6:	7e 3f                	jle    42a27 <keyboard_readc+0x20d>
   429e8:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   429ef:	7f 36                	jg     42a27 <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   429f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   429f4:	8d 50 80             	lea    -0x80(%rax),%edx
   429f7:	0f b6 05 05 19 01 00 	movzbl 0x11905(%rip),%eax        # 54303 <modifiers.1>
   429fe:	0f b6 c0             	movzbl %al,%eax
   42a01:	83 e0 03             	and    $0x3,%eax
   42a04:	48 63 c8             	movslq %eax,%rcx
   42a07:	48 63 c2             	movslq %edx,%rax
   42a0a:	48 c1 e0 02          	shl    $0x2,%rax
   42a0e:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   42a12:	48 8d 05 a7 26 00 00 	lea    0x26a7(%rip),%rax        # 450c0 <complex_keymap>
   42a19:	48 01 d0             	add    %rdx,%rax
   42a1c:	0f b6 00             	movzbl (%rax),%eax
   42a1f:	0f b6 c0             	movzbl %al,%eax
   42a22:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42a25:	eb 21                	jmp    42a48 <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42a27:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42a2b:	7f 1b                	jg     42a48 <keyboard_readc+0x22e>
   42a2d:	0f b6 05 cf 18 01 00 	movzbl 0x118cf(%rip),%eax        # 54303 <modifiers.1>
   42a34:	0f b6 c0             	movzbl %al,%eax
   42a37:	83 e0 02             	and    $0x2,%eax
   42a3a:	85 c0                	test   %eax,%eax
   42a3c:	74 0a                	je     42a48 <keyboard_readc+0x22e>
        ch = 0;
   42a3e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42a45:	eb 01                	jmp    42a48 <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   42a47:	90                   	nop
    }

    return ch;
   42a48:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42a4b:	c9                   	leave  
   42a4c:	c3                   	ret    

0000000000042a4d <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42a4d:	f3 0f 1e fa          	endbr64 
   42a51:	55                   	push   %rbp
   42a52:	48 89 e5             	mov    %rsp,%rbp
   42a55:	48 83 ec 20          	sub    $0x20,%rsp
   42a59:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42a60:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42a63:	89 c2                	mov    %eax,%edx
   42a65:	ec                   	in     (%dx),%al
   42a66:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42a69:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42a70:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42a73:	89 c2                	mov    %eax,%edx
   42a75:	ec                   	in     (%dx),%al
   42a76:	88 45 eb             	mov    %al,-0x15(%rbp)
   42a79:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42a80:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42a83:	89 c2                	mov    %eax,%edx
   42a85:	ec                   	in     (%dx),%al
   42a86:	88 45 f3             	mov    %al,-0xd(%rbp)
   42a89:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42a90:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42a93:	89 c2                	mov    %eax,%edx
   42a95:	ec                   	in     (%dx),%al
   42a96:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42a99:	90                   	nop
   42a9a:	c9                   	leave  
   42a9b:	c3                   	ret    

0000000000042a9c <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42a9c:	f3 0f 1e fa          	endbr64 
   42aa0:	55                   	push   %rbp
   42aa1:	48 89 e5             	mov    %rsp,%rbp
   42aa4:	48 83 ec 40          	sub    $0x40,%rsp
   42aa8:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42aac:	89 f0                	mov    %esi,%eax
   42aae:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42ab1:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42ab4:	8b 05 4a 18 01 00    	mov    0x1184a(%rip),%eax        # 54304 <initialized.0>
   42aba:	85 c0                	test   %eax,%eax
   42abc:	75 1e                	jne    42adc <parallel_port_putc+0x40>
   42abe:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42ac5:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42ac9:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42acd:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42ad0:	ee                   	out    %al,(%dx)
}
   42ad1:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42ad2:	c7 05 28 18 01 00 01 	movl   $0x1,0x11828(%rip)        # 54304 <initialized.0>
   42ad9:	00 00 00 
    }

    for (int i = 0;
   42adc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42ae3:	eb 09                	jmp    42aee <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42ae5:	e8 63 ff ff ff       	call   42a4d <delay>
         ++i) {
   42aea:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42aee:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42af5:	7f 18                	jg     42b0f <parallel_port_putc+0x73>
   42af7:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42afe:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42b01:	89 c2                	mov    %eax,%edx
   42b03:	ec                   	in     (%dx),%al
   42b04:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42b07:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42b0b:	84 c0                	test   %al,%al
   42b0d:	79 d6                	jns    42ae5 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   42b0f:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42b13:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42b1a:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42b1d:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42b21:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42b24:	ee                   	out    %al,(%dx)
}
   42b25:	90                   	nop
   42b26:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42b2d:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42b31:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42b35:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42b38:	ee                   	out    %al,(%dx)
}
   42b39:	90                   	nop
   42b3a:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42b41:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42b45:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42b49:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42b4c:	ee                   	out    %al,(%dx)
}
   42b4d:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42b4e:	90                   	nop
   42b4f:	c9                   	leave  
   42b50:	c3                   	ret    

0000000000042b51 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42b51:	f3 0f 1e fa          	endbr64 
   42b55:	55                   	push   %rbp
   42b56:	48 89 e5             	mov    %rsp,%rbp
   42b59:	48 83 ec 20          	sub    $0x20,%rsp
   42b5d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42b61:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42b65:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 42a9c <parallel_port_putc>
   42b6c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   42b70:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42b74:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42b78:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42b7c:	be 00 00 00 00       	mov    $0x0,%esi
   42b81:	48 89 c7             	mov    %rax,%rdi
   42b84:	e8 7a 13 00 00       	call   43f03 <printer_vprintf>
}
   42b89:	90                   	nop
   42b8a:	c9                   	leave  
   42b8b:	c3                   	ret    

0000000000042b8c <log_printf>:

void log_printf(const char* format, ...) {
   42b8c:	f3 0f 1e fa          	endbr64 
   42b90:	55                   	push   %rbp
   42b91:	48 89 e5             	mov    %rsp,%rbp
   42b94:	48 83 ec 60          	sub    $0x60,%rsp
   42b98:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42b9c:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42ba0:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42ba4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42ba8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42bac:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42bb0:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42bb7:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42bbb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42bbf:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42bc3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42bc7:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42bcb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42bcf:	48 89 d6             	mov    %rdx,%rsi
   42bd2:	48 89 c7             	mov    %rax,%rdi
   42bd5:	e8 77 ff ff ff       	call   42b51 <log_vprintf>
    va_end(val);
}
   42bda:	90                   	nop
   42bdb:	c9                   	leave  
   42bdc:	c3                   	ret    

0000000000042bdd <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42bdd:	f3 0f 1e fa          	endbr64 
   42be1:	55                   	push   %rbp
   42be2:	48 89 e5             	mov    %rsp,%rbp
   42be5:	48 83 ec 40          	sub    $0x40,%rsp
   42be9:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42bec:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42bef:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42bf3:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42bf7:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42bfb:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42bff:	48 8b 0a             	mov    (%rdx),%rcx
   42c02:	48 89 08             	mov    %rcx,(%rax)
   42c05:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42c09:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42c0d:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42c11:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42c15:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42c19:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c1d:	48 89 d6             	mov    %rdx,%rsi
   42c20:	48 89 c7             	mov    %rax,%rdi
   42c23:	e8 29 ff ff ff       	call   42b51 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42c28:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42c2c:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42c30:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42c33:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42c36:	89 c7                	mov    %eax,%edi
   42c38:	e8 c3 1d 00 00       	call   44a00 <console_vprintf>
}
   42c3d:	c9                   	leave  
   42c3e:	c3                   	ret    

0000000000042c3f <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42c3f:	f3 0f 1e fa          	endbr64 
   42c43:	55                   	push   %rbp
   42c44:	48 89 e5             	mov    %rsp,%rbp
   42c47:	48 83 ec 60          	sub    $0x60,%rsp
   42c4b:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42c4e:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42c51:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42c55:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42c59:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42c5d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42c61:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42c68:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42c6c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42c70:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42c74:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42c78:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42c7c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42c80:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42c83:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c86:	89 c7                	mov    %eax,%edi
   42c88:	e8 50 ff ff ff       	call   42bdd <error_vprintf>
   42c8d:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42c90:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42c93:	c9                   	leave  
   42c94:	c3                   	ret    

0000000000042c95 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42c95:	f3 0f 1e fa          	endbr64 
   42c99:	55                   	push   %rbp
   42c9a:	48 89 e5             	mov    %rsp,%rbp
   42c9d:	53                   	push   %rbx
   42c9e:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42ca2:	e8 73 fb ff ff       	call   4281a <keyboard_readc>
   42ca7:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42caa:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42cae:	74 1c                	je     42ccc <check_keyboard+0x37>
   42cb0:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42cb4:	74 16                	je     42ccc <check_keyboard+0x37>
   42cb6:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42cba:	74 10                	je     42ccc <check_keyboard+0x37>
   42cbc:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42cc0:	74 0a                	je     42ccc <check_keyboard+0x37>
   42cc2:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42cc6:	0f 85 02 01 00 00    	jne    42dce <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42ccc:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42cd3:	00 
        memset(pt, 0, PAGESIZE * 3);
   42cd4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cd8:	ba 00 30 00 00       	mov    $0x3000,%edx
   42cdd:	be 00 00 00 00       	mov    $0x0,%esi
   42ce2:	48 89 c7             	mov    %rax,%rdi
   42ce5:	e8 53 0f 00 00       	call   43c3d <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42cea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cee:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42cf5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cf9:	48 05 00 10 00 00    	add    $0x1000,%rax
   42cff:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42d06:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d0a:	48 05 00 20 00 00    	add    $0x2000,%rax
   42d10:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42d17:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d1b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42d1f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d23:	0f 22 d8             	mov    %rax,%cr3
}
   42d26:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42d27:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42d2e:	48 8d 05 e3 23 00 00 	lea    0x23e3(%rip),%rax        # 45118 <complex_keymap+0x58>
   42d35:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   42d39:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42d3d:	75 0d                	jne    42d4c <check_keyboard+0xb7>
            argument = "allocator";
   42d3f:	48 8d 05 d7 23 00 00 	lea    0x23d7(%rip),%rax        # 4511d <complex_keymap+0x5d>
   42d46:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42d4a:	eb 37                	jmp    42d83 <check_keyboard+0xee>
        } else if (c == 'e') {
   42d4c:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42d50:	75 0d                	jne    42d5f <check_keyboard+0xca>
            argument = "forkexit";
   42d52:	48 8d 05 ce 23 00 00 	lea    0x23ce(%rip),%rax        # 45127 <complex_keymap+0x67>
   42d59:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42d5d:	eb 24                	jmp    42d83 <check_keyboard+0xee>
        }
        else if (c == 't'){
   42d5f:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42d63:	75 0d                	jne    42d72 <check_keyboard+0xdd>
            argument = "test";
   42d65:	48 8d 05 c4 23 00 00 	lea    0x23c4(%rip),%rax        # 45130 <complex_keymap+0x70>
   42d6c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42d70:	eb 11                	jmp    42d83 <check_keyboard+0xee>
        }
        else if(c == '2'){
   42d72:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42d76:	75 0b                	jne    42d83 <check_keyboard+0xee>
            argument = "test2";
   42d78:	48 8d 05 b6 23 00 00 	lea    0x23b6(%rip),%rax        # 45135 <complex_keymap+0x75>
   42d7f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42d83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d87:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42d8b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42d90:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42d94:	76 1e                	jbe    42db4 <check_keyboard+0x11f>
   42d96:	48 8d 05 9e 23 00 00 	lea    0x239e(%rip),%rax        # 4513b <complex_keymap+0x7b>
   42d9d:	48 89 c2             	mov    %rax,%rdx
   42da0:	be 5d 02 00 00       	mov    $0x25d,%esi
   42da5:	48 8d 05 ab 23 00 00 	lea    0x23ab(%rip),%rax        # 45157 <complex_keymap+0x97>
   42dac:	48 89 c7             	mov    %rax,%rdi
   42daf:	e8 33 01 00 00       	call   42ee7 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42db4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42db8:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42dbb:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42dbf:	48 89 c3             	mov    %rax,%rbx
   42dc2:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42dc7:	e9 34 d2 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42dcc:	eb 11                	jmp    42ddf <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42dce:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42dd2:	74 06                	je     42dda <check_keyboard+0x145>
   42dd4:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42dd8:	75 05                	jne    42ddf <check_keyboard+0x14a>
        poweroff();
   42dda:	e8 3c f8 ff ff       	call   4261b <poweroff>
    }
    return c;
   42ddf:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42de2:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42de6:	c9                   	leave  
   42de7:	c3                   	ret    

0000000000042de8 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42de8:	f3 0f 1e fa          	endbr64 
   42dec:	55                   	push   %rbp
   42ded:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42df0:	e8 a0 fe ff ff       	call   42c95 <check_keyboard>
   42df5:	eb f9                	jmp    42df0 <fail+0x8>

0000000000042df7 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42df7:	f3 0f 1e fa          	endbr64 
   42dfb:	55                   	push   %rbp
   42dfc:	48 89 e5             	mov    %rsp,%rbp
   42dff:	48 83 ec 60          	sub    $0x60,%rsp
   42e03:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42e07:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42e0b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42e0f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42e13:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42e17:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42e1b:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42e22:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42e26:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42e2a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42e2e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42e32:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42e37:	0f 84 87 00 00 00    	je     42ec4 <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42e3d:	48 8d 05 27 23 00 00 	lea    0x2327(%rip),%rax        # 4516b <complex_keymap+0xab>
   42e44:	48 89 c2             	mov    %rax,%rdx
   42e47:	be 00 c0 00 00       	mov    $0xc000,%esi
   42e4c:	bf 30 07 00 00       	mov    $0x730,%edi
   42e51:	b8 00 00 00 00       	mov    $0x0,%eax
   42e56:	e8 e4 fd ff ff       	call   42c3f <error_printf>
   42e5b:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42e5e:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42e62:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42e66:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42e69:	be 00 c0 00 00       	mov    $0xc000,%esi
   42e6e:	89 c7                	mov    %eax,%edi
   42e70:	e8 68 fd ff ff       	call   42bdd <error_vprintf>
   42e75:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42e78:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42e7b:	48 63 c1             	movslq %ecx,%rax
   42e7e:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42e85:	48 c1 e8 20          	shr    $0x20,%rax
   42e89:	c1 f8 05             	sar    $0x5,%eax
   42e8c:	89 ce                	mov    %ecx,%esi
   42e8e:	c1 fe 1f             	sar    $0x1f,%esi
   42e91:	29 f0                	sub    %esi,%eax
   42e93:	89 c2                	mov    %eax,%edx
   42e95:	89 d0                	mov    %edx,%eax
   42e97:	c1 e0 02             	shl    $0x2,%eax
   42e9a:	01 d0                	add    %edx,%eax
   42e9c:	c1 e0 04             	shl    $0x4,%eax
   42e9f:	29 c1                	sub    %eax,%ecx
   42ea1:	89 ca                	mov    %ecx,%edx
   42ea3:	85 d2                	test   %edx,%edx
   42ea5:	74 3b                	je     42ee2 <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   42ea7:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42eaa:	48 8d 15 c2 22 00 00 	lea    0x22c2(%rip),%rdx        # 45173 <complex_keymap+0xb3>
   42eb1:	be 00 c0 00 00       	mov    $0xc000,%esi
   42eb6:	89 c7                	mov    %eax,%edi
   42eb8:	b8 00 00 00 00       	mov    $0x0,%eax
   42ebd:	e8 7d fd ff ff       	call   42c3f <error_printf>
   42ec2:	eb 1e                	jmp    42ee2 <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42ec4:	48 8d 05 aa 22 00 00 	lea    0x22aa(%rip),%rax        # 45175 <complex_keymap+0xb5>
   42ecb:	48 89 c2             	mov    %rax,%rdx
   42ece:	be 00 c0 00 00       	mov    $0xc000,%esi
   42ed3:	bf 30 07 00 00       	mov    $0x730,%edi
   42ed8:	b8 00 00 00 00       	mov    $0x0,%eax
   42edd:	e8 5d fd ff ff       	call   42c3f <error_printf>
    }

    va_end(val);
    fail();
   42ee2:	e8 01 ff ff ff       	call   42de8 <fail>

0000000000042ee7 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42ee7:	f3 0f 1e fa          	endbr64 
   42eeb:	55                   	push   %rbp
   42eec:	48 89 e5             	mov    %rsp,%rbp
   42eef:	48 83 ec 20          	sub    $0x20,%rsp
   42ef3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42ef7:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42efa:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42efe:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42f02:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42f05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f09:	48 89 c6             	mov    %rax,%rsi
   42f0c:	48 8d 05 68 22 00 00 	lea    0x2268(%rip),%rax        # 4517b <complex_keymap+0xbb>
   42f13:	48 89 c7             	mov    %rax,%rdi
   42f16:	b8 00 00 00 00       	mov    $0x0,%eax
   42f1b:	e8 d7 fe ff ff       	call   42df7 <panic>

0000000000042f20 <default_exception>:
}

void default_exception(proc* p){
   42f20:	f3 0f 1e fa          	endbr64 
   42f24:	55                   	push   %rbp
   42f25:	48 89 e5             	mov    %rsp,%rbp
   42f28:	48 83 ec 20          	sub    $0x20,%rsp
   42f2c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42f30:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f34:	48 83 c0 08          	add    $0x8,%rax
   42f38:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42f3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f40:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42f47:	48 89 c6             	mov    %rax,%rsi
   42f4a:	48 8d 05 48 22 00 00 	lea    0x2248(%rip),%rax        # 45199 <complex_keymap+0xd9>
   42f51:	48 89 c7             	mov    %rax,%rdi
   42f54:	b8 00 00 00 00       	mov    $0x0,%eax
   42f59:	e8 99 fe ff ff       	call   42df7 <panic>

0000000000042f5e <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42f5e:	55                   	push   %rbp
   42f5f:	48 89 e5             	mov    %rsp,%rbp
   42f62:	48 83 ec 10          	sub    $0x10,%rsp
   42f66:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42f6a:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42f6d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42f71:	78 06                	js     42f79 <pageindex+0x1b>
   42f73:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42f77:	7e 1e                	jle    42f97 <pageindex+0x39>
   42f79:	48 8d 05 38 22 00 00 	lea    0x2238(%rip),%rax        # 451b8 <complex_keymap+0xf8>
   42f80:	48 89 c2             	mov    %rax,%rdx
   42f83:	be 1e 00 00 00       	mov    $0x1e,%esi
   42f88:	48 8d 05 42 22 00 00 	lea    0x2242(%rip),%rax        # 451d1 <complex_keymap+0x111>
   42f8f:	48 89 c7             	mov    %rax,%rdi
   42f92:	e8 50 ff ff ff       	call   42ee7 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42f97:	b8 03 00 00 00       	mov    $0x3,%eax
   42f9c:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42f9f:	89 c2                	mov    %eax,%edx
   42fa1:	89 d0                	mov    %edx,%eax
   42fa3:	c1 e0 03             	shl    $0x3,%eax
   42fa6:	01 d0                	add    %edx,%eax
   42fa8:	83 c0 0c             	add    $0xc,%eax
   42fab:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42faf:	89 c1                	mov    %eax,%ecx
   42fb1:	48 d3 ea             	shr    %cl,%rdx
   42fb4:	48 89 d0             	mov    %rdx,%rax
   42fb7:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42fbc:	c9                   	leave  
   42fbd:	c3                   	ret    

0000000000042fbe <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42fbe:	f3 0f 1e fa          	endbr64 
   42fc2:	55                   	push   %rbp
   42fc3:	48 89 e5             	mov    %rsp,%rbp
   42fc6:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42fca:	48 8d 05 2f 30 01 00 	lea    0x1302f(%rip),%rax        # 56000 <kernel_pagetables>
   42fd1:	48 89 05 28 20 01 00 	mov    %rax,0x12028(%rip)        # 55000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42fd8:	ba 00 50 00 00       	mov    $0x5000,%edx
   42fdd:	be 00 00 00 00       	mov    $0x0,%esi
   42fe2:	48 8d 05 17 30 01 00 	lea    0x13017(%rip),%rax        # 56000 <kernel_pagetables>
   42fe9:	48 89 c7             	mov    %rax,%rdi
   42fec:	e8 4c 0c 00 00       	call   43c3d <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42ff1:	48 8d 05 08 40 01 00 	lea    0x14008(%rip),%rax        # 57000 <kernel_pagetables+0x1000>
   42ff8:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42ffc:	48 89 05 fd 2f 01 00 	mov    %rax,0x12ffd(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   43003:	48 8d 05 f6 4f 01 00 	lea    0x14ff6(%rip),%rax        # 58000 <kernel_pagetables+0x2000>
   4300a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   4300e:	48 89 05 eb 3f 01 00 	mov    %rax,0x13feb(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   43015:	48 8d 05 e4 5f 01 00 	lea    0x15fe4(%rip),%rax        # 59000 <kernel_pagetables+0x3000>
   4301c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   43020:	48 89 05 d9 4f 01 00 	mov    %rax,0x14fd9(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   43027:	48 8d 05 d2 6f 01 00 	lea    0x16fd2(%rip),%rax        # 5a000 <kernel_pagetables+0x4000>
   4302e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   43032:	48 89 05 cf 4f 01 00 	mov    %rax,0x14fcf(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   43039:	48 8b 05 c0 1f 01 00 	mov    0x11fc0(%rip),%rax        # 55000 <kernel_pagetable>
   43040:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43046:	b9 00 00 20 00       	mov    $0x200000,%ecx
   4304b:	ba 00 00 00 00       	mov    $0x0,%edx
   43050:	be 00 00 00 00       	mov    $0x0,%esi
   43055:	48 89 c7             	mov    %rax,%rdi
   43058:	e8 0e 02 00 00       	call   4326b <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4305d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43064:	00 
   43065:	eb 76                	jmp    430dd <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   43067:	48 8b 0d 92 1f 01 00 	mov    0x11f92(%rip),%rcx        # 55000 <kernel_pagetable>
   4306e:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   43072:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43076:	48 89 ce             	mov    %rcx,%rsi
   43079:	48 89 c7             	mov    %rax,%rdi
   4307c:	e8 34 06 00 00       	call   436b5 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   43081:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43085:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   43089:	74 1e                	je     430a9 <virtual_memory_init+0xeb>
   4308b:	48 8d 05 53 21 00 00 	lea    0x2153(%rip),%rax        # 451e5 <complex_keymap+0x125>
   43092:	48 89 c2             	mov    %rax,%rdx
   43095:	be 2d 00 00 00       	mov    $0x2d,%esi
   4309a:	48 8d 05 54 21 00 00 	lea    0x2154(%rip),%rax        # 451f5 <complex_keymap+0x135>
   430a1:	48 89 c7             	mov    %rax,%rdi
   430a4:	e8 3e fe ff ff       	call   42ee7 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   430a9:	8b 45 f0             	mov    -0x10(%rbp),%eax
   430ac:	48 98                	cltq   
   430ae:	83 e0 03             	and    $0x3,%eax
   430b1:	48 83 f8 03          	cmp    $0x3,%rax
   430b5:	74 1e                	je     430d5 <virtual_memory_init+0x117>
   430b7:	48 8d 05 4a 21 00 00 	lea    0x214a(%rip),%rax        # 45208 <complex_keymap+0x148>
   430be:	48 89 c2             	mov    %rax,%rdx
   430c1:	be 2e 00 00 00       	mov    $0x2e,%esi
   430c6:	48 8d 05 28 21 00 00 	lea    0x2128(%rip),%rax        # 451f5 <complex_keymap+0x135>
   430cd:	48 89 c7             	mov    %rax,%rdi
   430d0:	e8 12 fe ff ff       	call   42ee7 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   430d5:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   430dc:	00 
   430dd:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   430e4:	00 
   430e5:	76 80                	jbe    43067 <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   430e7:	48 8b 05 12 1f 01 00 	mov    0x11f12(%rip),%rax        # 55000 <kernel_pagetable>
   430ee:	48 89 c7             	mov    %rax,%rdi
   430f1:	e8 03 00 00 00       	call   430f9 <set_pagetable>
}
   430f6:	90                   	nop
   430f7:	c9                   	leave  
   430f8:	c3                   	ret    

00000000000430f9 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   430f9:	f3 0f 1e fa          	endbr64 
   430fd:	55                   	push   %rbp
   430fe:	48 89 e5             	mov    %rsp,%rbp
   43101:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   43105:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   43109:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4310d:	25 ff 0f 00 00       	and    $0xfff,%eax
   43112:	48 85 c0             	test   %rax,%rax
   43115:	74 1e                	je     43135 <set_pagetable+0x3c>
   43117:	48 8d 05 17 21 00 00 	lea    0x2117(%rip),%rax        # 45235 <complex_keymap+0x175>
   4311e:	48 89 c2             	mov    %rax,%rdx
   43121:	be 3c 00 00 00       	mov    $0x3c,%esi
   43126:	48 8d 05 c8 20 00 00 	lea    0x20c8(%rip),%rax        # 451f5 <complex_keymap+0x135>
   4312d:	48 89 c7             	mov    %rax,%rdi
   43130:	e8 b2 fd ff ff       	call   42ee7 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   43135:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   4313c:	48 89 c2             	mov    %rax,%rdx
   4313f:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   43143:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43147:	48 89 ce             	mov    %rcx,%rsi
   4314a:	48 89 c7             	mov    %rax,%rdi
   4314d:	e8 63 05 00 00       	call   436b5 <virtual_memory_lookup>
   43152:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43156:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   4315d:	48 39 d0             	cmp    %rdx,%rax
   43160:	74 1e                	je     43180 <set_pagetable+0x87>
   43162:	48 8d 05 e7 20 00 00 	lea    0x20e7(%rip),%rax        # 45250 <complex_keymap+0x190>
   43169:	48 89 c2             	mov    %rax,%rdx
   4316c:	be 3e 00 00 00       	mov    $0x3e,%esi
   43171:	48 8d 05 7d 20 00 00 	lea    0x207d(%rip),%rax        # 451f5 <complex_keymap+0x135>
   43178:	48 89 c7             	mov    %rax,%rdi
   4317b:	e8 67 fd ff ff       	call   42ee7 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   43180:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   43184:	48 8b 0d 75 1e 01 00 	mov    0x11e75(%rip),%rcx        # 55000 <kernel_pagetable>
   4318b:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4318f:	48 89 ce             	mov    %rcx,%rsi
   43192:	48 89 c7             	mov    %rax,%rdi
   43195:	e8 1b 05 00 00       	call   436b5 <virtual_memory_lookup>
   4319a:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4319e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   431a2:	48 39 c2             	cmp    %rax,%rdx
   431a5:	74 1e                	je     431c5 <set_pagetable+0xcc>
   431a7:	48 8d 05 0a 21 00 00 	lea    0x210a(%rip),%rax        # 452b8 <complex_keymap+0x1f8>
   431ae:	48 89 c2             	mov    %rax,%rdx
   431b1:	be 40 00 00 00       	mov    $0x40,%esi
   431b6:	48 8d 05 38 20 00 00 	lea    0x2038(%rip),%rax        # 451f5 <complex_keymap+0x135>
   431bd:	48 89 c7             	mov    %rax,%rdi
   431c0:	e8 22 fd ff ff       	call   42ee7 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   431c5:	48 8b 05 34 1e 01 00 	mov    0x11e34(%rip),%rax        # 55000 <kernel_pagetable>
   431cc:	48 89 c2             	mov    %rax,%rdx
   431cf:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   431d3:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   431d7:	48 89 ce             	mov    %rcx,%rsi
   431da:	48 89 c7             	mov    %rax,%rdi
   431dd:	e8 d3 04 00 00       	call   436b5 <virtual_memory_lookup>
   431e2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431e6:	48 8b 15 13 1e 01 00 	mov    0x11e13(%rip),%rdx        # 55000 <kernel_pagetable>
   431ed:	48 39 d0             	cmp    %rdx,%rax
   431f0:	74 1e                	je     43210 <set_pagetable+0x117>
   431f2:	48 8d 05 1f 21 00 00 	lea    0x211f(%rip),%rax        # 45318 <complex_keymap+0x258>
   431f9:	48 89 c2             	mov    %rax,%rdx
   431fc:	be 42 00 00 00       	mov    $0x42,%esi
   43201:	48 8d 05 ed 1f 00 00 	lea    0x1fed(%rip),%rax        # 451f5 <complex_keymap+0x135>
   43208:	48 89 c7             	mov    %rax,%rdi
   4320b:	e8 d7 fc ff ff       	call   42ee7 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   43210:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 4326b <virtual_memory_map>
   43217:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4321b:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4321f:	48 89 ce             	mov    %rcx,%rsi
   43222:	48 89 c7             	mov    %rax,%rdi
   43225:	e8 8b 04 00 00       	call   436b5 <virtual_memory_lookup>
   4322a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4322e:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 4326b <virtual_memory_map>
   43235:	48 39 d0             	cmp    %rdx,%rax
   43238:	74 1e                	je     43258 <set_pagetable+0x15f>
   4323a:	48 8d 05 3f 21 00 00 	lea    0x213f(%rip),%rax        # 45380 <complex_keymap+0x2c0>
   43241:	48 89 c2             	mov    %rax,%rdx
   43244:	be 44 00 00 00       	mov    $0x44,%esi
   43249:	48 8d 05 a5 1f 00 00 	lea    0x1fa5(%rip),%rax        # 451f5 <complex_keymap+0x135>
   43250:	48 89 c7             	mov    %rax,%rdi
   43253:	e8 8f fc ff ff       	call   42ee7 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   43258:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4325c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   43260:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43264:	0f 22 d8             	mov    %rax,%cr3
}
   43267:	90                   	nop
}
   43268:	90                   	nop
   43269:	c9                   	leave  
   4326a:	c3                   	ret    

000000000004326b <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   4326b:	f3 0f 1e fa          	endbr64 
   4326f:	55                   	push   %rbp
   43270:	48 89 e5             	mov    %rsp,%rbp
   43273:	48 83 ec 50          	sub    $0x50,%rsp
   43277:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4327b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4327f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43283:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   43287:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4328b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4328f:	25 ff 0f 00 00       	and    $0xfff,%eax
   43294:	48 85 c0             	test   %rax,%rax
   43297:	74 1e                	je     432b7 <virtual_memory_map+0x4c>
   43299:	48 8d 05 46 21 00 00 	lea    0x2146(%rip),%rax        # 453e6 <complex_keymap+0x326>
   432a0:	48 89 c2             	mov    %rax,%rdx
   432a3:	be 65 00 00 00       	mov    $0x65,%esi
   432a8:	48 8d 05 46 1f 00 00 	lea    0x1f46(%rip),%rax        # 451f5 <complex_keymap+0x135>
   432af:	48 89 c7             	mov    %rax,%rdi
   432b2:	e8 30 fc ff ff       	call   42ee7 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   432b7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   432bb:	25 ff 0f 00 00       	and    $0xfff,%eax
   432c0:	48 85 c0             	test   %rax,%rax
   432c3:	74 1e                	je     432e3 <virtual_memory_map+0x78>
   432c5:	48 8d 05 2d 21 00 00 	lea    0x212d(%rip),%rax        # 453f9 <complex_keymap+0x339>
   432cc:	48 89 c2             	mov    %rax,%rdx
   432cf:	be 66 00 00 00       	mov    $0x66,%esi
   432d4:	48 8d 05 1a 1f 00 00 	lea    0x1f1a(%rip),%rax        # 451f5 <complex_keymap+0x135>
   432db:	48 89 c7             	mov    %rax,%rdi
   432de:	e8 04 fc ff ff       	call   42ee7 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   432e3:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   432e7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   432eb:	48 01 d0             	add    %rdx,%rax
   432ee:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   432f2:	76 2e                	jbe    43322 <virtual_memory_map+0xb7>
   432f4:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   432f8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   432fc:	48 01 d0             	add    %rdx,%rax
   432ff:	48 85 c0             	test   %rax,%rax
   43302:	74 1e                	je     43322 <virtual_memory_map+0xb7>
   43304:	48 8d 05 01 21 00 00 	lea    0x2101(%rip),%rax        # 4540c <complex_keymap+0x34c>
   4330b:	48 89 c2             	mov    %rax,%rdx
   4330e:	be 67 00 00 00       	mov    $0x67,%esi
   43313:	48 8d 05 db 1e 00 00 	lea    0x1edb(%rip),%rax        # 451f5 <complex_keymap+0x135>
   4331a:	48 89 c7             	mov    %rax,%rdi
   4331d:	e8 c5 fb ff ff       	call   42ee7 <assert_fail>
    if (perm & PTE_P) {
   43322:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43325:	48 98                	cltq   
   43327:	83 e0 01             	and    $0x1,%eax
   4332a:	48 85 c0             	test   %rax,%rax
   4332d:	0f 84 8c 00 00 00    	je     433bf <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   43333:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43337:	25 ff 0f 00 00       	and    $0xfff,%eax
   4333c:	48 85 c0             	test   %rax,%rax
   4333f:	74 1e                	je     4335f <virtual_memory_map+0xf4>
   43341:	48 8d 05 e2 20 00 00 	lea    0x20e2(%rip),%rax        # 4542a <complex_keymap+0x36a>
   43348:	48 89 c2             	mov    %rax,%rdx
   4334b:	be 69 00 00 00       	mov    $0x69,%esi
   43350:	48 8d 05 9e 1e 00 00 	lea    0x1e9e(%rip),%rax        # 451f5 <complex_keymap+0x135>
   43357:	48 89 c7             	mov    %rax,%rdi
   4335a:	e8 88 fb ff ff       	call   42ee7 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   4335f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43363:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43367:	48 01 d0             	add    %rdx,%rax
   4336a:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   4336e:	76 1e                	jbe    4338e <virtual_memory_map+0x123>
   43370:	48 8d 05 c6 20 00 00 	lea    0x20c6(%rip),%rax        # 4543d <complex_keymap+0x37d>
   43377:	48 89 c2             	mov    %rax,%rdx
   4337a:	be 6a 00 00 00       	mov    $0x6a,%esi
   4337f:	48 8d 05 6f 1e 00 00 	lea    0x1e6f(%rip),%rax        # 451f5 <complex_keymap+0x135>
   43386:	48 89 c7             	mov    %rax,%rdi
   43389:	e8 59 fb ff ff       	call   42ee7 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   4338e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43392:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43396:	48 01 d0             	add    %rdx,%rax
   43399:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   4339f:	76 1e                	jbe    433bf <virtual_memory_map+0x154>
   433a1:	48 8d 05 a3 20 00 00 	lea    0x20a3(%rip),%rax        # 4544b <complex_keymap+0x38b>
   433a8:	48 89 c2             	mov    %rax,%rdx
   433ab:	be 6b 00 00 00       	mov    $0x6b,%esi
   433b0:	48 8d 05 3e 1e 00 00 	lea    0x1e3e(%rip),%rax        # 451f5 <complex_keymap+0x135>
   433b7:	48 89 c7             	mov    %rax,%rdi
   433ba:	e8 28 fb ff ff       	call   42ee7 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   433bf:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   433c3:	78 09                	js     433ce <virtual_memory_map+0x163>
   433c5:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   433cc:	7e 1e                	jle    433ec <virtual_memory_map+0x181>
   433ce:	48 8d 05 92 20 00 00 	lea    0x2092(%rip),%rax        # 45467 <complex_keymap+0x3a7>
   433d5:	48 89 c2             	mov    %rax,%rdx
   433d8:	be 6d 00 00 00       	mov    $0x6d,%esi
   433dd:	48 8d 05 11 1e 00 00 	lea    0x1e11(%rip),%rax        # 451f5 <complex_keymap+0x135>
   433e4:	48 89 c7             	mov    %rax,%rdi
   433e7:	e8 fb fa ff ff       	call   42ee7 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   433ec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433f0:	25 ff 0f 00 00       	and    $0xfff,%eax
   433f5:	48 85 c0             	test   %rax,%rax
   433f8:	74 1e                	je     43418 <virtual_memory_map+0x1ad>
   433fa:	48 8d 05 87 20 00 00 	lea    0x2087(%rip),%rax        # 45488 <complex_keymap+0x3c8>
   43401:	48 89 c2             	mov    %rax,%rdx
   43404:	be 6e 00 00 00       	mov    $0x6e,%esi
   43409:	48 8d 05 e5 1d 00 00 	lea    0x1de5(%rip),%rax        # 451f5 <complex_keymap+0x135>
   43410:	48 89 c7             	mov    %rax,%rdi
   43413:	e8 cf fa ff ff       	call   42ee7 <assert_fail>

    int last_index123 = -1;
   43418:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   4341f:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   43426:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43427:	e9 ed 00 00 00       	jmp    43519 <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   4342c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43430:	48 c1 e8 15          	shr    $0x15,%rax
   43434:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   43437:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4343a:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   4343d:	74 20                	je     4345f <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   4343f:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43442:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   43446:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4344a:	48 89 ce             	mov    %rcx,%rsi
   4344d:	48 89 c7             	mov    %rax,%rdi
   43450:	e8 d6 00 00 00       	call   4352b <lookup_l1pagetable>
   43455:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   43459:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4345c:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   4345f:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43462:	48 98                	cltq   
   43464:	83 e0 01             	and    $0x1,%eax
   43467:	48 85 c0             	test   %rax,%rax
   4346a:	74 37                	je     434a3 <virtual_memory_map+0x238>
   4346c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43471:	74 30                	je     434a3 <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   43473:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43477:	be 03 00 00 00       	mov    $0x3,%esi
   4347c:	48 89 c7             	mov    %rax,%rdi
   4347f:	e8 da fa ff ff       	call   42f5e <pageindex>
   43484:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   43487:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4348a:	48 98                	cltq   
   4348c:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   43490:	48 89 c1             	mov    %rax,%rcx
   43493:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43497:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4349a:	48 63 d2             	movslq %edx,%rdx
   4349d:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   434a1:	eb 5e                	jmp    43501 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   434a3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   434a8:	74 2a                	je     434d4 <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   434aa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434ae:	be 03 00 00 00       	mov    $0x3,%esi
   434b3:	48 89 c7             	mov    %rax,%rdi
   434b6:	e8 a3 fa ff ff       	call   42f5e <pageindex>
   434bb:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   434be:	8b 45 bc             	mov    -0x44(%rbp),%eax
   434c1:	48 63 c8             	movslq %eax,%rcx
   434c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434c8:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   434cb:	48 63 d2             	movslq %edx,%rdx
   434ce:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   434d2:	eb 2d                	jmp    43501 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   434d4:	8b 45 bc             	mov    -0x44(%rbp),%eax
   434d7:	48 98                	cltq   
   434d9:	83 e0 01             	and    $0x1,%eax
   434dc:	48 85 c0             	test   %rax,%rax
   434df:	74 20                	je     43501 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   434e1:	be 87 00 00 00       	mov    $0x87,%esi
   434e6:	48 8d 05 c3 1f 00 00 	lea    0x1fc3(%rip),%rax        # 454b0 <complex_keymap+0x3f0>
   434ed:	48 89 c7             	mov    %rax,%rdi
   434f0:	b8 00 00 00 00       	mov    $0x0,%eax
   434f5:	e8 92 f6 ff ff       	call   42b8c <log_printf>
            return -1;
   434fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   434ff:	eb 28                	jmp    43529 <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43501:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   43508:	00 
   43509:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   43510:	00 
   43511:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   43518:	00 
   43519:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   4351e:	0f 85 08 ff ff ff    	jne    4342c <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   43524:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43529:	c9                   	leave  
   4352a:	c3                   	ret    

000000000004352b <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   4352b:	f3 0f 1e fa          	endbr64 
   4352f:	55                   	push   %rbp
   43530:	48 89 e5             	mov    %rsp,%rbp
   43533:	48 83 ec 40          	sub    $0x40,%rsp
   43537:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4353b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4353f:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   43542:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43546:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   4354a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   43551:	e9 4f 01 00 00       	jmp    436a5 <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        int index = PAGEINDEX(va, i); // Get the index for the current level
   43556:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43559:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4355d:	89 d6                	mov    %edx,%esi
   4355f:	48 89 c7             	mov    %rax,%rdi
   43562:	e8 f7 f9 ff ff       	call   42f5e <pageindex>
   43567:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   4356a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4356e:	8b 55 f0             	mov    -0x10(%rbp),%edx
   43571:	48 63 d2             	movslq %edx,%rdx
   43574:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   43578:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   4357c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43580:	83 e0 01             	and    $0x1,%eax
   43583:	48 85 c0             	test   %rax,%rax
   43586:	75 6d                	jne    435f5 <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   43588:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4358b:	8d 48 02             	lea    0x2(%rax),%ecx
   4358e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43592:	25 ff 0f 00 00       	and    $0xfff,%eax
   43597:	48 89 c2             	mov    %rax,%rdx
   4359a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4359e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   435a4:	48 89 c6             	mov    %rax,%rsi
   435a7:	48 8d 05 4a 1f 00 00 	lea    0x1f4a(%rip),%rax        # 454f8 <complex_keymap+0x438>
   435ae:	48 89 c7             	mov    %rax,%rdi
   435b1:	b8 00 00 00 00       	mov    $0x0,%eax
   435b6:	e8 d1 f5 ff ff       	call   42b8c <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   435bb:	8b 45 cc             	mov    -0x34(%rbp),%eax
   435be:	48 98                	cltq   
   435c0:	83 e0 01             	and    $0x1,%eax
   435c3:	48 85 c0             	test   %rax,%rax
   435c6:	75 0a                	jne    435d2 <lookup_l1pagetable+0xa7>
                return NULL;
   435c8:	b8 00 00 00 00       	mov    $0x0,%eax
   435cd:	e9 e1 00 00 00       	jmp    436b3 <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   435d2:	be ac 00 00 00       	mov    $0xac,%esi
   435d7:	48 8d 05 82 1f 00 00 	lea    0x1f82(%rip),%rax        # 45560 <complex_keymap+0x4a0>
   435de:	48 89 c7             	mov    %rax,%rdi
   435e1:	b8 00 00 00 00       	mov    $0x0,%eax
   435e6:	e8 a1 f5 ff ff       	call   42b8c <log_printf>
            return NULL;
   435eb:	b8 00 00 00 00       	mov    $0x0,%eax
   435f0:	e9 be 00 00 00       	jmp    436b3 <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   435f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435f9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   435ff:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   43605:	76 1e                	jbe    43625 <lookup_l1pagetable+0xfa>
   43607:	48 8d 05 9a 1f 00 00 	lea    0x1f9a(%rip),%rax        # 455a8 <complex_keymap+0x4e8>
   4360e:	48 89 c2             	mov    %rax,%rdx
   43611:	be b1 00 00 00       	mov    $0xb1,%esi
   43616:	48 8d 05 d8 1b 00 00 	lea    0x1bd8(%rip),%rax        # 451f5 <complex_keymap+0x135>
   4361d:	48 89 c7             	mov    %rax,%rdi
   43620:	e8 c2 f8 ff ff       	call   42ee7 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   43625:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43628:	48 98                	cltq   
   4362a:	83 e0 02             	and    $0x2,%eax
   4362d:	48 85 c0             	test   %rax,%rax
   43630:	74 2a                	je     4365c <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   43632:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43636:	83 e0 02             	and    $0x2,%eax
   43639:	48 85 c0             	test   %rax,%rax
   4363c:	75 1e                	jne    4365c <lookup_l1pagetable+0x131>
   4363e:	48 8d 05 83 1f 00 00 	lea    0x1f83(%rip),%rax        # 455c8 <complex_keymap+0x508>
   43645:	48 89 c2             	mov    %rax,%rdx
   43648:	be b3 00 00 00       	mov    $0xb3,%esi
   4364d:	48 8d 05 a1 1b 00 00 	lea    0x1ba1(%rip),%rax        # 451f5 <complex_keymap+0x135>
   43654:	48 89 c7             	mov    %rax,%rdi
   43657:	e8 8b f8 ff ff       	call   42ee7 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   4365c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4365f:	48 98                	cltq   
   43661:	83 e0 04             	and    $0x4,%eax
   43664:	48 85 c0             	test   %rax,%rax
   43667:	74 2a                	je     43693 <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   43669:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4366d:	83 e0 04             	and    $0x4,%eax
   43670:	48 85 c0             	test   %rax,%rax
   43673:	75 1e                	jne    43693 <lookup_l1pagetable+0x168>
   43675:	48 8d 05 57 1f 00 00 	lea    0x1f57(%rip),%rax        # 455d3 <complex_keymap+0x513>
   4367c:	48 89 c2             	mov    %rax,%rdx
   4367f:	be b6 00 00 00       	mov    $0xb6,%esi
   43684:	48 8d 05 6a 1b 00 00 	lea    0x1b6a(%rip),%rax        # 451f5 <complex_keymap+0x135>
   4368b:	48 89 c7             	mov    %rax,%rdi
   4368e:	e8 54 f8 ff ff       	call   42ee7 <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43693:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43697:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4369d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   436a1:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   436a5:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   436a9:	0f 8e a7 fe ff ff    	jle    43556 <lookup_l1pagetable+0x2b>
    }
    return pt;
   436af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   436b3:	c9                   	leave  
   436b4:	c3                   	ret    

00000000000436b5 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   436b5:	f3 0f 1e fa          	endbr64 
   436b9:	55                   	push   %rbp
   436ba:	48 89 e5             	mov    %rsp,%rbp
   436bd:	48 83 ec 50          	sub    $0x50,%rsp
   436c1:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   436c5:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   436c9:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   436cd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   436d1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   436d5:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   436dc:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   436dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   436e4:	eb 41                	jmp    43727 <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   436e6:	8b 55 ec             	mov    -0x14(%rbp),%edx
   436e9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   436ed:	89 d6                	mov    %edx,%esi
   436ef:	48 89 c7             	mov    %rax,%rdi
   436f2:	e8 67 f8 ff ff       	call   42f5e <pageindex>
   436f7:	89 c2                	mov    %eax,%edx
   436f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436fd:	48 63 d2             	movslq %edx,%rdx
   43700:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43704:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43708:	83 e0 06             	and    $0x6,%eax
   4370b:	48 f7 d0             	not    %rax
   4370e:	48 21 d0             	and    %rdx,%rax
   43711:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43715:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43719:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4371f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43723:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43727:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4372b:	7f 0c                	jg     43739 <virtual_memory_lookup+0x84>
   4372d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43731:	83 e0 01             	and    $0x1,%eax
   43734:	48 85 c0             	test   %rax,%rax
   43737:	75 ad                	jne    436e6 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   43739:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43740:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   43747:	ff 
   43748:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   4374f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43753:	83 e0 01             	and    $0x1,%eax
   43756:	48 85 c0             	test   %rax,%rax
   43759:	74 34                	je     4378f <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   4375b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4375f:	48 c1 e8 0c          	shr    $0xc,%rax
   43763:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43766:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4376a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43770:	48 89 c2             	mov    %rax,%rdx
   43773:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43777:	25 ff 0f 00 00       	and    $0xfff,%eax
   4377c:	48 09 d0             	or     %rdx,%rax
   4377f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   43783:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43787:	25 ff 0f 00 00       	and    $0xfff,%eax
   4378c:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   4378f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43793:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43797:	48 89 10             	mov    %rdx,(%rax)
   4379a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   4379e:	48 89 50 08          	mov    %rdx,0x8(%rax)
   437a2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   437a6:	48 89 50 10          	mov    %rdx,0x10(%rax)
   437aa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   437ae:	c9                   	leave  
   437af:	c3                   	ret    

00000000000437b0 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   437b0:	f3 0f 1e fa          	endbr64 
   437b4:	55                   	push   %rbp
   437b5:	48 89 e5             	mov    %rsp,%rbp
   437b8:	48 83 ec 40          	sub    $0x40,%rsp
   437bc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   437c0:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   437c3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   437c7:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   437ce:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   437d2:	78 08                	js     437dc <program_load+0x2c>
   437d4:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   437d7:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   437da:	7c 1e                	jl     437fa <program_load+0x4a>
   437dc:	48 8d 05 fd 1d 00 00 	lea    0x1dfd(%rip),%rax        # 455e0 <complex_keymap+0x520>
   437e3:	48 89 c2             	mov    %rax,%rdx
   437e6:	be 37 00 00 00       	mov    $0x37,%esi
   437eb:	48 8d 05 1e 1e 00 00 	lea    0x1e1e(%rip),%rax        # 45610 <complex_keymap+0x550>
   437f2:	48 89 c7             	mov    %rax,%rdi
   437f5:	e8 ed f6 ff ff       	call   42ee7 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   437fa:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   437fd:	48 98                	cltq   
   437ff:	48 c1 e0 04          	shl    $0x4,%rax
   43803:	48 89 c2             	mov    %rax,%rdx
   43806:	48 8d 05 13 28 00 00 	lea    0x2813(%rip),%rax        # 46020 <ramimages>
   4380d:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   43811:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43815:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43819:	8b 00                	mov    (%rax),%eax
   4381b:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43820:	74 1e                	je     43840 <program_load+0x90>
   43822:	48 8d 05 f9 1d 00 00 	lea    0x1df9(%rip),%rax        # 45622 <complex_keymap+0x562>
   43829:	48 89 c2             	mov    %rax,%rdx
   4382c:	be 39 00 00 00       	mov    $0x39,%esi
   43831:	48 8d 05 d8 1d 00 00 	lea    0x1dd8(%rip),%rax        # 45610 <complex_keymap+0x550>
   43838:	48 89 c7             	mov    %rax,%rdi
   4383b:	e8 a7 f6 ff ff       	call   42ee7 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43840:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43844:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43848:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4384c:	48 01 d0             	add    %rdx,%rax
   4384f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43853:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4385a:	e9 94 00 00 00       	jmp    438f3 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   4385f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43862:	48 63 d0             	movslq %eax,%rdx
   43865:	48 89 d0             	mov    %rdx,%rax
   43868:	48 c1 e0 03          	shl    $0x3,%rax
   4386c:	48 29 d0             	sub    %rdx,%rax
   4386f:	48 c1 e0 03          	shl    $0x3,%rax
   43873:	48 89 c2             	mov    %rax,%rdx
   43876:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4387a:	48 01 d0             	add    %rdx,%rax
   4387d:	8b 00                	mov    (%rax),%eax
   4387f:	83 f8 01             	cmp    $0x1,%eax
   43882:	75 6b                	jne    438ef <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   43884:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43887:	48 63 d0             	movslq %eax,%rdx
   4388a:	48 89 d0             	mov    %rdx,%rax
   4388d:	48 c1 e0 03          	shl    $0x3,%rax
   43891:	48 29 d0             	sub    %rdx,%rax
   43894:	48 c1 e0 03          	shl    $0x3,%rax
   43898:	48 89 c2             	mov    %rax,%rdx
   4389b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4389f:	48 01 d0             	add    %rdx,%rax
   438a2:	48 8b 50 08          	mov    0x8(%rax),%rdx
   438a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438aa:	48 01 d0             	add    %rdx,%rax
   438ad:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   438b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   438b4:	48 63 d0             	movslq %eax,%rdx
   438b7:	48 89 d0             	mov    %rdx,%rax
   438ba:	48 c1 e0 03          	shl    $0x3,%rax
   438be:	48 29 d0             	sub    %rdx,%rax
   438c1:	48 c1 e0 03          	shl    $0x3,%rax
   438c5:	48 89 c2             	mov    %rax,%rdx
   438c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438cc:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   438d0:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   438d4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   438d8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438dc:	48 89 c7             	mov    %rax,%rdi
   438df:	e8 3d 00 00 00       	call   43921 <program_load_segment>
   438e4:	85 c0                	test   %eax,%eax
   438e6:	79 07                	jns    438ef <program_load+0x13f>
                return -1;
   438e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438ed:	eb 30                	jmp    4391f <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   438ef:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   438f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438f7:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   438fb:	0f b7 c0             	movzwl %ax,%eax
   438fe:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43901:	0f 8c 58 ff ff ff    	jl     4385f <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   43907:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4390b:	48 8b 50 18          	mov    0x18(%rax),%rdx
   4390f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43913:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   4391a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4391f:	c9                   	leave  
   43920:	c3                   	ret    

0000000000043921 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43921:	f3 0f 1e fa          	endbr64 
   43925:	55                   	push   %rbp
   43926:	48 89 e5             	mov    %rsp,%rbp
   43929:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4392d:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   43931:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   43935:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   43939:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4393d:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43941:	48 8b 40 10          	mov    0x10(%rax),%rax
   43945:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   43949:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   4394d:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43951:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43955:	48 01 d0             	add    %rdx,%rax
   43958:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4395c:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43960:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43964:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43968:	48 01 d0             	add    %rdx,%rax
   4396b:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   4396f:	48 81 65 e0 00 f0 ff 	andq   $0xfffffffffffff000,-0x20(%rbp)
   43976:	ff 

    int perms = PTE_P | PTE_W | PTE_U;
   43977:	c7 45 fc 07 00 00 00 	movl   $0x7,-0x4(%rbp)
    if ((ph->p_flags & ELF_PFLAG_WRITE) == 0){
   4397e:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43982:	8b 40 04             	mov    0x4(%rax),%eax
   43985:	83 e0 02             	and    $0x2,%eax
   43988:	85 c0                	test   %eax,%eax
   4398a:	75 07                	jne    43993 <program_load_segment+0x72>
        perms = PTE_P | PTE_U;
   4398c:	c7 45 fc 05 00 00 00 	movl   $0x5,-0x4(%rbp)
    }
    uintptr_t pa = 0;
   43993:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
   4399a:	00 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4399b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4399f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   439a3:	eb 7d                	jmp    43a22 <program_load_segment+0x101>
        pa = find_page(p->p_pid);
   439a5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   439a9:	8b 00                	mov    (%rax),%eax
   439ab:	0f be c0             	movsbl %al,%eax
   439ae:	89 c7                	mov    %eax,%edi
   439b0:	e8 4f ca ff ff       	call   40404 <find_page>
   439b5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   439b9:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   439bd:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   439c4:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   439c8:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   439cc:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   439d2:	b9 00 10 00 00       	mov    $0x1000,%ecx
   439d7:	48 89 c7             	mov    %rax,%rdi
   439da:	e8 8c f8 ff ff       	call   4326b <virtual_memory_map>
   439df:	85 c0                	test   %eax,%eax
   439e1:	79 37                	jns    43a1a <program_load_segment+0xf9>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   439e3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   439e7:	8b 00                	mov    (%rax),%eax
   439e9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   439ed:	49 89 d0             	mov    %rdx,%r8
   439f0:	89 c1                	mov    %eax,%ecx
   439f2:	48 8d 05 47 1c 00 00 	lea    0x1c47(%rip),%rax        # 45640 <complex_keymap+0x580>
   439f9:	48 89 c2             	mov    %rax,%rdx
   439fc:	be 00 c0 00 00       	mov    $0xc000,%esi
   43a01:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43a06:	b8 00 00 00 00       	mov    $0x0,%eax
   43a0b:	e8 6c 10 00 00       	call   44a7c <console_printf>
            return -1;
   43a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a15:	e9 1b 01 00 00       	jmp    43b35 <program_load_segment+0x214>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43a1a:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43a21:	00 
   43a22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a26:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   43a2a:	0f 82 75 ff ff ff    	jb     439a5 <program_load_segment+0x84>
        }
    }
    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43a30:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43a34:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43a3b:	48 89 c7             	mov    %rax,%rdi
   43a3e:	e8 b6 f6 ff ff       	call   430f9 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43a43:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a47:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   43a4b:	48 89 c2             	mov    %rax,%rdx
   43a4e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a52:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43a56:	48 89 ce             	mov    %rcx,%rsi
   43a59:	48 89 c7             	mov    %rax,%rdi
   43a5c:	e8 d6 00 00 00       	call   43b37 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43a61:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43a65:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
   43a69:	48 89 c2             	mov    %rax,%rdx
   43a6c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a70:	be 00 00 00 00       	mov    $0x0,%esi
   43a75:	48 89 c7             	mov    %rax,%rdi
   43a78:	e8 c0 01 00 00       	call   43c3d <memset>
    
    // update perms
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43a7d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a81:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43a85:	e9 89 00 00 00       	jmp    43b13 <program_load_segment+0x1f2>
        vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   43a8a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43a8e:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   43a95:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   43a99:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   43a9d:	48 89 ce             	mov    %rcx,%rsi
   43aa0:	48 89 c7             	mov    %rax,%rdi
   43aa3:	e8 0d fc ff ff       	call   436b5 <virtual_memory_lookup>
        int r = virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   43aa8:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   43aac:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43ab0:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43ab7:	8b 4d fc             	mov    -0x4(%rbp),%ecx
   43aba:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   43abe:	41 89 c8             	mov    %ecx,%r8d
   43ac1:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43ac6:	48 89 c7             	mov    %rax,%rdi
   43ac9:	e8 9d f7 ff ff       	call   4326b <virtual_memory_map>
   43ace:	89 45 c4             	mov    %eax,-0x3c(%rbp)
                                  perms);
        if (r < 0){
   43ad1:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
   43ad5:	79 34                	jns    43b0b <program_load_segment+0x1ea>
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43ad7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43adb:	8b 00                	mov    (%rax),%eax
   43add:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   43ae1:	49 89 d0             	mov    %rdx,%r8
   43ae4:	89 c1                	mov    %eax,%ecx
   43ae6:	48 8d 05 53 1b 00 00 	lea    0x1b53(%rip),%rax        # 45640 <complex_keymap+0x580>
   43aed:	48 89 c2             	mov    %rax,%rdx
   43af0:	be 00 c0 00 00       	mov    $0xc000,%esi
   43af5:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43afa:	b8 00 00 00 00       	mov    $0x0,%eax
   43aff:	e8 78 0f 00 00       	call   44a7c <console_printf>
            return -1;
   43b04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b09:	eb 2a                	jmp    43b35 <program_load_segment+0x214>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43b0b:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   43b12:	00 
   43b13:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b17:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   43b1b:	0f 82 69 ff ff ff    	jb     43a8a <program_load_segment+0x169>
        }
        }


    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43b21:	48 8b 05 d8 14 01 00 	mov    0x114d8(%rip),%rax        # 55000 <kernel_pagetable>
   43b28:	48 89 c7             	mov    %rax,%rdi
   43b2b:	e8 c9 f5 ff ff       	call   430f9 <set_pagetable>
    return 0;
   43b30:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43b35:	c9                   	leave  
   43b36:	c3                   	ret    

0000000000043b37 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43b37:	f3 0f 1e fa          	endbr64 
   43b3b:	55                   	push   %rbp
   43b3c:	48 89 e5             	mov    %rsp,%rbp
   43b3f:	48 83 ec 28          	sub    $0x28,%rsp
   43b43:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b47:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43b4b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43b4f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43b53:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43b57:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b5b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43b5f:	eb 1c                	jmp    43b7d <memcpy+0x46>
        *d = *s;
   43b61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b65:	0f b6 10             	movzbl (%rax),%edx
   43b68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b6c:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43b6e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43b73:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43b78:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43b7d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43b82:	75 dd                	jne    43b61 <memcpy+0x2a>
    }
    return dst;
   43b84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43b88:	c9                   	leave  
   43b89:	c3                   	ret    

0000000000043b8a <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43b8a:	f3 0f 1e fa          	endbr64 
   43b8e:	55                   	push   %rbp
   43b8f:	48 89 e5             	mov    %rsp,%rbp
   43b92:	48 83 ec 28          	sub    $0x28,%rsp
   43b96:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b9a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43b9e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43ba2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ba6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43baa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bae:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43bb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bb6:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43bba:	73 6a                	jae    43c26 <memmove+0x9c>
   43bbc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43bc0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43bc4:	48 01 d0             	add    %rdx,%rax
   43bc7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43bcb:	73 59                	jae    43c26 <memmove+0x9c>
        s += n, d += n;
   43bcd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43bd1:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43bd5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43bd9:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43bdd:	eb 17                	jmp    43bf6 <memmove+0x6c>
            *--d = *--s;
   43bdf:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43be4:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43be9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bed:	0f b6 10             	movzbl (%rax),%edx
   43bf0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bf4:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43bf6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43bfa:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43bfe:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43c02:	48 85 c0             	test   %rax,%rax
   43c05:	75 d8                	jne    43bdf <memmove+0x55>
    if (s < d && s + n > d) {
   43c07:	eb 2e                	jmp    43c37 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43c09:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c0d:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43c11:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c19:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43c1d:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43c21:	0f b6 12             	movzbl (%rdx),%edx
   43c24:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43c26:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c2a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43c2e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43c32:	48 85 c0             	test   %rax,%rax
   43c35:	75 d2                	jne    43c09 <memmove+0x7f>
        }
    }
    return dst;
   43c37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43c3b:	c9                   	leave  
   43c3c:	c3                   	ret    

0000000000043c3d <memset>:

void* memset(void* v, int c, size_t n) {
   43c3d:	f3 0f 1e fa          	endbr64 
   43c41:	55                   	push   %rbp
   43c42:	48 89 e5             	mov    %rsp,%rbp
   43c45:	48 83 ec 28          	sub    $0x28,%rsp
   43c49:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c4d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43c50:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43c54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c58:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c5c:	eb 15                	jmp    43c73 <memset+0x36>
        *p = c;
   43c5e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43c61:	89 c2                	mov    %eax,%edx
   43c63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c67:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43c69:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43c6e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43c73:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43c78:	75 e4                	jne    43c5e <memset+0x21>
    }
    return v;
   43c7a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43c7e:	c9                   	leave  
   43c7f:	c3                   	ret    

0000000000043c80 <strlen>:

size_t strlen(const char* s) {
   43c80:	f3 0f 1e fa          	endbr64 
   43c84:	55                   	push   %rbp
   43c85:	48 89 e5             	mov    %rsp,%rbp
   43c88:	48 83 ec 18          	sub    $0x18,%rsp
   43c8c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43c90:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43c97:	00 
   43c98:	eb 0a                	jmp    43ca4 <strlen+0x24>
        ++n;
   43c9a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43c9f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43ca4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ca8:	0f b6 00             	movzbl (%rax),%eax
   43cab:	84 c0                	test   %al,%al
   43cad:	75 eb                	jne    43c9a <strlen+0x1a>
    }
    return n;
   43caf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43cb3:	c9                   	leave  
   43cb4:	c3                   	ret    

0000000000043cb5 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43cb5:	f3 0f 1e fa          	endbr64 
   43cb9:	55                   	push   %rbp
   43cba:	48 89 e5             	mov    %rsp,%rbp
   43cbd:	48 83 ec 20          	sub    $0x20,%rsp
   43cc1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43cc5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43cc9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43cd0:	00 
   43cd1:	eb 0a                	jmp    43cdd <strnlen+0x28>
        ++n;
   43cd3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43cd8:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ce1:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43ce5:	74 0b                	je     43cf2 <strnlen+0x3d>
   43ce7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ceb:	0f b6 00             	movzbl (%rax),%eax
   43cee:	84 c0                	test   %al,%al
   43cf0:	75 e1                	jne    43cd3 <strnlen+0x1e>
    }
    return n;
   43cf2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43cf6:	c9                   	leave  
   43cf7:	c3                   	ret    

0000000000043cf8 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43cf8:	f3 0f 1e fa          	endbr64 
   43cfc:	55                   	push   %rbp
   43cfd:	48 89 e5             	mov    %rsp,%rbp
   43d00:	48 83 ec 20          	sub    $0x20,%rsp
   43d04:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d08:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43d0c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d10:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43d14:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43d18:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43d1c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43d20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d24:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43d28:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43d2c:	0f b6 12             	movzbl (%rdx),%edx
   43d2f:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43d31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d35:	48 83 e8 01          	sub    $0x1,%rax
   43d39:	0f b6 00             	movzbl (%rax),%eax
   43d3c:	84 c0                	test   %al,%al
   43d3e:	75 d4                	jne    43d14 <strcpy+0x1c>
    return dst;
   43d40:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43d44:	c9                   	leave  
   43d45:	c3                   	ret    

0000000000043d46 <strcmp>:

int strcmp(const char* a, const char* b) {
   43d46:	f3 0f 1e fa          	endbr64 
   43d4a:	55                   	push   %rbp
   43d4b:	48 89 e5             	mov    %rsp,%rbp
   43d4e:	48 83 ec 10          	sub    $0x10,%rsp
   43d52:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43d56:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43d5a:	eb 0a                	jmp    43d66 <strcmp+0x20>
        ++a, ++b;
   43d5c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43d61:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43d66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d6a:	0f b6 00             	movzbl (%rax),%eax
   43d6d:	84 c0                	test   %al,%al
   43d6f:	74 1d                	je     43d8e <strcmp+0x48>
   43d71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d75:	0f b6 00             	movzbl (%rax),%eax
   43d78:	84 c0                	test   %al,%al
   43d7a:	74 12                	je     43d8e <strcmp+0x48>
   43d7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d80:	0f b6 10             	movzbl (%rax),%edx
   43d83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d87:	0f b6 00             	movzbl (%rax),%eax
   43d8a:	38 c2                	cmp    %al,%dl
   43d8c:	74 ce                	je     43d5c <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43d8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d92:	0f b6 00             	movzbl (%rax),%eax
   43d95:	89 c2                	mov    %eax,%edx
   43d97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d9b:	0f b6 00             	movzbl (%rax),%eax
   43d9e:	38 c2                	cmp    %al,%dl
   43da0:	0f 97 c0             	seta   %al
   43da3:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43da6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43daa:	0f b6 00             	movzbl (%rax),%eax
   43dad:	89 c1                	mov    %eax,%ecx
   43daf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43db3:	0f b6 00             	movzbl (%rax),%eax
   43db6:	38 c1                	cmp    %al,%cl
   43db8:	0f 92 c0             	setb   %al
   43dbb:	0f b6 c8             	movzbl %al,%ecx
   43dbe:	89 d0                	mov    %edx,%eax
   43dc0:	29 c8                	sub    %ecx,%eax
}
   43dc2:	c9                   	leave  
   43dc3:	c3                   	ret    

0000000000043dc4 <strchr>:

char* strchr(const char* s, int c) {
   43dc4:	f3 0f 1e fa          	endbr64 
   43dc8:	55                   	push   %rbp
   43dc9:	48 89 e5             	mov    %rsp,%rbp
   43dcc:	48 83 ec 10          	sub    $0x10,%rsp
   43dd0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43dd4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43dd7:	eb 05                	jmp    43dde <strchr+0x1a>
        ++s;
   43dd9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43dde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43de2:	0f b6 00             	movzbl (%rax),%eax
   43de5:	84 c0                	test   %al,%al
   43de7:	74 0e                	je     43df7 <strchr+0x33>
   43de9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ded:	0f b6 00             	movzbl (%rax),%eax
   43df0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43df3:	38 d0                	cmp    %dl,%al
   43df5:	75 e2                	jne    43dd9 <strchr+0x15>
    }
    if (*s == (char) c) {
   43df7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dfb:	0f b6 00             	movzbl (%rax),%eax
   43dfe:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e01:	38 d0                	cmp    %dl,%al
   43e03:	75 06                	jne    43e0b <strchr+0x47>
        return (char*) s;
   43e05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e09:	eb 05                	jmp    43e10 <strchr+0x4c>
    } else {
        return NULL;
   43e0b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43e10:	c9                   	leave  
   43e11:	c3                   	ret    

0000000000043e12 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43e12:	f3 0f 1e fa          	endbr64 
   43e16:	55                   	push   %rbp
   43e17:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43e1a:	8b 05 e0 71 01 00    	mov    0x171e0(%rip),%eax        # 5b000 <rand_seed_set>
   43e20:	85 c0                	test   %eax,%eax
   43e22:	75 0a                	jne    43e2e <rand+0x1c>
        srand(819234718U);
   43e24:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43e29:	e8 24 00 00 00       	call   43e52 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43e2e:	8b 05 d0 71 01 00    	mov    0x171d0(%rip),%eax        # 5b004 <rand_seed>
   43e34:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43e3a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43e3f:	89 05 bf 71 01 00    	mov    %eax,0x171bf(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   43e45:	8b 05 b9 71 01 00    	mov    0x171b9(%rip),%eax        # 5b004 <rand_seed>
   43e4b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43e50:	5d                   	pop    %rbp
   43e51:	c3                   	ret    

0000000000043e52 <srand>:

void srand(unsigned seed) {
   43e52:	f3 0f 1e fa          	endbr64 
   43e56:	55                   	push   %rbp
   43e57:	48 89 e5             	mov    %rsp,%rbp
   43e5a:	48 83 ec 08          	sub    $0x8,%rsp
   43e5e:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43e61:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43e64:	89 05 9a 71 01 00    	mov    %eax,0x1719a(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   43e6a:	c7 05 8c 71 01 00 01 	movl   $0x1,0x1718c(%rip)        # 5b000 <rand_seed_set>
   43e71:	00 00 00 
}
   43e74:	90                   	nop
   43e75:	c9                   	leave  
   43e76:	c3                   	ret    

0000000000043e77 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43e77:	f3 0f 1e fa          	endbr64 
   43e7b:	55                   	push   %rbp
   43e7c:	48 89 e5             	mov    %rsp,%rbp
   43e7f:	48 83 ec 28          	sub    $0x28,%rsp
   43e83:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43e87:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43e8b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43e8e:	48 8d 05 eb 18 00 00 	lea    0x18eb(%rip),%rax        # 45780 <upper_digits.1>
   43e95:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   43e99:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43e9d:	79 0e                	jns    43ead <fill_numbuf+0x36>
        digits = lower_digits;
   43e9f:	48 8d 05 fa 18 00 00 	lea    0x18fa(%rip),%rax        # 457a0 <lower_digits.0>
   43ea6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   43eaa:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43ead:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43eb2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43eb6:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43eb9:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43ebc:	48 63 c8             	movslq %eax,%rcx
   43ebf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ec3:	ba 00 00 00 00       	mov    $0x0,%edx
   43ec8:	48 f7 f1             	div    %rcx
   43ecb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ecf:	48 01 d0             	add    %rdx,%rax
   43ed2:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43ed7:	0f b6 10             	movzbl (%rax),%edx
   43eda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ede:	88 10                	mov    %dl,(%rax)
        val /= base;
   43ee0:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43ee3:	48 63 f0             	movslq %eax,%rsi
   43ee6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43eea:	ba 00 00 00 00       	mov    $0x0,%edx
   43eef:	48 f7 f6             	div    %rsi
   43ef2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43ef6:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43efb:	75 bc                	jne    43eb9 <fill_numbuf+0x42>
    return numbuf_end;
   43efd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43f01:	c9                   	leave  
   43f02:	c3                   	ret    

0000000000043f03 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43f03:	f3 0f 1e fa          	endbr64 
   43f07:	55                   	push   %rbp
   43f08:	48 89 e5             	mov    %rsp,%rbp
   43f0b:	53                   	push   %rbx
   43f0c:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43f13:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43f1a:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43f20:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43f27:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43f2e:	e9 bd 09 00 00       	jmp    448f0 <printer_vprintf+0x9ed>
        if (*format != '%') {
   43f33:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f3a:	0f b6 00             	movzbl (%rax),%eax
   43f3d:	3c 25                	cmp    $0x25,%al
   43f3f:	74 31                	je     43f72 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   43f41:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f48:	4c 8b 00             	mov    (%rax),%r8
   43f4b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f52:	0f b6 00             	movzbl (%rax),%eax
   43f55:	0f b6 c8             	movzbl %al,%ecx
   43f58:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f5e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f65:	89 ce                	mov    %ecx,%esi
   43f67:	48 89 c7             	mov    %rax,%rdi
   43f6a:	41 ff d0             	call   *%r8
            continue;
   43f6d:	e9 76 09 00 00       	jmp    448e8 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   43f72:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43f79:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43f80:	01 
   43f81:	eb 4d                	jmp    43fd0 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   43f83:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f8a:	0f b6 00             	movzbl (%rax),%eax
   43f8d:	0f be c0             	movsbl %al,%eax
   43f90:	89 c6                	mov    %eax,%esi
   43f92:	48 8d 05 e7 16 00 00 	lea    0x16e7(%rip),%rax        # 45680 <flag_chars>
   43f99:	48 89 c7             	mov    %rax,%rdi
   43f9c:	e8 23 fe ff ff       	call   43dc4 <strchr>
   43fa1:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43fa5:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43faa:	74 34                	je     43fe0 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   43fac:	48 8d 15 cd 16 00 00 	lea    0x16cd(%rip),%rdx        # 45680 <flag_chars>
   43fb3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43fb7:	48 29 d0             	sub    %rdx,%rax
   43fba:	ba 01 00 00 00       	mov    $0x1,%edx
   43fbf:	89 c1                	mov    %eax,%ecx
   43fc1:	d3 e2                	shl    %cl,%edx
   43fc3:	89 d0                	mov    %edx,%eax
   43fc5:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43fc8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fcf:	01 
   43fd0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fd7:	0f b6 00             	movzbl (%rax),%eax
   43fda:	84 c0                	test   %al,%al
   43fdc:	75 a5                	jne    43f83 <printer_vprintf+0x80>
   43fde:	eb 01                	jmp    43fe1 <printer_vprintf+0xde>
            } else {
                break;
   43fe0:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43fe1:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43fe8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fef:	0f b6 00             	movzbl (%rax),%eax
   43ff2:	3c 30                	cmp    $0x30,%al
   43ff4:	7e 67                	jle    4405d <printer_vprintf+0x15a>
   43ff6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ffd:	0f b6 00             	movzbl (%rax),%eax
   44000:	3c 39                	cmp    $0x39,%al
   44002:	7f 59                	jg     4405d <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44004:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   4400b:	eb 2e                	jmp    4403b <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   4400d:	8b 55 e8             	mov    -0x18(%rbp),%edx
   44010:	89 d0                	mov    %edx,%eax
   44012:	c1 e0 02             	shl    $0x2,%eax
   44015:	01 d0                	add    %edx,%eax
   44017:	01 c0                	add    %eax,%eax
   44019:	89 c1                	mov    %eax,%ecx
   4401b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44022:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44026:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4402d:	0f b6 00             	movzbl (%rax),%eax
   44030:	0f be c0             	movsbl %al,%eax
   44033:	01 c8                	add    %ecx,%eax
   44035:	83 e8 30             	sub    $0x30,%eax
   44038:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4403b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44042:	0f b6 00             	movzbl (%rax),%eax
   44045:	3c 2f                	cmp    $0x2f,%al
   44047:	0f 8e 85 00 00 00    	jle    440d2 <printer_vprintf+0x1cf>
   4404d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44054:	0f b6 00             	movzbl (%rax),%eax
   44057:	3c 39                	cmp    $0x39,%al
   44059:	7e b2                	jle    4400d <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   4405b:	eb 75                	jmp    440d2 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   4405d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44064:	0f b6 00             	movzbl (%rax),%eax
   44067:	3c 2a                	cmp    $0x2a,%al
   44069:	75 68                	jne    440d3 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   4406b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44072:	8b 00                	mov    (%rax),%eax
   44074:	83 f8 2f             	cmp    $0x2f,%eax
   44077:	77 30                	ja     440a9 <printer_vprintf+0x1a6>
   44079:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44080:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44084:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4408b:	8b 00                	mov    (%rax),%eax
   4408d:	89 c0                	mov    %eax,%eax
   4408f:	48 01 d0             	add    %rdx,%rax
   44092:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44099:	8b 12                	mov    (%rdx),%edx
   4409b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4409e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440a5:	89 0a                	mov    %ecx,(%rdx)
   440a7:	eb 1a                	jmp    440c3 <printer_vprintf+0x1c0>
   440a9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440b0:	48 8b 40 08          	mov    0x8(%rax),%rax
   440b4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   440b8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440bf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440c3:	8b 00                	mov    (%rax),%eax
   440c5:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   440c8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   440cf:	01 
   440d0:	eb 01                	jmp    440d3 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   440d2:	90                   	nop
        }

        // process precision
        int precision = -1;
   440d3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   440da:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440e1:	0f b6 00             	movzbl (%rax),%eax
   440e4:	3c 2e                	cmp    $0x2e,%al
   440e6:	0f 85 00 01 00 00    	jne    441ec <printer_vprintf+0x2e9>
            ++format;
   440ec:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   440f3:	01 
            if (*format >= '0' && *format <= '9') {
   440f4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440fb:	0f b6 00             	movzbl (%rax),%eax
   440fe:	3c 2f                	cmp    $0x2f,%al
   44100:	7e 67                	jle    44169 <printer_vprintf+0x266>
   44102:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44109:	0f b6 00             	movzbl (%rax),%eax
   4410c:	3c 39                	cmp    $0x39,%al
   4410e:	7f 59                	jg     44169 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44110:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   44117:	eb 2e                	jmp    44147 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   44119:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4411c:	89 d0                	mov    %edx,%eax
   4411e:	c1 e0 02             	shl    $0x2,%eax
   44121:	01 d0                	add    %edx,%eax
   44123:	01 c0                	add    %eax,%eax
   44125:	89 c1                	mov    %eax,%ecx
   44127:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4412e:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44132:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44139:	0f b6 00             	movzbl (%rax),%eax
   4413c:	0f be c0             	movsbl %al,%eax
   4413f:	01 c8                	add    %ecx,%eax
   44141:	83 e8 30             	sub    $0x30,%eax
   44144:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44147:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4414e:	0f b6 00             	movzbl (%rax),%eax
   44151:	3c 2f                	cmp    $0x2f,%al
   44153:	0f 8e 85 00 00 00    	jle    441de <printer_vprintf+0x2db>
   44159:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44160:	0f b6 00             	movzbl (%rax),%eax
   44163:	3c 39                	cmp    $0x39,%al
   44165:	7e b2                	jle    44119 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   44167:	eb 75                	jmp    441de <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   44169:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44170:	0f b6 00             	movzbl (%rax),%eax
   44173:	3c 2a                	cmp    $0x2a,%al
   44175:	75 68                	jne    441df <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   44177:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4417e:	8b 00                	mov    (%rax),%eax
   44180:	83 f8 2f             	cmp    $0x2f,%eax
   44183:	77 30                	ja     441b5 <printer_vprintf+0x2b2>
   44185:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4418c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44190:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44197:	8b 00                	mov    (%rax),%eax
   44199:	89 c0                	mov    %eax,%eax
   4419b:	48 01 d0             	add    %rdx,%rax
   4419e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441a5:	8b 12                	mov    (%rdx),%edx
   441a7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   441aa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441b1:	89 0a                	mov    %ecx,(%rdx)
   441b3:	eb 1a                	jmp    441cf <printer_vprintf+0x2cc>
   441b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441bc:	48 8b 40 08          	mov    0x8(%rax),%rax
   441c0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441c4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441cb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441cf:	8b 00                	mov    (%rax),%eax
   441d1:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   441d4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   441db:	01 
   441dc:	eb 01                	jmp    441df <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   441de:	90                   	nop
            }
            if (precision < 0) {
   441df:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   441e3:	79 07                	jns    441ec <printer_vprintf+0x2e9>
                precision = 0;
   441e5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   441ec:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   441f3:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   441fa:	00 
        int length = 0;
   441fb:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   44202:	48 8d 05 7d 14 00 00 	lea    0x147d(%rip),%rax        # 45686 <flag_chars+0x6>
   44209:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   4420d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44214:	0f b6 00             	movzbl (%rax),%eax
   44217:	0f be c0             	movsbl %al,%eax
   4421a:	83 e8 43             	sub    $0x43,%eax
   4421d:	83 f8 37             	cmp    $0x37,%eax
   44220:	0f 87 b6 03 00 00    	ja     445dc <printer_vprintf+0x6d9>
   44226:	89 c0                	mov    %eax,%eax
   44228:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   4422f:	00 
   44230:	48 8d 05 5d 14 00 00 	lea    0x145d(%rip),%rax        # 45694 <flag_chars+0x14>
   44237:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4423a:	48 98                	cltq   
   4423c:	48 8d 15 51 14 00 00 	lea    0x1451(%rip),%rdx        # 45694 <flag_chars+0x14>
   44243:	48 01 d0             	add    %rdx,%rax
   44246:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   44249:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   44250:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44257:	01 
            goto again;
   44258:	eb b3                	jmp    4420d <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   4425a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4425e:	74 5d                	je     442bd <printer_vprintf+0x3ba>
   44260:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44267:	8b 00                	mov    (%rax),%eax
   44269:	83 f8 2f             	cmp    $0x2f,%eax
   4426c:	77 30                	ja     4429e <printer_vprintf+0x39b>
   4426e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44275:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44279:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44280:	8b 00                	mov    (%rax),%eax
   44282:	89 c0                	mov    %eax,%eax
   44284:	48 01 d0             	add    %rdx,%rax
   44287:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4428e:	8b 12                	mov    (%rdx),%edx
   44290:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44293:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4429a:	89 0a                	mov    %ecx,(%rdx)
   4429c:	eb 1a                	jmp    442b8 <printer_vprintf+0x3b5>
   4429e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442a5:	48 8b 40 08          	mov    0x8(%rax),%rax
   442a9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442ad:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442b4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442b8:	48 8b 00             	mov    (%rax),%rax
   442bb:	eb 5c                	jmp    44319 <printer_vprintf+0x416>
   442bd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442c4:	8b 00                	mov    (%rax),%eax
   442c6:	83 f8 2f             	cmp    $0x2f,%eax
   442c9:	77 30                	ja     442fb <printer_vprintf+0x3f8>
   442cb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442d2:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442d6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442dd:	8b 00                	mov    (%rax),%eax
   442df:	89 c0                	mov    %eax,%eax
   442e1:	48 01 d0             	add    %rdx,%rax
   442e4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442eb:	8b 12                	mov    (%rdx),%edx
   442ed:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442f0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442f7:	89 0a                	mov    %ecx,(%rdx)
   442f9:	eb 1a                	jmp    44315 <printer_vprintf+0x412>
   442fb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44302:	48 8b 40 08          	mov    0x8(%rax),%rax
   44306:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4430a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44311:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44315:	8b 00                	mov    (%rax),%eax
   44317:	48 98                	cltq   
   44319:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4431d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44321:	48 c1 f8 38          	sar    $0x38,%rax
   44325:	25 80 00 00 00       	and    $0x80,%eax
   4432a:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   4432d:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   44331:	74 09                	je     4433c <printer_vprintf+0x439>
   44333:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44337:	48 f7 d8             	neg    %rax
   4433a:	eb 04                	jmp    44340 <printer_vprintf+0x43d>
   4433c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44340:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   44344:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   44347:	83 c8 60             	or     $0x60,%eax
   4434a:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   4434d:	e9 cf 02 00 00       	jmp    44621 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   44352:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44356:	74 5d                	je     443b5 <printer_vprintf+0x4b2>
   44358:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4435f:	8b 00                	mov    (%rax),%eax
   44361:	83 f8 2f             	cmp    $0x2f,%eax
   44364:	77 30                	ja     44396 <printer_vprintf+0x493>
   44366:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4436d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44371:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44378:	8b 00                	mov    (%rax),%eax
   4437a:	89 c0                	mov    %eax,%eax
   4437c:	48 01 d0             	add    %rdx,%rax
   4437f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44386:	8b 12                	mov    (%rdx),%edx
   44388:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4438b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44392:	89 0a                	mov    %ecx,(%rdx)
   44394:	eb 1a                	jmp    443b0 <printer_vprintf+0x4ad>
   44396:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4439d:	48 8b 40 08          	mov    0x8(%rax),%rax
   443a1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443a5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443ac:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443b0:	48 8b 00             	mov    (%rax),%rax
   443b3:	eb 5c                	jmp    44411 <printer_vprintf+0x50e>
   443b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443bc:	8b 00                	mov    (%rax),%eax
   443be:	83 f8 2f             	cmp    $0x2f,%eax
   443c1:	77 30                	ja     443f3 <printer_vprintf+0x4f0>
   443c3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ca:	48 8b 50 10          	mov    0x10(%rax),%rdx
   443ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443d5:	8b 00                	mov    (%rax),%eax
   443d7:	89 c0                	mov    %eax,%eax
   443d9:	48 01 d0             	add    %rdx,%rax
   443dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443e3:	8b 12                	mov    (%rdx),%edx
   443e5:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443e8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443ef:	89 0a                	mov    %ecx,(%rdx)
   443f1:	eb 1a                	jmp    4440d <printer_vprintf+0x50a>
   443f3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443fa:	48 8b 40 08          	mov    0x8(%rax),%rax
   443fe:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44402:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44409:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4440d:	8b 00                	mov    (%rax),%eax
   4440f:	89 c0                	mov    %eax,%eax
   44411:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   44415:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44419:	e9 03 02 00 00       	jmp    44621 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   4441e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   44425:	e9 28 ff ff ff       	jmp    44352 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   4442a:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   44431:	e9 1c ff ff ff       	jmp    44352 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44436:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4443d:	8b 00                	mov    (%rax),%eax
   4443f:	83 f8 2f             	cmp    $0x2f,%eax
   44442:	77 30                	ja     44474 <printer_vprintf+0x571>
   44444:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4444b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4444f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44456:	8b 00                	mov    (%rax),%eax
   44458:	89 c0                	mov    %eax,%eax
   4445a:	48 01 d0             	add    %rdx,%rax
   4445d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44464:	8b 12                	mov    (%rdx),%edx
   44466:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44469:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44470:	89 0a                	mov    %ecx,(%rdx)
   44472:	eb 1a                	jmp    4448e <printer_vprintf+0x58b>
   44474:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4447b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4447f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44483:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4448a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4448e:	48 8b 00             	mov    (%rax),%rax
   44491:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   44495:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   4449c:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   444a3:	e9 79 01 00 00       	jmp    44621 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   444a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444af:	8b 00                	mov    (%rax),%eax
   444b1:	83 f8 2f             	cmp    $0x2f,%eax
   444b4:	77 30                	ja     444e6 <printer_vprintf+0x5e3>
   444b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444bd:	48 8b 50 10          	mov    0x10(%rax),%rdx
   444c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444c8:	8b 00                	mov    (%rax),%eax
   444ca:	89 c0                	mov    %eax,%eax
   444cc:	48 01 d0             	add    %rdx,%rax
   444cf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444d6:	8b 12                	mov    (%rdx),%edx
   444d8:	8d 4a 08             	lea    0x8(%rdx),%ecx
   444db:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444e2:	89 0a                	mov    %ecx,(%rdx)
   444e4:	eb 1a                	jmp    44500 <printer_vprintf+0x5fd>
   444e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444ed:	48 8b 40 08          	mov    0x8(%rax),%rax
   444f1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   444f5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444fc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44500:	48 8b 00             	mov    (%rax),%rax
   44503:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   44507:	e9 15 01 00 00       	jmp    44621 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   4450c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44513:	8b 00                	mov    (%rax),%eax
   44515:	83 f8 2f             	cmp    $0x2f,%eax
   44518:	77 30                	ja     4454a <printer_vprintf+0x647>
   4451a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44521:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44525:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4452c:	8b 00                	mov    (%rax),%eax
   4452e:	89 c0                	mov    %eax,%eax
   44530:	48 01 d0             	add    %rdx,%rax
   44533:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4453a:	8b 12                	mov    (%rdx),%edx
   4453c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4453f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44546:	89 0a                	mov    %ecx,(%rdx)
   44548:	eb 1a                	jmp    44564 <printer_vprintf+0x661>
   4454a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44551:	48 8b 40 08          	mov    0x8(%rax),%rax
   44555:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44559:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44560:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44564:	8b 00                	mov    (%rax),%eax
   44566:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   4456c:	e9 77 03 00 00       	jmp    448e8 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   44571:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44575:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44579:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44580:	8b 00                	mov    (%rax),%eax
   44582:	83 f8 2f             	cmp    $0x2f,%eax
   44585:	77 30                	ja     445b7 <printer_vprintf+0x6b4>
   44587:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4458e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44592:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44599:	8b 00                	mov    (%rax),%eax
   4459b:	89 c0                	mov    %eax,%eax
   4459d:	48 01 d0             	add    %rdx,%rax
   445a0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445a7:	8b 12                	mov    (%rdx),%edx
   445a9:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445ac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445b3:	89 0a                	mov    %ecx,(%rdx)
   445b5:	eb 1a                	jmp    445d1 <printer_vprintf+0x6ce>
   445b7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445be:	48 8b 40 08          	mov    0x8(%rax),%rax
   445c2:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445c6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445cd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445d1:	8b 00                	mov    (%rax),%eax
   445d3:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   445d6:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   445da:	eb 45                	jmp    44621 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   445dc:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   445e0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   445e4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   445eb:	0f b6 00             	movzbl (%rax),%eax
   445ee:	84 c0                	test   %al,%al
   445f0:	74 0c                	je     445fe <printer_vprintf+0x6fb>
   445f2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   445f9:	0f b6 00             	movzbl (%rax),%eax
   445fc:	eb 05                	jmp    44603 <printer_vprintf+0x700>
   445fe:	b8 25 00 00 00       	mov    $0x25,%eax
   44603:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44606:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   4460a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44611:	0f b6 00             	movzbl (%rax),%eax
   44614:	84 c0                	test   %al,%al
   44616:	75 08                	jne    44620 <printer_vprintf+0x71d>
                format--;
   44618:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   4461f:	01 
            }
            break;
   44620:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44621:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44624:	83 e0 20             	and    $0x20,%eax
   44627:	85 c0                	test   %eax,%eax
   44629:	74 1e                	je     44649 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   4462b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4462f:	48 83 c0 18          	add    $0x18,%rax
   44633:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44636:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4463a:	48 89 ce             	mov    %rcx,%rsi
   4463d:	48 89 c7             	mov    %rax,%rdi
   44640:	e8 32 f8 ff ff       	call   43e77 <fill_numbuf>
   44645:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44649:	48 8d 05 36 10 00 00 	lea    0x1036(%rip),%rax        # 45686 <flag_chars+0x6>
   44650:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44654:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44657:	83 e0 20             	and    $0x20,%eax
   4465a:	85 c0                	test   %eax,%eax
   4465c:	74 51                	je     446af <printer_vprintf+0x7ac>
   4465e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44661:	83 e0 40             	and    $0x40,%eax
   44664:	85 c0                	test   %eax,%eax
   44666:	74 47                	je     446af <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   44668:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4466b:	25 80 00 00 00       	and    $0x80,%eax
   44670:	85 c0                	test   %eax,%eax
   44672:	74 0d                	je     44681 <printer_vprintf+0x77e>
                prefix = "-";
   44674:	48 8d 05 0c 10 00 00 	lea    0x100c(%rip),%rax        # 45687 <flag_chars+0x7>
   4467b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   4467f:	eb 7d                	jmp    446fe <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44681:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44684:	83 e0 10             	and    $0x10,%eax
   44687:	85 c0                	test   %eax,%eax
   44689:	74 0d                	je     44698 <printer_vprintf+0x795>
                prefix = "+";
   4468b:	48 8d 05 f7 0f 00 00 	lea    0xff7(%rip),%rax        # 45689 <flag_chars+0x9>
   44692:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44696:	eb 66                	jmp    446fe <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44698:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4469b:	83 e0 08             	and    $0x8,%eax
   4469e:	85 c0                	test   %eax,%eax
   446a0:	74 5c                	je     446fe <printer_vprintf+0x7fb>
                prefix = " ";
   446a2:	48 8d 05 e2 0f 00 00 	lea    0xfe2(%rip),%rax        # 4568b <flag_chars+0xb>
   446a9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   446ad:	eb 4f                	jmp    446fe <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   446af:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446b2:	83 e0 20             	and    $0x20,%eax
   446b5:	85 c0                	test   %eax,%eax
   446b7:	74 46                	je     446ff <printer_vprintf+0x7fc>
   446b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446bc:	83 e0 01             	and    $0x1,%eax
   446bf:	85 c0                	test   %eax,%eax
   446c1:	74 3c                	je     446ff <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   446c3:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   446c7:	74 06                	je     446cf <printer_vprintf+0x7cc>
   446c9:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   446cd:	75 30                	jne    446ff <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   446cf:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   446d4:	75 0c                	jne    446e2 <printer_vprintf+0x7df>
   446d6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446d9:	25 00 01 00 00       	and    $0x100,%eax
   446de:	85 c0                	test   %eax,%eax
   446e0:	74 1d                	je     446ff <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   446e2:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   446e6:	75 09                	jne    446f1 <printer_vprintf+0x7ee>
   446e8:	48 8d 05 9e 0f 00 00 	lea    0xf9e(%rip),%rax        # 4568d <flag_chars+0xd>
   446ef:	eb 07                	jmp    446f8 <printer_vprintf+0x7f5>
   446f1:	48 8d 05 98 0f 00 00 	lea    0xf98(%rip),%rax        # 45690 <flag_chars+0x10>
   446f8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   446fc:	eb 01                	jmp    446ff <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   446fe:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   446ff:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44703:	78 24                	js     44729 <printer_vprintf+0x826>
   44705:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44708:	83 e0 20             	and    $0x20,%eax
   4470b:	85 c0                	test   %eax,%eax
   4470d:	75 1a                	jne    44729 <printer_vprintf+0x826>
            len = strnlen(data, precision);
   4470f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44712:	48 63 d0             	movslq %eax,%rdx
   44715:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44719:	48 89 d6             	mov    %rdx,%rsi
   4471c:	48 89 c7             	mov    %rax,%rdi
   4471f:	e8 91 f5 ff ff       	call   43cb5 <strnlen>
   44724:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44727:	eb 0f                	jmp    44738 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   44729:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4472d:	48 89 c7             	mov    %rax,%rdi
   44730:	e8 4b f5 ff ff       	call   43c80 <strlen>
   44735:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44738:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4473b:	83 e0 20             	and    $0x20,%eax
   4473e:	85 c0                	test   %eax,%eax
   44740:	74 20                	je     44762 <printer_vprintf+0x85f>
   44742:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44746:	78 1a                	js     44762 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   44748:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4474b:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   4474e:	7e 08                	jle    44758 <printer_vprintf+0x855>
   44750:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44753:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44756:	eb 05                	jmp    4475d <printer_vprintf+0x85a>
   44758:	b8 00 00 00 00       	mov    $0x0,%eax
   4475d:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44760:	eb 5c                	jmp    447be <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44762:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44765:	83 e0 20             	and    $0x20,%eax
   44768:	85 c0                	test   %eax,%eax
   4476a:	74 4b                	je     447b7 <printer_vprintf+0x8b4>
   4476c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4476f:	83 e0 02             	and    $0x2,%eax
   44772:	85 c0                	test   %eax,%eax
   44774:	74 41                	je     447b7 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44776:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44779:	83 e0 04             	and    $0x4,%eax
   4477c:	85 c0                	test   %eax,%eax
   4477e:	75 37                	jne    447b7 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   44780:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44784:	48 89 c7             	mov    %rax,%rdi
   44787:	e8 f4 f4 ff ff       	call   43c80 <strlen>
   4478c:	89 c2                	mov    %eax,%edx
   4478e:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44791:	01 d0                	add    %edx,%eax
   44793:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44796:	7e 1f                	jle    447b7 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   44798:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4479b:	2b 45 bc             	sub    -0x44(%rbp),%eax
   4479e:	89 c3                	mov    %eax,%ebx
   447a0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447a4:	48 89 c7             	mov    %rax,%rdi
   447a7:	e8 d4 f4 ff ff       	call   43c80 <strlen>
   447ac:	89 c2                	mov    %eax,%edx
   447ae:	89 d8                	mov    %ebx,%eax
   447b0:	29 d0                	sub    %edx,%eax
   447b2:	89 45 b8             	mov    %eax,-0x48(%rbp)
   447b5:	eb 07                	jmp    447be <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   447b7:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   447be:	8b 55 bc             	mov    -0x44(%rbp),%edx
   447c1:	8b 45 b8             	mov    -0x48(%rbp),%eax
   447c4:	01 d0                	add    %edx,%eax
   447c6:	48 63 d8             	movslq %eax,%rbx
   447c9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447cd:	48 89 c7             	mov    %rax,%rdi
   447d0:	e8 ab f4 ff ff       	call   43c80 <strlen>
   447d5:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   447d9:	8b 45 e8             	mov    -0x18(%rbp),%eax
   447dc:	29 d0                	sub    %edx,%eax
   447de:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   447e1:	eb 25                	jmp    44808 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   447e3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447ea:	48 8b 08             	mov    (%rax),%rcx
   447ed:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   447f3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447fa:	be 20 00 00 00       	mov    $0x20,%esi
   447ff:	48 89 c7             	mov    %rax,%rdi
   44802:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44804:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44808:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4480b:	83 e0 04             	and    $0x4,%eax
   4480e:	85 c0                	test   %eax,%eax
   44810:	75 36                	jne    44848 <printer_vprintf+0x945>
   44812:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44816:	7f cb                	jg     447e3 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   44818:	eb 2e                	jmp    44848 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   4481a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44821:	4c 8b 00             	mov    (%rax),%r8
   44824:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44828:	0f b6 00             	movzbl (%rax),%eax
   4482b:	0f b6 c8             	movzbl %al,%ecx
   4482e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44834:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4483b:	89 ce                	mov    %ecx,%esi
   4483d:	48 89 c7             	mov    %rax,%rdi
   44840:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44843:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44848:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4484c:	0f b6 00             	movzbl (%rax),%eax
   4484f:	84 c0                	test   %al,%al
   44851:	75 c7                	jne    4481a <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   44853:	eb 25                	jmp    4487a <printer_vprintf+0x977>
            p->putc(p, '0', color);
   44855:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4485c:	48 8b 08             	mov    (%rax),%rcx
   4485f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44865:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4486c:	be 30 00 00 00       	mov    $0x30,%esi
   44871:	48 89 c7             	mov    %rax,%rdi
   44874:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44876:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   4487a:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   4487e:	7f d5                	jg     44855 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   44880:	eb 32                	jmp    448b4 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   44882:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44889:	4c 8b 00             	mov    (%rax),%r8
   4488c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44890:	0f b6 00             	movzbl (%rax),%eax
   44893:	0f b6 c8             	movzbl %al,%ecx
   44896:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4489c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448a3:	89 ce                	mov    %ecx,%esi
   448a5:	48 89 c7             	mov    %rax,%rdi
   448a8:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   448ab:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   448b0:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   448b4:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   448b8:	7f c8                	jg     44882 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   448ba:	eb 25                	jmp    448e1 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   448bc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448c3:	48 8b 08             	mov    (%rax),%rcx
   448c6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448cc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448d3:	be 20 00 00 00       	mov    $0x20,%esi
   448d8:	48 89 c7             	mov    %rax,%rdi
   448db:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   448dd:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   448e1:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   448e5:	7f d5                	jg     448bc <printer_vprintf+0x9b9>
        }
    done: ;
   448e7:	90                   	nop
    for (; *format; ++format) {
   448e8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   448ef:	01 
   448f0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   448f7:	0f b6 00             	movzbl (%rax),%eax
   448fa:	84 c0                	test   %al,%al
   448fc:	0f 85 31 f6 ff ff    	jne    43f33 <printer_vprintf+0x30>
    }
}
   44902:	90                   	nop
   44903:	90                   	nop
   44904:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44908:	c9                   	leave  
   44909:	c3                   	ret    

000000000004490a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4490a:	f3 0f 1e fa          	endbr64 
   4490e:	55                   	push   %rbp
   4490f:	48 89 e5             	mov    %rsp,%rbp
   44912:	48 83 ec 20          	sub    $0x20,%rsp
   44916:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4491a:	89 f0                	mov    %esi,%eax
   4491c:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4491f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44922:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44926:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4492a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4492e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44932:	48 8d 15 67 46 07 00 	lea    0x74667(%rip),%rdx        # b8fa0 <console+0xfa0>
   44939:	48 39 d0             	cmp    %rdx,%rax
   4493c:	72 0f                	jb     4494d <console_putc+0x43>
        cp->cursor = console;
   4493e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44942:	48 8d 15 b7 36 07 00 	lea    0x736b7(%rip),%rdx        # b8000 <console>
   44949:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   4494d:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44951:	0f 85 82 00 00 00    	jne    449d9 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   44957:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4495b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4495f:	48 8d 15 9a 36 07 00 	lea    0x7369a(%rip),%rdx        # b8000 <console>
   44966:	48 29 d0             	sub    %rdx,%rax
   44969:	48 d1 f8             	sar    %rax
   4496c:	48 89 c1             	mov    %rax,%rcx
   4496f:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44976:	66 66 66 
   44979:	48 89 c8             	mov    %rcx,%rax
   4497c:	48 f7 ea             	imul   %rdx
   4497f:	48 89 d0             	mov    %rdx,%rax
   44982:	48 c1 f8 05          	sar    $0x5,%rax
   44986:	48 89 ce             	mov    %rcx,%rsi
   44989:	48 c1 fe 3f          	sar    $0x3f,%rsi
   4498d:	48 29 f0             	sub    %rsi,%rax
   44990:	48 89 c2             	mov    %rax,%rdx
   44993:	48 89 d0             	mov    %rdx,%rax
   44996:	48 c1 e0 02          	shl    $0x2,%rax
   4499a:	48 01 d0             	add    %rdx,%rax
   4499d:	48 c1 e0 04          	shl    $0x4,%rax
   449a1:	48 29 c1             	sub    %rax,%rcx
   449a4:	48 89 ca             	mov    %rcx,%rdx
   449a7:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   449aa:	eb 25                	jmp    449d1 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   449ac:	8b 45 e0             	mov    -0x20(%rbp),%eax
   449af:	83 c8 20             	or     $0x20,%eax
   449b2:	89 c6                	mov    %eax,%esi
   449b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449b8:	48 8b 40 08          	mov    0x8(%rax),%rax
   449bc:	48 8d 48 02          	lea    0x2(%rax),%rcx
   449c0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   449c4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449c8:	89 f2                	mov    %esi,%edx
   449ca:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   449cd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   449d1:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   449d5:	75 d5                	jne    449ac <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   449d7:	eb 24                	jmp    449fd <console_putc+0xf3>
        *cp->cursor++ = c | color;
   449d9:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   449dd:	8b 45 e0             	mov    -0x20(%rbp),%eax
   449e0:	89 d6                	mov    %edx,%esi
   449e2:	09 c6                	or     %eax,%esi
   449e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449e8:	48 8b 40 08          	mov    0x8(%rax),%rax
   449ec:	48 8d 48 02          	lea    0x2(%rax),%rcx
   449f0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   449f4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449f8:	89 f2                	mov    %esi,%edx
   449fa:	66 89 10             	mov    %dx,(%rax)
}
   449fd:	90                   	nop
   449fe:	c9                   	leave  
   449ff:	c3                   	ret    

0000000000044a00 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44a00:	f3 0f 1e fa          	endbr64 
   44a04:	55                   	push   %rbp
   44a05:	48 89 e5             	mov    %rsp,%rbp
   44a08:	48 83 ec 30          	sub    $0x30,%rsp
   44a0c:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44a0f:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44a12:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44a16:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44a1a:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 4490a <console_putc>
   44a21:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44a25:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44a29:	78 09                	js     44a34 <console_vprintf+0x34>
   44a2b:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44a32:	7e 07                	jle    44a3b <console_vprintf+0x3b>
        cpos = 0;
   44a34:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44a3b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44a3e:	48 98                	cltq   
   44a40:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44a44:	48 8d 05 b5 35 07 00 	lea    0x735b5(%rip),%rax        # b8000 <console>
   44a4b:	48 01 d0             	add    %rdx,%rax
   44a4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44a52:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44a56:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44a5a:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44a5d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44a61:	48 89 c7             	mov    %rax,%rdi
   44a64:	e8 9a f4 ff ff       	call   43f03 <printer_vprintf>
    return cp.cursor - console;
   44a69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44a6d:	48 8d 15 8c 35 07 00 	lea    0x7358c(%rip),%rdx        # b8000 <console>
   44a74:	48 29 d0             	sub    %rdx,%rax
   44a77:	48 d1 f8             	sar    %rax
}
   44a7a:	c9                   	leave  
   44a7b:	c3                   	ret    

0000000000044a7c <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44a7c:	f3 0f 1e fa          	endbr64 
   44a80:	55                   	push   %rbp
   44a81:	48 89 e5             	mov    %rsp,%rbp
   44a84:	48 83 ec 60          	sub    $0x60,%rsp
   44a88:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44a8b:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44a8e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44a92:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44a96:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44a9a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44a9e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44aa5:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44aa9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44aad:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44ab1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44ab5:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44ab9:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44abd:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44ac0:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44ac3:	89 c7                	mov    %eax,%edi
   44ac5:	e8 36 ff ff ff       	call   44a00 <console_vprintf>
   44aca:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44acd:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44ad0:	c9                   	leave  
   44ad1:	c3                   	ret    

0000000000044ad2 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44ad2:	f3 0f 1e fa          	endbr64 
   44ad6:	55                   	push   %rbp
   44ad7:	48 89 e5             	mov    %rsp,%rbp
   44ada:	48 83 ec 20          	sub    $0x20,%rsp
   44ade:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44ae2:	89 f0                	mov    %esi,%eax
   44ae4:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44ae7:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44aea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44aee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44af2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44af6:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44afa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44afe:	48 8b 40 10          	mov    0x10(%rax),%rax
   44b02:	48 39 c2             	cmp    %rax,%rdx
   44b05:	73 1a                	jae    44b21 <string_putc+0x4f>
        *sp->s++ = c;
   44b07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b0b:	48 8b 40 08          	mov    0x8(%rax),%rax
   44b0f:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44b13:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44b17:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44b1b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44b1f:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44b21:	90                   	nop
   44b22:	c9                   	leave  
   44b23:	c3                   	ret    

0000000000044b24 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44b24:	f3 0f 1e fa          	endbr64 
   44b28:	55                   	push   %rbp
   44b29:	48 89 e5             	mov    %rsp,%rbp
   44b2c:	48 83 ec 40          	sub    $0x40,%rsp
   44b30:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44b34:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44b38:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44b3c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44b40:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 44ad2 <string_putc>
   44b47:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   44b4b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b4f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44b53:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44b58:	74 33                	je     44b8d <vsnprintf+0x69>
        sp.end = s + size - 1;
   44b5a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44b5e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44b62:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b66:	48 01 d0             	add    %rdx,%rax
   44b69:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44b6d:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44b71:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44b75:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44b79:	be 00 00 00 00       	mov    $0x0,%esi
   44b7e:	48 89 c7             	mov    %rax,%rdi
   44b81:	e8 7d f3 ff ff       	call   43f03 <printer_vprintf>
        *sp.s = 0;
   44b86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b8a:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44b8d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b91:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44b95:	c9                   	leave  
   44b96:	c3                   	ret    

0000000000044b97 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44b97:	f3 0f 1e fa          	endbr64 
   44b9b:	55                   	push   %rbp
   44b9c:	48 89 e5             	mov    %rsp,%rbp
   44b9f:	48 83 ec 70          	sub    $0x70,%rsp
   44ba3:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44ba7:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44bab:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44baf:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44bb3:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44bb7:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44bbb:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44bc2:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44bc6:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44bca:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44bce:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44bd2:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44bd6:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44bda:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44bde:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44be2:	48 89 c7             	mov    %rax,%rdi
   44be5:	e8 3a ff ff ff       	call   44b24 <vsnprintf>
   44bea:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44bed:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44bf0:	c9                   	leave  
   44bf1:	c3                   	ret    

0000000000044bf2 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44bf2:	f3 0f 1e fa          	endbr64 
   44bf6:	55                   	push   %rbp
   44bf7:	48 89 e5             	mov    %rsp,%rbp
   44bfa:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44bfe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44c05:	eb 1a                	jmp    44c21 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   44c07:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44c0a:	48 98                	cltq   
   44c0c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44c10:	48 8d 05 e9 33 07 00 	lea    0x733e9(%rip),%rax        # b8000 <console>
   44c17:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44c1d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44c21:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44c28:	7e dd                	jle    44c07 <console_clear+0x15>
    }
    cursorpos = 0;
   44c2a:	c7 05 c8 43 07 00 00 	movl   $0x0,0x743c8(%rip)        # b8ffc <cursorpos>
   44c31:	00 00 00 
}
   44c34:	90                   	nop
   44c35:	c9                   	leave  
   44c36:	c3                   	ret    
