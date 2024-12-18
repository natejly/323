
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
   40177:	e8 19 17 00 00       	call   41895 <hardware_init>
    pageinfo_init();
   4017c:	e8 24 0c 00 00       	call   40da5 <pageinfo_init>
    console_clear();
   40181:	e8 9b 4f 00 00       	call   45121 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 6d 1c 00 00       	call   41dfd <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 5f ee 00 00 	lea    0xee5f(%rip),%rax        # 4f000 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 c3 3f 00 00       	call   4416c <memset>
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
   4021d:	e8 53 40 00 00       	call   44275 <strcmp>
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
   40252:	e8 1e 40 00 00       	call   44275 <strcmp>
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
   40287:	e8 e9 3f 00 00       	call   44275 <strcmp>
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
   402b9:	e8 b7 3f 00 00       	call   44275 <strcmp>
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
   402ff:	e8 f9 09 00 00       	call   40cfd <run>

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
   4033c:	e8 6f 1d 00 00       	call   420b0 <process_init>
    assert(process_config_tables(pid) == 0);
   40341:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40344:	89 c7                	mov    %eax,%edi
   40346:	e8 e2 35 00 00       	call   4392d <process_config_tables>
   4034b:	85 c0                	test   %eax,%eax
   4034d:	74 1e                	je     4036d <process_setup+0x69>
   4034f:	48 8d 05 72 4e 00 00 	lea    0x4e72(%rip),%rax        # 451c8 <memstate_colors+0x48>
   40356:	48 89 c2             	mov    %rax,%rdx
   40359:	be 77 00 00 00       	mov    $0x77,%esi
   4035e:	48 8d 05 83 4e 00 00 	lea    0x4e83(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40365:	48 89 c7             	mov    %rax,%rdi
   40368:	e8 79 25 00 00       	call   428e6 <assert_fail>

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
   40393:	e8 e3 38 00 00       	call   43c7b <process_load>
   40398:	85 c0                	test   %eax,%eax
   4039a:	79 1e                	jns    403ba <process_setup+0xb6>
   4039c:	48 8d 05 55 4e 00 00 	lea    0x4e55(%rip),%rax        # 451f8 <memstate_colors+0x78>
   403a3:	48 89 c2             	mov    %rax,%rdx
   403a6:	be 7a 00 00 00       	mov    $0x7a,%esi
   403ab:	48 8d 05 36 4e 00 00 	lea    0x4e36(%rip),%rax        # 451e8 <memstate_colors+0x68>
   403b2:	48 89 c7             	mov    %rax,%rdi
   403b5:	e8 2c 25 00 00       	call   428e6 <assert_fail>

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
   403db:	e8 d3 38 00 00       	call   43cb3 <process_setup_stack>

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
   404a7:	e8 ba 38 00 00       	call   43d66 <process_fork>
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
   404c1:	e8 85 31 00 00       	call   4364b <process_free>
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
   404ea:	e8 09 3b 00 00       	call   43ff8 <process_page_alloc>
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
   4059d:	e8 14 2b 00 00       	call   430b6 <virtual_memory_lookup>
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
   405cb:	e8 9a 26 00 00       	call   42c6a <virtual_memory_map>
                pageinfo[map.pn].refcount = 0;
   405d0:	8b 45 b8             	mov    -0x48(%rbp),%eax
   405d3:	48 98                	cltq   
   405d5:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   405d9:	48 8d 05 41 f9 00 00 	lea    0xf941(%rip),%rax        # 4ff21 <pageinfo+0x1>
   405e0:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[map.pn].owner = PO_FREE;
   405e4:	8b 45 b8             	mov    -0x48(%rbp),%eax
   405e7:	48 98                	cltq   
   405e9:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   405ed:	48 8d 05 2c f9 00 00 	lea    0xf92c(%rip),%rax        # 4ff20 <pageinfo>
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
   406e2:	e8 cf 29 00 00       	call   430b6 <virtual_memory_lookup>

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
   40734:	e8 7d 29 00 00       	call   430b6 <virtual_memory_lookup>
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
   40760:	e8 51 29 00 00       	call   430b6 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40765:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40769:	48 89 c1             	mov    %rax,%rcx
   4076c:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40770:	ba 18 00 00 00       	mov    $0x18,%edx
   40775:	48 89 c6             	mov    %rax,%rsi
   40778:	48 89 cf             	mov    %rcx,%rdi
   4077b:	e8 e6 38 00 00       	call   44066 <memcpy>
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
   4080b:	48 8b 05 ee f6 00 00 	mov    0xf6ee(%rip),%rax        # 4ff00 <current>
   40812:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   40819:	48 83 c0 18          	add    $0x18,%rax
   4081d:	48 89 d6             	mov    %rdx,%rsi
   40820:	ba 18 00 00 00       	mov    $0x18,%edx
   40825:	48 89 c7             	mov    %rax,%rdi
   40828:	48 89 d1             	mov    %rdx,%rcx
   4082b:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   4082e:	48 8b 05 cb 17 01 00 	mov    0x117cb(%rip),%rax        # 52000 <kernel_pagetable>
   40835:	48 89 c7             	mov    %rax,%rdi
   40838:	e8 bb 22 00 00       	call   42af8 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   4083d:	8b 05 b9 87 07 00    	mov    0x787b9(%rip),%eax        # b8ffc <cursorpos>
   40843:	89 c7                	mov    %eax,%edi
   40845:	e8 34 19 00 00       	call   4217e <console_show_cursor>
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
   40888:	e8 42 09 00 00       	call   411cf <check_virtual_memory>
        if(disp_global){
   4088d:	0f b6 05 6c 57 00 00 	movzbl 0x576c(%rip),%eax        # 46000 <disp_global>
   40894:	84 c0                	test   %al,%al
   40896:	74 0a                	je     408a2 <exception+0xad>
            memshow_physical();
   40898:	e8 fb 0a 00 00       	call   41398 <memshow_physical>
            memshow_virtual_animate();
   4089d:	e8 98 0e 00 00       	call   4173a <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   408a2:	e8 ed 1d 00 00       	call   42694 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   408a7:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   408ae:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   408b5:	48 83 e8 0e          	sub    $0xe,%rax
   408b9:	48 83 f8 2c          	cmp    $0x2c,%rax
   408bd:	0f 87 82 03 00 00    	ja     40c45 <exception+0x450>
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
   408e4:	48 8b 05 15 f6 00 00 	mov    0xf615(%rip),%rax        # 4ff00 <current>
   408eb:	48 8b 40 48          	mov    0x48(%rax),%rax
   408ef:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                    if((void *)addr == NULL)
   408f3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   408f8:	75 0f                	jne    40909 <exception+0x114>
                        kernel_panic(NULL);
   408fa:	bf 00 00 00 00       	mov    $0x0,%edi
   408ff:	b8 00 00 00 00       	mov    $0x0,%eax
   40904:	e8 ed 1e 00 00       	call   427f6 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40909:	48 8b 05 f0 f5 00 00 	mov    0xf5f0(%rip),%rax        # 4ff00 <current>
   40910:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40917:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   4091b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4091f:	48 89 ce             	mov    %rcx,%rsi
   40922:	48 89 c7             	mov    %rax,%rdi
   40925:	e8 8c 27 00 00       	call   430b6 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   4092a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4092e:	48 89 c1             	mov    %rax,%rcx
   40931:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   40938:	ba a0 00 00 00       	mov    $0xa0,%edx
   4093d:	48 89 ce             	mov    %rcx,%rsi
   40940:	48 89 c7             	mov    %rax,%rdi
   40943:	e8 1e 37 00 00       	call   44066 <memcpy>
                    kernel_panic(msg);
   40948:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   4094f:	48 89 c7             	mov    %rax,%rdi
   40952:	b8 00 00 00 00       	mov    $0x0,%eax
   40957:	e8 9a 1e 00 00       	call   427f6 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   4095c:	48 8b 05 9d f5 00 00 	mov    0xf59d(%rip),%rax        # 4ff00 <current>
   40963:	8b 10                	mov    (%rax),%edx
   40965:	48 8b 05 94 f5 00 00 	mov    0xf594(%rip),%rax        # 4ff00 <current>
   4096c:	48 63 d2             	movslq %edx,%rdx
   4096f:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40973:	e9 dd 02 00 00       	jmp    40c55 <exception+0x460>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   40978:	b8 00 00 00 00       	mov    $0x0,%eax
   4097d:	e8 13 fb ff ff       	call   40495 <syscall_fork>
   40982:	89 c2                	mov    %eax,%edx
   40984:	48 8b 05 75 f5 00 00 	mov    0xf575(%rip),%rax        # 4ff00 <current>
   4098b:	48 63 d2             	movslq %edx,%rdx
   4098e:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40992:	e9 be 02 00 00       	jmp    40c55 <exception+0x460>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   40997:	48 8b 05 62 f5 00 00 	mov    0xf562(%rip),%rax        # 4ff00 <current>
   4099e:	48 89 c7             	mov    %rax,%rdi
   409a1:	e8 fb fc ff ff       	call   406a1 <syscall_mapping>
                break;
   409a6:	e9 aa 02 00 00       	jmp    40c55 <exception+0x460>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   409ab:	b8 00 00 00 00       	mov    $0x0,%eax
   409b0:	e8 f9 fa ff ff       	call   404ae <syscall_exit>
                schedule();
   409b5:	e8 c4 02 00 00       	call   40c7e <schedule>
                break;
   409ba:	e9 96 02 00 00       	jmp    40c55 <exception+0x460>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   409bf:	e8 ba 02 00 00       	call   40c7e <schedule>
                break;                  /* will not be reached */
   409c4:	e9 8c 02 00 00       	jmp    40c55 <exception+0x460>
            }

    case INT_SYS_BRK:
        current->p_registers.reg_rax = syscall_brk(current, current->p_registers.reg_rdi);
   409c9:	48 8b 05 30 f5 00 00 	mov    0xf530(%rip),%rax        # 4ff00 <current>
   409d0:	48 8b 50 48          	mov    0x48(%rax),%rdx
   409d4:	48 8b 05 25 f5 00 00 	mov    0xf525(%rip),%rax        # 4ff00 <current>
   409db:	48 89 d6             	mov    %rdx,%rsi
   409de:	48 89 c7             	mov    %rax,%rdi
   409e1:	e8 0b fb ff ff       	call   404f1 <syscall_brk>
   409e6:	89 c2                	mov    %eax,%edx
   409e8:	48 8b 05 11 f5 00 00 	mov    0xf511(%rip),%rax        # 4ff00 <current>
   409ef:	48 63 d2             	movslq %edx,%rdx
   409f2:	48 89 50 18          	mov    %rdx,0x18(%rax)
        break;
   409f6:	e9 5a 02 00 00       	jmp    40c55 <exception+0x460>

    case INT_SYS_SBRK:
        current->p_registers.reg_rax = syscall_sbrk(current, current->p_registers.reg_rdi);
   409fb:	48 8b 05 fe f4 00 00 	mov    0xf4fe(%rip),%rax        # 4ff00 <current>
   40a02:	48 8b 40 48          	mov    0x48(%rax),%rax
   40a06:	48 89 c2             	mov    %rax,%rdx
   40a09:	48 8b 05 f0 f4 00 00 	mov    0xf4f0(%rip),%rax        # 4ff00 <current>
   40a10:	48 89 d6             	mov    %rdx,%rsi
   40a13:	48 89 c7             	mov    %rax,%rdi
   40a16:	e8 31 fc ff ff       	call   4064c <syscall_sbrk>
   40a1b:	48 89 c2             	mov    %rax,%rdx
   40a1e:	48 8b 05 db f4 00 00 	mov    0xf4db(%rip),%rax        # 4ff00 <current>
   40a25:	48 89 50 18          	mov    %rdx,0x18(%rax)
        break;
   40a29:	e9 27 02 00 00       	jmp    40c55 <exception+0x460>

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
   40a49:	e9 07 02 00 00       	jmp    40c55 <exception+0x460>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40a4e:	48 8b 05 ab f4 00 00 	mov    0xf4ab(%rip),%rax        # 4ff00 <current>
   40a55:	48 89 c7             	mov    %rax,%rdi
   40a58:	e8 2b fd ff ff       	call   40788 <syscall_mem_tog>
                break;
   40a5d:	e9 f3 01 00 00       	jmp    40c55 <exception+0x460>
            }

        case INT_TIMER:
            {
                ++ticks;
   40a62:	8b 05 b8 f8 00 00    	mov    0xf8b8(%rip),%eax        # 50320 <ticks>
   40a68:	83 c0 01             	add    $0x1,%eax
   40a6b:	89 05 af f8 00 00    	mov    %eax,0xf8af(%rip)        # 50320 <ticks>
                schedule();
   40a71:	e8 08 02 00 00       	call   40c7e <schedule>
                break;                  /* will not be reached */
   40a76:	e9 da 01 00 00       	jmp    40c55 <exception+0x460>
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
   40b23:	e8 ce 1c 00 00       	call   427f6 <kernel_panic>
                     addr, operation, problem, reg->reg_rip);
    }

    if (addr >= current->original_break && addr < current->program_break) {
   40b28:	48 8b 05 d1 f3 00 00 	mov    0xf3d1(%rip),%rax        # 4ff00 <current>
   40b2f:	48 8b 40 10          	mov    0x10(%rax),%rax
   40b33:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40b37:	0f 82 9e 00 00 00    	jb     40bdb <exception+0x3e6>
   40b3d:	48 8b 05 bc f3 00 00 	mov    0xf3bc(%rip),%rax        # 4ff00 <current>
   40b44:	48 8b 40 08          	mov    0x8(%rax),%rax
   40b48:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40b4c:	0f 83 89 00 00 00    	jae    40bdb <exception+0x3e6>
        uintptr_t faulting_page = addr & ~(PAGESIZE - 1); 
   40b52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40b56:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40b5c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        uintptr_t pa = (uintptr_t) palloc(current->p_pid);
   40b60:	48 8b 05 99 f3 00 00 	mov    0xf399(%rip),%rax        # 4ff00 <current>
   40b67:	8b 00                	mov    (%rax),%eax
   40b69:	89 c7                	mov    %eax,%edi
   40b6b:	e8 c2 29 00 00       	call   43532 <palloc>
   40b70:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        if (!pa || virtual_memory_map(current->p_pagetable, faulting_page, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   40b74:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40b79:	74 2d                	je     40ba8 <exception+0x3b3>
   40b7b:	48 8b 05 7e f3 00 00 	mov    0xf37e(%rip),%rax        # 4ff00 <current>
   40b82:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40b89:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40b8d:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40b91:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40b97:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40b9c:	48 89 c7             	mov    %rax,%rdi
   40b9f:	e8 c6 20 00 00       	call   42c6a <virtual_memory_map>
   40ba4:	85 c0                	test   %eax,%eax
   40ba6:	79 20                	jns    40bc8 <exception+0x3d3>
            current->p_state = P_BROKEN;
   40ba8:	48 8b 05 51 f3 00 00 	mov    0xf351(%rip),%rax        # 4ff00 <current>
   40baf:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40bb6:	00 00 00 
            syscall_exit();
   40bb9:	b8 00 00 00 00       	mov    $0x0,%eax
   40bbe:	e8 eb f8 ff ff       	call   404ae <syscall_exit>
            break;
   40bc3:	e9 8d 00 00 00       	jmp    40c55 <exception+0x460>
        }
        current->p_state = P_RUNNABLE;
   40bc8:	48 8b 05 31 f3 00 00 	mov    0xf331(%rip),%rax        # 4ff00 <current>
   40bcf:	c7 80 d8 00 00 00 01 	movl   $0x1,0xd8(%rax)
   40bd6:	00 00 00 
        break;
   40bd9:	eb 7a                	jmp    40c55 <exception+0x460>
    }

    // If the fault is outside the heap, treat it as an error
    console_printf(CPOS(24, 0), 0x0C00,
   40bdb:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40be2:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                   "Process %d page fault for %p (%s %s, rip=%p)!\n",
                   current->p_pid, addr, operation, problem, reg->reg_rip);
   40be9:	48 8b 05 10 f3 00 00 	mov    0xf310(%rip),%rax        # 4ff00 <current>
    console_printf(CPOS(24, 0), 0x0C00,
   40bf0:	8b 00                	mov    (%rax),%eax
   40bf2:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   40bf6:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   40bfa:	52                   	push   %rdx
   40bfb:	ff 75 d8             	push   -0x28(%rbp)
   40bfe:	49 89 f1             	mov    %rsi,%r9
   40c01:	49 89 c8             	mov    %rcx,%r8
   40c04:	89 c1                	mov    %eax,%ecx
   40c06:	48 8d 05 7b 46 00 00 	lea    0x467b(%rip),%rax        # 45288 <memstate_colors+0x108>
   40c0d:	48 89 c2             	mov    %rax,%rdx
   40c10:	be 00 0c 00 00       	mov    $0xc00,%esi
   40c15:	bf 80 07 00 00       	mov    $0x780,%edi
   40c1a:	b8 00 00 00 00       	mov    $0x0,%eax
   40c1f:	e8 87 43 00 00       	call   44fab <console_printf>
   40c24:	48 83 c4 10          	add    $0x10,%rsp
    current->p_state = P_BROKEN;
   40c28:	48 8b 05 d1 f2 00 00 	mov    0xf2d1(%rip),%rax        # 4ff00 <current>
   40c2f:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40c36:	00 00 00 
    syscall_exit();
   40c39:	b8 00 00 00 00       	mov    $0x0,%eax
   40c3e:	e8 6b f8 ff ff       	call   404ae <syscall_exit>
    break;
   40c43:	eb 10                	jmp    40c55 <exception+0x460>
}

    default:
        default_exception(current);
   40c45:	48 8b 05 b4 f2 00 00 	mov    0xf2b4(%rip),%rax        # 4ff00 <current>
   40c4c:	48 89 c7             	mov    %rax,%rdi
   40c4f:	e8 cb 1c 00 00       	call   4291f <default_exception>
        break;                  /* will not be reached */
   40c54:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40c55:	48 8b 05 a4 f2 00 00 	mov    0xf2a4(%rip),%rax        # 4ff00 <current>
   40c5c:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c62:	83 f8 01             	cmp    $0x1,%eax
   40c65:	75 0f                	jne    40c76 <exception+0x481>
        run(current);
   40c67:	48 8b 05 92 f2 00 00 	mov    0xf292(%rip),%rax        # 4ff00 <current>
   40c6e:	48 89 c7             	mov    %rax,%rdi
   40c71:	e8 87 00 00 00       	call   40cfd <run>
    } else {
        schedule();
   40c76:	e8 03 00 00 00       	call   40c7e <schedule>
    }
}
   40c7b:	90                   	nop
   40c7c:	c9                   	leave  
   40c7d:	c3                   	ret    

0000000000040c7e <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40c7e:	f3 0f 1e fa          	endbr64 
   40c82:	55                   	push   %rbp
   40c83:	48 89 e5             	mov    %rsp,%rbp
   40c86:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40c8a:	48 8b 05 6f f2 00 00 	mov    0xf26f(%rip),%rax        # 4ff00 <current>
   40c91:	8b 00                	mov    (%rax),%eax
   40c93:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40c96:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c99:	83 c0 01             	add    $0x1,%eax
   40c9c:	99                   	cltd   
   40c9d:	c1 ea 1c             	shr    $0x1c,%edx
   40ca0:	01 d0                	add    %edx,%eax
   40ca2:	83 e0 0f             	and    $0xf,%eax
   40ca5:	29 d0                	sub    %edx,%eax
   40ca7:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40caa:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cad:	48 63 d0             	movslq %eax,%rdx
   40cb0:	48 89 d0             	mov    %rdx,%rax
   40cb3:	48 c1 e0 04          	shl    $0x4,%rax
   40cb7:	48 29 d0             	sub    %rdx,%rax
   40cba:	48 c1 e0 04          	shl    $0x4,%rax
   40cbe:	48 89 c2             	mov    %rax,%rdx
   40cc1:	48 8d 05 10 e4 00 00 	lea    0xe410(%rip),%rax        # 4f0d8 <processes+0xd8>
   40cc8:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40ccb:	83 f8 01             	cmp    $0x1,%eax
   40cce:	75 26                	jne    40cf6 <schedule+0x78>
            run(&processes[pid]);
   40cd0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cd3:	48 63 d0             	movslq %eax,%rdx
   40cd6:	48 89 d0             	mov    %rdx,%rax
   40cd9:	48 c1 e0 04          	shl    $0x4,%rax
   40cdd:	48 29 d0             	sub    %rdx,%rax
   40ce0:	48 c1 e0 04          	shl    $0x4,%rax
   40ce4:	48 8d 15 15 e3 00 00 	lea    0xe315(%rip),%rdx        # 4f000 <processes>
   40ceb:	48 01 d0             	add    %rdx,%rax
   40cee:	48 89 c7             	mov    %rax,%rdi
   40cf1:	e8 07 00 00 00       	call   40cfd <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40cf6:	e8 99 19 00 00       	call   42694 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40cfb:	eb 99                	jmp    40c96 <schedule+0x18>

0000000000040cfd <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40cfd:	f3 0f 1e fa          	endbr64 
   40d01:	55                   	push   %rbp
   40d02:	48 89 e5             	mov    %rsp,%rbp
   40d05:	48 83 ec 10          	sub    $0x10,%rsp
   40d09:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40d0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d11:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40d17:	83 f8 01             	cmp    $0x1,%eax
   40d1a:	74 1e                	je     40d3a <run+0x3d>
   40d1c:	48 8d 05 49 46 00 00 	lea    0x4649(%rip),%rax        # 4536c <memstate_colors+0x1ec>
   40d23:	48 89 c2             	mov    %rax,%rdx
   40d26:	be ab 01 00 00       	mov    $0x1ab,%esi
   40d2b:	48 8d 05 b6 44 00 00 	lea    0x44b6(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40d32:	48 89 c7             	mov    %rax,%rdi
   40d35:	e8 ac 1b 00 00       	call   428e6 <assert_fail>
    current = p;
   40d3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d3e:	48 89 05 bb f1 00 00 	mov    %rax,0xf1bb(%rip)        # 4ff00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40d45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d49:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40d4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d4f:	8b 00                	mov    (%rax),%eax
   40d51:	83 c0 02             	add    $0x2,%eax
   40d54:	48 98                	cltq   
   40d56:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40d5a:	48 8d 05 1f 44 00 00 	lea    0x441f(%rip),%rax        # 45180 <memstate_colors>
   40d61:	0f b7 04 01          	movzwl (%rcx,%rax,1),%eax
    console_printf(CPOS(24, 79),
   40d65:	0f b7 c0             	movzwl %ax,%eax
   40d68:	89 d1                	mov    %edx,%ecx
   40d6a:	48 8d 15 14 46 00 00 	lea    0x4614(%rip),%rdx        # 45385 <memstate_colors+0x205>
   40d71:	89 c6                	mov    %eax,%esi
   40d73:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40d78:	b8 00 00 00 00       	mov    $0x0,%eax
   40d7d:	e8 29 42 00 00       	call   44fab <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40d82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d86:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40d8d:	48 89 c7             	mov    %rax,%rdi
   40d90:	e8 63 1d 00 00       	call   42af8 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40d95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d99:	48 83 c0 18          	add    $0x18,%rax
   40d9d:	48 89 c7             	mov    %rax,%rdi
   40da0:	e8 1e f3 ff ff       	call   400c3 <exception_return>

0000000000040da5 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40da5:	f3 0f 1e fa          	endbr64 
   40da9:	55                   	push   %rbp
   40daa:	48 89 e5             	mov    %rsp,%rbp
   40dad:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40db1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40db8:	00 
   40db9:	e9 93 00 00 00       	jmp    40e51 <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40dbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dc2:	48 89 c7             	mov    %rax,%rdi
   40dc5:	e8 04 11 00 00       	call   41ece <physical_memory_isreserved>
   40dca:	85 c0                	test   %eax,%eax
   40dcc:	74 09                	je     40dd7 <pageinfo_init+0x32>
            owner = PO_RESERVED;
   40dce:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40dd5:	eb 31                	jmp    40e08 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40dd7:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40dde:	00 
   40ddf:	76 0d                	jbe    40dee <pageinfo_init+0x49>
   40de1:	48 8d 05 28 72 01 00 	lea    0x17228(%rip),%rax        # 58010 <end>
   40de8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dec:	72 0a                	jb     40df8 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40dee:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40df5:	00 
   40df6:	75 09                	jne    40e01 <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   40df8:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40dff:	eb 07                	jmp    40e08 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   40e01:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40e08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e0c:	48 c1 e8 0c          	shr    $0xc,%rax
   40e10:	89 c2                	mov    %eax,%edx
   40e12:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e15:	89 c1                	mov    %eax,%ecx
   40e17:	48 63 c2             	movslq %edx,%rax
   40e1a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e1e:	48 8d 05 fb f0 00 00 	lea    0xf0fb(%rip),%rax        # 4ff20 <pageinfo>
   40e25:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40e28:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40e2c:	0f 95 c2             	setne  %dl
   40e2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e33:	48 c1 e8 0c          	shr    $0xc,%rax
   40e37:	89 d1                	mov    %edx,%ecx
   40e39:	48 98                	cltq   
   40e3b:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e3f:	48 8d 05 db f0 00 00 	lea    0xf0db(%rip),%rax        # 4ff21 <pageinfo+0x1>
   40e46:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e49:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e50:	00 
   40e51:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40e58:	00 
   40e59:	0f 86 5f ff ff ff    	jbe    40dbe <pageinfo_init+0x19>
    }
}
   40e5f:	90                   	nop
   40e60:	90                   	nop
   40e61:	c9                   	leave  
   40e62:	c3                   	ret    

