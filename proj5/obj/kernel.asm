
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
   400be:	e8 d1 08 00 00       	call   40994 <exception>

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
   40177:	e8 bc 1b 00 00       	call   41d38 <hardware_init>
    pageinfo_init();
   4017c:	e8 bc 10 00 00       	call   4123d <pageinfo_init>
    console_clear();
   40181:	e8 0e 49 00 00       	call   44a94 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 10 21 00 00       	call   422a0 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 7f 1e 01 00 	lea    0x11e7f(%rip),%rax        # 52020 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 36 39 00 00       	call   43adf <memset>
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
   40210:	48 8d 15 c9 48 00 00 	lea    0x48c9(%rip),%rdx        # 44ae0 <console_clear+0x4c>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 c6 39 00 00       	call   43be8 <strcmp>
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
   40245:	48 8d 15 99 48 00 00 	lea    0x4899(%rip),%rdx        # 44ae5 <console_clear+0x51>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 91 39 00 00       	call   43be8 <strcmp>
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
   4027a:	48 8d 15 6d 48 00 00 	lea    0x486d(%rip),%rdx        # 44aee <console_clear+0x5a>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 5c 39 00 00       	call   43be8 <strcmp>
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
   402ac:	48 8d 15 40 48 00 00 	lea    0x4840(%rip),%rdx        # 44af3 <console_clear+0x5f>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 2a 39 00 00       	call   43be8 <strcmp>
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
   4032a:	e8 de 2d 00 00       	call   4310d <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   4032f:	48 8d 15 ca 7c 07 00 	lea    0x77cca(%rip),%rdx        # b8000 <console>
   40336:	48 8d 35 c3 7c 07 00 	lea    0x77cc3(%rip),%rsi        # b8000 <console>
   4033d:	48 8b 05 bc 4c 01 00 	mov    0x14cbc(%rip),%rax        # 55000 <kernel_pagetable>
   40344:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4034a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4034f:	48 89 c7             	mov    %rax,%rdi
   40352:	e8 b6 2d 00 00       	call   4310d <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    // Switch to the first process using run()
    run(&processes[1]);
   40357:	48 8d 05 a2 1d 01 00 	lea    0x11da2(%rip),%rax        # 52100 <processes+0xe0>
   4035e:	48 89 c7             	mov    %rax,%rdi
   40361:	e8 6c 0e 00 00       	call   411d2 <run>

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
   403e0:	e8 fa 36 00 00       	call   43adf <memset>
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
   40558:	e8 fa 2f 00 00       	call   43557 <virtual_memory_lookup>
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
   4057f:	e8 89 2b 00 00       	call   4310d <virtual_memory_map>
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
   405d4:	e8 7a 1f 00 00       	call   42553 <process_init>

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
   4062d:	e8 db 2a 00 00       	call   4310d <virtual_memory_map>
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
   4065e:	e8 ef 2f 00 00       	call   43652 <program_load>
   40663:	89 45 f4             	mov    %eax,-0xc(%rbp)
    assert(r >= 0);
   40666:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4066a:	79 1e                	jns    4068a <process_setup+0xee>
   4066c:	48 8d 05 86 44 00 00 	lea    0x4486(%rip),%rax        # 44af9 <console_clear+0x65>
   40673:	48 89 c2             	mov    %rax,%rdx
   40676:	be c0 00 00 00       	mov    $0xc0,%esi
   4067b:	48 8d 05 7e 44 00 00 	lea    0x447e(%rip),%rax        # 44b00 <console_clear+0x6c>
   40682:	48 89 c7             	mov    %rax,%rdi
   40685:	e8 ff 26 00 00       	call   42d89 <assert_fail>

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
   406b1:	e8 57 2a 00 00       	call   4310d <virtual_memory_map>
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
   407d2:	e8 80 2d 00 00       	call   43557 <virtual_memory_lookup>

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
   4080a:	e8 48 2d 00 00       	call   43557 <virtual_memory_lookup>
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
   40836:	e8 1c 2d 00 00       	call   43557 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   4083b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4083f:	48 89 c1             	mov    %rax,%rcx
   40842:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40846:	ba 18 00 00 00       	mov    $0x18,%edx
   4084b:	48 89 c6             	mov    %rax,%rsi
   4084e:	48 89 cf             	mov    %rcx,%rdi
   40851:	e8 83 31 00 00       	call   439d9 <memcpy>
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

00000000000408cb <unmap>:
//    the kernel's stack, then jumping to kernel assembly code (in
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.
void unmap(x86_64_pagetable* child_table, proc* child){
   408cb:	f3 0f 1e fa          	endbr64 
   408cf:	55                   	push   %rbp
   408d0:	48 89 e5             	mov    %rsp,%rbp
   408d3:	48 83 ec 30          	sub    $0x30,%rsp
   408d7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   408db:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
        for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   408df:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   408e6:	00 
   408e7:	eb 4f                	jmp    40938 <unmap+0x6d>
            vamapping child_map = virtual_memory_lookup(child_table, va);
   408e9:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   408ed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   408f1:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   408f5:	48 89 ce             	mov    %rcx,%rsi
   408f8:	48 89 c7             	mov    %rax,%rdi
   408fb:	e8 57 2c 00 00       	call   43557 <virtual_memory_lookup>
            if (child_map.pn != -1) {
   40900:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40903:	83 f8 ff             	cmp    $0xffffffff,%eax
   40906:	74 28                	je     40930 <unmap+0x65>
                pageinfo[child_map.pn].refcount = 0;
   40908:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4090b:	48 98                	cltq   
   4090d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40911:	48 8d 05 29 25 01 00 	lea    0x12529(%rip),%rax        # 52e41 <pageinfo+0x1>
   40918:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[child_map.pn].owner = PO_FREE;
   4091c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4091f:	48 98                	cltq   
   40921:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40925:	48 8d 05 14 25 01 00 	lea    0x12514(%rip),%rax        # 52e40 <pageinfo>
   4092c:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40930:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40937:	00 
   40938:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4093f:	00 
   40940:	76 a7                	jbe    408e9 <unmap+0x1e>
            }
        }
        pageinfo[PAGENUMBER((uintptr_t) child_table)].refcount = 0;
   40942:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40946:	48 c1 e8 0c          	shr    $0xc,%rax
   4094a:	48 98                	cltq   
   4094c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40950:	48 8d 05 ea 24 01 00 	lea    0x124ea(%rip),%rax        # 52e41 <pageinfo+0x1>
   40957:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER((uintptr_t) child_table)].owner = PO_FREE;
   4095b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4095f:	48 c1 e8 0c          	shr    $0xc,%rax
   40963:	48 98                	cltq   
   40965:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40969:	48 8d 05 d0 24 01 00 	lea    0x124d0(%rip),%rax        # 52e40 <pageinfo>
   40970:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        child->p_state = P_FREE;
   40974:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40978:	c7 80 c8 00 00 00 00 	movl   $0x0,0xc8(%rax)
   4097f:	00 00 00 
        current->p_registers.reg_rax = -1;
   40982:	48 8b 05 77 16 01 00 	mov    0x11677(%rip),%rax        # 52000 <current>
   40989:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40990:	ff 
}
   40991:	90                   	nop
   40992:	c9                   	leave  
   40993:	c3                   	ret    

