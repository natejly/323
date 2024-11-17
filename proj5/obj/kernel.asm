
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
   400be:	e8 0d 07 00 00       	call   407d0 <exception>

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
   40177:	e8 22 16 00 00       	call   4179e <hardware_init>
    pageinfo_init();
   4017c:	e8 22 0b 00 00       	call   40ca3 <pageinfo_init>
    console_clear();
   40181:	e8 b3 42 00 00       	call   44439 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 76 1b 00 00       	call   41d06 <timer_init>


    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 7f 1e 01 00 	lea    0x11e7f(%rip),%rax        # 52020 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 db 32 00 00       	call   43484 <memset>
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
   40210:	48 8d 15 69 42 00 00 	lea    0x4269(%rip),%rdx        # 44480 <console_clear+0x47>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 6b 33 00 00       	call   4358d <strcmp>
   40222:	85 c0                	test   %eax,%eax
   40224:	75 14                	jne    4023a <kernel+0xd3>
        process_setup(1, 4);
   40226:	be 04 00 00 00       	mov    $0x4,%esi
   4022b:	bf 01 00 00 00       	mov    $0x1,%edi
   40230:	e8 c5 01 00 00       	call   403fa <process_setup>
   40235:	e9 d1 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4023a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4023f:	74 2e                	je     4026f <kernel+0x108>
   40241:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40245:	48 8d 15 39 42 00 00 	lea    0x4239(%rip),%rdx        # 44485 <console_clear+0x4c>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 36 33 00 00       	call   4358d <strcmp>
   40257:	85 c0                	test   %eax,%eax
   40259:	75 14                	jne    4026f <kernel+0x108>
        process_setup(1, 5);
   4025b:	be 05 00 00 00       	mov    $0x5,%esi
   40260:	bf 01 00 00 00       	mov    $0x1,%edi
   40265:	e8 90 01 00 00       	call   403fa <process_setup>
   4026a:	e9 9c 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test") == 0) {
   4026f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40274:	74 2b                	je     402a1 <kernel+0x13a>
   40276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4027a:	48 8d 15 0d 42 00 00 	lea    0x420d(%rip),%rdx        # 4448e <console_clear+0x55>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 01 33 00 00       	call   4358d <strcmp>
   4028c:	85 c0                	test   %eax,%eax
   4028e:	75 11                	jne    402a1 <kernel+0x13a>
        process_setup(1, 6);
   40290:	be 06 00 00 00       	mov    $0x6,%esi
   40295:	bf 01 00 00 00       	mov    $0x1,%edi
   4029a:	e8 5b 01 00 00       	call   403fa <process_setup>
   4029f:	eb 6a                	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test2") == 0) {
   402a1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a6:	74 3e                	je     402e6 <kernel+0x17f>
   402a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402ac:	48 8d 15 e0 41 00 00 	lea    0x41e0(%rip),%rdx        # 44493 <console_clear+0x5a>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 cf 32 00 00       	call   4358d <strcmp>
   402be:	85 c0                	test   %eax,%eax
   402c0:	75 24                	jne    402e6 <kernel+0x17f>
        for (pid_t i = 1; i <= 2; ++i) {
   402c2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402c9:	eb 13                	jmp    402de <kernel+0x177>
            process_setup(i, 6);
   402cb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402ce:	be 06 00 00 00       	mov    $0x6,%esi
   402d3:	89 c7                	mov    %eax,%edi
   402d5:	e8 20 01 00 00       	call   403fa <process_setup>
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
   402fc:	e8 f9 00 00 00       	call   403fa <process_setup>
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
   4032a:	e8 44 28 00 00       	call   42b73 <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   4032f:	48 8d 15 ca 7c 07 00 	lea    0x77cca(%rip),%rdx        # b8000 <console>
   40336:	48 8d 35 c3 7c 07 00 	lea    0x77cc3(%rip),%rsi        # b8000 <console>
   4033d:	48 8b 05 bc 4c 01 00 	mov    0x14cbc(%rip),%rax        # 55000 <kernel_pagetable>
   40344:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4034a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4034f:	48 89 c7             	mov    %rax,%rdi
   40352:	e8 1c 28 00 00       	call   42b73 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    // Switch to the first process using run()
    run(&processes[1]);
   40357:	48 8d 05 a2 1d 01 00 	lea    0x11da2(%rip),%rax        # 52100 <processes+0xe0>
   4035e:	48 89 c7             	mov    %rax,%rdi
   40361:	e8 d2 08 00 00       	call   40c38 <run>

0000000000040366 <reserve_page>:
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

// helper function for reserving pages which returns return its page address

uintptr_t reserve_page(int8_t owner){
   40366:	f3 0f 1e fa          	endbr64 
   4036a:	55                   	push   %rbp
   4036b:	48 89 e5             	mov    %rsp,%rbp
   4036e:	48 83 ec 18          	sub    $0x18,%rsp
   40372:	89 f8                	mov    %edi,%eax
   40374:	88 45 ec             	mov    %al,-0x14(%rbp)
    for (int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++) {
   40377:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4037e:	eb 6a                	jmp    403ea <reserve_page+0x84>
        if (pageinfo[i].refcount == 0 && pageinfo[i].owner == PO_FREE) {
   40380:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40383:	48 98                	cltq   
   40385:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40389:	48 8d 05 b1 2a 01 00 	lea    0x12ab1(%rip),%rax        # 52e41 <pageinfo+0x1>
   40390:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40394:	84 c0                	test   %al,%al
   40396:	75 4e                	jne    403e6 <reserve_page+0x80>
   40398:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4039b:	48 98                	cltq   
   4039d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   403a1:	48 8d 05 98 2a 01 00 	lea    0x12a98(%rip),%rax        # 52e40 <pageinfo>
   403a8:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   403ac:	84 c0                	test   %al,%al
   403ae:	75 36                	jne    403e6 <reserve_page+0x80>
            pageinfo[i].owner = owner;
   403b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403b3:	48 98                	cltq   
   403b5:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   403b9:	48 8d 15 80 2a 01 00 	lea    0x12a80(%rip),%rdx        # 52e40 <pageinfo>
   403c0:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
   403c4:	88 04 11             	mov    %al,(%rcx,%rdx,1)
            pageinfo[i].refcount = 1;
   403c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403ca:	48 98                	cltq   
   403cc:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   403d0:	48 8d 05 6a 2a 01 00 	lea    0x12a6a(%rip),%rax        # 52e41 <pageinfo+0x1>
   403d7:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
            return PAGEADDRESS(i);
   403db:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403de:	48 98                	cltq   
   403e0:	48 c1 e0 0c          	shl    $0xc,%rax
   403e4:	eb 12                	jmp    403f8 <reserve_page+0x92>
    for (int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++) {
   403e6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   403ea:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   403f1:	7e 8d                	jle    40380 <reserve_page+0x1a>
        }
    }
    return 1;
   403f3:	b8 01 00 00 00       	mov    $0x1,%eax
}
   403f8:	c9                   	leave  
   403f9:	c3                   	ret    

00000000000403fa <process_setup>:

void process_setup(pid_t pid, int program_number) {
   403fa:	f3 0f 1e fa          	endbr64 
   403fe:	55                   	push   %rbp
   403ff:	48 89 e5             	mov    %rsp,%rbp
   40402:	48 83 ec 30          	sub    $0x30,%rsp
   40406:	89 7d dc             	mov    %edi,-0x24(%rbp)
   40409:	89 75 d8             	mov    %esi,-0x28(%rbp)
    process_init(&processes[pid], 0);
   4040c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4040f:	48 63 d0             	movslq %eax,%rdx
   40412:	48 89 d0             	mov    %rdx,%rax
   40415:	48 c1 e0 03          	shl    $0x3,%rax
   40419:	48 29 d0             	sub    %rdx,%rax
   4041c:	48 c1 e0 05          	shl    $0x5,%rax
   40420:	48 8d 15 f9 1b 01 00 	lea    0x11bf9(%rip),%rdx        # 52020 <processes>
   40427:	48 01 d0             	add    %rdx,%rax
   4042a:	be 00 00 00 00       	mov    $0x0,%esi
   4042f:	48 89 c7             	mov    %rax,%rdi
   40432:	e8 82 1b 00 00       	call   41fb9 <process_init>
    // reserve a page for the page table
    uintptr_t pagetable_page = reserve_page(pid);
   40437:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4043a:	0f be c0             	movsbl %al,%eax
   4043d:	89 c7                	mov    %eax,%edi
   4043f:	e8 22 ff ff ff       	call   40366 <reserve_page>
   40444:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // make sure the page table page is reserved
    assert(pagetable_page != 1);
   40448:	48 83 7d f8 01       	cmpq   $0x1,-0x8(%rbp)
   4044d:	75 1e                	jne    4046d <process_setup+0x73>
   4044f:	48 8d 05 43 40 00 00 	lea    0x4043(%rip),%rax        # 44499 <console_clear+0x60>
   40456:	48 89 c2             	mov    %rax,%rdx
   40459:	be 93 00 00 00       	mov    $0x93,%esi
   4045e:	48 8d 05 48 40 00 00 	lea    0x4048(%rip),%rax        # 444ad <console_clear+0x74>
   40465:	48 89 c7             	mov    %rax,%rdi
   40468:	e8 82 23 00 00       	call   427ef <assert_fail>
    // memset the page table page to 0
    memset((x86_64_pagetable *)pagetable_page, 0, PAGESIZE);
   4046d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40471:	ba 00 10 00 00       	mov    $0x1000,%edx
   40476:	be 00 00 00 00       	mov    $0x0,%esi
   4047b:	48 89 c7             	mov    %rax,%rdi
   4047e:	e8 01 30 00 00       	call   43484 <memset>


    processes[pid].p_pagetable = kernel_pagetable;
   40483:	48 8b 15 76 4b 01 00 	mov    0x14b76(%rip),%rdx        # 55000 <kernel_pagetable>
   4048a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4048d:	48 63 c8             	movslq %eax,%rcx
   40490:	48 89 c8             	mov    %rcx,%rax
   40493:	48 c1 e0 03          	shl    $0x3,%rax
   40497:	48 29 c8             	sub    %rcx,%rax
   4049a:	48 c1 e0 05          	shl    $0x5,%rax
   4049e:	48 89 c1             	mov    %rax,%rcx
   404a1:	48 8d 05 48 1c 01 00 	lea    0x11c48(%rip),%rax        # 520f0 <processes+0xd0>
   404a8:	48 89 14 01          	mov    %rdx,(%rcx,%rax,1)
    ++pageinfo[PAGENUMBER(kernel_pagetable)].refcount; //increase refcount since kernel_pagetable was used
   404ac:	48 8b 05 4d 4b 01 00 	mov    0x14b4d(%rip),%rax        # 55000 <kernel_pagetable>
   404b3:	48 c1 e8 0c          	shr    $0xc,%rax
   404b7:	48 63 d0             	movslq %eax,%rdx
   404ba:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   404be:	48 8d 15 7c 29 01 00 	lea    0x1297c(%rip),%rdx        # 52e41 <pageinfo+0x1>
   404c5:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   404c9:	83 c2 01             	add    $0x1,%edx
   404cc:	89 d1                	mov    %edx,%ecx
   404ce:	48 98                	cltq   
   404d0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   404d4:	48 8d 05 66 29 01 00 	lea    0x12966(%rip),%rax        # 52e41 <pageinfo+0x1>
   404db:	88 0c 02             	mov    %cl,(%rdx,%rax,1)

    int r = program_load(&processes[pid], program_number, NULL);
   404de:	8b 45 dc             	mov    -0x24(%rbp),%eax
   404e1:	48 63 d0             	movslq %eax,%rdx
   404e4:	48 89 d0             	mov    %rdx,%rax
   404e7:	48 c1 e0 03          	shl    $0x3,%rax
   404eb:	48 29 d0             	sub    %rdx,%rax
   404ee:	48 c1 e0 05          	shl    $0x5,%rax
   404f2:	48 8d 15 27 1b 01 00 	lea    0x11b27(%rip),%rdx        # 52020 <processes>
   404f9:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
   404fd:	8b 45 d8             	mov    -0x28(%rbp),%eax
   40500:	ba 00 00 00 00       	mov    $0x0,%edx
   40505:	89 c6                	mov    %eax,%esi
   40507:	48 89 cf             	mov    %rcx,%rdi
   4050a:	e8 a9 2b 00 00       	call   430b8 <program_load>
   4050f:	89 45 f4             	mov    %eax,-0xc(%rbp)
    assert(r >= 0);
   40512:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40516:	79 1e                	jns    40536 <process_setup+0x13c>
   40518:	48 8d 05 9e 3f 00 00 	lea    0x3f9e(%rip),%rax        # 444bd <console_clear+0x84>
   4051f:	48 89 c2             	mov    %rax,%rdx
   40522:	be 9c 00 00 00       	mov    $0x9c,%esi
   40527:	48 8d 05 7f 3f 00 00 	lea    0x3f7f(%rip),%rax        # 444ad <console_clear+0x74>
   4052e:	48 89 c7             	mov    %rax,%rdi
   40531:	e8 b9 22 00 00       	call   427ef <assert_fail>

    processes[pid].p_registers.reg_rsp = PROC_START_ADDR + PROC_SIZE * pid;
   40536:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40539:	83 c0 04             	add    $0x4,%eax
   4053c:	c1 e0 12             	shl    $0x12,%eax
   4053f:	48 63 d0             	movslq %eax,%rdx
   40542:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40545:	48 63 c8             	movslq %eax,%rcx
   40548:	48 89 c8             	mov    %rcx,%rax
   4054b:	48 c1 e0 03          	shl    $0x3,%rax
   4054f:	48 29 c8             	sub    %rcx,%rax
   40552:	48 c1 e0 05          	shl    $0x5,%rax
   40556:	48 89 c1             	mov    %rax,%rcx
   40559:	48 8d 05 78 1b 01 00 	lea    0x11b78(%rip),%rax        # 520d8 <processes+0xb8>
   40560:	48 89 14 01          	mov    %rdx,(%rcx,%rax,1)
    uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
   40564:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40567:	48 63 d0             	movslq %eax,%rdx
   4056a:	48 89 d0             	mov    %rdx,%rax
   4056d:	48 c1 e0 03          	shl    $0x3,%rax
   40571:	48 29 d0             	sub    %rdx,%rax
   40574:	48 c1 e0 05          	shl    $0x5,%rax
   40578:	48 89 c2             	mov    %rax,%rdx
   4057b:	48 8d 05 56 1b 01 00 	lea    0x11b56(%rip),%rax        # 520d8 <processes+0xb8>
   40582:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   40586:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   4058c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    assign_physical_page(stack_page, pid);
   40590:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40593:	0f be d0             	movsbl %al,%edx
   40596:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4059a:	89 d6                	mov    %edx,%esi
   4059c:	48 89 c7             	mov    %rax,%rdi
   4059f:	e8 65 00 00 00       	call   40609 <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page, stack_page,
   405a4:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405a7:	48 63 d0             	movslq %eax,%rdx
   405aa:	48 89 d0             	mov    %rdx,%rax
   405ad:	48 c1 e0 03          	shl    $0x3,%rax
   405b1:	48 29 d0             	sub    %rdx,%rax
   405b4:	48 c1 e0 05          	shl    $0x5,%rax
   405b8:	48 89 c2             	mov    %rax,%rdx
   405bb:	48 8d 05 2e 1b 01 00 	lea    0x11b2e(%rip),%rax        # 520f0 <processes+0xd0>
   405c2:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   405c6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   405ca:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   405ce:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   405d4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405d9:	48 89 c7             	mov    %rax,%rdi
   405dc:	e8 92 25 00 00       	call   42b73 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   405e1:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405e4:	48 63 d0             	movslq %eax,%rdx
   405e7:	48 89 d0             	mov    %rdx,%rax
   405ea:	48 c1 e0 03          	shl    $0x3,%rax
   405ee:	48 29 d0             	sub    %rdx,%rax
   405f1:	48 c1 e0 05          	shl    $0x5,%rax
   405f5:	48 89 c2             	mov    %rax,%rdx
   405f8:	48 8d 05 e9 1a 01 00 	lea    0x11ae9(%rip),%rax        # 520e8 <processes+0xc8>
   405ff:	c7 04 02 01 00 00 00 	movl   $0x1,(%rdx,%rax,1)
}
   40606:	90                   	nop
   40607:	c9                   	leave  
   40608:	c3                   	ret    

0000000000040609 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40609:	f3 0f 1e fa          	endbr64 
   4060d:	55                   	push   %rbp
   4060e:	48 89 e5             	mov    %rsp,%rbp
   40611:	48 83 ec 10          	sub    $0x10,%rsp
   40615:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40619:	89 f0                	mov    %esi,%eax
   4061b:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   4061e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40622:	25 ff 0f 00 00       	and    $0xfff,%eax
   40627:	48 85 c0             	test   %rax,%rax
   4062a:	75 27                	jne    40653 <assign_physical_page+0x4a>
        || addr >= MEMSIZE_PHYSICAL
   4062c:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40633:	00 
   40634:	77 1d                	ja     40653 <assign_physical_page+0x4a>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40636:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4063a:	48 c1 e8 0c          	shr    $0xc,%rax
   4063e:	48 98                	cltq   
   40640:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40644:	48 8d 05 f6 27 01 00 	lea    0x127f6(%rip),%rax        # 52e41 <pageinfo+0x1>
   4064b:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4064f:	84 c0                	test   %al,%al
   40651:	74 07                	je     4065a <assign_physical_page+0x51>
        return -1;
   40653:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40658:	eb 3a                	jmp    40694 <assign_physical_page+0x8b>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   4065a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4065e:	48 c1 e8 0c          	shr    $0xc,%rax
   40662:	48 98                	cltq   
   40664:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40668:	48 8d 05 d2 27 01 00 	lea    0x127d2(%rip),%rax        # 52e41 <pageinfo+0x1>
   4066f:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40673:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40677:	48 c1 e8 0c          	shr    $0xc,%rax
   4067b:	48 98                	cltq   
   4067d:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40681:	48 8d 15 b8 27 01 00 	lea    0x127b8(%rip),%rdx        # 52e40 <pageinfo>
   40688:	0f b6 45 f4          	movzbl -0xc(%rbp),%eax
   4068c:	88 04 11             	mov    %al,(%rcx,%rdx,1)
        return 0;
   4068f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40694:	c9                   	leave  
   40695:	c3                   	ret    

0000000000040696 <syscall_mapping>:

void syscall_mapping(proc* p){
   40696:	f3 0f 1e fa          	endbr64 
   4069a:	55                   	push   %rbp
   4069b:	48 89 e5             	mov    %rsp,%rbp
   4069e:	48 83 ec 70          	sub    $0x70,%rsp
   406a2:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   406a6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406aa:	48 8b 40 38          	mov    0x38(%rax),%rax
   406ae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   406b2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406b6:	48 8b 40 30          	mov    0x30(%rax),%rax
   406ba:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   406be:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406c2:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   406c9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   406cd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   406d1:	48 89 ce             	mov    %rcx,%rsi
   406d4:	48 89 c7             	mov    %rax,%rdi
   406d7:	e8 e1 28 00 00       	call   42fbd <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   406dc:	8b 45 e0             	mov    -0x20(%rbp),%eax
   406df:	48 98                	cltq   
   406e1:	83 e0 06             	and    $0x6,%eax
   406e4:	48 83 f8 06          	cmp    $0x6,%rax
   406e8:	75 73                	jne    4075d <syscall_mapping+0xc7>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   406ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   406ee:	48 83 c0 17          	add    $0x17,%rax
   406f2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   406f6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406fa:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40701:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40705:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40709:	48 89 ce             	mov    %rcx,%rsi
   4070c:	48 89 c7             	mov    %rax,%rdi
   4070f:	e8 a9 28 00 00       	call   42fbd <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40714:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40717:	48 98                	cltq   
   40719:	83 e0 03             	and    $0x3,%eax
   4071c:	48 83 f8 03          	cmp    $0x3,%rax
   40720:	75 3e                	jne    40760 <syscall_mapping+0xca>
        return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40722:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40726:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4072d:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40731:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40735:	48 89 ce             	mov    %rcx,%rsi
   40738:	48 89 c7             	mov    %rax,%rdi
   4073b:	e8 7d 28 00 00       	call   42fbd <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40740:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40744:	48 89 c1             	mov    %rax,%rcx
   40747:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4074b:	ba 18 00 00 00       	mov    $0x18,%edx
   40750:	48 89 c6             	mov    %rax,%rsi
   40753:	48 89 cf             	mov    %rcx,%rdi
   40756:	e8 23 2c 00 00       	call   4337e <memcpy>
   4075b:	eb 04                	jmp    40761 <syscall_mapping+0xcb>
        return;
   4075d:	90                   	nop
   4075e:	eb 01                	jmp    40761 <syscall_mapping+0xcb>
        return;
   40760:	90                   	nop
}
   40761:	c9                   	leave  
   40762:	c3                   	ret    

0000000000040763 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40763:	f3 0f 1e fa          	endbr64 
   40767:	55                   	push   %rbp
   40768:	48 89 e5             	mov    %rsp,%rbp
   4076b:	48 83 ec 18          	sub    $0x18,%rsp
   4076f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40773:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40777:	48 8b 40 38          	mov    0x38(%rax),%rax
   4077b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   4077e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40782:	75 14                	jne    40798 <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   40784:	0f b6 05 75 58 00 00 	movzbl 0x5875(%rip),%eax        # 46000 <disp_global>
   4078b:	84 c0                	test   %al,%al
   4078d:	0f 94 c0             	sete   %al
   40790:	88 05 6a 58 00 00    	mov    %al,0x586a(%rip)        # 46000 <disp_global>
   40796:	eb 36                	jmp    407ce <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40798:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4079c:	78 2f                	js     407cd <syscall_mem_tog+0x6a>
   4079e:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   407a2:	7f 29                	jg     407cd <syscall_mem_tog+0x6a>
   407a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407a8:	8b 00                	mov    (%rax),%eax
   407aa:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   407ad:	75 1e                	jne    407cd <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   407af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407b3:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   407ba:	84 c0                	test   %al,%al
   407bc:	0f 94 c0             	sete   %al
   407bf:	89 c2                	mov    %eax,%edx
   407c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407c5:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   407cb:	eb 01                	jmp    407ce <syscall_mem_tog+0x6b>
            return;
   407cd:	90                   	nop
    }
}
   407ce:	c9                   	leave  
   407cf:	c3                   	ret    

