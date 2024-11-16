
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
   400be:	e8 e1 05 00 00       	call   406a4 <exception>

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
   40177:	e8 92 14 00 00       	call   4160e <hardware_init>
    pageinfo_init();
   4017c:	e8 92 09 00 00       	call   40b13 <pageinfo_init>
    console_clear();
   40181:	e8 23 41 00 00       	call   442a9 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 e6 19 00 00       	call   41b76 <timer_init>


    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   40190:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40195:	be 00 00 00 00       	mov    $0x0,%esi
   4019a:	48 8d 05 7f 0e 01 00 	lea    0x10e7f(%rip),%rax        # 51020 <processes>
   401a1:	48 89 c7             	mov    %rax,%rdi
   401a4:	e8 4b 31 00 00       	call   432f4 <memset>
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
   401c9:	48 8d 15 50 0e 01 00 	lea    0x10e50(%rip),%rdx        # 51020 <processes>
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
   401ed:	48 8d 05 f4 0e 01 00 	lea    0x10ef4(%rip),%rax        # 510e8 <processes+0xc8>
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
   40210:	48 8d 15 e9 40 00 00 	lea    0x40e9(%rip),%rdx        # 44300 <console_clear+0x57>
   40217:	48 89 d6             	mov    %rdx,%rsi
   4021a:	48 89 c7             	mov    %rax,%rdi
   4021d:	e8 db 31 00 00       	call   433fd <strcmp>
   40222:	85 c0                	test   %eax,%eax
   40224:	75 14                	jne    4023a <kernel+0xd3>
        process_setup(1, 4);
   40226:	be 04 00 00 00       	mov    $0x4,%esi
   4022b:	bf 01 00 00 00       	mov    $0x1,%edi
   40230:	e8 e5 00 00 00       	call   4031a <process_setup>
   40235:	e9 d1 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4023a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4023f:	74 2e                	je     4026f <kernel+0x108>
   40241:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40245:	48 8d 15 b9 40 00 00 	lea    0x40b9(%rip),%rdx        # 44305 <console_clear+0x5c>
   4024c:	48 89 d6             	mov    %rdx,%rsi
   4024f:	48 89 c7             	mov    %rax,%rdi
   40252:	e8 a6 31 00 00       	call   433fd <strcmp>
   40257:	85 c0                	test   %eax,%eax
   40259:	75 14                	jne    4026f <kernel+0x108>
        process_setup(1, 5);
   4025b:	be 05 00 00 00       	mov    $0x5,%esi
   40260:	bf 01 00 00 00       	mov    $0x1,%edi
   40265:	e8 b0 00 00 00       	call   4031a <process_setup>
   4026a:	e9 9c 00 00 00       	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test") == 0) {
   4026f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40274:	74 2b                	je     402a1 <kernel+0x13a>
   40276:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4027a:	48 8d 15 8d 40 00 00 	lea    0x408d(%rip),%rdx        # 4430e <console_clear+0x65>
   40281:	48 89 d6             	mov    %rdx,%rsi
   40284:	48 89 c7             	mov    %rax,%rdi
   40287:	e8 71 31 00 00       	call   433fd <strcmp>
   4028c:	85 c0                	test   %eax,%eax
   4028e:	75 11                	jne    402a1 <kernel+0x13a>
        process_setup(1, 6);
   40290:	be 06 00 00 00       	mov    $0x6,%esi
   40295:	bf 01 00 00 00       	mov    $0x1,%edi
   4029a:	e8 7b 00 00 00       	call   4031a <process_setup>
   4029f:	eb 6a                	jmp    4030b <kernel+0x1a4>
    } else if (command && strcmp(command, "test2") == 0) {
   402a1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a6:	74 3e                	je     402e6 <kernel+0x17f>
   402a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402ac:	48 8d 15 60 40 00 00 	lea    0x4060(%rip),%rdx        # 44313 <console_clear+0x6a>
   402b3:	48 89 d6             	mov    %rdx,%rsi
   402b6:	48 89 c7             	mov    %rax,%rdi
   402b9:	e8 3f 31 00 00       	call   433fd <strcmp>
   402be:	85 c0                	test   %eax,%eax
   402c0:	75 24                	jne    402e6 <kernel+0x17f>
        for (pid_t i = 1; i <= 2; ++i) {
   402c2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402c9:	eb 13                	jmp    402de <kernel+0x177>
            process_setup(i, 6);
   402cb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402ce:	be 06 00 00 00       	mov    $0x6,%esi
   402d3:	89 c7                	mov    %eax,%edi
   402d5:	e8 40 00 00 00       	call   4031a <process_setup>
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
   402fc:	e8 19 00 00 00       	call   4031a <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   40301:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40305:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   40309:	7e e4                	jle    402ef <kernel+0x188>
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
   4030b:	48 8d 05 ee 0d 01 00 	lea    0x10dee(%rip),%rax        # 51100 <processes+0xe0>
   40312:	48 89 c7             	mov    %rax,%rdi
   40315:	e8 8e 07 00 00       	call   40aa8 <run>

000000000004031a <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   4031a:	f3 0f 1e fa          	endbr64 
   4031e:	55                   	push   %rbp
   4031f:	48 89 e5             	mov    %rsp,%rbp
   40322:	48 83 ec 20          	sub    $0x20,%rsp
   40326:	89 7d ec             	mov    %edi,-0x14(%rbp)
   40329:	89 75 e8             	mov    %esi,-0x18(%rbp)
    process_init(&processes[pid], 0);
   4032c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4032f:	48 63 d0             	movslq %eax,%rdx
   40332:	48 89 d0             	mov    %rdx,%rax
   40335:	48 c1 e0 03          	shl    $0x3,%rax
   40339:	48 29 d0             	sub    %rdx,%rax
   4033c:	48 c1 e0 05          	shl    $0x5,%rax
   40340:	48 8d 15 d9 0c 01 00 	lea    0x10cd9(%rip),%rdx        # 51020 <processes>
   40347:	48 01 d0             	add    %rdx,%rax
   4034a:	be 00 00 00 00       	mov    $0x0,%esi
   4034f:	48 89 c7             	mov    %rax,%rdi
   40352:	e8 d2 1a 00 00       	call   41e29 <process_init>
    processes[pid].p_pagetable = kernel_pagetable;
   40357:	48 8b 15 a2 3c 01 00 	mov    0x13ca2(%rip),%rdx        # 54000 <kernel_pagetable>
   4035e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40361:	48 63 c8             	movslq %eax,%rcx
   40364:	48 89 c8             	mov    %rcx,%rax
   40367:	48 c1 e0 03          	shl    $0x3,%rax
   4036b:	48 29 c8             	sub    %rcx,%rax
   4036e:	48 c1 e0 05          	shl    $0x5,%rax
   40372:	48 89 c1             	mov    %rax,%rcx
   40375:	48 8d 05 74 0d 01 00 	lea    0x10d74(%rip),%rax        # 510f0 <processes+0xd0>
   4037c:	48 89 14 01          	mov    %rdx,(%rcx,%rax,1)
    ++pageinfo[PAGENUMBER(kernel_pagetable)].refcount; //increase refcount since kernel_pagetable was used
   40380:	48 8b 05 79 3c 01 00 	mov    0x13c79(%rip),%rax        # 54000 <kernel_pagetable>
   40387:	48 c1 e8 0c          	shr    $0xc,%rax
   4038b:	48 63 d0             	movslq %eax,%rdx
   4038e:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40392:	48 8d 15 a8 1a 01 00 	lea    0x11aa8(%rip),%rdx        # 51e41 <pageinfo+0x1>
   40399:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   4039d:	83 c2 01             	add    $0x1,%edx
   403a0:	89 d1                	mov    %edx,%ecx
   403a2:	48 98                	cltq   
   403a4:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   403a8:	48 8d 05 92 1a 01 00 	lea    0x11a92(%rip),%rax        # 51e41 <pageinfo+0x1>
   403af:	88 0c 02             	mov    %cl,(%rdx,%rax,1)

    int r = program_load(&processes[pid], program_number, NULL);
   403b2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403b5:	48 63 d0             	movslq %eax,%rdx
   403b8:	48 89 d0             	mov    %rdx,%rax
   403bb:	48 c1 e0 03          	shl    $0x3,%rax
   403bf:	48 29 d0             	sub    %rdx,%rax
   403c2:	48 c1 e0 05          	shl    $0x5,%rax
   403c6:	48 8d 15 53 0c 01 00 	lea    0x10c53(%rip),%rdx        # 51020 <processes>
   403cd:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
   403d1:	8b 45 e8             	mov    -0x18(%rbp),%eax
   403d4:	ba 00 00 00 00       	mov    $0x0,%edx
   403d9:	89 c6                	mov    %eax,%esi
   403db:	48 89 cf             	mov    %rcx,%rdi
   403de:	e8 45 2b 00 00       	call   42f28 <program_load>
   403e3:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   403e6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   403ea:	79 1e                	jns    4040a <process_setup+0xf0>
   403ec:	48 8d 05 26 3f 00 00 	lea    0x3f26(%rip),%rax        # 44319 <console_clear+0x70>
   403f3:	48 89 c2             	mov    %rax,%rdx
   403f6:	be 83 00 00 00       	mov    $0x83,%esi
   403fb:	48 8d 05 1e 3f 00 00 	lea    0x3f1e(%rip),%rax        # 44320 <console_clear+0x77>
   40402:	48 89 c7             	mov    %rax,%rdi
   40405:	e8 55 22 00 00       	call   4265f <assert_fail>

    processes[pid].p_registers.reg_rsp = PROC_START_ADDR + PROC_SIZE * pid;
   4040a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4040d:	83 c0 04             	add    $0x4,%eax
   40410:	c1 e0 12             	shl    $0x12,%eax
   40413:	48 63 d0             	movslq %eax,%rdx
   40416:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40419:	48 63 c8             	movslq %eax,%rcx
   4041c:	48 89 c8             	mov    %rcx,%rax
   4041f:	48 c1 e0 03          	shl    $0x3,%rax
   40423:	48 29 c8             	sub    %rcx,%rax
   40426:	48 c1 e0 05          	shl    $0x5,%rax
   4042a:	48 89 c1             	mov    %rax,%rcx
   4042d:	48 8d 05 a4 0c 01 00 	lea    0x10ca4(%rip),%rax        # 510d8 <processes+0xb8>
   40434:	48 89 14 01          	mov    %rdx,(%rcx,%rax,1)
    uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
   40438:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4043b:	48 63 d0             	movslq %eax,%rdx
   4043e:	48 89 d0             	mov    %rdx,%rax
   40441:	48 c1 e0 03          	shl    $0x3,%rax
   40445:	48 29 d0             	sub    %rdx,%rax
   40448:	48 c1 e0 05          	shl    $0x5,%rax
   4044c:	48 89 c2             	mov    %rax,%rdx
   4044f:	48 8d 05 82 0c 01 00 	lea    0x10c82(%rip),%rax        # 510d8 <processes+0xb8>
   40456:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4045a:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   40460:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assign_physical_page(stack_page, pid);
   40464:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40467:	0f be d0             	movsbl %al,%edx
   4046a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4046e:	89 d6                	mov    %edx,%esi
   40470:	48 89 c7             	mov    %rax,%rdi
   40473:	e8 65 00 00 00       	call   404dd <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page, stack_page,
   40478:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4047b:	48 63 d0             	movslq %eax,%rdx
   4047e:	48 89 d0             	mov    %rdx,%rax
   40481:	48 c1 e0 03          	shl    $0x3,%rax
   40485:	48 29 d0             	sub    %rdx,%rax
   40488:	48 c1 e0 05          	shl    $0x5,%rax
   4048c:	48 89 c2             	mov    %rax,%rdx
   4048f:	48 8d 05 5a 0c 01 00 	lea    0x10c5a(%rip),%rax        # 510f0 <processes+0xd0>
   40496:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   4049a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4049e:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   404a2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   404a8:	b9 00 10 00 00       	mov    $0x1000,%ecx
   404ad:	48 89 c7             	mov    %rax,%rdi
   404b0:	e8 2e 25 00 00       	call   429e3 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   404b5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   404b8:	48 63 d0             	movslq %eax,%rdx
   404bb:	48 89 d0             	mov    %rdx,%rax
   404be:	48 c1 e0 03          	shl    $0x3,%rax
   404c2:	48 29 d0             	sub    %rdx,%rax
   404c5:	48 c1 e0 05          	shl    $0x5,%rax
   404c9:	48 89 c2             	mov    %rax,%rdx
   404cc:	48 8d 05 15 0c 01 00 	lea    0x10c15(%rip),%rax        # 510e8 <processes+0xc8>
   404d3:	c7 04 02 01 00 00 00 	movl   $0x1,(%rdx,%rax,1)
}
   404da:	90                   	nop
   404db:	c9                   	leave  
   404dc:	c3                   	ret    

00000000000404dd <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   404dd:	f3 0f 1e fa          	endbr64 
   404e1:	55                   	push   %rbp
   404e2:	48 89 e5             	mov    %rsp,%rbp
   404e5:	48 83 ec 10          	sub    $0x10,%rsp
   404e9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   404ed:	89 f0                	mov    %esi,%eax
   404ef:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   404f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404f6:	25 ff 0f 00 00       	and    $0xfff,%eax
   404fb:	48 85 c0             	test   %rax,%rax
   404fe:	75 27                	jne    40527 <assign_physical_page+0x4a>
        || addr >= MEMSIZE_PHYSICAL
   40500:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40507:	00 
   40508:	77 1d                	ja     40527 <assign_physical_page+0x4a>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   4050a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4050e:	48 c1 e8 0c          	shr    $0xc,%rax
   40512:	48 98                	cltq   
   40514:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40518:	48 8d 05 22 19 01 00 	lea    0x11922(%rip),%rax        # 51e41 <pageinfo+0x1>
   4051f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40523:	84 c0                	test   %al,%al
   40525:	74 07                	je     4052e <assign_physical_page+0x51>
        return -1;
   40527:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4052c:	eb 3a                	jmp    40568 <assign_physical_page+0x8b>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   4052e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40532:	48 c1 e8 0c          	shr    $0xc,%rax
   40536:	48 98                	cltq   
   40538:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4053c:	48 8d 05 fe 18 01 00 	lea    0x118fe(%rip),%rax        # 51e41 <pageinfo+0x1>
   40543:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40547:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4054b:	48 c1 e8 0c          	shr    $0xc,%rax
   4054f:	48 98                	cltq   
   40551:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40555:	48 8d 15 e4 18 01 00 	lea    0x118e4(%rip),%rdx        # 51e40 <pageinfo>
   4055c:	0f b6 45 f4          	movzbl -0xc(%rbp),%eax
   40560:	88 04 11             	mov    %al,(%rcx,%rdx,1)
        return 0;
   40563:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40568:	c9                   	leave  
   40569:	c3                   	ret    

000000000004056a <syscall_mapping>:

void syscall_mapping(proc* p){
   4056a:	f3 0f 1e fa          	endbr64 
   4056e:	55                   	push   %rbp
   4056f:	48 89 e5             	mov    %rsp,%rbp
   40572:	48 83 ec 70          	sub    $0x70,%rsp
   40576:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   4057a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4057e:	48 8b 40 38          	mov    0x38(%rax),%rax
   40582:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40586:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4058a:	48 8b 40 30          	mov    0x30(%rax),%rax
   4058e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40592:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40596:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4059d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   405a1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   405a5:	48 89 ce             	mov    %rcx,%rsi
   405a8:	48 89 c7             	mov    %rax,%rdi
   405ab:	e8 7d 28 00 00       	call   42e2d <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   405b0:	8b 45 e0             	mov    -0x20(%rbp),%eax
   405b3:	48 98                	cltq   
   405b5:	83 e0 06             	and    $0x6,%eax
   405b8:	48 83 f8 06          	cmp    $0x6,%rax
   405bc:	75 73                	jne    40631 <syscall_mapping+0xc7>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   405be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405c2:	48 83 c0 17          	add    $0x17,%rax
   405c6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   405ca:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405ce:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   405d5:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   405d9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   405dd:	48 89 ce             	mov    %rcx,%rsi
   405e0:	48 89 c7             	mov    %rax,%rdi
   405e3:	e8 45 28 00 00       	call   42e2d <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   405e8:	8b 45 c8             	mov    -0x38(%rbp),%eax
   405eb:	48 98                	cltq   
   405ed:	83 e0 03             	and    $0x3,%eax
   405f0:	48 83 f8 03          	cmp    $0x3,%rax
   405f4:	75 3e                	jne    40634 <syscall_mapping+0xca>
        return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   405f6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405fa:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40601:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40605:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40609:	48 89 ce             	mov    %rcx,%rsi
   4060c:	48 89 c7             	mov    %rax,%rdi
   4060f:	e8 19 28 00 00       	call   42e2d <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40614:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40618:	48 89 c1             	mov    %rax,%rcx
   4061b:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4061f:	ba 18 00 00 00       	mov    $0x18,%edx
   40624:	48 89 c6             	mov    %rax,%rsi
   40627:	48 89 cf             	mov    %rcx,%rdi
   4062a:	e8 bf 2b 00 00       	call   431ee <memcpy>
   4062f:	eb 04                	jmp    40635 <syscall_mapping+0xcb>
        return;
   40631:	90                   	nop
   40632:	eb 01                	jmp    40635 <syscall_mapping+0xcb>
        return;
   40634:	90                   	nop
}
   40635:	c9                   	leave  
   40636:	c3                   	ret    

0000000000040637 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40637:	f3 0f 1e fa          	endbr64 
   4063b:	55                   	push   %rbp
   4063c:	48 89 e5             	mov    %rsp,%rbp
   4063f:	48 83 ec 18          	sub    $0x18,%rsp
   40643:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40647:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4064b:	48 8b 40 38          	mov    0x38(%rax),%rax
   4064f:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40652:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40656:	75 14                	jne    4066c <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   40658:	0f b6 05 a1 49 00 00 	movzbl 0x49a1(%rip),%eax        # 45000 <disp_global>
   4065f:	84 c0                	test   %al,%al
   40661:	0f 94 c0             	sete   %al
   40664:	88 05 96 49 00 00    	mov    %al,0x4996(%rip)        # 45000 <disp_global>
   4066a:	eb 36                	jmp    406a2 <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   4066c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40670:	78 2f                	js     406a1 <syscall_mem_tog+0x6a>
   40672:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40676:	7f 29                	jg     406a1 <syscall_mem_tog+0x6a>
   40678:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4067c:	8b 00                	mov    (%rax),%eax
   4067e:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40681:	75 1e                	jne    406a1 <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   40683:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40687:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   4068e:	84 c0                	test   %al,%al
   40690:	0f 94 c0             	sete   %al
   40693:	89 c2                	mov    %eax,%edx
   40695:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40699:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   4069f:	eb 01                	jmp    406a2 <syscall_mem_tog+0x6b>
            return;
   406a1:	90                   	nop
    }
}
   406a2:	c9                   	leave  
   406a3:	c3                   	ret    

