
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
   400be:	e8 0d 08 00 00       	call   408d0 <exception>

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
   40177:	e8 8a 1a 00 00       	call   41c06 <hardware_init>
    pageinfo_init();
   4017c:	e8 8a 0f 00 00       	call   4110b <pageinfo_init>
    console_clear();
   40181:	e8 1b 47 00 00       	call   448a1 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 de 1f 00 00       	call   4216e <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 7f 2e 01 00 	lea    0x12e7f(%rip),%rax        # 53020 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 43 37 00 00       	call   438ec <memset>
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
   401c9:	48 8d 15 50 2e 01 00 	lea    0x12e50(%rip),%rdx        # 53020 <processes>
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
   401ed:	48 8d 05 f4 2e 01 00 	lea    0x12ef4(%rip),%rax        # 530e8 <processes+0xc8>
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
   40210:	48 8d 15 e9 46 00 00 	lea    0x46e9(%rip),%rdx        # 44900 <console_clear+0x5f>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 d3 37 00 00       	call   439f5 <strcmp>
   40222:	85 c0                	test   %eax,%eax
   40224:	75 14                	jne    4023a <kernel+0xd3>
        process_setup(1, 4);
   40226:	be 04 00 00 00       	mov    $0x4,%esi
   4022b:	bf 01 00 00 00       	mov    $0x1,%edi
   40230:	e8 6c 03 00 00       	call   405a1 <process_setup>
   40235:	e9 d1 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4023a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4023f:	74 2e                	je     4026f <kernel+0x108>
   40241:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40245:	48 8d 15 b9 46 00 00 	lea    0x46b9(%rip),%rdx        # 44905 <console_clear+0x64>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 9e 37 00 00       	call   439f5 <strcmp>
   40257:	85 c0                	test   %eax,%eax
   40259:	75 14                	jne    4026f <kernel+0x108>
        process_setup(1, 5);
   4025b:	be 05 00 00 00       	mov    $0x5,%esi
   40260:	bf 01 00 00 00       	mov    $0x1,%edi
   40265:	e8 37 03 00 00       	call   405a1 <process_setup>
   4026a:	e9 9c 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test") == 0) {
   4026f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40274:	74 2b                	je     402a1 <kernel+0x13a>
   40276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4027a:	48 8d 15 8d 46 00 00 	lea    0x468d(%rip),%rdx        # 4490e <console_clear+0x6d>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 69 37 00 00       	call   439f5 <strcmp>
   4028c:	85 c0                	test   %eax,%eax
   4028e:	75 11                	jne    402a1 <kernel+0x13a>
        process_setup(1, 6);
   40290:	be 06 00 00 00       	mov    $0x6,%esi
   40295:	bf 01 00 00 00       	mov    $0x1,%edi
   4029a:	e8 02 03 00 00       	call   405a1 <process_setup>
   4029f:	eb 6a                	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test2") == 0) {
   402a1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a6:	74 3e                	je     402e6 <kernel+0x17f>
   402a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402ac:	48 8d 15 60 46 00 00 	lea    0x4660(%rip),%rdx        # 44913 <console_clear+0x72>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 37 37 00 00       	call   439f5 <strcmp>
   402be:	85 c0                	test   %eax,%eax
   402c0:	75 24                	jne    402e6 <kernel+0x17f>
        for (pid_t i = 1; i <= 2; ++i) {
   402c2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402c9:	eb 13                	jmp    402de <kernel+0x177>
            process_setup(i, 6);
   402cb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402ce:	be 06 00 00 00       	mov    $0x6,%esi
   402d3:	89 c7                	mov    %eax,%edi
   402d5:	e8 c7 02 00 00       	call   405a1 <process_setup>
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
   402fc:	e8 a0 02 00 00       	call   405a1 <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   40301:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40305:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   40309:	7e e4                	jle    402ef <kernel+0x188>
        }
    }
virtual_memory_map(kernel_pagetable, 0, 0,
   4030b:	48 8b 05 ee 5c 01 00 	mov    0x15cee(%rip),%rax        # 56000 <kernel_pagetable>
   40312:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40318:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4031d:	ba 00 00 00 00       	mov    $0x0,%edx
   40322:	be 00 00 00 00       	mov    $0x0,%esi
   40327:	48 89 c7             	mov    %rax,%rdi
   4032a:	e8 ac 2c 00 00       	call   42fdb <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   4032f:	48 8d 15 ca 7c 07 00 	lea    0x77cca(%rip),%rdx        # b8000 <console>
   40336:	48 8d 35 c3 7c 07 00 	lea    0x77cc3(%rip),%rsi        # b8000 <console>
   4033d:	48 8b 05 bc 5c 01 00 	mov    0x15cbc(%rip),%rax        # 56000 <kernel_pagetable>
   40344:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4034a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4034f:	48 89 c7             	mov    %rax,%rdi
   40352:	e8 84 2c 00 00       	call   42fdb <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    // Switch to the first process using run()
    run(&processes[1]);
   40357:	48 8d 05 a2 2d 01 00 	lea    0x12da2(%rip),%rax        # 53100 <processes+0xe0>
   4035e:	48 89 c7             	mov    %rax,%rdi
   40361:	e8 3a 0d 00 00       	call   410a0 <run>

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
   40395:	48 8d 05 a5 3a 01 00 	lea    0x13aa5(%rip),%rax        # 53e41 <pageinfo+0x1>
   4039c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   403a0:	84 c0                	test   %al,%al
   403a2:	75 47                	jne    403eb <reserve_page+0x85>
            pageinfo[pn].owner = owner;
   403a4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   403a7:	48 98                	cltq   
   403a9:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   403ad:	48 8d 15 8c 3a 01 00 	lea    0x13a8c(%rip),%rdx        # 53e40 <pageinfo>
   403b4:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
   403b8:	88 04 11             	mov    %al,(%rcx,%rdx,1)
            pageinfo[pn].refcount = 1;
   403bb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   403be:	48 98                	cltq   
   403c0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   403c4:	48 8d 05 76 3a 01 00 	lea    0x13a76(%rip),%rax        # 53e41 <pageinfo+0x1>
   403cb:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
            memset((void*) addr, 0, PAGESIZE);
   403cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403d3:	ba 00 10 00 00       	mov    $0x1000,%edx
   403d8:	be 00 00 00 00       	mov    $0x0,%esi
   403dd:	48 89 c7             	mov    %rax,%rdi
   403e0:	e8 07 35 00 00       	call   438ec <memset>
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
   40433:	48 8d 05 07 3a 01 00 	lea    0x13a07(%rip),%rax        # 53e41 <pageinfo+0x1>
   4043a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4043e:	84 c0                	test   %al,%al
   40440:	75 31                	jne    40473 <find_page+0x6f>
            pageinfo[pn].owner = owner;
   40442:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40445:	48 98                	cltq   
   40447:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4044b:	48 8d 15 ee 39 01 00 	lea    0x139ee(%rip),%rdx        # 53e40 <pageinfo>
   40452:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
   40456:	88 04 11             	mov    %al,(%rcx,%rdx,1)
            pageinfo[pn].refcount = 1;
   40459:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4045c:	48 98                	cltq   
   4045e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40462:	48 8d 05 d8 39 01 00 	lea    0x139d8(%rip),%rax        # 53e41 <pageinfo+0x1>
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
   40541:	eb 4e                	jmp    40591 <make_pages+0x105>
        vamapping vam = virtual_memory_lookup(kernel_pagetable, va);
   40543:	48 8b 0d b6 5a 01 00 	mov    0x15ab6(%rip),%rcx        # 56000 <kernel_pagetable>
   4054a:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4054e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40552:	48 89 ce             	mov    %rcx,%rsi
   40555:	48 89 c7             	mov    %rax,%rdi
   40558:	e8 c8 2e 00 00       	call   43425 <virtual_memory_lookup>
        if (vam.pn != -1) {
   4055d:	8b 45 b8             	mov    -0x48(%rbp),%eax
   40560:	83 f8 ff             	cmp    $0xffffffff,%eax
   40563:	74 24                	je     40589 <make_pages+0xfd>
            virtual_memory_map(l4, va, vam.pa, PAGESIZE, vam.perm & ~PTE_U);
   40565:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40568:	83 e0 fb             	and    $0xfffffffb,%eax
   4056b:	89 c1                	mov    %eax,%ecx
   4056d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   40571:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40575:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40579:	41 89 c8             	mov    %ecx,%r8d
   4057c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40581:	48 89 c7             	mov    %rax,%rdi
   40584:	e8 52 2a 00 00       	call   42fdb <virtual_memory_map>
    for (uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE) {
   40589:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40590:	00 
   40591:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   40598:	00 
   40599:	76 a8                	jbe    40543 <make_pages+0xb7>
        }
    }
    return l4;
   4059b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
   4059f:	c9                   	leave  
   405a0:	c3                   	ret    

00000000000405a1 <process_setup>:

void process_setup(pid_t pid, int program_number) {
   405a1:	f3 0f 1e fa          	endbr64 
   405a5:	55                   	push   %rbp
   405a6:	48 89 e5             	mov    %rsp,%rbp
   405a9:	48 83 ec 20          	sub    $0x20,%rsp
   405ad:	89 7d ec             	mov    %edi,-0x14(%rbp)
   405b0:	89 75 e8             	mov    %esi,-0x18(%rbp)
    process_init(&processes[pid], 0);
   405b3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   405b6:	48 63 d0             	movslq %eax,%rdx
   405b9:	48 89 d0             	mov    %rdx,%rax
   405bc:	48 c1 e0 03          	shl    $0x3,%rax
   405c0:	48 29 d0             	sub    %rdx,%rax
   405c3:	48 c1 e0 05          	shl    $0x5,%rax
   405c7:	48 8d 15 52 2a 01 00 	lea    0x12a52(%rip),%rdx        # 53020 <processes>
   405ce:	48 01 d0             	add    %rdx,%rax
   405d1:	be 00 00 00 00       	mov    $0x0,%esi
   405d6:	48 89 c7             	mov    %rax,%rdi
   405d9:	e8 43 1e 00 00       	call   42421 <process_init>

    x86_64_pagetable *l4 = make_pages(pid);
   405de:	8b 45 ec             	mov    -0x14(%rbp),%eax
   405e1:	89 c7                	mov    %eax,%edi
   405e3:	e8 a4 fe ff ff       	call   4048c <make_pages>
   405e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

    processes[pid].p_pagetable = l4;
   405ec:	8b 45 ec             	mov    -0x14(%rbp),%eax
   405ef:	48 63 d0             	movslq %eax,%rdx
   405f2:	48 89 d0             	mov    %rdx,%rax
   405f5:	48 c1 e0 03          	shl    $0x3,%rax
   405f9:	48 29 d0             	sub    %rdx,%rax
   405fc:	48 c1 e0 05          	shl    $0x5,%rax
   40600:	48 89 c1             	mov    %rax,%rcx
   40603:	48 8d 15 e6 2a 01 00 	lea    0x12ae6(%rip),%rdx        # 530f0 <processes+0xd0>
   4060a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4060e:	48 89 04 11          	mov    %rax,(%rcx,%rdx,1)
    // FIXME
    // virtual_memory_map(l4, 0, 0,
    //                PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(l4, CONSOLE_ADDR, CONSOLE_ADDR,
   40612:	48 8d 15 e7 79 07 00 	lea    0x779e7(%rip),%rdx        # b8000 <console>
   40619:	48 8d 35 e0 79 07 00 	lea    0x779e0(%rip),%rsi        # b8000 <console>
   40620:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40624:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4062a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4062f:	48 89 c7             	mov    %rax,%rdi
   40632:	e8 a4 29 00 00       	call   42fdb <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    int r = program_load(&processes[pid], program_number, NULL);
   40637:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4063a:	48 63 d0             	movslq %eax,%rdx
   4063d:	48 89 d0             	mov    %rdx,%rax
   40640:	48 c1 e0 03          	shl    $0x3,%rax
   40644:	48 29 d0             	sub    %rdx,%rax
   40647:	48 c1 e0 05          	shl    $0x5,%rax
   4064b:	48 8d 15 ce 29 01 00 	lea    0x129ce(%rip),%rdx        # 53020 <processes>
   40652:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
   40656:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40659:	ba 00 00 00 00       	mov    $0x0,%edx
   4065e:	89 c6                	mov    %eax,%esi
   40660:	48 89 cf             	mov    %rcx,%rdi
   40663:	e8 b8 2e 00 00       	call   43520 <program_load>
   40668:	89 45 f4             	mov    %eax,-0xc(%rbp)
    assert(r >= 0);
   4066b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4066f:	79 1e                	jns    4068f <process_setup+0xee>
   40671:	48 8d 05 a1 42 00 00 	lea    0x42a1(%rip),%rax        # 44919 <console_clear+0x78>
   40678:	48 89 c2             	mov    %rax,%rdx
   4067b:	be bf 00 00 00       	mov    $0xbf,%esi
   40680:	48 8d 05 99 42 00 00 	lea    0x4299(%rip),%rax        # 44920 <console_clear+0x7f>
   40687:	48 89 c7             	mov    %rax,%rdi
   4068a:	e8 c8 25 00 00       	call   42c57 <assert_fail>

    virtual_memory_map(l4, MEMSIZE_VIRTUAL - PAGESIZE, find_page(pid), PAGESIZE, PTE_P | PTE_W | PTE_U);
   4068f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40692:	0f be c0             	movsbl %al,%eax
   40695:	89 c7                	mov    %eax,%edi
   40697:	e8 68 fd ff ff       	call   40404 <find_page>
   4069c:	48 89 c2             	mov    %rax,%rdx
   4069f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   406a3:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   406a9:	b9 00 10 00 00       	mov    $0x1000,%ecx
   406ae:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   406b3:	48 89 c7             	mov    %rax,%rdi
   406b6:	e8 20 29 00 00       	call   42fdb <virtual_memory_map>
    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL;
   406bb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   406be:	48 63 d0             	movslq %eax,%rdx
   406c1:	48 89 d0             	mov    %rdx,%rax
   406c4:	48 c1 e0 03          	shl    $0x3,%rax
   406c8:	48 29 d0             	sub    %rdx,%rax
   406cb:	48 c1 e0 05          	shl    $0x5,%rax
   406cf:	48 89 c2             	mov    %rax,%rdx
   406d2:	48 8d 05 ff 29 01 00 	lea    0x129ff(%rip),%rax        # 530d8 <processes+0xb8>
   406d9:	48 c7 04 02 00 00 30 	movq   $0x300000,(%rdx,%rax,1)
   406e0:	00 

    processes[pid].p_state = P_RUNNABLE;
   406e1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   406e4:	48 63 d0             	movslq %eax,%rdx
   406e7:	48 89 d0             	mov    %rdx,%rax
   406ea:	48 c1 e0 03          	shl    $0x3,%rax
   406ee:	48 29 d0             	sub    %rdx,%rax
   406f1:	48 c1 e0 05          	shl    $0x5,%rax
   406f5:	48 89 c2             	mov    %rax,%rdx
   406f8:	48 8d 05 e9 29 01 00 	lea    0x129e9(%rip),%rax        # 530e8 <processes+0xc8>
   406ff:	c7 04 02 01 00 00 00 	movl   $0x1,(%rdx,%rax,1)
}
   40706:	90                   	nop
   40707:	c9                   	leave  
   40708:	c3                   	ret    

0000000000040709 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40709:	f3 0f 1e fa          	endbr64 
   4070d:	55                   	push   %rbp
   4070e:	48 89 e5             	mov    %rsp,%rbp
   40711:	48 83 ec 10          	sub    $0x10,%rsp
   40715:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40719:	89 f0                	mov    %esi,%eax
   4071b:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   4071e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40722:	25 ff 0f 00 00       	and    $0xfff,%eax
   40727:	48 85 c0             	test   %rax,%rax
   4072a:	75 27                	jne    40753 <assign_physical_page+0x4a>
        || addr >= MEMSIZE_PHYSICAL
   4072c:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40733:	00 
   40734:	77 1d                	ja     40753 <assign_physical_page+0x4a>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40736:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4073a:	48 c1 e8 0c          	shr    $0xc,%rax
   4073e:	48 98                	cltq   
   40740:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40744:	48 8d 05 f6 36 01 00 	lea    0x136f6(%rip),%rax        # 53e41 <pageinfo+0x1>
   4074b:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4074f:	84 c0                	test   %al,%al
   40751:	74 07                	je     4075a <assign_physical_page+0x51>
        return -1;
   40753:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40758:	eb 3a                	jmp    40794 <assign_physical_page+0x8b>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   4075a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4075e:	48 c1 e8 0c          	shr    $0xc,%rax
   40762:	48 98                	cltq   
   40764:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40768:	48 8d 05 d2 36 01 00 	lea    0x136d2(%rip),%rax        # 53e41 <pageinfo+0x1>
   4076f:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40773:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40777:	48 c1 e8 0c          	shr    $0xc,%rax
   4077b:	48 98                	cltq   
   4077d:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40781:	48 8d 15 b8 36 01 00 	lea    0x136b8(%rip),%rdx        # 53e40 <pageinfo>
   40788:	0f b6 45 f4          	movzbl -0xc(%rbp),%eax
   4078c:	88 04 11             	mov    %al,(%rcx,%rdx,1)
        return 0;
   4078f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40794:	c9                   	leave  
   40795:	c3                   	ret    

0000000000040796 <syscall_mapping>:

void syscall_mapping(proc* p){
   40796:	f3 0f 1e fa          	endbr64 
   4079a:	55                   	push   %rbp
   4079b:	48 89 e5             	mov    %rsp,%rbp
   4079e:	48 83 ec 70          	sub    $0x70,%rsp
   407a2:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   407a6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407aa:	48 8b 40 38          	mov    0x38(%rax),%rax
   407ae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   407b2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407b6:	48 8b 40 30          	mov    0x30(%rax),%rax
   407ba:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   407be:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407c2:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407c9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   407cd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407d1:	48 89 ce             	mov    %rcx,%rsi
   407d4:	48 89 c7             	mov    %rax,%rdi
   407d7:	e8 49 2c 00 00       	call   43425 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   407dc:	8b 45 e0             	mov    -0x20(%rbp),%eax
   407df:	48 98                	cltq   
   407e1:	83 e0 06             	and    $0x6,%eax
   407e4:	48 83 f8 06          	cmp    $0x6,%rax
   407e8:	75 73                	jne    4085d <syscall_mapping+0xc7>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   407ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407ee:	48 83 c0 17          	add    $0x17,%rax
   407f2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   407f6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407fa:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40801:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40805:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40809:	48 89 ce             	mov    %rcx,%rsi
   4080c:	48 89 c7             	mov    %rax,%rdi
   4080f:	e8 11 2c 00 00       	call   43425 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40814:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40817:	48 98                	cltq   
   40819:	83 e0 03             	and    $0x3,%eax
   4081c:	48 83 f8 03          	cmp    $0x3,%rax
   40820:	75 3e                	jne    40860 <syscall_mapping+0xca>
        return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40822:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40826:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4082d:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40831:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40835:	48 89 ce             	mov    %rcx,%rsi
   40838:	48 89 c7             	mov    %rax,%rdi
   4083b:	e8 e5 2b 00 00       	call   43425 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40840:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40844:	48 89 c1             	mov    %rax,%rcx
   40847:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4084b:	ba 18 00 00 00       	mov    $0x18,%edx
   40850:	48 89 c6             	mov    %rax,%rsi
   40853:	48 89 cf             	mov    %rcx,%rdi
   40856:	e8 8b 2f 00 00       	call   437e6 <memcpy>
   4085b:	eb 04                	jmp    40861 <syscall_mapping+0xcb>
        return;
   4085d:	90                   	nop
   4085e:	eb 01                	jmp    40861 <syscall_mapping+0xcb>
        return;
   40860:	90                   	nop
}
   40861:	c9                   	leave  
   40862:	c3                   	ret    

0000000000040863 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40863:	f3 0f 1e fa          	endbr64 
   40867:	55                   	push   %rbp
   40868:	48 89 e5             	mov    %rsp,%rbp
   4086b:	48 83 ec 18          	sub    $0x18,%rsp
   4086f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40873:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40877:	48 8b 40 38          	mov    0x38(%rax),%rax
   4087b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   4087e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40882:	75 14                	jne    40898 <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   40884:	0f b6 05 75 57 00 00 	movzbl 0x5775(%rip),%eax        # 46000 <disp_global>
   4088b:	84 c0                	test   %al,%al
   4088d:	0f 94 c0             	sete   %al
   40890:	88 05 6a 57 00 00    	mov    %al,0x576a(%rip)        # 46000 <disp_global>
   40896:	eb 36                	jmp    408ce <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40898:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4089c:	78 2f                	js     408cd <syscall_mem_tog+0x6a>
   4089e:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   408a2:	7f 29                	jg     408cd <syscall_mem_tog+0x6a>
   408a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408a8:	8b 00                	mov    (%rax),%eax
   408aa:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   408ad:	75 1e                	jne    408cd <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   408af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408b3:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   408ba:	84 c0                	test   %al,%al
   408bc:	0f 94 c0             	sete   %al
   408bf:	89 c2                	mov    %eax,%edx
   408c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408c5:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   408cb:	eb 01                	jmp    408ce <syscall_mem_tog+0x6b>
            return;
   408cd:	90                   	nop
    }
}
   408ce:	c9                   	leave  
   408cf:	c3                   	ret    