00000000000407d0 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   407d0:	f3 0f 1e fa          	endbr64 
   407d4:	55                   	push   %rbp
   407d5:	48 89 e5             	mov    %rsp,%rbp
   407d8:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   407df:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   407e6:	48 8b 05 13 18 01 00 	mov    0x11813(%rip),%rax        # 52000 <current>
   407ed:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   407f4:	48 83 c0 08          	add    $0x8,%rax
   407f8:	48 89 d6             	mov    %rdx,%rsi
   407fb:	ba 18 00 00 00       	mov    $0x18,%edx
   40800:	48 89 c7             	mov    %rax,%rdi
   40803:	48 89 d1             	mov    %rdx,%rcx
   40806:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40809:	48 8b 05 f0 47 01 00 	mov    0x147f0(%rip),%rax        # 55000 <kernel_pagetable>
   40810:	48 89 c7             	mov    %rax,%rdi
   40813:	e8 e9 21 00 00       	call   42a01 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40818:	8b 05 de 87 07 00    	mov    0x787de(%rip),%eax        # b8ffc <cursorpos>
   4081e:	89 c7                	mov    %eax,%edi
   40820:	e8 62 18 00 00       	call   42087 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40825:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4082c:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40833:	48 83 f8 0e          	cmp    $0xe,%rax
   40837:	74 14                	je     4084d <exception+0x7d>
   40839:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40840:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40847:	48 83 f8 0d          	cmp    $0xd,%rax
   4084b:	75 16                	jne    40863 <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   4084d:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40854:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4085b:	83 e0 04             	and    $0x4,%eax
   4085e:	48 85 c0             	test   %rax,%rax
   40861:	74 1a                	je     4087d <exception+0xad>
    {
        check_virtual_memory();
   40863:	e8 65 08 00 00       	call   410cd <check_virtual_memory>
        if(disp_global){
   40868:	0f b6 05 91 57 00 00 	movzbl 0x5791(%rip),%eax        # 46000 <disp_global>
   4086f:	84 c0                	test   %al,%al
   40871:	74 0a                	je     4087d <exception+0xad>
            memshow_physical();
   40873:	e8 1e 0a 00 00       	call   41296 <memshow_physical>
            memshow_virtual_animate();
   40878:	e8 bb 0d 00 00       	call   41638 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   4087d:	e8 1b 1d 00 00       	call   4259d <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40882:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40889:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40890:	48 83 e8 0e          	sub    $0xe,%rax
   40894:	48 83 f8 2a          	cmp    $0x2a,%rax
   40898:	0f 87 e2 02 00 00    	ja     40b80 <exception+0x3b0>
   4089e:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   408a5:	00 
   408a6:	48 8d 05 a3 3c 00 00 	lea    0x3ca3(%rip),%rax        # 44550 <console_clear+0x117>
   408ad:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   408b0:	48 98                	cltq   
   408b2:	48 8d 15 97 3c 00 00 	lea    0x3c97(%rip),%rdx        # 44550 <console_clear+0x117>
   408b9:	48 01 d0             	add    %rdx,%rax
   408bc:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   408bf:	48 8b 05 3a 17 01 00 	mov    0x1173a(%rip),%rax        # 52000 <current>
   408c6:	48 8b 40 38          	mov    0x38(%rax),%rax
   408ca:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		if((void *)addr == NULL)
   408ce:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   408d3:	75 0f                	jne    408e4 <exception+0x114>
		    panic(NULL);
   408d5:	bf 00 00 00 00       	mov    $0x0,%edi
   408da:	b8 00 00 00 00       	mov    $0x0,%eax
   408df:	e8 1b 1e 00 00       	call   426ff <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   408e4:	48 8b 05 15 17 01 00 	mov    0x11715(%rip),%rax        # 52000 <current>
   408eb:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   408f2:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   408f6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   408fa:	48 89 ce             	mov    %rcx,%rsi
   408fd:	48 89 c7             	mov    %rax,%rdi
   40900:	e8 b8 26 00 00       	call   42fbd <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40905:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40909:	48 89 c1             	mov    %rax,%rcx
   4090c:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   40913:	ba a0 00 00 00       	mov    $0xa0,%edx
   40918:	48 89 ce             	mov    %rcx,%rsi
   4091b:	48 89 c7             	mov    %rax,%rdi
   4091e:	e8 5b 2a 00 00       	call   4337e <memcpy>
		panic(msg);
   40923:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   4092a:	48 89 c7             	mov    %rax,%rdi
   4092d:	b8 00 00 00 00       	mov    $0x0,%eax
   40932:	e8 c8 1d 00 00       	call   426ff <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40937:	48 8b 05 c2 16 01 00 	mov    0x116c2(%rip),%rax        # 52000 <current>
   4093e:	8b 10                	mov    (%rax),%edx
   40940:	48 8b 05 b9 16 01 00 	mov    0x116b9(%rip),%rax        # 52000 <current>
   40947:	48 63 d2             	movslq %edx,%rdx
   4094a:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   4094e:	e9 3d 02 00 00       	jmp    40b90 <exception+0x3c0>

    case INT_SYS_YIELD:
        schedule();
   40953:	e8 61 02 00 00       	call   40bb9 <schedule>
        break;                  /* will not be reached */
   40958:	e9 33 02 00 00       	jmp    40b90 <exception+0x3c0>

    case INT_SYS_PAGE_ALLOC: {    
        uintptr_t addr = current->p_registers.reg_rdi;
   4095d:	48 8b 05 9c 16 01 00 	mov    0x1169c(%rip),%rax        # 52000 <current>
   40964:	48 8b 40 38          	mov    0x38(%rax),%rax
   40968:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        // check if address is page aligned
        if(addr % PAGESIZE != 0){
   4096c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40970:	25 ff 0f 00 00       	and    $0xfff,%eax
   40975:	48 85 c0             	test   %rax,%rax
   40978:	74 14                	je     4098e <exception+0x1be>
            current->p_registers.reg_rax = -1;
   4097a:	48 8b 05 7f 16 01 00 	mov    0x1167f(%rip),%rax        # 52000 <current>
   40981:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40988:	ff 
            break;
   40989:	e9 02 02 00 00       	jmp    40b90 <exception+0x3c0>
        }
        // check that we are within 
        if(addr >= MEMSIZE_VIRTUAL || addr < PROC_START_ADDR){  
   4098e:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40995:	00 
   40996:	77 0a                	ja     409a2 <exception+0x1d2>
   40998:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   4099f:	00 
   409a0:	77 14                	ja     409b6 <exception+0x1e6>
            current->p_registers.reg_rax = -1;
   409a2:	48 8b 05 57 16 01 00 	mov    0x11657(%rip),%rax        # 52000 <current>
   409a9:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   409b0:	ff 
            break;
   409b1:	e9 da 01 00 00       	jmp    40b90 <exception+0x3c0>
        }
        int r = assign_physical_page(addr, current->p_pid);
   409b6:	48 8b 05 43 16 01 00 	mov    0x11643(%rip),%rax        # 52000 <current>
   409bd:	8b 00                	mov    (%rax),%eax
   409bf:	0f be d0             	movsbl %al,%edx
   409c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409c6:	89 d6                	mov    %edx,%esi
   409c8:	48 89 c7             	mov    %rax,%rdi
   409cb:	e8 39 fc ff ff       	call   40609 <assign_physical_page>
   409d0:	89 45 f4             	mov    %eax,-0xc(%rbp)
        // if page was already allocated
        if(r < 0){
   409d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   409d7:	79 14                	jns    409ed <exception+0x21d>
            current->p_registers.reg_rax = -1;
   409d9:	48 8b 05 20 16 01 00 	mov    0x11620(%rip),%rax        # 52000 <current>
   409e0:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   409e7:	ff 
            break;
   409e8:	e9 a3 01 00 00       	jmp    40b90 <exception+0x3c0>
        }
        // map the page
        if (r >= 0) {
   409ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   409f1:	78 29                	js     40a1c <exception+0x24c>
            virtual_memory_map(current->p_pagetable, addr, addr,
   409f3:	48 8b 05 06 16 01 00 	mov    0x11606(%rip),%rax        # 52000 <current>
   409fa:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40a01:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40a05:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40a09:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40a0f:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40a14:	48 89 c7             	mov    %rax,%rdi
   40a17:	e8 57 21 00 00       	call   42b73 <virtual_memory_map>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
        current->p_registers.reg_rax = r;
   40a1c:	48 8b 05 dd 15 01 00 	mov    0x115dd(%rip),%rax        # 52000 <current>
   40a23:	8b 55 f4             	mov    -0xc(%rbp),%edx
   40a26:	48 63 d2             	movslq %edx,%rdx
   40a29:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40a2d:	e9 5e 01 00 00       	jmp    40b90 <exception+0x3c0>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40a32:	48 8b 05 c7 15 01 00 	mov    0x115c7(%rip),%rax        # 52000 <current>
   40a39:	48 89 c7             	mov    %rax,%rdi
   40a3c:	e8 55 fc ff ff       	call   40696 <syscall_mapping>
            break;
   40a41:	e9 4a 01 00 00       	jmp    40b90 <exception+0x3c0>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40a46:	48 8b 05 b3 15 01 00 	mov    0x115b3(%rip),%rax        # 52000 <current>
   40a4d:	48 89 c7             	mov    %rax,%rdi
   40a50:	e8 0e fd ff ff       	call   40763 <syscall_mem_tog>
	    break;
   40a55:	e9 36 01 00 00       	jmp    40b90 <exception+0x3c0>
	}

    case INT_TIMER:
        ++ticks;
   40a5a:	8b 05 c0 23 01 00    	mov    0x123c0(%rip),%eax        # 52e20 <ticks>
   40a60:	83 c0 01             	add    $0x1,%eax
   40a63:	89 05 b7 23 01 00    	mov    %eax,0x123b7(%rip)        # 52e20 <ticks>
        schedule();
   40a69:	e8 4b 01 00 00       	call   40bb9 <schedule>
        break;                  /* will not be reached */
   40a6e:	e9 1d 01 00 00       	jmp    40b90 <exception+0x3c0>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40a73:	0f 20 d0             	mov    %cr2,%rax
   40a76:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   40a7a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40a7e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40a82:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a89:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a90:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40a93:	48 85 c0             	test   %rax,%rax
   40a96:	74 09                	je     40aa1 <exception+0x2d1>
   40a98:	48 8d 05 25 3a 00 00 	lea    0x3a25(%rip),%rax        # 444c4 <console_clear+0x8b>
   40a9f:	eb 07                	jmp    40aa8 <exception+0x2d8>
   40aa1:	48 8d 05 22 3a 00 00 	lea    0x3a22(%rip),%rax        # 444ca <console_clear+0x91>
        const char* operation = reg->reg_err & PFERR_WRITE
   40aa8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40aac:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40ab3:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40aba:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40abd:	48 85 c0             	test   %rax,%rax
   40ac0:	74 09                	je     40acb <exception+0x2fb>
   40ac2:	48 8d 05 06 3a 00 00 	lea    0x3a06(%rip),%rax        # 444cf <console_clear+0x96>
   40ac9:	eb 07                	jmp    40ad2 <exception+0x302>
   40acb:	48 8d 05 10 3a 00 00 	lea    0x3a10(%rip),%rax        # 444e2 <console_clear+0xa9>
        const char* problem = reg->reg_err & PFERR_PRESENT
   40ad2:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40ad6:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40add:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ae4:	83 e0 04             	and    $0x4,%eax
   40ae7:	48 85 c0             	test   %rax,%rax
   40aea:	75 34                	jne    40b20 <exception+0x350>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40aec:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40af3:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40afa:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40afe:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40b02:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40b06:	49 89 f0             	mov    %rsi,%r8
   40b09:	48 89 c6             	mov    %rax,%rsi
   40b0c:	48 8d 05 dd 39 00 00 	lea    0x39dd(%rip),%rax        # 444f0 <console_clear+0xb7>
   40b13:	48 89 c7             	mov    %rax,%rdi
   40b16:	b8 00 00 00 00       	mov    $0x0,%eax
   40b1b:	e8 df 1b 00 00       	call   426ff <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40b20:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40b27:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40b2e:	48 8b 05 cb 14 01 00 	mov    0x114cb(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40b35:	8b 00                	mov    (%rax),%eax
   40b37:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40b3b:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   40b3f:	52                   	push   %rdx
   40b40:	ff 75 d0             	push   -0x30(%rbp)
   40b43:	49 89 f1             	mov    %rsi,%r9
   40b46:	49 89 c8             	mov    %rcx,%r8
   40b49:	89 c1                	mov    %eax,%ecx
   40b4b:	48 8d 05 ce 39 00 00 	lea    0x39ce(%rip),%rax        # 44520 <console_clear+0xe7>
   40b52:	48 89 c2             	mov    %rax,%rdx
   40b55:	be 00 0c 00 00       	mov    $0xc00,%esi
   40b5a:	bf 80 07 00 00       	mov    $0x780,%edi
   40b5f:	b8 00 00 00 00       	mov    $0x0,%eax
   40b64:	e8 5a 37 00 00       	call   442c3 <console_printf>
   40b69:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40b6d:	48 8b 05 8c 14 01 00 	mov    0x1148c(%rip),%rax        # 52000 <current>
   40b74:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40b7b:	00 00 00 
        break;
   40b7e:	eb 10                	jmp    40b90 <exception+0x3c0>
    }

    default:
        default_exception(current);
   40b80:	48 8b 05 79 14 01 00 	mov    0x11479(%rip),%rax        # 52000 <current>
   40b87:	48 89 c7             	mov    %rax,%rdi
   40b8a:	e8 99 1c 00 00       	call   42828 <default_exception>
        break;                  /* will not be reached */
   40b8f:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40b90:	48 8b 05 69 14 01 00 	mov    0x11469(%rip),%rax        # 52000 <current>
   40b97:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40b9d:	83 f8 01             	cmp    $0x1,%eax
   40ba0:	75 0f                	jne    40bb1 <exception+0x3e1>
        run(current);
   40ba2:	48 8b 05 57 14 01 00 	mov    0x11457(%rip),%rax        # 52000 <current>
   40ba9:	48 89 c7             	mov    %rax,%rdi
   40bac:	e8 87 00 00 00       	call   40c38 <run>
    } else {
        schedule();
   40bb1:	e8 03 00 00 00       	call   40bb9 <schedule>
    }
}
   40bb6:	90                   	nop
   40bb7:	c9                   	leave  
   40bb8:	c3                   	ret    

0000000000040bb9 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40bb9:	f3 0f 1e fa          	endbr64 
   40bbd:	55                   	push   %rbp
   40bbe:	48 89 e5             	mov    %rsp,%rbp
   40bc1:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40bc5:	48 8b 05 34 14 01 00 	mov    0x11434(%rip),%rax        # 52000 <current>
   40bcc:	8b 00                	mov    (%rax),%eax
   40bce:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40bd1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bd4:	83 c0 01             	add    $0x1,%eax
   40bd7:	99                   	cltd   
   40bd8:	c1 ea 1c             	shr    $0x1c,%edx
   40bdb:	01 d0                	add    %edx,%eax
   40bdd:	83 e0 0f             	and    $0xf,%eax
   40be0:	29 d0                	sub    %edx,%eax
   40be2:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40be5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40be8:	48 63 d0             	movslq %eax,%rdx
   40beb:	48 89 d0             	mov    %rdx,%rax
   40bee:	48 c1 e0 03          	shl    $0x3,%rax
   40bf2:	48 29 d0             	sub    %rdx,%rax
   40bf5:	48 c1 e0 05          	shl    $0x5,%rax
   40bf9:	48 89 c2             	mov    %rax,%rdx
   40bfc:	48 8d 05 e5 14 01 00 	lea    0x114e5(%rip),%rax        # 520e8 <processes+0xc8>
   40c03:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40c06:	83 f8 01             	cmp    $0x1,%eax
   40c09:	75 26                	jne    40c31 <schedule+0x78>
            run(&processes[pid]);
   40c0b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c0e:	48 63 d0             	movslq %eax,%rdx
   40c11:	48 89 d0             	mov    %rdx,%rax
   40c14:	48 c1 e0 03          	shl    $0x3,%rax
   40c18:	48 29 d0             	sub    %rdx,%rax
   40c1b:	48 c1 e0 05          	shl    $0x5,%rax
   40c1f:	48 8d 15 fa 13 01 00 	lea    0x113fa(%rip),%rdx        # 52020 <processes>
   40c26:	48 01 d0             	add    %rdx,%rax
   40c29:	48 89 c7             	mov    %rax,%rdi
   40c2c:	e8 07 00 00 00       	call   40c38 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40c31:	e8 67 19 00 00       	call   4259d <check_keyboard>
        pid = (pid + 1) % NPROC;
   40c36:	eb 99                	jmp    40bd1 <schedule+0x18>

0000000000040c38 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40c38:	f3 0f 1e fa          	endbr64 
   40c3c:	55                   	push   %rbp
   40c3d:	48 89 e5             	mov    %rsp,%rbp
   40c40:	48 83 ec 10          	sub    $0x10,%rsp
   40c44:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40c48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c4c:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40c52:	83 f8 01             	cmp    $0x1,%eax
   40c55:	74 1e                	je     40c75 <run+0x3d>
   40c57:	48 8d 05 9e 39 00 00 	lea    0x399e(%rip),%rax        # 445fc <console_clear+0x1c3>
   40c5e:	48 89 c2             	mov    %rax,%rdx
   40c61:	be 81 01 00 00       	mov    $0x181,%esi
   40c66:	48 8d 05 40 38 00 00 	lea    0x3840(%rip),%rax        # 444ad <console_clear+0x74>
   40c6d:	48 89 c7             	mov    %rax,%rdi
   40c70:	e8 7a 1b 00 00       	call   427ef <assert_fail>
    current = p;
   40c75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c79:	48 89 05 80 13 01 00 	mov    %rax,0x11380(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40c80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c84:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40c8b:	48 89 c7             	mov    %rax,%rdi
   40c8e:	e8 6e 1d 00 00       	call   42a01 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40c93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c97:	48 83 c0 08          	add    $0x8,%rax
   40c9b:	48 89 c7             	mov    %rax,%rdi
   40c9e:	e8 20 f4 ff ff       	call   400c3 <exception_return>

0000000000040ca3 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40ca3:	f3 0f 1e fa          	endbr64 
   40ca7:	55                   	push   %rbp
   40ca8:	48 89 e5             	mov    %rsp,%rbp
   40cab:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40caf:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40cb6:	00 
   40cb7:	e9 93 00 00 00       	jmp    40d4f <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40cbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cc0:	48 89 c7             	mov    %rax,%rdi
   40cc3:	e8 0f 11 00 00       	call   41dd7 <physical_memory_isreserved>
   40cc8:	85 c0                	test   %eax,%eax
   40cca:	74 09                	je     40cd5 <pageinfo_init+0x32>
            owner = PO_RESERVED;
   40ccc:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40cd3:	eb 31                	jmp    40d06 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40cd5:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40cdc:	00 
   40cdd:	76 0d                	jbe    40cec <pageinfo_init+0x49>
   40cdf:	48 8d 05 22 a3 01 00 	lea    0x1a322(%rip),%rax        # 5b008 <end>
   40ce6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40cea:	72 0a                	jb     40cf6 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40cec:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40cf3:	00 
   40cf4:	75 09                	jne    40cff <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   40cf6:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40cfd:	eb 07                	jmp    40d06 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   40cff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40d06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d0a:	48 c1 e8 0c          	shr    $0xc,%rax
   40d0e:	89 c2                	mov    %eax,%edx
   40d10:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40d13:	89 c1                	mov    %eax,%ecx
   40d15:	48 63 c2             	movslq %edx,%rax
   40d18:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40d1c:	48 8d 05 1d 21 01 00 	lea    0x1211d(%rip),%rax        # 52e40 <pageinfo>
   40d23:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40d26:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40d2a:	0f 95 c2             	setne  %dl
   40d2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d31:	48 c1 e8 0c          	shr    $0xc,%rax
   40d35:	89 d1                	mov    %edx,%ecx
   40d37:	48 98                	cltq   
   40d39:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40d3d:	48 8d 05 fd 20 01 00 	lea    0x120fd(%rip),%rax        # 52e41 <pageinfo+0x1>
   40d44:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d47:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d4e:	00 
   40d4f:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40d56:	00 
   40d57:	0f 86 5f ff ff ff    	jbe    40cbc <pageinfo_init+0x19>
    }
}
   40d5d:	90                   	nop
   40d5e:	90                   	nop
   40d5f:	c9                   	leave  
   40d60:	c3                   	ret    

0000000000040d61 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40d61:	f3 0f 1e fa          	endbr64 
   40d65:	55                   	push   %rbp
   40d66:	48 89 e5             	mov    %rsp,%rbp
   40d69:	48 83 ec 50          	sub    $0x50,%rsp
   40d6d:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40d71:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d75:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40d7b:	48 89 c2             	mov    %rax,%rdx
   40d7e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d82:	48 39 c2             	cmp    %rax,%rdx
   40d85:	74 1e                	je     40da5 <check_page_table_mappings+0x44>
   40d87:	48 8d 05 8a 38 00 00 	lea    0x388a(%rip),%rax        # 44618 <console_clear+0x1df>
   40d8e:	48 89 c2             	mov    %rax,%rdx
   40d91:	be ab 01 00 00       	mov    $0x1ab,%esi
   40d96:	48 8d 05 10 37 00 00 	lea    0x3710(%rip),%rax        # 444ad <console_clear+0x74>
   40d9d:	48 89 c7             	mov    %rax,%rdi
   40da0:	e8 4a 1a 00 00       	call   427ef <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40da5:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40dac:	00 
   40dad:	e9 b5 00 00 00       	jmp    40e67 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40db2:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40db6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40dba:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40dbe:	48 89 ce             	mov    %rcx,%rsi
   40dc1:	48 89 c7             	mov    %rax,%rdi
   40dc4:	e8 f4 21 00 00       	call   42fbd <virtual_memory_lookup>
        if (vam.pa != va) {
   40dc9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40dcd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dd1:	74 2c                	je     40dff <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40dd3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40dd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ddb:	49 89 d0             	mov    %rdx,%r8
   40dde:	48 89 c1             	mov    %rax,%rcx
   40de1:	48 8d 05 4f 38 00 00 	lea    0x384f(%rip),%rax        # 44637 <console_clear+0x1fe>
   40de8:	48 89 c2             	mov    %rax,%rdx
   40deb:	be 00 c0 00 00       	mov    $0xc000,%esi
   40df0:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40df5:	b8 00 00 00 00       	mov    $0x0,%eax
   40dfa:	e8 c4 34 00 00       	call   442c3 <console_printf>
        }
        assert(vam.pa == va);
   40dff:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e03:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e07:	74 1e                	je     40e27 <check_page_table_mappings+0xc6>
   40e09:	48 8d 05 31 38 00 00 	lea    0x3831(%rip),%rax        # 44641 <console_clear+0x208>
   40e10:	48 89 c2             	mov    %rax,%rdx
   40e13:	be b4 01 00 00       	mov    $0x1b4,%esi
   40e18:	48 8d 05 8e 36 00 00 	lea    0x368e(%rip),%rax        # 444ad <console_clear+0x74>
   40e1f:	48 89 c7             	mov    %rax,%rdi
   40e22:	e8 c8 19 00 00       	call   427ef <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40e27:	48 8d 05 d2 51 00 00 	lea    0x51d2(%rip),%rax        # 46000 <disp_global>
   40e2e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e32:	72 2b                	jb     40e5f <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   40e34:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40e37:	48 98                	cltq   
   40e39:	83 e0 02             	and    $0x2,%eax
   40e3c:	48 85 c0             	test   %rax,%rax
   40e3f:	75 1e                	jne    40e5f <check_page_table_mappings+0xfe>
   40e41:	48 8d 05 06 38 00 00 	lea    0x3806(%rip),%rax        # 4464e <console_clear+0x215>
   40e48:	48 89 c2             	mov    %rax,%rdx
   40e4b:	be b6 01 00 00       	mov    $0x1b6,%esi
   40e50:	48 8d 05 56 36 00 00 	lea    0x3656(%rip),%rax        # 444ad <console_clear+0x74>
   40e57:	48 89 c7             	mov    %rax,%rdi
   40e5a:	e8 90 19 00 00       	call   427ef <assert_fail>
         va += PAGESIZE) {
   40e5f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e66:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e67:	48 8d 05 9a a1 01 00 	lea    0x1a19a(%rip),%rax        # 5b008 <end>
   40e6e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e72:	0f 82 3a ff ff ff    	jb     40db2 <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40e78:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40e7f:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40e80:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40e84:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40e88:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e8c:	48 89 ce             	mov    %rcx,%rsi
   40e8f:	48 89 c7             	mov    %rax,%rdi
   40e92:	e8 26 21 00 00       	call   42fbd <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40e97:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e9b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40e9f:	74 1e                	je     40ebf <check_page_table_mappings+0x15e>
   40ea1:	48 8d 05 b7 37 00 00 	lea    0x37b7(%rip),%rax        # 4465f <console_clear+0x226>
   40ea8:	48 89 c2             	mov    %rax,%rdx
   40eab:	be bd 01 00 00       	mov    $0x1bd,%esi
   40eb0:	48 8d 05 f6 35 00 00 	lea    0x35f6(%rip),%rax        # 444ad <console_clear+0x74>
   40eb7:	48 89 c7             	mov    %rax,%rdi
   40eba:	e8 30 19 00 00       	call   427ef <assert_fail>
    assert(vam.perm & PTE_W);
   40ebf:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40ec2:	48 98                	cltq   
   40ec4:	83 e0 02             	and    $0x2,%eax
   40ec7:	48 85 c0             	test   %rax,%rax
   40eca:	75 1e                	jne    40eea <check_page_table_mappings+0x189>
   40ecc:	48 8d 05 7b 37 00 00 	lea    0x377b(%rip),%rax        # 4464e <console_clear+0x215>
   40ed3:	48 89 c2             	mov    %rax,%rdx
   40ed6:	be be 01 00 00       	mov    $0x1be,%esi
   40edb:	48 8d 05 cb 35 00 00 	lea    0x35cb(%rip),%rax        # 444ad <console_clear+0x74>
   40ee2:	48 89 c7             	mov    %rax,%rdi
   40ee5:	e8 05 19 00 00       	call   427ef <assert_fail>
}
   40eea:	90                   	nop
   40eeb:	c9                   	leave  
   40eec:	c3                   	ret    

0000000000040eed <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40eed:	f3 0f 1e fa          	endbr64 
   40ef1:	55                   	push   %rbp
   40ef2:	48 89 e5             	mov    %rsp,%rbp
   40ef5:	48 83 ec 20          	sub    $0x20,%rsp
   40ef9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40efd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40f00:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40f03:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40f06:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40f0d:	48 8b 05 ec 40 01 00 	mov    0x140ec(%rip),%rax        # 55000 <kernel_pagetable>
   40f14:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40f18:	75 71                	jne    40f8b <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   40f1a:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f21:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40f28:	eb 5b                	jmp    40f85 <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   40f2a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f2d:	48 63 d0             	movslq %eax,%rdx
   40f30:	48 89 d0             	mov    %rdx,%rax
   40f33:	48 c1 e0 03          	shl    $0x3,%rax
   40f37:	48 29 d0             	sub    %rdx,%rax
   40f3a:	48 c1 e0 05          	shl    $0x5,%rax
   40f3e:	48 89 c2             	mov    %rax,%rdx
   40f41:	48 8d 05 a0 11 01 00 	lea    0x111a0(%rip),%rax        # 520e8 <processes+0xc8>
   40f48:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40f4b:	85 c0                	test   %eax,%eax
   40f4d:	74 32                	je     40f81 <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40f4f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f52:	48 63 d0             	movslq %eax,%rdx
   40f55:	48 89 d0             	mov    %rdx,%rax
   40f58:	48 c1 e0 03          	shl    $0x3,%rax
   40f5c:	48 29 d0             	sub    %rdx,%rax
   40f5f:	48 c1 e0 05          	shl    $0x5,%rax
   40f63:	48 89 c2             	mov    %rax,%rdx
   40f66:	48 8d 05 83 11 01 00 	lea    0x11183(%rip),%rax        # 520f0 <processes+0xd0>
   40f6d:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   40f71:	48 8b 05 88 40 01 00 	mov    0x14088(%rip),%rax        # 55000 <kernel_pagetable>
   40f78:	48 39 c2             	cmp    %rax,%rdx
   40f7b:	75 04                	jne    40f81 <check_page_table_ownership+0x94>
                ++expected_refcount;
   40f7d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f81:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40f85:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40f89:	7e 9f                	jle    40f2a <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40f8b:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40f8e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f91:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f95:	be 00 00 00 00       	mov    $0x0,%esi
   40f9a:	48 89 c7             	mov    %rax,%rdi
   40f9d:	e8 03 00 00 00       	call   40fa5 <check_page_table_ownership_level>
}
   40fa2:	90                   	nop
   40fa3:	c9                   	leave  
   40fa4:	c3                   	ret    

