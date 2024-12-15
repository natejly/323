
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
   400be:	e8 32 07 00 00       	call   407f5 <exception>

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
   40177:	e8 14 17 00 00       	call   41890 <hardware_init>
    pageinfo_init();
   4017c:	e8 1f 0c 00 00       	call   40da0 <pageinfo_init>
    console_clear();
   40181:	e8 96 4f 00 00       	call   4511c <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 68 1c 00 00       	call   41df8 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 5f de 00 00 	lea    0xde5f(%rip),%rax        # 4e000 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 be 3f 00 00       	call   44167 <memset>
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
   40210:	48 8d 15 8f 4f 00 00 	lea    0x4f8f(%rip),%rdx        # 451a6 <memstate_colors+0x26>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 4e 40 00 00       	call   44270 <strcmp>
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
   40252:	e8 19 40 00 00       	call   44270 <strcmp>
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
   40287:	e8 e4 3f 00 00       	call   44270 <strcmp>
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
   402b9:	e8 b2 3f 00 00       	call   44270 <strcmp>
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
   402ff:	e8 f4 09 00 00       	call   40cf8 <run>

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
   4033c:	e8 6a 1d 00 00       	call   420ab <process_init>
    assert(process_config_tables(pid) == 0);
   40341:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40344:	89 c7                	mov    %eax,%edi
   40346:	e8 dd 35 00 00       	call   43928 <process_config_tables>
   4034b:	85 c0                	test   %eax,%eax
   4034d:	74 1e                	je     4036d <process_setup+0x69>
   4034f:	48 8d 05 72 4e 00 00 	lea    0x4e72(%rip),%rax        # 451c8 <memstate_colors+0x48>
   40356:	48 89 c2             	mov    %rax,%rdx
   40359:	be 77 00 00 00       	mov    $0x77,%esi
   4035e:	48 8d 05 83 4e 00 00 	lea    0x4e83(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40365:	48 89 c7             	mov    %rax,%rdi
   40368:	e8 74 25 00 00       	call   428e1 <assert_fail>

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
   40393:	e8 de 38 00 00       	call   43c76 <process_load>
   40398:	85 c0                	test   %eax,%eax
   4039a:	79 1e                	jns    403ba <process_setup+0xb6>
   4039c:	48 8d 05 55 4e 00 00 	lea    0x4e55(%rip),%rax        # 451f8 <memstate_colors+0x78>
   403a3:	48 89 c2             	mov    %rax,%rdx
   403a6:	be 7a 00 00 00       	mov    $0x7a,%esi
   403ab:	48 8d 05 36 4e 00 00 	lea    0x4e36(%rip),%rax        # 451e8 <memstate_colors+0x68>
   403b2:	48 89 c7             	mov    %rax,%rdi
   403b5:	e8 27 25 00 00       	call   428e1 <assert_fail>

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
   403db:	e8 ce 38 00 00       	call   43cae <process_setup_stack>

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
   404a7:	e8 b5 38 00 00       	call   43d61 <process_fork>
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
   404c1:	e8 80 31 00 00       	call   43646 <process_free>
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
   404ea:	e8 04 3b 00 00       	call   43ff3 <process_page_alloc>
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
    // Validate that new_brk is within the allowable range
    if (new_brk < p->original_break || new_brk >= MEMSIZE_VIRTUAL - PAGESIZE) {
   40505:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40509:	48 8b 40 10          	mov    0x10(%rax),%rax
   4050d:	48 39 45 a0          	cmp    %rax,-0x60(%rbp)
   40511:	72 0a                	jb     4051d <syscall_brk+0x2c>
   40513:	48 81 7d a0 ff ef 2f 	cmpq   $0x2fefff,-0x60(%rbp)
   4051a:	00 
   4051b:	76 0a                	jbe    40527 <syscall_brk+0x36>
        return -1;  // Error: break below heap start or beyond stack
   4051d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40522:	e9 23 01 00 00       	jmp    4064a <syscall_brk+0x159>
    }

    uintptr_t old_brk = p->program_break;
   40527:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4052b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4052f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    // Grow the heap lazily
    if (new_brk > old_brk) {
   40533:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   40537:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   4053b:	0f 87 f8 00 00 00    	ja     40639 <syscall_brk+0x148>
        //     }
        // }
    }

    // Shrink the heap and unmap pages
    else if (new_brk < old_brk) {
   40541:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   40545:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   40549:	0f 83 ea 00 00 00    	jae    40639 <syscall_brk+0x148>
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
   40582:	eb 7c                	jmp    40600 <syscall_brk+0x10f>
            vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   40584:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40588:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4058f:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40593:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40597:	48 89 ce             	mov    %rcx,%rsi
   4059a:	48 89 c7             	mov    %rax,%rdi
   4059d:	e8 0f 2b 00 00       	call   430b1 <virtual_memory_lookup>
            if (map.pn >= 0) {
   405a2:	8b 45 b8             	mov    -0x48(%rbp),%eax
   405a5:	85 c0                	test   %eax,%eax
   405a7:	78 4f                	js     405f8 <syscall_brk+0x107>
                virtual_memory_map(p->p_pagetable, addr, 0, PAGESIZE, 0);
   405a9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   405ad:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   405b4:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   405b8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   405be:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405c3:	ba 00 00 00 00       	mov    $0x0,%edx
   405c8:	48 89 c7             	mov    %rax,%rdi
   405cb:	e8 95 26 00 00       	call   42c65 <virtual_memory_map>
                pageinfo[map.pn].refcount = 0;
   405d0:	8b 45 b8             	mov    -0x48(%rbp),%eax
   405d3:	48 98                	cltq   
   405d5:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   405d9:	48 8d 05 41 e9 00 00 	lea    0xe941(%rip),%rax        # 4ef21 <pageinfo+0x1>
   405e0:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[map.pn].owner = PO_FREE;
   405e4:	8b 45 b8             	mov    -0x48(%rbp),%eax
   405e7:	48 98                	cltq   
   405e9:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   405ed:	48 8d 05 2c e9 00 00 	lea    0xe92c(%rip),%rax        # 4ef20 <pageinfo>
   405f4:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        for (uintptr_t addr = ROUNDUP(new_brk, PAGESIZE); addr < ROUNDUP(old_brk, PAGESIZE); addr += PAGESIZE) {
   405f8:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   405ff:	00 
   40600:	48 c7 45 d8 00 10 00 	movq   $0x1000,-0x28(%rbp)
   40607:	00 
   40608:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4060c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40610:	48 01 d0             	add    %rdx,%rax
   40613:	48 83 e8 01          	sub    $0x1,%rax
   40617:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   4061b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4061f:	ba 00 00 00 00       	mov    $0x0,%edx
   40624:	48 f7 75 d8          	divq   -0x28(%rbp)
   40628:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4062c:	48 29 d0             	sub    %rdx,%rax
   4062f:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
   40633:	0f 87 4b ff ff ff    	ja     40584 <syscall_brk+0x93>
            }
        }
    }

    p->program_break = new_brk; // Update program break
   40639:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4063d:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   40641:	48 89 50 08          	mov    %rdx,0x8(%rax)
    return 0;
   40645:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4064a:	c9                   	leave  
   4064b:	c3                   	ret    

000000000004064c <syscall_sbrk>:


intptr_t syscall_sbrk(proc* p, intptr_t difference) {
   4064c:	f3 0f 1e fa          	endbr64 
   40650:	55                   	push   %rbp
   40651:	48 89 e5             	mov    %rsp,%rbp
   40654:	48 83 ec 20          	sub    $0x20,%rsp
   40658:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4065c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    uintptr_t old_brk = p->program_break;
   40660:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40664:	48 8b 40 08          	mov    0x8(%rax),%rax
   40668:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t new_brk = old_brk + difference;
   4066c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40670:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40674:	48 01 d0             	add    %rdx,%rax
   40677:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    if (syscall_brk(p, new_brk) != 0) {
   4067b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4067f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40683:	48 89 d6             	mov    %rdx,%rsi
   40686:	48 89 c7             	mov    %rax,%rdi
   40689:	e8 63 fe ff ff       	call   404f1 <syscall_brk>
   4068e:	85 c0                	test   %eax,%eax
   40690:	74 09                	je     4069b <syscall_sbrk+0x4f>
        return -1;  // Failed to adjust break
   40692:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   40699:	eb 04                	jmp    4069f <syscall_sbrk+0x53>
    }

    return old_brk; // Return previous program break
   4069b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   4069f:	c9                   	leave  
   406a0:	c3                   	ret    

00000000000406a1 <syscall_mapping>:



void syscall_mapping(proc* p){
   406a1:	f3 0f 1e fa          	endbr64 
   406a5:	55                   	push   %rbp
   406a6:	48 89 e5             	mov    %rsp,%rbp
   406a9:	48 83 ec 70          	sub    $0x70,%rsp
   406ad:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   406b1:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406b5:	48 8b 40 48          	mov    0x48(%rax),%rax
   406b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   406bd:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406c1:	48 8b 40 40          	mov    0x40(%rax),%rax
   406c5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   406c9:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406cd:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406d4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   406d8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   406dc:	48 89 ce             	mov    %rcx,%rsi
   406df:	48 89 c7             	mov    %rax,%rdi
   406e2:	e8 ca 29 00 00       	call   430b1 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   406e7:	8b 45 e0             	mov    -0x20(%rbp),%eax
   406ea:	48 98                	cltq   
   406ec:	83 e0 06             	and    $0x6,%eax
   406ef:	48 83 f8 06          	cmp    $0x6,%rax
   406f3:	0f 85 89 00 00 00    	jne    40782 <syscall_mapping+0xe1>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   406f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   406fd:	48 83 c0 17          	add    $0x17,%rax
   40701:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (PAGENUMBER(endaddr) != PAGENUMBER(ptr)){
   40705:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40709:	48 c1 e8 0c          	shr    $0xc,%rax
   4070d:	89 c2                	mov    %eax,%edx
   4070f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40713:	48 c1 e8 0c          	shr    $0xc,%rax
   40717:	39 c2                	cmp    %eax,%edx
   40719:	74 2c                	je     40747 <syscall_mapping+0xa6>
        vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   4071b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4071f:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40726:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4072a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4072e:	48 89 ce             	mov    %rcx,%rsi
   40731:	48 89 c7             	mov    %rax,%rdi
   40734:	e8 78 29 00 00       	call   430b1 <virtual_memory_lookup>
        // check for write access for end address
        if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40739:	8b 45 b0             	mov    -0x50(%rbp),%eax
   4073c:	48 98                	cltq   
   4073e:	83 e0 03             	and    $0x3,%eax
   40741:	48 83 f8 03          	cmp    $0x3,%rax
   40745:	75 3e                	jne    40785 <syscall_mapping+0xe4>
            return; 
    }
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40747:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4074b:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40752:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40756:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4075a:	48 89 ce             	mov    %rcx,%rsi
   4075d:	48 89 c7             	mov    %rax,%rdi
   40760:	e8 4c 29 00 00       	call   430b1 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40765:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40769:	48 89 c1             	mov    %rax,%rcx
   4076c:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40770:	ba 18 00 00 00       	mov    $0x18,%edx
   40775:	48 89 c6             	mov    %rax,%rsi
   40778:	48 89 cf             	mov    %rcx,%rdi
   4077b:	e8 e1 38 00 00       	call   44061 <memcpy>
   40780:	eb 04                	jmp    40786 <syscall_mapping+0xe5>
        return;
   40782:	90                   	nop
   40783:	eb 01                	jmp    40786 <syscall_mapping+0xe5>
            return; 
   40785:	90                   	nop
}
   40786:	c9                   	leave  
   40787:	c3                   	ret    

0000000000040788 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40788:	f3 0f 1e fa          	endbr64 
   4078c:	55                   	push   %rbp
   4078d:	48 89 e5             	mov    %rsp,%rbp
   40790:	48 83 ec 18          	sub    $0x18,%rsp
   40794:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40798:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4079c:	48 8b 40 48          	mov    0x48(%rax),%rax
   407a0:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   407a3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   407a7:	75 14                	jne    407bd <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   407a9:	0f b6 05 50 58 00 00 	movzbl 0x5850(%rip),%eax        # 46000 <disp_global>
   407b0:	84 c0                	test   %al,%al
   407b2:	0f 94 c0             	sete   %al
   407b5:	88 05 45 58 00 00    	mov    %al,0x5845(%rip)        # 46000 <disp_global>
   407bb:	eb 36                	jmp    407f3 <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   407bd:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   407c1:	78 2f                	js     407f2 <syscall_mem_tog+0x6a>
   407c3:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   407c7:	7f 29                	jg     407f2 <syscall_mem_tog+0x6a>
   407c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407cd:	8b 00                	mov    (%rax),%eax
   407cf:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   407d2:	75 1e                	jne    407f2 <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   407d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407d8:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   407df:	84 c0                	test   %al,%al
   407e1:	0f 94 c0             	sete   %al
   407e4:	89 c2                	mov    %eax,%edx
   407e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407ea:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   407f0:	eb 01                	jmp    407f3 <syscall_mem_tog+0x6b>
            return;
   407f2:	90                   	nop
    }
}
   407f3:	c9                   	leave  
   407f4:	c3                   	ret    

00000000000407f5 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   407f5:	f3 0f 1e fa          	endbr64 
   407f9:	55                   	push   %rbp
   407fa:	48 89 e5             	mov    %rsp,%rbp
   407fd:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   40804:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   4080b:	48 8b 05 ee e6 00 00 	mov    0xe6ee(%rip),%rax        # 4ef00 <current>
   40812:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   40819:	48 83 c0 18          	add    $0x18,%rax
   4081d:	48 89 d6             	mov    %rdx,%rsi
   40820:	ba 18 00 00 00       	mov    $0x18,%edx
   40825:	48 89 c7             	mov    %rax,%rdi
   40828:	48 89 d1             	mov    %rdx,%rcx
   4082b:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   4082e:	48 8b 05 cb 07 01 00 	mov    0x107cb(%rip),%rax        # 51000 <kernel_pagetable>
   40835:	48 89 c7             	mov    %rax,%rdi
   40838:	e8 b6 22 00 00       	call   42af3 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   4083d:	8b 05 b9 87 07 00    	mov    0x787b9(%rip),%eax        # b8ffc <cursorpos>
   40843:	89 c7                	mov    %eax,%edi
   40845:	e8 2f 19 00 00       	call   42179 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   4084a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40851:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40858:	48 83 f8 0e          	cmp    $0xe,%rax
   4085c:	74 14                	je     40872 <exception+0x7d>
	    && reg->reg_intno != INT_GPF)
   4085e:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40865:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4086c:	48 83 f8 0d          	cmp    $0xd,%rax
   40870:	75 16                	jne    40888 <exception+0x93>
            || (reg->reg_err & PFERR_USER)) {
   40872:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40879:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40880:	83 e0 04             	and    $0x4,%eax
   40883:	48 85 c0             	test   %rax,%rax
   40886:	74 1a                	je     408a2 <exception+0xad>
        check_virtual_memory();
   40888:	e8 3d 09 00 00       	call   411ca <check_virtual_memory>
        if(disp_global){
   4088d:	0f b6 05 6c 57 00 00 	movzbl 0x576c(%rip),%eax        # 46000 <disp_global>
   40894:	84 c0                	test   %al,%al
   40896:	74 0a                	je     408a2 <exception+0xad>
            memshow_physical();
   40898:	e8 f6 0a 00 00       	call   41393 <memshow_physical>
            memshow_virtual_animate();
   4089d:	e8 93 0e 00 00       	call   41735 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   408a2:	e8 e8 1d 00 00       	call   4268f <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   408a7:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   408ae:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   408b5:	48 83 e8 0e          	sub    $0xe,%rax
   408b9:	48 83 f8 2c          	cmp    $0x2c,%rax
   408bd:	0f 87 7d 03 00 00    	ja     40c40 <exception+0x44b>
   408c3:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   408ca:	00 
   408cb:	48 8d 05 e6 49 00 00 	lea    0x49e6(%rip),%rax        # 452b8 <memstate_colors+0x138>
   408d2:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   408d5:	48 98                	cltq   
   408d7:	48 8d 15 da 49 00 00 	lea    0x49da(%rip),%rdx        # 452b8 <memstate_colors+0x138>
   408de:	48 01 d0             	add    %rdx,%rax
   408e1:	3e ff e0             	notrack jmp *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   408e4:	48 8b 05 15 e6 00 00 	mov    0xe615(%rip),%rax        # 4ef00 <current>
   408eb:	48 8b 40 48          	mov    0x48(%rax),%rax
   408ef:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                    if((void *)addr == NULL)
   408f3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   408f8:	75 0f                	jne    40909 <exception+0x114>
                        kernel_panic(NULL);
   408fa:	bf 00 00 00 00       	mov    $0x0,%edi
   408ff:	b8 00 00 00 00       	mov    $0x0,%eax
   40904:	e8 e8 1e 00 00       	call   427f1 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40909:	48 8b 05 f0 e5 00 00 	mov    0xe5f0(%rip),%rax        # 4ef00 <current>
   40910:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40917:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   4091b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4091f:	48 89 ce             	mov    %rcx,%rsi
   40922:	48 89 c7             	mov    %rax,%rdi
   40925:	e8 87 27 00 00       	call   430b1 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   4092a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4092e:	48 89 c1             	mov    %rax,%rcx
   40931:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   40938:	ba a0 00 00 00       	mov    $0xa0,%edx
   4093d:	48 89 ce             	mov    %rcx,%rsi
   40940:	48 89 c7             	mov    %rax,%rdi
   40943:	e8 19 37 00 00       	call   44061 <memcpy>
                    kernel_panic(msg);
   40948:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   4094f:	48 89 c7             	mov    %rax,%rdi
   40952:	b8 00 00 00 00       	mov    $0x0,%eax
   40957:	e8 95 1e 00 00       	call   427f1 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   4095c:	48 8b 05 9d e5 00 00 	mov    0xe59d(%rip),%rax        # 4ef00 <current>
   40963:	8b 10                	mov    (%rax),%edx
   40965:	48 8b 05 94 e5 00 00 	mov    0xe594(%rip),%rax        # 4ef00 <current>
   4096c:	48 63 d2             	movslq %edx,%rdx
   4096f:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40973:	e9 d8 02 00 00       	jmp    40c50 <exception+0x45b>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   40978:	b8 00 00 00 00       	mov    $0x0,%eax
   4097d:	e8 13 fb ff ff       	call   40495 <syscall_fork>
   40982:	89 c2                	mov    %eax,%edx
   40984:	48 8b 05 75 e5 00 00 	mov    0xe575(%rip),%rax        # 4ef00 <current>
   4098b:	48 63 d2             	movslq %edx,%rdx
   4098e:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40992:	e9 b9 02 00 00       	jmp    40c50 <exception+0x45b>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   40997:	48 8b 05 62 e5 00 00 	mov    0xe562(%rip),%rax        # 4ef00 <current>
   4099e:	48 89 c7             	mov    %rax,%rdi
   409a1:	e8 fb fc ff ff       	call   406a1 <syscall_mapping>
                break;
   409a6:	e9 a5 02 00 00       	jmp    40c50 <exception+0x45b>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   409ab:	b8 00 00 00 00       	mov    $0x0,%eax
   409b0:	e8 f9 fa ff ff       	call   404ae <syscall_exit>
                schedule();
   409b5:	e8 bf 02 00 00       	call   40c79 <schedule>
                break;
   409ba:	e9 91 02 00 00       	jmp    40c50 <exception+0x45b>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   409bf:	e8 b5 02 00 00       	call   40c79 <schedule>
                break;                  /* will not be reached */
   409c4:	e9 87 02 00 00       	jmp    40c50 <exception+0x45b>
            }

    case INT_SYS_BRK:
        current->p_registers.reg_rax = syscall_brk(current, current->p_registers.reg_rdi);
   409c9:	48 8b 05 30 e5 00 00 	mov    0xe530(%rip),%rax        # 4ef00 <current>
   409d0:	48 8b 50 48          	mov    0x48(%rax),%rdx
   409d4:	48 8b 05 25 e5 00 00 	mov    0xe525(%rip),%rax        # 4ef00 <current>
   409db:	48 89 d6             	mov    %rdx,%rsi
   409de:	48 89 c7             	mov    %rax,%rdi
   409e1:	e8 0b fb ff ff       	call   404f1 <syscall_brk>
   409e6:	89 c2                	mov    %eax,%edx
   409e8:	48 8b 05 11 e5 00 00 	mov    0xe511(%rip),%rax        # 4ef00 <current>
   409ef:	48 63 d2             	movslq %edx,%rdx
   409f2:	48 89 50 18          	mov    %rdx,0x18(%rax)
        break;
   409f6:	e9 55 02 00 00       	jmp    40c50 <exception+0x45b>

    case INT_SYS_SBRK:
        current->p_registers.reg_rax = syscall_sbrk(current, current->p_registers.reg_rdi);
   409fb:	48 8b 05 fe e4 00 00 	mov    0xe4fe(%rip),%rax        # 4ef00 <current>
   40a02:	48 8b 40 48          	mov    0x48(%rax),%rax
   40a06:	48 89 c2             	mov    %rax,%rdx
   40a09:	48 8b 05 f0 e4 00 00 	mov    0xe4f0(%rip),%rax        # 4ef00 <current>
   40a10:	48 89 d6             	mov    %rdx,%rsi
   40a13:	48 89 c7             	mov    %rax,%rdi
   40a16:	e8 31 fc ff ff       	call   4064c <syscall_sbrk>
   40a1b:	48 89 c2             	mov    %rax,%rdx
   40a1e:	48 8b 05 db e4 00 00 	mov    0xe4db(%rip),%rax        # 4ef00 <current>
   40a25:	48 89 50 18          	mov    %rdx,0x18(%rax)
        break;
   40a29:	e9 22 02 00 00       	jmp    40c50 <exception+0x45b>

	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   40a2e:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a35:	48 8b 40 30          	mov    0x30(%rax),%rax
   40a39:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		syscall_page_alloc(addr);
   40a3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a41:	48 89 c7             	mov    %rax,%rdi
   40a44:	e8 80 fa ff ff       	call   404c9 <syscall_page_alloc>
		break;
   40a49:	e9 02 02 00 00       	jmp    40c50 <exception+0x45b>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40a4e:	48 8b 05 ab e4 00 00 	mov    0xe4ab(%rip),%rax        # 4ef00 <current>
   40a55:	48 89 c7             	mov    %rax,%rdi
   40a58:	e8 2b fd ff ff       	call   40788 <syscall_mem_tog>
                break;
   40a5d:	e9 ee 01 00 00       	jmp    40c50 <exception+0x45b>
            }

        case INT_TIMER:
            {
                ++ticks;
   40a62:	8b 05 b8 e8 00 00    	mov    0xe8b8(%rip),%eax        # 4f320 <ticks>
   40a68:	83 c0 01             	add    $0x1,%eax
   40a6b:	89 05 af e8 00 00    	mov    %eax,0xe8af(%rip)        # 4f320 <ticks>
                schedule();
   40a71:	e8 03 02 00 00       	call   40c79 <schedule>
                break;                  /* will not be reached */
   40a76:	e9 d5 01 00 00       	jmp    40c50 <exception+0x45b>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40a7b:	0f 20 d0             	mov    %cr2,%rax
   40a7e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    return val;
   40a82:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
            }

case INT_PAGEFAULT: 
{
    uintptr_t addr = rcr2();  // Address that caused the fault
   40a86:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    const char* operation = reg->reg_err & PFERR_WRITE ? "write" : "read";
   40a8a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a91:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a98:	83 e0 02             	and    $0x2,%eax
   40a9b:	48 85 c0             	test   %rax,%rax
   40a9e:	74 09                	je     40aa9 <exception+0x2b4>
   40aa0:	48 8d 05 84 47 00 00 	lea    0x4784(%rip),%rax        # 4522b <memstate_colors+0xab>
   40aa7:	eb 07                	jmp    40ab0 <exception+0x2bb>
   40aa9:	48 8d 05 81 47 00 00 	lea    0x4781(%rip),%rax        # 45231 <memstate_colors+0xb1>
   40ab0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    const char* problem = reg->reg_err & PFERR_PRESENT ? "protection problem" : "missing page";
   40ab4:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40abb:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ac2:	83 e0 01             	and    $0x1,%eax
   40ac5:	48 85 c0             	test   %rax,%rax
   40ac8:	74 09                	je     40ad3 <exception+0x2de>
   40aca:	48 8d 05 65 47 00 00 	lea    0x4765(%rip),%rax        # 45236 <memstate_colors+0xb6>
   40ad1:	eb 07                	jmp    40ada <exception+0x2e5>
   40ad3:	48 8d 05 6f 47 00 00 	lea    0x476f(%rip),%rax        # 45249 <memstate_colors+0xc9>
   40ada:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Check if the fault occurred in user space
    if (!(reg->reg_err & PFERR_USER)) {
   40ade:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40ae5:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40aec:	83 e0 04             	and    $0x4,%eax
   40aef:	48 85 c0             	test   %rax,%rax
   40af2:	75 34                	jne    40b28 <exception+0x333>
        kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40af4:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40afb:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40b02:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   40b06:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40b0a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40b0e:	49 89 f0             	mov    %rsi,%r8
   40b11:	48 89 c6             	mov    %rax,%rsi
   40b14:	48 8d 05 3d 47 00 00 	lea    0x473d(%rip),%rax        # 45258 <memstate_colors+0xd8>
   40b1b:	48 89 c7             	mov    %rax,%rdi
   40b1e:	b8 00 00 00 00       	mov    $0x0,%eax
   40b23:	e8 c9 1c 00 00       	call   427f1 <kernel_panic>
                     addr, operation, problem, reg->reg_rip);
    }

    // Check if the faulting address is within the process's heap
    if (addr >= current->original_break && addr < current->program_break) {
   40b28:	48 8b 05 d1 e3 00 00 	mov    0xe3d1(%rip),%rax        # 4ef00 <current>
   40b2f:	48 8b 40 10          	mov    0x10(%rax),%rax
   40b33:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40b37:	0f 82 99 00 00 00    	jb     40bd6 <exception+0x3e1>
   40b3d:	48 8b 05 bc e3 00 00 	mov    0xe3bc(%rip),%rax        # 4ef00 <current>
   40b44:	48 8b 40 08          	mov    0x8(%rax),%rax
   40b48:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40b4c:	0f 83 84 00 00 00    	jae    40bd6 <exception+0x3e1>
        uintptr_t faulting_page = addr & ~(PAGESIZE - 1); // Align to page boundary
   40b52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40b56:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40b5c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        uintptr_t pa = (uintptr_t) palloc(current->p_pid);
   40b60:	48 8b 05 99 e3 00 00 	mov    0xe399(%rip),%rax        # 4ef00 <current>
   40b67:	8b 00                	mov    (%rax),%eax
   40b69:	89 c7                	mov    %eax,%edi
   40b6b:	e8 bd 29 00 00       	call   4352d <palloc>
   40b70:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        // If physical page allocation fails, kill the process
        if (!pa || virtual_memory_map(current->p_pagetable, faulting_page, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   40b74:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40b79:	74 2d                	je     40ba8 <exception+0x3b3>
   40b7b:	48 8b 05 7e e3 00 00 	mov    0xe37e(%rip),%rax        # 4ef00 <current>
   40b82:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40b89:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40b8d:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40b91:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40b97:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40b9c:	48 89 c7             	mov    %rax,%rdi
   40b9f:	e8 c1 20 00 00       	call   42c65 <virtual_memory_map>
   40ba4:	85 c0                	test   %eax,%eax
   40ba6:	79 1b                	jns    40bc3 <exception+0x3ce>
            current->p_state = P_BROKEN;
   40ba8:	48 8b 05 51 e3 00 00 	mov    0xe351(%rip),%rax        # 4ef00 <current>
   40baf:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40bb6:	00 00 00 
            syscall_exit();
   40bb9:	b8 00 00 00 00       	mov    $0x0,%eax
   40bbe:	e8 eb f8 ff ff       	call   404ae <syscall_exit>
        }

        // Set the process state back to runnable and resume execution
        current->p_state = P_RUNNABLE;
   40bc3:	48 8b 05 36 e3 00 00 	mov    0xe336(%rip),%rax        # 4ef00 <current>
   40bca:	c7 80 d8 00 00 00 01 	movl   $0x1,0xd8(%rax)
   40bd1:	00 00 00 
        break;
   40bd4:	eb 7a                	jmp    40c50 <exception+0x45b>
    }

    // If the fault is outside the heap, treat it as an error
    console_printf(CPOS(24, 0), 0x0C00,
   40bd6:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40bdd:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                   "Process %d page fault for %p (%s %s, rip=%p)!\n",
                   current->p_pid, addr, operation, problem, reg->reg_rip);
   40be4:	48 8b 05 15 e3 00 00 	mov    0xe315(%rip),%rax        # 4ef00 <current>
    console_printf(CPOS(24, 0), 0x0C00,
   40beb:	8b 00                	mov    (%rax),%eax
   40bed:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   40bf1:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   40bf5:	52                   	push   %rdx
   40bf6:	ff 75 d8             	push   -0x28(%rbp)
   40bf9:	49 89 f1             	mov    %rsi,%r9
   40bfc:	49 89 c8             	mov    %rcx,%r8
   40bff:	89 c1                	mov    %eax,%ecx
   40c01:	48 8d 05 80 46 00 00 	lea    0x4680(%rip),%rax        # 45288 <memstate_colors+0x108>
   40c08:	48 89 c2             	mov    %rax,%rdx
   40c0b:	be 00 0c 00 00       	mov    $0xc00,%esi
   40c10:	bf 80 07 00 00       	mov    $0x780,%edi
   40c15:	b8 00 00 00 00       	mov    $0x0,%eax
   40c1a:	e8 87 43 00 00       	call   44fa6 <console_printf>
   40c1f:	48 83 c4 10          	add    $0x10,%rsp
    current->p_state = P_BROKEN;
   40c23:	48 8b 05 d6 e2 00 00 	mov    0xe2d6(%rip),%rax        # 4ef00 <current>
   40c2a:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40c31:	00 00 00 
    syscall_exit();
   40c34:	b8 00 00 00 00       	mov    $0x0,%eax
   40c39:	e8 70 f8 ff ff       	call   404ae <syscall_exit>
    break;
   40c3e:	eb 10                	jmp    40c50 <exception+0x45b>
}



        default:
            default_exception(current);
   40c40:	48 8b 05 b9 e2 00 00 	mov    0xe2b9(%rip),%rax        # 4ef00 <current>
   40c47:	48 89 c7             	mov    %rax,%rdi
   40c4a:	e8 cb 1c 00 00       	call   4291a <default_exception>
            break;                  /* will not be reached */
   40c4f:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40c50:	48 8b 05 a9 e2 00 00 	mov    0xe2a9(%rip),%rax        # 4ef00 <current>
   40c57:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c5d:	83 f8 01             	cmp    $0x1,%eax
   40c60:	75 0f                	jne    40c71 <exception+0x47c>
        run(current);
   40c62:	48 8b 05 97 e2 00 00 	mov    0xe297(%rip),%rax        # 4ef00 <current>
   40c69:	48 89 c7             	mov    %rax,%rdi
   40c6c:	e8 87 00 00 00       	call   40cf8 <run>
    } else {
        schedule();
   40c71:	e8 03 00 00 00       	call   40c79 <schedule>
    }
}
   40c76:	90                   	nop
   40c77:	c9                   	leave  
   40c78:	c3                   	ret    

