
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
   400be:	e8 40 07 00 00       	call   40803 <exception>

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
   40177:	e8 27 17 00 00       	call   418a3 <hardware_init>
    pageinfo_init();
   4017c:	e8 32 0c 00 00       	call   40db3 <pageinfo_init>
    console_clear();
   40181:	e8 a9 4f 00 00       	call   4512f <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 7b 1c 00 00       	call   41e0b <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 5f ee 00 00 	lea    0xee5f(%rip),%rax        # 4f000 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 d1 3f 00 00       	call   4417a <memset>
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
   401c9:	48 8d 15 30 ee 00 00 	lea    0xee30(%rip),%rdx        # 4f000 <processes>
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
   401ed:	48 8d 05 e4 ee 00 00 	lea    0xeee4(%rip),%rax        # 4f0d8 <processes+0xd8>
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
   40210:	48 8d 15 8f 4f 00 00 	lea    0x4f8f(%rip),%rdx        # 451a6 <memstate_colors+0x26>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 61 40 00 00       	call   44283 <strcmp>
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
   40245:	48 8d 15 61 4f 00 00 	lea    0x4f61(%rip),%rdx        # 451ad <memstate_colors+0x2d>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 2c 40 00 00       	call   44283 <strcmp>
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
   4027a:	48 8d 15 37 4f 00 00 	lea    0x4f37(%rip),%rdx        # 451b8 <memstate_colors+0x38>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 f7 3f 00 00       	call   44283 <strcmp>
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
   402ac:	48 8d 15 0a 4f 00 00 	lea    0x4f0a(%rip),%rdx        # 451bd <memstate_colors+0x3d>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 c5 3f 00 00       	call   44283 <strcmp>
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
   402f5:	48 8d 05 f4 ed 00 00 	lea    0xedf4(%rip),%rax        # 4f0f0 <processes+0xf0>
   402fc:	48 89 c7             	mov    %rax,%rdi
   402ff:	e8 07 0a 00 00       	call   40d0b <run>

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
   4032a:	48 8d 15 cf ec 00 00 	lea    0xeccf(%rip),%rdx        # 4f000 <processes>
   40331:	48 01 d0             	add    %rdx,%rax
   40334:	be 00 00 00 00       	mov    $0x0,%esi
   40339:	48 89 c7             	mov    %rax,%rdi
   4033c:	e8 7d 1d 00 00       	call   420be <process_init>
    assert(process_config_tables(pid) == 0);
   40341:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40344:	89 c7                	mov    %eax,%edi
   40346:	e8 f0 35 00 00       	call   4393b <process_config_tables>
   4034b:	85 c0                	test   %eax,%eax
   4034d:	74 1e                	je     4036d <process_setup+0x69>
   4034f:	48 8d 05 72 4e 00 00 	lea    0x4e72(%rip),%rax        # 451c8 <memstate_colors+0x48>
   40356:	48 89 c2             	mov    %rax,%rdx
   40359:	be 77 00 00 00       	mov    $0x77,%esi
   4035e:	48 8d 05 83 4e 00 00 	lea    0x4e83(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40365:	48 89 c7             	mov    %rax,%rdi
   40368:	e8 87 25 00 00       	call   428f4 <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 8d 15 78 ec 00 00 	lea    0xec78(%rip),%rdx        # 4f000 <processes>
   40388:	48 01 c2             	add    %rax,%rdx
   4038b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4038e:	89 c6                	mov    %eax,%esi
   40390:	48 89 d7             	mov    %rdx,%rdi
   40393:	e8 f1 38 00 00       	call   43c89 <process_load>
   40398:	85 c0                	test   %eax,%eax
   4039a:	79 1e                	jns    403ba <process_setup+0xb6>
   4039c:	48 8d 05 55 4e 00 00 	lea    0x4e55(%rip),%rax        # 451f8 <memstate_colors+0x78>
   403a3:	48 89 c2             	mov    %rax,%rdx
   403a6:	be 7a 00 00 00       	mov    $0x7a,%esi
   403ab:	48 8d 05 36 4e 00 00 	lea    0x4e36(%rip),%rax        # 451e8 <memstate_colors+0x68>
   403b2:	48 89 c7             	mov    %rax,%rdi
   403b5:	e8 3a 25 00 00       	call   428f4 <assert_fail>

    process_setup_stack(&processes[pid]);
   403ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403bd:	48 63 d0             	movslq %eax,%rdx
   403c0:	48 89 d0             	mov    %rdx,%rax
   403c3:	48 c1 e0 04          	shl    $0x4,%rax
   403c7:	48 29 d0             	sub    %rdx,%rax
   403ca:	48 c1 e0 04          	shl    $0x4,%rax
   403ce:	48 8d 15 2b ec 00 00 	lea    0xec2b(%rip),%rdx        # 4f000 <processes>
   403d5:	48 01 d0             	add    %rdx,%rax
   403d8:	48 89 c7             	mov    %rax,%rdi
   403db:	e8 e1 38 00 00       	call   43cc1 <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   403e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403e3:	48 63 d0             	movslq %eax,%rdx
   403e6:	48 89 d0             	mov    %rdx,%rax
   403e9:	48 c1 e0 04          	shl    $0x4,%rax
   403ed:	48 29 d0             	sub    %rdx,%rax
   403f0:	48 c1 e0 04          	shl    $0x4,%rax
   403f4:	48 89 c2             	mov    %rax,%rdx
   403f7:	48 8d 05 da ec 00 00 	lea    0xecda(%rip),%rax        # 4f0d8 <processes+0xd8>
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
   40443:	48 8d 05 d7 fa 00 00 	lea    0xfad7(%rip),%rax        # 4ff21 <pageinfo+0x1>
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
   40467:	48 8d 05 b3 fa 00 00 	lea    0xfab3(%rip),%rax        # 4ff21 <pageinfo+0x1>
   4046e:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40472:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40476:	48 c1 e8 0c          	shr    $0xc,%rax
   4047a:	48 98                	cltq   
   4047c:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40480:	48 8d 15 99 fa 00 00 	lea    0xfa99(%rip),%rdx        # 4ff20 <pageinfo>
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
   4049d:	48 8b 05 5c fa 00 00 	mov    0xfa5c(%rip),%rax        # 4ff00 <current>
   404a4:	48 89 c7             	mov    %rax,%rdi
   404a7:	e8 c8 38 00 00       	call   43d74 <process_fork>
}
   404ac:	5d                   	pop    %rbp
   404ad:	c3                   	ret    

00000000000404ae <syscall_exit>:


void syscall_exit() {
   404ae:	f3 0f 1e fa          	endbr64 
   404b2:	55                   	push   %rbp
   404b3:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   404b6:	48 8b 05 43 fa 00 00 	mov    0xfa43(%rip),%rax        # 4ff00 <current>
   404bd:	8b 00                	mov    (%rax),%eax
   404bf:	89 c7                	mov    %eax,%edi
   404c1:	e8 93 31 00 00       	call   43659 <process_free>
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
   404d9:	48 8b 05 20 fa 00 00 	mov    0xfa20(%rip),%rax        # 4ff00 <current>
   404e0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   404e4:	48 89 d6             	mov    %rdx,%rsi
   404e7:	48 89 c7             	mov    %rax,%rdi
   404ea:	e8 17 3b 00 00       	call   44006 <process_page_alloc>
}
   404ef:	c9                   	leave  
   404f0:	c3                   	ret    

00000000000404f1 <syscall_brk>:

int syscall_brk(proc* p, uintptr_t new_brk) {
   404f1:	f3 0f 1e fa          	endbr64 
   404f5:	55                   	push   %rbp
   404f6:	48 89 e5             	mov    %rsp,%rbp
   404f9:	48 83 ec 60          	sub    $0x60,%rsp
   404fd:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   40501:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
    if (new_brk < p->original_break || new_brk >= MEMSIZE_VIRTUAL - PAGESIZE) {
   40505:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40509:	48 8b 40 10          	mov    0x10(%rax),%rax
   4050d:	48 39 45 a0          	cmp    %rax,-0x60(%rbp)
   40511:	72 0a                	jb     4051d <syscall_brk+0x2c>
   40513:	48 81 7d a0 ff ef 2f 	cmpq   $0x2fefff,-0x60(%rbp)
   4051a:	00 
   4051b:	76 0a                	jbe    40527 <syscall_brk+0x36>
        return -1;  
   4051d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40522:	e9 31 01 00 00       	jmp    40658 <syscall_brk+0x167>
    }

    uintptr_t old_brk = p->program_break;
   40527:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4052b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4052f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    if (new_brk > old_brk) {
   40533:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   40537:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   4053b:	0f 87 06 01 00 00    	ja     40647 <syscall_brk+0x156>
        //     }
        // }
    }

    // Shrink the heap and unmap pages
    else if (new_brk < old_brk) {
   40541:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   40545:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   40549:	0f 83 f8 00 00 00    	jae    40647 <syscall_brk+0x156>
        for (uintptr_t addr = ROUNDUP(new_brk, PAGESIZE); addr < ROUNDUP(old_brk, PAGESIZE); addr += PAGESIZE) {
   4054f:	48 c7 45 e8 00 10 00 	movq   $0x1000,-0x18(%rbp)
   40556:	00 
   40557:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4055b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4055f:	48 01 d0             	add    %rdx,%rax
   40562:	48 83 e8 01          	sub    $0x1,%rax
   40566:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4056a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4056e:	ba 00 00 00 00       	mov    $0x0,%edx
   40573:	48 f7 75 e8          	divq   -0x18(%rbp)
   40577:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4057b:	48 29 d0             	sub    %rdx,%rax
   4057e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   40582:	e9 87 00 00 00       	jmp    4060e <syscall_brk+0x11d>
            vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   40587:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4058b:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40592:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40596:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4059a:	48 89 ce             	mov    %rcx,%rsi
   4059d:	48 89 c7             	mov    %rax,%rdi
   405a0:	e8 1f 2b 00 00       	call   430c4 <virtual_memory_lookup>
            if (map.pn >= 0) {
   405a5:	8b 45 b8             	mov    -0x48(%rbp),%eax
   405a8:	85 c0                	test   %eax,%eax
   405aa:	78 5a                	js     40606 <syscall_brk+0x115>
                if(virtual_memory_map(p->p_pagetable, addr, 0, PAGESIZE, 0) < 0){
   405ac:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   405b0:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   405b7:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   405bb:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   405c1:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405c6:	ba 00 00 00 00       	mov    $0x0,%edx
   405cb:	48 89 c7             	mov    %rax,%rdi
   405ce:	e8 a5 26 00 00       	call   42c78 <virtual_memory_map>
   405d3:	85 c0                	test   %eax,%eax
   405d5:	79 07                	jns    405de <syscall_brk+0xed>
                    return -1;
   405d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   405dc:	eb 7a                	jmp    40658 <syscall_brk+0x167>
                }
                pageinfo[map.pn].refcount = 0;
   405de:	8b 45 b8             	mov    -0x48(%rbp),%eax
   405e1:	48 98                	cltq   
   405e3:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   405e7:	48 8d 05 33 f9 00 00 	lea    0xf933(%rip),%rax        # 4ff21 <pageinfo+0x1>
   405ee:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[map.pn].owner = PO_FREE;
   405f2:	8b 45 b8             	mov    -0x48(%rbp),%eax
   405f5:	48 98                	cltq   
   405f7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   405fb:	48 8d 05 1e f9 00 00 	lea    0xf91e(%rip),%rax        # 4ff20 <pageinfo>
   40602:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        for (uintptr_t addr = ROUNDUP(new_brk, PAGESIZE); addr < ROUNDUP(old_brk, PAGESIZE); addr += PAGESIZE) {
   40606:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4060d:	00 
   4060e:	48 c7 45 d8 00 10 00 	movq   $0x1000,-0x28(%rbp)
   40615:	00 
   40616:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4061a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4061e:	48 01 d0             	add    %rdx,%rax
   40621:	48 83 e8 01          	sub    $0x1,%rax
   40625:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   40629:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4062d:	ba 00 00 00 00       	mov    $0x0,%edx
   40632:	48 f7 75 d8          	divq   -0x28(%rbp)
   40636:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4063a:	48 29 d0             	sub    %rdx,%rax
   4063d:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
   40641:	0f 87 40 ff ff ff    	ja     40587 <syscall_brk+0x96>
            }
        }
    }

    p->program_break = new_brk; // Update program break
   40647:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4064b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4064f:	48 89 50 08          	mov    %rdx,0x8(%rax)
    return 0;
   40653:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40658:	c9                   	leave  
   40659:	c3                   	ret    

000000000004065a <syscall_sbrk>:


intptr_t syscall_sbrk(proc* p, intptr_t difference) {
   4065a:	f3 0f 1e fa          	endbr64 
   4065e:	55                   	push   %rbp
   4065f:	48 89 e5             	mov    %rsp,%rbp
   40662:	48 83 ec 20          	sub    $0x20,%rsp
   40666:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4066a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    uintptr_t old_brk = p->program_break;
   4066e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40672:	48 8b 40 08          	mov    0x8(%rax),%rax
   40676:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t new_brk = old_brk + difference;
   4067a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4067e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40682:	48 01 d0             	add    %rdx,%rax
   40685:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    if (syscall_brk(p, new_brk) != 0) {
   40689:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4068d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40691:	48 89 d6             	mov    %rdx,%rsi
   40694:	48 89 c7             	mov    %rax,%rdi
   40697:	e8 55 fe ff ff       	call   404f1 <syscall_brk>
   4069c:	85 c0                	test   %eax,%eax
   4069e:	74 09                	je     406a9 <syscall_sbrk+0x4f>
        return -1;  // Failed to adjust break
   406a0:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   406a7:	eb 04                	jmp    406ad <syscall_sbrk+0x53>
    }

    return old_brk; // Return previous program break
   406a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   406ad:	c9                   	leave  
   406ae:	c3                   	ret    

00000000000406af <syscall_mapping>:



void syscall_mapping(proc* p){
   406af:	f3 0f 1e fa          	endbr64 
   406b3:	55                   	push   %rbp
   406b4:	48 89 e5             	mov    %rsp,%rbp
   406b7:	48 83 ec 70          	sub    $0x70,%rsp
   406bb:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   406bf:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406c3:	48 8b 40 48          	mov    0x48(%rax),%rax
   406c7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   406cb:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406cf:	48 8b 40 40          	mov    0x40(%rax),%rax
   406d3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   406d7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406db:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406e2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   406e6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   406ea:	48 89 ce             	mov    %rcx,%rsi
   406ed:	48 89 c7             	mov    %rax,%rdi
   406f0:	e8 cf 29 00 00       	call   430c4 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   406f5:	8b 45 e0             	mov    -0x20(%rbp),%eax
   406f8:	48 98                	cltq   
   406fa:	83 e0 06             	and    $0x6,%eax
   406fd:	48 83 f8 06          	cmp    $0x6,%rax
   40701:	0f 85 89 00 00 00    	jne    40790 <syscall_mapping+0xe1>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   40707:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4070b:	48 83 c0 17          	add    $0x17,%rax
   4070f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (PAGENUMBER(endaddr) != PAGENUMBER(ptr)){
   40713:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40717:	48 c1 e8 0c          	shr    $0xc,%rax
   4071b:	89 c2                	mov    %eax,%edx
   4071d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40721:	48 c1 e8 0c          	shr    $0xc,%rax
   40725:	39 c2                	cmp    %eax,%edx
   40727:	74 2c                	je     40755 <syscall_mapping+0xa6>
        vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40729:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4072d:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40734:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40738:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4073c:	48 89 ce             	mov    %rcx,%rsi
   4073f:	48 89 c7             	mov    %rax,%rdi
   40742:	e8 7d 29 00 00       	call   430c4 <virtual_memory_lookup>
        // check for write access for end address
        if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40747:	8b 45 b0             	mov    -0x50(%rbp),%eax
   4074a:	48 98                	cltq   
   4074c:	83 e0 03             	and    $0x3,%eax
   4074f:	48 83 f8 03          	cmp    $0x3,%rax
   40753:	75 3e                	jne    40793 <syscall_mapping+0xe4>
            return; 
    }
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40755:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40759:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40760:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40764:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40768:	48 89 ce             	mov    %rcx,%rsi
   4076b:	48 89 c7             	mov    %rax,%rdi
   4076e:	e8 51 29 00 00       	call   430c4 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40773:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40777:	48 89 c1             	mov    %rax,%rcx
   4077a:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4077e:	ba 18 00 00 00       	mov    $0x18,%edx
   40783:	48 89 c6             	mov    %rax,%rsi
   40786:	48 89 cf             	mov    %rcx,%rdi
   40789:	e8 e6 38 00 00       	call   44074 <memcpy>
   4078e:	eb 04                	jmp    40794 <syscall_mapping+0xe5>
        return;
   40790:	90                   	nop
   40791:	eb 01                	jmp    40794 <syscall_mapping+0xe5>
            return; 
   40793:	90                   	nop
}
   40794:	c9                   	leave  
   40795:	c3                   	ret    

0000000000040796 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40796:	f3 0f 1e fa          	endbr64 
   4079a:	55                   	push   %rbp
   4079b:	48 89 e5             	mov    %rsp,%rbp
   4079e:	48 83 ec 18          	sub    $0x18,%rsp
   407a2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   407a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407aa:	48 8b 40 48          	mov    0x48(%rax),%rax
   407ae:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   407b1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   407b5:	75 14                	jne    407cb <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   407b7:	0f b6 05 42 58 00 00 	movzbl 0x5842(%rip),%eax        # 46000 <disp_global>
   407be:	84 c0                	test   %al,%al
   407c0:	0f 94 c0             	sete   %al
   407c3:	88 05 37 58 00 00    	mov    %al,0x5837(%rip)        # 46000 <disp_global>
   407c9:	eb 36                	jmp    40801 <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   407cb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   407cf:	78 2f                	js     40800 <syscall_mem_tog+0x6a>
   407d1:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   407d5:	7f 29                	jg     40800 <syscall_mem_tog+0x6a>
   407d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407db:	8b 00                	mov    (%rax),%eax
   407dd:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   407e0:	75 1e                	jne    40800 <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   407e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407e6:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   407ed:	84 c0                	test   %al,%al
   407ef:	0f 94 c0             	sete   %al
   407f2:	89 c2                	mov    %eax,%edx
   407f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407f8:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   407fe:	eb 01                	jmp    40801 <syscall_mem_tog+0x6b>
            return;
   40800:	90                   	nop
    }
}
   40801:	c9                   	leave  
   40802:	c3                   	ret    

0000000000040803 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40803:	f3 0f 1e fa          	endbr64 
   40807:	55                   	push   %rbp
   40808:	48 89 e5             	mov    %rsp,%rbp
   4080b:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   40812:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40819:	48 8b 05 e0 f6 00 00 	mov    0xf6e0(%rip),%rax        # 4ff00 <current>
   40820:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   40827:	48 83 c0 18          	add    $0x18,%rax
   4082b:	48 89 d6             	mov    %rdx,%rsi
   4082e:	ba 18 00 00 00       	mov    $0x18,%edx
   40833:	48 89 c7             	mov    %rax,%rdi
   40836:	48 89 d1             	mov    %rdx,%rcx
   40839:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   4083c:	48 8b 05 bd 17 01 00 	mov    0x117bd(%rip),%rax        # 52000 <kernel_pagetable>
   40843:	48 89 c7             	mov    %rax,%rdi
   40846:	e8 bb 22 00 00       	call   42b06 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   4084b:	8b 05 ab 87 07 00    	mov    0x787ab(%rip),%eax        # b8ffc <cursorpos>
   40851:	89 c7                	mov    %eax,%edi
   40853:	e8 34 19 00 00       	call   4218c <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   40858:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   4085f:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40866:	48 83 f8 0e          	cmp    $0xe,%rax
   4086a:	74 14                	je     40880 <exception+0x7d>
	    && reg->reg_intno != INT_GPF)
   4086c:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40873:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4087a:	48 83 f8 0d          	cmp    $0xd,%rax
   4087e:	75 16                	jne    40896 <exception+0x93>
            || (reg->reg_err & PFERR_USER)) {
   40880:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40887:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4088e:	83 e0 04             	and    $0x4,%eax
   40891:	48 85 c0             	test   %rax,%rax
   40894:	74 1a                	je     408b0 <exception+0xad>
        check_virtual_memory();
   40896:	e8 42 09 00 00       	call   411dd <check_virtual_memory>
        if(disp_global){
   4089b:	0f b6 05 5e 57 00 00 	movzbl 0x575e(%rip),%eax        # 46000 <disp_global>
   408a2:	84 c0                	test   %al,%al
   408a4:	74 0a                	je     408b0 <exception+0xad>
            memshow_physical();
   408a6:	e8 fb 0a 00 00       	call   413a6 <memshow_physical>
            memshow_virtual_animate();
   408ab:	e8 98 0e 00 00       	call   41748 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   408b0:	e8 ed 1d 00 00       	call   426a2 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   408b5:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   408bc:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   408c3:	48 83 e8 0e          	sub    $0xe,%rax
   408c7:	48 83 f8 2c          	cmp    $0x2c,%rax
   408cb:	0f 87 82 03 00 00    	ja     40c53 <exception+0x450>
   408d1:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   408d8:	00 
   408d9:	48 8d 05 d8 49 00 00 	lea    0x49d8(%rip),%rax        # 452b8 <memstate_colors+0x138>
   408e0:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   408e3:	48 98                	cltq   
   408e5:	48 8d 15 cc 49 00 00 	lea    0x49cc(%rip),%rdx        # 452b8 <memstate_colors+0x138>
   408ec:	48 01 d0             	add    %rdx,%rax
   408ef:	3e ff e0             	notrack jmp *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   408f2:	48 8b 05 07 f6 00 00 	mov    0xf607(%rip),%rax        # 4ff00 <current>
   408f9:	48 8b 40 48          	mov    0x48(%rax),%rax
   408fd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                    if((void *)addr == NULL)
   40901:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   40906:	75 0f                	jne    40917 <exception+0x114>
                        kernel_panic(NULL);
   40908:	bf 00 00 00 00       	mov    $0x0,%edi
   4090d:	b8 00 00 00 00       	mov    $0x0,%eax
   40912:	e8 ed 1e 00 00       	call   42804 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40917:	48 8b 05 e2 f5 00 00 	mov    0xf5e2(%rip),%rax        # 4ff00 <current>
   4091e:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40925:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   40929:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4092d:	48 89 ce             	mov    %rcx,%rsi
   40930:	48 89 c7             	mov    %rax,%rdi
   40933:	e8 8c 27 00 00       	call   430c4 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   40938:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4093c:	48 89 c1             	mov    %rax,%rcx
   4093f:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   40946:	ba a0 00 00 00       	mov    $0xa0,%edx
   4094b:	48 89 ce             	mov    %rcx,%rsi
   4094e:	48 89 c7             	mov    %rax,%rdi
   40951:	e8 1e 37 00 00       	call   44074 <memcpy>
                    kernel_panic(msg);
   40956:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   4095d:	48 89 c7             	mov    %rax,%rdi
   40960:	b8 00 00 00 00       	mov    $0x0,%eax
   40965:	e8 9a 1e 00 00       	call   42804 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   4096a:	48 8b 05 8f f5 00 00 	mov    0xf58f(%rip),%rax        # 4ff00 <current>
   40971:	8b 10                	mov    (%rax),%edx
   40973:	48 8b 05 86 f5 00 00 	mov    0xf586(%rip),%rax        # 4ff00 <current>
   4097a:	48 63 d2             	movslq %edx,%rdx
   4097d:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40981:	e9 dd 02 00 00       	jmp    40c63 <exception+0x460>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   40986:	b8 00 00 00 00       	mov    $0x0,%eax
   4098b:	e8 05 fb ff ff       	call   40495 <syscall_fork>
   40990:	89 c2                	mov    %eax,%edx
   40992:	48 8b 05 67 f5 00 00 	mov    0xf567(%rip),%rax        # 4ff00 <current>
   40999:	48 63 d2             	movslq %edx,%rdx
   4099c:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   409a0:	e9 be 02 00 00       	jmp    40c63 <exception+0x460>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   409a5:	48 8b 05 54 f5 00 00 	mov    0xf554(%rip),%rax        # 4ff00 <current>
   409ac:	48 89 c7             	mov    %rax,%rdi
   409af:	e8 fb fc ff ff       	call   406af <syscall_mapping>
                break;
   409b4:	e9 aa 02 00 00       	jmp    40c63 <exception+0x460>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   409b9:	b8 00 00 00 00       	mov    $0x0,%eax
   409be:	e8 eb fa ff ff       	call   404ae <syscall_exit>
                schedule();
   409c3:	e8 c4 02 00 00       	call   40c8c <schedule>
                break;
   409c8:	e9 96 02 00 00       	jmp    40c63 <exception+0x460>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   409cd:	e8 ba 02 00 00       	call   40c8c <schedule>
                break;                  /* will not be reached */
   409d2:	e9 8c 02 00 00       	jmp    40c63 <exception+0x460>
            }

    case INT_SYS_BRK:
        current->p_registers.reg_rax = syscall_brk(current, current->p_registers.reg_rdi);
   409d7:	48 8b 05 22 f5 00 00 	mov    0xf522(%rip),%rax        # 4ff00 <current>
   409de:	48 8b 50 48          	mov    0x48(%rax),%rdx
   409e2:	48 8b 05 17 f5 00 00 	mov    0xf517(%rip),%rax        # 4ff00 <current>
   409e9:	48 89 d6             	mov    %rdx,%rsi
   409ec:	48 89 c7             	mov    %rax,%rdi
   409ef:	e8 fd fa ff ff       	call   404f1 <syscall_brk>
   409f4:	89 c2                	mov    %eax,%edx
   409f6:	48 8b 05 03 f5 00 00 	mov    0xf503(%rip),%rax        # 4ff00 <current>
   409fd:	48 63 d2             	movslq %edx,%rdx
   40a00:	48 89 50 18          	mov    %rdx,0x18(%rax)
        break;
   40a04:	e9 5a 02 00 00       	jmp    40c63 <exception+0x460>

    case INT_SYS_SBRK:
        current->p_registers.reg_rax = syscall_sbrk(current, current->p_registers.reg_rdi);
   40a09:	48 8b 05 f0 f4 00 00 	mov    0xf4f0(%rip),%rax        # 4ff00 <current>
   40a10:	48 8b 40 48          	mov    0x48(%rax),%rax
   40a14:	48 89 c2             	mov    %rax,%rdx
   40a17:	48 8b 05 e2 f4 00 00 	mov    0xf4e2(%rip),%rax        # 4ff00 <current>
   40a1e:	48 89 d6             	mov    %rdx,%rsi
   40a21:	48 89 c7             	mov    %rax,%rdi
   40a24:	e8 31 fc ff ff       	call   4065a <syscall_sbrk>
   40a29:	48 89 c2             	mov    %rax,%rdx
   40a2c:	48 8b 05 cd f4 00 00 	mov    0xf4cd(%rip),%rax        # 4ff00 <current>
   40a33:	48 89 50 18          	mov    %rdx,0x18(%rax)
        break;
   40a37:	e9 27 02 00 00       	jmp    40c63 <exception+0x460>

	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   40a3c:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a43:	48 8b 40 30          	mov    0x30(%rax),%rax
   40a47:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		syscall_page_alloc(addr);
   40a4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a4f:	48 89 c7             	mov    %rax,%rdi
   40a52:	e8 72 fa ff ff       	call   404c9 <syscall_page_alloc>
		break;
   40a57:	e9 07 02 00 00       	jmp    40c63 <exception+0x460>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40a5c:	48 8b 05 9d f4 00 00 	mov    0xf49d(%rip),%rax        # 4ff00 <current>
   40a63:	48 89 c7             	mov    %rax,%rdi
   40a66:	e8 2b fd ff ff       	call   40796 <syscall_mem_tog>
                break;
   40a6b:	e9 f3 01 00 00       	jmp    40c63 <exception+0x460>
            }

        case INT_TIMER:
            {
                ++ticks;
   40a70:	8b 05 aa f8 00 00    	mov    0xf8aa(%rip),%eax        # 50320 <ticks>
   40a76:	83 c0 01             	add    $0x1,%eax
   40a79:	89 05 a1 f8 00 00    	mov    %eax,0xf8a1(%rip)        # 50320 <ticks>
                schedule();
   40a7f:	e8 08 02 00 00       	call   40c8c <schedule>
                break;                  /* will not be reached */
   40a84:	e9 da 01 00 00       	jmp    40c63 <exception+0x460>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40a89:	0f 20 d0             	mov    %cr2,%rax
   40a8c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    return val;
   40a90:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
            }

case INT_PAGEFAULT: 
{
    uintptr_t addr = rcr2();  // Address that caused the fault
   40a94:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    const char* operation = reg->reg_err & PFERR_WRITE ? "write" : "read";
   40a98:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a9f:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40aa6:	83 e0 02             	and    $0x2,%eax
   40aa9:	48 85 c0             	test   %rax,%rax
   40aac:	74 09                	je     40ab7 <exception+0x2b4>
   40aae:	48 8d 05 76 47 00 00 	lea    0x4776(%rip),%rax        # 4522b <memstate_colors+0xab>
   40ab5:	eb 07                	jmp    40abe <exception+0x2bb>
   40ab7:	48 8d 05 73 47 00 00 	lea    0x4773(%rip),%rax        # 45231 <memstate_colors+0xb1>
   40abe:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    const char* problem = reg->reg_err & PFERR_PRESENT ? "protection problem" : "missing page";
   40ac2:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40ac9:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ad0:	83 e0 01             	and    $0x1,%eax
   40ad3:	48 85 c0             	test   %rax,%rax
   40ad6:	74 09                	je     40ae1 <exception+0x2de>
   40ad8:	48 8d 05 57 47 00 00 	lea    0x4757(%rip),%rax        # 45236 <memstate_colors+0xb6>
   40adf:	eb 07                	jmp    40ae8 <exception+0x2e5>
   40ae1:	48 8d 05 61 47 00 00 	lea    0x4761(%rip),%rax        # 45249 <memstate_colors+0xc9>
   40ae8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Check if the fault occurred in user space
    if (!(reg->reg_err & PFERR_USER)) {
   40aec:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40af3:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40afa:	83 e0 04             	and    $0x4,%eax
   40afd:	48 85 c0             	test   %rax,%rax
   40b00:	75 34                	jne    40b36 <exception+0x333>
        kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40b02:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40b09:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40b10:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   40b14:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40b18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40b1c:	49 89 f0             	mov    %rsi,%r8
   40b1f:	48 89 c6             	mov    %rax,%rsi
   40b22:	48 8d 05 2f 47 00 00 	lea    0x472f(%rip),%rax        # 45258 <memstate_colors+0xd8>
   40b29:	48 89 c7             	mov    %rax,%rdi
   40b2c:	b8 00 00 00 00       	mov    $0x0,%eax
   40b31:	e8 ce 1c 00 00       	call   42804 <kernel_panic>
                     addr, operation, problem, reg->reg_rip);
    }

    if (addr >= current->original_break && addr < current->program_break) {
   40b36:	48 8b 05 c3 f3 00 00 	mov    0xf3c3(%rip),%rax        # 4ff00 <current>
   40b3d:	48 8b 40 10          	mov    0x10(%rax),%rax
   40b41:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40b45:	0f 82 9e 00 00 00    	jb     40be9 <exception+0x3e6>
   40b4b:	48 8b 05 ae f3 00 00 	mov    0xf3ae(%rip),%rax        # 4ff00 <current>
   40b52:	48 8b 40 08          	mov    0x8(%rax),%rax
   40b56:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40b5a:	0f 83 89 00 00 00    	jae    40be9 <exception+0x3e6>
        uintptr_t faulting_page = addr & ~(PAGESIZE - 1); 
   40b60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40b64:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40b6a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        uintptr_t pa = (uintptr_t) palloc(current->p_pid);
   40b6e:	48 8b 05 8b f3 00 00 	mov    0xf38b(%rip),%rax        # 4ff00 <current>
   40b75:	8b 00                	mov    (%rax),%eax
   40b77:	89 c7                	mov    %eax,%edi
   40b79:	e8 c2 29 00 00       	call   43540 <palloc>
   40b7e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        if (!pa || virtual_memory_map(current->p_pagetable, faulting_page, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   40b82:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40b87:	74 2d                	je     40bb6 <exception+0x3b3>
   40b89:	48 8b 05 70 f3 00 00 	mov    0xf370(%rip),%rax        # 4ff00 <current>
   40b90:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40b97:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40b9b:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40b9f:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40ba5:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40baa:	48 89 c7             	mov    %rax,%rdi
   40bad:	e8 c6 20 00 00       	call   42c78 <virtual_memory_map>
   40bb2:	85 c0                	test   %eax,%eax
   40bb4:	79 20                	jns    40bd6 <exception+0x3d3>
            current->p_state = P_BROKEN;
   40bb6:	48 8b 05 43 f3 00 00 	mov    0xf343(%rip),%rax        # 4ff00 <current>
   40bbd:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40bc4:	00 00 00 
            syscall_exit();
   40bc7:	b8 00 00 00 00       	mov    $0x0,%eax
   40bcc:	e8 dd f8 ff ff       	call   404ae <syscall_exit>
            break;
   40bd1:	e9 8d 00 00 00       	jmp    40c63 <exception+0x460>
        }
        current->p_state = P_RUNNABLE;
   40bd6:	48 8b 05 23 f3 00 00 	mov    0xf323(%rip),%rax        # 4ff00 <current>
   40bdd:	c7 80 d8 00 00 00 01 	movl   $0x1,0xd8(%rax)
   40be4:	00 00 00 
        break;
   40be7:	eb 7a                	jmp    40c63 <exception+0x460>
    }

    // If the fault is outside the heap, treat it as an error
    console_printf(CPOS(24, 0), 0x0C00,
   40be9:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40bf0:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                   "Process %d page fault for %p (%s %s, rip=%p)!\n",
                   current->p_pid, addr, operation, problem, reg->reg_rip);
   40bf7:	48 8b 05 02 f3 00 00 	mov    0xf302(%rip),%rax        # 4ff00 <current>
    console_printf(CPOS(24, 0), 0x0C00,
   40bfe:	8b 00                	mov    (%rax),%eax
   40c00:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   40c04:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   40c08:	52                   	push   %rdx
   40c09:	ff 75 d8             	push   -0x28(%rbp)
   40c0c:	49 89 f1             	mov    %rsi,%r9
   40c0f:	49 89 c8             	mov    %rcx,%r8
   40c12:	89 c1                	mov    %eax,%ecx
   40c14:	48 8d 05 6d 46 00 00 	lea    0x466d(%rip),%rax        # 45288 <memstate_colors+0x108>
   40c1b:	48 89 c2             	mov    %rax,%rdx
   40c1e:	be 00 0c 00 00       	mov    $0xc00,%esi
   40c23:	bf 80 07 00 00       	mov    $0x780,%edi
   40c28:	b8 00 00 00 00       	mov    $0x0,%eax
   40c2d:	e8 87 43 00 00       	call   44fb9 <console_printf>
   40c32:	48 83 c4 10          	add    $0x10,%rsp
    current->p_state = P_BROKEN;
   40c36:	48 8b 05 c3 f2 00 00 	mov    0xf2c3(%rip),%rax        # 4ff00 <current>
   40c3d:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40c44:	00 00 00 
    syscall_exit();
   40c47:	b8 00 00 00 00       	mov    $0x0,%eax
   40c4c:	e8 5d f8 ff ff       	call   404ae <syscall_exit>
    break;
   40c51:	eb 10                	jmp    40c63 <exception+0x460>
}

    default:
        default_exception(current);
   40c53:	48 8b 05 a6 f2 00 00 	mov    0xf2a6(%rip),%rax        # 4ff00 <current>
   40c5a:	48 89 c7             	mov    %rax,%rdi
   40c5d:	e8 cb 1c 00 00       	call   4292d <default_exception>
        break;                  /* will not be reached */
   40c62:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40c63:	48 8b 05 96 f2 00 00 	mov    0xf296(%rip),%rax        # 4ff00 <current>
   40c6a:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c70:	83 f8 01             	cmp    $0x1,%eax
   40c73:	75 0f                	jne    40c84 <exception+0x481>
        run(current);
   40c75:	48 8b 05 84 f2 00 00 	mov    0xf284(%rip),%rax        # 4ff00 <current>
   40c7c:	48 89 c7             	mov    %rax,%rdi
   40c7f:	e8 87 00 00 00       	call   40d0b <run>
    } else {
        schedule();
   40c84:	e8 03 00 00 00       	call   40c8c <schedule>
    }
}
   40c89:	90                   	nop
   40c8a:	c9                   	leave  
   40c8b:	c3                   	ret    