00000000000406a4 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   406a4:	f3 0f 1e fa          	endbr64 
   406a8:	55                   	push   %rbp
   406a9:	48 89 e5             	mov    %rsp,%rbp
   406ac:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   406b3:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   406ba:	48 8b 05 3f 09 01 00 	mov    0x1093f(%rip),%rax        # 51000 <current>
   406c1:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   406c8:	48 83 c0 08          	add    $0x8,%rax
   406cc:	48 89 d6             	mov    %rdx,%rsi
   406cf:	ba 18 00 00 00       	mov    $0x18,%edx
   406d4:	48 89 c7             	mov    %rax,%rdi
   406d7:	48 89 d1             	mov    %rdx,%rcx
   406da:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   406dd:	48 8b 05 1c 39 01 00 	mov    0x1391c(%rip),%rax        # 54000 <kernel_pagetable>
   406e4:	48 89 c7             	mov    %rax,%rdi
   406e7:	e8 85 21 00 00       	call   42871 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   406ec:	8b 05 0a 89 07 00    	mov    0x7890a(%rip),%eax        # b8ffc <cursorpos>
   406f2:	89 c7                	mov    %eax,%edi
   406f4:	e8 fe 17 00 00       	call   41ef7 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   406f9:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40700:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40707:	48 83 f8 0e          	cmp    $0xe,%rax
   4070b:	74 14                	je     40721 <exception+0x7d>
   4070d:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40714:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4071b:	48 83 f8 0d          	cmp    $0xd,%rax
   4071f:	75 16                	jne    40737 <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40721:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40728:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4072f:	83 e0 04             	and    $0x4,%eax
   40732:	48 85 c0             	test   %rax,%rax
   40735:	74 1a                	je     40751 <exception+0xad>
    {
        check_virtual_memory();
   40737:	e8 01 08 00 00       	call   40f3d <check_virtual_memory>
        if(disp_global){
   4073c:	0f b6 05 bd 48 00 00 	movzbl 0x48bd(%rip),%eax        # 45000 <disp_global>
   40743:	84 c0                	test   %al,%al
   40745:	74 0a                	je     40751 <exception+0xad>
            memshow_physical();
   40747:	e8 ba 09 00 00       	call   41106 <memshow_physical>
            memshow_virtual_animate();
   4074c:	e8 57 0d 00 00       	call   414a8 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40751:	e8 b7 1c 00 00       	call   4240d <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40756:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4075d:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40764:	48 83 e8 0e          	sub    $0xe,%rax
   40768:	48 83 f8 2a          	cmp    $0x2a,%rax
   4076c:	0f 87 7e 02 00 00    	ja     409f0 <exception+0x34c>
   40772:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   40779:	00 
   4077a:	48 8d 05 3f 3c 00 00 	lea    0x3c3f(%rip),%rax        # 443c0 <console_clear+0x117>
   40781:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40784:	48 98                	cltq   
   40786:	48 8d 15 33 3c 00 00 	lea    0x3c33(%rip),%rdx        # 443c0 <console_clear+0x117>
   4078d:	48 01 d0             	add    %rdx,%rax
   40790:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40793:	48 8b 05 66 08 01 00 	mov    0x10866(%rip),%rax        # 51000 <current>
   4079a:	48 8b 40 38          	mov    0x38(%rax),%rax
   4079e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		if((void *)addr == NULL)
   407a2:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   407a7:	75 0f                	jne    407b8 <exception+0x114>
		    panic(NULL);
   407a9:	bf 00 00 00 00       	mov    $0x0,%edi
   407ae:	b8 00 00 00 00       	mov    $0x0,%eax
   407b3:	e8 b7 1d 00 00       	call   4256f <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   407b8:	48 8b 05 41 08 01 00 	mov    0x10841(%rip),%rax        # 51000 <current>
   407bf:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407c6:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   407ca:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   407ce:	48 89 ce             	mov    %rcx,%rsi
   407d1:	48 89 c7             	mov    %rax,%rdi
   407d4:	e8 54 26 00 00       	call   42e2d <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   407d9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   407dd:	48 89 c1             	mov    %rax,%rcx
   407e0:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   407e7:	ba a0 00 00 00       	mov    $0xa0,%edx
   407ec:	48 89 ce             	mov    %rcx,%rsi
   407ef:	48 89 c7             	mov    %rax,%rdi
   407f2:	e8 f7 29 00 00       	call   431ee <memcpy>
		panic(msg);
   407f7:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   407fe:	48 89 c7             	mov    %rax,%rdi
   40801:	b8 00 00 00 00       	mov    $0x0,%eax
   40806:	e8 64 1d 00 00       	call   4256f <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   4080b:	48 8b 05 ee 07 01 00 	mov    0x107ee(%rip),%rax        # 51000 <current>
   40812:	8b 10                	mov    (%rax),%edx
   40814:	48 8b 05 e5 07 01 00 	mov    0x107e5(%rip),%rax        # 51000 <current>
   4081b:	48 63 d2             	movslq %edx,%rdx
   4081e:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40822:	e9 d9 01 00 00       	jmp    40a00 <exception+0x35c>

    case INT_SYS_YIELD:
        schedule();
   40827:	e8 fd 01 00 00       	call   40a29 <schedule>
        break;                  /* will not be reached */
   4082c:	e9 cf 01 00 00       	jmp    40a00 <exception+0x35c>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t addr = current->p_registers.reg_rdi;
   40831:	48 8b 05 c8 07 01 00 	mov    0x107c8(%rip),%rax        # 51000 <current>
   40838:	48 8b 40 38          	mov    0x38(%rax),%rax
   4083c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        int r = assign_physical_page(addr, current->p_pid);
   40840:	48 8b 05 b9 07 01 00 	mov    0x107b9(%rip),%rax        # 51000 <current>
   40847:	8b 00                	mov    (%rax),%eax
   40849:	0f be d0             	movsbl %al,%edx
   4084c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40850:	89 d6                	mov    %edx,%esi
   40852:	48 89 c7             	mov    %rax,%rdi
   40855:	e8 83 fc ff ff       	call   404dd <assign_physical_page>
   4085a:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (r >= 0) {
   4085d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40861:	78 29                	js     4088c <exception+0x1e8>
            virtual_memory_map(current->p_pagetable, addr, addr,
   40863:	48 8b 05 96 07 01 00 	mov    0x10796(%rip),%rax        # 51000 <current>
   4086a:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40871:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40875:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40879:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4087f:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40884:	48 89 c7             	mov    %rax,%rdi
   40887:	e8 57 21 00 00       	call   429e3 <virtual_memory_map>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
        current->p_registers.reg_rax = r;
   4088c:	48 8b 05 6d 07 01 00 	mov    0x1076d(%rip),%rax        # 51000 <current>
   40893:	8b 55 f4             	mov    -0xc(%rbp),%edx
   40896:	48 63 d2             	movslq %edx,%rdx
   40899:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   4089d:	e9 5e 01 00 00       	jmp    40a00 <exception+0x35c>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   408a2:	48 8b 05 57 07 01 00 	mov    0x10757(%rip),%rax        # 51000 <current>
   408a9:	48 89 c7             	mov    %rax,%rdi
   408ac:	e8 b9 fc ff ff       	call   4056a <syscall_mapping>
            break;
   408b1:	e9 4a 01 00 00       	jmp    40a00 <exception+0x35c>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   408b6:	48 8b 05 43 07 01 00 	mov    0x10743(%rip),%rax        # 51000 <current>
   408bd:	48 89 c7             	mov    %rax,%rdi
   408c0:	e8 72 fd ff ff       	call   40637 <syscall_mem_tog>
	    break;
   408c5:	e9 36 01 00 00       	jmp    40a00 <exception+0x35c>
	}

    case INT_TIMER:
        ++ticks;
   408ca:	8b 05 50 15 01 00    	mov    0x11550(%rip),%eax        # 51e20 <ticks>
   408d0:	83 c0 01             	add    $0x1,%eax
   408d3:	89 05 47 15 01 00    	mov    %eax,0x11547(%rip)        # 51e20 <ticks>
        schedule();
   408d9:	e8 4b 01 00 00       	call   40a29 <schedule>
        break;                  /* will not be reached */
   408de:	e9 1d 01 00 00       	jmp    40a00 <exception+0x35c>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   408e3:	0f 20 d0             	mov    %cr2,%rax
   408e6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   408ea:	48 8b 45 c8          	mov    -0x38(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   408ee:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   408f2:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408f9:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40900:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40903:	48 85 c0             	test   %rax,%rax
   40906:	74 09                	je     40911 <exception+0x26d>
   40908:	48 8d 05 21 3a 00 00 	lea    0x3a21(%rip),%rax        # 44330 <console_clear+0x87>
   4090f:	eb 07                	jmp    40918 <exception+0x274>
   40911:	48 8d 05 1e 3a 00 00 	lea    0x3a1e(%rip),%rax        # 44336 <console_clear+0x8d>
        const char* operation = reg->reg_err & PFERR_WRITE
   40918:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   4091c:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40923:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4092a:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   4092d:	48 85 c0             	test   %rax,%rax
   40930:	74 09                	je     4093b <exception+0x297>
   40932:	48 8d 05 02 3a 00 00 	lea    0x3a02(%rip),%rax        # 4433b <console_clear+0x92>
   40939:	eb 07                	jmp    40942 <exception+0x29e>
   4093b:	48 8d 05 0c 3a 00 00 	lea    0x3a0c(%rip),%rax        # 4434e <console_clear+0xa5>
        const char* problem = reg->reg_err & PFERR_PRESENT
   40942:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40946:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4094d:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40954:	83 e0 04             	and    $0x4,%eax
   40957:	48 85 c0             	test   %rax,%rax
   4095a:	75 34                	jne    40990 <exception+0x2ec>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   4095c:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40963:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   4096a:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   4096e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40972:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40976:	49 89 f0             	mov    %rsi,%r8
   40979:	48 89 c6             	mov    %rax,%rsi
   4097c:	48 8d 05 dd 39 00 00 	lea    0x39dd(%rip),%rax        # 44360 <console_clear+0xb7>
   40983:	48 89 c7             	mov    %rax,%rdi
   40986:	b8 00 00 00 00       	mov    $0x0,%eax
   4098b:	e8 df 1b 00 00       	call   4256f <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40990:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40997:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   4099e:	48 8b 05 5b 06 01 00 	mov    0x1065b(%rip),%rax        # 51000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   409a5:	8b 00                	mov    (%rax),%eax
   409a7:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   409ab:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   409af:	52                   	push   %rdx
   409b0:	ff 75 d0             	push   -0x30(%rbp)
   409b3:	49 89 f1             	mov    %rsi,%r9
   409b6:	49 89 c8             	mov    %rcx,%r8
   409b9:	89 c1                	mov    %eax,%ecx
   409bb:	48 8d 05 ce 39 00 00 	lea    0x39ce(%rip),%rax        # 44390 <console_clear+0xe7>
   409c2:	48 89 c2             	mov    %rax,%rdx
   409c5:	be 00 0c 00 00       	mov    $0xc00,%esi
   409ca:	bf 80 07 00 00       	mov    $0x780,%edi
   409cf:	b8 00 00 00 00       	mov    $0x0,%eax
   409d4:	e8 5a 37 00 00       	call   44133 <console_printf>
   409d9:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   409dd:	48 8b 05 1c 06 01 00 	mov    0x1061c(%rip),%rax        # 51000 <current>
   409e4:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   409eb:	00 00 00 
        break;
   409ee:	eb 10                	jmp    40a00 <exception+0x35c>
    }

    default:
        default_exception(current);
   409f0:	48 8b 05 09 06 01 00 	mov    0x10609(%rip),%rax        # 51000 <current>
   409f7:	48 89 c7             	mov    %rax,%rdi
   409fa:	e8 99 1c 00 00       	call   42698 <default_exception>
        break;                  /* will not be reached */
   409ff:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40a00:	48 8b 05 f9 05 01 00 	mov    0x105f9(%rip),%rax        # 51000 <current>
   40a07:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40a0d:	83 f8 01             	cmp    $0x1,%eax
   40a10:	75 0f                	jne    40a21 <exception+0x37d>
        run(current);
   40a12:	48 8b 05 e7 05 01 00 	mov    0x105e7(%rip),%rax        # 51000 <current>
   40a19:	48 89 c7             	mov    %rax,%rdi
   40a1c:	e8 87 00 00 00       	call   40aa8 <run>
    } else {
        schedule();
   40a21:	e8 03 00 00 00       	call   40a29 <schedule>
    }
}
   40a26:	90                   	nop
   40a27:	c9                   	leave  
   40a28:	c3                   	ret    

0000000000040a29 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40a29:	f3 0f 1e fa          	endbr64 
   40a2d:	55                   	push   %rbp
   40a2e:	48 89 e5             	mov    %rsp,%rbp
   40a31:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40a35:	48 8b 05 c4 05 01 00 	mov    0x105c4(%rip),%rax        # 51000 <current>
   40a3c:	8b 00                	mov    (%rax),%eax
   40a3e:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40a41:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40a44:	83 c0 01             	add    $0x1,%eax
   40a47:	99                   	cltd   
   40a48:	c1 ea 1c             	shr    $0x1c,%edx
   40a4b:	01 d0                	add    %edx,%eax
   40a4d:	83 e0 0f             	and    $0xf,%eax
   40a50:	29 d0                	sub    %edx,%eax
   40a52:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40a55:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40a58:	48 63 d0             	movslq %eax,%rdx
   40a5b:	48 89 d0             	mov    %rdx,%rax
   40a5e:	48 c1 e0 03          	shl    $0x3,%rax
   40a62:	48 29 d0             	sub    %rdx,%rax
   40a65:	48 c1 e0 05          	shl    $0x5,%rax
   40a69:	48 89 c2             	mov    %rax,%rdx
   40a6c:	48 8d 05 75 06 01 00 	lea    0x10675(%rip),%rax        # 510e8 <processes+0xc8>
   40a73:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40a76:	83 f8 01             	cmp    $0x1,%eax
   40a79:	75 26                	jne    40aa1 <schedule+0x78>
            run(&processes[pid]);
   40a7b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40a7e:	48 63 d0             	movslq %eax,%rdx
   40a81:	48 89 d0             	mov    %rdx,%rax
   40a84:	48 c1 e0 03          	shl    $0x3,%rax
   40a88:	48 29 d0             	sub    %rdx,%rax
   40a8b:	48 c1 e0 05          	shl    $0x5,%rax
   40a8f:	48 8d 15 8a 05 01 00 	lea    0x1058a(%rip),%rdx        # 51020 <processes>
   40a96:	48 01 d0             	add    %rdx,%rax
   40a99:	48 89 c7             	mov    %rax,%rdi
   40a9c:	e8 07 00 00 00       	call   40aa8 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40aa1:	e8 67 19 00 00       	call   4240d <check_keyboard>
        pid = (pid + 1) % NPROC;
   40aa6:	eb 99                	jmp    40a41 <schedule+0x18>

0000000000040aa8 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40aa8:	f3 0f 1e fa          	endbr64 
   40aac:	55                   	push   %rbp
   40aad:	48 89 e5             	mov    %rsp,%rbp
   40ab0:	48 83 ec 10          	sub    $0x10,%rsp
   40ab4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40ab8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40abc:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40ac2:	83 f8 01             	cmp    $0x1,%eax
   40ac5:	74 1e                	je     40ae5 <run+0x3d>
   40ac7:	48 8d 05 9e 39 00 00 	lea    0x399e(%rip),%rax        # 4446c <console_clear+0x1c3>
   40ace:	48 89 c2             	mov    %rax,%rdx
   40ad1:	be 58 01 00 00       	mov    $0x158,%esi
   40ad6:	48 8d 05 43 38 00 00 	lea    0x3843(%rip),%rax        # 44320 <console_clear+0x77>
   40add:	48 89 c7             	mov    %rax,%rdi
   40ae0:	e8 7a 1b 00 00       	call   4265f <assert_fail>
    current = p;
   40ae5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ae9:	48 89 05 10 05 01 00 	mov    %rax,0x10510(%rip)        # 51000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40af0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40af4:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40afb:	48 89 c7             	mov    %rax,%rdi
   40afe:	e8 6e 1d 00 00       	call   42871 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40b03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b07:	48 83 c0 08          	add    $0x8,%rax
   40b0b:	48 89 c7             	mov    %rax,%rdi
   40b0e:	e8 b0 f5 ff ff       	call   400c3 <exception_return>

0000000000040b13 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40b13:	f3 0f 1e fa          	endbr64 
   40b17:	55                   	push   %rbp
   40b18:	48 89 e5             	mov    %rsp,%rbp
   40b1b:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40b1f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40b26:	00 
   40b27:	e9 93 00 00 00       	jmp    40bbf <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40b2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b30:	48 89 c7             	mov    %rax,%rdi
   40b33:	e8 0f 11 00 00       	call   41c47 <physical_memory_isreserved>
   40b38:	85 c0                	test   %eax,%eax
   40b3a:	74 09                	je     40b45 <pageinfo_init+0x32>
            owner = PO_RESERVED;
   40b3c:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40b43:	eb 31                	jmp    40b76 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40b45:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40b4c:	00 
   40b4d:	76 0d                	jbe    40b5c <pageinfo_init+0x49>
   40b4f:	48 8d 05 b2 94 01 00 	lea    0x194b2(%rip),%rax        # 5a008 <end>
   40b56:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b5a:	72 0a                	jb     40b66 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40b5c:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40b63:	00 
   40b64:	75 09                	jne    40b6f <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   40b66:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40b6d:	eb 07                	jmp    40b76 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   40b6f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40b76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b7a:	48 c1 e8 0c          	shr    $0xc,%rax
   40b7e:	89 c2                	mov    %eax,%edx
   40b80:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40b83:	89 c1                	mov    %eax,%ecx
   40b85:	48 63 c2             	movslq %edx,%rax
   40b88:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40b8c:	48 8d 05 ad 12 01 00 	lea    0x112ad(%rip),%rax        # 51e40 <pageinfo>
   40b93:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40b96:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40b9a:	0f 95 c2             	setne  %dl
   40b9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ba1:	48 c1 e8 0c          	shr    $0xc,%rax
   40ba5:	89 d1                	mov    %edx,%ecx
   40ba7:	48 98                	cltq   
   40ba9:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40bad:	48 8d 05 8d 12 01 00 	lea    0x1128d(%rip),%rax        # 51e41 <pageinfo+0x1>
   40bb4:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40bb7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40bbe:	00 
   40bbf:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40bc6:	00 
   40bc7:	0f 86 5f ff ff ff    	jbe    40b2c <pageinfo_init+0x19>
    }
}
   40bcd:	90                   	nop
   40bce:	90                   	nop
   40bcf:	c9                   	leave  
   40bd0:	c3                   	ret    

0000000000040bd1 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40bd1:	f3 0f 1e fa          	endbr64 
   40bd5:	55                   	push   %rbp
   40bd6:	48 89 e5             	mov    %rsp,%rbp
   40bd9:	48 83 ec 50          	sub    $0x50,%rsp
   40bdd:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40be1:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40be5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40beb:	48 89 c2             	mov    %rax,%rdx
   40bee:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40bf2:	48 39 c2             	cmp    %rax,%rdx
   40bf5:	74 1e                	je     40c15 <check_page_table_mappings+0x44>
   40bf7:	48 8d 05 8a 38 00 00 	lea    0x388a(%rip),%rax        # 44488 <console_clear+0x1df>
   40bfe:	48 89 c2             	mov    %rax,%rdx
   40c01:	be 82 01 00 00       	mov    $0x182,%esi
   40c06:	48 8d 05 13 37 00 00 	lea    0x3713(%rip),%rax        # 44320 <console_clear+0x77>
   40c0d:	48 89 c7             	mov    %rax,%rdi
   40c10:	e8 4a 1a 00 00       	call   4265f <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40c15:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40c1c:	00 
   40c1d:	e9 b5 00 00 00       	jmp    40cd7 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40c22:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40c26:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40c2a:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40c2e:	48 89 ce             	mov    %rcx,%rsi
   40c31:	48 89 c7             	mov    %rax,%rdi
   40c34:	e8 f4 21 00 00       	call   42e2d <virtual_memory_lookup>
        if (vam.pa != va) {
   40c39:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40c3d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40c41:	74 2c                	je     40c6f <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40c43:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40c47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c4b:	49 89 d0             	mov    %rdx,%r8
   40c4e:	48 89 c1             	mov    %rax,%rcx
   40c51:	48 8d 05 4f 38 00 00 	lea    0x384f(%rip),%rax        # 444a7 <console_clear+0x1fe>
   40c58:	48 89 c2             	mov    %rax,%rdx
   40c5b:	be 00 c0 00 00       	mov    $0xc000,%esi
   40c60:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40c65:	b8 00 00 00 00       	mov    $0x0,%eax
   40c6a:	e8 c4 34 00 00       	call   44133 <console_printf>
        }
        assert(vam.pa == va);
   40c6f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40c73:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40c77:	74 1e                	je     40c97 <check_page_table_mappings+0xc6>
   40c79:	48 8d 05 31 38 00 00 	lea    0x3831(%rip),%rax        # 444b1 <console_clear+0x208>
   40c80:	48 89 c2             	mov    %rax,%rdx
   40c83:	be 8b 01 00 00       	mov    $0x18b,%esi
   40c88:	48 8d 05 91 36 00 00 	lea    0x3691(%rip),%rax        # 44320 <console_clear+0x77>
   40c8f:	48 89 c7             	mov    %rax,%rdi
   40c92:	e8 c8 19 00 00       	call   4265f <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40c97:	48 8d 05 62 43 00 00 	lea    0x4362(%rip),%rax        # 45000 <disp_global>
   40c9e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ca2:	72 2b                	jb     40ccf <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   40ca4:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40ca7:	48 98                	cltq   
   40ca9:	83 e0 02             	and    $0x2,%eax
   40cac:	48 85 c0             	test   %rax,%rax
   40caf:	75 1e                	jne    40ccf <check_page_table_mappings+0xfe>
   40cb1:	48 8d 05 06 38 00 00 	lea    0x3806(%rip),%rax        # 444be <console_clear+0x215>
   40cb8:	48 89 c2             	mov    %rax,%rdx
   40cbb:	be 8d 01 00 00       	mov    $0x18d,%esi
   40cc0:	48 8d 05 59 36 00 00 	lea    0x3659(%rip),%rax        # 44320 <console_clear+0x77>
   40cc7:	48 89 c7             	mov    %rax,%rdi
   40cca:	e8 90 19 00 00       	call   4265f <assert_fail>
         va += PAGESIZE) {
   40ccf:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40cd6:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40cd7:	48 8d 05 2a 93 01 00 	lea    0x1932a(%rip),%rax        # 5a008 <end>
   40cde:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ce2:	0f 82 3a ff ff ff    	jb     40c22 <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40ce8:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40cef:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40cf0:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40cf4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40cf8:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40cfc:	48 89 ce             	mov    %rcx,%rsi
   40cff:	48 89 c7             	mov    %rax,%rdi
   40d02:	e8 26 21 00 00       	call   42e2d <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40d07:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d0b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40d0f:	74 1e                	je     40d2f <check_page_table_mappings+0x15e>
   40d11:	48 8d 05 b7 37 00 00 	lea    0x37b7(%rip),%rax        # 444cf <console_clear+0x226>
   40d18:	48 89 c2             	mov    %rax,%rdx
   40d1b:	be 94 01 00 00       	mov    $0x194,%esi
   40d20:	48 8d 05 f9 35 00 00 	lea    0x35f9(%rip),%rax        # 44320 <console_clear+0x77>
   40d27:	48 89 c7             	mov    %rax,%rdi
   40d2a:	e8 30 19 00 00       	call   4265f <assert_fail>
    assert(vam.perm & PTE_W);
   40d2f:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40d32:	48 98                	cltq   
   40d34:	83 e0 02             	and    $0x2,%eax
   40d37:	48 85 c0             	test   %rax,%rax
   40d3a:	75 1e                	jne    40d5a <check_page_table_mappings+0x189>
   40d3c:	48 8d 05 7b 37 00 00 	lea    0x377b(%rip),%rax        # 444be <console_clear+0x215>
   40d43:	48 89 c2             	mov    %rax,%rdx
   40d46:	be 95 01 00 00       	mov    $0x195,%esi
   40d4b:	48 8d 05 ce 35 00 00 	lea    0x35ce(%rip),%rax        # 44320 <console_clear+0x77>
   40d52:	48 89 c7             	mov    %rax,%rdi
   40d55:	e8 05 19 00 00       	call   4265f <assert_fail>
}
   40d5a:	90                   	nop
   40d5b:	c9                   	leave  
   40d5c:	c3                   	ret    

0000000000040d5d <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40d5d:	f3 0f 1e fa          	endbr64 
   40d61:	55                   	push   %rbp
   40d62:	48 89 e5             	mov    %rsp,%rbp
   40d65:	48 83 ec 20          	sub    $0x20,%rsp
   40d69:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40d6d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40d70:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40d73:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40d76:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40d7d:	48 8b 05 7c 32 01 00 	mov    0x1327c(%rip),%rax        # 54000 <kernel_pagetable>
   40d84:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40d88:	75 71                	jne    40dfb <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   40d8a:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40d91:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40d98:	eb 5b                	jmp    40df5 <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   40d9a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40d9d:	48 63 d0             	movslq %eax,%rdx
   40da0:	48 89 d0             	mov    %rdx,%rax
   40da3:	48 c1 e0 03          	shl    $0x3,%rax
   40da7:	48 29 d0             	sub    %rdx,%rax
   40daa:	48 c1 e0 05          	shl    $0x5,%rax
   40dae:	48 89 c2             	mov    %rax,%rdx
   40db1:	48 8d 05 30 03 01 00 	lea    0x10330(%rip),%rax        # 510e8 <processes+0xc8>
   40db8:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40dbb:	85 c0                	test   %eax,%eax
   40dbd:	74 32                	je     40df1 <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40dbf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40dc2:	48 63 d0             	movslq %eax,%rdx
   40dc5:	48 89 d0             	mov    %rdx,%rax
   40dc8:	48 c1 e0 03          	shl    $0x3,%rax
   40dcc:	48 29 d0             	sub    %rdx,%rax
   40dcf:	48 c1 e0 05          	shl    $0x5,%rax
   40dd3:	48 89 c2             	mov    %rax,%rdx
   40dd6:	48 8d 05 13 03 01 00 	lea    0x10313(%rip),%rax        # 510f0 <processes+0xd0>
   40ddd:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   40de1:	48 8b 05 18 32 01 00 	mov    0x13218(%rip),%rax        # 54000 <kernel_pagetable>
   40de8:	48 39 c2             	cmp    %rax,%rdx
   40deb:	75 04                	jne    40df1 <check_page_table_ownership+0x94>
                ++expected_refcount;
   40ded:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40df1:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40df5:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40df9:	7e 9f                	jle    40d9a <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40dfb:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40dfe:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40e01:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e05:	be 00 00 00 00       	mov    $0x0,%esi
   40e0a:	48 89 c7             	mov    %rax,%rdi
   40e0d:	e8 03 00 00 00       	call   40e15 <check_page_table_ownership_level>
}
   40e12:	90                   	nop
   40e13:	c9                   	leave  
   40e14:	c3                   	ret    

0000000000040e15 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40e15:	f3 0f 1e fa          	endbr64 
   40e19:	55                   	push   %rbp
   40e1a:	48 89 e5             	mov    %rsp,%rbp
   40e1d:	48 83 ec 30          	sub    $0x30,%rsp
   40e21:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40e25:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40e28:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40e2b:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40e2e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e32:	48 c1 e8 0c          	shr    $0xc,%rax
   40e36:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40e3b:	7e 1e                	jle    40e5b <check_page_table_ownership_level+0x46>
   40e3d:	48 8d 05 9c 36 00 00 	lea    0x369c(%rip),%rax        # 444e0 <console_clear+0x237>
   40e44:	48 89 c2             	mov    %rax,%rdx
   40e47:	be b2 01 00 00       	mov    $0x1b2,%esi
   40e4c:	48 8d 05 cd 34 00 00 	lea    0x34cd(%rip),%rax        # 44320 <console_clear+0x77>
   40e53:	48 89 c7             	mov    %rax,%rdi
   40e56:	e8 04 18 00 00       	call   4265f <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40e5b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e5f:	48 c1 e8 0c          	shr    $0xc,%rax
   40e63:	48 98                	cltq   
   40e65:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40e69:	48 8d 05 d0 0f 01 00 	lea    0x10fd0(%rip),%rax        # 51e40 <pageinfo>
   40e70:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40e74:	0f be c0             	movsbl %al,%eax
   40e77:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40e7a:	74 1e                	je     40e9a <check_page_table_ownership_level+0x85>
   40e7c:	48 8d 05 75 36 00 00 	lea    0x3675(%rip),%rax        # 444f8 <console_clear+0x24f>
   40e83:	48 89 c2             	mov    %rax,%rdx
   40e86:	be b3 01 00 00       	mov    $0x1b3,%esi
   40e8b:	48 8d 05 8e 34 00 00 	lea    0x348e(%rip),%rax        # 44320 <console_clear+0x77>
   40e92:	48 89 c7             	mov    %rax,%rdi
   40e95:	e8 c5 17 00 00       	call   4265f <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40e9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e9e:	48 c1 e8 0c          	shr    $0xc,%rax
   40ea2:	48 98                	cltq   
   40ea4:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40ea8:	48 8d 05 92 0f 01 00 	lea    0x10f92(%rip),%rax        # 51e41 <pageinfo+0x1>
   40eaf:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40eb3:	0f be c0             	movsbl %al,%eax
   40eb6:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40eb9:	74 1e                	je     40ed9 <check_page_table_ownership_level+0xc4>
   40ebb:	48 8d 05 5e 36 00 00 	lea    0x365e(%rip),%rax        # 44520 <console_clear+0x277>
   40ec2:	48 89 c2             	mov    %rax,%rdx
   40ec5:	be b4 01 00 00       	mov    $0x1b4,%esi
   40eca:	48 8d 05 4f 34 00 00 	lea    0x344f(%rip),%rax        # 44320 <console_clear+0x77>
   40ed1:	48 89 c7             	mov    %rax,%rdi
   40ed4:	e8 86 17 00 00       	call   4265f <assert_fail>
    if (level < 3) {
   40ed9:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40edd:	7f 5b                	jg     40f3a <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40edf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40ee6:	eb 49                	jmp    40f31 <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   40ee8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40eec:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40eef:	48 63 d2             	movslq %edx,%rdx
   40ef2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40ef6:	48 85 c0             	test   %rax,%rax
   40ef9:	74 32                	je     40f2d <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40efb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40eff:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f02:	48 63 d2             	movslq %edx,%rdx
   40f05:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40f09:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40f0f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40f13:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40f16:	8d 70 01             	lea    0x1(%rax),%esi
   40f19:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40f1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f20:	b9 01 00 00 00       	mov    $0x1,%ecx
   40f25:	48 89 c7             	mov    %rax,%rdi
   40f28:	e8 e8 fe ff ff       	call   40e15 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40f2d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40f31:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40f38:	7e ae                	jle    40ee8 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   40f3a:	90                   	nop
   40f3b:	c9                   	leave  
   40f3c:	c3                   	ret    

0000000000040f3d <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40f3d:	f3 0f 1e fa          	endbr64 
   40f41:	55                   	push   %rbp
   40f42:	48 89 e5             	mov    %rsp,%rbp
   40f45:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40f49:	8b 05 99 01 01 00    	mov    0x10199(%rip),%eax        # 510e8 <processes+0xc8>
   40f4f:	85 c0                	test   %eax,%eax
   40f51:	74 1e                	je     40f71 <check_virtual_memory+0x34>
   40f53:	48 8d 05 f6 35 00 00 	lea    0x35f6(%rip),%rax        # 44550 <console_clear+0x2a7>
   40f5a:	48 89 c2             	mov    %rax,%rdx
   40f5d:	be c7 01 00 00       	mov    $0x1c7,%esi
   40f62:	48 8d 05 b7 33 00 00 	lea    0x33b7(%rip),%rax        # 44320 <console_clear+0x77>
   40f69:	48 89 c7             	mov    %rax,%rdi
   40f6c:	e8 ee 16 00 00       	call   4265f <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40f71:	48 8b 05 88 30 01 00 	mov    0x13088(%rip),%rax        # 54000 <kernel_pagetable>
   40f78:	48 89 c7             	mov    %rax,%rdi
   40f7b:	e8 51 fc ff ff       	call   40bd1 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40f80:	48 8b 05 79 30 01 00 	mov    0x13079(%rip),%rax        # 54000 <kernel_pagetable>
   40f87:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40f8c:	48 89 c7             	mov    %rax,%rdi
   40f8f:	e8 c9 fd ff ff       	call   40d5d <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40f94:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40f9b:	e9 b4 00 00 00       	jmp    41054 <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   40fa0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fa3:	48 63 d0             	movslq %eax,%rdx
   40fa6:	48 89 d0             	mov    %rdx,%rax
   40fa9:	48 c1 e0 03          	shl    $0x3,%rax
   40fad:	48 29 d0             	sub    %rdx,%rax
   40fb0:	48 c1 e0 05          	shl    $0x5,%rax
   40fb4:	48 89 c2             	mov    %rax,%rdx
   40fb7:	48 8d 05 2a 01 01 00 	lea    0x1012a(%rip),%rax        # 510e8 <processes+0xc8>
   40fbe:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40fc1:	85 c0                	test   %eax,%eax
   40fc3:	0f 84 87 00 00 00    	je     41050 <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   40fc9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fcc:	48 63 d0             	movslq %eax,%rdx
   40fcf:	48 89 d0             	mov    %rdx,%rax
   40fd2:	48 c1 e0 03          	shl    $0x3,%rax
   40fd6:	48 29 d0             	sub    %rdx,%rax
   40fd9:	48 c1 e0 05          	shl    $0x5,%rax
   40fdd:	48 89 c2             	mov    %rax,%rdx
   40fe0:	48 8d 05 09 01 01 00 	lea    0x10109(%rip),%rax        # 510f0 <processes+0xd0>
   40fe7:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   40feb:	48 8b 05 0e 30 01 00 	mov    0x1300e(%rip),%rax        # 54000 <kernel_pagetable>
   40ff2:	48 39 c2             	cmp    %rax,%rdx
   40ff5:	74 59                	je     41050 <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   40ff7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ffa:	48 63 d0             	movslq %eax,%rdx
   40ffd:	48 89 d0             	mov    %rdx,%rax
   41000:	48 c1 e0 03          	shl    $0x3,%rax
   41004:	48 29 d0             	sub    %rdx,%rax
   41007:	48 c1 e0 05          	shl    $0x5,%rax
   4100b:	48 89 c2             	mov    %rax,%rdx
   4100e:	48 8d 05 db 00 01 00 	lea    0x100db(%rip),%rax        # 510f0 <processes+0xd0>
   41015:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41019:	48 89 c7             	mov    %rax,%rdi
   4101c:	e8 b0 fb ff ff       	call   40bd1 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41021:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41024:	48 63 d0             	movslq %eax,%rdx
   41027:	48 89 d0             	mov    %rdx,%rax
   4102a:	48 c1 e0 03          	shl    $0x3,%rax
   4102e:	48 29 d0             	sub    %rdx,%rax
   41031:	48 c1 e0 05          	shl    $0x5,%rax
   41035:	48 89 c2             	mov    %rax,%rdx
   41038:	48 8d 05 b1 00 01 00 	lea    0x100b1(%rip),%rax        # 510f0 <processes+0xd0>
   4103f:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41043:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41046:	89 d6                	mov    %edx,%esi
   41048:	48 89 c7             	mov    %rax,%rdi
   4104b:	e8 0d fd ff ff       	call   40d5d <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41050:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41054:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41058:	0f 8e 42 ff ff ff    	jle    40fa0 <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4105e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41065:	e9 8b 00 00 00       	jmp    410f5 <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4106a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4106d:	48 98                	cltq   
   4106f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41073:	48 8d 05 c7 0d 01 00 	lea    0x10dc7(%rip),%rax        # 51e41 <pageinfo+0x1>
   4107a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4107e:	84 c0                	test   %al,%al
   41080:	7e 6f                	jle    410f1 <check_virtual_memory+0x1b4>
   41082:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41085:	48 98                	cltq   
   41087:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4108b:	48 8d 05 ae 0d 01 00 	lea    0x10dae(%rip),%rax        # 51e40 <pageinfo>
   41092:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41096:	84 c0                	test   %al,%al
   41098:	78 57                	js     410f1 <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4109a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4109d:	48 98                	cltq   
   4109f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   410a3:	48 8d 05 96 0d 01 00 	lea    0x10d96(%rip),%rax        # 51e40 <pageinfo>
   410aa:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   410ae:	0f be c0             	movsbl %al,%eax
   410b1:	48 63 d0             	movslq %eax,%rdx
   410b4:	48 89 d0             	mov    %rdx,%rax
   410b7:	48 c1 e0 03          	shl    $0x3,%rax
   410bb:	48 29 d0             	sub    %rdx,%rax
   410be:	48 c1 e0 05          	shl    $0x5,%rax
   410c2:	48 89 c2             	mov    %rax,%rdx
   410c5:	48 8d 05 1c 00 01 00 	lea    0x1001c(%rip),%rax        # 510e8 <processes+0xc8>
   410cc:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   410cf:	85 c0                	test   %eax,%eax
   410d1:	75 1e                	jne    410f1 <check_virtual_memory+0x1b4>
   410d3:	48 8d 05 96 34 00 00 	lea    0x3496(%rip),%rax        # 44570 <console_clear+0x2c7>
   410da:	48 89 c2             	mov    %rax,%rdx
   410dd:	be de 01 00 00       	mov    $0x1de,%esi
   410e2:	48 8d 05 37 32 00 00 	lea    0x3237(%rip),%rax        # 44320 <console_clear+0x77>
   410e9:	48 89 c7             	mov    %rax,%rdi
   410ec:	e8 6e 15 00 00       	call   4265f <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   410f1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   410f5:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   410fc:	0f 8e 68 ff ff ff    	jle    4106a <check_virtual_memory+0x12d>
        }
    }
}
   41102:	90                   	nop
   41103:	90                   	nop
   41104:	c9                   	leave  
   41105:	c3                   	ret    