0000000000040c79 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40c79:	f3 0f 1e fa          	endbr64 
   40c7d:	55                   	push   %rbp
   40c7e:	48 89 e5             	mov    %rsp,%rbp
   40c81:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40c85:	48 8b 05 74 e2 00 00 	mov    0xe274(%rip),%rax        # 4ef00 <current>
   40c8c:	8b 00                	mov    (%rax),%eax
   40c8e:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40c91:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c94:	83 c0 01             	add    $0x1,%eax
   40c97:	99                   	cltd   
   40c98:	c1 ea 1c             	shr    $0x1c,%edx
   40c9b:	01 d0                	add    %edx,%eax
   40c9d:	83 e0 0f             	and    $0xf,%eax
   40ca0:	29 d0                	sub    %edx,%eax
   40ca2:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40ca5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ca8:	48 63 d0             	movslq %eax,%rdx
   40cab:	48 89 d0             	mov    %rdx,%rax
   40cae:	48 c1 e0 04          	shl    $0x4,%rax
   40cb2:	48 29 d0             	sub    %rdx,%rax
   40cb5:	48 c1 e0 04          	shl    $0x4,%rax
   40cb9:	48 89 c2             	mov    %rax,%rdx
   40cbc:	48 8d 05 15 d4 00 00 	lea    0xd415(%rip),%rax        # 4e0d8 <processes+0xd8>
   40cc3:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40cc6:	83 f8 01             	cmp    $0x1,%eax
   40cc9:	75 26                	jne    40cf1 <schedule+0x78>
            run(&processes[pid]);
   40ccb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cce:	48 63 d0             	movslq %eax,%rdx
   40cd1:	48 89 d0             	mov    %rdx,%rax
   40cd4:	48 c1 e0 04          	shl    $0x4,%rax
   40cd8:	48 29 d0             	sub    %rdx,%rax
   40cdb:	48 c1 e0 04          	shl    $0x4,%rax
   40cdf:	48 8d 15 1a d3 00 00 	lea    0xd31a(%rip),%rdx        # 4e000 <processes>
   40ce6:	48 01 d0             	add    %rdx,%rax
   40ce9:	48 89 c7             	mov    %rax,%rdi
   40cec:	e8 07 00 00 00       	call   40cf8 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40cf1:	e8 99 19 00 00       	call   4268f <check_keyboard>
        pid = (pid + 1) % NPROC;
   40cf6:	eb 99                	jmp    40c91 <schedule+0x18>

0000000000040cf8 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40cf8:	f3 0f 1e fa          	endbr64 
   40cfc:	55                   	push   %rbp
   40cfd:	48 89 e5             	mov    %rsp,%rbp
   40d00:	48 83 ec 10          	sub    $0x10,%rsp
   40d04:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40d08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d0c:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40d12:	83 f8 01             	cmp    $0x1,%eax
   40d15:	74 1e                	je     40d35 <run+0x3d>
   40d17:	48 8d 05 4e 46 00 00 	lea    0x464e(%rip),%rax        # 4536c <memstate_colors+0x1ec>
   40d1e:	48 89 c2             	mov    %rax,%rdx
   40d21:	be b2 01 00 00       	mov    $0x1b2,%esi
   40d26:	48 8d 05 bb 44 00 00 	lea    0x44bb(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40d2d:	48 89 c7             	mov    %rax,%rdi
   40d30:	e8 ac 1b 00 00       	call   428e1 <assert_fail>
    current = p;
   40d35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d39:	48 89 05 c0 e1 00 00 	mov    %rax,0xe1c0(%rip)        # 4ef00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40d40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d44:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40d46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d4a:	8b 00                	mov    (%rax),%eax
   40d4c:	83 c0 02             	add    $0x2,%eax
   40d4f:	48 98                	cltq   
   40d51:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40d55:	48 8d 05 24 44 00 00 	lea    0x4424(%rip),%rax        # 45180 <memstate_colors>
   40d5c:	0f b7 04 01          	movzwl (%rcx,%rax,1),%eax
    console_printf(CPOS(24, 79),
   40d60:	0f b7 c0             	movzwl %ax,%eax
   40d63:	89 d1                	mov    %edx,%ecx
   40d65:	48 8d 15 19 46 00 00 	lea    0x4619(%rip),%rdx        # 45385 <memstate_colors+0x205>
   40d6c:	89 c6                	mov    %eax,%esi
   40d6e:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40d73:	b8 00 00 00 00       	mov    $0x0,%eax
   40d78:	e8 29 42 00 00       	call   44fa6 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40d7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d81:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40d88:	48 89 c7             	mov    %rax,%rdi
   40d8b:	e8 63 1d 00 00       	call   42af3 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40d90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d94:	48 83 c0 18          	add    $0x18,%rax
   40d98:	48 89 c7             	mov    %rax,%rdi
   40d9b:	e8 23 f3 ff ff       	call   400c3 <exception_return>

0000000000040da0 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40da0:	f3 0f 1e fa          	endbr64 
   40da4:	55                   	push   %rbp
   40da5:	48 89 e5             	mov    %rsp,%rbp
   40da8:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40dac:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40db3:	00 
   40db4:	e9 93 00 00 00       	jmp    40e4c <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40db9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dbd:	48 89 c7             	mov    %rax,%rdi
   40dc0:	e8 04 11 00 00       	call   41ec9 <physical_memory_isreserved>
   40dc5:	85 c0                	test   %eax,%eax
   40dc7:	74 09                	je     40dd2 <pageinfo_init+0x32>
            owner = PO_RESERVED;
   40dc9:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40dd0:	eb 31                	jmp    40e03 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40dd2:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40dd9:	00 
   40dda:	76 0d                	jbe    40de9 <pageinfo_init+0x49>
   40ddc:	48 8d 05 2d 62 01 00 	lea    0x1622d(%rip),%rax        # 57010 <end>
   40de3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40de7:	72 0a                	jb     40df3 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40de9:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40df0:	00 
   40df1:	75 09                	jne    40dfc <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   40df3:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40dfa:	eb 07                	jmp    40e03 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   40dfc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40e03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e07:	48 c1 e8 0c          	shr    $0xc,%rax
   40e0b:	89 c2                	mov    %eax,%edx
   40e0d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e10:	89 c1                	mov    %eax,%ecx
   40e12:	48 63 c2             	movslq %edx,%rax
   40e15:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e19:	48 8d 05 00 e1 00 00 	lea    0xe100(%rip),%rax        # 4ef20 <pageinfo>
   40e20:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40e23:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40e27:	0f 95 c2             	setne  %dl
   40e2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e2e:	48 c1 e8 0c          	shr    $0xc,%rax
   40e32:	89 d1                	mov    %edx,%ecx
   40e34:	48 98                	cltq   
   40e36:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e3a:	48 8d 05 e0 e0 00 00 	lea    0xe0e0(%rip),%rax        # 4ef21 <pageinfo+0x1>
   40e41:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e44:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e4b:	00 
   40e4c:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40e53:	00 
   40e54:	0f 86 5f ff ff ff    	jbe    40db9 <pageinfo_init+0x19>
    }
}
   40e5a:	90                   	nop
   40e5b:	90                   	nop
   40e5c:	c9                   	leave  
   40e5d:	c3                   	ret    

0000000000040e5e <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40e5e:	f3 0f 1e fa          	endbr64 
   40e62:	55                   	push   %rbp
   40e63:	48 89 e5             	mov    %rsp,%rbp
   40e66:	48 83 ec 50          	sub    $0x50,%rsp
   40e6a:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40e6e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e72:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40e78:	48 89 c2             	mov    %rax,%rdx
   40e7b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e7f:	48 39 c2             	cmp    %rax,%rdx
   40e82:	74 1e                	je     40ea2 <check_page_table_mappings+0x44>
   40e84:	48 8d 05 fd 44 00 00 	lea    0x44fd(%rip),%rax        # 45388 <memstate_colors+0x208>
   40e8b:	48 89 c2             	mov    %rax,%rdx
   40e8e:	be e0 01 00 00       	mov    $0x1e0,%esi
   40e93:	48 8d 05 4e 43 00 00 	lea    0x434e(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40e9a:	48 89 c7             	mov    %rax,%rdi
   40e9d:	e8 3f 1a 00 00       	call   428e1 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40ea2:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40ea9:	00 
   40eaa:	e9 b5 00 00 00       	jmp    40f64 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40eaf:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40eb3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40eb7:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40ebb:	48 89 ce             	mov    %rcx,%rsi
   40ebe:	48 89 c7             	mov    %rax,%rdi
   40ec1:	e8 eb 21 00 00       	call   430b1 <virtual_memory_lookup>
        if (vam.pa != va) {
   40ec6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40eca:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ece:	74 2c                	je     40efc <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40ed0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40ed4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ed8:	49 89 d0             	mov    %rdx,%r8
   40edb:	48 89 c1             	mov    %rax,%rcx
   40ede:	48 8d 05 c2 44 00 00 	lea    0x44c2(%rip),%rax        # 453a7 <memstate_colors+0x227>
   40ee5:	48 89 c2             	mov    %rax,%rdx
   40ee8:	be 00 c0 00 00       	mov    $0xc000,%esi
   40eed:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40ef2:	b8 00 00 00 00       	mov    $0x0,%eax
   40ef7:	e8 aa 40 00 00       	call   44fa6 <console_printf>
        }
        assert(vam.pa == va);
   40efc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f00:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f04:	74 1e                	je     40f24 <check_page_table_mappings+0xc6>
   40f06:	48 8d 05 a4 44 00 00 	lea    0x44a4(%rip),%rax        # 453b1 <memstate_colors+0x231>
   40f0d:	48 89 c2             	mov    %rax,%rdx
   40f10:	be e9 01 00 00       	mov    $0x1e9,%esi
   40f15:	48 8d 05 cc 42 00 00 	lea    0x42cc(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40f1c:	48 89 c7             	mov    %rax,%rdi
   40f1f:	e8 bd 19 00 00       	call   428e1 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40f24:	48 8d 05 d5 50 00 00 	lea    0x50d5(%rip),%rax        # 46000 <disp_global>
   40f2b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f2f:	72 2b                	jb     40f5c <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   40f31:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f34:	48 98                	cltq   
   40f36:	83 e0 02             	and    $0x2,%eax
   40f39:	48 85 c0             	test   %rax,%rax
   40f3c:	75 1e                	jne    40f5c <check_page_table_mappings+0xfe>
   40f3e:	48 8d 05 79 44 00 00 	lea    0x4479(%rip),%rax        # 453be <memstate_colors+0x23e>
   40f45:	48 89 c2             	mov    %rax,%rdx
   40f48:	be eb 01 00 00       	mov    $0x1eb,%esi
   40f4d:	48 8d 05 94 42 00 00 	lea    0x4294(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40f54:	48 89 c7             	mov    %rax,%rdi
   40f57:	e8 85 19 00 00       	call   428e1 <assert_fail>
         va += PAGESIZE) {
   40f5c:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40f63:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40f64:	48 8d 05 a5 60 01 00 	lea    0x160a5(%rip),%rax        # 57010 <end>
   40f6b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f6f:	0f 82 3a ff ff ff    	jb     40eaf <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40f75:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40f7c:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40f7d:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40f81:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40f85:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f89:	48 89 ce             	mov    %rcx,%rsi
   40f8c:	48 89 c7             	mov    %rax,%rdi
   40f8f:	e8 1d 21 00 00       	call   430b1 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40f94:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40f98:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40f9c:	74 1e                	je     40fbc <check_page_table_mappings+0x15e>
   40f9e:	48 8d 05 2a 44 00 00 	lea    0x442a(%rip),%rax        # 453cf <memstate_colors+0x24f>
   40fa5:	48 89 c2             	mov    %rax,%rdx
   40fa8:	be f2 01 00 00       	mov    $0x1f2,%esi
   40fad:	48 8d 05 34 42 00 00 	lea    0x4234(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40fb4:	48 89 c7             	mov    %rax,%rdi
   40fb7:	e8 25 19 00 00       	call   428e1 <assert_fail>
    assert(vam.perm & PTE_W);
   40fbc:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40fbf:	48 98                	cltq   
   40fc1:	83 e0 02             	and    $0x2,%eax
   40fc4:	48 85 c0             	test   %rax,%rax
   40fc7:	75 1e                	jne    40fe7 <check_page_table_mappings+0x189>
   40fc9:	48 8d 05 ee 43 00 00 	lea    0x43ee(%rip),%rax        # 453be <memstate_colors+0x23e>
   40fd0:	48 89 c2             	mov    %rax,%rdx
   40fd3:	be f3 01 00 00       	mov    $0x1f3,%esi
   40fd8:	48 8d 05 09 42 00 00 	lea    0x4209(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40fdf:	48 89 c7             	mov    %rax,%rdi
   40fe2:	e8 fa 18 00 00       	call   428e1 <assert_fail>
}
   40fe7:	90                   	nop
   40fe8:	c9                   	leave  
   40fe9:	c3                   	ret    

0000000000040fea <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40fea:	f3 0f 1e fa          	endbr64 
   40fee:	55                   	push   %rbp
   40fef:	48 89 e5             	mov    %rsp,%rbp
   40ff2:	48 83 ec 20          	sub    $0x20,%rsp
   40ff6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40ffa:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40ffd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41000:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   41003:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   4100a:	48 8b 05 ef ff 00 00 	mov    0xffef(%rip),%rax        # 51000 <kernel_pagetable>
   41011:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41015:	75 71                	jne    41088 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   41017:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4101e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41025:	eb 5b                	jmp    41082 <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   41027:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4102a:	48 63 d0             	movslq %eax,%rdx
   4102d:	48 89 d0             	mov    %rdx,%rax
   41030:	48 c1 e0 04          	shl    $0x4,%rax
   41034:	48 29 d0             	sub    %rdx,%rax
   41037:	48 c1 e0 04          	shl    $0x4,%rax
   4103b:	48 89 c2             	mov    %rax,%rdx
   4103e:	48 8d 05 93 d0 00 00 	lea    0xd093(%rip),%rax        # 4e0d8 <processes+0xd8>
   41045:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41048:	85 c0                	test   %eax,%eax
   4104a:	74 32                	je     4107e <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   4104c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4104f:	48 63 d0             	movslq %eax,%rdx
   41052:	48 89 d0             	mov    %rdx,%rax
   41055:	48 c1 e0 04          	shl    $0x4,%rax
   41059:	48 29 d0             	sub    %rdx,%rax
   4105c:	48 c1 e0 04          	shl    $0x4,%rax
   41060:	48 89 c2             	mov    %rax,%rdx
   41063:	48 8d 05 76 d0 00 00 	lea    0xd076(%rip),%rax        # 4e0e0 <processes+0xe0>
   4106a:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   4106e:	48 8b 05 8b ff 00 00 	mov    0xff8b(%rip),%rax        # 51000 <kernel_pagetable>
   41075:	48 39 c2             	cmp    %rax,%rdx
   41078:	75 04                	jne    4107e <check_page_table_ownership+0x94>
                ++expected_refcount;
   4107a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4107e:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41082:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41086:	7e 9f                	jle    41027 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41088:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   4108b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4108e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41092:	be 00 00 00 00       	mov    $0x0,%esi
   41097:	48 89 c7             	mov    %rax,%rdi
   4109a:	e8 03 00 00 00       	call   410a2 <check_page_table_ownership_level>
}
   4109f:	90                   	nop
   410a0:	c9                   	leave  
   410a1:	c3                   	ret    

00000000000410a2 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   410a2:	f3 0f 1e fa          	endbr64 
   410a6:	55                   	push   %rbp
   410a7:	48 89 e5             	mov    %rsp,%rbp
   410aa:	48 83 ec 30          	sub    $0x30,%rsp
   410ae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   410b2:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   410b5:	89 55 e0             	mov    %edx,-0x20(%rbp)
   410b8:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   410bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410bf:	48 c1 e8 0c          	shr    $0xc,%rax
   410c3:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   410c8:	7e 1e                	jle    410e8 <check_page_table_ownership_level+0x46>
   410ca:	48 8d 05 0f 43 00 00 	lea    0x430f(%rip),%rax        # 453e0 <memstate_colors+0x260>
   410d1:	48 89 c2             	mov    %rax,%rdx
   410d4:	be 10 02 00 00       	mov    $0x210,%esi
   410d9:	48 8d 05 08 41 00 00 	lea    0x4108(%rip),%rax        # 451e8 <memstate_colors+0x68>
   410e0:	48 89 c7             	mov    %rax,%rdi
   410e3:	e8 f9 17 00 00       	call   428e1 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   410e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410ec:	48 c1 e8 0c          	shr    $0xc,%rax
   410f0:	48 98                	cltq   
   410f2:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   410f6:	48 8d 05 23 de 00 00 	lea    0xde23(%rip),%rax        # 4ef20 <pageinfo>
   410fd:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41101:	0f be c0             	movsbl %al,%eax
   41104:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41107:	74 1e                	je     41127 <check_page_table_ownership_level+0x85>
   41109:	48 8d 05 e8 42 00 00 	lea    0x42e8(%rip),%rax        # 453f8 <memstate_colors+0x278>
   41110:	48 89 c2             	mov    %rax,%rdx
   41113:	be 11 02 00 00       	mov    $0x211,%esi
   41118:	48 8d 05 c9 40 00 00 	lea    0x40c9(%rip),%rax        # 451e8 <memstate_colors+0x68>
   4111f:	48 89 c7             	mov    %rax,%rdi
   41122:	e8 ba 17 00 00       	call   428e1 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41127:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4112b:	48 c1 e8 0c          	shr    $0xc,%rax
   4112f:	48 98                	cltq   
   41131:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41135:	48 8d 05 e5 dd 00 00 	lea    0xdde5(%rip),%rax        # 4ef21 <pageinfo+0x1>
   4113c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41140:	0f be c0             	movsbl %al,%eax
   41143:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41146:	74 1e                	je     41166 <check_page_table_ownership_level+0xc4>
   41148:	48 8d 05 d1 42 00 00 	lea    0x42d1(%rip),%rax        # 45420 <memstate_colors+0x2a0>
   4114f:	48 89 c2             	mov    %rax,%rdx
   41152:	be 12 02 00 00       	mov    $0x212,%esi
   41157:	48 8d 05 8a 40 00 00 	lea    0x408a(%rip),%rax        # 451e8 <memstate_colors+0x68>
   4115e:	48 89 c7             	mov    %rax,%rdi
   41161:	e8 7b 17 00 00       	call   428e1 <assert_fail>
    if (level < 3) {
   41166:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   4116a:	7f 5b                	jg     411c7 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4116c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41173:	eb 49                	jmp    411be <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   41175:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41179:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4117c:	48 63 d2             	movslq %edx,%rdx
   4117f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41183:	48 85 c0             	test   %rax,%rax
   41186:	74 32                	je     411ba <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41188:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4118c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4118f:	48 63 d2             	movslq %edx,%rdx
   41192:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41196:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4119c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   411a0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   411a3:	8d 70 01             	lea    0x1(%rax),%esi
   411a6:	8b 55 e0             	mov    -0x20(%rbp),%edx
   411a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   411ad:	b9 01 00 00 00       	mov    $0x1,%ecx
   411b2:	48 89 c7             	mov    %rax,%rdi
   411b5:	e8 e8 fe ff ff       	call   410a2 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   411ba:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411be:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   411c5:	7e ae                	jle    41175 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   411c7:	90                   	nop
   411c8:	c9                   	leave  
   411c9:	c3                   	ret    

00000000000411ca <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   411ca:	f3 0f 1e fa          	endbr64 
   411ce:	55                   	push   %rbp
   411cf:	48 89 e5             	mov    %rsp,%rbp
   411d2:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   411d6:	8b 05 fc ce 00 00    	mov    0xcefc(%rip),%eax        # 4e0d8 <processes+0xd8>
   411dc:	85 c0                	test   %eax,%eax
   411de:	74 1e                	je     411fe <check_virtual_memory+0x34>
   411e0:	48 8d 05 69 42 00 00 	lea    0x4269(%rip),%rax        # 45450 <memstate_colors+0x2d0>
   411e7:	48 89 c2             	mov    %rax,%rdx
   411ea:	be 25 02 00 00       	mov    $0x225,%esi
   411ef:	48 8d 05 f2 3f 00 00 	lea    0x3ff2(%rip),%rax        # 451e8 <memstate_colors+0x68>
   411f6:	48 89 c7             	mov    %rax,%rdi
   411f9:	e8 e3 16 00 00       	call   428e1 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   411fe:	48 8b 05 fb fd 00 00 	mov    0xfdfb(%rip),%rax        # 51000 <kernel_pagetable>
   41205:	48 89 c7             	mov    %rax,%rdi
   41208:	e8 51 fc ff ff       	call   40e5e <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4120d:	48 8b 05 ec fd 00 00 	mov    0xfdec(%rip),%rax        # 51000 <kernel_pagetable>
   41214:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41219:	48 89 c7             	mov    %rax,%rdi
   4121c:	e8 c9 fd ff ff       	call   40fea <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41221:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41228:	e9 b4 00 00 00       	jmp    412e1 <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   4122d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41230:	48 63 d0             	movslq %eax,%rdx
   41233:	48 89 d0             	mov    %rdx,%rax
   41236:	48 c1 e0 04          	shl    $0x4,%rax
   4123a:	48 29 d0             	sub    %rdx,%rax
   4123d:	48 c1 e0 04          	shl    $0x4,%rax
   41241:	48 89 c2             	mov    %rax,%rdx
   41244:	48 8d 05 8d ce 00 00 	lea    0xce8d(%rip),%rax        # 4e0d8 <processes+0xd8>
   4124b:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4124e:	85 c0                	test   %eax,%eax
   41250:	0f 84 87 00 00 00    	je     412dd <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41256:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41259:	48 63 d0             	movslq %eax,%rdx
   4125c:	48 89 d0             	mov    %rdx,%rax
   4125f:	48 c1 e0 04          	shl    $0x4,%rax
   41263:	48 29 d0             	sub    %rdx,%rax
   41266:	48 c1 e0 04          	shl    $0x4,%rax
   4126a:	48 89 c2             	mov    %rax,%rdx
   4126d:	48 8d 05 6c ce 00 00 	lea    0xce6c(%rip),%rax        # 4e0e0 <processes+0xe0>
   41274:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   41278:	48 8b 05 81 fd 00 00 	mov    0xfd81(%rip),%rax        # 51000 <kernel_pagetable>
   4127f:	48 39 c2             	cmp    %rax,%rdx
   41282:	74 59                	je     412dd <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   41284:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41287:	48 63 d0             	movslq %eax,%rdx
   4128a:	48 89 d0             	mov    %rdx,%rax
   4128d:	48 c1 e0 04          	shl    $0x4,%rax
   41291:	48 29 d0             	sub    %rdx,%rax
   41294:	48 c1 e0 04          	shl    $0x4,%rax
   41298:	48 89 c2             	mov    %rax,%rdx
   4129b:	48 8d 05 3e ce 00 00 	lea    0xce3e(%rip),%rax        # 4e0e0 <processes+0xe0>
   412a2:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   412a6:	48 89 c7             	mov    %rax,%rdi
   412a9:	e8 b0 fb ff ff       	call   40e5e <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   412ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412b1:	48 63 d0             	movslq %eax,%rdx
   412b4:	48 89 d0             	mov    %rdx,%rax
   412b7:	48 c1 e0 04          	shl    $0x4,%rax
   412bb:	48 29 d0             	sub    %rdx,%rax
   412be:	48 c1 e0 04          	shl    $0x4,%rax
   412c2:	48 89 c2             	mov    %rax,%rdx
   412c5:	48 8d 05 14 ce 00 00 	lea    0xce14(%rip),%rax        # 4e0e0 <processes+0xe0>
   412cc:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   412d0:	8b 55 fc             	mov    -0x4(%rbp),%edx
   412d3:	89 d6                	mov    %edx,%esi
   412d5:	48 89 c7             	mov    %rax,%rdi
   412d8:	e8 0d fd ff ff       	call   40fea <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   412dd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412e1:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   412e5:	0f 8e 42 ff ff ff    	jle    4122d <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412eb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   412f2:	e9 8b 00 00 00       	jmp    41382 <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   412f7:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412fa:	48 98                	cltq   
   412fc:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41300:	48 8d 05 1a dc 00 00 	lea    0xdc1a(%rip),%rax        # 4ef21 <pageinfo+0x1>
   41307:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4130b:	84 c0                	test   %al,%al
   4130d:	7e 6f                	jle    4137e <check_virtual_memory+0x1b4>
   4130f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41312:	48 98                	cltq   
   41314:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41318:	48 8d 05 01 dc 00 00 	lea    0xdc01(%rip),%rax        # 4ef20 <pageinfo>
   4131f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41323:	84 c0                	test   %al,%al
   41325:	78 57                	js     4137e <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41327:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4132a:	48 98                	cltq   
   4132c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41330:	48 8d 05 e9 db 00 00 	lea    0xdbe9(%rip),%rax        # 4ef20 <pageinfo>
   41337:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4133b:	0f be c0             	movsbl %al,%eax
   4133e:	48 63 d0             	movslq %eax,%rdx
   41341:	48 89 d0             	mov    %rdx,%rax
   41344:	48 c1 e0 04          	shl    $0x4,%rax
   41348:	48 29 d0             	sub    %rdx,%rax
   4134b:	48 c1 e0 04          	shl    $0x4,%rax
   4134f:	48 89 c2             	mov    %rax,%rdx
   41352:	48 8d 05 7f cd 00 00 	lea    0xcd7f(%rip),%rax        # 4e0d8 <processes+0xd8>
   41359:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4135c:	85 c0                	test   %eax,%eax
   4135e:	75 1e                	jne    4137e <check_virtual_memory+0x1b4>
   41360:	48 8d 05 09 41 00 00 	lea    0x4109(%rip),%rax        # 45470 <memstate_colors+0x2f0>
   41367:	48 89 c2             	mov    %rax,%rdx
   4136a:	be 3c 02 00 00       	mov    $0x23c,%esi
   4136f:	48 8d 05 72 3e 00 00 	lea    0x3e72(%rip),%rax        # 451e8 <memstate_colors+0x68>
   41376:	48 89 c7             	mov    %rax,%rdi
   41379:	e8 63 15 00 00       	call   428e1 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4137e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41382:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41389:	0f 8e 68 ff ff ff    	jle    412f7 <check_virtual_memory+0x12d>
        }
    }
}
   4138f:	90                   	nop
   41390:	90                   	nop
   41391:	c9                   	leave  
   41392:	c3                   	ret    

0000000000041393 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41393:	f3 0f 1e fa          	endbr64 
   41397:	55                   	push   %rbp
   41398:	48 89 e5             	mov    %rsp,%rbp
   4139b:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4139f:	48 8d 05 fa 40 00 00 	lea    0x40fa(%rip),%rax        # 454a0 <memstate_colors+0x320>
   413a6:	48 89 c2             	mov    %rax,%rdx
   413a9:	be 00 0f 00 00       	mov    $0xf00,%esi
   413ae:	bf 20 00 00 00       	mov    $0x20,%edi
   413b3:	b8 00 00 00 00       	mov    $0x0,%eax
   413b8:	e8 e9 3b 00 00       	call   44fa6 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   413c4:	e9 1b 01 00 00       	jmp    414e4 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   413c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413cc:	83 e0 3f             	and    $0x3f,%eax
   413cf:	85 c0                	test   %eax,%eax
   413d1:	75 40                	jne    41413 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   413d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413d6:	c1 e0 0c             	shl    $0xc,%eax
   413d9:	89 c2                	mov    %eax,%edx
   413db:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413de:	8d 48 3f             	lea    0x3f(%rax),%ecx
   413e1:	85 c0                	test   %eax,%eax
   413e3:	0f 48 c1             	cmovs  %ecx,%eax
   413e6:	c1 f8 06             	sar    $0x6,%eax
   413e9:	8d 48 01             	lea    0x1(%rax),%ecx
   413ec:	89 c8                	mov    %ecx,%eax
   413ee:	c1 e0 02             	shl    $0x2,%eax
   413f1:	01 c8                	add    %ecx,%eax
   413f3:	c1 e0 04             	shl    $0x4,%eax
   413f6:	83 c0 03             	add    $0x3,%eax
   413f9:	89 d1                	mov    %edx,%ecx
   413fb:	48 8d 15 ae 40 00 00 	lea    0x40ae(%rip),%rdx        # 454b0 <memstate_colors+0x330>
   41402:	be 00 0f 00 00       	mov    $0xf00,%esi
   41407:	89 c7                	mov    %eax,%edi
   41409:	b8 00 00 00 00       	mov    $0x0,%eax
   4140e:	e8 93 3b 00 00       	call   44fa6 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41413:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41416:	48 98                	cltq   
   41418:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4141c:	48 8d 05 fd da 00 00 	lea    0xdafd(%rip),%rax        # 4ef20 <pageinfo>
   41423:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41427:	0f be c0             	movsbl %al,%eax
   4142a:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   4142d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41430:	48 98                	cltq   
   41432:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41436:	48 8d 05 e4 da 00 00 	lea    0xdae4(%rip),%rax        # 4ef21 <pageinfo+0x1>
   4143d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41441:	84 c0                	test   %al,%al
   41443:	75 07                	jne    4144c <memshow_physical+0xb9>
            owner = PO_FREE;
   41445:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4144c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4144f:	83 c0 02             	add    $0x2,%eax
   41452:	48 98                	cltq   
   41454:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41458:	48 8d 05 21 3d 00 00 	lea    0x3d21(%rip),%rax        # 45180 <memstate_colors>
   4145f:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41463:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41467:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4146a:	48 98                	cltq   
   4146c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41470:	48 8d 05 aa da 00 00 	lea    0xdaaa(%rip),%rax        # 4ef21 <pageinfo+0x1>
   41477:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4147b:	3c 01                	cmp    $0x1,%al
   4147d:	7e 1c                	jle    4149b <memshow_physical+0x108>
   4147f:	48 8d 05 7a 6b 07 00 	lea    0x76b7a(%rip),%rax        # b8000 <console>
   41486:	48 c1 e8 0c          	shr    $0xc,%rax
   4148a:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4148d:	74 0c                	je     4149b <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4148f:	b8 53 00 00 00       	mov    $0x53,%eax
   41494:	80 cc 0f             	or     $0xf,%ah
   41497:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4149b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4149e:	8d 50 3f             	lea    0x3f(%rax),%edx
   414a1:	85 c0                	test   %eax,%eax
   414a3:	0f 48 c2             	cmovs  %edx,%eax
   414a6:	c1 f8 06             	sar    $0x6,%eax
   414a9:	8d 50 01             	lea    0x1(%rax),%edx
   414ac:	89 d0                	mov    %edx,%eax
   414ae:	c1 e0 02             	shl    $0x2,%eax
   414b1:	01 d0                	add    %edx,%eax
   414b3:	c1 e0 04             	shl    $0x4,%eax
   414b6:	89 c1                	mov    %eax,%ecx
   414b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414bb:	99                   	cltd   
   414bc:	c1 ea 1a             	shr    $0x1a,%edx
   414bf:	01 d0                	add    %edx,%eax
   414c1:	83 e0 3f             	and    $0x3f,%eax
   414c4:	29 d0                	sub    %edx,%eax
   414c6:	83 c0 0c             	add    $0xc,%eax
   414c9:	01 c8                	add    %ecx,%eax
   414cb:	48 98                	cltq   
   414cd:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   414d1:	48 8d 15 28 6b 07 00 	lea    0x76b28(%rip),%rdx        # b8000 <console>
   414d8:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414dc:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   414e0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   414e4:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   414eb:	0f 8e d8 fe ff ff    	jle    413c9 <memshow_physical+0x36>
    }
}
   414f1:	90                   	nop
   414f2:	90                   	nop
   414f3:	c9                   	leave  
   414f4:	c3                   	ret    