0000000000040c8c <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40c8c:	f3 0f 1e fa          	endbr64 
   40c90:	55                   	push   %rbp
   40c91:	48 89 e5             	mov    %rsp,%rbp
   40c94:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40c98:	48 8b 05 61 f2 00 00 	mov    0xf261(%rip),%rax        # 4ff00 <current>
   40c9f:	8b 00                	mov    (%rax),%eax
   40ca1:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40ca4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ca7:	83 c0 01             	add    $0x1,%eax
   40caa:	99                   	cltd   
   40cab:	c1 ea 1c             	shr    $0x1c,%edx
   40cae:	01 d0                	add    %edx,%eax
   40cb0:	83 e0 0f             	and    $0xf,%eax
   40cb3:	29 d0                	sub    %edx,%eax
   40cb5:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40cb8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cbb:	48 63 d0             	movslq %eax,%rdx
   40cbe:	48 89 d0             	mov    %rdx,%rax
   40cc1:	48 c1 e0 04          	shl    $0x4,%rax
   40cc5:	48 29 d0             	sub    %rdx,%rax
   40cc8:	48 c1 e0 04          	shl    $0x4,%rax
   40ccc:	48 89 c2             	mov    %rax,%rdx
   40ccf:	48 8d 05 02 e4 00 00 	lea    0xe402(%rip),%rax        # 4f0d8 <processes+0xd8>
   40cd6:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40cd9:	83 f8 01             	cmp    $0x1,%eax
   40cdc:	75 26                	jne    40d04 <schedule+0x78>
            run(&processes[pid]);
   40cde:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ce1:	48 63 d0             	movslq %eax,%rdx
   40ce4:	48 89 d0             	mov    %rdx,%rax
   40ce7:	48 c1 e0 04          	shl    $0x4,%rax
   40ceb:	48 29 d0             	sub    %rdx,%rax
   40cee:	48 c1 e0 04          	shl    $0x4,%rax
   40cf2:	48 8d 15 07 e3 00 00 	lea    0xe307(%rip),%rdx        # 4f000 <processes>
   40cf9:	48 01 d0             	add    %rdx,%rax
   40cfc:	48 89 c7             	mov    %rax,%rdi
   40cff:	e8 07 00 00 00       	call   40d0b <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40d04:	e8 99 19 00 00       	call   426a2 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40d09:	eb 99                	jmp    40ca4 <schedule+0x18>

0000000000040d0b <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40d0b:	f3 0f 1e fa          	endbr64 
   40d0f:	55                   	push   %rbp
   40d10:	48 89 e5             	mov    %rsp,%rbp
   40d13:	48 83 ec 10          	sub    $0x10,%rsp
   40d17:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40d1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d1f:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40d25:	83 f8 01             	cmp    $0x1,%eax
   40d28:	74 1e                	je     40d48 <run+0x3d>
   40d2a:	48 8d 05 3b 46 00 00 	lea    0x463b(%rip),%rax        # 4536c <memstate_colors+0x1ec>
   40d31:	48 89 c2             	mov    %rax,%rdx
   40d34:	be ac 01 00 00       	mov    $0x1ac,%esi
   40d39:	48 8d 05 a8 44 00 00 	lea    0x44a8(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40d40:	48 89 c7             	mov    %rax,%rdi
   40d43:	e8 ac 1b 00 00       	call   428f4 <assert_fail>
    current = p;
   40d48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d4c:	48 89 05 ad f1 00 00 	mov    %rax,0xf1ad(%rip)        # 4ff00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40d53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d57:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40d59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d5d:	8b 00                	mov    (%rax),%eax
   40d5f:	83 c0 02             	add    $0x2,%eax
   40d62:	48 98                	cltq   
   40d64:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40d68:	48 8d 05 11 44 00 00 	lea    0x4411(%rip),%rax        # 45180 <memstate_colors>
   40d6f:	0f b7 04 01          	movzwl (%rcx,%rax,1),%eax
    console_printf(CPOS(24, 79),
   40d73:	0f b7 c0             	movzwl %ax,%eax
   40d76:	89 d1                	mov    %edx,%ecx
   40d78:	48 8d 15 06 46 00 00 	lea    0x4606(%rip),%rdx        # 45385 <memstate_colors+0x205>
   40d7f:	89 c6                	mov    %eax,%esi
   40d81:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40d86:	b8 00 00 00 00       	mov    $0x0,%eax
   40d8b:	e8 29 42 00 00       	call   44fb9 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40d90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d94:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40d9b:	48 89 c7             	mov    %rax,%rdi
   40d9e:	e8 63 1d 00 00       	call   42b06 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40da3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40da7:	48 83 c0 18          	add    $0x18,%rax
   40dab:	48 89 c7             	mov    %rax,%rdi
   40dae:	e8 10 f3 ff ff       	call   400c3 <exception_return>

0000000000040db3 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40db3:	f3 0f 1e fa          	endbr64 
   40db7:	55                   	push   %rbp
   40db8:	48 89 e5             	mov    %rsp,%rbp
   40dbb:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40dbf:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40dc6:	00 
   40dc7:	e9 93 00 00 00       	jmp    40e5f <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40dcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dd0:	48 89 c7             	mov    %rax,%rdi
   40dd3:	e8 04 11 00 00       	call   41edc <physical_memory_isreserved>
   40dd8:	85 c0                	test   %eax,%eax
   40dda:	74 09                	je     40de5 <pageinfo_init+0x32>
            owner = PO_RESERVED;
   40ddc:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40de3:	eb 31                	jmp    40e16 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40de5:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40dec:	00 
   40ded:	76 0d                	jbe    40dfc <pageinfo_init+0x49>
   40def:	48 8d 05 1a 72 01 00 	lea    0x1721a(%rip),%rax        # 58010 <end>
   40df6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dfa:	72 0a                	jb     40e06 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40dfc:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40e03:	00 
   40e04:	75 09                	jne    40e0f <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   40e06:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40e0d:	eb 07                	jmp    40e16 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   40e0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40e16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e1a:	48 c1 e8 0c          	shr    $0xc,%rax
   40e1e:	89 c2                	mov    %eax,%edx
   40e20:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e23:	89 c1                	mov    %eax,%ecx
   40e25:	48 63 c2             	movslq %edx,%rax
   40e28:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e2c:	48 8d 05 ed f0 00 00 	lea    0xf0ed(%rip),%rax        # 4ff20 <pageinfo>
   40e33:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40e36:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40e3a:	0f 95 c2             	setne  %dl
   40e3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e41:	48 c1 e8 0c          	shr    $0xc,%rax
   40e45:	89 d1                	mov    %edx,%ecx
   40e47:	48 98                	cltq   
   40e49:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e4d:	48 8d 05 cd f0 00 00 	lea    0xf0cd(%rip),%rax        # 4ff21 <pageinfo+0x1>
   40e54:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e57:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e5e:	00 
   40e5f:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40e66:	00 
   40e67:	0f 86 5f ff ff ff    	jbe    40dcc <pageinfo_init+0x19>
    }
}
   40e6d:	90                   	nop
   40e6e:	90                   	nop
   40e6f:	c9                   	leave  
   40e70:	c3                   	ret    

0000000000040e71 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40e71:	f3 0f 1e fa          	endbr64 
   40e75:	55                   	push   %rbp
   40e76:	48 89 e5             	mov    %rsp,%rbp
   40e79:	48 83 ec 50          	sub    $0x50,%rsp
   40e7d:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40e81:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e85:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40e8b:	48 89 c2             	mov    %rax,%rdx
   40e8e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e92:	48 39 c2             	cmp    %rax,%rdx
   40e95:	74 1e                	je     40eb5 <check_page_table_mappings+0x44>
   40e97:	48 8d 05 ea 44 00 00 	lea    0x44ea(%rip),%rax        # 45388 <memstate_colors+0x208>
   40e9e:	48 89 c2             	mov    %rax,%rdx
   40ea1:	be da 01 00 00       	mov    $0x1da,%esi
   40ea6:	48 8d 05 3b 43 00 00 	lea    0x433b(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40ead:	48 89 c7             	mov    %rax,%rdi
   40eb0:	e8 3f 1a 00 00       	call   428f4 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40eb5:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40ebc:	00 
   40ebd:	e9 b5 00 00 00       	jmp    40f77 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40ec2:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40ec6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40eca:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40ece:	48 89 ce             	mov    %rcx,%rsi
   40ed1:	48 89 c7             	mov    %rax,%rdi
   40ed4:	e8 eb 21 00 00       	call   430c4 <virtual_memory_lookup>
        if (vam.pa != va) {
   40ed9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40edd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ee1:	74 2c                	je     40f0f <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40ee3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40ee7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40eeb:	49 89 d0             	mov    %rdx,%r8
   40eee:	48 89 c1             	mov    %rax,%rcx
   40ef1:	48 8d 05 af 44 00 00 	lea    0x44af(%rip),%rax        # 453a7 <memstate_colors+0x227>
   40ef8:	48 89 c2             	mov    %rax,%rdx
   40efb:	be 00 c0 00 00       	mov    $0xc000,%esi
   40f00:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40f05:	b8 00 00 00 00       	mov    $0x0,%eax
   40f0a:	e8 aa 40 00 00       	call   44fb9 <console_printf>
        }
        assert(vam.pa == va);
   40f0f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f13:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f17:	74 1e                	je     40f37 <check_page_table_mappings+0xc6>
   40f19:	48 8d 05 91 44 00 00 	lea    0x4491(%rip),%rax        # 453b1 <memstate_colors+0x231>
   40f20:	48 89 c2             	mov    %rax,%rdx
   40f23:	be e3 01 00 00       	mov    $0x1e3,%esi
   40f28:	48 8d 05 b9 42 00 00 	lea    0x42b9(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40f2f:	48 89 c7             	mov    %rax,%rdi
   40f32:	e8 bd 19 00 00       	call   428f4 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40f37:	48 8d 05 c2 50 00 00 	lea    0x50c2(%rip),%rax        # 46000 <disp_global>
   40f3e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f42:	72 2b                	jb     40f6f <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   40f44:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f47:	48 98                	cltq   
   40f49:	83 e0 02             	and    $0x2,%eax
   40f4c:	48 85 c0             	test   %rax,%rax
   40f4f:	75 1e                	jne    40f6f <check_page_table_mappings+0xfe>
   40f51:	48 8d 05 66 44 00 00 	lea    0x4466(%rip),%rax        # 453be <memstate_colors+0x23e>
   40f58:	48 89 c2             	mov    %rax,%rdx
   40f5b:	be e5 01 00 00       	mov    $0x1e5,%esi
   40f60:	48 8d 05 81 42 00 00 	lea    0x4281(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40f67:	48 89 c7             	mov    %rax,%rdi
   40f6a:	e8 85 19 00 00       	call   428f4 <assert_fail>
         va += PAGESIZE) {
   40f6f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40f76:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40f77:	48 8d 05 92 70 01 00 	lea    0x17092(%rip),%rax        # 58010 <end>
   40f7e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f82:	0f 82 3a ff ff ff    	jb     40ec2 <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40f88:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40f8f:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40f90:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40f94:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40f98:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f9c:	48 89 ce             	mov    %rcx,%rsi
   40f9f:	48 89 c7             	mov    %rax,%rdi
   40fa2:	e8 1d 21 00 00       	call   430c4 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40fa7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40fab:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40faf:	74 1e                	je     40fcf <check_page_table_mappings+0x15e>
   40fb1:	48 8d 05 17 44 00 00 	lea    0x4417(%rip),%rax        # 453cf <memstate_colors+0x24f>
   40fb8:	48 89 c2             	mov    %rax,%rdx
   40fbb:	be ec 01 00 00       	mov    $0x1ec,%esi
   40fc0:	48 8d 05 21 42 00 00 	lea    0x4221(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40fc7:	48 89 c7             	mov    %rax,%rdi
   40fca:	e8 25 19 00 00       	call   428f4 <assert_fail>
    assert(vam.perm & PTE_W);
   40fcf:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40fd2:	48 98                	cltq   
   40fd4:	83 e0 02             	and    $0x2,%eax
   40fd7:	48 85 c0             	test   %rax,%rax
   40fda:	75 1e                	jne    40ffa <check_page_table_mappings+0x189>
   40fdc:	48 8d 05 db 43 00 00 	lea    0x43db(%rip),%rax        # 453be <memstate_colors+0x23e>
   40fe3:	48 89 c2             	mov    %rax,%rdx
   40fe6:	be ed 01 00 00       	mov    $0x1ed,%esi
   40feb:	48 8d 05 f6 41 00 00 	lea    0x41f6(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40ff2:	48 89 c7             	mov    %rax,%rdi
   40ff5:	e8 fa 18 00 00       	call   428f4 <assert_fail>
}
   40ffa:	90                   	nop
   40ffb:	c9                   	leave  
   40ffc:	c3                   	ret    

0000000000040ffd <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40ffd:	f3 0f 1e fa          	endbr64 
   41001:	55                   	push   %rbp
   41002:	48 89 e5             	mov    %rsp,%rbp
   41005:	48 83 ec 20          	sub    $0x20,%rsp
   41009:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4100d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   41010:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41013:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   41016:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   4101d:	48 8b 05 dc 0f 01 00 	mov    0x10fdc(%rip),%rax        # 52000 <kernel_pagetable>
   41024:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41028:	75 71                	jne    4109b <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   4102a:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41031:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41038:	eb 5b                	jmp    41095 <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   4103a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4103d:	48 63 d0             	movslq %eax,%rdx
   41040:	48 89 d0             	mov    %rdx,%rax
   41043:	48 c1 e0 04          	shl    $0x4,%rax
   41047:	48 29 d0             	sub    %rdx,%rax
   4104a:	48 c1 e0 04          	shl    $0x4,%rax
   4104e:	48 89 c2             	mov    %rax,%rdx
   41051:	48 8d 05 80 e0 00 00 	lea    0xe080(%rip),%rax        # 4f0d8 <processes+0xd8>
   41058:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4105b:	85 c0                	test   %eax,%eax
   4105d:	74 32                	je     41091 <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   4105f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41062:	48 63 d0             	movslq %eax,%rdx
   41065:	48 89 d0             	mov    %rdx,%rax
   41068:	48 c1 e0 04          	shl    $0x4,%rax
   4106c:	48 29 d0             	sub    %rdx,%rax
   4106f:	48 c1 e0 04          	shl    $0x4,%rax
   41073:	48 89 c2             	mov    %rax,%rdx
   41076:	48 8d 05 63 e0 00 00 	lea    0xe063(%rip),%rax        # 4f0e0 <processes+0xe0>
   4107d:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   41081:	48 8b 05 78 0f 01 00 	mov    0x10f78(%rip),%rax        # 52000 <kernel_pagetable>
   41088:	48 39 c2             	cmp    %rax,%rdx
   4108b:	75 04                	jne    41091 <check_page_table_ownership+0x94>
                ++expected_refcount;
   4108d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41091:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41095:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41099:	7e 9f                	jle    4103a <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   4109b:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   4109e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   410a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410a5:	be 00 00 00 00       	mov    $0x0,%esi
   410aa:	48 89 c7             	mov    %rax,%rdi
   410ad:	e8 03 00 00 00       	call   410b5 <check_page_table_ownership_level>
}
   410b2:	90                   	nop
   410b3:	c9                   	leave  
   410b4:	c3                   	ret    

00000000000410b5 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   410b5:	f3 0f 1e fa          	endbr64 
   410b9:	55                   	push   %rbp
   410ba:	48 89 e5             	mov    %rsp,%rbp
   410bd:	48 83 ec 30          	sub    $0x30,%rsp
   410c1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   410c5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   410c8:	89 55 e0             	mov    %edx,-0x20(%rbp)
   410cb:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   410ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410d2:	48 c1 e8 0c          	shr    $0xc,%rax
   410d6:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   410db:	7e 1e                	jle    410fb <check_page_table_ownership_level+0x46>
   410dd:	48 8d 05 fc 42 00 00 	lea    0x42fc(%rip),%rax        # 453e0 <memstate_colors+0x260>
   410e4:	48 89 c2             	mov    %rax,%rdx
   410e7:	be 0a 02 00 00       	mov    $0x20a,%esi
   410ec:	48 8d 05 f5 40 00 00 	lea    0x40f5(%rip),%rax        # 451e8 <memstate_colors+0x68>
   410f3:	48 89 c7             	mov    %rax,%rdi
   410f6:	e8 f9 17 00 00       	call   428f4 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   410fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410ff:	48 c1 e8 0c          	shr    $0xc,%rax
   41103:	48 98                	cltq   
   41105:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41109:	48 8d 05 10 ee 00 00 	lea    0xee10(%rip),%rax        # 4ff20 <pageinfo>
   41110:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41114:	0f be c0             	movsbl %al,%eax
   41117:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   4111a:	74 1e                	je     4113a <check_page_table_ownership_level+0x85>
   4111c:	48 8d 05 d5 42 00 00 	lea    0x42d5(%rip),%rax        # 453f8 <memstate_colors+0x278>
   41123:	48 89 c2             	mov    %rax,%rdx
   41126:	be 0b 02 00 00       	mov    $0x20b,%esi
   4112b:	48 8d 05 b6 40 00 00 	lea    0x40b6(%rip),%rax        # 451e8 <memstate_colors+0x68>
   41132:	48 89 c7             	mov    %rax,%rdi
   41135:	e8 ba 17 00 00       	call   428f4 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   4113a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4113e:	48 c1 e8 0c          	shr    $0xc,%rax
   41142:	48 98                	cltq   
   41144:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41148:	48 8d 05 d2 ed 00 00 	lea    0xedd2(%rip),%rax        # 4ff21 <pageinfo+0x1>
   4114f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41153:	0f be c0             	movsbl %al,%eax
   41156:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41159:	74 1e                	je     41179 <check_page_table_ownership_level+0xc4>
   4115b:	48 8d 05 be 42 00 00 	lea    0x42be(%rip),%rax        # 45420 <memstate_colors+0x2a0>
   41162:	48 89 c2             	mov    %rax,%rdx
   41165:	be 0c 02 00 00       	mov    $0x20c,%esi
   4116a:	48 8d 05 77 40 00 00 	lea    0x4077(%rip),%rax        # 451e8 <memstate_colors+0x68>
   41171:	48 89 c7             	mov    %rax,%rdi
   41174:	e8 7b 17 00 00       	call   428f4 <assert_fail>
    if (level < 3) {
   41179:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   4117d:	7f 5b                	jg     411da <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4117f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41186:	eb 49                	jmp    411d1 <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   41188:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4118c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4118f:	48 63 d2             	movslq %edx,%rdx
   41192:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41196:	48 85 c0             	test   %rax,%rax
   41199:	74 32                	je     411cd <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   4119b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4119f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411a2:	48 63 d2             	movslq %edx,%rdx
   411a5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   411a9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   411af:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   411b3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   411b6:	8d 70 01             	lea    0x1(%rax),%esi
   411b9:	8b 55 e0             	mov    -0x20(%rbp),%edx
   411bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   411c0:	b9 01 00 00 00       	mov    $0x1,%ecx
   411c5:	48 89 c7             	mov    %rax,%rdi
   411c8:	e8 e8 fe ff ff       	call   410b5 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   411cd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411d1:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   411d8:	7e ae                	jle    41188 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   411da:	90                   	nop
   411db:	c9                   	leave  
   411dc:	c3                   	ret    

00000000000411dd <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   411dd:	f3 0f 1e fa          	endbr64 
   411e1:	55                   	push   %rbp
   411e2:	48 89 e5             	mov    %rsp,%rbp
   411e5:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   411e9:	8b 05 e9 de 00 00    	mov    0xdee9(%rip),%eax        # 4f0d8 <processes+0xd8>
   411ef:	85 c0                	test   %eax,%eax
   411f1:	74 1e                	je     41211 <check_virtual_memory+0x34>
   411f3:	48 8d 05 56 42 00 00 	lea    0x4256(%rip),%rax        # 45450 <memstate_colors+0x2d0>
   411fa:	48 89 c2             	mov    %rax,%rdx
   411fd:	be 1f 02 00 00       	mov    $0x21f,%esi
   41202:	48 8d 05 df 3f 00 00 	lea    0x3fdf(%rip),%rax        # 451e8 <memstate_colors+0x68>
   41209:	48 89 c7             	mov    %rax,%rdi
   4120c:	e8 e3 16 00 00       	call   428f4 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41211:	48 8b 05 e8 0d 01 00 	mov    0x10de8(%rip),%rax        # 52000 <kernel_pagetable>
   41218:	48 89 c7             	mov    %rax,%rdi
   4121b:	e8 51 fc ff ff       	call   40e71 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41220:	48 8b 05 d9 0d 01 00 	mov    0x10dd9(%rip),%rax        # 52000 <kernel_pagetable>
   41227:	be ff ff ff ff       	mov    $0xffffffff,%esi
   4122c:	48 89 c7             	mov    %rax,%rdi
   4122f:	e8 c9 fd ff ff       	call   40ffd <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41234:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4123b:	e9 b4 00 00 00       	jmp    412f4 <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   41240:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41243:	48 63 d0             	movslq %eax,%rdx
   41246:	48 89 d0             	mov    %rdx,%rax
   41249:	48 c1 e0 04          	shl    $0x4,%rax
   4124d:	48 29 d0             	sub    %rdx,%rax
   41250:	48 c1 e0 04          	shl    $0x4,%rax
   41254:	48 89 c2             	mov    %rax,%rdx
   41257:	48 8d 05 7a de 00 00 	lea    0xde7a(%rip),%rax        # 4f0d8 <processes+0xd8>
   4125e:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41261:	85 c0                	test   %eax,%eax
   41263:	0f 84 87 00 00 00    	je     412f0 <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41269:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4126c:	48 63 d0             	movslq %eax,%rdx
   4126f:	48 89 d0             	mov    %rdx,%rax
   41272:	48 c1 e0 04          	shl    $0x4,%rax
   41276:	48 29 d0             	sub    %rdx,%rax
   41279:	48 c1 e0 04          	shl    $0x4,%rax
   4127d:	48 89 c2             	mov    %rax,%rdx
   41280:	48 8d 05 59 de 00 00 	lea    0xde59(%rip),%rax        # 4f0e0 <processes+0xe0>
   41287:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   4128b:	48 8b 05 6e 0d 01 00 	mov    0x10d6e(%rip),%rax        # 52000 <kernel_pagetable>
   41292:	48 39 c2             	cmp    %rax,%rdx
   41295:	74 59                	je     412f0 <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   41297:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4129a:	48 63 d0             	movslq %eax,%rdx
   4129d:	48 89 d0             	mov    %rdx,%rax
   412a0:	48 c1 e0 04          	shl    $0x4,%rax
   412a4:	48 29 d0             	sub    %rdx,%rax
   412a7:	48 c1 e0 04          	shl    $0x4,%rax
   412ab:	48 89 c2             	mov    %rax,%rdx
   412ae:	48 8d 05 2b de 00 00 	lea    0xde2b(%rip),%rax        # 4f0e0 <processes+0xe0>
   412b5:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   412b9:	48 89 c7             	mov    %rax,%rdi
   412bc:	e8 b0 fb ff ff       	call   40e71 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   412c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412c4:	48 63 d0             	movslq %eax,%rdx
   412c7:	48 89 d0             	mov    %rdx,%rax
   412ca:	48 c1 e0 04          	shl    $0x4,%rax
   412ce:	48 29 d0             	sub    %rdx,%rax
   412d1:	48 c1 e0 04          	shl    $0x4,%rax
   412d5:	48 89 c2             	mov    %rax,%rdx
   412d8:	48 8d 05 01 de 00 00 	lea    0xde01(%rip),%rax        # 4f0e0 <processes+0xe0>
   412df:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   412e3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   412e6:	89 d6                	mov    %edx,%esi
   412e8:	48 89 c7             	mov    %rax,%rdi
   412eb:	e8 0d fd ff ff       	call   40ffd <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   412f0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412f4:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   412f8:	0f 8e 42 ff ff ff    	jle    41240 <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412fe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41305:	e9 8b 00 00 00       	jmp    41395 <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4130a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4130d:	48 98                	cltq   
   4130f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41313:	48 8d 05 07 ec 00 00 	lea    0xec07(%rip),%rax        # 4ff21 <pageinfo+0x1>
   4131a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4131e:	84 c0                	test   %al,%al
   41320:	7e 6f                	jle    41391 <check_virtual_memory+0x1b4>
   41322:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41325:	48 98                	cltq   
   41327:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4132b:	48 8d 05 ee eb 00 00 	lea    0xebee(%rip),%rax        # 4ff20 <pageinfo>
   41332:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41336:	84 c0                	test   %al,%al
   41338:	78 57                	js     41391 <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4133a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4133d:	48 98                	cltq   
   4133f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41343:	48 8d 05 d6 eb 00 00 	lea    0xebd6(%rip),%rax        # 4ff20 <pageinfo>
   4134a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4134e:	0f be c0             	movsbl %al,%eax
   41351:	48 63 d0             	movslq %eax,%rdx
   41354:	48 89 d0             	mov    %rdx,%rax
   41357:	48 c1 e0 04          	shl    $0x4,%rax
   4135b:	48 29 d0             	sub    %rdx,%rax
   4135e:	48 c1 e0 04          	shl    $0x4,%rax
   41362:	48 89 c2             	mov    %rax,%rdx
   41365:	48 8d 05 6c dd 00 00 	lea    0xdd6c(%rip),%rax        # 4f0d8 <processes+0xd8>
   4136c:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4136f:	85 c0                	test   %eax,%eax
   41371:	75 1e                	jne    41391 <check_virtual_memory+0x1b4>
   41373:	48 8d 05 f6 40 00 00 	lea    0x40f6(%rip),%rax        # 45470 <memstate_colors+0x2f0>
   4137a:	48 89 c2             	mov    %rax,%rdx
   4137d:	be 36 02 00 00       	mov    $0x236,%esi
   41382:	48 8d 05 5f 3e 00 00 	lea    0x3e5f(%rip),%rax        # 451e8 <memstate_colors+0x68>
   41389:	48 89 c7             	mov    %rax,%rdi
   4138c:	e8 63 15 00 00       	call   428f4 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41391:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41395:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   4139c:	0f 8e 68 ff ff ff    	jle    4130a <check_virtual_memory+0x12d>
        }
    }
}
   413a2:	90                   	nop
   413a3:	90                   	nop
   413a4:	c9                   	leave  
   413a5:	c3                   	ret    

00000000000413a6 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   413a6:	f3 0f 1e fa          	endbr64 
   413aa:	55                   	push   %rbp
   413ab:	48 89 e5             	mov    %rsp,%rbp
   413ae:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   413b2:	48 8d 05 e7 40 00 00 	lea    0x40e7(%rip),%rax        # 454a0 <memstate_colors+0x320>
   413b9:	48 89 c2             	mov    %rax,%rdx
   413bc:	be 00 0f 00 00       	mov    $0xf00,%esi
   413c1:	bf 20 00 00 00       	mov    $0x20,%edi
   413c6:	b8 00 00 00 00       	mov    $0x0,%eax
   413cb:	e8 e9 3b 00 00       	call   44fb9 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   413d7:	e9 1b 01 00 00       	jmp    414f7 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   413dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413df:	83 e0 3f             	and    $0x3f,%eax
   413e2:	85 c0                	test   %eax,%eax
   413e4:	75 40                	jne    41426 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   413e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413e9:	c1 e0 0c             	shl    $0xc,%eax
   413ec:	89 c2                	mov    %eax,%edx
   413ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413f1:	8d 48 3f             	lea    0x3f(%rax),%ecx
   413f4:	85 c0                	test   %eax,%eax
   413f6:	0f 48 c1             	cmovs  %ecx,%eax
   413f9:	c1 f8 06             	sar    $0x6,%eax
   413fc:	8d 48 01             	lea    0x1(%rax),%ecx
   413ff:	89 c8                	mov    %ecx,%eax
   41401:	c1 e0 02             	shl    $0x2,%eax
   41404:	01 c8                	add    %ecx,%eax
   41406:	c1 e0 04             	shl    $0x4,%eax
   41409:	83 c0 03             	add    $0x3,%eax
   4140c:	89 d1                	mov    %edx,%ecx
   4140e:	48 8d 15 9b 40 00 00 	lea    0x409b(%rip),%rdx        # 454b0 <memstate_colors+0x330>
   41415:	be 00 0f 00 00       	mov    $0xf00,%esi
   4141a:	89 c7                	mov    %eax,%edi
   4141c:	b8 00 00 00 00       	mov    $0x0,%eax
   41421:	e8 93 3b 00 00       	call   44fb9 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41426:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41429:	48 98                	cltq   
   4142b:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4142f:	48 8d 05 ea ea 00 00 	lea    0xeaea(%rip),%rax        # 4ff20 <pageinfo>
   41436:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4143a:	0f be c0             	movsbl %al,%eax
   4143d:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41440:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41443:	48 98                	cltq   
   41445:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41449:	48 8d 05 d1 ea 00 00 	lea    0xead1(%rip),%rax        # 4ff21 <pageinfo+0x1>
   41450:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41454:	84 c0                	test   %al,%al
   41456:	75 07                	jne    4145f <memshow_physical+0xb9>
            owner = PO_FREE;
   41458:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4145f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41462:	83 c0 02             	add    $0x2,%eax
   41465:	48 98                	cltq   
   41467:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4146b:	48 8d 05 0e 3d 00 00 	lea    0x3d0e(%rip),%rax        # 45180 <memstate_colors>
   41472:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41476:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   4147a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4147d:	48 98                	cltq   
   4147f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41483:	48 8d 05 97 ea 00 00 	lea    0xea97(%rip),%rax        # 4ff21 <pageinfo+0x1>
   4148a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4148e:	3c 01                	cmp    $0x1,%al
   41490:	7e 1c                	jle    414ae <memshow_physical+0x108>
   41492:	48 8d 05 67 6b 07 00 	lea    0x76b67(%rip),%rax        # b8000 <console>
   41499:	48 c1 e8 0c          	shr    $0xc,%rax
   4149d:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   414a0:	74 0c                	je     414ae <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   414a2:	b8 53 00 00 00       	mov    $0x53,%eax
   414a7:	80 cc 0f             	or     $0xf,%ah
   414aa:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   414ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414b1:	8d 50 3f             	lea    0x3f(%rax),%edx
   414b4:	85 c0                	test   %eax,%eax
   414b6:	0f 48 c2             	cmovs  %edx,%eax
   414b9:	c1 f8 06             	sar    $0x6,%eax
   414bc:	8d 50 01             	lea    0x1(%rax),%edx
   414bf:	89 d0                	mov    %edx,%eax
   414c1:	c1 e0 02             	shl    $0x2,%eax
   414c4:	01 d0                	add    %edx,%eax
   414c6:	c1 e0 04             	shl    $0x4,%eax
   414c9:	89 c1                	mov    %eax,%ecx
   414cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414ce:	99                   	cltd   
   414cf:	c1 ea 1a             	shr    $0x1a,%edx
   414d2:	01 d0                	add    %edx,%eax
   414d4:	83 e0 3f             	and    $0x3f,%eax
   414d7:	29 d0                	sub    %edx,%eax
   414d9:	83 c0 0c             	add    $0xc,%eax
   414dc:	01 c8                	add    %ecx,%eax
   414de:	48 98                	cltq   
   414e0:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   414e4:	48 8d 15 15 6b 07 00 	lea    0x76b15(%rip),%rdx        # b8000 <console>
   414eb:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414ef:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   414f3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   414f7:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   414fe:	0f 8e d8 fe ff ff    	jle    413dc <memshow_physical+0x36>
    }
}
   41504:	90                   	nop
   41505:	90                   	nop
   41506:	c9                   	leave  
   41507:	c3                   	ret    

