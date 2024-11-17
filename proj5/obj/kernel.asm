
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
   400be:	e8 7b 08 00 00       	call   4093e <exception>

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
   40177:	e8 ed 17 00 00       	call   41969 <hardware_init>
    pageinfo_init();
   4017c:	e8 ed 0c 00 00       	call   40e6e <pageinfo_init>
    console_clear();
   40181:	e8 7e 44 00 00       	call   44604 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 41 1d 00 00       	call   41ed1 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 7f 1e 01 00 	lea    0x11e7f(%rip),%rax        # 52020 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 a6 34 00 00       	call   4364f <memset>
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
   40210:	48 8d 15 49 44 00 00 	lea    0x4449(%rip),%rdx        # 44660 <console_clear+0x5c>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 36 35 00 00       	call   43758 <strcmp>
   40222:	85 c0                	test   %eax,%eax
   40224:	75 14                	jne    4023a <kernel+0xd3>
        process_setup(1, 4);
   40226:	be 04 00 00 00       	mov    $0x4,%esi
   4022b:	bf 01 00 00 00       	mov    $0x1,%edi
   40230:	e8 cf 01 00 00       	call   40404 <process_setup>
   40235:	e9 d1 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4023a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4023f:	74 2e                	je     4026f <kernel+0x108>
   40241:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40245:	48 8d 15 19 44 00 00 	lea    0x4419(%rip),%rdx        # 44665 <console_clear+0x61>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 01 35 00 00       	call   43758 <strcmp>
   40257:	85 c0                	test   %eax,%eax
   40259:	75 14                	jne    4026f <kernel+0x108>
        process_setup(1, 5);
   4025b:	be 05 00 00 00       	mov    $0x5,%esi
   40260:	bf 01 00 00 00       	mov    $0x1,%edi
   40265:	e8 9a 01 00 00       	call   40404 <process_setup>
   4026a:	e9 9c 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test") == 0) {
   4026f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40274:	74 2b                	je     402a1 <kernel+0x13a>
   40276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4027a:	48 8d 15 ed 43 00 00 	lea    0x43ed(%rip),%rdx        # 4466e <console_clear+0x6a>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 cc 34 00 00       	call   43758 <strcmp>
   4028c:	85 c0                	test   %eax,%eax
   4028e:	75 11                	jne    402a1 <kernel+0x13a>
        process_setup(1, 6);
   40290:	be 06 00 00 00       	mov    $0x6,%esi
   40295:	bf 01 00 00 00       	mov    $0x1,%edi
   4029a:	e8 65 01 00 00       	call   40404 <process_setup>
   4029f:	eb 6a                	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test2") == 0) {
   402a1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a6:	74 3e                	je     402e6 <kernel+0x17f>
   402a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402ac:	48 8d 15 c0 43 00 00 	lea    0x43c0(%rip),%rdx        # 44673 <console_clear+0x6f>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 9a 34 00 00       	call   43758 <strcmp>
   402be:	85 c0                	test   %eax,%eax
   402c0:	75 24                	jne    402e6 <kernel+0x17f>
        for (pid_t i = 1; i <= 2; ++i) {
   402c2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402c9:	eb 13                	jmp    402de <kernel+0x177>
            process_setup(i, 6);
   402cb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402ce:	be 06 00 00 00       	mov    $0x6,%esi
   402d3:	89 c7                	mov    %eax,%edi
   402d5:	e8 2a 01 00 00       	call   40404 <process_setup>
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
   402fc:	e8 03 01 00 00       	call   40404 <process_setup>
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
   4032a:	e8 0f 2a 00 00       	call   42d3e <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   4032f:	48 8d 15 ca 7c 07 00 	lea    0x77cca(%rip),%rdx        # b8000 <console>
   40336:	48 8d 35 c3 7c 07 00 	lea    0x77cc3(%rip),%rsi        # b8000 <console>
   4033d:	48 8b 05 bc 4c 01 00 	mov    0x14cbc(%rip),%rax        # 55000 <kernel_pagetable>
   40344:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4034a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4034f:	48 89 c7             	mov    %rax,%rdi
   40352:	e8 e7 29 00 00       	call   42d3e <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    // Switch to the first process using run()
    run(&processes[1]);
   40357:	48 8d 05 a2 1d 01 00 	lea    0x11da2(%rip),%rax        # 52100 <processes+0xe0>
   4035e:	48 89 c7             	mov    %rax,%rdi
   40361:	e8 9d 0a 00 00       	call   40e03 <run>

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
   403e0:	e8 6a 32 00 00       	call   4364f <memset>
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

0000000000040404 <process_setup>:

void process_setup(pid_t pid, int program_number) {
   40404:	f3 0f 1e fa          	endbr64 
   40408:	55                   	push   %rbp
   40409:	48 89 e5             	mov    %rsp,%rbp
   4040c:	48 83 ec 70          	sub    $0x70,%rsp
   40410:	89 7d 9c             	mov    %edi,-0x64(%rbp)
   40413:	89 75 98             	mov    %esi,-0x68(%rbp)
    process_init(&processes[pid], 0);
   40416:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40419:	48 63 d0             	movslq %eax,%rdx
   4041c:	48 89 d0             	mov    %rdx,%rax
   4041f:	48 c1 e0 03          	shl    $0x3,%rax
   40423:	48 29 d0             	sub    %rdx,%rax
   40426:	48 c1 e0 05          	shl    $0x5,%rax
   4042a:	48 8d 15 ef 1b 01 00 	lea    0x11bef(%rip),%rdx        # 52020 <processes>
   40431:	48 01 d0             	add    %rdx,%rax
   40434:	be 00 00 00 00       	mov    $0x0,%esi
   40439:	48 89 c7             	mov    %rax,%rdi
   4043c:	e8 43 1d 00 00       	call   42184 <process_init>
    x86_64_pagetable *l4 = reserve_page(pid);
   40441:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40444:	0f be c0             	movsbl %al,%eax
   40447:	89 c7                	mov    %eax,%edi
   40449:	e8 18 ff ff ff       	call   40366 <reserve_page>
   4044e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    x86_64_pagetable *l3 = reserve_page(pid);
   40452:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40455:	0f be c0             	movsbl %al,%eax
   40458:	89 c7                	mov    %eax,%edi
   4045a:	e8 07 ff ff ff       	call   40366 <reserve_page>
   4045f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    x86_64_pagetable *l2 = reserve_page(pid);
   40463:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40466:	0f be c0             	movsbl %al,%eax
   40469:	89 c7                	mov    %eax,%edi
   4046b:	e8 f6 fe ff ff       	call   40366 <reserve_page>
   40470:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    x86_64_pagetable *l1_1 = reserve_page(pid);
   40474:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40477:	0f be c0             	movsbl %al,%eax
   4047a:	89 c7                	mov    %eax,%edi
   4047c:	e8 e5 fe ff ff       	call   40366 <reserve_page>
   40481:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    x86_64_pagetable *l1_0 = reserve_page(pid);
   40485:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40488:	0f be c0             	movsbl %al,%eax
   4048b:	89 c7                	mov    %eax,%edi
   4048d:	e8 d4 fe ff ff       	call   40366 <reserve_page>
   40492:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

    l4->entry[0] = (x86_64_pageentry_t)l3 | PTE_P | PTE_W | PTE_U;
   40496:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4049a:	48 83 c8 07          	or     $0x7,%rax
   4049e:	48 89 c2             	mov    %rax,%rdx
   404a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   404a5:	48 89 10             	mov    %rdx,(%rax)
    l3->entry[0] = (x86_64_pageentry_t)l2 | PTE_P | PTE_W | PTE_U;
   404a8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   404ac:	48 83 c8 07          	or     $0x7,%rax
   404b0:	48 89 c2             	mov    %rax,%rdx
   404b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404b7:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[0] = (x86_64_pageentry_t)l1_0 | PTE_P | PTE_W | PTE_U;
   404ba:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   404be:	48 83 c8 07          	or     $0x7,%rax
   404c2:	48 89 c2             	mov    %rax,%rdx
   404c5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   404c9:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[1] = (x86_64_pageentry_t)l1_1 | PTE_P | PTE_W | PTE_U;
   404cc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404d0:	48 83 c8 07          	or     $0x7,%rax
   404d4:	48 89 c2             	mov    %rax,%rdx
   404d7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   404db:	48 89 50 08          	mov    %rdx,0x8(%rax)

    for (uintptr_t i = 0; i < PROC_START_ADDR; i += PAGESIZE){
   404df:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   404e6:	00 
   404e7:	eb 66                	jmp    4054f <process_setup+0x14b>

        vamapping vam = virtual_memory_lookup(kernel_pagetable, i);
   404e9:	48 8b 0d 10 4b 01 00 	mov    0x14b10(%rip),%rcx        # 55000 <kernel_pagetable>
   404f0:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   404f4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   404f8:	48 89 ce             	mov    %rcx,%rsi
   404fb:	48 89 c7             	mov    %rax,%rdi
   404fe:	e8 85 2c 00 00       	call   43188 <virtual_memory_lookup>
        if (vam.pn != -1){
   40503:	8b 45 a0             	mov    -0x60(%rbp),%eax
   40506:	83 f8 ff             	cmp    $0xffffffff,%eax
   40509:	74 3c                	je     40547 <process_setup+0x143>
        int r = virtual_memory_map(l4, i, vam.pa, PAGESIZE, vam.perm);
   4050b:	8b 4d b0             	mov    -0x50(%rbp),%ecx
   4050e:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   40512:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40516:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4051a:	41 89 c8             	mov    %ecx,%r8d
   4051d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40522:	48 89 c7             	mov    %rax,%rdi
   40525:	e8 14 28 00 00       	call   42d3e <virtual_memory_map>
   4052a:	89 45 bc             	mov    %eax,-0x44(%rbp)
        if (r != 0){
   4052d:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   40531:	74 14                	je     40547 <process_setup+0x143>
            current->p_registers.reg_rax = -1;
   40533:	48 8b 05 c6 1a 01 00 	mov    0x11ac6(%rip),%rax        # 52000 <current>
   4053a:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40541:	ff 
   40542:	e9 a6 01 00 00       	jmp    406ed <process_setup+0x2e9>
    for (uintptr_t i = 0; i < PROC_START_ADDR; i += PAGESIZE){
   40547:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4054e:	00 
   4054f:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   40556:	00 
   40557:	76 90                	jbe    404e9 <process_setup+0xe5>
            return;
        }
        }
        
    }
    processes[pid].p_pagetable = l4;
   40559:	8b 45 9c             	mov    -0x64(%rbp),%eax
   4055c:	48 63 d0             	movslq %eax,%rdx
   4055f:	48 89 d0             	mov    %rdx,%rax
   40562:	48 c1 e0 03          	shl    $0x3,%rax
   40566:	48 29 d0             	sub    %rdx,%rax
   40569:	48 c1 e0 05          	shl    $0x5,%rax
   4056d:	48 89 c1             	mov    %rax,%rcx
   40570:	48 8d 15 79 1b 01 00 	lea    0x11b79(%rip),%rdx        # 520f0 <processes+0xd0>
   40577:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4057b:	48 89 04 11          	mov    %rax,(%rcx,%rdx,1)
    // FIXME
    virtual_memory_map(l4, 0, 0,
   4057f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40583:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40589:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4058e:	ba 00 00 00 00       	mov    $0x0,%edx
   40593:	be 00 00 00 00       	mov    $0x0,%esi
   40598:	48 89 c7             	mov    %rax,%rdi
   4059b:	e8 9e 27 00 00       	call   42d3e <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(l4, CONSOLE_ADDR, CONSOLE_ADDR,
   405a0:	48 8d 15 59 7a 07 00 	lea    0x77a59(%rip),%rdx        # b8000 <console>
   405a7:	48 8d 35 52 7a 07 00 	lea    0x77a52(%rip),%rsi        # b8000 <console>
   405ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   405b2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   405b8:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405bd:	48 89 c7             	mov    %rax,%rdi
   405c0:	e8 79 27 00 00       	call   42d3e <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    int r = program_load(&processes[pid], program_number, NULL);
   405c5:	8b 45 9c             	mov    -0x64(%rbp),%eax
   405c8:	48 63 d0             	movslq %eax,%rdx
   405cb:	48 89 d0             	mov    %rdx,%rax
   405ce:	48 c1 e0 03          	shl    $0x3,%rax
   405d2:	48 29 d0             	sub    %rdx,%rax
   405d5:	48 c1 e0 05          	shl    $0x5,%rax
   405d9:	48 8d 15 40 1a 01 00 	lea    0x11a40(%rip),%rdx        # 52020 <processes>
   405e0:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
   405e4:	8b 45 98             	mov    -0x68(%rbp),%eax
   405e7:	ba 00 00 00 00       	mov    $0x0,%edx
   405ec:	89 c6                	mov    %eax,%esi
   405ee:	48 89 cf             	mov    %rcx,%rdi
   405f1:	e8 8d 2c 00 00       	call   43283 <program_load>
   405f6:	89 45 cc             	mov    %eax,-0x34(%rbp)
    assert(r >= 0);
   405f9:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
   405fd:	79 1e                	jns    4061d <process_setup+0x219>
   405ff:	48 8d 05 73 40 00 00 	lea    0x4073(%rip),%rax        # 44679 <console_clear+0x75>
   40606:	48 89 c2             	mov    %rax,%rdx
   40609:	be b2 00 00 00       	mov    $0xb2,%esi
   4060e:	48 8d 05 6b 40 00 00 	lea    0x406b(%rip),%rax        # 44680 <console_clear+0x7c>
   40615:	48 89 c7             	mov    %rax,%rdi
   40618:	e8 9d 23 00 00       	call   429ba <assert_fail>

    processes[pid].p_registers.reg_rsp = PROC_START_ADDR + PROC_SIZE * pid;
   4061d:	8b 45 9c             	mov    -0x64(%rbp),%eax
   40620:	83 c0 04             	add    $0x4,%eax
   40623:	c1 e0 12             	shl    $0x12,%eax
   40626:	48 63 d0             	movslq %eax,%rdx
   40629:	8b 45 9c             	mov    -0x64(%rbp),%eax
   4062c:	48 63 c8             	movslq %eax,%rcx
   4062f:	48 89 c8             	mov    %rcx,%rax
   40632:	48 c1 e0 03          	shl    $0x3,%rax
   40636:	48 29 c8             	sub    %rcx,%rax
   40639:	48 c1 e0 05          	shl    $0x5,%rax
   4063d:	48 89 c1             	mov    %rax,%rcx
   40640:	48 8d 05 91 1a 01 00 	lea    0x11a91(%rip),%rax        # 520d8 <processes+0xb8>
   40647:	48 89 14 01          	mov    %rdx,(%rcx,%rax,1)
    uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
   4064b:	8b 45 9c             	mov    -0x64(%rbp),%eax
   4064e:	48 63 d0             	movslq %eax,%rdx
   40651:	48 89 d0             	mov    %rdx,%rax
   40654:	48 c1 e0 03          	shl    $0x3,%rax
   40658:	48 29 d0             	sub    %rdx,%rax
   4065b:	48 c1 e0 05          	shl    $0x5,%rax
   4065f:	48 89 c2             	mov    %rax,%rdx
   40662:	48 8d 05 6f 1a 01 00 	lea    0x11a6f(%rip),%rax        # 520d8 <processes+0xb8>
   40669:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4066d:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   40673:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    assign_physical_page(stack_page, pid);
   40677:	8b 45 9c             	mov    -0x64(%rbp),%eax
   4067a:	0f be d0             	movsbl %al,%edx
   4067d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40681:	89 d6                	mov    %edx,%esi
   40683:	48 89 c7             	mov    %rax,%rdi
   40686:	e8 64 00 00 00       	call   406ef <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page, stack_page,
   4068b:	8b 45 9c             	mov    -0x64(%rbp),%eax
   4068e:	48 63 d0             	movslq %eax,%rdx
   40691:	48 89 d0             	mov    %rdx,%rax
   40694:	48 c1 e0 03          	shl    $0x3,%rax
   40698:	48 29 d0             	sub    %rdx,%rax
   4069b:	48 c1 e0 05          	shl    $0x5,%rax
   4069f:	48 89 c2             	mov    %rax,%rdx
   406a2:	48 8d 05 47 1a 01 00 	lea    0x11a47(%rip),%rax        # 520f0 <processes+0xd0>
   406a9:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   406ad:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   406b1:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
   406b5:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   406bb:	b9 00 10 00 00       	mov    $0x1000,%ecx
   406c0:	48 89 c7             	mov    %rax,%rdi
   406c3:	e8 76 26 00 00       	call   42d3e <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   406c8:	8b 45 9c             	mov    -0x64(%rbp),%eax
   406cb:	48 63 d0             	movslq %eax,%rdx
   406ce:	48 89 d0             	mov    %rdx,%rax
   406d1:	48 c1 e0 03          	shl    $0x3,%rax
   406d5:	48 29 d0             	sub    %rdx,%rax
   406d8:	48 c1 e0 05          	shl    $0x5,%rax
   406dc:	48 89 c2             	mov    %rax,%rdx
   406df:	48 8d 05 02 1a 01 00 	lea    0x11a02(%rip),%rax        # 520e8 <processes+0xc8>
   406e6:	c7 04 02 01 00 00 00 	movl   $0x1,(%rdx,%rax,1)
}
   406ed:	c9                   	leave  
   406ee:	c3                   	ret    

00000000000406ef <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   406ef:	f3 0f 1e fa          	endbr64 
   406f3:	55                   	push   %rbp
   406f4:	48 89 e5             	mov    %rsp,%rbp
   406f7:	48 83 ec 10          	sub    $0x10,%rsp
   406fb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   406ff:	89 f0                	mov    %esi,%eax
   40701:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   40704:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40708:	25 ff 0f 00 00       	and    $0xfff,%eax
   4070d:	48 85 c0             	test   %rax,%rax
   40710:	75 27                	jne    40739 <assign_physical_page+0x4a>
        || addr >= MEMSIZE_PHYSICAL
   40712:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40719:	00 
   4071a:	77 1d                	ja     40739 <assign_physical_page+0x4a>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   4071c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40720:	48 c1 e8 0c          	shr    $0xc,%rax
   40724:	48 98                	cltq   
   40726:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4072a:	48 8d 05 10 27 01 00 	lea    0x12710(%rip),%rax        # 52e41 <pageinfo+0x1>
   40731:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40735:	84 c0                	test   %al,%al
   40737:	74 07                	je     40740 <assign_physical_page+0x51>
        return -1;
   40739:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4073e:	eb 3a                	jmp    4077a <assign_physical_page+0x8b>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   40740:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40744:	48 c1 e8 0c          	shr    $0xc,%rax
   40748:	48 98                	cltq   
   4074a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4074e:	48 8d 05 ec 26 01 00 	lea    0x126ec(%rip),%rax        # 52e41 <pageinfo+0x1>
   40755:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40759:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4075d:	48 c1 e8 0c          	shr    $0xc,%rax
   40761:	48 98                	cltq   
   40763:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40767:	48 8d 15 d2 26 01 00 	lea    0x126d2(%rip),%rdx        # 52e40 <pageinfo>
   4076e:	0f b6 45 f4          	movzbl -0xc(%rbp),%eax
   40772:	88 04 11             	mov    %al,(%rcx,%rdx,1)
        return 0;
   40775:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   4077a:	c9                   	leave  
   4077b:	c3                   	ret    

000000000004077c <syscall_mapping>:

void syscall_mapping(proc* p){
   4077c:	f3 0f 1e fa          	endbr64 
   40780:	55                   	push   %rbp
   40781:	48 89 e5             	mov    %rsp,%rbp
   40784:	48 83 ec 70          	sub    $0x70,%rsp
   40788:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   4078c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40790:	48 8b 40 38          	mov    0x38(%rax),%rax
   40794:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40798:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4079c:	48 8b 40 30          	mov    0x30(%rax),%rax
   407a0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   407a4:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407a8:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407af:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   407b3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407b7:	48 89 ce             	mov    %rcx,%rsi
   407ba:	48 89 c7             	mov    %rax,%rdi
   407bd:	e8 c6 29 00 00       	call   43188 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   407c2:	8b 45 e0             	mov    -0x20(%rbp),%eax
   407c5:	48 98                	cltq   
   407c7:	83 e0 06             	and    $0x6,%eax
   407ca:	48 83 f8 06          	cmp    $0x6,%rax
   407ce:	75 73                	jne    40843 <syscall_mapping+0xc7>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   407d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407d4:	48 83 c0 17          	add    $0x17,%rax
   407d8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   407dc:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407e0:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407e7:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   407eb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   407ef:	48 89 ce             	mov    %rcx,%rsi
   407f2:	48 89 c7             	mov    %rax,%rdi
   407f5:	e8 8e 29 00 00       	call   43188 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   407fa:	8b 45 c8             	mov    -0x38(%rbp),%eax
   407fd:	48 98                	cltq   
   407ff:	83 e0 03             	and    $0x3,%eax
   40802:	48 83 f8 03          	cmp    $0x3,%rax
   40806:	75 3e                	jne    40846 <syscall_mapping+0xca>
        return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40808:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4080c:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40813:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40817:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4081b:	48 89 ce             	mov    %rcx,%rsi
   4081e:	48 89 c7             	mov    %rax,%rdi
   40821:	e8 62 29 00 00       	call   43188 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40826:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4082a:	48 89 c1             	mov    %rax,%rcx
   4082d:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40831:	ba 18 00 00 00       	mov    $0x18,%edx
   40836:	48 89 c6             	mov    %rax,%rsi
   40839:	48 89 cf             	mov    %rcx,%rdi
   4083c:	e8 08 2d 00 00       	call   43549 <memcpy>
   40841:	eb 04                	jmp    40847 <syscall_mapping+0xcb>
        return;
   40843:	90                   	nop
   40844:	eb 01                	jmp    40847 <syscall_mapping+0xcb>
        return;
   40846:	90                   	nop
}
   40847:	c9                   	leave  
   40848:	c3                   	ret    

0000000000040849 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40849:	f3 0f 1e fa          	endbr64 
   4084d:	55                   	push   %rbp
   4084e:	48 89 e5             	mov    %rsp,%rbp
   40851:	48 83 ec 18          	sub    $0x18,%rsp
   40855:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40859:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4085d:	48 8b 40 38          	mov    0x38(%rax),%rax
   40861:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40864:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40868:	75 14                	jne    4087e <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   4086a:	0f b6 05 8f 57 00 00 	movzbl 0x578f(%rip),%eax        # 46000 <disp_global>
   40871:	84 c0                	test   %al,%al
   40873:	0f 94 c0             	sete   %al
   40876:	88 05 84 57 00 00    	mov    %al,0x5784(%rip)        # 46000 <disp_global>
   4087c:	eb 36                	jmp    408b4 <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   4087e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40882:	78 2f                	js     408b3 <syscall_mem_tog+0x6a>
   40884:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40888:	7f 29                	jg     408b3 <syscall_mem_tog+0x6a>
   4088a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4088e:	8b 00                	mov    (%rax),%eax
   40890:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40893:	75 1e                	jne    408b3 <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   40895:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40899:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   408a0:	84 c0                	test   %al,%al
   408a2:	0f 94 c0             	sete   %al
   408a5:	89 c2                	mov    %eax,%edx
   408a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408ab:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   408b1:	eb 01                	jmp    408b4 <syscall_mem_tog+0x6b>
            return;
   408b3:	90                   	nop
    }
}
   408b4:	c9                   	leave  
   408b5:	c3                   	ret    

00000000000408b6 <find_page>:
//    the kernel's stack, then jumping to kernel assembly code (in
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.
uintptr_t find_page(int8_t owner) {
   408b6:	f3 0f 1e fa          	endbr64 
   408ba:	55                   	push   %rbp
   408bb:	48 89 e5             	mov    %rsp,%rbp
   408be:	48 83 ec 18          	sub    $0x18,%rsp
   408c2:	89 f8                	mov    %edi,%eax
   408c4:	88 45 ec             	mov    %al,-0x14(%rbp)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   408c7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   408ce:	00 
   408cf:	eb 5c                	jmp    4092d <find_page+0x77>
        int pn = PAGENUMBER(addr);
   408d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   408d5:	48 c1 e8 0c          	shr    $0xc,%rax
   408d9:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (pageinfo[pn].refcount == 0) {
   408dc:	8b 45 f4             	mov    -0xc(%rbp),%eax
   408df:	48 98                	cltq   
   408e1:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   408e5:	48 8d 05 55 25 01 00 	lea    0x12555(%rip),%rax        # 52e41 <pageinfo+0x1>
   408ec:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   408f0:	84 c0                	test   %al,%al
   408f2:	75 31                	jne    40925 <find_page+0x6f>
            pageinfo[pn].owner = owner;
   408f4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   408f7:	48 98                	cltq   
   408f9:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   408fd:	48 8d 15 3c 25 01 00 	lea    0x1253c(%rip),%rdx        # 52e40 <pageinfo>
   40904:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
   40908:	88 04 11             	mov    %al,(%rcx,%rdx,1)
            pageinfo[pn].refcount = 1;
   4090b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4090e:	48 98                	cltq   
   40910:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40914:	48 8d 05 26 25 01 00 	lea    0x12526(%rip),%rax        # 52e41 <pageinfo+0x1>
   4091b:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
            return addr; 
   4091f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40923:	eb 17                	jmp    4093c <find_page+0x86>
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40925:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4092c:	00 
   4092d:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40934:	00 
   40935:	76 9a                	jbe    408d1 <find_page+0x1b>
        }
    }
    return 0; 
   40937:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4093c:	c9                   	leave  
   4093d:	c3                   	ret    

000000000004093e <exception>:

void exception(x86_64_registers* reg) {
   4093e:	f3 0f 1e fa          	endbr64 
   40942:	55                   	push   %rbp
   40943:	48 89 e5             	mov    %rsp,%rbp
   40946:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   4094d:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40954:	48 8b 05 a5 16 01 00 	mov    0x116a5(%rip),%rax        # 52000 <current>
   4095b:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   40962:	48 83 c0 08          	add    $0x8,%rax
   40966:	48 89 d6             	mov    %rdx,%rsi
   40969:	ba 18 00 00 00       	mov    $0x18,%edx
   4096e:	48 89 c7             	mov    %rax,%rdi
   40971:	48 89 d1             	mov    %rdx,%rcx
   40974:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40977:	48 8b 05 82 46 01 00 	mov    0x14682(%rip),%rax        # 55000 <kernel_pagetable>
   4097e:	48 89 c7             	mov    %rax,%rdi
   40981:	e8 46 22 00 00       	call   42bcc <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40986:	8b 05 70 86 07 00    	mov    0x78670(%rip),%eax        # b8ffc <cursorpos>
   4098c:	89 c7                	mov    %eax,%edi
   4098e:	e8 bf 18 00 00       	call   42252 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40993:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   4099a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   409a1:	48 83 f8 0e          	cmp    $0xe,%rax
   409a5:	74 14                	je     409bb <exception+0x7d>
   409a7:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   409ae:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   409b5:	48 83 f8 0d          	cmp    $0xd,%rax
   409b9:	75 16                	jne    409d1 <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   409bb:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   409c2:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   409c9:	83 e0 04             	and    $0x4,%eax
   409cc:	48 85 c0             	test   %rax,%rax
   409cf:	74 1a                	je     409eb <exception+0xad>
    {
        check_virtual_memory();
   409d1:	e8 c2 08 00 00       	call   41298 <check_virtual_memory>
        if(disp_global){
   409d6:	0f b6 05 23 56 00 00 	movzbl 0x5623(%rip),%eax        # 46000 <disp_global>
   409dd:	84 c0                	test   %al,%al
   409df:	74 0a                	je     409eb <exception+0xad>
            memshow_physical();
   409e1:	e8 7b 0a 00 00       	call   41461 <memshow_physical>
            memshow_virtual_animate();
   409e6:	e8 18 0e 00 00       	call   41803 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   409eb:	e8 78 1d 00 00       	call   42768 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   409f0:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   409f7:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   409fe:	48 83 e8 0e          	sub    $0xe,%rax
   40a02:	48 83 f8 2a          	cmp    $0x2a,%rax
   40a06:	0f 87 3f 03 00 00    	ja     40d4b <exception+0x40d>
   40a0c:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   40a13:	00 
   40a14:	48 8d 05 05 3d 00 00 	lea    0x3d05(%rip),%rax        # 44720 <console_clear+0x11c>
   40a1b:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40a1e:	48 98                	cltq   
   40a20:	48 8d 15 f9 3c 00 00 	lea    0x3cf9(%rip),%rdx        # 44720 <console_clear+0x11c>
   40a27:	48 01 d0             	add    %rdx,%rax
   40a2a:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40a2d:	48 8b 05 cc 15 01 00 	mov    0x115cc(%rip),%rax        # 52000 <current>
   40a34:	48 8b 40 38          	mov    0x38(%rax),%rax
   40a38:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
		if((void *)addr == NULL)
   40a3c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40a41:	75 0f                	jne    40a52 <exception+0x114>
		    panic(NULL);
   40a43:	bf 00 00 00 00       	mov    $0x0,%edi
   40a48:	b8 00 00 00 00       	mov    $0x0,%eax
   40a4d:	e8 78 1e 00 00       	call   428ca <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40a52:	48 8b 05 a7 15 01 00 	mov    0x115a7(%rip),%rax        # 52000 <current>
   40a59:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40a60:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   40a64:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40a68:	48 89 ce             	mov    %rcx,%rsi
   40a6b:	48 89 c7             	mov    %rax,%rdi
   40a6e:	e8 15 27 00 00       	call   43188 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40a73:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40a77:	48 89 c1             	mov    %rax,%rcx
   40a7a:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   40a81:	ba a0 00 00 00       	mov    $0xa0,%edx
   40a86:	48 89 ce             	mov    %rcx,%rsi
   40a89:	48 89 c7             	mov    %rax,%rdi
   40a8c:	e8 b8 2a 00 00       	call   43549 <memcpy>
		panic(msg);
   40a91:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   40a98:	48 89 c7             	mov    %rax,%rdi
   40a9b:	b8 00 00 00 00       	mov    $0x0,%eax
   40aa0:	e8 25 1e 00 00       	call   428ca <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40aa5:	48 8b 05 54 15 01 00 	mov    0x11554(%rip),%rax        # 52000 <current>
   40aac:	8b 10                	mov    (%rax),%edx
   40aae:	48 8b 05 4b 15 01 00 	mov    0x1154b(%rip),%rax        # 52000 <current>
   40ab5:	48 63 d2             	movslq %edx,%rdx
   40ab8:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40abc:	e9 9a 02 00 00       	jmp    40d5b <exception+0x41d>

    case INT_SYS_YIELD:
        schedule();
   40ac1:	e8 be 02 00 00       	call   40d84 <schedule>
        break;                  /* will not be reached */
   40ac6:	e9 90 02 00 00       	jmp    40d5b <exception+0x41d>

case INT_SYS_PAGE_ALLOC: {
    uintptr_t va = current->p_registers.reg_rdi;
   40acb:	48 8b 05 2e 15 01 00 	mov    0x1152e(%rip),%rax        # 52000 <current>
   40ad2:	48 8b 40 38          	mov    0x38(%rax),%rax
   40ad6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // check allignment and bounds
    if (va % PAGESIZE != 0) {
   40ada:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ade:	25 ff 0f 00 00       	and    $0xfff,%eax
   40ae3:	48 85 c0             	test   %rax,%rax
   40ae6:	74 14                	je     40afc <exception+0x1be>
        current->p_registers.reg_rax = -1; 
   40ae8:	48 8b 05 11 15 01 00 	mov    0x11511(%rip),%rax        # 52000 <current>
   40aef:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40af6:	ff 
        break;
   40af7:	e9 5f 02 00 00       	jmp    40d5b <exception+0x41d>
    }
    if (va >= MEMSIZE_VIRTUAL) {
   40afc:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40b03:	00 
   40b04:	76 14                	jbe    40b1a <exception+0x1dc>
        current->p_registers.reg_rax = -1; 
   40b06:	48 8b 05 f3 14 01 00 	mov    0x114f3(%rip),%rax        # 52000 <current>
   40b0d:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b14:	ff 
        break;
   40b15:	e9 41 02 00 00       	jmp    40d5b <exception+0x41d>
    }
    if (va < PROC_START_ADDR) {
   40b1a:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   40b21:	00 
   40b22:	77 14                	ja     40b38 <exception+0x1fa>
        current->p_registers.reg_rax = -1; 
   40b24:	48 8b 05 d5 14 01 00 	mov    0x114d5(%rip),%rax        # 52000 <current>
   40b2b:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b32:	ff 
        break;
   40b33:	e9 23 02 00 00       	jmp    40d5b <exception+0x41d>
    }   
    uintptr_t pa = find_page(current->p_pid);
   40b38:	48 8b 05 c1 14 01 00 	mov    0x114c1(%rip),%rax        # 52000 <current>
   40b3f:	8b 00                	mov    (%rax),%eax
   40b41:	0f be c0             	movsbl %al,%eax
   40b44:	89 c7                	mov    %eax,%edi
   40b46:	e8 6b fd ff ff       	call   408b6 <find_page>
   40b4b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (pa == 0) {
   40b4f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   40b54:	75 14                	jne    40b6a <exception+0x22c>
        current->p_registers.reg_rax = -1; 
   40b56:	48 8b 05 a3 14 01 00 	mov    0x114a3(%rip),%rax        # 52000 <current>
   40b5d:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b64:	ff 
        break;
   40b65:	e9 f1 01 00 00       	jmp    40d5b <exception+0x41d>
    }
    int perm = PTE_P | PTE_W | PTE_U;
   40b6a:	c7 45 ec 07 00 00 00 	movl   $0x7,-0x14(%rbp)

    int r = virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, perm);
   40b71:	48 8b 05 88 14 01 00 	mov    0x11488(%rip),%rax        # 52000 <current>
   40b78:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40b7f:	8b 4d ec             	mov    -0x14(%rbp),%ecx
   40b82:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40b86:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40b8a:	41 89 c8             	mov    %ecx,%r8d
   40b8d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40b92:	48 89 c7             	mov    %rax,%rdi
   40b95:	e8 a4 21 00 00       	call   42d3e <virtual_memory_map>
   40b9a:	89 45 e8             	mov    %eax,-0x18(%rbp)

    if (r != 0) {
   40b9d:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   40ba1:	74 46                	je     40be9 <exception+0x2ab>
        // If mapping fails, free the physical page
        pageinfo[PAGENUMBER(pa)].refcount = 0;
   40ba3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ba7:	48 c1 e8 0c          	shr    $0xc,%rax
   40bab:	48 98                	cltq   
   40bad:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40bb1:	48 8d 05 89 22 01 00 	lea    0x12289(%rip),%rax        # 52e41 <pageinfo+0x1>
   40bb8:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(pa)].owner = PO_FREE;
   40bbc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40bc0:	48 c1 e8 0c          	shr    $0xc,%rax
   40bc4:	48 98                	cltq   
   40bc6:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40bca:	48 8d 05 6f 22 01 00 	lea    0x1226f(%rip),%rax        # 52e40 <pageinfo>
   40bd1:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        current->p_registers.reg_rax = -1;
   40bd5:	48 8b 05 24 14 01 00 	mov    0x11424(%rip),%rax        # 52000 <current>
   40bdc:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40be3:	ff 
        break;
   40be4:	e9 72 01 00 00       	jmp    40d5b <exception+0x41d>
    }

    // Success: Return 0
    current->p_registers.reg_rax = 0;
   40be9:	48 8b 05 10 14 01 00 	mov    0x11410(%rip),%rax        # 52000 <current>
   40bf0:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40bf7:	00 
    break;
   40bf8:	e9 5e 01 00 00       	jmp    40d5b <exception+0x41d>
}


    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40bfd:	48 8b 05 fc 13 01 00 	mov    0x113fc(%rip),%rax        # 52000 <current>
   40c04:	48 89 c7             	mov    %rax,%rdi
   40c07:	e8 70 fb ff ff       	call   4077c <syscall_mapping>
            break;
   40c0c:	e9 4a 01 00 00       	jmp    40d5b <exception+0x41d>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40c11:	48 8b 05 e8 13 01 00 	mov    0x113e8(%rip),%rax        # 52000 <current>
   40c18:	48 89 c7             	mov    %rax,%rdi
   40c1b:	e8 29 fc ff ff       	call   40849 <syscall_mem_tog>
	    break;
   40c20:	e9 36 01 00 00       	jmp    40d5b <exception+0x41d>
	}

    case INT_TIMER:
        ++ticks;
   40c25:	8b 05 f5 21 01 00    	mov    0x121f5(%rip),%eax        # 52e20 <ticks>
   40c2b:	83 c0 01             	add    $0x1,%eax
   40c2e:	89 05 ec 21 01 00    	mov    %eax,0x121ec(%rip)        # 52e20 <ticks>
        schedule();
   40c34:	e8 4b 01 00 00       	call   40d84 <schedule>
        break;                  /* will not be reached */
   40c39:	e9 1d 01 00 00       	jmp    40d5b <exception+0x41d>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40c3e:	0f 20 d0             	mov    %cr2,%rax
   40c41:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    return val;
   40c45:	48 8b 45 c0          	mov    -0x40(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40c49:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40c4d:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40c54:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40c5b:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40c5e:	48 85 c0             	test   %rax,%rax
   40c61:	74 09                	je     40c6c <exception+0x32e>
   40c63:	48 8d 05 26 3a 00 00 	lea    0x3a26(%rip),%rax        # 44690 <console_clear+0x8c>
   40c6a:	eb 07                	jmp    40c73 <exception+0x335>
   40c6c:	48 8d 05 23 3a 00 00 	lea    0x3a23(%rip),%rax        # 44696 <console_clear+0x92>
        const char* operation = reg->reg_err & PFERR_WRITE
   40c73:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40c77:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40c7e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40c85:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40c88:	48 85 c0             	test   %rax,%rax
   40c8b:	74 09                	je     40c96 <exception+0x358>
   40c8d:	48 8d 05 07 3a 00 00 	lea    0x3a07(%rip),%rax        # 4469b <console_clear+0x97>
   40c94:	eb 07                	jmp    40c9d <exception+0x35f>
   40c96:	48 8d 05 11 3a 00 00 	lea    0x3a11(%rip),%rax        # 446ae <console_clear+0xaa>
        const char* problem = reg->reg_err & PFERR_PRESENT
   40c9d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40ca1:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40ca8:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40caf:	83 e0 04             	and    $0x4,%eax
   40cb2:	48 85 c0             	test   %rax,%rax
   40cb5:	75 34                	jne    40ceb <exception+0x3ad>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40cb7:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40cbe:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40cc5:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40cc9:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40ccd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40cd1:	49 89 f0             	mov    %rsi,%r8
   40cd4:	48 89 c6             	mov    %rax,%rsi
   40cd7:	48 8d 05 e2 39 00 00 	lea    0x39e2(%rip),%rax        # 446c0 <console_clear+0xbc>
   40cde:	48 89 c7             	mov    %rax,%rdi
   40ce1:	b8 00 00 00 00       	mov    $0x0,%eax
   40ce6:	e8 df 1b 00 00       	call   428ca <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40ceb:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40cf2:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40cf9:	48 8b 05 00 13 01 00 	mov    0x11300(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40d00:	8b 00                	mov    (%rax),%eax
   40d02:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40d06:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   40d0a:	52                   	push   %rdx
   40d0b:	ff 75 c8             	push   -0x38(%rbp)
   40d0e:	49 89 f1             	mov    %rsi,%r9
   40d11:	49 89 c8             	mov    %rcx,%r8
   40d14:	89 c1                	mov    %eax,%ecx
   40d16:	48 8d 05 d3 39 00 00 	lea    0x39d3(%rip),%rax        # 446f0 <console_clear+0xec>
   40d1d:	48 89 c2             	mov    %rax,%rdx
   40d20:	be 00 0c 00 00       	mov    $0xc00,%esi
   40d25:	bf 80 07 00 00       	mov    $0x780,%edi
   40d2a:	b8 00 00 00 00       	mov    $0x0,%eax
   40d2f:	e8 5a 37 00 00       	call   4448e <console_printf>
   40d34:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40d38:	48 8b 05 c1 12 01 00 	mov    0x112c1(%rip),%rax        # 52000 <current>
   40d3f:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40d46:	00 00 00 
        break;
   40d49:	eb 10                	jmp    40d5b <exception+0x41d>
    }

    default:
        default_exception(current);
   40d4b:	48 8b 05 ae 12 01 00 	mov    0x112ae(%rip),%rax        # 52000 <current>
   40d52:	48 89 c7             	mov    %rax,%rdi
   40d55:	e8 99 1c 00 00       	call   429f3 <default_exception>
        break;                  /* will not be reached */
   40d5a:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40d5b:	48 8b 05 9e 12 01 00 	mov    0x1129e(%rip),%rax        # 52000 <current>
   40d62:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40d68:	83 f8 01             	cmp    $0x1,%eax
   40d6b:	75 0f                	jne    40d7c <exception+0x43e>
        run(current);
   40d6d:	48 8b 05 8c 12 01 00 	mov    0x1128c(%rip),%rax        # 52000 <current>
   40d74:	48 89 c7             	mov    %rax,%rdi
   40d77:	e8 87 00 00 00       	call   40e03 <run>
    } else {
        schedule();
   40d7c:	e8 03 00 00 00       	call   40d84 <schedule>
    }
}
   40d81:	90                   	nop
   40d82:	c9                   	leave  
   40d83:	c3                   	ret    

0000000000040d84 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40d84:	f3 0f 1e fa          	endbr64 
   40d88:	55                   	push   %rbp
   40d89:	48 89 e5             	mov    %rsp,%rbp
   40d8c:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40d90:	48 8b 05 69 12 01 00 	mov    0x11269(%rip),%rax        # 52000 <current>
   40d97:	8b 00                	mov    (%rax),%eax
   40d99:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40d9c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d9f:	83 c0 01             	add    $0x1,%eax
   40da2:	99                   	cltd   
   40da3:	c1 ea 1c             	shr    $0x1c,%edx
   40da6:	01 d0                	add    %edx,%eax
   40da8:	83 e0 0f             	and    $0xf,%eax
   40dab:	29 d0                	sub    %edx,%eax
   40dad:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40db0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40db3:	48 63 d0             	movslq %eax,%rdx
   40db6:	48 89 d0             	mov    %rdx,%rax
   40db9:	48 c1 e0 03          	shl    $0x3,%rax
   40dbd:	48 29 d0             	sub    %rdx,%rax
   40dc0:	48 c1 e0 05          	shl    $0x5,%rax
   40dc4:	48 89 c2             	mov    %rax,%rdx
   40dc7:	48 8d 05 1a 13 01 00 	lea    0x1131a(%rip),%rax        # 520e8 <processes+0xc8>
   40dce:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40dd1:	83 f8 01             	cmp    $0x1,%eax
   40dd4:	75 26                	jne    40dfc <schedule+0x78>
            run(&processes[pid]);
   40dd6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40dd9:	48 63 d0             	movslq %eax,%rdx
   40ddc:	48 89 d0             	mov    %rdx,%rax
   40ddf:	48 c1 e0 03          	shl    $0x3,%rax
   40de3:	48 29 d0             	sub    %rdx,%rax
   40de6:	48 c1 e0 05          	shl    $0x5,%rax
   40dea:	48 8d 15 2f 12 01 00 	lea    0x1122f(%rip),%rdx        # 52020 <processes>
   40df1:	48 01 d0             	add    %rdx,%rax
   40df4:	48 89 c7             	mov    %rax,%rdi
   40df7:	e8 07 00 00 00       	call   40e03 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40dfc:	e8 67 19 00 00       	call   42768 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40e01:	eb 99                	jmp    40d9c <schedule+0x18>

0000000000040e03 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40e03:	f3 0f 1e fa          	endbr64 
   40e07:	55                   	push   %rbp
   40e08:	48 89 e5             	mov    %rsp,%rbp
   40e0b:	48 83 ec 10          	sub    $0x10,%rsp
   40e0f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40e13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e17:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40e1d:	83 f8 01             	cmp    $0x1,%eax
   40e20:	74 1e                	je     40e40 <run+0x3d>
   40e22:	48 8d 05 a3 39 00 00 	lea    0x39a3(%rip),%rax        # 447cc <console_clear+0x1c8>
   40e29:	48 89 c2             	mov    %rax,%rdx
   40e2c:	be ad 01 00 00       	mov    $0x1ad,%esi
   40e31:	48 8d 05 48 38 00 00 	lea    0x3848(%rip),%rax        # 44680 <console_clear+0x7c>
   40e38:	48 89 c7             	mov    %rax,%rdi
   40e3b:	e8 7a 1b 00 00       	call   429ba <assert_fail>
    current = p;
   40e40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e44:	48 89 05 b5 11 01 00 	mov    %rax,0x111b5(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40e4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e4f:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40e56:	48 89 c7             	mov    %rax,%rdi
   40e59:	e8 6e 1d 00 00       	call   42bcc <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40e5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e62:	48 83 c0 08          	add    $0x8,%rax
   40e66:	48 89 c7             	mov    %rax,%rdi
   40e69:	e8 55 f2 ff ff       	call   400c3 <exception_return>

0000000000040e6e <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40e6e:	f3 0f 1e fa          	endbr64 
   40e72:	55                   	push   %rbp
   40e73:	48 89 e5             	mov    %rsp,%rbp
   40e76:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e7a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40e81:	00 
   40e82:	e9 93 00 00 00       	jmp    40f1a <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40e87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e8b:	48 89 c7             	mov    %rax,%rdi
   40e8e:	e8 0f 11 00 00       	call   41fa2 <physical_memory_isreserved>
   40e93:	85 c0                	test   %eax,%eax
   40e95:	74 09                	je     40ea0 <pageinfo_init+0x32>
            owner = PO_RESERVED;
   40e97:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40e9e:	eb 31                	jmp    40ed1 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40ea0:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40ea7:	00 
   40ea8:	76 0d                	jbe    40eb7 <pageinfo_init+0x49>
   40eaa:	48 8d 05 57 a1 01 00 	lea    0x1a157(%rip),%rax        # 5b008 <end>
   40eb1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40eb5:	72 0a                	jb     40ec1 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40eb7:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40ebe:	00 
   40ebf:	75 09                	jne    40eca <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   40ec1:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40ec8:	eb 07                	jmp    40ed1 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   40eca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40ed1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ed5:	48 c1 e8 0c          	shr    $0xc,%rax
   40ed9:	89 c2                	mov    %eax,%edx
   40edb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ede:	89 c1                	mov    %eax,%ecx
   40ee0:	48 63 c2             	movslq %edx,%rax
   40ee3:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40ee7:	48 8d 05 52 1f 01 00 	lea    0x11f52(%rip),%rax        # 52e40 <pageinfo>
   40eee:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40ef1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40ef5:	0f 95 c2             	setne  %dl
   40ef8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40efc:	48 c1 e8 0c          	shr    $0xc,%rax
   40f00:	89 d1                	mov    %edx,%ecx
   40f02:	48 98                	cltq   
   40f04:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40f08:	48 8d 05 32 1f 01 00 	lea    0x11f32(%rip),%rax        # 52e41 <pageinfo+0x1>
   40f0f:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40f12:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40f19:	00 
   40f1a:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40f21:	00 
   40f22:	0f 86 5f ff ff ff    	jbe    40e87 <pageinfo_init+0x19>
    }
}
   40f28:	90                   	nop
   40f29:	90                   	nop
   40f2a:	c9                   	leave  
   40f2b:	c3                   	ret    

