
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
   400be:	e8 f7 07 00 00       	call   408ba <exception>

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
   40177:	e8 0c 17 00 00       	call   41888 <hardware_init>
    pageinfo_init();
   4017c:	e8 0c 0c 00 00       	call   40d8d <pageinfo_init>
    console_clear();
   40181:	e8 9d 43 00 00       	call   44523 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 60 1c 00 00       	call   41df0 <timer_init>


    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 7f 1e 01 00 	lea    0x11e7f(%rip),%rax        # 52020 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 c5 33 00 00       	call   4356e <memset>
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
   40210:	48 8d 15 69 43 00 00 	lea    0x4369(%rip),%rdx        # 44580 <console_clear+0x5d>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 55 34 00 00       	call   43677 <strcmp>
   40222:	85 c0                	test   %eax,%eax
   40224:	75 14                	jne    4023a <kernel+0xd3>
        process_setup(1, 4);
   40226:	be 04 00 00 00       	mov    $0x4,%esi
   4022b:	bf 01 00 00 00       	mov    $0x1,%edi
   40230:	e8 d3 01 00 00       	call   40408 <process_setup>
   40235:	e9 d1 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4023a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4023f:	74 2e                	je     4026f <kernel+0x108>
   40241:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40245:	48 8d 15 39 43 00 00 	lea    0x4339(%rip),%rdx        # 44585 <console_clear+0x62>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 20 34 00 00       	call   43677 <strcmp>
   40257:	85 c0                	test   %eax,%eax
   40259:	75 14                	jne    4026f <kernel+0x108>
        process_setup(1, 5);
   4025b:	be 05 00 00 00       	mov    $0x5,%esi
   40260:	bf 01 00 00 00       	mov    $0x1,%edi
   40265:	e8 9e 01 00 00       	call   40408 <process_setup>
   4026a:	e9 9c 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test") == 0) {
   4026f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40274:	74 2b                	je     402a1 <kernel+0x13a>
   40276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4027a:	48 8d 15 0d 43 00 00 	lea    0x430d(%rip),%rdx        # 4458e <console_clear+0x6b>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 eb 33 00 00       	call   43677 <strcmp>
   4028c:	85 c0                	test   %eax,%eax
   4028e:	75 11                	jne    402a1 <kernel+0x13a>
        process_setup(1, 6);
   40290:	be 06 00 00 00       	mov    $0x6,%esi
   40295:	bf 01 00 00 00       	mov    $0x1,%edi
   4029a:	e8 69 01 00 00       	call   40408 <process_setup>
   4029f:	eb 6a                	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test2") == 0) {
   402a1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a6:	74 3e                	je     402e6 <kernel+0x17f>
   402a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402ac:	48 8d 15 e0 42 00 00 	lea    0x42e0(%rip),%rdx        # 44593 <console_clear+0x70>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 b9 33 00 00       	call   43677 <strcmp>
   402be:	85 c0                	test   %eax,%eax
   402c0:	75 24                	jne    402e6 <kernel+0x17f>
        for (pid_t i = 1; i <= 2; ++i) {
   402c2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402c9:	eb 13                	jmp    402de <kernel+0x177>
            process_setup(i, 6);
   402cb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402ce:	be 06 00 00 00       	mov    $0x6,%esi
   402d3:	89 c7                	mov    %eax,%edi
   402d5:	e8 2e 01 00 00       	call   40408 <process_setup>
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
   402fc:	e8 07 01 00 00       	call   40408 <process_setup>
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
   4032a:	e8 2e 29 00 00       	call   42c5d <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   4032f:	48 8d 15 ca 7c 07 00 	lea    0x77cca(%rip),%rdx        # b8000 <console>
   40336:	48 8d 35 c3 7c 07 00 	lea    0x77cc3(%rip),%rsi        # b8000 <console>
   4033d:	48 8b 05 bc 4c 01 00 	mov    0x14cbc(%rip),%rax        # 55000 <kernel_pagetable>
   40344:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4034a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4034f:	48 89 c7             	mov    %rax,%rdi
   40352:	e8 06 29 00 00       	call   42c5d <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    // Switch to the first process using run()
    run(&processes[1]);
   40357:	48 8d 05 a2 1d 01 00 	lea    0x11da2(%rip),%rax        # 52100 <processes+0xe0>
   4035e:	48 89 c7             	mov    %rax,%rdi
   40361:	e8 bc 09 00 00       	call   40d22 <run>

0000000000040366 <allocate_page_table>:
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

// helper function for reserving pages which returns return its page address

x86_64_pagetable* allocate_page_table(int8_t owner) {
   40366:	f3 0f 1e fa          	endbr64 
   4036a:	55                   	push   %rbp
   4036b:	48 89 e5             	mov    %rsp,%rbp
   4036e:	48 83 ec 20          	sub    $0x20,%rsp
   40372:	89 f8                	mov    %edi,%eax
   40374:	88 45 ec             	mov    %al,-0x14(%rbp)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40377:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4037e:	00 
   4037f:	eb 76                	jmp    403f7 <allocate_page_table+0x91>
        if (pageinfo[PAGENUMBER(addr)].refcount == 0) {
   40381:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40385:	48 c1 e8 0c          	shr    $0xc,%rax
   40389:	48 98                	cltq   
   4038b:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4038f:	48 8d 05 ab 2a 01 00 	lea    0x12aab(%rip),%rax        # 52e41 <pageinfo+0x1>
   40396:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4039a:	84 c0                	test   %al,%al
   4039c:	75 51                	jne    403ef <allocate_page_table+0x89>
            pageinfo[PAGENUMBER(addr)].owner = owner;
   4039e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403a2:	48 c1 e8 0c          	shr    $0xc,%rax
   403a6:	48 98                	cltq   
   403a8:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   403ac:	48 8d 15 8d 2a 01 00 	lea    0x12a8d(%rip),%rdx        # 52e40 <pageinfo>
   403b3:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
   403b7:	88 04 11             	mov    %al,(%rcx,%rdx,1)
            pageinfo[PAGENUMBER(addr)].refcount = 1;
   403ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403be:	48 c1 e8 0c          	shr    $0xc,%rax
   403c2:	48 98                	cltq   
   403c4:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   403c8:	48 8d 05 72 2a 01 00 	lea    0x12a72(%rip),%rax        # 52e41 <pageinfo+0x1>
   403cf:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
            memset((void*) addr, 0, PAGESIZE);
   403d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403d7:	ba 00 10 00 00       	mov    $0x1000,%edx
   403dc:	be 00 00 00 00       	mov    $0x0,%esi
   403e1:	48 89 c7             	mov    %rax,%rdi
   403e4:	e8 85 31 00 00       	call   4356e <memset>
            return (x86_64_pagetable*) addr; 
   403e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403ed:	eb 17                	jmp    40406 <allocate_page_table+0xa0>
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   403ef:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   403f6:	00 
   403f7:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403fe:	00 
   403ff:	76 80                	jbe    40381 <allocate_page_table+0x1b>
        }
    }
    return NULL;
   40401:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40406:	c9                   	leave  
   40407:	c3                   	ret    

0000000000040408 <process_setup>:

void process_setup(pid_t pid, int program_number) {
   40408:	f3 0f 1e fa          	endbr64 
   4040c:	55                   	push   %rbp
   4040d:	48 89 e5             	mov    %rsp,%rbp
   40410:	48 83 ec 70          	sub    $0x70,%rsp
   40414:	89 7d 9c             	mov    %edi,-0x64(%rbp)
   40417:	89 75 98             	mov    %esi,-0x68(%rbp)
    process_init(&processes[pid], 0);
   4041a:	8b 45 9c             	mov    -0x64(%rbp),%eax
   4041d:	48 63 d0             	movslq %eax,%rdx
   40420:	48 89 d0             	mov    %rdx,%rax
   40423:	48 c1 e0 03          	shl    $0x3,%rax
   40427:	48 29 d0             	sub    %rdx,%rax
   4042a:	48 c1 e0 05          	shl    $0x5,%rax
   4042e:	48 8d 15 eb 1b 01 00 	lea    0x11beb(%rip),%rdx        # 52020 <processes>
   40435:	48 01 d0             	add    %rdx,%rax
   40438:	be 00 00 00 00       	mov    $0x0,%esi
   4043d:	48 89 c7             	mov    %rax,%rdi
   40440:	e8 5e 1c 00 00       	call   420a3 <process_init>
    x86_64_pagetable *l4 = allocate_page_table(pid);
   40445:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40448:	0f be c0             	movsbl %al,%eax
   4044b:	89 c7                	mov    %eax,%edi
   4044d:	e8 14 ff ff ff       	call   40366 <allocate_page_table>
   40452:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    x86_64_pagetable *l3 = allocate_page_table(pid);
   40456:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40459:	0f be c0             	movsbl %al,%eax
   4045c:	89 c7                	mov    %eax,%edi
   4045e:	e8 03 ff ff ff       	call   40366 <allocate_page_table>
   40463:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    x86_64_pagetable *l2 = allocate_page_table(pid);
   40467:	8b 45 9c             	mov    -0x64(%rbp),%eax
   4046a:	0f be c0             	movsbl %al,%eax
   4046d:	89 c7                	mov    %eax,%edi
   4046f:	e8 f2 fe ff ff       	call   40366 <allocate_page_table>
   40474:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    x86_64_pagetable *l1_1 = allocate_page_table(pid);
   40478:	8b 45 9c             	mov    -0x64(%rbp),%eax
   4047b:	0f be c0             	movsbl %al,%eax
   4047e:	89 c7                	mov    %eax,%edi
   40480:	e8 e1 fe ff ff       	call   40366 <allocate_page_table>
   40485:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    x86_64_pagetable *l1_0 = allocate_page_table(pid);
   40489:	8b 45 9c             	mov    -0x64(%rbp),%eax
   4048c:	0f be c0             	movsbl %al,%eax
   4048f:	89 c7                	mov    %eax,%edi
   40491:	e8 d0 fe ff ff       	call   40366 <allocate_page_table>
   40496:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

    l4->entry[0] = (x86_64_pageentry_t)l3 | PTE_P | PTE_W | PTE_U;
   4049a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4049e:	48 83 c8 07          	or     $0x7,%rax
   404a2:	48 89 c2             	mov    %rax,%rdx
   404a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   404a9:	48 89 10             	mov    %rdx,(%rax)
    l3->entry[0] = (x86_64_pageentry_t)l2 | PTE_P | PTE_W | PTE_U;
   404ac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   404b0:	48 83 c8 07          	or     $0x7,%rax
   404b4:	48 89 c2             	mov    %rax,%rdx
   404b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404bb:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[0] = (x86_64_pageentry_t)l1_0 | PTE_P | PTE_W | PTE_U;
   404be:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   404c2:	48 83 c8 07          	or     $0x7,%rax
   404c6:	48 89 c2             	mov    %rax,%rdx
   404c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   404cd:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[1] = (x86_64_pageentry_t)l1_1 | PTE_P | PTE_W | PTE_U;
   404d0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404d4:	48 83 c8 07          	or     $0x7,%rax
   404d8:	48 89 c2             	mov    %rax,%rdx
   404db:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   404df:	48 89 50 08          	mov    %rdx,0x8(%rax)

    for (uintptr_t i = 0; i < PROC_START_ADDR; i += PAGESIZE){
   404e3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   404ea:	00 
   404eb:	eb 66                	jmp    40553 <process_setup+0x14b>

        vamapping vam = virtual_memory_lookup(kernel_pagetable, i);
   404ed:	48 8b 0d 0c 4b 01 00 	mov    0x14b0c(%rip),%rcx        # 55000 <kernel_pagetable>
   404f4:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   404f8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   404fc:	48 89 ce             	mov    %rcx,%rsi
   404ff:	48 89 c7             	mov    %rax,%rdi
   40502:	e8 a0 2b 00 00       	call   430a7 <virtual_memory_lookup>
        if (vam.pn != -1){
   40507:	8b 45 a0             	mov    -0x60(%rbp),%eax
   4050a:	83 f8 ff             	cmp    $0xffffffff,%eax
   4050d:	74 3c                	je     4054b <process_setup+0x143>
        int r = virtual_memory_map(l4, i, vam.pa, PAGESIZE, vam.perm);
   4050f:	8b 4d b0             	mov    -0x50(%rbp),%ecx
   40512:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   40516:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4051a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4051e:	41 89 c8             	mov    %ecx,%r8d
   40521:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40526:	48 89 c7             	mov    %rax,%rdi
   40529:	e8 2f 27 00 00       	call   42c5d <virtual_memory_map>
   4052e:	89 45 bc             	mov    %eax,-0x44(%rbp)
        if (r != 0){
   40531:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   40535:	74 14                	je     4054b <process_setup+0x143>
            current->p_registers.reg_rax = -1;
   40537:	48 8b 05 c2 1a 01 00 	mov    0x11ac2(%rip),%rax        # 52000 <current>
   4053e:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40545:	ff 
   40546:	e9 a6 01 00 00       	jmp    406f1 <process_setup+0x2e9>
    for (uintptr_t i = 0; i < PROC_START_ADDR; i += PAGESIZE){
   4054b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40552:	00 
   40553:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   4055a:	00 
   4055b:	76 90                	jbe    404ed <process_setup+0xe5>
            return;
        }
        }
        
    }
    processes[pid].p_pagetable = l4;
   4055d:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40560:	48 63 d0             	movslq %eax,%rdx
   40563:	48 89 d0             	mov    %rdx,%rax
   40566:	48 c1 e0 03          	shl    $0x3,%rax
   4056a:	48 29 d0             	sub    %rdx,%rax
   4056d:	48 c1 e0 05          	shl    $0x5,%rax
   40571:	48 89 c1             	mov    %rax,%rcx
   40574:	48 8d 15 75 1b 01 00 	lea    0x11b75(%rip),%rdx        # 520f0 <processes+0xd0>
   4057b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4057f:	48 89 04 11          	mov    %rax,(%rcx,%rdx,1)
    // FIXME
    virtual_memory_map(l4, 0, 0,
   40583:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40587:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   4058d:	b9 00 00 10 00       	mov    $0x100000,%ecx
   40592:	ba 00 00 00 00       	mov    $0x0,%edx
   40597:	be 00 00 00 00       	mov    $0x0,%esi
   4059c:	48 89 c7             	mov    %rax,%rdi
   4059f:	e8 b9 26 00 00       	call   42c5d <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(l4, CONSOLE_ADDR, CONSOLE_ADDR,
   405a4:	48 8d 15 55 7a 07 00 	lea    0x77a55(%rip),%rdx        # b8000 <console>
   405ab:	48 8d 35 4e 7a 07 00 	lea    0x77a4e(%rip),%rsi        # b8000 <console>
   405b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   405b6:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   405bc:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405c1:	48 89 c7             	mov    %rax,%rdi
   405c4:	e8 94 26 00 00       	call   42c5d <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    int r = program_load(&processes[pid], program_number, NULL);
   405c9:	8b 45 9c             	mov    -0x64(%rbp),%eax
   405cc:	48 63 d0             	movslq %eax,%rdx
   405cf:	48 89 d0             	mov    %rdx,%rax
   405d2:	48 c1 e0 03          	shl    $0x3,%rax
   405d6:	48 29 d0             	sub    %rdx,%rax
   405d9:	48 c1 e0 05          	shl    $0x5,%rax
   405dd:	48 8d 15 3c 1a 01 00 	lea    0x11a3c(%rip),%rdx        # 52020 <processes>
   405e4:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
   405e8:	8b 45 98             	mov    -0x68(%rbp),%eax
   405eb:	ba 00 00 00 00       	mov    $0x0,%edx
   405f0:	89 c6                	mov    %eax,%esi
   405f2:	48 89 cf             	mov    %rcx,%rdi
   405f5:	e8 a8 2b 00 00       	call   431a2 <program_load>
   405fa:	89 45 cc             	mov    %eax,-0x34(%rbp)
    assert(r >= 0);
   405fd:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
   40601:	79 1e                	jns    40621 <process_setup+0x219>
   40603:	48 8d 05 8f 3f 00 00 	lea    0x3f8f(%rip),%rax        # 44599 <console_clear+0x76>
   4060a:	48 89 c2             	mov    %rax,%rdx
   4060d:	be b1 00 00 00       	mov    $0xb1,%esi
   40612:	48 8d 05 87 3f 00 00 	lea    0x3f87(%rip),%rax        # 445a0 <console_clear+0x7d>
   40619:	48 89 c7             	mov    %rax,%rdi
   4061c:	e8 b8 22 00 00       	call   428d9 <assert_fail>

    processes[pid].p_registers.reg_rsp = PROC_START_ADDR + PROC_SIZE * pid;
   40621:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40624:	83 c0 04             	add    $0x4,%eax
   40627:	c1 e0 12             	shl    $0x12,%eax
   4062a:	48 63 d0             	movslq %eax,%rdx
   4062d:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40630:	48 63 c8             	movslq %eax,%rcx
   40633:	48 89 c8             	mov    %rcx,%rax
   40636:	48 c1 e0 03          	shl    $0x3,%rax
   4063a:	48 29 c8             	sub    %rcx,%rax
   4063d:	48 c1 e0 05          	shl    $0x5,%rax
   40641:	48 89 c1             	mov    %rax,%rcx
   40644:	48 8d 05 8d 1a 01 00 	lea    0x11a8d(%rip),%rax        # 520d8 <processes+0xb8>
   4064b:	48 89 14 01          	mov    %rdx,(%rcx,%rax,1)
    uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
   4064f:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40652:	48 63 d0             	movslq %eax,%rdx
   40655:	48 89 d0             	mov    %rdx,%rax
   40658:	48 c1 e0 03          	shl    $0x3,%rax
   4065c:	48 29 d0             	sub    %rdx,%rax
   4065f:	48 c1 e0 05          	shl    $0x5,%rax
   40663:	48 89 c2             	mov    %rax,%rdx
   40666:	48 8d 05 6b 1a 01 00 	lea    0x11a6b(%rip),%rax        # 520d8 <processes+0xb8>
   4066d:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   40671:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   40677:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    assign_physical_page(stack_page, pid);
   4067b:	8b 45 9c             	mov    -0x64(%rbp),%eax
   4067e:	0f be d0             	movsbl %al,%edx
   40681:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40685:	89 d6                	mov    %edx,%esi
   40687:	48 89 c7             	mov    %rax,%rdi
   4068a:	e8 64 00 00 00       	call   406f3 <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page, stack_page,
   4068f:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40692:	48 63 d0             	movslq %eax,%rdx
   40695:	48 89 d0             	mov    %rdx,%rax
   40698:	48 c1 e0 03          	shl    $0x3,%rax
   4069c:	48 29 d0             	sub    %rdx,%rax
   4069f:	48 c1 e0 05          	shl    $0x5,%rax
   406a3:	48 89 c2             	mov    %rax,%rdx
   406a6:	48 8d 05 43 1a 01 00 	lea    0x11a43(%rip),%rax        # 520f0 <processes+0xd0>
   406ad:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   406b1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   406b5:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
   406b9:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   406bf:	b9 00 10 00 00       	mov    $0x1000,%ecx
   406c4:	48 89 c7             	mov    %rax,%rdi
   406c7:	e8 91 25 00 00       	call   42c5d <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   406cc:	8b 45 9c             	mov    -0x64(%rbp),%eax
   406cf:	48 63 d0             	movslq %eax,%rdx
   406d2:	48 89 d0             	mov    %rdx,%rax
   406d5:	48 c1 e0 03          	shl    $0x3,%rax
   406d9:	48 29 d0             	sub    %rdx,%rax
   406dc:	48 c1 e0 05          	shl    $0x5,%rax
   406e0:	48 89 c2             	mov    %rax,%rdx
   406e3:	48 8d 05 fe 19 01 00 	lea    0x119fe(%rip),%rax        # 520e8 <processes+0xc8>
   406ea:	c7 04 02 01 00 00 00 	movl   $0x1,(%rdx,%rax,1)
}
   406f1:	c9                   	leave  
   406f2:	c3                   	ret    

00000000000406f3 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   406f3:	f3 0f 1e fa          	endbr64 
   406f7:	55                   	push   %rbp
   406f8:	48 89 e5             	mov    %rsp,%rbp
   406fb:	48 83 ec 10          	sub    $0x10,%rsp
   406ff:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40703:	89 f0                	mov    %esi,%eax
   40705:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   40708:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4070c:	25 ff 0f 00 00       	and    $0xfff,%eax
   40711:	48 85 c0             	test   %rax,%rax
   40714:	75 27                	jne    4073d <assign_physical_page+0x4a>
        || addr >= MEMSIZE_PHYSICAL
   40716:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4071d:	00 
   4071e:	77 1d                	ja     4073d <assign_physical_page+0x4a>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40720:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40724:	48 c1 e8 0c          	shr    $0xc,%rax
   40728:	48 98                	cltq   
   4072a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4072e:	48 8d 05 0c 27 01 00 	lea    0x1270c(%rip),%rax        # 52e41 <pageinfo+0x1>
   40735:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40739:	84 c0                	test   %al,%al
   4073b:	74 07                	je     40744 <assign_physical_page+0x51>
        return -1;
   4073d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40742:	eb 3a                	jmp    4077e <assign_physical_page+0x8b>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   40744:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40748:	48 c1 e8 0c          	shr    $0xc,%rax
   4074c:	48 98                	cltq   
   4074e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40752:	48 8d 05 e8 26 01 00 	lea    0x126e8(%rip),%rax        # 52e41 <pageinfo+0x1>
   40759:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4075d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40761:	48 c1 e8 0c          	shr    $0xc,%rax
   40765:	48 98                	cltq   
   40767:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4076b:	48 8d 15 ce 26 01 00 	lea    0x126ce(%rip),%rdx        # 52e40 <pageinfo>
   40772:	0f b6 45 f4          	movzbl -0xc(%rbp),%eax
   40776:	88 04 11             	mov    %al,(%rcx,%rdx,1)
        return 0;
   40779:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   4077e:	c9                   	leave  
   4077f:	c3                   	ret    

0000000000040780 <syscall_mapping>:

void syscall_mapping(proc* p){
   40780:	f3 0f 1e fa          	endbr64 
   40784:	55                   	push   %rbp
   40785:	48 89 e5             	mov    %rsp,%rbp
   40788:	48 83 ec 70          	sub    $0x70,%rsp
   4078c:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40790:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40794:	48 8b 40 38          	mov    0x38(%rax),%rax
   40798:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   4079c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407a0:	48 8b 40 30          	mov    0x30(%rax),%rax
   407a4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   407a8:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407ac:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407b3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   407b7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407bb:	48 89 ce             	mov    %rcx,%rsi
   407be:	48 89 c7             	mov    %rax,%rdi
   407c1:	e8 e1 28 00 00       	call   430a7 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   407c6:	8b 45 e0             	mov    -0x20(%rbp),%eax
   407c9:	48 98                	cltq   
   407cb:	83 e0 06             	and    $0x6,%eax
   407ce:	48 83 f8 06          	cmp    $0x6,%rax
   407d2:	75 73                	jne    40847 <syscall_mapping+0xc7>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   407d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407d8:	48 83 c0 17          	add    $0x17,%rax
   407dc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   407e0:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407e4:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407eb:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   407ef:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   407f3:	48 89 ce             	mov    %rcx,%rsi
   407f6:	48 89 c7             	mov    %rax,%rdi
   407f9:	e8 a9 28 00 00       	call   430a7 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   407fe:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40801:	48 98                	cltq   
   40803:	83 e0 03             	and    $0x3,%eax
   40806:	48 83 f8 03          	cmp    $0x3,%rax
   4080a:	75 3e                	jne    4084a <syscall_mapping+0xca>
        return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   4080c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40810:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40817:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4081b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4081f:	48 89 ce             	mov    %rcx,%rsi
   40822:	48 89 c7             	mov    %rax,%rdi
   40825:	e8 7d 28 00 00       	call   430a7 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   4082a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4082e:	48 89 c1             	mov    %rax,%rcx
   40831:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40835:	ba 18 00 00 00       	mov    $0x18,%edx
   4083a:	48 89 c6             	mov    %rax,%rsi
   4083d:	48 89 cf             	mov    %rcx,%rdi
   40840:	e8 23 2c 00 00       	call   43468 <memcpy>
   40845:	eb 04                	jmp    4084b <syscall_mapping+0xcb>
        return;
   40847:	90                   	nop
   40848:	eb 01                	jmp    4084b <syscall_mapping+0xcb>
        return;
   4084a:	90                   	nop
}
   4084b:	c9                   	leave  
   4084c:	c3                   	ret    

000000000004084d <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   4084d:	f3 0f 1e fa          	endbr64 
   40851:	55                   	push   %rbp
   40852:	48 89 e5             	mov    %rsp,%rbp
   40855:	48 83 ec 18          	sub    $0x18,%rsp
   40859:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   4085d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40861:	48 8b 40 38          	mov    0x38(%rax),%rax
   40865:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40868:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4086c:	75 14                	jne    40882 <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   4086e:	0f b6 05 8b 57 00 00 	movzbl 0x578b(%rip),%eax        # 46000 <disp_global>
   40875:	84 c0                	test   %al,%al
   40877:	0f 94 c0             	sete   %al
   4087a:	88 05 80 57 00 00    	mov    %al,0x5780(%rip)        # 46000 <disp_global>
   40880:	eb 36                	jmp    408b8 <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40882:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40886:	78 2f                	js     408b7 <syscall_mem_tog+0x6a>
   40888:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4088c:	7f 29                	jg     408b7 <syscall_mem_tog+0x6a>
   4088e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40892:	8b 00                	mov    (%rax),%eax
   40894:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40897:	75 1e                	jne    408b7 <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   40899:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4089d:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   408a4:	84 c0                	test   %al,%al
   408a6:	0f 94 c0             	sete   %al
   408a9:	89 c2                	mov    %eax,%edx
   408ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408af:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   408b5:	eb 01                	jmp    408b8 <syscall_mem_tog+0x6b>
            return;
   408b7:	90                   	nop
    }
}
   408b8:	c9                   	leave  
   408b9:	c3                   	ret    

00000000000408ba <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   408ba:	f3 0f 1e fa          	endbr64 
   408be:	55                   	push   %rbp
   408bf:	48 89 e5             	mov    %rsp,%rbp
   408c2:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   408c9:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   408d0:	48 8b 05 29 17 01 00 	mov    0x11729(%rip),%rax        # 52000 <current>
   408d7:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   408de:	48 83 c0 08          	add    $0x8,%rax
   408e2:	48 89 d6             	mov    %rdx,%rsi
   408e5:	ba 18 00 00 00       	mov    $0x18,%edx
   408ea:	48 89 c7             	mov    %rax,%rdi
   408ed:	48 89 d1             	mov    %rdx,%rcx
   408f0:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   408f3:	48 8b 05 06 47 01 00 	mov    0x14706(%rip),%rax        # 55000 <kernel_pagetable>
   408fa:	48 89 c7             	mov    %rax,%rdi
   408fd:	e8 e9 21 00 00       	call   42aeb <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40902:	8b 05 f4 86 07 00    	mov    0x786f4(%rip),%eax        # b8ffc <cursorpos>
   40908:	89 c7                	mov    %eax,%edi
   4090a:	e8 62 18 00 00       	call   42171 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   4090f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40916:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4091d:	48 83 f8 0e          	cmp    $0xe,%rax
   40921:	74 14                	je     40937 <exception+0x7d>
   40923:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4092a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40931:	48 83 f8 0d          	cmp    $0xd,%rax
   40935:	75 16                	jne    4094d <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40937:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4093e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40945:	83 e0 04             	and    $0x4,%eax
   40948:	48 85 c0             	test   %rax,%rax
   4094b:	74 1a                	je     40967 <exception+0xad>
    {
        check_virtual_memory();
   4094d:	e8 65 08 00 00       	call   411b7 <check_virtual_memory>
        if(disp_global){
   40952:	0f b6 05 a7 56 00 00 	movzbl 0x56a7(%rip),%eax        # 46000 <disp_global>
   40959:	84 c0                	test   %al,%al
   4095b:	74 0a                	je     40967 <exception+0xad>
            memshow_physical();
   4095d:	e8 1e 0a 00 00       	call   41380 <memshow_physical>
            memshow_virtual_animate();
   40962:	e8 bb 0d 00 00       	call   41722 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40967:	e8 1b 1d 00 00       	call   42687 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   4096c:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40973:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4097a:	48 83 e8 0e          	sub    $0xe,%rax
   4097e:	48 83 f8 2a          	cmp    $0x2a,%rax
   40982:	0f 87 e2 02 00 00    	ja     40c6a <exception+0x3b0>
   40988:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   4098f:	00 
   40990:	48 8d 05 a9 3c 00 00 	lea    0x3ca9(%rip),%rax        # 44640 <console_clear+0x11d>
   40997:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4099a:	48 98                	cltq   
   4099c:	48 8d 15 9d 3c 00 00 	lea    0x3c9d(%rip),%rdx        # 44640 <console_clear+0x11d>
   409a3:	48 01 d0             	add    %rdx,%rax
   409a6:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   409a9:	48 8b 05 50 16 01 00 	mov    0x11650(%rip),%rax        # 52000 <current>
   409b0:	48 8b 40 38          	mov    0x38(%rax),%rax
   409b4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		if((void *)addr == NULL)
   409b8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   409bd:	75 0f                	jne    409ce <exception+0x114>
		    panic(NULL);
   409bf:	bf 00 00 00 00       	mov    $0x0,%edi
   409c4:	b8 00 00 00 00       	mov    $0x0,%eax
   409c9:	e8 1b 1e 00 00       	call   427e9 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   409ce:	48 8b 05 2b 16 01 00 	mov    0x1162b(%rip),%rax        # 52000 <current>
   409d5:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   409dc:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   409e0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   409e4:	48 89 ce             	mov    %rcx,%rsi
   409e7:	48 89 c7             	mov    %rax,%rdi
   409ea:	e8 b8 26 00 00       	call   430a7 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   409ef:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   409f3:	48 89 c1             	mov    %rax,%rcx
   409f6:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   409fd:	ba a0 00 00 00       	mov    $0xa0,%edx
   40a02:	48 89 ce             	mov    %rcx,%rsi
   40a05:	48 89 c7             	mov    %rax,%rdi
   40a08:	e8 5b 2a 00 00       	call   43468 <memcpy>
		panic(msg);
   40a0d:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   40a14:	48 89 c7             	mov    %rax,%rdi
   40a17:	b8 00 00 00 00       	mov    $0x0,%eax
   40a1c:	e8 c8 1d 00 00       	call   427e9 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40a21:	48 8b 05 d8 15 01 00 	mov    0x115d8(%rip),%rax        # 52000 <current>
   40a28:	8b 10                	mov    (%rax),%edx
   40a2a:	48 8b 05 cf 15 01 00 	mov    0x115cf(%rip),%rax        # 52000 <current>
   40a31:	48 63 d2             	movslq %edx,%rdx
   40a34:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40a38:	e9 3d 02 00 00       	jmp    40c7a <exception+0x3c0>

    case INT_SYS_YIELD:
        schedule();
   40a3d:	e8 61 02 00 00       	call   40ca3 <schedule>
        break;                  /* will not be reached */
   40a42:	e9 33 02 00 00       	jmp    40c7a <exception+0x3c0>

    case INT_SYS_PAGE_ALLOC: {    
        uintptr_t addr = current->p_registers.reg_rdi;
   40a47:	48 8b 05 b2 15 01 00 	mov    0x115b2(%rip),%rax        # 52000 <current>
   40a4e:	48 8b 40 38          	mov    0x38(%rax),%rax
   40a52:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        // check if address is page aligned
        if(addr % PAGESIZE != 0){
   40a56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a5a:	25 ff 0f 00 00       	and    $0xfff,%eax
   40a5f:	48 85 c0             	test   %rax,%rax
   40a62:	74 14                	je     40a78 <exception+0x1be>
            current->p_registers.reg_rax = -1;
   40a64:	48 8b 05 95 15 01 00 	mov    0x11595(%rip),%rax        # 52000 <current>
   40a6b:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40a72:	ff 
            break;
   40a73:	e9 02 02 00 00       	jmp    40c7a <exception+0x3c0>
        }
        // check that we are within 
        if(addr >= MEMSIZE_VIRTUAL || addr < PROC_START_ADDR){  
   40a78:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40a7f:	00 
   40a80:	77 0a                	ja     40a8c <exception+0x1d2>
   40a82:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   40a89:	00 
   40a8a:	77 14                	ja     40aa0 <exception+0x1e6>
            current->p_registers.reg_rax = -1;
   40a8c:	48 8b 05 6d 15 01 00 	mov    0x1156d(%rip),%rax        # 52000 <current>
   40a93:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40a9a:	ff 
            break;
   40a9b:	e9 da 01 00 00       	jmp    40c7a <exception+0x3c0>
        }
        int r = assign_physical_page(addr, current->p_pid);
   40aa0:	48 8b 05 59 15 01 00 	mov    0x11559(%rip),%rax        # 52000 <current>
   40aa7:	8b 00                	mov    (%rax),%eax
   40aa9:	0f be d0             	movsbl %al,%edx
   40aac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ab0:	89 d6                	mov    %edx,%esi
   40ab2:	48 89 c7             	mov    %rax,%rdi
   40ab5:	e8 39 fc ff ff       	call   406f3 <assign_physical_page>
   40aba:	89 45 f4             	mov    %eax,-0xc(%rbp)
        // if page was already allocated
        if(r < 0){
   40abd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40ac1:	79 14                	jns    40ad7 <exception+0x21d>
            current->p_registers.reg_rax = -1;
   40ac3:	48 8b 05 36 15 01 00 	mov    0x11536(%rip),%rax        # 52000 <current>
   40aca:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40ad1:	ff 
            break;
   40ad2:	e9 a3 01 00 00       	jmp    40c7a <exception+0x3c0>
        }
        // map the page
        if (r >= 0) {
   40ad7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40adb:	78 29                	js     40b06 <exception+0x24c>
            virtual_memory_map(current->p_pagetable, addr, addr,
   40add:	48 8b 05 1c 15 01 00 	mov    0x1151c(%rip),%rax        # 52000 <current>
   40ae4:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40aeb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40aef:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40af3:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40af9:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40afe:	48 89 c7             	mov    %rax,%rdi
   40b01:	e8 57 21 00 00       	call   42c5d <virtual_memory_map>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
        current->p_registers.reg_rax = r;
   40b06:	48 8b 05 f3 14 01 00 	mov    0x114f3(%rip),%rax        # 52000 <current>
   40b0d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   40b10:	48 63 d2             	movslq %edx,%rdx
   40b13:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40b17:	e9 5e 01 00 00       	jmp    40c7a <exception+0x3c0>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40b1c:	48 8b 05 dd 14 01 00 	mov    0x114dd(%rip),%rax        # 52000 <current>
   40b23:	48 89 c7             	mov    %rax,%rdi
   40b26:	e8 55 fc ff ff       	call   40780 <syscall_mapping>
            break;
   40b2b:	e9 4a 01 00 00       	jmp    40c7a <exception+0x3c0>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40b30:	48 8b 05 c9 14 01 00 	mov    0x114c9(%rip),%rax        # 52000 <current>
   40b37:	48 89 c7             	mov    %rax,%rdi
   40b3a:	e8 0e fd ff ff       	call   4084d <syscall_mem_tog>
	    break;
   40b3f:	e9 36 01 00 00       	jmp    40c7a <exception+0x3c0>
	}

    case INT_TIMER:
        ++ticks;
   40b44:	8b 05 d6 22 01 00    	mov    0x122d6(%rip),%eax        # 52e20 <ticks>
   40b4a:	83 c0 01             	add    $0x1,%eax
   40b4d:	89 05 cd 22 01 00    	mov    %eax,0x122cd(%rip)        # 52e20 <ticks>
        schedule();
   40b53:	e8 4b 01 00 00       	call   40ca3 <schedule>
        break;                  /* will not be reached */
   40b58:	e9 1d 01 00 00       	jmp    40c7a <exception+0x3c0>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40b5d:	0f 20 d0             	mov    %cr2,%rax
   40b60:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   40b64:	48 8b 45 c8          	mov    -0x38(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40b68:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40b6c:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40b73:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b7a:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40b7d:	48 85 c0             	test   %rax,%rax
   40b80:	74 09                	je     40b8b <exception+0x2d1>
   40b82:	48 8d 05 27 3a 00 00 	lea    0x3a27(%rip),%rax        # 445b0 <console_clear+0x8d>
   40b89:	eb 07                	jmp    40b92 <exception+0x2d8>
   40b8b:	48 8d 05 24 3a 00 00 	lea    0x3a24(%rip),%rax        # 445b6 <console_clear+0x93>
        const char* operation = reg->reg_err & PFERR_WRITE
   40b92:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40b96:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40b9d:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ba4:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40ba7:	48 85 c0             	test   %rax,%rax
   40baa:	74 09                	je     40bb5 <exception+0x2fb>
   40bac:	48 8d 05 08 3a 00 00 	lea    0x3a08(%rip),%rax        # 445bb <console_clear+0x98>
   40bb3:	eb 07                	jmp    40bbc <exception+0x302>
   40bb5:	48 8d 05 12 3a 00 00 	lea    0x3a12(%rip),%rax        # 445ce <console_clear+0xab>
        const char* problem = reg->reg_err & PFERR_PRESENT
   40bbc:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40bc0:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40bc7:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40bce:	83 e0 04             	and    $0x4,%eax
   40bd1:	48 85 c0             	test   %rax,%rax
   40bd4:	75 34                	jne    40c0a <exception+0x350>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40bd6:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40bdd:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40be4:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40be8:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40bec:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40bf0:	49 89 f0             	mov    %rsi,%r8
   40bf3:	48 89 c6             	mov    %rax,%rsi
   40bf6:	48 8d 05 e3 39 00 00 	lea    0x39e3(%rip),%rax        # 445e0 <console_clear+0xbd>
   40bfd:	48 89 c7             	mov    %rax,%rdi
   40c00:	b8 00 00 00 00       	mov    $0x0,%eax
   40c05:	e8 df 1b 00 00       	call   427e9 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40c0a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40c11:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40c18:	48 8b 05 e1 13 01 00 	mov    0x113e1(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40c1f:	8b 00                	mov    (%rax),%eax
   40c21:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40c25:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   40c29:	52                   	push   %rdx
   40c2a:	ff 75 d0             	push   -0x30(%rbp)
   40c2d:	49 89 f1             	mov    %rsi,%r9
   40c30:	49 89 c8             	mov    %rcx,%r8
   40c33:	89 c1                	mov    %eax,%ecx
   40c35:	48 8d 05 d4 39 00 00 	lea    0x39d4(%rip),%rax        # 44610 <console_clear+0xed>
   40c3c:	48 89 c2             	mov    %rax,%rdx
   40c3f:	be 00 0c 00 00       	mov    $0xc00,%esi
   40c44:	bf 80 07 00 00       	mov    $0x780,%edi
   40c49:	b8 00 00 00 00       	mov    $0x0,%eax
   40c4e:	e8 5a 37 00 00       	call   443ad <console_printf>
   40c53:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40c57:	48 8b 05 a2 13 01 00 	mov    0x113a2(%rip),%rax        # 52000 <current>
   40c5e:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40c65:	00 00 00 
        break;
   40c68:	eb 10                	jmp    40c7a <exception+0x3c0>
    }

    default:
        default_exception(current);
   40c6a:	48 8b 05 8f 13 01 00 	mov    0x1138f(%rip),%rax        # 52000 <current>
   40c71:	48 89 c7             	mov    %rax,%rdi
   40c74:	e8 99 1c 00 00       	call   42912 <default_exception>
        break;                  /* will not be reached */
   40c79:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40c7a:	48 8b 05 7f 13 01 00 	mov    0x1137f(%rip),%rax        # 52000 <current>
   40c81:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40c87:	83 f8 01             	cmp    $0x1,%eax
   40c8a:	75 0f                	jne    40c9b <exception+0x3e1>
        run(current);
   40c8c:	48 8b 05 6d 13 01 00 	mov    0x1136d(%rip),%rax        # 52000 <current>
   40c93:	48 89 c7             	mov    %rax,%rdi
   40c96:	e8 87 00 00 00       	call   40d22 <run>
    } else {
        schedule();
   40c9b:	e8 03 00 00 00       	call   40ca3 <schedule>
    }
}
   40ca0:	90                   	nop
   40ca1:	c9                   	leave  
   40ca2:	c3                   	ret    

0000000000040ca3 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40ca3:	f3 0f 1e fa          	endbr64 
   40ca7:	55                   	push   %rbp
   40ca8:	48 89 e5             	mov    %rsp,%rbp
   40cab:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40caf:	48 8b 05 4a 13 01 00 	mov    0x1134a(%rip),%rax        # 52000 <current>
   40cb6:	8b 00                	mov    (%rax),%eax
   40cb8:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40cbb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cbe:	83 c0 01             	add    $0x1,%eax
   40cc1:	99                   	cltd   
   40cc2:	c1 ea 1c             	shr    $0x1c,%edx
   40cc5:	01 d0                	add    %edx,%eax
   40cc7:	83 e0 0f             	and    $0xf,%eax
   40cca:	29 d0                	sub    %edx,%eax
   40ccc:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40ccf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cd2:	48 63 d0             	movslq %eax,%rdx
   40cd5:	48 89 d0             	mov    %rdx,%rax
   40cd8:	48 c1 e0 03          	shl    $0x3,%rax
   40cdc:	48 29 d0             	sub    %rdx,%rax
   40cdf:	48 c1 e0 05          	shl    $0x5,%rax
   40ce3:	48 89 c2             	mov    %rax,%rdx
   40ce6:	48 8d 05 fb 13 01 00 	lea    0x113fb(%rip),%rax        # 520e8 <processes+0xc8>
   40ced:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40cf0:	83 f8 01             	cmp    $0x1,%eax
   40cf3:	75 26                	jne    40d1b <schedule+0x78>
            run(&processes[pid]);
   40cf5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cf8:	48 63 d0             	movslq %eax,%rdx
   40cfb:	48 89 d0             	mov    %rdx,%rax
   40cfe:	48 c1 e0 03          	shl    $0x3,%rax
   40d02:	48 29 d0             	sub    %rdx,%rax
   40d05:	48 c1 e0 05          	shl    $0x5,%rax
   40d09:	48 8d 15 10 13 01 00 	lea    0x11310(%rip),%rdx        # 52020 <processes>
   40d10:	48 01 d0             	add    %rdx,%rax
   40d13:	48 89 c7             	mov    %rax,%rdi
   40d16:	e8 07 00 00 00       	call   40d22 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40d1b:	e8 67 19 00 00       	call   42687 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40d20:	eb 99                	jmp    40cbb <schedule+0x18>

0000000000040d22 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40d22:	f3 0f 1e fa          	endbr64 
   40d26:	55                   	push   %rbp
   40d27:	48 89 e5             	mov    %rsp,%rbp
   40d2a:	48 83 ec 10          	sub    $0x10,%rsp
   40d2e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40d32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d36:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40d3c:	83 f8 01             	cmp    $0x1,%eax
   40d3f:	74 1e                	je     40d5f <run+0x3d>
   40d41:	48 8d 05 a4 39 00 00 	lea    0x39a4(%rip),%rax        # 446ec <console_clear+0x1c9>
   40d48:	48 89 c2             	mov    %rax,%rdx
   40d4b:	be 96 01 00 00       	mov    $0x196,%esi
   40d50:	48 8d 05 49 38 00 00 	lea    0x3849(%rip),%rax        # 445a0 <console_clear+0x7d>
   40d57:	48 89 c7             	mov    %rax,%rdi
   40d5a:	e8 7a 1b 00 00       	call   428d9 <assert_fail>
    current = p;
   40d5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d63:	48 89 05 96 12 01 00 	mov    %rax,0x11296(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40d6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d6e:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40d75:	48 89 c7             	mov    %rax,%rdi
   40d78:	e8 6e 1d 00 00       	call   42aeb <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40d7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d81:	48 83 c0 08          	add    $0x8,%rax
   40d85:	48 89 c7             	mov    %rax,%rdi
   40d88:	e8 36 f3 ff ff       	call   400c3 <exception_return>

0000000000040d8d <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40d8d:	f3 0f 1e fa          	endbr64 
   40d91:	55                   	push   %rbp
   40d92:	48 89 e5             	mov    %rsp,%rbp
   40d95:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d99:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40da0:	00 
   40da1:	e9 93 00 00 00       	jmp    40e39 <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40da6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40daa:	48 89 c7             	mov    %rax,%rdi
   40dad:	e8 0f 11 00 00       	call   41ec1 <physical_memory_isreserved>
   40db2:	85 c0                	test   %eax,%eax
   40db4:	74 09                	je     40dbf <pageinfo_init+0x32>
            owner = PO_RESERVED;
   40db6:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40dbd:	eb 31                	jmp    40df0 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40dbf:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40dc6:	00 
   40dc7:	76 0d                	jbe    40dd6 <pageinfo_init+0x49>
   40dc9:	48 8d 05 38 a2 01 00 	lea    0x1a238(%rip),%rax        # 5b008 <end>
   40dd0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dd4:	72 0a                	jb     40de0 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40dd6:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40ddd:	00 
   40dde:	75 09                	jne    40de9 <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   40de0:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40de7:	eb 07                	jmp    40df0 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   40de9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40df0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40df4:	48 c1 e8 0c          	shr    $0xc,%rax
   40df8:	89 c2                	mov    %eax,%edx
   40dfa:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40dfd:	89 c1                	mov    %eax,%ecx
   40dff:	48 63 c2             	movslq %edx,%rax
   40e02:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e06:	48 8d 05 33 20 01 00 	lea    0x12033(%rip),%rax        # 52e40 <pageinfo>
   40e0d:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40e10:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40e14:	0f 95 c2             	setne  %dl
   40e17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e1b:	48 c1 e8 0c          	shr    $0xc,%rax
   40e1f:	89 d1                	mov    %edx,%ecx
   40e21:	48 98                	cltq   
   40e23:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e27:	48 8d 05 13 20 01 00 	lea    0x12013(%rip),%rax        # 52e41 <pageinfo+0x1>
   40e2e:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e31:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e38:	00 
   40e39:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40e40:	00 
   40e41:	0f 86 5f ff ff ff    	jbe    40da6 <pageinfo_init+0x19>
    }
}
   40e47:	90                   	nop
   40e48:	90                   	nop
   40e49:	c9                   	leave  
   40e4a:	c3                   	ret    

0000000000040e4b <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40e4b:	f3 0f 1e fa          	endbr64 
   40e4f:	55                   	push   %rbp
   40e50:	48 89 e5             	mov    %rsp,%rbp
   40e53:	48 83 ec 50          	sub    $0x50,%rsp
   40e57:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40e5b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e5f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40e65:	48 89 c2             	mov    %rax,%rdx
   40e68:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e6c:	48 39 c2             	cmp    %rax,%rdx
   40e6f:	74 1e                	je     40e8f <check_page_table_mappings+0x44>
   40e71:	48 8d 05 90 38 00 00 	lea    0x3890(%rip),%rax        # 44708 <console_clear+0x1e5>
   40e78:	48 89 c2             	mov    %rax,%rdx
   40e7b:	be c0 01 00 00       	mov    $0x1c0,%esi
   40e80:	48 8d 05 19 37 00 00 	lea    0x3719(%rip),%rax        # 445a0 <console_clear+0x7d>
   40e87:	48 89 c7             	mov    %rax,%rdi
   40e8a:	e8 4a 1a 00 00       	call   428d9 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e8f:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40e96:	00 
   40e97:	e9 b5 00 00 00       	jmp    40f51 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40e9c:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40ea0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40ea4:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40ea8:	48 89 ce             	mov    %rcx,%rsi
   40eab:	48 89 c7             	mov    %rax,%rdi
   40eae:	e8 f4 21 00 00       	call   430a7 <virtual_memory_lookup>
        if (vam.pa != va) {
   40eb3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40eb7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ebb:	74 2c                	je     40ee9 <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40ebd:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40ec1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ec5:	49 89 d0             	mov    %rdx,%r8
   40ec8:	48 89 c1             	mov    %rax,%rcx
   40ecb:	48 8d 05 55 38 00 00 	lea    0x3855(%rip),%rax        # 44727 <console_clear+0x204>
   40ed2:	48 89 c2             	mov    %rax,%rdx
   40ed5:	be 00 c0 00 00       	mov    $0xc000,%esi
   40eda:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40edf:	b8 00 00 00 00       	mov    $0x0,%eax
   40ee4:	e8 c4 34 00 00       	call   443ad <console_printf>
        }
        assert(vam.pa == va);
   40ee9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40eed:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ef1:	74 1e                	je     40f11 <check_page_table_mappings+0xc6>
   40ef3:	48 8d 05 37 38 00 00 	lea    0x3837(%rip),%rax        # 44731 <console_clear+0x20e>
   40efa:	48 89 c2             	mov    %rax,%rdx
   40efd:	be c9 01 00 00       	mov    $0x1c9,%esi
   40f02:	48 8d 05 97 36 00 00 	lea    0x3697(%rip),%rax        # 445a0 <console_clear+0x7d>
   40f09:	48 89 c7             	mov    %rax,%rdi
   40f0c:	e8 c8 19 00 00       	call   428d9 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40f11:	48 8d 05 e8 50 00 00 	lea    0x50e8(%rip),%rax        # 46000 <disp_global>
   40f18:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f1c:	72 2b                	jb     40f49 <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   40f1e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f21:	48 98                	cltq   
   40f23:	83 e0 02             	and    $0x2,%eax
   40f26:	48 85 c0             	test   %rax,%rax
   40f29:	75 1e                	jne    40f49 <check_page_table_mappings+0xfe>
   40f2b:	48 8d 05 0c 38 00 00 	lea    0x380c(%rip),%rax        # 4473e <console_clear+0x21b>
   40f32:	48 89 c2             	mov    %rax,%rdx
   40f35:	be cb 01 00 00       	mov    $0x1cb,%esi
   40f3a:	48 8d 05 5f 36 00 00 	lea    0x365f(%rip),%rax        # 445a0 <console_clear+0x7d>
   40f41:	48 89 c7             	mov    %rax,%rdi
   40f44:	e8 90 19 00 00       	call   428d9 <assert_fail>
         va += PAGESIZE) {
   40f49:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40f50:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40f51:	48 8d 05 b0 a0 01 00 	lea    0x1a0b0(%rip),%rax        # 5b008 <end>
   40f58:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f5c:	0f 82 3a ff ff ff    	jb     40e9c <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40f62:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40f69:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40f6a:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40f6e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40f72:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f76:	48 89 ce             	mov    %rcx,%rsi
   40f79:	48 89 c7             	mov    %rax,%rdi
   40f7c:	e8 26 21 00 00       	call   430a7 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40f81:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40f85:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40f89:	74 1e                	je     40fa9 <check_page_table_mappings+0x15e>
   40f8b:	48 8d 05 bd 37 00 00 	lea    0x37bd(%rip),%rax        # 4474f <console_clear+0x22c>
   40f92:	48 89 c2             	mov    %rax,%rdx
   40f95:	be d2 01 00 00       	mov    $0x1d2,%esi
   40f9a:	48 8d 05 ff 35 00 00 	lea    0x35ff(%rip),%rax        # 445a0 <console_clear+0x7d>
   40fa1:	48 89 c7             	mov    %rax,%rdi
   40fa4:	e8 30 19 00 00       	call   428d9 <assert_fail>
    assert(vam.perm & PTE_W);
   40fa9:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40fac:	48 98                	cltq   
   40fae:	83 e0 02             	and    $0x2,%eax
   40fb1:	48 85 c0             	test   %rax,%rax
   40fb4:	75 1e                	jne    40fd4 <check_page_table_mappings+0x189>
   40fb6:	48 8d 05 81 37 00 00 	lea    0x3781(%rip),%rax        # 4473e <console_clear+0x21b>
   40fbd:	48 89 c2             	mov    %rax,%rdx
   40fc0:	be d3 01 00 00       	mov    $0x1d3,%esi
   40fc5:	48 8d 05 d4 35 00 00 	lea    0x35d4(%rip),%rax        # 445a0 <console_clear+0x7d>
   40fcc:	48 89 c7             	mov    %rax,%rdi
   40fcf:	e8 05 19 00 00       	call   428d9 <assert_fail>
}
   40fd4:	90                   	nop
   40fd5:	c9                   	leave  
   40fd6:	c3                   	ret    

0000000000040fd7 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40fd7:	f3 0f 1e fa          	endbr64 
   40fdb:	55                   	push   %rbp
   40fdc:	48 89 e5             	mov    %rsp,%rbp
   40fdf:	48 83 ec 20          	sub    $0x20,%rsp
   40fe3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40fe7:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40fea:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40fed:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40ff0:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40ff7:	48 8b 05 02 40 01 00 	mov    0x14002(%rip),%rax        # 55000 <kernel_pagetable>
   40ffe:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41002:	75 71                	jne    41075 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   41004:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4100b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41012:	eb 5b                	jmp    4106f <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   41014:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41017:	48 63 d0             	movslq %eax,%rdx
   4101a:	48 89 d0             	mov    %rdx,%rax
   4101d:	48 c1 e0 03          	shl    $0x3,%rax
   41021:	48 29 d0             	sub    %rdx,%rax
   41024:	48 c1 e0 05          	shl    $0x5,%rax
   41028:	48 89 c2             	mov    %rax,%rdx
   4102b:	48 8d 05 b6 10 01 00 	lea    0x110b6(%rip),%rax        # 520e8 <processes+0xc8>
   41032:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41035:	85 c0                	test   %eax,%eax
   41037:	74 32                	je     4106b <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41039:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4103c:	48 63 d0             	movslq %eax,%rdx
   4103f:	48 89 d0             	mov    %rdx,%rax
   41042:	48 c1 e0 03          	shl    $0x3,%rax
   41046:	48 29 d0             	sub    %rdx,%rax
   41049:	48 c1 e0 05          	shl    $0x5,%rax
   4104d:	48 89 c2             	mov    %rax,%rdx
   41050:	48 8d 05 99 10 01 00 	lea    0x11099(%rip),%rax        # 520f0 <processes+0xd0>
   41057:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   4105b:	48 8b 05 9e 3f 01 00 	mov    0x13f9e(%rip),%rax        # 55000 <kernel_pagetable>
   41062:	48 39 c2             	cmp    %rax,%rdx
   41065:	75 04                	jne    4106b <check_page_table_ownership+0x94>
                ++expected_refcount;
   41067:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4106b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4106f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41073:	7e 9f                	jle    41014 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41075:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41078:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4107b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4107f:	be 00 00 00 00       	mov    $0x0,%esi
   41084:	48 89 c7             	mov    %rax,%rdi
   41087:	e8 03 00 00 00       	call   4108f <check_page_table_ownership_level>
}
   4108c:	90                   	nop
   4108d:	c9                   	leave  
   4108e:	c3                   	ret    

000000000004108f <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   4108f:	f3 0f 1e fa          	endbr64 
   41093:	55                   	push   %rbp
   41094:	48 89 e5             	mov    %rsp,%rbp
   41097:	48 83 ec 30          	sub    $0x30,%rsp
   4109b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4109f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   410a2:	89 55 e0             	mov    %edx,-0x20(%rbp)
   410a5:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   410a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410ac:	48 c1 e8 0c          	shr    $0xc,%rax
   410b0:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   410b5:	7e 1e                	jle    410d5 <check_page_table_ownership_level+0x46>
   410b7:	48 8d 05 a2 36 00 00 	lea    0x36a2(%rip),%rax        # 44760 <console_clear+0x23d>
   410be:	48 89 c2             	mov    %rax,%rdx
   410c1:	be f0 01 00 00       	mov    $0x1f0,%esi
   410c6:	48 8d 05 d3 34 00 00 	lea    0x34d3(%rip),%rax        # 445a0 <console_clear+0x7d>
   410cd:	48 89 c7             	mov    %rax,%rdi
   410d0:	e8 04 18 00 00       	call   428d9 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   410d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410d9:	48 c1 e8 0c          	shr    $0xc,%rax
   410dd:	48 98                	cltq   
   410df:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   410e3:	48 8d 05 56 1d 01 00 	lea    0x11d56(%rip),%rax        # 52e40 <pageinfo>
   410ea:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   410ee:	0f be c0             	movsbl %al,%eax
   410f1:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   410f4:	74 1e                	je     41114 <check_page_table_ownership_level+0x85>
   410f6:	48 8d 05 7b 36 00 00 	lea    0x367b(%rip),%rax        # 44778 <console_clear+0x255>
   410fd:	48 89 c2             	mov    %rax,%rdx
   41100:	be f1 01 00 00       	mov    $0x1f1,%esi
   41105:	48 8d 05 94 34 00 00 	lea    0x3494(%rip),%rax        # 445a0 <console_clear+0x7d>
   4110c:	48 89 c7             	mov    %rax,%rdi
   4110f:	e8 c5 17 00 00       	call   428d9 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41114:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41118:	48 c1 e8 0c          	shr    $0xc,%rax
   4111c:	48 98                	cltq   
   4111e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41122:	48 8d 05 18 1d 01 00 	lea    0x11d18(%rip),%rax        # 52e41 <pageinfo+0x1>
   41129:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4112d:	0f be c0             	movsbl %al,%eax
   41130:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41133:	74 1e                	je     41153 <check_page_table_ownership_level+0xc4>
   41135:	48 8d 05 64 36 00 00 	lea    0x3664(%rip),%rax        # 447a0 <console_clear+0x27d>
   4113c:	48 89 c2             	mov    %rax,%rdx
   4113f:	be f2 01 00 00       	mov    $0x1f2,%esi
   41144:	48 8d 05 55 34 00 00 	lea    0x3455(%rip),%rax        # 445a0 <console_clear+0x7d>
   4114b:	48 89 c7             	mov    %rax,%rdi
   4114e:	e8 86 17 00 00       	call   428d9 <assert_fail>
    if (level < 3) {
   41153:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41157:	7f 5b                	jg     411b4 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41159:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41160:	eb 49                	jmp    411ab <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   41162:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41166:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41169:	48 63 d2             	movslq %edx,%rdx
   4116c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41170:	48 85 c0             	test   %rax,%rax
   41173:	74 32                	je     411a7 <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41175:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41179:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4117c:	48 63 d2             	movslq %edx,%rdx
   4117f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41183:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41189:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4118d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41190:	8d 70 01             	lea    0x1(%rax),%esi
   41193:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41196:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4119a:	b9 01 00 00 00       	mov    $0x1,%ecx
   4119f:	48 89 c7             	mov    %rax,%rdi
   411a2:	e8 e8 fe ff ff       	call   4108f <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   411a7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411ab:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   411b2:	7e ae                	jle    41162 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   411b4:	90                   	nop
   411b5:	c9                   	leave  
   411b6:	c3                   	ret    

00000000000411b7 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   411b7:	f3 0f 1e fa          	endbr64 
   411bb:	55                   	push   %rbp
   411bc:	48 89 e5             	mov    %rsp,%rbp
   411bf:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   411c3:	8b 05 1f 0f 01 00    	mov    0x10f1f(%rip),%eax        # 520e8 <processes+0xc8>
   411c9:	85 c0                	test   %eax,%eax
   411cb:	74 1e                	je     411eb <check_virtual_memory+0x34>
   411cd:	48 8d 05 fc 35 00 00 	lea    0x35fc(%rip),%rax        # 447d0 <console_clear+0x2ad>
   411d4:	48 89 c2             	mov    %rax,%rdx
   411d7:	be 05 02 00 00       	mov    $0x205,%esi
   411dc:	48 8d 05 bd 33 00 00 	lea    0x33bd(%rip),%rax        # 445a0 <console_clear+0x7d>
   411e3:	48 89 c7             	mov    %rax,%rdi
   411e6:	e8 ee 16 00 00       	call   428d9 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   411eb:	48 8b 05 0e 3e 01 00 	mov    0x13e0e(%rip),%rax        # 55000 <kernel_pagetable>
   411f2:	48 89 c7             	mov    %rax,%rdi
   411f5:	e8 51 fc ff ff       	call   40e4b <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   411fa:	48 8b 05 ff 3d 01 00 	mov    0x13dff(%rip),%rax        # 55000 <kernel_pagetable>
   41201:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41206:	48 89 c7             	mov    %rax,%rdi
   41209:	e8 c9 fd ff ff       	call   40fd7 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   4120e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41215:	e9 b4 00 00 00       	jmp    412ce <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   4121a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4121d:	48 63 d0             	movslq %eax,%rdx
   41220:	48 89 d0             	mov    %rdx,%rax
   41223:	48 c1 e0 03          	shl    $0x3,%rax
   41227:	48 29 d0             	sub    %rdx,%rax
   4122a:	48 c1 e0 05          	shl    $0x5,%rax
   4122e:	48 89 c2             	mov    %rax,%rdx
   41231:	48 8d 05 b0 0e 01 00 	lea    0x10eb0(%rip),%rax        # 520e8 <processes+0xc8>
   41238:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4123b:	85 c0                	test   %eax,%eax
   4123d:	0f 84 87 00 00 00    	je     412ca <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41243:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41246:	48 63 d0             	movslq %eax,%rdx
   41249:	48 89 d0             	mov    %rdx,%rax
   4124c:	48 c1 e0 03          	shl    $0x3,%rax
   41250:	48 29 d0             	sub    %rdx,%rax
   41253:	48 c1 e0 05          	shl    $0x5,%rax
   41257:	48 89 c2             	mov    %rax,%rdx
   4125a:	48 8d 05 8f 0e 01 00 	lea    0x10e8f(%rip),%rax        # 520f0 <processes+0xd0>
   41261:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   41265:	48 8b 05 94 3d 01 00 	mov    0x13d94(%rip),%rax        # 55000 <kernel_pagetable>
   4126c:	48 39 c2             	cmp    %rax,%rdx
   4126f:	74 59                	je     412ca <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   41271:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41274:	48 63 d0             	movslq %eax,%rdx
   41277:	48 89 d0             	mov    %rdx,%rax
   4127a:	48 c1 e0 03          	shl    $0x3,%rax
   4127e:	48 29 d0             	sub    %rdx,%rax
   41281:	48 c1 e0 05          	shl    $0x5,%rax
   41285:	48 89 c2             	mov    %rax,%rdx
   41288:	48 8d 05 61 0e 01 00 	lea    0x10e61(%rip),%rax        # 520f0 <processes+0xd0>
   4128f:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41293:	48 89 c7             	mov    %rax,%rdi
   41296:	e8 b0 fb ff ff       	call   40e4b <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4129b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4129e:	48 63 d0             	movslq %eax,%rdx
   412a1:	48 89 d0             	mov    %rdx,%rax
   412a4:	48 c1 e0 03          	shl    $0x3,%rax
   412a8:	48 29 d0             	sub    %rdx,%rax
   412ab:	48 c1 e0 05          	shl    $0x5,%rax
   412af:	48 89 c2             	mov    %rax,%rdx
   412b2:	48 8d 05 37 0e 01 00 	lea    0x10e37(%rip),%rax        # 520f0 <processes+0xd0>
   412b9:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   412bd:	8b 55 fc             	mov    -0x4(%rbp),%edx
   412c0:	89 d6                	mov    %edx,%esi
   412c2:	48 89 c7             	mov    %rax,%rdi
   412c5:	e8 0d fd ff ff       	call   40fd7 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   412ca:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412ce:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   412d2:	0f 8e 42 ff ff ff    	jle    4121a <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412d8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   412df:	e9 8b 00 00 00       	jmp    4136f <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   412e4:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412e7:	48 98                	cltq   
   412e9:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   412ed:	48 8d 05 4d 1b 01 00 	lea    0x11b4d(%rip),%rax        # 52e41 <pageinfo+0x1>
   412f4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   412f8:	84 c0                	test   %al,%al
   412fa:	7e 6f                	jle    4136b <check_virtual_memory+0x1b4>
   412fc:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412ff:	48 98                	cltq   
   41301:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41305:	48 8d 05 34 1b 01 00 	lea    0x11b34(%rip),%rax        # 52e40 <pageinfo>
   4130c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41310:	84 c0                	test   %al,%al
   41312:	78 57                	js     4136b <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41314:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41317:	48 98                	cltq   
   41319:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4131d:	48 8d 05 1c 1b 01 00 	lea    0x11b1c(%rip),%rax        # 52e40 <pageinfo>
   41324:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41328:	0f be c0             	movsbl %al,%eax
   4132b:	48 63 d0             	movslq %eax,%rdx
   4132e:	48 89 d0             	mov    %rdx,%rax
   41331:	48 c1 e0 03          	shl    $0x3,%rax
   41335:	48 29 d0             	sub    %rdx,%rax
   41338:	48 c1 e0 05          	shl    $0x5,%rax
   4133c:	48 89 c2             	mov    %rax,%rdx
   4133f:	48 8d 05 a2 0d 01 00 	lea    0x10da2(%rip),%rax        # 520e8 <processes+0xc8>
   41346:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41349:	85 c0                	test   %eax,%eax
   4134b:	75 1e                	jne    4136b <check_virtual_memory+0x1b4>
   4134d:	48 8d 05 9c 34 00 00 	lea    0x349c(%rip),%rax        # 447f0 <console_clear+0x2cd>
   41354:	48 89 c2             	mov    %rax,%rdx
   41357:	be 1c 02 00 00       	mov    $0x21c,%esi
   4135c:	48 8d 05 3d 32 00 00 	lea    0x323d(%rip),%rax        # 445a0 <console_clear+0x7d>
   41363:	48 89 c7             	mov    %rax,%rdi
   41366:	e8 6e 15 00 00       	call   428d9 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4136b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4136f:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41376:	0f 8e 68 ff ff ff    	jle    412e4 <check_virtual_memory+0x12d>
        }
    }
}
   4137c:	90                   	nop
   4137d:	90                   	nop
   4137e:	c9                   	leave  
   4137f:	c3                   	ret    