00000000000414f5 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   414f5:	f3 0f 1e fa          	endbr64 
   414f9:	55                   	push   %rbp
   414fa:	48 89 e5             	mov    %rsp,%rbp
   414fd:	48 83 ec 40          	sub    $0x40,%rsp
   41501:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41505:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41509:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4150d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41513:	48 89 c2             	mov    %rax,%rdx
   41516:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4151a:	48 39 c2             	cmp    %rax,%rdx
   4151d:	74 1e                	je     4153d <memshow_virtual+0x48>
   4151f:	48 8d 05 92 3f 00 00 	lea    0x3f92(%rip),%rax        # 454b8 <memstate_colors+0x338>
   41526:	48 89 c2             	mov    %rax,%rdx
   41529:	be 6d 02 00 00       	mov    $0x26d,%esi
   4152e:	48 8d 05 b3 3c 00 00 	lea    0x3cb3(%rip),%rax        # 451e8 <memstate_colors+0x68>
   41535:	48 89 c7             	mov    %rax,%rdi
   41538:	e8 a4 13 00 00       	call   428e1 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   4153d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41541:	48 89 c1             	mov    %rax,%rcx
   41544:	48 8d 05 9a 3f 00 00 	lea    0x3f9a(%rip),%rax        # 454e5 <memstate_colors+0x365>
   4154b:	48 89 c2             	mov    %rax,%rdx
   4154e:	be 00 0f 00 00       	mov    $0xf00,%esi
   41553:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41558:	b8 00 00 00 00       	mov    $0x0,%eax
   4155d:	e8 44 3a 00 00       	call   44fa6 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41562:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41569:	00 
   4156a:	e9 b4 01 00 00       	jmp    41723 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4156f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41573:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41577:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4157b:	48 89 ce             	mov    %rcx,%rsi
   4157e:	48 89 c7             	mov    %rax,%rdi
   41581:	e8 2b 1b 00 00       	call   430b1 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41586:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41589:	85 c0                	test   %eax,%eax
   4158b:	79 0b                	jns    41598 <memshow_virtual+0xa3>
            color = ' ';
   4158d:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41593:	e9 ff 00 00 00       	jmp    41697 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41598:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4159c:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   415a2:	76 1e                	jbe    415c2 <memshow_virtual+0xcd>
   415a4:	48 8d 05 57 3f 00 00 	lea    0x3f57(%rip),%rax        # 45502 <memstate_colors+0x382>
   415ab:	48 89 c2             	mov    %rax,%rdx
   415ae:	be 76 02 00 00       	mov    $0x276,%esi
   415b3:	48 8d 05 2e 3c 00 00 	lea    0x3c2e(%rip),%rax        # 451e8 <memstate_colors+0x68>
   415ba:	48 89 c7             	mov    %rax,%rdi
   415bd:	e8 1f 13 00 00       	call   428e1 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   415c2:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415c5:	48 98                	cltq   
   415c7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   415cb:	48 8d 05 4e d9 00 00 	lea    0xd94e(%rip),%rax        # 4ef20 <pageinfo>
   415d2:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   415d6:	0f be c0             	movsbl %al,%eax
   415d9:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   415dc:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415df:	48 98                	cltq   
   415e1:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   415e5:	48 8d 05 35 d9 00 00 	lea    0xd935(%rip),%rax        # 4ef21 <pageinfo+0x1>
   415ec:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   415f0:	84 c0                	test   %al,%al
   415f2:	75 07                	jne    415fb <memshow_virtual+0x106>
                owner = PO_FREE;
   415f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   415fb:	8b 45 f0             	mov    -0x10(%rbp),%eax
   415fe:	83 c0 02             	add    $0x2,%eax
   41601:	48 98                	cltq   
   41603:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41607:	48 8d 05 72 3b 00 00 	lea    0x3b72(%rip),%rax        # 45180 <memstate_colors>
   4160e:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41612:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41616:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41619:	48 98                	cltq   
   4161b:	83 e0 04             	and    $0x4,%eax
   4161e:	48 85 c0             	test   %rax,%rax
   41621:	74 27                	je     4164a <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41623:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41627:	c1 e0 04             	shl    $0x4,%eax
   4162a:	66 25 00 f0          	and    $0xf000,%ax
   4162e:	89 c2                	mov    %eax,%edx
   41630:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41634:	c1 f8 04             	sar    $0x4,%eax
   41637:	66 25 00 0f          	and    $0xf00,%ax
   4163b:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   4163d:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41641:	0f b6 c0             	movzbl %al,%eax
   41644:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41646:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   4164a:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4164d:	48 98                	cltq   
   4164f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41653:	48 8d 05 c7 d8 00 00 	lea    0xd8c7(%rip),%rax        # 4ef21 <pageinfo+0x1>
   4165a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4165e:	3c 01                	cmp    $0x1,%al
   41660:	7e 35                	jle    41697 <memshow_virtual+0x1a2>
   41662:	48 8d 05 97 69 07 00 	lea    0x76997(%rip),%rax        # b8000 <console>
   41669:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4166d:	74 28                	je     41697 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   4166f:	b8 53 00 00 00       	mov    $0x53,%eax
   41674:	89 c2                	mov    %eax,%edx
   41676:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4167a:	66 25 00 f0          	and    $0xf000,%ax
   4167e:	09 d0                	or     %edx,%eax
   41680:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41684:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41687:	48 98                	cltq   
   41689:	83 e0 04             	and    $0x4,%eax
   4168c:	48 85 c0             	test   %rax,%rax
   4168f:	75 06                	jne    41697 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   41691:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41697:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4169b:	48 c1 e8 0c          	shr    $0xc,%rax
   4169f:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   416a2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416a5:	83 e0 3f             	and    $0x3f,%eax
   416a8:	85 c0                	test   %eax,%eax
   416aa:	75 39                	jne    416e5 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   416ac:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416af:	c1 e8 06             	shr    $0x6,%eax
   416b2:	89 c2                	mov    %eax,%edx
   416b4:	89 d0                	mov    %edx,%eax
   416b6:	c1 e0 02             	shl    $0x2,%eax
   416b9:	01 d0                	add    %edx,%eax
   416bb:	c1 e0 04             	shl    $0x4,%eax
   416be:	05 73 03 00 00       	add    $0x373,%eax
   416c3:	89 c7                	mov    %eax,%edi
   416c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416c9:	48 89 c1             	mov    %rax,%rcx
   416cc:	48 8d 05 dd 3d 00 00 	lea    0x3ddd(%rip),%rax        # 454b0 <memstate_colors+0x330>
   416d3:	48 89 c2             	mov    %rax,%rdx
   416d6:	be 00 0f 00 00       	mov    $0xf00,%esi
   416db:	b8 00 00 00 00       	mov    $0x0,%eax
   416e0:	e8 c1 38 00 00       	call   44fa6 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   416e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416e8:	c1 e8 06             	shr    $0x6,%eax
   416eb:	89 c2                	mov    %eax,%edx
   416ed:	89 d0                	mov    %edx,%eax
   416ef:	c1 e0 02             	shl    $0x2,%eax
   416f2:	01 d0                	add    %edx,%eax
   416f4:	c1 e0 04             	shl    $0x4,%eax
   416f7:	89 c2                	mov    %eax,%edx
   416f9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416fc:	83 e0 3f             	and    $0x3f,%eax
   416ff:	01 d0                	add    %edx,%eax
   41701:	05 7c 03 00 00       	add    $0x37c,%eax
   41706:	89 c0                	mov    %eax,%eax
   41708:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4170c:	48 8d 15 ed 68 07 00 	lea    0x768ed(%rip),%rdx        # b8000 <console>
   41713:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41717:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4171b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41722:	00 
   41723:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4172a:	00 
   4172b:	0f 86 3e fe ff ff    	jbe    4156f <memshow_virtual+0x7a>
    }
}
   41731:	90                   	nop
   41732:	90                   	nop
   41733:	c9                   	leave  
   41734:	c3                   	ret    

0000000000041735 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41735:	f3 0f 1e fa          	endbr64 
   41739:	55                   	push   %rbp
   4173a:	48 89 e5             	mov    %rsp,%rbp
   4173d:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41741:	8b 05 dd db 00 00    	mov    0xdbdd(%rip),%eax        # 4f324 <last_ticks.1>
   41747:	85 c0                	test   %eax,%eax
   41749:	74 13                	je     4175e <memshow_virtual_animate+0x29>
   4174b:	8b 05 cf db 00 00    	mov    0xdbcf(%rip),%eax        # 4f320 <ticks>
   41751:	8b 15 cd db 00 00    	mov    0xdbcd(%rip),%edx        # 4f324 <last_ticks.1>
   41757:	29 d0                	sub    %edx,%eax
   41759:	83 f8 31             	cmp    $0x31,%eax
   4175c:	76 2c                	jbe    4178a <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   4175e:	8b 05 bc db 00 00    	mov    0xdbbc(%rip),%eax        # 4f320 <ticks>
   41764:	89 05 ba db 00 00    	mov    %eax,0xdbba(%rip)        # 4f324 <last_ticks.1>
        ++showing;
   4176a:	8b 05 94 48 00 00    	mov    0x4894(%rip),%eax        # 46004 <showing.0>
   41770:	83 c0 01             	add    $0x1,%eax
   41773:	89 05 8b 48 00 00    	mov    %eax,0x488b(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41779:	eb 0f                	jmp    4178a <memshow_virtual_animate+0x55>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   4177b:	8b 05 83 48 00 00    	mov    0x4883(%rip),%eax        # 46004 <showing.0>
   41781:	83 c0 01             	add    $0x1,%eax
   41784:	89 05 7a 48 00 00    	mov    %eax,0x487a(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   4178a:	8b 05 74 48 00 00    	mov    0x4874(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41790:	83 f8 20             	cmp    $0x20,%eax
   41793:	7f 33                	jg     417c8 <memshow_virtual_animate+0x93>
   41795:	8b 05 69 48 00 00    	mov    0x4869(%rip),%eax        # 46004 <showing.0>
   4179b:	99                   	cltd   
   4179c:	c1 ea 1c             	shr    $0x1c,%edx
   4179f:	01 d0                	add    %edx,%eax
   417a1:	83 e0 0f             	and    $0xf,%eax
   417a4:	29 d0                	sub    %edx,%eax
   417a6:	48 63 d0             	movslq %eax,%rdx
   417a9:	48 89 d0             	mov    %rdx,%rax
   417ac:	48 c1 e0 04          	shl    $0x4,%rax
   417b0:	48 29 d0             	sub    %rdx,%rax
   417b3:	48 c1 e0 04          	shl    $0x4,%rax
   417b7:	48 89 c2             	mov    %rax,%rdx
   417ba:	48 8d 05 17 c9 00 00 	lea    0xc917(%rip),%rax        # 4e0d8 <processes+0xd8>
   417c1:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   417c4:	85 c0                	test   %eax,%eax
   417c6:	74 b3                	je     4177b <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   417c8:	8b 05 36 48 00 00    	mov    0x4836(%rip),%eax        # 46004 <showing.0>
   417ce:	99                   	cltd   
   417cf:	c1 ea 1c             	shr    $0x1c,%edx
   417d2:	01 d0                	add    %edx,%eax
   417d4:	83 e0 0f             	and    $0xf,%eax
   417d7:	29 d0                	sub    %edx,%eax
   417d9:	89 05 25 48 00 00    	mov    %eax,0x4825(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   417df:	8b 05 1f 48 00 00    	mov    0x481f(%rip),%eax        # 46004 <showing.0>
   417e5:	48 63 d0             	movslq %eax,%rdx
   417e8:	48 89 d0             	mov    %rdx,%rax
   417eb:	48 c1 e0 04          	shl    $0x4,%rax
   417ef:	48 29 d0             	sub    %rdx,%rax
   417f2:	48 c1 e0 04          	shl    $0x4,%rax
   417f6:	48 89 c2             	mov    %rax,%rdx
   417f9:	48 8d 05 d8 c8 00 00 	lea    0xc8d8(%rip),%rax        # 4e0d8 <processes+0xd8>
   41800:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41803:	85 c0                	test   %eax,%eax
   41805:	0f 84 82 00 00 00    	je     4188d <memshow_virtual_animate+0x158>
   4180b:	8b 05 f3 47 00 00    	mov    0x47f3(%rip),%eax        # 46004 <showing.0>
   41811:	48 63 d0             	movslq %eax,%rdx
   41814:	48 89 d0             	mov    %rdx,%rax
   41817:	48 c1 e0 04          	shl    $0x4,%rax
   4181b:	48 29 d0             	sub    %rdx,%rax
   4181e:	48 c1 e0 04          	shl    $0x4,%rax
   41822:	48 89 c2             	mov    %rax,%rdx
   41825:	48 8d 05 bc c8 00 00 	lea    0xc8bc(%rip),%rax        # 4e0e8 <processes+0xe8>
   4182c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41830:	84 c0                	test   %al,%al
   41832:	74 59                	je     4188d <memshow_virtual_animate+0x158>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41834:	8b 15 ca 47 00 00    	mov    0x47ca(%rip),%edx        # 46004 <showing.0>
   4183a:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   4183e:	89 d1                	mov    %edx,%ecx
   41840:	48 8d 15 d5 3c 00 00 	lea    0x3cd5(%rip),%rdx        # 4551c <memstate_colors+0x39c>
   41847:	be 04 00 00 00       	mov    $0x4,%esi
   4184c:	48 89 c7             	mov    %rax,%rdi
   4184f:	b8 00 00 00 00       	mov    $0x0,%eax
   41854:	e8 68 38 00 00       	call   450c1 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41859:	8b 05 a5 47 00 00    	mov    0x47a5(%rip),%eax        # 46004 <showing.0>
   4185f:	48 63 d0             	movslq %eax,%rdx
   41862:	48 89 d0             	mov    %rdx,%rax
   41865:	48 c1 e0 04          	shl    $0x4,%rax
   41869:	48 29 d0             	sub    %rdx,%rax
   4186c:	48 c1 e0 04          	shl    $0x4,%rax
   41870:	48 89 c2             	mov    %rax,%rdx
   41873:	48 8d 05 66 c8 00 00 	lea    0xc866(%rip),%rax        # 4e0e0 <processes+0xe0>
   4187a:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4187e:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41882:	48 89 d6             	mov    %rdx,%rsi
   41885:	48 89 c7             	mov    %rax,%rdi
   41888:	e8 68 fc ff ff       	call   414f5 <memshow_virtual>
    }
}
   4188d:	90                   	nop
   4188e:	c9                   	leave  
   4188f:	c3                   	ret    

0000000000041890 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41890:	f3 0f 1e fa          	endbr64 
   41894:	55                   	push   %rbp
   41895:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41898:	e8 5f 01 00 00       	call   419fc <segments_init>
    interrupt_init();
   4189d:	e8 44 04 00 00       	call   41ce6 <interrupt_init>
    virtual_memory_init();
   418a2:	e8 11 11 00 00       	call   429b8 <virtual_memory_init>
}
   418a7:	90                   	nop
   418a8:	5d                   	pop    %rbp
   418a9:	c3                   	ret    

00000000000418aa <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   418aa:	f3 0f 1e fa          	endbr64 
   418ae:	55                   	push   %rbp
   418af:	48 89 e5             	mov    %rsp,%rbp
   418b2:	48 83 ec 18          	sub    $0x18,%rsp
   418b6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418ba:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   418be:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   418c1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   418c4:	48 98                	cltq   
   418c6:	48 c1 e0 2d          	shl    $0x2d,%rax
   418ca:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   418ce:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   418d5:	90 00 00 
   418d8:	48 09 c2             	or     %rax,%rdx
    *segment = type
   418db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418df:	48 89 10             	mov    %rdx,(%rax)
}
   418e2:	90                   	nop
   418e3:	c9                   	leave  
   418e4:	c3                   	ret    

00000000000418e5 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   418e5:	f3 0f 1e fa          	endbr64 
   418e9:	55                   	push   %rbp
   418ea:	48 89 e5             	mov    %rsp,%rbp
   418ed:	48 83 ec 28          	sub    $0x28,%rsp
   418f1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418f5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   418f9:	89 55 ec             	mov    %edx,-0x14(%rbp)
   418fc:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41900:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41904:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41908:	48 c1 e0 10          	shl    $0x10,%rax
   4190c:	48 89 c2             	mov    %rax,%rdx
   4190f:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41916:	00 00 00 
   41919:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   4191c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41920:	48 c1 e0 20          	shl    $0x20,%rax
   41924:	48 89 c1             	mov    %rax,%rcx
   41927:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4192e:	00 00 ff 
   41931:	48 21 c8             	and    %rcx,%rax
   41934:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41937:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4193b:	48 83 e8 01          	sub    $0x1,%rax
   4193f:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41942:	48 09 d0             	or     %rdx,%rax
        | type
   41945:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41949:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   4194c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4194f:	48 98                	cltq   
   41951:	48 c1 e0 2d          	shl    $0x2d,%rax
   41955:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41958:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4195f:	80 00 00 
   41962:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41965:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41969:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   4196c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41970:	48 83 c0 08          	add    $0x8,%rax
   41974:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41978:	48 c1 ea 20          	shr    $0x20,%rdx
   4197c:	48 89 10             	mov    %rdx,(%rax)
}
   4197f:	90                   	nop
   41980:	c9                   	leave  
   41981:	c3                   	ret    

0000000000041982 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41982:	f3 0f 1e fa          	endbr64 
   41986:	55                   	push   %rbp
   41987:	48 89 e5             	mov    %rsp,%rbp
   4198a:	48 83 ec 20          	sub    $0x20,%rsp
   4198e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41992:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41996:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41999:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   4199d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419a1:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   419a4:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   419a8:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   419ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
   419ae:	48 98                	cltq   
   419b0:	48 c1 e0 2d          	shl    $0x2d,%rax
   419b4:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   419b7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419bb:	48 c1 e0 20          	shl    $0x20,%rax
   419bf:	48 89 c1             	mov    %rax,%rcx
   419c2:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   419c9:	00 ff ff 
   419cc:	48 21 c8             	and    %rcx,%rax
   419cf:	48 09 c2             	or     %rax,%rdx
   419d2:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   419d9:	80 00 00 
   419dc:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   419df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419e3:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   419e6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419ea:	48 c1 e8 20          	shr    $0x20,%rax
   419ee:	48 89 c2             	mov    %rax,%rdx
   419f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419f5:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   419f9:	90                   	nop
   419fa:	c9                   	leave  
   419fb:	c3                   	ret    

00000000000419fc <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   419fc:	f3 0f 1e fa          	endbr64 
   41a00:	55                   	push   %rbp
   41a01:	48 89 e5             	mov    %rsp,%rbp
   41a04:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41a08:	48 c7 05 2d d9 00 00 	movq   $0x0,0xd92d(%rip)        # 4f340 <segments>
   41a0f:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41a13:	ba 00 00 00 00       	mov    $0x0,%edx
   41a18:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41a1f:	08 20 00 
   41a22:	48 89 c6             	mov    %rax,%rsi
   41a25:	48 8d 05 1c d9 00 00 	lea    0xd91c(%rip),%rax        # 4f348 <segments+0x8>
   41a2c:	48 89 c7             	mov    %rax,%rdi
   41a2f:	e8 76 fe ff ff       	call   418aa <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41a34:	ba 03 00 00 00       	mov    $0x3,%edx
   41a39:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41a40:	08 20 00 
   41a43:	48 89 c6             	mov    %rax,%rsi
   41a46:	48 8d 05 03 d9 00 00 	lea    0xd903(%rip),%rax        # 4f350 <segments+0x10>
   41a4d:	48 89 c7             	mov    %rax,%rdi
   41a50:	e8 55 fe ff ff       	call   418aa <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41a55:	ba 00 00 00 00       	mov    $0x0,%edx
   41a5a:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41a61:	02 00 00 
   41a64:	48 89 c6             	mov    %rax,%rsi
   41a67:	48 8d 05 ea d8 00 00 	lea    0xd8ea(%rip),%rax        # 4f358 <segments+0x18>
   41a6e:	48 89 c7             	mov    %rax,%rdi
   41a71:	e8 34 fe ff ff       	call   418aa <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41a76:	ba 03 00 00 00       	mov    $0x3,%edx
   41a7b:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41a82:	02 00 00 
   41a85:	48 89 c6             	mov    %rax,%rsi
   41a88:	48 8d 05 d1 d8 00 00 	lea    0xd8d1(%rip),%rax        # 4f360 <segments+0x20>
   41a8f:	48 89 c7             	mov    %rax,%rdi
   41a92:	e8 13 fe ff ff       	call   418aa <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41a97:	48 8d 05 e2 e8 00 00 	lea    0xe8e2(%rip),%rax        # 50380 <kernel_task_descriptor>
   41a9e:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41aa4:	48 89 c1             	mov    %rax,%rcx
   41aa7:	ba 00 00 00 00       	mov    $0x0,%edx
   41aac:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41ab3:	09 00 00 
   41ab6:	48 89 c6             	mov    %rax,%rsi
   41ab9:	48 8d 05 a8 d8 00 00 	lea    0xd8a8(%rip),%rax        # 4f368 <segments+0x28>
   41ac0:	48 89 c7             	mov    %rax,%rdi
   41ac3:	e8 1d fe ff ff       	call   418e5 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41ac8:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41ace:	48 8d 05 6b d8 00 00 	lea    0xd86b(%rip),%rax        # 4f340 <segments>
   41ad5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41ad9:	ba 60 00 00 00       	mov    $0x60,%edx
   41ade:	be 00 00 00 00       	mov    $0x0,%esi
   41ae3:	48 8d 05 96 e8 00 00 	lea    0xe896(%rip),%rax        # 50380 <kernel_task_descriptor>
   41aea:	48 89 c7             	mov    %rax,%rdi
   41aed:	e8 75 26 00 00       	call   44167 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41af2:	48 c7 05 87 e8 00 00 	movq   $0x80000,0xe887(%rip)        # 50384 <kernel_task_descriptor+0x4>
   41af9:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41afd:	ba 00 10 00 00       	mov    $0x1000,%edx
   41b02:	be 00 00 00 00       	mov    $0x0,%esi
   41b07:	48 8d 05 72 d8 00 00 	lea    0xd872(%rip),%rax        # 4f380 <interrupt_descriptors>
   41b0e:	48 89 c7             	mov    %rax,%rdi
   41b11:	e8 51 26 00 00       	call   44167 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41b16:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41b1d:	eb 3c                	jmp    41b5b <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41b1f:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   41b26:	48 89 c2             	mov    %rax,%rdx
   41b29:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41b2c:	48 c1 e0 04          	shl    $0x4,%rax
   41b30:	48 89 c1             	mov    %rax,%rcx
   41b33:	48 8d 05 46 d8 00 00 	lea    0xd846(%rip),%rax        # 4f380 <interrupt_descriptors>
   41b3a:	48 01 c8             	add    %rcx,%rax
   41b3d:	48 89 d1             	mov    %rdx,%rcx
   41b40:	ba 00 00 00 00       	mov    $0x0,%edx
   41b45:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41b4c:	0e 00 00 
   41b4f:	48 89 c7             	mov    %rax,%rdi
   41b52:	e8 2b fe ff ff       	call   41982 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41b57:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41b5b:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41b62:	76 bb                	jbe    41b1f <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41b64:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   41b6b:	48 89 c1             	mov    %rax,%rcx
   41b6e:	ba 00 00 00 00       	mov    $0x0,%edx
   41b73:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41b7a:	0e 00 00 
   41b7d:	48 89 c6             	mov    %rax,%rsi
   41b80:	48 8d 05 f9 d9 00 00 	lea    0xd9f9(%rip),%rax        # 4f580 <interrupt_descriptors+0x200>
   41b87:	48 89 c7             	mov    %rax,%rdi
   41b8a:	e8 f3 fd ff ff       	call   41982 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41b8f:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   41b96:	48 89 c1             	mov    %rax,%rcx
   41b99:	ba 00 00 00 00       	mov    $0x0,%edx
   41b9e:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ba5:	0e 00 00 
   41ba8:	48 89 c6             	mov    %rax,%rsi
   41bab:	48 8d 05 9e d8 00 00 	lea    0xd89e(%rip),%rax        # 4f450 <interrupt_descriptors+0xd0>
   41bb2:	48 89 c7             	mov    %rax,%rdi
   41bb5:	e8 c8 fd ff ff       	call   41982 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41bba:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   41bc1:	48 89 c1             	mov    %rax,%rcx
   41bc4:	ba 00 00 00 00       	mov    $0x0,%edx
   41bc9:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41bd0:	0e 00 00 
   41bd3:	48 89 c6             	mov    %rax,%rsi
   41bd6:	48 8d 05 83 d8 00 00 	lea    0xd883(%rip),%rax        # 4f460 <interrupt_descriptors+0xe0>
   41bdd:	48 89 c7             	mov    %rax,%rdi
   41be0:	e8 9d fd ff ff       	call   41982 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41be5:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41bec:	eb 50                	jmp    41c3e <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41bee:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41bf1:	83 e8 30             	sub    $0x30,%eax
   41bf4:	89 c0                	mov    %eax,%eax
   41bf6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   41bfd:	00 
   41bfe:	48 8d 05 e2 e4 ff ff 	lea    -0x1b1e(%rip),%rax        # 400e7 <sys_int_handlers>
   41c05:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41c09:	48 89 c2             	mov    %rax,%rdx
   41c0c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c0f:	48 c1 e0 04          	shl    $0x4,%rax
   41c13:	48 89 c1             	mov    %rax,%rcx
   41c16:	48 8d 05 63 d7 00 00 	lea    0xd763(%rip),%rax        # 4f380 <interrupt_descriptors>
   41c1d:	48 01 c8             	add    %rcx,%rax
   41c20:	48 89 d1             	mov    %rdx,%rcx
   41c23:	ba 03 00 00 00       	mov    $0x3,%edx
   41c28:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41c2f:	0e 00 00 
   41c32:	48 89 c7             	mov    %rax,%rdi
   41c35:	e8 48 fd ff ff       	call   41982 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41c3a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41c3e:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41c42:	76 aa                	jbe    41bee <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41c44:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41c4a:	48 8d 05 2f d7 00 00 	lea    0xd72f(%rip),%rax        # 4f380 <interrupt_descriptors>
   41c51:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41c55:	b8 28 00 00 00       	mov    $0x28,%eax
   41c5a:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41c5e:	0f 00 d8             	ltr    %ax
   41c61:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41c65:	0f 20 c0             	mov    %cr0,%rax
   41c68:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41c6c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41c70:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41c73:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41c7a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c7d:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41c80:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c83:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41c87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41c8b:	0f 22 c0             	mov    %rax,%cr0
}
   41c8e:	90                   	nop
    lcr0(cr0);
}
   41c8f:	90                   	nop
   41c90:	c9                   	leave  
   41c91:	c3                   	ret    

0000000000041c92 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41c92:	f3 0f 1e fa          	endbr64 
   41c96:	55                   	push   %rbp
   41c97:	48 89 e5             	mov    %rsp,%rbp
   41c9a:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41c9e:	0f b7 05 3b e7 00 00 	movzwl 0xe73b(%rip),%eax        # 503e0 <interrupts_enabled>
   41ca5:	f7 d0                	not    %eax
   41ca7:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41cab:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41caf:	0f b6 c0             	movzbl %al,%eax
   41cb2:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41cb9:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cbc:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41cc0:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41cc3:	ee                   	out    %al,(%dx)
}
   41cc4:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41cc5:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41cc9:	66 c1 e8 08          	shr    $0x8,%ax
   41ccd:	0f b6 c0             	movzbl %al,%eax
   41cd0:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41cd7:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cda:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41cde:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41ce1:	ee                   	out    %al,(%dx)
}
   41ce2:	90                   	nop
}
   41ce3:	90                   	nop
   41ce4:	c9                   	leave  
   41ce5:	c3                   	ret    

0000000000041ce6 <interrupt_init>:

void interrupt_init(void) {
   41ce6:	f3 0f 1e fa          	endbr64 
   41cea:	55                   	push   %rbp
   41ceb:	48 89 e5             	mov    %rsp,%rbp
   41cee:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41cf2:	66 c7 05 e5 e6 00 00 	movw   $0x0,0xe6e5(%rip)        # 503e0 <interrupts_enabled>
   41cf9:	00 00 
    interrupt_mask();
   41cfb:	e8 92 ff ff ff       	call   41c92 <interrupt_mask>
   41d00:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41d07:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d0b:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41d0f:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41d12:	ee                   	out    %al,(%dx)
}
   41d13:	90                   	nop
   41d14:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41d1b:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d1f:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41d23:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41d26:	ee                   	out    %al,(%dx)
}
   41d27:	90                   	nop
   41d28:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41d2f:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d33:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41d37:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41d3a:	ee                   	out    %al,(%dx)
}
   41d3b:	90                   	nop
   41d3c:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41d43:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d47:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41d4b:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41d4e:	ee                   	out    %al,(%dx)
}
   41d4f:	90                   	nop
   41d50:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41d57:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d5b:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41d5f:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41d62:	ee                   	out    %al,(%dx)
}
   41d63:	90                   	nop
   41d64:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41d6b:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d6f:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41d73:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41d76:	ee                   	out    %al,(%dx)
}
   41d77:	90                   	nop
   41d78:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41d7f:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d83:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41d87:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41d8a:	ee                   	out    %al,(%dx)
}
   41d8b:	90                   	nop
   41d8c:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41d93:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d97:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41d9b:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41d9e:	ee                   	out    %al,(%dx)
}
   41d9f:	90                   	nop
   41da0:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41da7:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dab:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41daf:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41db2:	ee                   	out    %al,(%dx)
}
   41db3:	90                   	nop
   41db4:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41dbb:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dbf:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41dc3:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41dc6:	ee                   	out    %al,(%dx)
}
   41dc7:	90                   	nop
   41dc8:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41dcf:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dd3:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41dd7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41dda:	ee                   	out    %al,(%dx)
}
   41ddb:	90                   	nop
   41ddc:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41de3:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41de7:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41deb:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41dee:	ee                   	out    %al,(%dx)
}
   41def:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41df0:	e8 9d fe ff ff       	call   41c92 <interrupt_mask>
}
   41df5:	90                   	nop
   41df6:	c9                   	leave  
   41df7:	c3                   	ret    

0000000000041df8 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41df8:	f3 0f 1e fa          	endbr64 
   41dfc:	55                   	push   %rbp
   41dfd:	48 89 e5             	mov    %rsp,%rbp
   41e00:	48 83 ec 28          	sub    $0x28,%rsp
   41e04:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41e07:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41e0b:	0f 8e 9f 00 00 00    	jle    41eb0 <timer_init+0xb8>
   41e11:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41e18:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e1c:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41e20:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e23:	ee                   	out    %al,(%dx)
}
   41e24:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41e25:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e28:	89 c2                	mov    %eax,%edx
   41e2a:	c1 ea 1f             	shr    $0x1f,%edx
   41e2d:	01 d0                	add    %edx,%eax
   41e2f:	d1 f8                	sar    %eax
   41e31:	05 de 34 12 00       	add    $0x1234de,%eax
   41e36:	99                   	cltd   
   41e37:	f7 7d dc             	idivl  -0x24(%rbp)
   41e3a:	89 c2                	mov    %eax,%edx
   41e3c:	89 d0                	mov    %edx,%eax
   41e3e:	c1 f8 1f             	sar    $0x1f,%eax
   41e41:	c1 e8 18             	shr    $0x18,%eax
   41e44:	89 c1                	mov    %eax,%ecx
   41e46:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41e49:	0f b6 c0             	movzbl %al,%eax
   41e4c:	29 c8                	sub    %ecx,%eax
   41e4e:	0f b6 c0             	movzbl %al,%eax
   41e51:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41e58:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e5b:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41e5f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e62:	ee                   	out    %al,(%dx)
}
   41e63:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41e64:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e67:	89 c2                	mov    %eax,%edx
   41e69:	c1 ea 1f             	shr    $0x1f,%edx
   41e6c:	01 d0                	add    %edx,%eax
   41e6e:	d1 f8                	sar    %eax
   41e70:	05 de 34 12 00       	add    $0x1234de,%eax
   41e75:	99                   	cltd   
   41e76:	f7 7d dc             	idivl  -0x24(%rbp)
   41e79:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41e7f:	85 c0                	test   %eax,%eax
   41e81:	0f 48 c2             	cmovs  %edx,%eax
   41e84:	c1 f8 08             	sar    $0x8,%eax
   41e87:	0f b6 c0             	movzbl %al,%eax
   41e8a:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41e91:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e94:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e98:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e9b:	ee                   	out    %al,(%dx)
}
   41e9c:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41e9d:	0f b7 05 3c e5 00 00 	movzwl 0xe53c(%rip),%eax        # 503e0 <interrupts_enabled>
   41ea4:	83 c8 01             	or     $0x1,%eax
   41ea7:	66 89 05 32 e5 00 00 	mov    %ax,0xe532(%rip)        # 503e0 <interrupts_enabled>
   41eae:	eb 11                	jmp    41ec1 <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41eb0:	0f b7 05 29 e5 00 00 	movzwl 0xe529(%rip),%eax        # 503e0 <interrupts_enabled>
   41eb7:	83 e0 fe             	and    $0xfffffffe,%eax
   41eba:	66 89 05 1f e5 00 00 	mov    %ax,0xe51f(%rip)        # 503e0 <interrupts_enabled>
    }
    interrupt_mask();
   41ec1:	e8 cc fd ff ff       	call   41c92 <interrupt_mask>
}
   41ec6:	90                   	nop
   41ec7:	c9                   	leave  
   41ec8:	c3                   	ret    