0000000000040f2c <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40f2c:	f3 0f 1e fa          	endbr64 
   40f30:	55                   	push   %rbp
   40f31:	48 89 e5             	mov    %rsp,%rbp
   40f34:	48 83 ec 50          	sub    $0x50,%rsp
   40f38:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40f3c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40f40:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40f46:	48 89 c2             	mov    %rax,%rdx
   40f49:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40f4d:	48 39 c2             	cmp    %rax,%rdx
   40f50:	74 1e                	je     40f70 <check_page_table_mappings+0x44>
   40f52:	48 8d 05 8f 38 00 00 	lea    0x388f(%rip),%rax        # 447e8 <console_clear+0x1e4>
   40f59:	48 89 c2             	mov    %rax,%rdx
   40f5c:	be d7 01 00 00       	mov    $0x1d7,%esi
   40f61:	48 8d 05 18 37 00 00 	lea    0x3718(%rip),%rax        # 44680 <console_clear+0x7c>
   40f68:	48 89 c7             	mov    %rax,%rdi
   40f6b:	e8 4a 1a 00 00       	call   429ba <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40f70:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40f77:	00 
   40f78:	e9 b5 00 00 00       	jmp    41032 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40f7d:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40f81:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40f85:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f89:	48 89 ce             	mov    %rcx,%rsi
   40f8c:	48 89 c7             	mov    %rax,%rdi
   40f8f:	e8 f4 21 00 00       	call   43188 <virtual_memory_lookup>
        if (vam.pa != va) {
   40f94:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f98:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f9c:	74 2c                	je     40fca <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40f9e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40fa2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40fa6:	49 89 d0             	mov    %rdx,%r8
   40fa9:	48 89 c1             	mov    %rax,%rcx
   40fac:	48 8d 05 54 38 00 00 	lea    0x3854(%rip),%rax        # 44807 <console_clear+0x203>
   40fb3:	48 89 c2             	mov    %rax,%rdx
   40fb6:	be 00 c0 00 00       	mov    $0xc000,%esi
   40fbb:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40fc0:	b8 00 00 00 00       	mov    $0x0,%eax
   40fc5:	e8 c4 34 00 00       	call   4448e <console_printf>
        }
        assert(vam.pa == va);
   40fca:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40fce:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40fd2:	74 1e                	je     40ff2 <check_page_table_mappings+0xc6>
   40fd4:	48 8d 05 36 38 00 00 	lea    0x3836(%rip),%rax        # 44811 <console_clear+0x20d>
   40fdb:	48 89 c2             	mov    %rax,%rdx
   40fde:	be e0 01 00 00       	mov    $0x1e0,%esi
   40fe3:	48 8d 05 96 36 00 00 	lea    0x3696(%rip),%rax        # 44680 <console_clear+0x7c>
   40fea:	48 89 c7             	mov    %rax,%rdi
   40fed:	e8 c8 19 00 00       	call   429ba <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40ff2:	48 8d 05 07 50 00 00 	lea    0x5007(%rip),%rax        # 46000 <disp_global>
   40ff9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ffd:	72 2b                	jb     4102a <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   40fff:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41002:	48 98                	cltq   
   41004:	83 e0 02             	and    $0x2,%eax
   41007:	48 85 c0             	test   %rax,%rax
   4100a:	75 1e                	jne    4102a <check_page_table_mappings+0xfe>
   4100c:	48 8d 05 0b 38 00 00 	lea    0x380b(%rip),%rax        # 4481e <console_clear+0x21a>
   41013:	48 89 c2             	mov    %rax,%rdx
   41016:	be e2 01 00 00       	mov    $0x1e2,%esi
   4101b:	48 8d 05 5e 36 00 00 	lea    0x365e(%rip),%rax        # 44680 <console_clear+0x7c>
   41022:	48 89 c7             	mov    %rax,%rdi
   41025:	e8 90 19 00 00       	call   429ba <assert_fail>
         va += PAGESIZE) {
   4102a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41031:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41032:	48 8d 05 cf 9f 01 00 	lea    0x19fcf(%rip),%rax        # 5b008 <end>
   41039:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4103d:	0f 82 3a ff ff ff    	jb     40f7d <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41043:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   4104a:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   4104b:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   4104f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41053:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41057:	48 89 ce             	mov    %rcx,%rsi
   4105a:	48 89 c7             	mov    %rax,%rdi
   4105d:	e8 26 21 00 00       	call   43188 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   41062:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41066:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4106a:	74 1e                	je     4108a <check_page_table_mappings+0x15e>
   4106c:	48 8d 05 bc 37 00 00 	lea    0x37bc(%rip),%rax        # 4482f <console_clear+0x22b>
   41073:	48 89 c2             	mov    %rax,%rdx
   41076:	be e9 01 00 00       	mov    $0x1e9,%esi
   4107b:	48 8d 05 fe 35 00 00 	lea    0x35fe(%rip),%rax        # 44680 <console_clear+0x7c>
   41082:	48 89 c7             	mov    %rax,%rdi
   41085:	e8 30 19 00 00       	call   429ba <assert_fail>
    assert(vam.perm & PTE_W);
   4108a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4108d:	48 98                	cltq   
   4108f:	83 e0 02             	and    $0x2,%eax
   41092:	48 85 c0             	test   %rax,%rax
   41095:	75 1e                	jne    410b5 <check_page_table_mappings+0x189>
   41097:	48 8d 05 80 37 00 00 	lea    0x3780(%rip),%rax        # 4481e <console_clear+0x21a>
   4109e:	48 89 c2             	mov    %rax,%rdx
   410a1:	be ea 01 00 00       	mov    $0x1ea,%esi
   410a6:	48 8d 05 d3 35 00 00 	lea    0x35d3(%rip),%rax        # 44680 <console_clear+0x7c>
   410ad:	48 89 c7             	mov    %rax,%rdi
   410b0:	e8 05 19 00 00       	call   429ba <assert_fail>
}
   410b5:	90                   	nop
   410b6:	c9                   	leave  
   410b7:	c3                   	ret    

00000000000410b8 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   410b8:	f3 0f 1e fa          	endbr64 
   410bc:	55                   	push   %rbp
   410bd:	48 89 e5             	mov    %rsp,%rbp
   410c0:	48 83 ec 20          	sub    $0x20,%rsp
   410c4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   410c8:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   410cb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   410ce:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   410d1:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   410d8:	48 8b 05 21 3f 01 00 	mov    0x13f21(%rip),%rax        # 55000 <kernel_pagetable>
   410df:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   410e3:	75 71                	jne    41156 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   410e5:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   410ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   410f3:	eb 5b                	jmp    41150 <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   410f5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   410f8:	48 63 d0             	movslq %eax,%rdx
   410fb:	48 89 d0             	mov    %rdx,%rax
   410fe:	48 c1 e0 03          	shl    $0x3,%rax
   41102:	48 29 d0             	sub    %rdx,%rax
   41105:	48 c1 e0 05          	shl    $0x5,%rax
   41109:	48 89 c2             	mov    %rax,%rdx
   4110c:	48 8d 05 d5 0f 01 00 	lea    0x10fd5(%rip),%rax        # 520e8 <processes+0xc8>
   41113:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41116:	85 c0                	test   %eax,%eax
   41118:	74 32                	je     4114c <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   4111a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4111d:	48 63 d0             	movslq %eax,%rdx
   41120:	48 89 d0             	mov    %rdx,%rax
   41123:	48 c1 e0 03          	shl    $0x3,%rax
   41127:	48 29 d0             	sub    %rdx,%rax
   4112a:	48 c1 e0 05          	shl    $0x5,%rax
   4112e:	48 89 c2             	mov    %rax,%rdx
   41131:	48 8d 05 b8 0f 01 00 	lea    0x10fb8(%rip),%rax        # 520f0 <processes+0xd0>
   41138:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   4113c:	48 8b 05 bd 3e 01 00 	mov    0x13ebd(%rip),%rax        # 55000 <kernel_pagetable>
   41143:	48 39 c2             	cmp    %rax,%rdx
   41146:	75 04                	jne    4114c <check_page_table_ownership+0x94>
                ++expected_refcount;
   41148:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4114c:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41150:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41154:	7e 9f                	jle    410f5 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41156:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41159:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4115c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41160:	be 00 00 00 00       	mov    $0x0,%esi
   41165:	48 89 c7             	mov    %rax,%rdi
   41168:	e8 03 00 00 00       	call   41170 <check_page_table_ownership_level>
}
   4116d:	90                   	nop
   4116e:	c9                   	leave  
   4116f:	c3                   	ret    