0000000000041508 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41508:	f3 0f 1e fa          	endbr64 
   4150c:	55                   	push   %rbp
   4150d:	48 89 e5             	mov    %rsp,%rbp
   41510:	48 83 ec 40          	sub    $0x40,%rsp
   41514:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41518:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   4151c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41520:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41526:	48 89 c2             	mov    %rax,%rdx
   41529:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4152d:	48 39 c2             	cmp    %rax,%rdx
   41530:	74 1e                	je     41550 <memshow_virtual+0x48>
   41532:	48 8d 05 7f 3f 00 00 	lea    0x3f7f(%rip),%rax        # 454b8 <memstate_colors+0x338>
   41539:	48 89 c2             	mov    %rax,%rdx
   4153c:	be 67 02 00 00       	mov    $0x267,%esi
   41541:	48 8d 05 a0 3c 00 00 	lea    0x3ca0(%rip),%rax        # 451e8 <memstate_colors+0x68>
   41548:	48 89 c7             	mov    %rax,%rdi
   4154b:	e8 a4 13 00 00       	call   428f4 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41550:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41554:	48 89 c1             	mov    %rax,%rcx
   41557:	48 8d 05 87 3f 00 00 	lea    0x3f87(%rip),%rax        # 454e5 <memstate_colors+0x365>
   4155e:	48 89 c2             	mov    %rax,%rdx
   41561:	be 00 0f 00 00       	mov    $0xf00,%esi
   41566:	bf 3a 03 00 00       	mov    $0x33a,%edi
   4156b:	b8 00 00 00 00       	mov    $0x0,%eax
   41570:	e8 44 3a 00 00       	call   44fb9 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41575:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4157c:	00 
   4157d:	e9 b4 01 00 00       	jmp    41736 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41582:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41586:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4158a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4158e:	48 89 ce             	mov    %rcx,%rsi
   41591:	48 89 c7             	mov    %rax,%rdi
   41594:	e8 2b 1b 00 00       	call   430c4 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41599:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4159c:	85 c0                	test   %eax,%eax
   4159e:	79 0b                	jns    415ab <memshow_virtual+0xa3>
            color = ' ';
   415a0:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   415a6:	e9 ff 00 00 00       	jmp    416aa <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   415ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   415af:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   415b5:	76 1e                	jbe    415d5 <memshow_virtual+0xcd>
   415b7:	48 8d 05 44 3f 00 00 	lea    0x3f44(%rip),%rax        # 45502 <memstate_colors+0x382>
   415be:	48 89 c2             	mov    %rax,%rdx
   415c1:	be 70 02 00 00       	mov    $0x270,%esi
   415c6:	48 8d 05 1b 3c 00 00 	lea    0x3c1b(%rip),%rax        # 451e8 <memstate_colors+0x68>
   415cd:	48 89 c7             	mov    %rax,%rdi
   415d0:	e8 1f 13 00 00       	call   428f4 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   415d5:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415d8:	48 98                	cltq   
   415da:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   415de:	48 8d 05 3b e9 00 00 	lea    0xe93b(%rip),%rax        # 4ff20 <pageinfo>
   415e5:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   415e9:	0f be c0             	movsbl %al,%eax
   415ec:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   415ef:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415f2:	48 98                	cltq   
   415f4:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   415f8:	48 8d 05 22 e9 00 00 	lea    0xe922(%rip),%rax        # 4ff21 <pageinfo+0x1>
   415ff:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41603:	84 c0                	test   %al,%al
   41605:	75 07                	jne    4160e <memshow_virtual+0x106>
                owner = PO_FREE;
   41607:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   4160e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41611:	83 c0 02             	add    $0x2,%eax
   41614:	48 98                	cltq   
   41616:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4161a:	48 8d 05 5f 3b 00 00 	lea    0x3b5f(%rip),%rax        # 45180 <memstate_colors>
   41621:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41625:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41629:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4162c:	48 98                	cltq   
   4162e:	83 e0 04             	and    $0x4,%eax
   41631:	48 85 c0             	test   %rax,%rax
   41634:	74 27                	je     4165d <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41636:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4163a:	c1 e0 04             	shl    $0x4,%eax
   4163d:	66 25 00 f0          	and    $0xf000,%ax
   41641:	89 c2                	mov    %eax,%edx
   41643:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41647:	c1 f8 04             	sar    $0x4,%eax
   4164a:	66 25 00 0f          	and    $0xf00,%ax
   4164e:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41650:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41654:	0f b6 c0             	movzbl %al,%eax
   41657:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41659:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   4165d:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41660:	48 98                	cltq   
   41662:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41666:	48 8d 05 b4 e8 00 00 	lea    0xe8b4(%rip),%rax        # 4ff21 <pageinfo+0x1>
   4166d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41671:	3c 01                	cmp    $0x1,%al
   41673:	7e 35                	jle    416aa <memshow_virtual+0x1a2>
   41675:	48 8d 05 84 69 07 00 	lea    0x76984(%rip),%rax        # b8000 <console>
   4167c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41680:	74 28                	je     416aa <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41682:	b8 53 00 00 00       	mov    $0x53,%eax
   41687:	89 c2                	mov    %eax,%edx
   41689:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4168d:	66 25 00 f0          	and    $0xf000,%ax
   41691:	09 d0                	or     %edx,%eax
   41693:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41697:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4169a:	48 98                	cltq   
   4169c:	83 e0 04             	and    $0x4,%eax
   4169f:	48 85 c0             	test   %rax,%rax
   416a2:	75 06                	jne    416aa <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   416a4:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   416aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416ae:	48 c1 e8 0c          	shr    $0xc,%rax
   416b2:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   416b5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416b8:	83 e0 3f             	and    $0x3f,%eax
   416bb:	85 c0                	test   %eax,%eax
   416bd:	75 39                	jne    416f8 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   416bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416c2:	c1 e8 06             	shr    $0x6,%eax
   416c5:	89 c2                	mov    %eax,%edx
   416c7:	89 d0                	mov    %edx,%eax
   416c9:	c1 e0 02             	shl    $0x2,%eax
   416cc:	01 d0                	add    %edx,%eax
   416ce:	c1 e0 04             	shl    $0x4,%eax
   416d1:	05 73 03 00 00       	add    $0x373,%eax
   416d6:	89 c7                	mov    %eax,%edi
   416d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416dc:	48 89 c1             	mov    %rax,%rcx
   416df:	48 8d 05 ca 3d 00 00 	lea    0x3dca(%rip),%rax        # 454b0 <memstate_colors+0x330>
   416e6:	48 89 c2             	mov    %rax,%rdx
   416e9:	be 00 0f 00 00       	mov    $0xf00,%esi
   416ee:	b8 00 00 00 00       	mov    $0x0,%eax
   416f3:	e8 c1 38 00 00       	call   44fb9 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   416f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416fb:	c1 e8 06             	shr    $0x6,%eax
   416fe:	89 c2                	mov    %eax,%edx
   41700:	89 d0                	mov    %edx,%eax
   41702:	c1 e0 02             	shl    $0x2,%eax
   41705:	01 d0                	add    %edx,%eax
   41707:	c1 e0 04             	shl    $0x4,%eax
   4170a:	89 c2                	mov    %eax,%edx
   4170c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4170f:	83 e0 3f             	and    $0x3f,%eax
   41712:	01 d0                	add    %edx,%eax
   41714:	05 7c 03 00 00       	add    $0x37c,%eax
   41719:	89 c0                	mov    %eax,%eax
   4171b:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4171f:	48 8d 15 da 68 07 00 	lea    0x768da(%rip),%rdx        # b8000 <console>
   41726:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4172a:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4172e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41735:	00 
   41736:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4173d:	00 
   4173e:	0f 86 3e fe ff ff    	jbe    41582 <memshow_virtual+0x7a>
    }
}
   41744:	90                   	nop
   41745:	90                   	nop
   41746:	c9                   	leave  
   41747:	c3                   	ret    

0000000000041748 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41748:	f3 0f 1e fa          	endbr64 
   4174c:	55                   	push   %rbp
   4174d:	48 89 e5             	mov    %rsp,%rbp
   41750:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41754:	8b 05 ca eb 00 00    	mov    0xebca(%rip),%eax        # 50324 <last_ticks.1>
   4175a:	85 c0                	test   %eax,%eax
   4175c:	74 13                	je     41771 <memshow_virtual_animate+0x29>
   4175e:	8b 05 bc eb 00 00    	mov    0xebbc(%rip),%eax        # 50320 <ticks>
   41764:	8b 15 ba eb 00 00    	mov    0xebba(%rip),%edx        # 50324 <last_ticks.1>
   4176a:	29 d0                	sub    %edx,%eax
   4176c:	83 f8 31             	cmp    $0x31,%eax
   4176f:	76 2c                	jbe    4179d <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   41771:	8b 05 a9 eb 00 00    	mov    0xeba9(%rip),%eax        # 50320 <ticks>
   41777:	89 05 a7 eb 00 00    	mov    %eax,0xeba7(%rip)        # 50324 <last_ticks.1>
        ++showing;
   4177d:	8b 05 81 48 00 00    	mov    0x4881(%rip),%eax        # 46004 <showing.0>
   41783:	83 c0 01             	add    $0x1,%eax
   41786:	89 05 78 48 00 00    	mov    %eax,0x4878(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4178c:	eb 0f                	jmp    4179d <memshow_virtual_animate+0x55>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   4178e:	8b 05 70 48 00 00    	mov    0x4870(%rip),%eax        # 46004 <showing.0>
   41794:	83 c0 01             	add    $0x1,%eax
   41797:	89 05 67 48 00 00    	mov    %eax,0x4867(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   4179d:	8b 05 61 48 00 00    	mov    0x4861(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   417a3:	83 f8 20             	cmp    $0x20,%eax
   417a6:	7f 33                	jg     417db <memshow_virtual_animate+0x93>
   417a8:	8b 05 56 48 00 00    	mov    0x4856(%rip),%eax        # 46004 <showing.0>
   417ae:	99                   	cltd   
   417af:	c1 ea 1c             	shr    $0x1c,%edx
   417b2:	01 d0                	add    %edx,%eax
   417b4:	83 e0 0f             	and    $0xf,%eax
   417b7:	29 d0                	sub    %edx,%eax
   417b9:	48 63 d0             	movslq %eax,%rdx
   417bc:	48 89 d0             	mov    %rdx,%rax
   417bf:	48 c1 e0 04          	shl    $0x4,%rax
   417c3:	48 29 d0             	sub    %rdx,%rax
   417c6:	48 c1 e0 04          	shl    $0x4,%rax
   417ca:	48 89 c2             	mov    %rax,%rdx
   417cd:	48 8d 05 04 d9 00 00 	lea    0xd904(%rip),%rax        # 4f0d8 <processes+0xd8>
   417d4:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   417d7:	85 c0                	test   %eax,%eax
   417d9:	74 b3                	je     4178e <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   417db:	8b 05 23 48 00 00    	mov    0x4823(%rip),%eax        # 46004 <showing.0>
   417e1:	99                   	cltd   
   417e2:	c1 ea 1c             	shr    $0x1c,%edx
   417e5:	01 d0                	add    %edx,%eax
   417e7:	83 e0 0f             	and    $0xf,%eax
   417ea:	29 d0                	sub    %edx,%eax
   417ec:	89 05 12 48 00 00    	mov    %eax,0x4812(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   417f2:	8b 05 0c 48 00 00    	mov    0x480c(%rip),%eax        # 46004 <showing.0>
   417f8:	48 63 d0             	movslq %eax,%rdx
   417fb:	48 89 d0             	mov    %rdx,%rax
   417fe:	48 c1 e0 04          	shl    $0x4,%rax
   41802:	48 29 d0             	sub    %rdx,%rax
   41805:	48 c1 e0 04          	shl    $0x4,%rax
   41809:	48 89 c2             	mov    %rax,%rdx
   4180c:	48 8d 05 c5 d8 00 00 	lea    0xd8c5(%rip),%rax        # 4f0d8 <processes+0xd8>
   41813:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41816:	85 c0                	test   %eax,%eax
   41818:	0f 84 82 00 00 00    	je     418a0 <memshow_virtual_animate+0x158>
   4181e:	8b 05 e0 47 00 00    	mov    0x47e0(%rip),%eax        # 46004 <showing.0>
   41824:	48 63 d0             	movslq %eax,%rdx
   41827:	48 89 d0             	mov    %rdx,%rax
   4182a:	48 c1 e0 04          	shl    $0x4,%rax
   4182e:	48 29 d0             	sub    %rdx,%rax
   41831:	48 c1 e0 04          	shl    $0x4,%rax
   41835:	48 89 c2             	mov    %rax,%rdx
   41838:	48 8d 05 a9 d8 00 00 	lea    0xd8a9(%rip),%rax        # 4f0e8 <processes+0xe8>
   4183f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41843:	84 c0                	test   %al,%al
   41845:	74 59                	je     418a0 <memshow_virtual_animate+0x158>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41847:	8b 15 b7 47 00 00    	mov    0x47b7(%rip),%edx        # 46004 <showing.0>
   4184d:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41851:	89 d1                	mov    %edx,%ecx
   41853:	48 8d 15 c2 3c 00 00 	lea    0x3cc2(%rip),%rdx        # 4551c <memstate_colors+0x39c>
   4185a:	be 04 00 00 00       	mov    $0x4,%esi
   4185f:	48 89 c7             	mov    %rax,%rdi
   41862:	b8 00 00 00 00       	mov    $0x0,%eax
   41867:	e8 68 38 00 00       	call   450d4 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   4186c:	8b 05 92 47 00 00    	mov    0x4792(%rip),%eax        # 46004 <showing.0>
   41872:	48 63 d0             	movslq %eax,%rdx
   41875:	48 89 d0             	mov    %rdx,%rax
   41878:	48 c1 e0 04          	shl    $0x4,%rax
   4187c:	48 29 d0             	sub    %rdx,%rax
   4187f:	48 c1 e0 04          	shl    $0x4,%rax
   41883:	48 89 c2             	mov    %rax,%rdx
   41886:	48 8d 05 53 d8 00 00 	lea    0xd853(%rip),%rax        # 4f0e0 <processes+0xe0>
   4188d:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41891:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41895:	48 89 d6             	mov    %rdx,%rsi
   41898:	48 89 c7             	mov    %rax,%rdi
   4189b:	e8 68 fc ff ff       	call   41508 <memshow_virtual>
    }
}
   418a0:	90                   	nop
   418a1:	c9                   	leave  
   418a2:	c3                   	ret    

00000000000418a3 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   418a3:	f3 0f 1e fa          	endbr64 
   418a7:	55                   	push   %rbp
   418a8:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   418ab:	e8 5f 01 00 00       	call   41a0f <segments_init>
    interrupt_init();
   418b0:	e8 44 04 00 00       	call   41cf9 <interrupt_init>
    virtual_memory_init();
   418b5:	e8 11 11 00 00       	call   429cb <virtual_memory_init>
}
   418ba:	90                   	nop
   418bb:	5d                   	pop    %rbp
   418bc:	c3                   	ret    

00000000000418bd <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   418bd:	f3 0f 1e fa          	endbr64 
   418c1:	55                   	push   %rbp
   418c2:	48 89 e5             	mov    %rsp,%rbp
   418c5:	48 83 ec 18          	sub    $0x18,%rsp
   418c9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418cd:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   418d1:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   418d4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   418d7:	48 98                	cltq   
   418d9:	48 c1 e0 2d          	shl    $0x2d,%rax
   418dd:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   418e1:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   418e8:	90 00 00 
   418eb:	48 09 c2             	or     %rax,%rdx
    *segment = type
   418ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418f2:	48 89 10             	mov    %rdx,(%rax)
}
   418f5:	90                   	nop
   418f6:	c9                   	leave  
   418f7:	c3                   	ret    

00000000000418f8 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   418f8:	f3 0f 1e fa          	endbr64 
   418fc:	55                   	push   %rbp
   418fd:	48 89 e5             	mov    %rsp,%rbp
   41900:	48 83 ec 28          	sub    $0x28,%rsp
   41904:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41908:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4190c:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4190f:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41913:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41917:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4191b:	48 c1 e0 10          	shl    $0x10,%rax
   4191f:	48 89 c2             	mov    %rax,%rdx
   41922:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41929:	00 00 00 
   4192c:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   4192f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41933:	48 c1 e0 20          	shl    $0x20,%rax
   41937:	48 89 c1             	mov    %rax,%rcx
   4193a:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41941:	00 00 ff 
   41944:	48 21 c8             	and    %rcx,%rax
   41947:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   4194a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4194e:	48 83 e8 01          	sub    $0x1,%rax
   41952:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41955:	48 09 d0             	or     %rdx,%rax
        | type
   41958:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   4195c:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   4195f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41962:	48 98                	cltq   
   41964:	48 c1 e0 2d          	shl    $0x2d,%rax
   41968:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   4196b:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41972:	80 00 00 
   41975:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41978:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4197c:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   4197f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41983:	48 83 c0 08          	add    $0x8,%rax
   41987:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4198b:	48 c1 ea 20          	shr    $0x20,%rdx
   4198f:	48 89 10             	mov    %rdx,(%rax)
}
   41992:	90                   	nop
   41993:	c9                   	leave  
   41994:	c3                   	ret    

0000000000041995 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41995:	f3 0f 1e fa          	endbr64 
   41999:	55                   	push   %rbp
   4199a:	48 89 e5             	mov    %rsp,%rbp
   4199d:	48 83 ec 20          	sub    $0x20,%rsp
   419a1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   419a5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   419a9:	89 55 ec             	mov    %edx,-0x14(%rbp)
   419ac:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   419b0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419b4:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   419b7:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   419bb:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   419be:	8b 45 ec             	mov    -0x14(%rbp),%eax
   419c1:	48 98                	cltq   
   419c3:	48 c1 e0 2d          	shl    $0x2d,%rax
   419c7:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   419ca:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419ce:	48 c1 e0 20          	shl    $0x20,%rax
   419d2:	48 89 c1             	mov    %rax,%rcx
   419d5:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   419dc:	00 ff ff 
   419df:	48 21 c8             	and    %rcx,%rax
   419e2:	48 09 c2             	or     %rax,%rdx
   419e5:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   419ec:	80 00 00 
   419ef:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   419f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419f6:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   419f9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419fd:	48 c1 e8 20          	shr    $0x20,%rax
   41a01:	48 89 c2             	mov    %rax,%rdx
   41a04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a08:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41a0c:	90                   	nop
   41a0d:	c9                   	leave  
   41a0e:	c3                   	ret    

0000000000041a0f <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41a0f:	f3 0f 1e fa          	endbr64 
   41a13:	55                   	push   %rbp
   41a14:	48 89 e5             	mov    %rsp,%rbp
   41a17:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41a1b:	48 c7 05 1a e9 00 00 	movq   $0x0,0xe91a(%rip)        # 50340 <segments>
   41a22:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41a26:	ba 00 00 00 00       	mov    $0x0,%edx
   41a2b:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41a32:	08 20 00 
   41a35:	48 89 c6             	mov    %rax,%rsi
   41a38:	48 8d 05 09 e9 00 00 	lea    0xe909(%rip),%rax        # 50348 <segments+0x8>
   41a3f:	48 89 c7             	mov    %rax,%rdi
   41a42:	e8 76 fe ff ff       	call   418bd <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41a47:	ba 03 00 00 00       	mov    $0x3,%edx
   41a4c:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41a53:	08 20 00 
   41a56:	48 89 c6             	mov    %rax,%rsi
   41a59:	48 8d 05 f0 e8 00 00 	lea    0xe8f0(%rip),%rax        # 50350 <segments+0x10>
   41a60:	48 89 c7             	mov    %rax,%rdi
   41a63:	e8 55 fe ff ff       	call   418bd <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41a68:	ba 00 00 00 00       	mov    $0x0,%edx
   41a6d:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41a74:	02 00 00 
   41a77:	48 89 c6             	mov    %rax,%rsi
   41a7a:	48 8d 05 d7 e8 00 00 	lea    0xe8d7(%rip),%rax        # 50358 <segments+0x18>
   41a81:	48 89 c7             	mov    %rax,%rdi
   41a84:	e8 34 fe ff ff       	call   418bd <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41a89:	ba 03 00 00 00       	mov    $0x3,%edx
   41a8e:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41a95:	02 00 00 
   41a98:	48 89 c6             	mov    %rax,%rsi
   41a9b:	48 8d 05 be e8 00 00 	lea    0xe8be(%rip),%rax        # 50360 <segments+0x20>
   41aa2:	48 89 c7             	mov    %rax,%rdi
   41aa5:	e8 13 fe ff ff       	call   418bd <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41aaa:	48 8d 05 cf f8 00 00 	lea    0xf8cf(%rip),%rax        # 51380 <kernel_task_descriptor>
   41ab1:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41ab7:	48 89 c1             	mov    %rax,%rcx
   41aba:	ba 00 00 00 00       	mov    $0x0,%edx
   41abf:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41ac6:	09 00 00 
   41ac9:	48 89 c6             	mov    %rax,%rsi
   41acc:	48 8d 05 95 e8 00 00 	lea    0xe895(%rip),%rax        # 50368 <segments+0x28>
   41ad3:	48 89 c7             	mov    %rax,%rdi
   41ad6:	e8 1d fe ff ff       	call   418f8 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41adb:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41ae1:	48 8d 05 58 e8 00 00 	lea    0xe858(%rip),%rax        # 50340 <segments>
   41ae8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41aec:	ba 60 00 00 00       	mov    $0x60,%edx
   41af1:	be 00 00 00 00       	mov    $0x0,%esi
   41af6:	48 8d 05 83 f8 00 00 	lea    0xf883(%rip),%rax        # 51380 <kernel_task_descriptor>
   41afd:	48 89 c7             	mov    %rax,%rdi
   41b00:	e8 75 26 00 00       	call   4417a <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41b05:	48 c7 05 74 f8 00 00 	movq   $0x80000,0xf874(%rip)        # 51384 <kernel_task_descriptor+0x4>
   41b0c:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41b10:	ba 00 10 00 00       	mov    $0x1000,%edx
   41b15:	be 00 00 00 00       	mov    $0x0,%esi
   41b1a:	48 8d 05 5f e8 00 00 	lea    0xe85f(%rip),%rax        # 50380 <interrupt_descriptors>
   41b21:	48 89 c7             	mov    %rax,%rdi
   41b24:	e8 51 26 00 00       	call   4417a <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41b29:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41b30:	eb 3c                	jmp    41b6e <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41b32:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   41b39:	48 89 c2             	mov    %rax,%rdx
   41b3c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41b3f:	48 c1 e0 04          	shl    $0x4,%rax
   41b43:	48 89 c1             	mov    %rax,%rcx
   41b46:	48 8d 05 33 e8 00 00 	lea    0xe833(%rip),%rax        # 50380 <interrupt_descriptors>
   41b4d:	48 01 c8             	add    %rcx,%rax
   41b50:	48 89 d1             	mov    %rdx,%rcx
   41b53:	ba 00 00 00 00       	mov    $0x0,%edx
   41b58:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41b5f:	0e 00 00 
   41b62:	48 89 c7             	mov    %rax,%rdi
   41b65:	e8 2b fe ff ff       	call   41995 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41b6a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41b6e:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41b75:	76 bb                	jbe    41b32 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41b77:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   41b7e:	48 89 c1             	mov    %rax,%rcx
   41b81:	ba 00 00 00 00       	mov    $0x0,%edx
   41b86:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41b8d:	0e 00 00 
   41b90:	48 89 c6             	mov    %rax,%rsi
   41b93:	48 8d 05 e6 e9 00 00 	lea    0xe9e6(%rip),%rax        # 50580 <interrupt_descriptors+0x200>
   41b9a:	48 89 c7             	mov    %rax,%rdi
   41b9d:	e8 f3 fd ff ff       	call   41995 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41ba2:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   41ba9:	48 89 c1             	mov    %rax,%rcx
   41bac:	ba 00 00 00 00       	mov    $0x0,%edx
   41bb1:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41bb8:	0e 00 00 
   41bbb:	48 89 c6             	mov    %rax,%rsi
   41bbe:	48 8d 05 8b e8 00 00 	lea    0xe88b(%rip),%rax        # 50450 <interrupt_descriptors+0xd0>
   41bc5:	48 89 c7             	mov    %rax,%rdi
   41bc8:	e8 c8 fd ff ff       	call   41995 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41bcd:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   41bd4:	48 89 c1             	mov    %rax,%rcx
   41bd7:	ba 00 00 00 00       	mov    $0x0,%edx
   41bdc:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41be3:	0e 00 00 
   41be6:	48 89 c6             	mov    %rax,%rsi
   41be9:	48 8d 05 70 e8 00 00 	lea    0xe870(%rip),%rax        # 50460 <interrupt_descriptors+0xe0>
   41bf0:	48 89 c7             	mov    %rax,%rdi
   41bf3:	e8 9d fd ff ff       	call   41995 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41bf8:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41bff:	eb 50                	jmp    41c51 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41c01:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c04:	83 e8 30             	sub    $0x30,%eax
   41c07:	89 c0                	mov    %eax,%eax
   41c09:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   41c10:	00 
   41c11:	48 8d 05 cf e4 ff ff 	lea    -0x1b31(%rip),%rax        # 400e7 <sys_int_handlers>
   41c18:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41c1c:	48 89 c2             	mov    %rax,%rdx
   41c1f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c22:	48 c1 e0 04          	shl    $0x4,%rax
   41c26:	48 89 c1             	mov    %rax,%rcx
   41c29:	48 8d 05 50 e7 00 00 	lea    0xe750(%rip),%rax        # 50380 <interrupt_descriptors>
   41c30:	48 01 c8             	add    %rcx,%rax
   41c33:	48 89 d1             	mov    %rdx,%rcx
   41c36:	ba 03 00 00 00       	mov    $0x3,%edx
   41c3b:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41c42:	0e 00 00 
   41c45:	48 89 c7             	mov    %rax,%rdi
   41c48:	e8 48 fd ff ff       	call   41995 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41c4d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41c51:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41c55:	76 aa                	jbe    41c01 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41c57:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41c5d:	48 8d 05 1c e7 00 00 	lea    0xe71c(%rip),%rax        # 50380 <interrupt_descriptors>
   41c64:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41c68:	b8 28 00 00 00       	mov    $0x28,%eax
   41c6d:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41c71:	0f 00 d8             	ltr    %ax
   41c74:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41c78:	0f 20 c0             	mov    %cr0,%rax
   41c7b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41c7f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41c83:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41c86:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41c8d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c90:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41c93:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c96:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41c9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41c9e:	0f 22 c0             	mov    %rax,%cr0
}
   41ca1:	90                   	nop
    lcr0(cr0);
}
   41ca2:	90                   	nop
   41ca3:	c9                   	leave  
   41ca4:	c3                   	ret    

0000000000041ca5 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41ca5:	f3 0f 1e fa          	endbr64 
   41ca9:	55                   	push   %rbp
   41caa:	48 89 e5             	mov    %rsp,%rbp
   41cad:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41cb1:	0f b7 05 28 f7 00 00 	movzwl 0xf728(%rip),%eax        # 513e0 <interrupts_enabled>
   41cb8:	f7 d0                	not    %eax
   41cba:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41cbe:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41cc2:	0f b6 c0             	movzbl %al,%eax
   41cc5:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41ccc:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ccf:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41cd3:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41cd6:	ee                   	out    %al,(%dx)
}
   41cd7:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41cd8:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41cdc:	66 c1 e8 08          	shr    $0x8,%ax
   41ce0:	0f b6 c0             	movzbl %al,%eax
   41ce3:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41cea:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ced:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41cf1:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41cf4:	ee                   	out    %al,(%dx)
}
   41cf5:	90                   	nop
}
   41cf6:	90                   	nop
   41cf7:	c9                   	leave  
   41cf8:	c3                   	ret    

0000000000041cf9 <interrupt_init>:

void interrupt_init(void) {
   41cf9:	f3 0f 1e fa          	endbr64 
   41cfd:	55                   	push   %rbp
   41cfe:	48 89 e5             	mov    %rsp,%rbp
   41d01:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41d05:	66 c7 05 d2 f6 00 00 	movw   $0x0,0xf6d2(%rip)        # 513e0 <interrupts_enabled>
   41d0c:	00 00 
    interrupt_mask();
   41d0e:	e8 92 ff ff ff       	call   41ca5 <interrupt_mask>
   41d13:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41d1a:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d1e:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41d22:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41d25:	ee                   	out    %al,(%dx)
}
   41d26:	90                   	nop
   41d27:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41d2e:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d32:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41d36:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41d39:	ee                   	out    %al,(%dx)
}
   41d3a:	90                   	nop
   41d3b:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41d42:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d46:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41d4a:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41d4d:	ee                   	out    %al,(%dx)
}
   41d4e:	90                   	nop
   41d4f:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41d56:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d5a:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41d5e:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41d61:	ee                   	out    %al,(%dx)
}
   41d62:	90                   	nop
   41d63:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41d6a:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d6e:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41d72:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41d75:	ee                   	out    %al,(%dx)
}
   41d76:	90                   	nop
   41d77:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41d7e:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d82:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41d86:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41d89:	ee                   	out    %al,(%dx)
}
   41d8a:	90                   	nop
   41d8b:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41d92:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d96:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41d9a:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41d9d:	ee                   	out    %al,(%dx)
}
   41d9e:	90                   	nop
   41d9f:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41da6:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41daa:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41dae:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41db1:	ee                   	out    %al,(%dx)
}
   41db2:	90                   	nop
   41db3:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41dba:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dbe:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41dc2:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41dc5:	ee                   	out    %al,(%dx)
}
   41dc6:	90                   	nop
   41dc7:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41dce:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dd2:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41dd6:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41dd9:	ee                   	out    %al,(%dx)
}
   41dda:	90                   	nop
   41ddb:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41de2:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41de6:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41dea:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ded:	ee                   	out    %al,(%dx)
}
   41dee:	90                   	nop
   41def:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41df6:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dfa:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41dfe:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e01:	ee                   	out    %al,(%dx)
}
   41e02:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41e03:	e8 9d fe ff ff       	call   41ca5 <interrupt_mask>
}
   41e08:	90                   	nop
   41e09:	c9                   	leave  
   41e0a:	c3                   	ret    