0000000000041ec9 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41ec9:	f3 0f 1e fa          	endbr64 
   41ecd:	55                   	push   %rbp
   41ece:	48 89 e5             	mov    %rsp,%rbp
   41ed1:	48 83 ec 08          	sub    $0x8,%rsp
   41ed5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41ed9:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41ede:	74 14                	je     41ef4 <physical_memory_isreserved+0x2b>
   41ee0:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41ee7:	00 
   41ee8:	76 11                	jbe    41efb <physical_memory_isreserved+0x32>
   41eea:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41ef1:	00 
   41ef2:	77 07                	ja     41efb <physical_memory_isreserved+0x32>
   41ef4:	b8 01 00 00 00       	mov    $0x1,%eax
   41ef9:	eb 05                	jmp    41f00 <physical_memory_isreserved+0x37>
   41efb:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41f00:	c9                   	leave  
   41f01:	c3                   	ret    

0000000000041f02 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41f02:	f3 0f 1e fa          	endbr64 
   41f06:	55                   	push   %rbp
   41f07:	48 89 e5             	mov    %rsp,%rbp
   41f0a:	48 83 ec 10          	sub    $0x10,%rsp
   41f0e:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41f11:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41f14:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41f17:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f1a:	c1 e0 10             	shl    $0x10,%eax
   41f1d:	89 c2                	mov    %eax,%edx
   41f1f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f22:	c1 e0 0b             	shl    $0xb,%eax
   41f25:	09 c2                	or     %eax,%edx
   41f27:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f2a:	c1 e0 08             	shl    $0x8,%eax
   41f2d:	09 d0                	or     %edx,%eax
}
   41f2f:	c9                   	leave  
   41f30:	c3                   	ret    

0000000000041f31 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41f31:	f3 0f 1e fa          	endbr64 
   41f35:	55                   	push   %rbp
   41f36:	48 89 e5             	mov    %rsp,%rbp
   41f39:	48 83 ec 18          	sub    $0x18,%rsp
   41f3d:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41f40:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41f43:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f46:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f49:	09 d0                	or     %edx,%eax
   41f4b:	0d 00 00 00 80       	or     $0x80000000,%eax
   41f50:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41f57:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41f5a:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f5d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f60:	ef                   	out    %eax,(%dx)
}
   41f61:	90                   	nop
   41f62:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41f69:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f6c:	89 c2                	mov    %eax,%edx
   41f6e:	ed                   	in     (%dx),%eax
   41f6f:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41f72:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41f75:	c9                   	leave  
   41f76:	c3                   	ret    

0000000000041f77 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41f77:	f3 0f 1e fa          	endbr64 
   41f7b:	55                   	push   %rbp
   41f7c:	48 89 e5             	mov    %rsp,%rbp
   41f7f:	48 83 ec 28          	sub    $0x28,%rsp
   41f83:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41f86:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41f89:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41f90:	eb 73                	jmp    42005 <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   41f92:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41f99:	eb 60                	jmp    41ffb <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   41f9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41fa2:	eb 4a                	jmp    41fee <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41fa4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41fa7:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41faa:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41fad:	89 ce                	mov    %ecx,%esi
   41faf:	89 c7                	mov    %eax,%edi
   41fb1:	e8 4c ff ff ff       	call   41f02 <pci_make_configaddr>
   41fb6:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41fb9:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fbc:	be 00 00 00 00       	mov    $0x0,%esi
   41fc1:	89 c7                	mov    %eax,%edi
   41fc3:	e8 69 ff ff ff       	call   41f31 <pci_config_readl>
   41fc8:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41fcb:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41fce:	c1 e0 10             	shl    $0x10,%eax
   41fd1:	0b 45 dc             	or     -0x24(%rbp),%eax
   41fd4:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41fd7:	75 05                	jne    41fde <pci_find_device+0x67>
                    return configaddr;
   41fd9:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fdc:	eb 35                	jmp    42013 <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41fde:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41fe2:	75 06                	jne    41fea <pci_find_device+0x73>
   41fe4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41fe8:	74 0c                	je     41ff6 <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   41fea:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41fee:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41ff2:	75 b0                	jne    41fa4 <pci_find_device+0x2d>
   41ff4:	eb 01                	jmp    41ff7 <pci_find_device+0x80>
                    break;
   41ff6:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41ff7:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41ffb:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41fff:	75 9a                	jne    41f9b <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   42001:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42005:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   4200c:	75 84                	jne    41f92 <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   4200e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   42013:	c9                   	leave  
   42014:	c3                   	ret    

0000000000042015 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   42015:	f3 0f 1e fa          	endbr64 
   42019:	55                   	push   %rbp
   4201a:	48 89 e5             	mov    %rsp,%rbp
   4201d:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42021:	be 13 71 00 00       	mov    $0x7113,%esi
   42026:	bf 86 80 00 00       	mov    $0x8086,%edi
   4202b:	e8 47 ff ff ff       	call   41f77 <pci_find_device>
   42030:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   42033:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   42037:	78 30                	js     42069 <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   42039:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4203c:	be 40 00 00 00       	mov    $0x40,%esi
   42041:	89 c7                	mov    %eax,%edi
   42043:	e8 e9 fe ff ff       	call   41f31 <pci_config_readl>
   42048:	25 c0 ff 00 00       	and    $0xffc0,%eax
   4204d:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42050:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42053:	83 c0 04             	add    $0x4,%eax
   42056:	89 45 f4             	mov    %eax,-0xc(%rbp)
   42059:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   4205f:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42063:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42066:	66 ef                	out    %ax,(%dx)
}
   42068:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42069:	48 8d 05 b0 34 00 00 	lea    0x34b0(%rip),%rax        # 45520 <memstate_colors+0x3a0>
   42070:	48 89 c2             	mov    %rax,%rdx
   42073:	be 00 c0 00 00       	mov    $0xc000,%esi
   42078:	bf 80 07 00 00       	mov    $0x780,%edi
   4207d:	b8 00 00 00 00       	mov    $0x0,%eax
   42082:	e8 1f 2f 00 00       	call   44fa6 <console_printf>
 spinloop: goto spinloop;
   42087:	eb fe                	jmp    42087 <poweroff+0x72>

0000000000042089 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   42089:	f3 0f 1e fa          	endbr64 
   4208d:	55                   	push   %rbp
   4208e:	48 89 e5             	mov    %rsp,%rbp
   42091:	48 83 ec 10          	sub    $0x10,%rsp
   42095:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   4209c:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420a0:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420a4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   420a7:	ee                   	out    %al,(%dx)
}
   420a8:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   420a9:	eb fe                	jmp    420a9 <reboot+0x20>

00000000000420ab <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   420ab:	f3 0f 1e fa          	endbr64 
   420af:	55                   	push   %rbp
   420b0:	48 89 e5             	mov    %rsp,%rbp
   420b3:	48 83 ec 10          	sub    $0x10,%rsp
   420b7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   420bb:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   420be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420c2:	48 83 c0 18          	add    $0x18,%rax
   420c6:	ba c0 00 00 00       	mov    $0xc0,%edx
   420cb:	be 00 00 00 00       	mov    $0x0,%esi
   420d0:	48 89 c7             	mov    %rax,%rdi
   420d3:	e8 8f 20 00 00       	call   44167 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   420d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420dc:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   420e3:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   420e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420e9:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   420f0:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   420f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420f8:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   420ff:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   42103:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42107:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   4210e:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   42110:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42114:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   4211b:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   4211f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42122:	83 e0 01             	and    $0x1,%eax
   42125:	85 c0                	test   %eax,%eax
   42127:	74 1c                	je     42145 <process_init+0x9a>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   42129:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4212d:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   42134:	80 cc 30             	or     $0x30,%ah
   42137:	48 89 c2             	mov    %rax,%rdx
   4213a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4213e:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42145:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42148:	83 e0 02             	and    $0x2,%eax
   4214b:	85 c0                	test   %eax,%eax
   4214d:	74 1c                	je     4216b <process_init+0xc0>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   4214f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42153:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   4215a:	80 e4 fd             	and    $0xfd,%ah
   4215d:	48 89 c2             	mov    %rax,%rdx
   42160:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42164:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   4216b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4216f:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   42176:	90                   	nop
   42177:	c9                   	leave  
   42178:	c3                   	ret    

0000000000042179 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42179:	f3 0f 1e fa          	endbr64 
   4217d:	55                   	push   %rbp
   4217e:	48 89 e5             	mov    %rsp,%rbp
   42181:	48 83 ec 28          	sub    $0x28,%rsp
   42185:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42188:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4218c:	78 09                	js     42197 <console_show_cursor+0x1e>
   4218e:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   42195:	7e 07                	jle    4219e <console_show_cursor+0x25>
        cpos = 0;
   42197:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   4219e:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   421a5:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421a9:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   421ad:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   421b0:	ee                   	out    %al,(%dx)
}
   421b1:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   421b2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   421b5:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   421bb:	85 c0                	test   %eax,%eax
   421bd:	0f 48 c2             	cmovs  %edx,%eax
   421c0:	c1 f8 08             	sar    $0x8,%eax
   421c3:	0f b6 c0             	movzbl %al,%eax
   421c6:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   421cd:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421d0:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   421d4:	8b 55 ec             	mov    -0x14(%rbp),%edx
   421d7:	ee                   	out    %al,(%dx)
}
   421d8:	90                   	nop
   421d9:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   421e0:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421e4:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   421e8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   421eb:	ee                   	out    %al,(%dx)
}
   421ec:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   421ed:	8b 45 dc             	mov    -0x24(%rbp),%eax
   421f0:	99                   	cltd   
   421f1:	c1 ea 18             	shr    $0x18,%edx
   421f4:	01 d0                	add    %edx,%eax
   421f6:	0f b6 c0             	movzbl %al,%eax
   421f9:	29 d0                	sub    %edx,%eax
   421fb:	0f b6 c0             	movzbl %al,%eax
   421fe:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   42205:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42208:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4220c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4220f:	ee                   	out    %al,(%dx)
}
   42210:	90                   	nop
}
   42211:	90                   	nop
   42212:	c9                   	leave  
   42213:	c3                   	ret    

0000000000042214 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   42214:	f3 0f 1e fa          	endbr64 
   42218:	55                   	push   %rbp
   42219:	48 89 e5             	mov    %rsp,%rbp
   4221c:	48 83 ec 20          	sub    $0x20,%rsp
   42220:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42227:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4222a:	89 c2                	mov    %eax,%edx
   4222c:	ec                   	in     (%dx),%al
   4222d:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42230:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   42234:	0f b6 c0             	movzbl %al,%eax
   42237:	83 e0 01             	and    $0x1,%eax
   4223a:	85 c0                	test   %eax,%eax
   4223c:	75 0a                	jne    42248 <keyboard_readc+0x34>
        return -1;
   4223e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42243:	e9 fd 01 00 00       	jmp    42445 <keyboard_readc+0x231>
   42248:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4224f:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42252:	89 c2                	mov    %eax,%edx
   42254:	ec                   	in     (%dx),%al
   42255:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42258:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   4225c:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   4225f:	0f b6 05 7c e1 00 00 	movzbl 0xe17c(%rip),%eax        # 503e2 <last_escape.2>
   42266:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42269:	c6 05 72 e1 00 00 00 	movb   $0x0,0xe172(%rip)        # 503e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42270:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42274:	75 11                	jne    42287 <keyboard_readc+0x73>
        last_escape = 0x80;
   42276:	c6 05 65 e1 00 00 80 	movb   $0x80,0xe165(%rip)        # 503e2 <last_escape.2>
        return 0;
   4227d:	b8 00 00 00 00       	mov    $0x0,%eax
   42282:	e9 be 01 00 00       	jmp    42445 <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42287:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4228b:	84 c0                	test   %al,%al
   4228d:	79 64                	jns    422f3 <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   4228f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42293:	83 e0 7f             	and    $0x7f,%eax
   42296:	89 c2                	mov    %eax,%edx
   42298:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   4229c:	09 d0                	or     %edx,%eax
   4229e:	48 98                	cltq   
   422a0:	48 8d 15 99 32 00 00 	lea    0x3299(%rip),%rdx        # 45540 <keymap>
   422a7:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   422ab:	0f b6 c0             	movzbl %al,%eax
   422ae:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   422b1:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   422b8:	7e 2f                	jle    422e9 <keyboard_readc+0xd5>
   422ba:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   422c1:	7f 26                	jg     422e9 <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   422c3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422c6:	2d fa 00 00 00       	sub    $0xfa,%eax
   422cb:	ba 01 00 00 00       	mov    $0x1,%edx
   422d0:	89 c1                	mov    %eax,%ecx
   422d2:	d3 e2                	shl    %cl,%edx
   422d4:	89 d0                	mov    %edx,%eax
   422d6:	f7 d0                	not    %eax
   422d8:	89 c2                	mov    %eax,%edx
   422da:	0f b6 05 02 e1 00 00 	movzbl 0xe102(%rip),%eax        # 503e3 <modifiers.1>
   422e1:	21 d0                	and    %edx,%eax
   422e3:	88 05 fa e0 00 00    	mov    %al,0xe0fa(%rip)        # 503e3 <modifiers.1>
        }
        return 0;
   422e9:	b8 00 00 00 00       	mov    $0x0,%eax
   422ee:	e9 52 01 00 00       	jmp    42445 <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   422f3:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   422f7:	0a 45 fa             	or     -0x6(%rbp),%al
   422fa:	0f b6 c0             	movzbl %al,%eax
   422fd:	48 98                	cltq   
   422ff:	48 8d 15 3a 32 00 00 	lea    0x323a(%rip),%rdx        # 45540 <keymap>
   42306:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   4230a:	0f b6 c0             	movzbl %al,%eax
   4230d:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42310:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42314:	7e 57                	jle    4236d <keyboard_readc+0x159>
   42316:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   4231a:	7f 51                	jg     4236d <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   4231c:	0f b6 05 c0 e0 00 00 	movzbl 0xe0c0(%rip),%eax        # 503e3 <modifiers.1>
   42323:	0f b6 c0             	movzbl %al,%eax
   42326:	83 e0 02             	and    $0x2,%eax
   42329:	85 c0                	test   %eax,%eax
   4232b:	74 09                	je     42336 <keyboard_readc+0x122>
            ch -= 0x60;
   4232d:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42331:	e9 0b 01 00 00       	jmp    42441 <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42336:	0f b6 05 a6 e0 00 00 	movzbl 0xe0a6(%rip),%eax        # 503e3 <modifiers.1>
   4233d:	0f b6 c0             	movzbl %al,%eax
   42340:	83 e0 01             	and    $0x1,%eax
   42343:	85 c0                	test   %eax,%eax
   42345:	0f 94 c2             	sete   %dl
   42348:	0f b6 05 94 e0 00 00 	movzbl 0xe094(%rip),%eax        # 503e3 <modifiers.1>
   4234f:	0f b6 c0             	movzbl %al,%eax
   42352:	83 e0 08             	and    $0x8,%eax
   42355:	85 c0                	test   %eax,%eax
   42357:	0f 94 c0             	sete   %al
   4235a:	31 d0                	xor    %edx,%eax
   4235c:	84 c0                	test   %al,%al
   4235e:	0f 84 dd 00 00 00    	je     42441 <keyboard_readc+0x22d>
            ch -= 0x20;
   42364:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42368:	e9 d4 00 00 00       	jmp    42441 <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4236d:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42374:	7e 30                	jle    423a6 <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42376:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42379:	2d fa 00 00 00       	sub    $0xfa,%eax
   4237e:	ba 01 00 00 00       	mov    $0x1,%edx
   42383:	89 c1                	mov    %eax,%ecx
   42385:	d3 e2                	shl    %cl,%edx
   42387:	89 d0                	mov    %edx,%eax
   42389:	89 c2                	mov    %eax,%edx
   4238b:	0f b6 05 51 e0 00 00 	movzbl 0xe051(%rip),%eax        # 503e3 <modifiers.1>
   42392:	31 d0                	xor    %edx,%eax
   42394:	88 05 49 e0 00 00    	mov    %al,0xe049(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   4239a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   423a1:	e9 9c 00 00 00       	jmp    42442 <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   423a6:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   423ad:	7e 2d                	jle    423dc <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   423af:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423b2:	2d fa 00 00 00       	sub    $0xfa,%eax
   423b7:	ba 01 00 00 00       	mov    $0x1,%edx
   423bc:	89 c1                	mov    %eax,%ecx
   423be:	d3 e2                	shl    %cl,%edx
   423c0:	89 d0                	mov    %edx,%eax
   423c2:	89 c2                	mov    %eax,%edx
   423c4:	0f b6 05 18 e0 00 00 	movzbl 0xe018(%rip),%eax        # 503e3 <modifiers.1>
   423cb:	09 d0                	or     %edx,%eax
   423cd:	88 05 10 e0 00 00    	mov    %al,0xe010(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   423d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   423da:	eb 66                	jmp    42442 <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   423dc:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   423e0:	7e 3f                	jle    42421 <keyboard_readc+0x20d>
   423e2:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   423e9:	7f 36                	jg     42421 <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   423eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423ee:	8d 50 80             	lea    -0x80(%rax),%edx
   423f1:	0f b6 05 eb df 00 00 	movzbl 0xdfeb(%rip),%eax        # 503e3 <modifiers.1>
   423f8:	0f b6 c0             	movzbl %al,%eax
   423fb:	83 e0 03             	and    $0x3,%eax
   423fe:	48 63 c8             	movslq %eax,%rcx
   42401:	48 63 c2             	movslq %edx,%rax
   42404:	48 c1 e0 02          	shl    $0x2,%rax
   42408:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   4240c:	48 8d 05 2d 32 00 00 	lea    0x322d(%rip),%rax        # 45640 <complex_keymap>
   42413:	48 01 d0             	add    %rdx,%rax
   42416:	0f b6 00             	movzbl (%rax),%eax
   42419:	0f b6 c0             	movzbl %al,%eax
   4241c:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4241f:	eb 21                	jmp    42442 <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42421:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42425:	7f 1b                	jg     42442 <keyboard_readc+0x22e>
   42427:	0f b6 05 b5 df 00 00 	movzbl 0xdfb5(%rip),%eax        # 503e3 <modifiers.1>
   4242e:	0f b6 c0             	movzbl %al,%eax
   42431:	83 e0 02             	and    $0x2,%eax
   42434:	85 c0                	test   %eax,%eax
   42436:	74 0a                	je     42442 <keyboard_readc+0x22e>
        ch = 0;
   42438:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4243f:	eb 01                	jmp    42442 <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   42441:	90                   	nop
    }

    return ch;
   42442:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42445:	c9                   	leave  
   42446:	c3                   	ret    

0000000000042447 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42447:	f3 0f 1e fa          	endbr64 
   4244b:	55                   	push   %rbp
   4244c:	48 89 e5             	mov    %rsp,%rbp
   4244f:	48 83 ec 20          	sub    $0x20,%rsp
   42453:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4245a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4245d:	89 c2                	mov    %eax,%edx
   4245f:	ec                   	in     (%dx),%al
   42460:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42463:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   4246a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4246d:	89 c2                	mov    %eax,%edx
   4246f:	ec                   	in     (%dx),%al
   42470:	88 45 eb             	mov    %al,-0x15(%rbp)
   42473:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   4247a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4247d:	89 c2                	mov    %eax,%edx
   4247f:	ec                   	in     (%dx),%al
   42480:	88 45 f3             	mov    %al,-0xd(%rbp)
   42483:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   4248a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4248d:	89 c2                	mov    %eax,%edx
   4248f:	ec                   	in     (%dx),%al
   42490:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42493:	90                   	nop
   42494:	c9                   	leave  
   42495:	c3                   	ret    

0000000000042496 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42496:	f3 0f 1e fa          	endbr64 
   4249a:	55                   	push   %rbp
   4249b:	48 89 e5             	mov    %rsp,%rbp
   4249e:	48 83 ec 40          	sub    $0x40,%rsp
   424a2:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   424a6:	89 f0                	mov    %esi,%eax
   424a8:	89 55 c0             	mov    %edx,-0x40(%rbp)
   424ab:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   424ae:	8b 05 30 df 00 00    	mov    0xdf30(%rip),%eax        # 503e4 <initialized.0>
   424b4:	85 c0                	test   %eax,%eax
   424b6:	75 1e                	jne    424d6 <parallel_port_putc+0x40>
   424b8:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   424bf:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424c3:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   424c7:	8b 55 f8             	mov    -0x8(%rbp),%edx
   424ca:	ee                   	out    %al,(%dx)
}
   424cb:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   424cc:	c7 05 0e df 00 00 01 	movl   $0x1,0xdf0e(%rip)        # 503e4 <initialized.0>
   424d3:	00 00 00 
    }

    for (int i = 0;
   424d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   424dd:	eb 09                	jmp    424e8 <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   424df:	e8 63 ff ff ff       	call   42447 <delay>
         ++i) {
   424e4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   424e8:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   424ef:	7f 18                	jg     42509 <parallel_port_putc+0x73>
   424f1:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   424f8:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424fb:	89 c2                	mov    %eax,%edx
   424fd:	ec                   	in     (%dx),%al
   424fe:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42501:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42505:	84 c0                	test   %al,%al
   42507:	79 d6                	jns    424df <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   42509:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   4250d:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42514:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42517:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   4251b:	8b 55 d8             	mov    -0x28(%rbp),%edx
   4251e:	ee                   	out    %al,(%dx)
}
   4251f:	90                   	nop
   42520:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42527:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4252b:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   4252f:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42532:	ee                   	out    %al,(%dx)
}
   42533:	90                   	nop
   42534:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   4253b:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4253f:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42543:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42546:	ee                   	out    %al,(%dx)
}
   42547:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42548:	90                   	nop
   42549:	c9                   	leave  
   4254a:	c3                   	ret    

000000000004254b <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   4254b:	f3 0f 1e fa          	endbr64 
   4254f:	55                   	push   %rbp
   42550:	48 89 e5             	mov    %rsp,%rbp
   42553:	48 83 ec 20          	sub    $0x20,%rsp
   42557:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4255b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   4255f:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 42496 <parallel_port_putc>
   42566:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   4256a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   4256e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42572:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42576:	be 00 00 00 00       	mov    $0x0,%esi
   4257b:	48 89 c7             	mov    %rax,%rdi
   4257e:	e8 aa 1e 00 00       	call   4442d <printer_vprintf>
}
   42583:	90                   	nop
   42584:	c9                   	leave  
   42585:	c3                   	ret    

0000000000042586 <log_printf>:

void log_printf(const char* format, ...) {
   42586:	f3 0f 1e fa          	endbr64 
   4258a:	55                   	push   %rbp
   4258b:	48 89 e5             	mov    %rsp,%rbp
   4258e:	48 83 ec 60          	sub    $0x60,%rsp
   42592:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42596:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4259a:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4259e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   425a2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   425a6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   425aa:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   425b1:	48 8d 45 10          	lea    0x10(%rbp),%rax
   425b5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   425b9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   425bd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   425c1:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   425c5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   425c9:	48 89 d6             	mov    %rdx,%rsi
   425cc:	48 89 c7             	mov    %rax,%rdi
   425cf:	e8 77 ff ff ff       	call   4254b <log_vprintf>
    va_end(val);
}
   425d4:	90                   	nop
   425d5:	c9                   	leave  
   425d6:	c3                   	ret    

00000000000425d7 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   425d7:	f3 0f 1e fa          	endbr64 
   425db:	55                   	push   %rbp
   425dc:	48 89 e5             	mov    %rsp,%rbp
   425df:	48 83 ec 40          	sub    $0x40,%rsp
   425e3:	89 7d dc             	mov    %edi,-0x24(%rbp)
   425e6:	89 75 d8             	mov    %esi,-0x28(%rbp)
   425e9:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   425ed:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   425f1:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   425f5:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   425f9:	48 8b 0a             	mov    (%rdx),%rcx
   425fc:	48 89 08             	mov    %rcx,(%rax)
   425ff:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42603:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42607:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   4260b:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   4260f:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42613:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42617:	48 89 d6             	mov    %rdx,%rsi
   4261a:	48 89 c7             	mov    %rax,%rdi
   4261d:	e8 29 ff ff ff       	call   4254b <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42622:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42626:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4262a:	8b 75 d8             	mov    -0x28(%rbp),%esi
   4262d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42630:	89 c7                	mov    %eax,%edi
   42632:	e8 f3 28 00 00       	call   44f2a <console_vprintf>
}
   42637:	c9                   	leave  
   42638:	c3                   	ret    

0000000000042639 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42639:	f3 0f 1e fa          	endbr64 
   4263d:	55                   	push   %rbp
   4263e:	48 89 e5             	mov    %rsp,%rbp
   42641:	48 83 ec 60          	sub    $0x60,%rsp
   42645:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42648:	89 75 a8             	mov    %esi,-0x58(%rbp)
   4264b:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   4264f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42653:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42657:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4265b:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42662:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42666:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4266a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4266e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42672:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42676:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4267a:	8b 75 a8             	mov    -0x58(%rbp),%esi
   4267d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42680:	89 c7                	mov    %eax,%edi
   42682:	e8 50 ff ff ff       	call   425d7 <error_vprintf>
   42687:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4268a:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4268d:	c9                   	leave  
   4268e:	c3                   	ret    

000000000004268f <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   4268f:	f3 0f 1e fa          	endbr64 
   42693:	55                   	push   %rbp
   42694:	48 89 e5             	mov    %rsp,%rbp
   42697:	53                   	push   %rbx
   42698:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   4269c:	e8 73 fb ff ff       	call   42214 <keyboard_readc>
   426a1:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   426a4:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   426a8:	74 1c                	je     426c6 <check_keyboard+0x37>
   426aa:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   426ae:	74 16                	je     426c6 <check_keyboard+0x37>
   426b0:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   426b4:	74 10                	je     426c6 <check_keyboard+0x37>
   426b6:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   426ba:	74 0a                	je     426c6 <check_keyboard+0x37>
   426bc:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   426c0:	0f 85 02 01 00 00    	jne    427c8 <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   426c6:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   426cd:	00 
        memset(pt, 0, PAGESIZE * 3);
   426ce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426d2:	ba 00 30 00 00       	mov    $0x3000,%edx
   426d7:	be 00 00 00 00       	mov    $0x0,%esi
   426dc:	48 89 c7             	mov    %rax,%rdi
   426df:	e8 83 1a 00 00       	call   44167 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   426e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426e8:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   426ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426f3:	48 05 00 10 00 00    	add    $0x1000,%rax
   426f9:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42700:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42704:	48 05 00 20 00 00    	add    $0x2000,%rax
   4270a:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42711:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42715:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42719:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4271d:	0f 22 d8             	mov    %rax,%cr3
}
   42720:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42721:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   42728:	48 8d 05 69 2f 00 00 	lea    0x2f69(%rip),%rax        # 45698 <complex_keymap+0x58>
   4272f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   42733:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42737:	75 0d                	jne    42746 <check_keyboard+0xb7>
            argument = "allocator";
   42739:	48 8d 05 5f 2f 00 00 	lea    0x2f5f(%rip),%rax        # 4569f <complex_keymap+0x5f>
   42740:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42744:	eb 37                	jmp    4277d <check_keyboard+0xee>
        } else if (c == 'c') {
   42746:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   4274a:	75 0d                	jne    42759 <check_keyboard+0xca>
            argument = "alloctests";
   4274c:	48 8d 05 56 2f 00 00 	lea    0x2f56(%rip),%rax        # 456a9 <complex_keymap+0x69>
   42753:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42757:	eb 24                	jmp    4277d <check_keyboard+0xee>
        } else if(c == 't'){
   42759:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4275d:	75 0d                	jne    4276c <check_keyboard+0xdd>
            argument = "test";
   4275f:	48 8d 05 4e 2f 00 00 	lea    0x2f4e(%rip),%rax        # 456b4 <complex_keymap+0x74>
   42766:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4276a:	eb 11                	jmp    4277d <check_keyboard+0xee>
        }
        else if(c == '2'){
   4276c:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42770:	75 0b                	jne    4277d <check_keyboard+0xee>
            argument = "test2";
   42772:	48 8d 05 40 2f 00 00 	lea    0x2f40(%rip),%rax        # 456b9 <complex_keymap+0x79>
   42779:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4277d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42781:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42785:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4278a:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   4278e:	76 1e                	jbe    427ae <check_keyboard+0x11f>
   42790:	48 8d 05 28 2f 00 00 	lea    0x2f28(%rip),%rax        # 456bf <complex_keymap+0x7f>
   42797:	48 89 c2             	mov    %rax,%rdx
   4279a:	be 5c 02 00 00       	mov    $0x25c,%esi
   4279f:	48 8d 05 35 2f 00 00 	lea    0x2f35(%rip),%rax        # 456db <complex_keymap+0x9b>
   427a6:	48 89 c7             	mov    %rax,%rdi
   427a9:	e8 33 01 00 00       	call   428e1 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   427ae:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   427b2:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   427b5:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   427b9:	48 89 c3             	mov    %rax,%rbx
   427bc:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   427c1:	e9 3a d8 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   427c6:	eb 11                	jmp    427d9 <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   427c8:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   427cc:	74 06                	je     427d4 <check_keyboard+0x145>
   427ce:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   427d2:	75 05                	jne    427d9 <check_keyboard+0x14a>
        poweroff();
   427d4:	e8 3c f8 ff ff       	call   42015 <poweroff>
    }
    return c;
   427d9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   427dc:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   427e0:	c9                   	leave  
   427e1:	c3                   	ret    

00000000000427e2 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   427e2:	f3 0f 1e fa          	endbr64 
   427e6:	55                   	push   %rbp
   427e7:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   427ea:	e8 a0 fe ff ff       	call   4268f <check_keyboard>
   427ef:	eb f9                	jmp    427ea <fail+0x8>

00000000000427f1 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   427f1:	f3 0f 1e fa          	endbr64 
   427f5:	55                   	push   %rbp
   427f6:	48 89 e5             	mov    %rsp,%rbp
   427f9:	48 83 ec 60          	sub    $0x60,%rsp
   427fd:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42801:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42805:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42809:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4280d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42811:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42815:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4281c:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42820:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42824:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42828:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4282c:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42831:	0f 84 87 00 00 00    	je     428be <kernel_panic+0xcd>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42837:	48 8d 05 b1 2e 00 00 	lea    0x2eb1(%rip),%rax        # 456ef <complex_keymap+0xaf>
   4283e:	48 89 c2             	mov    %rax,%rdx
   42841:	be 00 c0 00 00       	mov    $0xc000,%esi
   42846:	bf 30 07 00 00       	mov    $0x730,%edi
   4284b:	b8 00 00 00 00       	mov    $0x0,%eax
   42850:	e8 e4 fd ff ff       	call   42639 <error_printf>
   42855:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42858:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4285c:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42860:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42863:	be 00 c0 00 00       	mov    $0xc000,%esi
   42868:	89 c7                	mov    %eax,%edi
   4286a:	e8 68 fd ff ff       	call   425d7 <error_vprintf>
   4286f:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42872:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42875:	48 63 c1             	movslq %ecx,%rax
   42878:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4287f:	48 c1 e8 20          	shr    $0x20,%rax
   42883:	c1 f8 05             	sar    $0x5,%eax
   42886:	89 ce                	mov    %ecx,%esi
   42888:	c1 fe 1f             	sar    $0x1f,%esi
   4288b:	29 f0                	sub    %esi,%eax
   4288d:	89 c2                	mov    %eax,%edx
   4288f:	89 d0                	mov    %edx,%eax
   42891:	c1 e0 02             	shl    $0x2,%eax
   42894:	01 d0                	add    %edx,%eax
   42896:	c1 e0 04             	shl    $0x4,%eax
   42899:	29 c1                	sub    %eax,%ecx
   4289b:	89 ca                	mov    %ecx,%edx
   4289d:	85 d2                	test   %edx,%edx
   4289f:	74 3b                	je     428dc <kernel_panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   428a1:	8b 45 cc             	mov    -0x34(%rbp),%eax
   428a4:	48 8d 15 4c 2e 00 00 	lea    0x2e4c(%rip),%rdx        # 456f7 <complex_keymap+0xb7>
   428ab:	be 00 c0 00 00       	mov    $0xc000,%esi
   428b0:	89 c7                	mov    %eax,%edi
   428b2:	b8 00 00 00 00       	mov    $0x0,%eax
   428b7:	e8 7d fd ff ff       	call   42639 <error_printf>
   428bc:	eb 1e                	jmp    428dc <kernel_panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   428be:	48 8d 05 34 2e 00 00 	lea    0x2e34(%rip),%rax        # 456f9 <complex_keymap+0xb9>
   428c5:	48 89 c2             	mov    %rax,%rdx
   428c8:	be 00 c0 00 00       	mov    $0xc000,%esi
   428cd:	bf 30 07 00 00       	mov    $0x730,%edi
   428d2:	b8 00 00 00 00       	mov    $0x0,%eax
   428d7:	e8 5d fd ff ff       	call   42639 <error_printf>
    }

    va_end(val);
    fail();
   428dc:	e8 01 ff ff ff       	call   427e2 <fail>