0000000000041170 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   41170:	f3 0f 1e fa          	endbr64 
   41174:	55                   	push   %rbp
   41175:	48 89 e5             	mov    %rsp,%rbp
   41178:	48 83 ec 30          	sub    $0x30,%rsp
   4117c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41180:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41183:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41186:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41189:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4118d:	48 c1 e8 0c          	shr    $0xc,%rax
   41191:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41196:	7e 1e                	jle    411b6 <check_page_table_ownership_level+0x46>
   41198:	48 8d 05 a1 36 00 00 	lea    0x36a1(%rip),%rax        # 44840 <console_clear+0x23c>
   4119f:	48 89 c2             	mov    %rax,%rdx
   411a2:	be 07 02 00 00       	mov    $0x207,%esi
   411a7:	48 8d 05 d2 34 00 00 	lea    0x34d2(%rip),%rax        # 44680 <console_clear+0x7c>
   411ae:	48 89 c7             	mov    %rax,%rdi
   411b1:	e8 04 18 00 00       	call   429ba <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   411b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   411ba:	48 c1 e8 0c          	shr    $0xc,%rax
   411be:	48 98                	cltq   
   411c0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   411c4:	48 8d 05 75 1c 01 00 	lea    0x11c75(%rip),%rax        # 52e40 <pageinfo>
   411cb:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   411cf:	0f be c0             	movsbl %al,%eax
   411d2:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   411d5:	74 1e                	je     411f5 <check_page_table_ownership_level+0x85>
   411d7:	48 8d 05 7a 36 00 00 	lea    0x367a(%rip),%rax        # 44858 <console_clear+0x254>
   411de:	48 89 c2             	mov    %rax,%rdx
   411e1:	be 08 02 00 00       	mov    $0x208,%esi
   411e6:	48 8d 05 93 34 00 00 	lea    0x3493(%rip),%rax        # 44680 <console_clear+0x7c>
   411ed:	48 89 c7             	mov    %rax,%rdi
   411f0:	e8 c5 17 00 00       	call   429ba <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   411f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   411f9:	48 c1 e8 0c          	shr    $0xc,%rax
   411fd:	48 98                	cltq   
   411ff:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41203:	48 8d 05 37 1c 01 00 	lea    0x11c37(%rip),%rax        # 52e41 <pageinfo+0x1>
   4120a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4120e:	0f be c0             	movsbl %al,%eax
   41211:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41214:	74 1e                	je     41234 <check_page_table_ownership_level+0xc4>
   41216:	48 8d 05 63 36 00 00 	lea    0x3663(%rip),%rax        # 44880 <console_clear+0x27c>
   4121d:	48 89 c2             	mov    %rax,%rdx
   41220:	be 09 02 00 00       	mov    $0x209,%esi
   41225:	48 8d 05 54 34 00 00 	lea    0x3454(%rip),%rax        # 44680 <console_clear+0x7c>
   4122c:	48 89 c7             	mov    %rax,%rdi
   4122f:	e8 86 17 00 00       	call   429ba <assert_fail>
    if (level < 3) {
   41234:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41238:	7f 5b                	jg     41295 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4123a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41241:	eb 49                	jmp    4128c <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   41243:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41247:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4124a:	48 63 d2             	movslq %edx,%rdx
   4124d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41251:	48 85 c0             	test   %rax,%rax
   41254:	74 32                	je     41288 <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41256:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4125a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4125d:	48 63 d2             	movslq %edx,%rdx
   41260:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41264:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4126a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4126e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41271:	8d 70 01             	lea    0x1(%rax),%esi
   41274:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41277:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4127b:	b9 01 00 00 00       	mov    $0x1,%ecx
   41280:	48 89 c7             	mov    %rax,%rdi
   41283:	e8 e8 fe ff ff       	call   41170 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41288:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4128c:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41293:	7e ae                	jle    41243 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   41295:	90                   	nop
   41296:	c9                   	leave  
   41297:	c3                   	ret    

0000000000041298 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41298:	f3 0f 1e fa          	endbr64 
   4129c:	55                   	push   %rbp
   4129d:	48 89 e5             	mov    %rsp,%rbp
   412a0:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   412a4:	8b 05 3e 0e 01 00    	mov    0x10e3e(%rip),%eax        # 520e8 <processes+0xc8>
   412aa:	85 c0                	test   %eax,%eax
   412ac:	74 1e                	je     412cc <check_virtual_memory+0x34>
   412ae:	48 8d 05 fb 35 00 00 	lea    0x35fb(%rip),%rax        # 448b0 <console_clear+0x2ac>
   412b5:	48 89 c2             	mov    %rax,%rdx
   412b8:	be 1c 02 00 00       	mov    $0x21c,%esi
   412bd:	48 8d 05 bc 33 00 00 	lea    0x33bc(%rip),%rax        # 44680 <console_clear+0x7c>
   412c4:	48 89 c7             	mov    %rax,%rdi
   412c7:	e8 ee 16 00 00       	call   429ba <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   412cc:	48 8b 05 2d 3d 01 00 	mov    0x13d2d(%rip),%rax        # 55000 <kernel_pagetable>
   412d3:	48 89 c7             	mov    %rax,%rdi
   412d6:	e8 51 fc ff ff       	call   40f2c <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   412db:	48 8b 05 1e 3d 01 00 	mov    0x13d1e(%rip),%rax        # 55000 <kernel_pagetable>
   412e2:	be ff ff ff ff       	mov    $0xffffffff,%esi
   412e7:	48 89 c7             	mov    %rax,%rdi
   412ea:	e8 c9 fd ff ff       	call   410b8 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   412ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   412f6:	e9 b4 00 00 00       	jmp    413af <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   412fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412fe:	48 63 d0             	movslq %eax,%rdx
   41301:	48 89 d0             	mov    %rdx,%rax
   41304:	48 c1 e0 03          	shl    $0x3,%rax
   41308:	48 29 d0             	sub    %rdx,%rax
   4130b:	48 c1 e0 05          	shl    $0x5,%rax
   4130f:	48 89 c2             	mov    %rax,%rdx
   41312:	48 8d 05 cf 0d 01 00 	lea    0x10dcf(%rip),%rax        # 520e8 <processes+0xc8>
   41319:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4131c:	85 c0                	test   %eax,%eax
   4131e:	0f 84 87 00 00 00    	je     413ab <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41324:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41327:	48 63 d0             	movslq %eax,%rdx
   4132a:	48 89 d0             	mov    %rdx,%rax
   4132d:	48 c1 e0 03          	shl    $0x3,%rax
   41331:	48 29 d0             	sub    %rdx,%rax
   41334:	48 c1 e0 05          	shl    $0x5,%rax
   41338:	48 89 c2             	mov    %rax,%rdx
   4133b:	48 8d 05 ae 0d 01 00 	lea    0x10dae(%rip),%rax        # 520f0 <processes+0xd0>
   41342:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   41346:	48 8b 05 b3 3c 01 00 	mov    0x13cb3(%rip),%rax        # 55000 <kernel_pagetable>
   4134d:	48 39 c2             	cmp    %rax,%rdx
   41350:	74 59                	je     413ab <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   41352:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41355:	48 63 d0             	movslq %eax,%rdx
   41358:	48 89 d0             	mov    %rdx,%rax
   4135b:	48 c1 e0 03          	shl    $0x3,%rax
   4135f:	48 29 d0             	sub    %rdx,%rax
   41362:	48 c1 e0 05          	shl    $0x5,%rax
   41366:	48 89 c2             	mov    %rax,%rdx
   41369:	48 8d 05 80 0d 01 00 	lea    0x10d80(%rip),%rax        # 520f0 <processes+0xd0>
   41370:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41374:	48 89 c7             	mov    %rax,%rdi
   41377:	e8 b0 fb ff ff       	call   40f2c <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4137c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4137f:	48 63 d0             	movslq %eax,%rdx
   41382:	48 89 d0             	mov    %rdx,%rax
   41385:	48 c1 e0 03          	shl    $0x3,%rax
   41389:	48 29 d0             	sub    %rdx,%rax
   4138c:	48 c1 e0 05          	shl    $0x5,%rax
   41390:	48 89 c2             	mov    %rax,%rdx
   41393:	48 8d 05 56 0d 01 00 	lea    0x10d56(%rip),%rax        # 520f0 <processes+0xd0>
   4139a:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4139e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   413a1:	89 d6                	mov    %edx,%esi
   413a3:	48 89 c7             	mov    %rax,%rdi
   413a6:	e8 0d fd ff ff       	call   410b8 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   413ab:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   413af:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   413b3:	0f 8e 42 ff ff ff    	jle    412fb <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413b9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   413c0:	e9 8b 00 00 00       	jmp    41450 <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   413c5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   413c8:	48 98                	cltq   
   413ca:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   413ce:	48 8d 05 6c 1a 01 00 	lea    0x11a6c(%rip),%rax        # 52e41 <pageinfo+0x1>
   413d5:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   413d9:	84 c0                	test   %al,%al
   413db:	7e 6f                	jle    4144c <check_virtual_memory+0x1b4>
   413dd:	8b 45 f8             	mov    -0x8(%rbp),%eax
   413e0:	48 98                	cltq   
   413e2:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   413e6:	48 8d 05 53 1a 01 00 	lea    0x11a53(%rip),%rax        # 52e40 <pageinfo>
   413ed:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   413f1:	84 c0                	test   %al,%al
   413f3:	78 57                	js     4144c <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   413f5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   413f8:	48 98                	cltq   
   413fa:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   413fe:	48 8d 05 3b 1a 01 00 	lea    0x11a3b(%rip),%rax        # 52e40 <pageinfo>
   41405:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41409:	0f be c0             	movsbl %al,%eax
   4140c:	48 63 d0             	movslq %eax,%rdx
   4140f:	48 89 d0             	mov    %rdx,%rax
   41412:	48 c1 e0 03          	shl    $0x3,%rax
   41416:	48 29 d0             	sub    %rdx,%rax
   41419:	48 c1 e0 05          	shl    $0x5,%rax
   4141d:	48 89 c2             	mov    %rax,%rdx
   41420:	48 8d 05 c1 0c 01 00 	lea    0x10cc1(%rip),%rax        # 520e8 <processes+0xc8>
   41427:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4142a:	85 c0                	test   %eax,%eax
   4142c:	75 1e                	jne    4144c <check_virtual_memory+0x1b4>
   4142e:	48 8d 05 9b 34 00 00 	lea    0x349b(%rip),%rax        # 448d0 <console_clear+0x2cc>
   41435:	48 89 c2             	mov    %rax,%rdx
   41438:	be 33 02 00 00       	mov    $0x233,%esi
   4143d:	48 8d 05 3c 32 00 00 	lea    0x323c(%rip),%rax        # 44680 <console_clear+0x7c>
   41444:	48 89 c7             	mov    %rax,%rdi
   41447:	e8 6e 15 00 00       	call   429ba <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4144c:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41450:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41457:	0f 8e 68 ff ff ff    	jle    413c5 <check_virtual_memory+0x12d>
        }
    }
}
   4145d:	90                   	nop
   4145e:	90                   	nop
   4145f:	c9                   	leave  
   41460:	c3                   	ret    

0000000000041461 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41461:	f3 0f 1e fa          	endbr64 
   41465:	55                   	push   %rbp
   41466:	48 89 e5             	mov    %rsp,%rbp
   41469:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4146d:	48 8d 05 b2 34 00 00 	lea    0x34b2(%rip),%rax        # 44926 <memstate_colors+0x26>
   41474:	48 89 c2             	mov    %rax,%rdx
   41477:	be 00 0f 00 00       	mov    $0xf00,%esi
   4147c:	bf 20 00 00 00       	mov    $0x20,%edi
   41481:	b8 00 00 00 00       	mov    $0x0,%eax
   41486:	e8 03 30 00 00       	call   4448e <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4148b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41492:	e9 1b 01 00 00       	jmp    415b2 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   41497:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4149a:	83 e0 3f             	and    $0x3f,%eax
   4149d:	85 c0                	test   %eax,%eax
   4149f:	75 40                	jne    414e1 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   414a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414a4:	c1 e0 0c             	shl    $0xc,%eax
   414a7:	89 c2                	mov    %eax,%edx
   414a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414ac:	8d 48 3f             	lea    0x3f(%rax),%ecx
   414af:	85 c0                	test   %eax,%eax
   414b1:	0f 48 c1             	cmovs  %ecx,%eax
   414b4:	c1 f8 06             	sar    $0x6,%eax
   414b7:	8d 48 01             	lea    0x1(%rax),%ecx
   414ba:	89 c8                	mov    %ecx,%eax
   414bc:	c1 e0 02             	shl    $0x2,%eax
   414bf:	01 c8                	add    %ecx,%eax
   414c1:	c1 e0 04             	shl    $0x4,%eax
   414c4:	83 c0 03             	add    $0x3,%eax
   414c7:	89 d1                	mov    %edx,%ecx
   414c9:	48 8d 15 66 34 00 00 	lea    0x3466(%rip),%rdx        # 44936 <memstate_colors+0x36>
   414d0:	be 00 0f 00 00       	mov    $0xf00,%esi
   414d5:	89 c7                	mov    %eax,%edi
   414d7:	b8 00 00 00 00       	mov    $0x0,%eax
   414dc:	e8 ad 2f 00 00       	call   4448e <console_printf>
        }

        int owner = pageinfo[pn].owner;
   414e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414e4:	48 98                	cltq   
   414e6:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   414ea:	48 8d 05 4f 19 01 00 	lea    0x1194f(%rip),%rax        # 52e40 <pageinfo>
   414f1:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   414f5:	0f be c0             	movsbl %al,%eax
   414f8:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   414fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414fe:	48 98                	cltq   
   41500:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41504:	48 8d 05 36 19 01 00 	lea    0x11936(%rip),%rax        # 52e41 <pageinfo+0x1>
   4150b:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4150f:	84 c0                	test   %al,%al
   41511:	75 07                	jne    4151a <memshow_physical+0xb9>
            owner = PO_FREE;
   41513:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4151a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4151d:	83 c0 02             	add    $0x2,%eax
   41520:	48 98                	cltq   
   41522:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41526:	48 8d 05 d3 33 00 00 	lea    0x33d3(%rip),%rax        # 44900 <memstate_colors>
   4152d:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41531:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41535:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41538:	48 98                	cltq   
   4153a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4153e:	48 8d 05 fc 18 01 00 	lea    0x118fc(%rip),%rax        # 52e41 <pageinfo+0x1>
   41545:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41549:	3c 01                	cmp    $0x1,%al
   4154b:	7e 1c                	jle    41569 <memshow_physical+0x108>
   4154d:	48 8d 05 ac 6a 07 00 	lea    0x76aac(%rip),%rax        # b8000 <console>
   41554:	48 c1 e8 0c          	shr    $0xc,%rax
   41558:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4155b:	74 0c                	je     41569 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4155d:	b8 53 00 00 00       	mov    $0x53,%eax
   41562:	80 cc 0f             	or     $0xf,%ah
   41565:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41569:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4156c:	8d 50 3f             	lea    0x3f(%rax),%edx
   4156f:	85 c0                	test   %eax,%eax
   41571:	0f 48 c2             	cmovs  %edx,%eax
   41574:	c1 f8 06             	sar    $0x6,%eax
   41577:	8d 50 01             	lea    0x1(%rax),%edx
   4157a:	89 d0                	mov    %edx,%eax
   4157c:	c1 e0 02             	shl    $0x2,%eax
   4157f:	01 d0                	add    %edx,%eax
   41581:	c1 e0 04             	shl    $0x4,%eax
   41584:	89 c1                	mov    %eax,%ecx
   41586:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41589:	99                   	cltd   
   4158a:	c1 ea 1a             	shr    $0x1a,%edx
   4158d:	01 d0                	add    %edx,%eax
   4158f:	83 e0 3f             	and    $0x3f,%eax
   41592:	29 d0                	sub    %edx,%eax
   41594:	83 c0 0c             	add    $0xc,%eax
   41597:	01 c8                	add    %ecx,%eax
   41599:	48 98                	cltq   
   4159b:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4159f:	48 8d 15 5a 6a 07 00 	lea    0x76a5a(%rip),%rdx        # b8000 <console>
   415a6:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   415aa:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   415ae:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   415b2:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   415b9:	0f 8e d8 fe ff ff    	jle    41497 <memshow_physical+0x36>
    }
}
   415bf:	90                   	nop
   415c0:	90                   	nop
   415c1:	c9                   	leave  
   415c2:	c3                   	ret    

00000000000415c3 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   415c3:	f3 0f 1e fa          	endbr64 
   415c7:	55                   	push   %rbp
   415c8:	48 89 e5             	mov    %rsp,%rbp
   415cb:	48 83 ec 40          	sub    $0x40,%rsp
   415cf:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   415d3:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   415d7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   415db:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   415e1:	48 89 c2             	mov    %rax,%rdx
   415e4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   415e8:	48 39 c2             	cmp    %rax,%rdx
   415eb:	74 1e                	je     4160b <memshow_virtual+0x48>
   415ed:	48 8d 05 4c 33 00 00 	lea    0x334c(%rip),%rax        # 44940 <memstate_colors+0x40>
   415f4:	48 89 c2             	mov    %rax,%rdx
   415f7:	be 64 02 00 00       	mov    $0x264,%esi
   415fc:	48 8d 05 7d 30 00 00 	lea    0x307d(%rip),%rax        # 44680 <console_clear+0x7c>
   41603:	48 89 c7             	mov    %rax,%rdi
   41606:	e8 af 13 00 00       	call   429ba <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   4160b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4160f:	48 89 c1             	mov    %rax,%rcx
   41612:	48 8d 05 54 33 00 00 	lea    0x3354(%rip),%rax        # 4496d <memstate_colors+0x6d>
   41619:	48 89 c2             	mov    %rax,%rdx
   4161c:	be 00 0f 00 00       	mov    $0xf00,%esi
   41621:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41626:	b8 00 00 00 00       	mov    $0x0,%eax
   4162b:	e8 5e 2e 00 00       	call   4448e <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41630:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41637:	00 
   41638:	e9 b4 01 00 00       	jmp    417f1 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4163d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41641:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41645:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41649:	48 89 ce             	mov    %rcx,%rsi
   4164c:	48 89 c7             	mov    %rax,%rdi
   4164f:	e8 34 1b 00 00       	call   43188 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41654:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41657:	85 c0                	test   %eax,%eax
   41659:	79 0b                	jns    41666 <memshow_virtual+0xa3>
            color = ' ';
   4165b:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41661:	e9 ff 00 00 00       	jmp    41765 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41666:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4166a:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41670:	76 1e                	jbe    41690 <memshow_virtual+0xcd>
   41672:	48 8d 05 11 33 00 00 	lea    0x3311(%rip),%rax        # 4498a <memstate_colors+0x8a>
   41679:	48 89 c2             	mov    %rax,%rdx
   4167c:	be 6d 02 00 00       	mov    $0x26d,%esi
   41681:	48 8d 05 f8 2f 00 00 	lea    0x2ff8(%rip),%rax        # 44680 <console_clear+0x7c>
   41688:	48 89 c7             	mov    %rax,%rdi
   4168b:	e8 2a 13 00 00       	call   429ba <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41690:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41693:	48 98                	cltq   
   41695:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41699:	48 8d 05 a0 17 01 00 	lea    0x117a0(%rip),%rax        # 52e40 <pageinfo>
   416a0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   416a4:	0f be c0             	movsbl %al,%eax
   416a7:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   416aa:	8b 45 d0             	mov    -0x30(%rbp),%eax
   416ad:	48 98                	cltq   
   416af:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   416b3:	48 8d 05 87 17 01 00 	lea    0x11787(%rip),%rax        # 52e41 <pageinfo+0x1>
   416ba:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   416be:	84 c0                	test   %al,%al
   416c0:	75 07                	jne    416c9 <memshow_virtual+0x106>
                owner = PO_FREE;
   416c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   416c9:	8b 45 f0             	mov    -0x10(%rbp),%eax
   416cc:	83 c0 02             	add    $0x2,%eax
   416cf:	48 98                	cltq   
   416d1:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   416d5:	48 8d 05 24 32 00 00 	lea    0x3224(%rip),%rax        # 44900 <memstate_colors>
   416dc:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   416e0:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   416e4:	8b 45 e0             	mov    -0x20(%rbp),%eax
   416e7:	48 98                	cltq   
   416e9:	83 e0 04             	and    $0x4,%eax
   416ec:	48 85 c0             	test   %rax,%rax
   416ef:	74 27                	je     41718 <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   416f1:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   416f5:	c1 e0 04             	shl    $0x4,%eax
   416f8:	66 25 00 f0          	and    $0xf000,%ax
   416fc:	89 c2                	mov    %eax,%edx
   416fe:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41702:	c1 f8 04             	sar    $0x4,%eax
   41705:	66 25 00 0f          	and    $0xf00,%ax
   41709:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   4170b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4170f:	0f b6 c0             	movzbl %al,%eax
   41712:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41714:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41718:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4171b:	48 98                	cltq   
   4171d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41721:	48 8d 05 19 17 01 00 	lea    0x11719(%rip),%rax        # 52e41 <pageinfo+0x1>
   41728:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4172c:	3c 01                	cmp    $0x1,%al
   4172e:	7e 35                	jle    41765 <memshow_virtual+0x1a2>
   41730:	48 8d 05 c9 68 07 00 	lea    0x768c9(%rip),%rax        # b8000 <console>
   41737:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4173b:	74 28                	je     41765 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   4173d:	b8 53 00 00 00       	mov    $0x53,%eax
   41742:	89 c2                	mov    %eax,%edx
   41744:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41748:	66 25 00 f0          	and    $0xf000,%ax
   4174c:	09 d0                	or     %edx,%eax
   4174e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41752:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41755:	48 98                	cltq   
   41757:	83 e0 04             	and    $0x4,%eax
   4175a:	48 85 c0             	test   %rax,%rax
   4175d:	75 06                	jne    41765 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   4175f:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41765:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41769:	48 c1 e8 0c          	shr    $0xc,%rax
   4176d:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41770:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41773:	83 e0 3f             	and    $0x3f,%eax
   41776:	85 c0                	test   %eax,%eax
   41778:	75 39                	jne    417b3 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   4177a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4177d:	c1 e8 06             	shr    $0x6,%eax
   41780:	89 c2                	mov    %eax,%edx
   41782:	89 d0                	mov    %edx,%eax
   41784:	c1 e0 02             	shl    $0x2,%eax
   41787:	01 d0                	add    %edx,%eax
   41789:	c1 e0 04             	shl    $0x4,%eax
   4178c:	05 73 03 00 00       	add    $0x373,%eax
   41791:	89 c7                	mov    %eax,%edi
   41793:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41797:	48 89 c1             	mov    %rax,%rcx
   4179a:	48 8d 05 95 31 00 00 	lea    0x3195(%rip),%rax        # 44936 <memstate_colors+0x36>
   417a1:	48 89 c2             	mov    %rax,%rdx
   417a4:	be 00 0f 00 00       	mov    $0xf00,%esi
   417a9:	b8 00 00 00 00       	mov    $0x0,%eax
   417ae:	e8 db 2c 00 00       	call   4448e <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   417b3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   417b6:	c1 e8 06             	shr    $0x6,%eax
   417b9:	89 c2                	mov    %eax,%edx
   417bb:	89 d0                	mov    %edx,%eax
   417bd:	c1 e0 02             	shl    $0x2,%eax
   417c0:	01 d0                	add    %edx,%eax
   417c2:	c1 e0 04             	shl    $0x4,%eax
   417c5:	89 c2                	mov    %eax,%edx
   417c7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   417ca:	83 e0 3f             	and    $0x3f,%eax
   417cd:	01 d0                	add    %edx,%eax
   417cf:	05 7c 03 00 00       	add    $0x37c,%eax
   417d4:	89 c0                	mov    %eax,%eax
   417d6:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   417da:	48 8d 15 1f 68 07 00 	lea    0x7681f(%rip),%rdx        # b8000 <console>
   417e1:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   417e5:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   417e9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   417f0:	00 
   417f1:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   417f8:	00 
   417f9:	0f 86 3e fe ff ff    	jbe    4163d <memshow_virtual+0x7a>
    }
}
   417ff:	90                   	nop
   41800:	90                   	nop
   41801:	c9                   	leave  
   41802:	c3                   	ret    

0000000000041803 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41803:	f3 0f 1e fa          	endbr64 
   41807:	55                   	push   %rbp
   41808:	48 89 e5             	mov    %rsp,%rbp
   4180b:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   4180f:	8b 05 2b 1a 01 00    	mov    0x11a2b(%rip),%eax        # 53240 <last_ticks.1>
   41815:	85 c0                	test   %eax,%eax
   41817:	74 13                	je     4182c <memshow_virtual_animate+0x29>
   41819:	8b 05 01 16 01 00    	mov    0x11601(%rip),%eax        # 52e20 <ticks>
   4181f:	8b 15 1b 1a 01 00    	mov    0x11a1b(%rip),%edx        # 53240 <last_ticks.1>
   41825:	29 d0                	sub    %edx,%eax
   41827:	83 f8 31             	cmp    $0x31,%eax
   4182a:	76 2c                	jbe    41858 <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   4182c:	8b 05 ee 15 01 00    	mov    0x115ee(%rip),%eax        # 52e20 <ticks>
   41832:	89 05 08 1a 01 00    	mov    %eax,0x11a08(%rip)        # 53240 <last_ticks.1>
        ++showing;
   41838:	8b 05 c6 47 00 00    	mov    0x47c6(%rip),%eax        # 46004 <showing.0>
   4183e:	83 c0 01             	add    $0x1,%eax
   41841:	89 05 bd 47 00 00    	mov    %eax,0x47bd(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41847:	eb 0f                	jmp    41858 <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41849:	8b 05 b5 47 00 00    	mov    0x47b5(%rip),%eax        # 46004 <showing.0>
   4184f:	83 c0 01             	add    $0x1,%eax
   41852:	89 05 ac 47 00 00    	mov    %eax,0x47ac(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41858:	8b 05 a6 47 00 00    	mov    0x47a6(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   4185e:	83 f8 20             	cmp    $0x20,%eax
   41861:	7f 6b                	jg     418ce <memshow_virtual_animate+0xcb>
   41863:	8b 05 9b 47 00 00    	mov    0x479b(%rip),%eax        # 46004 <showing.0>
   41869:	99                   	cltd   
   4186a:	c1 ea 1c             	shr    $0x1c,%edx
   4186d:	01 d0                	add    %edx,%eax
   4186f:	83 e0 0f             	and    $0xf,%eax
   41872:	29 d0                	sub    %edx,%eax
   41874:	48 63 d0             	movslq %eax,%rdx
   41877:	48 89 d0             	mov    %rdx,%rax
   4187a:	48 c1 e0 03          	shl    $0x3,%rax
   4187e:	48 29 d0             	sub    %rdx,%rax
   41881:	48 c1 e0 05          	shl    $0x5,%rax
   41885:	48 89 c2             	mov    %rax,%rdx
   41888:	48 8d 05 59 08 01 00 	lea    0x10859(%rip),%rax        # 520e8 <processes+0xc8>
   4188f:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41892:	85 c0                	test   %eax,%eax
   41894:	74 b3                	je     41849 <memshow_virtual_animate+0x46>
   41896:	8b 05 68 47 00 00    	mov    0x4768(%rip),%eax        # 46004 <showing.0>
   4189c:	99                   	cltd   
   4189d:	c1 ea 1c             	shr    $0x1c,%edx
   418a0:	01 d0                	add    %edx,%eax
   418a2:	83 e0 0f             	and    $0xf,%eax
   418a5:	29 d0                	sub    %edx,%eax
   418a7:	48 63 d0             	movslq %eax,%rdx
   418aa:	48 89 d0             	mov    %rdx,%rax
   418ad:	48 c1 e0 03          	shl    $0x3,%rax
   418b1:	48 29 d0             	sub    %rdx,%rax
   418b4:	48 c1 e0 05          	shl    $0x5,%rax
   418b8:	48 89 c2             	mov    %rax,%rdx
   418bb:	48 8d 05 36 08 01 00 	lea    0x10836(%rip),%rax        # 520f8 <processes+0xd8>
   418c2:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   418c6:	84 c0                	test   %al,%al
   418c8:	0f 84 7b ff ff ff    	je     41849 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   418ce:	8b 05 30 47 00 00    	mov    0x4730(%rip),%eax        # 46004 <showing.0>
   418d4:	99                   	cltd   
   418d5:	c1 ea 1c             	shr    $0x1c,%edx
   418d8:	01 d0                	add    %edx,%eax
   418da:	83 e0 0f             	and    $0xf,%eax
   418dd:	29 d0                	sub    %edx,%eax
   418df:	89 05 1f 47 00 00    	mov    %eax,0x471f(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   418e5:	8b 05 19 47 00 00    	mov    0x4719(%rip),%eax        # 46004 <showing.0>
   418eb:	48 63 d0             	movslq %eax,%rdx
   418ee:	48 89 d0             	mov    %rdx,%rax
   418f1:	48 c1 e0 03          	shl    $0x3,%rax
   418f5:	48 29 d0             	sub    %rdx,%rax
   418f8:	48 c1 e0 05          	shl    $0x5,%rax
   418fc:	48 89 c2             	mov    %rax,%rdx
   418ff:	48 8d 05 e2 07 01 00 	lea    0x107e2(%rip),%rax        # 520e8 <processes+0xc8>
   41906:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41909:	85 c0                	test   %eax,%eax
   4190b:	74 59                	je     41966 <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   4190d:	8b 15 f1 46 00 00    	mov    0x46f1(%rip),%edx        # 46004 <showing.0>
   41913:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41917:	89 d1                	mov    %edx,%ecx
   41919:	48 8d 15 84 30 00 00 	lea    0x3084(%rip),%rdx        # 449a4 <memstate_colors+0xa4>
   41920:	be 04 00 00 00       	mov    $0x4,%esi
   41925:	48 89 c7             	mov    %rax,%rdi
   41928:	b8 00 00 00 00       	mov    $0x0,%eax
   4192d:	e8 77 2c 00 00       	call   445a9 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41932:	8b 05 cc 46 00 00    	mov    0x46cc(%rip),%eax        # 46004 <showing.0>
   41938:	48 63 d0             	movslq %eax,%rdx
   4193b:	48 89 d0             	mov    %rdx,%rax
   4193e:	48 c1 e0 03          	shl    $0x3,%rax
   41942:	48 29 d0             	sub    %rdx,%rax
   41945:	48 c1 e0 05          	shl    $0x5,%rax
   41949:	48 89 c2             	mov    %rax,%rdx
   4194c:	48 8d 05 9d 07 01 00 	lea    0x1079d(%rip),%rax        # 520f0 <processes+0xd0>
   41953:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41957:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4195b:	48 89 d6             	mov    %rdx,%rsi
   4195e:	48 89 c7             	mov    %rax,%rdi
   41961:	e8 5d fc ff ff       	call   415c3 <memshow_virtual>
    }
}
   41966:	90                   	nop
   41967:	c9                   	leave  
   41968:	c3                   	ret    

0000000000041969 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41969:	f3 0f 1e fa          	endbr64 
   4196d:	55                   	push   %rbp
   4196e:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41971:	e8 5f 01 00 00       	call   41ad5 <segments_init>
    interrupt_init();
   41976:	e8 44 04 00 00       	call   41dbf <interrupt_init>
    virtual_memory_init();
   4197b:	e8 11 11 00 00       	call   42a91 <virtual_memory_init>
}
   41980:	90                   	nop
   41981:	5d                   	pop    %rbp
   41982:	c3                   	ret    

0000000000041983 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41983:	f3 0f 1e fa          	endbr64 
   41987:	55                   	push   %rbp
   41988:	48 89 e5             	mov    %rsp,%rbp
   4198b:	48 83 ec 18          	sub    $0x18,%rsp
   4198f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41993:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41997:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   4199a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4199d:	48 98                	cltq   
   4199f:	48 c1 e0 2d          	shl    $0x2d,%rax
   419a3:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   419a7:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   419ae:	90 00 00 
   419b1:	48 09 c2             	or     %rax,%rdx
    *segment = type
   419b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419b8:	48 89 10             	mov    %rdx,(%rax)
}
   419bb:	90                   	nop
   419bc:	c9                   	leave  
   419bd:	c3                   	ret    