0000000000041106 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41106:	f3 0f 1e fa          	endbr64 
   4110a:	55                   	push   %rbp
   4110b:	48 89 e5             	mov    %rsp,%rbp
   4110e:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41112:	48 8d 05 ad 34 00 00 	lea    0x34ad(%rip),%rax        # 445c6 <memstate_colors+0x26>
   41119:	48 89 c2             	mov    %rax,%rdx
   4111c:	be 00 0f 00 00       	mov    $0xf00,%esi
   41121:	bf 20 00 00 00       	mov    $0x20,%edi
   41126:	b8 00 00 00 00       	mov    $0x0,%eax
   4112b:	e8 03 30 00 00       	call   44133 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41130:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41137:	e9 1b 01 00 00       	jmp    41257 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   4113c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4113f:	83 e0 3f             	and    $0x3f,%eax
   41142:	85 c0                	test   %eax,%eax
   41144:	75 40                	jne    41186 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41146:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41149:	c1 e0 0c             	shl    $0xc,%eax
   4114c:	89 c2                	mov    %eax,%edx
   4114e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41151:	8d 48 3f             	lea    0x3f(%rax),%ecx
   41154:	85 c0                	test   %eax,%eax
   41156:	0f 48 c1             	cmovs  %ecx,%eax
   41159:	c1 f8 06             	sar    $0x6,%eax
   4115c:	8d 48 01             	lea    0x1(%rax),%ecx
   4115f:	89 c8                	mov    %ecx,%eax
   41161:	c1 e0 02             	shl    $0x2,%eax
   41164:	01 c8                	add    %ecx,%eax
   41166:	c1 e0 04             	shl    $0x4,%eax
   41169:	83 c0 03             	add    $0x3,%eax
   4116c:	89 d1                	mov    %edx,%ecx
   4116e:	48 8d 15 61 34 00 00 	lea    0x3461(%rip),%rdx        # 445d6 <memstate_colors+0x36>
   41175:	be 00 0f 00 00       	mov    $0xf00,%esi
   4117a:	89 c7                	mov    %eax,%edi
   4117c:	b8 00 00 00 00       	mov    $0x0,%eax
   41181:	e8 ad 2f 00 00       	call   44133 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41186:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41189:	48 98                	cltq   
   4118b:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4118f:	48 8d 05 aa 0c 01 00 	lea    0x10caa(%rip),%rax        # 51e40 <pageinfo>
   41196:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4119a:	0f be c0             	movsbl %al,%eax
   4119d:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   411a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411a3:	48 98                	cltq   
   411a5:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   411a9:	48 8d 05 91 0c 01 00 	lea    0x10c91(%rip),%rax        # 51e41 <pageinfo+0x1>
   411b0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   411b4:	84 c0                	test   %al,%al
   411b6:	75 07                	jne    411bf <memshow_physical+0xb9>
            owner = PO_FREE;
   411b8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   411bf:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411c2:	83 c0 02             	add    $0x2,%eax
   411c5:	48 98                	cltq   
   411c7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   411cb:	48 8d 05 ce 33 00 00 	lea    0x33ce(%rip),%rax        # 445a0 <memstate_colors>
   411d2:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   411d6:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   411da:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411dd:	48 98                	cltq   
   411df:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   411e3:	48 8d 05 57 0c 01 00 	lea    0x10c57(%rip),%rax        # 51e41 <pageinfo+0x1>
   411ea:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   411ee:	3c 01                	cmp    $0x1,%al
   411f0:	7e 1c                	jle    4120e <memshow_physical+0x108>
   411f2:	48 8d 05 07 6e 07 00 	lea    0x76e07(%rip),%rax        # b8000 <console>
   411f9:	48 c1 e8 0c          	shr    $0xc,%rax
   411fd:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41200:	74 0c                	je     4120e <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41202:	b8 53 00 00 00       	mov    $0x53,%eax
   41207:	80 cc 0f             	or     $0xf,%ah
   4120a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4120e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41211:	8d 50 3f             	lea    0x3f(%rax),%edx
   41214:	85 c0                	test   %eax,%eax
   41216:	0f 48 c2             	cmovs  %edx,%eax
   41219:	c1 f8 06             	sar    $0x6,%eax
   4121c:	8d 50 01             	lea    0x1(%rax),%edx
   4121f:	89 d0                	mov    %edx,%eax
   41221:	c1 e0 02             	shl    $0x2,%eax
   41224:	01 d0                	add    %edx,%eax
   41226:	c1 e0 04             	shl    $0x4,%eax
   41229:	89 c1                	mov    %eax,%ecx
   4122b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4122e:	99                   	cltd   
   4122f:	c1 ea 1a             	shr    $0x1a,%edx
   41232:	01 d0                	add    %edx,%eax
   41234:	83 e0 3f             	and    $0x3f,%eax
   41237:	29 d0                	sub    %edx,%eax
   41239:	83 c0 0c             	add    $0xc,%eax
   4123c:	01 c8                	add    %ecx,%eax
   4123e:	48 98                	cltq   
   41240:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41244:	48 8d 15 b5 6d 07 00 	lea    0x76db5(%rip),%rdx        # b8000 <console>
   4124b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4124f:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41253:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41257:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4125e:	0f 8e d8 fe ff ff    	jle    4113c <memshow_physical+0x36>
    }
}
   41264:	90                   	nop
   41265:	90                   	nop
   41266:	c9                   	leave  
   41267:	c3                   	ret    

0000000000041268 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41268:	f3 0f 1e fa          	endbr64 
   4126c:	55                   	push   %rbp
   4126d:	48 89 e5             	mov    %rsp,%rbp
   41270:	48 83 ec 40          	sub    $0x40,%rsp
   41274:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41278:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   4127c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41280:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41286:	48 89 c2             	mov    %rax,%rdx
   41289:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4128d:	48 39 c2             	cmp    %rax,%rdx
   41290:	74 1e                	je     412b0 <memshow_virtual+0x48>
   41292:	48 8d 05 47 33 00 00 	lea    0x3347(%rip),%rax        # 445e0 <memstate_colors+0x40>
   41299:	48 89 c2             	mov    %rax,%rdx
   4129c:	be 0f 02 00 00       	mov    $0x20f,%esi
   412a1:	48 8d 05 78 30 00 00 	lea    0x3078(%rip),%rax        # 44320 <console_clear+0x77>
   412a8:	48 89 c7             	mov    %rax,%rdi
   412ab:	e8 af 13 00 00       	call   4265f <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   412b0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   412b4:	48 89 c1             	mov    %rax,%rcx
   412b7:	48 8d 05 4f 33 00 00 	lea    0x334f(%rip),%rax        # 4460d <memstate_colors+0x6d>
   412be:	48 89 c2             	mov    %rax,%rdx
   412c1:	be 00 0f 00 00       	mov    $0xf00,%esi
   412c6:	bf 3a 03 00 00       	mov    $0x33a,%edi
   412cb:	b8 00 00 00 00       	mov    $0x0,%eax
   412d0:	e8 5e 2e 00 00       	call   44133 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   412d5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   412dc:	00 
   412dd:	e9 b4 01 00 00       	jmp    41496 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   412e2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   412e6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   412ea:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   412ee:	48 89 ce             	mov    %rcx,%rsi
   412f1:	48 89 c7             	mov    %rax,%rdi
   412f4:	e8 34 1b 00 00       	call   42e2d <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   412f9:	8b 45 d0             	mov    -0x30(%rbp),%eax
   412fc:	85 c0                	test   %eax,%eax
   412fe:	79 0b                	jns    4130b <memshow_virtual+0xa3>
            color = ' ';
   41300:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41306:	e9 ff 00 00 00       	jmp    4140a <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   4130b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4130f:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41315:	76 1e                	jbe    41335 <memshow_virtual+0xcd>
   41317:	48 8d 05 0c 33 00 00 	lea    0x330c(%rip),%rax        # 4462a <memstate_colors+0x8a>
   4131e:	48 89 c2             	mov    %rax,%rdx
   41321:	be 18 02 00 00       	mov    $0x218,%esi
   41326:	48 8d 05 f3 2f 00 00 	lea    0x2ff3(%rip),%rax        # 44320 <console_clear+0x77>
   4132d:	48 89 c7             	mov    %rax,%rdi
   41330:	e8 2a 13 00 00       	call   4265f <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41335:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41338:	48 98                	cltq   
   4133a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4133e:	48 8d 05 fb 0a 01 00 	lea    0x10afb(%rip),%rax        # 51e40 <pageinfo>
   41345:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41349:	0f be c0             	movsbl %al,%eax
   4134c:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   4134f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41352:	48 98                	cltq   
   41354:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41358:	48 8d 05 e2 0a 01 00 	lea    0x10ae2(%rip),%rax        # 51e41 <pageinfo+0x1>
   4135f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41363:	84 c0                	test   %al,%al
   41365:	75 07                	jne    4136e <memshow_virtual+0x106>
                owner = PO_FREE;
   41367:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   4136e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41371:	83 c0 02             	add    $0x2,%eax
   41374:	48 98                	cltq   
   41376:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4137a:	48 8d 05 1f 32 00 00 	lea    0x321f(%rip),%rax        # 445a0 <memstate_colors>
   41381:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41385:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41389:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4138c:	48 98                	cltq   
   4138e:	83 e0 04             	and    $0x4,%eax
   41391:	48 85 c0             	test   %rax,%rax
   41394:	74 27                	je     413bd <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41396:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4139a:	c1 e0 04             	shl    $0x4,%eax
   4139d:	66 25 00 f0          	and    $0xf000,%ax
   413a1:	89 c2                	mov    %eax,%edx
   413a3:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413a7:	c1 f8 04             	sar    $0x4,%eax
   413aa:	66 25 00 0f          	and    $0xf00,%ax
   413ae:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   413b0:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413b4:	0f b6 c0             	movzbl %al,%eax
   413b7:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   413b9:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   413bd:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413c0:	48 98                	cltq   
   413c2:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   413c6:	48 8d 05 74 0a 01 00 	lea    0x10a74(%rip),%rax        # 51e41 <pageinfo+0x1>
   413cd:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   413d1:	3c 01                	cmp    $0x1,%al
   413d3:	7e 35                	jle    4140a <memshow_virtual+0x1a2>
   413d5:	48 8d 05 24 6c 07 00 	lea    0x76c24(%rip),%rax        # b8000 <console>
   413dc:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413e0:	74 28                	je     4140a <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   413e2:	b8 53 00 00 00       	mov    $0x53,%eax
   413e7:	89 c2                	mov    %eax,%edx
   413e9:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413ed:	66 25 00 f0          	and    $0xf000,%ax
   413f1:	09 d0                	or     %edx,%eax
   413f3:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   413f7:	8b 45 e0             	mov    -0x20(%rbp),%eax
   413fa:	48 98                	cltq   
   413fc:	83 e0 04             	and    $0x4,%eax
   413ff:	48 85 c0             	test   %rax,%rax
   41402:	75 06                	jne    4140a <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   41404:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4140a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4140e:	48 c1 e8 0c          	shr    $0xc,%rax
   41412:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41415:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41418:	83 e0 3f             	and    $0x3f,%eax
   4141b:	85 c0                	test   %eax,%eax
   4141d:	75 39                	jne    41458 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   4141f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41422:	c1 e8 06             	shr    $0x6,%eax
   41425:	89 c2                	mov    %eax,%edx
   41427:	89 d0                	mov    %edx,%eax
   41429:	c1 e0 02             	shl    $0x2,%eax
   4142c:	01 d0                	add    %edx,%eax
   4142e:	c1 e0 04             	shl    $0x4,%eax
   41431:	05 73 03 00 00       	add    $0x373,%eax
   41436:	89 c7                	mov    %eax,%edi
   41438:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4143c:	48 89 c1             	mov    %rax,%rcx
   4143f:	48 8d 05 90 31 00 00 	lea    0x3190(%rip),%rax        # 445d6 <memstate_colors+0x36>
   41446:	48 89 c2             	mov    %rax,%rdx
   41449:	be 00 0f 00 00       	mov    $0xf00,%esi
   4144e:	b8 00 00 00 00       	mov    $0x0,%eax
   41453:	e8 db 2c 00 00       	call   44133 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41458:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4145b:	c1 e8 06             	shr    $0x6,%eax
   4145e:	89 c2                	mov    %eax,%edx
   41460:	89 d0                	mov    %edx,%eax
   41462:	c1 e0 02             	shl    $0x2,%eax
   41465:	01 d0                	add    %edx,%eax
   41467:	c1 e0 04             	shl    $0x4,%eax
   4146a:	89 c2                	mov    %eax,%edx
   4146c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4146f:	83 e0 3f             	and    $0x3f,%eax
   41472:	01 d0                	add    %edx,%eax
   41474:	05 7c 03 00 00       	add    $0x37c,%eax
   41479:	89 c0                	mov    %eax,%eax
   4147b:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   4147f:	48 8d 15 7a 6b 07 00 	lea    0x76b7a(%rip),%rdx        # b8000 <console>
   41486:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4148a:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4148e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41495:	00 
   41496:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4149d:	00 
   4149e:	0f 86 3e fe ff ff    	jbe    412e2 <memshow_virtual+0x7a>
    }
}
   414a4:	90                   	nop
   414a5:	90                   	nop
   414a6:	c9                   	leave  
   414a7:	c3                   	ret    

00000000000414a8 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   414a8:	f3 0f 1e fa          	endbr64 
   414ac:	55                   	push   %rbp
   414ad:	48 89 e5             	mov    %rsp,%rbp
   414b0:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   414b4:	8b 05 86 0d 01 00    	mov    0x10d86(%rip),%eax        # 52240 <last_ticks.1>
   414ba:	85 c0                	test   %eax,%eax
   414bc:	74 13                	je     414d1 <memshow_virtual_animate+0x29>
   414be:	8b 05 5c 09 01 00    	mov    0x1095c(%rip),%eax        # 51e20 <ticks>
   414c4:	8b 15 76 0d 01 00    	mov    0x10d76(%rip),%edx        # 52240 <last_ticks.1>
   414ca:	29 d0                	sub    %edx,%eax
   414cc:	83 f8 31             	cmp    $0x31,%eax
   414cf:	76 2c                	jbe    414fd <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   414d1:	8b 05 49 09 01 00    	mov    0x10949(%rip),%eax        # 51e20 <ticks>
   414d7:	89 05 63 0d 01 00    	mov    %eax,0x10d63(%rip)        # 52240 <last_ticks.1>
        ++showing;
   414dd:	8b 05 21 3b 00 00    	mov    0x3b21(%rip),%eax        # 45004 <showing.0>
   414e3:	83 c0 01             	add    $0x1,%eax
   414e6:	89 05 18 3b 00 00    	mov    %eax,0x3b18(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   414ec:	eb 0f                	jmp    414fd <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   414ee:	8b 05 10 3b 00 00    	mov    0x3b10(%rip),%eax        # 45004 <showing.0>
   414f4:	83 c0 01             	add    $0x1,%eax
   414f7:	89 05 07 3b 00 00    	mov    %eax,0x3b07(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   414fd:	8b 05 01 3b 00 00    	mov    0x3b01(%rip),%eax        # 45004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41503:	83 f8 20             	cmp    $0x20,%eax
   41506:	7f 6b                	jg     41573 <memshow_virtual_animate+0xcb>
   41508:	8b 05 f6 3a 00 00    	mov    0x3af6(%rip),%eax        # 45004 <showing.0>
   4150e:	99                   	cltd   
   4150f:	c1 ea 1c             	shr    $0x1c,%edx
   41512:	01 d0                	add    %edx,%eax
   41514:	83 e0 0f             	and    $0xf,%eax
   41517:	29 d0                	sub    %edx,%eax
   41519:	48 63 d0             	movslq %eax,%rdx
   4151c:	48 89 d0             	mov    %rdx,%rax
   4151f:	48 c1 e0 03          	shl    $0x3,%rax
   41523:	48 29 d0             	sub    %rdx,%rax
   41526:	48 c1 e0 05          	shl    $0x5,%rax
   4152a:	48 89 c2             	mov    %rax,%rdx
   4152d:	48 8d 05 b4 fb 00 00 	lea    0xfbb4(%rip),%rax        # 510e8 <processes+0xc8>
   41534:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41537:	85 c0                	test   %eax,%eax
   41539:	74 b3                	je     414ee <memshow_virtual_animate+0x46>
   4153b:	8b 05 c3 3a 00 00    	mov    0x3ac3(%rip),%eax        # 45004 <showing.0>
   41541:	99                   	cltd   
   41542:	c1 ea 1c             	shr    $0x1c,%edx
   41545:	01 d0                	add    %edx,%eax
   41547:	83 e0 0f             	and    $0xf,%eax
   4154a:	29 d0                	sub    %edx,%eax
   4154c:	48 63 d0             	movslq %eax,%rdx
   4154f:	48 89 d0             	mov    %rdx,%rax
   41552:	48 c1 e0 03          	shl    $0x3,%rax
   41556:	48 29 d0             	sub    %rdx,%rax
   41559:	48 c1 e0 05          	shl    $0x5,%rax
   4155d:	48 89 c2             	mov    %rax,%rdx
   41560:	48 8d 05 91 fb 00 00 	lea    0xfb91(%rip),%rax        # 510f8 <processes+0xd8>
   41567:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4156b:	84 c0                	test   %al,%al
   4156d:	0f 84 7b ff ff ff    	je     414ee <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   41573:	8b 05 8b 3a 00 00    	mov    0x3a8b(%rip),%eax        # 45004 <showing.0>
   41579:	99                   	cltd   
   4157a:	c1 ea 1c             	shr    $0x1c,%edx
   4157d:	01 d0                	add    %edx,%eax
   4157f:	83 e0 0f             	and    $0xf,%eax
   41582:	29 d0                	sub    %edx,%eax
   41584:	89 05 7a 3a 00 00    	mov    %eax,0x3a7a(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   4158a:	8b 05 74 3a 00 00    	mov    0x3a74(%rip),%eax        # 45004 <showing.0>
   41590:	48 63 d0             	movslq %eax,%rdx
   41593:	48 89 d0             	mov    %rdx,%rax
   41596:	48 c1 e0 03          	shl    $0x3,%rax
   4159a:	48 29 d0             	sub    %rdx,%rax
   4159d:	48 c1 e0 05          	shl    $0x5,%rax
   415a1:	48 89 c2             	mov    %rax,%rdx
   415a4:	48 8d 05 3d fb 00 00 	lea    0xfb3d(%rip),%rax        # 510e8 <processes+0xc8>
   415ab:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   415ae:	85 c0                	test   %eax,%eax
   415b0:	74 59                	je     4160b <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   415b2:	8b 15 4c 3a 00 00    	mov    0x3a4c(%rip),%edx        # 45004 <showing.0>
   415b8:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   415bc:	89 d1                	mov    %edx,%ecx
   415be:	48 8d 15 7f 30 00 00 	lea    0x307f(%rip),%rdx        # 44644 <memstate_colors+0xa4>
   415c5:	be 04 00 00 00       	mov    $0x4,%esi
   415ca:	48 89 c7             	mov    %rax,%rdi
   415cd:	b8 00 00 00 00       	mov    $0x0,%eax
   415d2:	e8 77 2c 00 00       	call   4424e <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   415d7:	8b 05 27 3a 00 00    	mov    0x3a27(%rip),%eax        # 45004 <showing.0>
   415dd:	48 63 d0             	movslq %eax,%rdx
   415e0:	48 89 d0             	mov    %rdx,%rax
   415e3:	48 c1 e0 03          	shl    $0x3,%rax
   415e7:	48 29 d0             	sub    %rdx,%rax
   415ea:	48 c1 e0 05          	shl    $0x5,%rax
   415ee:	48 89 c2             	mov    %rax,%rdx
   415f1:	48 8d 05 f8 fa 00 00 	lea    0xfaf8(%rip),%rax        # 510f0 <processes+0xd0>
   415f8:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   415fc:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41600:	48 89 d6             	mov    %rdx,%rsi
   41603:	48 89 c7             	mov    %rax,%rdi
   41606:	e8 5d fc ff ff       	call   41268 <memshow_virtual>
    }
}
   4160b:	90                   	nop
   4160c:	c9                   	leave  
   4160d:	c3                   	ret    

000000000004160e <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   4160e:	f3 0f 1e fa          	endbr64 
   41612:	55                   	push   %rbp
   41613:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41616:	e8 5f 01 00 00       	call   4177a <segments_init>
    interrupt_init();
   4161b:	e8 44 04 00 00       	call   41a64 <interrupt_init>
    virtual_memory_init();
   41620:	e8 11 11 00 00       	call   42736 <virtual_memory_init>
}
   41625:	90                   	nop
   41626:	5d                   	pop    %rbp
   41627:	c3                   	ret    

0000000000041628 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41628:	f3 0f 1e fa          	endbr64 
   4162c:	55                   	push   %rbp
   4162d:	48 89 e5             	mov    %rsp,%rbp
   41630:	48 83 ec 18          	sub    $0x18,%rsp
   41634:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41638:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4163c:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   4163f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41642:	48 98                	cltq   
   41644:	48 c1 e0 2d          	shl    $0x2d,%rax
   41648:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   4164c:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41653:	90 00 00 
   41656:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41659:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4165d:	48 89 10             	mov    %rdx,(%rax)
}
   41660:	90                   	nop
   41661:	c9                   	leave  
   41662:	c3                   	ret    

0000000000041663 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41663:	f3 0f 1e fa          	endbr64 
   41667:	55                   	push   %rbp
   41668:	48 89 e5             	mov    %rsp,%rbp
   4166b:	48 83 ec 28          	sub    $0x28,%rsp
   4166f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41673:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41677:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4167a:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   4167e:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41682:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41686:	48 c1 e0 10          	shl    $0x10,%rax
   4168a:	48 89 c2             	mov    %rax,%rdx
   4168d:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41694:	00 00 00 
   41697:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   4169a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4169e:	48 c1 e0 20          	shl    $0x20,%rax
   416a2:	48 89 c1             	mov    %rax,%rcx
   416a5:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   416ac:	00 00 ff 
   416af:	48 21 c8             	and    %rcx,%rax
   416b2:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   416b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   416b9:	48 83 e8 01          	sub    $0x1,%rax
   416bd:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   416c0:	48 09 d0             	or     %rdx,%rax
        | type
   416c3:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   416c7:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   416ca:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416cd:	48 98                	cltq   
   416cf:	48 c1 e0 2d          	shl    $0x2d,%rax
   416d3:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   416d6:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   416dd:	80 00 00 
   416e0:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   416e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416e7:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   416ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416ee:	48 83 c0 08          	add    $0x8,%rax
   416f2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   416f6:	48 c1 ea 20          	shr    $0x20,%rdx
   416fa:	48 89 10             	mov    %rdx,(%rax)
}
   416fd:	90                   	nop
   416fe:	c9                   	leave  
   416ff:	c3                   	ret    

0000000000041700 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41700:	f3 0f 1e fa          	endbr64 
   41704:	55                   	push   %rbp
   41705:	48 89 e5             	mov    %rsp,%rbp
   41708:	48 83 ec 20          	sub    $0x20,%rsp
   4170c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41710:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41714:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41717:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   4171b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4171f:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41722:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41726:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41729:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4172c:	48 98                	cltq   
   4172e:	48 c1 e0 2d          	shl    $0x2d,%rax
   41732:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41735:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41739:	48 c1 e0 20          	shl    $0x20,%rax
   4173d:	48 89 c1             	mov    %rax,%rcx
   41740:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41747:	00 ff ff 
   4174a:	48 21 c8             	and    %rcx,%rax
   4174d:	48 09 c2             	or     %rax,%rdx
   41750:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41757:	80 00 00 
   4175a:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   4175d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41761:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41764:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41768:	48 c1 e8 20          	shr    $0x20,%rax
   4176c:	48 89 c2             	mov    %rax,%rdx
   4176f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41773:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41777:	90                   	nop
   41778:	c9                   	leave  
   41779:	c3                   	ret    

