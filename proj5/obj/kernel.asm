
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
   400be:	e8 ea 07 00 00       	call   408ad <exception>

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
   40177:	e8 5c 17 00 00       	call   418d8 <hardware_init>
    pageinfo_init();
   4017c:	e8 5c 0c 00 00       	call   40ddd <pageinfo_init>
    console_clear();
   40181:	e8 ed 43 00 00       	call   44573 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 b0 1c 00 00       	call   41e40 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 7f 1e 01 00 	lea    0x11e7f(%rip),%rax        # 52020 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 15 34 00 00       	call   435be <memset>
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
   40210:	48 8d 15 a9 43 00 00 	lea    0x43a9(%rip),%rdx        # 445c0 <console_clear+0x4d>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 a5 34 00 00       	call   436c7 <strcmp>
   40222:	85 c0                	test   %eax,%eax
   40224:	75 14                	jne    4023a <kernel+0xd3>
        process_setup(1, 4);
   40226:	be 04 00 00 00       	mov    $0x4,%esi
   4022b:	bf 01 00 00 00       	mov    $0x1,%edi
   40230:	e8 57 02 00 00       	call   4048c <process_setup>
   40235:	e9 d1 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4023a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4023f:	74 2e                	je     4026f <kernel+0x108>
   40241:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40245:	48 8d 15 79 43 00 00 	lea    0x4379(%rip),%rdx        # 445c5 <console_clear+0x52>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 70 34 00 00       	call   436c7 <strcmp>
   40257:	85 c0                	test   %eax,%eax
   40259:	75 14                	jne    4026f <kernel+0x108>
        process_setup(1, 5);
   4025b:	be 05 00 00 00       	mov    $0x5,%esi
   40260:	bf 01 00 00 00       	mov    $0x1,%edi
   40265:	e8 22 02 00 00       	call   4048c <process_setup>
   4026a:	e9 9c 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test") == 0) {
   4026f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40274:	74 2b                	je     402a1 <kernel+0x13a>
   40276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4027a:	48 8d 15 4d 43 00 00 	lea    0x434d(%rip),%rdx        # 445ce <console_clear+0x5b>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 3b 34 00 00       	call   436c7 <strcmp>
   4028c:	85 c0                	test   %eax,%eax
   4028e:	75 11                	jne    402a1 <kernel+0x13a>
        process_setup(1, 6);
   40290:	be 06 00 00 00       	mov    $0x6,%esi
   40295:	bf 01 00 00 00       	mov    $0x1,%edi
   4029a:	e8 ed 01 00 00       	call   4048c <process_setup>
   4029f:	eb 6a                	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test2") == 0) {
   402a1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a6:	74 3e                	je     402e6 <kernel+0x17f>
   402a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402ac:	48 8d 15 20 43 00 00 	lea    0x4320(%rip),%rdx        # 445d3 <console_clear+0x60>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 09 34 00 00       	call   436c7 <strcmp>
   402be:	85 c0                	test   %eax,%eax
   402c0:	75 24                	jne    402e6 <kernel+0x17f>
        for (pid_t i = 1; i <= 2; ++i) {
   402c2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402c9:	eb 13                	jmp    402de <kernel+0x177>
            process_setup(i, 6);
   402cb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402ce:	be 06 00 00 00       	mov    $0x6,%esi
   402d3:	89 c7                	mov    %eax,%edi
   402d5:	e8 b2 01 00 00       	call   4048c <process_setup>
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
   402fc:	e8 8b 01 00 00       	call   4048c <process_setup>
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
   4032a:	e8 7e 29 00 00       	call   42cad <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   4032f:	48 8d 15 ca 7c 07 00 	lea    0x77cca(%rip),%rdx        # b8000 <console>
   40336:	48 8d 35 c3 7c 07 00 	lea    0x77cc3(%rip),%rsi        # b8000 <console>
   4033d:	48 8b 05 bc 4c 01 00 	mov    0x14cbc(%rip),%rax        # 55000 <kernel_pagetable>
   40344:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4034a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4034f:	48 89 c7             	mov    %rax,%rdi
   40352:	e8 56 29 00 00       	call   42cad <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    // Switch to the first process using run()
    run(&processes[1]);
   40357:	48 8d 05 a2 1d 01 00 	lea    0x11da2(%rip),%rax        # 52100 <processes+0xe0>
   4035e:	48 89 c7             	mov    %rax,%rdi
   40361:	e8 0c 0a 00 00       	call   40d72 <run>

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
   403e0:	e8 d9 31 00 00       	call   435be <memset>
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

000000000004048c <process_setup>:


void process_setup(pid_t pid, int program_number) {
   4048c:	f3 0f 1e fa          	endbr64 
   40490:	55                   	push   %rbp
   40491:	48 89 e5             	mov    %rsp,%rbp
   40494:	48 83 ec 60          	sub    $0x60,%rsp
   40498:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4049b:	89 75 a8             	mov    %esi,-0x58(%rbp)
    process_init(&processes[pid], 0);
   4049e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404a1:	48 63 d0             	movslq %eax,%rdx
   404a4:	48 89 d0             	mov    %rdx,%rax
   404a7:	48 c1 e0 03          	shl    $0x3,%rax
   404ab:	48 29 d0             	sub    %rdx,%rax
   404ae:	48 c1 e0 05          	shl    $0x5,%rax
   404b2:	48 8d 15 67 1b 01 00 	lea    0x11b67(%rip),%rdx        # 52020 <processes>
   404b9:	48 01 d0             	add    %rdx,%rax
   404bc:	be 00 00 00 00       	mov    $0x0,%esi
   404c1:	48 89 c7             	mov    %rax,%rdi
   404c4:	e8 2a 1c 00 00       	call   420f3 <process_init>
    x86_64_pagetable *l4 = reserve_page(pid);
   404c9:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404cc:	0f be c0             	movsbl %al,%eax
   404cf:	89 c7                	mov    %eax,%edi
   404d1:	e8 90 fe ff ff       	call   40366 <reserve_page>
   404d6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    x86_64_pagetable *l3 = reserve_page(pid);
   404da:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404dd:	0f be c0             	movsbl %al,%eax
   404e0:	89 c7                	mov    %eax,%edi
   404e2:	e8 7f fe ff ff       	call   40366 <reserve_page>
   404e7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    x86_64_pagetable *l2 = reserve_page(pid);
   404eb:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404ee:	0f be c0             	movsbl %al,%eax
   404f1:	89 c7                	mov    %eax,%edi
   404f3:	e8 6e fe ff ff       	call   40366 <reserve_page>
   404f8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    x86_64_pagetable *l1_1 = reserve_page(pid);
   404fc:	8b 45 ac             	mov    -0x54(%rbp),%eax
   404ff:	0f be c0             	movsbl %al,%eax
   40502:	89 c7                	mov    %eax,%edi
   40504:	e8 5d fe ff ff       	call   40366 <reserve_page>
   40509:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    x86_64_pagetable *l1_0 = reserve_page(pid);
   4050d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   40510:	0f be c0             	movsbl %al,%eax
   40513:	89 c7                	mov    %eax,%edi
   40515:	e8 4c fe ff ff       	call   40366 <reserve_page>
   4051a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

    l4->entry[0] = (x86_64_pageentry_t)l3 | PTE_P | PTE_W | PTE_U;
   4051e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40522:	48 83 c8 07          	or     $0x7,%rax
   40526:	48 89 c2             	mov    %rax,%rdx
   40529:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4052d:	48 89 10             	mov    %rdx,(%rax)
    l3->entry[0] = (x86_64_pageentry_t)l2 | PTE_P | PTE_W | PTE_U;
   40530:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40534:	48 83 c8 07          	or     $0x7,%rax
   40538:	48 89 c2             	mov    %rax,%rdx
   4053b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4053f:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[0] = (x86_64_pageentry_t)l1_0 | PTE_P | PTE_W | PTE_U;
   40542:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40546:	48 83 c8 07          	or     $0x7,%rax
   4054a:	48 89 c2             	mov    %rax,%rdx
   4054d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40551:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[1] = (x86_64_pageentry_t)l1_1 | PTE_P | PTE_W | PTE_U;
   40554:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40558:	48 83 c8 07          	or     $0x7,%rax
   4055c:	48 89 c2             	mov    %rax,%rdx
   4055f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40563:	48 89 50 08          	mov    %rdx,0x8(%rax)

    for (uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE) {
   40567:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4056e:	00 
   4056f:	eb 4e                	jmp    405bf <process_setup+0x133>
        vamapping vam = virtual_memory_lookup(kernel_pagetable, va);
   40571:	48 8b 0d 88 4a 01 00 	mov    0x14a88(%rip),%rcx        # 55000 <kernel_pagetable>
   40578:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4057c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40580:	48 89 ce             	mov    %rcx,%rsi
   40583:	48 89 c7             	mov    %rax,%rdi
   40586:	e8 6c 2b 00 00       	call   430f7 <virtual_memory_lookup>
        if (vam.pn != -1) {
   4058b:	8b 45 b0             	mov    -0x50(%rbp),%eax
   4058e:	83 f8 ff             	cmp    $0xffffffff,%eax
   40591:	74 24                	je     405b7 <process_setup+0x12b>
            virtual_memory_map(l4, va, vam.pa, PAGESIZE, vam.perm & ~PTE_U);
   40593:	8b 45 c0             	mov    -0x40(%rbp),%eax
   40596:	83 e0 fb             	and    $0xfffffffb,%eax
   40599:	89 c1                	mov    %eax,%ecx
   4059b:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4059f:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   405a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   405a7:	41 89 c8             	mov    %ecx,%r8d
   405aa:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405af:	48 89 c7             	mov    %rax,%rdi
   405b2:	e8 f6 26 00 00       	call   42cad <virtual_memory_map>
    for (uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE) {
   405b7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   405be:	00 
   405bf:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   405c6:	00 
   405c7:	76 a8                	jbe    40571 <process_setup+0xe5>
        }
    }
    processes[pid].p_pagetable = l4;
   405c9:	8b 45 ac             	mov    -0x54(%rbp),%eax
   405cc:	48 63 d0             	movslq %eax,%rdx
   405cf:	48 89 d0             	mov    %rdx,%rax
   405d2:	48 c1 e0 03          	shl    $0x3,%rax
   405d6:	48 29 d0             	sub    %rdx,%rax
   405d9:	48 c1 e0 05          	shl    $0x5,%rax
   405dd:	48 89 c1             	mov    %rax,%rcx
   405e0:	48 8d 15 09 1b 01 00 	lea    0x11b09(%rip),%rdx        # 520f0 <processes+0xd0>
   405e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   405eb:	48 89 04 11          	mov    %rax,(%rcx,%rdx,1)
    // FIXME
    // virtual_memory_map(l4, 0, 0,
    //                PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(l4, CONSOLE_ADDR, CONSOLE_ADDR,
   405ef:	48 8d 15 0a 7a 07 00 	lea    0x77a0a(%rip),%rdx        # b8000 <console>
   405f6:	48 8d 35 03 7a 07 00 	lea    0x77a03(%rip),%rsi        # b8000 <console>
   405fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40601:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40607:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4060c:	48 89 c7             	mov    %rax,%rdi
   4060f:	e8 99 26 00 00       	call   42cad <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    int r = program_load(&processes[pid], program_number, NULL);
   40614:	8b 45 ac             	mov    -0x54(%rbp),%eax
   40617:	48 63 d0             	movslq %eax,%rdx
   4061a:	48 89 d0             	mov    %rdx,%rax
   4061d:	48 c1 e0 03          	shl    $0x3,%rax
   40621:	48 29 d0             	sub    %rdx,%rax
   40624:	48 c1 e0 05          	shl    $0x5,%rax
   40628:	48 8d 15 f1 19 01 00 	lea    0x119f1(%rip),%rdx        # 52020 <processes>
   4062f:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
   40633:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40636:	ba 00 00 00 00       	mov    $0x0,%edx
   4063b:	89 c6                	mov    %eax,%esi
   4063d:	48 89 cf             	mov    %rcx,%rdi
   40640:	e8 ad 2b 00 00       	call   431f2 <program_load>
   40645:	89 45 cc             	mov    %eax,-0x34(%rbp)
    assert(r >= 0);
   40648:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
   4064c:	79 1e                	jns    4066c <process_setup+0x1e0>
   4064e:	48 8d 05 84 3f 00 00 	lea    0x3f84(%rip),%rax        # 445d9 <console_clear+0x66>
   40655:	48 89 c2             	mov    %rax,%rdx
   40658:	be b8 00 00 00       	mov    $0xb8,%esi
   4065d:	48 8d 05 7c 3f 00 00 	lea    0x3f7c(%rip),%rax        # 445e0 <console_clear+0x6d>
   40664:	48 89 c7             	mov    %rax,%rdi
   40667:	e8 bd 22 00 00       	call   42929 <assert_fail>

    // Set up stack
    virtual_memory_map(l4, MEMSIZE_VIRTUAL - PAGESIZE, find_page(pid), PAGESIZE, PTE_P | PTE_W | PTE_U);
   4066c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4066f:	0f be c0             	movsbl %al,%eax
   40672:	89 c7                	mov    %eax,%edi
   40674:	e8 8b fd ff ff       	call   40404 <find_page>
   40679:	48 89 c2             	mov    %rax,%rdx
   4067c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40680:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40686:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4068b:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   40690:	48 89 c7             	mov    %rax,%rdi
   40693:	e8 15 26 00 00       	call   42cad <virtual_memory_map>
    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL;
   40698:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4069b:	48 63 d0             	movslq %eax,%rdx
   4069e:	48 89 d0             	mov    %rdx,%rax
   406a1:	48 c1 e0 03          	shl    $0x3,%rax
   406a5:	48 29 d0             	sub    %rdx,%rax
   406a8:	48 c1 e0 05          	shl    $0x5,%rax
   406ac:	48 89 c2             	mov    %rax,%rdx
   406af:	48 8d 05 22 1a 01 00 	lea    0x11a22(%rip),%rax        # 520d8 <processes+0xb8>
   406b6:	48 c7 04 02 00 00 30 	movq   $0x300000,(%rdx,%rax,1)
   406bd:	00 

    processes[pid].p_state = P_RUNNABLE;
   406be:	8b 45 ac             	mov    -0x54(%rbp),%eax
   406c1:	48 63 d0             	movslq %eax,%rdx
   406c4:	48 89 d0             	mov    %rdx,%rax
   406c7:	48 c1 e0 03          	shl    $0x3,%rax
   406cb:	48 29 d0             	sub    %rdx,%rax
   406ce:	48 c1 e0 05          	shl    $0x5,%rax
   406d2:	48 89 c2             	mov    %rax,%rdx
   406d5:	48 8d 05 0c 1a 01 00 	lea    0x11a0c(%rip),%rax        # 520e8 <processes+0xc8>
   406dc:	c7 04 02 01 00 00 00 	movl   $0x1,(%rdx,%rax,1)
}
   406e3:	90                   	nop
   406e4:	c9                   	leave  
   406e5:	c3                   	ret    

00000000000406e6 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   406e6:	f3 0f 1e fa          	endbr64 
   406ea:	55                   	push   %rbp
   406eb:	48 89 e5             	mov    %rsp,%rbp
   406ee:	48 83 ec 10          	sub    $0x10,%rsp
   406f2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   406f6:	89 f0                	mov    %esi,%eax
   406f8:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   406fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   406ff:	25 ff 0f 00 00       	and    $0xfff,%eax
   40704:	48 85 c0             	test   %rax,%rax
   40707:	75 27                	jne    40730 <assign_physical_page+0x4a>
        || addr >= MEMSIZE_PHYSICAL
   40709:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40710:	00 
   40711:	77 1d                	ja     40730 <assign_physical_page+0x4a>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40713:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40717:	48 c1 e8 0c          	shr    $0xc,%rax
   4071b:	48 98                	cltq   
   4071d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40721:	48 8d 05 19 27 01 00 	lea    0x12719(%rip),%rax        # 52e41 <pageinfo+0x1>
   40728:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4072c:	84 c0                	test   %al,%al
   4072e:	74 07                	je     40737 <assign_physical_page+0x51>
        return -1;
   40730:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40735:	eb 3a                	jmp    40771 <assign_physical_page+0x8b>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   40737:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4073b:	48 c1 e8 0c          	shr    $0xc,%rax
   4073f:	48 98                	cltq   
   40741:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40745:	48 8d 05 f5 26 01 00 	lea    0x126f5(%rip),%rax        # 52e41 <pageinfo+0x1>
   4074c:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40750:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40754:	48 c1 e8 0c          	shr    $0xc,%rax
   40758:	48 98                	cltq   
   4075a:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4075e:	48 8d 15 db 26 01 00 	lea    0x126db(%rip),%rdx        # 52e40 <pageinfo>
   40765:	0f b6 45 f4          	movzbl -0xc(%rbp),%eax
   40769:	88 04 11             	mov    %al,(%rcx,%rdx,1)
        return 0;
   4076c:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40771:	c9                   	leave  
   40772:	c3                   	ret    

0000000000040773 <syscall_mapping>:

void syscall_mapping(proc* p){
   40773:	f3 0f 1e fa          	endbr64 
   40777:	55                   	push   %rbp
   40778:	48 89 e5             	mov    %rsp,%rbp
   4077b:	48 83 ec 70          	sub    $0x70,%rsp
   4077f:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40783:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40787:	48 8b 40 38          	mov    0x38(%rax),%rax
   4078b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   4078f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40793:	48 8b 40 30          	mov    0x30(%rax),%rax
   40797:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   4079b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4079f:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407a6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   407aa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407ae:	48 89 ce             	mov    %rcx,%rsi
   407b1:	48 89 c7             	mov    %rax,%rdi
   407b4:	e8 3e 29 00 00       	call   430f7 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   407b9:	8b 45 e0             	mov    -0x20(%rbp),%eax
   407bc:	48 98                	cltq   
   407be:	83 e0 06             	and    $0x6,%eax
   407c1:	48 83 f8 06          	cmp    $0x6,%rax
   407c5:	75 73                	jne    4083a <syscall_mapping+0xc7>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   407c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407cb:	48 83 c0 17          	add    $0x17,%rax
   407cf:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   407d3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407d7:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407de:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   407e2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   407e6:	48 89 ce             	mov    %rcx,%rsi
   407e9:	48 89 c7             	mov    %rax,%rdi
   407ec:	e8 06 29 00 00       	call   430f7 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   407f1:	8b 45 c8             	mov    -0x38(%rbp),%eax
   407f4:	48 98                	cltq   
   407f6:	83 e0 03             	and    $0x3,%eax
   407f9:	48 83 f8 03          	cmp    $0x3,%rax
   407fd:	75 3e                	jne    4083d <syscall_mapping+0xca>
        return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   407ff:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40803:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4080a:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4080e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40812:	48 89 ce             	mov    %rcx,%rsi
   40815:	48 89 c7             	mov    %rax,%rdi
   40818:	e8 da 28 00 00       	call   430f7 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   4081d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40821:	48 89 c1             	mov    %rax,%rcx
   40824:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40828:	ba 18 00 00 00       	mov    $0x18,%edx
   4082d:	48 89 c6             	mov    %rax,%rsi
   40830:	48 89 cf             	mov    %rcx,%rdi
   40833:	e8 80 2c 00 00       	call   434b8 <memcpy>
   40838:	eb 04                	jmp    4083e <syscall_mapping+0xcb>
        return;
   4083a:	90                   	nop
   4083b:	eb 01                	jmp    4083e <syscall_mapping+0xcb>
        return;
   4083d:	90                   	nop
}
   4083e:	c9                   	leave  
   4083f:	c3                   	ret    

0000000000040840 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40840:	f3 0f 1e fa          	endbr64 
   40844:	55                   	push   %rbp
   40845:	48 89 e5             	mov    %rsp,%rbp
   40848:	48 83 ec 18          	sub    $0x18,%rsp
   4084c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40850:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40854:	48 8b 40 38          	mov    0x38(%rax),%rax
   40858:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   4085b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4085f:	75 14                	jne    40875 <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   40861:	0f b6 05 98 57 00 00 	movzbl 0x5798(%rip),%eax        # 46000 <disp_global>
   40868:	84 c0                	test   %al,%al
   4086a:	0f 94 c0             	sete   %al
   4086d:	88 05 8d 57 00 00    	mov    %al,0x578d(%rip)        # 46000 <disp_global>
   40873:	eb 36                	jmp    408ab <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40875:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40879:	78 2f                	js     408aa <syscall_mem_tog+0x6a>
   4087b:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4087f:	7f 29                	jg     408aa <syscall_mem_tog+0x6a>
   40881:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40885:	8b 00                	mov    (%rax),%eax
   40887:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4088a:	75 1e                	jne    408aa <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   4088c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40890:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   40897:	84 c0                	test   %al,%al
   40899:	0f 94 c0             	sete   %al
   4089c:	89 c2                	mov    %eax,%edx
   4089e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408a2:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   408a8:	eb 01                	jmp    408ab <syscall_mem_tog+0x6b>
            return;
   408aa:	90                   	nop
    }
}
   408ab:	c9                   	leave  
   408ac:	c3                   	ret    