00000000000419be <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   419be:	f3 0f 1e fa          	endbr64 
   419c2:	55                   	push   %rbp
   419c3:	48 89 e5             	mov    %rsp,%rbp
   419c6:	48 83 ec 28          	sub    $0x28,%rsp
   419ca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   419ce:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   419d2:	89 55 ec             	mov    %edx,-0x14(%rbp)
   419d5:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   419d9:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   419dd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419e1:	48 c1 e0 10          	shl    $0x10,%rax
   419e5:	48 89 c2             	mov    %rax,%rdx
   419e8:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   419ef:	00 00 00 
   419f2:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   419f5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419f9:	48 c1 e0 20          	shl    $0x20,%rax
   419fd:	48 89 c1             	mov    %rax,%rcx
   41a00:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41a07:	00 00 ff 
   41a0a:	48 21 c8             	and    %rcx,%rax
   41a0d:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41a10:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41a14:	48 83 e8 01          	sub    $0x1,%rax
   41a18:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41a1b:	48 09 d0             	or     %rdx,%rax
        | type
   41a1e:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41a22:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41a25:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a28:	48 98                	cltq   
   41a2a:	48 c1 e0 2d          	shl    $0x2d,%rax
   41a2e:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41a31:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41a38:	80 00 00 
   41a3b:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41a3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a42:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41a45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a49:	48 83 c0 08          	add    $0x8,%rax
   41a4d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41a51:	48 c1 ea 20          	shr    $0x20,%rdx
   41a55:	48 89 10             	mov    %rdx,(%rax)
}
   41a58:	90                   	nop
   41a59:	c9                   	leave  
   41a5a:	c3                   	ret    

0000000000041a5b <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41a5b:	f3 0f 1e fa          	endbr64 
   41a5f:	55                   	push   %rbp
   41a60:	48 89 e5             	mov    %rsp,%rbp
   41a63:	48 83 ec 20          	sub    $0x20,%rsp
   41a67:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41a6b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41a6f:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41a72:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41a76:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41a7a:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41a7d:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41a81:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41a84:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a87:	48 98                	cltq   
   41a89:	48 c1 e0 2d          	shl    $0x2d,%rax
   41a8d:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41a90:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41a94:	48 c1 e0 20          	shl    $0x20,%rax
   41a98:	48 89 c1             	mov    %rax,%rcx
   41a9b:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41aa2:	00 ff ff 
   41aa5:	48 21 c8             	and    %rcx,%rax
   41aa8:	48 09 c2             	or     %rax,%rdx
   41aab:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41ab2:	80 00 00 
   41ab5:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41ab8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41abc:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41abf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41ac3:	48 c1 e8 20          	shr    $0x20,%rax
   41ac7:	48 89 c2             	mov    %rax,%rdx
   41aca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ace:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41ad2:	90                   	nop
   41ad3:	c9                   	leave  
   41ad4:	c3                   	ret    

0000000000041ad5 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41ad5:	f3 0f 1e fa          	endbr64 
   41ad9:	55                   	push   %rbp
   41ada:	48 89 e5             	mov    %rsp,%rbp
   41add:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41ae1:	48 c7 05 74 17 01 00 	movq   $0x0,0x11774(%rip)        # 53260 <segments>
   41ae8:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41aec:	ba 00 00 00 00       	mov    $0x0,%edx
   41af1:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41af8:	08 20 00 
   41afb:	48 89 c6             	mov    %rax,%rsi
   41afe:	48 8d 05 63 17 01 00 	lea    0x11763(%rip),%rax        # 53268 <segments+0x8>
   41b05:	48 89 c7             	mov    %rax,%rdi
   41b08:	e8 76 fe ff ff       	call   41983 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41b0d:	ba 03 00 00 00       	mov    $0x3,%edx
   41b12:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41b19:	08 20 00 
   41b1c:	48 89 c6             	mov    %rax,%rsi
   41b1f:	48 8d 05 4a 17 01 00 	lea    0x1174a(%rip),%rax        # 53270 <segments+0x10>
   41b26:	48 89 c7             	mov    %rax,%rdi
   41b29:	e8 55 fe ff ff       	call   41983 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41b2e:	ba 00 00 00 00       	mov    $0x0,%edx
   41b33:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41b3a:	02 00 00 
   41b3d:	48 89 c6             	mov    %rax,%rsi
   41b40:	48 8d 05 31 17 01 00 	lea    0x11731(%rip),%rax        # 53278 <segments+0x18>
   41b47:	48 89 c7             	mov    %rax,%rdi
   41b4a:	e8 34 fe ff ff       	call   41983 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41b4f:	ba 03 00 00 00       	mov    $0x3,%edx
   41b54:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41b5b:	02 00 00 
   41b5e:	48 89 c6             	mov    %rax,%rsi
   41b61:	48 8d 05 18 17 01 00 	lea    0x11718(%rip),%rax        # 53280 <segments+0x20>
   41b68:	48 89 c7             	mov    %rax,%rdi
   41b6b:	e8 13 fe ff ff       	call   41983 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41b70:	48 8d 05 29 27 01 00 	lea    0x12729(%rip),%rax        # 542a0 <kernel_task_descriptor>
   41b77:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41b7d:	48 89 c1             	mov    %rax,%rcx
   41b80:	ba 00 00 00 00       	mov    $0x0,%edx
   41b85:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41b8c:	09 00 00 
   41b8f:	48 89 c6             	mov    %rax,%rsi
   41b92:	48 8d 05 ef 16 01 00 	lea    0x116ef(%rip),%rax        # 53288 <segments+0x28>
   41b99:	48 89 c7             	mov    %rax,%rdi
   41b9c:	e8 1d fe ff ff       	call   419be <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41ba1:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41ba7:	48 8d 05 b2 16 01 00 	lea    0x116b2(%rip),%rax        # 53260 <segments>
   41bae:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41bb2:	ba 60 00 00 00       	mov    $0x60,%edx
   41bb7:	be 00 00 00 00       	mov    $0x0,%esi
   41bbc:	48 8d 05 dd 26 01 00 	lea    0x126dd(%rip),%rax        # 542a0 <kernel_task_descriptor>
   41bc3:	48 89 c7             	mov    %rax,%rdi
   41bc6:	e8 84 1a 00 00       	call   4364f <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41bcb:	48 c7 05 ce 26 01 00 	movq   $0x80000,0x126ce(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41bd2:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41bd6:	ba 00 10 00 00       	mov    $0x1000,%edx
   41bdb:	be 00 00 00 00       	mov    $0x0,%esi
   41be0:	48 8d 05 b9 16 01 00 	lea    0x116b9(%rip),%rax        # 532a0 <interrupt_descriptors>
   41be7:	48 89 c7             	mov    %rax,%rdi
   41bea:	e8 60 1a 00 00       	call   4364f <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41bef:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41bf6:	eb 3c                	jmp    41c34 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41bf8:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   41bff:	48 89 c2             	mov    %rax,%rdx
   41c02:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c05:	48 c1 e0 04          	shl    $0x4,%rax
   41c09:	48 89 c1             	mov    %rax,%rcx
   41c0c:	48 8d 05 8d 16 01 00 	lea    0x1168d(%rip),%rax        # 532a0 <interrupt_descriptors>
   41c13:	48 01 c8             	add    %rcx,%rax
   41c16:	48 89 d1             	mov    %rdx,%rcx
   41c19:	ba 00 00 00 00       	mov    $0x0,%edx
   41c1e:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41c25:	0e 00 00 
   41c28:	48 89 c7             	mov    %rax,%rdi
   41c2b:	e8 2b fe ff ff       	call   41a5b <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41c30:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41c34:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41c3b:	76 bb                	jbe    41bf8 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41c3d:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   41c44:	48 89 c1             	mov    %rax,%rcx
   41c47:	ba 00 00 00 00       	mov    $0x0,%edx
   41c4c:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41c53:	0e 00 00 
   41c56:	48 89 c6             	mov    %rax,%rsi
   41c59:	48 8d 05 40 18 01 00 	lea    0x11840(%rip),%rax        # 534a0 <interrupt_descriptors+0x200>
   41c60:	48 89 c7             	mov    %rax,%rdi
   41c63:	e8 f3 fd ff ff       	call   41a5b <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41c68:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   41c6f:	48 89 c1             	mov    %rax,%rcx
   41c72:	ba 00 00 00 00       	mov    $0x0,%edx
   41c77:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41c7e:	0e 00 00 
   41c81:	48 89 c6             	mov    %rax,%rsi
   41c84:	48 8d 05 e5 16 01 00 	lea    0x116e5(%rip),%rax        # 53370 <interrupt_descriptors+0xd0>
   41c8b:	48 89 c7             	mov    %rax,%rdi
   41c8e:	e8 c8 fd ff ff       	call   41a5b <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41c93:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   41c9a:	48 89 c1             	mov    %rax,%rcx
   41c9d:	ba 00 00 00 00       	mov    $0x0,%edx
   41ca2:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ca9:	0e 00 00 
   41cac:	48 89 c6             	mov    %rax,%rsi
   41caf:	48 8d 05 ca 16 01 00 	lea    0x116ca(%rip),%rax        # 53380 <interrupt_descriptors+0xe0>
   41cb6:	48 89 c7             	mov    %rax,%rdi
   41cb9:	e8 9d fd ff ff       	call   41a5b <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41cbe:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41cc5:	eb 50                	jmp    41d17 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41cc7:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41cca:	83 e8 30             	sub    $0x30,%eax
   41ccd:	89 c0                	mov    %eax,%eax
   41ccf:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   41cd6:	00 
   41cd7:	48 8d 05 09 e4 ff ff 	lea    -0x1bf7(%rip),%rax        # 400e7 <sys_int_handlers>
   41cde:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41ce2:	48 89 c2             	mov    %rax,%rdx
   41ce5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ce8:	48 c1 e0 04          	shl    $0x4,%rax
   41cec:	48 89 c1             	mov    %rax,%rcx
   41cef:	48 8d 05 aa 15 01 00 	lea    0x115aa(%rip),%rax        # 532a0 <interrupt_descriptors>
   41cf6:	48 01 c8             	add    %rcx,%rax
   41cf9:	48 89 d1             	mov    %rdx,%rcx
   41cfc:	ba 03 00 00 00       	mov    $0x3,%edx
   41d01:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41d08:	0e 00 00 
   41d0b:	48 89 c7             	mov    %rax,%rdi
   41d0e:	e8 48 fd ff ff       	call   41a5b <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41d13:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41d17:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41d1b:	76 aa                	jbe    41cc7 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41d1d:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41d23:	48 8d 05 76 15 01 00 	lea    0x11576(%rip),%rax        # 532a0 <interrupt_descriptors>
   41d2a:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41d2e:	b8 28 00 00 00       	mov    $0x28,%eax
   41d33:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41d37:	0f 00 d8             	ltr    %ax
   41d3a:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41d3e:	0f 20 c0             	mov    %cr0,%rax
   41d41:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41d45:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41d49:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41d4c:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41d53:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d56:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41d59:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d5c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41d60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41d64:	0f 22 c0             	mov    %rax,%cr0
}
   41d67:	90                   	nop
    lcr0(cr0);
}
   41d68:	90                   	nop
   41d69:	c9                   	leave  
   41d6a:	c3                   	ret    

0000000000041d6b <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41d6b:	f3 0f 1e fa          	endbr64 
   41d6f:	55                   	push   %rbp
   41d70:	48 89 e5             	mov    %rsp,%rbp
   41d73:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41d77:	0f b7 05 82 25 01 00 	movzwl 0x12582(%rip),%eax        # 54300 <interrupts_enabled>
   41d7e:	f7 d0                	not    %eax
   41d80:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41d84:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41d88:	0f b6 c0             	movzbl %al,%eax
   41d8b:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41d92:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d95:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41d99:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41d9c:	ee                   	out    %al,(%dx)
}
   41d9d:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41d9e:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41da2:	66 c1 e8 08          	shr    $0x8,%ax
   41da6:	0f b6 c0             	movzbl %al,%eax
   41da9:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41db0:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41db3:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41db7:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41dba:	ee                   	out    %al,(%dx)
}
   41dbb:	90                   	nop
}
   41dbc:	90                   	nop
   41dbd:	c9                   	leave  
   41dbe:	c3                   	ret    

0000000000041dbf <interrupt_init>:

void interrupt_init(void) {
   41dbf:	f3 0f 1e fa          	endbr64 
   41dc3:	55                   	push   %rbp
   41dc4:	48 89 e5             	mov    %rsp,%rbp
   41dc7:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41dcb:	66 c7 05 2c 25 01 00 	movw   $0x0,0x1252c(%rip)        # 54300 <interrupts_enabled>
   41dd2:	00 00 
    interrupt_mask();
   41dd4:	e8 92 ff ff ff       	call   41d6b <interrupt_mask>
   41dd9:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41de0:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41de4:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41de8:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41deb:	ee                   	out    %al,(%dx)
}
   41dec:	90                   	nop
   41ded:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41df4:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41df8:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41dfc:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41dff:	ee                   	out    %al,(%dx)
}
   41e00:	90                   	nop
   41e01:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41e08:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e0c:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41e10:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41e13:	ee                   	out    %al,(%dx)
}
   41e14:	90                   	nop
   41e15:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41e1c:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e20:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41e24:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41e27:	ee                   	out    %al,(%dx)
}
   41e28:	90                   	nop
   41e29:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41e30:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e34:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41e38:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41e3b:	ee                   	out    %al,(%dx)
}
   41e3c:	90                   	nop
   41e3d:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41e44:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e48:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41e4c:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41e4f:	ee                   	out    %al,(%dx)
}
   41e50:	90                   	nop
   41e51:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41e58:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e5c:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41e60:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41e63:	ee                   	out    %al,(%dx)
}
   41e64:	90                   	nop
   41e65:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41e6c:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e70:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41e74:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41e77:	ee                   	out    %al,(%dx)
}
   41e78:	90                   	nop
   41e79:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41e80:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e84:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41e88:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41e8b:	ee                   	out    %al,(%dx)
}
   41e8c:	90                   	nop
   41e8d:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41e94:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e98:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41e9c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e9f:	ee                   	out    %al,(%dx)
}
   41ea0:	90                   	nop
   41ea1:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41ea8:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41eac:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41eb0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41eb3:	ee                   	out    %al,(%dx)
}
   41eb4:	90                   	nop
   41eb5:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41ebc:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ec0:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ec4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ec7:	ee                   	out    %al,(%dx)
}
   41ec8:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41ec9:	e8 9d fe ff ff       	call   41d6b <interrupt_mask>
}
   41ece:	90                   	nop
   41ecf:	c9                   	leave  
   41ed0:	c3                   	ret    

0000000000041ed1 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41ed1:	f3 0f 1e fa          	endbr64 
   41ed5:	55                   	push   %rbp
   41ed6:	48 89 e5             	mov    %rsp,%rbp
   41ed9:	48 83 ec 28          	sub    $0x28,%rsp
   41edd:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41ee0:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41ee4:	0f 8e 9f 00 00 00    	jle    41f89 <timer_init+0xb8>
   41eea:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41ef1:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ef5:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41ef9:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41efc:	ee                   	out    %al,(%dx)
}
   41efd:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41efe:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f01:	89 c2                	mov    %eax,%edx
   41f03:	c1 ea 1f             	shr    $0x1f,%edx
   41f06:	01 d0                	add    %edx,%eax
   41f08:	d1 f8                	sar    %eax
   41f0a:	05 de 34 12 00       	add    $0x1234de,%eax
   41f0f:	99                   	cltd   
   41f10:	f7 7d dc             	idivl  -0x24(%rbp)
   41f13:	89 c2                	mov    %eax,%edx
   41f15:	89 d0                	mov    %edx,%eax
   41f17:	c1 f8 1f             	sar    $0x1f,%eax
   41f1a:	c1 e8 18             	shr    $0x18,%eax
   41f1d:	89 c1                	mov    %eax,%ecx
   41f1f:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41f22:	0f b6 c0             	movzbl %al,%eax
   41f25:	29 c8                	sub    %ecx,%eax
   41f27:	0f b6 c0             	movzbl %al,%eax
   41f2a:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41f31:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f34:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41f38:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f3b:	ee                   	out    %al,(%dx)
}
   41f3c:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41f3d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f40:	89 c2                	mov    %eax,%edx
   41f42:	c1 ea 1f             	shr    $0x1f,%edx
   41f45:	01 d0                	add    %edx,%eax
   41f47:	d1 f8                	sar    %eax
   41f49:	05 de 34 12 00       	add    $0x1234de,%eax
   41f4e:	99                   	cltd   
   41f4f:	f7 7d dc             	idivl  -0x24(%rbp)
   41f52:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41f58:	85 c0                	test   %eax,%eax
   41f5a:	0f 48 c2             	cmovs  %edx,%eax
   41f5d:	c1 f8 08             	sar    $0x8,%eax
   41f60:	0f b6 c0             	movzbl %al,%eax
   41f63:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41f6a:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f6d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f71:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f74:	ee                   	out    %al,(%dx)
}
   41f75:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41f76:	0f b7 05 83 23 01 00 	movzwl 0x12383(%rip),%eax        # 54300 <interrupts_enabled>
   41f7d:	83 c8 01             	or     $0x1,%eax
   41f80:	66 89 05 79 23 01 00 	mov    %ax,0x12379(%rip)        # 54300 <interrupts_enabled>
   41f87:	eb 11                	jmp    41f9a <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41f89:	0f b7 05 70 23 01 00 	movzwl 0x12370(%rip),%eax        # 54300 <interrupts_enabled>
   41f90:	83 e0 fe             	and    $0xfffffffe,%eax
   41f93:	66 89 05 66 23 01 00 	mov    %ax,0x12366(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   41f9a:	e8 cc fd ff ff       	call   41d6b <interrupt_mask>
}
   41f9f:	90                   	nop
   41fa0:	c9                   	leave  
   41fa1:	c3                   	ret    

0000000000041fa2 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41fa2:	f3 0f 1e fa          	endbr64 
   41fa6:	55                   	push   %rbp
   41fa7:	48 89 e5             	mov    %rsp,%rbp
   41faa:	48 83 ec 08          	sub    $0x8,%rsp
   41fae:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41fb2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41fb7:	74 14                	je     41fcd <physical_memory_isreserved+0x2b>
   41fb9:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41fc0:	00 
   41fc1:	76 11                	jbe    41fd4 <physical_memory_isreserved+0x32>
   41fc3:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41fca:	00 
   41fcb:	77 07                	ja     41fd4 <physical_memory_isreserved+0x32>
   41fcd:	b8 01 00 00 00       	mov    $0x1,%eax
   41fd2:	eb 05                	jmp    41fd9 <physical_memory_isreserved+0x37>
   41fd4:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41fd9:	c9                   	leave  
   41fda:	c3                   	ret    

0000000000041fdb <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41fdb:	f3 0f 1e fa          	endbr64 
   41fdf:	55                   	push   %rbp
   41fe0:	48 89 e5             	mov    %rsp,%rbp
   41fe3:	48 83 ec 10          	sub    $0x10,%rsp
   41fe7:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41fea:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41fed:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41ff0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ff3:	c1 e0 10             	shl    $0x10,%eax
   41ff6:	89 c2                	mov    %eax,%edx
   41ff8:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ffb:	c1 e0 0b             	shl    $0xb,%eax
   41ffe:	09 c2                	or     %eax,%edx
   42000:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42003:	c1 e0 08             	shl    $0x8,%eax
   42006:	09 d0                	or     %edx,%eax
}
   42008:	c9                   	leave  
   42009:	c3                   	ret    

000000000004200a <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   4200a:	f3 0f 1e fa          	endbr64 
   4200e:	55                   	push   %rbp
   4200f:	48 89 e5             	mov    %rsp,%rbp
   42012:	48 83 ec 18          	sub    $0x18,%rsp
   42016:	89 7d ec             	mov    %edi,-0x14(%rbp)
   42019:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   4201c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4201f:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42022:	09 d0                	or     %edx,%eax
   42024:	0d 00 00 00 80       	or     $0x80000000,%eax
   42029:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   42030:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42033:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42036:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42039:	ef                   	out    %eax,(%dx)
}
   4203a:	90                   	nop
   4203b:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42042:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42045:	89 c2                	mov    %eax,%edx
   42047:	ed                   	in     (%dx),%eax
   42048:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   4204b:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   4204e:	c9                   	leave  
   4204f:	c3                   	ret    

0000000000042050 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   42050:	f3 0f 1e fa          	endbr64 
   42054:	55                   	push   %rbp
   42055:	48 89 e5             	mov    %rsp,%rbp
   42058:	48 83 ec 28          	sub    $0x28,%rsp
   4205c:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4205f:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42062:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42069:	eb 73                	jmp    420de <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   4206b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   42072:	eb 60                	jmp    420d4 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   42074:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4207b:	eb 4a                	jmp    420c7 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   4207d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42080:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   42083:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42086:	89 ce                	mov    %ecx,%esi
   42088:	89 c7                	mov    %eax,%edi
   4208a:	e8 4c ff ff ff       	call   41fdb <pci_make_configaddr>
   4208f:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   42092:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42095:	be 00 00 00 00       	mov    $0x0,%esi
   4209a:	89 c7                	mov    %eax,%edi
   4209c:	e8 69 ff ff ff       	call   4200a <pci_config_readl>
   420a1:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   420a4:	8b 45 d8             	mov    -0x28(%rbp),%eax
   420a7:	c1 e0 10             	shl    $0x10,%eax
   420aa:	0b 45 dc             	or     -0x24(%rbp),%eax
   420ad:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   420b0:	75 05                	jne    420b7 <pci_find_device+0x67>
                    return configaddr;
   420b2:	8b 45 f0             	mov    -0x10(%rbp),%eax
   420b5:	eb 35                	jmp    420ec <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   420b7:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   420bb:	75 06                	jne    420c3 <pci_find_device+0x73>
   420bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   420c1:	74 0c                	je     420cf <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   420c3:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   420c7:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   420cb:	75 b0                	jne    4207d <pci_find_device+0x2d>
   420cd:	eb 01                	jmp    420d0 <pci_find_device+0x80>
                    break;
   420cf:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   420d0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   420d4:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   420d8:	75 9a                	jne    42074 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   420da:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   420de:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   420e5:	75 84                	jne    4206b <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   420e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   420ec:	c9                   	leave  
   420ed:	c3                   	ret    

00000000000420ee <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   420ee:	f3 0f 1e fa          	endbr64 
   420f2:	55                   	push   %rbp
   420f3:	48 89 e5             	mov    %rsp,%rbp
   420f6:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   420fa:	be 13 71 00 00       	mov    $0x7113,%esi
   420ff:	bf 86 80 00 00       	mov    $0x8086,%edi
   42104:	e8 47 ff ff ff       	call   42050 <pci_find_device>
   42109:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   4210c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   42110:	78 30                	js     42142 <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   42112:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42115:	be 40 00 00 00       	mov    $0x40,%esi
   4211a:	89 c7                	mov    %eax,%edi
   4211c:	e8 e9 fe ff ff       	call   4200a <pci_config_readl>
   42121:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42126:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42129:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4212c:	83 c0 04             	add    $0x4,%eax
   4212f:	89 45 f4             	mov    %eax,-0xc(%rbp)
   42132:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42138:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   4213c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4213f:	66 ef                	out    %ax,(%dx)
}
   42141:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42142:	48 8d 05 77 28 00 00 	lea    0x2877(%rip),%rax        # 449c0 <memstate_colors+0xc0>
   42149:	48 89 c2             	mov    %rax,%rdx
   4214c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42151:	bf 80 07 00 00       	mov    $0x780,%edi
   42156:	b8 00 00 00 00       	mov    $0x0,%eax
   4215b:	e8 2e 23 00 00       	call   4448e <console_printf>
 spinloop: goto spinloop;
   42160:	eb fe                	jmp    42160 <poweroff+0x72>

0000000000042162 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   42162:	f3 0f 1e fa          	endbr64 
   42166:	55                   	push   %rbp
   42167:	48 89 e5             	mov    %rsp,%rbp
   4216a:	48 83 ec 10          	sub    $0x10,%rsp
   4216e:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42175:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42179:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4217d:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42180:	ee                   	out    %al,(%dx)
}
   42181:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   42182:	eb fe                	jmp    42182 <reboot+0x20>

0000000000042184 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42184:	f3 0f 1e fa          	endbr64 
   42188:	55                   	push   %rbp
   42189:	48 89 e5             	mov    %rsp,%rbp
   4218c:	48 83 ec 10          	sub    $0x10,%rsp
   42190:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42194:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   42197:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4219b:	48 83 c0 08          	add    $0x8,%rax
   4219f:	ba c0 00 00 00       	mov    $0xc0,%edx
   421a4:	be 00 00 00 00       	mov    $0x0,%esi
   421a9:	48 89 c7             	mov    %rax,%rdi
   421ac:	e8 9e 14 00 00       	call   4364f <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   421b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   421b5:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   421bc:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   421be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   421c2:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   421c9:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   421cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   421d1:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   421d8:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   421dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   421e0:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   421e7:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   421e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   421ed:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   421f4:	00 02 00 00 
    p->display_status = 1;
   421f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   421fc:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42203:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42206:	83 e0 01             	and    $0x1,%eax
   42209:	85 c0                	test   %eax,%eax
   4220b:	74 1c                	je     42229 <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4220d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42211:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42218:	80 cc 30             	or     $0x30,%ah
   4221b:	48 89 c2             	mov    %rax,%rdx
   4221e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42222:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42229:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4222c:	83 e0 02             	and    $0x2,%eax
   4222f:	85 c0                	test   %eax,%eax
   42231:	74 1c                	je     4224f <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42233:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42237:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4223e:	80 e4 fd             	and    $0xfd,%ah
   42241:	48 89 c2             	mov    %rax,%rdx
   42244:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42248:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   4224f:	90                   	nop
   42250:	c9                   	leave  
   42251:	c3                   	ret    