000000000004177a <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   4177a:	f3 0f 1e fa          	endbr64 
   4177e:	55                   	push   %rbp
   4177f:	48 89 e5             	mov    %rsp,%rbp
   41782:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41786:	48 c7 05 cf 0a 01 00 	movq   $0x0,0x10acf(%rip)        # 52260 <segments>
   4178d:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41791:	ba 00 00 00 00       	mov    $0x0,%edx
   41796:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4179d:	08 20 00 
   417a0:	48 89 c6             	mov    %rax,%rsi
   417a3:	48 8d 05 be 0a 01 00 	lea    0x10abe(%rip),%rax        # 52268 <segments+0x8>
   417aa:	48 89 c7             	mov    %rax,%rdi
   417ad:	e8 76 fe ff ff       	call   41628 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   417b2:	ba 03 00 00 00       	mov    $0x3,%edx
   417b7:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417be:	08 20 00 
   417c1:	48 89 c6             	mov    %rax,%rsi
   417c4:	48 8d 05 a5 0a 01 00 	lea    0x10aa5(%rip),%rax        # 52270 <segments+0x10>
   417cb:	48 89 c7             	mov    %rax,%rdi
   417ce:	e8 55 fe ff ff       	call   41628 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   417d3:	ba 00 00 00 00       	mov    $0x0,%edx
   417d8:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417df:	02 00 00 
   417e2:	48 89 c6             	mov    %rax,%rsi
   417e5:	48 8d 05 8c 0a 01 00 	lea    0x10a8c(%rip),%rax        # 52278 <segments+0x18>
   417ec:	48 89 c7             	mov    %rax,%rdi
   417ef:	e8 34 fe ff ff       	call   41628 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   417f4:	ba 03 00 00 00       	mov    $0x3,%edx
   417f9:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41800:	02 00 00 
   41803:	48 89 c6             	mov    %rax,%rsi
   41806:	48 8d 05 73 0a 01 00 	lea    0x10a73(%rip),%rax        # 52280 <segments+0x20>
   4180d:	48 89 c7             	mov    %rax,%rdi
   41810:	e8 13 fe ff ff       	call   41628 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41815:	48 8d 05 84 1a 01 00 	lea    0x11a84(%rip),%rax        # 532a0 <kernel_task_descriptor>
   4181c:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41822:	48 89 c1             	mov    %rax,%rcx
   41825:	ba 00 00 00 00       	mov    $0x0,%edx
   4182a:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41831:	09 00 00 
   41834:	48 89 c6             	mov    %rax,%rsi
   41837:	48 8d 05 4a 0a 01 00 	lea    0x10a4a(%rip),%rax        # 52288 <segments+0x28>
   4183e:	48 89 c7             	mov    %rax,%rdi
   41841:	e8 1d fe ff ff       	call   41663 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41846:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   4184c:	48 8d 05 0d 0a 01 00 	lea    0x10a0d(%rip),%rax        # 52260 <segments>
   41853:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41857:	ba 60 00 00 00       	mov    $0x60,%edx
   4185c:	be 00 00 00 00       	mov    $0x0,%esi
   41861:	48 8d 05 38 1a 01 00 	lea    0x11a38(%rip),%rax        # 532a0 <kernel_task_descriptor>
   41868:	48 89 c7             	mov    %rax,%rdi
   4186b:	e8 84 1a 00 00       	call   432f4 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41870:	48 c7 05 29 1a 01 00 	movq   $0x80000,0x11a29(%rip)        # 532a4 <kernel_task_descriptor+0x4>
   41877:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   4187b:	ba 00 10 00 00       	mov    $0x1000,%edx
   41880:	be 00 00 00 00       	mov    $0x0,%esi
   41885:	48 8d 05 14 0a 01 00 	lea    0x10a14(%rip),%rax        # 522a0 <interrupt_descriptors>
   4188c:	48 89 c7             	mov    %rax,%rdi
   4188f:	e8 60 1a 00 00       	call   432f4 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41894:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   4189b:	eb 3c                	jmp    418d9 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   4189d:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   418a4:	48 89 c2             	mov    %rax,%rdx
   418a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418aa:	48 c1 e0 04          	shl    $0x4,%rax
   418ae:	48 89 c1             	mov    %rax,%rcx
   418b1:	48 8d 05 e8 09 01 00 	lea    0x109e8(%rip),%rax        # 522a0 <interrupt_descriptors>
   418b8:	48 01 c8             	add    %rcx,%rax
   418bb:	48 89 d1             	mov    %rdx,%rcx
   418be:	ba 00 00 00 00       	mov    $0x0,%edx
   418c3:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   418ca:	0e 00 00 
   418cd:	48 89 c7             	mov    %rax,%rdi
   418d0:	e8 2b fe ff ff       	call   41700 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   418d5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   418d9:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   418e0:	76 bb                	jbe    4189d <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   418e2:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   418e9:	48 89 c1             	mov    %rax,%rcx
   418ec:	ba 00 00 00 00       	mov    $0x0,%edx
   418f1:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418f8:	0e 00 00 
   418fb:	48 89 c6             	mov    %rax,%rsi
   418fe:	48 8d 05 9b 0b 01 00 	lea    0x10b9b(%rip),%rax        # 524a0 <interrupt_descriptors+0x200>
   41905:	48 89 c7             	mov    %rax,%rdi
   41908:	e8 f3 fd ff ff       	call   41700 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   4190d:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   41914:	48 89 c1             	mov    %rax,%rcx
   41917:	ba 00 00 00 00       	mov    $0x0,%edx
   4191c:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41923:	0e 00 00 
   41926:	48 89 c6             	mov    %rax,%rsi
   41929:	48 8d 05 40 0a 01 00 	lea    0x10a40(%rip),%rax        # 52370 <interrupt_descriptors+0xd0>
   41930:	48 89 c7             	mov    %rax,%rdi
   41933:	e8 c8 fd ff ff       	call   41700 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41938:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   4193f:	48 89 c1             	mov    %rax,%rcx
   41942:	ba 00 00 00 00       	mov    $0x0,%edx
   41947:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4194e:	0e 00 00 
   41951:	48 89 c6             	mov    %rax,%rsi
   41954:	48 8d 05 25 0a 01 00 	lea    0x10a25(%rip),%rax        # 52380 <interrupt_descriptors+0xe0>
   4195b:	48 89 c7             	mov    %rax,%rdi
   4195e:	e8 9d fd ff ff       	call   41700 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41963:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   4196a:	eb 50                	jmp    419bc <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   4196c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4196f:	83 e8 30             	sub    $0x30,%eax
   41972:	89 c0                	mov    %eax,%eax
   41974:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   4197b:	00 
   4197c:	48 8d 05 64 e7 ff ff 	lea    -0x189c(%rip),%rax        # 400e7 <sys_int_handlers>
   41983:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41987:	48 89 c2             	mov    %rax,%rdx
   4198a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4198d:	48 c1 e0 04          	shl    $0x4,%rax
   41991:	48 89 c1             	mov    %rax,%rcx
   41994:	48 8d 05 05 09 01 00 	lea    0x10905(%rip),%rax        # 522a0 <interrupt_descriptors>
   4199b:	48 01 c8             	add    %rcx,%rax
   4199e:	48 89 d1             	mov    %rdx,%rcx
   419a1:	ba 03 00 00 00       	mov    $0x3,%edx
   419a6:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   419ad:	0e 00 00 
   419b0:	48 89 c7             	mov    %rax,%rdi
   419b3:	e8 48 fd ff ff       	call   41700 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   419b8:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   419bc:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   419c0:	76 aa                	jbe    4196c <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   419c2:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   419c8:	48 8d 05 d1 08 01 00 	lea    0x108d1(%rip),%rax        # 522a0 <interrupt_descriptors>
   419cf:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   419d3:	b8 28 00 00 00       	mov    $0x28,%eax
   419d8:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   419dc:	0f 00 d8             	ltr    %ax
   419df:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   419e3:	0f 20 c0             	mov    %cr0,%rax
   419e6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   419ea:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   419ee:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   419f1:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   419f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   419fb:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   419fe:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a01:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41a05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41a09:	0f 22 c0             	mov    %rax,%cr0
}
   41a0c:	90                   	nop
    lcr0(cr0);
}
   41a0d:	90                   	nop
   41a0e:	c9                   	leave  
   41a0f:	c3                   	ret    

0000000000041a10 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41a10:	f3 0f 1e fa          	endbr64 
   41a14:	55                   	push   %rbp
   41a15:	48 89 e5             	mov    %rsp,%rbp
   41a18:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41a1c:	0f b7 05 dd 18 01 00 	movzwl 0x118dd(%rip),%eax        # 53300 <interrupts_enabled>
   41a23:	f7 d0                	not    %eax
   41a25:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41a29:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a2d:	0f b6 c0             	movzbl %al,%eax
   41a30:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41a37:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a3a:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41a3e:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41a41:	ee                   	out    %al,(%dx)
}
   41a42:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41a43:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a47:	66 c1 e8 08          	shr    $0x8,%ax
   41a4b:	0f b6 c0             	movzbl %al,%eax
   41a4e:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41a55:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a58:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41a5c:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41a5f:	ee                   	out    %al,(%dx)
}
   41a60:	90                   	nop
}
   41a61:	90                   	nop
   41a62:	c9                   	leave  
   41a63:	c3                   	ret    

0000000000041a64 <interrupt_init>:

void interrupt_init(void) {
   41a64:	f3 0f 1e fa          	endbr64 
   41a68:	55                   	push   %rbp
   41a69:	48 89 e5             	mov    %rsp,%rbp
   41a6c:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41a70:	66 c7 05 87 18 01 00 	movw   $0x0,0x11887(%rip)        # 53300 <interrupts_enabled>
   41a77:	00 00 
    interrupt_mask();
   41a79:	e8 92 ff ff ff       	call   41a10 <interrupt_mask>
   41a7e:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41a85:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a89:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41a8d:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41a90:	ee                   	out    %al,(%dx)
}
   41a91:	90                   	nop
   41a92:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41a99:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a9d:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41aa1:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41aa4:	ee                   	out    %al,(%dx)
}
   41aa5:	90                   	nop
   41aa6:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41aad:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ab1:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41ab5:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41ab8:	ee                   	out    %al,(%dx)
}
   41ab9:	90                   	nop
   41aba:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41ac1:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ac5:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41ac9:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41acc:	ee                   	out    %al,(%dx)
}
   41acd:	90                   	nop
   41ace:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41ad5:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ad9:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41add:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41ae0:	ee                   	out    %al,(%dx)
}
   41ae1:	90                   	nop
   41ae2:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41ae9:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aed:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41af1:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41af4:	ee                   	out    %al,(%dx)
}
   41af5:	90                   	nop
   41af6:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41afd:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b01:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41b05:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41b08:	ee                   	out    %al,(%dx)
}
   41b09:	90                   	nop
   41b0a:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41b11:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b15:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41b19:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41b1c:	ee                   	out    %al,(%dx)
}
   41b1d:	90                   	nop
   41b1e:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41b25:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b29:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41b2d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41b30:	ee                   	out    %al,(%dx)
}
   41b31:	90                   	nop
   41b32:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41b39:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b3d:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b41:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b44:	ee                   	out    %al,(%dx)
}
   41b45:	90                   	nop
   41b46:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41b4d:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b51:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b55:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b58:	ee                   	out    %al,(%dx)
}
   41b59:	90                   	nop
   41b5a:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41b61:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b65:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b69:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b6c:	ee                   	out    %al,(%dx)
}
   41b6d:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41b6e:	e8 9d fe ff ff       	call   41a10 <interrupt_mask>
}
   41b73:	90                   	nop
   41b74:	c9                   	leave  
   41b75:	c3                   	ret    

0000000000041b76 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41b76:	f3 0f 1e fa          	endbr64 
   41b7a:	55                   	push   %rbp
   41b7b:	48 89 e5             	mov    %rsp,%rbp
   41b7e:	48 83 ec 28          	sub    $0x28,%rsp
   41b82:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41b85:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41b89:	0f 8e 9f 00 00 00    	jle    41c2e <timer_init+0xb8>
   41b8f:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41b96:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b9a:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b9e:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ba1:	ee                   	out    %al,(%dx)
}
   41ba2:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41ba3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41ba6:	89 c2                	mov    %eax,%edx
   41ba8:	c1 ea 1f             	shr    $0x1f,%edx
   41bab:	01 d0                	add    %edx,%eax
   41bad:	d1 f8                	sar    %eax
   41baf:	05 de 34 12 00       	add    $0x1234de,%eax
   41bb4:	99                   	cltd   
   41bb5:	f7 7d dc             	idivl  -0x24(%rbp)
   41bb8:	89 c2                	mov    %eax,%edx
   41bba:	89 d0                	mov    %edx,%eax
   41bbc:	c1 f8 1f             	sar    $0x1f,%eax
   41bbf:	c1 e8 18             	shr    $0x18,%eax
   41bc2:	89 c1                	mov    %eax,%ecx
   41bc4:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41bc7:	0f b6 c0             	movzbl %al,%eax
   41bca:	29 c8                	sub    %ecx,%eax
   41bcc:	0f b6 c0             	movzbl %al,%eax
   41bcf:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41bd6:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bd9:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41bdd:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41be0:	ee                   	out    %al,(%dx)
}
   41be1:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41be2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41be5:	89 c2                	mov    %eax,%edx
   41be7:	c1 ea 1f             	shr    $0x1f,%edx
   41bea:	01 d0                	add    %edx,%eax
   41bec:	d1 f8                	sar    %eax
   41bee:	05 de 34 12 00       	add    $0x1234de,%eax
   41bf3:	99                   	cltd   
   41bf4:	f7 7d dc             	idivl  -0x24(%rbp)
   41bf7:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41bfd:	85 c0                	test   %eax,%eax
   41bff:	0f 48 c2             	cmovs  %edx,%eax
   41c02:	c1 f8 08             	sar    $0x8,%eax
   41c05:	0f b6 c0             	movzbl %al,%eax
   41c08:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41c0f:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c12:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41c16:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41c19:	ee                   	out    %al,(%dx)
}
   41c1a:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41c1b:	0f b7 05 de 16 01 00 	movzwl 0x116de(%rip),%eax        # 53300 <interrupts_enabled>
   41c22:	83 c8 01             	or     $0x1,%eax
   41c25:	66 89 05 d4 16 01 00 	mov    %ax,0x116d4(%rip)        # 53300 <interrupts_enabled>
   41c2c:	eb 11                	jmp    41c3f <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41c2e:	0f b7 05 cb 16 01 00 	movzwl 0x116cb(%rip),%eax        # 53300 <interrupts_enabled>
   41c35:	83 e0 fe             	and    $0xfffffffe,%eax
   41c38:	66 89 05 c1 16 01 00 	mov    %ax,0x116c1(%rip)        # 53300 <interrupts_enabled>
    }
    interrupt_mask();
   41c3f:	e8 cc fd ff ff       	call   41a10 <interrupt_mask>
}
   41c44:	90                   	nop
   41c45:	c9                   	leave  
   41c46:	c3                   	ret    

0000000000041c47 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41c47:	f3 0f 1e fa          	endbr64 
   41c4b:	55                   	push   %rbp
   41c4c:	48 89 e5             	mov    %rsp,%rbp
   41c4f:	48 83 ec 08          	sub    $0x8,%rsp
   41c53:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41c57:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41c5c:	74 14                	je     41c72 <physical_memory_isreserved+0x2b>
   41c5e:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41c65:	00 
   41c66:	76 11                	jbe    41c79 <physical_memory_isreserved+0x32>
   41c68:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41c6f:	00 
   41c70:	77 07                	ja     41c79 <physical_memory_isreserved+0x32>
   41c72:	b8 01 00 00 00       	mov    $0x1,%eax
   41c77:	eb 05                	jmp    41c7e <physical_memory_isreserved+0x37>
   41c79:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41c7e:	c9                   	leave  
   41c7f:	c3                   	ret    

0000000000041c80 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41c80:	f3 0f 1e fa          	endbr64 
   41c84:	55                   	push   %rbp
   41c85:	48 89 e5             	mov    %rsp,%rbp
   41c88:	48 83 ec 10          	sub    $0x10,%rsp
   41c8c:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41c8f:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41c92:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41c95:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c98:	c1 e0 10             	shl    $0x10,%eax
   41c9b:	89 c2                	mov    %eax,%edx
   41c9d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ca0:	c1 e0 0b             	shl    $0xb,%eax
   41ca3:	09 c2                	or     %eax,%edx
   41ca5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41ca8:	c1 e0 08             	shl    $0x8,%eax
   41cab:	09 d0                	or     %edx,%eax
}
   41cad:	c9                   	leave  
   41cae:	c3                   	ret    

0000000000041caf <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41caf:	f3 0f 1e fa          	endbr64 
   41cb3:	55                   	push   %rbp
   41cb4:	48 89 e5             	mov    %rsp,%rbp
   41cb7:	48 83 ec 18          	sub    $0x18,%rsp
   41cbb:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41cbe:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41cc1:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41cc4:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41cc7:	09 d0                	or     %edx,%eax
   41cc9:	0d 00 00 00 80       	or     $0x80000000,%eax
   41cce:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41cd5:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41cd8:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cdb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cde:	ef                   	out    %eax,(%dx)
}
   41cdf:	90                   	nop
   41ce0:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41ce7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41cea:	89 c2                	mov    %eax,%edx
   41cec:	ed                   	in     (%dx),%eax
   41ced:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41cf0:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41cf3:	c9                   	leave  
   41cf4:	c3                   	ret    

0000000000041cf5 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41cf5:	f3 0f 1e fa          	endbr64 
   41cf9:	55                   	push   %rbp
   41cfa:	48 89 e5             	mov    %rsp,%rbp
   41cfd:	48 83 ec 28          	sub    $0x28,%rsp
   41d01:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41d04:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41d07:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41d0e:	eb 73                	jmp    41d83 <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   41d10:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41d17:	eb 60                	jmp    41d79 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   41d19:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41d20:	eb 4a                	jmp    41d6c <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41d22:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d25:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41d28:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d2b:	89 ce                	mov    %ecx,%esi
   41d2d:	89 c7                	mov    %eax,%edi
   41d2f:	e8 4c ff ff ff       	call   41c80 <pci_make_configaddr>
   41d34:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41d37:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d3a:	be 00 00 00 00       	mov    $0x0,%esi
   41d3f:	89 c7                	mov    %eax,%edi
   41d41:	e8 69 ff ff ff       	call   41caf <pci_config_readl>
   41d46:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41d49:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41d4c:	c1 e0 10             	shl    $0x10,%eax
   41d4f:	0b 45 dc             	or     -0x24(%rbp),%eax
   41d52:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41d55:	75 05                	jne    41d5c <pci_find_device+0x67>
                    return configaddr;
   41d57:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d5a:	eb 35                	jmp    41d91 <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41d5c:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41d60:	75 06                	jne    41d68 <pci_find_device+0x73>
   41d62:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41d66:	74 0c                	je     41d74 <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   41d68:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41d6c:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41d70:	75 b0                	jne    41d22 <pci_find_device+0x2d>
   41d72:	eb 01                	jmp    41d75 <pci_find_device+0x80>
                    break;
   41d74:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41d75:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41d79:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41d7d:	75 9a                	jne    41d19 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   41d7f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41d83:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41d8a:	75 84                	jne    41d10 <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   41d8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41d91:	c9                   	leave  
   41d92:	c3                   	ret    

0000000000041d93 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41d93:	f3 0f 1e fa          	endbr64 
   41d97:	55                   	push   %rbp
   41d98:	48 89 e5             	mov    %rsp,%rbp
   41d9b:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41d9f:	be 13 71 00 00       	mov    $0x7113,%esi
   41da4:	bf 86 80 00 00       	mov    $0x8086,%edi
   41da9:	e8 47 ff ff ff       	call   41cf5 <pci_find_device>
   41dae:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41db1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41db5:	78 30                	js     41de7 <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41db7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41dba:	be 40 00 00 00       	mov    $0x40,%esi
   41dbf:	89 c7                	mov    %eax,%edi
   41dc1:	e8 e9 fe ff ff       	call   41caf <pci_config_readl>
   41dc6:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41dcb:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41dce:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41dd1:	83 c0 04             	add    $0x4,%eax
   41dd4:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41dd7:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41ddd:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41de1:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41de4:	66 ef                	out    %ax,(%dx)
}
   41de6:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41de7:	48 8d 05 72 28 00 00 	lea    0x2872(%rip),%rax        # 44660 <memstate_colors+0xc0>
   41dee:	48 89 c2             	mov    %rax,%rdx
   41df1:	be 00 c0 00 00       	mov    $0xc000,%esi
   41df6:	bf 80 07 00 00       	mov    $0x780,%edi
   41dfb:	b8 00 00 00 00       	mov    $0x0,%eax
   41e00:	e8 2e 23 00 00       	call   44133 <console_printf>
 spinloop: goto spinloop;
   41e05:	eb fe                	jmp    41e05 <poweroff+0x72>

0000000000041e07 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41e07:	f3 0f 1e fa          	endbr64 
   41e0b:	55                   	push   %rbp
   41e0c:	48 89 e5             	mov    %rsp,%rbp
   41e0f:	48 83 ec 10          	sub    $0x10,%rsp
   41e13:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41e1a:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e1e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e22:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e25:	ee                   	out    %al,(%dx)
}
   41e26:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41e27:	eb fe                	jmp    41e27 <reboot+0x20>

0000000000041e29 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41e29:	f3 0f 1e fa          	endbr64 
   41e2d:	55                   	push   %rbp
   41e2e:	48 89 e5             	mov    %rsp,%rbp
   41e31:	48 83 ec 10          	sub    $0x10,%rsp
   41e35:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e39:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41e3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e40:	48 83 c0 08          	add    $0x8,%rax
   41e44:	ba c0 00 00 00       	mov    $0xc0,%edx
   41e49:	be 00 00 00 00       	mov    $0x0,%esi
   41e4e:	48 89 c7             	mov    %rax,%rdi
   41e51:	e8 9e 14 00 00       	call   432f4 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41e56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e5a:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41e61:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41e63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e67:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41e6e:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41e72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e76:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   41e7d:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41e81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e85:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   41e8c:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41e8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e92:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   41e99:	00 02 00 00 
    p->display_status = 1;
   41e9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ea1:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41ea8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41eab:	83 e0 01             	and    $0x1,%eax
   41eae:	85 c0                	test   %eax,%eax
   41eb0:	74 1c                	je     41ece <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41eb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41eb6:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41ebd:	80 cc 30             	or     $0x30,%ah
   41ec0:	48 89 c2             	mov    %rax,%rdx
   41ec3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ec7:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41ece:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41ed1:	83 e0 02             	and    $0x2,%eax
   41ed4:	85 c0                	test   %eax,%eax
   41ed6:	74 1c                	je     41ef4 <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41ed8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41edc:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41ee3:	80 e4 fd             	and    $0xfd,%ah
   41ee6:	48 89 c2             	mov    %rax,%rdx
   41ee9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41eed:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   41ef4:	90                   	nop
   41ef5:	c9                   	leave  
   41ef6:	c3                   	ret    

0000000000041ef7 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41ef7:	f3 0f 1e fa          	endbr64 
   41efb:	55                   	push   %rbp
   41efc:	48 89 e5             	mov    %rsp,%rbp
   41eff:	48 83 ec 28          	sub    $0x28,%rsp
   41f03:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41f06:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41f0a:	78 09                	js     41f15 <console_show_cursor+0x1e>
   41f0c:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41f13:	7e 07                	jle    41f1c <console_show_cursor+0x25>
        cpos = 0;
   41f15:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41f1c:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41f23:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f27:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41f2b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41f2e:	ee                   	out    %al,(%dx)
}
   41f2f:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41f30:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f33:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41f39:	85 c0                	test   %eax,%eax
   41f3b:	0f 48 c2             	cmovs  %edx,%eax
   41f3e:	c1 f8 08             	sar    $0x8,%eax
   41f41:	0f b6 c0             	movzbl %al,%eax
   41f44:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41f4b:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f4e:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41f52:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f55:	ee                   	out    %al,(%dx)
}
   41f56:	90                   	nop
   41f57:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41f5e:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f62:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41f66:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f69:	ee                   	out    %al,(%dx)
}
   41f6a:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41f6b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41f6e:	99                   	cltd   
   41f6f:	c1 ea 18             	shr    $0x18,%edx
   41f72:	01 d0                	add    %edx,%eax
   41f74:	0f b6 c0             	movzbl %al,%eax
   41f77:	29 d0                	sub    %edx,%eax
   41f79:	0f b6 c0             	movzbl %al,%eax
   41f7c:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41f83:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f86:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f8a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f8d:	ee                   	out    %al,(%dx)
}
   41f8e:	90                   	nop
}
   41f8f:	90                   	nop
   41f90:	c9                   	leave  
   41f91:	c3                   	ret    