0000000000040fa5 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40fa5:	f3 0f 1e fa          	endbr64 
   40fa9:	55                   	push   %rbp
   40faa:	48 89 e5             	mov    %rsp,%rbp
   40fad:	48 83 ec 30          	sub    $0x30,%rsp
   40fb1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40fb5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40fb8:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40fbb:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40fbe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fc2:	48 c1 e8 0c          	shr    $0xc,%rax
   40fc6:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40fcb:	7e 1e                	jle    40feb <check_page_table_ownership_level+0x46>
   40fcd:	48 8d 05 9c 36 00 00 	lea    0x369c(%rip),%rax        # 44670 <console_clear+0x237>
   40fd4:	48 89 c2             	mov    %rax,%rdx
   40fd7:	be db 01 00 00       	mov    $0x1db,%esi
   40fdc:	48 8d 05 ca 34 00 00 	lea    0x34ca(%rip),%rax        # 444ad <console_clear+0x74>
   40fe3:	48 89 c7             	mov    %rax,%rdi
   40fe6:	e8 04 18 00 00       	call   427ef <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40feb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fef:	48 c1 e8 0c          	shr    $0xc,%rax
   40ff3:	48 98                	cltq   
   40ff5:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40ff9:	48 8d 05 40 1e 01 00 	lea    0x11e40(%rip),%rax        # 52e40 <pageinfo>
   41000:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41004:	0f be c0             	movsbl %al,%eax
   41007:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   4100a:	74 1e                	je     4102a <check_page_table_ownership_level+0x85>
   4100c:	48 8d 05 75 36 00 00 	lea    0x3675(%rip),%rax        # 44688 <console_clear+0x24f>
   41013:	48 89 c2             	mov    %rax,%rdx
   41016:	be dc 01 00 00       	mov    $0x1dc,%esi
   4101b:	48 8d 05 8b 34 00 00 	lea    0x348b(%rip),%rax        # 444ad <console_clear+0x74>
   41022:	48 89 c7             	mov    %rax,%rdi
   41025:	e8 c5 17 00 00       	call   427ef <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   4102a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4102e:	48 c1 e8 0c          	shr    $0xc,%rax
   41032:	48 98                	cltq   
   41034:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41038:	48 8d 05 02 1e 01 00 	lea    0x11e02(%rip),%rax        # 52e41 <pageinfo+0x1>
   4103f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41043:	0f be c0             	movsbl %al,%eax
   41046:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41049:	74 1e                	je     41069 <check_page_table_ownership_level+0xc4>
   4104b:	48 8d 05 5e 36 00 00 	lea    0x365e(%rip),%rax        # 446b0 <console_clear+0x277>
   41052:	48 89 c2             	mov    %rax,%rdx
   41055:	be dd 01 00 00       	mov    $0x1dd,%esi
   4105a:	48 8d 05 4c 34 00 00 	lea    0x344c(%rip),%rax        # 444ad <console_clear+0x74>
   41061:	48 89 c7             	mov    %rax,%rdi
   41064:	e8 86 17 00 00       	call   427ef <assert_fail>
    if (level < 3) {
   41069:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   4106d:	7f 5b                	jg     410ca <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4106f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41076:	eb 49                	jmp    410c1 <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   41078:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4107c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4107f:	48 63 d2             	movslq %edx,%rdx
   41082:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41086:	48 85 c0             	test   %rax,%rax
   41089:	74 32                	je     410bd <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   4108b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4108f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41092:	48 63 d2             	movslq %edx,%rdx
   41095:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41099:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4109f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   410a3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   410a6:	8d 70 01             	lea    0x1(%rax),%esi
   410a9:	8b 55 e0             	mov    -0x20(%rbp),%edx
   410ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   410b0:	b9 01 00 00 00       	mov    $0x1,%ecx
   410b5:	48 89 c7             	mov    %rax,%rdi
   410b8:	e8 e8 fe ff ff       	call   40fa5 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   410bd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   410c1:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   410c8:	7e ae                	jle    41078 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   410ca:	90                   	nop
   410cb:	c9                   	leave  
   410cc:	c3                   	ret    

00000000000410cd <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   410cd:	f3 0f 1e fa          	endbr64 
   410d1:	55                   	push   %rbp
   410d2:	48 89 e5             	mov    %rsp,%rbp
   410d5:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   410d9:	8b 05 09 10 01 00    	mov    0x11009(%rip),%eax        # 520e8 <processes+0xc8>
   410df:	85 c0                	test   %eax,%eax
   410e1:	74 1e                	je     41101 <check_virtual_memory+0x34>
   410e3:	48 8d 05 f6 35 00 00 	lea    0x35f6(%rip),%rax        # 446e0 <console_clear+0x2a7>
   410ea:	48 89 c2             	mov    %rax,%rdx
   410ed:	be f0 01 00 00       	mov    $0x1f0,%esi
   410f2:	48 8d 05 b4 33 00 00 	lea    0x33b4(%rip),%rax        # 444ad <console_clear+0x74>
   410f9:	48 89 c7             	mov    %rax,%rdi
   410fc:	e8 ee 16 00 00       	call   427ef <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41101:	48 8b 05 f8 3e 01 00 	mov    0x13ef8(%rip),%rax        # 55000 <kernel_pagetable>
   41108:	48 89 c7             	mov    %rax,%rdi
   4110b:	e8 51 fc ff ff       	call   40d61 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41110:	48 8b 05 e9 3e 01 00 	mov    0x13ee9(%rip),%rax        # 55000 <kernel_pagetable>
   41117:	be ff ff ff ff       	mov    $0xffffffff,%esi
   4111c:	48 89 c7             	mov    %rax,%rdi
   4111f:	e8 c9 fd ff ff       	call   40eed <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41124:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4112b:	e9 b4 00 00 00       	jmp    411e4 <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   41130:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41133:	48 63 d0             	movslq %eax,%rdx
   41136:	48 89 d0             	mov    %rdx,%rax
   41139:	48 c1 e0 03          	shl    $0x3,%rax
   4113d:	48 29 d0             	sub    %rdx,%rax
   41140:	48 c1 e0 05          	shl    $0x5,%rax
   41144:	48 89 c2             	mov    %rax,%rdx
   41147:	48 8d 05 9a 0f 01 00 	lea    0x10f9a(%rip),%rax        # 520e8 <processes+0xc8>
   4114e:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41151:	85 c0                	test   %eax,%eax
   41153:	0f 84 87 00 00 00    	je     411e0 <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41159:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4115c:	48 63 d0             	movslq %eax,%rdx
   4115f:	48 89 d0             	mov    %rdx,%rax
   41162:	48 c1 e0 03          	shl    $0x3,%rax
   41166:	48 29 d0             	sub    %rdx,%rax
   41169:	48 c1 e0 05          	shl    $0x5,%rax
   4116d:	48 89 c2             	mov    %rax,%rdx
   41170:	48 8d 05 79 0f 01 00 	lea    0x10f79(%rip),%rax        # 520f0 <processes+0xd0>
   41177:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   4117b:	48 8b 05 7e 3e 01 00 	mov    0x13e7e(%rip),%rax        # 55000 <kernel_pagetable>
   41182:	48 39 c2             	cmp    %rax,%rdx
   41185:	74 59                	je     411e0 <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   41187:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4118a:	48 63 d0             	movslq %eax,%rdx
   4118d:	48 89 d0             	mov    %rdx,%rax
   41190:	48 c1 e0 03          	shl    $0x3,%rax
   41194:	48 29 d0             	sub    %rdx,%rax
   41197:	48 c1 e0 05          	shl    $0x5,%rax
   4119b:	48 89 c2             	mov    %rax,%rdx
   4119e:	48 8d 05 4b 0f 01 00 	lea    0x10f4b(%rip),%rax        # 520f0 <processes+0xd0>
   411a5:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   411a9:	48 89 c7             	mov    %rax,%rdi
   411ac:	e8 b0 fb ff ff       	call   40d61 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   411b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411b4:	48 63 d0             	movslq %eax,%rdx
   411b7:	48 89 d0             	mov    %rdx,%rax
   411ba:	48 c1 e0 03          	shl    $0x3,%rax
   411be:	48 29 d0             	sub    %rdx,%rax
   411c1:	48 c1 e0 05          	shl    $0x5,%rax
   411c5:	48 89 c2             	mov    %rax,%rdx
   411c8:	48 8d 05 21 0f 01 00 	lea    0x10f21(%rip),%rax        # 520f0 <processes+0xd0>
   411cf:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   411d3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411d6:	89 d6                	mov    %edx,%esi
   411d8:	48 89 c7             	mov    %rax,%rdi
   411db:	e8 0d fd ff ff       	call   40eed <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   411e0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411e4:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   411e8:	0f 8e 42 ff ff ff    	jle    41130 <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   411f5:	e9 8b 00 00 00       	jmp    41285 <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   411fa:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411fd:	48 98                	cltq   
   411ff:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41203:	48 8d 05 37 1c 01 00 	lea    0x11c37(%rip),%rax        # 52e41 <pageinfo+0x1>
   4120a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4120e:	84 c0                	test   %al,%al
   41210:	7e 6f                	jle    41281 <check_virtual_memory+0x1b4>
   41212:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41215:	48 98                	cltq   
   41217:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4121b:	48 8d 05 1e 1c 01 00 	lea    0x11c1e(%rip),%rax        # 52e40 <pageinfo>
   41222:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41226:	84 c0                	test   %al,%al
   41228:	78 57                	js     41281 <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4122a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4122d:	48 98                	cltq   
   4122f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41233:	48 8d 05 06 1c 01 00 	lea    0x11c06(%rip),%rax        # 52e40 <pageinfo>
   4123a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4123e:	0f be c0             	movsbl %al,%eax
   41241:	48 63 d0             	movslq %eax,%rdx
   41244:	48 89 d0             	mov    %rdx,%rax
   41247:	48 c1 e0 03          	shl    $0x3,%rax
   4124b:	48 29 d0             	sub    %rdx,%rax
   4124e:	48 c1 e0 05          	shl    $0x5,%rax
   41252:	48 89 c2             	mov    %rax,%rdx
   41255:	48 8d 05 8c 0e 01 00 	lea    0x10e8c(%rip),%rax        # 520e8 <processes+0xc8>
   4125c:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4125f:	85 c0                	test   %eax,%eax
   41261:	75 1e                	jne    41281 <check_virtual_memory+0x1b4>
   41263:	48 8d 05 96 34 00 00 	lea    0x3496(%rip),%rax        # 44700 <console_clear+0x2c7>
   4126a:	48 89 c2             	mov    %rax,%rdx
   4126d:	be 07 02 00 00       	mov    $0x207,%esi
   41272:	48 8d 05 34 32 00 00 	lea    0x3234(%rip),%rax        # 444ad <console_clear+0x74>
   41279:	48 89 c7             	mov    %rax,%rdi
   4127c:	e8 6e 15 00 00       	call   427ef <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41281:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41285:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   4128c:	0f 8e 68 ff ff ff    	jle    411fa <check_virtual_memory+0x12d>
        }
    }
}
   41292:	90                   	nop
   41293:	90                   	nop
   41294:	c9                   	leave  
   41295:	c3                   	ret    

0000000000041296 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41296:	f3 0f 1e fa          	endbr64 
   4129a:	55                   	push   %rbp
   4129b:	48 89 e5             	mov    %rsp,%rbp
   4129e:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   412a2:	48 8d 05 bd 34 00 00 	lea    0x34bd(%rip),%rax        # 44766 <memstate_colors+0x26>
   412a9:	48 89 c2             	mov    %rax,%rdx
   412ac:	be 00 0f 00 00       	mov    $0xf00,%esi
   412b1:	bf 20 00 00 00       	mov    $0x20,%edi
   412b6:	b8 00 00 00 00       	mov    $0x0,%eax
   412bb:	e8 03 30 00 00       	call   442c3 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   412c7:	e9 1b 01 00 00       	jmp    413e7 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   412cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412cf:	83 e0 3f             	and    $0x3f,%eax
   412d2:	85 c0                	test   %eax,%eax
   412d4:	75 40                	jne    41316 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   412d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412d9:	c1 e0 0c             	shl    $0xc,%eax
   412dc:	89 c2                	mov    %eax,%edx
   412de:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412e1:	8d 48 3f             	lea    0x3f(%rax),%ecx
   412e4:	85 c0                	test   %eax,%eax
   412e6:	0f 48 c1             	cmovs  %ecx,%eax
   412e9:	c1 f8 06             	sar    $0x6,%eax
   412ec:	8d 48 01             	lea    0x1(%rax),%ecx
   412ef:	89 c8                	mov    %ecx,%eax
   412f1:	c1 e0 02             	shl    $0x2,%eax
   412f4:	01 c8                	add    %ecx,%eax
   412f6:	c1 e0 04             	shl    $0x4,%eax
   412f9:	83 c0 03             	add    $0x3,%eax
   412fc:	89 d1                	mov    %edx,%ecx
   412fe:	48 8d 15 71 34 00 00 	lea    0x3471(%rip),%rdx        # 44776 <memstate_colors+0x36>
   41305:	be 00 0f 00 00       	mov    $0xf00,%esi
   4130a:	89 c7                	mov    %eax,%edi
   4130c:	b8 00 00 00 00       	mov    $0x0,%eax
   41311:	e8 ad 2f 00 00       	call   442c3 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41316:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41319:	48 98                	cltq   
   4131b:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4131f:	48 8d 05 1a 1b 01 00 	lea    0x11b1a(%rip),%rax        # 52e40 <pageinfo>
   41326:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4132a:	0f be c0             	movsbl %al,%eax
   4132d:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41330:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41333:	48 98                	cltq   
   41335:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41339:	48 8d 05 01 1b 01 00 	lea    0x11b01(%rip),%rax        # 52e41 <pageinfo+0x1>
   41340:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41344:	84 c0                	test   %al,%al
   41346:	75 07                	jne    4134f <memshow_physical+0xb9>
            owner = PO_FREE;
   41348:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4134f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41352:	83 c0 02             	add    $0x2,%eax
   41355:	48 98                	cltq   
   41357:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4135b:	48 8d 05 de 33 00 00 	lea    0x33de(%rip),%rax        # 44740 <memstate_colors>
   41362:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41366:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   4136a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4136d:	48 98                	cltq   
   4136f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41373:	48 8d 05 c7 1a 01 00 	lea    0x11ac7(%rip),%rax        # 52e41 <pageinfo+0x1>
   4137a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4137e:	3c 01                	cmp    $0x1,%al
   41380:	7e 1c                	jle    4139e <memshow_physical+0x108>
   41382:	48 8d 05 77 6c 07 00 	lea    0x76c77(%rip),%rax        # b8000 <console>
   41389:	48 c1 e8 0c          	shr    $0xc,%rax
   4138d:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41390:	74 0c                	je     4139e <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41392:	b8 53 00 00 00       	mov    $0x53,%eax
   41397:	80 cc 0f             	or     $0xf,%ah
   4139a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4139e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413a1:	8d 50 3f             	lea    0x3f(%rax),%edx
   413a4:	85 c0                	test   %eax,%eax
   413a6:	0f 48 c2             	cmovs  %edx,%eax
   413a9:	c1 f8 06             	sar    $0x6,%eax
   413ac:	8d 50 01             	lea    0x1(%rax),%edx
   413af:	89 d0                	mov    %edx,%eax
   413b1:	c1 e0 02             	shl    $0x2,%eax
   413b4:	01 d0                	add    %edx,%eax
   413b6:	c1 e0 04             	shl    $0x4,%eax
   413b9:	89 c1                	mov    %eax,%ecx
   413bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413be:	99                   	cltd   
   413bf:	c1 ea 1a             	shr    $0x1a,%edx
   413c2:	01 d0                	add    %edx,%eax
   413c4:	83 e0 3f             	and    $0x3f,%eax
   413c7:	29 d0                	sub    %edx,%eax
   413c9:	83 c0 0c             	add    $0xc,%eax
   413cc:	01 c8                	add    %ecx,%eax
   413ce:	48 98                	cltq   
   413d0:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   413d4:	48 8d 15 25 6c 07 00 	lea    0x76c25(%rip),%rdx        # b8000 <console>
   413db:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413df:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413e3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   413e7:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   413ee:	0f 8e d8 fe ff ff    	jle    412cc <memshow_physical+0x36>
    }
}
   413f4:	90                   	nop
   413f5:	90                   	nop
   413f6:	c9                   	leave  
   413f7:	c3                   	ret    

00000000000413f8 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   413f8:	f3 0f 1e fa          	endbr64 
   413fc:	55                   	push   %rbp
   413fd:	48 89 e5             	mov    %rsp,%rbp
   41400:	48 83 ec 40          	sub    $0x40,%rsp
   41404:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41408:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   4140c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41410:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41416:	48 89 c2             	mov    %rax,%rdx
   41419:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4141d:	48 39 c2             	cmp    %rax,%rdx
   41420:	74 1e                	je     41440 <memshow_virtual+0x48>
   41422:	48 8d 05 57 33 00 00 	lea    0x3357(%rip),%rax        # 44780 <memstate_colors+0x40>
   41429:	48 89 c2             	mov    %rax,%rdx
   4142c:	be 38 02 00 00       	mov    $0x238,%esi
   41431:	48 8d 05 75 30 00 00 	lea    0x3075(%rip),%rax        # 444ad <console_clear+0x74>
   41438:	48 89 c7             	mov    %rax,%rdi
   4143b:	e8 af 13 00 00       	call   427ef <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41440:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41444:	48 89 c1             	mov    %rax,%rcx
   41447:	48 8d 05 5f 33 00 00 	lea    0x335f(%rip),%rax        # 447ad <memstate_colors+0x6d>
   4144e:	48 89 c2             	mov    %rax,%rdx
   41451:	be 00 0f 00 00       	mov    $0xf00,%esi
   41456:	bf 3a 03 00 00       	mov    $0x33a,%edi
   4145b:	b8 00 00 00 00       	mov    $0x0,%eax
   41460:	e8 5e 2e 00 00       	call   442c3 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41465:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4146c:	00 
   4146d:	e9 b4 01 00 00       	jmp    41626 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41472:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41476:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4147a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4147e:	48 89 ce             	mov    %rcx,%rsi
   41481:	48 89 c7             	mov    %rax,%rdi
   41484:	e8 34 1b 00 00       	call   42fbd <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41489:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4148c:	85 c0                	test   %eax,%eax
   4148e:	79 0b                	jns    4149b <memshow_virtual+0xa3>
            color = ' ';
   41490:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41496:	e9 ff 00 00 00       	jmp    4159a <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   4149b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4149f:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   414a5:	76 1e                	jbe    414c5 <memshow_virtual+0xcd>
   414a7:	48 8d 05 1c 33 00 00 	lea    0x331c(%rip),%rax        # 447ca <memstate_colors+0x8a>
   414ae:	48 89 c2             	mov    %rax,%rdx
   414b1:	be 41 02 00 00       	mov    $0x241,%esi
   414b6:	48 8d 05 f0 2f 00 00 	lea    0x2ff0(%rip),%rax        # 444ad <console_clear+0x74>
   414bd:	48 89 c7             	mov    %rax,%rdi
   414c0:	e8 2a 13 00 00       	call   427ef <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   414c5:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414c8:	48 98                	cltq   
   414ca:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   414ce:	48 8d 05 6b 19 01 00 	lea    0x1196b(%rip),%rax        # 52e40 <pageinfo>
   414d5:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   414d9:	0f be c0             	movsbl %al,%eax
   414dc:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   414df:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414e2:	48 98                	cltq   
   414e4:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   414e8:	48 8d 05 52 19 01 00 	lea    0x11952(%rip),%rax        # 52e41 <pageinfo+0x1>
   414ef:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   414f3:	84 c0                	test   %al,%al
   414f5:	75 07                	jne    414fe <memshow_virtual+0x106>
                owner = PO_FREE;
   414f7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   414fe:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41501:	83 c0 02             	add    $0x2,%eax
   41504:	48 98                	cltq   
   41506:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4150a:	48 8d 05 2f 32 00 00 	lea    0x322f(%rip),%rax        # 44740 <memstate_colors>
   41511:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41515:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41519:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4151c:	48 98                	cltq   
   4151e:	83 e0 04             	and    $0x4,%eax
   41521:	48 85 c0             	test   %rax,%rax
   41524:	74 27                	je     4154d <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41526:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4152a:	c1 e0 04             	shl    $0x4,%eax
   4152d:	66 25 00 f0          	and    $0xf000,%ax
   41531:	89 c2                	mov    %eax,%edx
   41533:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41537:	c1 f8 04             	sar    $0x4,%eax
   4153a:	66 25 00 0f          	and    $0xf00,%ax
   4153e:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41540:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41544:	0f b6 c0             	movzbl %al,%eax
   41547:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41549:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   4154d:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41550:	48 98                	cltq   
   41552:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41556:	48 8d 05 e4 18 01 00 	lea    0x118e4(%rip),%rax        # 52e41 <pageinfo+0x1>
   4155d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41561:	3c 01                	cmp    $0x1,%al
   41563:	7e 35                	jle    4159a <memshow_virtual+0x1a2>
   41565:	48 8d 05 94 6a 07 00 	lea    0x76a94(%rip),%rax        # b8000 <console>
   4156c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41570:	74 28                	je     4159a <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41572:	b8 53 00 00 00       	mov    $0x53,%eax
   41577:	89 c2                	mov    %eax,%edx
   41579:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4157d:	66 25 00 f0          	and    $0xf000,%ax
   41581:	09 d0                	or     %edx,%eax
   41583:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41587:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4158a:	48 98                	cltq   
   4158c:	83 e0 04             	and    $0x4,%eax
   4158f:	48 85 c0             	test   %rax,%rax
   41592:	75 06                	jne    4159a <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   41594:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4159a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4159e:	48 c1 e8 0c          	shr    $0xc,%rax
   415a2:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   415a5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415a8:	83 e0 3f             	and    $0x3f,%eax
   415ab:	85 c0                	test   %eax,%eax
   415ad:	75 39                	jne    415e8 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   415af:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415b2:	c1 e8 06             	shr    $0x6,%eax
   415b5:	89 c2                	mov    %eax,%edx
   415b7:	89 d0                	mov    %edx,%eax
   415b9:	c1 e0 02             	shl    $0x2,%eax
   415bc:	01 d0                	add    %edx,%eax
   415be:	c1 e0 04             	shl    $0x4,%eax
   415c1:	05 73 03 00 00       	add    $0x373,%eax
   415c6:	89 c7                	mov    %eax,%edi
   415c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   415cc:	48 89 c1             	mov    %rax,%rcx
   415cf:	48 8d 05 a0 31 00 00 	lea    0x31a0(%rip),%rax        # 44776 <memstate_colors+0x36>
   415d6:	48 89 c2             	mov    %rax,%rdx
   415d9:	be 00 0f 00 00       	mov    $0xf00,%esi
   415de:	b8 00 00 00 00       	mov    $0x0,%eax
   415e3:	e8 db 2c 00 00       	call   442c3 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   415e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415eb:	c1 e8 06             	shr    $0x6,%eax
   415ee:	89 c2                	mov    %eax,%edx
   415f0:	89 d0                	mov    %edx,%eax
   415f2:	c1 e0 02             	shl    $0x2,%eax
   415f5:	01 d0                	add    %edx,%eax
   415f7:	c1 e0 04             	shl    $0x4,%eax
   415fa:	89 c2                	mov    %eax,%edx
   415fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415ff:	83 e0 3f             	and    $0x3f,%eax
   41602:	01 d0                	add    %edx,%eax
   41604:	05 7c 03 00 00       	add    $0x37c,%eax
   41609:	89 c0                	mov    %eax,%eax
   4160b:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4160f:	48 8d 15 ea 69 07 00 	lea    0x769ea(%rip),%rdx        # b8000 <console>
   41616:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4161a:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4161e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41625:	00 
   41626:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4162d:	00 
   4162e:	0f 86 3e fe ff ff    	jbe    41472 <memshow_virtual+0x7a>
    }
}
   41634:	90                   	nop
   41635:	90                   	nop
   41636:	c9                   	leave  
   41637:	c3                   	ret    

0000000000041638 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41638:	f3 0f 1e fa          	endbr64 
   4163c:	55                   	push   %rbp
   4163d:	48 89 e5             	mov    %rsp,%rbp
   41640:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41644:	8b 05 f6 1b 01 00    	mov    0x11bf6(%rip),%eax        # 53240 <last_ticks.1>
   4164a:	85 c0                	test   %eax,%eax
   4164c:	74 13                	je     41661 <memshow_virtual_animate+0x29>
   4164e:	8b 05 cc 17 01 00    	mov    0x117cc(%rip),%eax        # 52e20 <ticks>
   41654:	8b 15 e6 1b 01 00    	mov    0x11be6(%rip),%edx        # 53240 <last_ticks.1>
   4165a:	29 d0                	sub    %edx,%eax
   4165c:	83 f8 31             	cmp    $0x31,%eax
   4165f:	76 2c                	jbe    4168d <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   41661:	8b 05 b9 17 01 00    	mov    0x117b9(%rip),%eax        # 52e20 <ticks>
   41667:	89 05 d3 1b 01 00    	mov    %eax,0x11bd3(%rip)        # 53240 <last_ticks.1>
        ++showing;
   4166d:	8b 05 91 49 00 00    	mov    0x4991(%rip),%eax        # 46004 <showing.0>
   41673:	83 c0 01             	add    $0x1,%eax
   41676:	89 05 88 49 00 00    	mov    %eax,0x4988(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4167c:	eb 0f                	jmp    4168d <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   4167e:	8b 05 80 49 00 00    	mov    0x4980(%rip),%eax        # 46004 <showing.0>
   41684:	83 c0 01             	add    $0x1,%eax
   41687:	89 05 77 49 00 00    	mov    %eax,0x4977(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   4168d:	8b 05 71 49 00 00    	mov    0x4971(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41693:	83 f8 20             	cmp    $0x20,%eax
   41696:	7f 6b                	jg     41703 <memshow_virtual_animate+0xcb>
   41698:	8b 05 66 49 00 00    	mov    0x4966(%rip),%eax        # 46004 <showing.0>
   4169e:	99                   	cltd   
   4169f:	c1 ea 1c             	shr    $0x1c,%edx
   416a2:	01 d0                	add    %edx,%eax
   416a4:	83 e0 0f             	and    $0xf,%eax
   416a7:	29 d0                	sub    %edx,%eax
   416a9:	48 63 d0             	movslq %eax,%rdx
   416ac:	48 89 d0             	mov    %rdx,%rax
   416af:	48 c1 e0 03          	shl    $0x3,%rax
   416b3:	48 29 d0             	sub    %rdx,%rax
   416b6:	48 c1 e0 05          	shl    $0x5,%rax
   416ba:	48 89 c2             	mov    %rax,%rdx
   416bd:	48 8d 05 24 0a 01 00 	lea    0x10a24(%rip),%rax        # 520e8 <processes+0xc8>
   416c4:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   416c7:	85 c0                	test   %eax,%eax
   416c9:	74 b3                	je     4167e <memshow_virtual_animate+0x46>
   416cb:	8b 05 33 49 00 00    	mov    0x4933(%rip),%eax        # 46004 <showing.0>
   416d1:	99                   	cltd   
   416d2:	c1 ea 1c             	shr    $0x1c,%edx
   416d5:	01 d0                	add    %edx,%eax
   416d7:	83 e0 0f             	and    $0xf,%eax
   416da:	29 d0                	sub    %edx,%eax
   416dc:	48 63 d0             	movslq %eax,%rdx
   416df:	48 89 d0             	mov    %rdx,%rax
   416e2:	48 c1 e0 03          	shl    $0x3,%rax
   416e6:	48 29 d0             	sub    %rdx,%rax
   416e9:	48 c1 e0 05          	shl    $0x5,%rax
   416ed:	48 89 c2             	mov    %rax,%rdx
   416f0:	48 8d 05 01 0a 01 00 	lea    0x10a01(%rip),%rax        # 520f8 <processes+0xd8>
   416f7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   416fb:	84 c0                	test   %al,%al
   416fd:	0f 84 7b ff ff ff    	je     4167e <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   41703:	8b 05 fb 48 00 00    	mov    0x48fb(%rip),%eax        # 46004 <showing.0>
   41709:	99                   	cltd   
   4170a:	c1 ea 1c             	shr    $0x1c,%edx
   4170d:	01 d0                	add    %edx,%eax
   4170f:	83 e0 0f             	and    $0xf,%eax
   41712:	29 d0                	sub    %edx,%eax
   41714:	89 05 ea 48 00 00    	mov    %eax,0x48ea(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   4171a:	8b 05 e4 48 00 00    	mov    0x48e4(%rip),%eax        # 46004 <showing.0>
   41720:	48 63 d0             	movslq %eax,%rdx
   41723:	48 89 d0             	mov    %rdx,%rax
   41726:	48 c1 e0 03          	shl    $0x3,%rax
   4172a:	48 29 d0             	sub    %rdx,%rax
   4172d:	48 c1 e0 05          	shl    $0x5,%rax
   41731:	48 89 c2             	mov    %rax,%rdx
   41734:	48 8d 05 ad 09 01 00 	lea    0x109ad(%rip),%rax        # 520e8 <processes+0xc8>
   4173b:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4173e:	85 c0                	test   %eax,%eax
   41740:	74 59                	je     4179b <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41742:	8b 15 bc 48 00 00    	mov    0x48bc(%rip),%edx        # 46004 <showing.0>
   41748:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   4174c:	89 d1                	mov    %edx,%ecx
   4174e:	48 8d 15 8f 30 00 00 	lea    0x308f(%rip),%rdx        # 447e4 <memstate_colors+0xa4>
   41755:	be 04 00 00 00       	mov    $0x4,%esi
   4175a:	48 89 c7             	mov    %rax,%rdi
   4175d:	b8 00 00 00 00       	mov    $0x0,%eax
   41762:	e8 77 2c 00 00       	call   443de <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41767:	8b 05 97 48 00 00    	mov    0x4897(%rip),%eax        # 46004 <showing.0>
   4176d:	48 63 d0             	movslq %eax,%rdx
   41770:	48 89 d0             	mov    %rdx,%rax
   41773:	48 c1 e0 03          	shl    $0x3,%rax
   41777:	48 29 d0             	sub    %rdx,%rax
   4177a:	48 c1 e0 05          	shl    $0x5,%rax
   4177e:	48 89 c2             	mov    %rax,%rdx
   41781:	48 8d 05 68 09 01 00 	lea    0x10968(%rip),%rax        # 520f0 <processes+0xd0>
   41788:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4178c:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41790:	48 89 d6             	mov    %rdx,%rsi
   41793:	48 89 c7             	mov    %rax,%rdi
   41796:	e8 5d fc ff ff       	call   413f8 <memshow_virtual>
    }
}
   4179b:	90                   	nop
   4179c:	c9                   	leave  
   4179d:	c3                   	ret    

000000000004179e <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   4179e:	f3 0f 1e fa          	endbr64 
   417a2:	55                   	push   %rbp
   417a3:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   417a6:	e8 5f 01 00 00       	call   4190a <segments_init>
    interrupt_init();
   417ab:	e8 44 04 00 00       	call   41bf4 <interrupt_init>
    virtual_memory_init();
   417b0:	e8 11 11 00 00       	call   428c6 <virtual_memory_init>
}
   417b5:	90                   	nop
   417b6:	5d                   	pop    %rbp
   417b7:	c3                   	ret    

00000000000417b8 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   417b8:	f3 0f 1e fa          	endbr64 
   417bc:	55                   	push   %rbp
   417bd:	48 89 e5             	mov    %rsp,%rbp
   417c0:	48 83 ec 18          	sub    $0x18,%rsp
   417c4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   417c8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   417cc:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   417cf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   417d2:	48 98                	cltq   
   417d4:	48 c1 e0 2d          	shl    $0x2d,%rax
   417d8:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   417dc:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   417e3:	90 00 00 
   417e6:	48 09 c2             	or     %rax,%rdx
    *segment = type
   417e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   417ed:	48 89 10             	mov    %rdx,(%rax)
}
   417f0:	90                   	nop
   417f1:	c9                   	leave  
   417f2:	c3                   	ret    