0000000000040e63 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40e63:	f3 0f 1e fa          	endbr64 
   40e67:	55                   	push   %rbp
   40e68:	48 89 e5             	mov    %rsp,%rbp
   40e6b:	48 83 ec 50          	sub    $0x50,%rsp
   40e6f:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40e73:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e77:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40e7d:	48 89 c2             	mov    %rax,%rdx
   40e80:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40e84:	48 39 c2             	cmp    %rax,%rdx
   40e87:	74 1e                	je     40ea7 <check_page_table_mappings+0x44>
   40e89:	48 8d 05 f8 44 00 00 	lea    0x44f8(%rip),%rax        # 45388 <memstate_colors+0x208>
   40e90:	48 89 c2             	mov    %rax,%rdx
   40e93:	be d9 01 00 00       	mov    $0x1d9,%esi
   40e98:	48 8d 05 49 43 00 00 	lea    0x4349(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40e9f:	48 89 c7             	mov    %rax,%rdi
   40ea2:	e8 3f 1a 00 00       	call   428e6 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40ea7:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40eae:	00 
   40eaf:	e9 b5 00 00 00       	jmp    40f69 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40eb4:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40eb8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40ebc:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40ec0:	48 89 ce             	mov    %rcx,%rsi
   40ec3:	48 89 c7             	mov    %rax,%rdi
   40ec6:	e8 eb 21 00 00       	call   430b6 <virtual_memory_lookup>
        if (vam.pa != va) {
   40ecb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ecf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ed3:	74 2c                	je     40f01 <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40ed5:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40ed9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40edd:	49 89 d0             	mov    %rdx,%r8
   40ee0:	48 89 c1             	mov    %rax,%rcx
   40ee3:	48 8d 05 bd 44 00 00 	lea    0x44bd(%rip),%rax        # 453a7 <memstate_colors+0x227>
   40eea:	48 89 c2             	mov    %rax,%rdx
   40eed:	be 00 c0 00 00       	mov    $0xc000,%esi
   40ef2:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40ef7:	b8 00 00 00 00       	mov    $0x0,%eax
   40efc:	e8 aa 40 00 00       	call   44fab <console_printf>
        }
        assert(vam.pa == va);
   40f01:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f05:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f09:	74 1e                	je     40f29 <check_page_table_mappings+0xc6>
   40f0b:	48 8d 05 9f 44 00 00 	lea    0x449f(%rip),%rax        # 453b1 <memstate_colors+0x231>
   40f12:	48 89 c2             	mov    %rax,%rdx
   40f15:	be e2 01 00 00       	mov    $0x1e2,%esi
   40f1a:	48 8d 05 c7 42 00 00 	lea    0x42c7(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40f21:	48 89 c7             	mov    %rax,%rdi
   40f24:	e8 bd 19 00 00       	call   428e6 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40f29:	48 8d 05 d0 50 00 00 	lea    0x50d0(%rip),%rax        # 46000 <disp_global>
   40f30:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f34:	72 2b                	jb     40f61 <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   40f36:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f39:	48 98                	cltq   
   40f3b:	83 e0 02             	and    $0x2,%eax
   40f3e:	48 85 c0             	test   %rax,%rax
   40f41:	75 1e                	jne    40f61 <check_page_table_mappings+0xfe>
   40f43:	48 8d 05 74 44 00 00 	lea    0x4474(%rip),%rax        # 453be <memstate_colors+0x23e>
   40f4a:	48 89 c2             	mov    %rax,%rdx
   40f4d:	be e4 01 00 00       	mov    $0x1e4,%esi
   40f52:	48 8d 05 8f 42 00 00 	lea    0x428f(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40f59:	48 89 c7             	mov    %rax,%rdi
   40f5c:	e8 85 19 00 00       	call   428e6 <assert_fail>
         va += PAGESIZE) {
   40f61:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40f68:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40f69:	48 8d 05 a0 70 01 00 	lea    0x170a0(%rip),%rax        # 58010 <end>
   40f70:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f74:	0f 82 3a ff ff ff    	jb     40eb4 <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40f7a:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40f81:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40f82:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40f86:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40f8a:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f8e:	48 89 ce             	mov    %rcx,%rsi
   40f91:	48 89 c7             	mov    %rax,%rdi
   40f94:	e8 1d 21 00 00       	call   430b6 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40f99:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40f9d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40fa1:	74 1e                	je     40fc1 <check_page_table_mappings+0x15e>
   40fa3:	48 8d 05 25 44 00 00 	lea    0x4425(%rip),%rax        # 453cf <memstate_colors+0x24f>
   40faa:	48 89 c2             	mov    %rax,%rdx
   40fad:	be eb 01 00 00       	mov    $0x1eb,%esi
   40fb2:	48 8d 05 2f 42 00 00 	lea    0x422f(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40fb9:	48 89 c7             	mov    %rax,%rdi
   40fbc:	e8 25 19 00 00       	call   428e6 <assert_fail>
    assert(vam.perm & PTE_W);
   40fc1:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40fc4:	48 98                	cltq   
   40fc6:	83 e0 02             	and    $0x2,%eax
   40fc9:	48 85 c0             	test   %rax,%rax
   40fcc:	75 1e                	jne    40fec <check_page_table_mappings+0x189>
   40fce:	48 8d 05 e9 43 00 00 	lea    0x43e9(%rip),%rax        # 453be <memstate_colors+0x23e>
   40fd5:	48 89 c2             	mov    %rax,%rdx
   40fd8:	be ec 01 00 00       	mov    $0x1ec,%esi
   40fdd:	48 8d 05 04 42 00 00 	lea    0x4204(%rip),%rax        # 451e8 <memstate_colors+0x68>
   40fe4:	48 89 c7             	mov    %rax,%rdi
   40fe7:	e8 fa 18 00 00       	call   428e6 <assert_fail>
}
   40fec:	90                   	nop
   40fed:	c9                   	leave  
   40fee:	c3                   	ret    

0000000000040fef <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40fef:	f3 0f 1e fa          	endbr64 
   40ff3:	55                   	push   %rbp
   40ff4:	48 89 e5             	mov    %rsp,%rbp
   40ff7:	48 83 ec 20          	sub    $0x20,%rsp
   40ffb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40fff:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   41002:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41005:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   41008:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   4100f:	48 8b 05 ea 0f 01 00 	mov    0x10fea(%rip),%rax        # 52000 <kernel_pagetable>
   41016:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   4101a:	75 71                	jne    4108d <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   4101c:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41023:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4102a:	eb 5b                	jmp    41087 <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   4102c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4102f:	48 63 d0             	movslq %eax,%rdx
   41032:	48 89 d0             	mov    %rdx,%rax
   41035:	48 c1 e0 04          	shl    $0x4,%rax
   41039:	48 29 d0             	sub    %rdx,%rax
   4103c:	48 c1 e0 04          	shl    $0x4,%rax
   41040:	48 89 c2             	mov    %rax,%rdx
   41043:	48 8d 05 8e e0 00 00 	lea    0xe08e(%rip),%rax        # 4f0d8 <processes+0xd8>
   4104a:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4104d:	85 c0                	test   %eax,%eax
   4104f:	74 32                	je     41083 <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41051:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41054:	48 63 d0             	movslq %eax,%rdx
   41057:	48 89 d0             	mov    %rdx,%rax
   4105a:	48 c1 e0 04          	shl    $0x4,%rax
   4105e:	48 29 d0             	sub    %rdx,%rax
   41061:	48 c1 e0 04          	shl    $0x4,%rax
   41065:	48 89 c2             	mov    %rax,%rdx
   41068:	48 8d 05 71 e0 00 00 	lea    0xe071(%rip),%rax        # 4f0e0 <processes+0xe0>
   4106f:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   41073:	48 8b 05 86 0f 01 00 	mov    0x10f86(%rip),%rax        # 52000 <kernel_pagetable>
   4107a:	48 39 c2             	cmp    %rax,%rdx
   4107d:	75 04                	jne    41083 <check_page_table_ownership+0x94>
                ++expected_refcount;
   4107f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41083:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41087:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   4108b:	7e 9f                	jle    4102c <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   4108d:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41090:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41093:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41097:	be 00 00 00 00       	mov    $0x0,%esi
   4109c:	48 89 c7             	mov    %rax,%rdi
   4109f:	e8 03 00 00 00       	call   410a7 <check_page_table_ownership_level>
}
   410a4:	90                   	nop
   410a5:	c9                   	leave  
   410a6:	c3                   	ret    

00000000000410a7 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   410a7:	f3 0f 1e fa          	endbr64 
   410ab:	55                   	push   %rbp
   410ac:	48 89 e5             	mov    %rsp,%rbp
   410af:	48 83 ec 30          	sub    $0x30,%rsp
   410b3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   410b7:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   410ba:	89 55 e0             	mov    %edx,-0x20(%rbp)
   410bd:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   410c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410c4:	48 c1 e8 0c          	shr    $0xc,%rax
   410c8:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   410cd:	7e 1e                	jle    410ed <check_page_table_ownership_level+0x46>
   410cf:	48 8d 05 0a 43 00 00 	lea    0x430a(%rip),%rax        # 453e0 <memstate_colors+0x260>
   410d6:	48 89 c2             	mov    %rax,%rdx
   410d9:	be 09 02 00 00       	mov    $0x209,%esi
   410de:	48 8d 05 03 41 00 00 	lea    0x4103(%rip),%rax        # 451e8 <memstate_colors+0x68>
   410e5:	48 89 c7             	mov    %rax,%rdi
   410e8:	e8 f9 17 00 00       	call   428e6 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   410ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410f1:	48 c1 e8 0c          	shr    $0xc,%rax
   410f5:	48 98                	cltq   
   410f7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   410fb:	48 8d 05 1e ee 00 00 	lea    0xee1e(%rip),%rax        # 4ff20 <pageinfo>
   41102:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41106:	0f be c0             	movsbl %al,%eax
   41109:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   4110c:	74 1e                	je     4112c <check_page_table_ownership_level+0x85>
   4110e:	48 8d 05 e3 42 00 00 	lea    0x42e3(%rip),%rax        # 453f8 <memstate_colors+0x278>
   41115:	48 89 c2             	mov    %rax,%rdx
   41118:	be 0a 02 00 00       	mov    $0x20a,%esi
   4111d:	48 8d 05 c4 40 00 00 	lea    0x40c4(%rip),%rax        # 451e8 <memstate_colors+0x68>
   41124:	48 89 c7             	mov    %rax,%rdi
   41127:	e8 ba 17 00 00       	call   428e6 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   4112c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41130:	48 c1 e8 0c          	shr    $0xc,%rax
   41134:	48 98                	cltq   
   41136:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4113a:	48 8d 05 e0 ed 00 00 	lea    0xede0(%rip),%rax        # 4ff21 <pageinfo+0x1>
   41141:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41145:	0f be c0             	movsbl %al,%eax
   41148:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   4114b:	74 1e                	je     4116b <check_page_table_ownership_level+0xc4>
   4114d:	48 8d 05 cc 42 00 00 	lea    0x42cc(%rip),%rax        # 45420 <memstate_colors+0x2a0>
   41154:	48 89 c2             	mov    %rax,%rdx
   41157:	be 0b 02 00 00       	mov    $0x20b,%esi
   4115c:	48 8d 05 85 40 00 00 	lea    0x4085(%rip),%rax        # 451e8 <memstate_colors+0x68>
   41163:	48 89 c7             	mov    %rax,%rdi
   41166:	e8 7b 17 00 00       	call   428e6 <assert_fail>
    if (level < 3) {
   4116b:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   4116f:	7f 5b                	jg     411cc <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41171:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41178:	eb 49                	jmp    411c3 <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   4117a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4117e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41181:	48 63 d2             	movslq %edx,%rdx
   41184:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41188:	48 85 c0             	test   %rax,%rax
   4118b:	74 32                	je     411bf <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   4118d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41191:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41194:	48 63 d2             	movslq %edx,%rdx
   41197:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4119b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   411a1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   411a5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   411a8:	8d 70 01             	lea    0x1(%rax),%esi
   411ab:	8b 55 e0             	mov    -0x20(%rbp),%edx
   411ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   411b2:	b9 01 00 00 00       	mov    $0x1,%ecx
   411b7:	48 89 c7             	mov    %rax,%rdi
   411ba:	e8 e8 fe ff ff       	call   410a7 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   411bf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411c3:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   411ca:	7e ae                	jle    4117a <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   411cc:	90                   	nop
   411cd:	c9                   	leave  
   411ce:	c3                   	ret    

00000000000411cf <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   411cf:	f3 0f 1e fa          	endbr64 
   411d3:	55                   	push   %rbp
   411d4:	48 89 e5             	mov    %rsp,%rbp
   411d7:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   411db:	8b 05 f7 de 00 00    	mov    0xdef7(%rip),%eax        # 4f0d8 <processes+0xd8>
   411e1:	85 c0                	test   %eax,%eax
   411e3:	74 1e                	je     41203 <check_virtual_memory+0x34>
   411e5:	48 8d 05 64 42 00 00 	lea    0x4264(%rip),%rax        # 45450 <memstate_colors+0x2d0>
   411ec:	48 89 c2             	mov    %rax,%rdx
   411ef:	be 1e 02 00 00       	mov    $0x21e,%esi
   411f4:	48 8d 05 ed 3f 00 00 	lea    0x3fed(%rip),%rax        # 451e8 <memstate_colors+0x68>
   411fb:	48 89 c7             	mov    %rax,%rdi
   411fe:	e8 e3 16 00 00       	call   428e6 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41203:	48 8b 05 f6 0d 01 00 	mov    0x10df6(%rip),%rax        # 52000 <kernel_pagetable>
   4120a:	48 89 c7             	mov    %rax,%rdi
   4120d:	e8 51 fc ff ff       	call   40e63 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41212:	48 8b 05 e7 0d 01 00 	mov    0x10de7(%rip),%rax        # 52000 <kernel_pagetable>
   41219:	be ff ff ff ff       	mov    $0xffffffff,%esi
   4121e:	48 89 c7             	mov    %rax,%rdi
   41221:	e8 c9 fd ff ff       	call   40fef <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41226:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4122d:	e9 b4 00 00 00       	jmp    412e6 <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   41232:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41235:	48 63 d0             	movslq %eax,%rdx
   41238:	48 89 d0             	mov    %rdx,%rax
   4123b:	48 c1 e0 04          	shl    $0x4,%rax
   4123f:	48 29 d0             	sub    %rdx,%rax
   41242:	48 c1 e0 04          	shl    $0x4,%rax
   41246:	48 89 c2             	mov    %rax,%rdx
   41249:	48 8d 05 88 de 00 00 	lea    0xde88(%rip),%rax        # 4f0d8 <processes+0xd8>
   41250:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41253:	85 c0                	test   %eax,%eax
   41255:	0f 84 87 00 00 00    	je     412e2 <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   4125b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4125e:	48 63 d0             	movslq %eax,%rdx
   41261:	48 89 d0             	mov    %rdx,%rax
   41264:	48 c1 e0 04          	shl    $0x4,%rax
   41268:	48 29 d0             	sub    %rdx,%rax
   4126b:	48 c1 e0 04          	shl    $0x4,%rax
   4126f:	48 89 c2             	mov    %rax,%rdx
   41272:	48 8d 05 67 de 00 00 	lea    0xde67(%rip),%rax        # 4f0e0 <processes+0xe0>
   41279:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   4127d:	48 8b 05 7c 0d 01 00 	mov    0x10d7c(%rip),%rax        # 52000 <kernel_pagetable>
   41284:	48 39 c2             	cmp    %rax,%rdx
   41287:	74 59                	je     412e2 <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   41289:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4128c:	48 63 d0             	movslq %eax,%rdx
   4128f:	48 89 d0             	mov    %rdx,%rax
   41292:	48 c1 e0 04          	shl    $0x4,%rax
   41296:	48 29 d0             	sub    %rdx,%rax
   41299:	48 c1 e0 04          	shl    $0x4,%rax
   4129d:	48 89 c2             	mov    %rax,%rdx
   412a0:	48 8d 05 39 de 00 00 	lea    0xde39(%rip),%rax        # 4f0e0 <processes+0xe0>
   412a7:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   412ab:	48 89 c7             	mov    %rax,%rdi
   412ae:	e8 b0 fb ff ff       	call   40e63 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   412b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412b6:	48 63 d0             	movslq %eax,%rdx
   412b9:	48 89 d0             	mov    %rdx,%rax
   412bc:	48 c1 e0 04          	shl    $0x4,%rax
   412c0:	48 29 d0             	sub    %rdx,%rax
   412c3:	48 c1 e0 04          	shl    $0x4,%rax
   412c7:	48 89 c2             	mov    %rax,%rdx
   412ca:	48 8d 05 0f de 00 00 	lea    0xde0f(%rip),%rax        # 4f0e0 <processes+0xe0>
   412d1:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   412d5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   412d8:	89 d6                	mov    %edx,%esi
   412da:	48 89 c7             	mov    %rax,%rdi
   412dd:	e8 0d fd ff ff       	call   40fef <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   412e2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412e6:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   412ea:	0f 8e 42 ff ff ff    	jle    41232 <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   412f7:	e9 8b 00 00 00       	jmp    41387 <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   412fc:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412ff:	48 98                	cltq   
   41301:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41305:	48 8d 05 15 ec 00 00 	lea    0xec15(%rip),%rax        # 4ff21 <pageinfo+0x1>
   4130c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41310:	84 c0                	test   %al,%al
   41312:	7e 6f                	jle    41383 <check_virtual_memory+0x1b4>
   41314:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41317:	48 98                	cltq   
   41319:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4131d:	48 8d 05 fc eb 00 00 	lea    0xebfc(%rip),%rax        # 4ff20 <pageinfo>
   41324:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41328:	84 c0                	test   %al,%al
   4132a:	78 57                	js     41383 <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4132c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4132f:	48 98                	cltq   
   41331:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41335:	48 8d 05 e4 eb 00 00 	lea    0xebe4(%rip),%rax        # 4ff20 <pageinfo>
   4133c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41340:	0f be c0             	movsbl %al,%eax
   41343:	48 63 d0             	movslq %eax,%rdx
   41346:	48 89 d0             	mov    %rdx,%rax
   41349:	48 c1 e0 04          	shl    $0x4,%rax
   4134d:	48 29 d0             	sub    %rdx,%rax
   41350:	48 c1 e0 04          	shl    $0x4,%rax
   41354:	48 89 c2             	mov    %rax,%rdx
   41357:	48 8d 05 7a dd 00 00 	lea    0xdd7a(%rip),%rax        # 4f0d8 <processes+0xd8>
   4135e:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41361:	85 c0                	test   %eax,%eax
   41363:	75 1e                	jne    41383 <check_virtual_memory+0x1b4>
   41365:	48 8d 05 04 41 00 00 	lea    0x4104(%rip),%rax        # 45470 <memstate_colors+0x2f0>
   4136c:	48 89 c2             	mov    %rax,%rdx
   4136f:	be 35 02 00 00       	mov    $0x235,%esi
   41374:	48 8d 05 6d 3e 00 00 	lea    0x3e6d(%rip),%rax        # 451e8 <memstate_colors+0x68>
   4137b:	48 89 c7             	mov    %rax,%rdi
   4137e:	e8 63 15 00 00       	call   428e6 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41383:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41387:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   4138e:	0f 8e 68 ff ff ff    	jle    412fc <check_virtual_memory+0x12d>
        }
    }
}
   41394:	90                   	nop
   41395:	90                   	nop
   41396:	c9                   	leave  
   41397:	c3                   	ret    

0000000000041398 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41398:	f3 0f 1e fa          	endbr64 
   4139c:	55                   	push   %rbp
   4139d:	48 89 e5             	mov    %rsp,%rbp
   413a0:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   413a4:	48 8d 05 f5 40 00 00 	lea    0x40f5(%rip),%rax        # 454a0 <memstate_colors+0x320>
   413ab:	48 89 c2             	mov    %rax,%rdx
   413ae:	be 00 0f 00 00       	mov    $0xf00,%esi
   413b3:	bf 20 00 00 00       	mov    $0x20,%edi
   413b8:	b8 00 00 00 00       	mov    $0x0,%eax
   413bd:	e8 e9 3b 00 00       	call   44fab <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   413c9:	e9 1b 01 00 00       	jmp    414e9 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   413ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413d1:	83 e0 3f             	and    $0x3f,%eax
   413d4:	85 c0                	test   %eax,%eax
   413d6:	75 40                	jne    41418 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   413d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413db:	c1 e0 0c             	shl    $0xc,%eax
   413de:	89 c2                	mov    %eax,%edx
   413e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413e3:	8d 48 3f             	lea    0x3f(%rax),%ecx
   413e6:	85 c0                	test   %eax,%eax
   413e8:	0f 48 c1             	cmovs  %ecx,%eax
   413eb:	c1 f8 06             	sar    $0x6,%eax
   413ee:	8d 48 01             	lea    0x1(%rax),%ecx
   413f1:	89 c8                	mov    %ecx,%eax
   413f3:	c1 e0 02             	shl    $0x2,%eax
   413f6:	01 c8                	add    %ecx,%eax
   413f8:	c1 e0 04             	shl    $0x4,%eax
   413fb:	83 c0 03             	add    $0x3,%eax
   413fe:	89 d1                	mov    %edx,%ecx
   41400:	48 8d 15 a9 40 00 00 	lea    0x40a9(%rip),%rdx        # 454b0 <memstate_colors+0x330>
   41407:	be 00 0f 00 00       	mov    $0xf00,%esi
   4140c:	89 c7                	mov    %eax,%edi
   4140e:	b8 00 00 00 00       	mov    $0x0,%eax
   41413:	e8 93 3b 00 00       	call   44fab <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41418:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4141b:	48 98                	cltq   
   4141d:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41421:	48 8d 05 f8 ea 00 00 	lea    0xeaf8(%rip),%rax        # 4ff20 <pageinfo>
   41428:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4142c:	0f be c0             	movsbl %al,%eax
   4142f:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41432:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41435:	48 98                	cltq   
   41437:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4143b:	48 8d 05 df ea 00 00 	lea    0xeadf(%rip),%rax        # 4ff21 <pageinfo+0x1>
   41442:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41446:	84 c0                	test   %al,%al
   41448:	75 07                	jne    41451 <memshow_physical+0xb9>
            owner = PO_FREE;
   4144a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41451:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41454:	83 c0 02             	add    $0x2,%eax
   41457:	48 98                	cltq   
   41459:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4145d:	48 8d 05 1c 3d 00 00 	lea    0x3d1c(%rip),%rax        # 45180 <memstate_colors>
   41464:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41468:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   4146c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4146f:	48 98                	cltq   
   41471:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41475:	48 8d 05 a5 ea 00 00 	lea    0xeaa5(%rip),%rax        # 4ff21 <pageinfo+0x1>
   4147c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41480:	3c 01                	cmp    $0x1,%al
   41482:	7e 1c                	jle    414a0 <memshow_physical+0x108>
   41484:	48 8d 05 75 6b 07 00 	lea    0x76b75(%rip),%rax        # b8000 <console>
   4148b:	48 c1 e8 0c          	shr    $0xc,%rax
   4148f:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41492:	74 0c                	je     414a0 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41494:	b8 53 00 00 00       	mov    $0x53,%eax
   41499:	80 cc 0f             	or     $0xf,%ah
   4149c:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   414a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414a3:	8d 50 3f             	lea    0x3f(%rax),%edx
   414a6:	85 c0                	test   %eax,%eax
   414a8:	0f 48 c2             	cmovs  %edx,%eax
   414ab:	c1 f8 06             	sar    $0x6,%eax
   414ae:	8d 50 01             	lea    0x1(%rax),%edx
   414b1:	89 d0                	mov    %edx,%eax
   414b3:	c1 e0 02             	shl    $0x2,%eax
   414b6:	01 d0                	add    %edx,%eax
   414b8:	c1 e0 04             	shl    $0x4,%eax
   414bb:	89 c1                	mov    %eax,%ecx
   414bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414c0:	99                   	cltd   
   414c1:	c1 ea 1a             	shr    $0x1a,%edx
   414c4:	01 d0                	add    %edx,%eax
   414c6:	83 e0 3f             	and    $0x3f,%eax
   414c9:	29 d0                	sub    %edx,%eax
   414cb:	83 c0 0c             	add    $0xc,%eax
   414ce:	01 c8                	add    %ecx,%eax
   414d0:	48 98                	cltq   
   414d2:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   414d6:	48 8d 15 23 6b 07 00 	lea    0x76b23(%rip),%rdx        # b8000 <console>
   414dd:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414e1:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   414e5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   414e9:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   414f0:	0f 8e d8 fe ff ff    	jle    413ce <memshow_physical+0x36>
    }
}
   414f6:	90                   	nop
   414f7:	90                   	nop
   414f8:	c9                   	leave  
   414f9:	c3                   	ret    

00000000000414fa <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   414fa:	f3 0f 1e fa          	endbr64 
   414fe:	55                   	push   %rbp
   414ff:	48 89 e5             	mov    %rsp,%rbp
   41502:	48 83 ec 40          	sub    $0x40,%rsp
   41506:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4150a:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   4150e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41512:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41518:	48 89 c2             	mov    %rax,%rdx
   4151b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4151f:	48 39 c2             	cmp    %rax,%rdx
   41522:	74 1e                	je     41542 <memshow_virtual+0x48>
   41524:	48 8d 05 8d 3f 00 00 	lea    0x3f8d(%rip),%rax        # 454b8 <memstate_colors+0x338>
   4152b:	48 89 c2             	mov    %rax,%rdx
   4152e:	be 66 02 00 00       	mov    $0x266,%esi
   41533:	48 8d 05 ae 3c 00 00 	lea    0x3cae(%rip),%rax        # 451e8 <memstate_colors+0x68>
   4153a:	48 89 c7             	mov    %rax,%rdi
   4153d:	e8 a4 13 00 00       	call   428e6 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41542:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41546:	48 89 c1             	mov    %rax,%rcx
   41549:	48 8d 05 95 3f 00 00 	lea    0x3f95(%rip),%rax        # 454e5 <memstate_colors+0x365>
   41550:	48 89 c2             	mov    %rax,%rdx
   41553:	be 00 0f 00 00       	mov    $0xf00,%esi
   41558:	bf 3a 03 00 00       	mov    $0x33a,%edi
   4155d:	b8 00 00 00 00       	mov    $0x0,%eax
   41562:	e8 44 3a 00 00       	call   44fab <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41567:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4156e:	00 
   4156f:	e9 b4 01 00 00       	jmp    41728 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41574:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41578:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4157c:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41580:	48 89 ce             	mov    %rcx,%rsi
   41583:	48 89 c7             	mov    %rax,%rdi
   41586:	e8 2b 1b 00 00       	call   430b6 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   4158b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4158e:	85 c0                	test   %eax,%eax
   41590:	79 0b                	jns    4159d <memshow_virtual+0xa3>
            color = ' ';
   41592:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41598:	e9 ff 00 00 00       	jmp    4169c <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   4159d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   415a1:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   415a7:	76 1e                	jbe    415c7 <memshow_virtual+0xcd>
   415a9:	48 8d 05 52 3f 00 00 	lea    0x3f52(%rip),%rax        # 45502 <memstate_colors+0x382>
   415b0:	48 89 c2             	mov    %rax,%rdx
   415b3:	be 6f 02 00 00       	mov    $0x26f,%esi
   415b8:	48 8d 05 29 3c 00 00 	lea    0x3c29(%rip),%rax        # 451e8 <memstate_colors+0x68>
   415bf:	48 89 c7             	mov    %rax,%rdi
   415c2:	e8 1f 13 00 00       	call   428e6 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   415c7:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415ca:	48 98                	cltq   
   415cc:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   415d0:	48 8d 05 49 e9 00 00 	lea    0xe949(%rip),%rax        # 4ff20 <pageinfo>
   415d7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   415db:	0f be c0             	movsbl %al,%eax
   415de:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   415e1:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415e4:	48 98                	cltq   
   415e6:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   415ea:	48 8d 05 30 e9 00 00 	lea    0xe930(%rip),%rax        # 4ff21 <pageinfo+0x1>
   415f1:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   415f5:	84 c0                	test   %al,%al
   415f7:	75 07                	jne    41600 <memshow_virtual+0x106>
                owner = PO_FREE;
   415f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41600:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41603:	83 c0 02             	add    $0x2,%eax
   41606:	48 98                	cltq   
   41608:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4160c:	48 8d 05 6d 3b 00 00 	lea    0x3b6d(%rip),%rax        # 45180 <memstate_colors>
   41613:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41617:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   4161b:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4161e:	48 98                	cltq   
   41620:	83 e0 04             	and    $0x4,%eax
   41623:	48 85 c0             	test   %rax,%rax
   41626:	74 27                	je     4164f <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41628:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4162c:	c1 e0 04             	shl    $0x4,%eax
   4162f:	66 25 00 f0          	and    $0xf000,%ax
   41633:	89 c2                	mov    %eax,%edx
   41635:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41639:	c1 f8 04             	sar    $0x4,%eax
   4163c:	66 25 00 0f          	and    $0xf00,%ax
   41640:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41642:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41646:	0f b6 c0             	movzbl %al,%eax
   41649:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4164b:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   4164f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41652:	48 98                	cltq   
   41654:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41658:	48 8d 05 c2 e8 00 00 	lea    0xe8c2(%rip),%rax        # 4ff21 <pageinfo+0x1>
   4165f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41663:	3c 01                	cmp    $0x1,%al
   41665:	7e 35                	jle    4169c <memshow_virtual+0x1a2>
   41667:	48 8d 05 92 69 07 00 	lea    0x76992(%rip),%rax        # b8000 <console>
   4166e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41672:	74 28                	je     4169c <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41674:	b8 53 00 00 00       	mov    $0x53,%eax
   41679:	89 c2                	mov    %eax,%edx
   4167b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4167f:	66 25 00 f0          	and    $0xf000,%ax
   41683:	09 d0                	or     %edx,%eax
   41685:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41689:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4168c:	48 98                	cltq   
   4168e:	83 e0 04             	and    $0x4,%eax
   41691:	48 85 c0             	test   %rax,%rax
   41694:	75 06                	jne    4169c <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   41696:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4169c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416a0:	48 c1 e8 0c          	shr    $0xc,%rax
   416a4:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   416a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416aa:	83 e0 3f             	and    $0x3f,%eax
   416ad:	85 c0                	test   %eax,%eax
   416af:	75 39                	jne    416ea <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   416b1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416b4:	c1 e8 06             	shr    $0x6,%eax
   416b7:	89 c2                	mov    %eax,%edx
   416b9:	89 d0                	mov    %edx,%eax
   416bb:	c1 e0 02             	shl    $0x2,%eax
   416be:	01 d0                	add    %edx,%eax
   416c0:	c1 e0 04             	shl    $0x4,%eax
   416c3:	05 73 03 00 00       	add    $0x373,%eax
   416c8:	89 c7                	mov    %eax,%edi
   416ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416ce:	48 89 c1             	mov    %rax,%rcx
   416d1:	48 8d 05 d8 3d 00 00 	lea    0x3dd8(%rip),%rax        # 454b0 <memstate_colors+0x330>
   416d8:	48 89 c2             	mov    %rax,%rdx
   416db:	be 00 0f 00 00       	mov    $0xf00,%esi
   416e0:	b8 00 00 00 00       	mov    $0x0,%eax
   416e5:	e8 c1 38 00 00       	call   44fab <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   416ea:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416ed:	c1 e8 06             	shr    $0x6,%eax
   416f0:	89 c2                	mov    %eax,%edx
   416f2:	89 d0                	mov    %edx,%eax
   416f4:	c1 e0 02             	shl    $0x2,%eax
   416f7:	01 d0                	add    %edx,%eax
   416f9:	c1 e0 04             	shl    $0x4,%eax
   416fc:	89 c2                	mov    %eax,%edx
   416fe:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41701:	83 e0 3f             	and    $0x3f,%eax
   41704:	01 d0                	add    %edx,%eax
   41706:	05 7c 03 00 00       	add    $0x37c,%eax
   4170b:	89 c0                	mov    %eax,%eax
   4170d:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41711:	48 8d 15 e8 68 07 00 	lea    0x768e8(%rip),%rdx        # b8000 <console>
   41718:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4171c:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41720:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41727:	00 
   41728:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4172f:	00 
   41730:	0f 86 3e fe ff ff    	jbe    41574 <memshow_virtual+0x7a>
    }
}
   41736:	90                   	nop
   41737:	90                   	nop
   41738:	c9                   	leave  
   41739:	c3                   	ret    

