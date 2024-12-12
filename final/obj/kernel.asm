
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
   400be:	e8 9d 05 00 00       	call   40660 <exception>

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

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	f3 0f 1e fa          	endbr64 
   4016b:	55                   	push   %rbp
   4016c:	48 89 e5             	mov    %rsp,%rbp
   4016f:	48 83 ec 20          	sub    $0x20,%rsp
   40173:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40177:	e8 6e 14 00 00       	call   415ea <hardware_init>
    pageinfo_init();
   4017c:	e8 79 09 00 00       	call   40afa <pageinfo_init>
    console_clear();
   40181:	e8 a3 4c 00 00       	call   44e29 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 c2 19 00 00       	call   41b52 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 5f de 00 00 	lea    0xde5f(%rip),%rax        # 4e000 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 cb 3c 00 00       	call   43e74 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401b0:	eb 4d                	jmp    401ff <kernel+0x98>
        processes[i].p_pid = i;
   401b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401b5:	48 63 d0             	movslq %eax,%rdx
   401b8:	48 89 d0             	mov    %rdx,%rax
   401bb:	48 c1 e0 04          	shl    $0x4,%rax
   401bf:	48 29 d0             	sub    %rdx,%rax
   401c2:	48 c1 e0 04          	shl    $0x4,%rax
   401c6:	48 89 c1             	mov    %rax,%rcx
   401c9:	48 8d 15 30 de 00 00 	lea    0xde30(%rip),%rdx        # 4e000 <processes>
   401d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401d3:	89 04 11             	mov    %eax,(%rcx,%rdx,1)
        processes[i].p_state = P_FREE;
   401d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401d9:	48 63 d0             	movslq %eax,%rdx
   401dc:	48 89 d0             	mov    %rdx,%rax
   401df:	48 c1 e0 04          	shl    $0x4,%rax
   401e3:	48 29 d0             	sub    %rdx,%rax
   401e6:	48 c1 e0 04          	shl    $0x4,%rax
   401ea:	48 89 c2             	mov    %rax,%rdx
   401ed:	48 8d 05 e4 de 00 00 	lea    0xdee4(%rip),%rax        # 4e0d8 <processes+0xd8>
   401f4:	c7 04 02 00 00 00 00 	movl   $0x0,(%rdx,%rax,1)
    for (pid_t i = 0; i < NPROC; i++) {
   401fb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ff:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40203:	7e ad                	jle    401b2 <kernel+0x4b>
    }

    if (command && strcmp(command, "malloc") == 0) {
   40205:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4020a:	74 2e                	je     4023a <kernel+0xd3>
   4020c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40210:	48 8d 15 8f 4c 00 00 	lea    0x4c8f(%rip),%rdx        # 44ea6 <memstate_colors+0x26>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 5b 3d 00 00       	call   43f7d <strcmp>
   40222:	85 c0                	test   %eax,%eax
   40224:	75 14                	jne    4023a <kernel+0xd3>
        process_setup(1, 1);
   40226:	be 01 00 00 00       	mov    $0x1,%esi
   4022b:	bf 01 00 00 00       	mov    $0x1,%edi
   40230:	e8 cf 00 00 00       	call   40304 <process_setup>
   40235:	e9 bb 00 00 00       	jmp    402f5 <kernel+0x18e>
    } else if (command && strcmp(command, "alloctests") == 0) {
   4023a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4023f:	74 2e                	je     4026f <kernel+0x108>
   40241:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40245:	48 8d 15 61 4c 00 00 	lea    0x4c61(%rip),%rdx        # 44ead <memstate_colors+0x2d>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 26 3d 00 00       	call   43f7d <strcmp>
   40257:	85 c0                	test   %eax,%eax
   40259:	75 14                	jne    4026f <kernel+0x108>
        process_setup(1, 2);
   4025b:	be 02 00 00 00       	mov    $0x2,%esi
   40260:	bf 01 00 00 00       	mov    $0x1,%edi
   40265:	e8 9a 00 00 00       	call   40304 <process_setup>
   4026a:	e9 86 00 00 00       	jmp    402f5 <kernel+0x18e>
    } else if (command && strcmp(command, "test") == 0){
   4026f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40274:	74 2b                	je     402a1 <kernel+0x13a>
   40276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4027a:	48 8d 15 37 4c 00 00 	lea    0x4c37(%rip),%rdx        # 44eb8 <memstate_colors+0x38>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 f1 3c 00 00       	call   43f7d <strcmp>
   4028c:	85 c0                	test   %eax,%eax
   4028e:	75 11                	jne    402a1 <kernel+0x13a>
        process_setup(1, 3);
   40290:	be 03 00 00 00       	mov    $0x3,%esi
   40295:	bf 01 00 00 00       	mov    $0x1,%edi
   4029a:	e8 65 00 00 00       	call   40304 <process_setup>
   4029f:	eb 54                	jmp    402f5 <kernel+0x18e>
    } else if (command && strcmp(command, "test2") == 0) {
   402a1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a6:	74 3e                	je     402e6 <kernel+0x17f>
   402a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402ac:	48 8d 15 0a 4c 00 00 	lea    0x4c0a(%rip),%rdx        # 44ebd <memstate_colors+0x3d>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 bf 3c 00 00       	call   43f7d <strcmp>
   402be:	85 c0                	test   %eax,%eax
   402c0:	75 24                	jne    402e6 <kernel+0x17f>
        for (pid_t i = 1; i <= 2; ++i) {
   402c2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402c9:	eb 13                	jmp    402de <kernel+0x177>
            process_setup(i, 3);
   402cb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402ce:	be 03 00 00 00       	mov    $0x3,%esi
   402d3:	89 c7                	mov    %eax,%edi
   402d5:	e8 2a 00 00 00       	call   40304 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402da:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402de:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402e2:	7e e7                	jle    402cb <kernel+0x164>
   402e4:	eb 0f                	jmp    402f5 <kernel+0x18e>
        }
    } else {
        process_setup(1, 0);
   402e6:	be 00 00 00 00       	mov    $0x0,%esi
   402eb:	bf 01 00 00 00       	mov    $0x1,%edi
   402f0:	e8 0f 00 00 00       	call   40304 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   402f5:	48 8d 05 f4 dd 00 00 	lea    0xddf4(%rip),%rax        # 4e0f0 <processes+0xf0>
   402fc:	48 89 c7             	mov    %rax,%rdi
   402ff:	e8 4e 07 00 00       	call   40a52 <run>

0000000000040304 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   40304:	f3 0f 1e fa          	endbr64 
   40308:	55                   	push   %rbp
   40309:	48 89 e5             	mov    %rsp,%rbp
   4030c:	48 83 ec 10          	sub    $0x10,%rsp
   40310:	89 7d fc             	mov    %edi,-0x4(%rbp)
   40313:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   40316:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40319:	48 63 d0             	movslq %eax,%rdx
   4031c:	48 89 d0             	mov    %rdx,%rax
   4031f:	48 c1 e0 04          	shl    $0x4,%rax
   40323:	48 29 d0             	sub    %rdx,%rax
   40326:	48 c1 e0 04          	shl    $0x4,%rax
   4032a:	48 8d 15 cf dc 00 00 	lea    0xdccf(%rip),%rdx        # 4e000 <processes>
   40331:	48 01 d0             	add    %rdx,%rax
   40334:	be 00 00 00 00       	mov    $0x0,%esi
   40339:	48 89 c7             	mov    %rax,%rdi
   4033c:	e8 c4 1a 00 00       	call   41e05 <process_init>
    assert(process_config_tables(pid) == 0);
   40341:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40344:	89 c7                	mov    %eax,%edi
   40346:	e8 ea 32 00 00       	call   43635 <process_config_tables>
   4034b:	85 c0                	test   %eax,%eax
   4034d:	74 1e                	je     4036d <process_setup+0x69>
   4034f:	48 8d 05 72 4b 00 00 	lea    0x4b72(%rip),%rax        # 44ec8 <memstate_colors+0x48>
   40356:	48 89 c2             	mov    %rax,%rdx
   40359:	be 77 00 00 00       	mov    $0x77,%esi
   4035e:	48 8d 05 83 4b 00 00 	lea    0x4b83(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   40365:	48 89 c7             	mov    %rax,%rdi
   40368:	e8 ce 22 00 00       	call   4263b <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 8d 15 78 dc 00 00 	lea    0xdc78(%rip),%rdx        # 4e000 <processes>
   40388:	48 01 c2             	add    %rax,%rdx
   4038b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4038e:	89 c6                	mov    %eax,%esi
   40390:	48 89 d7             	mov    %rdx,%rdi
   40393:	e8 eb 35 00 00       	call   43983 <process_load>
   40398:	85 c0                	test   %eax,%eax
   4039a:	79 1e                	jns    403ba <process_setup+0xb6>
   4039c:	48 8d 05 55 4b 00 00 	lea    0x4b55(%rip),%rax        # 44ef8 <memstate_colors+0x78>
   403a3:	48 89 c2             	mov    %rax,%rdx
   403a6:	be 7a 00 00 00       	mov    $0x7a,%esi
   403ab:	48 8d 05 36 4b 00 00 	lea    0x4b36(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   403b2:	48 89 c7             	mov    %rax,%rdi
   403b5:	e8 81 22 00 00       	call   4263b <assert_fail>

    process_setup_stack(&processes[pid]);
   403ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403bd:	48 63 d0             	movslq %eax,%rdx
   403c0:	48 89 d0             	mov    %rdx,%rax
   403c3:	48 c1 e0 04          	shl    $0x4,%rax
   403c7:	48 29 d0             	sub    %rdx,%rax
   403ca:	48 c1 e0 04          	shl    $0x4,%rax
   403ce:	48 8d 15 2b dc 00 00 	lea    0xdc2b(%rip),%rdx        # 4e000 <processes>
   403d5:	48 01 d0             	add    %rdx,%rax
   403d8:	48 89 c7             	mov    %rax,%rdi
   403db:	e8 db 35 00 00       	call   439bb <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   403e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403e3:	48 63 d0             	movslq %eax,%rdx
   403e6:	48 89 d0             	mov    %rdx,%rax
   403e9:	48 c1 e0 04          	shl    $0x4,%rax
   403ed:	48 29 d0             	sub    %rdx,%rax
   403f0:	48 c1 e0 04          	shl    $0x4,%rax
   403f4:	48 89 c2             	mov    %rax,%rdx
   403f7:	48 8d 05 da dc 00 00 	lea    0xdcda(%rip),%rax        # 4e0d8 <processes+0xd8>
   403fe:	c7 04 02 01 00 00 00 	movl   $0x1,(%rdx,%rax,1)
}
   40405:	90                   	nop
   40406:	c9                   	leave  
   40407:	c3                   	ret    

0000000000040408 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40408:	f3 0f 1e fa          	endbr64 
   4040c:	55                   	push   %rbp
   4040d:	48 89 e5             	mov    %rsp,%rbp
   40410:	48 83 ec 10          	sub    $0x10,%rsp
   40414:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40418:	89 f0                	mov    %esi,%eax
   4041a:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   4041d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40421:	25 ff 0f 00 00       	and    $0xfff,%eax
   40426:	48 85 c0             	test   %rax,%rax
   40429:	75 27                	jne    40452 <assign_physical_page+0x4a>
        || addr >= MEMSIZE_PHYSICAL
   4042b:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40432:	00 
   40433:	77 1d                	ja     40452 <assign_physical_page+0x4a>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40435:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40439:	48 c1 e8 0c          	shr    $0xc,%rax
   4043d:	48 98                	cltq   
   4043f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40443:	48 8d 05 d7 ea 00 00 	lea    0xead7(%rip),%rax        # 4ef21 <pageinfo+0x1>
   4044a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4044e:	84 c0                	test   %al,%al
   40450:	74 07                	je     40459 <assign_physical_page+0x51>
        return -1;
   40452:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40457:	eb 3a                	jmp    40493 <assign_physical_page+0x8b>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   40459:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4045d:	48 c1 e8 0c          	shr    $0xc,%rax
   40461:	48 98                	cltq   
   40463:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40467:	48 8d 05 b3 ea 00 00 	lea    0xeab3(%rip),%rax        # 4ef21 <pageinfo+0x1>
   4046e:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40472:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40476:	48 c1 e8 0c          	shr    $0xc,%rax
   4047a:	48 98                	cltq   
   4047c:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40480:	48 8d 15 99 ea 00 00 	lea    0xea99(%rip),%rdx        # 4ef20 <pageinfo>
   40487:	0f b6 45 f4          	movzbl -0xc(%rbp),%eax
   4048b:	88 04 11             	mov    %al,(%rcx,%rdx,1)
        return 0;
   4048e:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40493:	c9                   	leave  
   40494:	c3                   	ret    

0000000000040495 <syscall_fork>:

pid_t syscall_fork() {
   40495:	f3 0f 1e fa          	endbr64 
   40499:	55                   	push   %rbp
   4049a:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   4049d:	48 8b 05 5c ea 00 00 	mov    0xea5c(%rip),%rax        # 4ef00 <current>
   404a4:	48 89 c7             	mov    %rax,%rdi
   404a7:	e8 c2 35 00 00       	call   43a6e <process_fork>
}
   404ac:	5d                   	pop    %rbp
   404ad:	c3                   	ret    

00000000000404ae <syscall_exit>:


void syscall_exit() {
   404ae:	f3 0f 1e fa          	endbr64 
   404b2:	55                   	push   %rbp
   404b3:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   404b6:	48 8b 05 43 ea 00 00 	mov    0xea43(%rip),%rax        # 4ef00 <current>
   404bd:	8b 00                	mov    (%rax),%eax
   404bf:	89 c7                	mov    %eax,%edi
   404c1:	e8 8d 2e 00 00       	call   43353 <process_free>
}
   404c6:	90                   	nop
   404c7:	5d                   	pop    %rbp
   404c8:	c3                   	ret    

00000000000404c9 <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   404c9:	f3 0f 1e fa          	endbr64 
   404cd:	55                   	push   %rbp
   404ce:	48 89 e5             	mov    %rsp,%rbp
   404d1:	48 83 ec 10          	sub    $0x10,%rsp
   404d5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   404d9:	48 8b 05 20 ea 00 00 	mov    0xea20(%rip),%rax        # 4ef00 <current>
   404e0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   404e4:	48 89 d6             	mov    %rdx,%rsi
   404e7:	48 89 c7             	mov    %rax,%rdi
   404ea:	e8 11 38 00 00       	call   43d00 <process_page_alloc>
}
   404ef:	c9                   	leave  
   404f0:	c3                   	ret    

00000000000404f1 <sbrk>:


int sbrk(proc * p, intptr_t difference) {
   404f1:	f3 0f 1e fa          	endbr64 
   404f5:	55                   	push   %rbp
   404f6:	48 89 e5             	mov    %rsp,%rbp
   404f9:	48 83 ec 10          	sub    $0x10,%rsp
   404fd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40501:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    // TODO : Your code here
    return 0;
   40505:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4050a:	c9                   	leave  
   4050b:	c3                   	ret    

000000000004050c <syscall_mapping>:


void syscall_mapping(proc* p){
   4050c:	f3 0f 1e fa          	endbr64 
   40510:	55                   	push   %rbp
   40511:	48 89 e5             	mov    %rsp,%rbp
   40514:	48 83 ec 70          	sub    $0x70,%rsp
   40518:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   4051c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40520:	48 8b 40 48          	mov    0x48(%rax),%rax
   40524:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40528:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4052c:	48 8b 40 40          	mov    0x40(%rax),%rax
   40530:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40534:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40538:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4053f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40543:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40547:	48 89 ce             	mov    %rcx,%rsi
   4054a:	48 89 c7             	mov    %rax,%rdi
   4054d:	e8 b9 28 00 00       	call   42e0b <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   40552:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40555:	48 98                	cltq   
   40557:	83 e0 06             	and    $0x6,%eax
   4055a:	48 83 f8 06          	cmp    $0x6,%rax
   4055e:	0f 85 89 00 00 00    	jne    405ed <syscall_mapping+0xe1>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   40564:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40568:	48 83 c0 17          	add    $0x17,%rax
   4056c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (PAGENUMBER(endaddr) != PAGENUMBER(ptr)){
   40570:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40574:	48 c1 e8 0c          	shr    $0xc,%rax
   40578:	89 c2                	mov    %eax,%edx
   4057a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4057e:	48 c1 e8 0c          	shr    $0xc,%rax
   40582:	39 c2                	cmp    %eax,%edx
   40584:	74 2c                	je     405b2 <syscall_mapping+0xa6>
        vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40586:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4058a:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40591:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40595:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40599:	48 89 ce             	mov    %rcx,%rsi
   4059c:	48 89 c7             	mov    %rax,%rdi
   4059f:	e8 67 28 00 00       	call   42e0b <virtual_memory_lookup>
        // check for write access for end address
        if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   405a4:	8b 45 b0             	mov    -0x50(%rbp),%eax
   405a7:	48 98                	cltq   
   405a9:	83 e0 03             	and    $0x3,%eax
   405ac:	48 83 f8 03          	cmp    $0x3,%rax
   405b0:	75 3e                	jne    405f0 <syscall_mapping+0xe4>
            return; 
    }
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   405b2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405b6:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   405bd:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   405c1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   405c5:	48 89 ce             	mov    %rcx,%rsi
   405c8:	48 89 c7             	mov    %rax,%rdi
   405cb:	e8 3b 28 00 00       	call   42e0b <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   405d0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   405d4:	48 89 c1             	mov    %rax,%rcx
   405d7:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   405db:	ba 18 00 00 00       	mov    $0x18,%edx
   405e0:	48 89 c6             	mov    %rax,%rsi
   405e3:	48 89 cf             	mov    %rcx,%rdi
   405e6:	e8 83 37 00 00       	call   43d6e <memcpy>
   405eb:	eb 04                	jmp    405f1 <syscall_mapping+0xe5>
        return;
   405ed:	90                   	nop
   405ee:	eb 01                	jmp    405f1 <syscall_mapping+0xe5>
            return; 
   405f0:	90                   	nop
}
   405f1:	c9                   	leave  
   405f2:	c3                   	ret    

00000000000405f3 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   405f3:	f3 0f 1e fa          	endbr64 
   405f7:	55                   	push   %rbp
   405f8:	48 89 e5             	mov    %rsp,%rbp
   405fb:	48 83 ec 18          	sub    $0x18,%rsp
   405ff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40603:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40607:	48 8b 40 48          	mov    0x48(%rax),%rax
   4060b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   4060e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40612:	75 14                	jne    40628 <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   40614:	0f b6 05 e5 59 00 00 	movzbl 0x59e5(%rip),%eax        # 46000 <disp_global>
   4061b:	84 c0                	test   %al,%al
   4061d:	0f 94 c0             	sete   %al
   40620:	88 05 da 59 00 00    	mov    %al,0x59da(%rip)        # 46000 <disp_global>
   40626:	eb 36                	jmp    4065e <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40628:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4062c:	78 2f                	js     4065d <syscall_mem_tog+0x6a>
   4062e:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40632:	7f 29                	jg     4065d <syscall_mem_tog+0x6a>
   40634:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40638:	8b 00                	mov    (%rax),%eax
   4063a:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4063d:	75 1e                	jne    4065d <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   4063f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40643:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   4064a:	84 c0                	test   %al,%al
   4064c:	0f 94 c0             	sete   %al
   4064f:	89 c2                	mov    %eax,%edx
   40651:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40655:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   4065b:	eb 01                	jmp    4065e <syscall_mem_tog+0x6b>
            return;
   4065d:	90                   	nop
    }
}
   4065e:	c9                   	leave  
   4065f:	c3                   	ret    

0000000000040660 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40660:	f3 0f 1e fa          	endbr64 
   40664:	55                   	push   %rbp
   40665:	48 89 e5             	mov    %rsp,%rbp
   40668:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   4066f:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40676:	48 8b 05 83 e8 00 00 	mov    0xe883(%rip),%rax        # 4ef00 <current>
   4067d:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   40684:	48 83 c0 18          	add    $0x18,%rax
   40688:	48 89 d6             	mov    %rdx,%rsi
   4068b:	ba 18 00 00 00       	mov    $0x18,%edx
   40690:	48 89 c7             	mov    %rax,%rdi
   40693:	48 89 d1             	mov    %rdx,%rcx
   40696:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40699:	48 8b 05 60 09 01 00 	mov    0x10960(%rip),%rax        # 51000 <kernel_pagetable>
   406a0:	48 89 c7             	mov    %rax,%rdi
   406a3:	e8 a5 21 00 00       	call   4284d <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   406a8:	8b 05 4e 89 07 00    	mov    0x7894e(%rip),%eax        # b8ffc <cursorpos>
   406ae:	89 c7                	mov    %eax,%edi
   406b0:	e8 1e 18 00 00       	call   41ed3 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   406b5:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   406bc:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406c3:	48 83 f8 0e          	cmp    $0xe,%rax
   406c7:	74 14                	je     406dd <exception+0x7d>
	    && reg->reg_intno != INT_GPF)
   406c9:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   406d0:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406d7:	48 83 f8 0d          	cmp    $0xd,%rax
   406db:	75 16                	jne    406f3 <exception+0x93>
            || (reg->reg_err & PFERR_USER)) {
   406dd:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   406e4:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   406eb:	83 e0 04             	and    $0x4,%eax
   406ee:	48 85 c0             	test   %rax,%rax
   406f1:	74 1a                	je     4070d <exception+0xad>
        check_virtual_memory();
   406f3:	e8 2c 08 00 00       	call   40f24 <check_virtual_memory>
        if(disp_global){
   406f8:	0f b6 05 01 59 00 00 	movzbl 0x5901(%rip),%eax        # 46000 <disp_global>
   406ff:	84 c0                	test   %al,%al
   40701:	74 0a                	je     4070d <exception+0xad>
            memshow_physical();
   40703:	e8 e5 09 00 00       	call   410ed <memshow_physical>
            memshow_virtual_animate();
   40708:	e8 82 0d 00 00       	call   4148f <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   4070d:	e8 d7 1c 00 00       	call   423e9 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40712:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40719:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40720:	48 83 e8 0e          	sub    $0xe,%rax
   40724:	48 83 f8 2c          	cmp    $0x2c,%rax
   40728:	0f 87 6a 02 00 00    	ja     40998 <exception+0x338>
   4072e:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   40735:	00 
   40736:	48 8d 05 7b 48 00 00 	lea    0x487b(%rip),%rax        # 44fb8 <memstate_colors+0x138>
   4073d:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40740:	48 98                	cltq   
   40742:	48 8d 15 6f 48 00 00 	lea    0x486f(%rip),%rdx        # 44fb8 <memstate_colors+0x138>
   40749:	48 01 d0             	add    %rdx,%rax
   4074c:	3e ff e0             	notrack jmp *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   4074f:	48 8b 05 aa e7 00 00 	mov    0xe7aa(%rip),%rax        # 4ef00 <current>
   40756:	48 8b 40 48          	mov    0x48(%rax),%rax
   4075a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                    if((void *)addr == NULL)
   4075e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   40763:	75 0f                	jne    40774 <exception+0x114>
                        kernel_panic(NULL);
   40765:	bf 00 00 00 00       	mov    $0x0,%edi
   4076a:	b8 00 00 00 00       	mov    $0x0,%eax
   4076f:	e8 d7 1d 00 00       	call   4254b <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40774:	48 8b 05 85 e7 00 00 	mov    0xe785(%rip),%rax        # 4ef00 <current>
   4077b:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40782:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40786:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4078a:	48 89 ce             	mov    %rcx,%rsi
   4078d:	48 89 c7             	mov    %rax,%rdi
   40790:	e8 76 26 00 00       	call   42e0b <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   40795:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40799:	48 89 c1             	mov    %rax,%rcx
   4079c:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
   407a3:	ba a0 00 00 00       	mov    $0xa0,%edx
   407a8:	48 89 ce             	mov    %rcx,%rsi
   407ab:	48 89 c7             	mov    %rax,%rdi
   407ae:	e8 bb 35 00 00       	call   43d6e <memcpy>
                    kernel_panic(msg);
   407b3:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
   407ba:	48 89 c7             	mov    %rax,%rdi
   407bd:	b8 00 00 00 00       	mov    $0x0,%eax
   407c2:	e8 84 1d 00 00       	call   4254b <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   407c7:	48 8b 05 32 e7 00 00 	mov    0xe732(%rip),%rax        # 4ef00 <current>
   407ce:	8b 10                	mov    (%rax),%edx
   407d0:	48 8b 05 29 e7 00 00 	mov    0xe729(%rip),%rax        # 4ef00 <current>
   407d7:	48 63 d2             	movslq %edx,%rdx
   407da:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   407de:	e9 c7 01 00 00       	jmp    409aa <exception+0x34a>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   407e3:	b8 00 00 00 00       	mov    $0x0,%eax
   407e8:	e8 a8 fc ff ff       	call   40495 <syscall_fork>
   407ed:	89 c2                	mov    %eax,%edx
   407ef:	48 8b 05 0a e7 00 00 	mov    0xe70a(%rip),%rax        # 4ef00 <current>
   407f6:	48 63 d2             	movslq %edx,%rdx
   407f9:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   407fd:	e9 a8 01 00 00       	jmp    409aa <exception+0x34a>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   40802:	48 8b 05 f7 e6 00 00 	mov    0xe6f7(%rip),%rax        # 4ef00 <current>
   40809:	48 89 c7             	mov    %rax,%rdi
   4080c:	e8 fb fc ff ff       	call   4050c <syscall_mapping>
                break;
   40811:	e9 94 01 00 00       	jmp    409aa <exception+0x34a>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   40816:	b8 00 00 00 00       	mov    $0x0,%eax
   4081b:	e8 8e fc ff ff       	call   404ae <syscall_exit>
                schedule();
   40820:	e8 ae 01 00 00       	call   409d3 <schedule>
                break;
   40825:	e9 80 01 00 00       	jmp    409aa <exception+0x34a>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   4082a:	e8 a4 01 00 00       	call   409d3 <schedule>
                break;                  /* will not be reached */
   4082f:	e9 76 01 00 00       	jmp    409aa <exception+0x34a>
                // TODO : Your code here
                break;
            }
	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   40834:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4083b:	48 8b 40 30          	mov    0x30(%rax),%rax
   4083f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		syscall_page_alloc(addr);
   40843:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40847:	48 89 c7             	mov    %rax,%rdi
   4084a:	e8 7a fc ff ff       	call   404c9 <syscall_page_alloc>
		break;
   4084f:	e9 56 01 00 00       	jmp    409aa <exception+0x34a>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40854:	48 8b 05 a5 e6 00 00 	mov    0xe6a5(%rip),%rax        # 4ef00 <current>
   4085b:	48 89 c7             	mov    %rax,%rdi
   4085e:	e8 90 fd ff ff       	call   405f3 <syscall_mem_tog>
                break;
   40863:	e9 42 01 00 00       	jmp    409aa <exception+0x34a>
            }

        case INT_TIMER:
            {
                ++ticks;
   40868:	8b 05 b2 ea 00 00    	mov    0xeab2(%rip),%eax        # 4f320 <ticks>
   4086e:	83 c0 01             	add    $0x1,%eax
   40871:	89 05 a9 ea 00 00    	mov    %eax,0xeaa9(%rip)        # 4f320 <ticks>
                schedule();
   40877:	e8 57 01 00 00       	call   409d3 <schedule>
                break;                  /* will not be reached */
   4087c:	e9 29 01 00 00       	jmp    409aa <exception+0x34a>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40881:	0f 20 d0             	mov    %cr2,%rax
   40884:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    return val;
   40888:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   4088c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
                const char* operation = reg->reg_err & PFERR_WRITE
   40890:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40897:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4089e:	83 e0 02             	and    $0x2,%eax
                    ? "write" : "read";
   408a1:	48 85 c0             	test   %rax,%rax
   408a4:	74 09                	je     408af <exception+0x24f>
   408a6:	48 8d 05 7e 46 00 00 	lea    0x467e(%rip),%rax        # 44f2b <memstate_colors+0xab>
   408ad:	eb 07                	jmp    408b6 <exception+0x256>
   408af:	48 8d 05 7b 46 00 00 	lea    0x467b(%rip),%rax        # 44f31 <memstate_colors+0xb1>
                const char* operation = reg->reg_err & PFERR_WRITE
   408b6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
                const char* problem = reg->reg_err & PFERR_PRESENT
   408ba:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408c1:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   408c8:	83 e0 01             	and    $0x1,%eax
                    ? "protection problem" : "missing page";
   408cb:	48 85 c0             	test   %rax,%rax
   408ce:	74 09                	je     408d9 <exception+0x279>
   408d0:	48 8d 05 5f 46 00 00 	lea    0x465f(%rip),%rax        # 44f36 <memstate_colors+0xb6>
   408d7:	eb 07                	jmp    408e0 <exception+0x280>
   408d9:	48 8d 05 69 46 00 00 	lea    0x4669(%rip),%rax        # 44f49 <memstate_colors+0xc9>
                const char* problem = reg->reg_err & PFERR_PRESENT
   408e0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

                if (!(reg->reg_err & PFERR_USER)) {
   408e4:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408eb:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   408f2:	83 e0 04             	and    $0x4,%eax
   408f5:	48 85 c0             	test   %rax,%rax
   408f8:	75 34                	jne    4092e <exception+0x2ce>
                    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   408fa:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40901:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40908:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4090c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40910:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40914:	49 89 f0             	mov    %rsi,%r8
   40917:	48 89 c6             	mov    %rax,%rsi
   4091a:	48 8d 05 37 46 00 00 	lea    0x4637(%rip),%rax        # 44f58 <memstate_colors+0xd8>
   40921:	48 89 c7             	mov    %rax,%rdi
   40924:	b8 00 00 00 00       	mov    $0x0,%eax
   40929:	e8 1d 1c 00 00       	call   4254b <kernel_panic>
                            addr, operation, problem, reg->reg_rip);
                }
                console_printf(CPOS(24, 0), 0x0C00,
   4092e:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40935:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                        "Process %d page fault for %p (%s %s, rip=%p)!\n",
                        current->p_pid, addr, operation, problem, reg->reg_rip);
   4093c:	48 8b 05 bd e5 00 00 	mov    0xe5bd(%rip),%rax        # 4ef00 <current>
                console_printf(CPOS(24, 0), 0x0C00,
   40943:	8b 00                	mov    (%rax),%eax
   40945:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   40949:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4094d:	52                   	push   %rdx
   4094e:	ff 75 d8             	push   -0x28(%rbp)
   40951:	49 89 f1             	mov    %rsi,%r9
   40954:	49 89 c8             	mov    %rcx,%r8
   40957:	89 c1                	mov    %eax,%ecx
   40959:	48 8d 05 28 46 00 00 	lea    0x4628(%rip),%rax        # 44f88 <memstate_colors+0x108>
   40960:	48 89 c2             	mov    %rax,%rdx
   40963:	be 00 0c 00 00       	mov    $0xc00,%esi
   40968:	bf 80 07 00 00       	mov    $0x780,%edi
   4096d:	b8 00 00 00 00       	mov    $0x0,%eax
   40972:	e8 3c 43 00 00       	call   44cb3 <console_printf>
   40977:	48 83 c4 10          	add    $0x10,%rsp
                current->p_state = P_BROKEN;
   4097b:	48 8b 05 7e e5 00 00 	mov    0xe57e(%rip),%rax        # 4ef00 <current>
   40982:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40989:	00 00 00 
                syscall_exit();
   4098c:	b8 00 00 00 00       	mov    $0x0,%eax
   40991:	e8 18 fb ff ff       	call   404ae <syscall_exit>
                break;
   40996:	eb 12                	jmp    409aa <exception+0x34a>
            }

        default:
            default_exception(current);
   40998:	48 8b 05 61 e5 00 00 	mov    0xe561(%rip),%rax        # 4ef00 <current>
   4099f:	48 89 c7             	mov    %rax,%rdi
   409a2:	e8 cd 1c 00 00       	call   42674 <default_exception>
            break;                  /* will not be reached */
   409a7:	eb 01                	jmp    409aa <exception+0x34a>
		break;
   409a9:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   409aa:	48 8b 05 4f e5 00 00 	mov    0xe54f(%rip),%rax        # 4ef00 <current>
   409b1:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   409b7:	83 f8 01             	cmp    $0x1,%eax
   409ba:	75 0f                	jne    409cb <exception+0x36b>
        run(current);
   409bc:	48 8b 05 3d e5 00 00 	mov    0xe53d(%rip),%rax        # 4ef00 <current>
   409c3:	48 89 c7             	mov    %rax,%rdi
   409c6:	e8 87 00 00 00       	call   40a52 <run>
    } else {
        schedule();
   409cb:	e8 03 00 00 00       	call   409d3 <schedule>
    }
}
   409d0:	90                   	nop
   409d1:	c9                   	leave  
   409d2:	c3                   	ret    