0000000000042252 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42252:	f3 0f 1e fa          	endbr64 
   42256:	55                   	push   %rbp
   42257:	48 89 e5             	mov    %rsp,%rbp
   4225a:	48 83 ec 28          	sub    $0x28,%rsp
   4225e:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42261:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42265:	78 09                	js     42270 <console_show_cursor+0x1e>
   42267:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4226e:	7e 07                	jle    42277 <console_show_cursor+0x25>
        cpos = 0;
   42270:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42277:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4227e:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42282:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42286:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42289:	ee                   	out    %al,(%dx)
}
   4228a:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   4228b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4228e:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42294:	85 c0                	test   %eax,%eax
   42296:	0f 48 c2             	cmovs  %edx,%eax
   42299:	c1 f8 08             	sar    $0x8,%eax
   4229c:	0f b6 c0             	movzbl %al,%eax
   4229f:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   422a6:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422a9:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   422ad:	8b 55 ec             	mov    -0x14(%rbp),%edx
   422b0:	ee                   	out    %al,(%dx)
}
   422b1:	90                   	nop
   422b2:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   422b9:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422bd:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   422c1:	8b 55 f4             	mov    -0xc(%rbp),%edx
   422c4:	ee                   	out    %al,(%dx)
}
   422c5:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   422c6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   422c9:	99                   	cltd   
   422ca:	c1 ea 18             	shr    $0x18,%edx
   422cd:	01 d0                	add    %edx,%eax
   422cf:	0f b6 c0             	movzbl %al,%eax
   422d2:	29 d0                	sub    %edx,%eax
   422d4:	0f b6 c0             	movzbl %al,%eax
   422d7:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   422de:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422e1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   422e5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   422e8:	ee                   	out    %al,(%dx)
}
   422e9:	90                   	nop
}
   422ea:	90                   	nop
   422eb:	c9                   	leave  
   422ec:	c3                   	ret    

00000000000422ed <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   422ed:	f3 0f 1e fa          	endbr64 
   422f1:	55                   	push   %rbp
   422f2:	48 89 e5             	mov    %rsp,%rbp
   422f5:	48 83 ec 20          	sub    $0x20,%rsp
   422f9:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42300:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42303:	89 c2                	mov    %eax,%edx
   42305:	ec                   	in     (%dx),%al
   42306:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42309:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   4230d:	0f b6 c0             	movzbl %al,%eax
   42310:	83 e0 01             	and    $0x1,%eax
   42313:	85 c0                	test   %eax,%eax
   42315:	75 0a                	jne    42321 <keyboard_readc+0x34>
        return -1;
   42317:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4231c:	e9 fd 01 00 00       	jmp    4251e <keyboard_readc+0x231>
   42321:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42328:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4232b:	89 c2                	mov    %eax,%edx
   4232d:	ec                   	in     (%dx),%al
   4232e:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42331:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42335:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42338:	0f b6 05 c3 1f 01 00 	movzbl 0x11fc3(%rip),%eax        # 54302 <last_escape.2>
   4233f:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42342:	c6 05 b9 1f 01 00 00 	movb   $0x0,0x11fb9(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42349:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4234d:	75 11                	jne    42360 <keyboard_readc+0x73>
        last_escape = 0x80;
   4234f:	c6 05 ac 1f 01 00 80 	movb   $0x80,0x11fac(%rip)        # 54302 <last_escape.2>
        return 0;
   42356:	b8 00 00 00 00       	mov    $0x0,%eax
   4235b:	e9 be 01 00 00       	jmp    4251e <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42360:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42364:	84 c0                	test   %al,%al
   42366:	79 64                	jns    423cc <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   42368:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4236c:	83 e0 7f             	and    $0x7f,%eax
   4236f:	89 c2                	mov    %eax,%edx
   42371:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42375:	09 d0                	or     %edx,%eax
   42377:	48 98                	cltq   
   42379:	48 8d 15 60 26 00 00 	lea    0x2660(%rip),%rdx        # 449e0 <keymap>
   42380:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42384:	0f b6 c0             	movzbl %al,%eax
   42387:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   4238a:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42391:	7e 2f                	jle    423c2 <keyboard_readc+0xd5>
   42393:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   4239a:	7f 26                	jg     423c2 <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   4239c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4239f:	2d fa 00 00 00       	sub    $0xfa,%eax
   423a4:	ba 01 00 00 00       	mov    $0x1,%edx
   423a9:	89 c1                	mov    %eax,%ecx
   423ab:	d3 e2                	shl    %cl,%edx
   423ad:	89 d0                	mov    %edx,%eax
   423af:	f7 d0                	not    %eax
   423b1:	89 c2                	mov    %eax,%edx
   423b3:	0f b6 05 49 1f 01 00 	movzbl 0x11f49(%rip),%eax        # 54303 <modifiers.1>
   423ba:	21 d0                	and    %edx,%eax
   423bc:	88 05 41 1f 01 00    	mov    %al,0x11f41(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   423c2:	b8 00 00 00 00       	mov    $0x0,%eax
   423c7:	e9 52 01 00 00       	jmp    4251e <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   423cc:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   423d0:	0a 45 fa             	or     -0x6(%rbp),%al
   423d3:	0f b6 c0             	movzbl %al,%eax
   423d6:	48 98                	cltq   
   423d8:	48 8d 15 01 26 00 00 	lea    0x2601(%rip),%rdx        # 449e0 <keymap>
   423df:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   423e3:	0f b6 c0             	movzbl %al,%eax
   423e6:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   423e9:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   423ed:	7e 57                	jle    42446 <keyboard_readc+0x159>
   423ef:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   423f3:	7f 51                	jg     42446 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   423f5:	0f b6 05 07 1f 01 00 	movzbl 0x11f07(%rip),%eax        # 54303 <modifiers.1>
   423fc:	0f b6 c0             	movzbl %al,%eax
   423ff:	83 e0 02             	and    $0x2,%eax
   42402:	85 c0                	test   %eax,%eax
   42404:	74 09                	je     4240f <keyboard_readc+0x122>
            ch -= 0x60;
   42406:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4240a:	e9 0b 01 00 00       	jmp    4251a <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4240f:	0f b6 05 ed 1e 01 00 	movzbl 0x11eed(%rip),%eax        # 54303 <modifiers.1>
   42416:	0f b6 c0             	movzbl %al,%eax
   42419:	83 e0 01             	and    $0x1,%eax
   4241c:	85 c0                	test   %eax,%eax
   4241e:	0f 94 c2             	sete   %dl
   42421:	0f b6 05 db 1e 01 00 	movzbl 0x11edb(%rip),%eax        # 54303 <modifiers.1>
   42428:	0f b6 c0             	movzbl %al,%eax
   4242b:	83 e0 08             	and    $0x8,%eax
   4242e:	85 c0                	test   %eax,%eax
   42430:	0f 94 c0             	sete   %al
   42433:	31 d0                	xor    %edx,%eax
   42435:	84 c0                	test   %al,%al
   42437:	0f 84 dd 00 00 00    	je     4251a <keyboard_readc+0x22d>
            ch -= 0x20;
   4243d:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42441:	e9 d4 00 00 00       	jmp    4251a <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42446:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4244d:	7e 30                	jle    4247f <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4244f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42452:	2d fa 00 00 00       	sub    $0xfa,%eax
   42457:	ba 01 00 00 00       	mov    $0x1,%edx
   4245c:	89 c1                	mov    %eax,%ecx
   4245e:	d3 e2                	shl    %cl,%edx
   42460:	89 d0                	mov    %edx,%eax
   42462:	89 c2                	mov    %eax,%edx
   42464:	0f b6 05 98 1e 01 00 	movzbl 0x11e98(%rip),%eax        # 54303 <modifiers.1>
   4246b:	31 d0                	xor    %edx,%eax
   4246d:	88 05 90 1e 01 00    	mov    %al,0x11e90(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42473:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4247a:	e9 9c 00 00 00       	jmp    4251b <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   4247f:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42486:	7e 2d                	jle    424b5 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42488:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4248b:	2d fa 00 00 00       	sub    $0xfa,%eax
   42490:	ba 01 00 00 00       	mov    $0x1,%edx
   42495:	89 c1                	mov    %eax,%ecx
   42497:	d3 e2                	shl    %cl,%edx
   42499:	89 d0                	mov    %edx,%eax
   4249b:	89 c2                	mov    %eax,%edx
   4249d:	0f b6 05 5f 1e 01 00 	movzbl 0x11e5f(%rip),%eax        # 54303 <modifiers.1>
   424a4:	09 d0                	or     %edx,%eax
   424a6:	88 05 57 1e 01 00    	mov    %al,0x11e57(%rip)        # 54303 <modifiers.1>
        ch = 0;
   424ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   424b3:	eb 66                	jmp    4251b <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   424b5:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   424b9:	7e 3f                	jle    424fa <keyboard_readc+0x20d>
   424bb:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   424c2:	7f 36                	jg     424fa <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   424c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   424c7:	8d 50 80             	lea    -0x80(%rax),%edx
   424ca:	0f b6 05 32 1e 01 00 	movzbl 0x11e32(%rip),%eax        # 54303 <modifiers.1>
   424d1:	0f b6 c0             	movzbl %al,%eax
   424d4:	83 e0 03             	and    $0x3,%eax
   424d7:	48 63 c8             	movslq %eax,%rcx
   424da:	48 63 c2             	movslq %edx,%rax
   424dd:	48 c1 e0 02          	shl    $0x2,%rax
   424e1:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   424e5:	48 8d 05 f4 25 00 00 	lea    0x25f4(%rip),%rax        # 44ae0 <complex_keymap>
   424ec:	48 01 d0             	add    %rdx,%rax
   424ef:	0f b6 00             	movzbl (%rax),%eax
   424f2:	0f b6 c0             	movzbl %al,%eax
   424f5:	89 45 fc             	mov    %eax,-0x4(%rbp)
   424f8:	eb 21                	jmp    4251b <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   424fa:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   424fe:	7f 1b                	jg     4251b <keyboard_readc+0x22e>
   42500:	0f b6 05 fc 1d 01 00 	movzbl 0x11dfc(%rip),%eax        # 54303 <modifiers.1>
   42507:	0f b6 c0             	movzbl %al,%eax
   4250a:	83 e0 02             	and    $0x2,%eax
   4250d:	85 c0                	test   %eax,%eax
   4250f:	74 0a                	je     4251b <keyboard_readc+0x22e>
        ch = 0;
   42511:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42518:	eb 01                	jmp    4251b <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   4251a:	90                   	nop
    }

    return ch;
   4251b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4251e:	c9                   	leave  
   4251f:	c3                   	ret    

0000000000042520 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42520:	f3 0f 1e fa          	endbr64 
   42524:	55                   	push   %rbp
   42525:	48 89 e5             	mov    %rsp,%rbp
   42528:	48 83 ec 20          	sub    $0x20,%rsp
   4252c:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42533:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42536:	89 c2                	mov    %eax,%edx
   42538:	ec                   	in     (%dx),%al
   42539:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4253c:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42543:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42546:	89 c2                	mov    %eax,%edx
   42548:	ec                   	in     (%dx),%al
   42549:	88 45 eb             	mov    %al,-0x15(%rbp)
   4254c:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42553:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42556:	89 c2                	mov    %eax,%edx
   42558:	ec                   	in     (%dx),%al
   42559:	88 45 f3             	mov    %al,-0xd(%rbp)
   4255c:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42563:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42566:	89 c2                	mov    %eax,%edx
   42568:	ec                   	in     (%dx),%al
   42569:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4256c:	90                   	nop
   4256d:	c9                   	leave  
   4256e:	c3                   	ret    

000000000004256f <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4256f:	f3 0f 1e fa          	endbr64 
   42573:	55                   	push   %rbp
   42574:	48 89 e5             	mov    %rsp,%rbp
   42577:	48 83 ec 40          	sub    $0x40,%rsp
   4257b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4257f:	89 f0                	mov    %esi,%eax
   42581:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42584:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42587:	8b 05 77 1d 01 00    	mov    0x11d77(%rip),%eax        # 54304 <initialized.0>
   4258d:	85 c0                	test   %eax,%eax
   4258f:	75 1e                	jne    425af <parallel_port_putc+0x40>
   42591:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42598:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4259c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   425a0:	8b 55 f8             	mov    -0x8(%rbp),%edx
   425a3:	ee                   	out    %al,(%dx)
}
   425a4:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   425a5:	c7 05 55 1d 01 00 01 	movl   $0x1,0x11d55(%rip)        # 54304 <initialized.0>
   425ac:	00 00 00 
    }

    for (int i = 0;
   425af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   425b6:	eb 09                	jmp    425c1 <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   425b8:	e8 63 ff ff ff       	call   42520 <delay>
         ++i) {
   425bd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   425c1:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   425c8:	7f 18                	jg     425e2 <parallel_port_putc+0x73>
   425ca:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   425d1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   425d4:	89 c2                	mov    %eax,%edx
   425d6:	ec                   	in     (%dx),%al
   425d7:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   425da:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   425de:	84 c0                	test   %al,%al
   425e0:	79 d6                	jns    425b8 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   425e2:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   425e6:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   425ed:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   425f0:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   425f4:	8b 55 d8             	mov    -0x28(%rbp),%edx
   425f7:	ee                   	out    %al,(%dx)
}
   425f8:	90                   	nop
   425f9:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42600:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42604:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42608:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4260b:	ee                   	out    %al,(%dx)
}
   4260c:	90                   	nop
   4260d:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42614:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42618:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4261c:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4261f:	ee                   	out    %al,(%dx)
}
   42620:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42621:	90                   	nop
   42622:	c9                   	leave  
   42623:	c3                   	ret    

0000000000042624 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42624:	f3 0f 1e fa          	endbr64 
   42628:	55                   	push   %rbp
   42629:	48 89 e5             	mov    %rsp,%rbp
   4262c:	48 83 ec 20          	sub    $0x20,%rsp
   42630:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42634:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42638:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 4256f <parallel_port_putc>
   4263f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   42643:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42647:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4264b:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4264f:	be 00 00 00 00       	mov    $0x0,%esi
   42654:	48 89 c7             	mov    %rax,%rdi
   42657:	e8 b9 12 00 00       	call   43915 <printer_vprintf>
}
   4265c:	90                   	nop
   4265d:	c9                   	leave  
   4265e:	c3                   	ret    

000000000004265f <log_printf>:

void log_printf(const char* format, ...) {
   4265f:	f3 0f 1e fa          	endbr64 
   42663:	55                   	push   %rbp
   42664:	48 89 e5             	mov    %rsp,%rbp
   42667:	48 83 ec 60          	sub    $0x60,%rsp
   4266b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4266f:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42673:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42677:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4267b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4267f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42683:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4268a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4268e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42692:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42696:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4269a:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4269e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   426a2:	48 89 d6             	mov    %rdx,%rsi
   426a5:	48 89 c7             	mov    %rax,%rdi
   426a8:	e8 77 ff ff ff       	call   42624 <log_vprintf>
    va_end(val);
}
   426ad:	90                   	nop
   426ae:	c9                   	leave  
   426af:	c3                   	ret    

00000000000426b0 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   426b0:	f3 0f 1e fa          	endbr64 
   426b4:	55                   	push   %rbp
   426b5:	48 89 e5             	mov    %rsp,%rbp
   426b8:	48 83 ec 40          	sub    $0x40,%rsp
   426bc:	89 7d dc             	mov    %edi,-0x24(%rbp)
   426bf:	89 75 d8             	mov    %esi,-0x28(%rbp)
   426c2:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   426c6:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   426ca:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   426ce:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   426d2:	48 8b 0a             	mov    (%rdx),%rcx
   426d5:	48 89 08             	mov    %rcx,(%rax)
   426d8:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   426dc:	48 89 48 08          	mov    %rcx,0x8(%rax)
   426e0:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   426e4:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   426e8:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   426ec:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   426f0:	48 89 d6             	mov    %rdx,%rsi
   426f3:	48 89 c7             	mov    %rax,%rdi
   426f6:	e8 29 ff ff ff       	call   42624 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   426fb:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   426ff:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42703:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42706:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42709:	89 c7                	mov    %eax,%edi
   4270b:	e8 02 1d 00 00       	call   44412 <console_vprintf>
}
   42710:	c9                   	leave  
   42711:	c3                   	ret    

0000000000042712 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42712:	f3 0f 1e fa          	endbr64 
   42716:	55                   	push   %rbp
   42717:	48 89 e5             	mov    %rsp,%rbp
   4271a:	48 83 ec 60          	sub    $0x60,%rsp
   4271e:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42721:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42724:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42728:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4272c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42730:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42734:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4273b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4273f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42743:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42747:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   4274b:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4274f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42753:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42756:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42759:	89 c7                	mov    %eax,%edi
   4275b:	e8 50 ff ff ff       	call   426b0 <error_vprintf>
   42760:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42763:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42766:	c9                   	leave  
   42767:	c3                   	ret    

0000000000042768 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42768:	f3 0f 1e fa          	endbr64 
   4276c:	55                   	push   %rbp
   4276d:	48 89 e5             	mov    %rsp,%rbp
   42770:	53                   	push   %rbx
   42771:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42775:	e8 73 fb ff ff       	call   422ed <keyboard_readc>
   4277a:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   4277d:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42781:	74 1c                	je     4279f <check_keyboard+0x37>
   42783:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42787:	74 16                	je     4279f <check_keyboard+0x37>
   42789:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   4278d:	74 10                	je     4279f <check_keyboard+0x37>
   4278f:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42793:	74 0a                	je     4279f <check_keyboard+0x37>
   42795:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42799:	0f 85 02 01 00 00    	jne    428a1 <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   4279f:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   427a6:	00 
        memset(pt, 0, PAGESIZE * 3);
   427a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   427ab:	ba 00 30 00 00       	mov    $0x3000,%edx
   427b0:	be 00 00 00 00       	mov    $0x0,%esi
   427b5:	48 89 c7             	mov    %rax,%rdi
   427b8:	e8 92 0e 00 00       	call   4364f <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   427bd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   427c1:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   427c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   427cc:	48 05 00 10 00 00    	add    $0x1000,%rax
   427d2:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   427d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   427dd:	48 05 00 20 00 00    	add    $0x2000,%rax
   427e3:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   427ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   427ee:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   427f2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   427f6:	0f 22 d8             	mov    %rax,%cr3
}
   427f9:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   427fa:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42801:	48 8d 05 30 23 00 00 	lea    0x2330(%rip),%rax        # 44b38 <complex_keymap+0x58>
   42808:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   4280c:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42810:	75 0d                	jne    4281f <check_keyboard+0xb7>
            argument = "allocator";
   42812:	48 8d 05 24 23 00 00 	lea    0x2324(%rip),%rax        # 44b3d <complex_keymap+0x5d>
   42819:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4281d:	eb 37                	jmp    42856 <check_keyboard+0xee>
        } else if (c == 'e') {
   4281f:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42823:	75 0d                	jne    42832 <check_keyboard+0xca>
            argument = "forkexit";
   42825:	48 8d 05 1b 23 00 00 	lea    0x231b(%rip),%rax        # 44b47 <complex_keymap+0x67>
   4282c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42830:	eb 24                	jmp    42856 <check_keyboard+0xee>
        }
        else if (c == 't'){
   42832:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42836:	75 0d                	jne    42845 <check_keyboard+0xdd>
            argument = "test";
   42838:	48 8d 05 11 23 00 00 	lea    0x2311(%rip),%rax        # 44b50 <complex_keymap+0x70>
   4283f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42843:	eb 11                	jmp    42856 <check_keyboard+0xee>
        }
        else if(c == '2'){
   42845:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42849:	75 0b                	jne    42856 <check_keyboard+0xee>
            argument = "test2";
   4284b:	48 8d 05 03 23 00 00 	lea    0x2303(%rip),%rax        # 44b55 <complex_keymap+0x75>
   42852:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42856:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4285a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   4285e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42863:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42867:	76 1e                	jbe    42887 <check_keyboard+0x11f>
   42869:	48 8d 05 eb 22 00 00 	lea    0x22eb(%rip),%rax        # 44b5b <complex_keymap+0x7b>
   42870:	48 89 c2             	mov    %rax,%rdx
   42873:	be 5d 02 00 00       	mov    $0x25d,%esi
   42878:	48 8d 05 f8 22 00 00 	lea    0x22f8(%rip),%rax        # 44b77 <complex_keymap+0x97>
   4287f:	48 89 c7             	mov    %rax,%rdi
   42882:	e8 33 01 00 00       	call   429ba <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42887:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4288b:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   4288e:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42892:	48 89 c3             	mov    %rax,%rbx
   42895:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   4289a:	e9 61 d7 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   4289f:	eb 11                	jmp    428b2 <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   428a1:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   428a5:	74 06                	je     428ad <check_keyboard+0x145>
   428a7:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   428ab:	75 05                	jne    428b2 <check_keyboard+0x14a>
        poweroff();
   428ad:	e8 3c f8 ff ff       	call   420ee <poweroff>
    }
    return c;
   428b2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   428b5:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   428b9:	c9                   	leave  
   428ba:	c3                   	ret    

00000000000428bb <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   428bb:	f3 0f 1e fa          	endbr64 
   428bf:	55                   	push   %rbp
   428c0:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   428c3:	e8 a0 fe ff ff       	call   42768 <check_keyboard>
   428c8:	eb f9                	jmp    428c3 <fail+0x8>

00000000000428ca <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   428ca:	f3 0f 1e fa          	endbr64 
   428ce:	55                   	push   %rbp
   428cf:	48 89 e5             	mov    %rsp,%rbp
   428d2:	48 83 ec 60          	sub    $0x60,%rsp
   428d6:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   428da:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   428de:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   428e2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   428e6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   428ea:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   428ee:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   428f5:	48 8d 45 10          	lea    0x10(%rbp),%rax
   428f9:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   428fd:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42901:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42905:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   4290a:	0f 84 87 00 00 00    	je     42997 <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42910:	48 8d 05 74 22 00 00 	lea    0x2274(%rip),%rax        # 44b8b <complex_keymap+0xab>
   42917:	48 89 c2             	mov    %rax,%rdx
   4291a:	be 00 c0 00 00       	mov    $0xc000,%esi
   4291f:	bf 30 07 00 00       	mov    $0x730,%edi
   42924:	b8 00 00 00 00       	mov    $0x0,%eax
   42929:	e8 e4 fd ff ff       	call   42712 <error_printf>
   4292e:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42931:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42935:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42939:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4293c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42941:	89 c7                	mov    %eax,%edi
   42943:	e8 68 fd ff ff       	call   426b0 <error_vprintf>
   42948:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4294b:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   4294e:	48 63 c1             	movslq %ecx,%rax
   42951:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42958:	48 c1 e8 20          	shr    $0x20,%rax
   4295c:	c1 f8 05             	sar    $0x5,%eax
   4295f:	89 ce                	mov    %ecx,%esi
   42961:	c1 fe 1f             	sar    $0x1f,%esi
   42964:	29 f0                	sub    %esi,%eax
   42966:	89 c2                	mov    %eax,%edx
   42968:	89 d0                	mov    %edx,%eax
   4296a:	c1 e0 02             	shl    $0x2,%eax
   4296d:	01 d0                	add    %edx,%eax
   4296f:	c1 e0 04             	shl    $0x4,%eax
   42972:	29 c1                	sub    %eax,%ecx
   42974:	89 ca                	mov    %ecx,%edx
   42976:	85 d2                	test   %edx,%edx
   42978:	74 3b                	je     429b5 <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   4297a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4297d:	48 8d 15 0f 22 00 00 	lea    0x220f(%rip),%rdx        # 44b93 <complex_keymap+0xb3>
   42984:	be 00 c0 00 00       	mov    $0xc000,%esi
   42989:	89 c7                	mov    %eax,%edi
   4298b:	b8 00 00 00 00       	mov    $0x0,%eax
   42990:	e8 7d fd ff ff       	call   42712 <error_printf>
   42995:	eb 1e                	jmp    429b5 <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42997:	48 8d 05 f7 21 00 00 	lea    0x21f7(%rip),%rax        # 44b95 <complex_keymap+0xb5>
   4299e:	48 89 c2             	mov    %rax,%rdx
   429a1:	be 00 c0 00 00       	mov    $0xc000,%esi
   429a6:	bf 30 07 00 00       	mov    $0x730,%edi
   429ab:	b8 00 00 00 00       	mov    $0x0,%eax
   429b0:	e8 5d fd ff ff       	call   42712 <error_printf>
    }

    va_end(val);
    fail();
   429b5:	e8 01 ff ff ff       	call   428bb <fail>

00000000000429ba <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   429ba:	f3 0f 1e fa          	endbr64 
   429be:	55                   	push   %rbp
   429bf:	48 89 e5             	mov    %rsp,%rbp
   429c2:	48 83 ec 20          	sub    $0x20,%rsp
   429c6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   429ca:	89 75 f4             	mov    %esi,-0xc(%rbp)
   429cd:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   429d1:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   429d5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   429d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   429dc:	48 89 c6             	mov    %rax,%rsi
   429df:	48 8d 05 b5 21 00 00 	lea    0x21b5(%rip),%rax        # 44b9b <complex_keymap+0xbb>
   429e6:	48 89 c7             	mov    %rax,%rdi
   429e9:	b8 00 00 00 00       	mov    $0x0,%eax
   429ee:	e8 d7 fe ff ff       	call   428ca <panic>

00000000000429f3 <default_exception>:
}