0000000000040994 <exception>:
void exception(x86_64_registers* reg) {
   40994:	f3 0f 1e fa          	endbr64 
   40998:	55                   	push   %rbp
   40999:	48 89 e5             	mov    %rsp,%rbp
   4099c:	48 81 ec 80 01 00 00 	sub    $0x180,%rsp
   409a3:	48 89 bd 88 fe ff ff 	mov    %rdi,-0x178(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   409aa:	48 8b 05 4f 16 01 00 	mov    0x1164f(%rip),%rax        # 52000 <current>
   409b1:	48 8b 95 88 fe ff ff 	mov    -0x178(%rbp),%rdx
   409b8:	48 83 c0 08          	add    $0x8,%rax
   409bc:	48 89 d6             	mov    %rdx,%rsi
   409bf:	ba 18 00 00 00       	mov    $0x18,%edx
   409c4:	48 89 c7             	mov    %rax,%rdi
   409c7:	48 89 d1             	mov    %rdx,%rcx
   409ca:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   409cd:	48 8b 05 2c 46 01 00 	mov    0x1462c(%rip),%rax        # 55000 <kernel_pagetable>
   409d4:	48 89 c7             	mov    %rax,%rdi
   409d7:	e8 bf 25 00 00       	call   42f9b <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   409dc:	8b 05 1a 86 07 00    	mov    0x7861a(%rip),%eax        # b8ffc <cursorpos>
   409e2:	89 c7                	mov    %eax,%edi
   409e4:	e8 38 1c 00 00       	call   42621 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   409e9:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   409f0:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   409f7:	48 83 f8 0e          	cmp    $0xe,%rax
   409fb:	74 14                	je     40a11 <exception+0x7d>
   409fd:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40a04:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40a0b:	48 83 f8 0d          	cmp    $0xd,%rax
   40a0f:	75 16                	jne    40a27 <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40a11:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40a18:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a1f:	83 e0 04             	and    $0x4,%eax
   40a22:	48 85 c0             	test   %rax,%rax
   40a25:	74 1a                	je     40a41 <exception+0xad>
    {
        check_virtual_memory();
   40a27:	e8 3b 0c 00 00       	call   41667 <check_virtual_memory>
        if(disp_global){
   40a2c:	0f b6 05 cd 55 00 00 	movzbl 0x55cd(%rip),%eax        # 46000 <disp_global>
   40a33:	84 c0                	test   %al,%al
   40a35:	74 0a                	je     40a41 <exception+0xad>
            memshow_physical();
   40a37:	e8 f4 0d 00 00       	call   41830 <memshow_physical>
            memshow_virtual_animate();
   40a3c:	e8 91 11 00 00       	call   41bd2 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40a41:	e8 f1 20 00 00       	call   42b37 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40a46:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40a4d:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40a54:	48 83 e8 0e          	sub    $0xe,%rax
   40a58:	48 83 f8 2a          	cmp    $0x2a,%rax
   40a5c:	0f 87 b8 06 00 00    	ja     4111a <exception+0x786>
   40a62:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   40a69:	00 
   40a6a:	48 8d 05 2f 41 00 00 	lea    0x412f(%rip),%rax        # 44ba0 <console_clear+0x10c>
   40a71:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40a74:	48 98                	cltq   
   40a76:	48 8d 15 23 41 00 00 	lea    0x4123(%rip),%rdx        # 44ba0 <console_clear+0x10c>
   40a7d:	48 01 d0             	add    %rdx,%rax
   40a80:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40a83:	48 8b 05 76 15 01 00 	mov    0x11576(%rip),%rax        # 52000 <current>
   40a8a:	48 8b 40 38          	mov    0x38(%rax),%rax
   40a8e:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
		if((void *)addr == NULL)
   40a92:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
   40a97:	75 0f                	jne    40aa8 <exception+0x114>
		    panic(NULL);
   40a99:	bf 00 00 00 00       	mov    $0x0,%edi
   40a9e:	b8 00 00 00 00       	mov    $0x0,%eax
   40aa3:	e8 f1 21 00 00       	call   42c99 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40aa8:	48 8b 05 51 15 01 00 	mov    0x11551(%rip),%rax        # 52000 <current>
   40aaf:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40ab6:	48 8d 85 68 ff ff ff 	lea    -0x98(%rbp),%rax
   40abd:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   40ac1:	48 89 ce             	mov    %rcx,%rsi
   40ac4:	48 89 c7             	mov    %rax,%rdi
   40ac7:	e8 8b 2a 00 00       	call   43557 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40acc:	48 8b 85 70 ff ff ff 	mov    -0x90(%rbp),%rax
   40ad3:	48 89 c1             	mov    %rax,%rcx
   40ad6:	48 8d 85 98 fe ff ff 	lea    -0x168(%rbp),%rax
   40add:	ba a0 00 00 00       	mov    $0xa0,%edx
   40ae2:	48 89 ce             	mov    %rcx,%rsi
   40ae5:	48 89 c7             	mov    %rax,%rdi
   40ae8:	e8 ec 2e 00 00       	call   439d9 <memcpy>
		panic(msg);
   40aed:	48 8d 85 98 fe ff ff 	lea    -0x168(%rbp),%rax
   40af4:	48 89 c7             	mov    %rax,%rdi
   40af7:	b8 00 00 00 00       	mov    $0x0,%eax
   40afc:	e8 98 21 00 00       	call   42c99 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40b01:	48 8b 05 f8 14 01 00 	mov    0x114f8(%rip),%rax        # 52000 <current>
   40b08:	8b 10                	mov    (%rax),%edx
   40b0a:	48 8b 05 ef 14 01 00 	mov    0x114ef(%rip),%rax        # 52000 <current>
   40b11:	48 63 d2             	movslq %edx,%rdx
   40b14:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40b18:	e9 0d 06 00 00       	jmp    4112a <exception+0x796>

    case INT_SYS_YIELD:
        schedule();
   40b1d:	e8 31 06 00 00       	call   41153 <schedule>
        break;                  /* will not be reached */
   40b22:	e9 03 06 00 00       	jmp    4112a <exception+0x796>

case INT_SYS_PAGE_ALLOC: {
    uintptr_t va = current->p_registers.reg_rdi;
   40b27:	48 8b 05 d2 14 01 00 	mov    0x114d2(%rip),%rax        # 52000 <current>
   40b2e:	48 8b 40 38          	mov    0x38(%rax),%rax
   40b32:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    // check allignment and bounds
    if (va % PAGESIZE != 0) {
   40b36:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b3a:	25 ff 0f 00 00       	and    $0xfff,%eax
   40b3f:	48 85 c0             	test   %rax,%rax
   40b42:	74 14                	je     40b58 <exception+0x1c4>
        current->p_registers.reg_rax = -1; 
   40b44:	48 8b 05 b5 14 01 00 	mov    0x114b5(%rip),%rax        # 52000 <current>
   40b4b:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b52:	ff 
        break;
   40b53:	e9 d2 05 00 00       	jmp    4112a <exception+0x796>
    }
    if (va >= MEMSIZE_VIRTUAL) {
   40b58:	48 81 7d b8 ff ff 2f 	cmpq   $0x2fffff,-0x48(%rbp)
   40b5f:	00 
   40b60:	76 14                	jbe    40b76 <exception+0x1e2>
        current->p_registers.reg_rax = -1; 
   40b62:	48 8b 05 97 14 01 00 	mov    0x11497(%rip),%rax        # 52000 <current>
   40b69:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b70:	ff 
        break;
   40b71:	e9 b4 05 00 00       	jmp    4112a <exception+0x796>
    }
    if (va < PROC_START_ADDR) {
   40b76:	48 81 7d b8 ff ff 0f 	cmpq   $0xfffff,-0x48(%rbp)
   40b7d:	00 
   40b7e:	77 14                	ja     40b94 <exception+0x200>
        current->p_registers.reg_rax = -1; 
   40b80:	48 8b 05 79 14 01 00 	mov    0x11479(%rip),%rax        # 52000 <current>
   40b87:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b8e:	ff 
        break;
   40b8f:	e9 96 05 00 00       	jmp    4112a <exception+0x796>
    }   
    uintptr_t pa = find_page(current->p_pid);
   40b94:	48 8b 05 65 14 01 00 	mov    0x11465(%rip),%rax        # 52000 <current>
   40b9b:	8b 00                	mov    (%rax),%eax
   40b9d:	0f be c0             	movsbl %al,%eax
   40ba0:	89 c7                	mov    %eax,%edi
   40ba2:	e8 5d f8 ff ff       	call   40404 <find_page>
   40ba7:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    if (pa == 0) {
   40bab:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   40bb0:	75 14                	jne    40bc6 <exception+0x232>
        current->p_registers.reg_rax = -1; 
   40bb2:	48 8b 05 47 14 01 00 	mov    0x11447(%rip),%rax        # 52000 <current>
   40bb9:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40bc0:	ff 
        break;
   40bc1:	e9 64 05 00 00       	jmp    4112a <exception+0x796>
    }
    int perm = PTE_P | PTE_W | PTE_U;
   40bc6:	c7 45 ac 07 00 00 00 	movl   $0x7,-0x54(%rbp)

    int r = virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, perm);
   40bcd:	48 8b 05 2c 14 01 00 	mov    0x1142c(%rip),%rax        # 52000 <current>
   40bd4:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40bdb:	8b 4d ac             	mov    -0x54(%rbp),%ecx
   40bde:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   40be2:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
   40be6:	41 89 c8             	mov    %ecx,%r8d
   40be9:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40bee:	48 89 c7             	mov    %rax,%rdi
   40bf1:	e8 17 25 00 00       	call   4310d <virtual_memory_map>
   40bf6:	89 45 a8             	mov    %eax,-0x58(%rbp)

    if (r != 0) {
   40bf9:	83 7d a8 00          	cmpl   $0x0,-0x58(%rbp)
   40bfd:	74 46                	je     40c45 <exception+0x2b1>
        // If mapping fails, free the physical page
        pageinfo[PAGENUMBER(pa)].refcount = 0;
   40bff:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40c03:	48 c1 e8 0c          	shr    $0xc,%rax
   40c07:	48 98                	cltq   
   40c09:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40c0d:	48 8d 05 2d 22 01 00 	lea    0x1222d(%rip),%rax        # 52e41 <pageinfo+0x1>
   40c14:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(pa)].owner = PO_FREE;
   40c18:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40c1c:	48 c1 e8 0c          	shr    $0xc,%rax
   40c20:	48 98                	cltq   
   40c22:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40c26:	48 8d 05 13 22 01 00 	lea    0x12213(%rip),%rax        # 52e40 <pageinfo>
   40c2d:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        current->p_registers.reg_rax = -1;
   40c31:	48 8b 05 c8 13 01 00 	mov    0x113c8(%rip),%rax        # 52000 <current>
   40c38:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40c3f:	ff 
        break;
   40c40:	e9 e5 04 00 00       	jmp    4112a <exception+0x796>
    }

    // Success: Return 0
    current->p_registers.reg_rax = 0;
   40c45:	48 8b 05 b4 13 01 00 	mov    0x113b4(%rip),%rax        # 52000 <current>
   40c4c:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40c53:	00 
    break;
   40c54:	e9 d1 04 00 00       	jmp    4112a <exception+0x796>
}
case INT_SYS_FORK: {
    // find free
    pid_t child_pid = -1;
   40c59:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    for (pid_t i = 1; i < NPROC; ++i) {
   40c60:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   40c67:	eb 31                	jmp    40c9a <exception+0x306>
        if (processes[i].p_state == P_FREE) {
   40c69:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40c6c:	48 63 d0             	movslq %eax,%rdx
   40c6f:	48 89 d0             	mov    %rdx,%rax
   40c72:	48 c1 e0 03          	shl    $0x3,%rax
   40c76:	48 29 d0             	sub    %rdx,%rax
   40c79:	48 c1 e0 05          	shl    $0x5,%rax
   40c7d:	48 89 c2             	mov    %rax,%rdx
   40c80:	48 8d 05 61 14 01 00 	lea    0x11461(%rip),%rax        # 520e8 <processes+0xc8>
   40c87:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40c8a:	85 c0                	test   %eax,%eax
   40c8c:	75 08                	jne    40c96 <exception+0x302>
            child_pid = i;
   40c8e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40c91:	89 45 fc             	mov    %eax,-0x4(%rbp)
            break;
   40c94:	eb 0a                	jmp    40ca0 <exception+0x30c>
    for (pid_t i = 1; i < NPROC; ++i) {
   40c96:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40c9a:	83 7d f8 0f          	cmpl   $0xf,-0x8(%rbp)
   40c9e:	7e c9                	jle    40c69 <exception+0x2d5>
        }
    }

    // no ree
    if (child_pid == -1) {
   40ca0:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40ca4:	75 14                	jne    40cba <exception+0x326>
        current->p_registers.reg_rax = -1;
   40ca6:	48 8b 05 53 13 01 00 	mov    0x11353(%rip),%rax        # 52000 <current>
   40cad:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40cb4:	ff 
        break;
   40cb5:	e9 70 04 00 00       	jmp    4112a <exception+0x796>
    }

    // reserve
    proc* parent = current;
   40cba:	48 8b 05 3f 13 01 00 	mov    0x1133f(%rip),%rax        # 52000 <current>
   40cc1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    proc* child = &processes[child_pid];
   40cc5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cc8:	48 63 d0             	movslq %eax,%rdx
   40ccb:	48 89 d0             	mov    %rdx,%rax
   40cce:	48 c1 e0 03          	shl    $0x3,%rax
   40cd2:	48 29 d0             	sub    %rdx,%rax
   40cd5:	48 c1 e0 05          	shl    $0x5,%rax
   40cd9:	48 8d 15 40 13 01 00 	lea    0x11340(%rip),%rdx        # 52020 <processes>
   40ce0:	48 01 d0             	add    %rdx,%rax
   40ce3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    process_init(child, child_pid);
   40ce7:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40cea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40cee:	89 d6                	mov    %edx,%esi
   40cf0:	48 89 c7             	mov    %rax,%rdi
   40cf3:	e8 5b 18 00 00       	call   42553 <process_init>

    //allocate
    x86_64_pagetable* child_table = make_pages(child_pid);
   40cf8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cfb:	89 c7                	mov    %eax,%edi
   40cfd:	e8 8a f7 ff ff       	call   4048c <make_pages>
   40d02:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if (!child_table) {
   40d06:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   40d0b:	75 14                	jne    40d21 <exception+0x38d>
        current->p_registers.reg_rax = -1;
   40d0d:	48 8b 05 ec 12 01 00 	mov    0x112ec(%rip),%rax        # 52000 <current>
   40d14:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40d1b:	ff 
        break;
   40d1c:	e9 09 04 00 00       	jmp    4112a <exception+0x796>
    }
    child->p_pagetable = child_table;
   40d21:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40d25:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40d29:	48 89 90 d0 00 00 00 	mov    %rdx,0xd0(%rax)
    int failed = 0;
   40d30:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    // map console

    vamapping console_mapping = virtual_memory_lookup(parent->p_pagetable, CONSOLE_ADDR);
   40d37:	48 8d 15 c2 72 07 00 	lea    0x772c2(%rip),%rdx        # b8000 <console>
   40d3e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d42:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40d49:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
   40d50:	48 89 ce             	mov    %rcx,%rsi
   40d53:	48 89 c7             	mov    %rax,%rdi
   40d56:	e8 fc 27 00 00       	call   43557 <virtual_memory_lookup>
        if (console_mapping.pn != -1) {
   40d5b:	8b 85 50 ff ff ff    	mov    -0xb0(%rbp),%eax
   40d61:	83 f8 ff             	cmp    $0xffffffff,%eax
   40d64:	74 60                	je     40dc6 <exception+0x432>
            pageinfo[console_mapping.pn].refcount++;
   40d66:	8b 85 50 ff ff ff    	mov    -0xb0(%rbp),%eax
   40d6c:	48 63 d0             	movslq %eax,%rdx
   40d6f:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40d73:	48 8d 15 c7 20 01 00 	lea    0x120c7(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40d7a:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40d7e:	83 c2 01             	add    $0x1,%edx
   40d81:	89 d1                	mov    %edx,%ecx
   40d83:	48 98                	cltq   
   40d85:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40d89:	48 8d 05 b1 20 01 00 	lea    0x120b1(%rip),%rax        # 52e41 <pageinfo+0x1>
   40d90:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
            if (virtual_memory_map(child_table, CONSOLE_ADDR, CONSOLE_ADDR, PAGESIZE, console_mapping.perm) < 0) {
   40d93:	8b 8d 60 ff ff ff    	mov    -0xa0(%rbp),%ecx
   40d99:	48 8d 15 60 72 07 00 	lea    0x77260(%rip),%rdx        # b8000 <console>
   40da0:	48 8d 35 59 72 07 00 	lea    0x77259(%rip),%rsi        # b8000 <console>
   40da7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40dab:	41 89 c8             	mov    %ecx,%r8d
   40dae:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40db3:	48 89 c7             	mov    %rax,%rdi
   40db6:	e8 52 23 00 00       	call   4310d <virtual_memory_map>
   40dbb:	85 c0                	test   %eax,%eax
   40dbd:	79 07                	jns    40dc6 <exception+0x432>
                failed = 1;
   40dbf:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
            }
    }

    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40dc6:	48 c7 45 e8 00 00 10 	movq   $0x100000,-0x18(%rbp)
   40dcd:	00 
   40dce:	e9 7f 01 00 00       	jmp    40f52 <exception+0x5be>
        vamapping parent_mapping = virtual_memory_lookup(parent->p_pagetable, va);
   40dd3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40dd7:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40dde:	48 8d 85 38 ff ff ff 	lea    -0xc8(%rbp),%rax
   40de5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40de9:	48 89 ce             	mov    %rcx,%rsi
   40dec:	48 89 c7             	mov    %rax,%rdi
   40def:	e8 63 27 00 00       	call   43557 <virtual_memory_lookup>
        // skip console and nonexistent pages
        if (va == CONSOLE_ADDR || parent_mapping.pn == -1) {
   40df4:	48 8d 05 05 72 07 00 	lea    0x77205(%rip),%rax        # b8000 <console>
   40dfb:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40dff:	0f 84 44 01 00 00    	je     40f49 <exception+0x5b5>
   40e05:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
   40e0b:	83 f8 ff             	cmp    $0xffffffff,%eax
   40e0e:	0f 84 35 01 00 00    	je     40f49 <exception+0x5b5>
            continue; 
        }

        if (parent_mapping.perm & PTE_W) {
   40e14:	8b 85 48 ff ff ff    	mov    -0xb8(%rbp),%eax
   40e1a:	48 98                	cltq   
   40e1c:	83 e0 02             	and    $0x2,%eax
   40e1f:	48 85 c0             	test   %rax,%rax
   40e22:	0f 84 af 00 00 00    	je     40ed7 <exception+0x543>
        // Allocate a new physical page for the child
            uintptr_t new_pa = find_page(child_pid);
   40e28:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e2b:	0f be c0             	movsbl %al,%eax
   40e2e:	89 c7                	mov    %eax,%edi
   40e30:	e8 cf f5 ff ff       	call   40404 <find_page>
   40e35:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            if (!new_pa) {
   40e39:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40e3e:	75 0c                	jne    40e4c <exception+0x4b8>
                failed = 1;
   40e40:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
                break;
   40e47:	e9 14 01 00 00       	jmp    40f60 <exception+0x5cc>
            }
            memcpy((void*) new_pa, (void*) parent_mapping.pa, PAGESIZE);
   40e4c:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
   40e53:	48 89 c1             	mov    %rax,%rcx
   40e56:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e5a:	ba 00 10 00 00       	mov    $0x1000,%edx
   40e5f:	48 89 ce             	mov    %rcx,%rsi
   40e62:	48 89 c7             	mov    %rax,%rdi
   40e65:	e8 6f 2b 00 00       	call   439d9 <memcpy>

            int r = virtual_memory_map(child_table, va, new_pa, PAGESIZE, parent_mapping.perm);
   40e6a:	8b 8d 48 ff ff ff    	mov    -0xb8(%rbp),%ecx
   40e70:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40e74:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40e78:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40e7c:	41 89 c8             	mov    %ecx,%r8d
   40e7f:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40e84:	48 89 c7             	mov    %rax,%rdi
   40e87:	e8 81 22 00 00       	call   4310d <virtual_memory_map>
   40e8c:	89 45 c4             	mov    %eax,-0x3c(%rbp)
            if (r < 0) {
   40e8f:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
   40e93:	0f 89 b1 00 00 00    	jns    40f4a <exception+0x5b6>
                failed = 1;
   40e99:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
                pageinfo[PAGENUMBER(new_pa)].refcount = 0; 
   40ea0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ea4:	48 c1 e8 0c          	shr    $0xc,%rax
   40ea8:	48 98                	cltq   
   40eaa:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40eae:	48 8d 05 8c 1f 01 00 	lea    0x11f8c(%rip),%rax        # 52e41 <pageinfo+0x1>
   40eb5:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[PAGENUMBER(new_pa)].owner = PO_FREE;
   40eb9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ebd:	48 c1 e8 0c          	shr    $0xc,%rax
   40ec1:	48 98                	cltq   
   40ec3:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40ec7:	48 8d 05 72 1f 01 00 	lea    0x11f72(%rip),%rax        # 52e40 <pageinfo>
   40ece:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                break;
   40ed2:	e9 89 00 00 00       	jmp    40f60 <exception+0x5cc>
            }
        } else if (((parent_mapping.perm & (PTE_P | PTE_U)) == (PTE_P | PTE_U))) {
   40ed7:	8b 85 48 ff ff ff    	mov    -0xb8(%rbp),%eax
   40edd:	48 98                	cltq   
   40edf:	83 e0 05             	and    $0x5,%eax
   40ee2:	48 83 f8 05          	cmp    $0x5,%rax
   40ee6:	75 62                	jne    40f4a <exception+0x5b6>
                
            if (virtual_memory_map(child_table, va, parent_mapping.pa, PAGESIZE, parent_mapping.perm) < 0) {
   40ee8:	8b 8d 48 ff ff ff    	mov    -0xb8(%rbp),%ecx
   40eee:	48 8b 95 40 ff ff ff 	mov    -0xc0(%rbp),%rdx
   40ef5:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40ef9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40efd:	41 89 c8             	mov    %ecx,%r8d
   40f00:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40f05:	48 89 c7             	mov    %rax,%rdi
   40f08:	e8 00 22 00 00       	call   4310d <virtual_memory_map>
   40f0d:	85 c0                	test   %eax,%eax
   40f0f:	79 09                	jns    40f1a <exception+0x586>
                failed = 1;
   40f11:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
                break;
   40f18:	eb 46                	jmp    40f60 <exception+0x5cc>
            }
            pageinfo[parent_mapping.pn].refcount++;
   40f1a:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
   40f20:	48 63 d0             	movslq %eax,%rdx
   40f23:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40f27:	48 8d 15 13 1f 01 00 	lea    0x11f13(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40f2e:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40f32:	83 c2 01             	add    $0x1,%edx
   40f35:	89 d1                	mov    %edx,%ecx
   40f37:	48 98                	cltq   
   40f39:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40f3d:	48 8d 05 fd 1e 01 00 	lea    0x11efd(%rip),%rax        # 52e41 <pageinfo+0x1>
   40f44:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
            continue;
   40f47:	eb 01                	jmp    40f4a <exception+0x5b6>
            continue; 
   40f49:	90                   	nop
    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40f4a:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   40f51:	00 
   40f52:	48 81 7d e8 ff ff 2f 	cmpq   $0x2fffff,-0x18(%rbp)
   40f59:	00 
   40f5a:	0f 86 73 fe ff ff    	jbe    40dd3 <exception+0x43f>
        }
    }

    if (failed != 0) {
   40f60:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40f64:	74 18                	je     40f7e <exception+0x5ea>
        unmap(child_table, child);
   40f66:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40f6a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40f6e:	48 89 d6             	mov    %rdx,%rsi
   40f71:	48 89 c7             	mov    %rax,%rdi
   40f74:	e8 52 f9 ff ff       	call   408cb <unmap>

        break;
   40f79:	e9 ac 01 00 00       	jmp    4112a <exception+0x796>
    }

    child->p_registers = parent->p_registers;
   40f7e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40f82:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40f86:	48 83 c0 08          	add    $0x8,%rax
   40f8a:	48 83 c2 08          	add    $0x8,%rdx
   40f8e:	b9 18 00 00 00       	mov    $0x18,%ecx
   40f93:	48 89 c7             	mov    %rax,%rdi
   40f96:	48 89 d6             	mov    %rdx,%rsi
   40f99:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    child->p_registers.reg_rax = 0; 
   40f9c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40fa0:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40fa7:	00 
    child->p_state = P_RUNNABLE;
   40fa8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40fac:	c7 80 c8 00 00 00 01 	movl   $0x1,0xc8(%rax)
   40fb3:	00 00 00 
    current->p_registers.reg_rax = child_pid;
   40fb6:	48 8b 05 43 10 01 00 	mov    0x11043(%rip),%rax        # 52000 <current>
   40fbd:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40fc0:	48 63 d2             	movslq %edx,%rdx
   40fc3:	48 89 50 08          	mov    %rdx,0x8(%rax)
    break;
   40fc7:	e9 5e 01 00 00       	jmp    4112a <exception+0x796>

    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40fcc:	48 8b 05 2d 10 01 00 	mov    0x1102d(%rip),%rax        # 52000 <current>
   40fd3:	48 89 c7             	mov    %rax,%rdi
   40fd6:	e8 b6 f7 ff ff       	call   40791 <syscall_mapping>
            break;
   40fdb:	e9 4a 01 00 00       	jmp    4112a <exception+0x796>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40fe0:	48 8b 05 19 10 01 00 	mov    0x11019(%rip),%rax        # 52000 <current>
   40fe7:	48 89 c7             	mov    %rax,%rdi
   40fea:	e8 6f f8 ff ff       	call   4085e <syscall_mem_tog>
	    break;
   40fef:	e9 36 01 00 00       	jmp    4112a <exception+0x796>
	}

    case INT_TIMER:
        ++ticks;
   40ff4:	8b 05 26 1e 01 00    	mov    0x11e26(%rip),%eax        # 52e20 <ticks>
   40ffa:	83 c0 01             	add    $0x1,%eax
   40ffd:	89 05 1d 1e 01 00    	mov    %eax,0x11e1d(%rip)        # 52e20 <ticks>
        schedule();
   41003:	e8 4b 01 00 00       	call   41153 <schedule>
        break;                  /* will not be reached */
   41008:	e9 1d 01 00 00       	jmp    4112a <exception+0x796>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   4100d:	0f 20 d0             	mov    %cr2,%rax
   41010:	48 89 45 80          	mov    %rax,-0x80(%rbp)
    return val;
   41014:	48 8b 45 80          	mov    -0x80(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   41018:	48 89 45 98          	mov    %rax,-0x68(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   4101c:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   41023:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4102a:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   4102d:	48 85 c0             	test   %rax,%rax
   41030:	74 09                	je     4103b <exception+0x6a7>
   41032:	48 8d 05 d7 3a 00 00 	lea    0x3ad7(%rip),%rax        # 44b10 <console_clear+0x7c>
   41039:	eb 07                	jmp    41042 <exception+0x6ae>
   4103b:	48 8d 05 d4 3a 00 00 	lea    0x3ad4(%rip),%rax        # 44b16 <console_clear+0x82>
        const char* operation = reg->reg_err & PFERR_WRITE
   41042:	48 89 45 90          	mov    %rax,-0x70(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   41046:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   4104d:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   41054:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   41057:	48 85 c0             	test   %rax,%rax
   4105a:	74 09                	je     41065 <exception+0x6d1>
   4105c:	48 8d 05 b8 3a 00 00 	lea    0x3ab8(%rip),%rax        # 44b1b <console_clear+0x87>
   41063:	eb 07                	jmp    4106c <exception+0x6d8>
   41065:	48 8d 05 c2 3a 00 00 	lea    0x3ac2(%rip),%rax        # 44b2e <console_clear+0x9a>
        const char* problem = reg->reg_err & PFERR_PRESENT
   4106c:	48 89 45 88          	mov    %rax,-0x78(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   41070:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   41077:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4107e:	83 e0 04             	and    $0x4,%eax
   41081:	48 85 c0             	test   %rax,%rax
   41084:	75 34                	jne    410ba <exception+0x726>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   41086:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   4108d:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   41094:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   41098:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
   4109c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   410a0:	49 89 f0             	mov    %rsi,%r8
   410a3:	48 89 c6             	mov    %rax,%rsi
   410a6:	48 8d 05 93 3a 00 00 	lea    0x3a93(%rip),%rax        # 44b40 <console_clear+0xac>
   410ad:	48 89 c7             	mov    %rax,%rdi
   410b0:	b8 00 00 00 00       	mov    $0x0,%eax
   410b5:	e8 df 1b 00 00       	call   42c99 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   410ba:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   410c1:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   410c8:	48 8b 05 31 0f 01 00 	mov    0x10f31(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   410cf:	8b 00                	mov    (%rax),%eax
   410d1:	48 8b 75 90          	mov    -0x70(%rbp),%rsi
   410d5:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   410d9:	52                   	push   %rdx
   410da:	ff 75 88             	push   -0x78(%rbp)
   410dd:	49 89 f1             	mov    %rsi,%r9
   410e0:	49 89 c8             	mov    %rcx,%r8
   410e3:	89 c1                	mov    %eax,%ecx
   410e5:	48 8d 05 84 3a 00 00 	lea    0x3a84(%rip),%rax        # 44b70 <console_clear+0xdc>
   410ec:	48 89 c2             	mov    %rax,%rdx
   410ef:	be 00 0c 00 00       	mov    $0xc00,%esi
   410f4:	bf 80 07 00 00       	mov    $0x780,%edi
   410f9:	b8 00 00 00 00       	mov    $0x0,%eax
   410fe:	e8 1b 38 00 00       	call   4491e <console_printf>
   41103:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   41107:	48 8b 05 f2 0e 01 00 	mov    0x10ef2(%rip),%rax        # 52000 <current>
   4110e:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   41115:	00 00 00 
        break;
   41118:	eb 10                	jmp    4112a <exception+0x796>
    }

    default:
        default_exception(current);
   4111a:	48 8b 05 df 0e 01 00 	mov    0x10edf(%rip),%rax        # 52000 <current>
   41121:	48 89 c7             	mov    %rax,%rdi
   41124:	e8 99 1c 00 00       	call   42dc2 <default_exception>
        break;                  /* will not be reached */
   41129:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   4112a:	48 8b 05 cf 0e 01 00 	mov    0x10ecf(%rip),%rax        # 52000 <current>
   41131:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41137:	83 f8 01             	cmp    $0x1,%eax
   4113a:	75 0f                	jne    4114b <exception+0x7b7>
        run(current);
   4113c:	48 8b 05 bd 0e 01 00 	mov    0x10ebd(%rip),%rax        # 52000 <current>
   41143:	48 89 c7             	mov    %rax,%rdi
   41146:	e8 87 00 00 00       	call   411d2 <run>
    } else {
        schedule();
   4114b:	e8 03 00 00 00       	call   41153 <schedule>
    }
}
   41150:	90                   	nop
   41151:	c9                   	leave  
   41152:	c3                   	ret    

0000000000041153 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   41153:	f3 0f 1e fa          	endbr64 
   41157:	55                   	push   %rbp
   41158:	48 89 e5             	mov    %rsp,%rbp
   4115b:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   4115f:	48 8b 05 9a 0e 01 00 	mov    0x10e9a(%rip),%rax        # 52000 <current>
   41166:	8b 00                	mov    (%rax),%eax
   41168:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   4116b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4116e:	83 c0 01             	add    $0x1,%eax
   41171:	99                   	cltd   
   41172:	c1 ea 1c             	shr    $0x1c,%edx
   41175:	01 d0                	add    %edx,%eax
   41177:	83 e0 0f             	and    $0xf,%eax
   4117a:	29 d0                	sub    %edx,%eax
   4117c:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   4117f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41182:	48 63 d0             	movslq %eax,%rdx
   41185:	48 89 d0             	mov    %rdx,%rax
   41188:	48 c1 e0 03          	shl    $0x3,%rax
   4118c:	48 29 d0             	sub    %rdx,%rax
   4118f:	48 c1 e0 05          	shl    $0x5,%rax
   41193:	48 89 c2             	mov    %rax,%rdx
   41196:	48 8d 05 4b 0f 01 00 	lea    0x10f4b(%rip),%rax        # 520e8 <processes+0xc8>
   4119d:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   411a0:	83 f8 01             	cmp    $0x1,%eax
   411a3:	75 26                	jne    411cb <schedule+0x78>
            run(&processes[pid]);
   411a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411a8:	48 63 d0             	movslq %eax,%rdx
   411ab:	48 89 d0             	mov    %rdx,%rax
   411ae:	48 c1 e0 03          	shl    $0x3,%rax
   411b2:	48 29 d0             	sub    %rdx,%rax
   411b5:	48 c1 e0 05          	shl    $0x5,%rax
   411b9:	48 8d 15 60 0e 01 00 	lea    0x10e60(%rip),%rdx        # 52020 <processes>
   411c0:	48 01 d0             	add    %rdx,%rax
   411c3:	48 89 c7             	mov    %rax,%rdi
   411c6:	e8 07 00 00 00       	call   411d2 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   411cb:	e8 67 19 00 00       	call   42b37 <check_keyboard>
        pid = (pid + 1) % NPROC;
   411d0:	eb 99                	jmp    4116b <schedule+0x18>

00000000000411d2 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   411d2:	f3 0f 1e fa          	endbr64 
   411d6:	55                   	push   %rbp
   411d7:	48 89 e5             	mov    %rsp,%rbp
   411da:	48 83 ec 10          	sub    $0x10,%rsp
   411de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   411e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411e6:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   411ec:	83 f8 01             	cmp    $0x1,%eax
   411ef:	74 1e                	je     4120f <run+0x3d>
   411f1:	48 8d 05 54 3a 00 00 	lea    0x3a54(%rip),%rax        # 44c4c <console_clear+0x1b8>
   411f8:	48 89 c2             	mov    %rax,%rdx
   411fb:	be 0e 02 00 00       	mov    $0x20e,%esi
   41200:	48 8d 05 f9 38 00 00 	lea    0x38f9(%rip),%rax        # 44b00 <console_clear+0x6c>
   41207:	48 89 c7             	mov    %rax,%rdi
   4120a:	e8 7a 1b 00 00       	call   42d89 <assert_fail>
    current = p;
   4120f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41213:	48 89 05 e6 0d 01 00 	mov    %rax,0x10de6(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   4121a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4121e:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   41225:	48 89 c7             	mov    %rax,%rdi
   41228:	e8 6e 1d 00 00       	call   42f9b <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   4122d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41231:	48 83 c0 08          	add    $0x8,%rax
   41235:	48 89 c7             	mov    %rax,%rdi
   41238:	e8 86 ee ff ff       	call   400c3 <exception_return>

000000000004123d <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   4123d:	f3 0f 1e fa          	endbr64 
   41241:	55                   	push   %rbp
   41242:	48 89 e5             	mov    %rsp,%rbp
   41245:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   41249:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41250:	00 
   41251:	e9 93 00 00 00       	jmp    412e9 <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   41256:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4125a:	48 89 c7             	mov    %rax,%rdi
   4125d:	e8 0f 11 00 00       	call   42371 <physical_memory_isreserved>
   41262:	85 c0                	test   %eax,%eax
   41264:	74 09                	je     4126f <pageinfo_init+0x32>
            owner = PO_RESERVED;
   41266:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   4126d:	eb 31                	jmp    412a0 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   4126f:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   41276:	00 
   41277:	76 0d                	jbe    41286 <pageinfo_init+0x49>
   41279:	48 8d 05 88 9d 01 00 	lea    0x19d88(%rip),%rax        # 5b008 <end>
   41280:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41284:	72 0a                	jb     41290 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   41286:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   4128d:	00 
   4128e:	75 09                	jne    41299 <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   41290:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   41297:	eb 07                	jmp    412a0 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   41299:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   412a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412a4:	48 c1 e8 0c          	shr    $0xc,%rax
   412a8:	89 c2                	mov    %eax,%edx
   412aa:	8b 45 f4             	mov    -0xc(%rbp),%eax
   412ad:	89 c1                	mov    %eax,%ecx
   412af:	48 63 c2             	movslq %edx,%rax
   412b2:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   412b6:	48 8d 05 83 1b 01 00 	lea    0x11b83(%rip),%rax        # 52e40 <pageinfo>
   412bd:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   412c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   412c4:	0f 95 c2             	setne  %dl
   412c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412cb:	48 c1 e8 0c          	shr    $0xc,%rax
   412cf:	89 d1                	mov    %edx,%ecx
   412d1:	48 98                	cltq   
   412d3:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   412d7:	48 8d 05 63 1b 01 00 	lea    0x11b63(%rip),%rax        # 52e41 <pageinfo+0x1>
   412de:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   412e1:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   412e8:	00 
   412e9:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   412f0:	00 
   412f1:	0f 86 5f ff ff ff    	jbe    41256 <pageinfo_init+0x19>
    }
}
   412f7:	90                   	nop
   412f8:	90                   	nop
   412f9:	c9                   	leave  
   412fa:	c3                   	ret    

00000000000412fb <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   412fb:	f3 0f 1e fa          	endbr64 
   412ff:	55                   	push   %rbp
   41300:	48 89 e5             	mov    %rsp,%rbp
   41303:	48 83 ec 50          	sub    $0x50,%rsp
   41307:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   4130b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4130f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41315:	48 89 c2             	mov    %rax,%rdx
   41318:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4131c:	48 39 c2             	cmp    %rax,%rdx
   4131f:	74 1e                	je     4133f <check_page_table_mappings+0x44>
   41321:	48 8d 05 40 39 00 00 	lea    0x3940(%rip),%rax        # 44c68 <console_clear+0x1d4>
   41328:	48 89 c2             	mov    %rax,%rdx
   4132b:	be 38 02 00 00       	mov    $0x238,%esi
   41330:	48 8d 05 c9 37 00 00 	lea    0x37c9(%rip),%rax        # 44b00 <console_clear+0x6c>
   41337:	48 89 c7             	mov    %rax,%rdi
   4133a:	e8 4a 1a 00 00       	call   42d89 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   4133f:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   41346:	00 
   41347:	e9 b5 00 00 00       	jmp    41401 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   4134c:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   41350:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41354:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41358:	48 89 ce             	mov    %rcx,%rsi
   4135b:	48 89 c7             	mov    %rax,%rdi
   4135e:	e8 f4 21 00 00       	call   43557 <virtual_memory_lookup>
        if (vam.pa != va) {
   41363:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41367:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4136b:	74 2c                	je     41399 <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   4136d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   41371:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41375:	49 89 d0             	mov    %rdx,%r8
   41378:	48 89 c1             	mov    %rax,%rcx
   4137b:	48 8d 05 05 39 00 00 	lea    0x3905(%rip),%rax        # 44c87 <console_clear+0x1f3>
   41382:	48 89 c2             	mov    %rax,%rdx
   41385:	be 00 c0 00 00       	mov    $0xc000,%esi
   4138a:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4138f:	b8 00 00 00 00       	mov    $0x0,%eax
   41394:	e8 85 35 00 00       	call   4491e <console_printf>
        }
        assert(vam.pa == va);
   41399:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4139d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413a1:	74 1e                	je     413c1 <check_page_table_mappings+0xc6>
   413a3:	48 8d 05 e7 38 00 00 	lea    0x38e7(%rip),%rax        # 44c91 <console_clear+0x1fd>
   413aa:	48 89 c2             	mov    %rax,%rdx
   413ad:	be 41 02 00 00       	mov    $0x241,%esi
   413b2:	48 8d 05 47 37 00 00 	lea    0x3747(%rip),%rax        # 44b00 <console_clear+0x6c>
   413b9:	48 89 c7             	mov    %rax,%rdi
   413bc:	e8 c8 19 00 00       	call   42d89 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   413c1:	48 8d 05 38 4c 00 00 	lea    0x4c38(%rip),%rax        # 46000 <disp_global>
   413c8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413cc:	72 2b                	jb     413f9 <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   413ce:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413d1:	48 98                	cltq   
   413d3:	83 e0 02             	and    $0x2,%eax
   413d6:	48 85 c0             	test   %rax,%rax
   413d9:	75 1e                	jne    413f9 <check_page_table_mappings+0xfe>
   413db:	48 8d 05 bc 38 00 00 	lea    0x38bc(%rip),%rax        # 44c9e <console_clear+0x20a>
   413e2:	48 89 c2             	mov    %rax,%rdx
   413e5:	be 43 02 00 00       	mov    $0x243,%esi
   413ea:	48 8d 05 0f 37 00 00 	lea    0x370f(%rip),%rax        # 44b00 <console_clear+0x6c>
   413f1:	48 89 c7             	mov    %rax,%rdi
   413f4:	e8 90 19 00 00       	call   42d89 <assert_fail>
         va += PAGESIZE) {
   413f9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41400:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41401:	48 8d 05 00 9c 01 00 	lea    0x19c00(%rip),%rax        # 5b008 <end>
   41408:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4140c:	0f 82 3a ff ff ff    	jb     4134c <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41412:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   41419:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   4141a:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   4141e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41422:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41426:	48 89 ce             	mov    %rcx,%rsi
   41429:	48 89 c7             	mov    %rax,%rdi
   4142c:	e8 26 21 00 00       	call   43557 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   41431:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41435:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   41439:	74 1e                	je     41459 <check_page_table_mappings+0x15e>
   4143b:	48 8d 05 6d 38 00 00 	lea    0x386d(%rip),%rax        # 44caf <console_clear+0x21b>
   41442:	48 89 c2             	mov    %rax,%rdx
   41445:	be 4a 02 00 00       	mov    $0x24a,%esi
   4144a:	48 8d 05 af 36 00 00 	lea    0x36af(%rip),%rax        # 44b00 <console_clear+0x6c>
   41451:	48 89 c7             	mov    %rax,%rdi
   41454:	e8 30 19 00 00       	call   42d89 <assert_fail>
    assert(vam.perm & PTE_W);
   41459:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4145c:	48 98                	cltq   
   4145e:	83 e0 02             	and    $0x2,%eax
   41461:	48 85 c0             	test   %rax,%rax
   41464:	75 1e                	jne    41484 <check_page_table_mappings+0x189>
   41466:	48 8d 05 31 38 00 00 	lea    0x3831(%rip),%rax        # 44c9e <console_clear+0x20a>
   4146d:	48 89 c2             	mov    %rax,%rdx
   41470:	be 4b 02 00 00       	mov    $0x24b,%esi
   41475:	48 8d 05 84 36 00 00 	lea    0x3684(%rip),%rax        # 44b00 <console_clear+0x6c>
   4147c:	48 89 c7             	mov    %rax,%rdi
   4147f:	e8 05 19 00 00       	call   42d89 <assert_fail>
}
   41484:	90                   	nop
   41485:	c9                   	leave  
   41486:	c3                   	ret    

0000000000041487 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   41487:	f3 0f 1e fa          	endbr64 
   4148b:	55                   	push   %rbp
   4148c:	48 89 e5             	mov    %rsp,%rbp
   4148f:	48 83 ec 20          	sub    $0x20,%rsp
   41493:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41497:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   4149a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4149d:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   414a0:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   414a7:	48 8b 05 52 3b 01 00 	mov    0x13b52(%rip),%rax        # 55000 <kernel_pagetable>
   414ae:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   414b2:	75 71                	jne    41525 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   414b4:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   414bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   414c2:	eb 5b                	jmp    4151f <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   414c4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   414c7:	48 63 d0             	movslq %eax,%rdx
   414ca:	48 89 d0             	mov    %rdx,%rax
   414cd:	48 c1 e0 03          	shl    $0x3,%rax
   414d1:	48 29 d0             	sub    %rdx,%rax
   414d4:	48 c1 e0 05          	shl    $0x5,%rax
   414d8:	48 89 c2             	mov    %rax,%rdx
   414db:	48 8d 05 06 0c 01 00 	lea    0x10c06(%rip),%rax        # 520e8 <processes+0xc8>
   414e2:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   414e5:	85 c0                	test   %eax,%eax
   414e7:	74 32                	je     4151b <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   414e9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   414ec:	48 63 d0             	movslq %eax,%rdx
   414ef:	48 89 d0             	mov    %rdx,%rax
   414f2:	48 c1 e0 03          	shl    $0x3,%rax
   414f6:	48 29 d0             	sub    %rdx,%rax
   414f9:	48 c1 e0 05          	shl    $0x5,%rax
   414fd:	48 89 c2             	mov    %rax,%rdx
   41500:	48 8d 05 e9 0b 01 00 	lea    0x10be9(%rip),%rax        # 520f0 <processes+0xd0>
   41507:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   4150b:	48 8b 05 ee 3a 01 00 	mov    0x13aee(%rip),%rax        # 55000 <kernel_pagetable>
   41512:	48 39 c2             	cmp    %rax,%rdx
   41515:	75 04                	jne    4151b <check_page_table_ownership+0x94>
                ++expected_refcount;
   41517:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4151b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4151f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41523:	7e 9f                	jle    414c4 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41525:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41528:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4152b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4152f:	be 00 00 00 00       	mov    $0x0,%esi
   41534:	48 89 c7             	mov    %rax,%rdi
   41537:	e8 03 00 00 00       	call   4153f <check_page_table_ownership_level>
}
   4153c:	90                   	nop
   4153d:	c9                   	leave  
   4153e:	c3                   	ret    

000000000004153f <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   4153f:	f3 0f 1e fa          	endbr64 
   41543:	55                   	push   %rbp
   41544:	48 89 e5             	mov    %rsp,%rbp
   41547:	48 83 ec 30          	sub    $0x30,%rsp
   4154b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4154f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41552:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41555:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41558:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4155c:	48 c1 e8 0c          	shr    $0xc,%rax
   41560:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41565:	7e 1e                	jle    41585 <check_page_table_ownership_level+0x46>
   41567:	48 8d 05 52 37 00 00 	lea    0x3752(%rip),%rax        # 44cc0 <console_clear+0x22c>
   4156e:	48 89 c2             	mov    %rax,%rdx
   41571:	be 68 02 00 00       	mov    $0x268,%esi
   41576:	48 8d 05 83 35 00 00 	lea    0x3583(%rip),%rax        # 44b00 <console_clear+0x6c>
   4157d:	48 89 c7             	mov    %rax,%rdi
   41580:	e8 04 18 00 00       	call   42d89 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41585:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41589:	48 c1 e8 0c          	shr    $0xc,%rax
   4158d:	48 98                	cltq   
   4158f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41593:	48 8d 05 a6 18 01 00 	lea    0x118a6(%rip),%rax        # 52e40 <pageinfo>
   4159a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4159e:	0f be c0             	movsbl %al,%eax
   415a1:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   415a4:	74 1e                	je     415c4 <check_page_table_ownership_level+0x85>
   415a6:	48 8d 05 2b 37 00 00 	lea    0x372b(%rip),%rax        # 44cd8 <console_clear+0x244>
   415ad:	48 89 c2             	mov    %rax,%rdx
   415b0:	be 69 02 00 00       	mov    $0x269,%esi
   415b5:	48 8d 05 44 35 00 00 	lea    0x3544(%rip),%rax        # 44b00 <console_clear+0x6c>
   415bc:	48 89 c7             	mov    %rax,%rdi
   415bf:	e8 c5 17 00 00       	call   42d89 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   415c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   415c8:	48 c1 e8 0c          	shr    $0xc,%rax
   415cc:	48 98                	cltq   
   415ce:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   415d2:	48 8d 05 68 18 01 00 	lea    0x11868(%rip),%rax        # 52e41 <pageinfo+0x1>
   415d9:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   415dd:	0f be c0             	movsbl %al,%eax
   415e0:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   415e3:	74 1e                	je     41603 <check_page_table_ownership_level+0xc4>
   415e5:	48 8d 05 14 37 00 00 	lea    0x3714(%rip),%rax        # 44d00 <console_clear+0x26c>
   415ec:	48 89 c2             	mov    %rax,%rdx
   415ef:	be 6a 02 00 00       	mov    $0x26a,%esi
   415f4:	48 8d 05 05 35 00 00 	lea    0x3505(%rip),%rax        # 44b00 <console_clear+0x6c>
   415fb:	48 89 c7             	mov    %rax,%rdi
   415fe:	e8 86 17 00 00       	call   42d89 <assert_fail>
    if (level < 3) {
   41603:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41607:	7f 5b                	jg     41664 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41609:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41610:	eb 49                	jmp    4165b <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   41612:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41616:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41619:	48 63 d2             	movslq %edx,%rdx
   4161c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41620:	48 85 c0             	test   %rax,%rax
   41623:	74 32                	je     41657 <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41625:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41629:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4162c:	48 63 d2             	movslq %edx,%rdx
   4162f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41633:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41639:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4163d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41640:	8d 70 01             	lea    0x1(%rax),%esi
   41643:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41646:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4164a:	b9 01 00 00 00       	mov    $0x1,%ecx
   4164f:	48 89 c7             	mov    %rax,%rdi
   41652:	e8 e8 fe ff ff       	call   4153f <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41657:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4165b:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41662:	7e ae                	jle    41612 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   41664:	90                   	nop
   41665:	c9                   	leave  
   41666:	c3                   	ret    

0000000000041667 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41667:	f3 0f 1e fa          	endbr64 
   4166b:	55                   	push   %rbp
   4166c:	48 89 e5             	mov    %rsp,%rbp
   4166f:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41673:	8b 05 6f 0a 01 00    	mov    0x10a6f(%rip),%eax        # 520e8 <processes+0xc8>
   41679:	85 c0                	test   %eax,%eax
   4167b:	74 1e                	je     4169b <check_virtual_memory+0x34>
   4167d:	48 8d 05 ac 36 00 00 	lea    0x36ac(%rip),%rax        # 44d30 <console_clear+0x29c>
   41684:	48 89 c2             	mov    %rax,%rdx
   41687:	be 7d 02 00 00       	mov    $0x27d,%esi
   4168c:	48 8d 05 6d 34 00 00 	lea    0x346d(%rip),%rax        # 44b00 <console_clear+0x6c>
   41693:	48 89 c7             	mov    %rax,%rdi
   41696:	e8 ee 16 00 00       	call   42d89 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4169b:	48 8b 05 5e 39 01 00 	mov    0x1395e(%rip),%rax        # 55000 <kernel_pagetable>
   416a2:	48 89 c7             	mov    %rax,%rdi
   416a5:	e8 51 fc ff ff       	call   412fb <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   416aa:	48 8b 05 4f 39 01 00 	mov    0x1394f(%rip),%rax        # 55000 <kernel_pagetable>
   416b1:	be ff ff ff ff       	mov    $0xffffffff,%esi
   416b6:	48 89 c7             	mov    %rax,%rdi
   416b9:	e8 c9 fd ff ff       	call   41487 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   416be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   416c5:	e9 b4 00 00 00       	jmp    4177e <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   416ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416cd:	48 63 d0             	movslq %eax,%rdx
   416d0:	48 89 d0             	mov    %rdx,%rax
   416d3:	48 c1 e0 03          	shl    $0x3,%rax
   416d7:	48 29 d0             	sub    %rdx,%rax
   416da:	48 c1 e0 05          	shl    $0x5,%rax
   416de:	48 89 c2             	mov    %rax,%rdx
   416e1:	48 8d 05 00 0a 01 00 	lea    0x10a00(%rip),%rax        # 520e8 <processes+0xc8>
   416e8:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   416eb:	85 c0                	test   %eax,%eax
   416ed:	0f 84 87 00 00 00    	je     4177a <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   416f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416f6:	48 63 d0             	movslq %eax,%rdx
   416f9:	48 89 d0             	mov    %rdx,%rax
   416fc:	48 c1 e0 03          	shl    $0x3,%rax
   41700:	48 29 d0             	sub    %rdx,%rax
   41703:	48 c1 e0 05          	shl    $0x5,%rax
   41707:	48 89 c2             	mov    %rax,%rdx
   4170a:	48 8d 05 df 09 01 00 	lea    0x109df(%rip),%rax        # 520f0 <processes+0xd0>
   41711:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   41715:	48 8b 05 e4 38 01 00 	mov    0x138e4(%rip),%rax        # 55000 <kernel_pagetable>
   4171c:	48 39 c2             	cmp    %rax,%rdx
   4171f:	74 59                	je     4177a <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   41721:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41724:	48 63 d0             	movslq %eax,%rdx
   41727:	48 89 d0             	mov    %rdx,%rax
   4172a:	48 c1 e0 03          	shl    $0x3,%rax
   4172e:	48 29 d0             	sub    %rdx,%rax
   41731:	48 c1 e0 05          	shl    $0x5,%rax
   41735:	48 89 c2             	mov    %rax,%rdx
   41738:	48 8d 05 b1 09 01 00 	lea    0x109b1(%rip),%rax        # 520f0 <processes+0xd0>
   4173f:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41743:	48 89 c7             	mov    %rax,%rdi
   41746:	e8 b0 fb ff ff       	call   412fb <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4174b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4174e:	48 63 d0             	movslq %eax,%rdx
   41751:	48 89 d0             	mov    %rdx,%rax
   41754:	48 c1 e0 03          	shl    $0x3,%rax
   41758:	48 29 d0             	sub    %rdx,%rax
   4175b:	48 c1 e0 05          	shl    $0x5,%rax
   4175f:	48 89 c2             	mov    %rax,%rdx
   41762:	48 8d 05 87 09 01 00 	lea    0x10987(%rip),%rax        # 520f0 <processes+0xd0>
   41769:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4176d:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41770:	89 d6                	mov    %edx,%esi
   41772:	48 89 c7             	mov    %rax,%rdi
   41775:	e8 0d fd ff ff       	call   41487 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   4177a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4177e:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41782:	0f 8e 42 ff ff ff    	jle    416ca <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41788:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4178f:	e9 8b 00 00 00       	jmp    4181f <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41794:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41797:	48 98                	cltq   
   41799:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4179d:	48 8d 05 9d 16 01 00 	lea    0x1169d(%rip),%rax        # 52e41 <pageinfo+0x1>
   417a4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   417a8:	84 c0                	test   %al,%al
   417aa:	7e 6f                	jle    4181b <check_virtual_memory+0x1b4>
   417ac:	8b 45 f8             	mov    -0x8(%rbp),%eax
   417af:	48 98                	cltq   
   417b1:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   417b5:	48 8d 05 84 16 01 00 	lea    0x11684(%rip),%rax        # 52e40 <pageinfo>
   417bc:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   417c0:	84 c0                	test   %al,%al
   417c2:	78 57                	js     4181b <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   417c4:	8b 45 f8             	mov    -0x8(%rbp),%eax
   417c7:	48 98                	cltq   
   417c9:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   417cd:	48 8d 05 6c 16 01 00 	lea    0x1166c(%rip),%rax        # 52e40 <pageinfo>
   417d4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   417d8:	0f be c0             	movsbl %al,%eax
   417db:	48 63 d0             	movslq %eax,%rdx
   417de:	48 89 d0             	mov    %rdx,%rax
   417e1:	48 c1 e0 03          	shl    $0x3,%rax
   417e5:	48 29 d0             	sub    %rdx,%rax
   417e8:	48 c1 e0 05          	shl    $0x5,%rax
   417ec:	48 89 c2             	mov    %rax,%rdx
   417ef:	48 8d 05 f2 08 01 00 	lea    0x108f2(%rip),%rax        # 520e8 <processes+0xc8>
   417f6:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   417f9:	85 c0                	test   %eax,%eax
   417fb:	75 1e                	jne    4181b <check_virtual_memory+0x1b4>
   417fd:	48 8d 05 4c 35 00 00 	lea    0x354c(%rip),%rax        # 44d50 <console_clear+0x2bc>
   41804:	48 89 c2             	mov    %rax,%rdx
   41807:	be 94 02 00 00       	mov    $0x294,%esi
   4180c:	48 8d 05 ed 32 00 00 	lea    0x32ed(%rip),%rax        # 44b00 <console_clear+0x6c>
   41813:	48 89 c7             	mov    %rax,%rdi
   41816:	e8 6e 15 00 00       	call   42d89 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4181b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4181f:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41826:	0f 8e 68 ff ff ff    	jle    41794 <check_virtual_memory+0x12d>
        }
    }
}
   4182c:	90                   	nop
   4182d:	90                   	nop
   4182e:	c9                   	leave  
   4182f:	c3                   	ret    

0000000000041830 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41830:	f3 0f 1e fa          	endbr64 
   41834:	55                   	push   %rbp
   41835:	48 89 e5             	mov    %rsp,%rbp
   41838:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4183c:	48 8d 05 63 35 00 00 	lea    0x3563(%rip),%rax        # 44da6 <memstate_colors+0x26>
   41843:	48 89 c2             	mov    %rax,%rdx
   41846:	be 00 0f 00 00       	mov    $0xf00,%esi
   4184b:	bf 20 00 00 00       	mov    $0x20,%edi
   41850:	b8 00 00 00 00       	mov    $0x0,%eax
   41855:	e8 c4 30 00 00       	call   4491e <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4185a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41861:	e9 1b 01 00 00       	jmp    41981 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   41866:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41869:	83 e0 3f             	and    $0x3f,%eax
   4186c:	85 c0                	test   %eax,%eax
   4186e:	75 40                	jne    418b0 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41870:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41873:	c1 e0 0c             	shl    $0xc,%eax
   41876:	89 c2                	mov    %eax,%edx
   41878:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4187b:	8d 48 3f             	lea    0x3f(%rax),%ecx
   4187e:	85 c0                	test   %eax,%eax
   41880:	0f 48 c1             	cmovs  %ecx,%eax
   41883:	c1 f8 06             	sar    $0x6,%eax
   41886:	8d 48 01             	lea    0x1(%rax),%ecx
   41889:	89 c8                	mov    %ecx,%eax
   4188b:	c1 e0 02             	shl    $0x2,%eax
   4188e:	01 c8                	add    %ecx,%eax
   41890:	c1 e0 04             	shl    $0x4,%eax
   41893:	83 c0 03             	add    $0x3,%eax
   41896:	89 d1                	mov    %edx,%ecx
   41898:	48 8d 15 17 35 00 00 	lea    0x3517(%rip),%rdx        # 44db6 <memstate_colors+0x36>
   4189f:	be 00 0f 00 00       	mov    $0xf00,%esi
   418a4:	89 c7                	mov    %eax,%edi
   418a6:	b8 00 00 00 00       	mov    $0x0,%eax
   418ab:	e8 6e 30 00 00       	call   4491e <console_printf>
        }

        int owner = pageinfo[pn].owner;
   418b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418b3:	48 98                	cltq   
   418b5:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   418b9:	48 8d 05 80 15 01 00 	lea    0x11580(%rip),%rax        # 52e40 <pageinfo>
   418c0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   418c4:	0f be c0             	movsbl %al,%eax
   418c7:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   418ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418cd:	48 98                	cltq   
   418cf:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   418d3:	48 8d 05 67 15 01 00 	lea    0x11567(%rip),%rax        # 52e41 <pageinfo+0x1>
   418da:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   418de:	84 c0                	test   %al,%al
   418e0:	75 07                	jne    418e9 <memshow_physical+0xb9>
            owner = PO_FREE;
   418e2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   418e9:	8b 45 f8             	mov    -0x8(%rbp),%eax
   418ec:	83 c0 02             	add    $0x2,%eax
   418ef:	48 98                	cltq   
   418f1:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   418f5:	48 8d 05 84 34 00 00 	lea    0x3484(%rip),%rax        # 44d80 <memstate_colors>
   418fc:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41900:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41904:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41907:	48 98                	cltq   
   41909:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4190d:	48 8d 05 2d 15 01 00 	lea    0x1152d(%rip),%rax        # 52e41 <pageinfo+0x1>
   41914:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41918:	3c 01                	cmp    $0x1,%al
   4191a:	7e 1c                	jle    41938 <memshow_physical+0x108>
   4191c:	48 8d 05 dd 66 07 00 	lea    0x766dd(%rip),%rax        # b8000 <console>
   41923:	48 c1 e8 0c          	shr    $0xc,%rax
   41927:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4192a:	74 0c                	je     41938 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4192c:	b8 53 00 00 00       	mov    $0x53,%eax
   41931:	80 cc 0f             	or     $0xf,%ah
   41934:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41938:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4193b:	8d 50 3f             	lea    0x3f(%rax),%edx
   4193e:	85 c0                	test   %eax,%eax
   41940:	0f 48 c2             	cmovs  %edx,%eax
   41943:	c1 f8 06             	sar    $0x6,%eax
   41946:	8d 50 01             	lea    0x1(%rax),%edx
   41949:	89 d0                	mov    %edx,%eax
   4194b:	c1 e0 02             	shl    $0x2,%eax
   4194e:	01 d0                	add    %edx,%eax
   41950:	c1 e0 04             	shl    $0x4,%eax
   41953:	89 c1                	mov    %eax,%ecx
   41955:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41958:	99                   	cltd   
   41959:	c1 ea 1a             	shr    $0x1a,%edx
   4195c:	01 d0                	add    %edx,%eax
   4195e:	83 e0 3f             	and    $0x3f,%eax
   41961:	29 d0                	sub    %edx,%eax
   41963:	83 c0 0c             	add    $0xc,%eax
   41966:	01 c8                	add    %ecx,%eax
   41968:	48 98                	cltq   
   4196a:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4196e:	48 8d 15 8b 66 07 00 	lea    0x7668b(%rip),%rdx        # b8000 <console>
   41975:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41979:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4197d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41981:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41988:	0f 8e d8 fe ff ff    	jle    41866 <memshow_physical+0x36>
    }
}
   4198e:	90                   	nop
   4198f:	90                   	nop
   41990:	c9                   	leave  
   41991:	c3                   	ret    