00000000000428e1 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   428e1:	f3 0f 1e fa          	endbr64 
   428e5:	55                   	push   %rbp
   428e6:	48 89 e5             	mov    %rsp,%rbp
   428e9:	48 83 ec 20          	sub    $0x20,%rsp
   428ed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   428f1:	89 75 f4             	mov    %esi,-0xc(%rbp)
   428f4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   428f8:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   428fc:	8b 55 f4             	mov    -0xc(%rbp),%edx
   428ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42903:	48 89 c6             	mov    %rax,%rsi
   42906:	48 8d 05 f2 2d 00 00 	lea    0x2df2(%rip),%rax        # 456ff <complex_keymap+0xbf>
   4290d:	48 89 c7             	mov    %rax,%rdi
   42910:	b8 00 00 00 00       	mov    $0x0,%eax
   42915:	e8 d7 fe ff ff       	call   427f1 <kernel_panic>

000000000004291a <default_exception>:
}

void default_exception(proc* p){
   4291a:	f3 0f 1e fa          	endbr64 
   4291e:	55                   	push   %rbp
   4291f:	48 89 e5             	mov    %rsp,%rbp
   42922:	48 83 ec 20          	sub    $0x20,%rsp
   42926:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   4292a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4292e:	48 83 c0 18          	add    $0x18,%rax
   42932:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   42936:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4293a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42941:	48 89 c6             	mov    %rax,%rsi
   42944:	48 8d 05 d2 2d 00 00 	lea    0x2dd2(%rip),%rax        # 4571d <complex_keymap+0xdd>
   4294b:	48 89 c7             	mov    %rax,%rdi
   4294e:	b8 00 00 00 00       	mov    $0x0,%eax
   42953:	e8 99 fe ff ff       	call   427f1 <kernel_panic>

0000000000042958 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42958:	55                   	push   %rbp
   42959:	48 89 e5             	mov    %rsp,%rbp
   4295c:	48 83 ec 10          	sub    $0x10,%rsp
   42960:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42964:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42967:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4296b:	78 06                	js     42973 <pageindex+0x1b>
   4296d:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42971:	7e 1e                	jle    42991 <pageindex+0x39>
   42973:	48 8d 05 be 2d 00 00 	lea    0x2dbe(%rip),%rax        # 45738 <complex_keymap+0xf8>
   4297a:	48 89 c2             	mov    %rax,%rdx
   4297d:	be 1e 00 00 00       	mov    $0x1e,%esi
   42982:	48 8d 05 c8 2d 00 00 	lea    0x2dc8(%rip),%rax        # 45751 <complex_keymap+0x111>
   42989:	48 89 c7             	mov    %rax,%rdi
   4298c:	e8 50 ff ff ff       	call   428e1 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42991:	b8 03 00 00 00       	mov    $0x3,%eax
   42996:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42999:	89 c2                	mov    %eax,%edx
   4299b:	89 d0                	mov    %edx,%eax
   4299d:	c1 e0 03             	shl    $0x3,%eax
   429a0:	01 d0                	add    %edx,%eax
   429a2:	83 c0 0c             	add    $0xc,%eax
   429a5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   429a9:	89 c1                	mov    %eax,%ecx
   429ab:	48 d3 ea             	shr    %cl,%rdx
   429ae:	48 89 d0             	mov    %rdx,%rax
   429b1:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   429b6:	c9                   	leave  
   429b7:	c3                   	ret    

00000000000429b8 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   429b8:	f3 0f 1e fa          	endbr64 
   429bc:	55                   	push   %rbp
   429bd:	48 89 e5             	mov    %rsp,%rbp
   429c0:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   429c4:	48 8d 05 35 f6 00 00 	lea    0xf635(%rip),%rax        # 52000 <kernel_pagetables>
   429cb:	48 89 05 2e e6 00 00 	mov    %rax,0xe62e(%rip)        # 51000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   429d2:	ba 00 50 00 00       	mov    $0x5000,%edx
   429d7:	be 00 00 00 00       	mov    $0x0,%esi
   429dc:	48 8d 05 1d f6 00 00 	lea    0xf61d(%rip),%rax        # 52000 <kernel_pagetables>
   429e3:	48 89 c7             	mov    %rax,%rdi
   429e6:	e8 7c 17 00 00       	call   44167 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   429eb:	48 8d 05 0e 06 01 00 	lea    0x1060e(%rip),%rax        # 53000 <kernel_pagetables+0x1000>
   429f2:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   429f6:	48 89 05 03 f6 00 00 	mov    %rax,0xf603(%rip)        # 52000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   429fd:	48 8d 05 fc 15 01 00 	lea    0x115fc(%rip),%rax        # 54000 <kernel_pagetables+0x2000>
   42a04:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42a08:	48 89 05 f1 05 01 00 	mov    %rax,0x105f1(%rip)        # 53000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42a0f:	48 8d 05 ea 25 01 00 	lea    0x125ea(%rip),%rax        # 55000 <kernel_pagetables+0x3000>
   42a16:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42a1a:	48 89 05 df 15 01 00 	mov    %rax,0x115df(%rip)        # 54000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42a21:	48 8d 05 d8 35 01 00 	lea    0x135d8(%rip),%rax        # 56000 <kernel_pagetables+0x4000>
   42a28:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42a2c:	48 89 05 d5 15 01 00 	mov    %rax,0x115d5(%rip)        # 54008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42a33:	48 8b 05 c6 e5 00 00 	mov    0xe5c6(%rip),%rax        # 51000 <kernel_pagetable>
   42a3a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42a40:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42a45:	ba 00 00 00 00       	mov    $0x0,%edx
   42a4a:	be 00 00 00 00       	mov    $0x0,%esi
   42a4f:	48 89 c7             	mov    %rax,%rdi
   42a52:	e8 0e 02 00 00       	call   42c65 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42a57:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42a5e:	00 
   42a5f:	eb 76                	jmp    42ad7 <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42a61:	48 8b 0d 98 e5 00 00 	mov    0xe598(%rip),%rcx        # 51000 <kernel_pagetable>
   42a68:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42a6c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42a70:	48 89 ce             	mov    %rcx,%rsi
   42a73:	48 89 c7             	mov    %rax,%rdi
   42a76:	e8 36 06 00 00       	call   430b1 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   42a7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a7f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42a83:	74 1e                	je     42aa3 <virtual_memory_init+0xeb>
   42a85:	48 8d 05 d9 2c 00 00 	lea    0x2cd9(%rip),%rax        # 45765 <complex_keymap+0x125>
   42a8c:	48 89 c2             	mov    %rax,%rdx
   42a8f:	be 2d 00 00 00       	mov    $0x2d,%esi
   42a94:	48 8d 05 da 2c 00 00 	lea    0x2cda(%rip),%rax        # 45775 <complex_keymap+0x135>
   42a9b:	48 89 c7             	mov    %rax,%rdi
   42a9e:	e8 3e fe ff ff       	call   428e1 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42aa3:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42aa6:	48 98                	cltq   
   42aa8:	83 e0 03             	and    $0x3,%eax
   42aab:	48 83 f8 03          	cmp    $0x3,%rax
   42aaf:	74 1e                	je     42acf <virtual_memory_init+0x117>
   42ab1:	48 8d 05 d0 2c 00 00 	lea    0x2cd0(%rip),%rax        # 45788 <complex_keymap+0x148>
   42ab8:	48 89 c2             	mov    %rax,%rdx
   42abb:	be 2e 00 00 00       	mov    $0x2e,%esi
   42ac0:	48 8d 05 ae 2c 00 00 	lea    0x2cae(%rip),%rax        # 45775 <complex_keymap+0x135>
   42ac7:	48 89 c7             	mov    %rax,%rdi
   42aca:	e8 12 fe ff ff       	call   428e1 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42acf:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42ad6:	00 
   42ad7:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42ade:	00 
   42adf:	76 80                	jbe    42a61 <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42ae1:	48 8b 05 18 e5 00 00 	mov    0xe518(%rip),%rax        # 51000 <kernel_pagetable>
   42ae8:	48 89 c7             	mov    %rax,%rdi
   42aeb:	e8 03 00 00 00       	call   42af3 <set_pagetable>
}
   42af0:	90                   	nop
   42af1:	c9                   	leave  
   42af2:	c3                   	ret    

0000000000042af3 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42af3:	f3 0f 1e fa          	endbr64 
   42af7:	55                   	push   %rbp
   42af8:	48 89 e5             	mov    %rsp,%rbp
   42afb:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42aff:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42b03:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42b07:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b0c:	48 85 c0             	test   %rax,%rax
   42b0f:	74 1e                	je     42b2f <set_pagetable+0x3c>
   42b11:	48 8d 05 9d 2c 00 00 	lea    0x2c9d(%rip),%rax        # 457b5 <complex_keymap+0x175>
   42b18:	48 89 c2             	mov    %rax,%rdx
   42b1b:	be 3d 00 00 00       	mov    $0x3d,%esi
   42b20:	48 8d 05 4e 2c 00 00 	lea    0x2c4e(%rip),%rax        # 45775 <complex_keymap+0x135>
   42b27:	48 89 c7             	mov    %rax,%rdi
   42b2a:	e8 b2 fd ff ff       	call   428e1 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42b2f:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   42b36:	48 89 c2             	mov    %rax,%rdx
   42b39:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42b3d:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42b41:	48 89 ce             	mov    %rcx,%rsi
   42b44:	48 89 c7             	mov    %rax,%rdi
   42b47:	e8 65 05 00 00       	call   430b1 <virtual_memory_lookup>
   42b4c:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42b50:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   42b57:	48 39 d0             	cmp    %rdx,%rax
   42b5a:	74 1e                	je     42b7a <set_pagetable+0x87>
   42b5c:	48 8d 05 6d 2c 00 00 	lea    0x2c6d(%rip),%rax        # 457d0 <complex_keymap+0x190>
   42b63:	48 89 c2             	mov    %rax,%rdx
   42b66:	be 3f 00 00 00       	mov    $0x3f,%esi
   42b6b:	48 8d 05 03 2c 00 00 	lea    0x2c03(%rip),%rax        # 45775 <complex_keymap+0x135>
   42b72:	48 89 c7             	mov    %rax,%rdi
   42b75:	e8 67 fd ff ff       	call   428e1 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42b7a:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42b7e:	48 8b 0d 7b e4 00 00 	mov    0xe47b(%rip),%rcx        # 51000 <kernel_pagetable>
   42b85:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42b89:	48 89 ce             	mov    %rcx,%rsi
   42b8c:	48 89 c7             	mov    %rax,%rdi
   42b8f:	e8 1d 05 00 00       	call   430b1 <virtual_memory_lookup>
   42b94:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42b98:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42b9c:	48 39 c2             	cmp    %rax,%rdx
   42b9f:	74 1e                	je     42bbf <set_pagetable+0xcc>
   42ba1:	48 8d 05 90 2c 00 00 	lea    0x2c90(%rip),%rax        # 45838 <complex_keymap+0x1f8>
   42ba8:	48 89 c2             	mov    %rax,%rdx
   42bab:	be 41 00 00 00       	mov    $0x41,%esi
   42bb0:	48 8d 05 be 2b 00 00 	lea    0x2bbe(%rip),%rax        # 45775 <complex_keymap+0x135>
   42bb7:	48 89 c7             	mov    %rax,%rdi
   42bba:	e8 22 fd ff ff       	call   428e1 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42bbf:	48 8b 05 3a e4 00 00 	mov    0xe43a(%rip),%rax        # 51000 <kernel_pagetable>
   42bc6:	48 89 c2             	mov    %rax,%rdx
   42bc9:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42bcd:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42bd1:	48 89 ce             	mov    %rcx,%rsi
   42bd4:	48 89 c7             	mov    %rax,%rdi
   42bd7:	e8 d5 04 00 00       	call   430b1 <virtual_memory_lookup>
   42bdc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42be0:	48 8b 15 19 e4 00 00 	mov    0xe419(%rip),%rdx        # 51000 <kernel_pagetable>
   42be7:	48 39 d0             	cmp    %rdx,%rax
   42bea:	74 1e                	je     42c0a <set_pagetable+0x117>
   42bec:	48 8d 05 a5 2c 00 00 	lea    0x2ca5(%rip),%rax        # 45898 <complex_keymap+0x258>
   42bf3:	48 89 c2             	mov    %rax,%rdx
   42bf6:	be 43 00 00 00       	mov    $0x43,%esi
   42bfb:	48 8d 05 73 2b 00 00 	lea    0x2b73(%rip),%rax        # 45775 <complex_keymap+0x135>
   42c02:	48 89 c7             	mov    %rax,%rdi
   42c05:	e8 d7 fc ff ff       	call   428e1 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42c0a:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 42c65 <virtual_memory_map>
   42c11:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42c15:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42c19:	48 89 ce             	mov    %rcx,%rsi
   42c1c:	48 89 c7             	mov    %rax,%rdi
   42c1f:	e8 8d 04 00 00       	call   430b1 <virtual_memory_lookup>
   42c24:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c28:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 42c65 <virtual_memory_map>
   42c2f:	48 39 d0             	cmp    %rdx,%rax
   42c32:	74 1e                	je     42c52 <set_pagetable+0x15f>
   42c34:	48 8d 05 c5 2c 00 00 	lea    0x2cc5(%rip),%rax        # 45900 <complex_keymap+0x2c0>
   42c3b:	48 89 c2             	mov    %rax,%rdx
   42c3e:	be 45 00 00 00       	mov    $0x45,%esi
   42c43:	48 8d 05 2b 2b 00 00 	lea    0x2b2b(%rip),%rax        # 45775 <complex_keymap+0x135>
   42c4a:	48 89 c7             	mov    %rax,%rdi
   42c4d:	e8 8f fc ff ff       	call   428e1 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42c52:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42c56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42c5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c5e:	0f 22 d8             	mov    %rax,%cr3
}
   42c61:	90                   	nop
}
   42c62:	90                   	nop
   42c63:	c9                   	leave  
   42c64:	c3                   	ret    

0000000000042c65 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42c65:	f3 0f 1e fa          	endbr64 
   42c69:	55                   	push   %rbp
   42c6a:	48 89 e5             	mov    %rsp,%rbp
   42c6d:	53                   	push   %rbx
   42c6e:	48 83 ec 58          	sub    $0x58,%rsp
   42c72:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42c76:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42c7a:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42c7e:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42c82:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42c86:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c8a:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c8f:	48 85 c0             	test   %rax,%rax
   42c92:	74 1e                	je     42cb2 <virtual_memory_map+0x4d>
   42c94:	48 8d 05 cb 2c 00 00 	lea    0x2ccb(%rip),%rax        # 45966 <complex_keymap+0x326>
   42c9b:	48 89 c2             	mov    %rax,%rdx
   42c9e:	be 66 00 00 00       	mov    $0x66,%esi
   42ca3:	48 8d 05 cb 2a 00 00 	lea    0x2acb(%rip),%rax        # 45775 <complex_keymap+0x135>
   42caa:	48 89 c7             	mov    %rax,%rdi
   42cad:	e8 2f fc ff ff       	call   428e1 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42cb2:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42cb6:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cbb:	48 85 c0             	test   %rax,%rax
   42cbe:	74 1e                	je     42cde <virtual_memory_map+0x79>
   42cc0:	48 8d 05 b2 2c 00 00 	lea    0x2cb2(%rip),%rax        # 45979 <complex_keymap+0x339>
   42cc7:	48 89 c2             	mov    %rax,%rdx
   42cca:	be 67 00 00 00       	mov    $0x67,%esi
   42ccf:	48 8d 05 9f 2a 00 00 	lea    0x2a9f(%rip),%rax        # 45775 <complex_keymap+0x135>
   42cd6:	48 89 c7             	mov    %rax,%rdi
   42cd9:	e8 03 fc ff ff       	call   428e1 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42cde:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42ce2:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ce6:	48 01 d0             	add    %rdx,%rax
   42ce9:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   42ced:	76 2e                	jbe    42d1d <virtual_memory_map+0xb8>
   42cef:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42cf3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42cf7:	48 01 d0             	add    %rdx,%rax
   42cfa:	48 85 c0             	test   %rax,%rax
   42cfd:	74 1e                	je     42d1d <virtual_memory_map+0xb8>
   42cff:	48 8d 05 86 2c 00 00 	lea    0x2c86(%rip),%rax        # 4598c <complex_keymap+0x34c>
   42d06:	48 89 c2             	mov    %rax,%rdx
   42d09:	be 68 00 00 00       	mov    $0x68,%esi
   42d0e:	48 8d 05 60 2a 00 00 	lea    0x2a60(%rip),%rax        # 45775 <complex_keymap+0x135>
   42d15:	48 89 c7             	mov    %rax,%rdi
   42d18:	e8 c4 fb ff ff       	call   428e1 <assert_fail>
    if (perm & PTE_P) {
   42d1d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42d20:	48 98                	cltq   
   42d22:	83 e0 01             	and    $0x1,%eax
   42d25:	48 85 c0             	test   %rax,%rax
   42d28:	0f 84 8c 00 00 00    	je     42dba <virtual_memory_map+0x155>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42d2e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42d32:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d37:	48 85 c0             	test   %rax,%rax
   42d3a:	74 1e                	je     42d5a <virtual_memory_map+0xf5>
   42d3c:	48 8d 05 67 2c 00 00 	lea    0x2c67(%rip),%rax        # 459aa <complex_keymap+0x36a>
   42d43:	48 89 c2             	mov    %rax,%rdx
   42d46:	be 6a 00 00 00       	mov    $0x6a,%esi
   42d4b:	48 8d 05 23 2a 00 00 	lea    0x2a23(%rip),%rax        # 45775 <complex_keymap+0x135>
   42d52:	48 89 c7             	mov    %rax,%rdi
   42d55:	e8 87 fb ff ff       	call   428e1 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42d5a:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42d5e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42d62:	48 01 d0             	add    %rdx,%rax
   42d65:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   42d69:	76 1e                	jbe    42d89 <virtual_memory_map+0x124>
   42d6b:	48 8d 05 4b 2c 00 00 	lea    0x2c4b(%rip),%rax        # 459bd <complex_keymap+0x37d>
   42d72:	48 89 c2             	mov    %rax,%rdx
   42d75:	be 6b 00 00 00       	mov    $0x6b,%esi
   42d7a:	48 8d 05 f4 29 00 00 	lea    0x29f4(%rip),%rax        # 45775 <complex_keymap+0x135>
   42d81:	48 89 c7             	mov    %rax,%rdi
   42d84:	e8 58 fb ff ff       	call   428e1 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42d89:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42d8d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42d91:	48 01 d0             	add    %rdx,%rax
   42d94:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42d9a:	76 1e                	jbe    42dba <virtual_memory_map+0x155>
   42d9c:	48 8d 05 28 2c 00 00 	lea    0x2c28(%rip),%rax        # 459cb <complex_keymap+0x38b>
   42da3:	48 89 c2             	mov    %rax,%rdx
   42da6:	be 6c 00 00 00       	mov    $0x6c,%esi
   42dab:	48 8d 05 c3 29 00 00 	lea    0x29c3(%rip),%rax        # 45775 <complex_keymap+0x135>
   42db2:	48 89 c7             	mov    %rax,%rdi
   42db5:	e8 27 fb ff ff       	call   428e1 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42dba:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42dbe:	78 09                	js     42dc9 <virtual_memory_map+0x164>
   42dc0:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42dc7:	7e 1e                	jle    42de7 <virtual_memory_map+0x182>
   42dc9:	48 8d 05 17 2c 00 00 	lea    0x2c17(%rip),%rax        # 459e7 <complex_keymap+0x3a7>
   42dd0:	48 89 c2             	mov    %rax,%rdx
   42dd3:	be 6e 00 00 00       	mov    $0x6e,%esi
   42dd8:	48 8d 05 96 29 00 00 	lea    0x2996(%rip),%rax        # 45775 <complex_keymap+0x135>
   42ddf:	48 89 c7             	mov    %rax,%rdi
   42de2:	e8 fa fa ff ff       	call   428e1 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42de7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42deb:	25 ff 0f 00 00       	and    $0xfff,%eax
   42df0:	48 85 c0             	test   %rax,%rax
   42df3:	74 1e                	je     42e13 <virtual_memory_map+0x1ae>
   42df5:	48 8d 05 0c 2c 00 00 	lea    0x2c0c(%rip),%rax        # 45a08 <complex_keymap+0x3c8>
   42dfc:	48 89 c2             	mov    %rax,%rdx
   42dff:	be 6f 00 00 00       	mov    $0x6f,%esi
   42e04:	48 8d 05 6a 29 00 00 	lea    0x296a(%rip),%rax        # 45775 <complex_keymap+0x135>
   42e0b:	48 89 c7             	mov    %rax,%rdi
   42e0e:	e8 ce fa ff ff       	call   428e1 <assert_fail>

    int last_index123 = -1;
   42e13:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   42e1a:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42e21:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42e22:	e9 e6 00 00 00       	jmp    42f0d <virtual_memory_map+0x2a8>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42e27:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e2b:	48 c1 e8 15          	shr    $0x15,%rax
   42e2f:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42e32:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42e35:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42e38:	74 20                	je     42e5a <virtual_memory_map+0x1f5>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42e3a:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42e3d:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42e41:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e45:	48 89 ce             	mov    %rcx,%rsi
   42e48:	48 89 c7             	mov    %rax,%rdi
   42e4b:	e8 d3 00 00 00       	call   42f23 <lookup_l4pagetable>
   42e50:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42e54:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42e57:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42e5a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42e5d:	48 98                	cltq   
   42e5f:	83 e0 01             	and    $0x1,%eax
   42e62:	48 85 c0             	test   %rax,%rax
   42e65:	74 34                	je     42e9b <virtual_memory_map+0x236>
   42e67:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42e6c:	74 2d                	je     42e9b <virtual_memory_map+0x236>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42e6e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42e71:	48 63 d8             	movslq %eax,%rbx
   42e74:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e78:	be 03 00 00 00       	mov    $0x3,%esi
   42e7d:	48 89 c7             	mov    %rax,%rdi
   42e80:	e8 d3 fa ff ff       	call   42958 <pageindex>
   42e85:	89 c2                	mov    %eax,%edx
   42e87:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42e8b:	48 89 d9             	mov    %rbx,%rcx
   42e8e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42e92:	48 63 d2             	movslq %edx,%rdx
   42e95:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42e99:	eb 5a                	jmp    42ef5 <virtual_memory_map+0x290>
        } else if (l4pagetable) { // if page is NOT marked present
   42e9b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42ea0:	74 26                	je     42ec8 <virtual_memory_map+0x263>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42ea2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42ea6:	be 03 00 00 00       	mov    $0x3,%esi
   42eab:	48 89 c7             	mov    %rax,%rdi
   42eae:	e8 a5 fa ff ff       	call   42958 <pageindex>
   42eb3:	89 c2                	mov    %eax,%edx
   42eb5:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42eb8:	48 63 c8             	movslq %eax,%rcx
   42ebb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ebf:	48 63 d2             	movslq %edx,%rdx
   42ec2:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42ec6:	eb 2d                	jmp    42ef5 <virtual_memory_map+0x290>
        } else if (perm & PTE_P) {
   42ec8:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ecb:	48 98                	cltq   
   42ecd:	83 e0 01             	and    $0x1,%eax
   42ed0:	48 85 c0             	test   %rax,%rax
   42ed3:	74 20                	je     42ef5 <virtual_memory_map+0x290>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42ed5:	be 84 00 00 00       	mov    $0x84,%esi
   42eda:	48 8d 05 4f 2b 00 00 	lea    0x2b4f(%rip),%rax        # 45a30 <complex_keymap+0x3f0>
   42ee1:	48 89 c7             	mov    %rax,%rdi
   42ee4:	b8 00 00 00 00       	mov    $0x0,%eax
   42ee9:	e8 98 f6 ff ff       	call   42586 <log_printf>
            return -1;
   42eee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42ef3:	eb 28                	jmp    42f1d <virtual_memory_map+0x2b8>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42ef5:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42efc:	00 
   42efd:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42f04:	00 
   42f05:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42f0c:	00 
   42f0d:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42f12:	0f 85 0f ff ff ff    	jne    42e27 <virtual_memory_map+0x1c2>
        }
    }
    return 0;
   42f18:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f1d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42f21:	c9                   	leave  
   42f22:	c3                   	ret    

0000000000042f23 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42f23:	f3 0f 1e fa          	endbr64 
   42f27:	55                   	push   %rbp
   42f28:	48 89 e5             	mov    %rsp,%rbp
   42f2b:	48 83 ec 40          	sub    $0x40,%rsp
   42f2f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f33:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42f37:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42f3a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f3e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42f42:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42f49:	e9 53 01 00 00       	jmp    430a1 <lookup_l4pagetable+0x17e>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42f4e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42f51:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42f55:	89 d6                	mov    %edx,%esi
   42f57:	48 89 c7             	mov    %rax,%rdi
   42f5a:	e8 f9 f9 ff ff       	call   42958 <pageindex>
   42f5f:	89 c2                	mov    %eax,%edx
   42f61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f65:	48 63 d2             	movslq %edx,%rdx
   42f68:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42f6c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42f70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f74:	83 e0 01             	and    $0x1,%eax
   42f77:	48 85 c0             	test   %rax,%rax
   42f7a:	75 6d                	jne    42fe9 <lookup_l4pagetable+0xc6>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42f7c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42f7f:	8d 48 02             	lea    0x2(%rax),%ecx
   42f82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f86:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f8b:	48 89 c2             	mov    %rax,%rdx
   42f8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f92:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42f98:	48 89 c6             	mov    %rax,%rsi
   42f9b:	48 8d 05 d6 2a 00 00 	lea    0x2ad6(%rip),%rax        # 45a78 <complex_keymap+0x438>
   42fa2:	48 89 c7             	mov    %rax,%rdi
   42fa5:	b8 00 00 00 00       	mov    $0x0,%eax
   42faa:	e8 d7 f5 ff ff       	call   42586 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42faf:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42fb2:	48 98                	cltq   
   42fb4:	83 e0 01             	and    $0x1,%eax
   42fb7:	48 85 c0             	test   %rax,%rax
   42fba:	75 0a                	jne    42fc6 <lookup_l4pagetable+0xa3>
                return NULL;
   42fbc:	b8 00 00 00 00       	mov    $0x0,%eax
   42fc1:	e9 e9 00 00 00       	jmp    430af <lookup_l4pagetable+0x18c>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42fc6:	be a7 00 00 00       	mov    $0xa7,%esi
   42fcb:	48 8d 05 0e 2b 00 00 	lea    0x2b0e(%rip),%rax        # 45ae0 <complex_keymap+0x4a0>
   42fd2:	48 89 c7             	mov    %rax,%rdi
   42fd5:	b8 00 00 00 00       	mov    $0x0,%eax
   42fda:	e8 a7 f5 ff ff       	call   42586 <log_printf>
            return NULL;
   42fdf:	b8 00 00 00 00       	mov    $0x0,%eax
   42fe4:	e9 c6 00 00 00       	jmp    430af <lookup_l4pagetable+0x18c>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42fe9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fed:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ff3:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42ff9:	76 1e                	jbe    43019 <lookup_l4pagetable+0xf6>
   42ffb:	48 8d 05 26 2b 00 00 	lea    0x2b26(%rip),%rax        # 45b28 <complex_keymap+0x4e8>
   43002:	48 89 c2             	mov    %rax,%rdx
   43005:	be ac 00 00 00       	mov    $0xac,%esi
   4300a:	48 8d 05 64 27 00 00 	lea    0x2764(%rip),%rax        # 45775 <complex_keymap+0x135>
   43011:	48 89 c7             	mov    %rax,%rdi
   43014:	e8 c8 f8 ff ff       	call   428e1 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   43019:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4301c:	48 98                	cltq   
   4301e:	83 e0 02             	and    $0x2,%eax
   43021:	48 85 c0             	test   %rax,%rax
   43024:	74 2a                	je     43050 <lookup_l4pagetable+0x12d>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   43026:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4302a:	83 e0 02             	and    $0x2,%eax
   4302d:	48 85 c0             	test   %rax,%rax
   43030:	75 1e                	jne    43050 <lookup_l4pagetable+0x12d>
   43032:	48 8d 05 0f 2b 00 00 	lea    0x2b0f(%rip),%rax        # 45b48 <complex_keymap+0x508>
   43039:	48 89 c2             	mov    %rax,%rdx
   4303c:	be ae 00 00 00       	mov    $0xae,%esi
   43041:	48 8d 05 2d 27 00 00 	lea    0x272d(%rip),%rax        # 45775 <complex_keymap+0x135>
   43048:	48 89 c7             	mov    %rax,%rdi
   4304b:	e8 91 f8 ff ff       	call   428e1 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   43050:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43053:	48 98                	cltq   
   43055:	83 e0 04             	and    $0x4,%eax
   43058:	48 85 c0             	test   %rax,%rax
   4305b:	74 2a                	je     43087 <lookup_l4pagetable+0x164>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   4305d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43061:	83 e0 04             	and    $0x4,%eax
   43064:	48 85 c0             	test   %rax,%rax
   43067:	75 1e                	jne    43087 <lookup_l4pagetable+0x164>
   43069:	48 8d 05 e3 2a 00 00 	lea    0x2ae3(%rip),%rax        # 45b53 <complex_keymap+0x513>
   43070:	48 89 c2             	mov    %rax,%rdx
   43073:	be b1 00 00 00       	mov    $0xb1,%esi
   43078:	48 8d 05 f6 26 00 00 	lea    0x26f6(%rip),%rax        # 45775 <complex_keymap+0x135>
   4307f:	48 89 c7             	mov    %rax,%rdi
   43082:	e8 5a f8 ff ff       	call   428e1 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   43087:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4308e:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   4308f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43093:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43099:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   4309d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   430a1:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   430a5:	0f 8e a3 fe ff ff    	jle    42f4e <lookup_l4pagetable+0x2b>
    }
    return pt;
   430ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   430af:	c9                   	leave  
   430b0:	c3                   	ret    