0000000000041380 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41380:	f3 0f 1e fa          	endbr64 
   41384:	55                   	push   %rbp
   41385:	48 89 e5             	mov    %rsp,%rbp
   41388:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4138c:	48 8d 05 b3 34 00 00 	lea    0x34b3(%rip),%rax        # 44846 <memstate_colors+0x26>
   41393:	48 89 c2             	mov    %rax,%rdx
   41396:	be 00 0f 00 00       	mov    $0xf00,%esi
   4139b:	bf 20 00 00 00       	mov    $0x20,%edi
   413a0:	b8 00 00 00 00       	mov    $0x0,%eax
   413a5:	e8 03 30 00 00       	call   443ad <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   413b1:	e9 1b 01 00 00       	jmp    414d1 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   413b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413b9:	83 e0 3f             	and    $0x3f,%eax
   413bc:	85 c0                	test   %eax,%eax
   413be:	75 40                	jne    41400 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   413c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413c3:	c1 e0 0c             	shl    $0xc,%eax
   413c6:	89 c2                	mov    %eax,%edx
   413c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413cb:	8d 48 3f             	lea    0x3f(%rax),%ecx
   413ce:	85 c0                	test   %eax,%eax
   413d0:	0f 48 c1             	cmovs  %ecx,%eax
   413d3:	c1 f8 06             	sar    $0x6,%eax
   413d6:	8d 48 01             	lea    0x1(%rax),%ecx
   413d9:	89 c8                	mov    %ecx,%eax
   413db:	c1 e0 02             	shl    $0x2,%eax
   413de:	01 c8                	add    %ecx,%eax
   413e0:	c1 e0 04             	shl    $0x4,%eax
   413e3:	83 c0 03             	add    $0x3,%eax
   413e6:	89 d1                	mov    %edx,%ecx
   413e8:	48 8d 15 67 34 00 00 	lea    0x3467(%rip),%rdx        # 44856 <memstate_colors+0x36>
   413ef:	be 00 0f 00 00       	mov    $0xf00,%esi
   413f4:	89 c7                	mov    %eax,%edi
   413f6:	b8 00 00 00 00       	mov    $0x0,%eax
   413fb:	e8 ad 2f 00 00       	call   443ad <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41400:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41403:	48 98                	cltq   
   41405:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41409:	48 8d 05 30 1a 01 00 	lea    0x11a30(%rip),%rax        # 52e40 <pageinfo>
   41410:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41414:	0f be c0             	movsbl %al,%eax
   41417:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   4141a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4141d:	48 98                	cltq   
   4141f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41423:	48 8d 05 17 1a 01 00 	lea    0x11a17(%rip),%rax        # 52e41 <pageinfo+0x1>
   4142a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4142e:	84 c0                	test   %al,%al
   41430:	75 07                	jne    41439 <memshow_physical+0xb9>
            owner = PO_FREE;
   41432:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41439:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4143c:	83 c0 02             	add    $0x2,%eax
   4143f:	48 98                	cltq   
   41441:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41445:	48 8d 05 d4 33 00 00 	lea    0x33d4(%rip),%rax        # 44820 <memstate_colors>
   4144c:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41450:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41454:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41457:	48 98                	cltq   
   41459:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4145d:	48 8d 05 dd 19 01 00 	lea    0x119dd(%rip),%rax        # 52e41 <pageinfo+0x1>
   41464:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41468:	3c 01                	cmp    $0x1,%al
   4146a:	7e 1c                	jle    41488 <memshow_physical+0x108>
   4146c:	48 8d 05 8d 6b 07 00 	lea    0x76b8d(%rip),%rax        # b8000 <console>
   41473:	48 c1 e8 0c          	shr    $0xc,%rax
   41477:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4147a:	74 0c                	je     41488 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4147c:	b8 53 00 00 00       	mov    $0x53,%eax
   41481:	80 cc 0f             	or     $0xf,%ah
   41484:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41488:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4148b:	8d 50 3f             	lea    0x3f(%rax),%edx
   4148e:	85 c0                	test   %eax,%eax
   41490:	0f 48 c2             	cmovs  %edx,%eax
   41493:	c1 f8 06             	sar    $0x6,%eax
   41496:	8d 50 01             	lea    0x1(%rax),%edx
   41499:	89 d0                	mov    %edx,%eax
   4149b:	c1 e0 02             	shl    $0x2,%eax
   4149e:	01 d0                	add    %edx,%eax
   414a0:	c1 e0 04             	shl    $0x4,%eax
   414a3:	89 c1                	mov    %eax,%ecx
   414a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414a8:	99                   	cltd   
   414a9:	c1 ea 1a             	shr    $0x1a,%edx
   414ac:	01 d0                	add    %edx,%eax
   414ae:	83 e0 3f             	and    $0x3f,%eax
   414b1:	29 d0                	sub    %edx,%eax
   414b3:	83 c0 0c             	add    $0xc,%eax
   414b6:	01 c8                	add    %ecx,%eax
   414b8:	48 98                	cltq   
   414ba:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   414be:	48 8d 15 3b 6b 07 00 	lea    0x76b3b(%rip),%rdx        # b8000 <console>
   414c5:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414c9:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   414cd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   414d1:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   414d8:	0f 8e d8 fe ff ff    	jle    413b6 <memshow_physical+0x36>
    }
}
   414de:	90                   	nop
   414df:	90                   	nop
   414e0:	c9                   	leave  
   414e1:	c3                   	ret    