0000000000041992 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41992:	f3 0f 1e fa          	endbr64 
   41996:	55                   	push   %rbp
   41997:	48 89 e5             	mov    %rsp,%rbp
   4199a:	48 83 ec 40          	sub    $0x40,%rsp
   4199e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   419a2:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   419a6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   419aa:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   419b0:	48 89 c2             	mov    %rax,%rdx
   419b3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   419b7:	48 39 c2             	cmp    %rax,%rdx
   419ba:	74 1e                	je     419da <memshow_virtual+0x48>
   419bc:	48 8d 05 fd 33 00 00 	lea    0x33fd(%rip),%rax        # 44dc0 <memstate_colors+0x40>
   419c3:	48 89 c2             	mov    %rax,%rdx
   419c6:	be c5 02 00 00       	mov    $0x2c5,%esi
   419cb:	48 8d 05 2e 31 00 00 	lea    0x312e(%rip),%rax        # 44b00 <console_clear+0x6c>
   419d2:	48 89 c7             	mov    %rax,%rdi
   419d5:	e8 af 13 00 00       	call   42d89 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   419da:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   419de:	48 89 c1             	mov    %rax,%rcx
   419e1:	48 8d 05 05 34 00 00 	lea    0x3405(%rip),%rax        # 44ded <memstate_colors+0x6d>
   419e8:	48 89 c2             	mov    %rax,%rdx
   419eb:	be 00 0f 00 00       	mov    $0xf00,%esi
   419f0:	bf 3a 03 00 00       	mov    $0x33a,%edi
   419f5:	b8 00 00 00 00       	mov    $0x0,%eax
   419fa:	e8 1f 2f 00 00       	call   4491e <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   419ff:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41a06:	00 
   41a07:	e9 b4 01 00 00       	jmp    41bc0 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41a0c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41a10:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41a14:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41a18:	48 89 ce             	mov    %rcx,%rsi
   41a1b:	48 89 c7             	mov    %rax,%rdi
   41a1e:	e8 34 1b 00 00       	call   43557 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41a23:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41a26:	85 c0                	test   %eax,%eax
   41a28:	79 0b                	jns    41a35 <memshow_virtual+0xa3>
            color = ' ';
   41a2a:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41a30:	e9 ff 00 00 00       	jmp    41b34 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41a35:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41a39:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41a3f:	76 1e                	jbe    41a5f <memshow_virtual+0xcd>
   41a41:	48 8d 05 c2 33 00 00 	lea    0x33c2(%rip),%rax        # 44e0a <memstate_colors+0x8a>
   41a48:	48 89 c2             	mov    %rax,%rdx
   41a4b:	be ce 02 00 00       	mov    $0x2ce,%esi
   41a50:	48 8d 05 a9 30 00 00 	lea    0x30a9(%rip),%rax        # 44b00 <console_clear+0x6c>
   41a57:	48 89 c7             	mov    %rax,%rdi
   41a5a:	e8 2a 13 00 00       	call   42d89 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41a5f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41a62:	48 98                	cltq   
   41a64:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41a68:	48 8d 05 d1 13 01 00 	lea    0x113d1(%rip),%rax        # 52e40 <pageinfo>
   41a6f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41a73:	0f be c0             	movsbl %al,%eax
   41a76:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41a79:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41a7c:	48 98                	cltq   
   41a7e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41a82:	48 8d 05 b8 13 01 00 	lea    0x113b8(%rip),%rax        # 52e41 <pageinfo+0x1>
   41a89:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41a8d:	84 c0                	test   %al,%al
   41a8f:	75 07                	jne    41a98 <memshow_virtual+0x106>
                owner = PO_FREE;
   41a91:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41a98:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a9b:	83 c0 02             	add    $0x2,%eax
   41a9e:	48 98                	cltq   
   41aa0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41aa4:	48 8d 05 d5 32 00 00 	lea    0x32d5(%rip),%rax        # 44d80 <memstate_colors>
   41aab:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41aaf:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41ab3:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41ab6:	48 98                	cltq   
   41ab8:	83 e0 04             	and    $0x4,%eax
   41abb:	48 85 c0             	test   %rax,%rax
   41abe:	74 27                	je     41ae7 <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41ac0:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41ac4:	c1 e0 04             	shl    $0x4,%eax
   41ac7:	66 25 00 f0          	and    $0xf000,%ax
   41acb:	89 c2                	mov    %eax,%edx
   41acd:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41ad1:	c1 f8 04             	sar    $0x4,%eax
   41ad4:	66 25 00 0f          	and    $0xf00,%ax
   41ad8:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41ada:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41ade:	0f b6 c0             	movzbl %al,%eax
   41ae1:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41ae3:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41ae7:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41aea:	48 98                	cltq   
   41aec:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41af0:	48 8d 05 4a 13 01 00 	lea    0x1134a(%rip),%rax        # 52e41 <pageinfo+0x1>
   41af7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41afb:	3c 01                	cmp    $0x1,%al
   41afd:	7e 35                	jle    41b34 <memshow_virtual+0x1a2>
   41aff:	48 8d 05 fa 64 07 00 	lea    0x764fa(%rip),%rax        # b8000 <console>
   41b06:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41b0a:	74 28                	je     41b34 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41b0c:	b8 53 00 00 00       	mov    $0x53,%eax
   41b11:	89 c2                	mov    %eax,%edx
   41b13:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41b17:	66 25 00 f0          	and    $0xf000,%ax
   41b1b:	09 d0                	or     %edx,%eax
   41b1d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41b21:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41b24:	48 98                	cltq   
   41b26:	83 e0 04             	and    $0x4,%eax
   41b29:	48 85 c0             	test   %rax,%rax
   41b2c:	75 06                	jne    41b34 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   41b2e:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41b34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b38:	48 c1 e8 0c          	shr    $0xc,%rax
   41b3c:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41b3f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41b42:	83 e0 3f             	and    $0x3f,%eax
   41b45:	85 c0                	test   %eax,%eax
   41b47:	75 39                	jne    41b82 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41b49:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41b4c:	c1 e8 06             	shr    $0x6,%eax
   41b4f:	89 c2                	mov    %eax,%edx
   41b51:	89 d0                	mov    %edx,%eax
   41b53:	c1 e0 02             	shl    $0x2,%eax
   41b56:	01 d0                	add    %edx,%eax
   41b58:	c1 e0 04             	shl    $0x4,%eax
   41b5b:	05 73 03 00 00       	add    $0x373,%eax
   41b60:	89 c7                	mov    %eax,%edi
   41b62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b66:	48 89 c1             	mov    %rax,%rcx
   41b69:	48 8d 05 46 32 00 00 	lea    0x3246(%rip),%rax        # 44db6 <memstate_colors+0x36>
   41b70:	48 89 c2             	mov    %rax,%rdx
   41b73:	be 00 0f 00 00       	mov    $0xf00,%esi
   41b78:	b8 00 00 00 00       	mov    $0x0,%eax
   41b7d:	e8 9c 2d 00 00       	call   4491e <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41b82:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41b85:	c1 e8 06             	shr    $0x6,%eax
   41b88:	89 c2                	mov    %eax,%edx
   41b8a:	89 d0                	mov    %edx,%eax
   41b8c:	c1 e0 02             	shl    $0x2,%eax
   41b8f:	01 d0                	add    %edx,%eax
   41b91:	c1 e0 04             	shl    $0x4,%eax
   41b94:	89 c2                	mov    %eax,%edx
   41b96:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41b99:	83 e0 3f             	and    $0x3f,%eax
   41b9c:	01 d0                	add    %edx,%eax
   41b9e:	05 7c 03 00 00       	add    $0x37c,%eax
   41ba3:	89 c0                	mov    %eax,%eax
   41ba5:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41ba9:	48 8d 15 50 64 07 00 	lea    0x76450(%rip),%rdx        # b8000 <console>
   41bb0:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41bb4:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41bb8:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41bbf:	00 
   41bc0:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41bc7:	00 
   41bc8:	0f 86 3e fe ff ff    	jbe    41a0c <memshow_virtual+0x7a>
    }
}
   41bce:	90                   	nop
   41bcf:	90                   	nop
   41bd0:	c9                   	leave  
   41bd1:	c3                   	ret    

0000000000041bd2 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41bd2:	f3 0f 1e fa          	endbr64 
   41bd6:	55                   	push   %rbp
   41bd7:	48 89 e5             	mov    %rsp,%rbp
   41bda:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41bde:	8b 05 5c 16 01 00    	mov    0x1165c(%rip),%eax        # 53240 <last_ticks.1>
   41be4:	85 c0                	test   %eax,%eax
   41be6:	74 13                	je     41bfb <memshow_virtual_animate+0x29>
   41be8:	8b 05 32 12 01 00    	mov    0x11232(%rip),%eax        # 52e20 <ticks>
   41bee:	8b 15 4c 16 01 00    	mov    0x1164c(%rip),%edx        # 53240 <last_ticks.1>
   41bf4:	29 d0                	sub    %edx,%eax
   41bf6:	83 f8 31             	cmp    $0x31,%eax
   41bf9:	76 2c                	jbe    41c27 <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   41bfb:	8b 05 1f 12 01 00    	mov    0x1121f(%rip),%eax        # 52e20 <ticks>
   41c01:	89 05 39 16 01 00    	mov    %eax,0x11639(%rip)        # 53240 <last_ticks.1>
        ++showing;
   41c07:	8b 05 f7 43 00 00    	mov    0x43f7(%rip),%eax        # 46004 <showing.0>
   41c0d:	83 c0 01             	add    $0x1,%eax
   41c10:	89 05 ee 43 00 00    	mov    %eax,0x43ee(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41c16:	eb 0f                	jmp    41c27 <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41c18:	8b 05 e6 43 00 00    	mov    0x43e6(%rip),%eax        # 46004 <showing.0>
   41c1e:	83 c0 01             	add    $0x1,%eax
   41c21:	89 05 dd 43 00 00    	mov    %eax,0x43dd(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41c27:	8b 05 d7 43 00 00    	mov    0x43d7(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41c2d:	83 f8 20             	cmp    $0x20,%eax
   41c30:	7f 6b                	jg     41c9d <memshow_virtual_animate+0xcb>
   41c32:	8b 05 cc 43 00 00    	mov    0x43cc(%rip),%eax        # 46004 <showing.0>
   41c38:	99                   	cltd   
   41c39:	c1 ea 1c             	shr    $0x1c,%edx
   41c3c:	01 d0                	add    %edx,%eax
   41c3e:	83 e0 0f             	and    $0xf,%eax
   41c41:	29 d0                	sub    %edx,%eax
   41c43:	48 63 d0             	movslq %eax,%rdx
   41c46:	48 89 d0             	mov    %rdx,%rax
   41c49:	48 c1 e0 03          	shl    $0x3,%rax
   41c4d:	48 29 d0             	sub    %rdx,%rax
   41c50:	48 c1 e0 05          	shl    $0x5,%rax
   41c54:	48 89 c2             	mov    %rax,%rdx
   41c57:	48 8d 05 8a 04 01 00 	lea    0x1048a(%rip),%rax        # 520e8 <processes+0xc8>
   41c5e:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41c61:	85 c0                	test   %eax,%eax
   41c63:	74 b3                	je     41c18 <memshow_virtual_animate+0x46>
   41c65:	8b 05 99 43 00 00    	mov    0x4399(%rip),%eax        # 46004 <showing.0>
   41c6b:	99                   	cltd   
   41c6c:	c1 ea 1c             	shr    $0x1c,%edx
   41c6f:	01 d0                	add    %edx,%eax
   41c71:	83 e0 0f             	and    $0xf,%eax
   41c74:	29 d0                	sub    %edx,%eax
   41c76:	48 63 d0             	movslq %eax,%rdx
   41c79:	48 89 d0             	mov    %rdx,%rax
   41c7c:	48 c1 e0 03          	shl    $0x3,%rax
   41c80:	48 29 d0             	sub    %rdx,%rax
   41c83:	48 c1 e0 05          	shl    $0x5,%rax
   41c87:	48 89 c2             	mov    %rax,%rdx
   41c8a:	48 8d 05 67 04 01 00 	lea    0x10467(%rip),%rax        # 520f8 <processes+0xd8>
   41c91:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41c95:	84 c0                	test   %al,%al
   41c97:	0f 84 7b ff ff ff    	je     41c18 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   41c9d:	8b 05 61 43 00 00    	mov    0x4361(%rip),%eax        # 46004 <showing.0>
   41ca3:	99                   	cltd   
   41ca4:	c1 ea 1c             	shr    $0x1c,%edx
   41ca7:	01 d0                	add    %edx,%eax
   41ca9:	83 e0 0f             	and    $0xf,%eax
   41cac:	29 d0                	sub    %edx,%eax
   41cae:	89 05 50 43 00 00    	mov    %eax,0x4350(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41cb4:	8b 05 4a 43 00 00    	mov    0x434a(%rip),%eax        # 46004 <showing.0>
   41cba:	48 63 d0             	movslq %eax,%rdx
   41cbd:	48 89 d0             	mov    %rdx,%rax
   41cc0:	48 c1 e0 03          	shl    $0x3,%rax
   41cc4:	48 29 d0             	sub    %rdx,%rax
   41cc7:	48 c1 e0 05          	shl    $0x5,%rax
   41ccb:	48 89 c2             	mov    %rax,%rdx
   41cce:	48 8d 05 13 04 01 00 	lea    0x10413(%rip),%rax        # 520e8 <processes+0xc8>
   41cd5:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41cd8:	85 c0                	test   %eax,%eax
   41cda:	74 59                	je     41d35 <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41cdc:	8b 15 22 43 00 00    	mov    0x4322(%rip),%edx        # 46004 <showing.0>
   41ce2:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41ce6:	89 d1                	mov    %edx,%ecx
   41ce8:	48 8d 15 35 31 00 00 	lea    0x3135(%rip),%rdx        # 44e24 <memstate_colors+0xa4>
   41cef:	be 04 00 00 00       	mov    $0x4,%esi
   41cf4:	48 89 c7             	mov    %rax,%rdi
   41cf7:	b8 00 00 00 00       	mov    $0x0,%eax
   41cfc:	e8 38 2d 00 00       	call   44a39 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41d01:	8b 05 fd 42 00 00    	mov    0x42fd(%rip),%eax        # 46004 <showing.0>
   41d07:	48 63 d0             	movslq %eax,%rdx
   41d0a:	48 89 d0             	mov    %rdx,%rax
   41d0d:	48 c1 e0 03          	shl    $0x3,%rax
   41d11:	48 29 d0             	sub    %rdx,%rax
   41d14:	48 c1 e0 05          	shl    $0x5,%rax
   41d18:	48 89 c2             	mov    %rax,%rdx
   41d1b:	48 8d 05 ce 03 01 00 	lea    0x103ce(%rip),%rax        # 520f0 <processes+0xd0>
   41d22:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41d26:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41d2a:	48 89 d6             	mov    %rdx,%rsi
   41d2d:	48 89 c7             	mov    %rax,%rdi
   41d30:	e8 5d fc ff ff       	call   41992 <memshow_virtual>
    }
}
   41d35:	90                   	nop
   41d36:	c9                   	leave  
   41d37:	c3                   	ret    

0000000000041d38 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41d38:	f3 0f 1e fa          	endbr64 
   41d3c:	55                   	push   %rbp
   41d3d:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41d40:	e8 5f 01 00 00       	call   41ea4 <segments_init>
    interrupt_init();
   41d45:	e8 44 04 00 00       	call   4218e <interrupt_init>
    virtual_memory_init();
   41d4a:	e8 11 11 00 00       	call   42e60 <virtual_memory_init>
}
   41d4f:	90                   	nop
   41d50:	5d                   	pop    %rbp
   41d51:	c3                   	ret    

0000000000041d52 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41d52:	f3 0f 1e fa          	endbr64 
   41d56:	55                   	push   %rbp
   41d57:	48 89 e5             	mov    %rsp,%rbp
   41d5a:	48 83 ec 18          	sub    $0x18,%rsp
   41d5e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41d62:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41d66:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41d69:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41d6c:	48 98                	cltq   
   41d6e:	48 c1 e0 2d          	shl    $0x2d,%rax
   41d72:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41d76:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41d7d:	90 00 00 
   41d80:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41d83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d87:	48 89 10             	mov    %rdx,(%rax)
}
   41d8a:	90                   	nop
   41d8b:	c9                   	leave  
   41d8c:	c3                   	ret    