00000000000408d0 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   408d0:	f3 0f 1e fa          	endbr64 
   408d4:	55                   	push   %rbp
   408d5:	48 89 e5             	mov    %rsp,%rbp
   408d8:	48 81 ec 80 01 00 00 	sub    $0x180,%rsp
   408df:	48 89 bd 88 fe ff ff 	mov    %rdi,-0x178(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   408e6:	48 8b 05 13 27 01 00 	mov    0x12713(%rip),%rax        # 53000 <current>
   408ed:	48 8b 95 88 fe ff ff 	mov    -0x178(%rbp),%rdx
   408f4:	48 83 c0 08          	add    $0x8,%rax
   408f8:	48 89 d6             	mov    %rdx,%rsi
   408fb:	ba 18 00 00 00       	mov    $0x18,%edx
   40900:	48 89 c7             	mov    %rax,%rdi
   40903:	48 89 d1             	mov    %rdx,%rcx
   40906:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40909:	48 8b 05 f0 56 01 00 	mov    0x156f0(%rip),%rax        # 56000 <kernel_pagetable>
   40910:	48 89 c7             	mov    %rax,%rdi
   40913:	e8 51 25 00 00       	call   42e69 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40918:	8b 05 de 86 07 00    	mov    0x786de(%rip),%eax        # b8ffc <cursorpos>
   4091e:	89 c7                	mov    %eax,%edi
   40920:	e8 ca 1b 00 00       	call   424ef <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40925:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   4092c:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40933:	48 83 f8 0e          	cmp    $0xe,%rax
   40937:	74 14                	je     4094d <exception+0x7d>
   40939:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40940:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40947:	48 83 f8 0d          	cmp    $0xd,%rax
   4094b:	75 16                	jne    40963 <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   4094d:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40954:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4095b:	83 e0 04             	and    $0x4,%eax
   4095e:	48 85 c0             	test   %rax,%rax
   40961:	74 1a                	je     4097d <exception+0xad>
    {
        check_virtual_memory();
   40963:	e8 cd 0b 00 00       	call   41535 <check_virtual_memory>
        if(disp_global){
   40968:	0f b6 05 91 56 00 00 	movzbl 0x5691(%rip),%eax        # 46000 <disp_global>
   4096f:	84 c0                	test   %al,%al
   40971:	74 0a                	je     4097d <exception+0xad>
            memshow_physical();
   40973:	e8 86 0d 00 00       	call   416fe <memshow_physical>
            memshow_virtual_animate();
   40978:	e8 23 11 00 00       	call   41aa0 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   4097d:	e8 83 20 00 00       	call   42a05 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40982:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40989:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40990:	48 83 e8 0e          	sub    $0xe,%rax
   40994:	48 83 f8 2a          	cmp    $0x2a,%rax
   40998:	0f 87 4a 06 00 00    	ja     40fe8 <exception+0x718>
   4099e:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   409a5:	00 
   409a6:	48 8d 05 13 40 00 00 	lea    0x4013(%rip),%rax        # 449c0 <console_clear+0x11f>
   409ad:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   409b0:	48 98                	cltq   
   409b2:	48 8d 15 07 40 00 00 	lea    0x4007(%rip),%rdx        # 449c0 <console_clear+0x11f>
   409b9:	48 01 d0             	add    %rdx,%rax
   409bc:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   409bf:	48 8b 05 3a 26 01 00 	mov    0x1263a(%rip),%rax        # 53000 <current>
   409c6:	48 8b 40 38          	mov    0x38(%rax),%rax
   409ca:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
		if((void *)addr == NULL)
   409ce:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
   409d3:	75 0f                	jne    409e4 <exception+0x114>
		    panic(NULL);
   409d5:	bf 00 00 00 00       	mov    $0x0,%edi
   409da:	b8 00 00 00 00       	mov    $0x0,%eax
   409df:	e8 83 21 00 00       	call   42b67 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   409e4:	48 8b 05 15 26 01 00 	mov    0x12615(%rip),%rax        # 53000 <current>
   409eb:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   409f2:	48 8d 85 68 ff ff ff 	lea    -0x98(%rbp),%rax
   409f9:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   409fd:	48 89 ce             	mov    %rcx,%rsi
   40a00:	48 89 c7             	mov    %rax,%rdi
   40a03:	e8 1d 2a 00 00       	call   43425 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40a08:	48 8b 85 70 ff ff ff 	mov    -0x90(%rbp),%rax
   40a0f:	48 89 c1             	mov    %rax,%rcx
   40a12:	48 8d 85 98 fe ff ff 	lea    -0x168(%rbp),%rax
   40a19:	ba a0 00 00 00       	mov    $0xa0,%edx
   40a1e:	48 89 ce             	mov    %rcx,%rsi
   40a21:	48 89 c7             	mov    %rax,%rdi
   40a24:	e8 bd 2d 00 00       	call   437e6 <memcpy>
		panic(msg);
   40a29:	48 8d 85 98 fe ff ff 	lea    -0x168(%rbp),%rax
   40a30:	48 89 c7             	mov    %rax,%rdi
   40a33:	b8 00 00 00 00       	mov    $0x0,%eax
   40a38:	e8 2a 21 00 00       	call   42b67 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40a3d:	48 8b 05 bc 25 01 00 	mov    0x125bc(%rip),%rax        # 53000 <current>
   40a44:	8b 10                	mov    (%rax),%edx
   40a46:	48 8b 05 b3 25 01 00 	mov    0x125b3(%rip),%rax        # 53000 <current>
   40a4d:	48 63 d2             	movslq %edx,%rdx
   40a50:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40a54:	e9 9f 05 00 00       	jmp    40ff8 <exception+0x728>

    case INT_SYS_YIELD:
        schedule();
   40a59:	e8 c3 05 00 00       	call   41021 <schedule>
        break;                  /* will not be reached */
   40a5e:	e9 95 05 00 00       	jmp    40ff8 <exception+0x728>

case INT_SYS_PAGE_ALLOC: {
    uintptr_t va = current->p_registers.reg_rdi;
   40a63:	48 8b 05 96 25 01 00 	mov    0x12596(%rip),%rax        # 53000 <current>
   40a6a:	48 8b 40 38          	mov    0x38(%rax),%rax
   40a6e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    // check allignment and bounds
    if (va % PAGESIZE != 0) {
   40a72:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40a76:	25 ff 0f 00 00       	and    $0xfff,%eax
   40a7b:	48 85 c0             	test   %rax,%rax
   40a7e:	74 14                	je     40a94 <exception+0x1c4>
        current->p_registers.reg_rax = -1; 
   40a80:	48 8b 05 79 25 01 00 	mov    0x12579(%rip),%rax        # 53000 <current>
   40a87:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40a8e:	ff 
        break;
   40a8f:	e9 64 05 00 00       	jmp    40ff8 <exception+0x728>
    }
    if (va >= MEMSIZE_VIRTUAL) {
   40a94:	48 81 7d b8 ff ff 2f 	cmpq   $0x2fffff,-0x48(%rbp)
   40a9b:	00 
   40a9c:	76 14                	jbe    40ab2 <exception+0x1e2>
        current->p_registers.reg_rax = -1; 
   40a9e:	48 8b 05 5b 25 01 00 	mov    0x1255b(%rip),%rax        # 53000 <current>
   40aa5:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40aac:	ff 
        break;
   40aad:	e9 46 05 00 00       	jmp    40ff8 <exception+0x728>
    }
    if (va < PROC_START_ADDR) {
   40ab2:	48 81 7d b8 ff ff 0f 	cmpq   $0xfffff,-0x48(%rbp)
   40ab9:	00 
   40aba:	77 14                	ja     40ad0 <exception+0x200>
        current->p_registers.reg_rax = -1; 
   40abc:	48 8b 05 3d 25 01 00 	mov    0x1253d(%rip),%rax        # 53000 <current>
   40ac3:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40aca:	ff 
        break;
   40acb:	e9 28 05 00 00       	jmp    40ff8 <exception+0x728>
    }   
    uintptr_t pa = find_page(current->p_pid);
   40ad0:	48 8b 05 29 25 01 00 	mov    0x12529(%rip),%rax        # 53000 <current>
   40ad7:	8b 00                	mov    (%rax),%eax
   40ad9:	0f be c0             	movsbl %al,%eax
   40adc:	89 c7                	mov    %eax,%edi
   40ade:	e8 21 f9 ff ff       	call   40404 <find_page>
   40ae3:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    if (pa == 0) {
   40ae7:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   40aec:	75 14                	jne    40b02 <exception+0x232>
        current->p_registers.reg_rax = -1; 
   40aee:	48 8b 05 0b 25 01 00 	mov    0x1250b(%rip),%rax        # 53000 <current>
   40af5:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40afc:	ff 
        break;
   40afd:	e9 f6 04 00 00       	jmp    40ff8 <exception+0x728>
    }
    int perm = PTE_P | PTE_W | PTE_U;
   40b02:	c7 45 ac 07 00 00 00 	movl   $0x7,-0x54(%rbp)

    int r = virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, perm);
   40b09:	48 8b 05 f0 24 01 00 	mov    0x124f0(%rip),%rax        # 53000 <current>
   40b10:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40b17:	8b 4d ac             	mov    -0x54(%rbp),%ecx
   40b1a:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   40b1e:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
   40b22:	41 89 c8             	mov    %ecx,%r8d
   40b25:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40b2a:	48 89 c7             	mov    %rax,%rdi
   40b2d:	e8 a9 24 00 00       	call   42fdb <virtual_memory_map>
   40b32:	89 45 a8             	mov    %eax,-0x58(%rbp)

    if (r != 0) {
   40b35:	83 7d a8 00          	cmpl   $0x0,-0x58(%rbp)
   40b39:	74 46                	je     40b81 <exception+0x2b1>
        // If mapping fails, free the physical page
        pageinfo[PAGENUMBER(pa)].refcount = 0;
   40b3b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40b3f:	48 c1 e8 0c          	shr    $0xc,%rax
   40b43:	48 98                	cltq   
   40b45:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40b49:	48 8d 05 f1 32 01 00 	lea    0x132f1(%rip),%rax        # 53e41 <pageinfo+0x1>
   40b50:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(pa)].owner = PO_FREE;
   40b54:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40b58:	48 c1 e8 0c          	shr    $0xc,%rax
   40b5c:	48 98                	cltq   
   40b5e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40b62:	48 8d 05 d7 32 01 00 	lea    0x132d7(%rip),%rax        # 53e40 <pageinfo>
   40b69:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        current->p_registers.reg_rax = -1;
   40b6d:	48 8b 05 8c 24 01 00 	mov    0x1248c(%rip),%rax        # 53000 <current>
   40b74:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b7b:	ff 
        break;
   40b7c:	e9 77 04 00 00       	jmp    40ff8 <exception+0x728>
    }

    // Success: Return 0
    current->p_registers.reg_rax = 0;
   40b81:	48 8b 05 78 24 01 00 	mov    0x12478(%rip),%rax        # 53000 <current>
   40b88:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40b8f:	00 
    break;
   40b90:	e9 63 04 00 00       	jmp    40ff8 <exception+0x728>
}
case INT_SYS_FORK: {
    // Step 1: Find a free process slot
    pid_t child_pid = -1;
   40b95:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    for (pid_t i = 1; i < NPROC; ++i) {
   40b9c:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   40ba3:	eb 31                	jmp    40bd6 <exception+0x306>
        if (processes[i].p_state == P_FREE) {
   40ba5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ba8:	48 63 d0             	movslq %eax,%rdx
   40bab:	48 89 d0             	mov    %rdx,%rax
   40bae:	48 c1 e0 03          	shl    $0x3,%rax
   40bb2:	48 29 d0             	sub    %rdx,%rax
   40bb5:	48 c1 e0 05          	shl    $0x5,%rax
   40bb9:	48 89 c2             	mov    %rax,%rdx
   40bbc:	48 8d 05 25 25 01 00 	lea    0x12525(%rip),%rax        # 530e8 <processes+0xc8>
   40bc3:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40bc6:	85 c0                	test   %eax,%eax
   40bc8:	75 08                	jne    40bd2 <exception+0x302>
            child_pid = i;
   40bca:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40bcd:	89 45 fc             	mov    %eax,-0x4(%rbp)
            break;
   40bd0:	eb 0a                	jmp    40bdc <exception+0x30c>
    for (pid_t i = 1; i < NPROC; ++i) {
   40bd2:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40bd6:	83 7d f8 0f          	cmpl   $0xf,-0x8(%rbp)
   40bda:	7e c9                	jle    40ba5 <exception+0x2d5>
        }
    }

    // If no free slot, return -1
    if (child_pid == -1) {
   40bdc:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40be0:	75 14                	jne    40bf6 <exception+0x326>
        current->p_registers.reg_rax = -1;
   40be2:	48 8b 05 17 24 01 00 	mov    0x12417(%rip),%rax        # 53000 <current>
   40be9:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40bf0:	ff 
        break;
   40bf1:	e9 02 04 00 00       	jmp    40ff8 <exception+0x728>
    }

    // Step 2: Reserve the new process slot
    proc* parent = current;
   40bf6:	48 8b 05 03 24 01 00 	mov    0x12403(%rip),%rax        # 53000 <current>
   40bfd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    proc* child = &processes[child_pid];
   40c01:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c04:	48 63 d0             	movslq %eax,%rdx
   40c07:	48 89 d0             	mov    %rdx,%rax
   40c0a:	48 c1 e0 03          	shl    $0x3,%rax
   40c0e:	48 29 d0             	sub    %rdx,%rax
   40c11:	48 c1 e0 05          	shl    $0x5,%rax
   40c15:	48 8d 15 04 24 01 00 	lea    0x12404(%rip),%rdx        # 53020 <processes>
   40c1c:	48 01 d0             	add    %rdx,%rax
   40c1f:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    process_init(child, child_pid);
   40c23:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40c26:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40c2a:	89 d6                	mov    %edx,%esi
   40c2c:	48 89 c7             	mov    %rax,%rdi
   40c2f:	e8 ed 17 00 00       	call   42421 <process_init>

    // Step 3: Allocate a new page table for the child
    x86_64_pagetable* child_pagetable = make_pages(child_pid);
   40c34:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c37:	89 c7                	mov    %eax,%edi
   40c39:	e8 4e f8 ff ff       	call   4048c <make_pages>
   40c3e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    if (!child_pagetable) {
   40c42:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40c47:	75 14                	jne    40c5d <exception+0x38d>
        current->p_registers.reg_rax = -1;
   40c49:	48 8b 05 b0 23 01 00 	mov    0x123b0(%rip),%rax        # 53000 <current>
   40c50:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40c57:	ff 
        break;
   40c58:	e9 9b 03 00 00       	jmp    40ff8 <exception+0x728>
    }
    child->p_pagetable = child_pagetable;
   40c5d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40c61:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40c65:	48 89 90 d0 00 00 00 	mov    %rdx,0xd0(%rax)

    int failed = 0;
   40c6c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40c73:	48 c7 45 e8 00 00 10 	movq   $0x100000,-0x18(%rbp)
   40c7a:	00 
   40c7b:	e9 f1 00 00 00       	jmp    40d71 <exception+0x4a1>
        vamapping parent_mapping = virtual_memory_lookup(parent->p_pagetable, va);
   40c80:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40c84:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40c8b:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
   40c92:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40c96:	48 89 ce             	mov    %rcx,%rsi
   40c99:	48 89 c7             	mov    %rax,%rdi
   40c9c:	e8 84 27 00 00       	call   43425 <virtual_memory_lookup>

        if (parent_mapping.pn == -1) {
   40ca1:	8b 85 50 ff ff ff    	mov    -0xb0(%rbp),%eax
   40ca7:	83 f8 ff             	cmp    $0xffffffff,%eax
   40caa:	0f 84 b8 00 00 00    	je     40d68 <exception+0x498>
            continue; // Skip unmapped pages
        }

        // mapp console
        virtual_memory_map(child_pagetable, CONSOLE_ADDR, parent_mapping.pa, PAGESIZE, parent_mapping.perm);
   40cb0:	8b 8d 60 ff ff ff    	mov    -0xa0(%rbp),%ecx
   40cb6:	48 8b 95 58 ff ff ff 	mov    -0xa8(%rbp),%rdx
   40cbd:	48 8d 35 3c 73 07 00 	lea    0x7733c(%rip),%rsi        # b8000 <console>
   40cc4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40cc8:	41 89 c8             	mov    %ecx,%r8d
   40ccb:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40cd0:	48 89 c7             	mov    %rax,%rdi
   40cd3:	e8 03 23 00 00       	call   42fdb <virtual_memory_map>

        // Allocate a new physical page for the child
        uintptr_t new_pa = find_page(child_pid);
   40cd8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cdb:	0f be c0             	movsbl %al,%eax
   40cde:	89 c7                	mov    %eax,%edi
   40ce0:	e8 1f f7 ff ff       	call   40404 <find_page>
   40ce5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        // Copy data from parent's page to the new page
        memcpy((void*) new_pa, (void*) parent_mapping.pa, PAGESIZE);
   40ce9:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
   40cf0:	48 89 c1             	mov    %rax,%rcx
   40cf3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40cf7:	ba 00 10 00 00       	mov    $0x1000,%edx
   40cfc:	48 89 ce             	mov    %rcx,%rsi
   40cff:	48 89 c7             	mov    %rax,%rdi
   40d02:	e8 df 2a 00 00       	call   437e6 <memcpy>

        // Map the new page in the child's page table
        if (virtual_memory_map(child_pagetable, va, new_pa, PAGESIZE, parent_mapping.perm) < 0) {
   40d07:	8b 8d 60 ff ff ff    	mov    -0xa0(%rbp),%ecx
   40d0d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   40d11:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40d15:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40d19:	41 89 c8             	mov    %ecx,%r8d
   40d1c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40d21:	48 89 c7             	mov    %rax,%rdi
   40d24:	e8 b2 22 00 00       	call   42fdb <virtual_memory_map>
   40d29:	85 c0                	test   %eax,%eax
   40d2b:	79 3c                	jns    40d69 <exception+0x499>
            failed = 1;
   40d2d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
            pageinfo[PAGENUMBER(new_pa)].refcount = 0; // Free the allocated page
   40d34:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40d38:	48 c1 e8 0c          	shr    $0xc,%rax
   40d3c:	48 98                	cltq   
   40d3e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40d42:	48 8d 05 f8 30 01 00 	lea    0x130f8(%rip),%rax        # 53e41 <pageinfo+0x1>
   40d49:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
            pageinfo[PAGENUMBER(new_pa)].owner = PO_FREE;
   40d4d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40d51:	48 c1 e8 0c          	shr    $0xc,%rax
   40d55:	48 98                	cltq   
   40d57:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40d5b:	48 8d 05 de 30 01 00 	lea    0x130de(%rip),%rax        # 53e40 <pageinfo>
   40d62:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
   40d66:	eb 17                	jmp    40d7f <exception+0x4af>
            continue; // Skip unmapped pages
   40d68:	90                   	nop
    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40d69:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   40d70:	00 
   40d71:	48 81 7d e8 ff ff 2f 	cmpq   $0x2fffff,-0x18(%rbp)
   40d78:	00 
   40d79:	0f 86 01 ff ff ff    	jbe    40c80 <exception+0x3b0>
            break;
        }
    }

    // Step 5: Handle failure
    if (failed) {
   40d7f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40d83:	0f 84 c3 00 00 00    	je     40e4c <exception+0x57c>
        for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40d89:	48 c7 45 e0 00 00 10 	movq   $0x100000,-0x20(%rbp)
   40d90:	00 
   40d91:	eb 5b                	jmp    40dee <exception+0x51e>
            vamapping child_mapping = virtual_memory_lookup(child_pagetable, va);
   40d93:	48 8d 85 38 ff ff ff 	lea    -0xc8(%rbp),%rax
   40d9a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40d9e:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40da2:	48 89 ce             	mov    %rcx,%rsi
   40da5:	48 89 c7             	mov    %rax,%rdi
   40da8:	e8 78 26 00 00       	call   43425 <virtual_memory_lookup>
            if (child_mapping.pn != -1) {
   40dad:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
   40db3:	83 f8 ff             	cmp    $0xffffffff,%eax
   40db6:	74 2e                	je     40de6 <exception+0x516>
                pageinfo[child_mapping.pn].refcount = 0;
   40db8:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
   40dbe:	48 98                	cltq   
   40dc0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40dc4:	48 8d 05 76 30 01 00 	lea    0x13076(%rip),%rax        # 53e41 <pageinfo+0x1>
   40dcb:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[child_mapping.pn].owner = PO_FREE;
   40dcf:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
   40dd5:	48 98                	cltq   
   40dd7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40ddb:	48 8d 05 5e 30 01 00 	lea    0x1305e(%rip),%rax        # 53e40 <pageinfo>
   40de2:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40de6:	48 81 45 e0 00 10 00 	addq   $0x1000,-0x20(%rbp)
   40ded:	00 
   40dee:	48 81 7d e0 ff ff 2f 	cmpq   $0x2fffff,-0x20(%rbp)
   40df5:	00 
   40df6:	76 9b                	jbe    40d93 <exception+0x4c3>
            }
        }
        pageinfo[PAGENUMBER((uintptr_t) child_pagetable)].refcount = 0;
   40df8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40dfc:	48 c1 e8 0c          	shr    $0xc,%rax
   40e00:	48 98                	cltq   
   40e02:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e06:	48 8d 05 34 30 01 00 	lea    0x13034(%rip),%rax        # 53e41 <pageinfo+0x1>
   40e0d:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER((uintptr_t) child_pagetable)].owner = PO_FREE;
   40e11:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e15:	48 c1 e8 0c          	shr    $0xc,%rax
   40e19:	48 98                	cltq   
   40e1b:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e1f:	48 8d 05 1a 30 01 00 	lea    0x1301a(%rip),%rax        # 53e40 <pageinfo>
   40e26:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        child->p_state = P_FREE;
   40e2a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40e2e:	c7 80 c8 00 00 00 00 	movl   $0x0,0xc8(%rax)
   40e35:	00 00 00 
        current->p_registers.reg_rax = -1;
   40e38:	48 8b 05 c1 21 01 00 	mov    0x121c1(%rip),%rax        # 53000 <current>
   40e3f:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40e46:	ff 
        break;
   40e47:	e9 ac 01 00 00       	jmp    40ff8 <exception+0x728>
    }

    // Step 6: Initialize child registers
    child->p_registers = parent->p_registers;
   40e4c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40e50:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40e54:	48 83 c0 08          	add    $0x8,%rax
   40e58:	48 83 c2 08          	add    $0x8,%rdx
   40e5c:	b9 18 00 00 00       	mov    $0x18,%ecx
   40e61:	48 89 c7             	mov    %rax,%rdi
   40e64:	48 89 d6             	mov    %rdx,%rsi
   40e67:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    child->p_registers.reg_rax = 0; // Fork returns 0 in the child
   40e6a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40e6e:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40e75:	00 

    // Step 7: Mark child as runnable
    child->p_state = P_RUNNABLE;
   40e76:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40e7a:	c7 80 c8 00 00 00 01 	movl   $0x1,0xc8(%rax)
   40e81:	00 00 00 

    // Step 8: Return child's PID to the parent
    current->p_registers.reg_rax = child_pid;
   40e84:	48 8b 05 75 21 01 00 	mov    0x12175(%rip),%rax        # 53000 <current>
   40e8b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40e8e:	48 63 d2             	movslq %edx,%rdx
   40e91:	48 89 50 08          	mov    %rdx,0x8(%rax)
    break;
   40e95:	e9 5e 01 00 00       	jmp    40ff8 <exception+0x728>
    }


    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40e9a:	48 8b 05 5f 21 01 00 	mov    0x1215f(%rip),%rax        # 53000 <current>
   40ea1:	48 89 c7             	mov    %rax,%rdi
   40ea4:	e8 ed f8 ff ff       	call   40796 <syscall_mapping>
            break;
   40ea9:	e9 4a 01 00 00       	jmp    40ff8 <exception+0x728>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40eae:	48 8b 05 4b 21 01 00 	mov    0x1214b(%rip),%rax        # 53000 <current>
   40eb5:	48 89 c7             	mov    %rax,%rdi
   40eb8:	e8 a6 f9 ff ff       	call   40863 <syscall_mem_tog>
	    break;
   40ebd:	e9 36 01 00 00       	jmp    40ff8 <exception+0x728>
	}

    case INT_TIMER:
        ++ticks;
   40ec2:	8b 05 58 2f 01 00    	mov    0x12f58(%rip),%eax        # 53e20 <ticks>
   40ec8:	83 c0 01             	add    $0x1,%eax
   40ecb:	89 05 4f 2f 01 00    	mov    %eax,0x12f4f(%rip)        # 53e20 <ticks>
        schedule();
   40ed1:	e8 4b 01 00 00       	call   41021 <schedule>
        break;                  /* will not be reached */
   40ed6:	e9 1d 01 00 00       	jmp    40ff8 <exception+0x728>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40edb:	0f 20 d0             	mov    %cr2,%rax
   40ede:	48 89 45 80          	mov    %rax,-0x80(%rbp)
    return val;
   40ee2:	48 8b 45 80          	mov    -0x80(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40ee6:	48 89 45 98          	mov    %rax,-0x68(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40eea:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40ef1:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ef8:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40efb:	48 85 c0             	test   %rax,%rax
   40efe:	74 09                	je     40f09 <exception+0x639>
   40f00:	48 8d 05 29 3a 00 00 	lea    0x3a29(%rip),%rax        # 44930 <console_clear+0x8f>
   40f07:	eb 07                	jmp    40f10 <exception+0x640>
   40f09:	48 8d 05 26 3a 00 00 	lea    0x3a26(%rip),%rax        # 44936 <console_clear+0x95>
        const char* operation = reg->reg_err & PFERR_WRITE
   40f10:	48 89 45 90          	mov    %rax,-0x70(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40f14:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40f1b:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40f22:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40f25:	48 85 c0             	test   %rax,%rax
   40f28:	74 09                	je     40f33 <exception+0x663>
   40f2a:	48 8d 05 0a 3a 00 00 	lea    0x3a0a(%rip),%rax        # 4493b <console_clear+0x9a>
   40f31:	eb 07                	jmp    40f3a <exception+0x66a>
   40f33:	48 8d 05 14 3a 00 00 	lea    0x3a14(%rip),%rax        # 4494e <console_clear+0xad>
        const char* problem = reg->reg_err & PFERR_PRESENT
   40f3a:	48 89 45 88          	mov    %rax,-0x78(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40f3e:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40f45:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40f4c:	83 e0 04             	and    $0x4,%eax
   40f4f:	48 85 c0             	test   %rax,%rax
   40f52:	75 34                	jne    40f88 <exception+0x6b8>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40f54:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40f5b:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40f62:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   40f66:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
   40f6a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40f6e:	49 89 f0             	mov    %rsi,%r8
   40f71:	48 89 c6             	mov    %rax,%rsi
   40f74:	48 8d 05 e5 39 00 00 	lea    0x39e5(%rip),%rax        # 44960 <console_clear+0xbf>
   40f7b:	48 89 c7             	mov    %rax,%rdi
   40f7e:	b8 00 00 00 00       	mov    $0x0,%eax
   40f83:	e8 df 1b 00 00       	call   42b67 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40f88:	48 8b 85 88 fe ff ff 	mov    -0x178(%rbp),%rax
   40f8f:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40f96:	48 8b 05 63 20 01 00 	mov    0x12063(%rip),%rax        # 53000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40f9d:	8b 00                	mov    (%rax),%eax
   40f9f:	48 8b 75 90          	mov    -0x70(%rbp),%rsi
   40fa3:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   40fa7:	52                   	push   %rdx
   40fa8:	ff 75 88             	push   -0x78(%rbp)
   40fab:	49 89 f1             	mov    %rsi,%r9
   40fae:	49 89 c8             	mov    %rcx,%r8
   40fb1:	89 c1                	mov    %eax,%ecx
   40fb3:	48 8d 05 d6 39 00 00 	lea    0x39d6(%rip),%rax        # 44990 <console_clear+0xef>
   40fba:	48 89 c2             	mov    %rax,%rdx
   40fbd:	be 00 0c 00 00       	mov    $0xc00,%esi
   40fc2:	bf 80 07 00 00       	mov    $0x780,%edi
   40fc7:	b8 00 00 00 00       	mov    $0x0,%eax
   40fcc:	e8 5a 37 00 00       	call   4472b <console_printf>
   40fd1:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40fd5:	48 8b 05 24 20 01 00 	mov    0x12024(%rip),%rax        # 53000 <current>
   40fdc:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40fe3:	00 00 00 
        break;
   40fe6:	eb 10                	jmp    40ff8 <exception+0x728>
    }

    default:
        default_exception(current);
   40fe8:	48 8b 05 11 20 01 00 	mov    0x12011(%rip),%rax        # 53000 <current>
   40fef:	48 89 c7             	mov    %rax,%rdi
   40ff2:	e8 99 1c 00 00       	call   42c90 <default_exception>
        break;                  /* will not be reached */
   40ff7:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40ff8:	48 8b 05 01 20 01 00 	mov    0x12001(%rip),%rax        # 53000 <current>
   40fff:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41005:	83 f8 01             	cmp    $0x1,%eax
   41008:	75 0f                	jne    41019 <exception+0x749>
        run(current);
   4100a:	48 8b 05 ef 1f 01 00 	mov    0x11fef(%rip),%rax        # 53000 <current>
   41011:	48 89 c7             	mov    %rax,%rdi
   41014:	e8 87 00 00 00       	call   410a0 <run>
    } else {
        schedule();
   41019:	e8 03 00 00 00       	call   41021 <schedule>
    }
}
   4101e:	90                   	nop
   4101f:	c9                   	leave  
   41020:	c3                   	ret    

0000000000041021 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   41021:	f3 0f 1e fa          	endbr64 
   41025:	55                   	push   %rbp
   41026:	48 89 e5             	mov    %rsp,%rbp
   41029:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   4102d:	48 8b 05 cc 1f 01 00 	mov    0x11fcc(%rip),%rax        # 53000 <current>
   41034:	8b 00                	mov    (%rax),%eax
   41036:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   41039:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4103c:	83 c0 01             	add    $0x1,%eax
   4103f:	99                   	cltd   
   41040:	c1 ea 1c             	shr    $0x1c,%edx
   41043:	01 d0                	add    %edx,%eax
   41045:	83 e0 0f             	and    $0xf,%eax
   41048:	29 d0                	sub    %edx,%eax
   4104a:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   4104d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41050:	48 63 d0             	movslq %eax,%rdx
   41053:	48 89 d0             	mov    %rdx,%rax
   41056:	48 c1 e0 03          	shl    $0x3,%rax
   4105a:	48 29 d0             	sub    %rdx,%rax
   4105d:	48 c1 e0 05          	shl    $0x5,%rax
   41061:	48 89 c2             	mov    %rax,%rdx
   41064:	48 8d 05 7d 20 01 00 	lea    0x1207d(%rip),%rax        # 530e8 <processes+0xc8>
   4106b:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4106e:	83 f8 01             	cmp    $0x1,%eax
   41071:	75 26                	jne    41099 <schedule+0x78>
            run(&processes[pid]);
   41073:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41076:	48 63 d0             	movslq %eax,%rdx
   41079:	48 89 d0             	mov    %rdx,%rax
   4107c:	48 c1 e0 03          	shl    $0x3,%rax
   41080:	48 29 d0             	sub    %rdx,%rax
   41083:	48 c1 e0 05          	shl    $0x5,%rax
   41087:	48 8d 15 92 1f 01 00 	lea    0x11f92(%rip),%rdx        # 53020 <processes>
   4108e:	48 01 d0             	add    %rdx,%rax
   41091:	48 89 c7             	mov    %rax,%rdi
   41094:	e8 07 00 00 00       	call   410a0 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   41099:	e8 67 19 00 00       	call   42a05 <check_keyboard>
        pid = (pid + 1) % NPROC;
   4109e:	eb 99                	jmp    41039 <schedule+0x18>

00000000000410a0 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   410a0:	f3 0f 1e fa          	endbr64 
   410a4:	55                   	push   %rbp
   410a5:	48 89 e5             	mov    %rsp,%rbp
   410a8:	48 83 ec 10          	sub    $0x10,%rsp
   410ac:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   410b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410b4:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   410ba:	83 f8 01             	cmp    $0x1,%eax
   410bd:	74 1e                	je     410dd <run+0x3d>
   410bf:	48 8d 05 a6 39 00 00 	lea    0x39a6(%rip),%rax        # 44a6c <console_clear+0x1cb>
   410c6:	48 89 c2             	mov    %rax,%rdx
   410c9:	be ff 01 00 00       	mov    $0x1ff,%esi
   410ce:	48 8d 05 4b 38 00 00 	lea    0x384b(%rip),%rax        # 44920 <console_clear+0x7f>
   410d5:	48 89 c7             	mov    %rax,%rdi
   410d8:	e8 7a 1b 00 00       	call   42c57 <assert_fail>
    current = p;
   410dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410e1:	48 89 05 18 1f 01 00 	mov    %rax,0x11f18(%rip)        # 53000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   410e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410ec:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   410f3:	48 89 c7             	mov    %rax,%rdi
   410f6:	e8 6e 1d 00 00       	call   42e69 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   410fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410ff:	48 83 c0 08          	add    $0x8,%rax
   41103:	48 89 c7             	mov    %rax,%rdi
   41106:	e8 b8 ef ff ff       	call   400c3 <exception_return>

000000000004110b <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   4110b:	f3 0f 1e fa          	endbr64 
   4110f:	55                   	push   %rbp
   41110:	48 89 e5             	mov    %rsp,%rbp
   41113:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   41117:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4111e:	00 
   4111f:	e9 93 00 00 00       	jmp    411b7 <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   41124:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41128:	48 89 c7             	mov    %rax,%rdi
   4112b:	e8 0f 11 00 00       	call   4223f <physical_memory_isreserved>
   41130:	85 c0                	test   %eax,%eax
   41132:	74 09                	je     4113d <pageinfo_init+0x32>
            owner = PO_RESERVED;
   41134:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   4113b:	eb 31                	jmp    4116e <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   4113d:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   41144:	00 
   41145:	76 0d                	jbe    41154 <pageinfo_init+0x49>
   41147:	48 8d 05 ba ae 01 00 	lea    0x1aeba(%rip),%rax        # 5c008 <end>
   4114e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41152:	72 0a                	jb     4115e <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   41154:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   4115b:	00 
   4115c:	75 09                	jne    41167 <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   4115e:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   41165:	eb 07                	jmp    4116e <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   41167:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4116e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41172:	48 c1 e8 0c          	shr    $0xc,%rax
   41176:	89 c2                	mov    %eax,%edx
   41178:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4117b:	89 c1                	mov    %eax,%ecx
   4117d:	48 63 c2             	movslq %edx,%rax
   41180:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41184:	48 8d 05 b5 2c 01 00 	lea    0x12cb5(%rip),%rax        # 53e40 <pageinfo>
   4118b:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   4118e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41192:	0f 95 c2             	setne  %dl
   41195:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41199:	48 c1 e8 0c          	shr    $0xc,%rax
   4119d:	89 d1                	mov    %edx,%ecx
   4119f:	48 98                	cltq   
   411a1:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   411a5:	48 8d 05 95 2c 01 00 	lea    0x12c95(%rip),%rax        # 53e41 <pageinfo+0x1>
   411ac:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   411af:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   411b6:	00 
   411b7:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   411be:	00 
   411bf:	0f 86 5f ff ff ff    	jbe    41124 <pageinfo_init+0x19>
    }
}
   411c5:	90                   	nop
   411c6:	90                   	nop
   411c7:	c9                   	leave  
   411c8:	c3                   	ret    