00000000000409d3 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   409d3:	f3 0f 1e fa          	endbr64 
   409d7:	55                   	push   %rbp
   409d8:	48 89 e5             	mov    %rsp,%rbp
   409db:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   409df:	48 8b 05 1a e5 00 00 	mov    0xe51a(%rip),%rax        # 4ef00 <current>
   409e6:	8b 00                	mov    (%rax),%eax
   409e8:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   409eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409ee:	83 c0 01             	add    $0x1,%eax
   409f1:	99                   	cltd   
   409f2:	c1 ea 1c             	shr    $0x1c,%edx
   409f5:	01 d0                	add    %edx,%eax
   409f7:	83 e0 0f             	and    $0xf,%eax
   409fa:	29 d0                	sub    %edx,%eax
   409fc:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   409ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40a02:	48 63 d0             	movslq %eax,%rdx
   40a05:	48 89 d0             	mov    %rdx,%rax
   40a08:	48 c1 e0 04          	shl    $0x4,%rax
   40a0c:	48 29 d0             	sub    %rdx,%rax
   40a0f:	48 c1 e0 04          	shl    $0x4,%rax
   40a13:	48 89 c2             	mov    %rax,%rdx
   40a16:	48 8d 05 bb d6 00 00 	lea    0xd6bb(%rip),%rax        # 4e0d8 <processes+0xd8>
   40a1d:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40a20:	83 f8 01             	cmp    $0x1,%eax
   40a23:	75 26                	jne    40a4b <schedule+0x78>
            run(&processes[pid]);
   40a25:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40a28:	48 63 d0             	movslq %eax,%rdx
   40a2b:	48 89 d0             	mov    %rdx,%rax
   40a2e:	48 c1 e0 04          	shl    $0x4,%rax
   40a32:	48 29 d0             	sub    %rdx,%rax
   40a35:	48 c1 e0 04          	shl    $0x4,%rax
   40a39:	48 8d 15 c0 d5 00 00 	lea    0xd5c0(%rip),%rdx        # 4e000 <processes>
   40a40:	48 01 d0             	add    %rdx,%rax
   40a43:	48 89 c7             	mov    %rax,%rdi
   40a46:	e8 07 00 00 00       	call   40a52 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40a4b:	e8 99 19 00 00       	call   423e9 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40a50:	eb 99                	jmp    409eb <schedule+0x18>

0000000000040a52 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40a52:	f3 0f 1e fa          	endbr64 
   40a56:	55                   	push   %rbp
   40a57:	48 89 e5             	mov    %rsp,%rbp
   40a5a:	48 83 ec 10          	sub    $0x10,%rsp
   40a5e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40a62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a66:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40a6c:	83 f8 01             	cmp    $0x1,%eax
   40a6f:	74 1e                	je     40a8f <run+0x3d>
   40a71:	48 8d 05 f4 45 00 00 	lea    0x45f4(%rip),%rax        # 4506c <memstate_colors+0x1ec>
   40a78:	48 89 c2             	mov    %rax,%rdx
   40a7b:	be 7a 01 00 00       	mov    $0x17a,%esi
   40a80:	48 8d 05 61 44 00 00 	lea    0x4461(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   40a87:	48 89 c7             	mov    %rax,%rdi
   40a8a:	e8 ac 1b 00 00       	call   4263b <assert_fail>
    current = p;
   40a8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a93:	48 89 05 66 e4 00 00 	mov    %rax,0xe466(%rip)        # 4ef00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40a9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a9e:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40aa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40aa4:	8b 00                	mov    (%rax),%eax
   40aa6:	83 c0 02             	add    $0x2,%eax
   40aa9:	48 98                	cltq   
   40aab:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40aaf:	48 8d 05 ca 43 00 00 	lea    0x43ca(%rip),%rax        # 44e80 <memstate_colors>
   40ab6:	0f b7 04 01          	movzwl (%rcx,%rax,1),%eax
    console_printf(CPOS(24, 79),
   40aba:	0f b7 c0             	movzwl %ax,%eax
   40abd:	89 d1                	mov    %edx,%ecx
   40abf:	48 8d 15 bf 45 00 00 	lea    0x45bf(%rip),%rdx        # 45085 <memstate_colors+0x205>
   40ac6:	89 c6                	mov    %eax,%esi
   40ac8:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40acd:	b8 00 00 00 00       	mov    $0x0,%eax
   40ad2:	e8 dc 41 00 00       	call   44cb3 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40ad7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40adb:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40ae2:	48 89 c7             	mov    %rax,%rdi
   40ae5:	e8 63 1d 00 00       	call   4284d <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40aea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40aee:	48 83 c0 18          	add    $0x18,%rax
   40af2:	48 89 c7             	mov    %rax,%rdi
   40af5:	e8 c9 f5 ff ff       	call   400c3 <exception_return>

0000000000040afa <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40afa:	f3 0f 1e fa          	endbr64 
   40afe:	55                   	push   %rbp
   40aff:	48 89 e5             	mov    %rsp,%rbp
   40b02:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40b06:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40b0d:	00 
   40b0e:	e9 93 00 00 00       	jmp    40ba6 <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40b13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b17:	48 89 c7             	mov    %rax,%rdi
   40b1a:	e8 04 11 00 00       	call   41c23 <physical_memory_isreserved>
   40b1f:	85 c0                	test   %eax,%eax
   40b21:	74 09                	je     40b2c <pageinfo_init+0x32>
            owner = PO_RESERVED;
   40b23:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40b2a:	eb 31                	jmp    40b5d <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40b2c:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40b33:	00 
   40b34:	76 0d                	jbe    40b43 <pageinfo_init+0x49>
   40b36:	48 8d 05 d3 64 01 00 	lea    0x164d3(%rip),%rax        # 57010 <end>
   40b3d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b41:	72 0a                	jb     40b4d <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40b43:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40b4a:	00 
   40b4b:	75 09                	jne    40b56 <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   40b4d:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40b54:	eb 07                	jmp    40b5d <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   40b56:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40b5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b61:	48 c1 e8 0c          	shr    $0xc,%rax
   40b65:	89 c2                	mov    %eax,%edx
   40b67:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40b6a:	89 c1                	mov    %eax,%ecx
   40b6c:	48 63 c2             	movslq %edx,%rax
   40b6f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40b73:	48 8d 05 a6 e3 00 00 	lea    0xe3a6(%rip),%rax        # 4ef20 <pageinfo>
   40b7a:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40b7d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40b81:	0f 95 c2             	setne  %dl
   40b84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b88:	48 c1 e8 0c          	shr    $0xc,%rax
   40b8c:	89 d1                	mov    %edx,%ecx
   40b8e:	48 98                	cltq   
   40b90:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40b94:	48 8d 05 86 e3 00 00 	lea    0xe386(%rip),%rax        # 4ef21 <pageinfo+0x1>
   40b9b:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40b9e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40ba5:	00 
   40ba6:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40bad:	00 
   40bae:	0f 86 5f ff ff ff    	jbe    40b13 <pageinfo_init+0x19>
    }
}
   40bb4:	90                   	nop
   40bb5:	90                   	nop
   40bb6:	c9                   	leave  
   40bb7:	c3                   	ret    