0000000000041d8d <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41d8d:	f3 0f 1e fa          	endbr64 
   41d91:	55                   	push   %rbp
   41d92:	48 89 e5             	mov    %rsp,%rbp
   41d95:	48 83 ec 28          	sub    $0x28,%rsp
   41d99:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41d9d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41da1:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41da4:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41da8:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41dac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41db0:	48 c1 e0 10          	shl    $0x10,%rax
   41db4:	48 89 c2             	mov    %rax,%rdx
   41db7:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41dbe:	00 00 00 
   41dc1:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41dc4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41dc8:	48 c1 e0 20          	shl    $0x20,%rax
   41dcc:	48 89 c1             	mov    %rax,%rcx
   41dcf:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41dd6:	00 00 ff 
   41dd9:	48 21 c8             	and    %rcx,%rax
   41ddc:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41ddf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41de3:	48 83 e8 01          	sub    $0x1,%rax
   41de7:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41dea:	48 09 d0             	or     %rdx,%rax
        | type
   41ded:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41df1:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41df4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41df7:	48 98                	cltq   
   41df9:	48 c1 e0 2d          	shl    $0x2d,%rax
   41dfd:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41e00:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41e07:	80 00 00 
   41e0a:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41e0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e11:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41e14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e18:	48 83 c0 08          	add    $0x8,%rax
   41e1c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41e20:	48 c1 ea 20          	shr    $0x20,%rdx
   41e24:	48 89 10             	mov    %rdx,(%rax)
}
   41e27:	90                   	nop
   41e28:	c9                   	leave  
   41e29:	c3                   	ret    

0000000000041e2a <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41e2a:	f3 0f 1e fa          	endbr64 
   41e2e:	55                   	push   %rbp
   41e2f:	48 89 e5             	mov    %rsp,%rbp
   41e32:	48 83 ec 20          	sub    $0x20,%rsp
   41e36:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e3a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41e3e:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41e41:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41e45:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41e49:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41e4c:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41e50:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41e53:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41e56:	48 98                	cltq   
   41e58:	48 c1 e0 2d          	shl    $0x2d,%rax
   41e5c:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41e5f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41e63:	48 c1 e0 20          	shl    $0x20,%rax
   41e67:	48 89 c1             	mov    %rax,%rcx
   41e6a:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41e71:	00 ff ff 
   41e74:	48 21 c8             	and    %rcx,%rax
   41e77:	48 09 c2             	or     %rax,%rdx
   41e7a:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41e81:	80 00 00 
   41e84:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41e87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e8b:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41e8e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41e92:	48 c1 e8 20          	shr    $0x20,%rax
   41e96:	48 89 c2             	mov    %rax,%rdx
   41e99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e9d:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41ea1:	90                   	nop
   41ea2:	c9                   	leave  
   41ea3:	c3                   	ret    

0000000000041ea4 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41ea4:	f3 0f 1e fa          	endbr64 
   41ea8:	55                   	push   %rbp
   41ea9:	48 89 e5             	mov    %rsp,%rbp
   41eac:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41eb0:	48 c7 05 a5 13 01 00 	movq   $0x0,0x113a5(%rip)        # 53260 <segments>
   41eb7:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41ebb:	ba 00 00 00 00       	mov    $0x0,%edx
   41ec0:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41ec7:	08 20 00 
   41eca:	48 89 c6             	mov    %rax,%rsi
   41ecd:	48 8d 05 94 13 01 00 	lea    0x11394(%rip),%rax        # 53268 <segments+0x8>
   41ed4:	48 89 c7             	mov    %rax,%rdi
   41ed7:	e8 76 fe ff ff       	call   41d52 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41edc:	ba 03 00 00 00       	mov    $0x3,%edx
   41ee1:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41ee8:	08 20 00 
   41eeb:	48 89 c6             	mov    %rax,%rsi
   41eee:	48 8d 05 7b 13 01 00 	lea    0x1137b(%rip),%rax        # 53270 <segments+0x10>
   41ef5:	48 89 c7             	mov    %rax,%rdi
   41ef8:	e8 55 fe ff ff       	call   41d52 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41efd:	ba 00 00 00 00       	mov    $0x0,%edx
   41f02:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41f09:	02 00 00 
   41f0c:	48 89 c6             	mov    %rax,%rsi
   41f0f:	48 8d 05 62 13 01 00 	lea    0x11362(%rip),%rax        # 53278 <segments+0x18>
   41f16:	48 89 c7             	mov    %rax,%rdi
   41f19:	e8 34 fe ff ff       	call   41d52 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41f1e:	ba 03 00 00 00       	mov    $0x3,%edx
   41f23:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41f2a:	02 00 00 
   41f2d:	48 89 c6             	mov    %rax,%rsi
   41f30:	48 8d 05 49 13 01 00 	lea    0x11349(%rip),%rax        # 53280 <segments+0x20>
   41f37:	48 89 c7             	mov    %rax,%rdi
   41f3a:	e8 13 fe ff ff       	call   41d52 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41f3f:	48 8d 05 5a 23 01 00 	lea    0x1235a(%rip),%rax        # 542a0 <kernel_task_descriptor>
   41f46:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41f4c:	48 89 c1             	mov    %rax,%rcx
   41f4f:	ba 00 00 00 00       	mov    $0x0,%edx
   41f54:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41f5b:	09 00 00 
   41f5e:	48 89 c6             	mov    %rax,%rsi
   41f61:	48 8d 05 20 13 01 00 	lea    0x11320(%rip),%rax        # 53288 <segments+0x28>
   41f68:	48 89 c7             	mov    %rax,%rdi
   41f6b:	e8 1d fe ff ff       	call   41d8d <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41f70:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41f76:	48 8d 05 e3 12 01 00 	lea    0x112e3(%rip),%rax        # 53260 <segments>
   41f7d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41f81:	ba 60 00 00 00       	mov    $0x60,%edx
   41f86:	be 00 00 00 00       	mov    $0x0,%esi
   41f8b:	48 8d 05 0e 23 01 00 	lea    0x1230e(%rip),%rax        # 542a0 <kernel_task_descriptor>
   41f92:	48 89 c7             	mov    %rax,%rdi
   41f95:	e8 45 1b 00 00       	call   43adf <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41f9a:	48 c7 05 ff 22 01 00 	movq   $0x80000,0x122ff(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41fa1:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41fa5:	ba 00 10 00 00       	mov    $0x1000,%edx
   41faa:	be 00 00 00 00       	mov    $0x0,%esi
   41faf:	48 8d 05 ea 12 01 00 	lea    0x112ea(%rip),%rax        # 532a0 <interrupt_descriptors>
   41fb6:	48 89 c7             	mov    %rax,%rdi
   41fb9:	e8 21 1b 00 00       	call   43adf <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41fbe:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41fc5:	eb 3c                	jmp    42003 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41fc7:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   41fce:	48 89 c2             	mov    %rax,%rdx
   41fd1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41fd4:	48 c1 e0 04          	shl    $0x4,%rax
   41fd8:	48 89 c1             	mov    %rax,%rcx
   41fdb:	48 8d 05 be 12 01 00 	lea    0x112be(%rip),%rax        # 532a0 <interrupt_descriptors>
   41fe2:	48 01 c8             	add    %rcx,%rax
   41fe5:	48 89 d1             	mov    %rdx,%rcx
   41fe8:	ba 00 00 00 00       	mov    $0x0,%edx
   41fed:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41ff4:	0e 00 00 
   41ff7:	48 89 c7             	mov    %rax,%rdi
   41ffa:	e8 2b fe ff ff       	call   41e2a <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41fff:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42003:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   4200a:	76 bb                	jbe    41fc7 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   4200c:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   42013:	48 89 c1             	mov    %rax,%rcx
   42016:	ba 00 00 00 00       	mov    $0x0,%edx
   4201b:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   42022:	0e 00 00 
   42025:	48 89 c6             	mov    %rax,%rsi
   42028:	48 8d 05 71 14 01 00 	lea    0x11471(%rip),%rax        # 534a0 <interrupt_descriptors+0x200>
   4202f:	48 89 c7             	mov    %rax,%rdi
   42032:	e8 f3 fd ff ff       	call   41e2a <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   42037:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   4203e:	48 89 c1             	mov    %rax,%rcx
   42041:	ba 00 00 00 00       	mov    $0x0,%edx
   42046:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4204d:	0e 00 00 
   42050:	48 89 c6             	mov    %rax,%rsi
   42053:	48 8d 05 16 13 01 00 	lea    0x11316(%rip),%rax        # 53370 <interrupt_descriptors+0xd0>
   4205a:	48 89 c7             	mov    %rax,%rdi
   4205d:	e8 c8 fd ff ff       	call   41e2a <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   42062:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   42069:	48 89 c1             	mov    %rax,%rcx
   4206c:	ba 00 00 00 00       	mov    $0x0,%edx
   42071:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   42078:	0e 00 00 
   4207b:	48 89 c6             	mov    %rax,%rsi
   4207e:	48 8d 05 fb 12 01 00 	lea    0x112fb(%rip),%rax        # 53380 <interrupt_descriptors+0xe0>
   42085:	48 89 c7             	mov    %rax,%rdi
   42088:	e8 9d fd ff ff       	call   41e2a <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4208d:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   42094:	eb 50                	jmp    420e6 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   42096:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42099:	83 e8 30             	sub    $0x30,%eax
   4209c:	89 c0                	mov    %eax,%eax
   4209e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   420a5:	00 
   420a6:	48 8d 05 3a e0 ff ff 	lea    -0x1fc6(%rip),%rax        # 400e7 <sys_int_handlers>
   420ad:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   420b1:	48 89 c2             	mov    %rax,%rdx
   420b4:	8b 45 f8             	mov    -0x8(%rbp),%eax
   420b7:	48 c1 e0 04          	shl    $0x4,%rax
   420bb:	48 89 c1             	mov    %rax,%rcx
   420be:	48 8d 05 db 11 01 00 	lea    0x111db(%rip),%rax        # 532a0 <interrupt_descriptors>
   420c5:	48 01 c8             	add    %rcx,%rax
   420c8:	48 89 d1             	mov    %rdx,%rcx
   420cb:	ba 03 00 00 00       	mov    $0x3,%edx
   420d0:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   420d7:	0e 00 00 
   420da:	48 89 c7             	mov    %rax,%rdi
   420dd:	e8 48 fd ff ff       	call   41e2a <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   420e2:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   420e6:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   420ea:	76 aa                	jbe    42096 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   420ec:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   420f2:	48 8d 05 a7 11 01 00 	lea    0x111a7(%rip),%rax        # 532a0 <interrupt_descriptors>
   420f9:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   420fd:	b8 28 00 00 00       	mov    $0x28,%eax
   42102:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   42106:	0f 00 d8             	ltr    %ax
   42109:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4210d:	0f 20 c0             	mov    %cr0,%rax
   42110:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   42114:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   42118:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   4211b:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   42122:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42125:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   42128:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4212b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   4212f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42133:	0f 22 c0             	mov    %rax,%cr0
}
   42136:	90                   	nop
    lcr0(cr0);
}
   42137:	90                   	nop
   42138:	c9                   	leave  
   42139:	c3                   	ret    

000000000004213a <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   4213a:	f3 0f 1e fa          	endbr64 
   4213e:	55                   	push   %rbp
   4213f:	48 89 e5             	mov    %rsp,%rbp
   42142:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   42146:	0f b7 05 b3 21 01 00 	movzwl 0x121b3(%rip),%eax        # 54300 <interrupts_enabled>
   4214d:	f7 d0                	not    %eax
   4214f:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   42153:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   42157:	0f b6 c0             	movzbl %al,%eax
   4215a:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   42161:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42164:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42168:	8b 55 f0             	mov    -0x10(%rbp),%edx
   4216b:	ee                   	out    %al,(%dx)
}
   4216c:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   4216d:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   42171:	66 c1 e8 08          	shr    $0x8,%ax
   42175:	0f b6 c0             	movzbl %al,%eax
   42178:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   4217f:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42182:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42186:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42189:	ee                   	out    %al,(%dx)
}
   4218a:	90                   	nop
}
   4218b:	90                   	nop
   4218c:	c9                   	leave  
   4218d:	c3                   	ret    

000000000004218e <interrupt_init>:

void interrupt_init(void) {
   4218e:	f3 0f 1e fa          	endbr64 
   42192:	55                   	push   %rbp
   42193:	48 89 e5             	mov    %rsp,%rbp
   42196:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   4219a:	66 c7 05 5d 21 01 00 	movw   $0x0,0x1215d(%rip)        # 54300 <interrupts_enabled>
   421a1:	00 00 
    interrupt_mask();
   421a3:	e8 92 ff ff ff       	call   4213a <interrupt_mask>
   421a8:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   421af:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421b3:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   421b7:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   421ba:	ee                   	out    %al,(%dx)
}
   421bb:	90                   	nop
   421bc:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   421c3:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421c7:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   421cb:	8b 55 ac             	mov    -0x54(%rbp),%edx
   421ce:	ee                   	out    %al,(%dx)
}
   421cf:	90                   	nop
   421d0:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   421d7:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421db:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   421df:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   421e2:	ee                   	out    %al,(%dx)
}
   421e3:	90                   	nop
   421e4:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   421eb:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421ef:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   421f3:	8b 55 bc             	mov    -0x44(%rbp),%edx
   421f6:	ee                   	out    %al,(%dx)
}
   421f7:	90                   	nop
   421f8:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   421ff:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42203:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   42207:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   4220a:	ee                   	out    %al,(%dx)
}
   4220b:	90                   	nop
   4220c:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   42213:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42217:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   4221b:	8b 55 cc             	mov    -0x34(%rbp),%edx
   4221e:	ee                   	out    %al,(%dx)
}
   4221f:	90                   	nop
   42220:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   42227:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4222b:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   4222f:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   42232:	ee                   	out    %al,(%dx)
}
   42233:	90                   	nop
   42234:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   4223b:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4223f:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   42243:	8b 55 dc             	mov    -0x24(%rbp),%edx
   42246:	ee                   	out    %al,(%dx)
}
   42247:	90                   	nop
   42248:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   4224f:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42253:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42257:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4225a:	ee                   	out    %al,(%dx)
}
   4225b:	90                   	nop
   4225c:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   42263:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42267:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4226b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4226e:	ee                   	out    %al,(%dx)
}
   4226f:	90                   	nop
   42270:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   42277:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4227b:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4227f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42282:	ee                   	out    %al,(%dx)
}
   42283:	90                   	nop
   42284:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   4228b:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4228f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42293:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42296:	ee                   	out    %al,(%dx)
}
   42297:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   42298:	e8 9d fe ff ff       	call   4213a <interrupt_mask>
}
   4229d:	90                   	nop
   4229e:	c9                   	leave  
   4229f:	c3                   	ret    

00000000000422a0 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   422a0:	f3 0f 1e fa          	endbr64 
   422a4:	55                   	push   %rbp
   422a5:	48 89 e5             	mov    %rsp,%rbp
   422a8:	48 83 ec 28          	sub    $0x28,%rsp
   422ac:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   422af:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   422b3:	0f 8e 9f 00 00 00    	jle    42358 <timer_init+0xb8>
   422b9:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   422c0:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422c4:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   422c8:	8b 55 ec             	mov    -0x14(%rbp),%edx
   422cb:	ee                   	out    %al,(%dx)
}
   422cc:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   422cd:	8b 45 dc             	mov    -0x24(%rbp),%eax
   422d0:	89 c2                	mov    %eax,%edx
   422d2:	c1 ea 1f             	shr    $0x1f,%edx
   422d5:	01 d0                	add    %edx,%eax
   422d7:	d1 f8                	sar    %eax
   422d9:	05 de 34 12 00       	add    $0x1234de,%eax
   422de:	99                   	cltd   
   422df:	f7 7d dc             	idivl  -0x24(%rbp)
   422e2:	89 c2                	mov    %eax,%edx
   422e4:	89 d0                	mov    %edx,%eax
   422e6:	c1 f8 1f             	sar    $0x1f,%eax
   422e9:	c1 e8 18             	shr    $0x18,%eax
   422ec:	89 c1                	mov    %eax,%ecx
   422ee:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   422f1:	0f b6 c0             	movzbl %al,%eax
   422f4:	29 c8                	sub    %ecx,%eax
   422f6:	0f b6 c0             	movzbl %al,%eax
   422f9:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   42300:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42303:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42307:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4230a:	ee                   	out    %al,(%dx)
}
   4230b:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   4230c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4230f:	89 c2                	mov    %eax,%edx
   42311:	c1 ea 1f             	shr    $0x1f,%edx
   42314:	01 d0                	add    %edx,%eax
   42316:	d1 f8                	sar    %eax
   42318:	05 de 34 12 00       	add    $0x1234de,%eax
   4231d:	99                   	cltd   
   4231e:	f7 7d dc             	idivl  -0x24(%rbp)
   42321:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42327:	85 c0                	test   %eax,%eax
   42329:	0f 48 c2             	cmovs  %edx,%eax
   4232c:	c1 f8 08             	sar    $0x8,%eax
   4232f:	0f b6 c0             	movzbl %al,%eax
   42332:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   42339:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4233c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42340:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42343:	ee                   	out    %al,(%dx)
}
   42344:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   42345:	0f b7 05 b4 1f 01 00 	movzwl 0x11fb4(%rip),%eax        # 54300 <interrupts_enabled>
   4234c:	83 c8 01             	or     $0x1,%eax
   4234f:	66 89 05 aa 1f 01 00 	mov    %ax,0x11faa(%rip)        # 54300 <interrupts_enabled>
   42356:	eb 11                	jmp    42369 <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   42358:	0f b7 05 a1 1f 01 00 	movzwl 0x11fa1(%rip),%eax        # 54300 <interrupts_enabled>
   4235f:	83 e0 fe             	and    $0xfffffffe,%eax
   42362:	66 89 05 97 1f 01 00 	mov    %ax,0x11f97(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   42369:	e8 cc fd ff ff       	call   4213a <interrupt_mask>
}
   4236e:	90                   	nop
   4236f:	c9                   	leave  
   42370:	c3                   	ret    

0000000000042371 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   42371:	f3 0f 1e fa          	endbr64 
   42375:	55                   	push   %rbp
   42376:	48 89 e5             	mov    %rsp,%rbp
   42379:	48 83 ec 08          	sub    $0x8,%rsp
   4237d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   42381:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   42386:	74 14                	je     4239c <physical_memory_isreserved+0x2b>
   42388:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   4238f:	00 
   42390:	76 11                	jbe    423a3 <physical_memory_isreserved+0x32>
   42392:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   42399:	00 
   4239a:	77 07                	ja     423a3 <physical_memory_isreserved+0x32>
   4239c:	b8 01 00 00 00       	mov    $0x1,%eax
   423a1:	eb 05                	jmp    423a8 <physical_memory_isreserved+0x37>
   423a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
   423a8:	c9                   	leave  
   423a9:	c3                   	ret    

00000000000423aa <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   423aa:	f3 0f 1e fa          	endbr64 
   423ae:	55                   	push   %rbp
   423af:	48 89 e5             	mov    %rsp,%rbp
   423b2:	48 83 ec 10          	sub    $0x10,%rsp
   423b6:	89 7d fc             	mov    %edi,-0x4(%rbp)
   423b9:	89 75 f8             	mov    %esi,-0x8(%rbp)
   423bc:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   423bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423c2:	c1 e0 10             	shl    $0x10,%eax
   423c5:	89 c2                	mov    %eax,%edx
   423c7:	8b 45 f8             	mov    -0x8(%rbp),%eax
   423ca:	c1 e0 0b             	shl    $0xb,%eax
   423cd:	09 c2                	or     %eax,%edx
   423cf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   423d2:	c1 e0 08             	shl    $0x8,%eax
   423d5:	09 d0                	or     %edx,%eax
}
   423d7:	c9                   	leave  
   423d8:	c3                   	ret    

00000000000423d9 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   423d9:	f3 0f 1e fa          	endbr64 
   423dd:	55                   	push   %rbp
   423de:	48 89 e5             	mov    %rsp,%rbp
   423e1:	48 83 ec 18          	sub    $0x18,%rsp
   423e5:	89 7d ec             	mov    %edi,-0x14(%rbp)
   423e8:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   423eb:	8b 55 ec             	mov    -0x14(%rbp),%edx
   423ee:	8b 45 e8             	mov    -0x18(%rbp),%eax
   423f1:	09 d0                	or     %edx,%eax
   423f3:	0d 00 00 00 80       	or     $0x80000000,%eax
   423f8:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   423ff:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42402:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42405:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42408:	ef                   	out    %eax,(%dx)
}
   42409:	90                   	nop
   4240a:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42411:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42414:	89 c2                	mov    %eax,%edx
   42416:	ed                   	in     (%dx),%eax
   42417:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   4241a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   4241d:	c9                   	leave  
   4241e:	c3                   	ret    

000000000004241f <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   4241f:	f3 0f 1e fa          	endbr64 
   42423:	55                   	push   %rbp
   42424:	48 89 e5             	mov    %rsp,%rbp
   42427:	48 83 ec 28          	sub    $0x28,%rsp
   4242b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4242e:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42431:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42438:	eb 73                	jmp    424ad <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   4243a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   42441:	eb 60                	jmp    424a3 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   42443:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4244a:	eb 4a                	jmp    42496 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   4244c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4244f:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   42452:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42455:	89 ce                	mov    %ecx,%esi
   42457:	89 c7                	mov    %eax,%edi
   42459:	e8 4c ff ff ff       	call   423aa <pci_make_configaddr>
   4245e:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   42461:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42464:	be 00 00 00 00       	mov    $0x0,%esi
   42469:	89 c7                	mov    %eax,%edi
   4246b:	e8 69 ff ff ff       	call   423d9 <pci_config_readl>
   42470:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   42473:	8b 45 d8             	mov    -0x28(%rbp),%eax
   42476:	c1 e0 10             	shl    $0x10,%eax
   42479:	0b 45 dc             	or     -0x24(%rbp),%eax
   4247c:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   4247f:	75 05                	jne    42486 <pci_find_device+0x67>
                    return configaddr;
   42481:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42484:	eb 35                	jmp    424bb <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   42486:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   4248a:	75 06                	jne    42492 <pci_find_device+0x73>
   4248c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42490:	74 0c                	je     4249e <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   42492:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42496:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   4249a:	75 b0                	jne    4244c <pci_find_device+0x2d>
   4249c:	eb 01                	jmp    4249f <pci_find_device+0x80>
                    break;
   4249e:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   4249f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   424a3:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   424a7:	75 9a                	jne    42443 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   424a9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   424ad:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   424b4:	75 84                	jne    4243a <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   424b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   424bb:	c9                   	leave  
   424bc:	c3                   	ret    

00000000000424bd <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   424bd:	f3 0f 1e fa          	endbr64 
   424c1:	55                   	push   %rbp
   424c2:	48 89 e5             	mov    %rsp,%rbp
   424c5:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   424c9:	be 13 71 00 00       	mov    $0x7113,%esi
   424ce:	bf 86 80 00 00       	mov    $0x8086,%edi
   424d3:	e8 47 ff ff ff       	call   4241f <pci_find_device>
   424d8:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   424db:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   424df:	78 30                	js     42511 <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   424e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   424e4:	be 40 00 00 00       	mov    $0x40,%esi
   424e9:	89 c7                	mov    %eax,%edi
   424eb:	e8 e9 fe ff ff       	call   423d9 <pci_config_readl>
   424f0:	25 c0 ff 00 00       	and    $0xffc0,%eax
   424f5:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   424f8:	8b 45 f8             	mov    -0x8(%rbp),%eax
   424fb:	83 c0 04             	add    $0x4,%eax
   424fe:	89 45 f4             	mov    %eax,-0xc(%rbp)
   42501:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42507:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   4250b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4250e:	66 ef                	out    %ax,(%dx)
}
   42510:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42511:	48 8d 05 28 29 00 00 	lea    0x2928(%rip),%rax        # 44e40 <memstate_colors+0xc0>
   42518:	48 89 c2             	mov    %rax,%rdx
   4251b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42520:	bf 80 07 00 00       	mov    $0x780,%edi
   42525:	b8 00 00 00 00       	mov    $0x0,%eax
   4252a:	e8 ef 23 00 00       	call   4491e <console_printf>
 spinloop: goto spinloop;
   4252f:	eb fe                	jmp    4252f <poweroff+0x72>

0000000000042531 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   42531:	f3 0f 1e fa          	endbr64 
   42535:	55                   	push   %rbp
   42536:	48 89 e5             	mov    %rsp,%rbp
   42539:	48 83 ec 10          	sub    $0x10,%rsp
   4253d:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42544:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42548:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4254c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4254f:	ee                   	out    %al,(%dx)
}
   42550:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   42551:	eb fe                	jmp    42551 <reboot+0x20>

0000000000042553 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42553:	f3 0f 1e fa          	endbr64 
   42557:	55                   	push   %rbp
   42558:	48 89 e5             	mov    %rsp,%rbp
   4255b:	48 83 ec 10          	sub    $0x10,%rsp
   4255f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42563:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   42566:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4256a:	48 83 c0 08          	add    $0x8,%rax
   4256e:	ba c0 00 00 00       	mov    $0xc0,%edx
   42573:	be 00 00 00 00       	mov    $0x0,%esi
   42578:	48 89 c7             	mov    %rax,%rdi
   4257b:	e8 5f 15 00 00       	call   43adf <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   42580:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42584:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   4258b:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   4258d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42591:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   42598:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   4259c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425a0:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   425a7:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   425ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425af:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   425b6:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   425b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425bc:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   425c3:	00 02 00 00 
    p->display_status = 1;
   425c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425cb:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   425d2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   425d5:	83 e0 01             	and    $0x1,%eax
   425d8:	85 c0                	test   %eax,%eax
   425da:	74 1c                	je     425f8 <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   425dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425e0:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   425e7:	80 cc 30             	or     $0x30,%ah
   425ea:	48 89 c2             	mov    %rax,%rdx
   425ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425f1:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   425f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   425fb:	83 e0 02             	and    $0x2,%eax
   425fe:	85 c0                	test   %eax,%eax
   42600:	74 1c                	je     4261e <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42602:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42606:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4260d:	80 e4 fd             	and    $0xfd,%ah
   42610:	48 89 c2             	mov    %rax,%rdx
   42613:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42617:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   4261e:	90                   	nop
   4261f:	c9                   	leave  
   42620:	c3                   	ret    

0000000000042621 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42621:	f3 0f 1e fa          	endbr64 
   42625:	55                   	push   %rbp
   42626:	48 89 e5             	mov    %rsp,%rbp
   42629:	48 83 ec 28          	sub    $0x28,%rsp
   4262d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42630:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42634:	78 09                	js     4263f <console_show_cursor+0x1e>
   42636:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4263d:	7e 07                	jle    42646 <console_show_cursor+0x25>
        cpos = 0;
   4263f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42646:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4264d:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42651:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42655:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42658:	ee                   	out    %al,(%dx)
}
   42659:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   4265a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4265d:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42663:	85 c0                	test   %eax,%eax
   42665:	0f 48 c2             	cmovs  %edx,%eax
   42668:	c1 f8 08             	sar    $0x8,%eax
   4266b:	0f b6 c0             	movzbl %al,%eax
   4266e:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42675:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42678:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4267c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4267f:	ee                   	out    %al,(%dx)
}
   42680:	90                   	nop
   42681:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42688:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4268c:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42690:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42693:	ee                   	out    %al,(%dx)
}
   42694:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42695:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42698:	99                   	cltd   
   42699:	c1 ea 18             	shr    $0x18,%edx
   4269c:	01 d0                	add    %edx,%eax
   4269e:	0f b6 c0             	movzbl %al,%eax
   426a1:	29 d0                	sub    %edx,%eax
   426a3:	0f b6 c0             	movzbl %al,%eax
   426a6:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   426ad:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426b0:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   426b4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   426b7:	ee                   	out    %al,(%dx)
}
   426b8:	90                   	nop
}
   426b9:	90                   	nop
   426ba:	c9                   	leave  
   426bb:	c3                   	ret    