00000000000414e2 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   414e2:	f3 0f 1e fa          	endbr64 
   414e6:	55                   	push   %rbp
   414e7:	48 89 e5             	mov    %rsp,%rbp
   414ea:	48 83 ec 40          	sub    $0x40,%rsp
   414ee:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   414f2:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   414f6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   414fa:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41500:	48 89 c2             	mov    %rax,%rdx
   41503:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41507:	48 39 c2             	cmp    %rax,%rdx
   4150a:	74 1e                	je     4152a <memshow_virtual+0x48>
   4150c:	48 8d 05 4d 33 00 00 	lea    0x334d(%rip),%rax        # 44860 <memstate_colors+0x40>
   41513:	48 89 c2             	mov    %rax,%rdx
   41516:	be 4d 02 00 00       	mov    $0x24d,%esi
   4151b:	48 8d 05 7e 30 00 00 	lea    0x307e(%rip),%rax        # 445a0 <console_clear+0x7d>
   41522:	48 89 c7             	mov    %rax,%rdi
   41525:	e8 af 13 00 00       	call   428d9 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   4152a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4152e:	48 89 c1             	mov    %rax,%rcx
   41531:	48 8d 05 55 33 00 00 	lea    0x3355(%rip),%rax        # 4488d <memstate_colors+0x6d>
   41538:	48 89 c2             	mov    %rax,%rdx
   4153b:	be 00 0f 00 00       	mov    $0xf00,%esi
   41540:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41545:	b8 00 00 00 00       	mov    $0x0,%eax
   4154a:	e8 5e 2e 00 00       	call   443ad <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4154f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41556:	00 
   41557:	e9 b4 01 00 00       	jmp    41710 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4155c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41560:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41564:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41568:	48 89 ce             	mov    %rcx,%rsi
   4156b:	48 89 c7             	mov    %rax,%rdi
   4156e:	e8 34 1b 00 00       	call   430a7 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41573:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41576:	85 c0                	test   %eax,%eax
   41578:	79 0b                	jns    41585 <memshow_virtual+0xa3>
            color = ' ';
   4157a:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41580:	e9 ff 00 00 00       	jmp    41684 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41585:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41589:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4158f:	76 1e                	jbe    415af <memshow_virtual+0xcd>
   41591:	48 8d 05 12 33 00 00 	lea    0x3312(%rip),%rax        # 448aa <memstate_colors+0x8a>
   41598:	48 89 c2             	mov    %rax,%rdx
   4159b:	be 56 02 00 00       	mov    $0x256,%esi
   415a0:	48 8d 05 f9 2f 00 00 	lea    0x2ff9(%rip),%rax        # 445a0 <console_clear+0x7d>
   415a7:	48 89 c7             	mov    %rax,%rdi
   415aa:	e8 2a 13 00 00       	call   428d9 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   415af:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415b2:	48 98                	cltq   
   415b4:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   415b8:	48 8d 05 81 18 01 00 	lea    0x11881(%rip),%rax        # 52e40 <pageinfo>
   415bf:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   415c3:	0f be c0             	movsbl %al,%eax
   415c6:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   415c9:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415cc:	48 98                	cltq   
   415ce:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   415d2:	48 8d 05 68 18 01 00 	lea    0x11868(%rip),%rax        # 52e41 <pageinfo+0x1>
   415d9:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   415dd:	84 c0                	test   %al,%al
   415df:	75 07                	jne    415e8 <memshow_virtual+0x106>
                owner = PO_FREE;
   415e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   415e8:	8b 45 f0             	mov    -0x10(%rbp),%eax
   415eb:	83 c0 02             	add    $0x2,%eax
   415ee:	48 98                	cltq   
   415f0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   415f4:	48 8d 05 25 32 00 00 	lea    0x3225(%rip),%rax        # 44820 <memstate_colors>
   415fb:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   415ff:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41603:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41606:	48 98                	cltq   
   41608:	83 e0 04             	and    $0x4,%eax
   4160b:	48 85 c0             	test   %rax,%rax
   4160e:	74 27                	je     41637 <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41610:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41614:	c1 e0 04             	shl    $0x4,%eax
   41617:	66 25 00 f0          	and    $0xf000,%ax
   4161b:	89 c2                	mov    %eax,%edx
   4161d:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41621:	c1 f8 04             	sar    $0x4,%eax
   41624:	66 25 00 0f          	and    $0xf00,%ax
   41628:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   4162a:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4162e:	0f b6 c0             	movzbl %al,%eax
   41631:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41633:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41637:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4163a:	48 98                	cltq   
   4163c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41640:	48 8d 05 fa 17 01 00 	lea    0x117fa(%rip),%rax        # 52e41 <pageinfo+0x1>
   41647:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4164b:	3c 01                	cmp    $0x1,%al
   4164d:	7e 35                	jle    41684 <memshow_virtual+0x1a2>
   4164f:	48 8d 05 aa 69 07 00 	lea    0x769aa(%rip),%rax        # b8000 <console>
   41656:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4165a:	74 28                	je     41684 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   4165c:	b8 53 00 00 00       	mov    $0x53,%eax
   41661:	89 c2                	mov    %eax,%edx
   41663:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41667:	66 25 00 f0          	and    $0xf000,%ax
   4166b:	09 d0                	or     %edx,%eax
   4166d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41671:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41674:	48 98                	cltq   
   41676:	83 e0 04             	and    $0x4,%eax
   41679:	48 85 c0             	test   %rax,%rax
   4167c:	75 06                	jne    41684 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   4167e:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41684:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41688:	48 c1 e8 0c          	shr    $0xc,%rax
   4168c:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   4168f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41692:	83 e0 3f             	and    $0x3f,%eax
   41695:	85 c0                	test   %eax,%eax
   41697:	75 39                	jne    416d2 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41699:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4169c:	c1 e8 06             	shr    $0x6,%eax
   4169f:	89 c2                	mov    %eax,%edx
   416a1:	89 d0                	mov    %edx,%eax
   416a3:	c1 e0 02             	shl    $0x2,%eax
   416a6:	01 d0                	add    %edx,%eax
   416a8:	c1 e0 04             	shl    $0x4,%eax
   416ab:	05 73 03 00 00       	add    $0x373,%eax
   416b0:	89 c7                	mov    %eax,%edi
   416b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416b6:	48 89 c1             	mov    %rax,%rcx
   416b9:	48 8d 05 96 31 00 00 	lea    0x3196(%rip),%rax        # 44856 <memstate_colors+0x36>
   416c0:	48 89 c2             	mov    %rax,%rdx
   416c3:	be 00 0f 00 00       	mov    $0xf00,%esi
   416c8:	b8 00 00 00 00       	mov    $0x0,%eax
   416cd:	e8 db 2c 00 00       	call   443ad <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   416d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416d5:	c1 e8 06             	shr    $0x6,%eax
   416d8:	89 c2                	mov    %eax,%edx
   416da:	89 d0                	mov    %edx,%eax
   416dc:	c1 e0 02             	shl    $0x2,%eax
   416df:	01 d0                	add    %edx,%eax
   416e1:	c1 e0 04             	shl    $0x4,%eax
   416e4:	89 c2                	mov    %eax,%edx
   416e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416e9:	83 e0 3f             	and    $0x3f,%eax
   416ec:	01 d0                	add    %edx,%eax
   416ee:	05 7c 03 00 00       	add    $0x37c,%eax
   416f3:	89 c0                	mov    %eax,%eax
   416f5:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   416f9:	48 8d 15 00 69 07 00 	lea    0x76900(%rip),%rdx        # b8000 <console>
   41700:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41704:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41708:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4170f:	00 
   41710:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41717:	00 
   41718:	0f 86 3e fe ff ff    	jbe    4155c <memshow_virtual+0x7a>
    }
}
   4171e:	90                   	nop
   4171f:	90                   	nop
   41720:	c9                   	leave  
   41721:	c3                   	ret    

0000000000041722 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41722:	f3 0f 1e fa          	endbr64 
   41726:	55                   	push   %rbp
   41727:	48 89 e5             	mov    %rsp,%rbp
   4172a:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   4172e:	8b 05 0c 1b 01 00    	mov    0x11b0c(%rip),%eax        # 53240 <last_ticks.1>
   41734:	85 c0                	test   %eax,%eax
   41736:	74 13                	je     4174b <memshow_virtual_animate+0x29>
   41738:	8b 05 e2 16 01 00    	mov    0x116e2(%rip),%eax        # 52e20 <ticks>
   4173e:	8b 15 fc 1a 01 00    	mov    0x11afc(%rip),%edx        # 53240 <last_ticks.1>
   41744:	29 d0                	sub    %edx,%eax
   41746:	83 f8 31             	cmp    $0x31,%eax
   41749:	76 2c                	jbe    41777 <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   4174b:	8b 05 cf 16 01 00    	mov    0x116cf(%rip),%eax        # 52e20 <ticks>
   41751:	89 05 e9 1a 01 00    	mov    %eax,0x11ae9(%rip)        # 53240 <last_ticks.1>
        ++showing;
   41757:	8b 05 a7 48 00 00    	mov    0x48a7(%rip),%eax        # 46004 <showing.0>
   4175d:	83 c0 01             	add    $0x1,%eax
   41760:	89 05 9e 48 00 00    	mov    %eax,0x489e(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41766:	eb 0f                	jmp    41777 <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41768:	8b 05 96 48 00 00    	mov    0x4896(%rip),%eax        # 46004 <showing.0>
   4176e:	83 c0 01             	add    $0x1,%eax
   41771:	89 05 8d 48 00 00    	mov    %eax,0x488d(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41777:	8b 05 87 48 00 00    	mov    0x4887(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   4177d:	83 f8 20             	cmp    $0x20,%eax
   41780:	7f 6b                	jg     417ed <memshow_virtual_animate+0xcb>
   41782:	8b 05 7c 48 00 00    	mov    0x487c(%rip),%eax        # 46004 <showing.0>
   41788:	99                   	cltd   
   41789:	c1 ea 1c             	shr    $0x1c,%edx
   4178c:	01 d0                	add    %edx,%eax
   4178e:	83 e0 0f             	and    $0xf,%eax
   41791:	29 d0                	sub    %edx,%eax
   41793:	48 63 d0             	movslq %eax,%rdx
   41796:	48 89 d0             	mov    %rdx,%rax
   41799:	48 c1 e0 03          	shl    $0x3,%rax
   4179d:	48 29 d0             	sub    %rdx,%rax
   417a0:	48 c1 e0 05          	shl    $0x5,%rax
   417a4:	48 89 c2             	mov    %rax,%rdx
   417a7:	48 8d 05 3a 09 01 00 	lea    0x1093a(%rip),%rax        # 520e8 <processes+0xc8>
   417ae:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   417b1:	85 c0                	test   %eax,%eax
   417b3:	74 b3                	je     41768 <memshow_virtual_animate+0x46>
   417b5:	8b 05 49 48 00 00    	mov    0x4849(%rip),%eax        # 46004 <showing.0>
   417bb:	99                   	cltd   
   417bc:	c1 ea 1c             	shr    $0x1c,%edx
   417bf:	01 d0                	add    %edx,%eax
   417c1:	83 e0 0f             	and    $0xf,%eax
   417c4:	29 d0                	sub    %edx,%eax
   417c6:	48 63 d0             	movslq %eax,%rdx
   417c9:	48 89 d0             	mov    %rdx,%rax
   417cc:	48 c1 e0 03          	shl    $0x3,%rax
   417d0:	48 29 d0             	sub    %rdx,%rax
   417d3:	48 c1 e0 05          	shl    $0x5,%rax
   417d7:	48 89 c2             	mov    %rax,%rdx
   417da:	48 8d 05 17 09 01 00 	lea    0x10917(%rip),%rax        # 520f8 <processes+0xd8>
   417e1:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   417e5:	84 c0                	test   %al,%al
   417e7:	0f 84 7b ff ff ff    	je     41768 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   417ed:	8b 05 11 48 00 00    	mov    0x4811(%rip),%eax        # 46004 <showing.0>
   417f3:	99                   	cltd   
   417f4:	c1 ea 1c             	shr    $0x1c,%edx
   417f7:	01 d0                	add    %edx,%eax
   417f9:	83 e0 0f             	and    $0xf,%eax
   417fc:	29 d0                	sub    %edx,%eax
   417fe:	89 05 00 48 00 00    	mov    %eax,0x4800(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41804:	8b 05 fa 47 00 00    	mov    0x47fa(%rip),%eax        # 46004 <showing.0>
   4180a:	48 63 d0             	movslq %eax,%rdx
   4180d:	48 89 d0             	mov    %rdx,%rax
   41810:	48 c1 e0 03          	shl    $0x3,%rax
   41814:	48 29 d0             	sub    %rdx,%rax
   41817:	48 c1 e0 05          	shl    $0x5,%rax
   4181b:	48 89 c2             	mov    %rax,%rdx
   4181e:	48 8d 05 c3 08 01 00 	lea    0x108c3(%rip),%rax        # 520e8 <processes+0xc8>
   41825:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41828:	85 c0                	test   %eax,%eax
   4182a:	74 59                	je     41885 <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   4182c:	8b 15 d2 47 00 00    	mov    0x47d2(%rip),%edx        # 46004 <showing.0>
   41832:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41836:	89 d1                	mov    %edx,%ecx
   41838:	48 8d 15 85 30 00 00 	lea    0x3085(%rip),%rdx        # 448c4 <memstate_colors+0xa4>
   4183f:	be 04 00 00 00       	mov    $0x4,%esi
   41844:	48 89 c7             	mov    %rax,%rdi
   41847:	b8 00 00 00 00       	mov    $0x0,%eax
   4184c:	e8 77 2c 00 00       	call   444c8 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41851:	8b 05 ad 47 00 00    	mov    0x47ad(%rip),%eax        # 46004 <showing.0>
   41857:	48 63 d0             	movslq %eax,%rdx
   4185a:	48 89 d0             	mov    %rdx,%rax
   4185d:	48 c1 e0 03          	shl    $0x3,%rax
   41861:	48 29 d0             	sub    %rdx,%rax
   41864:	48 c1 e0 05          	shl    $0x5,%rax
   41868:	48 89 c2             	mov    %rax,%rdx
   4186b:	48 8d 05 7e 08 01 00 	lea    0x1087e(%rip),%rax        # 520f0 <processes+0xd0>
   41872:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41876:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4187a:	48 89 d6             	mov    %rdx,%rsi
   4187d:	48 89 c7             	mov    %rax,%rdi
   41880:	e8 5d fc ff ff       	call   414e2 <memshow_virtual>
    }
}
   41885:	90                   	nop
   41886:	c9                   	leave  
   41887:	c3                   	ret    

0000000000041888 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41888:	f3 0f 1e fa          	endbr64 
   4188c:	55                   	push   %rbp
   4188d:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41890:	e8 5f 01 00 00       	call   419f4 <segments_init>
    interrupt_init();
   41895:	e8 44 04 00 00       	call   41cde <interrupt_init>
    virtual_memory_init();
   4189a:	e8 11 11 00 00       	call   429b0 <virtual_memory_init>
}
   4189f:	90                   	nop
   418a0:	5d                   	pop    %rbp
   418a1:	c3                   	ret    

00000000000418a2 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   418a2:	f3 0f 1e fa          	endbr64 
   418a6:	55                   	push   %rbp
   418a7:	48 89 e5             	mov    %rsp,%rbp
   418aa:	48 83 ec 18          	sub    $0x18,%rsp
   418ae:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418b2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   418b6:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   418b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   418bc:	48 98                	cltq   
   418be:	48 c1 e0 2d          	shl    $0x2d,%rax
   418c2:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   418c6:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   418cd:	90 00 00 
   418d0:	48 09 c2             	or     %rax,%rdx
    *segment = type
   418d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418d7:	48 89 10             	mov    %rdx,(%rax)
}
   418da:	90                   	nop
   418db:	c9                   	leave  
   418dc:	c3                   	ret    