00000000000408ad <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   408ad:	f3 0f 1e fa          	endbr64 
   408b1:	55                   	push   %rbp
   408b2:	48 89 e5             	mov    %rsp,%rbp
   408b5:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   408bc:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   408c3:	48 8b 05 36 17 01 00 	mov    0x11736(%rip),%rax        # 52000 <current>
   408ca:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   408d1:	48 83 c0 08          	add    $0x8,%rax
   408d5:	48 89 d6             	mov    %rdx,%rsi
   408d8:	ba 18 00 00 00       	mov    $0x18,%edx
   408dd:	48 89 c7             	mov    %rax,%rdi
   408e0:	48 89 d1             	mov    %rdx,%rcx
   408e3:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   408e6:	48 8b 05 13 47 01 00 	mov    0x14713(%rip),%rax        # 55000 <kernel_pagetable>
   408ed:	48 89 c7             	mov    %rax,%rdi
   408f0:	e8 46 22 00 00       	call   42b3b <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   408f5:	8b 05 01 87 07 00    	mov    0x78701(%rip),%eax        # b8ffc <cursorpos>
   408fb:	89 c7                	mov    %eax,%edi
   408fd:	e8 bf 18 00 00       	call   421c1 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40902:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40909:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40910:	48 83 f8 0e          	cmp    $0xe,%rax
   40914:	74 14                	je     4092a <exception+0x7d>
   40916:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   4091d:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40924:	48 83 f8 0d          	cmp    $0xd,%rax
   40928:	75 16                	jne    40940 <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   4092a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40931:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40938:	83 e0 04             	and    $0x4,%eax
   4093b:	48 85 c0             	test   %rax,%rax
   4093e:	74 1a                	je     4095a <exception+0xad>
    {
        check_virtual_memory();
   40940:	e8 c2 08 00 00       	call   41207 <check_virtual_memory>
        if(disp_global){
   40945:	0f b6 05 b4 56 00 00 	movzbl 0x56b4(%rip),%eax        # 46000 <disp_global>
   4094c:	84 c0                	test   %al,%al
   4094e:	74 0a                	je     4095a <exception+0xad>
            memshow_physical();
   40950:	e8 7b 0a 00 00       	call   413d0 <memshow_physical>
            memshow_virtual_animate();
   40955:	e8 18 0e 00 00       	call   41772 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   4095a:	e8 78 1d 00 00       	call   426d7 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   4095f:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40966:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4096d:	48 83 e8 0e          	sub    $0xe,%rax
   40971:	48 83 f8 2a          	cmp    $0x2a,%rax
   40975:	0f 87 3f 03 00 00    	ja     40cba <exception+0x40d>
   4097b:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   40982:	00 
   40983:	48 8d 05 f6 3c 00 00 	lea    0x3cf6(%rip),%rax        # 44680 <console_clear+0x10d>
   4098a:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4098d:	48 98                	cltq   
   4098f:	48 8d 15 ea 3c 00 00 	lea    0x3cea(%rip),%rdx        # 44680 <console_clear+0x10d>
   40996:	48 01 d0             	add    %rdx,%rax
   40999:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   4099c:	48 8b 05 5d 16 01 00 	mov    0x1165d(%rip),%rax        # 52000 <current>
   409a3:	48 8b 40 38          	mov    0x38(%rax),%rax
   409a7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
		if((void *)addr == NULL)
   409ab:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   409b0:	75 0f                	jne    409c1 <exception+0x114>
		    panic(NULL);
   409b2:	bf 00 00 00 00       	mov    $0x0,%edi
   409b7:	b8 00 00 00 00       	mov    $0x0,%eax
   409bc:	e8 78 1e 00 00       	call   42839 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   409c1:	48 8b 05 38 16 01 00 	mov    0x11638(%rip),%rax        # 52000 <current>
   409c8:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   409cf:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   409d3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   409d7:	48 89 ce             	mov    %rcx,%rsi
   409da:	48 89 c7             	mov    %rax,%rdi
   409dd:	e8 15 27 00 00       	call   430f7 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   409e2:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   409e6:	48 89 c1             	mov    %rax,%rcx
   409e9:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   409f0:	ba a0 00 00 00       	mov    $0xa0,%edx
   409f5:	48 89 ce             	mov    %rcx,%rsi
   409f8:	48 89 c7             	mov    %rax,%rdi
   409fb:	e8 b8 2a 00 00       	call   434b8 <memcpy>
		panic(msg);
   40a00:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   40a07:	48 89 c7             	mov    %rax,%rdi
   40a0a:	b8 00 00 00 00       	mov    $0x0,%eax
   40a0f:	e8 25 1e 00 00       	call   42839 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40a14:	48 8b 05 e5 15 01 00 	mov    0x115e5(%rip),%rax        # 52000 <current>
   40a1b:	8b 10                	mov    (%rax),%edx
   40a1d:	48 8b 05 dc 15 01 00 	mov    0x115dc(%rip),%rax        # 52000 <current>
   40a24:	48 63 d2             	movslq %edx,%rdx
   40a27:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40a2b:	e9 9a 02 00 00       	jmp    40cca <exception+0x41d>

    case INT_SYS_YIELD:
        schedule();
   40a30:	e8 be 02 00 00       	call   40cf3 <schedule>
        break;                  /* will not be reached */
   40a35:	e9 90 02 00 00       	jmp    40cca <exception+0x41d>

case INT_SYS_PAGE_ALLOC: {
    uintptr_t va = current->p_registers.reg_rdi;
   40a3a:	48 8b 05 bf 15 01 00 	mov    0x115bf(%rip),%rax        # 52000 <current>
   40a41:	48 8b 40 38          	mov    0x38(%rax),%rax
   40a45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // check allignment and bounds
    if (va % PAGESIZE != 0) {
   40a49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a4d:	25 ff 0f 00 00       	and    $0xfff,%eax
   40a52:	48 85 c0             	test   %rax,%rax
   40a55:	74 14                	je     40a6b <exception+0x1be>
        current->p_registers.reg_rax = -1; 
   40a57:	48 8b 05 a2 15 01 00 	mov    0x115a2(%rip),%rax        # 52000 <current>
   40a5e:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40a65:	ff 
        break;
   40a66:	e9 5f 02 00 00       	jmp    40cca <exception+0x41d>
    }
    if (va >= MEMSIZE_VIRTUAL) {
   40a6b:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40a72:	00 
   40a73:	76 14                	jbe    40a89 <exception+0x1dc>
        current->p_registers.reg_rax = -1; 
   40a75:	48 8b 05 84 15 01 00 	mov    0x11584(%rip),%rax        # 52000 <current>
   40a7c:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40a83:	ff 
        break;
   40a84:	e9 41 02 00 00       	jmp    40cca <exception+0x41d>
    }
    if (va < PROC_START_ADDR) {
   40a89:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   40a90:	00 
   40a91:	77 14                	ja     40aa7 <exception+0x1fa>
        current->p_registers.reg_rax = -1; 
   40a93:	48 8b 05 66 15 01 00 	mov    0x11566(%rip),%rax        # 52000 <current>
   40a9a:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40aa1:	ff 
        break;
   40aa2:	e9 23 02 00 00       	jmp    40cca <exception+0x41d>
    }   
    uintptr_t pa = find_page(current->p_pid);
   40aa7:	48 8b 05 52 15 01 00 	mov    0x11552(%rip),%rax        # 52000 <current>
   40aae:	8b 00                	mov    (%rax),%eax
   40ab0:	0f be c0             	movsbl %al,%eax
   40ab3:	89 c7                	mov    %eax,%edi
   40ab5:	e8 4a f9 ff ff       	call   40404 <find_page>
   40aba:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (pa == 0) {
   40abe:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   40ac3:	75 14                	jne    40ad9 <exception+0x22c>
        current->p_registers.reg_rax = -1; 
   40ac5:	48 8b 05 34 15 01 00 	mov    0x11534(%rip),%rax        # 52000 <current>
   40acc:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40ad3:	ff 
        break;
   40ad4:	e9 f1 01 00 00       	jmp    40cca <exception+0x41d>
    }
    int perm = PTE_P | PTE_W | PTE_U;
   40ad9:	c7 45 ec 07 00 00 00 	movl   $0x7,-0x14(%rbp)

    int r = virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, perm);
   40ae0:	48 8b 05 19 15 01 00 	mov    0x11519(%rip),%rax        # 52000 <current>
   40ae7:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40aee:	8b 4d ec             	mov    -0x14(%rbp),%ecx
   40af1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40af5:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40af9:	41 89 c8             	mov    %ecx,%r8d
   40afc:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40b01:	48 89 c7             	mov    %rax,%rdi
   40b04:	e8 a4 21 00 00       	call   42cad <virtual_memory_map>
   40b09:	89 45 e8             	mov    %eax,-0x18(%rbp)

    if (r != 0) {
   40b0c:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   40b10:	74 46                	je     40b58 <exception+0x2ab>
        // If mapping fails, free the physical page
        pageinfo[PAGENUMBER(pa)].refcount = 0;
   40b12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40b16:	48 c1 e8 0c          	shr    $0xc,%rax
   40b1a:	48 98                	cltq   
   40b1c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40b20:	48 8d 05 1a 23 01 00 	lea    0x1231a(%rip),%rax        # 52e41 <pageinfo+0x1>
   40b27:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(pa)].owner = PO_FREE;
   40b2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40b2f:	48 c1 e8 0c          	shr    $0xc,%rax
   40b33:	48 98                	cltq   
   40b35:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40b39:	48 8d 05 00 23 01 00 	lea    0x12300(%rip),%rax        # 52e40 <pageinfo>
   40b40:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        current->p_registers.reg_rax = -1;
   40b44:	48 8b 05 b5 14 01 00 	mov    0x114b5(%rip),%rax        # 52000 <current>
   40b4b:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b52:	ff 
        break;
   40b53:	e9 72 01 00 00       	jmp    40cca <exception+0x41d>
    }

    // Success: Return 0
    current->p_registers.reg_rax = 0;
   40b58:	48 8b 05 a1 14 01 00 	mov    0x114a1(%rip),%rax        # 52000 <current>
   40b5f:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40b66:	00 
    break;
   40b67:	e9 5e 01 00 00       	jmp    40cca <exception+0x41d>
}


    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40b6c:	48 8b 05 8d 14 01 00 	mov    0x1148d(%rip),%rax        # 52000 <current>
   40b73:	48 89 c7             	mov    %rax,%rdi
   40b76:	e8 f8 fb ff ff       	call   40773 <syscall_mapping>
            break;
   40b7b:	e9 4a 01 00 00       	jmp    40cca <exception+0x41d>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40b80:	48 8b 05 79 14 01 00 	mov    0x11479(%rip),%rax        # 52000 <current>
   40b87:	48 89 c7             	mov    %rax,%rdi
   40b8a:	e8 b1 fc ff ff       	call   40840 <syscall_mem_tog>
	    break;
   40b8f:	e9 36 01 00 00       	jmp    40cca <exception+0x41d>
	}

    case INT_TIMER:
        ++ticks;
   40b94:	8b 05 86 22 01 00    	mov    0x12286(%rip),%eax        # 52e20 <ticks>
   40b9a:	83 c0 01             	add    $0x1,%eax
   40b9d:	89 05 7d 22 01 00    	mov    %eax,0x1227d(%rip)        # 52e20 <ticks>
        schedule();
   40ba3:	e8 4b 01 00 00       	call   40cf3 <schedule>
        break;                  /* will not be reached */
   40ba8:	e9 1d 01 00 00       	jmp    40cca <exception+0x41d>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40bad:	0f 20 d0             	mov    %cr2,%rax
   40bb0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    return val;
   40bb4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40bb8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40bbc:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40bc3:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40bca:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40bcd:	48 85 c0             	test   %rax,%rax
   40bd0:	74 09                	je     40bdb <exception+0x32e>
   40bd2:	48 8d 05 17 3a 00 00 	lea    0x3a17(%rip),%rax        # 445f0 <console_clear+0x7d>
   40bd9:	eb 07                	jmp    40be2 <exception+0x335>
   40bdb:	48 8d 05 14 3a 00 00 	lea    0x3a14(%rip),%rax        # 445f6 <console_clear+0x83>
        const char* operation = reg->reg_err & PFERR_WRITE
   40be2:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40be6:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40bed:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40bf4:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40bf7:	48 85 c0             	test   %rax,%rax
   40bfa:	74 09                	je     40c05 <exception+0x358>
   40bfc:	48 8d 05 f8 39 00 00 	lea    0x39f8(%rip),%rax        # 445fb <console_clear+0x88>
   40c03:	eb 07                	jmp    40c0c <exception+0x35f>
   40c05:	48 8d 05 02 3a 00 00 	lea    0x3a02(%rip),%rax        # 4460e <console_clear+0x9b>
        const char* problem = reg->reg_err & PFERR_PRESENT
   40c0c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40c10:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40c17:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40c1e:	83 e0 04             	and    $0x4,%eax
   40c21:	48 85 c0             	test   %rax,%rax
   40c24:	75 34                	jne    40c5a <exception+0x3ad>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40c26:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40c2d:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40c34:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40c38:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40c3c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40c40:	49 89 f0             	mov    %rsi,%r8
   40c43:	48 89 c6             	mov    %rax,%rsi
   40c46:	48 8d 05 d3 39 00 00 	lea    0x39d3(%rip),%rax        # 44620 <console_clear+0xad>
   40c4d:	48 89 c7             	mov    %rax,%rdi
   40c50:	b8 00 00 00 00       	mov    $0x0,%eax
   40c55:	e8 df 1b 00 00       	call   42839 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40c5a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40c61:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40c68:	48 8b 05 91 13 01 00 	mov    0x11391(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40c6f:	8b 00                	mov    (%rax),%eax
   40c71:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40c75:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   40c79:	52                   	push   %rdx
   40c7a:	ff 75 c8             	push   -0x38(%rbp)
   40c7d:	49 89 f1             	mov    %rsi,%r9
   40c80:	49 89 c8             	mov    %rcx,%r8
   40c83:	89 c1                	mov    %eax,%ecx
   40c85:	48 8d 05 c4 39 00 00 	lea    0x39c4(%rip),%rax        # 44650 <console_clear+0xdd>
   40c8c:	48 89 c2             	mov    %rax,%rdx
   40c8f:	be 00 0c 00 00       	mov    $0xc00,%esi
   40c94:	bf 80 07 00 00       	mov    $0x780,%edi
   40c99:	b8 00 00 00 00       	mov    $0x0,%eax
   40c9e:	e8 5a 37 00 00       	call   443fd <console_printf>
   40ca3:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40ca7:	48 8b 05 52 13 01 00 	mov    0x11352(%rip),%rax        # 52000 <current>
   40cae:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40cb5:	00 00 00 
        break;
   40cb8:	eb 10                	jmp    40cca <exception+0x41d>
    }

    default:
        default_exception(current);
   40cba:	48 8b 05 3f 13 01 00 	mov    0x1133f(%rip),%rax        # 52000 <current>
   40cc1:	48 89 c7             	mov    %rax,%rdi
   40cc4:	e8 99 1c 00 00       	call   42962 <default_exception>
        break;                  /* will not be reached */
   40cc9:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40cca:	48 8b 05 2f 13 01 00 	mov    0x1132f(%rip),%rax        # 52000 <current>
   40cd1:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40cd7:	83 f8 01             	cmp    $0x1,%eax
   40cda:	75 0f                	jne    40ceb <exception+0x43e>
        run(current);
   40cdc:	48 8b 05 1d 13 01 00 	mov    0x1131d(%rip),%rax        # 52000 <current>
   40ce3:	48 89 c7             	mov    %rax,%rdi
   40ce6:	e8 87 00 00 00       	call   40d72 <run>
    } else {
        schedule();
   40ceb:	e8 03 00 00 00       	call   40cf3 <schedule>
    }
}
   40cf0:	90                   	nop
   40cf1:	c9                   	leave  
   40cf2:	c3                   	ret    

0000000000040cf3 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40cf3:	f3 0f 1e fa          	endbr64 
   40cf7:	55                   	push   %rbp
   40cf8:	48 89 e5             	mov    %rsp,%rbp
   40cfb:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40cff:	48 8b 05 fa 12 01 00 	mov    0x112fa(%rip),%rax        # 52000 <current>
   40d06:	8b 00                	mov    (%rax),%eax
   40d08:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40d0b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d0e:	83 c0 01             	add    $0x1,%eax
   40d11:	99                   	cltd   
   40d12:	c1 ea 1c             	shr    $0x1c,%edx
   40d15:	01 d0                	add    %edx,%eax
   40d17:	83 e0 0f             	and    $0xf,%eax
   40d1a:	29 d0                	sub    %edx,%eax
   40d1c:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40d1f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d22:	48 63 d0             	movslq %eax,%rdx
   40d25:	48 89 d0             	mov    %rdx,%rax
   40d28:	48 c1 e0 03          	shl    $0x3,%rax
   40d2c:	48 29 d0             	sub    %rdx,%rax
   40d2f:	48 c1 e0 05          	shl    $0x5,%rax
   40d33:	48 89 c2             	mov    %rax,%rdx
   40d36:	48 8d 05 ab 13 01 00 	lea    0x113ab(%rip),%rax        # 520e8 <processes+0xc8>
   40d3d:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40d40:	83 f8 01             	cmp    $0x1,%eax
   40d43:	75 26                	jne    40d6b <schedule+0x78>
            run(&processes[pid]);
   40d45:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d48:	48 63 d0             	movslq %eax,%rdx
   40d4b:	48 89 d0             	mov    %rdx,%rax
   40d4e:	48 c1 e0 03          	shl    $0x3,%rax
   40d52:	48 29 d0             	sub    %rdx,%rax
   40d55:	48 c1 e0 05          	shl    $0x5,%rax
   40d59:	48 8d 15 c0 12 01 00 	lea    0x112c0(%rip),%rdx        # 52020 <processes>
   40d60:	48 01 d0             	add    %rdx,%rax
   40d63:	48 89 c7             	mov    %rax,%rdi
   40d66:	e8 07 00 00 00       	call   40d72 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40d6b:	e8 67 19 00 00       	call   426d7 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40d70:	eb 99                	jmp    40d0b <schedule+0x18>

0000000000040d72 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40d72:	f3 0f 1e fa          	endbr64 
   40d76:	55                   	push   %rbp
   40d77:	48 89 e5             	mov    %rsp,%rbp
   40d7a:	48 83 ec 10          	sub    $0x10,%rsp
   40d7e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40d82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d86:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40d8c:	83 f8 01             	cmp    $0x1,%eax
   40d8f:	74 1e                	je     40daf <run+0x3d>
   40d91:	48 8d 05 94 39 00 00 	lea    0x3994(%rip),%rax        # 4472c <console_clear+0x1b9>
   40d98:	48 89 c2             	mov    %rax,%rdx
   40d9b:	be a7 01 00 00       	mov    $0x1a7,%esi
   40da0:	48 8d 05 39 38 00 00 	lea    0x3839(%rip),%rax        # 445e0 <console_clear+0x6d>
   40da7:	48 89 c7             	mov    %rax,%rdi
   40daa:	e8 7a 1b 00 00       	call   42929 <assert_fail>
    current = p;
   40daf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40db3:	48 89 05 46 12 01 00 	mov    %rax,0x11246(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40dba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dbe:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40dc5:	48 89 c7             	mov    %rax,%rdi
   40dc8:	e8 6e 1d 00 00       	call   42b3b <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40dcd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dd1:	48 83 c0 08          	add    $0x8,%rax
   40dd5:	48 89 c7             	mov    %rax,%rdi
   40dd8:	e8 e6 f2 ff ff       	call   400c3 <exception_return>

0000000000040ddd <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40ddd:	f3 0f 1e fa          	endbr64 
   40de1:	55                   	push   %rbp
   40de2:	48 89 e5             	mov    %rsp,%rbp
   40de5:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40de9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40df0:	00 
   40df1:	e9 93 00 00 00       	jmp    40e89 <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40df6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dfa:	48 89 c7             	mov    %rax,%rdi
   40dfd:	e8 0f 11 00 00       	call   41f11 <physical_memory_isreserved>
   40e02:	85 c0                	test   %eax,%eax
   40e04:	74 09                	je     40e0f <pageinfo_init+0x32>
            owner = PO_RESERVED;
   40e06:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40e0d:	eb 31                	jmp    40e40 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40e0f:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40e16:	00 
   40e17:	76 0d                	jbe    40e26 <pageinfo_init+0x49>
   40e19:	48 8d 05 e8 a1 01 00 	lea    0x1a1e8(%rip),%rax        # 5b008 <end>
   40e20:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e24:	72 0a                	jb     40e30 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40e26:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40e2d:	00 
   40e2e:	75 09                	jne    40e39 <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   40e30:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40e37:	eb 07                	jmp    40e40 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   40e39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40e40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e44:	48 c1 e8 0c          	shr    $0xc,%rax
   40e48:	89 c2                	mov    %eax,%edx
   40e4a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e4d:	89 c1                	mov    %eax,%ecx
   40e4f:	48 63 c2             	movslq %edx,%rax
   40e52:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e56:	48 8d 05 e3 1f 01 00 	lea    0x11fe3(%rip),%rax        # 52e40 <pageinfo>
   40e5d:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40e60:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40e64:	0f 95 c2             	setne  %dl
   40e67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e6b:	48 c1 e8 0c          	shr    $0xc,%rax
   40e6f:	89 d1                	mov    %edx,%ecx
   40e71:	48 98                	cltq   
   40e73:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e77:	48 8d 05 c3 1f 01 00 	lea    0x11fc3(%rip),%rax        # 52e41 <pageinfo+0x1>
   40e7e:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e81:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e88:	00 
   40e89:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40e90:	00 
   40e91:	0f 86 5f ff ff ff    	jbe    40df6 <pageinfo_init+0x19>
    }
}
   40e97:	90                   	nop
   40e98:	90                   	nop
   40e99:	c9                   	leave  
   40e9a:	c3                   	ret    

0000000000040e9b <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40e9b:	f3 0f 1e fa          	endbr64 
   40e9f:	55                   	push   %rbp
   40ea0:	48 89 e5             	mov    %rsp,%rbp
   40ea3:	48 83 ec 50          	sub    $0x50,%rsp
   40ea7:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40eab:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40eaf:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40eb5:	48 89 c2             	mov    %rax,%rdx
   40eb8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40ebc:	48 39 c2             	cmp    %rax,%rdx
   40ebf:	74 1e                	je     40edf <check_page_table_mappings+0x44>
   40ec1:	48 8d 05 80 38 00 00 	lea    0x3880(%rip),%rax        # 44748 <console_clear+0x1d5>
   40ec8:	48 89 c2             	mov    %rax,%rdx
   40ecb:	be d1 01 00 00       	mov    $0x1d1,%esi
   40ed0:	48 8d 05 09 37 00 00 	lea    0x3709(%rip),%rax        # 445e0 <console_clear+0x6d>
   40ed7:	48 89 c7             	mov    %rax,%rdi
   40eda:	e8 4a 1a 00 00       	call   42929 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40edf:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40ee6:	00 
   40ee7:	e9 b5 00 00 00       	jmp    40fa1 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40eec:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40ef0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40ef4:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40ef8:	48 89 ce             	mov    %rcx,%rsi
   40efb:	48 89 c7             	mov    %rax,%rdi
   40efe:	e8 f4 21 00 00       	call   430f7 <virtual_memory_lookup>
        if (vam.pa != va) {
   40f03:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f07:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f0b:	74 2c                	je     40f39 <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40f0d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40f11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40f15:	49 89 d0             	mov    %rdx,%r8
   40f18:	48 89 c1             	mov    %rax,%rcx
   40f1b:	48 8d 05 45 38 00 00 	lea    0x3845(%rip),%rax        # 44767 <console_clear+0x1f4>
   40f22:	48 89 c2             	mov    %rax,%rdx
   40f25:	be 00 c0 00 00       	mov    $0xc000,%esi
   40f2a:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40f2f:	b8 00 00 00 00       	mov    $0x0,%eax
   40f34:	e8 c4 34 00 00       	call   443fd <console_printf>
        }
        assert(vam.pa == va);
   40f39:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f3d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f41:	74 1e                	je     40f61 <check_page_table_mappings+0xc6>
   40f43:	48 8d 05 27 38 00 00 	lea    0x3827(%rip),%rax        # 44771 <console_clear+0x1fe>
   40f4a:	48 89 c2             	mov    %rax,%rdx
   40f4d:	be da 01 00 00       	mov    $0x1da,%esi
   40f52:	48 8d 05 87 36 00 00 	lea    0x3687(%rip),%rax        # 445e0 <console_clear+0x6d>
   40f59:	48 89 c7             	mov    %rax,%rdi
   40f5c:	e8 c8 19 00 00       	call   42929 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40f61:	48 8d 05 98 50 00 00 	lea    0x5098(%rip),%rax        # 46000 <disp_global>
   40f68:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f6c:	72 2b                	jb     40f99 <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   40f6e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f71:	48 98                	cltq   
   40f73:	83 e0 02             	and    $0x2,%eax
   40f76:	48 85 c0             	test   %rax,%rax
   40f79:	75 1e                	jne    40f99 <check_page_table_mappings+0xfe>
   40f7b:	48 8d 05 fc 37 00 00 	lea    0x37fc(%rip),%rax        # 4477e <console_clear+0x20b>
   40f82:	48 89 c2             	mov    %rax,%rdx
   40f85:	be dc 01 00 00       	mov    $0x1dc,%esi
   40f8a:	48 8d 05 4f 36 00 00 	lea    0x364f(%rip),%rax        # 445e0 <console_clear+0x6d>
   40f91:	48 89 c7             	mov    %rax,%rdi
   40f94:	e8 90 19 00 00       	call   42929 <assert_fail>
         va += PAGESIZE) {
   40f99:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40fa0:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40fa1:	48 8d 05 60 a0 01 00 	lea    0x1a060(%rip),%rax        # 5b008 <end>
   40fa8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40fac:	0f 82 3a ff ff ff    	jb     40eec <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40fb2:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40fb9:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40fba:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40fbe:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40fc2:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40fc6:	48 89 ce             	mov    %rcx,%rsi
   40fc9:	48 89 c7             	mov    %rax,%rdi
   40fcc:	e8 26 21 00 00       	call   430f7 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40fd1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40fd5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40fd9:	74 1e                	je     40ff9 <check_page_table_mappings+0x15e>
   40fdb:	48 8d 05 ad 37 00 00 	lea    0x37ad(%rip),%rax        # 4478f <console_clear+0x21c>
   40fe2:	48 89 c2             	mov    %rax,%rdx
   40fe5:	be e3 01 00 00       	mov    $0x1e3,%esi
   40fea:	48 8d 05 ef 35 00 00 	lea    0x35ef(%rip),%rax        # 445e0 <console_clear+0x6d>
   40ff1:	48 89 c7             	mov    %rax,%rdi
   40ff4:	e8 30 19 00 00       	call   42929 <assert_fail>
    assert(vam.perm & PTE_W);
   40ff9:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40ffc:	48 98                	cltq   
   40ffe:	83 e0 02             	and    $0x2,%eax
   41001:	48 85 c0             	test   %rax,%rax
   41004:	75 1e                	jne    41024 <check_page_table_mappings+0x189>
   41006:	48 8d 05 71 37 00 00 	lea    0x3771(%rip),%rax        # 4477e <console_clear+0x20b>
   4100d:	48 89 c2             	mov    %rax,%rdx
   41010:	be e4 01 00 00       	mov    $0x1e4,%esi
   41015:	48 8d 05 c4 35 00 00 	lea    0x35c4(%rip),%rax        # 445e0 <console_clear+0x6d>
   4101c:	48 89 c7             	mov    %rax,%rdi
   4101f:	e8 05 19 00 00       	call   42929 <assert_fail>
}
   41024:	90                   	nop
   41025:	c9                   	leave  
   41026:	c3                   	ret    

0000000000041027 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   41027:	f3 0f 1e fa          	endbr64 
   4102b:	55                   	push   %rbp
   4102c:	48 89 e5             	mov    %rsp,%rbp
   4102f:	48 83 ec 20          	sub    $0x20,%rsp
   41033:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41037:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   4103a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4103d:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   41040:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41047:	48 8b 05 b2 3f 01 00 	mov    0x13fb2(%rip),%rax        # 55000 <kernel_pagetable>
   4104e:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41052:	75 71                	jne    410c5 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   41054:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4105b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41062:	eb 5b                	jmp    410bf <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   41064:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41067:	48 63 d0             	movslq %eax,%rdx
   4106a:	48 89 d0             	mov    %rdx,%rax
   4106d:	48 c1 e0 03          	shl    $0x3,%rax
   41071:	48 29 d0             	sub    %rdx,%rax
   41074:	48 c1 e0 05          	shl    $0x5,%rax
   41078:	48 89 c2             	mov    %rax,%rdx
   4107b:	48 8d 05 66 10 01 00 	lea    0x11066(%rip),%rax        # 520e8 <processes+0xc8>
   41082:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41085:	85 c0                	test   %eax,%eax
   41087:	74 32                	je     410bb <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41089:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4108c:	48 63 d0             	movslq %eax,%rdx
   4108f:	48 89 d0             	mov    %rdx,%rax
   41092:	48 c1 e0 03          	shl    $0x3,%rax
   41096:	48 29 d0             	sub    %rdx,%rax
   41099:	48 c1 e0 05          	shl    $0x5,%rax
   4109d:	48 89 c2             	mov    %rax,%rdx
   410a0:	48 8d 05 49 10 01 00 	lea    0x11049(%rip),%rax        # 520f0 <processes+0xd0>
   410a7:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   410ab:	48 8b 05 4e 3f 01 00 	mov    0x13f4e(%rip),%rax        # 55000 <kernel_pagetable>
   410b2:	48 39 c2             	cmp    %rax,%rdx
   410b5:	75 04                	jne    410bb <check_page_table_ownership+0x94>
                ++expected_refcount;
   410b7:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   410bb:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   410bf:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   410c3:	7e 9f                	jle    41064 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   410c5:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   410c8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   410cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410cf:	be 00 00 00 00       	mov    $0x0,%esi
   410d4:	48 89 c7             	mov    %rax,%rdi
   410d7:	e8 03 00 00 00       	call   410df <check_page_table_ownership_level>
}
   410dc:	90                   	nop
   410dd:	c9                   	leave  
   410de:	c3                   	ret    