000000000004173a <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   4173a:	f3 0f 1e fa          	endbr64 
   4173e:	55                   	push   %rbp
   4173f:	48 89 e5             	mov    %rsp,%rbp
   41742:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41746:	8b 05 d8 eb 00 00    	mov    0xebd8(%rip),%eax        # 50324 <last_ticks.1>
   4174c:	85 c0                	test   %eax,%eax
   4174e:	74 13                	je     41763 <memshow_virtual_animate+0x29>
   41750:	8b 05 ca eb 00 00    	mov    0xebca(%rip),%eax        # 50320 <ticks>
   41756:	8b 15 c8 eb 00 00    	mov    0xebc8(%rip),%edx        # 50324 <last_ticks.1>
   4175c:	29 d0                	sub    %edx,%eax
   4175e:	83 f8 31             	cmp    $0x31,%eax
   41761:	76 2c                	jbe    4178f <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   41763:	8b 05 b7 eb 00 00    	mov    0xebb7(%rip),%eax        # 50320 <ticks>
   41769:	89 05 b5 eb 00 00    	mov    %eax,0xebb5(%rip)        # 50324 <last_ticks.1>
        ++showing;
   4176f:	8b 05 8f 48 00 00    	mov    0x488f(%rip),%eax        # 46004 <showing.0>
   41775:	83 c0 01             	add    $0x1,%eax
   41778:	89 05 86 48 00 00    	mov    %eax,0x4886(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4177e:	eb 0f                	jmp    4178f <memshow_virtual_animate+0x55>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   41780:	8b 05 7e 48 00 00    	mov    0x487e(%rip),%eax        # 46004 <showing.0>
   41786:	83 c0 01             	add    $0x1,%eax
   41789:	89 05 75 48 00 00    	mov    %eax,0x4875(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   4178f:	8b 05 6f 48 00 00    	mov    0x486f(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41795:	83 f8 20             	cmp    $0x20,%eax
   41798:	7f 33                	jg     417cd <memshow_virtual_animate+0x93>
   4179a:	8b 05 64 48 00 00    	mov    0x4864(%rip),%eax        # 46004 <showing.0>
   417a0:	99                   	cltd   
   417a1:	c1 ea 1c             	shr    $0x1c,%edx
   417a4:	01 d0                	add    %edx,%eax
   417a6:	83 e0 0f             	and    $0xf,%eax
   417a9:	29 d0                	sub    %edx,%eax
   417ab:	48 63 d0             	movslq %eax,%rdx
   417ae:	48 89 d0             	mov    %rdx,%rax
   417b1:	48 c1 e0 04          	shl    $0x4,%rax
   417b5:	48 29 d0             	sub    %rdx,%rax
   417b8:	48 c1 e0 04          	shl    $0x4,%rax
   417bc:	48 89 c2             	mov    %rax,%rdx
   417bf:	48 8d 05 12 d9 00 00 	lea    0xd912(%rip),%rax        # 4f0d8 <processes+0xd8>
   417c6:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   417c9:	85 c0                	test   %eax,%eax
   417cb:	74 b3                	je     41780 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   417cd:	8b 05 31 48 00 00    	mov    0x4831(%rip),%eax        # 46004 <showing.0>
   417d3:	99                   	cltd   
   417d4:	c1 ea 1c             	shr    $0x1c,%edx
   417d7:	01 d0                	add    %edx,%eax
   417d9:	83 e0 0f             	and    $0xf,%eax
   417dc:	29 d0                	sub    %edx,%eax
   417de:	89 05 20 48 00 00    	mov    %eax,0x4820(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   417e4:	8b 05 1a 48 00 00    	mov    0x481a(%rip),%eax        # 46004 <showing.0>
   417ea:	48 63 d0             	movslq %eax,%rdx
   417ed:	48 89 d0             	mov    %rdx,%rax
   417f0:	48 c1 e0 04          	shl    $0x4,%rax
   417f4:	48 29 d0             	sub    %rdx,%rax
   417f7:	48 c1 e0 04          	shl    $0x4,%rax
   417fb:	48 89 c2             	mov    %rax,%rdx
   417fe:	48 8d 05 d3 d8 00 00 	lea    0xd8d3(%rip),%rax        # 4f0d8 <processes+0xd8>
   41805:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41808:	85 c0                	test   %eax,%eax
   4180a:	0f 84 82 00 00 00    	je     41892 <memshow_virtual_animate+0x158>
   41810:	8b 05 ee 47 00 00    	mov    0x47ee(%rip),%eax        # 46004 <showing.0>
   41816:	48 63 d0             	movslq %eax,%rdx
   41819:	48 89 d0             	mov    %rdx,%rax
   4181c:	48 c1 e0 04          	shl    $0x4,%rax
   41820:	48 29 d0             	sub    %rdx,%rax
   41823:	48 c1 e0 04          	shl    $0x4,%rax
   41827:	48 89 c2             	mov    %rax,%rdx
   4182a:	48 8d 05 b7 d8 00 00 	lea    0xd8b7(%rip),%rax        # 4f0e8 <processes+0xe8>
   41831:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41835:	84 c0                	test   %al,%al
   41837:	74 59                	je     41892 <memshow_virtual_animate+0x158>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41839:	8b 15 c5 47 00 00    	mov    0x47c5(%rip),%edx        # 46004 <showing.0>
   4183f:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41843:	89 d1                	mov    %edx,%ecx
   41845:	48 8d 15 d0 3c 00 00 	lea    0x3cd0(%rip),%rdx        # 4551c <memstate_colors+0x39c>
   4184c:	be 04 00 00 00       	mov    $0x4,%esi
   41851:	48 89 c7             	mov    %rax,%rdi
   41854:	b8 00 00 00 00       	mov    $0x0,%eax
   41859:	e8 68 38 00 00       	call   450c6 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   4185e:	8b 05 a0 47 00 00    	mov    0x47a0(%rip),%eax        # 46004 <showing.0>
   41864:	48 63 d0             	movslq %eax,%rdx
   41867:	48 89 d0             	mov    %rdx,%rax
   4186a:	48 c1 e0 04          	shl    $0x4,%rax
   4186e:	48 29 d0             	sub    %rdx,%rax
   41871:	48 c1 e0 04          	shl    $0x4,%rax
   41875:	48 89 c2             	mov    %rax,%rdx
   41878:	48 8d 05 61 d8 00 00 	lea    0xd861(%rip),%rax        # 4f0e0 <processes+0xe0>
   4187f:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41883:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41887:	48 89 d6             	mov    %rdx,%rsi
   4188a:	48 89 c7             	mov    %rax,%rdi
   4188d:	e8 68 fc ff ff       	call   414fa <memshow_virtual>
    }
}
   41892:	90                   	nop
   41893:	c9                   	leave  
   41894:	c3                   	ret    

0000000000041895 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41895:	f3 0f 1e fa          	endbr64 
   41899:	55                   	push   %rbp
   4189a:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   4189d:	e8 5f 01 00 00       	call   41a01 <segments_init>
    interrupt_init();
   418a2:	e8 44 04 00 00       	call   41ceb <interrupt_init>
    virtual_memory_init();
   418a7:	e8 11 11 00 00       	call   429bd <virtual_memory_init>
}
   418ac:	90                   	nop
   418ad:	5d                   	pop    %rbp
   418ae:	c3                   	ret    

00000000000418af <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   418af:	f3 0f 1e fa          	endbr64 
   418b3:	55                   	push   %rbp
   418b4:	48 89 e5             	mov    %rsp,%rbp
   418b7:	48 83 ec 18          	sub    $0x18,%rsp
   418bb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418bf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   418c3:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   418c6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   418c9:	48 98                	cltq   
   418cb:	48 c1 e0 2d          	shl    $0x2d,%rax
   418cf:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   418d3:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   418da:	90 00 00 
   418dd:	48 09 c2             	or     %rax,%rdx
    *segment = type
   418e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418e4:	48 89 10             	mov    %rdx,(%rax)
}
   418e7:	90                   	nop
   418e8:	c9                   	leave  
   418e9:	c3                   	ret    

00000000000418ea <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   418ea:	f3 0f 1e fa          	endbr64 
   418ee:	55                   	push   %rbp
   418ef:	48 89 e5             	mov    %rsp,%rbp
   418f2:	48 83 ec 28          	sub    $0x28,%rsp
   418f6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418fa:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   418fe:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41901:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41905:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41909:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4190d:	48 c1 e0 10          	shl    $0x10,%rax
   41911:	48 89 c2             	mov    %rax,%rdx
   41914:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   4191b:	00 00 00 
   4191e:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41921:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41925:	48 c1 e0 20          	shl    $0x20,%rax
   41929:	48 89 c1             	mov    %rax,%rcx
   4192c:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41933:	00 00 ff 
   41936:	48 21 c8             	and    %rcx,%rax
   41939:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   4193c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41940:	48 83 e8 01          	sub    $0x1,%rax
   41944:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41947:	48 09 d0             	or     %rdx,%rax
        | type
   4194a:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   4194e:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41951:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41954:	48 98                	cltq   
   41956:	48 c1 e0 2d          	shl    $0x2d,%rax
   4195a:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   4195d:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41964:	80 00 00 
   41967:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   4196a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4196e:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41971:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41975:	48 83 c0 08          	add    $0x8,%rax
   41979:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4197d:	48 c1 ea 20          	shr    $0x20,%rdx
   41981:	48 89 10             	mov    %rdx,(%rax)
}
   41984:	90                   	nop
   41985:	c9                   	leave  
   41986:	c3                   	ret    

0000000000041987 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41987:	f3 0f 1e fa          	endbr64 
   4198b:	55                   	push   %rbp
   4198c:	48 89 e5             	mov    %rsp,%rbp
   4198f:	48 83 ec 20          	sub    $0x20,%rsp
   41993:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41997:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4199b:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4199e:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   419a2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419a6:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   419a9:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   419ad:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   419b0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   419b3:	48 98                	cltq   
   419b5:	48 c1 e0 2d          	shl    $0x2d,%rax
   419b9:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   419bc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419c0:	48 c1 e0 20          	shl    $0x20,%rax
   419c4:	48 89 c1             	mov    %rax,%rcx
   419c7:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   419ce:	00 ff ff 
   419d1:	48 21 c8             	and    %rcx,%rax
   419d4:	48 09 c2             	or     %rax,%rdx
   419d7:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   419de:	80 00 00 
   419e1:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   419e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419e8:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   419eb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419ef:	48 c1 e8 20          	shr    $0x20,%rax
   419f3:	48 89 c2             	mov    %rax,%rdx
   419f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419fa:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   419fe:	90                   	nop
   419ff:	c9                   	leave  
   41a00:	c3                   	ret    

0000000000041a01 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41a01:	f3 0f 1e fa          	endbr64 
   41a05:	55                   	push   %rbp
   41a06:	48 89 e5             	mov    %rsp,%rbp
   41a09:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41a0d:	48 c7 05 28 e9 00 00 	movq   $0x0,0xe928(%rip)        # 50340 <segments>
   41a14:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41a18:	ba 00 00 00 00       	mov    $0x0,%edx
   41a1d:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41a24:	08 20 00 
   41a27:	48 89 c6             	mov    %rax,%rsi
   41a2a:	48 8d 05 17 e9 00 00 	lea    0xe917(%rip),%rax        # 50348 <segments+0x8>
   41a31:	48 89 c7             	mov    %rax,%rdi
   41a34:	e8 76 fe ff ff       	call   418af <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41a39:	ba 03 00 00 00       	mov    $0x3,%edx
   41a3e:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41a45:	08 20 00 
   41a48:	48 89 c6             	mov    %rax,%rsi
   41a4b:	48 8d 05 fe e8 00 00 	lea    0xe8fe(%rip),%rax        # 50350 <segments+0x10>
   41a52:	48 89 c7             	mov    %rax,%rdi
   41a55:	e8 55 fe ff ff       	call   418af <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41a5a:	ba 00 00 00 00       	mov    $0x0,%edx
   41a5f:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41a66:	02 00 00 
   41a69:	48 89 c6             	mov    %rax,%rsi
   41a6c:	48 8d 05 e5 e8 00 00 	lea    0xe8e5(%rip),%rax        # 50358 <segments+0x18>
   41a73:	48 89 c7             	mov    %rax,%rdi
   41a76:	e8 34 fe ff ff       	call   418af <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41a7b:	ba 03 00 00 00       	mov    $0x3,%edx
   41a80:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41a87:	02 00 00 
   41a8a:	48 89 c6             	mov    %rax,%rsi
   41a8d:	48 8d 05 cc e8 00 00 	lea    0xe8cc(%rip),%rax        # 50360 <segments+0x20>
   41a94:	48 89 c7             	mov    %rax,%rdi
   41a97:	e8 13 fe ff ff       	call   418af <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41a9c:	48 8d 05 dd f8 00 00 	lea    0xf8dd(%rip),%rax        # 51380 <kernel_task_descriptor>
   41aa3:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41aa9:	48 89 c1             	mov    %rax,%rcx
   41aac:	ba 00 00 00 00       	mov    $0x0,%edx
   41ab1:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41ab8:	09 00 00 
   41abb:	48 89 c6             	mov    %rax,%rsi
   41abe:	48 8d 05 a3 e8 00 00 	lea    0xe8a3(%rip),%rax        # 50368 <segments+0x28>
   41ac5:	48 89 c7             	mov    %rax,%rdi
   41ac8:	e8 1d fe ff ff       	call   418ea <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41acd:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41ad3:	48 8d 05 66 e8 00 00 	lea    0xe866(%rip),%rax        # 50340 <segments>
   41ada:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41ade:	ba 60 00 00 00       	mov    $0x60,%edx
   41ae3:	be 00 00 00 00       	mov    $0x0,%esi
   41ae8:	48 8d 05 91 f8 00 00 	lea    0xf891(%rip),%rax        # 51380 <kernel_task_descriptor>
   41aef:	48 89 c7             	mov    %rax,%rdi
   41af2:	e8 75 26 00 00       	call   4416c <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41af7:	48 c7 05 82 f8 00 00 	movq   $0x80000,0xf882(%rip)        # 51384 <kernel_task_descriptor+0x4>
   41afe:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41b02:	ba 00 10 00 00       	mov    $0x1000,%edx
   41b07:	be 00 00 00 00       	mov    $0x0,%esi
   41b0c:	48 8d 05 6d e8 00 00 	lea    0xe86d(%rip),%rax        # 50380 <interrupt_descriptors>
   41b13:	48 89 c7             	mov    %rax,%rdi
   41b16:	e8 51 26 00 00       	call   4416c <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41b1b:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41b22:	eb 3c                	jmp    41b60 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41b24:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   41b2b:	48 89 c2             	mov    %rax,%rdx
   41b2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41b31:	48 c1 e0 04          	shl    $0x4,%rax
   41b35:	48 89 c1             	mov    %rax,%rcx
   41b38:	48 8d 05 41 e8 00 00 	lea    0xe841(%rip),%rax        # 50380 <interrupt_descriptors>
   41b3f:	48 01 c8             	add    %rcx,%rax
   41b42:	48 89 d1             	mov    %rdx,%rcx
   41b45:	ba 00 00 00 00       	mov    $0x0,%edx
   41b4a:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41b51:	0e 00 00 
   41b54:	48 89 c7             	mov    %rax,%rdi
   41b57:	e8 2b fe ff ff       	call   41987 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41b5c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41b60:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41b67:	76 bb                	jbe    41b24 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41b69:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   41b70:	48 89 c1             	mov    %rax,%rcx
   41b73:	ba 00 00 00 00       	mov    $0x0,%edx
   41b78:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41b7f:	0e 00 00 
   41b82:	48 89 c6             	mov    %rax,%rsi
   41b85:	48 8d 05 f4 e9 00 00 	lea    0xe9f4(%rip),%rax        # 50580 <interrupt_descriptors+0x200>
   41b8c:	48 89 c7             	mov    %rax,%rdi
   41b8f:	e8 f3 fd ff ff       	call   41987 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41b94:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   41b9b:	48 89 c1             	mov    %rax,%rcx
   41b9e:	ba 00 00 00 00       	mov    $0x0,%edx
   41ba3:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41baa:	0e 00 00 
   41bad:	48 89 c6             	mov    %rax,%rsi
   41bb0:	48 8d 05 99 e8 00 00 	lea    0xe899(%rip),%rax        # 50450 <interrupt_descriptors+0xd0>
   41bb7:	48 89 c7             	mov    %rax,%rdi
   41bba:	e8 c8 fd ff ff       	call   41987 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41bbf:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   41bc6:	48 89 c1             	mov    %rax,%rcx
   41bc9:	ba 00 00 00 00       	mov    $0x0,%edx
   41bce:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41bd5:	0e 00 00 
   41bd8:	48 89 c6             	mov    %rax,%rsi
   41bdb:	48 8d 05 7e e8 00 00 	lea    0xe87e(%rip),%rax        # 50460 <interrupt_descriptors+0xe0>
   41be2:	48 89 c7             	mov    %rax,%rdi
   41be5:	e8 9d fd ff ff       	call   41987 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41bea:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41bf1:	eb 50                	jmp    41c43 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41bf3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41bf6:	83 e8 30             	sub    $0x30,%eax
   41bf9:	89 c0                	mov    %eax,%eax
   41bfb:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   41c02:	00 
   41c03:	48 8d 05 dd e4 ff ff 	lea    -0x1b23(%rip),%rax        # 400e7 <sys_int_handlers>
   41c0a:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41c0e:	48 89 c2             	mov    %rax,%rdx
   41c11:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c14:	48 c1 e0 04          	shl    $0x4,%rax
   41c18:	48 89 c1             	mov    %rax,%rcx
   41c1b:	48 8d 05 5e e7 00 00 	lea    0xe75e(%rip),%rax        # 50380 <interrupt_descriptors>
   41c22:	48 01 c8             	add    %rcx,%rax
   41c25:	48 89 d1             	mov    %rdx,%rcx
   41c28:	ba 03 00 00 00       	mov    $0x3,%edx
   41c2d:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41c34:	0e 00 00 
   41c37:	48 89 c7             	mov    %rax,%rdi
   41c3a:	e8 48 fd ff ff       	call   41987 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41c3f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41c43:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41c47:	76 aa                	jbe    41bf3 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41c49:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41c4f:	48 8d 05 2a e7 00 00 	lea    0xe72a(%rip),%rax        # 50380 <interrupt_descriptors>
   41c56:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41c5a:	b8 28 00 00 00       	mov    $0x28,%eax
   41c5f:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41c63:	0f 00 d8             	ltr    %ax
   41c66:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41c6a:	0f 20 c0             	mov    %cr0,%rax
   41c6d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41c71:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41c75:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41c78:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41c7f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c82:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41c85:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c88:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41c8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41c90:	0f 22 c0             	mov    %rax,%cr0
}
   41c93:	90                   	nop
    lcr0(cr0);
}
   41c94:	90                   	nop
   41c95:	c9                   	leave  
   41c96:	c3                   	ret    

0000000000041c97 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41c97:	f3 0f 1e fa          	endbr64 
   41c9b:	55                   	push   %rbp
   41c9c:	48 89 e5             	mov    %rsp,%rbp
   41c9f:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41ca3:	0f b7 05 36 f7 00 00 	movzwl 0xf736(%rip),%eax        # 513e0 <interrupts_enabled>
   41caa:	f7 d0                	not    %eax
   41cac:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41cb0:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41cb4:	0f b6 c0             	movzbl %al,%eax
   41cb7:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41cbe:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cc1:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41cc5:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41cc8:	ee                   	out    %al,(%dx)
}
   41cc9:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41cca:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41cce:	66 c1 e8 08          	shr    $0x8,%ax
   41cd2:	0f b6 c0             	movzbl %al,%eax
   41cd5:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41cdc:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cdf:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41ce3:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41ce6:	ee                   	out    %al,(%dx)
}
   41ce7:	90                   	nop
}
   41ce8:	90                   	nop
   41ce9:	c9                   	leave  
   41cea:	c3                   	ret    

0000000000041ceb <interrupt_init>:

void interrupt_init(void) {
   41ceb:	f3 0f 1e fa          	endbr64 
   41cef:	55                   	push   %rbp
   41cf0:	48 89 e5             	mov    %rsp,%rbp
   41cf3:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41cf7:	66 c7 05 e0 f6 00 00 	movw   $0x0,0xf6e0(%rip)        # 513e0 <interrupts_enabled>
   41cfe:	00 00 
    interrupt_mask();
   41d00:	e8 92 ff ff ff       	call   41c97 <interrupt_mask>
   41d05:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41d0c:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d10:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41d14:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41d17:	ee                   	out    %al,(%dx)
}
   41d18:	90                   	nop
   41d19:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41d20:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d24:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41d28:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41d2b:	ee                   	out    %al,(%dx)
}
   41d2c:	90                   	nop
   41d2d:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41d34:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d38:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41d3c:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41d3f:	ee                   	out    %al,(%dx)
}
   41d40:	90                   	nop
   41d41:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41d48:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d4c:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41d50:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41d53:	ee                   	out    %al,(%dx)
}
   41d54:	90                   	nop
   41d55:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41d5c:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d60:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41d64:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41d67:	ee                   	out    %al,(%dx)
}
   41d68:	90                   	nop
   41d69:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41d70:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d74:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41d78:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41d7b:	ee                   	out    %al,(%dx)
}
   41d7c:	90                   	nop
   41d7d:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41d84:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d88:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41d8c:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41d8f:	ee                   	out    %al,(%dx)
}
   41d90:	90                   	nop
   41d91:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41d98:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d9c:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41da0:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41da3:	ee                   	out    %al,(%dx)
}
   41da4:	90                   	nop
   41da5:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41dac:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41db0:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41db4:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41db7:	ee                   	out    %al,(%dx)
}
   41db8:	90                   	nop
   41db9:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41dc0:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dc4:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41dc8:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41dcb:	ee                   	out    %al,(%dx)
}
   41dcc:	90                   	nop
   41dcd:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41dd4:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dd8:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ddc:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ddf:	ee                   	out    %al,(%dx)
}
   41de0:	90                   	nop
   41de1:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41de8:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dec:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41df0:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41df3:	ee                   	out    %al,(%dx)
}
   41df4:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41df5:	e8 9d fe ff ff       	call   41c97 <interrupt_mask>
}
   41dfa:	90                   	nop
   41dfb:	c9                   	leave  
   41dfc:	c3                   	ret    

0000000000041dfd <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41dfd:	f3 0f 1e fa          	endbr64 
   41e01:	55                   	push   %rbp
   41e02:	48 89 e5             	mov    %rsp,%rbp
   41e05:	48 83 ec 28          	sub    $0x28,%rsp
   41e09:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41e0c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41e10:	0f 8e 9f 00 00 00    	jle    41eb5 <timer_init+0xb8>
   41e16:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41e1d:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e21:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41e25:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e28:	ee                   	out    %al,(%dx)
}
   41e29:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41e2a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e2d:	89 c2                	mov    %eax,%edx
   41e2f:	c1 ea 1f             	shr    $0x1f,%edx
   41e32:	01 d0                	add    %edx,%eax
   41e34:	d1 f8                	sar    %eax
   41e36:	05 de 34 12 00       	add    $0x1234de,%eax
   41e3b:	99                   	cltd   
   41e3c:	f7 7d dc             	idivl  -0x24(%rbp)
   41e3f:	89 c2                	mov    %eax,%edx
   41e41:	89 d0                	mov    %edx,%eax
   41e43:	c1 f8 1f             	sar    $0x1f,%eax
   41e46:	c1 e8 18             	shr    $0x18,%eax
   41e49:	89 c1                	mov    %eax,%ecx
   41e4b:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41e4e:	0f b6 c0             	movzbl %al,%eax
   41e51:	29 c8                	sub    %ecx,%eax
   41e53:	0f b6 c0             	movzbl %al,%eax
   41e56:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41e5d:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e60:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41e64:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e67:	ee                   	out    %al,(%dx)
}
   41e68:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41e69:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e6c:	89 c2                	mov    %eax,%edx
   41e6e:	c1 ea 1f             	shr    $0x1f,%edx
   41e71:	01 d0                	add    %edx,%eax
   41e73:	d1 f8                	sar    %eax
   41e75:	05 de 34 12 00       	add    $0x1234de,%eax
   41e7a:	99                   	cltd   
   41e7b:	f7 7d dc             	idivl  -0x24(%rbp)
   41e7e:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41e84:	85 c0                	test   %eax,%eax
   41e86:	0f 48 c2             	cmovs  %edx,%eax
   41e89:	c1 f8 08             	sar    $0x8,%eax
   41e8c:	0f b6 c0             	movzbl %al,%eax
   41e8f:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41e96:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e99:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e9d:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ea0:	ee                   	out    %al,(%dx)
}
   41ea1:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41ea2:	0f b7 05 37 f5 00 00 	movzwl 0xf537(%rip),%eax        # 513e0 <interrupts_enabled>
   41ea9:	83 c8 01             	or     $0x1,%eax
   41eac:	66 89 05 2d f5 00 00 	mov    %ax,0xf52d(%rip)        # 513e0 <interrupts_enabled>
   41eb3:	eb 11                	jmp    41ec6 <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41eb5:	0f b7 05 24 f5 00 00 	movzwl 0xf524(%rip),%eax        # 513e0 <interrupts_enabled>
   41ebc:	83 e0 fe             	and    $0xfffffffe,%eax
   41ebf:	66 89 05 1a f5 00 00 	mov    %ax,0xf51a(%rip)        # 513e0 <interrupts_enabled>
    }
    interrupt_mask();
   41ec6:	e8 cc fd ff ff       	call   41c97 <interrupt_mask>
}
   41ecb:	90                   	nop
   41ecc:	c9                   	leave  
   41ecd:	c3                   	ret    

0000000000041ece <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41ece:	f3 0f 1e fa          	endbr64 
   41ed2:	55                   	push   %rbp
   41ed3:	48 89 e5             	mov    %rsp,%rbp
   41ed6:	48 83 ec 08          	sub    $0x8,%rsp
   41eda:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41ede:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41ee3:	74 14                	je     41ef9 <physical_memory_isreserved+0x2b>
   41ee5:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41eec:	00 
   41eed:	76 11                	jbe    41f00 <physical_memory_isreserved+0x32>
   41eef:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41ef6:	00 
   41ef7:	77 07                	ja     41f00 <physical_memory_isreserved+0x32>
   41ef9:	b8 01 00 00 00       	mov    $0x1,%eax
   41efe:	eb 05                	jmp    41f05 <physical_memory_isreserved+0x37>
   41f00:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41f05:	c9                   	leave  
   41f06:	c3                   	ret    

0000000000041f07 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41f07:	f3 0f 1e fa          	endbr64 
   41f0b:	55                   	push   %rbp
   41f0c:	48 89 e5             	mov    %rsp,%rbp
   41f0f:	48 83 ec 10          	sub    $0x10,%rsp
   41f13:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41f16:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41f19:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41f1c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f1f:	c1 e0 10             	shl    $0x10,%eax
   41f22:	89 c2                	mov    %eax,%edx
   41f24:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f27:	c1 e0 0b             	shl    $0xb,%eax
   41f2a:	09 c2                	or     %eax,%edx
   41f2c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f2f:	c1 e0 08             	shl    $0x8,%eax
   41f32:	09 d0                	or     %edx,%eax
}
   41f34:	c9                   	leave  
   41f35:	c3                   	ret    

0000000000041f36 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41f36:	f3 0f 1e fa          	endbr64 
   41f3a:	55                   	push   %rbp
   41f3b:	48 89 e5             	mov    %rsp,%rbp
   41f3e:	48 83 ec 18          	sub    $0x18,%rsp
   41f42:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41f45:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41f48:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f4b:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f4e:	09 d0                	or     %edx,%eax
   41f50:	0d 00 00 00 80       	or     $0x80000000,%eax
   41f55:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41f5c:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41f5f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f62:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f65:	ef                   	out    %eax,(%dx)
}
   41f66:	90                   	nop
   41f67:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41f6e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f71:	89 c2                	mov    %eax,%edx
   41f73:	ed                   	in     (%dx),%eax
   41f74:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41f77:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41f7a:	c9                   	leave  
   41f7b:	c3                   	ret    

0000000000041f7c <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41f7c:	f3 0f 1e fa          	endbr64 
   41f80:	55                   	push   %rbp
   41f81:	48 89 e5             	mov    %rsp,%rbp
   41f84:	48 83 ec 28          	sub    $0x28,%rsp
   41f88:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41f8b:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41f8e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41f95:	eb 73                	jmp    4200a <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   41f97:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41f9e:	eb 60                	jmp    42000 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   41fa0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41fa7:	eb 4a                	jmp    41ff3 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41fa9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41fac:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41faf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41fb2:	89 ce                	mov    %ecx,%esi
   41fb4:	89 c7                	mov    %eax,%edi
   41fb6:	e8 4c ff ff ff       	call   41f07 <pci_make_configaddr>
   41fbb:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41fbe:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fc1:	be 00 00 00 00       	mov    $0x0,%esi
   41fc6:	89 c7                	mov    %eax,%edi
   41fc8:	e8 69 ff ff ff       	call   41f36 <pci_config_readl>
   41fcd:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41fd0:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41fd3:	c1 e0 10             	shl    $0x10,%eax
   41fd6:	0b 45 dc             	or     -0x24(%rbp),%eax
   41fd9:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41fdc:	75 05                	jne    41fe3 <pci_find_device+0x67>
                    return configaddr;
   41fde:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fe1:	eb 35                	jmp    42018 <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41fe3:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41fe7:	75 06                	jne    41fef <pci_find_device+0x73>
   41fe9:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41fed:	74 0c                	je     41ffb <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   41fef:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41ff3:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41ff7:	75 b0                	jne    41fa9 <pci_find_device+0x2d>
   41ff9:	eb 01                	jmp    41ffc <pci_find_device+0x80>
                    break;
   41ffb:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41ffc:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42000:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   42004:	75 9a                	jne    41fa0 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   42006:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4200a:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42011:	75 84                	jne    41f97 <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   42013:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   42018:	c9                   	leave  
   42019:	c3                   	ret    

000000000004201a <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   4201a:	f3 0f 1e fa          	endbr64 
   4201e:	55                   	push   %rbp
   4201f:	48 89 e5             	mov    %rsp,%rbp
   42022:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42026:	be 13 71 00 00       	mov    $0x7113,%esi
   4202b:	bf 86 80 00 00       	mov    $0x8086,%edi
   42030:	e8 47 ff ff ff       	call   41f7c <pci_find_device>
   42035:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   42038:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4203c:	78 30                	js     4206e <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   4203e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42041:	be 40 00 00 00       	mov    $0x40,%esi
   42046:	89 c7                	mov    %eax,%edi
   42048:	e8 e9 fe ff ff       	call   41f36 <pci_config_readl>
   4204d:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42052:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42055:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42058:	83 c0 04             	add    $0x4,%eax
   4205b:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4205e:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42064:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42068:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4206b:	66 ef                	out    %ax,(%dx)
}
   4206d:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   4206e:	48 8d 05 ab 34 00 00 	lea    0x34ab(%rip),%rax        # 45520 <memstate_colors+0x3a0>
   42075:	48 89 c2             	mov    %rax,%rdx
   42078:	be 00 c0 00 00       	mov    $0xc000,%esi
   4207d:	bf 80 07 00 00       	mov    $0x780,%edi
   42082:	b8 00 00 00 00       	mov    $0x0,%eax
   42087:	e8 1f 2f 00 00       	call   44fab <console_printf>
 spinloop: goto spinloop;
   4208c:	eb fe                	jmp    4208c <poweroff+0x72>

000000000004208e <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   4208e:	f3 0f 1e fa          	endbr64 
   42092:	55                   	push   %rbp
   42093:	48 89 e5             	mov    %rsp,%rbp
   42096:	48 83 ec 10          	sub    $0x10,%rsp
   4209a:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   420a1:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420a5:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420a9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   420ac:	ee                   	out    %al,(%dx)
}
   420ad:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   420ae:	eb fe                	jmp    420ae <reboot+0x20>

00000000000420b0 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   420b0:	f3 0f 1e fa          	endbr64 
   420b4:	55                   	push   %rbp
   420b5:	48 89 e5             	mov    %rsp,%rbp
   420b8:	48 83 ec 10          	sub    $0x10,%rsp
   420bc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   420c0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   420c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420c7:	48 83 c0 18          	add    $0x18,%rax
   420cb:	ba c0 00 00 00       	mov    $0xc0,%edx
   420d0:	be 00 00 00 00       	mov    $0x0,%esi
   420d5:	48 89 c7             	mov    %rax,%rdi
   420d8:	e8 8f 20 00 00       	call   4416c <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   420dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420e1:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   420e8:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   420ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420ee:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   420f5:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   420f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420fd:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   42104:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   42108:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4210c:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   42113:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   42115:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42119:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   42120:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42124:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42127:	83 e0 01             	and    $0x1,%eax
   4212a:	85 c0                	test   %eax,%eax
   4212c:	74 1c                	je     4214a <process_init+0x9a>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4212e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42132:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   42139:	80 cc 30             	or     $0x30,%ah
   4213c:	48 89 c2             	mov    %rax,%rdx
   4213f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42143:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   4214a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4214d:	83 e0 02             	and    $0x2,%eax
   42150:	85 c0                	test   %eax,%eax
   42152:	74 1c                	je     42170 <process_init+0xc0>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42154:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42158:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   4215f:	80 e4 fd             	and    $0xfd,%ah
   42162:	48 89 c2             	mov    %rax,%rdx
   42165:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42169:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   42170:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42174:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   4217b:	90                   	nop
   4217c:	c9                   	leave  
   4217d:	c3                   	ret    

