
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
   400be:	e8 d6 08 00 00       	call   40999 <exception>

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
   40177:	e8 bc 1a 00 00       	call   41c38 <hardware_init>
    pageinfo_init();
   4017c:	e8 bc 0f 00 00       	call   4113d <pageinfo_init>
    console_clear();
   40181:	e8 66 47 00 00       	call   448ec <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 10 20 00 00       	call   421a0 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 7f 2e 01 00 	lea    0x12e7f(%rip),%rax        # 53020 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 8e 37 00 00       	call   43937 <memset>
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
   40210:	48 8d 15 29 47 00 00 	lea    0x4729(%rip),%rdx        # 44940 <console_clear+0x54>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 1e 38 00 00       	call   43a40 <strcmp>
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
   40245:	48 8d 15 f9 46 00 00 	lea    0x46f9(%rip),%rdx        # 44945 <console_clear+0x59>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 e9 37 00 00       	call   43a40 <strcmp>
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
   4027a:	48 8d 15 cd 46 00 00 	lea    0x46cd(%rip),%rdx        # 4494e <console_clear+0x62>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 b4 37 00 00       	call   43a40 <strcmp>
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
   402ac:	48 8d 15 a0 46 00 00 	lea    0x46a0(%rip),%rdx        # 44953 <console_clear+0x67>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 82 37 00 00       	call   43a40 <strcmp>
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
   4032a:	e8 de 2c 00 00       	call   4300d <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   4032f:	48 8d 15 ca 7c 07 00 	lea    0x77cca(%rip),%rdx        # b8000 <console>
   40336:	48 8d 35 c3 7c 07 00 	lea    0x77cc3(%rip),%rsi        # b8000 <console>
   4033d:	48 8b 05 bc 5c 01 00 	mov    0x15cbc(%rip),%rax        # 56000 <kernel_pagetable>
   40344:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4034a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4034f:	48 89 c7             	mov    %rax,%rdi
   40352:	e8 b6 2c 00 00       	call   4300d <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    // Switch to the first process using run()
    run(&processes[1]);
   40357:	48 8d 05 a2 2d 01 00 	lea    0x12da2(%rip),%rax        # 53100 <processes+0xe0>
   4035e:	48 89 c7             	mov    %rax,%rdi
   40361:	e8 6c 0d 00 00       	call   410d2 <run>

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
   403e0:	e8 52 35 00 00       	call   43937 <memset>
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
   40558:	e8 fa 2e 00 00       	call   43457 <virtual_memory_lookup>
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
   40584:	e8 84 2a 00 00       	call   4300d <virtual_memory_map>
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
   405d9:	e8 75 1e 00 00       	call   42453 <process_init>

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
   40632:	e8 d6 29 00 00       	call   4300d <virtual_memory_map>
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
   40663:	e8 ea 2e 00 00       	call   43552 <program_load>
   40668:	89 45 f4             	mov    %eax,-0xc(%rbp)
    assert(r >= 0);
   4066b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4066f:	79 1e                	jns    4068f <process_setup+0xee>
   40671:	48 8d 05 e1 42 00 00 	lea    0x42e1(%rip),%rax        # 44959 <console_clear+0x6d>
   40678:	48 89 c2             	mov    %rax,%rdx
   4067b:	be bf 00 00 00       	mov    $0xbf,%esi
   40680:	48 8d 05 d9 42 00 00 	lea    0x42d9(%rip),%rax        # 44960 <console_clear+0x74>
   40687:	48 89 c7             	mov    %rax,%rdi
   4068a:	e8 fa 25 00 00       	call   42c89 <assert_fail>

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
   406b6:	e8 52 29 00 00       	call   4300d <virtual_memory_map>
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
   407d7:	e8 7b 2c 00 00       	call   43457 <virtual_memory_lookup>

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
   4080f:	e8 43 2c 00 00       	call   43457 <virtual_memory_lookup>
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
   4083b:	e8 17 2c 00 00       	call   43457 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40840:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40844:	48 89 c1             	mov    %rax,%rcx
   40847:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4084b:	ba 18 00 00 00       	mov    $0x18,%edx
   40850:	48 89 c6             	mov    %rax,%rsi
   40853:	48 89 cf             	mov    %rcx,%rdi
   40856:	e8 d6 2f 00 00       	call   43831 <memcpy>
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

00000000000408d0 <unmap>:
//    the kernel's stack, then jumping to kernel assembly code (in
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.
void unmap(x86_64_pagetable* child_table, proc* child){
   408d0:	f3 0f 1e fa          	endbr64 
   408d4:	55                   	push   %rbp
   408d5:	48 89 e5             	mov    %rsp,%rbp
   408d8:	48 83 ec 30          	sub    $0x30,%rsp
   408dc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   408e0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
        for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   408e4:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   408eb:	00 
   408ec:	eb 4f                	jmp    4093d <unmap+0x6d>
            vamapping child_map = virtual_memory_lookup(child_table, va);
   408ee:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   408f2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   408f6:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   408fa:	48 89 ce             	mov    %rcx,%rsi
   408fd:	48 89 c7             	mov    %rax,%rdi
   40900:	e8 52 2b 00 00       	call   43457 <virtual_memory_lookup>
            if (child_map.pn != -1) {
   40905:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40908:	83 f8 ff             	cmp    $0xffffffff,%eax
   4090b:	74 28                	je     40935 <unmap+0x65>
                pageinfo[child_map.pn].refcount = 0;
   4090d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40910:	48 98                	cltq   
   40912:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40916:	48 8d 05 24 35 01 00 	lea    0x13524(%rip),%rax        # 53e41 <pageinfo+0x1>
   4091d:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[child_map.pn].owner = PO_FREE;
   40921:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40924:	48 98                	cltq   
   40926:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4092a:	48 8d 05 0f 35 01 00 	lea    0x1350f(%rip),%rax        # 53e40 <pageinfo>
   40931:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40935:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4093c:	00 
   4093d:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40944:	00 
   40945:	76 a7                	jbe    408ee <unmap+0x1e>
            }
        }
        pageinfo[PAGENUMBER((uintptr_t) child_table)].refcount = 0;
   40947:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4094b:	48 c1 e8 0c          	shr    $0xc,%rax
   4094f:	48 98                	cltq   
   40951:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40955:	48 8d 05 e5 34 01 00 	lea    0x134e5(%rip),%rax        # 53e41 <pageinfo+0x1>
   4095c:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER((uintptr_t) child_table)].owner = PO_FREE;
   40960:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40964:	48 c1 e8 0c          	shr    $0xc,%rax
   40968:	48 98                	cltq   
   4096a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4096e:	48 8d 05 cb 34 01 00 	lea    0x134cb(%rip),%rax        # 53e40 <pageinfo>
   40975:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        child->p_state = P_FREE;
   40979:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4097d:	c7 80 c8 00 00 00 00 	movl   $0x0,0xc8(%rax)
   40984:	00 00 00 
        current->p_registers.reg_rax = -1;
   40987:	48 8b 05 72 26 01 00 	mov    0x12672(%rip),%rax        # 53000 <current>
   4098e:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40995:	ff 
}
   40996:	90                   	nop
   40997:	c9                   	leave  
   40998:	c3                   	ret    

0000000000040999 <exception>:
void exception(x86_64_registers* reg) {
   40999:	f3 0f 1e fa          	endbr64 
   4099d:	55                   	push   %rbp
   4099e:	48 89 e5             	mov    %rsp,%rbp
   409a1:	48 81 ec 60 01 00 00 	sub    $0x160,%rsp
   409a8:	48 89 bd a8 fe ff ff 	mov    %rdi,-0x158(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   409af:	48 8b 05 4a 26 01 00 	mov    0x1264a(%rip),%rax        # 53000 <current>
   409b6:	48 8b 95 a8 fe ff ff 	mov    -0x158(%rbp),%rdx
   409bd:	48 83 c0 08          	add    $0x8,%rax
   409c1:	48 89 d6             	mov    %rdx,%rsi
   409c4:	ba 18 00 00 00       	mov    $0x18,%edx
   409c9:	48 89 c7             	mov    %rax,%rdi
   409cc:	48 89 d1             	mov    %rdx,%rcx
   409cf:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   409d2:	48 8b 05 27 56 01 00 	mov    0x15627(%rip),%rax        # 56000 <kernel_pagetable>
   409d9:	48 89 c7             	mov    %rax,%rdi
   409dc:	e8 ba 24 00 00       	call   42e9b <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   409e1:	8b 05 15 86 07 00    	mov    0x78615(%rip),%eax        # b8ffc <cursorpos>
   409e7:	89 c7                	mov    %eax,%edi
   409e9:	e8 33 1b 00 00       	call   42521 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   409ee:	48 8b 85 a8 fe ff ff 	mov    -0x158(%rbp),%rax
   409f5:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   409fc:	48 83 f8 0e          	cmp    $0xe,%rax
   40a00:	74 14                	je     40a16 <exception+0x7d>
   40a02:	48 8b 85 a8 fe ff ff 	mov    -0x158(%rbp),%rax
   40a09:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40a10:	48 83 f8 0d          	cmp    $0xd,%rax
   40a14:	75 16                	jne    40a2c <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40a16:	48 8b 85 a8 fe ff ff 	mov    -0x158(%rbp),%rax
   40a1d:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a24:	83 e0 04             	and    $0x4,%eax
   40a27:	48 85 c0             	test   %rax,%rax
   40a2a:	74 1a                	je     40a46 <exception+0xad>
    {
        check_virtual_memory();
   40a2c:	e8 36 0b 00 00       	call   41567 <check_virtual_memory>
        if(disp_global){
   40a31:	0f b6 05 c8 55 00 00 	movzbl 0x55c8(%rip),%eax        # 46000 <disp_global>
   40a38:	84 c0                	test   %al,%al
   40a3a:	74 0a                	je     40a46 <exception+0xad>
            memshow_physical();
   40a3c:	e8 ef 0c 00 00       	call   41730 <memshow_physical>
            memshow_virtual_animate();
   40a41:	e8 8c 10 00 00       	call   41ad2 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40a46:	e8 ec 1f 00 00       	call   42a37 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40a4b:	48 8b 85 a8 fe ff ff 	mov    -0x158(%rbp),%rax
   40a52:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40a59:	48 83 e8 0e          	sub    $0xe,%rax
   40a5d:	48 83 f8 2a          	cmp    $0x2a,%rax
   40a61:	0f 87 b3 05 00 00    	ja     4101a <exception+0x681>
   40a67:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   40a6e:	00 
   40a6f:	48 8d 05 8a 3f 00 00 	lea    0x3f8a(%rip),%rax        # 44a00 <console_clear+0x114>
   40a76:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40a79:	48 98                	cltq   
   40a7b:	48 8d 15 7e 3f 00 00 	lea    0x3f7e(%rip),%rdx        # 44a00 <console_clear+0x114>
   40a82:	48 01 d0             	add    %rdx,%rax
   40a85:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40a88:	48 8b 05 71 25 01 00 	mov    0x12571(%rip),%rax        # 53000 <current>
   40a8f:	48 8b 40 38          	mov    0x38(%rax),%rax
   40a93:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
		if((void *)addr == NULL)
   40a97:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
   40a9c:	75 0f                	jne    40aad <exception+0x114>
		    panic(NULL);
   40a9e:	bf 00 00 00 00       	mov    $0x0,%edi
   40aa3:	b8 00 00 00 00       	mov    $0x0,%eax
   40aa8:	e8 ec 20 00 00       	call   42b99 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40aad:	48 8b 05 4c 25 01 00 	mov    0x1254c(%rip),%rax        # 53000 <current>
   40ab4:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40abb:	48 8d 85 68 ff ff ff 	lea    -0x98(%rbp),%rax
   40ac2:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   40ac6:	48 89 ce             	mov    %rcx,%rsi
   40ac9:	48 89 c7             	mov    %rax,%rdi
   40acc:	e8 86 29 00 00       	call   43457 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40ad1:	48 8b 85 70 ff ff ff 	mov    -0x90(%rbp),%rax
   40ad8:	48 89 c1             	mov    %rax,%rcx
   40adb:	48 8d 85 b0 fe ff ff 	lea    -0x150(%rbp),%rax
   40ae2:	ba a0 00 00 00       	mov    $0xa0,%edx
   40ae7:	48 89 ce             	mov    %rcx,%rsi
   40aea:	48 89 c7             	mov    %rax,%rdi
   40aed:	e8 3f 2d 00 00       	call   43831 <memcpy>
		panic(msg);
   40af2:	48 8d 85 b0 fe ff ff 	lea    -0x150(%rbp),%rax
   40af9:	48 89 c7             	mov    %rax,%rdi
   40afc:	b8 00 00 00 00       	mov    $0x0,%eax
   40b01:	e8 93 20 00 00       	call   42b99 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40b06:	48 8b 05 f3 24 01 00 	mov    0x124f3(%rip),%rax        # 53000 <current>
   40b0d:	8b 10                	mov    (%rax),%edx
   40b0f:	48 8b 05 ea 24 01 00 	mov    0x124ea(%rip),%rax        # 53000 <current>
   40b16:	48 63 d2             	movslq %edx,%rdx
   40b19:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40b1d:	e9 08 05 00 00       	jmp    4102a <exception+0x691>

    case INT_SYS_YIELD:
        schedule();
   40b22:	e8 2c 05 00 00       	call   41053 <schedule>
        break;                  /* will not be reached */
   40b27:	e9 fe 04 00 00       	jmp    4102a <exception+0x691>

case INT_SYS_PAGE_ALLOC: {
    uintptr_t va = current->p_registers.reg_rdi;
   40b2c:	48 8b 05 cd 24 01 00 	mov    0x124cd(%rip),%rax        # 53000 <current>
   40b33:	48 8b 40 38          	mov    0x38(%rax),%rax
   40b37:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    // check allignment and bounds
    if (va % PAGESIZE != 0) {
   40b3b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b3f:	25 ff 0f 00 00       	and    $0xfff,%eax
   40b44:	48 85 c0             	test   %rax,%rax
   40b47:	74 14                	je     40b5d <exception+0x1c4>
        current->p_registers.reg_rax = -1; 
   40b49:	48 8b 05 b0 24 01 00 	mov    0x124b0(%rip),%rax        # 53000 <current>
   40b50:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b57:	ff 
        break;
   40b58:	e9 cd 04 00 00       	jmp    4102a <exception+0x691>
    }
    if (va >= MEMSIZE_VIRTUAL) {
   40b5d:	48 81 7d b8 ff ff 2f 	cmpq   $0x2fffff,-0x48(%rbp)
   40b64:	00 
   40b65:	76 14                	jbe    40b7b <exception+0x1e2>
        current->p_registers.reg_rax = -1; 
   40b67:	48 8b 05 92 24 01 00 	mov    0x12492(%rip),%rax        # 53000 <current>
   40b6e:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b75:	ff 
        break;
   40b76:	e9 af 04 00 00       	jmp    4102a <exception+0x691>
    }
    if (va < PROC_START_ADDR) {
   40b7b:	48 81 7d b8 ff ff 0f 	cmpq   $0xfffff,-0x48(%rbp)
   40b82:	00 
   40b83:	77 14                	ja     40b99 <exception+0x200>
        current->p_registers.reg_rax = -1; 
   40b85:	48 8b 05 74 24 01 00 	mov    0x12474(%rip),%rax        # 53000 <current>
   40b8c:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b93:	ff 
        break;
   40b94:	e9 91 04 00 00       	jmp    4102a <exception+0x691>
    }   
    uintptr_t pa = find_page(current->p_pid);
   40b99:	48 8b 05 60 24 01 00 	mov    0x12460(%rip),%rax        # 53000 <current>
   40ba0:	8b 00                	mov    (%rax),%eax
   40ba2:	0f be c0             	movsbl %al,%eax
   40ba5:	89 c7                	mov    %eax,%edi
   40ba7:	e8 58 f8 ff ff       	call   40404 <find_page>
   40bac:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    if (pa == 0) {
   40bb0:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   40bb5:	75 14                	jne    40bcb <exception+0x232>
        current->p_registers.reg_rax = -1; 
   40bb7:	48 8b 05 42 24 01 00 	mov    0x12442(%rip),%rax        # 53000 <current>
   40bbe:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40bc5:	ff 
        break;
   40bc6:	e9 5f 04 00 00       	jmp    4102a <exception+0x691>
    }
    int perm = PTE_P | PTE_W | PTE_U;
   40bcb:	c7 45 ac 07 00 00 00 	movl   $0x7,-0x54(%rbp)

    int r = virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, perm);
   40bd2:	48 8b 05 27 24 01 00 	mov    0x12427(%rip),%rax        # 53000 <current>
   40bd9:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40be0:	8b 4d ac             	mov    -0x54(%rbp),%ecx
   40be3:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   40be7:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
   40beb:	41 89 c8             	mov    %ecx,%r8d
   40bee:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40bf3:	48 89 c7             	mov    %rax,%rdi
   40bf6:	e8 12 24 00 00       	call   4300d <virtual_memory_map>
   40bfb:	89 45 a8             	mov    %eax,-0x58(%rbp)

    if (r != 0) {
   40bfe:	83 7d a8 00          	cmpl   $0x0,-0x58(%rbp)
   40c02:	74 46                	je     40c4a <exception+0x2b1>
        // If mapping fails, free the physical page
        pageinfo[PAGENUMBER(pa)].refcount = 0;
   40c04:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40c08:	48 c1 e8 0c          	shr    $0xc,%rax
   40c0c:	48 98                	cltq   
   40c0e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40c12:	48 8d 05 28 32 01 00 	lea    0x13228(%rip),%rax        # 53e41 <pageinfo+0x1>
   40c19:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(pa)].owner = PO_FREE;
   40c1d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40c21:	48 c1 e8 0c          	shr    $0xc,%rax
   40c25:	48 98                	cltq   
   40c27:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40c2b:	48 8d 05 0e 32 01 00 	lea    0x1320e(%rip),%rax        # 53e40 <pageinfo>
   40c32:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        current->p_registers.reg_rax = -1;
   40c36:	48 8b 05 c3 23 01 00 	mov    0x123c3(%rip),%rax        # 53000 <current>
   40c3d:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40c44:	ff 
        break;
   40c45:	e9 e0 03 00 00       	jmp    4102a <exception+0x691>
    }

    // Success: Return 0
    current->p_registers.reg_rax = 0;
   40c4a:	48 8b 05 af 23 01 00 	mov    0x123af(%rip),%rax        # 53000 <current>
   40c51:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40c58:	00 
    break;
   40c59:	e9 cc 03 00 00       	jmp    4102a <exception+0x691>
}
case INT_SYS_FORK: {
    // Step 1: Find a free process slot
    pid_t child_pid = -1;
   40c5e:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    for (pid_t i = 1; i < NPROC; ++i) {
   40c65:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   40c6c:	eb 31                	jmp    40c9f <exception+0x306>
        if (processes[i].p_state == P_FREE) {
   40c6e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40c71:	48 63 d0             	movslq %eax,%rdx
   40c74:	48 89 d0             	mov    %rdx,%rax
   40c77:	48 c1 e0 03          	shl    $0x3,%rax
   40c7b:	48 29 d0             	sub    %rdx,%rax
   40c7e:	48 c1 e0 05          	shl    $0x5,%rax
   40c82:	48 89 c2             	mov    %rax,%rdx
   40c85:	48 8d 05 5c 24 01 00 	lea    0x1245c(%rip),%rax        # 530e8 <processes+0xc8>
   40c8c:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40c8f:	85 c0                	test   %eax,%eax
   40c91:	75 08                	jne    40c9b <exception+0x302>
            child_pid = i;
   40c93:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40c96:	89 45 fc             	mov    %eax,-0x4(%rbp)
            break;
   40c99:	eb 0a                	jmp    40ca5 <exception+0x30c>
    for (pid_t i = 1; i < NPROC; ++i) {
   40c9b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40c9f:	83 7d f8 0f          	cmpl   $0xf,-0x8(%rbp)
   40ca3:	7e c9                	jle    40c6e <exception+0x2d5>
        }
    }

    // If no free slot, return -1
    if (child_pid == -1) {
   40ca5:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40ca9:	75 14                	jne    40cbf <exception+0x326>
        current->p_registers.reg_rax = -1;
   40cab:	48 8b 05 4e 23 01 00 	mov    0x1234e(%rip),%rax        # 53000 <current>
   40cb2:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40cb9:	ff 
        break;
   40cba:	e9 6b 03 00 00       	jmp    4102a <exception+0x691>
    }

    // Step 2: Reserve the new process slot
    proc* parent = current;
   40cbf:	48 8b 05 3a 23 01 00 	mov    0x1233a(%rip),%rax        # 53000 <current>
   40cc6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    proc* child = &processes[child_pid];
   40cca:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ccd:	48 63 d0             	movslq %eax,%rdx
   40cd0:	48 89 d0             	mov    %rdx,%rax
   40cd3:	48 c1 e0 03          	shl    $0x3,%rax
   40cd7:	48 29 d0             	sub    %rdx,%rax
   40cda:	48 c1 e0 05          	shl    $0x5,%rax
   40cde:	48 8d 15 3b 23 01 00 	lea    0x1233b(%rip),%rdx        # 53020 <processes>
   40ce5:	48 01 d0             	add    %rdx,%rax
   40ce8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    process_init(child, child_pid);
   40cec:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40cef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40cf3:	89 d6                	mov    %edx,%esi
   40cf5:	48 89 c7             	mov    %rax,%rdi
   40cf8:	e8 56 17 00 00       	call   42453 <process_init>

    // Step 3: Allocate a new page table for the child
    x86_64_pagetable* child_table = make_pages(child_pid);
   40cfd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d00:	89 c7                	mov    %eax,%edi
   40d02:	e8 85 f7 ff ff       	call   4048c <make_pages>
   40d07:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if (!child_table) {
   40d0b:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   40d10:	75 14                	jne    40d26 <exception+0x38d>
        current->p_registers.reg_rax = -1;
   40d12:	48 8b 05 e7 22 01 00 	mov    0x122e7(%rip),%rax        # 53000 <current>
   40d19:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40d20:	ff 
        break;
   40d21:	e9 04 03 00 00       	jmp    4102a <exception+0x691>
    }
    child->p_pagetable = child_table;
   40d26:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40d2a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40d2e:	48 89 90 d0 00 00 00 	mov    %rdx,0xd0(%rax)

    int failed = 0;
   40d35:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40d3c:	48 c7 45 e8 00 00 10 	movq   $0x100000,-0x18(%rbp)
   40d43:	00 
   40d44:	e9 09 01 00 00       	jmp    40e52 <exception+0x4b9>
        vamapping parent_mapping = virtual_memory_lookup(parent->p_pagetable, va);
   40d49:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d4d:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40d54:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
   40d5b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40d5f:	48 89 ce             	mov    %rcx,%rsi
   40d62:	48 89 c7             	mov    %rax,%rdi
   40d65:	e8 ed 26 00 00       	call   43457 <virtual_memory_lookup>

        if (parent_mapping.pn == -1) {
   40d6a:	8b 85 50 ff ff ff    	mov    -0xb0(%rbp),%eax
   40d70:	83 f8 ff             	cmp    $0xffffffff,%eax
   40d73:	0f 84 d0 00 00 00    	je     40e49 <exception+0x4b0>
            continue; 
        }
        // mapp console
        virtual_memory_map(child_table, CONSOLE_ADDR, parent_mapping.pa, PAGESIZE, parent_mapping.perm);
   40d79:	8b 8d 60 ff ff ff    	mov    -0xa0(%rbp),%ecx
   40d7f:	48 8b 95 58 ff ff ff 	mov    -0xa8(%rbp),%rdx
   40d86:	48 8d 35 73 72 07 00 	lea    0x77273(%rip),%rsi        # b8000 <console>
   40d8d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40d91:	41 89 c8             	mov    %ecx,%r8d
   40d94:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40d99:	48 89 c7             	mov    %rax,%rdi
   40d9c:	e8 6c 22 00 00       	call   4300d <virtual_memory_map>

        // Allocate a new physical page for the child
        uintptr_t new_pa = find_page(child_pid);
   40da1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40da4:	0f be c0             	movsbl %al,%eax
   40da7:	89 c7                	mov    %eax,%edi
   40da9:	e8 56 f6 ff ff       	call   40404 <find_page>
   40dae:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        if (!new_pa) {
   40db2:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40db7:	75 0c                	jne    40dc5 <exception+0x42c>
            failed = 1;
   40db9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
            break;
   40dc0:	e9 9b 00 00 00       	jmp    40e60 <exception+0x4c7>
        }
        memcpy((void*) new_pa, (void*) parent_mapping.pa, PAGESIZE);
   40dc5:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
   40dcc:	48 89 c1             	mov    %rax,%rcx
   40dcf:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40dd3:	ba 00 10 00 00       	mov    $0x1000,%edx
   40dd8:	48 89 ce             	mov    %rcx,%rsi
   40ddb:	48 89 c7             	mov    %rax,%rdi
   40dde:	e8 4e 2a 00 00       	call   43831 <memcpy>
        int r = virtual_memory_map(child_table, va, new_pa, PAGESIZE, parent_mapping.perm);
   40de3:	8b 8d 60 ff ff ff    	mov    -0xa0(%rbp),%ecx
   40de9:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40ded:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40df1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40df5:	41 89 c8             	mov    %ecx,%r8d
   40df8:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40dfd:	48 89 c7             	mov    %rax,%rdi
   40e00:	e8 08 22 00 00       	call   4300d <virtual_memory_map>
   40e05:	89 45 c4             	mov    %eax,-0x3c(%rbp)

        if (r < 0) {
   40e08:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
   40e0c:	79 3c                	jns    40e4a <exception+0x4b1>
            failed = 1;
   40e0e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
            pageinfo[PAGENUMBER(new_pa)].refcount = 0; 
   40e15:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e19:	48 c1 e8 0c          	shr    $0xc,%rax
   40e1d:	48 98                	cltq   
   40e1f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e23:	48 8d 05 17 30 01 00 	lea    0x13017(%rip),%rax        # 53e41 <pageinfo+0x1>
   40e2a:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
            pageinfo[PAGENUMBER(new_pa)].owner = PO_FREE;
   40e2e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e32:	48 c1 e8 0c          	shr    $0xc,%rax
   40e36:	48 98                	cltq   
   40e38:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e3c:	48 8d 05 fd 2f 01 00 	lea    0x12ffd(%rip),%rax        # 53e40 <pageinfo>
   40e43:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
            break;
   40e47:	eb 17                	jmp    40e60 <exception+0x4c7>
            continue; 
   40e49:	90                   	nop
    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40e4a:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   40e51:	00 
   40e52:	48 81 7d e8 ff ff 2f 	cmpq   $0x2fffff,-0x18(%rbp)
   40e59:	00 
   40e5a:	0f 86 e9 fe ff ff    	jbe    40d49 <exception+0x3b0>
        }
    }

    if (failed != 0) {
   40e60:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40e64:	74 18                	je     40e7e <exception+0x4e5>
        unmap(child_table, child);
   40e66:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40e6a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40e6e:	48 89 d6             	mov    %rdx,%rsi
   40e71:	48 89 c7             	mov    %rax,%rdi
   40e74:	e8 57 fa ff ff       	call   408d0 <unmap>

        break;
   40e79:	e9 ac 01 00 00       	jmp    4102a <exception+0x691>
    }

    child->p_registers = parent->p_registers;
   40e7e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40e82:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40e86:	48 83 c0 08          	add    $0x8,%rax
   40e8a:	48 83 c2 08          	add    $0x8,%rdx
   40e8e:	b9 18 00 00 00       	mov    $0x18,%ecx
   40e93:	48 89 c7             	mov    %rax,%rdi
   40e96:	48 89 d6             	mov    %rdx,%rsi
   40e99:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    child->p_registers.reg_rax = 0; 
   40e9c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40ea0:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40ea7:	00 
    child->p_state = P_RUNNABLE;
   40ea8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40eac:	c7 80 c8 00 00 00 01 	movl   $0x1,0xc8(%rax)
   40eb3:	00 00 00 
    current->p_registers.reg_rax = child_pid;
   40eb6:	48 8b 05 43 21 01 00 	mov    0x12143(%rip),%rax        # 53000 <current>
   40ebd:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ec0:	48 63 d2             	movslq %edx,%rdx
   40ec3:	48 89 50 08          	mov    %rdx,0x8(%rax)
    break;
   40ec7:	e9 5e 01 00 00       	jmp    4102a <exception+0x691>

    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40ecc:	48 8b 05 2d 21 01 00 	mov    0x1212d(%rip),%rax        # 53000 <current>
   40ed3:	48 89 c7             	mov    %rax,%rdi
   40ed6:	e8 bb f8 ff ff       	call   40796 <syscall_mapping>
            break;
   40edb:	e9 4a 01 00 00       	jmp    4102a <exception+0x691>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40ee0:	48 8b 05 19 21 01 00 	mov    0x12119(%rip),%rax        # 53000 <current>
   40ee7:	48 89 c7             	mov    %rax,%rdi
   40eea:	e8 74 f9 ff ff       	call   40863 <syscall_mem_tog>
	    break;
   40eef:	e9 36 01 00 00       	jmp    4102a <exception+0x691>
	}

    case INT_TIMER:
        ++ticks;
   40ef4:	8b 05 26 2f 01 00    	mov    0x12f26(%rip),%eax        # 53e20 <ticks>
   40efa:	83 c0 01             	add    $0x1,%eax
   40efd:	89 05 1d 2f 01 00    	mov    %eax,0x12f1d(%rip)        # 53e20 <ticks>
        schedule();
   40f03:	e8 4b 01 00 00       	call   41053 <schedule>
        break;                  /* will not be reached */
   40f08:	e9 1d 01 00 00       	jmp    4102a <exception+0x691>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40f0d:	0f 20 d0             	mov    %cr2,%rax
   40f10:	48 89 45 80          	mov    %rax,-0x80(%rbp)
    return val;
   40f14:	48 8b 45 80          	mov    -0x80(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40f18:	48 89 45 98          	mov    %rax,-0x68(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40f1c:	48 8b 85 a8 fe ff ff 	mov    -0x158(%rbp),%rax
   40f23:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40f2a:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40f2d:	48 85 c0             	test   %rax,%rax
   40f30:	74 09                	je     40f3b <exception+0x5a2>
   40f32:	48 8d 05 37 3a 00 00 	lea    0x3a37(%rip),%rax        # 44970 <console_clear+0x84>
   40f39:	eb 07                	jmp    40f42 <exception+0x5a9>
   40f3b:	48 8d 05 34 3a 00 00 	lea    0x3a34(%rip),%rax        # 44976 <console_clear+0x8a>
        const char* operation = reg->reg_err & PFERR_WRITE
   40f42:	48 89 45 90          	mov    %rax,-0x70(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40f46:	48 8b 85 a8 fe ff ff 	mov    -0x158(%rbp),%rax
   40f4d:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40f54:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40f57:	48 85 c0             	test   %rax,%rax
   40f5a:	74 09                	je     40f65 <exception+0x5cc>
   40f5c:	48 8d 05 18 3a 00 00 	lea    0x3a18(%rip),%rax        # 4497b <console_clear+0x8f>
   40f63:	eb 07                	jmp    40f6c <exception+0x5d3>
   40f65:	48 8d 05 22 3a 00 00 	lea    0x3a22(%rip),%rax        # 4498e <console_clear+0xa2>
        const char* problem = reg->reg_err & PFERR_PRESENT
   40f6c:	48 89 45 88          	mov    %rax,-0x78(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40f70:	48 8b 85 a8 fe ff ff 	mov    -0x158(%rbp),%rax
   40f77:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40f7e:	83 e0 04             	and    $0x4,%eax
   40f81:	48 85 c0             	test   %rax,%rax
   40f84:	75 34                	jne    40fba <exception+0x621>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40f86:	48 8b 85 a8 fe ff ff 	mov    -0x158(%rbp),%rax
   40f8d:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40f94:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   40f98:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
   40f9c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40fa0:	49 89 f0             	mov    %rsi,%r8
   40fa3:	48 89 c6             	mov    %rax,%rsi
   40fa6:	48 8d 05 f3 39 00 00 	lea    0x39f3(%rip),%rax        # 449a0 <console_clear+0xb4>
   40fad:	48 89 c7             	mov    %rax,%rdi
   40fb0:	b8 00 00 00 00       	mov    $0x0,%eax
   40fb5:	e8 df 1b 00 00       	call   42b99 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40fba:	48 8b 85 a8 fe ff ff 	mov    -0x158(%rbp),%rax
   40fc1:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40fc8:	48 8b 05 31 20 01 00 	mov    0x12031(%rip),%rax        # 53000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40fcf:	8b 00                	mov    (%rax),%eax
   40fd1:	48 8b 75 90          	mov    -0x70(%rbp),%rsi
   40fd5:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   40fd9:	52                   	push   %rdx
   40fda:	ff 75 88             	push   -0x78(%rbp)
   40fdd:	49 89 f1             	mov    %rsi,%r9
   40fe0:	49 89 c8             	mov    %rcx,%r8
   40fe3:	89 c1                	mov    %eax,%ecx
   40fe5:	48 8d 05 e4 39 00 00 	lea    0x39e4(%rip),%rax        # 449d0 <console_clear+0xe4>
   40fec:	48 89 c2             	mov    %rax,%rdx
   40fef:	be 00 0c 00 00       	mov    $0xc00,%esi
   40ff4:	bf 80 07 00 00       	mov    $0x780,%edi
   40ff9:	b8 00 00 00 00       	mov    $0x0,%eax
   40ffe:	e8 73 37 00 00       	call   44776 <console_printf>
   41003:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   41007:	48 8b 05 f2 1f 01 00 	mov    0x11ff2(%rip),%rax        # 53000 <current>
   4100e:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   41015:	00 00 00 
        break;
   41018:	eb 10                	jmp    4102a <exception+0x691>
    }

    default:
        default_exception(current);
   4101a:	48 8b 05 df 1f 01 00 	mov    0x11fdf(%rip),%rax        # 53000 <current>
   41021:	48 89 c7             	mov    %rax,%rdi
   41024:	e8 99 1c 00 00       	call   42cc2 <default_exception>
        break;                  /* will not be reached */
   41029:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   4102a:	48 8b 05 cf 1f 01 00 	mov    0x11fcf(%rip),%rax        # 53000 <current>
   41031:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41037:	83 f8 01             	cmp    $0x1,%eax
   4103a:	75 0f                	jne    4104b <exception+0x6b2>
        run(current);
   4103c:	48 8b 05 bd 1f 01 00 	mov    0x11fbd(%rip),%rax        # 53000 <current>
   41043:	48 89 c7             	mov    %rax,%rdi
   41046:	e8 87 00 00 00       	call   410d2 <run>
    } else {
        schedule();
   4104b:	e8 03 00 00 00       	call   41053 <schedule>
    }
}
   41050:	90                   	nop
   41051:	c9                   	leave  
   41052:	c3                   	ret    

0000000000041053 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   41053:	f3 0f 1e fa          	endbr64 
   41057:	55                   	push   %rbp
   41058:	48 89 e5             	mov    %rsp,%rbp
   4105b:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   4105f:	48 8b 05 9a 1f 01 00 	mov    0x11f9a(%rip),%rax        # 53000 <current>
   41066:	8b 00                	mov    (%rax),%eax
   41068:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   4106b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4106e:	83 c0 01             	add    $0x1,%eax
   41071:	99                   	cltd   
   41072:	c1 ea 1c             	shr    $0x1c,%edx
   41075:	01 d0                	add    %edx,%eax
   41077:	83 e0 0f             	and    $0xf,%eax
   4107a:	29 d0                	sub    %edx,%eax
   4107c:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   4107f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41082:	48 63 d0             	movslq %eax,%rdx
   41085:	48 89 d0             	mov    %rdx,%rax
   41088:	48 c1 e0 03          	shl    $0x3,%rax
   4108c:	48 29 d0             	sub    %rdx,%rax
   4108f:	48 c1 e0 05          	shl    $0x5,%rax
   41093:	48 89 c2             	mov    %rax,%rdx
   41096:	48 8d 05 4b 20 01 00 	lea    0x1204b(%rip),%rax        # 530e8 <processes+0xc8>
   4109d:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   410a0:	83 f8 01             	cmp    $0x1,%eax
   410a3:	75 26                	jne    410cb <schedule+0x78>
            run(&processes[pid]);
   410a5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410a8:	48 63 d0             	movslq %eax,%rdx
   410ab:	48 89 d0             	mov    %rdx,%rax
   410ae:	48 c1 e0 03          	shl    $0x3,%rax
   410b2:	48 29 d0             	sub    %rdx,%rax
   410b5:	48 c1 e0 05          	shl    $0x5,%rax
   410b9:	48 8d 15 60 1f 01 00 	lea    0x11f60(%rip),%rdx        # 53020 <processes>
   410c0:	48 01 d0             	add    %rdx,%rax
   410c3:	48 89 c7             	mov    %rax,%rdi
   410c6:	e8 07 00 00 00       	call   410d2 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   410cb:	e8 67 19 00 00       	call   42a37 <check_keyboard>
        pid = (pid + 1) % NPROC;
   410d0:	eb 99                	jmp    4106b <schedule+0x18>

00000000000410d2 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   410d2:	f3 0f 1e fa          	endbr64 
   410d6:	55                   	push   %rbp
   410d7:	48 89 e5             	mov    %rsp,%rbp
   410da:	48 83 ec 10          	sub    $0x10,%rsp
   410de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   410e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410e6:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   410ec:	83 f8 01             	cmp    $0x1,%eax
   410ef:	74 1e                	je     4110f <run+0x3d>
   410f1:	48 8d 05 b4 39 00 00 	lea    0x39b4(%rip),%rax        # 44aac <console_clear+0x1c0>
   410f8:	48 89 c2             	mov    %rax,%rdx
   410fb:	be fc 01 00 00       	mov    $0x1fc,%esi
   41100:	48 8d 05 59 38 00 00 	lea    0x3859(%rip),%rax        # 44960 <console_clear+0x74>
   41107:	48 89 c7             	mov    %rax,%rdi
   4110a:	e8 7a 1b 00 00       	call   42c89 <assert_fail>
    current = p;
   4110f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41113:	48 89 05 e6 1e 01 00 	mov    %rax,0x11ee6(%rip)        # 53000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   4111a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4111e:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   41125:	48 89 c7             	mov    %rax,%rdi
   41128:	e8 6e 1d 00 00       	call   42e9b <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   4112d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41131:	48 83 c0 08          	add    $0x8,%rax
   41135:	48 89 c7             	mov    %rax,%rdi
   41138:	e8 86 ef ff ff       	call   400c3 <exception_return>

000000000004113d <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   4113d:	f3 0f 1e fa          	endbr64 
   41141:	55                   	push   %rbp
   41142:	48 89 e5             	mov    %rsp,%rbp
   41145:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   41149:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41150:	00 
   41151:	e9 93 00 00 00       	jmp    411e9 <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   41156:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4115a:	48 89 c7             	mov    %rax,%rdi
   4115d:	e8 0f 11 00 00       	call   42271 <physical_memory_isreserved>
   41162:	85 c0                	test   %eax,%eax
   41164:	74 09                	je     4116f <pageinfo_init+0x32>
            owner = PO_RESERVED;
   41166:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   4116d:	eb 31                	jmp    411a0 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   4116f:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   41176:	00 
   41177:	76 0d                	jbe    41186 <pageinfo_init+0x49>
   41179:	48 8d 05 88 ae 01 00 	lea    0x1ae88(%rip),%rax        # 5c008 <end>
   41180:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41184:	72 0a                	jb     41190 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   41186:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   4118d:	00 
   4118e:	75 09                	jne    41199 <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   41190:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   41197:	eb 07                	jmp    411a0 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   41199:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   411a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411a4:	48 c1 e8 0c          	shr    $0xc,%rax
   411a8:	89 c2                	mov    %eax,%edx
   411aa:	8b 45 f4             	mov    -0xc(%rbp),%eax
   411ad:	89 c1                	mov    %eax,%ecx
   411af:	48 63 c2             	movslq %edx,%rax
   411b2:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   411b6:	48 8d 05 83 2c 01 00 	lea    0x12c83(%rip),%rax        # 53e40 <pageinfo>
   411bd:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   411c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   411c4:	0f 95 c2             	setne  %dl
   411c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411cb:	48 c1 e8 0c          	shr    $0xc,%rax
   411cf:	89 d1                	mov    %edx,%ecx
   411d1:	48 98                	cltq   
   411d3:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   411d7:	48 8d 05 63 2c 01 00 	lea    0x12c63(%rip),%rax        # 53e41 <pageinfo+0x1>
   411de:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   411e1:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   411e8:	00 
   411e9:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   411f0:	00 
   411f1:	0f 86 5f ff ff ff    	jbe    41156 <pageinfo_init+0x19>
    }
}
   411f7:	90                   	nop
   411f8:	90                   	nop
   411f9:	c9                   	leave  
   411fa:	c3                   	ret    

00000000000411fb <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   411fb:	f3 0f 1e fa          	endbr64 
   411ff:	55                   	push   %rbp
   41200:	48 89 e5             	mov    %rsp,%rbp
   41203:	48 83 ec 50          	sub    $0x50,%rsp
   41207:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   4120b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4120f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41215:	48 89 c2             	mov    %rax,%rdx
   41218:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4121c:	48 39 c2             	cmp    %rax,%rdx
   4121f:	74 1e                	je     4123f <check_page_table_mappings+0x44>
   41221:	48 8d 05 a0 38 00 00 	lea    0x38a0(%rip),%rax        # 44ac8 <console_clear+0x1dc>
   41228:	48 89 c2             	mov    %rax,%rdx
   4122b:	be 26 02 00 00       	mov    $0x226,%esi
   41230:	48 8d 05 29 37 00 00 	lea    0x3729(%rip),%rax        # 44960 <console_clear+0x74>
   41237:	48 89 c7             	mov    %rax,%rdi
   4123a:	e8 4a 1a 00 00       	call   42c89 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   4123f:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   41246:	00 
   41247:	e9 b5 00 00 00       	jmp    41301 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   4124c:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   41250:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41254:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41258:	48 89 ce             	mov    %rcx,%rsi
   4125b:	48 89 c7             	mov    %rax,%rdi
   4125e:	e8 f4 21 00 00       	call   43457 <virtual_memory_lookup>
        if (vam.pa != va) {
   41263:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41267:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4126b:	74 2c                	je     41299 <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   4126d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   41271:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41275:	49 89 d0             	mov    %rdx,%r8
   41278:	48 89 c1             	mov    %rax,%rcx
   4127b:	48 8d 05 65 38 00 00 	lea    0x3865(%rip),%rax        # 44ae7 <console_clear+0x1fb>
   41282:	48 89 c2             	mov    %rax,%rdx
   41285:	be 00 c0 00 00       	mov    $0xc000,%esi
   4128a:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4128f:	b8 00 00 00 00       	mov    $0x0,%eax
   41294:	e8 dd 34 00 00       	call   44776 <console_printf>
        }
        assert(vam.pa == va);
   41299:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4129d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   412a1:	74 1e                	je     412c1 <check_page_table_mappings+0xc6>
   412a3:	48 8d 05 47 38 00 00 	lea    0x3847(%rip),%rax        # 44af1 <console_clear+0x205>
   412aa:	48 89 c2             	mov    %rax,%rdx
   412ad:	be 2f 02 00 00       	mov    $0x22f,%esi
   412b2:	48 8d 05 a7 36 00 00 	lea    0x36a7(%rip),%rax        # 44960 <console_clear+0x74>
   412b9:	48 89 c7             	mov    %rax,%rdi
   412bc:	e8 c8 19 00 00       	call   42c89 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   412c1:	48 8d 05 38 4d 00 00 	lea    0x4d38(%rip),%rax        # 46000 <disp_global>
   412c8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   412cc:	72 2b                	jb     412f9 <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   412ce:	8b 45 d0             	mov    -0x30(%rbp),%eax
   412d1:	48 98                	cltq   
   412d3:	83 e0 02             	and    $0x2,%eax
   412d6:	48 85 c0             	test   %rax,%rax
   412d9:	75 1e                	jne    412f9 <check_page_table_mappings+0xfe>
   412db:	48 8d 05 1c 38 00 00 	lea    0x381c(%rip),%rax        # 44afe <console_clear+0x212>
   412e2:	48 89 c2             	mov    %rax,%rdx
   412e5:	be 31 02 00 00       	mov    $0x231,%esi
   412ea:	48 8d 05 6f 36 00 00 	lea    0x366f(%rip),%rax        # 44960 <console_clear+0x74>
   412f1:	48 89 c7             	mov    %rax,%rdi
   412f4:	e8 90 19 00 00       	call   42c89 <assert_fail>
         va += PAGESIZE) {
   412f9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41300:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41301:	48 8d 05 00 ad 01 00 	lea    0x1ad00(%rip),%rax        # 5c008 <end>
   41308:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4130c:	0f 82 3a ff ff ff    	jb     4124c <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41312:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   41319:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   4131a:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   4131e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41322:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41326:	48 89 ce             	mov    %rcx,%rsi
   41329:	48 89 c7             	mov    %rax,%rdi
   4132c:	e8 26 21 00 00       	call   43457 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   41331:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41335:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   41339:	74 1e                	je     41359 <check_page_table_mappings+0x15e>
   4133b:	48 8d 05 cd 37 00 00 	lea    0x37cd(%rip),%rax        # 44b0f <console_clear+0x223>
   41342:	48 89 c2             	mov    %rax,%rdx
   41345:	be 38 02 00 00       	mov    $0x238,%esi
   4134a:	48 8d 05 0f 36 00 00 	lea    0x360f(%rip),%rax        # 44960 <console_clear+0x74>
   41351:	48 89 c7             	mov    %rax,%rdi
   41354:	e8 30 19 00 00       	call   42c89 <assert_fail>
    assert(vam.perm & PTE_W);
   41359:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4135c:	48 98                	cltq   
   4135e:	83 e0 02             	and    $0x2,%eax
   41361:	48 85 c0             	test   %rax,%rax
   41364:	75 1e                	jne    41384 <check_page_table_mappings+0x189>
   41366:	48 8d 05 91 37 00 00 	lea    0x3791(%rip),%rax        # 44afe <console_clear+0x212>
   4136d:	48 89 c2             	mov    %rax,%rdx
   41370:	be 39 02 00 00       	mov    $0x239,%esi
   41375:	48 8d 05 e4 35 00 00 	lea    0x35e4(%rip),%rax        # 44960 <console_clear+0x74>
   4137c:	48 89 c7             	mov    %rax,%rdi
   4137f:	e8 05 19 00 00       	call   42c89 <assert_fail>
}
   41384:	90                   	nop
   41385:	c9                   	leave  
   41386:	c3                   	ret    