00000000000430b1 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   430b1:	f3 0f 1e fa          	endbr64 
   430b5:	55                   	push   %rbp
   430b6:	48 89 e5             	mov    %rsp,%rbp
   430b9:	48 83 ec 50          	sub    $0x50,%rsp
   430bd:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   430c1:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   430c5:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   430c9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   430cd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   430d1:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   430d8:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   430d9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   430e0:	eb 41                	jmp    43123 <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   430e2:	8b 55 ec             	mov    -0x14(%rbp),%edx
   430e5:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   430e9:	89 d6                	mov    %edx,%esi
   430eb:	48 89 c7             	mov    %rax,%rdi
   430ee:	e8 65 f8 ff ff       	call   42958 <pageindex>
   430f3:	89 c2                	mov    %eax,%edx
   430f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430f9:	48 63 d2             	movslq %edx,%rdx
   430fc:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43100:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43104:	83 e0 06             	and    $0x6,%eax
   43107:	48 f7 d0             	not    %rax
   4310a:	48 21 d0             	and    %rdx,%rax
   4310d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43111:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43115:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4311b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4311f:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43123:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   43127:	7f 0c                	jg     43135 <virtual_memory_lookup+0x84>
   43129:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4312d:	83 e0 01             	and    $0x1,%eax
   43130:	48 85 c0             	test   %rax,%rax
   43133:	75 ad                	jne    430e2 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   43135:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   4313c:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   43143:	ff 
   43144:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   4314b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4314f:	83 e0 01             	and    $0x1,%eax
   43152:	48 85 c0             	test   %rax,%rax
   43155:	74 34                	je     4318b <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   43157:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4315b:	48 c1 e8 0c          	shr    $0xc,%rax
   4315f:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43162:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43166:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4316c:	48 89 c2             	mov    %rax,%rdx
   4316f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43173:	25 ff 0f 00 00       	and    $0xfff,%eax
   43178:	48 09 d0             	or     %rdx,%rax
   4317b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   4317f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43183:	25 ff 0f 00 00       	and    $0xfff,%eax
   43188:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   4318b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4318f:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43193:	48 89 10             	mov    %rdx,(%rax)
   43196:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   4319a:	48 89 50 08          	mov    %rdx,0x8(%rax)
   4319e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   431a2:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   431a6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431aa:	c9                   	leave  
   431ab:	c3                   	ret    

00000000000431ac <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   431ac:	f3 0f 1e fa          	endbr64 
   431b0:	55                   	push   %rbp
   431b1:	48 89 e5             	mov    %rsp,%rbp
   431b4:	48 83 ec 40          	sub    $0x40,%rsp
   431b8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   431bc:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   431bf:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   431c3:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   431ca:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   431ce:	78 08                	js     431d8 <program_load+0x2c>
   431d0:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   431d3:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   431d6:	7c 1e                	jl     431f6 <program_load+0x4a>
   431d8:	48 8d 05 81 29 00 00 	lea    0x2981(%rip),%rax        # 45b60 <complex_keymap+0x520>
   431df:	48 89 c2             	mov    %rax,%rdx
   431e2:	be 2e 00 00 00       	mov    $0x2e,%esi
   431e7:	48 8d 05 a2 29 00 00 	lea    0x29a2(%rip),%rax        # 45b90 <complex_keymap+0x550>
   431ee:	48 89 c7             	mov    %rax,%rdi
   431f1:	e8 eb f6 ff ff       	call   428e1 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   431f6:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   431f9:	48 98                	cltq   
   431fb:	48 c1 e0 04          	shl    $0x4,%rax
   431ff:	48 89 c2             	mov    %rax,%rdx
   43202:	48 8d 05 17 2e 00 00 	lea    0x2e17(%rip),%rax        # 46020 <ramimages>
   43209:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4320d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43211:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43215:	8b 00                	mov    (%rax),%eax
   43217:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   4321c:	74 1e                	je     4323c <program_load+0x90>
   4321e:	48 8d 05 7d 29 00 00 	lea    0x297d(%rip),%rax        # 45ba2 <complex_keymap+0x562>
   43225:	48 89 c2             	mov    %rax,%rdx
   43228:	be 30 00 00 00       	mov    $0x30,%esi
   4322d:	48 8d 05 5c 29 00 00 	lea    0x295c(%rip),%rax        # 45b90 <complex_keymap+0x550>
   43234:	48 89 c7             	mov    %rax,%rdi
   43237:	e8 a5 f6 ff ff       	call   428e1 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   4323c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43240:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43244:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43248:	48 01 d0             	add    %rdx,%rax
   4324b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   4324f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43256:	e9 94 00 00 00       	jmp    432ef <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   4325b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4325e:	48 63 d0             	movslq %eax,%rdx
   43261:	48 89 d0             	mov    %rdx,%rax
   43264:	48 c1 e0 03          	shl    $0x3,%rax
   43268:	48 29 d0             	sub    %rdx,%rax
   4326b:	48 c1 e0 03          	shl    $0x3,%rax
   4326f:	48 89 c2             	mov    %rax,%rdx
   43272:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43276:	48 01 d0             	add    %rdx,%rax
   43279:	8b 00                	mov    (%rax),%eax
   4327b:	83 f8 01             	cmp    $0x1,%eax
   4327e:	75 6b                	jne    432eb <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   43280:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43283:	48 63 d0             	movslq %eax,%rdx
   43286:	48 89 d0             	mov    %rdx,%rax
   43289:	48 c1 e0 03          	shl    $0x3,%rax
   4328d:	48 29 d0             	sub    %rdx,%rax
   43290:	48 c1 e0 03          	shl    $0x3,%rax
   43294:	48 89 c2             	mov    %rax,%rdx
   43297:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4329b:	48 01 d0             	add    %rdx,%rax
   4329e:	48 8b 50 08          	mov    0x8(%rax),%rdx
   432a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432a6:	48 01 d0             	add    %rdx,%rax
   432a9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   432ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
   432b0:	48 63 d0             	movslq %eax,%rdx
   432b3:	48 89 d0             	mov    %rdx,%rax
   432b6:	48 c1 e0 03          	shl    $0x3,%rax
   432ba:	48 29 d0             	sub    %rdx,%rax
   432bd:	48 c1 e0 03          	shl    $0x3,%rax
   432c1:	48 89 c2             	mov    %rax,%rdx
   432c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432c8:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   432cc:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   432d0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   432d4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432d8:	48 89 c7             	mov    %rax,%rdi
   432db:	e8 3d 00 00 00       	call   4331d <program_load_segment>
   432e0:	85 c0                	test   %eax,%eax
   432e2:	79 07                	jns    432eb <program_load+0x13f>
                return -1;
   432e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   432e9:	eb 30                	jmp    4331b <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   432eb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   432ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432f3:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   432f7:	0f b7 c0             	movzwl %ax,%eax
   432fa:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   432fd:	0f 8c 58 ff ff ff    	jl     4325b <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   43303:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43307:	48 8b 50 18          	mov    0x18(%rax),%rdx
   4330b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4330f:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   43316:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4331b:	c9                   	leave  
   4331c:	c3                   	ret    

000000000004331d <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   4331d:	f3 0f 1e fa          	endbr64 
   43321:	55                   	push   %rbp
   43322:	48 89 e5             	mov    %rsp,%rbp
   43325:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   43329:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   4332d:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   43331:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   43335:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   43339:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   4333d:	48 8b 40 10          	mov    0x10(%rax),%rax
   43341:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   43345:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43349:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4334d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43351:	48 01 d0             	add    %rdx,%rax
   43354:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43358:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   4335c:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43360:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43364:	48 01 d0             	add    %rdx,%rax
   43367:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   4336b:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   43372:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43373:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43377:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4337b:	e9 81 00 00 00       	jmp    43401 <program_load_segment+0xe4>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   43380:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43384:	8b 00                	mov    (%rax),%eax
   43386:	89 c7                	mov    %eax,%edi
   43388:	e8 a0 01 00 00       	call   4352d <palloc>
   4338d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   43391:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   43396:	74 2a                	je     433c2 <program_load_segment+0xa5>
   43398:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4339c:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   433a3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   433a7:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   433ab:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   433b1:	b9 00 10 00 00       	mov    $0x1000,%ecx
   433b6:	48 89 c7             	mov    %rax,%rdi
   433b9:	e8 a7 f8 ff ff       	call   42c65 <virtual_memory_map>
   433be:	85 c0                	test   %eax,%eax
   433c0:	79 37                	jns    433f9 <program_load_segment+0xdc>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   433c2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   433c6:	8b 00                	mov    (%rax),%eax
   433c8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   433cc:	49 89 d0             	mov    %rdx,%r8
   433cf:	89 c1                	mov    %eax,%ecx
   433d1:	48 8d 05 e8 27 00 00 	lea    0x27e8(%rip),%rax        # 45bc0 <complex_keymap+0x580>
   433d8:	48 89 c2             	mov    %rax,%rdx
   433db:	be 00 c0 00 00       	mov    $0xc000,%esi
   433e0:	bf e0 06 00 00       	mov    $0x6e0,%edi
   433e5:	b8 00 00 00 00       	mov    $0x0,%eax
   433ea:	e8 b7 1b 00 00       	call   44fa6 <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   433ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   433f4:	e9 32 01 00 00       	jmp    4352b <program_load_segment+0x20e>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   433f9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43400:	00 
   43401:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43405:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43409:	0f 82 71 ff ff ff    	jb     43380 <program_load_segment+0x63>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   4340f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43413:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4341a:	48 89 c7             	mov    %rax,%rdi
   4341d:	e8 d1 f6 ff ff       	call   42af3 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43422:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43426:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4342a:	48 89 c2             	mov    %rax,%rdx
   4342d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43431:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43435:	48 89 ce             	mov    %rcx,%rsi
   43438:	48 89 c7             	mov    %rax,%rdi
   4343b:	e8 21 0c 00 00       	call   44061 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43440:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43444:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   43448:	48 89 c2             	mov    %rax,%rdx
   4344b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4344f:	be 00 00 00 00       	mov    $0x0,%esi
   43454:	48 89 c7             	mov    %rax,%rdi
   43457:	e8 0b 0d 00 00       	call   44167 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   4345c:	48 8b 05 9d db 00 00 	mov    0xdb9d(%rip),%rax        # 51000 <kernel_pagetable>
   43463:	48 89 c7             	mov    %rax,%rdi
   43466:	e8 88 f6 ff ff       	call   42af3 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   4346b:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   4346f:	8b 40 04             	mov    0x4(%rax),%eax
   43472:	83 e0 02             	and    $0x2,%eax
   43475:	85 c0                	test   %eax,%eax
   43477:	75 60                	jne    434d9 <program_load_segment+0x1bc>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43479:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4347d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43481:	eb 4c                	jmp    434cf <program_load_segment+0x1b2>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   43483:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43487:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4348e:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   43492:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43496:	48 89 ce             	mov    %rcx,%rsi
   43499:	48 89 c7             	mov    %rax,%rdi
   4349c:	e8 10 fc ff ff       	call   430b1 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   434a1:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   434a5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   434a9:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   434b0:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   434b4:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   434ba:	b9 00 10 00 00       	mov    $0x1000,%ecx
   434bf:	48 89 c7             	mov    %rax,%rdi
   434c2:	e8 9e f7 ff ff       	call   42c65 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   434c7:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   434ce:	00 
   434cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434d3:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   434d7:	72 aa                	jb     43483 <program_load_segment+0x166>
                    PTE_P | PTE_U);
        }
    }
    // get break to end of proc mem rounded to pagesize
    p->original_break = ROUNDUP(end_mem, PAGESIZE); 
   434d9:	48 c7 45 d0 00 10 00 	movq   $0x1000,-0x30(%rbp)
   434e0:	00 
   434e1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   434e5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434e9:	48 01 d0             	add    %rdx,%rax
   434ec:	48 83 e8 01          	sub    $0x1,%rax
   434f0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   434f4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   434f8:	ba 00 00 00 00       	mov    $0x0,%edx
   434fd:	48 f7 75 d0          	divq   -0x30(%rbp)
   43501:	48 89 d1             	mov    %rdx,%rcx
   43504:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43508:	48 29 c8             	sub    %rcx,%rax
   4350b:	48 89 c2             	mov    %rax,%rdx
   4350e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43512:	48 89 50 10          	mov    %rdx,0x10(%rax)
    p->program_break = p->original_break;
   43516:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4351a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4351e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43522:	48 89 50 08          	mov    %rdx,0x8(%rax)

    return 0;
   43526:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4352b:	c9                   	leave  
   4352c:	c3                   	ret    

000000000004352d <palloc>:
   4352d:	55                   	push   %rbp
   4352e:	48 89 e5             	mov    %rsp,%rbp
   43531:	48 83 ec 20          	sub    $0x20,%rsp
   43535:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43538:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   4353f:	00 
   43540:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43544:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43548:	e9 95 00 00 00       	jmp    435e2 <palloc+0xb5>
   4354d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43551:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43555:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4355c:	00 
   4355d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43561:	48 c1 e8 0c          	shr    $0xc,%rax
   43565:	48 98                	cltq   
   43567:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   4356e:	00 
   4356f:	84 c0                	test   %al,%al
   43571:	75 6f                	jne    435e2 <palloc+0xb5>
   43573:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43577:	48 c1 e8 0c          	shr    $0xc,%rax
   4357b:	48 98                	cltq   
   4357d:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43584:	00 
   43585:	84 c0                	test   %al,%al
   43587:	75 59                	jne    435e2 <palloc+0xb5>
   43589:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4358d:	48 c1 e8 0c          	shr    $0xc,%rax
   43591:	89 c2                	mov    %eax,%edx
   43593:	48 63 c2             	movslq %edx,%rax
   43596:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4359d:	00 
   4359e:	83 c0 01             	add    $0x1,%eax
   435a1:	89 c1                	mov    %eax,%ecx
   435a3:	48 63 c2             	movslq %edx,%rax
   435a6:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   435ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435b1:	48 c1 e8 0c          	shr    $0xc,%rax
   435b5:	89 c1                	mov    %eax,%ecx
   435b7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   435ba:	89 c2                	mov    %eax,%edx
   435bc:	48 63 c1             	movslq %ecx,%rax
   435bf:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
   435c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435ca:	ba 00 10 00 00       	mov    $0x1000,%edx
   435cf:	be cc 00 00 00       	mov    $0xcc,%esi
   435d4:	48 89 c7             	mov    %rax,%rdi
   435d7:	e8 8b 0b 00 00       	call   44167 <memset>
   435dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435e0:	eb 2c                	jmp    4360e <palloc+0xe1>
   435e2:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   435e9:	00 
   435ea:	0f 86 5d ff ff ff    	jbe    4354d <palloc+0x20>
   435f0:	ba f8 5b 04 00       	mov    $0x45bf8,%edx
   435f5:	be 00 0c 00 00       	mov    $0xc00,%esi
   435fa:	bf 80 07 00 00       	mov    $0x780,%edi
   435ff:	b8 00 00 00 00       	mov    $0x0,%eax
   43604:	e8 9d 19 00 00       	call   44fa6 <console_printf>
   43609:	b8 00 00 00 00       	mov    $0x0,%eax
   4360e:	c9                   	leave  
   4360f:	c3                   	ret    

0000000000043610 <palloc_target>:
   43610:	55                   	push   %rbp
   43611:	48 89 e5             	mov    %rsp,%rbp
   43614:	48 8b 05 e5 39 01 00 	mov    0x139e5(%rip),%rax        # 57000 <palloc_target_proc>
   4361b:	48 85 c0             	test   %rax,%rax
   4361e:	75 14                	jne    43634 <palloc_target+0x24>
   43620:	ba 11 5c 04 00       	mov    $0x45c11,%edx
   43625:	be 27 00 00 00       	mov    $0x27,%esi
   4362a:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   4362f:	e8 ad f2 ff ff       	call   428e1 <assert_fail>
   43634:	48 8b 05 c5 39 01 00 	mov    0x139c5(%rip),%rax        # 57000 <palloc_target_proc>
   4363b:	8b 00                	mov    (%rax),%eax
   4363d:	89 c7                	mov    %eax,%edi
   4363f:	e8 e9 fe ff ff       	call   4352d <palloc>
   43644:	5d                   	pop    %rbp
   43645:	c3                   	ret    

0000000000043646 <process_free>:
   43646:	55                   	push   %rbp
   43647:	48 89 e5             	mov    %rsp,%rbp
   4364a:	48 83 ec 60          	sub    $0x60,%rsp
   4364e:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43651:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43654:	48 63 d0             	movslq %eax,%rdx
   43657:	48 89 d0             	mov    %rdx,%rax
   4365a:	48 c1 e0 04          	shl    $0x4,%rax
   4365e:	48 29 d0             	sub    %rdx,%rax
   43661:	48 c1 e0 04          	shl    $0x4,%rax
   43665:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   4366b:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43671:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43678:	00 
   43679:	e9 ad 00 00 00       	jmp    4372b <process_free+0xe5>
   4367e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43681:	48 63 d0             	movslq %eax,%rdx
   43684:	48 89 d0             	mov    %rdx,%rax
   43687:	48 c1 e0 04          	shl    $0x4,%rax
   4368b:	48 29 d0             	sub    %rdx,%rax
   4368e:	48 c1 e0 04          	shl    $0x4,%rax
   43692:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43698:	48 8b 08             	mov    (%rax),%rcx
   4369b:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4369f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   436a3:	48 89 ce             	mov    %rcx,%rsi
   436a6:	48 89 c7             	mov    %rax,%rdi
   436a9:	e8 03 fa ff ff       	call   430b1 <virtual_memory_lookup>
   436ae:	8b 45 c8             	mov    -0x38(%rbp),%eax
   436b1:	48 98                	cltq   
   436b3:	83 e0 01             	and    $0x1,%eax
   436b6:	48 85 c0             	test   %rax,%rax
   436b9:	74 68                	je     43723 <process_free+0xdd>
   436bb:	8b 45 b8             	mov    -0x48(%rbp),%eax
   436be:	48 63 d0             	movslq %eax,%rdx
   436c1:	0f b6 94 12 21 ef 04 	movzbl 0x4ef21(%rdx,%rdx,1),%edx
   436c8:	00 
   436c9:	83 ea 01             	sub    $0x1,%edx
   436cc:	48 98                	cltq   
   436ce:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
   436d5:	8b 45 b8             	mov    -0x48(%rbp),%eax
   436d8:	48 98                	cltq   
   436da:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   436e1:	00 
   436e2:	84 c0                	test   %al,%al
   436e4:	75 0f                	jne    436f5 <process_free+0xaf>
   436e6:	8b 45 b8             	mov    -0x48(%rbp),%eax
   436e9:	48 98                	cltq   
   436eb:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   436f2:	00 
   436f3:	eb 2e                	jmp    43723 <process_free+0xdd>
   436f5:	8b 45 b8             	mov    -0x48(%rbp),%eax
   436f8:	48 98                	cltq   
   436fa:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   43701:	00 
   43702:	0f be c0             	movsbl %al,%eax
   43705:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43708:	75 19                	jne    43723 <process_free+0xdd>
   4370a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4370e:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43711:	48 89 c6             	mov    %rax,%rsi
   43714:	bf 38 5c 04 00       	mov    $0x45c38,%edi
   43719:	b8 00 00 00 00       	mov    $0x0,%eax
   4371e:	e8 63 ee ff ff       	call   42586 <log_printf>
   43723:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4372a:	00 
   4372b:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43732:	00 
   43733:	0f 86 45 ff ff ff    	jbe    4367e <process_free+0x38>
   43739:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4373c:	48 63 d0             	movslq %eax,%rdx
   4373f:	48 89 d0             	mov    %rdx,%rax
   43742:	48 c1 e0 04          	shl    $0x4,%rax
   43746:	48 29 d0             	sub    %rdx,%rax
   43749:	48 c1 e0 04          	shl    $0x4,%rax
   4374d:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43753:	48 8b 00             	mov    (%rax),%rax
   43756:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4375a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4375e:	48 8b 00             	mov    (%rax),%rax
   43761:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43767:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4376b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4376f:	48 8b 00             	mov    (%rax),%rax
   43772:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43778:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4377c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43780:	48 8b 00             	mov    (%rax),%rax
   43783:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43789:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4378d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43791:	48 8b 40 08          	mov    0x8(%rax),%rax
   43795:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4379b:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   4379f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437a3:	48 c1 e8 0c          	shr    $0xc,%rax
   437a7:	48 98                	cltq   
   437a9:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   437b0:	00 
   437b1:	3c 01                	cmp    $0x1,%al
   437b3:	74 14                	je     437c9 <process_free+0x183>
   437b5:	ba 70 5c 04 00       	mov    $0x45c70,%edx
   437ba:	be 4f 00 00 00       	mov    $0x4f,%esi
   437bf:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   437c4:	e8 18 f1 ff ff       	call   428e1 <assert_fail>
   437c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437cd:	48 c1 e8 0c          	shr    $0xc,%rax
   437d1:	48 98                	cltq   
   437d3:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   437da:	00 
   437db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437df:	48 c1 e8 0c          	shr    $0xc,%rax
   437e3:	48 98                	cltq   
   437e5:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   437ec:	00 
   437ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437f1:	48 c1 e8 0c          	shr    $0xc,%rax
   437f5:	48 98                	cltq   
   437f7:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   437fe:	00 
   437ff:	3c 01                	cmp    $0x1,%al
   43801:	74 14                	je     43817 <process_free+0x1d1>
   43803:	ba 98 5c 04 00       	mov    $0x45c98,%edx
   43808:	be 52 00 00 00       	mov    $0x52,%esi
   4380d:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   43812:	e8 ca f0 ff ff       	call   428e1 <assert_fail>
   43817:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4381b:	48 c1 e8 0c          	shr    $0xc,%rax
   4381f:	48 98                	cltq   
   43821:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43828:	00 
   43829:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4382d:	48 c1 e8 0c          	shr    $0xc,%rax
   43831:	48 98                	cltq   
   43833:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4383a:	00 
   4383b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4383f:	48 c1 e8 0c          	shr    $0xc,%rax
   43843:	48 98                	cltq   
   43845:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4384c:	00 
   4384d:	3c 01                	cmp    $0x1,%al
   4384f:	74 14                	je     43865 <process_free+0x21f>
   43851:	ba c0 5c 04 00       	mov    $0x45cc0,%edx
   43856:	be 55 00 00 00       	mov    $0x55,%esi
   4385b:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   43860:	e8 7c f0 ff ff       	call   428e1 <assert_fail>
   43865:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43869:	48 c1 e8 0c          	shr    $0xc,%rax
   4386d:	48 98                	cltq   
   4386f:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43876:	00 
   43877:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4387b:	48 c1 e8 0c          	shr    $0xc,%rax
   4387f:	48 98                	cltq   
   43881:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43888:	00 
   43889:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4388d:	48 c1 e8 0c          	shr    $0xc,%rax
   43891:	48 98                	cltq   
   43893:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4389a:	00 
   4389b:	3c 01                	cmp    $0x1,%al
   4389d:	74 14                	je     438b3 <process_free+0x26d>
   4389f:	ba e8 5c 04 00       	mov    $0x45ce8,%edx
   438a4:	be 58 00 00 00       	mov    $0x58,%esi
   438a9:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   438ae:	e8 2e f0 ff ff       	call   428e1 <assert_fail>
   438b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438b7:	48 c1 e8 0c          	shr    $0xc,%rax
   438bb:	48 98                	cltq   
   438bd:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   438c4:	00 
   438c5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438c9:	48 c1 e8 0c          	shr    $0xc,%rax
   438cd:	48 98                	cltq   
   438cf:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   438d6:	00 
   438d7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   438db:	48 c1 e8 0c          	shr    $0xc,%rax
   438df:	48 98                	cltq   
   438e1:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   438e8:	00 
   438e9:	3c 01                	cmp    $0x1,%al
   438eb:	74 14                	je     43901 <process_free+0x2bb>
   438ed:	ba 10 5d 04 00       	mov    $0x45d10,%edx
   438f2:	be 5b 00 00 00       	mov    $0x5b,%esi
   438f7:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   438fc:	e8 e0 ef ff ff       	call   428e1 <assert_fail>
   43901:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43905:	48 c1 e8 0c          	shr    $0xc,%rax
   43909:	48 98                	cltq   
   4390b:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43912:	00 
   43913:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43917:	48 c1 e8 0c          	shr    $0xc,%rax
   4391b:	48 98                	cltq   
   4391d:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43924:	00 
   43925:	90                   	nop
   43926:	c9                   	leave  
   43927:	c3                   	ret    

0000000000043928 <process_config_tables>:
   43928:	55                   	push   %rbp
   43929:	48 89 e5             	mov    %rsp,%rbp
   4392c:	48 83 ec 40          	sub    $0x40,%rsp
   43930:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43933:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43936:	89 c7                	mov    %eax,%edi
   43938:	e8 f0 fb ff ff       	call   4352d <palloc>
   4393d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43941:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43944:	89 c7                	mov    %eax,%edi
   43946:	e8 e2 fb ff ff       	call   4352d <palloc>
   4394b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4394f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43952:	89 c7                	mov    %eax,%edi
   43954:	e8 d4 fb ff ff       	call   4352d <palloc>
   43959:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4395d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43960:	89 c7                	mov    %eax,%edi
   43962:	e8 c6 fb ff ff       	call   4352d <palloc>
   43967:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4396b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4396e:	89 c7                	mov    %eax,%edi
   43970:	e8 b8 fb ff ff       	call   4352d <palloc>
   43975:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43979:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4397e:	74 20                	je     439a0 <process_config_tables+0x78>
   43980:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43985:	74 19                	je     439a0 <process_config_tables+0x78>
   43987:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4398c:	74 12                	je     439a0 <process_config_tables+0x78>
   4398e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43993:	74 0b                	je     439a0 <process_config_tables+0x78>
   43995:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4399a:	0f 85 e1 00 00 00    	jne    43a81 <process_config_tables+0x159>
   439a0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   439a5:	74 24                	je     439cb <process_config_tables+0xa3>
   439a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   439ab:	48 c1 e8 0c          	shr    $0xc,%rax
   439af:	48 98                	cltq   
   439b1:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   439b8:	00 
   439b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   439bd:	48 c1 e8 0c          	shr    $0xc,%rax
   439c1:	48 98                	cltq   
   439c3:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   439ca:	00 
   439cb:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   439d0:	74 24                	je     439f6 <process_config_tables+0xce>
   439d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   439d6:	48 c1 e8 0c          	shr    $0xc,%rax
   439da:	48 98                	cltq   
   439dc:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   439e3:	00 
   439e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   439e8:	48 c1 e8 0c          	shr    $0xc,%rax
   439ec:	48 98                	cltq   
   439ee:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   439f5:	00 
   439f6:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   439fb:	74 24                	je     43a21 <process_config_tables+0xf9>
   439fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a01:	48 c1 e8 0c          	shr    $0xc,%rax
   43a05:	48 98                	cltq   
   43a07:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43a0e:	00 
   43a0f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a13:	48 c1 e8 0c          	shr    $0xc,%rax
   43a17:	48 98                	cltq   
   43a19:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43a20:	00 
   43a21:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43a26:	74 24                	je     43a4c <process_config_tables+0x124>
   43a28:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a2c:	48 c1 e8 0c          	shr    $0xc,%rax
   43a30:	48 98                	cltq   
   43a32:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43a39:	00 
   43a3a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a3e:	48 c1 e8 0c          	shr    $0xc,%rax
   43a42:	48 98                	cltq   
   43a44:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43a4b:	00 
   43a4c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43a51:	74 24                	je     43a77 <process_config_tables+0x14f>
   43a53:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a57:	48 c1 e8 0c          	shr    $0xc,%rax
   43a5b:	48 98                	cltq   
   43a5d:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43a64:	00 
   43a65:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a69:	48 c1 e8 0c          	shr    $0xc,%rax
   43a6d:	48 98                	cltq   
   43a6f:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43a76:	00 
   43a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a7c:	e9 f3 01 00 00       	jmp    43c74 <process_config_tables+0x34c>
   43a81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a85:	ba 00 10 00 00       	mov    $0x1000,%edx
   43a8a:	be 00 00 00 00       	mov    $0x0,%esi
   43a8f:	48 89 c7             	mov    %rax,%rdi
   43a92:	e8 d0 06 00 00       	call   44167 <memset>
   43a97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a9b:	ba 00 10 00 00       	mov    $0x1000,%edx
   43aa0:	be 00 00 00 00       	mov    $0x0,%esi
   43aa5:	48 89 c7             	mov    %rax,%rdi
   43aa8:	e8 ba 06 00 00       	call   44167 <memset>
   43aad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ab1:	ba 00 10 00 00       	mov    $0x1000,%edx
   43ab6:	be 00 00 00 00       	mov    $0x0,%esi
   43abb:	48 89 c7             	mov    %rax,%rdi
   43abe:	e8 a4 06 00 00       	call   44167 <memset>
   43ac3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ac7:	ba 00 10 00 00       	mov    $0x1000,%edx
   43acc:	be 00 00 00 00       	mov    $0x0,%esi
   43ad1:	48 89 c7             	mov    %rax,%rdi
   43ad4:	e8 8e 06 00 00       	call   44167 <memset>
   43ad9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43add:	ba 00 10 00 00       	mov    $0x1000,%edx
   43ae2:	be 00 00 00 00       	mov    $0x0,%esi
   43ae7:	48 89 c7             	mov    %rax,%rdi
   43aea:	e8 78 06 00 00       	call   44167 <memset>
   43aef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43af3:	48 83 c8 07          	or     $0x7,%rax
   43af7:	48 89 c2             	mov    %rax,%rdx
   43afa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43afe:	48 89 10             	mov    %rdx,(%rax)
   43b01:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b05:	48 83 c8 07          	or     $0x7,%rax
   43b09:	48 89 c2             	mov    %rax,%rdx
   43b0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b10:	48 89 10             	mov    %rdx,(%rax)
   43b13:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43b17:	48 83 c8 07          	or     $0x7,%rax
   43b1b:	48 89 c2             	mov    %rax,%rdx
   43b1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b22:	48 89 10             	mov    %rdx,(%rax)
   43b25:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b29:	48 83 c8 07          	or     $0x7,%rax
   43b2d:	48 89 c2             	mov    %rax,%rdx
   43b30:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b34:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43b38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b3c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43b42:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   43b48:	b9 00 00 10 00       	mov    $0x100000,%ecx
   43b4d:	ba 00 00 00 00       	mov    $0x0,%edx
   43b52:	be 00 00 00 00       	mov    $0x0,%esi
   43b57:	48 89 c7             	mov    %rax,%rdi
   43b5a:	e8 06 f1 ff ff       	call   42c65 <virtual_memory_map>
   43b5f:	85 c0                	test   %eax,%eax
   43b61:	75 2f                	jne    43b92 <process_config_tables+0x26a>
   43b63:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   43b68:	be 00 80 0b 00       	mov    $0xb8000,%esi
   43b6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b71:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43b77:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43b7d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43b82:	48 89 c7             	mov    %rax,%rdi
   43b85:	e8 db f0 ff ff       	call   42c65 <virtual_memory_map>
   43b8a:	85 c0                	test   %eax,%eax
   43b8c:	0f 84 bb 00 00 00    	je     43c4d <process_config_tables+0x325>
   43b92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b96:	48 c1 e8 0c          	shr    $0xc,%rax
   43b9a:	48 98                	cltq   
   43b9c:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43ba3:	00 
   43ba4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ba8:	48 c1 e8 0c          	shr    $0xc,%rax
   43bac:	48 98                	cltq   
   43bae:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43bb5:	00 
   43bb6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bba:	48 c1 e8 0c          	shr    $0xc,%rax
   43bbe:	48 98                	cltq   
   43bc0:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43bc7:	00 
   43bc8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bcc:	48 c1 e8 0c          	shr    $0xc,%rax
   43bd0:	48 98                	cltq   
   43bd2:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43bd9:	00 
   43bda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bde:	48 c1 e8 0c          	shr    $0xc,%rax
   43be2:	48 98                	cltq   
   43be4:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43beb:	00 
   43bec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bf0:	48 c1 e8 0c          	shr    $0xc,%rax
   43bf4:	48 98                	cltq   
   43bf6:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43bfd:	00 
   43bfe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c02:	48 c1 e8 0c          	shr    $0xc,%rax
   43c06:	48 98                	cltq   
   43c08:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43c0f:	00 
   43c10:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c14:	48 c1 e8 0c          	shr    $0xc,%rax
   43c18:	48 98                	cltq   
   43c1a:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43c21:	00 
   43c22:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c26:	48 c1 e8 0c          	shr    $0xc,%rax
   43c2a:	48 98                	cltq   
   43c2c:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43c33:	00 
   43c34:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c38:	48 c1 e8 0c          	shr    $0xc,%rax
   43c3c:	48 98                	cltq   
   43c3e:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43c45:	00 
   43c46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43c4b:	eb 27                	jmp    43c74 <process_config_tables+0x34c>
   43c4d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43c50:	48 63 d0             	movslq %eax,%rdx
   43c53:	48 89 d0             	mov    %rdx,%rax
   43c56:	48 c1 e0 04          	shl    $0x4,%rax
   43c5a:	48 29 d0             	sub    %rdx,%rax
   43c5d:	48 c1 e0 04          	shl    $0x4,%rax
   43c61:	48 8d 90 e0 e0 04 00 	lea    0x4e0e0(%rax),%rdx
   43c68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c6c:	48 89 02             	mov    %rax,(%rdx)
   43c6f:	b8 00 00 00 00       	mov    $0x0,%eax
   43c74:	c9                   	leave  
   43c75:	c3                   	ret    