000000000004217e <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   4217e:	f3 0f 1e fa          	endbr64 
   42182:	55                   	push   %rbp
   42183:	48 89 e5             	mov    %rsp,%rbp
   42186:	48 83 ec 28          	sub    $0x28,%rsp
   4218a:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4218d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42191:	78 09                	js     4219c <console_show_cursor+0x1e>
   42193:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4219a:	7e 07                	jle    421a3 <console_show_cursor+0x25>
        cpos = 0;
   4219c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   421a3:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   421aa:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421ae:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   421b2:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   421b5:	ee                   	out    %al,(%dx)
}
   421b6:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   421b7:	8b 45 dc             	mov    -0x24(%rbp),%eax
   421ba:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   421c0:	85 c0                	test   %eax,%eax
   421c2:	0f 48 c2             	cmovs  %edx,%eax
   421c5:	c1 f8 08             	sar    $0x8,%eax
   421c8:	0f b6 c0             	movzbl %al,%eax
   421cb:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   421d2:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421d5:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   421d9:	8b 55 ec             	mov    -0x14(%rbp),%edx
   421dc:	ee                   	out    %al,(%dx)
}
   421dd:	90                   	nop
   421de:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   421e5:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421e9:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   421ed:	8b 55 f4             	mov    -0xc(%rbp),%edx
   421f0:	ee                   	out    %al,(%dx)
}
   421f1:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   421f2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   421f5:	99                   	cltd   
   421f6:	c1 ea 18             	shr    $0x18,%edx
   421f9:	01 d0                	add    %edx,%eax
   421fb:	0f b6 c0             	movzbl %al,%eax
   421fe:	29 d0                	sub    %edx,%eax
   42200:	0f b6 c0             	movzbl %al,%eax
   42203:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   4220a:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4220d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42211:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42214:	ee                   	out    %al,(%dx)
}
   42215:	90                   	nop
}
   42216:	90                   	nop
   42217:	c9                   	leave  
   42218:	c3                   	ret    

0000000000042219 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   42219:	f3 0f 1e fa          	endbr64 
   4221d:	55                   	push   %rbp
   4221e:	48 89 e5             	mov    %rsp,%rbp
   42221:	48 83 ec 20          	sub    $0x20,%rsp
   42225:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4222c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4222f:	89 c2                	mov    %eax,%edx
   42231:	ec                   	in     (%dx),%al
   42232:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42235:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   42239:	0f b6 c0             	movzbl %al,%eax
   4223c:	83 e0 01             	and    $0x1,%eax
   4223f:	85 c0                	test   %eax,%eax
   42241:	75 0a                	jne    4224d <keyboard_readc+0x34>
        return -1;
   42243:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42248:	e9 fd 01 00 00       	jmp    4244a <keyboard_readc+0x231>
   4224d:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42254:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42257:	89 c2                	mov    %eax,%edx
   42259:	ec                   	in     (%dx),%al
   4225a:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   4225d:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42261:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42264:	0f b6 05 77 f1 00 00 	movzbl 0xf177(%rip),%eax        # 513e2 <last_escape.2>
   4226b:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   4226e:	c6 05 6d f1 00 00 00 	movb   $0x0,0xf16d(%rip)        # 513e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42275:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42279:	75 11                	jne    4228c <keyboard_readc+0x73>
        last_escape = 0x80;
   4227b:	c6 05 60 f1 00 00 80 	movb   $0x80,0xf160(%rip)        # 513e2 <last_escape.2>
        return 0;
   42282:	b8 00 00 00 00       	mov    $0x0,%eax
   42287:	e9 be 01 00 00       	jmp    4244a <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4228c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42290:	84 c0                	test   %al,%al
   42292:	79 64                	jns    422f8 <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   42294:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42298:	83 e0 7f             	and    $0x7f,%eax
   4229b:	89 c2                	mov    %eax,%edx
   4229d:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   422a1:	09 d0                	or     %edx,%eax
   422a3:	48 98                	cltq   
   422a5:	48 8d 15 94 32 00 00 	lea    0x3294(%rip),%rdx        # 45540 <keymap>
   422ac:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   422b0:	0f b6 c0             	movzbl %al,%eax
   422b3:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   422b6:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   422bd:	7e 2f                	jle    422ee <keyboard_readc+0xd5>
   422bf:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   422c6:	7f 26                	jg     422ee <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   422c8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422cb:	2d fa 00 00 00       	sub    $0xfa,%eax
   422d0:	ba 01 00 00 00       	mov    $0x1,%edx
   422d5:	89 c1                	mov    %eax,%ecx
   422d7:	d3 e2                	shl    %cl,%edx
   422d9:	89 d0                	mov    %edx,%eax
   422db:	f7 d0                	not    %eax
   422dd:	89 c2                	mov    %eax,%edx
   422df:	0f b6 05 fd f0 00 00 	movzbl 0xf0fd(%rip),%eax        # 513e3 <modifiers.1>
   422e6:	21 d0                	and    %edx,%eax
   422e8:	88 05 f5 f0 00 00    	mov    %al,0xf0f5(%rip)        # 513e3 <modifiers.1>
        }
        return 0;
   422ee:	b8 00 00 00 00       	mov    $0x0,%eax
   422f3:	e9 52 01 00 00       	jmp    4244a <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   422f8:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   422fc:	0a 45 fa             	or     -0x6(%rbp),%al
   422ff:	0f b6 c0             	movzbl %al,%eax
   42302:	48 98                	cltq   
   42304:	48 8d 15 35 32 00 00 	lea    0x3235(%rip),%rdx        # 45540 <keymap>
   4230b:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   4230f:	0f b6 c0             	movzbl %al,%eax
   42312:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42315:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42319:	7e 57                	jle    42372 <keyboard_readc+0x159>
   4231b:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   4231f:	7f 51                	jg     42372 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   42321:	0f b6 05 bb f0 00 00 	movzbl 0xf0bb(%rip),%eax        # 513e3 <modifiers.1>
   42328:	0f b6 c0             	movzbl %al,%eax
   4232b:	83 e0 02             	and    $0x2,%eax
   4232e:	85 c0                	test   %eax,%eax
   42330:	74 09                	je     4233b <keyboard_readc+0x122>
            ch -= 0x60;
   42332:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42336:	e9 0b 01 00 00       	jmp    42446 <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4233b:	0f b6 05 a1 f0 00 00 	movzbl 0xf0a1(%rip),%eax        # 513e3 <modifiers.1>
   42342:	0f b6 c0             	movzbl %al,%eax
   42345:	83 e0 01             	and    $0x1,%eax
   42348:	85 c0                	test   %eax,%eax
   4234a:	0f 94 c2             	sete   %dl
   4234d:	0f b6 05 8f f0 00 00 	movzbl 0xf08f(%rip),%eax        # 513e3 <modifiers.1>
   42354:	0f b6 c0             	movzbl %al,%eax
   42357:	83 e0 08             	and    $0x8,%eax
   4235a:	85 c0                	test   %eax,%eax
   4235c:	0f 94 c0             	sete   %al
   4235f:	31 d0                	xor    %edx,%eax
   42361:	84 c0                	test   %al,%al
   42363:	0f 84 dd 00 00 00    	je     42446 <keyboard_readc+0x22d>
            ch -= 0x20;
   42369:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4236d:	e9 d4 00 00 00       	jmp    42446 <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42372:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42379:	7e 30                	jle    423ab <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4237b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4237e:	2d fa 00 00 00       	sub    $0xfa,%eax
   42383:	ba 01 00 00 00       	mov    $0x1,%edx
   42388:	89 c1                	mov    %eax,%ecx
   4238a:	d3 e2                	shl    %cl,%edx
   4238c:	89 d0                	mov    %edx,%eax
   4238e:	89 c2                	mov    %eax,%edx
   42390:	0f b6 05 4c f0 00 00 	movzbl 0xf04c(%rip),%eax        # 513e3 <modifiers.1>
   42397:	31 d0                	xor    %edx,%eax
   42399:	88 05 44 f0 00 00    	mov    %al,0xf044(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   4239f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   423a6:	e9 9c 00 00 00       	jmp    42447 <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   423ab:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   423b2:	7e 2d                	jle    423e1 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   423b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423b7:	2d fa 00 00 00       	sub    $0xfa,%eax
   423bc:	ba 01 00 00 00       	mov    $0x1,%edx
   423c1:	89 c1                	mov    %eax,%ecx
   423c3:	d3 e2                	shl    %cl,%edx
   423c5:	89 d0                	mov    %edx,%eax
   423c7:	89 c2                	mov    %eax,%edx
   423c9:	0f b6 05 13 f0 00 00 	movzbl 0xf013(%rip),%eax        # 513e3 <modifiers.1>
   423d0:	09 d0                	or     %edx,%eax
   423d2:	88 05 0b f0 00 00    	mov    %al,0xf00b(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   423d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   423df:	eb 66                	jmp    42447 <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   423e1:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   423e5:	7e 3f                	jle    42426 <keyboard_readc+0x20d>
   423e7:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   423ee:	7f 36                	jg     42426 <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   423f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423f3:	8d 50 80             	lea    -0x80(%rax),%edx
   423f6:	0f b6 05 e6 ef 00 00 	movzbl 0xefe6(%rip),%eax        # 513e3 <modifiers.1>
   423fd:	0f b6 c0             	movzbl %al,%eax
   42400:	83 e0 03             	and    $0x3,%eax
   42403:	48 63 c8             	movslq %eax,%rcx
   42406:	48 63 c2             	movslq %edx,%rax
   42409:	48 c1 e0 02          	shl    $0x2,%rax
   4240d:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   42411:	48 8d 05 28 32 00 00 	lea    0x3228(%rip),%rax        # 45640 <complex_keymap>
   42418:	48 01 d0             	add    %rdx,%rax
   4241b:	0f b6 00             	movzbl (%rax),%eax
   4241e:	0f b6 c0             	movzbl %al,%eax
   42421:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42424:	eb 21                	jmp    42447 <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42426:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4242a:	7f 1b                	jg     42447 <keyboard_readc+0x22e>
   4242c:	0f b6 05 b0 ef 00 00 	movzbl 0xefb0(%rip),%eax        # 513e3 <modifiers.1>
   42433:	0f b6 c0             	movzbl %al,%eax
   42436:	83 e0 02             	and    $0x2,%eax
   42439:	85 c0                	test   %eax,%eax
   4243b:	74 0a                	je     42447 <keyboard_readc+0x22e>
        ch = 0;
   4243d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42444:	eb 01                	jmp    42447 <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   42446:	90                   	nop
    }

    return ch;
   42447:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4244a:	c9                   	leave  
   4244b:	c3                   	ret    

000000000004244c <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   4244c:	f3 0f 1e fa          	endbr64 
   42450:	55                   	push   %rbp
   42451:	48 89 e5             	mov    %rsp,%rbp
   42454:	48 83 ec 20          	sub    $0x20,%rsp
   42458:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4245f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42462:	89 c2                	mov    %eax,%edx
   42464:	ec                   	in     (%dx),%al
   42465:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42468:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   4246f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42472:	89 c2                	mov    %eax,%edx
   42474:	ec                   	in     (%dx),%al
   42475:	88 45 eb             	mov    %al,-0x15(%rbp)
   42478:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   4247f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42482:	89 c2                	mov    %eax,%edx
   42484:	ec                   	in     (%dx),%al
   42485:	88 45 f3             	mov    %al,-0xd(%rbp)
   42488:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   4248f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42492:	89 c2                	mov    %eax,%edx
   42494:	ec                   	in     (%dx),%al
   42495:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42498:	90                   	nop
   42499:	c9                   	leave  
   4249a:	c3                   	ret    

000000000004249b <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4249b:	f3 0f 1e fa          	endbr64 
   4249f:	55                   	push   %rbp
   424a0:	48 89 e5             	mov    %rsp,%rbp
   424a3:	48 83 ec 40          	sub    $0x40,%rsp
   424a7:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   424ab:	89 f0                	mov    %esi,%eax
   424ad:	89 55 c0             	mov    %edx,-0x40(%rbp)
   424b0:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   424b3:	8b 05 2b ef 00 00    	mov    0xef2b(%rip),%eax        # 513e4 <initialized.0>
   424b9:	85 c0                	test   %eax,%eax
   424bb:	75 1e                	jne    424db <parallel_port_putc+0x40>
   424bd:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   424c4:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424c8:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   424cc:	8b 55 f8             	mov    -0x8(%rbp),%edx
   424cf:	ee                   	out    %al,(%dx)
}
   424d0:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   424d1:	c7 05 09 ef 00 00 01 	movl   $0x1,0xef09(%rip)        # 513e4 <initialized.0>
   424d8:	00 00 00 
    }

    for (int i = 0;
   424db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   424e2:	eb 09                	jmp    424ed <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   424e4:	e8 63 ff ff ff       	call   4244c <delay>
         ++i) {
   424e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   424ed:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   424f4:	7f 18                	jg     4250e <parallel_port_putc+0x73>
   424f6:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   424fd:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42500:	89 c2                	mov    %eax,%edx
   42502:	ec                   	in     (%dx),%al
   42503:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42506:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4250a:	84 c0                	test   %al,%al
   4250c:	79 d6                	jns    424e4 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   4250e:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42512:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42519:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4251c:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42520:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42523:	ee                   	out    %al,(%dx)
}
   42524:	90                   	nop
   42525:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   4252c:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42530:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42534:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42537:	ee                   	out    %al,(%dx)
}
   42538:	90                   	nop
   42539:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42540:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42544:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42548:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4254b:	ee                   	out    %al,(%dx)
}
   4254c:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   4254d:	90                   	nop
   4254e:	c9                   	leave  
   4254f:	c3                   	ret    

0000000000042550 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42550:	f3 0f 1e fa          	endbr64 
   42554:	55                   	push   %rbp
   42555:	48 89 e5             	mov    %rsp,%rbp
   42558:	48 83 ec 20          	sub    $0x20,%rsp
   4255c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42560:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42564:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 4249b <parallel_port_putc>
   4256b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   4256f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42573:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42577:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4257b:	be 00 00 00 00       	mov    $0x0,%esi
   42580:	48 89 c7             	mov    %rax,%rdi
   42583:	e8 aa 1e 00 00       	call   44432 <printer_vprintf>
}
   42588:	90                   	nop
   42589:	c9                   	leave  
   4258a:	c3                   	ret    

000000000004258b <log_printf>:

void log_printf(const char* format, ...) {
   4258b:	f3 0f 1e fa          	endbr64 
   4258f:	55                   	push   %rbp
   42590:	48 89 e5             	mov    %rsp,%rbp
   42593:	48 83 ec 60          	sub    $0x60,%rsp
   42597:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4259b:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4259f:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   425a3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   425a7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   425ab:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   425af:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   425b6:	48 8d 45 10          	lea    0x10(%rbp),%rax
   425ba:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   425be:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   425c2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   425c6:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   425ca:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   425ce:	48 89 d6             	mov    %rdx,%rsi
   425d1:	48 89 c7             	mov    %rax,%rdi
   425d4:	e8 77 ff ff ff       	call   42550 <log_vprintf>
    va_end(val);
}
   425d9:	90                   	nop
   425da:	c9                   	leave  
   425db:	c3                   	ret    

00000000000425dc <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   425dc:	f3 0f 1e fa          	endbr64 
   425e0:	55                   	push   %rbp
   425e1:	48 89 e5             	mov    %rsp,%rbp
   425e4:	48 83 ec 40          	sub    $0x40,%rsp
   425e8:	89 7d dc             	mov    %edi,-0x24(%rbp)
   425eb:	89 75 d8             	mov    %esi,-0x28(%rbp)
   425ee:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   425f2:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   425f6:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   425fa:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   425fe:	48 8b 0a             	mov    (%rdx),%rcx
   42601:	48 89 08             	mov    %rcx,(%rax)
   42604:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42608:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4260c:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42610:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42614:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42618:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4261c:	48 89 d6             	mov    %rdx,%rsi
   4261f:	48 89 c7             	mov    %rax,%rdi
   42622:	e8 29 ff ff ff       	call   42550 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42627:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4262b:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4262f:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42632:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42635:	89 c7                	mov    %eax,%edi
   42637:	e8 f3 28 00 00       	call   44f2f <console_vprintf>
}
   4263c:	c9                   	leave  
   4263d:	c3                   	ret    

000000000004263e <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   4263e:	f3 0f 1e fa          	endbr64 
   42642:	55                   	push   %rbp
   42643:	48 89 e5             	mov    %rsp,%rbp
   42646:	48 83 ec 60          	sub    $0x60,%rsp
   4264a:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4264d:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42650:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42654:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42658:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4265c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42660:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42667:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4266b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4266f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42673:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42677:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4267b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4267f:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42682:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42685:	89 c7                	mov    %eax,%edi
   42687:	e8 50 ff ff ff       	call   425dc <error_vprintf>
   4268c:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4268f:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42692:	c9                   	leave  
   42693:	c3                   	ret    

0000000000042694 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42694:	f3 0f 1e fa          	endbr64 
   42698:	55                   	push   %rbp
   42699:	48 89 e5             	mov    %rsp,%rbp
   4269c:	53                   	push   %rbx
   4269d:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   426a1:	e8 73 fb ff ff       	call   42219 <keyboard_readc>
   426a6:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   426a9:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   426ad:	74 1c                	je     426cb <check_keyboard+0x37>
   426af:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   426b3:	74 16                	je     426cb <check_keyboard+0x37>
   426b5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   426b9:	74 10                	je     426cb <check_keyboard+0x37>
   426bb:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   426bf:	74 0a                	je     426cb <check_keyboard+0x37>
   426c1:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   426c5:	0f 85 02 01 00 00    	jne    427cd <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   426cb:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   426d2:	00 
        memset(pt, 0, PAGESIZE * 3);
   426d3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426d7:	ba 00 30 00 00       	mov    $0x3000,%edx
   426dc:	be 00 00 00 00       	mov    $0x0,%esi
   426e1:	48 89 c7             	mov    %rax,%rdi
   426e4:	e8 83 1a 00 00       	call   4416c <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   426e9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426ed:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   426f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   426f8:	48 05 00 10 00 00    	add    $0x1000,%rax
   426fe:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42705:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42709:	48 05 00 20 00 00    	add    $0x2000,%rax
   4270f:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42716:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4271a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4271e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42722:	0f 22 d8             	mov    %rax,%cr3
}
   42725:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42726:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   4272d:	48 8d 05 64 2f 00 00 	lea    0x2f64(%rip),%rax        # 45698 <complex_keymap+0x58>
   42734:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   42738:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4273c:	75 0d                	jne    4274b <check_keyboard+0xb7>
            argument = "allocator";
   4273e:	48 8d 05 5a 2f 00 00 	lea    0x2f5a(%rip),%rax        # 4569f <complex_keymap+0x5f>
   42745:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42749:	eb 37                	jmp    42782 <check_keyboard+0xee>
        } else if (c == 'c') {
   4274b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   4274f:	75 0d                	jne    4275e <check_keyboard+0xca>
            argument = "alloctests";
   42751:	48 8d 05 51 2f 00 00 	lea    0x2f51(%rip),%rax        # 456a9 <complex_keymap+0x69>
   42758:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4275c:	eb 24                	jmp    42782 <check_keyboard+0xee>
        } else if(c == 't'){
   4275e:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42762:	75 0d                	jne    42771 <check_keyboard+0xdd>
            argument = "test";
   42764:	48 8d 05 49 2f 00 00 	lea    0x2f49(%rip),%rax        # 456b4 <complex_keymap+0x74>
   4276b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4276f:	eb 11                	jmp    42782 <check_keyboard+0xee>
        }
        else if(c == '2'){
   42771:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42775:	75 0b                	jne    42782 <check_keyboard+0xee>
            argument = "test2";
   42777:	48 8d 05 3b 2f 00 00 	lea    0x2f3b(%rip),%rax        # 456b9 <complex_keymap+0x79>
   4277e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42782:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42786:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   4278a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4278f:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42793:	76 1e                	jbe    427b3 <check_keyboard+0x11f>
   42795:	48 8d 05 23 2f 00 00 	lea    0x2f23(%rip),%rax        # 456bf <complex_keymap+0x7f>
   4279c:	48 89 c2             	mov    %rax,%rdx
   4279f:	be 5c 02 00 00       	mov    $0x25c,%esi
   427a4:	48 8d 05 30 2f 00 00 	lea    0x2f30(%rip),%rax        # 456db <complex_keymap+0x9b>
   427ab:	48 89 c7             	mov    %rax,%rdi
   427ae:	e8 33 01 00 00       	call   428e6 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   427b3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   427b7:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   427ba:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   427be:	48 89 c3             	mov    %rax,%rbx
   427c1:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   427c6:	e9 35 d8 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   427cb:	eb 11                	jmp    427de <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   427cd:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   427d1:	74 06                	je     427d9 <check_keyboard+0x145>
   427d3:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   427d7:	75 05                	jne    427de <check_keyboard+0x14a>
        poweroff();
   427d9:	e8 3c f8 ff ff       	call   4201a <poweroff>
    }
    return c;
   427de:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   427e1:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   427e5:	c9                   	leave  
   427e6:	c3                   	ret    

00000000000427e7 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   427e7:	f3 0f 1e fa          	endbr64 
   427eb:	55                   	push   %rbp
   427ec:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   427ef:	e8 a0 fe ff ff       	call   42694 <check_keyboard>
   427f4:	eb f9                	jmp    427ef <fail+0x8>

00000000000427f6 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   427f6:	f3 0f 1e fa          	endbr64 
   427fa:	55                   	push   %rbp
   427fb:	48 89 e5             	mov    %rsp,%rbp
   427fe:	48 83 ec 60          	sub    $0x60,%rsp
   42802:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42806:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4280a:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4280e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42812:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42816:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4281a:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42821:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42825:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42829:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4282d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42831:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42836:	0f 84 87 00 00 00    	je     428c3 <kernel_panic+0xcd>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   4283c:	48 8d 05 ac 2e 00 00 	lea    0x2eac(%rip),%rax        # 456ef <complex_keymap+0xaf>
   42843:	48 89 c2             	mov    %rax,%rdx
   42846:	be 00 c0 00 00       	mov    $0xc000,%esi
   4284b:	bf 30 07 00 00       	mov    $0x730,%edi
   42850:	b8 00 00 00 00       	mov    $0x0,%eax
   42855:	e8 e4 fd ff ff       	call   4263e <error_printf>
   4285a:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   4285d:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42861:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42865:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42868:	be 00 c0 00 00       	mov    $0xc000,%esi
   4286d:	89 c7                	mov    %eax,%edi
   4286f:	e8 68 fd ff ff       	call   425dc <error_vprintf>
   42874:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42877:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   4287a:	48 63 c1             	movslq %ecx,%rax
   4287d:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42884:	48 c1 e8 20          	shr    $0x20,%rax
   42888:	c1 f8 05             	sar    $0x5,%eax
   4288b:	89 ce                	mov    %ecx,%esi
   4288d:	c1 fe 1f             	sar    $0x1f,%esi
   42890:	29 f0                	sub    %esi,%eax
   42892:	89 c2                	mov    %eax,%edx
   42894:	89 d0                	mov    %edx,%eax
   42896:	c1 e0 02             	shl    $0x2,%eax
   42899:	01 d0                	add    %edx,%eax
   4289b:	c1 e0 04             	shl    $0x4,%eax
   4289e:	29 c1                	sub    %eax,%ecx
   428a0:	89 ca                	mov    %ecx,%edx
   428a2:	85 d2                	test   %edx,%edx
   428a4:	74 3b                	je     428e1 <kernel_panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   428a6:	8b 45 cc             	mov    -0x34(%rbp),%eax
   428a9:	48 8d 15 47 2e 00 00 	lea    0x2e47(%rip),%rdx        # 456f7 <complex_keymap+0xb7>
   428b0:	be 00 c0 00 00       	mov    $0xc000,%esi
   428b5:	89 c7                	mov    %eax,%edi
   428b7:	b8 00 00 00 00       	mov    $0x0,%eax
   428bc:	e8 7d fd ff ff       	call   4263e <error_printf>
   428c1:	eb 1e                	jmp    428e1 <kernel_panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   428c3:	48 8d 05 2f 2e 00 00 	lea    0x2e2f(%rip),%rax        # 456f9 <complex_keymap+0xb9>
   428ca:	48 89 c2             	mov    %rax,%rdx
   428cd:	be 00 c0 00 00       	mov    $0xc000,%esi
   428d2:	bf 30 07 00 00       	mov    $0x730,%edi
   428d7:	b8 00 00 00 00       	mov    $0x0,%eax
   428dc:	e8 5d fd ff ff       	call   4263e <error_printf>
    }

    va_end(val);
    fail();
   428e1:	e8 01 ff ff ff       	call   427e7 <fail>

00000000000428e6 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   428e6:	f3 0f 1e fa          	endbr64 
   428ea:	55                   	push   %rbp
   428eb:	48 89 e5             	mov    %rsp,%rbp
   428ee:	48 83 ec 20          	sub    $0x20,%rsp
   428f2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   428f6:	89 75 f4             	mov    %esi,-0xc(%rbp)
   428f9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   428fd:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42901:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42904:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42908:	48 89 c6             	mov    %rax,%rsi
   4290b:	48 8d 05 ed 2d 00 00 	lea    0x2ded(%rip),%rax        # 456ff <complex_keymap+0xbf>
   42912:	48 89 c7             	mov    %rax,%rdi
   42915:	b8 00 00 00 00       	mov    $0x0,%eax
   4291a:	e8 d7 fe ff ff       	call   427f6 <kernel_panic>

000000000004291f <default_exception>:
}

void default_exception(proc* p){
   4291f:	f3 0f 1e fa          	endbr64 
   42923:	55                   	push   %rbp
   42924:	48 89 e5             	mov    %rsp,%rbp
   42927:	48 83 ec 20          	sub    $0x20,%rsp
   4292b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   4292f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42933:	48 83 c0 18          	add    $0x18,%rax
   42937:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   4293b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4293f:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42946:	48 89 c6             	mov    %rax,%rsi
   42949:	48 8d 05 cd 2d 00 00 	lea    0x2dcd(%rip),%rax        # 4571d <complex_keymap+0xdd>
   42950:	48 89 c7             	mov    %rax,%rdi
   42953:	b8 00 00 00 00       	mov    $0x0,%eax
   42958:	e8 99 fe ff ff       	call   427f6 <kernel_panic>

000000000004295d <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4295d:	55                   	push   %rbp
   4295e:	48 89 e5             	mov    %rsp,%rbp
   42961:	48 83 ec 10          	sub    $0x10,%rsp
   42965:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42969:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   4296c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42970:	78 06                	js     42978 <pageindex+0x1b>
   42972:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42976:	7e 1e                	jle    42996 <pageindex+0x39>
   42978:	48 8d 05 b9 2d 00 00 	lea    0x2db9(%rip),%rax        # 45738 <complex_keymap+0xf8>
   4297f:	48 89 c2             	mov    %rax,%rdx
   42982:	be 1e 00 00 00       	mov    $0x1e,%esi
   42987:	48 8d 05 c3 2d 00 00 	lea    0x2dc3(%rip),%rax        # 45751 <complex_keymap+0x111>
   4298e:	48 89 c7             	mov    %rax,%rdi
   42991:	e8 50 ff ff ff       	call   428e6 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42996:	b8 03 00 00 00       	mov    $0x3,%eax
   4299b:	2b 45 f4             	sub    -0xc(%rbp),%eax
   4299e:	89 c2                	mov    %eax,%edx
   429a0:	89 d0                	mov    %edx,%eax
   429a2:	c1 e0 03             	shl    $0x3,%eax
   429a5:	01 d0                	add    %edx,%eax
   429a7:	83 c0 0c             	add    $0xc,%eax
   429aa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   429ae:	89 c1                	mov    %eax,%ecx
   429b0:	48 d3 ea             	shr    %cl,%rdx
   429b3:	48 89 d0             	mov    %rdx,%rax
   429b6:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   429bb:	c9                   	leave  
   429bc:	c3                   	ret    

00000000000429bd <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   429bd:	f3 0f 1e fa          	endbr64 
   429c1:	55                   	push   %rbp
   429c2:	48 89 e5             	mov    %rsp,%rbp
   429c5:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   429c9:	48 8d 05 30 06 01 00 	lea    0x10630(%rip),%rax        # 53000 <kernel_pagetables>
   429d0:	48 89 05 29 f6 00 00 	mov    %rax,0xf629(%rip)        # 52000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   429d7:	ba 00 50 00 00       	mov    $0x5000,%edx
   429dc:	be 00 00 00 00       	mov    $0x0,%esi
   429e1:	48 8d 05 18 06 01 00 	lea    0x10618(%rip),%rax        # 53000 <kernel_pagetables>
   429e8:	48 89 c7             	mov    %rax,%rdi
   429eb:	e8 7c 17 00 00       	call   4416c <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   429f0:	48 8d 05 09 16 01 00 	lea    0x11609(%rip),%rax        # 54000 <kernel_pagetables+0x1000>
   429f7:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   429fb:	48 89 05 fe 05 01 00 	mov    %rax,0x105fe(%rip)        # 53000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42a02:	48 8d 05 f7 25 01 00 	lea    0x125f7(%rip),%rax        # 55000 <kernel_pagetables+0x2000>
   42a09:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42a0d:	48 89 05 ec 15 01 00 	mov    %rax,0x115ec(%rip)        # 54000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42a14:	48 8d 05 e5 35 01 00 	lea    0x135e5(%rip),%rax        # 56000 <kernel_pagetables+0x3000>
   42a1b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42a1f:	48 89 05 da 25 01 00 	mov    %rax,0x125da(%rip)        # 55000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42a26:	48 8d 05 d3 45 01 00 	lea    0x145d3(%rip),%rax        # 57000 <kernel_pagetables+0x4000>
   42a2d:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42a31:	48 89 05 d0 25 01 00 	mov    %rax,0x125d0(%rip)        # 55008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42a38:	48 8b 05 c1 f5 00 00 	mov    0xf5c1(%rip),%rax        # 52000 <kernel_pagetable>
   42a3f:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42a45:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42a4a:	ba 00 00 00 00       	mov    $0x0,%edx
   42a4f:	be 00 00 00 00       	mov    $0x0,%esi
   42a54:	48 89 c7             	mov    %rax,%rdi
   42a57:	e8 0e 02 00 00       	call   42c6a <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42a5c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42a63:	00 
   42a64:	eb 76                	jmp    42adc <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42a66:	48 8b 0d 93 f5 00 00 	mov    0xf593(%rip),%rcx        # 52000 <kernel_pagetable>
   42a6d:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42a71:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42a75:	48 89 ce             	mov    %rcx,%rsi
   42a78:	48 89 c7             	mov    %rax,%rdi
   42a7b:	e8 36 06 00 00       	call   430b6 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   42a80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a84:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42a88:	74 1e                	je     42aa8 <virtual_memory_init+0xeb>
   42a8a:	48 8d 05 d4 2c 00 00 	lea    0x2cd4(%rip),%rax        # 45765 <complex_keymap+0x125>
   42a91:	48 89 c2             	mov    %rax,%rdx
   42a94:	be 2d 00 00 00       	mov    $0x2d,%esi
   42a99:	48 8d 05 d5 2c 00 00 	lea    0x2cd5(%rip),%rax        # 45775 <complex_keymap+0x135>
   42aa0:	48 89 c7             	mov    %rax,%rdi
   42aa3:	e8 3e fe ff ff       	call   428e6 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42aa8:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42aab:	48 98                	cltq   
   42aad:	83 e0 03             	and    $0x3,%eax
   42ab0:	48 83 f8 03          	cmp    $0x3,%rax
   42ab4:	74 1e                	je     42ad4 <virtual_memory_init+0x117>
   42ab6:	48 8d 05 cb 2c 00 00 	lea    0x2ccb(%rip),%rax        # 45788 <complex_keymap+0x148>
   42abd:	48 89 c2             	mov    %rax,%rdx
   42ac0:	be 2e 00 00 00       	mov    $0x2e,%esi
   42ac5:	48 8d 05 a9 2c 00 00 	lea    0x2ca9(%rip),%rax        # 45775 <complex_keymap+0x135>
   42acc:	48 89 c7             	mov    %rax,%rdi
   42acf:	e8 12 fe ff ff       	call   428e6 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42ad4:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42adb:	00 
   42adc:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42ae3:	00 
   42ae4:	76 80                	jbe    42a66 <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42ae6:	48 8b 05 13 f5 00 00 	mov    0xf513(%rip),%rax        # 52000 <kernel_pagetable>
   42aed:	48 89 c7             	mov    %rax,%rdi
   42af0:	e8 03 00 00 00       	call   42af8 <set_pagetable>
}
   42af5:	90                   	nop
   42af6:	c9                   	leave  
   42af7:	c3                   	ret    