00000000000410df <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   410df:	f3 0f 1e fa          	endbr64 
   410e3:	55                   	push   %rbp
   410e4:	48 89 e5             	mov    %rsp,%rbp
   410e7:	48 83 ec 30          	sub    $0x30,%rsp
   410eb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   410ef:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   410f2:	89 55 e0             	mov    %edx,-0x20(%rbp)
   410f5:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   410f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410fc:	48 c1 e8 0c          	shr    $0xc,%rax
   41100:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41105:	7e 1e                	jle    41125 <check_page_table_ownership_level+0x46>
   41107:	48 8d 05 92 36 00 00 	lea    0x3692(%rip),%rax        # 447a0 <console_clear+0x22d>
   4110e:	48 89 c2             	mov    %rax,%rdx
   41111:	be 01 02 00 00       	mov    $0x201,%esi
   41116:	48 8d 05 c3 34 00 00 	lea    0x34c3(%rip),%rax        # 445e0 <console_clear+0x6d>
   4111d:	48 89 c7             	mov    %rax,%rdi
   41120:	e8 04 18 00 00       	call   42929 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41125:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41129:	48 c1 e8 0c          	shr    $0xc,%rax
   4112d:	48 98                	cltq   
   4112f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41133:	48 8d 05 06 1d 01 00 	lea    0x11d06(%rip),%rax        # 52e40 <pageinfo>
   4113a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4113e:	0f be c0             	movsbl %al,%eax
   41141:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41144:	74 1e                	je     41164 <check_page_table_ownership_level+0x85>
   41146:	48 8d 05 6b 36 00 00 	lea    0x366b(%rip),%rax        # 447b8 <console_clear+0x245>
   4114d:	48 89 c2             	mov    %rax,%rdx
   41150:	be 02 02 00 00       	mov    $0x202,%esi
   41155:	48 8d 05 84 34 00 00 	lea    0x3484(%rip),%rax        # 445e0 <console_clear+0x6d>
   4115c:	48 89 c7             	mov    %rax,%rdi
   4115f:	e8 c5 17 00 00       	call   42929 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41164:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41168:	48 c1 e8 0c          	shr    $0xc,%rax
   4116c:	48 98                	cltq   
   4116e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41172:	48 8d 05 c8 1c 01 00 	lea    0x11cc8(%rip),%rax        # 52e41 <pageinfo+0x1>
   41179:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4117d:	0f be c0             	movsbl %al,%eax
   41180:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41183:	74 1e                	je     411a3 <check_page_table_ownership_level+0xc4>
   41185:	48 8d 05 54 36 00 00 	lea    0x3654(%rip),%rax        # 447e0 <console_clear+0x26d>
   4118c:	48 89 c2             	mov    %rax,%rdx
   4118f:	be 03 02 00 00       	mov    $0x203,%esi
   41194:	48 8d 05 45 34 00 00 	lea    0x3445(%rip),%rax        # 445e0 <console_clear+0x6d>
   4119b:	48 89 c7             	mov    %rax,%rdi
   4119e:	e8 86 17 00 00       	call   42929 <assert_fail>
    if (level < 3) {
   411a3:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   411a7:	7f 5b                	jg     41204 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   411a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   411b0:	eb 49                	jmp    411fb <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   411b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   411b6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411b9:	48 63 d2             	movslq %edx,%rdx
   411bc:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   411c0:	48 85 c0             	test   %rax,%rax
   411c3:	74 32                	je     411f7 <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   411c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   411c9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411cc:	48 63 d2             	movslq %edx,%rdx
   411cf:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   411d3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   411d9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   411dd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   411e0:	8d 70 01             	lea    0x1(%rax),%esi
   411e3:	8b 55 e0             	mov    -0x20(%rbp),%edx
   411e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   411ea:	b9 01 00 00 00       	mov    $0x1,%ecx
   411ef:	48 89 c7             	mov    %rax,%rdi
   411f2:	e8 e8 fe ff ff       	call   410df <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   411f7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411fb:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41202:	7e ae                	jle    411b2 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   41204:	90                   	nop
   41205:	c9                   	leave  
   41206:	c3                   	ret    

0000000000041207 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41207:	f3 0f 1e fa          	endbr64 
   4120b:	55                   	push   %rbp
   4120c:	48 89 e5             	mov    %rsp,%rbp
   4120f:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41213:	8b 05 cf 0e 01 00    	mov    0x10ecf(%rip),%eax        # 520e8 <processes+0xc8>
   41219:	85 c0                	test   %eax,%eax
   4121b:	74 1e                	je     4123b <check_virtual_memory+0x34>
   4121d:	48 8d 05 ec 35 00 00 	lea    0x35ec(%rip),%rax        # 44810 <console_clear+0x29d>
   41224:	48 89 c2             	mov    %rax,%rdx
   41227:	be 16 02 00 00       	mov    $0x216,%esi
   4122c:	48 8d 05 ad 33 00 00 	lea    0x33ad(%rip),%rax        # 445e0 <console_clear+0x6d>
   41233:	48 89 c7             	mov    %rax,%rdi
   41236:	e8 ee 16 00 00       	call   42929 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4123b:	48 8b 05 be 3d 01 00 	mov    0x13dbe(%rip),%rax        # 55000 <kernel_pagetable>
   41242:	48 89 c7             	mov    %rax,%rdi
   41245:	e8 51 fc ff ff       	call   40e9b <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4124a:	48 8b 05 af 3d 01 00 	mov    0x13daf(%rip),%rax        # 55000 <kernel_pagetable>
   41251:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41256:	48 89 c7             	mov    %rax,%rdi
   41259:	e8 c9 fd ff ff       	call   41027 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   4125e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41265:	e9 b4 00 00 00       	jmp    4131e <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   4126a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4126d:	48 63 d0             	movslq %eax,%rdx
   41270:	48 89 d0             	mov    %rdx,%rax
   41273:	48 c1 e0 03          	shl    $0x3,%rax
   41277:	48 29 d0             	sub    %rdx,%rax
   4127a:	48 c1 e0 05          	shl    $0x5,%rax
   4127e:	48 89 c2             	mov    %rax,%rdx
   41281:	48 8d 05 60 0e 01 00 	lea    0x10e60(%rip),%rax        # 520e8 <processes+0xc8>
   41288:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4128b:	85 c0                	test   %eax,%eax
   4128d:	0f 84 87 00 00 00    	je     4131a <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41293:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41296:	48 63 d0             	movslq %eax,%rdx
   41299:	48 89 d0             	mov    %rdx,%rax
   4129c:	48 c1 e0 03          	shl    $0x3,%rax
   412a0:	48 29 d0             	sub    %rdx,%rax
   412a3:	48 c1 e0 05          	shl    $0x5,%rax
   412a7:	48 89 c2             	mov    %rax,%rdx
   412aa:	48 8d 05 3f 0e 01 00 	lea    0x10e3f(%rip),%rax        # 520f0 <processes+0xd0>
   412b1:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   412b5:	48 8b 05 44 3d 01 00 	mov    0x13d44(%rip),%rax        # 55000 <kernel_pagetable>
   412bc:	48 39 c2             	cmp    %rax,%rdx
   412bf:	74 59                	je     4131a <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   412c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412c4:	48 63 d0             	movslq %eax,%rdx
   412c7:	48 89 d0             	mov    %rdx,%rax
   412ca:	48 c1 e0 03          	shl    $0x3,%rax
   412ce:	48 29 d0             	sub    %rdx,%rax
   412d1:	48 c1 e0 05          	shl    $0x5,%rax
   412d5:	48 89 c2             	mov    %rax,%rdx
   412d8:	48 8d 05 11 0e 01 00 	lea    0x10e11(%rip),%rax        # 520f0 <processes+0xd0>
   412df:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   412e3:	48 89 c7             	mov    %rax,%rdi
   412e6:	e8 b0 fb ff ff       	call   40e9b <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   412eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412ee:	48 63 d0             	movslq %eax,%rdx
   412f1:	48 89 d0             	mov    %rdx,%rax
   412f4:	48 c1 e0 03          	shl    $0x3,%rax
   412f8:	48 29 d0             	sub    %rdx,%rax
   412fb:	48 c1 e0 05          	shl    $0x5,%rax
   412ff:	48 89 c2             	mov    %rax,%rdx
   41302:	48 8d 05 e7 0d 01 00 	lea    0x10de7(%rip),%rax        # 520f0 <processes+0xd0>
   41309:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4130d:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41310:	89 d6                	mov    %edx,%esi
   41312:	48 89 c7             	mov    %rax,%rdi
   41315:	e8 0d fd ff ff       	call   41027 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   4131a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4131e:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41322:	0f 8e 42 ff ff ff    	jle    4126a <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41328:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4132f:	e9 8b 00 00 00       	jmp    413bf <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41334:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41337:	48 98                	cltq   
   41339:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4133d:	48 8d 05 fd 1a 01 00 	lea    0x11afd(%rip),%rax        # 52e41 <pageinfo+0x1>
   41344:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41348:	84 c0                	test   %al,%al
   4134a:	7e 6f                	jle    413bb <check_virtual_memory+0x1b4>
   4134c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4134f:	48 98                	cltq   
   41351:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41355:	48 8d 05 e4 1a 01 00 	lea    0x11ae4(%rip),%rax        # 52e40 <pageinfo>
   4135c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41360:	84 c0                	test   %al,%al
   41362:	78 57                	js     413bb <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41364:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41367:	48 98                	cltq   
   41369:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4136d:	48 8d 05 cc 1a 01 00 	lea    0x11acc(%rip),%rax        # 52e40 <pageinfo>
   41374:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41378:	0f be c0             	movsbl %al,%eax
   4137b:	48 63 d0             	movslq %eax,%rdx
   4137e:	48 89 d0             	mov    %rdx,%rax
   41381:	48 c1 e0 03          	shl    $0x3,%rax
   41385:	48 29 d0             	sub    %rdx,%rax
   41388:	48 c1 e0 05          	shl    $0x5,%rax
   4138c:	48 89 c2             	mov    %rax,%rdx
   4138f:	48 8d 05 52 0d 01 00 	lea    0x10d52(%rip),%rax        # 520e8 <processes+0xc8>
   41396:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41399:	85 c0                	test   %eax,%eax
   4139b:	75 1e                	jne    413bb <check_virtual_memory+0x1b4>
   4139d:	48 8d 05 8c 34 00 00 	lea    0x348c(%rip),%rax        # 44830 <console_clear+0x2bd>
   413a4:	48 89 c2             	mov    %rax,%rdx
   413a7:	be 2d 02 00 00       	mov    $0x22d,%esi
   413ac:	48 8d 05 2d 32 00 00 	lea    0x322d(%rip),%rax        # 445e0 <console_clear+0x6d>
   413b3:	48 89 c7             	mov    %rax,%rdi
   413b6:	e8 6e 15 00 00       	call   42929 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413bb:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   413bf:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   413c6:	0f 8e 68 ff ff ff    	jle    41334 <check_virtual_memory+0x12d>
        }
    }
}
   413cc:	90                   	nop
   413cd:	90                   	nop
   413ce:	c9                   	leave  
   413cf:	c3                   	ret    

00000000000413d0 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   413d0:	f3 0f 1e fa          	endbr64 
   413d4:	55                   	push   %rbp
   413d5:	48 89 e5             	mov    %rsp,%rbp
   413d8:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   413dc:	48 8d 05 a3 34 00 00 	lea    0x34a3(%rip),%rax        # 44886 <memstate_colors+0x26>
   413e3:	48 89 c2             	mov    %rax,%rdx
   413e6:	be 00 0f 00 00       	mov    $0xf00,%esi
   413eb:	bf 20 00 00 00       	mov    $0x20,%edi
   413f0:	b8 00 00 00 00       	mov    $0x0,%eax
   413f5:	e8 03 30 00 00       	call   443fd <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41401:	e9 1b 01 00 00       	jmp    41521 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   41406:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41409:	83 e0 3f             	and    $0x3f,%eax
   4140c:	85 c0                	test   %eax,%eax
   4140e:	75 40                	jne    41450 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41410:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41413:	c1 e0 0c             	shl    $0xc,%eax
   41416:	89 c2                	mov    %eax,%edx
   41418:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4141b:	8d 48 3f             	lea    0x3f(%rax),%ecx
   4141e:	85 c0                	test   %eax,%eax
   41420:	0f 48 c1             	cmovs  %ecx,%eax
   41423:	c1 f8 06             	sar    $0x6,%eax
   41426:	8d 48 01             	lea    0x1(%rax),%ecx
   41429:	89 c8                	mov    %ecx,%eax
   4142b:	c1 e0 02             	shl    $0x2,%eax
   4142e:	01 c8                	add    %ecx,%eax
   41430:	c1 e0 04             	shl    $0x4,%eax
   41433:	83 c0 03             	add    $0x3,%eax
   41436:	89 d1                	mov    %edx,%ecx
   41438:	48 8d 15 57 34 00 00 	lea    0x3457(%rip),%rdx        # 44896 <memstate_colors+0x36>
   4143f:	be 00 0f 00 00       	mov    $0xf00,%esi
   41444:	89 c7                	mov    %eax,%edi
   41446:	b8 00 00 00 00       	mov    $0x0,%eax
   4144b:	e8 ad 2f 00 00       	call   443fd <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41450:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41453:	48 98                	cltq   
   41455:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41459:	48 8d 05 e0 19 01 00 	lea    0x119e0(%rip),%rax        # 52e40 <pageinfo>
   41460:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41464:	0f be c0             	movsbl %al,%eax
   41467:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   4146a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4146d:	48 98                	cltq   
   4146f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41473:	48 8d 05 c7 19 01 00 	lea    0x119c7(%rip),%rax        # 52e41 <pageinfo+0x1>
   4147a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4147e:	84 c0                	test   %al,%al
   41480:	75 07                	jne    41489 <memshow_physical+0xb9>
            owner = PO_FREE;
   41482:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41489:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4148c:	83 c0 02             	add    $0x2,%eax
   4148f:	48 98                	cltq   
   41491:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41495:	48 8d 05 c4 33 00 00 	lea    0x33c4(%rip),%rax        # 44860 <memstate_colors>
   4149c:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   414a0:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   414a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414a7:	48 98                	cltq   
   414a9:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   414ad:	48 8d 05 8d 19 01 00 	lea    0x1198d(%rip),%rax        # 52e41 <pageinfo+0x1>
   414b4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   414b8:	3c 01                	cmp    $0x1,%al
   414ba:	7e 1c                	jle    414d8 <memshow_physical+0x108>
   414bc:	48 8d 05 3d 6b 07 00 	lea    0x76b3d(%rip),%rax        # b8000 <console>
   414c3:	48 c1 e8 0c          	shr    $0xc,%rax
   414c7:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   414ca:	74 0c                	je     414d8 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   414cc:	b8 53 00 00 00       	mov    $0x53,%eax
   414d1:	80 cc 0f             	or     $0xf,%ah
   414d4:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   414d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414db:	8d 50 3f             	lea    0x3f(%rax),%edx
   414de:	85 c0                	test   %eax,%eax
   414e0:	0f 48 c2             	cmovs  %edx,%eax
   414e3:	c1 f8 06             	sar    $0x6,%eax
   414e6:	8d 50 01             	lea    0x1(%rax),%edx
   414e9:	89 d0                	mov    %edx,%eax
   414eb:	c1 e0 02             	shl    $0x2,%eax
   414ee:	01 d0                	add    %edx,%eax
   414f0:	c1 e0 04             	shl    $0x4,%eax
   414f3:	89 c1                	mov    %eax,%ecx
   414f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414f8:	99                   	cltd   
   414f9:	c1 ea 1a             	shr    $0x1a,%edx
   414fc:	01 d0                	add    %edx,%eax
   414fe:	83 e0 3f             	and    $0x3f,%eax
   41501:	29 d0                	sub    %edx,%eax
   41503:	83 c0 0c             	add    $0xc,%eax
   41506:	01 c8                	add    %ecx,%eax
   41508:	48 98                	cltq   
   4150a:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4150e:	48 8d 15 eb 6a 07 00 	lea    0x76aeb(%rip),%rdx        # b8000 <console>
   41515:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41519:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4151d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41521:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41528:	0f 8e d8 fe ff ff    	jle    41406 <memshow_physical+0x36>
    }
}
   4152e:	90                   	nop
   4152f:	90                   	nop
   41530:	c9                   	leave  
   41531:	c3                   	ret    

0000000000041532 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41532:	f3 0f 1e fa          	endbr64 
   41536:	55                   	push   %rbp
   41537:	48 89 e5             	mov    %rsp,%rbp
   4153a:	48 83 ec 40          	sub    $0x40,%rsp
   4153e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41542:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41546:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4154a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41550:	48 89 c2             	mov    %rax,%rdx
   41553:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41557:	48 39 c2             	cmp    %rax,%rdx
   4155a:	74 1e                	je     4157a <memshow_virtual+0x48>
   4155c:	48 8d 05 3d 33 00 00 	lea    0x333d(%rip),%rax        # 448a0 <memstate_colors+0x40>
   41563:	48 89 c2             	mov    %rax,%rdx
   41566:	be 5e 02 00 00       	mov    $0x25e,%esi
   4156b:	48 8d 05 6e 30 00 00 	lea    0x306e(%rip),%rax        # 445e0 <console_clear+0x6d>
   41572:	48 89 c7             	mov    %rax,%rdi
   41575:	e8 af 13 00 00       	call   42929 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   4157a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4157e:	48 89 c1             	mov    %rax,%rcx
   41581:	48 8d 05 45 33 00 00 	lea    0x3345(%rip),%rax        # 448cd <memstate_colors+0x6d>
   41588:	48 89 c2             	mov    %rax,%rdx
   4158b:	be 00 0f 00 00       	mov    $0xf00,%esi
   41590:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41595:	b8 00 00 00 00       	mov    $0x0,%eax
   4159a:	e8 5e 2e 00 00       	call   443fd <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4159f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   415a6:	00 
   415a7:	e9 b4 01 00 00       	jmp    41760 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   415ac:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   415b0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   415b4:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   415b8:	48 89 ce             	mov    %rcx,%rsi
   415bb:	48 89 c7             	mov    %rax,%rdi
   415be:	e8 34 1b 00 00       	call   430f7 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   415c3:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415c6:	85 c0                	test   %eax,%eax
   415c8:	79 0b                	jns    415d5 <memshow_virtual+0xa3>
            color = ' ';
   415ca:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   415d0:	e9 ff 00 00 00       	jmp    416d4 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   415d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   415d9:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   415df:	76 1e                	jbe    415ff <memshow_virtual+0xcd>
   415e1:	48 8d 05 02 33 00 00 	lea    0x3302(%rip),%rax        # 448ea <memstate_colors+0x8a>
   415e8:	48 89 c2             	mov    %rax,%rdx
   415eb:	be 67 02 00 00       	mov    $0x267,%esi
   415f0:	48 8d 05 e9 2f 00 00 	lea    0x2fe9(%rip),%rax        # 445e0 <console_clear+0x6d>
   415f7:	48 89 c7             	mov    %rax,%rdi
   415fa:	e8 2a 13 00 00       	call   42929 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   415ff:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41602:	48 98                	cltq   
   41604:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41608:	48 8d 05 31 18 01 00 	lea    0x11831(%rip),%rax        # 52e40 <pageinfo>
   4160f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41613:	0f be c0             	movsbl %al,%eax
   41616:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41619:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4161c:	48 98                	cltq   
   4161e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41622:	48 8d 05 18 18 01 00 	lea    0x11818(%rip),%rax        # 52e41 <pageinfo+0x1>
   41629:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4162d:	84 c0                	test   %al,%al
   4162f:	75 07                	jne    41638 <memshow_virtual+0x106>
                owner = PO_FREE;
   41631:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41638:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4163b:	83 c0 02             	add    $0x2,%eax
   4163e:	48 98                	cltq   
   41640:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41644:	48 8d 05 15 32 00 00 	lea    0x3215(%rip),%rax        # 44860 <memstate_colors>
   4164b:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   4164f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41653:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41656:	48 98                	cltq   
   41658:	83 e0 04             	and    $0x4,%eax
   4165b:	48 85 c0             	test   %rax,%rax
   4165e:	74 27                	je     41687 <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41660:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41664:	c1 e0 04             	shl    $0x4,%eax
   41667:	66 25 00 f0          	and    $0xf000,%ax
   4166b:	89 c2                	mov    %eax,%edx
   4166d:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41671:	c1 f8 04             	sar    $0x4,%eax
   41674:	66 25 00 0f          	and    $0xf00,%ax
   41678:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   4167a:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4167e:	0f b6 c0             	movzbl %al,%eax
   41681:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41683:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41687:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4168a:	48 98                	cltq   
   4168c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41690:	48 8d 05 aa 17 01 00 	lea    0x117aa(%rip),%rax        # 52e41 <pageinfo+0x1>
   41697:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4169b:	3c 01                	cmp    $0x1,%al
   4169d:	7e 35                	jle    416d4 <memshow_virtual+0x1a2>
   4169f:	48 8d 05 5a 69 07 00 	lea    0x7695a(%rip),%rax        # b8000 <console>
   416a6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   416aa:	74 28                	je     416d4 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   416ac:	b8 53 00 00 00       	mov    $0x53,%eax
   416b1:	89 c2                	mov    %eax,%edx
   416b3:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   416b7:	66 25 00 f0          	and    $0xf000,%ax
   416bb:	09 d0                	or     %edx,%eax
   416bd:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   416c1:	8b 45 e0             	mov    -0x20(%rbp),%eax
   416c4:	48 98                	cltq   
   416c6:	83 e0 04             	and    $0x4,%eax
   416c9:	48 85 c0             	test   %rax,%rax
   416cc:	75 06                	jne    416d4 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   416ce:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   416d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416d8:	48 c1 e8 0c          	shr    $0xc,%rax
   416dc:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   416df:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416e2:	83 e0 3f             	and    $0x3f,%eax
   416e5:	85 c0                	test   %eax,%eax
   416e7:	75 39                	jne    41722 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   416e9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416ec:	c1 e8 06             	shr    $0x6,%eax
   416ef:	89 c2                	mov    %eax,%edx
   416f1:	89 d0                	mov    %edx,%eax
   416f3:	c1 e0 02             	shl    $0x2,%eax
   416f6:	01 d0                	add    %edx,%eax
   416f8:	c1 e0 04             	shl    $0x4,%eax
   416fb:	05 73 03 00 00       	add    $0x373,%eax
   41700:	89 c7                	mov    %eax,%edi
   41702:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41706:	48 89 c1             	mov    %rax,%rcx
   41709:	48 8d 05 86 31 00 00 	lea    0x3186(%rip),%rax        # 44896 <memstate_colors+0x36>
   41710:	48 89 c2             	mov    %rax,%rdx
   41713:	be 00 0f 00 00       	mov    $0xf00,%esi
   41718:	b8 00 00 00 00       	mov    $0x0,%eax
   4171d:	e8 db 2c 00 00       	call   443fd <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41722:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41725:	c1 e8 06             	shr    $0x6,%eax
   41728:	89 c2                	mov    %eax,%edx
   4172a:	89 d0                	mov    %edx,%eax
   4172c:	c1 e0 02             	shl    $0x2,%eax
   4172f:	01 d0                	add    %edx,%eax
   41731:	c1 e0 04             	shl    $0x4,%eax
   41734:	89 c2                	mov    %eax,%edx
   41736:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41739:	83 e0 3f             	and    $0x3f,%eax
   4173c:	01 d0                	add    %edx,%eax
   4173e:	05 7c 03 00 00       	add    $0x37c,%eax
   41743:	89 c0                	mov    %eax,%eax
   41745:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41749:	48 8d 15 b0 68 07 00 	lea    0x768b0(%rip),%rdx        # b8000 <console>
   41750:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41754:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41758:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4175f:	00 
   41760:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41767:	00 
   41768:	0f 86 3e fe ff ff    	jbe    415ac <memshow_virtual+0x7a>
    }
}
   4176e:	90                   	nop
   4176f:	90                   	nop
   41770:	c9                   	leave  
   41771:	c3                   	ret    

0000000000041772 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41772:	f3 0f 1e fa          	endbr64 
   41776:	55                   	push   %rbp
   41777:	48 89 e5             	mov    %rsp,%rbp
   4177a:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   4177e:	8b 05 bc 1a 01 00    	mov    0x11abc(%rip),%eax        # 53240 <last_ticks.1>
   41784:	85 c0                	test   %eax,%eax
   41786:	74 13                	je     4179b <memshow_virtual_animate+0x29>
   41788:	8b 05 92 16 01 00    	mov    0x11692(%rip),%eax        # 52e20 <ticks>
   4178e:	8b 15 ac 1a 01 00    	mov    0x11aac(%rip),%edx        # 53240 <last_ticks.1>
   41794:	29 d0                	sub    %edx,%eax
   41796:	83 f8 31             	cmp    $0x31,%eax
   41799:	76 2c                	jbe    417c7 <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   4179b:	8b 05 7f 16 01 00    	mov    0x1167f(%rip),%eax        # 52e20 <ticks>
   417a1:	89 05 99 1a 01 00    	mov    %eax,0x11a99(%rip)        # 53240 <last_ticks.1>
        ++showing;
   417a7:	8b 05 57 48 00 00    	mov    0x4857(%rip),%eax        # 46004 <showing.0>
   417ad:	83 c0 01             	add    $0x1,%eax
   417b0:	89 05 4e 48 00 00    	mov    %eax,0x484e(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   417b6:	eb 0f                	jmp    417c7 <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   417b8:	8b 05 46 48 00 00    	mov    0x4846(%rip),%eax        # 46004 <showing.0>
   417be:	83 c0 01             	add    $0x1,%eax
   417c1:	89 05 3d 48 00 00    	mov    %eax,0x483d(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   417c7:	8b 05 37 48 00 00    	mov    0x4837(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   417cd:	83 f8 20             	cmp    $0x20,%eax
   417d0:	7f 6b                	jg     4183d <memshow_virtual_animate+0xcb>
   417d2:	8b 05 2c 48 00 00    	mov    0x482c(%rip),%eax        # 46004 <showing.0>
   417d8:	99                   	cltd   
   417d9:	c1 ea 1c             	shr    $0x1c,%edx
   417dc:	01 d0                	add    %edx,%eax
   417de:	83 e0 0f             	and    $0xf,%eax
   417e1:	29 d0                	sub    %edx,%eax
   417e3:	48 63 d0             	movslq %eax,%rdx
   417e6:	48 89 d0             	mov    %rdx,%rax
   417e9:	48 c1 e0 03          	shl    $0x3,%rax
   417ed:	48 29 d0             	sub    %rdx,%rax
   417f0:	48 c1 e0 05          	shl    $0x5,%rax
   417f4:	48 89 c2             	mov    %rax,%rdx
   417f7:	48 8d 05 ea 08 01 00 	lea    0x108ea(%rip),%rax        # 520e8 <processes+0xc8>
   417fe:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41801:	85 c0                	test   %eax,%eax
   41803:	74 b3                	je     417b8 <memshow_virtual_animate+0x46>
   41805:	8b 05 f9 47 00 00    	mov    0x47f9(%rip),%eax        # 46004 <showing.0>
   4180b:	99                   	cltd   
   4180c:	c1 ea 1c             	shr    $0x1c,%edx
   4180f:	01 d0                	add    %edx,%eax
   41811:	83 e0 0f             	and    $0xf,%eax
   41814:	29 d0                	sub    %edx,%eax
   41816:	48 63 d0             	movslq %eax,%rdx
   41819:	48 89 d0             	mov    %rdx,%rax
   4181c:	48 c1 e0 03          	shl    $0x3,%rax
   41820:	48 29 d0             	sub    %rdx,%rax
   41823:	48 c1 e0 05          	shl    $0x5,%rax
   41827:	48 89 c2             	mov    %rax,%rdx
   4182a:	48 8d 05 c7 08 01 00 	lea    0x108c7(%rip),%rax        # 520f8 <processes+0xd8>
   41831:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41835:	84 c0                	test   %al,%al
   41837:	0f 84 7b ff ff ff    	je     417b8 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   4183d:	8b 05 c1 47 00 00    	mov    0x47c1(%rip),%eax        # 46004 <showing.0>
   41843:	99                   	cltd   
   41844:	c1 ea 1c             	shr    $0x1c,%edx
   41847:	01 d0                	add    %edx,%eax
   41849:	83 e0 0f             	and    $0xf,%eax
   4184c:	29 d0                	sub    %edx,%eax
   4184e:	89 05 b0 47 00 00    	mov    %eax,0x47b0(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41854:	8b 05 aa 47 00 00    	mov    0x47aa(%rip),%eax        # 46004 <showing.0>
   4185a:	48 63 d0             	movslq %eax,%rdx
   4185d:	48 89 d0             	mov    %rdx,%rax
   41860:	48 c1 e0 03          	shl    $0x3,%rax
   41864:	48 29 d0             	sub    %rdx,%rax
   41867:	48 c1 e0 05          	shl    $0x5,%rax
   4186b:	48 89 c2             	mov    %rax,%rdx
   4186e:	48 8d 05 73 08 01 00 	lea    0x10873(%rip),%rax        # 520e8 <processes+0xc8>
   41875:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41878:	85 c0                	test   %eax,%eax
   4187a:	74 59                	je     418d5 <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   4187c:	8b 15 82 47 00 00    	mov    0x4782(%rip),%edx        # 46004 <showing.0>
   41882:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41886:	89 d1                	mov    %edx,%ecx
   41888:	48 8d 15 75 30 00 00 	lea    0x3075(%rip),%rdx        # 44904 <memstate_colors+0xa4>
   4188f:	be 04 00 00 00       	mov    $0x4,%esi
   41894:	48 89 c7             	mov    %rax,%rdi
   41897:	b8 00 00 00 00       	mov    $0x0,%eax
   4189c:	e8 77 2c 00 00       	call   44518 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   418a1:	8b 05 5d 47 00 00    	mov    0x475d(%rip),%eax        # 46004 <showing.0>
   418a7:	48 63 d0             	movslq %eax,%rdx
   418aa:	48 89 d0             	mov    %rdx,%rax
   418ad:	48 c1 e0 03          	shl    $0x3,%rax
   418b1:	48 29 d0             	sub    %rdx,%rax
   418b4:	48 c1 e0 05          	shl    $0x5,%rax
   418b8:	48 89 c2             	mov    %rax,%rdx
   418bb:	48 8d 05 2e 08 01 00 	lea    0x1082e(%rip),%rax        # 520f0 <processes+0xd0>
   418c2:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   418c6:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   418ca:	48 89 d6             	mov    %rdx,%rsi
   418cd:	48 89 c7             	mov    %rax,%rdi
   418d0:	e8 5d fc ff ff       	call   41532 <memshow_virtual>
    }
}
   418d5:	90                   	nop
   418d6:	c9                   	leave  
   418d7:	c3                   	ret    

00000000000418d8 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   418d8:	f3 0f 1e fa          	endbr64 
   418dc:	55                   	push   %rbp
   418dd:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   418e0:	e8 5f 01 00 00       	call   41a44 <segments_init>
    interrupt_init();
   418e5:	e8 44 04 00 00       	call   41d2e <interrupt_init>
    virtual_memory_init();
   418ea:	e8 11 11 00 00       	call   42a00 <virtual_memory_init>
}
   418ef:	90                   	nop
   418f0:	5d                   	pop    %rbp
   418f1:	c3                   	ret    

00000000000418f2 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   418f2:	f3 0f 1e fa          	endbr64 
   418f6:	55                   	push   %rbp
   418f7:	48 89 e5             	mov    %rsp,%rbp
   418fa:	48 83 ec 18          	sub    $0x18,%rsp
   418fe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41902:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41906:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41909:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4190c:	48 98                	cltq   
   4190e:	48 c1 e0 2d          	shl    $0x2d,%rax
   41912:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41916:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   4191d:	90 00 00 
   41920:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41923:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41927:	48 89 10             	mov    %rdx,(%rax)
}
   4192a:	90                   	nop
   4192b:	c9                   	leave  
   4192c:	c3                   	ret    