0000000000041e0b <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41e0b:	f3 0f 1e fa          	endbr64 
   41e0f:	55                   	push   %rbp
   41e10:	48 89 e5             	mov    %rsp,%rbp
   41e13:	48 83 ec 28          	sub    $0x28,%rsp
   41e17:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41e1a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41e1e:	0f 8e 9f 00 00 00    	jle    41ec3 <timer_init+0xb8>
   41e24:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41e2b:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e2f:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41e33:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e36:	ee                   	out    %al,(%dx)
}
   41e37:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41e38:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e3b:	89 c2                	mov    %eax,%edx
   41e3d:	c1 ea 1f             	shr    $0x1f,%edx
   41e40:	01 d0                	add    %edx,%eax
   41e42:	d1 f8                	sar    %eax
   41e44:	05 de 34 12 00       	add    $0x1234de,%eax
   41e49:	99                   	cltd   
   41e4a:	f7 7d dc             	idivl  -0x24(%rbp)
   41e4d:	89 c2                	mov    %eax,%edx
   41e4f:	89 d0                	mov    %edx,%eax
   41e51:	c1 f8 1f             	sar    $0x1f,%eax
   41e54:	c1 e8 18             	shr    $0x18,%eax
   41e57:	89 c1                	mov    %eax,%ecx
   41e59:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41e5c:	0f b6 c0             	movzbl %al,%eax
   41e5f:	29 c8                	sub    %ecx,%eax
   41e61:	0f b6 c0             	movzbl %al,%eax
   41e64:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41e6b:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e6e:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41e72:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e75:	ee                   	out    %al,(%dx)
}
   41e76:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41e77:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e7a:	89 c2                	mov    %eax,%edx
   41e7c:	c1 ea 1f             	shr    $0x1f,%edx
   41e7f:	01 d0                	add    %edx,%eax
   41e81:	d1 f8                	sar    %eax
   41e83:	05 de 34 12 00       	add    $0x1234de,%eax
   41e88:	99                   	cltd   
   41e89:	f7 7d dc             	idivl  -0x24(%rbp)
   41e8c:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41e92:	85 c0                	test   %eax,%eax
   41e94:	0f 48 c2             	cmovs  %edx,%eax
   41e97:	c1 f8 08             	sar    $0x8,%eax
   41e9a:	0f b6 c0             	movzbl %al,%eax
   41e9d:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41ea4:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ea7:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41eab:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41eae:	ee                   	out    %al,(%dx)
}
   41eaf:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41eb0:	0f b7 05 29 f5 00 00 	movzwl 0xf529(%rip),%eax        # 513e0 <interrupts_enabled>
   41eb7:	83 c8 01             	or     $0x1,%eax
   41eba:	66 89 05 1f f5 00 00 	mov    %ax,0xf51f(%rip)        # 513e0 <interrupts_enabled>
   41ec1:	eb 11                	jmp    41ed4 <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41ec3:	0f b7 05 16 f5 00 00 	movzwl 0xf516(%rip),%eax        # 513e0 <interrupts_enabled>
   41eca:	83 e0 fe             	and    $0xfffffffe,%eax
   41ecd:	66 89 05 0c f5 00 00 	mov    %ax,0xf50c(%rip)        # 513e0 <interrupts_enabled>
    }
    interrupt_mask();
   41ed4:	e8 cc fd ff ff       	call   41ca5 <interrupt_mask>
}
   41ed9:	90                   	nop
   41eda:	c9                   	leave  
   41edb:	c3                   	ret    

0000000000041edc <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41edc:	f3 0f 1e fa          	endbr64 
   41ee0:	55                   	push   %rbp
   41ee1:	48 89 e5             	mov    %rsp,%rbp
   41ee4:	48 83 ec 08          	sub    $0x8,%rsp
   41ee8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41eec:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41ef1:	74 14                	je     41f07 <physical_memory_isreserved+0x2b>
   41ef3:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41efa:	00 
   41efb:	76 11                	jbe    41f0e <physical_memory_isreserved+0x32>
   41efd:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41f04:	00 
   41f05:	77 07                	ja     41f0e <physical_memory_isreserved+0x32>
   41f07:	b8 01 00 00 00       	mov    $0x1,%eax
   41f0c:	eb 05                	jmp    41f13 <physical_memory_isreserved+0x37>
   41f0e:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41f13:	c9                   	leave  
   41f14:	c3                   	ret    

0000000000041f15 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41f15:	f3 0f 1e fa          	endbr64 
   41f19:	55                   	push   %rbp
   41f1a:	48 89 e5             	mov    %rsp,%rbp
   41f1d:	48 83 ec 10          	sub    $0x10,%rsp
   41f21:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41f24:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41f27:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41f2a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f2d:	c1 e0 10             	shl    $0x10,%eax
   41f30:	89 c2                	mov    %eax,%edx
   41f32:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f35:	c1 e0 0b             	shl    $0xb,%eax
   41f38:	09 c2                	or     %eax,%edx
   41f3a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f3d:	c1 e0 08             	shl    $0x8,%eax
   41f40:	09 d0                	or     %edx,%eax
}
   41f42:	c9                   	leave  
   41f43:	c3                   	ret    

0000000000041f44 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41f44:	f3 0f 1e fa          	endbr64 
   41f48:	55                   	push   %rbp
   41f49:	48 89 e5             	mov    %rsp,%rbp
   41f4c:	48 83 ec 18          	sub    $0x18,%rsp
   41f50:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41f53:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41f56:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f59:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f5c:	09 d0                	or     %edx,%eax
   41f5e:	0d 00 00 00 80       	or     $0x80000000,%eax
   41f63:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41f6a:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41f6d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f70:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f73:	ef                   	out    %eax,(%dx)
}
   41f74:	90                   	nop
   41f75:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41f7c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f7f:	89 c2                	mov    %eax,%edx
   41f81:	ed                   	in     (%dx),%eax
   41f82:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41f85:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41f88:	c9                   	leave  
   41f89:	c3                   	ret    

0000000000041f8a <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41f8a:	f3 0f 1e fa          	endbr64 
   41f8e:	55                   	push   %rbp
   41f8f:	48 89 e5             	mov    %rsp,%rbp
   41f92:	48 83 ec 28          	sub    $0x28,%rsp
   41f96:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41f99:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41f9c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41fa3:	eb 73                	jmp    42018 <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   41fa5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41fac:	eb 60                	jmp    4200e <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   41fae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41fb5:	eb 4a                	jmp    42001 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41fb7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41fba:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41fbd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41fc0:	89 ce                	mov    %ecx,%esi
   41fc2:	89 c7                	mov    %eax,%edi
   41fc4:	e8 4c ff ff ff       	call   41f15 <pci_make_configaddr>
   41fc9:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41fcc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fcf:	be 00 00 00 00       	mov    $0x0,%esi
   41fd4:	89 c7                	mov    %eax,%edi
   41fd6:	e8 69 ff ff ff       	call   41f44 <pci_config_readl>
   41fdb:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41fde:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41fe1:	c1 e0 10             	shl    $0x10,%eax
   41fe4:	0b 45 dc             	or     -0x24(%rbp),%eax
   41fe7:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41fea:	75 05                	jne    41ff1 <pci_find_device+0x67>
                    return configaddr;
   41fec:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fef:	eb 35                	jmp    42026 <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41ff1:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41ff5:	75 06                	jne    41ffd <pci_find_device+0x73>
   41ff7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41ffb:	74 0c                	je     42009 <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   41ffd:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42001:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   42005:	75 b0                	jne    41fb7 <pci_find_device+0x2d>
   42007:	eb 01                	jmp    4200a <pci_find_device+0x80>
                    break;
   42009:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   4200a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4200e:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   42012:	75 9a                	jne    41fae <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   42014:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42018:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   4201f:	75 84                	jne    41fa5 <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   42021:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   42026:	c9                   	leave  
   42027:	c3                   	ret    

0000000000042028 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   42028:	f3 0f 1e fa          	endbr64 
   4202c:	55                   	push   %rbp
   4202d:	48 89 e5             	mov    %rsp,%rbp
   42030:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42034:	be 13 71 00 00       	mov    $0x7113,%esi
   42039:	bf 86 80 00 00       	mov    $0x8086,%edi
   4203e:	e8 47 ff ff ff       	call   41f8a <pci_find_device>
   42043:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   42046:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4204a:	78 30                	js     4207c <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   4204c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4204f:	be 40 00 00 00       	mov    $0x40,%esi
   42054:	89 c7                	mov    %eax,%edi
   42056:	e8 e9 fe ff ff       	call   41f44 <pci_config_readl>
   4205b:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42060:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42063:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42066:	83 c0 04             	add    $0x4,%eax
   42069:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4206c:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42072:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42076:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42079:	66 ef                	out    %ax,(%dx)
}
   4207b:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   4207c:	48 8d 05 9d 34 00 00 	lea    0x349d(%rip),%rax        # 45520 <memstate_colors+0x3a0>
   42083:	48 89 c2             	mov    %rax,%rdx
   42086:	be 00 c0 00 00       	mov    $0xc000,%esi
   4208b:	bf 80 07 00 00       	mov    $0x780,%edi
   42090:	b8 00 00 00 00       	mov    $0x0,%eax
   42095:	e8 1f 2f 00 00       	call   44fb9 <console_printf>
 spinloop: goto spinloop;
   4209a:	eb fe                	jmp    4209a <poweroff+0x72>

000000000004209c <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   4209c:	f3 0f 1e fa          	endbr64 
   420a0:	55                   	push   %rbp
   420a1:	48 89 e5             	mov    %rsp,%rbp
   420a4:	48 83 ec 10          	sub    $0x10,%rsp
   420a8:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   420af:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420b3:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420b7:	8b 55 fc             	mov    -0x4(%rbp),%edx
   420ba:	ee                   	out    %al,(%dx)
}
   420bb:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   420bc:	eb fe                	jmp    420bc <reboot+0x20>

00000000000420be <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   420be:	f3 0f 1e fa          	endbr64 
   420c2:	55                   	push   %rbp
   420c3:	48 89 e5             	mov    %rsp,%rbp
   420c6:	48 83 ec 10          	sub    $0x10,%rsp
   420ca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   420ce:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   420d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420d5:	48 83 c0 18          	add    $0x18,%rax
   420d9:	ba c0 00 00 00       	mov    $0xc0,%edx
   420de:	be 00 00 00 00       	mov    $0x0,%esi
   420e3:	48 89 c7             	mov    %rax,%rdi
   420e6:	e8 8f 20 00 00       	call   4417a <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   420eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420ef:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   420f6:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   420f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420fc:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   42103:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   42107:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4210b:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   42112:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   42116:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4211a:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   42121:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   42123:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42127:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   4212e:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42132:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42135:	83 e0 01             	and    $0x1,%eax
   42138:	85 c0                	test   %eax,%eax
   4213a:	74 1c                	je     42158 <process_init+0x9a>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4213c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42140:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   42147:	80 cc 30             	or     $0x30,%ah
   4214a:	48 89 c2             	mov    %rax,%rdx
   4214d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42151:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42158:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4215b:	83 e0 02             	and    $0x2,%eax
   4215e:	85 c0                	test   %eax,%eax
   42160:	74 1c                	je     4217e <process_init+0xc0>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42162:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42166:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   4216d:	80 e4 fd             	and    $0xfd,%ah
   42170:	48 89 c2             	mov    %rax,%rdx
   42173:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42177:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   4217e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42182:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   42189:	90                   	nop
   4218a:	c9                   	leave  
   4218b:	c3                   	ret    

000000000004218c <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   4218c:	f3 0f 1e fa          	endbr64 
   42190:	55                   	push   %rbp
   42191:	48 89 e5             	mov    %rsp,%rbp
   42194:	48 83 ec 28          	sub    $0x28,%rsp
   42198:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4219b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4219f:	78 09                	js     421aa <console_show_cursor+0x1e>
   421a1:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   421a8:	7e 07                	jle    421b1 <console_show_cursor+0x25>
        cpos = 0;
   421aa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   421b1:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   421b8:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421bc:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   421c0:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   421c3:	ee                   	out    %al,(%dx)
}
   421c4:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   421c5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   421c8:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   421ce:	85 c0                	test   %eax,%eax
   421d0:	0f 48 c2             	cmovs  %edx,%eax
   421d3:	c1 f8 08             	sar    $0x8,%eax
   421d6:	0f b6 c0             	movzbl %al,%eax
   421d9:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   421e0:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421e3:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   421e7:	8b 55 ec             	mov    -0x14(%rbp),%edx
   421ea:	ee                   	out    %al,(%dx)
}
   421eb:	90                   	nop
   421ec:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   421f3:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421f7:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   421fb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   421fe:	ee                   	out    %al,(%dx)
}
   421ff:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42200:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42203:	99                   	cltd   
   42204:	c1 ea 18             	shr    $0x18,%edx
   42207:	01 d0                	add    %edx,%eax
   42209:	0f b6 c0             	movzbl %al,%eax
   4220c:	29 d0                	sub    %edx,%eax
   4220e:	0f b6 c0             	movzbl %al,%eax
   42211:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   42218:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4221b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4221f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42222:	ee                   	out    %al,(%dx)
}
   42223:	90                   	nop
}
   42224:	90                   	nop
   42225:	c9                   	leave  
   42226:	c3                   	ret    

0000000000042227 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   42227:	f3 0f 1e fa          	endbr64 
   4222b:	55                   	push   %rbp
   4222c:	48 89 e5             	mov    %rsp,%rbp
   4222f:	48 83 ec 20          	sub    $0x20,%rsp
   42233:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4223a:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4223d:	89 c2                	mov    %eax,%edx
   4223f:	ec                   	in     (%dx),%al
   42240:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42243:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   42247:	0f b6 c0             	movzbl %al,%eax
   4224a:	83 e0 01             	and    $0x1,%eax
   4224d:	85 c0                	test   %eax,%eax
   4224f:	75 0a                	jne    4225b <keyboard_readc+0x34>
        return -1;
   42251:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42256:	e9 fd 01 00 00       	jmp    42458 <keyboard_readc+0x231>
   4225b:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42262:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42265:	89 c2                	mov    %eax,%edx
   42267:	ec                   	in     (%dx),%al
   42268:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   4226b:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   4226f:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42272:	0f b6 05 69 f1 00 00 	movzbl 0xf169(%rip),%eax        # 513e2 <last_escape.2>
   42279:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   4227c:	c6 05 5f f1 00 00 00 	movb   $0x0,0xf15f(%rip)        # 513e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42283:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42287:	75 11                	jne    4229a <keyboard_readc+0x73>
        last_escape = 0x80;
   42289:	c6 05 52 f1 00 00 80 	movb   $0x80,0xf152(%rip)        # 513e2 <last_escape.2>
        return 0;
   42290:	b8 00 00 00 00       	mov    $0x0,%eax
   42295:	e9 be 01 00 00       	jmp    42458 <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4229a:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4229e:	84 c0                	test   %al,%al
   422a0:	79 64                	jns    42306 <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   422a2:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   422a6:	83 e0 7f             	and    $0x7f,%eax
   422a9:	89 c2                	mov    %eax,%edx
   422ab:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   422af:	09 d0                	or     %edx,%eax
   422b1:	48 98                	cltq   
   422b3:	48 8d 15 86 32 00 00 	lea    0x3286(%rip),%rdx        # 45540 <keymap>
   422ba:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   422be:	0f b6 c0             	movzbl %al,%eax
   422c1:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   422c4:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   422cb:	7e 2f                	jle    422fc <keyboard_readc+0xd5>
   422cd:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   422d4:	7f 26                	jg     422fc <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   422d6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422d9:	2d fa 00 00 00       	sub    $0xfa,%eax
   422de:	ba 01 00 00 00       	mov    $0x1,%edx
   422e3:	89 c1                	mov    %eax,%ecx
   422e5:	d3 e2                	shl    %cl,%edx
   422e7:	89 d0                	mov    %edx,%eax
   422e9:	f7 d0                	not    %eax
   422eb:	89 c2                	mov    %eax,%edx
   422ed:	0f b6 05 ef f0 00 00 	movzbl 0xf0ef(%rip),%eax        # 513e3 <modifiers.1>
   422f4:	21 d0                	and    %edx,%eax
   422f6:	88 05 e7 f0 00 00    	mov    %al,0xf0e7(%rip)        # 513e3 <modifiers.1>
        }
        return 0;
   422fc:	b8 00 00 00 00       	mov    $0x0,%eax
   42301:	e9 52 01 00 00       	jmp    42458 <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   42306:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4230a:	0a 45 fa             	or     -0x6(%rbp),%al
   4230d:	0f b6 c0             	movzbl %al,%eax
   42310:	48 98                	cltq   
   42312:	48 8d 15 27 32 00 00 	lea    0x3227(%rip),%rdx        # 45540 <keymap>
   42319:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   4231d:	0f b6 c0             	movzbl %al,%eax
   42320:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42323:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42327:	7e 57                	jle    42380 <keyboard_readc+0x159>
   42329:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   4232d:	7f 51                	jg     42380 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   4232f:	0f b6 05 ad f0 00 00 	movzbl 0xf0ad(%rip),%eax        # 513e3 <modifiers.1>
   42336:	0f b6 c0             	movzbl %al,%eax
   42339:	83 e0 02             	and    $0x2,%eax
   4233c:	85 c0                	test   %eax,%eax
   4233e:	74 09                	je     42349 <keyboard_readc+0x122>
            ch -= 0x60;
   42340:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42344:	e9 0b 01 00 00       	jmp    42454 <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42349:	0f b6 05 93 f0 00 00 	movzbl 0xf093(%rip),%eax        # 513e3 <modifiers.1>
   42350:	0f b6 c0             	movzbl %al,%eax
   42353:	83 e0 01             	and    $0x1,%eax
   42356:	85 c0                	test   %eax,%eax
   42358:	0f 94 c2             	sete   %dl
   4235b:	0f b6 05 81 f0 00 00 	movzbl 0xf081(%rip),%eax        # 513e3 <modifiers.1>
   42362:	0f b6 c0             	movzbl %al,%eax
   42365:	83 e0 08             	and    $0x8,%eax
   42368:	85 c0                	test   %eax,%eax
   4236a:	0f 94 c0             	sete   %al
   4236d:	31 d0                	xor    %edx,%eax
   4236f:	84 c0                	test   %al,%al
   42371:	0f 84 dd 00 00 00    	je     42454 <keyboard_readc+0x22d>
            ch -= 0x20;
   42377:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4237b:	e9 d4 00 00 00       	jmp    42454 <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42380:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42387:	7e 30                	jle    423b9 <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42389:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4238c:	2d fa 00 00 00       	sub    $0xfa,%eax
   42391:	ba 01 00 00 00       	mov    $0x1,%edx
   42396:	89 c1                	mov    %eax,%ecx
   42398:	d3 e2                	shl    %cl,%edx
   4239a:	89 d0                	mov    %edx,%eax
   4239c:	89 c2                	mov    %eax,%edx
   4239e:	0f b6 05 3e f0 00 00 	movzbl 0xf03e(%rip),%eax        # 513e3 <modifiers.1>
   423a5:	31 d0                	xor    %edx,%eax
   423a7:	88 05 36 f0 00 00    	mov    %al,0xf036(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   423ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   423b4:	e9 9c 00 00 00       	jmp    42455 <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   423b9:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   423c0:	7e 2d                	jle    423ef <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   423c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423c5:	2d fa 00 00 00       	sub    $0xfa,%eax
   423ca:	ba 01 00 00 00       	mov    $0x1,%edx
   423cf:	89 c1                	mov    %eax,%ecx
   423d1:	d3 e2                	shl    %cl,%edx
   423d3:	89 d0                	mov    %edx,%eax
   423d5:	89 c2                	mov    %eax,%edx
   423d7:	0f b6 05 05 f0 00 00 	movzbl 0xf005(%rip),%eax        # 513e3 <modifiers.1>
   423de:	09 d0                	or     %edx,%eax
   423e0:	88 05 fd ef 00 00    	mov    %al,0xeffd(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   423e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   423ed:	eb 66                	jmp    42455 <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   423ef:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   423f3:	7e 3f                	jle    42434 <keyboard_readc+0x20d>
   423f5:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   423fc:	7f 36                	jg     42434 <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   423fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42401:	8d 50 80             	lea    -0x80(%rax),%edx
   42404:	0f b6 05 d8 ef 00 00 	movzbl 0xefd8(%rip),%eax        # 513e3 <modifiers.1>
   4240b:	0f b6 c0             	movzbl %al,%eax
   4240e:	83 e0 03             	and    $0x3,%eax
   42411:	48 63 c8             	movslq %eax,%rcx
   42414:	48 63 c2             	movslq %edx,%rax
   42417:	48 c1 e0 02          	shl    $0x2,%rax
   4241b:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   4241f:	48 8d 05 1a 32 00 00 	lea    0x321a(%rip),%rax        # 45640 <complex_keymap>
   42426:	48 01 d0             	add    %rdx,%rax
   42429:	0f b6 00             	movzbl (%rax),%eax
   4242c:	0f b6 c0             	movzbl %al,%eax
   4242f:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42432:	eb 21                	jmp    42455 <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42434:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42438:	7f 1b                	jg     42455 <keyboard_readc+0x22e>
   4243a:	0f b6 05 a2 ef 00 00 	movzbl 0xefa2(%rip),%eax        # 513e3 <modifiers.1>
   42441:	0f b6 c0             	movzbl %al,%eax
   42444:	83 e0 02             	and    $0x2,%eax
   42447:	85 c0                	test   %eax,%eax
   42449:	74 0a                	je     42455 <keyboard_readc+0x22e>
        ch = 0;
   4244b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42452:	eb 01                	jmp    42455 <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   42454:	90                   	nop
    }

    return ch;
   42455:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42458:	c9                   	leave  
   42459:	c3                   	ret    

000000000004245a <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   4245a:	f3 0f 1e fa          	endbr64 
   4245e:	55                   	push   %rbp
   4245f:	48 89 e5             	mov    %rsp,%rbp
   42462:	48 83 ec 20          	sub    $0x20,%rsp
   42466:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4246d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42470:	89 c2                	mov    %eax,%edx
   42472:	ec                   	in     (%dx),%al
   42473:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42476:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   4247d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42480:	89 c2                	mov    %eax,%edx
   42482:	ec                   	in     (%dx),%al
   42483:	88 45 eb             	mov    %al,-0x15(%rbp)
   42486:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   4248d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42490:	89 c2                	mov    %eax,%edx
   42492:	ec                   	in     (%dx),%al
   42493:	88 45 f3             	mov    %al,-0xd(%rbp)
   42496:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   4249d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   424a0:	89 c2                	mov    %eax,%edx
   424a2:	ec                   	in     (%dx),%al
   424a3:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   424a6:	90                   	nop
   424a7:	c9                   	leave  
   424a8:	c3                   	ret    

00000000000424a9 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   424a9:	f3 0f 1e fa          	endbr64 
   424ad:	55                   	push   %rbp
   424ae:	48 89 e5             	mov    %rsp,%rbp
   424b1:	48 83 ec 40          	sub    $0x40,%rsp
   424b5:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   424b9:	89 f0                	mov    %esi,%eax
   424bb:	89 55 c0             	mov    %edx,-0x40(%rbp)
   424be:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   424c1:	8b 05 1d ef 00 00    	mov    0xef1d(%rip),%eax        # 513e4 <initialized.0>
   424c7:	85 c0                	test   %eax,%eax
   424c9:	75 1e                	jne    424e9 <parallel_port_putc+0x40>
   424cb:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   424d2:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424d6:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   424da:	8b 55 f8             	mov    -0x8(%rbp),%edx
   424dd:	ee                   	out    %al,(%dx)
}
   424de:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   424df:	c7 05 fb ee 00 00 01 	movl   $0x1,0xeefb(%rip)        # 513e4 <initialized.0>
   424e6:	00 00 00 
    }

    for (int i = 0;
   424e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   424f0:	eb 09                	jmp    424fb <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   424f2:	e8 63 ff ff ff       	call   4245a <delay>
         ++i) {
   424f7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   424fb:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42502:	7f 18                	jg     4251c <parallel_port_putc+0x73>
   42504:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4250b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4250e:	89 c2                	mov    %eax,%edx
   42510:	ec                   	in     (%dx),%al
   42511:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42514:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42518:	84 c0                	test   %al,%al
   4251a:	79 d6                	jns    424f2 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   4251c:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42520:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42527:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4252a:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   4252e:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42531:	ee                   	out    %al,(%dx)
}
   42532:	90                   	nop
   42533:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   4253a:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4253e:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42542:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42545:	ee                   	out    %al,(%dx)
}
   42546:	90                   	nop
   42547:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   4254e:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42552:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42556:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42559:	ee                   	out    %al,(%dx)
}
   4255a:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   4255b:	90                   	nop
   4255c:	c9                   	leave  
   4255d:	c3                   	ret    

000000000004255e <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   4255e:	f3 0f 1e fa          	endbr64 
   42562:	55                   	push   %rbp
   42563:	48 89 e5             	mov    %rsp,%rbp
   42566:	48 83 ec 20          	sub    $0x20,%rsp
   4256a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4256e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42572:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 424a9 <parallel_port_putc>
   42579:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   4257d:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42581:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42585:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42589:	be 00 00 00 00       	mov    $0x0,%esi
   4258e:	48 89 c7             	mov    %rax,%rdi
   42591:	e8 aa 1e 00 00       	call   44440 <printer_vprintf>
}
   42596:	90                   	nop
   42597:	c9                   	leave  
   42598:	c3                   	ret    

0000000000042599 <log_printf>:

void log_printf(const char* format, ...) {
   42599:	f3 0f 1e fa          	endbr64 
   4259d:	55                   	push   %rbp
   4259e:	48 89 e5             	mov    %rsp,%rbp
   425a1:	48 83 ec 60          	sub    $0x60,%rsp
   425a5:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   425a9:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   425ad:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   425b1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   425b5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   425b9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   425bd:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   425c4:	48 8d 45 10          	lea    0x10(%rbp),%rax
   425c8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   425cc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   425d0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   425d4:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   425d8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   425dc:	48 89 d6             	mov    %rdx,%rsi
   425df:	48 89 c7             	mov    %rax,%rdi
   425e2:	e8 77 ff ff ff       	call   4255e <log_vprintf>
    va_end(val);
}
   425e7:	90                   	nop
   425e8:	c9                   	leave  
   425e9:	c3                   	ret    

00000000000425ea <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   425ea:	f3 0f 1e fa          	endbr64 
   425ee:	55                   	push   %rbp
   425ef:	48 89 e5             	mov    %rsp,%rbp
   425f2:	48 83 ec 40          	sub    $0x40,%rsp
   425f6:	89 7d dc             	mov    %edi,-0x24(%rbp)
   425f9:	89 75 d8             	mov    %esi,-0x28(%rbp)
   425fc:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42600:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42604:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42608:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4260c:	48 8b 0a             	mov    (%rdx),%rcx
   4260f:	48 89 08             	mov    %rcx,(%rax)
   42612:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42616:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4261a:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   4261e:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42622:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42626:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4262a:	48 89 d6             	mov    %rdx,%rsi
   4262d:	48 89 c7             	mov    %rax,%rdi
   42630:	e8 29 ff ff ff       	call   4255e <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42635:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42639:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4263d:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42640:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42643:	89 c7                	mov    %eax,%edi
   42645:	e8 f3 28 00 00       	call   44f3d <console_vprintf>
}
   4264a:	c9                   	leave  
   4264b:	c3                   	ret    

000000000004264c <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   4264c:	f3 0f 1e fa          	endbr64 
   42650:	55                   	push   %rbp
   42651:	48 89 e5             	mov    %rsp,%rbp
   42654:	48 83 ec 60          	sub    $0x60,%rsp
   42658:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4265b:	89 75 a8             	mov    %esi,-0x58(%rbp)
   4265e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42662:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42666:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4266a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4266e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42675:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42679:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4267d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42681:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42685:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42689:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4268d:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42690:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42693:	89 c7                	mov    %eax,%edi
   42695:	e8 50 ff ff ff       	call   425ea <error_vprintf>
   4269a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4269d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   426a0:	c9                   	leave  
   426a1:	c3                   	ret    

00000000000426a2 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   426a2:	f3 0f 1e fa          	endbr64 
   426a6:	55                   	push   %rbp
   426a7:	48 89 e5             	mov    %rsp,%rbp
   426aa:	53                   	push   %rbx
   426ab:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   426af:	e8 73 fb ff ff       	call   42227 <keyboard_readc>
   426b4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   426b7:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   426bb:	74 1c                	je     426d9 <check_keyboard+0x37>
   426bd:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   426c1:	74 16                	je     426d9 <check_keyboard+0x37>
   426c3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   426c7:	74 10                	je     426d9 <check_keyboard+0x37>
   426c9:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   426cd:	74 0a                	je     426d9 <check_keyboard+0x37>
   426cf:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   426d3:	0f 85 02 01 00 00    	jne    427db <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   426d9:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   426e0:	00 
        memset(pt, 0, PAGESIZE * 3);
   426e1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426e5:	ba 00 30 00 00       	mov    $0x3000,%edx
   426ea:	be 00 00 00 00       	mov    $0x0,%esi
   426ef:	48 89 c7             	mov    %rax,%rdi
   426f2:	e8 83 1a 00 00       	call   4417a <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   426f7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426fb:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42702:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42706:	48 05 00 10 00 00    	add    $0x1000,%rax
   4270c:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42713:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42717:	48 05 00 20 00 00    	add    $0x2000,%rax
   4271d:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42724:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42728:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4272c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42730:	0f 22 d8             	mov    %rax,%cr3
}
   42733:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42734:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   4273b:	48 8d 05 56 2f 00 00 	lea    0x2f56(%rip),%rax        # 45698 <complex_keymap+0x58>
   42742:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   42746:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4274a:	75 0d                	jne    42759 <check_keyboard+0xb7>
            argument = "allocator";
   4274c:	48 8d 05 4c 2f 00 00 	lea    0x2f4c(%rip),%rax        # 4569f <complex_keymap+0x5f>
   42753:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42757:	eb 37                	jmp    42790 <check_keyboard+0xee>
        } else if (c == 'c') {
   42759:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   4275d:	75 0d                	jne    4276c <check_keyboard+0xca>
            argument = "alloctests";
   4275f:	48 8d 05 43 2f 00 00 	lea    0x2f43(%rip),%rax        # 456a9 <complex_keymap+0x69>
   42766:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4276a:	eb 24                	jmp    42790 <check_keyboard+0xee>
        } else if(c == 't'){
   4276c:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42770:	75 0d                	jne    4277f <check_keyboard+0xdd>
            argument = "test";
   42772:	48 8d 05 3b 2f 00 00 	lea    0x2f3b(%rip),%rax        # 456b4 <complex_keymap+0x74>
   42779:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4277d:	eb 11                	jmp    42790 <check_keyboard+0xee>
        }
        else if(c == '2'){
   4277f:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42783:	75 0b                	jne    42790 <check_keyboard+0xee>
            argument = "test2";
   42785:	48 8d 05 2d 2f 00 00 	lea    0x2f2d(%rip),%rax        # 456b9 <complex_keymap+0x79>
   4278c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42790:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42794:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42798:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4279d:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   427a1:	76 1e                	jbe    427c1 <check_keyboard+0x11f>
   427a3:	48 8d 05 15 2f 00 00 	lea    0x2f15(%rip),%rax        # 456bf <complex_keymap+0x7f>
   427aa:	48 89 c2             	mov    %rax,%rdx
   427ad:	be 5c 02 00 00       	mov    $0x25c,%esi
   427b2:	48 8d 05 22 2f 00 00 	lea    0x2f22(%rip),%rax        # 456db <complex_keymap+0x9b>
   427b9:	48 89 c7             	mov    %rax,%rdi
   427bc:	e8 33 01 00 00       	call   428f4 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   427c1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   427c5:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   427c8:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   427cc:	48 89 c3             	mov    %rax,%rbx
   427cf:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   427d4:	e9 27 d8 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   427d9:	eb 11                	jmp    427ec <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   427db:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   427df:	74 06                	je     427e7 <check_keyboard+0x145>
   427e1:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   427e5:	75 05                	jne    427ec <check_keyboard+0x14a>
        poweroff();
   427e7:	e8 3c f8 ff ff       	call   42028 <poweroff>
    }
    return c;
   427ec:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   427ef:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   427f3:	c9                   	leave  
   427f4:	c3                   	ret    