00000000000411c9 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   411c9:	f3 0f 1e fa          	endbr64 
   411cd:	55                   	push   %rbp
   411ce:	48 89 e5             	mov    %rsp,%rbp
   411d1:	48 83 ec 50          	sub    $0x50,%rsp
   411d5:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   411d9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   411dd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   411e3:	48 89 c2             	mov    %rax,%rdx
   411e6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   411ea:	48 39 c2             	cmp    %rax,%rdx
   411ed:	74 1e                	je     4120d <check_page_table_mappings+0x44>
   411ef:	48 8d 05 92 38 00 00 	lea    0x3892(%rip),%rax        # 44a88 <console_clear+0x1e7>
   411f6:	48 89 c2             	mov    %rax,%rdx
   411f9:	be 29 02 00 00       	mov    $0x229,%esi
   411fe:	48 8d 05 1b 37 00 00 	lea    0x371b(%rip),%rax        # 44920 <console_clear+0x7f>
   41205:	48 89 c7             	mov    %rax,%rdi
   41208:	e8 4a 1a 00 00       	call   42c57 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   4120d:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   41214:	00 
   41215:	e9 b5 00 00 00       	jmp    412cf <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   4121a:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   4121e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41222:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41226:	48 89 ce             	mov    %rcx,%rsi
   41229:	48 89 c7             	mov    %rax,%rdi
   4122c:	e8 f4 21 00 00       	call   43425 <virtual_memory_lookup>
        if (vam.pa != va) {
   41231:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41235:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41239:	74 2c                	je     41267 <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   4123b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4123f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41243:	49 89 d0             	mov    %rdx,%r8
   41246:	48 89 c1             	mov    %rax,%rcx
   41249:	48 8d 05 57 38 00 00 	lea    0x3857(%rip),%rax        # 44aa7 <console_clear+0x206>
   41250:	48 89 c2             	mov    %rax,%rdx
   41253:	be 00 c0 00 00       	mov    $0xc000,%esi
   41258:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4125d:	b8 00 00 00 00       	mov    $0x0,%eax
   41262:	e8 c4 34 00 00       	call   4472b <console_printf>
        }
        assert(vam.pa == va);
   41267:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4126b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4126f:	74 1e                	je     4128f <check_page_table_mappings+0xc6>
   41271:	48 8d 05 39 38 00 00 	lea    0x3839(%rip),%rax        # 44ab1 <console_clear+0x210>
   41278:	48 89 c2             	mov    %rax,%rdx
   4127b:	be 32 02 00 00       	mov    $0x232,%esi
   41280:	48 8d 05 99 36 00 00 	lea    0x3699(%rip),%rax        # 44920 <console_clear+0x7f>
   41287:	48 89 c7             	mov    %rax,%rdi
   4128a:	e8 c8 19 00 00       	call   42c57 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   4128f:	48 8d 05 6a 4d 00 00 	lea    0x4d6a(%rip),%rax        # 46000 <disp_global>
   41296:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4129a:	72 2b                	jb     412c7 <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   4129c:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4129f:	48 98                	cltq   
   412a1:	83 e0 02             	and    $0x2,%eax
   412a4:	48 85 c0             	test   %rax,%rax
   412a7:	75 1e                	jne    412c7 <check_page_table_mappings+0xfe>
   412a9:	48 8d 05 0e 38 00 00 	lea    0x380e(%rip),%rax        # 44abe <console_clear+0x21d>
   412b0:	48 89 c2             	mov    %rax,%rdx
   412b3:	be 34 02 00 00       	mov    $0x234,%esi
   412b8:	48 8d 05 61 36 00 00 	lea    0x3661(%rip),%rax        # 44920 <console_clear+0x7f>
   412bf:	48 89 c7             	mov    %rax,%rdi
   412c2:	e8 90 19 00 00       	call   42c57 <assert_fail>
         va += PAGESIZE) {
   412c7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   412ce:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   412cf:	48 8d 05 32 ad 01 00 	lea    0x1ad32(%rip),%rax        # 5c008 <end>
   412d6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   412da:	0f 82 3a ff ff ff    	jb     4121a <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   412e0:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   412e7:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   412e8:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   412ec:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   412f0:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   412f4:	48 89 ce             	mov    %rcx,%rsi
   412f7:	48 89 c7             	mov    %rax,%rdi
   412fa:	e8 26 21 00 00       	call   43425 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   412ff:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41303:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   41307:	74 1e                	je     41327 <check_page_table_mappings+0x15e>
   41309:	48 8d 05 bf 37 00 00 	lea    0x37bf(%rip),%rax        # 44acf <console_clear+0x22e>
   41310:	48 89 c2             	mov    %rax,%rdx
   41313:	be 3b 02 00 00       	mov    $0x23b,%esi
   41318:	48 8d 05 01 36 00 00 	lea    0x3601(%rip),%rax        # 44920 <console_clear+0x7f>
   4131f:	48 89 c7             	mov    %rax,%rdi
   41322:	e8 30 19 00 00       	call   42c57 <assert_fail>
    assert(vam.perm & PTE_W);
   41327:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4132a:	48 98                	cltq   
   4132c:	83 e0 02             	and    $0x2,%eax
   4132f:	48 85 c0             	test   %rax,%rax
   41332:	75 1e                	jne    41352 <check_page_table_mappings+0x189>
   41334:	48 8d 05 83 37 00 00 	lea    0x3783(%rip),%rax        # 44abe <console_clear+0x21d>
   4133b:	48 89 c2             	mov    %rax,%rdx
   4133e:	be 3c 02 00 00       	mov    $0x23c,%esi
   41343:	48 8d 05 d6 35 00 00 	lea    0x35d6(%rip),%rax        # 44920 <console_clear+0x7f>
   4134a:	48 89 c7             	mov    %rax,%rdi
   4134d:	e8 05 19 00 00       	call   42c57 <assert_fail>
}
   41352:	90                   	nop
   41353:	c9                   	leave  
   41354:	c3                   	ret    

0000000000041355 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   41355:	f3 0f 1e fa          	endbr64 
   41359:	55                   	push   %rbp
   4135a:	48 89 e5             	mov    %rsp,%rbp
   4135d:	48 83 ec 20          	sub    $0x20,%rsp
   41361:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41365:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   41368:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4136b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   4136e:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41375:	48 8b 05 84 4c 01 00 	mov    0x14c84(%rip),%rax        # 56000 <kernel_pagetable>
   4137c:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41380:	75 71                	jne    413f3 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   41382:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41389:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41390:	eb 5b                	jmp    413ed <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   41392:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41395:	48 63 d0             	movslq %eax,%rdx
   41398:	48 89 d0             	mov    %rdx,%rax
   4139b:	48 c1 e0 03          	shl    $0x3,%rax
   4139f:	48 29 d0             	sub    %rdx,%rax
   413a2:	48 c1 e0 05          	shl    $0x5,%rax
   413a6:	48 89 c2             	mov    %rax,%rdx
   413a9:	48 8d 05 38 1d 01 00 	lea    0x11d38(%rip),%rax        # 530e8 <processes+0xc8>
   413b0:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   413b3:	85 c0                	test   %eax,%eax
   413b5:	74 32                	je     413e9 <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   413b7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   413ba:	48 63 d0             	movslq %eax,%rdx
   413bd:	48 89 d0             	mov    %rdx,%rax
   413c0:	48 c1 e0 03          	shl    $0x3,%rax
   413c4:	48 29 d0             	sub    %rdx,%rax
   413c7:	48 c1 e0 05          	shl    $0x5,%rax
   413cb:	48 89 c2             	mov    %rax,%rdx
   413ce:	48 8d 05 1b 1d 01 00 	lea    0x11d1b(%rip),%rax        # 530f0 <processes+0xd0>
   413d5:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   413d9:	48 8b 05 20 4c 01 00 	mov    0x14c20(%rip),%rax        # 56000 <kernel_pagetable>
   413e0:	48 39 c2             	cmp    %rax,%rdx
   413e3:	75 04                	jne    413e9 <check_page_table_ownership+0x94>
                ++expected_refcount;
   413e5:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   413e9:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   413ed:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   413f1:	7e 9f                	jle    41392 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   413f3:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   413f6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   413f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   413fd:	be 00 00 00 00       	mov    $0x0,%esi
   41402:	48 89 c7             	mov    %rax,%rdi
   41405:	e8 03 00 00 00       	call   4140d <check_page_table_ownership_level>
}
   4140a:	90                   	nop
   4140b:	c9                   	leave  
   4140c:	c3                   	ret    

000000000004140d <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   4140d:	f3 0f 1e fa          	endbr64 
   41411:	55                   	push   %rbp
   41412:	48 89 e5             	mov    %rsp,%rbp
   41415:	48 83 ec 30          	sub    $0x30,%rsp
   41419:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4141d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41420:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41423:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41426:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4142a:	48 c1 e8 0c          	shr    $0xc,%rax
   4142e:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41433:	7e 1e                	jle    41453 <check_page_table_ownership_level+0x46>
   41435:	48 8d 05 a4 36 00 00 	lea    0x36a4(%rip),%rax        # 44ae0 <console_clear+0x23f>
   4143c:	48 89 c2             	mov    %rax,%rdx
   4143f:	be 59 02 00 00       	mov    $0x259,%esi
   41444:	48 8d 05 d5 34 00 00 	lea    0x34d5(%rip),%rax        # 44920 <console_clear+0x7f>
   4144b:	48 89 c7             	mov    %rax,%rdi
   4144e:	e8 04 18 00 00       	call   42c57 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41453:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41457:	48 c1 e8 0c          	shr    $0xc,%rax
   4145b:	48 98                	cltq   
   4145d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41461:	48 8d 05 d8 29 01 00 	lea    0x129d8(%rip),%rax        # 53e40 <pageinfo>
   41468:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4146c:	0f be c0             	movsbl %al,%eax
   4146f:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41472:	74 1e                	je     41492 <check_page_table_ownership_level+0x85>
   41474:	48 8d 05 7d 36 00 00 	lea    0x367d(%rip),%rax        # 44af8 <console_clear+0x257>
   4147b:	48 89 c2             	mov    %rax,%rdx
   4147e:	be 5a 02 00 00       	mov    $0x25a,%esi
   41483:	48 8d 05 96 34 00 00 	lea    0x3496(%rip),%rax        # 44920 <console_clear+0x7f>
   4148a:	48 89 c7             	mov    %rax,%rdi
   4148d:	e8 c5 17 00 00       	call   42c57 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41492:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41496:	48 c1 e8 0c          	shr    $0xc,%rax
   4149a:	48 98                	cltq   
   4149c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   414a0:	48 8d 05 9a 29 01 00 	lea    0x1299a(%rip),%rax        # 53e41 <pageinfo+0x1>
   414a7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   414ab:	0f be c0             	movsbl %al,%eax
   414ae:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   414b1:	74 1e                	je     414d1 <check_page_table_ownership_level+0xc4>
   414b3:	48 8d 05 66 36 00 00 	lea    0x3666(%rip),%rax        # 44b20 <console_clear+0x27f>
   414ba:	48 89 c2             	mov    %rax,%rdx
   414bd:	be 5b 02 00 00       	mov    $0x25b,%esi
   414c2:	48 8d 05 57 34 00 00 	lea    0x3457(%rip),%rax        # 44920 <console_clear+0x7f>
   414c9:	48 89 c7             	mov    %rax,%rdi
   414cc:	e8 86 17 00 00       	call   42c57 <assert_fail>
    if (level < 3) {
   414d1:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   414d5:	7f 5b                	jg     41532 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   414d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   414de:	eb 49                	jmp    41529 <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   414e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   414e4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   414e7:	48 63 d2             	movslq %edx,%rdx
   414ea:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   414ee:	48 85 c0             	test   %rax,%rax
   414f1:	74 32                	je     41525 <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   414f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   414f7:	8b 55 fc             	mov    -0x4(%rbp),%edx
   414fa:	48 63 d2             	movslq %edx,%rdx
   414fd:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41501:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41507:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4150b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4150e:	8d 70 01             	lea    0x1(%rax),%esi
   41511:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41514:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41518:	b9 01 00 00 00       	mov    $0x1,%ecx
   4151d:	48 89 c7             	mov    %rax,%rdi
   41520:	e8 e8 fe ff ff       	call   4140d <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41525:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41529:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41530:	7e ae                	jle    414e0 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   41532:	90                   	nop
   41533:	c9                   	leave  
   41534:	c3                   	ret    

0000000000041535 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41535:	f3 0f 1e fa          	endbr64 
   41539:	55                   	push   %rbp
   4153a:	48 89 e5             	mov    %rsp,%rbp
   4153d:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41541:	8b 05 a1 1b 01 00    	mov    0x11ba1(%rip),%eax        # 530e8 <processes+0xc8>
   41547:	85 c0                	test   %eax,%eax
   41549:	74 1e                	je     41569 <check_virtual_memory+0x34>
   4154b:	48 8d 05 fe 35 00 00 	lea    0x35fe(%rip),%rax        # 44b50 <console_clear+0x2af>
   41552:	48 89 c2             	mov    %rax,%rdx
   41555:	be 6e 02 00 00       	mov    $0x26e,%esi
   4155a:	48 8d 05 bf 33 00 00 	lea    0x33bf(%rip),%rax        # 44920 <console_clear+0x7f>
   41561:	48 89 c7             	mov    %rax,%rdi
   41564:	e8 ee 16 00 00       	call   42c57 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41569:	48 8b 05 90 4a 01 00 	mov    0x14a90(%rip),%rax        # 56000 <kernel_pagetable>
   41570:	48 89 c7             	mov    %rax,%rdi
   41573:	e8 51 fc ff ff       	call   411c9 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41578:	48 8b 05 81 4a 01 00 	mov    0x14a81(%rip),%rax        # 56000 <kernel_pagetable>
   4157f:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41584:	48 89 c7             	mov    %rax,%rdi
   41587:	e8 c9 fd ff ff       	call   41355 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   4158c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41593:	e9 b4 00 00 00       	jmp    4164c <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   41598:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4159b:	48 63 d0             	movslq %eax,%rdx
   4159e:	48 89 d0             	mov    %rdx,%rax
   415a1:	48 c1 e0 03          	shl    $0x3,%rax
   415a5:	48 29 d0             	sub    %rdx,%rax
   415a8:	48 c1 e0 05          	shl    $0x5,%rax
   415ac:	48 89 c2             	mov    %rax,%rdx
   415af:	48 8d 05 32 1b 01 00 	lea    0x11b32(%rip),%rax        # 530e8 <processes+0xc8>
   415b6:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   415b9:	85 c0                	test   %eax,%eax
   415bb:	0f 84 87 00 00 00    	je     41648 <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   415c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   415c4:	48 63 d0             	movslq %eax,%rdx
   415c7:	48 89 d0             	mov    %rdx,%rax
   415ca:	48 c1 e0 03          	shl    $0x3,%rax
   415ce:	48 29 d0             	sub    %rdx,%rax
   415d1:	48 c1 e0 05          	shl    $0x5,%rax
   415d5:	48 89 c2             	mov    %rax,%rdx
   415d8:	48 8d 05 11 1b 01 00 	lea    0x11b11(%rip),%rax        # 530f0 <processes+0xd0>
   415df:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   415e3:	48 8b 05 16 4a 01 00 	mov    0x14a16(%rip),%rax        # 56000 <kernel_pagetable>
   415ea:	48 39 c2             	cmp    %rax,%rdx
   415ed:	74 59                	je     41648 <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   415ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
   415f2:	48 63 d0             	movslq %eax,%rdx
   415f5:	48 89 d0             	mov    %rdx,%rax
   415f8:	48 c1 e0 03          	shl    $0x3,%rax
   415fc:	48 29 d0             	sub    %rdx,%rax
   415ff:	48 c1 e0 05          	shl    $0x5,%rax
   41603:	48 89 c2             	mov    %rax,%rdx
   41606:	48 8d 05 e3 1a 01 00 	lea    0x11ae3(%rip),%rax        # 530f0 <processes+0xd0>
   4160d:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41611:	48 89 c7             	mov    %rax,%rdi
   41614:	e8 b0 fb ff ff       	call   411c9 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41619:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4161c:	48 63 d0             	movslq %eax,%rdx
   4161f:	48 89 d0             	mov    %rdx,%rax
   41622:	48 c1 e0 03          	shl    $0x3,%rax
   41626:	48 29 d0             	sub    %rdx,%rax
   41629:	48 c1 e0 05          	shl    $0x5,%rax
   4162d:	48 89 c2             	mov    %rax,%rdx
   41630:	48 8d 05 b9 1a 01 00 	lea    0x11ab9(%rip),%rax        # 530f0 <processes+0xd0>
   41637:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4163b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4163e:	89 d6                	mov    %edx,%esi
   41640:	48 89 c7             	mov    %rax,%rdi
   41643:	e8 0d fd ff ff       	call   41355 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41648:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4164c:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41650:	0f 8e 42 ff ff ff    	jle    41598 <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41656:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4165d:	e9 8b 00 00 00       	jmp    416ed <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41662:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41665:	48 98                	cltq   
   41667:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4166b:	48 8d 05 cf 27 01 00 	lea    0x127cf(%rip),%rax        # 53e41 <pageinfo+0x1>
   41672:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41676:	84 c0                	test   %al,%al
   41678:	7e 6f                	jle    416e9 <check_virtual_memory+0x1b4>
   4167a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4167d:	48 98                	cltq   
   4167f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41683:	48 8d 05 b6 27 01 00 	lea    0x127b6(%rip),%rax        # 53e40 <pageinfo>
   4168a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4168e:	84 c0                	test   %al,%al
   41690:	78 57                	js     416e9 <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41692:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41695:	48 98                	cltq   
   41697:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4169b:	48 8d 05 9e 27 01 00 	lea    0x1279e(%rip),%rax        # 53e40 <pageinfo>
   416a2:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   416a6:	0f be c0             	movsbl %al,%eax
   416a9:	48 63 d0             	movslq %eax,%rdx
   416ac:	48 89 d0             	mov    %rdx,%rax
   416af:	48 c1 e0 03          	shl    $0x3,%rax
   416b3:	48 29 d0             	sub    %rdx,%rax
   416b6:	48 c1 e0 05          	shl    $0x5,%rax
   416ba:	48 89 c2             	mov    %rax,%rdx
   416bd:	48 8d 05 24 1a 01 00 	lea    0x11a24(%rip),%rax        # 530e8 <processes+0xc8>
   416c4:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   416c7:	85 c0                	test   %eax,%eax
   416c9:	75 1e                	jne    416e9 <check_virtual_memory+0x1b4>
   416cb:	48 8d 05 9e 34 00 00 	lea    0x349e(%rip),%rax        # 44b70 <console_clear+0x2cf>
   416d2:	48 89 c2             	mov    %rax,%rdx
   416d5:	be 85 02 00 00       	mov    $0x285,%esi
   416da:	48 8d 05 3f 32 00 00 	lea    0x323f(%rip),%rax        # 44920 <console_clear+0x7f>
   416e1:	48 89 c7             	mov    %rax,%rdi
   416e4:	e8 6e 15 00 00       	call   42c57 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   416e9:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   416ed:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   416f4:	0f 8e 68 ff ff ff    	jle    41662 <check_virtual_memory+0x12d>
        }
    }
}
   416fa:	90                   	nop
   416fb:	90                   	nop
   416fc:	c9                   	leave  
   416fd:	c3                   	ret    

00000000000416fe <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   416fe:	f3 0f 1e fa          	endbr64 
   41702:	55                   	push   %rbp
   41703:	48 89 e5             	mov    %rsp,%rbp
   41706:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4170a:	48 8d 05 b5 34 00 00 	lea    0x34b5(%rip),%rax        # 44bc6 <memstate_colors+0x26>
   41711:	48 89 c2             	mov    %rax,%rdx
   41714:	be 00 0f 00 00       	mov    $0xf00,%esi
   41719:	bf 20 00 00 00       	mov    $0x20,%edi
   4171e:	b8 00 00 00 00       	mov    $0x0,%eax
   41723:	e8 03 30 00 00       	call   4472b <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41728:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4172f:	e9 1b 01 00 00       	jmp    4184f <memshow_physical+0x151>
        if (pn % 64 == 0) {
   41734:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41737:	83 e0 3f             	and    $0x3f,%eax
   4173a:	85 c0                	test   %eax,%eax
   4173c:	75 40                	jne    4177e <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   4173e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41741:	c1 e0 0c             	shl    $0xc,%eax
   41744:	89 c2                	mov    %eax,%edx
   41746:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41749:	8d 48 3f             	lea    0x3f(%rax),%ecx
   4174c:	85 c0                	test   %eax,%eax
   4174e:	0f 48 c1             	cmovs  %ecx,%eax
   41751:	c1 f8 06             	sar    $0x6,%eax
   41754:	8d 48 01             	lea    0x1(%rax),%ecx
   41757:	89 c8                	mov    %ecx,%eax
   41759:	c1 e0 02             	shl    $0x2,%eax
   4175c:	01 c8                	add    %ecx,%eax
   4175e:	c1 e0 04             	shl    $0x4,%eax
   41761:	83 c0 03             	add    $0x3,%eax
   41764:	89 d1                	mov    %edx,%ecx
   41766:	48 8d 15 69 34 00 00 	lea    0x3469(%rip),%rdx        # 44bd6 <memstate_colors+0x36>
   4176d:	be 00 0f 00 00       	mov    $0xf00,%esi
   41772:	89 c7                	mov    %eax,%edi
   41774:	b8 00 00 00 00       	mov    $0x0,%eax
   41779:	e8 ad 2f 00 00       	call   4472b <console_printf>
        }

        int owner = pageinfo[pn].owner;
   4177e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41781:	48 98                	cltq   
   41783:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41787:	48 8d 05 b2 26 01 00 	lea    0x126b2(%rip),%rax        # 53e40 <pageinfo>
   4178e:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41792:	0f be c0             	movsbl %al,%eax
   41795:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41798:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4179b:	48 98                	cltq   
   4179d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   417a1:	48 8d 05 99 26 01 00 	lea    0x12699(%rip),%rax        # 53e41 <pageinfo+0x1>
   417a8:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   417ac:	84 c0                	test   %al,%al
   417ae:	75 07                	jne    417b7 <memshow_physical+0xb9>
            owner = PO_FREE;
   417b0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   417b7:	8b 45 f8             	mov    -0x8(%rbp),%eax
   417ba:	83 c0 02             	add    $0x2,%eax
   417bd:	48 98                	cltq   
   417bf:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   417c3:	48 8d 05 d6 33 00 00 	lea    0x33d6(%rip),%rax        # 44ba0 <memstate_colors>
   417ca:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   417ce:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   417d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417d5:	48 98                	cltq   
   417d7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   417db:	48 8d 05 5f 26 01 00 	lea    0x1265f(%rip),%rax        # 53e41 <pageinfo+0x1>
   417e2:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   417e6:	3c 01                	cmp    $0x1,%al
   417e8:	7e 1c                	jle    41806 <memshow_physical+0x108>
   417ea:	48 8d 05 0f 68 07 00 	lea    0x7680f(%rip),%rax        # b8000 <console>
   417f1:	48 c1 e8 0c          	shr    $0xc,%rax
   417f5:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   417f8:	74 0c                	je     41806 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   417fa:	b8 53 00 00 00       	mov    $0x53,%eax
   417ff:	80 cc 0f             	or     $0xf,%ah
   41802:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41806:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41809:	8d 50 3f             	lea    0x3f(%rax),%edx
   4180c:	85 c0                	test   %eax,%eax
   4180e:	0f 48 c2             	cmovs  %edx,%eax
   41811:	c1 f8 06             	sar    $0x6,%eax
   41814:	8d 50 01             	lea    0x1(%rax),%edx
   41817:	89 d0                	mov    %edx,%eax
   41819:	c1 e0 02             	shl    $0x2,%eax
   4181c:	01 d0                	add    %edx,%eax
   4181e:	c1 e0 04             	shl    $0x4,%eax
   41821:	89 c1                	mov    %eax,%ecx
   41823:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41826:	99                   	cltd   
   41827:	c1 ea 1a             	shr    $0x1a,%edx
   4182a:	01 d0                	add    %edx,%eax
   4182c:	83 e0 3f             	and    $0x3f,%eax
   4182f:	29 d0                	sub    %edx,%eax
   41831:	83 c0 0c             	add    $0xc,%eax
   41834:	01 c8                	add    %ecx,%eax
   41836:	48 98                	cltq   
   41838:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4183c:	48 8d 15 bd 67 07 00 	lea    0x767bd(%rip),%rdx        # b8000 <console>
   41843:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41847:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4184b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4184f:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41856:	0f 8e d8 fe ff ff    	jle    41734 <memshow_physical+0x36>
    }
}
   4185c:	90                   	nop
   4185d:	90                   	nop
   4185e:	c9                   	leave  
   4185f:	c3                   	ret    

0000000000041860 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41860:	f3 0f 1e fa          	endbr64 
   41864:	55                   	push   %rbp
   41865:	48 89 e5             	mov    %rsp,%rbp
   41868:	48 83 ec 40          	sub    $0x40,%rsp
   4186c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41870:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41874:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41878:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4187e:	48 89 c2             	mov    %rax,%rdx
   41881:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41885:	48 39 c2             	cmp    %rax,%rdx
   41888:	74 1e                	je     418a8 <memshow_virtual+0x48>
   4188a:	48 8d 05 4f 33 00 00 	lea    0x334f(%rip),%rax        # 44be0 <memstate_colors+0x40>
   41891:	48 89 c2             	mov    %rax,%rdx
   41894:	be b6 02 00 00       	mov    $0x2b6,%esi
   41899:	48 8d 05 80 30 00 00 	lea    0x3080(%rip),%rax        # 44920 <console_clear+0x7f>
   418a0:	48 89 c7             	mov    %rax,%rdi
   418a3:	e8 af 13 00 00       	call   42c57 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   418a8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   418ac:	48 89 c1             	mov    %rax,%rcx
   418af:	48 8d 05 57 33 00 00 	lea    0x3357(%rip),%rax        # 44c0d <memstate_colors+0x6d>
   418b6:	48 89 c2             	mov    %rax,%rdx
   418b9:	be 00 0f 00 00       	mov    $0xf00,%esi
   418be:	bf 3a 03 00 00       	mov    $0x33a,%edi
   418c3:	b8 00 00 00 00       	mov    $0x0,%eax
   418c8:	e8 5e 2e 00 00       	call   4472b <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   418cd:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   418d4:	00 
   418d5:	e9 b4 01 00 00       	jmp    41a8e <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   418da:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   418de:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   418e2:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   418e6:	48 89 ce             	mov    %rcx,%rsi
   418e9:	48 89 c7             	mov    %rax,%rdi
   418ec:	e8 34 1b 00 00       	call   43425 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   418f1:	8b 45 d0             	mov    -0x30(%rbp),%eax
   418f4:	85 c0                	test   %eax,%eax
   418f6:	79 0b                	jns    41903 <memshow_virtual+0xa3>
            color = ' ';
   418f8:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   418fe:	e9 ff 00 00 00       	jmp    41a02 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41903:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41907:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4190d:	76 1e                	jbe    4192d <memshow_virtual+0xcd>
   4190f:	48 8d 05 14 33 00 00 	lea    0x3314(%rip),%rax        # 44c2a <memstate_colors+0x8a>
   41916:	48 89 c2             	mov    %rax,%rdx
   41919:	be bf 02 00 00       	mov    $0x2bf,%esi
   4191e:	48 8d 05 fb 2f 00 00 	lea    0x2ffb(%rip),%rax        # 44920 <console_clear+0x7f>
   41925:	48 89 c7             	mov    %rax,%rdi
   41928:	e8 2a 13 00 00       	call   42c57 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   4192d:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41930:	48 98                	cltq   
   41932:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41936:	48 8d 05 03 25 01 00 	lea    0x12503(%rip),%rax        # 53e40 <pageinfo>
   4193d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41941:	0f be c0             	movsbl %al,%eax
   41944:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41947:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4194a:	48 98                	cltq   
   4194c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41950:	48 8d 05 ea 24 01 00 	lea    0x124ea(%rip),%rax        # 53e41 <pageinfo+0x1>
   41957:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4195b:	84 c0                	test   %al,%al
   4195d:	75 07                	jne    41966 <memshow_virtual+0x106>
                owner = PO_FREE;
   4195f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41966:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41969:	83 c0 02             	add    $0x2,%eax
   4196c:	48 98                	cltq   
   4196e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41972:	48 8d 05 27 32 00 00 	lea    0x3227(%rip),%rax        # 44ba0 <memstate_colors>
   41979:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   4197d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41981:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41984:	48 98                	cltq   
   41986:	83 e0 04             	and    $0x4,%eax
   41989:	48 85 c0             	test   %rax,%rax
   4198c:	74 27                	je     419b5 <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4198e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41992:	c1 e0 04             	shl    $0x4,%eax
   41995:	66 25 00 f0          	and    $0xf000,%ax
   41999:	89 c2                	mov    %eax,%edx
   4199b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4199f:	c1 f8 04             	sar    $0x4,%eax
   419a2:	66 25 00 0f          	and    $0xf00,%ax
   419a6:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   419a8:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419ac:	0f b6 c0             	movzbl %al,%eax
   419af:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   419b1:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   419b5:	8b 45 d0             	mov    -0x30(%rbp),%eax
   419b8:	48 98                	cltq   
   419ba:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   419be:	48 8d 05 7c 24 01 00 	lea    0x1247c(%rip),%rax        # 53e41 <pageinfo+0x1>
   419c5:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   419c9:	3c 01                	cmp    $0x1,%al
   419cb:	7e 35                	jle    41a02 <memshow_virtual+0x1a2>
   419cd:	48 8d 05 2c 66 07 00 	lea    0x7662c(%rip),%rax        # b8000 <console>
   419d4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   419d8:	74 28                	je     41a02 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   419da:	b8 53 00 00 00       	mov    $0x53,%eax
   419df:	89 c2                	mov    %eax,%edx
   419e1:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419e5:	66 25 00 f0          	and    $0xf000,%ax
   419e9:	09 d0                	or     %edx,%eax
   419eb:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   419ef:	8b 45 e0             	mov    -0x20(%rbp),%eax
   419f2:	48 98                	cltq   
   419f4:	83 e0 04             	and    $0x4,%eax
   419f7:	48 85 c0             	test   %rax,%rax
   419fa:	75 06                	jne    41a02 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   419fc:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41a02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a06:	48 c1 e8 0c          	shr    $0xc,%rax
   41a0a:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41a0d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a10:	83 e0 3f             	and    $0x3f,%eax
   41a13:	85 c0                	test   %eax,%eax
   41a15:	75 39                	jne    41a50 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41a17:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a1a:	c1 e8 06             	shr    $0x6,%eax
   41a1d:	89 c2                	mov    %eax,%edx
   41a1f:	89 d0                	mov    %edx,%eax
   41a21:	c1 e0 02             	shl    $0x2,%eax
   41a24:	01 d0                	add    %edx,%eax
   41a26:	c1 e0 04             	shl    $0x4,%eax
   41a29:	05 73 03 00 00       	add    $0x373,%eax
   41a2e:	89 c7                	mov    %eax,%edi
   41a30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a34:	48 89 c1             	mov    %rax,%rcx
   41a37:	48 8d 05 98 31 00 00 	lea    0x3198(%rip),%rax        # 44bd6 <memstate_colors+0x36>
   41a3e:	48 89 c2             	mov    %rax,%rdx
   41a41:	be 00 0f 00 00       	mov    $0xf00,%esi
   41a46:	b8 00 00 00 00       	mov    $0x0,%eax
   41a4b:	e8 db 2c 00 00       	call   4472b <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41a50:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a53:	c1 e8 06             	shr    $0x6,%eax
   41a56:	89 c2                	mov    %eax,%edx
   41a58:	89 d0                	mov    %edx,%eax
   41a5a:	c1 e0 02             	shl    $0x2,%eax
   41a5d:	01 d0                	add    %edx,%eax
   41a5f:	c1 e0 04             	shl    $0x4,%eax
   41a62:	89 c2                	mov    %eax,%edx
   41a64:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a67:	83 e0 3f             	and    $0x3f,%eax
   41a6a:	01 d0                	add    %edx,%eax
   41a6c:	05 7c 03 00 00       	add    $0x37c,%eax
   41a71:	89 c0                	mov    %eax,%eax
   41a73:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41a77:	48 8d 15 82 65 07 00 	lea    0x76582(%rip),%rdx        # b8000 <console>
   41a7e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41a82:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41a86:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41a8d:	00 
   41a8e:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41a95:	00 
   41a96:	0f 86 3e fe ff ff    	jbe    418da <memshow_virtual+0x7a>
    }
}
   41a9c:	90                   	nop
   41a9d:	90                   	nop
   41a9e:	c9                   	leave  
   41a9f:	c3                   	ret    