0000000000042af8 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42af8:	f3 0f 1e fa          	endbr64 
   42afc:	55                   	push   %rbp
   42afd:	48 89 e5             	mov    %rsp,%rbp
   42b00:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42b04:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42b08:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42b0c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b11:	48 85 c0             	test   %rax,%rax
   42b14:	74 1e                	je     42b34 <set_pagetable+0x3c>
   42b16:	48 8d 05 98 2c 00 00 	lea    0x2c98(%rip),%rax        # 457b5 <complex_keymap+0x175>
   42b1d:	48 89 c2             	mov    %rax,%rdx
   42b20:	be 3d 00 00 00       	mov    $0x3d,%esi
   42b25:	48 8d 05 49 2c 00 00 	lea    0x2c49(%rip),%rax        # 45775 <complex_keymap+0x135>
   42b2c:	48 89 c7             	mov    %rax,%rdi
   42b2f:	e8 b2 fd ff ff       	call   428e6 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42b34:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   42b3b:	48 89 c2             	mov    %rax,%rdx
   42b3e:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42b42:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42b46:	48 89 ce             	mov    %rcx,%rsi
   42b49:	48 89 c7             	mov    %rax,%rdi
   42b4c:	e8 65 05 00 00       	call   430b6 <virtual_memory_lookup>
   42b51:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42b55:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   42b5c:	48 39 d0             	cmp    %rdx,%rax
   42b5f:	74 1e                	je     42b7f <set_pagetable+0x87>
   42b61:	48 8d 05 68 2c 00 00 	lea    0x2c68(%rip),%rax        # 457d0 <complex_keymap+0x190>
   42b68:	48 89 c2             	mov    %rax,%rdx
   42b6b:	be 3f 00 00 00       	mov    $0x3f,%esi
   42b70:	48 8d 05 fe 2b 00 00 	lea    0x2bfe(%rip),%rax        # 45775 <complex_keymap+0x135>
   42b77:	48 89 c7             	mov    %rax,%rdi
   42b7a:	e8 67 fd ff ff       	call   428e6 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42b7f:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42b83:	48 8b 0d 76 f4 00 00 	mov    0xf476(%rip),%rcx        # 52000 <kernel_pagetable>
   42b8a:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42b8e:	48 89 ce             	mov    %rcx,%rsi
   42b91:	48 89 c7             	mov    %rax,%rdi
   42b94:	e8 1d 05 00 00       	call   430b6 <virtual_memory_lookup>
   42b99:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42b9d:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42ba1:	48 39 c2             	cmp    %rax,%rdx
   42ba4:	74 1e                	je     42bc4 <set_pagetable+0xcc>
   42ba6:	48 8d 05 8b 2c 00 00 	lea    0x2c8b(%rip),%rax        # 45838 <complex_keymap+0x1f8>
   42bad:	48 89 c2             	mov    %rax,%rdx
   42bb0:	be 41 00 00 00       	mov    $0x41,%esi
   42bb5:	48 8d 05 b9 2b 00 00 	lea    0x2bb9(%rip),%rax        # 45775 <complex_keymap+0x135>
   42bbc:	48 89 c7             	mov    %rax,%rdi
   42bbf:	e8 22 fd ff ff       	call   428e6 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42bc4:	48 8b 05 35 f4 00 00 	mov    0xf435(%rip),%rax        # 52000 <kernel_pagetable>
   42bcb:	48 89 c2             	mov    %rax,%rdx
   42bce:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42bd2:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42bd6:	48 89 ce             	mov    %rcx,%rsi
   42bd9:	48 89 c7             	mov    %rax,%rdi
   42bdc:	e8 d5 04 00 00       	call   430b6 <virtual_memory_lookup>
   42be1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42be5:	48 8b 15 14 f4 00 00 	mov    0xf414(%rip),%rdx        # 52000 <kernel_pagetable>
   42bec:	48 39 d0             	cmp    %rdx,%rax
   42bef:	74 1e                	je     42c0f <set_pagetable+0x117>
   42bf1:	48 8d 05 a0 2c 00 00 	lea    0x2ca0(%rip),%rax        # 45898 <complex_keymap+0x258>
   42bf8:	48 89 c2             	mov    %rax,%rdx
   42bfb:	be 43 00 00 00       	mov    $0x43,%esi
   42c00:	48 8d 05 6e 2b 00 00 	lea    0x2b6e(%rip),%rax        # 45775 <complex_keymap+0x135>
   42c07:	48 89 c7             	mov    %rax,%rdi
   42c0a:	e8 d7 fc ff ff       	call   428e6 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42c0f:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 42c6a <virtual_memory_map>
   42c16:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42c1a:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42c1e:	48 89 ce             	mov    %rcx,%rsi
   42c21:	48 89 c7             	mov    %rax,%rdi
   42c24:	e8 8d 04 00 00       	call   430b6 <virtual_memory_lookup>
   42c29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c2d:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 42c6a <virtual_memory_map>
   42c34:	48 39 d0             	cmp    %rdx,%rax
   42c37:	74 1e                	je     42c57 <set_pagetable+0x15f>
   42c39:	48 8d 05 c0 2c 00 00 	lea    0x2cc0(%rip),%rax        # 45900 <complex_keymap+0x2c0>
   42c40:	48 89 c2             	mov    %rax,%rdx
   42c43:	be 45 00 00 00       	mov    $0x45,%esi
   42c48:	48 8d 05 26 2b 00 00 	lea    0x2b26(%rip),%rax        # 45775 <complex_keymap+0x135>
   42c4f:	48 89 c7             	mov    %rax,%rdi
   42c52:	e8 8f fc ff ff       	call   428e6 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42c57:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42c5b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42c5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c63:	0f 22 d8             	mov    %rax,%cr3
}
   42c66:	90                   	nop
}
   42c67:	90                   	nop
   42c68:	c9                   	leave  
   42c69:	c3                   	ret    

0000000000042c6a <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42c6a:	f3 0f 1e fa          	endbr64 
   42c6e:	55                   	push   %rbp
   42c6f:	48 89 e5             	mov    %rsp,%rbp
   42c72:	53                   	push   %rbx
   42c73:	48 83 ec 58          	sub    $0x58,%rsp
   42c77:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42c7b:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42c7f:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42c83:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42c87:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42c8b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c8f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c94:	48 85 c0             	test   %rax,%rax
   42c97:	74 1e                	je     42cb7 <virtual_memory_map+0x4d>
   42c99:	48 8d 05 c6 2c 00 00 	lea    0x2cc6(%rip),%rax        # 45966 <complex_keymap+0x326>
   42ca0:	48 89 c2             	mov    %rax,%rdx
   42ca3:	be 66 00 00 00       	mov    $0x66,%esi
   42ca8:	48 8d 05 c6 2a 00 00 	lea    0x2ac6(%rip),%rax        # 45775 <complex_keymap+0x135>
   42caf:	48 89 c7             	mov    %rax,%rdi
   42cb2:	e8 2f fc ff ff       	call   428e6 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42cb7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42cbb:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cc0:	48 85 c0             	test   %rax,%rax
   42cc3:	74 1e                	je     42ce3 <virtual_memory_map+0x79>
   42cc5:	48 8d 05 ad 2c 00 00 	lea    0x2cad(%rip),%rax        # 45979 <complex_keymap+0x339>
   42ccc:	48 89 c2             	mov    %rax,%rdx
   42ccf:	be 67 00 00 00       	mov    $0x67,%esi
   42cd4:	48 8d 05 9a 2a 00 00 	lea    0x2a9a(%rip),%rax        # 45775 <complex_keymap+0x135>
   42cdb:	48 89 c7             	mov    %rax,%rdi
   42cde:	e8 03 fc ff ff       	call   428e6 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42ce3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42ce7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ceb:	48 01 d0             	add    %rdx,%rax
   42cee:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   42cf2:	76 2e                	jbe    42d22 <virtual_memory_map+0xb8>
   42cf4:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42cf8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42cfc:	48 01 d0             	add    %rdx,%rax
   42cff:	48 85 c0             	test   %rax,%rax
   42d02:	74 1e                	je     42d22 <virtual_memory_map+0xb8>
   42d04:	48 8d 05 81 2c 00 00 	lea    0x2c81(%rip),%rax        # 4598c <complex_keymap+0x34c>
   42d0b:	48 89 c2             	mov    %rax,%rdx
   42d0e:	be 68 00 00 00       	mov    $0x68,%esi
   42d13:	48 8d 05 5b 2a 00 00 	lea    0x2a5b(%rip),%rax        # 45775 <complex_keymap+0x135>
   42d1a:	48 89 c7             	mov    %rax,%rdi
   42d1d:	e8 c4 fb ff ff       	call   428e6 <assert_fail>
    if (perm & PTE_P) {
   42d22:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42d25:	48 98                	cltq   
   42d27:	83 e0 01             	and    $0x1,%eax
   42d2a:	48 85 c0             	test   %rax,%rax
   42d2d:	0f 84 8c 00 00 00    	je     42dbf <virtual_memory_map+0x155>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42d33:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42d37:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d3c:	48 85 c0             	test   %rax,%rax
   42d3f:	74 1e                	je     42d5f <virtual_memory_map+0xf5>
   42d41:	48 8d 05 62 2c 00 00 	lea    0x2c62(%rip),%rax        # 459aa <complex_keymap+0x36a>
   42d48:	48 89 c2             	mov    %rax,%rdx
   42d4b:	be 6a 00 00 00       	mov    $0x6a,%esi
   42d50:	48 8d 05 1e 2a 00 00 	lea    0x2a1e(%rip),%rax        # 45775 <complex_keymap+0x135>
   42d57:	48 89 c7             	mov    %rax,%rdi
   42d5a:	e8 87 fb ff ff       	call   428e6 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42d5f:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42d63:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42d67:	48 01 d0             	add    %rdx,%rax
   42d6a:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   42d6e:	76 1e                	jbe    42d8e <virtual_memory_map+0x124>
   42d70:	48 8d 05 46 2c 00 00 	lea    0x2c46(%rip),%rax        # 459bd <complex_keymap+0x37d>
   42d77:	48 89 c2             	mov    %rax,%rdx
   42d7a:	be 6b 00 00 00       	mov    $0x6b,%esi
   42d7f:	48 8d 05 ef 29 00 00 	lea    0x29ef(%rip),%rax        # 45775 <complex_keymap+0x135>
   42d86:	48 89 c7             	mov    %rax,%rdi
   42d89:	e8 58 fb ff ff       	call   428e6 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42d8e:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42d92:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42d96:	48 01 d0             	add    %rdx,%rax
   42d99:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42d9f:	76 1e                	jbe    42dbf <virtual_memory_map+0x155>
   42da1:	48 8d 05 23 2c 00 00 	lea    0x2c23(%rip),%rax        # 459cb <complex_keymap+0x38b>
   42da8:	48 89 c2             	mov    %rax,%rdx
   42dab:	be 6c 00 00 00       	mov    $0x6c,%esi
   42db0:	48 8d 05 be 29 00 00 	lea    0x29be(%rip),%rax        # 45775 <complex_keymap+0x135>
   42db7:	48 89 c7             	mov    %rax,%rdi
   42dba:	e8 27 fb ff ff       	call   428e6 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42dbf:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42dc3:	78 09                	js     42dce <virtual_memory_map+0x164>
   42dc5:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42dcc:	7e 1e                	jle    42dec <virtual_memory_map+0x182>
   42dce:	48 8d 05 12 2c 00 00 	lea    0x2c12(%rip),%rax        # 459e7 <complex_keymap+0x3a7>
   42dd5:	48 89 c2             	mov    %rax,%rdx
   42dd8:	be 6e 00 00 00       	mov    $0x6e,%esi
   42ddd:	48 8d 05 91 29 00 00 	lea    0x2991(%rip),%rax        # 45775 <complex_keymap+0x135>
   42de4:	48 89 c7             	mov    %rax,%rdi
   42de7:	e8 fa fa ff ff       	call   428e6 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42dec:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42df0:	25 ff 0f 00 00       	and    $0xfff,%eax
   42df5:	48 85 c0             	test   %rax,%rax
   42df8:	74 1e                	je     42e18 <virtual_memory_map+0x1ae>
   42dfa:	48 8d 05 07 2c 00 00 	lea    0x2c07(%rip),%rax        # 45a08 <complex_keymap+0x3c8>
   42e01:	48 89 c2             	mov    %rax,%rdx
   42e04:	be 6f 00 00 00       	mov    $0x6f,%esi
   42e09:	48 8d 05 65 29 00 00 	lea    0x2965(%rip),%rax        # 45775 <complex_keymap+0x135>
   42e10:	48 89 c7             	mov    %rax,%rdi
   42e13:	e8 ce fa ff ff       	call   428e6 <assert_fail>

    int last_index123 = -1;
   42e18:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   42e1f:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42e26:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42e27:	e9 e6 00 00 00       	jmp    42f12 <virtual_memory_map+0x2a8>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42e2c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e30:	48 c1 e8 15          	shr    $0x15,%rax
   42e34:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42e37:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42e3a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42e3d:	74 20                	je     42e5f <virtual_memory_map+0x1f5>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42e3f:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42e42:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42e46:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e4a:	48 89 ce             	mov    %rcx,%rsi
   42e4d:	48 89 c7             	mov    %rax,%rdi
   42e50:	e8 d3 00 00 00       	call   42f28 <lookup_l4pagetable>
   42e55:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42e59:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42e5c:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42e5f:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42e62:	48 98                	cltq   
   42e64:	83 e0 01             	and    $0x1,%eax
   42e67:	48 85 c0             	test   %rax,%rax
   42e6a:	74 34                	je     42ea0 <virtual_memory_map+0x236>
   42e6c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42e71:	74 2d                	je     42ea0 <virtual_memory_map+0x236>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42e73:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42e76:	48 63 d8             	movslq %eax,%rbx
   42e79:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e7d:	be 03 00 00 00       	mov    $0x3,%esi
   42e82:	48 89 c7             	mov    %rax,%rdi
   42e85:	e8 d3 fa ff ff       	call   4295d <pageindex>
   42e8a:	89 c2                	mov    %eax,%edx
   42e8c:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42e90:	48 89 d9             	mov    %rbx,%rcx
   42e93:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42e97:	48 63 d2             	movslq %edx,%rdx
   42e9a:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42e9e:	eb 5a                	jmp    42efa <virtual_memory_map+0x290>
        } else if (l4pagetable) { // if page is NOT marked present
   42ea0:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42ea5:	74 26                	je     42ecd <virtual_memory_map+0x263>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42ea7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42eab:	be 03 00 00 00       	mov    $0x3,%esi
   42eb0:	48 89 c7             	mov    %rax,%rdi
   42eb3:	e8 a5 fa ff ff       	call   4295d <pageindex>
   42eb8:	89 c2                	mov    %eax,%edx
   42eba:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ebd:	48 63 c8             	movslq %eax,%rcx
   42ec0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ec4:	48 63 d2             	movslq %edx,%rdx
   42ec7:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42ecb:	eb 2d                	jmp    42efa <virtual_memory_map+0x290>
        } else if (perm & PTE_P) {
   42ecd:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ed0:	48 98                	cltq   
   42ed2:	83 e0 01             	and    $0x1,%eax
   42ed5:	48 85 c0             	test   %rax,%rax
   42ed8:	74 20                	je     42efa <virtual_memory_map+0x290>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42eda:	be 84 00 00 00       	mov    $0x84,%esi
   42edf:	48 8d 05 4a 2b 00 00 	lea    0x2b4a(%rip),%rax        # 45a30 <complex_keymap+0x3f0>
   42ee6:	48 89 c7             	mov    %rax,%rdi
   42ee9:	b8 00 00 00 00       	mov    $0x0,%eax
   42eee:	e8 98 f6 ff ff       	call   4258b <log_printf>
            return -1;
   42ef3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42ef8:	eb 28                	jmp    42f22 <virtual_memory_map+0x2b8>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42efa:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42f01:	00 
   42f02:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42f09:	00 
   42f0a:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42f11:	00 
   42f12:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42f17:	0f 85 0f ff ff ff    	jne    42e2c <virtual_memory_map+0x1c2>
        }
    }
    return 0;
   42f1d:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f22:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42f26:	c9                   	leave  
   42f27:	c3                   	ret    

0000000000042f28 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42f28:	f3 0f 1e fa          	endbr64 
   42f2c:	55                   	push   %rbp
   42f2d:	48 89 e5             	mov    %rsp,%rbp
   42f30:	48 83 ec 40          	sub    $0x40,%rsp
   42f34:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f38:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42f3c:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42f3f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f43:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42f47:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42f4e:	e9 53 01 00 00       	jmp    430a6 <lookup_l4pagetable+0x17e>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42f53:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42f56:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42f5a:	89 d6                	mov    %edx,%esi
   42f5c:	48 89 c7             	mov    %rax,%rdi
   42f5f:	e8 f9 f9 ff ff       	call   4295d <pageindex>
   42f64:	89 c2                	mov    %eax,%edx
   42f66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f6a:	48 63 d2             	movslq %edx,%rdx
   42f6d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42f71:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42f75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f79:	83 e0 01             	and    $0x1,%eax
   42f7c:	48 85 c0             	test   %rax,%rax
   42f7f:	75 6d                	jne    42fee <lookup_l4pagetable+0xc6>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42f81:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42f84:	8d 48 02             	lea    0x2(%rax),%ecx
   42f87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f8b:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f90:	48 89 c2             	mov    %rax,%rdx
   42f93:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f97:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42f9d:	48 89 c6             	mov    %rax,%rsi
   42fa0:	48 8d 05 d1 2a 00 00 	lea    0x2ad1(%rip),%rax        # 45a78 <complex_keymap+0x438>
   42fa7:	48 89 c7             	mov    %rax,%rdi
   42faa:	b8 00 00 00 00       	mov    $0x0,%eax
   42faf:	e8 d7 f5 ff ff       	call   4258b <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42fb4:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42fb7:	48 98                	cltq   
   42fb9:	83 e0 01             	and    $0x1,%eax
   42fbc:	48 85 c0             	test   %rax,%rax
   42fbf:	75 0a                	jne    42fcb <lookup_l4pagetable+0xa3>
                return NULL;
   42fc1:	b8 00 00 00 00       	mov    $0x0,%eax
   42fc6:	e9 e9 00 00 00       	jmp    430b4 <lookup_l4pagetable+0x18c>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42fcb:	be a7 00 00 00       	mov    $0xa7,%esi
   42fd0:	48 8d 05 09 2b 00 00 	lea    0x2b09(%rip),%rax        # 45ae0 <complex_keymap+0x4a0>
   42fd7:	48 89 c7             	mov    %rax,%rdi
   42fda:	b8 00 00 00 00       	mov    $0x0,%eax
   42fdf:	e8 a7 f5 ff ff       	call   4258b <log_printf>
            return NULL;
   42fe4:	b8 00 00 00 00       	mov    $0x0,%eax
   42fe9:	e9 c6 00 00 00       	jmp    430b4 <lookup_l4pagetable+0x18c>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42fee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ff2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ff8:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42ffe:	76 1e                	jbe    4301e <lookup_l4pagetable+0xf6>
   43000:	48 8d 05 21 2b 00 00 	lea    0x2b21(%rip),%rax        # 45b28 <complex_keymap+0x4e8>
   43007:	48 89 c2             	mov    %rax,%rdx
   4300a:	be ac 00 00 00       	mov    $0xac,%esi
   4300f:	48 8d 05 5f 27 00 00 	lea    0x275f(%rip),%rax        # 45775 <complex_keymap+0x135>
   43016:	48 89 c7             	mov    %rax,%rdi
   43019:	e8 c8 f8 ff ff       	call   428e6 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   4301e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43021:	48 98                	cltq   
   43023:	83 e0 02             	and    $0x2,%eax
   43026:	48 85 c0             	test   %rax,%rax
   43029:	74 2a                	je     43055 <lookup_l4pagetable+0x12d>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   4302b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4302f:	83 e0 02             	and    $0x2,%eax
   43032:	48 85 c0             	test   %rax,%rax
   43035:	75 1e                	jne    43055 <lookup_l4pagetable+0x12d>
   43037:	48 8d 05 0a 2b 00 00 	lea    0x2b0a(%rip),%rax        # 45b48 <complex_keymap+0x508>
   4303e:	48 89 c2             	mov    %rax,%rdx
   43041:	be ae 00 00 00       	mov    $0xae,%esi
   43046:	48 8d 05 28 27 00 00 	lea    0x2728(%rip),%rax        # 45775 <complex_keymap+0x135>
   4304d:	48 89 c7             	mov    %rax,%rdi
   43050:	e8 91 f8 ff ff       	call   428e6 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   43055:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43058:	48 98                	cltq   
   4305a:	83 e0 04             	and    $0x4,%eax
   4305d:	48 85 c0             	test   %rax,%rax
   43060:	74 2a                	je     4308c <lookup_l4pagetable+0x164>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   43062:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43066:	83 e0 04             	and    $0x4,%eax
   43069:	48 85 c0             	test   %rax,%rax
   4306c:	75 1e                	jne    4308c <lookup_l4pagetable+0x164>
   4306e:	48 8d 05 de 2a 00 00 	lea    0x2ade(%rip),%rax        # 45b53 <complex_keymap+0x513>
   43075:	48 89 c2             	mov    %rax,%rdx
   43078:	be b1 00 00 00       	mov    $0xb1,%esi
   4307d:	48 8d 05 f1 26 00 00 	lea    0x26f1(%rip),%rax        # 45775 <complex_keymap+0x135>
   43084:	48 89 c7             	mov    %rax,%rdi
   43087:	e8 5a f8 ff ff       	call   428e6 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   4308c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43093:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43094:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43098:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4309e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   430a2:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   430a6:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   430aa:	0f 8e a3 fe ff ff    	jle    42f53 <lookup_l4pagetable+0x2b>
    }
    return pt;
   430b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   430b4:	c9                   	leave  
   430b5:	c3                   	ret    

00000000000430b6 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   430b6:	f3 0f 1e fa          	endbr64 
   430ba:	55                   	push   %rbp
   430bb:	48 89 e5             	mov    %rsp,%rbp
   430be:	48 83 ec 50          	sub    $0x50,%rsp
   430c2:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   430c6:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   430ca:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   430ce:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   430d2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   430d6:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   430dd:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   430de:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   430e5:	eb 41                	jmp    43128 <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   430e7:	8b 55 ec             	mov    -0x14(%rbp),%edx
   430ea:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   430ee:	89 d6                	mov    %edx,%esi
   430f0:	48 89 c7             	mov    %rax,%rdi
   430f3:	e8 65 f8 ff ff       	call   4295d <pageindex>
   430f8:	89 c2                	mov    %eax,%edx
   430fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430fe:	48 63 d2             	movslq %edx,%rdx
   43101:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43105:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43109:	83 e0 06             	and    $0x6,%eax
   4310c:	48 f7 d0             	not    %rax
   4310f:	48 21 d0             	and    %rdx,%rax
   43112:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43116:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4311a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43120:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43124:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43128:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4312c:	7f 0c                	jg     4313a <virtual_memory_lookup+0x84>
   4312e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43132:	83 e0 01             	and    $0x1,%eax
   43135:	48 85 c0             	test   %rax,%rax
   43138:	75 ad                	jne    430e7 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   4313a:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43141:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   43148:	ff 
   43149:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   43150:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43154:	83 e0 01             	and    $0x1,%eax
   43157:	48 85 c0             	test   %rax,%rax
   4315a:	74 34                	je     43190 <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   4315c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43160:	48 c1 e8 0c          	shr    $0xc,%rax
   43164:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43167:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4316b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43171:	48 89 c2             	mov    %rax,%rdx
   43174:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43178:	25 ff 0f 00 00       	and    $0xfff,%eax
   4317d:	48 09 d0             	or     %rdx,%rax
   43180:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   43184:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43188:	25 ff 0f 00 00       	and    $0xfff,%eax
   4318d:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   43190:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43194:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43198:	48 89 10             	mov    %rdx,(%rax)
   4319b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   4319f:	48 89 50 08          	mov    %rdx,0x8(%rax)
   431a3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   431a7:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   431ab:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431af:	c9                   	leave  
   431b0:	c3                   	ret    

00000000000431b1 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   431b1:	f3 0f 1e fa          	endbr64 
   431b5:	55                   	push   %rbp
   431b6:	48 89 e5             	mov    %rsp,%rbp
   431b9:	48 83 ec 40          	sub    $0x40,%rsp
   431bd:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   431c1:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   431c4:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   431c8:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   431cf:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   431d3:	78 08                	js     431dd <program_load+0x2c>
   431d5:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   431d8:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   431db:	7c 1e                	jl     431fb <program_load+0x4a>
   431dd:	48 8d 05 7c 29 00 00 	lea    0x297c(%rip),%rax        # 45b60 <complex_keymap+0x520>
   431e4:	48 89 c2             	mov    %rax,%rdx
   431e7:	be 2e 00 00 00       	mov    $0x2e,%esi
   431ec:	48 8d 05 9d 29 00 00 	lea    0x299d(%rip),%rax        # 45b90 <complex_keymap+0x550>
   431f3:	48 89 c7             	mov    %rax,%rdi
   431f6:	e8 eb f6 ff ff       	call   428e6 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   431fb:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   431fe:	48 98                	cltq   
   43200:	48 c1 e0 04          	shl    $0x4,%rax
   43204:	48 89 c2             	mov    %rax,%rdx
   43207:	48 8d 05 12 2e 00 00 	lea    0x2e12(%rip),%rax        # 46020 <ramimages>
   4320e:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   43212:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43216:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4321a:	8b 00                	mov    (%rax),%eax
   4321c:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43221:	74 1e                	je     43241 <program_load+0x90>
   43223:	48 8d 05 78 29 00 00 	lea    0x2978(%rip),%rax        # 45ba2 <complex_keymap+0x562>
   4322a:	48 89 c2             	mov    %rax,%rdx
   4322d:	be 30 00 00 00       	mov    $0x30,%esi
   43232:	48 8d 05 57 29 00 00 	lea    0x2957(%rip),%rax        # 45b90 <complex_keymap+0x550>
   43239:	48 89 c7             	mov    %rax,%rdi
   4323c:	e8 a5 f6 ff ff       	call   428e6 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43241:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43245:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43249:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4324d:	48 01 d0             	add    %rdx,%rax
   43250:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4325b:	e9 94 00 00 00       	jmp    432f4 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43260:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43263:	48 63 d0             	movslq %eax,%rdx
   43266:	48 89 d0             	mov    %rdx,%rax
   43269:	48 c1 e0 03          	shl    $0x3,%rax
   4326d:	48 29 d0             	sub    %rdx,%rax
   43270:	48 c1 e0 03          	shl    $0x3,%rax
   43274:	48 89 c2             	mov    %rax,%rdx
   43277:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4327b:	48 01 d0             	add    %rdx,%rax
   4327e:	8b 00                	mov    (%rax),%eax
   43280:	83 f8 01             	cmp    $0x1,%eax
   43283:	75 6b                	jne    432f0 <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   43285:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43288:	48 63 d0             	movslq %eax,%rdx
   4328b:	48 89 d0             	mov    %rdx,%rax
   4328e:	48 c1 e0 03          	shl    $0x3,%rax
   43292:	48 29 d0             	sub    %rdx,%rax
   43295:	48 c1 e0 03          	shl    $0x3,%rax
   43299:	48 89 c2             	mov    %rax,%rdx
   4329c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432a0:	48 01 d0             	add    %rdx,%rax
   432a3:	48 8b 50 08          	mov    0x8(%rax),%rdx
   432a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ab:	48 01 d0             	add    %rdx,%rax
   432ae:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   432b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   432b5:	48 63 d0             	movslq %eax,%rdx
   432b8:	48 89 d0             	mov    %rdx,%rax
   432bb:	48 c1 e0 03          	shl    $0x3,%rax
   432bf:	48 29 d0             	sub    %rdx,%rax
   432c2:	48 c1 e0 03          	shl    $0x3,%rax
   432c6:	48 89 c2             	mov    %rax,%rdx
   432c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432cd:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   432d1:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   432d5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   432d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432dd:	48 89 c7             	mov    %rax,%rdi
   432e0:	e8 3d 00 00 00       	call   43322 <program_load_segment>
   432e5:	85 c0                	test   %eax,%eax
   432e7:	79 07                	jns    432f0 <program_load+0x13f>
                return -1;
   432e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   432ee:	eb 30                	jmp    43320 <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   432f0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   432f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432f8:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   432fc:	0f b7 c0             	movzwl %ax,%eax
   432ff:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43302:	0f 8c 58 ff ff ff    	jl     43260 <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   43308:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4330c:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43310:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43314:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   4331b:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43320:	c9                   	leave  
   43321:	c3                   	ret    