000000000004192d <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   4192d:	f3 0f 1e fa          	endbr64 
   41931:	55                   	push   %rbp
   41932:	48 89 e5             	mov    %rsp,%rbp
   41935:	48 83 ec 28          	sub    $0x28,%rsp
   41939:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4193d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41941:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41944:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41948:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   4194c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41950:	48 c1 e0 10          	shl    $0x10,%rax
   41954:	48 89 c2             	mov    %rax,%rdx
   41957:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   4195e:	00 00 00 
   41961:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41964:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41968:	48 c1 e0 20          	shl    $0x20,%rax
   4196c:	48 89 c1             	mov    %rax,%rcx
   4196f:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41976:	00 00 ff 
   41979:	48 21 c8             	and    %rcx,%rax
   4197c:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   4197f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41983:	48 83 e8 01          	sub    $0x1,%rax
   41987:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   4198a:	48 09 d0             	or     %rdx,%rax
        | type
   4198d:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41991:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41994:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41997:	48 98                	cltq   
   41999:	48 c1 e0 2d          	shl    $0x2d,%rax
   4199d:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   419a0:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   419a7:	80 00 00 
   419aa:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   419ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419b1:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   419b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419b8:	48 83 c0 08          	add    $0x8,%rax
   419bc:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   419c0:	48 c1 ea 20          	shr    $0x20,%rdx
   419c4:	48 89 10             	mov    %rdx,(%rax)
}
   419c7:	90                   	nop
   419c8:	c9                   	leave  
   419c9:	c3                   	ret    

00000000000419ca <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   419ca:	f3 0f 1e fa          	endbr64 
   419ce:	55                   	push   %rbp
   419cf:	48 89 e5             	mov    %rsp,%rbp
   419d2:	48 83 ec 20          	sub    $0x20,%rsp
   419d6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   419da:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   419de:	89 55 ec             	mov    %edx,-0x14(%rbp)
   419e1:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   419e5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419e9:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   419ec:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   419f0:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   419f3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   419f6:	48 98                	cltq   
   419f8:	48 c1 e0 2d          	shl    $0x2d,%rax
   419fc:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   419ff:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41a03:	48 c1 e0 20          	shl    $0x20,%rax
   41a07:	48 89 c1             	mov    %rax,%rcx
   41a0a:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41a11:	00 ff ff 
   41a14:	48 21 c8             	and    %rcx,%rax
   41a17:	48 09 c2             	or     %rax,%rdx
   41a1a:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41a21:	80 00 00 
   41a24:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41a27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a2b:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41a2e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41a32:	48 c1 e8 20          	shr    $0x20,%rax
   41a36:	48 89 c2             	mov    %rax,%rdx
   41a39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a3d:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41a41:	90                   	nop
   41a42:	c9                   	leave  
   41a43:	c3                   	ret    

0000000000041a44 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41a44:	f3 0f 1e fa          	endbr64 
   41a48:	55                   	push   %rbp
   41a49:	48 89 e5             	mov    %rsp,%rbp
   41a4c:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41a50:	48 c7 05 05 18 01 00 	movq   $0x0,0x11805(%rip)        # 53260 <segments>
   41a57:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41a5b:	ba 00 00 00 00       	mov    $0x0,%edx
   41a60:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41a67:	08 20 00 
   41a6a:	48 89 c6             	mov    %rax,%rsi
   41a6d:	48 8d 05 f4 17 01 00 	lea    0x117f4(%rip),%rax        # 53268 <segments+0x8>
   41a74:	48 89 c7             	mov    %rax,%rdi
   41a77:	e8 76 fe ff ff       	call   418f2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41a7c:	ba 03 00 00 00       	mov    $0x3,%edx
   41a81:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41a88:	08 20 00 
   41a8b:	48 89 c6             	mov    %rax,%rsi
   41a8e:	48 8d 05 db 17 01 00 	lea    0x117db(%rip),%rax        # 53270 <segments+0x10>
   41a95:	48 89 c7             	mov    %rax,%rdi
   41a98:	e8 55 fe ff ff       	call   418f2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41a9d:	ba 00 00 00 00       	mov    $0x0,%edx
   41aa2:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41aa9:	02 00 00 
   41aac:	48 89 c6             	mov    %rax,%rsi
   41aaf:	48 8d 05 c2 17 01 00 	lea    0x117c2(%rip),%rax        # 53278 <segments+0x18>
   41ab6:	48 89 c7             	mov    %rax,%rdi
   41ab9:	e8 34 fe ff ff       	call   418f2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41abe:	ba 03 00 00 00       	mov    $0x3,%edx
   41ac3:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41aca:	02 00 00 
   41acd:	48 89 c6             	mov    %rax,%rsi
   41ad0:	48 8d 05 a9 17 01 00 	lea    0x117a9(%rip),%rax        # 53280 <segments+0x20>
   41ad7:	48 89 c7             	mov    %rax,%rdi
   41ada:	e8 13 fe ff ff       	call   418f2 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41adf:	48 8d 05 ba 27 01 00 	lea    0x127ba(%rip),%rax        # 542a0 <kernel_task_descriptor>
   41ae6:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41aec:	48 89 c1             	mov    %rax,%rcx
   41aef:	ba 00 00 00 00       	mov    $0x0,%edx
   41af4:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41afb:	09 00 00 
   41afe:	48 89 c6             	mov    %rax,%rsi
   41b01:	48 8d 05 80 17 01 00 	lea    0x11780(%rip),%rax        # 53288 <segments+0x28>
   41b08:	48 89 c7             	mov    %rax,%rdi
   41b0b:	e8 1d fe ff ff       	call   4192d <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41b10:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41b16:	48 8d 05 43 17 01 00 	lea    0x11743(%rip),%rax        # 53260 <segments>
   41b1d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41b21:	ba 60 00 00 00       	mov    $0x60,%edx
   41b26:	be 00 00 00 00       	mov    $0x0,%esi
   41b2b:	48 8d 05 6e 27 01 00 	lea    0x1276e(%rip),%rax        # 542a0 <kernel_task_descriptor>
   41b32:	48 89 c7             	mov    %rax,%rdi
   41b35:	e8 84 1a 00 00       	call   435be <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41b3a:	48 c7 05 5f 27 01 00 	movq   $0x80000,0x1275f(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41b41:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41b45:	ba 00 10 00 00       	mov    $0x1000,%edx
   41b4a:	be 00 00 00 00       	mov    $0x0,%esi
   41b4f:	48 8d 05 4a 17 01 00 	lea    0x1174a(%rip),%rax        # 532a0 <interrupt_descriptors>
   41b56:	48 89 c7             	mov    %rax,%rdi
   41b59:	e8 60 1a 00 00       	call   435be <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41b5e:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41b65:	eb 3c                	jmp    41ba3 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41b67:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   41b6e:	48 89 c2             	mov    %rax,%rdx
   41b71:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41b74:	48 c1 e0 04          	shl    $0x4,%rax
   41b78:	48 89 c1             	mov    %rax,%rcx
   41b7b:	48 8d 05 1e 17 01 00 	lea    0x1171e(%rip),%rax        # 532a0 <interrupt_descriptors>
   41b82:	48 01 c8             	add    %rcx,%rax
   41b85:	48 89 d1             	mov    %rdx,%rcx
   41b88:	ba 00 00 00 00       	mov    $0x0,%edx
   41b8d:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41b94:	0e 00 00 
   41b97:	48 89 c7             	mov    %rax,%rdi
   41b9a:	e8 2b fe ff ff       	call   419ca <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41b9f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41ba3:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41baa:	76 bb                	jbe    41b67 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41bac:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   41bb3:	48 89 c1             	mov    %rax,%rcx
   41bb6:	ba 00 00 00 00       	mov    $0x0,%edx
   41bbb:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41bc2:	0e 00 00 
   41bc5:	48 89 c6             	mov    %rax,%rsi
   41bc8:	48 8d 05 d1 18 01 00 	lea    0x118d1(%rip),%rax        # 534a0 <interrupt_descriptors+0x200>
   41bcf:	48 89 c7             	mov    %rax,%rdi
   41bd2:	e8 f3 fd ff ff       	call   419ca <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41bd7:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   41bde:	48 89 c1             	mov    %rax,%rcx
   41be1:	ba 00 00 00 00       	mov    $0x0,%edx
   41be6:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41bed:	0e 00 00 
   41bf0:	48 89 c6             	mov    %rax,%rsi
   41bf3:	48 8d 05 76 17 01 00 	lea    0x11776(%rip),%rax        # 53370 <interrupt_descriptors+0xd0>
   41bfa:	48 89 c7             	mov    %rax,%rdi
   41bfd:	e8 c8 fd ff ff       	call   419ca <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41c02:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   41c09:	48 89 c1             	mov    %rax,%rcx
   41c0c:	ba 00 00 00 00       	mov    $0x0,%edx
   41c11:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41c18:	0e 00 00 
   41c1b:	48 89 c6             	mov    %rax,%rsi
   41c1e:	48 8d 05 5b 17 01 00 	lea    0x1175b(%rip),%rax        # 53380 <interrupt_descriptors+0xe0>
   41c25:	48 89 c7             	mov    %rax,%rdi
   41c28:	e8 9d fd ff ff       	call   419ca <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41c2d:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41c34:	eb 50                	jmp    41c86 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41c36:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c39:	83 e8 30             	sub    $0x30,%eax
   41c3c:	89 c0                	mov    %eax,%eax
   41c3e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   41c45:	00 
   41c46:	48 8d 05 9a e4 ff ff 	lea    -0x1b66(%rip),%rax        # 400e7 <sys_int_handlers>
   41c4d:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41c51:	48 89 c2             	mov    %rax,%rdx
   41c54:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c57:	48 c1 e0 04          	shl    $0x4,%rax
   41c5b:	48 89 c1             	mov    %rax,%rcx
   41c5e:	48 8d 05 3b 16 01 00 	lea    0x1163b(%rip),%rax        # 532a0 <interrupt_descriptors>
   41c65:	48 01 c8             	add    %rcx,%rax
   41c68:	48 89 d1             	mov    %rdx,%rcx
   41c6b:	ba 03 00 00 00       	mov    $0x3,%edx
   41c70:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41c77:	0e 00 00 
   41c7a:	48 89 c7             	mov    %rax,%rdi
   41c7d:	e8 48 fd ff ff       	call   419ca <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41c82:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41c86:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41c8a:	76 aa                	jbe    41c36 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41c8c:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41c92:	48 8d 05 07 16 01 00 	lea    0x11607(%rip),%rax        # 532a0 <interrupt_descriptors>
   41c99:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41c9d:	b8 28 00 00 00       	mov    $0x28,%eax
   41ca2:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41ca6:	0f 00 d8             	ltr    %ax
   41ca9:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41cad:	0f 20 c0             	mov    %cr0,%rax
   41cb0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41cb4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41cb8:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41cbb:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41cc2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41cc5:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41cc8:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ccb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41ccf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41cd3:	0f 22 c0             	mov    %rax,%cr0
}
   41cd6:	90                   	nop
    lcr0(cr0);
}
   41cd7:	90                   	nop
   41cd8:	c9                   	leave  
   41cd9:	c3                   	ret    

0000000000041cda <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41cda:	f3 0f 1e fa          	endbr64 
   41cde:	55                   	push   %rbp
   41cdf:	48 89 e5             	mov    %rsp,%rbp
   41ce2:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41ce6:	0f b7 05 13 26 01 00 	movzwl 0x12613(%rip),%eax        # 54300 <interrupts_enabled>
   41ced:	f7 d0                	not    %eax
   41cef:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41cf3:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41cf7:	0f b6 c0             	movzbl %al,%eax
   41cfa:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41d01:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d04:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41d08:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41d0b:	ee                   	out    %al,(%dx)
}
   41d0c:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41d0d:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41d11:	66 c1 e8 08          	shr    $0x8,%ax
   41d15:	0f b6 c0             	movzbl %al,%eax
   41d18:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41d1f:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d22:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41d26:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41d29:	ee                   	out    %al,(%dx)
}
   41d2a:	90                   	nop
}
   41d2b:	90                   	nop
   41d2c:	c9                   	leave  
   41d2d:	c3                   	ret    

0000000000041d2e <interrupt_init>:

void interrupt_init(void) {
   41d2e:	f3 0f 1e fa          	endbr64 
   41d32:	55                   	push   %rbp
   41d33:	48 89 e5             	mov    %rsp,%rbp
   41d36:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41d3a:	66 c7 05 bd 25 01 00 	movw   $0x0,0x125bd(%rip)        # 54300 <interrupts_enabled>
   41d41:	00 00 
    interrupt_mask();
   41d43:	e8 92 ff ff ff       	call   41cda <interrupt_mask>
   41d48:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41d4f:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d53:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41d57:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41d5a:	ee                   	out    %al,(%dx)
}
   41d5b:	90                   	nop
   41d5c:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41d63:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d67:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41d6b:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41d6e:	ee                   	out    %al,(%dx)
}
   41d6f:	90                   	nop
   41d70:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41d77:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d7b:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41d7f:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41d82:	ee                   	out    %al,(%dx)
}
   41d83:	90                   	nop
   41d84:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41d8b:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d8f:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41d93:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41d96:	ee                   	out    %al,(%dx)
}
   41d97:	90                   	nop
   41d98:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41d9f:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41da3:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41da7:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41daa:	ee                   	out    %al,(%dx)
}
   41dab:	90                   	nop
   41dac:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41db3:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41db7:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41dbb:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41dbe:	ee                   	out    %al,(%dx)
}
   41dbf:	90                   	nop
   41dc0:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41dc7:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dcb:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41dcf:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41dd2:	ee                   	out    %al,(%dx)
}
   41dd3:	90                   	nop
   41dd4:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41ddb:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ddf:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41de3:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41de6:	ee                   	out    %al,(%dx)
}
   41de7:	90                   	nop
   41de8:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41def:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41df3:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41df7:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41dfa:	ee                   	out    %al,(%dx)
}
   41dfb:	90                   	nop
   41dfc:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41e03:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e07:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41e0b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e0e:	ee                   	out    %al,(%dx)
}
   41e0f:	90                   	nop
   41e10:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41e17:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e1b:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41e1f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e22:	ee                   	out    %al,(%dx)
}
   41e23:	90                   	nop
   41e24:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41e2b:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e2f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e33:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e36:	ee                   	out    %al,(%dx)
}
   41e37:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41e38:	e8 9d fe ff ff       	call   41cda <interrupt_mask>
}
   41e3d:	90                   	nop
   41e3e:	c9                   	leave  
   41e3f:	c3                   	ret    

0000000000041e40 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41e40:	f3 0f 1e fa          	endbr64 
   41e44:	55                   	push   %rbp
   41e45:	48 89 e5             	mov    %rsp,%rbp
   41e48:	48 83 ec 28          	sub    $0x28,%rsp
   41e4c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41e4f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41e53:	0f 8e 9f 00 00 00    	jle    41ef8 <timer_init+0xb8>
   41e59:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41e60:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e64:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41e68:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e6b:	ee                   	out    %al,(%dx)
}
   41e6c:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41e6d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e70:	89 c2                	mov    %eax,%edx
   41e72:	c1 ea 1f             	shr    $0x1f,%edx
   41e75:	01 d0                	add    %edx,%eax
   41e77:	d1 f8                	sar    %eax
   41e79:	05 de 34 12 00       	add    $0x1234de,%eax
   41e7e:	99                   	cltd   
   41e7f:	f7 7d dc             	idivl  -0x24(%rbp)
   41e82:	89 c2                	mov    %eax,%edx
   41e84:	89 d0                	mov    %edx,%eax
   41e86:	c1 f8 1f             	sar    $0x1f,%eax
   41e89:	c1 e8 18             	shr    $0x18,%eax
   41e8c:	89 c1                	mov    %eax,%ecx
   41e8e:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41e91:	0f b6 c0             	movzbl %al,%eax
   41e94:	29 c8                	sub    %ecx,%eax
   41e96:	0f b6 c0             	movzbl %al,%eax
   41e99:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41ea0:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ea3:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ea7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41eaa:	ee                   	out    %al,(%dx)
}
   41eab:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41eac:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41eaf:	89 c2                	mov    %eax,%edx
   41eb1:	c1 ea 1f             	shr    $0x1f,%edx
   41eb4:	01 d0                	add    %edx,%eax
   41eb6:	d1 f8                	sar    %eax
   41eb8:	05 de 34 12 00       	add    $0x1234de,%eax
   41ebd:	99                   	cltd   
   41ebe:	f7 7d dc             	idivl  -0x24(%rbp)
   41ec1:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41ec7:	85 c0                	test   %eax,%eax
   41ec9:	0f 48 c2             	cmovs  %edx,%eax
   41ecc:	c1 f8 08             	sar    $0x8,%eax
   41ecf:	0f b6 c0             	movzbl %al,%eax
   41ed2:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41ed9:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41edc:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ee0:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ee3:	ee                   	out    %al,(%dx)
}
   41ee4:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41ee5:	0f b7 05 14 24 01 00 	movzwl 0x12414(%rip),%eax        # 54300 <interrupts_enabled>
   41eec:	83 c8 01             	or     $0x1,%eax
   41eef:	66 89 05 0a 24 01 00 	mov    %ax,0x1240a(%rip)        # 54300 <interrupts_enabled>
   41ef6:	eb 11                	jmp    41f09 <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41ef8:	0f b7 05 01 24 01 00 	movzwl 0x12401(%rip),%eax        # 54300 <interrupts_enabled>
   41eff:	83 e0 fe             	and    $0xfffffffe,%eax
   41f02:	66 89 05 f7 23 01 00 	mov    %ax,0x123f7(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   41f09:	e8 cc fd ff ff       	call   41cda <interrupt_mask>
}
   41f0e:	90                   	nop
   41f0f:	c9                   	leave  
   41f10:	c3                   	ret    

0000000000041f11 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41f11:	f3 0f 1e fa          	endbr64 
   41f15:	55                   	push   %rbp
   41f16:	48 89 e5             	mov    %rsp,%rbp
   41f19:	48 83 ec 08          	sub    $0x8,%rsp
   41f1d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41f21:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41f26:	74 14                	je     41f3c <physical_memory_isreserved+0x2b>
   41f28:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41f2f:	00 
   41f30:	76 11                	jbe    41f43 <physical_memory_isreserved+0x32>
   41f32:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41f39:	00 
   41f3a:	77 07                	ja     41f43 <physical_memory_isreserved+0x32>
   41f3c:	b8 01 00 00 00       	mov    $0x1,%eax
   41f41:	eb 05                	jmp    41f48 <physical_memory_isreserved+0x37>
   41f43:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41f48:	c9                   	leave  
   41f49:	c3                   	ret    

0000000000041f4a <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41f4a:	f3 0f 1e fa          	endbr64 
   41f4e:	55                   	push   %rbp
   41f4f:	48 89 e5             	mov    %rsp,%rbp
   41f52:	48 83 ec 10          	sub    $0x10,%rsp
   41f56:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41f59:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41f5c:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41f5f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f62:	c1 e0 10             	shl    $0x10,%eax
   41f65:	89 c2                	mov    %eax,%edx
   41f67:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f6a:	c1 e0 0b             	shl    $0xb,%eax
   41f6d:	09 c2                	or     %eax,%edx
   41f6f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f72:	c1 e0 08             	shl    $0x8,%eax
   41f75:	09 d0                	or     %edx,%eax
}
   41f77:	c9                   	leave  
   41f78:	c3                   	ret    

0000000000041f79 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41f79:	f3 0f 1e fa          	endbr64 
   41f7d:	55                   	push   %rbp
   41f7e:	48 89 e5             	mov    %rsp,%rbp
   41f81:	48 83 ec 18          	sub    $0x18,%rsp
   41f85:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41f88:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41f8b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f8e:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f91:	09 d0                	or     %edx,%eax
   41f93:	0d 00 00 00 80       	or     $0x80000000,%eax
   41f98:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41f9f:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41fa2:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fa5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41fa8:	ef                   	out    %eax,(%dx)
}
   41fa9:	90                   	nop
   41faa:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41fb1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41fb4:	89 c2                	mov    %eax,%edx
   41fb6:	ed                   	in     (%dx),%eax
   41fb7:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41fba:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41fbd:	c9                   	leave  
   41fbe:	c3                   	ret    

0000000000041fbf <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41fbf:	f3 0f 1e fa          	endbr64 
   41fc3:	55                   	push   %rbp
   41fc4:	48 89 e5             	mov    %rsp,%rbp
   41fc7:	48 83 ec 28          	sub    $0x28,%rsp
   41fcb:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41fce:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41fd1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41fd8:	eb 73                	jmp    4204d <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   41fda:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41fe1:	eb 60                	jmp    42043 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   41fe3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41fea:	eb 4a                	jmp    42036 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41fec:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41fef:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41ff2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ff5:	89 ce                	mov    %ecx,%esi
   41ff7:	89 c7                	mov    %eax,%edi
   41ff9:	e8 4c ff ff ff       	call   41f4a <pci_make_configaddr>
   41ffe:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   42001:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42004:	be 00 00 00 00       	mov    $0x0,%esi
   42009:	89 c7                	mov    %eax,%edi
   4200b:	e8 69 ff ff ff       	call   41f79 <pci_config_readl>
   42010:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   42013:	8b 45 d8             	mov    -0x28(%rbp),%eax
   42016:	c1 e0 10             	shl    $0x10,%eax
   42019:	0b 45 dc             	or     -0x24(%rbp),%eax
   4201c:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   4201f:	75 05                	jne    42026 <pci_find_device+0x67>
                    return configaddr;
   42021:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42024:	eb 35                	jmp    4205b <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   42026:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   4202a:	75 06                	jne    42032 <pci_find_device+0x73>
   4202c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42030:	74 0c                	je     4203e <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   42032:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42036:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   4203a:	75 b0                	jne    41fec <pci_find_device+0x2d>
   4203c:	eb 01                	jmp    4203f <pci_find_device+0x80>
                    break;
   4203e:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   4203f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42043:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   42047:	75 9a                	jne    41fe3 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   42049:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4204d:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42054:	75 84                	jne    41fda <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   42056:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   4205b:	c9                   	leave  
   4205c:	c3                   	ret    

000000000004205d <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   4205d:	f3 0f 1e fa          	endbr64 
   42061:	55                   	push   %rbp
   42062:	48 89 e5             	mov    %rsp,%rbp
   42065:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42069:	be 13 71 00 00       	mov    $0x7113,%esi
   4206e:	bf 86 80 00 00       	mov    $0x8086,%edi
   42073:	e8 47 ff ff ff       	call   41fbf <pci_find_device>
   42078:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   4207b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4207f:	78 30                	js     420b1 <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   42081:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42084:	be 40 00 00 00       	mov    $0x40,%esi
   42089:	89 c7                	mov    %eax,%edi
   4208b:	e8 e9 fe ff ff       	call   41f79 <pci_config_readl>
   42090:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42095:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42098:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4209b:	83 c0 04             	add    $0x4,%eax
   4209e:	89 45 f4             	mov    %eax,-0xc(%rbp)
   420a1:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   420a7:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   420ab:	8b 55 f4             	mov    -0xc(%rbp),%edx
   420ae:	66 ef                	out    %ax,(%dx)
}
   420b0:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   420b1:	48 8d 05 68 28 00 00 	lea    0x2868(%rip),%rax        # 44920 <memstate_colors+0xc0>
   420b8:	48 89 c2             	mov    %rax,%rdx
   420bb:	be 00 c0 00 00       	mov    $0xc000,%esi
   420c0:	bf 80 07 00 00       	mov    $0x780,%edi
   420c5:	b8 00 00 00 00       	mov    $0x0,%eax
   420ca:	e8 2e 23 00 00       	call   443fd <console_printf>
 spinloop: goto spinloop;
   420cf:	eb fe                	jmp    420cf <poweroff+0x72>

00000000000420d1 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   420d1:	f3 0f 1e fa          	endbr64 
   420d5:	55                   	push   %rbp
   420d6:	48 89 e5             	mov    %rsp,%rbp
   420d9:	48 83 ec 10          	sub    $0x10,%rsp
   420dd:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   420e4:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420e8:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420ec:	8b 55 fc             	mov    -0x4(%rbp),%edx
   420ef:	ee                   	out    %al,(%dx)
}
   420f0:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   420f1:	eb fe                	jmp    420f1 <reboot+0x20>

00000000000420f3 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   420f3:	f3 0f 1e fa          	endbr64 
   420f7:	55                   	push   %rbp
   420f8:	48 89 e5             	mov    %rsp,%rbp
   420fb:	48 83 ec 10          	sub    $0x10,%rsp
   420ff:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42103:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   42106:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4210a:	48 83 c0 08          	add    $0x8,%rax
   4210e:	ba c0 00 00 00       	mov    $0xc0,%edx
   42113:	be 00 00 00 00       	mov    $0x0,%esi
   42118:	48 89 c7             	mov    %rax,%rdi
   4211b:	e8 9e 14 00 00       	call   435be <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   42120:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42124:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   4212b:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   4212d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42131:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   42138:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   4213c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42140:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   42147:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   4214b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4214f:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   42156:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   42158:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4215c:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   42163:	00 02 00 00 
    p->display_status = 1;
   42167:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4216b:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42172:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42175:	83 e0 01             	and    $0x1,%eax
   42178:	85 c0                	test   %eax,%eax
   4217a:	74 1c                	je     42198 <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4217c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42180:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42187:	80 cc 30             	or     $0x30,%ah
   4218a:	48 89 c2             	mov    %rax,%rdx
   4218d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42191:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42198:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4219b:	83 e0 02             	and    $0x2,%eax
   4219e:	85 c0                	test   %eax,%eax
   421a0:	74 1c                	je     421be <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   421a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   421a6:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   421ad:	80 e4 fd             	and    $0xfd,%ah
   421b0:	48 89 c2             	mov    %rax,%rdx
   421b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   421b7:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   421be:	90                   	nop
   421bf:	c9                   	leave  
   421c0:	c3                   	ret    

00000000000421c1 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   421c1:	f3 0f 1e fa          	endbr64 
   421c5:	55                   	push   %rbp
   421c6:	48 89 e5             	mov    %rsp,%rbp
   421c9:	48 83 ec 28          	sub    $0x28,%rsp
   421cd:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   421d0:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   421d4:	78 09                	js     421df <console_show_cursor+0x1e>
   421d6:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   421dd:	7e 07                	jle    421e6 <console_show_cursor+0x25>
        cpos = 0;
   421df:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   421e6:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   421ed:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421f1:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   421f5:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   421f8:	ee                   	out    %al,(%dx)
}
   421f9:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   421fa:	8b 45 dc             	mov    -0x24(%rbp),%eax
   421fd:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42203:	85 c0                	test   %eax,%eax
   42205:	0f 48 c2             	cmovs  %edx,%eax
   42208:	c1 f8 08             	sar    $0x8,%eax
   4220b:	0f b6 c0             	movzbl %al,%eax
   4220e:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42215:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42218:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4221c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4221f:	ee                   	out    %al,(%dx)
}
   42220:	90                   	nop
   42221:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42228:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4222c:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42230:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42233:	ee                   	out    %al,(%dx)
}
   42234:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42235:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42238:	99                   	cltd   
   42239:	c1 ea 18             	shr    $0x18,%edx
   4223c:	01 d0                	add    %edx,%eax
   4223e:	0f b6 c0             	movzbl %al,%eax
   42241:	29 d0                	sub    %edx,%eax
   42243:	0f b6 c0             	movzbl %al,%eax
   42246:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   4224d:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42250:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42254:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42257:	ee                   	out    %al,(%dx)
}
   42258:	90                   	nop
}
   42259:	90                   	nop
   4225a:	c9                   	leave  
   4225b:	c3                   	ret    