0000000000041387 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   41387:	f3 0f 1e fa          	endbr64 
   4138b:	55                   	push   %rbp
   4138c:	48 89 e5             	mov    %rsp,%rbp
   4138f:	48 83 ec 20          	sub    $0x20,%rsp
   41393:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41397:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   4139a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4139d:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   413a0:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   413a7:	48 8b 05 52 4c 01 00 	mov    0x14c52(%rip),%rax        # 56000 <kernel_pagetable>
   413ae:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   413b2:	75 71                	jne    41425 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   413b4:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   413bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   413c2:	eb 5b                	jmp    4141f <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   413c4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   413c7:	48 63 d0             	movslq %eax,%rdx
   413ca:	48 89 d0             	mov    %rdx,%rax
   413cd:	48 c1 e0 03          	shl    $0x3,%rax
   413d1:	48 29 d0             	sub    %rdx,%rax
   413d4:	48 c1 e0 05          	shl    $0x5,%rax
   413d8:	48 89 c2             	mov    %rax,%rdx
   413db:	48 8d 05 06 1d 01 00 	lea    0x11d06(%rip),%rax        # 530e8 <processes+0xc8>
   413e2:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   413e5:	85 c0                	test   %eax,%eax
   413e7:	74 32                	je     4141b <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   413e9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   413ec:	48 63 d0             	movslq %eax,%rdx
   413ef:	48 89 d0             	mov    %rdx,%rax
   413f2:	48 c1 e0 03          	shl    $0x3,%rax
   413f6:	48 29 d0             	sub    %rdx,%rax
   413f9:	48 c1 e0 05          	shl    $0x5,%rax
   413fd:	48 89 c2             	mov    %rax,%rdx
   41400:	48 8d 05 e9 1c 01 00 	lea    0x11ce9(%rip),%rax        # 530f0 <processes+0xd0>
   41407:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   4140b:	48 8b 05 ee 4b 01 00 	mov    0x14bee(%rip),%rax        # 56000 <kernel_pagetable>
   41412:	48 39 c2             	cmp    %rax,%rdx
   41415:	75 04                	jne    4141b <check_page_table_ownership+0x94>
                ++expected_refcount;
   41417:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4141b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4141f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41423:	7e 9f                	jle    413c4 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41425:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41428:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4142b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4142f:	be 00 00 00 00       	mov    $0x0,%esi
   41434:	48 89 c7             	mov    %rax,%rdi
   41437:	e8 03 00 00 00       	call   4143f <check_page_table_ownership_level>
}
   4143c:	90                   	nop
   4143d:	c9                   	leave  
   4143e:	c3                   	ret    

000000000004143f <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   4143f:	f3 0f 1e fa          	endbr64 
   41443:	55                   	push   %rbp
   41444:	48 89 e5             	mov    %rsp,%rbp
   41447:	48 83 ec 30          	sub    $0x30,%rsp
   4144b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4144f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41452:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41455:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41458:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4145c:	48 c1 e8 0c          	shr    $0xc,%rax
   41460:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41465:	7e 1e                	jle    41485 <check_page_table_ownership_level+0x46>
   41467:	48 8d 05 b2 36 00 00 	lea    0x36b2(%rip),%rax        # 44b20 <console_clear+0x234>
   4146e:	48 89 c2             	mov    %rax,%rdx
   41471:	be 56 02 00 00       	mov    $0x256,%esi
   41476:	48 8d 05 e3 34 00 00 	lea    0x34e3(%rip),%rax        # 44960 <console_clear+0x74>
   4147d:	48 89 c7             	mov    %rax,%rdi
   41480:	e8 04 18 00 00       	call   42c89 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41485:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41489:	48 c1 e8 0c          	shr    $0xc,%rax
   4148d:	48 98                	cltq   
   4148f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41493:	48 8d 05 a6 29 01 00 	lea    0x129a6(%rip),%rax        # 53e40 <pageinfo>
   4149a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4149e:	0f be c0             	movsbl %al,%eax
   414a1:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   414a4:	74 1e                	je     414c4 <check_page_table_ownership_level+0x85>
   414a6:	48 8d 05 8b 36 00 00 	lea    0x368b(%rip),%rax        # 44b38 <console_clear+0x24c>
   414ad:	48 89 c2             	mov    %rax,%rdx
   414b0:	be 57 02 00 00       	mov    $0x257,%esi
   414b5:	48 8d 05 a4 34 00 00 	lea    0x34a4(%rip),%rax        # 44960 <console_clear+0x74>
   414bc:	48 89 c7             	mov    %rax,%rdi
   414bf:	e8 c5 17 00 00       	call   42c89 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   414c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   414c8:	48 c1 e8 0c          	shr    $0xc,%rax
   414cc:	48 98                	cltq   
   414ce:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   414d2:	48 8d 05 68 29 01 00 	lea    0x12968(%rip),%rax        # 53e41 <pageinfo+0x1>
   414d9:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   414dd:	0f be c0             	movsbl %al,%eax
   414e0:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   414e3:	74 1e                	je     41503 <check_page_table_ownership_level+0xc4>
   414e5:	48 8d 05 74 36 00 00 	lea    0x3674(%rip),%rax        # 44b60 <console_clear+0x274>
   414ec:	48 89 c2             	mov    %rax,%rdx
   414ef:	be 58 02 00 00       	mov    $0x258,%esi
   414f4:	48 8d 05 65 34 00 00 	lea    0x3465(%rip),%rax        # 44960 <console_clear+0x74>
   414fb:	48 89 c7             	mov    %rax,%rdi
   414fe:	e8 86 17 00 00       	call   42c89 <assert_fail>
    if (level < 3) {
   41503:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41507:	7f 5b                	jg     41564 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41509:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41510:	eb 49                	jmp    4155b <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   41512:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41516:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41519:	48 63 d2             	movslq %edx,%rdx
   4151c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41520:	48 85 c0             	test   %rax,%rax
   41523:	74 32                	je     41557 <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41525:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41529:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4152c:	48 63 d2             	movslq %edx,%rdx
   4152f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41533:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41539:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4153d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41540:	8d 70 01             	lea    0x1(%rax),%esi
   41543:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41546:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4154a:	b9 01 00 00 00       	mov    $0x1,%ecx
   4154f:	48 89 c7             	mov    %rax,%rdi
   41552:	e8 e8 fe ff ff       	call   4143f <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41557:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4155b:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41562:	7e ae                	jle    41512 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   41564:	90                   	nop
   41565:	c9                   	leave  
   41566:	c3                   	ret    

0000000000041567 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41567:	f3 0f 1e fa          	endbr64 
   4156b:	55                   	push   %rbp
   4156c:	48 89 e5             	mov    %rsp,%rbp
   4156f:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41573:	8b 05 6f 1b 01 00    	mov    0x11b6f(%rip),%eax        # 530e8 <processes+0xc8>
   41579:	85 c0                	test   %eax,%eax
   4157b:	74 1e                	je     4159b <check_virtual_memory+0x34>
   4157d:	48 8d 05 0c 36 00 00 	lea    0x360c(%rip),%rax        # 44b90 <console_clear+0x2a4>
   41584:	48 89 c2             	mov    %rax,%rdx
   41587:	be 6b 02 00 00       	mov    $0x26b,%esi
   4158c:	48 8d 05 cd 33 00 00 	lea    0x33cd(%rip),%rax        # 44960 <console_clear+0x74>
   41593:	48 89 c7             	mov    %rax,%rdi
   41596:	e8 ee 16 00 00       	call   42c89 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4159b:	48 8b 05 5e 4a 01 00 	mov    0x14a5e(%rip),%rax        # 56000 <kernel_pagetable>
   415a2:	48 89 c7             	mov    %rax,%rdi
   415a5:	e8 51 fc ff ff       	call   411fb <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   415aa:	48 8b 05 4f 4a 01 00 	mov    0x14a4f(%rip),%rax        # 56000 <kernel_pagetable>
   415b1:	be ff ff ff ff       	mov    $0xffffffff,%esi
   415b6:	48 89 c7             	mov    %rax,%rdi
   415b9:	e8 c9 fd ff ff       	call   41387 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   415be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   415c5:	e9 b4 00 00 00       	jmp    4167e <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   415ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
   415cd:	48 63 d0             	movslq %eax,%rdx
   415d0:	48 89 d0             	mov    %rdx,%rax
   415d3:	48 c1 e0 03          	shl    $0x3,%rax
   415d7:	48 29 d0             	sub    %rdx,%rax
   415da:	48 c1 e0 05          	shl    $0x5,%rax
   415de:	48 89 c2             	mov    %rax,%rdx
   415e1:	48 8d 05 00 1b 01 00 	lea    0x11b00(%rip),%rax        # 530e8 <processes+0xc8>
   415e8:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   415eb:	85 c0                	test   %eax,%eax
   415ed:	0f 84 87 00 00 00    	je     4167a <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   415f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   415f6:	48 63 d0             	movslq %eax,%rdx
   415f9:	48 89 d0             	mov    %rdx,%rax
   415fc:	48 c1 e0 03          	shl    $0x3,%rax
   41600:	48 29 d0             	sub    %rdx,%rax
   41603:	48 c1 e0 05          	shl    $0x5,%rax
   41607:	48 89 c2             	mov    %rax,%rdx
   4160a:	48 8d 05 df 1a 01 00 	lea    0x11adf(%rip),%rax        # 530f0 <processes+0xd0>
   41611:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   41615:	48 8b 05 e4 49 01 00 	mov    0x149e4(%rip),%rax        # 56000 <kernel_pagetable>
   4161c:	48 39 c2             	cmp    %rax,%rdx
   4161f:	74 59                	je     4167a <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   41621:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41624:	48 63 d0             	movslq %eax,%rdx
   41627:	48 89 d0             	mov    %rdx,%rax
   4162a:	48 c1 e0 03          	shl    $0x3,%rax
   4162e:	48 29 d0             	sub    %rdx,%rax
   41631:	48 c1 e0 05          	shl    $0x5,%rax
   41635:	48 89 c2             	mov    %rax,%rdx
   41638:	48 8d 05 b1 1a 01 00 	lea    0x11ab1(%rip),%rax        # 530f0 <processes+0xd0>
   4163f:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41643:	48 89 c7             	mov    %rax,%rdi
   41646:	e8 b0 fb ff ff       	call   411fb <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4164b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4164e:	48 63 d0             	movslq %eax,%rdx
   41651:	48 89 d0             	mov    %rdx,%rax
   41654:	48 c1 e0 03          	shl    $0x3,%rax
   41658:	48 29 d0             	sub    %rdx,%rax
   4165b:	48 c1 e0 05          	shl    $0x5,%rax
   4165f:	48 89 c2             	mov    %rax,%rdx
   41662:	48 8d 05 87 1a 01 00 	lea    0x11a87(%rip),%rax        # 530f0 <processes+0xd0>
   41669:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4166d:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41670:	89 d6                	mov    %edx,%esi
   41672:	48 89 c7             	mov    %rax,%rdi
   41675:	e8 0d fd ff ff       	call   41387 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   4167a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4167e:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41682:	0f 8e 42 ff ff ff    	jle    415ca <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41688:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4168f:	e9 8b 00 00 00       	jmp    4171f <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41694:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41697:	48 98                	cltq   
   41699:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4169d:	48 8d 05 9d 27 01 00 	lea    0x1279d(%rip),%rax        # 53e41 <pageinfo+0x1>
   416a4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   416a8:	84 c0                	test   %al,%al
   416aa:	7e 6f                	jle    4171b <check_virtual_memory+0x1b4>
   416ac:	8b 45 f8             	mov    -0x8(%rbp),%eax
   416af:	48 98                	cltq   
   416b1:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   416b5:	48 8d 05 84 27 01 00 	lea    0x12784(%rip),%rax        # 53e40 <pageinfo>
   416bc:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   416c0:	84 c0                	test   %al,%al
   416c2:	78 57                	js     4171b <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   416c4:	8b 45 f8             	mov    -0x8(%rbp),%eax
   416c7:	48 98                	cltq   
   416c9:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   416cd:	48 8d 05 6c 27 01 00 	lea    0x1276c(%rip),%rax        # 53e40 <pageinfo>
   416d4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   416d8:	0f be c0             	movsbl %al,%eax
   416db:	48 63 d0             	movslq %eax,%rdx
   416de:	48 89 d0             	mov    %rdx,%rax
   416e1:	48 c1 e0 03          	shl    $0x3,%rax
   416e5:	48 29 d0             	sub    %rdx,%rax
   416e8:	48 c1 e0 05          	shl    $0x5,%rax
   416ec:	48 89 c2             	mov    %rax,%rdx
   416ef:	48 8d 05 f2 19 01 00 	lea    0x119f2(%rip),%rax        # 530e8 <processes+0xc8>
   416f6:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   416f9:	85 c0                	test   %eax,%eax
   416fb:	75 1e                	jne    4171b <check_virtual_memory+0x1b4>
   416fd:	48 8d 05 ac 34 00 00 	lea    0x34ac(%rip),%rax        # 44bb0 <console_clear+0x2c4>
   41704:	48 89 c2             	mov    %rax,%rdx
   41707:	be 82 02 00 00       	mov    $0x282,%esi
   4170c:	48 8d 05 4d 32 00 00 	lea    0x324d(%rip),%rax        # 44960 <console_clear+0x74>
   41713:	48 89 c7             	mov    %rax,%rdi
   41716:	e8 6e 15 00 00       	call   42c89 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4171b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4171f:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41726:	0f 8e 68 ff ff ff    	jle    41694 <check_virtual_memory+0x12d>
        }
    }
}
   4172c:	90                   	nop
   4172d:	90                   	nop
   4172e:	c9                   	leave  
   4172f:	c3                   	ret    