0000000000043322 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43322:	f3 0f 1e fa          	endbr64 
   43326:	55                   	push   %rbp
   43327:	48 89 e5             	mov    %rsp,%rbp
   4332a:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4332e:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   43332:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   43336:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   4333a:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4333e:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43342:	48 8b 40 10          	mov    0x10(%rax),%rax
   43346:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4334a:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   4334e:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43352:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43356:	48 01 d0             	add    %rdx,%rax
   43359:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4335d:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43361:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43365:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43369:	48 01 d0             	add    %rdx,%rax
   4336c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43370:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   43377:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43378:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4337c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43380:	e9 81 00 00 00       	jmp    43406 <program_load_segment+0xe4>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   43385:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43389:	8b 00                	mov    (%rax),%eax
   4338b:	89 c7                	mov    %eax,%edi
   4338d:	e8 a0 01 00 00       	call   43532 <palloc>
   43392:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   43396:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   4339b:	74 2a                	je     433c7 <program_load_segment+0xa5>
   4339d:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   433a1:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   433a8:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   433ac:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   433b0:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   433b6:	b9 00 10 00 00       	mov    $0x1000,%ecx
   433bb:	48 89 c7             	mov    %rax,%rdi
   433be:	e8 a7 f8 ff ff       	call   42c6a <virtual_memory_map>
   433c3:	85 c0                	test   %eax,%eax
   433c5:	79 37                	jns    433fe <program_load_segment+0xdc>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   433c7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   433cb:	8b 00                	mov    (%rax),%eax
   433cd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   433d1:	49 89 d0             	mov    %rdx,%r8
   433d4:	89 c1                	mov    %eax,%ecx
   433d6:	48 8d 05 e3 27 00 00 	lea    0x27e3(%rip),%rax        # 45bc0 <complex_keymap+0x580>
   433dd:	48 89 c2             	mov    %rax,%rdx
   433e0:	be 00 c0 00 00       	mov    $0xc000,%esi
   433e5:	bf e0 06 00 00       	mov    $0x6e0,%edi
   433ea:	b8 00 00 00 00       	mov    $0x0,%eax
   433ef:	e8 b7 1b 00 00       	call   44fab <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   433f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   433f9:	e9 32 01 00 00       	jmp    43530 <program_load_segment+0x20e>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   433fe:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43405:	00 
   43406:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4340a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4340e:	0f 82 71 ff ff ff    	jb     43385 <program_load_segment+0x63>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43414:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43418:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4341f:	48 89 c7             	mov    %rax,%rdi
   43422:	e8 d1 f6 ff ff       	call   42af8 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43427:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4342b:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4342f:	48 89 c2             	mov    %rax,%rdx
   43432:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43436:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4343a:	48 89 ce             	mov    %rcx,%rsi
   4343d:	48 89 c7             	mov    %rax,%rdi
   43440:	e8 21 0c 00 00       	call   44066 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43445:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43449:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4344d:	48 89 c2             	mov    %rax,%rdx
   43450:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43454:	be 00 00 00 00       	mov    $0x0,%esi
   43459:	48 89 c7             	mov    %rax,%rdi
   4345c:	e8 0b 0d 00 00       	call   4416c <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43461:	48 8b 05 98 eb 00 00 	mov    0xeb98(%rip),%rax        # 52000 <kernel_pagetable>
   43468:	48 89 c7             	mov    %rax,%rdi
   4346b:	e8 88 f6 ff ff       	call   42af8 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   43470:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43474:	8b 40 04             	mov    0x4(%rax),%eax
   43477:	83 e0 02             	and    $0x2,%eax
   4347a:	85 c0                	test   %eax,%eax
   4347c:	75 60                	jne    434de <program_load_segment+0x1bc>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4347e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43482:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43486:	eb 4c                	jmp    434d4 <program_load_segment+0x1b2>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   43488:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4348c:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   43493:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   43497:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4349b:	48 89 ce             	mov    %rcx,%rsi
   4349e:	48 89 c7             	mov    %rax,%rdi
   434a1:	e8 10 fc ff ff       	call   430b6 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   434a6:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   434aa:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   434ae:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   434b5:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   434b9:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   434bf:	b9 00 10 00 00       	mov    $0x1000,%ecx
   434c4:	48 89 c7             	mov    %rax,%rdi
   434c7:	e8 9e f7 ff ff       	call   42c6a <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   434cc:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   434d3:	00 
   434d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434d8:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   434dc:	72 aa                	jb     43488 <program_load_segment+0x166>
                    PTE_P | PTE_U);
        }
    }
    // get break to end of proc mem rounded to pagesize
    p->original_break = ROUNDUP(end_mem, PAGESIZE); 
   434de:	48 c7 45 d0 00 10 00 	movq   $0x1000,-0x30(%rbp)
   434e5:	00 
   434e6:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   434ea:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434ee:	48 01 d0             	add    %rdx,%rax
   434f1:	48 83 e8 01          	sub    $0x1,%rax
   434f5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   434f9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   434fd:	ba 00 00 00 00       	mov    $0x0,%edx
   43502:	48 f7 75 d0          	divq   -0x30(%rbp)
   43506:	48 89 d1             	mov    %rdx,%rcx
   43509:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4350d:	48 29 c8             	sub    %rcx,%rax
   43510:	48 89 c2             	mov    %rax,%rdx
   43513:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43517:	48 89 50 10          	mov    %rdx,0x10(%rax)
    p->program_break = p->original_break;
   4351b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4351f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43523:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43527:	48 89 50 08          	mov    %rdx,0x8(%rax)

    return 0;
   4352b:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43530:	c9                   	leave  
   43531:	c3                   	ret    

0000000000043532 <palloc>:
   43532:	55                   	push   %rbp
   43533:	48 89 e5             	mov    %rsp,%rbp
   43536:	48 83 ec 20          	sub    $0x20,%rsp
   4353a:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4353d:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43544:	00 
   43545:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43549:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4354d:	e9 95 00 00 00       	jmp    435e7 <palloc+0xb5>
   43552:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43556:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4355a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43561:	00 
   43562:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43566:	48 c1 e8 0c          	shr    $0xc,%rax
   4356a:	48 98                	cltq   
   4356c:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   43573:	00 
   43574:	84 c0                	test   %al,%al
   43576:	75 6f                	jne    435e7 <palloc+0xb5>
   43578:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4357c:	48 c1 e8 0c          	shr    $0xc,%rax
   43580:	48 98                	cltq   
   43582:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43589:	00 
   4358a:	84 c0                	test   %al,%al
   4358c:	75 59                	jne    435e7 <palloc+0xb5>
   4358e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43592:	48 c1 e8 0c          	shr    $0xc,%rax
   43596:	89 c2                	mov    %eax,%edx
   43598:	48 63 c2             	movslq %edx,%rax
   4359b:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   435a2:	00 
   435a3:	83 c0 01             	add    $0x1,%eax
   435a6:	89 c1                	mov    %eax,%ecx
   435a8:	48 63 c2             	movslq %edx,%rax
   435ab:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   435b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435b6:	48 c1 e8 0c          	shr    $0xc,%rax
   435ba:	89 c1                	mov    %eax,%ecx
   435bc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   435bf:	89 c2                	mov    %eax,%edx
   435c1:	48 63 c1             	movslq %ecx,%rax
   435c4:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
   435cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435cf:	ba 00 10 00 00       	mov    $0x1000,%edx
   435d4:	be cc 00 00 00       	mov    $0xcc,%esi
   435d9:	48 89 c7             	mov    %rax,%rdi
   435dc:	e8 8b 0b 00 00       	call   4416c <memset>
   435e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435e5:	eb 2c                	jmp    43613 <palloc+0xe1>
   435e7:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   435ee:	00 
   435ef:	0f 86 5d ff ff ff    	jbe    43552 <palloc+0x20>
   435f5:	ba f8 5b 04 00       	mov    $0x45bf8,%edx
   435fa:	be 00 0c 00 00       	mov    $0xc00,%esi
   435ff:	bf 80 07 00 00       	mov    $0x780,%edi
   43604:	b8 00 00 00 00       	mov    $0x0,%eax
   43609:	e8 9d 19 00 00       	call   44fab <console_printf>
   4360e:	b8 00 00 00 00       	mov    $0x0,%eax
   43613:	c9                   	leave  
   43614:	c3                   	ret    

0000000000043615 <palloc_target>:
   43615:	55                   	push   %rbp
   43616:	48 89 e5             	mov    %rsp,%rbp
   43619:	48 8b 05 e0 49 01 00 	mov    0x149e0(%rip),%rax        # 58000 <palloc_target_proc>
   43620:	48 85 c0             	test   %rax,%rax
   43623:	75 14                	jne    43639 <palloc_target+0x24>
   43625:	ba 11 5c 04 00       	mov    $0x45c11,%edx
   4362a:	be 27 00 00 00       	mov    $0x27,%esi
   4362f:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   43634:	e8 ad f2 ff ff       	call   428e6 <assert_fail>
   43639:	48 8b 05 c0 49 01 00 	mov    0x149c0(%rip),%rax        # 58000 <palloc_target_proc>
   43640:	8b 00                	mov    (%rax),%eax
   43642:	89 c7                	mov    %eax,%edi
   43644:	e8 e9 fe ff ff       	call   43532 <palloc>
   43649:	5d                   	pop    %rbp
   4364a:	c3                   	ret    

000000000004364b <process_free>:
   4364b:	55                   	push   %rbp
   4364c:	48 89 e5             	mov    %rsp,%rbp
   4364f:	48 83 ec 60          	sub    $0x60,%rsp
   43653:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43656:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43659:	48 63 d0             	movslq %eax,%rdx
   4365c:	48 89 d0             	mov    %rdx,%rax
   4365f:	48 c1 e0 04          	shl    $0x4,%rax
   43663:	48 29 d0             	sub    %rdx,%rax
   43666:	48 c1 e0 04          	shl    $0x4,%rax
   4366a:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43670:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43676:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   4367d:	00 
   4367e:	e9 ad 00 00 00       	jmp    43730 <process_free+0xe5>
   43683:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43686:	48 63 d0             	movslq %eax,%rdx
   43689:	48 89 d0             	mov    %rdx,%rax
   4368c:	48 c1 e0 04          	shl    $0x4,%rax
   43690:	48 29 d0             	sub    %rdx,%rax
   43693:	48 c1 e0 04          	shl    $0x4,%rax
   43697:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   4369d:	48 8b 08             	mov    (%rax),%rcx
   436a0:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   436a4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   436a8:	48 89 ce             	mov    %rcx,%rsi
   436ab:	48 89 c7             	mov    %rax,%rdi
   436ae:	e8 03 fa ff ff       	call   430b6 <virtual_memory_lookup>
   436b3:	8b 45 c8             	mov    -0x38(%rbp),%eax
   436b6:	48 98                	cltq   
   436b8:	83 e0 01             	and    $0x1,%eax
   436bb:	48 85 c0             	test   %rax,%rax
   436be:	74 68                	je     43728 <process_free+0xdd>
   436c0:	8b 45 b8             	mov    -0x48(%rbp),%eax
   436c3:	48 63 d0             	movslq %eax,%rdx
   436c6:	0f b6 94 12 21 ff 04 	movzbl 0x4ff21(%rdx,%rdx,1),%edx
   436cd:	00 
   436ce:	83 ea 01             	sub    $0x1,%edx
   436d1:	48 98                	cltq   
   436d3:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
   436da:	8b 45 b8             	mov    -0x48(%rbp),%eax
   436dd:	48 98                	cltq   
   436df:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   436e6:	00 
   436e7:	84 c0                	test   %al,%al
   436e9:	75 0f                	jne    436fa <process_free+0xaf>
   436eb:	8b 45 b8             	mov    -0x48(%rbp),%eax
   436ee:	48 98                	cltq   
   436f0:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   436f7:	00 
   436f8:	eb 2e                	jmp    43728 <process_free+0xdd>
   436fa:	8b 45 b8             	mov    -0x48(%rbp),%eax
   436fd:	48 98                	cltq   
   436ff:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   43706:	00 
   43707:	0f be c0             	movsbl %al,%eax
   4370a:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   4370d:	75 19                	jne    43728 <process_free+0xdd>
   4370f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43713:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43716:	48 89 c6             	mov    %rax,%rsi
   43719:	bf 38 5c 04 00       	mov    $0x45c38,%edi
   4371e:	b8 00 00 00 00       	mov    $0x0,%eax
   43723:	e8 63 ee ff ff       	call   4258b <log_printf>
   43728:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4372f:	00 
   43730:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43737:	00 
   43738:	0f 86 45 ff ff ff    	jbe    43683 <process_free+0x38>
   4373e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43741:	48 63 d0             	movslq %eax,%rdx
   43744:	48 89 d0             	mov    %rdx,%rax
   43747:	48 c1 e0 04          	shl    $0x4,%rax
   4374b:	48 29 d0             	sub    %rdx,%rax
   4374e:	48 c1 e0 04          	shl    $0x4,%rax
   43752:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43758:	48 8b 00             	mov    (%rax),%rax
   4375b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4375f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43763:	48 8b 00             	mov    (%rax),%rax
   43766:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4376c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43770:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43774:	48 8b 00             	mov    (%rax),%rax
   43777:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4377d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43781:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43785:	48 8b 00             	mov    (%rax),%rax
   43788:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4378e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43792:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43796:	48 8b 40 08          	mov    0x8(%rax),%rax
   4379a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   437a0:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   437a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437a8:	48 c1 e8 0c          	shr    $0xc,%rax
   437ac:	48 98                	cltq   
   437ae:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   437b5:	00 
   437b6:	3c 01                	cmp    $0x1,%al
   437b8:	74 14                	je     437ce <process_free+0x183>
   437ba:	ba 70 5c 04 00       	mov    $0x45c70,%edx
   437bf:	be 4f 00 00 00       	mov    $0x4f,%esi
   437c4:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   437c9:	e8 18 f1 ff ff       	call   428e6 <assert_fail>
   437ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437d2:	48 c1 e8 0c          	shr    $0xc,%rax
   437d6:	48 98                	cltq   
   437d8:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   437df:	00 
   437e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437e4:	48 c1 e8 0c          	shr    $0xc,%rax
   437e8:	48 98                	cltq   
   437ea:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   437f1:	00 
   437f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437f6:	48 c1 e8 0c          	shr    $0xc,%rax
   437fa:	48 98                	cltq   
   437fc:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43803:	00 
   43804:	3c 01                	cmp    $0x1,%al
   43806:	74 14                	je     4381c <process_free+0x1d1>
   43808:	ba 98 5c 04 00       	mov    $0x45c98,%edx
   4380d:	be 52 00 00 00       	mov    $0x52,%esi
   43812:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   43817:	e8 ca f0 ff ff       	call   428e6 <assert_fail>
   4381c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43820:	48 c1 e8 0c          	shr    $0xc,%rax
   43824:	48 98                	cltq   
   43826:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4382d:	00 
   4382e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43832:	48 c1 e8 0c          	shr    $0xc,%rax
   43836:	48 98                	cltq   
   43838:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4383f:	00 
   43840:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43844:	48 c1 e8 0c          	shr    $0xc,%rax
   43848:	48 98                	cltq   
   4384a:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43851:	00 
   43852:	3c 01                	cmp    $0x1,%al
   43854:	74 14                	je     4386a <process_free+0x21f>
   43856:	ba c0 5c 04 00       	mov    $0x45cc0,%edx
   4385b:	be 55 00 00 00       	mov    $0x55,%esi
   43860:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   43865:	e8 7c f0 ff ff       	call   428e6 <assert_fail>
   4386a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4386e:	48 c1 e8 0c          	shr    $0xc,%rax
   43872:	48 98                	cltq   
   43874:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4387b:	00 
   4387c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43880:	48 c1 e8 0c          	shr    $0xc,%rax
   43884:	48 98                	cltq   
   43886:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4388d:	00 
   4388e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43892:	48 c1 e8 0c          	shr    $0xc,%rax
   43896:	48 98                	cltq   
   43898:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4389f:	00 
   438a0:	3c 01                	cmp    $0x1,%al
   438a2:	74 14                	je     438b8 <process_free+0x26d>
   438a4:	ba e8 5c 04 00       	mov    $0x45ce8,%edx
   438a9:	be 58 00 00 00       	mov    $0x58,%esi
   438ae:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   438b3:	e8 2e f0 ff ff       	call   428e6 <assert_fail>
   438b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438bc:	48 c1 e8 0c          	shr    $0xc,%rax
   438c0:	48 98                	cltq   
   438c2:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   438c9:	00 
   438ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438ce:	48 c1 e8 0c          	shr    $0xc,%rax
   438d2:	48 98                	cltq   
   438d4:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   438db:	00 
   438dc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   438e0:	48 c1 e8 0c          	shr    $0xc,%rax
   438e4:	48 98                	cltq   
   438e6:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   438ed:	00 
   438ee:	3c 01                	cmp    $0x1,%al
   438f0:	74 14                	je     43906 <process_free+0x2bb>
   438f2:	ba 10 5d 04 00       	mov    $0x45d10,%edx
   438f7:	be 5b 00 00 00       	mov    $0x5b,%esi
   438fc:	bf 2c 5c 04 00       	mov    $0x45c2c,%edi
   43901:	e8 e0 ef ff ff       	call   428e6 <assert_fail>
   43906:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4390a:	48 c1 e8 0c          	shr    $0xc,%rax
   4390e:	48 98                	cltq   
   43910:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43917:	00 
   43918:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4391c:	48 c1 e8 0c          	shr    $0xc,%rax
   43920:	48 98                	cltq   
   43922:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43929:	00 
   4392a:	90                   	nop
   4392b:	c9                   	leave  
   4392c:	c3                   	ret    

000000000004392d <process_config_tables>:
   4392d:	55                   	push   %rbp
   4392e:	48 89 e5             	mov    %rsp,%rbp
   43931:	48 83 ec 40          	sub    $0x40,%rsp
   43935:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43938:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4393b:	89 c7                	mov    %eax,%edi
   4393d:	e8 f0 fb ff ff       	call   43532 <palloc>
   43942:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43946:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43949:	89 c7                	mov    %eax,%edi
   4394b:	e8 e2 fb ff ff       	call   43532 <palloc>
   43950:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43954:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43957:	89 c7                	mov    %eax,%edi
   43959:	e8 d4 fb ff ff       	call   43532 <palloc>
   4395e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43962:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43965:	89 c7                	mov    %eax,%edi
   43967:	e8 c6 fb ff ff       	call   43532 <palloc>
   4396c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43970:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43973:	89 c7                	mov    %eax,%edi
   43975:	e8 b8 fb ff ff       	call   43532 <palloc>
   4397a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4397e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43983:	74 20                	je     439a5 <process_config_tables+0x78>
   43985:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4398a:	74 19                	je     439a5 <process_config_tables+0x78>
   4398c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43991:	74 12                	je     439a5 <process_config_tables+0x78>
   43993:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43998:	74 0b                	je     439a5 <process_config_tables+0x78>
   4399a:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4399f:	0f 85 e1 00 00 00    	jne    43a86 <process_config_tables+0x159>
   439a5:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   439aa:	74 24                	je     439d0 <process_config_tables+0xa3>
   439ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   439b0:	48 c1 e8 0c          	shr    $0xc,%rax
   439b4:	48 98                	cltq   
   439b6:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   439bd:	00 
   439be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   439c2:	48 c1 e8 0c          	shr    $0xc,%rax
   439c6:	48 98                	cltq   
   439c8:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   439cf:	00 
   439d0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   439d5:	74 24                	je     439fb <process_config_tables+0xce>
   439d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   439db:	48 c1 e8 0c          	shr    $0xc,%rax
   439df:	48 98                	cltq   
   439e1:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   439e8:	00 
   439e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   439ed:	48 c1 e8 0c          	shr    $0xc,%rax
   439f1:	48 98                	cltq   
   439f3:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   439fa:	00 
   439fb:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43a00:	74 24                	je     43a26 <process_config_tables+0xf9>
   43a02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a06:	48 c1 e8 0c          	shr    $0xc,%rax
   43a0a:	48 98                	cltq   
   43a0c:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43a13:	00 
   43a14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a18:	48 c1 e8 0c          	shr    $0xc,%rax
   43a1c:	48 98                	cltq   
   43a1e:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43a25:	00 
   43a26:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43a2b:	74 24                	je     43a51 <process_config_tables+0x124>
   43a2d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a31:	48 c1 e8 0c          	shr    $0xc,%rax
   43a35:	48 98                	cltq   
   43a37:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43a3e:	00 
   43a3f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a43:	48 c1 e8 0c          	shr    $0xc,%rax
   43a47:	48 98                	cltq   
   43a49:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43a50:	00 
   43a51:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43a56:	74 24                	je     43a7c <process_config_tables+0x14f>
   43a58:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a5c:	48 c1 e8 0c          	shr    $0xc,%rax
   43a60:	48 98                	cltq   
   43a62:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43a69:	00 
   43a6a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a6e:	48 c1 e8 0c          	shr    $0xc,%rax
   43a72:	48 98                	cltq   
   43a74:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43a7b:	00 
   43a7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a81:	e9 f3 01 00 00       	jmp    43c79 <process_config_tables+0x34c>
   43a86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a8a:	ba 00 10 00 00       	mov    $0x1000,%edx
   43a8f:	be 00 00 00 00       	mov    $0x0,%esi
   43a94:	48 89 c7             	mov    %rax,%rdi
   43a97:	e8 d0 06 00 00       	call   4416c <memset>
   43a9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43aa0:	ba 00 10 00 00       	mov    $0x1000,%edx
   43aa5:	be 00 00 00 00       	mov    $0x0,%esi
   43aaa:	48 89 c7             	mov    %rax,%rdi
   43aad:	e8 ba 06 00 00       	call   4416c <memset>
   43ab2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ab6:	ba 00 10 00 00       	mov    $0x1000,%edx
   43abb:	be 00 00 00 00       	mov    $0x0,%esi
   43ac0:	48 89 c7             	mov    %rax,%rdi
   43ac3:	e8 a4 06 00 00       	call   4416c <memset>
   43ac8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43acc:	ba 00 10 00 00       	mov    $0x1000,%edx
   43ad1:	be 00 00 00 00       	mov    $0x0,%esi
   43ad6:	48 89 c7             	mov    %rax,%rdi
   43ad9:	e8 8e 06 00 00       	call   4416c <memset>
   43ade:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43ae2:	ba 00 10 00 00       	mov    $0x1000,%edx
   43ae7:	be 00 00 00 00       	mov    $0x0,%esi
   43aec:	48 89 c7             	mov    %rax,%rdi
   43aef:	e8 78 06 00 00       	call   4416c <memset>
   43af4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43af8:	48 83 c8 07          	or     $0x7,%rax
   43afc:	48 89 c2             	mov    %rax,%rdx
   43aff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b03:	48 89 10             	mov    %rdx,(%rax)
   43b06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b0a:	48 83 c8 07          	or     $0x7,%rax
   43b0e:	48 89 c2             	mov    %rax,%rdx
   43b11:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b15:	48 89 10             	mov    %rdx,(%rax)
   43b18:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43b1c:	48 83 c8 07          	or     $0x7,%rax
   43b20:	48 89 c2             	mov    %rax,%rdx
   43b23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b27:	48 89 10             	mov    %rdx,(%rax)
   43b2a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b2e:	48 83 c8 07          	or     $0x7,%rax
   43b32:	48 89 c2             	mov    %rax,%rdx
   43b35:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b39:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43b3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b41:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43b47:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   43b4d:	b9 00 00 10 00       	mov    $0x100000,%ecx
   43b52:	ba 00 00 00 00       	mov    $0x0,%edx
   43b57:	be 00 00 00 00       	mov    $0x0,%esi
   43b5c:	48 89 c7             	mov    %rax,%rdi
   43b5f:	e8 06 f1 ff ff       	call   42c6a <virtual_memory_map>
   43b64:	85 c0                	test   %eax,%eax
   43b66:	75 2f                	jne    43b97 <process_config_tables+0x26a>
   43b68:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   43b6d:	be 00 80 0b 00       	mov    $0xb8000,%esi
   43b72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b76:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43b7c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43b82:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43b87:	48 89 c7             	mov    %rax,%rdi
   43b8a:	e8 db f0 ff ff       	call   42c6a <virtual_memory_map>
   43b8f:	85 c0                	test   %eax,%eax
   43b91:	0f 84 bb 00 00 00    	je     43c52 <process_config_tables+0x325>
   43b97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b9b:	48 c1 e8 0c          	shr    $0xc,%rax
   43b9f:	48 98                	cltq   
   43ba1:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43ba8:	00 
   43ba9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bad:	48 c1 e8 0c          	shr    $0xc,%rax
   43bb1:	48 98                	cltq   
   43bb3:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43bba:	00 
   43bbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bbf:	48 c1 e8 0c          	shr    $0xc,%rax
   43bc3:	48 98                	cltq   
   43bc5:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43bcc:	00 
   43bcd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bd1:	48 c1 e8 0c          	shr    $0xc,%rax
   43bd5:	48 98                	cltq   
   43bd7:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43bde:	00 
   43bdf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43be3:	48 c1 e8 0c          	shr    $0xc,%rax
   43be7:	48 98                	cltq   
   43be9:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43bf0:	00 
   43bf1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bf5:	48 c1 e8 0c          	shr    $0xc,%rax
   43bf9:	48 98                	cltq   
   43bfb:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43c02:	00 
   43c03:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c07:	48 c1 e8 0c          	shr    $0xc,%rax
   43c0b:	48 98                	cltq   
   43c0d:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43c14:	00 
   43c15:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c19:	48 c1 e8 0c          	shr    $0xc,%rax
   43c1d:	48 98                	cltq   
   43c1f:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43c26:	00 
   43c27:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c2b:	48 c1 e8 0c          	shr    $0xc,%rax
   43c2f:	48 98                	cltq   
   43c31:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43c38:	00 
   43c39:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c3d:	48 c1 e8 0c          	shr    $0xc,%rax
   43c41:	48 98                	cltq   
   43c43:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43c4a:	00 
   43c4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43c50:	eb 27                	jmp    43c79 <process_config_tables+0x34c>
   43c52:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43c55:	48 63 d0             	movslq %eax,%rdx
   43c58:	48 89 d0             	mov    %rdx,%rax
   43c5b:	48 c1 e0 04          	shl    $0x4,%rax
   43c5f:	48 29 d0             	sub    %rdx,%rax
   43c62:	48 c1 e0 04          	shl    $0x4,%rax
   43c66:	48 8d 90 e0 f0 04 00 	lea    0x4f0e0(%rax),%rdx
   43c6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c71:	48 89 02             	mov    %rax,(%rdx)
   43c74:	b8 00 00 00 00       	mov    $0x0,%eax
   43c79:	c9                   	leave  
   43c7a:	c3                   	ret    

0000000000043c7b <process_load>:
   43c7b:	55                   	push   %rbp
   43c7c:	48 89 e5             	mov    %rsp,%rbp
   43c7f:	48 83 ec 20          	sub    $0x20,%rsp
   43c83:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c87:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43c8a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c8e:	48 89 05 6b 43 01 00 	mov    %rax,0x1436b(%rip)        # 58000 <palloc_target_proc>
   43c95:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   43c98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c9c:	ba 15 36 04 00       	mov    $0x43615,%edx
   43ca1:	89 ce                	mov    %ecx,%esi
   43ca3:	48 89 c7             	mov    %rax,%rdi
   43ca6:	e8 06 f5 ff ff       	call   431b1 <program_load>
   43cab:	89 45 fc             	mov    %eax,-0x4(%rbp)
   43cae:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43cb1:	c9                   	leave  
   43cb2:	c3                   	ret    

0000000000043cb3 <process_setup_stack>:
   43cb3:	55                   	push   %rbp
   43cb4:	48 89 e5             	mov    %rsp,%rbp
   43cb7:	48 83 ec 20          	sub    $0x20,%rsp
   43cbb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43cbf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cc3:	8b 00                	mov    (%rax),%eax
   43cc5:	89 c7                	mov    %eax,%edi
   43cc7:	e8 66 f8 ff ff       	call   43532 <palloc>
   43ccc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43cd0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cd4:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   43cdb:	00 00 30 00 
   43cdf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ce3:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43cea:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43cee:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43cf4:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43cfa:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43cff:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   43d04:	48 89 c7             	mov    %rax,%rdi
   43d07:	e8 5e ef ff ff       	call   42c6a <virtual_memory_map>
   43d0c:	90                   	nop
   43d0d:	c9                   	leave  
   43d0e:	c3                   	ret    

0000000000043d0f <find_free_pid>:
   43d0f:	55                   	push   %rbp
   43d10:	48 89 e5             	mov    %rsp,%rbp
   43d13:	48 83 ec 10          	sub    $0x10,%rsp
   43d17:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43d1e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   43d25:	eb 24                	jmp    43d4b <find_free_pid+0x3c>
   43d27:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43d2a:	48 63 d0             	movslq %eax,%rdx
   43d2d:	48 89 d0             	mov    %rdx,%rax
   43d30:	48 c1 e0 04          	shl    $0x4,%rax
   43d34:	48 29 d0             	sub    %rdx,%rax
   43d37:	48 c1 e0 04          	shl    $0x4,%rax
   43d3b:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43d41:	8b 00                	mov    (%rax),%eax
   43d43:	85 c0                	test   %eax,%eax
   43d45:	74 0c                	je     43d53 <find_free_pid+0x44>
   43d47:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43d4b:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   43d4f:	7e d6                	jle    43d27 <find_free_pid+0x18>
   43d51:	eb 01                	jmp    43d54 <find_free_pid+0x45>
   43d53:	90                   	nop
   43d54:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   43d58:	74 05                	je     43d5f <find_free_pid+0x50>
   43d5a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43d5d:	eb 05                	jmp    43d64 <find_free_pid+0x55>
   43d5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43d64:	c9                   	leave  
   43d65:	c3                   	ret    