0000000000041aa0 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41aa0:	f3 0f 1e fa          	endbr64 
   41aa4:	55                   	push   %rbp
   41aa5:	48 89 e5             	mov    %rsp,%rbp
   41aa8:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41aac:	8b 05 8e 27 01 00    	mov    0x1278e(%rip),%eax        # 54240 <last_ticks.1>
   41ab2:	85 c0                	test   %eax,%eax
   41ab4:	74 13                	je     41ac9 <memshow_virtual_animate+0x29>
   41ab6:	8b 05 64 23 01 00    	mov    0x12364(%rip),%eax        # 53e20 <ticks>
   41abc:	8b 15 7e 27 01 00    	mov    0x1277e(%rip),%edx        # 54240 <last_ticks.1>
   41ac2:	29 d0                	sub    %edx,%eax
   41ac4:	83 f8 31             	cmp    $0x31,%eax
   41ac7:	76 2c                	jbe    41af5 <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   41ac9:	8b 05 51 23 01 00    	mov    0x12351(%rip),%eax        # 53e20 <ticks>
   41acf:	89 05 6b 27 01 00    	mov    %eax,0x1276b(%rip)        # 54240 <last_ticks.1>
        ++showing;
   41ad5:	8b 05 29 45 00 00    	mov    0x4529(%rip),%eax        # 46004 <showing.0>
   41adb:	83 c0 01             	add    $0x1,%eax
   41ade:	89 05 20 45 00 00    	mov    %eax,0x4520(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41ae4:	eb 0f                	jmp    41af5 <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41ae6:	8b 05 18 45 00 00    	mov    0x4518(%rip),%eax        # 46004 <showing.0>
   41aec:	83 c0 01             	add    $0x1,%eax
   41aef:	89 05 0f 45 00 00    	mov    %eax,0x450f(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41af5:	8b 05 09 45 00 00    	mov    0x4509(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41afb:	83 f8 20             	cmp    $0x20,%eax
   41afe:	7f 6b                	jg     41b6b <memshow_virtual_animate+0xcb>
   41b00:	8b 05 fe 44 00 00    	mov    0x44fe(%rip),%eax        # 46004 <showing.0>
   41b06:	99                   	cltd   
   41b07:	c1 ea 1c             	shr    $0x1c,%edx
   41b0a:	01 d0                	add    %edx,%eax
   41b0c:	83 e0 0f             	and    $0xf,%eax
   41b0f:	29 d0                	sub    %edx,%eax
   41b11:	48 63 d0             	movslq %eax,%rdx
   41b14:	48 89 d0             	mov    %rdx,%rax
   41b17:	48 c1 e0 03          	shl    $0x3,%rax
   41b1b:	48 29 d0             	sub    %rdx,%rax
   41b1e:	48 c1 e0 05          	shl    $0x5,%rax
   41b22:	48 89 c2             	mov    %rax,%rdx
   41b25:	48 8d 05 bc 15 01 00 	lea    0x115bc(%rip),%rax        # 530e8 <processes+0xc8>
   41b2c:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41b2f:	85 c0                	test   %eax,%eax
   41b31:	74 b3                	je     41ae6 <memshow_virtual_animate+0x46>
   41b33:	8b 05 cb 44 00 00    	mov    0x44cb(%rip),%eax        # 46004 <showing.0>
   41b39:	99                   	cltd   
   41b3a:	c1 ea 1c             	shr    $0x1c,%edx
   41b3d:	01 d0                	add    %edx,%eax
   41b3f:	83 e0 0f             	and    $0xf,%eax
   41b42:	29 d0                	sub    %edx,%eax
   41b44:	48 63 d0             	movslq %eax,%rdx
   41b47:	48 89 d0             	mov    %rdx,%rax
   41b4a:	48 c1 e0 03          	shl    $0x3,%rax
   41b4e:	48 29 d0             	sub    %rdx,%rax
   41b51:	48 c1 e0 05          	shl    $0x5,%rax
   41b55:	48 89 c2             	mov    %rax,%rdx
   41b58:	48 8d 05 99 15 01 00 	lea    0x11599(%rip),%rax        # 530f8 <processes+0xd8>
   41b5f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41b63:	84 c0                	test   %al,%al
   41b65:	0f 84 7b ff ff ff    	je     41ae6 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   41b6b:	8b 05 93 44 00 00    	mov    0x4493(%rip),%eax        # 46004 <showing.0>
   41b71:	99                   	cltd   
   41b72:	c1 ea 1c             	shr    $0x1c,%edx
   41b75:	01 d0                	add    %edx,%eax
   41b77:	83 e0 0f             	and    $0xf,%eax
   41b7a:	29 d0                	sub    %edx,%eax
   41b7c:	89 05 82 44 00 00    	mov    %eax,0x4482(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41b82:	8b 05 7c 44 00 00    	mov    0x447c(%rip),%eax        # 46004 <showing.0>
   41b88:	48 63 d0             	movslq %eax,%rdx
   41b8b:	48 89 d0             	mov    %rdx,%rax
   41b8e:	48 c1 e0 03          	shl    $0x3,%rax
   41b92:	48 29 d0             	sub    %rdx,%rax
   41b95:	48 c1 e0 05          	shl    $0x5,%rax
   41b99:	48 89 c2             	mov    %rax,%rdx
   41b9c:	48 8d 05 45 15 01 00 	lea    0x11545(%rip),%rax        # 530e8 <processes+0xc8>
   41ba3:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41ba6:	85 c0                	test   %eax,%eax
   41ba8:	74 59                	je     41c03 <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41baa:	8b 15 54 44 00 00    	mov    0x4454(%rip),%edx        # 46004 <showing.0>
   41bb0:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41bb4:	89 d1                	mov    %edx,%ecx
   41bb6:	48 8d 15 87 30 00 00 	lea    0x3087(%rip),%rdx        # 44c44 <memstate_colors+0xa4>
   41bbd:	be 04 00 00 00       	mov    $0x4,%esi
   41bc2:	48 89 c7             	mov    %rax,%rdi
   41bc5:	b8 00 00 00 00       	mov    $0x0,%eax
   41bca:	e8 77 2c 00 00       	call   44846 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41bcf:	8b 05 2f 44 00 00    	mov    0x442f(%rip),%eax        # 46004 <showing.0>
   41bd5:	48 63 d0             	movslq %eax,%rdx
   41bd8:	48 89 d0             	mov    %rdx,%rax
   41bdb:	48 c1 e0 03          	shl    $0x3,%rax
   41bdf:	48 29 d0             	sub    %rdx,%rax
   41be2:	48 c1 e0 05          	shl    $0x5,%rax
   41be6:	48 89 c2             	mov    %rax,%rdx
   41be9:	48 8d 05 00 15 01 00 	lea    0x11500(%rip),%rax        # 530f0 <processes+0xd0>
   41bf0:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41bf4:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41bf8:	48 89 d6             	mov    %rdx,%rsi
   41bfb:	48 89 c7             	mov    %rax,%rdi
   41bfe:	e8 5d fc ff ff       	call   41860 <memshow_virtual>
    }
}
   41c03:	90                   	nop
   41c04:	c9                   	leave  
   41c05:	c3                   	ret    

0000000000041c06 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41c06:	f3 0f 1e fa          	endbr64 
   41c0a:	55                   	push   %rbp
   41c0b:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41c0e:	e8 5f 01 00 00       	call   41d72 <segments_init>
    interrupt_init();
   41c13:	e8 44 04 00 00       	call   4205c <interrupt_init>
    virtual_memory_init();
   41c18:	e8 11 11 00 00       	call   42d2e <virtual_memory_init>
}
   41c1d:	90                   	nop
   41c1e:	5d                   	pop    %rbp
   41c1f:	c3                   	ret    

0000000000041c20 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41c20:	f3 0f 1e fa          	endbr64 
   41c24:	55                   	push   %rbp
   41c25:	48 89 e5             	mov    %rsp,%rbp
   41c28:	48 83 ec 18          	sub    $0x18,%rsp
   41c2c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41c30:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41c34:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41c37:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41c3a:	48 98                	cltq   
   41c3c:	48 c1 e0 2d          	shl    $0x2d,%rax
   41c40:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41c44:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41c4b:	90 00 00 
   41c4e:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41c51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c55:	48 89 10             	mov    %rdx,(%rax)
}
   41c58:	90                   	nop
   41c59:	c9                   	leave  
   41c5a:	c3                   	ret    

0000000000041c5b <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41c5b:	f3 0f 1e fa          	endbr64 
   41c5f:	55                   	push   %rbp
   41c60:	48 89 e5             	mov    %rsp,%rbp
   41c63:	48 83 ec 28          	sub    $0x28,%rsp
   41c67:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41c6b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41c6f:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41c72:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41c76:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41c7a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c7e:	48 c1 e0 10          	shl    $0x10,%rax
   41c82:	48 89 c2             	mov    %rax,%rdx
   41c85:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41c8c:	00 00 00 
   41c8f:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41c92:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c96:	48 c1 e0 20          	shl    $0x20,%rax
   41c9a:	48 89 c1             	mov    %rax,%rcx
   41c9d:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41ca4:	00 00 ff 
   41ca7:	48 21 c8             	and    %rcx,%rax
   41caa:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41cad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41cb1:	48 83 e8 01          	sub    $0x1,%rax
   41cb5:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41cb8:	48 09 d0             	or     %rdx,%rax
        | type
   41cbb:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41cbf:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41cc2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41cc5:	48 98                	cltq   
   41cc7:	48 c1 e0 2d          	shl    $0x2d,%rax
   41ccb:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41cce:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41cd5:	80 00 00 
   41cd8:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41cdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41cdf:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41ce2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ce6:	48 83 c0 08          	add    $0x8,%rax
   41cea:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41cee:	48 c1 ea 20          	shr    $0x20,%rdx
   41cf2:	48 89 10             	mov    %rdx,(%rax)
}
   41cf5:	90                   	nop
   41cf6:	c9                   	leave  
   41cf7:	c3                   	ret    

0000000000041cf8 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41cf8:	f3 0f 1e fa          	endbr64 
   41cfc:	55                   	push   %rbp
   41cfd:	48 89 e5             	mov    %rsp,%rbp
   41d00:	48 83 ec 20          	sub    $0x20,%rsp
   41d04:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41d08:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41d0c:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41d0f:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41d13:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d17:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41d1a:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41d1e:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41d21:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41d24:	48 98                	cltq   
   41d26:	48 c1 e0 2d          	shl    $0x2d,%rax
   41d2a:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41d2d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d31:	48 c1 e0 20          	shl    $0x20,%rax
   41d35:	48 89 c1             	mov    %rax,%rcx
   41d38:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41d3f:	00 ff ff 
   41d42:	48 21 c8             	and    %rcx,%rax
   41d45:	48 09 c2             	or     %rax,%rdx
   41d48:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41d4f:	80 00 00 
   41d52:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41d55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d59:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41d5c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d60:	48 c1 e8 20          	shr    $0x20,%rax
   41d64:	48 89 c2             	mov    %rax,%rdx
   41d67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d6b:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41d6f:	90                   	nop
   41d70:	c9                   	leave  
   41d71:	c3                   	ret    

0000000000041d72 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41d72:	f3 0f 1e fa          	endbr64 
   41d76:	55                   	push   %rbp
   41d77:	48 89 e5             	mov    %rsp,%rbp
   41d7a:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41d7e:	48 c7 05 d7 24 01 00 	movq   $0x0,0x124d7(%rip)        # 54260 <segments>
   41d85:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41d89:	ba 00 00 00 00       	mov    $0x0,%edx
   41d8e:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41d95:	08 20 00 
   41d98:	48 89 c6             	mov    %rax,%rsi
   41d9b:	48 8d 05 c6 24 01 00 	lea    0x124c6(%rip),%rax        # 54268 <segments+0x8>
   41da2:	48 89 c7             	mov    %rax,%rdi
   41da5:	e8 76 fe ff ff       	call   41c20 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41daa:	ba 03 00 00 00       	mov    $0x3,%edx
   41daf:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41db6:	08 20 00 
   41db9:	48 89 c6             	mov    %rax,%rsi
   41dbc:	48 8d 05 ad 24 01 00 	lea    0x124ad(%rip),%rax        # 54270 <segments+0x10>
   41dc3:	48 89 c7             	mov    %rax,%rdi
   41dc6:	e8 55 fe ff ff       	call   41c20 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41dcb:	ba 00 00 00 00       	mov    $0x0,%edx
   41dd0:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41dd7:	02 00 00 
   41dda:	48 89 c6             	mov    %rax,%rsi
   41ddd:	48 8d 05 94 24 01 00 	lea    0x12494(%rip),%rax        # 54278 <segments+0x18>
   41de4:	48 89 c7             	mov    %rax,%rdi
   41de7:	e8 34 fe ff ff       	call   41c20 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41dec:	ba 03 00 00 00       	mov    $0x3,%edx
   41df1:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41df8:	02 00 00 
   41dfb:	48 89 c6             	mov    %rax,%rsi
   41dfe:	48 8d 05 7b 24 01 00 	lea    0x1247b(%rip),%rax        # 54280 <segments+0x20>
   41e05:	48 89 c7             	mov    %rax,%rdi
   41e08:	e8 13 fe ff ff       	call   41c20 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41e0d:	48 8d 05 8c 34 01 00 	lea    0x1348c(%rip),%rax        # 552a0 <kernel_task_descriptor>
   41e14:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41e1a:	48 89 c1             	mov    %rax,%rcx
   41e1d:	ba 00 00 00 00       	mov    $0x0,%edx
   41e22:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41e29:	09 00 00 
   41e2c:	48 89 c6             	mov    %rax,%rsi
   41e2f:	48 8d 05 52 24 01 00 	lea    0x12452(%rip),%rax        # 54288 <segments+0x28>
   41e36:	48 89 c7             	mov    %rax,%rdi
   41e39:	e8 1d fe ff ff       	call   41c5b <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41e3e:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41e44:	48 8d 05 15 24 01 00 	lea    0x12415(%rip),%rax        # 54260 <segments>
   41e4b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41e4f:	ba 60 00 00 00       	mov    $0x60,%edx
   41e54:	be 00 00 00 00       	mov    $0x0,%esi
   41e59:	48 8d 05 40 34 01 00 	lea    0x13440(%rip),%rax        # 552a0 <kernel_task_descriptor>
   41e60:	48 89 c7             	mov    %rax,%rdi
   41e63:	e8 84 1a 00 00       	call   438ec <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41e68:	48 c7 05 31 34 01 00 	movq   $0x80000,0x13431(%rip)        # 552a4 <kernel_task_descriptor+0x4>
   41e6f:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41e73:	ba 00 10 00 00       	mov    $0x1000,%edx
   41e78:	be 00 00 00 00       	mov    $0x0,%esi
   41e7d:	48 8d 05 1c 24 01 00 	lea    0x1241c(%rip),%rax        # 542a0 <interrupt_descriptors>
   41e84:	48 89 c7             	mov    %rax,%rdi
   41e87:	e8 60 1a 00 00       	call   438ec <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41e8c:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41e93:	eb 3c                	jmp    41ed1 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41e95:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   41e9c:	48 89 c2             	mov    %rax,%rdx
   41e9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ea2:	48 c1 e0 04          	shl    $0x4,%rax
   41ea6:	48 89 c1             	mov    %rax,%rcx
   41ea9:	48 8d 05 f0 23 01 00 	lea    0x123f0(%rip),%rax        # 542a0 <interrupt_descriptors>
   41eb0:	48 01 c8             	add    %rcx,%rax
   41eb3:	48 89 d1             	mov    %rdx,%rcx
   41eb6:	ba 00 00 00 00       	mov    $0x0,%edx
   41ebb:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41ec2:	0e 00 00 
   41ec5:	48 89 c7             	mov    %rax,%rdi
   41ec8:	e8 2b fe ff ff       	call   41cf8 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41ecd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41ed1:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41ed8:	76 bb                	jbe    41e95 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41eda:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   41ee1:	48 89 c1             	mov    %rax,%rcx
   41ee4:	ba 00 00 00 00       	mov    $0x0,%edx
   41ee9:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ef0:	0e 00 00 
   41ef3:	48 89 c6             	mov    %rax,%rsi
   41ef6:	48 8d 05 a3 25 01 00 	lea    0x125a3(%rip),%rax        # 544a0 <interrupt_descriptors+0x200>
   41efd:	48 89 c7             	mov    %rax,%rdi
   41f00:	e8 f3 fd ff ff       	call   41cf8 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41f05:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   41f0c:	48 89 c1             	mov    %rax,%rcx
   41f0f:	ba 00 00 00 00       	mov    $0x0,%edx
   41f14:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41f1b:	0e 00 00 
   41f1e:	48 89 c6             	mov    %rax,%rsi
   41f21:	48 8d 05 48 24 01 00 	lea    0x12448(%rip),%rax        # 54370 <interrupt_descriptors+0xd0>
   41f28:	48 89 c7             	mov    %rax,%rdi
   41f2b:	e8 c8 fd ff ff       	call   41cf8 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41f30:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   41f37:	48 89 c1             	mov    %rax,%rcx
   41f3a:	ba 00 00 00 00       	mov    $0x0,%edx
   41f3f:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41f46:	0e 00 00 
   41f49:	48 89 c6             	mov    %rax,%rsi
   41f4c:	48 8d 05 2d 24 01 00 	lea    0x1242d(%rip),%rax        # 54380 <interrupt_descriptors+0xe0>
   41f53:	48 89 c7             	mov    %rax,%rdi
   41f56:	e8 9d fd ff ff       	call   41cf8 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41f5b:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41f62:	eb 50                	jmp    41fb4 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41f64:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f67:	83 e8 30             	sub    $0x30,%eax
   41f6a:	89 c0                	mov    %eax,%eax
   41f6c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   41f73:	00 
   41f74:	48 8d 05 6c e1 ff ff 	lea    -0x1e94(%rip),%rax        # 400e7 <sys_int_handlers>
   41f7b:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41f7f:	48 89 c2             	mov    %rax,%rdx
   41f82:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f85:	48 c1 e0 04          	shl    $0x4,%rax
   41f89:	48 89 c1             	mov    %rax,%rcx
   41f8c:	48 8d 05 0d 23 01 00 	lea    0x1230d(%rip),%rax        # 542a0 <interrupt_descriptors>
   41f93:	48 01 c8             	add    %rcx,%rax
   41f96:	48 89 d1             	mov    %rdx,%rcx
   41f99:	ba 03 00 00 00       	mov    $0x3,%edx
   41f9e:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41fa5:	0e 00 00 
   41fa8:	48 89 c7             	mov    %rax,%rdi
   41fab:	e8 48 fd ff ff       	call   41cf8 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41fb0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41fb4:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41fb8:	76 aa                	jbe    41f64 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41fba:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41fc0:	48 8d 05 d9 22 01 00 	lea    0x122d9(%rip),%rax        # 542a0 <interrupt_descriptors>
   41fc7:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41fcb:	b8 28 00 00 00       	mov    $0x28,%eax
   41fd0:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41fd4:	0f 00 d8             	ltr    %ax
   41fd7:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41fdb:	0f 20 c0             	mov    %cr0,%rax
   41fde:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41fe2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41fe6:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41fe9:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41ff0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41ff3:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41ff6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ff9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41ffd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42001:	0f 22 c0             	mov    %rax,%cr0
}
   42004:	90                   	nop
    lcr0(cr0);
}
   42005:	90                   	nop
   42006:	c9                   	leave  
   42007:	c3                   	ret    

0000000000042008 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   42008:	f3 0f 1e fa          	endbr64 
   4200c:	55                   	push   %rbp
   4200d:	48 89 e5             	mov    %rsp,%rbp
   42010:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   42014:	0f b7 05 e5 32 01 00 	movzwl 0x132e5(%rip),%eax        # 55300 <interrupts_enabled>
   4201b:	f7 d0                	not    %eax
   4201d:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   42021:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   42025:	0f b6 c0             	movzbl %al,%eax
   42028:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   4202f:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42032:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42036:	8b 55 f0             	mov    -0x10(%rbp),%edx
   42039:	ee                   	out    %al,(%dx)
}
   4203a:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   4203b:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   4203f:	66 c1 e8 08          	shr    $0x8,%ax
   42043:	0f b6 c0             	movzbl %al,%eax
   42046:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   4204d:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42050:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42054:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42057:	ee                   	out    %al,(%dx)
}
   42058:	90                   	nop
}
   42059:	90                   	nop
   4205a:	c9                   	leave  
   4205b:	c3                   	ret    

000000000004205c <interrupt_init>:

void interrupt_init(void) {
   4205c:	f3 0f 1e fa          	endbr64 
   42060:	55                   	push   %rbp
   42061:	48 89 e5             	mov    %rsp,%rbp
   42064:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   42068:	66 c7 05 8f 32 01 00 	movw   $0x0,0x1328f(%rip)        # 55300 <interrupts_enabled>
   4206f:	00 00 
    interrupt_mask();
   42071:	e8 92 ff ff ff       	call   42008 <interrupt_mask>
   42076:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   4207d:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42081:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   42085:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   42088:	ee                   	out    %al,(%dx)
}
   42089:	90                   	nop
   4208a:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   42091:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42095:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   42099:	8b 55 ac             	mov    -0x54(%rbp),%edx
   4209c:	ee                   	out    %al,(%dx)
}
   4209d:	90                   	nop
   4209e:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   420a5:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420a9:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   420ad:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   420b0:	ee                   	out    %al,(%dx)
}
   420b1:	90                   	nop
   420b2:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   420b9:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420bd:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   420c1:	8b 55 bc             	mov    -0x44(%rbp),%edx
   420c4:	ee                   	out    %al,(%dx)
}
   420c5:	90                   	nop
   420c6:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   420cd:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420d1:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   420d5:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   420d8:	ee                   	out    %al,(%dx)
}
   420d9:	90                   	nop
   420da:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   420e1:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420e5:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   420e9:	8b 55 cc             	mov    -0x34(%rbp),%edx
   420ec:	ee                   	out    %al,(%dx)
}
   420ed:	90                   	nop
   420ee:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   420f5:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420f9:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   420fd:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   42100:	ee                   	out    %al,(%dx)
}
   42101:	90                   	nop
   42102:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   42109:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4210d:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   42111:	8b 55 dc             	mov    -0x24(%rbp),%edx
   42114:	ee                   	out    %al,(%dx)
}
   42115:	90                   	nop
   42116:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   4211d:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42121:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42125:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42128:	ee                   	out    %al,(%dx)
}
   42129:	90                   	nop
   4212a:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   42131:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42135:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42139:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4213c:	ee                   	out    %al,(%dx)
}
   4213d:	90                   	nop
   4213e:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   42145:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42149:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4214d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42150:	ee                   	out    %al,(%dx)
}
   42151:	90                   	nop
   42152:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   42159:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4215d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42161:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42164:	ee                   	out    %al,(%dx)
}
   42165:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   42166:	e8 9d fe ff ff       	call   42008 <interrupt_mask>
}
   4216b:	90                   	nop
   4216c:	c9                   	leave  
   4216d:	c3                   	ret    

000000000004216e <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   4216e:	f3 0f 1e fa          	endbr64 
   42172:	55                   	push   %rbp
   42173:	48 89 e5             	mov    %rsp,%rbp
   42176:	48 83 ec 28          	sub    $0x28,%rsp
   4217a:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   4217d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42181:	0f 8e 9f 00 00 00    	jle    42226 <timer_init+0xb8>
   42187:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   4218e:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42192:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42196:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42199:	ee                   	out    %al,(%dx)
}
   4219a:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   4219b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4219e:	89 c2                	mov    %eax,%edx
   421a0:	c1 ea 1f             	shr    $0x1f,%edx
   421a3:	01 d0                	add    %edx,%eax
   421a5:	d1 f8                	sar    %eax
   421a7:	05 de 34 12 00       	add    $0x1234de,%eax
   421ac:	99                   	cltd   
   421ad:	f7 7d dc             	idivl  -0x24(%rbp)
   421b0:	89 c2                	mov    %eax,%edx
   421b2:	89 d0                	mov    %edx,%eax
   421b4:	c1 f8 1f             	sar    $0x1f,%eax
   421b7:	c1 e8 18             	shr    $0x18,%eax
   421ba:	89 c1                	mov    %eax,%ecx
   421bc:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   421bf:	0f b6 c0             	movzbl %al,%eax
   421c2:	29 c8                	sub    %ecx,%eax
   421c4:	0f b6 c0             	movzbl %al,%eax
   421c7:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   421ce:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421d1:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   421d5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   421d8:	ee                   	out    %al,(%dx)
}
   421d9:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   421da:	8b 45 dc             	mov    -0x24(%rbp),%eax
   421dd:	89 c2                	mov    %eax,%edx
   421df:	c1 ea 1f             	shr    $0x1f,%edx
   421e2:	01 d0                	add    %edx,%eax
   421e4:	d1 f8                	sar    %eax
   421e6:	05 de 34 12 00       	add    $0x1234de,%eax
   421eb:	99                   	cltd   
   421ec:	f7 7d dc             	idivl  -0x24(%rbp)
   421ef:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   421f5:	85 c0                	test   %eax,%eax
   421f7:	0f 48 c2             	cmovs  %edx,%eax
   421fa:	c1 f8 08             	sar    $0x8,%eax
   421fd:	0f b6 c0             	movzbl %al,%eax
   42200:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   42207:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4220a:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4220e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42211:	ee                   	out    %al,(%dx)
}
   42212:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   42213:	0f b7 05 e6 30 01 00 	movzwl 0x130e6(%rip),%eax        # 55300 <interrupts_enabled>
   4221a:	83 c8 01             	or     $0x1,%eax
   4221d:	66 89 05 dc 30 01 00 	mov    %ax,0x130dc(%rip)        # 55300 <interrupts_enabled>
   42224:	eb 11                	jmp    42237 <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   42226:	0f b7 05 d3 30 01 00 	movzwl 0x130d3(%rip),%eax        # 55300 <interrupts_enabled>
   4222d:	83 e0 fe             	and    $0xfffffffe,%eax
   42230:	66 89 05 c9 30 01 00 	mov    %ax,0x130c9(%rip)        # 55300 <interrupts_enabled>
    }
    interrupt_mask();
   42237:	e8 cc fd ff ff       	call   42008 <interrupt_mask>
}
   4223c:	90                   	nop
   4223d:	c9                   	leave  
   4223e:	c3                   	ret    

000000000004223f <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   4223f:	f3 0f 1e fa          	endbr64 
   42243:	55                   	push   %rbp
   42244:	48 89 e5             	mov    %rsp,%rbp
   42247:	48 83 ec 08          	sub    $0x8,%rsp
   4224b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   4224f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   42254:	74 14                	je     4226a <physical_memory_isreserved+0x2b>
   42256:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   4225d:	00 
   4225e:	76 11                	jbe    42271 <physical_memory_isreserved+0x32>
   42260:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   42267:	00 
   42268:	77 07                	ja     42271 <physical_memory_isreserved+0x32>
   4226a:	b8 01 00 00 00       	mov    $0x1,%eax
   4226f:	eb 05                	jmp    42276 <physical_memory_isreserved+0x37>
   42271:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42276:	c9                   	leave  
   42277:	c3                   	ret    

0000000000042278 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   42278:	f3 0f 1e fa          	endbr64 
   4227c:	55                   	push   %rbp
   4227d:	48 89 e5             	mov    %rsp,%rbp
   42280:	48 83 ec 10          	sub    $0x10,%rsp
   42284:	89 7d fc             	mov    %edi,-0x4(%rbp)
   42287:	89 75 f8             	mov    %esi,-0x8(%rbp)
   4228a:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   4228d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42290:	c1 e0 10             	shl    $0x10,%eax
   42293:	89 c2                	mov    %eax,%edx
   42295:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42298:	c1 e0 0b             	shl    $0xb,%eax
   4229b:	09 c2                	or     %eax,%edx
   4229d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422a0:	c1 e0 08             	shl    $0x8,%eax
   422a3:	09 d0                	or     %edx,%eax
}
   422a5:	c9                   	leave  
   422a6:	c3                   	ret    

00000000000422a7 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   422a7:	f3 0f 1e fa          	endbr64 
   422ab:	55                   	push   %rbp
   422ac:	48 89 e5             	mov    %rsp,%rbp
   422af:	48 83 ec 18          	sub    $0x18,%rsp
   422b3:	89 7d ec             	mov    %edi,-0x14(%rbp)
   422b6:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   422b9:	8b 55 ec             	mov    -0x14(%rbp),%edx
   422bc:	8b 45 e8             	mov    -0x18(%rbp),%eax
   422bf:	09 d0                	or     %edx,%eax
   422c1:	0d 00 00 00 80       	or     $0x80000000,%eax
   422c6:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   422cd:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   422d0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   422d3:	8b 55 f4             	mov    -0xc(%rbp),%edx
   422d6:	ef                   	out    %eax,(%dx)
}
   422d7:	90                   	nop
   422d8:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   422df:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422e2:	89 c2                	mov    %eax,%edx
   422e4:	ed                   	in     (%dx),%eax
   422e5:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   422e8:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   422eb:	c9                   	leave  
   422ec:	c3                   	ret    