00000000000427f5 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   427f5:	f3 0f 1e fa          	endbr64 
   427f9:	55                   	push   %rbp
   427fa:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   427fd:	e8 a0 fe ff ff       	call   426a2 <check_keyboard>
   42802:	eb f9                	jmp    427fd <fail+0x8>

0000000000042804 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   42804:	f3 0f 1e fa          	endbr64 
   42808:	55                   	push   %rbp
   42809:	48 89 e5             	mov    %rsp,%rbp
   4280c:	48 83 ec 60          	sub    $0x60,%rsp
   42810:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42814:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42818:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4281c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42820:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42824:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42828:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4282f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42833:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42837:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4283b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4283f:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42844:	0f 84 87 00 00 00    	je     428d1 <kernel_panic+0xcd>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   4284a:	48 8d 05 9e 2e 00 00 	lea    0x2e9e(%rip),%rax        # 456ef <complex_keymap+0xaf>
   42851:	48 89 c2             	mov    %rax,%rdx
   42854:	be 00 c0 00 00       	mov    $0xc000,%esi
   42859:	bf 30 07 00 00       	mov    $0x730,%edi
   4285e:	b8 00 00 00 00       	mov    $0x0,%eax
   42863:	e8 e4 fd ff ff       	call   4264c <error_printf>
   42868:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   4286b:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4286f:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42873:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42876:	be 00 c0 00 00       	mov    $0xc000,%esi
   4287b:	89 c7                	mov    %eax,%edi
   4287d:	e8 68 fd ff ff       	call   425ea <error_vprintf>
   42882:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42885:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42888:	48 63 c1             	movslq %ecx,%rax
   4288b:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42892:	48 c1 e8 20          	shr    $0x20,%rax
   42896:	c1 f8 05             	sar    $0x5,%eax
   42899:	89 ce                	mov    %ecx,%esi
   4289b:	c1 fe 1f             	sar    $0x1f,%esi
   4289e:	29 f0                	sub    %esi,%eax
   428a0:	89 c2                	mov    %eax,%edx
   428a2:	89 d0                	mov    %edx,%eax
   428a4:	c1 e0 02             	shl    $0x2,%eax
   428a7:	01 d0                	add    %edx,%eax
   428a9:	c1 e0 04             	shl    $0x4,%eax
   428ac:	29 c1                	sub    %eax,%ecx
   428ae:	89 ca                	mov    %ecx,%edx
   428b0:	85 d2                	test   %edx,%edx
   428b2:	74 3b                	je     428ef <kernel_panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   428b4:	8b 45 cc             	mov    -0x34(%rbp),%eax
   428b7:	48 8d 15 39 2e 00 00 	lea    0x2e39(%rip),%rdx        # 456f7 <complex_keymap+0xb7>
   428be:	be 00 c0 00 00       	mov    $0xc000,%esi
   428c3:	89 c7                	mov    %eax,%edi
   428c5:	b8 00 00 00 00       	mov    $0x0,%eax
   428ca:	e8 7d fd ff ff       	call   4264c <error_printf>
   428cf:	eb 1e                	jmp    428ef <kernel_panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   428d1:	48 8d 05 21 2e 00 00 	lea    0x2e21(%rip),%rax        # 456f9 <complex_keymap+0xb9>
   428d8:	48 89 c2             	mov    %rax,%rdx
   428db:	be 00 c0 00 00       	mov    $0xc000,%esi
   428e0:	bf 30 07 00 00       	mov    $0x730,%edi
   428e5:	b8 00 00 00 00       	mov    $0x0,%eax
   428ea:	e8 5d fd ff ff       	call   4264c <error_printf>
    }

    va_end(val);
    fail();
   428ef:	e8 01 ff ff ff       	call   427f5 <fail>

00000000000428f4 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   428f4:	f3 0f 1e fa          	endbr64 
   428f8:	55                   	push   %rbp
   428f9:	48 89 e5             	mov    %rsp,%rbp
   428fc:	48 83 ec 20          	sub    $0x20,%rsp
   42900:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42904:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42907:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   4290b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4290f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42912:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42916:	48 89 c6             	mov    %rax,%rsi
   42919:	48 8d 05 df 2d 00 00 	lea    0x2ddf(%rip),%rax        # 456ff <complex_keymap+0xbf>
   42920:	48 89 c7             	mov    %rax,%rdi
   42923:	b8 00 00 00 00       	mov    $0x0,%eax
   42928:	e8 d7 fe ff ff       	call   42804 <kernel_panic>

000000000004292d <default_exception>:
}

void default_exception(proc* p){
   4292d:	f3 0f 1e fa          	endbr64 
   42931:	55                   	push   %rbp
   42932:	48 89 e5             	mov    %rsp,%rbp
   42935:	48 83 ec 20          	sub    $0x20,%rsp
   42939:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   4293d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42941:	48 83 c0 18          	add    $0x18,%rax
   42945:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   42949:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4294d:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42954:	48 89 c6             	mov    %rax,%rsi
   42957:	48 8d 05 bf 2d 00 00 	lea    0x2dbf(%rip),%rax        # 4571d <complex_keymap+0xdd>
   4295e:	48 89 c7             	mov    %rax,%rdi
   42961:	b8 00 00 00 00       	mov    $0x0,%eax
   42966:	e8 99 fe ff ff       	call   42804 <kernel_panic>

000000000004296b <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4296b:	55                   	push   %rbp
   4296c:	48 89 e5             	mov    %rsp,%rbp
   4296f:	48 83 ec 10          	sub    $0x10,%rsp
   42973:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42977:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   4297a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4297e:	78 06                	js     42986 <pageindex+0x1b>
   42980:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42984:	7e 1e                	jle    429a4 <pageindex+0x39>
   42986:	48 8d 05 ab 2d 00 00 	lea    0x2dab(%rip),%rax        # 45738 <complex_keymap+0xf8>
   4298d:	48 89 c2             	mov    %rax,%rdx
   42990:	be 1e 00 00 00       	mov    $0x1e,%esi
   42995:	48 8d 05 b5 2d 00 00 	lea    0x2db5(%rip),%rax        # 45751 <complex_keymap+0x111>
   4299c:	48 89 c7             	mov    %rax,%rdi
   4299f:	e8 50 ff ff ff       	call   428f4 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   429a4:	b8 03 00 00 00       	mov    $0x3,%eax
   429a9:	2b 45 f4             	sub    -0xc(%rbp),%eax
   429ac:	89 c2                	mov    %eax,%edx
   429ae:	89 d0                	mov    %edx,%eax
   429b0:	c1 e0 03             	shl    $0x3,%eax
   429b3:	01 d0                	add    %edx,%eax
   429b5:	83 c0 0c             	add    $0xc,%eax
   429b8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   429bc:	89 c1                	mov    %eax,%ecx
   429be:	48 d3 ea             	shr    %cl,%rdx
   429c1:	48 89 d0             	mov    %rdx,%rax
   429c4:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   429c9:	c9                   	leave  
   429ca:	c3                   	ret    

00000000000429cb <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   429cb:	f3 0f 1e fa          	endbr64 
   429cf:	55                   	push   %rbp
   429d0:	48 89 e5             	mov    %rsp,%rbp
   429d3:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   429d7:	48 8d 05 22 06 01 00 	lea    0x10622(%rip),%rax        # 53000 <kernel_pagetables>
   429de:	48 89 05 1b f6 00 00 	mov    %rax,0xf61b(%rip)        # 52000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   429e5:	ba 00 50 00 00       	mov    $0x5000,%edx
   429ea:	be 00 00 00 00       	mov    $0x0,%esi
   429ef:	48 8d 05 0a 06 01 00 	lea    0x1060a(%rip),%rax        # 53000 <kernel_pagetables>
   429f6:	48 89 c7             	mov    %rax,%rdi
   429f9:	e8 7c 17 00 00       	call   4417a <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   429fe:	48 8d 05 fb 15 01 00 	lea    0x115fb(%rip),%rax        # 54000 <kernel_pagetables+0x1000>
   42a05:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42a09:	48 89 05 f0 05 01 00 	mov    %rax,0x105f0(%rip)        # 53000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42a10:	48 8d 05 e9 25 01 00 	lea    0x125e9(%rip),%rax        # 55000 <kernel_pagetables+0x2000>
   42a17:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42a1b:	48 89 05 de 15 01 00 	mov    %rax,0x115de(%rip)        # 54000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42a22:	48 8d 05 d7 35 01 00 	lea    0x135d7(%rip),%rax        # 56000 <kernel_pagetables+0x3000>
   42a29:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42a2d:	48 89 05 cc 25 01 00 	mov    %rax,0x125cc(%rip)        # 55000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42a34:	48 8d 05 c5 45 01 00 	lea    0x145c5(%rip),%rax        # 57000 <kernel_pagetables+0x4000>
   42a3b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42a3f:	48 89 05 c2 25 01 00 	mov    %rax,0x125c2(%rip)        # 55008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42a46:	48 8b 05 b3 f5 00 00 	mov    0xf5b3(%rip),%rax        # 52000 <kernel_pagetable>
   42a4d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42a53:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42a58:	ba 00 00 00 00       	mov    $0x0,%edx
   42a5d:	be 00 00 00 00       	mov    $0x0,%esi
   42a62:	48 89 c7             	mov    %rax,%rdi
   42a65:	e8 0e 02 00 00       	call   42c78 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42a6a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42a71:	00 
   42a72:	eb 76                	jmp    42aea <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42a74:	48 8b 0d 85 f5 00 00 	mov    0xf585(%rip),%rcx        # 52000 <kernel_pagetable>
   42a7b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42a7f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42a83:	48 89 ce             	mov    %rcx,%rsi
   42a86:	48 89 c7             	mov    %rax,%rdi
   42a89:	e8 36 06 00 00       	call   430c4 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   42a8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a92:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42a96:	74 1e                	je     42ab6 <virtual_memory_init+0xeb>
   42a98:	48 8d 05 c6 2c 00 00 	lea    0x2cc6(%rip),%rax        # 45765 <complex_keymap+0x125>
   42a9f:	48 89 c2             	mov    %rax,%rdx
   42aa2:	be 2d 00 00 00       	mov    $0x2d,%esi
   42aa7:	48 8d 05 c7 2c 00 00 	lea    0x2cc7(%rip),%rax        # 45775 <complex_keymap+0x135>
   42aae:	48 89 c7             	mov    %rax,%rdi
   42ab1:	e8 3e fe ff ff       	call   428f4 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42ab6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42ab9:	48 98                	cltq   
   42abb:	83 e0 03             	and    $0x3,%eax
   42abe:	48 83 f8 03          	cmp    $0x3,%rax
   42ac2:	74 1e                	je     42ae2 <virtual_memory_init+0x117>
   42ac4:	48 8d 05 bd 2c 00 00 	lea    0x2cbd(%rip),%rax        # 45788 <complex_keymap+0x148>
   42acb:	48 89 c2             	mov    %rax,%rdx
   42ace:	be 2e 00 00 00       	mov    $0x2e,%esi
   42ad3:	48 8d 05 9b 2c 00 00 	lea    0x2c9b(%rip),%rax        # 45775 <complex_keymap+0x135>
   42ada:	48 89 c7             	mov    %rax,%rdi
   42add:	e8 12 fe ff ff       	call   428f4 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42ae2:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42ae9:	00 
   42aea:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42af1:	00 
   42af2:	76 80                	jbe    42a74 <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42af4:	48 8b 05 05 f5 00 00 	mov    0xf505(%rip),%rax        # 52000 <kernel_pagetable>
   42afb:	48 89 c7             	mov    %rax,%rdi
   42afe:	e8 03 00 00 00       	call   42b06 <set_pagetable>
}
   42b03:	90                   	nop
   42b04:	c9                   	leave  
   42b05:	c3                   	ret    

0000000000042b06 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42b06:	f3 0f 1e fa          	endbr64 
   42b0a:	55                   	push   %rbp
   42b0b:	48 89 e5             	mov    %rsp,%rbp
   42b0e:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42b12:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42b16:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42b1a:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b1f:	48 85 c0             	test   %rax,%rax
   42b22:	74 1e                	je     42b42 <set_pagetable+0x3c>
   42b24:	48 8d 05 8a 2c 00 00 	lea    0x2c8a(%rip),%rax        # 457b5 <complex_keymap+0x175>
   42b2b:	48 89 c2             	mov    %rax,%rdx
   42b2e:	be 3d 00 00 00       	mov    $0x3d,%esi
   42b33:	48 8d 05 3b 2c 00 00 	lea    0x2c3b(%rip),%rax        # 45775 <complex_keymap+0x135>
   42b3a:	48 89 c7             	mov    %rax,%rdi
   42b3d:	e8 b2 fd ff ff       	call   428f4 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42b42:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   42b49:	48 89 c2             	mov    %rax,%rdx
   42b4c:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42b50:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42b54:	48 89 ce             	mov    %rcx,%rsi
   42b57:	48 89 c7             	mov    %rax,%rdi
   42b5a:	e8 65 05 00 00       	call   430c4 <virtual_memory_lookup>
   42b5f:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42b63:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   42b6a:	48 39 d0             	cmp    %rdx,%rax
   42b6d:	74 1e                	je     42b8d <set_pagetable+0x87>
   42b6f:	48 8d 05 5a 2c 00 00 	lea    0x2c5a(%rip),%rax        # 457d0 <complex_keymap+0x190>
   42b76:	48 89 c2             	mov    %rax,%rdx
   42b79:	be 3f 00 00 00       	mov    $0x3f,%esi
   42b7e:	48 8d 05 f0 2b 00 00 	lea    0x2bf0(%rip),%rax        # 45775 <complex_keymap+0x135>
   42b85:	48 89 c7             	mov    %rax,%rdi
   42b88:	e8 67 fd ff ff       	call   428f4 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42b8d:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42b91:	48 8b 0d 68 f4 00 00 	mov    0xf468(%rip),%rcx        # 52000 <kernel_pagetable>
   42b98:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42b9c:	48 89 ce             	mov    %rcx,%rsi
   42b9f:	48 89 c7             	mov    %rax,%rdi
   42ba2:	e8 1d 05 00 00       	call   430c4 <virtual_memory_lookup>
   42ba7:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42bab:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42baf:	48 39 c2             	cmp    %rax,%rdx
   42bb2:	74 1e                	je     42bd2 <set_pagetable+0xcc>
   42bb4:	48 8d 05 7d 2c 00 00 	lea    0x2c7d(%rip),%rax        # 45838 <complex_keymap+0x1f8>
   42bbb:	48 89 c2             	mov    %rax,%rdx
   42bbe:	be 41 00 00 00       	mov    $0x41,%esi
   42bc3:	48 8d 05 ab 2b 00 00 	lea    0x2bab(%rip),%rax        # 45775 <complex_keymap+0x135>
   42bca:	48 89 c7             	mov    %rax,%rdi
   42bcd:	e8 22 fd ff ff       	call   428f4 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42bd2:	48 8b 05 27 f4 00 00 	mov    0xf427(%rip),%rax        # 52000 <kernel_pagetable>
   42bd9:	48 89 c2             	mov    %rax,%rdx
   42bdc:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42be0:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42be4:	48 89 ce             	mov    %rcx,%rsi
   42be7:	48 89 c7             	mov    %rax,%rdi
   42bea:	e8 d5 04 00 00       	call   430c4 <virtual_memory_lookup>
   42bef:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42bf3:	48 8b 15 06 f4 00 00 	mov    0xf406(%rip),%rdx        # 52000 <kernel_pagetable>
   42bfa:	48 39 d0             	cmp    %rdx,%rax
   42bfd:	74 1e                	je     42c1d <set_pagetable+0x117>
   42bff:	48 8d 05 92 2c 00 00 	lea    0x2c92(%rip),%rax        # 45898 <complex_keymap+0x258>
   42c06:	48 89 c2             	mov    %rax,%rdx
   42c09:	be 43 00 00 00       	mov    $0x43,%esi
   42c0e:	48 8d 05 60 2b 00 00 	lea    0x2b60(%rip),%rax        # 45775 <complex_keymap+0x135>
   42c15:	48 89 c7             	mov    %rax,%rdi
   42c18:	e8 d7 fc ff ff       	call   428f4 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42c1d:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 42c78 <virtual_memory_map>
   42c24:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42c28:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42c2c:	48 89 ce             	mov    %rcx,%rsi
   42c2f:	48 89 c7             	mov    %rax,%rdi
   42c32:	e8 8d 04 00 00       	call   430c4 <virtual_memory_lookup>
   42c37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c3b:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 42c78 <virtual_memory_map>
   42c42:	48 39 d0             	cmp    %rdx,%rax
   42c45:	74 1e                	je     42c65 <set_pagetable+0x15f>
   42c47:	48 8d 05 b2 2c 00 00 	lea    0x2cb2(%rip),%rax        # 45900 <complex_keymap+0x2c0>
   42c4e:	48 89 c2             	mov    %rax,%rdx
   42c51:	be 45 00 00 00       	mov    $0x45,%esi
   42c56:	48 8d 05 18 2b 00 00 	lea    0x2b18(%rip),%rax        # 45775 <complex_keymap+0x135>
   42c5d:	48 89 c7             	mov    %rax,%rdi
   42c60:	e8 8f fc ff ff       	call   428f4 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42c65:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42c69:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42c6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c71:	0f 22 d8             	mov    %rax,%cr3
}
   42c74:	90                   	nop
}
   42c75:	90                   	nop
   42c76:	c9                   	leave  
   42c77:	c3                   	ret    

0000000000042c78 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42c78:	f3 0f 1e fa          	endbr64 
   42c7c:	55                   	push   %rbp
   42c7d:	48 89 e5             	mov    %rsp,%rbp
   42c80:	53                   	push   %rbx
   42c81:	48 83 ec 58          	sub    $0x58,%rsp
   42c85:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42c89:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42c8d:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42c91:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42c95:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42c99:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c9d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ca2:	48 85 c0             	test   %rax,%rax
   42ca5:	74 1e                	je     42cc5 <virtual_memory_map+0x4d>
   42ca7:	48 8d 05 b8 2c 00 00 	lea    0x2cb8(%rip),%rax        # 45966 <complex_keymap+0x326>
   42cae:	48 89 c2             	mov    %rax,%rdx
   42cb1:	be 66 00 00 00       	mov    $0x66,%esi
   42cb6:	48 8d 05 b8 2a 00 00 	lea    0x2ab8(%rip),%rax        # 45775 <complex_keymap+0x135>
   42cbd:	48 89 c7             	mov    %rax,%rdi
   42cc0:	e8 2f fc ff ff       	call   428f4 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42cc5:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42cc9:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cce:	48 85 c0             	test   %rax,%rax
   42cd1:	74 1e                	je     42cf1 <virtual_memory_map+0x79>
   42cd3:	48 8d 05 9f 2c 00 00 	lea    0x2c9f(%rip),%rax        # 45979 <complex_keymap+0x339>
   42cda:	48 89 c2             	mov    %rax,%rdx
   42cdd:	be 67 00 00 00       	mov    $0x67,%esi
   42ce2:	48 8d 05 8c 2a 00 00 	lea    0x2a8c(%rip),%rax        # 45775 <complex_keymap+0x135>
   42ce9:	48 89 c7             	mov    %rax,%rdi
   42cec:	e8 03 fc ff ff       	call   428f4 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42cf1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42cf5:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42cf9:	48 01 d0             	add    %rdx,%rax
   42cfc:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   42d00:	76 2e                	jbe    42d30 <virtual_memory_map+0xb8>
   42d02:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42d06:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42d0a:	48 01 d0             	add    %rdx,%rax
   42d0d:	48 85 c0             	test   %rax,%rax
   42d10:	74 1e                	je     42d30 <virtual_memory_map+0xb8>
   42d12:	48 8d 05 73 2c 00 00 	lea    0x2c73(%rip),%rax        # 4598c <complex_keymap+0x34c>
   42d19:	48 89 c2             	mov    %rax,%rdx
   42d1c:	be 68 00 00 00       	mov    $0x68,%esi
   42d21:	48 8d 05 4d 2a 00 00 	lea    0x2a4d(%rip),%rax        # 45775 <complex_keymap+0x135>
   42d28:	48 89 c7             	mov    %rax,%rdi
   42d2b:	e8 c4 fb ff ff       	call   428f4 <assert_fail>
    if (perm & PTE_P) {
   42d30:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42d33:	48 98                	cltq   
   42d35:	83 e0 01             	and    $0x1,%eax
   42d38:	48 85 c0             	test   %rax,%rax
   42d3b:	0f 84 8c 00 00 00    	je     42dcd <virtual_memory_map+0x155>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42d41:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42d45:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d4a:	48 85 c0             	test   %rax,%rax
   42d4d:	74 1e                	je     42d6d <virtual_memory_map+0xf5>
   42d4f:	48 8d 05 54 2c 00 00 	lea    0x2c54(%rip),%rax        # 459aa <complex_keymap+0x36a>
   42d56:	48 89 c2             	mov    %rax,%rdx
   42d59:	be 6a 00 00 00       	mov    $0x6a,%esi
   42d5e:	48 8d 05 10 2a 00 00 	lea    0x2a10(%rip),%rax        # 45775 <complex_keymap+0x135>
   42d65:	48 89 c7             	mov    %rax,%rdi
   42d68:	e8 87 fb ff ff       	call   428f4 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42d6d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42d71:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42d75:	48 01 d0             	add    %rdx,%rax
   42d78:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   42d7c:	76 1e                	jbe    42d9c <virtual_memory_map+0x124>
   42d7e:	48 8d 05 38 2c 00 00 	lea    0x2c38(%rip),%rax        # 459bd <complex_keymap+0x37d>
   42d85:	48 89 c2             	mov    %rax,%rdx
   42d88:	be 6b 00 00 00       	mov    $0x6b,%esi
   42d8d:	48 8d 05 e1 29 00 00 	lea    0x29e1(%rip),%rax        # 45775 <complex_keymap+0x135>
   42d94:	48 89 c7             	mov    %rax,%rdi
   42d97:	e8 58 fb ff ff       	call   428f4 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42d9c:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42da0:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42da4:	48 01 d0             	add    %rdx,%rax
   42da7:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42dad:	76 1e                	jbe    42dcd <virtual_memory_map+0x155>
   42daf:	48 8d 05 15 2c 00 00 	lea    0x2c15(%rip),%rax        # 459cb <complex_keymap+0x38b>
   42db6:	48 89 c2             	mov    %rax,%rdx
   42db9:	be 6c 00 00 00       	mov    $0x6c,%esi
   42dbe:	48 8d 05 b0 29 00 00 	lea    0x29b0(%rip),%rax        # 45775 <complex_keymap+0x135>
   42dc5:	48 89 c7             	mov    %rax,%rdi
   42dc8:	e8 27 fb ff ff       	call   428f4 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42dcd:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42dd1:	78 09                	js     42ddc <virtual_memory_map+0x164>
   42dd3:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42dda:	7e 1e                	jle    42dfa <virtual_memory_map+0x182>
   42ddc:	48 8d 05 04 2c 00 00 	lea    0x2c04(%rip),%rax        # 459e7 <complex_keymap+0x3a7>
   42de3:	48 89 c2             	mov    %rax,%rdx
   42de6:	be 6e 00 00 00       	mov    $0x6e,%esi
   42deb:	48 8d 05 83 29 00 00 	lea    0x2983(%rip),%rax        # 45775 <complex_keymap+0x135>
   42df2:	48 89 c7             	mov    %rax,%rdi
   42df5:	e8 fa fa ff ff       	call   428f4 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42dfa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42dfe:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e03:	48 85 c0             	test   %rax,%rax
   42e06:	74 1e                	je     42e26 <virtual_memory_map+0x1ae>
   42e08:	48 8d 05 f9 2b 00 00 	lea    0x2bf9(%rip),%rax        # 45a08 <complex_keymap+0x3c8>
   42e0f:	48 89 c2             	mov    %rax,%rdx
   42e12:	be 6f 00 00 00       	mov    $0x6f,%esi
   42e17:	48 8d 05 57 29 00 00 	lea    0x2957(%rip),%rax        # 45775 <complex_keymap+0x135>
   42e1e:	48 89 c7             	mov    %rax,%rdi
   42e21:	e8 ce fa ff ff       	call   428f4 <assert_fail>

    int last_index123 = -1;
   42e26:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   42e2d:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42e34:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42e35:	e9 e6 00 00 00       	jmp    42f20 <virtual_memory_map+0x2a8>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42e3a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e3e:	48 c1 e8 15          	shr    $0x15,%rax
   42e42:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42e45:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42e48:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42e4b:	74 20                	je     42e6d <virtual_memory_map+0x1f5>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42e4d:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42e50:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42e54:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e58:	48 89 ce             	mov    %rcx,%rsi
   42e5b:	48 89 c7             	mov    %rax,%rdi
   42e5e:	e8 d3 00 00 00       	call   42f36 <lookup_l4pagetable>
   42e63:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42e67:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42e6a:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42e6d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42e70:	48 98                	cltq   
   42e72:	83 e0 01             	and    $0x1,%eax
   42e75:	48 85 c0             	test   %rax,%rax
   42e78:	74 34                	je     42eae <virtual_memory_map+0x236>
   42e7a:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42e7f:	74 2d                	je     42eae <virtual_memory_map+0x236>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42e81:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42e84:	48 63 d8             	movslq %eax,%rbx
   42e87:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e8b:	be 03 00 00 00       	mov    $0x3,%esi
   42e90:	48 89 c7             	mov    %rax,%rdi
   42e93:	e8 d3 fa ff ff       	call   4296b <pageindex>
   42e98:	89 c2                	mov    %eax,%edx
   42e9a:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42e9e:	48 89 d9             	mov    %rbx,%rcx
   42ea1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ea5:	48 63 d2             	movslq %edx,%rdx
   42ea8:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42eac:	eb 5a                	jmp    42f08 <virtual_memory_map+0x290>
        } else if (l4pagetable) { // if page is NOT marked present
   42eae:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42eb3:	74 26                	je     42edb <virtual_memory_map+0x263>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42eb5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42eb9:	be 03 00 00 00       	mov    $0x3,%esi
   42ebe:	48 89 c7             	mov    %rax,%rdi
   42ec1:	e8 a5 fa ff ff       	call   4296b <pageindex>
   42ec6:	89 c2                	mov    %eax,%edx
   42ec8:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ecb:	48 63 c8             	movslq %eax,%rcx
   42ece:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ed2:	48 63 d2             	movslq %edx,%rdx
   42ed5:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42ed9:	eb 2d                	jmp    42f08 <virtual_memory_map+0x290>
        } else if (perm & PTE_P) {
   42edb:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ede:	48 98                	cltq   
   42ee0:	83 e0 01             	and    $0x1,%eax
   42ee3:	48 85 c0             	test   %rax,%rax
   42ee6:	74 20                	je     42f08 <virtual_memory_map+0x290>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42ee8:	be 84 00 00 00       	mov    $0x84,%esi
   42eed:	48 8d 05 3c 2b 00 00 	lea    0x2b3c(%rip),%rax        # 45a30 <complex_keymap+0x3f0>
   42ef4:	48 89 c7             	mov    %rax,%rdi
   42ef7:	b8 00 00 00 00       	mov    $0x0,%eax
   42efc:	e8 98 f6 ff ff       	call   42599 <log_printf>
            return -1;
   42f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f06:	eb 28                	jmp    42f30 <virtual_memory_map+0x2b8>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42f08:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42f0f:	00 
   42f10:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42f17:	00 
   42f18:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42f1f:	00 
   42f20:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42f25:	0f 85 0f ff ff ff    	jne    42e3a <virtual_memory_map+0x1c2>
        }
    }
    return 0;
   42f2b:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f30:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42f34:	c9                   	leave  
   42f35:	c3                   	ret    

0000000000042f36 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42f36:	f3 0f 1e fa          	endbr64 
   42f3a:	55                   	push   %rbp
   42f3b:	48 89 e5             	mov    %rsp,%rbp
   42f3e:	48 83 ec 40          	sub    $0x40,%rsp
   42f42:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f46:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42f4a:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42f4d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f51:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42f55:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42f5c:	e9 53 01 00 00       	jmp    430b4 <lookup_l4pagetable+0x17e>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42f61:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42f64:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42f68:	89 d6                	mov    %edx,%esi
   42f6a:	48 89 c7             	mov    %rax,%rdi
   42f6d:	e8 f9 f9 ff ff       	call   4296b <pageindex>
   42f72:	89 c2                	mov    %eax,%edx
   42f74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f78:	48 63 d2             	movslq %edx,%rdx
   42f7b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42f7f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42f83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f87:	83 e0 01             	and    $0x1,%eax
   42f8a:	48 85 c0             	test   %rax,%rax
   42f8d:	75 6d                	jne    42ffc <lookup_l4pagetable+0xc6>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42f8f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42f92:	8d 48 02             	lea    0x2(%rax),%ecx
   42f95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f99:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f9e:	48 89 c2             	mov    %rax,%rdx
   42fa1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fa5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42fab:	48 89 c6             	mov    %rax,%rsi
   42fae:	48 8d 05 c3 2a 00 00 	lea    0x2ac3(%rip),%rax        # 45a78 <complex_keymap+0x438>
   42fb5:	48 89 c7             	mov    %rax,%rdi
   42fb8:	b8 00 00 00 00       	mov    $0x0,%eax
   42fbd:	e8 d7 f5 ff ff       	call   42599 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42fc2:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42fc5:	48 98                	cltq   
   42fc7:	83 e0 01             	and    $0x1,%eax
   42fca:	48 85 c0             	test   %rax,%rax
   42fcd:	75 0a                	jne    42fd9 <lookup_l4pagetable+0xa3>
                return NULL;
   42fcf:	b8 00 00 00 00       	mov    $0x0,%eax
   42fd4:	e9 e9 00 00 00       	jmp    430c2 <lookup_l4pagetable+0x18c>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42fd9:	be a7 00 00 00       	mov    $0xa7,%esi
   42fde:	48 8d 05 fb 2a 00 00 	lea    0x2afb(%rip),%rax        # 45ae0 <complex_keymap+0x4a0>
   42fe5:	48 89 c7             	mov    %rax,%rdi
   42fe8:	b8 00 00 00 00       	mov    $0x0,%eax
   42fed:	e8 a7 f5 ff ff       	call   42599 <log_printf>
            return NULL;
   42ff2:	b8 00 00 00 00       	mov    $0x0,%eax
   42ff7:	e9 c6 00 00 00       	jmp    430c2 <lookup_l4pagetable+0x18c>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42ffc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43000:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43006:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4300c:	76 1e                	jbe    4302c <lookup_l4pagetable+0xf6>
   4300e:	48 8d 05 13 2b 00 00 	lea    0x2b13(%rip),%rax        # 45b28 <complex_keymap+0x4e8>
   43015:	48 89 c2             	mov    %rax,%rdx
   43018:	be ac 00 00 00       	mov    $0xac,%esi
   4301d:	48 8d 05 51 27 00 00 	lea    0x2751(%rip),%rax        # 45775 <complex_keymap+0x135>
   43024:	48 89 c7             	mov    %rax,%rdi
   43027:	e8 c8 f8 ff ff       	call   428f4 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   4302c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4302f:	48 98                	cltq   
   43031:	83 e0 02             	and    $0x2,%eax
   43034:	48 85 c0             	test   %rax,%rax
   43037:	74 2a                	je     43063 <lookup_l4pagetable+0x12d>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   43039:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4303d:	83 e0 02             	and    $0x2,%eax
   43040:	48 85 c0             	test   %rax,%rax
   43043:	75 1e                	jne    43063 <lookup_l4pagetable+0x12d>
   43045:	48 8d 05 fc 2a 00 00 	lea    0x2afc(%rip),%rax        # 45b48 <complex_keymap+0x508>
   4304c:	48 89 c2             	mov    %rax,%rdx
   4304f:	be ae 00 00 00       	mov    $0xae,%esi
   43054:	48 8d 05 1a 27 00 00 	lea    0x271a(%rip),%rax        # 45775 <complex_keymap+0x135>
   4305b:	48 89 c7             	mov    %rax,%rdi
   4305e:	e8 91 f8 ff ff       	call   428f4 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   43063:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43066:	48 98                	cltq   
   43068:	83 e0 04             	and    $0x4,%eax
   4306b:	48 85 c0             	test   %rax,%rax
   4306e:	74 2a                	je     4309a <lookup_l4pagetable+0x164>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   43070:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43074:	83 e0 04             	and    $0x4,%eax
   43077:	48 85 c0             	test   %rax,%rax
   4307a:	75 1e                	jne    4309a <lookup_l4pagetable+0x164>
   4307c:	48 8d 05 d0 2a 00 00 	lea    0x2ad0(%rip),%rax        # 45b53 <complex_keymap+0x513>
   43083:	48 89 c2             	mov    %rax,%rdx
   43086:	be b1 00 00 00       	mov    $0xb1,%esi
   4308b:	48 8d 05 e3 26 00 00 	lea    0x26e3(%rip),%rax        # 45775 <complex_keymap+0x135>
   43092:	48 89 c7             	mov    %rax,%rdi
   43095:	e8 5a f8 ff ff       	call   428f4 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   4309a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   430a1:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   430a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430a6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   430ac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   430b0:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   430b4:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   430b8:	0f 8e a3 fe ff ff    	jle    42f61 <lookup_l4pagetable+0x2b>
    }
    return pt;
   430be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   430c2:	c9                   	leave  
   430c3:	c3                   	ret    