0000000000040bb8 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40bb8:	f3 0f 1e fa          	endbr64 
   40bbc:	55                   	push   %rbp
   40bbd:	48 89 e5             	mov    %rsp,%rbp
   40bc0:	48 83 ec 50          	sub    $0x50,%rsp
   40bc4:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40bc8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40bcc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40bd2:	48 89 c2             	mov    %rax,%rdx
   40bd5:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40bd9:	48 39 c2             	cmp    %rax,%rdx
   40bdc:	74 1e                	je     40bfc <check_page_table_mappings+0x44>
   40bde:	48 8d 05 a3 44 00 00 	lea    0x44a3(%rip),%rax        # 45088 <memstate_colors+0x208>
   40be5:	48 89 c2             	mov    %rax,%rdx
   40be8:	be a8 01 00 00       	mov    $0x1a8,%esi
   40bed:	48 8d 05 f4 42 00 00 	lea    0x42f4(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   40bf4:	48 89 c7             	mov    %rax,%rdi
   40bf7:	e8 3f 1a 00 00       	call   4263b <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40bfc:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40c03:	00 
   40c04:	e9 b5 00 00 00       	jmp    40cbe <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40c09:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40c0d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40c11:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40c15:	48 89 ce             	mov    %rcx,%rsi
   40c18:	48 89 c7             	mov    %rax,%rdi
   40c1b:	e8 eb 21 00 00       	call   42e0b <virtual_memory_lookup>
        if (vam.pa != va) {
   40c20:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40c24:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40c28:	74 2c                	je     40c56 <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40c2a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40c2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c32:	49 89 d0             	mov    %rdx,%r8
   40c35:	48 89 c1             	mov    %rax,%rcx
   40c38:	48 8d 05 68 44 00 00 	lea    0x4468(%rip),%rax        # 450a7 <memstate_colors+0x227>
   40c3f:	48 89 c2             	mov    %rax,%rdx
   40c42:	be 00 c0 00 00       	mov    $0xc000,%esi
   40c47:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40c4c:	b8 00 00 00 00       	mov    $0x0,%eax
   40c51:	e8 5d 40 00 00       	call   44cb3 <console_printf>
        }
        assert(vam.pa == va);
   40c56:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40c5a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40c5e:	74 1e                	je     40c7e <check_page_table_mappings+0xc6>
   40c60:	48 8d 05 4a 44 00 00 	lea    0x444a(%rip),%rax        # 450b1 <memstate_colors+0x231>
   40c67:	48 89 c2             	mov    %rax,%rdx
   40c6a:	be b1 01 00 00       	mov    $0x1b1,%esi
   40c6f:	48 8d 05 72 42 00 00 	lea    0x4272(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   40c76:	48 89 c7             	mov    %rax,%rdi
   40c79:	e8 bd 19 00 00       	call   4263b <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40c7e:	48 8d 05 7b 53 00 00 	lea    0x537b(%rip),%rax        # 46000 <disp_global>
   40c85:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40c89:	72 2b                	jb     40cb6 <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   40c8b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40c8e:	48 98                	cltq   
   40c90:	83 e0 02             	and    $0x2,%eax
   40c93:	48 85 c0             	test   %rax,%rax
   40c96:	75 1e                	jne    40cb6 <check_page_table_mappings+0xfe>
   40c98:	48 8d 05 1f 44 00 00 	lea    0x441f(%rip),%rax        # 450be <memstate_colors+0x23e>
   40c9f:	48 89 c2             	mov    %rax,%rdx
   40ca2:	be b3 01 00 00       	mov    $0x1b3,%esi
   40ca7:	48 8d 05 3a 42 00 00 	lea    0x423a(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   40cae:	48 89 c7             	mov    %rax,%rdi
   40cb1:	e8 85 19 00 00       	call   4263b <assert_fail>
         va += PAGESIZE) {
   40cb6:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40cbd:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40cbe:	48 8d 05 4b 63 01 00 	lea    0x1634b(%rip),%rax        # 57010 <end>
   40cc5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40cc9:	0f 82 3a ff ff ff    	jb     40c09 <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40ccf:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40cd6:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40cd7:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40cdb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40cdf:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40ce3:	48 89 ce             	mov    %rcx,%rsi
   40ce6:	48 89 c7             	mov    %rax,%rdi
   40ce9:	e8 1d 21 00 00       	call   42e0b <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40cee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40cf2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40cf6:	74 1e                	je     40d16 <check_page_table_mappings+0x15e>
   40cf8:	48 8d 05 d0 43 00 00 	lea    0x43d0(%rip),%rax        # 450cf <memstate_colors+0x24f>
   40cff:	48 89 c2             	mov    %rax,%rdx
   40d02:	be ba 01 00 00       	mov    $0x1ba,%esi
   40d07:	48 8d 05 da 41 00 00 	lea    0x41da(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   40d0e:	48 89 c7             	mov    %rax,%rdi
   40d11:	e8 25 19 00 00       	call   4263b <assert_fail>
    assert(vam.perm & PTE_W);
   40d16:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40d19:	48 98                	cltq   
   40d1b:	83 e0 02             	and    $0x2,%eax
   40d1e:	48 85 c0             	test   %rax,%rax
   40d21:	75 1e                	jne    40d41 <check_page_table_mappings+0x189>
   40d23:	48 8d 05 94 43 00 00 	lea    0x4394(%rip),%rax        # 450be <memstate_colors+0x23e>
   40d2a:	48 89 c2             	mov    %rax,%rdx
   40d2d:	be bb 01 00 00       	mov    $0x1bb,%esi
   40d32:	48 8d 05 af 41 00 00 	lea    0x41af(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   40d39:	48 89 c7             	mov    %rax,%rdi
   40d3c:	e8 fa 18 00 00       	call   4263b <assert_fail>
}
   40d41:	90                   	nop
   40d42:	c9                   	leave  
   40d43:	c3                   	ret    

0000000000040d44 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40d44:	f3 0f 1e fa          	endbr64 
   40d48:	55                   	push   %rbp
   40d49:	48 89 e5             	mov    %rsp,%rbp
   40d4c:	48 83 ec 20          	sub    $0x20,%rsp
   40d50:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40d54:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40d57:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40d5a:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40d5d:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40d64:	48 8b 05 95 02 01 00 	mov    0x10295(%rip),%rax        # 51000 <kernel_pagetable>
   40d6b:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40d6f:	75 71                	jne    40de2 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   40d71:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40d78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40d7f:	eb 5b                	jmp    40ddc <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   40d81:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40d84:	48 63 d0             	movslq %eax,%rdx
   40d87:	48 89 d0             	mov    %rdx,%rax
   40d8a:	48 c1 e0 04          	shl    $0x4,%rax
   40d8e:	48 29 d0             	sub    %rdx,%rax
   40d91:	48 c1 e0 04          	shl    $0x4,%rax
   40d95:	48 89 c2             	mov    %rax,%rdx
   40d98:	48 8d 05 39 d3 00 00 	lea    0xd339(%rip),%rax        # 4e0d8 <processes+0xd8>
   40d9f:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40da2:	85 c0                	test   %eax,%eax
   40da4:	74 32                	je     40dd8 <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40da6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40da9:	48 63 d0             	movslq %eax,%rdx
   40dac:	48 89 d0             	mov    %rdx,%rax
   40daf:	48 c1 e0 04          	shl    $0x4,%rax
   40db3:	48 29 d0             	sub    %rdx,%rax
   40db6:	48 c1 e0 04          	shl    $0x4,%rax
   40dba:	48 89 c2             	mov    %rax,%rdx
   40dbd:	48 8d 05 1c d3 00 00 	lea    0xd31c(%rip),%rax        # 4e0e0 <processes+0xe0>
   40dc4:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   40dc8:	48 8b 05 31 02 01 00 	mov    0x10231(%rip),%rax        # 51000 <kernel_pagetable>
   40dcf:	48 39 c2             	cmp    %rax,%rdx
   40dd2:	75 04                	jne    40dd8 <check_page_table_ownership+0x94>
                ++expected_refcount;
   40dd4:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40dd8:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40ddc:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40de0:	7e 9f                	jle    40d81 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40de2:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40de5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40de8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40dec:	be 00 00 00 00       	mov    $0x0,%esi
   40df1:	48 89 c7             	mov    %rax,%rdi
   40df4:	e8 03 00 00 00       	call   40dfc <check_page_table_ownership_level>
}
   40df9:	90                   	nop
   40dfa:	c9                   	leave  
   40dfb:	c3                   	ret    

0000000000040dfc <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40dfc:	f3 0f 1e fa          	endbr64 
   40e00:	55                   	push   %rbp
   40e01:	48 89 e5             	mov    %rsp,%rbp
   40e04:	48 83 ec 30          	sub    $0x30,%rsp
   40e08:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40e0c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40e0f:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40e12:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40e15:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e19:	48 c1 e8 0c          	shr    $0xc,%rax
   40e1d:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40e22:	7e 1e                	jle    40e42 <check_page_table_ownership_level+0x46>
   40e24:	48 8d 05 b5 42 00 00 	lea    0x42b5(%rip),%rax        # 450e0 <memstate_colors+0x260>
   40e2b:	48 89 c2             	mov    %rax,%rdx
   40e2e:	be d8 01 00 00       	mov    $0x1d8,%esi
   40e33:	48 8d 05 ae 40 00 00 	lea    0x40ae(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   40e3a:	48 89 c7             	mov    %rax,%rdi
   40e3d:	e8 f9 17 00 00       	call   4263b <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40e42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e46:	48 c1 e8 0c          	shr    $0xc,%rax
   40e4a:	48 98                	cltq   
   40e4c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e50:	48 8d 05 c9 e0 00 00 	lea    0xe0c9(%rip),%rax        # 4ef20 <pageinfo>
   40e57:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40e5b:	0f be c0             	movsbl %al,%eax
   40e5e:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40e61:	74 1e                	je     40e81 <check_page_table_ownership_level+0x85>
   40e63:	48 8d 05 8e 42 00 00 	lea    0x428e(%rip),%rax        # 450f8 <memstate_colors+0x278>
   40e6a:	48 89 c2             	mov    %rax,%rdx
   40e6d:	be d9 01 00 00       	mov    $0x1d9,%esi
   40e72:	48 8d 05 6f 40 00 00 	lea    0x406f(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   40e79:	48 89 c7             	mov    %rax,%rdi
   40e7c:	e8 ba 17 00 00       	call   4263b <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40e81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e85:	48 c1 e8 0c          	shr    $0xc,%rax
   40e89:	48 98                	cltq   
   40e8b:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e8f:	48 8d 05 8b e0 00 00 	lea    0xe08b(%rip),%rax        # 4ef21 <pageinfo+0x1>
   40e96:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40e9a:	0f be c0             	movsbl %al,%eax
   40e9d:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40ea0:	74 1e                	je     40ec0 <check_page_table_ownership_level+0xc4>
   40ea2:	48 8d 05 77 42 00 00 	lea    0x4277(%rip),%rax        # 45120 <memstate_colors+0x2a0>
   40ea9:	48 89 c2             	mov    %rax,%rdx
   40eac:	be da 01 00 00       	mov    $0x1da,%esi
   40eb1:	48 8d 05 30 40 00 00 	lea    0x4030(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   40eb8:	48 89 c7             	mov    %rax,%rdi
   40ebb:	e8 7b 17 00 00       	call   4263b <assert_fail>
    if (level < 3) {
   40ec0:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40ec4:	7f 5b                	jg     40f21 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40ec6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40ecd:	eb 49                	jmp    40f18 <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   40ecf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ed3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ed6:	48 63 d2             	movslq %edx,%rdx
   40ed9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40edd:	48 85 c0             	test   %rax,%rax
   40ee0:	74 32                	je     40f14 <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40ee2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ee6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ee9:	48 63 d2             	movslq %edx,%rdx
   40eec:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40ef0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40ef6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40efa:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40efd:	8d 70 01             	lea    0x1(%rax),%esi
   40f00:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40f03:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f07:	b9 01 00 00 00       	mov    $0x1,%ecx
   40f0c:	48 89 c7             	mov    %rax,%rdi
   40f0f:	e8 e8 fe ff ff       	call   40dfc <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40f14:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40f18:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40f1f:	7e ae                	jle    40ecf <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   40f21:	90                   	nop
   40f22:	c9                   	leave  
   40f23:	c3                   	ret    

0000000000040f24 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40f24:	f3 0f 1e fa          	endbr64 
   40f28:	55                   	push   %rbp
   40f29:	48 89 e5             	mov    %rsp,%rbp
   40f2c:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40f30:	8b 05 a2 d1 00 00    	mov    0xd1a2(%rip),%eax        # 4e0d8 <processes+0xd8>
   40f36:	85 c0                	test   %eax,%eax
   40f38:	74 1e                	je     40f58 <check_virtual_memory+0x34>
   40f3a:	48 8d 05 0f 42 00 00 	lea    0x420f(%rip),%rax        # 45150 <memstate_colors+0x2d0>
   40f41:	48 89 c2             	mov    %rax,%rdx
   40f44:	be ed 01 00 00       	mov    $0x1ed,%esi
   40f49:	48 8d 05 98 3f 00 00 	lea    0x3f98(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   40f50:	48 89 c7             	mov    %rax,%rdi
   40f53:	e8 e3 16 00 00       	call   4263b <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40f58:	48 8b 05 a1 00 01 00 	mov    0x100a1(%rip),%rax        # 51000 <kernel_pagetable>
   40f5f:	48 89 c7             	mov    %rax,%rdi
   40f62:	e8 51 fc ff ff       	call   40bb8 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40f67:	48 8b 05 92 00 01 00 	mov    0x10092(%rip),%rax        # 51000 <kernel_pagetable>
   40f6e:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40f73:	48 89 c7             	mov    %rax,%rdi
   40f76:	e8 c9 fd ff ff       	call   40d44 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40f7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40f82:	e9 b4 00 00 00       	jmp    4103b <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   40f87:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f8a:	48 63 d0             	movslq %eax,%rdx
   40f8d:	48 89 d0             	mov    %rdx,%rax
   40f90:	48 c1 e0 04          	shl    $0x4,%rax
   40f94:	48 29 d0             	sub    %rdx,%rax
   40f97:	48 c1 e0 04          	shl    $0x4,%rax
   40f9b:	48 89 c2             	mov    %rax,%rdx
   40f9e:	48 8d 05 33 d1 00 00 	lea    0xd133(%rip),%rax        # 4e0d8 <processes+0xd8>
   40fa5:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40fa8:	85 c0                	test   %eax,%eax
   40faa:	0f 84 87 00 00 00    	je     41037 <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   40fb0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fb3:	48 63 d0             	movslq %eax,%rdx
   40fb6:	48 89 d0             	mov    %rdx,%rax
   40fb9:	48 c1 e0 04          	shl    $0x4,%rax
   40fbd:	48 29 d0             	sub    %rdx,%rax
   40fc0:	48 c1 e0 04          	shl    $0x4,%rax
   40fc4:	48 89 c2             	mov    %rax,%rdx
   40fc7:	48 8d 05 12 d1 00 00 	lea    0xd112(%rip),%rax        # 4e0e0 <processes+0xe0>
   40fce:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   40fd2:	48 8b 05 27 00 01 00 	mov    0x10027(%rip),%rax        # 51000 <kernel_pagetable>
   40fd9:	48 39 c2             	cmp    %rax,%rdx
   40fdc:	74 59                	je     41037 <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   40fde:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fe1:	48 63 d0             	movslq %eax,%rdx
   40fe4:	48 89 d0             	mov    %rdx,%rax
   40fe7:	48 c1 e0 04          	shl    $0x4,%rax
   40feb:	48 29 d0             	sub    %rdx,%rax
   40fee:	48 c1 e0 04          	shl    $0x4,%rax
   40ff2:	48 89 c2             	mov    %rax,%rdx
   40ff5:	48 8d 05 e4 d0 00 00 	lea    0xd0e4(%rip),%rax        # 4e0e0 <processes+0xe0>
   40ffc:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41000:	48 89 c7             	mov    %rax,%rdi
   41003:	e8 b0 fb ff ff       	call   40bb8 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41008:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4100b:	48 63 d0             	movslq %eax,%rdx
   4100e:	48 89 d0             	mov    %rdx,%rax
   41011:	48 c1 e0 04          	shl    $0x4,%rax
   41015:	48 29 d0             	sub    %rdx,%rax
   41018:	48 c1 e0 04          	shl    $0x4,%rax
   4101c:	48 89 c2             	mov    %rax,%rdx
   4101f:	48 8d 05 ba d0 00 00 	lea    0xd0ba(%rip),%rax        # 4e0e0 <processes+0xe0>
   41026:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4102a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4102d:	89 d6                	mov    %edx,%esi
   4102f:	48 89 c7             	mov    %rax,%rdi
   41032:	e8 0d fd ff ff       	call   40d44 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41037:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4103b:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4103f:	0f 8e 42 ff ff ff    	jle    40f87 <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41045:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4104c:	e9 8b 00 00 00       	jmp    410dc <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41051:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41054:	48 98                	cltq   
   41056:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4105a:	48 8d 05 c0 de 00 00 	lea    0xdec0(%rip),%rax        # 4ef21 <pageinfo+0x1>
   41061:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41065:	84 c0                	test   %al,%al
   41067:	7e 6f                	jle    410d8 <check_virtual_memory+0x1b4>
   41069:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4106c:	48 98                	cltq   
   4106e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41072:	48 8d 05 a7 de 00 00 	lea    0xdea7(%rip),%rax        # 4ef20 <pageinfo>
   41079:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4107d:	84 c0                	test   %al,%al
   4107f:	78 57                	js     410d8 <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41081:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41084:	48 98                	cltq   
   41086:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4108a:	48 8d 05 8f de 00 00 	lea    0xde8f(%rip),%rax        # 4ef20 <pageinfo>
   41091:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41095:	0f be c0             	movsbl %al,%eax
   41098:	48 63 d0             	movslq %eax,%rdx
   4109b:	48 89 d0             	mov    %rdx,%rax
   4109e:	48 c1 e0 04          	shl    $0x4,%rax
   410a2:	48 29 d0             	sub    %rdx,%rax
   410a5:	48 c1 e0 04          	shl    $0x4,%rax
   410a9:	48 89 c2             	mov    %rax,%rdx
   410ac:	48 8d 05 25 d0 00 00 	lea    0xd025(%rip),%rax        # 4e0d8 <processes+0xd8>
   410b3:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   410b6:	85 c0                	test   %eax,%eax
   410b8:	75 1e                	jne    410d8 <check_virtual_memory+0x1b4>
   410ba:	48 8d 05 af 40 00 00 	lea    0x40af(%rip),%rax        # 45170 <memstate_colors+0x2f0>
   410c1:	48 89 c2             	mov    %rax,%rdx
   410c4:	be 04 02 00 00       	mov    $0x204,%esi
   410c9:	48 8d 05 18 3e 00 00 	lea    0x3e18(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   410d0:	48 89 c7             	mov    %rax,%rdi
   410d3:	e8 63 15 00 00       	call   4263b <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   410d8:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   410dc:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   410e3:	0f 8e 68 ff ff ff    	jle    41051 <check_virtual_memory+0x12d>
        }
    }
}
   410e9:	90                   	nop
   410ea:	90                   	nop
   410eb:	c9                   	leave  
   410ec:	c3                   	ret    

00000000000410ed <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   410ed:	f3 0f 1e fa          	endbr64 
   410f1:	55                   	push   %rbp
   410f2:	48 89 e5             	mov    %rsp,%rbp
   410f5:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   410f9:	48 8d 05 a0 40 00 00 	lea    0x40a0(%rip),%rax        # 451a0 <memstate_colors+0x320>
   41100:	48 89 c2             	mov    %rax,%rdx
   41103:	be 00 0f 00 00       	mov    $0xf00,%esi
   41108:	bf 20 00 00 00       	mov    $0x20,%edi
   4110d:	b8 00 00 00 00       	mov    $0x0,%eax
   41112:	e8 9c 3b 00 00       	call   44cb3 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41117:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4111e:	e9 1b 01 00 00       	jmp    4123e <memshow_physical+0x151>
        if (pn % 64 == 0) {
   41123:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41126:	83 e0 3f             	and    $0x3f,%eax
   41129:	85 c0                	test   %eax,%eax
   4112b:	75 40                	jne    4116d <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   4112d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41130:	c1 e0 0c             	shl    $0xc,%eax
   41133:	89 c2                	mov    %eax,%edx
   41135:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41138:	8d 48 3f             	lea    0x3f(%rax),%ecx
   4113b:	85 c0                	test   %eax,%eax
   4113d:	0f 48 c1             	cmovs  %ecx,%eax
   41140:	c1 f8 06             	sar    $0x6,%eax
   41143:	8d 48 01             	lea    0x1(%rax),%ecx
   41146:	89 c8                	mov    %ecx,%eax
   41148:	c1 e0 02             	shl    $0x2,%eax
   4114b:	01 c8                	add    %ecx,%eax
   4114d:	c1 e0 04             	shl    $0x4,%eax
   41150:	83 c0 03             	add    $0x3,%eax
   41153:	89 d1                	mov    %edx,%ecx
   41155:	48 8d 15 54 40 00 00 	lea    0x4054(%rip),%rdx        # 451b0 <memstate_colors+0x330>
   4115c:	be 00 0f 00 00       	mov    $0xf00,%esi
   41161:	89 c7                	mov    %eax,%edi
   41163:	b8 00 00 00 00       	mov    $0x0,%eax
   41168:	e8 46 3b 00 00       	call   44cb3 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   4116d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41170:	48 98                	cltq   
   41172:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41176:	48 8d 05 a3 dd 00 00 	lea    0xdda3(%rip),%rax        # 4ef20 <pageinfo>
   4117d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41181:	0f be c0             	movsbl %al,%eax
   41184:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41187:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4118a:	48 98                	cltq   
   4118c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41190:	48 8d 05 8a dd 00 00 	lea    0xdd8a(%rip),%rax        # 4ef21 <pageinfo+0x1>
   41197:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4119b:	84 c0                	test   %al,%al
   4119d:	75 07                	jne    411a6 <memshow_physical+0xb9>
            owner = PO_FREE;
   4119f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   411a6:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411a9:	83 c0 02             	add    $0x2,%eax
   411ac:	48 98                	cltq   
   411ae:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   411b2:	48 8d 05 c7 3c 00 00 	lea    0x3cc7(%rip),%rax        # 44e80 <memstate_colors>
   411b9:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   411bd:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   411c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411c4:	48 98                	cltq   
   411c6:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   411ca:	48 8d 05 50 dd 00 00 	lea    0xdd50(%rip),%rax        # 4ef21 <pageinfo+0x1>
   411d1:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   411d5:	3c 01                	cmp    $0x1,%al
   411d7:	7e 1c                	jle    411f5 <memshow_physical+0x108>
   411d9:	48 8d 05 20 6e 07 00 	lea    0x76e20(%rip),%rax        # b8000 <console>
   411e0:	48 c1 e8 0c          	shr    $0xc,%rax
   411e4:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   411e7:	74 0c                	je     411f5 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   411e9:	b8 53 00 00 00       	mov    $0x53,%eax
   411ee:	80 cc 0f             	or     $0xf,%ah
   411f1:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   411f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411f8:	8d 50 3f             	lea    0x3f(%rax),%edx
   411fb:	85 c0                	test   %eax,%eax
   411fd:	0f 48 c2             	cmovs  %edx,%eax
   41200:	c1 f8 06             	sar    $0x6,%eax
   41203:	8d 50 01             	lea    0x1(%rax),%edx
   41206:	89 d0                	mov    %edx,%eax
   41208:	c1 e0 02             	shl    $0x2,%eax
   4120b:	01 d0                	add    %edx,%eax
   4120d:	c1 e0 04             	shl    $0x4,%eax
   41210:	89 c1                	mov    %eax,%ecx
   41212:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41215:	99                   	cltd   
   41216:	c1 ea 1a             	shr    $0x1a,%edx
   41219:	01 d0                	add    %edx,%eax
   4121b:	83 e0 3f             	and    $0x3f,%eax
   4121e:	29 d0                	sub    %edx,%eax
   41220:	83 c0 0c             	add    $0xc,%eax
   41223:	01 c8                	add    %ecx,%eax
   41225:	48 98                	cltq   
   41227:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4122b:	48 8d 15 ce 6d 07 00 	lea    0x76dce(%rip),%rdx        # b8000 <console>
   41232:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41236:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4123a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4123e:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41245:	0f 8e d8 fe ff ff    	jle    41123 <memshow_physical+0x36>
    }
}
   4124b:	90                   	nop
   4124c:	90                   	nop
   4124d:	c9                   	leave  
   4124e:	c3                   	ret    

000000000004124f <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   4124f:	f3 0f 1e fa          	endbr64 
   41253:	55                   	push   %rbp
   41254:	48 89 e5             	mov    %rsp,%rbp
   41257:	48 83 ec 40          	sub    $0x40,%rsp
   4125b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4125f:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41263:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41267:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4126d:	48 89 c2             	mov    %rax,%rdx
   41270:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41274:	48 39 c2             	cmp    %rax,%rdx
   41277:	74 1e                	je     41297 <memshow_virtual+0x48>
   41279:	48 8d 05 38 3f 00 00 	lea    0x3f38(%rip),%rax        # 451b8 <memstate_colors+0x338>
   41280:	48 89 c2             	mov    %rax,%rdx
   41283:	be 35 02 00 00       	mov    $0x235,%esi
   41288:	48 8d 05 59 3c 00 00 	lea    0x3c59(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   4128f:	48 89 c7             	mov    %rax,%rdi
   41292:	e8 a4 13 00 00       	call   4263b <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41297:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4129b:	48 89 c1             	mov    %rax,%rcx
   4129e:	48 8d 05 40 3f 00 00 	lea    0x3f40(%rip),%rax        # 451e5 <memstate_colors+0x365>
   412a5:	48 89 c2             	mov    %rax,%rdx
   412a8:	be 00 0f 00 00       	mov    $0xf00,%esi
   412ad:	bf 3a 03 00 00       	mov    $0x33a,%edi
   412b2:	b8 00 00 00 00       	mov    $0x0,%eax
   412b7:	e8 f7 39 00 00       	call   44cb3 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   412bc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   412c3:	00 
   412c4:	e9 b4 01 00 00       	jmp    4147d <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   412c9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   412cd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   412d1:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   412d5:	48 89 ce             	mov    %rcx,%rsi
   412d8:	48 89 c7             	mov    %rax,%rdi
   412db:	e8 2b 1b 00 00       	call   42e0b <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   412e0:	8b 45 d0             	mov    -0x30(%rbp),%eax
   412e3:	85 c0                	test   %eax,%eax
   412e5:	79 0b                	jns    412f2 <memshow_virtual+0xa3>
            color = ' ';
   412e7:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   412ed:	e9 ff 00 00 00       	jmp    413f1 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   412f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   412f6:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   412fc:	76 1e                	jbe    4131c <memshow_virtual+0xcd>
   412fe:	48 8d 05 fd 3e 00 00 	lea    0x3efd(%rip),%rax        # 45202 <memstate_colors+0x382>
   41305:	48 89 c2             	mov    %rax,%rdx
   41308:	be 3e 02 00 00       	mov    $0x23e,%esi
   4130d:	48 8d 05 d4 3b 00 00 	lea    0x3bd4(%rip),%rax        # 44ee8 <memstate_colors+0x68>
   41314:	48 89 c7             	mov    %rax,%rdi
   41317:	e8 1f 13 00 00       	call   4263b <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   4131c:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4131f:	48 98                	cltq   
   41321:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41325:	48 8d 05 f4 db 00 00 	lea    0xdbf4(%rip),%rax        # 4ef20 <pageinfo>
   4132c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41330:	0f be c0             	movsbl %al,%eax
   41333:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41336:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41339:	48 98                	cltq   
   4133b:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4133f:	48 8d 05 db db 00 00 	lea    0xdbdb(%rip),%rax        # 4ef21 <pageinfo+0x1>
   41346:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4134a:	84 c0                	test   %al,%al
   4134c:	75 07                	jne    41355 <memshow_virtual+0x106>
                owner = PO_FREE;
   4134e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41355:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41358:	83 c0 02             	add    $0x2,%eax
   4135b:	48 98                	cltq   
   4135d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41361:	48 8d 05 18 3b 00 00 	lea    0x3b18(%rip),%rax        # 44e80 <memstate_colors>
   41368:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   4136c:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41370:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41373:	48 98                	cltq   
   41375:	83 e0 04             	and    $0x4,%eax
   41378:	48 85 c0             	test   %rax,%rax
   4137b:	74 27                	je     413a4 <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4137d:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41381:	c1 e0 04             	shl    $0x4,%eax
   41384:	66 25 00 f0          	and    $0xf000,%ax
   41388:	89 c2                	mov    %eax,%edx
   4138a:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4138e:	c1 f8 04             	sar    $0x4,%eax
   41391:	66 25 00 0f          	and    $0xf00,%ax
   41395:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41397:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4139b:	0f b6 c0             	movzbl %al,%eax
   4139e:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   413a0:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   413a4:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413a7:	48 98                	cltq   
   413a9:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   413ad:	48 8d 05 6d db 00 00 	lea    0xdb6d(%rip),%rax        # 4ef21 <pageinfo+0x1>
   413b4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   413b8:	3c 01                	cmp    $0x1,%al
   413ba:	7e 35                	jle    413f1 <memshow_virtual+0x1a2>
   413bc:	48 8d 05 3d 6c 07 00 	lea    0x76c3d(%rip),%rax        # b8000 <console>
   413c3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413c7:	74 28                	je     413f1 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   413c9:	b8 53 00 00 00       	mov    $0x53,%eax
   413ce:	89 c2                	mov    %eax,%edx
   413d0:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413d4:	66 25 00 f0          	and    $0xf000,%ax
   413d8:	09 d0                	or     %edx,%eax
   413da:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   413de:	8b 45 e0             	mov    -0x20(%rbp),%eax
   413e1:	48 98                	cltq   
   413e3:	83 e0 04             	and    $0x4,%eax
   413e6:	48 85 c0             	test   %rax,%rax
   413e9:	75 06                	jne    413f1 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   413eb:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   413f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413f5:	48 c1 e8 0c          	shr    $0xc,%rax
   413f9:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   413fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   413ff:	83 e0 3f             	and    $0x3f,%eax
   41402:	85 c0                	test   %eax,%eax
   41404:	75 39                	jne    4143f <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41406:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41409:	c1 e8 06             	shr    $0x6,%eax
   4140c:	89 c2                	mov    %eax,%edx
   4140e:	89 d0                	mov    %edx,%eax
   41410:	c1 e0 02             	shl    $0x2,%eax
   41413:	01 d0                	add    %edx,%eax
   41415:	c1 e0 04             	shl    $0x4,%eax
   41418:	05 73 03 00 00       	add    $0x373,%eax
   4141d:	89 c7                	mov    %eax,%edi
   4141f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41423:	48 89 c1             	mov    %rax,%rcx
   41426:	48 8d 05 83 3d 00 00 	lea    0x3d83(%rip),%rax        # 451b0 <memstate_colors+0x330>
   4142d:	48 89 c2             	mov    %rax,%rdx
   41430:	be 00 0f 00 00       	mov    $0xf00,%esi
   41435:	b8 00 00 00 00       	mov    $0x0,%eax
   4143a:	e8 74 38 00 00       	call   44cb3 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   4143f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41442:	c1 e8 06             	shr    $0x6,%eax
   41445:	89 c2                	mov    %eax,%edx
   41447:	89 d0                	mov    %edx,%eax
   41449:	c1 e0 02             	shl    $0x2,%eax
   4144c:	01 d0                	add    %edx,%eax
   4144e:	c1 e0 04             	shl    $0x4,%eax
   41451:	89 c2                	mov    %eax,%edx
   41453:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41456:	83 e0 3f             	and    $0x3f,%eax
   41459:	01 d0                	add    %edx,%eax
   4145b:	05 7c 03 00 00       	add    $0x37c,%eax
   41460:	89 c0                	mov    %eax,%eax
   41462:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41466:	48 8d 15 93 6b 07 00 	lea    0x76b93(%rip),%rdx        # b8000 <console>
   4146d:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41471:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41475:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4147c:	00 
   4147d:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41484:	00 
   41485:	0f 86 3e fe ff ff    	jbe    412c9 <memshow_virtual+0x7a>
    }
}
   4148b:	90                   	nop
   4148c:	90                   	nop
   4148d:	c9                   	leave  
   4148e:	c3                   	ret    

000000000004148f <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   4148f:	f3 0f 1e fa          	endbr64 
   41493:	55                   	push   %rbp
   41494:	48 89 e5             	mov    %rsp,%rbp
   41497:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   4149b:	8b 05 83 de 00 00    	mov    0xde83(%rip),%eax        # 4f324 <last_ticks.1>
   414a1:	85 c0                	test   %eax,%eax
   414a3:	74 13                	je     414b8 <memshow_virtual_animate+0x29>
   414a5:	8b 05 75 de 00 00    	mov    0xde75(%rip),%eax        # 4f320 <ticks>
   414ab:	8b 15 73 de 00 00    	mov    0xde73(%rip),%edx        # 4f324 <last_ticks.1>
   414b1:	29 d0                	sub    %edx,%eax
   414b3:	83 f8 31             	cmp    $0x31,%eax
   414b6:	76 2c                	jbe    414e4 <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   414b8:	8b 05 62 de 00 00    	mov    0xde62(%rip),%eax        # 4f320 <ticks>
   414be:	89 05 60 de 00 00    	mov    %eax,0xde60(%rip)        # 4f324 <last_ticks.1>
        ++showing;
   414c4:	8b 05 3a 4b 00 00    	mov    0x4b3a(%rip),%eax        # 46004 <showing.0>
   414ca:	83 c0 01             	add    $0x1,%eax
   414cd:	89 05 31 4b 00 00    	mov    %eax,0x4b31(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   414d3:	eb 0f                	jmp    414e4 <memshow_virtual_animate+0x55>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   414d5:	8b 05 29 4b 00 00    	mov    0x4b29(%rip),%eax        # 46004 <showing.0>
   414db:	83 c0 01             	add    $0x1,%eax
   414de:	89 05 20 4b 00 00    	mov    %eax,0x4b20(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   414e4:	8b 05 1a 4b 00 00    	mov    0x4b1a(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   414ea:	83 f8 20             	cmp    $0x20,%eax
   414ed:	7f 33                	jg     41522 <memshow_virtual_animate+0x93>
   414ef:	8b 05 0f 4b 00 00    	mov    0x4b0f(%rip),%eax        # 46004 <showing.0>
   414f5:	99                   	cltd   
   414f6:	c1 ea 1c             	shr    $0x1c,%edx
   414f9:	01 d0                	add    %edx,%eax
   414fb:	83 e0 0f             	and    $0xf,%eax
   414fe:	29 d0                	sub    %edx,%eax
   41500:	48 63 d0             	movslq %eax,%rdx
   41503:	48 89 d0             	mov    %rdx,%rax
   41506:	48 c1 e0 04          	shl    $0x4,%rax
   4150a:	48 29 d0             	sub    %rdx,%rax
   4150d:	48 c1 e0 04          	shl    $0x4,%rax
   41511:	48 89 c2             	mov    %rax,%rdx
   41514:	48 8d 05 bd cb 00 00 	lea    0xcbbd(%rip),%rax        # 4e0d8 <processes+0xd8>
   4151b:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4151e:	85 c0                	test   %eax,%eax
   41520:	74 b3                	je     414d5 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   41522:	8b 05 dc 4a 00 00    	mov    0x4adc(%rip),%eax        # 46004 <showing.0>
   41528:	99                   	cltd   
   41529:	c1 ea 1c             	shr    $0x1c,%edx
   4152c:	01 d0                	add    %edx,%eax
   4152e:	83 e0 0f             	and    $0xf,%eax
   41531:	29 d0                	sub    %edx,%eax
   41533:	89 05 cb 4a 00 00    	mov    %eax,0x4acb(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   41539:	8b 05 c5 4a 00 00    	mov    0x4ac5(%rip),%eax        # 46004 <showing.0>
   4153f:	48 63 d0             	movslq %eax,%rdx
   41542:	48 89 d0             	mov    %rdx,%rax
   41545:	48 c1 e0 04          	shl    $0x4,%rax
   41549:	48 29 d0             	sub    %rdx,%rax
   4154c:	48 c1 e0 04          	shl    $0x4,%rax
   41550:	48 89 c2             	mov    %rax,%rdx
   41553:	48 8d 05 7e cb 00 00 	lea    0xcb7e(%rip),%rax        # 4e0d8 <processes+0xd8>
   4155a:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4155d:	85 c0                	test   %eax,%eax
   4155f:	0f 84 82 00 00 00    	je     415e7 <memshow_virtual_animate+0x158>
   41565:	8b 05 99 4a 00 00    	mov    0x4a99(%rip),%eax        # 46004 <showing.0>
   4156b:	48 63 d0             	movslq %eax,%rdx
   4156e:	48 89 d0             	mov    %rdx,%rax
   41571:	48 c1 e0 04          	shl    $0x4,%rax
   41575:	48 29 d0             	sub    %rdx,%rax
   41578:	48 c1 e0 04          	shl    $0x4,%rax
   4157c:	48 89 c2             	mov    %rax,%rdx
   4157f:	48 8d 05 62 cb 00 00 	lea    0xcb62(%rip),%rax        # 4e0e8 <processes+0xe8>
   41586:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4158a:	84 c0                	test   %al,%al
   4158c:	74 59                	je     415e7 <memshow_virtual_animate+0x158>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   4158e:	8b 15 70 4a 00 00    	mov    0x4a70(%rip),%edx        # 46004 <showing.0>
   41594:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41598:	89 d1                	mov    %edx,%ecx
   4159a:	48 8d 15 7b 3c 00 00 	lea    0x3c7b(%rip),%rdx        # 4521c <memstate_colors+0x39c>
   415a1:	be 04 00 00 00       	mov    $0x4,%esi
   415a6:	48 89 c7             	mov    %rax,%rdi
   415a9:	b8 00 00 00 00       	mov    $0x0,%eax
   415ae:	e8 1b 38 00 00       	call   44dce <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   415b3:	8b 05 4b 4a 00 00    	mov    0x4a4b(%rip),%eax        # 46004 <showing.0>
   415b9:	48 63 d0             	movslq %eax,%rdx
   415bc:	48 89 d0             	mov    %rdx,%rax
   415bf:	48 c1 e0 04          	shl    $0x4,%rax
   415c3:	48 29 d0             	sub    %rdx,%rax
   415c6:	48 c1 e0 04          	shl    $0x4,%rax
   415ca:	48 89 c2             	mov    %rax,%rdx
   415cd:	48 8d 05 0c cb 00 00 	lea    0xcb0c(%rip),%rax        # 4e0e0 <processes+0xe0>
   415d4:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   415d8:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   415dc:	48 89 d6             	mov    %rdx,%rsi
   415df:	48 89 c7             	mov    %rax,%rdi
   415e2:	e8 68 fc ff ff       	call   4124f <memshow_virtual>
    }
}
   415e7:	90                   	nop
   415e8:	c9                   	leave  
   415e9:	c3                   	ret    

00000000000415ea <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   415ea:	f3 0f 1e fa          	endbr64 
   415ee:	55                   	push   %rbp
   415ef:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   415f2:	e8 5f 01 00 00       	call   41756 <segments_init>
    interrupt_init();
   415f7:	e8 44 04 00 00       	call   41a40 <interrupt_init>
    virtual_memory_init();
   415fc:	e8 11 11 00 00       	call   42712 <virtual_memory_init>
}
   41601:	90                   	nop
   41602:	5d                   	pop    %rbp
   41603:	c3                   	ret    

0000000000041604 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41604:	f3 0f 1e fa          	endbr64 
   41608:	55                   	push   %rbp
   41609:	48 89 e5             	mov    %rsp,%rbp
   4160c:	48 83 ec 18          	sub    $0x18,%rsp
   41610:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41614:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41618:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   4161b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4161e:	48 98                	cltq   
   41620:	48 c1 e0 2d          	shl    $0x2d,%rax
   41624:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41628:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   4162f:	90 00 00 
   41632:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41635:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41639:	48 89 10             	mov    %rdx,(%rax)
}
   4163c:	90                   	nop
   4163d:	c9                   	leave  
   4163e:	c3                   	ret    

000000000004163f <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   4163f:	f3 0f 1e fa          	endbr64 
   41643:	55                   	push   %rbp
   41644:	48 89 e5             	mov    %rsp,%rbp
   41647:	48 83 ec 28          	sub    $0x28,%rsp
   4164b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4164f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41653:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41656:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   4165a:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   4165e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41662:	48 c1 e0 10          	shl    $0x10,%rax
   41666:	48 89 c2             	mov    %rax,%rdx
   41669:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41670:	00 00 00 
   41673:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41676:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4167a:	48 c1 e0 20          	shl    $0x20,%rax
   4167e:	48 89 c1             	mov    %rax,%rcx
   41681:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41688:	00 00 ff 
   4168b:	48 21 c8             	and    %rcx,%rax
   4168e:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41691:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41695:	48 83 e8 01          	sub    $0x1,%rax
   41699:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   4169c:	48 09 d0             	or     %rdx,%rax
        | type
   4169f:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   416a3:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   416a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416a9:	48 98                	cltq   
   416ab:	48 c1 e0 2d          	shl    $0x2d,%rax
   416af:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   416b2:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   416b9:	80 00 00 
   416bc:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   416bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416c3:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   416c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416ca:	48 83 c0 08          	add    $0x8,%rax
   416ce:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   416d2:	48 c1 ea 20          	shr    $0x20,%rdx
   416d6:	48 89 10             	mov    %rdx,(%rax)
}
   416d9:	90                   	nop
   416da:	c9                   	leave  
   416db:	c3                   	ret    

00000000000416dc <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   416dc:	f3 0f 1e fa          	endbr64 
   416e0:	55                   	push   %rbp
   416e1:	48 89 e5             	mov    %rsp,%rbp
   416e4:	48 83 ec 20          	sub    $0x20,%rsp
   416e8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   416ec:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   416f0:	89 55 ec             	mov    %edx,-0x14(%rbp)
   416f3:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   416f7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416fb:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   416fe:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41702:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41705:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41708:	48 98                	cltq   
   4170a:	48 c1 e0 2d          	shl    $0x2d,%rax
   4170e:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41711:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41715:	48 c1 e0 20          	shl    $0x20,%rax
   41719:	48 89 c1             	mov    %rax,%rcx
   4171c:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41723:	00 ff ff 
   41726:	48 21 c8             	and    %rcx,%rax
   41729:	48 09 c2             	or     %rax,%rdx
   4172c:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41733:	80 00 00 
   41736:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41739:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4173d:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41740:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41744:	48 c1 e8 20          	shr    $0x20,%rax
   41748:	48 89 c2             	mov    %rax,%rdx
   4174b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4174f:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41753:	90                   	nop
   41754:	c9                   	leave  
   41755:	c3                   	ret    

0000000000041756 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41756:	f3 0f 1e fa          	endbr64 
   4175a:	55                   	push   %rbp
   4175b:	48 89 e5             	mov    %rsp,%rbp
   4175e:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41762:	48 c7 05 d3 db 00 00 	movq   $0x0,0xdbd3(%rip)        # 4f340 <segments>
   41769:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   4176d:	ba 00 00 00 00       	mov    $0x0,%edx
   41772:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41779:	08 20 00 
   4177c:	48 89 c6             	mov    %rax,%rsi
   4177f:	48 8d 05 c2 db 00 00 	lea    0xdbc2(%rip),%rax        # 4f348 <segments+0x8>
   41786:	48 89 c7             	mov    %rax,%rdi
   41789:	e8 76 fe ff ff       	call   41604 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   4178e:	ba 03 00 00 00       	mov    $0x3,%edx
   41793:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4179a:	08 20 00 
   4179d:	48 89 c6             	mov    %rax,%rsi
   417a0:	48 8d 05 a9 db 00 00 	lea    0xdba9(%rip),%rax        # 4f350 <segments+0x10>
   417a7:	48 89 c7             	mov    %rax,%rdi
   417aa:	e8 55 fe ff ff       	call   41604 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   417af:	ba 00 00 00 00       	mov    $0x0,%edx
   417b4:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417bb:	02 00 00 
   417be:	48 89 c6             	mov    %rax,%rsi
   417c1:	48 8d 05 90 db 00 00 	lea    0xdb90(%rip),%rax        # 4f358 <segments+0x18>
   417c8:	48 89 c7             	mov    %rax,%rdi
   417cb:	e8 34 fe ff ff       	call   41604 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   417d0:	ba 03 00 00 00       	mov    $0x3,%edx
   417d5:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417dc:	02 00 00 
   417df:	48 89 c6             	mov    %rax,%rsi
   417e2:	48 8d 05 77 db 00 00 	lea    0xdb77(%rip),%rax        # 4f360 <segments+0x20>
   417e9:	48 89 c7             	mov    %rax,%rdi
   417ec:	e8 13 fe ff ff       	call   41604 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   417f1:	48 8d 05 88 eb 00 00 	lea    0xeb88(%rip),%rax        # 50380 <kernel_task_descriptor>
   417f8:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   417fe:	48 89 c1             	mov    %rax,%rcx
   41801:	ba 00 00 00 00       	mov    $0x0,%edx
   41806:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   4180d:	09 00 00 
   41810:	48 89 c6             	mov    %rax,%rsi
   41813:	48 8d 05 4e db 00 00 	lea    0xdb4e(%rip),%rax        # 4f368 <segments+0x28>
   4181a:	48 89 c7             	mov    %rax,%rdi
   4181d:	e8 1d fe ff ff       	call   4163f <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41822:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41828:	48 8d 05 11 db 00 00 	lea    0xdb11(%rip),%rax        # 4f340 <segments>
   4182f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41833:	ba 60 00 00 00       	mov    $0x60,%edx
   41838:	be 00 00 00 00       	mov    $0x0,%esi
   4183d:	48 8d 05 3c eb 00 00 	lea    0xeb3c(%rip),%rax        # 50380 <kernel_task_descriptor>
   41844:	48 89 c7             	mov    %rax,%rdi
   41847:	e8 28 26 00 00       	call   43e74 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   4184c:	48 c7 05 2d eb 00 00 	movq   $0x80000,0xeb2d(%rip)        # 50384 <kernel_task_descriptor+0x4>
   41853:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41857:	ba 00 10 00 00       	mov    $0x1000,%edx
   4185c:	be 00 00 00 00       	mov    $0x0,%esi
   41861:	48 8d 05 18 db 00 00 	lea    0xdb18(%rip),%rax        # 4f380 <interrupt_descriptors>
   41868:	48 89 c7             	mov    %rax,%rdi
   4186b:	e8 04 26 00 00       	call   43e74 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41870:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41877:	eb 3c                	jmp    418b5 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41879:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   41880:	48 89 c2             	mov    %rax,%rdx
   41883:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41886:	48 c1 e0 04          	shl    $0x4,%rax
   4188a:	48 89 c1             	mov    %rax,%rcx
   4188d:	48 8d 05 ec da 00 00 	lea    0xdaec(%rip),%rax        # 4f380 <interrupt_descriptors>
   41894:	48 01 c8             	add    %rcx,%rax
   41897:	48 89 d1             	mov    %rdx,%rcx
   4189a:	ba 00 00 00 00       	mov    $0x0,%edx
   4189f:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   418a6:	0e 00 00 
   418a9:	48 89 c7             	mov    %rax,%rdi
   418ac:	e8 2b fe ff ff       	call   416dc <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   418b1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   418b5:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   418bc:	76 bb                	jbe    41879 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   418be:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   418c5:	48 89 c1             	mov    %rax,%rcx
   418c8:	ba 00 00 00 00       	mov    $0x0,%edx
   418cd:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418d4:	0e 00 00 
   418d7:	48 89 c6             	mov    %rax,%rsi
   418da:	48 8d 05 9f dc 00 00 	lea    0xdc9f(%rip),%rax        # 4f580 <interrupt_descriptors+0x200>
   418e1:	48 89 c7             	mov    %rax,%rdi
   418e4:	e8 f3 fd ff ff       	call   416dc <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   418e9:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   418f0:	48 89 c1             	mov    %rax,%rcx
   418f3:	ba 00 00 00 00       	mov    $0x0,%edx
   418f8:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418ff:	0e 00 00 
   41902:	48 89 c6             	mov    %rax,%rsi
   41905:	48 8d 05 44 db 00 00 	lea    0xdb44(%rip),%rax        # 4f450 <interrupt_descriptors+0xd0>
   4190c:	48 89 c7             	mov    %rax,%rdi
   4190f:	e8 c8 fd ff ff       	call   416dc <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41914:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   4191b:	48 89 c1             	mov    %rax,%rcx
   4191e:	ba 00 00 00 00       	mov    $0x0,%edx
   41923:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4192a:	0e 00 00 
   4192d:	48 89 c6             	mov    %rax,%rsi
   41930:	48 8d 05 29 db 00 00 	lea    0xdb29(%rip),%rax        # 4f460 <interrupt_descriptors+0xe0>
   41937:	48 89 c7             	mov    %rax,%rdi
   4193a:	e8 9d fd ff ff       	call   416dc <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4193f:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41946:	eb 50                	jmp    41998 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41948:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4194b:	83 e8 30             	sub    $0x30,%eax
   4194e:	89 c0                	mov    %eax,%eax
   41950:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   41957:	00 
   41958:	48 8d 05 88 e7 ff ff 	lea    -0x1878(%rip),%rax        # 400e7 <sys_int_handlers>
   4195f:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41963:	48 89 c2             	mov    %rax,%rdx
   41966:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41969:	48 c1 e0 04          	shl    $0x4,%rax
   4196d:	48 89 c1             	mov    %rax,%rcx
   41970:	48 8d 05 09 da 00 00 	lea    0xda09(%rip),%rax        # 4f380 <interrupt_descriptors>
   41977:	48 01 c8             	add    %rcx,%rax
   4197a:	48 89 d1             	mov    %rdx,%rcx
   4197d:	ba 03 00 00 00       	mov    $0x3,%edx
   41982:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41989:	0e 00 00 
   4198c:	48 89 c7             	mov    %rax,%rdi
   4198f:	e8 48 fd ff ff       	call   416dc <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41994:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41998:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   4199c:	76 aa                	jbe    41948 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4199e:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   419a4:	48 8d 05 d5 d9 00 00 	lea    0xd9d5(%rip),%rax        # 4f380 <interrupt_descriptors>
   419ab:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   419af:	b8 28 00 00 00       	mov    $0x28,%eax
   419b4:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   419b8:	0f 00 d8             	ltr    %ax
   419bb:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   419bf:	0f 20 c0             	mov    %cr0,%rax
   419c2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   419c6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   419ca:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   419cd:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   419d4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   419d7:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   419da:	8b 45 f0             	mov    -0x10(%rbp),%eax
   419dd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   419e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   419e5:	0f 22 c0             	mov    %rax,%cr0
}
   419e8:	90                   	nop
    lcr0(cr0);
}
   419e9:	90                   	nop
   419ea:	c9                   	leave  
   419eb:	c3                   	ret    

00000000000419ec <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   419ec:	f3 0f 1e fa          	endbr64 
   419f0:	55                   	push   %rbp
   419f1:	48 89 e5             	mov    %rsp,%rbp
   419f4:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   419f8:	0f b7 05 e1 e9 00 00 	movzwl 0xe9e1(%rip),%eax        # 503e0 <interrupts_enabled>
   419ff:	f7 d0                	not    %eax
   41a01:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41a05:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a09:	0f b6 c0             	movzbl %al,%eax
   41a0c:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41a13:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a16:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41a1a:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41a1d:	ee                   	out    %al,(%dx)
}
   41a1e:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41a1f:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a23:	66 c1 e8 08          	shr    $0x8,%ax
   41a27:	0f b6 c0             	movzbl %al,%eax
   41a2a:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41a31:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a34:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41a38:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41a3b:	ee                   	out    %al,(%dx)
}
   41a3c:	90                   	nop
}
   41a3d:	90                   	nop
   41a3e:	c9                   	leave  
   41a3f:	c3                   	ret    

0000000000041a40 <interrupt_init>:

void interrupt_init(void) {
   41a40:	f3 0f 1e fa          	endbr64 
   41a44:	55                   	push   %rbp
   41a45:	48 89 e5             	mov    %rsp,%rbp
   41a48:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41a4c:	66 c7 05 8b e9 00 00 	movw   $0x0,0xe98b(%rip)        # 503e0 <interrupts_enabled>
   41a53:	00 00 
    interrupt_mask();
   41a55:	e8 92 ff ff ff       	call   419ec <interrupt_mask>
   41a5a:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41a61:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a65:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41a69:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41a6c:	ee                   	out    %al,(%dx)
}
   41a6d:	90                   	nop
   41a6e:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41a75:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a79:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41a7d:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41a80:	ee                   	out    %al,(%dx)
}
   41a81:	90                   	nop
   41a82:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41a89:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a8d:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41a91:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41a94:	ee                   	out    %al,(%dx)
}
   41a95:	90                   	nop
   41a96:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41a9d:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aa1:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41aa5:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41aa8:	ee                   	out    %al,(%dx)
}
   41aa9:	90                   	nop
   41aaa:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41ab1:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ab5:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41ab9:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41abc:	ee                   	out    %al,(%dx)
}
   41abd:	90                   	nop
   41abe:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41ac5:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ac9:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41acd:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41ad0:	ee                   	out    %al,(%dx)
}
   41ad1:	90                   	nop
   41ad2:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41ad9:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41add:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41ae1:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41ae4:	ee                   	out    %al,(%dx)
}
   41ae5:	90                   	nop
   41ae6:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41aed:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41af1:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41af5:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41af8:	ee                   	out    %al,(%dx)
}
   41af9:	90                   	nop
   41afa:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41b01:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b05:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41b09:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41b0c:	ee                   	out    %al,(%dx)
}
   41b0d:	90                   	nop
   41b0e:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41b15:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b19:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b1d:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b20:	ee                   	out    %al,(%dx)
}
   41b21:	90                   	nop
   41b22:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41b29:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b2d:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b31:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b34:	ee                   	out    %al,(%dx)
}
   41b35:	90                   	nop
   41b36:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41b3d:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b41:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b45:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b48:	ee                   	out    %al,(%dx)
}
   41b49:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41b4a:	e8 9d fe ff ff       	call   419ec <interrupt_mask>
}
   41b4f:	90                   	nop
   41b50:	c9                   	leave  
   41b51:	c3                   	ret    