0000000000041f92 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41f92:	f3 0f 1e fa          	endbr64 
   41f96:	55                   	push   %rbp
   41f97:	48 89 e5             	mov    %rsp,%rbp
   41f9a:	48 83 ec 20          	sub    $0x20,%rsp
   41f9e:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41fa5:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fa8:	89 c2                	mov    %eax,%edx
   41faa:	ec                   	in     (%dx),%al
   41fab:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41fae:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41fb2:	0f b6 c0             	movzbl %al,%eax
   41fb5:	83 e0 01             	and    $0x1,%eax
   41fb8:	85 c0                	test   %eax,%eax
   41fba:	75 0a                	jne    41fc6 <keyboard_readc+0x34>
        return -1;
   41fbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41fc1:	e9 fd 01 00 00       	jmp    421c3 <keyboard_readc+0x231>
   41fc6:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41fcd:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41fd0:	89 c2                	mov    %eax,%edx
   41fd2:	ec                   	in     (%dx),%al
   41fd3:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41fd6:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41fda:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41fdd:	0f b6 05 1e 13 01 00 	movzbl 0x1131e(%rip),%eax        # 53302 <last_escape.2>
   41fe4:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41fe7:	c6 05 14 13 01 00 00 	movb   $0x0,0x11314(%rip)        # 53302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41fee:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41ff2:	75 11                	jne    42005 <keyboard_readc+0x73>
        last_escape = 0x80;
   41ff4:	c6 05 07 13 01 00 80 	movb   $0x80,0x11307(%rip)        # 53302 <last_escape.2>
        return 0;
   41ffb:	b8 00 00 00 00       	mov    $0x0,%eax
   42000:	e9 be 01 00 00       	jmp    421c3 <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42005:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42009:	84 c0                	test   %al,%al
   4200b:	79 64                	jns    42071 <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   4200d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42011:	83 e0 7f             	and    $0x7f,%eax
   42014:	89 c2                	mov    %eax,%edx
   42016:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   4201a:	09 d0                	or     %edx,%eax
   4201c:	48 98                	cltq   
   4201e:	48 8d 15 5b 26 00 00 	lea    0x265b(%rip),%rdx        # 44680 <keymap>
   42025:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42029:	0f b6 c0             	movzbl %al,%eax
   4202c:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   4202f:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42036:	7e 2f                	jle    42067 <keyboard_readc+0xd5>
   42038:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   4203f:	7f 26                	jg     42067 <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42041:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42044:	2d fa 00 00 00       	sub    $0xfa,%eax
   42049:	ba 01 00 00 00       	mov    $0x1,%edx
   4204e:	89 c1                	mov    %eax,%ecx
   42050:	d3 e2                	shl    %cl,%edx
   42052:	89 d0                	mov    %edx,%eax
   42054:	f7 d0                	not    %eax
   42056:	89 c2                	mov    %eax,%edx
   42058:	0f b6 05 a4 12 01 00 	movzbl 0x112a4(%rip),%eax        # 53303 <modifiers.1>
   4205f:	21 d0                	and    %edx,%eax
   42061:	88 05 9c 12 01 00    	mov    %al,0x1129c(%rip)        # 53303 <modifiers.1>
        }
        return 0;
   42067:	b8 00 00 00 00       	mov    $0x0,%eax
   4206c:	e9 52 01 00 00       	jmp    421c3 <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   42071:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42075:	0a 45 fa             	or     -0x6(%rbp),%al
   42078:	0f b6 c0             	movzbl %al,%eax
   4207b:	48 98                	cltq   
   4207d:	48 8d 15 fc 25 00 00 	lea    0x25fc(%rip),%rdx        # 44680 <keymap>
   42084:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42088:	0f b6 c0             	movzbl %al,%eax
   4208b:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   4208e:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42092:	7e 57                	jle    420eb <keyboard_readc+0x159>
   42094:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42098:	7f 51                	jg     420eb <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   4209a:	0f b6 05 62 12 01 00 	movzbl 0x11262(%rip),%eax        # 53303 <modifiers.1>
   420a1:	0f b6 c0             	movzbl %al,%eax
   420a4:	83 e0 02             	and    $0x2,%eax
   420a7:	85 c0                	test   %eax,%eax
   420a9:	74 09                	je     420b4 <keyboard_readc+0x122>
            ch -= 0x60;
   420ab:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   420af:	e9 0b 01 00 00       	jmp    421bf <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   420b4:	0f b6 05 48 12 01 00 	movzbl 0x11248(%rip),%eax        # 53303 <modifiers.1>
   420bb:	0f b6 c0             	movzbl %al,%eax
   420be:	83 e0 01             	and    $0x1,%eax
   420c1:	85 c0                	test   %eax,%eax
   420c3:	0f 94 c2             	sete   %dl
   420c6:	0f b6 05 36 12 01 00 	movzbl 0x11236(%rip),%eax        # 53303 <modifiers.1>
   420cd:	0f b6 c0             	movzbl %al,%eax
   420d0:	83 e0 08             	and    $0x8,%eax
   420d3:	85 c0                	test   %eax,%eax
   420d5:	0f 94 c0             	sete   %al
   420d8:	31 d0                	xor    %edx,%eax
   420da:	84 c0                	test   %al,%al
   420dc:	0f 84 dd 00 00 00    	je     421bf <keyboard_readc+0x22d>
            ch -= 0x20;
   420e2:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   420e6:	e9 d4 00 00 00       	jmp    421bf <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   420eb:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   420f2:	7e 30                	jle    42124 <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   420f4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420f7:	2d fa 00 00 00       	sub    $0xfa,%eax
   420fc:	ba 01 00 00 00       	mov    $0x1,%edx
   42101:	89 c1                	mov    %eax,%ecx
   42103:	d3 e2                	shl    %cl,%edx
   42105:	89 d0                	mov    %edx,%eax
   42107:	89 c2                	mov    %eax,%edx
   42109:	0f b6 05 f3 11 01 00 	movzbl 0x111f3(%rip),%eax        # 53303 <modifiers.1>
   42110:	31 d0                	xor    %edx,%eax
   42112:	88 05 eb 11 01 00    	mov    %al,0x111eb(%rip)        # 53303 <modifiers.1>
        ch = 0;
   42118:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4211f:	e9 9c 00 00 00       	jmp    421c0 <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   42124:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4212b:	7e 2d                	jle    4215a <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4212d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42130:	2d fa 00 00 00       	sub    $0xfa,%eax
   42135:	ba 01 00 00 00       	mov    $0x1,%edx
   4213a:	89 c1                	mov    %eax,%ecx
   4213c:	d3 e2                	shl    %cl,%edx
   4213e:	89 d0                	mov    %edx,%eax
   42140:	89 c2                	mov    %eax,%edx
   42142:	0f b6 05 ba 11 01 00 	movzbl 0x111ba(%rip),%eax        # 53303 <modifiers.1>
   42149:	09 d0                	or     %edx,%eax
   4214b:	88 05 b2 11 01 00    	mov    %al,0x111b2(%rip)        # 53303 <modifiers.1>
        ch = 0;
   42151:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42158:	eb 66                	jmp    421c0 <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   4215a:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4215e:	7e 3f                	jle    4219f <keyboard_readc+0x20d>
   42160:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42167:	7f 36                	jg     4219f <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42169:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4216c:	8d 50 80             	lea    -0x80(%rax),%edx
   4216f:	0f b6 05 8d 11 01 00 	movzbl 0x1118d(%rip),%eax        # 53303 <modifiers.1>
   42176:	0f b6 c0             	movzbl %al,%eax
   42179:	83 e0 03             	and    $0x3,%eax
   4217c:	48 63 c8             	movslq %eax,%rcx
   4217f:	48 63 c2             	movslq %edx,%rax
   42182:	48 c1 e0 02          	shl    $0x2,%rax
   42186:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   4218a:	48 8d 05 ef 25 00 00 	lea    0x25ef(%rip),%rax        # 44780 <complex_keymap>
   42191:	48 01 d0             	add    %rdx,%rax
   42194:	0f b6 00             	movzbl (%rax),%eax
   42197:	0f b6 c0             	movzbl %al,%eax
   4219a:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4219d:	eb 21                	jmp    421c0 <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   4219f:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   421a3:	7f 1b                	jg     421c0 <keyboard_readc+0x22e>
   421a5:	0f b6 05 57 11 01 00 	movzbl 0x11157(%rip),%eax        # 53303 <modifiers.1>
   421ac:	0f b6 c0             	movzbl %al,%eax
   421af:	83 e0 02             	and    $0x2,%eax
   421b2:	85 c0                	test   %eax,%eax
   421b4:	74 0a                	je     421c0 <keyboard_readc+0x22e>
        ch = 0;
   421b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421bd:	eb 01                	jmp    421c0 <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   421bf:	90                   	nop
    }

    return ch;
   421c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   421c3:	c9                   	leave  
   421c4:	c3                   	ret    

00000000000421c5 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   421c5:	f3 0f 1e fa          	endbr64 
   421c9:	55                   	push   %rbp
   421ca:	48 89 e5             	mov    %rsp,%rbp
   421cd:	48 83 ec 20          	sub    $0x20,%rsp
   421d1:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421d8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   421db:	89 c2                	mov    %eax,%edx
   421dd:	ec                   	in     (%dx),%al
   421de:	88 45 e3             	mov    %al,-0x1d(%rbp)
   421e1:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   421e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   421eb:	89 c2                	mov    %eax,%edx
   421ed:	ec                   	in     (%dx),%al
   421ee:	88 45 eb             	mov    %al,-0x15(%rbp)
   421f1:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   421f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   421fb:	89 c2                	mov    %eax,%edx
   421fd:	ec                   	in     (%dx),%al
   421fe:	88 45 f3             	mov    %al,-0xd(%rbp)
   42201:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42208:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4220b:	89 c2                	mov    %eax,%edx
   4220d:	ec                   	in     (%dx),%al
   4220e:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42211:	90                   	nop
   42212:	c9                   	leave  
   42213:	c3                   	ret    

0000000000042214 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42214:	f3 0f 1e fa          	endbr64 
   42218:	55                   	push   %rbp
   42219:	48 89 e5             	mov    %rsp,%rbp
   4221c:	48 83 ec 40          	sub    $0x40,%rsp
   42220:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42224:	89 f0                	mov    %esi,%eax
   42226:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42229:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   4222c:	8b 05 d2 10 01 00    	mov    0x110d2(%rip),%eax        # 53304 <initialized.0>
   42232:	85 c0                	test   %eax,%eax
   42234:	75 1e                	jne    42254 <parallel_port_putc+0x40>
   42236:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   4223d:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42241:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42245:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42248:	ee                   	out    %al,(%dx)
}
   42249:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   4224a:	c7 05 b0 10 01 00 01 	movl   $0x1,0x110b0(%rip)        # 53304 <initialized.0>
   42251:	00 00 00 
    }

    for (int i = 0;
   42254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4225b:	eb 09                	jmp    42266 <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   4225d:	e8 63 ff ff ff       	call   421c5 <delay>
         ++i) {
   42262:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42266:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   4226d:	7f 18                	jg     42287 <parallel_port_putc+0x73>
   4226f:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42276:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42279:	89 c2                	mov    %eax,%edx
   4227b:	ec                   	in     (%dx),%al
   4227c:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4227f:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42283:	84 c0                	test   %al,%al
   42285:	79 d6                	jns    4225d <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   42287:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   4228b:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42292:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42295:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42299:	8b 55 d8             	mov    -0x28(%rbp),%edx
   4229c:	ee                   	out    %al,(%dx)
}
   4229d:	90                   	nop
   4229e:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   422a5:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422a9:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   422ad:	8b 55 e0             	mov    -0x20(%rbp),%edx
   422b0:	ee                   	out    %al,(%dx)
}
   422b1:	90                   	nop
   422b2:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   422b9:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422bd:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   422c1:	8b 55 e8             	mov    -0x18(%rbp),%edx
   422c4:	ee                   	out    %al,(%dx)
}
   422c5:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   422c6:	90                   	nop
   422c7:	c9                   	leave  
   422c8:	c3                   	ret    

00000000000422c9 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   422c9:	f3 0f 1e fa          	endbr64 
   422cd:	55                   	push   %rbp
   422ce:	48 89 e5             	mov    %rsp,%rbp
   422d1:	48 83 ec 20          	sub    $0x20,%rsp
   422d5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   422d9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   422dd:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 42214 <parallel_port_putc>
   422e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   422e8:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   422ec:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   422f0:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   422f4:	be 00 00 00 00       	mov    $0x0,%esi
   422f9:	48 89 c7             	mov    %rax,%rdi
   422fc:	e8 b9 12 00 00       	call   435ba <printer_vprintf>
}
   42301:	90                   	nop
   42302:	c9                   	leave  
   42303:	c3                   	ret    

0000000000042304 <log_printf>:

void log_printf(const char* format, ...) {
   42304:	f3 0f 1e fa          	endbr64 
   42308:	55                   	push   %rbp
   42309:	48 89 e5             	mov    %rsp,%rbp
   4230c:	48 83 ec 60          	sub    $0x60,%rsp
   42310:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42314:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42318:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4231c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42320:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42324:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42328:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4232f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42333:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42337:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4233b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4233f:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42343:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42347:	48 89 d6             	mov    %rdx,%rsi
   4234a:	48 89 c7             	mov    %rax,%rdi
   4234d:	e8 77 ff ff ff       	call   422c9 <log_vprintf>
    va_end(val);
}
   42352:	90                   	nop
   42353:	c9                   	leave  
   42354:	c3                   	ret    

0000000000042355 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42355:	f3 0f 1e fa          	endbr64 
   42359:	55                   	push   %rbp
   4235a:	48 89 e5             	mov    %rsp,%rbp
   4235d:	48 83 ec 40          	sub    $0x40,%rsp
   42361:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42364:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42367:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   4236b:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4236f:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42373:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42377:	48 8b 0a             	mov    (%rdx),%rcx
   4237a:	48 89 08             	mov    %rcx,(%rax)
   4237d:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42381:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42385:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42389:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   4238d:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42391:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42395:	48 89 d6             	mov    %rdx,%rsi
   42398:	48 89 c7             	mov    %rax,%rdi
   4239b:	e8 29 ff ff ff       	call   422c9 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   423a0:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   423a4:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   423a8:	8b 75 d8             	mov    -0x28(%rbp),%esi
   423ab:	8b 45 dc             	mov    -0x24(%rbp),%eax
   423ae:	89 c7                	mov    %eax,%edi
   423b0:	e8 02 1d 00 00       	call   440b7 <console_vprintf>
}
   423b5:	c9                   	leave  
   423b6:	c3                   	ret    

00000000000423b7 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   423b7:	f3 0f 1e fa          	endbr64 
   423bb:	55                   	push   %rbp
   423bc:	48 89 e5             	mov    %rsp,%rbp
   423bf:	48 83 ec 60          	sub    $0x60,%rsp
   423c3:	89 7d ac             	mov    %edi,-0x54(%rbp)
   423c6:	89 75 a8             	mov    %esi,-0x58(%rbp)
   423c9:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   423cd:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   423d1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   423d5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   423d9:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   423e0:	48 8d 45 10          	lea    0x10(%rbp),%rax
   423e4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   423e8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   423ec:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   423f0:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   423f4:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   423f8:	8b 75 a8             	mov    -0x58(%rbp),%esi
   423fb:	8b 45 ac             	mov    -0x54(%rbp),%eax
   423fe:	89 c7                	mov    %eax,%edi
   42400:	e8 50 ff ff ff       	call   42355 <error_vprintf>
   42405:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42408:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4240b:	c9                   	leave  
   4240c:	c3                   	ret    

000000000004240d <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   4240d:	f3 0f 1e fa          	endbr64 
   42411:	55                   	push   %rbp
   42412:	48 89 e5             	mov    %rsp,%rbp
   42415:	53                   	push   %rbx
   42416:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   4241a:	e8 73 fb ff ff       	call   41f92 <keyboard_readc>
   4241f:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42422:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42426:	74 1c                	je     42444 <check_keyboard+0x37>
   42428:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   4242c:	74 16                	je     42444 <check_keyboard+0x37>
   4242e:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42432:	74 10                	je     42444 <check_keyboard+0x37>
   42434:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42438:	74 0a                	je     42444 <check_keyboard+0x37>
   4243a:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4243e:	0f 85 02 01 00 00    	jne    42546 <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42444:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4244b:	00 
        memset(pt, 0, PAGESIZE * 3);
   4244c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42450:	ba 00 30 00 00       	mov    $0x3000,%edx
   42455:	be 00 00 00 00       	mov    $0x0,%esi
   4245a:	48 89 c7             	mov    %rax,%rdi
   4245d:	e8 92 0e 00 00       	call   432f4 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42462:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42466:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   4246d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42471:	48 05 00 10 00 00    	add    $0x1000,%rax
   42477:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   4247e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42482:	48 05 00 20 00 00    	add    $0x2000,%rax
   42488:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   4248f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42493:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42497:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4249b:	0f 22 d8             	mov    %rax,%cr3
}
   4249e:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   4249f:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   424a6:	48 8d 05 2b 23 00 00 	lea    0x232b(%rip),%rax        # 447d8 <complex_keymap+0x58>
   424ad:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   424b1:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   424b5:	75 0d                	jne    424c4 <check_keyboard+0xb7>
            argument = "allocator";
   424b7:	48 8d 05 1f 23 00 00 	lea    0x231f(%rip),%rax        # 447dd <complex_keymap+0x5d>
   424be:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   424c2:	eb 37                	jmp    424fb <check_keyboard+0xee>
        } else if (c == 'e') {
   424c4:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   424c8:	75 0d                	jne    424d7 <check_keyboard+0xca>
            argument = "forkexit";
   424ca:	48 8d 05 16 23 00 00 	lea    0x2316(%rip),%rax        # 447e7 <complex_keymap+0x67>
   424d1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   424d5:	eb 24                	jmp    424fb <check_keyboard+0xee>
        }
        else if (c == 't'){
   424d7:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   424db:	75 0d                	jne    424ea <check_keyboard+0xdd>
            argument = "test";
   424dd:	48 8d 05 0c 23 00 00 	lea    0x230c(%rip),%rax        # 447f0 <complex_keymap+0x70>
   424e4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   424e8:	eb 11                	jmp    424fb <check_keyboard+0xee>
        }
        else if(c == '2'){
   424ea:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   424ee:	75 0b                	jne    424fb <check_keyboard+0xee>
            argument = "test2";
   424f0:	48 8d 05 fe 22 00 00 	lea    0x22fe(%rip),%rax        # 447f5 <complex_keymap+0x75>
   424f7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   424fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   424ff:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42503:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42508:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   4250c:	76 1e                	jbe    4252c <check_keyboard+0x11f>
   4250e:	48 8d 05 e6 22 00 00 	lea    0x22e6(%rip),%rax        # 447fb <complex_keymap+0x7b>
   42515:	48 89 c2             	mov    %rax,%rdx
   42518:	be 5d 02 00 00       	mov    $0x25d,%esi
   4251d:	48 8d 05 f3 22 00 00 	lea    0x22f3(%rip),%rax        # 44817 <complex_keymap+0x97>
   42524:	48 89 c7             	mov    %rax,%rdi
   42527:	e8 33 01 00 00       	call   4265f <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   4252c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42530:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42533:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42537:	48 89 c3             	mov    %rax,%rbx
   4253a:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   4253f:	e9 bc da ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42544:	eb 11                	jmp    42557 <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42546:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   4254a:	74 06                	je     42552 <check_keyboard+0x145>
   4254c:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42550:	75 05                	jne    42557 <check_keyboard+0x14a>
        poweroff();
   42552:	e8 3c f8 ff ff       	call   41d93 <poweroff>
    }
    return c;
   42557:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   4255a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4255e:	c9                   	leave  
   4255f:	c3                   	ret    

0000000000042560 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42560:	f3 0f 1e fa          	endbr64 
   42564:	55                   	push   %rbp
   42565:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42568:	e8 a0 fe ff ff       	call   4240d <check_keyboard>
   4256d:	eb f9                	jmp    42568 <fail+0x8>

000000000004256f <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   4256f:	f3 0f 1e fa          	endbr64 
   42573:	55                   	push   %rbp
   42574:	48 89 e5             	mov    %rsp,%rbp
   42577:	48 83 ec 60          	sub    $0x60,%rsp
   4257b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4257f:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42583:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42587:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4258b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4258f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42593:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4259a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4259e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   425a2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   425a6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   425aa:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   425af:	0f 84 87 00 00 00    	je     4263c <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   425b5:	48 8d 05 6f 22 00 00 	lea    0x226f(%rip),%rax        # 4482b <complex_keymap+0xab>
   425bc:	48 89 c2             	mov    %rax,%rdx
   425bf:	be 00 c0 00 00       	mov    $0xc000,%esi
   425c4:	bf 30 07 00 00       	mov    $0x730,%edi
   425c9:	b8 00 00 00 00       	mov    $0x0,%eax
   425ce:	e8 e4 fd ff ff       	call   423b7 <error_printf>
   425d3:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   425d6:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   425da:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   425de:	8b 45 cc             	mov    -0x34(%rbp),%eax
   425e1:	be 00 c0 00 00       	mov    $0xc000,%esi
   425e6:	89 c7                	mov    %eax,%edi
   425e8:	e8 68 fd ff ff       	call   42355 <error_vprintf>
   425ed:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   425f0:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   425f3:	48 63 c1             	movslq %ecx,%rax
   425f6:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   425fd:	48 c1 e8 20          	shr    $0x20,%rax
   42601:	c1 f8 05             	sar    $0x5,%eax
   42604:	89 ce                	mov    %ecx,%esi
   42606:	c1 fe 1f             	sar    $0x1f,%esi
   42609:	29 f0                	sub    %esi,%eax
   4260b:	89 c2                	mov    %eax,%edx
   4260d:	89 d0                	mov    %edx,%eax
   4260f:	c1 e0 02             	shl    $0x2,%eax
   42612:	01 d0                	add    %edx,%eax
   42614:	c1 e0 04             	shl    $0x4,%eax
   42617:	29 c1                	sub    %eax,%ecx
   42619:	89 ca                	mov    %ecx,%edx
   4261b:	85 d2                	test   %edx,%edx
   4261d:	74 3b                	je     4265a <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   4261f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42622:	48 8d 15 0a 22 00 00 	lea    0x220a(%rip),%rdx        # 44833 <complex_keymap+0xb3>
   42629:	be 00 c0 00 00       	mov    $0xc000,%esi
   4262e:	89 c7                	mov    %eax,%edi
   42630:	b8 00 00 00 00       	mov    $0x0,%eax
   42635:	e8 7d fd ff ff       	call   423b7 <error_printf>
   4263a:	eb 1e                	jmp    4265a <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   4263c:	48 8d 05 f2 21 00 00 	lea    0x21f2(%rip),%rax        # 44835 <complex_keymap+0xb5>
   42643:	48 89 c2             	mov    %rax,%rdx
   42646:	be 00 c0 00 00       	mov    $0xc000,%esi
   4264b:	bf 30 07 00 00       	mov    $0x730,%edi
   42650:	b8 00 00 00 00       	mov    $0x0,%eax
   42655:	e8 5d fd ff ff       	call   423b7 <error_printf>
    }

    va_end(val);
    fail();
   4265a:	e8 01 ff ff ff       	call   42560 <fail>

000000000004265f <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   4265f:	f3 0f 1e fa          	endbr64 
   42663:	55                   	push   %rbp
   42664:	48 89 e5             	mov    %rsp,%rbp
   42667:	48 83 ec 20          	sub    $0x20,%rsp
   4266b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4266f:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42672:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42676:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4267a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4267d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42681:	48 89 c6             	mov    %rax,%rsi
   42684:	48 8d 05 b0 21 00 00 	lea    0x21b0(%rip),%rax        # 4483b <complex_keymap+0xbb>
   4268b:	48 89 c7             	mov    %rax,%rdi
   4268e:	b8 00 00 00 00       	mov    $0x0,%eax
   42693:	e8 d7 fe ff ff       	call   4256f <panic>

0000000000042698 <default_exception>:
}