0000000000043d66 <process_fork>:
   43d66:	55                   	push   %rbp
   43d67:	48 89 e5             	mov    %rsp,%rbp
   43d6a:	48 83 ec 40          	sub    $0x40,%rsp
   43d6e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43d72:	b8 00 00 00 00       	mov    $0x0,%eax
   43d77:	e8 93 ff ff ff       	call   43d0f <find_free_pid>
   43d7c:	89 45 f4             	mov    %eax,-0xc(%rbp)
   43d7f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   43d83:	75 0a                	jne    43d8f <process_fork+0x29>
   43d85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43d8a:	e9 67 02 00 00       	jmp    43ff6 <process_fork+0x290>
   43d8f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43d92:	48 63 d0             	movslq %eax,%rdx
   43d95:	48 89 d0             	mov    %rdx,%rax
   43d98:	48 c1 e0 04          	shl    $0x4,%rax
   43d9c:	48 29 d0             	sub    %rdx,%rax
   43d9f:	48 c1 e0 04          	shl    $0x4,%rax
   43da3:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   43da9:	be 00 00 00 00       	mov    $0x0,%esi
   43dae:	48 89 c7             	mov    %rax,%rdi
   43db1:	e8 fa e2 ff ff       	call   420b0 <process_init>
   43db6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43db9:	89 c7                	mov    %eax,%edi
   43dbb:	e8 6d fb ff ff       	call   4392d <process_config_tables>
   43dc0:	83 f8 ff             	cmp    $0xffffffff,%eax
   43dc3:	75 0a                	jne    43dcf <process_fork+0x69>
   43dc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43dca:	e9 27 02 00 00       	jmp    43ff6 <process_fork+0x290>
   43dcf:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43dd6:	00 
   43dd7:	e9 79 01 00 00       	jmp    43f55 <process_fork+0x1ef>
   43ddc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43de0:	8b 00                	mov    (%rax),%eax
   43de2:	48 63 d0             	movslq %eax,%rdx
   43de5:	48 89 d0             	mov    %rdx,%rax
   43de8:	48 c1 e0 04          	shl    $0x4,%rax
   43dec:	48 29 d0             	sub    %rdx,%rax
   43def:	48 c1 e0 04          	shl    $0x4,%rax
   43df3:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43df9:	48 8b 08             	mov    (%rax),%rcx
   43dfc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43e00:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43e04:	48 89 ce             	mov    %rcx,%rsi
   43e07:	48 89 c7             	mov    %rax,%rdi
   43e0a:	e8 a7 f2 ff ff       	call   430b6 <virtual_memory_lookup>
   43e0f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43e12:	48 98                	cltq   
   43e14:	83 e0 07             	and    $0x7,%eax
   43e17:	48 83 f8 07          	cmp    $0x7,%rax
   43e1b:	0f 85 a1 00 00 00    	jne    43ec2 <process_fork+0x15c>
   43e21:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43e24:	89 c7                	mov    %eax,%edi
   43e26:	e8 07 f7 ff ff       	call   43532 <palloc>
   43e2b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43e2f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43e34:	75 14                	jne    43e4a <process_fork+0xe4>
   43e36:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43e39:	89 c7                	mov    %eax,%edi
   43e3b:	e8 0b f8 ff ff       	call   4364b <process_free>
   43e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43e45:	e9 ac 01 00 00       	jmp    43ff6 <process_fork+0x290>
   43e4a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e4e:	48 89 c1             	mov    %rax,%rcx
   43e51:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e55:	ba 00 10 00 00       	mov    $0x1000,%edx
   43e5a:	48 89 ce             	mov    %rcx,%rsi
   43e5d:	48 89 c7             	mov    %rax,%rdi
   43e60:	e8 01 02 00 00       	call   44066 <memcpy>
   43e65:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   43e69:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43e6c:	48 63 d0             	movslq %eax,%rdx
   43e6f:	48 89 d0             	mov    %rdx,%rax
   43e72:	48 c1 e0 04          	shl    $0x4,%rax
   43e76:	48 29 d0             	sub    %rdx,%rax
   43e79:	48 c1 e0 04          	shl    $0x4,%rax
   43e7d:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43e83:	48 8b 00             	mov    (%rax),%rax
   43e86:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43e8a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43e90:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43e96:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43e9b:	48 89 fa             	mov    %rdi,%rdx
   43e9e:	48 89 c7             	mov    %rax,%rdi
   43ea1:	e8 c4 ed ff ff       	call   42c6a <virtual_memory_map>
   43ea6:	85 c0                	test   %eax,%eax
   43ea8:	0f 84 9f 00 00 00    	je     43f4d <process_fork+0x1e7>
   43eae:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43eb1:	89 c7                	mov    %eax,%edi
   43eb3:	e8 93 f7 ff ff       	call   4364b <process_free>
   43eb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43ebd:	e9 34 01 00 00       	jmp    43ff6 <process_fork+0x290>
   43ec2:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43ec5:	48 98                	cltq   
   43ec7:	83 e0 05             	and    $0x5,%eax
   43eca:	48 83 f8 05          	cmp    $0x5,%rax
   43ece:	75 7d                	jne    43f4d <process_fork+0x1e7>
   43ed0:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43ed4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ed7:	48 63 d0             	movslq %eax,%rdx
   43eda:	48 89 d0             	mov    %rdx,%rax
   43edd:	48 c1 e0 04          	shl    $0x4,%rax
   43ee1:	48 29 d0             	sub    %rdx,%rax
   43ee4:	48 c1 e0 04          	shl    $0x4,%rax
   43ee8:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43eee:	48 8b 00             	mov    (%rax),%rax
   43ef1:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43ef5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43efb:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43f01:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43f06:	48 89 fa             	mov    %rdi,%rdx
   43f09:	48 89 c7             	mov    %rax,%rdi
   43f0c:	e8 59 ed ff ff       	call   42c6a <virtual_memory_map>
   43f11:	85 c0                	test   %eax,%eax
   43f13:	74 14                	je     43f29 <process_fork+0x1c3>
   43f15:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43f18:	89 c7                	mov    %eax,%edi
   43f1a:	e8 2c f7 ff ff       	call   4364b <process_free>
   43f1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43f24:	e9 cd 00 00 00       	jmp    43ff6 <process_fork+0x290>
   43f29:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43f2d:	48 c1 e8 0c          	shr    $0xc,%rax
   43f31:	89 c2                	mov    %eax,%edx
   43f33:	48 63 c2             	movslq %edx,%rax
   43f36:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43f3d:	00 
   43f3e:	83 c0 01             	add    $0x1,%eax
   43f41:	89 c1                	mov    %eax,%ecx
   43f43:	48 63 c2             	movslq %edx,%rax
   43f46:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   43f4d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43f54:	00 
   43f55:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43f5c:	00 
   43f5d:	0f 86 79 fe ff ff    	jbe    43ddc <process_fork+0x76>
   43f63:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43f67:	8b 08                	mov    (%rax),%ecx
   43f69:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43f6c:	48 63 d0             	movslq %eax,%rdx
   43f6f:	48 89 d0             	mov    %rdx,%rax
   43f72:	48 c1 e0 04          	shl    $0x4,%rax
   43f76:	48 29 d0             	sub    %rdx,%rax
   43f79:	48 c1 e0 04          	shl    $0x4,%rax
   43f7d:	48 8d b0 10 f0 04 00 	lea    0x4f010(%rax),%rsi
   43f84:	48 63 d1             	movslq %ecx,%rdx
   43f87:	48 89 d0             	mov    %rdx,%rax
   43f8a:	48 c1 e0 04          	shl    $0x4,%rax
   43f8e:	48 29 d0             	sub    %rdx,%rax
   43f91:	48 c1 e0 04          	shl    $0x4,%rax
   43f95:	48 8d 90 10 f0 04 00 	lea    0x4f010(%rax),%rdx
   43f9c:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43fa0:	48 83 c2 08          	add    $0x8,%rdx
   43fa4:	b9 18 00 00 00       	mov    $0x18,%ecx
   43fa9:	48 89 c7             	mov    %rax,%rdi
   43fac:	48 89 d6             	mov    %rdx,%rsi
   43faf:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43fb2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43fb5:	48 63 d0             	movslq %eax,%rdx
   43fb8:	48 89 d0             	mov    %rdx,%rax
   43fbb:	48 c1 e0 04          	shl    $0x4,%rax
   43fbf:	48 29 d0             	sub    %rdx,%rax
   43fc2:	48 c1 e0 04          	shl    $0x4,%rax
   43fc6:	48 05 18 f0 04 00    	add    $0x4f018,%rax
   43fcc:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43fd3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43fd6:	48 63 d0             	movslq %eax,%rdx
   43fd9:	48 89 d0             	mov    %rdx,%rax
   43fdc:	48 c1 e0 04          	shl    $0x4,%rax
   43fe0:	48 29 d0             	sub    %rdx,%rax
   43fe3:	48 c1 e0 04          	shl    $0x4,%rax
   43fe7:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43fed:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43ff3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ff6:	c9                   	leave  
   43ff7:	c3                   	ret    

0000000000043ff8 <process_page_alloc>:
   43ff8:	55                   	push   %rbp
   43ff9:	48 89 e5             	mov    %rsp,%rbp
   43ffc:	48 83 ec 20          	sub    $0x20,%rsp
   44000:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44004:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   44008:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   4400f:	00 
   44010:	77 07                	ja     44019 <process_page_alloc+0x21>
   44012:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44017:	eb 4b                	jmp    44064 <process_page_alloc+0x6c>
   44019:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4401d:	8b 00                	mov    (%rax),%eax
   4401f:	89 c7                	mov    %eax,%edi
   44021:	e8 0c f5 ff ff       	call   43532 <palloc>
   44026:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4402a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4402f:	74 2e                	je     4405f <process_page_alloc+0x67>
   44031:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44035:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44039:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   44040:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   44044:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4404a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   44050:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44055:	48 89 c7             	mov    %rax,%rdi
   44058:	e8 0d ec ff ff       	call   42c6a <virtual_memory_map>
   4405d:	eb 05                	jmp    44064 <process_page_alloc+0x6c>
   4405f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44064:	c9                   	leave  
   44065:	c3                   	ret    

0000000000044066 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   44066:	f3 0f 1e fa          	endbr64 
   4406a:	55                   	push   %rbp
   4406b:	48 89 e5             	mov    %rsp,%rbp
   4406e:	48 83 ec 28          	sub    $0x28,%rsp
   44072:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44076:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4407a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   4407e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44082:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   44086:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4408a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4408e:	eb 1c                	jmp    440ac <memcpy+0x46>
        *d = *s;
   44090:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44094:	0f b6 10             	movzbl (%rax),%edx
   44097:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4409b:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4409d:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   440a2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   440a7:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   440ac:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   440b1:	75 dd                	jne    44090 <memcpy+0x2a>
    }
    return dst;
   440b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   440b7:	c9                   	leave  
   440b8:	c3                   	ret    

00000000000440b9 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   440b9:	f3 0f 1e fa          	endbr64 
   440bd:	55                   	push   %rbp
   440be:	48 89 e5             	mov    %rsp,%rbp
   440c1:	48 83 ec 28          	sub    $0x28,%rsp
   440c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   440c9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   440cd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   440d1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   440d5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   440d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   440dd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   440e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440e5:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   440e9:	73 6a                	jae    44155 <memmove+0x9c>
   440eb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   440ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   440f3:	48 01 d0             	add    %rdx,%rax
   440f6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   440fa:	73 59                	jae    44155 <memmove+0x9c>
        s += n, d += n;
   440fc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44100:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   44104:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44108:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   4410c:	eb 17                	jmp    44125 <memmove+0x6c>
            *--d = *--s;
   4410e:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   44113:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   44118:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4411c:	0f b6 10             	movzbl (%rax),%edx
   4411f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44123:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   44125:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44129:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4412d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   44131:	48 85 c0             	test   %rax,%rax
   44134:	75 d8                	jne    4410e <memmove+0x55>
    if (s < d && s + n > d) {
   44136:	eb 2e                	jmp    44166 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   44138:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4413c:	48 8d 42 01          	lea    0x1(%rdx),%rax
   44140:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44144:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44148:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4414c:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   44150:	0f b6 12             	movzbl (%rdx),%edx
   44153:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   44155:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44159:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4415d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   44161:	48 85 c0             	test   %rax,%rax
   44164:	75 d2                	jne    44138 <memmove+0x7f>
        }
    }
    return dst;
   44166:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4416a:	c9                   	leave  
   4416b:	c3                   	ret    

000000000004416c <memset>:

void* memset(void* v, int c, size_t n) {
   4416c:	f3 0f 1e fa          	endbr64 
   44170:	55                   	push   %rbp
   44171:	48 89 e5             	mov    %rsp,%rbp
   44174:	48 83 ec 28          	sub    $0x28,%rsp
   44178:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4417c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4417f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   44183:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44187:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4418b:	eb 15                	jmp    441a2 <memset+0x36>
        *p = c;
   4418d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44190:	89 c2                	mov    %eax,%edx
   44192:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44196:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   44198:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4419d:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   441a2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   441a7:	75 e4                	jne    4418d <memset+0x21>
    }
    return v;
   441a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   441ad:	c9                   	leave  
   441ae:	c3                   	ret    

00000000000441af <strlen>:

size_t strlen(const char* s) {
   441af:	f3 0f 1e fa          	endbr64 
   441b3:	55                   	push   %rbp
   441b4:	48 89 e5             	mov    %rsp,%rbp
   441b7:	48 83 ec 18          	sub    $0x18,%rsp
   441bb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   441bf:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   441c6:	00 
   441c7:	eb 0a                	jmp    441d3 <strlen+0x24>
        ++n;
   441c9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   441ce:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   441d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   441d7:	0f b6 00             	movzbl (%rax),%eax
   441da:	84 c0                	test   %al,%al
   441dc:	75 eb                	jne    441c9 <strlen+0x1a>
    }
    return n;
   441de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   441e2:	c9                   	leave  
   441e3:	c3                   	ret    

00000000000441e4 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   441e4:	f3 0f 1e fa          	endbr64 
   441e8:	55                   	push   %rbp
   441e9:	48 89 e5             	mov    %rsp,%rbp
   441ec:	48 83 ec 20          	sub    $0x20,%rsp
   441f0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   441f4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   441f8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   441ff:	00 
   44200:	eb 0a                	jmp    4420c <strnlen+0x28>
        ++n;
   44202:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   44207:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4420c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44210:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   44214:	74 0b                	je     44221 <strnlen+0x3d>
   44216:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4421a:	0f b6 00             	movzbl (%rax),%eax
   4421d:	84 c0                	test   %al,%al
   4421f:	75 e1                	jne    44202 <strnlen+0x1e>
    }
    return n;
   44221:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   44225:	c9                   	leave  
   44226:	c3                   	ret    

0000000000044227 <strcpy>:

char* strcpy(char* dst, const char* src) {
   44227:	f3 0f 1e fa          	endbr64 
   4422b:	55                   	push   %rbp
   4422c:	48 89 e5             	mov    %rsp,%rbp
   4422f:	48 83 ec 20          	sub    $0x20,%rsp
   44233:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44237:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   4423b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4423f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   44243:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44247:	48 8d 42 01          	lea    0x1(%rdx),%rax
   4424b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4424f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44253:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44257:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   4425b:	0f b6 12             	movzbl (%rdx),%edx
   4425e:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   44260:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44264:	48 83 e8 01          	sub    $0x1,%rax
   44268:	0f b6 00             	movzbl (%rax),%eax
   4426b:	84 c0                	test   %al,%al
   4426d:	75 d4                	jne    44243 <strcpy+0x1c>
    return dst;
   4426f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   44273:	c9                   	leave  
   44274:	c3                   	ret    

0000000000044275 <strcmp>:

int strcmp(const char* a, const char* b) {
   44275:	f3 0f 1e fa          	endbr64 
   44279:	55                   	push   %rbp
   4427a:	48 89 e5             	mov    %rsp,%rbp
   4427d:	48 83 ec 10          	sub    $0x10,%rsp
   44281:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   44285:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   44289:	eb 0a                	jmp    44295 <strcmp+0x20>
        ++a, ++b;
   4428b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   44290:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   44295:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44299:	0f b6 00             	movzbl (%rax),%eax
   4429c:	84 c0                	test   %al,%al
   4429e:	74 1d                	je     442bd <strcmp+0x48>
   442a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442a4:	0f b6 00             	movzbl (%rax),%eax
   442a7:	84 c0                	test   %al,%al
   442a9:	74 12                	je     442bd <strcmp+0x48>
   442ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442af:	0f b6 10             	movzbl (%rax),%edx
   442b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442b6:	0f b6 00             	movzbl (%rax),%eax
   442b9:	38 c2                	cmp    %al,%dl
   442bb:	74 ce                	je     4428b <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   442bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442c1:	0f b6 00             	movzbl (%rax),%eax
   442c4:	89 c2                	mov    %eax,%edx
   442c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442ca:	0f b6 00             	movzbl (%rax),%eax
   442cd:	38 c2                	cmp    %al,%dl
   442cf:	0f 97 c0             	seta   %al
   442d2:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   442d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   442d9:	0f b6 00             	movzbl (%rax),%eax
   442dc:	89 c1                	mov    %eax,%ecx
   442de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442e2:	0f b6 00             	movzbl (%rax),%eax
   442e5:	38 c1                	cmp    %al,%cl
   442e7:	0f 92 c0             	setb   %al
   442ea:	0f b6 c8             	movzbl %al,%ecx
   442ed:	89 d0                	mov    %edx,%eax
   442ef:	29 c8                	sub    %ecx,%eax
}
   442f1:	c9                   	leave  
   442f2:	c3                   	ret    

00000000000442f3 <strchr>:

char* strchr(const char* s, int c) {
   442f3:	f3 0f 1e fa          	endbr64 
   442f7:	55                   	push   %rbp
   442f8:	48 89 e5             	mov    %rsp,%rbp
   442fb:	48 83 ec 10          	sub    $0x10,%rsp
   442ff:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   44303:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   44306:	eb 05                	jmp    4430d <strchr+0x1a>
        ++s;
   44308:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   4430d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44311:	0f b6 00             	movzbl (%rax),%eax
   44314:	84 c0                	test   %al,%al
   44316:	74 0e                	je     44326 <strchr+0x33>
   44318:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4431c:	0f b6 00             	movzbl (%rax),%eax
   4431f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   44322:	38 d0                	cmp    %dl,%al
   44324:	75 e2                	jne    44308 <strchr+0x15>
    }
    if (*s == (char) c) {
   44326:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4432a:	0f b6 00             	movzbl (%rax),%eax
   4432d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   44330:	38 d0                	cmp    %dl,%al
   44332:	75 06                	jne    4433a <strchr+0x47>
        return (char*) s;
   44334:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44338:	eb 05                	jmp    4433f <strchr+0x4c>
    } else {
        return NULL;
   4433a:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   4433f:	c9                   	leave  
   44340:	c3                   	ret    

0000000000044341 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   44341:	f3 0f 1e fa          	endbr64 
   44345:	55                   	push   %rbp
   44346:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   44349:	8b 05 b9 3c 01 00    	mov    0x13cb9(%rip),%eax        # 58008 <rand_seed_set>
   4434f:	85 c0                	test   %eax,%eax
   44351:	75 0a                	jne    4435d <rand+0x1c>
        srand(819234718U);
   44353:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   44358:	e8 24 00 00 00       	call   44381 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   4435d:	8b 05 a9 3c 01 00    	mov    0x13ca9(%rip),%eax        # 5800c <rand_seed>
   44363:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   44369:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   4436e:	89 05 98 3c 01 00    	mov    %eax,0x13c98(%rip)        # 5800c <rand_seed>
    return rand_seed & RAND_MAX;
   44374:	8b 05 92 3c 01 00    	mov    0x13c92(%rip),%eax        # 5800c <rand_seed>
   4437a:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4437f:	5d                   	pop    %rbp
   44380:	c3                   	ret    

0000000000044381 <srand>:

void srand(unsigned seed) {
   44381:	f3 0f 1e fa          	endbr64 
   44385:	55                   	push   %rbp
   44386:	48 89 e5             	mov    %rsp,%rbp
   44389:	48 83 ec 08          	sub    $0x8,%rsp
   4438d:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   44390:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44393:	89 05 73 3c 01 00    	mov    %eax,0x13c73(%rip)        # 5800c <rand_seed>
    rand_seed_set = 1;
   44399:	c7 05 65 3c 01 00 01 	movl   $0x1,0x13c65(%rip)        # 58008 <rand_seed_set>
   443a0:	00 00 00 
}
   443a3:	90                   	nop
   443a4:	c9                   	leave  
   443a5:	c3                   	ret    

00000000000443a6 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   443a6:	f3 0f 1e fa          	endbr64 
   443aa:	55                   	push   %rbp
   443ab:	48 89 e5             	mov    %rsp,%rbp
   443ae:	48 83 ec 28          	sub    $0x28,%rsp
   443b2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   443b6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   443ba:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   443bd:	48 8d 05 7c 1a 00 00 	lea    0x1a7c(%rip),%rax        # 45e40 <upper_digits.1>
   443c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   443c8:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   443cc:	79 0e                	jns    443dc <fill_numbuf+0x36>
        digits = lower_digits;
   443ce:	48 8d 05 8b 1a 00 00 	lea    0x1a8b(%rip),%rax        # 45e60 <lower_digits.0>
   443d5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   443d9:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   443dc:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   443e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443e5:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   443e8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   443eb:	48 63 c8             	movslq %eax,%rcx
   443ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   443f2:	ba 00 00 00 00       	mov    $0x0,%edx
   443f7:	48 f7 f1             	div    %rcx
   443fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   443fe:	48 01 d0             	add    %rdx,%rax
   44401:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   44406:	0f b6 10             	movzbl (%rax),%edx
   44409:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4440d:	88 10                	mov    %dl,(%rax)
        val /= base;
   4440f:	8b 45 dc             	mov    -0x24(%rbp),%eax
   44412:	48 63 f0             	movslq %eax,%rsi
   44415:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44419:	ba 00 00 00 00       	mov    $0x0,%edx
   4441e:	48 f7 f6             	div    %rsi
   44421:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   44425:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4442a:	75 bc                	jne    443e8 <fill_numbuf+0x42>
    return numbuf_end;
   4442c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   44430:	c9                   	leave  
   44431:	c3                   	ret    

0000000000044432 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   44432:	f3 0f 1e fa          	endbr64 
   44436:	55                   	push   %rbp
   44437:	48 89 e5             	mov    %rsp,%rbp
   4443a:	53                   	push   %rbx
   4443b:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   44442:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   44449:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   4444f:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44456:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   4445d:	e9 bd 09 00 00       	jmp    44e1f <printer_vprintf+0x9ed>
        if (*format != '%') {
   44462:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44469:	0f b6 00             	movzbl (%rax),%eax
   4446c:	3c 25                	cmp    $0x25,%al
   4446e:	74 31                	je     444a1 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   44470:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44477:	4c 8b 00             	mov    (%rax),%r8
   4447a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44481:	0f b6 00             	movzbl (%rax),%eax
   44484:	0f b6 c8             	movzbl %al,%ecx
   44487:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4448d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44494:	89 ce                	mov    %ecx,%esi
   44496:	48 89 c7             	mov    %rax,%rdi
   44499:	41 ff d0             	call   *%r8
            continue;
   4449c:	e9 76 09 00 00       	jmp    44e17 <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   444a1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   444a8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   444af:	01 
   444b0:	eb 4d                	jmp    444ff <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   444b2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   444b9:	0f b6 00             	movzbl (%rax),%eax
   444bc:	0f be c0             	movsbl %al,%eax
   444bf:	89 c6                	mov    %eax,%esi
   444c1:	48 8d 05 78 18 00 00 	lea    0x1878(%rip),%rax        # 45d40 <flag_chars>
   444c8:	48 89 c7             	mov    %rax,%rdi
   444cb:	e8 23 fe ff ff       	call   442f3 <strchr>
   444d0:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   444d4:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   444d9:	74 34                	je     4450f <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   444db:	48 8d 15 5e 18 00 00 	lea    0x185e(%rip),%rdx        # 45d40 <flag_chars>
   444e2:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   444e6:	48 29 d0             	sub    %rdx,%rax
   444e9:	ba 01 00 00 00       	mov    $0x1,%edx
   444ee:	89 c1                	mov    %eax,%ecx
   444f0:	d3 e2                	shl    %cl,%edx
   444f2:	89 d0                	mov    %edx,%eax
   444f4:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   444f7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   444fe:	01 
   444ff:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44506:	0f b6 00             	movzbl (%rax),%eax
   44509:	84 c0                	test   %al,%al
   4450b:	75 a5                	jne    444b2 <printer_vprintf+0x80>
   4450d:	eb 01                	jmp    44510 <printer_vprintf+0xde>
            } else {
                break;
   4450f:	90                   	nop
            }
        }

        // process width
        int width = -1;
   44510:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   44517:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4451e:	0f b6 00             	movzbl (%rax),%eax
   44521:	3c 30                	cmp    $0x30,%al
   44523:	7e 67                	jle    4458c <printer_vprintf+0x15a>
   44525:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4452c:	0f b6 00             	movzbl (%rax),%eax
   4452f:	3c 39                	cmp    $0x39,%al
   44531:	7f 59                	jg     4458c <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44533:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   4453a:	eb 2e                	jmp    4456a <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   4453c:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4453f:	89 d0                	mov    %edx,%eax
   44541:	c1 e0 02             	shl    $0x2,%eax
   44544:	01 d0                	add    %edx,%eax
   44546:	01 c0                	add    %eax,%eax
   44548:	89 c1                	mov    %eax,%ecx
   4454a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44551:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44555:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4455c:	0f b6 00             	movzbl (%rax),%eax
   4455f:	0f be c0             	movsbl %al,%eax
   44562:	01 c8                	add    %ecx,%eax
   44564:	83 e8 30             	sub    $0x30,%eax
   44567:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4456a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44571:	0f b6 00             	movzbl (%rax),%eax
   44574:	3c 2f                	cmp    $0x2f,%al
   44576:	0f 8e 85 00 00 00    	jle    44601 <printer_vprintf+0x1cf>
   4457c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44583:	0f b6 00             	movzbl (%rax),%eax
   44586:	3c 39                	cmp    $0x39,%al
   44588:	7e b2                	jle    4453c <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   4458a:	eb 75                	jmp    44601 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   4458c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44593:	0f b6 00             	movzbl (%rax),%eax
   44596:	3c 2a                	cmp    $0x2a,%al
   44598:	75 68                	jne    44602 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   4459a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445a1:	8b 00                	mov    (%rax),%eax
   445a3:	83 f8 2f             	cmp    $0x2f,%eax
   445a6:	77 30                	ja     445d8 <printer_vprintf+0x1a6>
   445a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445af:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445b3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445ba:	8b 00                	mov    (%rax),%eax
   445bc:	89 c0                	mov    %eax,%eax
   445be:	48 01 d0             	add    %rdx,%rax
   445c1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445c8:	8b 12                	mov    (%rdx),%edx
   445ca:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445cd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445d4:	89 0a                	mov    %ecx,(%rdx)
   445d6:	eb 1a                	jmp    445f2 <printer_vprintf+0x1c0>
   445d8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445df:	48 8b 40 08          	mov    0x8(%rax),%rax
   445e3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445ee:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445f2:	8b 00                	mov    (%rax),%eax
   445f4:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   445f7:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   445fe:	01 
   445ff:	eb 01                	jmp    44602 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   44601:	90                   	nop
        }

        // process precision
        int precision = -1;
   44602:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   44609:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44610:	0f b6 00             	movzbl (%rax),%eax
   44613:	3c 2e                	cmp    $0x2e,%al
   44615:	0f 85 00 01 00 00    	jne    4471b <printer_vprintf+0x2e9>
            ++format;
   4461b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44622:	01 
            if (*format >= '0' && *format <= '9') {
   44623:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4462a:	0f b6 00             	movzbl (%rax),%eax
   4462d:	3c 2f                	cmp    $0x2f,%al
   4462f:	7e 67                	jle    44698 <printer_vprintf+0x266>
   44631:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44638:	0f b6 00             	movzbl (%rax),%eax
   4463b:	3c 39                	cmp    $0x39,%al
   4463d:	7f 59                	jg     44698 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4463f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   44646:	eb 2e                	jmp    44676 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   44648:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4464b:	89 d0                	mov    %edx,%eax
   4464d:	c1 e0 02             	shl    $0x2,%eax
   44650:	01 d0                	add    %edx,%eax
   44652:	01 c0                	add    %eax,%eax
   44654:	89 c1                	mov    %eax,%ecx
   44656:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4465d:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44661:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44668:	0f b6 00             	movzbl (%rax),%eax
   4466b:	0f be c0             	movsbl %al,%eax
   4466e:	01 c8                	add    %ecx,%eax
   44670:	83 e8 30             	sub    $0x30,%eax
   44673:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44676:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4467d:	0f b6 00             	movzbl (%rax),%eax
   44680:	3c 2f                	cmp    $0x2f,%al
   44682:	0f 8e 85 00 00 00    	jle    4470d <printer_vprintf+0x2db>
   44688:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4468f:	0f b6 00             	movzbl (%rax),%eax
   44692:	3c 39                	cmp    $0x39,%al
   44694:	7e b2                	jle    44648 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   44696:	eb 75                	jmp    4470d <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   44698:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4469f:	0f b6 00             	movzbl (%rax),%eax
   446a2:	3c 2a                	cmp    $0x2a,%al
   446a4:	75 68                	jne    4470e <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   446a6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446ad:	8b 00                	mov    (%rax),%eax
   446af:	83 f8 2f             	cmp    $0x2f,%eax
   446b2:	77 30                	ja     446e4 <printer_vprintf+0x2b2>
   446b4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446bb:	48 8b 50 10          	mov    0x10(%rax),%rdx
   446bf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446c6:	8b 00                	mov    (%rax),%eax
   446c8:	89 c0                	mov    %eax,%eax
   446ca:	48 01 d0             	add    %rdx,%rax
   446cd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446d4:	8b 12                	mov    (%rdx),%edx
   446d6:	8d 4a 08             	lea    0x8(%rdx),%ecx
   446d9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446e0:	89 0a                	mov    %ecx,(%rdx)
   446e2:	eb 1a                	jmp    446fe <printer_vprintf+0x2cc>
   446e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446eb:	48 8b 40 08          	mov    0x8(%rax),%rax
   446ef:	48 8d 48 08          	lea    0x8(%rax),%rcx
   446f3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446fa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   446fe:	8b 00                	mov    (%rax),%eax
   44700:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   44703:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4470a:	01 
   4470b:	eb 01                	jmp    4470e <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   4470d:	90                   	nop
            }
            if (precision < 0) {
   4470e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44712:	79 07                	jns    4471b <printer_vprintf+0x2e9>
                precision = 0;
   44714:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   4471b:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   44722:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   44729:	00 
        int length = 0;
   4472a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   44731:	48 8d 05 0e 16 00 00 	lea    0x160e(%rip),%rax        # 45d46 <flag_chars+0x6>
   44738:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   4473c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44743:	0f b6 00             	movzbl (%rax),%eax
   44746:	0f be c0             	movsbl %al,%eax
   44749:	83 e8 43             	sub    $0x43,%eax
   4474c:	83 f8 37             	cmp    $0x37,%eax
   4474f:	0f 87 b6 03 00 00    	ja     44b0b <printer_vprintf+0x6d9>
   44755:	89 c0                	mov    %eax,%eax
   44757:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   4475e:	00 
   4475f:	48 8d 05 ee 15 00 00 	lea    0x15ee(%rip),%rax        # 45d54 <flag_chars+0x14>
   44766:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   44769:	48 98                	cltq   
   4476b:	48 8d 15 e2 15 00 00 	lea    0x15e2(%rip),%rdx        # 45d54 <flag_chars+0x14>
   44772:	48 01 d0             	add    %rdx,%rax
   44775:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   44778:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   4477f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44786:	01 
            goto again;
   44787:	eb b3                	jmp    4473c <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   44789:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4478d:	74 5d                	je     447ec <printer_vprintf+0x3ba>
   4478f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44796:	8b 00                	mov    (%rax),%eax
   44798:	83 f8 2f             	cmp    $0x2f,%eax
   4479b:	77 30                	ja     447cd <printer_vprintf+0x39b>
   4479d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447a4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   447a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447af:	8b 00                	mov    (%rax),%eax
   447b1:	89 c0                	mov    %eax,%eax
   447b3:	48 01 d0             	add    %rdx,%rax
   447b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447bd:	8b 12                	mov    (%rdx),%edx
   447bf:	8d 4a 08             	lea    0x8(%rdx),%ecx
   447c2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447c9:	89 0a                	mov    %ecx,(%rdx)
   447cb:	eb 1a                	jmp    447e7 <printer_vprintf+0x3b5>
   447cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447d4:	48 8b 40 08          	mov    0x8(%rax),%rax
   447d8:	48 8d 48 08          	lea    0x8(%rax),%rcx
   447dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447e3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   447e7:	48 8b 00             	mov    (%rax),%rax
   447ea:	eb 5c                	jmp    44848 <printer_vprintf+0x416>
   447ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447f3:	8b 00                	mov    (%rax),%eax
   447f5:	83 f8 2f             	cmp    $0x2f,%eax
   447f8:	77 30                	ja     4482a <printer_vprintf+0x3f8>
   447fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44801:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44805:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4480c:	8b 00                	mov    (%rax),%eax
   4480e:	89 c0                	mov    %eax,%eax
   44810:	48 01 d0             	add    %rdx,%rax
   44813:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4481a:	8b 12                	mov    (%rdx),%edx
   4481c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4481f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44826:	89 0a                	mov    %ecx,(%rdx)
   44828:	eb 1a                	jmp    44844 <printer_vprintf+0x412>
   4482a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44831:	48 8b 40 08          	mov    0x8(%rax),%rax
   44835:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44839:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44840:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44844:	8b 00                	mov    (%rax),%eax
   44846:	48 98                	cltq   
   44848:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4484c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44850:	48 c1 f8 38          	sar    $0x38,%rax
   44854:	25 80 00 00 00       	and    $0x80,%eax
   44859:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   4485c:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   44860:	74 09                	je     4486b <printer_vprintf+0x439>
   44862:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44866:	48 f7 d8             	neg    %rax
   44869:	eb 04                	jmp    4486f <printer_vprintf+0x43d>
   4486b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4486f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   44873:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   44876:	83 c8 60             	or     $0x60,%eax
   44879:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   4487c:	e9 cf 02 00 00       	jmp    44b50 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   44881:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44885:	74 5d                	je     448e4 <printer_vprintf+0x4b2>
   44887:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4488e:	8b 00                	mov    (%rax),%eax
   44890:	83 f8 2f             	cmp    $0x2f,%eax
   44893:	77 30                	ja     448c5 <printer_vprintf+0x493>
   44895:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4489c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   448a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448a7:	8b 00                	mov    (%rax),%eax
   448a9:	89 c0                	mov    %eax,%eax
   448ab:	48 01 d0             	add    %rdx,%rax
   448ae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   448b5:	8b 12                	mov    (%rdx),%edx
   448b7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   448ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   448c1:	89 0a                	mov    %ecx,(%rdx)
   448c3:	eb 1a                	jmp    448df <printer_vprintf+0x4ad>
   448c5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448cc:	48 8b 40 08          	mov    0x8(%rax),%rax
   448d0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   448d4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   448db:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   448df:	48 8b 00             	mov    (%rax),%rax
   448e2:	eb 5c                	jmp    44940 <printer_vprintf+0x50e>
   448e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448eb:	8b 00                	mov    (%rax),%eax
   448ed:	83 f8 2f             	cmp    $0x2f,%eax
   448f0:	77 30                	ja     44922 <printer_vprintf+0x4f0>
   448f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   448f9:	48 8b 50 10          	mov    0x10(%rax),%rdx
   448fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44904:	8b 00                	mov    (%rax),%eax
   44906:	89 c0                	mov    %eax,%eax
   44908:	48 01 d0             	add    %rdx,%rax
   4490b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44912:	8b 12                	mov    (%rdx),%edx
   44914:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44917:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4491e:	89 0a                	mov    %ecx,(%rdx)
   44920:	eb 1a                	jmp    4493c <printer_vprintf+0x50a>
   44922:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44929:	48 8b 40 08          	mov    0x8(%rax),%rax
   4492d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44931:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44938:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4493c:	8b 00                	mov    (%rax),%eax
   4493e:	89 c0                	mov    %eax,%eax
   44940:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   44944:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44948:	e9 03 02 00 00       	jmp    44b50 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   4494d:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   44954:	e9 28 ff ff ff       	jmp    44881 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   44959:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   44960:	e9 1c ff ff ff       	jmp    44881 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44965:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4496c:	8b 00                	mov    (%rax),%eax
   4496e:	83 f8 2f             	cmp    $0x2f,%eax
   44971:	77 30                	ja     449a3 <printer_vprintf+0x571>
   44973:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4497a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4497e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44985:	8b 00                	mov    (%rax),%eax
   44987:	89 c0                	mov    %eax,%eax
   44989:	48 01 d0             	add    %rdx,%rax
   4498c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44993:	8b 12                	mov    (%rdx),%edx
   44995:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44998:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4499f:	89 0a                	mov    %ecx,(%rdx)
   449a1:	eb 1a                	jmp    449bd <printer_vprintf+0x58b>
   449a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   449aa:	48 8b 40 08          	mov    0x8(%rax),%rax
   449ae:	48 8d 48 08          	lea    0x8(%rax),%rcx
   449b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   449b9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449bd:	48 8b 00             	mov    (%rax),%rax
   449c0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   449c4:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   449cb:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   449d2:	e9 79 01 00 00       	jmp    44b50 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   449d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   449de:	8b 00                	mov    (%rax),%eax
   449e0:	83 f8 2f             	cmp    $0x2f,%eax
   449e3:	77 30                	ja     44a15 <printer_vprintf+0x5e3>
   449e5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   449ec:	48 8b 50 10          	mov    0x10(%rax),%rdx
   449f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   449f7:	8b 00                	mov    (%rax),%eax
   449f9:	89 c0                	mov    %eax,%eax
   449fb:	48 01 d0             	add    %rdx,%rax
   449fe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a05:	8b 12                	mov    (%rdx),%edx
   44a07:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44a0a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a11:	89 0a                	mov    %ecx,(%rdx)
   44a13:	eb 1a                	jmp    44a2f <printer_vprintf+0x5fd>
   44a15:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a1c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a20:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44a24:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a2b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a2f:	48 8b 00             	mov    (%rax),%rax
   44a32:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   44a36:	e9 15 01 00 00       	jmp    44b50 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   44a3b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a42:	8b 00                	mov    (%rax),%eax
   44a44:	83 f8 2f             	cmp    $0x2f,%eax
   44a47:	77 30                	ja     44a79 <printer_vprintf+0x647>
   44a49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a50:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44a54:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a5b:	8b 00                	mov    (%rax),%eax
   44a5d:	89 c0                	mov    %eax,%eax
   44a5f:	48 01 d0             	add    %rdx,%rax
   44a62:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a69:	8b 12                	mov    (%rdx),%edx
   44a6b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44a6e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a75:	89 0a                	mov    %ecx,(%rdx)
   44a77:	eb 1a                	jmp    44a93 <printer_vprintf+0x661>
   44a79:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44a80:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a84:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44a88:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44a8f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a93:	8b 00                	mov    (%rax),%eax
   44a95:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   44a9b:	e9 77 03 00 00       	jmp    44e17 <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   44aa0:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44aa4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44aa8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44aaf:	8b 00                	mov    (%rax),%eax
   44ab1:	83 f8 2f             	cmp    $0x2f,%eax
   44ab4:	77 30                	ja     44ae6 <printer_vprintf+0x6b4>
   44ab6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44abd:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44ac1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44ac8:	8b 00                	mov    (%rax),%eax
   44aca:	89 c0                	mov    %eax,%eax
   44acc:	48 01 d0             	add    %rdx,%rax
   44acf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44ad6:	8b 12                	mov    (%rdx),%edx
   44ad8:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44adb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44ae2:	89 0a                	mov    %ecx,(%rdx)
   44ae4:	eb 1a                	jmp    44b00 <printer_vprintf+0x6ce>
   44ae6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44aed:	48 8b 40 08          	mov    0x8(%rax),%rax
   44af1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44af5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44afc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44b00:	8b 00                	mov    (%rax),%eax
   44b02:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44b05:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   44b09:	eb 45                	jmp    44b50 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   44b0b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44b0f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   44b13:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44b1a:	0f b6 00             	movzbl (%rax),%eax
   44b1d:	84 c0                	test   %al,%al
   44b1f:	74 0c                	je     44b2d <printer_vprintf+0x6fb>
   44b21:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44b28:	0f b6 00             	movzbl (%rax),%eax
   44b2b:	eb 05                	jmp    44b32 <printer_vprintf+0x700>
   44b2d:	b8 25 00 00 00       	mov    $0x25,%eax
   44b32:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44b35:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   44b39:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44b40:	0f b6 00             	movzbl (%rax),%eax
   44b43:	84 c0                	test   %al,%al
   44b45:	75 08                	jne    44b4f <printer_vprintf+0x71d>
                format--;
   44b47:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44b4e:	01 
            }
            break;
   44b4f:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44b50:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44b53:	83 e0 20             	and    $0x20,%eax
   44b56:	85 c0                	test   %eax,%eax
   44b58:	74 1e                	je     44b78 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   44b5a:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44b5e:	48 83 c0 18          	add    $0x18,%rax
   44b62:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44b65:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44b69:	48 89 ce             	mov    %rcx,%rsi
   44b6c:	48 89 c7             	mov    %rax,%rdi
   44b6f:	e8 32 f8 ff ff       	call   443a6 <fill_numbuf>
   44b74:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44b78:	48 8d 05 c7 11 00 00 	lea    0x11c7(%rip),%rax        # 45d46 <flag_chars+0x6>
   44b7f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44b83:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44b86:	83 e0 20             	and    $0x20,%eax
   44b89:	85 c0                	test   %eax,%eax
   44b8b:	74 51                	je     44bde <printer_vprintf+0x7ac>
   44b8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44b90:	83 e0 40             	and    $0x40,%eax
   44b93:	85 c0                	test   %eax,%eax
   44b95:	74 47                	je     44bde <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   44b97:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44b9a:	25 80 00 00 00       	and    $0x80,%eax
   44b9f:	85 c0                	test   %eax,%eax
   44ba1:	74 0d                	je     44bb0 <printer_vprintf+0x77e>
                prefix = "-";
   44ba3:	48 8d 05 9d 11 00 00 	lea    0x119d(%rip),%rax        # 45d47 <flag_chars+0x7>
   44baa:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44bae:	eb 7d                	jmp    44c2d <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44bb0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44bb3:	83 e0 10             	and    $0x10,%eax
   44bb6:	85 c0                	test   %eax,%eax
   44bb8:	74 0d                	je     44bc7 <printer_vprintf+0x795>
                prefix = "+";
   44bba:	48 8d 05 88 11 00 00 	lea    0x1188(%rip),%rax        # 45d49 <flag_chars+0x9>
   44bc1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44bc5:	eb 66                	jmp    44c2d <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44bc7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44bca:	83 e0 08             	and    $0x8,%eax
   44bcd:	85 c0                	test   %eax,%eax
   44bcf:	74 5c                	je     44c2d <printer_vprintf+0x7fb>
                prefix = " ";
   44bd1:	48 8d 05 73 11 00 00 	lea    0x1173(%rip),%rax        # 45d4b <flag_chars+0xb>
   44bd8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44bdc:	eb 4f                	jmp    44c2d <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44bde:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44be1:	83 e0 20             	and    $0x20,%eax
   44be4:	85 c0                	test   %eax,%eax
   44be6:	74 46                	je     44c2e <printer_vprintf+0x7fc>
   44be8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44beb:	83 e0 01             	and    $0x1,%eax
   44bee:	85 c0                	test   %eax,%eax
   44bf0:	74 3c                	je     44c2e <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   44bf2:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   44bf6:	74 06                	je     44bfe <printer_vprintf+0x7cc>
   44bf8:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44bfc:	75 30                	jne    44c2e <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   44bfe:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44c03:	75 0c                	jne    44c11 <printer_vprintf+0x7df>
   44c05:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c08:	25 00 01 00 00       	and    $0x100,%eax
   44c0d:	85 c0                	test   %eax,%eax
   44c0f:	74 1d                	je     44c2e <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   44c11:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44c15:	75 09                	jne    44c20 <printer_vprintf+0x7ee>
   44c17:	48 8d 05 2f 11 00 00 	lea    0x112f(%rip),%rax        # 45d4d <flag_chars+0xd>
   44c1e:	eb 07                	jmp    44c27 <printer_vprintf+0x7f5>
   44c20:	48 8d 05 29 11 00 00 	lea    0x1129(%rip),%rax        # 45d50 <flag_chars+0x10>
   44c27:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44c2b:	eb 01                	jmp    44c2e <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   44c2d:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44c2e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44c32:	78 24                	js     44c58 <printer_vprintf+0x826>
   44c34:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c37:	83 e0 20             	and    $0x20,%eax
   44c3a:	85 c0                	test   %eax,%eax
   44c3c:	75 1a                	jne    44c58 <printer_vprintf+0x826>
            len = strnlen(data, precision);
   44c3e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44c41:	48 63 d0             	movslq %eax,%rdx
   44c44:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44c48:	48 89 d6             	mov    %rdx,%rsi
   44c4b:	48 89 c7             	mov    %rax,%rdi
   44c4e:	e8 91 f5 ff ff       	call   441e4 <strnlen>
   44c53:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44c56:	eb 0f                	jmp    44c67 <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   44c58:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44c5c:	48 89 c7             	mov    %rax,%rdi
   44c5f:	e8 4b f5 ff ff       	call   441af <strlen>
   44c64:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44c67:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c6a:	83 e0 20             	and    $0x20,%eax
   44c6d:	85 c0                	test   %eax,%eax
   44c6f:	74 20                	je     44c91 <printer_vprintf+0x85f>
   44c71:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44c75:	78 1a                	js     44c91 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   44c77:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44c7a:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44c7d:	7e 08                	jle    44c87 <printer_vprintf+0x855>
   44c7f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44c82:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44c85:	eb 05                	jmp    44c8c <printer_vprintf+0x85a>
   44c87:	b8 00 00 00 00       	mov    $0x0,%eax
   44c8c:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44c8f:	eb 5c                	jmp    44ced <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44c91:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c94:	83 e0 20             	and    $0x20,%eax
   44c97:	85 c0                	test   %eax,%eax
   44c99:	74 4b                	je     44ce6 <printer_vprintf+0x8b4>
   44c9b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44c9e:	83 e0 02             	and    $0x2,%eax
   44ca1:	85 c0                	test   %eax,%eax
   44ca3:	74 41                	je     44ce6 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44ca5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44ca8:	83 e0 04             	and    $0x4,%eax
   44cab:	85 c0                	test   %eax,%eax
   44cad:	75 37                	jne    44ce6 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   44caf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44cb3:	48 89 c7             	mov    %rax,%rdi
   44cb6:	e8 f4 f4 ff ff       	call   441af <strlen>
   44cbb:	89 c2                	mov    %eax,%edx
   44cbd:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44cc0:	01 d0                	add    %edx,%eax
   44cc2:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44cc5:	7e 1f                	jle    44ce6 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   44cc7:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44cca:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44ccd:	89 c3                	mov    %eax,%ebx
   44ccf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44cd3:	48 89 c7             	mov    %rax,%rdi
   44cd6:	e8 d4 f4 ff ff       	call   441af <strlen>
   44cdb:	89 c2                	mov    %eax,%edx
   44cdd:	89 d8                	mov    %ebx,%eax
   44cdf:	29 d0                	sub    %edx,%eax
   44ce1:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44ce4:	eb 07                	jmp    44ced <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   44ce6:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44ced:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44cf0:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44cf3:	01 d0                	add    %edx,%eax
   44cf5:	48 63 d8             	movslq %eax,%rbx
   44cf8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44cfc:	48 89 c7             	mov    %rax,%rdi
   44cff:	e8 ab f4 ff ff       	call   441af <strlen>
   44d04:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   44d08:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44d0b:	29 d0                	sub    %edx,%eax
   44d0d:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44d10:	eb 25                	jmp    44d37 <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   44d12:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d19:	48 8b 08             	mov    (%rax),%rcx
   44d1c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44d22:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d29:	be 20 00 00 00       	mov    $0x20,%esi
   44d2e:	48 89 c7             	mov    %rax,%rdi
   44d31:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44d33:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44d37:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44d3a:	83 e0 04             	and    $0x4,%eax
   44d3d:	85 c0                	test   %eax,%eax
   44d3f:	75 36                	jne    44d77 <printer_vprintf+0x945>
   44d41:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44d45:	7f cb                	jg     44d12 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   44d47:	eb 2e                	jmp    44d77 <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   44d49:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d50:	4c 8b 00             	mov    (%rax),%r8
   44d53:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44d57:	0f b6 00             	movzbl (%rax),%eax
   44d5a:	0f b6 c8             	movzbl %al,%ecx
   44d5d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44d63:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d6a:	89 ce                	mov    %ecx,%esi
   44d6c:	48 89 c7             	mov    %rax,%rdi
   44d6f:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44d72:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44d77:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44d7b:	0f b6 00             	movzbl (%rax),%eax
   44d7e:	84 c0                	test   %al,%al
   44d80:	75 c7                	jne    44d49 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   44d82:	eb 25                	jmp    44da9 <printer_vprintf+0x977>
            p->putc(p, '0', color);
   44d84:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d8b:	48 8b 08             	mov    (%rax),%rcx
   44d8e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44d94:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44d9b:	be 30 00 00 00       	mov    $0x30,%esi
   44da0:	48 89 c7             	mov    %rax,%rdi
   44da3:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44da5:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44da9:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44dad:	7f d5                	jg     44d84 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   44daf:	eb 32                	jmp    44de3 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   44db1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44db8:	4c 8b 00             	mov    (%rax),%r8
   44dbb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44dbf:	0f b6 00             	movzbl (%rax),%eax
   44dc2:	0f b6 c8             	movzbl %al,%ecx
   44dc5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44dcb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44dd2:	89 ce                	mov    %ecx,%esi
   44dd4:	48 89 c7             	mov    %rax,%rdi
   44dd7:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   44dda:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44ddf:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44de3:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44de7:	7f c8                	jg     44db1 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   44de9:	eb 25                	jmp    44e10 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   44deb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44df2:	48 8b 08             	mov    (%rax),%rcx
   44df5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44dfb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44e02:	be 20 00 00 00       	mov    $0x20,%esi
   44e07:	48 89 c7             	mov    %rax,%rdi
   44e0a:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44e0c:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44e10:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44e14:	7f d5                	jg     44deb <printer_vprintf+0x9b9>
        }
    done: ;
   44e16:	90                   	nop
    for (; *format; ++format) {
   44e17:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44e1e:	01 
   44e1f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44e26:	0f b6 00             	movzbl (%rax),%eax
   44e29:	84 c0                	test   %al,%al
   44e2b:	0f 85 31 f6 ff ff    	jne    44462 <printer_vprintf+0x30>
    }
}
   44e31:	90                   	nop
   44e32:	90                   	nop
   44e33:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44e37:	c9                   	leave  
   44e38:	c3                   	ret    

0000000000044e39 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   44e39:	f3 0f 1e fa          	endbr64 
   44e3d:	55                   	push   %rbp
   44e3e:	48 89 e5             	mov    %rsp,%rbp
   44e41:	48 83 ec 20          	sub    $0x20,%rsp
   44e45:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44e49:	89 f0                	mov    %esi,%eax
   44e4b:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44e4e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44e51:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44e55:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44e59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44e5d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44e61:	48 8d 15 38 41 07 00 	lea    0x74138(%rip),%rdx        # b8fa0 <console+0xfa0>
   44e68:	48 39 d0             	cmp    %rdx,%rax
   44e6b:	72 0f                	jb     44e7c <console_putc+0x43>
        cp->cursor = console;
   44e6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44e71:	48 8d 15 88 31 07 00 	lea    0x73188(%rip),%rdx        # b8000 <console>
   44e78:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   44e7c:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44e80:	0f 85 82 00 00 00    	jne    44f08 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   44e86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44e8a:	48 8b 40 08          	mov    0x8(%rax),%rax
   44e8e:	48 8d 15 6b 31 07 00 	lea    0x7316b(%rip),%rdx        # b8000 <console>
   44e95:	48 29 d0             	sub    %rdx,%rax
   44e98:	48 d1 f8             	sar    %rax
   44e9b:	48 89 c1             	mov    %rax,%rcx
   44e9e:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44ea5:	66 66 66 
   44ea8:	48 89 c8             	mov    %rcx,%rax
   44eab:	48 f7 ea             	imul   %rdx
   44eae:	48 89 d0             	mov    %rdx,%rax
   44eb1:	48 c1 f8 05          	sar    $0x5,%rax
   44eb5:	48 89 ce             	mov    %rcx,%rsi
   44eb8:	48 c1 fe 3f          	sar    $0x3f,%rsi
   44ebc:	48 29 f0             	sub    %rsi,%rax
   44ebf:	48 89 c2             	mov    %rax,%rdx
   44ec2:	48 89 d0             	mov    %rdx,%rax
   44ec5:	48 c1 e0 02          	shl    $0x2,%rax
   44ec9:	48 01 d0             	add    %rdx,%rax
   44ecc:	48 c1 e0 04          	shl    $0x4,%rax
   44ed0:	48 29 c1             	sub    %rax,%rcx
   44ed3:	48 89 ca             	mov    %rcx,%rdx
   44ed6:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44ed9:	eb 25                	jmp    44f00 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   44edb:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44ede:	83 c8 20             	or     $0x20,%eax
   44ee1:	89 c6                	mov    %eax,%esi
   44ee3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44ee7:	48 8b 40 08          	mov    0x8(%rax),%rax
   44eeb:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44eef:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44ef3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44ef7:	89 f2                	mov    %esi,%edx
   44ef9:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44efc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44f00:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44f04:	75 d5                	jne    44edb <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44f06:	eb 24                	jmp    44f2c <console_putc+0xf3>
        *cp->cursor++ = c | color;
   44f08:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44f0c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44f0f:	89 d6                	mov    %edx,%esi
   44f11:	09 c6                	or     %eax,%esi
   44f13:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44f17:	48 8b 40 08          	mov    0x8(%rax),%rax
   44f1b:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44f1f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44f23:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44f27:	89 f2                	mov    %esi,%edx
   44f29:	66 89 10             	mov    %dx,(%rax)
}
   44f2c:	90                   	nop
   44f2d:	c9                   	leave  
   44f2e:	c3                   	ret    

0000000000044f2f <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44f2f:	f3 0f 1e fa          	endbr64 
   44f33:	55                   	push   %rbp
   44f34:	48 89 e5             	mov    %rsp,%rbp
   44f37:	48 83 ec 30          	sub    $0x30,%rsp
   44f3b:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44f3e:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44f41:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44f45:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44f49:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 44e39 <console_putc>
   44f50:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44f54:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44f58:	78 09                	js     44f63 <console_vprintf+0x34>
   44f5a:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44f61:	7e 07                	jle    44f6a <console_vprintf+0x3b>
        cpos = 0;
   44f63:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44f6a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44f6d:	48 98                	cltq   
   44f6f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44f73:	48 8d 05 86 30 07 00 	lea    0x73086(%rip),%rax        # b8000 <console>
   44f7a:	48 01 d0             	add    %rdx,%rax
   44f7d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44f81:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44f85:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44f89:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44f8c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44f90:	48 89 c7             	mov    %rax,%rdi
   44f93:	e8 9a f4 ff ff       	call   44432 <printer_vprintf>
    return cp.cursor - console;
   44f98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44f9c:	48 8d 15 5d 30 07 00 	lea    0x7305d(%rip),%rdx        # b8000 <console>
   44fa3:	48 29 d0             	sub    %rdx,%rax
   44fa6:	48 d1 f8             	sar    %rax
}
   44fa9:	c9                   	leave  
   44faa:	c3                   	ret    

0000000000044fab <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44fab:	f3 0f 1e fa          	endbr64 
   44faf:	55                   	push   %rbp
   44fb0:	48 89 e5             	mov    %rsp,%rbp
   44fb3:	48 83 ec 60          	sub    $0x60,%rsp
   44fb7:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44fba:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44fbd:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44fc1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44fc5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44fc9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44fcd:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44fd4:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44fd8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44fdc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44fe0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44fe4:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44fe8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44fec:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44fef:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44ff2:	89 c7                	mov    %eax,%edi
   44ff4:	e8 36 ff ff ff       	call   44f2f <console_vprintf>
   44ff9:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44ffc:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44fff:	c9                   	leave  
   45000:	c3                   	ret    

0000000000045001 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   45001:	f3 0f 1e fa          	endbr64 
   45005:	55                   	push   %rbp
   45006:	48 89 e5             	mov    %rsp,%rbp
   45009:	48 83 ec 20          	sub    $0x20,%rsp
   4500d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   45011:	89 f0                	mov    %esi,%eax
   45013:	89 55 e0             	mov    %edx,-0x20(%rbp)
   45016:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   45019:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4501d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   45021:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   45025:	48 8b 50 08          	mov    0x8(%rax),%rdx
   45029:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4502d:	48 8b 40 10          	mov    0x10(%rax),%rax
   45031:	48 39 c2             	cmp    %rax,%rdx
   45034:	73 1a                	jae    45050 <string_putc+0x4f>
        *sp->s++ = c;
   45036:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4503a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4503e:	48 8d 48 01          	lea    0x1(%rax),%rcx
   45042:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   45046:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4504a:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   4504e:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   45050:	90                   	nop
   45051:	c9                   	leave  
   45052:	c3                   	ret    

0000000000045053 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   45053:	f3 0f 1e fa          	endbr64 
   45057:	55                   	push   %rbp
   45058:	48 89 e5             	mov    %rsp,%rbp
   4505b:	48 83 ec 40          	sub    $0x40,%rsp
   4505f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   45063:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   45067:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   4506b:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   4506f:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 45001 <string_putc>
   45076:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   4507a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4507e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   45082:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   45087:	74 33                	je     450bc <vsnprintf+0x69>
        sp.end = s + size - 1;
   45089:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4508d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   45091:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   45095:	48 01 d0             	add    %rdx,%rax
   45098:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   4509c:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   450a0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   450a4:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   450a8:	be 00 00 00 00       	mov    $0x0,%esi
   450ad:	48 89 c7             	mov    %rax,%rdi
   450b0:	e8 7d f3 ff ff       	call   44432 <printer_vprintf>
        *sp.s = 0;
   450b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   450b9:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   450bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   450c0:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   450c4:	c9                   	leave  
   450c5:	c3                   	ret    

00000000000450c6 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   450c6:	f3 0f 1e fa          	endbr64 
   450ca:	55                   	push   %rbp
   450cb:	48 89 e5             	mov    %rsp,%rbp
   450ce:	48 83 ec 70          	sub    $0x70,%rsp
   450d2:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   450d6:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   450da:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   450de:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   450e2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   450e6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   450ea:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   450f1:	48 8d 45 10          	lea    0x10(%rbp),%rax
   450f5:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   450f9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   450fd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   45101:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   45105:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   45109:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   4510d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   45111:	48 89 c7             	mov    %rax,%rdi
   45114:	e8 3a ff ff ff       	call   45053 <vsnprintf>
   45119:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   4511c:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   4511f:	c9                   	leave  
   45120:	c3                   	ret    

0000000000045121 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   45121:	f3 0f 1e fa          	endbr64 
   45125:	55                   	push   %rbp
   45126:	48 89 e5             	mov    %rsp,%rbp
   45129:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4512d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   45134:	eb 1a                	jmp    45150 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   45136:	8b 45 fc             	mov    -0x4(%rbp),%eax
   45139:	48 98                	cltq   
   4513b:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4513f:	48 8d 05 ba 2e 07 00 	lea    0x72eba(%rip),%rax        # b8000 <console>
   45146:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4514c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   45150:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   45157:	7e dd                	jle    45136 <console_clear+0x15>
    }
    cursorpos = 0;
   45159:	c7 05 99 3e 07 00 00 	movl   $0x0,0x73e99(%rip)        # b8ffc <cursorpos>
   45160:	00 00 00 
}
   45163:	90                   	nop
   45164:	c9                   	leave  
   45165:	c3                   	ret    