00000000000418dd <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   418dd:	f3 0f 1e fa          	endbr64 
   418e1:	55                   	push   %rbp
   418e2:	48 89 e5             	mov    %rsp,%rbp
   418e5:	48 83 ec 28          	sub    $0x28,%rsp
   418e9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418ed:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   418f1:	89 55 ec             	mov    %edx,-0x14(%rbp)
   418f4:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   418f8:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   418fc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41900:	48 c1 e0 10          	shl    $0x10,%rax
   41904:	48 89 c2             	mov    %rax,%rdx
   41907:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   4190e:	00 00 00 
   41911:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41914:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41918:	48 c1 e0 20          	shl    $0x20,%rax
   4191c:	48 89 c1             	mov    %rax,%rcx
   4191f:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41926:	00 00 ff 
   41929:	48 21 c8             	and    %rcx,%rax
   4192c:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   4192f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41933:	48 83 e8 01          	sub    $0x1,%rax
   41937:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   4193a:	48 09 d0             	or     %rdx,%rax
        | type
   4193d:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41941:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41944:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41947:	48 98                	cltq   
   41949:	48 c1 e0 2d          	shl    $0x2d,%rax
   4194d:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41950:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41957:	80 00 00 
   4195a:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   4195d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41961:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41964:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41968:	48 83 c0 08          	add    $0x8,%rax
   4196c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41970:	48 c1 ea 20          	shr    $0x20,%rdx
   41974:	48 89 10             	mov    %rdx,(%rax)
}
   41977:	90                   	nop
   41978:	c9                   	leave  
   41979:	c3                   	ret    

000000000004197a <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   4197a:	f3 0f 1e fa          	endbr64 
   4197e:	55                   	push   %rbp
   4197f:	48 89 e5             	mov    %rsp,%rbp
   41982:	48 83 ec 20          	sub    $0x20,%rsp
   41986:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4198a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4198e:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41991:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41995:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41999:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4199c:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   419a0:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   419a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   419a6:	48 98                	cltq   
   419a8:	48 c1 e0 2d          	shl    $0x2d,%rax
   419ac:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   419af:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419b3:	48 c1 e0 20          	shl    $0x20,%rax
   419b7:	48 89 c1             	mov    %rax,%rcx
   419ba:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   419c1:	00 ff ff 
   419c4:	48 21 c8             	and    %rcx,%rax
   419c7:	48 09 c2             	or     %rax,%rdx
   419ca:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   419d1:	80 00 00 
   419d4:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   419d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419db:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   419de:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419e2:	48 c1 e8 20          	shr    $0x20,%rax
   419e6:	48 89 c2             	mov    %rax,%rdx
   419e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419ed:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   419f1:	90                   	nop
   419f2:	c9                   	leave  
   419f3:	c3                   	ret    

00000000000419f4 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   419f4:	f3 0f 1e fa          	endbr64 
   419f8:	55                   	push   %rbp
   419f9:	48 89 e5             	mov    %rsp,%rbp
   419fc:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41a00:	48 c7 05 55 18 01 00 	movq   $0x0,0x11855(%rip)        # 53260 <segments>
   41a07:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41a0b:	ba 00 00 00 00       	mov    $0x0,%edx
   41a10:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41a17:	08 20 00 
   41a1a:	48 89 c6             	mov    %rax,%rsi
   41a1d:	48 8d 05 44 18 01 00 	lea    0x11844(%rip),%rax        # 53268 <segments+0x8>
   41a24:	48 89 c7             	mov    %rax,%rdi
   41a27:	e8 76 fe ff ff       	call   418a2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41a2c:	ba 03 00 00 00       	mov    $0x3,%edx
   41a31:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41a38:	08 20 00 
   41a3b:	48 89 c6             	mov    %rax,%rsi
   41a3e:	48 8d 05 2b 18 01 00 	lea    0x1182b(%rip),%rax        # 53270 <segments+0x10>
   41a45:	48 89 c7             	mov    %rax,%rdi
   41a48:	e8 55 fe ff ff       	call   418a2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41a4d:	ba 00 00 00 00       	mov    $0x0,%edx
   41a52:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41a59:	02 00 00 
   41a5c:	48 89 c6             	mov    %rax,%rsi
   41a5f:	48 8d 05 12 18 01 00 	lea    0x11812(%rip),%rax        # 53278 <segments+0x18>
   41a66:	48 89 c7             	mov    %rax,%rdi
   41a69:	e8 34 fe ff ff       	call   418a2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41a6e:	ba 03 00 00 00       	mov    $0x3,%edx
   41a73:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41a7a:	02 00 00 
   41a7d:	48 89 c6             	mov    %rax,%rsi
   41a80:	48 8d 05 f9 17 01 00 	lea    0x117f9(%rip),%rax        # 53280 <segments+0x20>
   41a87:	48 89 c7             	mov    %rax,%rdi
   41a8a:	e8 13 fe ff ff       	call   418a2 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41a8f:	48 8d 05 0a 28 01 00 	lea    0x1280a(%rip),%rax        # 542a0 <kernel_task_descriptor>
   41a96:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41a9c:	48 89 c1             	mov    %rax,%rcx
   41a9f:	ba 00 00 00 00       	mov    $0x0,%edx
   41aa4:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41aab:	09 00 00 
   41aae:	48 89 c6             	mov    %rax,%rsi
   41ab1:	48 8d 05 d0 17 01 00 	lea    0x117d0(%rip),%rax        # 53288 <segments+0x28>
   41ab8:	48 89 c7             	mov    %rax,%rdi
   41abb:	e8 1d fe ff ff       	call   418dd <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41ac0:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41ac6:	48 8d 05 93 17 01 00 	lea    0x11793(%rip),%rax        # 53260 <segments>
   41acd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41ad1:	ba 60 00 00 00       	mov    $0x60,%edx
   41ad6:	be 00 00 00 00       	mov    $0x0,%esi
   41adb:	48 8d 05 be 27 01 00 	lea    0x127be(%rip),%rax        # 542a0 <kernel_task_descriptor>
   41ae2:	48 89 c7             	mov    %rax,%rdi
   41ae5:	e8 84 1a 00 00       	call   4356e <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41aea:	48 c7 05 af 27 01 00 	movq   $0x80000,0x127af(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41af1:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41af5:	ba 00 10 00 00       	mov    $0x1000,%edx
   41afa:	be 00 00 00 00       	mov    $0x0,%esi
   41aff:	48 8d 05 9a 17 01 00 	lea    0x1179a(%rip),%rax        # 532a0 <interrupt_descriptors>
   41b06:	48 89 c7             	mov    %rax,%rdi
   41b09:	e8 60 1a 00 00       	call   4356e <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41b0e:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41b15:	eb 3c                	jmp    41b53 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41b17:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   41b1e:	48 89 c2             	mov    %rax,%rdx
   41b21:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41b24:	48 c1 e0 04          	shl    $0x4,%rax
   41b28:	48 89 c1             	mov    %rax,%rcx
   41b2b:	48 8d 05 6e 17 01 00 	lea    0x1176e(%rip),%rax        # 532a0 <interrupt_descriptors>
   41b32:	48 01 c8             	add    %rcx,%rax
   41b35:	48 89 d1             	mov    %rdx,%rcx
   41b38:	ba 00 00 00 00       	mov    $0x0,%edx
   41b3d:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41b44:	0e 00 00 
   41b47:	48 89 c7             	mov    %rax,%rdi
   41b4a:	e8 2b fe ff ff       	call   4197a <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41b4f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41b53:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41b5a:	76 bb                	jbe    41b17 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41b5c:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   41b63:	48 89 c1             	mov    %rax,%rcx
   41b66:	ba 00 00 00 00       	mov    $0x0,%edx
   41b6b:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41b72:	0e 00 00 
   41b75:	48 89 c6             	mov    %rax,%rsi
   41b78:	48 8d 05 21 19 01 00 	lea    0x11921(%rip),%rax        # 534a0 <interrupt_descriptors+0x200>
   41b7f:	48 89 c7             	mov    %rax,%rdi
   41b82:	e8 f3 fd ff ff       	call   4197a <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41b87:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   41b8e:	48 89 c1             	mov    %rax,%rcx
   41b91:	ba 00 00 00 00       	mov    $0x0,%edx
   41b96:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41b9d:	0e 00 00 
   41ba0:	48 89 c6             	mov    %rax,%rsi
   41ba3:	48 8d 05 c6 17 01 00 	lea    0x117c6(%rip),%rax        # 53370 <interrupt_descriptors+0xd0>
   41baa:	48 89 c7             	mov    %rax,%rdi
   41bad:	e8 c8 fd ff ff       	call   4197a <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41bb2:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   41bb9:	48 89 c1             	mov    %rax,%rcx
   41bbc:	ba 00 00 00 00       	mov    $0x0,%edx
   41bc1:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41bc8:	0e 00 00 
   41bcb:	48 89 c6             	mov    %rax,%rsi
   41bce:	48 8d 05 ab 17 01 00 	lea    0x117ab(%rip),%rax        # 53380 <interrupt_descriptors+0xe0>
   41bd5:	48 89 c7             	mov    %rax,%rdi
   41bd8:	e8 9d fd ff ff       	call   4197a <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41bdd:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41be4:	eb 50                	jmp    41c36 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41be6:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41be9:	83 e8 30             	sub    $0x30,%eax
   41bec:	89 c0                	mov    %eax,%eax
   41bee:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   41bf5:	00 
   41bf6:	48 8d 05 ea e4 ff ff 	lea    -0x1b16(%rip),%rax        # 400e7 <sys_int_handlers>
   41bfd:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41c01:	48 89 c2             	mov    %rax,%rdx
   41c04:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c07:	48 c1 e0 04          	shl    $0x4,%rax
   41c0b:	48 89 c1             	mov    %rax,%rcx
   41c0e:	48 8d 05 8b 16 01 00 	lea    0x1168b(%rip),%rax        # 532a0 <interrupt_descriptors>
   41c15:	48 01 c8             	add    %rcx,%rax
   41c18:	48 89 d1             	mov    %rdx,%rcx
   41c1b:	ba 03 00 00 00       	mov    $0x3,%edx
   41c20:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41c27:	0e 00 00 
   41c2a:	48 89 c7             	mov    %rax,%rdi
   41c2d:	e8 48 fd ff ff       	call   4197a <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41c32:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41c36:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41c3a:	76 aa                	jbe    41be6 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41c3c:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41c42:	48 8d 05 57 16 01 00 	lea    0x11657(%rip),%rax        # 532a0 <interrupt_descriptors>
   41c49:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41c4d:	b8 28 00 00 00       	mov    $0x28,%eax
   41c52:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41c56:	0f 00 d8             	ltr    %ax
   41c59:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41c5d:	0f 20 c0             	mov    %cr0,%rax
   41c60:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41c64:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41c68:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41c6b:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41c72:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c75:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41c78:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c7b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41c7f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41c83:	0f 22 c0             	mov    %rax,%cr0
}
   41c86:	90                   	nop
    lcr0(cr0);
}
   41c87:	90                   	nop
   41c88:	c9                   	leave  
   41c89:	c3                   	ret    

0000000000041c8a <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41c8a:	f3 0f 1e fa          	endbr64 
   41c8e:	55                   	push   %rbp
   41c8f:	48 89 e5             	mov    %rsp,%rbp
   41c92:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41c96:	0f b7 05 63 26 01 00 	movzwl 0x12663(%rip),%eax        # 54300 <interrupts_enabled>
   41c9d:	f7 d0                	not    %eax
   41c9f:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41ca3:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41ca7:	0f b6 c0             	movzbl %al,%eax
   41caa:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41cb1:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cb4:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41cb8:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41cbb:	ee                   	out    %al,(%dx)
}
   41cbc:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41cbd:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41cc1:	66 c1 e8 08          	shr    $0x8,%ax
   41cc5:	0f b6 c0             	movzbl %al,%eax
   41cc8:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41ccf:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cd2:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41cd6:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41cd9:	ee                   	out    %al,(%dx)
}
   41cda:	90                   	nop
}
   41cdb:	90                   	nop
   41cdc:	c9                   	leave  
   41cdd:	c3                   	ret    

0000000000041cde <interrupt_init>:

void interrupt_init(void) {
   41cde:	f3 0f 1e fa          	endbr64 
   41ce2:	55                   	push   %rbp
   41ce3:	48 89 e5             	mov    %rsp,%rbp
   41ce6:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41cea:	66 c7 05 0d 26 01 00 	movw   $0x0,0x1260d(%rip)        # 54300 <interrupts_enabled>
   41cf1:	00 00 
    interrupt_mask();
   41cf3:	e8 92 ff ff ff       	call   41c8a <interrupt_mask>
   41cf8:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41cff:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d03:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41d07:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41d0a:	ee                   	out    %al,(%dx)
}
   41d0b:	90                   	nop
   41d0c:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41d13:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d17:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41d1b:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41d1e:	ee                   	out    %al,(%dx)
}
   41d1f:	90                   	nop
   41d20:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41d27:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d2b:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41d2f:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41d32:	ee                   	out    %al,(%dx)
}
   41d33:	90                   	nop
   41d34:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41d3b:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d3f:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41d43:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41d46:	ee                   	out    %al,(%dx)
}
   41d47:	90                   	nop
   41d48:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41d4f:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d53:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41d57:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41d5a:	ee                   	out    %al,(%dx)
}
   41d5b:	90                   	nop
   41d5c:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41d63:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d67:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41d6b:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41d6e:	ee                   	out    %al,(%dx)
}
   41d6f:	90                   	nop
   41d70:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41d77:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d7b:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41d7f:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41d82:	ee                   	out    %al,(%dx)
}
   41d83:	90                   	nop
   41d84:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41d8b:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d8f:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41d93:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41d96:	ee                   	out    %al,(%dx)
}
   41d97:	90                   	nop
   41d98:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41d9f:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41da3:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41da7:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41daa:	ee                   	out    %al,(%dx)
}
   41dab:	90                   	nop
   41dac:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41db3:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41db7:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41dbb:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41dbe:	ee                   	out    %al,(%dx)
}
   41dbf:	90                   	nop
   41dc0:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41dc7:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dcb:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41dcf:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41dd2:	ee                   	out    %al,(%dx)
}
   41dd3:	90                   	nop
   41dd4:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41ddb:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ddf:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41de3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41de6:	ee                   	out    %al,(%dx)
}
   41de7:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41de8:	e8 9d fe ff ff       	call   41c8a <interrupt_mask>
}
   41ded:	90                   	nop
   41dee:	c9                   	leave  
   41def:	c3                   	ret    

0000000000041df0 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41df0:	f3 0f 1e fa          	endbr64 
   41df4:	55                   	push   %rbp
   41df5:	48 89 e5             	mov    %rsp,%rbp
   41df8:	48 83 ec 28          	sub    $0x28,%rsp
   41dfc:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41dff:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41e03:	0f 8e 9f 00 00 00    	jle    41ea8 <timer_init+0xb8>
   41e09:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41e10:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e14:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41e18:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e1b:	ee                   	out    %al,(%dx)
}
   41e1c:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41e1d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e20:	89 c2                	mov    %eax,%edx
   41e22:	c1 ea 1f             	shr    $0x1f,%edx
   41e25:	01 d0                	add    %edx,%eax
   41e27:	d1 f8                	sar    %eax
   41e29:	05 de 34 12 00       	add    $0x1234de,%eax
   41e2e:	99                   	cltd   
   41e2f:	f7 7d dc             	idivl  -0x24(%rbp)
   41e32:	89 c2                	mov    %eax,%edx
   41e34:	89 d0                	mov    %edx,%eax
   41e36:	c1 f8 1f             	sar    $0x1f,%eax
   41e39:	c1 e8 18             	shr    $0x18,%eax
   41e3c:	89 c1                	mov    %eax,%ecx
   41e3e:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41e41:	0f b6 c0             	movzbl %al,%eax
   41e44:	29 c8                	sub    %ecx,%eax
   41e46:	0f b6 c0             	movzbl %al,%eax
   41e49:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41e50:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e53:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41e57:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e5a:	ee                   	out    %al,(%dx)
}
   41e5b:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41e5c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e5f:	89 c2                	mov    %eax,%edx
   41e61:	c1 ea 1f             	shr    $0x1f,%edx
   41e64:	01 d0                	add    %edx,%eax
   41e66:	d1 f8                	sar    %eax
   41e68:	05 de 34 12 00       	add    $0x1234de,%eax
   41e6d:	99                   	cltd   
   41e6e:	f7 7d dc             	idivl  -0x24(%rbp)
   41e71:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41e77:	85 c0                	test   %eax,%eax
   41e79:	0f 48 c2             	cmovs  %edx,%eax
   41e7c:	c1 f8 08             	sar    $0x8,%eax
   41e7f:	0f b6 c0             	movzbl %al,%eax
   41e82:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41e89:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e8c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e90:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e93:	ee                   	out    %al,(%dx)
}
   41e94:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41e95:	0f b7 05 64 24 01 00 	movzwl 0x12464(%rip),%eax        # 54300 <interrupts_enabled>
   41e9c:	83 c8 01             	or     $0x1,%eax
   41e9f:	66 89 05 5a 24 01 00 	mov    %ax,0x1245a(%rip)        # 54300 <interrupts_enabled>
   41ea6:	eb 11                	jmp    41eb9 <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41ea8:	0f b7 05 51 24 01 00 	movzwl 0x12451(%rip),%eax        # 54300 <interrupts_enabled>
   41eaf:	83 e0 fe             	and    $0xfffffffe,%eax
   41eb2:	66 89 05 47 24 01 00 	mov    %ax,0x12447(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   41eb9:	e8 cc fd ff ff       	call   41c8a <interrupt_mask>
}
   41ebe:	90                   	nop
   41ebf:	c9                   	leave  
   41ec0:	c3                   	ret    

0000000000041ec1 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41ec1:	f3 0f 1e fa          	endbr64 
   41ec5:	55                   	push   %rbp
   41ec6:	48 89 e5             	mov    %rsp,%rbp
   41ec9:	48 83 ec 08          	sub    $0x8,%rsp
   41ecd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41ed1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41ed6:	74 14                	je     41eec <physical_memory_isreserved+0x2b>
   41ed8:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41edf:	00 
   41ee0:	76 11                	jbe    41ef3 <physical_memory_isreserved+0x32>
   41ee2:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41ee9:	00 
   41eea:	77 07                	ja     41ef3 <physical_memory_isreserved+0x32>
   41eec:	b8 01 00 00 00       	mov    $0x1,%eax
   41ef1:	eb 05                	jmp    41ef8 <physical_memory_isreserved+0x37>
   41ef3:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41ef8:	c9                   	leave  
   41ef9:	c3                   	ret    

0000000000041efa <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41efa:	f3 0f 1e fa          	endbr64 
   41efe:	55                   	push   %rbp
   41eff:	48 89 e5             	mov    %rsp,%rbp
   41f02:	48 83 ec 10          	sub    $0x10,%rsp
   41f06:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41f09:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41f0c:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41f0f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f12:	c1 e0 10             	shl    $0x10,%eax
   41f15:	89 c2                	mov    %eax,%edx
   41f17:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f1a:	c1 e0 0b             	shl    $0xb,%eax
   41f1d:	09 c2                	or     %eax,%edx
   41f1f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f22:	c1 e0 08             	shl    $0x8,%eax
   41f25:	09 d0                	or     %edx,%eax
}
   41f27:	c9                   	leave  
   41f28:	c3                   	ret    

0000000000041f29 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41f29:	f3 0f 1e fa          	endbr64 
   41f2d:	55                   	push   %rbp
   41f2e:	48 89 e5             	mov    %rsp,%rbp
   41f31:	48 83 ec 18          	sub    $0x18,%rsp
   41f35:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41f38:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41f3b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f3e:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f41:	09 d0                	or     %edx,%eax
   41f43:	0d 00 00 00 80       	or     $0x80000000,%eax
   41f48:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41f4f:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41f52:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f55:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f58:	ef                   	out    %eax,(%dx)
}
   41f59:	90                   	nop
   41f5a:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41f61:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f64:	89 c2                	mov    %eax,%edx
   41f66:	ed                   	in     (%dx),%eax
   41f67:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41f6a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41f6d:	c9                   	leave  
   41f6e:	c3                   	ret    

0000000000041f6f <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41f6f:	f3 0f 1e fa          	endbr64 
   41f73:	55                   	push   %rbp
   41f74:	48 89 e5             	mov    %rsp,%rbp
   41f77:	48 83 ec 28          	sub    $0x28,%rsp
   41f7b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41f7e:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41f81:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41f88:	eb 73                	jmp    41ffd <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   41f8a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41f91:	eb 60                	jmp    41ff3 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   41f93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41f9a:	eb 4a                	jmp    41fe6 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41f9c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f9f:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41fa2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41fa5:	89 ce                	mov    %ecx,%esi
   41fa7:	89 c7                	mov    %eax,%edi
   41fa9:	e8 4c ff ff ff       	call   41efa <pci_make_configaddr>
   41fae:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41fb1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fb4:	be 00 00 00 00       	mov    $0x0,%esi
   41fb9:	89 c7                	mov    %eax,%edi
   41fbb:	e8 69 ff ff ff       	call   41f29 <pci_config_readl>
   41fc0:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41fc3:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41fc6:	c1 e0 10             	shl    $0x10,%eax
   41fc9:	0b 45 dc             	or     -0x24(%rbp),%eax
   41fcc:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41fcf:	75 05                	jne    41fd6 <pci_find_device+0x67>
                    return configaddr;
   41fd1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fd4:	eb 35                	jmp    4200b <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41fd6:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41fda:	75 06                	jne    41fe2 <pci_find_device+0x73>
   41fdc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41fe0:	74 0c                	je     41fee <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   41fe2:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41fe6:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41fea:	75 b0                	jne    41f9c <pci_find_device+0x2d>
   41fec:	eb 01                	jmp    41fef <pci_find_device+0x80>
                    break;
   41fee:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41fef:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41ff3:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41ff7:	75 9a                	jne    41f93 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   41ff9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41ffd:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42004:	75 84                	jne    41f8a <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   42006:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   4200b:	c9                   	leave  
   4200c:	c3                   	ret    

000000000004200d <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   4200d:	f3 0f 1e fa          	endbr64 
   42011:	55                   	push   %rbp
   42012:	48 89 e5             	mov    %rsp,%rbp
   42015:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42019:	be 13 71 00 00       	mov    $0x7113,%esi
   4201e:	bf 86 80 00 00       	mov    $0x8086,%edi
   42023:	e8 47 ff ff ff       	call   41f6f <pci_find_device>
   42028:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   4202b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4202f:	78 30                	js     42061 <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   42031:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42034:	be 40 00 00 00       	mov    $0x40,%esi
   42039:	89 c7                	mov    %eax,%edi
   4203b:	e8 e9 fe ff ff       	call   41f29 <pci_config_readl>
   42040:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42045:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42048:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4204b:	83 c0 04             	add    $0x4,%eax
   4204e:	89 45 f4             	mov    %eax,-0xc(%rbp)
   42051:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42057:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   4205b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4205e:	66 ef                	out    %ax,(%dx)
}
   42060:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42061:	48 8d 05 78 28 00 00 	lea    0x2878(%rip),%rax        # 448e0 <memstate_colors+0xc0>
   42068:	48 89 c2             	mov    %rax,%rdx
   4206b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42070:	bf 80 07 00 00       	mov    $0x780,%edi
   42075:	b8 00 00 00 00       	mov    $0x0,%eax
   4207a:	e8 2e 23 00 00       	call   443ad <console_printf>
 spinloop: goto spinloop;
   4207f:	eb fe                	jmp    4207f <poweroff+0x72>

0000000000042081 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   42081:	f3 0f 1e fa          	endbr64 
   42085:	55                   	push   %rbp
   42086:	48 89 e5             	mov    %rsp,%rbp
   42089:	48 83 ec 10          	sub    $0x10,%rsp
   4208d:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42094:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42098:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4209c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4209f:	ee                   	out    %al,(%dx)
}
   420a0:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   420a1:	eb fe                	jmp    420a1 <reboot+0x20>

00000000000420a3 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   420a3:	f3 0f 1e fa          	endbr64 
   420a7:	55                   	push   %rbp
   420a8:	48 89 e5             	mov    %rsp,%rbp
   420ab:	48 83 ec 10          	sub    $0x10,%rsp
   420af:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   420b3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   420b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420ba:	48 83 c0 08          	add    $0x8,%rax
   420be:	ba c0 00 00 00       	mov    $0xc0,%edx
   420c3:	be 00 00 00 00       	mov    $0x0,%esi
   420c8:	48 89 c7             	mov    %rax,%rdi
   420cb:	e8 9e 14 00 00       	call   4356e <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   420d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420d4:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   420db:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   420dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420e1:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   420e8:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   420ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420f0:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   420f7:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   420fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420ff:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   42106:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   42108:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4210c:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   42113:	00 02 00 00 
    p->display_status = 1;
   42117:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4211b:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42122:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42125:	83 e0 01             	and    $0x1,%eax
   42128:	85 c0                	test   %eax,%eax
   4212a:	74 1c                	je     42148 <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4212c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42130:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42137:	80 cc 30             	or     $0x30,%ah
   4213a:	48 89 c2             	mov    %rax,%rdx
   4213d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42141:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42148:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4214b:	83 e0 02             	and    $0x2,%eax
   4214e:	85 c0                	test   %eax,%eax
   42150:	74 1c                	je     4216e <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42152:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42156:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4215d:	80 e4 fd             	and    $0xfd,%ah
   42160:	48 89 c2             	mov    %rax,%rdx
   42163:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42167:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   4216e:	90                   	nop
   4216f:	c9                   	leave  
   42170:	c3                   	ret    