00000000000430c4 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   430c4:	f3 0f 1e fa          	endbr64 
   430c8:	55                   	push   %rbp
   430c9:	48 89 e5             	mov    %rsp,%rbp
   430cc:	48 83 ec 50          	sub    $0x50,%rsp
   430d0:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   430d4:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   430d8:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   430dc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   430e0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   430e4:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   430eb:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   430ec:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   430f3:	eb 41                	jmp    43136 <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   430f5:	8b 55 ec             	mov    -0x14(%rbp),%edx
   430f8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   430fc:	89 d6                	mov    %edx,%esi
   430fe:	48 89 c7             	mov    %rax,%rdi
   43101:	e8 65 f8 ff ff       	call   4296b <pageindex>
   43106:	89 c2                	mov    %eax,%edx
   43108:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4310c:	48 63 d2             	movslq %edx,%rdx
   4310f:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43113:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43117:	83 e0 06             	and    $0x6,%eax
   4311a:	48 f7 d0             	not    %rax
   4311d:	48 21 d0             	and    %rdx,%rax
   43120:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43124:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43128:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4312e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43132:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43136:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4313a:	7f 0c                	jg     43148 <virtual_memory_lookup+0x84>
   4313c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43140:	83 e0 01             	and    $0x1,%eax
   43143:	48 85 c0             	test   %rax,%rax
   43146:	75 ad                	jne    430f5 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   43148:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   4314f:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   43156:	ff 
   43157:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   4315e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43162:	83 e0 01             	and    $0x1,%eax
   43165:	48 85 c0             	test   %rax,%rax
   43168:	74 34                	je     4319e <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   4316a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4316e:	48 c1 e8 0c          	shr    $0xc,%rax
   43172:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43175:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43179:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4317f:	48 89 c2             	mov    %rax,%rdx
   43182:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43186:	25 ff 0f 00 00       	and    $0xfff,%eax
   4318b:	48 09 d0             	or     %rdx,%rax
   4318e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   43192:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43196:	25 ff 0f 00 00       	and    $0xfff,%eax
   4319b:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   4319e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431a2:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   431a6:	48 89 10             	mov    %rdx,(%rax)
   431a9:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   431ad:	48 89 50 08          	mov    %rdx,0x8(%rax)
   431b1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   431b5:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   431b9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431bd:	c9                   	leave  
   431be:	c3                   	ret    

00000000000431bf <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   431bf:	f3 0f 1e fa          	endbr64 
   431c3:	55                   	push   %rbp
   431c4:	48 89 e5             	mov    %rsp,%rbp
   431c7:	48 83 ec 40          	sub    $0x40,%rsp
   431cb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   431cf:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   431d2:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   431d6:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   431dd:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   431e1:	78 08                	js     431eb <program_load+0x2c>
   431e3:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   431e6:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   431e9:	7c 1e                	jl     43209 <program_load+0x4a>
   431eb:	48 8d 05 6e 29 00 00 	lea    0x296e(%rip),%rax        # 45b60 <complex_keymap+0x520>
   431f2:	48 89 c2             	mov    %rax,%rdx
   431f5:	be 2e 00 00 00       	mov    $0x2e,%esi
   431fa:	48 8d 05 8f 29 00 00 	lea    0x298f(%rip),%rax        # 45b90 <complex_keymap+0x550>
   43201:	48 89 c7             	mov    %rax,%rdi
   43204:	e8 eb f6 ff ff       	call   428f4 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   43209:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   4320c:	48 98                	cltq   
   4320e:	48 c1 e0 04          	shl    $0x4,%rax
   43212:	48 89 c2             	mov    %rax,%rdx
   43215:	48 8d 05 04 2e 00 00 	lea    0x2e04(%rip),%rax        # 46020 <ramimages>
   4321c:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   43220:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43224:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43228:	8b 00                	mov    (%rax),%eax
   4322a:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   4322f:	74 1e                	je     4324f <program_load+0x90>
   43231:	48 8d 05 6a 29 00 00 	lea    0x296a(%rip),%rax        # 45ba2 <complex_keymap+0x562>
   43238:	48 89 c2             	mov    %rax,%rdx
   4323b:	be 30 00 00 00       	mov    $0x30,%esi
   43240:	48 8d 05 49 29 00 00 	lea    0x2949(%rip),%rax        # 45b90 <complex_keymap+0x550>
   43247:	48 89 c7             	mov    %rax,%rdi
   4324a:	e8 a5 f6 ff ff       	call   428f4 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   4324f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43253:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43257:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4325b:	48 01 d0             	add    %rdx,%rax
   4325e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43262:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43269:	e9 94 00 00 00       	jmp    43302 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   4326e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43271:	48 63 d0             	movslq %eax,%rdx
   43274:	48 89 d0             	mov    %rdx,%rax
   43277:	48 c1 e0 03          	shl    $0x3,%rax
   4327b:	48 29 d0             	sub    %rdx,%rax
   4327e:	48 c1 e0 03          	shl    $0x3,%rax
   43282:	48 89 c2             	mov    %rax,%rdx
   43285:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43289:	48 01 d0             	add    %rdx,%rax
   4328c:	8b 00                	mov    (%rax),%eax
   4328e:	83 f8 01             	cmp    $0x1,%eax
   43291:	75 6b                	jne    432fe <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   43293:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43296:	48 63 d0             	movslq %eax,%rdx
   43299:	48 89 d0             	mov    %rdx,%rax
   4329c:	48 c1 e0 03          	shl    $0x3,%rax
   432a0:	48 29 d0             	sub    %rdx,%rax
   432a3:	48 c1 e0 03          	shl    $0x3,%rax
   432a7:	48 89 c2             	mov    %rax,%rdx
   432aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432ae:	48 01 d0             	add    %rdx,%rax
   432b1:	48 8b 50 08          	mov    0x8(%rax),%rdx
   432b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432b9:	48 01 d0             	add    %rdx,%rax
   432bc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   432c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   432c3:	48 63 d0             	movslq %eax,%rdx
   432c6:	48 89 d0             	mov    %rdx,%rax
   432c9:	48 c1 e0 03          	shl    $0x3,%rax
   432cd:	48 29 d0             	sub    %rdx,%rax
   432d0:	48 c1 e0 03          	shl    $0x3,%rax
   432d4:	48 89 c2             	mov    %rax,%rdx
   432d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432db:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   432df:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   432e3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   432e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432eb:	48 89 c7             	mov    %rax,%rdi
   432ee:	e8 3d 00 00 00       	call   43330 <program_load_segment>
   432f3:	85 c0                	test   %eax,%eax
   432f5:	79 07                	jns    432fe <program_load+0x13f>
                return -1;
   432f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   432fc:	eb 30                	jmp    4332e <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   432fe:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43302:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43306:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   4330a:	0f b7 c0             	movzwl %ax,%eax
   4330d:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43310:	0f 8c 58 ff ff ff    	jl     4326e <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   43316:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4331a:	48 8b 50 18          	mov    0x18(%rax),%rdx
   4331e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43322:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   43329:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4332e:	c9                   	leave  
   4332f:	c3                   	ret    

0000000000043330 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43330:	f3 0f 1e fa          	endbr64 
   43334:	55                   	push   %rbp
   43335:	48 89 e5             	mov    %rsp,%rbp
   43338:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4333c:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   43340:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   43344:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   43348:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4334c:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43350:	48 8b 40 10          	mov    0x10(%rax),%rax
   43354:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   43358:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   4335c:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43360:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43364:	48 01 d0             	add    %rdx,%rax
   43367:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4336b:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   4336f:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43373:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43377:	48 01 d0             	add    %rdx,%rax
   4337a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   4337e:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   43385:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43386:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4338a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4338e:	e9 81 00 00 00       	jmp    43414 <program_load_segment+0xe4>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   43393:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43397:	8b 00                	mov    (%rax),%eax
   43399:	89 c7                	mov    %eax,%edi
   4339b:	e8 a0 01 00 00       	call   43540 <palloc>
   433a0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   433a4:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   433a9:	74 2a                	je     433d5 <program_load_segment+0xa5>
   433ab:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   433af:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   433b6:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   433ba:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   433be:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   433c4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   433c9:	48 89 c7             	mov    %rax,%rdi
   433cc:	e8 a7 f8 ff ff       	call   42c78 <virtual_memory_map>
   433d1:	85 c0                	test   %eax,%eax
   433d3:	79 37                	jns    4340c <program_load_segment+0xdc>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   433d5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   433d9:	8b 00                	mov    (%rax),%eax
   433db:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   433df:	49 89 d0             	mov    %rdx,%r8
   433e2:	89 c1                	mov    %eax,%ecx
   433e4:	48 8d 05 d5 27 00 00 	lea    0x27d5(%rip),%rax        # 45bc0 <complex_keymap+0x580>
   433eb:	48 89 c2             	mov    %rax,%rdx
   433ee:	be 00 c0 00 00       	mov    $0xc000,%esi
   433f3:	bf e0 06 00 00       	mov    $0x6e0,%edi
   433f8:	b8 00 00 00 00       	mov    $0x0,%eax
   433fd:	e8 b7 1b 00 00       	call   44fb9 <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   43402:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43407:	e9 32 01 00 00       	jmp    4353e <program_load_segment+0x20e>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4340c:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43413:	00 
   43414:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43418:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4341c:	0f 82 71 ff ff ff    	jb     43393 <program_load_segment+0x63>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43422:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43426:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4342d:	48 89 c7             	mov    %rax,%rdi
   43430:	e8 d1 f6 ff ff       	call   42b06 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43435:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43439:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4343d:	48 89 c2             	mov    %rax,%rdx
   43440:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43444:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43448:	48 89 ce             	mov    %rcx,%rsi
   4344b:	48 89 c7             	mov    %rax,%rdi
   4344e:	e8 21 0c 00 00       	call   44074 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43453:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43457:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4345b:	48 89 c2             	mov    %rax,%rdx
   4345e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43462:	be 00 00 00 00       	mov    $0x0,%esi
   43467:	48 89 c7             	mov    %rax,%rdi
   4346a:	e8 0b 0d 00 00       	call   4417a <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   4346f:	48 8b 05 8a eb 00 00 	mov    0xeb8a(%rip),%rax        # 52000 <kernel_pagetable>
   43476:	48 89 c7             	mov    %rax,%rdi
   43479:	e8 88 f6 ff ff       	call   42b06 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   4347e:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43482:	8b 40 04             	mov    0x4(%rax),%eax
   43485:	83 e0 02             	and    $0x2,%eax
   43488:	85 c0                	test   %eax,%eax
   4348a:	75 60                	jne    434ec <program_load_segment+0x1bc>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4348c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43490:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43494:	eb 4c                	jmp    434e2 <program_load_segment+0x1b2>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   43496:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4349a:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   434a1:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   434a5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   434a9:	48 89 ce             	mov    %rcx,%rsi
   434ac:	48 89 c7             	mov    %rax,%rdi
   434af:	e8 10 fc ff ff       	call   430c4 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   434b4:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   434b8:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   434bc:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   434c3:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   434c7:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   434cd:	b9 00 10 00 00       	mov    $0x1000,%ecx
   434d2:	48 89 c7             	mov    %rax,%rdi
   434d5:	e8 9e f7 ff ff       	call   42c78 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   434da:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   434e1:	00 
   434e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434e6:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   434ea:	72 aa                	jb     43496 <program_load_segment+0x166>
                    PTE_P | PTE_U);
        }
    }
    // get break to end of proc mem rounded to pagesize
    p->original_break = ROUNDUP(end_mem, PAGESIZE); 
   434ec:	48 c7 45 d0 00 10 00 	movq   $0x1000,-0x30(%rbp)
   434f3:	00 
   434f4:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   434f8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434fc:	48 01 d0             	add    %rdx,%rax
   434ff:	48 83 e8 01          	sub    $0x1,%rax
   43503:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   43507:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4350b:	ba 00 00 00 00       	mov    $0x0,%edx
   43510:	48 f7 75 d0          	divq   -0x30(%rbp)
   43514:	48 89 d1             	mov    %rdx,%rcx
   43517:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4351b:	48 29 c8             	sub    %rcx,%rax
   4351e:	48 89 c2             	mov    %rax,%rdx
   43521:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43525:	48 89 50 10          	mov    %rdx,0x10(%rax)
    p->program_break = p->original_break;
   43529:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4352d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43531:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43535:	48 89 50 08          	mov    %rdx,0x8(%rax)

    return 0;
   43539:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4353e:	c9                   	leave  
   4353f:	c3                   	ret    

0000000000043540 <palloc>:
   43540:	55                   	push   %rbp
   43541:	48 89 e5             	mov    %rsp,%rbp
   43544:	48 83 ec 20          	sub    $0x20,%rsp
   43548:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4354b:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43552:	00 
   43553:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43557:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4355b:	e9 95 00 00 00       	jmp    435f5 <palloc+0xb5>
   43560:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43564:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43568:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4356f:	00 
   43570:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43574:	48 c1 e8 0c          	shr    $0xc,%rax
   43578:	48 98                	cltq   
   4357a:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   43581:	00 
   43582:	84 c0                	test   %al,%al
   43584:	75 6f                	jne    435f5 <palloc+0xb5>
   43586:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4358a:	48 c1 e8 0c          	shr    $0xc,%rax
   4358e:	48 98                	cltq   
   43590:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43597:	00 
   43598:	84 c0                	test   %al,%al
   4359a:	75 59                	jne    435f5 <palloc+0xb5>
   4359c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435a0:	48 c1 e8 0c          	shr    $0xc,%rax
   435a4:	89 c2                	mov    %eax,%edx
   435a6:	48 63 c2             	movslq %edx,%rax
   435a9:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   435b0:	00 
   435b1:	83 c0 01             	add    $0x1,%eax
   435b4:	89 c1                	mov    %eax,%ecx
   435b6:	48 63 c2             	movslq %edx,%rax
   435b9:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   435c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435c4:	48 c1 e8 0c          	shr    $0xc,%rax
   435c8:	89 c1                	mov    %eax,%ecx
   435ca:	8b 45 ec             	mov    -0x14(%rbp),%eax
   435cd:	89 c2                	mov    %eax,%edx
   435cf:	48 63 c1             	movslq %ecx,%rax
   435d2:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
   435d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435dd:	ba 00 10 00 00       	mov    $0x1000,%edx
   435e2:	be cc 00 00 00       	mov    $0xcc,%esi
   435e7:	48 89 c7             	mov    %rax,%rdi
   435ea:	e8 8b 0b 00 00       	call   4417a <memset>
   435ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435f3:	eb 2c                	jmp    43621 <palloc+0xe1>
   435f5:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   435fc:	00 
   435fd:	0f 86 5d ff ff ff    	jbe    43560 <palloc+0x20>
   43603:	ba f8 5b 04 00       	mov    $0x45bf8,%edx
   43608:	be 00 0c 00 00       	mov    $0xc00,%esi
   4360d:	bf 80 07 00 00       	mov    $0x780,%edi
   43612:	b8 00 00 00 00       	mov    $0x0,%eax
   43617:	e8 9d 19 00 00       	call   44fb9 <console_printf>
   4361c:	b8 00 00 00 00       	mov    $0x0,%eax
   43621:	c9                   	leave  
   43622:	c3                   	ret    

0000000000043623 <palloc_target>:
   43623:	55                   	push   %rbp
   43624:	48 89 e5             	mov    %rsp,%rbp
   43627:	48 8b 05 d2 49 01 00 	mov    0x149d2(%rip),%rax        # 58000 <palloc_target_proc>
   4362e:	48 85 c0             	test   %rax,%rax
   43631:	75 14                	jne    43647 <palloc_target+0x24>
   43633:	ba 11 5c 04 00       	mov    $0x45c11,%edx
   43638:	be 27 00 00 00       	mov    $0x27,%esi
   4363d:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   43642:	e8 ad f2 ff ff       	call   428f4 <assert_fail>
   43647:	48 8b 05 b2 49 01 00 	mov    0x149b2(%rip),%rax        # 58000 <palloc_target_proc>
   4364e:	8b 00                	mov    (%rax),%eax
   43650:	89 c7                	mov    %eax,%edi
   43652:	e8 e9 fe ff ff       	call   43540 <palloc>
   43657:	5d                   	pop    %rbp
   43658:	c3                   	ret    

0000000000043659 <process_free>:
   43659:	55                   	push   %rbp
   4365a:	48 89 e5             	mov    %rsp,%rbp
   4365d:	48 83 ec 60          	sub    $0x60,%rsp
   43661:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43664:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43667:	48 63 d0             	movslq %eax,%rdx
   4366a:	48 89 d0             	mov    %rdx,%rax
   4366d:	48 c1 e0 04          	shl    $0x4,%rax
   43671:	48 29 d0             	sub    %rdx,%rax
   43674:	48 c1 e0 04          	shl    $0x4,%rax
   43678:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   4367e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43684:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   4368b:	00 
   4368c:	e9 ad 00 00 00       	jmp    4373e <process_free+0xe5>
   43691:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43694:	48 63 d0             	movslq %eax,%rdx
   43697:	48 89 d0             	mov    %rdx,%rax
   4369a:	48 c1 e0 04          	shl    $0x4,%rax
   4369e:	48 29 d0             	sub    %rdx,%rax
   436a1:	48 c1 e0 04          	shl    $0x4,%rax
   436a5:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   436ab:	48 8b 08             	mov    (%rax),%rcx
   436ae:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   436b2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   436b6:	48 89 ce             	mov    %rcx,%rsi
   436b9:	48 89 c7             	mov    %rax,%rdi
   436bc:	e8 03 fa ff ff       	call   430c4 <virtual_memory_lookup>
   436c1:	8b 45 c8             	mov    -0x38(%rbp),%eax
   436c4:	48 98                	cltq   
   436c6:	83 e0 01             	and    $0x1,%eax
   436c9:	48 85 c0             	test   %rax,%rax
   436cc:	74 68                	je     43736 <process_free+0xdd>
   436ce:	8b 45 b8             	mov    -0x48(%rbp),%eax
   436d1:	48 63 d0             	movslq %eax,%rdx
   436d4:	0f b6 94 12 21 ff 04 	movzbl 0x4ff21(%rdx,%rdx,1),%edx
   436db:	00 
   436dc:	83 ea 01             	sub    $0x1,%edx
   436df:	48 98                	cltq   
   436e1:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
   436e8:	8b 45 b8             	mov    -0x48(%rbp),%eax
   436eb:	48 98                	cltq   
   436ed:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   436f4:	00 
   436f5:	84 c0                	test   %al,%al
   436f7:	75 0f                	jne    43708 <process_free+0xaf>
   436f9:	8b 45 b8             	mov    -0x48(%rbp),%eax
   436fc:	48 98                	cltq   
   436fe:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43705:	00 
   43706:	eb 2e                	jmp    43736 <process_free+0xdd>
   43708:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4370b:	48 98                	cltq   
   4370d:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   43714:	00 
   43715:	0f be c0             	movsbl %al,%eax
   43718:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   4371b:	75 19                	jne    43736 <process_free+0xdd>
   4371d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43721:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43724:	48 89 c6             	mov    %rax,%rsi
   43727:	bf 38 5c 04 00       	mov    $0x45c38,%edi
   4372c:	b8 00 00 00 00       	mov    $0x0,%eax
   43731:	e8 63 ee ff ff       	call   42599 <log_printf>
   43736:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4373d:	00 
   4373e:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43745:	00 
   43746:	0f 86 45 ff ff ff    	jbe    43691 <process_free+0x38>
   4374c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4374f:	48 63 d0             	movslq %eax,%rdx
   43752:	48 89 d0             	mov    %rdx,%rax
   43755:	48 c1 e0 04          	shl    $0x4,%rax
   43759:	48 29 d0             	sub    %rdx,%rax
   4375c:	48 c1 e0 04          	shl    $0x4,%rax
   43760:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43766:	48 8b 00             	mov    (%rax),%rax
   43769:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4376d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43771:	48 8b 00             	mov    (%rax),%rax
   43774:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4377a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4377e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43782:	48 8b 00             	mov    (%rax),%rax
   43785:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4378b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4378f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43793:	48 8b 00             	mov    (%rax),%rax
   43796:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4379c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   437a0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437a4:	48 8b 40 08          	mov    0x8(%rax),%rax
   437a8:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   437ae:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   437b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437b6:	48 c1 e8 0c          	shr    $0xc,%rax
   437ba:	48 98                	cltq   
   437bc:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   437c3:	00 
   437c4:	3c 01                	cmp    $0x1,%al
   437c6:	74 14                	je     437dc <process_free+0x183>
   437c8:	ba 70 5c 04 00       	mov    $0x45c70,%edx
   437cd:	be 4f 00 00 00       	mov    $0x4f,%esi
   437d2:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   437d7:	e8 18 f1 ff ff       	call   428f4 <assert_fail>
   437dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437e0:	48 c1 e8 0c          	shr    $0xc,%rax
   437e4:	48 98                	cltq   
   437e6:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   437ed:	00 
   437ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437f2:	48 c1 e8 0c          	shr    $0xc,%rax
   437f6:	48 98                	cltq   
   437f8:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   437ff:	00 
   43800:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43804:	48 c1 e8 0c          	shr    $0xc,%rax
   43808:	48 98                	cltq   
   4380a:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43811:	00 
   43812:	3c 01                	cmp    $0x1,%al
   43814:	74 14                	je     4382a <process_free+0x1d1>
   43816:	ba 98 5c 04 00       	mov    $0x45c98,%edx
   4381b:	be 52 00 00 00       	mov    $0x52,%esi
   43820:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   43825:	e8 ca f0 ff ff       	call   428f4 <assert_fail>
   4382a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4382e:	48 c1 e8 0c          	shr    $0xc,%rax
   43832:	48 98                	cltq   
   43834:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4383b:	00 
   4383c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43840:	48 c1 e8 0c          	shr    $0xc,%rax
   43844:	48 98                	cltq   
   43846:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4384d:	00 
   4384e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43852:	48 c1 e8 0c          	shr    $0xc,%rax
   43856:	48 98                	cltq   
   43858:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4385f:	00 
   43860:	3c 01                	cmp    $0x1,%al
   43862:	74 14                	je     43878 <process_free+0x21f>
   43864:	ba c0 5c 04 00       	mov    $0x45cc0,%edx
   43869:	be 55 00 00 00       	mov    $0x55,%esi
   4386e:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   43873:	e8 7c f0 ff ff       	call   428f4 <assert_fail>
   43878:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4387c:	48 c1 e8 0c          	shr    $0xc,%rax
   43880:	48 98                	cltq   
   43882:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43889:	00 
   4388a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4388e:	48 c1 e8 0c          	shr    $0xc,%rax
   43892:	48 98                	cltq   
   43894:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4389b:	00 
   4389c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438a0:	48 c1 e8 0c          	shr    $0xc,%rax
   438a4:	48 98                	cltq   
   438a6:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   438ad:	00 
   438ae:	3c 01                	cmp    $0x1,%al
   438b0:	74 14                	je     438c6 <process_free+0x26d>
   438b2:	ba e8 5c 04 00       	mov    $0x45ce8,%edx
   438b7:	be 58 00 00 00       	mov    $0x58,%esi
   438bc:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   438c1:	e8 2e f0 ff ff       	call   428f4 <assert_fail>
   438c6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438ca:	48 c1 e8 0c          	shr    $0xc,%rax
   438ce:	48 98                	cltq   
   438d0:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   438d7:	00 
   438d8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438dc:	48 c1 e8 0c          	shr    $0xc,%rax
   438e0:	48 98                	cltq   
   438e2:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   438e9:	00 
   438ea:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   438ee:	48 c1 e8 0c          	shr    $0xc,%rax
   438f2:	48 98                	cltq   
   438f4:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   438fb:	00 
   438fc:	3c 01                	cmp    $0x1,%al
   438fe:	74 14                	je     43914 <process_free+0x2bb>
   43900:	ba 10 5d 04 00       	mov    $0x45d10,%edx
   43905:	be 5b 00 00 00       	mov    $0x5b,%esi
   4390a:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   4390f:	e8 e0 ef ff ff       	call   428f4 <assert_fail>
   43914:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43918:	48 c1 e8 0c          	shr    $0xc,%rax
   4391c:	48 98                	cltq   
   4391e:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43925:	00 
   43926:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4392a:	48 c1 e8 0c          	shr    $0xc,%rax
   4392e:	48 98                	cltq   
   43930:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43937:	00 
   43938:	90                   	nop
   43939:	c9                   	leave  
   4393a:	c3                   	ret    

000000000004393b <process_config_tables>:
   4393b:	55                   	push   %rbp
   4393c:	48 89 e5             	mov    %rsp,%rbp
   4393f:	48 83 ec 40          	sub    $0x40,%rsp
   43943:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43946:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43949:	89 c7                	mov    %eax,%edi
   4394b:	e8 f0 fb ff ff       	call   43540 <palloc>
   43950:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43954:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43957:	89 c7                	mov    %eax,%edi
   43959:	e8 e2 fb ff ff       	call   43540 <palloc>
   4395e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43962:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43965:	89 c7                	mov    %eax,%edi
   43967:	e8 d4 fb ff ff       	call   43540 <palloc>
   4396c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43970:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43973:	89 c7                	mov    %eax,%edi
   43975:	e8 c6 fb ff ff       	call   43540 <palloc>
   4397a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4397e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43981:	89 c7                	mov    %eax,%edi
   43983:	e8 b8 fb ff ff       	call   43540 <palloc>
   43988:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4398c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43991:	74 20                	je     439b3 <process_config_tables+0x78>
   43993:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43998:	74 19                	je     439b3 <process_config_tables+0x78>
   4399a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4399f:	74 12                	je     439b3 <process_config_tables+0x78>
   439a1:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   439a6:	74 0b                	je     439b3 <process_config_tables+0x78>
   439a8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   439ad:	0f 85 e1 00 00 00    	jne    43a94 <process_config_tables+0x159>
   439b3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   439b8:	74 24                	je     439de <process_config_tables+0xa3>
   439ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   439be:	48 c1 e8 0c          	shr    $0xc,%rax
   439c2:	48 98                	cltq   
   439c4:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   439cb:	00 
   439cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   439d0:	48 c1 e8 0c          	shr    $0xc,%rax
   439d4:	48 98                	cltq   
   439d6:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   439dd:	00 
   439de:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   439e3:	74 24                	je     43a09 <process_config_tables+0xce>
   439e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   439e9:	48 c1 e8 0c          	shr    $0xc,%rax
   439ed:	48 98                	cltq   
   439ef:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   439f6:	00 
   439f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   439fb:	48 c1 e8 0c          	shr    $0xc,%rax
   439ff:	48 98                	cltq   
   43a01:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43a08:	00 
   43a09:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43a0e:	74 24                	je     43a34 <process_config_tables+0xf9>
   43a10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a14:	48 c1 e8 0c          	shr    $0xc,%rax
   43a18:	48 98                	cltq   
   43a1a:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43a21:	00 
   43a22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a26:	48 c1 e8 0c          	shr    $0xc,%rax
   43a2a:	48 98                	cltq   
   43a2c:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43a33:	00 
   43a34:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43a39:	74 24                	je     43a5f <process_config_tables+0x124>
   43a3b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a3f:	48 c1 e8 0c          	shr    $0xc,%rax
   43a43:	48 98                	cltq   
   43a45:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43a4c:	00 
   43a4d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a51:	48 c1 e8 0c          	shr    $0xc,%rax
   43a55:	48 98                	cltq   
   43a57:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43a5e:	00 
   43a5f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43a64:	74 24                	je     43a8a <process_config_tables+0x14f>
   43a66:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a6a:	48 c1 e8 0c          	shr    $0xc,%rax
   43a6e:	48 98                	cltq   
   43a70:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43a77:	00 
   43a78:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a7c:	48 c1 e8 0c          	shr    $0xc,%rax
   43a80:	48 98                	cltq   
   43a82:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43a89:	00 
   43a8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a8f:	e9 f3 01 00 00       	jmp    43c87 <process_config_tables+0x34c>
   43a94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a98:	ba 00 10 00 00       	mov    $0x1000,%edx
   43a9d:	be 00 00 00 00       	mov    $0x0,%esi
   43aa2:	48 89 c7             	mov    %rax,%rdi
   43aa5:	e8 d0 06 00 00       	call   4417a <memset>
   43aaa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43aae:	ba 00 10 00 00       	mov    $0x1000,%edx
   43ab3:	be 00 00 00 00       	mov    $0x0,%esi
   43ab8:	48 89 c7             	mov    %rax,%rdi
   43abb:	e8 ba 06 00 00       	call   4417a <memset>
   43ac0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ac4:	ba 00 10 00 00       	mov    $0x1000,%edx
   43ac9:	be 00 00 00 00       	mov    $0x0,%esi
   43ace:	48 89 c7             	mov    %rax,%rdi
   43ad1:	e8 a4 06 00 00       	call   4417a <memset>
   43ad6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ada:	ba 00 10 00 00       	mov    $0x1000,%edx
   43adf:	be 00 00 00 00       	mov    $0x0,%esi
   43ae4:	48 89 c7             	mov    %rax,%rdi
   43ae7:	e8 8e 06 00 00       	call   4417a <memset>
   43aec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43af0:	ba 00 10 00 00       	mov    $0x1000,%edx
   43af5:	be 00 00 00 00       	mov    $0x0,%esi
   43afa:	48 89 c7             	mov    %rax,%rdi
   43afd:	e8 78 06 00 00       	call   4417a <memset>
   43b02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b06:	48 83 c8 07          	or     $0x7,%rax
   43b0a:	48 89 c2             	mov    %rax,%rdx
   43b0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b11:	48 89 10             	mov    %rdx,(%rax)
   43b14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b18:	48 83 c8 07          	or     $0x7,%rax
   43b1c:	48 89 c2             	mov    %rax,%rdx
   43b1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b23:	48 89 10             	mov    %rdx,(%rax)
   43b26:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43b2a:	48 83 c8 07          	or     $0x7,%rax
   43b2e:	48 89 c2             	mov    %rax,%rdx
   43b31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b35:	48 89 10             	mov    %rdx,(%rax)
   43b38:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b3c:	48 83 c8 07          	or     $0x7,%rax
   43b40:	48 89 c2             	mov    %rax,%rdx
   43b43:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b47:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43b4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b4f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43b55:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   43b5b:	b9 00 00 10 00       	mov    $0x100000,%ecx
   43b60:	ba 00 00 00 00       	mov    $0x0,%edx
   43b65:	be 00 00 00 00       	mov    $0x0,%esi
   43b6a:	48 89 c7             	mov    %rax,%rdi
   43b6d:	e8 06 f1 ff ff       	call   42c78 <virtual_memory_map>
   43b72:	85 c0                	test   %eax,%eax
   43b74:	75 2f                	jne    43ba5 <process_config_tables+0x26a>
   43b76:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   43b7b:	be 00 80 0b 00       	mov    $0xb8000,%esi
   43b80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b84:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43b8a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43b90:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43b95:	48 89 c7             	mov    %rax,%rdi
   43b98:	e8 db f0 ff ff       	call   42c78 <virtual_memory_map>
   43b9d:	85 c0                	test   %eax,%eax
   43b9f:	0f 84 bb 00 00 00    	je     43c60 <process_config_tables+0x325>
   43ba5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ba9:	48 c1 e8 0c          	shr    $0xc,%rax
   43bad:	48 98                	cltq   
   43baf:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43bb6:	00 
   43bb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bbb:	48 c1 e8 0c          	shr    $0xc,%rax
   43bbf:	48 98                	cltq   
   43bc1:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43bc8:	00 
   43bc9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bcd:	48 c1 e8 0c          	shr    $0xc,%rax
   43bd1:	48 98                	cltq   
   43bd3:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43bda:	00 
   43bdb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bdf:	48 c1 e8 0c          	shr    $0xc,%rax
   43be3:	48 98                	cltq   
   43be5:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43bec:	00 
   43bed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bf1:	48 c1 e8 0c          	shr    $0xc,%rax
   43bf5:	48 98                	cltq   
   43bf7:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43bfe:	00 
   43bff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c03:	48 c1 e8 0c          	shr    $0xc,%rax
   43c07:	48 98                	cltq   
   43c09:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43c10:	00 
   43c11:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c15:	48 c1 e8 0c          	shr    $0xc,%rax
   43c19:	48 98                	cltq   
   43c1b:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43c22:	00 
   43c23:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c27:	48 c1 e8 0c          	shr    $0xc,%rax
   43c2b:	48 98                	cltq   
   43c2d:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43c34:	00 
   43c35:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c39:	48 c1 e8 0c          	shr    $0xc,%rax
   43c3d:	48 98                	cltq   
   43c3f:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43c46:	00 
   43c47:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c4b:	48 c1 e8 0c          	shr    $0xc,%rax
   43c4f:	48 98                	cltq   
   43c51:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43c58:	00 
   43c59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43c5e:	eb 27                	jmp    43c87 <process_config_tables+0x34c>
   43c60:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43c63:	48 63 d0             	movslq %eax,%rdx
   43c66:	48 89 d0             	mov    %rdx,%rax
   43c69:	48 c1 e0 04          	shl    $0x4,%rax
   43c6d:	48 29 d0             	sub    %rdx,%rax
   43c70:	48 c1 e0 04          	shl    $0x4,%rax
   43c74:	48 8d 90 e0 f0 04 00 	lea    0x4f0e0(%rax),%rdx
   43c7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c7f:	48 89 02             	mov    %rax,(%rdx)
   43c82:	b8 00 00 00 00       	mov    $0x0,%eax
   43c87:	c9                   	leave  
   43c88:	c3                   	ret    