0000000000041b52 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41b52:	f3 0f 1e fa          	endbr64 
   41b56:	55                   	push   %rbp
   41b57:	48 89 e5             	mov    %rsp,%rbp
   41b5a:	48 83 ec 28          	sub    $0x28,%rsp
   41b5e:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41b61:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41b65:	0f 8e 9f 00 00 00    	jle    41c0a <timer_init+0xb8>
   41b6b:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41b72:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b76:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b7a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b7d:	ee                   	out    %al,(%dx)
}
   41b7e:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41b7f:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b82:	89 c2                	mov    %eax,%edx
   41b84:	c1 ea 1f             	shr    $0x1f,%edx
   41b87:	01 d0                	add    %edx,%eax
   41b89:	d1 f8                	sar    %eax
   41b8b:	05 de 34 12 00       	add    $0x1234de,%eax
   41b90:	99                   	cltd   
   41b91:	f7 7d dc             	idivl  -0x24(%rbp)
   41b94:	89 c2                	mov    %eax,%edx
   41b96:	89 d0                	mov    %edx,%eax
   41b98:	c1 f8 1f             	sar    $0x1f,%eax
   41b9b:	c1 e8 18             	shr    $0x18,%eax
   41b9e:	89 c1                	mov    %eax,%ecx
   41ba0:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41ba3:	0f b6 c0             	movzbl %al,%eax
   41ba6:	29 c8                	sub    %ecx,%eax
   41ba8:	0f b6 c0             	movzbl %al,%eax
   41bab:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41bb2:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bb5:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41bb9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41bbc:	ee                   	out    %al,(%dx)
}
   41bbd:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41bbe:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41bc1:	89 c2                	mov    %eax,%edx
   41bc3:	c1 ea 1f             	shr    $0x1f,%edx
   41bc6:	01 d0                	add    %edx,%eax
   41bc8:	d1 f8                	sar    %eax
   41bca:	05 de 34 12 00       	add    $0x1234de,%eax
   41bcf:	99                   	cltd   
   41bd0:	f7 7d dc             	idivl  -0x24(%rbp)
   41bd3:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41bd9:	85 c0                	test   %eax,%eax
   41bdb:	0f 48 c2             	cmovs  %edx,%eax
   41bde:	c1 f8 08             	sar    $0x8,%eax
   41be1:	0f b6 c0             	movzbl %al,%eax
   41be4:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41beb:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bee:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41bf2:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41bf5:	ee                   	out    %al,(%dx)
}
   41bf6:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41bf7:	0f b7 05 e2 e7 00 00 	movzwl 0xe7e2(%rip),%eax        # 503e0 <interrupts_enabled>
   41bfe:	83 c8 01             	or     $0x1,%eax
   41c01:	66 89 05 d8 e7 00 00 	mov    %ax,0xe7d8(%rip)        # 503e0 <interrupts_enabled>
   41c08:	eb 11                	jmp    41c1b <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41c0a:	0f b7 05 cf e7 00 00 	movzwl 0xe7cf(%rip),%eax        # 503e0 <interrupts_enabled>
   41c11:	83 e0 fe             	and    $0xfffffffe,%eax
   41c14:	66 89 05 c5 e7 00 00 	mov    %ax,0xe7c5(%rip)        # 503e0 <interrupts_enabled>
    }
    interrupt_mask();
   41c1b:	e8 cc fd ff ff       	call   419ec <interrupt_mask>
}
   41c20:	90                   	nop
   41c21:	c9                   	leave  
   41c22:	c3                   	ret    

0000000000041c23 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41c23:	f3 0f 1e fa          	endbr64 
   41c27:	55                   	push   %rbp
   41c28:	48 89 e5             	mov    %rsp,%rbp
   41c2b:	48 83 ec 08          	sub    $0x8,%rsp
   41c2f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41c33:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41c38:	74 14                	je     41c4e <physical_memory_isreserved+0x2b>
   41c3a:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41c41:	00 
   41c42:	76 11                	jbe    41c55 <physical_memory_isreserved+0x32>
   41c44:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41c4b:	00 
   41c4c:	77 07                	ja     41c55 <physical_memory_isreserved+0x32>
   41c4e:	b8 01 00 00 00       	mov    $0x1,%eax
   41c53:	eb 05                	jmp    41c5a <physical_memory_isreserved+0x37>
   41c55:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41c5a:	c9                   	leave  
   41c5b:	c3                   	ret    

0000000000041c5c <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41c5c:	f3 0f 1e fa          	endbr64 
   41c60:	55                   	push   %rbp
   41c61:	48 89 e5             	mov    %rsp,%rbp
   41c64:	48 83 ec 10          	sub    $0x10,%rsp
   41c68:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41c6b:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41c6e:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41c71:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c74:	c1 e0 10             	shl    $0x10,%eax
   41c77:	89 c2                	mov    %eax,%edx
   41c79:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c7c:	c1 e0 0b             	shl    $0xb,%eax
   41c7f:	09 c2                	or     %eax,%edx
   41c81:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c84:	c1 e0 08             	shl    $0x8,%eax
   41c87:	09 d0                	or     %edx,%eax
}
   41c89:	c9                   	leave  
   41c8a:	c3                   	ret    

0000000000041c8b <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41c8b:	f3 0f 1e fa          	endbr64 
   41c8f:	55                   	push   %rbp
   41c90:	48 89 e5             	mov    %rsp,%rbp
   41c93:	48 83 ec 18          	sub    $0x18,%rsp
   41c97:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41c9a:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41c9d:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ca0:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41ca3:	09 d0                	or     %edx,%eax
   41ca5:	0d 00 00 00 80       	or     $0x80000000,%eax
   41caa:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41cb1:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41cb4:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cb7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cba:	ef                   	out    %eax,(%dx)
}
   41cbb:	90                   	nop
   41cbc:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41cc3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41cc6:	89 c2                	mov    %eax,%edx
   41cc8:	ed                   	in     (%dx),%eax
   41cc9:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41ccc:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41ccf:	c9                   	leave  
   41cd0:	c3                   	ret    

0000000000041cd1 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41cd1:	f3 0f 1e fa          	endbr64 
   41cd5:	55                   	push   %rbp
   41cd6:	48 89 e5             	mov    %rsp,%rbp
   41cd9:	48 83 ec 28          	sub    $0x28,%rsp
   41cdd:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41ce0:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41ce3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41cea:	eb 73                	jmp    41d5f <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   41cec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41cf3:	eb 60                	jmp    41d55 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   41cf5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41cfc:	eb 4a                	jmp    41d48 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41cfe:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d01:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41d04:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d07:	89 ce                	mov    %ecx,%esi
   41d09:	89 c7                	mov    %eax,%edi
   41d0b:	e8 4c ff ff ff       	call   41c5c <pci_make_configaddr>
   41d10:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41d13:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d16:	be 00 00 00 00       	mov    $0x0,%esi
   41d1b:	89 c7                	mov    %eax,%edi
   41d1d:	e8 69 ff ff ff       	call   41c8b <pci_config_readl>
   41d22:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41d25:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41d28:	c1 e0 10             	shl    $0x10,%eax
   41d2b:	0b 45 dc             	or     -0x24(%rbp),%eax
   41d2e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41d31:	75 05                	jne    41d38 <pci_find_device+0x67>
                    return configaddr;
   41d33:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d36:	eb 35                	jmp    41d6d <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41d38:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41d3c:	75 06                	jne    41d44 <pci_find_device+0x73>
   41d3e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41d42:	74 0c                	je     41d50 <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   41d44:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41d48:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41d4c:	75 b0                	jne    41cfe <pci_find_device+0x2d>
   41d4e:	eb 01                	jmp    41d51 <pci_find_device+0x80>
                    break;
   41d50:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41d51:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41d55:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41d59:	75 9a                	jne    41cf5 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   41d5b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41d5f:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41d66:	75 84                	jne    41cec <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   41d68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41d6d:	c9                   	leave  
   41d6e:	c3                   	ret    

0000000000041d6f <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41d6f:	f3 0f 1e fa          	endbr64 
   41d73:	55                   	push   %rbp
   41d74:	48 89 e5             	mov    %rsp,%rbp
   41d77:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41d7b:	be 13 71 00 00       	mov    $0x7113,%esi
   41d80:	bf 86 80 00 00       	mov    $0x8086,%edi
   41d85:	e8 47 ff ff ff       	call   41cd1 <pci_find_device>
   41d8a:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41d8d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41d91:	78 30                	js     41dc3 <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41d93:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d96:	be 40 00 00 00       	mov    $0x40,%esi
   41d9b:	89 c7                	mov    %eax,%edi
   41d9d:	e8 e9 fe ff ff       	call   41c8b <pci_config_readl>
   41da2:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41da7:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41daa:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41dad:	83 c0 04             	add    $0x4,%eax
   41db0:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41db3:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41db9:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41dbd:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41dc0:	66 ef                	out    %ax,(%dx)
}
   41dc2:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41dc3:	48 8d 05 56 34 00 00 	lea    0x3456(%rip),%rax        # 45220 <memstate_colors+0x3a0>
   41dca:	48 89 c2             	mov    %rax,%rdx
   41dcd:	be 00 c0 00 00       	mov    $0xc000,%esi
   41dd2:	bf 80 07 00 00       	mov    $0x780,%edi
   41dd7:	b8 00 00 00 00       	mov    $0x0,%eax
   41ddc:	e8 d2 2e 00 00       	call   44cb3 <console_printf>
 spinloop: goto spinloop;
   41de1:	eb fe                	jmp    41de1 <poweroff+0x72>

0000000000041de3 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41de3:	f3 0f 1e fa          	endbr64 
   41de7:	55                   	push   %rbp
   41de8:	48 89 e5             	mov    %rsp,%rbp
   41deb:	48 83 ec 10          	sub    $0x10,%rsp
   41def:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41df6:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dfa:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41dfe:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e01:	ee                   	out    %al,(%dx)
}
   41e02:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41e03:	eb fe                	jmp    41e03 <reboot+0x20>

0000000000041e05 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41e05:	f3 0f 1e fa          	endbr64 
   41e09:	55                   	push   %rbp
   41e0a:	48 89 e5             	mov    %rsp,%rbp
   41e0d:	48 83 ec 10          	sub    $0x10,%rsp
   41e11:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e15:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41e18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e1c:	48 83 c0 18          	add    $0x18,%rax
   41e20:	ba c0 00 00 00       	mov    $0xc0,%edx
   41e25:	be 00 00 00 00       	mov    $0x0,%esi
   41e2a:	48 89 c7             	mov    %rax,%rdi
   41e2d:	e8 42 20 00 00       	call   43e74 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41e32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e36:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41e3d:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41e3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e43:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41e4a:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41e4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e52:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41e59:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41e5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e61:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41e68:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41e6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e6e:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41e75:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41e79:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e7c:	83 e0 01             	and    $0x1,%eax
   41e7f:	85 c0                	test   %eax,%eax
   41e81:	74 1c                	je     41e9f <process_init+0x9a>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41e83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e87:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e8e:	80 cc 30             	or     $0x30,%ah
   41e91:	48 89 c2             	mov    %rax,%rdx
   41e94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e98:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41e9f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41ea2:	83 e0 02             	and    $0x2,%eax
   41ea5:	85 c0                	test   %eax,%eax
   41ea7:	74 1c                	je     41ec5 <process_init+0xc0>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41ea9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ead:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41eb4:	80 e4 fd             	and    $0xfd,%ah
   41eb7:	48 89 c2             	mov    %rax,%rdx
   41eba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ebe:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41ec5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ec9:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41ed0:	90                   	nop
   41ed1:	c9                   	leave  
   41ed2:	c3                   	ret    

0000000000041ed3 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41ed3:	f3 0f 1e fa          	endbr64 
   41ed7:	55                   	push   %rbp
   41ed8:	48 89 e5             	mov    %rsp,%rbp
   41edb:	48 83 ec 28          	sub    $0x28,%rsp
   41edf:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41ee2:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41ee6:	78 09                	js     41ef1 <console_show_cursor+0x1e>
   41ee8:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41eef:	7e 07                	jle    41ef8 <console_show_cursor+0x25>
        cpos = 0;
   41ef1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41ef8:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41eff:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f03:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41f07:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41f0a:	ee                   	out    %al,(%dx)
}
   41f0b:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41f0c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f0f:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41f15:	85 c0                	test   %eax,%eax
   41f17:	0f 48 c2             	cmovs  %edx,%eax
   41f1a:	c1 f8 08             	sar    $0x8,%eax
   41f1d:	0f b6 c0             	movzbl %al,%eax
   41f20:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41f27:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f2a:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41f2e:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f31:	ee                   	out    %al,(%dx)
}
   41f32:	90                   	nop
   41f33:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41f3a:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f3e:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41f42:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f45:	ee                   	out    %al,(%dx)
}
   41f46:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41f47:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f4a:	99                   	cltd   
   41f4b:	c1 ea 18             	shr    $0x18,%edx
   41f4e:	01 d0                	add    %edx,%eax
   41f50:	0f b6 c0             	movzbl %al,%eax
   41f53:	29 d0                	sub    %edx,%eax
   41f55:	0f b6 c0             	movzbl %al,%eax
   41f58:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41f5f:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f62:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f66:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f69:	ee                   	out    %al,(%dx)
}
   41f6a:	90                   	nop
}
   41f6b:	90                   	nop
   41f6c:	c9                   	leave  
   41f6d:	c3                   	ret    

0000000000041f6e <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41f6e:	f3 0f 1e fa          	endbr64 
   41f72:	55                   	push   %rbp
   41f73:	48 89 e5             	mov    %rsp,%rbp
   41f76:	48 83 ec 20          	sub    $0x20,%rsp
   41f7a:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f81:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f84:	89 c2                	mov    %eax,%edx
   41f86:	ec                   	in     (%dx),%al
   41f87:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41f8a:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41f8e:	0f b6 c0             	movzbl %al,%eax
   41f91:	83 e0 01             	and    $0x1,%eax
   41f94:	85 c0                	test   %eax,%eax
   41f96:	75 0a                	jne    41fa2 <keyboard_readc+0x34>
        return -1;
   41f98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41f9d:	e9 fd 01 00 00       	jmp    4219f <keyboard_readc+0x231>
   41fa2:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41fa9:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41fac:	89 c2                	mov    %eax,%edx
   41fae:	ec                   	in     (%dx),%al
   41faf:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41fb2:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41fb6:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41fb9:	0f b6 05 22 e4 00 00 	movzbl 0xe422(%rip),%eax        # 503e2 <last_escape.2>
   41fc0:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41fc3:	c6 05 18 e4 00 00 00 	movb   $0x0,0xe418(%rip)        # 503e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41fca:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41fce:	75 11                	jne    41fe1 <keyboard_readc+0x73>
        last_escape = 0x80;
   41fd0:	c6 05 0b e4 00 00 80 	movb   $0x80,0xe40b(%rip)        # 503e2 <last_escape.2>
        return 0;
   41fd7:	b8 00 00 00 00       	mov    $0x0,%eax
   41fdc:	e9 be 01 00 00       	jmp    4219f <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41fe1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fe5:	84 c0                	test   %al,%al
   41fe7:	79 64                	jns    4204d <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   41fe9:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fed:	83 e0 7f             	and    $0x7f,%eax
   41ff0:	89 c2                	mov    %eax,%edx
   41ff2:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41ff6:	09 d0                	or     %edx,%eax
   41ff8:	48 98                	cltq   
   41ffa:	48 8d 15 3f 32 00 00 	lea    0x323f(%rip),%rdx        # 45240 <keymap>
   42001:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42005:	0f b6 c0             	movzbl %al,%eax
   42008:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   4200b:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42012:	7e 2f                	jle    42043 <keyboard_readc+0xd5>
   42014:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   4201b:	7f 26                	jg     42043 <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   4201d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42020:	2d fa 00 00 00       	sub    $0xfa,%eax
   42025:	ba 01 00 00 00       	mov    $0x1,%edx
   4202a:	89 c1                	mov    %eax,%ecx
   4202c:	d3 e2                	shl    %cl,%edx
   4202e:	89 d0                	mov    %edx,%eax
   42030:	f7 d0                	not    %eax
   42032:	89 c2                	mov    %eax,%edx
   42034:	0f b6 05 a8 e3 00 00 	movzbl 0xe3a8(%rip),%eax        # 503e3 <modifiers.1>
   4203b:	21 d0                	and    %edx,%eax
   4203d:	88 05 a0 e3 00 00    	mov    %al,0xe3a0(%rip)        # 503e3 <modifiers.1>
        }
        return 0;
   42043:	b8 00 00 00 00       	mov    $0x0,%eax
   42048:	e9 52 01 00 00       	jmp    4219f <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   4204d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42051:	0a 45 fa             	or     -0x6(%rbp),%al
   42054:	0f b6 c0             	movzbl %al,%eax
   42057:	48 98                	cltq   
   42059:	48 8d 15 e0 31 00 00 	lea    0x31e0(%rip),%rdx        # 45240 <keymap>
   42060:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42064:	0f b6 c0             	movzbl %al,%eax
   42067:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   4206a:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4206e:	7e 57                	jle    420c7 <keyboard_readc+0x159>
   42070:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42074:	7f 51                	jg     420c7 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   42076:	0f b6 05 66 e3 00 00 	movzbl 0xe366(%rip),%eax        # 503e3 <modifiers.1>
   4207d:	0f b6 c0             	movzbl %al,%eax
   42080:	83 e0 02             	and    $0x2,%eax
   42083:	85 c0                	test   %eax,%eax
   42085:	74 09                	je     42090 <keyboard_readc+0x122>
            ch -= 0x60;
   42087:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4208b:	e9 0b 01 00 00       	jmp    4219b <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42090:	0f b6 05 4c e3 00 00 	movzbl 0xe34c(%rip),%eax        # 503e3 <modifiers.1>
   42097:	0f b6 c0             	movzbl %al,%eax
   4209a:	83 e0 01             	and    $0x1,%eax
   4209d:	85 c0                	test   %eax,%eax
   4209f:	0f 94 c2             	sete   %dl
   420a2:	0f b6 05 3a e3 00 00 	movzbl 0xe33a(%rip),%eax        # 503e3 <modifiers.1>
   420a9:	0f b6 c0             	movzbl %al,%eax
   420ac:	83 e0 08             	and    $0x8,%eax
   420af:	85 c0                	test   %eax,%eax
   420b1:	0f 94 c0             	sete   %al
   420b4:	31 d0                	xor    %edx,%eax
   420b6:	84 c0                	test   %al,%al
   420b8:	0f 84 dd 00 00 00    	je     4219b <keyboard_readc+0x22d>
            ch -= 0x20;
   420be:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   420c2:	e9 d4 00 00 00       	jmp    4219b <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   420c7:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   420ce:	7e 30                	jle    42100 <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   420d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420d3:	2d fa 00 00 00       	sub    $0xfa,%eax
   420d8:	ba 01 00 00 00       	mov    $0x1,%edx
   420dd:	89 c1                	mov    %eax,%ecx
   420df:	d3 e2                	shl    %cl,%edx
   420e1:	89 d0                	mov    %edx,%eax
   420e3:	89 c2                	mov    %eax,%edx
   420e5:	0f b6 05 f7 e2 00 00 	movzbl 0xe2f7(%rip),%eax        # 503e3 <modifiers.1>
   420ec:	31 d0                	xor    %edx,%eax
   420ee:	88 05 ef e2 00 00    	mov    %al,0xe2ef(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   420f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   420fb:	e9 9c 00 00 00       	jmp    4219c <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   42100:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42107:	7e 2d                	jle    42136 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42109:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4210c:	2d fa 00 00 00       	sub    $0xfa,%eax
   42111:	ba 01 00 00 00       	mov    $0x1,%edx
   42116:	89 c1                	mov    %eax,%ecx
   42118:	d3 e2                	shl    %cl,%edx
   4211a:	89 d0                	mov    %edx,%eax
   4211c:	89 c2                	mov    %eax,%edx
   4211e:	0f b6 05 be e2 00 00 	movzbl 0xe2be(%rip),%eax        # 503e3 <modifiers.1>
   42125:	09 d0                	or     %edx,%eax
   42127:	88 05 b6 e2 00 00    	mov    %al,0xe2b6(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   4212d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42134:	eb 66                	jmp    4219c <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42136:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4213a:	7e 3f                	jle    4217b <keyboard_readc+0x20d>
   4213c:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42143:	7f 36                	jg     4217b <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42145:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42148:	8d 50 80             	lea    -0x80(%rax),%edx
   4214b:	0f b6 05 91 e2 00 00 	movzbl 0xe291(%rip),%eax        # 503e3 <modifiers.1>
   42152:	0f b6 c0             	movzbl %al,%eax
   42155:	83 e0 03             	and    $0x3,%eax
   42158:	48 63 c8             	movslq %eax,%rcx
   4215b:	48 63 c2             	movslq %edx,%rax
   4215e:	48 c1 e0 02          	shl    $0x2,%rax
   42162:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   42166:	48 8d 05 d3 31 00 00 	lea    0x31d3(%rip),%rax        # 45340 <complex_keymap>
   4216d:	48 01 d0             	add    %rdx,%rax
   42170:	0f b6 00             	movzbl (%rax),%eax
   42173:	0f b6 c0             	movzbl %al,%eax
   42176:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42179:	eb 21                	jmp    4219c <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   4217b:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4217f:	7f 1b                	jg     4219c <keyboard_readc+0x22e>
   42181:	0f b6 05 5b e2 00 00 	movzbl 0xe25b(%rip),%eax        # 503e3 <modifiers.1>
   42188:	0f b6 c0             	movzbl %al,%eax
   4218b:	83 e0 02             	and    $0x2,%eax
   4218e:	85 c0                	test   %eax,%eax
   42190:	74 0a                	je     4219c <keyboard_readc+0x22e>
        ch = 0;
   42192:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42199:	eb 01                	jmp    4219c <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   4219b:	90                   	nop
    }

    return ch;
   4219c:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4219f:	c9                   	leave  
   421a0:	c3                   	ret    

00000000000421a1 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   421a1:	f3 0f 1e fa          	endbr64 
   421a5:	55                   	push   %rbp
   421a6:	48 89 e5             	mov    %rsp,%rbp
   421a9:	48 83 ec 20          	sub    $0x20,%rsp
   421ad:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421b4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   421b7:	89 c2                	mov    %eax,%edx
   421b9:	ec                   	in     (%dx),%al
   421ba:	88 45 e3             	mov    %al,-0x1d(%rbp)
   421bd:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   421c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   421c7:	89 c2                	mov    %eax,%edx
   421c9:	ec                   	in     (%dx),%al
   421ca:	88 45 eb             	mov    %al,-0x15(%rbp)
   421cd:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   421d4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   421d7:	89 c2                	mov    %eax,%edx
   421d9:	ec                   	in     (%dx),%al
   421da:	88 45 f3             	mov    %al,-0xd(%rbp)
   421dd:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   421e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421e7:	89 c2                	mov    %eax,%edx
   421e9:	ec                   	in     (%dx),%al
   421ea:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   421ed:	90                   	nop
   421ee:	c9                   	leave  
   421ef:	c3                   	ret    

00000000000421f0 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   421f0:	f3 0f 1e fa          	endbr64 
   421f4:	55                   	push   %rbp
   421f5:	48 89 e5             	mov    %rsp,%rbp
   421f8:	48 83 ec 40          	sub    $0x40,%rsp
   421fc:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42200:	89 f0                	mov    %esi,%eax
   42202:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42205:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42208:	8b 05 d6 e1 00 00    	mov    0xe1d6(%rip),%eax        # 503e4 <initialized.0>
   4220e:	85 c0                	test   %eax,%eax
   42210:	75 1e                	jne    42230 <parallel_port_putc+0x40>
   42212:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42219:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4221d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42221:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42224:	ee                   	out    %al,(%dx)
}
   42225:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42226:	c7 05 b4 e1 00 00 01 	movl   $0x1,0xe1b4(%rip)        # 503e4 <initialized.0>
   4222d:	00 00 00 
    }

    for (int i = 0;
   42230:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42237:	eb 09                	jmp    42242 <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42239:	e8 63 ff ff ff       	call   421a1 <delay>
         ++i) {
   4223e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42242:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42249:	7f 18                	jg     42263 <parallel_port_putc+0x73>
   4224b:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42252:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42255:	89 c2                	mov    %eax,%edx
   42257:	ec                   	in     (%dx),%al
   42258:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4225b:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4225f:	84 c0                	test   %al,%al
   42261:	79 d6                	jns    42239 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   42263:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42267:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4226e:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42271:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42275:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42278:	ee                   	out    %al,(%dx)
}
   42279:	90                   	nop
   4227a:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42281:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42285:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42289:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4228c:	ee                   	out    %al,(%dx)
}
   4228d:	90                   	nop
   4228e:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42295:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42299:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4229d:	8b 55 e8             	mov    -0x18(%rbp),%edx
   422a0:	ee                   	out    %al,(%dx)
}
   422a1:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   422a2:	90                   	nop
   422a3:	c9                   	leave  
   422a4:	c3                   	ret    

00000000000422a5 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   422a5:	f3 0f 1e fa          	endbr64 
   422a9:	55                   	push   %rbp
   422aa:	48 89 e5             	mov    %rsp,%rbp
   422ad:	48 83 ec 20          	sub    $0x20,%rsp
   422b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   422b5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   422b9:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 421f0 <parallel_port_putc>
   422c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   422c4:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   422c8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   422cc:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   422d0:	be 00 00 00 00       	mov    $0x0,%esi
   422d5:	48 89 c7             	mov    %rax,%rdi
   422d8:	e8 5d 1e 00 00       	call   4413a <printer_vprintf>
}
   422dd:	90                   	nop
   422de:	c9                   	leave  
   422df:	c3                   	ret    

00000000000422e0 <log_printf>:

void log_printf(const char* format, ...) {
   422e0:	f3 0f 1e fa          	endbr64 
   422e4:	55                   	push   %rbp
   422e5:	48 89 e5             	mov    %rsp,%rbp
   422e8:	48 83 ec 60          	sub    $0x60,%rsp
   422ec:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   422f0:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   422f4:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   422f8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   422fc:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42300:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42304:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4230b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4230f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42313:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42317:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4231b:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4231f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42323:	48 89 d6             	mov    %rdx,%rsi
   42326:	48 89 c7             	mov    %rax,%rdi
   42329:	e8 77 ff ff ff       	call   422a5 <log_vprintf>
    va_end(val);
}
   4232e:	90                   	nop
   4232f:	c9                   	leave  
   42330:	c3                   	ret    

0000000000042331 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42331:	f3 0f 1e fa          	endbr64 
   42335:	55                   	push   %rbp
   42336:	48 89 e5             	mov    %rsp,%rbp
   42339:	48 83 ec 40          	sub    $0x40,%rsp
   4233d:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42340:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42343:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42347:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4234b:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4234f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42353:	48 8b 0a             	mov    (%rdx),%rcx
   42356:	48 89 08             	mov    %rcx,(%rax)
   42359:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4235d:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42361:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42365:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42369:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4236d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42371:	48 89 d6             	mov    %rdx,%rsi
   42374:	48 89 c7             	mov    %rax,%rdi
   42377:	e8 29 ff ff ff       	call   422a5 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4237c:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42380:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42384:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42387:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4238a:	89 c7                	mov    %eax,%edi
   4238c:	e8 a6 28 00 00       	call   44c37 <console_vprintf>
}
   42391:	c9                   	leave  
   42392:	c3                   	ret    

0000000000042393 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42393:	f3 0f 1e fa          	endbr64 
   42397:	55                   	push   %rbp
   42398:	48 89 e5             	mov    %rsp,%rbp
   4239b:	48 83 ec 60          	sub    $0x60,%rsp
   4239f:	89 7d ac             	mov    %edi,-0x54(%rbp)
   423a2:	89 75 a8             	mov    %esi,-0x58(%rbp)
   423a5:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   423a9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   423ad:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   423b1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   423b5:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   423bc:	48 8d 45 10          	lea    0x10(%rbp),%rax
   423c0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   423c4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   423c8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   423cc:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   423d0:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   423d4:	8b 75 a8             	mov    -0x58(%rbp),%esi
   423d7:	8b 45 ac             	mov    -0x54(%rbp),%eax
   423da:	89 c7                	mov    %eax,%edi
   423dc:	e8 50 ff ff ff       	call   42331 <error_vprintf>
   423e1:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   423e4:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   423e7:	c9                   	leave  
   423e8:	c3                   	ret    

00000000000423e9 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   423e9:	f3 0f 1e fa          	endbr64 
   423ed:	55                   	push   %rbp
   423ee:	48 89 e5             	mov    %rsp,%rbp
   423f1:	53                   	push   %rbx
   423f2:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   423f6:	e8 73 fb ff ff       	call   41f6e <keyboard_readc>
   423fb:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   423fe:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42402:	74 1c                	je     42420 <check_keyboard+0x37>
   42404:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   42408:	74 16                	je     42420 <check_keyboard+0x37>
   4240a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   4240e:	74 10                	je     42420 <check_keyboard+0x37>
   42410:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42414:	74 0a                	je     42420 <check_keyboard+0x37>
   42416:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4241a:	0f 85 02 01 00 00    	jne    42522 <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42420:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42427:	00 
        memset(pt, 0, PAGESIZE * 3);
   42428:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4242c:	ba 00 30 00 00       	mov    $0x3000,%edx
   42431:	be 00 00 00 00       	mov    $0x0,%esi
   42436:	48 89 c7             	mov    %rax,%rdi
   42439:	e8 36 1a 00 00       	call   43e74 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   4243e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42442:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42449:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4244d:	48 05 00 10 00 00    	add    $0x1000,%rax
   42453:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   4245a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4245e:	48 05 00 20 00 00    	add    $0x2000,%rax
   42464:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   4246b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4246f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42473:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42477:	0f 22 d8             	mov    %rax,%cr3
}
   4247a:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   4247b:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   42482:	48 8d 05 0f 2f 00 00 	lea    0x2f0f(%rip),%rax        # 45398 <complex_keymap+0x58>
   42489:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   4248d:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42491:	75 0d                	jne    424a0 <check_keyboard+0xb7>
            argument = "allocator";
   42493:	48 8d 05 05 2f 00 00 	lea    0x2f05(%rip),%rax        # 4539f <complex_keymap+0x5f>
   4249a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4249e:	eb 37                	jmp    424d7 <check_keyboard+0xee>
        } else if (c == 'c') {
   424a0:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   424a4:	75 0d                	jne    424b3 <check_keyboard+0xca>
            argument = "alloctests";
   424a6:	48 8d 05 fc 2e 00 00 	lea    0x2efc(%rip),%rax        # 453a9 <complex_keymap+0x69>
   424ad:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   424b1:	eb 24                	jmp    424d7 <check_keyboard+0xee>
        } else if(c == 't'){
   424b3:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   424b7:	75 0d                	jne    424c6 <check_keyboard+0xdd>
            argument = "test";
   424b9:	48 8d 05 f4 2e 00 00 	lea    0x2ef4(%rip),%rax        # 453b4 <complex_keymap+0x74>
   424c0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   424c4:	eb 11                	jmp    424d7 <check_keyboard+0xee>
        }
        else if(c == '2'){
   424c6:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   424ca:	75 0b                	jne    424d7 <check_keyboard+0xee>
            argument = "test2";
   424cc:	48 8d 05 e6 2e 00 00 	lea    0x2ee6(%rip),%rax        # 453b9 <complex_keymap+0x79>
   424d3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   424d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   424db:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   424df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   424e4:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   424e8:	76 1e                	jbe    42508 <check_keyboard+0x11f>
   424ea:	48 8d 05 ce 2e 00 00 	lea    0x2ece(%rip),%rax        # 453bf <complex_keymap+0x7f>
   424f1:	48 89 c2             	mov    %rax,%rdx
   424f4:	be 5c 02 00 00       	mov    $0x25c,%esi
   424f9:	48 8d 05 db 2e 00 00 	lea    0x2edb(%rip),%rax        # 453db <complex_keymap+0x9b>
   42500:	48 89 c7             	mov    %rax,%rdi
   42503:	e8 33 01 00 00       	call   4263b <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42508:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4250c:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   4250f:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42513:	48 89 c3             	mov    %rax,%rbx
   42516:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   4251b:	e9 e0 da ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42520:	eb 11                	jmp    42533 <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42522:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42526:	74 06                	je     4252e <check_keyboard+0x145>
   42528:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   4252c:	75 05                	jne    42533 <check_keyboard+0x14a>
        poweroff();
   4252e:	e8 3c f8 ff ff       	call   41d6f <poweroff>
    }
    return c;
   42533:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42536:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4253a:	c9                   	leave  
   4253b:	c3                   	ret    

000000000004253c <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4253c:	f3 0f 1e fa          	endbr64 
   42540:	55                   	push   %rbp
   42541:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42544:	e8 a0 fe ff ff       	call   423e9 <check_keyboard>
   42549:	eb f9                	jmp    42544 <fail+0x8>