00000000000422ed <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   422ed:	f3 0f 1e fa          	endbr64 
   422f1:	55                   	push   %rbp
   422f2:	48 89 e5             	mov    %rsp,%rbp
   422f5:	48 83 ec 28          	sub    $0x28,%rsp
   422f9:	89 7d dc             	mov    %edi,-0x24(%rbp)
   422fc:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   422ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42306:	eb 73                	jmp    4237b <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   42308:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4230f:	eb 60                	jmp    42371 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   42311:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42318:	eb 4a                	jmp    42364 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   4231a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4231d:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   42320:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42323:	89 ce                	mov    %ecx,%esi
   42325:	89 c7                	mov    %eax,%edi
   42327:	e8 4c ff ff ff       	call   42278 <pci_make_configaddr>
   4232c:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   4232f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42332:	be 00 00 00 00       	mov    $0x0,%esi
   42337:	89 c7                	mov    %eax,%edi
   42339:	e8 69 ff ff ff       	call   422a7 <pci_config_readl>
   4233e:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   42341:	8b 45 d8             	mov    -0x28(%rbp),%eax
   42344:	c1 e0 10             	shl    $0x10,%eax
   42347:	0b 45 dc             	or     -0x24(%rbp),%eax
   4234a:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   4234d:	75 05                	jne    42354 <pci_find_device+0x67>
                    return configaddr;
   4234f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42352:	eb 35                	jmp    42389 <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   42354:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   42358:	75 06                	jne    42360 <pci_find_device+0x73>
   4235a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4235e:	74 0c                	je     4236c <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   42360:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42364:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   42368:	75 b0                	jne    4231a <pci_find_device+0x2d>
   4236a:	eb 01                	jmp    4236d <pci_find_device+0x80>
                    break;
   4236c:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   4236d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42371:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   42375:	75 9a                	jne    42311 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   42377:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4237b:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42382:	75 84                	jne    42308 <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   42384:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   42389:	c9                   	leave  
   4238a:	c3                   	ret    

000000000004238b <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   4238b:	f3 0f 1e fa          	endbr64 
   4238f:	55                   	push   %rbp
   42390:	48 89 e5             	mov    %rsp,%rbp
   42393:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42397:	be 13 71 00 00       	mov    $0x7113,%esi
   4239c:	bf 86 80 00 00       	mov    $0x8086,%edi
   423a1:	e8 47 ff ff ff       	call   422ed <pci_find_device>
   423a6:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   423a9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   423ad:	78 30                	js     423df <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   423af:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423b2:	be 40 00 00 00       	mov    $0x40,%esi
   423b7:	89 c7                	mov    %eax,%edi
   423b9:	e8 e9 fe ff ff       	call   422a7 <pci_config_readl>
   423be:	25 c0 ff 00 00       	and    $0xffc0,%eax
   423c3:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   423c6:	8b 45 f8             	mov    -0x8(%rbp),%eax
   423c9:	83 c0 04             	add    $0x4,%eax
   423cc:	89 45 f4             	mov    %eax,-0xc(%rbp)
   423cf:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   423d5:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   423d9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   423dc:	66 ef                	out    %ax,(%dx)
}
   423de:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   423df:	48 8d 05 7a 28 00 00 	lea    0x287a(%rip),%rax        # 44c60 <memstate_colors+0xc0>
   423e6:	48 89 c2             	mov    %rax,%rdx
   423e9:	be 00 c0 00 00       	mov    $0xc000,%esi
   423ee:	bf 80 07 00 00       	mov    $0x780,%edi
   423f3:	b8 00 00 00 00       	mov    $0x0,%eax
   423f8:	e8 2e 23 00 00       	call   4472b <console_printf>
 spinloop: goto spinloop;
   423fd:	eb fe                	jmp    423fd <poweroff+0x72>

00000000000423ff <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   423ff:	f3 0f 1e fa          	endbr64 
   42403:	55                   	push   %rbp
   42404:	48 89 e5             	mov    %rsp,%rbp
   42407:	48 83 ec 10          	sub    $0x10,%rsp
   4240b:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42412:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42416:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4241a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4241d:	ee                   	out    %al,(%dx)
}
   4241e:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   4241f:	eb fe                	jmp    4241f <reboot+0x20>

0000000000042421 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42421:	f3 0f 1e fa          	endbr64 
   42425:	55                   	push   %rbp
   42426:	48 89 e5             	mov    %rsp,%rbp
   42429:	48 83 ec 10          	sub    $0x10,%rsp
   4242d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42431:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   42434:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42438:	48 83 c0 08          	add    $0x8,%rax
   4243c:	ba c0 00 00 00       	mov    $0xc0,%edx
   42441:	be 00 00 00 00       	mov    $0x0,%esi
   42446:	48 89 c7             	mov    %rax,%rdi
   42449:	e8 9e 14 00 00       	call   438ec <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   4244e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42452:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   42459:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   4245b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4245f:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   42466:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   4246a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4246e:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   42475:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   42479:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4247d:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   42484:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   42486:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4248a:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   42491:	00 02 00 00 
    p->display_status = 1;
   42495:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42499:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   424a0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   424a3:	83 e0 01             	and    $0x1,%eax
   424a6:	85 c0                	test   %eax,%eax
   424a8:	74 1c                	je     424c6 <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   424aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424ae:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   424b5:	80 cc 30             	or     $0x30,%ah
   424b8:	48 89 c2             	mov    %rax,%rdx
   424bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424bf:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   424c6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   424c9:	83 e0 02             	and    $0x2,%eax
   424cc:	85 c0                	test   %eax,%eax
   424ce:	74 1c                	je     424ec <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   424d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424d4:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   424db:	80 e4 fd             	and    $0xfd,%ah
   424de:	48 89 c2             	mov    %rax,%rdx
   424e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424e5:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   424ec:	90                   	nop
   424ed:	c9                   	leave  
   424ee:	c3                   	ret    

00000000000424ef <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   424ef:	f3 0f 1e fa          	endbr64 
   424f3:	55                   	push   %rbp
   424f4:	48 89 e5             	mov    %rsp,%rbp
   424f7:	48 83 ec 28          	sub    $0x28,%rsp
   424fb:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   424fe:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42502:	78 09                	js     4250d <console_show_cursor+0x1e>
   42504:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4250b:	7e 07                	jle    42514 <console_show_cursor+0x25>
        cpos = 0;
   4250d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42514:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4251b:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4251f:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42523:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42526:	ee                   	out    %al,(%dx)
}
   42527:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   42528:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4252b:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42531:	85 c0                	test   %eax,%eax
   42533:	0f 48 c2             	cmovs  %edx,%eax
   42536:	c1 f8 08             	sar    $0x8,%eax
   42539:	0f b6 c0             	movzbl %al,%eax
   4253c:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42543:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42546:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4254a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4254d:	ee                   	out    %al,(%dx)
}
   4254e:	90                   	nop
   4254f:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42556:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4255a:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4255e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42561:	ee                   	out    %al,(%dx)
}
   42562:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42563:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42566:	99                   	cltd   
   42567:	c1 ea 18             	shr    $0x18,%edx
   4256a:	01 d0                	add    %edx,%eax
   4256c:	0f b6 c0             	movzbl %al,%eax
   4256f:	29 d0                	sub    %edx,%eax
   42571:	0f b6 c0             	movzbl %al,%eax
   42574:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   4257b:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4257e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42582:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42585:	ee                   	out    %al,(%dx)
}
   42586:	90                   	nop
}
   42587:	90                   	nop
   42588:	c9                   	leave  
   42589:	c3                   	ret    

000000000004258a <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   4258a:	f3 0f 1e fa          	endbr64 
   4258e:	55                   	push   %rbp
   4258f:	48 89 e5             	mov    %rsp,%rbp
   42592:	48 83 ec 20          	sub    $0x20,%rsp
   42596:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4259d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   425a0:	89 c2                	mov    %eax,%edx
   425a2:	ec                   	in     (%dx),%al
   425a3:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   425a6:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   425aa:	0f b6 c0             	movzbl %al,%eax
   425ad:	83 e0 01             	and    $0x1,%eax
   425b0:	85 c0                	test   %eax,%eax
   425b2:	75 0a                	jne    425be <keyboard_readc+0x34>
        return -1;
   425b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   425b9:	e9 fd 01 00 00       	jmp    427bb <keyboard_readc+0x231>
   425be:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   425c5:	8b 45 e8             	mov    -0x18(%rbp),%eax
   425c8:	89 c2                	mov    %eax,%edx
   425ca:	ec                   	in     (%dx),%al
   425cb:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   425ce:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   425d2:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   425d5:	0f b6 05 26 2d 01 00 	movzbl 0x12d26(%rip),%eax        # 55302 <last_escape.2>
   425dc:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   425df:	c6 05 1c 2d 01 00 00 	movb   $0x0,0x12d1c(%rip)        # 55302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   425e6:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   425ea:	75 11                	jne    425fd <keyboard_readc+0x73>
        last_escape = 0x80;
   425ec:	c6 05 0f 2d 01 00 80 	movb   $0x80,0x12d0f(%rip)        # 55302 <last_escape.2>
        return 0;
   425f3:	b8 00 00 00 00       	mov    $0x0,%eax
   425f8:	e9 be 01 00 00       	jmp    427bb <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   425fd:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42601:	84 c0                	test   %al,%al
   42603:	79 64                	jns    42669 <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   42605:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42609:	83 e0 7f             	and    $0x7f,%eax
   4260c:	89 c2                	mov    %eax,%edx
   4260e:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42612:	09 d0                	or     %edx,%eax
   42614:	48 98                	cltq   
   42616:	48 8d 15 63 26 00 00 	lea    0x2663(%rip),%rdx        # 44c80 <keymap>
   4261d:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42621:	0f b6 c0             	movzbl %al,%eax
   42624:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42627:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   4262e:	7e 2f                	jle    4265f <keyboard_readc+0xd5>
   42630:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42637:	7f 26                	jg     4265f <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42639:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4263c:	2d fa 00 00 00       	sub    $0xfa,%eax
   42641:	ba 01 00 00 00       	mov    $0x1,%edx
   42646:	89 c1                	mov    %eax,%ecx
   42648:	d3 e2                	shl    %cl,%edx
   4264a:	89 d0                	mov    %edx,%eax
   4264c:	f7 d0                	not    %eax
   4264e:	89 c2                	mov    %eax,%edx
   42650:	0f b6 05 ac 2c 01 00 	movzbl 0x12cac(%rip),%eax        # 55303 <modifiers.1>
   42657:	21 d0                	and    %edx,%eax
   42659:	88 05 a4 2c 01 00    	mov    %al,0x12ca4(%rip)        # 55303 <modifiers.1>
        }
        return 0;
   4265f:	b8 00 00 00 00       	mov    $0x0,%eax
   42664:	e9 52 01 00 00       	jmp    427bb <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   42669:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4266d:	0a 45 fa             	or     -0x6(%rbp),%al
   42670:	0f b6 c0             	movzbl %al,%eax
   42673:	48 98                	cltq   
   42675:	48 8d 15 04 26 00 00 	lea    0x2604(%rip),%rdx        # 44c80 <keymap>
   4267c:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42680:	0f b6 c0             	movzbl %al,%eax
   42683:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42686:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4268a:	7e 57                	jle    426e3 <keyboard_readc+0x159>
   4268c:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42690:	7f 51                	jg     426e3 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   42692:	0f b6 05 6a 2c 01 00 	movzbl 0x12c6a(%rip),%eax        # 55303 <modifiers.1>
   42699:	0f b6 c0             	movzbl %al,%eax
   4269c:	83 e0 02             	and    $0x2,%eax
   4269f:	85 c0                	test   %eax,%eax
   426a1:	74 09                	je     426ac <keyboard_readc+0x122>
            ch -= 0x60;
   426a3:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   426a7:	e9 0b 01 00 00       	jmp    427b7 <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   426ac:	0f b6 05 50 2c 01 00 	movzbl 0x12c50(%rip),%eax        # 55303 <modifiers.1>
   426b3:	0f b6 c0             	movzbl %al,%eax
   426b6:	83 e0 01             	and    $0x1,%eax
   426b9:	85 c0                	test   %eax,%eax
   426bb:	0f 94 c2             	sete   %dl
   426be:	0f b6 05 3e 2c 01 00 	movzbl 0x12c3e(%rip),%eax        # 55303 <modifiers.1>
   426c5:	0f b6 c0             	movzbl %al,%eax
   426c8:	83 e0 08             	and    $0x8,%eax
   426cb:	85 c0                	test   %eax,%eax
   426cd:	0f 94 c0             	sete   %al
   426d0:	31 d0                	xor    %edx,%eax
   426d2:	84 c0                	test   %al,%al
   426d4:	0f 84 dd 00 00 00    	je     427b7 <keyboard_readc+0x22d>
            ch -= 0x20;
   426da:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   426de:	e9 d4 00 00 00       	jmp    427b7 <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   426e3:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   426ea:	7e 30                	jle    4271c <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   426ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
   426ef:	2d fa 00 00 00       	sub    $0xfa,%eax
   426f4:	ba 01 00 00 00       	mov    $0x1,%edx
   426f9:	89 c1                	mov    %eax,%ecx
   426fb:	d3 e2                	shl    %cl,%edx
   426fd:	89 d0                	mov    %edx,%eax
   426ff:	89 c2                	mov    %eax,%edx
   42701:	0f b6 05 fb 2b 01 00 	movzbl 0x12bfb(%rip),%eax        # 55303 <modifiers.1>
   42708:	31 d0                	xor    %edx,%eax
   4270a:	88 05 f3 2b 01 00    	mov    %al,0x12bf3(%rip)        # 55303 <modifiers.1>
        ch = 0;
   42710:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42717:	e9 9c 00 00 00       	jmp    427b8 <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   4271c:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42723:	7e 2d                	jle    42752 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42725:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42728:	2d fa 00 00 00       	sub    $0xfa,%eax
   4272d:	ba 01 00 00 00       	mov    $0x1,%edx
   42732:	89 c1                	mov    %eax,%ecx
   42734:	d3 e2                	shl    %cl,%edx
   42736:	89 d0                	mov    %edx,%eax
   42738:	89 c2                	mov    %eax,%edx
   4273a:	0f b6 05 c2 2b 01 00 	movzbl 0x12bc2(%rip),%eax        # 55303 <modifiers.1>
   42741:	09 d0                	or     %edx,%eax
   42743:	88 05 ba 2b 01 00    	mov    %al,0x12bba(%rip)        # 55303 <modifiers.1>
        ch = 0;
   42749:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42750:	eb 66                	jmp    427b8 <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42752:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42756:	7e 3f                	jle    42797 <keyboard_readc+0x20d>
   42758:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   4275f:	7f 36                	jg     42797 <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42761:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42764:	8d 50 80             	lea    -0x80(%rax),%edx
   42767:	0f b6 05 95 2b 01 00 	movzbl 0x12b95(%rip),%eax        # 55303 <modifiers.1>
   4276e:	0f b6 c0             	movzbl %al,%eax
   42771:	83 e0 03             	and    $0x3,%eax
   42774:	48 63 c8             	movslq %eax,%rcx
   42777:	48 63 c2             	movslq %edx,%rax
   4277a:	48 c1 e0 02          	shl    $0x2,%rax
   4277e:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   42782:	48 8d 05 f7 25 00 00 	lea    0x25f7(%rip),%rax        # 44d80 <complex_keymap>
   42789:	48 01 d0             	add    %rdx,%rax
   4278c:	0f b6 00             	movzbl (%rax),%eax
   4278f:	0f b6 c0             	movzbl %al,%eax
   42792:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42795:	eb 21                	jmp    427b8 <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42797:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4279b:	7f 1b                	jg     427b8 <keyboard_readc+0x22e>
   4279d:	0f b6 05 5f 2b 01 00 	movzbl 0x12b5f(%rip),%eax        # 55303 <modifiers.1>
   427a4:	0f b6 c0             	movzbl %al,%eax
   427a7:	83 e0 02             	and    $0x2,%eax
   427aa:	85 c0                	test   %eax,%eax
   427ac:	74 0a                	je     427b8 <keyboard_readc+0x22e>
        ch = 0;
   427ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   427b5:	eb 01                	jmp    427b8 <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   427b7:	90                   	nop
    }

    return ch;
   427b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   427bb:	c9                   	leave  
   427bc:	c3                   	ret    

00000000000427bd <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   427bd:	f3 0f 1e fa          	endbr64 
   427c1:	55                   	push   %rbp
   427c2:	48 89 e5             	mov    %rsp,%rbp
   427c5:	48 83 ec 20          	sub    $0x20,%rsp
   427c9:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   427d0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   427d3:	89 c2                	mov    %eax,%edx
   427d5:	ec                   	in     (%dx),%al
   427d6:	88 45 e3             	mov    %al,-0x1d(%rbp)
   427d9:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   427e0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   427e3:	89 c2                	mov    %eax,%edx
   427e5:	ec                   	in     (%dx),%al
   427e6:	88 45 eb             	mov    %al,-0x15(%rbp)
   427e9:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   427f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   427f3:	89 c2                	mov    %eax,%edx
   427f5:	ec                   	in     (%dx),%al
   427f6:	88 45 f3             	mov    %al,-0xd(%rbp)
   427f9:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42800:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42803:	89 c2                	mov    %eax,%edx
   42805:	ec                   	in     (%dx),%al
   42806:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42809:	90                   	nop
   4280a:	c9                   	leave  
   4280b:	c3                   	ret    

000000000004280c <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4280c:	f3 0f 1e fa          	endbr64 
   42810:	55                   	push   %rbp
   42811:	48 89 e5             	mov    %rsp,%rbp
   42814:	48 83 ec 40          	sub    $0x40,%rsp
   42818:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4281c:	89 f0                	mov    %esi,%eax
   4281e:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42821:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42824:	8b 05 da 2a 01 00    	mov    0x12ada(%rip),%eax        # 55304 <initialized.0>
   4282a:	85 c0                	test   %eax,%eax
   4282c:	75 1e                	jne    4284c <parallel_port_putc+0x40>
   4282e:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42835:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42839:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4283d:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42840:	ee                   	out    %al,(%dx)
}
   42841:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42842:	c7 05 b8 2a 01 00 01 	movl   $0x1,0x12ab8(%rip)        # 55304 <initialized.0>
   42849:	00 00 00 
    }

    for (int i = 0;
   4284c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42853:	eb 09                	jmp    4285e <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42855:	e8 63 ff ff ff       	call   427bd <delay>
         ++i) {
   4285a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   4285e:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42865:	7f 18                	jg     4287f <parallel_port_putc+0x73>
   42867:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4286e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42871:	89 c2                	mov    %eax,%edx
   42873:	ec                   	in     (%dx),%al
   42874:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42877:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4287b:	84 c0                	test   %al,%al
   4287d:	79 d6                	jns    42855 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   4287f:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42883:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4288a:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4288d:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42891:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42894:	ee                   	out    %al,(%dx)
}
   42895:	90                   	nop
   42896:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   4289d:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   428a1:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   428a5:	8b 55 e0             	mov    -0x20(%rbp),%edx
   428a8:	ee                   	out    %al,(%dx)
}
   428a9:	90                   	nop
   428aa:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   428b1:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   428b5:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   428b9:	8b 55 e8             	mov    -0x18(%rbp),%edx
   428bc:	ee                   	out    %al,(%dx)
}
   428bd:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   428be:	90                   	nop
   428bf:	c9                   	leave  
   428c0:	c3                   	ret    

00000000000428c1 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   428c1:	f3 0f 1e fa          	endbr64 
   428c5:	55                   	push   %rbp
   428c6:	48 89 e5             	mov    %rsp,%rbp
   428c9:	48 83 ec 20          	sub    $0x20,%rsp
   428cd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   428d1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   428d5:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 4280c <parallel_port_putc>
   428dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   428e0:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   428e4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   428e8:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   428ec:	be 00 00 00 00       	mov    $0x0,%esi
   428f1:	48 89 c7             	mov    %rax,%rdi
   428f4:	e8 b9 12 00 00       	call   43bb2 <printer_vprintf>
}
   428f9:	90                   	nop
   428fa:	c9                   	leave  
   428fb:	c3                   	ret    

00000000000428fc <log_printf>:

void log_printf(const char* format, ...) {
   428fc:	f3 0f 1e fa          	endbr64 
   42900:	55                   	push   %rbp
   42901:	48 89 e5             	mov    %rsp,%rbp
   42904:	48 83 ec 60          	sub    $0x60,%rsp
   42908:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4290c:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42910:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42914:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42918:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4291c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42920:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42927:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4292b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4292f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42933:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42937:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4293b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4293f:	48 89 d6             	mov    %rdx,%rsi
   42942:	48 89 c7             	mov    %rax,%rdi
   42945:	e8 77 ff ff ff       	call   428c1 <log_vprintf>
    va_end(val);
}
   4294a:	90                   	nop
   4294b:	c9                   	leave  
   4294c:	c3                   	ret    

000000000004294d <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   4294d:	f3 0f 1e fa          	endbr64 
   42951:	55                   	push   %rbp
   42952:	48 89 e5             	mov    %rsp,%rbp
   42955:	48 83 ec 40          	sub    $0x40,%rsp
   42959:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4295c:	89 75 d8             	mov    %esi,-0x28(%rbp)
   4295f:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42963:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42967:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4296b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4296f:	48 8b 0a             	mov    (%rdx),%rcx
   42972:	48 89 08             	mov    %rcx,(%rax)
   42975:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42979:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4297d:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42981:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42985:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42989:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4298d:	48 89 d6             	mov    %rdx,%rsi
   42990:	48 89 c7             	mov    %rax,%rdi
   42993:	e8 29 ff ff ff       	call   428c1 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42998:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4299c:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   429a0:	8b 75 d8             	mov    -0x28(%rbp),%esi
   429a3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429a6:	89 c7                	mov    %eax,%edi
   429a8:	e8 02 1d 00 00       	call   446af <console_vprintf>
}
   429ad:	c9                   	leave  
   429ae:	c3                   	ret    

00000000000429af <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   429af:	f3 0f 1e fa          	endbr64 
   429b3:	55                   	push   %rbp
   429b4:	48 89 e5             	mov    %rsp,%rbp
   429b7:	48 83 ec 60          	sub    $0x60,%rsp
   429bb:	89 7d ac             	mov    %edi,-0x54(%rbp)
   429be:	89 75 a8             	mov    %esi,-0x58(%rbp)
   429c1:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   429c5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   429c9:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   429cd:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   429d1:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   429d8:	48 8d 45 10          	lea    0x10(%rbp),%rax
   429dc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   429e0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   429e4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   429e8:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   429ec:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   429f0:	8b 75 a8             	mov    -0x58(%rbp),%esi
   429f3:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429f6:	89 c7                	mov    %eax,%edi
   429f8:	e8 50 ff ff ff       	call   4294d <error_vprintf>
   429fd:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42a00:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42a03:	c9                   	leave  
   42a04:	c3                   	ret    

0000000000042a05 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42a05:	f3 0f 1e fa          	endbr64 
   42a09:	55                   	push   %rbp
   42a0a:	48 89 e5             	mov    %rsp,%rbp
   42a0d:	53                   	push   %rbx
   42a0e:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42a12:	e8 73 fb ff ff       	call   4258a <keyboard_readc>
   42a17:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42a1a:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42a1e:	74 1c                	je     42a3c <check_keyboard+0x37>
   42a20:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42a24:	74 16                	je     42a3c <check_keyboard+0x37>
   42a26:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42a2a:	74 10                	je     42a3c <check_keyboard+0x37>
   42a2c:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42a30:	74 0a                	je     42a3c <check_keyboard+0x37>
   42a32:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42a36:	0f 85 02 01 00 00    	jne    42b3e <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42a3c:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42a43:	00 
        memset(pt, 0, PAGESIZE * 3);
   42a44:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a48:	ba 00 30 00 00       	mov    $0x3000,%edx
   42a4d:	be 00 00 00 00       	mov    $0x0,%esi
   42a52:	48 89 c7             	mov    %rax,%rdi
   42a55:	e8 92 0e 00 00       	call   438ec <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42a5a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a5e:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42a65:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a69:	48 05 00 10 00 00    	add    $0x1000,%rax
   42a6f:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42a76:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a7a:	48 05 00 20 00 00    	add    $0x2000,%rax
   42a80:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42a87:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a8b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42a8f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42a93:	0f 22 d8             	mov    %rax,%cr3
}
   42a96:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42a97:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42a9e:	48 8d 05 33 23 00 00 	lea    0x2333(%rip),%rax        # 44dd8 <complex_keymap+0x58>
   42aa5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   42aa9:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42aad:	75 0d                	jne    42abc <check_keyboard+0xb7>
            argument = "allocator";
   42aaf:	48 8d 05 27 23 00 00 	lea    0x2327(%rip),%rax        # 44ddd <complex_keymap+0x5d>
   42ab6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42aba:	eb 37                	jmp    42af3 <check_keyboard+0xee>
        } else if (c == 'e') {
   42abc:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42ac0:	75 0d                	jne    42acf <check_keyboard+0xca>
            argument = "forkexit";
   42ac2:	48 8d 05 1e 23 00 00 	lea    0x231e(%rip),%rax        # 44de7 <complex_keymap+0x67>
   42ac9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42acd:	eb 24                	jmp    42af3 <check_keyboard+0xee>
        }
        else if (c == 't'){
   42acf:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42ad3:	75 0d                	jne    42ae2 <check_keyboard+0xdd>
            argument = "test";
   42ad5:	48 8d 05 14 23 00 00 	lea    0x2314(%rip),%rax        # 44df0 <complex_keymap+0x70>
   42adc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42ae0:	eb 11                	jmp    42af3 <check_keyboard+0xee>
        }
        else if(c == '2'){
   42ae2:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42ae6:	75 0b                	jne    42af3 <check_keyboard+0xee>
            argument = "test2";
   42ae8:	48 8d 05 06 23 00 00 	lea    0x2306(%rip),%rax        # 44df5 <complex_keymap+0x75>
   42aef:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42af3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42af7:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42afb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42b00:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42b04:	76 1e                	jbe    42b24 <check_keyboard+0x11f>
   42b06:	48 8d 05 ee 22 00 00 	lea    0x22ee(%rip),%rax        # 44dfb <complex_keymap+0x7b>
   42b0d:	48 89 c2             	mov    %rax,%rdx
   42b10:	be 5d 02 00 00       	mov    $0x25d,%esi
   42b15:	48 8d 05 fb 22 00 00 	lea    0x22fb(%rip),%rax        # 44e17 <complex_keymap+0x97>
   42b1c:	48 89 c7             	mov    %rax,%rdi
   42b1f:	e8 33 01 00 00       	call   42c57 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42b24:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b28:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42b2b:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42b2f:	48 89 c3             	mov    %rax,%rbx
   42b32:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42b37:	e9 c4 d4 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42b3c:	eb 11                	jmp    42b4f <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42b3e:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42b42:	74 06                	je     42b4a <check_keyboard+0x145>
   42b44:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42b48:	75 05                	jne    42b4f <check_keyboard+0x14a>
        poweroff();
   42b4a:	e8 3c f8 ff ff       	call   4238b <poweroff>
    }
    return c;
   42b4f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42b52:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42b56:	c9                   	leave  
   42b57:	c3                   	ret    

0000000000042b58 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42b58:	f3 0f 1e fa          	endbr64 
   42b5c:	55                   	push   %rbp
   42b5d:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42b60:	e8 a0 fe ff ff       	call   42a05 <check_keyboard>
   42b65:	eb f9                	jmp    42b60 <fail+0x8>

0000000000042b67 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42b67:	f3 0f 1e fa          	endbr64 
   42b6b:	55                   	push   %rbp
   42b6c:	48 89 e5             	mov    %rsp,%rbp
   42b6f:	48 83 ec 60          	sub    $0x60,%rsp
   42b73:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42b77:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42b7b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42b7f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42b83:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42b87:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42b8b:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42b92:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42b96:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42b9a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42b9e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42ba2:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42ba7:	0f 84 87 00 00 00    	je     42c34 <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42bad:	48 8d 05 77 22 00 00 	lea    0x2277(%rip),%rax        # 44e2b <complex_keymap+0xab>
   42bb4:	48 89 c2             	mov    %rax,%rdx
   42bb7:	be 00 c0 00 00       	mov    $0xc000,%esi
   42bbc:	bf 30 07 00 00       	mov    $0x730,%edi
   42bc1:	b8 00 00 00 00       	mov    $0x0,%eax
   42bc6:	e8 e4 fd ff ff       	call   429af <error_printf>
   42bcb:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42bce:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42bd2:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42bd6:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bd9:	be 00 c0 00 00       	mov    $0xc000,%esi
   42bde:	89 c7                	mov    %eax,%edi
   42be0:	e8 68 fd ff ff       	call   4294d <error_vprintf>
   42be5:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42be8:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42beb:	48 63 c1             	movslq %ecx,%rax
   42bee:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42bf5:	48 c1 e8 20          	shr    $0x20,%rax
   42bf9:	c1 f8 05             	sar    $0x5,%eax
   42bfc:	89 ce                	mov    %ecx,%esi
   42bfe:	c1 fe 1f             	sar    $0x1f,%esi
   42c01:	29 f0                	sub    %esi,%eax
   42c03:	89 c2                	mov    %eax,%edx
   42c05:	89 d0                	mov    %edx,%eax
   42c07:	c1 e0 02             	shl    $0x2,%eax
   42c0a:	01 d0                	add    %edx,%eax
   42c0c:	c1 e0 04             	shl    $0x4,%eax
   42c0f:	29 c1                	sub    %eax,%ecx
   42c11:	89 ca                	mov    %ecx,%edx
   42c13:	85 d2                	test   %edx,%edx
   42c15:	74 3b                	je     42c52 <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   42c17:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c1a:	48 8d 15 12 22 00 00 	lea    0x2212(%rip),%rdx        # 44e33 <complex_keymap+0xb3>
   42c21:	be 00 c0 00 00       	mov    $0xc000,%esi
   42c26:	89 c7                	mov    %eax,%edi
   42c28:	b8 00 00 00 00       	mov    $0x0,%eax
   42c2d:	e8 7d fd ff ff       	call   429af <error_printf>
   42c32:	eb 1e                	jmp    42c52 <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42c34:	48 8d 05 fa 21 00 00 	lea    0x21fa(%rip),%rax        # 44e35 <complex_keymap+0xb5>
   42c3b:	48 89 c2             	mov    %rax,%rdx
   42c3e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42c43:	bf 30 07 00 00       	mov    $0x730,%edi
   42c48:	b8 00 00 00 00       	mov    $0x0,%eax
   42c4d:	e8 5d fd ff ff       	call   429af <error_printf>
    }

    va_end(val);
    fail();
   42c52:	e8 01 ff ff ff       	call   42b58 <fail>