000000000004225c <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   4225c:	f3 0f 1e fa          	endbr64 
   42260:	55                   	push   %rbp
   42261:	48 89 e5             	mov    %rsp,%rbp
   42264:	48 83 ec 20          	sub    $0x20,%rsp
   42268:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4226f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42272:	89 c2                	mov    %eax,%edx
   42274:	ec                   	in     (%dx),%al
   42275:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42278:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   4227c:	0f b6 c0             	movzbl %al,%eax
   4227f:	83 e0 01             	and    $0x1,%eax
   42282:	85 c0                	test   %eax,%eax
   42284:	75 0a                	jne    42290 <keyboard_readc+0x34>
        return -1;
   42286:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4228b:	e9 fd 01 00 00       	jmp    4248d <keyboard_readc+0x231>
   42290:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42297:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4229a:	89 c2                	mov    %eax,%edx
   4229c:	ec                   	in     (%dx),%al
   4229d:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   422a0:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   422a4:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   422a7:	0f b6 05 54 20 01 00 	movzbl 0x12054(%rip),%eax        # 54302 <last_escape.2>
   422ae:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   422b1:	c6 05 4a 20 01 00 00 	movb   $0x0,0x1204a(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   422b8:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   422bc:	75 11                	jne    422cf <keyboard_readc+0x73>
        last_escape = 0x80;
   422be:	c6 05 3d 20 01 00 80 	movb   $0x80,0x1203d(%rip)        # 54302 <last_escape.2>
        return 0;
   422c5:	b8 00 00 00 00       	mov    $0x0,%eax
   422ca:	e9 be 01 00 00       	jmp    4248d <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   422cf:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   422d3:	84 c0                	test   %al,%al
   422d5:	79 64                	jns    4233b <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   422d7:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   422db:	83 e0 7f             	and    $0x7f,%eax
   422de:	89 c2                	mov    %eax,%edx
   422e0:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   422e4:	09 d0                	or     %edx,%eax
   422e6:	48 98                	cltq   
   422e8:	48 8d 15 51 26 00 00 	lea    0x2651(%rip),%rdx        # 44940 <keymap>
   422ef:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   422f3:	0f b6 c0             	movzbl %al,%eax
   422f6:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   422f9:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42300:	7e 2f                	jle    42331 <keyboard_readc+0xd5>
   42302:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42309:	7f 26                	jg     42331 <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   4230b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4230e:	2d fa 00 00 00       	sub    $0xfa,%eax
   42313:	ba 01 00 00 00       	mov    $0x1,%edx
   42318:	89 c1                	mov    %eax,%ecx
   4231a:	d3 e2                	shl    %cl,%edx
   4231c:	89 d0                	mov    %edx,%eax
   4231e:	f7 d0                	not    %eax
   42320:	89 c2                	mov    %eax,%edx
   42322:	0f b6 05 da 1f 01 00 	movzbl 0x11fda(%rip),%eax        # 54303 <modifiers.1>
   42329:	21 d0                	and    %edx,%eax
   4232b:	88 05 d2 1f 01 00    	mov    %al,0x11fd2(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   42331:	b8 00 00 00 00       	mov    $0x0,%eax
   42336:	e9 52 01 00 00       	jmp    4248d <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   4233b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4233f:	0a 45 fa             	or     -0x6(%rbp),%al
   42342:	0f b6 c0             	movzbl %al,%eax
   42345:	48 98                	cltq   
   42347:	48 8d 15 f2 25 00 00 	lea    0x25f2(%rip),%rdx        # 44940 <keymap>
   4234e:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42352:	0f b6 c0             	movzbl %al,%eax
   42355:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42358:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4235c:	7e 57                	jle    423b5 <keyboard_readc+0x159>
   4235e:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42362:	7f 51                	jg     423b5 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   42364:	0f b6 05 98 1f 01 00 	movzbl 0x11f98(%rip),%eax        # 54303 <modifiers.1>
   4236b:	0f b6 c0             	movzbl %al,%eax
   4236e:	83 e0 02             	and    $0x2,%eax
   42371:	85 c0                	test   %eax,%eax
   42373:	74 09                	je     4237e <keyboard_readc+0x122>
            ch -= 0x60;
   42375:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42379:	e9 0b 01 00 00       	jmp    42489 <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4237e:	0f b6 05 7e 1f 01 00 	movzbl 0x11f7e(%rip),%eax        # 54303 <modifiers.1>
   42385:	0f b6 c0             	movzbl %al,%eax
   42388:	83 e0 01             	and    $0x1,%eax
   4238b:	85 c0                	test   %eax,%eax
   4238d:	0f 94 c2             	sete   %dl
   42390:	0f b6 05 6c 1f 01 00 	movzbl 0x11f6c(%rip),%eax        # 54303 <modifiers.1>
   42397:	0f b6 c0             	movzbl %al,%eax
   4239a:	83 e0 08             	and    $0x8,%eax
   4239d:	85 c0                	test   %eax,%eax
   4239f:	0f 94 c0             	sete   %al
   423a2:	31 d0                	xor    %edx,%eax
   423a4:	84 c0                	test   %al,%al
   423a6:	0f 84 dd 00 00 00    	je     42489 <keyboard_readc+0x22d>
            ch -= 0x20;
   423ac:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   423b0:	e9 d4 00 00 00       	jmp    42489 <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   423b5:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   423bc:	7e 30                	jle    423ee <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   423be:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423c1:	2d fa 00 00 00       	sub    $0xfa,%eax
   423c6:	ba 01 00 00 00       	mov    $0x1,%edx
   423cb:	89 c1                	mov    %eax,%ecx
   423cd:	d3 e2                	shl    %cl,%edx
   423cf:	89 d0                	mov    %edx,%eax
   423d1:	89 c2                	mov    %eax,%edx
   423d3:	0f b6 05 29 1f 01 00 	movzbl 0x11f29(%rip),%eax        # 54303 <modifiers.1>
   423da:	31 d0                	xor    %edx,%eax
   423dc:	88 05 21 1f 01 00    	mov    %al,0x11f21(%rip)        # 54303 <modifiers.1>
        ch = 0;
   423e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   423e9:	e9 9c 00 00 00       	jmp    4248a <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   423ee:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   423f5:	7e 2d                	jle    42424 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   423f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423fa:	2d fa 00 00 00       	sub    $0xfa,%eax
   423ff:	ba 01 00 00 00       	mov    $0x1,%edx
   42404:	89 c1                	mov    %eax,%ecx
   42406:	d3 e2                	shl    %cl,%edx
   42408:	89 d0                	mov    %edx,%eax
   4240a:	89 c2                	mov    %eax,%edx
   4240c:	0f b6 05 f0 1e 01 00 	movzbl 0x11ef0(%rip),%eax        # 54303 <modifiers.1>
   42413:	09 d0                	or     %edx,%eax
   42415:	88 05 e8 1e 01 00    	mov    %al,0x11ee8(%rip)        # 54303 <modifiers.1>
        ch = 0;
   4241b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42422:	eb 66                	jmp    4248a <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42424:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42428:	7e 3f                	jle    42469 <keyboard_readc+0x20d>
   4242a:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42431:	7f 36                	jg     42469 <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42433:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42436:	8d 50 80             	lea    -0x80(%rax),%edx
   42439:	0f b6 05 c3 1e 01 00 	movzbl 0x11ec3(%rip),%eax        # 54303 <modifiers.1>
   42440:	0f b6 c0             	movzbl %al,%eax
   42443:	83 e0 03             	and    $0x3,%eax
   42446:	48 63 c8             	movslq %eax,%rcx
   42449:	48 63 c2             	movslq %edx,%rax
   4244c:	48 c1 e0 02          	shl    $0x2,%rax
   42450:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   42454:	48 8d 05 e5 25 00 00 	lea    0x25e5(%rip),%rax        # 44a40 <complex_keymap>
   4245b:	48 01 d0             	add    %rdx,%rax
   4245e:	0f b6 00             	movzbl (%rax),%eax
   42461:	0f b6 c0             	movzbl %al,%eax
   42464:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42467:	eb 21                	jmp    4248a <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42469:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4246d:	7f 1b                	jg     4248a <keyboard_readc+0x22e>
   4246f:	0f b6 05 8d 1e 01 00 	movzbl 0x11e8d(%rip),%eax        # 54303 <modifiers.1>
   42476:	0f b6 c0             	movzbl %al,%eax
   42479:	83 e0 02             	and    $0x2,%eax
   4247c:	85 c0                	test   %eax,%eax
   4247e:	74 0a                	je     4248a <keyboard_readc+0x22e>
        ch = 0;
   42480:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42487:	eb 01                	jmp    4248a <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   42489:	90                   	nop
    }

    return ch;
   4248a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4248d:	c9                   	leave  
   4248e:	c3                   	ret    

000000000004248f <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   4248f:	f3 0f 1e fa          	endbr64 
   42493:	55                   	push   %rbp
   42494:	48 89 e5             	mov    %rsp,%rbp
   42497:	48 83 ec 20          	sub    $0x20,%rsp
   4249b:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   424a2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   424a5:	89 c2                	mov    %eax,%edx
   424a7:	ec                   	in     (%dx),%al
   424a8:	88 45 e3             	mov    %al,-0x1d(%rbp)
   424ab:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   424b2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   424b5:	89 c2                	mov    %eax,%edx
   424b7:	ec                   	in     (%dx),%al
   424b8:	88 45 eb             	mov    %al,-0x15(%rbp)
   424bb:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   424c2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   424c5:	89 c2                	mov    %eax,%edx
   424c7:	ec                   	in     (%dx),%al
   424c8:	88 45 f3             	mov    %al,-0xd(%rbp)
   424cb:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   424d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   424d5:	89 c2                	mov    %eax,%edx
   424d7:	ec                   	in     (%dx),%al
   424d8:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   424db:	90                   	nop
   424dc:	c9                   	leave  
   424dd:	c3                   	ret    

00000000000424de <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   424de:	f3 0f 1e fa          	endbr64 
   424e2:	55                   	push   %rbp
   424e3:	48 89 e5             	mov    %rsp,%rbp
   424e6:	48 83 ec 40          	sub    $0x40,%rsp
   424ea:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   424ee:	89 f0                	mov    %esi,%eax
   424f0:	89 55 c0             	mov    %edx,-0x40(%rbp)
   424f3:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   424f6:	8b 05 08 1e 01 00    	mov    0x11e08(%rip),%eax        # 54304 <initialized.0>
   424fc:	85 c0                	test   %eax,%eax
   424fe:	75 1e                	jne    4251e <parallel_port_putc+0x40>
   42500:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42507:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4250b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4250f:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42512:	ee                   	out    %al,(%dx)
}
   42513:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42514:	c7 05 e6 1d 01 00 01 	movl   $0x1,0x11de6(%rip)        # 54304 <initialized.0>
   4251b:	00 00 00 
    }

    for (int i = 0;
   4251e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42525:	eb 09                	jmp    42530 <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42527:	e8 63 ff ff ff       	call   4248f <delay>
         ++i) {
   4252c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42530:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42537:	7f 18                	jg     42551 <parallel_port_putc+0x73>
   42539:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42540:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42543:	89 c2                	mov    %eax,%edx
   42545:	ec                   	in     (%dx),%al
   42546:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42549:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4254d:	84 c0                	test   %al,%al
   4254f:	79 d6                	jns    42527 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   42551:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42555:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4255c:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4255f:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42563:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42566:	ee                   	out    %al,(%dx)
}
   42567:	90                   	nop
   42568:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   4256f:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42573:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42577:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4257a:	ee                   	out    %al,(%dx)
}
   4257b:	90                   	nop
   4257c:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42583:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42587:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4258b:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4258e:	ee                   	out    %al,(%dx)
}
   4258f:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42590:	90                   	nop
   42591:	c9                   	leave  
   42592:	c3                   	ret    

0000000000042593 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42593:	f3 0f 1e fa          	endbr64 
   42597:	55                   	push   %rbp
   42598:	48 89 e5             	mov    %rsp,%rbp
   4259b:	48 83 ec 20          	sub    $0x20,%rsp
   4259f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   425a3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   425a7:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 424de <parallel_port_putc>
   425ae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   425b2:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   425b6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   425ba:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   425be:	be 00 00 00 00       	mov    $0x0,%esi
   425c3:	48 89 c7             	mov    %rax,%rdi
   425c6:	e8 b9 12 00 00       	call   43884 <printer_vprintf>
}
   425cb:	90                   	nop
   425cc:	c9                   	leave  
   425cd:	c3                   	ret    

00000000000425ce <log_printf>:

void log_printf(const char* format, ...) {
   425ce:	f3 0f 1e fa          	endbr64 
   425d2:	55                   	push   %rbp
   425d3:	48 89 e5             	mov    %rsp,%rbp
   425d6:	48 83 ec 60          	sub    $0x60,%rsp
   425da:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   425de:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   425e2:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   425e6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   425ea:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   425ee:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   425f2:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   425f9:	48 8d 45 10          	lea    0x10(%rbp),%rax
   425fd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42601:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42605:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42609:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4260d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42611:	48 89 d6             	mov    %rdx,%rsi
   42614:	48 89 c7             	mov    %rax,%rdi
   42617:	e8 77 ff ff ff       	call   42593 <log_vprintf>
    va_end(val);
}
   4261c:	90                   	nop
   4261d:	c9                   	leave  
   4261e:	c3                   	ret    

000000000004261f <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   4261f:	f3 0f 1e fa          	endbr64 
   42623:	55                   	push   %rbp
   42624:	48 89 e5             	mov    %rsp,%rbp
   42627:	48 83 ec 40          	sub    $0x40,%rsp
   4262b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4262e:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42631:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42635:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42639:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4263d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42641:	48 8b 0a             	mov    (%rdx),%rcx
   42644:	48 89 08             	mov    %rcx,(%rax)
   42647:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4264b:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4264f:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42653:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42657:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4265b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4265f:	48 89 d6             	mov    %rdx,%rsi
   42662:	48 89 c7             	mov    %rax,%rdi
   42665:	e8 29 ff ff ff       	call   42593 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4266a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4266e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42672:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42675:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42678:	89 c7                	mov    %eax,%edi
   4267a:	e8 02 1d 00 00       	call   44381 <console_vprintf>
}
   4267f:	c9                   	leave  
   42680:	c3                   	ret    

0000000000042681 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42681:	f3 0f 1e fa          	endbr64 
   42685:	55                   	push   %rbp
   42686:	48 89 e5             	mov    %rsp,%rbp
   42689:	48 83 ec 60          	sub    $0x60,%rsp
   4268d:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42690:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42693:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42697:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4269b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4269f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   426a3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   426aa:	48 8d 45 10          	lea    0x10(%rbp),%rax
   426ae:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   426b2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   426b6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   426ba:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   426be:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   426c2:	8b 75 a8             	mov    -0x58(%rbp),%esi
   426c5:	8b 45 ac             	mov    -0x54(%rbp),%eax
   426c8:	89 c7                	mov    %eax,%edi
   426ca:	e8 50 ff ff ff       	call   4261f <error_vprintf>
   426cf:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   426d2:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   426d5:	c9                   	leave  
   426d6:	c3                   	ret    

00000000000426d7 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   426d7:	f3 0f 1e fa          	endbr64 
   426db:	55                   	push   %rbp
   426dc:	48 89 e5             	mov    %rsp,%rbp
   426df:	53                   	push   %rbx
   426e0:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   426e4:	e8 73 fb ff ff       	call   4225c <keyboard_readc>
   426e9:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   426ec:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   426f0:	74 1c                	je     4270e <check_keyboard+0x37>
   426f2:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   426f6:	74 16                	je     4270e <check_keyboard+0x37>
   426f8:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   426fc:	74 10                	je     4270e <check_keyboard+0x37>
   426fe:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42702:	74 0a                	je     4270e <check_keyboard+0x37>
   42704:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42708:	0f 85 02 01 00 00    	jne    42810 <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   4270e:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42715:	00 
        memset(pt, 0, PAGESIZE * 3);
   42716:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4271a:	ba 00 30 00 00       	mov    $0x3000,%edx
   4271f:	be 00 00 00 00       	mov    $0x0,%esi
   42724:	48 89 c7             	mov    %rax,%rdi
   42727:	e8 92 0e 00 00       	call   435be <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   4272c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42730:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42737:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4273b:	48 05 00 10 00 00    	add    $0x1000,%rax
   42741:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42748:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4274c:	48 05 00 20 00 00    	add    $0x2000,%rax
   42752:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42759:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4275d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42761:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42765:	0f 22 d8             	mov    %rax,%cr3
}
   42768:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42769:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42770:	48 8d 05 21 23 00 00 	lea    0x2321(%rip),%rax        # 44a98 <complex_keymap+0x58>
   42777:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   4277b:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4277f:	75 0d                	jne    4278e <check_keyboard+0xb7>
            argument = "allocator";
   42781:	48 8d 05 15 23 00 00 	lea    0x2315(%rip),%rax        # 44a9d <complex_keymap+0x5d>
   42788:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4278c:	eb 37                	jmp    427c5 <check_keyboard+0xee>
        } else if (c == 'e') {
   4278e:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42792:	75 0d                	jne    427a1 <check_keyboard+0xca>
            argument = "forkexit";
   42794:	48 8d 05 0c 23 00 00 	lea    0x230c(%rip),%rax        # 44aa7 <complex_keymap+0x67>
   4279b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4279f:	eb 24                	jmp    427c5 <check_keyboard+0xee>
        }
        else if (c == 't'){
   427a1:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   427a5:	75 0d                	jne    427b4 <check_keyboard+0xdd>
            argument = "test";
   427a7:	48 8d 05 02 23 00 00 	lea    0x2302(%rip),%rax        # 44ab0 <complex_keymap+0x70>
   427ae:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   427b2:	eb 11                	jmp    427c5 <check_keyboard+0xee>
        }
        else if(c == '2'){
   427b4:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   427b8:	75 0b                	jne    427c5 <check_keyboard+0xee>
            argument = "test2";
   427ba:	48 8d 05 f4 22 00 00 	lea    0x22f4(%rip),%rax        # 44ab5 <complex_keymap+0x75>
   427c1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   427c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   427c9:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   427cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   427d2:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   427d6:	76 1e                	jbe    427f6 <check_keyboard+0x11f>
   427d8:	48 8d 05 dc 22 00 00 	lea    0x22dc(%rip),%rax        # 44abb <complex_keymap+0x7b>
   427df:	48 89 c2             	mov    %rax,%rdx
   427e2:	be 5d 02 00 00       	mov    $0x25d,%esi
   427e7:	48 8d 05 e9 22 00 00 	lea    0x22e9(%rip),%rax        # 44ad7 <complex_keymap+0x97>
   427ee:	48 89 c7             	mov    %rax,%rdi
   427f1:	e8 33 01 00 00       	call   42929 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   427f6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   427fa:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   427fd:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42801:	48 89 c3             	mov    %rax,%rbx
   42804:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42809:	e9 f2 d7 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   4280e:	eb 11                	jmp    42821 <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42810:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42814:	74 06                	je     4281c <check_keyboard+0x145>
   42816:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   4281a:	75 05                	jne    42821 <check_keyboard+0x14a>
        poweroff();
   4281c:	e8 3c f8 ff ff       	call   4205d <poweroff>
    }
    return c;
   42821:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42824:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42828:	c9                   	leave  
   42829:	c3                   	ret    

000000000004282a <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4282a:	f3 0f 1e fa          	endbr64 
   4282e:	55                   	push   %rbp
   4282f:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42832:	e8 a0 fe ff ff       	call   426d7 <check_keyboard>
   42837:	eb f9                	jmp    42832 <fail+0x8>

0000000000042839 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42839:	f3 0f 1e fa          	endbr64 
   4283d:	55                   	push   %rbp
   4283e:	48 89 e5             	mov    %rsp,%rbp
   42841:	48 83 ec 60          	sub    $0x60,%rsp
   42845:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42849:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4284d:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42851:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42855:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42859:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4285d:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42864:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42868:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   4286c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42870:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42874:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42879:	0f 84 87 00 00 00    	je     42906 <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   4287f:	48 8d 05 65 22 00 00 	lea    0x2265(%rip),%rax        # 44aeb <complex_keymap+0xab>
   42886:	48 89 c2             	mov    %rax,%rdx
   42889:	be 00 c0 00 00       	mov    $0xc000,%esi
   4288e:	bf 30 07 00 00       	mov    $0x730,%edi
   42893:	b8 00 00 00 00       	mov    $0x0,%eax
   42898:	e8 e4 fd ff ff       	call   42681 <error_printf>
   4289d:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   428a0:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   428a4:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   428a8:	8b 45 cc             	mov    -0x34(%rbp),%eax
   428ab:	be 00 c0 00 00       	mov    $0xc000,%esi
   428b0:	89 c7                	mov    %eax,%edi
   428b2:	e8 68 fd ff ff       	call   4261f <error_vprintf>
   428b7:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   428ba:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   428bd:	48 63 c1             	movslq %ecx,%rax
   428c0:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   428c7:	48 c1 e8 20          	shr    $0x20,%rax
   428cb:	c1 f8 05             	sar    $0x5,%eax
   428ce:	89 ce                	mov    %ecx,%esi
   428d0:	c1 fe 1f             	sar    $0x1f,%esi
   428d3:	29 f0                	sub    %esi,%eax
   428d5:	89 c2                	mov    %eax,%edx
   428d7:	89 d0                	mov    %edx,%eax
   428d9:	c1 e0 02             	shl    $0x2,%eax
   428dc:	01 d0                	add    %edx,%eax
   428de:	c1 e0 04             	shl    $0x4,%eax
   428e1:	29 c1                	sub    %eax,%ecx
   428e3:	89 ca                	mov    %ecx,%edx
   428e5:	85 d2                	test   %edx,%edx
   428e7:	74 3b                	je     42924 <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   428e9:	8b 45 cc             	mov    -0x34(%rbp),%eax
   428ec:	48 8d 15 00 22 00 00 	lea    0x2200(%rip),%rdx        # 44af3 <complex_keymap+0xb3>
   428f3:	be 00 c0 00 00       	mov    $0xc000,%esi
   428f8:	89 c7                	mov    %eax,%edi
   428fa:	b8 00 00 00 00       	mov    $0x0,%eax
   428ff:	e8 7d fd ff ff       	call   42681 <error_printf>
   42904:	eb 1e                	jmp    42924 <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42906:	48 8d 05 e8 21 00 00 	lea    0x21e8(%rip),%rax        # 44af5 <complex_keymap+0xb5>
   4290d:	48 89 c2             	mov    %rax,%rdx
   42910:	be 00 c0 00 00       	mov    $0xc000,%esi
   42915:	bf 30 07 00 00       	mov    $0x730,%edi
   4291a:	b8 00 00 00 00       	mov    $0x0,%eax
   4291f:	e8 5d fd ff ff       	call   42681 <error_printf>
    }

    va_end(val);
    fail();
   42924:	e8 01 ff ff ff       	call   4282a <fail>

0000000000042929 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42929:	f3 0f 1e fa          	endbr64 
   4292d:	55                   	push   %rbp
   4292e:	48 89 e5             	mov    %rsp,%rbp
   42931:	48 83 ec 20          	sub    $0x20,%rsp
   42935:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42939:	89 75 f4             	mov    %esi,-0xc(%rbp)
   4293c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42940:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42944:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42947:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4294b:	48 89 c6             	mov    %rax,%rsi
   4294e:	48 8d 05 a6 21 00 00 	lea    0x21a6(%rip),%rax        # 44afb <complex_keymap+0xbb>
   42955:	48 89 c7             	mov    %rax,%rdi
   42958:	b8 00 00 00 00       	mov    $0x0,%eax
   4295d:	e8 d7 fe ff ff       	call   42839 <panic>

0000000000042962 <default_exception>:
}