000000000004254b <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   4254b:	f3 0f 1e fa          	endbr64 
   4254f:	55                   	push   %rbp
   42550:	48 89 e5             	mov    %rsp,%rbp
   42553:	48 83 ec 60          	sub    $0x60,%rsp
   42557:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4255b:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4255f:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42563:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42567:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4256b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4256f:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42576:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4257a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   4257e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42582:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42586:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   4258b:	0f 84 87 00 00 00    	je     42618 <kernel_panic+0xcd>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42591:	48 8d 05 57 2e 00 00 	lea    0x2e57(%rip),%rax        # 453ef <complex_keymap+0xaf>
   42598:	48 89 c2             	mov    %rax,%rdx
   4259b:	be 00 c0 00 00       	mov    $0xc000,%esi
   425a0:	bf 30 07 00 00       	mov    $0x730,%edi
   425a5:	b8 00 00 00 00       	mov    $0x0,%eax
   425aa:	e8 e4 fd ff ff       	call   42393 <error_printf>
   425af:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   425b2:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   425b6:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   425ba:	8b 45 cc             	mov    -0x34(%rbp),%eax
   425bd:	be 00 c0 00 00       	mov    $0xc000,%esi
   425c2:	89 c7                	mov    %eax,%edi
   425c4:	e8 68 fd ff ff       	call   42331 <error_vprintf>
   425c9:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   425cc:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   425cf:	48 63 c1             	movslq %ecx,%rax
   425d2:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   425d9:	48 c1 e8 20          	shr    $0x20,%rax
   425dd:	c1 f8 05             	sar    $0x5,%eax
   425e0:	89 ce                	mov    %ecx,%esi
   425e2:	c1 fe 1f             	sar    $0x1f,%esi
   425e5:	29 f0                	sub    %esi,%eax
   425e7:	89 c2                	mov    %eax,%edx
   425e9:	89 d0                	mov    %edx,%eax
   425eb:	c1 e0 02             	shl    $0x2,%eax
   425ee:	01 d0                	add    %edx,%eax
   425f0:	c1 e0 04             	shl    $0x4,%eax
   425f3:	29 c1                	sub    %eax,%ecx
   425f5:	89 ca                	mov    %ecx,%edx
   425f7:	85 d2                	test   %edx,%edx
   425f9:	74 3b                	je     42636 <kernel_panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   425fb:	8b 45 cc             	mov    -0x34(%rbp),%eax
   425fe:	48 8d 15 f2 2d 00 00 	lea    0x2df2(%rip),%rdx        # 453f7 <complex_keymap+0xb7>
   42605:	be 00 c0 00 00       	mov    $0xc000,%esi
   4260a:	89 c7                	mov    %eax,%edi
   4260c:	b8 00 00 00 00       	mov    $0x0,%eax
   42611:	e8 7d fd ff ff       	call   42393 <error_printf>
   42616:	eb 1e                	jmp    42636 <kernel_panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42618:	48 8d 05 da 2d 00 00 	lea    0x2dda(%rip),%rax        # 453f9 <complex_keymap+0xb9>
   4261f:	48 89 c2             	mov    %rax,%rdx
   42622:	be 00 c0 00 00       	mov    $0xc000,%esi
   42627:	bf 30 07 00 00       	mov    $0x730,%edi
   4262c:	b8 00 00 00 00       	mov    $0x0,%eax
   42631:	e8 5d fd ff ff       	call   42393 <error_printf>
    }

    va_end(val);
    fail();
   42636:	e8 01 ff ff ff       	call   4253c <fail>

000000000004263b <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   4263b:	f3 0f 1e fa          	endbr64 
   4263f:	55                   	push   %rbp
   42640:	48 89 e5             	mov    %rsp,%rbp
   42643:	48 83 ec 20          	sub    $0x20,%rsp
   42647:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4264b:	89 75 f4             	mov    %esi,-0xc(%rbp)
   4264e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42652:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42656:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42659:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4265d:	48 89 c6             	mov    %rax,%rsi
   42660:	48 8d 05 98 2d 00 00 	lea    0x2d98(%rip),%rax        # 453ff <complex_keymap+0xbf>
   42667:	48 89 c7             	mov    %rax,%rdi
   4266a:	b8 00 00 00 00       	mov    $0x0,%eax
   4266f:	e8 d7 fe ff ff       	call   4254b <kernel_panic>

0000000000042674 <default_exception>:
}

void default_exception(proc* p){
   42674:	f3 0f 1e fa          	endbr64 
   42678:	55                   	push   %rbp
   42679:	48 89 e5             	mov    %rsp,%rbp
   4267c:	48 83 ec 20          	sub    $0x20,%rsp
   42680:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42684:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42688:	48 83 c0 18          	add    $0x18,%rax
   4268c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   42690:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42694:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4269b:	48 89 c6             	mov    %rax,%rsi
   4269e:	48 8d 05 78 2d 00 00 	lea    0x2d78(%rip),%rax        # 4541d <complex_keymap+0xdd>
   426a5:	48 89 c7             	mov    %rax,%rdi
   426a8:	b8 00 00 00 00       	mov    $0x0,%eax
   426ad:	e8 99 fe ff ff       	call   4254b <kernel_panic>

00000000000426b2 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   426b2:	55                   	push   %rbp
   426b3:	48 89 e5             	mov    %rsp,%rbp
   426b6:	48 83 ec 10          	sub    $0x10,%rsp
   426ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   426be:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   426c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   426c5:	78 06                	js     426cd <pageindex+0x1b>
   426c7:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   426cb:	7e 1e                	jle    426eb <pageindex+0x39>
   426cd:	48 8d 05 64 2d 00 00 	lea    0x2d64(%rip),%rax        # 45438 <complex_keymap+0xf8>
   426d4:	48 89 c2             	mov    %rax,%rdx
   426d7:	be 1e 00 00 00       	mov    $0x1e,%esi
   426dc:	48 8d 05 6e 2d 00 00 	lea    0x2d6e(%rip),%rax        # 45451 <complex_keymap+0x111>
   426e3:	48 89 c7             	mov    %rax,%rdi
   426e6:	e8 50 ff ff ff       	call   4263b <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   426eb:	b8 03 00 00 00       	mov    $0x3,%eax
   426f0:	2b 45 f4             	sub    -0xc(%rbp),%eax
   426f3:	89 c2                	mov    %eax,%edx
   426f5:	89 d0                	mov    %edx,%eax
   426f7:	c1 e0 03             	shl    $0x3,%eax
   426fa:	01 d0                	add    %edx,%eax
   426fc:	83 c0 0c             	add    $0xc,%eax
   426ff:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42703:	89 c1                	mov    %eax,%ecx
   42705:	48 d3 ea             	shr    %cl,%rdx
   42708:	48 89 d0             	mov    %rdx,%rax
   4270b:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42710:	c9                   	leave  
   42711:	c3                   	ret    

0000000000042712 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42712:	f3 0f 1e fa          	endbr64 
   42716:	55                   	push   %rbp
   42717:	48 89 e5             	mov    %rsp,%rbp
   4271a:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   4271e:	48 8d 05 db f8 00 00 	lea    0xf8db(%rip),%rax        # 52000 <kernel_pagetables>
   42725:	48 89 05 d4 e8 00 00 	mov    %rax,0xe8d4(%rip)        # 51000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   4272c:	ba 00 50 00 00       	mov    $0x5000,%edx
   42731:	be 00 00 00 00       	mov    $0x0,%esi
   42736:	48 8d 05 c3 f8 00 00 	lea    0xf8c3(%rip),%rax        # 52000 <kernel_pagetables>
   4273d:	48 89 c7             	mov    %rax,%rdi
   42740:	e8 2f 17 00 00       	call   43e74 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42745:	48 8d 05 b4 08 01 00 	lea    0x108b4(%rip),%rax        # 53000 <kernel_pagetables+0x1000>
   4274c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42750:	48 89 05 a9 f8 00 00 	mov    %rax,0xf8a9(%rip)        # 52000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42757:	48 8d 05 a2 18 01 00 	lea    0x118a2(%rip),%rax        # 54000 <kernel_pagetables+0x2000>
   4275e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42762:	48 89 05 97 08 01 00 	mov    %rax,0x10897(%rip)        # 53000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42769:	48 8d 05 90 28 01 00 	lea    0x12890(%rip),%rax        # 55000 <kernel_pagetables+0x3000>
   42770:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42774:	48 89 05 85 18 01 00 	mov    %rax,0x11885(%rip)        # 54000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   4277b:	48 8d 05 7e 38 01 00 	lea    0x1387e(%rip),%rax        # 56000 <kernel_pagetables+0x4000>
   42782:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42786:	48 89 05 7b 18 01 00 	mov    %rax,0x1187b(%rip)        # 54008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4278d:	48 8b 05 6c e8 00 00 	mov    0xe86c(%rip),%rax        # 51000 <kernel_pagetable>
   42794:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4279a:	b9 00 00 20 00       	mov    $0x200000,%ecx
   4279f:	ba 00 00 00 00       	mov    $0x0,%edx
   427a4:	be 00 00 00 00       	mov    $0x0,%esi
   427a9:	48 89 c7             	mov    %rax,%rdi
   427ac:	e8 0e 02 00 00       	call   429bf <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   427b1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   427b8:	00 
   427b9:	eb 76                	jmp    42831 <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   427bb:	48 8b 0d 3e e8 00 00 	mov    0xe83e(%rip),%rcx        # 51000 <kernel_pagetable>
   427c2:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   427c6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   427ca:	48 89 ce             	mov    %rcx,%rsi
   427cd:	48 89 c7             	mov    %rax,%rdi
   427d0:	e8 36 06 00 00       	call   42e0b <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   427d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   427d9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   427dd:	74 1e                	je     427fd <virtual_memory_init+0xeb>
   427df:	48 8d 05 7f 2c 00 00 	lea    0x2c7f(%rip),%rax        # 45465 <complex_keymap+0x125>
   427e6:	48 89 c2             	mov    %rax,%rdx
   427e9:	be 2d 00 00 00       	mov    $0x2d,%esi
   427ee:	48 8d 05 80 2c 00 00 	lea    0x2c80(%rip),%rax        # 45475 <complex_keymap+0x135>
   427f5:	48 89 c7             	mov    %rax,%rdi
   427f8:	e8 3e fe ff ff       	call   4263b <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   427fd:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42800:	48 98                	cltq   
   42802:	83 e0 03             	and    $0x3,%eax
   42805:	48 83 f8 03          	cmp    $0x3,%rax
   42809:	74 1e                	je     42829 <virtual_memory_init+0x117>
   4280b:	48 8d 05 76 2c 00 00 	lea    0x2c76(%rip),%rax        # 45488 <complex_keymap+0x148>
   42812:	48 89 c2             	mov    %rax,%rdx
   42815:	be 2e 00 00 00       	mov    $0x2e,%esi
   4281a:	48 8d 05 54 2c 00 00 	lea    0x2c54(%rip),%rax        # 45475 <complex_keymap+0x135>
   42821:	48 89 c7             	mov    %rax,%rdi
   42824:	e8 12 fe ff ff       	call   4263b <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42829:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42830:	00 
   42831:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42838:	00 
   42839:	76 80                	jbe    427bb <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   4283b:	48 8b 05 be e7 00 00 	mov    0xe7be(%rip),%rax        # 51000 <kernel_pagetable>
   42842:	48 89 c7             	mov    %rax,%rdi
   42845:	e8 03 00 00 00       	call   4284d <set_pagetable>
}
   4284a:	90                   	nop
   4284b:	c9                   	leave  
   4284c:	c3                   	ret    

000000000004284d <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   4284d:	f3 0f 1e fa          	endbr64 
   42851:	55                   	push   %rbp
   42852:	48 89 e5             	mov    %rsp,%rbp
   42855:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42859:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   4285d:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42861:	25 ff 0f 00 00       	and    $0xfff,%eax
   42866:	48 85 c0             	test   %rax,%rax
   42869:	74 1e                	je     42889 <set_pagetable+0x3c>
   4286b:	48 8d 05 43 2c 00 00 	lea    0x2c43(%rip),%rax        # 454b5 <complex_keymap+0x175>
   42872:	48 89 c2             	mov    %rax,%rdx
   42875:	be 3d 00 00 00       	mov    $0x3d,%esi
   4287a:	48 8d 05 f4 2b 00 00 	lea    0x2bf4(%rip),%rax        # 45475 <complex_keymap+0x135>
   42881:	48 89 c7             	mov    %rax,%rdi
   42884:	e8 b2 fd ff ff       	call   4263b <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42889:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   42890:	48 89 c2             	mov    %rax,%rdx
   42893:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42897:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4289b:	48 89 ce             	mov    %rcx,%rsi
   4289e:	48 89 c7             	mov    %rax,%rdi
   428a1:	e8 65 05 00 00       	call   42e0b <virtual_memory_lookup>
   428a6:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   428aa:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   428b1:	48 39 d0             	cmp    %rdx,%rax
   428b4:	74 1e                	je     428d4 <set_pagetable+0x87>
   428b6:	48 8d 05 13 2c 00 00 	lea    0x2c13(%rip),%rax        # 454d0 <complex_keymap+0x190>
   428bd:	48 89 c2             	mov    %rax,%rdx
   428c0:	be 3f 00 00 00       	mov    $0x3f,%esi
   428c5:	48 8d 05 a9 2b 00 00 	lea    0x2ba9(%rip),%rax        # 45475 <complex_keymap+0x135>
   428cc:	48 89 c7             	mov    %rax,%rdi
   428cf:	e8 67 fd ff ff       	call   4263b <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   428d4:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   428d8:	48 8b 0d 21 e7 00 00 	mov    0xe721(%rip),%rcx        # 51000 <kernel_pagetable>
   428df:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   428e3:	48 89 ce             	mov    %rcx,%rsi
   428e6:	48 89 c7             	mov    %rax,%rdi
   428e9:	e8 1d 05 00 00       	call   42e0b <virtual_memory_lookup>
   428ee:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   428f2:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   428f6:	48 39 c2             	cmp    %rax,%rdx
   428f9:	74 1e                	je     42919 <set_pagetable+0xcc>
   428fb:	48 8d 05 36 2c 00 00 	lea    0x2c36(%rip),%rax        # 45538 <complex_keymap+0x1f8>
   42902:	48 89 c2             	mov    %rax,%rdx
   42905:	be 41 00 00 00       	mov    $0x41,%esi
   4290a:	48 8d 05 64 2b 00 00 	lea    0x2b64(%rip),%rax        # 45475 <complex_keymap+0x135>
   42911:	48 89 c7             	mov    %rax,%rdi
   42914:	e8 22 fd ff ff       	call   4263b <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42919:	48 8b 05 e0 e6 00 00 	mov    0xe6e0(%rip),%rax        # 51000 <kernel_pagetable>
   42920:	48 89 c2             	mov    %rax,%rdx
   42923:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42927:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4292b:	48 89 ce             	mov    %rcx,%rsi
   4292e:	48 89 c7             	mov    %rax,%rdi
   42931:	e8 d5 04 00 00       	call   42e0b <virtual_memory_lookup>
   42936:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4293a:	48 8b 15 bf e6 00 00 	mov    0xe6bf(%rip),%rdx        # 51000 <kernel_pagetable>
   42941:	48 39 d0             	cmp    %rdx,%rax
   42944:	74 1e                	je     42964 <set_pagetable+0x117>
   42946:	48 8d 05 4b 2c 00 00 	lea    0x2c4b(%rip),%rax        # 45598 <complex_keymap+0x258>
   4294d:	48 89 c2             	mov    %rax,%rdx
   42950:	be 43 00 00 00       	mov    $0x43,%esi
   42955:	48 8d 05 19 2b 00 00 	lea    0x2b19(%rip),%rax        # 45475 <complex_keymap+0x135>
   4295c:	48 89 c7             	mov    %rax,%rdi
   4295f:	e8 d7 fc ff ff       	call   4263b <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42964:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 429bf <virtual_memory_map>
   4296b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4296f:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42973:	48 89 ce             	mov    %rcx,%rsi
   42976:	48 89 c7             	mov    %rax,%rdi
   42979:	e8 8d 04 00 00       	call   42e0b <virtual_memory_lookup>
   4297e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42982:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 429bf <virtual_memory_map>
   42989:	48 39 d0             	cmp    %rdx,%rax
   4298c:	74 1e                	je     429ac <set_pagetable+0x15f>
   4298e:	48 8d 05 6b 2c 00 00 	lea    0x2c6b(%rip),%rax        # 45600 <complex_keymap+0x2c0>
   42995:	48 89 c2             	mov    %rax,%rdx
   42998:	be 45 00 00 00       	mov    $0x45,%esi
   4299d:	48 8d 05 d1 2a 00 00 	lea    0x2ad1(%rip),%rax        # 45475 <complex_keymap+0x135>
   429a4:	48 89 c7             	mov    %rax,%rdi
   429a7:	e8 8f fc ff ff       	call   4263b <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   429ac:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   429b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   429b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   429b8:	0f 22 d8             	mov    %rax,%cr3
}
   429bb:	90                   	nop
}
   429bc:	90                   	nop
   429bd:	c9                   	leave  
   429be:	c3                   	ret    

00000000000429bf <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   429bf:	f3 0f 1e fa          	endbr64 
   429c3:	55                   	push   %rbp
   429c4:	48 89 e5             	mov    %rsp,%rbp
   429c7:	53                   	push   %rbx
   429c8:	48 83 ec 58          	sub    $0x58,%rsp
   429cc:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   429d0:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   429d4:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   429d8:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   429dc:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   429e0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429e4:	25 ff 0f 00 00       	and    $0xfff,%eax
   429e9:	48 85 c0             	test   %rax,%rax
   429ec:	74 1e                	je     42a0c <virtual_memory_map+0x4d>
   429ee:	48 8d 05 71 2c 00 00 	lea    0x2c71(%rip),%rax        # 45666 <complex_keymap+0x326>
   429f5:	48 89 c2             	mov    %rax,%rdx
   429f8:	be 66 00 00 00       	mov    $0x66,%esi
   429fd:	48 8d 05 71 2a 00 00 	lea    0x2a71(%rip),%rax        # 45475 <complex_keymap+0x135>
   42a04:	48 89 c7             	mov    %rax,%rdi
   42a07:	e8 2f fc ff ff       	call   4263b <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42a0c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a10:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a15:	48 85 c0             	test   %rax,%rax
   42a18:	74 1e                	je     42a38 <virtual_memory_map+0x79>
   42a1a:	48 8d 05 58 2c 00 00 	lea    0x2c58(%rip),%rax        # 45679 <complex_keymap+0x339>
   42a21:	48 89 c2             	mov    %rax,%rdx
   42a24:	be 67 00 00 00       	mov    $0x67,%esi
   42a29:	48 8d 05 45 2a 00 00 	lea    0x2a45(%rip),%rax        # 45475 <complex_keymap+0x135>
   42a30:	48 89 c7             	mov    %rax,%rdi
   42a33:	e8 03 fc ff ff       	call   4263b <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42a38:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42a3c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a40:	48 01 d0             	add    %rdx,%rax
   42a43:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   42a47:	76 2e                	jbe    42a77 <virtual_memory_map+0xb8>
   42a49:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42a4d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a51:	48 01 d0             	add    %rdx,%rax
   42a54:	48 85 c0             	test   %rax,%rax
   42a57:	74 1e                	je     42a77 <virtual_memory_map+0xb8>
   42a59:	48 8d 05 2c 2c 00 00 	lea    0x2c2c(%rip),%rax        # 4568c <complex_keymap+0x34c>
   42a60:	48 89 c2             	mov    %rax,%rdx
   42a63:	be 68 00 00 00       	mov    $0x68,%esi
   42a68:	48 8d 05 06 2a 00 00 	lea    0x2a06(%rip),%rax        # 45475 <complex_keymap+0x135>
   42a6f:	48 89 c7             	mov    %rax,%rdi
   42a72:	e8 c4 fb ff ff       	call   4263b <assert_fail>
    if (perm & PTE_P) {
   42a77:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a7a:	48 98                	cltq   
   42a7c:	83 e0 01             	and    $0x1,%eax
   42a7f:	48 85 c0             	test   %rax,%rax
   42a82:	0f 84 8c 00 00 00    	je     42b14 <virtual_memory_map+0x155>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42a88:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42a8c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a91:	48 85 c0             	test   %rax,%rax
   42a94:	74 1e                	je     42ab4 <virtual_memory_map+0xf5>
   42a96:	48 8d 05 0d 2c 00 00 	lea    0x2c0d(%rip),%rax        # 456aa <complex_keymap+0x36a>
   42a9d:	48 89 c2             	mov    %rax,%rdx
   42aa0:	be 6a 00 00 00       	mov    $0x6a,%esi
   42aa5:	48 8d 05 c9 29 00 00 	lea    0x29c9(%rip),%rax        # 45475 <complex_keymap+0x135>
   42aac:	48 89 c7             	mov    %rax,%rdi
   42aaf:	e8 87 fb ff ff       	call   4263b <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42ab4:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42ab8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42abc:	48 01 d0             	add    %rdx,%rax
   42abf:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   42ac3:	76 1e                	jbe    42ae3 <virtual_memory_map+0x124>
   42ac5:	48 8d 05 f1 2b 00 00 	lea    0x2bf1(%rip),%rax        # 456bd <complex_keymap+0x37d>
   42acc:	48 89 c2             	mov    %rax,%rdx
   42acf:	be 6b 00 00 00       	mov    $0x6b,%esi
   42ad4:	48 8d 05 9a 29 00 00 	lea    0x299a(%rip),%rax        # 45475 <complex_keymap+0x135>
   42adb:	48 89 c7             	mov    %rax,%rdi
   42ade:	e8 58 fb ff ff       	call   4263b <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42ae3:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42ae7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42aeb:	48 01 d0             	add    %rdx,%rax
   42aee:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42af4:	76 1e                	jbe    42b14 <virtual_memory_map+0x155>
   42af6:	48 8d 05 ce 2b 00 00 	lea    0x2bce(%rip),%rax        # 456cb <complex_keymap+0x38b>
   42afd:	48 89 c2             	mov    %rax,%rdx
   42b00:	be 6c 00 00 00       	mov    $0x6c,%esi
   42b05:	48 8d 05 69 29 00 00 	lea    0x2969(%rip),%rax        # 45475 <complex_keymap+0x135>
   42b0c:	48 89 c7             	mov    %rax,%rdi
   42b0f:	e8 27 fb ff ff       	call   4263b <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42b14:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42b18:	78 09                	js     42b23 <virtual_memory_map+0x164>
   42b1a:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42b21:	7e 1e                	jle    42b41 <virtual_memory_map+0x182>
   42b23:	48 8d 05 bd 2b 00 00 	lea    0x2bbd(%rip),%rax        # 456e7 <complex_keymap+0x3a7>
   42b2a:	48 89 c2             	mov    %rax,%rdx
   42b2d:	be 6e 00 00 00       	mov    $0x6e,%esi
   42b32:	48 8d 05 3c 29 00 00 	lea    0x293c(%rip),%rax        # 45475 <complex_keymap+0x135>
   42b39:	48 89 c7             	mov    %rax,%rdi
   42b3c:	e8 fa fa ff ff       	call   4263b <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42b41:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b45:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b4a:	48 85 c0             	test   %rax,%rax
   42b4d:	74 1e                	je     42b6d <virtual_memory_map+0x1ae>
   42b4f:	48 8d 05 b2 2b 00 00 	lea    0x2bb2(%rip),%rax        # 45708 <complex_keymap+0x3c8>
   42b56:	48 89 c2             	mov    %rax,%rdx
   42b59:	be 6f 00 00 00       	mov    $0x6f,%esi
   42b5e:	48 8d 05 10 29 00 00 	lea    0x2910(%rip),%rax        # 45475 <complex_keymap+0x135>
   42b65:	48 89 c7             	mov    %rax,%rdi
   42b68:	e8 ce fa ff ff       	call   4263b <assert_fail>

    int last_index123 = -1;
   42b6d:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   42b74:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42b7b:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42b7c:	e9 e6 00 00 00       	jmp    42c67 <virtual_memory_map+0x2a8>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42b81:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42b85:	48 c1 e8 15          	shr    $0x15,%rax
   42b89:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42b8c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42b8f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42b92:	74 20                	je     42bb4 <virtual_memory_map+0x1f5>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42b94:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42b97:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42b9b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b9f:	48 89 ce             	mov    %rcx,%rsi
   42ba2:	48 89 c7             	mov    %rax,%rdi
   42ba5:	e8 d3 00 00 00       	call   42c7d <lookup_l4pagetable>
   42baa:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42bae:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42bb1:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42bb4:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42bb7:	48 98                	cltq   
   42bb9:	83 e0 01             	and    $0x1,%eax
   42bbc:	48 85 c0             	test   %rax,%rax
   42bbf:	74 34                	je     42bf5 <virtual_memory_map+0x236>
   42bc1:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42bc6:	74 2d                	je     42bf5 <virtual_memory_map+0x236>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42bc8:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42bcb:	48 63 d8             	movslq %eax,%rbx
   42bce:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42bd2:	be 03 00 00 00       	mov    $0x3,%esi
   42bd7:	48 89 c7             	mov    %rax,%rdi
   42bda:	e8 d3 fa ff ff       	call   426b2 <pageindex>
   42bdf:	89 c2                	mov    %eax,%edx
   42be1:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42be5:	48 89 d9             	mov    %rbx,%rcx
   42be8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42bec:	48 63 d2             	movslq %edx,%rdx
   42bef:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42bf3:	eb 5a                	jmp    42c4f <virtual_memory_map+0x290>
        } else if (l4pagetable) { // if page is NOT marked present
   42bf5:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42bfa:	74 26                	je     42c22 <virtual_memory_map+0x263>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42bfc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c00:	be 03 00 00 00       	mov    $0x3,%esi
   42c05:	48 89 c7             	mov    %rax,%rdi
   42c08:	e8 a5 fa ff ff       	call   426b2 <pageindex>
   42c0d:	89 c2                	mov    %eax,%edx
   42c0f:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c12:	48 63 c8             	movslq %eax,%rcx
   42c15:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42c19:	48 63 d2             	movslq %edx,%rdx
   42c1c:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42c20:	eb 2d                	jmp    42c4f <virtual_memory_map+0x290>
        } else if (perm & PTE_P) {
   42c22:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c25:	48 98                	cltq   
   42c27:	83 e0 01             	and    $0x1,%eax
   42c2a:	48 85 c0             	test   %rax,%rax
   42c2d:	74 20                	je     42c4f <virtual_memory_map+0x290>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42c2f:	be 84 00 00 00       	mov    $0x84,%esi
   42c34:	48 8d 05 f5 2a 00 00 	lea    0x2af5(%rip),%rax        # 45730 <complex_keymap+0x3f0>
   42c3b:	48 89 c7             	mov    %rax,%rdi
   42c3e:	b8 00 00 00 00       	mov    $0x0,%eax
   42c43:	e8 98 f6 ff ff       	call   422e0 <log_printf>
            return -1;
   42c48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c4d:	eb 28                	jmp    42c77 <virtual_memory_map+0x2b8>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42c4f:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42c56:	00 
   42c57:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42c5e:	00 
   42c5f:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42c66:	00 
   42c67:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42c6c:	0f 85 0f ff ff ff    	jne    42b81 <virtual_memory_map+0x1c2>
        }
    }
    return 0;
   42c72:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42c77:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42c7b:	c9                   	leave  
   42c7c:	c3                   	ret    

0000000000042c7d <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42c7d:	f3 0f 1e fa          	endbr64 
   42c81:	55                   	push   %rbp
   42c82:	48 89 e5             	mov    %rsp,%rbp
   42c85:	48 83 ec 40          	sub    $0x40,%rsp
   42c89:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42c8d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42c91:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c94:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c98:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42c9c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42ca3:	e9 53 01 00 00       	jmp    42dfb <lookup_l4pagetable+0x17e>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42ca8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42cab:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42caf:	89 d6                	mov    %edx,%esi
   42cb1:	48 89 c7             	mov    %rax,%rdi
   42cb4:	e8 f9 f9 ff ff       	call   426b2 <pageindex>
   42cb9:	89 c2                	mov    %eax,%edx
   42cbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42cbf:	48 63 d2             	movslq %edx,%rdx
   42cc2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42cc6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42cca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cce:	83 e0 01             	and    $0x1,%eax
   42cd1:	48 85 c0             	test   %rax,%rax
   42cd4:	75 6d                	jne    42d43 <lookup_l4pagetable+0xc6>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42cd6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42cd9:	8d 48 02             	lea    0x2(%rax),%ecx
   42cdc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ce0:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ce5:	48 89 c2             	mov    %rax,%rdx
   42ce8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cec:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42cf2:	48 89 c6             	mov    %rax,%rsi
   42cf5:	48 8d 05 7c 2a 00 00 	lea    0x2a7c(%rip),%rax        # 45778 <complex_keymap+0x438>
   42cfc:	48 89 c7             	mov    %rax,%rdi
   42cff:	b8 00 00 00 00       	mov    $0x0,%eax
   42d04:	e8 d7 f5 ff ff       	call   422e0 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42d09:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d0c:	48 98                	cltq   
   42d0e:	83 e0 01             	and    $0x1,%eax
   42d11:	48 85 c0             	test   %rax,%rax
   42d14:	75 0a                	jne    42d20 <lookup_l4pagetable+0xa3>
                return NULL;
   42d16:	b8 00 00 00 00       	mov    $0x0,%eax
   42d1b:	e9 e9 00 00 00       	jmp    42e09 <lookup_l4pagetable+0x18c>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42d20:	be a7 00 00 00       	mov    $0xa7,%esi
   42d25:	48 8d 05 b4 2a 00 00 	lea    0x2ab4(%rip),%rax        # 457e0 <complex_keymap+0x4a0>
   42d2c:	48 89 c7             	mov    %rax,%rdi
   42d2f:	b8 00 00 00 00       	mov    $0x0,%eax
   42d34:	e8 a7 f5 ff ff       	call   422e0 <log_printf>
            return NULL;
   42d39:	b8 00 00 00 00       	mov    $0x0,%eax
   42d3e:	e9 c6 00 00 00       	jmp    42e09 <lookup_l4pagetable+0x18c>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42d43:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d47:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d4d:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42d53:	76 1e                	jbe    42d73 <lookup_l4pagetable+0xf6>
   42d55:	48 8d 05 cc 2a 00 00 	lea    0x2acc(%rip),%rax        # 45828 <complex_keymap+0x4e8>
   42d5c:	48 89 c2             	mov    %rax,%rdx
   42d5f:	be ac 00 00 00       	mov    $0xac,%esi
   42d64:	48 8d 05 0a 27 00 00 	lea    0x270a(%rip),%rax        # 45475 <complex_keymap+0x135>
   42d6b:	48 89 c7             	mov    %rax,%rdi
   42d6e:	e8 c8 f8 ff ff       	call   4263b <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42d73:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d76:	48 98                	cltq   
   42d78:	83 e0 02             	and    $0x2,%eax
   42d7b:	48 85 c0             	test   %rax,%rax
   42d7e:	74 2a                	je     42daa <lookup_l4pagetable+0x12d>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42d80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d84:	83 e0 02             	and    $0x2,%eax
   42d87:	48 85 c0             	test   %rax,%rax
   42d8a:	75 1e                	jne    42daa <lookup_l4pagetable+0x12d>
   42d8c:	48 8d 05 b5 2a 00 00 	lea    0x2ab5(%rip),%rax        # 45848 <complex_keymap+0x508>
   42d93:	48 89 c2             	mov    %rax,%rdx
   42d96:	be ae 00 00 00       	mov    $0xae,%esi
   42d9b:	48 8d 05 d3 26 00 00 	lea    0x26d3(%rip),%rax        # 45475 <complex_keymap+0x135>
   42da2:	48 89 c7             	mov    %rax,%rdi
   42da5:	e8 91 f8 ff ff       	call   4263b <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42daa:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42dad:	48 98                	cltq   
   42daf:	83 e0 04             	and    $0x4,%eax
   42db2:	48 85 c0             	test   %rax,%rax
   42db5:	74 2a                	je     42de1 <lookup_l4pagetable+0x164>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42db7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dbb:	83 e0 04             	and    $0x4,%eax
   42dbe:	48 85 c0             	test   %rax,%rax
   42dc1:	75 1e                	jne    42de1 <lookup_l4pagetable+0x164>
   42dc3:	48 8d 05 89 2a 00 00 	lea    0x2a89(%rip),%rax        # 45853 <complex_keymap+0x513>
   42dca:	48 89 c2             	mov    %rax,%rdx
   42dcd:	be b1 00 00 00       	mov    $0xb1,%esi
   42dd2:	48 8d 05 9c 26 00 00 	lea    0x269c(%rip),%rax        # 45475 <complex_keymap+0x135>
   42dd9:	48 89 c7             	mov    %rax,%rdi
   42ddc:	e8 5a f8 ff ff       	call   4263b <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42de1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42de8:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42de9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ded:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42df3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42df7:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42dfb:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42dff:	0f 8e a3 fe ff ff    	jle    42ca8 <lookup_l4pagetable+0x2b>
    }
    return pt;
   42e05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42e09:	c9                   	leave  
   42e0a:	c3                   	ret    