00000000000417f3 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   417f3:	f3 0f 1e fa          	endbr64 
   417f7:	55                   	push   %rbp
   417f8:	48 89 e5             	mov    %rsp,%rbp
   417fb:	48 83 ec 28          	sub    $0x28,%rsp
   417ff:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41803:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41807:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4180a:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   4180e:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41812:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41816:	48 c1 e0 10          	shl    $0x10,%rax
   4181a:	48 89 c2             	mov    %rax,%rdx
   4181d:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41824:	00 00 00 
   41827:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   4182a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4182e:	48 c1 e0 20          	shl    $0x20,%rax
   41832:	48 89 c1             	mov    %rax,%rcx
   41835:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4183c:	00 00 ff 
   4183f:	48 21 c8             	and    %rcx,%rax
   41842:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41845:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41849:	48 83 e8 01          	sub    $0x1,%rax
   4184d:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41850:	48 09 d0             	or     %rdx,%rax
        | type
   41853:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41857:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   4185a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4185d:	48 98                	cltq   
   4185f:	48 c1 e0 2d          	shl    $0x2d,%rax
   41863:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41866:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4186d:	80 00 00 
   41870:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41873:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41877:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   4187a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4187e:	48 83 c0 08          	add    $0x8,%rax
   41882:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41886:	48 c1 ea 20          	shr    $0x20,%rdx
   4188a:	48 89 10             	mov    %rdx,(%rax)
}
   4188d:	90                   	nop
   4188e:	c9                   	leave  
   4188f:	c3                   	ret    

0000000000041890 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41890:	f3 0f 1e fa          	endbr64 
   41894:	55                   	push   %rbp
   41895:	48 89 e5             	mov    %rsp,%rbp
   41898:	48 83 ec 20          	sub    $0x20,%rsp
   4189c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418a0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   418a4:	89 55 ec             	mov    %edx,-0x14(%rbp)
   418a7:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   418ab:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   418af:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   418b2:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   418b6:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   418b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   418bc:	48 98                	cltq   
   418be:	48 c1 e0 2d          	shl    $0x2d,%rax
   418c2:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   418c5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   418c9:	48 c1 e0 20          	shl    $0x20,%rax
   418cd:	48 89 c1             	mov    %rax,%rcx
   418d0:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   418d7:	00 ff ff 
   418da:	48 21 c8             	and    %rcx,%rax
   418dd:	48 09 c2             	or     %rax,%rdx
   418e0:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   418e7:	80 00 00 
   418ea:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   418ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418f1:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   418f4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   418f8:	48 c1 e8 20          	shr    $0x20,%rax
   418fc:	48 89 c2             	mov    %rax,%rdx
   418ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41903:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41907:	90                   	nop
   41908:	c9                   	leave  
   41909:	c3                   	ret    

000000000004190a <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   4190a:	f3 0f 1e fa          	endbr64 
   4190e:	55                   	push   %rbp
   4190f:	48 89 e5             	mov    %rsp,%rbp
   41912:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41916:	48 c7 05 3f 19 01 00 	movq   $0x0,0x1193f(%rip)        # 53260 <segments>
   4191d:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41921:	ba 00 00 00 00       	mov    $0x0,%edx
   41926:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4192d:	08 20 00 
   41930:	48 89 c6             	mov    %rax,%rsi
   41933:	48 8d 05 2e 19 01 00 	lea    0x1192e(%rip),%rax        # 53268 <segments+0x8>
   4193a:	48 89 c7             	mov    %rax,%rdi
   4193d:	e8 76 fe ff ff       	call   417b8 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41942:	ba 03 00 00 00       	mov    $0x3,%edx
   41947:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4194e:	08 20 00 
   41951:	48 89 c6             	mov    %rax,%rsi
   41954:	48 8d 05 15 19 01 00 	lea    0x11915(%rip),%rax        # 53270 <segments+0x10>
   4195b:	48 89 c7             	mov    %rax,%rdi
   4195e:	e8 55 fe ff ff       	call   417b8 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41963:	ba 00 00 00 00       	mov    $0x0,%edx
   41968:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   4196f:	02 00 00 
   41972:	48 89 c6             	mov    %rax,%rsi
   41975:	48 8d 05 fc 18 01 00 	lea    0x118fc(%rip),%rax        # 53278 <segments+0x18>
   4197c:	48 89 c7             	mov    %rax,%rdi
   4197f:	e8 34 fe ff ff       	call   417b8 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41984:	ba 03 00 00 00       	mov    $0x3,%edx
   41989:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41990:	02 00 00 
   41993:	48 89 c6             	mov    %rax,%rsi
   41996:	48 8d 05 e3 18 01 00 	lea    0x118e3(%rip),%rax        # 53280 <segments+0x20>
   4199d:	48 89 c7             	mov    %rax,%rdi
   419a0:	e8 13 fe ff ff       	call   417b8 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   419a5:	48 8d 05 f4 28 01 00 	lea    0x128f4(%rip),%rax        # 542a0 <kernel_task_descriptor>
   419ac:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   419b2:	48 89 c1             	mov    %rax,%rcx
   419b5:	ba 00 00 00 00       	mov    $0x0,%edx
   419ba:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   419c1:	09 00 00 
   419c4:	48 89 c6             	mov    %rax,%rsi
   419c7:	48 8d 05 ba 18 01 00 	lea    0x118ba(%rip),%rax        # 53288 <segments+0x28>
   419ce:	48 89 c7             	mov    %rax,%rdi
   419d1:	e8 1d fe ff ff       	call   417f3 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   419d6:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   419dc:	48 8d 05 7d 18 01 00 	lea    0x1187d(%rip),%rax        # 53260 <segments>
   419e3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   419e7:	ba 60 00 00 00       	mov    $0x60,%edx
   419ec:	be 00 00 00 00       	mov    $0x0,%esi
   419f1:	48 8d 05 a8 28 01 00 	lea    0x128a8(%rip),%rax        # 542a0 <kernel_task_descriptor>
   419f8:	48 89 c7             	mov    %rax,%rdi
   419fb:	e8 84 1a 00 00       	call   43484 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41a00:	48 c7 05 99 28 01 00 	movq   $0x80000,0x12899(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41a07:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41a0b:	ba 00 10 00 00       	mov    $0x1000,%edx
   41a10:	be 00 00 00 00       	mov    $0x0,%esi
   41a15:	48 8d 05 84 18 01 00 	lea    0x11884(%rip),%rax        # 532a0 <interrupt_descriptors>
   41a1c:	48 89 c7             	mov    %rax,%rdi
   41a1f:	e8 60 1a 00 00       	call   43484 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41a24:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41a2b:	eb 3c                	jmp    41a69 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41a2d:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   41a34:	48 89 c2             	mov    %rax,%rdx
   41a37:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a3a:	48 c1 e0 04          	shl    $0x4,%rax
   41a3e:	48 89 c1             	mov    %rax,%rcx
   41a41:	48 8d 05 58 18 01 00 	lea    0x11858(%rip),%rax        # 532a0 <interrupt_descriptors>
   41a48:	48 01 c8             	add    %rcx,%rax
   41a4b:	48 89 d1             	mov    %rdx,%rcx
   41a4e:	ba 00 00 00 00       	mov    $0x0,%edx
   41a53:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41a5a:	0e 00 00 
   41a5d:	48 89 c7             	mov    %rax,%rdi
   41a60:	e8 2b fe ff ff       	call   41890 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41a65:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41a69:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41a70:	76 bb                	jbe    41a2d <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41a72:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   41a79:	48 89 c1             	mov    %rax,%rcx
   41a7c:	ba 00 00 00 00       	mov    $0x0,%edx
   41a81:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41a88:	0e 00 00 
   41a8b:	48 89 c6             	mov    %rax,%rsi
   41a8e:	48 8d 05 0b 1a 01 00 	lea    0x11a0b(%rip),%rax        # 534a0 <interrupt_descriptors+0x200>
   41a95:	48 89 c7             	mov    %rax,%rdi
   41a98:	e8 f3 fd ff ff       	call   41890 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41a9d:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   41aa4:	48 89 c1             	mov    %rax,%rcx
   41aa7:	ba 00 00 00 00       	mov    $0x0,%edx
   41aac:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ab3:	0e 00 00 
   41ab6:	48 89 c6             	mov    %rax,%rsi
   41ab9:	48 8d 05 b0 18 01 00 	lea    0x118b0(%rip),%rax        # 53370 <interrupt_descriptors+0xd0>
   41ac0:	48 89 c7             	mov    %rax,%rdi
   41ac3:	e8 c8 fd ff ff       	call   41890 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41ac8:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   41acf:	48 89 c1             	mov    %rax,%rcx
   41ad2:	ba 00 00 00 00       	mov    $0x0,%edx
   41ad7:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ade:	0e 00 00 
   41ae1:	48 89 c6             	mov    %rax,%rsi
   41ae4:	48 8d 05 95 18 01 00 	lea    0x11895(%rip),%rax        # 53380 <interrupt_descriptors+0xe0>
   41aeb:	48 89 c7             	mov    %rax,%rdi
   41aee:	e8 9d fd ff ff       	call   41890 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41af3:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41afa:	eb 50                	jmp    41b4c <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41afc:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41aff:	83 e8 30             	sub    $0x30,%eax
   41b02:	89 c0                	mov    %eax,%eax
   41b04:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   41b0b:	00 
   41b0c:	48 8d 05 d4 e5 ff ff 	lea    -0x1a2c(%rip),%rax        # 400e7 <sys_int_handlers>
   41b13:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41b17:	48 89 c2             	mov    %rax,%rdx
   41b1a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41b1d:	48 c1 e0 04          	shl    $0x4,%rax
   41b21:	48 89 c1             	mov    %rax,%rcx
   41b24:	48 8d 05 75 17 01 00 	lea    0x11775(%rip),%rax        # 532a0 <interrupt_descriptors>
   41b2b:	48 01 c8             	add    %rcx,%rax
   41b2e:	48 89 d1             	mov    %rdx,%rcx
   41b31:	ba 03 00 00 00       	mov    $0x3,%edx
   41b36:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41b3d:	0e 00 00 
   41b40:	48 89 c7             	mov    %rax,%rdi
   41b43:	e8 48 fd ff ff       	call   41890 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41b48:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41b4c:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41b50:	76 aa                	jbe    41afc <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41b52:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41b58:	48 8d 05 41 17 01 00 	lea    0x11741(%rip),%rax        # 532a0 <interrupt_descriptors>
   41b5f:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41b63:	b8 28 00 00 00       	mov    $0x28,%eax
   41b68:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41b6c:	0f 00 d8             	ltr    %ax
   41b6f:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41b73:	0f 20 c0             	mov    %cr0,%rax
   41b76:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41b7a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41b7e:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41b81:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41b88:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41b8b:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41b8e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41b91:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41b95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41b99:	0f 22 c0             	mov    %rax,%cr0
}
   41b9c:	90                   	nop
    lcr0(cr0);
}
   41b9d:	90                   	nop
   41b9e:	c9                   	leave  
   41b9f:	c3                   	ret    

0000000000041ba0 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41ba0:	f3 0f 1e fa          	endbr64 
   41ba4:	55                   	push   %rbp
   41ba5:	48 89 e5             	mov    %rsp,%rbp
   41ba8:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41bac:	0f b7 05 4d 27 01 00 	movzwl 0x1274d(%rip),%eax        # 54300 <interrupts_enabled>
   41bb3:	f7 d0                	not    %eax
   41bb5:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41bb9:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41bbd:	0f b6 c0             	movzbl %al,%eax
   41bc0:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41bc7:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bca:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41bce:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41bd1:	ee                   	out    %al,(%dx)
}
   41bd2:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41bd3:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41bd7:	66 c1 e8 08          	shr    $0x8,%ax
   41bdb:	0f b6 c0             	movzbl %al,%eax
   41bde:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41be5:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41be8:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41bec:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41bef:	ee                   	out    %al,(%dx)
}
   41bf0:	90                   	nop
}
   41bf1:	90                   	nop
   41bf2:	c9                   	leave  
   41bf3:	c3                   	ret    

0000000000041bf4 <interrupt_init>:

void interrupt_init(void) {
   41bf4:	f3 0f 1e fa          	endbr64 
   41bf8:	55                   	push   %rbp
   41bf9:	48 89 e5             	mov    %rsp,%rbp
   41bfc:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41c00:	66 c7 05 f7 26 01 00 	movw   $0x0,0x126f7(%rip)        # 54300 <interrupts_enabled>
   41c07:	00 00 
    interrupt_mask();
   41c09:	e8 92 ff ff ff       	call   41ba0 <interrupt_mask>
   41c0e:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41c15:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c19:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41c1d:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41c20:	ee                   	out    %al,(%dx)
}
   41c21:	90                   	nop
   41c22:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41c29:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c2d:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41c31:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41c34:	ee                   	out    %al,(%dx)
}
   41c35:	90                   	nop
   41c36:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41c3d:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c41:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41c45:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41c48:	ee                   	out    %al,(%dx)
}
   41c49:	90                   	nop
   41c4a:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41c51:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c55:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41c59:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41c5c:	ee                   	out    %al,(%dx)
}
   41c5d:	90                   	nop
   41c5e:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41c65:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c69:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41c6d:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41c70:	ee                   	out    %al,(%dx)
}
   41c71:	90                   	nop
   41c72:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41c79:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c7d:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41c81:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41c84:	ee                   	out    %al,(%dx)
}
   41c85:	90                   	nop
   41c86:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41c8d:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c91:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41c95:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41c98:	ee                   	out    %al,(%dx)
}
   41c99:	90                   	nop
   41c9a:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41ca1:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ca5:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41ca9:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41cac:	ee                   	out    %al,(%dx)
}
   41cad:	90                   	nop
   41cae:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41cb5:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cb9:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41cbd:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41cc0:	ee                   	out    %al,(%dx)
}
   41cc1:	90                   	nop
   41cc2:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41cc9:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ccd:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41cd1:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41cd4:	ee                   	out    %al,(%dx)
}
   41cd5:	90                   	nop
   41cd6:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41cdd:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ce1:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ce5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ce8:	ee                   	out    %al,(%dx)
}
   41ce9:	90                   	nop
   41cea:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41cf1:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cf5:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41cf9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41cfc:	ee                   	out    %al,(%dx)
}
   41cfd:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41cfe:	e8 9d fe ff ff       	call   41ba0 <interrupt_mask>
}
   41d03:	90                   	nop
   41d04:	c9                   	leave  
   41d05:	c3                   	ret    

0000000000041d06 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41d06:	f3 0f 1e fa          	endbr64 
   41d0a:	55                   	push   %rbp
   41d0b:	48 89 e5             	mov    %rsp,%rbp
   41d0e:	48 83 ec 28          	sub    $0x28,%rsp
   41d12:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41d15:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41d19:	0f 8e 9f 00 00 00    	jle    41dbe <timer_init+0xb8>
   41d1f:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41d26:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d2a:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41d2e:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41d31:	ee                   	out    %al,(%dx)
}
   41d32:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41d33:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41d36:	89 c2                	mov    %eax,%edx
   41d38:	c1 ea 1f             	shr    $0x1f,%edx
   41d3b:	01 d0                	add    %edx,%eax
   41d3d:	d1 f8                	sar    %eax
   41d3f:	05 de 34 12 00       	add    $0x1234de,%eax
   41d44:	99                   	cltd   
   41d45:	f7 7d dc             	idivl  -0x24(%rbp)
   41d48:	89 c2                	mov    %eax,%edx
   41d4a:	89 d0                	mov    %edx,%eax
   41d4c:	c1 f8 1f             	sar    $0x1f,%eax
   41d4f:	c1 e8 18             	shr    $0x18,%eax
   41d52:	89 c1                	mov    %eax,%ecx
   41d54:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41d57:	0f b6 c0             	movzbl %al,%eax
   41d5a:	29 c8                	sub    %ecx,%eax
   41d5c:	0f b6 c0             	movzbl %al,%eax
   41d5f:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41d66:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d69:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41d6d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d70:	ee                   	out    %al,(%dx)
}
   41d71:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41d72:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41d75:	89 c2                	mov    %eax,%edx
   41d77:	c1 ea 1f             	shr    $0x1f,%edx
   41d7a:	01 d0                	add    %edx,%eax
   41d7c:	d1 f8                	sar    %eax
   41d7e:	05 de 34 12 00       	add    $0x1234de,%eax
   41d83:	99                   	cltd   
   41d84:	f7 7d dc             	idivl  -0x24(%rbp)
   41d87:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41d8d:	85 c0                	test   %eax,%eax
   41d8f:	0f 48 c2             	cmovs  %edx,%eax
   41d92:	c1 f8 08             	sar    $0x8,%eax
   41d95:	0f b6 c0             	movzbl %al,%eax
   41d98:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41d9f:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41da2:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41da6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41da9:	ee                   	out    %al,(%dx)
}
   41daa:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41dab:	0f b7 05 4e 25 01 00 	movzwl 0x1254e(%rip),%eax        # 54300 <interrupts_enabled>
   41db2:	83 c8 01             	or     $0x1,%eax
   41db5:	66 89 05 44 25 01 00 	mov    %ax,0x12544(%rip)        # 54300 <interrupts_enabled>
   41dbc:	eb 11                	jmp    41dcf <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41dbe:	0f b7 05 3b 25 01 00 	movzwl 0x1253b(%rip),%eax        # 54300 <interrupts_enabled>
   41dc5:	83 e0 fe             	and    $0xfffffffe,%eax
   41dc8:	66 89 05 31 25 01 00 	mov    %ax,0x12531(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   41dcf:	e8 cc fd ff ff       	call   41ba0 <interrupt_mask>
}
   41dd4:	90                   	nop
   41dd5:	c9                   	leave  
   41dd6:	c3                   	ret    

0000000000041dd7 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41dd7:	f3 0f 1e fa          	endbr64 
   41ddb:	55                   	push   %rbp
   41ddc:	48 89 e5             	mov    %rsp,%rbp
   41ddf:	48 83 ec 08          	sub    $0x8,%rsp
   41de3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41de7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41dec:	74 14                	je     41e02 <physical_memory_isreserved+0x2b>
   41dee:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41df5:	00 
   41df6:	76 11                	jbe    41e09 <physical_memory_isreserved+0x32>
   41df8:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41dff:	00 
   41e00:	77 07                	ja     41e09 <physical_memory_isreserved+0x32>
   41e02:	b8 01 00 00 00       	mov    $0x1,%eax
   41e07:	eb 05                	jmp    41e0e <physical_memory_isreserved+0x37>
   41e09:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41e0e:	c9                   	leave  
   41e0f:	c3                   	ret    

0000000000041e10 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41e10:	f3 0f 1e fa          	endbr64 
   41e14:	55                   	push   %rbp
   41e15:	48 89 e5             	mov    %rsp,%rbp
   41e18:	48 83 ec 10          	sub    $0x10,%rsp
   41e1c:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41e1f:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41e22:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41e25:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e28:	c1 e0 10             	shl    $0x10,%eax
   41e2b:	89 c2                	mov    %eax,%edx
   41e2d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41e30:	c1 e0 0b             	shl    $0xb,%eax
   41e33:	09 c2                	or     %eax,%edx
   41e35:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e38:	c1 e0 08             	shl    $0x8,%eax
   41e3b:	09 d0                	or     %edx,%eax
}
   41e3d:	c9                   	leave  
   41e3e:	c3                   	ret    

0000000000041e3f <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41e3f:	f3 0f 1e fa          	endbr64 
   41e43:	55                   	push   %rbp
   41e44:	48 89 e5             	mov    %rsp,%rbp
   41e47:	48 83 ec 18          	sub    $0x18,%rsp
   41e4b:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41e4e:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41e51:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e54:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41e57:	09 d0                	or     %edx,%eax
   41e59:	0d 00 00 00 80       	or     $0x80000000,%eax
   41e5e:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41e65:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41e68:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e6b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e6e:	ef                   	out    %eax,(%dx)
}
   41e6f:	90                   	nop
   41e70:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41e77:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e7a:	89 c2                	mov    %eax,%edx
   41e7c:	ed                   	in     (%dx),%eax
   41e7d:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41e80:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41e83:	c9                   	leave  
   41e84:	c3                   	ret    

0000000000041e85 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41e85:	f3 0f 1e fa          	endbr64 
   41e89:	55                   	push   %rbp
   41e8a:	48 89 e5             	mov    %rsp,%rbp
   41e8d:	48 83 ec 28          	sub    $0x28,%rsp
   41e91:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41e94:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41e97:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e9e:	eb 73                	jmp    41f13 <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   41ea0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41ea7:	eb 60                	jmp    41f09 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   41ea9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41eb0:	eb 4a                	jmp    41efc <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41eb2:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41eb5:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41eb8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ebb:	89 ce                	mov    %ecx,%esi
   41ebd:	89 c7                	mov    %eax,%edi
   41ebf:	e8 4c ff ff ff       	call   41e10 <pci_make_configaddr>
   41ec4:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41ec7:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41eca:	be 00 00 00 00       	mov    $0x0,%esi
   41ecf:	89 c7                	mov    %eax,%edi
   41ed1:	e8 69 ff ff ff       	call   41e3f <pci_config_readl>
   41ed6:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41ed9:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41edc:	c1 e0 10             	shl    $0x10,%eax
   41edf:	0b 45 dc             	or     -0x24(%rbp),%eax
   41ee2:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41ee5:	75 05                	jne    41eec <pci_find_device+0x67>
                    return configaddr;
   41ee7:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41eea:	eb 35                	jmp    41f21 <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41eec:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41ef0:	75 06                	jne    41ef8 <pci_find_device+0x73>
   41ef2:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41ef6:	74 0c                	je     41f04 <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   41ef8:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41efc:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41f00:	75 b0                	jne    41eb2 <pci_find_device+0x2d>
   41f02:	eb 01                	jmp    41f05 <pci_find_device+0x80>
                    break;
   41f04:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41f05:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41f09:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41f0d:	75 9a                	jne    41ea9 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   41f0f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41f13:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41f1a:	75 84                	jne    41ea0 <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   41f1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41f21:	c9                   	leave  
   41f22:	c3                   	ret    

0000000000041f23 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41f23:	f3 0f 1e fa          	endbr64 
   41f27:	55                   	push   %rbp
   41f28:	48 89 e5             	mov    %rsp,%rbp
   41f2b:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41f2f:	be 13 71 00 00       	mov    $0x7113,%esi
   41f34:	bf 86 80 00 00       	mov    $0x8086,%edi
   41f39:	e8 47 ff ff ff       	call   41e85 <pci_find_device>
   41f3e:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41f41:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41f45:	78 30                	js     41f77 <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41f47:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f4a:	be 40 00 00 00       	mov    $0x40,%esi
   41f4f:	89 c7                	mov    %eax,%edi
   41f51:	e8 e9 fe ff ff       	call   41e3f <pci_config_readl>
   41f56:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41f5b:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41f5e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f61:	83 c0 04             	add    $0x4,%eax
   41f64:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41f67:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41f6d:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41f71:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f74:	66 ef                	out    %ax,(%dx)
}
   41f76:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41f77:	48 8d 05 82 28 00 00 	lea    0x2882(%rip),%rax        # 44800 <memstate_colors+0xc0>
   41f7e:	48 89 c2             	mov    %rax,%rdx
   41f81:	be 00 c0 00 00       	mov    $0xc000,%esi
   41f86:	bf 80 07 00 00       	mov    $0x780,%edi
   41f8b:	b8 00 00 00 00       	mov    $0x0,%eax
   41f90:	e8 2e 23 00 00       	call   442c3 <console_printf>
 spinloop: goto spinloop;
   41f95:	eb fe                	jmp    41f95 <poweroff+0x72>

0000000000041f97 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41f97:	f3 0f 1e fa          	endbr64 
   41f9b:	55                   	push   %rbp
   41f9c:	48 89 e5             	mov    %rsp,%rbp
   41f9f:	48 83 ec 10          	sub    $0x10,%rsp
   41fa3:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41faa:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fae:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fb2:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41fb5:	ee                   	out    %al,(%dx)
}
   41fb6:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41fb7:	eb fe                	jmp    41fb7 <reboot+0x20>

0000000000041fb9 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41fb9:	f3 0f 1e fa          	endbr64 
   41fbd:	55                   	push   %rbp
   41fbe:	48 89 e5             	mov    %rsp,%rbp
   41fc1:	48 83 ec 10          	sub    $0x10,%rsp
   41fc5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41fc9:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41fcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fd0:	48 83 c0 08          	add    $0x8,%rax
   41fd4:	ba c0 00 00 00       	mov    $0xc0,%edx
   41fd9:	be 00 00 00 00       	mov    $0x0,%esi
   41fde:	48 89 c7             	mov    %rax,%rdi
   41fe1:	e8 9e 14 00 00       	call   43484 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41fe6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fea:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41ff1:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41ff3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ff7:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41ffe:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   42002:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42006:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   4200d:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   42011:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42015:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   4201c:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   4201e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42022:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   42029:	00 02 00 00 
    p->display_status = 1;
   4202d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42031:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42038:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4203b:	83 e0 01             	and    $0x1,%eax
   4203e:	85 c0                	test   %eax,%eax
   42040:	74 1c                	je     4205e <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   42042:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42046:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4204d:	80 cc 30             	or     $0x30,%ah
   42050:	48 89 c2             	mov    %rax,%rdx
   42053:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42057:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   4205e:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42061:	83 e0 02             	and    $0x2,%eax
   42064:	85 c0                	test   %eax,%eax
   42066:	74 1c                	je     42084 <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42068:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4206c:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42073:	80 e4 fd             	and    $0xfd,%ah
   42076:	48 89 c2             	mov    %rax,%rdx
   42079:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4207d:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   42084:	90                   	nop
   42085:	c9                   	leave  
   42086:	c3                   	ret    

0000000000042087 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42087:	f3 0f 1e fa          	endbr64 
   4208b:	55                   	push   %rbp
   4208c:	48 89 e5             	mov    %rsp,%rbp
   4208f:	48 83 ec 28          	sub    $0x28,%rsp
   42093:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42096:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4209a:	78 09                	js     420a5 <console_show_cursor+0x1e>
   4209c:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   420a3:	7e 07                	jle    420ac <console_show_cursor+0x25>
        cpos = 0;
   420a5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   420ac:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   420b3:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420b7:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   420bb:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   420be:	ee                   	out    %al,(%dx)
}
   420bf:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   420c0:	8b 45 dc             	mov    -0x24(%rbp),%eax
   420c3:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   420c9:	85 c0                	test   %eax,%eax
   420cb:	0f 48 c2             	cmovs  %edx,%eax
   420ce:	c1 f8 08             	sar    $0x8,%eax
   420d1:	0f b6 c0             	movzbl %al,%eax
   420d4:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   420db:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420de:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   420e2:	8b 55 ec             	mov    -0x14(%rbp),%edx
   420e5:	ee                   	out    %al,(%dx)
}
   420e6:	90                   	nop
   420e7:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   420ee:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420f2:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   420f6:	8b 55 f4             	mov    -0xc(%rbp),%edx
   420f9:	ee                   	out    %al,(%dx)
}
   420fa:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   420fb:	8b 45 dc             	mov    -0x24(%rbp),%eax
   420fe:	99                   	cltd   
   420ff:	c1 ea 18             	shr    $0x18,%edx
   42102:	01 d0                	add    %edx,%eax
   42104:	0f b6 c0             	movzbl %al,%eax
   42107:	29 d0                	sub    %edx,%eax
   42109:	0f b6 c0             	movzbl %al,%eax
   4210c:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   42113:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42116:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4211a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4211d:	ee                   	out    %al,(%dx)
}
   4211e:	90                   	nop
}
   4211f:	90                   	nop
   42120:	c9                   	leave  
   42121:	c3                   	ret    