void default_exception(proc* p){
   42962:	f3 0f 1e fa          	endbr64 
   42966:	55                   	push   %rbp
   42967:	48 89 e5             	mov    %rsp,%rbp
   4296a:	48 83 ec 20          	sub    $0x20,%rsp
   4296e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42972:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42976:	48 83 c0 08          	add    $0x8,%rax
   4297a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   4297e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42982:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42989:	48 89 c6             	mov    %rax,%rsi
   4298c:	48 8d 05 86 21 00 00 	lea    0x2186(%rip),%rax        # 44b19 <complex_keymap+0xd9>
   42993:	48 89 c7             	mov    %rax,%rdi
   42996:	b8 00 00 00 00       	mov    $0x0,%eax
   4299b:	e8 99 fe ff ff       	call   42839 <panic>

00000000000429a0 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   429a0:	55                   	push   %rbp
   429a1:	48 89 e5             	mov    %rsp,%rbp
   429a4:	48 83 ec 10          	sub    $0x10,%rsp
   429a8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   429ac:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   429af:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   429b3:	78 06                	js     429bb <pageindex+0x1b>
   429b5:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   429b9:	7e 1e                	jle    429d9 <pageindex+0x39>
   429bb:	48 8d 05 76 21 00 00 	lea    0x2176(%rip),%rax        # 44b38 <complex_keymap+0xf8>
   429c2:	48 89 c2             	mov    %rax,%rdx
   429c5:	be 1e 00 00 00       	mov    $0x1e,%esi
   429ca:	48 8d 05 80 21 00 00 	lea    0x2180(%rip),%rax        # 44b51 <complex_keymap+0x111>
   429d1:	48 89 c7             	mov    %rax,%rdi
   429d4:	e8 50 ff ff ff       	call   42929 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   429d9:	b8 03 00 00 00       	mov    $0x3,%eax
   429de:	2b 45 f4             	sub    -0xc(%rbp),%eax
   429e1:	89 c2                	mov    %eax,%edx
   429e3:	89 d0                	mov    %edx,%eax
   429e5:	c1 e0 03             	shl    $0x3,%eax
   429e8:	01 d0                	add    %edx,%eax
   429ea:	83 c0 0c             	add    $0xc,%eax
   429ed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   429f1:	89 c1                	mov    %eax,%ecx
   429f3:	48 d3 ea             	shr    %cl,%rdx
   429f6:	48 89 d0             	mov    %rdx,%rax
   429f9:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   429fe:	c9                   	leave  
   429ff:	c3                   	ret    

0000000000042a00 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42a00:	f3 0f 1e fa          	endbr64 
   42a04:	55                   	push   %rbp
   42a05:	48 89 e5             	mov    %rsp,%rbp
   42a08:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42a0c:	48 8d 05 ed 35 01 00 	lea    0x135ed(%rip),%rax        # 56000 <kernel_pagetables>
   42a13:	48 89 05 e6 25 01 00 	mov    %rax,0x125e6(%rip)        # 55000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42a1a:	ba 00 50 00 00       	mov    $0x5000,%edx
   42a1f:	be 00 00 00 00       	mov    $0x0,%esi
   42a24:	48 8d 05 d5 35 01 00 	lea    0x135d5(%rip),%rax        # 56000 <kernel_pagetables>
   42a2b:	48 89 c7             	mov    %rax,%rdi
   42a2e:	e8 8b 0b 00 00       	call   435be <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42a33:	48 8d 05 c6 45 01 00 	lea    0x145c6(%rip),%rax        # 57000 <kernel_pagetables+0x1000>
   42a3a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42a3e:	48 89 05 bb 35 01 00 	mov    %rax,0x135bb(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42a45:	48 8d 05 b4 55 01 00 	lea    0x155b4(%rip),%rax        # 58000 <kernel_pagetables+0x2000>
   42a4c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42a50:	48 89 05 a9 45 01 00 	mov    %rax,0x145a9(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42a57:	48 8d 05 a2 65 01 00 	lea    0x165a2(%rip),%rax        # 59000 <kernel_pagetables+0x3000>
   42a5e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42a62:	48 89 05 97 55 01 00 	mov    %rax,0x15597(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42a69:	48 8d 05 90 75 01 00 	lea    0x17590(%rip),%rax        # 5a000 <kernel_pagetables+0x4000>
   42a70:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42a74:	48 89 05 8d 55 01 00 	mov    %rax,0x1558d(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42a7b:	48 8b 05 7e 25 01 00 	mov    0x1257e(%rip),%rax        # 55000 <kernel_pagetable>
   42a82:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42a88:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42a8d:	ba 00 00 00 00       	mov    $0x0,%edx
   42a92:	be 00 00 00 00       	mov    $0x0,%esi
   42a97:	48 89 c7             	mov    %rax,%rdi
   42a9a:	e8 0e 02 00 00       	call   42cad <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42a9f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42aa6:	00 
   42aa7:	eb 76                	jmp    42b1f <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42aa9:	48 8b 0d 50 25 01 00 	mov    0x12550(%rip),%rcx        # 55000 <kernel_pagetable>
   42ab0:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42ab4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42ab8:	48 89 ce             	mov    %rcx,%rsi
   42abb:	48 89 c7             	mov    %rax,%rdi
   42abe:	e8 34 06 00 00       	call   430f7 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42ac3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ac7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42acb:	74 1e                	je     42aeb <virtual_memory_init+0xeb>
   42acd:	48 8d 05 91 20 00 00 	lea    0x2091(%rip),%rax        # 44b65 <complex_keymap+0x125>
   42ad4:	48 89 c2             	mov    %rax,%rdx
   42ad7:	be 2d 00 00 00       	mov    $0x2d,%esi
   42adc:	48 8d 05 92 20 00 00 	lea    0x2092(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42ae3:	48 89 c7             	mov    %rax,%rdi
   42ae6:	e8 3e fe ff ff       	call   42929 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42aeb:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42aee:	48 98                	cltq   
   42af0:	83 e0 03             	and    $0x3,%eax
   42af3:	48 83 f8 03          	cmp    $0x3,%rax
   42af7:	74 1e                	je     42b17 <virtual_memory_init+0x117>
   42af9:	48 8d 05 88 20 00 00 	lea    0x2088(%rip),%rax        # 44b88 <complex_keymap+0x148>
   42b00:	48 89 c2             	mov    %rax,%rdx
   42b03:	be 2e 00 00 00       	mov    $0x2e,%esi
   42b08:	48 8d 05 66 20 00 00 	lea    0x2066(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42b0f:	48 89 c7             	mov    %rax,%rdi
   42b12:	e8 12 fe ff ff       	call   42929 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42b17:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42b1e:	00 
   42b1f:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42b26:	00 
   42b27:	76 80                	jbe    42aa9 <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42b29:	48 8b 05 d0 24 01 00 	mov    0x124d0(%rip),%rax        # 55000 <kernel_pagetable>
   42b30:	48 89 c7             	mov    %rax,%rdi
   42b33:	e8 03 00 00 00       	call   42b3b <set_pagetable>
}
   42b38:	90                   	nop
   42b39:	c9                   	leave  
   42b3a:	c3                   	ret    

0000000000042b3b <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42b3b:	f3 0f 1e fa          	endbr64 
   42b3f:	55                   	push   %rbp
   42b40:	48 89 e5             	mov    %rsp,%rbp
   42b43:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42b47:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42b4b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42b4f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b54:	48 85 c0             	test   %rax,%rax
   42b57:	74 1e                	je     42b77 <set_pagetable+0x3c>
   42b59:	48 8d 05 55 20 00 00 	lea    0x2055(%rip),%rax        # 44bb5 <complex_keymap+0x175>
   42b60:	48 89 c2             	mov    %rax,%rdx
   42b63:	be 3d 00 00 00       	mov    $0x3d,%esi
   42b68:	48 8d 05 06 20 00 00 	lea    0x2006(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42b6f:	48 89 c7             	mov    %rax,%rdi
   42b72:	e8 b2 fd ff ff       	call   42929 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42b77:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   42b7e:	48 89 c2             	mov    %rax,%rdx
   42b81:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42b85:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42b89:	48 89 ce             	mov    %rcx,%rsi
   42b8c:	48 89 c7             	mov    %rax,%rdi
   42b8f:	e8 63 05 00 00       	call   430f7 <virtual_memory_lookup>
   42b94:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42b98:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   42b9f:	48 39 d0             	cmp    %rdx,%rax
   42ba2:	74 1e                	je     42bc2 <set_pagetable+0x87>
   42ba4:	48 8d 05 25 20 00 00 	lea    0x2025(%rip),%rax        # 44bd0 <complex_keymap+0x190>
   42bab:	48 89 c2             	mov    %rax,%rdx
   42bae:	be 3f 00 00 00       	mov    $0x3f,%esi
   42bb3:	48 8d 05 bb 1f 00 00 	lea    0x1fbb(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42bba:	48 89 c7             	mov    %rax,%rdi
   42bbd:	e8 67 fd ff ff       	call   42929 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42bc2:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42bc6:	48 8b 0d 33 24 01 00 	mov    0x12433(%rip),%rcx        # 55000 <kernel_pagetable>
   42bcd:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42bd1:	48 89 ce             	mov    %rcx,%rsi
   42bd4:	48 89 c7             	mov    %rax,%rdi
   42bd7:	e8 1b 05 00 00       	call   430f7 <virtual_memory_lookup>
   42bdc:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42be0:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42be4:	48 39 c2             	cmp    %rax,%rdx
   42be7:	74 1e                	je     42c07 <set_pagetable+0xcc>
   42be9:	48 8d 05 48 20 00 00 	lea    0x2048(%rip),%rax        # 44c38 <complex_keymap+0x1f8>
   42bf0:	48 89 c2             	mov    %rax,%rdx
   42bf3:	be 41 00 00 00       	mov    $0x41,%esi
   42bf8:	48 8d 05 76 1f 00 00 	lea    0x1f76(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42bff:	48 89 c7             	mov    %rax,%rdi
   42c02:	e8 22 fd ff ff       	call   42929 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42c07:	48 8b 05 f2 23 01 00 	mov    0x123f2(%rip),%rax        # 55000 <kernel_pagetable>
   42c0e:	48 89 c2             	mov    %rax,%rdx
   42c11:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42c15:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42c19:	48 89 ce             	mov    %rcx,%rsi
   42c1c:	48 89 c7             	mov    %rax,%rdi
   42c1f:	e8 d3 04 00 00       	call   430f7 <virtual_memory_lookup>
   42c24:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c28:	48 8b 15 d1 23 01 00 	mov    0x123d1(%rip),%rdx        # 55000 <kernel_pagetable>
   42c2f:	48 39 d0             	cmp    %rdx,%rax
   42c32:	74 1e                	je     42c52 <set_pagetable+0x117>
   42c34:	48 8d 05 5d 20 00 00 	lea    0x205d(%rip),%rax        # 44c98 <complex_keymap+0x258>
   42c3b:	48 89 c2             	mov    %rax,%rdx
   42c3e:	be 43 00 00 00       	mov    $0x43,%esi
   42c43:	48 8d 05 2b 1f 00 00 	lea    0x1f2b(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42c4a:	48 89 c7             	mov    %rax,%rdi
   42c4d:	e8 d7 fc ff ff       	call   42929 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42c52:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 42cad <virtual_memory_map>
   42c59:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42c5d:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42c61:	48 89 ce             	mov    %rcx,%rsi
   42c64:	48 89 c7             	mov    %rax,%rdi
   42c67:	e8 8b 04 00 00       	call   430f7 <virtual_memory_lookup>
   42c6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c70:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 42cad <virtual_memory_map>
   42c77:	48 39 d0             	cmp    %rdx,%rax
   42c7a:	74 1e                	je     42c9a <set_pagetable+0x15f>
   42c7c:	48 8d 05 7d 20 00 00 	lea    0x207d(%rip),%rax        # 44d00 <complex_keymap+0x2c0>
   42c83:	48 89 c2             	mov    %rax,%rdx
   42c86:	be 45 00 00 00       	mov    $0x45,%esi
   42c8b:	48 8d 05 e3 1e 00 00 	lea    0x1ee3(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42c92:	48 89 c7             	mov    %rax,%rdi
   42c95:	e8 8f fc ff ff       	call   42929 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42c9a:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42c9e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42ca2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ca6:	0f 22 d8             	mov    %rax,%cr3
}
   42ca9:	90                   	nop
}
   42caa:	90                   	nop
   42cab:	c9                   	leave  
   42cac:	c3                   	ret    

0000000000042cad <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42cad:	f3 0f 1e fa          	endbr64 
   42cb1:	55                   	push   %rbp
   42cb2:	48 89 e5             	mov    %rsp,%rbp
   42cb5:	48 83 ec 50          	sub    $0x50,%rsp
   42cb9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42cbd:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42cc1:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42cc5:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   42cc9:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42ccd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42cd1:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cd6:	48 85 c0             	test   %rax,%rax
   42cd9:	74 1e                	je     42cf9 <virtual_memory_map+0x4c>
   42cdb:	48 8d 05 84 20 00 00 	lea    0x2084(%rip),%rax        # 44d66 <complex_keymap+0x326>
   42ce2:	48 89 c2             	mov    %rax,%rdx
   42ce5:	be 66 00 00 00       	mov    $0x66,%esi
   42cea:	48 8d 05 84 1e 00 00 	lea    0x1e84(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42cf1:	48 89 c7             	mov    %rax,%rdi
   42cf4:	e8 30 fc ff ff       	call   42929 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42cf9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42cfd:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d02:	48 85 c0             	test   %rax,%rax
   42d05:	74 1e                	je     42d25 <virtual_memory_map+0x78>
   42d07:	48 8d 05 6b 20 00 00 	lea    0x206b(%rip),%rax        # 44d79 <complex_keymap+0x339>
   42d0e:	48 89 c2             	mov    %rax,%rdx
   42d11:	be 67 00 00 00       	mov    $0x67,%esi
   42d16:	48 8d 05 58 1e 00 00 	lea    0x1e58(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42d1d:	48 89 c7             	mov    %rax,%rdi
   42d20:	e8 04 fc ff ff       	call   42929 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42d25:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42d29:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42d2d:	48 01 d0             	add    %rdx,%rax
   42d30:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42d34:	76 2e                	jbe    42d64 <virtual_memory_map+0xb7>
   42d36:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42d3a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42d3e:	48 01 d0             	add    %rdx,%rax
   42d41:	48 85 c0             	test   %rax,%rax
   42d44:	74 1e                	je     42d64 <virtual_memory_map+0xb7>
   42d46:	48 8d 05 3f 20 00 00 	lea    0x203f(%rip),%rax        # 44d8c <complex_keymap+0x34c>
   42d4d:	48 89 c2             	mov    %rax,%rdx
   42d50:	be 68 00 00 00       	mov    $0x68,%esi
   42d55:	48 8d 05 19 1e 00 00 	lea    0x1e19(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42d5c:	48 89 c7             	mov    %rax,%rdi
   42d5f:	e8 c5 fb ff ff       	call   42929 <assert_fail>
    if (perm & PTE_P) {
   42d64:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42d67:	48 98                	cltq   
   42d69:	83 e0 01             	and    $0x1,%eax
   42d6c:	48 85 c0             	test   %rax,%rax
   42d6f:	0f 84 8c 00 00 00    	je     42e01 <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42d75:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d79:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d7e:	48 85 c0             	test   %rax,%rax
   42d81:	74 1e                	je     42da1 <virtual_memory_map+0xf4>
   42d83:	48 8d 05 20 20 00 00 	lea    0x2020(%rip),%rax        # 44daa <complex_keymap+0x36a>
   42d8a:	48 89 c2             	mov    %rax,%rdx
   42d8d:	be 6a 00 00 00       	mov    $0x6a,%esi
   42d92:	48 8d 05 dc 1d 00 00 	lea    0x1ddc(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42d99:	48 89 c7             	mov    %rax,%rdi
   42d9c:	e8 88 fb ff ff       	call   42929 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42da1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42da5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42da9:	48 01 d0             	add    %rdx,%rax
   42dac:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   42db0:	76 1e                	jbe    42dd0 <virtual_memory_map+0x123>
   42db2:	48 8d 05 04 20 00 00 	lea    0x2004(%rip),%rax        # 44dbd <complex_keymap+0x37d>
   42db9:	48 89 c2             	mov    %rax,%rdx
   42dbc:	be 6b 00 00 00       	mov    $0x6b,%esi
   42dc1:	48 8d 05 ad 1d 00 00 	lea    0x1dad(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42dc8:	48 89 c7             	mov    %rax,%rdi
   42dcb:	e8 59 fb ff ff       	call   42929 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42dd0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42dd4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42dd8:	48 01 d0             	add    %rdx,%rax
   42ddb:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42de1:	76 1e                	jbe    42e01 <virtual_memory_map+0x154>
   42de3:	48 8d 05 e1 1f 00 00 	lea    0x1fe1(%rip),%rax        # 44dcb <complex_keymap+0x38b>
   42dea:	48 89 c2             	mov    %rax,%rdx
   42ded:	be 6c 00 00 00       	mov    $0x6c,%esi
   42df2:	48 8d 05 7c 1d 00 00 	lea    0x1d7c(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42df9:	48 89 c7             	mov    %rax,%rdi
   42dfc:	e8 28 fb ff ff       	call   42929 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42e01:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   42e05:	78 09                	js     42e10 <virtual_memory_map+0x163>
   42e07:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   42e0e:	7e 1e                	jle    42e2e <virtual_memory_map+0x181>
   42e10:	48 8d 05 d0 1f 00 00 	lea    0x1fd0(%rip),%rax        # 44de7 <complex_keymap+0x3a7>
   42e17:	48 89 c2             	mov    %rax,%rdx
   42e1a:	be 6e 00 00 00       	mov    $0x6e,%esi
   42e1f:	48 8d 05 4f 1d 00 00 	lea    0x1d4f(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42e26:	48 89 c7             	mov    %rax,%rdi
   42e29:	e8 fb fa ff ff       	call   42929 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42e2e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e32:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e37:	48 85 c0             	test   %rax,%rax
   42e3a:	74 1e                	je     42e5a <virtual_memory_map+0x1ad>
   42e3c:	48 8d 05 c5 1f 00 00 	lea    0x1fc5(%rip),%rax        # 44e08 <complex_keymap+0x3c8>
   42e43:	48 89 c2             	mov    %rax,%rdx
   42e46:	be 6f 00 00 00       	mov    $0x6f,%esi
   42e4b:	48 8d 05 23 1d 00 00 	lea    0x1d23(%rip),%rax        # 44b75 <complex_keymap+0x135>
   42e52:	48 89 c7             	mov    %rax,%rdi
   42e55:	e8 cf fa ff ff       	call   42929 <assert_fail>

    int last_index123 = -1;
   42e5a:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42e61:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   42e68:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42e69:	e9 ed 00 00 00       	jmp    42f5b <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42e6e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42e72:	48 c1 e8 15          	shr    $0x15,%rax
   42e76:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   42e79:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42e7c:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   42e7f:	74 20                	je     42ea1 <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   42e81:	8b 55 bc             	mov    -0x44(%rbp),%edx
   42e84:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   42e88:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e8c:	48 89 ce             	mov    %rcx,%rsi
   42e8f:	48 89 c7             	mov    %rax,%rdi
   42e92:	e8 d6 00 00 00       	call   42f6d <lookup_l1pagetable>
   42e97:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   42e9b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42e9e:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42ea1:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42ea4:	48 98                	cltq   
   42ea6:	83 e0 01             	and    $0x1,%eax
   42ea9:	48 85 c0             	test   %rax,%rax
   42eac:	74 37                	je     42ee5 <virtual_memory_map+0x238>
   42eae:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   42eb3:	74 30                	je     42ee5 <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   42eb5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42eb9:	be 03 00 00 00       	mov    $0x3,%esi
   42ebe:	48 89 c7             	mov    %rax,%rdi
   42ec1:	e8 da fa ff ff       	call   429a0 <pageindex>
   42ec6:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   42ec9:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42ecc:	48 98                	cltq   
   42ece:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   42ed2:	48 89 c1             	mov    %rax,%rcx
   42ed5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ed9:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42edc:	48 63 d2             	movslq %edx,%rdx
   42edf:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42ee3:	eb 5e                	jmp    42f43 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   42ee5:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   42eea:	74 2a                	je     42f16 <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   42eec:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42ef0:	be 03 00 00 00       	mov    $0x3,%esi
   42ef5:	48 89 c7             	mov    %rax,%rdi
   42ef8:	e8 a3 fa ff ff       	call   429a0 <pageindex>
   42efd:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   42f00:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42f03:	48 63 c8             	movslq %eax,%rcx
   42f06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f0a:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42f0d:	48 63 d2             	movslq %edx,%rdx
   42f10:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42f14:	eb 2d                	jmp    42f43 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   42f16:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42f19:	48 98                	cltq   
   42f1b:	83 e0 01             	and    $0x1,%eax
   42f1e:	48 85 c0             	test   %rax,%rax
   42f21:	74 20                	je     42f43 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42f23:	be 88 00 00 00       	mov    $0x88,%esi
   42f28:	48 8d 05 01 1f 00 00 	lea    0x1f01(%rip),%rax        # 44e30 <complex_keymap+0x3f0>
   42f2f:	48 89 c7             	mov    %rax,%rdi
   42f32:	b8 00 00 00 00       	mov    $0x0,%eax
   42f37:	e8 92 f6 ff ff       	call   425ce <log_printf>
            return -1;
   42f3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f41:	eb 28                	jmp    42f6b <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42f43:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   42f4a:	00 
   42f4b:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   42f52:	00 
   42f53:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   42f5a:	00 
   42f5b:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   42f60:	0f 85 08 ff ff ff    	jne    42e6e <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   42f66:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f6b:	c9                   	leave  
   42f6c:	c3                   	ret    

0000000000042f6d <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42f6d:	f3 0f 1e fa          	endbr64 
   42f71:	55                   	push   %rbp
   42f72:	48 89 e5             	mov    %rsp,%rbp
   42f75:	48 83 ec 40          	sub    $0x40,%rsp
   42f79:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f7d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42f81:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42f84:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f88:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42f8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42f93:	e9 4f 01 00 00       	jmp    430e7 <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
                int index = PAGEINDEX(va, i); // Get the index for the current level
   42f98:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42f9b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42f9f:	89 d6                	mov    %edx,%esi
   42fa1:	48 89 c7             	mov    %rax,%rdi
   42fa4:	e8 f7 f9 ff ff       	call   429a0 <pageindex>
   42fa9:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   42fac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fb0:	8b 55 f0             	mov    -0x10(%rbp),%edx
   42fb3:	48 63 d2             	movslq %edx,%rdx
   42fb6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42fba:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42fbe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fc2:	83 e0 01             	and    $0x1,%eax
   42fc5:	48 85 c0             	test   %rax,%rax
   42fc8:	75 6d                	jne    43037 <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42fca:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42fcd:	8d 48 02             	lea    0x2(%rax),%ecx
   42fd0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fd4:	25 ff 0f 00 00       	and    $0xfff,%eax
   42fd9:	48 89 c2             	mov    %rax,%rdx
   42fdc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fe0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42fe6:	48 89 c6             	mov    %rax,%rsi
   42fe9:	48 8d 05 88 1e 00 00 	lea    0x1e88(%rip),%rax        # 44e78 <complex_keymap+0x438>
   42ff0:	48 89 c7             	mov    %rax,%rdi
   42ff3:	b8 00 00 00 00       	mov    $0x0,%eax
   42ff8:	e8 d1 f5 ff ff       	call   425ce <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42ffd:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43000:	48 98                	cltq   
   43002:	83 e0 01             	and    $0x1,%eax
   43005:	48 85 c0             	test   %rax,%rax
   43008:	75 0a                	jne    43014 <lookup_l1pagetable+0xa7>
                return NULL;
   4300a:	b8 00 00 00 00       	mov    $0x0,%eax
   4300f:	e9 e1 00 00 00       	jmp    430f5 <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   43014:	be ad 00 00 00       	mov    $0xad,%esi
   43019:	48 8d 05 c0 1e 00 00 	lea    0x1ec0(%rip),%rax        # 44ee0 <complex_keymap+0x4a0>
   43020:	48 89 c7             	mov    %rax,%rdi
   43023:	b8 00 00 00 00       	mov    $0x0,%eax
   43028:	e8 a1 f5 ff ff       	call   425ce <log_printf>
            return NULL;
   4302d:	b8 00 00 00 00       	mov    $0x0,%eax
   43032:	e9 be 00 00 00       	jmp    430f5 <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   43037:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4303b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43041:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   43047:	76 1e                	jbe    43067 <lookup_l1pagetable+0xfa>
   43049:	48 8d 05 d8 1e 00 00 	lea    0x1ed8(%rip),%rax        # 44f28 <complex_keymap+0x4e8>
   43050:	48 89 c2             	mov    %rax,%rdx
   43053:	be b2 00 00 00       	mov    $0xb2,%esi
   43058:	48 8d 05 16 1b 00 00 	lea    0x1b16(%rip),%rax        # 44b75 <complex_keymap+0x135>
   4305f:	48 89 c7             	mov    %rax,%rdi
   43062:	e8 c2 f8 ff ff       	call   42929 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   43067:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4306a:	48 98                	cltq   
   4306c:	83 e0 02             	and    $0x2,%eax
   4306f:	48 85 c0             	test   %rax,%rax
   43072:	74 2a                	je     4309e <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   43074:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43078:	83 e0 02             	and    $0x2,%eax
   4307b:	48 85 c0             	test   %rax,%rax
   4307e:	75 1e                	jne    4309e <lookup_l1pagetable+0x131>
   43080:	48 8d 05 c1 1e 00 00 	lea    0x1ec1(%rip),%rax        # 44f48 <complex_keymap+0x508>
   43087:	48 89 c2             	mov    %rax,%rdx
   4308a:	be b4 00 00 00       	mov    $0xb4,%esi
   4308f:	48 8d 05 df 1a 00 00 	lea    0x1adf(%rip),%rax        # 44b75 <complex_keymap+0x135>
   43096:	48 89 c7             	mov    %rax,%rdi
   43099:	e8 8b f8 ff ff       	call   42929 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   4309e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   430a1:	48 98                	cltq   
   430a3:	83 e0 04             	and    $0x4,%eax
   430a6:	48 85 c0             	test   %rax,%rax
   430a9:	74 2a                	je     430d5 <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   430ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430af:	83 e0 04             	and    $0x4,%eax
   430b2:	48 85 c0             	test   %rax,%rax
   430b5:	75 1e                	jne    430d5 <lookup_l1pagetable+0x168>
   430b7:	48 8d 05 95 1e 00 00 	lea    0x1e95(%rip),%rax        # 44f53 <complex_keymap+0x513>
   430be:	48 89 c2             	mov    %rax,%rdx
   430c1:	be b7 00 00 00       	mov    $0xb7,%esi
   430c6:	48 8d 05 a8 1a 00 00 	lea    0x1aa8(%rip),%rax        # 44b75 <complex_keymap+0x135>
   430cd:	48 89 c7             	mov    %rax,%rdi
   430d0:	e8 54 f8 ff ff       	call   42929 <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   430d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430d9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   430df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   430e3:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   430e7:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   430eb:	0f 8e a7 fe ff ff    	jle    42f98 <lookup_l1pagetable+0x2b>
    }
    return pt;
   430f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   430f5:	c9                   	leave  
   430f6:	c3                   	ret    

00000000000430f7 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   430f7:	f3 0f 1e fa          	endbr64 
   430fb:	55                   	push   %rbp
   430fc:	48 89 e5             	mov    %rsp,%rbp
   430ff:	48 83 ec 50          	sub    $0x50,%rsp
   43103:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43107:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   4310b:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   4310f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43113:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   43117:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4311e:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4311f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   43126:	eb 41                	jmp    43169 <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   43128:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4312b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4312f:	89 d6                	mov    %edx,%esi
   43131:	48 89 c7             	mov    %rax,%rdi
   43134:	e8 67 f8 ff ff       	call   429a0 <pageindex>
   43139:	89 c2                	mov    %eax,%edx
   4313b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4313f:	48 63 d2             	movslq %edx,%rdx
   43142:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43146:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4314a:	83 e0 06             	and    $0x6,%eax
   4314d:	48 f7 d0             	not    %rax
   43150:	48 21 d0             	and    %rdx,%rax
   43153:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43157:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4315b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43161:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43165:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43169:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4316d:	7f 0c                	jg     4317b <virtual_memory_lookup+0x84>
   4316f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43173:	83 e0 01             	and    $0x1,%eax
   43176:	48 85 c0             	test   %rax,%rax
   43179:	75 ad                	jne    43128 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   4317b:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43182:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   43189:	ff 
   4318a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   43191:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43195:	83 e0 01             	and    $0x1,%eax
   43198:	48 85 c0             	test   %rax,%rax
   4319b:	74 34                	je     431d1 <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   4319d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431a1:	48 c1 e8 0c          	shr    $0xc,%rax
   431a5:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   431a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431ac:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   431b2:	48 89 c2             	mov    %rax,%rdx
   431b5:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   431b9:	25 ff 0f 00 00       	and    $0xfff,%eax
   431be:	48 09 d0             	or     %rdx,%rax
   431c1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   431c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431c9:	25 ff 0f 00 00       	and    $0xfff,%eax
   431ce:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   431d1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431d5:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   431d9:	48 89 10             	mov    %rdx,(%rax)
   431dc:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   431e0:	48 89 50 08          	mov    %rdx,0x8(%rax)
   431e4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   431e8:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   431ec:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431f0:	c9                   	leave  
   431f1:	c3                   	ret    

00000000000431f2 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   431f2:	f3 0f 1e fa          	endbr64 
   431f6:	55                   	push   %rbp
   431f7:	48 89 e5             	mov    %rsp,%rbp
   431fa:	48 83 ec 40          	sub    $0x40,%rsp
   431fe:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43202:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   43205:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   43209:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   43210:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43214:	78 08                	js     4321e <program_load+0x2c>
   43216:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43219:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   4321c:	7c 1e                	jl     4323c <program_load+0x4a>
   4321e:	48 8d 05 3b 1d 00 00 	lea    0x1d3b(%rip),%rax        # 44f60 <complex_keymap+0x520>
   43225:	48 89 c2             	mov    %rax,%rdx
   43228:	be 37 00 00 00       	mov    $0x37,%esi
   4322d:	48 8d 05 5c 1d 00 00 	lea    0x1d5c(%rip),%rax        # 44f90 <complex_keymap+0x550>
   43234:	48 89 c7             	mov    %rax,%rdi
   43237:	e8 ed f6 ff ff       	call   42929 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4323c:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   4323f:	48 98                	cltq   
   43241:	48 c1 e0 04          	shl    $0x4,%rax
   43245:	48 89 c2             	mov    %rax,%rdx
   43248:	48 8d 05 d1 2d 00 00 	lea    0x2dd1(%rip),%rax        # 46020 <ramimages>
   4324f:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   43253:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43257:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4325b:	8b 00                	mov    (%rax),%eax
   4325d:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43262:	74 1e                	je     43282 <program_load+0x90>
   43264:	48 8d 05 37 1d 00 00 	lea    0x1d37(%rip),%rax        # 44fa2 <complex_keymap+0x562>
   4326b:	48 89 c2             	mov    %rax,%rdx
   4326e:	be 39 00 00 00       	mov    $0x39,%esi
   43273:	48 8d 05 16 1d 00 00 	lea    0x1d16(%rip),%rax        # 44f90 <complex_keymap+0x550>
   4327a:	48 89 c7             	mov    %rax,%rdi
   4327d:	e8 a7 f6 ff ff       	call   42929 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43282:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43286:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4328a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4328e:	48 01 d0             	add    %rdx,%rax
   43291:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43295:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4329c:	e9 94 00 00 00       	jmp    43335 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   432a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   432a4:	48 63 d0             	movslq %eax,%rdx
   432a7:	48 89 d0             	mov    %rdx,%rax
   432aa:	48 c1 e0 03          	shl    $0x3,%rax
   432ae:	48 29 d0             	sub    %rdx,%rax
   432b1:	48 c1 e0 03          	shl    $0x3,%rax
   432b5:	48 89 c2             	mov    %rax,%rdx
   432b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432bc:	48 01 d0             	add    %rdx,%rax
   432bf:	8b 00                	mov    (%rax),%eax
   432c1:	83 f8 01             	cmp    $0x1,%eax
   432c4:	75 6b                	jne    43331 <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   432c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   432c9:	48 63 d0             	movslq %eax,%rdx
   432cc:	48 89 d0             	mov    %rdx,%rax
   432cf:	48 c1 e0 03          	shl    $0x3,%rax
   432d3:	48 29 d0             	sub    %rdx,%rax
   432d6:	48 c1 e0 03          	shl    $0x3,%rax
   432da:	48 89 c2             	mov    %rax,%rdx
   432dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432e1:	48 01 d0             	add    %rdx,%rax
   432e4:	48 8b 50 08          	mov    0x8(%rax),%rdx
   432e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ec:	48 01 d0             	add    %rdx,%rax
   432ef:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   432f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   432f6:	48 63 d0             	movslq %eax,%rdx
   432f9:	48 89 d0             	mov    %rdx,%rax
   432fc:	48 c1 e0 03          	shl    $0x3,%rax
   43300:	48 29 d0             	sub    %rdx,%rax
   43303:	48 c1 e0 03          	shl    $0x3,%rax
   43307:	48 89 c2             	mov    %rax,%rdx
   4330a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4330e:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43312:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   43316:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4331a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4331e:	48 89 c7             	mov    %rax,%rdi
   43321:	e8 3d 00 00 00       	call   43363 <program_load_segment>
   43326:	85 c0                	test   %eax,%eax
   43328:	79 07                	jns    43331 <program_load+0x13f>
                return -1;
   4332a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4332f:	eb 30                	jmp    43361 <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43331:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43335:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43339:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   4333d:	0f b7 c0             	movzwl %ax,%eax
   43340:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43343:	0f 8c 58 ff ff ff    	jl     432a1 <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   43349:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4334d:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43351:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43355:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   4335c:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43361:	c9                   	leave  
   43362:	c3                   	ret    

0000000000043363 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43363:	f3 0f 1e fa          	endbr64 
   43367:	55                   	push   %rbp
   43368:	48 89 e5             	mov    %rsp,%rbp
   4336b:	48 83 ec 40          	sub    $0x40,%rsp
   4336f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43373:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43377:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   4337b:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4337f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43383:	48 8b 40 10          	mov    0x10(%rax),%rax
   43387:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4338b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4338f:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43393:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43397:	48 01 d0             	add    %rdx,%rax
   4339a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4339e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   433a2:	48 8b 50 28          	mov    0x28(%rax),%rdx
   433a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433aa:	48 01 d0             	add    %rdx,%rax
   433ad:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   433b1:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   433b8:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   433b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433bd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   433c1:	e9 81 00 00 00       	jmp    43447 <program_load_segment+0xe4>
        if (assign_physical_page(addr, p->p_pid) < 0
   433c6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433ca:	8b 00                	mov    (%rax),%eax
   433cc:	0f be d0             	movsbl %al,%edx
   433cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433d3:	89 d6                	mov    %edx,%esi
   433d5:	48 89 c7             	mov    %rax,%rdi
   433d8:	e8 09 d3 ff ff       	call   406e6 <assign_physical_page>
   433dd:	85 c0                	test   %eax,%eax
   433df:	78 2a                	js     4340b <program_load_segment+0xa8>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   433e1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433e5:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   433ec:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   433f0:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   433f4:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   433fa:	b9 00 10 00 00       	mov    $0x1000,%ecx
   433ff:	48 89 c7             	mov    %rax,%rdi
   43402:	e8 a6 f8 ff ff       	call   42cad <virtual_memory_map>
   43407:	85 c0                	test   %eax,%eax
   43409:	79 34                	jns    4343f <program_load_segment+0xdc>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   4340b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4340f:	8b 00                	mov    (%rax),%eax
   43411:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43415:	49 89 d0             	mov    %rdx,%r8
   43418:	89 c1                	mov    %eax,%ecx
   4341a:	48 8d 05 9f 1b 00 00 	lea    0x1b9f(%rip),%rax        # 44fc0 <complex_keymap+0x580>
   43421:	48 89 c2             	mov    %rax,%rdx
   43424:	be 00 c0 00 00       	mov    $0xc000,%esi
   43429:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4342e:	b8 00 00 00 00       	mov    $0x0,%eax
   43433:	e8 c5 0f 00 00       	call   443fd <console_printf>
            return -1;
   43438:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4343d:	eb 77                	jmp    434b6 <program_load_segment+0x153>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4343f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43446:	00 
   43447:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4344b:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   4344f:	0f 82 71 ff ff ff    	jb     433c6 <program_load_segment+0x63>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43455:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43459:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43460:	48 89 c7             	mov    %rax,%rdi
   43463:	e8 d3 f6 ff ff       	call   42b3b <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43468:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4346c:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   43470:	48 89 c2             	mov    %rax,%rdx
   43473:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43477:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4347b:	48 89 ce             	mov    %rcx,%rsi
   4347e:	48 89 c7             	mov    %rax,%rdi
   43481:	e8 32 00 00 00       	call   434b8 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43486:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4348a:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4348e:	48 89 c2             	mov    %rax,%rdx
   43491:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43495:	be 00 00 00 00       	mov    $0x0,%esi
   4349a:	48 89 c7             	mov    %rax,%rdi
   4349d:	e8 1c 01 00 00       	call   435be <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   434a2:	48 8b 05 57 1b 01 00 	mov    0x11b57(%rip),%rax        # 55000 <kernel_pagetable>
   434a9:	48 89 c7             	mov    %rax,%rdi
   434ac:	e8 8a f6 ff ff       	call   42b3b <set_pagetable>
    return 0;
   434b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
   434b6:	c9                   	leave  
   434b7:	c3                   	ret    

00000000000434b8 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   434b8:	f3 0f 1e fa          	endbr64 
   434bc:	55                   	push   %rbp
   434bd:	48 89 e5             	mov    %rsp,%rbp
   434c0:	48 83 ec 28          	sub    $0x28,%rsp
   434c4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   434c8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   434cc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   434d0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   434d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   434d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434dc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   434e0:	eb 1c                	jmp    434fe <memcpy+0x46>
        *d = *s;
   434e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434e6:	0f b6 10             	movzbl (%rax),%edx
   434e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434ed:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   434ef:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   434f4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   434f9:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   434fe:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43503:	75 dd                	jne    434e2 <memcpy+0x2a>
    }
    return dst;
   43505:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43509:	c9                   	leave  
   4350a:	c3                   	ret    

000000000004350b <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   4350b:	f3 0f 1e fa          	endbr64 
   4350f:	55                   	push   %rbp
   43510:	48 89 e5             	mov    %rsp,%rbp
   43513:	48 83 ec 28          	sub    $0x28,%rsp
   43517:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4351b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4351f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43523:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43527:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   4352b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4352f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43533:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43537:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   4353b:	73 6a                	jae    435a7 <memmove+0x9c>
   4353d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43541:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43545:	48 01 d0             	add    %rdx,%rax
   43548:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4354c:	73 59                	jae    435a7 <memmove+0x9c>
        s += n, d += n;
   4354e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43552:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43556:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4355a:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   4355e:	eb 17                	jmp    43577 <memmove+0x6c>
            *--d = *--s;
   43560:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43565:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   4356a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4356e:	0f b6 10             	movzbl (%rax),%edx
   43571:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43575:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43577:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4357b:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4357f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43583:	48 85 c0             	test   %rax,%rax
   43586:	75 d8                	jne    43560 <memmove+0x55>
    if (s < d && s + n > d) {
   43588:	eb 2e                	jmp    435b8 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   4358a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4358e:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43592:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43596:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4359a:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4359e:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   435a2:	0f b6 12             	movzbl (%rdx),%edx
   435a5:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   435a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435ab:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   435af:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   435b3:	48 85 c0             	test   %rax,%rax
   435b6:	75 d2                	jne    4358a <memmove+0x7f>
        }
    }
    return dst;
   435b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   435bc:	c9                   	leave  
   435bd:	c3                   	ret    

00000000000435be <memset>:

void* memset(void* v, int c, size_t n) {
   435be:	f3 0f 1e fa          	endbr64 
   435c2:	55                   	push   %rbp
   435c3:	48 89 e5             	mov    %rsp,%rbp
   435c6:	48 83 ec 28          	sub    $0x28,%rsp
   435ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   435ce:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   435d1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   435d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435d9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   435dd:	eb 15                	jmp    435f4 <memset+0x36>
        *p = c;
   435df:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   435e2:	89 c2                	mov    %eax,%edx
   435e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435e8:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   435ea:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   435ef:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   435f4:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   435f9:	75 e4                	jne    435df <memset+0x21>
    }
    return v;
   435fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   435ff:	c9                   	leave  
   43600:	c3                   	ret    

0000000000043601 <strlen>:

size_t strlen(const char* s) {
   43601:	f3 0f 1e fa          	endbr64 
   43605:	55                   	push   %rbp
   43606:	48 89 e5             	mov    %rsp,%rbp
   43609:	48 83 ec 18          	sub    $0x18,%rsp
   4360d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43611:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43618:	00 
   43619:	eb 0a                	jmp    43625 <strlen+0x24>
        ++n;
   4361b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43620:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43625:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43629:	0f b6 00             	movzbl (%rax),%eax
   4362c:	84 c0                	test   %al,%al
   4362e:	75 eb                	jne    4361b <strlen+0x1a>
    }
    return n;
   43630:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43634:	c9                   	leave  
   43635:	c3                   	ret    

0000000000043636 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43636:	f3 0f 1e fa          	endbr64 
   4363a:	55                   	push   %rbp
   4363b:	48 89 e5             	mov    %rsp,%rbp
   4363e:	48 83 ec 20          	sub    $0x20,%rsp
   43642:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43646:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   4364a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43651:	00 
   43652:	eb 0a                	jmp    4365e <strnlen+0x28>
        ++n;
   43654:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43659:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4365e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43662:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43666:	74 0b                	je     43673 <strnlen+0x3d>
   43668:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4366c:	0f b6 00             	movzbl (%rax),%eax
   4366f:	84 c0                	test   %al,%al
   43671:	75 e1                	jne    43654 <strnlen+0x1e>
    }
    return n;
   43673:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43677:	c9                   	leave  
   43678:	c3                   	ret    

0000000000043679 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43679:	f3 0f 1e fa          	endbr64 
   4367d:	55                   	push   %rbp
   4367e:	48 89 e5             	mov    %rsp,%rbp
   43681:	48 83 ec 20          	sub    $0x20,%rsp
   43685:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43689:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   4368d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43691:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43695:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43699:	48 8d 42 01          	lea    0x1(%rdx),%rax
   4369d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   436a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436a5:	48 8d 48 01          	lea    0x1(%rax),%rcx
   436a9:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   436ad:	0f b6 12             	movzbl (%rdx),%edx
   436b0:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   436b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436b6:	48 83 e8 01          	sub    $0x1,%rax
   436ba:	0f b6 00             	movzbl (%rax),%eax
   436bd:	84 c0                	test   %al,%al
   436bf:	75 d4                	jne    43695 <strcpy+0x1c>
    return dst;
   436c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   436c5:	c9                   	leave  
   436c6:	c3                   	ret    

00000000000436c7 <strcmp>:

int strcmp(const char* a, const char* b) {
   436c7:	f3 0f 1e fa          	endbr64 
   436cb:	55                   	push   %rbp
   436cc:	48 89 e5             	mov    %rsp,%rbp
   436cf:	48 83 ec 10          	sub    $0x10,%rsp
   436d3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   436d7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   436db:	eb 0a                	jmp    436e7 <strcmp+0x20>
        ++a, ++b;
   436dd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   436e2:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   436e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436eb:	0f b6 00             	movzbl (%rax),%eax
   436ee:	84 c0                	test   %al,%al
   436f0:	74 1d                	je     4370f <strcmp+0x48>
   436f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436f6:	0f b6 00             	movzbl (%rax),%eax
   436f9:	84 c0                	test   %al,%al
   436fb:	74 12                	je     4370f <strcmp+0x48>
   436fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43701:	0f b6 10             	movzbl (%rax),%edx
   43704:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43708:	0f b6 00             	movzbl (%rax),%eax
   4370b:	38 c2                	cmp    %al,%dl
   4370d:	74 ce                	je     436dd <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   4370f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43713:	0f b6 00             	movzbl (%rax),%eax
   43716:	89 c2                	mov    %eax,%edx
   43718:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4371c:	0f b6 00             	movzbl (%rax),%eax
   4371f:	38 c2                	cmp    %al,%dl
   43721:	0f 97 c0             	seta   %al
   43724:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43727:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4372b:	0f b6 00             	movzbl (%rax),%eax
   4372e:	89 c1                	mov    %eax,%ecx
   43730:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43734:	0f b6 00             	movzbl (%rax),%eax
   43737:	38 c1                	cmp    %al,%cl
   43739:	0f 92 c0             	setb   %al
   4373c:	0f b6 c8             	movzbl %al,%ecx
   4373f:	89 d0                	mov    %edx,%eax
   43741:	29 c8                	sub    %ecx,%eax
}
   43743:	c9                   	leave  
   43744:	c3                   	ret    

0000000000043745 <strchr>:

char* strchr(const char* s, int c) {
   43745:	f3 0f 1e fa          	endbr64 
   43749:	55                   	push   %rbp
   4374a:	48 89 e5             	mov    %rsp,%rbp
   4374d:	48 83 ec 10          	sub    $0x10,%rsp
   43751:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43755:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43758:	eb 05                	jmp    4375f <strchr+0x1a>
        ++s;
   4375a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   4375f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43763:	0f b6 00             	movzbl (%rax),%eax
   43766:	84 c0                	test   %al,%al
   43768:	74 0e                	je     43778 <strchr+0x33>
   4376a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4376e:	0f b6 00             	movzbl (%rax),%eax
   43771:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43774:	38 d0                	cmp    %dl,%al
   43776:	75 e2                	jne    4375a <strchr+0x15>
    }
    if (*s == (char) c) {
   43778:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4377c:	0f b6 00             	movzbl (%rax),%eax
   4377f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43782:	38 d0                	cmp    %dl,%al
   43784:	75 06                	jne    4378c <strchr+0x47>
        return (char*) s;
   43786:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4378a:	eb 05                	jmp    43791 <strchr+0x4c>
    } else {
        return NULL;
   4378c:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43791:	c9                   	leave  
   43792:	c3                   	ret    

0000000000043793 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43793:	f3 0f 1e fa          	endbr64 
   43797:	55                   	push   %rbp
   43798:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   4379b:	8b 05 5f 78 01 00    	mov    0x1785f(%rip),%eax        # 5b000 <rand_seed_set>
   437a1:	85 c0                	test   %eax,%eax
   437a3:	75 0a                	jne    437af <rand+0x1c>
        srand(819234718U);
   437a5:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   437aa:	e8 24 00 00 00       	call   437d3 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   437af:	8b 05 4f 78 01 00    	mov    0x1784f(%rip),%eax        # 5b004 <rand_seed>
   437b5:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   437bb:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   437c0:	89 05 3e 78 01 00    	mov    %eax,0x1783e(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   437c6:	8b 05 38 78 01 00    	mov    0x17838(%rip),%eax        # 5b004 <rand_seed>
   437cc:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   437d1:	5d                   	pop    %rbp
   437d2:	c3                   	ret    

00000000000437d3 <srand>:

void srand(unsigned seed) {
   437d3:	f3 0f 1e fa          	endbr64 
   437d7:	55                   	push   %rbp
   437d8:	48 89 e5             	mov    %rsp,%rbp
   437db:	48 83 ec 08          	sub    $0x8,%rsp
   437df:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   437e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   437e5:	89 05 19 78 01 00    	mov    %eax,0x17819(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   437eb:	c7 05 0b 78 01 00 01 	movl   $0x1,0x1780b(%rip)        # 5b000 <rand_seed_set>
   437f2:	00 00 00 
}
   437f5:	90                   	nop
   437f6:	c9                   	leave  
   437f7:	c3                   	ret    

00000000000437f8 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   437f8:	f3 0f 1e fa          	endbr64 
   437fc:	55                   	push   %rbp
   437fd:	48 89 e5             	mov    %rsp,%rbp
   43800:	48 83 ec 28          	sub    $0x28,%rsp
   43804:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43808:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4380c:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   4380f:	48 8d 05 ea 18 00 00 	lea    0x18ea(%rip),%rax        # 45100 <upper_digits.1>
   43816:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   4381a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4381e:	79 0e                	jns    4382e <fill_numbuf+0x36>
        digits = lower_digits;
   43820:	48 8d 05 f9 18 00 00 	lea    0x18f9(%rip),%rax        # 45120 <lower_digits.0>
   43827:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   4382b:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   4382e:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43833:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43837:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   4383a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4383d:	48 63 c8             	movslq %eax,%rcx
   43840:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43844:	ba 00 00 00 00       	mov    $0x0,%edx
   43849:	48 f7 f1             	div    %rcx
   4384c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43850:	48 01 d0             	add    %rdx,%rax
   43853:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43858:	0f b6 10             	movzbl (%rax),%edx
   4385b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4385f:	88 10                	mov    %dl,(%rax)
        val /= base;
   43861:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43864:	48 63 f0             	movslq %eax,%rsi
   43867:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4386b:	ba 00 00 00 00       	mov    $0x0,%edx
   43870:	48 f7 f6             	div    %rsi
   43873:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43877:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4387c:	75 bc                	jne    4383a <fill_numbuf+0x42>
    return numbuf_end;
   4387e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43882:	c9                   	leave  
   43883:	c3                   	ret    

0000000000043884 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43884:	f3 0f 1e fa          	endbr64 
   43888:	55                   	push   %rbp
   43889:	48 89 e5             	mov    %rsp,%rbp
   4388c:	53                   	push   %rbx
   4388d:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43894:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   4389b:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   438a1:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   438a8:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   438af:	e9 bd 09 00 00       	jmp    44271 <printer_vprintf+0x9ed>
        if (*format != '%') {
   438b4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   438bb:	0f b6 00             	movzbl (%rax),%eax
   438be:	3c 25                	cmp    $0x25,%al
   438c0:	74 31                	je     438f3 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   438c2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   438c9:	4c 8b 00             	mov    (%rax),%r8
   438cc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   438d3:	0f b6 00             	movzbl (%rax),%eax
   438d6:	0f b6 c8             	movzbl %al,%ecx
   438d9:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   438df:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   438e6:	89 ce                	mov    %ecx,%esi
   438e8:	48 89 c7             	mov    %rax,%rdi
   438eb:	41 ff d0             	call   *%r8
            continue;
   438ee:	e9 76 09 00 00       	jmp    44269 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   438f3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   438fa:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43901:	01 
   43902:	eb 4d                	jmp    43951 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   43904:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4390b:	0f b6 00             	movzbl (%rax),%eax
   4390e:	0f be c0             	movsbl %al,%eax
   43911:	89 c6                	mov    %eax,%esi
   43913:	48 8d 05 e6 16 00 00 	lea    0x16e6(%rip),%rax        # 45000 <flag_chars>
   4391a:	48 89 c7             	mov    %rax,%rdi
   4391d:	e8 23 fe ff ff       	call   43745 <strchr>
   43922:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43926:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   4392b:	74 34                	je     43961 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   4392d:	48 8d 15 cc 16 00 00 	lea    0x16cc(%rip),%rdx        # 45000 <flag_chars>
   43934:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43938:	48 29 d0             	sub    %rdx,%rax
   4393b:	ba 01 00 00 00       	mov    $0x1,%edx
   43940:	89 c1                	mov    %eax,%ecx
   43942:	d3 e2                	shl    %cl,%edx
   43944:	89 d0                	mov    %edx,%eax
   43946:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43949:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43950:	01 
   43951:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43958:	0f b6 00             	movzbl (%rax),%eax
   4395b:	84 c0                	test   %al,%al
   4395d:	75 a5                	jne    43904 <printer_vprintf+0x80>
   4395f:	eb 01                	jmp    43962 <printer_vprintf+0xde>
            } else {
                break;
   43961:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43962:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43969:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43970:	0f b6 00             	movzbl (%rax),%eax
   43973:	3c 30                	cmp    $0x30,%al
   43975:	7e 67                	jle    439de <printer_vprintf+0x15a>
   43977:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4397e:	0f b6 00             	movzbl (%rax),%eax
   43981:	3c 39                	cmp    $0x39,%al
   43983:	7f 59                	jg     439de <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43985:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   4398c:	eb 2e                	jmp    439bc <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   4398e:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43991:	89 d0                	mov    %edx,%eax
   43993:	c1 e0 02             	shl    $0x2,%eax
   43996:	01 d0                	add    %edx,%eax
   43998:	01 c0                	add    %eax,%eax
   4399a:	89 c1                	mov    %eax,%ecx
   4399c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439a3:	48 8d 50 01          	lea    0x1(%rax),%rdx
   439a7:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   439ae:	0f b6 00             	movzbl (%rax),%eax
   439b1:	0f be c0             	movsbl %al,%eax
   439b4:	01 c8                	add    %ecx,%eax
   439b6:	83 e8 30             	sub    $0x30,%eax
   439b9:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   439bc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439c3:	0f b6 00             	movzbl (%rax),%eax
   439c6:	3c 2f                	cmp    $0x2f,%al
   439c8:	0f 8e 85 00 00 00    	jle    43a53 <printer_vprintf+0x1cf>
   439ce:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439d5:	0f b6 00             	movzbl (%rax),%eax
   439d8:	3c 39                	cmp    $0x39,%al
   439da:	7e b2                	jle    4398e <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   439dc:	eb 75                	jmp    43a53 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   439de:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439e5:	0f b6 00             	movzbl (%rax),%eax
   439e8:	3c 2a                	cmp    $0x2a,%al
   439ea:	75 68                	jne    43a54 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   439ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439f3:	8b 00                	mov    (%rax),%eax
   439f5:	83 f8 2f             	cmp    $0x2f,%eax
   439f8:	77 30                	ja     43a2a <printer_vprintf+0x1a6>
   439fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a01:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43a05:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a0c:	8b 00                	mov    (%rax),%eax
   43a0e:	89 c0                	mov    %eax,%eax
   43a10:	48 01 d0             	add    %rdx,%rax
   43a13:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a1a:	8b 12                	mov    (%rdx),%edx
   43a1c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a1f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a26:	89 0a                	mov    %ecx,(%rdx)
   43a28:	eb 1a                	jmp    43a44 <printer_vprintf+0x1c0>
   43a2a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a31:	48 8b 40 08          	mov    0x8(%rax),%rax
   43a35:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43a39:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a40:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43a44:	8b 00                	mov    (%rax),%eax
   43a46:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43a49:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a50:	01 
   43a51:	eb 01                	jmp    43a54 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   43a53:	90                   	nop
        }

        // process precision
        int precision = -1;
   43a54:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43a5b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a62:	0f b6 00             	movzbl (%rax),%eax
   43a65:	3c 2e                	cmp    $0x2e,%al
   43a67:	0f 85 00 01 00 00    	jne    43b6d <printer_vprintf+0x2e9>
            ++format;
   43a6d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a74:	01 
            if (*format >= '0' && *format <= '9') {
   43a75:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a7c:	0f b6 00             	movzbl (%rax),%eax
   43a7f:	3c 2f                	cmp    $0x2f,%al
   43a81:	7e 67                	jle    43aea <printer_vprintf+0x266>
   43a83:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a8a:	0f b6 00             	movzbl (%rax),%eax
   43a8d:	3c 39                	cmp    $0x39,%al
   43a8f:	7f 59                	jg     43aea <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43a91:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43a98:	eb 2e                	jmp    43ac8 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   43a9a:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43a9d:	89 d0                	mov    %edx,%eax
   43a9f:	c1 e0 02             	shl    $0x2,%eax
   43aa2:	01 d0                	add    %edx,%eax
   43aa4:	01 c0                	add    %eax,%eax
   43aa6:	89 c1                	mov    %eax,%ecx
   43aa8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43aaf:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43ab3:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43aba:	0f b6 00             	movzbl (%rax),%eax
   43abd:	0f be c0             	movsbl %al,%eax
   43ac0:	01 c8                	add    %ecx,%eax
   43ac2:	83 e8 30             	sub    $0x30,%eax
   43ac5:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43ac8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43acf:	0f b6 00             	movzbl (%rax),%eax
   43ad2:	3c 2f                	cmp    $0x2f,%al
   43ad4:	0f 8e 85 00 00 00    	jle    43b5f <printer_vprintf+0x2db>
   43ada:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ae1:	0f b6 00             	movzbl (%rax),%eax
   43ae4:	3c 39                	cmp    $0x39,%al
   43ae6:	7e b2                	jle    43a9a <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   43ae8:	eb 75                	jmp    43b5f <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   43aea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43af1:	0f b6 00             	movzbl (%rax),%eax
   43af4:	3c 2a                	cmp    $0x2a,%al
   43af6:	75 68                	jne    43b60 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   43af8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43aff:	8b 00                	mov    (%rax),%eax
   43b01:	83 f8 2f             	cmp    $0x2f,%eax
   43b04:	77 30                	ja     43b36 <printer_vprintf+0x2b2>
   43b06:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b0d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b11:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b18:	8b 00                	mov    (%rax),%eax
   43b1a:	89 c0                	mov    %eax,%eax
   43b1c:	48 01 d0             	add    %rdx,%rax
   43b1f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b26:	8b 12                	mov    (%rdx),%edx
   43b28:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b2b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b32:	89 0a                	mov    %ecx,(%rdx)
   43b34:	eb 1a                	jmp    43b50 <printer_vprintf+0x2cc>
   43b36:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b3d:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b41:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b45:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b4c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b50:	8b 00                	mov    (%rax),%eax
   43b52:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43b55:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43b5c:	01 
   43b5d:	eb 01                	jmp    43b60 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   43b5f:	90                   	nop
            }
            if (precision < 0) {
   43b60:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43b64:	79 07                	jns    43b6d <printer_vprintf+0x2e9>
                precision = 0;
   43b66:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43b6d:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43b74:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43b7b:	00 
        int length = 0;
   43b7c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43b83:	48 8d 05 7c 14 00 00 	lea    0x147c(%rip),%rax        # 45006 <flag_chars+0x6>
   43b8a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   43b8e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b95:	0f b6 00             	movzbl (%rax),%eax
   43b98:	0f be c0             	movsbl %al,%eax
   43b9b:	83 e8 43             	sub    $0x43,%eax
   43b9e:	83 f8 37             	cmp    $0x37,%eax
   43ba1:	0f 87 b6 03 00 00    	ja     43f5d <printer_vprintf+0x6d9>
   43ba7:	89 c0                	mov    %eax,%eax
   43ba9:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   43bb0:	00 
   43bb1:	48 8d 05 5c 14 00 00 	lea    0x145c(%rip),%rax        # 45014 <flag_chars+0x14>
   43bb8:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   43bbb:	48 98                	cltq   
   43bbd:	48 8d 15 50 14 00 00 	lea    0x1450(%rip),%rdx        # 45014 <flag_chars+0x14>
   43bc4:	48 01 d0             	add    %rdx,%rax
   43bc7:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   43bca:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43bd1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43bd8:	01 
            goto again;
   43bd9:	eb b3                	jmp    43b8e <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43bdb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43bdf:	74 5d                	je     43c3e <printer_vprintf+0x3ba>
   43be1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43be8:	8b 00                	mov    (%rax),%eax
   43bea:	83 f8 2f             	cmp    $0x2f,%eax
   43bed:	77 30                	ja     43c1f <printer_vprintf+0x39b>
   43bef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bf6:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43bfa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c01:	8b 00                	mov    (%rax),%eax
   43c03:	89 c0                	mov    %eax,%eax
   43c05:	48 01 d0             	add    %rdx,%rax
   43c08:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c0f:	8b 12                	mov    (%rdx),%edx
   43c11:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c14:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c1b:	89 0a                	mov    %ecx,(%rdx)
   43c1d:	eb 1a                	jmp    43c39 <printer_vprintf+0x3b5>
   43c1f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c26:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c2a:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c2e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c35:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c39:	48 8b 00             	mov    (%rax),%rax
   43c3c:	eb 5c                	jmp    43c9a <printer_vprintf+0x416>
   43c3e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c45:	8b 00                	mov    (%rax),%eax
   43c47:	83 f8 2f             	cmp    $0x2f,%eax
   43c4a:	77 30                	ja     43c7c <printer_vprintf+0x3f8>
   43c4c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c53:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c5e:	8b 00                	mov    (%rax),%eax
   43c60:	89 c0                	mov    %eax,%eax
   43c62:	48 01 d0             	add    %rdx,%rax
   43c65:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c6c:	8b 12                	mov    (%rdx),%edx
   43c6e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c71:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c78:	89 0a                	mov    %ecx,(%rdx)
   43c7a:	eb 1a                	jmp    43c96 <printer_vprintf+0x412>
   43c7c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c83:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c87:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c8b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c92:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c96:	8b 00                	mov    (%rax),%eax
   43c98:	48 98                	cltq   
   43c9a:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43c9e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43ca2:	48 c1 f8 38          	sar    $0x38,%rax
   43ca6:	25 80 00 00 00       	and    $0x80,%eax
   43cab:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43cae:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43cb2:	74 09                	je     43cbd <printer_vprintf+0x439>
   43cb4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43cb8:	48 f7 d8             	neg    %rax
   43cbb:	eb 04                	jmp    43cc1 <printer_vprintf+0x43d>
   43cbd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43cc1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43cc5:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43cc8:	83 c8 60             	or     $0x60,%eax
   43ccb:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43cce:	e9 cf 02 00 00       	jmp    43fa2 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43cd3:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43cd7:	74 5d                	je     43d36 <printer_vprintf+0x4b2>
   43cd9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ce0:	8b 00                	mov    (%rax),%eax
   43ce2:	83 f8 2f             	cmp    $0x2f,%eax
   43ce5:	77 30                	ja     43d17 <printer_vprintf+0x493>
   43ce7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cee:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43cf2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cf9:	8b 00                	mov    (%rax),%eax
   43cfb:	89 c0                	mov    %eax,%eax
   43cfd:	48 01 d0             	add    %rdx,%rax
   43d00:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d07:	8b 12                	mov    (%rdx),%edx
   43d09:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d13:	89 0a                	mov    %ecx,(%rdx)
   43d15:	eb 1a                	jmp    43d31 <printer_vprintf+0x4ad>
   43d17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d1e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d22:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d26:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d2d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d31:	48 8b 00             	mov    (%rax),%rax
   43d34:	eb 5c                	jmp    43d92 <printer_vprintf+0x50e>
   43d36:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d3d:	8b 00                	mov    (%rax),%eax
   43d3f:	83 f8 2f             	cmp    $0x2f,%eax
   43d42:	77 30                	ja     43d74 <printer_vprintf+0x4f0>
   43d44:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d4b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d4f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d56:	8b 00                	mov    (%rax),%eax
   43d58:	89 c0                	mov    %eax,%eax
   43d5a:	48 01 d0             	add    %rdx,%rax
   43d5d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d64:	8b 12                	mov    (%rdx),%edx
   43d66:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d69:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d70:	89 0a                	mov    %ecx,(%rdx)
   43d72:	eb 1a                	jmp    43d8e <printer_vprintf+0x50a>
   43d74:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d7b:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d7f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d83:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d8a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d8e:	8b 00                	mov    (%rax),%eax
   43d90:	89 c0                	mov    %eax,%eax
   43d92:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43d96:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43d9a:	e9 03 02 00 00       	jmp    43fa2 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   43d9f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43da6:	e9 28 ff ff ff       	jmp    43cd3 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   43dab:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43db2:	e9 1c ff ff ff       	jmp    43cd3 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43db7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dbe:	8b 00                	mov    (%rax),%eax
   43dc0:	83 f8 2f             	cmp    $0x2f,%eax
   43dc3:	77 30                	ja     43df5 <printer_vprintf+0x571>
   43dc5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dcc:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43dd0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dd7:	8b 00                	mov    (%rax),%eax
   43dd9:	89 c0                	mov    %eax,%eax
   43ddb:	48 01 d0             	add    %rdx,%rax
   43dde:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43de5:	8b 12                	mov    (%rdx),%edx
   43de7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43dea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43df1:	89 0a                	mov    %ecx,(%rdx)
   43df3:	eb 1a                	jmp    43e0f <printer_vprintf+0x58b>
   43df5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dfc:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e00:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e04:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e0b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e0f:	48 8b 00             	mov    (%rax),%rax
   43e12:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43e16:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43e1d:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43e24:	e9 79 01 00 00       	jmp    43fa2 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   43e29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e30:	8b 00                	mov    (%rax),%eax
   43e32:	83 f8 2f             	cmp    $0x2f,%eax
   43e35:	77 30                	ja     43e67 <printer_vprintf+0x5e3>
   43e37:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e3e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e49:	8b 00                	mov    (%rax),%eax
   43e4b:	89 c0                	mov    %eax,%eax
   43e4d:	48 01 d0             	add    %rdx,%rax
   43e50:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e57:	8b 12                	mov    (%rdx),%edx
   43e59:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e5c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e63:	89 0a                	mov    %ecx,(%rdx)
   43e65:	eb 1a                	jmp    43e81 <printer_vprintf+0x5fd>
   43e67:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e6e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e72:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e76:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e7d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e81:	48 8b 00             	mov    (%rax),%rax
   43e84:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43e88:	e9 15 01 00 00       	jmp    43fa2 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   43e8d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e94:	8b 00                	mov    (%rax),%eax
   43e96:	83 f8 2f             	cmp    $0x2f,%eax
   43e99:	77 30                	ja     43ecb <printer_vprintf+0x647>
   43e9b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ea2:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ea6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ead:	8b 00                	mov    (%rax),%eax
   43eaf:	89 c0                	mov    %eax,%eax
   43eb1:	48 01 d0             	add    %rdx,%rax
   43eb4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ebb:	8b 12                	mov    (%rdx),%edx
   43ebd:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43ec0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ec7:	89 0a                	mov    %ecx,(%rdx)
   43ec9:	eb 1a                	jmp    43ee5 <printer_vprintf+0x661>
   43ecb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ed2:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ed6:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43eda:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ee1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ee5:	8b 00                	mov    (%rax),%eax
   43ee7:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43eed:	e9 77 03 00 00       	jmp    44269 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   43ef2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43ef6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43efa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f01:	8b 00                	mov    (%rax),%eax
   43f03:	83 f8 2f             	cmp    $0x2f,%eax
   43f06:	77 30                	ja     43f38 <printer_vprintf+0x6b4>
   43f08:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f0f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f13:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f1a:	8b 00                	mov    (%rax),%eax
   43f1c:	89 c0                	mov    %eax,%eax
   43f1e:	48 01 d0             	add    %rdx,%rax
   43f21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f28:	8b 12                	mov    (%rdx),%edx
   43f2a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f2d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f34:	89 0a                	mov    %ecx,(%rdx)
   43f36:	eb 1a                	jmp    43f52 <printer_vprintf+0x6ce>
   43f38:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f3f:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f43:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f47:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f4e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f52:	8b 00                	mov    (%rax),%eax
   43f54:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43f57:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43f5b:	eb 45                	jmp    43fa2 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   43f5d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43f61:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43f65:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f6c:	0f b6 00             	movzbl (%rax),%eax
   43f6f:	84 c0                	test   %al,%al
   43f71:	74 0c                	je     43f7f <printer_vprintf+0x6fb>
   43f73:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f7a:	0f b6 00             	movzbl (%rax),%eax
   43f7d:	eb 05                	jmp    43f84 <printer_vprintf+0x700>
   43f7f:	b8 25 00 00 00       	mov    $0x25,%eax
   43f84:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43f87:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43f8b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f92:	0f b6 00             	movzbl (%rax),%eax
   43f95:	84 c0                	test   %al,%al
   43f97:	75 08                	jne    43fa1 <printer_vprintf+0x71d>
                format--;
   43f99:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43fa0:	01 
            }
            break;
   43fa1:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43fa2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fa5:	83 e0 20             	and    $0x20,%eax
   43fa8:	85 c0                	test   %eax,%eax
   43faa:	74 1e                	je     43fca <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43fac:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43fb0:	48 83 c0 18          	add    $0x18,%rax
   43fb4:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43fb7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43fbb:	48 89 ce             	mov    %rcx,%rsi
   43fbe:	48 89 c7             	mov    %rax,%rdi
   43fc1:	e8 32 f8 ff ff       	call   437f8 <fill_numbuf>
   43fc6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43fca:	48 8d 05 35 10 00 00 	lea    0x1035(%rip),%rax        # 45006 <flag_chars+0x6>
   43fd1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43fd5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fd8:	83 e0 20             	and    $0x20,%eax
   43fdb:	85 c0                	test   %eax,%eax
   43fdd:	74 51                	je     44030 <printer_vprintf+0x7ac>
   43fdf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fe2:	83 e0 40             	and    $0x40,%eax
   43fe5:	85 c0                	test   %eax,%eax
   43fe7:	74 47                	je     44030 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   43fe9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fec:	25 80 00 00 00       	and    $0x80,%eax
   43ff1:	85 c0                	test   %eax,%eax
   43ff3:	74 0d                	je     44002 <printer_vprintf+0x77e>
                prefix = "-";
   43ff5:	48 8d 05 0b 10 00 00 	lea    0x100b(%rip),%rax        # 45007 <flag_chars+0x7>
   43ffc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44000:	eb 7d                	jmp    4407f <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44002:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44005:	83 e0 10             	and    $0x10,%eax
   44008:	85 c0                	test   %eax,%eax
   4400a:	74 0d                	je     44019 <printer_vprintf+0x795>
                prefix = "+";
   4400c:	48 8d 05 f6 0f 00 00 	lea    0xff6(%rip),%rax        # 45009 <flag_chars+0x9>
   44013:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44017:	eb 66                	jmp    4407f <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44019:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4401c:	83 e0 08             	and    $0x8,%eax
   4401f:	85 c0                	test   %eax,%eax
   44021:	74 5c                	je     4407f <printer_vprintf+0x7fb>
                prefix = " ";
   44023:	48 8d 05 e1 0f 00 00 	lea    0xfe1(%rip),%rax        # 4500b <flag_chars+0xb>
   4402a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   4402e:	eb 4f                	jmp    4407f <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44030:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44033:	83 e0 20             	and    $0x20,%eax
   44036:	85 c0                	test   %eax,%eax
   44038:	74 46                	je     44080 <printer_vprintf+0x7fc>
   4403a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4403d:	83 e0 01             	and    $0x1,%eax
   44040:	85 c0                	test   %eax,%eax
   44042:	74 3c                	je     44080 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   44044:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   44048:	74 06                	je     44050 <printer_vprintf+0x7cc>
   4404a:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4404e:	75 30                	jne    44080 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   44050:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44055:	75 0c                	jne    44063 <printer_vprintf+0x7df>
   44057:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4405a:	25 00 01 00 00       	and    $0x100,%eax
   4405f:	85 c0                	test   %eax,%eax
   44061:	74 1d                	je     44080 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   44063:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44067:	75 09                	jne    44072 <printer_vprintf+0x7ee>
   44069:	48 8d 05 9d 0f 00 00 	lea    0xf9d(%rip),%rax        # 4500d <flag_chars+0xd>
   44070:	eb 07                	jmp    44079 <printer_vprintf+0x7f5>
   44072:	48 8d 05 97 0f 00 00 	lea    0xf97(%rip),%rax        # 45010 <flag_chars+0x10>
   44079:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4407d:	eb 01                	jmp    44080 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   4407f:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44080:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44084:	78 24                	js     440aa <printer_vprintf+0x826>
   44086:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44089:	83 e0 20             	and    $0x20,%eax
   4408c:	85 c0                	test   %eax,%eax
   4408e:	75 1a                	jne    440aa <printer_vprintf+0x826>
            len = strnlen(data, precision);
   44090:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44093:	48 63 d0             	movslq %eax,%rdx
   44096:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4409a:	48 89 d6             	mov    %rdx,%rsi
   4409d:	48 89 c7             	mov    %rax,%rdi
   440a0:	e8 91 f5 ff ff       	call   43636 <strnlen>
   440a5:	89 45 bc             	mov    %eax,-0x44(%rbp)
   440a8:	eb 0f                	jmp    440b9 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   440aa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   440ae:	48 89 c7             	mov    %rax,%rdi
   440b1:	e8 4b f5 ff ff       	call   43601 <strlen>
   440b6:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   440b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440bc:	83 e0 20             	and    $0x20,%eax
   440bf:	85 c0                	test   %eax,%eax
   440c1:	74 20                	je     440e3 <printer_vprintf+0x85f>
   440c3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   440c7:	78 1a                	js     440e3 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   440c9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   440cc:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   440cf:	7e 08                	jle    440d9 <printer_vprintf+0x855>
   440d1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   440d4:	2b 45 bc             	sub    -0x44(%rbp),%eax
   440d7:	eb 05                	jmp    440de <printer_vprintf+0x85a>
   440d9:	b8 00 00 00 00       	mov    $0x0,%eax
   440de:	89 45 b8             	mov    %eax,-0x48(%rbp)
   440e1:	eb 5c                	jmp    4413f <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   440e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440e6:	83 e0 20             	and    $0x20,%eax
   440e9:	85 c0                	test   %eax,%eax
   440eb:	74 4b                	je     44138 <printer_vprintf+0x8b4>
   440ed:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440f0:	83 e0 02             	and    $0x2,%eax
   440f3:	85 c0                	test   %eax,%eax
   440f5:	74 41                	je     44138 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   440f7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440fa:	83 e0 04             	and    $0x4,%eax
   440fd:	85 c0                	test   %eax,%eax
   440ff:	75 37                	jne    44138 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   44101:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44105:	48 89 c7             	mov    %rax,%rdi
   44108:	e8 f4 f4 ff ff       	call   43601 <strlen>
   4410d:	89 c2                	mov    %eax,%edx
   4410f:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44112:	01 d0                	add    %edx,%eax
   44114:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44117:	7e 1f                	jle    44138 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   44119:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4411c:	2b 45 bc             	sub    -0x44(%rbp),%eax
   4411f:	89 c3                	mov    %eax,%ebx
   44121:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44125:	48 89 c7             	mov    %rax,%rdi
   44128:	e8 d4 f4 ff ff       	call   43601 <strlen>
   4412d:	89 c2                	mov    %eax,%edx
   4412f:	89 d8                	mov    %ebx,%eax
   44131:	29 d0                	sub    %edx,%eax
   44133:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44136:	eb 07                	jmp    4413f <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   44138:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   4413f:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44142:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44145:	01 d0                	add    %edx,%eax
   44147:	48 63 d8             	movslq %eax,%rbx
   4414a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4414e:	48 89 c7             	mov    %rax,%rdi
   44151:	e8 ab f4 ff ff       	call   43601 <strlen>
   44156:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   4415a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4415d:	29 d0                	sub    %edx,%eax
   4415f:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44162:	eb 25                	jmp    44189 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   44164:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4416b:	48 8b 08             	mov    (%rax),%rcx
   4416e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44174:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4417b:	be 20 00 00 00       	mov    $0x20,%esi
   44180:	48 89 c7             	mov    %rax,%rdi
   44183:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44185:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44189:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4418c:	83 e0 04             	and    $0x4,%eax
   4418f:	85 c0                	test   %eax,%eax
   44191:	75 36                	jne    441c9 <printer_vprintf+0x945>
   44193:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44197:	7f cb                	jg     44164 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   44199:	eb 2e                	jmp    441c9 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   4419b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441a2:	4c 8b 00             	mov    (%rax),%r8
   441a5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   441a9:	0f b6 00             	movzbl (%rax),%eax
   441ac:	0f b6 c8             	movzbl %al,%ecx
   441af:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   441b5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441bc:	89 ce                	mov    %ecx,%esi
   441be:	48 89 c7             	mov    %rax,%rdi
   441c1:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   441c4:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   441c9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   441cd:	0f b6 00             	movzbl (%rax),%eax
   441d0:	84 c0                	test   %al,%al
   441d2:	75 c7                	jne    4419b <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   441d4:	eb 25                	jmp    441fb <printer_vprintf+0x977>
            p->putc(p, '0', color);
   441d6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441dd:	48 8b 08             	mov    (%rax),%rcx
   441e0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   441e6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441ed:	be 30 00 00 00       	mov    $0x30,%esi
   441f2:	48 89 c7             	mov    %rax,%rdi
   441f5:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   441f7:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   441fb:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   441ff:	7f d5                	jg     441d6 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   44201:	eb 32                	jmp    44235 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   44203:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4420a:	4c 8b 00             	mov    (%rax),%r8
   4420d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44211:	0f b6 00             	movzbl (%rax),%eax
   44214:	0f b6 c8             	movzbl %al,%ecx
   44217:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4421d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44224:	89 ce                	mov    %ecx,%esi
   44226:	48 89 c7             	mov    %rax,%rdi
   44229:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   4422c:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44231:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44235:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44239:	7f c8                	jg     44203 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   4423b:	eb 25                	jmp    44262 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   4423d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44244:	48 8b 08             	mov    (%rax),%rcx
   44247:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4424d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44254:	be 20 00 00 00       	mov    $0x20,%esi
   44259:	48 89 c7             	mov    %rax,%rdi
   4425c:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   4425e:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44262:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44266:	7f d5                	jg     4423d <printer_vprintf+0x9b9>
        }
    done: ;
   44268:	90                   	nop
    for (; *format; ++format) {
   44269:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44270:	01 
   44271:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44278:	0f b6 00             	movzbl (%rax),%eax
   4427b:	84 c0                	test   %al,%al
   4427d:	0f 85 31 f6 ff ff    	jne    438b4 <printer_vprintf+0x30>
    }
}
   44283:	90                   	nop
   44284:	90                   	nop
   44285:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44289:	c9                   	leave  
   4428a:	c3                   	ret    

000000000004428b <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4428b:	f3 0f 1e fa          	endbr64 
   4428f:	55                   	push   %rbp
   44290:	48 89 e5             	mov    %rsp,%rbp
   44293:	48 83 ec 20          	sub    $0x20,%rsp
   44297:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4429b:	89 f0                	mov    %esi,%eax
   4429d:	89 55 e0             	mov    %edx,-0x20(%rbp)
   442a0:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   442a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   442a7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   442ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442af:	48 8b 40 08          	mov    0x8(%rax),%rax
   442b3:	48 8d 15 e6 4c 07 00 	lea    0x74ce6(%rip),%rdx        # b8fa0 <console+0xfa0>
   442ba:	48 39 d0             	cmp    %rdx,%rax
   442bd:	72 0f                	jb     442ce <console_putc+0x43>
        cp->cursor = console;
   442bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442c3:	48 8d 15 36 3d 07 00 	lea    0x73d36(%rip),%rdx        # b8000 <console>
   442ca:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   442ce:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   442d2:	0f 85 82 00 00 00    	jne    4435a <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   442d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442dc:	48 8b 40 08          	mov    0x8(%rax),%rax
   442e0:	48 8d 15 19 3d 07 00 	lea    0x73d19(%rip),%rdx        # b8000 <console>
   442e7:	48 29 d0             	sub    %rdx,%rax
   442ea:	48 d1 f8             	sar    %rax
   442ed:	48 89 c1             	mov    %rax,%rcx
   442f0:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   442f7:	66 66 66 
   442fa:	48 89 c8             	mov    %rcx,%rax
   442fd:	48 f7 ea             	imul   %rdx
   44300:	48 89 d0             	mov    %rdx,%rax
   44303:	48 c1 f8 05          	sar    $0x5,%rax
   44307:	48 89 ce             	mov    %rcx,%rsi
   4430a:	48 c1 fe 3f          	sar    $0x3f,%rsi
   4430e:	48 29 f0             	sub    %rsi,%rax
   44311:	48 89 c2             	mov    %rax,%rdx
   44314:	48 89 d0             	mov    %rdx,%rax
   44317:	48 c1 e0 02          	shl    $0x2,%rax
   4431b:	48 01 d0             	add    %rdx,%rax
   4431e:	48 c1 e0 04          	shl    $0x4,%rax
   44322:	48 29 c1             	sub    %rax,%rcx
   44325:	48 89 ca             	mov    %rcx,%rdx
   44328:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   4432b:	eb 25                	jmp    44352 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   4432d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44330:	83 c8 20             	or     $0x20,%eax
   44333:	89 c6                	mov    %eax,%esi
   44335:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44339:	48 8b 40 08          	mov    0x8(%rax),%rax
   4433d:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44341:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44345:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44349:	89 f2                	mov    %esi,%edx
   4434b:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   4434e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44352:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44356:	75 d5                	jne    4432d <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44358:	eb 24                	jmp    4437e <console_putc+0xf3>
        *cp->cursor++ = c | color;
   4435a:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   4435e:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44361:	89 d6                	mov    %edx,%esi
   44363:	09 c6                	or     %eax,%esi
   44365:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44369:	48 8b 40 08          	mov    0x8(%rax),%rax
   4436d:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44371:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44375:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44379:	89 f2                	mov    %esi,%edx
   4437b:	66 89 10             	mov    %dx,(%rax)
}
   4437e:	90                   	nop
   4437f:	c9                   	leave  
   44380:	c3                   	ret    

0000000000044381 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44381:	f3 0f 1e fa          	endbr64 
   44385:	55                   	push   %rbp
   44386:	48 89 e5             	mov    %rsp,%rbp
   44389:	48 83 ec 30          	sub    $0x30,%rsp
   4438d:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44390:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44393:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44397:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   4439b:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 4428b <console_putc>
   443a2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   443a6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   443aa:	78 09                	js     443b5 <console_vprintf+0x34>
   443ac:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   443b3:	7e 07                	jle    443bc <console_vprintf+0x3b>
        cpos = 0;
   443b5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   443bc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443bf:	48 98                	cltq   
   443c1:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   443c5:	48 8d 05 34 3c 07 00 	lea    0x73c34(%rip),%rax        # b8000 <console>
   443cc:	48 01 d0             	add    %rdx,%rax
   443cf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   443d3:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   443d7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   443db:	8b 75 e8             	mov    -0x18(%rbp),%esi
   443de:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   443e2:	48 89 c7             	mov    %rax,%rdi
   443e5:	e8 9a f4 ff ff       	call   43884 <printer_vprintf>
    return cp.cursor - console;
   443ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   443ee:	48 8d 15 0b 3c 07 00 	lea    0x73c0b(%rip),%rdx        # b8000 <console>
   443f5:	48 29 d0             	sub    %rdx,%rax
   443f8:	48 d1 f8             	sar    %rax
}
   443fb:	c9                   	leave  
   443fc:	c3                   	ret    

00000000000443fd <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   443fd:	f3 0f 1e fa          	endbr64 
   44401:	55                   	push   %rbp
   44402:	48 89 e5             	mov    %rsp,%rbp
   44405:	48 83 ec 60          	sub    $0x60,%rsp
   44409:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4440c:	89 75 a8             	mov    %esi,-0x58(%rbp)
   4440f:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44413:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44417:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4441b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4441f:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44426:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4442a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4442e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44432:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44436:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4443a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4443e:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44441:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44444:	89 c7                	mov    %eax,%edi
   44446:	e8 36 ff ff ff       	call   44381 <console_vprintf>
   4444b:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4444e:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44451:	c9                   	leave  
   44452:	c3                   	ret    

0000000000044453 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44453:	f3 0f 1e fa          	endbr64 
   44457:	55                   	push   %rbp
   44458:	48 89 e5             	mov    %rsp,%rbp
   4445b:	48 83 ec 20          	sub    $0x20,%rsp
   4445f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44463:	89 f0                	mov    %esi,%eax
   44465:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44468:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   4446b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4446f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44473:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44477:	48 8b 50 08          	mov    0x8(%rax),%rdx
   4447b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4447f:	48 8b 40 10          	mov    0x10(%rax),%rax
   44483:	48 39 c2             	cmp    %rax,%rdx
   44486:	73 1a                	jae    444a2 <string_putc+0x4f>
        *sp->s++ = c;
   44488:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4448c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44490:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44494:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44498:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4449c:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   444a0:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   444a2:	90                   	nop
   444a3:	c9                   	leave  
   444a4:	c3                   	ret    

00000000000444a5 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   444a5:	f3 0f 1e fa          	endbr64 
   444a9:	55                   	push   %rbp
   444aa:	48 89 e5             	mov    %rsp,%rbp
   444ad:	48 83 ec 40          	sub    $0x40,%rsp
   444b1:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   444b5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   444b9:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   444bd:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   444c1:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 44453 <string_putc>
   444c8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   444cc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   444d0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   444d4:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   444d9:	74 33                	je     4450e <vsnprintf+0x69>
        sp.end = s + size - 1;
   444db:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   444df:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   444e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   444e7:	48 01 d0             	add    %rdx,%rax
   444ea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   444ee:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   444f2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   444f6:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   444fa:	be 00 00 00 00       	mov    $0x0,%esi
   444ff:	48 89 c7             	mov    %rax,%rdi
   44502:	e8 7d f3 ff ff       	call   43884 <printer_vprintf>
        *sp.s = 0;
   44507:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4450b:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   4450e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44512:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44516:	c9                   	leave  
   44517:	c3                   	ret    

0000000000044518 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44518:	f3 0f 1e fa          	endbr64 
   4451c:	55                   	push   %rbp
   4451d:	48 89 e5             	mov    %rsp,%rbp
   44520:	48 83 ec 70          	sub    $0x70,%rsp
   44524:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44528:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   4452c:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44530:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44534:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44538:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4453c:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44543:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44547:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   4454b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4454f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44553:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44557:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   4455b:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   4455f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44563:	48 89 c7             	mov    %rax,%rdi
   44566:	e8 3a ff ff ff       	call   444a5 <vsnprintf>
   4456b:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   4456e:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44571:	c9                   	leave  
   44572:	c3                   	ret    

0000000000044573 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44573:	f3 0f 1e fa          	endbr64 
   44577:	55                   	push   %rbp
   44578:	48 89 e5             	mov    %rsp,%rbp
   4457b:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4457f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44586:	eb 1a                	jmp    445a2 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   44588:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4458b:	48 98                	cltq   
   4458d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44591:	48 8d 05 68 3a 07 00 	lea    0x73a68(%rip),%rax        # b8000 <console>
   44598:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4459e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   445a2:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   445a9:	7e dd                	jle    44588 <console_clear+0x15>
    }
    cursorpos = 0;
   445ab:	c7 05 47 4a 07 00 00 	movl   $0x0,0x74a47(%rip)        # b8ffc <cursorpos>
   445b2:	00 00 00 
}
   445b5:	90                   	nop
   445b6:	c9                   	leave  
   445b7:	c3                   	ret    