00000000000426bc <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   426bc:	f3 0f 1e fa          	endbr64 
   426c0:	55                   	push   %rbp
   426c1:	48 89 e5             	mov    %rsp,%rbp
   426c4:	48 83 ec 20          	sub    $0x20,%rsp
   426c8:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   426cf:	8b 45 f0             	mov    -0x10(%rbp),%eax
   426d2:	89 c2                	mov    %eax,%edx
   426d4:	ec                   	in     (%dx),%al
   426d5:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   426d8:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   426dc:	0f b6 c0             	movzbl %al,%eax
   426df:	83 e0 01             	and    $0x1,%eax
   426e2:	85 c0                	test   %eax,%eax
   426e4:	75 0a                	jne    426f0 <keyboard_readc+0x34>
        return -1;
   426e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   426eb:	e9 fd 01 00 00       	jmp    428ed <keyboard_readc+0x231>
   426f0:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   426f7:	8b 45 e8             	mov    -0x18(%rbp),%eax
   426fa:	89 c2                	mov    %eax,%edx
   426fc:	ec                   	in     (%dx),%al
   426fd:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42700:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42704:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42707:	0f b6 05 f4 1b 01 00 	movzbl 0x11bf4(%rip),%eax        # 54302 <last_escape.2>
   4270e:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42711:	c6 05 ea 1b 01 00 00 	movb   $0x0,0x11bea(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42718:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4271c:	75 11                	jne    4272f <keyboard_readc+0x73>
        last_escape = 0x80;
   4271e:	c6 05 dd 1b 01 00 80 	movb   $0x80,0x11bdd(%rip)        # 54302 <last_escape.2>
        return 0;
   42725:	b8 00 00 00 00       	mov    $0x0,%eax
   4272a:	e9 be 01 00 00       	jmp    428ed <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4272f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42733:	84 c0                	test   %al,%al
   42735:	79 64                	jns    4279b <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   42737:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4273b:	83 e0 7f             	and    $0x7f,%eax
   4273e:	89 c2                	mov    %eax,%edx
   42740:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42744:	09 d0                	or     %edx,%eax
   42746:	48 98                	cltq   
   42748:	48 8d 15 11 27 00 00 	lea    0x2711(%rip),%rdx        # 44e60 <keymap>
   4274f:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42753:	0f b6 c0             	movzbl %al,%eax
   42756:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42759:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42760:	7e 2f                	jle    42791 <keyboard_readc+0xd5>
   42762:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42769:	7f 26                	jg     42791 <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   4276b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4276e:	2d fa 00 00 00       	sub    $0xfa,%eax
   42773:	ba 01 00 00 00       	mov    $0x1,%edx
   42778:	89 c1                	mov    %eax,%ecx
   4277a:	d3 e2                	shl    %cl,%edx
   4277c:	89 d0                	mov    %edx,%eax
   4277e:	f7 d0                	not    %eax
   42780:	89 c2                	mov    %eax,%edx
   42782:	0f b6 05 7a 1b 01 00 	movzbl 0x11b7a(%rip),%eax        # 54303 <modifiers.1>
   42789:	21 d0                	and    %edx,%eax
   4278b:	88 05 72 1b 01 00    	mov    %al,0x11b72(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   42791:	b8 00 00 00 00       	mov    $0x0,%eax
   42796:	e9 52 01 00 00       	jmp    428ed <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   4279b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4279f:	0a 45 fa             	or     -0x6(%rbp),%al
   427a2:	0f b6 c0             	movzbl %al,%eax
   427a5:	48 98                	cltq   
   427a7:	48 8d 15 b2 26 00 00 	lea    0x26b2(%rip),%rdx        # 44e60 <keymap>
   427ae:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   427b2:	0f b6 c0             	movzbl %al,%eax
   427b5:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   427b8:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   427bc:	7e 57                	jle    42815 <keyboard_readc+0x159>
   427be:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   427c2:	7f 51                	jg     42815 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   427c4:	0f b6 05 38 1b 01 00 	movzbl 0x11b38(%rip),%eax        # 54303 <modifiers.1>
   427cb:	0f b6 c0             	movzbl %al,%eax
   427ce:	83 e0 02             	and    $0x2,%eax
   427d1:	85 c0                	test   %eax,%eax
   427d3:	74 09                	je     427de <keyboard_readc+0x122>
            ch -= 0x60;
   427d5:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   427d9:	e9 0b 01 00 00       	jmp    428e9 <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   427de:	0f b6 05 1e 1b 01 00 	movzbl 0x11b1e(%rip),%eax        # 54303 <modifiers.1>
   427e5:	0f b6 c0             	movzbl %al,%eax
   427e8:	83 e0 01             	and    $0x1,%eax
   427eb:	85 c0                	test   %eax,%eax
   427ed:	0f 94 c2             	sete   %dl
   427f0:	0f b6 05 0c 1b 01 00 	movzbl 0x11b0c(%rip),%eax        # 54303 <modifiers.1>
   427f7:	0f b6 c0             	movzbl %al,%eax
   427fa:	83 e0 08             	and    $0x8,%eax
   427fd:	85 c0                	test   %eax,%eax
   427ff:	0f 94 c0             	sete   %al
   42802:	31 d0                	xor    %edx,%eax
   42804:	84 c0                	test   %al,%al
   42806:	0f 84 dd 00 00 00    	je     428e9 <keyboard_readc+0x22d>
            ch -= 0x20;
   4280c:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42810:	e9 d4 00 00 00       	jmp    428e9 <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42815:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4281c:	7e 30                	jle    4284e <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4281e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42821:	2d fa 00 00 00       	sub    $0xfa,%eax
   42826:	ba 01 00 00 00       	mov    $0x1,%edx
   4282b:	89 c1                	mov    %eax,%ecx
   4282d:	d3 e2                	shl    %cl,%edx
   4282f:	89 d0                	mov    %edx,%eax
   42831:	89 c2                	mov    %eax,%edx
   42833:	0f b6 05 c9 1a 01 00 	movzbl 0x11ac9(%rip),%eax        # 54303 <modifiers.1>
   4283a:	31 d0                	xor    %edx,%eax
   4283c:	88 05 c1 1a 01 00    	mov    %al,0x11ac1(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42842:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42849:	e9 9c 00 00 00       	jmp    428ea <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   4284e:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42855:	7e 2d                	jle    42884 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42857:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4285a:	2d fa 00 00 00       	sub    $0xfa,%eax
   4285f:	ba 01 00 00 00       	mov    $0x1,%edx
   42864:	89 c1                	mov    %eax,%ecx
   42866:	d3 e2                	shl    %cl,%edx
   42868:	89 d0                	mov    %edx,%eax
   4286a:	89 c2                	mov    %eax,%edx
   4286c:	0f b6 05 90 1a 01 00 	movzbl 0x11a90(%rip),%eax        # 54303 <modifiers.1>
   42873:	09 d0                	or     %edx,%eax
   42875:	88 05 88 1a 01 00    	mov    %al,0x11a88(%rip)        # 54303 <modifiers.1>
        ch = 0;
   4287b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42882:	eb 66                	jmp    428ea <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42884:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42888:	7e 3f                	jle    428c9 <keyboard_readc+0x20d>
   4288a:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42891:	7f 36                	jg     428c9 <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42893:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42896:	8d 50 80             	lea    -0x80(%rax),%edx
   42899:	0f b6 05 63 1a 01 00 	movzbl 0x11a63(%rip),%eax        # 54303 <modifiers.1>
   428a0:	0f b6 c0             	movzbl %al,%eax
   428a3:	83 e0 03             	and    $0x3,%eax
   428a6:	48 63 c8             	movslq %eax,%rcx
   428a9:	48 63 c2             	movslq %edx,%rax
   428ac:	48 c1 e0 02          	shl    $0x2,%rax
   428b0:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   428b4:	48 8d 05 a5 26 00 00 	lea    0x26a5(%rip),%rax        # 44f60 <complex_keymap>
   428bb:	48 01 d0             	add    %rdx,%rax
   428be:	0f b6 00             	movzbl (%rax),%eax
   428c1:	0f b6 c0             	movzbl %al,%eax
   428c4:	89 45 fc             	mov    %eax,-0x4(%rbp)
   428c7:	eb 21                	jmp    428ea <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   428c9:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   428cd:	7f 1b                	jg     428ea <keyboard_readc+0x22e>
   428cf:	0f b6 05 2d 1a 01 00 	movzbl 0x11a2d(%rip),%eax        # 54303 <modifiers.1>
   428d6:	0f b6 c0             	movzbl %al,%eax
   428d9:	83 e0 02             	and    $0x2,%eax
   428dc:	85 c0                	test   %eax,%eax
   428de:	74 0a                	je     428ea <keyboard_readc+0x22e>
        ch = 0;
   428e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   428e7:	eb 01                	jmp    428ea <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   428e9:	90                   	nop
    }

    return ch;
   428ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   428ed:	c9                   	leave  
   428ee:	c3                   	ret    

00000000000428ef <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   428ef:	f3 0f 1e fa          	endbr64 
   428f3:	55                   	push   %rbp
   428f4:	48 89 e5             	mov    %rsp,%rbp
   428f7:	48 83 ec 20          	sub    $0x20,%rsp
   428fb:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42902:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42905:	89 c2                	mov    %eax,%edx
   42907:	ec                   	in     (%dx),%al
   42908:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4290b:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42912:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42915:	89 c2                	mov    %eax,%edx
   42917:	ec                   	in     (%dx),%al
   42918:	88 45 eb             	mov    %al,-0x15(%rbp)
   4291b:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42922:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42925:	89 c2                	mov    %eax,%edx
   42927:	ec                   	in     (%dx),%al
   42928:	88 45 f3             	mov    %al,-0xd(%rbp)
   4292b:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42932:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42935:	89 c2                	mov    %eax,%edx
   42937:	ec                   	in     (%dx),%al
   42938:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4293b:	90                   	nop
   4293c:	c9                   	leave  
   4293d:	c3                   	ret    

000000000004293e <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4293e:	f3 0f 1e fa          	endbr64 
   42942:	55                   	push   %rbp
   42943:	48 89 e5             	mov    %rsp,%rbp
   42946:	48 83 ec 40          	sub    $0x40,%rsp
   4294a:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4294e:	89 f0                	mov    %esi,%eax
   42950:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42953:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42956:	8b 05 a8 19 01 00    	mov    0x119a8(%rip),%eax        # 54304 <initialized.0>
   4295c:	85 c0                	test   %eax,%eax
   4295e:	75 1e                	jne    4297e <parallel_port_putc+0x40>
   42960:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42967:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4296b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4296f:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42972:	ee                   	out    %al,(%dx)
}
   42973:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42974:	c7 05 86 19 01 00 01 	movl   $0x1,0x11986(%rip)        # 54304 <initialized.0>
   4297b:	00 00 00 
    }

    for (int i = 0;
   4297e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42985:	eb 09                	jmp    42990 <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42987:	e8 63 ff ff ff       	call   428ef <delay>
         ++i) {
   4298c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42990:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42997:	7f 18                	jg     429b1 <parallel_port_putc+0x73>
   42999:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   429a0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   429a3:	89 c2                	mov    %eax,%edx
   429a5:	ec                   	in     (%dx),%al
   429a6:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   429a9:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   429ad:	84 c0                	test   %al,%al
   429af:	79 d6                	jns    42987 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   429b1:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   429b5:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   429bc:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   429bf:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   429c3:	8b 55 d8             	mov    -0x28(%rbp),%edx
   429c6:	ee                   	out    %al,(%dx)
}
   429c7:	90                   	nop
   429c8:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   429cf:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   429d3:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   429d7:	8b 55 e0             	mov    -0x20(%rbp),%edx
   429da:	ee                   	out    %al,(%dx)
}
   429db:	90                   	nop
   429dc:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   429e3:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   429e7:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   429eb:	8b 55 e8             	mov    -0x18(%rbp),%edx
   429ee:	ee                   	out    %al,(%dx)
}
   429ef:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   429f0:	90                   	nop
   429f1:	c9                   	leave  
   429f2:	c3                   	ret    

00000000000429f3 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   429f3:	f3 0f 1e fa          	endbr64 
   429f7:	55                   	push   %rbp
   429f8:	48 89 e5             	mov    %rsp,%rbp
   429fb:	48 83 ec 20          	sub    $0x20,%rsp
   429ff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42a03:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42a07:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 4293e <parallel_port_putc>
   42a0e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   42a12:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42a16:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42a1a:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42a1e:	be 00 00 00 00       	mov    $0x0,%esi
   42a23:	48 89 c7             	mov    %rax,%rdi
   42a26:	e8 7a 13 00 00       	call   43da5 <printer_vprintf>
}
   42a2b:	90                   	nop
   42a2c:	c9                   	leave  
   42a2d:	c3                   	ret    

0000000000042a2e <log_printf>:

void log_printf(const char* format, ...) {
   42a2e:	f3 0f 1e fa          	endbr64 
   42a32:	55                   	push   %rbp
   42a33:	48 89 e5             	mov    %rsp,%rbp
   42a36:	48 83 ec 60          	sub    $0x60,%rsp
   42a3a:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42a3e:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42a42:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42a46:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42a4a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42a4e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42a52:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42a59:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42a5d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42a61:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42a65:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42a69:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42a6d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42a71:	48 89 d6             	mov    %rdx,%rsi
   42a74:	48 89 c7             	mov    %rax,%rdi
   42a77:	e8 77 ff ff ff       	call   429f3 <log_vprintf>
    va_end(val);
}
   42a7c:	90                   	nop
   42a7d:	c9                   	leave  
   42a7e:	c3                   	ret    

0000000000042a7f <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42a7f:	f3 0f 1e fa          	endbr64 
   42a83:	55                   	push   %rbp
   42a84:	48 89 e5             	mov    %rsp,%rbp
   42a87:	48 83 ec 40          	sub    $0x40,%rsp
   42a8b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42a8e:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42a91:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42a95:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42a99:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42a9d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42aa1:	48 8b 0a             	mov    (%rdx),%rcx
   42aa4:	48 89 08             	mov    %rcx,(%rax)
   42aa7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42aab:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42aaf:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42ab3:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42ab7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42abb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42abf:	48 89 d6             	mov    %rdx,%rsi
   42ac2:	48 89 c7             	mov    %rax,%rdi
   42ac5:	e8 29 ff ff ff       	call   429f3 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42aca:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42ace:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42ad2:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42ad5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42ad8:	89 c7                	mov    %eax,%edi
   42ada:	e8 c3 1d 00 00       	call   448a2 <console_vprintf>
}
   42adf:	c9                   	leave  
   42ae0:	c3                   	ret    

0000000000042ae1 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42ae1:	f3 0f 1e fa          	endbr64 
   42ae5:	55                   	push   %rbp
   42ae6:	48 89 e5             	mov    %rsp,%rbp
   42ae9:	48 83 ec 60          	sub    $0x60,%rsp
   42aed:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42af0:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42af3:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42af7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42afb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42aff:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42b03:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42b0a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42b0e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42b12:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42b16:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42b1a:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42b1e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42b22:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42b25:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b28:	89 c7                	mov    %eax,%edi
   42b2a:	e8 50 ff ff ff       	call   42a7f <error_vprintf>
   42b2f:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42b32:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42b35:	c9                   	leave  
   42b36:	c3                   	ret    

0000000000042b37 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42b37:	f3 0f 1e fa          	endbr64 
   42b3b:	55                   	push   %rbp
   42b3c:	48 89 e5             	mov    %rsp,%rbp
   42b3f:	53                   	push   %rbx
   42b40:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42b44:	e8 73 fb ff ff       	call   426bc <keyboard_readc>
   42b49:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42b4c:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42b50:	74 1c                	je     42b6e <check_keyboard+0x37>
   42b52:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42b56:	74 16                	je     42b6e <check_keyboard+0x37>
   42b58:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42b5c:	74 10                	je     42b6e <check_keyboard+0x37>
   42b5e:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42b62:	74 0a                	je     42b6e <check_keyboard+0x37>
   42b64:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42b68:	0f 85 02 01 00 00    	jne    42c70 <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42b6e:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42b75:	00 
        memset(pt, 0, PAGESIZE * 3);
   42b76:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b7a:	ba 00 30 00 00       	mov    $0x3000,%edx
   42b7f:	be 00 00 00 00       	mov    $0x0,%esi
   42b84:	48 89 c7             	mov    %rax,%rdi
   42b87:	e8 53 0f 00 00       	call   43adf <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42b8c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b90:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42b97:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b9b:	48 05 00 10 00 00    	add    $0x1000,%rax
   42ba1:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42ba8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bac:	48 05 00 20 00 00    	add    $0x2000,%rax
   42bb2:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42bb9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bbd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42bc1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42bc5:	0f 22 d8             	mov    %rax,%cr3
}
   42bc8:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42bc9:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42bd0:	48 8d 05 e1 23 00 00 	lea    0x23e1(%rip),%rax        # 44fb8 <complex_keymap+0x58>
   42bd7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   42bdb:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42bdf:	75 0d                	jne    42bee <check_keyboard+0xb7>
            argument = "allocator";
   42be1:	48 8d 05 d5 23 00 00 	lea    0x23d5(%rip),%rax        # 44fbd <complex_keymap+0x5d>
   42be8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42bec:	eb 37                	jmp    42c25 <check_keyboard+0xee>
        } else if (c == 'e') {
   42bee:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42bf2:	75 0d                	jne    42c01 <check_keyboard+0xca>
            argument = "forkexit";
   42bf4:	48 8d 05 cc 23 00 00 	lea    0x23cc(%rip),%rax        # 44fc7 <complex_keymap+0x67>
   42bfb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42bff:	eb 24                	jmp    42c25 <check_keyboard+0xee>
        }
        else if (c == 't'){
   42c01:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42c05:	75 0d                	jne    42c14 <check_keyboard+0xdd>
            argument = "test";
   42c07:	48 8d 05 c2 23 00 00 	lea    0x23c2(%rip),%rax        # 44fd0 <complex_keymap+0x70>
   42c0e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42c12:	eb 11                	jmp    42c25 <check_keyboard+0xee>
        }
        else if(c == '2'){
   42c14:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42c18:	75 0b                	jne    42c25 <check_keyboard+0xee>
            argument = "test2";
   42c1a:	48 8d 05 b4 23 00 00 	lea    0x23b4(%rip),%rax        # 44fd5 <complex_keymap+0x75>
   42c21:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42c25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c29:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42c2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c32:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42c36:	76 1e                	jbe    42c56 <check_keyboard+0x11f>
   42c38:	48 8d 05 9c 23 00 00 	lea    0x239c(%rip),%rax        # 44fdb <complex_keymap+0x7b>
   42c3f:	48 89 c2             	mov    %rax,%rdx
   42c42:	be 5d 02 00 00       	mov    $0x25d,%esi
   42c47:	48 8d 05 a9 23 00 00 	lea    0x23a9(%rip),%rax        # 44ff7 <complex_keymap+0x97>
   42c4e:	48 89 c7             	mov    %rax,%rdi
   42c51:	e8 33 01 00 00       	call   42d89 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42c56:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c5a:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42c5d:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42c61:	48 89 c3             	mov    %rax,%rbx
   42c64:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42c69:	e9 92 d3 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42c6e:	eb 11                	jmp    42c81 <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42c70:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42c74:	74 06                	je     42c7c <check_keyboard+0x145>
   42c76:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42c7a:	75 05                	jne    42c81 <check_keyboard+0x14a>
        poweroff();
   42c7c:	e8 3c f8 ff ff       	call   424bd <poweroff>
    }
    return c;
   42c81:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42c84:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42c88:	c9                   	leave  
   42c89:	c3                   	ret    

0000000000042c8a <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42c8a:	f3 0f 1e fa          	endbr64 
   42c8e:	55                   	push   %rbp
   42c8f:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42c92:	e8 a0 fe ff ff       	call   42b37 <check_keyboard>
   42c97:	eb f9                	jmp    42c92 <fail+0x8>

0000000000042c99 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42c99:	f3 0f 1e fa          	endbr64 
   42c9d:	55                   	push   %rbp
   42c9e:	48 89 e5             	mov    %rsp,%rbp
   42ca1:	48 83 ec 60          	sub    $0x60,%rsp
   42ca5:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42ca9:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42cad:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42cb1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42cb5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42cb9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42cbd:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42cc4:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42cc8:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42ccc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42cd0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42cd4:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42cd9:	0f 84 87 00 00 00    	je     42d66 <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42cdf:	48 8d 05 25 23 00 00 	lea    0x2325(%rip),%rax        # 4500b <complex_keymap+0xab>
   42ce6:	48 89 c2             	mov    %rax,%rdx
   42ce9:	be 00 c0 00 00       	mov    $0xc000,%esi
   42cee:	bf 30 07 00 00       	mov    $0x730,%edi
   42cf3:	b8 00 00 00 00       	mov    $0x0,%eax
   42cf8:	e8 e4 fd ff ff       	call   42ae1 <error_printf>
   42cfd:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42d00:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42d04:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42d08:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d0b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d10:	89 c7                	mov    %eax,%edi
   42d12:	e8 68 fd ff ff       	call   42a7f <error_vprintf>
   42d17:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42d1a:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42d1d:	48 63 c1             	movslq %ecx,%rax
   42d20:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42d27:	48 c1 e8 20          	shr    $0x20,%rax
   42d2b:	c1 f8 05             	sar    $0x5,%eax
   42d2e:	89 ce                	mov    %ecx,%esi
   42d30:	c1 fe 1f             	sar    $0x1f,%esi
   42d33:	29 f0                	sub    %esi,%eax
   42d35:	89 c2                	mov    %eax,%edx
   42d37:	89 d0                	mov    %edx,%eax
   42d39:	c1 e0 02             	shl    $0x2,%eax
   42d3c:	01 d0                	add    %edx,%eax
   42d3e:	c1 e0 04             	shl    $0x4,%eax
   42d41:	29 c1                	sub    %eax,%ecx
   42d43:	89 ca                	mov    %ecx,%edx
   42d45:	85 d2                	test   %edx,%edx
   42d47:	74 3b                	je     42d84 <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   42d49:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d4c:	48 8d 15 c0 22 00 00 	lea    0x22c0(%rip),%rdx        # 45013 <complex_keymap+0xb3>
   42d53:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d58:	89 c7                	mov    %eax,%edi
   42d5a:	b8 00 00 00 00       	mov    $0x0,%eax
   42d5f:	e8 7d fd ff ff       	call   42ae1 <error_printf>
   42d64:	eb 1e                	jmp    42d84 <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42d66:	48 8d 05 a8 22 00 00 	lea    0x22a8(%rip),%rax        # 45015 <complex_keymap+0xb5>
   42d6d:	48 89 c2             	mov    %rax,%rdx
   42d70:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d75:	bf 30 07 00 00       	mov    $0x730,%edi
   42d7a:	b8 00 00 00 00       	mov    $0x0,%eax
   42d7f:	e8 5d fd ff ff       	call   42ae1 <error_printf>
    }

    va_end(val);
    fail();
   42d84:	e8 01 ff ff ff       	call   42c8a <fail>

0000000000042d89 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42d89:	f3 0f 1e fa          	endbr64 
   42d8d:	55                   	push   %rbp
   42d8e:	48 89 e5             	mov    %rsp,%rbp
   42d91:	48 83 ec 20          	sub    $0x20,%rsp
   42d95:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42d99:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42d9c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42da0:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42da4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42da7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42dab:	48 89 c6             	mov    %rax,%rsi
   42dae:	48 8d 05 66 22 00 00 	lea    0x2266(%rip),%rax        # 4501b <complex_keymap+0xbb>
   42db5:	48 89 c7             	mov    %rax,%rdi
   42db8:	b8 00 00 00 00       	mov    $0x0,%eax
   42dbd:	e8 d7 fe ff ff       	call   42c99 <panic>

0000000000042dc2 <default_exception>:
}