0000000000043c76 <process_load>:
   43c76:	55                   	push   %rbp
   43c77:	48 89 e5             	mov    %rsp,%rbp
   43c7a:	48 83 ec 20          	sub    $0x20,%rsp
   43c7e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c82:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43c85:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c89:	48 89 05 70 33 01 00 	mov    %rax,0x13370(%rip)        # 57000 <palloc_target_proc>
   43c90:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   43c93:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c97:	ba 10 36 04 00       	mov    $0x43610,%edx
   43c9c:	89 ce                	mov    %ecx,%esi
   43c9e:	48 89 c7             	mov    %rax,%rdi
   43ca1:	e8 06 f5 ff ff       	call   431ac <program_load>
   43ca6:	89 45 fc             	mov    %eax,-0x4(%rbp)
   43ca9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43cac:	c9                   	leave  
   43cad:	c3                   	ret    

0000000000043cae <process_setup_stack>:
   43cae:	55                   	push   %rbp
   43caf:	48 89 e5             	mov    %rsp,%rbp
   43cb2:	48 83 ec 20          	sub    $0x20,%rsp
   43cb6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43cba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cbe:	8b 00                	mov    (%rax),%eax
   43cc0:	89 c7                	mov    %eax,%edi
   43cc2:	e8 66 f8 ff ff       	call   4352d <palloc>
   43cc7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43ccb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ccf:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   43cd6:	00 00 30 00 
   43cda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cde:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43ce5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43ce9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43cef:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43cf5:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43cfa:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   43cff:	48 89 c7             	mov    %rax,%rdi
   43d02:	e8 5e ef ff ff       	call   42c65 <virtual_memory_map>
   43d07:	90                   	nop
   43d08:	c9                   	leave  
   43d09:	c3                   	ret    

0000000000043d0a <find_free_pid>:
   43d0a:	55                   	push   %rbp
   43d0b:	48 89 e5             	mov    %rsp,%rbp
   43d0e:	48 83 ec 10          	sub    $0x10,%rsp
   43d12:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43d19:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   43d20:	eb 24                	jmp    43d46 <find_free_pid+0x3c>
   43d22:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43d25:	48 63 d0             	movslq %eax,%rdx
   43d28:	48 89 d0             	mov    %rdx,%rax
   43d2b:	48 c1 e0 04          	shl    $0x4,%rax
   43d2f:	48 29 d0             	sub    %rdx,%rax
   43d32:	48 c1 e0 04          	shl    $0x4,%rax
   43d36:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43d3c:	8b 00                	mov    (%rax),%eax
   43d3e:	85 c0                	test   %eax,%eax
   43d40:	74 0c                	je     43d4e <find_free_pid+0x44>
   43d42:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43d46:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   43d4a:	7e d6                	jle    43d22 <find_free_pid+0x18>
   43d4c:	eb 01                	jmp    43d4f <find_free_pid+0x45>
   43d4e:	90                   	nop
   43d4f:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   43d53:	74 05                	je     43d5a <find_free_pid+0x50>
   43d55:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43d58:	eb 05                	jmp    43d5f <find_free_pid+0x55>
   43d5a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43d5f:	c9                   	leave  
   43d60:	c3                   	ret    

0000000000043d61 <process_fork>:
   43d61:	55                   	push   %rbp
   43d62:	48 89 e5             	mov    %rsp,%rbp
   43d65:	48 83 ec 40          	sub    $0x40,%rsp
   43d69:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43d6d:	b8 00 00 00 00       	mov    $0x0,%eax
   43d72:	e8 93 ff ff ff       	call   43d0a <find_free_pid>
   43d77:	89 45 f4             	mov    %eax,-0xc(%rbp)
   43d7a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   43d7e:	75 0a                	jne    43d8a <process_fork+0x29>
   43d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43d85:	e9 67 02 00 00       	jmp    43ff1 <process_fork+0x290>
   43d8a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43d8d:	48 63 d0             	movslq %eax,%rdx
   43d90:	48 89 d0             	mov    %rdx,%rax
   43d93:	48 c1 e0 04          	shl    $0x4,%rax
   43d97:	48 29 d0             	sub    %rdx,%rax
   43d9a:	48 c1 e0 04          	shl    $0x4,%rax
   43d9e:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   43da4:	be 00 00 00 00       	mov    $0x0,%esi
   43da9:	48 89 c7             	mov    %rax,%rdi
   43dac:	e8 fa e2 ff ff       	call   420ab <process_init>
   43db1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43db4:	89 c7                	mov    %eax,%edi
   43db6:	e8 6d fb ff ff       	call   43928 <process_config_tables>
   43dbb:	83 f8 ff             	cmp    $0xffffffff,%eax
   43dbe:	75 0a                	jne    43dca <process_fork+0x69>
   43dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43dc5:	e9 27 02 00 00       	jmp    43ff1 <process_fork+0x290>
   43dca:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43dd1:	00 
   43dd2:	e9 79 01 00 00       	jmp    43f50 <process_fork+0x1ef>
   43dd7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43ddb:	8b 00                	mov    (%rax),%eax
   43ddd:	48 63 d0             	movslq %eax,%rdx
   43de0:	48 89 d0             	mov    %rdx,%rax
   43de3:	48 c1 e0 04          	shl    $0x4,%rax
   43de7:	48 29 d0             	sub    %rdx,%rax
   43dea:	48 c1 e0 04          	shl    $0x4,%rax
   43dee:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43df4:	48 8b 08             	mov    (%rax),%rcx
   43df7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43dfb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43dff:	48 89 ce             	mov    %rcx,%rsi
   43e02:	48 89 c7             	mov    %rax,%rdi
   43e05:	e8 a7 f2 ff ff       	call   430b1 <virtual_memory_lookup>
   43e0a:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43e0d:	48 98                	cltq   
   43e0f:	83 e0 07             	and    $0x7,%eax
   43e12:	48 83 f8 07          	cmp    $0x7,%rax
   43e16:	0f 85 a1 00 00 00    	jne    43ebd <process_fork+0x15c>
   43e1c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43e1f:	89 c7                	mov    %eax,%edi
   43e21:	e8 07 f7 ff ff       	call   4352d <palloc>
   43e26:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43e2a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43e2f:	75 14                	jne    43e45 <process_fork+0xe4>
   43e31:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43e34:	89 c7                	mov    %eax,%edi
   43e36:	e8 0b f8 ff ff       	call   43646 <process_free>
   43e3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43e40:	e9 ac 01 00 00       	jmp    43ff1 <process_fork+0x290>
   43e45:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e49:	48 89 c1             	mov    %rax,%rcx
   43e4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e50:	ba 00 10 00 00       	mov    $0x1000,%edx
   43e55:	48 89 ce             	mov    %rcx,%rsi
   43e58:	48 89 c7             	mov    %rax,%rdi
   43e5b:	e8 01 02 00 00       	call   44061 <memcpy>
   43e60:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   43e64:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43e67:	48 63 d0             	movslq %eax,%rdx
   43e6a:	48 89 d0             	mov    %rdx,%rax
   43e6d:	48 c1 e0 04          	shl    $0x4,%rax
   43e71:	48 29 d0             	sub    %rdx,%rax
   43e74:	48 c1 e0 04          	shl    $0x4,%rax
   43e78:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43e7e:	48 8b 00             	mov    (%rax),%rax
   43e81:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43e85:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43e8b:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43e91:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43e96:	48 89 fa             	mov    %rdi,%rdx
   43e99:	48 89 c7             	mov    %rax,%rdi
   43e9c:	e8 c4 ed ff ff       	call   42c65 <virtual_memory_map>
   43ea1:	85 c0                	test   %eax,%eax
   43ea3:	0f 84 9f 00 00 00    	je     43f48 <process_fork+0x1e7>
   43ea9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43eac:	89 c7                	mov    %eax,%edi
   43eae:	e8 93 f7 ff ff       	call   43646 <process_free>
   43eb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43eb8:	e9 34 01 00 00       	jmp    43ff1 <process_fork+0x290>
   43ebd:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43ec0:	48 98                	cltq   
   43ec2:	83 e0 05             	and    $0x5,%eax
   43ec5:	48 83 f8 05          	cmp    $0x5,%rax
   43ec9:	75 7d                	jne    43f48 <process_fork+0x1e7>
   43ecb:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43ecf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ed2:	48 63 d0             	movslq %eax,%rdx
   43ed5:	48 89 d0             	mov    %rdx,%rax
   43ed8:	48 c1 e0 04          	shl    $0x4,%rax
   43edc:	48 29 d0             	sub    %rdx,%rax
   43edf:	48 c1 e0 04          	shl    $0x4,%rax
   43ee3:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43ee9:	48 8b 00             	mov    (%rax),%rax
   43eec:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43ef0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43ef6:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43efc:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43f01:	48 89 fa             	mov    %rdi,%rdx
   43f04:	48 89 c7             	mov    %rax,%rdi
   43f07:	e8 59 ed ff ff       	call   42c65 <virtual_memory_map>
   43f0c:	85 c0                	test   %eax,%eax
   43f0e:	74 14                	je     43f24 <process_fork+0x1c3>
   43f10:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43f13:	89 c7                	mov    %eax,%edi
   43f15:	e8 2c f7 ff ff       	call   43646 <process_free>
   43f1a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43f1f:	e9 cd 00 00 00       	jmp    43ff1 <process_fork+0x290>
   43f24:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43f28:	48 c1 e8 0c          	shr    $0xc,%rax
   43f2c:	89 c2                	mov    %eax,%edx
   43f2e:	48 63 c2             	movslq %edx,%rax
   43f31:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43f38:	00 
   43f39:	83 c0 01             	add    $0x1,%eax
   43f3c:	89 c1                	mov    %eax,%ecx
   43f3e:	48 63 c2             	movslq %edx,%rax
   43f41:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   43f48:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43f4f:	00 
   43f50:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43f57:	00 
   43f58:	0f 86 79 fe ff ff    	jbe    43dd7 <process_fork+0x76>
   43f5e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43f62:	8b 08                	mov    (%rax),%ecx
   43f64:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43f67:	48 63 d0             	movslq %eax,%rdx
   43f6a:	48 89 d0             	mov    %rdx,%rax
   43f6d:	48 c1 e0 04          	shl    $0x4,%rax
   43f71:	48 29 d0             	sub    %rdx,%rax
   43f74:	48 c1 e0 04          	shl    $0x4,%rax
   43f78:	48 8d b0 10 e0 04 00 	lea    0x4e010(%rax),%rsi
   43f7f:	48 63 d1             	movslq %ecx,%rdx
   43f82:	48 89 d0             	mov    %rdx,%rax
   43f85:	48 c1 e0 04          	shl    $0x4,%rax
   43f89:	48 29 d0             	sub    %rdx,%rax
   43f8c:	48 c1 e0 04          	shl    $0x4,%rax
   43f90:	48 8d 90 10 e0 04 00 	lea    0x4e010(%rax),%rdx
   43f97:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43f9b:	48 83 c2 08          	add    $0x8,%rdx
   43f9f:	b9 18 00 00 00       	mov    $0x18,%ecx
   43fa4:	48 89 c7             	mov    %rax,%rdi
   43fa7:	48 89 d6             	mov    %rdx,%rsi
   43faa:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43fad:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43fb0:	48 63 d0             	movslq %eax,%rdx
   43fb3:	48 89 d0             	mov    %rdx,%rax
   43fb6:	48 c1 e0 04          	shl    $0x4,%rax
   43fba:	48 29 d0             	sub    %rdx,%rax
   43fbd:	48 c1 e0 04          	shl    $0x4,%rax
   43fc1:	48 05 18 e0 04 00    	add    $0x4e018,%rax
   43fc7:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43fce:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43fd1:	48 63 d0             	movslq %eax,%rdx
   43fd4:	48 89 d0             	mov    %rdx,%rax
   43fd7:	48 c1 e0 04          	shl    $0x4,%rax
   43fdb:	48 29 d0             	sub    %rdx,%rax
   43fde:	48 c1 e0 04          	shl    $0x4,%rax
   43fe2:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43fe8:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43fee:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ff1:	c9                   	leave  
   43ff2:	c3                   	ret    

0000000000043ff3 <process_page_alloc>:
   43ff3:	55                   	push   %rbp
   43ff4:	48 89 e5             	mov    %rsp,%rbp
   43ff7:	48 83 ec 20          	sub    $0x20,%rsp
   43ffb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43fff:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   44003:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   4400a:	00 
   4400b:	77 07                	ja     44014 <process_page_alloc+0x21>
   4400d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44012:	eb 4b                	jmp    4405f <process_page_alloc+0x6c>
   44014:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44018:	8b 00                	mov    (%rax),%eax
   4401a:	89 c7                	mov    %eax,%edi
   4401c:	e8 0c f5 ff ff       	call   4352d <palloc>
   44021:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44025:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4402a:	74 2e                	je     4405a <process_page_alloc+0x67>
   4402c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44030:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44034:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4403b:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   4403f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44045:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4404b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44050:	48 89 c7             	mov    %rax,%rdi
   44053:	e8 0d ec ff ff       	call   42c65 <virtual_memory_map>
   44058:	eb 05                	jmp    4405f <process_page_alloc+0x6c>
   4405a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4405f:	c9                   	leave  
   44060:	c3                   	ret    

0000000000044061 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   44061:	f3 0f 1e fa          	endbr64 
   44065:	55                   	push   %rbp
   44066:	48 89 e5             	mov    %rsp,%rbp
   44069:	48 83 ec 28          	sub    $0x28,%rsp
   4406d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44071:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   44075:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   44079:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4407d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   44081:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44085:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   44089:	eb 1c                	jmp    440a7 <memcpy+0x46>
        *d = *s;
   4408b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4408f:	0f b6 10             	movzbl (%rax),%edx
   44092:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44096:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   44098:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4409d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   440a2:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   440a7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   440ac:	75 dd                	jne    4408b <memcpy+0x2a>
    }
    return dst;
   440ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   440b2:	c9                   	leave  
   440b3:	c3                   	ret    

00000000000440b4 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   440b4:	f3 0f 1e fa          	endbr64 
   440b8:	55                   	push   %rbp
   440b9:	48 89 e5             	mov    %rsp,%rbp
   440bc:	48 83 ec 28          	sub    $0x28,%rsp
   440c0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   440c4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   440c8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   440cc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   440d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   440d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   440d8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   440dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440e0:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   440e4:	73 6a                	jae    44150 <memmove+0x9c>
   440e6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   440ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   440ee:	48 01 d0             	add    %rdx,%rax
   440f1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   440f5:	73 59                	jae    44150 <memmove+0x9c>
        s += n, d += n;
   440f7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   440fb:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   440ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44103:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   44107:	eb 17                	jmp    44120 <memmove+0x6c>
            *--d = *--s;
   44109:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   4410e:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   44113:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44117:	0f b6 10             	movzbl (%rax),%edx
   4411a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4411e:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   44120:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44124:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44128:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   4412c:	48 85 c0             	test   %rax,%rax
   4412f:	75 d8                	jne    44109 <memmove+0x55>
    if (s < d && s + n > d) {
   44131:	eb 2e                	jmp    44161 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   44133:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44137:	48 8d 42 01          	lea    0x1(%rdx),%rax
   4413b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4413f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44143:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44147:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   4414b:	0f b6 12             	movzbl (%rdx),%edx
   4414e:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   44150:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44154:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44158:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   4415c:	48 85 c0             	test   %rax,%rax
   4415f:	75 d2                	jne    44133 <memmove+0x7f>
        }
    }
    return dst;
   44161:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   44165:	c9                   	leave  
   44166:	c3                   	ret    

0000000000044167 <memset>:

void* memset(void* v, int c, size_t n) {
   44167:	f3 0f 1e fa          	endbr64 
   4416b:	55                   	push   %rbp
   4416c:	48 89 e5             	mov    %rsp,%rbp
   4416f:	48 83 ec 28          	sub    $0x28,%rsp
   44173:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44177:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4417a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4417e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44182:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44186:	eb 15                	jmp    4419d <memset+0x36>
        *p = c;
   44188:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4418b:	89 c2                	mov    %eax,%edx
   4418d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44191:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   44193:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   44198:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4419d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   441a2:	75 e4                	jne    44188 <memset+0x21>
    }
    return v;
   441a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   441a8:	c9                   	leave  
   441a9:	c3                   	ret    

00000000000441aa <strlen>:

size_t strlen(const char* s) {
   441aa:	f3 0f 1e fa          	endbr64 
   441ae:	55                   	push   %rbp
   441af:	48 89 e5             	mov    %rsp,%rbp
   441b2:	48 83 ec 18          	sub    $0x18,%rsp
   441b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   441ba:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   441c1:	00 
   441c2:	eb 0a                	jmp    441ce <strlen+0x24>
        ++n;
   441c4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   441c9:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   441ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   441d2:	0f b6 00             	movzbl (%rax),%eax
   441d5:	84 c0                	test   %al,%al
   441d7:	75 eb                	jne    441c4 <strlen+0x1a>
    }
    return n;
   441d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   441dd:	c9                   	leave  
   441de:	c3                   	ret    

00000000000441df <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   441df:	f3 0f 1e fa          	endbr64 
   441e3:	55                   	push   %rbp
   441e4:	48 89 e5             	mov    %rsp,%rbp
   441e7:	48 83 ec 20          	sub    $0x20,%rsp
   441eb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   441ef:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   441f3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   441fa:	00 
   441fb:	eb 0a                	jmp    44207 <strnlen+0x28>
        ++n;
   441fd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   44202:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   44207:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4420b:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   4420f:	74 0b                	je     4421c <strnlen+0x3d>
   44211:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44215:	0f b6 00             	movzbl (%rax),%eax
   44218:	84 c0                	test   %al,%al
   4421a:	75 e1                	jne    441fd <strnlen+0x1e>
    }
    return n;
   4421c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   44220:	c9                   	leave  
   44221:	c3                   	ret    

0000000000044222 <strcpy>:

char* strcpy(char* dst, const char* src) {
   44222:	f3 0f 1e fa          	endbr64 
   44226:	55                   	push   %rbp
   44227:	48 89 e5             	mov    %rsp,%rbp
   4422a:	48 83 ec 20          	sub    $0x20,%rsp
   4422e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44232:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   44236:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4423a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   4423e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44242:	48 8d 42 01          	lea    0x1(%rdx),%rax
   44246:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4424a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4424e:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44252:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   44256:	0f b6 12             	movzbl (%rdx),%edx
   44259:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   4425b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4425f:	48 83 e8 01          	sub    $0x1,%rax
   44263:	0f b6 00             	movzbl (%rax),%eax
   44266:	84 c0                	test   %al,%al
   44268:	75 d4                	jne    4423e <strcpy+0x1c>
    return dst;
   4426a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4426e:	c9                   	leave  
   4426f:	c3                   	ret    

0000000000044270 <strcmp>:

int strcmp(const char* a, const char* b) {
   44270:	f3 0f 1e fa          	endbr64 
   44274:	55                   	push   %rbp
   44275:	48 89 e5             	mov    %rsp,%rbp
   44278:	48 83 ec 10          	sub    $0x10,%rsp
   4427c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   44280:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   44284:	eb 0a                	jmp    44290 <strcmp+0x20>
        ++a, ++b;
   44286:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4428b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   44290:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44294:	0f b6 00             	movzbl (%rax),%eax
   44297:	84 c0                	test   %al,%al
   44299:	74 1d                	je     442b8 <strcmp+0x48>
   4429b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4429f:	0f b6 00             	movzbl (%rax),%eax
   442a2:	84 c0                	test   %al,%al
   442a4:	74 12                	je     442b8 <strcmp+0x48>
   442a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442aa:	0f b6 10             	movzbl (%rax),%edx
   442ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442b1:	0f b6 00             	movzbl (%rax),%eax
   442b4:	38 c2                	cmp    %al,%dl
   442b6:	74 ce                	je     44286 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   442b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442bc:	0f b6 00             	movzbl (%rax),%eax
   442bf:	89 c2                	mov    %eax,%edx
   442c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442c5:	0f b6 00             	movzbl (%rax),%eax
   442c8:	38 c2                	cmp    %al,%dl
   442ca:	0f 97 c0             	seta   %al
   442cd:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   442d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442d4:	0f b6 00             	movzbl (%rax),%eax
   442d7:	89 c1                	mov    %eax,%ecx
   442d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442dd:	0f b6 00             	movzbl (%rax),%eax
   442e0:	38 c1                	cmp    %al,%cl
   442e2:	0f 92 c0             	setb   %al
   442e5:	0f b6 c8             	movzbl %al,%ecx
   442e8:	89 d0                	mov    %edx,%eax
   442ea:	29 c8                	sub    %ecx,%eax
}
   442ec:	c9                   	leave  
   442ed:	c3                   	ret    

00000000000442ee <strchr>:

char* strchr(const char* s, int c) {
   442ee:	f3 0f 1e fa          	endbr64 
   442f2:	55                   	push   %rbp
   442f3:	48 89 e5             	mov    %rsp,%rbp
   442f6:	48 83 ec 10          	sub    $0x10,%rsp
   442fa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   442fe:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   44301:	eb 05                	jmp    44308 <strchr+0x1a>
        ++s;
   44303:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   44308:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4430c:	0f b6 00             	movzbl (%rax),%eax
   4430f:	84 c0                	test   %al,%al
   44311:	74 0e                	je     44321 <strchr+0x33>
   44313:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44317:	0f b6 00             	movzbl (%rax),%eax
   4431a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4431d:	38 d0                	cmp    %dl,%al
   4431f:	75 e2                	jne    44303 <strchr+0x15>
    }
    if (*s == (char) c) {
   44321:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44325:	0f b6 00             	movzbl (%rax),%eax
   44328:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4432b:	38 d0                	cmp    %dl,%al
   4432d:	75 06                	jne    44335 <strchr+0x47>
        return (char*) s;
   4432f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44333:	eb 05                	jmp    4433a <strchr+0x4c>
    } else {
        return NULL;
   44335:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   4433a:	c9                   	leave  
   4433b:	c3                   	ret    

000000000004433c <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   4433c:	f3 0f 1e fa          	endbr64 
   44340:	55                   	push   %rbp
   44341:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   44344:	8b 05 be 2c 01 00    	mov    0x12cbe(%rip),%eax        # 57008 <rand_seed_set>
   4434a:	85 c0                	test   %eax,%eax
   4434c:	75 0a                	jne    44358 <rand+0x1c>
        srand(819234718U);
   4434e:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   44353:	e8 24 00 00 00       	call   4437c <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   44358:	8b 05 ae 2c 01 00    	mov    0x12cae(%rip),%eax        # 5700c <rand_seed>
   4435e:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   44364:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   44369:	89 05 9d 2c 01 00    	mov    %eax,0x12c9d(%rip)        # 5700c <rand_seed>
    return rand_seed & RAND_MAX;
   4436f:	8b 05 97 2c 01 00    	mov    0x12c97(%rip),%eax        # 5700c <rand_seed>
   44375:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4437a:	5d                   	pop    %rbp
   4437b:	c3                   	ret    

000000000004437c <srand>:

void srand(unsigned seed) {
   4437c:	f3 0f 1e fa          	endbr64 
   44380:	55                   	push   %rbp
   44381:	48 89 e5             	mov    %rsp,%rbp
   44384:	48 83 ec 08          	sub    $0x8,%rsp
   44388:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   4438b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4438e:	89 05 78 2c 01 00    	mov    %eax,0x12c78(%rip)        # 5700c <rand_seed>
    rand_seed_set = 1;
   44394:	c7 05 6a 2c 01 00 01 	movl   $0x1,0x12c6a(%rip)        # 57008 <rand_seed_set>
   4439b:	00 00 00 
}
   4439e:	90                   	nop
   4439f:	c9                   	leave  
   443a0:	c3                   	ret    

00000000000443a1 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   443a1:	f3 0f 1e fa          	endbr64 
   443a5:	55                   	push   %rbp
   443a6:	48 89 e5             	mov    %rsp,%rbp
   443a9:	48 83 ec 28          	sub    $0x28,%rsp
   443ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   443b1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   443b5:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   443b8:	48 8d 05 81 1a 00 00 	lea    0x1a81(%rip),%rax        # 45e40 <upper_digits.1>
   443bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   443c3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   443c7:	79 0e                	jns    443d7 <fill_numbuf+0x36>
        digits = lower_digits;
   443c9:	48 8d 05 90 1a 00 00 	lea    0x1a90(%rip),%rax        # 45e60 <lower_digits.0>
   443d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   443d4:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   443d7:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   443dc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443e0:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   443e3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   443e6:	48 63 c8             	movslq %eax,%rcx
   443e9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   443ed:	ba 00 00 00 00       	mov    $0x0,%edx
   443f2:	48 f7 f1             	div    %rcx
   443f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   443f9:	48 01 d0             	add    %rdx,%rax
   443fc:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   44401:	0f b6 10             	movzbl (%rax),%edx
   44404:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44408:	88 10                	mov    %dl,(%rax)
        val /= base;
   4440a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4440d:	48 63 f0             	movslq %eax,%rsi
   44410:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44414:	ba 00 00 00 00       	mov    $0x0,%edx
   44419:	48 f7 f6             	div    %rsi
   4441c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   44420:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   44425:	75 bc                	jne    443e3 <fill_numbuf+0x42>
    return numbuf_end;
   44427:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4442b:	c9                   	leave  
   4442c:	c3                   	ret    

000000000004442d <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   4442d:	f3 0f 1e fa          	endbr64 
   44431:	55                   	push   %rbp
   44432:	48 89 e5             	mov    %rsp,%rbp
   44435:	53                   	push   %rbx
   44436:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   4443d:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   44444:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   4444a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44451:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   44458:	e9 bd 09 00 00       	jmp    44e1a <printer_vprintf+0x9ed>
        if (*format != '%') {
   4445d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44464:	0f b6 00             	movzbl (%rax),%eax
   44467:	3c 25                	cmp    $0x25,%al
   44469:	74 31                	je     4449c <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   4446b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44472:	4c 8b 00             	mov    (%rax),%r8
   44475:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4447c:	0f b6 00             	movzbl (%rax),%eax
   4447f:	0f b6 c8             	movzbl %al,%ecx
   44482:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44488:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4448f:	89 ce                	mov    %ecx,%esi
   44491:	48 89 c7             	mov    %rax,%rdi
   44494:	41 ff d0             	call   *%r8
            continue;
   44497:	e9 76 09 00 00       	jmp    44e12 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   4449c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   444a3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   444aa:	01 
   444ab:	eb 4d                	jmp    444fa <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   444ad:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   444b4:	0f b6 00             	movzbl (%rax),%eax
   444b7:	0f be c0             	movsbl %al,%eax
   444ba:	89 c6                	mov    %eax,%esi
   444bc:	48 8d 05 7d 18 00 00 	lea    0x187d(%rip),%rax        # 45d40 <flag_chars>
   444c3:	48 89 c7             	mov    %rax,%rdi
   444c6:	e8 23 fe ff ff       	call   442ee <strchr>
   444cb:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   444cf:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   444d4:	74 34                	je     4450a <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   444d6:	48 8d 15 63 18 00 00 	lea    0x1863(%rip),%rdx        # 45d40 <flag_chars>
   444dd:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   444e1:	48 29 d0             	sub    %rdx,%rax
   444e4:	ba 01 00 00 00       	mov    $0x1,%edx
   444e9:	89 c1                	mov    %eax,%ecx
   444eb:	d3 e2                	shl    %cl,%edx
   444ed:	89 d0                	mov    %edx,%eax
   444ef:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   444f2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   444f9:	01 
   444fa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44501:	0f b6 00             	movzbl (%rax),%eax
   44504:	84 c0                	test   %al,%al
   44506:	75 a5                	jne    444ad <printer_vprintf+0x80>
   44508:	eb 01                	jmp    4450b <printer_vprintf+0xde>
            } else {
                break;
   4450a:	90                   	nop
            }
        }

        // process width
        int width = -1;
   4450b:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   44512:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44519:	0f b6 00             	movzbl (%rax),%eax
   4451c:	3c 30                	cmp    $0x30,%al
   4451e:	7e 67                	jle    44587 <printer_vprintf+0x15a>
   44520:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44527:	0f b6 00             	movzbl (%rax),%eax
   4452a:	3c 39                	cmp    $0x39,%al
   4452c:	7f 59                	jg     44587 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4452e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   44535:	eb 2e                	jmp    44565 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   44537:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4453a:	89 d0                	mov    %edx,%eax
   4453c:	c1 e0 02             	shl    $0x2,%eax
   4453f:	01 d0                	add    %edx,%eax
   44541:	01 c0                	add    %eax,%eax
   44543:	89 c1                	mov    %eax,%ecx
   44545:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4454c:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44550:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44557:	0f b6 00             	movzbl (%rax),%eax
   4455a:	0f be c0             	movsbl %al,%eax
   4455d:	01 c8                	add    %ecx,%eax
   4455f:	83 e8 30             	sub    $0x30,%eax
   44562:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44565:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4456c:	0f b6 00             	movzbl (%rax),%eax
   4456f:	3c 2f                	cmp    $0x2f,%al
   44571:	0f 8e 85 00 00 00    	jle    445fc <printer_vprintf+0x1cf>
   44577:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4457e:	0f b6 00             	movzbl (%rax),%eax
   44581:	3c 39                	cmp    $0x39,%al
   44583:	7e b2                	jle    44537 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   44585:	eb 75                	jmp    445fc <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   44587:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4458e:	0f b6 00             	movzbl (%rax),%eax
   44591:	3c 2a                	cmp    $0x2a,%al
   44593:	75 68                	jne    445fd <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   44595:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4459c:	8b 00                	mov    (%rax),%eax
   4459e:	83 f8 2f             	cmp    $0x2f,%eax
   445a1:	77 30                	ja     445d3 <printer_vprintf+0x1a6>
   445a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445aa:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445b5:	8b 00                	mov    (%rax),%eax
   445b7:	89 c0                	mov    %eax,%eax
   445b9:	48 01 d0             	add    %rdx,%rax
   445bc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445c3:	8b 12                	mov    (%rdx),%edx
   445c5:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445c8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445cf:	89 0a                	mov    %ecx,(%rdx)
   445d1:	eb 1a                	jmp    445ed <printer_vprintf+0x1c0>
   445d3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445da:	48 8b 40 08          	mov    0x8(%rax),%rax
   445de:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445e2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445e9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445ed:	8b 00                	mov    (%rax),%eax
   445ef:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   445f2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   445f9:	01 
   445fa:	eb 01                	jmp    445fd <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   445fc:	90                   	nop
        }

        // process precision
        int precision = -1;
   445fd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   44604:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4460b:	0f b6 00             	movzbl (%rax),%eax
   4460e:	3c 2e                	cmp    $0x2e,%al
   44610:	0f 85 00 01 00 00    	jne    44716 <printer_vprintf+0x2e9>
            ++format;
   44616:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4461d:	01 
            if (*format >= '0' && *format <= '9') {
   4461e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44625:	0f b6 00             	movzbl (%rax),%eax
   44628:	3c 2f                	cmp    $0x2f,%al
   4462a:	7e 67                	jle    44693 <printer_vprintf+0x266>
   4462c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44633:	0f b6 00             	movzbl (%rax),%eax
   44636:	3c 39                	cmp    $0x39,%al
   44638:	7f 59                	jg     44693 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4463a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   44641:	eb 2e                	jmp    44671 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   44643:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   44646:	89 d0                	mov    %edx,%eax
   44648:	c1 e0 02             	shl    $0x2,%eax
   4464b:	01 d0                	add    %edx,%eax
   4464d:	01 c0                	add    %eax,%eax
   4464f:	89 c1                	mov    %eax,%ecx
   44651:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44658:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4465c:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44663:	0f b6 00             	movzbl (%rax),%eax
   44666:	0f be c0             	movsbl %al,%eax
   44669:	01 c8                	add    %ecx,%eax
   4466b:	83 e8 30             	sub    $0x30,%eax
   4466e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44671:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44678:	0f b6 00             	movzbl (%rax),%eax
   4467b:	3c 2f                	cmp    $0x2f,%al
   4467d:	0f 8e 85 00 00 00    	jle    44708 <printer_vprintf+0x2db>
   44683:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4468a:	0f b6 00             	movzbl (%rax),%eax
   4468d:	3c 39                	cmp    $0x39,%al
   4468f:	7e b2                	jle    44643 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   44691:	eb 75                	jmp    44708 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   44693:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4469a:	0f b6 00             	movzbl (%rax),%eax
   4469d:	3c 2a                	cmp    $0x2a,%al
   4469f:	75 68                	jne    44709 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   446a1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446a8:	8b 00                	mov    (%rax),%eax
   446aa:	83 f8 2f             	cmp    $0x2f,%eax
   446ad:	77 30                	ja     446df <printer_vprintf+0x2b2>
   446af:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446b6:	48 8b 50 10          	mov    0x10(%rax),%rdx
   446ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446c1:	8b 00                	mov    (%rax),%eax
   446c3:	89 c0                	mov    %eax,%eax
   446c5:	48 01 d0             	add    %rdx,%rax
   446c8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446cf:	8b 12                	mov    (%rdx),%edx
   446d1:	8d 4a 08             	lea    0x8(%rdx),%ecx
   446d4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446db:	89 0a                	mov    %ecx,(%rdx)
   446dd:	eb 1a                	jmp    446f9 <printer_vprintf+0x2cc>
   446df:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446e6:	48 8b 40 08          	mov    0x8(%rax),%rax
   446ea:	48 8d 48 08          	lea    0x8(%rax),%rcx
   446ee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446f5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   446f9:	8b 00                	mov    (%rax),%eax
   446fb:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   446fe:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44705:	01 
   44706:	eb 01                	jmp    44709 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   44708:	90                   	nop
            }
            if (precision < 0) {
   44709:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4470d:	79 07                	jns    44716 <printer_vprintf+0x2e9>
                precision = 0;
   4470f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   44716:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   4471d:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   44724:	00 
        int length = 0;
   44725:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   4472c:	48 8d 05 13 16 00 00 	lea    0x1613(%rip),%rax        # 45d46 <flag_chars+0x6>
   44733:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   44737:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4473e:	0f b6 00             	movzbl (%rax),%eax
   44741:	0f be c0             	movsbl %al,%eax
   44744:	83 e8 43             	sub    $0x43,%eax
   44747:	83 f8 37             	cmp    $0x37,%eax
   4474a:	0f 87 b6 03 00 00    	ja     44b06 <printer_vprintf+0x6d9>
   44750:	89 c0                	mov    %eax,%eax
   44752:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   44759:	00 
   4475a:	48 8d 05 f3 15 00 00 	lea    0x15f3(%rip),%rax        # 45d54 <flag_chars+0x14>
   44761:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   44764:	48 98                	cltq   
   44766:	48 8d 15 e7 15 00 00 	lea    0x15e7(%rip),%rdx        # 45d54 <flag_chars+0x14>
   4476d:	48 01 d0             	add    %rdx,%rax
   44770:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   44773:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   4477a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44781:	01 
            goto again;
   44782:	eb b3                	jmp    44737 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   44784:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44788:	74 5d                	je     447e7 <printer_vprintf+0x3ba>
   4478a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44791:	8b 00                	mov    (%rax),%eax
   44793:	83 f8 2f             	cmp    $0x2f,%eax
   44796:	77 30                	ja     447c8 <printer_vprintf+0x39b>
   44798:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4479f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   447a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447aa:	8b 00                	mov    (%rax),%eax
   447ac:	89 c0                	mov    %eax,%eax
   447ae:	48 01 d0             	add    %rdx,%rax
   447b1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447b8:	8b 12                	mov    (%rdx),%edx
   447ba:	8d 4a 08             	lea    0x8(%rdx),%ecx
   447bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447c4:	89 0a                	mov    %ecx,(%rdx)
   447c6:	eb 1a                	jmp    447e2 <printer_vprintf+0x3b5>
   447c8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447cf:	48 8b 40 08          	mov    0x8(%rax),%rax
   447d3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   447d7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447de:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   447e2:	48 8b 00             	mov    (%rax),%rax
   447e5:	eb 5c                	jmp    44843 <printer_vprintf+0x416>
   447e7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447ee:	8b 00                	mov    (%rax),%eax
   447f0:	83 f8 2f             	cmp    $0x2f,%eax
   447f3:	77 30                	ja     44825 <printer_vprintf+0x3f8>
   447f5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447fc:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44800:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44807:	8b 00                	mov    (%rax),%eax
   44809:	89 c0                	mov    %eax,%eax
   4480b:	48 01 d0             	add    %rdx,%rax
   4480e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44815:	8b 12                	mov    (%rdx),%edx
   44817:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4481a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44821:	89 0a                	mov    %ecx,(%rdx)
   44823:	eb 1a                	jmp    4483f <printer_vprintf+0x412>
   44825:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4482c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44830:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44834:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4483b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4483f:	8b 00                	mov    (%rax),%eax
   44841:	48 98                	cltq   
   44843:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   44847:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4484b:	48 c1 f8 38          	sar    $0x38,%rax
   4484f:	25 80 00 00 00       	and    $0x80,%eax
   44854:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   44857:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   4485b:	74 09                	je     44866 <printer_vprintf+0x439>
   4485d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44861:	48 f7 d8             	neg    %rax
   44864:	eb 04                	jmp    4486a <printer_vprintf+0x43d>
   44866:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4486a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   4486e:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   44871:	83 c8 60             	or     $0x60,%eax
   44874:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   44877:	e9 cf 02 00 00       	jmp    44b4b <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   4487c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44880:	74 5d                	je     448df <printer_vprintf+0x4b2>
   44882:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44889:	8b 00                	mov    (%rax),%eax
   4488b:	83 f8 2f             	cmp    $0x2f,%eax
   4488e:	77 30                	ja     448c0 <printer_vprintf+0x493>
   44890:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44897:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4489b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448a2:	8b 00                	mov    (%rax),%eax
   448a4:	89 c0                	mov    %eax,%eax
   448a6:	48 01 d0             	add    %rdx,%rax
   448a9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   448b0:	8b 12                	mov    (%rdx),%edx
   448b2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   448b5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   448bc:	89 0a                	mov    %ecx,(%rdx)
   448be:	eb 1a                	jmp    448da <printer_vprintf+0x4ad>
   448c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448c7:	48 8b 40 08          	mov    0x8(%rax),%rax
   448cb:	48 8d 48 08          	lea    0x8(%rax),%rcx
   448cf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   448d6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   448da:	48 8b 00             	mov    (%rax),%rax
   448dd:	eb 5c                	jmp    4493b <printer_vprintf+0x50e>
   448df:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448e6:	8b 00                	mov    (%rax),%eax
   448e8:	83 f8 2f             	cmp    $0x2f,%eax
   448eb:	77 30                	ja     4491d <printer_vprintf+0x4f0>
   448ed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448f4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   448f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448ff:	8b 00                	mov    (%rax),%eax
   44901:	89 c0                	mov    %eax,%eax
   44903:	48 01 d0             	add    %rdx,%rax
   44906:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4490d:	8b 12                	mov    (%rdx),%edx
   4490f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44912:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44919:	89 0a                	mov    %ecx,(%rdx)
   4491b:	eb 1a                	jmp    44937 <printer_vprintf+0x50a>
   4491d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44924:	48 8b 40 08          	mov    0x8(%rax),%rax
   44928:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4492c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44933:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44937:	8b 00                	mov    (%rax),%eax
   44939:	89 c0                	mov    %eax,%eax
   4493b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   4493f:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44943:	e9 03 02 00 00       	jmp    44b4b <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   44948:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   4494f:	e9 28 ff ff ff       	jmp    4487c <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   44954:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   4495b:	e9 1c ff ff ff       	jmp    4487c <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44960:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44967:	8b 00                	mov    (%rax),%eax
   44969:	83 f8 2f             	cmp    $0x2f,%eax
   4496c:	77 30                	ja     4499e <printer_vprintf+0x571>
   4496e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44975:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44979:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44980:	8b 00                	mov    (%rax),%eax
   44982:	89 c0                	mov    %eax,%eax
   44984:	48 01 d0             	add    %rdx,%rax
   44987:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4498e:	8b 12                	mov    (%rdx),%edx
   44990:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44993:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4499a:	89 0a                	mov    %ecx,(%rdx)
   4499c:	eb 1a                	jmp    449b8 <printer_vprintf+0x58b>
   4499e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   449a5:	48 8b 40 08          	mov    0x8(%rax),%rax
   449a9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   449ad:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   449b4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449b8:	48 8b 00             	mov    (%rax),%rax
   449bb:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   449bf:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   449c6:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   449cd:	e9 79 01 00 00       	jmp    44b4b <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   449d2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   449d9:	8b 00                	mov    (%rax),%eax
   449db:	83 f8 2f             	cmp    $0x2f,%eax
   449de:	77 30                	ja     44a10 <printer_vprintf+0x5e3>
   449e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   449e7:	48 8b 50 10          	mov    0x10(%rax),%rdx
   449eb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   449f2:	8b 00                	mov    (%rax),%eax
   449f4:	89 c0                	mov    %eax,%eax
   449f6:	48 01 d0             	add    %rdx,%rax
   449f9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a00:	8b 12                	mov    (%rdx),%edx
   44a02:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44a05:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a0c:	89 0a                	mov    %ecx,(%rdx)
   44a0e:	eb 1a                	jmp    44a2a <printer_vprintf+0x5fd>
   44a10:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a17:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a1b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44a1f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a26:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a2a:	48 8b 00             	mov    (%rax),%rax
   44a2d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   44a31:	e9 15 01 00 00       	jmp    44b4b <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   44a36:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a3d:	8b 00                	mov    (%rax),%eax
   44a3f:	83 f8 2f             	cmp    $0x2f,%eax
   44a42:	77 30                	ja     44a74 <printer_vprintf+0x647>
   44a44:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a4b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44a4f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a56:	8b 00                	mov    (%rax),%eax
   44a58:	89 c0                	mov    %eax,%eax
   44a5a:	48 01 d0             	add    %rdx,%rax
   44a5d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a64:	8b 12                	mov    (%rdx),%edx
   44a66:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44a69:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a70:	89 0a                	mov    %ecx,(%rdx)
   44a72:	eb 1a                	jmp    44a8e <printer_vprintf+0x661>
   44a74:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a7b:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a7f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44a83:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a8a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a8e:	8b 00                	mov    (%rax),%eax
   44a90:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   44a96:	e9 77 03 00 00       	jmp    44e12 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   44a9b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44a9f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44aa3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44aaa:	8b 00                	mov    (%rax),%eax
   44aac:	83 f8 2f             	cmp    $0x2f,%eax
   44aaf:	77 30                	ja     44ae1 <printer_vprintf+0x6b4>
   44ab1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44ab8:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44abc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44ac3:	8b 00                	mov    (%rax),%eax
   44ac5:	89 c0                	mov    %eax,%eax
   44ac7:	48 01 d0             	add    %rdx,%rax
   44aca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44ad1:	8b 12                	mov    (%rdx),%edx
   44ad3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44ad6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44add:	89 0a                	mov    %ecx,(%rdx)
   44adf:	eb 1a                	jmp    44afb <printer_vprintf+0x6ce>
   44ae1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44ae8:	48 8b 40 08          	mov    0x8(%rax),%rax
   44aec:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44af0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44af7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44afb:	8b 00                	mov    (%rax),%eax
   44afd:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44b00:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   44b04:	eb 45                	jmp    44b4b <printer_vprintf+0x71e>
        default:
            data = numbuf;
   44b06:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44b0a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   44b0e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44b15:	0f b6 00             	movzbl (%rax),%eax
   44b18:	84 c0                	test   %al,%al
   44b1a:	74 0c                	je     44b28 <printer_vprintf+0x6fb>
   44b1c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44b23:	0f b6 00             	movzbl (%rax),%eax
   44b26:	eb 05                	jmp    44b2d <printer_vprintf+0x700>
   44b28:	b8 25 00 00 00       	mov    $0x25,%eax
   44b2d:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44b30:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   44b34:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44b3b:	0f b6 00             	movzbl (%rax),%eax
   44b3e:	84 c0                	test   %al,%al
   44b40:	75 08                	jne    44b4a <printer_vprintf+0x71d>
                format--;
   44b42:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44b49:	01 
            }
            break;
   44b4a:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44b4b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44b4e:	83 e0 20             	and    $0x20,%eax
   44b51:	85 c0                	test   %eax,%eax
   44b53:	74 1e                	je     44b73 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   44b55:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44b59:	48 83 c0 18          	add    $0x18,%rax
   44b5d:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44b60:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44b64:	48 89 ce             	mov    %rcx,%rsi
   44b67:	48 89 c7             	mov    %rax,%rdi
   44b6a:	e8 32 f8 ff ff       	call   443a1 <fill_numbuf>
   44b6f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44b73:	48 8d 05 cc 11 00 00 	lea    0x11cc(%rip),%rax        # 45d46 <flag_chars+0x6>
   44b7a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44b7e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44b81:	83 e0 20             	and    $0x20,%eax
   44b84:	85 c0                	test   %eax,%eax
   44b86:	74 51                	je     44bd9 <printer_vprintf+0x7ac>
   44b88:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44b8b:	83 e0 40             	and    $0x40,%eax
   44b8e:	85 c0                	test   %eax,%eax
   44b90:	74 47                	je     44bd9 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   44b92:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44b95:	25 80 00 00 00       	and    $0x80,%eax
   44b9a:	85 c0                	test   %eax,%eax
   44b9c:	74 0d                	je     44bab <printer_vprintf+0x77e>
                prefix = "-";
   44b9e:	48 8d 05 a2 11 00 00 	lea    0x11a2(%rip),%rax        # 45d47 <flag_chars+0x7>
   44ba5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44ba9:	eb 7d                	jmp    44c28 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44bab:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44bae:	83 e0 10             	and    $0x10,%eax
   44bb1:	85 c0                	test   %eax,%eax
   44bb3:	74 0d                	je     44bc2 <printer_vprintf+0x795>
                prefix = "+";
   44bb5:	48 8d 05 8d 11 00 00 	lea    0x118d(%rip),%rax        # 45d49 <flag_chars+0x9>
   44bbc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44bc0:	eb 66                	jmp    44c28 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44bc2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44bc5:	83 e0 08             	and    $0x8,%eax
   44bc8:	85 c0                	test   %eax,%eax
   44bca:	74 5c                	je     44c28 <printer_vprintf+0x7fb>
                prefix = " ";
   44bcc:	48 8d 05 78 11 00 00 	lea    0x1178(%rip),%rax        # 45d4b <flag_chars+0xb>
   44bd3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44bd7:	eb 4f                	jmp    44c28 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44bd9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44bdc:	83 e0 20             	and    $0x20,%eax
   44bdf:	85 c0                	test   %eax,%eax
   44be1:	74 46                	je     44c29 <printer_vprintf+0x7fc>
   44be3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44be6:	83 e0 01             	and    $0x1,%eax
   44be9:	85 c0                	test   %eax,%eax
   44beb:	74 3c                	je     44c29 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   44bed:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   44bf1:	74 06                	je     44bf9 <printer_vprintf+0x7cc>
   44bf3:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44bf7:	75 30                	jne    44c29 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   44bf9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44bfe:	75 0c                	jne    44c0c <printer_vprintf+0x7df>
   44c00:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c03:	25 00 01 00 00       	and    $0x100,%eax
   44c08:	85 c0                	test   %eax,%eax
   44c0a:	74 1d                	je     44c29 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   44c0c:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44c10:	75 09                	jne    44c1b <printer_vprintf+0x7ee>
   44c12:	48 8d 05 34 11 00 00 	lea    0x1134(%rip),%rax        # 45d4d <flag_chars+0xd>
   44c19:	eb 07                	jmp    44c22 <printer_vprintf+0x7f5>
   44c1b:	48 8d 05 2e 11 00 00 	lea    0x112e(%rip),%rax        # 45d50 <flag_chars+0x10>
   44c22:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44c26:	eb 01                	jmp    44c29 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   44c28:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44c29:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44c2d:	78 24                	js     44c53 <printer_vprintf+0x826>
   44c2f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c32:	83 e0 20             	and    $0x20,%eax
   44c35:	85 c0                	test   %eax,%eax
   44c37:	75 1a                	jne    44c53 <printer_vprintf+0x826>
            len = strnlen(data, precision);
   44c39:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44c3c:	48 63 d0             	movslq %eax,%rdx
   44c3f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44c43:	48 89 d6             	mov    %rdx,%rsi
   44c46:	48 89 c7             	mov    %rax,%rdi
   44c49:	e8 91 f5 ff ff       	call   441df <strnlen>
   44c4e:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44c51:	eb 0f                	jmp    44c62 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   44c53:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44c57:	48 89 c7             	mov    %rax,%rdi
   44c5a:	e8 4b f5 ff ff       	call   441aa <strlen>
   44c5f:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44c62:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c65:	83 e0 20             	and    $0x20,%eax
   44c68:	85 c0                	test   %eax,%eax
   44c6a:	74 20                	je     44c8c <printer_vprintf+0x85f>
   44c6c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44c70:	78 1a                	js     44c8c <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   44c72:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44c75:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44c78:	7e 08                	jle    44c82 <printer_vprintf+0x855>
   44c7a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44c7d:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44c80:	eb 05                	jmp    44c87 <printer_vprintf+0x85a>
   44c82:	b8 00 00 00 00       	mov    $0x0,%eax
   44c87:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44c8a:	eb 5c                	jmp    44ce8 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44c8c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c8f:	83 e0 20             	and    $0x20,%eax
   44c92:	85 c0                	test   %eax,%eax
   44c94:	74 4b                	je     44ce1 <printer_vprintf+0x8b4>
   44c96:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c99:	83 e0 02             	and    $0x2,%eax
   44c9c:	85 c0                	test   %eax,%eax
   44c9e:	74 41                	je     44ce1 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44ca0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44ca3:	83 e0 04             	and    $0x4,%eax
   44ca6:	85 c0                	test   %eax,%eax
   44ca8:	75 37                	jne    44ce1 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   44caa:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44cae:	48 89 c7             	mov    %rax,%rdi
   44cb1:	e8 f4 f4 ff ff       	call   441aa <strlen>
   44cb6:	89 c2                	mov    %eax,%edx
   44cb8:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44cbb:	01 d0                	add    %edx,%eax
   44cbd:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44cc0:	7e 1f                	jle    44ce1 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   44cc2:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44cc5:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44cc8:	89 c3                	mov    %eax,%ebx
   44cca:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44cce:	48 89 c7             	mov    %rax,%rdi
   44cd1:	e8 d4 f4 ff ff       	call   441aa <strlen>
   44cd6:	89 c2                	mov    %eax,%edx
   44cd8:	89 d8                	mov    %ebx,%eax
   44cda:	29 d0                	sub    %edx,%eax
   44cdc:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44cdf:	eb 07                	jmp    44ce8 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   44ce1:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44ce8:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44ceb:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44cee:	01 d0                	add    %edx,%eax
   44cf0:	48 63 d8             	movslq %eax,%rbx
   44cf3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44cf7:	48 89 c7             	mov    %rax,%rdi
   44cfa:	e8 ab f4 ff ff       	call   441aa <strlen>
   44cff:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   44d03:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44d06:	29 d0                	sub    %edx,%eax
   44d08:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44d0b:	eb 25                	jmp    44d32 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   44d0d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d14:	48 8b 08             	mov    (%rax),%rcx
   44d17:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44d1d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d24:	be 20 00 00 00       	mov    $0x20,%esi
   44d29:	48 89 c7             	mov    %rax,%rdi
   44d2c:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44d2e:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44d32:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44d35:	83 e0 04             	and    $0x4,%eax
   44d38:	85 c0                	test   %eax,%eax
   44d3a:	75 36                	jne    44d72 <printer_vprintf+0x945>
   44d3c:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44d40:	7f cb                	jg     44d0d <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   44d42:	eb 2e                	jmp    44d72 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   44d44:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d4b:	4c 8b 00             	mov    (%rax),%r8
   44d4e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44d52:	0f b6 00             	movzbl (%rax),%eax
   44d55:	0f b6 c8             	movzbl %al,%ecx
   44d58:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44d5e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d65:	89 ce                	mov    %ecx,%esi
   44d67:	48 89 c7             	mov    %rax,%rdi
   44d6a:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44d6d:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44d72:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44d76:	0f b6 00             	movzbl (%rax),%eax
   44d79:	84 c0                	test   %al,%al
   44d7b:	75 c7                	jne    44d44 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   44d7d:	eb 25                	jmp    44da4 <printer_vprintf+0x977>
            p->putc(p, '0', color);
   44d7f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d86:	48 8b 08             	mov    (%rax),%rcx
   44d89:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44d8f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d96:	be 30 00 00 00       	mov    $0x30,%esi
   44d9b:	48 89 c7             	mov    %rax,%rdi
   44d9e:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44da0:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44da4:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44da8:	7f d5                	jg     44d7f <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   44daa:	eb 32                	jmp    44dde <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   44dac:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44db3:	4c 8b 00             	mov    (%rax),%r8
   44db6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44dba:	0f b6 00             	movzbl (%rax),%eax
   44dbd:	0f b6 c8             	movzbl %al,%ecx
   44dc0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44dc6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44dcd:	89 ce                	mov    %ecx,%esi
   44dcf:	48 89 c7             	mov    %rax,%rdi
   44dd2:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   44dd5:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44dda:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44dde:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44de2:	7f c8                	jg     44dac <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   44de4:	eb 25                	jmp    44e0b <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   44de6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44ded:	48 8b 08             	mov    (%rax),%rcx
   44df0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44df6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44dfd:	be 20 00 00 00       	mov    $0x20,%esi
   44e02:	48 89 c7             	mov    %rax,%rdi
   44e05:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44e07:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44e0b:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44e0f:	7f d5                	jg     44de6 <printer_vprintf+0x9b9>
        }
    done: ;
   44e11:	90                   	nop
    for (; *format; ++format) {
   44e12:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44e19:	01 
   44e1a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44e21:	0f b6 00             	movzbl (%rax),%eax
   44e24:	84 c0                	test   %al,%al
   44e26:	0f 85 31 f6 ff ff    	jne    4445d <printer_vprintf+0x30>
    }
}
   44e2c:	90                   	nop
   44e2d:	90                   	nop
   44e2e:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44e32:	c9                   	leave  
   44e33:	c3                   	ret    

0000000000044e34 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   44e34:	f3 0f 1e fa          	endbr64 
   44e38:	55                   	push   %rbp
   44e39:	48 89 e5             	mov    %rsp,%rbp
   44e3c:	48 83 ec 20          	sub    $0x20,%rsp
   44e40:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44e44:	89 f0                	mov    %esi,%eax
   44e46:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44e49:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44e4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44e50:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44e54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44e58:	48 8b 40 08          	mov    0x8(%rax),%rax
   44e5c:	48 8d 15 3d 41 07 00 	lea    0x7413d(%rip),%rdx        # b8fa0 <console+0xfa0>
   44e63:	48 39 d0             	cmp    %rdx,%rax
   44e66:	72 0f                	jb     44e77 <console_putc+0x43>
        cp->cursor = console;
   44e68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44e6c:	48 8d 15 8d 31 07 00 	lea    0x7318d(%rip),%rdx        # b8000 <console>
   44e73:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   44e77:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44e7b:	0f 85 82 00 00 00    	jne    44f03 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   44e81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44e85:	48 8b 40 08          	mov    0x8(%rax),%rax
   44e89:	48 8d 15 70 31 07 00 	lea    0x73170(%rip),%rdx        # b8000 <console>
   44e90:	48 29 d0             	sub    %rdx,%rax
   44e93:	48 d1 f8             	sar    %rax
   44e96:	48 89 c1             	mov    %rax,%rcx
   44e99:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44ea0:	66 66 66 
   44ea3:	48 89 c8             	mov    %rcx,%rax
   44ea6:	48 f7 ea             	imul   %rdx
   44ea9:	48 89 d0             	mov    %rdx,%rax
   44eac:	48 c1 f8 05          	sar    $0x5,%rax
   44eb0:	48 89 ce             	mov    %rcx,%rsi
   44eb3:	48 c1 fe 3f          	sar    $0x3f,%rsi
   44eb7:	48 29 f0             	sub    %rsi,%rax
   44eba:	48 89 c2             	mov    %rax,%rdx
   44ebd:	48 89 d0             	mov    %rdx,%rax
   44ec0:	48 c1 e0 02          	shl    $0x2,%rax
   44ec4:	48 01 d0             	add    %rdx,%rax
   44ec7:	48 c1 e0 04          	shl    $0x4,%rax
   44ecb:	48 29 c1             	sub    %rax,%rcx
   44ece:	48 89 ca             	mov    %rcx,%rdx
   44ed1:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44ed4:	eb 25                	jmp    44efb <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   44ed6:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44ed9:	83 c8 20             	or     $0x20,%eax
   44edc:	89 c6                	mov    %eax,%esi
   44ede:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44ee2:	48 8b 40 08          	mov    0x8(%rax),%rax
   44ee6:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44eea:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44eee:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44ef2:	89 f2                	mov    %esi,%edx
   44ef4:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44ef7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44efb:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44eff:	75 d5                	jne    44ed6 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44f01:	eb 24                	jmp    44f27 <console_putc+0xf3>
        *cp->cursor++ = c | color;
   44f03:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44f07:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44f0a:	89 d6                	mov    %edx,%esi
   44f0c:	09 c6                	or     %eax,%esi
   44f0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44f12:	48 8b 40 08          	mov    0x8(%rax),%rax
   44f16:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44f1a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44f1e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44f22:	89 f2                	mov    %esi,%edx
   44f24:	66 89 10             	mov    %dx,(%rax)
}
   44f27:	90                   	nop
   44f28:	c9                   	leave  
   44f29:	c3                   	ret    

0000000000044f2a <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44f2a:	f3 0f 1e fa          	endbr64 
   44f2e:	55                   	push   %rbp
   44f2f:	48 89 e5             	mov    %rsp,%rbp
   44f32:	48 83 ec 30          	sub    $0x30,%rsp
   44f36:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44f39:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44f3c:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44f40:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44f44:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 44e34 <console_putc>
   44f4b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44f4f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44f53:	78 09                	js     44f5e <console_vprintf+0x34>
   44f55:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44f5c:	7e 07                	jle    44f65 <console_vprintf+0x3b>
        cpos = 0;
   44f5e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44f65:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44f68:	48 98                	cltq   
   44f6a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44f6e:	48 8d 05 8b 30 07 00 	lea    0x7308b(%rip),%rax        # b8000 <console>
   44f75:	48 01 d0             	add    %rdx,%rax
   44f78:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44f7c:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44f80:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44f84:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44f87:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44f8b:	48 89 c7             	mov    %rax,%rdi
   44f8e:	e8 9a f4 ff ff       	call   4442d <printer_vprintf>
    return cp.cursor - console;
   44f93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44f97:	48 8d 15 62 30 07 00 	lea    0x73062(%rip),%rdx        # b8000 <console>
   44f9e:	48 29 d0             	sub    %rdx,%rax
   44fa1:	48 d1 f8             	sar    %rax
}
   44fa4:	c9                   	leave  
   44fa5:	c3                   	ret    

0000000000044fa6 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44fa6:	f3 0f 1e fa          	endbr64 
   44faa:	55                   	push   %rbp
   44fab:	48 89 e5             	mov    %rsp,%rbp
   44fae:	48 83 ec 60          	sub    $0x60,%rsp
   44fb2:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44fb5:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44fb8:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44fbc:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44fc0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44fc4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44fc8:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44fcf:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44fd3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44fd7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44fdb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44fdf:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44fe3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44fe7:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44fea:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44fed:	89 c7                	mov    %eax,%edi
   44fef:	e8 36 ff ff ff       	call   44f2a <console_vprintf>
   44ff4:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44ff7:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44ffa:	c9                   	leave  
   44ffb:	c3                   	ret    

0000000000044ffc <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44ffc:	f3 0f 1e fa          	endbr64 
   45000:	55                   	push   %rbp
   45001:	48 89 e5             	mov    %rsp,%rbp
   45004:	48 83 ec 20          	sub    $0x20,%rsp
   45008:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4500c:	89 f0                	mov    %esi,%eax
   4500e:	89 55 e0             	mov    %edx,-0x20(%rbp)
   45011:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   45014:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   45018:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   4501c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   45020:	48 8b 50 08          	mov    0x8(%rax),%rdx
   45024:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   45028:	48 8b 40 10          	mov    0x10(%rax),%rax
   4502c:	48 39 c2             	cmp    %rax,%rdx
   4502f:	73 1a                	jae    4504b <string_putc+0x4f>
        *sp->s++ = c;
   45031:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   45035:	48 8b 40 08          	mov    0x8(%rax),%rax
   45039:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4503d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   45041:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   45045:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   45049:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   4504b:	90                   	nop
   4504c:	c9                   	leave  
   4504d:	c3                   	ret    

000000000004504e <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   4504e:	f3 0f 1e fa          	endbr64 
   45052:	55                   	push   %rbp
   45053:	48 89 e5             	mov    %rsp,%rbp
   45056:	48 83 ec 40          	sub    $0x40,%rsp
   4505a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4505e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   45062:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   45066:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   4506a:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 44ffc <string_putc>
   45071:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   45075:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   45079:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   4507d:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   45082:	74 33                	je     450b7 <vsnprintf+0x69>
        sp.end = s + size - 1;
   45084:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   45088:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4508c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   45090:	48 01 d0             	add    %rdx,%rax
   45093:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   45097:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   4509b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4509f:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   450a3:	be 00 00 00 00       	mov    $0x0,%esi
   450a8:	48 89 c7             	mov    %rax,%rdi
   450ab:	e8 7d f3 ff ff       	call   4442d <printer_vprintf>
        *sp.s = 0;
   450b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   450b4:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   450b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   450bb:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   450bf:	c9                   	leave  
   450c0:	c3                   	ret    

00000000000450c1 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   450c1:	f3 0f 1e fa          	endbr64 
   450c5:	55                   	push   %rbp
   450c6:	48 89 e5             	mov    %rsp,%rbp
   450c9:	48 83 ec 70          	sub    $0x70,%rsp
   450cd:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   450d1:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   450d5:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   450d9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   450dd:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   450e1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   450e5:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   450ec:	48 8d 45 10          	lea    0x10(%rbp),%rax
   450f0:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   450f4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   450f8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   450fc:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   45100:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   45104:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   45108:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4510c:	48 89 c7             	mov    %rax,%rdi
   4510f:	e8 3a ff ff ff       	call   4504e <vsnprintf>
   45114:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   45117:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   4511a:	c9                   	leave  
   4511b:	c3                   	ret    

000000000004511c <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   4511c:	f3 0f 1e fa          	endbr64 
   45120:	55                   	push   %rbp
   45121:	48 89 e5             	mov    %rsp,%rbp
   45124:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   45128:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4512f:	eb 1a                	jmp    4514b <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   45131:	8b 45 fc             	mov    -0x4(%rbp),%eax
   45134:	48 98                	cltq   
   45136:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4513a:	48 8d 05 bf 2e 07 00 	lea    0x72ebf(%rip),%rax        # b8000 <console>
   45141:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   45147:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4514b:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   45152:	7e dd                	jle    45131 <console_clear+0x15>
    }
    cursorpos = 0;
   45154:	c7 05 9e 3e 07 00 00 	movl   $0x0,0x73e9e(%rip)        # b8ffc <cursorpos>
   4515b:	00 00 00 
}
   4515e:	90                   	nop
   4515f:	c9                   	leave  
   45160:	c3                   	ret    