0000000000042122 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   42122:	f3 0f 1e fa          	endbr64 
   42126:	55                   	push   %rbp
   42127:	48 89 e5             	mov    %rsp,%rbp
   4212a:	48 83 ec 20          	sub    $0x20,%rsp
   4212e:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42135:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42138:	89 c2                	mov    %eax,%edx
   4213a:	ec                   	in     (%dx),%al
   4213b:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4213e:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   42142:	0f b6 c0             	movzbl %al,%eax
   42145:	83 e0 01             	and    $0x1,%eax
   42148:	85 c0                	test   %eax,%eax
   4214a:	75 0a                	jne    42156 <keyboard_readc+0x34>
        return -1;
   4214c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42151:	e9 fd 01 00 00       	jmp    42353 <keyboard_readc+0x231>
   42156:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4215d:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42160:	89 c2                	mov    %eax,%edx
   42162:	ec                   	in     (%dx),%al
   42163:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42166:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   4216a:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   4216d:	0f b6 05 8e 21 01 00 	movzbl 0x1218e(%rip),%eax        # 54302 <last_escape.2>
   42174:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42177:	c6 05 84 21 01 00 00 	movb   $0x0,0x12184(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   4217e:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42182:	75 11                	jne    42195 <keyboard_readc+0x73>
        last_escape = 0x80;
   42184:	c6 05 77 21 01 00 80 	movb   $0x80,0x12177(%rip)        # 54302 <last_escape.2>
        return 0;
   4218b:	b8 00 00 00 00       	mov    $0x0,%eax
   42190:	e9 be 01 00 00       	jmp    42353 <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42195:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42199:	84 c0                	test   %al,%al
   4219b:	79 64                	jns    42201 <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   4219d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   421a1:	83 e0 7f             	and    $0x7f,%eax
   421a4:	89 c2                	mov    %eax,%edx
   421a6:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   421aa:	09 d0                	or     %edx,%eax
   421ac:	48 98                	cltq   
   421ae:	48 8d 15 6b 26 00 00 	lea    0x266b(%rip),%rdx        # 44820 <keymap>
   421b5:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   421b9:	0f b6 c0             	movzbl %al,%eax
   421bc:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   421bf:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   421c6:	7e 2f                	jle    421f7 <keyboard_readc+0xd5>
   421c8:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   421cf:	7f 26                	jg     421f7 <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   421d1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   421d4:	2d fa 00 00 00       	sub    $0xfa,%eax
   421d9:	ba 01 00 00 00       	mov    $0x1,%edx
   421de:	89 c1                	mov    %eax,%ecx
   421e0:	d3 e2                	shl    %cl,%edx
   421e2:	89 d0                	mov    %edx,%eax
   421e4:	f7 d0                	not    %eax
   421e6:	89 c2                	mov    %eax,%edx
   421e8:	0f b6 05 14 21 01 00 	movzbl 0x12114(%rip),%eax        # 54303 <modifiers.1>
   421ef:	21 d0                	and    %edx,%eax
   421f1:	88 05 0c 21 01 00    	mov    %al,0x1210c(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   421f7:	b8 00 00 00 00       	mov    $0x0,%eax
   421fc:	e9 52 01 00 00       	jmp    42353 <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   42201:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42205:	0a 45 fa             	or     -0x6(%rbp),%al
   42208:	0f b6 c0             	movzbl %al,%eax
   4220b:	48 98                	cltq   
   4220d:	48 8d 15 0c 26 00 00 	lea    0x260c(%rip),%rdx        # 44820 <keymap>
   42214:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42218:	0f b6 c0             	movzbl %al,%eax
   4221b:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   4221e:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42222:	7e 57                	jle    4227b <keyboard_readc+0x159>
   42224:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42228:	7f 51                	jg     4227b <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   4222a:	0f b6 05 d2 20 01 00 	movzbl 0x120d2(%rip),%eax        # 54303 <modifiers.1>
   42231:	0f b6 c0             	movzbl %al,%eax
   42234:	83 e0 02             	and    $0x2,%eax
   42237:	85 c0                	test   %eax,%eax
   42239:	74 09                	je     42244 <keyboard_readc+0x122>
            ch -= 0x60;
   4223b:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4223f:	e9 0b 01 00 00       	jmp    4234f <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42244:	0f b6 05 b8 20 01 00 	movzbl 0x120b8(%rip),%eax        # 54303 <modifiers.1>
   4224b:	0f b6 c0             	movzbl %al,%eax
   4224e:	83 e0 01             	and    $0x1,%eax
   42251:	85 c0                	test   %eax,%eax
   42253:	0f 94 c2             	sete   %dl
   42256:	0f b6 05 a6 20 01 00 	movzbl 0x120a6(%rip),%eax        # 54303 <modifiers.1>
   4225d:	0f b6 c0             	movzbl %al,%eax
   42260:	83 e0 08             	and    $0x8,%eax
   42263:	85 c0                	test   %eax,%eax
   42265:	0f 94 c0             	sete   %al
   42268:	31 d0                	xor    %edx,%eax
   4226a:	84 c0                	test   %al,%al
   4226c:	0f 84 dd 00 00 00    	je     4234f <keyboard_readc+0x22d>
            ch -= 0x20;
   42272:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42276:	e9 d4 00 00 00       	jmp    4234f <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4227b:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42282:	7e 30                	jle    422b4 <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42284:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42287:	2d fa 00 00 00       	sub    $0xfa,%eax
   4228c:	ba 01 00 00 00       	mov    $0x1,%edx
   42291:	89 c1                	mov    %eax,%ecx
   42293:	d3 e2                	shl    %cl,%edx
   42295:	89 d0                	mov    %edx,%eax
   42297:	89 c2                	mov    %eax,%edx
   42299:	0f b6 05 63 20 01 00 	movzbl 0x12063(%rip),%eax        # 54303 <modifiers.1>
   422a0:	31 d0                	xor    %edx,%eax
   422a2:	88 05 5b 20 01 00    	mov    %al,0x1205b(%rip)        # 54303 <modifiers.1>
        ch = 0;
   422a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   422af:	e9 9c 00 00 00       	jmp    42350 <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   422b4:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   422bb:	7e 2d                	jle    422ea <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   422bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422c0:	2d fa 00 00 00       	sub    $0xfa,%eax
   422c5:	ba 01 00 00 00       	mov    $0x1,%edx
   422ca:	89 c1                	mov    %eax,%ecx
   422cc:	d3 e2                	shl    %cl,%edx
   422ce:	89 d0                	mov    %edx,%eax
   422d0:	89 c2                	mov    %eax,%edx
   422d2:	0f b6 05 2a 20 01 00 	movzbl 0x1202a(%rip),%eax        # 54303 <modifiers.1>
   422d9:	09 d0                	or     %edx,%eax
   422db:	88 05 22 20 01 00    	mov    %al,0x12022(%rip)        # 54303 <modifiers.1>
        ch = 0;
   422e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   422e8:	eb 66                	jmp    42350 <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   422ea:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   422ee:	7e 3f                	jle    4232f <keyboard_readc+0x20d>
   422f0:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   422f7:	7f 36                	jg     4232f <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   422f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422fc:	8d 50 80             	lea    -0x80(%rax),%edx
   422ff:	0f b6 05 fd 1f 01 00 	movzbl 0x11ffd(%rip),%eax        # 54303 <modifiers.1>
   42306:	0f b6 c0             	movzbl %al,%eax
   42309:	83 e0 03             	and    $0x3,%eax
   4230c:	48 63 c8             	movslq %eax,%rcx
   4230f:	48 63 c2             	movslq %edx,%rax
   42312:	48 c1 e0 02          	shl    $0x2,%rax
   42316:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   4231a:	48 8d 05 ff 25 00 00 	lea    0x25ff(%rip),%rax        # 44920 <complex_keymap>
   42321:	48 01 d0             	add    %rdx,%rax
   42324:	0f b6 00             	movzbl (%rax),%eax
   42327:	0f b6 c0             	movzbl %al,%eax
   4232a:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4232d:	eb 21                	jmp    42350 <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   4232f:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42333:	7f 1b                	jg     42350 <keyboard_readc+0x22e>
   42335:	0f b6 05 c7 1f 01 00 	movzbl 0x11fc7(%rip),%eax        # 54303 <modifiers.1>
   4233c:	0f b6 c0             	movzbl %al,%eax
   4233f:	83 e0 02             	and    $0x2,%eax
   42342:	85 c0                	test   %eax,%eax
   42344:	74 0a                	je     42350 <keyboard_readc+0x22e>
        ch = 0;
   42346:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4234d:	eb 01                	jmp    42350 <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   4234f:	90                   	nop
    }

    return ch;
   42350:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42353:	c9                   	leave  
   42354:	c3                   	ret    

0000000000042355 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42355:	f3 0f 1e fa          	endbr64 
   42359:	55                   	push   %rbp
   4235a:	48 89 e5             	mov    %rsp,%rbp
   4235d:	48 83 ec 20          	sub    $0x20,%rsp
   42361:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42368:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4236b:	89 c2                	mov    %eax,%edx
   4236d:	ec                   	in     (%dx),%al
   4236e:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42371:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42378:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4237b:	89 c2                	mov    %eax,%edx
   4237d:	ec                   	in     (%dx),%al
   4237e:	88 45 eb             	mov    %al,-0x15(%rbp)
   42381:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42388:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4238b:	89 c2                	mov    %eax,%edx
   4238d:	ec                   	in     (%dx),%al
   4238e:	88 45 f3             	mov    %al,-0xd(%rbp)
   42391:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42398:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4239b:	89 c2                	mov    %eax,%edx
   4239d:	ec                   	in     (%dx),%al
   4239e:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   423a1:	90                   	nop
   423a2:	c9                   	leave  
   423a3:	c3                   	ret    

00000000000423a4 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   423a4:	f3 0f 1e fa          	endbr64 
   423a8:	55                   	push   %rbp
   423a9:	48 89 e5             	mov    %rsp,%rbp
   423ac:	48 83 ec 40          	sub    $0x40,%rsp
   423b0:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   423b4:	89 f0                	mov    %esi,%eax
   423b6:	89 55 c0             	mov    %edx,-0x40(%rbp)
   423b9:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   423bc:	8b 05 42 1f 01 00    	mov    0x11f42(%rip),%eax        # 54304 <initialized.0>
   423c2:	85 c0                	test   %eax,%eax
   423c4:	75 1e                	jne    423e4 <parallel_port_putc+0x40>
   423c6:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   423cd:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423d1:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   423d5:	8b 55 f8             	mov    -0x8(%rbp),%edx
   423d8:	ee                   	out    %al,(%dx)
}
   423d9:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   423da:	c7 05 20 1f 01 00 01 	movl   $0x1,0x11f20(%rip)        # 54304 <initialized.0>
   423e1:	00 00 00 
    }

    for (int i = 0;
   423e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   423eb:	eb 09                	jmp    423f6 <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   423ed:	e8 63 ff ff ff       	call   42355 <delay>
         ++i) {
   423f2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   423f6:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   423fd:	7f 18                	jg     42417 <parallel_port_putc+0x73>
   423ff:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42406:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42409:	89 c2                	mov    %eax,%edx
   4240b:	ec                   	in     (%dx),%al
   4240c:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4240f:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42413:	84 c0                	test   %al,%al
   42415:	79 d6                	jns    423ed <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   42417:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   4241b:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42422:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42425:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42429:	8b 55 d8             	mov    -0x28(%rbp),%edx
   4242c:	ee                   	out    %al,(%dx)
}
   4242d:	90                   	nop
   4242e:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42435:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42439:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   4243d:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42440:	ee                   	out    %al,(%dx)
}
   42441:	90                   	nop
   42442:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42449:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4244d:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42451:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42454:	ee                   	out    %al,(%dx)
}
   42455:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42456:	90                   	nop
   42457:	c9                   	leave  
   42458:	c3                   	ret    

0000000000042459 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42459:	f3 0f 1e fa          	endbr64 
   4245d:	55                   	push   %rbp
   4245e:	48 89 e5             	mov    %rsp,%rbp
   42461:	48 83 ec 20          	sub    $0x20,%rsp
   42465:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42469:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   4246d:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 423a4 <parallel_port_putc>
   42474:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   42478:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   4247c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42480:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42484:	be 00 00 00 00       	mov    $0x0,%esi
   42489:	48 89 c7             	mov    %rax,%rdi
   4248c:	e8 b9 12 00 00       	call   4374a <printer_vprintf>
}
   42491:	90                   	nop
   42492:	c9                   	leave  
   42493:	c3                   	ret    

0000000000042494 <log_printf>:

void log_printf(const char* format, ...) {
   42494:	f3 0f 1e fa          	endbr64 
   42498:	55                   	push   %rbp
   42499:	48 89 e5             	mov    %rsp,%rbp
   4249c:	48 83 ec 60          	sub    $0x60,%rsp
   424a0:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   424a4:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   424a8:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   424ac:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   424b0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   424b4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   424b8:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   424bf:	48 8d 45 10          	lea    0x10(%rbp),%rax
   424c3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   424c7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   424cb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   424cf:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   424d3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   424d7:	48 89 d6             	mov    %rdx,%rsi
   424da:	48 89 c7             	mov    %rax,%rdi
   424dd:	e8 77 ff ff ff       	call   42459 <log_vprintf>
    va_end(val);
}
   424e2:	90                   	nop
   424e3:	c9                   	leave  
   424e4:	c3                   	ret    

00000000000424e5 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   424e5:	f3 0f 1e fa          	endbr64 
   424e9:	55                   	push   %rbp
   424ea:	48 89 e5             	mov    %rsp,%rbp
   424ed:	48 83 ec 40          	sub    $0x40,%rsp
   424f1:	89 7d dc             	mov    %edi,-0x24(%rbp)
   424f4:	89 75 d8             	mov    %esi,-0x28(%rbp)
   424f7:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   424fb:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   424ff:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42503:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42507:	48 8b 0a             	mov    (%rdx),%rcx
   4250a:	48 89 08             	mov    %rcx,(%rax)
   4250d:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42511:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42515:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42519:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   4251d:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42521:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42525:	48 89 d6             	mov    %rdx,%rsi
   42528:	48 89 c7             	mov    %rax,%rdi
   4252b:	e8 29 ff ff ff       	call   42459 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42530:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42534:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42538:	8b 75 d8             	mov    -0x28(%rbp),%esi
   4253b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4253e:	89 c7                	mov    %eax,%edi
   42540:	e8 02 1d 00 00       	call   44247 <console_vprintf>
}
   42545:	c9                   	leave  
   42546:	c3                   	ret    

0000000000042547 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42547:	f3 0f 1e fa          	endbr64 
   4254b:	55                   	push   %rbp
   4254c:	48 89 e5             	mov    %rsp,%rbp
   4254f:	48 83 ec 60          	sub    $0x60,%rsp
   42553:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42556:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42559:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   4255d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42561:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42565:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42569:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42570:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42574:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42578:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4257c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42580:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42584:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42588:	8b 75 a8             	mov    -0x58(%rbp),%esi
   4258b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4258e:	89 c7                	mov    %eax,%edi
   42590:	e8 50 ff ff ff       	call   424e5 <error_vprintf>
   42595:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42598:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4259b:	c9                   	leave  
   4259c:	c3                   	ret    

000000000004259d <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   4259d:	f3 0f 1e fa          	endbr64 
   425a1:	55                   	push   %rbp
   425a2:	48 89 e5             	mov    %rsp,%rbp
   425a5:	53                   	push   %rbx
   425a6:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   425aa:	e8 73 fb ff ff       	call   42122 <keyboard_readc>
   425af:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   425b2:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   425b6:	74 1c                	je     425d4 <check_keyboard+0x37>
   425b8:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   425bc:	74 16                	je     425d4 <check_keyboard+0x37>
   425be:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   425c2:	74 10                	je     425d4 <check_keyboard+0x37>
   425c4:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   425c8:	74 0a                	je     425d4 <check_keyboard+0x37>
   425ca:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   425ce:	0f 85 02 01 00 00    	jne    426d6 <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   425d4:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   425db:	00 
        memset(pt, 0, PAGESIZE * 3);
   425dc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   425e0:	ba 00 30 00 00       	mov    $0x3000,%edx
   425e5:	be 00 00 00 00       	mov    $0x0,%esi
   425ea:	48 89 c7             	mov    %rax,%rdi
   425ed:	e8 92 0e 00 00       	call   43484 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   425f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   425f6:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   425fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42601:	48 05 00 10 00 00    	add    $0x1000,%rax
   42607:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   4260e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42612:	48 05 00 20 00 00    	add    $0x2000,%rax
   42618:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   4261f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42623:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42627:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4262b:	0f 22 d8             	mov    %rax,%cr3
}
   4262e:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   4262f:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42636:	48 8d 05 3b 23 00 00 	lea    0x233b(%rip),%rax        # 44978 <complex_keymap+0x58>
   4263d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   42641:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42645:	75 0d                	jne    42654 <check_keyboard+0xb7>
            argument = "allocator";
   42647:	48 8d 05 2f 23 00 00 	lea    0x232f(%rip),%rax        # 4497d <complex_keymap+0x5d>
   4264e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42652:	eb 37                	jmp    4268b <check_keyboard+0xee>
        } else if (c == 'e') {
   42654:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42658:	75 0d                	jne    42667 <check_keyboard+0xca>
            argument = "forkexit";
   4265a:	48 8d 05 26 23 00 00 	lea    0x2326(%rip),%rax        # 44987 <complex_keymap+0x67>
   42661:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42665:	eb 24                	jmp    4268b <check_keyboard+0xee>
        }
        else if (c == 't'){
   42667:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4266b:	75 0d                	jne    4267a <check_keyboard+0xdd>
            argument = "test";
   4266d:	48 8d 05 1c 23 00 00 	lea    0x231c(%rip),%rax        # 44990 <complex_keymap+0x70>
   42674:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42678:	eb 11                	jmp    4268b <check_keyboard+0xee>
        }
        else if(c == '2'){
   4267a:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4267e:	75 0b                	jne    4268b <check_keyboard+0xee>
            argument = "test2";
   42680:	48 8d 05 0e 23 00 00 	lea    0x230e(%rip),%rax        # 44995 <complex_keymap+0x75>
   42687:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4268b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4268f:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42693:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42698:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   4269c:	76 1e                	jbe    426bc <check_keyboard+0x11f>
   4269e:	48 8d 05 f6 22 00 00 	lea    0x22f6(%rip),%rax        # 4499b <complex_keymap+0x7b>
   426a5:	48 89 c2             	mov    %rax,%rdx
   426a8:	be 5d 02 00 00       	mov    $0x25d,%esi
   426ad:	48 8d 05 03 23 00 00 	lea    0x2303(%rip),%rax        # 449b7 <complex_keymap+0x97>
   426b4:	48 89 c7             	mov    %rax,%rdi
   426b7:	e8 33 01 00 00       	call   427ef <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   426bc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   426c0:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   426c3:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   426c7:	48 89 c3             	mov    %rax,%rbx
   426ca:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   426cf:	e9 2c d9 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   426d4:	eb 11                	jmp    426e7 <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   426d6:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   426da:	74 06                	je     426e2 <check_keyboard+0x145>
   426dc:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   426e0:	75 05                	jne    426e7 <check_keyboard+0x14a>
        poweroff();
   426e2:	e8 3c f8 ff ff       	call   41f23 <poweroff>
    }
    return c;
   426e7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   426ea:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   426ee:	c9                   	leave  
   426ef:	c3                   	ret    

00000000000426f0 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   426f0:	f3 0f 1e fa          	endbr64 
   426f4:	55                   	push   %rbp
   426f5:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   426f8:	e8 a0 fe ff ff       	call   4259d <check_keyboard>
   426fd:	eb f9                	jmp    426f8 <fail+0x8>

00000000000426ff <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   426ff:	f3 0f 1e fa          	endbr64 
   42703:	55                   	push   %rbp
   42704:	48 89 e5             	mov    %rsp,%rbp
   42707:	48 83 ec 60          	sub    $0x60,%rsp
   4270b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4270f:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42713:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42717:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4271b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4271f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42723:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4272a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4272e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42732:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42736:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4273a:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   4273f:	0f 84 87 00 00 00    	je     427cc <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42745:	48 8d 05 7f 22 00 00 	lea    0x227f(%rip),%rax        # 449cb <complex_keymap+0xab>
   4274c:	48 89 c2             	mov    %rax,%rdx
   4274f:	be 00 c0 00 00       	mov    $0xc000,%esi
   42754:	bf 30 07 00 00       	mov    $0x730,%edi
   42759:	b8 00 00 00 00       	mov    $0x0,%eax
   4275e:	e8 e4 fd ff ff       	call   42547 <error_printf>
   42763:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42766:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4276a:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   4276e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42771:	be 00 c0 00 00       	mov    $0xc000,%esi
   42776:	89 c7                	mov    %eax,%edi
   42778:	e8 68 fd ff ff       	call   424e5 <error_vprintf>
   4277d:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42780:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42783:	48 63 c1             	movslq %ecx,%rax
   42786:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4278d:	48 c1 e8 20          	shr    $0x20,%rax
   42791:	c1 f8 05             	sar    $0x5,%eax
   42794:	89 ce                	mov    %ecx,%esi
   42796:	c1 fe 1f             	sar    $0x1f,%esi
   42799:	29 f0                	sub    %esi,%eax
   4279b:	89 c2                	mov    %eax,%edx
   4279d:	89 d0                	mov    %edx,%eax
   4279f:	c1 e0 02             	shl    $0x2,%eax
   427a2:	01 d0                	add    %edx,%eax
   427a4:	c1 e0 04             	shl    $0x4,%eax
   427a7:	29 c1                	sub    %eax,%ecx
   427a9:	89 ca                	mov    %ecx,%edx
   427ab:	85 d2                	test   %edx,%edx
   427ad:	74 3b                	je     427ea <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   427af:	8b 45 cc             	mov    -0x34(%rbp),%eax
   427b2:	48 8d 15 1a 22 00 00 	lea    0x221a(%rip),%rdx        # 449d3 <complex_keymap+0xb3>
   427b9:	be 00 c0 00 00       	mov    $0xc000,%esi
   427be:	89 c7                	mov    %eax,%edi
   427c0:	b8 00 00 00 00       	mov    $0x0,%eax
   427c5:	e8 7d fd ff ff       	call   42547 <error_printf>
   427ca:	eb 1e                	jmp    427ea <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   427cc:	48 8d 05 02 22 00 00 	lea    0x2202(%rip),%rax        # 449d5 <complex_keymap+0xb5>
   427d3:	48 89 c2             	mov    %rax,%rdx
   427d6:	be 00 c0 00 00       	mov    $0xc000,%esi
   427db:	bf 30 07 00 00       	mov    $0x730,%edi
   427e0:	b8 00 00 00 00       	mov    $0x0,%eax
   427e5:	e8 5d fd ff ff       	call   42547 <error_printf>
    }

    va_end(val);
    fail();
   427ea:	e8 01 ff ff ff       	call   426f0 <fail>

00000000000427ef <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   427ef:	f3 0f 1e fa          	endbr64 
   427f3:	55                   	push   %rbp
   427f4:	48 89 e5             	mov    %rsp,%rbp
   427f7:	48 83 ec 20          	sub    $0x20,%rsp
   427fb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   427ff:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42802:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42806:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4280a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4280d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42811:	48 89 c6             	mov    %rax,%rsi
   42814:	48 8d 05 c0 21 00 00 	lea    0x21c0(%rip),%rax        # 449db <complex_keymap+0xbb>
   4281b:	48 89 c7             	mov    %rax,%rdi
   4281e:	b8 00 00 00 00       	mov    $0x0,%eax
   42823:	e8 d7 fe ff ff       	call   426ff <panic>

0000000000042828 <default_exception>:
}