0000000000042e0b <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42e0b:	f3 0f 1e fa          	endbr64 
   42e0f:	55                   	push   %rbp
   42e10:	48 89 e5             	mov    %rsp,%rbp
   42e13:	48 83 ec 50          	sub    $0x50,%rsp
   42e17:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42e1b:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42e1f:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42e23:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e27:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42e2b:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42e32:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42e33:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42e3a:	eb 41                	jmp    42e7d <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42e3c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42e3f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42e43:	89 d6                	mov    %edx,%esi
   42e45:	48 89 c7             	mov    %rax,%rdi
   42e48:	e8 65 f8 ff ff       	call   426b2 <pageindex>
   42e4d:	89 c2                	mov    %eax,%edx
   42e4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e53:	48 63 d2             	movslq %edx,%rdx
   42e56:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42e5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e5e:	83 e0 06             	and    $0x6,%eax
   42e61:	48 f7 d0             	not    %rax
   42e64:	48 21 d0             	and    %rdx,%rax
   42e67:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42e6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e6f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42e75:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42e79:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42e7d:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42e81:	7f 0c                	jg     42e8f <virtual_memory_lookup+0x84>
   42e83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e87:	83 e0 01             	and    $0x1,%eax
   42e8a:	48 85 c0             	test   %rax,%rax
   42e8d:	75 ad                	jne    42e3c <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42e8f:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42e96:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42e9d:	ff 
   42e9e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42ea5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ea9:	83 e0 01             	and    $0x1,%eax
   42eac:	48 85 c0             	test   %rax,%rax
   42eaf:	74 34                	je     42ee5 <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   42eb1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42eb5:	48 c1 e8 0c          	shr    $0xc,%rax
   42eb9:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42ebc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ec0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ec6:	48 89 c2             	mov    %rax,%rdx
   42ec9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42ecd:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ed2:	48 09 d0             	or     %rdx,%rax
   42ed5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42ed9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42edd:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ee2:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42ee5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42ee9:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42eed:	48 89 10             	mov    %rdx,(%rax)
   42ef0:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42ef4:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42ef8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42efc:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42f00:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42f04:	c9                   	leave  
   42f05:	c3                   	ret    

0000000000042f06 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42f06:	f3 0f 1e fa          	endbr64 
   42f0a:	55                   	push   %rbp
   42f0b:	48 89 e5             	mov    %rsp,%rbp
   42f0e:	48 83 ec 40          	sub    $0x40,%rsp
   42f12:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f16:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42f19:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42f1d:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42f24:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42f28:	78 08                	js     42f32 <program_load+0x2c>
   42f2a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42f2d:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42f30:	7c 1e                	jl     42f50 <program_load+0x4a>
   42f32:	48 8d 05 27 29 00 00 	lea    0x2927(%rip),%rax        # 45860 <complex_keymap+0x520>
   42f39:	48 89 c2             	mov    %rax,%rdx
   42f3c:	be 2e 00 00 00       	mov    $0x2e,%esi
   42f41:	48 8d 05 48 29 00 00 	lea    0x2948(%rip),%rax        # 45890 <complex_keymap+0x550>
   42f48:	48 89 c7             	mov    %rax,%rdi
   42f4b:	e8 eb f6 ff ff       	call   4263b <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42f50:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42f53:	48 98                	cltq   
   42f55:	48 c1 e0 04          	shl    $0x4,%rax
   42f59:	48 89 c2             	mov    %rax,%rdx
   42f5c:	48 8d 05 bd 30 00 00 	lea    0x30bd(%rip),%rax        # 46020 <ramimages>
   42f63:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   42f67:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42f6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f6f:	8b 00                	mov    (%rax),%eax
   42f71:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42f76:	74 1e                	je     42f96 <program_load+0x90>
   42f78:	48 8d 05 23 29 00 00 	lea    0x2923(%rip),%rax        # 458a2 <complex_keymap+0x562>
   42f7f:	48 89 c2             	mov    %rax,%rdx
   42f82:	be 30 00 00 00       	mov    $0x30,%esi
   42f87:	48 8d 05 02 29 00 00 	lea    0x2902(%rip),%rax        # 45890 <complex_keymap+0x550>
   42f8e:	48 89 c7             	mov    %rax,%rdi
   42f91:	e8 a5 f6 ff ff       	call   4263b <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42f96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f9a:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42f9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fa2:	48 01 d0             	add    %rdx,%rax
   42fa5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42fa9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42fb0:	e9 94 00 00 00       	jmp    43049 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42fb5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42fb8:	48 63 d0             	movslq %eax,%rdx
   42fbb:	48 89 d0             	mov    %rdx,%rax
   42fbe:	48 c1 e0 03          	shl    $0x3,%rax
   42fc2:	48 29 d0             	sub    %rdx,%rax
   42fc5:	48 c1 e0 03          	shl    $0x3,%rax
   42fc9:	48 89 c2             	mov    %rax,%rdx
   42fcc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fd0:	48 01 d0             	add    %rdx,%rax
   42fd3:	8b 00                	mov    (%rax),%eax
   42fd5:	83 f8 01             	cmp    $0x1,%eax
   42fd8:	75 6b                	jne    43045 <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42fda:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42fdd:	48 63 d0             	movslq %eax,%rdx
   42fe0:	48 89 d0             	mov    %rdx,%rax
   42fe3:	48 c1 e0 03          	shl    $0x3,%rax
   42fe7:	48 29 d0             	sub    %rdx,%rax
   42fea:	48 c1 e0 03          	shl    $0x3,%rax
   42fee:	48 89 c2             	mov    %rax,%rdx
   42ff1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ff5:	48 01 d0             	add    %rdx,%rax
   42ff8:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42ffc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43000:	48 01 d0             	add    %rdx,%rax
   43003:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   43007:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4300a:	48 63 d0             	movslq %eax,%rdx
   4300d:	48 89 d0             	mov    %rdx,%rax
   43010:	48 c1 e0 03          	shl    $0x3,%rax
   43014:	48 29 d0             	sub    %rdx,%rax
   43017:	48 c1 e0 03          	shl    $0x3,%rax
   4301b:	48 89 c2             	mov    %rax,%rdx
   4301e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43022:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43026:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4302a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4302e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43032:	48 89 c7             	mov    %rax,%rdi
   43035:	e8 3d 00 00 00       	call   43077 <program_load_segment>
   4303a:	85 c0                	test   %eax,%eax
   4303c:	79 07                	jns    43045 <program_load+0x13f>
                return -1;
   4303e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43043:	eb 30                	jmp    43075 <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43045:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43049:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4304d:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   43051:	0f b7 c0             	movzwl %ax,%eax
   43054:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43057:	0f 8c 58 ff ff ff    	jl     42fb5 <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   4305d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43061:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43065:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43069:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   43070:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43075:	c9                   	leave  
   43076:	c3                   	ret    

0000000000043077 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43077:	f3 0f 1e fa          	endbr64 
   4307b:	55                   	push   %rbp
   4307c:	48 89 e5             	mov    %rsp,%rbp
   4307f:	48 83 ec 70          	sub    $0x70,%rsp
   43083:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43087:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   4308b:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   4308f:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   43093:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43097:	48 8b 40 10          	mov    0x10(%rax),%rax
   4309b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4309f:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   430a3:	48 8b 50 20          	mov    0x20(%rax),%rdx
   430a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430ab:	48 01 d0             	add    %rdx,%rax
   430ae:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   430b2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   430b6:	48 8b 50 28          	mov    0x28(%rax),%rdx
   430ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430be:	48 01 d0             	add    %rdx,%rax
   430c1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   430c5:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   430cc:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   430cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430d1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   430d5:	e9 81 00 00 00       	jmp    4315b <program_load_segment+0xe4>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   430da:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   430de:	8b 00                	mov    (%rax),%eax
   430e0:	89 c7                	mov    %eax,%edi
   430e2:	e8 53 01 00 00       	call   4323a <palloc>
   430e7:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   430eb:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   430f0:	74 2a                	je     4311c <program_load_segment+0xa5>
   430f2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   430f6:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   430fd:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43101:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43105:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4310b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43110:	48 89 c7             	mov    %rax,%rdi
   43113:	e8 a7 f8 ff ff       	call   429bf <virtual_memory_map>
   43118:	85 c0                	test   %eax,%eax
   4311a:	79 37                	jns    43153 <program_load_segment+0xdc>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   4311c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43120:	8b 00                	mov    (%rax),%eax
   43122:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43126:	49 89 d0             	mov    %rdx,%r8
   43129:	89 c1                	mov    %eax,%ecx
   4312b:	48 8d 05 8e 27 00 00 	lea    0x278e(%rip),%rax        # 458c0 <complex_keymap+0x580>
   43132:	48 89 c2             	mov    %rax,%rdx
   43135:	be 00 c0 00 00       	mov    $0xc000,%esi
   4313a:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4313f:	b8 00 00 00 00       	mov    $0x0,%eax
   43144:	e8 6a 1b 00 00       	call   44cb3 <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   43149:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4314e:	e9 e5 00 00 00       	jmp    43238 <program_load_segment+0x1c1>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43153:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4315a:	00 
   4315b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4315f:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43163:	0f 82 71 ff ff ff    	jb     430da <program_load_segment+0x63>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43169:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4316d:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43174:	48 89 c7             	mov    %rax,%rdi
   43177:	e8 d1 f6 ff ff       	call   4284d <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   4317c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43180:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   43184:	48 89 c2             	mov    %rax,%rdx
   43187:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4318b:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   4318f:	48 89 ce             	mov    %rcx,%rsi
   43192:	48 89 c7             	mov    %rax,%rdi
   43195:	e8 d4 0b 00 00       	call   43d6e <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   4319a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4319e:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   431a2:	48 89 c2             	mov    %rax,%rdx
   431a5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   431a9:	be 00 00 00 00       	mov    $0x0,%esi
   431ae:	48 89 c7             	mov    %rax,%rdi
   431b1:	e8 be 0c 00 00       	call   43e74 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   431b6:	48 8b 05 43 de 00 00 	mov    0xde43(%rip),%rax        # 51000 <kernel_pagetable>
   431bd:	48 89 c7             	mov    %rax,%rdi
   431c0:	e8 88 f6 ff ff       	call   4284d <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   431c5:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   431c9:	8b 40 04             	mov    0x4(%rax),%eax
   431cc:	83 e0 02             	and    $0x2,%eax
   431cf:	85 c0                	test   %eax,%eax
   431d1:	75 60                	jne    43233 <program_load_segment+0x1bc>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   431d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431d7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   431db:	eb 4c                	jmp    43229 <program_load_segment+0x1b2>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   431dd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   431e1:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   431e8:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   431ec:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   431f0:	48 89 ce             	mov    %rcx,%rsi
   431f3:	48 89 c7             	mov    %rax,%rdi
   431f6:	e8 10 fc ff ff       	call   42e0b <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   431fb:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   431ff:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43203:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4320a:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   4320e:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43214:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43219:	48 89 c7             	mov    %rax,%rdi
   4321c:	e8 9e f7 ff ff       	call   429bf <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43221:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43228:	00 
   43229:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4322d:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43231:	72 aa                	jb     431dd <program_load_segment+0x166>
                    PTE_P | PTE_U);
        }
    }
    // TODO : Add code here
    return 0;
   43233:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43238:	c9                   	leave  
   43239:	c3                   	ret    

000000000004323a <palloc>:
   4323a:	55                   	push   %rbp
   4323b:	48 89 e5             	mov    %rsp,%rbp
   4323e:	48 83 ec 20          	sub    $0x20,%rsp
   43242:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43245:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   4324c:	00 
   4324d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43251:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43255:	e9 95 00 00 00       	jmp    432ef <palloc+0xb5>
   4325a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4325e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43262:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43269:	00 
   4326a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4326e:	48 c1 e8 0c          	shr    $0xc,%rax
   43272:	48 98                	cltq   
   43274:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   4327b:	00 
   4327c:	84 c0                	test   %al,%al
   4327e:	75 6f                	jne    432ef <palloc+0xb5>
   43280:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43284:	48 c1 e8 0c          	shr    $0xc,%rax
   43288:	48 98                	cltq   
   4328a:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43291:	00 
   43292:	84 c0                	test   %al,%al
   43294:	75 59                	jne    432ef <palloc+0xb5>
   43296:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4329a:	48 c1 e8 0c          	shr    $0xc,%rax
   4329e:	89 c2                	mov    %eax,%edx
   432a0:	48 63 c2             	movslq %edx,%rax
   432a3:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   432aa:	00 
   432ab:	83 c0 01             	add    $0x1,%eax
   432ae:	89 c1                	mov    %eax,%ecx
   432b0:	48 63 c2             	movslq %edx,%rax
   432b3:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   432ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432be:	48 c1 e8 0c          	shr    $0xc,%rax
   432c2:	89 c1                	mov    %eax,%ecx
   432c4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   432c7:	89 c2                	mov    %eax,%edx
   432c9:	48 63 c1             	movslq %ecx,%rax
   432cc:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
   432d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432d7:	ba 00 10 00 00       	mov    $0x1000,%edx
   432dc:	be cc 00 00 00       	mov    $0xcc,%esi
   432e1:	48 89 c7             	mov    %rax,%rdi
   432e4:	e8 8b 0b 00 00       	call   43e74 <memset>
   432e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ed:	eb 2c                	jmp    4331b <palloc+0xe1>
   432ef:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   432f6:	00 
   432f7:	0f 86 5d ff ff ff    	jbe    4325a <palloc+0x20>
   432fd:	ba f8 58 04 00       	mov    $0x458f8,%edx
   43302:	be 00 0c 00 00       	mov    $0xc00,%esi
   43307:	bf 80 07 00 00       	mov    $0x780,%edi
   4330c:	b8 00 00 00 00       	mov    $0x0,%eax
   43311:	e8 9d 19 00 00       	call   44cb3 <console_printf>
   43316:	b8 00 00 00 00       	mov    $0x0,%eax
   4331b:	c9                   	leave  
   4331c:	c3                   	ret    

000000000004331d <palloc_target>:
   4331d:	55                   	push   %rbp
   4331e:	48 89 e5             	mov    %rsp,%rbp
   43321:	48 8b 05 d8 3c 01 00 	mov    0x13cd8(%rip),%rax        # 57000 <palloc_target_proc>
   43328:	48 85 c0             	test   %rax,%rax
   4332b:	75 14                	jne    43341 <palloc_target+0x24>
   4332d:	ba 11 59 04 00       	mov    $0x45911,%edx
   43332:	be 27 00 00 00       	mov    $0x27,%esi
   43337:	bf 2c 59 04 00       	mov    $0x4592c,%edi
   4333c:	e8 fa f2 ff ff       	call   4263b <assert_fail>
   43341:	48 8b 05 b8 3c 01 00 	mov    0x13cb8(%rip),%rax        # 57000 <palloc_target_proc>
   43348:	8b 00                	mov    (%rax),%eax
   4334a:	89 c7                	mov    %eax,%edi
   4334c:	e8 e9 fe ff ff       	call   4323a <palloc>
   43351:	5d                   	pop    %rbp
   43352:	c3                   	ret    

0000000000043353 <process_free>:
   43353:	55                   	push   %rbp
   43354:	48 89 e5             	mov    %rsp,%rbp
   43357:	48 83 ec 60          	sub    $0x60,%rsp
   4335b:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4335e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43361:	48 63 d0             	movslq %eax,%rdx
   43364:	48 89 d0             	mov    %rdx,%rax
   43367:	48 c1 e0 04          	shl    $0x4,%rax
   4336b:	48 29 d0             	sub    %rdx,%rax
   4336e:	48 c1 e0 04          	shl    $0x4,%rax
   43372:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43378:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   4337e:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43385:	00 
   43386:	e9 ad 00 00 00       	jmp    43438 <process_free+0xe5>
   4338b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4338e:	48 63 d0             	movslq %eax,%rdx
   43391:	48 89 d0             	mov    %rdx,%rax
   43394:	48 c1 e0 04          	shl    $0x4,%rax
   43398:	48 29 d0             	sub    %rdx,%rax
   4339b:	48 c1 e0 04          	shl    $0x4,%rax
   4339f:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   433a5:	48 8b 08             	mov    (%rax),%rcx
   433a8:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   433ac:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   433b0:	48 89 ce             	mov    %rcx,%rsi
   433b3:	48 89 c7             	mov    %rax,%rdi
   433b6:	e8 50 fa ff ff       	call   42e0b <virtual_memory_lookup>
   433bb:	8b 45 c8             	mov    -0x38(%rbp),%eax
   433be:	48 98                	cltq   
   433c0:	83 e0 01             	and    $0x1,%eax
   433c3:	48 85 c0             	test   %rax,%rax
   433c6:	74 68                	je     43430 <process_free+0xdd>
   433c8:	8b 45 b8             	mov    -0x48(%rbp),%eax
   433cb:	48 63 d0             	movslq %eax,%rdx
   433ce:	0f b6 94 12 21 ef 04 	movzbl 0x4ef21(%rdx,%rdx,1),%edx
   433d5:	00 
   433d6:	83 ea 01             	sub    $0x1,%edx
   433d9:	48 98                	cltq   
   433db:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
   433e2:	8b 45 b8             	mov    -0x48(%rbp),%eax
   433e5:	48 98                	cltq   
   433e7:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   433ee:	00 
   433ef:	84 c0                	test   %al,%al
   433f1:	75 0f                	jne    43402 <process_free+0xaf>
   433f3:	8b 45 b8             	mov    -0x48(%rbp),%eax
   433f6:	48 98                	cltq   
   433f8:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   433ff:	00 
   43400:	eb 2e                	jmp    43430 <process_free+0xdd>
   43402:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43405:	48 98                	cltq   
   43407:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   4340e:	00 
   4340f:	0f be c0             	movsbl %al,%eax
   43412:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43415:	75 19                	jne    43430 <process_free+0xdd>
   43417:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4341b:	8b 55 ac             	mov    -0x54(%rbp),%edx
   4341e:	48 89 c6             	mov    %rax,%rsi
   43421:	bf 38 59 04 00       	mov    $0x45938,%edi
   43426:	b8 00 00 00 00       	mov    $0x0,%eax
   4342b:	e8 b0 ee ff ff       	call   422e0 <log_printf>
   43430:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43437:	00 
   43438:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4343f:	00 
   43440:	0f 86 45 ff ff ff    	jbe    4338b <process_free+0x38>
   43446:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43449:	48 63 d0             	movslq %eax,%rdx
   4344c:	48 89 d0             	mov    %rdx,%rax
   4344f:	48 c1 e0 04          	shl    $0x4,%rax
   43453:	48 29 d0             	sub    %rdx,%rax
   43456:	48 c1 e0 04          	shl    $0x4,%rax
   4345a:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43460:	48 8b 00             	mov    (%rax),%rax
   43463:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43467:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4346b:	48 8b 00             	mov    (%rax),%rax
   4346e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43474:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43478:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4347c:	48 8b 00             	mov    (%rax),%rax
   4347f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43485:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43489:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4348d:	48 8b 00             	mov    (%rax),%rax
   43490:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43496:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4349a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4349e:	48 8b 40 08          	mov    0x8(%rax),%rax
   434a2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   434a8:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   434ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434b0:	48 c1 e8 0c          	shr    $0xc,%rax
   434b4:	48 98                	cltq   
   434b6:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   434bd:	00 
   434be:	3c 01                	cmp    $0x1,%al
   434c0:	74 14                	je     434d6 <process_free+0x183>
   434c2:	ba 70 59 04 00       	mov    $0x45970,%edx
   434c7:	be 4f 00 00 00       	mov    $0x4f,%esi
   434cc:	bf 2c 59 04 00       	mov    $0x4592c,%edi
   434d1:	e8 65 f1 ff ff       	call   4263b <assert_fail>
   434d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434da:	48 c1 e8 0c          	shr    $0xc,%rax
   434de:	48 98                	cltq   
   434e0:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   434e7:	00 
   434e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434ec:	48 c1 e8 0c          	shr    $0xc,%rax
   434f0:	48 98                	cltq   
   434f2:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   434f9:	00 
   434fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434fe:	48 c1 e8 0c          	shr    $0xc,%rax
   43502:	48 98                	cltq   
   43504:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4350b:	00 
   4350c:	3c 01                	cmp    $0x1,%al
   4350e:	74 14                	je     43524 <process_free+0x1d1>
   43510:	ba 98 59 04 00       	mov    $0x45998,%edx
   43515:	be 52 00 00 00       	mov    $0x52,%esi
   4351a:	bf 2c 59 04 00       	mov    $0x4592c,%edi
   4351f:	e8 17 f1 ff ff       	call   4263b <assert_fail>
   43524:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43528:	48 c1 e8 0c          	shr    $0xc,%rax
   4352c:	48 98                	cltq   
   4352e:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43535:	00 
   43536:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4353a:	48 c1 e8 0c          	shr    $0xc,%rax
   4353e:	48 98                	cltq   
   43540:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43547:	00 
   43548:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4354c:	48 c1 e8 0c          	shr    $0xc,%rax
   43550:	48 98                	cltq   
   43552:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43559:	00 
   4355a:	3c 01                	cmp    $0x1,%al
   4355c:	74 14                	je     43572 <process_free+0x21f>
   4355e:	ba c0 59 04 00       	mov    $0x459c0,%edx
   43563:	be 55 00 00 00       	mov    $0x55,%esi
   43568:	bf 2c 59 04 00       	mov    $0x4592c,%edi
   4356d:	e8 c9 f0 ff ff       	call   4263b <assert_fail>
   43572:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43576:	48 c1 e8 0c          	shr    $0xc,%rax
   4357a:	48 98                	cltq   
   4357c:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43583:	00 
   43584:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43588:	48 c1 e8 0c          	shr    $0xc,%rax
   4358c:	48 98                	cltq   
   4358e:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43595:	00 
   43596:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4359a:	48 c1 e8 0c          	shr    $0xc,%rax
   4359e:	48 98                	cltq   
   435a0:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   435a7:	00 
   435a8:	3c 01                	cmp    $0x1,%al
   435aa:	74 14                	je     435c0 <process_free+0x26d>
   435ac:	ba e8 59 04 00       	mov    $0x459e8,%edx
   435b1:	be 58 00 00 00       	mov    $0x58,%esi
   435b6:	bf 2c 59 04 00       	mov    $0x4592c,%edi
   435bb:	e8 7b f0 ff ff       	call   4263b <assert_fail>
   435c0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435c4:	48 c1 e8 0c          	shr    $0xc,%rax
   435c8:	48 98                	cltq   
   435ca:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   435d1:	00 
   435d2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435d6:	48 c1 e8 0c          	shr    $0xc,%rax
   435da:	48 98                	cltq   
   435dc:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   435e3:	00 
   435e4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   435e8:	48 c1 e8 0c          	shr    $0xc,%rax
   435ec:	48 98                	cltq   
   435ee:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   435f5:	00 
   435f6:	3c 01                	cmp    $0x1,%al
   435f8:	74 14                	je     4360e <process_free+0x2bb>
   435fa:	ba 10 5a 04 00       	mov    $0x45a10,%edx
   435ff:	be 5b 00 00 00       	mov    $0x5b,%esi
   43604:	bf 2c 59 04 00       	mov    $0x4592c,%edi
   43609:	e8 2d f0 ff ff       	call   4263b <assert_fail>
   4360e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43612:	48 c1 e8 0c          	shr    $0xc,%rax
   43616:	48 98                	cltq   
   43618:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4361f:	00 
   43620:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43624:	48 c1 e8 0c          	shr    $0xc,%rax
   43628:	48 98                	cltq   
   4362a:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43631:	00 
   43632:	90                   	nop
   43633:	c9                   	leave  
   43634:	c3                   	ret    

0000000000043635 <process_config_tables>:
   43635:	55                   	push   %rbp
   43636:	48 89 e5             	mov    %rsp,%rbp
   43639:	48 83 ec 40          	sub    $0x40,%rsp
   4363d:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43640:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43643:	89 c7                	mov    %eax,%edi
   43645:	e8 f0 fb ff ff       	call   4323a <palloc>
   4364a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4364e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43651:	89 c7                	mov    %eax,%edi
   43653:	e8 e2 fb ff ff       	call   4323a <palloc>
   43658:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4365c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4365f:	89 c7                	mov    %eax,%edi
   43661:	e8 d4 fb ff ff       	call   4323a <palloc>
   43666:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4366a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4366d:	89 c7                	mov    %eax,%edi
   4366f:	e8 c6 fb ff ff       	call   4323a <palloc>
   43674:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43678:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4367b:	89 c7                	mov    %eax,%edi
   4367d:	e8 b8 fb ff ff       	call   4323a <palloc>
   43682:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43686:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4368b:	74 20                	je     436ad <process_config_tables+0x78>
   4368d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43692:	74 19                	je     436ad <process_config_tables+0x78>
   43694:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43699:	74 12                	je     436ad <process_config_tables+0x78>
   4369b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   436a0:	74 0b                	je     436ad <process_config_tables+0x78>
   436a2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   436a7:	0f 85 e1 00 00 00    	jne    4378e <process_config_tables+0x159>
   436ad:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   436b2:	74 24                	je     436d8 <process_config_tables+0xa3>
   436b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436b8:	48 c1 e8 0c          	shr    $0xc,%rax
   436bc:	48 98                	cltq   
   436be:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   436c5:	00 
   436c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436ca:	48 c1 e8 0c          	shr    $0xc,%rax
   436ce:	48 98                	cltq   
   436d0:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   436d7:	00 
   436d8:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   436dd:	74 24                	je     43703 <process_config_tables+0xce>
   436df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436e3:	48 c1 e8 0c          	shr    $0xc,%rax
   436e7:	48 98                	cltq   
   436e9:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   436f0:	00 
   436f1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436f5:	48 c1 e8 0c          	shr    $0xc,%rax
   436f9:	48 98                	cltq   
   436fb:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43702:	00 
   43703:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43708:	74 24                	je     4372e <process_config_tables+0xf9>
   4370a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4370e:	48 c1 e8 0c          	shr    $0xc,%rax
   43712:	48 98                	cltq   
   43714:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4371b:	00 
   4371c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43720:	48 c1 e8 0c          	shr    $0xc,%rax
   43724:	48 98                	cltq   
   43726:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4372d:	00 
   4372e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43733:	74 24                	je     43759 <process_config_tables+0x124>
   43735:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43739:	48 c1 e8 0c          	shr    $0xc,%rax
   4373d:	48 98                	cltq   
   4373f:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43746:	00 
   43747:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4374b:	48 c1 e8 0c          	shr    $0xc,%rax
   4374f:	48 98                	cltq   
   43751:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43758:	00 
   43759:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4375e:	74 24                	je     43784 <process_config_tables+0x14f>
   43760:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43764:	48 c1 e8 0c          	shr    $0xc,%rax
   43768:	48 98                	cltq   
   4376a:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43771:	00 
   43772:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43776:	48 c1 e8 0c          	shr    $0xc,%rax
   4377a:	48 98                	cltq   
   4377c:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43783:	00 
   43784:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43789:	e9 f3 01 00 00       	jmp    43981 <process_config_tables+0x34c>
   4378e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43792:	ba 00 10 00 00       	mov    $0x1000,%edx
   43797:	be 00 00 00 00       	mov    $0x0,%esi
   4379c:	48 89 c7             	mov    %rax,%rdi
   4379f:	e8 d0 06 00 00       	call   43e74 <memset>
   437a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437a8:	ba 00 10 00 00       	mov    $0x1000,%edx
   437ad:	be 00 00 00 00       	mov    $0x0,%esi
   437b2:	48 89 c7             	mov    %rax,%rdi
   437b5:	e8 ba 06 00 00       	call   43e74 <memset>
   437ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437be:	ba 00 10 00 00       	mov    $0x1000,%edx
   437c3:	be 00 00 00 00       	mov    $0x0,%esi
   437c8:	48 89 c7             	mov    %rax,%rdi
   437cb:	e8 a4 06 00 00       	call   43e74 <memset>
   437d0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437d4:	ba 00 10 00 00       	mov    $0x1000,%edx
   437d9:	be 00 00 00 00       	mov    $0x0,%esi
   437de:	48 89 c7             	mov    %rax,%rdi
   437e1:	e8 8e 06 00 00       	call   43e74 <memset>
   437e6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   437ea:	ba 00 10 00 00       	mov    $0x1000,%edx
   437ef:	be 00 00 00 00       	mov    $0x0,%esi
   437f4:	48 89 c7             	mov    %rax,%rdi
   437f7:	e8 78 06 00 00       	call   43e74 <memset>
   437fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43800:	48 83 c8 07          	or     $0x7,%rax
   43804:	48 89 c2             	mov    %rax,%rdx
   43807:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4380b:	48 89 10             	mov    %rdx,(%rax)
   4380e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43812:	48 83 c8 07          	or     $0x7,%rax
   43816:	48 89 c2             	mov    %rax,%rdx
   43819:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4381d:	48 89 10             	mov    %rdx,(%rax)
   43820:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43824:	48 83 c8 07          	or     $0x7,%rax
   43828:	48 89 c2             	mov    %rax,%rdx
   4382b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4382f:	48 89 10             	mov    %rdx,(%rax)
   43832:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43836:	48 83 c8 07          	or     $0x7,%rax
   4383a:	48 89 c2             	mov    %rax,%rdx
   4383d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43841:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43845:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43849:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4384f:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   43855:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4385a:	ba 00 00 00 00       	mov    $0x0,%edx
   4385f:	be 00 00 00 00       	mov    $0x0,%esi
   43864:	48 89 c7             	mov    %rax,%rdi
   43867:	e8 53 f1 ff ff       	call   429bf <virtual_memory_map>
   4386c:	85 c0                	test   %eax,%eax
   4386e:	75 2f                	jne    4389f <process_config_tables+0x26a>
   43870:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   43875:	be 00 80 0b 00       	mov    $0xb8000,%esi
   4387a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4387e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43884:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4388a:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4388f:	48 89 c7             	mov    %rax,%rdi
   43892:	e8 28 f1 ff ff       	call   429bf <virtual_memory_map>
   43897:	85 c0                	test   %eax,%eax
   43899:	0f 84 bb 00 00 00    	je     4395a <process_config_tables+0x325>
   4389f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438a3:	48 c1 e8 0c          	shr    $0xc,%rax
   438a7:	48 98                	cltq   
   438a9:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   438b0:	00 
   438b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438b5:	48 c1 e8 0c          	shr    $0xc,%rax
   438b9:	48 98                	cltq   
   438bb:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   438c2:	00 
   438c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438c7:	48 c1 e8 0c          	shr    $0xc,%rax
   438cb:	48 98                	cltq   
   438cd:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   438d4:	00 
   438d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438d9:	48 c1 e8 0c          	shr    $0xc,%rax
   438dd:	48 98                	cltq   
   438df:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   438e6:	00 
   438e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438eb:	48 c1 e8 0c          	shr    $0xc,%rax
   438ef:	48 98                	cltq   
   438f1:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   438f8:	00 
   438f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438fd:	48 c1 e8 0c          	shr    $0xc,%rax
   43901:	48 98                	cltq   
   43903:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4390a:	00 
   4390b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4390f:	48 c1 e8 0c          	shr    $0xc,%rax
   43913:	48 98                	cltq   
   43915:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4391c:	00 
   4391d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43921:	48 c1 e8 0c          	shr    $0xc,%rax
   43925:	48 98                	cltq   
   43927:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4392e:	00 
   4392f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43933:	48 c1 e8 0c          	shr    $0xc,%rax
   43937:	48 98                	cltq   
   43939:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43940:	00 
   43941:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43945:	48 c1 e8 0c          	shr    $0xc,%rax
   43949:	48 98                	cltq   
   4394b:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43952:	00 
   43953:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43958:	eb 27                	jmp    43981 <process_config_tables+0x34c>
   4395a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4395d:	48 63 d0             	movslq %eax,%rdx
   43960:	48 89 d0             	mov    %rdx,%rax
   43963:	48 c1 e0 04          	shl    $0x4,%rax
   43967:	48 29 d0             	sub    %rdx,%rax
   4396a:	48 c1 e0 04          	shl    $0x4,%rax
   4396e:	48 8d 90 e0 e0 04 00 	lea    0x4e0e0(%rax),%rdx
   43975:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43979:	48 89 02             	mov    %rax,(%rdx)
   4397c:	b8 00 00 00 00       	mov    $0x0,%eax
   43981:	c9                   	leave  
   43982:	c3                   	ret    