0000000000041730 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41730:	f3 0f 1e fa          	endbr64 
   41734:	55                   	push   %rbp
   41735:	48 89 e5             	mov    %rsp,%rbp
   41738:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4173c:	48 8d 05 c3 34 00 00 	lea    0x34c3(%rip),%rax        # 44c06 <memstate_colors+0x26>
   41743:	48 89 c2             	mov    %rax,%rdx
   41746:	be 00 0f 00 00       	mov    $0xf00,%esi
   4174b:	bf 20 00 00 00       	mov    $0x20,%edi
   41750:	b8 00 00 00 00       	mov    $0x0,%eax
   41755:	e8 1c 30 00 00       	call   44776 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4175a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41761:	e9 1b 01 00 00       	jmp    41881 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   41766:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41769:	83 e0 3f             	and    $0x3f,%eax
   4176c:	85 c0                	test   %eax,%eax
   4176e:	75 40                	jne    417b0 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41770:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41773:	c1 e0 0c             	shl    $0xc,%eax
   41776:	89 c2                	mov    %eax,%edx
   41778:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4177b:	8d 48 3f             	lea    0x3f(%rax),%ecx
   4177e:	85 c0                	test   %eax,%eax
   41780:	0f 48 c1             	cmovs  %ecx,%eax
   41783:	c1 f8 06             	sar    $0x6,%eax
   41786:	8d 48 01             	lea    0x1(%rax),%ecx
   41789:	89 c8                	mov    %ecx,%eax
   4178b:	c1 e0 02             	shl    $0x2,%eax
   4178e:	01 c8                	add    %ecx,%eax
   41790:	c1 e0 04             	shl    $0x4,%eax
   41793:	83 c0 03             	add    $0x3,%eax
   41796:	89 d1                	mov    %edx,%ecx
   41798:	48 8d 15 77 34 00 00 	lea    0x3477(%rip),%rdx        # 44c16 <memstate_colors+0x36>
   4179f:	be 00 0f 00 00       	mov    $0xf00,%esi
   417a4:	89 c7                	mov    %eax,%edi
   417a6:	b8 00 00 00 00       	mov    $0x0,%eax
   417ab:	e8 c6 2f 00 00       	call   44776 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   417b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417b3:	48 98                	cltq   
   417b5:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   417b9:	48 8d 05 80 26 01 00 	lea    0x12680(%rip),%rax        # 53e40 <pageinfo>
   417c0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   417c4:	0f be c0             	movsbl %al,%eax
   417c7:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   417ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417cd:	48 98                	cltq   
   417cf:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   417d3:	48 8d 05 67 26 01 00 	lea    0x12667(%rip),%rax        # 53e41 <pageinfo+0x1>
   417da:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   417de:	84 c0                	test   %al,%al
   417e0:	75 07                	jne    417e9 <memshow_physical+0xb9>
            owner = PO_FREE;
   417e2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   417e9:	8b 45 f8             	mov    -0x8(%rbp),%eax
   417ec:	83 c0 02             	add    $0x2,%eax
   417ef:	48 98                	cltq   
   417f1:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   417f5:	48 8d 05 e4 33 00 00 	lea    0x33e4(%rip),%rax        # 44be0 <memstate_colors>
   417fc:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41800:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41804:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41807:	48 98                	cltq   
   41809:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4180d:	48 8d 05 2d 26 01 00 	lea    0x1262d(%rip),%rax        # 53e41 <pageinfo+0x1>
   41814:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41818:	3c 01                	cmp    $0x1,%al
   4181a:	7e 1c                	jle    41838 <memshow_physical+0x108>
   4181c:	48 8d 05 dd 67 07 00 	lea    0x767dd(%rip),%rax        # b8000 <console>
   41823:	48 c1 e8 0c          	shr    $0xc,%rax
   41827:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4182a:	74 0c                	je     41838 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4182c:	b8 53 00 00 00       	mov    $0x53,%eax
   41831:	80 cc 0f             	or     $0xf,%ah
   41834:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41838:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4183b:	8d 50 3f             	lea    0x3f(%rax),%edx
   4183e:	85 c0                	test   %eax,%eax
   41840:	0f 48 c2             	cmovs  %edx,%eax
   41843:	c1 f8 06             	sar    $0x6,%eax
   41846:	8d 50 01             	lea    0x1(%rax),%edx
   41849:	89 d0                	mov    %edx,%eax
   4184b:	c1 e0 02             	shl    $0x2,%eax
   4184e:	01 d0                	add    %edx,%eax
   41850:	c1 e0 04             	shl    $0x4,%eax
   41853:	89 c1                	mov    %eax,%ecx
   41855:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41858:	99                   	cltd   
   41859:	c1 ea 1a             	shr    $0x1a,%edx
   4185c:	01 d0                	add    %edx,%eax
   4185e:	83 e0 3f             	and    $0x3f,%eax
   41861:	29 d0                	sub    %edx,%eax
   41863:	83 c0 0c             	add    $0xc,%eax
   41866:	01 c8                	add    %ecx,%eax
   41868:	48 98                	cltq   
   4186a:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4186e:	48 8d 15 8b 67 07 00 	lea    0x7678b(%rip),%rdx        # b8000 <console>
   41875:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41879:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4187d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41881:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41888:	0f 8e d8 fe ff ff    	jle    41766 <memshow_physical+0x36>
    }
}
   4188e:	90                   	nop
   4188f:	90                   	nop
   41890:	c9                   	leave  
   41891:	c3                   	ret    

0000000000041892 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41892:	f3 0f 1e fa          	endbr64 
   41896:	55                   	push   %rbp
   41897:	48 89 e5             	mov    %rsp,%rbp
   4189a:	48 83 ec 40          	sub    $0x40,%rsp
   4189e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   418a2:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   418a6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   418aa:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   418b0:	48 89 c2             	mov    %rax,%rdx
   418b3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   418b7:	48 39 c2             	cmp    %rax,%rdx
   418ba:	74 1e                	je     418da <memshow_virtual+0x48>
   418bc:	48 8d 05 5d 33 00 00 	lea    0x335d(%rip),%rax        # 44c20 <memstate_colors+0x40>
   418c3:	48 89 c2             	mov    %rax,%rdx
   418c6:	be b3 02 00 00       	mov    $0x2b3,%esi
   418cb:	48 8d 05 8e 30 00 00 	lea    0x308e(%rip),%rax        # 44960 <console_clear+0x74>
   418d2:	48 89 c7             	mov    %rax,%rdi
   418d5:	e8 af 13 00 00       	call   42c89 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   418da:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   418de:	48 89 c1             	mov    %rax,%rcx
   418e1:	48 8d 05 65 33 00 00 	lea    0x3365(%rip),%rax        # 44c4d <memstate_colors+0x6d>
   418e8:	48 89 c2             	mov    %rax,%rdx
   418eb:	be 00 0f 00 00       	mov    $0xf00,%esi
   418f0:	bf 3a 03 00 00       	mov    $0x33a,%edi
   418f5:	b8 00 00 00 00       	mov    $0x0,%eax
   418fa:	e8 77 2e 00 00       	call   44776 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   418ff:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41906:	00 
   41907:	e9 b4 01 00 00       	jmp    41ac0 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4190c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41910:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41914:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41918:	48 89 ce             	mov    %rcx,%rsi
   4191b:	48 89 c7             	mov    %rax,%rdi
   4191e:	e8 34 1b 00 00       	call   43457 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41923:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41926:	85 c0                	test   %eax,%eax
   41928:	79 0b                	jns    41935 <memshow_virtual+0xa3>
            color = ' ';
   4192a:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41930:	e9 ff 00 00 00       	jmp    41a34 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41935:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41939:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4193f:	76 1e                	jbe    4195f <memshow_virtual+0xcd>
   41941:	48 8d 05 22 33 00 00 	lea    0x3322(%rip),%rax        # 44c6a <memstate_colors+0x8a>
   41948:	48 89 c2             	mov    %rax,%rdx
   4194b:	be bc 02 00 00       	mov    $0x2bc,%esi
   41950:	48 8d 05 09 30 00 00 	lea    0x3009(%rip),%rax        # 44960 <console_clear+0x74>
   41957:	48 89 c7             	mov    %rax,%rdi
   4195a:	e8 2a 13 00 00       	call   42c89 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   4195f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41962:	48 98                	cltq   
   41964:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41968:	48 8d 05 d1 24 01 00 	lea    0x124d1(%rip),%rax        # 53e40 <pageinfo>
   4196f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41973:	0f be c0             	movsbl %al,%eax
   41976:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41979:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4197c:	48 98                	cltq   
   4197e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41982:	48 8d 05 b8 24 01 00 	lea    0x124b8(%rip),%rax        # 53e41 <pageinfo+0x1>
   41989:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4198d:	84 c0                	test   %al,%al
   4198f:	75 07                	jne    41998 <memshow_virtual+0x106>
                owner = PO_FREE;
   41991:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41998:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4199b:	83 c0 02             	add    $0x2,%eax
   4199e:	48 98                	cltq   
   419a0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   419a4:	48 8d 05 35 32 00 00 	lea    0x3235(%rip),%rax        # 44be0 <memstate_colors>
   419ab:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   419af:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   419b3:	8b 45 e0             	mov    -0x20(%rbp),%eax
   419b6:	48 98                	cltq   
   419b8:	83 e0 04             	and    $0x4,%eax
   419bb:	48 85 c0             	test   %rax,%rax
   419be:	74 27                	je     419e7 <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   419c0:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419c4:	c1 e0 04             	shl    $0x4,%eax
   419c7:	66 25 00 f0          	and    $0xf000,%ax
   419cb:	89 c2                	mov    %eax,%edx
   419cd:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419d1:	c1 f8 04             	sar    $0x4,%eax
   419d4:	66 25 00 0f          	and    $0xf00,%ax
   419d8:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   419da:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419de:	0f b6 c0             	movzbl %al,%eax
   419e1:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   419e3:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   419e7:	8b 45 d0             	mov    -0x30(%rbp),%eax
   419ea:	48 98                	cltq   
   419ec:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   419f0:	48 8d 05 4a 24 01 00 	lea    0x1244a(%rip),%rax        # 53e41 <pageinfo+0x1>
   419f7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   419fb:	3c 01                	cmp    $0x1,%al
   419fd:	7e 35                	jle    41a34 <memshow_virtual+0x1a2>
   419ff:	48 8d 05 fa 65 07 00 	lea    0x765fa(%rip),%rax        # b8000 <console>
   41a06:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41a0a:	74 28                	je     41a34 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41a0c:	b8 53 00 00 00       	mov    $0x53,%eax
   41a11:	89 c2                	mov    %eax,%edx
   41a13:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41a17:	66 25 00 f0          	and    $0xf000,%ax
   41a1b:	09 d0                	or     %edx,%eax
   41a1d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41a21:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41a24:	48 98                	cltq   
   41a26:	83 e0 04             	and    $0x4,%eax
   41a29:	48 85 c0             	test   %rax,%rax
   41a2c:	75 06                	jne    41a34 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   41a2e:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41a34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a38:	48 c1 e8 0c          	shr    $0xc,%rax
   41a3c:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41a3f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a42:	83 e0 3f             	and    $0x3f,%eax
   41a45:	85 c0                	test   %eax,%eax
   41a47:	75 39                	jne    41a82 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41a49:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a4c:	c1 e8 06             	shr    $0x6,%eax
   41a4f:	89 c2                	mov    %eax,%edx
   41a51:	89 d0                	mov    %edx,%eax
   41a53:	c1 e0 02             	shl    $0x2,%eax
   41a56:	01 d0                	add    %edx,%eax
   41a58:	c1 e0 04             	shl    $0x4,%eax
   41a5b:	05 73 03 00 00       	add    $0x373,%eax
   41a60:	89 c7                	mov    %eax,%edi
   41a62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a66:	48 89 c1             	mov    %rax,%rcx
   41a69:	48 8d 05 a6 31 00 00 	lea    0x31a6(%rip),%rax        # 44c16 <memstate_colors+0x36>
   41a70:	48 89 c2             	mov    %rax,%rdx
   41a73:	be 00 0f 00 00       	mov    $0xf00,%esi
   41a78:	b8 00 00 00 00       	mov    $0x0,%eax
   41a7d:	e8 f4 2c 00 00       	call   44776 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41a82:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a85:	c1 e8 06             	shr    $0x6,%eax
   41a88:	89 c2                	mov    %eax,%edx
   41a8a:	89 d0                	mov    %edx,%eax
   41a8c:	c1 e0 02             	shl    $0x2,%eax
   41a8f:	01 d0                	add    %edx,%eax
   41a91:	c1 e0 04             	shl    $0x4,%eax
   41a94:	89 c2                	mov    %eax,%edx
   41a96:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a99:	83 e0 3f             	and    $0x3f,%eax
   41a9c:	01 d0                	add    %edx,%eax
   41a9e:	05 7c 03 00 00       	add    $0x37c,%eax
   41aa3:	89 c0                	mov    %eax,%eax
   41aa5:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41aa9:	48 8d 15 50 65 07 00 	lea    0x76550(%rip),%rdx        # b8000 <console>
   41ab0:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41ab4:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41ab8:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41abf:	00 
   41ac0:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41ac7:	00 
   41ac8:	0f 86 3e fe ff ff    	jbe    4190c <memshow_virtual+0x7a>
    }
}
   41ace:	90                   	nop
   41acf:	90                   	nop
   41ad0:	c9                   	leave  
   41ad1:	c3                   	ret    

0000000000041ad2 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41ad2:	f3 0f 1e fa          	endbr64 
   41ad6:	55                   	push   %rbp
   41ad7:	48 89 e5             	mov    %rsp,%rbp
   41ada:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41ade:	8b 05 5c 27 01 00    	mov    0x1275c(%rip),%eax        # 54240 <last_ticks.1>
   41ae4:	85 c0                	test   %eax,%eax
   41ae6:	74 13                	je     41afb <memshow_virtual_animate+0x29>
   41ae8:	8b 05 32 23 01 00    	mov    0x12332(%rip),%eax        # 53e20 <ticks>
   41aee:	8b 15 4c 27 01 00    	mov    0x1274c(%rip),%edx        # 54240 <last_ticks.1>
   41af4:	29 d0                	sub    %edx,%eax
   41af6:	83 f8 31             	cmp    $0x31,%eax
   41af9:	76 2c                	jbe    41b27 <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   41afb:	8b 05 1f 23 01 00    	mov    0x1231f(%rip),%eax        # 53e20 <ticks>
   41b01:	89 05 39 27 01 00    	mov    %eax,0x12739(%rip)        # 54240 <last_ticks.1>
        ++showing;
   41b07:	8b 05 f7 44 00 00    	mov    0x44f7(%rip),%eax        # 46004 <showing.0>
   41b0d:	83 c0 01             	add    $0x1,%eax
   41b10:	89 05 ee 44 00 00    	mov    %eax,0x44ee(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41b16:	eb 0f                	jmp    41b27 <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41b18:	8b 05 e6 44 00 00    	mov    0x44e6(%rip),%eax        # 46004 <showing.0>
   41b1e:	83 c0 01             	add    $0x1,%eax
   41b21:	89 05 dd 44 00 00    	mov    %eax,0x44dd(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41b27:	8b 05 d7 44 00 00    	mov    0x44d7(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41b2d:	83 f8 20             	cmp    $0x20,%eax
   41b30:	7f 6b                	jg     41b9d <memshow_virtual_animate+0xcb>
   41b32:	8b 05 cc 44 00 00    	mov    0x44cc(%rip),%eax        # 46004 <showing.0>
   41b38:	99                   	cltd   
   41b39:	c1 ea 1c             	shr    $0x1c,%edx
   41b3c:	01 d0                	add    %edx,%eax
   41b3e:	83 e0 0f             	and    $0xf,%eax
   41b41:	29 d0                	sub    %edx,%eax
   41b43:	48 63 d0             	movslq %eax,%rdx
   41b46:	48 89 d0             	mov    %rdx,%rax
   41b49:	48 c1 e0 03          	shl    $0x3,%rax
   41b4d:	48 29 d0             	sub    %rdx,%rax
   41b50:	48 c1 e0 05          	shl    $0x5,%rax
   41b54:	48 89 c2             	mov    %rax,%rdx
   41b57:	48 8d 05 8a 15 01 00 	lea    0x1158a(%rip),%rax        # 530e8 <processes+0xc8>
   41b5e:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41b61:	85 c0                	test   %eax,%eax
   41b63:	74 b3                	je     41b18 <memshow_virtual_animate+0x46>
   41b65:	8b 05 99 44 00 00    	mov    0x4499(%rip),%eax        # 46004 <showing.0>
   41b6b:	99                   	cltd   
   41b6c:	c1 ea 1c             	shr    $0x1c,%edx
   41b6f:	01 d0                	add    %edx,%eax
   41b71:	83 e0 0f             	and    $0xf,%eax
   41b74:	29 d0                	sub    %edx,%eax
   41b76:	48 63 d0             	movslq %eax,%rdx
   41b79:	48 89 d0             	mov    %rdx,%rax
   41b7c:	48 c1 e0 03          	shl    $0x3,%rax
   41b80:	48 29 d0             	sub    %rdx,%rax
   41b83:	48 c1 e0 05          	shl    $0x5,%rax
   41b87:	48 89 c2             	mov    %rax,%rdx
   41b8a:	48 8d 05 67 15 01 00 	lea    0x11567(%rip),%rax        # 530f8 <processes+0xd8>
   41b91:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41b95:	84 c0                	test   %al,%al
   41b97:	0f 84 7b ff ff ff    	je     41b18 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   41b9d:	8b 05 61 44 00 00    	mov    0x4461(%rip),%eax        # 46004 <showing.0>
   41ba3:	99                   	cltd   
   41ba4:	c1 ea 1c             	shr    $0x1c,%edx
   41ba7:	01 d0                	add    %edx,%eax
   41ba9:	83 e0 0f             	and    $0xf,%eax
   41bac:	29 d0                	sub    %edx,%eax
   41bae:	89 05 50 44 00 00    	mov    %eax,0x4450(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41bb4:	8b 05 4a 44 00 00    	mov    0x444a(%rip),%eax        # 46004 <showing.0>
   41bba:	48 63 d0             	movslq %eax,%rdx
   41bbd:	48 89 d0             	mov    %rdx,%rax
   41bc0:	48 c1 e0 03          	shl    $0x3,%rax
   41bc4:	48 29 d0             	sub    %rdx,%rax
   41bc7:	48 c1 e0 05          	shl    $0x5,%rax
   41bcb:	48 89 c2             	mov    %rax,%rdx
   41bce:	48 8d 05 13 15 01 00 	lea    0x11513(%rip),%rax        # 530e8 <processes+0xc8>
   41bd5:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41bd8:	85 c0                	test   %eax,%eax
   41bda:	74 59                	je     41c35 <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41bdc:	8b 15 22 44 00 00    	mov    0x4422(%rip),%edx        # 46004 <showing.0>
   41be2:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41be6:	89 d1                	mov    %edx,%ecx
   41be8:	48 8d 15 95 30 00 00 	lea    0x3095(%rip),%rdx        # 44c84 <memstate_colors+0xa4>
   41bef:	be 04 00 00 00       	mov    $0x4,%esi
   41bf4:	48 89 c7             	mov    %rax,%rdi
   41bf7:	b8 00 00 00 00       	mov    $0x0,%eax
   41bfc:	e8 90 2c 00 00       	call   44891 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41c01:	8b 05 fd 43 00 00    	mov    0x43fd(%rip),%eax        # 46004 <showing.0>
   41c07:	48 63 d0             	movslq %eax,%rdx
   41c0a:	48 89 d0             	mov    %rdx,%rax
   41c0d:	48 c1 e0 03          	shl    $0x3,%rax
   41c11:	48 29 d0             	sub    %rdx,%rax
   41c14:	48 c1 e0 05          	shl    $0x5,%rax
   41c18:	48 89 c2             	mov    %rax,%rdx
   41c1b:	48 8d 05 ce 14 01 00 	lea    0x114ce(%rip),%rax        # 530f0 <processes+0xd0>
   41c22:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41c26:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41c2a:	48 89 d6             	mov    %rdx,%rsi
   41c2d:	48 89 c7             	mov    %rax,%rdi
   41c30:	e8 5d fc ff ff       	call   41892 <memshow_virtual>
    }
}
   41c35:	90                   	nop
   41c36:	c9                   	leave  
   41c37:	c3                   	ret    

0000000000041c38 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41c38:	f3 0f 1e fa          	endbr64 
   41c3c:	55                   	push   %rbp
   41c3d:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41c40:	e8 5f 01 00 00       	call   41da4 <segments_init>
    interrupt_init();
   41c45:	e8 44 04 00 00       	call   4208e <interrupt_init>
    virtual_memory_init();
   41c4a:	e8 11 11 00 00       	call   42d60 <virtual_memory_init>
}
   41c4f:	90                   	nop
   41c50:	5d                   	pop    %rbp
   41c51:	c3                   	ret    

0000000000041c52 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41c52:	f3 0f 1e fa          	endbr64 
   41c56:	55                   	push   %rbp
   41c57:	48 89 e5             	mov    %rsp,%rbp
   41c5a:	48 83 ec 18          	sub    $0x18,%rsp
   41c5e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41c62:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41c66:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41c69:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41c6c:	48 98                	cltq   
   41c6e:	48 c1 e0 2d          	shl    $0x2d,%rax
   41c72:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41c76:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41c7d:	90 00 00 
   41c80:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41c83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c87:	48 89 10             	mov    %rdx,(%rax)
}
   41c8a:	90                   	nop
   41c8b:	c9                   	leave  
   41c8c:	c3                   	ret    

0000000000041c8d <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41c8d:	f3 0f 1e fa          	endbr64 
   41c91:	55                   	push   %rbp
   41c92:	48 89 e5             	mov    %rsp,%rbp
   41c95:	48 83 ec 28          	sub    $0x28,%rsp
   41c99:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41c9d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41ca1:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41ca4:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41ca8:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41cac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41cb0:	48 c1 e0 10          	shl    $0x10,%rax
   41cb4:	48 89 c2             	mov    %rax,%rdx
   41cb7:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41cbe:	00 00 00 
   41cc1:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41cc4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41cc8:	48 c1 e0 20          	shl    $0x20,%rax
   41ccc:	48 89 c1             	mov    %rax,%rcx
   41ccf:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41cd6:	00 00 ff 
   41cd9:	48 21 c8             	and    %rcx,%rax
   41cdc:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41cdf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41ce3:	48 83 e8 01          	sub    $0x1,%rax
   41ce7:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41cea:	48 09 d0             	or     %rdx,%rax
        | type
   41ced:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41cf1:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41cf4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41cf7:	48 98                	cltq   
   41cf9:	48 c1 e0 2d          	shl    $0x2d,%rax
   41cfd:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41d00:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41d07:	80 00 00 
   41d0a:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41d0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d11:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41d14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d18:	48 83 c0 08          	add    $0x8,%rax
   41d1c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41d20:	48 c1 ea 20          	shr    $0x20,%rdx
   41d24:	48 89 10             	mov    %rdx,(%rax)
}
   41d27:	90                   	nop
   41d28:	c9                   	leave  
   41d29:	c3                   	ret    