0000000000042171 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42171:	f3 0f 1e fa          	endbr64 
   42175:	55                   	push   %rbp
   42176:	48 89 e5             	mov    %rsp,%rbp
   42179:	48 83 ec 28          	sub    $0x28,%rsp
   4217d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42180:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42184:	78 09                	js     4218f <console_show_cursor+0x1e>
   42186:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4218d:	7e 07                	jle    42196 <console_show_cursor+0x25>
        cpos = 0;
   4218f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42196:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4219d:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421a1:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   421a5:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   421a8:	ee                   	out    %al,(%dx)
}
   421a9:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   421aa:	8b 45 dc             	mov    -0x24(%rbp),%eax
   421ad:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   421b3:	85 c0                	test   %eax,%eax
   421b5:	0f 48 c2             	cmovs  %edx,%eax
   421b8:	c1 f8 08             	sar    $0x8,%eax
   421bb:	0f b6 c0             	movzbl %al,%eax
   421be:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   421c5:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421c8:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   421cc:	8b 55 ec             	mov    -0x14(%rbp),%edx
   421cf:	ee                   	out    %al,(%dx)
}
   421d0:	90                   	nop
   421d1:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   421d8:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421dc:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   421e0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   421e3:	ee                   	out    %al,(%dx)
}
   421e4:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   421e5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   421e8:	99                   	cltd   
   421e9:	c1 ea 18             	shr    $0x18,%edx
   421ec:	01 d0                	add    %edx,%eax
   421ee:	0f b6 c0             	movzbl %al,%eax
   421f1:	29 d0                	sub    %edx,%eax
   421f3:	0f b6 c0             	movzbl %al,%eax
   421f6:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   421fd:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42200:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42204:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42207:	ee                   	out    %al,(%dx)
}
   42208:	90                   	nop
}
   42209:	90                   	nop
   4220a:	c9                   	leave  
   4220b:	c3                   	ret    

000000000004220c <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   4220c:	f3 0f 1e fa          	endbr64 
   42210:	55                   	push   %rbp
   42211:	48 89 e5             	mov    %rsp,%rbp
   42214:	48 83 ec 20          	sub    $0x20,%rsp
   42218:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4221f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42222:	89 c2                	mov    %eax,%edx
   42224:	ec                   	in     (%dx),%al
   42225:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42228:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   4222c:	0f b6 c0             	movzbl %al,%eax
   4222f:	83 e0 01             	and    $0x1,%eax
   42232:	85 c0                	test   %eax,%eax
   42234:	75 0a                	jne    42240 <keyboard_readc+0x34>
        return -1;
   42236:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4223b:	e9 fd 01 00 00       	jmp    4243d <keyboard_readc+0x231>
   42240:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42247:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4224a:	89 c2                	mov    %eax,%edx
   4224c:	ec                   	in     (%dx),%al
   4224d:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42250:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42254:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42257:	0f b6 05 a4 20 01 00 	movzbl 0x120a4(%rip),%eax        # 54302 <last_escape.2>
   4225e:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42261:	c6 05 9a 20 01 00 00 	movb   $0x0,0x1209a(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42268:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4226c:	75 11                	jne    4227f <keyboard_readc+0x73>
        last_escape = 0x80;
   4226e:	c6 05 8d 20 01 00 80 	movb   $0x80,0x1208d(%rip)        # 54302 <last_escape.2>
        return 0;
   42275:	b8 00 00 00 00       	mov    $0x0,%eax
   4227a:	e9 be 01 00 00       	jmp    4243d <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4227f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42283:	84 c0                	test   %al,%al
   42285:	79 64                	jns    422eb <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   42287:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4228b:	83 e0 7f             	and    $0x7f,%eax
   4228e:	89 c2                	mov    %eax,%edx
   42290:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42294:	09 d0                	or     %edx,%eax
   42296:	48 98                	cltq   
   42298:	48 8d 15 61 26 00 00 	lea    0x2661(%rip),%rdx        # 44900 <keymap>
   4229f:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   422a3:	0f b6 c0             	movzbl %al,%eax
   422a6:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   422a9:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   422b0:	7e 2f                	jle    422e1 <keyboard_readc+0xd5>
   422b2:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   422b9:	7f 26                	jg     422e1 <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   422bb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422be:	2d fa 00 00 00       	sub    $0xfa,%eax
   422c3:	ba 01 00 00 00       	mov    $0x1,%edx
   422c8:	89 c1                	mov    %eax,%ecx
   422ca:	d3 e2                	shl    %cl,%edx
   422cc:	89 d0                	mov    %edx,%eax
   422ce:	f7 d0                	not    %eax
   422d0:	89 c2                	mov    %eax,%edx
   422d2:	0f b6 05 2a 20 01 00 	movzbl 0x1202a(%rip),%eax        # 54303 <modifiers.1>
   422d9:	21 d0                	and    %edx,%eax
   422db:	88 05 22 20 01 00    	mov    %al,0x12022(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   422e1:	b8 00 00 00 00       	mov    $0x0,%eax
   422e6:	e9 52 01 00 00       	jmp    4243d <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   422eb:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   422ef:	0a 45 fa             	or     -0x6(%rbp),%al
   422f2:	0f b6 c0             	movzbl %al,%eax
   422f5:	48 98                	cltq   
   422f7:	48 8d 15 02 26 00 00 	lea    0x2602(%rip),%rdx        # 44900 <keymap>
   422fe:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42302:	0f b6 c0             	movzbl %al,%eax
   42305:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42308:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4230c:	7e 57                	jle    42365 <keyboard_readc+0x159>
   4230e:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42312:	7f 51                	jg     42365 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   42314:	0f b6 05 e8 1f 01 00 	movzbl 0x11fe8(%rip),%eax        # 54303 <modifiers.1>
   4231b:	0f b6 c0             	movzbl %al,%eax
   4231e:	83 e0 02             	and    $0x2,%eax
   42321:	85 c0                	test   %eax,%eax
   42323:	74 09                	je     4232e <keyboard_readc+0x122>
            ch -= 0x60;
   42325:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42329:	e9 0b 01 00 00       	jmp    42439 <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4232e:	0f b6 05 ce 1f 01 00 	movzbl 0x11fce(%rip),%eax        # 54303 <modifiers.1>
   42335:	0f b6 c0             	movzbl %al,%eax
   42338:	83 e0 01             	and    $0x1,%eax
   4233b:	85 c0                	test   %eax,%eax
   4233d:	0f 94 c2             	sete   %dl
   42340:	0f b6 05 bc 1f 01 00 	movzbl 0x11fbc(%rip),%eax        # 54303 <modifiers.1>
   42347:	0f b6 c0             	movzbl %al,%eax
   4234a:	83 e0 08             	and    $0x8,%eax
   4234d:	85 c0                	test   %eax,%eax
   4234f:	0f 94 c0             	sete   %al
   42352:	31 d0                	xor    %edx,%eax
   42354:	84 c0                	test   %al,%al
   42356:	0f 84 dd 00 00 00    	je     42439 <keyboard_readc+0x22d>
            ch -= 0x20;
   4235c:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42360:	e9 d4 00 00 00       	jmp    42439 <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42365:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4236c:	7e 30                	jle    4239e <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4236e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42371:	2d fa 00 00 00       	sub    $0xfa,%eax
   42376:	ba 01 00 00 00       	mov    $0x1,%edx
   4237b:	89 c1                	mov    %eax,%ecx
   4237d:	d3 e2                	shl    %cl,%edx
   4237f:	89 d0                	mov    %edx,%eax
   42381:	89 c2                	mov    %eax,%edx
   42383:	0f b6 05 79 1f 01 00 	movzbl 0x11f79(%rip),%eax        # 54303 <modifiers.1>
   4238a:	31 d0                	xor    %edx,%eax
   4238c:	88 05 71 1f 01 00    	mov    %al,0x11f71(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42392:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42399:	e9 9c 00 00 00       	jmp    4243a <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   4239e:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   423a5:	7e 2d                	jle    423d4 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   423a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423aa:	2d fa 00 00 00       	sub    $0xfa,%eax
   423af:	ba 01 00 00 00       	mov    $0x1,%edx
   423b4:	89 c1                	mov    %eax,%ecx
   423b6:	d3 e2                	shl    %cl,%edx
   423b8:	89 d0                	mov    %edx,%eax
   423ba:	89 c2                	mov    %eax,%edx
   423bc:	0f b6 05 40 1f 01 00 	movzbl 0x11f40(%rip),%eax        # 54303 <modifiers.1>
   423c3:	09 d0                	or     %edx,%eax
   423c5:	88 05 38 1f 01 00    	mov    %al,0x11f38(%rip)        # 54303 <modifiers.1>
        ch = 0;
   423cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   423d2:	eb 66                	jmp    4243a <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   423d4:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   423d8:	7e 3f                	jle    42419 <keyboard_readc+0x20d>
   423da:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   423e1:	7f 36                	jg     42419 <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   423e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423e6:	8d 50 80             	lea    -0x80(%rax),%edx
   423e9:	0f b6 05 13 1f 01 00 	movzbl 0x11f13(%rip),%eax        # 54303 <modifiers.1>
   423f0:	0f b6 c0             	movzbl %al,%eax
   423f3:	83 e0 03             	and    $0x3,%eax
   423f6:	48 63 c8             	movslq %eax,%rcx
   423f9:	48 63 c2             	movslq %edx,%rax
   423fc:	48 c1 e0 02          	shl    $0x2,%rax
   42400:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   42404:	48 8d 05 f5 25 00 00 	lea    0x25f5(%rip),%rax        # 44a00 <complex_keymap>
   4240b:	48 01 d0             	add    %rdx,%rax
   4240e:	0f b6 00             	movzbl (%rax),%eax
   42411:	0f b6 c0             	movzbl %al,%eax
   42414:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42417:	eb 21                	jmp    4243a <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42419:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4241d:	7f 1b                	jg     4243a <keyboard_readc+0x22e>
   4241f:	0f b6 05 dd 1e 01 00 	movzbl 0x11edd(%rip),%eax        # 54303 <modifiers.1>
   42426:	0f b6 c0             	movzbl %al,%eax
   42429:	83 e0 02             	and    $0x2,%eax
   4242c:	85 c0                	test   %eax,%eax
   4242e:	74 0a                	je     4243a <keyboard_readc+0x22e>
        ch = 0;
   42430:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42437:	eb 01                	jmp    4243a <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   42439:	90                   	nop
    }

    return ch;
   4243a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4243d:	c9                   	leave  
   4243e:	c3                   	ret    

000000000004243f <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   4243f:	f3 0f 1e fa          	endbr64 
   42443:	55                   	push   %rbp
   42444:	48 89 e5             	mov    %rsp,%rbp
   42447:	48 83 ec 20          	sub    $0x20,%rsp
   4244b:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42452:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42455:	89 c2                	mov    %eax,%edx
   42457:	ec                   	in     (%dx),%al
   42458:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4245b:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42462:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42465:	89 c2                	mov    %eax,%edx
   42467:	ec                   	in     (%dx),%al
   42468:	88 45 eb             	mov    %al,-0x15(%rbp)
   4246b:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42472:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42475:	89 c2                	mov    %eax,%edx
   42477:	ec                   	in     (%dx),%al
   42478:	88 45 f3             	mov    %al,-0xd(%rbp)
   4247b:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42482:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42485:	89 c2                	mov    %eax,%edx
   42487:	ec                   	in     (%dx),%al
   42488:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4248b:	90                   	nop
   4248c:	c9                   	leave  
   4248d:	c3                   	ret    

000000000004248e <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4248e:	f3 0f 1e fa          	endbr64 
   42492:	55                   	push   %rbp
   42493:	48 89 e5             	mov    %rsp,%rbp
   42496:	48 83 ec 40          	sub    $0x40,%rsp
   4249a:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4249e:	89 f0                	mov    %esi,%eax
   424a0:	89 55 c0             	mov    %edx,-0x40(%rbp)
   424a3:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   424a6:	8b 05 58 1e 01 00    	mov    0x11e58(%rip),%eax        # 54304 <initialized.0>
   424ac:	85 c0                	test   %eax,%eax
   424ae:	75 1e                	jne    424ce <parallel_port_putc+0x40>
   424b0:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   424b7:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424bb:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   424bf:	8b 55 f8             	mov    -0x8(%rbp),%edx
   424c2:	ee                   	out    %al,(%dx)
}
   424c3:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   424c4:	c7 05 36 1e 01 00 01 	movl   $0x1,0x11e36(%rip)        # 54304 <initialized.0>
   424cb:	00 00 00 
    }

    for (int i = 0;
   424ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   424d5:	eb 09                	jmp    424e0 <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   424d7:	e8 63 ff ff ff       	call   4243f <delay>
         ++i) {
   424dc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   424e0:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   424e7:	7f 18                	jg     42501 <parallel_port_putc+0x73>
   424e9:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   424f0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424f3:	89 c2                	mov    %eax,%edx
   424f5:	ec                   	in     (%dx),%al
   424f6:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   424f9:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   424fd:	84 c0                	test   %al,%al
   424ff:	79 d6                	jns    424d7 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   42501:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42505:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4250c:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4250f:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42513:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42516:	ee                   	out    %al,(%dx)
}
   42517:	90                   	nop
   42518:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   4251f:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42523:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42527:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4252a:	ee                   	out    %al,(%dx)
}
   4252b:	90                   	nop
   4252c:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42533:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42537:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4253b:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4253e:	ee                   	out    %al,(%dx)
}
   4253f:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42540:	90                   	nop
   42541:	c9                   	leave  
   42542:	c3                   	ret    

0000000000042543 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42543:	f3 0f 1e fa          	endbr64 
   42547:	55                   	push   %rbp
   42548:	48 89 e5             	mov    %rsp,%rbp
   4254b:	48 83 ec 20          	sub    $0x20,%rsp
   4254f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42553:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42557:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 4248e <parallel_port_putc>
   4255e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   42562:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42566:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4256a:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4256e:	be 00 00 00 00       	mov    $0x0,%esi
   42573:	48 89 c7             	mov    %rax,%rdi
   42576:	e8 b9 12 00 00       	call   43834 <printer_vprintf>
}
   4257b:	90                   	nop
   4257c:	c9                   	leave  
   4257d:	c3                   	ret    

000000000004257e <log_printf>:

void log_printf(const char* format, ...) {
   4257e:	f3 0f 1e fa          	endbr64 
   42582:	55                   	push   %rbp
   42583:	48 89 e5             	mov    %rsp,%rbp
   42586:	48 83 ec 60          	sub    $0x60,%rsp
   4258a:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4258e:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42592:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42596:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4259a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4259e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   425a2:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   425a9:	48 8d 45 10          	lea    0x10(%rbp),%rax
   425ad:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   425b1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   425b5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   425b9:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   425bd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   425c1:	48 89 d6             	mov    %rdx,%rsi
   425c4:	48 89 c7             	mov    %rax,%rdi
   425c7:	e8 77 ff ff ff       	call   42543 <log_vprintf>
    va_end(val);
}
   425cc:	90                   	nop
   425cd:	c9                   	leave  
   425ce:	c3                   	ret    

00000000000425cf <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   425cf:	f3 0f 1e fa          	endbr64 
   425d3:	55                   	push   %rbp
   425d4:	48 89 e5             	mov    %rsp,%rbp
   425d7:	48 83 ec 40          	sub    $0x40,%rsp
   425db:	89 7d dc             	mov    %edi,-0x24(%rbp)
   425de:	89 75 d8             	mov    %esi,-0x28(%rbp)
   425e1:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   425e5:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   425e9:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   425ed:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   425f1:	48 8b 0a             	mov    (%rdx),%rcx
   425f4:	48 89 08             	mov    %rcx,(%rax)
   425f7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   425fb:	48 89 48 08          	mov    %rcx,0x8(%rax)
   425ff:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42603:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42607:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4260b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4260f:	48 89 d6             	mov    %rdx,%rsi
   42612:	48 89 c7             	mov    %rax,%rdi
   42615:	e8 29 ff ff ff       	call   42543 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4261a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4261e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42622:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42625:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42628:	89 c7                	mov    %eax,%edi
   4262a:	e8 02 1d 00 00       	call   44331 <console_vprintf>
}
   4262f:	c9                   	leave  
   42630:	c3                   	ret    

0000000000042631 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42631:	f3 0f 1e fa          	endbr64 
   42635:	55                   	push   %rbp
   42636:	48 89 e5             	mov    %rsp,%rbp
   42639:	48 83 ec 60          	sub    $0x60,%rsp
   4263d:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42640:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42643:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42647:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4264b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4264f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42653:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4265a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4265e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42662:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42666:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   4266a:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4266e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42672:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42675:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42678:	89 c7                	mov    %eax,%edi
   4267a:	e8 50 ff ff ff       	call   425cf <error_vprintf>
   4267f:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42682:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42685:	c9                   	leave  
   42686:	c3                   	ret    

0000000000042687 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42687:	f3 0f 1e fa          	endbr64 
   4268b:	55                   	push   %rbp
   4268c:	48 89 e5             	mov    %rsp,%rbp
   4268f:	53                   	push   %rbx
   42690:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42694:	e8 73 fb ff ff       	call   4220c <keyboard_readc>
   42699:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   4269c:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   426a0:	74 1c                	je     426be <check_keyboard+0x37>
   426a2:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   426a6:	74 16                	je     426be <check_keyboard+0x37>
   426a8:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   426ac:	74 10                	je     426be <check_keyboard+0x37>
   426ae:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   426b2:	74 0a                	je     426be <check_keyboard+0x37>
   426b4:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   426b8:	0f 85 02 01 00 00    	jne    427c0 <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   426be:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   426c5:	00 
        memset(pt, 0, PAGESIZE * 3);
   426c6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426ca:	ba 00 30 00 00       	mov    $0x3000,%edx
   426cf:	be 00 00 00 00       	mov    $0x0,%esi
   426d4:	48 89 c7             	mov    %rax,%rdi
   426d7:	e8 92 0e 00 00       	call   4356e <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   426dc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426e0:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   426e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426eb:	48 05 00 10 00 00    	add    $0x1000,%rax
   426f1:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   426f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426fc:	48 05 00 20 00 00    	add    $0x2000,%rax
   42702:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42709:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4270d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42711:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42715:	0f 22 d8             	mov    %rax,%cr3
}
   42718:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42719:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42720:	48 8d 05 31 23 00 00 	lea    0x2331(%rip),%rax        # 44a58 <complex_keymap+0x58>
   42727:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   4272b:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4272f:	75 0d                	jne    4273e <check_keyboard+0xb7>
            argument = "allocator";
   42731:	48 8d 05 25 23 00 00 	lea    0x2325(%rip),%rax        # 44a5d <complex_keymap+0x5d>
   42738:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4273c:	eb 37                	jmp    42775 <check_keyboard+0xee>
        } else if (c == 'e') {
   4273e:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42742:	75 0d                	jne    42751 <check_keyboard+0xca>
            argument = "forkexit";
   42744:	48 8d 05 1c 23 00 00 	lea    0x231c(%rip),%rax        # 44a67 <complex_keymap+0x67>
   4274b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4274f:	eb 24                	jmp    42775 <check_keyboard+0xee>
        }
        else if (c == 't'){
   42751:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42755:	75 0d                	jne    42764 <check_keyboard+0xdd>
            argument = "test";
   42757:	48 8d 05 12 23 00 00 	lea    0x2312(%rip),%rax        # 44a70 <complex_keymap+0x70>
   4275e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42762:	eb 11                	jmp    42775 <check_keyboard+0xee>
        }
        else if(c == '2'){
   42764:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42768:	75 0b                	jne    42775 <check_keyboard+0xee>
            argument = "test2";
   4276a:	48 8d 05 04 23 00 00 	lea    0x2304(%rip),%rax        # 44a75 <complex_keymap+0x75>
   42771:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42775:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42779:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   4277d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42782:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42786:	76 1e                	jbe    427a6 <check_keyboard+0x11f>
   42788:	48 8d 05 ec 22 00 00 	lea    0x22ec(%rip),%rax        # 44a7b <complex_keymap+0x7b>
   4278f:	48 89 c2             	mov    %rax,%rdx
   42792:	be 5d 02 00 00       	mov    $0x25d,%esi
   42797:	48 8d 05 f9 22 00 00 	lea    0x22f9(%rip),%rax        # 44a97 <complex_keymap+0x97>
   4279e:	48 89 c7             	mov    %rax,%rdi
   427a1:	e8 33 01 00 00       	call   428d9 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   427a6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   427aa:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   427ad:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   427b1:	48 89 c3             	mov    %rax,%rbx
   427b4:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   427b9:	e9 42 d8 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   427be:	eb 11                	jmp    427d1 <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   427c0:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   427c4:	74 06                	je     427cc <check_keyboard+0x145>
   427c6:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   427ca:	75 05                	jne    427d1 <check_keyboard+0x14a>
        poweroff();
   427cc:	e8 3c f8 ff ff       	call   4200d <poweroff>
    }
    return c;
   427d1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   427d4:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   427d8:	c9                   	leave  
   427d9:	c3                   	ret    

00000000000427da <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   427da:	f3 0f 1e fa          	endbr64 
   427de:	55                   	push   %rbp
   427df:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   427e2:	e8 a0 fe ff ff       	call   42687 <check_keyboard>
   427e7:	eb f9                	jmp    427e2 <fail+0x8>

00000000000427e9 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   427e9:	f3 0f 1e fa          	endbr64 
   427ed:	55                   	push   %rbp
   427ee:	48 89 e5             	mov    %rsp,%rbp
   427f1:	48 83 ec 60          	sub    $0x60,%rsp
   427f5:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   427f9:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   427fd:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42801:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42805:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42809:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4280d:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42814:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42818:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   4281c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42820:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42824:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42829:	0f 84 87 00 00 00    	je     428b6 <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   4282f:	48 8d 05 75 22 00 00 	lea    0x2275(%rip),%rax        # 44aab <complex_keymap+0xab>
   42836:	48 89 c2             	mov    %rax,%rdx
   42839:	be 00 c0 00 00       	mov    $0xc000,%esi
   4283e:	bf 30 07 00 00       	mov    $0x730,%edi
   42843:	b8 00 00 00 00       	mov    $0x0,%eax
   42848:	e8 e4 fd ff ff       	call   42631 <error_printf>
   4284d:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42850:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42854:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42858:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4285b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42860:	89 c7                	mov    %eax,%edi
   42862:	e8 68 fd ff ff       	call   425cf <error_vprintf>
   42867:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4286a:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   4286d:	48 63 c1             	movslq %ecx,%rax
   42870:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42877:	48 c1 e8 20          	shr    $0x20,%rax
   4287b:	c1 f8 05             	sar    $0x5,%eax
   4287e:	89 ce                	mov    %ecx,%esi
   42880:	c1 fe 1f             	sar    $0x1f,%esi
   42883:	29 f0                	sub    %esi,%eax
   42885:	89 c2                	mov    %eax,%edx
   42887:	89 d0                	mov    %edx,%eax
   42889:	c1 e0 02             	shl    $0x2,%eax
   4288c:	01 d0                	add    %edx,%eax
   4288e:	c1 e0 04             	shl    $0x4,%eax
   42891:	29 c1                	sub    %eax,%ecx
   42893:	89 ca                	mov    %ecx,%edx
   42895:	85 d2                	test   %edx,%edx
   42897:	74 3b                	je     428d4 <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   42899:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4289c:	48 8d 15 10 22 00 00 	lea    0x2210(%rip),%rdx        # 44ab3 <complex_keymap+0xb3>
   428a3:	be 00 c0 00 00       	mov    $0xc000,%esi
   428a8:	89 c7                	mov    %eax,%edi
   428aa:	b8 00 00 00 00       	mov    $0x0,%eax
   428af:	e8 7d fd ff ff       	call   42631 <error_printf>
   428b4:	eb 1e                	jmp    428d4 <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   428b6:	48 8d 05 f8 21 00 00 	lea    0x21f8(%rip),%rax        # 44ab5 <complex_keymap+0xb5>
   428bd:	48 89 c2             	mov    %rax,%rdx
   428c0:	be 00 c0 00 00       	mov    $0xc000,%esi
   428c5:	bf 30 07 00 00       	mov    $0x730,%edi
   428ca:	b8 00 00 00 00       	mov    $0x0,%eax
   428cf:	e8 5d fd ff ff       	call   42631 <error_printf>
    }

    va_end(val);
    fail();
   428d4:	e8 01 ff ff ff       	call   427da <fail>

00000000000428d9 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   428d9:	f3 0f 1e fa          	endbr64 
   428dd:	55                   	push   %rbp
   428de:	48 89 e5             	mov    %rsp,%rbp
   428e1:	48 83 ec 20          	sub    $0x20,%rsp
   428e5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   428e9:	89 75 f4             	mov    %esi,-0xc(%rbp)
   428ec:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   428f0:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   428f4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   428f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   428fb:	48 89 c6             	mov    %rax,%rsi
   428fe:	48 8d 05 b6 21 00 00 	lea    0x21b6(%rip),%rax        # 44abb <complex_keymap+0xbb>
   42905:	48 89 c7             	mov    %rax,%rdi
   42908:	b8 00 00 00 00       	mov    $0x0,%eax
   4290d:	e8 d7 fe ff ff       	call   427e9 <panic>

0000000000042912 <default_exception>:
}