0000000000043c89 <process_load>:
   43c89:	55                   	push   %rbp
   43c8a:	48 89 e5             	mov    %rsp,%rbp
   43c8d:	48 83 ec 20          	sub    $0x20,%rsp
   43c91:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c95:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43c98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c9c:	48 89 05 5d 43 01 00 	mov    %rax,0x1435d(%rip)        # 58000 <palloc_target_proc>
   43ca3:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   43ca6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43caa:	ba 23 36 04 00       	mov    $0x43623,%edx
   43caf:	89 ce                	mov    %ecx,%esi
   43cb1:	48 89 c7             	mov    %rax,%rdi
   43cb4:	e8 06 f5 ff ff       	call   431bf <program_load>
   43cb9:	89 45 fc             	mov    %eax,-0x4(%rbp)
   43cbc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43cbf:	c9                   	leave  
   43cc0:	c3                   	ret    

0000000000043cc1 <process_setup_stack>:
   43cc1:	55                   	push   %rbp
   43cc2:	48 89 e5             	mov    %rsp,%rbp
   43cc5:	48 83 ec 20          	sub    $0x20,%rsp
   43cc9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43ccd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cd1:	8b 00                	mov    (%rax),%eax
   43cd3:	89 c7                	mov    %eax,%edi
   43cd5:	e8 66 f8 ff ff       	call   43540 <palloc>
   43cda:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43cde:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ce2:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   43ce9:	00 00 30 00 
   43ced:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cf1:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43cf8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43cfc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43d02:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43d08:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43d0d:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   43d12:	48 89 c7             	mov    %rax,%rdi
   43d15:	e8 5e ef ff ff       	call   42c78 <virtual_memory_map>
   43d1a:	90                   	nop
   43d1b:	c9                   	leave  
   43d1c:	c3                   	ret    

0000000000043d1d <find_free_pid>:
   43d1d:	55                   	push   %rbp
   43d1e:	48 89 e5             	mov    %rsp,%rbp
   43d21:	48 83 ec 10          	sub    $0x10,%rsp
   43d25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43d2c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   43d33:	eb 24                	jmp    43d59 <find_free_pid+0x3c>
   43d35:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43d38:	48 63 d0             	movslq %eax,%rdx
   43d3b:	48 89 d0             	mov    %rdx,%rax
   43d3e:	48 c1 e0 04          	shl    $0x4,%rax
   43d42:	48 29 d0             	sub    %rdx,%rax
   43d45:	48 c1 e0 04          	shl    $0x4,%rax
   43d49:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43d4f:	8b 00                	mov    (%rax),%eax
   43d51:	85 c0                	test   %eax,%eax
   43d53:	74 0c                	je     43d61 <find_free_pid+0x44>
   43d55:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43d59:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   43d5d:	7e d6                	jle    43d35 <find_free_pid+0x18>
   43d5f:	eb 01                	jmp    43d62 <find_free_pid+0x45>
   43d61:	90                   	nop
   43d62:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   43d66:	74 05                	je     43d6d <find_free_pid+0x50>
   43d68:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43d6b:	eb 05                	jmp    43d72 <find_free_pid+0x55>
   43d6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43d72:	c9                   	leave  
   43d73:	c3                   	ret    

0000000000043d74 <process_fork>:
   43d74:	55                   	push   %rbp
   43d75:	48 89 e5             	mov    %rsp,%rbp
   43d78:	48 83 ec 40          	sub    $0x40,%rsp
   43d7c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43d80:	b8 00 00 00 00       	mov    $0x0,%eax
   43d85:	e8 93 ff ff ff       	call   43d1d <find_free_pid>
   43d8a:	89 45 f4             	mov    %eax,-0xc(%rbp)
   43d8d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   43d91:	75 0a                	jne    43d9d <process_fork+0x29>
   43d93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43d98:	e9 67 02 00 00       	jmp    44004 <process_fork+0x290>
   43d9d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43da0:	48 63 d0             	movslq %eax,%rdx
   43da3:	48 89 d0             	mov    %rdx,%rax
   43da6:	48 c1 e0 04          	shl    $0x4,%rax
   43daa:	48 29 d0             	sub    %rdx,%rax
   43dad:	48 c1 e0 04          	shl    $0x4,%rax
   43db1:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   43db7:	be 00 00 00 00       	mov    $0x0,%esi
   43dbc:	48 89 c7             	mov    %rax,%rdi
   43dbf:	e8 fa e2 ff ff       	call   420be <process_init>
   43dc4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43dc7:	89 c7                	mov    %eax,%edi
   43dc9:	e8 6d fb ff ff       	call   4393b <process_config_tables>
   43dce:	83 f8 ff             	cmp    $0xffffffff,%eax
   43dd1:	75 0a                	jne    43ddd <process_fork+0x69>
   43dd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43dd8:	e9 27 02 00 00       	jmp    44004 <process_fork+0x290>
   43ddd:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43de4:	00 
   43de5:	e9 79 01 00 00       	jmp    43f63 <process_fork+0x1ef>
   43dea:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43dee:	8b 00                	mov    (%rax),%eax
   43df0:	48 63 d0             	movslq %eax,%rdx
   43df3:	48 89 d0             	mov    %rdx,%rax
   43df6:	48 c1 e0 04          	shl    $0x4,%rax
   43dfa:	48 29 d0             	sub    %rdx,%rax
   43dfd:	48 c1 e0 04          	shl    $0x4,%rax
   43e01:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43e07:	48 8b 08             	mov    (%rax),%rcx
   43e0a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43e0e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43e12:	48 89 ce             	mov    %rcx,%rsi
   43e15:	48 89 c7             	mov    %rax,%rdi
   43e18:	e8 a7 f2 ff ff       	call   430c4 <virtual_memory_lookup>
   43e1d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43e20:	48 98                	cltq   
   43e22:	83 e0 07             	and    $0x7,%eax
   43e25:	48 83 f8 07          	cmp    $0x7,%rax
   43e29:	0f 85 a1 00 00 00    	jne    43ed0 <process_fork+0x15c>
   43e2f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43e32:	89 c7                	mov    %eax,%edi
   43e34:	e8 07 f7 ff ff       	call   43540 <palloc>
   43e39:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43e3d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43e42:	75 14                	jne    43e58 <process_fork+0xe4>
   43e44:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43e47:	89 c7                	mov    %eax,%edi
   43e49:	e8 0b f8 ff ff       	call   43659 <process_free>
   43e4e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43e53:	e9 ac 01 00 00       	jmp    44004 <process_fork+0x290>
   43e58:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e5c:	48 89 c1             	mov    %rax,%rcx
   43e5f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e63:	ba 00 10 00 00       	mov    $0x1000,%edx
   43e68:	48 89 ce             	mov    %rcx,%rsi
   43e6b:	48 89 c7             	mov    %rax,%rdi
   43e6e:	e8 01 02 00 00       	call   44074 <memcpy>
   43e73:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   43e77:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43e7a:	48 63 d0             	movslq %eax,%rdx
   43e7d:	48 89 d0             	mov    %rdx,%rax
   43e80:	48 c1 e0 04          	shl    $0x4,%rax
   43e84:	48 29 d0             	sub    %rdx,%rax
   43e87:	48 c1 e0 04          	shl    $0x4,%rax
   43e8b:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43e91:	48 8b 00             	mov    (%rax),%rax
   43e94:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43e98:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43e9e:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43ea4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43ea9:	48 89 fa             	mov    %rdi,%rdx
   43eac:	48 89 c7             	mov    %rax,%rdi
   43eaf:	e8 c4 ed ff ff       	call   42c78 <virtual_memory_map>
   43eb4:	85 c0                	test   %eax,%eax
   43eb6:	0f 84 9f 00 00 00    	je     43f5b <process_fork+0x1e7>
   43ebc:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ebf:	89 c7                	mov    %eax,%edi
   43ec1:	e8 93 f7 ff ff       	call   43659 <process_free>
   43ec6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43ecb:	e9 34 01 00 00       	jmp    44004 <process_fork+0x290>
   43ed0:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43ed3:	48 98                	cltq   
   43ed5:	83 e0 05             	and    $0x5,%eax
   43ed8:	48 83 f8 05          	cmp    $0x5,%rax
   43edc:	75 7d                	jne    43f5b <process_fork+0x1e7>
   43ede:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43ee2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ee5:	48 63 d0             	movslq %eax,%rdx
   43ee8:	48 89 d0             	mov    %rdx,%rax
   43eeb:	48 c1 e0 04          	shl    $0x4,%rax
   43eef:	48 29 d0             	sub    %rdx,%rax
   43ef2:	48 c1 e0 04          	shl    $0x4,%rax
   43ef6:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43efc:	48 8b 00             	mov    (%rax),%rax
   43eff:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43f03:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43f09:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43f0f:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43f14:	48 89 fa             	mov    %rdi,%rdx
   43f17:	48 89 c7             	mov    %rax,%rdi
   43f1a:	e8 59 ed ff ff       	call   42c78 <virtual_memory_map>
   43f1f:	85 c0                	test   %eax,%eax
   43f21:	74 14                	je     43f37 <process_fork+0x1c3>
   43f23:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43f26:	89 c7                	mov    %eax,%edi
   43f28:	e8 2c f7 ff ff       	call   43659 <process_free>
   43f2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43f32:	e9 cd 00 00 00       	jmp    44004 <process_fork+0x290>
   43f37:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43f3b:	48 c1 e8 0c          	shr    $0xc,%rax
   43f3f:	89 c2                	mov    %eax,%edx
   43f41:	48 63 c2             	movslq %edx,%rax
   43f44:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43f4b:	00 
   43f4c:	83 c0 01             	add    $0x1,%eax
   43f4f:	89 c1                	mov    %eax,%ecx
   43f51:	48 63 c2             	movslq %edx,%rax
   43f54:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   43f5b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43f62:	00 
   43f63:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43f6a:	00 
   43f6b:	0f 86 79 fe ff ff    	jbe    43dea <process_fork+0x76>
   43f71:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43f75:	8b 08                	mov    (%rax),%ecx
   43f77:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43f7a:	48 63 d0             	movslq %eax,%rdx
   43f7d:	48 89 d0             	mov    %rdx,%rax
   43f80:	48 c1 e0 04          	shl    $0x4,%rax
   43f84:	48 29 d0             	sub    %rdx,%rax
   43f87:	48 c1 e0 04          	shl    $0x4,%rax
   43f8b:	48 8d b0 10 f0 04 00 	lea    0x4f010(%rax),%rsi
   43f92:	48 63 d1             	movslq %ecx,%rdx
   43f95:	48 89 d0             	mov    %rdx,%rax
   43f98:	48 c1 e0 04          	shl    $0x4,%rax
   43f9c:	48 29 d0             	sub    %rdx,%rax
   43f9f:	48 c1 e0 04          	shl    $0x4,%rax
   43fa3:	48 8d 90 10 f0 04 00 	lea    0x4f010(%rax),%rdx
   43faa:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43fae:	48 83 c2 08          	add    $0x8,%rdx
   43fb2:	b9 18 00 00 00       	mov    $0x18,%ecx
   43fb7:	48 89 c7             	mov    %rax,%rdi
   43fba:	48 89 d6             	mov    %rdx,%rsi
   43fbd:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43fc0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43fc3:	48 63 d0             	movslq %eax,%rdx
   43fc6:	48 89 d0             	mov    %rdx,%rax
   43fc9:	48 c1 e0 04          	shl    $0x4,%rax
   43fcd:	48 29 d0             	sub    %rdx,%rax
   43fd0:	48 c1 e0 04          	shl    $0x4,%rax
   43fd4:	48 05 18 f0 04 00    	add    $0x4f018,%rax
   43fda:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43fe1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43fe4:	48 63 d0             	movslq %eax,%rdx
   43fe7:	48 89 d0             	mov    %rdx,%rax
   43fea:	48 c1 e0 04          	shl    $0x4,%rax
   43fee:	48 29 d0             	sub    %rdx,%rax
   43ff1:	48 c1 e0 04          	shl    $0x4,%rax
   43ff5:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43ffb:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   44001:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44004:	c9                   	leave  
   44005:	c3                   	ret    

0000000000044006 <process_page_alloc>:
   44006:	55                   	push   %rbp
   44007:	48 89 e5             	mov    %rsp,%rbp
   4400a:	48 83 ec 20          	sub    $0x20,%rsp
   4400e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44012:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   44016:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   4401d:	00 
   4401e:	77 07                	ja     44027 <process_page_alloc+0x21>
   44020:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44025:	eb 4b                	jmp    44072 <process_page_alloc+0x6c>
   44027:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4402b:	8b 00                	mov    (%rax),%eax
   4402d:	89 c7                	mov    %eax,%edi
   4402f:	e8 0c f5 ff ff       	call   43540 <palloc>
   44034:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44038:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4403d:	74 2e                	je     4406d <process_page_alloc+0x67>
   4403f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44043:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44047:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4404e:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   44052:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44058:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4405e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44063:	48 89 c7             	mov    %rax,%rdi
   44066:	e8 0d ec ff ff       	call   42c78 <virtual_memory_map>
   4406b:	eb 05                	jmp    44072 <process_page_alloc+0x6c>
   4406d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44072:	c9                   	leave  
   44073:	c3                   	ret    

0000000000044074 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   44074:	f3 0f 1e fa          	endbr64 
   44078:	55                   	push   %rbp
   44079:	48 89 e5             	mov    %rsp,%rbp
   4407c:	48 83 ec 28          	sub    $0x28,%rsp
   44080:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44084:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   44088:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   4408c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44090:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   44094:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44098:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4409c:	eb 1c                	jmp    440ba <memcpy+0x46>
        *d = *s;
   4409e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440a2:	0f b6 10             	movzbl (%rax),%edx
   440a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   440a9:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   440ab:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   440b0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   440b5:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   440ba:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   440bf:	75 dd                	jne    4409e <memcpy+0x2a>
    }
    return dst;
   440c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   440c5:	c9                   	leave  
   440c6:	c3                   	ret    

00000000000440c7 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   440c7:	f3 0f 1e fa          	endbr64 
   440cb:	55                   	push   %rbp
   440cc:	48 89 e5             	mov    %rsp,%rbp
   440cf:	48 83 ec 28          	sub    $0x28,%rsp
   440d3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   440d7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   440db:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   440df:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   440e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   440e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   440eb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   440ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440f3:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   440f7:	73 6a                	jae    44163 <memmove+0x9c>
   440f9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   440fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44101:	48 01 d0             	add    %rdx,%rax
   44104:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   44108:	73 59                	jae    44163 <memmove+0x9c>
        s += n, d += n;
   4410a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4410e:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   44112:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44116:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   4411a:	eb 17                	jmp    44133 <memmove+0x6c>
            *--d = *--s;
   4411c:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   44121:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   44126:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4412a:	0f b6 10             	movzbl (%rax),%edx
   4412d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44131:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   44133:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44137:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4413b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   4413f:	48 85 c0             	test   %rax,%rax
   44142:	75 d8                	jne    4411c <memmove+0x55>
    if (s < d && s + n > d) {
   44144:	eb 2e                	jmp    44174 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   44146:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4414a:	48 8d 42 01          	lea    0x1(%rdx),%rax
   4414e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44152:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44156:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4415a:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   4415e:	0f b6 12             	movzbl (%rdx),%edx
   44161:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   44163:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44167:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4416b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   4416f:	48 85 c0             	test   %rax,%rax
   44172:	75 d2                	jne    44146 <memmove+0x7f>
        }
    }
    return dst;
   44174:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   44178:	c9                   	leave  
   44179:	c3                   	ret    

000000000004417a <memset>:

void* memset(void* v, int c, size_t n) {
   4417a:	f3 0f 1e fa          	endbr64 
   4417e:	55                   	push   %rbp
   4417f:	48 89 e5             	mov    %rsp,%rbp
   44182:	48 83 ec 28          	sub    $0x28,%rsp
   44186:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4418a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4418d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   44191:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44195:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44199:	eb 15                	jmp    441b0 <memset+0x36>
        *p = c;
   4419b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4419e:	89 c2                	mov    %eax,%edx
   441a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441a4:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   441a6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   441ab:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   441b0:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   441b5:	75 e4                	jne    4419b <memset+0x21>
    }
    return v;
   441b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   441bb:	c9                   	leave  
   441bc:	c3                   	ret    

00000000000441bd <strlen>:

size_t strlen(const char* s) {
   441bd:	f3 0f 1e fa          	endbr64 
   441c1:	55                   	push   %rbp
   441c2:	48 89 e5             	mov    %rsp,%rbp
   441c5:	48 83 ec 18          	sub    $0x18,%rsp
   441c9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   441cd:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   441d4:	00 
   441d5:	eb 0a                	jmp    441e1 <strlen+0x24>
        ++n;
   441d7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   441dc:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   441e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   441e5:	0f b6 00             	movzbl (%rax),%eax
   441e8:	84 c0                	test   %al,%al
   441ea:	75 eb                	jne    441d7 <strlen+0x1a>
    }
    return n;
   441ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   441f0:	c9                   	leave  
   441f1:	c3                   	ret    

00000000000441f2 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   441f2:	f3 0f 1e fa          	endbr64 
   441f6:	55                   	push   %rbp
   441f7:	48 89 e5             	mov    %rsp,%rbp
   441fa:	48 83 ec 20          	sub    $0x20,%rsp
   441fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44202:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   44206:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4420d:	00 
   4420e:	eb 0a                	jmp    4421a <strnlen+0x28>
        ++n;
   44210:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   44215:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4421a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4421e:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   44222:	74 0b                	je     4422f <strnlen+0x3d>
   44224:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44228:	0f b6 00             	movzbl (%rax),%eax
   4422b:	84 c0                	test   %al,%al
   4422d:	75 e1                	jne    44210 <strnlen+0x1e>
    }
    return n;
   4422f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   44233:	c9                   	leave  
   44234:	c3                   	ret    

0000000000044235 <strcpy>:

char* strcpy(char* dst, const char* src) {
   44235:	f3 0f 1e fa          	endbr64 
   44239:	55                   	push   %rbp
   4423a:	48 89 e5             	mov    %rsp,%rbp
   4423d:	48 83 ec 20          	sub    $0x20,%rsp
   44241:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44245:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   44249:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4424d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   44251:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44255:	48 8d 42 01          	lea    0x1(%rdx),%rax
   44259:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4425d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44261:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44265:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   44269:	0f b6 12             	movzbl (%rdx),%edx
   4426c:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   4426e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44272:	48 83 e8 01          	sub    $0x1,%rax
   44276:	0f b6 00             	movzbl (%rax),%eax
   44279:	84 c0                	test   %al,%al
   4427b:	75 d4                	jne    44251 <strcpy+0x1c>
    return dst;
   4427d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   44281:	c9                   	leave  
   44282:	c3                   	ret    

0000000000044283 <strcmp>:

int strcmp(const char* a, const char* b) {
   44283:	f3 0f 1e fa          	endbr64 
   44287:	55                   	push   %rbp
   44288:	48 89 e5             	mov    %rsp,%rbp
   4428b:	48 83 ec 10          	sub    $0x10,%rsp
   4428f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   44293:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   44297:	eb 0a                	jmp    442a3 <strcmp+0x20>
        ++a, ++b;
   44299:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4429e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   442a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442a7:	0f b6 00             	movzbl (%rax),%eax
   442aa:	84 c0                	test   %al,%al
   442ac:	74 1d                	je     442cb <strcmp+0x48>
   442ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442b2:	0f b6 00             	movzbl (%rax),%eax
   442b5:	84 c0                	test   %al,%al
   442b7:	74 12                	je     442cb <strcmp+0x48>
   442b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442bd:	0f b6 10             	movzbl (%rax),%edx
   442c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442c4:	0f b6 00             	movzbl (%rax),%eax
   442c7:	38 c2                	cmp    %al,%dl
   442c9:	74 ce                	je     44299 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   442cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442cf:	0f b6 00             	movzbl (%rax),%eax
   442d2:	89 c2                	mov    %eax,%edx
   442d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442d8:	0f b6 00             	movzbl (%rax),%eax
   442db:	38 c2                	cmp    %al,%dl
   442dd:	0f 97 c0             	seta   %al
   442e0:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   442e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442e7:	0f b6 00             	movzbl (%rax),%eax
   442ea:	89 c1                	mov    %eax,%ecx
   442ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442f0:	0f b6 00             	movzbl (%rax),%eax
   442f3:	38 c1                	cmp    %al,%cl
   442f5:	0f 92 c0             	setb   %al
   442f8:	0f b6 c8             	movzbl %al,%ecx
   442fb:	89 d0                	mov    %edx,%eax
   442fd:	29 c8                	sub    %ecx,%eax
}
   442ff:	c9                   	leave  
   44300:	c3                   	ret    

0000000000044301 <strchr>:

char* strchr(const char* s, int c) {
   44301:	f3 0f 1e fa          	endbr64 
   44305:	55                   	push   %rbp
   44306:	48 89 e5             	mov    %rsp,%rbp
   44309:	48 83 ec 10          	sub    $0x10,%rsp
   4430d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   44311:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   44314:	eb 05                	jmp    4431b <strchr+0x1a>
        ++s;
   44316:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   4431b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4431f:	0f b6 00             	movzbl (%rax),%eax
   44322:	84 c0                	test   %al,%al
   44324:	74 0e                	je     44334 <strchr+0x33>
   44326:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4432a:	0f b6 00             	movzbl (%rax),%eax
   4432d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   44330:	38 d0                	cmp    %dl,%al
   44332:	75 e2                	jne    44316 <strchr+0x15>
    }
    if (*s == (char) c) {
   44334:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44338:	0f b6 00             	movzbl (%rax),%eax
   4433b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4433e:	38 d0                	cmp    %dl,%al
   44340:	75 06                	jne    44348 <strchr+0x47>
        return (char*) s;
   44342:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44346:	eb 05                	jmp    4434d <strchr+0x4c>
    } else {
        return NULL;
   44348:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   4434d:	c9                   	leave  
   4434e:	c3                   	ret    

000000000004434f <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   4434f:	f3 0f 1e fa          	endbr64 
   44353:	55                   	push   %rbp
   44354:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   44357:	8b 05 ab 3c 01 00    	mov    0x13cab(%rip),%eax        # 58008 <rand_seed_set>
   4435d:	85 c0                	test   %eax,%eax
   4435f:	75 0a                	jne    4436b <rand+0x1c>
        srand(819234718U);
   44361:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   44366:	e8 24 00 00 00       	call   4438f <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   4436b:	8b 05 9b 3c 01 00    	mov    0x13c9b(%rip),%eax        # 5800c <rand_seed>
   44371:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   44377:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   4437c:	89 05 8a 3c 01 00    	mov    %eax,0x13c8a(%rip)        # 5800c <rand_seed>
    return rand_seed & RAND_MAX;
   44382:	8b 05 84 3c 01 00    	mov    0x13c84(%rip),%eax        # 5800c <rand_seed>
   44388:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4438d:	5d                   	pop    %rbp
   4438e:	c3                   	ret    

000000000004438f <srand>:

void srand(unsigned seed) {
   4438f:	f3 0f 1e fa          	endbr64 
   44393:	55                   	push   %rbp
   44394:	48 89 e5             	mov    %rsp,%rbp
   44397:	48 83 ec 08          	sub    $0x8,%rsp
   4439b:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   4439e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   443a1:	89 05 65 3c 01 00    	mov    %eax,0x13c65(%rip)        # 5800c <rand_seed>
    rand_seed_set = 1;
   443a7:	c7 05 57 3c 01 00 01 	movl   $0x1,0x13c57(%rip)        # 58008 <rand_seed_set>
   443ae:	00 00 00 
}
   443b1:	90                   	nop
   443b2:	c9                   	leave  
   443b3:	c3                   	ret    

00000000000443b4 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   443b4:	f3 0f 1e fa          	endbr64 
   443b8:	55                   	push   %rbp
   443b9:	48 89 e5             	mov    %rsp,%rbp
   443bc:	48 83 ec 28          	sub    $0x28,%rsp
   443c0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   443c4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   443c8:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   443cb:	48 8d 05 6e 1a 00 00 	lea    0x1a6e(%rip),%rax        # 45e40 <upper_digits.1>
   443d2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   443d6:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   443da:	79 0e                	jns    443ea <fill_numbuf+0x36>
        digits = lower_digits;
   443dc:	48 8d 05 7d 1a 00 00 	lea    0x1a7d(%rip),%rax        # 45e60 <lower_digits.0>
   443e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   443e7:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   443ea:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   443ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443f3:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   443f6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   443f9:	48 63 c8             	movslq %eax,%rcx
   443fc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44400:	ba 00 00 00 00       	mov    $0x0,%edx
   44405:	48 f7 f1             	div    %rcx
   44408:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4440c:	48 01 d0             	add    %rdx,%rax
   4440f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   44414:	0f b6 10             	movzbl (%rax),%edx
   44417:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4441b:	88 10                	mov    %dl,(%rax)
        val /= base;
   4441d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   44420:	48 63 f0             	movslq %eax,%rsi
   44423:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44427:	ba 00 00 00 00       	mov    $0x0,%edx
   4442c:	48 f7 f6             	div    %rsi
   4442f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   44433:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   44438:	75 bc                	jne    443f6 <fill_numbuf+0x42>
    return numbuf_end;
   4443a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4443e:	c9                   	leave  
   4443f:	c3                   	ret    

0000000000044440 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   44440:	f3 0f 1e fa          	endbr64 
   44444:	55                   	push   %rbp
   44445:	48 89 e5             	mov    %rsp,%rbp
   44448:	53                   	push   %rbx
   44449:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   44450:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   44457:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   4445d:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44464:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   4446b:	e9 bd 09 00 00       	jmp    44e2d <printer_vprintf+0x9ed>
        if (*format != '%') {
   44470:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44477:	0f b6 00             	movzbl (%rax),%eax
   4447a:	3c 25                	cmp    $0x25,%al
   4447c:	74 31                	je     444af <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   4447e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44485:	4c 8b 00             	mov    (%rax),%r8
   44488:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4448f:	0f b6 00             	movzbl (%rax),%eax
   44492:	0f b6 c8             	movzbl %al,%ecx
   44495:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4449b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   444a2:	89 ce                	mov    %ecx,%esi
   444a4:	48 89 c7             	mov    %rax,%rdi
   444a7:	41 ff d0             	call   *%r8
            continue;
   444aa:	e9 76 09 00 00       	jmp    44e25 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   444af:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   444b6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   444bd:	01 
   444be:	eb 4d                	jmp    4450d <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   444c0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   444c7:	0f b6 00             	movzbl (%rax),%eax
   444ca:	0f be c0             	movsbl %al,%eax
   444cd:	89 c6                	mov    %eax,%esi
   444cf:	48 8d 05 6a 18 00 00 	lea    0x186a(%rip),%rax        # 45d40 <flag_chars>
   444d6:	48 89 c7             	mov    %rax,%rdi
   444d9:	e8 23 fe ff ff       	call   44301 <strchr>
   444de:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   444e2:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   444e7:	74 34                	je     4451d <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   444e9:	48 8d 15 50 18 00 00 	lea    0x1850(%rip),%rdx        # 45d40 <flag_chars>
   444f0:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   444f4:	48 29 d0             	sub    %rdx,%rax
   444f7:	ba 01 00 00 00       	mov    $0x1,%edx
   444fc:	89 c1                	mov    %eax,%ecx
   444fe:	d3 e2                	shl    %cl,%edx
   44500:	89 d0                	mov    %edx,%eax
   44502:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   44505:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4450c:	01 
   4450d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44514:	0f b6 00             	movzbl (%rax),%eax
   44517:	84 c0                	test   %al,%al
   44519:	75 a5                	jne    444c0 <printer_vprintf+0x80>
   4451b:	eb 01                	jmp    4451e <printer_vprintf+0xde>
            } else {
                break;
   4451d:	90                   	nop
            }
        }

        // process width
        int width = -1;
   4451e:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   44525:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4452c:	0f b6 00             	movzbl (%rax),%eax
   4452f:	3c 30                	cmp    $0x30,%al
   44531:	7e 67                	jle    4459a <printer_vprintf+0x15a>
   44533:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4453a:	0f b6 00             	movzbl (%rax),%eax
   4453d:	3c 39                	cmp    $0x39,%al
   4453f:	7f 59                	jg     4459a <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44541:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   44548:	eb 2e                	jmp    44578 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   4454a:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4454d:	89 d0                	mov    %edx,%eax
   4454f:	c1 e0 02             	shl    $0x2,%eax
   44552:	01 d0                	add    %edx,%eax
   44554:	01 c0                	add    %eax,%eax
   44556:	89 c1                	mov    %eax,%ecx
   44558:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4455f:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44563:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4456a:	0f b6 00             	movzbl (%rax),%eax
   4456d:	0f be c0             	movsbl %al,%eax
   44570:	01 c8                	add    %ecx,%eax
   44572:	83 e8 30             	sub    $0x30,%eax
   44575:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44578:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4457f:	0f b6 00             	movzbl (%rax),%eax
   44582:	3c 2f                	cmp    $0x2f,%al
   44584:	0f 8e 85 00 00 00    	jle    4460f <printer_vprintf+0x1cf>
   4458a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44591:	0f b6 00             	movzbl (%rax),%eax
   44594:	3c 39                	cmp    $0x39,%al
   44596:	7e b2                	jle    4454a <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   44598:	eb 75                	jmp    4460f <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   4459a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   445a1:	0f b6 00             	movzbl (%rax),%eax
   445a4:	3c 2a                	cmp    $0x2a,%al
   445a6:	75 68                	jne    44610 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   445a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445af:	8b 00                	mov    (%rax),%eax
   445b1:	83 f8 2f             	cmp    $0x2f,%eax
   445b4:	77 30                	ja     445e6 <printer_vprintf+0x1a6>
   445b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445bd:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445c8:	8b 00                	mov    (%rax),%eax
   445ca:	89 c0                	mov    %eax,%eax
   445cc:	48 01 d0             	add    %rdx,%rax
   445cf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445d6:	8b 12                	mov    (%rdx),%edx
   445d8:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445db:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445e2:	89 0a                	mov    %ecx,(%rdx)
   445e4:	eb 1a                	jmp    44600 <printer_vprintf+0x1c0>
   445e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445ed:	48 8b 40 08          	mov    0x8(%rax),%rax
   445f1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445f5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445fc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44600:	8b 00                	mov    (%rax),%eax
   44602:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   44605:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4460c:	01 
   4460d:	eb 01                	jmp    44610 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   4460f:	90                   	nop
        }

        // process precision
        int precision = -1;
   44610:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   44617:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4461e:	0f b6 00             	movzbl (%rax),%eax
   44621:	3c 2e                	cmp    $0x2e,%al
   44623:	0f 85 00 01 00 00    	jne    44729 <printer_vprintf+0x2e9>
            ++format;
   44629:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44630:	01 
            if (*format >= '0' && *format <= '9') {
   44631:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44638:	0f b6 00             	movzbl (%rax),%eax
   4463b:	3c 2f                	cmp    $0x2f,%al
   4463d:	7e 67                	jle    446a6 <printer_vprintf+0x266>
   4463f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44646:	0f b6 00             	movzbl (%rax),%eax
   44649:	3c 39                	cmp    $0x39,%al
   4464b:	7f 59                	jg     446a6 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4464d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   44654:	eb 2e                	jmp    44684 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   44656:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   44659:	89 d0                	mov    %edx,%eax
   4465b:	c1 e0 02             	shl    $0x2,%eax
   4465e:	01 d0                	add    %edx,%eax
   44660:	01 c0                	add    %eax,%eax
   44662:	89 c1                	mov    %eax,%ecx
   44664:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4466b:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4466f:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44676:	0f b6 00             	movzbl (%rax),%eax
   44679:	0f be c0             	movsbl %al,%eax
   4467c:	01 c8                	add    %ecx,%eax
   4467e:	83 e8 30             	sub    $0x30,%eax
   44681:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44684:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4468b:	0f b6 00             	movzbl (%rax),%eax
   4468e:	3c 2f                	cmp    $0x2f,%al
   44690:	0f 8e 85 00 00 00    	jle    4471b <printer_vprintf+0x2db>
   44696:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4469d:	0f b6 00             	movzbl (%rax),%eax
   446a0:	3c 39                	cmp    $0x39,%al
   446a2:	7e b2                	jle    44656 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   446a4:	eb 75                	jmp    4471b <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   446a6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   446ad:	0f b6 00             	movzbl (%rax),%eax
   446b0:	3c 2a                	cmp    $0x2a,%al
   446b2:	75 68                	jne    4471c <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   446b4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446bb:	8b 00                	mov    (%rax),%eax
   446bd:	83 f8 2f             	cmp    $0x2f,%eax
   446c0:	77 30                	ja     446f2 <printer_vprintf+0x2b2>
   446c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446c9:	48 8b 50 10          	mov    0x10(%rax),%rdx
   446cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446d4:	8b 00                	mov    (%rax),%eax
   446d6:	89 c0                	mov    %eax,%eax
   446d8:	48 01 d0             	add    %rdx,%rax
   446db:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446e2:	8b 12                	mov    (%rdx),%edx
   446e4:	8d 4a 08             	lea    0x8(%rdx),%ecx
   446e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446ee:	89 0a                	mov    %ecx,(%rdx)
   446f0:	eb 1a                	jmp    4470c <printer_vprintf+0x2cc>
   446f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446f9:	48 8b 40 08          	mov    0x8(%rax),%rax
   446fd:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44701:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44708:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4470c:	8b 00                	mov    (%rax),%eax
   4470e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   44711:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44718:	01 
   44719:	eb 01                	jmp    4471c <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   4471b:	90                   	nop
            }
            if (precision < 0) {
   4471c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44720:	79 07                	jns    44729 <printer_vprintf+0x2e9>
                precision = 0;
   44722:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   44729:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   44730:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   44737:	00 
        int length = 0;
   44738:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   4473f:	48 8d 05 00 16 00 00 	lea    0x1600(%rip),%rax        # 45d46 <flag_chars+0x6>
   44746:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   4474a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44751:	0f b6 00             	movzbl (%rax),%eax
   44754:	0f be c0             	movsbl %al,%eax
   44757:	83 e8 43             	sub    $0x43,%eax
   4475a:	83 f8 37             	cmp    $0x37,%eax
   4475d:	0f 87 b6 03 00 00    	ja     44b19 <printer_vprintf+0x6d9>
   44763:	89 c0                	mov    %eax,%eax
   44765:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   4476c:	00 
   4476d:	48 8d 05 e0 15 00 00 	lea    0x15e0(%rip),%rax        # 45d54 <flag_chars+0x14>
   44774:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   44777:	48 98                	cltq   
   44779:	48 8d 15 d4 15 00 00 	lea    0x15d4(%rip),%rdx        # 45d54 <flag_chars+0x14>
   44780:	48 01 d0             	add    %rdx,%rax
   44783:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   44786:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   4478d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44794:	01 
            goto again;
   44795:	eb b3                	jmp    4474a <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   44797:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4479b:	74 5d                	je     447fa <printer_vprintf+0x3ba>
   4479d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447a4:	8b 00                	mov    (%rax),%eax
   447a6:	83 f8 2f             	cmp    $0x2f,%eax
   447a9:	77 30                	ja     447db <printer_vprintf+0x39b>
   447ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447b2:	48 8b 50 10          	mov    0x10(%rax),%rdx
   447b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447bd:	8b 00                	mov    (%rax),%eax
   447bf:	89 c0                	mov    %eax,%eax
   447c1:	48 01 d0             	add    %rdx,%rax
   447c4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447cb:	8b 12                	mov    (%rdx),%edx
   447cd:	8d 4a 08             	lea    0x8(%rdx),%ecx
   447d0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447d7:	89 0a                	mov    %ecx,(%rdx)
   447d9:	eb 1a                	jmp    447f5 <printer_vprintf+0x3b5>
   447db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447e2:	48 8b 40 08          	mov    0x8(%rax),%rax
   447e6:	48 8d 48 08          	lea    0x8(%rax),%rcx
   447ea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447f1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   447f5:	48 8b 00             	mov    (%rax),%rax
   447f8:	eb 5c                	jmp    44856 <printer_vprintf+0x416>
   447fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44801:	8b 00                	mov    (%rax),%eax
   44803:	83 f8 2f             	cmp    $0x2f,%eax
   44806:	77 30                	ja     44838 <printer_vprintf+0x3f8>
   44808:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4480f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44813:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4481a:	8b 00                	mov    (%rax),%eax
   4481c:	89 c0                	mov    %eax,%eax
   4481e:	48 01 d0             	add    %rdx,%rax
   44821:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44828:	8b 12                	mov    (%rdx),%edx
   4482a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4482d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44834:	89 0a                	mov    %ecx,(%rdx)
   44836:	eb 1a                	jmp    44852 <printer_vprintf+0x412>
   44838:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4483f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44843:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44847:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4484e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44852:	8b 00                	mov    (%rax),%eax
   44854:	48 98                	cltq   
   44856:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4485a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4485e:	48 c1 f8 38          	sar    $0x38,%rax
   44862:	25 80 00 00 00       	and    $0x80,%eax
   44867:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   4486a:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   4486e:	74 09                	je     44879 <printer_vprintf+0x439>
   44870:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44874:	48 f7 d8             	neg    %rax
   44877:	eb 04                	jmp    4487d <printer_vprintf+0x43d>
   44879:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4487d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   44881:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   44884:	83 c8 60             	or     $0x60,%eax
   44887:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   4488a:	e9 cf 02 00 00       	jmp    44b5e <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   4488f:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44893:	74 5d                	je     448f2 <printer_vprintf+0x4b2>
   44895:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4489c:	8b 00                	mov    (%rax),%eax
   4489e:	83 f8 2f             	cmp    $0x2f,%eax
   448a1:	77 30                	ja     448d3 <printer_vprintf+0x493>
   448a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448aa:	48 8b 50 10          	mov    0x10(%rax),%rdx
   448ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448b5:	8b 00                	mov    (%rax),%eax
   448b7:	89 c0                	mov    %eax,%eax
   448b9:	48 01 d0             	add    %rdx,%rax
   448bc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   448c3:	8b 12                	mov    (%rdx),%edx
   448c5:	8d 4a 08             	lea    0x8(%rdx),%ecx
   448c8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   448cf:	89 0a                	mov    %ecx,(%rdx)
   448d1:	eb 1a                	jmp    448ed <printer_vprintf+0x4ad>
   448d3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448da:	48 8b 40 08          	mov    0x8(%rax),%rax
   448de:	48 8d 48 08          	lea    0x8(%rax),%rcx
   448e2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   448e9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   448ed:	48 8b 00             	mov    (%rax),%rax
   448f0:	eb 5c                	jmp    4494e <printer_vprintf+0x50e>
   448f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448f9:	8b 00                	mov    (%rax),%eax
   448fb:	83 f8 2f             	cmp    $0x2f,%eax
   448fe:	77 30                	ja     44930 <printer_vprintf+0x4f0>
   44900:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44907:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4490b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44912:	8b 00                	mov    (%rax),%eax
   44914:	89 c0                	mov    %eax,%eax
   44916:	48 01 d0             	add    %rdx,%rax
   44919:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44920:	8b 12                	mov    (%rdx),%edx
   44922:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44925:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4492c:	89 0a                	mov    %ecx,(%rdx)
   4492e:	eb 1a                	jmp    4494a <printer_vprintf+0x50a>
   44930:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44937:	48 8b 40 08          	mov    0x8(%rax),%rax
   4493b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4493f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44946:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4494a:	8b 00                	mov    (%rax),%eax
   4494c:	89 c0                	mov    %eax,%eax
   4494e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   44952:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44956:	e9 03 02 00 00       	jmp    44b5e <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   4495b:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   44962:	e9 28 ff ff ff       	jmp    4488f <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   44967:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   4496e:	e9 1c ff ff ff       	jmp    4488f <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44973:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4497a:	8b 00                	mov    (%rax),%eax
   4497c:	83 f8 2f             	cmp    $0x2f,%eax
   4497f:	77 30                	ja     449b1 <printer_vprintf+0x571>
   44981:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44988:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4498c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44993:	8b 00                	mov    (%rax),%eax
   44995:	89 c0                	mov    %eax,%eax
   44997:	48 01 d0             	add    %rdx,%rax
   4499a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   449a1:	8b 12                	mov    (%rdx),%edx
   449a3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   449a6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   449ad:	89 0a                	mov    %ecx,(%rdx)
   449af:	eb 1a                	jmp    449cb <printer_vprintf+0x58b>
   449b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   449b8:	48 8b 40 08          	mov    0x8(%rax),%rax
   449bc:	48 8d 48 08          	lea    0x8(%rax),%rcx
   449c0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   449c7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449cb:	48 8b 00             	mov    (%rax),%rax
   449ce:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   449d2:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   449d9:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   449e0:	e9 79 01 00 00       	jmp    44b5e <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   449e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   449ec:	8b 00                	mov    (%rax),%eax
   449ee:	83 f8 2f             	cmp    $0x2f,%eax
   449f1:	77 30                	ja     44a23 <printer_vprintf+0x5e3>
   449f3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   449fa:	48 8b 50 10          	mov    0x10(%rax),%rdx
   449fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a05:	8b 00                	mov    (%rax),%eax
   44a07:	89 c0                	mov    %eax,%eax
   44a09:	48 01 d0             	add    %rdx,%rax
   44a0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a13:	8b 12                	mov    (%rdx),%edx
   44a15:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44a18:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a1f:	89 0a                	mov    %ecx,(%rdx)
   44a21:	eb 1a                	jmp    44a3d <printer_vprintf+0x5fd>
   44a23:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a2a:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a2e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44a32:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a39:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a3d:	48 8b 00             	mov    (%rax),%rax
   44a40:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   44a44:	e9 15 01 00 00       	jmp    44b5e <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   44a49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a50:	8b 00                	mov    (%rax),%eax
   44a52:	83 f8 2f             	cmp    $0x2f,%eax
   44a55:	77 30                	ja     44a87 <printer_vprintf+0x647>
   44a57:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a5e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44a62:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a69:	8b 00                	mov    (%rax),%eax
   44a6b:	89 c0                	mov    %eax,%eax
   44a6d:	48 01 d0             	add    %rdx,%rax
   44a70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a77:	8b 12                	mov    (%rdx),%edx
   44a79:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44a7c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a83:	89 0a                	mov    %ecx,(%rdx)
   44a85:	eb 1a                	jmp    44aa1 <printer_vprintf+0x661>
   44a87:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a8e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a92:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44a96:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a9d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44aa1:	8b 00                	mov    (%rax),%eax
   44aa3:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   44aa9:	e9 77 03 00 00       	jmp    44e25 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   44aae:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44ab2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44ab6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44abd:	8b 00                	mov    (%rax),%eax
   44abf:	83 f8 2f             	cmp    $0x2f,%eax
   44ac2:	77 30                	ja     44af4 <printer_vprintf+0x6b4>
   44ac4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44acb:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44acf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44ad6:	8b 00                	mov    (%rax),%eax
   44ad8:	89 c0                	mov    %eax,%eax
   44ada:	48 01 d0             	add    %rdx,%rax
   44add:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44ae4:	8b 12                	mov    (%rdx),%edx
   44ae6:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44ae9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44af0:	89 0a                	mov    %ecx,(%rdx)
   44af2:	eb 1a                	jmp    44b0e <printer_vprintf+0x6ce>
   44af4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44afb:	48 8b 40 08          	mov    0x8(%rax),%rax
   44aff:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44b03:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44b0a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44b0e:	8b 00                	mov    (%rax),%eax
   44b10:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44b13:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   44b17:	eb 45                	jmp    44b5e <printer_vprintf+0x71e>
        default:
            data = numbuf;
   44b19:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44b1d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   44b21:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44b28:	0f b6 00             	movzbl (%rax),%eax
   44b2b:	84 c0                	test   %al,%al
   44b2d:	74 0c                	je     44b3b <printer_vprintf+0x6fb>
   44b2f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44b36:	0f b6 00             	movzbl (%rax),%eax
   44b39:	eb 05                	jmp    44b40 <printer_vprintf+0x700>
   44b3b:	b8 25 00 00 00       	mov    $0x25,%eax
   44b40:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44b43:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   44b47:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44b4e:	0f b6 00             	movzbl (%rax),%eax
   44b51:	84 c0                	test   %al,%al
   44b53:	75 08                	jne    44b5d <printer_vprintf+0x71d>
                format--;
   44b55:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44b5c:	01 
            }
            break;
   44b5d:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44b5e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44b61:	83 e0 20             	and    $0x20,%eax
   44b64:	85 c0                	test   %eax,%eax
   44b66:	74 1e                	je     44b86 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   44b68:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44b6c:	48 83 c0 18          	add    $0x18,%rax
   44b70:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44b73:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44b77:	48 89 ce             	mov    %rcx,%rsi
   44b7a:	48 89 c7             	mov    %rax,%rdi
   44b7d:	e8 32 f8 ff ff       	call   443b4 <fill_numbuf>
   44b82:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44b86:	48 8d 05 b9 11 00 00 	lea    0x11b9(%rip),%rax        # 45d46 <flag_chars+0x6>
   44b8d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44b91:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44b94:	83 e0 20             	and    $0x20,%eax
   44b97:	85 c0                	test   %eax,%eax
   44b99:	74 51                	je     44bec <printer_vprintf+0x7ac>
   44b9b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44b9e:	83 e0 40             	and    $0x40,%eax
   44ba1:	85 c0                	test   %eax,%eax
   44ba3:	74 47                	je     44bec <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   44ba5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44ba8:	25 80 00 00 00       	and    $0x80,%eax
   44bad:	85 c0                	test   %eax,%eax
   44baf:	74 0d                	je     44bbe <printer_vprintf+0x77e>
                prefix = "-";
   44bb1:	48 8d 05 8f 11 00 00 	lea    0x118f(%rip),%rax        # 45d47 <flag_chars+0x7>
   44bb8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44bbc:	eb 7d                	jmp    44c3b <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44bbe:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44bc1:	83 e0 10             	and    $0x10,%eax
   44bc4:	85 c0                	test   %eax,%eax
   44bc6:	74 0d                	je     44bd5 <printer_vprintf+0x795>
                prefix = "+";
   44bc8:	48 8d 05 7a 11 00 00 	lea    0x117a(%rip),%rax        # 45d49 <flag_chars+0x9>
   44bcf:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44bd3:	eb 66                	jmp    44c3b <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44bd5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44bd8:	83 e0 08             	and    $0x8,%eax
   44bdb:	85 c0                	test   %eax,%eax
   44bdd:	74 5c                	je     44c3b <printer_vprintf+0x7fb>
                prefix = " ";
   44bdf:	48 8d 05 65 11 00 00 	lea    0x1165(%rip),%rax        # 45d4b <flag_chars+0xb>
   44be6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44bea:	eb 4f                	jmp    44c3b <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44bec:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44bef:	83 e0 20             	and    $0x20,%eax
   44bf2:	85 c0                	test   %eax,%eax
   44bf4:	74 46                	je     44c3c <printer_vprintf+0x7fc>
   44bf6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44bf9:	83 e0 01             	and    $0x1,%eax
   44bfc:	85 c0                	test   %eax,%eax
   44bfe:	74 3c                	je     44c3c <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   44c00:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   44c04:	74 06                	je     44c0c <printer_vprintf+0x7cc>
   44c06:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44c0a:	75 30                	jne    44c3c <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   44c0c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44c11:	75 0c                	jne    44c1f <printer_vprintf+0x7df>
   44c13:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c16:	25 00 01 00 00       	and    $0x100,%eax
   44c1b:	85 c0                	test   %eax,%eax
   44c1d:	74 1d                	je     44c3c <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   44c1f:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44c23:	75 09                	jne    44c2e <printer_vprintf+0x7ee>
   44c25:	48 8d 05 21 11 00 00 	lea    0x1121(%rip),%rax        # 45d4d <flag_chars+0xd>
   44c2c:	eb 07                	jmp    44c35 <printer_vprintf+0x7f5>
   44c2e:	48 8d 05 1b 11 00 00 	lea    0x111b(%rip),%rax        # 45d50 <flag_chars+0x10>
   44c35:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44c39:	eb 01                	jmp    44c3c <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   44c3b:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44c3c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44c40:	78 24                	js     44c66 <printer_vprintf+0x826>
   44c42:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c45:	83 e0 20             	and    $0x20,%eax
   44c48:	85 c0                	test   %eax,%eax
   44c4a:	75 1a                	jne    44c66 <printer_vprintf+0x826>
            len = strnlen(data, precision);
   44c4c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44c4f:	48 63 d0             	movslq %eax,%rdx
   44c52:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44c56:	48 89 d6             	mov    %rdx,%rsi
   44c59:	48 89 c7             	mov    %rax,%rdi
   44c5c:	e8 91 f5 ff ff       	call   441f2 <strnlen>
   44c61:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44c64:	eb 0f                	jmp    44c75 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   44c66:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44c6a:	48 89 c7             	mov    %rax,%rdi
   44c6d:	e8 4b f5 ff ff       	call   441bd <strlen>
   44c72:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44c75:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c78:	83 e0 20             	and    $0x20,%eax
   44c7b:	85 c0                	test   %eax,%eax
   44c7d:	74 20                	je     44c9f <printer_vprintf+0x85f>
   44c7f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44c83:	78 1a                	js     44c9f <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   44c85:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44c88:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44c8b:	7e 08                	jle    44c95 <printer_vprintf+0x855>
   44c8d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44c90:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44c93:	eb 05                	jmp    44c9a <printer_vprintf+0x85a>
   44c95:	b8 00 00 00 00       	mov    $0x0,%eax
   44c9a:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44c9d:	eb 5c                	jmp    44cfb <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44c9f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44ca2:	83 e0 20             	and    $0x20,%eax
   44ca5:	85 c0                	test   %eax,%eax
   44ca7:	74 4b                	je     44cf4 <printer_vprintf+0x8b4>
   44ca9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44cac:	83 e0 02             	and    $0x2,%eax
   44caf:	85 c0                	test   %eax,%eax
   44cb1:	74 41                	je     44cf4 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44cb3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44cb6:	83 e0 04             	and    $0x4,%eax
   44cb9:	85 c0                	test   %eax,%eax
   44cbb:	75 37                	jne    44cf4 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   44cbd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44cc1:	48 89 c7             	mov    %rax,%rdi
   44cc4:	e8 f4 f4 ff ff       	call   441bd <strlen>
   44cc9:	89 c2                	mov    %eax,%edx
   44ccb:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44cce:	01 d0                	add    %edx,%eax
   44cd0:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44cd3:	7e 1f                	jle    44cf4 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   44cd5:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44cd8:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44cdb:	89 c3                	mov    %eax,%ebx
   44cdd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44ce1:	48 89 c7             	mov    %rax,%rdi
   44ce4:	e8 d4 f4 ff ff       	call   441bd <strlen>
   44ce9:	89 c2                	mov    %eax,%edx
   44ceb:	89 d8                	mov    %ebx,%eax
   44ced:	29 d0                	sub    %edx,%eax
   44cef:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44cf2:	eb 07                	jmp    44cfb <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   44cf4:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44cfb:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44cfe:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44d01:	01 d0                	add    %edx,%eax
   44d03:	48 63 d8             	movslq %eax,%rbx
   44d06:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44d0a:	48 89 c7             	mov    %rax,%rdi
   44d0d:	e8 ab f4 ff ff       	call   441bd <strlen>
   44d12:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   44d16:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44d19:	29 d0                	sub    %edx,%eax
   44d1b:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44d1e:	eb 25                	jmp    44d45 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   44d20:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d27:	48 8b 08             	mov    (%rax),%rcx
   44d2a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44d30:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d37:	be 20 00 00 00       	mov    $0x20,%esi
   44d3c:	48 89 c7             	mov    %rax,%rdi
   44d3f:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44d41:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44d45:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44d48:	83 e0 04             	and    $0x4,%eax
   44d4b:	85 c0                	test   %eax,%eax
   44d4d:	75 36                	jne    44d85 <printer_vprintf+0x945>
   44d4f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44d53:	7f cb                	jg     44d20 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   44d55:	eb 2e                	jmp    44d85 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   44d57:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d5e:	4c 8b 00             	mov    (%rax),%r8
   44d61:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44d65:	0f b6 00             	movzbl (%rax),%eax
   44d68:	0f b6 c8             	movzbl %al,%ecx
   44d6b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44d71:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d78:	89 ce                	mov    %ecx,%esi
   44d7a:	48 89 c7             	mov    %rax,%rdi
   44d7d:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44d80:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44d85:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44d89:	0f b6 00             	movzbl (%rax),%eax
   44d8c:	84 c0                	test   %al,%al
   44d8e:	75 c7                	jne    44d57 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   44d90:	eb 25                	jmp    44db7 <printer_vprintf+0x977>
            p->putc(p, '0', color);
   44d92:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d99:	48 8b 08             	mov    (%rax),%rcx
   44d9c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44da2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44da9:	be 30 00 00 00       	mov    $0x30,%esi
   44dae:	48 89 c7             	mov    %rax,%rdi
   44db1:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44db3:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44db7:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44dbb:	7f d5                	jg     44d92 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   44dbd:	eb 32                	jmp    44df1 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   44dbf:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44dc6:	4c 8b 00             	mov    (%rax),%r8
   44dc9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44dcd:	0f b6 00             	movzbl (%rax),%eax
   44dd0:	0f b6 c8             	movzbl %al,%ecx
   44dd3:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44dd9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44de0:	89 ce                	mov    %ecx,%esi
   44de2:	48 89 c7             	mov    %rax,%rdi
   44de5:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   44de8:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44ded:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44df1:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44df5:	7f c8                	jg     44dbf <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   44df7:	eb 25                	jmp    44e1e <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   44df9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44e00:	48 8b 08             	mov    (%rax),%rcx
   44e03:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44e09:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44e10:	be 20 00 00 00       	mov    $0x20,%esi
   44e15:	48 89 c7             	mov    %rax,%rdi
   44e18:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44e1a:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44e1e:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44e22:	7f d5                	jg     44df9 <printer_vprintf+0x9b9>
        }
    done: ;
   44e24:	90                   	nop
    for (; *format; ++format) {
   44e25:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44e2c:	01 
   44e2d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44e34:	0f b6 00             	movzbl (%rax),%eax
   44e37:	84 c0                	test   %al,%al
   44e39:	0f 85 31 f6 ff ff    	jne    44470 <printer_vprintf+0x30>
    }
}
   44e3f:	90                   	nop
   44e40:	90                   	nop
   44e41:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44e45:	c9                   	leave  
   44e46:	c3                   	ret    

0000000000044e47 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   44e47:	f3 0f 1e fa          	endbr64 
   44e4b:	55                   	push   %rbp
   44e4c:	48 89 e5             	mov    %rsp,%rbp
   44e4f:	48 83 ec 20          	sub    $0x20,%rsp
   44e53:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44e57:	89 f0                	mov    %esi,%eax
   44e59:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44e5c:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44e5f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44e63:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44e67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44e6b:	48 8b 40 08          	mov    0x8(%rax),%rax
   44e6f:	48 8d 15 2a 41 07 00 	lea    0x7412a(%rip),%rdx        # b8fa0 <console+0xfa0>
   44e76:	48 39 d0             	cmp    %rdx,%rax
   44e79:	72 0f                	jb     44e8a <console_putc+0x43>
        cp->cursor = console;
   44e7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44e7f:	48 8d 15 7a 31 07 00 	lea    0x7317a(%rip),%rdx        # b8000 <console>
   44e86:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   44e8a:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44e8e:	0f 85 82 00 00 00    	jne    44f16 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   44e94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44e98:	48 8b 40 08          	mov    0x8(%rax),%rax
   44e9c:	48 8d 15 5d 31 07 00 	lea    0x7315d(%rip),%rdx        # b8000 <console>
   44ea3:	48 29 d0             	sub    %rdx,%rax
   44ea6:	48 d1 f8             	sar    %rax
   44ea9:	48 89 c1             	mov    %rax,%rcx
   44eac:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44eb3:	66 66 66 
   44eb6:	48 89 c8             	mov    %rcx,%rax
   44eb9:	48 f7 ea             	imul   %rdx
   44ebc:	48 89 d0             	mov    %rdx,%rax
   44ebf:	48 c1 f8 05          	sar    $0x5,%rax
   44ec3:	48 89 ce             	mov    %rcx,%rsi
   44ec6:	48 c1 fe 3f          	sar    $0x3f,%rsi
   44eca:	48 29 f0             	sub    %rsi,%rax
   44ecd:	48 89 c2             	mov    %rax,%rdx
   44ed0:	48 89 d0             	mov    %rdx,%rax
   44ed3:	48 c1 e0 02          	shl    $0x2,%rax
   44ed7:	48 01 d0             	add    %rdx,%rax
   44eda:	48 c1 e0 04          	shl    $0x4,%rax
   44ede:	48 29 c1             	sub    %rax,%rcx
   44ee1:	48 89 ca             	mov    %rcx,%rdx
   44ee4:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44ee7:	eb 25                	jmp    44f0e <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   44ee9:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44eec:	83 c8 20             	or     $0x20,%eax
   44eef:	89 c6                	mov    %eax,%esi
   44ef1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44ef5:	48 8b 40 08          	mov    0x8(%rax),%rax
   44ef9:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44efd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44f01:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44f05:	89 f2                	mov    %esi,%edx
   44f07:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44f0a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44f0e:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44f12:	75 d5                	jne    44ee9 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44f14:	eb 24                	jmp    44f3a <console_putc+0xf3>
        *cp->cursor++ = c | color;
   44f16:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44f1a:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44f1d:	89 d6                	mov    %edx,%esi
   44f1f:	09 c6                	or     %eax,%esi
   44f21:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44f25:	48 8b 40 08          	mov    0x8(%rax),%rax
   44f29:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44f2d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44f31:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44f35:	89 f2                	mov    %esi,%edx
   44f37:	66 89 10             	mov    %dx,(%rax)
}
   44f3a:	90                   	nop
   44f3b:	c9                   	leave  
   44f3c:	c3                   	ret    

0000000000044f3d <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44f3d:	f3 0f 1e fa          	endbr64 
   44f41:	55                   	push   %rbp
   44f42:	48 89 e5             	mov    %rsp,%rbp
   44f45:	48 83 ec 30          	sub    $0x30,%rsp
   44f49:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44f4c:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44f4f:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44f53:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44f57:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 44e47 <console_putc>
   44f5e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44f62:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44f66:	78 09                	js     44f71 <console_vprintf+0x34>
   44f68:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44f6f:	7e 07                	jle    44f78 <console_vprintf+0x3b>
        cpos = 0;
   44f71:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44f78:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44f7b:	48 98                	cltq   
   44f7d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44f81:	48 8d 05 78 30 07 00 	lea    0x73078(%rip),%rax        # b8000 <console>
   44f88:	48 01 d0             	add    %rdx,%rax
   44f8b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44f8f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44f93:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44f97:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44f9a:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44f9e:	48 89 c7             	mov    %rax,%rdi
   44fa1:	e8 9a f4 ff ff       	call   44440 <printer_vprintf>
    return cp.cursor - console;
   44fa6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44faa:	48 8d 15 4f 30 07 00 	lea    0x7304f(%rip),%rdx        # b8000 <console>
   44fb1:	48 29 d0             	sub    %rdx,%rax
   44fb4:	48 d1 f8             	sar    %rax
}
   44fb7:	c9                   	leave  
   44fb8:	c3                   	ret    

0000000000044fb9 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44fb9:	f3 0f 1e fa          	endbr64 
   44fbd:	55                   	push   %rbp
   44fbe:	48 89 e5             	mov    %rsp,%rbp
   44fc1:	48 83 ec 60          	sub    $0x60,%rsp
   44fc5:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44fc8:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44fcb:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44fcf:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44fd3:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44fd7:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44fdb:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44fe2:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44fe6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44fea:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44fee:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44ff2:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44ff6:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44ffa:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44ffd:	8b 45 ac             	mov    -0x54(%rbp),%eax
   45000:	89 c7                	mov    %eax,%edi
   45002:	e8 36 ff ff ff       	call   44f3d <console_vprintf>
   45007:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4500a:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4500d:	c9                   	leave  
   4500e:	c3                   	ret    

000000000004500f <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   4500f:	f3 0f 1e fa          	endbr64 
   45013:	55                   	push   %rbp
   45014:	48 89 e5             	mov    %rsp,%rbp
   45017:	48 83 ec 20          	sub    $0x20,%rsp
   4501b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4501f:	89 f0                	mov    %esi,%eax
   45021:	89 55 e0             	mov    %edx,-0x20(%rbp)
   45024:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   45027:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4502b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   4502f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   45033:	48 8b 50 08          	mov    0x8(%rax),%rdx
   45037:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4503b:	48 8b 40 10          	mov    0x10(%rax),%rax
   4503f:	48 39 c2             	cmp    %rax,%rdx
   45042:	73 1a                	jae    4505e <string_putc+0x4f>
        *sp->s++ = c;
   45044:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   45048:	48 8b 40 08          	mov    0x8(%rax),%rax
   4504c:	48 8d 48 01          	lea    0x1(%rax),%rcx
   45050:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   45054:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   45058:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   4505c:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   4505e:	90                   	nop
   4505f:	c9                   	leave  
   45060:	c3                   	ret    

0000000000045061 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   45061:	f3 0f 1e fa          	endbr64 
   45065:	55                   	push   %rbp
   45066:	48 89 e5             	mov    %rsp,%rbp
   45069:	48 83 ec 40          	sub    $0x40,%rsp
   4506d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   45071:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   45075:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   45079:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   4507d:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 4500f <string_putc>
   45084:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   45088:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4508c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   45090:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   45095:	74 33                	je     450ca <vsnprintf+0x69>
        sp.end = s + size - 1;
   45097:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4509b:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4509f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   450a3:	48 01 d0             	add    %rdx,%rax
   450a6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   450aa:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   450ae:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   450b2:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   450b6:	be 00 00 00 00       	mov    $0x0,%esi
   450bb:	48 89 c7             	mov    %rax,%rdi
   450be:	e8 7d f3 ff ff       	call   44440 <printer_vprintf>
        *sp.s = 0;
   450c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   450c7:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   450ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   450ce:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   450d2:	c9                   	leave  
   450d3:	c3                   	ret    

00000000000450d4 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   450d4:	f3 0f 1e fa          	endbr64 
   450d8:	55                   	push   %rbp
   450d9:	48 89 e5             	mov    %rsp,%rbp
   450dc:	48 83 ec 70          	sub    $0x70,%rsp
   450e0:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   450e4:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   450e8:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   450ec:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   450f0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   450f4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   450f8:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   450ff:	48 8d 45 10          	lea    0x10(%rbp),%rax
   45103:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   45107:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4510b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   4510f:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   45113:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   45117:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   4511b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4511f:	48 89 c7             	mov    %rax,%rdi
   45122:	e8 3a ff ff ff       	call   45061 <vsnprintf>
   45127:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   4512a:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   4512d:	c9                   	leave  
   4512e:	c3                   	ret    

000000000004512f <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   4512f:	f3 0f 1e fa          	endbr64 
   45133:	55                   	push   %rbp
   45134:	48 89 e5             	mov    %rsp,%rbp
   45137:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4513b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   45142:	eb 1a                	jmp    4515e <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   45144:	8b 45 fc             	mov    -0x4(%rbp),%eax
   45147:	48 98                	cltq   
   45149:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4514d:	48 8d 05 ac 2e 07 00 	lea    0x72eac(%rip),%rax        # b8000 <console>
   45154:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4515a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4515e:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   45165:	7e dd                	jle    45144 <console_clear+0x15>
    }
    cursorpos = 0;
   45167:	c7 05 8b 3e 07 00 00 	movl   $0x0,0x73e8b(%rip)        # b8ffc <cursorpos>
   4516e:	00 00 00 
}
   45171:	90                   	nop
   45172:	c9                   	leave  
   45173:	c3                   	ret    