0000000000043983 <process_load>:
   43983:	55                   	push   %rbp
   43984:	48 89 e5             	mov    %rsp,%rbp
   43987:	48 83 ec 20          	sub    $0x20,%rsp
   4398b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4398f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43992:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43996:	48 89 05 63 36 01 00 	mov    %rax,0x13663(%rip)        # 57000 <palloc_target_proc>
   4399d:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   439a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439a4:	ba 1d 33 04 00       	mov    $0x4331d,%edx
   439a9:	89 ce                	mov    %ecx,%esi
   439ab:	48 89 c7             	mov    %rax,%rdi
   439ae:	e8 53 f5 ff ff       	call   42f06 <program_load>
   439b3:	89 45 fc             	mov    %eax,-0x4(%rbp)
   439b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   439b9:	c9                   	leave  
   439ba:	c3                   	ret    

00000000000439bb <process_setup_stack>:
   439bb:	55                   	push   %rbp
   439bc:	48 89 e5             	mov    %rsp,%rbp
   439bf:	48 83 ec 20          	sub    $0x20,%rsp
   439c3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   439c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439cb:	8b 00                	mov    (%rax),%eax
   439cd:	89 c7                	mov    %eax,%edi
   439cf:	e8 66 f8 ff ff       	call   4323a <palloc>
   439d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   439d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439dc:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   439e3:	00 00 30 00 
   439e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439eb:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   439f2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   439f6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   439fc:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43a02:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a07:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   43a0c:	48 89 c7             	mov    %rax,%rdi
   43a0f:	e8 ab ef ff ff       	call   429bf <virtual_memory_map>
   43a14:	90                   	nop
   43a15:	c9                   	leave  
   43a16:	c3                   	ret    

0000000000043a17 <find_free_pid>:
   43a17:	55                   	push   %rbp
   43a18:	48 89 e5             	mov    %rsp,%rbp
   43a1b:	48 83 ec 10          	sub    $0x10,%rsp
   43a1f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43a26:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   43a2d:	eb 24                	jmp    43a53 <find_free_pid+0x3c>
   43a2f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43a32:	48 63 d0             	movslq %eax,%rdx
   43a35:	48 89 d0             	mov    %rdx,%rax
   43a38:	48 c1 e0 04          	shl    $0x4,%rax
   43a3c:	48 29 d0             	sub    %rdx,%rax
   43a3f:	48 c1 e0 04          	shl    $0x4,%rax
   43a43:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43a49:	8b 00                	mov    (%rax),%eax
   43a4b:	85 c0                	test   %eax,%eax
   43a4d:	74 0c                	je     43a5b <find_free_pid+0x44>
   43a4f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43a53:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   43a57:	7e d6                	jle    43a2f <find_free_pid+0x18>
   43a59:	eb 01                	jmp    43a5c <find_free_pid+0x45>
   43a5b:	90                   	nop
   43a5c:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   43a60:	74 05                	je     43a67 <find_free_pid+0x50>
   43a62:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43a65:	eb 05                	jmp    43a6c <find_free_pid+0x55>
   43a67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a6c:	c9                   	leave  
   43a6d:	c3                   	ret    

0000000000043a6e <process_fork>:
   43a6e:	55                   	push   %rbp
   43a6f:	48 89 e5             	mov    %rsp,%rbp
   43a72:	48 83 ec 40          	sub    $0x40,%rsp
   43a76:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43a7a:	b8 00 00 00 00       	mov    $0x0,%eax
   43a7f:	e8 93 ff ff ff       	call   43a17 <find_free_pid>
   43a84:	89 45 f4             	mov    %eax,-0xc(%rbp)
   43a87:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   43a8b:	75 0a                	jne    43a97 <process_fork+0x29>
   43a8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a92:	e9 67 02 00 00       	jmp    43cfe <process_fork+0x290>
   43a97:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a9a:	48 63 d0             	movslq %eax,%rdx
   43a9d:	48 89 d0             	mov    %rdx,%rax
   43aa0:	48 c1 e0 04          	shl    $0x4,%rax
   43aa4:	48 29 d0             	sub    %rdx,%rax
   43aa7:	48 c1 e0 04          	shl    $0x4,%rax
   43aab:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   43ab1:	be 00 00 00 00       	mov    $0x0,%esi
   43ab6:	48 89 c7             	mov    %rax,%rdi
   43ab9:	e8 47 e3 ff ff       	call   41e05 <process_init>
   43abe:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ac1:	89 c7                	mov    %eax,%edi
   43ac3:	e8 6d fb ff ff       	call   43635 <process_config_tables>
   43ac8:	83 f8 ff             	cmp    $0xffffffff,%eax
   43acb:	75 0a                	jne    43ad7 <process_fork+0x69>
   43acd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43ad2:	e9 27 02 00 00       	jmp    43cfe <process_fork+0x290>
   43ad7:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43ade:	00 
   43adf:	e9 79 01 00 00       	jmp    43c5d <process_fork+0x1ef>
   43ae4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43ae8:	8b 00                	mov    (%rax),%eax
   43aea:	48 63 d0             	movslq %eax,%rdx
   43aed:	48 89 d0             	mov    %rdx,%rax
   43af0:	48 c1 e0 04          	shl    $0x4,%rax
   43af4:	48 29 d0             	sub    %rdx,%rax
   43af7:	48 c1 e0 04          	shl    $0x4,%rax
   43afb:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43b01:	48 8b 08             	mov    (%rax),%rcx
   43b04:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43b08:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43b0c:	48 89 ce             	mov    %rcx,%rsi
   43b0f:	48 89 c7             	mov    %rax,%rdi
   43b12:	e8 f4 f2 ff ff       	call   42e0b <virtual_memory_lookup>
   43b17:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43b1a:	48 98                	cltq   
   43b1c:	83 e0 07             	and    $0x7,%eax
   43b1f:	48 83 f8 07          	cmp    $0x7,%rax
   43b23:	0f 85 a1 00 00 00    	jne    43bca <process_fork+0x15c>
   43b29:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b2c:	89 c7                	mov    %eax,%edi
   43b2e:	e8 07 f7 ff ff       	call   4323a <palloc>
   43b33:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43b37:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43b3c:	75 14                	jne    43b52 <process_fork+0xe4>
   43b3e:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b41:	89 c7                	mov    %eax,%edi
   43b43:	e8 0b f8 ff ff       	call   43353 <process_free>
   43b48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b4d:	e9 ac 01 00 00       	jmp    43cfe <process_fork+0x290>
   43b52:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b56:	48 89 c1             	mov    %rax,%rcx
   43b59:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b5d:	ba 00 10 00 00       	mov    $0x1000,%edx
   43b62:	48 89 ce             	mov    %rcx,%rsi
   43b65:	48 89 c7             	mov    %rax,%rdi
   43b68:	e8 01 02 00 00       	call   43d6e <memcpy>
   43b6d:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   43b71:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b74:	48 63 d0             	movslq %eax,%rdx
   43b77:	48 89 d0             	mov    %rdx,%rax
   43b7a:	48 c1 e0 04          	shl    $0x4,%rax
   43b7e:	48 29 d0             	sub    %rdx,%rax
   43b81:	48 c1 e0 04          	shl    $0x4,%rax
   43b85:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43b8b:	48 8b 00             	mov    (%rax),%rax
   43b8e:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43b92:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43b98:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43b9e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43ba3:	48 89 fa             	mov    %rdi,%rdx
   43ba6:	48 89 c7             	mov    %rax,%rdi
   43ba9:	e8 11 ee ff ff       	call   429bf <virtual_memory_map>
   43bae:	85 c0                	test   %eax,%eax
   43bb0:	0f 84 9f 00 00 00    	je     43c55 <process_fork+0x1e7>
   43bb6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43bb9:	89 c7                	mov    %eax,%edi
   43bbb:	e8 93 f7 ff ff       	call   43353 <process_free>
   43bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43bc5:	e9 34 01 00 00       	jmp    43cfe <process_fork+0x290>
   43bca:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43bcd:	48 98                	cltq   
   43bcf:	83 e0 05             	and    $0x5,%eax
   43bd2:	48 83 f8 05          	cmp    $0x5,%rax
   43bd6:	75 7d                	jne    43c55 <process_fork+0x1e7>
   43bd8:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43bdc:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43bdf:	48 63 d0             	movslq %eax,%rdx
   43be2:	48 89 d0             	mov    %rdx,%rax
   43be5:	48 c1 e0 04          	shl    $0x4,%rax
   43be9:	48 29 d0             	sub    %rdx,%rax
   43bec:	48 c1 e0 04          	shl    $0x4,%rax
   43bf0:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43bf6:	48 8b 00             	mov    (%rax),%rax
   43bf9:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43bfd:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43c03:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43c09:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43c0e:	48 89 fa             	mov    %rdi,%rdx
   43c11:	48 89 c7             	mov    %rax,%rdi
   43c14:	e8 a6 ed ff ff       	call   429bf <virtual_memory_map>
   43c19:	85 c0                	test   %eax,%eax
   43c1b:	74 14                	je     43c31 <process_fork+0x1c3>
   43c1d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43c20:	89 c7                	mov    %eax,%edi
   43c22:	e8 2c f7 ff ff       	call   43353 <process_free>
   43c27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43c2c:	e9 cd 00 00 00       	jmp    43cfe <process_fork+0x290>
   43c31:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c35:	48 c1 e8 0c          	shr    $0xc,%rax
   43c39:	89 c2                	mov    %eax,%edx
   43c3b:	48 63 c2             	movslq %edx,%rax
   43c3e:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43c45:	00 
   43c46:	83 c0 01             	add    $0x1,%eax
   43c49:	89 c1                	mov    %eax,%ecx
   43c4b:	48 63 c2             	movslq %edx,%rax
   43c4e:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   43c55:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43c5c:	00 
   43c5d:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43c64:	00 
   43c65:	0f 86 79 fe ff ff    	jbe    43ae4 <process_fork+0x76>
   43c6b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43c6f:	8b 08                	mov    (%rax),%ecx
   43c71:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43c74:	48 63 d0             	movslq %eax,%rdx
   43c77:	48 89 d0             	mov    %rdx,%rax
   43c7a:	48 c1 e0 04          	shl    $0x4,%rax
   43c7e:	48 29 d0             	sub    %rdx,%rax
   43c81:	48 c1 e0 04          	shl    $0x4,%rax
   43c85:	48 8d b0 10 e0 04 00 	lea    0x4e010(%rax),%rsi
   43c8c:	48 63 d1             	movslq %ecx,%rdx
   43c8f:	48 89 d0             	mov    %rdx,%rax
   43c92:	48 c1 e0 04          	shl    $0x4,%rax
   43c96:	48 29 d0             	sub    %rdx,%rax
   43c99:	48 c1 e0 04          	shl    $0x4,%rax
   43c9d:	48 8d 90 10 e0 04 00 	lea    0x4e010(%rax),%rdx
   43ca4:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43ca8:	48 83 c2 08          	add    $0x8,%rdx
   43cac:	b9 18 00 00 00       	mov    $0x18,%ecx
   43cb1:	48 89 c7             	mov    %rax,%rdi
   43cb4:	48 89 d6             	mov    %rdx,%rsi
   43cb7:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43cba:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43cbd:	48 63 d0             	movslq %eax,%rdx
   43cc0:	48 89 d0             	mov    %rdx,%rax
   43cc3:	48 c1 e0 04          	shl    $0x4,%rax
   43cc7:	48 29 d0             	sub    %rdx,%rax
   43cca:	48 c1 e0 04          	shl    $0x4,%rax
   43cce:	48 05 18 e0 04 00    	add    $0x4e018,%rax
   43cd4:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43cdb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43cde:	48 63 d0             	movslq %eax,%rdx
   43ce1:	48 89 d0             	mov    %rdx,%rax
   43ce4:	48 c1 e0 04          	shl    $0x4,%rax
   43ce8:	48 29 d0             	sub    %rdx,%rax
   43ceb:	48 c1 e0 04          	shl    $0x4,%rax
   43cef:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43cf5:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43cfb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43cfe:	c9                   	leave  
   43cff:	c3                   	ret    

0000000000043d00 <process_page_alloc>:
   43d00:	55                   	push   %rbp
   43d01:	48 89 e5             	mov    %rsp,%rbp
   43d04:	48 83 ec 20          	sub    $0x20,%rsp
   43d08:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d0c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43d10:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   43d17:	00 
   43d18:	77 07                	ja     43d21 <process_page_alloc+0x21>
   43d1a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43d1f:	eb 4b                	jmp    43d6c <process_page_alloc+0x6c>
   43d21:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d25:	8b 00                	mov    (%rax),%eax
   43d27:	89 c7                	mov    %eax,%edi
   43d29:	e8 0c f5 ff ff       	call   4323a <palloc>
   43d2e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43d32:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43d37:	74 2e                	je     43d67 <process_page_alloc+0x67>
   43d39:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43d3d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d41:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43d48:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   43d4c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43d52:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43d58:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43d5d:	48 89 c7             	mov    %rax,%rdi
   43d60:	e8 5a ec ff ff       	call   429bf <virtual_memory_map>
   43d65:	eb 05                	jmp    43d6c <process_page_alloc+0x6c>
   43d67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43d6c:	c9                   	leave  
   43d6d:	c3                   	ret    

0000000000043d6e <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43d6e:	f3 0f 1e fa          	endbr64 
   43d72:	55                   	push   %rbp
   43d73:	48 89 e5             	mov    %rsp,%rbp
   43d76:	48 83 ec 28          	sub    $0x28,%rsp
   43d7a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d7e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43d82:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43d86:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43d8a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43d8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d92:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43d96:	eb 1c                	jmp    43db4 <memcpy+0x46>
        *d = *s;
   43d98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d9c:	0f b6 10             	movzbl (%rax),%edx
   43d9f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43da3:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43da5:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43daa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43daf:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43db4:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43db9:	75 dd                	jne    43d98 <memcpy+0x2a>
    }
    return dst;
   43dbb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43dbf:	c9                   	leave  
   43dc0:	c3                   	ret    

0000000000043dc1 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43dc1:	f3 0f 1e fa          	endbr64 
   43dc5:	55                   	push   %rbp
   43dc6:	48 89 e5             	mov    %rsp,%rbp
   43dc9:	48 83 ec 28          	sub    $0x28,%rsp
   43dcd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43dd1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43dd5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43dd9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ddd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43de1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43de5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43de9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ded:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43df1:	73 6a                	jae    43e5d <memmove+0x9c>
   43df3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43df7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43dfb:	48 01 d0             	add    %rdx,%rax
   43dfe:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43e02:	73 59                	jae    43e5d <memmove+0x9c>
        s += n, d += n;
   43e04:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e08:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43e0c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e10:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43e14:	eb 17                	jmp    43e2d <memmove+0x6c>
            *--d = *--s;
   43e16:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43e1b:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43e20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e24:	0f b6 10             	movzbl (%rax),%edx
   43e27:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e2b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43e2d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e31:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43e35:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43e39:	48 85 c0             	test   %rax,%rax
   43e3c:	75 d8                	jne    43e16 <memmove+0x55>
    if (s < d && s + n > d) {
   43e3e:	eb 2e                	jmp    43e6e <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43e40:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43e44:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43e48:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43e4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e50:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43e54:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43e58:	0f b6 12             	movzbl (%rdx),%edx
   43e5b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43e5d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e61:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43e65:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43e69:	48 85 c0             	test   %rax,%rax
   43e6c:	75 d2                	jne    43e40 <memmove+0x7f>
        }
    }
    return dst;
   43e6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43e72:	c9                   	leave  
   43e73:	c3                   	ret    

0000000000043e74 <memset>:

void* memset(void* v, int c, size_t n) {
   43e74:	f3 0f 1e fa          	endbr64 
   43e78:	55                   	push   %rbp
   43e79:	48 89 e5             	mov    %rsp,%rbp
   43e7c:	48 83 ec 28          	sub    $0x28,%rsp
   43e80:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43e84:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43e87:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43e8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e8f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43e93:	eb 15                	jmp    43eaa <memset+0x36>
        *p = c;
   43e95:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43e98:	89 c2                	mov    %eax,%edx
   43e9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e9e:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43ea0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43ea5:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43eaa:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43eaf:	75 e4                	jne    43e95 <memset+0x21>
    }
    return v;
   43eb1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43eb5:	c9                   	leave  
   43eb6:	c3                   	ret    

0000000000043eb7 <strlen>:

size_t strlen(const char* s) {
   43eb7:	f3 0f 1e fa          	endbr64 
   43ebb:	55                   	push   %rbp
   43ebc:	48 89 e5             	mov    %rsp,%rbp
   43ebf:	48 83 ec 18          	sub    $0x18,%rsp
   43ec3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43ec7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43ece:	00 
   43ecf:	eb 0a                	jmp    43edb <strlen+0x24>
        ++n;
   43ed1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43ed6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43edb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43edf:	0f b6 00             	movzbl (%rax),%eax
   43ee2:	84 c0                	test   %al,%al
   43ee4:	75 eb                	jne    43ed1 <strlen+0x1a>
    }
    return n;
   43ee6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43eea:	c9                   	leave  
   43eeb:	c3                   	ret    

0000000000043eec <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43eec:	f3 0f 1e fa          	endbr64 
   43ef0:	55                   	push   %rbp
   43ef1:	48 89 e5             	mov    %rsp,%rbp
   43ef4:	48 83 ec 20          	sub    $0x20,%rsp
   43ef8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43efc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43f00:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43f07:	00 
   43f08:	eb 0a                	jmp    43f14 <strnlen+0x28>
        ++n;
   43f0a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43f0f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43f14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f18:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43f1c:	74 0b                	je     43f29 <strnlen+0x3d>
   43f1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f22:	0f b6 00             	movzbl (%rax),%eax
   43f25:	84 c0                	test   %al,%al
   43f27:	75 e1                	jne    43f0a <strnlen+0x1e>
    }
    return n;
   43f29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43f2d:	c9                   	leave  
   43f2e:	c3                   	ret    

0000000000043f2f <strcpy>:

char* strcpy(char* dst, const char* src) {
   43f2f:	f3 0f 1e fa          	endbr64 
   43f33:	55                   	push   %rbp
   43f34:	48 89 e5             	mov    %rsp,%rbp
   43f37:	48 83 ec 20          	sub    $0x20,%rsp
   43f3b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43f3f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43f43:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f47:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43f4b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43f4f:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43f53:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43f57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f5b:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43f5f:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43f63:	0f b6 12             	movzbl (%rdx),%edx
   43f66:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43f68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f6c:	48 83 e8 01          	sub    $0x1,%rax
   43f70:	0f b6 00             	movzbl (%rax),%eax
   43f73:	84 c0                	test   %al,%al
   43f75:	75 d4                	jne    43f4b <strcpy+0x1c>
    return dst;
   43f77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43f7b:	c9                   	leave  
   43f7c:	c3                   	ret    

0000000000043f7d <strcmp>:

int strcmp(const char* a, const char* b) {
   43f7d:	f3 0f 1e fa          	endbr64 
   43f81:	55                   	push   %rbp
   43f82:	48 89 e5             	mov    %rsp,%rbp
   43f85:	48 83 ec 10          	sub    $0x10,%rsp
   43f89:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43f8d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43f91:	eb 0a                	jmp    43f9d <strcmp+0x20>
        ++a, ++b;
   43f93:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43f98:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43f9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fa1:	0f b6 00             	movzbl (%rax),%eax
   43fa4:	84 c0                	test   %al,%al
   43fa6:	74 1d                	je     43fc5 <strcmp+0x48>
   43fa8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fac:	0f b6 00             	movzbl (%rax),%eax
   43faf:	84 c0                	test   %al,%al
   43fb1:	74 12                	je     43fc5 <strcmp+0x48>
   43fb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fb7:	0f b6 10             	movzbl (%rax),%edx
   43fba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fbe:	0f b6 00             	movzbl (%rax),%eax
   43fc1:	38 c2                	cmp    %al,%dl
   43fc3:	74 ce                	je     43f93 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43fc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fc9:	0f b6 00             	movzbl (%rax),%eax
   43fcc:	89 c2                	mov    %eax,%edx
   43fce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fd2:	0f b6 00             	movzbl (%rax),%eax
   43fd5:	38 c2                	cmp    %al,%dl
   43fd7:	0f 97 c0             	seta   %al
   43fda:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43fdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fe1:	0f b6 00             	movzbl (%rax),%eax
   43fe4:	89 c1                	mov    %eax,%ecx
   43fe6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fea:	0f b6 00             	movzbl (%rax),%eax
   43fed:	38 c1                	cmp    %al,%cl
   43fef:	0f 92 c0             	setb   %al
   43ff2:	0f b6 c8             	movzbl %al,%ecx
   43ff5:	89 d0                	mov    %edx,%eax
   43ff7:	29 c8                	sub    %ecx,%eax
}
   43ff9:	c9                   	leave  
   43ffa:	c3                   	ret    

0000000000043ffb <strchr>:

char* strchr(const char* s, int c) {
   43ffb:	f3 0f 1e fa          	endbr64 
   43fff:	55                   	push   %rbp
   44000:	48 89 e5             	mov    %rsp,%rbp
   44003:	48 83 ec 10          	sub    $0x10,%rsp
   44007:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4400b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   4400e:	eb 05                	jmp    44015 <strchr+0x1a>
        ++s;
   44010:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   44015:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44019:	0f b6 00             	movzbl (%rax),%eax
   4401c:	84 c0                	test   %al,%al
   4401e:	74 0e                	je     4402e <strchr+0x33>
   44020:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44024:	0f b6 00             	movzbl (%rax),%eax
   44027:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4402a:	38 d0                	cmp    %dl,%al
   4402c:	75 e2                	jne    44010 <strchr+0x15>
    }
    if (*s == (char) c) {
   4402e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44032:	0f b6 00             	movzbl (%rax),%eax
   44035:	8b 55 f4             	mov    -0xc(%rbp),%edx
   44038:	38 d0                	cmp    %dl,%al
   4403a:	75 06                	jne    44042 <strchr+0x47>
        return (char*) s;
   4403c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44040:	eb 05                	jmp    44047 <strchr+0x4c>
    } else {
        return NULL;
   44042:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   44047:	c9                   	leave  
   44048:	c3                   	ret    

0000000000044049 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   44049:	f3 0f 1e fa          	endbr64 
   4404d:	55                   	push   %rbp
   4404e:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   44051:	8b 05 b1 2f 01 00    	mov    0x12fb1(%rip),%eax        # 57008 <rand_seed_set>
   44057:	85 c0                	test   %eax,%eax
   44059:	75 0a                	jne    44065 <rand+0x1c>
        srand(819234718U);
   4405b:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   44060:	e8 24 00 00 00       	call   44089 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   44065:	8b 05 a1 2f 01 00    	mov    0x12fa1(%rip),%eax        # 5700c <rand_seed>
   4406b:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   44071:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   44076:	89 05 90 2f 01 00    	mov    %eax,0x12f90(%rip)        # 5700c <rand_seed>
    return rand_seed & RAND_MAX;
   4407c:	8b 05 8a 2f 01 00    	mov    0x12f8a(%rip),%eax        # 5700c <rand_seed>
   44082:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   44087:	5d                   	pop    %rbp
   44088:	c3                   	ret    

0000000000044089 <srand>:

void srand(unsigned seed) {
   44089:	f3 0f 1e fa          	endbr64 
   4408d:	55                   	push   %rbp
   4408e:	48 89 e5             	mov    %rsp,%rbp
   44091:	48 83 ec 08          	sub    $0x8,%rsp
   44095:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   44098:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4409b:	89 05 6b 2f 01 00    	mov    %eax,0x12f6b(%rip)        # 5700c <rand_seed>
    rand_seed_set = 1;
   440a1:	c7 05 5d 2f 01 00 01 	movl   $0x1,0x12f5d(%rip)        # 57008 <rand_seed_set>
   440a8:	00 00 00 
}
   440ab:	90                   	nop
   440ac:	c9                   	leave  
   440ad:	c3                   	ret    

00000000000440ae <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   440ae:	f3 0f 1e fa          	endbr64 
   440b2:	55                   	push   %rbp
   440b3:	48 89 e5             	mov    %rsp,%rbp
   440b6:	48 83 ec 28          	sub    $0x28,%rsp
   440ba:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   440be:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   440c2:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   440c5:	48 8d 05 74 1a 00 00 	lea    0x1a74(%rip),%rax        # 45b40 <upper_digits.1>
   440cc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   440d0:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   440d4:	79 0e                	jns    440e4 <fill_numbuf+0x36>
        digits = lower_digits;
   440d6:	48 8d 05 83 1a 00 00 	lea    0x1a83(%rip),%rax        # 45b60 <lower_digits.0>
   440dd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   440e1:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   440e4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   440e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   440ed:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   440f0:	8b 45 dc             	mov    -0x24(%rbp),%eax
   440f3:	48 63 c8             	movslq %eax,%rcx
   440f6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   440fa:	ba 00 00 00 00       	mov    $0x0,%edx
   440ff:	48 f7 f1             	div    %rcx
   44102:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44106:	48 01 d0             	add    %rdx,%rax
   44109:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4410e:	0f b6 10             	movzbl (%rax),%edx
   44111:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44115:	88 10                	mov    %dl,(%rax)
        val /= base;
   44117:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4411a:	48 63 f0             	movslq %eax,%rsi
   4411d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44121:	ba 00 00 00 00       	mov    $0x0,%edx
   44126:	48 f7 f6             	div    %rsi
   44129:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   4412d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   44132:	75 bc                	jne    440f0 <fill_numbuf+0x42>
    return numbuf_end;
   44134:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   44138:	c9                   	leave  
   44139:	c3                   	ret    

000000000004413a <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   4413a:	f3 0f 1e fa          	endbr64 
   4413e:	55                   	push   %rbp
   4413f:	48 89 e5             	mov    %rsp,%rbp
   44142:	53                   	push   %rbx
   44143:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   4414a:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   44151:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   44157:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4415e:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   44165:	e9 bd 09 00 00       	jmp    44b27 <printer_vprintf+0x9ed>
        if (*format != '%') {
   4416a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44171:	0f b6 00             	movzbl (%rax),%eax
   44174:	3c 25                	cmp    $0x25,%al
   44176:	74 31                	je     441a9 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   44178:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4417f:	4c 8b 00             	mov    (%rax),%r8
   44182:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44189:	0f b6 00             	movzbl (%rax),%eax
   4418c:	0f b6 c8             	movzbl %al,%ecx
   4418f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44195:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4419c:	89 ce                	mov    %ecx,%esi
   4419e:	48 89 c7             	mov    %rax,%rdi
   441a1:	41 ff d0             	call   *%r8
            continue;
   441a4:	e9 76 09 00 00       	jmp    44b1f <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   441a9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   441b0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   441b7:	01 
   441b8:	eb 4d                	jmp    44207 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   441ba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441c1:	0f b6 00             	movzbl (%rax),%eax
   441c4:	0f be c0             	movsbl %al,%eax
   441c7:	89 c6                	mov    %eax,%esi
   441c9:	48 8d 05 70 18 00 00 	lea    0x1870(%rip),%rax        # 45a40 <flag_chars>
   441d0:	48 89 c7             	mov    %rax,%rdi
   441d3:	e8 23 fe ff ff       	call   43ffb <strchr>
   441d8:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   441dc:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   441e1:	74 34                	je     44217 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   441e3:	48 8d 15 56 18 00 00 	lea    0x1856(%rip),%rdx        # 45a40 <flag_chars>
   441ea:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   441ee:	48 29 d0             	sub    %rdx,%rax
   441f1:	ba 01 00 00 00       	mov    $0x1,%edx
   441f6:	89 c1                	mov    %eax,%ecx
   441f8:	d3 e2                	shl    %cl,%edx
   441fa:	89 d0                	mov    %edx,%eax
   441fc:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   441ff:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44206:	01 
   44207:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4420e:	0f b6 00             	movzbl (%rax),%eax
   44211:	84 c0                	test   %al,%al
   44213:	75 a5                	jne    441ba <printer_vprintf+0x80>
   44215:	eb 01                	jmp    44218 <printer_vprintf+0xde>
            } else {
                break;
   44217:	90                   	nop
            }
        }

        // process width
        int width = -1;
   44218:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   4421f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44226:	0f b6 00             	movzbl (%rax),%eax
   44229:	3c 30                	cmp    $0x30,%al
   4422b:	7e 67                	jle    44294 <printer_vprintf+0x15a>
   4422d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44234:	0f b6 00             	movzbl (%rax),%eax
   44237:	3c 39                	cmp    $0x39,%al
   44239:	7f 59                	jg     44294 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4423b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   44242:	eb 2e                	jmp    44272 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   44244:	8b 55 e8             	mov    -0x18(%rbp),%edx
   44247:	89 d0                	mov    %edx,%eax
   44249:	c1 e0 02             	shl    $0x2,%eax
   4424c:	01 d0                	add    %edx,%eax
   4424e:	01 c0                	add    %eax,%eax
   44250:	89 c1                	mov    %eax,%ecx
   44252:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44259:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4425d:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44264:	0f b6 00             	movzbl (%rax),%eax
   44267:	0f be c0             	movsbl %al,%eax
   4426a:	01 c8                	add    %ecx,%eax
   4426c:	83 e8 30             	sub    $0x30,%eax
   4426f:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44272:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44279:	0f b6 00             	movzbl (%rax),%eax
   4427c:	3c 2f                	cmp    $0x2f,%al
   4427e:	0f 8e 85 00 00 00    	jle    44309 <printer_vprintf+0x1cf>
   44284:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4428b:	0f b6 00             	movzbl (%rax),%eax
   4428e:	3c 39                	cmp    $0x39,%al
   44290:	7e b2                	jle    44244 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   44292:	eb 75                	jmp    44309 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   44294:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4429b:	0f b6 00             	movzbl (%rax),%eax
   4429e:	3c 2a                	cmp    $0x2a,%al
   442a0:	75 68                	jne    4430a <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   442a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442a9:	8b 00                	mov    (%rax),%eax
   442ab:	83 f8 2f             	cmp    $0x2f,%eax
   442ae:	77 30                	ja     442e0 <printer_vprintf+0x1a6>
   442b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442b7:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442c2:	8b 00                	mov    (%rax),%eax
   442c4:	89 c0                	mov    %eax,%eax
   442c6:	48 01 d0             	add    %rdx,%rax
   442c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442d0:	8b 12                	mov    (%rdx),%edx
   442d2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442d5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442dc:	89 0a                	mov    %ecx,(%rdx)
   442de:	eb 1a                	jmp    442fa <printer_vprintf+0x1c0>
   442e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442e7:	48 8b 40 08          	mov    0x8(%rax),%rax
   442eb:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442ef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442f6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442fa:	8b 00                	mov    (%rax),%eax
   442fc:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   442ff:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44306:	01 
   44307:	eb 01                	jmp    4430a <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   44309:	90                   	nop
        }

        // process precision
        int precision = -1;
   4430a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   44311:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44318:	0f b6 00             	movzbl (%rax),%eax
   4431b:	3c 2e                	cmp    $0x2e,%al
   4431d:	0f 85 00 01 00 00    	jne    44423 <printer_vprintf+0x2e9>
            ++format;
   44323:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4432a:	01 
            if (*format >= '0' && *format <= '9') {
   4432b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44332:	0f b6 00             	movzbl (%rax),%eax
   44335:	3c 2f                	cmp    $0x2f,%al
   44337:	7e 67                	jle    443a0 <printer_vprintf+0x266>
   44339:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44340:	0f b6 00             	movzbl (%rax),%eax
   44343:	3c 39                	cmp    $0x39,%al
   44345:	7f 59                	jg     443a0 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44347:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   4434e:	eb 2e                	jmp    4437e <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   44350:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   44353:	89 d0                	mov    %edx,%eax
   44355:	c1 e0 02             	shl    $0x2,%eax
   44358:	01 d0                	add    %edx,%eax
   4435a:	01 c0                	add    %eax,%eax
   4435c:	89 c1                	mov    %eax,%ecx
   4435e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44365:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44369:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44370:	0f b6 00             	movzbl (%rax),%eax
   44373:	0f be c0             	movsbl %al,%eax
   44376:	01 c8                	add    %ecx,%eax
   44378:	83 e8 30             	sub    $0x30,%eax
   4437b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4437e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44385:	0f b6 00             	movzbl (%rax),%eax
   44388:	3c 2f                	cmp    $0x2f,%al
   4438a:	0f 8e 85 00 00 00    	jle    44415 <printer_vprintf+0x2db>
   44390:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44397:	0f b6 00             	movzbl (%rax),%eax
   4439a:	3c 39                	cmp    $0x39,%al
   4439c:	7e b2                	jle    44350 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   4439e:	eb 75                	jmp    44415 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   443a0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   443a7:	0f b6 00             	movzbl (%rax),%eax
   443aa:	3c 2a                	cmp    $0x2a,%al
   443ac:	75 68                	jne    44416 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   443ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443b5:	8b 00                	mov    (%rax),%eax
   443b7:	83 f8 2f             	cmp    $0x2f,%eax
   443ba:	77 30                	ja     443ec <printer_vprintf+0x2b2>
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
   443ea:	eb 1a                	jmp    44406 <printer_vprintf+0x2cc>
   443ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443f3:	48 8b 40 08          	mov    0x8(%rax),%rax
   443f7:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443fb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44402:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44406:	8b 00                	mov    (%rax),%eax
   44408:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   4440b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44412:	01 
   44413:	eb 01                	jmp    44416 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   44415:	90                   	nop
            }
            if (precision < 0) {
   44416:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4441a:	79 07                	jns    44423 <printer_vprintf+0x2e9>
                precision = 0;
   4441c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   44423:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   4442a:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   44431:	00 
        int length = 0;
   44432:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   44439:	48 8d 05 06 16 00 00 	lea    0x1606(%rip),%rax        # 45a46 <flag_chars+0x6>
   44440:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   44444:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4444b:	0f b6 00             	movzbl (%rax),%eax
   4444e:	0f be c0             	movsbl %al,%eax
   44451:	83 e8 43             	sub    $0x43,%eax
   44454:	83 f8 37             	cmp    $0x37,%eax
   44457:	0f 87 b6 03 00 00    	ja     44813 <printer_vprintf+0x6d9>
   4445d:	89 c0                	mov    %eax,%eax
   4445f:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   44466:	00 
   44467:	48 8d 05 e6 15 00 00 	lea    0x15e6(%rip),%rax        # 45a54 <flag_chars+0x14>
   4446e:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   44471:	48 98                	cltq   
   44473:	48 8d 15 da 15 00 00 	lea    0x15da(%rip),%rdx        # 45a54 <flag_chars+0x14>
   4447a:	48 01 d0             	add    %rdx,%rax
   4447d:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   44480:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   44487:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4448e:	01 
            goto again;
   4448f:	eb b3                	jmp    44444 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   44491:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44495:	74 5d                	je     444f4 <printer_vprintf+0x3ba>
   44497:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4449e:	8b 00                	mov    (%rax),%eax
   444a0:	83 f8 2f             	cmp    $0x2f,%eax
   444a3:	77 30                	ja     444d5 <printer_vprintf+0x39b>
   444a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444ac:	48 8b 50 10          	mov    0x10(%rax),%rdx
   444b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444b7:	8b 00                	mov    (%rax),%eax
   444b9:	89 c0                	mov    %eax,%eax
   444bb:	48 01 d0             	add    %rdx,%rax
   444be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444c5:	8b 12                	mov    (%rdx),%edx
   444c7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   444ca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444d1:	89 0a                	mov    %ecx,(%rdx)
   444d3:	eb 1a                	jmp    444ef <printer_vprintf+0x3b5>
   444d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444dc:	48 8b 40 08          	mov    0x8(%rax),%rax
   444e0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   444e4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444eb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444ef:	48 8b 00             	mov    (%rax),%rax
   444f2:	eb 5c                	jmp    44550 <printer_vprintf+0x416>
   444f4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444fb:	8b 00                	mov    (%rax),%eax
   444fd:	83 f8 2f             	cmp    $0x2f,%eax
   44500:	77 30                	ja     44532 <printer_vprintf+0x3f8>
   44502:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44509:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4450d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44514:	8b 00                	mov    (%rax),%eax
   44516:	89 c0                	mov    %eax,%eax
   44518:	48 01 d0             	add    %rdx,%rax
   4451b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44522:	8b 12                	mov    (%rdx),%edx
   44524:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44527:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4452e:	89 0a                	mov    %ecx,(%rdx)
   44530:	eb 1a                	jmp    4454c <printer_vprintf+0x412>
   44532:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44539:	48 8b 40 08          	mov    0x8(%rax),%rax
   4453d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44541:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44548:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4454c:	8b 00                	mov    (%rax),%eax
   4454e:	48 98                	cltq   
   44550:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   44554:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44558:	48 c1 f8 38          	sar    $0x38,%rax
   4455c:	25 80 00 00 00       	and    $0x80,%eax
   44561:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   44564:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   44568:	74 09                	je     44573 <printer_vprintf+0x439>
   4456a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4456e:	48 f7 d8             	neg    %rax
   44571:	eb 04                	jmp    44577 <printer_vprintf+0x43d>
   44573:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44577:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   4457b:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   4457e:	83 c8 60             	or     $0x60,%eax
   44581:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   44584:	e9 cf 02 00 00       	jmp    44858 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   44589:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4458d:	74 5d                	je     445ec <printer_vprintf+0x4b2>
   4458f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44596:	8b 00                	mov    (%rax),%eax
   44598:	83 f8 2f             	cmp    $0x2f,%eax
   4459b:	77 30                	ja     445cd <printer_vprintf+0x493>
   4459d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445a4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445af:	8b 00                	mov    (%rax),%eax
   445b1:	89 c0                	mov    %eax,%eax
   445b3:	48 01 d0             	add    %rdx,%rax
   445b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445bd:	8b 12                	mov    (%rdx),%edx
   445bf:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445c2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445c9:	89 0a                	mov    %ecx,(%rdx)
   445cb:	eb 1a                	jmp    445e7 <printer_vprintf+0x4ad>
   445cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445d4:	48 8b 40 08          	mov    0x8(%rax),%rax
   445d8:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445e3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445e7:	48 8b 00             	mov    (%rax),%rax
   445ea:	eb 5c                	jmp    44648 <printer_vprintf+0x50e>
   445ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445f3:	8b 00                	mov    (%rax),%eax
   445f5:	83 f8 2f             	cmp    $0x2f,%eax
   445f8:	77 30                	ja     4462a <printer_vprintf+0x4f0>
   445fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44601:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44605:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4460c:	8b 00                	mov    (%rax),%eax
   4460e:	89 c0                	mov    %eax,%eax
   44610:	48 01 d0             	add    %rdx,%rax
   44613:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4461a:	8b 12                	mov    (%rdx),%edx
   4461c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4461f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44626:	89 0a                	mov    %ecx,(%rdx)
   44628:	eb 1a                	jmp    44644 <printer_vprintf+0x50a>
   4462a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44631:	48 8b 40 08          	mov    0x8(%rax),%rax
   44635:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44639:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44640:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44644:	8b 00                	mov    (%rax),%eax
   44646:	89 c0                	mov    %eax,%eax
   44648:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   4464c:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44650:	e9 03 02 00 00       	jmp    44858 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   44655:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   4465c:	e9 28 ff ff ff       	jmp    44589 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   44661:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   44668:	e9 1c ff ff ff       	jmp    44589 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   4466d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44674:	8b 00                	mov    (%rax),%eax
   44676:	83 f8 2f             	cmp    $0x2f,%eax
   44679:	77 30                	ja     446ab <printer_vprintf+0x571>
   4467b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44682:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44686:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4468d:	8b 00                	mov    (%rax),%eax
   4468f:	89 c0                	mov    %eax,%eax
   44691:	48 01 d0             	add    %rdx,%rax
   44694:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4469b:	8b 12                	mov    (%rdx),%edx
   4469d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   446a0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446a7:	89 0a                	mov    %ecx,(%rdx)
   446a9:	eb 1a                	jmp    446c5 <printer_vprintf+0x58b>
   446ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446b2:	48 8b 40 08          	mov    0x8(%rax),%rax
   446b6:	48 8d 48 08          	lea    0x8(%rax),%rcx
   446ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446c1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   446c5:	48 8b 00             	mov    (%rax),%rax
   446c8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   446cc:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   446d3:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   446da:	e9 79 01 00 00       	jmp    44858 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   446df:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446e6:	8b 00                	mov    (%rax),%eax
   446e8:	83 f8 2f             	cmp    $0x2f,%eax
   446eb:	77 30                	ja     4471d <printer_vprintf+0x5e3>
   446ed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446f4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   446f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446ff:	8b 00                	mov    (%rax),%eax
   44701:	89 c0                	mov    %eax,%eax
   44703:	48 01 d0             	add    %rdx,%rax
   44706:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4470d:	8b 12                	mov    (%rdx),%edx
   4470f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44712:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44719:	89 0a                	mov    %ecx,(%rdx)
   4471b:	eb 1a                	jmp    44737 <printer_vprintf+0x5fd>
   4471d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44724:	48 8b 40 08          	mov    0x8(%rax),%rax
   44728:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4472c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44733:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44737:	48 8b 00             	mov    (%rax),%rax
   4473a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   4473e:	e9 15 01 00 00       	jmp    44858 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   44743:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4474a:	8b 00                	mov    (%rax),%eax
   4474c:	83 f8 2f             	cmp    $0x2f,%eax
   4474f:	77 30                	ja     44781 <printer_vprintf+0x647>
   44751:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44758:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4475c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44763:	8b 00                	mov    (%rax),%eax
   44765:	89 c0                	mov    %eax,%eax
   44767:	48 01 d0             	add    %rdx,%rax
   4476a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44771:	8b 12                	mov    (%rdx),%edx
   44773:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44776:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4477d:	89 0a                	mov    %ecx,(%rdx)
   4477f:	eb 1a                	jmp    4479b <printer_vprintf+0x661>
   44781:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44788:	48 8b 40 08          	mov    0x8(%rax),%rax
   4478c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44790:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44797:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4479b:	8b 00                	mov    (%rax),%eax
   4479d:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   447a3:	e9 77 03 00 00       	jmp    44b1f <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   447a8:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   447ac:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   447b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447b7:	8b 00                	mov    (%rax),%eax
   447b9:	83 f8 2f             	cmp    $0x2f,%eax
   447bc:	77 30                	ja     447ee <printer_vprintf+0x6b4>
   447be:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447c5:	48 8b 50 10          	mov    0x10(%rax),%rdx
   447c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447d0:	8b 00                	mov    (%rax),%eax
   447d2:	89 c0                	mov    %eax,%eax
   447d4:	48 01 d0             	add    %rdx,%rax
   447d7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447de:	8b 12                	mov    (%rdx),%edx
   447e0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   447e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447ea:	89 0a                	mov    %ecx,(%rdx)
   447ec:	eb 1a                	jmp    44808 <printer_vprintf+0x6ce>
   447ee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447f5:	48 8b 40 08          	mov    0x8(%rax),%rax
   447f9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   447fd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44804:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44808:	8b 00                	mov    (%rax),%eax
   4480a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   4480d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   44811:	eb 45                	jmp    44858 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   44813:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44817:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   4481b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44822:	0f b6 00             	movzbl (%rax),%eax
   44825:	84 c0                	test   %al,%al
   44827:	74 0c                	je     44835 <printer_vprintf+0x6fb>
   44829:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44830:	0f b6 00             	movzbl (%rax),%eax
   44833:	eb 05                	jmp    4483a <printer_vprintf+0x700>
   44835:	b8 25 00 00 00       	mov    $0x25,%eax
   4483a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   4483d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   44841:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44848:	0f b6 00             	movzbl (%rax),%eax
   4484b:	84 c0                	test   %al,%al
   4484d:	75 08                	jne    44857 <printer_vprintf+0x71d>
                format--;
   4484f:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44856:	01 
            }
            break;
   44857:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44858:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4485b:	83 e0 20             	and    $0x20,%eax
   4485e:	85 c0                	test   %eax,%eax
   44860:	74 1e                	je     44880 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   44862:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44866:	48 83 c0 18          	add    $0x18,%rax
   4486a:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4486d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44871:	48 89 ce             	mov    %rcx,%rsi
   44874:	48 89 c7             	mov    %rax,%rdi
   44877:	e8 32 f8 ff ff       	call   440ae <fill_numbuf>
   4487c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44880:	48 8d 05 bf 11 00 00 	lea    0x11bf(%rip),%rax        # 45a46 <flag_chars+0x6>
   44887:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   4488b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4488e:	83 e0 20             	and    $0x20,%eax
   44891:	85 c0                	test   %eax,%eax
   44893:	74 51                	je     448e6 <printer_vprintf+0x7ac>
   44895:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44898:	83 e0 40             	and    $0x40,%eax
   4489b:	85 c0                	test   %eax,%eax
   4489d:	74 47                	je     448e6 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   4489f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   448a2:	25 80 00 00 00       	and    $0x80,%eax
   448a7:	85 c0                	test   %eax,%eax
   448a9:	74 0d                	je     448b8 <printer_vprintf+0x77e>
                prefix = "-";
   448ab:	48 8d 05 95 11 00 00 	lea    0x1195(%rip),%rax        # 45a47 <flag_chars+0x7>
   448b2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   448b6:	eb 7d                	jmp    44935 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   448b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   448bb:	83 e0 10             	and    $0x10,%eax
   448be:	85 c0                	test   %eax,%eax
   448c0:	74 0d                	je     448cf <printer_vprintf+0x795>
                prefix = "+";
   448c2:	48 8d 05 80 11 00 00 	lea    0x1180(%rip),%rax        # 45a49 <flag_chars+0x9>
   448c9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   448cd:	eb 66                	jmp    44935 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   448cf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   448d2:	83 e0 08             	and    $0x8,%eax
   448d5:	85 c0                	test   %eax,%eax
   448d7:	74 5c                	je     44935 <printer_vprintf+0x7fb>
                prefix = " ";
   448d9:	48 8d 05 6b 11 00 00 	lea    0x116b(%rip),%rax        # 45a4b <flag_chars+0xb>
   448e0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   448e4:	eb 4f                	jmp    44935 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   448e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   448e9:	83 e0 20             	and    $0x20,%eax
   448ec:	85 c0                	test   %eax,%eax
   448ee:	74 46                	je     44936 <printer_vprintf+0x7fc>
   448f0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   448f3:	83 e0 01             	and    $0x1,%eax
   448f6:	85 c0                	test   %eax,%eax
   448f8:	74 3c                	je     44936 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   448fa:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   448fe:	74 06                	je     44906 <printer_vprintf+0x7cc>
   44900:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44904:	75 30                	jne    44936 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   44906:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4490b:	75 0c                	jne    44919 <printer_vprintf+0x7df>
   4490d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44910:	25 00 01 00 00       	and    $0x100,%eax
   44915:	85 c0                	test   %eax,%eax
   44917:	74 1d                	je     44936 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   44919:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4491d:	75 09                	jne    44928 <printer_vprintf+0x7ee>
   4491f:	48 8d 05 27 11 00 00 	lea    0x1127(%rip),%rax        # 45a4d <flag_chars+0xd>
   44926:	eb 07                	jmp    4492f <printer_vprintf+0x7f5>
   44928:	48 8d 05 21 11 00 00 	lea    0x1121(%rip),%rax        # 45a50 <flag_chars+0x10>
   4492f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44933:	eb 01                	jmp    44936 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   44935:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44936:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4493a:	78 24                	js     44960 <printer_vprintf+0x826>
   4493c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4493f:	83 e0 20             	and    $0x20,%eax
   44942:	85 c0                	test   %eax,%eax
   44944:	75 1a                	jne    44960 <printer_vprintf+0x826>
            len = strnlen(data, precision);
   44946:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44949:	48 63 d0             	movslq %eax,%rdx
   4494c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44950:	48 89 d6             	mov    %rdx,%rsi
   44953:	48 89 c7             	mov    %rax,%rdi
   44956:	e8 91 f5 ff ff       	call   43eec <strnlen>
   4495b:	89 45 bc             	mov    %eax,-0x44(%rbp)
   4495e:	eb 0f                	jmp    4496f <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   44960:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44964:	48 89 c7             	mov    %rax,%rdi
   44967:	e8 4b f5 ff ff       	call   43eb7 <strlen>
   4496c:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   4496f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44972:	83 e0 20             	and    $0x20,%eax
   44975:	85 c0                	test   %eax,%eax
   44977:	74 20                	je     44999 <printer_vprintf+0x85f>
   44979:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4497d:	78 1a                	js     44999 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   4497f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44982:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44985:	7e 08                	jle    4498f <printer_vprintf+0x855>
   44987:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4498a:	2b 45 bc             	sub    -0x44(%rbp),%eax
   4498d:	eb 05                	jmp    44994 <printer_vprintf+0x85a>
   4498f:	b8 00 00 00 00       	mov    $0x0,%eax
   44994:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44997:	eb 5c                	jmp    449f5 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44999:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4499c:	83 e0 20             	and    $0x20,%eax
   4499f:	85 c0                	test   %eax,%eax
   449a1:	74 4b                	je     449ee <printer_vprintf+0x8b4>
   449a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   449a6:	83 e0 02             	and    $0x2,%eax
   449a9:	85 c0                	test   %eax,%eax
   449ab:	74 41                	je     449ee <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   449ad:	8b 45 ec             	mov    -0x14(%rbp),%eax
   449b0:	83 e0 04             	and    $0x4,%eax
   449b3:	85 c0                	test   %eax,%eax
   449b5:	75 37                	jne    449ee <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   449b7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   449bb:	48 89 c7             	mov    %rax,%rdi
   449be:	e8 f4 f4 ff ff       	call   43eb7 <strlen>
   449c3:	89 c2                	mov    %eax,%edx
   449c5:	8b 45 bc             	mov    -0x44(%rbp),%eax
   449c8:	01 d0                	add    %edx,%eax
   449ca:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   449cd:	7e 1f                	jle    449ee <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   449cf:	8b 45 e8             	mov    -0x18(%rbp),%eax
   449d2:	2b 45 bc             	sub    -0x44(%rbp),%eax
   449d5:	89 c3                	mov    %eax,%ebx
   449d7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   449db:	48 89 c7             	mov    %rax,%rdi
   449de:	e8 d4 f4 ff ff       	call   43eb7 <strlen>
   449e3:	89 c2                	mov    %eax,%edx
   449e5:	89 d8                	mov    %ebx,%eax
   449e7:	29 d0                	sub    %edx,%eax
   449e9:	89 45 b8             	mov    %eax,-0x48(%rbp)
   449ec:	eb 07                	jmp    449f5 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   449ee:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   449f5:	8b 55 bc             	mov    -0x44(%rbp),%edx
   449f8:	8b 45 b8             	mov    -0x48(%rbp),%eax
   449fb:	01 d0                	add    %edx,%eax
   449fd:	48 63 d8             	movslq %eax,%rbx
   44a00:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44a04:	48 89 c7             	mov    %rax,%rdi
   44a07:	e8 ab f4 ff ff       	call   43eb7 <strlen>
   44a0c:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   44a10:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44a13:	29 d0                	sub    %edx,%eax
   44a15:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44a18:	eb 25                	jmp    44a3f <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   44a1a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44a21:	48 8b 08             	mov    (%rax),%rcx
   44a24:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44a2a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44a31:	be 20 00 00 00       	mov    $0x20,%esi
   44a36:	48 89 c7             	mov    %rax,%rdi
   44a39:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44a3b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44a3f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44a42:	83 e0 04             	and    $0x4,%eax
   44a45:	85 c0                	test   %eax,%eax
   44a47:	75 36                	jne    44a7f <printer_vprintf+0x945>
   44a49:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44a4d:	7f cb                	jg     44a1a <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   44a4f:	eb 2e                	jmp    44a7f <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   44a51:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44a58:	4c 8b 00             	mov    (%rax),%r8
   44a5b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44a5f:	0f b6 00             	movzbl (%rax),%eax
   44a62:	0f b6 c8             	movzbl %al,%ecx
   44a65:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44a6b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44a72:	89 ce                	mov    %ecx,%esi
   44a74:	48 89 c7             	mov    %rax,%rdi
   44a77:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44a7a:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44a7f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44a83:	0f b6 00             	movzbl (%rax),%eax
   44a86:	84 c0                	test   %al,%al
   44a88:	75 c7                	jne    44a51 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   44a8a:	eb 25                	jmp    44ab1 <printer_vprintf+0x977>
            p->putc(p, '0', color);
   44a8c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44a93:	48 8b 08             	mov    (%rax),%rcx
   44a96:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44a9c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44aa3:	be 30 00 00 00       	mov    $0x30,%esi
   44aa8:	48 89 c7             	mov    %rax,%rdi
   44aab:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44aad:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44ab1:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44ab5:	7f d5                	jg     44a8c <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   44ab7:	eb 32                	jmp    44aeb <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   44ab9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44ac0:	4c 8b 00             	mov    (%rax),%r8
   44ac3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44ac7:	0f b6 00             	movzbl (%rax),%eax
   44aca:	0f b6 c8             	movzbl %al,%ecx
   44acd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44ad3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44ada:	89 ce                	mov    %ecx,%esi
   44adc:	48 89 c7             	mov    %rax,%rdi
   44adf:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   44ae2:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44ae7:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44aeb:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44aef:	7f c8                	jg     44ab9 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   44af1:	eb 25                	jmp    44b18 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   44af3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44afa:	48 8b 08             	mov    (%rax),%rcx
   44afd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44b03:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44b0a:	be 20 00 00 00       	mov    $0x20,%esi
   44b0f:	48 89 c7             	mov    %rax,%rdi
   44b12:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44b14:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44b18:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44b1c:	7f d5                	jg     44af3 <printer_vprintf+0x9b9>
        }
    done: ;
   44b1e:	90                   	nop
    for (; *format; ++format) {
   44b1f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44b26:	01 
   44b27:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44b2e:	0f b6 00             	movzbl (%rax),%eax
   44b31:	84 c0                	test   %al,%al
   44b33:	0f 85 31 f6 ff ff    	jne    4416a <printer_vprintf+0x30>
    }
}
   44b39:	90                   	nop
   44b3a:	90                   	nop
   44b3b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44b3f:	c9                   	leave  
   44b40:	c3                   	ret    

0000000000044b41 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   44b41:	f3 0f 1e fa          	endbr64 
   44b45:	55                   	push   %rbp
   44b46:	48 89 e5             	mov    %rsp,%rbp
   44b49:	48 83 ec 20          	sub    $0x20,%rsp
   44b4d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44b51:	89 f0                	mov    %esi,%eax
   44b53:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44b56:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44b59:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44b5d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44b61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b65:	48 8b 40 08          	mov    0x8(%rax),%rax
   44b69:	48 8d 15 30 44 07 00 	lea    0x74430(%rip),%rdx        # b8fa0 <console+0xfa0>
   44b70:	48 39 d0             	cmp    %rdx,%rax
   44b73:	72 0f                	jb     44b84 <console_putc+0x43>
        cp->cursor = console;
   44b75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b79:	48 8d 15 80 34 07 00 	lea    0x73480(%rip),%rdx        # b8000 <console>
   44b80:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   44b84:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44b88:	0f 85 82 00 00 00    	jne    44c10 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   44b8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b92:	48 8b 40 08          	mov    0x8(%rax),%rax
   44b96:	48 8d 15 63 34 07 00 	lea    0x73463(%rip),%rdx        # b8000 <console>
   44b9d:	48 29 d0             	sub    %rdx,%rax
   44ba0:	48 d1 f8             	sar    %rax
   44ba3:	48 89 c1             	mov    %rax,%rcx
   44ba6:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44bad:	66 66 66 
   44bb0:	48 89 c8             	mov    %rcx,%rax
   44bb3:	48 f7 ea             	imul   %rdx
   44bb6:	48 89 d0             	mov    %rdx,%rax
   44bb9:	48 c1 f8 05          	sar    $0x5,%rax
   44bbd:	48 89 ce             	mov    %rcx,%rsi
   44bc0:	48 c1 fe 3f          	sar    $0x3f,%rsi
   44bc4:	48 29 f0             	sub    %rsi,%rax
   44bc7:	48 89 c2             	mov    %rax,%rdx
   44bca:	48 89 d0             	mov    %rdx,%rax
   44bcd:	48 c1 e0 02          	shl    $0x2,%rax
   44bd1:	48 01 d0             	add    %rdx,%rax
   44bd4:	48 c1 e0 04          	shl    $0x4,%rax
   44bd8:	48 29 c1             	sub    %rax,%rcx
   44bdb:	48 89 ca             	mov    %rcx,%rdx
   44bde:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44be1:	eb 25                	jmp    44c08 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   44be3:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44be6:	83 c8 20             	or     $0x20,%eax
   44be9:	89 c6                	mov    %eax,%esi
   44beb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44bef:	48 8b 40 08          	mov    0x8(%rax),%rax
   44bf3:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44bf7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44bfb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44bff:	89 f2                	mov    %esi,%edx
   44c01:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44c04:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44c08:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44c0c:	75 d5                	jne    44be3 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44c0e:	eb 24                	jmp    44c34 <console_putc+0xf3>
        *cp->cursor++ = c | color;
   44c10:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44c14:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44c17:	89 d6                	mov    %edx,%esi
   44c19:	09 c6                	or     %eax,%esi
   44c1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44c1f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44c23:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44c27:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44c2b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44c2f:	89 f2                	mov    %esi,%edx
   44c31:	66 89 10             	mov    %dx,(%rax)
}
   44c34:	90                   	nop
   44c35:	c9                   	leave  
   44c36:	c3                   	ret    

0000000000044c37 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44c37:	f3 0f 1e fa          	endbr64 
   44c3b:	55                   	push   %rbp
   44c3c:	48 89 e5             	mov    %rsp,%rbp
   44c3f:	48 83 ec 30          	sub    $0x30,%rsp
   44c43:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44c46:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44c49:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44c4d:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44c51:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 44b41 <console_putc>
   44c58:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44c5c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44c60:	78 09                	js     44c6b <console_vprintf+0x34>
   44c62:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44c69:	7e 07                	jle    44c72 <console_vprintf+0x3b>
        cpos = 0;
   44c6b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44c72:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c75:	48 98                	cltq   
   44c77:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44c7b:	48 8d 05 7e 33 07 00 	lea    0x7337e(%rip),%rax        # b8000 <console>
   44c82:	48 01 d0             	add    %rdx,%rax
   44c85:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44c89:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44c8d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44c91:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44c94:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44c98:	48 89 c7             	mov    %rax,%rdi
   44c9b:	e8 9a f4 ff ff       	call   4413a <printer_vprintf>
    return cp.cursor - console;
   44ca0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44ca4:	48 8d 15 55 33 07 00 	lea    0x73355(%rip),%rdx        # b8000 <console>
   44cab:	48 29 d0             	sub    %rdx,%rax
   44cae:	48 d1 f8             	sar    %rax
}
   44cb1:	c9                   	leave  
   44cb2:	c3                   	ret    

0000000000044cb3 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44cb3:	f3 0f 1e fa          	endbr64 
   44cb7:	55                   	push   %rbp
   44cb8:	48 89 e5             	mov    %rsp,%rbp
   44cbb:	48 83 ec 60          	sub    $0x60,%rsp
   44cbf:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44cc2:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44cc5:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44cc9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44ccd:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44cd1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44cd5:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44cdc:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44ce0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44ce4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44ce8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44cec:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44cf0:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44cf4:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44cf7:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44cfa:	89 c7                	mov    %eax,%edi
   44cfc:	e8 36 ff ff ff       	call   44c37 <console_vprintf>
   44d01:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44d04:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44d07:	c9                   	leave  
   44d08:	c3                   	ret    

0000000000044d09 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44d09:	f3 0f 1e fa          	endbr64 
   44d0d:	55                   	push   %rbp
   44d0e:	48 89 e5             	mov    %rsp,%rbp
   44d11:	48 83 ec 20          	sub    $0x20,%rsp
   44d15:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44d19:	89 f0                	mov    %esi,%eax
   44d1b:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44d1e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44d21:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44d25:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44d29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44d2d:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44d31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44d35:	48 8b 40 10          	mov    0x10(%rax),%rax
   44d39:	48 39 c2             	cmp    %rax,%rdx
   44d3c:	73 1a                	jae    44d58 <string_putc+0x4f>
        *sp->s++ = c;
   44d3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44d42:	48 8b 40 08          	mov    0x8(%rax),%rax
   44d46:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44d4a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44d4e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44d52:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44d56:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44d58:	90                   	nop
   44d59:	c9                   	leave  
   44d5a:	c3                   	ret    

0000000000044d5b <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44d5b:	f3 0f 1e fa          	endbr64 
   44d5f:	55                   	push   %rbp
   44d60:	48 89 e5             	mov    %rsp,%rbp
   44d63:	48 83 ec 40          	sub    $0x40,%rsp
   44d67:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44d6b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44d6f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44d73:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44d77:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 44d09 <string_putc>
   44d7e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   44d82:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44d86:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44d8a:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44d8f:	74 33                	je     44dc4 <vsnprintf+0x69>
        sp.end = s + size - 1;
   44d91:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44d95:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44d99:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44d9d:	48 01 d0             	add    %rdx,%rax
   44da0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44da4:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44da8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44dac:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44db0:	be 00 00 00 00       	mov    $0x0,%esi
   44db5:	48 89 c7             	mov    %rax,%rdi
   44db8:	e8 7d f3 ff ff       	call   4413a <printer_vprintf>
        *sp.s = 0;
   44dbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44dc1:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44dc4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44dc8:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44dcc:	c9                   	leave  
   44dcd:	c3                   	ret    

0000000000044dce <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44dce:	f3 0f 1e fa          	endbr64 
   44dd2:	55                   	push   %rbp
   44dd3:	48 89 e5             	mov    %rsp,%rbp
   44dd6:	48 83 ec 70          	sub    $0x70,%rsp
   44dda:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44dde:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44de2:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44de6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44dea:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44dee:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44df2:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44df9:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44dfd:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44e01:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44e05:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44e09:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44e0d:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44e11:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44e15:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44e19:	48 89 c7             	mov    %rax,%rdi
   44e1c:	e8 3a ff ff ff       	call   44d5b <vsnprintf>
   44e21:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44e24:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44e27:	c9                   	leave  
   44e28:	c3                   	ret    

0000000000044e29 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44e29:	f3 0f 1e fa          	endbr64 
   44e2d:	55                   	push   %rbp
   44e2e:	48 89 e5             	mov    %rsp,%rbp
   44e31:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44e35:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44e3c:	eb 1a                	jmp    44e58 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   44e3e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44e41:	48 98                	cltq   
   44e43:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44e47:	48 8d 05 b2 31 07 00 	lea    0x731b2(%rip),%rax        # b8000 <console>
   44e4e:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44e54:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44e58:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44e5f:	7e dd                	jle    44e3e <console_clear+0x15>
    }
    cursorpos = 0;
   44e61:	c7 05 91 41 07 00 00 	movl   $0x0,0x74191(%rip)        # b8ffc <cursorpos>
   44e68:	00 00 00 
}
   44e6b:	90                   	nop
   44e6c:	c9                   	leave  
   44e6d:	c3                   	ret    