0000000000041d2a <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41d2a:	f3 0f 1e fa          	endbr64 
   41d2e:	55                   	push   %rbp
   41d2f:	48 89 e5             	mov    %rsp,%rbp
   41d32:	48 83 ec 20          	sub    $0x20,%rsp
   41d36:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41d3a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41d3e:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41d41:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41d45:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d49:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41d4c:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41d50:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41d53:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41d56:	48 98                	cltq   
   41d58:	48 c1 e0 2d          	shl    $0x2d,%rax
   41d5c:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41d5f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d63:	48 c1 e0 20          	shl    $0x20,%rax
   41d67:	48 89 c1             	mov    %rax,%rcx
   41d6a:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41d71:	00 ff ff 
   41d74:	48 21 c8             	and    %rcx,%rax
   41d77:	48 09 c2             	or     %rax,%rdx
   41d7a:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41d81:	80 00 00 
   41d84:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41d87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d8b:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41d8e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d92:	48 c1 e8 20          	shr    $0x20,%rax
   41d96:	48 89 c2             	mov    %rax,%rdx
   41d99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d9d:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41da1:	90                   	nop
   41da2:	c9                   	leave  
   41da3:	c3                   	ret    

0000000000041da4 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41da4:	f3 0f 1e fa          	endbr64 
   41da8:	55                   	push   %rbp
   41da9:	48 89 e5             	mov    %rsp,%rbp
   41dac:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41db0:	48 c7 05 a5 24 01 00 	movq   $0x0,0x124a5(%rip)        # 54260 <segments>
   41db7:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41dbb:	ba 00 00 00 00       	mov    $0x0,%edx
   41dc0:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41dc7:	08 20 00 
   41dca:	48 89 c6             	mov    %rax,%rsi
   41dcd:	48 8d 05 94 24 01 00 	lea    0x12494(%rip),%rax        # 54268 <segments+0x8>
   41dd4:	48 89 c7             	mov    %rax,%rdi
   41dd7:	e8 76 fe ff ff       	call   41c52 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41ddc:	ba 03 00 00 00       	mov    $0x3,%edx
   41de1:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41de8:	08 20 00 
   41deb:	48 89 c6             	mov    %rax,%rsi
   41dee:	48 8d 05 7b 24 01 00 	lea    0x1247b(%rip),%rax        # 54270 <segments+0x10>
   41df5:	48 89 c7             	mov    %rax,%rdi
   41df8:	e8 55 fe ff ff       	call   41c52 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41dfd:	ba 00 00 00 00       	mov    $0x0,%edx
   41e02:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41e09:	02 00 00 
   41e0c:	48 89 c6             	mov    %rax,%rsi
   41e0f:	48 8d 05 62 24 01 00 	lea    0x12462(%rip),%rax        # 54278 <segments+0x18>
   41e16:	48 89 c7             	mov    %rax,%rdi
   41e19:	e8 34 fe ff ff       	call   41c52 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41e1e:	ba 03 00 00 00       	mov    $0x3,%edx
   41e23:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41e2a:	02 00 00 
   41e2d:	48 89 c6             	mov    %rax,%rsi
   41e30:	48 8d 05 49 24 01 00 	lea    0x12449(%rip),%rax        # 54280 <segments+0x20>
   41e37:	48 89 c7             	mov    %rax,%rdi
   41e3a:	e8 13 fe ff ff       	call   41c52 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41e3f:	48 8d 05 5a 34 01 00 	lea    0x1345a(%rip),%rax        # 552a0 <kernel_task_descriptor>
   41e46:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41e4c:	48 89 c1             	mov    %rax,%rcx
   41e4f:	ba 00 00 00 00       	mov    $0x0,%edx
   41e54:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41e5b:	09 00 00 
   41e5e:	48 89 c6             	mov    %rax,%rsi
   41e61:	48 8d 05 20 24 01 00 	lea    0x12420(%rip),%rax        # 54288 <segments+0x28>
   41e68:	48 89 c7             	mov    %rax,%rdi
   41e6b:	e8 1d fe ff ff       	call   41c8d <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41e70:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41e76:	48 8d 05 e3 23 01 00 	lea    0x123e3(%rip),%rax        # 54260 <segments>
   41e7d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41e81:	ba 60 00 00 00       	mov    $0x60,%edx
   41e86:	be 00 00 00 00       	mov    $0x0,%esi
   41e8b:	48 8d 05 0e 34 01 00 	lea    0x1340e(%rip),%rax        # 552a0 <kernel_task_descriptor>
   41e92:	48 89 c7             	mov    %rax,%rdi
   41e95:	e8 9d 1a 00 00       	call   43937 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41e9a:	48 c7 05 ff 33 01 00 	movq   $0x80000,0x133ff(%rip)        # 552a4 <kernel_task_descriptor+0x4>
   41ea1:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41ea5:	ba 00 10 00 00       	mov    $0x1000,%edx
   41eaa:	be 00 00 00 00       	mov    $0x0,%esi
   41eaf:	48 8d 05 ea 23 01 00 	lea    0x123ea(%rip),%rax        # 542a0 <interrupt_descriptors>
   41eb6:	48 89 c7             	mov    %rax,%rdi
   41eb9:	e8 79 1a 00 00       	call   43937 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41ebe:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41ec5:	eb 3c                	jmp    41f03 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41ec7:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   41ece:	48 89 c2             	mov    %rax,%rdx
   41ed1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ed4:	48 c1 e0 04          	shl    $0x4,%rax
   41ed8:	48 89 c1             	mov    %rax,%rcx
   41edb:	48 8d 05 be 23 01 00 	lea    0x123be(%rip),%rax        # 542a0 <interrupt_descriptors>
   41ee2:	48 01 c8             	add    %rcx,%rax
   41ee5:	48 89 d1             	mov    %rdx,%rcx
   41ee8:	ba 00 00 00 00       	mov    $0x0,%edx
   41eed:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41ef4:	0e 00 00 
   41ef7:	48 89 c7             	mov    %rax,%rdi
   41efa:	e8 2b fe ff ff       	call   41d2a <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41eff:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41f03:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41f0a:	76 bb                	jbe    41ec7 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41f0c:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   41f13:	48 89 c1             	mov    %rax,%rcx
   41f16:	ba 00 00 00 00       	mov    $0x0,%edx
   41f1b:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41f22:	0e 00 00 
   41f25:	48 89 c6             	mov    %rax,%rsi
   41f28:	48 8d 05 71 25 01 00 	lea    0x12571(%rip),%rax        # 544a0 <interrupt_descriptors+0x200>
   41f2f:	48 89 c7             	mov    %rax,%rdi
   41f32:	e8 f3 fd ff ff       	call   41d2a <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41f37:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   41f3e:	48 89 c1             	mov    %rax,%rcx
   41f41:	ba 00 00 00 00       	mov    $0x0,%edx
   41f46:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41f4d:	0e 00 00 
   41f50:	48 89 c6             	mov    %rax,%rsi
   41f53:	48 8d 05 16 24 01 00 	lea    0x12416(%rip),%rax        # 54370 <interrupt_descriptors+0xd0>
   41f5a:	48 89 c7             	mov    %rax,%rdi
   41f5d:	e8 c8 fd ff ff       	call   41d2a <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41f62:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   41f69:	48 89 c1             	mov    %rax,%rcx
   41f6c:	ba 00 00 00 00       	mov    $0x0,%edx
   41f71:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41f78:	0e 00 00 
   41f7b:	48 89 c6             	mov    %rax,%rsi
   41f7e:	48 8d 05 fb 23 01 00 	lea    0x123fb(%rip),%rax        # 54380 <interrupt_descriptors+0xe0>
   41f85:	48 89 c7             	mov    %rax,%rdi
   41f88:	e8 9d fd ff ff       	call   41d2a <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41f8d:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41f94:	eb 50                	jmp    41fe6 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41f96:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f99:	83 e8 30             	sub    $0x30,%eax
   41f9c:	89 c0                	mov    %eax,%eax
   41f9e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   41fa5:	00 
   41fa6:	48 8d 05 3a e1 ff ff 	lea    -0x1ec6(%rip),%rax        # 400e7 <sys_int_handlers>
   41fad:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41fb1:	48 89 c2             	mov    %rax,%rdx
   41fb4:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41fb7:	48 c1 e0 04          	shl    $0x4,%rax
   41fbb:	48 89 c1             	mov    %rax,%rcx
   41fbe:	48 8d 05 db 22 01 00 	lea    0x122db(%rip),%rax        # 542a0 <interrupt_descriptors>
   41fc5:	48 01 c8             	add    %rcx,%rax
   41fc8:	48 89 d1             	mov    %rdx,%rcx
   41fcb:	ba 03 00 00 00       	mov    $0x3,%edx
   41fd0:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41fd7:	0e 00 00 
   41fda:	48 89 c7             	mov    %rax,%rdi
   41fdd:	e8 48 fd ff ff       	call   41d2a <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41fe2:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41fe6:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41fea:	76 aa                	jbe    41f96 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41fec:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41ff2:	48 8d 05 a7 22 01 00 	lea    0x122a7(%rip),%rax        # 542a0 <interrupt_descriptors>
   41ff9:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41ffd:	b8 28 00 00 00       	mov    $0x28,%eax
   42002:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   42006:	0f 00 d8             	ltr    %ax
   42009:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4200d:	0f 20 c0             	mov    %cr0,%rax
   42010:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   42014:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   42018:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   4201b:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   42022:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42025:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   42028:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4202b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   4202f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42033:	0f 22 c0             	mov    %rax,%cr0
}
   42036:	90                   	nop
    lcr0(cr0);
}
   42037:	90                   	nop
   42038:	c9                   	leave  
   42039:	c3                   	ret    

000000000004203a <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   4203a:	f3 0f 1e fa          	endbr64 
   4203e:	55                   	push   %rbp
   4203f:	48 89 e5             	mov    %rsp,%rbp
   42042:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   42046:	0f b7 05 b3 32 01 00 	movzwl 0x132b3(%rip),%eax        # 55300 <interrupts_enabled>
   4204d:	f7 d0                	not    %eax
   4204f:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   42053:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   42057:	0f b6 c0             	movzbl %al,%eax
   4205a:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   42061:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42064:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42068:	8b 55 f0             	mov    -0x10(%rbp),%edx
   4206b:	ee                   	out    %al,(%dx)
}
   4206c:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   4206d:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   42071:	66 c1 e8 08          	shr    $0x8,%ax
   42075:	0f b6 c0             	movzbl %al,%eax
   42078:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   4207f:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42082:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42086:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42089:	ee                   	out    %al,(%dx)
}
   4208a:	90                   	nop
}
   4208b:	90                   	nop
   4208c:	c9                   	leave  
   4208d:	c3                   	ret    

000000000004208e <interrupt_init>:

void interrupt_init(void) {
   4208e:	f3 0f 1e fa          	endbr64 
   42092:	55                   	push   %rbp
   42093:	48 89 e5             	mov    %rsp,%rbp
   42096:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   4209a:	66 c7 05 5d 32 01 00 	movw   $0x0,0x1325d(%rip)        # 55300 <interrupts_enabled>
   420a1:	00 00 
    interrupt_mask();
   420a3:	e8 92 ff ff ff       	call   4203a <interrupt_mask>
   420a8:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   420af:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420b3:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   420b7:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   420ba:	ee                   	out    %al,(%dx)
}
   420bb:	90                   	nop
   420bc:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   420c3:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420c7:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   420cb:	8b 55 ac             	mov    -0x54(%rbp),%edx
   420ce:	ee                   	out    %al,(%dx)
}
   420cf:	90                   	nop
   420d0:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   420d7:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420db:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   420df:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   420e2:	ee                   	out    %al,(%dx)
}
   420e3:	90                   	nop
   420e4:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   420eb:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420ef:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   420f3:	8b 55 bc             	mov    -0x44(%rbp),%edx
   420f6:	ee                   	out    %al,(%dx)
}
   420f7:	90                   	nop
   420f8:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   420ff:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42103:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   42107:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   4210a:	ee                   	out    %al,(%dx)
}
   4210b:	90                   	nop
   4210c:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   42113:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42117:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   4211b:	8b 55 cc             	mov    -0x34(%rbp),%edx
   4211e:	ee                   	out    %al,(%dx)
}
   4211f:	90                   	nop
   42120:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   42127:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4212b:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   4212f:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   42132:	ee                   	out    %al,(%dx)
}
   42133:	90                   	nop
   42134:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   4213b:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4213f:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   42143:	8b 55 dc             	mov    -0x24(%rbp),%edx
   42146:	ee                   	out    %al,(%dx)
}
   42147:	90                   	nop
   42148:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   4214f:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42153:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42157:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4215a:	ee                   	out    %al,(%dx)
}
   4215b:	90                   	nop
   4215c:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   42163:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42167:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4216b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4216e:	ee                   	out    %al,(%dx)
}
   4216f:	90                   	nop
   42170:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   42177:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4217b:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4217f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42182:	ee                   	out    %al,(%dx)
}
   42183:	90                   	nop
   42184:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   4218b:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4218f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42193:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42196:	ee                   	out    %al,(%dx)
}
   42197:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   42198:	e8 9d fe ff ff       	call   4203a <interrupt_mask>
}
   4219d:	90                   	nop
   4219e:	c9                   	leave  
   4219f:	c3                   	ret    

00000000000421a0 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   421a0:	f3 0f 1e fa          	endbr64 
   421a4:	55                   	push   %rbp
   421a5:	48 89 e5             	mov    %rsp,%rbp
   421a8:	48 83 ec 28          	sub    $0x28,%rsp
   421ac:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   421af:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   421b3:	0f 8e 9f 00 00 00    	jle    42258 <timer_init+0xb8>
   421b9:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   421c0:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421c4:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   421c8:	8b 55 ec             	mov    -0x14(%rbp),%edx
   421cb:	ee                   	out    %al,(%dx)
}
   421cc:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   421cd:	8b 45 dc             	mov    -0x24(%rbp),%eax
   421d0:	89 c2                	mov    %eax,%edx
   421d2:	c1 ea 1f             	shr    $0x1f,%edx
   421d5:	01 d0                	add    %edx,%eax
   421d7:	d1 f8                	sar    %eax
   421d9:	05 de 34 12 00       	add    $0x1234de,%eax
   421de:	99                   	cltd   
   421df:	f7 7d dc             	idivl  -0x24(%rbp)
   421e2:	89 c2                	mov    %eax,%edx
   421e4:	89 d0                	mov    %edx,%eax
   421e6:	c1 f8 1f             	sar    $0x1f,%eax
   421e9:	c1 e8 18             	shr    $0x18,%eax
   421ec:	89 c1                	mov    %eax,%ecx
   421ee:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   421f1:	0f b6 c0             	movzbl %al,%eax
   421f4:	29 c8                	sub    %ecx,%eax
   421f6:	0f b6 c0             	movzbl %al,%eax
   421f9:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   42200:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42203:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42207:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4220a:	ee                   	out    %al,(%dx)
}
   4220b:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   4220c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4220f:	89 c2                	mov    %eax,%edx
   42211:	c1 ea 1f             	shr    $0x1f,%edx
   42214:	01 d0                	add    %edx,%eax
   42216:	d1 f8                	sar    %eax
   42218:	05 de 34 12 00       	add    $0x1234de,%eax
   4221d:	99                   	cltd   
   4221e:	f7 7d dc             	idivl  -0x24(%rbp)
   42221:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42227:	85 c0                	test   %eax,%eax
   42229:	0f 48 c2             	cmovs  %edx,%eax
   4222c:	c1 f8 08             	sar    $0x8,%eax
   4222f:	0f b6 c0             	movzbl %al,%eax
   42232:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   42239:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4223c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42240:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42243:	ee                   	out    %al,(%dx)
}
   42244:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   42245:	0f b7 05 b4 30 01 00 	movzwl 0x130b4(%rip),%eax        # 55300 <interrupts_enabled>
   4224c:	83 c8 01             	or     $0x1,%eax
   4224f:	66 89 05 aa 30 01 00 	mov    %ax,0x130aa(%rip)        # 55300 <interrupts_enabled>
   42256:	eb 11                	jmp    42269 <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   42258:	0f b7 05 a1 30 01 00 	movzwl 0x130a1(%rip),%eax        # 55300 <interrupts_enabled>
   4225f:	83 e0 fe             	and    $0xfffffffe,%eax
   42262:	66 89 05 97 30 01 00 	mov    %ax,0x13097(%rip)        # 55300 <interrupts_enabled>
    }
    interrupt_mask();
   42269:	e8 cc fd ff ff       	call   4203a <interrupt_mask>
}
   4226e:	90                   	nop
   4226f:	c9                   	leave  
   42270:	c3                   	ret    

0000000000042271 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   42271:	f3 0f 1e fa          	endbr64 
   42275:	55                   	push   %rbp
   42276:	48 89 e5             	mov    %rsp,%rbp
   42279:	48 83 ec 08          	sub    $0x8,%rsp
   4227d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   42281:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   42286:	74 14                	je     4229c <physical_memory_isreserved+0x2b>
   42288:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   4228f:	00 
   42290:	76 11                	jbe    422a3 <physical_memory_isreserved+0x32>
   42292:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   42299:	00 
   4229a:	77 07                	ja     422a3 <physical_memory_isreserved+0x32>
   4229c:	b8 01 00 00 00       	mov    $0x1,%eax
   422a1:	eb 05                	jmp    422a8 <physical_memory_isreserved+0x37>
   422a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
   422a8:	c9                   	leave  
   422a9:	c3                   	ret    

00000000000422aa <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   422aa:	f3 0f 1e fa          	endbr64 
   422ae:	55                   	push   %rbp
   422af:	48 89 e5             	mov    %rsp,%rbp
   422b2:	48 83 ec 10          	sub    $0x10,%rsp
   422b6:	89 7d fc             	mov    %edi,-0x4(%rbp)
   422b9:	89 75 f8             	mov    %esi,-0x8(%rbp)
   422bc:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   422bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422c2:	c1 e0 10             	shl    $0x10,%eax
   422c5:	89 c2                	mov    %eax,%edx
   422c7:	8b 45 f8             	mov    -0x8(%rbp),%eax
   422ca:	c1 e0 0b             	shl    $0xb,%eax
   422cd:	09 c2                	or     %eax,%edx
   422cf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422d2:	c1 e0 08             	shl    $0x8,%eax
   422d5:	09 d0                	or     %edx,%eax
}
   422d7:	c9                   	leave  
   422d8:	c3                   	ret    

00000000000422d9 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   422d9:	f3 0f 1e fa          	endbr64 
   422dd:	55                   	push   %rbp
   422de:	48 89 e5             	mov    %rsp,%rbp
   422e1:	48 83 ec 18          	sub    $0x18,%rsp
   422e5:	89 7d ec             	mov    %edi,-0x14(%rbp)
   422e8:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   422eb:	8b 55 ec             	mov    -0x14(%rbp),%edx
   422ee:	8b 45 e8             	mov    -0x18(%rbp),%eax
   422f1:	09 d0                	or     %edx,%eax
   422f3:	0d 00 00 00 80       	or     $0x80000000,%eax
   422f8:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   422ff:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42302:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42305:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42308:	ef                   	out    %eax,(%dx)
}
   42309:	90                   	nop
   4230a:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42311:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42314:	89 c2                	mov    %eax,%edx
   42316:	ed                   	in     (%dx),%eax
   42317:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   4231a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   4231d:	c9                   	leave  
   4231e:	c3                   	ret    

000000000004231f <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   4231f:	f3 0f 1e fa          	endbr64 
   42323:	55                   	push   %rbp
   42324:	48 89 e5             	mov    %rsp,%rbp
   42327:	48 83 ec 28          	sub    $0x28,%rsp
   4232b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4232e:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42331:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42338:	eb 73                	jmp    423ad <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   4233a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   42341:	eb 60                	jmp    423a3 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   42343:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4234a:	eb 4a                	jmp    42396 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   4234c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4234f:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   42352:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42355:	89 ce                	mov    %ecx,%esi
   42357:	89 c7                	mov    %eax,%edi
   42359:	e8 4c ff ff ff       	call   422aa <pci_make_configaddr>
   4235e:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   42361:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42364:	be 00 00 00 00       	mov    $0x0,%esi
   42369:	89 c7                	mov    %eax,%edi
   4236b:	e8 69 ff ff ff       	call   422d9 <pci_config_readl>
   42370:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   42373:	8b 45 d8             	mov    -0x28(%rbp),%eax
   42376:	c1 e0 10             	shl    $0x10,%eax
   42379:	0b 45 dc             	or     -0x24(%rbp),%eax
   4237c:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   4237f:	75 05                	jne    42386 <pci_find_device+0x67>
                    return configaddr;
   42381:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42384:	eb 35                	jmp    423bb <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   42386:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   4238a:	75 06                	jne    42392 <pci_find_device+0x73>
   4238c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42390:	74 0c                	je     4239e <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   42392:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42396:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   4239a:	75 b0                	jne    4234c <pci_find_device+0x2d>
   4239c:	eb 01                	jmp    4239f <pci_find_device+0x80>
                    break;
   4239e:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   4239f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   423a3:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   423a7:	75 9a                	jne    42343 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   423a9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   423ad:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   423b4:	75 84                	jne    4233a <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   423b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   423bb:	c9                   	leave  
   423bc:	c3                   	ret    

00000000000423bd <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   423bd:	f3 0f 1e fa          	endbr64 
   423c1:	55                   	push   %rbp
   423c2:	48 89 e5             	mov    %rsp,%rbp
   423c5:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   423c9:	be 13 71 00 00       	mov    $0x7113,%esi
   423ce:	bf 86 80 00 00       	mov    $0x8086,%edi
   423d3:	e8 47 ff ff ff       	call   4231f <pci_find_device>
   423d8:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   423db:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   423df:	78 30                	js     42411 <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   423e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423e4:	be 40 00 00 00       	mov    $0x40,%esi
   423e9:	89 c7                	mov    %eax,%edi
   423eb:	e8 e9 fe ff ff       	call   422d9 <pci_config_readl>
   423f0:	25 c0 ff 00 00       	and    $0xffc0,%eax
   423f5:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   423f8:	8b 45 f8             	mov    -0x8(%rbp),%eax
   423fb:	83 c0 04             	add    $0x4,%eax
   423fe:	89 45 f4             	mov    %eax,-0xc(%rbp)
   42401:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42407:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   4240b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4240e:	66 ef                	out    %ax,(%dx)
}
   42410:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42411:	48 8d 05 88 28 00 00 	lea    0x2888(%rip),%rax        # 44ca0 <memstate_colors+0xc0>
   42418:	48 89 c2             	mov    %rax,%rdx
   4241b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42420:	bf 80 07 00 00       	mov    $0x780,%edi
   42425:	b8 00 00 00 00       	mov    $0x0,%eax
   4242a:	e8 47 23 00 00       	call   44776 <console_printf>
 spinloop: goto spinloop;
   4242f:	eb fe                	jmp    4242f <poweroff+0x72>

0000000000042431 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   42431:	f3 0f 1e fa          	endbr64 
   42435:	55                   	push   %rbp
   42436:	48 89 e5             	mov    %rsp,%rbp
   42439:	48 83 ec 10          	sub    $0x10,%rsp
   4243d:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42444:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42448:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4244c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4244f:	ee                   	out    %al,(%dx)
}
   42450:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   42451:	eb fe                	jmp    42451 <reboot+0x20>

0000000000042453 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42453:	f3 0f 1e fa          	endbr64 
   42457:	55                   	push   %rbp
   42458:	48 89 e5             	mov    %rsp,%rbp
   4245b:	48 83 ec 10          	sub    $0x10,%rsp
   4245f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42463:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   42466:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4246a:	48 83 c0 08          	add    $0x8,%rax
   4246e:	ba c0 00 00 00       	mov    $0xc0,%edx
   42473:	be 00 00 00 00       	mov    $0x0,%esi
   42478:	48 89 c7             	mov    %rax,%rdi
   4247b:	e8 b7 14 00 00       	call   43937 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   42480:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42484:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   4248b:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   4248d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42491:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   42498:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   4249c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424a0:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   424a7:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   424ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424af:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   424b6:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   424b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424bc:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   424c3:	00 02 00 00 
    p->display_status = 1;
   424c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424cb:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   424d2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   424d5:	83 e0 01             	and    $0x1,%eax
   424d8:	85 c0                	test   %eax,%eax
   424da:	74 1c                	je     424f8 <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   424dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424e0:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   424e7:	80 cc 30             	or     $0x30,%ah
   424ea:	48 89 c2             	mov    %rax,%rdx
   424ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424f1:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   424f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   424fb:	83 e0 02             	and    $0x2,%eax
   424fe:	85 c0                	test   %eax,%eax
   42500:	74 1c                	je     4251e <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42502:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42506:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4250d:	80 e4 fd             	and    $0xfd,%ah
   42510:	48 89 c2             	mov    %rax,%rdx
   42513:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42517:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   4251e:	90                   	nop
   4251f:	c9                   	leave  
   42520:	c3                   	ret    

0000000000042521 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42521:	f3 0f 1e fa          	endbr64 
   42525:	55                   	push   %rbp
   42526:	48 89 e5             	mov    %rsp,%rbp
   42529:	48 83 ec 28          	sub    $0x28,%rsp
   4252d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42530:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42534:	78 09                	js     4253f <console_show_cursor+0x1e>
   42536:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4253d:	7e 07                	jle    42546 <console_show_cursor+0x25>
        cpos = 0;
   4253f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42546:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4254d:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42551:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42555:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42558:	ee                   	out    %al,(%dx)
}
   42559:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   4255a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4255d:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42563:	85 c0                	test   %eax,%eax
   42565:	0f 48 c2             	cmovs  %edx,%eax
   42568:	c1 f8 08             	sar    $0x8,%eax
   4256b:	0f b6 c0             	movzbl %al,%eax
   4256e:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42575:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42578:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4257c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4257f:	ee                   	out    %al,(%dx)
}
   42580:	90                   	nop
   42581:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42588:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4258c:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42590:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42593:	ee                   	out    %al,(%dx)
}
   42594:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42595:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42598:	99                   	cltd   
   42599:	c1 ea 18             	shr    $0x18,%edx
   4259c:	01 d0                	add    %edx,%eax
   4259e:	0f b6 c0             	movzbl %al,%eax
   425a1:	29 d0                	sub    %edx,%eax
   425a3:	0f b6 c0             	movzbl %al,%eax
   425a6:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   425ad:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   425b0:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   425b4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   425b7:	ee                   	out    %al,(%dx)
}
   425b8:	90                   	nop
}
   425b9:	90                   	nop
   425ba:	c9                   	leave  
   425bb:	c3                   	ret    