void default_exception(proc* p){
   42828:	f3 0f 1e fa          	endbr64 
   4282c:	55                   	push   %rbp
   4282d:	48 89 e5             	mov    %rsp,%rbp
   42830:	48 83 ec 20          	sub    $0x20,%rsp
   42834:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42838:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4283c:	48 83 c0 08          	add    $0x8,%rax
   42840:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42844:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42848:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4284f:	48 89 c6             	mov    %rax,%rsi
   42852:	48 8d 05 a0 21 00 00 	lea    0x21a0(%rip),%rax        # 449f9 <complex_keymap+0xd9>
   42859:	48 89 c7             	mov    %rax,%rdi
   4285c:	b8 00 00 00 00       	mov    $0x0,%eax
   42861:	e8 99 fe ff ff       	call   426ff <panic>

0000000000042866 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42866:	55                   	push   %rbp
   42867:	48 89 e5             	mov    %rsp,%rbp
   4286a:	48 83 ec 10          	sub    $0x10,%rsp
   4286e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42872:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42875:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42879:	78 06                	js     42881 <pageindex+0x1b>
   4287b:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   4287f:	7e 1e                	jle    4289f <pageindex+0x39>
   42881:	48 8d 05 90 21 00 00 	lea    0x2190(%rip),%rax        # 44a18 <complex_keymap+0xf8>
   42888:	48 89 c2             	mov    %rax,%rdx
   4288b:	be 1e 00 00 00       	mov    $0x1e,%esi
   42890:	48 8d 05 9a 21 00 00 	lea    0x219a(%rip),%rax        # 44a31 <complex_keymap+0x111>
   42897:	48 89 c7             	mov    %rax,%rdi
   4289a:	e8 50 ff ff ff       	call   427ef <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   4289f:	b8 03 00 00 00       	mov    $0x3,%eax
   428a4:	2b 45 f4             	sub    -0xc(%rbp),%eax
   428a7:	89 c2                	mov    %eax,%edx
   428a9:	89 d0                	mov    %edx,%eax
   428ab:	c1 e0 03             	shl    $0x3,%eax
   428ae:	01 d0                	add    %edx,%eax
   428b0:	83 c0 0c             	add    $0xc,%eax
   428b3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   428b7:	89 c1                	mov    %eax,%ecx
   428b9:	48 d3 ea             	shr    %cl,%rdx
   428bc:	48 89 d0             	mov    %rdx,%rax
   428bf:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   428c4:	c9                   	leave  
   428c5:	c3                   	ret    

00000000000428c6 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   428c6:	f3 0f 1e fa          	endbr64 
   428ca:	55                   	push   %rbp
   428cb:	48 89 e5             	mov    %rsp,%rbp
   428ce:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   428d2:	48 8d 05 27 37 01 00 	lea    0x13727(%rip),%rax        # 56000 <kernel_pagetables>
   428d9:	48 89 05 20 27 01 00 	mov    %rax,0x12720(%rip)        # 55000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   428e0:	ba 00 50 00 00       	mov    $0x5000,%edx
   428e5:	be 00 00 00 00       	mov    $0x0,%esi
   428ea:	48 8d 05 0f 37 01 00 	lea    0x1370f(%rip),%rax        # 56000 <kernel_pagetables>
   428f1:	48 89 c7             	mov    %rax,%rdi
   428f4:	e8 8b 0b 00 00       	call   43484 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   428f9:	48 8d 05 00 47 01 00 	lea    0x14700(%rip),%rax        # 57000 <kernel_pagetables+0x1000>
   42900:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42904:	48 89 05 f5 36 01 00 	mov    %rax,0x136f5(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   4290b:	48 8d 05 ee 56 01 00 	lea    0x156ee(%rip),%rax        # 58000 <kernel_pagetables+0x2000>
   42912:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42916:	48 89 05 e3 46 01 00 	mov    %rax,0x146e3(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   4291d:	48 8d 05 dc 66 01 00 	lea    0x166dc(%rip),%rax        # 59000 <kernel_pagetables+0x3000>
   42924:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42928:	48 89 05 d1 56 01 00 	mov    %rax,0x156d1(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   4292f:	48 8d 05 ca 76 01 00 	lea    0x176ca(%rip),%rax        # 5a000 <kernel_pagetables+0x4000>
   42936:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   4293a:	48 89 05 c7 56 01 00 	mov    %rax,0x156c7(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42941:	48 8b 05 b8 26 01 00 	mov    0x126b8(%rip),%rax        # 55000 <kernel_pagetable>
   42948:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4294e:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42953:	ba 00 00 00 00       	mov    $0x0,%edx
   42958:	be 00 00 00 00       	mov    $0x0,%esi
   4295d:	48 89 c7             	mov    %rax,%rdi
   42960:	e8 0e 02 00 00       	call   42b73 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42965:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4296c:	00 
   4296d:	eb 76                	jmp    429e5 <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   4296f:	48 8b 0d 8a 26 01 00 	mov    0x1268a(%rip),%rcx        # 55000 <kernel_pagetable>
   42976:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4297a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4297e:	48 89 ce             	mov    %rcx,%rsi
   42981:	48 89 c7             	mov    %rax,%rdi
   42984:	e8 34 06 00 00       	call   42fbd <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42989:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4298d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42991:	74 1e                	je     429b1 <virtual_memory_init+0xeb>
   42993:	48 8d 05 ab 20 00 00 	lea    0x20ab(%rip),%rax        # 44a45 <complex_keymap+0x125>
   4299a:	48 89 c2             	mov    %rax,%rdx
   4299d:	be 2d 00 00 00       	mov    $0x2d,%esi
   429a2:	48 8d 05 ac 20 00 00 	lea    0x20ac(%rip),%rax        # 44a55 <complex_keymap+0x135>
   429a9:	48 89 c7             	mov    %rax,%rdi
   429ac:	e8 3e fe ff ff       	call   427ef <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   429b1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   429b4:	48 98                	cltq   
   429b6:	83 e0 03             	and    $0x3,%eax
   429b9:	48 83 f8 03          	cmp    $0x3,%rax
   429bd:	74 1e                	je     429dd <virtual_memory_init+0x117>
   429bf:	48 8d 05 a2 20 00 00 	lea    0x20a2(%rip),%rax        # 44a68 <complex_keymap+0x148>
   429c6:	48 89 c2             	mov    %rax,%rdx
   429c9:	be 2e 00 00 00       	mov    $0x2e,%esi
   429ce:	48 8d 05 80 20 00 00 	lea    0x2080(%rip),%rax        # 44a55 <complex_keymap+0x135>
   429d5:	48 89 c7             	mov    %rax,%rdi
   429d8:	e8 12 fe ff ff       	call   427ef <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   429dd:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   429e4:	00 
   429e5:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   429ec:	00 
   429ed:	76 80                	jbe    4296f <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   429ef:	48 8b 05 0a 26 01 00 	mov    0x1260a(%rip),%rax        # 55000 <kernel_pagetable>
   429f6:	48 89 c7             	mov    %rax,%rdi
   429f9:	e8 03 00 00 00       	call   42a01 <set_pagetable>
}
   429fe:	90                   	nop
   429ff:	c9                   	leave  
   42a00:	c3                   	ret    

0000000000042a01 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42a01:	f3 0f 1e fa          	endbr64 
   42a05:	55                   	push   %rbp
   42a06:	48 89 e5             	mov    %rsp,%rbp
   42a09:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42a0d:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42a11:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42a15:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a1a:	48 85 c0             	test   %rax,%rax
   42a1d:	74 1e                	je     42a3d <set_pagetable+0x3c>
   42a1f:	48 8d 05 6f 20 00 00 	lea    0x206f(%rip),%rax        # 44a95 <complex_keymap+0x175>
   42a26:	48 89 c2             	mov    %rax,%rdx
   42a29:	be 3d 00 00 00       	mov    $0x3d,%esi
   42a2e:	48 8d 05 20 20 00 00 	lea    0x2020(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42a35:	48 89 c7             	mov    %rax,%rdi
   42a38:	e8 b2 fd ff ff       	call   427ef <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42a3d:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   42a44:	48 89 c2             	mov    %rax,%rdx
   42a47:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42a4b:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42a4f:	48 89 ce             	mov    %rcx,%rsi
   42a52:	48 89 c7             	mov    %rax,%rdi
   42a55:	e8 63 05 00 00       	call   42fbd <virtual_memory_lookup>
   42a5a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42a5e:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   42a65:	48 39 d0             	cmp    %rdx,%rax
   42a68:	74 1e                	je     42a88 <set_pagetable+0x87>
   42a6a:	48 8d 05 3f 20 00 00 	lea    0x203f(%rip),%rax        # 44ab0 <complex_keymap+0x190>
   42a71:	48 89 c2             	mov    %rax,%rdx
   42a74:	be 3f 00 00 00       	mov    $0x3f,%esi
   42a79:	48 8d 05 d5 1f 00 00 	lea    0x1fd5(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42a80:	48 89 c7             	mov    %rax,%rdi
   42a83:	e8 67 fd ff ff       	call   427ef <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42a88:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42a8c:	48 8b 0d 6d 25 01 00 	mov    0x1256d(%rip),%rcx        # 55000 <kernel_pagetable>
   42a93:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42a97:	48 89 ce             	mov    %rcx,%rsi
   42a9a:	48 89 c7             	mov    %rax,%rdi
   42a9d:	e8 1b 05 00 00       	call   42fbd <virtual_memory_lookup>
   42aa2:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42aa6:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42aaa:	48 39 c2             	cmp    %rax,%rdx
   42aad:	74 1e                	je     42acd <set_pagetable+0xcc>
   42aaf:	48 8d 05 62 20 00 00 	lea    0x2062(%rip),%rax        # 44b18 <complex_keymap+0x1f8>
   42ab6:	48 89 c2             	mov    %rax,%rdx
   42ab9:	be 41 00 00 00       	mov    $0x41,%esi
   42abe:	48 8d 05 90 1f 00 00 	lea    0x1f90(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42ac5:	48 89 c7             	mov    %rax,%rdi
   42ac8:	e8 22 fd ff ff       	call   427ef <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42acd:	48 8b 05 2c 25 01 00 	mov    0x1252c(%rip),%rax        # 55000 <kernel_pagetable>
   42ad4:	48 89 c2             	mov    %rax,%rdx
   42ad7:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42adb:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42adf:	48 89 ce             	mov    %rcx,%rsi
   42ae2:	48 89 c7             	mov    %rax,%rdi
   42ae5:	e8 d3 04 00 00       	call   42fbd <virtual_memory_lookup>
   42aea:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42aee:	48 8b 15 0b 25 01 00 	mov    0x1250b(%rip),%rdx        # 55000 <kernel_pagetable>
   42af5:	48 39 d0             	cmp    %rdx,%rax
   42af8:	74 1e                	je     42b18 <set_pagetable+0x117>
   42afa:	48 8d 05 77 20 00 00 	lea    0x2077(%rip),%rax        # 44b78 <complex_keymap+0x258>
   42b01:	48 89 c2             	mov    %rax,%rdx
   42b04:	be 43 00 00 00       	mov    $0x43,%esi
   42b09:	48 8d 05 45 1f 00 00 	lea    0x1f45(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42b10:	48 89 c7             	mov    %rax,%rdi
   42b13:	e8 d7 fc ff ff       	call   427ef <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42b18:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 42b73 <virtual_memory_map>
   42b1f:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42b23:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42b27:	48 89 ce             	mov    %rcx,%rsi
   42b2a:	48 89 c7             	mov    %rax,%rdi
   42b2d:	e8 8b 04 00 00       	call   42fbd <virtual_memory_lookup>
   42b32:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b36:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 42b73 <virtual_memory_map>
   42b3d:	48 39 d0             	cmp    %rdx,%rax
   42b40:	74 1e                	je     42b60 <set_pagetable+0x15f>
   42b42:	48 8d 05 97 20 00 00 	lea    0x2097(%rip),%rax        # 44be0 <complex_keymap+0x2c0>
   42b49:	48 89 c2             	mov    %rax,%rdx
   42b4c:	be 45 00 00 00       	mov    $0x45,%esi
   42b51:	48 8d 05 fd 1e 00 00 	lea    0x1efd(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42b58:	48 89 c7             	mov    %rax,%rdi
   42b5b:	e8 8f fc ff ff       	call   427ef <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42b60:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42b64:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42b68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b6c:	0f 22 d8             	mov    %rax,%cr3
}
   42b6f:	90                   	nop
}
   42b70:	90                   	nop
   42b71:	c9                   	leave  
   42b72:	c3                   	ret    

0000000000042b73 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42b73:	f3 0f 1e fa          	endbr64 
   42b77:	55                   	push   %rbp
   42b78:	48 89 e5             	mov    %rsp,%rbp
   42b7b:	48 83 ec 50          	sub    $0x50,%rsp
   42b7f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42b83:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42b87:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42b8b:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   42b8f:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42b93:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b97:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b9c:	48 85 c0             	test   %rax,%rax
   42b9f:	74 1e                	je     42bbf <virtual_memory_map+0x4c>
   42ba1:	48 8d 05 9e 20 00 00 	lea    0x209e(%rip),%rax        # 44c46 <complex_keymap+0x326>
   42ba8:	48 89 c2             	mov    %rax,%rdx
   42bab:	be 66 00 00 00       	mov    $0x66,%esi
   42bb0:	48 8d 05 9e 1e 00 00 	lea    0x1e9e(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42bb7:	48 89 c7             	mov    %rax,%rdi
   42bba:	e8 30 fc ff ff       	call   427ef <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42bbf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42bc3:	25 ff 0f 00 00       	and    $0xfff,%eax
   42bc8:	48 85 c0             	test   %rax,%rax
   42bcb:	74 1e                	je     42beb <virtual_memory_map+0x78>
   42bcd:	48 8d 05 85 20 00 00 	lea    0x2085(%rip),%rax        # 44c59 <complex_keymap+0x339>
   42bd4:	48 89 c2             	mov    %rax,%rdx
   42bd7:	be 67 00 00 00       	mov    $0x67,%esi
   42bdc:	48 8d 05 72 1e 00 00 	lea    0x1e72(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42be3:	48 89 c7             	mov    %rax,%rdi
   42be6:	e8 04 fc ff ff       	call   427ef <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42beb:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42bef:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42bf3:	48 01 d0             	add    %rdx,%rax
   42bf6:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42bfa:	76 2e                	jbe    42c2a <virtual_memory_map+0xb7>
   42bfc:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42c00:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c04:	48 01 d0             	add    %rdx,%rax
   42c07:	48 85 c0             	test   %rax,%rax
   42c0a:	74 1e                	je     42c2a <virtual_memory_map+0xb7>
   42c0c:	48 8d 05 59 20 00 00 	lea    0x2059(%rip),%rax        # 44c6c <complex_keymap+0x34c>
   42c13:	48 89 c2             	mov    %rax,%rdx
   42c16:	be 68 00 00 00       	mov    $0x68,%esi
   42c1b:	48 8d 05 33 1e 00 00 	lea    0x1e33(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42c22:	48 89 c7             	mov    %rax,%rdi
   42c25:	e8 c5 fb ff ff       	call   427ef <assert_fail>
    if (perm & PTE_P) {
   42c2a:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42c2d:	48 98                	cltq   
   42c2f:	83 e0 01             	and    $0x1,%eax
   42c32:	48 85 c0             	test   %rax,%rax
   42c35:	0f 84 8c 00 00 00    	je     42cc7 <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42c3b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c3f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c44:	48 85 c0             	test   %rax,%rax
   42c47:	74 1e                	je     42c67 <virtual_memory_map+0xf4>
   42c49:	48 8d 05 3a 20 00 00 	lea    0x203a(%rip),%rax        # 44c8a <complex_keymap+0x36a>
   42c50:	48 89 c2             	mov    %rax,%rdx
   42c53:	be 6a 00 00 00       	mov    $0x6a,%esi
   42c58:	48 8d 05 f6 1d 00 00 	lea    0x1df6(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42c5f:	48 89 c7             	mov    %rax,%rdi
   42c62:	e8 88 fb ff ff       	call   427ef <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42c67:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42c6b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c6f:	48 01 d0             	add    %rdx,%rax
   42c72:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   42c76:	76 1e                	jbe    42c96 <virtual_memory_map+0x123>
   42c78:	48 8d 05 1e 20 00 00 	lea    0x201e(%rip),%rax        # 44c9d <complex_keymap+0x37d>
   42c7f:	48 89 c2             	mov    %rax,%rdx
   42c82:	be 6b 00 00 00       	mov    $0x6b,%esi
   42c87:	48 8d 05 c7 1d 00 00 	lea    0x1dc7(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42c8e:	48 89 c7             	mov    %rax,%rdi
   42c91:	e8 59 fb ff ff       	call   427ef <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42c96:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42c9a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c9e:	48 01 d0             	add    %rdx,%rax
   42ca1:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42ca7:	76 1e                	jbe    42cc7 <virtual_memory_map+0x154>
   42ca9:	48 8d 05 fb 1f 00 00 	lea    0x1ffb(%rip),%rax        # 44cab <complex_keymap+0x38b>
   42cb0:	48 89 c2             	mov    %rax,%rdx
   42cb3:	be 6c 00 00 00       	mov    $0x6c,%esi
   42cb8:	48 8d 05 96 1d 00 00 	lea    0x1d96(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42cbf:	48 89 c7             	mov    %rax,%rdi
   42cc2:	e8 28 fb ff ff       	call   427ef <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42cc7:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   42ccb:	78 09                	js     42cd6 <virtual_memory_map+0x163>
   42ccd:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   42cd4:	7e 1e                	jle    42cf4 <virtual_memory_map+0x181>
   42cd6:	48 8d 05 ea 1f 00 00 	lea    0x1fea(%rip),%rax        # 44cc7 <complex_keymap+0x3a7>
   42cdd:	48 89 c2             	mov    %rax,%rdx
   42ce0:	be 6e 00 00 00       	mov    $0x6e,%esi
   42ce5:	48 8d 05 69 1d 00 00 	lea    0x1d69(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42cec:	48 89 c7             	mov    %rax,%rdi
   42cef:	e8 fb fa ff ff       	call   427ef <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42cf4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cf8:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cfd:	48 85 c0             	test   %rax,%rax
   42d00:	74 1e                	je     42d20 <virtual_memory_map+0x1ad>
   42d02:	48 8d 05 df 1f 00 00 	lea    0x1fdf(%rip),%rax        # 44ce8 <complex_keymap+0x3c8>
   42d09:	48 89 c2             	mov    %rax,%rdx
   42d0c:	be 6f 00 00 00       	mov    $0x6f,%esi
   42d11:	48 8d 05 3d 1d 00 00 	lea    0x1d3d(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42d18:	48 89 c7             	mov    %rax,%rdi
   42d1b:	e8 cf fa ff ff       	call   427ef <assert_fail>

    int last_index123 = -1;
   42d20:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42d27:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   42d2e:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42d2f:	e9 ed 00 00 00       	jmp    42e21 <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42d34:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42d38:	48 c1 e8 15          	shr    $0x15,%rax
   42d3c:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   42d3f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42d42:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   42d45:	74 20                	je     42d67 <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   42d47:	8b 55 bc             	mov    -0x44(%rbp),%edx
   42d4a:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   42d4e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d52:	48 89 ce             	mov    %rcx,%rsi
   42d55:	48 89 c7             	mov    %rax,%rdi
   42d58:	e8 d6 00 00 00       	call   42e33 <lookup_l1pagetable>
   42d5d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   42d61:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42d64:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42d67:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42d6a:	48 98                	cltq   
   42d6c:	83 e0 01             	and    $0x1,%eax
   42d6f:	48 85 c0             	test   %rax,%rax
   42d72:	74 37                	je     42dab <virtual_memory_map+0x238>
   42d74:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   42d79:	74 30                	je     42dab <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   42d7b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42d7f:	be 03 00 00 00       	mov    $0x3,%esi
   42d84:	48 89 c7             	mov    %rax,%rdi
   42d87:	e8 da fa ff ff       	call   42866 <pageindex>
   42d8c:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   42d8f:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42d92:	48 98                	cltq   
   42d94:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   42d98:	48 89 c1             	mov    %rax,%rcx
   42d9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d9f:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42da2:	48 63 d2             	movslq %edx,%rdx
   42da5:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42da9:	eb 5e                	jmp    42e09 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   42dab:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   42db0:	74 2a                	je     42ddc <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   42db2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42db6:	be 03 00 00 00       	mov    $0x3,%esi
   42dbb:	48 89 c7             	mov    %rax,%rdi
   42dbe:	e8 a3 fa ff ff       	call   42866 <pageindex>
   42dc3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   42dc6:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42dc9:	48 63 c8             	movslq %eax,%rcx
   42dcc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dd0:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42dd3:	48 63 d2             	movslq %edx,%rdx
   42dd6:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42dda:	eb 2d                	jmp    42e09 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   42ddc:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42ddf:	48 98                	cltq   
   42de1:	83 e0 01             	and    $0x1,%eax
   42de4:	48 85 c0             	test   %rax,%rax
   42de7:	74 20                	je     42e09 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42de9:	be 88 00 00 00       	mov    $0x88,%esi
   42dee:	48 8d 05 1b 1f 00 00 	lea    0x1f1b(%rip),%rax        # 44d10 <complex_keymap+0x3f0>
   42df5:	48 89 c7             	mov    %rax,%rdi
   42df8:	b8 00 00 00 00       	mov    $0x0,%eax
   42dfd:	e8 92 f6 ff ff       	call   42494 <log_printf>
            return -1;
   42e02:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42e07:	eb 28                	jmp    42e31 <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42e09:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   42e10:	00 
   42e11:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   42e18:	00 
   42e19:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   42e20:	00 
   42e21:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   42e26:	0f 85 08 ff ff ff    	jne    42d34 <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   42e2c:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42e31:	c9                   	leave  
   42e32:	c3                   	ret    

0000000000042e33 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42e33:	f3 0f 1e fa          	endbr64 
   42e37:	55                   	push   %rbp
   42e38:	48 89 e5             	mov    %rsp,%rbp
   42e3b:	48 83 ec 40          	sub    $0x40,%rsp
   42e3f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42e43:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42e47:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42e4a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42e52:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42e59:	e9 4f 01 00 00       	jmp    42fad <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
                int index = PAGEINDEX(va, i); // Get the index for the current level
   42e5e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42e61:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42e65:	89 d6                	mov    %edx,%esi
   42e67:	48 89 c7             	mov    %rax,%rdi
   42e6a:	e8 f7 f9 ff ff       	call   42866 <pageindex>
   42e6f:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   42e72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e76:	8b 55 f0             	mov    -0x10(%rbp),%edx
   42e79:	48 63 d2             	movslq %edx,%rdx
   42e7c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42e80:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42e84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e88:	83 e0 01             	and    $0x1,%eax
   42e8b:	48 85 c0             	test   %rax,%rax
   42e8e:	75 6d                	jne    42efd <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42e90:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42e93:	8d 48 02             	lea    0x2(%rax),%ecx
   42e96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e9a:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e9f:	48 89 c2             	mov    %rax,%rdx
   42ea2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ea6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42eac:	48 89 c6             	mov    %rax,%rsi
   42eaf:	48 8d 05 a2 1e 00 00 	lea    0x1ea2(%rip),%rax        # 44d58 <complex_keymap+0x438>
   42eb6:	48 89 c7             	mov    %rax,%rdi
   42eb9:	b8 00 00 00 00       	mov    $0x0,%eax
   42ebe:	e8 d1 f5 ff ff       	call   42494 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42ec3:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42ec6:	48 98                	cltq   
   42ec8:	83 e0 01             	and    $0x1,%eax
   42ecb:	48 85 c0             	test   %rax,%rax
   42ece:	75 0a                	jne    42eda <lookup_l1pagetable+0xa7>
                return NULL;
   42ed0:	b8 00 00 00 00       	mov    $0x0,%eax
   42ed5:	e9 e1 00 00 00       	jmp    42fbb <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42eda:	be ad 00 00 00       	mov    $0xad,%esi
   42edf:	48 8d 05 da 1e 00 00 	lea    0x1eda(%rip),%rax        # 44dc0 <complex_keymap+0x4a0>
   42ee6:	48 89 c7             	mov    %rax,%rdi
   42ee9:	b8 00 00 00 00       	mov    $0x0,%eax
   42eee:	e8 a1 f5 ff ff       	call   42494 <log_printf>
            return NULL;
   42ef3:	b8 00 00 00 00       	mov    $0x0,%eax
   42ef8:	e9 be 00 00 00       	jmp    42fbb <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42efd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f01:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42f07:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42f0d:	76 1e                	jbe    42f2d <lookup_l1pagetable+0xfa>
   42f0f:	48 8d 05 f2 1e 00 00 	lea    0x1ef2(%rip),%rax        # 44e08 <complex_keymap+0x4e8>
   42f16:	48 89 c2             	mov    %rax,%rdx
   42f19:	be b2 00 00 00       	mov    $0xb2,%esi
   42f1e:	48 8d 05 30 1b 00 00 	lea    0x1b30(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42f25:	48 89 c7             	mov    %rax,%rdi
   42f28:	e8 c2 f8 ff ff       	call   427ef <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42f2d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42f30:	48 98                	cltq   
   42f32:	83 e0 02             	and    $0x2,%eax
   42f35:	48 85 c0             	test   %rax,%rax
   42f38:	74 2a                	je     42f64 <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42f3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f3e:	83 e0 02             	and    $0x2,%eax
   42f41:	48 85 c0             	test   %rax,%rax
   42f44:	75 1e                	jne    42f64 <lookup_l1pagetable+0x131>
   42f46:	48 8d 05 db 1e 00 00 	lea    0x1edb(%rip),%rax        # 44e28 <complex_keymap+0x508>
   42f4d:	48 89 c2             	mov    %rax,%rdx
   42f50:	be b4 00 00 00       	mov    $0xb4,%esi
   42f55:	48 8d 05 f9 1a 00 00 	lea    0x1af9(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42f5c:	48 89 c7             	mov    %rax,%rdi
   42f5f:	e8 8b f8 ff ff       	call   427ef <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42f64:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42f67:	48 98                	cltq   
   42f69:	83 e0 04             	and    $0x4,%eax
   42f6c:	48 85 c0             	test   %rax,%rax
   42f6f:	74 2a                	je     42f9b <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42f71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f75:	83 e0 04             	and    $0x4,%eax
   42f78:	48 85 c0             	test   %rax,%rax
   42f7b:	75 1e                	jne    42f9b <lookup_l1pagetable+0x168>
   42f7d:	48 8d 05 af 1e 00 00 	lea    0x1eaf(%rip),%rax        # 44e33 <complex_keymap+0x513>
   42f84:	48 89 c2             	mov    %rax,%rdx
   42f87:	be b7 00 00 00       	mov    $0xb7,%esi
   42f8c:	48 8d 05 c2 1a 00 00 	lea    0x1ac2(%rip),%rax        # 44a55 <complex_keymap+0x135>
   42f93:	48 89 c7             	mov    %rax,%rdi
   42f96:	e8 54 f8 ff ff       	call   427ef <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42f9b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f9f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42fa5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42fa9:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42fad:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42fb1:	0f 8e a7 fe ff ff    	jle    42e5e <lookup_l1pagetable+0x2b>
    }
    return pt;
   42fb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42fbb:	c9                   	leave  
   42fbc:	c3                   	ret    

0000000000042fbd <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42fbd:	f3 0f 1e fa          	endbr64 
   42fc1:	55                   	push   %rbp
   42fc2:	48 89 e5             	mov    %rsp,%rbp
   42fc5:	48 83 ec 50          	sub    $0x50,%rsp
   42fc9:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42fcd:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42fd1:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42fd5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42fd9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42fdd:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42fe4:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42fe5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42fec:	eb 41                	jmp    4302f <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42fee:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42ff1:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42ff5:	89 d6                	mov    %edx,%esi
   42ff7:	48 89 c7             	mov    %rax,%rdi
   42ffa:	e8 67 f8 ff ff       	call   42866 <pageindex>
   42fff:	89 c2                	mov    %eax,%edx
   43001:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43005:	48 63 d2             	movslq %edx,%rdx
   43008:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   4300c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43010:	83 e0 06             	and    $0x6,%eax
   43013:	48 f7 d0             	not    %rax
   43016:	48 21 d0             	and    %rdx,%rax
   43019:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   4301d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43021:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43027:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4302b:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   4302f:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   43033:	7f 0c                	jg     43041 <virtual_memory_lookup+0x84>
   43035:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43039:	83 e0 01             	and    $0x1,%eax
   4303c:	48 85 c0             	test   %rax,%rax
   4303f:	75 ad                	jne    42fee <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   43041:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43048:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   4304f:	ff 
   43050:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   43057:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4305b:	83 e0 01             	and    $0x1,%eax
   4305e:	48 85 c0             	test   %rax,%rax
   43061:	74 34                	je     43097 <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   43063:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43067:	48 c1 e8 0c          	shr    $0xc,%rax
   4306b:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   4306e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43072:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43078:	48 89 c2             	mov    %rax,%rdx
   4307b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4307f:	25 ff 0f 00 00       	and    $0xfff,%eax
   43084:	48 09 d0             	or     %rdx,%rax
   43087:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   4308b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4308f:	25 ff 0f 00 00       	and    $0xfff,%eax
   43094:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   43097:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4309b:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4309f:	48 89 10             	mov    %rdx,(%rax)
   430a2:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   430a6:	48 89 50 08          	mov    %rdx,0x8(%rax)
   430aa:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   430ae:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   430b2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   430b6:	c9                   	leave  
   430b7:	c3                   	ret    

00000000000430b8 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   430b8:	f3 0f 1e fa          	endbr64 
   430bc:	55                   	push   %rbp
   430bd:	48 89 e5             	mov    %rsp,%rbp
   430c0:	48 83 ec 40          	sub    $0x40,%rsp
   430c4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   430c8:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   430cb:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   430cf:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   430d6:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   430da:	78 08                	js     430e4 <program_load+0x2c>
   430dc:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   430df:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   430e2:	7c 1e                	jl     43102 <program_load+0x4a>
   430e4:	48 8d 05 55 1d 00 00 	lea    0x1d55(%rip),%rax        # 44e40 <complex_keymap+0x520>
   430eb:	48 89 c2             	mov    %rax,%rdx
   430ee:	be 37 00 00 00       	mov    $0x37,%esi
   430f3:	48 8d 05 76 1d 00 00 	lea    0x1d76(%rip),%rax        # 44e70 <complex_keymap+0x550>
   430fa:	48 89 c7             	mov    %rax,%rdi
   430fd:	e8 ed f6 ff ff       	call   427ef <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   43102:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43105:	48 98                	cltq   
   43107:	48 c1 e0 04          	shl    $0x4,%rax
   4310b:	48 89 c2             	mov    %rax,%rdx
   4310e:	48 8d 05 0b 2f 00 00 	lea    0x2f0b(%rip),%rax        # 46020 <ramimages>
   43115:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   43119:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   4311d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43121:	8b 00                	mov    (%rax),%eax
   43123:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43128:	74 1e                	je     43148 <program_load+0x90>
   4312a:	48 8d 05 51 1d 00 00 	lea    0x1d51(%rip),%rax        # 44e82 <complex_keymap+0x562>
   43131:	48 89 c2             	mov    %rax,%rdx
   43134:	be 39 00 00 00       	mov    $0x39,%esi
   43139:	48 8d 05 30 1d 00 00 	lea    0x1d30(%rip),%rax        # 44e70 <complex_keymap+0x550>
   43140:	48 89 c7             	mov    %rax,%rdi
   43143:	e8 a7 f6 ff ff       	call   427ef <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43148:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4314c:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43150:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43154:	48 01 d0             	add    %rdx,%rax
   43157:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   4315b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43162:	e9 94 00 00 00       	jmp    431fb <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43167:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4316a:	48 63 d0             	movslq %eax,%rdx
   4316d:	48 89 d0             	mov    %rdx,%rax
   43170:	48 c1 e0 03          	shl    $0x3,%rax
   43174:	48 29 d0             	sub    %rdx,%rax
   43177:	48 c1 e0 03          	shl    $0x3,%rax
   4317b:	48 89 c2             	mov    %rax,%rdx
   4317e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43182:	48 01 d0             	add    %rdx,%rax
   43185:	8b 00                	mov    (%rax),%eax
   43187:	83 f8 01             	cmp    $0x1,%eax
   4318a:	75 6b                	jne    431f7 <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   4318c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4318f:	48 63 d0             	movslq %eax,%rdx
   43192:	48 89 d0             	mov    %rdx,%rax
   43195:	48 c1 e0 03          	shl    $0x3,%rax
   43199:	48 29 d0             	sub    %rdx,%rax
   4319c:	48 c1 e0 03          	shl    $0x3,%rax
   431a0:	48 89 c2             	mov    %rax,%rdx
   431a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431a7:	48 01 d0             	add    %rdx,%rax
   431aa:	48 8b 50 08          	mov    0x8(%rax),%rdx
   431ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431b2:	48 01 d0             	add    %rdx,%rax
   431b5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   431b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   431bc:	48 63 d0             	movslq %eax,%rdx
   431bf:	48 89 d0             	mov    %rdx,%rax
   431c2:	48 c1 e0 03          	shl    $0x3,%rax
   431c6:	48 29 d0             	sub    %rdx,%rax
   431c9:	48 c1 e0 03          	shl    $0x3,%rax
   431cd:	48 89 c2             	mov    %rax,%rdx
   431d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431d4:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   431d8:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   431dc:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   431e0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   431e4:	48 89 c7             	mov    %rax,%rdi
   431e7:	e8 3d 00 00 00       	call   43229 <program_load_segment>
   431ec:	85 c0                	test   %eax,%eax
   431ee:	79 07                	jns    431f7 <program_load+0x13f>
                return -1;
   431f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   431f5:	eb 30                	jmp    43227 <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   431f7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   431fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431ff:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   43203:	0f b7 c0             	movzwl %ax,%eax
   43206:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43209:	0f 8c 58 ff ff ff    	jl     43167 <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   4320f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43213:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43217:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4321b:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   43222:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43227:	c9                   	leave  
   43228:	c3                   	ret    

0000000000043229 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43229:	f3 0f 1e fa          	endbr64 
   4322d:	55                   	push   %rbp
   4322e:	48 89 e5             	mov    %rsp,%rbp
   43231:	48 83 ec 40          	sub    $0x40,%rsp
   43235:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43239:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4323d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43241:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   43245:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43249:	48 8b 40 10          	mov    0x10(%rax),%rax
   4324d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   43251:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43255:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43259:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4325d:	48 01 d0             	add    %rdx,%rax
   43260:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43264:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43268:	48 8b 50 28          	mov    0x28(%rax),%rdx
   4326c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43270:	48 01 d0             	add    %rdx,%rax
   43273:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43277:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   4327e:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4327f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43283:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43287:	e9 81 00 00 00       	jmp    4330d <program_load_segment+0xe4>
        if (assign_physical_page(addr, p->p_pid) < 0
   4328c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43290:	8b 00                	mov    (%rax),%eax
   43292:	0f be d0             	movsbl %al,%edx
   43295:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43299:	89 d6                	mov    %edx,%esi
   4329b:	48 89 c7             	mov    %rax,%rdi
   4329e:	e8 66 d3 ff ff       	call   40609 <assign_physical_page>
   432a3:	85 c0                	test   %eax,%eax
   432a5:	78 2a                	js     432d1 <program_load_segment+0xa8>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   432a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432ab:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   432b2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   432b6:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   432ba:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   432c0:	b9 00 10 00 00       	mov    $0x1000,%ecx
   432c5:	48 89 c7             	mov    %rax,%rdi
   432c8:	e8 a6 f8 ff ff       	call   42b73 <virtual_memory_map>
   432cd:	85 c0                	test   %eax,%eax
   432cf:	79 34                	jns    43305 <program_load_segment+0xdc>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   432d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432d5:	8b 00                	mov    (%rax),%eax
   432d7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   432db:	49 89 d0             	mov    %rdx,%r8
   432de:	89 c1                	mov    %eax,%ecx
   432e0:	48 8d 05 b9 1b 00 00 	lea    0x1bb9(%rip),%rax        # 44ea0 <complex_keymap+0x580>
   432e7:	48 89 c2             	mov    %rax,%rdx
   432ea:	be 00 c0 00 00       	mov    $0xc000,%esi
   432ef:	bf e0 06 00 00       	mov    $0x6e0,%edi
   432f4:	b8 00 00 00 00       	mov    $0x0,%eax
   432f9:	e8 c5 0f 00 00       	call   442c3 <console_printf>
            return -1;
   432fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43303:	eb 77                	jmp    4337c <program_load_segment+0x153>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43305:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4330c:	00 
   4330d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43311:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43315:	0f 82 71 ff ff ff    	jb     4328c <program_load_segment+0x63>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   4331b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4331f:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43326:	48 89 c7             	mov    %rax,%rdi
   43329:	e8 d3 f6 ff ff       	call   42a01 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   4332e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43332:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   43336:	48 89 c2             	mov    %rax,%rdx
   43339:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4333d:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   43341:	48 89 ce             	mov    %rcx,%rsi
   43344:	48 89 c7             	mov    %rax,%rdi
   43347:	e8 32 00 00 00       	call   4337e <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   4334c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43350:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   43354:	48 89 c2             	mov    %rax,%rdx
   43357:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4335b:	be 00 00 00 00       	mov    $0x0,%esi
   43360:	48 89 c7             	mov    %rax,%rdi
   43363:	e8 1c 01 00 00       	call   43484 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43368:	48 8b 05 91 1c 01 00 	mov    0x11c91(%rip),%rax        # 55000 <kernel_pagetable>
   4336f:	48 89 c7             	mov    %rax,%rdi
   43372:	e8 8a f6 ff ff       	call   42a01 <set_pagetable>
    return 0;
   43377:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4337c:	c9                   	leave  
   4337d:	c3                   	ret    

000000000004337e <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   4337e:	f3 0f 1e fa          	endbr64 
   43382:	55                   	push   %rbp
   43383:	48 89 e5             	mov    %rsp,%rbp
   43386:	48 83 ec 28          	sub    $0x28,%rsp
   4338a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4338e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43392:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43396:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4339a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4339e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433a2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   433a6:	eb 1c                	jmp    433c4 <memcpy+0x46>
        *d = *s;
   433a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433ac:	0f b6 10             	movzbl (%rax),%edx
   433af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433b3:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   433b5:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   433ba:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   433bf:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   433c4:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   433c9:	75 dd                	jne    433a8 <memcpy+0x2a>
    }
    return dst;
   433cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   433cf:	c9                   	leave  
   433d0:	c3                   	ret    

00000000000433d1 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   433d1:	f3 0f 1e fa          	endbr64 
   433d5:	55                   	push   %rbp
   433d6:	48 89 e5             	mov    %rsp,%rbp
   433d9:	48 83 ec 28          	sub    $0x28,%rsp
   433dd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   433e1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   433e5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   433e9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   433f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433f5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   433f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433fd:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43401:	73 6a                	jae    4346d <memmove+0x9c>
   43403:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43407:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4340b:	48 01 d0             	add    %rdx,%rax
   4340e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43412:	73 59                	jae    4346d <memmove+0x9c>
        s += n, d += n;
   43414:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43418:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   4341c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43420:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43424:	eb 17                	jmp    4343d <memmove+0x6c>
            *--d = *--s;
   43426:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   4342b:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43430:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43434:	0f b6 10             	movzbl (%rax),%edx
   43437:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4343b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   4343d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43441:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43445:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43449:	48 85 c0             	test   %rax,%rax
   4344c:	75 d8                	jne    43426 <memmove+0x55>
    if (s < d && s + n > d) {
   4344e:	eb 2e                	jmp    4347e <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43450:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43454:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43458:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4345c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43460:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43464:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43468:	0f b6 12             	movzbl (%rdx),%edx
   4346b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   4346d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43471:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43475:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43479:	48 85 c0             	test   %rax,%rax
   4347c:	75 d2                	jne    43450 <memmove+0x7f>
        }
    }
    return dst;
   4347e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43482:	c9                   	leave  
   43483:	c3                   	ret    

0000000000043484 <memset>:

void* memset(void* v, int c, size_t n) {
   43484:	f3 0f 1e fa          	endbr64 
   43488:	55                   	push   %rbp
   43489:	48 89 e5             	mov    %rsp,%rbp
   4348c:	48 83 ec 28          	sub    $0x28,%rsp
   43490:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43494:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43497:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4349b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4349f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   434a3:	eb 15                	jmp    434ba <memset+0x36>
        *p = c;
   434a5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   434a8:	89 c2                	mov    %eax,%edx
   434aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434ae:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   434b0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   434b5:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   434ba:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   434bf:	75 e4                	jne    434a5 <memset+0x21>
    }
    return v;
   434c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   434c5:	c9                   	leave  
   434c6:	c3                   	ret    

00000000000434c7 <strlen>:

size_t strlen(const char* s) {
   434c7:	f3 0f 1e fa          	endbr64 
   434cb:	55                   	push   %rbp
   434cc:	48 89 e5             	mov    %rsp,%rbp
   434cf:	48 83 ec 18          	sub    $0x18,%rsp
   434d3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   434d7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   434de:	00 
   434df:	eb 0a                	jmp    434eb <strlen+0x24>
        ++n;
   434e1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   434e6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   434eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434ef:	0f b6 00             	movzbl (%rax),%eax
   434f2:	84 c0                	test   %al,%al
   434f4:	75 eb                	jne    434e1 <strlen+0x1a>
    }
    return n;
   434f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   434fa:	c9                   	leave  
   434fb:	c3                   	ret    

00000000000434fc <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   434fc:	f3 0f 1e fa          	endbr64 
   43500:	55                   	push   %rbp
   43501:	48 89 e5             	mov    %rsp,%rbp
   43504:	48 83 ec 20          	sub    $0x20,%rsp
   43508:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4350c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43510:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43517:	00 
   43518:	eb 0a                	jmp    43524 <strnlen+0x28>
        ++n;
   4351a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   4351f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43524:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43528:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   4352c:	74 0b                	je     43539 <strnlen+0x3d>
   4352e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43532:	0f b6 00             	movzbl (%rax),%eax
   43535:	84 c0                	test   %al,%al
   43537:	75 e1                	jne    4351a <strnlen+0x1e>
    }
    return n;
   43539:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   4353d:	c9                   	leave  
   4353e:	c3                   	ret    

000000000004353f <strcpy>:

char* strcpy(char* dst, const char* src) {
   4353f:	f3 0f 1e fa          	endbr64 
   43543:	55                   	push   %rbp
   43544:	48 89 e5             	mov    %rsp,%rbp
   43547:	48 83 ec 20          	sub    $0x20,%rsp
   4354b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4354f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43553:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43557:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   4355b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4355f:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43563:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43567:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4356b:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4356f:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43573:	0f b6 12             	movzbl (%rdx),%edx
   43576:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43578:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4357c:	48 83 e8 01          	sub    $0x1,%rax
   43580:	0f b6 00             	movzbl (%rax),%eax
   43583:	84 c0                	test   %al,%al
   43585:	75 d4                	jne    4355b <strcpy+0x1c>
    return dst;
   43587:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4358b:	c9                   	leave  
   4358c:	c3                   	ret    

000000000004358d <strcmp>:

int strcmp(const char* a, const char* b) {
   4358d:	f3 0f 1e fa          	endbr64 
   43591:	55                   	push   %rbp
   43592:	48 89 e5             	mov    %rsp,%rbp
   43595:	48 83 ec 10          	sub    $0x10,%rsp
   43599:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4359d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   435a1:	eb 0a                	jmp    435ad <strcmp+0x20>
        ++a, ++b;
   435a3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   435a8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   435ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435b1:	0f b6 00             	movzbl (%rax),%eax
   435b4:	84 c0                	test   %al,%al
   435b6:	74 1d                	je     435d5 <strcmp+0x48>
   435b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435bc:	0f b6 00             	movzbl (%rax),%eax
   435bf:	84 c0                	test   %al,%al
   435c1:	74 12                	je     435d5 <strcmp+0x48>
   435c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435c7:	0f b6 10             	movzbl (%rax),%edx
   435ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435ce:	0f b6 00             	movzbl (%rax),%eax
   435d1:	38 c2                	cmp    %al,%dl
   435d3:	74 ce                	je     435a3 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   435d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435d9:	0f b6 00             	movzbl (%rax),%eax
   435dc:	89 c2                	mov    %eax,%edx
   435de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435e2:	0f b6 00             	movzbl (%rax),%eax
   435e5:	38 c2                	cmp    %al,%dl
   435e7:	0f 97 c0             	seta   %al
   435ea:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   435ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435f1:	0f b6 00             	movzbl (%rax),%eax
   435f4:	89 c1                	mov    %eax,%ecx
   435f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435fa:	0f b6 00             	movzbl (%rax),%eax
   435fd:	38 c1                	cmp    %al,%cl
   435ff:	0f 92 c0             	setb   %al
   43602:	0f b6 c8             	movzbl %al,%ecx
   43605:	89 d0                	mov    %edx,%eax
   43607:	29 c8                	sub    %ecx,%eax
}
   43609:	c9                   	leave  
   4360a:	c3                   	ret    

000000000004360b <strchr>:

char* strchr(const char* s, int c) {
   4360b:	f3 0f 1e fa          	endbr64 
   4360f:	55                   	push   %rbp
   43610:	48 89 e5             	mov    %rsp,%rbp
   43613:	48 83 ec 10          	sub    $0x10,%rsp
   43617:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4361b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   4361e:	eb 05                	jmp    43625 <strchr+0x1a>
        ++s;
   43620:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43625:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43629:	0f b6 00             	movzbl (%rax),%eax
   4362c:	84 c0                	test   %al,%al
   4362e:	74 0e                	je     4363e <strchr+0x33>
   43630:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43634:	0f b6 00             	movzbl (%rax),%eax
   43637:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4363a:	38 d0                	cmp    %dl,%al
   4363c:	75 e2                	jne    43620 <strchr+0x15>
    }
    if (*s == (char) c) {
   4363e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43642:	0f b6 00             	movzbl (%rax),%eax
   43645:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43648:	38 d0                	cmp    %dl,%al
   4364a:	75 06                	jne    43652 <strchr+0x47>
        return (char*) s;
   4364c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43650:	eb 05                	jmp    43657 <strchr+0x4c>
    } else {
        return NULL;
   43652:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43657:	c9                   	leave  
   43658:	c3                   	ret    

0000000000043659 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43659:	f3 0f 1e fa          	endbr64 
   4365d:	55                   	push   %rbp
   4365e:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43661:	8b 05 99 79 01 00    	mov    0x17999(%rip),%eax        # 5b000 <rand_seed_set>
   43667:	85 c0                	test   %eax,%eax
   43669:	75 0a                	jne    43675 <rand+0x1c>
        srand(819234718U);
   4366b:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43670:	e8 24 00 00 00       	call   43699 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43675:	8b 05 89 79 01 00    	mov    0x17989(%rip),%eax        # 5b004 <rand_seed>
   4367b:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43681:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43686:	89 05 78 79 01 00    	mov    %eax,0x17978(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   4368c:	8b 05 72 79 01 00    	mov    0x17972(%rip),%eax        # 5b004 <rand_seed>
   43692:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43697:	5d                   	pop    %rbp
   43698:	c3                   	ret    

0000000000043699 <srand>:

void srand(unsigned seed) {
   43699:	f3 0f 1e fa          	endbr64 
   4369d:	55                   	push   %rbp
   4369e:	48 89 e5             	mov    %rsp,%rbp
   436a1:	48 83 ec 08          	sub    $0x8,%rsp
   436a5:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   436a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   436ab:	89 05 53 79 01 00    	mov    %eax,0x17953(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   436b1:	c7 05 45 79 01 00 01 	movl   $0x1,0x17945(%rip)        # 5b000 <rand_seed_set>
   436b8:	00 00 00 
}
   436bb:	90                   	nop
   436bc:	c9                   	leave  
   436bd:	c3                   	ret    

00000000000436be <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   436be:	f3 0f 1e fa          	endbr64 
   436c2:	55                   	push   %rbp
   436c3:	48 89 e5             	mov    %rsp,%rbp
   436c6:	48 83 ec 28          	sub    $0x28,%rsp
   436ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   436ce:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   436d2:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   436d5:	48 8d 05 04 19 00 00 	lea    0x1904(%rip),%rax        # 44fe0 <upper_digits.1>
   436dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   436e0:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   436e4:	79 0e                	jns    436f4 <fill_numbuf+0x36>
        digits = lower_digits;
   436e6:	48 8d 05 13 19 00 00 	lea    0x1913(%rip),%rax        # 45000 <lower_digits.0>
   436ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   436f1:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   436f4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   436f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436fd:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43700:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43703:	48 63 c8             	movslq %eax,%rcx
   43706:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4370a:	ba 00 00 00 00       	mov    $0x0,%edx
   4370f:	48 f7 f1             	div    %rcx
   43712:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43716:	48 01 d0             	add    %rdx,%rax
   43719:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4371e:	0f b6 10             	movzbl (%rax),%edx
   43721:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43725:	88 10                	mov    %dl,(%rax)
        val /= base;
   43727:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4372a:	48 63 f0             	movslq %eax,%rsi
   4372d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43731:	ba 00 00 00 00       	mov    $0x0,%edx
   43736:	48 f7 f6             	div    %rsi
   43739:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   4373d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43742:	75 bc                	jne    43700 <fill_numbuf+0x42>
    return numbuf_end;
   43744:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43748:	c9                   	leave  
   43749:	c3                   	ret    

000000000004374a <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   4374a:	f3 0f 1e fa          	endbr64 
   4374e:	55                   	push   %rbp
   4374f:	48 89 e5             	mov    %rsp,%rbp
   43752:	53                   	push   %rbx
   43753:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   4375a:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43761:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43767:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4376e:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43775:	e9 bd 09 00 00       	jmp    44137 <printer_vprintf+0x9ed>
        if (*format != '%') {
   4377a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43781:	0f b6 00             	movzbl (%rax),%eax
   43784:	3c 25                	cmp    $0x25,%al
   43786:	74 31                	je     437b9 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   43788:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4378f:	4c 8b 00             	mov    (%rax),%r8
   43792:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43799:	0f b6 00             	movzbl (%rax),%eax
   4379c:	0f b6 c8             	movzbl %al,%ecx
   4379f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   437a5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   437ac:	89 ce                	mov    %ecx,%esi
   437ae:	48 89 c7             	mov    %rax,%rdi
   437b1:	41 ff d0             	call   *%r8
            continue;
   437b4:	e9 76 09 00 00       	jmp    4412f <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   437b9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   437c0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   437c7:	01 
   437c8:	eb 4d                	jmp    43817 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   437ca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437d1:	0f b6 00             	movzbl (%rax),%eax
   437d4:	0f be c0             	movsbl %al,%eax
   437d7:	89 c6                	mov    %eax,%esi
   437d9:	48 8d 05 00 17 00 00 	lea    0x1700(%rip),%rax        # 44ee0 <flag_chars>
   437e0:	48 89 c7             	mov    %rax,%rdi
   437e3:	e8 23 fe ff ff       	call   4360b <strchr>
   437e8:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   437ec:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   437f1:	74 34                	je     43827 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   437f3:	48 8d 15 e6 16 00 00 	lea    0x16e6(%rip),%rdx        # 44ee0 <flag_chars>
   437fa:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   437fe:	48 29 d0             	sub    %rdx,%rax
   43801:	ba 01 00 00 00       	mov    $0x1,%edx
   43806:	89 c1                	mov    %eax,%ecx
   43808:	d3 e2                	shl    %cl,%edx
   4380a:	89 d0                	mov    %edx,%eax
   4380c:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   4380f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43816:	01 
   43817:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4381e:	0f b6 00             	movzbl (%rax),%eax
   43821:	84 c0                	test   %al,%al
   43823:	75 a5                	jne    437ca <printer_vprintf+0x80>
   43825:	eb 01                	jmp    43828 <printer_vprintf+0xde>
            } else {
                break;
   43827:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43828:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   4382f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43836:	0f b6 00             	movzbl (%rax),%eax
   43839:	3c 30                	cmp    $0x30,%al
   4383b:	7e 67                	jle    438a4 <printer_vprintf+0x15a>
   4383d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43844:	0f b6 00             	movzbl (%rax),%eax
   43847:	3c 39                	cmp    $0x39,%al
   43849:	7f 59                	jg     438a4 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4384b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43852:	eb 2e                	jmp    43882 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   43854:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43857:	89 d0                	mov    %edx,%eax
   43859:	c1 e0 02             	shl    $0x2,%eax
   4385c:	01 d0                	add    %edx,%eax
   4385e:	01 c0                	add    %eax,%eax
   43860:	89 c1                	mov    %eax,%ecx
   43862:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43869:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4386d:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43874:	0f b6 00             	movzbl (%rax),%eax
   43877:	0f be c0             	movsbl %al,%eax
   4387a:	01 c8                	add    %ecx,%eax
   4387c:	83 e8 30             	sub    $0x30,%eax
   4387f:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43882:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43889:	0f b6 00             	movzbl (%rax),%eax
   4388c:	3c 2f                	cmp    $0x2f,%al
   4388e:	0f 8e 85 00 00 00    	jle    43919 <printer_vprintf+0x1cf>
   43894:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4389b:	0f b6 00             	movzbl (%rax),%eax
   4389e:	3c 39                	cmp    $0x39,%al
   438a0:	7e b2                	jle    43854 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   438a2:	eb 75                	jmp    43919 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   438a4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   438ab:	0f b6 00             	movzbl (%rax),%eax
   438ae:	3c 2a                	cmp    $0x2a,%al
   438b0:	75 68                	jne    4391a <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   438b2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438b9:	8b 00                	mov    (%rax),%eax
   438bb:	83 f8 2f             	cmp    $0x2f,%eax
   438be:	77 30                	ja     438f0 <printer_vprintf+0x1a6>
   438c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438c7:	48 8b 50 10          	mov    0x10(%rax),%rdx
   438cb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438d2:	8b 00                	mov    (%rax),%eax
   438d4:	89 c0                	mov    %eax,%eax
   438d6:	48 01 d0             	add    %rdx,%rax
   438d9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438e0:	8b 12                	mov    (%rdx),%edx
   438e2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   438e5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438ec:	89 0a                	mov    %ecx,(%rdx)
   438ee:	eb 1a                	jmp    4390a <printer_vprintf+0x1c0>
   438f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438f7:	48 8b 40 08          	mov    0x8(%rax),%rax
   438fb:	48 8d 48 08          	lea    0x8(%rax),%rcx
   438ff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43906:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4390a:	8b 00                	mov    (%rax),%eax
   4390c:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   4390f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43916:	01 
   43917:	eb 01                	jmp    4391a <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   43919:	90                   	nop
        }

        // process precision
        int precision = -1;
   4391a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43921:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43928:	0f b6 00             	movzbl (%rax),%eax
   4392b:	3c 2e                	cmp    $0x2e,%al
   4392d:	0f 85 00 01 00 00    	jne    43a33 <printer_vprintf+0x2e9>
            ++format;
   43933:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4393a:	01 
            if (*format >= '0' && *format <= '9') {
   4393b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43942:	0f b6 00             	movzbl (%rax),%eax
   43945:	3c 2f                	cmp    $0x2f,%al
   43947:	7e 67                	jle    439b0 <printer_vprintf+0x266>
   43949:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43950:	0f b6 00             	movzbl (%rax),%eax
   43953:	3c 39                	cmp    $0x39,%al
   43955:	7f 59                	jg     439b0 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43957:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   4395e:	eb 2e                	jmp    4398e <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   43960:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43963:	89 d0                	mov    %edx,%eax
   43965:	c1 e0 02             	shl    $0x2,%eax
   43968:	01 d0                	add    %edx,%eax
   4396a:	01 c0                	add    %eax,%eax
   4396c:	89 c1                	mov    %eax,%ecx
   4396e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43975:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43979:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43980:	0f b6 00             	movzbl (%rax),%eax
   43983:	0f be c0             	movsbl %al,%eax
   43986:	01 c8                	add    %ecx,%eax
   43988:	83 e8 30             	sub    $0x30,%eax
   4398b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4398e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43995:	0f b6 00             	movzbl (%rax),%eax
   43998:	3c 2f                	cmp    $0x2f,%al
   4399a:	0f 8e 85 00 00 00    	jle    43a25 <printer_vprintf+0x2db>
   439a0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439a7:	0f b6 00             	movzbl (%rax),%eax
   439aa:	3c 39                	cmp    $0x39,%al
   439ac:	7e b2                	jle    43960 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   439ae:	eb 75                	jmp    43a25 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   439b0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439b7:	0f b6 00             	movzbl (%rax),%eax
   439ba:	3c 2a                	cmp    $0x2a,%al
   439bc:	75 68                	jne    43a26 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   439be:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439c5:	8b 00                	mov    (%rax),%eax
   439c7:	83 f8 2f             	cmp    $0x2f,%eax
   439ca:	77 30                	ja     439fc <printer_vprintf+0x2b2>
   439cc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439d3:	48 8b 50 10          	mov    0x10(%rax),%rdx
   439d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439de:	8b 00                	mov    (%rax),%eax
   439e0:	89 c0                	mov    %eax,%eax
   439e2:	48 01 d0             	add    %rdx,%rax
   439e5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439ec:	8b 12                	mov    (%rdx),%edx
   439ee:	8d 4a 08             	lea    0x8(%rdx),%ecx
   439f1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439f8:	89 0a                	mov    %ecx,(%rdx)
   439fa:	eb 1a                	jmp    43a16 <printer_vprintf+0x2cc>
   439fc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a03:	48 8b 40 08          	mov    0x8(%rax),%rax
   43a07:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43a0b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a12:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43a16:	8b 00                	mov    (%rax),%eax
   43a18:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43a1b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a22:	01 
   43a23:	eb 01                	jmp    43a26 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   43a25:	90                   	nop
            }
            if (precision < 0) {
   43a26:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43a2a:	79 07                	jns    43a33 <printer_vprintf+0x2e9>
                precision = 0;
   43a2c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43a33:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43a3a:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43a41:	00 
        int length = 0;
   43a42:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43a49:	48 8d 05 96 14 00 00 	lea    0x1496(%rip),%rax        # 44ee6 <flag_chars+0x6>
   43a50:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   43a54:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a5b:	0f b6 00             	movzbl (%rax),%eax
   43a5e:	0f be c0             	movsbl %al,%eax
   43a61:	83 e8 43             	sub    $0x43,%eax
   43a64:	83 f8 37             	cmp    $0x37,%eax
   43a67:	0f 87 b6 03 00 00    	ja     43e23 <printer_vprintf+0x6d9>
   43a6d:	89 c0                	mov    %eax,%eax
   43a6f:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   43a76:	00 
   43a77:	48 8d 05 76 14 00 00 	lea    0x1476(%rip),%rax        # 44ef4 <flag_chars+0x14>
   43a7e:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   43a81:	48 98                	cltq   
   43a83:	48 8d 15 6a 14 00 00 	lea    0x146a(%rip),%rdx        # 44ef4 <flag_chars+0x14>
   43a8a:	48 01 d0             	add    %rdx,%rax
   43a8d:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   43a90:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43a97:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a9e:	01 
            goto again;
   43a9f:	eb b3                	jmp    43a54 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43aa1:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43aa5:	74 5d                	je     43b04 <printer_vprintf+0x3ba>
   43aa7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43aae:	8b 00                	mov    (%rax),%eax
   43ab0:	83 f8 2f             	cmp    $0x2f,%eax
   43ab3:	77 30                	ja     43ae5 <printer_vprintf+0x39b>
   43ab5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43abc:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ac0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ac7:	8b 00                	mov    (%rax),%eax
   43ac9:	89 c0                	mov    %eax,%eax
   43acb:	48 01 d0             	add    %rdx,%rax
   43ace:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ad5:	8b 12                	mov    (%rdx),%edx
   43ad7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43ada:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ae1:	89 0a                	mov    %ecx,(%rdx)
   43ae3:	eb 1a                	jmp    43aff <printer_vprintf+0x3b5>
   43ae5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43aec:	48 8b 40 08          	mov    0x8(%rax),%rax
   43af0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43af4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43afb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43aff:	48 8b 00             	mov    (%rax),%rax
   43b02:	eb 5c                	jmp    43b60 <printer_vprintf+0x416>
   43b04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b0b:	8b 00                	mov    (%rax),%eax
   43b0d:	83 f8 2f             	cmp    $0x2f,%eax
   43b10:	77 30                	ja     43b42 <printer_vprintf+0x3f8>
   43b12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b19:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b1d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b24:	8b 00                	mov    (%rax),%eax
   43b26:	89 c0                	mov    %eax,%eax
   43b28:	48 01 d0             	add    %rdx,%rax
   43b2b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b32:	8b 12                	mov    (%rdx),%edx
   43b34:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b37:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b3e:	89 0a                	mov    %ecx,(%rdx)
   43b40:	eb 1a                	jmp    43b5c <printer_vprintf+0x412>
   43b42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b49:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b4d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b51:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b58:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b5c:	8b 00                	mov    (%rax),%eax
   43b5e:	48 98                	cltq   
   43b60:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43b64:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43b68:	48 c1 f8 38          	sar    $0x38,%rax
   43b6c:	25 80 00 00 00       	and    $0x80,%eax
   43b71:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43b74:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43b78:	74 09                	je     43b83 <printer_vprintf+0x439>
   43b7a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43b7e:	48 f7 d8             	neg    %rax
   43b81:	eb 04                	jmp    43b87 <printer_vprintf+0x43d>
   43b83:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43b87:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43b8b:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43b8e:	83 c8 60             	or     $0x60,%eax
   43b91:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43b94:	e9 cf 02 00 00       	jmp    43e68 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43b99:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43b9d:	74 5d                	je     43bfc <printer_vprintf+0x4b2>
   43b9f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ba6:	8b 00                	mov    (%rax),%eax
   43ba8:	83 f8 2f             	cmp    $0x2f,%eax
   43bab:	77 30                	ja     43bdd <printer_vprintf+0x493>
   43bad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bb4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43bb8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bbf:	8b 00                	mov    (%rax),%eax
   43bc1:	89 c0                	mov    %eax,%eax
   43bc3:	48 01 d0             	add    %rdx,%rax
   43bc6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bcd:	8b 12                	mov    (%rdx),%edx
   43bcf:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43bd2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bd9:	89 0a                	mov    %ecx,(%rdx)
   43bdb:	eb 1a                	jmp    43bf7 <printer_vprintf+0x4ad>
   43bdd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43be4:	48 8b 40 08          	mov    0x8(%rax),%rax
   43be8:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43bec:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bf3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43bf7:	48 8b 00             	mov    (%rax),%rax
   43bfa:	eb 5c                	jmp    43c58 <printer_vprintf+0x50e>
   43bfc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c03:	8b 00                	mov    (%rax),%eax
   43c05:	83 f8 2f             	cmp    $0x2f,%eax
   43c08:	77 30                	ja     43c3a <printer_vprintf+0x4f0>
   43c0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c11:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c15:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c1c:	8b 00                	mov    (%rax),%eax
   43c1e:	89 c0                	mov    %eax,%eax
   43c20:	48 01 d0             	add    %rdx,%rax
   43c23:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c2a:	8b 12                	mov    (%rdx),%edx
   43c2c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c36:	89 0a                	mov    %ecx,(%rdx)
   43c38:	eb 1a                	jmp    43c54 <printer_vprintf+0x50a>
   43c3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c41:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c45:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c49:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c50:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c54:	8b 00                	mov    (%rax),%eax
   43c56:	89 c0                	mov    %eax,%eax
   43c58:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43c5c:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43c60:	e9 03 02 00 00       	jmp    43e68 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   43c65:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43c6c:	e9 28 ff ff ff       	jmp    43b99 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   43c71:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43c78:	e9 1c ff ff ff       	jmp    43b99 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43c7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c84:	8b 00                	mov    (%rax),%eax
   43c86:	83 f8 2f             	cmp    $0x2f,%eax
   43c89:	77 30                	ja     43cbb <printer_vprintf+0x571>
   43c8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c92:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c96:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c9d:	8b 00                	mov    (%rax),%eax
   43c9f:	89 c0                	mov    %eax,%eax
   43ca1:	48 01 d0             	add    %rdx,%rax
   43ca4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cab:	8b 12                	mov    (%rdx),%edx
   43cad:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43cb0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cb7:	89 0a                	mov    %ecx,(%rdx)
   43cb9:	eb 1a                	jmp    43cd5 <printer_vprintf+0x58b>
   43cbb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cc2:	48 8b 40 08          	mov    0x8(%rax),%rax
   43cc6:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43cca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cd1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43cd5:	48 8b 00             	mov    (%rax),%rax
   43cd8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43cdc:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43ce3:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43cea:	e9 79 01 00 00       	jmp    43e68 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   43cef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cf6:	8b 00                	mov    (%rax),%eax
   43cf8:	83 f8 2f             	cmp    $0x2f,%eax
   43cfb:	77 30                	ja     43d2d <printer_vprintf+0x5e3>
   43cfd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d04:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d0f:	8b 00                	mov    (%rax),%eax
   43d11:	89 c0                	mov    %eax,%eax
   43d13:	48 01 d0             	add    %rdx,%rax
   43d16:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d1d:	8b 12                	mov    (%rdx),%edx
   43d1f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d22:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d29:	89 0a                	mov    %ecx,(%rdx)
   43d2b:	eb 1a                	jmp    43d47 <printer_vprintf+0x5fd>
   43d2d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d34:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d38:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d3c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d43:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d47:	48 8b 00             	mov    (%rax),%rax
   43d4a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43d4e:	e9 15 01 00 00       	jmp    43e68 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   43d53:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d5a:	8b 00                	mov    (%rax),%eax
   43d5c:	83 f8 2f             	cmp    $0x2f,%eax
   43d5f:	77 30                	ja     43d91 <printer_vprintf+0x647>
   43d61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d68:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d73:	8b 00                	mov    (%rax),%eax
   43d75:	89 c0                	mov    %eax,%eax
   43d77:	48 01 d0             	add    %rdx,%rax
   43d7a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d81:	8b 12                	mov    (%rdx),%edx
   43d83:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d86:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d8d:	89 0a                	mov    %ecx,(%rdx)
   43d8f:	eb 1a                	jmp    43dab <printer_vprintf+0x661>
   43d91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d98:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d9c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43da0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43da7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43dab:	8b 00                	mov    (%rax),%eax
   43dad:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43db3:	e9 77 03 00 00       	jmp    4412f <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   43db8:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43dbc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43dc0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dc7:	8b 00                	mov    (%rax),%eax
   43dc9:	83 f8 2f             	cmp    $0x2f,%eax
   43dcc:	77 30                	ja     43dfe <printer_vprintf+0x6b4>
   43dce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dd5:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43dd9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43de0:	8b 00                	mov    (%rax),%eax
   43de2:	89 c0                	mov    %eax,%eax
   43de4:	48 01 d0             	add    %rdx,%rax
   43de7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43dee:	8b 12                	mov    (%rdx),%edx
   43df0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43df3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43dfa:	89 0a                	mov    %ecx,(%rdx)
   43dfc:	eb 1a                	jmp    43e18 <printer_vprintf+0x6ce>
   43dfe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e05:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e09:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e0d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e14:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e18:	8b 00                	mov    (%rax),%eax
   43e1a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43e1d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43e21:	eb 45                	jmp    43e68 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   43e23:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43e27:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43e2b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e32:	0f b6 00             	movzbl (%rax),%eax
   43e35:	84 c0                	test   %al,%al
   43e37:	74 0c                	je     43e45 <printer_vprintf+0x6fb>
   43e39:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e40:	0f b6 00             	movzbl (%rax),%eax
   43e43:	eb 05                	jmp    43e4a <printer_vprintf+0x700>
   43e45:	b8 25 00 00 00       	mov    $0x25,%eax
   43e4a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43e4d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43e51:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e58:	0f b6 00             	movzbl (%rax),%eax
   43e5b:	84 c0                	test   %al,%al
   43e5d:	75 08                	jne    43e67 <printer_vprintf+0x71d>
                format--;
   43e5f:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43e66:	01 
            }
            break;
   43e67:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43e68:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e6b:	83 e0 20             	and    $0x20,%eax
   43e6e:	85 c0                	test   %eax,%eax
   43e70:	74 1e                	je     43e90 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43e72:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43e76:	48 83 c0 18          	add    $0x18,%rax
   43e7a:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43e7d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43e81:	48 89 ce             	mov    %rcx,%rsi
   43e84:	48 89 c7             	mov    %rax,%rdi
   43e87:	e8 32 f8 ff ff       	call   436be <fill_numbuf>
   43e8c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43e90:	48 8d 05 4f 10 00 00 	lea    0x104f(%rip),%rax        # 44ee6 <flag_chars+0x6>
   43e97:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43e9b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e9e:	83 e0 20             	and    $0x20,%eax
   43ea1:	85 c0                	test   %eax,%eax
   43ea3:	74 51                	je     43ef6 <printer_vprintf+0x7ac>
   43ea5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ea8:	83 e0 40             	and    $0x40,%eax
   43eab:	85 c0                	test   %eax,%eax
   43ead:	74 47                	je     43ef6 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   43eaf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43eb2:	25 80 00 00 00       	and    $0x80,%eax
   43eb7:	85 c0                	test   %eax,%eax
   43eb9:	74 0d                	je     43ec8 <printer_vprintf+0x77e>
                prefix = "-";
   43ebb:	48 8d 05 25 10 00 00 	lea    0x1025(%rip),%rax        # 44ee7 <flag_chars+0x7>
   43ec2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   43ec6:	eb 7d                	jmp    43f45 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43ec8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ecb:	83 e0 10             	and    $0x10,%eax
   43ece:	85 c0                	test   %eax,%eax
   43ed0:	74 0d                	je     43edf <printer_vprintf+0x795>
                prefix = "+";
   43ed2:	48 8d 05 10 10 00 00 	lea    0x1010(%rip),%rax        # 44ee9 <flag_chars+0x9>
   43ed9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   43edd:	eb 66                	jmp    43f45 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   43edf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ee2:	83 e0 08             	and    $0x8,%eax
   43ee5:	85 c0                	test   %eax,%eax
   43ee7:	74 5c                	je     43f45 <printer_vprintf+0x7fb>
                prefix = " ";
   43ee9:	48 8d 05 fb 0f 00 00 	lea    0xffb(%rip),%rax        # 44eeb <flag_chars+0xb>
   43ef0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   43ef4:	eb 4f                	jmp    43f45 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43ef6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ef9:	83 e0 20             	and    $0x20,%eax
   43efc:	85 c0                	test   %eax,%eax
   43efe:	74 46                	je     43f46 <printer_vprintf+0x7fc>
   43f00:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43f03:	83 e0 01             	and    $0x1,%eax
   43f06:	85 c0                	test   %eax,%eax
   43f08:	74 3c                	je     43f46 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   43f0a:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   43f0e:	74 06                	je     43f16 <printer_vprintf+0x7cc>
   43f10:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43f14:	75 30                	jne    43f46 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   43f16:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43f1b:	75 0c                	jne    43f29 <printer_vprintf+0x7df>
   43f1d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43f20:	25 00 01 00 00       	and    $0x100,%eax
   43f25:	85 c0                	test   %eax,%eax
   43f27:	74 1d                	je     43f46 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   43f29:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43f2d:	75 09                	jne    43f38 <printer_vprintf+0x7ee>
   43f2f:	48 8d 05 b7 0f 00 00 	lea    0xfb7(%rip),%rax        # 44eed <flag_chars+0xd>
   43f36:	eb 07                	jmp    43f3f <printer_vprintf+0x7f5>
   43f38:	48 8d 05 b1 0f 00 00 	lea    0xfb1(%rip),%rax        # 44ef0 <flag_chars+0x10>
   43f3f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43f43:	eb 01                	jmp    43f46 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   43f45:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43f46:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43f4a:	78 24                	js     43f70 <printer_vprintf+0x826>
   43f4c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43f4f:	83 e0 20             	and    $0x20,%eax
   43f52:	85 c0                	test   %eax,%eax
   43f54:	75 1a                	jne    43f70 <printer_vprintf+0x826>
            len = strnlen(data, precision);
   43f56:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43f59:	48 63 d0             	movslq %eax,%rdx
   43f5c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43f60:	48 89 d6             	mov    %rdx,%rsi
   43f63:	48 89 c7             	mov    %rax,%rdi
   43f66:	e8 91 f5 ff ff       	call   434fc <strnlen>
   43f6b:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43f6e:	eb 0f                	jmp    43f7f <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   43f70:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43f74:	48 89 c7             	mov    %rax,%rdi
   43f77:	e8 4b f5 ff ff       	call   434c7 <strlen>
   43f7c:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43f7f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43f82:	83 e0 20             	and    $0x20,%eax
   43f85:	85 c0                	test   %eax,%eax
   43f87:	74 20                	je     43fa9 <printer_vprintf+0x85f>
   43f89:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43f8d:	78 1a                	js     43fa9 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   43f8f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43f92:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   43f95:	7e 08                	jle    43f9f <printer_vprintf+0x855>
   43f97:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43f9a:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43f9d:	eb 05                	jmp    43fa4 <printer_vprintf+0x85a>
   43f9f:	b8 00 00 00 00       	mov    $0x0,%eax
   43fa4:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43fa7:	eb 5c                	jmp    44005 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43fa9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fac:	83 e0 20             	and    $0x20,%eax
   43faf:	85 c0                	test   %eax,%eax
   43fb1:	74 4b                	je     43ffe <printer_vprintf+0x8b4>
   43fb3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fb6:	83 e0 02             	and    $0x2,%eax
   43fb9:	85 c0                	test   %eax,%eax
   43fbb:	74 41                	je     43ffe <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   43fbd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fc0:	83 e0 04             	and    $0x4,%eax
   43fc3:	85 c0                	test   %eax,%eax
   43fc5:	75 37                	jne    43ffe <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   43fc7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43fcb:	48 89 c7             	mov    %rax,%rdi
   43fce:	e8 f4 f4 ff ff       	call   434c7 <strlen>
   43fd3:	89 c2                	mov    %eax,%edx
   43fd5:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43fd8:	01 d0                	add    %edx,%eax
   43fda:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   43fdd:	7e 1f                	jle    43ffe <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   43fdf:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43fe2:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43fe5:	89 c3                	mov    %eax,%ebx
   43fe7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43feb:	48 89 c7             	mov    %rax,%rdi
   43fee:	e8 d4 f4 ff ff       	call   434c7 <strlen>
   43ff3:	89 c2                	mov    %eax,%edx
   43ff5:	89 d8                	mov    %ebx,%eax
   43ff7:	29 d0                	sub    %edx,%eax
   43ff9:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43ffc:	eb 07                	jmp    44005 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   43ffe:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44005:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44008:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4400b:	01 d0                	add    %edx,%eax
   4400d:	48 63 d8             	movslq %eax,%rbx
   44010:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44014:	48 89 c7             	mov    %rax,%rdi
   44017:	e8 ab f4 ff ff       	call   434c7 <strlen>
   4401c:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   44020:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44023:	29 d0                	sub    %edx,%eax
   44025:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44028:	eb 25                	jmp    4404f <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   4402a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44031:	48 8b 08             	mov    (%rax),%rcx
   44034:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4403a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44041:	be 20 00 00 00       	mov    $0x20,%esi
   44046:	48 89 c7             	mov    %rax,%rdi
   44049:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   4404b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   4404f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44052:	83 e0 04             	and    $0x4,%eax
   44055:	85 c0                	test   %eax,%eax
   44057:	75 36                	jne    4408f <printer_vprintf+0x945>
   44059:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   4405d:	7f cb                	jg     4402a <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   4405f:	eb 2e                	jmp    4408f <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   44061:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44068:	4c 8b 00             	mov    (%rax),%r8
   4406b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4406f:	0f b6 00             	movzbl (%rax),%eax
   44072:	0f b6 c8             	movzbl %al,%ecx
   44075:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4407b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44082:	89 ce                	mov    %ecx,%esi
   44084:	48 89 c7             	mov    %rax,%rdi
   44087:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   4408a:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   4408f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44093:	0f b6 00             	movzbl (%rax),%eax
   44096:	84 c0                	test   %al,%al
   44098:	75 c7                	jne    44061 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   4409a:	eb 25                	jmp    440c1 <printer_vprintf+0x977>
            p->putc(p, '0', color);
   4409c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   440a3:	48 8b 08             	mov    (%rax),%rcx
   440a6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   440ac:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   440b3:	be 30 00 00 00       	mov    $0x30,%esi
   440b8:	48 89 c7             	mov    %rax,%rdi
   440bb:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   440bd:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   440c1:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   440c5:	7f d5                	jg     4409c <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   440c7:	eb 32                	jmp    440fb <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   440c9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   440d0:	4c 8b 00             	mov    (%rax),%r8
   440d3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   440d7:	0f b6 00             	movzbl (%rax),%eax
   440da:	0f b6 c8             	movzbl %al,%ecx
   440dd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   440e3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   440ea:	89 ce                	mov    %ecx,%esi
   440ec:	48 89 c7             	mov    %rax,%rdi
   440ef:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   440f2:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   440f7:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   440fb:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   440ff:	7f c8                	jg     440c9 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   44101:	eb 25                	jmp    44128 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   44103:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4410a:	48 8b 08             	mov    (%rax),%rcx
   4410d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44113:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4411a:	be 20 00 00 00       	mov    $0x20,%esi
   4411f:	48 89 c7             	mov    %rax,%rdi
   44122:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44124:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44128:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   4412c:	7f d5                	jg     44103 <printer_vprintf+0x9b9>
        }
    done: ;
   4412e:	90                   	nop
    for (; *format; ++format) {
   4412f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44136:	01 
   44137:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4413e:	0f b6 00             	movzbl (%rax),%eax
   44141:	84 c0                	test   %al,%al
   44143:	0f 85 31 f6 ff ff    	jne    4377a <printer_vprintf+0x30>
    }
}
   44149:	90                   	nop
   4414a:	90                   	nop
   4414b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4414f:	c9                   	leave  
   44150:	c3                   	ret    

0000000000044151 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   44151:	f3 0f 1e fa          	endbr64 
   44155:	55                   	push   %rbp
   44156:	48 89 e5             	mov    %rsp,%rbp
   44159:	48 83 ec 20          	sub    $0x20,%rsp
   4415d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44161:	89 f0                	mov    %esi,%eax
   44163:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44166:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44169:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4416d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44171:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44175:	48 8b 40 08          	mov    0x8(%rax),%rax
   44179:	48 8d 15 20 4e 07 00 	lea    0x74e20(%rip),%rdx        # b8fa0 <console+0xfa0>
   44180:	48 39 d0             	cmp    %rdx,%rax
   44183:	72 0f                	jb     44194 <console_putc+0x43>
        cp->cursor = console;
   44185:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44189:	48 8d 15 70 3e 07 00 	lea    0x73e70(%rip),%rdx        # b8000 <console>
   44190:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   44194:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44198:	0f 85 82 00 00 00    	jne    44220 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   4419e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   441a2:	48 8b 40 08          	mov    0x8(%rax),%rax
   441a6:	48 8d 15 53 3e 07 00 	lea    0x73e53(%rip),%rdx        # b8000 <console>
   441ad:	48 29 d0             	sub    %rdx,%rax
   441b0:	48 d1 f8             	sar    %rax
   441b3:	48 89 c1             	mov    %rax,%rcx
   441b6:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   441bd:	66 66 66 
   441c0:	48 89 c8             	mov    %rcx,%rax
   441c3:	48 f7 ea             	imul   %rdx
   441c6:	48 89 d0             	mov    %rdx,%rax
   441c9:	48 c1 f8 05          	sar    $0x5,%rax
   441cd:	48 89 ce             	mov    %rcx,%rsi
   441d0:	48 c1 fe 3f          	sar    $0x3f,%rsi
   441d4:	48 29 f0             	sub    %rsi,%rax
   441d7:	48 89 c2             	mov    %rax,%rdx
   441da:	48 89 d0             	mov    %rdx,%rax
   441dd:	48 c1 e0 02          	shl    $0x2,%rax
   441e1:	48 01 d0             	add    %rdx,%rax
   441e4:	48 c1 e0 04          	shl    $0x4,%rax
   441e8:	48 29 c1             	sub    %rax,%rcx
   441eb:	48 89 ca             	mov    %rcx,%rdx
   441ee:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   441f1:	eb 25                	jmp    44218 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   441f3:	8b 45 e0             	mov    -0x20(%rbp),%eax
   441f6:	83 c8 20             	or     $0x20,%eax
   441f9:	89 c6                	mov    %eax,%esi
   441fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   441ff:	48 8b 40 08          	mov    0x8(%rax),%rax
   44203:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44207:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4420b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4420f:	89 f2                	mov    %esi,%edx
   44211:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44214:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44218:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   4421c:	75 d5                	jne    441f3 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   4421e:	eb 24                	jmp    44244 <console_putc+0xf3>
        *cp->cursor++ = c | color;
   44220:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44224:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44227:	89 d6                	mov    %edx,%esi
   44229:	09 c6                	or     %eax,%esi
   4422b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4422f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44233:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44237:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4423b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4423f:	89 f2                	mov    %esi,%edx
   44241:	66 89 10             	mov    %dx,(%rax)
}
   44244:	90                   	nop
   44245:	c9                   	leave  
   44246:	c3                   	ret    

0000000000044247 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44247:	f3 0f 1e fa          	endbr64 
   4424b:	55                   	push   %rbp
   4424c:	48 89 e5             	mov    %rsp,%rbp
   4424f:	48 83 ec 30          	sub    $0x30,%rsp
   44253:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44256:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44259:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4425d:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44261:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 44151 <console_putc>
   44268:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4426c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44270:	78 09                	js     4427b <console_vprintf+0x34>
   44272:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44279:	7e 07                	jle    44282 <console_vprintf+0x3b>
        cpos = 0;
   4427b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44282:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44285:	48 98                	cltq   
   44287:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4428b:	48 8d 05 6e 3d 07 00 	lea    0x73d6e(%rip),%rax        # b8000 <console>
   44292:	48 01 d0             	add    %rdx,%rax
   44295:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44299:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4429d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   442a1:	8b 75 e8             	mov    -0x18(%rbp),%esi
   442a4:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   442a8:	48 89 c7             	mov    %rax,%rdi
   442ab:	e8 9a f4 ff ff       	call   4374a <printer_vprintf>
    return cp.cursor - console;
   442b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442b4:	48 8d 15 45 3d 07 00 	lea    0x73d45(%rip),%rdx        # b8000 <console>
   442bb:	48 29 d0             	sub    %rdx,%rax
   442be:	48 d1 f8             	sar    %rax
}
   442c1:	c9                   	leave  
   442c2:	c3                   	ret    

00000000000442c3 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   442c3:	f3 0f 1e fa          	endbr64 
   442c7:	55                   	push   %rbp
   442c8:	48 89 e5             	mov    %rsp,%rbp
   442cb:	48 83 ec 60          	sub    $0x60,%rsp
   442cf:	89 7d ac             	mov    %edi,-0x54(%rbp)
   442d2:	89 75 a8             	mov    %esi,-0x58(%rbp)
   442d5:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   442d9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   442dd:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   442e1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   442e5:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   442ec:	48 8d 45 10          	lea    0x10(%rbp),%rax
   442f0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   442f4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   442f8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   442fc:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44300:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44304:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44307:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4430a:	89 c7                	mov    %eax,%edi
   4430c:	e8 36 ff ff ff       	call   44247 <console_vprintf>
   44311:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44314:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44317:	c9                   	leave  
   44318:	c3                   	ret    

0000000000044319 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44319:	f3 0f 1e fa          	endbr64 
   4431d:	55                   	push   %rbp
   4431e:	48 89 e5             	mov    %rsp,%rbp
   44321:	48 83 ec 20          	sub    $0x20,%rsp
   44325:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44329:	89 f0                	mov    %esi,%eax
   4432b:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4432e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44331:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44335:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44339:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4433d:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44341:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44345:	48 8b 40 10          	mov    0x10(%rax),%rax
   44349:	48 39 c2             	cmp    %rax,%rdx
   4434c:	73 1a                	jae    44368 <string_putc+0x4f>
        *sp->s++ = c;
   4434e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44352:	48 8b 40 08          	mov    0x8(%rax),%rax
   44356:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4435a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4435e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44362:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44366:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44368:	90                   	nop
   44369:	c9                   	leave  
   4436a:	c3                   	ret    

000000000004436b <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   4436b:	f3 0f 1e fa          	endbr64 
   4436f:	55                   	push   %rbp
   44370:	48 89 e5             	mov    %rsp,%rbp
   44373:	48 83 ec 40          	sub    $0x40,%rsp
   44377:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4437b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4437f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44383:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44387:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 44319 <string_putc>
   4438e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   44392:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44396:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   4439a:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   4439f:	74 33                	je     443d4 <vsnprintf+0x69>
        sp.end = s + size - 1;
   443a1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   443a5:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   443a9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   443ad:	48 01 d0             	add    %rdx,%rax
   443b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   443b4:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   443b8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   443bc:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   443c0:	be 00 00 00 00       	mov    $0x0,%esi
   443c5:	48 89 c7             	mov    %rax,%rdi
   443c8:	e8 7d f3 ff ff       	call   4374a <printer_vprintf>
        *sp.s = 0;
   443cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   443d1:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   443d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   443d8:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   443dc:	c9                   	leave  
   443dd:	c3                   	ret    

00000000000443de <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   443de:	f3 0f 1e fa          	endbr64 
   443e2:	55                   	push   %rbp
   443e3:	48 89 e5             	mov    %rsp,%rbp
   443e6:	48 83 ec 70          	sub    $0x70,%rsp
   443ea:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   443ee:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   443f2:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   443f6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   443fa:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   443fe:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44402:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44409:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4440d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44411:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44415:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44419:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4441d:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44421:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44425:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44429:	48 89 c7             	mov    %rax,%rdi
   4442c:	e8 3a ff ff ff       	call   4436b <vsnprintf>
   44431:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44434:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44437:	c9                   	leave  
   44438:	c3                   	ret    

0000000000044439 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44439:	f3 0f 1e fa          	endbr64 
   4443d:	55                   	push   %rbp
   4443e:	48 89 e5             	mov    %rsp,%rbp
   44441:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44445:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4444c:	eb 1a                	jmp    44468 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   4444e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44451:	48 98                	cltq   
   44453:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44457:	48 8d 05 a2 3b 07 00 	lea    0x73ba2(%rip),%rax        # b8000 <console>
   4445e:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44464:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44468:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   4446f:	7e dd                	jle    4444e <console_clear+0x15>
    }
    cursorpos = 0;
   44471:	c7 05 81 4b 07 00 00 	movl   $0x0,0x74b81(%rip)        # b8ffc <cursorpos>
   44478:	00 00 00 
}
   4447b:	90                   	nop
   4447c:	c9                   	leave  
   4447d:	c3                   	ret    