void default_exception(proc* p){
   429f3:	f3 0f 1e fa          	endbr64 
   429f7:	55                   	push   %rbp
   429f8:	48 89 e5             	mov    %rsp,%rbp
   429fb:	48 83 ec 20          	sub    $0x20,%rsp
   429ff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42a03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a07:	48 83 c0 08          	add    $0x8,%rax
   42a0b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42a0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a13:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42a1a:	48 89 c6             	mov    %rax,%rsi
   42a1d:	48 8d 05 95 21 00 00 	lea    0x2195(%rip),%rax        # 44bb9 <complex_keymap+0xd9>
   42a24:	48 89 c7             	mov    %rax,%rdi
   42a27:	b8 00 00 00 00       	mov    $0x0,%eax
   42a2c:	e8 99 fe ff ff       	call   428ca <panic>

0000000000042a31 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42a31:	55                   	push   %rbp
   42a32:	48 89 e5             	mov    %rsp,%rbp
   42a35:	48 83 ec 10          	sub    $0x10,%rsp
   42a39:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42a3d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42a40:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42a44:	78 06                	js     42a4c <pageindex+0x1b>
   42a46:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42a4a:	7e 1e                	jle    42a6a <pageindex+0x39>
   42a4c:	48 8d 05 85 21 00 00 	lea    0x2185(%rip),%rax        # 44bd8 <complex_keymap+0xf8>
   42a53:	48 89 c2             	mov    %rax,%rdx
   42a56:	be 1e 00 00 00       	mov    $0x1e,%esi
   42a5b:	48 8d 05 8f 21 00 00 	lea    0x218f(%rip),%rax        # 44bf1 <complex_keymap+0x111>
   42a62:	48 89 c7             	mov    %rax,%rdi
   42a65:	e8 50 ff ff ff       	call   429ba <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42a6a:	b8 03 00 00 00       	mov    $0x3,%eax
   42a6f:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42a72:	89 c2                	mov    %eax,%edx
   42a74:	89 d0                	mov    %edx,%eax
   42a76:	c1 e0 03             	shl    $0x3,%eax
   42a79:	01 d0                	add    %edx,%eax
   42a7b:	83 c0 0c             	add    $0xc,%eax
   42a7e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42a82:	89 c1                	mov    %eax,%ecx
   42a84:	48 d3 ea             	shr    %cl,%rdx
   42a87:	48 89 d0             	mov    %rdx,%rax
   42a8a:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42a8f:	c9                   	leave  
   42a90:	c3                   	ret    

0000000000042a91 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42a91:	f3 0f 1e fa          	endbr64 
   42a95:	55                   	push   %rbp
   42a96:	48 89 e5             	mov    %rsp,%rbp
   42a99:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42a9d:	48 8d 05 5c 35 01 00 	lea    0x1355c(%rip),%rax        # 56000 <kernel_pagetables>
   42aa4:	48 89 05 55 25 01 00 	mov    %rax,0x12555(%rip)        # 55000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42aab:	ba 00 50 00 00       	mov    $0x5000,%edx
   42ab0:	be 00 00 00 00       	mov    $0x0,%esi
   42ab5:	48 8d 05 44 35 01 00 	lea    0x13544(%rip),%rax        # 56000 <kernel_pagetables>
   42abc:	48 89 c7             	mov    %rax,%rdi
   42abf:	e8 8b 0b 00 00       	call   4364f <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42ac4:	48 8d 05 35 45 01 00 	lea    0x14535(%rip),%rax        # 57000 <kernel_pagetables+0x1000>
   42acb:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42acf:	48 89 05 2a 35 01 00 	mov    %rax,0x1352a(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42ad6:	48 8d 05 23 55 01 00 	lea    0x15523(%rip),%rax        # 58000 <kernel_pagetables+0x2000>
   42add:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42ae1:	48 89 05 18 45 01 00 	mov    %rax,0x14518(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42ae8:	48 8d 05 11 65 01 00 	lea    0x16511(%rip),%rax        # 59000 <kernel_pagetables+0x3000>
   42aef:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42af3:	48 89 05 06 55 01 00 	mov    %rax,0x15506(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42afa:	48 8d 05 ff 74 01 00 	lea    0x174ff(%rip),%rax        # 5a000 <kernel_pagetables+0x4000>
   42b01:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42b05:	48 89 05 fc 54 01 00 	mov    %rax,0x154fc(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42b0c:	48 8b 05 ed 24 01 00 	mov    0x124ed(%rip),%rax        # 55000 <kernel_pagetable>
   42b13:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42b19:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42b1e:	ba 00 00 00 00       	mov    $0x0,%edx
   42b23:	be 00 00 00 00       	mov    $0x0,%esi
   42b28:	48 89 c7             	mov    %rax,%rdi
   42b2b:	e8 0e 02 00 00       	call   42d3e <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42b30:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42b37:	00 
   42b38:	eb 76                	jmp    42bb0 <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42b3a:	48 8b 0d bf 24 01 00 	mov    0x124bf(%rip),%rcx        # 55000 <kernel_pagetable>
   42b41:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42b45:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42b49:	48 89 ce             	mov    %rcx,%rsi
   42b4c:	48 89 c7             	mov    %rax,%rdi
   42b4f:	e8 34 06 00 00       	call   43188 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42b54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b58:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42b5c:	74 1e                	je     42b7c <virtual_memory_init+0xeb>
   42b5e:	48 8d 05 a0 20 00 00 	lea    0x20a0(%rip),%rax        # 44c05 <complex_keymap+0x125>
   42b65:	48 89 c2             	mov    %rax,%rdx
   42b68:	be 2d 00 00 00       	mov    $0x2d,%esi
   42b6d:	48 8d 05 a1 20 00 00 	lea    0x20a1(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42b74:	48 89 c7             	mov    %rax,%rdi
   42b77:	e8 3e fe ff ff       	call   429ba <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42b7c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42b7f:	48 98                	cltq   
   42b81:	83 e0 03             	and    $0x3,%eax
   42b84:	48 83 f8 03          	cmp    $0x3,%rax
   42b88:	74 1e                	je     42ba8 <virtual_memory_init+0x117>
   42b8a:	48 8d 05 97 20 00 00 	lea    0x2097(%rip),%rax        # 44c28 <complex_keymap+0x148>
   42b91:	48 89 c2             	mov    %rax,%rdx
   42b94:	be 2e 00 00 00       	mov    $0x2e,%esi
   42b99:	48 8d 05 75 20 00 00 	lea    0x2075(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42ba0:	48 89 c7             	mov    %rax,%rdi
   42ba3:	e8 12 fe ff ff       	call   429ba <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42ba8:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42baf:	00 
   42bb0:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42bb7:	00 
   42bb8:	76 80                	jbe    42b3a <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42bba:	48 8b 05 3f 24 01 00 	mov    0x1243f(%rip),%rax        # 55000 <kernel_pagetable>
   42bc1:	48 89 c7             	mov    %rax,%rdi
   42bc4:	e8 03 00 00 00       	call   42bcc <set_pagetable>
}
   42bc9:	90                   	nop
   42bca:	c9                   	leave  
   42bcb:	c3                   	ret    

0000000000042bcc <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42bcc:	f3 0f 1e fa          	endbr64 
   42bd0:	55                   	push   %rbp
   42bd1:	48 89 e5             	mov    %rsp,%rbp
   42bd4:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42bd8:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42bdc:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42be0:	25 ff 0f 00 00       	and    $0xfff,%eax
   42be5:	48 85 c0             	test   %rax,%rax
   42be8:	74 1e                	je     42c08 <set_pagetable+0x3c>
   42bea:	48 8d 05 64 20 00 00 	lea    0x2064(%rip),%rax        # 44c55 <complex_keymap+0x175>
   42bf1:	48 89 c2             	mov    %rax,%rdx
   42bf4:	be 3d 00 00 00       	mov    $0x3d,%esi
   42bf9:	48 8d 05 15 20 00 00 	lea    0x2015(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42c00:	48 89 c7             	mov    %rax,%rdi
   42c03:	e8 b2 fd ff ff       	call   429ba <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42c08:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   42c0f:	48 89 c2             	mov    %rax,%rdx
   42c12:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42c16:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42c1a:	48 89 ce             	mov    %rcx,%rsi
   42c1d:	48 89 c7             	mov    %rax,%rdi
   42c20:	e8 63 05 00 00       	call   43188 <virtual_memory_lookup>
   42c25:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42c29:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   42c30:	48 39 d0             	cmp    %rdx,%rax
   42c33:	74 1e                	je     42c53 <set_pagetable+0x87>
   42c35:	48 8d 05 34 20 00 00 	lea    0x2034(%rip),%rax        # 44c70 <complex_keymap+0x190>
   42c3c:	48 89 c2             	mov    %rax,%rdx
   42c3f:	be 3f 00 00 00       	mov    $0x3f,%esi
   42c44:	48 8d 05 ca 1f 00 00 	lea    0x1fca(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42c4b:	48 89 c7             	mov    %rax,%rdi
   42c4e:	e8 67 fd ff ff       	call   429ba <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42c53:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42c57:	48 8b 0d a2 23 01 00 	mov    0x123a2(%rip),%rcx        # 55000 <kernel_pagetable>
   42c5e:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42c62:	48 89 ce             	mov    %rcx,%rsi
   42c65:	48 89 c7             	mov    %rax,%rdi
   42c68:	e8 1b 05 00 00       	call   43188 <virtual_memory_lookup>
   42c6d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42c71:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42c75:	48 39 c2             	cmp    %rax,%rdx
   42c78:	74 1e                	je     42c98 <set_pagetable+0xcc>
   42c7a:	48 8d 05 57 20 00 00 	lea    0x2057(%rip),%rax        # 44cd8 <complex_keymap+0x1f8>
   42c81:	48 89 c2             	mov    %rax,%rdx
   42c84:	be 41 00 00 00       	mov    $0x41,%esi
   42c89:	48 8d 05 85 1f 00 00 	lea    0x1f85(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42c90:	48 89 c7             	mov    %rax,%rdi
   42c93:	e8 22 fd ff ff       	call   429ba <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42c98:	48 8b 05 61 23 01 00 	mov    0x12361(%rip),%rax        # 55000 <kernel_pagetable>
   42c9f:	48 89 c2             	mov    %rax,%rdx
   42ca2:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42ca6:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42caa:	48 89 ce             	mov    %rcx,%rsi
   42cad:	48 89 c7             	mov    %rax,%rdi
   42cb0:	e8 d3 04 00 00       	call   43188 <virtual_memory_lookup>
   42cb5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42cb9:	48 8b 15 40 23 01 00 	mov    0x12340(%rip),%rdx        # 55000 <kernel_pagetable>
   42cc0:	48 39 d0             	cmp    %rdx,%rax
   42cc3:	74 1e                	je     42ce3 <set_pagetable+0x117>
   42cc5:	48 8d 05 6c 20 00 00 	lea    0x206c(%rip),%rax        # 44d38 <complex_keymap+0x258>
   42ccc:	48 89 c2             	mov    %rax,%rdx
   42ccf:	be 43 00 00 00       	mov    $0x43,%esi
   42cd4:	48 8d 05 3a 1f 00 00 	lea    0x1f3a(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42cdb:	48 89 c7             	mov    %rax,%rdi
   42cde:	e8 d7 fc ff ff       	call   429ba <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42ce3:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 42d3e <virtual_memory_map>
   42cea:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42cee:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42cf2:	48 89 ce             	mov    %rcx,%rsi
   42cf5:	48 89 c7             	mov    %rax,%rdi
   42cf8:	e8 8b 04 00 00       	call   43188 <virtual_memory_lookup>
   42cfd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d01:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 42d3e <virtual_memory_map>
   42d08:	48 39 d0             	cmp    %rdx,%rax
   42d0b:	74 1e                	je     42d2b <set_pagetable+0x15f>
   42d0d:	48 8d 05 8c 20 00 00 	lea    0x208c(%rip),%rax        # 44da0 <complex_keymap+0x2c0>
   42d14:	48 89 c2             	mov    %rax,%rdx
   42d17:	be 45 00 00 00       	mov    $0x45,%esi
   42d1c:	48 8d 05 f2 1e 00 00 	lea    0x1ef2(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42d23:	48 89 c7             	mov    %rax,%rdi
   42d26:	e8 8f fc ff ff       	call   429ba <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42d2b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42d2f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42d33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d37:	0f 22 d8             	mov    %rax,%cr3
}
   42d3a:	90                   	nop
}
   42d3b:	90                   	nop
   42d3c:	c9                   	leave  
   42d3d:	c3                   	ret    

0000000000042d3e <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42d3e:	f3 0f 1e fa          	endbr64 
   42d42:	55                   	push   %rbp
   42d43:	48 89 e5             	mov    %rsp,%rbp
   42d46:	48 83 ec 50          	sub    $0x50,%rsp
   42d4a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42d4e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42d52:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42d56:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   42d5a:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42d5e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42d62:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d67:	48 85 c0             	test   %rax,%rax
   42d6a:	74 1e                	je     42d8a <virtual_memory_map+0x4c>
   42d6c:	48 8d 05 93 20 00 00 	lea    0x2093(%rip),%rax        # 44e06 <complex_keymap+0x326>
   42d73:	48 89 c2             	mov    %rax,%rdx
   42d76:	be 66 00 00 00       	mov    $0x66,%esi
   42d7b:	48 8d 05 93 1e 00 00 	lea    0x1e93(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42d82:	48 89 c7             	mov    %rax,%rdi
   42d85:	e8 30 fc ff ff       	call   429ba <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42d8a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42d8e:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d93:	48 85 c0             	test   %rax,%rax
   42d96:	74 1e                	je     42db6 <virtual_memory_map+0x78>
   42d98:	48 8d 05 7a 20 00 00 	lea    0x207a(%rip),%rax        # 44e19 <complex_keymap+0x339>
   42d9f:	48 89 c2             	mov    %rax,%rdx
   42da2:	be 67 00 00 00       	mov    $0x67,%esi
   42da7:	48 8d 05 67 1e 00 00 	lea    0x1e67(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42dae:	48 89 c7             	mov    %rax,%rdi
   42db1:	e8 04 fc ff ff       	call   429ba <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42db6:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42dba:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42dbe:	48 01 d0             	add    %rdx,%rax
   42dc1:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42dc5:	76 2e                	jbe    42df5 <virtual_memory_map+0xb7>
   42dc7:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42dcb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42dcf:	48 01 d0             	add    %rdx,%rax
   42dd2:	48 85 c0             	test   %rax,%rax
   42dd5:	74 1e                	je     42df5 <virtual_memory_map+0xb7>
   42dd7:	48 8d 05 4e 20 00 00 	lea    0x204e(%rip),%rax        # 44e2c <complex_keymap+0x34c>
   42dde:	48 89 c2             	mov    %rax,%rdx
   42de1:	be 68 00 00 00       	mov    $0x68,%esi
   42de6:	48 8d 05 28 1e 00 00 	lea    0x1e28(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42ded:	48 89 c7             	mov    %rax,%rdi
   42df0:	e8 c5 fb ff ff       	call   429ba <assert_fail>
    if (perm & PTE_P) {
   42df5:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42df8:	48 98                	cltq   
   42dfa:	83 e0 01             	and    $0x1,%eax
   42dfd:	48 85 c0             	test   %rax,%rax
   42e00:	0f 84 8c 00 00 00    	je     42e92 <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42e06:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e0a:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e0f:	48 85 c0             	test   %rax,%rax
   42e12:	74 1e                	je     42e32 <virtual_memory_map+0xf4>
   42e14:	48 8d 05 2f 20 00 00 	lea    0x202f(%rip),%rax        # 44e4a <complex_keymap+0x36a>
   42e1b:	48 89 c2             	mov    %rax,%rdx
   42e1e:	be 6a 00 00 00       	mov    $0x6a,%esi
   42e23:	48 8d 05 eb 1d 00 00 	lea    0x1deb(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42e2a:	48 89 c7             	mov    %rax,%rdi
   42e2d:	e8 88 fb ff ff       	call   429ba <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42e32:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42e36:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e3a:	48 01 d0             	add    %rdx,%rax
   42e3d:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   42e41:	76 1e                	jbe    42e61 <virtual_memory_map+0x123>
   42e43:	48 8d 05 13 20 00 00 	lea    0x2013(%rip),%rax        # 44e5d <complex_keymap+0x37d>
   42e4a:	48 89 c2             	mov    %rax,%rdx
   42e4d:	be 6b 00 00 00       	mov    $0x6b,%esi
   42e52:	48 8d 05 bc 1d 00 00 	lea    0x1dbc(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42e59:	48 89 c7             	mov    %rax,%rdi
   42e5c:	e8 59 fb ff ff       	call   429ba <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42e61:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42e65:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e69:	48 01 d0             	add    %rdx,%rax
   42e6c:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42e72:	76 1e                	jbe    42e92 <virtual_memory_map+0x154>
   42e74:	48 8d 05 f0 1f 00 00 	lea    0x1ff0(%rip),%rax        # 44e6b <complex_keymap+0x38b>
   42e7b:	48 89 c2             	mov    %rax,%rdx
   42e7e:	be 6c 00 00 00       	mov    $0x6c,%esi
   42e83:	48 8d 05 8b 1d 00 00 	lea    0x1d8b(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42e8a:	48 89 c7             	mov    %rax,%rdi
   42e8d:	e8 28 fb ff ff       	call   429ba <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42e92:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   42e96:	78 09                	js     42ea1 <virtual_memory_map+0x163>
   42e98:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   42e9f:	7e 1e                	jle    42ebf <virtual_memory_map+0x181>
   42ea1:	48 8d 05 df 1f 00 00 	lea    0x1fdf(%rip),%rax        # 44e87 <complex_keymap+0x3a7>
   42ea8:	48 89 c2             	mov    %rax,%rdx
   42eab:	be 6e 00 00 00       	mov    $0x6e,%esi
   42eb0:	48 8d 05 5e 1d 00 00 	lea    0x1d5e(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42eb7:	48 89 c7             	mov    %rax,%rdi
   42eba:	e8 fb fa ff ff       	call   429ba <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42ebf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ec3:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ec8:	48 85 c0             	test   %rax,%rax
   42ecb:	74 1e                	je     42eeb <virtual_memory_map+0x1ad>
   42ecd:	48 8d 05 d4 1f 00 00 	lea    0x1fd4(%rip),%rax        # 44ea8 <complex_keymap+0x3c8>
   42ed4:	48 89 c2             	mov    %rax,%rdx
   42ed7:	be 6f 00 00 00       	mov    $0x6f,%esi
   42edc:	48 8d 05 32 1d 00 00 	lea    0x1d32(%rip),%rax        # 44c15 <complex_keymap+0x135>
   42ee3:	48 89 c7             	mov    %rax,%rdi
   42ee6:	e8 cf fa ff ff       	call   429ba <assert_fail>

    int last_index123 = -1;
   42eeb:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42ef2:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   42ef9:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42efa:	e9 ed 00 00 00       	jmp    42fec <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42eff:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42f03:	48 c1 e8 15          	shr    $0x15,%rax
   42f07:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   42f0a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42f0d:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   42f10:	74 20                	je     42f32 <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   42f12:	8b 55 bc             	mov    -0x44(%rbp),%edx
   42f15:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   42f19:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f1d:	48 89 ce             	mov    %rcx,%rsi
   42f20:	48 89 c7             	mov    %rax,%rdi
   42f23:	e8 d6 00 00 00       	call   42ffe <lookup_l1pagetable>
   42f28:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   42f2c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42f2f:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42f32:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42f35:	48 98                	cltq   
   42f37:	83 e0 01             	and    $0x1,%eax
   42f3a:	48 85 c0             	test   %rax,%rax
   42f3d:	74 37                	je     42f76 <virtual_memory_map+0x238>
   42f3f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   42f44:	74 30                	je     42f76 <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   42f46:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42f4a:	be 03 00 00 00       	mov    $0x3,%esi
   42f4f:	48 89 c7             	mov    %rax,%rdi
   42f52:	e8 da fa ff ff       	call   42a31 <pageindex>
   42f57:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   42f5a:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42f5d:	48 98                	cltq   
   42f5f:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   42f63:	48 89 c1             	mov    %rax,%rcx
   42f66:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f6a:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42f6d:	48 63 d2             	movslq %edx,%rdx
   42f70:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42f74:	eb 5e                	jmp    42fd4 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   42f76:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   42f7b:	74 2a                	je     42fa7 <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   42f7d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42f81:	be 03 00 00 00       	mov    $0x3,%esi
   42f86:	48 89 c7             	mov    %rax,%rdi
   42f89:	e8 a3 fa ff ff       	call   42a31 <pageindex>
   42f8e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   42f91:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42f94:	48 63 c8             	movslq %eax,%rcx
   42f97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f9b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42f9e:	48 63 d2             	movslq %edx,%rdx
   42fa1:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42fa5:	eb 2d                	jmp    42fd4 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   42fa7:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42faa:	48 98                	cltq   
   42fac:	83 e0 01             	and    $0x1,%eax
   42faf:	48 85 c0             	test   %rax,%rax
   42fb2:	74 20                	je     42fd4 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42fb4:	be 88 00 00 00       	mov    $0x88,%esi
   42fb9:	48 8d 05 10 1f 00 00 	lea    0x1f10(%rip),%rax        # 44ed0 <complex_keymap+0x3f0>
   42fc0:	48 89 c7             	mov    %rax,%rdi
   42fc3:	b8 00 00 00 00       	mov    $0x0,%eax
   42fc8:	e8 92 f6 ff ff       	call   4265f <log_printf>
            return -1;
   42fcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42fd2:	eb 28                	jmp    42ffc <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42fd4:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   42fdb:	00 
   42fdc:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   42fe3:	00 
   42fe4:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   42feb:	00 
   42fec:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   42ff1:	0f 85 08 ff ff ff    	jne    42eff <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   42ff7:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42ffc:	c9                   	leave  
   42ffd:	c3                   	ret    

0000000000042ffe <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42ffe:	f3 0f 1e fa          	endbr64 
   43002:	55                   	push   %rbp
   43003:	48 89 e5             	mov    %rsp,%rbp
   43006:	48 83 ec 40          	sub    $0x40,%rsp
   4300a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4300e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43012:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   43015:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43019:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   4301d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   43024:	e9 4f 01 00 00       	jmp    43178 <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
                int index = PAGEINDEX(va, i); // Get the index for the current level
   43029:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4302c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43030:	89 d6                	mov    %edx,%esi
   43032:	48 89 c7             	mov    %rax,%rdi
   43035:	e8 f7 f9 ff ff       	call   42a31 <pageindex>
   4303a:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   4303d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43041:	8b 55 f0             	mov    -0x10(%rbp),%edx
   43044:	48 63 d2             	movslq %edx,%rdx
   43047:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4304b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   4304f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43053:	83 e0 01             	and    $0x1,%eax
   43056:	48 85 c0             	test   %rax,%rax
   43059:	75 6d                	jne    430c8 <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   4305b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4305e:	8d 48 02             	lea    0x2(%rax),%ecx
   43061:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43065:	25 ff 0f 00 00       	and    $0xfff,%eax
   4306a:	48 89 c2             	mov    %rax,%rdx
   4306d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43071:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43077:	48 89 c6             	mov    %rax,%rsi
   4307a:	48 8d 05 97 1e 00 00 	lea    0x1e97(%rip),%rax        # 44f18 <complex_keymap+0x438>
   43081:	48 89 c7             	mov    %rax,%rdi
   43084:	b8 00 00 00 00       	mov    $0x0,%eax
   43089:	e8 d1 f5 ff ff       	call   4265f <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   4308e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43091:	48 98                	cltq   
   43093:	83 e0 01             	and    $0x1,%eax
   43096:	48 85 c0             	test   %rax,%rax
   43099:	75 0a                	jne    430a5 <lookup_l1pagetable+0xa7>
                return NULL;
   4309b:	b8 00 00 00 00       	mov    $0x0,%eax
   430a0:	e9 e1 00 00 00       	jmp    43186 <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   430a5:	be ad 00 00 00       	mov    $0xad,%esi
   430aa:	48 8d 05 cf 1e 00 00 	lea    0x1ecf(%rip),%rax        # 44f80 <complex_keymap+0x4a0>
   430b1:	48 89 c7             	mov    %rax,%rdi
   430b4:	b8 00 00 00 00       	mov    $0x0,%eax
   430b9:	e8 a1 f5 ff ff       	call   4265f <log_printf>
            return NULL;
   430be:	b8 00 00 00 00       	mov    $0x0,%eax
   430c3:	e9 be 00 00 00       	jmp    43186 <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   430c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430cc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   430d2:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   430d8:	76 1e                	jbe    430f8 <lookup_l1pagetable+0xfa>
   430da:	48 8d 05 e7 1e 00 00 	lea    0x1ee7(%rip),%rax        # 44fc8 <complex_keymap+0x4e8>
   430e1:	48 89 c2             	mov    %rax,%rdx
   430e4:	be b2 00 00 00       	mov    $0xb2,%esi
   430e9:	48 8d 05 25 1b 00 00 	lea    0x1b25(%rip),%rax        # 44c15 <complex_keymap+0x135>
   430f0:	48 89 c7             	mov    %rax,%rdi
   430f3:	e8 c2 f8 ff ff       	call   429ba <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   430f8:	8b 45 cc             	mov    -0x34(%rbp),%eax
   430fb:	48 98                	cltq   
   430fd:	83 e0 02             	and    $0x2,%eax
   43100:	48 85 c0             	test   %rax,%rax
   43103:	74 2a                	je     4312f <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   43105:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43109:	83 e0 02             	and    $0x2,%eax
   4310c:	48 85 c0             	test   %rax,%rax
   4310f:	75 1e                	jne    4312f <lookup_l1pagetable+0x131>
   43111:	48 8d 05 d0 1e 00 00 	lea    0x1ed0(%rip),%rax        # 44fe8 <complex_keymap+0x508>
   43118:	48 89 c2             	mov    %rax,%rdx
   4311b:	be b4 00 00 00       	mov    $0xb4,%esi
   43120:	48 8d 05 ee 1a 00 00 	lea    0x1aee(%rip),%rax        # 44c15 <complex_keymap+0x135>
   43127:	48 89 c7             	mov    %rax,%rdi
   4312a:	e8 8b f8 ff ff       	call   429ba <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   4312f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43132:	48 98                	cltq   
   43134:	83 e0 04             	and    $0x4,%eax
   43137:	48 85 c0             	test   %rax,%rax
   4313a:	74 2a                	je     43166 <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   4313c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43140:	83 e0 04             	and    $0x4,%eax
   43143:	48 85 c0             	test   %rax,%rax
   43146:	75 1e                	jne    43166 <lookup_l1pagetable+0x168>
   43148:	48 8d 05 a4 1e 00 00 	lea    0x1ea4(%rip),%rax        # 44ff3 <complex_keymap+0x513>
   4314f:	48 89 c2             	mov    %rax,%rdx
   43152:	be b7 00 00 00       	mov    $0xb7,%esi
   43157:	48 8d 05 b7 1a 00 00 	lea    0x1ab7(%rip),%rax        # 44c15 <complex_keymap+0x135>
   4315e:	48 89 c7             	mov    %rax,%rdi
   43161:	e8 54 f8 ff ff       	call   429ba <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43166:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4316a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43170:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   43174:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   43178:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   4317c:	0f 8e a7 fe ff ff    	jle    43029 <lookup_l1pagetable+0x2b>
    }
    return pt;
   43182:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43186:	c9                   	leave  
   43187:	c3                   	ret    

0000000000043188 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   43188:	f3 0f 1e fa          	endbr64 
   4318c:	55                   	push   %rbp
   4318d:	48 89 e5             	mov    %rsp,%rbp
   43190:	48 83 ec 50          	sub    $0x50,%rsp
   43194:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43198:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   4319c:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   431a0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   431a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   431a8:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   431af:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   431b0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   431b7:	eb 41                	jmp    431fa <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   431b9:	8b 55 ec             	mov    -0x14(%rbp),%edx
   431bc:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   431c0:	89 d6                	mov    %edx,%esi
   431c2:	48 89 c7             	mov    %rax,%rdi
   431c5:	e8 67 f8 ff ff       	call   42a31 <pageindex>
   431ca:	89 c2                	mov    %eax,%edx
   431cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431d0:	48 63 d2             	movslq %edx,%rdx
   431d3:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   431d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431db:	83 e0 06             	and    $0x6,%eax
   431de:	48 f7 d0             	not    %rax
   431e1:	48 21 d0             	and    %rdx,%rax
   431e4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   431e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431ec:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   431f2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   431f6:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   431fa:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   431fe:	7f 0c                	jg     4320c <virtual_memory_lookup+0x84>
   43200:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43204:	83 e0 01             	and    $0x1,%eax
   43207:	48 85 c0             	test   %rax,%rax
   4320a:	75 ad                	jne    431b9 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   4320c:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43213:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   4321a:	ff 
   4321b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   43222:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43226:	83 e0 01             	and    $0x1,%eax
   43229:	48 85 c0             	test   %rax,%rax
   4322c:	74 34                	je     43262 <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   4322e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43232:	48 c1 e8 0c          	shr    $0xc,%rax
   43236:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43239:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4323d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43243:	48 89 c2             	mov    %rax,%rdx
   43246:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4324a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4324f:	48 09 d0             	or     %rdx,%rax
   43252:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   43256:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4325a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4325f:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   43262:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43266:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4326a:	48 89 10             	mov    %rdx,(%rax)
   4326d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   43271:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43275:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43279:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   4327d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43281:	c9                   	leave  
   43282:	c3                   	ret    

0000000000043283 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   43283:	f3 0f 1e fa          	endbr64 
   43287:	55                   	push   %rbp
   43288:	48 89 e5             	mov    %rsp,%rbp
   4328b:	48 83 ec 40          	sub    $0x40,%rsp
   4328f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43293:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   43296:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   4329a:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   432a1:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   432a5:	78 08                	js     432af <program_load+0x2c>
   432a7:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   432aa:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   432ad:	7c 1e                	jl     432cd <program_load+0x4a>
   432af:	48 8d 05 4a 1d 00 00 	lea    0x1d4a(%rip),%rax        # 45000 <complex_keymap+0x520>
   432b6:	48 89 c2             	mov    %rax,%rdx
   432b9:	be 37 00 00 00       	mov    $0x37,%esi
   432be:	48 8d 05 6b 1d 00 00 	lea    0x1d6b(%rip),%rax        # 45030 <complex_keymap+0x550>
   432c5:	48 89 c7             	mov    %rax,%rdi
   432c8:	e8 ed f6 ff ff       	call   429ba <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   432cd:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   432d0:	48 98                	cltq   
   432d2:	48 c1 e0 04          	shl    $0x4,%rax
   432d6:	48 89 c2             	mov    %rax,%rdx
   432d9:	48 8d 05 40 2d 00 00 	lea    0x2d40(%rip),%rax        # 46020 <ramimages>
   432e0:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   432e4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   432e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ec:	8b 00                	mov    (%rax),%eax
   432ee:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   432f3:	74 1e                	je     43313 <program_load+0x90>
   432f5:	48 8d 05 46 1d 00 00 	lea    0x1d46(%rip),%rax        # 45042 <complex_keymap+0x562>
   432fc:	48 89 c2             	mov    %rax,%rdx
   432ff:	be 39 00 00 00       	mov    $0x39,%esi
   43304:	48 8d 05 25 1d 00 00 	lea    0x1d25(%rip),%rax        # 45030 <complex_keymap+0x550>
   4330b:	48 89 c7             	mov    %rax,%rdi
   4330e:	e8 a7 f6 ff ff       	call   429ba <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43313:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43317:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4331b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4331f:	48 01 d0             	add    %rdx,%rax
   43322:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43326:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4332d:	e9 94 00 00 00       	jmp    433c6 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43332:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43335:	48 63 d0             	movslq %eax,%rdx
   43338:	48 89 d0             	mov    %rdx,%rax
   4333b:	48 c1 e0 03          	shl    $0x3,%rax
   4333f:	48 29 d0             	sub    %rdx,%rax
   43342:	48 c1 e0 03          	shl    $0x3,%rax
   43346:	48 89 c2             	mov    %rax,%rdx
   43349:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4334d:	48 01 d0             	add    %rdx,%rax
   43350:	8b 00                	mov    (%rax),%eax
   43352:	83 f8 01             	cmp    $0x1,%eax
   43355:	75 6b                	jne    433c2 <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   43357:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4335a:	48 63 d0             	movslq %eax,%rdx
   4335d:	48 89 d0             	mov    %rdx,%rax
   43360:	48 c1 e0 03          	shl    $0x3,%rax
   43364:	48 29 d0             	sub    %rdx,%rax
   43367:	48 c1 e0 03          	shl    $0x3,%rax
   4336b:	48 89 c2             	mov    %rax,%rdx
   4336e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43372:	48 01 d0             	add    %rdx,%rax
   43375:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43379:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4337d:	48 01 d0             	add    %rdx,%rax
   43380:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   43384:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43387:	48 63 d0             	movslq %eax,%rdx
   4338a:	48 89 d0             	mov    %rdx,%rax
   4338d:	48 c1 e0 03          	shl    $0x3,%rax
   43391:	48 29 d0             	sub    %rdx,%rax
   43394:	48 c1 e0 03          	shl    $0x3,%rax
   43398:	48 89 c2             	mov    %rax,%rdx
   4339b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4339f:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   433a3:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   433a7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   433ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433af:	48 89 c7             	mov    %rax,%rdi
   433b2:	e8 3d 00 00 00       	call   433f4 <program_load_segment>
   433b7:	85 c0                	test   %eax,%eax
   433b9:	79 07                	jns    433c2 <program_load+0x13f>
                return -1;
   433bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   433c0:	eb 30                	jmp    433f2 <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   433c2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   433c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433ca:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   433ce:	0f b7 c0             	movzwl %ax,%eax
   433d1:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   433d4:	0f 8c 58 ff ff ff    	jl     43332 <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   433da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433de:	48 8b 50 18          	mov    0x18(%rax),%rdx
   433e2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433e6:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   433ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
   433f2:	c9                   	leave  
   433f3:	c3                   	ret    

00000000000433f4 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   433f4:	f3 0f 1e fa          	endbr64 
   433f8:	55                   	push   %rbp
   433f9:	48 89 e5             	mov    %rsp,%rbp
   433fc:	48 83 ec 40          	sub    $0x40,%rsp
   43400:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43404:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43408:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   4340c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   43410:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43414:	48 8b 40 10          	mov    0x10(%rax),%rax
   43418:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4341c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43420:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43424:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43428:	48 01 d0             	add    %rdx,%rax
   4342b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4342f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43433:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43437:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4343b:	48 01 d0             	add    %rdx,%rax
   4343e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43442:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   43449:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4344a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4344e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43452:	e9 81 00 00 00       	jmp    434d8 <program_load_segment+0xe4>
        if (assign_physical_page(addr, p->p_pid) < 0
   43457:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4345b:	8b 00                	mov    (%rax),%eax
   4345d:	0f be d0             	movsbl %al,%edx
   43460:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43464:	89 d6                	mov    %edx,%esi
   43466:	48 89 c7             	mov    %rax,%rdi
   43469:	e8 81 d2 ff ff       	call   406ef <assign_physical_page>
   4346e:	85 c0                	test   %eax,%eax
   43470:	78 2a                	js     4349c <program_load_segment+0xa8>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   43472:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43476:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4347d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43481:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43485:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4348b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43490:	48 89 c7             	mov    %rax,%rdi
   43493:	e8 a6 f8 ff ff       	call   42d3e <virtual_memory_map>
   43498:	85 c0                	test   %eax,%eax
   4349a:	79 34                	jns    434d0 <program_load_segment+0xdc>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   4349c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434a0:	8b 00                	mov    (%rax),%eax
   434a2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   434a6:	49 89 d0             	mov    %rdx,%r8
   434a9:	89 c1                	mov    %eax,%ecx
   434ab:	48 8d 05 ae 1b 00 00 	lea    0x1bae(%rip),%rax        # 45060 <complex_keymap+0x580>
   434b2:	48 89 c2             	mov    %rax,%rdx
   434b5:	be 00 c0 00 00       	mov    $0xc000,%esi
   434ba:	bf e0 06 00 00       	mov    $0x6e0,%edi
   434bf:	b8 00 00 00 00       	mov    $0x0,%eax
   434c4:	e8 c5 0f 00 00       	call   4448e <console_printf>
            return -1;
   434c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   434ce:	eb 77                	jmp    43547 <program_load_segment+0x153>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   434d0:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   434d7:	00 
   434d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434dc:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   434e0:	0f 82 71 ff ff ff    	jb     43457 <program_load_segment+0x63>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   434e6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434ea:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   434f1:	48 89 c7             	mov    %rax,%rdi
   434f4:	e8 d3 f6 ff ff       	call   42bcc <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   434f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434fd:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   43501:	48 89 c2             	mov    %rax,%rdx
   43504:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43508:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4350c:	48 89 ce             	mov    %rcx,%rsi
   4350f:	48 89 c7             	mov    %rax,%rdi
   43512:	e8 32 00 00 00       	call   43549 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43517:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4351b:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4351f:	48 89 c2             	mov    %rax,%rdx
   43522:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43526:	be 00 00 00 00       	mov    $0x0,%esi
   4352b:	48 89 c7             	mov    %rax,%rdi
   4352e:	e8 1c 01 00 00       	call   4364f <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43533:	48 8b 05 c6 1a 01 00 	mov    0x11ac6(%rip),%rax        # 55000 <kernel_pagetable>
   4353a:	48 89 c7             	mov    %rax,%rdi
   4353d:	e8 8a f6 ff ff       	call   42bcc <set_pagetable>
    return 0;
   43542:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43547:	c9                   	leave  
   43548:	c3                   	ret    

0000000000043549 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43549:	f3 0f 1e fa          	endbr64 
   4354d:	55                   	push   %rbp
   4354e:	48 89 e5             	mov    %rsp,%rbp
   43551:	48 83 ec 28          	sub    $0x28,%rsp
   43555:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43559:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4355d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43561:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43565:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43569:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4356d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43571:	eb 1c                	jmp    4358f <memcpy+0x46>
        *d = *s;
   43573:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43577:	0f b6 10             	movzbl (%rax),%edx
   4357a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4357e:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43580:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43585:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4358a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   4358f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43594:	75 dd                	jne    43573 <memcpy+0x2a>
    }
    return dst;
   43596:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4359a:	c9                   	leave  
   4359b:	c3                   	ret    

000000000004359c <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   4359c:	f3 0f 1e fa          	endbr64 
   435a0:	55                   	push   %rbp
   435a1:	48 89 e5             	mov    %rsp,%rbp
   435a4:	48 83 ec 28          	sub    $0x28,%rsp
   435a8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   435ac:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   435b0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   435b4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   435bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435c0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   435c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435c8:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   435cc:	73 6a                	jae    43638 <memmove+0x9c>
   435ce:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   435d2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435d6:	48 01 d0             	add    %rdx,%rax
   435d9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   435dd:	73 59                	jae    43638 <memmove+0x9c>
        s += n, d += n;
   435df:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435e3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   435e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435eb:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   435ef:	eb 17                	jmp    43608 <memmove+0x6c>
            *--d = *--s;
   435f1:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   435f6:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   435fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435ff:	0f b6 10             	movzbl (%rax),%edx
   43602:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43606:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43608:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4360c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43610:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43614:	48 85 c0             	test   %rax,%rax
   43617:	75 d8                	jne    435f1 <memmove+0x55>
    if (s < d && s + n > d) {
   43619:	eb 2e                	jmp    43649 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   4361b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4361f:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43623:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43627:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4362b:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4362f:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43633:	0f b6 12             	movzbl (%rdx),%edx
   43636:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43638:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4363c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43640:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43644:	48 85 c0             	test   %rax,%rax
   43647:	75 d2                	jne    4361b <memmove+0x7f>
        }
    }
    return dst;
   43649:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4364d:	c9                   	leave  
   4364e:	c3                   	ret    

000000000004364f <memset>:

void* memset(void* v, int c, size_t n) {
   4364f:	f3 0f 1e fa          	endbr64 
   43653:	55                   	push   %rbp
   43654:	48 89 e5             	mov    %rsp,%rbp
   43657:	48 83 ec 28          	sub    $0x28,%rsp
   4365b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4365f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43662:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43666:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4366a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4366e:	eb 15                	jmp    43685 <memset+0x36>
        *p = c;
   43670:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43673:	89 c2                	mov    %eax,%edx
   43675:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43679:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4367b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43680:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43685:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4368a:	75 e4                	jne    43670 <memset+0x21>
    }
    return v;
   4368c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43690:	c9                   	leave  
   43691:	c3                   	ret    

0000000000043692 <strlen>:

size_t strlen(const char* s) {
   43692:	f3 0f 1e fa          	endbr64 
   43696:	55                   	push   %rbp
   43697:	48 89 e5             	mov    %rsp,%rbp
   4369a:	48 83 ec 18          	sub    $0x18,%rsp
   4369e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   436a2:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   436a9:	00 
   436aa:	eb 0a                	jmp    436b6 <strlen+0x24>
        ++n;
   436ac:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   436b1:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   436b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436ba:	0f b6 00             	movzbl (%rax),%eax
   436bd:	84 c0                	test   %al,%al
   436bf:	75 eb                	jne    436ac <strlen+0x1a>
    }
    return n;
   436c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   436c5:	c9                   	leave  
   436c6:	c3                   	ret    

00000000000436c7 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   436c7:	f3 0f 1e fa          	endbr64 
   436cb:	55                   	push   %rbp
   436cc:	48 89 e5             	mov    %rsp,%rbp
   436cf:	48 83 ec 20          	sub    $0x20,%rsp
   436d3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   436d7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   436db:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   436e2:	00 
   436e3:	eb 0a                	jmp    436ef <strnlen+0x28>
        ++n;
   436e5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   436ea:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   436ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436f3:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   436f7:	74 0b                	je     43704 <strnlen+0x3d>
   436f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436fd:	0f b6 00             	movzbl (%rax),%eax
   43700:	84 c0                	test   %al,%al
   43702:	75 e1                	jne    436e5 <strnlen+0x1e>
    }
    return n;
   43704:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43708:	c9                   	leave  
   43709:	c3                   	ret    

000000000004370a <strcpy>:

char* strcpy(char* dst, const char* src) {
   4370a:	f3 0f 1e fa          	endbr64 
   4370e:	55                   	push   %rbp
   4370f:	48 89 e5             	mov    %rsp,%rbp
   43712:	48 83 ec 20          	sub    $0x20,%rsp
   43716:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4371a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   4371e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43722:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43726:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4372a:	48 8d 42 01          	lea    0x1(%rdx),%rax
   4372e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43732:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43736:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4373a:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   4373e:	0f b6 12             	movzbl (%rdx),%edx
   43741:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43743:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43747:	48 83 e8 01          	sub    $0x1,%rax
   4374b:	0f b6 00             	movzbl (%rax),%eax
   4374e:	84 c0                	test   %al,%al
   43750:	75 d4                	jne    43726 <strcpy+0x1c>
    return dst;
   43752:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43756:	c9                   	leave  
   43757:	c3                   	ret    

0000000000043758 <strcmp>:

int strcmp(const char* a, const char* b) {
   43758:	f3 0f 1e fa          	endbr64 
   4375c:	55                   	push   %rbp
   4375d:	48 89 e5             	mov    %rsp,%rbp
   43760:	48 83 ec 10          	sub    $0x10,%rsp
   43764:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43768:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   4376c:	eb 0a                	jmp    43778 <strcmp+0x20>
        ++a, ++b;
   4376e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43773:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43778:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4377c:	0f b6 00             	movzbl (%rax),%eax
   4377f:	84 c0                	test   %al,%al
   43781:	74 1d                	je     437a0 <strcmp+0x48>
   43783:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43787:	0f b6 00             	movzbl (%rax),%eax
   4378a:	84 c0                	test   %al,%al
   4378c:	74 12                	je     437a0 <strcmp+0x48>
   4378e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43792:	0f b6 10             	movzbl (%rax),%edx
   43795:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43799:	0f b6 00             	movzbl (%rax),%eax
   4379c:	38 c2                	cmp    %al,%dl
   4379e:	74 ce                	je     4376e <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   437a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437a4:	0f b6 00             	movzbl (%rax),%eax
   437a7:	89 c2                	mov    %eax,%edx
   437a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437ad:	0f b6 00             	movzbl (%rax),%eax
   437b0:	38 c2                	cmp    %al,%dl
   437b2:	0f 97 c0             	seta   %al
   437b5:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   437b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437bc:	0f b6 00             	movzbl (%rax),%eax
   437bf:	89 c1                	mov    %eax,%ecx
   437c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437c5:	0f b6 00             	movzbl (%rax),%eax
   437c8:	38 c1                	cmp    %al,%cl
   437ca:	0f 92 c0             	setb   %al
   437cd:	0f b6 c8             	movzbl %al,%ecx
   437d0:	89 d0                	mov    %edx,%eax
   437d2:	29 c8                	sub    %ecx,%eax
}
   437d4:	c9                   	leave  
   437d5:	c3                   	ret    

00000000000437d6 <strchr>:

char* strchr(const char* s, int c) {
   437d6:	f3 0f 1e fa          	endbr64 
   437da:	55                   	push   %rbp
   437db:	48 89 e5             	mov    %rsp,%rbp
   437de:	48 83 ec 10          	sub    $0x10,%rsp
   437e2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   437e6:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   437e9:	eb 05                	jmp    437f0 <strchr+0x1a>
        ++s;
   437eb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   437f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437f4:	0f b6 00             	movzbl (%rax),%eax
   437f7:	84 c0                	test   %al,%al
   437f9:	74 0e                	je     43809 <strchr+0x33>
   437fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437ff:	0f b6 00             	movzbl (%rax),%eax
   43802:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43805:	38 d0                	cmp    %dl,%al
   43807:	75 e2                	jne    437eb <strchr+0x15>
    }
    if (*s == (char) c) {
   43809:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4380d:	0f b6 00             	movzbl (%rax),%eax
   43810:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43813:	38 d0                	cmp    %dl,%al
   43815:	75 06                	jne    4381d <strchr+0x47>
        return (char*) s;
   43817:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4381b:	eb 05                	jmp    43822 <strchr+0x4c>
    } else {
        return NULL;
   4381d:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43822:	c9                   	leave  
   43823:	c3                   	ret    

0000000000043824 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43824:	f3 0f 1e fa          	endbr64 
   43828:	55                   	push   %rbp
   43829:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   4382c:	8b 05 ce 77 01 00    	mov    0x177ce(%rip),%eax        # 5b000 <rand_seed_set>
   43832:	85 c0                	test   %eax,%eax
   43834:	75 0a                	jne    43840 <rand+0x1c>
        srand(819234718U);
   43836:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   4383b:	e8 24 00 00 00       	call   43864 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43840:	8b 05 be 77 01 00    	mov    0x177be(%rip),%eax        # 5b004 <rand_seed>
   43846:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   4384c:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43851:	89 05 ad 77 01 00    	mov    %eax,0x177ad(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   43857:	8b 05 a7 77 01 00    	mov    0x177a7(%rip),%eax        # 5b004 <rand_seed>
   4385d:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43862:	5d                   	pop    %rbp
   43863:	c3                   	ret    

0000000000043864 <srand>:

void srand(unsigned seed) {
   43864:	f3 0f 1e fa          	endbr64 
   43868:	55                   	push   %rbp
   43869:	48 89 e5             	mov    %rsp,%rbp
   4386c:	48 83 ec 08          	sub    $0x8,%rsp
   43870:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43873:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43876:	89 05 88 77 01 00    	mov    %eax,0x17788(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   4387c:	c7 05 7a 77 01 00 01 	movl   $0x1,0x1777a(%rip)        # 5b000 <rand_seed_set>
   43883:	00 00 00 
}
   43886:	90                   	nop
   43887:	c9                   	leave  
   43888:	c3                   	ret    

0000000000043889 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43889:	f3 0f 1e fa          	endbr64 
   4388d:	55                   	push   %rbp
   4388e:	48 89 e5             	mov    %rsp,%rbp
   43891:	48 83 ec 28          	sub    $0x28,%rsp
   43895:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43899:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4389d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   438a0:	48 8d 05 f9 18 00 00 	lea    0x18f9(%rip),%rax        # 451a0 <upper_digits.1>
   438a7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   438ab:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   438af:	79 0e                	jns    438bf <fill_numbuf+0x36>
        digits = lower_digits;
   438b1:	48 8d 05 08 19 00 00 	lea    0x1908(%rip),%rax        # 451c0 <lower_digits.0>
   438b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   438bc:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   438bf:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   438c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438c8:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   438cb:	8b 45 dc             	mov    -0x24(%rbp),%eax
   438ce:	48 63 c8             	movslq %eax,%rcx
   438d1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   438d5:	ba 00 00 00 00       	mov    $0x0,%edx
   438da:	48 f7 f1             	div    %rcx
   438dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438e1:	48 01 d0             	add    %rdx,%rax
   438e4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   438e9:	0f b6 10             	movzbl (%rax),%edx
   438ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438f0:	88 10                	mov    %dl,(%rax)
        val /= base;
   438f2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   438f5:	48 63 f0             	movslq %eax,%rsi
   438f8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   438fc:	ba 00 00 00 00       	mov    $0x0,%edx
   43901:	48 f7 f6             	div    %rsi
   43904:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43908:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4390d:	75 bc                	jne    438cb <fill_numbuf+0x42>
    return numbuf_end;
   4390f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43913:	c9                   	leave  
   43914:	c3                   	ret    

0000000000043915 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43915:	f3 0f 1e fa          	endbr64 
   43919:	55                   	push   %rbp
   4391a:	48 89 e5             	mov    %rsp,%rbp
   4391d:	53                   	push   %rbx
   4391e:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43925:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   4392c:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43932:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43939:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43940:	e9 bd 09 00 00       	jmp    44302 <printer_vprintf+0x9ed>
        if (*format != '%') {
   43945:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4394c:	0f b6 00             	movzbl (%rax),%eax
   4394f:	3c 25                	cmp    $0x25,%al
   43951:	74 31                	je     43984 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   43953:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4395a:	4c 8b 00             	mov    (%rax),%r8
   4395d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43964:	0f b6 00             	movzbl (%rax),%eax
   43967:	0f b6 c8             	movzbl %al,%ecx
   4396a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43970:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43977:	89 ce                	mov    %ecx,%esi
   43979:	48 89 c7             	mov    %rax,%rdi
   4397c:	41 ff d0             	call   *%r8
            continue;
   4397f:	e9 76 09 00 00       	jmp    442fa <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   43984:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   4398b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43992:	01 
   43993:	eb 4d                	jmp    439e2 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   43995:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4399c:	0f b6 00             	movzbl (%rax),%eax
   4399f:	0f be c0             	movsbl %al,%eax
   439a2:	89 c6                	mov    %eax,%esi
   439a4:	48 8d 05 f5 16 00 00 	lea    0x16f5(%rip),%rax        # 450a0 <flag_chars>
   439ab:	48 89 c7             	mov    %rax,%rdi
   439ae:	e8 23 fe ff ff       	call   437d6 <strchr>
   439b3:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   439b7:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   439bc:	74 34                	je     439f2 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   439be:	48 8d 15 db 16 00 00 	lea    0x16db(%rip),%rdx        # 450a0 <flag_chars>
   439c5:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   439c9:	48 29 d0             	sub    %rdx,%rax
   439cc:	ba 01 00 00 00       	mov    $0x1,%edx
   439d1:	89 c1                	mov    %eax,%ecx
   439d3:	d3 e2                	shl    %cl,%edx
   439d5:	89 d0                	mov    %edx,%eax
   439d7:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   439da:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   439e1:	01 
   439e2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439e9:	0f b6 00             	movzbl (%rax),%eax
   439ec:	84 c0                	test   %al,%al
   439ee:	75 a5                	jne    43995 <printer_vprintf+0x80>
   439f0:	eb 01                	jmp    439f3 <printer_vprintf+0xde>
            } else {
                break;
   439f2:	90                   	nop
            }
        }

        // process width
        int width = -1;
   439f3:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   439fa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a01:	0f b6 00             	movzbl (%rax),%eax
   43a04:	3c 30                	cmp    $0x30,%al
   43a06:	7e 67                	jle    43a6f <printer_vprintf+0x15a>
   43a08:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a0f:	0f b6 00             	movzbl (%rax),%eax
   43a12:	3c 39                	cmp    $0x39,%al
   43a14:	7f 59                	jg     43a6f <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43a16:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43a1d:	eb 2e                	jmp    43a4d <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   43a1f:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43a22:	89 d0                	mov    %edx,%eax
   43a24:	c1 e0 02             	shl    $0x2,%eax
   43a27:	01 d0                	add    %edx,%eax
   43a29:	01 c0                	add    %eax,%eax
   43a2b:	89 c1                	mov    %eax,%ecx
   43a2d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a34:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43a38:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43a3f:	0f b6 00             	movzbl (%rax),%eax
   43a42:	0f be c0             	movsbl %al,%eax
   43a45:	01 c8                	add    %ecx,%eax
   43a47:	83 e8 30             	sub    $0x30,%eax
   43a4a:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43a4d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a54:	0f b6 00             	movzbl (%rax),%eax
   43a57:	3c 2f                	cmp    $0x2f,%al
   43a59:	0f 8e 85 00 00 00    	jle    43ae4 <printer_vprintf+0x1cf>
   43a5f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a66:	0f b6 00             	movzbl (%rax),%eax
   43a69:	3c 39                	cmp    $0x39,%al
   43a6b:	7e b2                	jle    43a1f <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   43a6d:	eb 75                	jmp    43ae4 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   43a6f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a76:	0f b6 00             	movzbl (%rax),%eax
   43a79:	3c 2a                	cmp    $0x2a,%al
   43a7b:	75 68                	jne    43ae5 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   43a7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a84:	8b 00                	mov    (%rax),%eax
   43a86:	83 f8 2f             	cmp    $0x2f,%eax
   43a89:	77 30                	ja     43abb <printer_vprintf+0x1a6>
   43a8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a92:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43a96:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a9d:	8b 00                	mov    (%rax),%eax
   43a9f:	89 c0                	mov    %eax,%eax
   43aa1:	48 01 d0             	add    %rdx,%rax
   43aa4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43aab:	8b 12                	mov    (%rdx),%edx
   43aad:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43ab0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ab7:	89 0a                	mov    %ecx,(%rdx)
   43ab9:	eb 1a                	jmp    43ad5 <printer_vprintf+0x1c0>
   43abb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ac2:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ac6:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43aca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ad1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ad5:	8b 00                	mov    (%rax),%eax
   43ad7:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43ada:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43ae1:	01 
   43ae2:	eb 01                	jmp    43ae5 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   43ae4:	90                   	nop
        }

        // process precision
        int precision = -1;
   43ae5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43aec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43af3:	0f b6 00             	movzbl (%rax),%eax
   43af6:	3c 2e                	cmp    $0x2e,%al
   43af8:	0f 85 00 01 00 00    	jne    43bfe <printer_vprintf+0x2e9>
            ++format;
   43afe:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43b05:	01 
            if (*format >= '0' && *format <= '9') {
   43b06:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b0d:	0f b6 00             	movzbl (%rax),%eax
   43b10:	3c 2f                	cmp    $0x2f,%al
   43b12:	7e 67                	jle    43b7b <printer_vprintf+0x266>
   43b14:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b1b:	0f b6 00             	movzbl (%rax),%eax
   43b1e:	3c 39                	cmp    $0x39,%al
   43b20:	7f 59                	jg     43b7b <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43b22:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43b29:	eb 2e                	jmp    43b59 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   43b2b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43b2e:	89 d0                	mov    %edx,%eax
   43b30:	c1 e0 02             	shl    $0x2,%eax
   43b33:	01 d0                	add    %edx,%eax
   43b35:	01 c0                	add    %eax,%eax
   43b37:	89 c1                	mov    %eax,%ecx
   43b39:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b40:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43b44:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43b4b:	0f b6 00             	movzbl (%rax),%eax
   43b4e:	0f be c0             	movsbl %al,%eax
   43b51:	01 c8                	add    %ecx,%eax
   43b53:	83 e8 30             	sub    $0x30,%eax
   43b56:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43b59:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b60:	0f b6 00             	movzbl (%rax),%eax
   43b63:	3c 2f                	cmp    $0x2f,%al
   43b65:	0f 8e 85 00 00 00    	jle    43bf0 <printer_vprintf+0x2db>
   43b6b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b72:	0f b6 00             	movzbl (%rax),%eax
   43b75:	3c 39                	cmp    $0x39,%al
   43b77:	7e b2                	jle    43b2b <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   43b79:	eb 75                	jmp    43bf0 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   43b7b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b82:	0f b6 00             	movzbl (%rax),%eax
   43b85:	3c 2a                	cmp    $0x2a,%al
   43b87:	75 68                	jne    43bf1 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   43b89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b90:	8b 00                	mov    (%rax),%eax
   43b92:	83 f8 2f             	cmp    $0x2f,%eax
   43b95:	77 30                	ja     43bc7 <printer_vprintf+0x2b2>
   43b97:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b9e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ba2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ba9:	8b 00                	mov    (%rax),%eax
   43bab:	89 c0                	mov    %eax,%eax
   43bad:	48 01 d0             	add    %rdx,%rax
   43bb0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bb7:	8b 12                	mov    (%rdx),%edx
   43bb9:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43bbc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bc3:	89 0a                	mov    %ecx,(%rdx)
   43bc5:	eb 1a                	jmp    43be1 <printer_vprintf+0x2cc>
   43bc7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bce:	48 8b 40 08          	mov    0x8(%rax),%rax
   43bd2:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43bd6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bdd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43be1:	8b 00                	mov    (%rax),%eax
   43be3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43be6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43bed:	01 
   43bee:	eb 01                	jmp    43bf1 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   43bf0:	90                   	nop
            }
            if (precision < 0) {
   43bf1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43bf5:	79 07                	jns    43bfe <printer_vprintf+0x2e9>
                precision = 0;
   43bf7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43bfe:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43c05:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43c0c:	00 
        int length = 0;
   43c0d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43c14:	48 8d 05 8b 14 00 00 	lea    0x148b(%rip),%rax        # 450a6 <flag_chars+0x6>
   43c1b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   43c1f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c26:	0f b6 00             	movzbl (%rax),%eax
   43c29:	0f be c0             	movsbl %al,%eax
   43c2c:	83 e8 43             	sub    $0x43,%eax
   43c2f:	83 f8 37             	cmp    $0x37,%eax
   43c32:	0f 87 b6 03 00 00    	ja     43fee <printer_vprintf+0x6d9>
   43c38:	89 c0                	mov    %eax,%eax
   43c3a:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   43c41:	00 
   43c42:	48 8d 05 6b 14 00 00 	lea    0x146b(%rip),%rax        # 450b4 <flag_chars+0x14>
   43c49:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   43c4c:	48 98                	cltq   
   43c4e:	48 8d 15 5f 14 00 00 	lea    0x145f(%rip),%rdx        # 450b4 <flag_chars+0x14>
   43c55:	48 01 d0             	add    %rdx,%rax
   43c58:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   43c5b:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43c62:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43c69:	01 
            goto again;
   43c6a:	eb b3                	jmp    43c1f <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43c6c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43c70:	74 5d                	je     43ccf <printer_vprintf+0x3ba>
   43c72:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c79:	8b 00                	mov    (%rax),%eax
   43c7b:	83 f8 2f             	cmp    $0x2f,%eax
   43c7e:	77 30                	ja     43cb0 <printer_vprintf+0x39b>
   43c80:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c87:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c92:	8b 00                	mov    (%rax),%eax
   43c94:	89 c0                	mov    %eax,%eax
   43c96:	48 01 d0             	add    %rdx,%rax
   43c99:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ca0:	8b 12                	mov    (%rdx),%edx
   43ca2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43ca5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cac:	89 0a                	mov    %ecx,(%rdx)
   43cae:	eb 1a                	jmp    43cca <printer_vprintf+0x3b5>
   43cb0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cb7:	48 8b 40 08          	mov    0x8(%rax),%rax
   43cbb:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43cbf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cc6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43cca:	48 8b 00             	mov    (%rax),%rax
   43ccd:	eb 5c                	jmp    43d2b <printer_vprintf+0x416>
   43ccf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cd6:	8b 00                	mov    (%rax),%eax
   43cd8:	83 f8 2f             	cmp    $0x2f,%eax
   43cdb:	77 30                	ja     43d0d <printer_vprintf+0x3f8>
   43cdd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ce4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ce8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cef:	8b 00                	mov    (%rax),%eax
   43cf1:	89 c0                	mov    %eax,%eax
   43cf3:	48 01 d0             	add    %rdx,%rax
   43cf6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cfd:	8b 12                	mov    (%rdx),%edx
   43cff:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d02:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d09:	89 0a                	mov    %ecx,(%rdx)
   43d0b:	eb 1a                	jmp    43d27 <printer_vprintf+0x412>
   43d0d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d14:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d18:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d1c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d23:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d27:	8b 00                	mov    (%rax),%eax
   43d29:	48 98                	cltq   
   43d2b:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43d2f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43d33:	48 c1 f8 38          	sar    $0x38,%rax
   43d37:	25 80 00 00 00       	and    $0x80,%eax
   43d3c:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43d3f:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43d43:	74 09                	je     43d4e <printer_vprintf+0x439>
   43d45:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43d49:	48 f7 d8             	neg    %rax
   43d4c:	eb 04                	jmp    43d52 <printer_vprintf+0x43d>
   43d4e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43d52:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43d56:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43d59:	83 c8 60             	or     $0x60,%eax
   43d5c:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43d5f:	e9 cf 02 00 00       	jmp    44033 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43d64:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43d68:	74 5d                	je     43dc7 <printer_vprintf+0x4b2>
   43d6a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d71:	8b 00                	mov    (%rax),%eax
   43d73:	83 f8 2f             	cmp    $0x2f,%eax
   43d76:	77 30                	ja     43da8 <printer_vprintf+0x493>
   43d78:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d7f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d83:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d8a:	8b 00                	mov    (%rax),%eax
   43d8c:	89 c0                	mov    %eax,%eax
   43d8e:	48 01 d0             	add    %rdx,%rax
   43d91:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d98:	8b 12                	mov    (%rdx),%edx
   43d9a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d9d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43da4:	89 0a                	mov    %ecx,(%rdx)
   43da6:	eb 1a                	jmp    43dc2 <printer_vprintf+0x4ad>
   43da8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43daf:	48 8b 40 08          	mov    0x8(%rax),%rax
   43db3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43db7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43dbe:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43dc2:	48 8b 00             	mov    (%rax),%rax
   43dc5:	eb 5c                	jmp    43e23 <printer_vprintf+0x50e>
   43dc7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dce:	8b 00                	mov    (%rax),%eax
   43dd0:	83 f8 2f             	cmp    $0x2f,%eax
   43dd3:	77 30                	ja     43e05 <printer_vprintf+0x4f0>
   43dd5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ddc:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43de0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43de7:	8b 00                	mov    (%rax),%eax
   43de9:	89 c0                	mov    %eax,%eax
   43deb:	48 01 d0             	add    %rdx,%rax
   43dee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43df5:	8b 12                	mov    (%rdx),%edx
   43df7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43dfa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e01:	89 0a                	mov    %ecx,(%rdx)
   43e03:	eb 1a                	jmp    43e1f <printer_vprintf+0x50a>
   43e05:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e0c:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e10:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e14:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e1b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e1f:	8b 00                	mov    (%rax),%eax
   43e21:	89 c0                	mov    %eax,%eax
   43e23:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43e27:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43e2b:	e9 03 02 00 00       	jmp    44033 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   43e30:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43e37:	e9 28 ff ff ff       	jmp    43d64 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   43e3c:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43e43:	e9 1c ff ff ff       	jmp    43d64 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43e48:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e4f:	8b 00                	mov    (%rax),%eax
   43e51:	83 f8 2f             	cmp    $0x2f,%eax
   43e54:	77 30                	ja     43e86 <printer_vprintf+0x571>
   43e56:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e5d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e68:	8b 00                	mov    (%rax),%eax
   43e6a:	89 c0                	mov    %eax,%eax
   43e6c:	48 01 d0             	add    %rdx,%rax
   43e6f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e76:	8b 12                	mov    (%rdx),%edx
   43e78:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e7b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e82:	89 0a                	mov    %ecx,(%rdx)
   43e84:	eb 1a                	jmp    43ea0 <printer_vprintf+0x58b>
   43e86:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e8d:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e91:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e95:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e9c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ea0:	48 8b 00             	mov    (%rax),%rax
   43ea3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43ea7:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43eae:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43eb5:	e9 79 01 00 00       	jmp    44033 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   43eba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ec1:	8b 00                	mov    (%rax),%eax
   43ec3:	83 f8 2f             	cmp    $0x2f,%eax
   43ec6:	77 30                	ja     43ef8 <printer_vprintf+0x5e3>
   43ec8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ecf:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ed3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43eda:	8b 00                	mov    (%rax),%eax
   43edc:	89 c0                	mov    %eax,%eax
   43ede:	48 01 d0             	add    %rdx,%rax
   43ee1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ee8:	8b 12                	mov    (%rdx),%edx
   43eea:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43eed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ef4:	89 0a                	mov    %ecx,(%rdx)
   43ef6:	eb 1a                	jmp    43f12 <printer_vprintf+0x5fd>
   43ef8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43eff:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f03:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f07:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f0e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f12:	48 8b 00             	mov    (%rax),%rax
   43f15:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43f19:	e9 15 01 00 00       	jmp    44033 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   43f1e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f25:	8b 00                	mov    (%rax),%eax
   43f27:	83 f8 2f             	cmp    $0x2f,%eax
   43f2a:	77 30                	ja     43f5c <printer_vprintf+0x647>
   43f2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f33:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f37:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f3e:	8b 00                	mov    (%rax),%eax
   43f40:	89 c0                	mov    %eax,%eax
   43f42:	48 01 d0             	add    %rdx,%rax
   43f45:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f4c:	8b 12                	mov    (%rdx),%edx
   43f4e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f51:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f58:	89 0a                	mov    %ecx,(%rdx)
   43f5a:	eb 1a                	jmp    43f76 <printer_vprintf+0x661>
   43f5c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f63:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f67:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f6b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f72:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f76:	8b 00                	mov    (%rax),%eax
   43f78:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43f7e:	e9 77 03 00 00       	jmp    442fa <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   43f83:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43f87:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43f8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f92:	8b 00                	mov    (%rax),%eax
   43f94:	83 f8 2f             	cmp    $0x2f,%eax
   43f97:	77 30                	ja     43fc9 <printer_vprintf+0x6b4>
   43f99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fa0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43fa4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fab:	8b 00                	mov    (%rax),%eax
   43fad:	89 c0                	mov    %eax,%eax
   43faf:	48 01 d0             	add    %rdx,%rax
   43fb2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fb9:	8b 12                	mov    (%rdx),%edx
   43fbb:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43fbe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fc5:	89 0a                	mov    %ecx,(%rdx)
   43fc7:	eb 1a                	jmp    43fe3 <printer_vprintf+0x6ce>
   43fc9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fd0:	48 8b 40 08          	mov    0x8(%rax),%rax
   43fd4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43fd8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fdf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43fe3:	8b 00                	mov    (%rax),%eax
   43fe5:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43fe8:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43fec:	eb 45                	jmp    44033 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   43fee:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43ff2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43ff6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ffd:	0f b6 00             	movzbl (%rax),%eax
   44000:	84 c0                	test   %al,%al
   44002:	74 0c                	je     44010 <printer_vprintf+0x6fb>
   44004:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4400b:	0f b6 00             	movzbl (%rax),%eax
   4400e:	eb 05                	jmp    44015 <printer_vprintf+0x700>
   44010:	b8 25 00 00 00       	mov    $0x25,%eax
   44015:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44018:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   4401c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44023:	0f b6 00             	movzbl (%rax),%eax
   44026:	84 c0                	test   %al,%al
   44028:	75 08                	jne    44032 <printer_vprintf+0x71d>
                format--;
   4402a:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44031:	01 
            }
            break;
   44032:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44033:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44036:	83 e0 20             	and    $0x20,%eax
   44039:	85 c0                	test   %eax,%eax
   4403b:	74 1e                	je     4405b <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   4403d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44041:	48 83 c0 18          	add    $0x18,%rax
   44045:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44048:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4404c:	48 89 ce             	mov    %rcx,%rsi
   4404f:	48 89 c7             	mov    %rax,%rdi
   44052:	e8 32 f8 ff ff       	call   43889 <fill_numbuf>
   44057:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   4405b:	48 8d 05 44 10 00 00 	lea    0x1044(%rip),%rax        # 450a6 <flag_chars+0x6>
   44062:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44066:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44069:	83 e0 20             	and    $0x20,%eax
   4406c:	85 c0                	test   %eax,%eax
   4406e:	74 51                	je     440c1 <printer_vprintf+0x7ac>
   44070:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44073:	83 e0 40             	and    $0x40,%eax
   44076:	85 c0                	test   %eax,%eax
   44078:	74 47                	je     440c1 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   4407a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4407d:	25 80 00 00 00       	and    $0x80,%eax
   44082:	85 c0                	test   %eax,%eax
   44084:	74 0d                	je     44093 <printer_vprintf+0x77e>
                prefix = "-";
   44086:	48 8d 05 1a 10 00 00 	lea    0x101a(%rip),%rax        # 450a7 <flag_chars+0x7>
   4408d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44091:	eb 7d                	jmp    44110 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44093:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44096:	83 e0 10             	and    $0x10,%eax
   44099:	85 c0                	test   %eax,%eax
   4409b:	74 0d                	je     440aa <printer_vprintf+0x795>
                prefix = "+";
   4409d:	48 8d 05 05 10 00 00 	lea    0x1005(%rip),%rax        # 450a9 <flag_chars+0x9>
   440a4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   440a8:	eb 66                	jmp    44110 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   440aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440ad:	83 e0 08             	and    $0x8,%eax
   440b0:	85 c0                	test   %eax,%eax
   440b2:	74 5c                	je     44110 <printer_vprintf+0x7fb>
                prefix = " ";
   440b4:	48 8d 05 f0 0f 00 00 	lea    0xff0(%rip),%rax        # 450ab <flag_chars+0xb>
   440bb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   440bf:	eb 4f                	jmp    44110 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   440c1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440c4:	83 e0 20             	and    $0x20,%eax
   440c7:	85 c0                	test   %eax,%eax
   440c9:	74 46                	je     44111 <printer_vprintf+0x7fc>
   440cb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440ce:	83 e0 01             	and    $0x1,%eax
   440d1:	85 c0                	test   %eax,%eax
   440d3:	74 3c                	je     44111 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   440d5:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   440d9:	74 06                	je     440e1 <printer_vprintf+0x7cc>
   440db:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   440df:	75 30                	jne    44111 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   440e1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   440e6:	75 0c                	jne    440f4 <printer_vprintf+0x7df>
   440e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440eb:	25 00 01 00 00       	and    $0x100,%eax
   440f0:	85 c0                	test   %eax,%eax
   440f2:	74 1d                	je     44111 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   440f4:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   440f8:	75 09                	jne    44103 <printer_vprintf+0x7ee>
   440fa:	48 8d 05 ac 0f 00 00 	lea    0xfac(%rip),%rax        # 450ad <flag_chars+0xd>
   44101:	eb 07                	jmp    4410a <printer_vprintf+0x7f5>
   44103:	48 8d 05 a6 0f 00 00 	lea    0xfa6(%rip),%rax        # 450b0 <flag_chars+0x10>
   4410a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4410e:	eb 01                	jmp    44111 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   44110:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44111:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44115:	78 24                	js     4413b <printer_vprintf+0x826>
   44117:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4411a:	83 e0 20             	and    $0x20,%eax
   4411d:	85 c0                	test   %eax,%eax
   4411f:	75 1a                	jne    4413b <printer_vprintf+0x826>
            len = strnlen(data, precision);
   44121:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44124:	48 63 d0             	movslq %eax,%rdx
   44127:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4412b:	48 89 d6             	mov    %rdx,%rsi
   4412e:	48 89 c7             	mov    %rax,%rdi
   44131:	e8 91 f5 ff ff       	call   436c7 <strnlen>
   44136:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44139:	eb 0f                	jmp    4414a <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   4413b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4413f:	48 89 c7             	mov    %rax,%rdi
   44142:	e8 4b f5 ff ff       	call   43692 <strlen>
   44147:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   4414a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4414d:	83 e0 20             	and    $0x20,%eax
   44150:	85 c0                	test   %eax,%eax
   44152:	74 20                	je     44174 <printer_vprintf+0x85f>
   44154:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44158:	78 1a                	js     44174 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   4415a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4415d:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44160:	7e 08                	jle    4416a <printer_vprintf+0x855>
   44162:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44165:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44168:	eb 05                	jmp    4416f <printer_vprintf+0x85a>
   4416a:	b8 00 00 00 00       	mov    $0x0,%eax
   4416f:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44172:	eb 5c                	jmp    441d0 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44174:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44177:	83 e0 20             	and    $0x20,%eax
   4417a:	85 c0                	test   %eax,%eax
   4417c:	74 4b                	je     441c9 <printer_vprintf+0x8b4>
   4417e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44181:	83 e0 02             	and    $0x2,%eax
   44184:	85 c0                	test   %eax,%eax
   44186:	74 41                	je     441c9 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44188:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4418b:	83 e0 04             	and    $0x4,%eax
   4418e:	85 c0                	test   %eax,%eax
   44190:	75 37                	jne    441c9 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   44192:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44196:	48 89 c7             	mov    %rax,%rdi
   44199:	e8 f4 f4 ff ff       	call   43692 <strlen>
   4419e:	89 c2                	mov    %eax,%edx
   441a0:	8b 45 bc             	mov    -0x44(%rbp),%eax
   441a3:	01 d0                	add    %edx,%eax
   441a5:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   441a8:	7e 1f                	jle    441c9 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   441aa:	8b 45 e8             	mov    -0x18(%rbp),%eax
   441ad:	2b 45 bc             	sub    -0x44(%rbp),%eax
   441b0:	89 c3                	mov    %eax,%ebx
   441b2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   441b6:	48 89 c7             	mov    %rax,%rdi
   441b9:	e8 d4 f4 ff ff       	call   43692 <strlen>
   441be:	89 c2                	mov    %eax,%edx
   441c0:	89 d8                	mov    %ebx,%eax
   441c2:	29 d0                	sub    %edx,%eax
   441c4:	89 45 b8             	mov    %eax,-0x48(%rbp)
   441c7:	eb 07                	jmp    441d0 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   441c9:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   441d0:	8b 55 bc             	mov    -0x44(%rbp),%edx
   441d3:	8b 45 b8             	mov    -0x48(%rbp),%eax
   441d6:	01 d0                	add    %edx,%eax
   441d8:	48 63 d8             	movslq %eax,%rbx
   441db:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   441df:	48 89 c7             	mov    %rax,%rdi
   441e2:	e8 ab f4 ff ff       	call   43692 <strlen>
   441e7:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   441eb:	8b 45 e8             	mov    -0x18(%rbp),%eax
   441ee:	29 d0                	sub    %edx,%eax
   441f0:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   441f3:	eb 25                	jmp    4421a <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   441f5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441fc:	48 8b 08             	mov    (%rax),%rcx
   441ff:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44205:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4420c:	be 20 00 00 00       	mov    $0x20,%esi
   44211:	48 89 c7             	mov    %rax,%rdi
   44214:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44216:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   4421a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4421d:	83 e0 04             	and    $0x4,%eax
   44220:	85 c0                	test   %eax,%eax
   44222:	75 36                	jne    4425a <printer_vprintf+0x945>
   44224:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44228:	7f cb                	jg     441f5 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   4422a:	eb 2e                	jmp    4425a <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   4422c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44233:	4c 8b 00             	mov    (%rax),%r8
   44236:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4423a:	0f b6 00             	movzbl (%rax),%eax
   4423d:	0f b6 c8             	movzbl %al,%ecx
   44240:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44246:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4424d:	89 ce                	mov    %ecx,%esi
   4424f:	48 89 c7             	mov    %rax,%rdi
   44252:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44255:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   4425a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4425e:	0f b6 00             	movzbl (%rax),%eax
   44261:	84 c0                	test   %al,%al
   44263:	75 c7                	jne    4422c <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   44265:	eb 25                	jmp    4428c <printer_vprintf+0x977>
            p->putc(p, '0', color);
   44267:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4426e:	48 8b 08             	mov    (%rax),%rcx
   44271:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44277:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4427e:	be 30 00 00 00       	mov    $0x30,%esi
   44283:	48 89 c7             	mov    %rax,%rdi
   44286:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44288:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   4428c:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44290:	7f d5                	jg     44267 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   44292:	eb 32                	jmp    442c6 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   44294:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4429b:	4c 8b 00             	mov    (%rax),%r8
   4429e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   442a2:	0f b6 00             	movzbl (%rax),%eax
   442a5:	0f b6 c8             	movzbl %al,%ecx
   442a8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   442ae:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   442b5:	89 ce                	mov    %ecx,%esi
   442b7:	48 89 c7             	mov    %rax,%rdi
   442ba:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   442bd:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   442c2:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   442c6:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   442ca:	7f c8                	jg     44294 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   442cc:	eb 25                	jmp    442f3 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   442ce:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   442d5:	48 8b 08             	mov    (%rax),%rcx
   442d8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   442de:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   442e5:	be 20 00 00 00       	mov    $0x20,%esi
   442ea:	48 89 c7             	mov    %rax,%rdi
   442ed:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   442ef:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   442f3:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   442f7:	7f d5                	jg     442ce <printer_vprintf+0x9b9>
        }
    done: ;
   442f9:	90                   	nop
    for (; *format; ++format) {
   442fa:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44301:	01 
   44302:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44309:	0f b6 00             	movzbl (%rax),%eax
   4430c:	84 c0                	test   %al,%al
   4430e:	0f 85 31 f6 ff ff    	jne    43945 <printer_vprintf+0x30>
    }
}
   44314:	90                   	nop
   44315:	90                   	nop
   44316:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4431a:	c9                   	leave  
   4431b:	c3                   	ret    

000000000004431c <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4431c:	f3 0f 1e fa          	endbr64 
   44320:	55                   	push   %rbp
   44321:	48 89 e5             	mov    %rsp,%rbp
   44324:	48 83 ec 20          	sub    $0x20,%rsp
   44328:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4432c:	89 f0                	mov    %esi,%eax
   4432e:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44331:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44334:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44338:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4433c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44340:	48 8b 40 08          	mov    0x8(%rax),%rax
   44344:	48 8d 15 55 4c 07 00 	lea    0x74c55(%rip),%rdx        # b8fa0 <console+0xfa0>
   4434b:	48 39 d0             	cmp    %rdx,%rax
   4434e:	72 0f                	jb     4435f <console_putc+0x43>
        cp->cursor = console;
   44350:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44354:	48 8d 15 a5 3c 07 00 	lea    0x73ca5(%rip),%rdx        # b8000 <console>
   4435b:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   4435f:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44363:	0f 85 82 00 00 00    	jne    443eb <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   44369:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4436d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44371:	48 8d 15 88 3c 07 00 	lea    0x73c88(%rip),%rdx        # b8000 <console>
   44378:	48 29 d0             	sub    %rdx,%rax
   4437b:	48 d1 f8             	sar    %rax
   4437e:	48 89 c1             	mov    %rax,%rcx
   44381:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44388:	66 66 66 
   4438b:	48 89 c8             	mov    %rcx,%rax
   4438e:	48 f7 ea             	imul   %rdx
   44391:	48 89 d0             	mov    %rdx,%rax
   44394:	48 c1 f8 05          	sar    $0x5,%rax
   44398:	48 89 ce             	mov    %rcx,%rsi
   4439b:	48 c1 fe 3f          	sar    $0x3f,%rsi
   4439f:	48 29 f0             	sub    %rsi,%rax
   443a2:	48 89 c2             	mov    %rax,%rdx
   443a5:	48 89 d0             	mov    %rdx,%rax
   443a8:	48 c1 e0 02          	shl    $0x2,%rax
   443ac:	48 01 d0             	add    %rdx,%rax
   443af:	48 c1 e0 04          	shl    $0x4,%rax
   443b3:	48 29 c1             	sub    %rax,%rcx
   443b6:	48 89 ca             	mov    %rcx,%rdx
   443b9:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   443bc:	eb 25                	jmp    443e3 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   443be:	8b 45 e0             	mov    -0x20(%rbp),%eax
   443c1:	83 c8 20             	or     $0x20,%eax
   443c4:	89 c6                	mov    %eax,%esi
   443c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   443ca:	48 8b 40 08          	mov    0x8(%rax),%rax
   443ce:	48 8d 48 02          	lea    0x2(%rax),%rcx
   443d2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   443d6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443da:	89 f2                	mov    %esi,%edx
   443dc:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   443df:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   443e3:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   443e7:	75 d5                	jne    443be <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   443e9:	eb 24                	jmp    4440f <console_putc+0xf3>
        *cp->cursor++ = c | color;
   443eb:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   443ef:	8b 45 e0             	mov    -0x20(%rbp),%eax
   443f2:	89 d6                	mov    %edx,%esi
   443f4:	09 c6                	or     %eax,%esi
   443f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   443fa:	48 8b 40 08          	mov    0x8(%rax),%rax
   443fe:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44402:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44406:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4440a:	89 f2                	mov    %esi,%edx
   4440c:	66 89 10             	mov    %dx,(%rax)
}
   4440f:	90                   	nop
   44410:	c9                   	leave  
   44411:	c3                   	ret    

0000000000044412 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44412:	f3 0f 1e fa          	endbr64 
   44416:	55                   	push   %rbp
   44417:	48 89 e5             	mov    %rsp,%rbp
   4441a:	48 83 ec 30          	sub    $0x30,%rsp
   4441e:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44421:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44424:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44428:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   4442c:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 4431c <console_putc>
   44433:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44437:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   4443b:	78 09                	js     44446 <console_vprintf+0x34>
   4443d:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44444:	7e 07                	jle    4444d <console_vprintf+0x3b>
        cpos = 0;
   44446:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   4444d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44450:	48 98                	cltq   
   44452:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44456:	48 8d 05 a3 3b 07 00 	lea    0x73ba3(%rip),%rax        # b8000 <console>
   4445d:	48 01 d0             	add    %rdx,%rax
   44460:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44464:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44468:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4446c:	8b 75 e8             	mov    -0x18(%rbp),%esi
   4446f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44473:	48 89 c7             	mov    %rax,%rdi
   44476:	e8 9a f4 ff ff       	call   43915 <printer_vprintf>
    return cp.cursor - console;
   4447b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4447f:	48 8d 15 7a 3b 07 00 	lea    0x73b7a(%rip),%rdx        # b8000 <console>
   44486:	48 29 d0             	sub    %rdx,%rax
   44489:	48 d1 f8             	sar    %rax
}
   4448c:	c9                   	leave  
   4448d:	c3                   	ret    

000000000004448e <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   4448e:	f3 0f 1e fa          	endbr64 
   44492:	55                   	push   %rbp
   44493:	48 89 e5             	mov    %rsp,%rbp
   44496:	48 83 ec 60          	sub    $0x60,%rsp
   4449a:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4449d:	89 75 a8             	mov    %esi,-0x58(%rbp)
   444a0:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   444a4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   444a8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   444ac:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   444b0:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   444b7:	48 8d 45 10          	lea    0x10(%rbp),%rax
   444bb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   444bf:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   444c3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   444c7:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   444cb:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   444cf:	8b 75 a8             	mov    -0x58(%rbp),%esi
   444d2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   444d5:	89 c7                	mov    %eax,%edi
   444d7:	e8 36 ff ff ff       	call   44412 <console_vprintf>
   444dc:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   444df:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   444e2:	c9                   	leave  
   444e3:	c3                   	ret    

00000000000444e4 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   444e4:	f3 0f 1e fa          	endbr64 
   444e8:	55                   	push   %rbp
   444e9:	48 89 e5             	mov    %rsp,%rbp
   444ec:	48 83 ec 20          	sub    $0x20,%rsp
   444f0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   444f4:	89 f0                	mov    %esi,%eax
   444f6:	89 55 e0             	mov    %edx,-0x20(%rbp)
   444f9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   444fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44500:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44504:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44508:	48 8b 50 08          	mov    0x8(%rax),%rdx
   4450c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44510:	48 8b 40 10          	mov    0x10(%rax),%rax
   44514:	48 39 c2             	cmp    %rax,%rdx
   44517:	73 1a                	jae    44533 <string_putc+0x4f>
        *sp->s++ = c;
   44519:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4451d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44521:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44525:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44529:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4452d:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44531:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44533:	90                   	nop
   44534:	c9                   	leave  
   44535:	c3                   	ret    

0000000000044536 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44536:	f3 0f 1e fa          	endbr64 
   4453a:	55                   	push   %rbp
   4453b:	48 89 e5             	mov    %rsp,%rbp
   4453e:	48 83 ec 40          	sub    $0x40,%rsp
   44542:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44546:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4454a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   4454e:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44552:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 444e4 <string_putc>
   44559:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   4455d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44561:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44565:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   4456a:	74 33                	je     4459f <vsnprintf+0x69>
        sp.end = s + size - 1;
   4456c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44570:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44574:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44578:	48 01 d0             	add    %rdx,%rax
   4457b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   4457f:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44583:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44587:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4458b:	be 00 00 00 00       	mov    $0x0,%esi
   44590:	48 89 c7             	mov    %rax,%rdi
   44593:	e8 7d f3 ff ff       	call   43915 <printer_vprintf>
        *sp.s = 0;
   44598:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4459c:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   4459f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   445a3:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   445a7:	c9                   	leave  
   445a8:	c3                   	ret    

00000000000445a9 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   445a9:	f3 0f 1e fa          	endbr64 
   445ad:	55                   	push   %rbp
   445ae:	48 89 e5             	mov    %rsp,%rbp
   445b1:	48 83 ec 70          	sub    $0x70,%rsp
   445b5:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   445b9:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   445bd:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   445c1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   445c5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   445c9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   445cd:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   445d4:	48 8d 45 10          	lea    0x10(%rbp),%rax
   445d8:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   445dc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   445e0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   445e4:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   445e8:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   445ec:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   445f0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   445f4:	48 89 c7             	mov    %rax,%rdi
   445f7:	e8 3a ff ff ff       	call   44536 <vsnprintf>
   445fc:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   445ff:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44602:	c9                   	leave  
   44603:	c3                   	ret    

0000000000044604 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44604:	f3 0f 1e fa          	endbr64 
   44608:	55                   	push   %rbp
   44609:	48 89 e5             	mov    %rsp,%rbp
   4460c:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44610:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44617:	eb 1a                	jmp    44633 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   44619:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4461c:	48 98                	cltq   
   4461e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44622:	48 8d 05 d7 39 07 00 	lea    0x739d7(%rip),%rax        # b8000 <console>
   44629:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4462f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44633:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   4463a:	7e dd                	jle    44619 <console_clear+0x15>
    }
    cursorpos = 0;
   4463c:	c7 05 b6 49 07 00 00 	movl   $0x0,0x749b6(%rip)        # b8ffc <cursorpos>
   44643:	00 00 00 
}
   44646:	90                   	nop
   44647:	c9                   	leave  
   44648:	c3                   	ret    