00000000000425bc <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   425bc:	f3 0f 1e fa          	endbr64 
   425c0:	55                   	push   %rbp
   425c1:	48 89 e5             	mov    %rsp,%rbp
   425c4:	48 83 ec 20          	sub    $0x20,%rsp
   425c8:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   425cf:	8b 45 f0             	mov    -0x10(%rbp),%eax
   425d2:	89 c2                	mov    %eax,%edx
   425d4:	ec                   	in     (%dx),%al
   425d5:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   425d8:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   425dc:	0f b6 c0             	movzbl %al,%eax
   425df:	83 e0 01             	and    $0x1,%eax
   425e2:	85 c0                	test   %eax,%eax
   425e4:	75 0a                	jne    425f0 <keyboard_readc+0x34>
        return -1;
   425e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   425eb:	e9 fd 01 00 00       	jmp    427ed <keyboard_readc+0x231>
   425f0:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   425f7:	8b 45 e8             	mov    -0x18(%rbp),%eax
   425fa:	89 c2                	mov    %eax,%edx
   425fc:	ec                   	in     (%dx),%al
   425fd:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42600:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42604:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42607:	0f b6 05 f4 2c 01 00 	movzbl 0x12cf4(%rip),%eax        # 55302 <last_escape.2>
   4260e:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42611:	c6 05 ea 2c 01 00 00 	movb   $0x0,0x12cea(%rip)        # 55302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42618:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4261c:	75 11                	jne    4262f <keyboard_readc+0x73>
        last_escape = 0x80;
   4261e:	c6 05 dd 2c 01 00 80 	movb   $0x80,0x12cdd(%rip)        # 55302 <last_escape.2>
        return 0;
   42625:	b8 00 00 00 00       	mov    $0x0,%eax
   4262a:	e9 be 01 00 00       	jmp    427ed <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4262f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42633:	84 c0                	test   %al,%al
   42635:	79 64                	jns    4269b <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   42637:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4263b:	83 e0 7f             	and    $0x7f,%eax
   4263e:	89 c2                	mov    %eax,%edx
   42640:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42644:	09 d0                	or     %edx,%eax
   42646:	48 98                	cltq   
   42648:	48 8d 15 71 26 00 00 	lea    0x2671(%rip),%rdx        # 44cc0 <keymap>
   4264f:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42653:	0f b6 c0             	movzbl %al,%eax
   42656:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42659:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42660:	7e 2f                	jle    42691 <keyboard_readc+0xd5>
   42662:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42669:	7f 26                	jg     42691 <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   4266b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4266e:	2d fa 00 00 00       	sub    $0xfa,%eax
   42673:	ba 01 00 00 00       	mov    $0x1,%edx
   42678:	89 c1                	mov    %eax,%ecx
   4267a:	d3 e2                	shl    %cl,%edx
   4267c:	89 d0                	mov    %edx,%eax
   4267e:	f7 d0                	not    %eax
   42680:	89 c2                	mov    %eax,%edx
   42682:	0f b6 05 7a 2c 01 00 	movzbl 0x12c7a(%rip),%eax        # 55303 <modifiers.1>
   42689:	21 d0                	and    %edx,%eax
   4268b:	88 05 72 2c 01 00    	mov    %al,0x12c72(%rip)        # 55303 <modifiers.1>
        }
        return 0;
   42691:	b8 00 00 00 00       	mov    $0x0,%eax
   42696:	e9 52 01 00 00       	jmp    427ed <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   4269b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4269f:	0a 45 fa             	or     -0x6(%rbp),%al
   426a2:	0f b6 c0             	movzbl %al,%eax
   426a5:	48 98                	cltq   
   426a7:	48 8d 15 12 26 00 00 	lea    0x2612(%rip),%rdx        # 44cc0 <keymap>
   426ae:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   426b2:	0f b6 c0             	movzbl %al,%eax
   426b5:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   426b8:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   426bc:	7e 57                	jle    42715 <keyboard_readc+0x159>
   426be:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   426c2:	7f 51                	jg     42715 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   426c4:	0f b6 05 38 2c 01 00 	movzbl 0x12c38(%rip),%eax        # 55303 <modifiers.1>
   426cb:	0f b6 c0             	movzbl %al,%eax
   426ce:	83 e0 02             	and    $0x2,%eax
   426d1:	85 c0                	test   %eax,%eax
   426d3:	74 09                	je     426de <keyboard_readc+0x122>
            ch -= 0x60;
   426d5:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   426d9:	e9 0b 01 00 00       	jmp    427e9 <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   426de:	0f b6 05 1e 2c 01 00 	movzbl 0x12c1e(%rip),%eax        # 55303 <modifiers.1>
   426e5:	0f b6 c0             	movzbl %al,%eax
   426e8:	83 e0 01             	and    $0x1,%eax
   426eb:	85 c0                	test   %eax,%eax
   426ed:	0f 94 c2             	sete   %dl
   426f0:	0f b6 05 0c 2c 01 00 	movzbl 0x12c0c(%rip),%eax        # 55303 <modifiers.1>
   426f7:	0f b6 c0             	movzbl %al,%eax
   426fa:	83 e0 08             	and    $0x8,%eax
   426fd:	85 c0                	test   %eax,%eax
   426ff:	0f 94 c0             	sete   %al
   42702:	31 d0                	xor    %edx,%eax
   42704:	84 c0                	test   %al,%al
   42706:	0f 84 dd 00 00 00    	je     427e9 <keyboard_readc+0x22d>
            ch -= 0x20;
   4270c:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42710:	e9 d4 00 00 00       	jmp    427e9 <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42715:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4271c:	7e 30                	jle    4274e <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4271e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42721:	2d fa 00 00 00       	sub    $0xfa,%eax
   42726:	ba 01 00 00 00       	mov    $0x1,%edx
   4272b:	89 c1                	mov    %eax,%ecx
   4272d:	d3 e2                	shl    %cl,%edx
   4272f:	89 d0                	mov    %edx,%eax
   42731:	89 c2                	mov    %eax,%edx
   42733:	0f b6 05 c9 2b 01 00 	movzbl 0x12bc9(%rip),%eax        # 55303 <modifiers.1>
   4273a:	31 d0                	xor    %edx,%eax
   4273c:	88 05 c1 2b 01 00    	mov    %al,0x12bc1(%rip)        # 55303 <modifiers.1>
        ch = 0;
   42742:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42749:	e9 9c 00 00 00       	jmp    427ea <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   4274e:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42755:	7e 2d                	jle    42784 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42757:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4275a:	2d fa 00 00 00       	sub    $0xfa,%eax
   4275f:	ba 01 00 00 00       	mov    $0x1,%edx
   42764:	89 c1                	mov    %eax,%ecx
   42766:	d3 e2                	shl    %cl,%edx
   42768:	89 d0                	mov    %edx,%eax
   4276a:	89 c2                	mov    %eax,%edx
   4276c:	0f b6 05 90 2b 01 00 	movzbl 0x12b90(%rip),%eax        # 55303 <modifiers.1>
   42773:	09 d0                	or     %edx,%eax
   42775:	88 05 88 2b 01 00    	mov    %al,0x12b88(%rip)        # 55303 <modifiers.1>
        ch = 0;
   4277b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42782:	eb 66                	jmp    427ea <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42784:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42788:	7e 3f                	jle    427c9 <keyboard_readc+0x20d>
   4278a:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42791:	7f 36                	jg     427c9 <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42793:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42796:	8d 50 80             	lea    -0x80(%rax),%edx
   42799:	0f b6 05 63 2b 01 00 	movzbl 0x12b63(%rip),%eax        # 55303 <modifiers.1>
   427a0:	0f b6 c0             	movzbl %al,%eax
   427a3:	83 e0 03             	and    $0x3,%eax
   427a6:	48 63 c8             	movslq %eax,%rcx
   427a9:	48 63 c2             	movslq %edx,%rax
   427ac:	48 c1 e0 02          	shl    $0x2,%rax
   427b0:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   427b4:	48 8d 05 05 26 00 00 	lea    0x2605(%rip),%rax        # 44dc0 <complex_keymap>
   427bb:	48 01 d0             	add    %rdx,%rax
   427be:	0f b6 00             	movzbl (%rax),%eax
   427c1:	0f b6 c0             	movzbl %al,%eax
   427c4:	89 45 fc             	mov    %eax,-0x4(%rbp)
   427c7:	eb 21                	jmp    427ea <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   427c9:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   427cd:	7f 1b                	jg     427ea <keyboard_readc+0x22e>
   427cf:	0f b6 05 2d 2b 01 00 	movzbl 0x12b2d(%rip),%eax        # 55303 <modifiers.1>
   427d6:	0f b6 c0             	movzbl %al,%eax
   427d9:	83 e0 02             	and    $0x2,%eax
   427dc:	85 c0                	test   %eax,%eax
   427de:	74 0a                	je     427ea <keyboard_readc+0x22e>
        ch = 0;
   427e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   427e7:	eb 01                	jmp    427ea <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   427e9:	90                   	nop
    }

    return ch;
   427ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   427ed:	c9                   	leave  
   427ee:	c3                   	ret    

00000000000427ef <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   427ef:	f3 0f 1e fa          	endbr64 
   427f3:	55                   	push   %rbp
   427f4:	48 89 e5             	mov    %rsp,%rbp
   427f7:	48 83 ec 20          	sub    $0x20,%rsp
   427fb:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42802:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42805:	89 c2                	mov    %eax,%edx
   42807:	ec                   	in     (%dx),%al
   42808:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4280b:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42812:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42815:	89 c2                	mov    %eax,%edx
   42817:	ec                   	in     (%dx),%al
   42818:	88 45 eb             	mov    %al,-0x15(%rbp)
   4281b:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42822:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42825:	89 c2                	mov    %eax,%edx
   42827:	ec                   	in     (%dx),%al
   42828:	88 45 f3             	mov    %al,-0xd(%rbp)
   4282b:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42832:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42835:	89 c2                	mov    %eax,%edx
   42837:	ec                   	in     (%dx),%al
   42838:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4283b:	90                   	nop
   4283c:	c9                   	leave  
   4283d:	c3                   	ret    

000000000004283e <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4283e:	f3 0f 1e fa          	endbr64 
   42842:	55                   	push   %rbp
   42843:	48 89 e5             	mov    %rsp,%rbp
   42846:	48 83 ec 40          	sub    $0x40,%rsp
   4284a:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4284e:	89 f0                	mov    %esi,%eax
   42850:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42853:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42856:	8b 05 a8 2a 01 00    	mov    0x12aa8(%rip),%eax        # 55304 <initialized.0>
   4285c:	85 c0                	test   %eax,%eax
   4285e:	75 1e                	jne    4287e <parallel_port_putc+0x40>
   42860:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42867:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4286b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4286f:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42872:	ee                   	out    %al,(%dx)
}
   42873:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42874:	c7 05 86 2a 01 00 01 	movl   $0x1,0x12a86(%rip)        # 55304 <initialized.0>
   4287b:	00 00 00 
    }

    for (int i = 0;
   4287e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42885:	eb 09                	jmp    42890 <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42887:	e8 63 ff ff ff       	call   427ef <delay>
         ++i) {
   4288c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42890:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42897:	7f 18                	jg     428b1 <parallel_port_putc+0x73>
   42899:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   428a0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   428a3:	89 c2                	mov    %eax,%edx
   428a5:	ec                   	in     (%dx),%al
   428a6:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   428a9:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   428ad:	84 c0                	test   %al,%al
   428af:	79 d6                	jns    42887 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   428b1:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   428b5:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   428bc:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   428bf:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   428c3:	8b 55 d8             	mov    -0x28(%rbp),%edx
   428c6:	ee                   	out    %al,(%dx)
}
   428c7:	90                   	nop
   428c8:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   428cf:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   428d3:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   428d7:	8b 55 e0             	mov    -0x20(%rbp),%edx
   428da:	ee                   	out    %al,(%dx)
}
   428db:	90                   	nop
   428dc:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   428e3:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   428e7:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   428eb:	8b 55 e8             	mov    -0x18(%rbp),%edx
   428ee:	ee                   	out    %al,(%dx)
}
   428ef:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   428f0:	90                   	nop
   428f1:	c9                   	leave  
   428f2:	c3                   	ret    

00000000000428f3 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   428f3:	f3 0f 1e fa          	endbr64 
   428f7:	55                   	push   %rbp
   428f8:	48 89 e5             	mov    %rsp,%rbp
   428fb:	48 83 ec 20          	sub    $0x20,%rsp
   428ff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42903:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42907:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 4283e <parallel_port_putc>
   4290e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   42912:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42916:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4291a:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4291e:	be 00 00 00 00       	mov    $0x0,%esi
   42923:	48 89 c7             	mov    %rax,%rdi
   42926:	e8 d2 12 00 00       	call   43bfd <printer_vprintf>
}
   4292b:	90                   	nop
   4292c:	c9                   	leave  
   4292d:	c3                   	ret    

000000000004292e <log_printf>:

void log_printf(const char* format, ...) {
   4292e:	f3 0f 1e fa          	endbr64 
   42932:	55                   	push   %rbp
   42933:	48 89 e5             	mov    %rsp,%rbp
   42936:	48 83 ec 60          	sub    $0x60,%rsp
   4293a:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4293e:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42942:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42946:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4294a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4294e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42952:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42959:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4295d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42961:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42965:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42969:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4296d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42971:	48 89 d6             	mov    %rdx,%rsi
   42974:	48 89 c7             	mov    %rax,%rdi
   42977:	e8 77 ff ff ff       	call   428f3 <log_vprintf>
    va_end(val);
}
   4297c:	90                   	nop
   4297d:	c9                   	leave  
   4297e:	c3                   	ret    

000000000004297f <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   4297f:	f3 0f 1e fa          	endbr64 
   42983:	55                   	push   %rbp
   42984:	48 89 e5             	mov    %rsp,%rbp
   42987:	48 83 ec 40          	sub    $0x40,%rsp
   4298b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4298e:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42991:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42995:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42999:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4299d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   429a1:	48 8b 0a             	mov    (%rdx),%rcx
   429a4:	48 89 08             	mov    %rcx,(%rax)
   429a7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   429ab:	48 89 48 08          	mov    %rcx,0x8(%rax)
   429af:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   429b3:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   429b7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   429bb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   429bf:	48 89 d6             	mov    %rdx,%rsi
   429c2:	48 89 c7             	mov    %rax,%rdi
   429c5:	e8 29 ff ff ff       	call   428f3 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   429ca:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   429ce:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   429d2:	8b 75 d8             	mov    -0x28(%rbp),%esi
   429d5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429d8:	89 c7                	mov    %eax,%edi
   429da:	e8 1b 1d 00 00       	call   446fa <console_vprintf>
}
   429df:	c9                   	leave  
   429e0:	c3                   	ret    

00000000000429e1 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   429e1:	f3 0f 1e fa          	endbr64 
   429e5:	55                   	push   %rbp
   429e6:	48 89 e5             	mov    %rsp,%rbp
   429e9:	48 83 ec 60          	sub    $0x60,%rsp
   429ed:	89 7d ac             	mov    %edi,-0x54(%rbp)
   429f0:	89 75 a8             	mov    %esi,-0x58(%rbp)
   429f3:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   429f7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   429fb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   429ff:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42a03:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42a0a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42a0e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42a12:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42a16:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42a1a:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42a1e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42a22:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42a25:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a28:	89 c7                	mov    %eax,%edi
   42a2a:	e8 50 ff ff ff       	call   4297f <error_vprintf>
   42a2f:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42a32:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42a35:	c9                   	leave  
   42a36:	c3                   	ret    

0000000000042a37 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42a37:	f3 0f 1e fa          	endbr64 
   42a3b:	55                   	push   %rbp
   42a3c:	48 89 e5             	mov    %rsp,%rbp
   42a3f:	53                   	push   %rbx
   42a40:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42a44:	e8 73 fb ff ff       	call   425bc <keyboard_readc>
   42a49:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42a4c:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42a50:	74 1c                	je     42a6e <check_keyboard+0x37>
   42a52:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42a56:	74 16                	je     42a6e <check_keyboard+0x37>
   42a58:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42a5c:	74 10                	je     42a6e <check_keyboard+0x37>
   42a5e:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42a62:	74 0a                	je     42a6e <check_keyboard+0x37>
   42a64:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42a68:	0f 85 02 01 00 00    	jne    42b70 <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42a6e:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42a75:	00 
        memset(pt, 0, PAGESIZE * 3);
   42a76:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a7a:	ba 00 30 00 00       	mov    $0x3000,%edx
   42a7f:	be 00 00 00 00       	mov    $0x0,%esi
   42a84:	48 89 c7             	mov    %rax,%rdi
   42a87:	e8 ab 0e 00 00       	call   43937 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42a8c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a90:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42a97:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a9b:	48 05 00 10 00 00    	add    $0x1000,%rax
   42aa1:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42aa8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42aac:	48 05 00 20 00 00    	add    $0x2000,%rax
   42ab2:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42ab9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42abd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42ac1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42ac5:	0f 22 d8             	mov    %rax,%cr3
}
   42ac8:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42ac9:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42ad0:	48 8d 05 41 23 00 00 	lea    0x2341(%rip),%rax        # 44e18 <complex_keymap+0x58>
   42ad7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   42adb:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42adf:	75 0d                	jne    42aee <check_keyboard+0xb7>
            argument = "allocator";
   42ae1:	48 8d 05 35 23 00 00 	lea    0x2335(%rip),%rax        # 44e1d <complex_keymap+0x5d>
   42ae8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42aec:	eb 37                	jmp    42b25 <check_keyboard+0xee>
        } else if (c == 'e') {
   42aee:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42af2:	75 0d                	jne    42b01 <check_keyboard+0xca>
            argument = "forkexit";
   42af4:	48 8d 05 2c 23 00 00 	lea    0x232c(%rip),%rax        # 44e27 <complex_keymap+0x67>
   42afb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42aff:	eb 24                	jmp    42b25 <check_keyboard+0xee>
        }
        else if (c == 't'){
   42b01:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42b05:	75 0d                	jne    42b14 <check_keyboard+0xdd>
            argument = "test";
   42b07:	48 8d 05 22 23 00 00 	lea    0x2322(%rip),%rax        # 44e30 <complex_keymap+0x70>
   42b0e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42b12:	eb 11                	jmp    42b25 <check_keyboard+0xee>
        }
        else if(c == '2'){
   42b14:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42b18:	75 0b                	jne    42b25 <check_keyboard+0xee>
            argument = "test2";
   42b1a:	48 8d 05 14 23 00 00 	lea    0x2314(%rip),%rax        # 44e35 <complex_keymap+0x75>
   42b21:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42b25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b29:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42b2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42b32:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42b36:	76 1e                	jbe    42b56 <check_keyboard+0x11f>
   42b38:	48 8d 05 fc 22 00 00 	lea    0x22fc(%rip),%rax        # 44e3b <complex_keymap+0x7b>
   42b3f:	48 89 c2             	mov    %rax,%rdx
   42b42:	be 5d 02 00 00       	mov    $0x25d,%esi
   42b47:	48 8d 05 09 23 00 00 	lea    0x2309(%rip),%rax        # 44e57 <complex_keymap+0x97>
   42b4e:	48 89 c7             	mov    %rax,%rdi
   42b51:	e8 33 01 00 00       	call   42c89 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42b56:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b5a:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42b5d:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42b61:	48 89 c3             	mov    %rax,%rbx
   42b64:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42b69:	e9 92 d4 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42b6e:	eb 11                	jmp    42b81 <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42b70:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42b74:	74 06                	je     42b7c <check_keyboard+0x145>
   42b76:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42b7a:	75 05                	jne    42b81 <check_keyboard+0x14a>
        poweroff();
   42b7c:	e8 3c f8 ff ff       	call   423bd <poweroff>
    }
    return c;
   42b81:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42b84:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42b88:	c9                   	leave  
   42b89:	c3                   	ret    

0000000000042b8a <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42b8a:	f3 0f 1e fa          	endbr64 
   42b8e:	55                   	push   %rbp
   42b8f:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42b92:	e8 a0 fe ff ff       	call   42a37 <check_keyboard>
   42b97:	eb f9                	jmp    42b92 <fail+0x8>

0000000000042b99 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42b99:	f3 0f 1e fa          	endbr64 
   42b9d:	55                   	push   %rbp
   42b9e:	48 89 e5             	mov    %rsp,%rbp
   42ba1:	48 83 ec 60          	sub    $0x60,%rsp
   42ba5:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42ba9:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42bad:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42bb1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42bb5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42bb9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42bbd:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42bc4:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42bc8:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42bcc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42bd0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42bd4:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42bd9:	0f 84 87 00 00 00    	je     42c66 <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42bdf:	48 8d 05 85 22 00 00 	lea    0x2285(%rip),%rax        # 44e6b <complex_keymap+0xab>
   42be6:	48 89 c2             	mov    %rax,%rdx
   42be9:	be 00 c0 00 00       	mov    $0xc000,%esi
   42bee:	bf 30 07 00 00       	mov    $0x730,%edi
   42bf3:	b8 00 00 00 00       	mov    $0x0,%eax
   42bf8:	e8 e4 fd ff ff       	call   429e1 <error_printf>
   42bfd:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42c00:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42c04:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42c08:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c0b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42c10:	89 c7                	mov    %eax,%edi
   42c12:	e8 68 fd ff ff       	call   4297f <error_vprintf>
   42c17:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42c1a:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42c1d:	48 63 c1             	movslq %ecx,%rax
   42c20:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42c27:	48 c1 e8 20          	shr    $0x20,%rax
   42c2b:	c1 f8 05             	sar    $0x5,%eax
   42c2e:	89 ce                	mov    %ecx,%esi
   42c30:	c1 fe 1f             	sar    $0x1f,%esi
   42c33:	29 f0                	sub    %esi,%eax
   42c35:	89 c2                	mov    %eax,%edx
   42c37:	89 d0                	mov    %edx,%eax
   42c39:	c1 e0 02             	shl    $0x2,%eax
   42c3c:	01 d0                	add    %edx,%eax
   42c3e:	c1 e0 04             	shl    $0x4,%eax
   42c41:	29 c1                	sub    %eax,%ecx
   42c43:	89 ca                	mov    %ecx,%edx
   42c45:	85 d2                	test   %edx,%edx
   42c47:	74 3b                	je     42c84 <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   42c49:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c4c:	48 8d 15 20 22 00 00 	lea    0x2220(%rip),%rdx        # 44e73 <complex_keymap+0xb3>
   42c53:	be 00 c0 00 00       	mov    $0xc000,%esi
   42c58:	89 c7                	mov    %eax,%edi
   42c5a:	b8 00 00 00 00       	mov    $0x0,%eax
   42c5f:	e8 7d fd ff ff       	call   429e1 <error_printf>
   42c64:	eb 1e                	jmp    42c84 <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42c66:	48 8d 05 08 22 00 00 	lea    0x2208(%rip),%rax        # 44e75 <complex_keymap+0xb5>
   42c6d:	48 89 c2             	mov    %rax,%rdx
   42c70:	be 00 c0 00 00       	mov    $0xc000,%esi
   42c75:	bf 30 07 00 00       	mov    $0x730,%edi
   42c7a:	b8 00 00 00 00       	mov    $0x0,%eax
   42c7f:	e8 5d fd ff ff       	call   429e1 <error_printf>
    }

    va_end(val);
    fail();
   42c84:	e8 01 ff ff ff       	call   42b8a <fail>

0000000000042c89 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42c89:	f3 0f 1e fa          	endbr64 
   42c8d:	55                   	push   %rbp
   42c8e:	48 89 e5             	mov    %rsp,%rbp
   42c91:	48 83 ec 20          	sub    $0x20,%rsp
   42c95:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42c99:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42c9c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42ca0:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42ca4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42ca7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42cab:	48 89 c6             	mov    %rax,%rsi
   42cae:	48 8d 05 c6 21 00 00 	lea    0x21c6(%rip),%rax        # 44e7b <complex_keymap+0xbb>
   42cb5:	48 89 c7             	mov    %rax,%rdi
   42cb8:	b8 00 00 00 00       	mov    $0x0,%eax
   42cbd:	e8 d7 fe ff ff       	call   42b99 <panic>

0000000000042cc2 <default_exception>:
}