void default_exception(proc* p){
   42698:	f3 0f 1e fa          	endbr64 
   4269c:	55                   	push   %rbp
   4269d:	48 89 e5             	mov    %rsp,%rbp
   426a0:	48 83 ec 20          	sub    $0x20,%rsp
   426a4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   426a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   426ac:	48 83 c0 08          	add    $0x8,%rax
   426b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   426b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426b8:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   426bf:	48 89 c6             	mov    %rax,%rsi
   426c2:	48 8d 05 90 21 00 00 	lea    0x2190(%rip),%rax        # 44859 <complex_keymap+0xd9>
   426c9:	48 89 c7             	mov    %rax,%rdi
   426cc:	b8 00 00 00 00       	mov    $0x0,%eax
   426d1:	e8 99 fe ff ff       	call   4256f <panic>

00000000000426d6 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   426d6:	55                   	push   %rbp
   426d7:	48 89 e5             	mov    %rsp,%rbp
   426da:	48 83 ec 10          	sub    $0x10,%rsp
   426de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   426e2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   426e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   426e9:	78 06                	js     426f1 <pageindex+0x1b>
   426eb:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   426ef:	7e 1e                	jle    4270f <pageindex+0x39>
   426f1:	48 8d 05 80 21 00 00 	lea    0x2180(%rip),%rax        # 44878 <complex_keymap+0xf8>
   426f8:	48 89 c2             	mov    %rax,%rdx
   426fb:	be 1e 00 00 00       	mov    $0x1e,%esi
   42700:	48 8d 05 8a 21 00 00 	lea    0x218a(%rip),%rax        # 44891 <complex_keymap+0x111>
   42707:	48 89 c7             	mov    %rax,%rdi
   4270a:	e8 50 ff ff ff       	call   4265f <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   4270f:	b8 03 00 00 00       	mov    $0x3,%eax
   42714:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42717:	89 c2                	mov    %eax,%edx
   42719:	89 d0                	mov    %edx,%eax
   4271b:	c1 e0 03             	shl    $0x3,%eax
   4271e:	01 d0                	add    %edx,%eax
   42720:	83 c0 0c             	add    $0xc,%eax
   42723:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42727:	89 c1                	mov    %eax,%ecx
   42729:	48 d3 ea             	shr    %cl,%rdx
   4272c:	48 89 d0             	mov    %rdx,%rax
   4272f:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42734:	c9                   	leave  
   42735:	c3                   	ret    

0000000000042736 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42736:	f3 0f 1e fa          	endbr64 
   4273a:	55                   	push   %rbp
   4273b:	48 89 e5             	mov    %rsp,%rbp
   4273e:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42742:	48 8d 05 b7 28 01 00 	lea    0x128b7(%rip),%rax        # 55000 <kernel_pagetables>
   42749:	48 89 05 b0 18 01 00 	mov    %rax,0x118b0(%rip)        # 54000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42750:	ba 00 50 00 00       	mov    $0x5000,%edx
   42755:	be 00 00 00 00       	mov    $0x0,%esi
   4275a:	48 8d 05 9f 28 01 00 	lea    0x1289f(%rip),%rax        # 55000 <kernel_pagetables>
   42761:	48 89 c7             	mov    %rax,%rdi
   42764:	e8 8b 0b 00 00       	call   432f4 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42769:	48 8d 05 90 38 01 00 	lea    0x13890(%rip),%rax        # 56000 <kernel_pagetables+0x1000>
   42770:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42774:	48 89 05 85 28 01 00 	mov    %rax,0x12885(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   4277b:	48 8d 05 7e 48 01 00 	lea    0x1487e(%rip),%rax        # 57000 <kernel_pagetables+0x2000>
   42782:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42786:	48 89 05 73 38 01 00 	mov    %rax,0x13873(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   4278d:	48 8d 05 6c 58 01 00 	lea    0x1586c(%rip),%rax        # 58000 <kernel_pagetables+0x3000>
   42794:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42798:	48 89 05 61 48 01 00 	mov    %rax,0x14861(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   4279f:	48 8d 05 5a 68 01 00 	lea    0x1685a(%rip),%rax        # 59000 <kernel_pagetables+0x4000>
   427a6:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   427aa:	48 89 05 57 48 01 00 	mov    %rax,0x14857(%rip)        # 57008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   427b1:	48 8b 05 48 18 01 00 	mov    0x11848(%rip),%rax        # 54000 <kernel_pagetable>
   427b8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   427be:	b9 00 00 20 00       	mov    $0x200000,%ecx
   427c3:	ba 00 00 00 00       	mov    $0x0,%edx
   427c8:	be 00 00 00 00       	mov    $0x0,%esi
   427cd:	48 89 c7             	mov    %rax,%rdi
   427d0:	e8 0e 02 00 00       	call   429e3 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   427d5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   427dc:	00 
   427dd:	eb 76                	jmp    42855 <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   427df:	48 8b 0d 1a 18 01 00 	mov    0x1181a(%rip),%rcx        # 54000 <kernel_pagetable>
   427e6:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   427ea:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   427ee:	48 89 ce             	mov    %rcx,%rsi
   427f1:	48 89 c7             	mov    %rax,%rdi
   427f4:	e8 34 06 00 00       	call   42e2d <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   427f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   427fd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42801:	74 1e                	je     42821 <virtual_memory_init+0xeb>
   42803:	48 8d 05 9b 20 00 00 	lea    0x209b(%rip),%rax        # 448a5 <complex_keymap+0x125>
   4280a:	48 89 c2             	mov    %rax,%rdx
   4280d:	be 2d 00 00 00       	mov    $0x2d,%esi
   42812:	48 8d 05 9c 20 00 00 	lea    0x209c(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42819:	48 89 c7             	mov    %rax,%rdi
   4281c:	e8 3e fe ff ff       	call   4265f <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42821:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42824:	48 98                	cltq   
   42826:	83 e0 03             	and    $0x3,%eax
   42829:	48 83 f8 03          	cmp    $0x3,%rax
   4282d:	74 1e                	je     4284d <virtual_memory_init+0x117>
   4282f:	48 8d 05 92 20 00 00 	lea    0x2092(%rip),%rax        # 448c8 <complex_keymap+0x148>
   42836:	48 89 c2             	mov    %rax,%rdx
   42839:	be 2e 00 00 00       	mov    $0x2e,%esi
   4283e:	48 8d 05 70 20 00 00 	lea    0x2070(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42845:	48 89 c7             	mov    %rax,%rdi
   42848:	e8 12 fe ff ff       	call   4265f <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4284d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42854:	00 
   42855:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4285c:	00 
   4285d:	76 80                	jbe    427df <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   4285f:	48 8b 05 9a 17 01 00 	mov    0x1179a(%rip),%rax        # 54000 <kernel_pagetable>
   42866:	48 89 c7             	mov    %rax,%rdi
   42869:	e8 03 00 00 00       	call   42871 <set_pagetable>
}
   4286e:	90                   	nop
   4286f:	c9                   	leave  
   42870:	c3                   	ret    

0000000000042871 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42871:	f3 0f 1e fa          	endbr64 
   42875:	55                   	push   %rbp
   42876:	48 89 e5             	mov    %rsp,%rbp
   42879:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4287d:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42881:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42885:	25 ff 0f 00 00       	and    $0xfff,%eax
   4288a:	48 85 c0             	test   %rax,%rax
   4288d:	74 1e                	je     428ad <set_pagetable+0x3c>
   4288f:	48 8d 05 5f 20 00 00 	lea    0x205f(%rip),%rax        # 448f5 <complex_keymap+0x175>
   42896:	48 89 c2             	mov    %rax,%rdx
   42899:	be 3d 00 00 00       	mov    $0x3d,%esi
   4289e:	48 8d 05 10 20 00 00 	lea    0x2010(%rip),%rax        # 448b5 <complex_keymap+0x135>
   428a5:	48 89 c7             	mov    %rax,%rdi
   428a8:	e8 b2 fd ff ff       	call   4265f <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   428ad:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   428b4:	48 89 c2             	mov    %rax,%rdx
   428b7:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   428bb:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   428bf:	48 89 ce             	mov    %rcx,%rsi
   428c2:	48 89 c7             	mov    %rax,%rdi
   428c5:	e8 63 05 00 00       	call   42e2d <virtual_memory_lookup>
   428ca:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   428ce:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   428d5:	48 39 d0             	cmp    %rdx,%rax
   428d8:	74 1e                	je     428f8 <set_pagetable+0x87>
   428da:	48 8d 05 2f 20 00 00 	lea    0x202f(%rip),%rax        # 44910 <complex_keymap+0x190>
   428e1:	48 89 c2             	mov    %rax,%rdx
   428e4:	be 3f 00 00 00       	mov    $0x3f,%esi
   428e9:	48 8d 05 c5 1f 00 00 	lea    0x1fc5(%rip),%rax        # 448b5 <complex_keymap+0x135>
   428f0:	48 89 c7             	mov    %rax,%rdi
   428f3:	e8 67 fd ff ff       	call   4265f <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   428f8:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   428fc:	48 8b 0d fd 16 01 00 	mov    0x116fd(%rip),%rcx        # 54000 <kernel_pagetable>
   42903:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42907:	48 89 ce             	mov    %rcx,%rsi
   4290a:	48 89 c7             	mov    %rax,%rdi
   4290d:	e8 1b 05 00 00       	call   42e2d <virtual_memory_lookup>
   42912:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42916:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4291a:	48 39 c2             	cmp    %rax,%rdx
   4291d:	74 1e                	je     4293d <set_pagetable+0xcc>
   4291f:	48 8d 05 52 20 00 00 	lea    0x2052(%rip),%rax        # 44978 <complex_keymap+0x1f8>
   42926:	48 89 c2             	mov    %rax,%rdx
   42929:	be 41 00 00 00       	mov    $0x41,%esi
   4292e:	48 8d 05 80 1f 00 00 	lea    0x1f80(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42935:	48 89 c7             	mov    %rax,%rdi
   42938:	e8 22 fd ff ff       	call   4265f <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   4293d:	48 8b 05 bc 16 01 00 	mov    0x116bc(%rip),%rax        # 54000 <kernel_pagetable>
   42944:	48 89 c2             	mov    %rax,%rdx
   42947:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   4294b:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4294f:	48 89 ce             	mov    %rcx,%rsi
   42952:	48 89 c7             	mov    %rax,%rdi
   42955:	e8 d3 04 00 00       	call   42e2d <virtual_memory_lookup>
   4295a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4295e:	48 8b 15 9b 16 01 00 	mov    0x1169b(%rip),%rdx        # 54000 <kernel_pagetable>
   42965:	48 39 d0             	cmp    %rdx,%rax
   42968:	74 1e                	je     42988 <set_pagetable+0x117>
   4296a:	48 8d 05 67 20 00 00 	lea    0x2067(%rip),%rax        # 449d8 <complex_keymap+0x258>
   42971:	48 89 c2             	mov    %rax,%rdx
   42974:	be 43 00 00 00       	mov    $0x43,%esi
   42979:	48 8d 05 35 1f 00 00 	lea    0x1f35(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42980:	48 89 c7             	mov    %rax,%rdi
   42983:	e8 d7 fc ff ff       	call   4265f <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42988:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 429e3 <virtual_memory_map>
   4298f:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42993:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42997:	48 89 ce             	mov    %rcx,%rsi
   4299a:	48 89 c7             	mov    %rax,%rdi
   4299d:	e8 8b 04 00 00       	call   42e2d <virtual_memory_lookup>
   429a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   429a6:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 429e3 <virtual_memory_map>
   429ad:	48 39 d0             	cmp    %rdx,%rax
   429b0:	74 1e                	je     429d0 <set_pagetable+0x15f>
   429b2:	48 8d 05 87 20 00 00 	lea    0x2087(%rip),%rax        # 44a40 <complex_keymap+0x2c0>
   429b9:	48 89 c2             	mov    %rax,%rdx
   429bc:	be 45 00 00 00       	mov    $0x45,%esi
   429c1:	48 8d 05 ed 1e 00 00 	lea    0x1eed(%rip),%rax        # 448b5 <complex_keymap+0x135>
   429c8:	48 89 c7             	mov    %rax,%rdi
   429cb:	e8 8f fc ff ff       	call   4265f <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   429d0:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   429d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   429d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   429dc:	0f 22 d8             	mov    %rax,%cr3
}
   429df:	90                   	nop
}
   429e0:	90                   	nop
   429e1:	c9                   	leave  
   429e2:	c3                   	ret    

00000000000429e3 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   429e3:	f3 0f 1e fa          	endbr64 
   429e7:	55                   	push   %rbp
   429e8:	48 89 e5             	mov    %rsp,%rbp
   429eb:	48 83 ec 50          	sub    $0x50,%rsp
   429ef:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   429f3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   429f7:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   429fb:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   429ff:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42a03:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42a07:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a0c:	48 85 c0             	test   %rax,%rax
   42a0f:	74 1e                	je     42a2f <virtual_memory_map+0x4c>
   42a11:	48 8d 05 8e 20 00 00 	lea    0x208e(%rip),%rax        # 44aa6 <complex_keymap+0x326>
   42a18:	48 89 c2             	mov    %rax,%rdx
   42a1b:	be 66 00 00 00       	mov    $0x66,%esi
   42a20:	48 8d 05 8e 1e 00 00 	lea    0x1e8e(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42a27:	48 89 c7             	mov    %rax,%rdi
   42a2a:	e8 30 fc ff ff       	call   4265f <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42a2f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a33:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a38:	48 85 c0             	test   %rax,%rax
   42a3b:	74 1e                	je     42a5b <virtual_memory_map+0x78>
   42a3d:	48 8d 05 75 20 00 00 	lea    0x2075(%rip),%rax        # 44ab9 <complex_keymap+0x339>
   42a44:	48 89 c2             	mov    %rax,%rdx
   42a47:	be 67 00 00 00       	mov    $0x67,%esi
   42a4c:	48 8d 05 62 1e 00 00 	lea    0x1e62(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42a53:	48 89 c7             	mov    %rax,%rdi
   42a56:	e8 04 fc ff ff       	call   4265f <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42a5b:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42a5f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a63:	48 01 d0             	add    %rdx,%rax
   42a66:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42a6a:	76 2e                	jbe    42a9a <virtual_memory_map+0xb7>
   42a6c:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42a70:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a74:	48 01 d0             	add    %rdx,%rax
   42a77:	48 85 c0             	test   %rax,%rax
   42a7a:	74 1e                	je     42a9a <virtual_memory_map+0xb7>
   42a7c:	48 8d 05 49 20 00 00 	lea    0x2049(%rip),%rax        # 44acc <complex_keymap+0x34c>
   42a83:	48 89 c2             	mov    %rax,%rdx
   42a86:	be 68 00 00 00       	mov    $0x68,%esi
   42a8b:	48 8d 05 23 1e 00 00 	lea    0x1e23(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42a92:	48 89 c7             	mov    %rax,%rdi
   42a95:	e8 c5 fb ff ff       	call   4265f <assert_fail>
    if (perm & PTE_P) {
   42a9a:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42a9d:	48 98                	cltq   
   42a9f:	83 e0 01             	and    $0x1,%eax
   42aa2:	48 85 c0             	test   %rax,%rax
   42aa5:	0f 84 8c 00 00 00    	je     42b37 <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42aab:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42aaf:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ab4:	48 85 c0             	test   %rax,%rax
   42ab7:	74 1e                	je     42ad7 <virtual_memory_map+0xf4>
   42ab9:	48 8d 05 2a 20 00 00 	lea    0x202a(%rip),%rax        # 44aea <complex_keymap+0x36a>
   42ac0:	48 89 c2             	mov    %rax,%rdx
   42ac3:	be 6a 00 00 00       	mov    $0x6a,%esi
   42ac8:	48 8d 05 e6 1d 00 00 	lea    0x1de6(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42acf:	48 89 c7             	mov    %rax,%rdi
   42ad2:	e8 88 fb ff ff       	call   4265f <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42ad7:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42adb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42adf:	48 01 d0             	add    %rdx,%rax
   42ae2:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   42ae6:	76 1e                	jbe    42b06 <virtual_memory_map+0x123>
   42ae8:	48 8d 05 0e 20 00 00 	lea    0x200e(%rip),%rax        # 44afd <complex_keymap+0x37d>
   42aef:	48 89 c2             	mov    %rax,%rdx
   42af2:	be 6b 00 00 00       	mov    $0x6b,%esi
   42af7:	48 8d 05 b7 1d 00 00 	lea    0x1db7(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42afe:	48 89 c7             	mov    %rax,%rdi
   42b01:	e8 59 fb ff ff       	call   4265f <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42b06:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42b0a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42b0e:	48 01 d0             	add    %rdx,%rax
   42b11:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42b17:	76 1e                	jbe    42b37 <virtual_memory_map+0x154>
   42b19:	48 8d 05 eb 1f 00 00 	lea    0x1feb(%rip),%rax        # 44b0b <complex_keymap+0x38b>
   42b20:	48 89 c2             	mov    %rax,%rdx
   42b23:	be 6c 00 00 00       	mov    $0x6c,%esi
   42b28:	48 8d 05 86 1d 00 00 	lea    0x1d86(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42b2f:	48 89 c7             	mov    %rax,%rdi
   42b32:	e8 28 fb ff ff       	call   4265f <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42b37:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   42b3b:	78 09                	js     42b46 <virtual_memory_map+0x163>
   42b3d:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   42b44:	7e 1e                	jle    42b64 <virtual_memory_map+0x181>
   42b46:	48 8d 05 da 1f 00 00 	lea    0x1fda(%rip),%rax        # 44b27 <complex_keymap+0x3a7>
   42b4d:	48 89 c2             	mov    %rax,%rdx
   42b50:	be 6e 00 00 00       	mov    $0x6e,%esi
   42b55:	48 8d 05 59 1d 00 00 	lea    0x1d59(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42b5c:	48 89 c7             	mov    %rax,%rdi
   42b5f:	e8 fb fa ff ff       	call   4265f <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42b64:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b68:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b6d:	48 85 c0             	test   %rax,%rax
   42b70:	74 1e                	je     42b90 <virtual_memory_map+0x1ad>
   42b72:	48 8d 05 cf 1f 00 00 	lea    0x1fcf(%rip),%rax        # 44b48 <complex_keymap+0x3c8>
   42b79:	48 89 c2             	mov    %rax,%rdx
   42b7c:	be 6f 00 00 00       	mov    $0x6f,%esi
   42b81:	48 8d 05 2d 1d 00 00 	lea    0x1d2d(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42b88:	48 89 c7             	mov    %rax,%rdi
   42b8b:	e8 cf fa ff ff       	call   4265f <assert_fail>

    int last_index123 = -1;
   42b90:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42b97:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   42b9e:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42b9f:	e9 ed 00 00 00       	jmp    42c91 <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42ba4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42ba8:	48 c1 e8 15          	shr    $0x15,%rax
   42bac:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   42baf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42bb2:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   42bb5:	74 20                	je     42bd7 <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   42bb7:	8b 55 bc             	mov    -0x44(%rbp),%edx
   42bba:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   42bbe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bc2:	48 89 ce             	mov    %rcx,%rsi
   42bc5:	48 89 c7             	mov    %rax,%rdi
   42bc8:	e8 d6 00 00 00       	call   42ca3 <lookup_l1pagetable>
   42bcd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   42bd1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42bd4:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42bd7:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42bda:	48 98                	cltq   
   42bdc:	83 e0 01             	and    $0x1,%eax
   42bdf:	48 85 c0             	test   %rax,%rax
   42be2:	74 37                	je     42c1b <virtual_memory_map+0x238>
   42be4:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   42be9:	74 30                	je     42c1b <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   42beb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42bef:	be 03 00 00 00       	mov    $0x3,%esi
   42bf4:	48 89 c7             	mov    %rax,%rdi
   42bf7:	e8 da fa ff ff       	call   426d6 <pageindex>
   42bfc:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   42bff:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42c02:	48 98                	cltq   
   42c04:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   42c08:	48 89 c1             	mov    %rax,%rcx
   42c0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c0f:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42c12:	48 63 d2             	movslq %edx,%rdx
   42c15:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42c19:	eb 5e                	jmp    42c79 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   42c1b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   42c20:	74 2a                	je     42c4c <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   42c22:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c26:	be 03 00 00 00       	mov    $0x3,%esi
   42c2b:	48 89 c7             	mov    %rax,%rdi
   42c2e:	e8 a3 fa ff ff       	call   426d6 <pageindex>
   42c33:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   42c36:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42c39:	48 63 c8             	movslq %eax,%rcx
   42c3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c40:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42c43:	48 63 d2             	movslq %edx,%rdx
   42c46:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42c4a:	eb 2d                	jmp    42c79 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   42c4c:	8b 45 bc             	mov    -0x44(%rbp),%eax
   42c4f:	48 98                	cltq   
   42c51:	83 e0 01             	and    $0x1,%eax
   42c54:	48 85 c0             	test   %rax,%rax
   42c57:	74 20                	je     42c79 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42c59:	be 88 00 00 00       	mov    $0x88,%esi
   42c5e:	48 8d 05 0b 1f 00 00 	lea    0x1f0b(%rip),%rax        # 44b70 <complex_keymap+0x3f0>
   42c65:	48 89 c7             	mov    %rax,%rdi
   42c68:	b8 00 00 00 00       	mov    $0x0,%eax
   42c6d:	e8 92 f6 ff ff       	call   42304 <log_printf>
            return -1;
   42c72:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c77:	eb 28                	jmp    42ca1 <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42c79:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   42c80:	00 
   42c81:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   42c88:	00 
   42c89:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   42c90:	00 
   42c91:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   42c96:	0f 85 08 ff ff ff    	jne    42ba4 <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   42c9c:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42ca1:	c9                   	leave  
   42ca2:	c3                   	ret    

0000000000042ca3 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42ca3:	f3 0f 1e fa          	endbr64 
   42ca7:	55                   	push   %rbp
   42ca8:	48 89 e5             	mov    %rsp,%rbp
   42cab:	48 83 ec 40          	sub    $0x40,%rsp
   42caf:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42cb3:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42cb7:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42cba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cbe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42cc2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42cc9:	e9 4f 01 00 00       	jmp    42e1d <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
                int index = PAGEINDEX(va, i); // Get the index for the current level
   42cce:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42cd1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42cd5:	89 d6                	mov    %edx,%esi
   42cd7:	48 89 c7             	mov    %rax,%rdi
   42cda:	e8 f7 f9 ff ff       	call   426d6 <pageindex>
   42cdf:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   42ce2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ce6:	8b 55 f0             	mov    -0x10(%rbp),%edx
   42ce9:	48 63 d2             	movslq %edx,%rdx
   42cec:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42cf0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42cf4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cf8:	83 e0 01             	and    $0x1,%eax
   42cfb:	48 85 c0             	test   %rax,%rax
   42cfe:	75 6d                	jne    42d6d <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42d00:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42d03:	8d 48 02             	lea    0x2(%rax),%ecx
   42d06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d0a:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d0f:	48 89 c2             	mov    %rax,%rdx
   42d12:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d16:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d1c:	48 89 c6             	mov    %rax,%rsi
   42d1f:	48 8d 05 92 1e 00 00 	lea    0x1e92(%rip),%rax        # 44bb8 <complex_keymap+0x438>
   42d26:	48 89 c7             	mov    %rax,%rdi
   42d29:	b8 00 00 00 00       	mov    $0x0,%eax
   42d2e:	e8 d1 f5 ff ff       	call   42304 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42d33:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d36:	48 98                	cltq   
   42d38:	83 e0 01             	and    $0x1,%eax
   42d3b:	48 85 c0             	test   %rax,%rax
   42d3e:	75 0a                	jne    42d4a <lookup_l1pagetable+0xa7>
                return NULL;
   42d40:	b8 00 00 00 00       	mov    $0x0,%eax
   42d45:	e9 e1 00 00 00       	jmp    42e2b <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42d4a:	be ad 00 00 00       	mov    $0xad,%esi
   42d4f:	48 8d 05 ca 1e 00 00 	lea    0x1eca(%rip),%rax        # 44c20 <complex_keymap+0x4a0>
   42d56:	48 89 c7             	mov    %rax,%rdi
   42d59:	b8 00 00 00 00       	mov    $0x0,%eax
   42d5e:	e8 a1 f5 ff ff       	call   42304 <log_printf>
            return NULL;
   42d63:	b8 00 00 00 00       	mov    $0x0,%eax
   42d68:	e9 be 00 00 00       	jmp    42e2b <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42d6d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d71:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d77:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42d7d:	76 1e                	jbe    42d9d <lookup_l1pagetable+0xfa>
   42d7f:	48 8d 05 e2 1e 00 00 	lea    0x1ee2(%rip),%rax        # 44c68 <complex_keymap+0x4e8>
   42d86:	48 89 c2             	mov    %rax,%rdx
   42d89:	be b2 00 00 00       	mov    $0xb2,%esi
   42d8e:	48 8d 05 20 1b 00 00 	lea    0x1b20(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42d95:	48 89 c7             	mov    %rax,%rdi
   42d98:	e8 c2 f8 ff ff       	call   4265f <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42d9d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42da0:	48 98                	cltq   
   42da2:	83 e0 02             	and    $0x2,%eax
   42da5:	48 85 c0             	test   %rax,%rax
   42da8:	74 2a                	je     42dd4 <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42daa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dae:	83 e0 02             	and    $0x2,%eax
   42db1:	48 85 c0             	test   %rax,%rax
   42db4:	75 1e                	jne    42dd4 <lookup_l1pagetable+0x131>
   42db6:	48 8d 05 cb 1e 00 00 	lea    0x1ecb(%rip),%rax        # 44c88 <complex_keymap+0x508>
   42dbd:	48 89 c2             	mov    %rax,%rdx
   42dc0:	be b4 00 00 00       	mov    $0xb4,%esi
   42dc5:	48 8d 05 e9 1a 00 00 	lea    0x1ae9(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42dcc:	48 89 c7             	mov    %rax,%rdi
   42dcf:	e8 8b f8 ff ff       	call   4265f <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42dd4:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42dd7:	48 98                	cltq   
   42dd9:	83 e0 04             	and    $0x4,%eax
   42ddc:	48 85 c0             	test   %rax,%rax
   42ddf:	74 2a                	je     42e0b <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42de1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42de5:	83 e0 04             	and    $0x4,%eax
   42de8:	48 85 c0             	test   %rax,%rax
   42deb:	75 1e                	jne    42e0b <lookup_l1pagetable+0x168>
   42ded:	48 8d 05 9f 1e 00 00 	lea    0x1e9f(%rip),%rax        # 44c93 <complex_keymap+0x513>
   42df4:	48 89 c2             	mov    %rax,%rdx
   42df7:	be b7 00 00 00       	mov    $0xb7,%esi
   42dfc:	48 8d 05 b2 1a 00 00 	lea    0x1ab2(%rip),%rax        # 448b5 <complex_keymap+0x135>
   42e03:	48 89 c7             	mov    %rax,%rdi
   42e06:	e8 54 f8 ff ff       	call   4265f <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42e0b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e0f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42e15:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42e19:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42e1d:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42e21:	0f 8e a7 fe ff ff    	jle    42cce <lookup_l1pagetable+0x2b>
    }
    return pt;
   42e27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42e2b:	c9                   	leave  
   42e2c:	c3                   	ret    

0000000000042e2d <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42e2d:	f3 0f 1e fa          	endbr64 
   42e31:	55                   	push   %rbp
   42e32:	48 89 e5             	mov    %rsp,%rbp
   42e35:	48 83 ec 50          	sub    $0x50,%rsp
   42e39:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42e3d:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42e41:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42e45:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e49:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42e4d:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42e54:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42e55:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42e5c:	eb 41                	jmp    42e9f <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42e5e:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42e61:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42e65:	89 d6                	mov    %edx,%esi
   42e67:	48 89 c7             	mov    %rax,%rdi
   42e6a:	e8 67 f8 ff ff       	call   426d6 <pageindex>
   42e6f:	89 c2                	mov    %eax,%edx
   42e71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e75:	48 63 d2             	movslq %edx,%rdx
   42e78:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42e7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e80:	83 e0 06             	and    $0x6,%eax
   42e83:	48 f7 d0             	not    %rax
   42e86:	48 21 d0             	and    %rdx,%rax
   42e89:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42e8d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e91:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42e97:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42e9b:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42e9f:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42ea3:	7f 0c                	jg     42eb1 <virtual_memory_lookup+0x84>
   42ea5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ea9:	83 e0 01             	and    $0x1,%eax
   42eac:	48 85 c0             	test   %rax,%rax
   42eaf:	75 ad                	jne    42e5e <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42eb1:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42eb8:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42ebf:	ff 
   42ec0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42ec7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ecb:	83 e0 01             	and    $0x1,%eax
   42ece:	48 85 c0             	test   %rax,%rax
   42ed1:	74 34                	je     42f07 <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   42ed3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ed7:	48 c1 e8 0c          	shr    $0xc,%rax
   42edb:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42ede:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ee2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ee8:	48 89 c2             	mov    %rax,%rdx
   42eeb:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42eef:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ef4:	48 09 d0             	or     %rdx,%rax
   42ef7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42efb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42eff:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f04:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42f07:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42f0b:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42f0f:	48 89 10             	mov    %rdx,(%rax)
   42f12:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42f16:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42f1a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42f1e:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42f22:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42f26:	c9                   	leave  
   42f27:	c3                   	ret    

0000000000042f28 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42f28:	f3 0f 1e fa          	endbr64 
   42f2c:	55                   	push   %rbp
   42f2d:	48 89 e5             	mov    %rsp,%rbp
   42f30:	48 83 ec 40          	sub    $0x40,%rsp
   42f34:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f38:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42f3b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42f3f:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42f46:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42f4a:	78 08                	js     42f54 <program_load+0x2c>
   42f4c:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42f4f:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42f52:	7c 1e                	jl     42f72 <program_load+0x4a>
   42f54:	48 8d 05 45 1d 00 00 	lea    0x1d45(%rip),%rax        # 44ca0 <complex_keymap+0x520>
   42f5b:	48 89 c2             	mov    %rax,%rdx
   42f5e:	be 37 00 00 00       	mov    $0x37,%esi
   42f63:	48 8d 05 66 1d 00 00 	lea    0x1d66(%rip),%rax        # 44cd0 <complex_keymap+0x550>
   42f6a:	48 89 c7             	mov    %rax,%rdi
   42f6d:	e8 ed f6 ff ff       	call   4265f <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42f72:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42f75:	48 98                	cltq   
   42f77:	48 c1 e0 04          	shl    $0x4,%rax
   42f7b:	48 89 c2             	mov    %rax,%rdx
   42f7e:	48 8d 05 9b 20 00 00 	lea    0x209b(%rip),%rax        # 45020 <ramimages>
   42f85:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   42f89:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42f8d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f91:	8b 00                	mov    (%rax),%eax
   42f93:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42f98:	74 1e                	je     42fb8 <program_load+0x90>
   42f9a:	48 8d 05 41 1d 00 00 	lea    0x1d41(%rip),%rax        # 44ce2 <complex_keymap+0x562>
   42fa1:	48 89 c2             	mov    %rax,%rdx
   42fa4:	be 39 00 00 00       	mov    $0x39,%esi
   42fa9:	48 8d 05 20 1d 00 00 	lea    0x1d20(%rip),%rax        # 44cd0 <complex_keymap+0x550>
   42fb0:	48 89 c7             	mov    %rax,%rdi
   42fb3:	e8 a7 f6 ff ff       	call   4265f <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42fb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fbc:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42fc0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fc4:	48 01 d0             	add    %rdx,%rax
   42fc7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42fcb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42fd2:	e9 94 00 00 00       	jmp    4306b <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42fd7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42fda:	48 63 d0             	movslq %eax,%rdx
   42fdd:	48 89 d0             	mov    %rdx,%rax
   42fe0:	48 c1 e0 03          	shl    $0x3,%rax
   42fe4:	48 29 d0             	sub    %rdx,%rax
   42fe7:	48 c1 e0 03          	shl    $0x3,%rax
   42feb:	48 89 c2             	mov    %rax,%rdx
   42fee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ff2:	48 01 d0             	add    %rdx,%rax
   42ff5:	8b 00                	mov    (%rax),%eax
   42ff7:	83 f8 01             	cmp    $0x1,%eax
   42ffa:	75 6b                	jne    43067 <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42ffc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42fff:	48 63 d0             	movslq %eax,%rdx
   43002:	48 89 d0             	mov    %rdx,%rax
   43005:	48 c1 e0 03          	shl    $0x3,%rax
   43009:	48 29 d0             	sub    %rdx,%rax
   4300c:	48 c1 e0 03          	shl    $0x3,%rax
   43010:	48 89 c2             	mov    %rax,%rdx
   43013:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43017:	48 01 d0             	add    %rdx,%rax
   4301a:	48 8b 50 08          	mov    0x8(%rax),%rdx
   4301e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43022:	48 01 d0             	add    %rdx,%rax
   43025:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   43029:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4302c:	48 63 d0             	movslq %eax,%rdx
   4302f:	48 89 d0             	mov    %rdx,%rax
   43032:	48 c1 e0 03          	shl    $0x3,%rax
   43036:	48 29 d0             	sub    %rdx,%rax
   43039:	48 c1 e0 03          	shl    $0x3,%rax
   4303d:	48 89 c2             	mov    %rax,%rdx
   43040:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43044:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43048:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4304c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43050:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43054:	48 89 c7             	mov    %rax,%rdi
   43057:	e8 3d 00 00 00       	call   43099 <program_load_segment>
   4305c:	85 c0                	test   %eax,%eax
   4305e:	79 07                	jns    43067 <program_load+0x13f>
                return -1;
   43060:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43065:	eb 30                	jmp    43097 <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43067:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4306b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4306f:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   43073:	0f b7 c0             	movzwl %ax,%eax
   43076:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43079:	0f 8c 58 ff ff ff    	jl     42fd7 <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   4307f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43083:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43087:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4308b:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   43092:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43097:	c9                   	leave  
   43098:	c3                   	ret    

0000000000043099 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43099:	f3 0f 1e fa          	endbr64 
   4309d:	55                   	push   %rbp
   4309e:	48 89 e5             	mov    %rsp,%rbp
   430a1:	48 83 ec 40          	sub    $0x40,%rsp
   430a5:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   430a9:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   430ad:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   430b1:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   430b5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   430b9:	48 8b 40 10          	mov    0x10(%rax),%rax
   430bd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   430c1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   430c5:	48 8b 50 20          	mov    0x20(%rax),%rdx
   430c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430cd:	48 01 d0             	add    %rdx,%rax
   430d0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   430d4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   430d8:	48 8b 50 28          	mov    0x28(%rax),%rdx
   430dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430e0:	48 01 d0             	add    %rdx,%rax
   430e3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   430e7:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   430ee:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   430ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430f3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   430f7:	e9 81 00 00 00       	jmp    4317d <program_load_segment+0xe4>
        if (assign_physical_page(addr, p->p_pid) < 0
   430fc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43100:	8b 00                	mov    (%rax),%eax
   43102:	0f be d0             	movsbl %al,%edx
   43105:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43109:	89 d6                	mov    %edx,%esi
   4310b:	48 89 c7             	mov    %rax,%rdi
   4310e:	e8 ca d3 ff ff       	call   404dd <assign_physical_page>
   43113:	85 c0                	test   %eax,%eax
   43115:	78 2a                	js     43141 <program_load_segment+0xa8>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   43117:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4311b:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43122:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43126:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4312a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43130:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43135:	48 89 c7             	mov    %rax,%rdi
   43138:	e8 a6 f8 ff ff       	call   429e3 <virtual_memory_map>
   4313d:	85 c0                	test   %eax,%eax
   4313f:	79 34                	jns    43175 <program_load_segment+0xdc>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43141:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43145:	8b 00                	mov    (%rax),%eax
   43147:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4314b:	49 89 d0             	mov    %rdx,%r8
   4314e:	89 c1                	mov    %eax,%ecx
   43150:	48 8d 05 a9 1b 00 00 	lea    0x1ba9(%rip),%rax        # 44d00 <complex_keymap+0x580>
   43157:	48 89 c2             	mov    %rax,%rdx
   4315a:	be 00 c0 00 00       	mov    $0xc000,%esi
   4315f:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43164:	b8 00 00 00 00       	mov    $0x0,%eax
   43169:	e8 c5 0f 00 00       	call   44133 <console_printf>
            return -1;
   4316e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43173:	eb 77                	jmp    431ec <program_load_segment+0x153>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43175:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4317c:	00 
   4317d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43181:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43185:	0f 82 71 ff ff ff    	jb     430fc <program_load_segment+0x63>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   4318b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4318f:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43196:	48 89 c7             	mov    %rax,%rdi
   43199:	e8 d3 f6 ff ff       	call   42871 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   4319e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431a2:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   431a6:	48 89 c2             	mov    %rax,%rdx
   431a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431ad:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   431b1:	48 89 ce             	mov    %rcx,%rsi
   431b4:	48 89 c7             	mov    %rax,%rdi
   431b7:	e8 32 00 00 00       	call   431ee <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   431bc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   431c0:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   431c4:	48 89 c2             	mov    %rax,%rdx
   431c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431cb:	be 00 00 00 00       	mov    $0x0,%esi
   431d0:	48 89 c7             	mov    %rax,%rdi
   431d3:	e8 1c 01 00 00       	call   432f4 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   431d8:	48 8b 05 21 0e 01 00 	mov    0x10e21(%rip),%rax        # 54000 <kernel_pagetable>
   431df:	48 89 c7             	mov    %rax,%rdi
   431e2:	e8 8a f6 ff ff       	call   42871 <set_pagetable>
    return 0;
   431e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
   431ec:	c9                   	leave  
   431ed:	c3                   	ret    

00000000000431ee <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   431ee:	f3 0f 1e fa          	endbr64 
   431f2:	55                   	push   %rbp
   431f3:	48 89 e5             	mov    %rsp,%rbp
   431f6:	48 83 ec 28          	sub    $0x28,%rsp
   431fa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   431fe:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43202:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43206:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4320a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4320e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43212:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43216:	eb 1c                	jmp    43234 <memcpy+0x46>
        *d = *s;
   43218:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4321c:	0f b6 10             	movzbl (%rax),%edx
   4321f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43223:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43225:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4322a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4322f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43234:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43239:	75 dd                	jne    43218 <memcpy+0x2a>
    }
    return dst;
   4323b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4323f:	c9                   	leave  
   43240:	c3                   	ret    

0000000000043241 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43241:	f3 0f 1e fa          	endbr64 
   43245:	55                   	push   %rbp
   43246:	48 89 e5             	mov    %rsp,%rbp
   43249:	48 83 ec 28          	sub    $0x28,%rsp
   4324d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43251:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43255:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43259:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4325d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43261:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43265:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43269:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4326d:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43271:	73 6a                	jae    432dd <memmove+0x9c>
   43273:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43277:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4327b:	48 01 d0             	add    %rdx,%rax
   4327e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43282:	73 59                	jae    432dd <memmove+0x9c>
        s += n, d += n;
   43284:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43288:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   4328c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43290:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43294:	eb 17                	jmp    432ad <memmove+0x6c>
            *--d = *--s;
   43296:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   4329b:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   432a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   432a4:	0f b6 10             	movzbl (%rax),%edx
   432a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ab:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   432ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432b1:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   432b5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   432b9:	48 85 c0             	test   %rax,%rax
   432bc:	75 d8                	jne    43296 <memmove+0x55>
    if (s < d && s + n > d) {
   432be:	eb 2e                	jmp    432ee <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   432c0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   432c4:	48 8d 42 01          	lea    0x1(%rdx),%rax
   432c8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   432cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432d0:	48 8d 48 01          	lea    0x1(%rax),%rcx
   432d4:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   432d8:	0f b6 12             	movzbl (%rdx),%edx
   432db:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   432dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432e1:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   432e5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   432e9:	48 85 c0             	test   %rax,%rax
   432ec:	75 d2                	jne    432c0 <memmove+0x7f>
        }
    }
    return dst;
   432ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   432f2:	c9                   	leave  
   432f3:	c3                   	ret    

00000000000432f4 <memset>:

void* memset(void* v, int c, size_t n) {
   432f4:	f3 0f 1e fa          	endbr64 
   432f8:	55                   	push   %rbp
   432f9:	48 89 e5             	mov    %rsp,%rbp
   432fc:	48 83 ec 28          	sub    $0x28,%rsp
   43300:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43304:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43307:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4330b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4330f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43313:	eb 15                	jmp    4332a <memset+0x36>
        *p = c;
   43315:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43318:	89 c2                	mov    %eax,%edx
   4331a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4331e:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43320:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43325:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4332a:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4332f:	75 e4                	jne    43315 <memset+0x21>
    }
    return v;
   43331:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43335:	c9                   	leave  
   43336:	c3                   	ret    

0000000000043337 <strlen>:

size_t strlen(const char* s) {
   43337:	f3 0f 1e fa          	endbr64 
   4333b:	55                   	push   %rbp
   4333c:	48 89 e5             	mov    %rsp,%rbp
   4333f:	48 83 ec 18          	sub    $0x18,%rsp
   43343:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43347:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4334e:	00 
   4334f:	eb 0a                	jmp    4335b <strlen+0x24>
        ++n;
   43351:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43356:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4335b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4335f:	0f b6 00             	movzbl (%rax),%eax
   43362:	84 c0                	test   %al,%al
   43364:	75 eb                	jne    43351 <strlen+0x1a>
    }
    return n;
   43366:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   4336a:	c9                   	leave  
   4336b:	c3                   	ret    

000000000004336c <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   4336c:	f3 0f 1e fa          	endbr64 
   43370:	55                   	push   %rbp
   43371:	48 89 e5             	mov    %rsp,%rbp
   43374:	48 83 ec 20          	sub    $0x20,%rsp
   43378:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4337c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43380:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43387:	00 
   43388:	eb 0a                	jmp    43394 <strnlen+0x28>
        ++n;
   4338a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   4338f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43394:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43398:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   4339c:	74 0b                	je     433a9 <strnlen+0x3d>
   4339e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433a2:	0f b6 00             	movzbl (%rax),%eax
   433a5:	84 c0                	test   %al,%al
   433a7:	75 e1                	jne    4338a <strnlen+0x1e>
    }
    return n;
   433a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   433ad:	c9                   	leave  
   433ae:	c3                   	ret    

00000000000433af <strcpy>:

char* strcpy(char* dst, const char* src) {
   433af:	f3 0f 1e fa          	endbr64 
   433b3:	55                   	push   %rbp
   433b4:	48 89 e5             	mov    %rsp,%rbp
   433b7:	48 83 ec 20          	sub    $0x20,%rsp
   433bb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   433bf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   433c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433c7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   433cb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   433cf:	48 8d 42 01          	lea    0x1(%rdx),%rax
   433d3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   433d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433db:	48 8d 48 01          	lea    0x1(%rax),%rcx
   433df:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   433e3:	0f b6 12             	movzbl (%rdx),%edx
   433e6:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   433e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433ec:	48 83 e8 01          	sub    $0x1,%rax
   433f0:	0f b6 00             	movzbl (%rax),%eax
   433f3:	84 c0                	test   %al,%al
   433f5:	75 d4                	jne    433cb <strcpy+0x1c>
    return dst;
   433f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   433fb:	c9                   	leave  
   433fc:	c3                   	ret    

00000000000433fd <strcmp>:

int strcmp(const char* a, const char* b) {
   433fd:	f3 0f 1e fa          	endbr64 
   43401:	55                   	push   %rbp
   43402:	48 89 e5             	mov    %rsp,%rbp
   43405:	48 83 ec 10          	sub    $0x10,%rsp
   43409:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4340d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43411:	eb 0a                	jmp    4341d <strcmp+0x20>
        ++a, ++b;
   43413:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43418:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   4341d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43421:	0f b6 00             	movzbl (%rax),%eax
   43424:	84 c0                	test   %al,%al
   43426:	74 1d                	je     43445 <strcmp+0x48>
   43428:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4342c:	0f b6 00             	movzbl (%rax),%eax
   4342f:	84 c0                	test   %al,%al
   43431:	74 12                	je     43445 <strcmp+0x48>
   43433:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43437:	0f b6 10             	movzbl (%rax),%edx
   4343a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4343e:	0f b6 00             	movzbl (%rax),%eax
   43441:	38 c2                	cmp    %al,%dl
   43443:	74 ce                	je     43413 <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43445:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43449:	0f b6 00             	movzbl (%rax),%eax
   4344c:	89 c2                	mov    %eax,%edx
   4344e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43452:	0f b6 00             	movzbl (%rax),%eax
   43455:	38 c2                	cmp    %al,%dl
   43457:	0f 97 c0             	seta   %al
   4345a:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   4345d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43461:	0f b6 00             	movzbl (%rax),%eax
   43464:	89 c1                	mov    %eax,%ecx
   43466:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4346a:	0f b6 00             	movzbl (%rax),%eax
   4346d:	38 c1                	cmp    %al,%cl
   4346f:	0f 92 c0             	setb   %al
   43472:	0f b6 c8             	movzbl %al,%ecx
   43475:	89 d0                	mov    %edx,%eax
   43477:	29 c8                	sub    %ecx,%eax
}
   43479:	c9                   	leave  
   4347a:	c3                   	ret    

000000000004347b <strchr>:

char* strchr(const char* s, int c) {
   4347b:	f3 0f 1e fa          	endbr64 
   4347f:	55                   	push   %rbp
   43480:	48 89 e5             	mov    %rsp,%rbp
   43483:	48 83 ec 10          	sub    $0x10,%rsp
   43487:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4348b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   4348e:	eb 05                	jmp    43495 <strchr+0x1a>
        ++s;
   43490:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43495:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43499:	0f b6 00             	movzbl (%rax),%eax
   4349c:	84 c0                	test   %al,%al
   4349e:	74 0e                	je     434ae <strchr+0x33>
   434a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434a4:	0f b6 00             	movzbl (%rax),%eax
   434a7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   434aa:	38 d0                	cmp    %dl,%al
   434ac:	75 e2                	jne    43490 <strchr+0x15>
    }
    if (*s == (char) c) {
   434ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434b2:	0f b6 00             	movzbl (%rax),%eax
   434b5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   434b8:	38 d0                	cmp    %dl,%al
   434ba:	75 06                	jne    434c2 <strchr+0x47>
        return (char*) s;
   434bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434c0:	eb 05                	jmp    434c7 <strchr+0x4c>
    } else {
        return NULL;
   434c2:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   434c7:	c9                   	leave  
   434c8:	c3                   	ret    

00000000000434c9 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   434c9:	f3 0f 1e fa          	endbr64 
   434cd:	55                   	push   %rbp
   434ce:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   434d1:	8b 05 29 6b 01 00    	mov    0x16b29(%rip),%eax        # 5a000 <rand_seed_set>
   434d7:	85 c0                	test   %eax,%eax
   434d9:	75 0a                	jne    434e5 <rand+0x1c>
        srand(819234718U);
   434db:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   434e0:	e8 24 00 00 00       	call   43509 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   434e5:	8b 05 19 6b 01 00    	mov    0x16b19(%rip),%eax        # 5a004 <rand_seed>
   434eb:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   434f1:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   434f6:	89 05 08 6b 01 00    	mov    %eax,0x16b08(%rip)        # 5a004 <rand_seed>
    return rand_seed & RAND_MAX;
   434fc:	8b 05 02 6b 01 00    	mov    0x16b02(%rip),%eax        # 5a004 <rand_seed>
   43502:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43507:	5d                   	pop    %rbp
   43508:	c3                   	ret    

0000000000043509 <srand>:

void srand(unsigned seed) {
   43509:	f3 0f 1e fa          	endbr64 
   4350d:	55                   	push   %rbp
   4350e:	48 89 e5             	mov    %rsp,%rbp
   43511:	48 83 ec 08          	sub    $0x8,%rsp
   43515:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43518:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4351b:	89 05 e3 6a 01 00    	mov    %eax,0x16ae3(%rip)        # 5a004 <rand_seed>
    rand_seed_set = 1;
   43521:	c7 05 d5 6a 01 00 01 	movl   $0x1,0x16ad5(%rip)        # 5a000 <rand_seed_set>
   43528:	00 00 00 
}
   4352b:	90                   	nop
   4352c:	c9                   	leave  
   4352d:	c3                   	ret    

000000000004352e <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   4352e:	f3 0f 1e fa          	endbr64 
   43532:	55                   	push   %rbp
   43533:	48 89 e5             	mov    %rsp,%rbp
   43536:	48 83 ec 28          	sub    $0x28,%rsp
   4353a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4353e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43542:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43545:	48 8d 05 f4 18 00 00 	lea    0x18f4(%rip),%rax        # 44e40 <upper_digits.1>
   4354c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   43550:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43554:	79 0e                	jns    43564 <fill_numbuf+0x36>
        digits = lower_digits;
   43556:	48 8d 05 03 19 00 00 	lea    0x1903(%rip),%rax        # 44e60 <lower_digits.0>
   4355d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   43561:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43564:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43569:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4356d:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43570:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43573:	48 63 c8             	movslq %eax,%rcx
   43576:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4357a:	ba 00 00 00 00       	mov    $0x0,%edx
   4357f:	48 f7 f1             	div    %rcx
   43582:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43586:	48 01 d0             	add    %rdx,%rax
   43589:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4358e:	0f b6 10             	movzbl (%rax),%edx
   43591:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43595:	88 10                	mov    %dl,(%rax)
        val /= base;
   43597:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4359a:	48 63 f0             	movslq %eax,%rsi
   4359d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435a1:	ba 00 00 00 00       	mov    $0x0,%edx
   435a6:	48 f7 f6             	div    %rsi
   435a9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   435ad:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   435b2:	75 bc                	jne    43570 <fill_numbuf+0x42>
    return numbuf_end;
   435b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   435b8:	c9                   	leave  
   435b9:	c3                   	ret    

00000000000435ba <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   435ba:	f3 0f 1e fa          	endbr64 
   435be:	55                   	push   %rbp
   435bf:	48 89 e5             	mov    %rsp,%rbp
   435c2:	53                   	push   %rbx
   435c3:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   435ca:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   435d1:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   435d7:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   435de:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   435e5:	e9 bd 09 00 00       	jmp    43fa7 <printer_vprintf+0x9ed>
        if (*format != '%') {
   435ea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   435f1:	0f b6 00             	movzbl (%rax),%eax
   435f4:	3c 25                	cmp    $0x25,%al
   435f6:	74 31                	je     43629 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   435f8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   435ff:	4c 8b 00             	mov    (%rax),%r8
   43602:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43609:	0f b6 00             	movzbl (%rax),%eax
   4360c:	0f b6 c8             	movzbl %al,%ecx
   4360f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43615:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4361c:	89 ce                	mov    %ecx,%esi
   4361e:	48 89 c7             	mov    %rax,%rdi
   43621:	41 ff d0             	call   *%r8
            continue;
   43624:	e9 76 09 00 00       	jmp    43f9f <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   43629:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43630:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43637:	01 
   43638:	eb 4d                	jmp    43687 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   4363a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43641:	0f b6 00             	movzbl (%rax),%eax
   43644:	0f be c0             	movsbl %al,%eax
   43647:	89 c6                	mov    %eax,%esi
   43649:	48 8d 05 f0 16 00 00 	lea    0x16f0(%rip),%rax        # 44d40 <flag_chars>
   43650:	48 89 c7             	mov    %rax,%rdi
   43653:	e8 23 fe ff ff       	call   4347b <strchr>
   43658:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   4365c:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43661:	74 34                	je     43697 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   43663:	48 8d 15 d6 16 00 00 	lea    0x16d6(%rip),%rdx        # 44d40 <flag_chars>
   4366a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4366e:	48 29 d0             	sub    %rdx,%rax
   43671:	ba 01 00 00 00       	mov    $0x1,%edx
   43676:	89 c1                	mov    %eax,%ecx
   43678:	d3 e2                	shl    %cl,%edx
   4367a:	89 d0                	mov    %edx,%eax
   4367c:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   4367f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43686:	01 
   43687:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4368e:	0f b6 00             	movzbl (%rax),%eax
   43691:	84 c0                	test   %al,%al
   43693:	75 a5                	jne    4363a <printer_vprintf+0x80>
   43695:	eb 01                	jmp    43698 <printer_vprintf+0xde>
            } else {
                break;
   43697:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43698:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   4369f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436a6:	0f b6 00             	movzbl (%rax),%eax
   436a9:	3c 30                	cmp    $0x30,%al
   436ab:	7e 67                	jle    43714 <printer_vprintf+0x15a>
   436ad:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436b4:	0f b6 00             	movzbl (%rax),%eax
   436b7:	3c 39                	cmp    $0x39,%al
   436b9:	7f 59                	jg     43714 <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   436bb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   436c2:	eb 2e                	jmp    436f2 <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   436c4:	8b 55 e8             	mov    -0x18(%rbp),%edx
   436c7:	89 d0                	mov    %edx,%eax
   436c9:	c1 e0 02             	shl    $0x2,%eax
   436cc:	01 d0                	add    %edx,%eax
   436ce:	01 c0                	add    %eax,%eax
   436d0:	89 c1                	mov    %eax,%ecx
   436d2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436d9:	48 8d 50 01          	lea    0x1(%rax),%rdx
   436dd:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   436e4:	0f b6 00             	movzbl (%rax),%eax
   436e7:	0f be c0             	movsbl %al,%eax
   436ea:	01 c8                	add    %ecx,%eax
   436ec:	83 e8 30             	sub    $0x30,%eax
   436ef:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   436f2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436f9:	0f b6 00             	movzbl (%rax),%eax
   436fc:	3c 2f                	cmp    $0x2f,%al
   436fe:	0f 8e 85 00 00 00    	jle    43789 <printer_vprintf+0x1cf>
   43704:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4370b:	0f b6 00             	movzbl (%rax),%eax
   4370e:	3c 39                	cmp    $0x39,%al
   43710:	7e b2                	jle    436c4 <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   43712:	eb 75                	jmp    43789 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   43714:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4371b:	0f b6 00             	movzbl (%rax),%eax
   4371e:	3c 2a                	cmp    $0x2a,%al
   43720:	75 68                	jne    4378a <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   43722:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43729:	8b 00                	mov    (%rax),%eax
   4372b:	83 f8 2f             	cmp    $0x2f,%eax
   4372e:	77 30                	ja     43760 <printer_vprintf+0x1a6>
   43730:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43737:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4373b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43742:	8b 00                	mov    (%rax),%eax
   43744:	89 c0                	mov    %eax,%eax
   43746:	48 01 d0             	add    %rdx,%rax
   43749:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43750:	8b 12                	mov    (%rdx),%edx
   43752:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43755:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4375c:	89 0a                	mov    %ecx,(%rdx)
   4375e:	eb 1a                	jmp    4377a <printer_vprintf+0x1c0>
   43760:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43767:	48 8b 40 08          	mov    0x8(%rax),%rax
   4376b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4376f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43776:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4377a:	8b 00                	mov    (%rax),%eax
   4377c:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   4377f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43786:	01 
   43787:	eb 01                	jmp    4378a <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   43789:	90                   	nop
        }

        // process precision
        int precision = -1;
   4378a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43791:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43798:	0f b6 00             	movzbl (%rax),%eax
   4379b:	3c 2e                	cmp    $0x2e,%al
   4379d:	0f 85 00 01 00 00    	jne    438a3 <printer_vprintf+0x2e9>
            ++format;
   437a3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   437aa:	01 
            if (*format >= '0' && *format <= '9') {
   437ab:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437b2:	0f b6 00             	movzbl (%rax),%eax
   437b5:	3c 2f                	cmp    $0x2f,%al
   437b7:	7e 67                	jle    43820 <printer_vprintf+0x266>
   437b9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437c0:	0f b6 00             	movzbl (%rax),%eax
   437c3:	3c 39                	cmp    $0x39,%al
   437c5:	7f 59                	jg     43820 <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   437c7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   437ce:	eb 2e                	jmp    437fe <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   437d0:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   437d3:	89 d0                	mov    %edx,%eax
   437d5:	c1 e0 02             	shl    $0x2,%eax
   437d8:	01 d0                	add    %edx,%eax
   437da:	01 c0                	add    %eax,%eax
   437dc:	89 c1                	mov    %eax,%ecx
   437de:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437e5:	48 8d 50 01          	lea    0x1(%rax),%rdx
   437e9:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   437f0:	0f b6 00             	movzbl (%rax),%eax
   437f3:	0f be c0             	movsbl %al,%eax
   437f6:	01 c8                	add    %ecx,%eax
   437f8:	83 e8 30             	sub    $0x30,%eax
   437fb:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   437fe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43805:	0f b6 00             	movzbl (%rax),%eax
   43808:	3c 2f                	cmp    $0x2f,%al
   4380a:	0f 8e 85 00 00 00    	jle    43895 <printer_vprintf+0x2db>
   43810:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43817:	0f b6 00             	movzbl (%rax),%eax
   4381a:	3c 39                	cmp    $0x39,%al
   4381c:	7e b2                	jle    437d0 <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   4381e:	eb 75                	jmp    43895 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   43820:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43827:	0f b6 00             	movzbl (%rax),%eax
   4382a:	3c 2a                	cmp    $0x2a,%al
   4382c:	75 68                	jne    43896 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   4382e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43835:	8b 00                	mov    (%rax),%eax
   43837:	83 f8 2f             	cmp    $0x2f,%eax
   4383a:	77 30                	ja     4386c <printer_vprintf+0x2b2>
   4383c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43843:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43847:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4384e:	8b 00                	mov    (%rax),%eax
   43850:	89 c0                	mov    %eax,%eax
   43852:	48 01 d0             	add    %rdx,%rax
   43855:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4385c:	8b 12                	mov    (%rdx),%edx
   4385e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43861:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43868:	89 0a                	mov    %ecx,(%rdx)
   4386a:	eb 1a                	jmp    43886 <printer_vprintf+0x2cc>
   4386c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43873:	48 8b 40 08          	mov    0x8(%rax),%rax
   43877:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4387b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43882:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43886:	8b 00                	mov    (%rax),%eax
   43888:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   4388b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43892:	01 
   43893:	eb 01                	jmp    43896 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   43895:	90                   	nop
            }
            if (precision < 0) {
   43896:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4389a:	79 07                	jns    438a3 <printer_vprintf+0x2e9>
                precision = 0;
   4389c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   438a3:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   438aa:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   438b1:	00 
        int length = 0;
   438b2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   438b9:	48 8d 05 86 14 00 00 	lea    0x1486(%rip),%rax        # 44d46 <flag_chars+0x6>
   438c0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   438c4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   438cb:	0f b6 00             	movzbl (%rax),%eax
   438ce:	0f be c0             	movsbl %al,%eax
   438d1:	83 e8 43             	sub    $0x43,%eax
   438d4:	83 f8 37             	cmp    $0x37,%eax
   438d7:	0f 87 b6 03 00 00    	ja     43c93 <printer_vprintf+0x6d9>
   438dd:	89 c0                	mov    %eax,%eax
   438df:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   438e6:	00 
   438e7:	48 8d 05 66 14 00 00 	lea    0x1466(%rip),%rax        # 44d54 <flag_chars+0x14>
   438ee:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   438f1:	48 98                	cltq   
   438f3:	48 8d 15 5a 14 00 00 	lea    0x145a(%rip),%rdx        # 44d54 <flag_chars+0x14>
   438fa:	48 01 d0             	add    %rdx,%rax
   438fd:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   43900:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43907:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4390e:	01 
            goto again;
   4390f:	eb b3                	jmp    438c4 <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43911:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43915:	74 5d                	je     43974 <printer_vprintf+0x3ba>
   43917:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4391e:	8b 00                	mov    (%rax),%eax
   43920:	83 f8 2f             	cmp    $0x2f,%eax
   43923:	77 30                	ja     43955 <printer_vprintf+0x39b>
   43925:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4392c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43930:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43937:	8b 00                	mov    (%rax),%eax
   43939:	89 c0                	mov    %eax,%eax
   4393b:	48 01 d0             	add    %rdx,%rax
   4393e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43945:	8b 12                	mov    (%rdx),%edx
   43947:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4394a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43951:	89 0a                	mov    %ecx,(%rdx)
   43953:	eb 1a                	jmp    4396f <printer_vprintf+0x3b5>
   43955:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4395c:	48 8b 40 08          	mov    0x8(%rax),%rax
   43960:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43964:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4396b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4396f:	48 8b 00             	mov    (%rax),%rax
   43972:	eb 5c                	jmp    439d0 <printer_vprintf+0x416>
   43974:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4397b:	8b 00                	mov    (%rax),%eax
   4397d:	83 f8 2f             	cmp    $0x2f,%eax
   43980:	77 30                	ja     439b2 <printer_vprintf+0x3f8>
   43982:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43989:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4398d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43994:	8b 00                	mov    (%rax),%eax
   43996:	89 c0                	mov    %eax,%eax
   43998:	48 01 d0             	add    %rdx,%rax
   4399b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439a2:	8b 12                	mov    (%rdx),%edx
   439a4:	8d 4a 08             	lea    0x8(%rdx),%ecx
   439a7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439ae:	89 0a                	mov    %ecx,(%rdx)
   439b0:	eb 1a                	jmp    439cc <printer_vprintf+0x412>
   439b2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439b9:	48 8b 40 08          	mov    0x8(%rax),%rax
   439bd:	48 8d 48 08          	lea    0x8(%rax),%rcx
   439c1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439c8:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   439cc:	8b 00                	mov    (%rax),%eax
   439ce:	48 98                	cltq   
   439d0:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   439d4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   439d8:	48 c1 f8 38          	sar    $0x38,%rax
   439dc:	25 80 00 00 00       	and    $0x80,%eax
   439e1:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   439e4:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   439e8:	74 09                	je     439f3 <printer_vprintf+0x439>
   439ea:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   439ee:	48 f7 d8             	neg    %rax
   439f1:	eb 04                	jmp    439f7 <printer_vprintf+0x43d>
   439f3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   439f7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   439fb:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   439fe:	83 c8 60             	or     $0x60,%eax
   43a01:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43a04:	e9 cf 02 00 00       	jmp    43cd8 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43a09:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43a0d:	74 5d                	je     43a6c <printer_vprintf+0x4b2>
   43a0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a16:	8b 00                	mov    (%rax),%eax
   43a18:	83 f8 2f             	cmp    $0x2f,%eax
   43a1b:	77 30                	ja     43a4d <printer_vprintf+0x493>
   43a1d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a24:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43a28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a2f:	8b 00                	mov    (%rax),%eax
   43a31:	89 c0                	mov    %eax,%eax
   43a33:	48 01 d0             	add    %rdx,%rax
   43a36:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a3d:	8b 12                	mov    (%rdx),%edx
   43a3f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a42:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a49:	89 0a                	mov    %ecx,(%rdx)
   43a4b:	eb 1a                	jmp    43a67 <printer_vprintf+0x4ad>
   43a4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a54:	48 8b 40 08          	mov    0x8(%rax),%rax
   43a58:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43a5c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a63:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43a67:	48 8b 00             	mov    (%rax),%rax
   43a6a:	eb 5c                	jmp    43ac8 <printer_vprintf+0x50e>
   43a6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a73:	8b 00                	mov    (%rax),%eax
   43a75:	83 f8 2f             	cmp    $0x2f,%eax
   43a78:	77 30                	ja     43aaa <printer_vprintf+0x4f0>
   43a7a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a81:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43a85:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a8c:	8b 00                	mov    (%rax),%eax
   43a8e:	89 c0                	mov    %eax,%eax
   43a90:	48 01 d0             	add    %rdx,%rax
   43a93:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a9a:	8b 12                	mov    (%rdx),%edx
   43a9c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a9f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43aa6:	89 0a                	mov    %ecx,(%rdx)
   43aa8:	eb 1a                	jmp    43ac4 <printer_vprintf+0x50a>
   43aaa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ab1:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ab5:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43ab9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ac0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ac4:	8b 00                	mov    (%rax),%eax
   43ac6:	89 c0                	mov    %eax,%eax
   43ac8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43acc:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43ad0:	e9 03 02 00 00       	jmp    43cd8 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   43ad5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43adc:	e9 28 ff ff ff       	jmp    43a09 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   43ae1:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43ae8:	e9 1c ff ff ff       	jmp    43a09 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43aed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43af4:	8b 00                	mov    (%rax),%eax
   43af6:	83 f8 2f             	cmp    $0x2f,%eax
   43af9:	77 30                	ja     43b2b <printer_vprintf+0x571>
   43afb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b02:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b06:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b0d:	8b 00                	mov    (%rax),%eax
   43b0f:	89 c0                	mov    %eax,%eax
   43b11:	48 01 d0             	add    %rdx,%rax
   43b14:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b1b:	8b 12                	mov    (%rdx),%edx
   43b1d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b20:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b27:	89 0a                	mov    %ecx,(%rdx)
   43b29:	eb 1a                	jmp    43b45 <printer_vprintf+0x58b>
   43b2b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b32:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b36:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b3a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b41:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b45:	48 8b 00             	mov    (%rax),%rax
   43b48:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43b4c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43b53:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43b5a:	e9 79 01 00 00       	jmp    43cd8 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   43b5f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b66:	8b 00                	mov    (%rax),%eax
   43b68:	83 f8 2f             	cmp    $0x2f,%eax
   43b6b:	77 30                	ja     43b9d <printer_vprintf+0x5e3>
   43b6d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b74:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b78:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b7f:	8b 00                	mov    (%rax),%eax
   43b81:	89 c0                	mov    %eax,%eax
   43b83:	48 01 d0             	add    %rdx,%rax
   43b86:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b8d:	8b 12                	mov    (%rdx),%edx
   43b8f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b92:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b99:	89 0a                	mov    %ecx,(%rdx)
   43b9b:	eb 1a                	jmp    43bb7 <printer_vprintf+0x5fd>
   43b9d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ba4:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ba8:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43bac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bb3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43bb7:	48 8b 00             	mov    (%rax),%rax
   43bba:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43bbe:	e9 15 01 00 00       	jmp    43cd8 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   43bc3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bca:	8b 00                	mov    (%rax),%eax
   43bcc:	83 f8 2f             	cmp    $0x2f,%eax
   43bcf:	77 30                	ja     43c01 <printer_vprintf+0x647>
   43bd1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bd8:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43bdc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43be3:	8b 00                	mov    (%rax),%eax
   43be5:	89 c0                	mov    %eax,%eax
   43be7:	48 01 d0             	add    %rdx,%rax
   43bea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bf1:	8b 12                	mov    (%rdx),%edx
   43bf3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43bf6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bfd:	89 0a                	mov    %ecx,(%rdx)
   43bff:	eb 1a                	jmp    43c1b <printer_vprintf+0x661>
   43c01:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c08:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c0c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c10:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c17:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c1b:	8b 00                	mov    (%rax),%eax
   43c1d:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43c23:	e9 77 03 00 00       	jmp    43f9f <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   43c28:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43c2c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43c30:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c37:	8b 00                	mov    (%rax),%eax
   43c39:	83 f8 2f             	cmp    $0x2f,%eax
   43c3c:	77 30                	ja     43c6e <printer_vprintf+0x6b4>
   43c3e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c45:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c50:	8b 00                	mov    (%rax),%eax
   43c52:	89 c0                	mov    %eax,%eax
   43c54:	48 01 d0             	add    %rdx,%rax
   43c57:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c5e:	8b 12                	mov    (%rdx),%edx
   43c60:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c63:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c6a:	89 0a                	mov    %ecx,(%rdx)
   43c6c:	eb 1a                	jmp    43c88 <printer_vprintf+0x6ce>
   43c6e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c75:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c79:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c7d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c84:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c88:	8b 00                	mov    (%rax),%eax
   43c8a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43c8d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43c91:	eb 45                	jmp    43cd8 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   43c93:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43c97:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43c9b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ca2:	0f b6 00             	movzbl (%rax),%eax
   43ca5:	84 c0                	test   %al,%al
   43ca7:	74 0c                	je     43cb5 <printer_vprintf+0x6fb>
   43ca9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cb0:	0f b6 00             	movzbl (%rax),%eax
   43cb3:	eb 05                	jmp    43cba <printer_vprintf+0x700>
   43cb5:	b8 25 00 00 00       	mov    $0x25,%eax
   43cba:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43cbd:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43cc1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cc8:	0f b6 00             	movzbl (%rax),%eax
   43ccb:	84 c0                	test   %al,%al
   43ccd:	75 08                	jne    43cd7 <printer_vprintf+0x71d>
                format--;
   43ccf:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43cd6:	01 
            }
            break;
   43cd7:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43cd8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43cdb:	83 e0 20             	and    $0x20,%eax
   43cde:	85 c0                	test   %eax,%eax
   43ce0:	74 1e                	je     43d00 <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43ce2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43ce6:	48 83 c0 18          	add    $0x18,%rax
   43cea:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43ced:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43cf1:	48 89 ce             	mov    %rcx,%rsi
   43cf4:	48 89 c7             	mov    %rax,%rdi
   43cf7:	e8 32 f8 ff ff       	call   4352e <fill_numbuf>
   43cfc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43d00:	48 8d 05 3f 10 00 00 	lea    0x103f(%rip),%rax        # 44d46 <flag_chars+0x6>
   43d07:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43d0b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d0e:	83 e0 20             	and    $0x20,%eax
   43d11:	85 c0                	test   %eax,%eax
   43d13:	74 51                	je     43d66 <printer_vprintf+0x7ac>
   43d15:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d18:	83 e0 40             	and    $0x40,%eax
   43d1b:	85 c0                	test   %eax,%eax
   43d1d:	74 47                	je     43d66 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   43d1f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d22:	25 80 00 00 00       	and    $0x80,%eax
   43d27:	85 c0                	test   %eax,%eax
   43d29:	74 0d                	je     43d38 <printer_vprintf+0x77e>
                prefix = "-";
   43d2b:	48 8d 05 15 10 00 00 	lea    0x1015(%rip),%rax        # 44d47 <flag_chars+0x7>
   43d32:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   43d36:	eb 7d                	jmp    43db5 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43d38:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d3b:	83 e0 10             	and    $0x10,%eax
   43d3e:	85 c0                	test   %eax,%eax
   43d40:	74 0d                	je     43d4f <printer_vprintf+0x795>
                prefix = "+";
   43d42:	48 8d 05 00 10 00 00 	lea    0x1000(%rip),%rax        # 44d49 <flag_chars+0x9>
   43d49:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   43d4d:	eb 66                	jmp    43db5 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   43d4f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d52:	83 e0 08             	and    $0x8,%eax
   43d55:	85 c0                	test   %eax,%eax
   43d57:	74 5c                	je     43db5 <printer_vprintf+0x7fb>
                prefix = " ";
   43d59:	48 8d 05 eb 0f 00 00 	lea    0xfeb(%rip),%rax        # 44d4b <flag_chars+0xb>
   43d60:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   43d64:	eb 4f                	jmp    43db5 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43d66:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d69:	83 e0 20             	and    $0x20,%eax
   43d6c:	85 c0                	test   %eax,%eax
   43d6e:	74 46                	je     43db6 <printer_vprintf+0x7fc>
   43d70:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d73:	83 e0 01             	and    $0x1,%eax
   43d76:	85 c0                	test   %eax,%eax
   43d78:	74 3c                	je     43db6 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   43d7a:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   43d7e:	74 06                	je     43d86 <printer_vprintf+0x7cc>
   43d80:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43d84:	75 30                	jne    43db6 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   43d86:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43d8b:	75 0c                	jne    43d99 <printer_vprintf+0x7df>
   43d8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d90:	25 00 01 00 00       	and    $0x100,%eax
   43d95:	85 c0                	test   %eax,%eax
   43d97:	74 1d                	je     43db6 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   43d99:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43d9d:	75 09                	jne    43da8 <printer_vprintf+0x7ee>
   43d9f:	48 8d 05 a7 0f 00 00 	lea    0xfa7(%rip),%rax        # 44d4d <flag_chars+0xd>
   43da6:	eb 07                	jmp    43daf <printer_vprintf+0x7f5>
   43da8:	48 8d 05 a1 0f 00 00 	lea    0xfa1(%rip),%rax        # 44d50 <flag_chars+0x10>
   43daf:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43db3:	eb 01                	jmp    43db6 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   43db5:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43db6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43dba:	78 24                	js     43de0 <printer_vprintf+0x826>
   43dbc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43dbf:	83 e0 20             	and    $0x20,%eax
   43dc2:	85 c0                	test   %eax,%eax
   43dc4:	75 1a                	jne    43de0 <printer_vprintf+0x826>
            len = strnlen(data, precision);
   43dc6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43dc9:	48 63 d0             	movslq %eax,%rdx
   43dcc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43dd0:	48 89 d6             	mov    %rdx,%rsi
   43dd3:	48 89 c7             	mov    %rax,%rdi
   43dd6:	e8 91 f5 ff ff       	call   4336c <strnlen>
   43ddb:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43dde:	eb 0f                	jmp    43def <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   43de0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43de4:	48 89 c7             	mov    %rax,%rdi
   43de7:	e8 4b f5 ff ff       	call   43337 <strlen>
   43dec:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43def:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43df2:	83 e0 20             	and    $0x20,%eax
   43df5:	85 c0                	test   %eax,%eax
   43df7:	74 20                	je     43e19 <printer_vprintf+0x85f>
   43df9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43dfd:	78 1a                	js     43e19 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   43dff:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43e02:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   43e05:	7e 08                	jle    43e0f <printer_vprintf+0x855>
   43e07:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43e0a:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43e0d:	eb 05                	jmp    43e14 <printer_vprintf+0x85a>
   43e0f:	b8 00 00 00 00       	mov    $0x0,%eax
   43e14:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43e17:	eb 5c                	jmp    43e75 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43e19:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e1c:	83 e0 20             	and    $0x20,%eax
   43e1f:	85 c0                	test   %eax,%eax
   43e21:	74 4b                	je     43e6e <printer_vprintf+0x8b4>
   43e23:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e26:	83 e0 02             	and    $0x2,%eax
   43e29:	85 c0                	test   %eax,%eax
   43e2b:	74 41                	je     43e6e <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   43e2d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e30:	83 e0 04             	and    $0x4,%eax
   43e33:	85 c0                	test   %eax,%eax
   43e35:	75 37                	jne    43e6e <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   43e37:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43e3b:	48 89 c7             	mov    %rax,%rdi
   43e3e:	e8 f4 f4 ff ff       	call   43337 <strlen>
   43e43:	89 c2                	mov    %eax,%edx
   43e45:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43e48:	01 d0                	add    %edx,%eax
   43e4a:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   43e4d:	7e 1f                	jle    43e6e <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   43e4f:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43e52:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43e55:	89 c3                	mov    %eax,%ebx
   43e57:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43e5b:	48 89 c7             	mov    %rax,%rdi
   43e5e:	e8 d4 f4 ff ff       	call   43337 <strlen>
   43e63:	89 c2                	mov    %eax,%edx
   43e65:	89 d8                	mov    %ebx,%eax
   43e67:	29 d0                	sub    %edx,%eax
   43e69:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43e6c:	eb 07                	jmp    43e75 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   43e6e:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   43e75:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43e78:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43e7b:	01 d0                	add    %edx,%eax
   43e7d:	48 63 d8             	movslq %eax,%rbx
   43e80:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43e84:	48 89 c7             	mov    %rax,%rdi
   43e87:	e8 ab f4 ff ff       	call   43337 <strlen>
   43e8c:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   43e90:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43e93:	29 d0                	sub    %edx,%eax
   43e95:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43e98:	eb 25                	jmp    43ebf <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   43e9a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ea1:	48 8b 08             	mov    (%rax),%rcx
   43ea4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43eaa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43eb1:	be 20 00 00 00       	mov    $0x20,%esi
   43eb6:	48 89 c7             	mov    %rax,%rdi
   43eb9:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43ebb:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43ebf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ec2:	83 e0 04             	and    $0x4,%eax
   43ec5:	85 c0                	test   %eax,%eax
   43ec7:	75 36                	jne    43eff <printer_vprintf+0x945>
   43ec9:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43ecd:	7f cb                	jg     43e9a <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   43ecf:	eb 2e                	jmp    43eff <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   43ed1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ed8:	4c 8b 00             	mov    (%rax),%r8
   43edb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43edf:	0f b6 00             	movzbl (%rax),%eax
   43ee2:	0f b6 c8             	movzbl %al,%ecx
   43ee5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43eeb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ef2:	89 ce                	mov    %ecx,%esi
   43ef4:	48 89 c7             	mov    %rax,%rdi
   43ef7:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   43efa:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   43eff:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43f03:	0f b6 00             	movzbl (%rax),%eax
   43f06:	84 c0                	test   %al,%al
   43f08:	75 c7                	jne    43ed1 <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   43f0a:	eb 25                	jmp    43f31 <printer_vprintf+0x977>
            p->putc(p, '0', color);
   43f0c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f13:	48 8b 08             	mov    (%rax),%rcx
   43f16:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f1c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f23:	be 30 00 00 00       	mov    $0x30,%esi
   43f28:	48 89 c7             	mov    %rax,%rdi
   43f2b:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   43f2d:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   43f31:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   43f35:	7f d5                	jg     43f0c <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   43f37:	eb 32                	jmp    43f6b <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   43f39:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f40:	4c 8b 00             	mov    (%rax),%r8
   43f43:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43f47:	0f b6 00             	movzbl (%rax),%eax
   43f4a:	0f b6 c8             	movzbl %al,%ecx
   43f4d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f53:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f5a:	89 ce                	mov    %ecx,%esi
   43f5c:	48 89 c7             	mov    %rax,%rdi
   43f5f:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   43f62:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   43f67:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   43f6b:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43f6f:	7f c8                	jg     43f39 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   43f71:	eb 25                	jmp    43f98 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   43f73:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f7a:	48 8b 08             	mov    (%rax),%rcx
   43f7d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f83:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f8a:	be 20 00 00 00       	mov    $0x20,%esi
   43f8f:	48 89 c7             	mov    %rax,%rdi
   43f92:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   43f94:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43f98:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43f9c:	7f d5                	jg     43f73 <printer_vprintf+0x9b9>
        }
    done: ;
   43f9e:	90                   	nop
    for (; *format; ++format) {
   43f9f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fa6:	01 
   43fa7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fae:	0f b6 00             	movzbl (%rax),%eax
   43fb1:	84 c0                	test   %al,%al
   43fb3:	0f 85 31 f6 ff ff    	jne    435ea <printer_vprintf+0x30>
    }
}
   43fb9:	90                   	nop
   43fba:	90                   	nop
   43fbb:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43fbf:	c9                   	leave  
   43fc0:	c3                   	ret    

0000000000043fc1 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   43fc1:	f3 0f 1e fa          	endbr64 
   43fc5:	55                   	push   %rbp
   43fc6:	48 89 e5             	mov    %rsp,%rbp
   43fc9:	48 83 ec 20          	sub    $0x20,%rsp
   43fcd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43fd1:	89 f0                	mov    %esi,%eax
   43fd3:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43fd6:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   43fd9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43fdd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43fe1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fe5:	48 8b 40 08          	mov    0x8(%rax),%rax
   43fe9:	48 8d 15 b0 4f 07 00 	lea    0x74fb0(%rip),%rdx        # b8fa0 <console+0xfa0>
   43ff0:	48 39 d0             	cmp    %rdx,%rax
   43ff3:	72 0f                	jb     44004 <console_putc+0x43>
        cp->cursor = console;
   43ff5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ff9:	48 8d 15 00 40 07 00 	lea    0x74000(%rip),%rdx        # b8000 <console>
   44000:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   44004:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44008:	0f 85 82 00 00 00    	jne    44090 <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   4400e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44012:	48 8b 40 08          	mov    0x8(%rax),%rax
   44016:	48 8d 15 e3 3f 07 00 	lea    0x73fe3(%rip),%rdx        # b8000 <console>
   4401d:	48 29 d0             	sub    %rdx,%rax
   44020:	48 d1 f8             	sar    %rax
   44023:	48 89 c1             	mov    %rax,%rcx
   44026:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   4402d:	66 66 66 
   44030:	48 89 c8             	mov    %rcx,%rax
   44033:	48 f7 ea             	imul   %rdx
   44036:	48 89 d0             	mov    %rdx,%rax
   44039:	48 c1 f8 05          	sar    $0x5,%rax
   4403d:	48 89 ce             	mov    %rcx,%rsi
   44040:	48 c1 fe 3f          	sar    $0x3f,%rsi
   44044:	48 29 f0             	sub    %rsi,%rax
   44047:	48 89 c2             	mov    %rax,%rdx
   4404a:	48 89 d0             	mov    %rdx,%rax
   4404d:	48 c1 e0 02          	shl    $0x2,%rax
   44051:	48 01 d0             	add    %rdx,%rax
   44054:	48 c1 e0 04          	shl    $0x4,%rax
   44058:	48 29 c1             	sub    %rax,%rcx
   4405b:	48 89 ca             	mov    %rcx,%rdx
   4405e:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44061:	eb 25                	jmp    44088 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   44063:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44066:	83 c8 20             	or     $0x20,%eax
   44069:	89 c6                	mov    %eax,%esi
   4406b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4406f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44073:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44077:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4407b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4407f:	89 f2                	mov    %esi,%edx
   44081:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44084:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44088:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   4408c:	75 d5                	jne    44063 <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   4408e:	eb 24                	jmp    440b4 <console_putc+0xf3>
        *cp->cursor++ = c | color;
   44090:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44094:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44097:	89 d6                	mov    %edx,%esi
   44099:	09 c6                	or     %eax,%esi
   4409b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4409f:	48 8b 40 08          	mov    0x8(%rax),%rax
   440a3:	48 8d 48 02          	lea    0x2(%rax),%rcx
   440a7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   440ab:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440af:	89 f2                	mov    %esi,%edx
   440b1:	66 89 10             	mov    %dx,(%rax)
}
   440b4:	90                   	nop
   440b5:	c9                   	leave  
   440b6:	c3                   	ret    

00000000000440b7 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   440b7:	f3 0f 1e fa          	endbr64 
   440bb:	55                   	push   %rbp
   440bc:	48 89 e5             	mov    %rsp,%rbp
   440bf:	48 83 ec 30          	sub    $0x30,%rsp
   440c3:	89 7d ec             	mov    %edi,-0x14(%rbp)
   440c6:	89 75 e8             	mov    %esi,-0x18(%rbp)
   440c9:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   440cd:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   440d1:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 43fc1 <console_putc>
   440d8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   440dc:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   440e0:	78 09                	js     440eb <console_vprintf+0x34>
   440e2:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   440e9:	7e 07                	jle    440f2 <console_vprintf+0x3b>
        cpos = 0;
   440eb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   440f2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440f5:	48 98                	cltq   
   440f7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   440fb:	48 8d 05 fe 3e 07 00 	lea    0x73efe(%rip),%rax        # b8000 <console>
   44102:	48 01 d0             	add    %rdx,%rax
   44105:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44109:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4410d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44111:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44114:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44118:	48 89 c7             	mov    %rax,%rdi
   4411b:	e8 9a f4 ff ff       	call   435ba <printer_vprintf>
    return cp.cursor - console;
   44120:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44124:	48 8d 15 d5 3e 07 00 	lea    0x73ed5(%rip),%rdx        # b8000 <console>
   4412b:	48 29 d0             	sub    %rdx,%rax
   4412e:	48 d1 f8             	sar    %rax
}
   44131:	c9                   	leave  
   44132:	c3                   	ret    

0000000000044133 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44133:	f3 0f 1e fa          	endbr64 
   44137:	55                   	push   %rbp
   44138:	48 89 e5             	mov    %rsp,%rbp
   4413b:	48 83 ec 60          	sub    $0x60,%rsp
   4413f:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44142:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44145:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44149:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4414d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44151:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44155:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4415c:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44160:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44164:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44168:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   4416c:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44170:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44174:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44177:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4417a:	89 c7                	mov    %eax,%edi
   4417c:	e8 36 ff ff ff       	call   440b7 <console_vprintf>
   44181:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44184:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44187:	c9                   	leave  
   44188:	c3                   	ret    

0000000000044189 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44189:	f3 0f 1e fa          	endbr64 
   4418d:	55                   	push   %rbp
   4418e:	48 89 e5             	mov    %rsp,%rbp
   44191:	48 83 ec 20          	sub    $0x20,%rsp
   44195:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44199:	89 f0                	mov    %esi,%eax
   4419b:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4419e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   441a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   441a5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   441a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441ad:	48 8b 50 08          	mov    0x8(%rax),%rdx
   441b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441b5:	48 8b 40 10          	mov    0x10(%rax),%rax
   441b9:	48 39 c2             	cmp    %rax,%rdx
   441bc:	73 1a                	jae    441d8 <string_putc+0x4f>
        *sp->s++ = c;
   441be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441c2:	48 8b 40 08          	mov    0x8(%rax),%rax
   441c6:	48 8d 48 01          	lea    0x1(%rax),%rcx
   441ca:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   441ce:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441d2:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   441d6:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   441d8:	90                   	nop
   441d9:	c9                   	leave  
   441da:	c3                   	ret    

00000000000441db <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   441db:	f3 0f 1e fa          	endbr64 
   441df:	55                   	push   %rbp
   441e0:	48 89 e5             	mov    %rsp,%rbp
   441e3:	48 83 ec 40          	sub    $0x40,%rsp
   441e7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   441eb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   441ef:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   441f3:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   441f7:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 44189 <string_putc>
   441fe:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   44202:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44206:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   4420a:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   4420f:	74 33                	je     44244 <vsnprintf+0x69>
        sp.end = s + size - 1;
   44211:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44215:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44219:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4421d:	48 01 d0             	add    %rdx,%rax
   44220:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44224:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44228:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4422c:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44230:	be 00 00 00 00       	mov    $0x0,%esi
   44235:	48 89 c7             	mov    %rax,%rdi
   44238:	e8 7d f3 ff ff       	call   435ba <printer_vprintf>
        *sp.s = 0;
   4423d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44241:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44244:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44248:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   4424c:	c9                   	leave  
   4424d:	c3                   	ret    

000000000004424e <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   4424e:	f3 0f 1e fa          	endbr64 
   44252:	55                   	push   %rbp
   44253:	48 89 e5             	mov    %rsp,%rbp
   44256:	48 83 ec 70          	sub    $0x70,%rsp
   4425a:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4425e:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44262:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44266:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4426a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4426e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44272:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44279:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4427d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44281:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44285:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44289:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4428d:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44291:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44295:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44299:	48 89 c7             	mov    %rax,%rdi
   4429c:	e8 3a ff ff ff       	call   441db <vsnprintf>
   442a1:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   442a4:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   442a7:	c9                   	leave  
   442a8:	c3                   	ret    

00000000000442a9 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   442a9:	f3 0f 1e fa          	endbr64 
   442ad:	55                   	push   %rbp
   442ae:	48 89 e5             	mov    %rsp,%rbp
   442b1:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   442b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   442bc:	eb 1a                	jmp    442d8 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   442be:	8b 45 fc             	mov    -0x4(%rbp),%eax
   442c1:	48 98                	cltq   
   442c3:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   442c7:	48 8d 05 32 3d 07 00 	lea    0x73d32(%rip),%rax        # b8000 <console>
   442ce:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   442d4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   442d8:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   442df:	7e dd                	jle    442be <console_clear+0x15>
    }
    cursorpos = 0;
   442e1:	c7 05 11 4d 07 00 00 	movl   $0x0,0x74d11(%rip)        # b8ffc <cursorpos>
   442e8:	00 00 00 
}
   442eb:	90                   	nop
   442ec:	c9                   	leave  
   442ed:	c3                   	ret    