void default_exception(proc* p){
   42dc2:	f3 0f 1e fa          	endbr64 
   42dc6:	55                   	push   %rbp
   42dc7:	48 89 e5             	mov    %rsp,%rbp
   42dca:	48 83 ec 20          	sub    $0x20,%rsp
   42dce:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42dd2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dd6:	48 83 c0 08          	add    $0x8,%rax
   42dda:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42dde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42de2:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42de9:	48 89 c6             	mov    %rax,%rsi
   42dec:	48 8d 05 46 22 00 00 	lea    0x2246(%rip),%rax        # 45039 <complex_keymap+0xd9>
   42df3:	48 89 c7             	mov    %rax,%rdi
   42df6:	b8 00 00 00 00       	mov    $0x0,%eax
   42dfb:	e8 99 fe ff ff       	call   42c99 <panic>

0000000000042e00 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42e00:	55                   	push   %rbp
   42e01:	48 89 e5             	mov    %rsp,%rbp
   42e04:	48 83 ec 10          	sub    $0x10,%rsp
   42e08:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42e0c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42e0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42e13:	78 06                	js     42e1b <pageindex+0x1b>
   42e15:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42e19:	7e 1e                	jle    42e39 <pageindex+0x39>
   42e1b:	48 8d 05 36 22 00 00 	lea    0x2236(%rip),%rax        # 45058 <complex_keymap+0xf8>
   42e22:	48 89 c2             	mov    %rax,%rdx
   42e25:	be 1e 00 00 00       	mov    $0x1e,%esi
   42e2a:	48 8d 05 40 22 00 00 	lea    0x2240(%rip),%rax        # 45071 <complex_keymap+0x111>
   42e31:	48 89 c7             	mov    %rax,%rdi
   42e34:	e8 50 ff ff ff       	call   42d89 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42e39:	b8 03 00 00 00       	mov    $0x3,%eax
   42e3e:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42e41:	89 c2                	mov    %eax,%edx
   42e43:	89 d0                	mov    %edx,%eax
   42e45:	c1 e0 03             	shl    $0x3,%eax
   42e48:	01 d0                	add    %edx,%eax
   42e4a:	83 c0 0c             	add    $0xc,%eax
   42e4d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e51:	89 c1                	mov    %eax,%ecx
   42e53:	48 d3 ea             	shr    %cl,%rdx
   42e56:	48 89 d0             	mov    %rdx,%rax
   42e59:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42e5e:	c9                   	leave  
   42e5f:	c3                   	ret    

0000000000042e60 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42e60:	f3 0f 1e fa          	endbr64 
   42e64:	55                   	push   %rbp
   42e65:	48 89 e5             	mov    %rsp,%rbp
   42e68:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42e6c:	48 8d 05 8d 31 01 00 	lea    0x1318d(%rip),%rax        # 56000 <kernel_pagetables>
   42e73:	48 89 05 86 21 01 00 	mov    %rax,0x12186(%rip)        # 55000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42e7a:	ba 00 50 00 00       	mov    $0x5000,%edx
   42e7f:	be 00 00 00 00       	mov    $0x0,%esi
   42e84:	48 8d 05 75 31 01 00 	lea    0x13175(%rip),%rax        # 56000 <kernel_pagetables>
   42e8b:	48 89 c7             	mov    %rax,%rdi
   42e8e:	e8 4c 0c 00 00       	call   43adf <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42e93:	48 8d 05 66 41 01 00 	lea    0x14166(%rip),%rax        # 57000 <kernel_pagetables+0x1000>
   42e9a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42e9e:	48 89 05 5b 31 01 00 	mov    %rax,0x1315b(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42ea5:	48 8d 05 54 51 01 00 	lea    0x15154(%rip),%rax        # 58000 <kernel_pagetables+0x2000>
   42eac:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42eb0:	48 89 05 49 41 01 00 	mov    %rax,0x14149(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42eb7:	48 8d 05 42 61 01 00 	lea    0x16142(%rip),%rax        # 59000 <kernel_pagetables+0x3000>
   42ebe:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42ec2:	48 89 05 37 51 01 00 	mov    %rax,0x15137(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42ec9:	48 8d 05 30 71 01 00 	lea    0x17130(%rip),%rax        # 5a000 <kernel_pagetables+0x4000>
   42ed0:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42ed4:	48 89 05 2d 51 01 00 	mov    %rax,0x1512d(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42edb:	48 8b 05 1e 21 01 00 	mov    0x1211e(%rip),%rax        # 55000 <kernel_pagetable>
   42ee2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42ee8:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42eed:	ba 00 00 00 00       	mov    $0x0,%edx
   42ef2:	be 00 00 00 00       	mov    $0x0,%esi
   42ef7:	48 89 c7             	mov    %rax,%rdi
   42efa:	e8 0e 02 00 00       	call   4310d <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42eff:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42f06:	00 
   42f07:	eb 76                	jmp    42f7f <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42f09:	48 8b 0d f0 20 01 00 	mov    0x120f0(%rip),%rcx        # 55000 <kernel_pagetable>
   42f10:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42f14:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42f18:	48 89 ce             	mov    %rcx,%rsi
   42f1b:	48 89 c7             	mov    %rax,%rdi
   42f1e:	e8 34 06 00 00       	call   43557 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42f23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f27:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42f2b:	74 1e                	je     42f4b <virtual_memory_init+0xeb>
   42f2d:	48 8d 05 51 21 00 00 	lea    0x2151(%rip),%rax        # 45085 <complex_keymap+0x125>
   42f34:	48 89 c2             	mov    %rax,%rdx
   42f37:	be 2d 00 00 00       	mov    $0x2d,%esi
   42f3c:	48 8d 05 52 21 00 00 	lea    0x2152(%rip),%rax        # 45095 <complex_keymap+0x135>
   42f43:	48 89 c7             	mov    %rax,%rdi
   42f46:	e8 3e fe ff ff       	call   42d89 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42f4b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42f4e:	48 98                	cltq   
   42f50:	83 e0 03             	and    $0x3,%eax
   42f53:	48 83 f8 03          	cmp    $0x3,%rax
   42f57:	74 1e                	je     42f77 <virtual_memory_init+0x117>
   42f59:	48 8d 05 48 21 00 00 	lea    0x2148(%rip),%rax        # 450a8 <complex_keymap+0x148>
   42f60:	48 89 c2             	mov    %rax,%rdx
   42f63:	be 2e 00 00 00       	mov    $0x2e,%esi
   42f68:	48 8d 05 26 21 00 00 	lea    0x2126(%rip),%rax        # 45095 <complex_keymap+0x135>
   42f6f:	48 89 c7             	mov    %rax,%rdi
   42f72:	e8 12 fe ff ff       	call   42d89 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42f77:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42f7e:	00 
   42f7f:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42f86:	00 
   42f87:	76 80                	jbe    42f09 <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42f89:	48 8b 05 70 20 01 00 	mov    0x12070(%rip),%rax        # 55000 <kernel_pagetable>
   42f90:	48 89 c7             	mov    %rax,%rdi
   42f93:	e8 03 00 00 00       	call   42f9b <set_pagetable>
}
   42f98:	90                   	nop
   42f99:	c9                   	leave  
   42f9a:	c3                   	ret    

0000000000042f9b <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42f9b:	f3 0f 1e fa          	endbr64 
   42f9f:	55                   	push   %rbp
   42fa0:	48 89 e5             	mov    %rsp,%rbp
   42fa3:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42fa7:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42fab:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42faf:	25 ff 0f 00 00       	and    $0xfff,%eax
   42fb4:	48 85 c0             	test   %rax,%rax
   42fb7:	74 1e                	je     42fd7 <set_pagetable+0x3c>
   42fb9:	48 8d 05 15 21 00 00 	lea    0x2115(%rip),%rax        # 450d5 <complex_keymap+0x175>
   42fc0:	48 89 c2             	mov    %rax,%rdx
   42fc3:	be 3c 00 00 00       	mov    $0x3c,%esi
   42fc8:	48 8d 05 c6 20 00 00 	lea    0x20c6(%rip),%rax        # 45095 <complex_keymap+0x135>
   42fcf:	48 89 c7             	mov    %rax,%rdi
   42fd2:	e8 b2 fd ff ff       	call   42d89 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42fd7:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   42fde:	48 89 c2             	mov    %rax,%rdx
   42fe1:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42fe5:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42fe9:	48 89 ce             	mov    %rcx,%rsi
   42fec:	48 89 c7             	mov    %rax,%rdi
   42fef:	e8 63 05 00 00       	call   43557 <virtual_memory_lookup>
   42ff4:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42ff8:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   42fff:	48 39 d0             	cmp    %rdx,%rax
   43002:	74 1e                	je     43022 <set_pagetable+0x87>
   43004:	48 8d 05 e5 20 00 00 	lea    0x20e5(%rip),%rax        # 450f0 <complex_keymap+0x190>
   4300b:	48 89 c2             	mov    %rax,%rdx
   4300e:	be 3e 00 00 00       	mov    $0x3e,%esi
   43013:	48 8d 05 7b 20 00 00 	lea    0x207b(%rip),%rax        # 45095 <complex_keymap+0x135>
   4301a:	48 89 c7             	mov    %rax,%rdi
   4301d:	e8 67 fd ff ff       	call   42d89 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   43022:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   43026:	48 8b 0d d3 1f 01 00 	mov    0x11fd3(%rip),%rcx        # 55000 <kernel_pagetable>
   4302d:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   43031:	48 89 ce             	mov    %rcx,%rsi
   43034:	48 89 c7             	mov    %rax,%rdi
   43037:	e8 1b 05 00 00       	call   43557 <virtual_memory_lookup>
   4303c:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   43040:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43044:	48 39 c2             	cmp    %rax,%rdx
   43047:	74 1e                	je     43067 <set_pagetable+0xcc>
   43049:	48 8d 05 08 21 00 00 	lea    0x2108(%rip),%rax        # 45158 <complex_keymap+0x1f8>
   43050:	48 89 c2             	mov    %rax,%rdx
   43053:	be 40 00 00 00       	mov    $0x40,%esi
   43058:	48 8d 05 36 20 00 00 	lea    0x2036(%rip),%rax        # 45095 <complex_keymap+0x135>
   4305f:	48 89 c7             	mov    %rax,%rdi
   43062:	e8 22 fd ff ff       	call   42d89 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   43067:	48 8b 05 92 1f 01 00 	mov    0x11f92(%rip),%rax        # 55000 <kernel_pagetable>
   4306e:	48 89 c2             	mov    %rax,%rdx
   43071:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   43075:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43079:	48 89 ce             	mov    %rcx,%rsi
   4307c:	48 89 c7             	mov    %rax,%rdi
   4307f:	e8 d3 04 00 00       	call   43557 <virtual_memory_lookup>
   43084:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43088:	48 8b 15 71 1f 01 00 	mov    0x11f71(%rip),%rdx        # 55000 <kernel_pagetable>
   4308f:	48 39 d0             	cmp    %rdx,%rax
   43092:	74 1e                	je     430b2 <set_pagetable+0x117>
   43094:	48 8d 05 1d 21 00 00 	lea    0x211d(%rip),%rax        # 451b8 <complex_keymap+0x258>
   4309b:	48 89 c2             	mov    %rax,%rdx
   4309e:	be 42 00 00 00       	mov    $0x42,%esi
   430a3:	48 8d 05 eb 1f 00 00 	lea    0x1feb(%rip),%rax        # 45095 <complex_keymap+0x135>
   430aa:	48 89 c7             	mov    %rax,%rdi
   430ad:	e8 d7 fc ff ff       	call   42d89 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   430b2:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 4310d <virtual_memory_map>
   430b9:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   430bd:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   430c1:	48 89 ce             	mov    %rcx,%rsi
   430c4:	48 89 c7             	mov    %rax,%rdi
   430c7:	e8 8b 04 00 00       	call   43557 <virtual_memory_lookup>
   430cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430d0:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 4310d <virtual_memory_map>
   430d7:	48 39 d0             	cmp    %rdx,%rax
   430da:	74 1e                	je     430fa <set_pagetable+0x15f>
   430dc:	48 8d 05 3d 21 00 00 	lea    0x213d(%rip),%rax        # 45220 <complex_keymap+0x2c0>
   430e3:	48 89 c2             	mov    %rax,%rdx
   430e6:	be 44 00 00 00       	mov    $0x44,%esi
   430eb:	48 8d 05 a3 1f 00 00 	lea    0x1fa3(%rip),%rax        # 45095 <complex_keymap+0x135>
   430f2:	48 89 c7             	mov    %rax,%rdi
   430f5:	e8 8f fc ff ff       	call   42d89 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   430fa:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   430fe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   43102:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43106:	0f 22 d8             	mov    %rax,%cr3
}
   43109:	90                   	nop
}
   4310a:	90                   	nop
   4310b:	c9                   	leave  
   4310c:	c3                   	ret    

000000000004310d <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   4310d:	f3 0f 1e fa          	endbr64 
   43111:	55                   	push   %rbp
   43112:	48 89 e5             	mov    %rsp,%rbp
   43115:	48 83 ec 50          	sub    $0x50,%rsp
   43119:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4311d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43121:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43125:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   43129:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4312d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43131:	25 ff 0f 00 00       	and    $0xfff,%eax
   43136:	48 85 c0             	test   %rax,%rax
   43139:	74 1e                	je     43159 <virtual_memory_map+0x4c>
   4313b:	48 8d 05 44 21 00 00 	lea    0x2144(%rip),%rax        # 45286 <complex_keymap+0x326>
   43142:	48 89 c2             	mov    %rax,%rdx
   43145:	be 65 00 00 00       	mov    $0x65,%esi
   4314a:	48 8d 05 44 1f 00 00 	lea    0x1f44(%rip),%rax        # 45095 <complex_keymap+0x135>
   43151:	48 89 c7             	mov    %rax,%rdi
   43154:	e8 30 fc ff ff       	call   42d89 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   43159:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4315d:	25 ff 0f 00 00       	and    $0xfff,%eax
   43162:	48 85 c0             	test   %rax,%rax
   43165:	74 1e                	je     43185 <virtual_memory_map+0x78>
   43167:	48 8d 05 2b 21 00 00 	lea    0x212b(%rip),%rax        # 45299 <complex_keymap+0x339>
   4316e:	48 89 c2             	mov    %rax,%rdx
   43171:	be 66 00 00 00       	mov    $0x66,%esi
   43176:	48 8d 05 18 1f 00 00 	lea    0x1f18(%rip),%rax        # 45095 <complex_keymap+0x135>
   4317d:	48 89 c7             	mov    %rax,%rdi
   43180:	e8 04 fc ff ff       	call   42d89 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   43185:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43189:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4318d:	48 01 d0             	add    %rdx,%rax
   43190:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   43194:	76 2e                	jbe    431c4 <virtual_memory_map+0xb7>
   43196:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4319a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4319e:	48 01 d0             	add    %rdx,%rax
   431a1:	48 85 c0             	test   %rax,%rax
   431a4:	74 1e                	je     431c4 <virtual_memory_map+0xb7>
   431a6:	48 8d 05 ff 20 00 00 	lea    0x20ff(%rip),%rax        # 452ac <complex_keymap+0x34c>
   431ad:	48 89 c2             	mov    %rax,%rdx
   431b0:	be 67 00 00 00       	mov    $0x67,%esi
   431b5:	48 8d 05 d9 1e 00 00 	lea    0x1ed9(%rip),%rax        # 45095 <complex_keymap+0x135>
   431bc:	48 89 c7             	mov    %rax,%rdi
   431bf:	e8 c5 fb ff ff       	call   42d89 <assert_fail>
    if (perm & PTE_P) {
   431c4:	8b 45 bc             	mov    -0x44(%rbp),%eax
   431c7:	48 98                	cltq   
   431c9:	83 e0 01             	and    $0x1,%eax
   431cc:	48 85 c0             	test   %rax,%rax
   431cf:	0f 84 8c 00 00 00    	je     43261 <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   431d5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431d9:	25 ff 0f 00 00       	and    $0xfff,%eax
   431de:	48 85 c0             	test   %rax,%rax
   431e1:	74 1e                	je     43201 <virtual_memory_map+0xf4>
   431e3:	48 8d 05 e0 20 00 00 	lea    0x20e0(%rip),%rax        # 452ca <complex_keymap+0x36a>
   431ea:	48 89 c2             	mov    %rax,%rdx
   431ed:	be 69 00 00 00       	mov    $0x69,%esi
   431f2:	48 8d 05 9c 1e 00 00 	lea    0x1e9c(%rip),%rax        # 45095 <complex_keymap+0x135>
   431f9:	48 89 c7             	mov    %rax,%rdi
   431fc:	e8 88 fb ff ff       	call   42d89 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   43201:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43205:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43209:	48 01 d0             	add    %rdx,%rax
   4320c:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   43210:	76 1e                	jbe    43230 <virtual_memory_map+0x123>
   43212:	48 8d 05 c4 20 00 00 	lea    0x20c4(%rip),%rax        # 452dd <complex_keymap+0x37d>
   43219:	48 89 c2             	mov    %rax,%rdx
   4321c:	be 6a 00 00 00       	mov    $0x6a,%esi
   43221:	48 8d 05 6d 1e 00 00 	lea    0x1e6d(%rip),%rax        # 45095 <complex_keymap+0x135>
   43228:	48 89 c7             	mov    %rax,%rdi
   4322b:	e8 59 fb ff ff       	call   42d89 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   43230:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43234:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43238:	48 01 d0             	add    %rdx,%rax
   4323b:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   43241:	76 1e                	jbe    43261 <virtual_memory_map+0x154>
   43243:	48 8d 05 a1 20 00 00 	lea    0x20a1(%rip),%rax        # 452eb <complex_keymap+0x38b>
   4324a:	48 89 c2             	mov    %rax,%rdx
   4324d:	be 6b 00 00 00       	mov    $0x6b,%esi
   43252:	48 8d 05 3c 1e 00 00 	lea    0x1e3c(%rip),%rax        # 45095 <complex_keymap+0x135>
   43259:	48 89 c7             	mov    %rax,%rdi
   4325c:	e8 28 fb ff ff       	call   42d89 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   43261:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43265:	78 09                	js     43270 <virtual_memory_map+0x163>
   43267:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   4326e:	7e 1e                	jle    4328e <virtual_memory_map+0x181>
   43270:	48 8d 05 90 20 00 00 	lea    0x2090(%rip),%rax        # 45307 <complex_keymap+0x3a7>
   43277:	48 89 c2             	mov    %rax,%rdx
   4327a:	be 6d 00 00 00       	mov    $0x6d,%esi
   4327f:	48 8d 05 0f 1e 00 00 	lea    0x1e0f(%rip),%rax        # 45095 <complex_keymap+0x135>
   43286:	48 89 c7             	mov    %rax,%rdi
   43289:	e8 fb fa ff ff       	call   42d89 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   4328e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43292:	25 ff 0f 00 00       	and    $0xfff,%eax
   43297:	48 85 c0             	test   %rax,%rax
   4329a:	74 1e                	je     432ba <virtual_memory_map+0x1ad>
   4329c:	48 8d 05 85 20 00 00 	lea    0x2085(%rip),%rax        # 45328 <complex_keymap+0x3c8>
   432a3:	48 89 c2             	mov    %rax,%rdx
   432a6:	be 6e 00 00 00       	mov    $0x6e,%esi
   432ab:	48 8d 05 e3 1d 00 00 	lea    0x1de3(%rip),%rax        # 45095 <complex_keymap+0x135>
   432b2:	48 89 c7             	mov    %rax,%rdi
   432b5:	e8 cf fa ff ff       	call   42d89 <assert_fail>

    int last_index123 = -1;
   432ba:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   432c1:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   432c8:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   432c9:	e9 ed 00 00 00       	jmp    433bb <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   432ce:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   432d2:	48 c1 e8 15          	shr    $0x15,%rax
   432d6:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   432d9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   432dc:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   432df:	74 20                	je     43301 <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   432e1:	8b 55 bc             	mov    -0x44(%rbp),%edx
   432e4:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   432e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432ec:	48 89 ce             	mov    %rcx,%rsi
   432ef:	48 89 c7             	mov    %rax,%rdi
   432f2:	e8 d6 00 00 00       	call   433cd <lookup_l1pagetable>
   432f7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   432fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   432fe:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   43301:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43304:	48 98                	cltq   
   43306:	83 e0 01             	and    $0x1,%eax
   43309:	48 85 c0             	test   %rax,%rax
   4330c:	74 37                	je     43345 <virtual_memory_map+0x238>
   4330e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43313:	74 30                	je     43345 <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   43315:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43319:	be 03 00 00 00       	mov    $0x3,%esi
   4331e:	48 89 c7             	mov    %rax,%rdi
   43321:	e8 da fa ff ff       	call   42e00 <pageindex>
   43326:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   43329:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4332c:	48 98                	cltq   
   4332e:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   43332:	48 89 c1             	mov    %rax,%rcx
   43335:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43339:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4333c:	48 63 d2             	movslq %edx,%rdx
   4333f:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   43343:	eb 5e                	jmp    433a3 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   43345:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4334a:	74 2a                	je     43376 <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   4334c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43350:	be 03 00 00 00       	mov    $0x3,%esi
   43355:	48 89 c7             	mov    %rax,%rdi
   43358:	e8 a3 fa ff ff       	call   42e00 <pageindex>
   4335d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   43360:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43363:	48 63 c8             	movslq %eax,%rcx
   43366:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4336a:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4336d:	48 63 d2             	movslq %edx,%rdx
   43370:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   43374:	eb 2d                	jmp    433a3 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   43376:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43379:	48 98                	cltq   
   4337b:	83 e0 01             	and    $0x1,%eax
   4337e:	48 85 c0             	test   %rax,%rax
   43381:	74 20                	je     433a3 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   43383:	be 87 00 00 00       	mov    $0x87,%esi
   43388:	48 8d 05 c1 1f 00 00 	lea    0x1fc1(%rip),%rax        # 45350 <complex_keymap+0x3f0>
   4338f:	48 89 c7             	mov    %rax,%rdi
   43392:	b8 00 00 00 00       	mov    $0x0,%eax
   43397:	e8 92 f6 ff ff       	call   42a2e <log_printf>
            return -1;
   4339c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   433a1:	eb 28                	jmp    433cb <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   433a3:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   433aa:	00 
   433ab:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   433b2:	00 
   433b3:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   433ba:	00 
   433bb:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   433c0:	0f 85 08 ff ff ff    	jne    432ce <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   433c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
   433cb:	c9                   	leave  
   433cc:	c3                   	ret    

00000000000433cd <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   433cd:	f3 0f 1e fa          	endbr64 
   433d1:	55                   	push   %rbp
   433d2:	48 89 e5             	mov    %rsp,%rbp
   433d5:	48 83 ec 40          	sub    $0x40,%rsp
   433d9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   433dd:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   433e1:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   433e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   433ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   433f3:	e9 4f 01 00 00       	jmp    43547 <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        int index = PAGEINDEX(va, i); // Get the index for the current level
   433f8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   433fb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   433ff:	89 d6                	mov    %edx,%esi
   43401:	48 89 c7             	mov    %rax,%rdi
   43404:	e8 f7 f9 ff ff       	call   42e00 <pageindex>
   43409:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   4340c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43410:	8b 55 f0             	mov    -0x10(%rbp),%edx
   43413:	48 63 d2             	movslq %edx,%rdx
   43416:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4341a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   4341e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43422:	83 e0 01             	and    $0x1,%eax
   43425:	48 85 c0             	test   %rax,%rax
   43428:	75 6d                	jne    43497 <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   4342a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4342d:	8d 48 02             	lea    0x2(%rax),%ecx
   43430:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43434:	25 ff 0f 00 00       	and    $0xfff,%eax
   43439:	48 89 c2             	mov    %rax,%rdx
   4343c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43440:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43446:	48 89 c6             	mov    %rax,%rsi
   43449:	48 8d 05 48 1f 00 00 	lea    0x1f48(%rip),%rax        # 45398 <complex_keymap+0x438>
   43450:	48 89 c7             	mov    %rax,%rdi
   43453:	b8 00 00 00 00       	mov    $0x0,%eax
   43458:	e8 d1 f5 ff ff       	call   42a2e <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   4345d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43460:	48 98                	cltq   
   43462:	83 e0 01             	and    $0x1,%eax
   43465:	48 85 c0             	test   %rax,%rax
   43468:	75 0a                	jne    43474 <lookup_l1pagetable+0xa7>
                return NULL;
   4346a:	b8 00 00 00 00       	mov    $0x0,%eax
   4346f:	e9 e1 00 00 00       	jmp    43555 <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   43474:	be ac 00 00 00       	mov    $0xac,%esi
   43479:	48 8d 05 80 1f 00 00 	lea    0x1f80(%rip),%rax        # 45400 <complex_keymap+0x4a0>
   43480:	48 89 c7             	mov    %rax,%rdi
   43483:	b8 00 00 00 00       	mov    $0x0,%eax
   43488:	e8 a1 f5 ff ff       	call   42a2e <log_printf>
            return NULL;
   4348d:	b8 00 00 00 00       	mov    $0x0,%eax
   43492:	e9 be 00 00 00       	jmp    43555 <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   43497:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4349b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   434a1:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   434a7:	76 1e                	jbe    434c7 <lookup_l1pagetable+0xfa>
   434a9:	48 8d 05 98 1f 00 00 	lea    0x1f98(%rip),%rax        # 45448 <complex_keymap+0x4e8>
   434b0:	48 89 c2             	mov    %rax,%rdx
   434b3:	be b1 00 00 00       	mov    $0xb1,%esi
   434b8:	48 8d 05 d6 1b 00 00 	lea    0x1bd6(%rip),%rax        # 45095 <complex_keymap+0x135>
   434bf:	48 89 c7             	mov    %rax,%rdi
   434c2:	e8 c2 f8 ff ff       	call   42d89 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   434c7:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434ca:	48 98                	cltq   
   434cc:	83 e0 02             	and    $0x2,%eax
   434cf:	48 85 c0             	test   %rax,%rax
   434d2:	74 2a                	je     434fe <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   434d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434d8:	83 e0 02             	and    $0x2,%eax
   434db:	48 85 c0             	test   %rax,%rax
   434de:	75 1e                	jne    434fe <lookup_l1pagetable+0x131>
   434e0:	48 8d 05 81 1f 00 00 	lea    0x1f81(%rip),%rax        # 45468 <complex_keymap+0x508>
   434e7:	48 89 c2             	mov    %rax,%rdx
   434ea:	be b3 00 00 00       	mov    $0xb3,%esi
   434ef:	48 8d 05 9f 1b 00 00 	lea    0x1b9f(%rip),%rax        # 45095 <complex_keymap+0x135>
   434f6:	48 89 c7             	mov    %rax,%rdi
   434f9:	e8 8b f8 ff ff       	call   42d89 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   434fe:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43501:	48 98                	cltq   
   43503:	83 e0 04             	and    $0x4,%eax
   43506:	48 85 c0             	test   %rax,%rax
   43509:	74 2a                	je     43535 <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   4350b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4350f:	83 e0 04             	and    $0x4,%eax
   43512:	48 85 c0             	test   %rax,%rax
   43515:	75 1e                	jne    43535 <lookup_l1pagetable+0x168>
   43517:	48 8d 05 55 1f 00 00 	lea    0x1f55(%rip),%rax        # 45473 <complex_keymap+0x513>
   4351e:	48 89 c2             	mov    %rax,%rdx
   43521:	be b6 00 00 00       	mov    $0xb6,%esi
   43526:	48 8d 05 68 1b 00 00 	lea    0x1b68(%rip),%rax        # 45095 <complex_keymap+0x135>
   4352d:	48 89 c7             	mov    %rax,%rdi
   43530:	e8 54 f8 ff ff       	call   42d89 <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43535:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43539:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4353f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   43543:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   43547:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   4354b:	0f 8e a7 fe ff ff    	jle    433f8 <lookup_l1pagetable+0x2b>
    }
    return pt;
   43551:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43555:	c9                   	leave  
   43556:	c3                   	ret    

0000000000043557 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   43557:	f3 0f 1e fa          	endbr64 
   4355b:	55                   	push   %rbp
   4355c:	48 89 e5             	mov    %rsp,%rbp
   4355f:	48 83 ec 50          	sub    $0x50,%rsp
   43563:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43567:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   4356b:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   4356f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43573:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   43577:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4357e:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4357f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   43586:	eb 41                	jmp    435c9 <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   43588:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4358b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4358f:	89 d6                	mov    %edx,%esi
   43591:	48 89 c7             	mov    %rax,%rdi
   43594:	e8 67 f8 ff ff       	call   42e00 <pageindex>
   43599:	89 c2                	mov    %eax,%edx
   4359b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4359f:	48 63 d2             	movslq %edx,%rdx
   435a2:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   435a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435aa:	83 e0 06             	and    $0x6,%eax
   435ad:	48 f7 d0             	not    %rax
   435b0:	48 21 d0             	and    %rdx,%rax
   435b3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   435b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435bb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   435c1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   435c5:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   435c9:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   435cd:	7f 0c                	jg     435db <virtual_memory_lookup+0x84>
   435cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435d3:	83 e0 01             	and    $0x1,%eax
   435d6:	48 85 c0             	test   %rax,%rax
   435d9:	75 ad                	jne    43588 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   435db:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   435e2:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   435e9:	ff 
   435ea:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   435f1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435f5:	83 e0 01             	and    $0x1,%eax
   435f8:	48 85 c0             	test   %rax,%rax
   435fb:	74 34                	je     43631 <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   435fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43601:	48 c1 e8 0c          	shr    $0xc,%rax
   43605:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43608:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4360c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43612:	48 89 c2             	mov    %rax,%rdx
   43615:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43619:	25 ff 0f 00 00       	and    $0xfff,%eax
   4361e:	48 09 d0             	or     %rdx,%rax
   43621:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   43625:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43629:	25 ff 0f 00 00       	and    $0xfff,%eax
   4362e:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   43631:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43635:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43639:	48 89 10             	mov    %rdx,(%rax)
   4363c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   43640:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43644:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43648:	48 89 50 10          	mov    %rdx,0x10(%rax)
   4364c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43650:	c9                   	leave  
   43651:	c3                   	ret    

0000000000043652 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   43652:	f3 0f 1e fa          	endbr64 
   43656:	55                   	push   %rbp
   43657:	48 89 e5             	mov    %rsp,%rbp
   4365a:	48 83 ec 40          	sub    $0x40,%rsp
   4365e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43662:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   43665:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   43669:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   43670:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43674:	78 08                	js     4367e <program_load+0x2c>
   43676:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43679:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   4367c:	7c 1e                	jl     4369c <program_load+0x4a>
   4367e:	48 8d 05 fb 1d 00 00 	lea    0x1dfb(%rip),%rax        # 45480 <complex_keymap+0x520>
   43685:	48 89 c2             	mov    %rax,%rdx
   43688:	be 37 00 00 00       	mov    $0x37,%esi
   4368d:	48 8d 05 1c 1e 00 00 	lea    0x1e1c(%rip),%rax        # 454b0 <complex_keymap+0x550>
   43694:	48 89 c7             	mov    %rax,%rdi
   43697:	e8 ed f6 ff ff       	call   42d89 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4369c:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   4369f:	48 98                	cltq   
   436a1:	48 c1 e0 04          	shl    $0x4,%rax
   436a5:	48 89 c2             	mov    %rax,%rdx
   436a8:	48 8d 05 71 29 00 00 	lea    0x2971(%rip),%rax        # 46020 <ramimages>
   436af:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   436b3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   436b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436bb:	8b 00                	mov    (%rax),%eax
   436bd:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   436c2:	74 1e                	je     436e2 <program_load+0x90>
   436c4:	48 8d 05 f7 1d 00 00 	lea    0x1df7(%rip),%rax        # 454c2 <complex_keymap+0x562>
   436cb:	48 89 c2             	mov    %rax,%rdx
   436ce:	be 39 00 00 00       	mov    $0x39,%esi
   436d3:	48 8d 05 d6 1d 00 00 	lea    0x1dd6(%rip),%rax        # 454b0 <complex_keymap+0x550>
   436da:	48 89 c7             	mov    %rax,%rdi
   436dd:	e8 a7 f6 ff ff       	call   42d89 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   436e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436e6:	48 8b 50 20          	mov    0x20(%rax),%rdx
   436ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436ee:	48 01 d0             	add    %rdx,%rax
   436f1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   436f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   436fc:	e9 94 00 00 00       	jmp    43795 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43701:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43704:	48 63 d0             	movslq %eax,%rdx
   43707:	48 89 d0             	mov    %rdx,%rax
   4370a:	48 c1 e0 03          	shl    $0x3,%rax
   4370e:	48 29 d0             	sub    %rdx,%rax
   43711:	48 c1 e0 03          	shl    $0x3,%rax
   43715:	48 89 c2             	mov    %rax,%rdx
   43718:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4371c:	48 01 d0             	add    %rdx,%rax
   4371f:	8b 00                	mov    (%rax),%eax
   43721:	83 f8 01             	cmp    $0x1,%eax
   43724:	75 6b                	jne    43791 <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   43726:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43729:	48 63 d0             	movslq %eax,%rdx
   4372c:	48 89 d0             	mov    %rdx,%rax
   4372f:	48 c1 e0 03          	shl    $0x3,%rax
   43733:	48 29 d0             	sub    %rdx,%rax
   43736:	48 c1 e0 03          	shl    $0x3,%rax
   4373a:	48 89 c2             	mov    %rax,%rdx
   4373d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43741:	48 01 d0             	add    %rdx,%rax
   43744:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43748:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4374c:	48 01 d0             	add    %rdx,%rax
   4374f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   43753:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43756:	48 63 d0             	movslq %eax,%rdx
   43759:	48 89 d0             	mov    %rdx,%rax
   4375c:	48 c1 e0 03          	shl    $0x3,%rax
   43760:	48 29 d0             	sub    %rdx,%rax
   43763:	48 c1 e0 03          	shl    $0x3,%rax
   43767:	48 89 c2             	mov    %rax,%rdx
   4376a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4376e:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43772:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   43776:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4377a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4377e:	48 89 c7             	mov    %rax,%rdi
   43781:	e8 3d 00 00 00       	call   437c3 <program_load_segment>
   43786:	85 c0                	test   %eax,%eax
   43788:	79 07                	jns    43791 <program_load+0x13f>
                return -1;
   4378a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4378f:	eb 30                	jmp    437c1 <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43791:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43795:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43799:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   4379d:	0f b7 c0             	movzwl %ax,%eax
   437a0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   437a3:	0f 8c 58 ff ff ff    	jl     43701 <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   437a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437ad:	48 8b 50 18          	mov    0x18(%rax),%rdx
   437b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   437b5:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   437bc:	b8 00 00 00 00       	mov    $0x0,%eax
}
   437c1:	c9                   	leave  
   437c2:	c3                   	ret    

00000000000437c3 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   437c3:	f3 0f 1e fa          	endbr64 
   437c7:	55                   	push   %rbp
   437c8:	48 89 e5             	mov    %rsp,%rbp
   437cb:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   437cf:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   437d3:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   437d7:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   437db:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   437df:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   437e3:	48 8b 40 10          	mov    0x10(%rax),%rax
   437e7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   437eb:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   437ef:	48 8b 50 20          	mov    0x20(%rax),%rdx
   437f3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437f7:	48 01 d0             	add    %rdx,%rax
   437fa:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   437fe:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43802:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43806:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4380a:	48 01 d0             	add    %rdx,%rax
   4380d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43811:	48 81 65 e0 00 f0 ff 	andq   $0xfffffffffffff000,-0x20(%rbp)
   43818:	ff 

    int perms = PTE_P | PTE_W | PTE_U;
   43819:	c7 45 fc 07 00 00 00 	movl   $0x7,-0x4(%rbp)
    if ((ph->p_flags & ELF_PFLAG_WRITE) == 0){
   43820:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43824:	8b 40 04             	mov    0x4(%rax),%eax
   43827:	83 e0 02             	and    $0x2,%eax
   4382a:	85 c0                	test   %eax,%eax
   4382c:	75 07                	jne    43835 <program_load_segment+0x72>
        perms = PTE_P | PTE_U;
   4382e:	c7 45 fc 05 00 00 00 	movl   $0x5,-0x4(%rbp)
    }
    uintptr_t pa = 0;
   43835:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
   4383c:	00 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4383d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43841:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43845:	eb 7d                	jmp    438c4 <program_load_segment+0x101>
        pa = find_page(p->p_pid);
   43847:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4384b:	8b 00                	mov    (%rax),%eax
   4384d:	0f be c0             	movsbl %al,%eax
   43850:	89 c7                	mov    %eax,%edi
   43852:	e8 ad cb ff ff       	call   40404 <find_page>
   43857:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   4385b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4385f:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43866:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4386a:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   4386e:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43874:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43879:	48 89 c7             	mov    %rax,%rdi
   4387c:	e8 8c f8 ff ff       	call   4310d <virtual_memory_map>
   43881:	85 c0                	test   %eax,%eax
   43883:	79 37                	jns    438bc <program_load_segment+0xf9>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43885:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43889:	8b 00                	mov    (%rax),%eax
   4388b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4388f:	49 89 d0             	mov    %rdx,%r8
   43892:	89 c1                	mov    %eax,%ecx
   43894:	48 8d 05 45 1c 00 00 	lea    0x1c45(%rip),%rax        # 454e0 <complex_keymap+0x580>
   4389b:	48 89 c2             	mov    %rax,%rdx
   4389e:	be 00 c0 00 00       	mov    $0xc000,%esi
   438a3:	bf e0 06 00 00       	mov    $0x6e0,%edi
   438a8:	b8 00 00 00 00       	mov    $0x0,%eax
   438ad:	e8 6c 10 00 00       	call   4491e <console_printf>
            return -1;
   438b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438b7:	e9 1b 01 00 00       	jmp    439d7 <program_load_segment+0x214>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   438bc:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   438c3:	00 
   438c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438c8:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   438cc:	0f 82 75 ff ff ff    	jb     43847 <program_load_segment+0x84>
        }
    }
    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   438d2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   438d6:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   438dd:	48 89 c7             	mov    %rax,%rdi
   438e0:	e8 b6 f6 ff ff       	call   42f9b <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   438e5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438e9:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   438ed:	48 89 c2             	mov    %rax,%rdx
   438f0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   438f4:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   438f8:	48 89 ce             	mov    %rcx,%rsi
   438fb:	48 89 c7             	mov    %rax,%rdi
   438fe:	e8 d6 00 00 00       	call   439d9 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43903:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43907:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
   4390b:	48 89 c2             	mov    %rax,%rdx
   4390e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43912:	be 00 00 00 00       	mov    $0x0,%esi
   43917:	48 89 c7             	mov    %rax,%rdi
   4391a:	e8 c0 01 00 00       	call   43adf <memset>
    
    // update perms
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4391f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43923:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43927:	e9 89 00 00 00       	jmp    439b5 <program_load_segment+0x1f2>
        vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   4392c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43930:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   43937:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   4393b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4393f:	48 89 ce             	mov    %rcx,%rsi
   43942:	48 89 c7             	mov    %rax,%rdi
   43945:	e8 0d fc ff ff       	call   43557 <virtual_memory_lookup>
        int r = virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   4394a:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   4394e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43952:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43959:	8b 4d fc             	mov    -0x4(%rbp),%ecx
   4395c:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   43960:	41 89 c8             	mov    %ecx,%r8d
   43963:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43968:	48 89 c7             	mov    %rax,%rdi
   4396b:	e8 9d f7 ff ff       	call   4310d <virtual_memory_map>
   43970:	89 45 c4             	mov    %eax,-0x3c(%rbp)
                                  perms);
        if (r < 0){
   43973:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
   43977:	79 34                	jns    439ad <program_load_segment+0x1ea>
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43979:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4397d:	8b 00                	mov    (%rax),%eax
   4397f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   43983:	49 89 d0             	mov    %rdx,%r8
   43986:	89 c1                	mov    %eax,%ecx
   43988:	48 8d 05 51 1b 00 00 	lea    0x1b51(%rip),%rax        # 454e0 <complex_keymap+0x580>
   4398f:	48 89 c2             	mov    %rax,%rdx
   43992:	be 00 c0 00 00       	mov    $0xc000,%esi
   43997:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4399c:	b8 00 00 00 00       	mov    $0x0,%eax
   439a1:	e8 78 0f 00 00       	call   4491e <console_printf>
            return -1;
   439a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   439ab:	eb 2a                	jmp    439d7 <program_load_segment+0x214>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   439ad:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   439b4:	00 
   439b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439b9:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   439bd:	0f 82 69 ff ff ff    	jb     4392c <program_load_segment+0x169>
        }
        }


    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   439c3:	48 8b 05 36 16 01 00 	mov    0x11636(%rip),%rax        # 55000 <kernel_pagetable>
   439ca:	48 89 c7             	mov    %rax,%rdi
   439cd:	e8 c9 f5 ff ff       	call   42f9b <set_pagetable>
    return 0;
   439d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
   439d7:	c9                   	leave  
   439d8:	c3                   	ret    