void default_exception(proc* p){
   42cc2:	f3 0f 1e fa          	endbr64 
   42cc6:	55                   	push   %rbp
   42cc7:	48 89 e5             	mov    %rsp,%rbp
   42cca:	48 83 ec 20          	sub    $0x20,%rsp
   42cce:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42cd2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cd6:	48 83 c0 08          	add    $0x8,%rax
   42cda:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42cde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ce2:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42ce9:	48 89 c6             	mov    %rax,%rsi
   42cec:	48 8d 05 a6 21 00 00 	lea    0x21a6(%rip),%rax        # 44e99 <complex_keymap+0xd9>
   42cf3:	48 89 c7             	mov    %rax,%rdi
   42cf6:	b8 00 00 00 00       	mov    $0x0,%eax
   42cfb:	e8 99 fe ff ff       	call   42b99 <panic>

0000000000042d00 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42d00:	55                   	push   %rbp
   42d01:	48 89 e5             	mov    %rsp,%rbp
   42d04:	48 83 ec 10          	sub    $0x10,%rsp
   42d08:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42d0c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42d0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42d13:	78 06                	js     42d1b <pageindex+0x1b>
   42d15:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42d19:	7e 1e                	jle    42d39 <pageindex+0x39>
   42d1b:	48 8d 05 96 21 00 00 	lea    0x2196(%rip),%rax        # 44eb8 <complex_keymap+0xf8>
   42d22:	48 89 c2             	mov    %rax,%rdx
   42d25:	be 1e 00 00 00       	mov    $0x1e,%esi
   42d2a:	48 8d 05 a0 21 00 00 	lea    0x21a0(%rip),%rax        # 44ed1 <complex_keymap+0x111>
   42d31:	48 89 c7             	mov    %rax,%rdi
   42d34:	e8 50 ff ff ff       	call   42c89 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42d39:	b8 03 00 00 00       	mov    $0x3,%eax
   42d3e:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42d41:	89 c2                	mov    %eax,%edx
   42d43:	89 d0                	mov    %edx,%eax
   42d45:	c1 e0 03             	shl    $0x3,%eax
   42d48:	01 d0                	add    %edx,%eax
   42d4a:	83 c0 0c             	add    $0xc,%eax
   42d4d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42d51:	89 c1                	mov    %eax,%ecx
   42d53:	48 d3 ea             	shr    %cl,%rdx
   42d56:	48 89 d0             	mov    %rdx,%rax
   42d59:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42d5e:	c9                   	leave  
   42d5f:	c3                   	ret    

0000000000042d60 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42d60:	f3 0f 1e fa          	endbr64 
   42d64:	55                   	push   %rbp
   42d65:	48 89 e5             	mov    %rsp,%rbp
   42d68:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42d6c:	48 8d 05 8d 42 01 00 	lea    0x1428d(%rip),%rax        # 57000 <kernel_pagetables>
   42d73:	48 89 05 86 32 01 00 	mov    %rax,0x13286(%rip)        # 56000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42d7a:	ba 00 50 00 00       	mov    $0x5000,%edx
   42d7f:	be 00 00 00 00       	mov    $0x0,%esi
   42d84:	48 8d 05 75 42 01 00 	lea    0x14275(%rip),%rax        # 57000 <kernel_pagetables>
   42d8b:	48 89 c7             	mov    %rax,%rdi
   42d8e:	e8 a4 0b 00 00       	call   43937 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42d93:	48 8d 05 66 52 01 00 	lea    0x15266(%rip),%rax        # 58000 <kernel_pagetables+0x1000>
   42d9a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42d9e:	48 89 05 5b 42 01 00 	mov    %rax,0x1425b(%rip)        # 57000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42da5:	48 8d 05 54 62 01 00 	lea    0x16254(%rip),%rax        # 59000 <kernel_pagetables+0x2000>
   42dac:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42db0:	48 89 05 49 52 01 00 	mov    %rax,0x15249(%rip)        # 58000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42db7:	48 8d 05 42 72 01 00 	lea    0x17242(%rip),%rax        # 5a000 <kernel_pagetables+0x3000>
   42dbe:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42dc2:	48 89 05 37 62 01 00 	mov    %rax,0x16237(%rip)        # 59000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42dc9:	48 8d 05 30 82 01 00 	lea    0x18230(%rip),%rax        # 5b000 <kernel_pagetables+0x4000>
   42dd0:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42dd4:	48 89 05 2d 62 01 00 	mov    %rax,0x1622d(%rip)        # 59008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42ddb:	48 8b 05 1e 32 01 00 	mov    0x1321e(%rip),%rax        # 56000 <kernel_pagetable>
   42de2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42de8:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42ded:	ba 00 00 00 00       	mov    $0x0,%edx
   42df2:	be 00 00 00 00       	mov    $0x0,%esi
   42df7:	48 89 c7             	mov    %rax,%rdi
   42dfa:	e8 0e 02 00 00       	call   4300d <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42dff:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42e06:	00 
   42e07:	eb 76                	jmp    42e7f <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42e09:	48 8b 0d f0 31 01 00 	mov    0x131f0(%rip),%rcx        # 56000 <kernel_pagetable>
   42e10:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42e14:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e18:	48 89 ce             	mov    %rcx,%rsi
   42e1b:	48 89 c7             	mov    %rax,%rdi
   42e1e:	e8 34 06 00 00       	call   43457 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42e23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e27:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42e2b:	74 1e                	je     42e4b <virtual_memory_init+0xeb>
   42e2d:	48 8d 05 b1 20 00 00 	lea    0x20b1(%rip),%rax        # 44ee5 <complex_keymap+0x125>
   42e34:	48 89 c2             	mov    %rax,%rdx
   42e37:	be 2d 00 00 00       	mov    $0x2d,%esi
   42e3c:	48 8d 05 b2 20 00 00 	lea    0x20b2(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   42e43:	48 89 c7             	mov    %rax,%rdi
   42e46:	e8 3e fe ff ff       	call   42c89 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42e4b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42e4e:	48 98                	cltq   
   42e50:	83 e0 03             	and    $0x3,%eax
   42e53:	48 83 f8 03          	cmp    $0x3,%rax
   42e57:	74 1e                	je     42e77 <virtual_memory_init+0x117>
   42e59:	48 8d 05 a8 20 00 00 	lea    0x20a8(%rip),%rax        # 44f08 <complex_keymap+0x148>
   42e60:	48 89 c2             	mov    %rax,%rdx
   42e63:	be 2e 00 00 00       	mov    $0x2e,%esi
   42e68:	48 8d 05 86 20 00 00 	lea    0x2086(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   42e6f:	48 89 c7             	mov    %rax,%rdi
   42e72:	e8 12 fe ff ff       	call   42c89 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42e77:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42e7e:	00 
   42e7f:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42e86:	00 
   42e87:	76 80                	jbe    42e09 <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42e89:	48 8b 05 70 31 01 00 	mov    0x13170(%rip),%rax        # 56000 <kernel_pagetable>
   42e90:	48 89 c7             	mov    %rax,%rdi
   42e93:	e8 03 00 00 00       	call   42e9b <set_pagetable>
}
   42e98:	90                   	nop
   42e99:	c9                   	leave  
   42e9a:	c3                   	ret    

0000000000042e9b <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42e9b:	f3 0f 1e fa          	endbr64 
   42e9f:	55                   	push   %rbp
   42ea0:	48 89 e5             	mov    %rsp,%rbp
   42ea3:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42ea7:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42eab:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42eaf:	25 ff 0f 00 00       	and    $0xfff,%eax
   42eb4:	48 85 c0             	test   %rax,%rax
   42eb7:	74 1e                	je     42ed7 <set_pagetable+0x3c>
   42eb9:	48 8d 05 75 20 00 00 	lea    0x2075(%rip),%rax        # 44f35 <complex_keymap+0x175>
   42ec0:	48 89 c2             	mov    %rax,%rdx
   42ec3:	be 3c 00 00 00       	mov    $0x3c,%esi
   42ec8:	48 8d 05 26 20 00 00 	lea    0x2026(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   42ecf:	48 89 c7             	mov    %rax,%rdi
   42ed2:	e8 b2 fd ff ff       	call   42c89 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42ed7:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   42ede:	48 89 c2             	mov    %rax,%rdx
   42ee1:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42ee5:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42ee9:	48 89 ce             	mov    %rcx,%rsi
   42eec:	48 89 c7             	mov    %rax,%rdi
   42eef:	e8 63 05 00 00       	call   43457 <virtual_memory_lookup>
   42ef4:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42ef8:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   42eff:	48 39 d0             	cmp    %rdx,%rax
   42f02:	74 1e                	je     42f22 <set_pagetable+0x87>
   42f04:	48 8d 05 45 20 00 00 	lea    0x2045(%rip),%rax        # 44f50 <complex_keymap+0x190>
   42f0b:	48 89 c2             	mov    %rax,%rdx
   42f0e:	be 3e 00 00 00       	mov    $0x3e,%esi
   42f13:	48 8d 05 db 1f 00 00 	lea    0x1fdb(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   42f1a:	48 89 c7             	mov    %rax,%rdi
   42f1d:	e8 67 fd ff ff       	call   42c89 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42f22:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42f26:	48 8b 0d d3 30 01 00 	mov    0x130d3(%rip),%rcx        # 56000 <kernel_pagetable>
   42f2d:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42f31:	48 89 ce             	mov    %rcx,%rsi
   42f34:	48 89 c7             	mov    %rax,%rdi
   42f37:	e8 1b 05 00 00       	call   43457 <virtual_memory_lookup>
   42f3c:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42f40:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42f44:	48 39 c2             	cmp    %rax,%rdx
   42f47:	74 1e                	je     42f67 <set_pagetable+0xcc>
   42f49:	48 8d 05 68 20 00 00 	lea    0x2068(%rip),%rax        # 44fb8 <complex_keymap+0x1f8>
   42f50:	48 89 c2             	mov    %rax,%rdx
   42f53:	be 40 00 00 00       	mov    $0x40,%esi
   42f58:	48 8d 05 96 1f 00 00 	lea    0x1f96(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   42f5f:	48 89 c7             	mov    %rax,%rdi
   42f62:	e8 22 fd ff ff       	call   42c89 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42f67:	48 8b 05 92 30 01 00 	mov    0x13092(%rip),%rax        # 56000 <kernel_pagetable>
   42f6e:	48 89 c2             	mov    %rax,%rdx
   42f71:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42f75:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42f79:	48 89 ce             	mov    %rcx,%rsi
   42f7c:	48 89 c7             	mov    %rax,%rdi
   42f7f:	e8 d3 04 00 00       	call   43457 <virtual_memory_lookup>
   42f84:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42f88:	48 8b 15 71 30 01 00 	mov    0x13071(%rip),%rdx        # 56000 <kernel_pagetable>
   42f8f:	48 39 d0             	cmp    %rdx,%rax
   42f92:	74 1e                	je     42fb2 <set_pagetable+0x117>
   42f94:	48 8d 05 7d 20 00 00 	lea    0x207d(%rip),%rax        # 45018 <complex_keymap+0x258>
   42f9b:	48 89 c2             	mov    %rax,%rdx
   42f9e:	be 42 00 00 00       	mov    $0x42,%esi
   42fa3:	48 8d 05 4b 1f 00 00 	lea    0x1f4b(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   42faa:	48 89 c7             	mov    %rax,%rdi
   42fad:	e8 d7 fc ff ff       	call   42c89 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42fb2:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 4300d <virtual_memory_map>
   42fb9:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42fbd:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42fc1:	48 89 ce             	mov    %rcx,%rsi
   42fc4:	48 89 c7             	mov    %rax,%rdi
   42fc7:	e8 8b 04 00 00       	call   43457 <virtual_memory_lookup>
   42fcc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fd0:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 4300d <virtual_memory_map>
   42fd7:	48 39 d0             	cmp    %rdx,%rax
   42fda:	74 1e                	je     42ffa <set_pagetable+0x15f>
   42fdc:	48 8d 05 9d 20 00 00 	lea    0x209d(%rip),%rax        # 45080 <complex_keymap+0x2c0>
   42fe3:	48 89 c2             	mov    %rax,%rdx
   42fe6:	be 44 00 00 00       	mov    $0x44,%esi
   42feb:	48 8d 05 03 1f 00 00 	lea    0x1f03(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   42ff2:	48 89 c7             	mov    %rax,%rdi
   42ff5:	e8 8f fc ff ff       	call   42c89 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42ffa:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42ffe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   43002:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43006:	0f 22 d8             	mov    %rax,%cr3
}
   43009:	90                   	nop
}
   4300a:	90                   	nop
   4300b:	c9                   	leave  
   4300c:	c3                   	ret    

000000000004300d <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   4300d:	f3 0f 1e fa          	endbr64 
   43011:	55                   	push   %rbp
   43012:	48 89 e5             	mov    %rsp,%rbp
   43015:	48 83 ec 50          	sub    $0x50,%rsp
   43019:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4301d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43021:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43025:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   43029:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4302d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43031:	25 ff 0f 00 00       	and    $0xfff,%eax
   43036:	48 85 c0             	test   %rax,%rax
   43039:	74 1e                	je     43059 <virtual_memory_map+0x4c>
   4303b:	48 8d 05 a4 20 00 00 	lea    0x20a4(%rip),%rax        # 450e6 <complex_keymap+0x326>
   43042:	48 89 c2             	mov    %rax,%rdx
   43045:	be 65 00 00 00       	mov    $0x65,%esi
   4304a:	48 8d 05 a4 1e 00 00 	lea    0x1ea4(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   43051:	48 89 c7             	mov    %rax,%rdi
   43054:	e8 30 fc ff ff       	call   42c89 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   43059:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4305d:	25 ff 0f 00 00       	and    $0xfff,%eax
   43062:	48 85 c0             	test   %rax,%rax
   43065:	74 1e                	je     43085 <virtual_memory_map+0x78>
   43067:	48 8d 05 8b 20 00 00 	lea    0x208b(%rip),%rax        # 450f9 <complex_keymap+0x339>
   4306e:	48 89 c2             	mov    %rax,%rdx
   43071:	be 66 00 00 00       	mov    $0x66,%esi
   43076:	48 8d 05 78 1e 00 00 	lea    0x1e78(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   4307d:	48 89 c7             	mov    %rax,%rdi
   43080:	e8 04 fc ff ff       	call   42c89 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   43085:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43089:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4308d:	48 01 d0             	add    %rdx,%rax
   43090:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   43094:	76 2e                	jbe    430c4 <virtual_memory_map+0xb7>
   43096:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4309a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4309e:	48 01 d0             	add    %rdx,%rax
   430a1:	48 85 c0             	test   %rax,%rax
   430a4:	74 1e                	je     430c4 <virtual_memory_map+0xb7>
   430a6:	48 8d 05 5f 20 00 00 	lea    0x205f(%rip),%rax        # 4510c <complex_keymap+0x34c>
   430ad:	48 89 c2             	mov    %rax,%rdx
   430b0:	be 67 00 00 00       	mov    $0x67,%esi
   430b5:	48 8d 05 39 1e 00 00 	lea    0x1e39(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   430bc:	48 89 c7             	mov    %rax,%rdi
   430bf:	e8 c5 fb ff ff       	call   42c89 <assert_fail>
    if (perm & PTE_P) {
   430c4:	8b 45 bc             	mov    -0x44(%rbp),%eax
   430c7:	48 98                	cltq   
   430c9:	83 e0 01             	and    $0x1,%eax
   430cc:	48 85 c0             	test   %rax,%rax
   430cf:	0f 84 8c 00 00 00    	je     43161 <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   430d5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   430d9:	25 ff 0f 00 00       	and    $0xfff,%eax
   430de:	48 85 c0             	test   %rax,%rax
   430e1:	74 1e                	je     43101 <virtual_memory_map+0xf4>
   430e3:	48 8d 05 40 20 00 00 	lea    0x2040(%rip),%rax        # 4512a <complex_keymap+0x36a>
   430ea:	48 89 c2             	mov    %rax,%rdx
   430ed:	be 69 00 00 00       	mov    $0x69,%esi
   430f2:	48 8d 05 fc 1d 00 00 	lea    0x1dfc(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   430f9:	48 89 c7             	mov    %rax,%rdi
   430fc:	e8 88 fb ff ff       	call   42c89 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   43101:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43105:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43109:	48 01 d0             	add    %rdx,%rax
   4310c:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   43110:	76 1e                	jbe    43130 <virtual_memory_map+0x123>
   43112:	48 8d 05 24 20 00 00 	lea    0x2024(%rip),%rax        # 4513d <complex_keymap+0x37d>
   43119:	48 89 c2             	mov    %rax,%rdx
   4311c:	be 6a 00 00 00       	mov    $0x6a,%esi
   43121:	48 8d 05 cd 1d 00 00 	lea    0x1dcd(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   43128:	48 89 c7             	mov    %rax,%rdi
   4312b:	e8 59 fb ff ff       	call   42c89 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   43130:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43134:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43138:	48 01 d0             	add    %rdx,%rax
   4313b:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   43141:	76 1e                	jbe    43161 <virtual_memory_map+0x154>
   43143:	48 8d 05 01 20 00 00 	lea    0x2001(%rip),%rax        # 4514b <complex_keymap+0x38b>
   4314a:	48 89 c2             	mov    %rax,%rdx
   4314d:	be 6b 00 00 00       	mov    $0x6b,%esi
   43152:	48 8d 05 9c 1d 00 00 	lea    0x1d9c(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   43159:	48 89 c7             	mov    %rax,%rdi
   4315c:	e8 28 fb ff ff       	call   42c89 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   43161:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43165:	78 09                	js     43170 <virtual_memory_map+0x163>
   43167:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   4316e:	7e 1e                	jle    4318e <virtual_memory_map+0x181>
   43170:	48 8d 05 f0 1f 00 00 	lea    0x1ff0(%rip),%rax        # 45167 <complex_keymap+0x3a7>
   43177:	48 89 c2             	mov    %rax,%rdx
   4317a:	be 6d 00 00 00       	mov    $0x6d,%esi
   4317f:	48 8d 05 6f 1d 00 00 	lea    0x1d6f(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   43186:	48 89 c7             	mov    %rax,%rdi
   43189:	e8 fb fa ff ff       	call   42c89 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   4318e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43192:	25 ff 0f 00 00       	and    $0xfff,%eax
   43197:	48 85 c0             	test   %rax,%rax
   4319a:	74 1e                	je     431ba <virtual_memory_map+0x1ad>
   4319c:	48 8d 05 e5 1f 00 00 	lea    0x1fe5(%rip),%rax        # 45188 <complex_keymap+0x3c8>
   431a3:	48 89 c2             	mov    %rax,%rdx
   431a6:	be 6e 00 00 00       	mov    $0x6e,%esi
   431ab:	48 8d 05 43 1d 00 00 	lea    0x1d43(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   431b2:	48 89 c7             	mov    %rax,%rdi
   431b5:	e8 cf fa ff ff       	call   42c89 <assert_fail>

    int last_index123 = -1;
   431ba:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   431c1:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   431c8:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   431c9:	e9 ed 00 00 00       	jmp    432bb <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   431ce:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431d2:	48 c1 e8 15          	shr    $0x15,%rax
   431d6:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   431d9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   431dc:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   431df:	74 20                	je     43201 <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   431e1:	8b 55 bc             	mov    -0x44(%rbp),%edx
   431e4:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   431e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   431ec:	48 89 ce             	mov    %rcx,%rsi
   431ef:	48 89 c7             	mov    %rax,%rdi
   431f2:	e8 d6 00 00 00       	call   432cd <lookup_l1pagetable>
   431f7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   431fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   431fe:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   43201:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43204:	48 98                	cltq   
   43206:	83 e0 01             	and    $0x1,%eax
   43209:	48 85 c0             	test   %rax,%rax
   4320c:	74 37                	je     43245 <virtual_memory_map+0x238>
   4320e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43213:	74 30                	je     43245 <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   43215:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43219:	be 03 00 00 00       	mov    $0x3,%esi
   4321e:	48 89 c7             	mov    %rax,%rdi
   43221:	e8 da fa ff ff       	call   42d00 <pageindex>
   43226:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   43229:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4322c:	48 98                	cltq   
   4322e:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   43232:	48 89 c1             	mov    %rax,%rcx
   43235:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43239:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4323c:	48 63 d2             	movslq %edx,%rdx
   4323f:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   43243:	eb 5e                	jmp    432a3 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   43245:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4324a:	74 2a                	je     43276 <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   4324c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43250:	be 03 00 00 00       	mov    $0x3,%esi
   43255:	48 89 c7             	mov    %rax,%rdi
   43258:	e8 a3 fa ff ff       	call   42d00 <pageindex>
   4325d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   43260:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43263:	48 63 c8             	movslq %eax,%rcx
   43266:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4326a:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4326d:	48 63 d2             	movslq %edx,%rdx
   43270:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   43274:	eb 2d                	jmp    432a3 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   43276:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43279:	48 98                	cltq   
   4327b:	83 e0 01             	and    $0x1,%eax
   4327e:	48 85 c0             	test   %rax,%rax
   43281:	74 20                	je     432a3 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   43283:	be 87 00 00 00       	mov    $0x87,%esi
   43288:	48 8d 05 21 1f 00 00 	lea    0x1f21(%rip),%rax        # 451b0 <complex_keymap+0x3f0>
   4328f:	48 89 c7             	mov    %rax,%rdi
   43292:	b8 00 00 00 00       	mov    $0x0,%eax
   43297:	e8 92 f6 ff ff       	call   4292e <log_printf>
            return -1;
   4329c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   432a1:	eb 28                	jmp    432cb <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   432a3:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   432aa:	00 
   432ab:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   432b2:	00 
   432b3:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   432ba:	00 
   432bb:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   432c0:	0f 85 08 ff ff ff    	jne    431ce <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   432c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
   432cb:	c9                   	leave  
   432cc:	c3                   	ret    

00000000000432cd <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   432cd:	f3 0f 1e fa          	endbr64 
   432d1:	55                   	push   %rbp
   432d2:	48 89 e5             	mov    %rsp,%rbp
   432d5:	48 83 ec 40          	sub    $0x40,%rsp
   432d9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   432dd:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   432e1:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   432e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   432ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   432f3:	e9 4f 01 00 00       	jmp    43447 <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        int index = PAGEINDEX(va, i); // Get the index for the current level
   432f8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   432fb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   432ff:	89 d6                	mov    %edx,%esi
   43301:	48 89 c7             	mov    %rax,%rdi
   43304:	e8 f7 f9 ff ff       	call   42d00 <pageindex>
   43309:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   4330c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43310:	8b 55 f0             	mov    -0x10(%rbp),%edx
   43313:	48 63 d2             	movslq %edx,%rdx
   43316:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4331a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   4331e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43322:	83 e0 01             	and    $0x1,%eax
   43325:	48 85 c0             	test   %rax,%rax
   43328:	75 6d                	jne    43397 <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   4332a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4332d:	8d 48 02             	lea    0x2(%rax),%ecx
   43330:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43334:	25 ff 0f 00 00       	and    $0xfff,%eax
   43339:	48 89 c2             	mov    %rax,%rdx
   4333c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43340:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43346:	48 89 c6             	mov    %rax,%rsi
   43349:	48 8d 05 a8 1e 00 00 	lea    0x1ea8(%rip),%rax        # 451f8 <complex_keymap+0x438>
   43350:	48 89 c7             	mov    %rax,%rdi
   43353:	b8 00 00 00 00       	mov    $0x0,%eax
   43358:	e8 d1 f5 ff ff       	call   4292e <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   4335d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43360:	48 98                	cltq   
   43362:	83 e0 01             	and    $0x1,%eax
   43365:	48 85 c0             	test   %rax,%rax
   43368:	75 0a                	jne    43374 <lookup_l1pagetable+0xa7>
                return NULL;
   4336a:	b8 00 00 00 00       	mov    $0x0,%eax
   4336f:	e9 e1 00 00 00       	jmp    43455 <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   43374:	be ac 00 00 00       	mov    $0xac,%esi
   43379:	48 8d 05 e0 1e 00 00 	lea    0x1ee0(%rip),%rax        # 45260 <complex_keymap+0x4a0>
   43380:	48 89 c7             	mov    %rax,%rdi
   43383:	b8 00 00 00 00       	mov    $0x0,%eax
   43388:	e8 a1 f5 ff ff       	call   4292e <log_printf>
            return NULL;
   4338d:	b8 00 00 00 00       	mov    $0x0,%eax
   43392:	e9 be 00 00 00       	jmp    43455 <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   43397:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4339b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   433a1:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   433a7:	76 1e                	jbe    433c7 <lookup_l1pagetable+0xfa>
   433a9:	48 8d 05 f8 1e 00 00 	lea    0x1ef8(%rip),%rax        # 452a8 <complex_keymap+0x4e8>
   433b0:	48 89 c2             	mov    %rax,%rdx
   433b3:	be b1 00 00 00       	mov    $0xb1,%esi
   433b8:	48 8d 05 36 1b 00 00 	lea    0x1b36(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   433bf:	48 89 c7             	mov    %rax,%rdi
   433c2:	e8 c2 f8 ff ff       	call   42c89 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   433c7:	8b 45 cc             	mov    -0x34(%rbp),%eax
   433ca:	48 98                	cltq   
   433cc:	83 e0 02             	and    $0x2,%eax
   433cf:	48 85 c0             	test   %rax,%rax
   433d2:	74 2a                	je     433fe <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   433d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433d8:	83 e0 02             	and    $0x2,%eax
   433db:	48 85 c0             	test   %rax,%rax
   433de:	75 1e                	jne    433fe <lookup_l1pagetable+0x131>
   433e0:	48 8d 05 e1 1e 00 00 	lea    0x1ee1(%rip),%rax        # 452c8 <complex_keymap+0x508>
   433e7:	48 89 c2             	mov    %rax,%rdx
   433ea:	be b3 00 00 00       	mov    $0xb3,%esi
   433ef:	48 8d 05 ff 1a 00 00 	lea    0x1aff(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   433f6:	48 89 c7             	mov    %rax,%rdi
   433f9:	e8 8b f8 ff ff       	call   42c89 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   433fe:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43401:	48 98                	cltq   
   43403:	83 e0 04             	and    $0x4,%eax
   43406:	48 85 c0             	test   %rax,%rax
   43409:	74 2a                	je     43435 <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   4340b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4340f:	83 e0 04             	and    $0x4,%eax
   43412:	48 85 c0             	test   %rax,%rax
   43415:	75 1e                	jne    43435 <lookup_l1pagetable+0x168>
   43417:	48 8d 05 b5 1e 00 00 	lea    0x1eb5(%rip),%rax        # 452d3 <complex_keymap+0x513>
   4341e:	48 89 c2             	mov    %rax,%rdx
   43421:	be b6 00 00 00       	mov    $0xb6,%esi
   43426:	48 8d 05 c8 1a 00 00 	lea    0x1ac8(%rip),%rax        # 44ef5 <complex_keymap+0x135>
   4342d:	48 89 c7             	mov    %rax,%rdi
   43430:	e8 54 f8 ff ff       	call   42c89 <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43435:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43439:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4343f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   43443:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   43447:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   4344b:	0f 8e a7 fe ff ff    	jle    432f8 <lookup_l1pagetable+0x2b>
    }
    return pt;
   43451:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43455:	c9                   	leave  
   43456:	c3                   	ret    

0000000000043457 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   43457:	f3 0f 1e fa          	endbr64 
   4345b:	55                   	push   %rbp
   4345c:	48 89 e5             	mov    %rsp,%rbp
   4345f:	48 83 ec 50          	sub    $0x50,%rsp
   43463:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43467:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   4346b:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   4346f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43473:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   43477:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4347e:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4347f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   43486:	eb 41                	jmp    434c9 <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   43488:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4348b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4348f:	89 d6                	mov    %edx,%esi
   43491:	48 89 c7             	mov    %rax,%rdi
   43494:	e8 67 f8 ff ff       	call   42d00 <pageindex>
   43499:	89 c2                	mov    %eax,%edx
   4349b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4349f:	48 63 d2             	movslq %edx,%rdx
   434a2:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   434a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434aa:	83 e0 06             	and    $0x6,%eax
   434ad:	48 f7 d0             	not    %rax
   434b0:	48 21 d0             	and    %rdx,%rax
   434b3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   434b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434bb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   434c1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   434c5:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   434c9:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   434cd:	7f 0c                	jg     434db <virtual_memory_lookup+0x84>
   434cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434d3:	83 e0 01             	and    $0x1,%eax
   434d6:	48 85 c0             	test   %rax,%rax
   434d9:	75 ad                	jne    43488 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   434db:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   434e2:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   434e9:	ff 
   434ea:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   434f1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434f5:	83 e0 01             	and    $0x1,%eax
   434f8:	48 85 c0             	test   %rax,%rax
   434fb:	74 34                	je     43531 <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   434fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43501:	48 c1 e8 0c          	shr    $0xc,%rax
   43505:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43508:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4350c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43512:	48 89 c2             	mov    %rax,%rdx
   43515:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43519:	25 ff 0f 00 00       	and    $0xfff,%eax
   4351e:	48 09 d0             	or     %rdx,%rax
   43521:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   43525:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43529:	25 ff 0f 00 00       	and    $0xfff,%eax
   4352e:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   43531:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43535:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43539:	48 89 10             	mov    %rdx,(%rax)
   4353c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   43540:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43544:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43548:	48 89 50 10          	mov    %rdx,0x10(%rax)
   4354c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43550:	c9                   	leave  
   43551:	c3                   	ret    

0000000000043552 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   43552:	f3 0f 1e fa          	endbr64 
   43556:	55                   	push   %rbp
   43557:	48 89 e5             	mov    %rsp,%rbp
   4355a:	48 83 ec 40          	sub    $0x40,%rsp
   4355e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43562:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   43565:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   43569:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   43570:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43574:	78 08                	js     4357e <program_load+0x2c>
   43576:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43579:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   4357c:	7c 1e                	jl     4359c <program_load+0x4a>
   4357e:	48 8d 05 5b 1d 00 00 	lea    0x1d5b(%rip),%rax        # 452e0 <complex_keymap+0x520>
   43585:	48 89 c2             	mov    %rax,%rdx
   43588:	be 37 00 00 00       	mov    $0x37,%esi
   4358d:	48 8d 05 7c 1d 00 00 	lea    0x1d7c(%rip),%rax        # 45310 <complex_keymap+0x550>
   43594:	48 89 c7             	mov    %rax,%rdi
   43597:	e8 ed f6 ff ff       	call   42c89 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4359c:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   4359f:	48 98                	cltq   
   435a1:	48 c1 e0 04          	shl    $0x4,%rax
   435a5:	48 89 c2             	mov    %rax,%rdx
   435a8:	48 8d 05 71 2a 00 00 	lea    0x2a71(%rip),%rax        # 46020 <ramimages>
   435af:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   435b3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   435b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435bb:	8b 00                	mov    (%rax),%eax
   435bd:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   435c2:	74 1e                	je     435e2 <program_load+0x90>
   435c4:	48 8d 05 57 1d 00 00 	lea    0x1d57(%rip),%rax        # 45322 <complex_keymap+0x562>
   435cb:	48 89 c2             	mov    %rax,%rdx
   435ce:	be 39 00 00 00       	mov    $0x39,%esi
   435d3:	48 8d 05 36 1d 00 00 	lea    0x1d36(%rip),%rax        # 45310 <complex_keymap+0x550>
   435da:	48 89 c7             	mov    %rax,%rdi
   435dd:	e8 a7 f6 ff ff       	call   42c89 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   435e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435e6:	48 8b 50 20          	mov    0x20(%rax),%rdx
   435ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435ee:	48 01 d0             	add    %rdx,%rax
   435f1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   435f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   435fc:	e9 94 00 00 00       	jmp    43695 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43601:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43604:	48 63 d0             	movslq %eax,%rdx
   43607:	48 89 d0             	mov    %rdx,%rax
   4360a:	48 c1 e0 03          	shl    $0x3,%rax
   4360e:	48 29 d0             	sub    %rdx,%rax
   43611:	48 c1 e0 03          	shl    $0x3,%rax
   43615:	48 89 c2             	mov    %rax,%rdx
   43618:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4361c:	48 01 d0             	add    %rdx,%rax
   4361f:	8b 00                	mov    (%rax),%eax
   43621:	83 f8 01             	cmp    $0x1,%eax
   43624:	75 6b                	jne    43691 <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   43626:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43629:	48 63 d0             	movslq %eax,%rdx
   4362c:	48 89 d0             	mov    %rdx,%rax
   4362f:	48 c1 e0 03          	shl    $0x3,%rax
   43633:	48 29 d0             	sub    %rdx,%rax
   43636:	48 c1 e0 03          	shl    $0x3,%rax
   4363a:	48 89 c2             	mov    %rax,%rdx
   4363d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43641:	48 01 d0             	add    %rdx,%rax
   43644:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43648:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4364c:	48 01 d0             	add    %rdx,%rax
   4364f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   43653:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43656:	48 63 d0             	movslq %eax,%rdx
   43659:	48 89 d0             	mov    %rdx,%rax
   4365c:	48 c1 e0 03          	shl    $0x3,%rax
   43660:	48 29 d0             	sub    %rdx,%rax
   43663:	48 c1 e0 03          	shl    $0x3,%rax
   43667:	48 89 c2             	mov    %rax,%rdx
   4366a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4366e:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43672:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   43676:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4367a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4367e:	48 89 c7             	mov    %rax,%rdi
   43681:	e8 3d 00 00 00       	call   436c3 <program_load_segment>
   43686:	85 c0                	test   %eax,%eax
   43688:	79 07                	jns    43691 <program_load+0x13f>
                return -1;
   4368a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4368f:	eb 30                	jmp    436c1 <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43691:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43695:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43699:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   4369d:	0f b7 c0             	movzwl %ax,%eax
   436a0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   436a3:	0f 8c 58 ff ff ff    	jl     43601 <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   436a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436ad:	48 8b 50 18          	mov    0x18(%rax),%rdx
   436b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436b5:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   436bc:	b8 00 00 00 00       	mov    $0x0,%eax
}
   436c1:	c9                   	leave  
   436c2:	c3                   	ret    

00000000000436c3 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   436c3:	f3 0f 1e fa          	endbr64 
   436c7:	55                   	push   %rbp
   436c8:	48 89 e5             	mov    %rsp,%rbp
   436cb:	48 83 ec 50          	sub    $0x50,%rsp
   436cf:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   436d3:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   436d7:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   436db:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   436df:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   436e3:	48 8b 40 10          	mov    0x10(%rax),%rax
   436e7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   436eb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   436ef:	48 8b 50 20          	mov    0x20(%rax),%rdx
   436f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436f7:	48 01 d0             	add    %rdx,%rax
   436fa:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   436fe:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43702:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43706:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4370a:	48 01 d0             	add    %rdx,%rax
   4370d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);   
   43711:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   43718:	ff 

    int permz = PTE_P | PTE_U;  // Always present and user-accessible
   43719:	c7 45 fc 05 00 00 00 	movl   $0x5,-0x4(%rbp)
    if (ph->p_flags & ELF_PFLAG_WRITE) {
   43720:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43724:	8b 40 04             	mov    0x4(%rax),%eax
   43727:	83 e0 02             	and    $0x2,%eax
   4372a:	85 c0                	test   %eax,%eax
   4372c:	74 04                	je     43732 <program_load_segment+0x6f>
        permz |= PTE_W;  // Add writable permission if segment is writable
   4372e:	83 4d fc 02          	orl    $0x2,-0x4(%rbp)
    }
    

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43732:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43736:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4373a:	e9 81 00 00 00       	jmp    437c0 <program_load_segment+0xfd>
        if (assign_physical_page(addr, p->p_pid) < 0
   4373f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43743:	8b 00                	mov    (%rax),%eax
   43745:	0f be d0             	movsbl %al,%edx
   43748:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4374c:	89 d6                	mov    %edx,%esi
   4374e:	48 89 c7             	mov    %rax,%rdi
   43751:	e8 b3 cf ff ff       	call   40709 <assign_physical_page>
   43756:	85 c0                	test   %eax,%eax
   43758:	78 2a                	js     43784 <program_load_segment+0xc1>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   4375a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4375e:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43765:	8b 4d fc             	mov    -0x4(%rbp),%ecx
   43768:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4376c:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   43770:	41 89 c8             	mov    %ecx,%r8d
   43773:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43778:	48 89 c7             	mov    %rax,%rdi
   4377b:	e8 8d f8 ff ff       	call   4300d <virtual_memory_map>
   43780:	85 c0                	test   %eax,%eax
   43782:	79 34                	jns    437b8 <program_load_segment+0xf5>
                                  permz) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43784:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43788:	8b 00                	mov    (%rax),%eax
   4378a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4378e:	49 89 d0             	mov    %rdx,%r8
   43791:	89 c1                	mov    %eax,%ecx
   43793:	48 8d 05 a6 1b 00 00 	lea    0x1ba6(%rip),%rax        # 45340 <complex_keymap+0x580>
   4379a:	48 89 c2             	mov    %rax,%rdx
   4379d:	be 00 c0 00 00       	mov    $0xc000,%esi
   437a2:	bf e0 06 00 00       	mov    $0x6e0,%edi
   437a7:	b8 00 00 00 00       	mov    $0x0,%eax
   437ac:	e8 c5 0f 00 00       	call   44776 <console_printf>
            return -1;
   437b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   437b6:	eb 77                	jmp    4382f <program_load_segment+0x16c>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   437b8:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   437bf:	00 
   437c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437c4:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   437c8:	0f 82 71 ff ff ff    	jb     4373f <program_load_segment+0x7c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   437ce:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   437d2:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   437d9:	48 89 c7             	mov    %rax,%rdi
   437dc:	e8 ba f6 ff ff       	call   42e9b <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   437e1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437e5:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   437e9:	48 89 c2             	mov    %rax,%rdx
   437ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437f0:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   437f4:	48 89 ce             	mov    %rcx,%rsi
   437f7:	48 89 c7             	mov    %rax,%rdi
   437fa:	e8 32 00 00 00       	call   43831 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   437ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43803:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   43807:	48 89 c2             	mov    %rax,%rdx
   4380a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4380e:	be 00 00 00 00       	mov    $0x0,%esi
   43813:	48 89 c7             	mov    %rax,%rdi
   43816:	e8 1c 01 00 00       	call   43937 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   4381b:	48 8b 05 de 27 01 00 	mov    0x127de(%rip),%rax        # 56000 <kernel_pagetable>
   43822:	48 89 c7             	mov    %rax,%rdi
   43825:	e8 71 f6 ff ff       	call   42e9b <set_pagetable>
    return 0;
   4382a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4382f:	c9                   	leave  
   43830:	c3                   	ret    

0000000000043831 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43831:	f3 0f 1e fa          	endbr64 
   43835:	55                   	push   %rbp
   43836:	48 89 e5             	mov    %rsp,%rbp
   43839:	48 83 ec 28          	sub    $0x28,%rsp
   4383d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43841:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43845:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43849:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4384d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43851:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43855:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43859:	eb 1c                	jmp    43877 <memcpy+0x46>
        *d = *s;
   4385b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4385f:	0f b6 10             	movzbl (%rax),%edx
   43862:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43866:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43868:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4386d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43872:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43877:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4387c:	75 dd                	jne    4385b <memcpy+0x2a>
    }
    return dst;
   4387e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43882:	c9                   	leave  
   43883:	c3                   	ret    

0000000000043884 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43884:	f3 0f 1e fa          	endbr64 
   43888:	55                   	push   %rbp
   43889:	48 89 e5             	mov    %rsp,%rbp
   4388c:	48 83 ec 28          	sub    $0x28,%rsp
   43890:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43894:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43898:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   4389c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   438a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   438a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438a8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   438ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438b0:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   438b4:	73 6a                	jae    43920 <memmove+0x9c>
   438b6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   438ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438be:	48 01 d0             	add    %rdx,%rax
   438c1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   438c5:	73 59                	jae    43920 <memmove+0x9c>
        s += n, d += n;
   438c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438cb:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   438cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438d3:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   438d7:	eb 17                	jmp    438f0 <memmove+0x6c>
            *--d = *--s;
   438d9:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   438de:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   438e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438e7:	0f b6 10             	movzbl (%rax),%edx
   438ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438ee:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   438f0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438f4:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   438f8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   438fc:	48 85 c0             	test   %rax,%rax
   438ff:	75 d8                	jne    438d9 <memmove+0x55>
    if (s < d && s + n > d) {
   43901:	eb 2e                	jmp    43931 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43903:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43907:	48 8d 42 01          	lea    0x1(%rdx),%rax
   4390b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4390f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43913:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43917:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   4391b:	0f b6 12             	movzbl (%rdx),%edx
   4391e:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43920:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43924:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43928:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   4392c:	48 85 c0             	test   %rax,%rax
   4392f:	75 d2                	jne    43903 <memmove+0x7f>
        }
    }
    return dst;
   43931:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43935:	c9                   	leave  
   43936:	c3                   	ret    

0000000000043937 <memset>:

void* memset(void* v, int c, size_t n) {
   43937:	f3 0f 1e fa          	endbr64 
   4393b:	55                   	push   %rbp
   4393c:	48 89 e5             	mov    %rsp,%rbp
   4393f:	48 83 ec 28          	sub    $0x28,%rsp
   43943:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43947:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4394a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4394e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43952:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43956:	eb 15                	jmp    4396d <memset+0x36>
        *p = c;
   43958:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4395b:	89 c2                	mov    %eax,%edx
   4395d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43961:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43963:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43968:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4396d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43972:	75 e4                	jne    43958 <memset+0x21>
    }
    return v;
   43974:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43978:	c9                   	leave  
   43979:	c3                   	ret    

000000000004397a <strlen>:

size_t strlen(const char* s) {
   4397a:	f3 0f 1e fa          	endbr64 
   4397e:	55                   	push   %rbp
   4397f:	48 89 e5             	mov    %rsp,%rbp
   43982:	48 83 ec 18          	sub    $0x18,%rsp
   43986:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   4398a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43991:	00 
   43992:	eb 0a                	jmp    4399e <strlen+0x24>
        ++n;
   43994:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43999:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4399e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439a2:	0f b6 00             	movzbl (%rax),%eax
   439a5:	84 c0                	test   %al,%al
   439a7:	75 eb                	jne    43994 <strlen+0x1a>
    }
    return n;
   439a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   439ad:	c9                   	leave  
   439ae:	c3                   	ret    

00000000000439af <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   439af:	f3 0f 1e fa          	endbr64 
   439b3:	55                   	push   %rbp
   439b4:	48 89 e5             	mov    %rsp,%rbp
   439b7:	48 83 ec 20          	sub    $0x20,%rsp
   439bb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   439bf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   439c3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   439ca:	00 
   439cb:	eb 0a                	jmp    439d7 <strnlen+0x28>
        ++n;
   439cd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   439d2:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   439d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   439db:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   439df:	74 0b                	je     439ec <strnlen+0x3d>
   439e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439e5:	0f b6 00             	movzbl (%rax),%eax
   439e8:	84 c0                	test   %al,%al
   439ea:	75 e1                	jne    439cd <strnlen+0x1e>
    }
    return n;
   439ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   439f0:	c9                   	leave  
   439f1:	c3                   	ret    

00000000000439f2 <strcpy>:

char* strcpy(char* dst, const char* src) {
   439f2:	f3 0f 1e fa          	endbr64 
   439f6:	55                   	push   %rbp
   439f7:	48 89 e5             	mov    %rsp,%rbp
   439fa:	48 83 ec 20          	sub    $0x20,%rsp
   439fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43a02:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43a06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a0a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43a0e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43a12:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43a16:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43a1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a1e:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43a22:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43a26:	0f b6 12             	movzbl (%rdx),%edx
   43a29:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43a2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a2f:	48 83 e8 01          	sub    $0x1,%rax
   43a33:	0f b6 00             	movzbl (%rax),%eax
   43a36:	84 c0                	test   %al,%al
   43a38:	75 d4                	jne    43a0e <strcpy+0x1c>
    return dst;
   43a3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43a3e:	c9                   	leave  
   43a3f:	c3                   	ret    

0000000000043a40 <strcmp>:

int strcmp(const char* a, const char* b) {
   43a40:	f3 0f 1e fa          	endbr64 
   43a44:	55                   	push   %rbp
   43a45:	48 89 e5             	mov    %rsp,%rbp
   43a48:	48 83 ec 10          	sub    $0x10,%rsp
   43a4c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43a50:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43a54:	eb 0a                	jmp    43a60 <strcmp+0x20>
        ++a, ++b;
   43a56:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43a5b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43a60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a64:	0f b6 00             	movzbl (%rax),%eax
   43a67:	84 c0                	test   %al,%al
   43a69:	74 1d                	je     43a88 <strcmp+0x48>
   43a6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a6f:	0f b6 00             	movzbl (%rax),%eax
   43a72:	84 c0                	test   %al,%al
   43a74:	74 12                	je     43a88 <strcmp+0x48>
   43a76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a7a:	0f b6 10             	movzbl (%rax),%edx
   43a7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a81:	0f b6 00             	movzbl (%rax),%eax
   43a84:	38 c2                	cmp    %al,%dl
   43a86:	74 ce                	je     43a56 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43a88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a8c:	0f b6 00             	movzbl (%rax),%eax
   43a8f:	89 c2                	mov    %eax,%edx
   43a91:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a95:	0f b6 00             	movzbl (%rax),%eax
   43a98:	38 c2                	cmp    %al,%dl
   43a9a:	0f 97 c0             	seta   %al
   43a9d:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43aa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43aa4:	0f b6 00             	movzbl (%rax),%eax
   43aa7:	89 c1                	mov    %eax,%ecx
   43aa9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43aad:	0f b6 00             	movzbl (%rax),%eax
   43ab0:	38 c1                	cmp    %al,%cl
   43ab2:	0f 92 c0             	setb   %al
   43ab5:	0f b6 c8             	movzbl %al,%ecx
   43ab8:	89 d0                	mov    %edx,%eax
   43aba:	29 c8                	sub    %ecx,%eax
}
   43abc:	c9                   	leave  
   43abd:	c3                   	ret    

0000000000043abe <strchr>:

char* strchr(const char* s, int c) {
   43abe:	f3 0f 1e fa          	endbr64 
   43ac2:	55                   	push   %rbp
   43ac3:	48 89 e5             	mov    %rsp,%rbp
   43ac6:	48 83 ec 10          	sub    $0x10,%rsp
   43aca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43ace:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43ad1:	eb 05                	jmp    43ad8 <strchr+0x1a>
        ++s;
   43ad3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43ad8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43adc:	0f b6 00             	movzbl (%rax),%eax
   43adf:	84 c0                	test   %al,%al
   43ae1:	74 0e                	je     43af1 <strchr+0x33>
   43ae3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ae7:	0f b6 00             	movzbl (%rax),%eax
   43aea:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43aed:	38 d0                	cmp    %dl,%al
   43aef:	75 e2                	jne    43ad3 <strchr+0x15>
    }
    if (*s == (char) c) {
   43af1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43af5:	0f b6 00             	movzbl (%rax),%eax
   43af8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43afb:	38 d0                	cmp    %dl,%al
   43afd:	75 06                	jne    43b05 <strchr+0x47>
        return (char*) s;
   43aff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b03:	eb 05                	jmp    43b0a <strchr+0x4c>
    } else {
        return NULL;
   43b05:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43b0a:	c9                   	leave  
   43b0b:	c3                   	ret    

0000000000043b0c <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43b0c:	f3 0f 1e fa          	endbr64 
   43b10:	55                   	push   %rbp
   43b11:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43b14:	8b 05 e6 84 01 00    	mov    0x184e6(%rip),%eax        # 5c000 <rand_seed_set>
   43b1a:	85 c0                	test   %eax,%eax
   43b1c:	75 0a                	jne    43b28 <rand+0x1c>
        srand(819234718U);
   43b1e:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43b23:	e8 24 00 00 00       	call   43b4c <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43b28:	8b 05 d6 84 01 00    	mov    0x184d6(%rip),%eax        # 5c004 <rand_seed>
   43b2e:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43b34:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43b39:	89 05 c5 84 01 00    	mov    %eax,0x184c5(%rip)        # 5c004 <rand_seed>
    return rand_seed & RAND_MAX;
   43b3f:	8b 05 bf 84 01 00    	mov    0x184bf(%rip),%eax        # 5c004 <rand_seed>
   43b45:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43b4a:	5d                   	pop    %rbp
   43b4b:	c3                   	ret    

0000000000043b4c <srand>:

void srand(unsigned seed) {
   43b4c:	f3 0f 1e fa          	endbr64 
   43b50:	55                   	push   %rbp
   43b51:	48 89 e5             	mov    %rsp,%rbp
   43b54:	48 83 ec 08          	sub    $0x8,%rsp
   43b58:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43b5b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43b5e:	89 05 a0 84 01 00    	mov    %eax,0x184a0(%rip)        # 5c004 <rand_seed>
    rand_seed_set = 1;
   43b64:	c7 05 92 84 01 00 01 	movl   $0x1,0x18492(%rip)        # 5c000 <rand_seed_set>
   43b6b:	00 00 00 
}
   43b6e:	90                   	nop
   43b6f:	c9                   	leave  
   43b70:	c3                   	ret    

0000000000043b71 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43b71:	f3 0f 1e fa          	endbr64 
   43b75:	55                   	push   %rbp
   43b76:	48 89 e5             	mov    %rsp,%rbp
   43b79:	48 83 ec 28          	sub    $0x28,%rsp
   43b7d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b81:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43b85:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43b88:	48 8d 05 f1 18 00 00 	lea    0x18f1(%rip),%rax        # 45480 <upper_digits.1>
   43b8f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   43b93:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43b97:	79 0e                	jns    43ba7 <fill_numbuf+0x36>
        digits = lower_digits;
   43b99:	48 8d 05 00 19 00 00 	lea    0x1900(%rip),%rax        # 454a0 <lower_digits.0>
   43ba0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   43ba4:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43ba7:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43bac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bb0:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43bb3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43bb6:	48 63 c8             	movslq %eax,%rcx
   43bb9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43bbd:	ba 00 00 00 00       	mov    $0x0,%edx
   43bc2:	48 f7 f1             	div    %rcx
   43bc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bc9:	48 01 d0             	add    %rdx,%rax
   43bcc:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43bd1:	0f b6 10             	movzbl (%rax),%edx
   43bd4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bd8:	88 10                	mov    %dl,(%rax)
        val /= base;
   43bda:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43bdd:	48 63 f0             	movslq %eax,%rsi
   43be0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43be4:	ba 00 00 00 00       	mov    $0x0,%edx
   43be9:	48 f7 f6             	div    %rsi
   43bec:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43bf0:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43bf5:	75 bc                	jne    43bb3 <fill_numbuf+0x42>
    return numbuf_end;
   43bf7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43bfb:	c9                   	leave  
   43bfc:	c3                   	ret    

0000000000043bfd <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43bfd:	f3 0f 1e fa          	endbr64 
   43c01:	55                   	push   %rbp
   43c02:	48 89 e5             	mov    %rsp,%rbp
   43c05:	53                   	push   %rbx
   43c06:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43c0d:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43c14:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43c1a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43c21:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43c28:	e9 bd 09 00 00       	jmp    445ea <printer_vprintf+0x9ed>
        if (*format != '%') {
   43c2d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c34:	0f b6 00             	movzbl (%rax),%eax
   43c37:	3c 25                	cmp    $0x25,%al
   43c39:	74 31                	je     43c6c <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   43c3b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c42:	4c 8b 00             	mov    (%rax),%r8
   43c45:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c4c:	0f b6 00             	movzbl (%rax),%eax
   43c4f:	0f b6 c8             	movzbl %al,%ecx
   43c52:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43c58:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c5f:	89 ce                	mov    %ecx,%esi
   43c61:	48 89 c7             	mov    %rax,%rdi
   43c64:	41 ff d0             	call   *%r8
            continue;
   43c67:	e9 76 09 00 00       	jmp    445e2 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   43c6c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43c73:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43c7a:	01 
   43c7b:	eb 4d                	jmp    43cca <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   43c7d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c84:	0f b6 00             	movzbl (%rax),%eax
   43c87:	0f be c0             	movsbl %al,%eax
   43c8a:	89 c6                	mov    %eax,%esi
   43c8c:	48 8d 05 ed 16 00 00 	lea    0x16ed(%rip),%rax        # 45380 <flag_chars>
   43c93:	48 89 c7             	mov    %rax,%rdi
   43c96:	e8 23 fe ff ff       	call   43abe <strchr>
   43c9b:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43c9f:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43ca4:	74 34                	je     43cda <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   43ca6:	48 8d 15 d3 16 00 00 	lea    0x16d3(%rip),%rdx        # 45380 <flag_chars>
   43cad:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43cb1:	48 29 d0             	sub    %rdx,%rax
   43cb4:	ba 01 00 00 00       	mov    $0x1,%edx
   43cb9:	89 c1                	mov    %eax,%ecx
   43cbb:	d3 e2                	shl    %cl,%edx
   43cbd:	89 d0                	mov    %edx,%eax
   43cbf:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43cc2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43cc9:	01 
   43cca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cd1:	0f b6 00             	movzbl (%rax),%eax
   43cd4:	84 c0                	test   %al,%al
   43cd6:	75 a5                	jne    43c7d <printer_vprintf+0x80>
   43cd8:	eb 01                	jmp    43cdb <printer_vprintf+0xde>
            } else {
                break;
   43cda:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43cdb:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43ce2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ce9:	0f b6 00             	movzbl (%rax),%eax
   43cec:	3c 30                	cmp    $0x30,%al
   43cee:	7e 67                	jle    43d57 <printer_vprintf+0x15a>
   43cf0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cf7:	0f b6 00             	movzbl (%rax),%eax
   43cfa:	3c 39                	cmp    $0x39,%al
   43cfc:	7f 59                	jg     43d57 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43cfe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43d05:	eb 2e                	jmp    43d35 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   43d07:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43d0a:	89 d0                	mov    %edx,%eax
   43d0c:	c1 e0 02             	shl    $0x2,%eax
   43d0f:	01 d0                	add    %edx,%eax
   43d11:	01 c0                	add    %eax,%eax
   43d13:	89 c1                	mov    %eax,%ecx
   43d15:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d1c:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43d20:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43d27:	0f b6 00             	movzbl (%rax),%eax
   43d2a:	0f be c0             	movsbl %al,%eax
   43d2d:	01 c8                	add    %ecx,%eax
   43d2f:	83 e8 30             	sub    $0x30,%eax
   43d32:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43d35:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d3c:	0f b6 00             	movzbl (%rax),%eax
   43d3f:	3c 2f                	cmp    $0x2f,%al
   43d41:	0f 8e 85 00 00 00    	jle    43dcc <printer_vprintf+0x1cf>
   43d47:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d4e:	0f b6 00             	movzbl (%rax),%eax
   43d51:	3c 39                	cmp    $0x39,%al
   43d53:	7e b2                	jle    43d07 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   43d55:	eb 75                	jmp    43dcc <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   43d57:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d5e:	0f b6 00             	movzbl (%rax),%eax
   43d61:	3c 2a                	cmp    $0x2a,%al
   43d63:	75 68                	jne    43dcd <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   43d65:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d6c:	8b 00                	mov    (%rax),%eax
   43d6e:	83 f8 2f             	cmp    $0x2f,%eax
   43d71:	77 30                	ja     43da3 <printer_vprintf+0x1a6>
   43d73:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d7a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d7e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d85:	8b 00                	mov    (%rax),%eax
   43d87:	89 c0                	mov    %eax,%eax
   43d89:	48 01 d0             	add    %rdx,%rax
   43d8c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d93:	8b 12                	mov    (%rdx),%edx
   43d95:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d98:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d9f:	89 0a                	mov    %ecx,(%rdx)
   43da1:	eb 1a                	jmp    43dbd <printer_vprintf+0x1c0>
   43da3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43daa:	48 8b 40 08          	mov    0x8(%rax),%rax
   43dae:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43db2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43db9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43dbd:	8b 00                	mov    (%rax),%eax
   43dbf:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43dc2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43dc9:	01 
   43dca:	eb 01                	jmp    43dcd <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   43dcc:	90                   	nop
        }

        // process precision
        int precision = -1;
   43dcd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43dd4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ddb:	0f b6 00             	movzbl (%rax),%eax
   43dde:	3c 2e                	cmp    $0x2e,%al
   43de0:	0f 85 00 01 00 00    	jne    43ee6 <printer_vprintf+0x2e9>
            ++format;
   43de6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43ded:	01 
            if (*format >= '0' && *format <= '9') {
   43dee:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43df5:	0f b6 00             	movzbl (%rax),%eax
   43df8:	3c 2f                	cmp    $0x2f,%al
   43dfa:	7e 67                	jle    43e63 <printer_vprintf+0x266>
   43dfc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e03:	0f b6 00             	movzbl (%rax),%eax
   43e06:	3c 39                	cmp    $0x39,%al
   43e08:	7f 59                	jg     43e63 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43e0a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43e11:	eb 2e                	jmp    43e41 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   43e13:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43e16:	89 d0                	mov    %edx,%eax
   43e18:	c1 e0 02             	shl    $0x2,%eax
   43e1b:	01 d0                	add    %edx,%eax
   43e1d:	01 c0                	add    %eax,%eax
   43e1f:	89 c1                	mov    %eax,%ecx
   43e21:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e28:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43e2c:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43e33:	0f b6 00             	movzbl (%rax),%eax
   43e36:	0f be c0             	movsbl %al,%eax
   43e39:	01 c8                	add    %ecx,%eax
   43e3b:	83 e8 30             	sub    $0x30,%eax
   43e3e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43e41:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e48:	0f b6 00             	movzbl (%rax),%eax
   43e4b:	3c 2f                	cmp    $0x2f,%al
   43e4d:	0f 8e 85 00 00 00    	jle    43ed8 <printer_vprintf+0x2db>
   43e53:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e5a:	0f b6 00             	movzbl (%rax),%eax
   43e5d:	3c 39                	cmp    $0x39,%al
   43e5f:	7e b2                	jle    43e13 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   43e61:	eb 75                	jmp    43ed8 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   43e63:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e6a:	0f b6 00             	movzbl (%rax),%eax
   43e6d:	3c 2a                	cmp    $0x2a,%al
   43e6f:	75 68                	jne    43ed9 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   43e71:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e78:	8b 00                	mov    (%rax),%eax
   43e7a:	83 f8 2f             	cmp    $0x2f,%eax
   43e7d:	77 30                	ja     43eaf <printer_vprintf+0x2b2>
   43e7f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e86:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e8a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e91:	8b 00                	mov    (%rax),%eax
   43e93:	89 c0                	mov    %eax,%eax
   43e95:	48 01 d0             	add    %rdx,%rax
   43e98:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e9f:	8b 12                	mov    (%rdx),%edx
   43ea1:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43ea4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43eab:	89 0a                	mov    %ecx,(%rdx)
   43ead:	eb 1a                	jmp    43ec9 <printer_vprintf+0x2cc>
   43eaf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43eb6:	48 8b 40 08          	mov    0x8(%rax),%rax
   43eba:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43ebe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ec5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ec9:	8b 00                	mov    (%rax),%eax
   43ecb:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43ece:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43ed5:	01 
   43ed6:	eb 01                	jmp    43ed9 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   43ed8:	90                   	nop
            }
            if (precision < 0) {
   43ed9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43edd:	79 07                	jns    43ee6 <printer_vprintf+0x2e9>
                precision = 0;
   43edf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43ee6:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43eed:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43ef4:	00 
        int length = 0;
   43ef5:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43efc:	48 8d 05 83 14 00 00 	lea    0x1483(%rip),%rax        # 45386 <flag_chars+0x6>
   43f03:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   43f07:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f0e:	0f b6 00             	movzbl (%rax),%eax
   43f11:	0f be c0             	movsbl %al,%eax
   43f14:	83 e8 43             	sub    $0x43,%eax
   43f17:	83 f8 37             	cmp    $0x37,%eax
   43f1a:	0f 87 b6 03 00 00    	ja     442d6 <printer_vprintf+0x6d9>
   43f20:	89 c0                	mov    %eax,%eax
   43f22:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   43f29:	00 
   43f2a:	48 8d 05 63 14 00 00 	lea    0x1463(%rip),%rax        # 45394 <flag_chars+0x14>
   43f31:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   43f34:	48 98                	cltq   
   43f36:	48 8d 15 57 14 00 00 	lea    0x1457(%rip),%rdx        # 45394 <flag_chars+0x14>
   43f3d:	48 01 d0             	add    %rdx,%rax
   43f40:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   43f43:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43f4a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43f51:	01 
            goto again;
   43f52:	eb b3                	jmp    43f07 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43f54:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43f58:	74 5d                	je     43fb7 <printer_vprintf+0x3ba>
   43f5a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f61:	8b 00                	mov    (%rax),%eax
   43f63:	83 f8 2f             	cmp    $0x2f,%eax
   43f66:	77 30                	ja     43f98 <printer_vprintf+0x39b>
   43f68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f6f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f73:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f7a:	8b 00                	mov    (%rax),%eax
   43f7c:	89 c0                	mov    %eax,%eax
   43f7e:	48 01 d0             	add    %rdx,%rax
   43f81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f88:	8b 12                	mov    (%rdx),%edx
   43f8a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f8d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f94:	89 0a                	mov    %ecx,(%rdx)
   43f96:	eb 1a                	jmp    43fb2 <printer_vprintf+0x3b5>
   43f98:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f9f:	48 8b 40 08          	mov    0x8(%rax),%rax
   43fa3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43fa7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fae:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43fb2:	48 8b 00             	mov    (%rax),%rax
   43fb5:	eb 5c                	jmp    44013 <printer_vprintf+0x416>
   43fb7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fbe:	8b 00                	mov    (%rax),%eax
   43fc0:	83 f8 2f             	cmp    $0x2f,%eax
   43fc3:	77 30                	ja     43ff5 <printer_vprintf+0x3f8>
   43fc5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fcc:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43fd0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fd7:	8b 00                	mov    (%rax),%eax
   43fd9:	89 c0                	mov    %eax,%eax
   43fdb:	48 01 d0             	add    %rdx,%rax
   43fde:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fe5:	8b 12                	mov    (%rdx),%edx
   43fe7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43fea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ff1:	89 0a                	mov    %ecx,(%rdx)
   43ff3:	eb 1a                	jmp    4400f <printer_vprintf+0x412>
   43ff5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ffc:	48 8b 40 08          	mov    0x8(%rax),%rax
   44000:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44004:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4400b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4400f:	8b 00                	mov    (%rax),%eax
   44011:	48 98                	cltq   
   44013:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   44017:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4401b:	48 c1 f8 38          	sar    $0x38,%rax
   4401f:	25 80 00 00 00       	and    $0x80,%eax
   44024:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   44027:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   4402b:	74 09                	je     44036 <printer_vprintf+0x439>
   4402d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44031:	48 f7 d8             	neg    %rax
   44034:	eb 04                	jmp    4403a <printer_vprintf+0x43d>
   44036:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4403a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   4403e:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   44041:	83 c8 60             	or     $0x60,%eax
   44044:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   44047:	e9 cf 02 00 00       	jmp    4431b <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   4404c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44050:	74 5d                	je     440af <printer_vprintf+0x4b2>
   44052:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44059:	8b 00                	mov    (%rax),%eax
   4405b:	83 f8 2f             	cmp    $0x2f,%eax
   4405e:	77 30                	ja     44090 <printer_vprintf+0x493>
   44060:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44067:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4406b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44072:	8b 00                	mov    (%rax),%eax
   44074:	89 c0                	mov    %eax,%eax
   44076:	48 01 d0             	add    %rdx,%rax
   44079:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44080:	8b 12                	mov    (%rdx),%edx
   44082:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44085:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4408c:	89 0a                	mov    %ecx,(%rdx)
   4408e:	eb 1a                	jmp    440aa <printer_vprintf+0x4ad>
   44090:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44097:	48 8b 40 08          	mov    0x8(%rax),%rax
   4409b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4409f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440a6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440aa:	48 8b 00             	mov    (%rax),%rax
   440ad:	eb 5c                	jmp    4410b <printer_vprintf+0x50e>
   440af:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440b6:	8b 00                	mov    (%rax),%eax
   440b8:	83 f8 2f             	cmp    $0x2f,%eax
   440bb:	77 30                	ja     440ed <printer_vprintf+0x4f0>
   440bd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440c4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   440c8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440cf:	8b 00                	mov    (%rax),%eax
   440d1:	89 c0                	mov    %eax,%eax
   440d3:	48 01 d0             	add    %rdx,%rax
   440d6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440dd:	8b 12                	mov    (%rdx),%edx
   440df:	8d 4a 08             	lea    0x8(%rdx),%ecx
   440e2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440e9:	89 0a                	mov    %ecx,(%rdx)
   440eb:	eb 1a                	jmp    44107 <printer_vprintf+0x50a>
   440ed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440f4:	48 8b 40 08          	mov    0x8(%rax),%rax
   440f8:	48 8d 48 08          	lea    0x8(%rax),%rcx
   440fc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44103:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44107:	8b 00                	mov    (%rax),%eax
   44109:	89 c0                	mov    %eax,%eax
   4410b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   4410f:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44113:	e9 03 02 00 00       	jmp    4431b <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   44118:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   4411f:	e9 28 ff ff ff       	jmp    4404c <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   44124:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   4412b:	e9 1c ff ff ff       	jmp    4404c <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44130:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44137:	8b 00                	mov    (%rax),%eax
   44139:	83 f8 2f             	cmp    $0x2f,%eax
   4413c:	77 30                	ja     4416e <printer_vprintf+0x571>
   4413e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44145:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44149:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44150:	8b 00                	mov    (%rax),%eax
   44152:	89 c0                	mov    %eax,%eax
   44154:	48 01 d0             	add    %rdx,%rax
   44157:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4415e:	8b 12                	mov    (%rdx),%edx
   44160:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44163:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4416a:	89 0a                	mov    %ecx,(%rdx)
   4416c:	eb 1a                	jmp    44188 <printer_vprintf+0x58b>
   4416e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44175:	48 8b 40 08          	mov    0x8(%rax),%rax
   44179:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4417d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44184:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44188:	48 8b 00             	mov    (%rax),%rax
   4418b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   4418f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   44196:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   4419d:	e9 79 01 00 00       	jmp    4431b <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   441a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441a9:	8b 00                	mov    (%rax),%eax
   441ab:	83 f8 2f             	cmp    $0x2f,%eax
   441ae:	77 30                	ja     441e0 <printer_vprintf+0x5e3>
   441b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441b7:	48 8b 50 10          	mov    0x10(%rax),%rdx
   441bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441c2:	8b 00                	mov    (%rax),%eax
   441c4:	89 c0                	mov    %eax,%eax
   441c6:	48 01 d0             	add    %rdx,%rax
   441c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441d0:	8b 12                	mov    (%rdx),%edx
   441d2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   441d5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441dc:	89 0a                	mov    %ecx,(%rdx)
   441de:	eb 1a                	jmp    441fa <printer_vprintf+0x5fd>
   441e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441e7:	48 8b 40 08          	mov    0x8(%rax),%rax
   441eb:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441ef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441f6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441fa:	48 8b 00             	mov    (%rax),%rax
   441fd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   44201:	e9 15 01 00 00       	jmp    4431b <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   44206:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4420d:	8b 00                	mov    (%rax),%eax
   4420f:	83 f8 2f             	cmp    $0x2f,%eax
   44212:	77 30                	ja     44244 <printer_vprintf+0x647>
   44214:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4421b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4421f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44226:	8b 00                	mov    (%rax),%eax
   44228:	89 c0                	mov    %eax,%eax
   4422a:	48 01 d0             	add    %rdx,%rax
   4422d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44234:	8b 12                	mov    (%rdx),%edx
   44236:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44239:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44240:	89 0a                	mov    %ecx,(%rdx)
   44242:	eb 1a                	jmp    4425e <printer_vprintf+0x661>
   44244:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4424b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4424f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44253:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4425a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4425e:	8b 00                	mov    (%rax),%eax
   44260:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   44266:	e9 77 03 00 00       	jmp    445e2 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   4426b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4426f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44273:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4427a:	8b 00                	mov    (%rax),%eax
   4427c:	83 f8 2f             	cmp    $0x2f,%eax
   4427f:	77 30                	ja     442b1 <printer_vprintf+0x6b4>
   44281:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44288:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4428c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44293:	8b 00                	mov    (%rax),%eax
   44295:	89 c0                	mov    %eax,%eax
   44297:	48 01 d0             	add    %rdx,%rax
   4429a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442a1:	8b 12                	mov    (%rdx),%edx
   442a3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442a6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442ad:	89 0a                	mov    %ecx,(%rdx)
   442af:	eb 1a                	jmp    442cb <printer_vprintf+0x6ce>
   442b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442b8:	48 8b 40 08          	mov    0x8(%rax),%rax
   442bc:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442c0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442c7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442cb:	8b 00                	mov    (%rax),%eax
   442cd:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   442d0:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   442d4:	eb 45                	jmp    4431b <printer_vprintf+0x71e>
        default:
            data = numbuf;
   442d6:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   442da:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   442de:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   442e5:	0f b6 00             	movzbl (%rax),%eax
   442e8:	84 c0                	test   %al,%al
   442ea:	74 0c                	je     442f8 <printer_vprintf+0x6fb>
   442ec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   442f3:	0f b6 00             	movzbl (%rax),%eax
   442f6:	eb 05                	jmp    442fd <printer_vprintf+0x700>
   442f8:	b8 25 00 00 00       	mov    $0x25,%eax
   442fd:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44300:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   44304:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4430b:	0f b6 00             	movzbl (%rax),%eax
   4430e:	84 c0                	test   %al,%al
   44310:	75 08                	jne    4431a <printer_vprintf+0x71d>
                format--;
   44312:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44319:	01 
            }
            break;
   4431a:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   4431b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4431e:	83 e0 20             	and    $0x20,%eax
   44321:	85 c0                	test   %eax,%eax
   44323:	74 1e                	je     44343 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   44325:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44329:	48 83 c0 18          	add    $0x18,%rax
   4432d:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44330:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44334:	48 89 ce             	mov    %rcx,%rsi
   44337:	48 89 c7             	mov    %rax,%rdi
   4433a:	e8 32 f8 ff ff       	call   43b71 <fill_numbuf>
   4433f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44343:	48 8d 05 3c 10 00 00 	lea    0x103c(%rip),%rax        # 45386 <flag_chars+0x6>
   4434a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   4434e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44351:	83 e0 20             	and    $0x20,%eax
   44354:	85 c0                	test   %eax,%eax
   44356:	74 51                	je     443a9 <printer_vprintf+0x7ac>
   44358:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4435b:	83 e0 40             	and    $0x40,%eax
   4435e:	85 c0                	test   %eax,%eax
   44360:	74 47                	je     443a9 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   44362:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44365:	25 80 00 00 00       	and    $0x80,%eax
   4436a:	85 c0                	test   %eax,%eax
   4436c:	74 0d                	je     4437b <printer_vprintf+0x77e>
                prefix = "-";
   4436e:	48 8d 05 12 10 00 00 	lea    0x1012(%rip),%rax        # 45387 <flag_chars+0x7>
   44375:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44379:	eb 7d                	jmp    443f8 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   4437b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4437e:	83 e0 10             	and    $0x10,%eax
   44381:	85 c0                	test   %eax,%eax
   44383:	74 0d                	je     44392 <printer_vprintf+0x795>
                prefix = "+";
   44385:	48 8d 05 fd 0f 00 00 	lea    0xffd(%rip),%rax        # 45389 <flag_chars+0x9>
   4438c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44390:	eb 66                	jmp    443f8 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44392:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44395:	83 e0 08             	and    $0x8,%eax
   44398:	85 c0                	test   %eax,%eax
   4439a:	74 5c                	je     443f8 <printer_vprintf+0x7fb>
                prefix = " ";
   4439c:	48 8d 05 e8 0f 00 00 	lea    0xfe8(%rip),%rax        # 4538b <flag_chars+0xb>
   443a3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   443a7:	eb 4f                	jmp    443f8 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   443a9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443ac:	83 e0 20             	and    $0x20,%eax
   443af:	85 c0                	test   %eax,%eax
   443b1:	74 46                	je     443f9 <printer_vprintf+0x7fc>
   443b3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443b6:	83 e0 01             	and    $0x1,%eax
   443b9:	85 c0                	test   %eax,%eax
   443bb:	74 3c                	je     443f9 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   443bd:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   443c1:	74 06                	je     443c9 <printer_vprintf+0x7cc>
   443c3:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   443c7:	75 30                	jne    443f9 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   443c9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   443ce:	75 0c                	jne    443dc <printer_vprintf+0x7df>
   443d0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443d3:	25 00 01 00 00       	and    $0x100,%eax
   443d8:	85 c0                	test   %eax,%eax
   443da:	74 1d                	je     443f9 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   443dc:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   443e0:	75 09                	jne    443eb <printer_vprintf+0x7ee>
   443e2:	48 8d 05 a4 0f 00 00 	lea    0xfa4(%rip),%rax        # 4538d <flag_chars+0xd>
   443e9:	eb 07                	jmp    443f2 <printer_vprintf+0x7f5>
   443eb:	48 8d 05 9e 0f 00 00 	lea    0xf9e(%rip),%rax        # 45390 <flag_chars+0x10>
   443f2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   443f6:	eb 01                	jmp    443f9 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   443f8:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   443f9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   443fd:	78 24                	js     44423 <printer_vprintf+0x826>
   443ff:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44402:	83 e0 20             	and    $0x20,%eax
   44405:	85 c0                	test   %eax,%eax
   44407:	75 1a                	jne    44423 <printer_vprintf+0x826>
            len = strnlen(data, precision);
   44409:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4440c:	48 63 d0             	movslq %eax,%rdx
   4440f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44413:	48 89 d6             	mov    %rdx,%rsi
   44416:	48 89 c7             	mov    %rax,%rdi
   44419:	e8 91 f5 ff ff       	call   439af <strnlen>
   4441e:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44421:	eb 0f                	jmp    44432 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   44423:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44427:	48 89 c7             	mov    %rax,%rdi
   4442a:	e8 4b f5 ff ff       	call   4397a <strlen>
   4442f:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44432:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44435:	83 e0 20             	and    $0x20,%eax
   44438:	85 c0                	test   %eax,%eax
   4443a:	74 20                	je     4445c <printer_vprintf+0x85f>
   4443c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44440:	78 1a                	js     4445c <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   44442:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44445:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44448:	7e 08                	jle    44452 <printer_vprintf+0x855>
   4444a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4444d:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44450:	eb 05                	jmp    44457 <printer_vprintf+0x85a>
   44452:	b8 00 00 00 00       	mov    $0x0,%eax
   44457:	89 45 b8             	mov    %eax,-0x48(%rbp)
   4445a:	eb 5c                	jmp    444b8 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   4445c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4445f:	83 e0 20             	and    $0x20,%eax
   44462:	85 c0                	test   %eax,%eax
   44464:	74 4b                	je     444b1 <printer_vprintf+0x8b4>
   44466:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44469:	83 e0 02             	and    $0x2,%eax
   4446c:	85 c0                	test   %eax,%eax
   4446e:	74 41                	je     444b1 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44470:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44473:	83 e0 04             	and    $0x4,%eax
   44476:	85 c0                	test   %eax,%eax
   44478:	75 37                	jne    444b1 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   4447a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4447e:	48 89 c7             	mov    %rax,%rdi
   44481:	e8 f4 f4 ff ff       	call   4397a <strlen>
   44486:	89 c2                	mov    %eax,%edx
   44488:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4448b:	01 d0                	add    %edx,%eax
   4448d:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44490:	7e 1f                	jle    444b1 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   44492:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44495:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44498:	89 c3                	mov    %eax,%ebx
   4449a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4449e:	48 89 c7             	mov    %rax,%rdi
   444a1:	e8 d4 f4 ff ff       	call   4397a <strlen>
   444a6:	89 c2                	mov    %eax,%edx
   444a8:	89 d8                	mov    %ebx,%eax
   444aa:	29 d0                	sub    %edx,%eax
   444ac:	89 45 b8             	mov    %eax,-0x48(%rbp)
   444af:	eb 07                	jmp    444b8 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   444b1:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   444b8:	8b 55 bc             	mov    -0x44(%rbp),%edx
   444bb:	8b 45 b8             	mov    -0x48(%rbp),%eax
   444be:	01 d0                	add    %edx,%eax
   444c0:	48 63 d8             	movslq %eax,%rbx
   444c3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   444c7:	48 89 c7             	mov    %rax,%rdi
   444ca:	e8 ab f4 ff ff       	call   4397a <strlen>
   444cf:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   444d3:	8b 45 e8             	mov    -0x18(%rbp),%eax
   444d6:	29 d0                	sub    %edx,%eax
   444d8:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   444db:	eb 25                	jmp    44502 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   444dd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   444e4:	48 8b 08             	mov    (%rax),%rcx
   444e7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   444ed:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   444f4:	be 20 00 00 00       	mov    $0x20,%esi
   444f9:	48 89 c7             	mov    %rax,%rdi
   444fc:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   444fe:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44502:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44505:	83 e0 04             	and    $0x4,%eax
   44508:	85 c0                	test   %eax,%eax
   4450a:	75 36                	jne    44542 <printer_vprintf+0x945>
   4450c:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44510:	7f cb                	jg     444dd <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   44512:	eb 2e                	jmp    44542 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   44514:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4451b:	4c 8b 00             	mov    (%rax),%r8
   4451e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44522:	0f b6 00             	movzbl (%rax),%eax
   44525:	0f b6 c8             	movzbl %al,%ecx
   44528:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4452e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44535:	89 ce                	mov    %ecx,%esi
   44537:	48 89 c7             	mov    %rax,%rdi
   4453a:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   4453d:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44542:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44546:	0f b6 00             	movzbl (%rax),%eax
   44549:	84 c0                	test   %al,%al
   4454b:	75 c7                	jne    44514 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   4454d:	eb 25                	jmp    44574 <printer_vprintf+0x977>
            p->putc(p, '0', color);
   4454f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44556:	48 8b 08             	mov    (%rax),%rcx
   44559:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4455f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44566:	be 30 00 00 00       	mov    $0x30,%esi
   4456b:	48 89 c7             	mov    %rax,%rdi
   4456e:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44570:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44574:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44578:	7f d5                	jg     4454f <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   4457a:	eb 32                	jmp    445ae <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   4457c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44583:	4c 8b 00             	mov    (%rax),%r8
   44586:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4458a:	0f b6 00             	movzbl (%rax),%eax
   4458d:	0f b6 c8             	movzbl %al,%ecx
   44590:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44596:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4459d:	89 ce                	mov    %ecx,%esi
   4459f:	48 89 c7             	mov    %rax,%rdi
   445a2:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   445a5:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   445aa:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   445ae:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   445b2:	7f c8                	jg     4457c <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   445b4:	eb 25                	jmp    445db <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   445b6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   445bd:	48 8b 08             	mov    (%rax),%rcx
   445c0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   445c6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   445cd:	be 20 00 00 00       	mov    $0x20,%esi
   445d2:	48 89 c7             	mov    %rax,%rdi
   445d5:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   445d7:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   445db:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   445df:	7f d5                	jg     445b6 <printer_vprintf+0x9b9>
        }
    done: ;
   445e1:	90                   	nop
    for (; *format; ++format) {
   445e2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   445e9:	01 
   445ea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   445f1:	0f b6 00             	movzbl (%rax),%eax
   445f4:	84 c0                	test   %al,%al
   445f6:	0f 85 31 f6 ff ff    	jne    43c2d <printer_vprintf+0x30>
    }
}
   445fc:	90                   	nop
   445fd:	90                   	nop
   445fe:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44602:	c9                   	leave  
   44603:	c3                   	ret    

0000000000044604 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   44604:	f3 0f 1e fa          	endbr64 
   44608:	55                   	push   %rbp
   44609:	48 89 e5             	mov    %rsp,%rbp
   4460c:	48 83 ec 20          	sub    $0x20,%rsp
   44610:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44614:	89 f0                	mov    %esi,%eax
   44616:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44619:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   4461c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44620:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44624:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44628:	48 8b 40 08          	mov    0x8(%rax),%rax
   4462c:	48 8d 15 6d 49 07 00 	lea    0x7496d(%rip),%rdx        # b8fa0 <console+0xfa0>
   44633:	48 39 d0             	cmp    %rdx,%rax
   44636:	72 0f                	jb     44647 <console_putc+0x43>
        cp->cursor = console;
   44638:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4463c:	48 8d 15 bd 39 07 00 	lea    0x739bd(%rip),%rdx        # b8000 <console>
   44643:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   44647:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   4464b:	0f 85 82 00 00 00    	jne    446d3 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   44651:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44655:	48 8b 40 08          	mov    0x8(%rax),%rax
   44659:	48 8d 15 a0 39 07 00 	lea    0x739a0(%rip),%rdx        # b8000 <console>
   44660:	48 29 d0             	sub    %rdx,%rax
   44663:	48 d1 f8             	sar    %rax
   44666:	48 89 c1             	mov    %rax,%rcx
   44669:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44670:	66 66 66 
   44673:	48 89 c8             	mov    %rcx,%rax
   44676:	48 f7 ea             	imul   %rdx
   44679:	48 89 d0             	mov    %rdx,%rax
   4467c:	48 c1 f8 05          	sar    $0x5,%rax
   44680:	48 89 ce             	mov    %rcx,%rsi
   44683:	48 c1 fe 3f          	sar    $0x3f,%rsi
   44687:	48 29 f0             	sub    %rsi,%rax
   4468a:	48 89 c2             	mov    %rax,%rdx
   4468d:	48 89 d0             	mov    %rdx,%rax
   44690:	48 c1 e0 02          	shl    $0x2,%rax
   44694:	48 01 d0             	add    %rdx,%rax
   44697:	48 c1 e0 04          	shl    $0x4,%rax
   4469b:	48 29 c1             	sub    %rax,%rcx
   4469e:	48 89 ca             	mov    %rcx,%rdx
   446a1:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   446a4:	eb 25                	jmp    446cb <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   446a6:	8b 45 e0             	mov    -0x20(%rbp),%eax
   446a9:	83 c8 20             	or     $0x20,%eax
   446ac:	89 c6                	mov    %eax,%esi
   446ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   446b2:	48 8b 40 08          	mov    0x8(%rax),%rax
   446b6:	48 8d 48 02          	lea    0x2(%rax),%rcx
   446ba:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   446be:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   446c2:	89 f2                	mov    %esi,%edx
   446c4:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   446c7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   446cb:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   446cf:	75 d5                	jne    446a6 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   446d1:	eb 24                	jmp    446f7 <console_putc+0xf3>
        *cp->cursor++ = c | color;
   446d3:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   446d7:	8b 45 e0             	mov    -0x20(%rbp),%eax
   446da:	89 d6                	mov    %edx,%esi
   446dc:	09 c6                	or     %eax,%esi
   446de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   446e2:	48 8b 40 08          	mov    0x8(%rax),%rax
   446e6:	48 8d 48 02          	lea    0x2(%rax),%rcx
   446ea:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   446ee:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   446f2:	89 f2                	mov    %esi,%edx
   446f4:	66 89 10             	mov    %dx,(%rax)
}
   446f7:	90                   	nop
   446f8:	c9                   	leave  
   446f9:	c3                   	ret    

00000000000446fa <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   446fa:	f3 0f 1e fa          	endbr64 
   446fe:	55                   	push   %rbp
   446ff:	48 89 e5             	mov    %rsp,%rbp
   44702:	48 83 ec 30          	sub    $0x30,%rsp
   44706:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44709:	89 75 e8             	mov    %esi,-0x18(%rbp)
   4470c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44710:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44714:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 44604 <console_putc>
   4471b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4471f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44723:	78 09                	js     4472e <console_vprintf+0x34>
   44725:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   4472c:	7e 07                	jle    44735 <console_vprintf+0x3b>
        cpos = 0;
   4472e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44735:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44738:	48 98                	cltq   
   4473a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4473e:	48 8d 05 bb 38 07 00 	lea    0x738bb(%rip),%rax        # b8000 <console>
   44745:	48 01 d0             	add    %rdx,%rax
   44748:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   4474c:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44750:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44754:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44757:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   4475b:	48 89 c7             	mov    %rax,%rdi
   4475e:	e8 9a f4 ff ff       	call   43bfd <printer_vprintf>
    return cp.cursor - console;
   44763:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44767:	48 8d 15 92 38 07 00 	lea    0x73892(%rip),%rdx        # b8000 <console>
   4476e:	48 29 d0             	sub    %rdx,%rax
   44771:	48 d1 f8             	sar    %rax
}
   44774:	c9                   	leave  
   44775:	c3                   	ret    

0000000000044776 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44776:	f3 0f 1e fa          	endbr64 
   4477a:	55                   	push   %rbp
   4477b:	48 89 e5             	mov    %rsp,%rbp
   4477e:	48 83 ec 60          	sub    $0x60,%rsp
   44782:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44785:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44788:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   4478c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44790:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44794:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44798:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4479f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   447a3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   447a7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   447ab:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   447af:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   447b3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   447b7:	8b 75 a8             	mov    -0x58(%rbp),%esi
   447ba:	8b 45 ac             	mov    -0x54(%rbp),%eax
   447bd:	89 c7                	mov    %eax,%edi
   447bf:	e8 36 ff ff ff       	call   446fa <console_vprintf>
   447c4:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   447c7:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   447ca:	c9                   	leave  
   447cb:	c3                   	ret    

00000000000447cc <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   447cc:	f3 0f 1e fa          	endbr64 
   447d0:	55                   	push   %rbp
   447d1:	48 89 e5             	mov    %rsp,%rbp
   447d4:	48 83 ec 20          	sub    $0x20,%rsp
   447d8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   447dc:	89 f0                	mov    %esi,%eax
   447de:	89 55 e0             	mov    %edx,-0x20(%rbp)
   447e1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   447e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   447e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   447ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   447f0:	48 8b 50 08          	mov    0x8(%rax),%rdx
   447f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   447f8:	48 8b 40 10          	mov    0x10(%rax),%rax
   447fc:	48 39 c2             	cmp    %rax,%rdx
   447ff:	73 1a                	jae    4481b <string_putc+0x4f>
        *sp->s++ = c;
   44801:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44805:	48 8b 40 08          	mov    0x8(%rax),%rax
   44809:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4480d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44811:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44815:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44819:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   4481b:	90                   	nop
   4481c:	c9                   	leave  
   4481d:	c3                   	ret    

000000000004481e <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   4481e:	f3 0f 1e fa          	endbr64 
   44822:	55                   	push   %rbp
   44823:	48 89 e5             	mov    %rsp,%rbp
   44826:	48 83 ec 40          	sub    $0x40,%rsp
   4482a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4482e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44832:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44836:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   4483a:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 447cc <string_putc>
   44841:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   44845:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44849:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   4484d:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44852:	74 33                	je     44887 <vsnprintf+0x69>
        sp.end = s + size - 1;
   44854:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44858:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4485c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44860:	48 01 d0             	add    %rdx,%rax
   44863:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44867:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   4486b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4486f:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44873:	be 00 00 00 00       	mov    $0x0,%esi
   44878:	48 89 c7             	mov    %rax,%rdi
   4487b:	e8 7d f3 ff ff       	call   43bfd <printer_vprintf>
        *sp.s = 0;
   44880:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44884:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44887:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4488b:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   4488f:	c9                   	leave  
   44890:	c3                   	ret    

0000000000044891 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44891:	f3 0f 1e fa          	endbr64 
   44895:	55                   	push   %rbp
   44896:	48 89 e5             	mov    %rsp,%rbp
   44899:	48 83 ec 70          	sub    $0x70,%rsp
   4489d:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   448a1:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   448a5:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   448a9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   448ad:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   448b1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   448b5:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   448bc:	48 8d 45 10          	lea    0x10(%rbp),%rax
   448c0:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   448c4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   448c8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   448cc:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   448d0:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   448d4:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   448d8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   448dc:	48 89 c7             	mov    %rax,%rdi
   448df:	e8 3a ff ff ff       	call   4481e <vsnprintf>
   448e4:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   448e7:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   448ea:	c9                   	leave  
   448eb:	c3                   	ret    

00000000000448ec <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   448ec:	f3 0f 1e fa          	endbr64 
   448f0:	55                   	push   %rbp
   448f1:	48 89 e5             	mov    %rsp,%rbp
   448f4:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   448f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   448ff:	eb 1a                	jmp    4491b <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   44901:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44904:	48 98                	cltq   
   44906:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4490a:	48 8d 05 ef 36 07 00 	lea    0x736ef(%rip),%rax        # b8000 <console>
   44911:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44917:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4491b:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44922:	7e dd                	jle    44901 <console_clear+0x15>
    }
    cursorpos = 0;
   44924:	c7 05 ce 46 07 00 00 	movl   $0x0,0x746ce(%rip)        # b8ffc <cursorpos>
   4492b:	00 00 00 
}
   4492e:	90                   	nop
   4492f:	c9                   	leave  
   44930:	c3                   	ret    