0000000000042c57 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42c57:	f3 0f 1e fa          	endbr64 
   42c5b:	55                   	push   %rbp
   42c5c:	48 89 e5             	mov    %rsp,%rbp
   42c5f:	48 83 ec 20          	sub    $0x20,%rsp
   42c63:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42c67:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42c6a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42c6e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42c72:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42c75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c79:	48 89 c6             	mov    %rax,%rsi
   42c7c:	48 8d 05 b8 21 00 00 	lea    0x21b8(%rip),%rax        # 44e3b <complex_keymap+0xbb>
   42c83:	48 89 c7             	mov    %rax,%rdi
   42c86:	b8 00 00 00 00       	mov    $0x0,%eax
   42c8b:	e8 d7 fe ff ff       	call   42b67 <panic>

0000000000042c90 <default_exception>:
}

void default_exception(proc* p){
   42c90:	f3 0f 1e fa          	endbr64 
   42c94:	55                   	push   %rbp
   42c95:	48 89 e5             	mov    %rsp,%rbp
   42c98:	48 83 ec 20          	sub    $0x20,%rsp
   42c9c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42ca0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ca4:	48 83 c0 08          	add    $0x8,%rax
   42ca8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42cac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42cb0:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42cb7:	48 89 c6             	mov    %rax,%rsi
   42cba:	48 8d 05 98 21 00 00 	lea    0x2198(%rip),%rax        # 44e59 <complex_keymap+0xd9>
   42cc1:	48 89 c7             	mov    %rax,%rdi
   42cc4:	b8 00 00 00 00       	mov    $0x0,%eax
   42cc9:	e8 99 fe ff ff       	call   42b67 <panic>

0000000000042cce <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42cce:	55                   	push   %rbp
   42ccf:	48 89 e5             	mov    %rsp,%rbp
   42cd2:	48 83 ec 10          	sub    $0x10,%rsp
   42cd6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42cda:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42cdd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42ce1:	78 06                	js     42ce9 <pageindex+0x1b>
   42ce3:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42ce7:	7e 1e                	jle    42d07 <pageindex+0x39>
   42ce9:	48 8d 05 88 21 00 00 	lea    0x2188(%rip),%rax        # 44e78 <complex_keymap+0xf8>
   42cf0:	48 89 c2             	mov    %rax,%rdx
   42cf3:	be 1e 00 00 00       	mov    $0x1e,%esi
   42cf8:	48 8d 05 92 21 00 00 	lea    0x2192(%rip),%rax        # 44e91 <complex_keymap+0x111>
   42cff:	48 89 c7             	mov    %rax,%rdi
   42d02:	e8 50 ff ff ff       	call   42c57 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42d07:	b8 03 00 00 00       	mov    $0x3,%eax
   42d0c:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42d0f:	89 c2                	mov    %eax,%edx
   42d11:	89 d0                	mov    %edx,%eax
   42d13:	c1 e0 03             	shl    $0x3,%eax
   42d16:	01 d0                	add    %edx,%eax
   42d18:	83 c0 0c             	add    $0xc,%eax
   42d1b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42d1f:	89 c1                	mov    %eax,%ecx
   42d21:	48 d3 ea             	shr    %cl,%rdx
   42d24:	48 89 d0             	mov    %rdx,%rax
   42d27:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42d2c:	c9                   	leave  
   42d2d:	c3                   	ret    

0000000000042d2e <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42d2e:	f3 0f 1e fa          	endbr64 
   42d32:	55                   	push   %rbp
   42d33:	48 89 e5             	mov    %rsp,%rbp
   42d36:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42d3a:	48 8d 05 bf 42 01 00 	lea    0x142bf(%rip),%rax        # 57000 <kernel_pagetables>
   42d41:	48 89 05 b8 32 01 00 	mov    %rax,0x132b8(%rip)        # 56000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42d48:	ba 00 50 00 00       	mov    $0x5000,%edx
   42d4d:	be 00 00 00 00       	mov    $0x0,%esi
   42d52:	48 8d 05 a7 42 01 00 	lea    0x142a7(%rip),%rax        # 57000 <kernel_pagetables>
   42d59:	48 89 c7             	mov    %rax,%rdi
   42d5c:	e8 8b 0b 00 00       	call   438ec <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42d61:	48 8d 05 98 52 01 00 	lea    0x15298(%rip),%rax        # 58000 <kernel_pagetables+0x1000>
   42d68:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42d6c:	48 89 05 8d 42 01 00 	mov    %rax,0x1428d(%rip)        # 57000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42d73:	48 8d 05 86 62 01 00 	lea    0x16286(%rip),%rax        # 59000 <kernel_pagetables+0x2000>
   42d7a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42d7e:	48 89 05 7b 52 01 00 	mov    %rax,0x1527b(%rip)        # 58000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42d85:	48 8d 05 74 72 01 00 	lea    0x17274(%rip),%rax        # 5a000 <kernel_pagetables+0x3000>
   42d8c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42d90:	48 89 05 69 62 01 00 	mov    %rax,0x16269(%rip)        # 59000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42d97:	48 8d 05 62 82 01 00 	lea    0x18262(%rip),%rax        # 5b000 <kernel_pagetables+0x4000>
   42d9e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42da2:	48 89 05 5f 62 01 00 	mov    %rax,0x1625f(%rip)        # 59008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42da9:	48 8b 05 50 32 01 00 	mov    0x13250(%rip),%rax        # 56000 <kernel_pagetable>
   42db0:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42db6:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42dbb:	ba 00 00 00 00       	mov    $0x0,%edx
   42dc0:	be 00 00 00 00       	mov    $0x0,%esi
   42dc5:	48 89 c7             	mov    %rax,%rdi
   42dc8:	e8 0e 02 00 00       	call   42fdb <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42dcd:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42dd4:	00 
   42dd5:	eb 76                	jmp    42e4d <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42dd7:	48 8b 0d 22 32 01 00 	mov    0x13222(%rip),%rcx        # 56000 <kernel_pagetable>
   42dde:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42de2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42de6:	48 89 ce             	mov    %rcx,%rsi
   42de9:	48 89 c7             	mov    %rax,%rdi
   42dec:	e8 34 06 00 00       	call   43425 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42df1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42df5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42df9:	74 1e                	je     42e19 <virtual_memory_init+0xeb>
   42dfb:	48 8d 05 a3 20 00 00 	lea    0x20a3(%rip),%rax        # 44ea5 <complex_keymap+0x125>
   42e02:	48 89 c2             	mov    %rax,%rdx
   42e05:	be 2d 00 00 00       	mov    $0x2d,%esi
   42e0a:	48 8d 05 a4 20 00 00 	lea    0x20a4(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   42e11:	48 89 c7             	mov    %rax,%rdi
   42e14:	e8 3e fe ff ff       	call   42c57 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42e19:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42e1c:	48 98                	cltq   
   42e1e:	83 e0 03             	and    $0x3,%eax
   42e21:	48 83 f8 03          	cmp    $0x3,%rax
   42e25:	74 1e                	je     42e45 <virtual_memory_init+0x117>
   42e27:	48 8d 05 9a 20 00 00 	lea    0x209a(%rip),%rax        # 44ec8 <complex_keymap+0x148>
   42e2e:	48 89 c2             	mov    %rax,%rdx
   42e31:	be 2e 00 00 00       	mov    $0x2e,%esi
   42e36:	48 8d 05 78 20 00 00 	lea    0x2078(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   42e3d:	48 89 c7             	mov    %rax,%rdi
   42e40:	e8 12 fe ff ff       	call   42c57 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42e45:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42e4c:	00 
   42e4d:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42e54:	00 
   42e55:	76 80                	jbe    42dd7 <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42e57:	48 8b 05 a2 31 01 00 	mov    0x131a2(%rip),%rax        # 56000 <kernel_pagetable>
   42e5e:	48 89 c7             	mov    %rax,%rdi
   42e61:	e8 03 00 00 00       	call   42e69 <set_pagetable>
}
   42e66:	90                   	nop
   42e67:	c9                   	leave  
   42e68:	c3                   	ret    

0000000000042e69 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42e69:	f3 0f 1e fa          	endbr64 
   42e6d:	55                   	push   %rbp
   42e6e:	48 89 e5             	mov    %rsp,%rbp
   42e71:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42e75:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42e79:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42e7d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e82:	48 85 c0             	test   %rax,%rax
   42e85:	74 1e                	je     42ea5 <set_pagetable+0x3c>
   42e87:	48 8d 05 67 20 00 00 	lea    0x2067(%rip),%rax        # 44ef5 <complex_keymap+0x175>
   42e8e:	48 89 c2             	mov    %rax,%rdx
   42e91:	be 3c 00 00 00       	mov    $0x3c,%esi
   42e96:	48 8d 05 18 20 00 00 	lea    0x2018(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   42e9d:	48 89 c7             	mov    %rax,%rdi
   42ea0:	e8 b2 fd ff ff       	call   42c57 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42ea5:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   42eac:	48 89 c2             	mov    %rax,%rdx
   42eaf:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42eb3:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42eb7:	48 89 ce             	mov    %rcx,%rsi
   42eba:	48 89 c7             	mov    %rax,%rdi
   42ebd:	e8 63 05 00 00       	call   43425 <virtual_memory_lookup>
   42ec2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42ec6:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   42ecd:	48 39 d0             	cmp    %rdx,%rax
   42ed0:	74 1e                	je     42ef0 <set_pagetable+0x87>
   42ed2:	48 8d 05 37 20 00 00 	lea    0x2037(%rip),%rax        # 44f10 <complex_keymap+0x190>
   42ed9:	48 89 c2             	mov    %rax,%rdx
   42edc:	be 3e 00 00 00       	mov    $0x3e,%esi
   42ee1:	48 8d 05 cd 1f 00 00 	lea    0x1fcd(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   42ee8:	48 89 c7             	mov    %rax,%rdi
   42eeb:	e8 67 fd ff ff       	call   42c57 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42ef0:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42ef4:	48 8b 0d 05 31 01 00 	mov    0x13105(%rip),%rcx        # 56000 <kernel_pagetable>
   42efb:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42eff:	48 89 ce             	mov    %rcx,%rsi
   42f02:	48 89 c7             	mov    %rax,%rdi
   42f05:	e8 1b 05 00 00       	call   43425 <virtual_memory_lookup>
   42f0a:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42f0e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42f12:	48 39 c2             	cmp    %rax,%rdx
   42f15:	74 1e                	je     42f35 <set_pagetable+0xcc>
   42f17:	48 8d 05 5a 20 00 00 	lea    0x205a(%rip),%rax        # 44f78 <complex_keymap+0x1f8>
   42f1e:	48 89 c2             	mov    %rax,%rdx
   42f21:	be 40 00 00 00       	mov    $0x40,%esi
   42f26:	48 8d 05 88 1f 00 00 	lea    0x1f88(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   42f2d:	48 89 c7             	mov    %rax,%rdi
   42f30:	e8 22 fd ff ff       	call   42c57 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42f35:	48 8b 05 c4 30 01 00 	mov    0x130c4(%rip),%rax        # 56000 <kernel_pagetable>
   42f3c:	48 89 c2             	mov    %rax,%rdx
   42f3f:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42f43:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42f47:	48 89 ce             	mov    %rcx,%rsi
   42f4a:	48 89 c7             	mov    %rax,%rdi
   42f4d:	e8 d3 04 00 00       	call   43425 <virtual_memory_lookup>
   42f52:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42f56:	48 8b 15 a3 30 01 00 	mov    0x130a3(%rip),%rdx        # 56000 <kernel_pagetable>
   42f5d:	48 39 d0             	cmp    %rdx,%rax
   42f60:	74 1e                	je     42f80 <set_pagetable+0x117>
   42f62:	48 8d 05 6f 20 00 00 	lea    0x206f(%rip),%rax        # 44fd8 <complex_keymap+0x258>
   42f69:	48 89 c2             	mov    %rax,%rdx
   42f6c:	be 42 00 00 00       	mov    $0x42,%esi
   42f71:	48 8d 05 3d 1f 00 00 	lea    0x1f3d(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   42f78:	48 89 c7             	mov    %rax,%rdi
   42f7b:	e8 d7 fc ff ff       	call   42c57 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42f80:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 42fdb <virtual_memory_map>
   42f87:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42f8b:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42f8f:	48 89 ce             	mov    %rcx,%rsi
   42f92:	48 89 c7             	mov    %rax,%rdi
   42f95:	e8 8b 04 00 00       	call   43425 <virtual_memory_lookup>
   42f9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f9e:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 42fdb <virtual_memory_map>
   42fa5:	48 39 d0             	cmp    %rdx,%rax
   42fa8:	74 1e                	je     42fc8 <set_pagetable+0x15f>
   42faa:	48 8d 05 8f 20 00 00 	lea    0x208f(%rip),%rax        # 45040 <complex_keymap+0x2c0>
   42fb1:	48 89 c2             	mov    %rax,%rdx
   42fb4:	be 44 00 00 00       	mov    $0x44,%esi
   42fb9:	48 8d 05 f5 1e 00 00 	lea    0x1ef5(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   42fc0:	48 89 c7             	mov    %rax,%rdi
   42fc3:	e8 8f fc ff ff       	call   42c57 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42fc8:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42fcc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42fd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fd4:	0f 22 d8             	mov    %rax,%cr3
}
   42fd7:	90                   	nop
}
   42fd8:	90                   	nop
   42fd9:	c9                   	leave  
   42fda:	c3                   	ret    

0000000000042fdb <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42fdb:	f3 0f 1e fa          	endbr64 
   42fdf:	55                   	push   %rbp
   42fe0:	48 89 e5             	mov    %rsp,%rbp
   42fe3:	48 83 ec 50          	sub    $0x50,%rsp
   42fe7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42feb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42fef:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42ff3:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   42ff7:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42ffb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42fff:	25 ff 0f 00 00       	and    $0xfff,%eax
   43004:	48 85 c0             	test   %rax,%rax
   43007:	74 1e                	je     43027 <virtual_memory_map+0x4c>
   43009:	48 8d 05 96 20 00 00 	lea    0x2096(%rip),%rax        # 450a6 <complex_keymap+0x326>
   43010:	48 89 c2             	mov    %rax,%rdx
   43013:	be 65 00 00 00       	mov    $0x65,%esi
   43018:	48 8d 05 96 1e 00 00 	lea    0x1e96(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   4301f:	48 89 c7             	mov    %rax,%rdi
   43022:	e8 30 fc ff ff       	call   42c57 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   43027:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4302b:	25 ff 0f 00 00       	and    $0xfff,%eax
   43030:	48 85 c0             	test   %rax,%rax
   43033:	74 1e                	je     43053 <virtual_memory_map+0x78>
   43035:	48 8d 05 7d 20 00 00 	lea    0x207d(%rip),%rax        # 450b9 <complex_keymap+0x339>
   4303c:	48 89 c2             	mov    %rax,%rdx
   4303f:	be 66 00 00 00       	mov    $0x66,%esi
   43044:	48 8d 05 6a 1e 00 00 	lea    0x1e6a(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   4304b:	48 89 c7             	mov    %rax,%rdi
   4304e:	e8 04 fc ff ff       	call   42c57 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   43053:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43057:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4305b:	48 01 d0             	add    %rdx,%rax
   4305e:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   43062:	76 2e                	jbe    43092 <virtual_memory_map+0xb7>
   43064:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43068:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4306c:	48 01 d0             	add    %rdx,%rax
   4306f:	48 85 c0             	test   %rax,%rax
   43072:	74 1e                	je     43092 <virtual_memory_map+0xb7>
   43074:	48 8d 05 51 20 00 00 	lea    0x2051(%rip),%rax        # 450cc <complex_keymap+0x34c>
   4307b:	48 89 c2             	mov    %rax,%rdx
   4307e:	be 67 00 00 00       	mov    $0x67,%esi
   43083:	48 8d 05 2b 1e 00 00 	lea    0x1e2b(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   4308a:	48 89 c7             	mov    %rax,%rdi
   4308d:	e8 c5 fb ff ff       	call   42c57 <assert_fail>
    if (perm & PTE_P) {
   43092:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43095:	48 98                	cltq   
   43097:	83 e0 01             	and    $0x1,%eax
   4309a:	48 85 c0             	test   %rax,%rax
   4309d:	0f 84 8c 00 00 00    	je     4312f <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   430a3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   430a7:	25 ff 0f 00 00       	and    $0xfff,%eax
   430ac:	48 85 c0             	test   %rax,%rax
   430af:	74 1e                	je     430cf <virtual_memory_map+0xf4>
   430b1:	48 8d 05 32 20 00 00 	lea    0x2032(%rip),%rax        # 450ea <complex_keymap+0x36a>
   430b8:	48 89 c2             	mov    %rax,%rdx
   430bb:	be 69 00 00 00       	mov    $0x69,%esi
   430c0:	48 8d 05 ee 1d 00 00 	lea    0x1dee(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   430c7:	48 89 c7             	mov    %rax,%rdi
   430ca:	e8 88 fb ff ff       	call   42c57 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   430cf:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   430d3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   430d7:	48 01 d0             	add    %rdx,%rax
   430da:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   430de:	76 1e                	jbe    430fe <virtual_memory_map+0x123>
   430e0:	48 8d 05 16 20 00 00 	lea    0x2016(%rip),%rax        # 450fd <complex_keymap+0x37d>
   430e7:	48 89 c2             	mov    %rax,%rdx
   430ea:	be 6a 00 00 00       	mov    $0x6a,%esi
   430ef:	48 8d 05 bf 1d 00 00 	lea    0x1dbf(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   430f6:	48 89 c7             	mov    %rax,%rdi
   430f9:	e8 59 fb ff ff       	call   42c57 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   430fe:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43102:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43106:	48 01 d0             	add    %rdx,%rax
   43109:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   4310f:	76 1e                	jbe    4312f <virtual_memory_map+0x154>
   43111:	48 8d 05 f3 1f 00 00 	lea    0x1ff3(%rip),%rax        # 4510b <complex_keymap+0x38b>
   43118:	48 89 c2             	mov    %rax,%rdx
   4311b:	be 6b 00 00 00       	mov    $0x6b,%esi
   43120:	48 8d 05 8e 1d 00 00 	lea    0x1d8e(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   43127:	48 89 c7             	mov    %rax,%rdi
   4312a:	e8 28 fb ff ff       	call   42c57 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   4312f:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43133:	78 09                	js     4313e <virtual_memory_map+0x163>
   43135:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   4313c:	7e 1e                	jle    4315c <virtual_memory_map+0x181>
   4313e:	48 8d 05 e2 1f 00 00 	lea    0x1fe2(%rip),%rax        # 45127 <complex_keymap+0x3a7>
   43145:	48 89 c2             	mov    %rax,%rdx
   43148:	be 6d 00 00 00       	mov    $0x6d,%esi
   4314d:	48 8d 05 61 1d 00 00 	lea    0x1d61(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   43154:	48 89 c7             	mov    %rax,%rdi
   43157:	e8 fb fa ff ff       	call   42c57 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   4315c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43160:	25 ff 0f 00 00       	and    $0xfff,%eax
   43165:	48 85 c0             	test   %rax,%rax
   43168:	74 1e                	je     43188 <virtual_memory_map+0x1ad>
   4316a:	48 8d 05 d7 1f 00 00 	lea    0x1fd7(%rip),%rax        # 45148 <complex_keymap+0x3c8>
   43171:	48 89 c2             	mov    %rax,%rdx
   43174:	be 6e 00 00 00       	mov    $0x6e,%esi
   43179:	48 8d 05 35 1d 00 00 	lea    0x1d35(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   43180:	48 89 c7             	mov    %rax,%rdi
   43183:	e8 cf fa ff ff       	call   42c57 <assert_fail>

    int last_index123 = -1;
   43188:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   4318f:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   43196:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43197:	e9 ed 00 00 00       	jmp    43289 <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   4319c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431a0:	48 c1 e8 15          	shr    $0x15,%rax
   431a4:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   431a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   431aa:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   431ad:	74 20                	je     431cf <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   431af:	8b 55 bc             	mov    -0x44(%rbp),%edx
   431b2:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   431b6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   431ba:	48 89 ce             	mov    %rcx,%rsi
   431bd:	48 89 c7             	mov    %rax,%rdi
   431c0:	e8 d6 00 00 00       	call   4329b <lookup_l1pagetable>
   431c5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   431c9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   431cc:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   431cf:	8b 45 bc             	mov    -0x44(%rbp),%eax
   431d2:	48 98                	cltq   
   431d4:	83 e0 01             	and    $0x1,%eax
   431d7:	48 85 c0             	test   %rax,%rax
   431da:	74 37                	je     43213 <virtual_memory_map+0x238>
   431dc:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   431e1:	74 30                	je     43213 <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   431e3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431e7:	be 03 00 00 00       	mov    $0x3,%esi
   431ec:	48 89 c7             	mov    %rax,%rdi
   431ef:	e8 da fa ff ff       	call   42cce <pageindex>
   431f4:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   431f7:	8b 45 bc             	mov    -0x44(%rbp),%eax
   431fa:	48 98                	cltq   
   431fc:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   43200:	48 89 c1             	mov    %rax,%rcx
   43203:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43207:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4320a:	48 63 d2             	movslq %edx,%rdx
   4320d:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   43211:	eb 5e                	jmp    43271 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   43213:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43218:	74 2a                	je     43244 <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   4321a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4321e:	be 03 00 00 00       	mov    $0x3,%esi
   43223:	48 89 c7             	mov    %rax,%rdi
   43226:	e8 a3 fa ff ff       	call   42cce <pageindex>
   4322b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   4322e:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43231:	48 63 c8             	movslq %eax,%rcx
   43234:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43238:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4323b:	48 63 d2             	movslq %edx,%rdx
   4323e:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   43242:	eb 2d                	jmp    43271 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   43244:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43247:	48 98                	cltq   
   43249:	83 e0 01             	and    $0x1,%eax
   4324c:	48 85 c0             	test   %rax,%rax
   4324f:	74 20                	je     43271 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   43251:	be 87 00 00 00       	mov    $0x87,%esi
   43256:	48 8d 05 13 1f 00 00 	lea    0x1f13(%rip),%rax        # 45170 <complex_keymap+0x3f0>
   4325d:	48 89 c7             	mov    %rax,%rdi
   43260:	b8 00 00 00 00       	mov    $0x0,%eax
   43265:	e8 92 f6 ff ff       	call   428fc <log_printf>
            return -1;
   4326a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4326f:	eb 28                	jmp    43299 <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43271:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   43278:	00 
   43279:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   43280:	00 
   43281:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   43288:	00 
   43289:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   4328e:	0f 85 08 ff ff ff    	jne    4319c <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   43294:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43299:	c9                   	leave  
   4329a:	c3                   	ret    

000000000004329b <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   4329b:	f3 0f 1e fa          	endbr64 
   4329f:	55                   	push   %rbp
   432a0:	48 89 e5             	mov    %rsp,%rbp
   432a3:	48 83 ec 40          	sub    $0x40,%rsp
   432a7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   432ab:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   432af:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   432b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   432ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   432c1:	e9 4f 01 00 00       	jmp    43415 <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        int index = PAGEINDEX(va, i); // Get the index for the current level
   432c6:	8b 55 f4             	mov    -0xc(%rbp),%edx
   432c9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   432cd:	89 d6                	mov    %edx,%esi
   432cf:	48 89 c7             	mov    %rax,%rdi
   432d2:	e8 f7 f9 ff ff       	call   42cce <pageindex>
   432d7:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   432da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   432de:	8b 55 f0             	mov    -0x10(%rbp),%edx
   432e1:	48 63 d2             	movslq %edx,%rdx
   432e4:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   432e8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   432ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432f0:	83 e0 01             	and    $0x1,%eax
   432f3:	48 85 c0             	test   %rax,%rax
   432f6:	75 6d                	jne    43365 <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   432f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   432fb:	8d 48 02             	lea    0x2(%rax),%ecx
   432fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43302:	25 ff 0f 00 00       	and    $0xfff,%eax
   43307:	48 89 c2             	mov    %rax,%rdx
   4330a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4330e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43314:	48 89 c6             	mov    %rax,%rsi
   43317:	48 8d 05 9a 1e 00 00 	lea    0x1e9a(%rip),%rax        # 451b8 <complex_keymap+0x438>
   4331e:	48 89 c7             	mov    %rax,%rdi
   43321:	b8 00 00 00 00       	mov    $0x0,%eax
   43326:	e8 d1 f5 ff ff       	call   428fc <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   4332b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4332e:	48 98                	cltq   
   43330:	83 e0 01             	and    $0x1,%eax
   43333:	48 85 c0             	test   %rax,%rax
   43336:	75 0a                	jne    43342 <lookup_l1pagetable+0xa7>
                return NULL;
   43338:	b8 00 00 00 00       	mov    $0x0,%eax
   4333d:	e9 e1 00 00 00       	jmp    43423 <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   43342:	be ac 00 00 00       	mov    $0xac,%esi
   43347:	48 8d 05 d2 1e 00 00 	lea    0x1ed2(%rip),%rax        # 45220 <complex_keymap+0x4a0>
   4334e:	48 89 c7             	mov    %rax,%rdi
   43351:	b8 00 00 00 00       	mov    $0x0,%eax
   43356:	e8 a1 f5 ff ff       	call   428fc <log_printf>
            return NULL;
   4335b:	b8 00 00 00 00       	mov    $0x0,%eax
   43360:	e9 be 00 00 00       	jmp    43423 <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   43365:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43369:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4336f:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   43375:	76 1e                	jbe    43395 <lookup_l1pagetable+0xfa>
   43377:	48 8d 05 ea 1e 00 00 	lea    0x1eea(%rip),%rax        # 45268 <complex_keymap+0x4e8>
   4337e:	48 89 c2             	mov    %rax,%rdx
   43381:	be b1 00 00 00       	mov    $0xb1,%esi
   43386:	48 8d 05 28 1b 00 00 	lea    0x1b28(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   4338d:	48 89 c7             	mov    %rax,%rdi
   43390:	e8 c2 f8 ff ff       	call   42c57 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   43395:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43398:	48 98                	cltq   
   4339a:	83 e0 02             	and    $0x2,%eax
   4339d:	48 85 c0             	test   %rax,%rax
   433a0:	74 2a                	je     433cc <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   433a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433a6:	83 e0 02             	and    $0x2,%eax
   433a9:	48 85 c0             	test   %rax,%rax
   433ac:	75 1e                	jne    433cc <lookup_l1pagetable+0x131>
   433ae:	48 8d 05 d3 1e 00 00 	lea    0x1ed3(%rip),%rax        # 45288 <complex_keymap+0x508>
   433b5:	48 89 c2             	mov    %rax,%rdx
   433b8:	be b3 00 00 00       	mov    $0xb3,%esi
   433bd:	48 8d 05 f1 1a 00 00 	lea    0x1af1(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   433c4:	48 89 c7             	mov    %rax,%rdi
   433c7:	e8 8b f8 ff ff       	call   42c57 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   433cc:	8b 45 cc             	mov    -0x34(%rbp),%eax
   433cf:	48 98                	cltq   
   433d1:	83 e0 04             	and    $0x4,%eax
   433d4:	48 85 c0             	test   %rax,%rax
   433d7:	74 2a                	je     43403 <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   433d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433dd:	83 e0 04             	and    $0x4,%eax
   433e0:	48 85 c0             	test   %rax,%rax
   433e3:	75 1e                	jne    43403 <lookup_l1pagetable+0x168>
   433e5:	48 8d 05 a7 1e 00 00 	lea    0x1ea7(%rip),%rax        # 45293 <complex_keymap+0x513>
   433ec:	48 89 c2             	mov    %rax,%rdx
   433ef:	be b6 00 00 00       	mov    $0xb6,%esi
   433f4:	48 8d 05 ba 1a 00 00 	lea    0x1aba(%rip),%rax        # 44eb5 <complex_keymap+0x135>
   433fb:	48 89 c7             	mov    %rax,%rdi
   433fe:	e8 54 f8 ff ff       	call   42c57 <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43403:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43407:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4340d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   43411:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   43415:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   43419:	0f 8e a7 fe ff ff    	jle    432c6 <lookup_l1pagetable+0x2b>
    }
    return pt;
   4341f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43423:	c9                   	leave  
   43424:	c3                   	ret    

0000000000043425 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   43425:	f3 0f 1e fa          	endbr64 
   43429:	55                   	push   %rbp
   4342a:	48 89 e5             	mov    %rsp,%rbp
   4342d:	48 83 ec 50          	sub    $0x50,%rsp
   43431:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43435:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   43439:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   4343d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43441:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   43445:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4344c:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4344d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   43454:	eb 41                	jmp    43497 <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   43456:	8b 55 ec             	mov    -0x14(%rbp),%edx
   43459:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4345d:	89 d6                	mov    %edx,%esi
   4345f:	48 89 c7             	mov    %rax,%rdi
   43462:	e8 67 f8 ff ff       	call   42cce <pageindex>
   43467:	89 c2                	mov    %eax,%edx
   43469:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4346d:	48 63 d2             	movslq %edx,%rdx
   43470:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43474:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43478:	83 e0 06             	and    $0x6,%eax
   4347b:	48 f7 d0             	not    %rax
   4347e:	48 21 d0             	and    %rdx,%rax
   43481:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43485:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43489:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4348f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43493:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43497:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4349b:	7f 0c                	jg     434a9 <virtual_memory_lookup+0x84>
   4349d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434a1:	83 e0 01             	and    $0x1,%eax
   434a4:	48 85 c0             	test   %rax,%rax
   434a7:	75 ad                	jne    43456 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   434a9:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   434b0:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   434b7:	ff 
   434b8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   434bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434c3:	83 e0 01             	and    $0x1,%eax
   434c6:	48 85 c0             	test   %rax,%rax
   434c9:	74 34                	je     434ff <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   434cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434cf:	48 c1 e8 0c          	shr    $0xc,%rax
   434d3:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   434d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434da:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   434e0:	48 89 c2             	mov    %rax,%rdx
   434e3:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   434e7:	25 ff 0f 00 00       	and    $0xfff,%eax
   434ec:	48 09 d0             	or     %rdx,%rax
   434ef:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   434f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434f7:	25 ff 0f 00 00       	and    $0xfff,%eax
   434fc:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   434ff:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43503:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43507:	48 89 10             	mov    %rdx,(%rax)
   4350a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   4350e:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43512:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43516:	48 89 50 10          	mov    %rdx,0x10(%rax)
   4351a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4351e:	c9                   	leave  
   4351f:	c3                   	ret    

0000000000043520 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   43520:	f3 0f 1e fa          	endbr64 
   43524:	55                   	push   %rbp
   43525:	48 89 e5             	mov    %rsp,%rbp
   43528:	48 83 ec 40          	sub    $0x40,%rsp
   4352c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43530:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   43533:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   43537:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   4353e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43542:	78 08                	js     4354c <program_load+0x2c>
   43544:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43547:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   4354a:	7c 1e                	jl     4356a <program_load+0x4a>
   4354c:	48 8d 05 4d 1d 00 00 	lea    0x1d4d(%rip),%rax        # 452a0 <complex_keymap+0x520>
   43553:	48 89 c2             	mov    %rax,%rdx
   43556:	be 37 00 00 00       	mov    $0x37,%esi
   4355b:	48 8d 05 6e 1d 00 00 	lea    0x1d6e(%rip),%rax        # 452d0 <complex_keymap+0x550>
   43562:	48 89 c7             	mov    %rax,%rdi
   43565:	e8 ed f6 ff ff       	call   42c57 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4356a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   4356d:	48 98                	cltq   
   4356f:	48 c1 e0 04          	shl    $0x4,%rax
   43573:	48 89 c2             	mov    %rax,%rdx
   43576:	48 8d 05 a3 2a 00 00 	lea    0x2aa3(%rip),%rax        # 46020 <ramimages>
   4357d:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   43581:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43585:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43589:	8b 00                	mov    (%rax),%eax
   4358b:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43590:	74 1e                	je     435b0 <program_load+0x90>
   43592:	48 8d 05 49 1d 00 00 	lea    0x1d49(%rip),%rax        # 452e2 <complex_keymap+0x562>
   43599:	48 89 c2             	mov    %rax,%rdx
   4359c:	be 39 00 00 00       	mov    $0x39,%esi
   435a1:	48 8d 05 28 1d 00 00 	lea    0x1d28(%rip),%rax        # 452d0 <complex_keymap+0x550>
   435a8:	48 89 c7             	mov    %rax,%rdi
   435ab:	e8 a7 f6 ff ff       	call   42c57 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   435b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435b4:	48 8b 50 20          	mov    0x20(%rax),%rdx
   435b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435bc:	48 01 d0             	add    %rdx,%rax
   435bf:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   435c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   435ca:	e9 94 00 00 00       	jmp    43663 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   435cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   435d2:	48 63 d0             	movslq %eax,%rdx
   435d5:	48 89 d0             	mov    %rdx,%rax
   435d8:	48 c1 e0 03          	shl    $0x3,%rax
   435dc:	48 29 d0             	sub    %rdx,%rax
   435df:	48 c1 e0 03          	shl    $0x3,%rax
   435e3:	48 89 c2             	mov    %rax,%rdx
   435e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435ea:	48 01 d0             	add    %rdx,%rax
   435ed:	8b 00                	mov    (%rax),%eax
   435ef:	83 f8 01             	cmp    $0x1,%eax
   435f2:	75 6b                	jne    4365f <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   435f4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   435f7:	48 63 d0             	movslq %eax,%rdx
   435fa:	48 89 d0             	mov    %rdx,%rax
   435fd:	48 c1 e0 03          	shl    $0x3,%rax
   43601:	48 29 d0             	sub    %rdx,%rax
   43604:	48 c1 e0 03          	shl    $0x3,%rax
   43608:	48 89 c2             	mov    %rax,%rdx
   4360b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4360f:	48 01 d0             	add    %rdx,%rax
   43612:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43616:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4361a:	48 01 d0             	add    %rdx,%rax
   4361d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   43621:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43624:	48 63 d0             	movslq %eax,%rdx
   43627:	48 89 d0             	mov    %rdx,%rax
   4362a:	48 c1 e0 03          	shl    $0x3,%rax
   4362e:	48 29 d0             	sub    %rdx,%rax
   43631:	48 c1 e0 03          	shl    $0x3,%rax
   43635:	48 89 c2             	mov    %rax,%rdx
   43638:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4363c:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43640:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   43644:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43648:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4364c:	48 89 c7             	mov    %rax,%rdi
   4364f:	e8 3d 00 00 00       	call   43691 <program_load_segment>
   43654:	85 c0                	test   %eax,%eax
   43656:	79 07                	jns    4365f <program_load+0x13f>
                return -1;
   43658:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4365d:	eb 30                	jmp    4368f <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   4365f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43663:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43667:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   4366b:	0f b7 c0             	movzwl %ax,%eax
   4366e:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43671:	0f 8c 58 ff ff ff    	jl     435cf <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   43677:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4367b:	48 8b 50 18          	mov    0x18(%rax),%rdx
   4367f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43683:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   4368a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4368f:	c9                   	leave  
   43690:	c3                   	ret    

0000000000043691 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43691:	f3 0f 1e fa          	endbr64 
   43695:	55                   	push   %rbp
   43696:	48 89 e5             	mov    %rsp,%rbp
   43699:	48 83 ec 40          	sub    $0x40,%rsp
   4369d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   436a1:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   436a5:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   436a9:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   436ad:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   436b1:	48 8b 40 10          	mov    0x10(%rax),%rax
   436b5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   436b9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   436bd:	48 8b 50 20          	mov    0x20(%rax),%rdx
   436c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436c5:	48 01 d0             	add    %rdx,%rax
   436c8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   436cc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   436d0:	48 8b 50 28          	mov    0x28(%rax),%rdx
   436d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436d8:	48 01 d0             	add    %rdx,%rax
   436db:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   436df:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   436e6:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   436e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   436ef:	e9 81 00 00 00       	jmp    43775 <program_load_segment+0xe4>
        if (assign_physical_page(addr, p->p_pid) < 0
   436f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436f8:	8b 00                	mov    (%rax),%eax
   436fa:	0f be d0             	movsbl %al,%edx
   436fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43701:	89 d6                	mov    %edx,%esi
   43703:	48 89 c7             	mov    %rax,%rdi
   43706:	e8 fe cf ff ff       	call   40709 <assign_physical_page>
   4370b:	85 c0                	test   %eax,%eax
   4370d:	78 2a                	js     43739 <program_load_segment+0xa8>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   4370f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43713:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4371a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4371e:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43722:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43728:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4372d:	48 89 c7             	mov    %rax,%rdi
   43730:	e8 a6 f8 ff ff       	call   42fdb <virtual_memory_map>
   43735:	85 c0                	test   %eax,%eax
   43737:	79 34                	jns    4376d <program_load_segment+0xdc>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43739:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4373d:	8b 00                	mov    (%rax),%eax
   4373f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43743:	49 89 d0             	mov    %rdx,%r8
   43746:	89 c1                	mov    %eax,%ecx
   43748:	48 8d 05 b1 1b 00 00 	lea    0x1bb1(%rip),%rax        # 45300 <complex_keymap+0x580>
   4374f:	48 89 c2             	mov    %rax,%rdx
   43752:	be 00 c0 00 00       	mov    $0xc000,%esi
   43757:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4375c:	b8 00 00 00 00       	mov    $0x0,%eax
   43761:	e8 c5 0f 00 00       	call   4472b <console_printf>
            return -1;
   43766:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4376b:	eb 77                	jmp    437e4 <program_load_segment+0x153>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4376d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43774:	00 
   43775:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43779:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   4377d:	0f 82 71 ff ff ff    	jb     436f4 <program_load_segment+0x63>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43783:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43787:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4378e:	48 89 c7             	mov    %rax,%rdi
   43791:	e8 d3 f6 ff ff       	call   42e69 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43796:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4379a:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   4379e:	48 89 c2             	mov    %rax,%rdx
   437a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437a5:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   437a9:	48 89 ce             	mov    %rcx,%rsi
   437ac:	48 89 c7             	mov    %rax,%rdi
   437af:	e8 32 00 00 00       	call   437e6 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   437b4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437b8:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   437bc:	48 89 c2             	mov    %rax,%rdx
   437bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437c3:	be 00 00 00 00       	mov    $0x0,%esi
   437c8:	48 89 c7             	mov    %rax,%rdi
   437cb:	e8 1c 01 00 00       	call   438ec <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   437d0:	48 8b 05 29 28 01 00 	mov    0x12829(%rip),%rax        # 56000 <kernel_pagetable>
   437d7:	48 89 c7             	mov    %rax,%rdi
   437da:	e8 8a f6 ff ff       	call   42e69 <set_pagetable>
    return 0;
   437df:	b8 00 00 00 00       	mov    $0x0,%eax
}
   437e4:	c9                   	leave  
   437e5:	c3                   	ret    

00000000000437e6 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   437e6:	f3 0f 1e fa          	endbr64 
   437ea:	55                   	push   %rbp
   437eb:	48 89 e5             	mov    %rsp,%rbp
   437ee:	48 83 ec 28          	sub    $0x28,%rsp
   437f2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   437f6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   437fa:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   437fe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43802:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43806:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4380a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4380e:	eb 1c                	jmp    4382c <memcpy+0x46>
        *d = *s;
   43810:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43814:	0f b6 10             	movzbl (%rax),%edx
   43817:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4381b:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4381d:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43822:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43827:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   4382c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43831:	75 dd                	jne    43810 <memcpy+0x2a>
    }
    return dst;
   43833:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43837:	c9                   	leave  
   43838:	c3                   	ret    

0000000000043839 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43839:	f3 0f 1e fa          	endbr64 
   4383d:	55                   	push   %rbp
   4383e:	48 89 e5             	mov    %rsp,%rbp
   43841:	48 83 ec 28          	sub    $0x28,%rsp
   43845:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43849:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4384d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43851:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43855:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43859:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4385d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43861:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43865:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43869:	73 6a                	jae    438d5 <memmove+0x9c>
   4386b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4386f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43873:	48 01 d0             	add    %rdx,%rax
   43876:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4387a:	73 59                	jae    438d5 <memmove+0x9c>
        s += n, d += n;
   4387c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43880:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43884:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43888:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   4388c:	eb 17                	jmp    438a5 <memmove+0x6c>
            *--d = *--s;
   4388e:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43893:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43898:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4389c:	0f b6 10             	movzbl (%rax),%edx
   4389f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438a3:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   438a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438a9:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   438ad:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   438b1:	48 85 c0             	test   %rax,%rax
   438b4:	75 d8                	jne    4388e <memmove+0x55>
    if (s < d && s + n > d) {
   438b6:	eb 2e                	jmp    438e6 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   438b8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   438bc:	48 8d 42 01          	lea    0x1(%rdx),%rax
   438c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   438c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438c8:	48 8d 48 01          	lea    0x1(%rax),%rcx
   438cc:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   438d0:	0f b6 12             	movzbl (%rdx),%edx
   438d3:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   438d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438d9:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   438dd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   438e1:	48 85 c0             	test   %rax,%rax
   438e4:	75 d2                	jne    438b8 <memmove+0x7f>
        }
    }
    return dst;
   438e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   438ea:	c9                   	leave  
   438eb:	c3                   	ret    

00000000000438ec <memset>:

void* memset(void* v, int c, size_t n) {
   438ec:	f3 0f 1e fa          	endbr64 
   438f0:	55                   	push   %rbp
   438f1:	48 89 e5             	mov    %rsp,%rbp
   438f4:	48 83 ec 28          	sub    $0x28,%rsp
   438f8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   438fc:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   438ff:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43903:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43907:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4390b:	eb 15                	jmp    43922 <memset+0x36>
        *p = c;
   4390d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43910:	89 c2                	mov    %eax,%edx
   43912:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43916:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43918:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4391d:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43922:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43927:	75 e4                	jne    4390d <memset+0x21>
    }
    return v;
   43929:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4392d:	c9                   	leave  
   4392e:	c3                   	ret    

000000000004392f <strlen>:

size_t strlen(const char* s) {
   4392f:	f3 0f 1e fa          	endbr64 
   43933:	55                   	push   %rbp
   43934:	48 89 e5             	mov    %rsp,%rbp
   43937:	48 83 ec 18          	sub    $0x18,%rsp
   4393b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   4393f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43946:	00 
   43947:	eb 0a                	jmp    43953 <strlen+0x24>
        ++n;
   43949:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   4394e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43953:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43957:	0f b6 00             	movzbl (%rax),%eax
   4395a:	84 c0                	test   %al,%al
   4395c:	75 eb                	jne    43949 <strlen+0x1a>
    }
    return n;
   4395e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43962:	c9                   	leave  
   43963:	c3                   	ret    

0000000000043964 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43964:	f3 0f 1e fa          	endbr64 
   43968:	55                   	push   %rbp
   43969:	48 89 e5             	mov    %rsp,%rbp
   4396c:	48 83 ec 20          	sub    $0x20,%rsp
   43970:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43974:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43978:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4397f:	00 
   43980:	eb 0a                	jmp    4398c <strnlen+0x28>
        ++n;
   43982:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43987:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4398c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43990:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43994:	74 0b                	je     439a1 <strnlen+0x3d>
   43996:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4399a:	0f b6 00             	movzbl (%rax),%eax
   4399d:	84 c0                	test   %al,%al
   4399f:	75 e1                	jne    43982 <strnlen+0x1e>
    }
    return n;
   439a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   439a5:	c9                   	leave  
   439a6:	c3                   	ret    

00000000000439a7 <strcpy>:

char* strcpy(char* dst, const char* src) {
   439a7:	f3 0f 1e fa          	endbr64 
   439ab:	55                   	push   %rbp
   439ac:	48 89 e5             	mov    %rsp,%rbp
   439af:	48 83 ec 20          	sub    $0x20,%rsp
   439b3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   439b7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   439bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   439c3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   439c7:	48 8d 42 01          	lea    0x1(%rdx),%rax
   439cb:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   439cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   439d3:	48 8d 48 01          	lea    0x1(%rax),%rcx
   439d7:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   439db:	0f b6 12             	movzbl (%rdx),%edx
   439de:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   439e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   439e4:	48 83 e8 01          	sub    $0x1,%rax
   439e8:	0f b6 00             	movzbl (%rax),%eax
   439eb:	84 c0                	test   %al,%al
   439ed:	75 d4                	jne    439c3 <strcpy+0x1c>
    return dst;
   439ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   439f3:	c9                   	leave  
   439f4:	c3                   	ret    

00000000000439f5 <strcmp>:

int strcmp(const char* a, const char* b) {
   439f5:	f3 0f 1e fa          	endbr64 
   439f9:	55                   	push   %rbp
   439fa:	48 89 e5             	mov    %rsp,%rbp
   439fd:	48 83 ec 10          	sub    $0x10,%rsp
   43a01:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43a05:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43a09:	eb 0a                	jmp    43a15 <strcmp+0x20>
        ++a, ++b;
   43a0b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43a10:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43a15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a19:	0f b6 00             	movzbl (%rax),%eax
   43a1c:	84 c0                	test   %al,%al
   43a1e:	74 1d                	je     43a3d <strcmp+0x48>
   43a20:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a24:	0f b6 00             	movzbl (%rax),%eax
   43a27:	84 c0                	test   %al,%al
   43a29:	74 12                	je     43a3d <strcmp+0x48>
   43a2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a2f:	0f b6 10             	movzbl (%rax),%edx
   43a32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a36:	0f b6 00             	movzbl (%rax),%eax
   43a39:	38 c2                	cmp    %al,%dl
   43a3b:	74 ce                	je     43a0b <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43a3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a41:	0f b6 00             	movzbl (%rax),%eax
   43a44:	89 c2                	mov    %eax,%edx
   43a46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a4a:	0f b6 00             	movzbl (%rax),%eax
   43a4d:	38 c2                	cmp    %al,%dl
   43a4f:	0f 97 c0             	seta   %al
   43a52:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43a55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a59:	0f b6 00             	movzbl (%rax),%eax
   43a5c:	89 c1                	mov    %eax,%ecx
   43a5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a62:	0f b6 00             	movzbl (%rax),%eax
   43a65:	38 c1                	cmp    %al,%cl
   43a67:	0f 92 c0             	setb   %al
   43a6a:	0f b6 c8             	movzbl %al,%ecx
   43a6d:	89 d0                	mov    %edx,%eax
   43a6f:	29 c8                	sub    %ecx,%eax
}
   43a71:	c9                   	leave  
   43a72:	c3                   	ret    

0000000000043a73 <strchr>:

char* strchr(const char* s, int c) {
   43a73:	f3 0f 1e fa          	endbr64 
   43a77:	55                   	push   %rbp
   43a78:	48 89 e5             	mov    %rsp,%rbp
   43a7b:	48 83 ec 10          	sub    $0x10,%rsp
   43a7f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43a83:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43a86:	eb 05                	jmp    43a8d <strchr+0x1a>
        ++s;
   43a88:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43a8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a91:	0f b6 00             	movzbl (%rax),%eax
   43a94:	84 c0                	test   %al,%al
   43a96:	74 0e                	je     43aa6 <strchr+0x33>
   43a98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a9c:	0f b6 00             	movzbl (%rax),%eax
   43a9f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43aa2:	38 d0                	cmp    %dl,%al
   43aa4:	75 e2                	jne    43a88 <strchr+0x15>
    }
    if (*s == (char) c) {
   43aa6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43aaa:	0f b6 00             	movzbl (%rax),%eax
   43aad:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43ab0:	38 d0                	cmp    %dl,%al
   43ab2:	75 06                	jne    43aba <strchr+0x47>
        return (char*) s;
   43ab4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ab8:	eb 05                	jmp    43abf <strchr+0x4c>
    } else {
        return NULL;
   43aba:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43abf:	c9                   	leave  
   43ac0:	c3                   	ret    

0000000000043ac1 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43ac1:	f3 0f 1e fa          	endbr64 
   43ac5:	55                   	push   %rbp
   43ac6:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43ac9:	8b 05 31 85 01 00    	mov    0x18531(%rip),%eax        # 5c000 <rand_seed_set>
   43acf:	85 c0                	test   %eax,%eax
   43ad1:	75 0a                	jne    43add <rand+0x1c>
        srand(819234718U);
   43ad3:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43ad8:	e8 24 00 00 00       	call   43b01 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43add:	8b 05 21 85 01 00    	mov    0x18521(%rip),%eax        # 5c004 <rand_seed>
   43ae3:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43ae9:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43aee:	89 05 10 85 01 00    	mov    %eax,0x18510(%rip)        # 5c004 <rand_seed>
    return rand_seed & RAND_MAX;
   43af4:	8b 05 0a 85 01 00    	mov    0x1850a(%rip),%eax        # 5c004 <rand_seed>
   43afa:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43aff:	5d                   	pop    %rbp
   43b00:	c3                   	ret    

0000000000043b01 <srand>:

void srand(unsigned seed) {
   43b01:	f3 0f 1e fa          	endbr64 
   43b05:	55                   	push   %rbp
   43b06:	48 89 e5             	mov    %rsp,%rbp
   43b09:	48 83 ec 08          	sub    $0x8,%rsp
   43b0d:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43b10:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43b13:	89 05 eb 84 01 00    	mov    %eax,0x184eb(%rip)        # 5c004 <rand_seed>
    rand_seed_set = 1;
   43b19:	c7 05 dd 84 01 00 01 	movl   $0x1,0x184dd(%rip)        # 5c000 <rand_seed_set>
   43b20:	00 00 00 
}
   43b23:	90                   	nop
   43b24:	c9                   	leave  
   43b25:	c3                   	ret    

0000000000043b26 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43b26:	f3 0f 1e fa          	endbr64 
   43b2a:	55                   	push   %rbp
   43b2b:	48 89 e5             	mov    %rsp,%rbp
   43b2e:	48 83 ec 28          	sub    $0x28,%rsp
   43b32:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b36:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43b3a:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43b3d:	48 8d 05 fc 18 00 00 	lea    0x18fc(%rip),%rax        # 45440 <upper_digits.1>
   43b44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   43b48:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43b4c:	79 0e                	jns    43b5c <fill_numbuf+0x36>
        digits = lower_digits;
   43b4e:	48 8d 05 0b 19 00 00 	lea    0x190b(%rip),%rax        # 45460 <lower_digits.0>
   43b55:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   43b59:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43b5c:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43b61:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b65:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43b68:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43b6b:	48 63 c8             	movslq %eax,%rcx
   43b6e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43b72:	ba 00 00 00 00       	mov    $0x0,%edx
   43b77:	48 f7 f1             	div    %rcx
   43b7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b7e:	48 01 d0             	add    %rdx,%rax
   43b81:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43b86:	0f b6 10             	movzbl (%rax),%edx
   43b89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b8d:	88 10                	mov    %dl,(%rax)
        val /= base;
   43b8f:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43b92:	48 63 f0             	movslq %eax,%rsi
   43b95:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43b99:	ba 00 00 00 00       	mov    $0x0,%edx
   43b9e:	48 f7 f6             	div    %rsi
   43ba1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43ba5:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43baa:	75 bc                	jne    43b68 <fill_numbuf+0x42>
    return numbuf_end;
   43bac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43bb0:	c9                   	leave  
   43bb1:	c3                   	ret    

0000000000043bb2 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43bb2:	f3 0f 1e fa          	endbr64 
   43bb6:	55                   	push   %rbp
   43bb7:	48 89 e5             	mov    %rsp,%rbp
   43bba:	53                   	push   %rbx
   43bbb:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43bc2:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43bc9:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43bcf:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43bd6:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43bdd:	e9 bd 09 00 00       	jmp    4459f <printer_vprintf+0x9ed>
        if (*format != '%') {
   43be2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43be9:	0f b6 00             	movzbl (%rax),%eax
   43bec:	3c 25                	cmp    $0x25,%al
   43bee:	74 31                	je     43c21 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   43bf0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43bf7:	4c 8b 00             	mov    (%rax),%r8
   43bfa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c01:	0f b6 00             	movzbl (%rax),%eax
   43c04:	0f b6 c8             	movzbl %al,%ecx
   43c07:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43c0d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c14:	89 ce                	mov    %ecx,%esi
   43c16:	48 89 c7             	mov    %rax,%rdi
   43c19:	41 ff d0             	call   *%r8
            continue;
   43c1c:	e9 76 09 00 00       	jmp    44597 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   43c21:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43c28:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43c2f:	01 
   43c30:	eb 4d                	jmp    43c7f <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   43c32:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c39:	0f b6 00             	movzbl (%rax),%eax
   43c3c:	0f be c0             	movsbl %al,%eax
   43c3f:	89 c6                	mov    %eax,%esi
   43c41:	48 8d 05 f8 16 00 00 	lea    0x16f8(%rip),%rax        # 45340 <flag_chars>
   43c48:	48 89 c7             	mov    %rax,%rdi
   43c4b:	e8 23 fe ff ff       	call   43a73 <strchr>
   43c50:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43c54:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43c59:	74 34                	je     43c8f <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   43c5b:	48 8d 15 de 16 00 00 	lea    0x16de(%rip),%rdx        # 45340 <flag_chars>
   43c62:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43c66:	48 29 d0             	sub    %rdx,%rax
   43c69:	ba 01 00 00 00       	mov    $0x1,%edx
   43c6e:	89 c1                	mov    %eax,%ecx
   43c70:	d3 e2                	shl    %cl,%edx
   43c72:	89 d0                	mov    %edx,%eax
   43c74:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43c77:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43c7e:	01 
   43c7f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c86:	0f b6 00             	movzbl (%rax),%eax
   43c89:	84 c0                	test   %al,%al
   43c8b:	75 a5                	jne    43c32 <printer_vprintf+0x80>
   43c8d:	eb 01                	jmp    43c90 <printer_vprintf+0xde>
            } else {
                break;
   43c8f:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43c90:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43c97:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c9e:	0f b6 00             	movzbl (%rax),%eax
   43ca1:	3c 30                	cmp    $0x30,%al
   43ca3:	7e 67                	jle    43d0c <printer_vprintf+0x15a>
   43ca5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cac:	0f b6 00             	movzbl (%rax),%eax
   43caf:	3c 39                	cmp    $0x39,%al
   43cb1:	7f 59                	jg     43d0c <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43cb3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43cba:	eb 2e                	jmp    43cea <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   43cbc:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43cbf:	89 d0                	mov    %edx,%eax
   43cc1:	c1 e0 02             	shl    $0x2,%eax
   43cc4:	01 d0                	add    %edx,%eax
   43cc6:	01 c0                	add    %eax,%eax
   43cc8:	89 c1                	mov    %eax,%ecx
   43cca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cd1:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43cd5:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43cdc:	0f b6 00             	movzbl (%rax),%eax
   43cdf:	0f be c0             	movsbl %al,%eax
   43ce2:	01 c8                	add    %ecx,%eax
   43ce4:	83 e8 30             	sub    $0x30,%eax
   43ce7:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43cea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cf1:	0f b6 00             	movzbl (%rax),%eax
   43cf4:	3c 2f                	cmp    $0x2f,%al
   43cf6:	0f 8e 85 00 00 00    	jle    43d81 <printer_vprintf+0x1cf>
   43cfc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d03:	0f b6 00             	movzbl (%rax),%eax
   43d06:	3c 39                	cmp    $0x39,%al
   43d08:	7e b2                	jle    43cbc <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   43d0a:	eb 75                	jmp    43d81 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   43d0c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d13:	0f b6 00             	movzbl (%rax),%eax
   43d16:	3c 2a                	cmp    $0x2a,%al
   43d18:	75 68                	jne    43d82 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   43d1a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d21:	8b 00                	mov    (%rax),%eax
   43d23:	83 f8 2f             	cmp    $0x2f,%eax
   43d26:	77 30                	ja     43d58 <printer_vprintf+0x1a6>
   43d28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d2f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d33:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d3a:	8b 00                	mov    (%rax),%eax
   43d3c:	89 c0                	mov    %eax,%eax
   43d3e:	48 01 d0             	add    %rdx,%rax
   43d41:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d48:	8b 12                	mov    (%rdx),%edx
   43d4a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d4d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d54:	89 0a                	mov    %ecx,(%rdx)
   43d56:	eb 1a                	jmp    43d72 <printer_vprintf+0x1c0>
   43d58:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d5f:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d63:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d67:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d6e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d72:	8b 00                	mov    (%rax),%eax
   43d74:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43d77:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43d7e:	01 
   43d7f:	eb 01                	jmp    43d82 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   43d81:	90                   	nop
        }

        // process precision
        int precision = -1;
   43d82:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43d89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d90:	0f b6 00             	movzbl (%rax),%eax
   43d93:	3c 2e                	cmp    $0x2e,%al
   43d95:	0f 85 00 01 00 00    	jne    43e9b <printer_vprintf+0x2e9>
            ++format;
   43d9b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43da2:	01 
            if (*format >= '0' && *format <= '9') {
   43da3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43daa:	0f b6 00             	movzbl (%rax),%eax
   43dad:	3c 2f                	cmp    $0x2f,%al
   43daf:	7e 67                	jle    43e18 <printer_vprintf+0x266>
   43db1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43db8:	0f b6 00             	movzbl (%rax),%eax
   43dbb:	3c 39                	cmp    $0x39,%al
   43dbd:	7f 59                	jg     43e18 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43dbf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43dc6:	eb 2e                	jmp    43df6 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   43dc8:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43dcb:	89 d0                	mov    %edx,%eax
   43dcd:	c1 e0 02             	shl    $0x2,%eax
   43dd0:	01 d0                	add    %edx,%eax
   43dd2:	01 c0                	add    %eax,%eax
   43dd4:	89 c1                	mov    %eax,%ecx
   43dd6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ddd:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43de1:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43de8:	0f b6 00             	movzbl (%rax),%eax
   43deb:	0f be c0             	movsbl %al,%eax
   43dee:	01 c8                	add    %ecx,%eax
   43df0:	83 e8 30             	sub    $0x30,%eax
   43df3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43df6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43dfd:	0f b6 00             	movzbl (%rax),%eax
   43e00:	3c 2f                	cmp    $0x2f,%al
   43e02:	0f 8e 85 00 00 00    	jle    43e8d <printer_vprintf+0x2db>
   43e08:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e0f:	0f b6 00             	movzbl (%rax),%eax
   43e12:	3c 39                	cmp    $0x39,%al
   43e14:	7e b2                	jle    43dc8 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   43e16:	eb 75                	jmp    43e8d <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   43e18:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e1f:	0f b6 00             	movzbl (%rax),%eax
   43e22:	3c 2a                	cmp    $0x2a,%al
   43e24:	75 68                	jne    43e8e <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   43e26:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e2d:	8b 00                	mov    (%rax),%eax
   43e2f:	83 f8 2f             	cmp    $0x2f,%eax
   43e32:	77 30                	ja     43e64 <printer_vprintf+0x2b2>
   43e34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e3b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e3f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e46:	8b 00                	mov    (%rax),%eax
   43e48:	89 c0                	mov    %eax,%eax
   43e4a:	48 01 d0             	add    %rdx,%rax
   43e4d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e54:	8b 12                	mov    (%rdx),%edx
   43e56:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e59:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e60:	89 0a                	mov    %ecx,(%rdx)
   43e62:	eb 1a                	jmp    43e7e <printer_vprintf+0x2cc>
   43e64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e6b:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e6f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e73:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e7a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e7e:	8b 00                	mov    (%rax),%eax
   43e80:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43e83:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43e8a:	01 
   43e8b:	eb 01                	jmp    43e8e <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   43e8d:	90                   	nop
            }
            if (precision < 0) {
   43e8e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43e92:	79 07                	jns    43e9b <printer_vprintf+0x2e9>
                precision = 0;
   43e94:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43e9b:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43ea2:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43ea9:	00 
        int length = 0;
   43eaa:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43eb1:	48 8d 05 8e 14 00 00 	lea    0x148e(%rip),%rax        # 45346 <flag_chars+0x6>
   43eb8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   43ebc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ec3:	0f b6 00             	movzbl (%rax),%eax
   43ec6:	0f be c0             	movsbl %al,%eax
   43ec9:	83 e8 43             	sub    $0x43,%eax
   43ecc:	83 f8 37             	cmp    $0x37,%eax
   43ecf:	0f 87 b6 03 00 00    	ja     4428b <printer_vprintf+0x6d9>
   43ed5:	89 c0                	mov    %eax,%eax
   43ed7:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   43ede:	00 
   43edf:	48 8d 05 6e 14 00 00 	lea    0x146e(%rip),%rax        # 45354 <flag_chars+0x14>
   43ee6:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   43ee9:	48 98                	cltq   
   43eeb:	48 8d 15 62 14 00 00 	lea    0x1462(%rip),%rdx        # 45354 <flag_chars+0x14>
   43ef2:	48 01 d0             	add    %rdx,%rax
   43ef5:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   43ef8:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43eff:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43f06:	01 
            goto again;
   43f07:	eb b3                	jmp    43ebc <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43f09:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43f0d:	74 5d                	je     43f6c <printer_vprintf+0x3ba>
   43f0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f16:	8b 00                	mov    (%rax),%eax
   43f18:	83 f8 2f             	cmp    $0x2f,%eax
   43f1b:	77 30                	ja     43f4d <printer_vprintf+0x39b>
   43f1d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f24:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f2f:	8b 00                	mov    (%rax),%eax
   43f31:	89 c0                	mov    %eax,%eax
   43f33:	48 01 d0             	add    %rdx,%rax
   43f36:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f3d:	8b 12                	mov    (%rdx),%edx
   43f3f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f42:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f49:	89 0a                	mov    %ecx,(%rdx)
   43f4b:	eb 1a                	jmp    43f67 <printer_vprintf+0x3b5>
   43f4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f54:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f58:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f5c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f63:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f67:	48 8b 00             	mov    (%rax),%rax
   43f6a:	eb 5c                	jmp    43fc8 <printer_vprintf+0x416>
   43f6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f73:	8b 00                	mov    (%rax),%eax
   43f75:	83 f8 2f             	cmp    $0x2f,%eax
   43f78:	77 30                	ja     43faa <printer_vprintf+0x3f8>
   43f7a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f81:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f8c:	8b 00                	mov    (%rax),%eax
   43f8e:	89 c0                	mov    %eax,%eax
   43f90:	48 01 d0             	add    %rdx,%rax
   43f93:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f9a:	8b 12                	mov    (%rdx),%edx
   43f9c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f9f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fa6:	89 0a                	mov    %ecx,(%rdx)
   43fa8:	eb 1a                	jmp    43fc4 <printer_vprintf+0x412>
   43faa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fb1:	48 8b 40 08          	mov    0x8(%rax),%rax
   43fb5:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43fb9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fc0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43fc4:	8b 00                	mov    (%rax),%eax
   43fc6:	48 98                	cltq   
   43fc8:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43fcc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43fd0:	48 c1 f8 38          	sar    $0x38,%rax
   43fd4:	25 80 00 00 00       	and    $0x80,%eax
   43fd9:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43fdc:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43fe0:	74 09                	je     43feb <printer_vprintf+0x439>
   43fe2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43fe6:	48 f7 d8             	neg    %rax
   43fe9:	eb 04                	jmp    43fef <printer_vprintf+0x43d>
   43feb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43fef:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43ff3:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43ff6:	83 c8 60             	or     $0x60,%eax
   43ff9:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43ffc:	e9 cf 02 00 00       	jmp    442d0 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   44001:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44005:	74 5d                	je     44064 <printer_vprintf+0x4b2>
   44007:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4400e:	8b 00                	mov    (%rax),%eax
   44010:	83 f8 2f             	cmp    $0x2f,%eax
   44013:	77 30                	ja     44045 <printer_vprintf+0x493>
   44015:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4401c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44020:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44027:	8b 00                	mov    (%rax),%eax
   44029:	89 c0                	mov    %eax,%eax
   4402b:	48 01 d0             	add    %rdx,%rax
   4402e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44035:	8b 12                	mov    (%rdx),%edx
   44037:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4403a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44041:	89 0a                	mov    %ecx,(%rdx)
   44043:	eb 1a                	jmp    4405f <printer_vprintf+0x4ad>
   44045:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4404c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44050:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44054:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4405b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4405f:	48 8b 00             	mov    (%rax),%rax
   44062:	eb 5c                	jmp    440c0 <printer_vprintf+0x50e>
   44064:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4406b:	8b 00                	mov    (%rax),%eax
   4406d:	83 f8 2f             	cmp    $0x2f,%eax
   44070:	77 30                	ja     440a2 <printer_vprintf+0x4f0>
   44072:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44079:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4407d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44084:	8b 00                	mov    (%rax),%eax
   44086:	89 c0                	mov    %eax,%eax
   44088:	48 01 d0             	add    %rdx,%rax
   4408b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44092:	8b 12                	mov    (%rdx),%edx
   44094:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44097:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4409e:	89 0a                	mov    %ecx,(%rdx)
   440a0:	eb 1a                	jmp    440bc <printer_vprintf+0x50a>
   440a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440a9:	48 8b 40 08          	mov    0x8(%rax),%rax
   440ad:	48 8d 48 08          	lea    0x8(%rax),%rcx
   440b1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440b8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440bc:	8b 00                	mov    (%rax),%eax
   440be:	89 c0                	mov    %eax,%eax
   440c0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   440c4:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   440c8:	e9 03 02 00 00       	jmp    442d0 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   440cd:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   440d4:	e9 28 ff ff ff       	jmp    44001 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   440d9:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   440e0:	e9 1c ff ff ff       	jmp    44001 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   440e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440ec:	8b 00                	mov    (%rax),%eax
   440ee:	83 f8 2f             	cmp    $0x2f,%eax
   440f1:	77 30                	ja     44123 <printer_vprintf+0x571>
   440f3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440fa:	48 8b 50 10          	mov    0x10(%rax),%rdx
   440fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44105:	8b 00                	mov    (%rax),%eax
   44107:	89 c0                	mov    %eax,%eax
   44109:	48 01 d0             	add    %rdx,%rax
   4410c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44113:	8b 12                	mov    (%rdx),%edx
   44115:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44118:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4411f:	89 0a                	mov    %ecx,(%rdx)
   44121:	eb 1a                	jmp    4413d <printer_vprintf+0x58b>
   44123:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4412a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4412e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44132:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44139:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4413d:	48 8b 00             	mov    (%rax),%rax
   44140:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   44144:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   4414b:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   44152:	e9 79 01 00 00       	jmp    442d0 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   44157:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4415e:	8b 00                	mov    (%rax),%eax
   44160:	83 f8 2f             	cmp    $0x2f,%eax
   44163:	77 30                	ja     44195 <printer_vprintf+0x5e3>
   44165:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4416c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44170:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44177:	8b 00                	mov    (%rax),%eax
   44179:	89 c0                	mov    %eax,%eax
   4417b:	48 01 d0             	add    %rdx,%rax
   4417e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44185:	8b 12                	mov    (%rdx),%edx
   44187:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4418a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44191:	89 0a                	mov    %ecx,(%rdx)
   44193:	eb 1a                	jmp    441af <printer_vprintf+0x5fd>
   44195:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4419c:	48 8b 40 08          	mov    0x8(%rax),%rax
   441a0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441a4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441ab:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441af:	48 8b 00             	mov    (%rax),%rax
   441b2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   441b6:	e9 15 01 00 00       	jmp    442d0 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   441bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441c2:	8b 00                	mov    (%rax),%eax
   441c4:	83 f8 2f             	cmp    $0x2f,%eax
   441c7:	77 30                	ja     441f9 <printer_vprintf+0x647>
   441c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441d0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   441d4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441db:	8b 00                	mov    (%rax),%eax
   441dd:	89 c0                	mov    %eax,%eax
   441df:	48 01 d0             	add    %rdx,%rax
   441e2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441e9:	8b 12                	mov    (%rdx),%edx
   441eb:	8d 4a 08             	lea    0x8(%rdx),%ecx
   441ee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441f5:	89 0a                	mov    %ecx,(%rdx)
   441f7:	eb 1a                	jmp    44213 <printer_vprintf+0x661>
   441f9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44200:	48 8b 40 08          	mov    0x8(%rax),%rax
   44204:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44208:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4420f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44213:	8b 00                	mov    (%rax),%eax
   44215:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   4421b:	e9 77 03 00 00       	jmp    44597 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   44220:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44224:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44228:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4422f:	8b 00                	mov    (%rax),%eax
   44231:	83 f8 2f             	cmp    $0x2f,%eax
   44234:	77 30                	ja     44266 <printer_vprintf+0x6b4>
   44236:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4423d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44241:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44248:	8b 00                	mov    (%rax),%eax
   4424a:	89 c0                	mov    %eax,%eax
   4424c:	48 01 d0             	add    %rdx,%rax
   4424f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44256:	8b 12                	mov    (%rdx),%edx
   44258:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4425b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44262:	89 0a                	mov    %ecx,(%rdx)
   44264:	eb 1a                	jmp    44280 <printer_vprintf+0x6ce>
   44266:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4426d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44271:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44275:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4427c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44280:	8b 00                	mov    (%rax),%eax
   44282:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44285:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   44289:	eb 45                	jmp    442d0 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   4428b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4428f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   44293:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4429a:	0f b6 00             	movzbl (%rax),%eax
   4429d:	84 c0                	test   %al,%al
   4429f:	74 0c                	je     442ad <printer_vprintf+0x6fb>
   442a1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   442a8:	0f b6 00             	movzbl (%rax),%eax
   442ab:	eb 05                	jmp    442b2 <printer_vprintf+0x700>
   442ad:	b8 25 00 00 00       	mov    $0x25,%eax
   442b2:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   442b5:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   442b9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   442c0:	0f b6 00             	movzbl (%rax),%eax
   442c3:	84 c0                	test   %al,%al
   442c5:	75 08                	jne    442cf <printer_vprintf+0x71d>
                format--;
   442c7:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   442ce:	01 
            }
            break;
   442cf:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   442d0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   442d3:	83 e0 20             	and    $0x20,%eax
   442d6:	85 c0                	test   %eax,%eax
   442d8:	74 1e                	je     442f8 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   442da:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   442de:	48 83 c0 18          	add    $0x18,%rax
   442e2:	8b 55 e0             	mov    -0x20(%rbp),%edx
   442e5:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   442e9:	48 89 ce             	mov    %rcx,%rsi
   442ec:	48 89 c7             	mov    %rax,%rdi
   442ef:	e8 32 f8 ff ff       	call   43b26 <fill_numbuf>
   442f4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   442f8:	48 8d 05 47 10 00 00 	lea    0x1047(%rip),%rax        # 45346 <flag_chars+0x6>
   442ff:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44303:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44306:	83 e0 20             	and    $0x20,%eax
   44309:	85 c0                	test   %eax,%eax
   4430b:	74 51                	je     4435e <printer_vprintf+0x7ac>
   4430d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44310:	83 e0 40             	and    $0x40,%eax
   44313:	85 c0                	test   %eax,%eax
   44315:	74 47                	je     4435e <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   44317:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4431a:	25 80 00 00 00       	and    $0x80,%eax
   4431f:	85 c0                	test   %eax,%eax
   44321:	74 0d                	je     44330 <printer_vprintf+0x77e>
                prefix = "-";
   44323:	48 8d 05 1d 10 00 00 	lea    0x101d(%rip),%rax        # 45347 <flag_chars+0x7>
   4432a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   4432e:	eb 7d                	jmp    443ad <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44330:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44333:	83 e0 10             	and    $0x10,%eax
   44336:	85 c0                	test   %eax,%eax
   44338:	74 0d                	je     44347 <printer_vprintf+0x795>
                prefix = "+";
   4433a:	48 8d 05 08 10 00 00 	lea    0x1008(%rip),%rax        # 45349 <flag_chars+0x9>
   44341:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44345:	eb 66                	jmp    443ad <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44347:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4434a:	83 e0 08             	and    $0x8,%eax
   4434d:	85 c0                	test   %eax,%eax
   4434f:	74 5c                	je     443ad <printer_vprintf+0x7fb>
                prefix = " ";
   44351:	48 8d 05 f3 0f 00 00 	lea    0xff3(%rip),%rax        # 4534b <flag_chars+0xb>
   44358:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   4435c:	eb 4f                	jmp    443ad <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   4435e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44361:	83 e0 20             	and    $0x20,%eax
   44364:	85 c0                	test   %eax,%eax
   44366:	74 46                	je     443ae <printer_vprintf+0x7fc>
   44368:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4436b:	83 e0 01             	and    $0x1,%eax
   4436e:	85 c0                	test   %eax,%eax
   44370:	74 3c                	je     443ae <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   44372:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   44376:	74 06                	je     4437e <printer_vprintf+0x7cc>
   44378:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4437c:	75 30                	jne    443ae <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   4437e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44383:	75 0c                	jne    44391 <printer_vprintf+0x7df>
   44385:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44388:	25 00 01 00 00       	and    $0x100,%eax
   4438d:	85 c0                	test   %eax,%eax
   4438f:	74 1d                	je     443ae <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   44391:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44395:	75 09                	jne    443a0 <printer_vprintf+0x7ee>
   44397:	48 8d 05 af 0f 00 00 	lea    0xfaf(%rip),%rax        # 4534d <flag_chars+0xd>
   4439e:	eb 07                	jmp    443a7 <printer_vprintf+0x7f5>
   443a0:	48 8d 05 a9 0f 00 00 	lea    0xfa9(%rip),%rax        # 45350 <flag_chars+0x10>
   443a7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   443ab:	eb 01                	jmp    443ae <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   443ad:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   443ae:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   443b2:	78 24                	js     443d8 <printer_vprintf+0x826>
   443b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443b7:	83 e0 20             	and    $0x20,%eax
   443ba:	85 c0                	test   %eax,%eax
   443bc:	75 1a                	jne    443d8 <printer_vprintf+0x826>
            len = strnlen(data, precision);
   443be:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   443c1:	48 63 d0             	movslq %eax,%rdx
   443c4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   443c8:	48 89 d6             	mov    %rdx,%rsi
   443cb:	48 89 c7             	mov    %rax,%rdi
   443ce:	e8 91 f5 ff ff       	call   43964 <strnlen>
   443d3:	89 45 bc             	mov    %eax,-0x44(%rbp)
   443d6:	eb 0f                	jmp    443e7 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   443d8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   443dc:	48 89 c7             	mov    %rax,%rdi
   443df:	e8 4b f5 ff ff       	call   4392f <strlen>
   443e4:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   443e7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443ea:	83 e0 20             	and    $0x20,%eax
   443ed:	85 c0                	test   %eax,%eax
   443ef:	74 20                	je     44411 <printer_vprintf+0x85f>
   443f1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   443f5:	78 1a                	js     44411 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   443f7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   443fa:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   443fd:	7e 08                	jle    44407 <printer_vprintf+0x855>
   443ff:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44402:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44405:	eb 05                	jmp    4440c <printer_vprintf+0x85a>
   44407:	b8 00 00 00 00       	mov    $0x0,%eax
   4440c:	89 45 b8             	mov    %eax,-0x48(%rbp)
   4440f:	eb 5c                	jmp    4446d <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44411:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44414:	83 e0 20             	and    $0x20,%eax
   44417:	85 c0                	test   %eax,%eax
   44419:	74 4b                	je     44466 <printer_vprintf+0x8b4>
   4441b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4441e:	83 e0 02             	and    $0x2,%eax
   44421:	85 c0                	test   %eax,%eax
   44423:	74 41                	je     44466 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44425:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44428:	83 e0 04             	and    $0x4,%eax
   4442b:	85 c0                	test   %eax,%eax
   4442d:	75 37                	jne    44466 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   4442f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44433:	48 89 c7             	mov    %rax,%rdi
   44436:	e8 f4 f4 ff ff       	call   4392f <strlen>
   4443b:	89 c2                	mov    %eax,%edx
   4443d:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44440:	01 d0                	add    %edx,%eax
   44442:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44445:	7e 1f                	jle    44466 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   44447:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4444a:	2b 45 bc             	sub    -0x44(%rbp),%eax
   4444d:	89 c3                	mov    %eax,%ebx
   4444f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44453:	48 89 c7             	mov    %rax,%rdi
   44456:	e8 d4 f4 ff ff       	call   4392f <strlen>
   4445b:	89 c2                	mov    %eax,%edx
   4445d:	89 d8                	mov    %ebx,%eax
   4445f:	29 d0                	sub    %edx,%eax
   44461:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44464:	eb 07                	jmp    4446d <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   44466:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   4446d:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44470:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44473:	01 d0                	add    %edx,%eax
   44475:	48 63 d8             	movslq %eax,%rbx
   44478:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4447c:	48 89 c7             	mov    %rax,%rdi
   4447f:	e8 ab f4 ff ff       	call   4392f <strlen>
   44484:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   44488:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4448b:	29 d0                	sub    %edx,%eax
   4448d:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44490:	eb 25                	jmp    444b7 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   44492:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44499:	48 8b 08             	mov    (%rax),%rcx
   4449c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   444a2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   444a9:	be 20 00 00 00       	mov    $0x20,%esi
   444ae:	48 89 c7             	mov    %rax,%rdi
   444b1:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   444b3:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   444b7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   444ba:	83 e0 04             	and    $0x4,%eax
   444bd:	85 c0                	test   %eax,%eax
   444bf:	75 36                	jne    444f7 <printer_vprintf+0x945>
   444c1:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   444c5:	7f cb                	jg     44492 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   444c7:	eb 2e                	jmp    444f7 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   444c9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   444d0:	4c 8b 00             	mov    (%rax),%r8
   444d3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   444d7:	0f b6 00             	movzbl (%rax),%eax
   444da:	0f b6 c8             	movzbl %al,%ecx
   444dd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   444e3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   444ea:	89 ce                	mov    %ecx,%esi
   444ec:	48 89 c7             	mov    %rax,%rdi
   444ef:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   444f2:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   444f7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   444fb:	0f b6 00             	movzbl (%rax),%eax
   444fe:	84 c0                	test   %al,%al
   44500:	75 c7                	jne    444c9 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   44502:	eb 25                	jmp    44529 <printer_vprintf+0x977>
            p->putc(p, '0', color);
   44504:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4450b:	48 8b 08             	mov    (%rax),%rcx
   4450e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44514:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4451b:	be 30 00 00 00       	mov    $0x30,%esi
   44520:	48 89 c7             	mov    %rax,%rdi
   44523:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44525:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44529:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   4452d:	7f d5                	jg     44504 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   4452f:	eb 32                	jmp    44563 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   44531:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44538:	4c 8b 00             	mov    (%rax),%r8
   4453b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4453f:	0f b6 00             	movzbl (%rax),%eax
   44542:	0f b6 c8             	movzbl %al,%ecx
   44545:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4454b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44552:	89 ce                	mov    %ecx,%esi
   44554:	48 89 c7             	mov    %rax,%rdi
   44557:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   4455a:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   4455f:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44563:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44567:	7f c8                	jg     44531 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   44569:	eb 25                	jmp    44590 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   4456b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44572:	48 8b 08             	mov    (%rax),%rcx
   44575:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4457b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44582:	be 20 00 00 00       	mov    $0x20,%esi
   44587:	48 89 c7             	mov    %rax,%rdi
   4458a:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   4458c:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44590:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44594:	7f d5                	jg     4456b <printer_vprintf+0x9b9>
        }
    done: ;
   44596:	90                   	nop
    for (; *format; ++format) {
   44597:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4459e:	01 
   4459f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   445a6:	0f b6 00             	movzbl (%rax),%eax
   445a9:	84 c0                	test   %al,%al
   445ab:	0f 85 31 f6 ff ff    	jne    43be2 <printer_vprintf+0x30>
    }
}
   445b1:	90                   	nop
   445b2:	90                   	nop
   445b3:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   445b7:	c9                   	leave  
   445b8:	c3                   	ret    

00000000000445b9 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   445b9:	f3 0f 1e fa          	endbr64 
   445bd:	55                   	push   %rbp
   445be:	48 89 e5             	mov    %rsp,%rbp
   445c1:	48 83 ec 20          	sub    $0x20,%rsp
   445c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   445c9:	89 f0                	mov    %esi,%eax
   445cb:	89 55 e0             	mov    %edx,-0x20(%rbp)
   445ce:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   445d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   445d5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   445d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   445dd:	48 8b 40 08          	mov    0x8(%rax),%rax
   445e1:	48 8d 15 b8 49 07 00 	lea    0x749b8(%rip),%rdx        # b8fa0 <console+0xfa0>
   445e8:	48 39 d0             	cmp    %rdx,%rax
   445eb:	72 0f                	jb     445fc <console_putc+0x43>
        cp->cursor = console;
   445ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   445f1:	48 8d 15 08 3a 07 00 	lea    0x73a08(%rip),%rdx        # b8000 <console>
   445f8:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   445fc:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44600:	0f 85 82 00 00 00    	jne    44688 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   44606:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4460a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4460e:	48 8d 15 eb 39 07 00 	lea    0x739eb(%rip),%rdx        # b8000 <console>
   44615:	48 29 d0             	sub    %rdx,%rax
   44618:	48 d1 f8             	sar    %rax
   4461b:	48 89 c1             	mov    %rax,%rcx
   4461e:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44625:	66 66 66 
   44628:	48 89 c8             	mov    %rcx,%rax
   4462b:	48 f7 ea             	imul   %rdx
   4462e:	48 89 d0             	mov    %rdx,%rax
   44631:	48 c1 f8 05          	sar    $0x5,%rax
   44635:	48 89 ce             	mov    %rcx,%rsi
   44638:	48 c1 fe 3f          	sar    $0x3f,%rsi
   4463c:	48 29 f0             	sub    %rsi,%rax
   4463f:	48 89 c2             	mov    %rax,%rdx
   44642:	48 89 d0             	mov    %rdx,%rax
   44645:	48 c1 e0 02          	shl    $0x2,%rax
   44649:	48 01 d0             	add    %rdx,%rax
   4464c:	48 c1 e0 04          	shl    $0x4,%rax
   44650:	48 29 c1             	sub    %rax,%rcx
   44653:	48 89 ca             	mov    %rcx,%rdx
   44656:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44659:	eb 25                	jmp    44680 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   4465b:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4465e:	83 c8 20             	or     $0x20,%eax
   44661:	89 c6                	mov    %eax,%esi
   44663:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44667:	48 8b 40 08          	mov    0x8(%rax),%rax
   4466b:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4466f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44673:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44677:	89 f2                	mov    %esi,%edx
   44679:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   4467c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44680:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44684:	75 d5                	jne    4465b <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44686:	eb 24                	jmp    446ac <console_putc+0xf3>
        *cp->cursor++ = c | color;
   44688:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   4468c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4468f:	89 d6                	mov    %edx,%esi
   44691:	09 c6                	or     %eax,%esi
   44693:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44697:	48 8b 40 08          	mov    0x8(%rax),%rax
   4469b:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4469f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   446a3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   446a7:	89 f2                	mov    %esi,%edx
   446a9:	66 89 10             	mov    %dx,(%rax)
}
   446ac:	90                   	nop
   446ad:	c9                   	leave  
   446ae:	c3                   	ret    

00000000000446af <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   446af:	f3 0f 1e fa          	endbr64 
   446b3:	55                   	push   %rbp
   446b4:	48 89 e5             	mov    %rsp,%rbp
   446b7:	48 83 ec 30          	sub    $0x30,%rsp
   446bb:	89 7d ec             	mov    %edi,-0x14(%rbp)
   446be:	89 75 e8             	mov    %esi,-0x18(%rbp)
   446c1:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   446c5:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   446c9:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 445b9 <console_putc>
   446d0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   446d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   446d8:	78 09                	js     446e3 <console_vprintf+0x34>
   446da:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   446e1:	7e 07                	jle    446ea <console_vprintf+0x3b>
        cpos = 0;
   446e3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   446ea:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446ed:	48 98                	cltq   
   446ef:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   446f3:	48 8d 05 06 39 07 00 	lea    0x73906(%rip),%rax        # b8000 <console>
   446fa:	48 01 d0             	add    %rdx,%rax
   446fd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44701:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44705:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44709:	8b 75 e8             	mov    -0x18(%rbp),%esi
   4470c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44710:	48 89 c7             	mov    %rax,%rdi
   44713:	e8 9a f4 ff ff       	call   43bb2 <printer_vprintf>
    return cp.cursor - console;
   44718:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4471c:	48 8d 15 dd 38 07 00 	lea    0x738dd(%rip),%rdx        # b8000 <console>
   44723:	48 29 d0             	sub    %rdx,%rax
   44726:	48 d1 f8             	sar    %rax
}
   44729:	c9                   	leave  
   4472a:	c3                   	ret    

000000000004472b <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   4472b:	f3 0f 1e fa          	endbr64 
   4472f:	55                   	push   %rbp
   44730:	48 89 e5             	mov    %rsp,%rbp
   44733:	48 83 ec 60          	sub    $0x60,%rsp
   44737:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4473a:	89 75 a8             	mov    %esi,-0x58(%rbp)
   4473d:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44741:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44745:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44749:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4474d:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44754:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44758:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4475c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44760:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44764:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44768:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4476c:	8b 75 a8             	mov    -0x58(%rbp),%esi
   4476f:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44772:	89 c7                	mov    %eax,%edi
   44774:	e8 36 ff ff ff       	call   446af <console_vprintf>
   44779:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4477c:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4477f:	c9                   	leave  
   44780:	c3                   	ret    

0000000000044781 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44781:	f3 0f 1e fa          	endbr64 
   44785:	55                   	push   %rbp
   44786:	48 89 e5             	mov    %rsp,%rbp
   44789:	48 83 ec 20          	sub    $0x20,%rsp
   4478d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44791:	89 f0                	mov    %esi,%eax
   44793:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44796:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44799:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4479d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   447a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   447a5:	48 8b 50 08          	mov    0x8(%rax),%rdx
   447a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   447ad:	48 8b 40 10          	mov    0x10(%rax),%rax
   447b1:	48 39 c2             	cmp    %rax,%rdx
   447b4:	73 1a                	jae    447d0 <string_putc+0x4f>
        *sp->s++ = c;
   447b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   447ba:	48 8b 40 08          	mov    0x8(%rax),%rax
   447be:	48 8d 48 01          	lea    0x1(%rax),%rcx
   447c2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   447c6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   447ca:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   447ce:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   447d0:	90                   	nop
   447d1:	c9                   	leave  
   447d2:	c3                   	ret    

00000000000447d3 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   447d3:	f3 0f 1e fa          	endbr64 
   447d7:	55                   	push   %rbp
   447d8:	48 89 e5             	mov    %rsp,%rbp
   447db:	48 83 ec 40          	sub    $0x40,%rsp
   447df:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   447e3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   447e7:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   447eb:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   447ef:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 44781 <string_putc>
   447f6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   447fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   447fe:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44802:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44807:	74 33                	je     4483c <vsnprintf+0x69>
        sp.end = s + size - 1;
   44809:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4480d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44811:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44815:	48 01 d0             	add    %rdx,%rax
   44818:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   4481c:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44820:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44824:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44828:	be 00 00 00 00       	mov    $0x0,%esi
   4482d:	48 89 c7             	mov    %rax,%rdi
   44830:	e8 7d f3 ff ff       	call   43bb2 <printer_vprintf>
        *sp.s = 0;
   44835:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44839:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   4483c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44840:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44844:	c9                   	leave  
   44845:	c3                   	ret    

0000000000044846 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44846:	f3 0f 1e fa          	endbr64 
   4484a:	55                   	push   %rbp
   4484b:	48 89 e5             	mov    %rsp,%rbp
   4484e:	48 83 ec 70          	sub    $0x70,%rsp
   44852:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44856:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   4485a:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   4485e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44862:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44866:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4486a:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44871:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44875:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44879:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4487d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44881:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44885:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44889:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   4488d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44891:	48 89 c7             	mov    %rax,%rdi
   44894:	e8 3a ff ff ff       	call   447d3 <vsnprintf>
   44899:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   4489c:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   4489f:	c9                   	leave  
   448a0:	c3                   	ret    

00000000000448a1 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   448a1:	f3 0f 1e fa          	endbr64 
   448a5:	55                   	push   %rbp
   448a6:	48 89 e5             	mov    %rsp,%rbp
   448a9:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   448ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   448b4:	eb 1a                	jmp    448d0 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   448b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   448b9:	48 98                	cltq   
   448bb:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   448bf:	48 8d 05 3a 37 07 00 	lea    0x7373a(%rip),%rax        # b8000 <console>
   448c6:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   448cc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   448d0:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   448d7:	7e dd                	jle    448b6 <console_clear+0x15>
    }
    cursorpos = 0;
   448d9:	c7 05 19 47 07 00 00 	movl   $0x0,0x74719(%rip)        # b8ffc <cursorpos>
   448e0:	00 00 00 
}
   448e3:	90                   	nop
   448e4:	c9                   	leave  
   448e5:	c3                   	ret    