void default_exception(proc* p){
   42912:	f3 0f 1e fa          	endbr64 
   42916:	55                   	push   %rbp
   42917:	48 89 e5             	mov    %rsp,%rbp
   4291a:	48 83 ec 20          	sub    $0x20,%rsp
   4291e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42922:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42926:	48 83 c0 08          	add    $0x8,%rax
   4292a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   4292e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42932:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42939:	48 89 c6             	mov    %rax,%rsi
   4293c:	48 8d 05 96 21 00 00 	lea    0x2196(%rip),%rax        # 44ad9 <complex_keymap+0xd9>
   42943:	48 89 c7             	mov    %rax,%rdi
   42946:	b8 00 00 00 00       	mov    $0x0,%eax
   4294b:	e8 99 fe ff ff       	call   427e9 <panic>

0000000000042950 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42950:	55                   	push   %rbp
   42951:	48 89 e5             	mov    %rsp,%rbp
   42954:	48 83 ec 10          	sub    $0x10,%rsp
   42958:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4295c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   4295f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42963:	78 06                	js     4296b <pageindex+0x1b>
   42965:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42969:	7e 1e                	jle    42989 <pageindex+0x39>
   4296b:	48 8d 05 86 21 00 00 	lea    0x2186(%rip),%rax        # 44af8 <complex_keymap+0xf8>
   42972:	48 89 c2             	mov    %rax,%rdx
   42975:	be 1e 00 00 00       	mov    $0x1e,%esi
   4297a:	48 8d 05 90 21 00 00 	lea    0x2190(%rip),%rax        # 44b11 <complex_keymap+0x111>
   42981:	48 89 c7             	mov    %rax,%rdi
   42984:	e8 50 ff ff ff       	call   428d9 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42989:	b8 03 00 00 00       	mov    $0x3,%eax
   4298e:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42991:	89 c2                	mov    %eax,%edx
   42993:	89 d0                	mov    %edx,%eax
   42995:	c1 e0 03             	shl    $0x3,%eax
   42998:	01 d0                	add    %edx,%eax
   4299a:	83 c0 0c             	add    $0xc,%eax
   4299d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   429a1:	89 c1                	mov    %eax,%ecx
   429a3:	48 d3 ea             	shr    %cl,%rdx
   429a6:	48 89 d0             	mov    %rdx,%rax
   429a9:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   429ae:	c9                   	leave  
   429af:	c3                   	ret    

00000000000429b0 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   429b0:	f3 0f 1e fa          	endbr64 
   429b4:	55                   	push   %rbp
   429b5:	48 89 e5             	mov    %rsp,%rbp
   429b8:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   429bc:	48 8d 05 3d 36 01 00 	lea    0x1363d(%rip),%rax        # 56000 <kernel_pagetables>
   429c3:	48 89 05 36 26 01 00 	mov    %rax,0x12636(%rip)        # 55000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   429ca:	ba 00 50 00 00       	mov    $0x5000,%edx
   429cf:	be 00 00 00 00       	mov    $0x0,%esi
   429d4:	48 8d 05 25 36 01 00 	lea    0x13625(%rip),%rax        # 56000 <kernel_pagetables>
   429db:	48 89 c7             	mov    %rax,%rdi
   429de:	e8 8b 0b 00 00       	call   4356e <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   429e3:	48 8d 05 16 46 01 00 	lea    0x14616(%rip),%rax        # 57000 <kernel_pagetables+0x1000>
   429ea:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   429ee:	48 89 05 0b 36 01 00 	mov    %rax,0x1360b(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   429f5:	48 8d 05 04 56 01 00 	lea    0x15604(%rip),%rax        # 58000 <kernel_pagetables+0x2000>
   429fc:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42a00:	48 89 05 f9 45 01 00 	mov    %rax,0x145f9(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42a07:	48 8d 05 f2 65 01 00 	lea    0x165f2(%rip),%rax        # 59000 <kernel_pagetables+0x3000>
   42a0e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42a12:	48 89 05 e7 55 01 00 	mov    %rax,0x155e7(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42a19:	48 8d 05 e0 75 01 00 	lea    0x175e0(%rip),%rax        # 5a000 <kernel_pagetables+0x4000>
   42a20:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42a24:	48 89 05 dd 55 01 00 	mov    %rax,0x155dd(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42a2b:	48 8b 05 ce 25 01 00 	mov    0x125ce(%rip),%rax        # 55000 <kernel_pagetable>
   42a32:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42a38:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42a3d:	ba 00 00 00 00       	mov    $0x0,%edx
   42a42:	be 00 00 00 00       	mov    $0x0,%esi
   42a47:	48 89 c7             	mov    %rax,%rdi
   42a4a:	e8 0e 02 00 00       	call   42c5d <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42a4f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42a56:	00 
   42a57:	eb 76                	jmp    42acf <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42a59:	48 8b 0d a0 25 01 00 	mov    0x125a0(%rip),%rcx        # 55000 <kernel_pagetable>
   42a60:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42a64:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42a68:	48 89 ce             	mov    %rcx,%rsi
   42a6b:	48 89 c7             	mov    %rax,%rdi
   42a6e:	e8 34 06 00 00       	call   430a7 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42a73:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a77:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42a7b:	74 1e                	je     42a9b <virtual_memory_init+0xeb>
   42a7d:	48 8d 05 a1 20 00 00 	lea    0x20a1(%rip),%rax        # 44b25 <complex_keymap+0x125>
   42a84:	48 89 c2             	mov    %rax,%rdx
   42a87:	be 2d 00 00 00       	mov    $0x2d,%esi
   42a8c:	48 8d 05 a2 20 00 00 	lea    0x20a2(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42a93:	48 89 c7             	mov    %rax,%rdi
   42a96:	e8 3e fe ff ff       	call   428d9 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42a9b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42a9e:	48 98                	cltq   
   42aa0:	83 e0 03             	and    $0x3,%eax
   42aa3:	48 83 f8 03          	cmp    $0x3,%rax
   42aa7:	74 1e                	je     42ac7 <virtual_memory_init+0x117>
   42aa9:	48 8d 05 98 20 00 00 	lea    0x2098(%rip),%rax        # 44b48 <complex_keymap+0x148>
   42ab0:	48 89 c2             	mov    %rax,%rdx
   42ab3:	be 2e 00 00 00       	mov    $0x2e,%esi
   42ab8:	48 8d 05 76 20 00 00 	lea    0x2076(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42abf:	48 89 c7             	mov    %rax,%rdi
   42ac2:	e8 12 fe ff ff       	call   428d9 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42ac7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42ace:	00 
   42acf:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42ad6:	00 
   42ad7:	76 80                	jbe    42a59 <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42ad9:	48 8b 05 20 25 01 00 	mov    0x12520(%rip),%rax        # 55000 <kernel_pagetable>
   42ae0:	48 89 c7             	mov    %rax,%rdi
   42ae3:	e8 03 00 00 00       	call   42aeb <set_pagetable>
}
   42ae8:	90                   	nop
   42ae9:	c9                   	leave  
   42aea:	c3                   	ret    

0000000000042aeb <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42aeb:	f3 0f 1e fa          	endbr64 
   42aef:	55                   	push   %rbp
   42af0:	48 89 e5             	mov    %rsp,%rbp
   42af3:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42af7:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42afb:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42aff:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b04:	48 85 c0             	test   %rax,%rax
   42b07:	74 1e                	je     42b27 <set_pagetable+0x3c>
   42b09:	48 8d 05 65 20 00 00 	lea    0x2065(%rip),%rax        # 44b75 <complex_keymap+0x175>
   42b10:	48 89 c2             	mov    %rax,%rdx
   42b13:	be 3d 00 00 00       	mov    $0x3d,%esi
   42b18:	48 8d 05 16 20 00 00 	lea    0x2016(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42b1f:	48 89 c7             	mov    %rax,%rdi
   42b22:	e8 b2 fd ff ff       	call   428d9 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42b27:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   42b2e:	48 89 c2             	mov    %rax,%rdx
   42b31:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42b35:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42b39:	48 89 ce             	mov    %rcx,%rsi
   42b3c:	48 89 c7             	mov    %rax,%rdi
   42b3f:	e8 63 05 00 00       	call   430a7 <virtual_memory_lookup>
   42b44:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42b48:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   42b4f:	48 39 d0             	cmp    %rdx,%rax
   42b52:	74 1e                	je     42b72 <set_pagetable+0x87>
   42b54:	48 8d 05 35 20 00 00 	lea    0x2035(%rip),%rax        # 44b90 <complex_keymap+0x190>
   42b5b:	48 89 c2             	mov    %rax,%rdx
   42b5e:	be 3f 00 00 00       	mov    $0x3f,%esi
   42b63:	48 8d 05 cb 1f 00 00 	lea    0x1fcb(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42b6a:	48 89 c7             	mov    %rax,%rdi
   42b6d:	e8 67 fd ff ff       	call   428d9 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42b72:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42b76:	48 8b 0d 83 24 01 00 	mov    0x12483(%rip),%rcx        # 55000 <kernel_pagetable>
   42b7d:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42b81:	48 89 ce             	mov    %rcx,%rsi
   42b84:	48 89 c7             	mov    %rax,%rdi
   42b87:	e8 1b 05 00 00       	call   430a7 <virtual_memory_lookup>
   42b8c:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42b90:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42b94:	48 39 c2             	cmp    %rax,%rdx
   42b97:	74 1e                	je     42bb7 <set_pagetable+0xcc>
   42b99:	48 8d 05 58 20 00 00 	lea    0x2058(%rip),%rax        # 44bf8 <complex_keymap+0x1f8>
   42ba0:	48 89 c2             	mov    %rax,%rdx
   42ba3:	be 41 00 00 00       	mov    $0x41,%esi
   42ba8:	48 8d 05 86 1f 00 00 	lea    0x1f86(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42baf:	48 89 c7             	mov    %rax,%rdi
   42bb2:	e8 22 fd ff ff       	call   428d9 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42bb7:	48 8b 05 42 24 01 00 	mov    0x12442(%rip),%rax        # 55000 <kernel_pagetable>
   42bbe:	48 89 c2             	mov    %rax,%rdx
   42bc1:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42bc5:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42bc9:	48 89 ce             	mov    %rcx,%rsi
   42bcc:	48 89 c7             	mov    %rax,%rdi
   42bcf:	e8 d3 04 00 00       	call   430a7 <virtual_memory_lookup>
   42bd4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42bd8:	48 8b 15 21 24 01 00 	mov    0x12421(%rip),%rdx        # 55000 <kernel_pagetable>
   42bdf:	48 39 d0             	cmp    %rdx,%rax
   42be2:	74 1e                	je     42c02 <set_pagetable+0x117>
   42be4:	48 8d 05 6d 20 00 00 	lea    0x206d(%rip),%rax        # 44c58 <complex_keymap+0x258>
   42beb:	48 89 c2             	mov    %rax,%rdx
   42bee:	be 43 00 00 00       	mov    $0x43,%esi
   42bf3:	48 8d 05 3b 1f 00 00 	lea    0x1f3b(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42bfa:	48 89 c7             	mov    %rax,%rdi
   42bfd:	e8 d7 fc ff ff       	call   428d9 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42c02:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 42c5d <virtual_memory_map>
   42c09:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42c0d:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42c11:	48 89 ce             	mov    %rcx,%rsi
   42c14:	48 89 c7             	mov    %rax,%rdi
   42c17:	e8 8b 04 00 00       	call   430a7 <virtual_memory_lookup>
   42c1c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c20:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 42c5d <virtual_memory_map>
   42c27:	48 39 d0             	cmp    %rdx,%rax
   42c2a:	74 1e                	je     42c4a <set_pagetable+0x15f>
   42c2c:	48 8d 05 8d 20 00 00 	lea    0x208d(%rip),%rax        # 44cc0 <complex_keymap+0x2c0>
   42c33:	48 89 c2             	mov    %rax,%rdx
   42c36:	be 45 00 00 00       	mov    $0x45,%esi
   42c3b:	48 8d 05 f3 1e 00 00 	lea    0x1ef3(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42c42:	48 89 c7             	mov    %rax,%rdi
   42c45:	e8 8f fc ff ff       	call   428d9 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42c4a:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42c4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42c52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c56:	0f 22 d8             	mov    %rax,%cr3
}
   42c59:	90                   	nop
}
   42c5a:	90                   	nop
   42c5b:	c9                   	leave  
   42c5c:	c3                   	ret    

0000000000042c5d <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42c5d:	f3 0f 1e fa          	endbr64 
   42c61:	55                   	push   %rbp
   42c62:	48 89 e5             	mov    %rsp,%rbp
   42c65:	48 83 ec 50          	sub    $0x50,%rsp
   42c69:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42c6d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42c71:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42c75:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   42c79:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42c7d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c81:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c86:	48 85 c0             	test   %rax,%rax
   42c89:	74 1e                	je     42ca9 <virtual_memory_map+0x4c>
   42c8b:	48 8d 05 94 20 00 00 	lea    0x2094(%rip),%rax        # 44d26 <complex_keymap+0x326>
   42c92:	48 89 c2             	mov    %rax,%rdx
   42c95:	be 66 00 00 00       	mov    $0x66,%esi
   42c9a:	48 8d 05 94 1e 00 00 	lea    0x1e94(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42ca1:	48 89 c7             	mov    %rax,%rdi
   42ca4:	e8 30 fc ff ff       	call   428d9 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42ca9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42cad:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cb2:	48 85 c0             	test   %rax,%rax
   42cb5:	74 1e                	je     42cd5 <virtual_memory_map+0x78>
   42cb7:	48 8d 05 7b 20 00 00 	lea    0x207b(%rip),%rax        # 44d39 <complex_keymap+0x339>
   42cbe:	48 89 c2             	mov    %rax,%rdx
   42cc1:	be 67 00 00 00       	mov    $0x67,%esi
   42cc6:	48 8d 05 68 1e 00 00 	lea    0x1e68(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42ccd:	48 89 c7             	mov    %rax,%rdi
   42cd0:	e8 04 fc ff ff       	call   428d9 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42cd5:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42cd9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42cdd:	48 01 d0             	add    %rdx,%rax
   42ce0:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42ce4:	76 2e                	jbe    42d14 <virtual_memory_map+0xb7>
   42ce6:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42cea:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42cee:	48 01 d0             	add    %rdx,%rax
   42cf1:	48 85 c0             	test   %rax,%rax
   42cf4:	74 1e                	je     42d14 <virtual_memory_map+0xb7>
   42cf6:	48 8d 05 4f 20 00 00 	lea    0x204f(%rip),%rax        # 44d4c <complex_keymap+0x34c>
   42cfd:	48 89 c2             	mov    %rax,%rdx
   42d00:	be 68 00 00 00       	mov    $0x68,%esi
   42d05:	48 8d 05 29 1e 00 00 	lea    0x1e29(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42d0c:	48 89 c7             	mov    %rax,%rdi
   42d0f:	e8 c5 fb ff ff       	call   428d9 <assert_fail>
    if (perm & PTE_P) {
   42d14:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42d17:	48 98                	cltq   
   42d19:	83 e0 01             	and    $0x1,%eax
   42d1c:	48 85 c0             	test   %rax,%rax
   42d1f:	0f 84 8c 00 00 00    	je     42db1 <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42d25:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d29:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d2e:	48 85 c0             	test   %rax,%rax
   42d31:	74 1e                	je     42d51 <virtual_memory_map+0xf4>
   42d33:	48 8d 05 30 20 00 00 	lea    0x2030(%rip),%rax        # 44d6a <complex_keymap+0x36a>
   42d3a:	48 89 c2             	mov    %rax,%rdx
   42d3d:	be 6a 00 00 00       	mov    $0x6a,%esi
   42d42:	48 8d 05 ec 1d 00 00 	lea    0x1dec(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42d49:	48 89 c7             	mov    %rax,%rdi
   42d4c:	e8 88 fb ff ff       	call   428d9 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42d51:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42d55:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42d59:	48 01 d0             	add    %rdx,%rax
   42d5c:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   42d60:	76 1e                	jbe    42d80 <virtual_memory_map+0x123>
   42d62:	48 8d 05 14 20 00 00 	lea    0x2014(%rip),%rax        # 44d7d <complex_keymap+0x37d>
   42d69:	48 89 c2             	mov    %rax,%rdx
   42d6c:	be 6b 00 00 00       	mov    $0x6b,%esi
   42d71:	48 8d 05 bd 1d 00 00 	lea    0x1dbd(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42d78:	48 89 c7             	mov    %rax,%rdi
   42d7b:	e8 59 fb ff ff       	call   428d9 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42d80:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42d84:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42d88:	48 01 d0             	add    %rdx,%rax
   42d8b:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42d91:	76 1e                	jbe    42db1 <virtual_memory_map+0x154>
   42d93:	48 8d 05 f1 1f 00 00 	lea    0x1ff1(%rip),%rax        # 44d8b <complex_keymap+0x38b>
   42d9a:	48 89 c2             	mov    %rax,%rdx
   42d9d:	be 6c 00 00 00       	mov    $0x6c,%esi
   42da2:	48 8d 05 8c 1d 00 00 	lea    0x1d8c(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42da9:	48 89 c7             	mov    %rax,%rdi
   42dac:	e8 28 fb ff ff       	call   428d9 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42db1:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   42db5:	78 09                	js     42dc0 <virtual_memory_map+0x163>
   42db7:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   42dbe:	7e 1e                	jle    42dde <virtual_memory_map+0x181>
   42dc0:	48 8d 05 e0 1f 00 00 	lea    0x1fe0(%rip),%rax        # 44da7 <complex_keymap+0x3a7>
   42dc7:	48 89 c2             	mov    %rax,%rdx
   42dca:	be 6e 00 00 00       	mov    $0x6e,%esi
   42dcf:	48 8d 05 5f 1d 00 00 	lea    0x1d5f(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42dd6:	48 89 c7             	mov    %rax,%rdi
   42dd9:	e8 fb fa ff ff       	call   428d9 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42dde:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42de2:	25 ff 0f 00 00       	and    $0xfff,%eax
   42de7:	48 85 c0             	test   %rax,%rax
   42dea:	74 1e                	je     42e0a <virtual_memory_map+0x1ad>
   42dec:	48 8d 05 d5 1f 00 00 	lea    0x1fd5(%rip),%rax        # 44dc8 <complex_keymap+0x3c8>
   42df3:	48 89 c2             	mov    %rax,%rdx
   42df6:	be 6f 00 00 00       	mov    $0x6f,%esi
   42dfb:	48 8d 05 33 1d 00 00 	lea    0x1d33(%rip),%rax        # 44b35 <complex_keymap+0x135>
   42e02:	48 89 c7             	mov    %rax,%rdi
   42e05:	e8 cf fa ff ff       	call   428d9 <assert_fail>

    int last_index123 = -1;
   42e0a:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42e11:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   42e18:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42e19:	e9 ed 00 00 00       	jmp    42f0b <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42e1e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42e22:	48 c1 e8 15          	shr    $0x15,%rax
   42e26:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   42e29:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42e2c:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   42e2f:	74 20                	je     42e51 <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   42e31:	8b 55 bc             	mov    -0x44(%rbp),%edx
   42e34:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   42e38:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e3c:	48 89 ce             	mov    %rcx,%rsi
   42e3f:	48 89 c7             	mov    %rax,%rdi
   42e42:	e8 d6 00 00 00       	call   42f1d <lookup_l1pagetable>
   42e47:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   42e4b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42e4e:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42e51:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42e54:	48 98                	cltq   
   42e56:	83 e0 01             	and    $0x1,%eax
   42e59:	48 85 c0             	test   %rax,%rax
   42e5c:	74 37                	je     42e95 <virtual_memory_map+0x238>
   42e5e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   42e63:	74 30                	je     42e95 <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   42e65:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42e69:	be 03 00 00 00       	mov    $0x3,%esi
   42e6e:	48 89 c7             	mov    %rax,%rdi
   42e71:	e8 da fa ff ff       	call   42950 <pageindex>
   42e76:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   42e79:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42e7c:	48 98                	cltq   
   42e7e:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   42e82:	48 89 c1             	mov    %rax,%rcx
   42e85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e89:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42e8c:	48 63 d2             	movslq %edx,%rdx
   42e8f:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42e93:	eb 5e                	jmp    42ef3 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   42e95:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   42e9a:	74 2a                	je     42ec6 <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   42e9c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42ea0:	be 03 00 00 00       	mov    $0x3,%esi
   42ea5:	48 89 c7             	mov    %rax,%rdi
   42ea8:	e8 a3 fa ff ff       	call   42950 <pageindex>
   42ead:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   42eb0:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42eb3:	48 63 c8             	movslq %eax,%rcx
   42eb6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42eba:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42ebd:	48 63 d2             	movslq %edx,%rdx
   42ec0:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42ec4:	eb 2d                	jmp    42ef3 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   42ec6:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42ec9:	48 98                	cltq   
   42ecb:	83 e0 01             	and    $0x1,%eax
   42ece:	48 85 c0             	test   %rax,%rax
   42ed1:	74 20                	je     42ef3 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42ed3:	be 88 00 00 00       	mov    $0x88,%esi
   42ed8:	48 8d 05 11 1f 00 00 	lea    0x1f11(%rip),%rax        # 44df0 <complex_keymap+0x3f0>
   42edf:	48 89 c7             	mov    %rax,%rdi
   42ee2:	b8 00 00 00 00       	mov    $0x0,%eax
   42ee7:	e8 92 f6 ff ff       	call   4257e <log_printf>
            return -1;
   42eec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42ef1:	eb 28                	jmp    42f1b <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42ef3:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   42efa:	00 
   42efb:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   42f02:	00 
   42f03:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   42f0a:	00 
   42f0b:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   42f10:	0f 85 08 ff ff ff    	jne    42e1e <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   42f16:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f1b:	c9                   	leave  
   42f1c:	c3                   	ret    

0000000000042f1d <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42f1d:	f3 0f 1e fa          	endbr64 
   42f21:	55                   	push   %rbp
   42f22:	48 89 e5             	mov    %rsp,%rbp
   42f25:	48 83 ec 40          	sub    $0x40,%rsp
   42f29:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f2d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42f31:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42f34:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f38:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42f3c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42f43:	e9 4f 01 00 00       	jmp    43097 <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
                int index = PAGEINDEX(va, i); // Get the index for the current level
   42f48:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42f4b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42f4f:	89 d6                	mov    %edx,%esi
   42f51:	48 89 c7             	mov    %rax,%rdi
   42f54:	e8 f7 f9 ff ff       	call   42950 <pageindex>
   42f59:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   42f5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f60:	8b 55 f0             	mov    -0x10(%rbp),%edx
   42f63:	48 63 d2             	movslq %edx,%rdx
   42f66:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42f6a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42f6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f72:	83 e0 01             	and    $0x1,%eax
   42f75:	48 85 c0             	test   %rax,%rax
   42f78:	75 6d                	jne    42fe7 <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42f7a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42f7d:	8d 48 02             	lea    0x2(%rax),%ecx
   42f80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f84:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f89:	48 89 c2             	mov    %rax,%rdx
   42f8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f90:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42f96:	48 89 c6             	mov    %rax,%rsi
   42f99:	48 8d 05 98 1e 00 00 	lea    0x1e98(%rip),%rax        # 44e38 <complex_keymap+0x438>
   42fa0:	48 89 c7             	mov    %rax,%rdi
   42fa3:	b8 00 00 00 00       	mov    $0x0,%eax
   42fa8:	e8 d1 f5 ff ff       	call   4257e <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42fad:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42fb0:	48 98                	cltq   
   42fb2:	83 e0 01             	and    $0x1,%eax
   42fb5:	48 85 c0             	test   %rax,%rax
   42fb8:	75 0a                	jne    42fc4 <lookup_l1pagetable+0xa7>
                return NULL;
   42fba:	b8 00 00 00 00       	mov    $0x0,%eax
   42fbf:	e9 e1 00 00 00       	jmp    430a5 <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42fc4:	be ad 00 00 00       	mov    $0xad,%esi
   42fc9:	48 8d 05 d0 1e 00 00 	lea    0x1ed0(%rip),%rax        # 44ea0 <complex_keymap+0x4a0>
   42fd0:	48 89 c7             	mov    %rax,%rdi
   42fd3:	b8 00 00 00 00       	mov    $0x0,%eax
   42fd8:	e8 a1 f5 ff ff       	call   4257e <log_printf>
            return NULL;
   42fdd:	b8 00 00 00 00       	mov    $0x0,%eax
   42fe2:	e9 be 00 00 00       	jmp    430a5 <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42fe7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42feb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ff1:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42ff7:	76 1e                	jbe    43017 <lookup_l1pagetable+0xfa>
   42ff9:	48 8d 05 e8 1e 00 00 	lea    0x1ee8(%rip),%rax        # 44ee8 <complex_keymap+0x4e8>
   43000:	48 89 c2             	mov    %rax,%rdx
   43003:	be b2 00 00 00       	mov    $0xb2,%esi
   43008:	48 8d 05 26 1b 00 00 	lea    0x1b26(%rip),%rax        # 44b35 <complex_keymap+0x135>
   4300f:	48 89 c7             	mov    %rax,%rdi
   43012:	e8 c2 f8 ff ff       	call   428d9 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   43017:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4301a:	48 98                	cltq   
   4301c:	83 e0 02             	and    $0x2,%eax
   4301f:	48 85 c0             	test   %rax,%rax
   43022:	74 2a                	je     4304e <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   43024:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43028:	83 e0 02             	and    $0x2,%eax
   4302b:	48 85 c0             	test   %rax,%rax
   4302e:	75 1e                	jne    4304e <lookup_l1pagetable+0x131>
   43030:	48 8d 05 d1 1e 00 00 	lea    0x1ed1(%rip),%rax        # 44f08 <complex_keymap+0x508>
   43037:	48 89 c2             	mov    %rax,%rdx
   4303a:	be b4 00 00 00       	mov    $0xb4,%esi
   4303f:	48 8d 05 ef 1a 00 00 	lea    0x1aef(%rip),%rax        # 44b35 <complex_keymap+0x135>
   43046:	48 89 c7             	mov    %rax,%rdi
   43049:	e8 8b f8 ff ff       	call   428d9 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   4304e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43051:	48 98                	cltq   
   43053:	83 e0 04             	and    $0x4,%eax
   43056:	48 85 c0             	test   %rax,%rax
   43059:	74 2a                	je     43085 <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   4305b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4305f:	83 e0 04             	and    $0x4,%eax
   43062:	48 85 c0             	test   %rax,%rax
   43065:	75 1e                	jne    43085 <lookup_l1pagetable+0x168>
   43067:	48 8d 05 a5 1e 00 00 	lea    0x1ea5(%rip),%rax        # 44f13 <complex_keymap+0x513>
   4306e:	48 89 c2             	mov    %rax,%rdx
   43071:	be b7 00 00 00       	mov    $0xb7,%esi
   43076:	48 8d 05 b8 1a 00 00 	lea    0x1ab8(%rip),%rax        # 44b35 <complex_keymap+0x135>
   4307d:	48 89 c7             	mov    %rax,%rdi
   43080:	e8 54 f8 ff ff       	call   428d9 <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43085:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43089:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4308f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   43093:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   43097:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   4309b:	0f 8e a7 fe ff ff    	jle    42f48 <lookup_l1pagetable+0x2b>
    }
    return pt;
   430a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   430a5:	c9                   	leave  
   430a6:	c3                   	ret    

00000000000430a7 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   430a7:	f3 0f 1e fa          	endbr64 
   430ab:	55                   	push   %rbp
   430ac:	48 89 e5             	mov    %rsp,%rbp
   430af:	48 83 ec 50          	sub    $0x50,%rsp
   430b3:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   430b7:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   430bb:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   430bf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   430c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   430c7:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   430ce:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   430cf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   430d6:	eb 41                	jmp    43119 <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   430d8:	8b 55 ec             	mov    -0x14(%rbp),%edx
   430db:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   430df:	89 d6                	mov    %edx,%esi
   430e1:	48 89 c7             	mov    %rax,%rdi
   430e4:	e8 67 f8 ff ff       	call   42950 <pageindex>
   430e9:	89 c2                	mov    %eax,%edx
   430eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430ef:	48 63 d2             	movslq %edx,%rdx
   430f2:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   430f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430fa:	83 e0 06             	and    $0x6,%eax
   430fd:	48 f7 d0             	not    %rax
   43100:	48 21 d0             	and    %rdx,%rax
   43103:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43107:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4310b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43111:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43115:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43119:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4311d:	7f 0c                	jg     4312b <virtual_memory_lookup+0x84>
   4311f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43123:	83 e0 01             	and    $0x1,%eax
   43126:	48 85 c0             	test   %rax,%rax
   43129:	75 ad                	jne    430d8 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   4312b:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43132:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   43139:	ff 
   4313a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   43141:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43145:	83 e0 01             	and    $0x1,%eax
   43148:	48 85 c0             	test   %rax,%rax
   4314b:	74 34                	je     43181 <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   4314d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43151:	48 c1 e8 0c          	shr    $0xc,%rax
   43155:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43158:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4315c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43162:	48 89 c2             	mov    %rax,%rdx
   43165:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43169:	25 ff 0f 00 00       	and    $0xfff,%eax
   4316e:	48 09 d0             	or     %rdx,%rax
   43171:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   43175:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43179:	25 ff 0f 00 00       	and    $0xfff,%eax
   4317e:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   43181:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43185:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43189:	48 89 10             	mov    %rdx,(%rax)
   4318c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   43190:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43194:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43198:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   4319c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431a0:	c9                   	leave  
   431a1:	c3                   	ret    

00000000000431a2 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   431a2:	f3 0f 1e fa          	endbr64 
   431a6:	55                   	push   %rbp
   431a7:	48 89 e5             	mov    %rsp,%rbp
   431aa:	48 83 ec 40          	sub    $0x40,%rsp
   431ae:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   431b2:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   431b5:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   431b9:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   431c0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   431c4:	78 08                	js     431ce <program_load+0x2c>
   431c6:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   431c9:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   431cc:	7c 1e                	jl     431ec <program_load+0x4a>
   431ce:	48 8d 05 4b 1d 00 00 	lea    0x1d4b(%rip),%rax        # 44f20 <complex_keymap+0x520>
   431d5:	48 89 c2             	mov    %rax,%rdx
   431d8:	be 37 00 00 00       	mov    $0x37,%esi
   431dd:	48 8d 05 6c 1d 00 00 	lea    0x1d6c(%rip),%rax        # 44f50 <complex_keymap+0x550>
   431e4:	48 89 c7             	mov    %rax,%rdi
   431e7:	e8 ed f6 ff ff       	call   428d9 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   431ec:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   431ef:	48 98                	cltq   
   431f1:	48 c1 e0 04          	shl    $0x4,%rax
   431f5:	48 89 c2             	mov    %rax,%rdx
   431f8:	48 8d 05 21 2e 00 00 	lea    0x2e21(%rip),%rax        # 46020 <ramimages>
   431ff:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   43203:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43207:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4320b:	8b 00                	mov    (%rax),%eax
   4320d:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43212:	74 1e                	je     43232 <program_load+0x90>
   43214:	48 8d 05 47 1d 00 00 	lea    0x1d47(%rip),%rax        # 44f62 <complex_keymap+0x562>
   4321b:	48 89 c2             	mov    %rax,%rdx
   4321e:	be 39 00 00 00       	mov    $0x39,%esi
   43223:	48 8d 05 26 1d 00 00 	lea    0x1d26(%rip),%rax        # 44f50 <complex_keymap+0x550>
   4322a:	48 89 c7             	mov    %rax,%rdi
   4322d:	e8 a7 f6 ff ff       	call   428d9 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43232:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43236:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4323a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4323e:	48 01 d0             	add    %rdx,%rax
   43241:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43245:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4324c:	e9 94 00 00 00       	jmp    432e5 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43251:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43254:	48 63 d0             	movslq %eax,%rdx
   43257:	48 89 d0             	mov    %rdx,%rax
   4325a:	48 c1 e0 03          	shl    $0x3,%rax
   4325e:	48 29 d0             	sub    %rdx,%rax
   43261:	48 c1 e0 03          	shl    $0x3,%rax
   43265:	48 89 c2             	mov    %rax,%rdx
   43268:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4326c:	48 01 d0             	add    %rdx,%rax
   4326f:	8b 00                	mov    (%rax),%eax
   43271:	83 f8 01             	cmp    $0x1,%eax
   43274:	75 6b                	jne    432e1 <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   43276:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43279:	48 63 d0             	movslq %eax,%rdx
   4327c:	48 89 d0             	mov    %rdx,%rax
   4327f:	48 c1 e0 03          	shl    $0x3,%rax
   43283:	48 29 d0             	sub    %rdx,%rax
   43286:	48 c1 e0 03          	shl    $0x3,%rax
   4328a:	48 89 c2             	mov    %rax,%rdx
   4328d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43291:	48 01 d0             	add    %rdx,%rax
   43294:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43298:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4329c:	48 01 d0             	add    %rdx,%rax
   4329f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   432a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   432a6:	48 63 d0             	movslq %eax,%rdx
   432a9:	48 89 d0             	mov    %rdx,%rax
   432ac:	48 c1 e0 03          	shl    $0x3,%rax
   432b0:	48 29 d0             	sub    %rdx,%rax
   432b3:	48 c1 e0 03          	shl    $0x3,%rax
   432b7:	48 89 c2             	mov    %rax,%rdx
   432ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432be:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   432c2:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   432c6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   432ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432ce:	48 89 c7             	mov    %rax,%rdi
   432d1:	e8 3d 00 00 00       	call   43313 <program_load_segment>
   432d6:	85 c0                	test   %eax,%eax
   432d8:	79 07                	jns    432e1 <program_load+0x13f>
                return -1;
   432da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   432df:	eb 30                	jmp    43311 <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   432e1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   432e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432e9:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   432ed:	0f b7 c0             	movzwl %ax,%eax
   432f0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   432f3:	0f 8c 58 ff ff ff    	jl     43251 <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   432f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432fd:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43301:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43305:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   4330c:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43311:	c9                   	leave  
   43312:	c3                   	ret    

0000000000043313 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43313:	f3 0f 1e fa          	endbr64 
   43317:	55                   	push   %rbp
   43318:	48 89 e5             	mov    %rsp,%rbp
   4331b:	48 83 ec 40          	sub    $0x40,%rsp
   4331f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43323:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43327:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   4332b:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4332f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43333:	48 8b 40 10          	mov    0x10(%rax),%rax
   43337:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4333b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4333f:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43343:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43347:	48 01 d0             	add    %rdx,%rax
   4334a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4334e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43352:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43356:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4335a:	48 01 d0             	add    %rdx,%rax
   4335d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43361:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   43368:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43369:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4336d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43371:	e9 81 00 00 00       	jmp    433f7 <program_load_segment+0xe4>
        if (assign_physical_page(addr, p->p_pid) < 0
   43376:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4337a:	8b 00                	mov    (%rax),%eax
   4337c:	0f be d0             	movsbl %al,%edx
   4337f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43383:	89 d6                	mov    %edx,%esi
   43385:	48 89 c7             	mov    %rax,%rdi
   43388:	e8 66 d3 ff ff       	call   406f3 <assign_physical_page>
   4338d:	85 c0                	test   %eax,%eax
   4338f:	78 2a                	js     433bb <program_load_segment+0xa8>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   43391:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43395:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4339c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   433a0:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   433a4:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   433aa:	b9 00 10 00 00       	mov    $0x1000,%ecx
   433af:	48 89 c7             	mov    %rax,%rdi
   433b2:	e8 a6 f8 ff ff       	call   42c5d <virtual_memory_map>
   433b7:	85 c0                	test   %eax,%eax
   433b9:	79 34                	jns    433ef <program_load_segment+0xdc>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   433bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433bf:	8b 00                	mov    (%rax),%eax
   433c1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   433c5:	49 89 d0             	mov    %rdx,%r8
   433c8:	89 c1                	mov    %eax,%ecx
   433ca:	48 8d 05 af 1b 00 00 	lea    0x1baf(%rip),%rax        # 44f80 <complex_keymap+0x580>
   433d1:	48 89 c2             	mov    %rax,%rdx
   433d4:	be 00 c0 00 00       	mov    $0xc000,%esi
   433d9:	bf e0 06 00 00       	mov    $0x6e0,%edi
   433de:	b8 00 00 00 00       	mov    $0x0,%eax
   433e3:	e8 c5 0f 00 00       	call   443ad <console_printf>
            return -1;
   433e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   433ed:	eb 77                	jmp    43466 <program_load_segment+0x153>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   433ef:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   433f6:	00 
   433f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433fb:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   433ff:	0f 82 71 ff ff ff    	jb     43376 <program_load_segment+0x63>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43405:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43409:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43410:	48 89 c7             	mov    %rax,%rdi
   43413:	e8 d3 f6 ff ff       	call   42aeb <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43418:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4341c:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   43420:	48 89 c2             	mov    %rax,%rdx
   43423:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43427:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4342b:	48 89 ce             	mov    %rcx,%rsi
   4342e:	48 89 c7             	mov    %rax,%rdi
   43431:	e8 32 00 00 00       	call   43468 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43436:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4343a:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4343e:	48 89 c2             	mov    %rax,%rdx
   43441:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43445:	be 00 00 00 00       	mov    $0x0,%esi
   4344a:	48 89 c7             	mov    %rax,%rdi
   4344d:	e8 1c 01 00 00       	call   4356e <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43452:	48 8b 05 a7 1b 01 00 	mov    0x11ba7(%rip),%rax        # 55000 <kernel_pagetable>
   43459:	48 89 c7             	mov    %rax,%rdi
   4345c:	e8 8a f6 ff ff       	call   42aeb <set_pagetable>
    return 0;
   43461:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43466:	c9                   	leave  
   43467:	c3                   	ret    

0000000000043468 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43468:	f3 0f 1e fa          	endbr64 
   4346c:	55                   	push   %rbp
   4346d:	48 89 e5             	mov    %rsp,%rbp
   43470:	48 83 ec 28          	sub    $0x28,%rsp
   43474:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43478:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4347c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43480:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43484:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43488:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4348c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43490:	eb 1c                	jmp    434ae <memcpy+0x46>
        *d = *s;
   43492:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43496:	0f b6 10             	movzbl (%rax),%edx
   43499:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4349d:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4349f:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   434a4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   434a9:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   434ae:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   434b3:	75 dd                	jne    43492 <memcpy+0x2a>
    }
    return dst;
   434b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   434b9:	c9                   	leave  
   434ba:	c3                   	ret    

00000000000434bb <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   434bb:	f3 0f 1e fa          	endbr64 
   434bf:	55                   	push   %rbp
   434c0:	48 89 e5             	mov    %rsp,%rbp
   434c3:	48 83 ec 28          	sub    $0x28,%rsp
   434c7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   434cb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   434cf:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   434d3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   434d7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   434db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434df:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   434e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434e7:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   434eb:	73 6a                	jae    43557 <memmove+0x9c>
   434ed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   434f1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434f5:	48 01 d0             	add    %rdx,%rax
   434f8:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   434fc:	73 59                	jae    43557 <memmove+0x9c>
        s += n, d += n;
   434fe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43502:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43506:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4350a:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   4350e:	eb 17                	jmp    43527 <memmove+0x6c>
            *--d = *--s;
   43510:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43515:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   4351a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4351e:	0f b6 10             	movzbl (%rax),%edx
   43521:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43525:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43527:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4352b:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4352f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43533:	48 85 c0             	test   %rax,%rax
   43536:	75 d8                	jne    43510 <memmove+0x55>
    if (s < d && s + n > d) {
   43538:	eb 2e                	jmp    43568 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   4353a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4353e:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43542:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43546:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4354a:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4354e:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43552:	0f b6 12             	movzbl (%rdx),%edx
   43555:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43557:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4355b:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4355f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43563:	48 85 c0             	test   %rax,%rax
   43566:	75 d2                	jne    4353a <memmove+0x7f>
        }
    }
    return dst;
   43568:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4356c:	c9                   	leave  
   4356d:	c3                   	ret    

000000000004356e <memset>:

void* memset(void* v, int c, size_t n) {
   4356e:	f3 0f 1e fa          	endbr64 
   43572:	55                   	push   %rbp
   43573:	48 89 e5             	mov    %rsp,%rbp
   43576:	48 83 ec 28          	sub    $0x28,%rsp
   4357a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4357e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43581:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43585:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43589:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4358d:	eb 15                	jmp    435a4 <memset+0x36>
        *p = c;
   4358f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43592:	89 c2                	mov    %eax,%edx
   43594:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43598:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4359a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4359f:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   435a4:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   435a9:	75 e4                	jne    4358f <memset+0x21>
    }
    return v;
   435ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   435af:	c9                   	leave  
   435b0:	c3                   	ret    

00000000000435b1 <strlen>:

size_t strlen(const char* s) {
   435b1:	f3 0f 1e fa          	endbr64 
   435b5:	55                   	push   %rbp
   435b6:	48 89 e5             	mov    %rsp,%rbp
   435b9:	48 83 ec 18          	sub    $0x18,%rsp
   435bd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   435c1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   435c8:	00 
   435c9:	eb 0a                	jmp    435d5 <strlen+0x24>
        ++n;
   435cb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   435d0:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   435d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435d9:	0f b6 00             	movzbl (%rax),%eax
   435dc:	84 c0                	test   %al,%al
   435de:	75 eb                	jne    435cb <strlen+0x1a>
    }
    return n;
   435e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   435e4:	c9                   	leave  
   435e5:	c3                   	ret    

00000000000435e6 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   435e6:	f3 0f 1e fa          	endbr64 
   435ea:	55                   	push   %rbp
   435eb:	48 89 e5             	mov    %rsp,%rbp
   435ee:	48 83 ec 20          	sub    $0x20,%rsp
   435f2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   435f6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   435fa:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43601:	00 
   43602:	eb 0a                	jmp    4360e <strnlen+0x28>
        ++n;
   43604:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43609:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4360e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43612:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43616:	74 0b                	je     43623 <strnlen+0x3d>
   43618:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4361c:	0f b6 00             	movzbl (%rax),%eax
   4361f:	84 c0                	test   %al,%al
   43621:	75 e1                	jne    43604 <strnlen+0x1e>
    }
    return n;
   43623:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43627:	c9                   	leave  
   43628:	c3                   	ret    

0000000000043629 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43629:	f3 0f 1e fa          	endbr64 
   4362d:	55                   	push   %rbp
   4362e:	48 89 e5             	mov    %rsp,%rbp
   43631:	48 83 ec 20          	sub    $0x20,%rsp
   43635:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43639:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   4363d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43641:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43645:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43649:	48 8d 42 01          	lea    0x1(%rdx),%rax
   4364d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43651:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43655:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43659:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   4365d:	0f b6 12             	movzbl (%rdx),%edx
   43660:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43662:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43666:	48 83 e8 01          	sub    $0x1,%rax
   4366a:	0f b6 00             	movzbl (%rax),%eax
   4366d:	84 c0                	test   %al,%al
   4366f:	75 d4                	jne    43645 <strcpy+0x1c>
    return dst;
   43671:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43675:	c9                   	leave  
   43676:	c3                   	ret    

0000000000043677 <strcmp>:

int strcmp(const char* a, const char* b) {
   43677:	f3 0f 1e fa          	endbr64 
   4367b:	55                   	push   %rbp
   4367c:	48 89 e5             	mov    %rsp,%rbp
   4367f:	48 83 ec 10          	sub    $0x10,%rsp
   43683:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43687:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   4368b:	eb 0a                	jmp    43697 <strcmp+0x20>
        ++a, ++b;
   4368d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43692:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43697:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4369b:	0f b6 00             	movzbl (%rax),%eax
   4369e:	84 c0                	test   %al,%al
   436a0:	74 1d                	je     436bf <strcmp+0x48>
   436a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436a6:	0f b6 00             	movzbl (%rax),%eax
   436a9:	84 c0                	test   %al,%al
   436ab:	74 12                	je     436bf <strcmp+0x48>
   436ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436b1:	0f b6 10             	movzbl (%rax),%edx
   436b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436b8:	0f b6 00             	movzbl (%rax),%eax
   436bb:	38 c2                	cmp    %al,%dl
   436bd:	74 ce                	je     4368d <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   436bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436c3:	0f b6 00             	movzbl (%rax),%eax
   436c6:	89 c2                	mov    %eax,%edx
   436c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436cc:	0f b6 00             	movzbl (%rax),%eax
   436cf:	38 c2                	cmp    %al,%dl
   436d1:	0f 97 c0             	seta   %al
   436d4:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   436d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436db:	0f b6 00             	movzbl (%rax),%eax
   436de:	89 c1                	mov    %eax,%ecx
   436e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436e4:	0f b6 00             	movzbl (%rax),%eax
   436e7:	38 c1                	cmp    %al,%cl
   436e9:	0f 92 c0             	setb   %al
   436ec:	0f b6 c8             	movzbl %al,%ecx
   436ef:	89 d0                	mov    %edx,%eax
   436f1:	29 c8                	sub    %ecx,%eax
}
   436f3:	c9                   	leave  
   436f4:	c3                   	ret    

00000000000436f5 <strchr>:

char* strchr(const char* s, int c) {
   436f5:	f3 0f 1e fa          	endbr64 
   436f9:	55                   	push   %rbp
   436fa:	48 89 e5             	mov    %rsp,%rbp
   436fd:	48 83 ec 10          	sub    $0x10,%rsp
   43701:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43705:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43708:	eb 05                	jmp    4370f <strchr+0x1a>
        ++s;
   4370a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   4370f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43713:	0f b6 00             	movzbl (%rax),%eax
   43716:	84 c0                	test   %al,%al
   43718:	74 0e                	je     43728 <strchr+0x33>
   4371a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4371e:	0f b6 00             	movzbl (%rax),%eax
   43721:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43724:	38 d0                	cmp    %dl,%al
   43726:	75 e2                	jne    4370a <strchr+0x15>
    }
    if (*s == (char) c) {
   43728:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4372c:	0f b6 00             	movzbl (%rax),%eax
   4372f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43732:	38 d0                	cmp    %dl,%al
   43734:	75 06                	jne    4373c <strchr+0x47>
        return (char*) s;
   43736:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4373a:	eb 05                	jmp    43741 <strchr+0x4c>
    } else {
        return NULL;
   4373c:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43741:	c9                   	leave  
   43742:	c3                   	ret    

0000000000043743 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43743:	f3 0f 1e fa          	endbr64 
   43747:	55                   	push   %rbp
   43748:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   4374b:	8b 05 af 78 01 00    	mov    0x178af(%rip),%eax        # 5b000 <rand_seed_set>
   43751:	85 c0                	test   %eax,%eax
   43753:	75 0a                	jne    4375f <rand+0x1c>
        srand(819234718U);
   43755:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   4375a:	e8 24 00 00 00       	call   43783 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   4375f:	8b 05 9f 78 01 00    	mov    0x1789f(%rip),%eax        # 5b004 <rand_seed>
   43765:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   4376b:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43770:	89 05 8e 78 01 00    	mov    %eax,0x1788e(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   43776:	8b 05 88 78 01 00    	mov    0x17888(%rip),%eax        # 5b004 <rand_seed>
   4377c:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43781:	5d                   	pop    %rbp
   43782:	c3                   	ret    

0000000000043783 <srand>:

void srand(unsigned seed) {
   43783:	f3 0f 1e fa          	endbr64 
   43787:	55                   	push   %rbp
   43788:	48 89 e5             	mov    %rsp,%rbp
   4378b:	48 83 ec 08          	sub    $0x8,%rsp
   4378f:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43792:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43795:	89 05 69 78 01 00    	mov    %eax,0x17869(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   4379b:	c7 05 5b 78 01 00 01 	movl   $0x1,0x1785b(%rip)        # 5b000 <rand_seed_set>
   437a2:	00 00 00 
}
   437a5:	90                   	nop
   437a6:	c9                   	leave  
   437a7:	c3                   	ret    

00000000000437a8 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   437a8:	f3 0f 1e fa          	endbr64 
   437ac:	55                   	push   %rbp
   437ad:	48 89 e5             	mov    %rsp,%rbp
   437b0:	48 83 ec 28          	sub    $0x28,%rsp
   437b4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   437b8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   437bc:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   437bf:	48 8d 05 fa 18 00 00 	lea    0x18fa(%rip),%rax        # 450c0 <upper_digits.1>
   437c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   437ca:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   437ce:	79 0e                	jns    437de <fill_numbuf+0x36>
        digits = lower_digits;
   437d0:	48 8d 05 09 19 00 00 	lea    0x1909(%rip),%rax        # 450e0 <lower_digits.0>
   437d7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   437db:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   437de:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   437e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437e7:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   437ea:	8b 45 dc             	mov    -0x24(%rbp),%eax
   437ed:	48 63 c8             	movslq %eax,%rcx
   437f0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437f4:	ba 00 00 00 00       	mov    $0x0,%edx
   437f9:	48 f7 f1             	div    %rcx
   437fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43800:	48 01 d0             	add    %rdx,%rax
   43803:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43808:	0f b6 10             	movzbl (%rax),%edx
   4380b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4380f:	88 10                	mov    %dl,(%rax)
        val /= base;
   43811:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43814:	48 63 f0             	movslq %eax,%rsi
   43817:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4381b:	ba 00 00 00 00       	mov    $0x0,%edx
   43820:	48 f7 f6             	div    %rsi
   43823:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43827:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4382c:	75 bc                	jne    437ea <fill_numbuf+0x42>
    return numbuf_end;
   4382e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43832:	c9                   	leave  
   43833:	c3                   	ret    

0000000000043834 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43834:	f3 0f 1e fa          	endbr64 
   43838:	55                   	push   %rbp
   43839:	48 89 e5             	mov    %rsp,%rbp
   4383c:	53                   	push   %rbx
   4383d:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43844:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   4384b:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43851:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43858:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   4385f:	e9 bd 09 00 00       	jmp    44221 <printer_vprintf+0x9ed>
        if (*format != '%') {
   43864:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4386b:	0f b6 00             	movzbl (%rax),%eax
   4386e:	3c 25                	cmp    $0x25,%al
   43870:	74 31                	je     438a3 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   43872:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43879:	4c 8b 00             	mov    (%rax),%r8
   4387c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43883:	0f b6 00             	movzbl (%rax),%eax
   43886:	0f b6 c8             	movzbl %al,%ecx
   43889:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4388f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43896:	89 ce                	mov    %ecx,%esi
   43898:	48 89 c7             	mov    %rax,%rdi
   4389b:	41 ff d0             	call   *%r8
            continue;
   4389e:	e9 76 09 00 00       	jmp    44219 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   438a3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   438aa:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   438b1:	01 
   438b2:	eb 4d                	jmp    43901 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   438b4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   438bb:	0f b6 00             	movzbl (%rax),%eax
   438be:	0f be c0             	movsbl %al,%eax
   438c1:	89 c6                	mov    %eax,%esi
   438c3:	48 8d 05 f6 16 00 00 	lea    0x16f6(%rip),%rax        # 44fc0 <flag_chars>
   438ca:	48 89 c7             	mov    %rax,%rdi
   438cd:	e8 23 fe ff ff       	call   436f5 <strchr>
   438d2:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   438d6:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   438db:	74 34                	je     43911 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   438dd:	48 8d 15 dc 16 00 00 	lea    0x16dc(%rip),%rdx        # 44fc0 <flag_chars>
   438e4:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   438e8:	48 29 d0             	sub    %rdx,%rax
   438eb:	ba 01 00 00 00       	mov    $0x1,%edx
   438f0:	89 c1                	mov    %eax,%ecx
   438f2:	d3 e2                	shl    %cl,%edx
   438f4:	89 d0                	mov    %edx,%eax
   438f6:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   438f9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43900:	01 
   43901:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43908:	0f b6 00             	movzbl (%rax),%eax
   4390b:	84 c0                	test   %al,%al
   4390d:	75 a5                	jne    438b4 <printer_vprintf+0x80>
   4390f:	eb 01                	jmp    43912 <printer_vprintf+0xde>
            } else {
                break;
   43911:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43912:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43919:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43920:	0f b6 00             	movzbl (%rax),%eax
   43923:	3c 30                	cmp    $0x30,%al
   43925:	7e 67                	jle    4398e <printer_vprintf+0x15a>
   43927:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4392e:	0f b6 00             	movzbl (%rax),%eax
   43931:	3c 39                	cmp    $0x39,%al
   43933:	7f 59                	jg     4398e <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43935:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   4393c:	eb 2e                	jmp    4396c <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   4393e:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43941:	89 d0                	mov    %edx,%eax
   43943:	c1 e0 02             	shl    $0x2,%eax
   43946:	01 d0                	add    %edx,%eax
   43948:	01 c0                	add    %eax,%eax
   4394a:	89 c1                	mov    %eax,%ecx
   4394c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43953:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43957:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4395e:	0f b6 00             	movzbl (%rax),%eax
   43961:	0f be c0             	movsbl %al,%eax
   43964:	01 c8                	add    %ecx,%eax
   43966:	83 e8 30             	sub    $0x30,%eax
   43969:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4396c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43973:	0f b6 00             	movzbl (%rax),%eax
   43976:	3c 2f                	cmp    $0x2f,%al
   43978:	0f 8e 85 00 00 00    	jle    43a03 <printer_vprintf+0x1cf>
   4397e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43985:	0f b6 00             	movzbl (%rax),%eax
   43988:	3c 39                	cmp    $0x39,%al
   4398a:	7e b2                	jle    4393e <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   4398c:	eb 75                	jmp    43a03 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   4398e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43995:	0f b6 00             	movzbl (%rax),%eax
   43998:	3c 2a                	cmp    $0x2a,%al
   4399a:	75 68                	jne    43a04 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   4399c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439a3:	8b 00                	mov    (%rax),%eax
   439a5:	83 f8 2f             	cmp    $0x2f,%eax
   439a8:	77 30                	ja     439da <printer_vprintf+0x1a6>
   439aa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439b1:	48 8b 50 10          	mov    0x10(%rax),%rdx
   439b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439bc:	8b 00                	mov    (%rax),%eax
   439be:	89 c0                	mov    %eax,%eax
   439c0:	48 01 d0             	add    %rdx,%rax
   439c3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439ca:	8b 12                	mov    (%rdx),%edx
   439cc:	8d 4a 08             	lea    0x8(%rdx),%ecx
   439cf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439d6:	89 0a                	mov    %ecx,(%rdx)
   439d8:	eb 1a                	jmp    439f4 <printer_vprintf+0x1c0>
   439da:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439e1:	48 8b 40 08          	mov    0x8(%rax),%rax
   439e5:	48 8d 48 08          	lea    0x8(%rax),%rcx
   439e9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439f0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   439f4:	8b 00                	mov    (%rax),%eax
   439f6:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   439f9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a00:	01 
   43a01:	eb 01                	jmp    43a04 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   43a03:	90                   	nop
        }

        // process precision
        int precision = -1;
   43a04:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43a0b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a12:	0f b6 00             	movzbl (%rax),%eax
   43a15:	3c 2e                	cmp    $0x2e,%al
   43a17:	0f 85 00 01 00 00    	jne    43b1d <printer_vprintf+0x2e9>
            ++format;
   43a1d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a24:	01 
            if (*format >= '0' && *format <= '9') {
   43a25:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a2c:	0f b6 00             	movzbl (%rax),%eax
   43a2f:	3c 2f                	cmp    $0x2f,%al
   43a31:	7e 67                	jle    43a9a <printer_vprintf+0x266>
   43a33:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a3a:	0f b6 00             	movzbl (%rax),%eax
   43a3d:	3c 39                	cmp    $0x39,%al
   43a3f:	7f 59                	jg     43a9a <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43a41:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43a48:	eb 2e                	jmp    43a78 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   43a4a:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43a4d:	89 d0                	mov    %edx,%eax
   43a4f:	c1 e0 02             	shl    $0x2,%eax
   43a52:	01 d0                	add    %edx,%eax
   43a54:	01 c0                	add    %eax,%eax
   43a56:	89 c1                	mov    %eax,%ecx
   43a58:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a5f:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43a63:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43a6a:	0f b6 00             	movzbl (%rax),%eax
   43a6d:	0f be c0             	movsbl %al,%eax
   43a70:	01 c8                	add    %ecx,%eax
   43a72:	83 e8 30             	sub    $0x30,%eax
   43a75:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43a78:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a7f:	0f b6 00             	movzbl (%rax),%eax
   43a82:	3c 2f                	cmp    $0x2f,%al
   43a84:	0f 8e 85 00 00 00    	jle    43b0f <printer_vprintf+0x2db>
   43a8a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a91:	0f b6 00             	movzbl (%rax),%eax
   43a94:	3c 39                	cmp    $0x39,%al
   43a96:	7e b2                	jle    43a4a <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   43a98:	eb 75                	jmp    43b0f <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   43a9a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43aa1:	0f b6 00             	movzbl (%rax),%eax
   43aa4:	3c 2a                	cmp    $0x2a,%al
   43aa6:	75 68                	jne    43b10 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   43aa8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43aaf:	8b 00                	mov    (%rax),%eax
   43ab1:	83 f8 2f             	cmp    $0x2f,%eax
   43ab4:	77 30                	ja     43ae6 <printer_vprintf+0x2b2>
   43ab6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43abd:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ac1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ac8:	8b 00                	mov    (%rax),%eax
   43aca:	89 c0                	mov    %eax,%eax
   43acc:	48 01 d0             	add    %rdx,%rax
   43acf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ad6:	8b 12                	mov    (%rdx),%edx
   43ad8:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43adb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ae2:	89 0a                	mov    %ecx,(%rdx)
   43ae4:	eb 1a                	jmp    43b00 <printer_vprintf+0x2cc>
   43ae6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43aed:	48 8b 40 08          	mov    0x8(%rax),%rax
   43af1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43af5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43afc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b00:	8b 00                	mov    (%rax),%eax
   43b02:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43b05:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43b0c:	01 
   43b0d:	eb 01                	jmp    43b10 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   43b0f:	90                   	nop
            }
            if (precision < 0) {
   43b10:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43b14:	79 07                	jns    43b1d <printer_vprintf+0x2e9>
                precision = 0;
   43b16:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43b1d:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43b24:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43b2b:	00 
        int length = 0;
   43b2c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43b33:	48 8d 05 8c 14 00 00 	lea    0x148c(%rip),%rax        # 44fc6 <flag_chars+0x6>
   43b3a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   43b3e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b45:	0f b6 00             	movzbl (%rax),%eax
   43b48:	0f be c0             	movsbl %al,%eax
   43b4b:	83 e8 43             	sub    $0x43,%eax
   43b4e:	83 f8 37             	cmp    $0x37,%eax
   43b51:	0f 87 b6 03 00 00    	ja     43f0d <printer_vprintf+0x6d9>
   43b57:	89 c0                	mov    %eax,%eax
   43b59:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   43b60:	00 
   43b61:	48 8d 05 6c 14 00 00 	lea    0x146c(%rip),%rax        # 44fd4 <flag_chars+0x14>
   43b68:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   43b6b:	48 98                	cltq   
   43b6d:	48 8d 15 60 14 00 00 	lea    0x1460(%rip),%rdx        # 44fd4 <flag_chars+0x14>
   43b74:	48 01 d0             	add    %rdx,%rax
   43b77:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   43b7a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43b81:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43b88:	01 
            goto again;
   43b89:	eb b3                	jmp    43b3e <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43b8b:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43b8f:	74 5d                	je     43bee <printer_vprintf+0x3ba>
   43b91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b98:	8b 00                	mov    (%rax),%eax
   43b9a:	83 f8 2f             	cmp    $0x2f,%eax
   43b9d:	77 30                	ja     43bcf <printer_vprintf+0x39b>
   43b9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ba6:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43baa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bb1:	8b 00                	mov    (%rax),%eax
   43bb3:	89 c0                	mov    %eax,%eax
   43bb5:	48 01 d0             	add    %rdx,%rax
   43bb8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bbf:	8b 12                	mov    (%rdx),%edx
   43bc1:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43bc4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bcb:	89 0a                	mov    %ecx,(%rdx)
   43bcd:	eb 1a                	jmp    43be9 <printer_vprintf+0x3b5>
   43bcf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bd6:	48 8b 40 08          	mov    0x8(%rax),%rax
   43bda:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43bde:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43be5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43be9:	48 8b 00             	mov    (%rax),%rax
   43bec:	eb 5c                	jmp    43c4a <printer_vprintf+0x416>
   43bee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bf5:	8b 00                	mov    (%rax),%eax
   43bf7:	83 f8 2f             	cmp    $0x2f,%eax
   43bfa:	77 30                	ja     43c2c <printer_vprintf+0x3f8>
   43bfc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c03:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c0e:	8b 00                	mov    (%rax),%eax
   43c10:	89 c0                	mov    %eax,%eax
   43c12:	48 01 d0             	add    %rdx,%rax
   43c15:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c1c:	8b 12                	mov    (%rdx),%edx
   43c1e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c28:	89 0a                	mov    %ecx,(%rdx)
   43c2a:	eb 1a                	jmp    43c46 <printer_vprintf+0x412>
   43c2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c33:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c37:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c3b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c42:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c46:	8b 00                	mov    (%rax),%eax
   43c48:	48 98                	cltq   
   43c4a:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43c4e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43c52:	48 c1 f8 38          	sar    $0x38,%rax
   43c56:	25 80 00 00 00       	and    $0x80,%eax
   43c5b:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43c5e:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43c62:	74 09                	je     43c6d <printer_vprintf+0x439>
   43c64:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43c68:	48 f7 d8             	neg    %rax
   43c6b:	eb 04                	jmp    43c71 <printer_vprintf+0x43d>
   43c6d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43c71:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43c75:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43c78:	83 c8 60             	or     $0x60,%eax
   43c7b:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43c7e:	e9 cf 02 00 00       	jmp    43f52 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43c83:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43c87:	74 5d                	je     43ce6 <printer_vprintf+0x4b2>
   43c89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c90:	8b 00                	mov    (%rax),%eax
   43c92:	83 f8 2f             	cmp    $0x2f,%eax
   43c95:	77 30                	ja     43cc7 <printer_vprintf+0x493>
   43c97:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c9e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ca2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ca9:	8b 00                	mov    (%rax),%eax
   43cab:	89 c0                	mov    %eax,%eax
   43cad:	48 01 d0             	add    %rdx,%rax
   43cb0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cb7:	8b 12                	mov    (%rdx),%edx
   43cb9:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43cbc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cc3:	89 0a                	mov    %ecx,(%rdx)
   43cc5:	eb 1a                	jmp    43ce1 <printer_vprintf+0x4ad>
   43cc7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cce:	48 8b 40 08          	mov    0x8(%rax),%rax
   43cd2:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43cd6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cdd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ce1:	48 8b 00             	mov    (%rax),%rax
   43ce4:	eb 5c                	jmp    43d42 <printer_vprintf+0x50e>
   43ce6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ced:	8b 00                	mov    (%rax),%eax
   43cef:	83 f8 2f             	cmp    $0x2f,%eax
   43cf2:	77 30                	ja     43d24 <printer_vprintf+0x4f0>
   43cf4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cfb:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43cff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d06:	8b 00                	mov    (%rax),%eax
   43d08:	89 c0                	mov    %eax,%eax
   43d0a:	48 01 d0             	add    %rdx,%rax
   43d0d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d14:	8b 12                	mov    (%rdx),%edx
   43d16:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d19:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d20:	89 0a                	mov    %ecx,(%rdx)
   43d22:	eb 1a                	jmp    43d3e <printer_vprintf+0x50a>
   43d24:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d2b:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d2f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d33:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d3a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d3e:	8b 00                	mov    (%rax),%eax
   43d40:	89 c0                	mov    %eax,%eax
   43d42:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43d46:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43d4a:	e9 03 02 00 00       	jmp    43f52 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   43d4f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43d56:	e9 28 ff ff ff       	jmp    43c83 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   43d5b:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43d62:	e9 1c ff ff ff       	jmp    43c83 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43d67:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d6e:	8b 00                	mov    (%rax),%eax
   43d70:	83 f8 2f             	cmp    $0x2f,%eax
   43d73:	77 30                	ja     43da5 <printer_vprintf+0x571>
   43d75:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d7c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d80:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d87:	8b 00                	mov    (%rax),%eax
   43d89:	89 c0                	mov    %eax,%eax
   43d8b:	48 01 d0             	add    %rdx,%rax
   43d8e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d95:	8b 12                	mov    (%rdx),%edx
   43d97:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d9a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43da1:	89 0a                	mov    %ecx,(%rdx)
   43da3:	eb 1a                	jmp    43dbf <printer_vprintf+0x58b>
   43da5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dac:	48 8b 40 08          	mov    0x8(%rax),%rax
   43db0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43db4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43dbb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43dbf:	48 8b 00             	mov    (%rax),%rax
   43dc2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43dc6:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43dcd:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43dd4:	e9 79 01 00 00       	jmp    43f52 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   43dd9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43de0:	8b 00                	mov    (%rax),%eax
   43de2:	83 f8 2f             	cmp    $0x2f,%eax
   43de5:	77 30                	ja     43e17 <printer_vprintf+0x5e3>
   43de7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dee:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43df2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43df9:	8b 00                	mov    (%rax),%eax
   43dfb:	89 c0                	mov    %eax,%eax
   43dfd:	48 01 d0             	add    %rdx,%rax
   43e00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e07:	8b 12                	mov    (%rdx),%edx
   43e09:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e13:	89 0a                	mov    %ecx,(%rdx)
   43e15:	eb 1a                	jmp    43e31 <printer_vprintf+0x5fd>
   43e17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e1e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e22:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e26:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e2d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e31:	48 8b 00             	mov    (%rax),%rax
   43e34:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43e38:	e9 15 01 00 00       	jmp    43f52 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   43e3d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e44:	8b 00                	mov    (%rax),%eax
   43e46:	83 f8 2f             	cmp    $0x2f,%eax
   43e49:	77 30                	ja     43e7b <printer_vprintf+0x647>
   43e4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e52:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e5d:	8b 00                	mov    (%rax),%eax
   43e5f:	89 c0                	mov    %eax,%eax
   43e61:	48 01 d0             	add    %rdx,%rax
   43e64:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e6b:	8b 12                	mov    (%rdx),%edx
   43e6d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e77:	89 0a                	mov    %ecx,(%rdx)
   43e79:	eb 1a                	jmp    43e95 <printer_vprintf+0x661>
   43e7b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e82:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e86:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e8a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e91:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e95:	8b 00                	mov    (%rax),%eax
   43e97:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43e9d:	e9 77 03 00 00       	jmp    44219 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   43ea2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43ea6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43eaa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43eb1:	8b 00                	mov    (%rax),%eax
   43eb3:	83 f8 2f             	cmp    $0x2f,%eax
   43eb6:	77 30                	ja     43ee8 <printer_vprintf+0x6b4>
   43eb8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ebf:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ec3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43eca:	8b 00                	mov    (%rax),%eax
   43ecc:	89 c0                	mov    %eax,%eax
   43ece:	48 01 d0             	add    %rdx,%rax
   43ed1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ed8:	8b 12                	mov    (%rdx),%edx
   43eda:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43edd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ee4:	89 0a                	mov    %ecx,(%rdx)
   43ee6:	eb 1a                	jmp    43f02 <printer_vprintf+0x6ce>
   43ee8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43eef:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ef3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43ef7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43efe:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f02:	8b 00                	mov    (%rax),%eax
   43f04:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43f07:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43f0b:	eb 45                	jmp    43f52 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   43f0d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43f11:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43f15:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f1c:	0f b6 00             	movzbl (%rax),%eax
   43f1f:	84 c0                	test   %al,%al
   43f21:	74 0c                	je     43f2f <printer_vprintf+0x6fb>
   43f23:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f2a:	0f b6 00             	movzbl (%rax),%eax
   43f2d:	eb 05                	jmp    43f34 <printer_vprintf+0x700>
   43f2f:	b8 25 00 00 00       	mov    $0x25,%eax
   43f34:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43f37:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43f3b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f42:	0f b6 00             	movzbl (%rax),%eax
   43f45:	84 c0                	test   %al,%al
   43f47:	75 08                	jne    43f51 <printer_vprintf+0x71d>
                format--;
   43f49:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43f50:	01 
            }
            break;
   43f51:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43f52:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43f55:	83 e0 20             	and    $0x20,%eax
   43f58:	85 c0                	test   %eax,%eax
   43f5a:	74 1e                	je     43f7a <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43f5c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43f60:	48 83 c0 18          	add    $0x18,%rax
   43f64:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43f67:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43f6b:	48 89 ce             	mov    %rcx,%rsi
   43f6e:	48 89 c7             	mov    %rax,%rdi
   43f71:	e8 32 f8 ff ff       	call   437a8 <fill_numbuf>
   43f76:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43f7a:	48 8d 05 45 10 00 00 	lea    0x1045(%rip),%rax        # 44fc6 <flag_chars+0x6>
   43f81:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43f85:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43f88:	83 e0 20             	and    $0x20,%eax
   43f8b:	85 c0                	test   %eax,%eax
   43f8d:	74 51                	je     43fe0 <printer_vprintf+0x7ac>
   43f8f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43f92:	83 e0 40             	and    $0x40,%eax
   43f95:	85 c0                	test   %eax,%eax
   43f97:	74 47                	je     43fe0 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   43f99:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43f9c:	25 80 00 00 00       	and    $0x80,%eax
   43fa1:	85 c0                	test   %eax,%eax
   43fa3:	74 0d                	je     43fb2 <printer_vprintf+0x77e>
                prefix = "-";
   43fa5:	48 8d 05 1b 10 00 00 	lea    0x101b(%rip),%rax        # 44fc7 <flag_chars+0x7>
   43fac:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   43fb0:	eb 7d                	jmp    4402f <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43fb2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fb5:	83 e0 10             	and    $0x10,%eax
   43fb8:	85 c0                	test   %eax,%eax
   43fba:	74 0d                	je     43fc9 <printer_vprintf+0x795>
                prefix = "+";
   43fbc:	48 8d 05 06 10 00 00 	lea    0x1006(%rip),%rax        # 44fc9 <flag_chars+0x9>
   43fc3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   43fc7:	eb 66                	jmp    4402f <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   43fc9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fcc:	83 e0 08             	and    $0x8,%eax
   43fcf:	85 c0                	test   %eax,%eax
   43fd1:	74 5c                	je     4402f <printer_vprintf+0x7fb>
                prefix = " ";
   43fd3:	48 8d 05 f1 0f 00 00 	lea    0xff1(%rip),%rax        # 44fcb <flag_chars+0xb>
   43fda:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   43fde:	eb 4f                	jmp    4402f <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43fe0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fe3:	83 e0 20             	and    $0x20,%eax
   43fe6:	85 c0                	test   %eax,%eax
   43fe8:	74 46                	je     44030 <printer_vprintf+0x7fc>
   43fea:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fed:	83 e0 01             	and    $0x1,%eax
   43ff0:	85 c0                	test   %eax,%eax
   43ff2:	74 3c                	je     44030 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   43ff4:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   43ff8:	74 06                	je     44000 <printer_vprintf+0x7cc>
   43ffa:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43ffe:	75 30                	jne    44030 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   44000:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44005:	75 0c                	jne    44013 <printer_vprintf+0x7df>
   44007:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4400a:	25 00 01 00 00       	and    $0x100,%eax
   4400f:	85 c0                	test   %eax,%eax
   44011:	74 1d                	je     44030 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   44013:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44017:	75 09                	jne    44022 <printer_vprintf+0x7ee>
   44019:	48 8d 05 ad 0f 00 00 	lea    0xfad(%rip),%rax        # 44fcd <flag_chars+0xd>
   44020:	eb 07                	jmp    44029 <printer_vprintf+0x7f5>
   44022:	48 8d 05 a7 0f 00 00 	lea    0xfa7(%rip),%rax        # 44fd0 <flag_chars+0x10>
   44029:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4402d:	eb 01                	jmp    44030 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   4402f:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44030:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44034:	78 24                	js     4405a <printer_vprintf+0x826>
   44036:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44039:	83 e0 20             	and    $0x20,%eax
   4403c:	85 c0                	test   %eax,%eax
   4403e:	75 1a                	jne    4405a <printer_vprintf+0x826>
            len = strnlen(data, precision);
   44040:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44043:	48 63 d0             	movslq %eax,%rdx
   44046:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4404a:	48 89 d6             	mov    %rdx,%rsi
   4404d:	48 89 c7             	mov    %rax,%rdi
   44050:	e8 91 f5 ff ff       	call   435e6 <strnlen>
   44055:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44058:	eb 0f                	jmp    44069 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   4405a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4405e:	48 89 c7             	mov    %rax,%rdi
   44061:	e8 4b f5 ff ff       	call   435b1 <strlen>
   44066:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44069:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4406c:	83 e0 20             	and    $0x20,%eax
   4406f:	85 c0                	test   %eax,%eax
   44071:	74 20                	je     44093 <printer_vprintf+0x85f>
   44073:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44077:	78 1a                	js     44093 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   44079:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4407c:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   4407f:	7e 08                	jle    44089 <printer_vprintf+0x855>
   44081:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44084:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44087:	eb 05                	jmp    4408e <printer_vprintf+0x85a>
   44089:	b8 00 00 00 00       	mov    $0x0,%eax
   4408e:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44091:	eb 5c                	jmp    440ef <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44093:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44096:	83 e0 20             	and    $0x20,%eax
   44099:	85 c0                	test   %eax,%eax
   4409b:	74 4b                	je     440e8 <printer_vprintf+0x8b4>
   4409d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440a0:	83 e0 02             	and    $0x2,%eax
   440a3:	85 c0                	test   %eax,%eax
   440a5:	74 41                	je     440e8 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   440a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440aa:	83 e0 04             	and    $0x4,%eax
   440ad:	85 c0                	test   %eax,%eax
   440af:	75 37                	jne    440e8 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   440b1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   440b5:	48 89 c7             	mov    %rax,%rdi
   440b8:	e8 f4 f4 ff ff       	call   435b1 <strlen>
   440bd:	89 c2                	mov    %eax,%edx
   440bf:	8b 45 bc             	mov    -0x44(%rbp),%eax
   440c2:	01 d0                	add    %edx,%eax
   440c4:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   440c7:	7e 1f                	jle    440e8 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   440c9:	8b 45 e8             	mov    -0x18(%rbp),%eax
   440cc:	2b 45 bc             	sub    -0x44(%rbp),%eax
   440cf:	89 c3                	mov    %eax,%ebx
   440d1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   440d5:	48 89 c7             	mov    %rax,%rdi
   440d8:	e8 d4 f4 ff ff       	call   435b1 <strlen>
   440dd:	89 c2                	mov    %eax,%edx
   440df:	89 d8                	mov    %ebx,%eax
   440e1:	29 d0                	sub    %edx,%eax
   440e3:	89 45 b8             	mov    %eax,-0x48(%rbp)
   440e6:	eb 07                	jmp    440ef <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   440e8:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   440ef:	8b 55 bc             	mov    -0x44(%rbp),%edx
   440f2:	8b 45 b8             	mov    -0x48(%rbp),%eax
   440f5:	01 d0                	add    %edx,%eax
   440f7:	48 63 d8             	movslq %eax,%rbx
   440fa:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   440fe:	48 89 c7             	mov    %rax,%rdi
   44101:	e8 ab f4 ff ff       	call   435b1 <strlen>
   44106:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   4410a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4410d:	29 d0                	sub    %edx,%eax
   4410f:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44112:	eb 25                	jmp    44139 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   44114:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4411b:	48 8b 08             	mov    (%rax),%rcx
   4411e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44124:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4412b:	be 20 00 00 00       	mov    $0x20,%esi
   44130:	48 89 c7             	mov    %rax,%rdi
   44133:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44135:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44139:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4413c:	83 e0 04             	and    $0x4,%eax
   4413f:	85 c0                	test   %eax,%eax
   44141:	75 36                	jne    44179 <printer_vprintf+0x945>
   44143:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44147:	7f cb                	jg     44114 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   44149:	eb 2e                	jmp    44179 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   4414b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44152:	4c 8b 00             	mov    (%rax),%r8
   44155:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44159:	0f b6 00             	movzbl (%rax),%eax
   4415c:	0f b6 c8             	movzbl %al,%ecx
   4415f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44165:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4416c:	89 ce                	mov    %ecx,%esi
   4416e:	48 89 c7             	mov    %rax,%rdi
   44171:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44174:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44179:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4417d:	0f b6 00             	movzbl (%rax),%eax
   44180:	84 c0                	test   %al,%al
   44182:	75 c7                	jne    4414b <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   44184:	eb 25                	jmp    441ab <printer_vprintf+0x977>
            p->putc(p, '0', color);
   44186:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4418d:	48 8b 08             	mov    (%rax),%rcx
   44190:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44196:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4419d:	be 30 00 00 00       	mov    $0x30,%esi
   441a2:	48 89 c7             	mov    %rax,%rdi
   441a5:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   441a7:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   441ab:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   441af:	7f d5                	jg     44186 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   441b1:	eb 32                	jmp    441e5 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   441b3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441ba:	4c 8b 00             	mov    (%rax),%r8
   441bd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   441c1:	0f b6 00             	movzbl (%rax),%eax
   441c4:	0f b6 c8             	movzbl %al,%ecx
   441c7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   441cd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441d4:	89 ce                	mov    %ecx,%esi
   441d6:	48 89 c7             	mov    %rax,%rdi
   441d9:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   441dc:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   441e1:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   441e5:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   441e9:	7f c8                	jg     441b3 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   441eb:	eb 25                	jmp    44212 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   441ed:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441f4:	48 8b 08             	mov    (%rax),%rcx
   441f7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   441fd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44204:	be 20 00 00 00       	mov    $0x20,%esi
   44209:	48 89 c7             	mov    %rax,%rdi
   4420c:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   4420e:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44212:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44216:	7f d5                	jg     441ed <printer_vprintf+0x9b9>
        }
    done: ;
   44218:	90                   	nop
    for (; *format; ++format) {
   44219:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44220:	01 
   44221:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44228:	0f b6 00             	movzbl (%rax),%eax
   4422b:	84 c0                	test   %al,%al
   4422d:	0f 85 31 f6 ff ff    	jne    43864 <printer_vprintf+0x30>
    }
}
   44233:	90                   	nop
   44234:	90                   	nop
   44235:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44239:	c9                   	leave  
   4423a:	c3                   	ret    

000000000004423b <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4423b:	f3 0f 1e fa          	endbr64 
   4423f:	55                   	push   %rbp
   44240:	48 89 e5             	mov    %rsp,%rbp
   44243:	48 83 ec 20          	sub    $0x20,%rsp
   44247:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4424b:	89 f0                	mov    %esi,%eax
   4424d:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44250:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44253:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44257:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4425b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4425f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44263:	48 8d 15 36 4d 07 00 	lea    0x74d36(%rip),%rdx        # b8fa0 <console+0xfa0>
   4426a:	48 39 d0             	cmp    %rdx,%rax
   4426d:	72 0f                	jb     4427e <console_putc+0x43>
        cp->cursor = console;
   4426f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44273:	48 8d 15 86 3d 07 00 	lea    0x73d86(%rip),%rdx        # b8000 <console>
   4427a:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   4427e:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44282:	0f 85 82 00 00 00    	jne    4430a <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   44288:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4428c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44290:	48 8d 15 69 3d 07 00 	lea    0x73d69(%rip),%rdx        # b8000 <console>
   44297:	48 29 d0             	sub    %rdx,%rax
   4429a:	48 d1 f8             	sar    %rax
   4429d:	48 89 c1             	mov    %rax,%rcx
   442a0:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   442a7:	66 66 66 
   442aa:	48 89 c8             	mov    %rcx,%rax
   442ad:	48 f7 ea             	imul   %rdx
   442b0:	48 89 d0             	mov    %rdx,%rax
   442b3:	48 c1 f8 05          	sar    $0x5,%rax
   442b7:	48 89 ce             	mov    %rcx,%rsi
   442ba:	48 c1 fe 3f          	sar    $0x3f,%rsi
   442be:	48 29 f0             	sub    %rsi,%rax
   442c1:	48 89 c2             	mov    %rax,%rdx
   442c4:	48 89 d0             	mov    %rdx,%rax
   442c7:	48 c1 e0 02          	shl    $0x2,%rax
   442cb:	48 01 d0             	add    %rdx,%rax
   442ce:	48 c1 e0 04          	shl    $0x4,%rax
   442d2:	48 29 c1             	sub    %rax,%rcx
   442d5:	48 89 ca             	mov    %rcx,%rdx
   442d8:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   442db:	eb 25                	jmp    44302 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   442dd:	8b 45 e0             	mov    -0x20(%rbp),%eax
   442e0:	83 c8 20             	or     $0x20,%eax
   442e3:	89 c6                	mov    %eax,%esi
   442e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442e9:	48 8b 40 08          	mov    0x8(%rax),%rax
   442ed:	48 8d 48 02          	lea    0x2(%rax),%rcx
   442f1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   442f5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442f9:	89 f2                	mov    %esi,%edx
   442fb:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   442fe:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44302:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44306:	75 d5                	jne    442dd <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44308:	eb 24                	jmp    4432e <console_putc+0xf3>
        *cp->cursor++ = c | color;
   4430a:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   4430e:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44311:	89 d6                	mov    %edx,%esi
   44313:	09 c6                	or     %eax,%esi
   44315:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44319:	48 8b 40 08          	mov    0x8(%rax),%rax
   4431d:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44321:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44325:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44329:	89 f2                	mov    %esi,%edx
   4432b:	66 89 10             	mov    %dx,(%rax)
}
   4432e:	90                   	nop
   4432f:	c9                   	leave  
   44330:	c3                   	ret    

0000000000044331 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44331:	f3 0f 1e fa          	endbr64 
   44335:	55                   	push   %rbp
   44336:	48 89 e5             	mov    %rsp,%rbp
   44339:	48 83 ec 30          	sub    $0x30,%rsp
   4433d:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44340:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44343:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44347:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   4434b:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 4423b <console_putc>
   44352:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44356:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   4435a:	78 09                	js     44365 <console_vprintf+0x34>
   4435c:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44363:	7e 07                	jle    4436c <console_vprintf+0x3b>
        cpos = 0;
   44365:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   4436c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4436f:	48 98                	cltq   
   44371:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44375:	48 8d 05 84 3c 07 00 	lea    0x73c84(%rip),%rax        # b8000 <console>
   4437c:	48 01 d0             	add    %rdx,%rax
   4437f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44383:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44387:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4438b:	8b 75 e8             	mov    -0x18(%rbp),%esi
   4438e:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44392:	48 89 c7             	mov    %rax,%rdi
   44395:	e8 9a f4 ff ff       	call   43834 <printer_vprintf>
    return cp.cursor - console;
   4439a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4439e:	48 8d 15 5b 3c 07 00 	lea    0x73c5b(%rip),%rdx        # b8000 <console>
   443a5:	48 29 d0             	sub    %rdx,%rax
   443a8:	48 d1 f8             	sar    %rax
}
   443ab:	c9                   	leave  
   443ac:	c3                   	ret    

00000000000443ad <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   443ad:	f3 0f 1e fa          	endbr64 
   443b1:	55                   	push   %rbp
   443b2:	48 89 e5             	mov    %rsp,%rbp
   443b5:	48 83 ec 60          	sub    $0x60,%rsp
   443b9:	89 7d ac             	mov    %edi,-0x54(%rbp)
   443bc:	89 75 a8             	mov    %esi,-0x58(%rbp)
   443bf:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   443c3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   443c7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   443cb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   443cf:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   443d6:	48 8d 45 10          	lea    0x10(%rbp),%rax
   443da:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   443de:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   443e2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   443e6:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   443ea:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   443ee:	8b 75 a8             	mov    -0x58(%rbp),%esi
   443f1:	8b 45 ac             	mov    -0x54(%rbp),%eax
   443f4:	89 c7                	mov    %eax,%edi
   443f6:	e8 36 ff ff ff       	call   44331 <console_vprintf>
   443fb:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   443fe:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44401:	c9                   	leave  
   44402:	c3                   	ret    

0000000000044403 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44403:	f3 0f 1e fa          	endbr64 
   44407:	55                   	push   %rbp
   44408:	48 89 e5             	mov    %rsp,%rbp
   4440b:	48 83 ec 20          	sub    $0x20,%rsp
   4440f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44413:	89 f0                	mov    %esi,%eax
   44415:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44418:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   4441b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4441f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44423:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44427:	48 8b 50 08          	mov    0x8(%rax),%rdx
   4442b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4442f:	48 8b 40 10          	mov    0x10(%rax),%rax
   44433:	48 39 c2             	cmp    %rax,%rdx
   44436:	73 1a                	jae    44452 <string_putc+0x4f>
        *sp->s++ = c;
   44438:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4443c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44440:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44444:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44448:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4444c:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44450:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44452:	90                   	nop
   44453:	c9                   	leave  
   44454:	c3                   	ret    

0000000000044455 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44455:	f3 0f 1e fa          	endbr64 
   44459:	55                   	push   %rbp
   4445a:	48 89 e5             	mov    %rsp,%rbp
   4445d:	48 83 ec 40          	sub    $0x40,%rsp
   44461:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44465:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44469:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   4446d:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44471:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 44403 <string_putc>
   44478:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   4447c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44480:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44484:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44489:	74 33                	je     444be <vsnprintf+0x69>
        sp.end = s + size - 1;
   4448b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4448f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44493:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44497:	48 01 d0             	add    %rdx,%rax
   4449a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   4449e:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   444a2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   444a6:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   444aa:	be 00 00 00 00       	mov    $0x0,%esi
   444af:	48 89 c7             	mov    %rax,%rdi
   444b2:	e8 7d f3 ff ff       	call   43834 <printer_vprintf>
        *sp.s = 0;
   444b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   444bb:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   444be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   444c2:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   444c6:	c9                   	leave  
   444c7:	c3                   	ret    

00000000000444c8 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   444c8:	f3 0f 1e fa          	endbr64 
   444cc:	55                   	push   %rbp
   444cd:	48 89 e5             	mov    %rsp,%rbp
   444d0:	48 83 ec 70          	sub    $0x70,%rsp
   444d4:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   444d8:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   444dc:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   444e0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   444e4:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   444e8:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   444ec:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   444f3:	48 8d 45 10          	lea    0x10(%rbp),%rax
   444f7:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   444fb:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   444ff:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44503:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44507:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   4450b:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   4450f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44513:	48 89 c7             	mov    %rax,%rdi
   44516:	e8 3a ff ff ff       	call   44455 <vsnprintf>
   4451b:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   4451e:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44521:	c9                   	leave  
   44522:	c3                   	ret    

0000000000044523 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44523:	f3 0f 1e fa          	endbr64 
   44527:	55                   	push   %rbp
   44528:	48 89 e5             	mov    %rsp,%rbp
   4452b:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4452f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44536:	eb 1a                	jmp    44552 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   44538:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4453b:	48 98                	cltq   
   4453d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44541:	48 8d 05 b8 3a 07 00 	lea    0x73ab8(%rip),%rax        # b8000 <console>
   44548:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4454e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44552:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44559:	7e dd                	jle    44538 <console_clear+0x15>
    }
    cursorpos = 0;
   4455b:	c7 05 97 4a 07 00 00 	movl   $0x0,0x74a97(%rip)        # b8ffc <cursorpos>
   44562:	00 00 00 
}
   44565:	90                   	nop
   44566:	c9                   	leave  
   44567:	c3                   	ret    