00000000000439d9 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   439d9:	f3 0f 1e fa          	endbr64 
   439dd:	55                   	push   %rbp
   439de:	48 89 e5             	mov    %rsp,%rbp
   439e1:	48 83 ec 28          	sub    $0x28,%rsp
   439e5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   439e9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   439ed:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   439f1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   439f5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   439f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439fd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43a01:	eb 1c                	jmp    43a1f <memcpy+0x46>
        *d = *s;
   43a03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a07:	0f b6 10             	movzbl (%rax),%edx
   43a0a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a0e:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43a10:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43a15:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43a1a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43a1f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43a24:	75 dd                	jne    43a03 <memcpy+0x2a>
    }
    return dst;
   43a26:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43a2a:	c9                   	leave  
   43a2b:	c3                   	ret    

0000000000043a2c <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43a2c:	f3 0f 1e fa          	endbr64 
   43a30:	55                   	push   %rbp
   43a31:	48 89 e5             	mov    %rsp,%rbp
   43a34:	48 83 ec 28          	sub    $0x28,%rsp
   43a38:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43a3c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43a40:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43a44:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a48:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43a4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a50:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43a54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a58:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43a5c:	73 6a                	jae    43ac8 <memmove+0x9c>
   43a5e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43a62:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a66:	48 01 d0             	add    %rdx,%rax
   43a69:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43a6d:	73 59                	jae    43ac8 <memmove+0x9c>
        s += n, d += n;
   43a6f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a73:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43a77:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a7b:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43a7f:	eb 17                	jmp    43a98 <memmove+0x6c>
            *--d = *--s;
   43a81:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43a86:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43a8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a8f:	0f b6 10             	movzbl (%rax),%edx
   43a92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a96:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43a98:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a9c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43aa0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43aa4:	48 85 c0             	test   %rax,%rax
   43aa7:	75 d8                	jne    43a81 <memmove+0x55>
    if (s < d && s + n > d) {
   43aa9:	eb 2e                	jmp    43ad9 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43aab:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43aaf:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43ab3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43ab7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43abb:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43abf:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43ac3:	0f b6 12             	movzbl (%rdx),%edx
   43ac6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43ac8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43acc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43ad0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43ad4:	48 85 c0             	test   %rax,%rax
   43ad7:	75 d2                	jne    43aab <memmove+0x7f>
        }
    }
    return dst;
   43ad9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43add:	c9                   	leave  
   43ade:	c3                   	ret    

0000000000043adf <memset>:

void* memset(void* v, int c, size_t n) {
   43adf:	f3 0f 1e fa          	endbr64 
   43ae3:	55                   	push   %rbp
   43ae4:	48 89 e5             	mov    %rsp,%rbp
   43ae7:	48 83 ec 28          	sub    $0x28,%rsp
   43aeb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43aef:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43af2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43af6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43afa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43afe:	eb 15                	jmp    43b15 <memset+0x36>
        *p = c;
   43b00:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43b03:	89 c2                	mov    %eax,%edx
   43b05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b09:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43b0b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43b10:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43b15:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43b1a:	75 e4                	jne    43b00 <memset+0x21>
    }
    return v;
   43b1c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43b20:	c9                   	leave  
   43b21:	c3                   	ret    

0000000000043b22 <strlen>:

size_t strlen(const char* s) {
   43b22:	f3 0f 1e fa          	endbr64 
   43b26:	55                   	push   %rbp
   43b27:	48 89 e5             	mov    %rsp,%rbp
   43b2a:	48 83 ec 18          	sub    $0x18,%rsp
   43b2e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43b32:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43b39:	00 
   43b3a:	eb 0a                	jmp    43b46 <strlen+0x24>
        ++n;
   43b3c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43b41:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43b46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b4a:	0f b6 00             	movzbl (%rax),%eax
   43b4d:	84 c0                	test   %al,%al
   43b4f:	75 eb                	jne    43b3c <strlen+0x1a>
    }
    return n;
   43b51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43b55:	c9                   	leave  
   43b56:	c3                   	ret    

0000000000043b57 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43b57:	f3 0f 1e fa          	endbr64 
   43b5b:	55                   	push   %rbp
   43b5c:	48 89 e5             	mov    %rsp,%rbp
   43b5f:	48 83 ec 20          	sub    $0x20,%rsp
   43b63:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b67:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43b6b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43b72:	00 
   43b73:	eb 0a                	jmp    43b7f <strnlen+0x28>
        ++n;
   43b75:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43b7a:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43b7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b83:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43b87:	74 0b                	je     43b94 <strnlen+0x3d>
   43b89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b8d:	0f b6 00             	movzbl (%rax),%eax
   43b90:	84 c0                	test   %al,%al
   43b92:	75 e1                	jne    43b75 <strnlen+0x1e>
    }
    return n;
   43b94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43b98:	c9                   	leave  
   43b99:	c3                   	ret    

0000000000043b9a <strcpy>:

char* strcpy(char* dst, const char* src) {
   43b9a:	f3 0f 1e fa          	endbr64 
   43b9e:	55                   	push   %rbp
   43b9f:	48 89 e5             	mov    %rsp,%rbp
   43ba2:	48 83 ec 20          	sub    $0x20,%rsp
   43ba6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43baa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43bae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bb2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43bb6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43bba:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43bbe:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43bc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bc6:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43bca:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43bce:	0f b6 12             	movzbl (%rdx),%edx
   43bd1:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43bd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bd7:	48 83 e8 01          	sub    $0x1,%rax
   43bdb:	0f b6 00             	movzbl (%rax),%eax
   43bde:	84 c0                	test   %al,%al
   43be0:	75 d4                	jne    43bb6 <strcpy+0x1c>
    return dst;
   43be2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43be6:	c9                   	leave  
   43be7:	c3                   	ret    

0000000000043be8 <strcmp>:

int strcmp(const char* a, const char* b) {
   43be8:	f3 0f 1e fa          	endbr64 
   43bec:	55                   	push   %rbp
   43bed:	48 89 e5             	mov    %rsp,%rbp
   43bf0:	48 83 ec 10          	sub    $0x10,%rsp
   43bf4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43bf8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43bfc:	eb 0a                	jmp    43c08 <strcmp+0x20>
        ++a, ++b;
   43bfe:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43c03:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43c08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c0c:	0f b6 00             	movzbl (%rax),%eax
   43c0f:	84 c0                	test   %al,%al
   43c11:	74 1d                	je     43c30 <strcmp+0x48>
   43c13:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c17:	0f b6 00             	movzbl (%rax),%eax
   43c1a:	84 c0                	test   %al,%al
   43c1c:	74 12                	je     43c30 <strcmp+0x48>
   43c1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c22:	0f b6 10             	movzbl (%rax),%edx
   43c25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c29:	0f b6 00             	movzbl (%rax),%eax
   43c2c:	38 c2                	cmp    %al,%dl
   43c2e:	74 ce                	je     43bfe <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43c30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c34:	0f b6 00             	movzbl (%rax),%eax
   43c37:	89 c2                	mov    %eax,%edx
   43c39:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c3d:	0f b6 00             	movzbl (%rax),%eax
   43c40:	38 c2                	cmp    %al,%dl
   43c42:	0f 97 c0             	seta   %al
   43c45:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43c48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c4c:	0f b6 00             	movzbl (%rax),%eax
   43c4f:	89 c1                	mov    %eax,%ecx
   43c51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c55:	0f b6 00             	movzbl (%rax),%eax
   43c58:	38 c1                	cmp    %al,%cl
   43c5a:	0f 92 c0             	setb   %al
   43c5d:	0f b6 c8             	movzbl %al,%ecx
   43c60:	89 d0                	mov    %edx,%eax
   43c62:	29 c8                	sub    %ecx,%eax
}
   43c64:	c9                   	leave  
   43c65:	c3                   	ret    

0000000000043c66 <strchr>:

char* strchr(const char* s, int c) {
   43c66:	f3 0f 1e fa          	endbr64 
   43c6a:	55                   	push   %rbp
   43c6b:	48 89 e5             	mov    %rsp,%rbp
   43c6e:	48 83 ec 10          	sub    $0x10,%rsp
   43c72:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43c76:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43c79:	eb 05                	jmp    43c80 <strchr+0x1a>
        ++s;
   43c7b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43c80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c84:	0f b6 00             	movzbl (%rax),%eax
   43c87:	84 c0                	test   %al,%al
   43c89:	74 0e                	je     43c99 <strchr+0x33>
   43c8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c8f:	0f b6 00             	movzbl (%rax),%eax
   43c92:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43c95:	38 d0                	cmp    %dl,%al
   43c97:	75 e2                	jne    43c7b <strchr+0x15>
    }
    if (*s == (char) c) {
   43c99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c9d:	0f b6 00             	movzbl (%rax),%eax
   43ca0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43ca3:	38 d0                	cmp    %dl,%al
   43ca5:	75 06                	jne    43cad <strchr+0x47>
        return (char*) s;
   43ca7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cab:	eb 05                	jmp    43cb2 <strchr+0x4c>
    } else {
        return NULL;
   43cad:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43cb2:	c9                   	leave  
   43cb3:	c3                   	ret    

0000000000043cb4 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43cb4:	f3 0f 1e fa          	endbr64 
   43cb8:	55                   	push   %rbp
   43cb9:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43cbc:	8b 05 3e 73 01 00    	mov    0x1733e(%rip),%eax        # 5b000 <rand_seed_set>
   43cc2:	85 c0                	test   %eax,%eax
   43cc4:	75 0a                	jne    43cd0 <rand+0x1c>
        srand(819234718U);
   43cc6:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43ccb:	e8 24 00 00 00       	call   43cf4 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43cd0:	8b 05 2e 73 01 00    	mov    0x1732e(%rip),%eax        # 5b004 <rand_seed>
   43cd6:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43cdc:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43ce1:	89 05 1d 73 01 00    	mov    %eax,0x1731d(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   43ce7:	8b 05 17 73 01 00    	mov    0x17317(%rip),%eax        # 5b004 <rand_seed>
   43ced:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43cf2:	5d                   	pop    %rbp
   43cf3:	c3                   	ret    

0000000000043cf4 <srand>:

void srand(unsigned seed) {
   43cf4:	f3 0f 1e fa          	endbr64 
   43cf8:	55                   	push   %rbp
   43cf9:	48 89 e5             	mov    %rsp,%rbp
   43cfc:	48 83 ec 08          	sub    $0x8,%rsp
   43d00:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43d03:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43d06:	89 05 f8 72 01 00    	mov    %eax,0x172f8(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   43d0c:	c7 05 ea 72 01 00 01 	movl   $0x1,0x172ea(%rip)        # 5b000 <rand_seed_set>
   43d13:	00 00 00 
}
   43d16:	90                   	nop
   43d17:	c9                   	leave  
   43d18:	c3                   	ret    

0000000000043d19 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43d19:	f3 0f 1e fa          	endbr64 
   43d1d:	55                   	push   %rbp
   43d1e:	48 89 e5             	mov    %rsp,%rbp
   43d21:	48 83 ec 28          	sub    $0x28,%rsp
   43d25:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d29:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43d2d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43d30:	48 8d 05 e9 18 00 00 	lea    0x18e9(%rip),%rax        # 45620 <upper_digits.1>
   43d37:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   43d3b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43d3f:	79 0e                	jns    43d4f <fill_numbuf+0x36>
        digits = lower_digits;
   43d41:	48 8d 05 f8 18 00 00 	lea    0x18f8(%rip),%rax        # 45640 <lower_digits.0>
   43d48:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   43d4c:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43d4f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43d54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d58:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43d5b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43d5e:	48 63 c8             	movslq %eax,%rcx
   43d61:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43d65:	ba 00 00 00 00       	mov    $0x0,%edx
   43d6a:	48 f7 f1             	div    %rcx
   43d6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d71:	48 01 d0             	add    %rdx,%rax
   43d74:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43d79:	0f b6 10             	movzbl (%rax),%edx
   43d7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d80:	88 10                	mov    %dl,(%rax)
        val /= base;
   43d82:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43d85:	48 63 f0             	movslq %eax,%rsi
   43d88:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43d8c:	ba 00 00 00 00       	mov    $0x0,%edx
   43d91:	48 f7 f6             	div    %rsi
   43d94:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43d98:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43d9d:	75 bc                	jne    43d5b <fill_numbuf+0x42>
    return numbuf_end;
   43d9f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43da3:	c9                   	leave  
   43da4:	c3                   	ret    

0000000000043da5 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43da5:	f3 0f 1e fa          	endbr64 
   43da9:	55                   	push   %rbp
   43daa:	48 89 e5             	mov    %rsp,%rbp
   43dad:	53                   	push   %rbx
   43dae:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43db5:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43dbc:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43dc2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43dc9:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43dd0:	e9 bd 09 00 00       	jmp    44792 <printer_vprintf+0x9ed>
        if (*format != '%') {
   43dd5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ddc:	0f b6 00             	movzbl (%rax),%eax
   43ddf:	3c 25                	cmp    $0x25,%al
   43de1:	74 31                	je     43e14 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   43de3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43dea:	4c 8b 00             	mov    (%rax),%r8
   43ded:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43df4:	0f b6 00             	movzbl (%rax),%eax
   43df7:	0f b6 c8             	movzbl %al,%ecx
   43dfa:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43e00:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43e07:	89 ce                	mov    %ecx,%esi
   43e09:	48 89 c7             	mov    %rax,%rdi
   43e0c:	41 ff d0             	call   *%r8
            continue;
   43e0f:	e9 76 09 00 00       	jmp    4478a <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   43e14:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43e1b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43e22:	01 
   43e23:	eb 4d                	jmp    43e72 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   43e25:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e2c:	0f b6 00             	movzbl (%rax),%eax
   43e2f:	0f be c0             	movsbl %al,%eax
   43e32:	89 c6                	mov    %eax,%esi
   43e34:	48 8d 05 e5 16 00 00 	lea    0x16e5(%rip),%rax        # 45520 <flag_chars>
   43e3b:	48 89 c7             	mov    %rax,%rdi
   43e3e:	e8 23 fe ff ff       	call   43c66 <strchr>
   43e43:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43e47:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43e4c:	74 34                	je     43e82 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   43e4e:	48 8d 15 cb 16 00 00 	lea    0x16cb(%rip),%rdx        # 45520 <flag_chars>
   43e55:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43e59:	48 29 d0             	sub    %rdx,%rax
   43e5c:	ba 01 00 00 00       	mov    $0x1,%edx
   43e61:	89 c1                	mov    %eax,%ecx
   43e63:	d3 e2                	shl    %cl,%edx
   43e65:	89 d0                	mov    %edx,%eax
   43e67:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43e6a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43e71:	01 
   43e72:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e79:	0f b6 00             	movzbl (%rax),%eax
   43e7c:	84 c0                	test   %al,%al
   43e7e:	75 a5                	jne    43e25 <printer_vprintf+0x80>
   43e80:	eb 01                	jmp    43e83 <printer_vprintf+0xde>
            } else {
                break;
   43e82:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43e83:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43e8a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e91:	0f b6 00             	movzbl (%rax),%eax
   43e94:	3c 30                	cmp    $0x30,%al
   43e96:	7e 67                	jle    43eff <printer_vprintf+0x15a>
   43e98:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e9f:	0f b6 00             	movzbl (%rax),%eax
   43ea2:	3c 39                	cmp    $0x39,%al
   43ea4:	7f 59                	jg     43eff <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43ea6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43ead:	eb 2e                	jmp    43edd <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   43eaf:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43eb2:	89 d0                	mov    %edx,%eax
   43eb4:	c1 e0 02             	shl    $0x2,%eax
   43eb7:	01 d0                	add    %edx,%eax
   43eb9:	01 c0                	add    %eax,%eax
   43ebb:	89 c1                	mov    %eax,%ecx
   43ebd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ec4:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43ec8:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43ecf:	0f b6 00             	movzbl (%rax),%eax
   43ed2:	0f be c0             	movsbl %al,%eax
   43ed5:	01 c8                	add    %ecx,%eax
   43ed7:	83 e8 30             	sub    $0x30,%eax
   43eda:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43edd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ee4:	0f b6 00             	movzbl (%rax),%eax
   43ee7:	3c 2f                	cmp    $0x2f,%al
   43ee9:	0f 8e 85 00 00 00    	jle    43f74 <printer_vprintf+0x1cf>
   43eef:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ef6:	0f b6 00             	movzbl (%rax),%eax
   43ef9:	3c 39                	cmp    $0x39,%al
   43efb:	7e b2                	jle    43eaf <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   43efd:	eb 75                	jmp    43f74 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   43eff:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f06:	0f b6 00             	movzbl (%rax),%eax
   43f09:	3c 2a                	cmp    $0x2a,%al
   43f0b:	75 68                	jne    43f75 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   43f0d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f14:	8b 00                	mov    (%rax),%eax
   43f16:	83 f8 2f             	cmp    $0x2f,%eax
   43f19:	77 30                	ja     43f4b <printer_vprintf+0x1a6>
   43f1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f22:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f26:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f2d:	8b 00                	mov    (%rax),%eax
   43f2f:	89 c0                	mov    %eax,%eax
   43f31:	48 01 d0             	add    %rdx,%rax
   43f34:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f3b:	8b 12                	mov    (%rdx),%edx
   43f3d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f40:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f47:	89 0a                	mov    %ecx,(%rdx)
   43f49:	eb 1a                	jmp    43f65 <printer_vprintf+0x1c0>
   43f4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f52:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f56:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f5a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f61:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f65:	8b 00                	mov    (%rax),%eax
   43f67:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43f6a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43f71:	01 
   43f72:	eb 01                	jmp    43f75 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   43f74:	90                   	nop
        }

        // process precision
        int precision = -1;
   43f75:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43f7c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f83:	0f b6 00             	movzbl (%rax),%eax
   43f86:	3c 2e                	cmp    $0x2e,%al
   43f88:	0f 85 00 01 00 00    	jne    4408e <printer_vprintf+0x2e9>
            ++format;
   43f8e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43f95:	01 
            if (*format >= '0' && *format <= '9') {
   43f96:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f9d:	0f b6 00             	movzbl (%rax),%eax
   43fa0:	3c 2f                	cmp    $0x2f,%al
   43fa2:	7e 67                	jle    4400b <printer_vprintf+0x266>
   43fa4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fab:	0f b6 00             	movzbl (%rax),%eax
   43fae:	3c 39                	cmp    $0x39,%al
   43fb0:	7f 59                	jg     4400b <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43fb2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43fb9:	eb 2e                	jmp    43fe9 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   43fbb:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43fbe:	89 d0                	mov    %edx,%eax
   43fc0:	c1 e0 02             	shl    $0x2,%eax
   43fc3:	01 d0                	add    %edx,%eax
   43fc5:	01 c0                	add    %eax,%eax
   43fc7:	89 c1                	mov    %eax,%ecx
   43fc9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fd0:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43fd4:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43fdb:	0f b6 00             	movzbl (%rax),%eax
   43fde:	0f be c0             	movsbl %al,%eax
   43fe1:	01 c8                	add    %ecx,%eax
   43fe3:	83 e8 30             	sub    $0x30,%eax
   43fe6:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43fe9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ff0:	0f b6 00             	movzbl (%rax),%eax
   43ff3:	3c 2f                	cmp    $0x2f,%al
   43ff5:	0f 8e 85 00 00 00    	jle    44080 <printer_vprintf+0x2db>
   43ffb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44002:	0f b6 00             	movzbl (%rax),%eax
   44005:	3c 39                	cmp    $0x39,%al
   44007:	7e b2                	jle    43fbb <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   44009:	eb 75                	jmp    44080 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   4400b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44012:	0f b6 00             	movzbl (%rax),%eax
   44015:	3c 2a                	cmp    $0x2a,%al
   44017:	75 68                	jne    44081 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   44019:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44020:	8b 00                	mov    (%rax),%eax
   44022:	83 f8 2f             	cmp    $0x2f,%eax
   44025:	77 30                	ja     44057 <printer_vprintf+0x2b2>
   44027:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4402e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44032:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44039:	8b 00                	mov    (%rax),%eax
   4403b:	89 c0                	mov    %eax,%eax
   4403d:	48 01 d0             	add    %rdx,%rax
   44040:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44047:	8b 12                	mov    (%rdx),%edx
   44049:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4404c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44053:	89 0a                	mov    %ecx,(%rdx)
   44055:	eb 1a                	jmp    44071 <printer_vprintf+0x2cc>
   44057:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4405e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44062:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44066:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4406d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44071:	8b 00                	mov    (%rax),%eax
   44073:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   44076:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4407d:	01 
   4407e:	eb 01                	jmp    44081 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   44080:	90                   	nop
            }
            if (precision < 0) {
   44081:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44085:	79 07                	jns    4408e <printer_vprintf+0x2e9>
                precision = 0;
   44087:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   4408e:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   44095:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   4409c:	00 
        int length = 0;
   4409d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   440a4:	48 8d 05 7b 14 00 00 	lea    0x147b(%rip),%rax        # 45526 <flag_chars+0x6>
   440ab:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   440af:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440b6:	0f b6 00             	movzbl (%rax),%eax
   440b9:	0f be c0             	movsbl %al,%eax
   440bc:	83 e8 43             	sub    $0x43,%eax
   440bf:	83 f8 37             	cmp    $0x37,%eax
   440c2:	0f 87 b6 03 00 00    	ja     4447e <printer_vprintf+0x6d9>
   440c8:	89 c0                	mov    %eax,%eax
   440ca:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   440d1:	00 
   440d2:	48 8d 05 5b 14 00 00 	lea    0x145b(%rip),%rax        # 45534 <flag_chars+0x14>
   440d9:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   440dc:	48 98                	cltq   
   440de:	48 8d 15 4f 14 00 00 	lea    0x144f(%rip),%rdx        # 45534 <flag_chars+0x14>
   440e5:	48 01 d0             	add    %rdx,%rax
   440e8:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   440eb:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   440f2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   440f9:	01 
            goto again;
   440fa:	eb b3                	jmp    440af <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   440fc:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44100:	74 5d                	je     4415f <printer_vprintf+0x3ba>
   44102:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44109:	8b 00                	mov    (%rax),%eax
   4410b:	83 f8 2f             	cmp    $0x2f,%eax
   4410e:	77 30                	ja     44140 <printer_vprintf+0x39b>
   44110:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44117:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4411b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44122:	8b 00                	mov    (%rax),%eax
   44124:	89 c0                	mov    %eax,%eax
   44126:	48 01 d0             	add    %rdx,%rax
   44129:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44130:	8b 12                	mov    (%rdx),%edx
   44132:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44135:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4413c:	89 0a                	mov    %ecx,(%rdx)
   4413e:	eb 1a                	jmp    4415a <printer_vprintf+0x3b5>
   44140:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44147:	48 8b 40 08          	mov    0x8(%rax),%rax
   4414b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4414f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44156:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4415a:	48 8b 00             	mov    (%rax),%rax
   4415d:	eb 5c                	jmp    441bb <printer_vprintf+0x416>
   4415f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44166:	8b 00                	mov    (%rax),%eax
   44168:	83 f8 2f             	cmp    $0x2f,%eax
   4416b:	77 30                	ja     4419d <printer_vprintf+0x3f8>
   4416d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44174:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44178:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4417f:	8b 00                	mov    (%rax),%eax
   44181:	89 c0                	mov    %eax,%eax
   44183:	48 01 d0             	add    %rdx,%rax
   44186:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4418d:	8b 12                	mov    (%rdx),%edx
   4418f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44192:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44199:	89 0a                	mov    %ecx,(%rdx)
   4419b:	eb 1a                	jmp    441b7 <printer_vprintf+0x412>
   4419d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441a4:	48 8b 40 08          	mov    0x8(%rax),%rax
   441a8:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441ac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441b3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441b7:	8b 00                	mov    (%rax),%eax
   441b9:	48 98                	cltq   
   441bb:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   441bf:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   441c3:	48 c1 f8 38          	sar    $0x38,%rax
   441c7:	25 80 00 00 00       	and    $0x80,%eax
   441cc:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   441cf:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   441d3:	74 09                	je     441de <printer_vprintf+0x439>
   441d5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   441d9:	48 f7 d8             	neg    %rax
   441dc:	eb 04                	jmp    441e2 <printer_vprintf+0x43d>
   441de:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   441e2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   441e6:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   441e9:	83 c8 60             	or     $0x60,%eax
   441ec:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   441ef:	e9 cf 02 00 00       	jmp    444c3 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   441f4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   441f8:	74 5d                	je     44257 <printer_vprintf+0x4b2>
   441fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44201:	8b 00                	mov    (%rax),%eax
   44203:	83 f8 2f             	cmp    $0x2f,%eax
   44206:	77 30                	ja     44238 <printer_vprintf+0x493>
   44208:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4420f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44213:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4421a:	8b 00                	mov    (%rax),%eax
   4421c:	89 c0                	mov    %eax,%eax
   4421e:	48 01 d0             	add    %rdx,%rax
   44221:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44228:	8b 12                	mov    (%rdx),%edx
   4422a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4422d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44234:	89 0a                	mov    %ecx,(%rdx)
   44236:	eb 1a                	jmp    44252 <printer_vprintf+0x4ad>
   44238:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4423f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44243:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44247:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4424e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44252:	48 8b 00             	mov    (%rax),%rax
   44255:	eb 5c                	jmp    442b3 <printer_vprintf+0x50e>
   44257:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4425e:	8b 00                	mov    (%rax),%eax
   44260:	83 f8 2f             	cmp    $0x2f,%eax
   44263:	77 30                	ja     44295 <printer_vprintf+0x4f0>
   44265:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4426c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44270:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44277:	8b 00                	mov    (%rax),%eax
   44279:	89 c0                	mov    %eax,%eax
   4427b:	48 01 d0             	add    %rdx,%rax
   4427e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44285:	8b 12                	mov    (%rdx),%edx
   44287:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4428a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44291:	89 0a                	mov    %ecx,(%rdx)
   44293:	eb 1a                	jmp    442af <printer_vprintf+0x50a>
   44295:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4429c:	48 8b 40 08          	mov    0x8(%rax),%rax
   442a0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442a4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442ab:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442af:	8b 00                	mov    (%rax),%eax
   442b1:	89 c0                	mov    %eax,%eax
   442b3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   442b7:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   442bb:	e9 03 02 00 00       	jmp    444c3 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   442c0:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   442c7:	e9 28 ff ff ff       	jmp    441f4 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   442cc:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   442d3:	e9 1c ff ff ff       	jmp    441f4 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   442d8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442df:	8b 00                	mov    (%rax),%eax
   442e1:	83 f8 2f             	cmp    $0x2f,%eax
   442e4:	77 30                	ja     44316 <printer_vprintf+0x571>
   442e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442ed:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442f1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442f8:	8b 00                	mov    (%rax),%eax
   442fa:	89 c0                	mov    %eax,%eax
   442fc:	48 01 d0             	add    %rdx,%rax
   442ff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44306:	8b 12                	mov    (%rdx),%edx
   44308:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4430b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44312:	89 0a                	mov    %ecx,(%rdx)
   44314:	eb 1a                	jmp    44330 <printer_vprintf+0x58b>
   44316:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4431d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44321:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44325:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4432c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44330:	48 8b 00             	mov    (%rax),%rax
   44333:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   44337:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   4433e:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   44345:	e9 79 01 00 00       	jmp    444c3 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   4434a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44351:	8b 00                	mov    (%rax),%eax
   44353:	83 f8 2f             	cmp    $0x2f,%eax
   44356:	77 30                	ja     44388 <printer_vprintf+0x5e3>
   44358:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4435f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44363:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4436a:	8b 00                	mov    (%rax),%eax
   4436c:	89 c0                	mov    %eax,%eax
   4436e:	48 01 d0             	add    %rdx,%rax
   44371:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44378:	8b 12                	mov    (%rdx),%edx
   4437a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4437d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44384:	89 0a                	mov    %ecx,(%rdx)
   44386:	eb 1a                	jmp    443a2 <printer_vprintf+0x5fd>
   44388:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4438f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44393:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44397:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4439e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443a2:	48 8b 00             	mov    (%rax),%rax
   443a5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   443a9:	e9 15 01 00 00       	jmp    444c3 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   443ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443b5:	8b 00                	mov    (%rax),%eax
   443b7:	83 f8 2f             	cmp    $0x2f,%eax
   443ba:	77 30                	ja     443ec <printer_vprintf+0x647>
   443bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443c3:	48 8b 50 10          	mov    0x10(%rax),%rdx
   443c7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ce:	8b 00                	mov    (%rax),%eax
   443d0:	89 c0                	mov    %eax,%eax
   443d2:	48 01 d0             	add    %rdx,%rax
   443d5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443dc:	8b 12                	mov    (%rdx),%edx
   443de:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443e1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443e8:	89 0a                	mov    %ecx,(%rdx)
   443ea:	eb 1a                	jmp    44406 <printer_vprintf+0x661>
   443ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443f3:	48 8b 40 08          	mov    0x8(%rax),%rax
   443f7:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443fb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44402:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44406:	8b 00                	mov    (%rax),%eax
   44408:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   4440e:	e9 77 03 00 00       	jmp    4478a <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   44413:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44417:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   4441b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44422:	8b 00                	mov    (%rax),%eax
   44424:	83 f8 2f             	cmp    $0x2f,%eax
   44427:	77 30                	ja     44459 <printer_vprintf+0x6b4>
   44429:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44430:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44434:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4443b:	8b 00                	mov    (%rax),%eax
   4443d:	89 c0                	mov    %eax,%eax
   4443f:	48 01 d0             	add    %rdx,%rax
   44442:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44449:	8b 12                	mov    (%rdx),%edx
   4444b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4444e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44455:	89 0a                	mov    %ecx,(%rdx)
   44457:	eb 1a                	jmp    44473 <printer_vprintf+0x6ce>
   44459:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44460:	48 8b 40 08          	mov    0x8(%rax),%rax
   44464:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44468:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4446f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44473:	8b 00                	mov    (%rax),%eax
   44475:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44478:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   4447c:	eb 45                	jmp    444c3 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   4447e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44482:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   44486:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4448d:	0f b6 00             	movzbl (%rax),%eax
   44490:	84 c0                	test   %al,%al
   44492:	74 0c                	je     444a0 <printer_vprintf+0x6fb>
   44494:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4449b:	0f b6 00             	movzbl (%rax),%eax
   4449e:	eb 05                	jmp    444a5 <printer_vprintf+0x700>
   444a0:	b8 25 00 00 00       	mov    $0x25,%eax
   444a5:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   444a8:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   444ac:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   444b3:	0f b6 00             	movzbl (%rax),%eax
   444b6:	84 c0                	test   %al,%al
   444b8:	75 08                	jne    444c2 <printer_vprintf+0x71d>
                format--;
   444ba:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   444c1:	01 
            }
            break;
   444c2:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   444c3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   444c6:	83 e0 20             	and    $0x20,%eax
   444c9:	85 c0                	test   %eax,%eax
   444cb:	74 1e                	je     444eb <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   444cd:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   444d1:	48 83 c0 18          	add    $0x18,%rax
   444d5:	8b 55 e0             	mov    -0x20(%rbp),%edx
   444d8:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   444dc:	48 89 ce             	mov    %rcx,%rsi
   444df:	48 89 c7             	mov    %rax,%rdi
   444e2:	e8 32 f8 ff ff       	call   43d19 <fill_numbuf>
   444e7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   444eb:	48 8d 05 34 10 00 00 	lea    0x1034(%rip),%rax        # 45526 <flag_chars+0x6>
   444f2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   444f6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   444f9:	83 e0 20             	and    $0x20,%eax
   444fc:	85 c0                	test   %eax,%eax
   444fe:	74 51                	je     44551 <printer_vprintf+0x7ac>
   44500:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44503:	83 e0 40             	and    $0x40,%eax
   44506:	85 c0                	test   %eax,%eax
   44508:	74 47                	je     44551 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   4450a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4450d:	25 80 00 00 00       	and    $0x80,%eax
   44512:	85 c0                	test   %eax,%eax
   44514:	74 0d                	je     44523 <printer_vprintf+0x77e>
                prefix = "-";
   44516:	48 8d 05 0a 10 00 00 	lea    0x100a(%rip),%rax        # 45527 <flag_chars+0x7>
   4451d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44521:	eb 7d                	jmp    445a0 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44523:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44526:	83 e0 10             	and    $0x10,%eax
   44529:	85 c0                	test   %eax,%eax
   4452b:	74 0d                	je     4453a <printer_vprintf+0x795>
                prefix = "+";
   4452d:	48 8d 05 f5 0f 00 00 	lea    0xff5(%rip),%rax        # 45529 <flag_chars+0x9>
   44534:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44538:	eb 66                	jmp    445a0 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   4453a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4453d:	83 e0 08             	and    $0x8,%eax
   44540:	85 c0                	test   %eax,%eax
   44542:	74 5c                	je     445a0 <printer_vprintf+0x7fb>
                prefix = " ";
   44544:	48 8d 05 e0 0f 00 00 	lea    0xfe0(%rip),%rax        # 4552b <flag_chars+0xb>
   4454b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   4454f:	eb 4f                	jmp    445a0 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44551:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44554:	83 e0 20             	and    $0x20,%eax
   44557:	85 c0                	test   %eax,%eax
   44559:	74 46                	je     445a1 <printer_vprintf+0x7fc>
   4455b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4455e:	83 e0 01             	and    $0x1,%eax
   44561:	85 c0                	test   %eax,%eax
   44563:	74 3c                	je     445a1 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   44565:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   44569:	74 06                	je     44571 <printer_vprintf+0x7cc>
   4456b:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4456f:	75 30                	jne    445a1 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   44571:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44576:	75 0c                	jne    44584 <printer_vprintf+0x7df>
   44578:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4457b:	25 00 01 00 00       	and    $0x100,%eax
   44580:	85 c0                	test   %eax,%eax
   44582:	74 1d                	je     445a1 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   44584:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44588:	75 09                	jne    44593 <printer_vprintf+0x7ee>
   4458a:	48 8d 05 9c 0f 00 00 	lea    0xf9c(%rip),%rax        # 4552d <flag_chars+0xd>
   44591:	eb 07                	jmp    4459a <printer_vprintf+0x7f5>
   44593:	48 8d 05 96 0f 00 00 	lea    0xf96(%rip),%rax        # 45530 <flag_chars+0x10>
   4459a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4459e:	eb 01                	jmp    445a1 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   445a0:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   445a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   445a5:	78 24                	js     445cb <printer_vprintf+0x826>
   445a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   445aa:	83 e0 20             	and    $0x20,%eax
   445ad:	85 c0                	test   %eax,%eax
   445af:	75 1a                	jne    445cb <printer_vprintf+0x826>
            len = strnlen(data, precision);
   445b1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   445b4:	48 63 d0             	movslq %eax,%rdx
   445b7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   445bb:	48 89 d6             	mov    %rdx,%rsi
   445be:	48 89 c7             	mov    %rax,%rdi
   445c1:	e8 91 f5 ff ff       	call   43b57 <strnlen>
   445c6:	89 45 bc             	mov    %eax,-0x44(%rbp)
   445c9:	eb 0f                	jmp    445da <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   445cb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   445cf:	48 89 c7             	mov    %rax,%rdi
   445d2:	e8 4b f5 ff ff       	call   43b22 <strlen>
   445d7:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   445da:	8b 45 ec             	mov    -0x14(%rbp),%eax
   445dd:	83 e0 20             	and    $0x20,%eax
   445e0:	85 c0                	test   %eax,%eax
   445e2:	74 20                	je     44604 <printer_vprintf+0x85f>
   445e4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   445e8:	78 1a                	js     44604 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   445ea:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   445ed:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   445f0:	7e 08                	jle    445fa <printer_vprintf+0x855>
   445f2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   445f5:	2b 45 bc             	sub    -0x44(%rbp),%eax
   445f8:	eb 05                	jmp    445ff <printer_vprintf+0x85a>
   445fa:	b8 00 00 00 00       	mov    $0x0,%eax
   445ff:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44602:	eb 5c                	jmp    44660 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44604:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44607:	83 e0 20             	and    $0x20,%eax
   4460a:	85 c0                	test   %eax,%eax
   4460c:	74 4b                	je     44659 <printer_vprintf+0x8b4>
   4460e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44611:	83 e0 02             	and    $0x2,%eax
   44614:	85 c0                	test   %eax,%eax
   44616:	74 41                	je     44659 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44618:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4461b:	83 e0 04             	and    $0x4,%eax
   4461e:	85 c0                	test   %eax,%eax
   44620:	75 37                	jne    44659 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   44622:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44626:	48 89 c7             	mov    %rax,%rdi
   44629:	e8 f4 f4 ff ff       	call   43b22 <strlen>
   4462e:	89 c2                	mov    %eax,%edx
   44630:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44633:	01 d0                	add    %edx,%eax
   44635:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44638:	7e 1f                	jle    44659 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   4463a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4463d:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44640:	89 c3                	mov    %eax,%ebx
   44642:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44646:	48 89 c7             	mov    %rax,%rdi
   44649:	e8 d4 f4 ff ff       	call   43b22 <strlen>
   4464e:	89 c2                	mov    %eax,%edx
   44650:	89 d8                	mov    %ebx,%eax
   44652:	29 d0                	sub    %edx,%eax
   44654:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44657:	eb 07                	jmp    44660 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   44659:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44660:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44663:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44666:	01 d0                	add    %edx,%eax
   44668:	48 63 d8             	movslq %eax,%rbx
   4466b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4466f:	48 89 c7             	mov    %rax,%rdi
   44672:	e8 ab f4 ff ff       	call   43b22 <strlen>
   44677:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   4467b:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4467e:	29 d0                	sub    %edx,%eax
   44680:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44683:	eb 25                	jmp    446aa <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   44685:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4468c:	48 8b 08             	mov    (%rax),%rcx
   4468f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44695:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4469c:	be 20 00 00 00       	mov    $0x20,%esi
   446a1:	48 89 c7             	mov    %rax,%rdi
   446a4:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   446a6:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   446aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446ad:	83 e0 04             	and    $0x4,%eax
   446b0:	85 c0                	test   %eax,%eax
   446b2:	75 36                	jne    446ea <printer_vprintf+0x945>
   446b4:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   446b8:	7f cb                	jg     44685 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   446ba:	eb 2e                	jmp    446ea <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   446bc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   446c3:	4c 8b 00             	mov    (%rax),%r8
   446c6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   446ca:	0f b6 00             	movzbl (%rax),%eax
   446cd:	0f b6 c8             	movzbl %al,%ecx
   446d0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   446d6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   446dd:	89 ce                	mov    %ecx,%esi
   446df:	48 89 c7             	mov    %rax,%rdi
   446e2:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   446e5:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   446ea:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   446ee:	0f b6 00             	movzbl (%rax),%eax
   446f1:	84 c0                	test   %al,%al
   446f3:	75 c7                	jne    446bc <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   446f5:	eb 25                	jmp    4471c <printer_vprintf+0x977>
            p->putc(p, '0', color);
   446f7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   446fe:	48 8b 08             	mov    (%rax),%rcx
   44701:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44707:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4470e:	be 30 00 00 00       	mov    $0x30,%esi
   44713:	48 89 c7             	mov    %rax,%rdi
   44716:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44718:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   4471c:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44720:	7f d5                	jg     446f7 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   44722:	eb 32                	jmp    44756 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   44724:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4472b:	4c 8b 00             	mov    (%rax),%r8
   4472e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44732:	0f b6 00             	movzbl (%rax),%eax
   44735:	0f b6 c8             	movzbl %al,%ecx
   44738:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4473e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44745:	89 ce                	mov    %ecx,%esi
   44747:	48 89 c7             	mov    %rax,%rdi
   4474a:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   4474d:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44752:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44756:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   4475a:	7f c8                	jg     44724 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   4475c:	eb 25                	jmp    44783 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   4475e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44765:	48 8b 08             	mov    (%rax),%rcx
   44768:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4476e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44775:	be 20 00 00 00       	mov    $0x20,%esi
   4477a:	48 89 c7             	mov    %rax,%rdi
   4477d:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   4477f:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44783:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44787:	7f d5                	jg     4475e <printer_vprintf+0x9b9>
        }
    done: ;
   44789:	90                   	nop
    for (; *format; ++format) {
   4478a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44791:	01 
   44792:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44799:	0f b6 00             	movzbl (%rax),%eax
   4479c:	84 c0                	test   %al,%al
   4479e:	0f 85 31 f6 ff ff    	jne    43dd5 <printer_vprintf+0x30>
    }
}
   447a4:	90                   	nop
   447a5:	90                   	nop
   447a6:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   447aa:	c9                   	leave  
   447ab:	c3                   	ret    

00000000000447ac <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   447ac:	f3 0f 1e fa          	endbr64 
   447b0:	55                   	push   %rbp
   447b1:	48 89 e5             	mov    %rsp,%rbp
   447b4:	48 83 ec 20          	sub    $0x20,%rsp
   447b8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   447bc:	89 f0                	mov    %esi,%eax
   447be:	89 55 e0             	mov    %edx,-0x20(%rbp)
   447c1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   447c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   447c8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   447cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   447d0:	48 8b 40 08          	mov    0x8(%rax),%rax
   447d4:	48 8d 15 c5 47 07 00 	lea    0x747c5(%rip),%rdx        # b8fa0 <console+0xfa0>
   447db:	48 39 d0             	cmp    %rdx,%rax
   447de:	72 0f                	jb     447ef <console_putc+0x43>
        cp->cursor = console;
   447e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   447e4:	48 8d 15 15 38 07 00 	lea    0x73815(%rip),%rdx        # b8000 <console>
   447eb:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   447ef:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   447f3:	0f 85 82 00 00 00    	jne    4487b <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   447f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   447fd:	48 8b 40 08          	mov    0x8(%rax),%rax
   44801:	48 8d 15 f8 37 07 00 	lea    0x737f8(%rip),%rdx        # b8000 <console>
   44808:	48 29 d0             	sub    %rdx,%rax
   4480b:	48 d1 f8             	sar    %rax
   4480e:	48 89 c1             	mov    %rax,%rcx
   44811:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44818:	66 66 66 
   4481b:	48 89 c8             	mov    %rcx,%rax
   4481e:	48 f7 ea             	imul   %rdx
   44821:	48 89 d0             	mov    %rdx,%rax
   44824:	48 c1 f8 05          	sar    $0x5,%rax
   44828:	48 89 ce             	mov    %rcx,%rsi
   4482b:	48 c1 fe 3f          	sar    $0x3f,%rsi
   4482f:	48 29 f0             	sub    %rsi,%rax
   44832:	48 89 c2             	mov    %rax,%rdx
   44835:	48 89 d0             	mov    %rdx,%rax
   44838:	48 c1 e0 02          	shl    $0x2,%rax
   4483c:	48 01 d0             	add    %rdx,%rax
   4483f:	48 c1 e0 04          	shl    $0x4,%rax
   44843:	48 29 c1             	sub    %rax,%rcx
   44846:	48 89 ca             	mov    %rcx,%rdx
   44849:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   4484c:	eb 25                	jmp    44873 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   4484e:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44851:	83 c8 20             	or     $0x20,%eax
   44854:	89 c6                	mov    %eax,%esi
   44856:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4485a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4485e:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44862:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44866:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4486a:	89 f2                	mov    %esi,%edx
   4486c:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   4486f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44873:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44877:	75 d5                	jne    4484e <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44879:	eb 24                	jmp    4489f <console_putc+0xf3>
        *cp->cursor++ = c | color;
   4487b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   4487f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44882:	89 d6                	mov    %edx,%esi
   44884:	09 c6                	or     %eax,%esi
   44886:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4488a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4488e:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44892:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44896:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4489a:	89 f2                	mov    %esi,%edx
   4489c:	66 89 10             	mov    %dx,(%rax)
}
   4489f:	90                   	nop
   448a0:	c9                   	leave  
   448a1:	c3                   	ret    

00000000000448a2 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   448a2:	f3 0f 1e fa          	endbr64 
   448a6:	55                   	push   %rbp
   448a7:	48 89 e5             	mov    %rsp,%rbp
   448aa:	48 83 ec 30          	sub    $0x30,%rsp
   448ae:	89 7d ec             	mov    %edi,-0x14(%rbp)
   448b1:	89 75 e8             	mov    %esi,-0x18(%rbp)
   448b4:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   448b8:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   448bc:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 447ac <console_putc>
   448c3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   448c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   448cb:	78 09                	js     448d6 <console_vprintf+0x34>
   448cd:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   448d4:	7e 07                	jle    448dd <console_vprintf+0x3b>
        cpos = 0;
   448d6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   448dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   448e0:	48 98                	cltq   
   448e2:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   448e6:	48 8d 05 13 37 07 00 	lea    0x73713(%rip),%rax        # b8000 <console>
   448ed:	48 01 d0             	add    %rdx,%rax
   448f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   448f4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   448f8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   448fc:	8b 75 e8             	mov    -0x18(%rbp),%esi
   448ff:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44903:	48 89 c7             	mov    %rax,%rdi
   44906:	e8 9a f4 ff ff       	call   43da5 <printer_vprintf>
    return cp.cursor - console;
   4490b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4490f:	48 8d 15 ea 36 07 00 	lea    0x736ea(%rip),%rdx        # b8000 <console>
   44916:	48 29 d0             	sub    %rdx,%rax
   44919:	48 d1 f8             	sar    %rax
}
   4491c:	c9                   	leave  
   4491d:	c3                   	ret    

000000000004491e <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   4491e:	f3 0f 1e fa          	endbr64 
   44922:	55                   	push   %rbp
   44923:	48 89 e5             	mov    %rsp,%rbp
   44926:	48 83 ec 60          	sub    $0x60,%rsp
   4492a:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4492d:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44930:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44934:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44938:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4493c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44940:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44947:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4494b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4494f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44953:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44957:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4495b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4495f:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44962:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44965:	89 c7                	mov    %eax,%edi
   44967:	e8 36 ff ff ff       	call   448a2 <console_vprintf>
   4496c:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4496f:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44972:	c9                   	leave  
   44973:	c3                   	ret    

0000000000044974 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44974:	f3 0f 1e fa          	endbr64 
   44978:	55                   	push   %rbp
   44979:	48 89 e5             	mov    %rsp,%rbp
   4497c:	48 83 ec 20          	sub    $0x20,%rsp
   44980:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44984:	89 f0                	mov    %esi,%eax
   44986:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44989:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   4498c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44990:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44994:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44998:	48 8b 50 08          	mov    0x8(%rax),%rdx
   4499c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   449a0:	48 8b 40 10          	mov    0x10(%rax),%rax
   449a4:	48 39 c2             	cmp    %rax,%rdx
   449a7:	73 1a                	jae    449c3 <string_putc+0x4f>
        *sp->s++ = c;
   449a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   449ad:	48 8b 40 08          	mov    0x8(%rax),%rax
   449b1:	48 8d 48 01          	lea    0x1(%rax),%rcx
   449b5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   449b9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449bd:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   449c1:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   449c3:	90                   	nop
   449c4:	c9                   	leave  
   449c5:	c3                   	ret    

00000000000449c6 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   449c6:	f3 0f 1e fa          	endbr64 
   449ca:	55                   	push   %rbp
   449cb:	48 89 e5             	mov    %rsp,%rbp
   449ce:	48 83 ec 40          	sub    $0x40,%rsp
   449d2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   449d6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   449da:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   449de:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   449e2:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 44974 <string_putc>
   449e9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   449ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   449f1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   449f5:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   449fa:	74 33                	je     44a2f <vsnprintf+0x69>
        sp.end = s + size - 1;
   449fc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44a00:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44a04:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44a08:	48 01 d0             	add    %rdx,%rax
   44a0b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44a0f:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44a13:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44a17:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44a1b:	be 00 00 00 00       	mov    $0x0,%esi
   44a20:	48 89 c7             	mov    %rax,%rdi
   44a23:	e8 7d f3 ff ff       	call   43da5 <printer_vprintf>
        *sp.s = 0;
   44a28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a2c:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44a2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a33:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44a37:	c9                   	leave  
   44a38:	c3                   	ret    

0000000000044a39 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44a39:	f3 0f 1e fa          	endbr64 
   44a3d:	55                   	push   %rbp
   44a3e:	48 89 e5             	mov    %rsp,%rbp
   44a41:	48 83 ec 70          	sub    $0x70,%rsp
   44a45:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44a49:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44a4d:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44a51:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44a55:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44a59:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44a5d:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44a64:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44a68:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44a6c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44a70:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44a74:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44a78:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44a7c:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44a80:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44a84:	48 89 c7             	mov    %rax,%rdi
   44a87:	e8 3a ff ff ff       	call   449c6 <vsnprintf>
   44a8c:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44a8f:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44a92:	c9                   	leave  
   44a93:	c3                   	ret    

0000000000044a94 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44a94:	f3 0f 1e fa          	endbr64 
   44a98:	55                   	push   %rbp
   44a99:	48 89 e5             	mov    %rsp,%rbp
   44a9c:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44aa0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44aa7:	eb 1a                	jmp    44ac3 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   44aa9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44aac:	48 98                	cltq   
   44aae:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44ab2:	48 8d 05 47 35 07 00 	lea    0x73547(%rip),%rax        # b8000 <console>
   44ab9:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44abf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44ac3:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44aca:	7e dd                	jle    44aa9 <console_clear+0x15>
    }
    cursorpos = 0;
   44acc:	c7 05 26 45 07 00 00 	movl   $0x0,0x74526(%rip)        # b8ffc <cursorpos>
   44ad3:	00 00 00 
}
   44ad6:	90                   	nop
   44ad7:	c9                   	leave  
   44ad8:	c3                   	ret    
