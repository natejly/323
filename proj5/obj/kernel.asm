
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
   400be:	e8 97 0d 00 00       	call   40e5a <exception>

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
   40177:	e8 2c 1d 00 00       	call   41ea8 <hardware_init>
    pageinfo_init();
   4017c:	e8 2c 12 00 00       	call   413ad <pageinfo_init>
    console_clear();
   40181:	e8 7e 4a 00 00       	call   44c04 <console_clear>
    timer_init(HZ);
   40186:	bf 64 00 00 00       	mov    $0x64,%edi
   4018b:	e8 80 22 00 00       	call   42410 <timer_init>
    virtual_memory_map(kernel_pagetable, 0, 0,
   40190:	48 8b 05 69 4e 01 00 	mov    0x14e69(%rip),%rax        # 55000 <kernel_pagetable>
   40197:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   4019d:	b9 00 00 10 00       	mov    $0x100000,%ecx
   401a2:	ba 00 00 00 00       	mov    $0x0,%edx
   401a7:	be 00 00 00 00       	mov    $0x0,%esi
   401ac:	48 89 c7             	mov    %rax,%rdi
   401af:	e8 c9 30 00 00       	call   4327d <virtual_memory_map>
                   PROC_START_ADDR, PTE_P | PTE_W); 

    virtual_memory_map(kernel_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   401b4:	48 8d 15 45 7e 07 00 	lea    0x77e45(%rip),%rdx        # b8000 <console>
   401bb:	48 8d 35 3e 7e 07 00 	lea    0x77e3e(%rip),%rsi        # b8000 <console>
   401c2:	48 8b 05 37 4e 01 00 	mov    0x14e37(%rip),%rax        # 55000 <kernel_pagetable>
   401c9:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401cf:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401d4:	48 89 c7             	mov    %rax,%rdi
   401d7:	e8 a1 30 00 00       	call   4327d <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401dc:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401e1:	be 00 00 00 00       	mov    $0x0,%esi
   401e6:	48 8d 05 33 1e 01 00 	lea    0x11e33(%rip),%rax        # 52020 <processes>
   401ed:	48 89 c7             	mov    %rax,%rdi
   401f0:	e8 5a 3a 00 00       	call   43c4f <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401fc:	eb 4d                	jmp    4024b <kernel+0xe4>
        processes[i].p_pid = i;
   401fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40201:	48 63 d0             	movslq %eax,%rdx
   40204:	48 89 d0             	mov    %rdx,%rax
   40207:	48 c1 e0 03          	shl    $0x3,%rax
   4020b:	48 29 d0             	sub    %rdx,%rax
   4020e:	48 c1 e0 05          	shl    $0x5,%rax
   40212:	48 89 c1             	mov    %rax,%rcx
   40215:	48 8d 15 04 1e 01 00 	lea    0x11e04(%rip),%rdx        # 52020 <processes>
   4021c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4021f:	89 04 11             	mov    %eax,(%rcx,%rdx,1)
        processes[i].p_state = P_FREE;
   40222:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40225:	48 63 d0             	movslq %eax,%rdx
   40228:	48 89 d0             	mov    %rdx,%rax
   4022b:	48 c1 e0 03          	shl    $0x3,%rax
   4022f:	48 29 d0             	sub    %rdx,%rax
   40232:	48 c1 e0 05          	shl    $0x5,%rax
   40236:	48 89 c2             	mov    %rax,%rdx
   40239:	48 8d 05 a8 1e 01 00 	lea    0x11ea8(%rip),%rax        # 520e8 <processes+0xc8>
   40240:	c7 04 02 00 00 00 00 	movl   $0x0,(%rdx,%rax,1)
    for (pid_t i = 0; i < NPROC; i++) {
   40247:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4024b:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4024f:	7e ad                	jle    401fe <kernel+0x97>
    }
            
    if (command && strcmp(command, "fork") == 0) {
   40251:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40256:	74 2e                	je     40286 <kernel+0x11f>
   40258:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025c:	48 8d 15 fd 49 00 00 	lea    0x49fd(%rip),%rdx        # 44c60 <console_clear+0x5c>
   40263:	48 89 d6             	mov    %rdx,%rsi
   40266:	48 89 c7             	mov    %rax,%rdi
   40269:	e8 ea 3a 00 00       	call   43d58 <strcmp>
   4026e:	85 c0                	test   %eax,%eax
   40270:	75 14                	jne    40286 <kernel+0x11f>
        process_setup(1, 4);
   40272:	be 04 00 00 00       	mov    $0x4,%esi
   40277:	bf 01 00 00 00       	mov    $0x1,%edi
   4027c:	e8 c4 03 00 00       	call   40645 <process_setup>
   40281:	e9 d1 00 00 00       	jmp    40357 <kernel+0x1f0>
    } else if (command && strcmp(command, "forkexit") == 0) {
   40286:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4028b:	74 2e                	je     402bb <kernel+0x154>
   4028d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40291:	48 8d 15 cd 49 00 00 	lea    0x49cd(%rip),%rdx        # 44c65 <console_clear+0x61>
   40298:	48 89 d6             	mov    %rdx,%rsi
   4029b:	48 89 c7             	mov    %rax,%rdi
   4029e:	e8 b5 3a 00 00       	call   43d58 <strcmp>
   402a3:	85 c0                	test   %eax,%eax
   402a5:	75 14                	jne    402bb <kernel+0x154>
        process_setup(1, 5);
   402a7:	be 05 00 00 00       	mov    $0x5,%esi
   402ac:	bf 01 00 00 00       	mov    $0x1,%edi
   402b1:	e8 8f 03 00 00       	call   40645 <process_setup>
   402b6:	e9 9c 00 00 00       	jmp    40357 <kernel+0x1f0>
    } else if (command && strcmp(command, "test") == 0) {
   402bb:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402c0:	74 2b                	je     402ed <kernel+0x186>
   402c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402c6:	48 8d 15 a1 49 00 00 	lea    0x49a1(%rip),%rdx        # 44c6e <console_clear+0x6a>
   402cd:	48 89 d6             	mov    %rdx,%rsi
   402d0:	48 89 c7             	mov    %rax,%rdi
   402d3:	e8 80 3a 00 00       	call   43d58 <strcmp>
   402d8:	85 c0                	test   %eax,%eax
   402da:	75 11                	jne    402ed <kernel+0x186>
        process_setup(1, 6);
   402dc:	be 06 00 00 00       	mov    $0x6,%esi
   402e1:	bf 01 00 00 00       	mov    $0x1,%edi
   402e6:	e8 5a 03 00 00       	call   40645 <process_setup>
   402eb:	eb 6a                	jmp    40357 <kernel+0x1f0>
    } else if (command && strcmp(command, "test2") == 0) {
   402ed:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402f2:	74 3e                	je     40332 <kernel+0x1cb>
   402f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402f8:	48 8d 15 74 49 00 00 	lea    0x4974(%rip),%rdx        # 44c73 <console_clear+0x6f>
   402ff:	48 89 d6             	mov    %rdx,%rsi
   40302:	48 89 c7             	mov    %rax,%rdi
   40305:	e8 4e 3a 00 00       	call   43d58 <strcmp>
   4030a:	85 c0                	test   %eax,%eax
   4030c:	75 24                	jne    40332 <kernel+0x1cb>
        for (pid_t i = 1; i <= 2; ++i) {
   4030e:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   40315:	eb 13                	jmp    4032a <kernel+0x1c3>
            process_setup(i, 6);
   40317:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4031a:	be 06 00 00 00       	mov    $0x6,%esi
   4031f:	89 c7                	mov    %eax,%edi
   40321:	e8 1f 03 00 00       	call   40645 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   40326:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4032a:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   4032e:	7e e7                	jle    40317 <kernel+0x1b0>
   40330:	eb 25                	jmp    40357 <kernel+0x1f0>
        }
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
   40332:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
   40339:	eb 16                	jmp    40351 <kernel+0x1ea>
            process_setup(i, i - 1);
   4033b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4033e:	8d 50 ff             	lea    -0x1(%rax),%edx
   40341:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40344:	89 d6                	mov    %edx,%esi
   40346:	89 c7                	mov    %eax,%edi
   40348:	e8 f8 02 00 00       	call   40645 <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   4034d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40351:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   40355:	7e e4                	jle    4033b <kernel+0x1d4>
        }
    }

    // Switch to the first process using run()
    run(&processes[1]);
   40357:	48 8d 05 a2 1d 01 00 	lea    0x11da2(%rip),%rax        # 52100 <processes+0xe0>
   4035e:	48 89 c7             	mov    %rax,%rdi
   40361:	e8 dc 0f 00 00       	call   41342 <run>

0000000000040366 <reserve_page>:
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

// helper function for reserving pages which returns return its page address
x86_64_pagetable* reserve_page(int8_t owner);
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
   403e0:	e8 6a 38 00 00       	call   43c4f <memset>
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
uintptr_t find_page(int8_t owner);
uintptr_t find_page(int8_t owner) {
   40404:	f3 0f 1e fa          	endbr64 
   40408:	55                   	push   %rbp
   40409:	48 89 e5             	mov    %rsp,%rbp
   4040c:	48 83 ec 20          	sub    $0x20,%rsp
   40410:	89 f8                	mov    %edi,%eax
   40412:	88 45 ec             	mov    %al,-0x14(%rbp)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40415:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4041c:	00 
   4041d:	eb 43                	jmp    40462 <find_page+0x5e>
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
   40440:	75 18                	jne    4045a <find_page+0x56>
            assign_physical_page(addr, owner);
   40442:	0f be 55 ec          	movsbl -0x14(%rbp),%edx
   40446:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4044a:	89 d6                	mov    %edx,%esi
   4044c:	48 89 c7             	mov    %rax,%rdi
   4044f:	e8 b6 03 00 00       	call   4080a <assign_physical_page>
            return addr; 
   40454:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40458:	eb 17                	jmp    40471 <find_page+0x6d>
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4045a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40461:	00 
   40462:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40469:	00 
   4046a:	76 b3                	jbe    4041f <find_page+0x1b>
        }
    }
    return 0; 
   4046c:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40471:	c9                   	leave  
   40472:	c3                   	ret    

0000000000040473 <make_pages>:
x86_64_pagetable* make_pages(pid_t pid);
x86_64_pagetable* make_pages(pid_t pid){
   40473:	f3 0f 1e fa          	endbr64 
   40477:	55                   	push   %rbp
   40478:	48 89 e5             	mov    %rsp,%rbp
   4047b:	48 83 ec 40          	sub    $0x40,%rsp
   4047f:	89 7d cc             	mov    %edi,-0x34(%rbp)
    x86_64_pagetable *l4 = (x86_64_pagetable*) find_page(pid);
   40482:	8b 45 cc             	mov    -0x34(%rbp),%eax
   40485:	0f be c0             	movsbl %al,%eax
   40488:	89 c7                	mov    %eax,%edi
   4048a:	e8 75 ff ff ff       	call   40404 <find_page>
   4048f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pagetable *l3 = (x86_64_pagetable*) find_page(pid);
   40493:	8b 45 cc             	mov    -0x34(%rbp),%eax
   40496:	0f be c0             	movsbl %al,%eax
   40499:	89 c7                	mov    %eax,%edi
   4049b:	e8 64 ff ff ff       	call   40404 <find_page>
   404a0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    x86_64_pagetable *l2 = (x86_64_pagetable*) find_page(pid);
   404a4:	8b 45 cc             	mov    -0x34(%rbp),%eax
   404a7:	0f be c0             	movsbl %al,%eax
   404aa:	89 c7                	mov    %eax,%edi
   404ac:	e8 53 ff ff ff       	call   40404 <find_page>
   404b1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    x86_64_pagetable *l1_1 = (x86_64_pagetable*) find_page(pid);
   404b5:	8b 45 cc             	mov    -0x34(%rbp),%eax
   404b8:	0f be c0             	movsbl %al,%eax
   404bb:	89 c7                	mov    %eax,%edi
   404bd:	e8 42 ff ff ff       	call   40404 <find_page>
   404c2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    x86_64_pagetable *l1_0 = (x86_64_pagetable*) find_page(pid);
   404c6:	8b 45 cc             	mov    -0x34(%rbp),%eax
   404c9:	0f be c0             	movsbl %al,%eax
   404cc:	89 c7                	mov    %eax,%edi
   404ce:	e8 31 ff ff ff       	call   40404 <find_page>
   404d3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    memset(l4, 0, PAGESIZE);
   404d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404db:	ba 00 10 00 00       	mov    $0x1000,%edx
   404e0:	be 00 00 00 00       	mov    $0x0,%esi
   404e5:	48 89 c7             	mov    %rax,%rdi
   404e8:	e8 62 37 00 00       	call   43c4f <memset>
    memset(l3, 0, PAGESIZE);
   404ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   404f1:	ba 00 10 00 00       	mov    $0x1000,%edx
   404f6:	be 00 00 00 00       	mov    $0x0,%esi
   404fb:	48 89 c7             	mov    %rax,%rdi
   404fe:	e8 4c 37 00 00       	call   43c4f <memset>
    memset(l2, 0, PAGESIZE);
   40503:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40507:	ba 00 10 00 00       	mov    $0x1000,%edx
   4050c:	be 00 00 00 00       	mov    $0x0,%esi
   40511:	48 89 c7             	mov    %rax,%rdi
   40514:	e8 36 37 00 00       	call   43c4f <memset>
    memset(l1_1, 0, PAGESIZE);
   40519:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4051d:	ba 00 10 00 00       	mov    $0x1000,%edx
   40522:	be 00 00 00 00       	mov    $0x0,%esi
   40527:	48 89 c7             	mov    %rax,%rdi
   4052a:	e8 20 37 00 00       	call   43c4f <memset>
    memset(l1_0, 0, PAGESIZE);
   4052f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40533:	ba 00 10 00 00       	mov    $0x1000,%edx
   40538:	be 00 00 00 00       	mov    $0x0,%esi
   4053d:	48 89 c7             	mov    %rax,%rdi
   40540:	e8 0a 37 00 00       	call   43c4f <memset>

    if (!l4) {
   40545:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4054a:	75 0a                	jne    40556 <make_pages+0xe3>
        return NULL;
   4054c:	b8 00 00 00 00       	mov    $0x0,%eax
   40551:	e9 ed 00 00 00       	jmp    40643 <make_pages+0x1d0>
    }
    if (!l3 || !l2 || !l1_1 || !l1_0) {
   40556:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4055b:	74 19                	je     40576 <make_pages+0x103>
   4055d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40562:	74 12                	je     40576 <make_pages+0x103>
   40564:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40569:	74 0b                	je     40576 <make_pages+0x103>
   4056b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   40570:	0f 85 80 00 00 00    	jne    405f6 <make_pages+0x183>
        if (l1_1) {
   40576:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4057b:	74 19                	je     40596 <make_pages+0x123>
            pageinfo[PAGENUMBER(l1_1)].refcount = 0;
   4057d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40581:	48 c1 e8 0c          	shr    $0xc,%rax
   40585:	48 98                	cltq   
   40587:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4058b:	48 8d 05 af 28 01 00 	lea    0x128af(%rip),%rax        # 52e41 <pageinfo+0x1>
   40592:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        }
        if (l3) {
   40596:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4059b:	74 19                	je     405b6 <make_pages+0x143>
            pageinfo[PAGENUMBER(l3)].refcount = 0;
   4059d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   405a1:	48 c1 e8 0c          	shr    $0xc,%rax
   405a5:	48 98                	cltq   
   405a7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   405ab:	48 8d 05 8f 28 01 00 	lea    0x1288f(%rip),%rax        # 52e41 <pageinfo+0x1>
   405b2:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        }
        if (l2) {
   405b6:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   405bb:	74 19                	je     405d6 <make_pages+0x163>
            pageinfo[PAGENUMBER(l2)].refcount = 0;
   405bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405c1:	48 c1 e8 0c          	shr    $0xc,%rax
   405c5:	48 98                	cltq   
   405c7:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   405cb:	48 8d 05 6f 28 01 00 	lea    0x1286f(%rip),%rax        # 52e41 <pageinfo+0x1>
   405d2:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        }
        pageinfo[PAGENUMBER(l4)].refcount = 0;
   405d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405da:	48 c1 e8 0c          	shr    $0xc,%rax
   405de:	48 98                	cltq   
   405e0:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   405e4:	48 8d 05 56 28 01 00 	lea    0x12856(%rip),%rax        # 52e41 <pageinfo+0x1>
   405eb:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        return NULL;
   405ef:	b8 00 00 00 00       	mov    $0x0,%eax
   405f4:	eb 4d                	jmp    40643 <make_pages+0x1d0>
    }
    l4->entry[0] = (x86_64_pageentry_t)l3 | PTE_P | PTE_W | PTE_U;
   405f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   405fa:	48 83 c8 07          	or     $0x7,%rax
   405fe:	48 89 c2             	mov    %rax,%rdx
   40601:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40605:	48 89 10             	mov    %rdx,(%rax)
    l3->entry[0] = (x86_64_pageentry_t)l2 | PTE_P | PTE_W | PTE_U;
   40608:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4060c:	48 83 c8 07          	or     $0x7,%rax
   40610:	48 89 c2             	mov    %rax,%rdx
   40613:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40617:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[0] = (x86_64_pageentry_t)l1_0 | PTE_P | PTE_W | PTE_U;
   4061a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4061e:	48 83 c8 07          	or     $0x7,%rax
   40622:	48 89 c2             	mov    %rax,%rdx
   40625:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40629:	48 89 10             	mov    %rdx,(%rax)
    l2->entry[1] = (x86_64_pageentry_t)l1_1 | PTE_P | PTE_W | PTE_U;
   4062c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40630:	48 83 c8 07          	or     $0x7,%rax
   40634:	48 89 c2             	mov    %rax,%rdx
   40637:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4063b:	48 89 50 08          	mov    %rdx,0x8(%rax)
    return l4;
   4063f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   40643:	c9                   	leave  
   40644:	c3                   	ret    

0000000000040645 <process_setup>:

void process_setup(pid_t pid, int program_number) {
   40645:	f3 0f 1e fa          	endbr64 
   40649:	55                   	push   %rbp
   4064a:	48 89 e5             	mov    %rsp,%rbp
   4064d:	48 83 ec 40          	sub    $0x40,%rsp
   40651:	89 7d cc             	mov    %edi,-0x34(%rbp)
   40654:	89 75 c8             	mov    %esi,-0x38(%rbp)
    process_init(&processes[pid], 0);
   40657:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4065a:	48 63 d0             	movslq %eax,%rdx
   4065d:	48 89 d0             	mov    %rdx,%rax
   40660:	48 c1 e0 03          	shl    $0x3,%rax
   40664:	48 29 d0             	sub    %rdx,%rax
   40667:	48 c1 e0 05          	shl    $0x5,%rax
   4066b:	48 8d 15 ae 19 01 00 	lea    0x119ae(%rip),%rdx        # 52020 <processes>
   40672:	48 01 d0             	add    %rdx,%rax
   40675:	be 00 00 00 00       	mov    $0x0,%esi
   4067a:	48 89 c7             	mov    %rax,%rdi
   4067d:	e8 41 20 00 00       	call   426c3 <process_init>

    x86_64_pagetable *l4 = make_pages(pid);
   40682:	8b 45 cc             	mov    -0x34(%rbp),%eax
   40685:	89 c7                	mov    %eax,%edi
   40687:	e8 e7 fd ff ff       	call   40473 <make_pages>
   4068c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    for (uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE) {
   40690:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40697:	00 
   40698:	eb 49                	jmp    406e3 <process_setup+0x9e>
        vamapping vam = virtual_memory_lookup(kernel_pagetable, va);
   4069a:	48 8b 0d 5f 49 01 00 	mov    0x1495f(%rip),%rcx        # 55000 <kernel_pagetable>
   406a1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   406a5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   406a9:	48 89 ce             	mov    %rcx,%rsi
   406ac:	48 89 c7             	mov    %rax,%rdi
   406af:	e8 13 30 00 00       	call   436c7 <virtual_memory_lookup>
        if (vam.pn != -1) {
   406b4:	8b 45 d0             	mov    -0x30(%rbp),%eax
   406b7:	83 f8 ff             	cmp    $0xffffffff,%eax
   406ba:	74 1f                	je     406db <process_setup+0x96>
            virtual_memory_map(l4, va, vam.pa, PAGESIZE, PTE_P | PTE_W );
   406bc:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   406c0:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   406c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   406c8:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   406ce:	b9 00 10 00 00       	mov    $0x1000,%ecx
   406d3:	48 89 c7             	mov    %rax,%rdi
   406d6:	e8 a2 2b 00 00       	call   4327d <virtual_memory_map>
    for (uintptr_t va = 0; va < PROC_START_ADDR; va += PAGESIZE) {
   406db:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   406e2:	00 
   406e3:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   406ea:	00 
   406eb:	76 ad                	jbe    4069a <process_setup+0x55>
        }
    }

    processes[pid].p_pagetable = l4;
   406ed:	8b 45 cc             	mov    -0x34(%rbp),%eax
   406f0:	48 63 d0             	movslq %eax,%rdx
   406f3:	48 89 d0             	mov    %rdx,%rax
   406f6:	48 c1 e0 03          	shl    $0x3,%rax
   406fa:	48 29 d0             	sub    %rdx,%rax
   406fd:	48 c1 e0 05          	shl    $0x5,%rax
   40701:	48 89 c1             	mov    %rax,%rcx
   40704:	48 8d 15 e5 19 01 00 	lea    0x119e5(%rip),%rdx        # 520f0 <processes+0xd0>
   4070b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4070f:	48 89 04 11          	mov    %rax,(%rcx,%rdx,1)
    // FIXME
    // virtual_memory_map(l4, 0, 0,
    //                PROC_START_ADDR, PTE_P | PTE_W); 
    virtual_memory_map(l4, CONSOLE_ADDR, CONSOLE_ADDR,
   40713:	48 8d 15 e6 78 07 00 	lea    0x778e6(%rip),%rdx        # b8000 <console>
   4071a:	48 8d 35 df 78 07 00 	lea    0x778df(%rip),%rsi        # b8000 <console>
   40721:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40725:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4072b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40730:	48 89 c7             	mov    %rax,%rdi
   40733:	e8 45 2b 00 00       	call   4327d <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);

    int r = program_load(&processes[pid], program_number, NULL);
   40738:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4073b:	48 63 d0             	movslq %eax,%rdx
   4073e:	48 89 d0             	mov    %rdx,%rax
   40741:	48 c1 e0 03          	shl    $0x3,%rax
   40745:	48 29 d0             	sub    %rdx,%rax
   40748:	48 c1 e0 05          	shl    $0x5,%rax
   4074c:	48 8d 15 cd 18 01 00 	lea    0x118cd(%rip),%rdx        # 52020 <processes>
   40753:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
   40757:	8b 45 c8             	mov    -0x38(%rbp),%eax
   4075a:	ba 00 00 00 00       	mov    $0x0,%edx
   4075f:	89 c6                	mov    %eax,%esi
   40761:	48 89 cf             	mov    %rcx,%rdi
   40764:	e8 59 30 00 00       	call   437c2 <program_load>
   40769:	89 45 ec             	mov    %eax,-0x14(%rbp)
    assert(r >= 0);
   4076c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   40770:	79 1e                	jns    40790 <process_setup+0x14b>
   40772:	48 8d 05 00 45 00 00 	lea    0x4500(%rip),%rax        # 44c79 <console_clear+0x75>
   40779:	48 89 c2             	mov    %rax,%rdx
   4077c:	be d1 00 00 00       	mov    $0xd1,%esi
   40781:	48 8d 05 f8 44 00 00 	lea    0x44f8(%rip),%rax        # 44c80 <console_clear+0x7c>
   40788:	48 89 c7             	mov    %rax,%rdi
   4078b:	e8 69 27 00 00       	call   42ef9 <assert_fail>

    virtual_memory_map(l4, MEMSIZE_VIRTUAL - PAGESIZE, find_page(pid), PAGESIZE, PTE_P | PTE_W | PTE_U);
   40790:	8b 45 cc             	mov    -0x34(%rbp),%eax
   40793:	0f be c0             	movsbl %al,%eax
   40796:	89 c7                	mov    %eax,%edi
   40798:	e8 67 fc ff ff       	call   40404 <find_page>
   4079d:	48 89 c2             	mov    %rax,%rdx
   407a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   407a4:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   407aa:	b9 00 10 00 00       	mov    $0x1000,%ecx
   407af:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   407b4:	48 89 c7             	mov    %rax,%rdi
   407b7:	e8 c1 2a 00 00       	call   4327d <virtual_memory_map>
    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL;
   407bc:	8b 45 cc             	mov    -0x34(%rbp),%eax
   407bf:	48 63 d0             	movslq %eax,%rdx
   407c2:	48 89 d0             	mov    %rdx,%rax
   407c5:	48 c1 e0 03          	shl    $0x3,%rax
   407c9:	48 29 d0             	sub    %rdx,%rax
   407cc:	48 c1 e0 05          	shl    $0x5,%rax
   407d0:	48 89 c2             	mov    %rax,%rdx
   407d3:	48 8d 05 fe 18 01 00 	lea    0x118fe(%rip),%rax        # 520d8 <processes+0xb8>
   407da:	48 c7 04 02 00 00 30 	movq   $0x300000,(%rdx,%rax,1)
   407e1:	00 

    processes[pid].p_state = P_RUNNABLE;
   407e2:	8b 45 cc             	mov    -0x34(%rbp),%eax
   407e5:	48 63 d0             	movslq %eax,%rdx
   407e8:	48 89 d0             	mov    %rdx,%rax
   407eb:	48 c1 e0 03          	shl    $0x3,%rax
   407ef:	48 29 d0             	sub    %rdx,%rax
   407f2:	48 c1 e0 05          	shl    $0x5,%rax
   407f6:	48 89 c2             	mov    %rax,%rdx
   407f9:	48 8d 05 e8 18 01 00 	lea    0x118e8(%rip),%rax        # 520e8 <processes+0xc8>
   40800:	c7 04 02 01 00 00 00 	movl   $0x1,(%rdx,%rax,1)
}
   40807:	90                   	nop
   40808:	c9                   	leave  
   40809:	c3                   	ret    

000000000004080a <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   4080a:	f3 0f 1e fa          	endbr64 
   4080e:	55                   	push   %rbp
   4080f:	48 89 e5             	mov    %rsp,%rbp
   40812:	48 83 ec 10          	sub    $0x10,%rsp
   40816:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4081a:	89 f0                	mov    %esi,%eax
   4081c:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   4081f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40823:	25 ff 0f 00 00       	and    $0xfff,%eax
   40828:	48 85 c0             	test   %rax,%rax
   4082b:	75 27                	jne    40854 <assign_physical_page+0x4a>
        || addr >= MEMSIZE_PHYSICAL
   4082d:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40834:	00 
   40835:	77 1d                	ja     40854 <assign_physical_page+0x4a>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40837:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4083b:	48 c1 e8 0c          	shr    $0xc,%rax
   4083f:	48 98                	cltq   
   40841:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40845:	48 8d 05 f5 25 01 00 	lea    0x125f5(%rip),%rax        # 52e41 <pageinfo+0x1>
   4084c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40850:	84 c0                	test   %al,%al
   40852:	74 07                	je     4085b <assign_physical_page+0x51>
        return -1;
   40854:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40859:	eb 3a                	jmp    40895 <assign_physical_page+0x8b>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   4085b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4085f:	48 c1 e8 0c          	shr    $0xc,%rax
   40863:	48 98                	cltq   
   40865:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40869:	48 8d 05 d1 25 01 00 	lea    0x125d1(%rip),%rax        # 52e41 <pageinfo+0x1>
   40870:	c6 04 02 01          	movb   $0x1,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40874:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40878:	48 c1 e8 0c          	shr    $0xc,%rax
   4087c:	48 98                	cltq   
   4087e:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   40882:	48 8d 15 b7 25 01 00 	lea    0x125b7(%rip),%rdx        # 52e40 <pageinfo>
   40889:	0f b6 45 f4          	movzbl -0xc(%rbp),%eax
   4088d:	88 04 11             	mov    %al,(%rcx,%rdx,1)
        return 0;
   40890:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40895:	c9                   	leave  
   40896:	c3                   	ret    

0000000000040897 <syscall_mapping>:

void syscall_mapping(proc* p){
   40897:	f3 0f 1e fa          	endbr64 
   4089b:	55                   	push   %rbp
   4089c:	48 89 e5             	mov    %rsp,%rbp
   4089f:	48 83 ec 70          	sub    $0x70,%rsp
   408a3:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   408a7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   408ab:	48 8b 40 38          	mov    0x38(%rax),%rax
   408af:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   408b3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   408b7:	48 8b 40 30          	mov    0x30(%rax),%rax
   408bb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   408bf:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   408c3:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   408ca:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   408ce:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   408d2:	48 89 ce             	mov    %rcx,%rsi
   408d5:	48 89 c7             	mov    %rax,%rdi
   408d8:	e8 ea 2d 00 00       	call   436c7 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   408dd:	8b 45 e0             	mov    -0x20(%rbp),%eax
   408e0:	48 98                	cltq   
   408e2:	83 e0 06             	and    $0x6,%eax
   408e5:	48 83 f8 06          	cmp    $0x6,%rax
   408e9:	75 73                	jne    4095e <syscall_mapping+0xc7>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   408eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   408ef:	48 83 c0 17          	add    $0x17,%rax
   408f3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   408f7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   408fb:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40902:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40906:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4090a:	48 89 ce             	mov    %rcx,%rsi
   4090d:	48 89 c7             	mov    %rax,%rdi
   40910:	e8 b2 2d 00 00       	call   436c7 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40915:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40918:	48 98                	cltq   
   4091a:	83 e0 03             	and    $0x3,%eax
   4091d:	48 83 f8 03          	cmp    $0x3,%rax
   40921:	75 3e                	jne    40961 <syscall_mapping+0xca>
        return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40923:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40927:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4092e:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40932:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40936:	48 89 ce             	mov    %rcx,%rsi
   40939:	48 89 c7             	mov    %rax,%rdi
   4093c:	e8 86 2d 00 00       	call   436c7 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40941:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40945:	48 89 c1             	mov    %rax,%rcx
   40948:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4094c:	ba 18 00 00 00       	mov    $0x18,%edx
   40951:	48 89 c6             	mov    %rax,%rsi
   40954:	48 89 cf             	mov    %rcx,%rdi
   40957:	e8 ed 31 00 00       	call   43b49 <memcpy>
   4095c:	eb 04                	jmp    40962 <syscall_mapping+0xcb>
        return;
   4095e:	90                   	nop
   4095f:	eb 01                	jmp    40962 <syscall_mapping+0xcb>
        return;
   40961:	90                   	nop
}
   40962:	c9                   	leave  
   40963:	c3                   	ret    

0000000000040964 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40964:	f3 0f 1e fa          	endbr64 
   40968:	55                   	push   %rbp
   40969:	48 89 e5             	mov    %rsp,%rbp
   4096c:	48 83 ec 18          	sub    $0x18,%rsp
   40970:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40974:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40978:	48 8b 40 38          	mov    0x38(%rax),%rax
   4097c:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   4097f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40983:	75 14                	jne    40999 <syscall_mem_tog+0x35>
        disp_global = !disp_global;
   40985:	0f b6 05 74 56 00 00 	movzbl 0x5674(%rip),%eax        # 46000 <disp_global>
   4098c:	84 c0                	test   %al,%al
   4098e:	0f 94 c0             	sete   %al
   40991:	88 05 69 56 00 00    	mov    %al,0x5669(%rip)        # 46000 <disp_global>
   40997:	eb 36                	jmp    409cf <syscall_mem_tog+0x6b>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40999:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4099d:	78 2f                	js     409ce <syscall_mem_tog+0x6a>
   4099f:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   409a3:	7f 29                	jg     409ce <syscall_mem_tog+0x6a>
   409a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   409a9:	8b 00                	mov    (%rax),%eax
   409ab:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   409ae:	75 1e                	jne    409ce <syscall_mem_tog+0x6a>
            return;
        process->display_status = !(process->display_status);
   409b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   409b4:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   409bb:	84 c0                	test   %al,%al
   409bd:	0f 94 c0             	sete   %al
   409c0:	89 c2                	mov    %eax,%edx
   409c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   409c6:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   409cc:	eb 01                	jmp    409cf <syscall_mem_tog+0x6b>
            return;
   409ce:	90                   	nop
    }
}
   409cf:	c9                   	leave  
   409d0:	c3                   	ret    

00000000000409d1 <exit1>:
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

// from office hours help 
void exit1(proc* p);
void exit1(proc* p){
   409d1:	f3 0f 1e fa          	endbr64 
   409d5:	55                   	push   %rbp
   409d6:	48 89 e5             	mov    %rsp,%rbp
   409d9:	48 83 ec 60          	sub    $0x60,%rsp
   409dd:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
        for (uintptr_t addr = PROC_START_ADDR; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE){
   409e1:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   409e8:	00 
   409e9:	e9 86 00 00 00       	jmp    40a74 <exit1+0xa3>
            vamapping vam = virtual_memory_lookup(p->p_pagetable, addr);
   409ee:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   409f2:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   409f9:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   409fd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40a01:	48 89 ce             	mov    %rcx,%rsi
   40a04:	48 89 c7             	mov    %rax,%rdi
   40a07:	e8 bb 2c 00 00       	call   436c7 <virtual_memory_lookup>
            if (vam.pn < 0){
   40a0c:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40a0f:	85 c0                	test   %eax,%eax
   40a11:	78 58                	js     40a6b <exit1+0x9a>
                continue;
            }
            pageinfo[vam.pn].refcount--;
   40a13:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40a16:	48 63 d0             	movslq %eax,%rdx
   40a19:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40a1d:	48 8d 15 1d 24 01 00 	lea    0x1241d(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40a24:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40a28:	83 ea 01             	sub    $0x1,%edx
   40a2b:	89 d1                	mov    %edx,%ecx
   40a2d:	48 98                	cltq   
   40a2f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40a33:	48 8d 05 07 24 01 00 	lea    0x12407(%rip),%rax        # 52e41 <pageinfo+0x1>
   40a3a:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
            if (pageinfo[vam.pn].refcount == 0)
   40a3d:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40a40:	48 98                	cltq   
   40a42:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40a46:	48 8d 05 f4 23 01 00 	lea    0x123f4(%rip),%rax        # 52e41 <pageinfo+0x1>
   40a4d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   40a51:	84 c0                	test   %al,%al
   40a53:	75 17                	jne    40a6c <exit1+0x9b>
                {
                pageinfo[vam.pn].owner = PO_FREE;
   40a55:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40a58:	48 98                	cltq   
   40a5a:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40a5e:	48 8d 05 db 23 01 00 	lea    0x123db(%rip),%rax        # 52e40 <pageinfo>
   40a65:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
   40a69:	eb 01                	jmp    40a6c <exit1+0x9b>
                continue;
   40a6b:	90                   	nop
        for (uintptr_t addr = PROC_START_ADDR; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE){
   40a6c:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40a73:	00 
   40a74:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40a7b:	00 
   40a7c:	0f 86 6c ff ff ff    	jbe    409ee <exit1+0x1d>
            }
        }
        x86_64_pagetable* page_tables[5];

        page_tables[0] = p->p_pagetable;
   40a82:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40a86:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40a8d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        page_tables[1] = (x86_64_pagetable*) PTE_ADDR(page_tables[0]->entry[0]); // L3 
   40a91:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40a95:	48 8b 00             	mov    (%rax),%rax
   40a98:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40a9e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        page_tables[2] = (x86_64_pagetable*) PTE_ADDR(page_tables[1]->entry[0]); // L2
   40aa2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40aa6:	48 8b 00             	mov    (%rax),%rax
   40aa9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40aaf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        page_tables[3] = (x86_64_pagetable*) PTE_ADDR(page_tables[2]->entry[0]); // L1_0
   40ab3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40ab7:	48 8b 00             	mov    (%rax),%rax
   40aba:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40ac0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        page_tables[4] = (x86_64_pagetable*) PTE_ADDR(page_tables[2]->entry[1]); // L1_1
   40ac4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40ac8:	48 8b 40 08          	mov    0x8(%rax),%rax
   40acc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40ad2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    
        for (int i = 0; i < 5; ++i) {
   40ad6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40add:	eb 4c                	jmp    40b2b <exit1+0x15a>
        if (page_tables[i]) {
   40adf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ae2:	48 98                	cltq   
   40ae4:	48 8b 44 c5 c8       	mov    -0x38(%rbp,%rax,8),%rax
   40ae9:	48 85 c0             	test   %rax,%rax
   40aec:	74 39                	je     40b27 <exit1+0x156>
            int pn = PAGENUMBER(page_tables[i]);
   40aee:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40af1:	48 98                	cltq   
   40af3:	48 8b 44 c5 c8       	mov    -0x38(%rbp,%rax,8),%rax
   40af8:	48 c1 e8 0c          	shr    $0xc,%rax
   40afc:	89 45 f0             	mov    %eax,-0x10(%rbp)
                pageinfo[pn].owner = PO_FREE;
   40aff:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40b02:	48 98                	cltq   
   40b04:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40b08:	48 8d 05 31 23 01 00 	lea    0x12331(%rip),%rax        # 52e40 <pageinfo>
   40b0f:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
                pageinfo[pn].refcount = 0;
   40b13:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40b16:	48 98                	cltq   
   40b18:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40b1c:	48 8d 05 1e 23 01 00 	lea    0x1231e(%rip),%rax        # 52e41 <pageinfo+0x1>
   40b23:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        for (int i = 0; i < 5; ++i) {
   40b27:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40b2b:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   40b2f:	7e ae                	jle    40adf <exit1+0x10e>
        }
    }
            p->p_state = P_FREE;
   40b31:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40b35:	c7 80 c8 00 00 00 00 	movl   $0x0,0xc8(%rax)
   40b3c:	00 00 00 

}
   40b3f:	90                   	nop
   40b40:	c9                   	leave  
   40b41:	c3                   	ret    

0000000000040b42 <fork1>:
// a lot of help from OH on fork1 and exit1
int fork1(void);
int fork1(void){
   40b42:	f3 0f 1e fa          	endbr64 
   40b46:	55                   	push   %rbp
   40b47:	48 89 e5             	mov    %rsp,%rbp
   40b4a:	48 83 ec 70          	sub    $0x70,%rsp
    // find free
    pid_t child_pid = -1;
   40b4e:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)

    for (pid_t i = 1; i < NPROC; i++) {
   40b55:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   40b5c:	eb 31                	jmp    40b8f <fork1+0x4d>
        if (processes[i].p_state == P_FREE) {
   40b5e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40b61:	48 63 d0             	movslq %eax,%rdx
   40b64:	48 89 d0             	mov    %rdx,%rax
   40b67:	48 c1 e0 03          	shl    $0x3,%rax
   40b6b:	48 29 d0             	sub    %rdx,%rax
   40b6e:	48 c1 e0 05          	shl    $0x5,%rax
   40b72:	48 89 c2             	mov    %rax,%rdx
   40b75:	48 8d 05 6c 15 01 00 	lea    0x1156c(%rip),%rax        # 520e8 <processes+0xc8>
   40b7c:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40b7f:	85 c0                	test   %eax,%eax
   40b81:	75 08                	jne    40b8b <fork1+0x49>
            child_pid = i;
   40b83:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40b86:	89 45 fc             	mov    %eax,-0x4(%rbp)
            // current->p_registers.reg_rax = -1;
            break;
   40b89:	eb 0a                	jmp    40b95 <fork1+0x53>
    for (pid_t i = 1; i < NPROC; i++) {
   40b8b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40b8f:	83 7d f8 0f          	cmpl   $0xf,-0x8(%rbp)
   40b93:	7e c9                	jle    40b5e <fork1+0x1c>
        }
    }
    // no ree
    if (child_pid == -1) {
   40b95:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40b99:	75 1b                	jne    40bb6 <fork1+0x74>
        current->p_registers.reg_rax = child_pid;
   40b9b:	48 8b 05 5e 14 01 00 	mov    0x1145e(%rip),%rax        # 52000 <current>
   40ba2:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ba5:	48 63 d2             	movslq %edx,%rdx
   40ba8:	48 89 50 08          	mov    %rdx,0x8(%rax)
        return -1;
   40bac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40bb1:	e9 a2 02 00 00       	jmp    40e58 <fork1+0x316>
    }

    // reserve
    proc* parent = current;
   40bb6:	48 8b 05 43 14 01 00 	mov    0x11443(%rip),%rax        # 52000 <current>
   40bbd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    proc* child = &processes[child_pid];
   40bc1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bc4:	48 63 d0             	movslq %eax,%rdx
   40bc7:	48 89 d0             	mov    %rdx,%rax
   40bca:	48 c1 e0 03          	shl    $0x3,%rax
   40bce:	48 29 d0             	sub    %rdx,%rax
   40bd1:	48 c1 e0 05          	shl    $0x5,%rax
   40bd5:	48 8d 15 44 14 01 00 	lea    0x11444(%rip),%rdx        # 52020 <processes>
   40bdc:	48 01 d0             	add    %rdx,%rax
   40bdf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    process_init(child, 0);
   40be3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40be7:	be 00 00 00 00       	mov    $0x0,%esi
   40bec:	48 89 c7             	mov    %rax,%rdi
   40bef:	e8 cf 1a 00 00       	call   426c3 <process_init>

    x86_64_pagetable* child_table = make_pages(child_pid);
   40bf4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bf7:	89 c7                	mov    %eax,%edi
   40bf9:	e8 75 f8 ff ff       	call   40473 <make_pages>
   40bfe:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if (child_table == NULL){
   40c02:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   40c07:	75 0a                	jne    40c13 <fork1+0xd1>
        return -1;
   40c09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40c0e:	e9 45 02 00 00       	jmp    40e58 <fork1+0x316>
    }
    for (uintptr_t addr = 0; addr < PROC_START_ADDR; addr += PAGESIZE) {
   40c13:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   40c1a:	00 
   40c1b:	eb 56                	jmp    40c73 <fork1+0x131>
        vamapping vm = virtual_memory_lookup(kernel_pagetable, addr);
   40c1d:	48 8b 0d dc 43 01 00 	mov    0x143dc(%rip),%rcx        # 55000 <kernel_pagetable>
   40c24:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40c28:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40c2c:	48 89 ce             	mov    %rcx,%rsi
   40c2f:	48 89 c7             	mov    %rax,%rdi
   40c32:	e8 90 2a 00 00       	call   436c7 <virtual_memory_lookup>
        if (vm.pn >= 0) {
   40c37:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40c3a:	85 c0                	test   %eax,%eax
   40c3c:	78 2d                	js     40c6b <fork1+0x129>
            if (virtual_memory_map(child_table, addr, addr, PAGESIZE, vm.perm) < 0) {
   40c3e:	8b 4d c0             	mov    -0x40(%rbp),%ecx
   40c41:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40c45:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40c49:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40c4d:	41 89 c8             	mov    %ecx,%r8d
   40c50:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40c55:	48 89 c7             	mov    %rax,%rdi
   40c58:	e8 20 26 00 00       	call   4327d <virtual_memory_map>
   40c5d:	85 c0                	test   %eax,%eax
   40c5f:	79 0a                	jns    40c6b <fork1+0x129>
                return -1;
   40c61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40c66:	e9 ed 01 00 00       	jmp    40e58 <fork1+0x316>
    for (uintptr_t addr = 0; addr < PROC_START_ADDR; addr += PAGESIZE) {
   40c6b:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   40c72:	00 
   40c73:	48 81 7d f0 ff ff 0f 	cmpq   $0xfffff,-0x10(%rbp)
   40c7a:	00 
   40c7b:	76 a0                	jbe    40c1d <fork1+0xdb>
            }
        }
    }

    child->p_pagetable = child_table;
   40c7d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40c81:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40c85:	48 89 90 d0 00 00 00 	mov    %rdx,0xd0(%rax)

    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40c8c:	48 c7 45 e8 00 00 10 	movq   $0x100000,-0x18(%rbp)
   40c93:	00 
   40c94:	e9 63 01 00 00       	jmp    40dfc <fork1+0x2ba>
        vamapping parent_mapping = virtual_memory_lookup(parent->p_pagetable, va);
   40c99:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40c9d:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40ca4:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   40ca8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40cac:	48 89 ce             	mov    %rcx,%rsi
   40caf:	48 89 c7             	mov    %rax,%rdi
   40cb2:	e8 10 2a 00 00       	call   436c7 <virtual_memory_lookup>
        // skip console and nonexistent pages
        if (va == CONSOLE_ADDR || parent_mapping.pn == -1) {
   40cb7:	48 8d 05 42 73 07 00 	lea    0x77342(%rip),%rax        # b8000 <console>
   40cbe:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40cc2:	0f 84 2b 01 00 00    	je     40df3 <fork1+0x2b1>
   40cc8:	8b 45 98             	mov    -0x68(%rbp),%eax
   40ccb:	83 f8 ff             	cmp    $0xffffffff,%eax
   40cce:	0f 84 1f 01 00 00    	je     40df3 <fork1+0x2b1>
            continue; 
        }
        if (parent_mapping.perm & PTE_W) {
   40cd4:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40cd7:	48 98                	cltq   
   40cd9:	83 e0 02             	and    $0x2,%eax
   40cdc:	48 85 c0             	test   %rax,%rax
   40cdf:	0f 84 94 00 00 00    	je     40d79 <fork1+0x237>
        // Allocate a new physical page for the child
            uintptr_t new_pa = find_page(child_pid);
   40ce5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ce8:	0f be c0             	movsbl %al,%eax
   40ceb:	89 c7                	mov    %eax,%edi
   40ced:	e8 12 f7 ff ff       	call   40404 <find_page>
   40cf2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            if (!new_pa) {
   40cf6:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40cfb:	75 1d                	jne    40d1a <fork1+0x1d8>
            exit1(child);
   40cfd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40d01:	48 89 c7             	mov    %rax,%rdi
   40d04:	e8 c8 fc ff ff       	call   409d1 <exit1>
            child_pid = -1;
   40d09:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
            return -1;
   40d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40d15:	e9 3e 01 00 00       	jmp    40e58 <fork1+0x316>
            }
            memcpy((void*) new_pa, (void*) parent_mapping.pa, PAGESIZE);
   40d1a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   40d1e:	48 89 c1             	mov    %rax,%rcx
   40d21:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40d25:	ba 00 10 00 00       	mov    $0x1000,%edx
   40d2a:	48 89 ce             	mov    %rcx,%rsi
   40d2d:	48 89 c7             	mov    %rax,%rdi
   40d30:	e8 14 2e 00 00       	call   43b49 <memcpy>
            if (virtual_memory_map(child_table, va, new_pa, PAGESIZE, parent_mapping.perm) < 0) {
   40d35:	8b 4d a8             	mov    -0x58(%rbp),%ecx
   40d38:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40d3c:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40d40:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40d44:	41 89 c8             	mov    %ecx,%r8d
   40d47:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40d4c:	48 89 c7             	mov    %rax,%rdi
   40d4f:	e8 29 25 00 00       	call   4327d <virtual_memory_map>
   40d54:	85 c0                	test   %eax,%eax
   40d56:	0f 89 98 00 00 00    	jns    40df4 <fork1+0x2b2>
                exit1(child);
   40d5c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40d60:	48 89 c7             	mov    %rax,%rdi
   40d63:	e8 69 fc ff ff       	call   409d1 <exit1>
                child_pid = -1;
   40d68:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
                return -1;
   40d6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40d74:	e9 df 00 00 00       	jmp    40e58 <fork1+0x316>

            }
        } else if (((parent_mapping.perm & (PTE_P | PTE_U)) == (PTE_P | PTE_U))) {
   40d79:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40d7c:	48 98                	cltq   
   40d7e:	83 e0 05             	and    $0x5,%eax
   40d81:	48 83 f8 05          	cmp    $0x5,%rax
   40d85:	75 6d                	jne    40df4 <fork1+0x2b2>
                
            if (virtual_memory_map(child_table, va, parent_mapping.pa, PAGESIZE, parent_mapping.perm) < 0) {
   40d87:	8b 4d a8             	mov    -0x58(%rbp),%ecx
   40d8a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   40d8e:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40d92:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40d96:	41 89 c8             	mov    %ecx,%r8d
   40d99:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40d9e:	48 89 c7             	mov    %rax,%rdi
   40da1:	e8 d7 24 00 00       	call   4327d <virtual_memory_map>
   40da6:	85 c0                	test   %eax,%eax
   40da8:	79 1d                	jns    40dc7 <fork1+0x285>
                exit1(child);            
   40daa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40dae:	48 89 c7             	mov    %rax,%rdi
   40db1:	e8 1b fc ff ff       	call   409d1 <exit1>
                child_pid = -1;
   40db6:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
                return -1;
   40dbd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40dc2:	e9 91 00 00 00       	jmp    40e58 <fork1+0x316>
            }
            pageinfo[parent_mapping.pn].refcount++;
   40dc7:	8b 45 98             	mov    -0x68(%rbp),%eax
   40dca:	48 63 d0             	movslq %eax,%rdx
   40dcd:	48 8d 0c 12          	lea    (%rdx,%rdx,1),%rcx
   40dd1:	48 8d 15 69 20 01 00 	lea    0x12069(%rip),%rdx        # 52e41 <pageinfo+0x1>
   40dd8:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   40ddc:	83 c2 01             	add    $0x1,%edx
   40ddf:	89 d1                	mov    %edx,%ecx
   40de1:	48 98                	cltq   
   40de3:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   40de7:	48 8d 05 53 20 01 00 	lea    0x12053(%rip),%rax        # 52e41 <pageinfo+0x1>
   40dee:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
   40df1:	eb 01                	jmp    40df4 <fork1+0x2b2>
            continue; 
   40df3:	90                   	nop
    for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40df4:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   40dfb:	00 
   40dfc:	48 81 7d e8 ff ff 2f 	cmpq   $0x2fffff,-0x18(%rbp)
   40e03:	00 
   40e04:	0f 86 8f fe ff ff    	jbe    40c99 <fork1+0x157>
        }
    }
    child->p_registers = parent->p_registers;
   40e0a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40e0e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40e12:	48 83 c0 08          	add    $0x8,%rax
   40e16:	48 83 c2 08          	add    $0x8,%rdx
   40e1a:	b9 18 00 00 00       	mov    $0x18,%ecx
   40e1f:	48 89 c7             	mov    %rax,%rdi
   40e22:	48 89 d6             	mov    %rdx,%rsi
   40e25:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    child->p_registers.reg_rax = 0; 
   40e28:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40e2c:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40e33:	00 
    child->p_state = P_RUNNABLE;
   40e34:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40e38:	c7 80 c8 00 00 00 01 	movl   $0x1,0xc8(%rax)
   40e3f:	00 00 00 
    current->p_registers.reg_rax = child_pid;
   40e42:	48 8b 05 b7 11 01 00 	mov    0x111b7(%rip),%rax        # 52000 <current>
   40e49:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40e4c:	48 63 d2             	movslq %edx,%rdx
   40e4f:	48 89 50 08          	mov    %rdx,0x8(%rax)
    return 0;
   40e53:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40e58:	c9                   	leave  
   40e59:	c3                   	ret    

0000000000040e5a <exception>:
void exception(x86_64_registers* reg) {
   40e5a:	f3 0f 1e fa          	endbr64 
   40e5e:	55                   	push   %rbp
   40e5f:	48 89 e5             	mov    %rsp,%rbp
   40e62:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   40e69:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40e70:	48 8b 05 89 11 01 00 	mov    0x11189(%rip),%rax        # 52000 <current>
   40e77:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   40e7e:	48 83 c0 08          	add    $0x8,%rax
   40e82:	48 89 d6             	mov    %rdx,%rsi
   40e85:	ba 18 00 00 00       	mov    $0x18,%edx
   40e8a:	48 89 c7             	mov    %rax,%rdi
   40e8d:	48 89 d1             	mov    %rdx,%rcx
   40e90:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40e93:	48 8b 05 66 41 01 00 	mov    0x14166(%rip),%rax        # 55000 <kernel_pagetable>
   40e9a:	48 89 c7             	mov    %rax,%rdi
   40e9d:	e8 69 22 00 00       	call   4310b <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40ea2:	8b 05 54 81 07 00    	mov    0x78154(%rip),%eax        # b8ffc <cursorpos>
   40ea8:	89 c7                	mov    %eax,%edi
   40eaa:	e8 e2 18 00 00       	call   42791 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40eaf:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40eb6:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40ebd:	48 83 f8 0e          	cmp    $0xe,%rax
   40ec1:	74 14                	je     40ed7 <exception+0x7d>
   40ec3:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40eca:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40ed1:	48 83 f8 0d          	cmp    $0xd,%rax
   40ed5:	75 16                	jne    40eed <exception+0x93>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40ed7:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40ede:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ee5:	83 e0 04             	and    $0x4,%eax
   40ee8:	48 85 c0             	test   %rax,%rax
   40eeb:	74 1a                	je     40f07 <exception+0xad>
    {
        check_virtual_memory();
   40eed:	e8 e5 08 00 00       	call   417d7 <check_virtual_memory>
        if(disp_global){
   40ef2:	0f b6 05 07 51 00 00 	movzbl 0x5107(%rip),%eax        # 46000 <disp_global>
   40ef9:	84 c0                	test   %al,%al
   40efb:	74 0a                	je     40f07 <exception+0xad>
            memshow_physical();
   40efd:	e8 9e 0a 00 00       	call   419a0 <memshow_physical>
            memshow_virtual_animate();
   40f02:	e8 3b 0e 00 00       	call   41d42 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40f07:	e8 9b 1d 00 00       	call   42ca7 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40f0c:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40f13:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40f1a:	48 83 e8 0e          	sub    $0xe,%rax
   40f1e:	48 83 f8 2a          	cmp    $0x2a,%rax
   40f22:	0f 87 62 03 00 00    	ja     4128a <exception+0x430>
   40f28:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   40f2f:	00 
   40f30:	48 8d 05 e9 3d 00 00 	lea    0x3de9(%rip),%rax        # 44d20 <console_clear+0x11c>
   40f37:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   40f3a:	48 98                	cltq   
   40f3c:	48 8d 15 dd 3d 00 00 	lea    0x3ddd(%rip),%rdx        # 44d20 <console_clear+0x11c>
   40f43:	48 01 d0             	add    %rdx,%rax
   40f46:	3e ff e0             	notrack jmp *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40f49:	48 8b 05 b0 10 01 00 	mov    0x110b0(%rip),%rax        # 52000 <current>
   40f50:	48 8b 40 38          	mov    0x38(%rax),%rax
   40f54:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
		if((void *)addr == NULL)
   40f58:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   40f5d:	75 0f                	jne    40f6e <exception+0x114>
		    panic(NULL);
   40f5f:	bf 00 00 00 00       	mov    $0x0,%edi
   40f64:	b8 00 00 00 00       	mov    $0x0,%eax
   40f69:	e8 9b 1e 00 00       	call   42e09 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40f6e:	48 8b 05 8b 10 01 00 	mov    0x1108b(%rip),%rax        # 52000 <current>
   40f75:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40f7c:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40f80:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40f84:	48 89 ce             	mov    %rcx,%rsi
   40f87:	48 89 c7             	mov    %rax,%rdi
   40f8a:	e8 38 27 00 00       	call   436c7 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40f8f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40f93:	48 89 c1             	mov    %rax,%rcx
   40f96:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
   40f9d:	ba a0 00 00 00       	mov    $0xa0,%edx
   40fa2:	48 89 ce             	mov    %rcx,%rsi
   40fa5:	48 89 c7             	mov    %rax,%rdi
   40fa8:	e8 9c 2b 00 00       	call   43b49 <memcpy>
		panic(msg);
   40fad:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
   40fb4:	48 89 c7             	mov    %rax,%rdi
   40fb7:	b8 00 00 00 00       	mov    $0x0,%eax
   40fbc:	e8 48 1e 00 00       	call   42e09 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40fc1:	48 8b 05 38 10 01 00 	mov    0x11038(%rip),%rax        # 52000 <current>
   40fc8:	8b 10                	mov    (%rax),%edx
   40fca:	48 8b 05 2f 10 01 00 	mov    0x1102f(%rip),%rax        # 52000 <current>
   40fd1:	48 63 d2             	movslq %edx,%rdx
   40fd4:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40fd8:	e9 bd 02 00 00       	jmp    4129a <exception+0x440>

    case INT_SYS_YIELD:
        schedule();
   40fdd:	e8 e1 02 00 00       	call   412c3 <schedule>
        break;                  /* will not be reached */
   40fe2:	e9 b3 02 00 00       	jmp    4129a <exception+0x440>

case INT_SYS_PAGE_ALLOC: {
    uintptr_t va = current->p_registers.reg_rdi;
   40fe7:	48 8b 05 12 10 01 00 	mov    0x11012(%rip),%rax        # 52000 <current>
   40fee:	48 8b 40 38          	mov    0x38(%rax),%rax
   40ff2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    // check allignment and bounds
    if (va % PAGESIZE != 0) {
   40ff6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ffa:	25 ff 0f 00 00       	and    $0xfff,%eax
   40fff:	48 85 c0             	test   %rax,%rax
   41002:	74 14                	je     41018 <exception+0x1be>
        current->p_registers.reg_rax = -1; 
   41004:	48 8b 05 f5 0f 01 00 	mov    0x10ff5(%rip),%rax        # 52000 <current>
   4100b:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   41012:	ff 
        break;
   41013:	e9 82 02 00 00       	jmp    4129a <exception+0x440>
    }
    if (va >= MEMSIZE_VIRTUAL) {
   41018:	48 81 7d f0 ff ff 2f 	cmpq   $0x2fffff,-0x10(%rbp)
   4101f:	00 
   41020:	76 14                	jbe    41036 <exception+0x1dc>
        current->p_registers.reg_rax = -1; 
   41022:	48 8b 05 d7 0f 01 00 	mov    0x10fd7(%rip),%rax        # 52000 <current>
   41029:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   41030:	ff 
        break;
   41031:	e9 64 02 00 00       	jmp    4129a <exception+0x440>
    }
    if (va < PROC_START_ADDR) {
   41036:	48 81 7d f0 ff ff 0f 	cmpq   $0xfffff,-0x10(%rbp)
   4103d:	00 
   4103e:	77 14                	ja     41054 <exception+0x1fa>
        current->p_registers.reg_rax = -1; 
   41040:	48 8b 05 b9 0f 01 00 	mov    0x10fb9(%rip),%rax        # 52000 <current>
   41047:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   4104e:	ff 
        break;
   4104f:	e9 46 02 00 00       	jmp    4129a <exception+0x440>
    }   
    uintptr_t pa = find_page(current->p_pid);
   41054:	48 8b 05 a5 0f 01 00 	mov    0x10fa5(%rip),%rax        # 52000 <current>
   4105b:	8b 00                	mov    (%rax),%eax
   4105d:	0f be c0             	movsbl %al,%eax
   41060:	89 c7                	mov    %eax,%edi
   41062:	e8 9d f3 ff ff       	call   40404 <find_page>
   41067:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (pa == 0) {
   4106b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   41070:	75 14                	jne    41086 <exception+0x22c>
        current->p_registers.reg_rax = -1; 
   41072:	48 8b 05 87 0f 01 00 	mov    0x10f87(%rip),%rax        # 52000 <current>
   41079:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   41080:	ff 
        break;
   41081:	e9 14 02 00 00       	jmp    4129a <exception+0x440>
    }
    int perm = PTE_P | PTE_W | PTE_U;
   41086:	c7 45 e4 07 00 00 00 	movl   $0x7,-0x1c(%rbp)

    int r = virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, perm);
   4108d:	48 8b 05 6c 0f 01 00 	mov    0x10f6c(%rip),%rax        # 52000 <current>
   41094:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4109b:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   4109e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   410a2:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   410a6:	41 89 c8             	mov    %ecx,%r8d
   410a9:	b9 00 10 00 00       	mov    $0x1000,%ecx
   410ae:	48 89 c7             	mov    %rax,%rdi
   410b1:	e8 c7 21 00 00       	call   4327d <virtual_memory_map>
   410b6:	89 45 e0             	mov    %eax,-0x20(%rbp)

    if (r != 0) {
   410b9:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
   410bd:	74 46                	je     41105 <exception+0x2ab>
        // If mapping fails, free the physical page
        pageinfo[PAGENUMBER(pa)].refcount = 0;
   410bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410c3:	48 c1 e8 0c          	shr    $0xc,%rax
   410c7:	48 98                	cltq   
   410c9:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   410cd:	48 8d 05 6d 1d 01 00 	lea    0x11d6d(%rip),%rax        # 52e41 <pageinfo+0x1>
   410d4:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(pa)].owner = PO_FREE;
   410d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410dc:	48 c1 e8 0c          	shr    $0xc,%rax
   410e0:	48 98                	cltq   
   410e2:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   410e6:	48 8d 05 53 1d 01 00 	lea    0x11d53(%rip),%rax        # 52e40 <pageinfo>
   410ed:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
        current->p_registers.reg_rax = -1;
   410f1:	48 8b 05 08 0f 01 00 	mov    0x10f08(%rip),%rax        # 52000 <current>
   410f8:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   410ff:	ff 
        break;
   41100:	e9 95 01 00 00       	jmp    4129a <exception+0x440>
    }

    // Success: Return 0
    current->p_registers.reg_rax = 0;
   41105:	48 8b 05 f4 0e 01 00 	mov    0x10ef4(%rip),%rax        # 52000 <current>
   4110c:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   41113:	00 
    break;
   41114:	e9 81 01 00 00       	jmp    4129a <exception+0x440>
}
// was helped by ULA's on SYS_FORK
case INT_SYS_FORK: {
    
    fork1();
   41119:	e8 24 fa ff ff       	call   40b42 <fork1>
    break;
   4111e:	e9 77 01 00 00       	jmp    4129a <exception+0x440>

    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   41123:	48 8b 05 d6 0e 01 00 	mov    0x10ed6(%rip),%rax        # 52000 <current>
   4112a:	48 89 c7             	mov    %rax,%rdi
   4112d:	e8 65 f7 ff ff       	call   40897 <syscall_mapping>
            break;
   41132:	e9 63 01 00 00       	jmp    4129a <exception+0x440>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   41137:	48 8b 05 c2 0e 01 00 	mov    0x10ec2(%rip),%rax        # 52000 <current>
   4113e:	48 89 c7             	mov    %rax,%rdi
   41141:	e8 1e f8 ff ff       	call   40964 <syscall_mem_tog>
	    break;
   41146:	e9 4f 01 00 00       	jmp    4129a <exception+0x440>
	}

    case INT_TIMER:
        ++ticks;
   4114b:	8b 05 cf 1c 01 00    	mov    0x11ccf(%rip),%eax        # 52e20 <ticks>
   41151:	83 c0 01             	add    $0x1,%eax
   41154:	89 05 c6 1c 01 00    	mov    %eax,0x11cc6(%rip)        # 52e20 <ticks>
        schedule();
   4115a:	e8 64 01 00 00       	call   412c3 <schedule>
        break;                  /* will not be reached */
   4115f:	e9 36 01 00 00       	jmp    4129a <exception+0x440>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   41164:	0f 20 d0             	mov    %cr2,%rax
   41167:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    return val;
   4116b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   4116f:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   41173:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   4117a:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   41181:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   41184:	48 85 c0             	test   %rax,%rax
   41187:	74 09                	je     41192 <exception+0x338>
   41189:	48 8d 05 00 3b 00 00 	lea    0x3b00(%rip),%rax        # 44c90 <console_clear+0x8c>
   41190:	eb 07                	jmp    41199 <exception+0x33f>
   41192:	48 8d 05 fd 3a 00 00 	lea    0x3afd(%rip),%rax        # 44c96 <console_clear+0x92>
        const char* operation = reg->reg_err & PFERR_WRITE
   41199:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   4119d:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   411a4:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   411ab:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   411ae:	48 85 c0             	test   %rax,%rax
   411b1:	74 09                	je     411bc <exception+0x362>
   411b3:	48 8d 05 e1 3a 00 00 	lea    0x3ae1(%rip),%rax        # 44c9b <console_clear+0x97>
   411ba:	eb 07                	jmp    411c3 <exception+0x369>
   411bc:	48 8d 05 eb 3a 00 00 	lea    0x3aeb(%rip),%rax        # 44cae <console_clear+0xaa>
        const char* problem = reg->reg_err & PFERR_PRESENT
   411c3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   411c7:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   411ce:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   411d5:	83 e0 04             	and    $0x4,%eax
   411d8:	48 85 c0             	test   %rax,%rax
   411db:	75 34                	jne    41211 <exception+0x3b7>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   411dd:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   411e4:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   411eb:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   411ef:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   411f3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   411f7:	49 89 f0             	mov    %rsi,%r8
   411fa:	48 89 c6             	mov    %rax,%rsi
   411fd:	48 8d 05 bc 3a 00 00 	lea    0x3abc(%rip),%rax        # 44cc0 <console_clear+0xbc>
   41204:	48 89 c7             	mov    %rax,%rdi
   41207:	b8 00 00 00 00       	mov    $0x0,%eax
   4120c:	e8 f8 1b 00 00       	call   42e09 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   41211:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   41218:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   4121f:	48 8b 05 da 0d 01 00 	mov    0x10dda(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   41226:	8b 00                	mov    (%rax),%eax
   41228:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
   4122c:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   41230:	52                   	push   %rdx
   41231:	ff 75 c0             	push   -0x40(%rbp)
   41234:	49 89 f1             	mov    %rsi,%r9
   41237:	49 89 c8             	mov    %rcx,%r8
   4123a:	89 c1                	mov    %eax,%ecx
   4123c:	48 8d 05 ad 3a 00 00 	lea    0x3aad(%rip),%rax        # 44cf0 <console_clear+0xec>
   41243:	48 89 c2             	mov    %rax,%rdx
   41246:	be 00 0c 00 00       	mov    $0xc00,%esi
   4124b:	bf 80 07 00 00       	mov    $0x780,%edi
   41250:	b8 00 00 00 00       	mov    $0x0,%eax
   41255:	e8 34 38 00 00       	call   44a8e <console_printf>
   4125a:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   4125e:	48 8b 05 9b 0d 01 00 	mov    0x10d9b(%rip),%rax        # 52000 <current>
   41265:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   4126c:	00 00 00 
        break;
   4126f:	eb 29                	jmp    4129a <exception+0x440>
    }

case INT_SYS_EXIT: {
    proc *p = current;
   41271:	48 8b 05 88 0d 01 00 	mov    0x10d88(%rip),%rax        # 52000 <current>
   41278:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    exit1(p);
   4127c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41280:	48 89 c7             	mov    %rax,%rdi
   41283:	e8 49 f7 ff ff       	call   409d1 <exit1>
    // current->p_registers.reg_rax = -1; 
    break;
   41288:	eb 10                	jmp    4129a <exception+0x440>
}



    default:
        default_exception(current);
   4128a:	48 8b 05 6f 0d 01 00 	mov    0x10d6f(%rip),%rax        # 52000 <current>
   41291:	48 89 c7             	mov    %rax,%rdi
   41294:	e8 99 1c 00 00       	call   42f32 <default_exception>
        break;                  /* will not be reached */
   41299:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   4129a:	48 8b 05 5f 0d 01 00 	mov    0x10d5f(%rip),%rax        # 52000 <current>
   412a1:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   412a7:	83 f8 01             	cmp    $0x1,%eax
   412aa:	75 0f                	jne    412bb <exception+0x461>
        run(current);
   412ac:	48 8b 05 4d 0d 01 00 	mov    0x10d4d(%rip),%rax        # 52000 <current>
   412b3:	48 89 c7             	mov    %rax,%rdi
   412b6:	e8 87 00 00 00       	call   41342 <run>
    } else {
        schedule();
   412bb:	e8 03 00 00 00       	call   412c3 <schedule>
    }
}
   412c0:	90                   	nop
   412c1:	c9                   	leave  
   412c2:	c3                   	ret    

00000000000412c3 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   412c3:	f3 0f 1e fa          	endbr64 
   412c7:	55                   	push   %rbp
   412c8:	48 89 e5             	mov    %rsp,%rbp
   412cb:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   412cf:	48 8b 05 2a 0d 01 00 	mov    0x10d2a(%rip),%rax        # 52000 <current>
   412d6:	8b 00                	mov    (%rax),%eax
   412d8:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   412db:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412de:	83 c0 01             	add    $0x1,%eax
   412e1:	99                   	cltd   
   412e2:	c1 ea 1c             	shr    $0x1c,%edx
   412e5:	01 d0                	add    %edx,%eax
   412e7:	83 e0 0f             	and    $0xf,%eax
   412ea:	29 d0                	sub    %edx,%eax
   412ec:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   412ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412f2:	48 63 d0             	movslq %eax,%rdx
   412f5:	48 89 d0             	mov    %rdx,%rax
   412f8:	48 c1 e0 03          	shl    $0x3,%rax
   412fc:	48 29 d0             	sub    %rdx,%rax
   412ff:	48 c1 e0 05          	shl    $0x5,%rax
   41303:	48 89 c2             	mov    %rax,%rdx
   41306:	48 8d 05 db 0d 01 00 	lea    0x10ddb(%rip),%rax        # 520e8 <processes+0xc8>
   4130d:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41310:	83 f8 01             	cmp    $0x1,%eax
   41313:	75 26                	jne    4133b <schedule+0x78>
            run(&processes[pid]);
   41315:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41318:	48 63 d0             	movslq %eax,%rdx
   4131b:	48 89 d0             	mov    %rdx,%rax
   4131e:	48 c1 e0 03          	shl    $0x3,%rax
   41322:	48 29 d0             	sub    %rdx,%rax
   41325:	48 c1 e0 05          	shl    $0x5,%rax
   41329:	48 8d 15 f0 0c 01 00 	lea    0x10cf0(%rip),%rdx        # 52020 <processes>
   41330:	48 01 d0             	add    %rdx,%rax
   41333:	48 89 c7             	mov    %rax,%rdi
   41336:	e8 07 00 00 00       	call   41342 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   4133b:	e8 67 19 00 00       	call   42ca7 <check_keyboard>
        pid = (pid + 1) % NPROC;
   41340:	eb 99                	jmp    412db <schedule+0x18>

0000000000041342 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   41342:	f3 0f 1e fa          	endbr64 
   41346:	55                   	push   %rbp
   41347:	48 89 e5             	mov    %rsp,%rbp
   4134a:	48 83 ec 10          	sub    $0x10,%rsp
   4134e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   41352:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41356:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   4135c:	83 f8 01             	cmp    $0x1,%eax
   4135f:	74 1e                	je     4137f <run+0x3d>
   41361:	48 8d 05 64 3a 00 00 	lea    0x3a64(%rip),%rax        # 44dcc <console_clear+0x1c8>
   41368:	48 89 c2             	mov    %rax,%rdx
   4136b:	be 39 02 00 00       	mov    $0x239,%esi
   41370:	48 8d 05 09 39 00 00 	lea    0x3909(%rip),%rax        # 44c80 <console_clear+0x7c>
   41377:	48 89 c7             	mov    %rax,%rdi
   4137a:	e8 7a 1b 00 00       	call   42ef9 <assert_fail>
    current = p;
   4137f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41383:	48 89 05 76 0c 01 00 	mov    %rax,0x10c76(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   4138a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4138e:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   41395:	48 89 c7             	mov    %rax,%rdi
   41398:	e8 6e 1d 00 00       	call   4310b <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   4139d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413a1:	48 83 c0 08          	add    $0x8,%rax
   413a5:	48 89 c7             	mov    %rax,%rdi
   413a8:	e8 16 ed ff ff       	call   400c3 <exception_return>

00000000000413ad <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   413ad:	f3 0f 1e fa          	endbr64 
   413b1:	55                   	push   %rbp
   413b2:	48 89 e5             	mov    %rsp,%rbp
   413b5:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   413b9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   413c0:	00 
   413c1:	e9 93 00 00 00       	jmp    41459 <pageinfo_init+0xac>
        int owner;
        if (physical_memory_isreserved(addr)) {
   413c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413ca:	48 89 c7             	mov    %rax,%rdi
   413cd:	e8 0f 11 00 00       	call   424e1 <physical_memory_isreserved>
   413d2:	85 c0                	test   %eax,%eax
   413d4:	74 09                	je     413df <pageinfo_init+0x32>
            owner = PO_RESERVED;
   413d6:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   413dd:	eb 31                	jmp    41410 <pageinfo_init+0x63>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   413df:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   413e6:	00 
   413e7:	76 0d                	jbe    413f6 <pageinfo_init+0x49>
   413e9:	48 8d 05 18 9c 01 00 	lea    0x19c18(%rip),%rax        # 5b008 <end>
   413f0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413f4:	72 0a                	jb     41400 <pageinfo_init+0x53>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   413f6:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   413fd:	00 
   413fe:	75 09                	jne    41409 <pageinfo_init+0x5c>
            owner = PO_KERNEL;
   41400:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   41407:	eb 07                	jmp    41410 <pageinfo_init+0x63>
        } else {
            owner = PO_FREE;
   41409:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   41410:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41414:	48 c1 e8 0c          	shr    $0xc,%rax
   41418:	89 c2                	mov    %eax,%edx
   4141a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4141d:	89 c1                	mov    %eax,%ecx
   4141f:	48 63 c2             	movslq %edx,%rax
   41422:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41426:	48 8d 05 13 1a 01 00 	lea    0x11a13(%rip),%rax        # 52e40 <pageinfo>
   4142d:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   41430:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41434:	0f 95 c2             	setne  %dl
   41437:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4143b:	48 c1 e8 0c          	shr    $0xc,%rax
   4143f:	89 d1                	mov    %edx,%ecx
   41441:	48 98                	cltq   
   41443:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41447:	48 8d 05 f3 19 01 00 	lea    0x119f3(%rip),%rax        # 52e41 <pageinfo+0x1>
   4144e:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   41451:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41458:	00 
   41459:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   41460:	00 
   41461:	0f 86 5f ff ff ff    	jbe    413c6 <pageinfo_init+0x19>
    }
}
   41467:	90                   	nop
   41468:	90                   	nop
   41469:	c9                   	leave  
   4146a:	c3                   	ret    

000000000004146b <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   4146b:	f3 0f 1e fa          	endbr64 
   4146f:	55                   	push   %rbp
   41470:	48 89 e5             	mov    %rsp,%rbp
   41473:	48 83 ec 50          	sub    $0x50,%rsp
   41477:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   4147b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4147f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41485:	48 89 c2             	mov    %rax,%rdx
   41488:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4148c:	48 39 c2             	cmp    %rax,%rdx
   4148f:	74 1e                	je     414af <check_page_table_mappings+0x44>
   41491:	48 8d 05 50 39 00 00 	lea    0x3950(%rip),%rax        # 44de8 <console_clear+0x1e4>
   41498:	48 89 c2             	mov    %rax,%rdx
   4149b:	be 63 02 00 00       	mov    $0x263,%esi
   414a0:	48 8d 05 d9 37 00 00 	lea    0x37d9(%rip),%rax        # 44c80 <console_clear+0x7c>
   414a7:	48 89 c7             	mov    %rax,%rdi
   414aa:	e8 4a 1a 00 00       	call   42ef9 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   414af:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   414b6:	00 
   414b7:	e9 b5 00 00 00       	jmp    41571 <check_page_table_mappings+0x106>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   414bc:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   414c0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   414c4:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   414c8:	48 89 ce             	mov    %rcx,%rsi
   414cb:	48 89 c7             	mov    %rax,%rdi
   414ce:	e8 f4 21 00 00       	call   436c7 <virtual_memory_lookup>
        if (vam.pa != va) {
   414d3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   414d7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   414db:	74 2c                	je     41509 <check_page_table_mappings+0x9e>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   414dd:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   414e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414e5:	49 89 d0             	mov    %rdx,%r8
   414e8:	48 89 c1             	mov    %rax,%rcx
   414eb:	48 8d 05 15 39 00 00 	lea    0x3915(%rip),%rax        # 44e07 <console_clear+0x203>
   414f2:	48 89 c2             	mov    %rax,%rdx
   414f5:	be 00 c0 00 00       	mov    $0xc000,%esi
   414fa:	bf e0 06 00 00       	mov    $0x6e0,%edi
   414ff:	b8 00 00 00 00       	mov    $0x0,%eax
   41504:	e8 85 35 00 00       	call   44a8e <console_printf>
        }
        assert(vam.pa == va);
   41509:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4150d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41511:	74 1e                	je     41531 <check_page_table_mappings+0xc6>
   41513:	48 8d 05 f7 38 00 00 	lea    0x38f7(%rip),%rax        # 44e11 <console_clear+0x20d>
   4151a:	48 89 c2             	mov    %rax,%rdx
   4151d:	be 6c 02 00 00       	mov    $0x26c,%esi
   41522:	48 8d 05 57 37 00 00 	lea    0x3757(%rip),%rax        # 44c80 <console_clear+0x7c>
   41529:	48 89 c7             	mov    %rax,%rdi
   4152c:	e8 c8 19 00 00       	call   42ef9 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   41531:	48 8d 05 c8 4a 00 00 	lea    0x4ac8(%rip),%rax        # 46000 <disp_global>
   41538:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4153c:	72 2b                	jb     41569 <check_page_table_mappings+0xfe>
            assert(vam.perm & PTE_W);
   4153e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41541:	48 98                	cltq   
   41543:	83 e0 02             	and    $0x2,%eax
   41546:	48 85 c0             	test   %rax,%rax
   41549:	75 1e                	jne    41569 <check_page_table_mappings+0xfe>
   4154b:	48 8d 05 cc 38 00 00 	lea    0x38cc(%rip),%rax        # 44e1e <console_clear+0x21a>
   41552:	48 89 c2             	mov    %rax,%rdx
   41555:	be 6e 02 00 00       	mov    $0x26e,%esi
   4155a:	48 8d 05 1f 37 00 00 	lea    0x371f(%rip),%rax        # 44c80 <console_clear+0x7c>
   41561:	48 89 c7             	mov    %rax,%rdi
   41564:	e8 90 19 00 00       	call   42ef9 <assert_fail>
         va += PAGESIZE) {
   41569:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41570:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41571:	48 8d 05 90 9a 01 00 	lea    0x19a90(%rip),%rax        # 5b008 <end>
   41578:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4157c:	0f 82 3a ff ff ff    	jb     414bc <check_page_table_mappings+0x51>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41582:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   41589:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   4158a:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   4158e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41592:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41596:	48 89 ce             	mov    %rcx,%rsi
   41599:	48 89 c7             	mov    %rax,%rdi
   4159c:	e8 26 21 00 00       	call   436c7 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   415a1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   415a5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   415a9:	74 1e                	je     415c9 <check_page_table_mappings+0x15e>
   415ab:	48 8d 05 7d 38 00 00 	lea    0x387d(%rip),%rax        # 44e2f <console_clear+0x22b>
   415b2:	48 89 c2             	mov    %rax,%rdx
   415b5:	be 75 02 00 00       	mov    $0x275,%esi
   415ba:	48 8d 05 bf 36 00 00 	lea    0x36bf(%rip),%rax        # 44c80 <console_clear+0x7c>
   415c1:	48 89 c7             	mov    %rax,%rdi
   415c4:	e8 30 19 00 00       	call   42ef9 <assert_fail>
    assert(vam.perm & PTE_W);
   415c9:	8b 45 e8             	mov    -0x18(%rbp),%eax
   415cc:	48 98                	cltq   
   415ce:	83 e0 02             	and    $0x2,%eax
   415d1:	48 85 c0             	test   %rax,%rax
   415d4:	75 1e                	jne    415f4 <check_page_table_mappings+0x189>
   415d6:	48 8d 05 41 38 00 00 	lea    0x3841(%rip),%rax        # 44e1e <console_clear+0x21a>
   415dd:	48 89 c2             	mov    %rax,%rdx
   415e0:	be 76 02 00 00       	mov    $0x276,%esi
   415e5:	48 8d 05 94 36 00 00 	lea    0x3694(%rip),%rax        # 44c80 <console_clear+0x7c>
   415ec:	48 89 c7             	mov    %rax,%rdi
   415ef:	e8 05 19 00 00       	call   42ef9 <assert_fail>
}
   415f4:	90                   	nop
   415f5:	c9                   	leave  
   415f6:	c3                   	ret    

00000000000415f7 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   415f7:	f3 0f 1e fa          	endbr64 
   415fb:	55                   	push   %rbp
   415fc:	48 89 e5             	mov    %rsp,%rbp
   415ff:	48 83 ec 20          	sub    $0x20,%rsp
   41603:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41607:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   4160a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4160d:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   41610:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41617:	48 8b 05 e2 39 01 00 	mov    0x139e2(%rip),%rax        # 55000 <kernel_pagetable>
   4161e:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41622:	75 71                	jne    41695 <check_page_table_ownership+0x9e>
        owner = PO_KERNEL;
   41624:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4162b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41632:	eb 5b                	jmp    4168f <check_page_table_ownership+0x98>
            if (processes[xpid].p_state != P_FREE
   41634:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41637:	48 63 d0             	movslq %eax,%rdx
   4163a:	48 89 d0             	mov    %rdx,%rax
   4163d:	48 c1 e0 03          	shl    $0x3,%rax
   41641:	48 29 d0             	sub    %rdx,%rax
   41644:	48 c1 e0 05          	shl    $0x5,%rax
   41648:	48 89 c2             	mov    %rax,%rdx
   4164b:	48 8d 05 96 0a 01 00 	lea    0x10a96(%rip),%rax        # 520e8 <processes+0xc8>
   41652:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41655:	85 c0                	test   %eax,%eax
   41657:	74 32                	je     4168b <check_page_table_ownership+0x94>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41659:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4165c:	48 63 d0             	movslq %eax,%rdx
   4165f:	48 89 d0             	mov    %rdx,%rax
   41662:	48 c1 e0 03          	shl    $0x3,%rax
   41666:	48 29 d0             	sub    %rdx,%rax
   41669:	48 c1 e0 05          	shl    $0x5,%rax
   4166d:	48 89 c2             	mov    %rax,%rdx
   41670:	48 8d 05 79 0a 01 00 	lea    0x10a79(%rip),%rax        # 520f0 <processes+0xd0>
   41677:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   4167b:	48 8b 05 7e 39 01 00 	mov    0x1397e(%rip),%rax        # 55000 <kernel_pagetable>
   41682:	48 39 c2             	cmp    %rax,%rdx
   41685:	75 04                	jne    4168b <check_page_table_ownership+0x94>
                ++expected_refcount;
   41687:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4168b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4168f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41693:	7e 9f                	jle    41634 <check_page_table_ownership+0x3d>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41695:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41698:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4169b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4169f:	be 00 00 00 00       	mov    $0x0,%esi
   416a4:	48 89 c7             	mov    %rax,%rdi
   416a7:	e8 03 00 00 00       	call   416af <check_page_table_ownership_level>
}
   416ac:	90                   	nop
   416ad:	c9                   	leave  
   416ae:	c3                   	ret    

00000000000416af <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   416af:	f3 0f 1e fa          	endbr64 
   416b3:	55                   	push   %rbp
   416b4:	48 89 e5             	mov    %rsp,%rbp
   416b7:	48 83 ec 30          	sub    $0x30,%rsp
   416bb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   416bf:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   416c2:	89 55 e0             	mov    %edx,-0x20(%rbp)
   416c5:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   416c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   416cc:	48 c1 e8 0c          	shr    $0xc,%rax
   416d0:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   416d5:	7e 1e                	jle    416f5 <check_page_table_ownership_level+0x46>
   416d7:	48 8d 05 62 37 00 00 	lea    0x3762(%rip),%rax        # 44e40 <console_clear+0x23c>
   416de:	48 89 c2             	mov    %rax,%rdx
   416e1:	be 93 02 00 00       	mov    $0x293,%esi
   416e6:	48 8d 05 93 35 00 00 	lea    0x3593(%rip),%rax        # 44c80 <console_clear+0x7c>
   416ed:	48 89 c7             	mov    %rax,%rdi
   416f0:	e8 04 18 00 00       	call   42ef9 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   416f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   416f9:	48 c1 e8 0c          	shr    $0xc,%rax
   416fd:	48 98                	cltq   
   416ff:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41703:	48 8d 05 36 17 01 00 	lea    0x11736(%rip),%rax        # 52e40 <pageinfo>
   4170a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4170e:	0f be c0             	movsbl %al,%eax
   41711:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41714:	74 1e                	je     41734 <check_page_table_ownership_level+0x85>
   41716:	48 8d 05 3b 37 00 00 	lea    0x373b(%rip),%rax        # 44e58 <console_clear+0x254>
   4171d:	48 89 c2             	mov    %rax,%rdx
   41720:	be 94 02 00 00       	mov    $0x294,%esi
   41725:	48 8d 05 54 35 00 00 	lea    0x3554(%rip),%rax        # 44c80 <console_clear+0x7c>
   4172c:	48 89 c7             	mov    %rax,%rdi
   4172f:	e8 c5 17 00 00       	call   42ef9 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41734:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41738:	48 c1 e8 0c          	shr    $0xc,%rax
   4173c:	48 98                	cltq   
   4173e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41742:	48 8d 05 f8 16 01 00 	lea    0x116f8(%rip),%rax        # 52e41 <pageinfo+0x1>
   41749:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4174d:	0f be c0             	movsbl %al,%eax
   41750:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41753:	74 1e                	je     41773 <check_page_table_ownership_level+0xc4>
   41755:	48 8d 05 24 37 00 00 	lea    0x3724(%rip),%rax        # 44e80 <console_clear+0x27c>
   4175c:	48 89 c2             	mov    %rax,%rdx
   4175f:	be 95 02 00 00       	mov    $0x295,%esi
   41764:	48 8d 05 15 35 00 00 	lea    0x3515(%rip),%rax        # 44c80 <console_clear+0x7c>
   4176b:	48 89 c7             	mov    %rax,%rdi
   4176e:	e8 86 17 00 00       	call   42ef9 <assert_fail>
    if (level < 3) {
   41773:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41777:	7f 5b                	jg     417d4 <check_page_table_ownership_level+0x125>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41779:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41780:	eb 49                	jmp    417cb <check_page_table_ownership_level+0x11c>
            if (pt->entry[index]) {
   41782:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41786:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41789:	48 63 d2             	movslq %edx,%rdx
   4178c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41790:	48 85 c0             	test   %rax,%rax
   41793:	74 32                	je     417c7 <check_page_table_ownership_level+0x118>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41795:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41799:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4179c:	48 63 d2             	movslq %edx,%rdx
   4179f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   417a3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   417a9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   417ad:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   417b0:	8d 70 01             	lea    0x1(%rax),%esi
   417b3:	8b 55 e0             	mov    -0x20(%rbp),%edx
   417b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   417ba:	b9 01 00 00 00       	mov    $0x1,%ecx
   417bf:	48 89 c7             	mov    %rax,%rdi
   417c2:	e8 e8 fe ff ff       	call   416af <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   417c7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   417cb:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   417d2:	7e ae                	jle    41782 <check_page_table_ownership_level+0xd3>
            }
        }
    }
}
   417d4:	90                   	nop
   417d5:	c9                   	leave  
   417d6:	c3                   	ret    

00000000000417d7 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   417d7:	f3 0f 1e fa          	endbr64 
   417db:	55                   	push   %rbp
   417dc:	48 89 e5             	mov    %rsp,%rbp
   417df:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   417e3:	8b 05 ff 08 01 00    	mov    0x108ff(%rip),%eax        # 520e8 <processes+0xc8>
   417e9:	85 c0                	test   %eax,%eax
   417eb:	74 1e                	je     4180b <check_virtual_memory+0x34>
   417ed:	48 8d 05 bc 36 00 00 	lea    0x36bc(%rip),%rax        # 44eb0 <console_clear+0x2ac>
   417f4:	48 89 c2             	mov    %rax,%rdx
   417f7:	be a8 02 00 00       	mov    $0x2a8,%esi
   417fc:	48 8d 05 7d 34 00 00 	lea    0x347d(%rip),%rax        # 44c80 <console_clear+0x7c>
   41803:	48 89 c7             	mov    %rax,%rdi
   41806:	e8 ee 16 00 00       	call   42ef9 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4180b:	48 8b 05 ee 37 01 00 	mov    0x137ee(%rip),%rax        # 55000 <kernel_pagetable>
   41812:	48 89 c7             	mov    %rax,%rdi
   41815:	e8 51 fc ff ff       	call   4146b <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4181a:	48 8b 05 df 37 01 00 	mov    0x137df(%rip),%rax        # 55000 <kernel_pagetable>
   41821:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41826:	48 89 c7             	mov    %rax,%rdi
   41829:	e8 c9 fd ff ff       	call   415f7 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   4182e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41835:	e9 b4 00 00 00       	jmp    418ee <check_virtual_memory+0x117>
        if (processes[pid].p_state != P_FREE
   4183a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4183d:	48 63 d0             	movslq %eax,%rdx
   41840:	48 89 d0             	mov    %rdx,%rax
   41843:	48 c1 e0 03          	shl    $0x3,%rax
   41847:	48 29 d0             	sub    %rdx,%rax
   4184a:	48 c1 e0 05          	shl    $0x5,%rax
   4184e:	48 89 c2             	mov    %rax,%rdx
   41851:	48 8d 05 90 08 01 00 	lea    0x10890(%rip),%rax        # 520e8 <processes+0xc8>
   41858:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4185b:	85 c0                	test   %eax,%eax
   4185d:	0f 84 87 00 00 00    	je     418ea <check_virtual_memory+0x113>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41863:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41866:	48 63 d0             	movslq %eax,%rdx
   41869:	48 89 d0             	mov    %rdx,%rax
   4186c:	48 c1 e0 03          	shl    $0x3,%rax
   41870:	48 29 d0             	sub    %rdx,%rax
   41873:	48 c1 e0 05          	shl    $0x5,%rax
   41877:	48 89 c2             	mov    %rax,%rdx
   4187a:	48 8d 05 6f 08 01 00 	lea    0x1086f(%rip),%rax        # 520f0 <processes+0xd0>
   41881:	48 8b 14 02          	mov    (%rdx,%rax,1),%rdx
   41885:	48 8b 05 74 37 01 00 	mov    0x13774(%rip),%rax        # 55000 <kernel_pagetable>
   4188c:	48 39 c2             	cmp    %rax,%rdx
   4188f:	74 59                	je     418ea <check_virtual_memory+0x113>
            check_page_table_mappings(processes[pid].p_pagetable);
   41891:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41894:	48 63 d0             	movslq %eax,%rdx
   41897:	48 89 d0             	mov    %rdx,%rax
   4189a:	48 c1 e0 03          	shl    $0x3,%rax
   4189e:	48 29 d0             	sub    %rdx,%rax
   418a1:	48 c1 e0 05          	shl    $0x5,%rax
   418a5:	48 89 c2             	mov    %rax,%rdx
   418a8:	48 8d 05 41 08 01 00 	lea    0x10841(%rip),%rax        # 520f0 <processes+0xd0>
   418af:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   418b3:	48 89 c7             	mov    %rax,%rdi
   418b6:	e8 b0 fb ff ff       	call   4146b <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   418bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418be:	48 63 d0             	movslq %eax,%rdx
   418c1:	48 89 d0             	mov    %rdx,%rax
   418c4:	48 c1 e0 03          	shl    $0x3,%rax
   418c8:	48 29 d0             	sub    %rdx,%rax
   418cb:	48 c1 e0 05          	shl    $0x5,%rax
   418cf:	48 89 c2             	mov    %rax,%rdx
   418d2:	48 8d 05 17 08 01 00 	lea    0x10817(%rip),%rax        # 520f0 <processes+0xd0>
   418d9:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   418dd:	8b 55 fc             	mov    -0x4(%rbp),%edx
   418e0:	89 d6                	mov    %edx,%esi
   418e2:	48 89 c7             	mov    %rax,%rdi
   418e5:	e8 0d fd ff ff       	call   415f7 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   418ea:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   418ee:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   418f2:	0f 8e 42 ff ff ff    	jle    4183a <check_virtual_memory+0x63>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   418f8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   418ff:	e9 8b 00 00 00       	jmp    4198f <check_virtual_memory+0x1b8>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41904:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41907:	48 98                	cltq   
   41909:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4190d:	48 8d 05 2d 15 01 00 	lea    0x1152d(%rip),%rax        # 52e41 <pageinfo+0x1>
   41914:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41918:	84 c0                	test   %al,%al
   4191a:	7e 6f                	jle    4198b <check_virtual_memory+0x1b4>
   4191c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4191f:	48 98                	cltq   
   41921:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41925:	48 8d 05 14 15 01 00 	lea    0x11514(%rip),%rax        # 52e40 <pageinfo>
   4192c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41930:	84 c0                	test   %al,%al
   41932:	78 57                	js     4198b <check_virtual_memory+0x1b4>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41934:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41937:	48 98                	cltq   
   41939:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   4193d:	48 8d 05 fc 14 01 00 	lea    0x114fc(%rip),%rax        # 52e40 <pageinfo>
   41944:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41948:	0f be c0             	movsbl %al,%eax
   4194b:	48 63 d0             	movslq %eax,%rdx
   4194e:	48 89 d0             	mov    %rdx,%rax
   41951:	48 c1 e0 03          	shl    $0x3,%rax
   41955:	48 29 d0             	sub    %rdx,%rax
   41958:	48 c1 e0 05          	shl    $0x5,%rax
   4195c:	48 89 c2             	mov    %rax,%rdx
   4195f:	48 8d 05 82 07 01 00 	lea    0x10782(%rip),%rax        # 520e8 <processes+0xc8>
   41966:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41969:	85 c0                	test   %eax,%eax
   4196b:	75 1e                	jne    4198b <check_virtual_memory+0x1b4>
   4196d:	48 8d 05 5c 35 00 00 	lea    0x355c(%rip),%rax        # 44ed0 <console_clear+0x2cc>
   41974:	48 89 c2             	mov    %rax,%rdx
   41977:	be bf 02 00 00       	mov    $0x2bf,%esi
   4197c:	48 8d 05 fd 32 00 00 	lea    0x32fd(%rip),%rax        # 44c80 <console_clear+0x7c>
   41983:	48 89 c7             	mov    %rax,%rdi
   41986:	e8 6e 15 00 00       	call   42ef9 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4198b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4198f:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41996:	0f 8e 68 ff ff ff    	jle    41904 <check_virtual_memory+0x12d>
        }
    }
}
   4199c:	90                   	nop
   4199d:	90                   	nop
   4199e:	c9                   	leave  
   4199f:	c3                   	ret    

00000000000419a0 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   419a0:	f3 0f 1e fa          	endbr64 
   419a4:	55                   	push   %rbp
   419a5:	48 89 e5             	mov    %rsp,%rbp
   419a8:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   419ac:	48 8d 05 73 35 00 00 	lea    0x3573(%rip),%rax        # 44f26 <memstate_colors+0x26>
   419b3:	48 89 c2             	mov    %rax,%rdx
   419b6:	be 00 0f 00 00       	mov    $0xf00,%esi
   419bb:	bf 20 00 00 00       	mov    $0x20,%edi
   419c0:	b8 00 00 00 00       	mov    $0x0,%eax
   419c5:	e8 c4 30 00 00       	call   44a8e <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   419ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   419d1:	e9 1b 01 00 00       	jmp    41af1 <memshow_physical+0x151>
        if (pn % 64 == 0) {
   419d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419d9:	83 e0 3f             	and    $0x3f,%eax
   419dc:	85 c0                	test   %eax,%eax
   419de:	75 40                	jne    41a20 <memshow_physical+0x80>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   419e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419e3:	c1 e0 0c             	shl    $0xc,%eax
   419e6:	89 c2                	mov    %eax,%edx
   419e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419eb:	8d 48 3f             	lea    0x3f(%rax),%ecx
   419ee:	85 c0                	test   %eax,%eax
   419f0:	0f 48 c1             	cmovs  %ecx,%eax
   419f3:	c1 f8 06             	sar    $0x6,%eax
   419f6:	8d 48 01             	lea    0x1(%rax),%ecx
   419f9:	89 c8                	mov    %ecx,%eax
   419fb:	c1 e0 02             	shl    $0x2,%eax
   419fe:	01 c8                	add    %ecx,%eax
   41a00:	c1 e0 04             	shl    $0x4,%eax
   41a03:	83 c0 03             	add    $0x3,%eax
   41a06:	89 d1                	mov    %edx,%ecx
   41a08:	48 8d 15 27 35 00 00 	lea    0x3527(%rip),%rdx        # 44f36 <memstate_colors+0x36>
   41a0f:	be 00 0f 00 00       	mov    $0xf00,%esi
   41a14:	89 c7                	mov    %eax,%edi
   41a16:	b8 00 00 00 00       	mov    $0x0,%eax
   41a1b:	e8 6e 30 00 00       	call   44a8e <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41a20:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a23:	48 98                	cltq   
   41a25:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41a29:	48 8d 05 10 14 01 00 	lea    0x11410(%rip),%rax        # 52e40 <pageinfo>
   41a30:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41a34:	0f be c0             	movsbl %al,%eax
   41a37:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41a3a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a3d:	48 98                	cltq   
   41a3f:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41a43:	48 8d 05 f7 13 01 00 	lea    0x113f7(%rip),%rax        # 52e41 <pageinfo+0x1>
   41a4a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41a4e:	84 c0                	test   %al,%al
   41a50:	75 07                	jne    41a59 <memshow_physical+0xb9>
            owner = PO_FREE;
   41a52:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41a59:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41a5c:	83 c0 02             	add    $0x2,%eax
   41a5f:	48 98                	cltq   
   41a61:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41a65:	48 8d 05 94 34 00 00 	lea    0x3494(%rip),%rax        # 44f00 <memstate_colors>
   41a6c:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41a70:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41a74:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a77:	48 98                	cltq   
   41a79:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41a7d:	48 8d 05 bd 13 01 00 	lea    0x113bd(%rip),%rax        # 52e41 <pageinfo+0x1>
   41a84:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41a88:	3c 01                	cmp    $0x1,%al
   41a8a:	7e 1c                	jle    41aa8 <memshow_physical+0x108>
   41a8c:	48 8d 05 6d 65 07 00 	lea    0x7656d(%rip),%rax        # b8000 <console>
   41a93:	48 c1 e8 0c          	shr    $0xc,%rax
   41a97:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41a9a:	74 0c                	je     41aa8 <memshow_physical+0x108>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41a9c:	b8 53 00 00 00       	mov    $0x53,%eax
   41aa1:	80 cc 0f             	or     $0xf,%ah
   41aa4:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41aa8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41aab:	8d 50 3f             	lea    0x3f(%rax),%edx
   41aae:	85 c0                	test   %eax,%eax
   41ab0:	0f 48 c2             	cmovs  %edx,%eax
   41ab3:	c1 f8 06             	sar    $0x6,%eax
   41ab6:	8d 50 01             	lea    0x1(%rax),%edx
   41ab9:	89 d0                	mov    %edx,%eax
   41abb:	c1 e0 02             	shl    $0x2,%eax
   41abe:	01 d0                	add    %edx,%eax
   41ac0:	c1 e0 04             	shl    $0x4,%eax
   41ac3:	89 c1                	mov    %eax,%ecx
   41ac5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ac8:	99                   	cltd   
   41ac9:	c1 ea 1a             	shr    $0x1a,%edx
   41acc:	01 d0                	add    %edx,%eax
   41ace:	83 e0 3f             	and    $0x3f,%eax
   41ad1:	29 d0                	sub    %edx,%eax
   41ad3:	83 c0 0c             	add    $0xc,%eax
   41ad6:	01 c8                	add    %ecx,%eax
   41ad8:	48 98                	cltq   
   41ada:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41ade:	48 8d 15 1b 65 07 00 	lea    0x7651b(%rip),%rdx        # b8000 <console>
   41ae5:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41ae9:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41aed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41af1:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41af8:	0f 8e d8 fe ff ff    	jle    419d6 <memshow_physical+0x36>
    }
}
   41afe:	90                   	nop
   41aff:	90                   	nop
   41b00:	c9                   	leave  
   41b01:	c3                   	ret    

0000000000041b02 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41b02:	f3 0f 1e fa          	endbr64 
   41b06:	55                   	push   %rbp
   41b07:	48 89 e5             	mov    %rsp,%rbp
   41b0a:	48 83 ec 40          	sub    $0x40,%rsp
   41b0e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41b12:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41b16:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41b1a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41b20:	48 89 c2             	mov    %rax,%rdx
   41b23:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41b27:	48 39 c2             	cmp    %rax,%rdx
   41b2a:	74 1e                	je     41b4a <memshow_virtual+0x48>
   41b2c:	48 8d 05 0d 34 00 00 	lea    0x340d(%rip),%rax        # 44f40 <memstate_colors+0x40>
   41b33:	48 89 c2             	mov    %rax,%rdx
   41b36:	be f0 02 00 00       	mov    $0x2f0,%esi
   41b3b:	48 8d 05 3e 31 00 00 	lea    0x313e(%rip),%rax        # 44c80 <console_clear+0x7c>
   41b42:	48 89 c7             	mov    %rax,%rdi
   41b45:	e8 af 13 00 00       	call   42ef9 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41b4a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41b4e:	48 89 c1             	mov    %rax,%rcx
   41b51:	48 8d 05 15 34 00 00 	lea    0x3415(%rip),%rax        # 44f6d <memstate_colors+0x6d>
   41b58:	48 89 c2             	mov    %rax,%rdx
   41b5b:	be 00 0f 00 00       	mov    $0xf00,%esi
   41b60:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41b65:	b8 00 00 00 00       	mov    $0x0,%eax
   41b6a:	e8 1f 2f 00 00       	call   44a8e <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41b6f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41b76:	00 
   41b77:	e9 b4 01 00 00       	jmp    41d30 <memshow_virtual+0x22e>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41b7c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41b80:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41b84:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41b88:	48 89 ce             	mov    %rcx,%rsi
   41b8b:	48 89 c7             	mov    %rax,%rdi
   41b8e:	e8 34 1b 00 00       	call   436c7 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41b93:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41b96:	85 c0                	test   %eax,%eax
   41b98:	79 0b                	jns    41ba5 <memshow_virtual+0xa3>
            color = ' ';
   41b9a:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41ba0:	e9 ff 00 00 00       	jmp    41ca4 <memshow_virtual+0x1a2>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41ba5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41ba9:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41baf:	76 1e                	jbe    41bcf <memshow_virtual+0xcd>
   41bb1:	48 8d 05 d2 33 00 00 	lea    0x33d2(%rip),%rax        # 44f8a <memstate_colors+0x8a>
   41bb8:	48 89 c2             	mov    %rax,%rdx
   41bbb:	be f9 02 00 00       	mov    $0x2f9,%esi
   41bc0:	48 8d 05 b9 30 00 00 	lea    0x30b9(%rip),%rax        # 44c80 <console_clear+0x7c>
   41bc7:	48 89 c7             	mov    %rax,%rdi
   41bca:	e8 2a 13 00 00       	call   42ef9 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41bcf:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41bd2:	48 98                	cltq   
   41bd4:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41bd8:	48 8d 05 61 12 01 00 	lea    0x11261(%rip),%rax        # 52e40 <pageinfo>
   41bdf:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41be3:	0f be c0             	movsbl %al,%eax
   41be6:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41be9:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41bec:	48 98                	cltq   
   41bee:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41bf2:	48 8d 05 48 12 01 00 	lea    0x11248(%rip),%rax        # 52e41 <pageinfo+0x1>
   41bf9:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41bfd:	84 c0                	test   %al,%al
   41bff:	75 07                	jne    41c08 <memshow_virtual+0x106>
                owner = PO_FREE;
   41c01:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41c08:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c0b:	83 c0 02             	add    $0x2,%eax
   41c0e:	48 98                	cltq   
   41c10:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41c14:	48 8d 05 e5 32 00 00 	lea    0x32e5(%rip),%rax        # 44f00 <memstate_colors>
   41c1b:	0f b7 04 02          	movzwl (%rdx,%rax,1),%eax
   41c1f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41c23:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41c26:	48 98                	cltq   
   41c28:	83 e0 04             	and    $0x4,%eax
   41c2b:	48 85 c0             	test   %rax,%rax
   41c2e:	74 27                	je     41c57 <memshow_virtual+0x155>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41c30:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c34:	c1 e0 04             	shl    $0x4,%eax
   41c37:	66 25 00 f0          	and    $0xf000,%ax
   41c3b:	89 c2                	mov    %eax,%edx
   41c3d:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c41:	c1 f8 04             	sar    $0x4,%eax
   41c44:	66 25 00 0f          	and    $0xf00,%ax
   41c48:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41c4a:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c4e:	0f b6 c0             	movzbl %al,%eax
   41c51:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41c53:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41c57:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41c5a:	48 98                	cltq   
   41c5c:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   41c60:	48 8d 05 da 11 01 00 	lea    0x111da(%rip),%rax        # 52e41 <pageinfo+0x1>
   41c67:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41c6b:	3c 01                	cmp    $0x1,%al
   41c6d:	7e 35                	jle    41ca4 <memshow_virtual+0x1a2>
   41c6f:	48 8d 05 8a 63 07 00 	lea    0x7638a(%rip),%rax        # b8000 <console>
   41c76:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41c7a:	74 28                	je     41ca4 <memshow_virtual+0x1a2>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41c7c:	b8 53 00 00 00       	mov    $0x53,%eax
   41c81:	89 c2                	mov    %eax,%edx
   41c83:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41c87:	66 25 00 f0          	and    $0xf000,%ax
   41c8b:	09 d0                	or     %edx,%eax
   41c8d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41c91:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41c94:	48 98                	cltq   
   41c96:	83 e0 04             	and    $0x4,%eax
   41c99:	48 85 c0             	test   %rax,%rax
   41c9c:	75 06                	jne    41ca4 <memshow_virtual+0x1a2>
                    color = color | 0x0F00;
   41c9e:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41ca4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ca8:	48 c1 e8 0c          	shr    $0xc,%rax
   41cac:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41caf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41cb2:	83 e0 3f             	and    $0x3f,%eax
   41cb5:	85 c0                	test   %eax,%eax
   41cb7:	75 39                	jne    41cf2 <memshow_virtual+0x1f0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41cb9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41cbc:	c1 e8 06             	shr    $0x6,%eax
   41cbf:	89 c2                	mov    %eax,%edx
   41cc1:	89 d0                	mov    %edx,%eax
   41cc3:	c1 e0 02             	shl    $0x2,%eax
   41cc6:	01 d0                	add    %edx,%eax
   41cc8:	c1 e0 04             	shl    $0x4,%eax
   41ccb:	05 73 03 00 00       	add    $0x373,%eax
   41cd0:	89 c7                	mov    %eax,%edi
   41cd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41cd6:	48 89 c1             	mov    %rax,%rcx
   41cd9:	48 8d 05 56 32 00 00 	lea    0x3256(%rip),%rax        # 44f36 <memstate_colors+0x36>
   41ce0:	48 89 c2             	mov    %rax,%rdx
   41ce3:	be 00 0f 00 00       	mov    $0xf00,%esi
   41ce8:	b8 00 00 00 00       	mov    $0x0,%eax
   41ced:	e8 9c 2d 00 00       	call   44a8e <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41cf2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41cf5:	c1 e8 06             	shr    $0x6,%eax
   41cf8:	89 c2                	mov    %eax,%edx
   41cfa:	89 d0                	mov    %edx,%eax
   41cfc:	c1 e0 02             	shl    $0x2,%eax
   41cff:	01 d0                	add    %edx,%eax
   41d01:	c1 e0 04             	shl    $0x4,%eax
   41d04:	89 c2                	mov    %eax,%edx
   41d06:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41d09:	83 e0 3f             	and    $0x3f,%eax
   41d0c:	01 d0                	add    %edx,%eax
   41d0e:	05 7c 03 00 00       	add    $0x37c,%eax
   41d13:	89 c0                	mov    %eax,%eax
   41d15:	48 8d 0c 00          	lea    (%rax,%rax,1),%rcx
   41d19:	48 8d 15 e0 62 07 00 	lea    0x762e0(%rip),%rdx        # b8000 <console>
   41d20:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41d24:	66 89 04 11          	mov    %ax,(%rcx,%rdx,1)
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41d28:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41d2f:	00 
   41d30:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41d37:	00 
   41d38:	0f 86 3e fe ff ff    	jbe    41b7c <memshow_virtual+0x7a>
    }
}
   41d3e:	90                   	nop
   41d3f:	90                   	nop
   41d40:	c9                   	leave  
   41d41:	c3                   	ret    

0000000000041d42 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41d42:	f3 0f 1e fa          	endbr64 
   41d46:	55                   	push   %rbp
   41d47:	48 89 e5             	mov    %rsp,%rbp
   41d4a:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41d4e:	8b 05 ec 14 01 00    	mov    0x114ec(%rip),%eax        # 53240 <last_ticks.1>
   41d54:	85 c0                	test   %eax,%eax
   41d56:	74 13                	je     41d6b <memshow_virtual_animate+0x29>
   41d58:	8b 05 c2 10 01 00    	mov    0x110c2(%rip),%eax        # 52e20 <ticks>
   41d5e:	8b 15 dc 14 01 00    	mov    0x114dc(%rip),%edx        # 53240 <last_ticks.1>
   41d64:	29 d0                	sub    %edx,%eax
   41d66:	83 f8 31             	cmp    $0x31,%eax
   41d69:	76 2c                	jbe    41d97 <memshow_virtual_animate+0x55>
        last_ticks = ticks;
   41d6b:	8b 05 af 10 01 00    	mov    0x110af(%rip),%eax        # 52e20 <ticks>
   41d71:	89 05 c9 14 01 00    	mov    %eax,0x114c9(%rip)        # 53240 <last_ticks.1>
        ++showing;
   41d77:	8b 05 87 42 00 00    	mov    0x4287(%rip),%eax        # 46004 <showing.0>
   41d7d:	83 c0 01             	add    $0x1,%eax
   41d80:	89 05 7e 42 00 00    	mov    %eax,0x427e(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41d86:	eb 0f                	jmp    41d97 <memshow_virtual_animate+0x55>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41d88:	8b 05 76 42 00 00    	mov    0x4276(%rip),%eax        # 46004 <showing.0>
   41d8e:	83 c0 01             	add    $0x1,%eax
   41d91:	89 05 6d 42 00 00    	mov    %eax,0x426d(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41d97:	8b 05 67 42 00 00    	mov    0x4267(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41d9d:	83 f8 20             	cmp    $0x20,%eax
   41da0:	7f 6b                	jg     41e0d <memshow_virtual_animate+0xcb>
   41da2:	8b 05 5c 42 00 00    	mov    0x425c(%rip),%eax        # 46004 <showing.0>
   41da8:	99                   	cltd   
   41da9:	c1 ea 1c             	shr    $0x1c,%edx
   41dac:	01 d0                	add    %edx,%eax
   41dae:	83 e0 0f             	and    $0xf,%eax
   41db1:	29 d0                	sub    %edx,%eax
   41db3:	48 63 d0             	movslq %eax,%rdx
   41db6:	48 89 d0             	mov    %rdx,%rax
   41db9:	48 c1 e0 03          	shl    $0x3,%rax
   41dbd:	48 29 d0             	sub    %rdx,%rax
   41dc0:	48 c1 e0 05          	shl    $0x5,%rax
   41dc4:	48 89 c2             	mov    %rax,%rdx
   41dc7:	48 8d 05 1a 03 01 00 	lea    0x1031a(%rip),%rax        # 520e8 <processes+0xc8>
   41dce:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41dd1:	85 c0                	test   %eax,%eax
   41dd3:	74 b3                	je     41d88 <memshow_virtual_animate+0x46>
   41dd5:	8b 05 29 42 00 00    	mov    0x4229(%rip),%eax        # 46004 <showing.0>
   41ddb:	99                   	cltd   
   41ddc:	c1 ea 1c             	shr    $0x1c,%edx
   41ddf:	01 d0                	add    %edx,%eax
   41de1:	83 e0 0f             	and    $0xf,%eax
   41de4:	29 d0                	sub    %edx,%eax
   41de6:	48 63 d0             	movslq %eax,%rdx
   41de9:	48 89 d0             	mov    %rdx,%rax
   41dec:	48 c1 e0 03          	shl    $0x3,%rax
   41df0:	48 29 d0             	sub    %rdx,%rax
   41df3:	48 c1 e0 05          	shl    $0x5,%rax
   41df7:	48 89 c2             	mov    %rax,%rdx
   41dfa:	48 8d 05 f7 02 01 00 	lea    0x102f7(%rip),%rax        # 520f8 <processes+0xd8>
   41e01:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   41e05:	84 c0                	test   %al,%al
   41e07:	0f 84 7b ff ff ff    	je     41d88 <memshow_virtual_animate+0x46>
    }
    showing = showing % NPROC;
   41e0d:	8b 05 f1 41 00 00    	mov    0x41f1(%rip),%eax        # 46004 <showing.0>
   41e13:	99                   	cltd   
   41e14:	c1 ea 1c             	shr    $0x1c,%edx
   41e17:	01 d0                	add    %edx,%eax
   41e19:	83 e0 0f             	and    $0xf,%eax
   41e1c:	29 d0                	sub    %edx,%eax
   41e1e:	89 05 e0 41 00 00    	mov    %eax,0x41e0(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41e24:	8b 05 da 41 00 00    	mov    0x41da(%rip),%eax        # 46004 <showing.0>
   41e2a:	48 63 d0             	movslq %eax,%rdx
   41e2d:	48 89 d0             	mov    %rdx,%rax
   41e30:	48 c1 e0 03          	shl    $0x3,%rax
   41e34:	48 29 d0             	sub    %rdx,%rax
   41e37:	48 c1 e0 05          	shl    $0x5,%rax
   41e3b:	48 89 c2             	mov    %rax,%rdx
   41e3e:	48 8d 05 a3 02 01 00 	lea    0x102a3(%rip),%rax        # 520e8 <processes+0xc8>
   41e45:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   41e48:	85 c0                	test   %eax,%eax
   41e4a:	74 59                	je     41ea5 <memshow_virtual_animate+0x163>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41e4c:	8b 15 b2 41 00 00    	mov    0x41b2(%rip),%edx        # 46004 <showing.0>
   41e52:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41e56:	89 d1                	mov    %edx,%ecx
   41e58:	48 8d 15 45 31 00 00 	lea    0x3145(%rip),%rdx        # 44fa4 <memstate_colors+0xa4>
   41e5f:	be 04 00 00 00       	mov    $0x4,%esi
   41e64:	48 89 c7             	mov    %rax,%rdi
   41e67:	b8 00 00 00 00       	mov    $0x0,%eax
   41e6c:	e8 38 2d 00 00       	call   44ba9 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41e71:	8b 05 8d 41 00 00    	mov    0x418d(%rip),%eax        # 46004 <showing.0>
   41e77:	48 63 d0             	movslq %eax,%rdx
   41e7a:	48 89 d0             	mov    %rdx,%rax
   41e7d:	48 c1 e0 03          	shl    $0x3,%rax
   41e81:	48 29 d0             	sub    %rdx,%rax
   41e84:	48 c1 e0 05          	shl    $0x5,%rax
   41e88:	48 89 c2             	mov    %rax,%rdx
   41e8b:	48 8d 05 5e 02 01 00 	lea    0x1025e(%rip),%rax        # 520f0 <processes+0xd0>
   41e92:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   41e96:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41e9a:	48 89 d6             	mov    %rdx,%rsi
   41e9d:	48 89 c7             	mov    %rax,%rdi
   41ea0:	e8 5d fc ff ff       	call   41b02 <memshow_virtual>
    }
}
   41ea5:	90                   	nop
   41ea6:	c9                   	leave  
   41ea7:	c3                   	ret    

0000000000041ea8 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41ea8:	f3 0f 1e fa          	endbr64 
   41eac:	55                   	push   %rbp
   41ead:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41eb0:	e8 5f 01 00 00       	call   42014 <segments_init>
    interrupt_init();
   41eb5:	e8 44 04 00 00       	call   422fe <interrupt_init>
    virtual_memory_init();
   41eba:	e8 11 11 00 00       	call   42fd0 <virtual_memory_init>
}
   41ebf:	90                   	nop
   41ec0:	5d                   	pop    %rbp
   41ec1:	c3                   	ret    

0000000000041ec2 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41ec2:	f3 0f 1e fa          	endbr64 
   41ec6:	55                   	push   %rbp
   41ec7:	48 89 e5             	mov    %rsp,%rbp
   41eca:	48 83 ec 18          	sub    $0x18,%rsp
   41ece:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41ed2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41ed6:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41ed9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41edc:	48 98                	cltq   
   41ede:	48 c1 e0 2d          	shl    $0x2d,%rax
   41ee2:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41ee6:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41eed:	90 00 00 
   41ef0:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41ef3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ef7:	48 89 10             	mov    %rdx,(%rax)
}
   41efa:	90                   	nop
   41efb:	c9                   	leave  
   41efc:	c3                   	ret    

0000000000041efd <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41efd:	f3 0f 1e fa          	endbr64 
   41f01:	55                   	push   %rbp
   41f02:	48 89 e5             	mov    %rsp,%rbp
   41f05:	48 83 ec 28          	sub    $0x28,%rsp
   41f09:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41f0d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41f11:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41f14:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41f18:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41f1c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41f20:	48 c1 e0 10          	shl    $0x10,%rax
   41f24:	48 89 c2             	mov    %rax,%rdx
   41f27:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41f2e:	00 00 00 
   41f31:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41f34:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41f38:	48 c1 e0 20          	shl    $0x20,%rax
   41f3c:	48 89 c1             	mov    %rax,%rcx
   41f3f:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41f46:	00 00 ff 
   41f49:	48 21 c8             	and    %rcx,%rax
   41f4c:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41f4f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41f53:	48 83 e8 01          	sub    $0x1,%rax
   41f57:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41f5a:	48 09 d0             	or     %rdx,%rax
        | type
   41f5d:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41f61:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41f64:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41f67:	48 98                	cltq   
   41f69:	48 c1 e0 2d          	shl    $0x2d,%rax
   41f6d:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41f70:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41f77:	80 00 00 
   41f7a:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41f7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f81:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41f84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f88:	48 83 c0 08          	add    $0x8,%rax
   41f8c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41f90:	48 c1 ea 20          	shr    $0x20,%rdx
   41f94:	48 89 10             	mov    %rdx,(%rax)
}
   41f97:	90                   	nop
   41f98:	c9                   	leave  
   41f99:	c3                   	ret    

0000000000041f9a <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41f9a:	f3 0f 1e fa          	endbr64 
   41f9e:	55                   	push   %rbp
   41f9f:	48 89 e5             	mov    %rsp,%rbp
   41fa2:	48 83 ec 20          	sub    $0x20,%rsp
   41fa6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41faa:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41fae:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41fb1:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41fb5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41fb9:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41fbc:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41fc0:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41fc3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41fc6:	48 98                	cltq   
   41fc8:	48 c1 e0 2d          	shl    $0x2d,%rax
   41fcc:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41fcf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41fd3:	48 c1 e0 20          	shl    $0x20,%rax
   41fd7:	48 89 c1             	mov    %rax,%rcx
   41fda:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41fe1:	00 ff ff 
   41fe4:	48 21 c8             	and    %rcx,%rax
   41fe7:	48 09 c2             	or     %rax,%rdx
   41fea:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41ff1:	80 00 00 
   41ff4:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41ff7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ffb:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41ffe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42002:	48 c1 e8 20          	shr    $0x20,%rax
   42006:	48 89 c2             	mov    %rax,%rdx
   42009:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4200d:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   42011:	90                   	nop
   42012:	c9                   	leave  
   42013:	c3                   	ret    

0000000000042014 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   42014:	f3 0f 1e fa          	endbr64 
   42018:	55                   	push   %rbp
   42019:	48 89 e5             	mov    %rsp,%rbp
   4201c:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   42020:	48 c7 05 35 12 01 00 	movq   $0x0,0x11235(%rip)        # 53260 <segments>
   42027:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   4202b:	ba 00 00 00 00       	mov    $0x0,%edx
   42030:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   42037:	08 20 00 
   4203a:	48 89 c6             	mov    %rax,%rsi
   4203d:	48 8d 05 24 12 01 00 	lea    0x11224(%rip),%rax        # 53268 <segments+0x8>
   42044:	48 89 c7             	mov    %rax,%rdi
   42047:	e8 76 fe ff ff       	call   41ec2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   4204c:	ba 03 00 00 00       	mov    $0x3,%edx
   42051:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   42058:	08 20 00 
   4205b:	48 89 c6             	mov    %rax,%rsi
   4205e:	48 8d 05 0b 12 01 00 	lea    0x1120b(%rip),%rax        # 53270 <segments+0x10>
   42065:	48 89 c7             	mov    %rax,%rdi
   42068:	e8 55 fe ff ff       	call   41ec2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4206d:	ba 00 00 00 00       	mov    $0x0,%edx
   42072:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   42079:	02 00 00 
   4207c:	48 89 c6             	mov    %rax,%rsi
   4207f:	48 8d 05 f2 11 01 00 	lea    0x111f2(%rip),%rax        # 53278 <segments+0x18>
   42086:	48 89 c7             	mov    %rax,%rdi
   42089:	e8 34 fe ff ff       	call   41ec2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   4208e:	ba 03 00 00 00       	mov    $0x3,%edx
   42093:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   4209a:	02 00 00 
   4209d:	48 89 c6             	mov    %rax,%rsi
   420a0:	48 8d 05 d9 11 01 00 	lea    0x111d9(%rip),%rax        # 53280 <segments+0x20>
   420a7:	48 89 c7             	mov    %rax,%rdi
   420aa:	e8 13 fe ff ff       	call   41ec2 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   420af:	48 8d 05 ea 21 01 00 	lea    0x121ea(%rip),%rax        # 542a0 <kernel_task_descriptor>
   420b6:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   420bc:	48 89 c1             	mov    %rax,%rcx
   420bf:	ba 00 00 00 00       	mov    $0x0,%edx
   420c4:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   420cb:	09 00 00 
   420ce:	48 89 c6             	mov    %rax,%rsi
   420d1:	48 8d 05 b0 11 01 00 	lea    0x111b0(%rip),%rax        # 53288 <segments+0x28>
   420d8:	48 89 c7             	mov    %rax,%rdi
   420db:	e8 1d fe ff ff       	call   41efd <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   420e0:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   420e6:	48 8d 05 73 11 01 00 	lea    0x11173(%rip),%rax        # 53260 <segments>
   420ed:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   420f1:	ba 60 00 00 00       	mov    $0x60,%edx
   420f6:	be 00 00 00 00       	mov    $0x0,%esi
   420fb:	48 8d 05 9e 21 01 00 	lea    0x1219e(%rip),%rax        # 542a0 <kernel_task_descriptor>
   42102:	48 89 c7             	mov    %rax,%rdi
   42105:	e8 45 1b 00 00       	call   43c4f <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   4210a:	48 c7 05 8f 21 01 00 	movq   $0x80000,0x1218f(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   42111:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   42115:	ba 00 10 00 00       	mov    $0x1000,%edx
   4211a:	be 00 00 00 00       	mov    $0x0,%esi
   4211f:	48 8d 05 7a 11 01 00 	lea    0x1117a(%rip),%rax        # 532a0 <interrupt_descriptors>
   42126:	48 89 c7             	mov    %rax,%rdi
   42129:	e8 21 1b 00 00       	call   43c4f <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4212e:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   42135:	eb 3c                	jmp    42173 <segments_init+0x15f>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   42137:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   4213e:	48 89 c2             	mov    %rax,%rdx
   42141:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42144:	48 c1 e0 04          	shl    $0x4,%rax
   42148:	48 89 c1             	mov    %rax,%rcx
   4214b:	48 8d 05 4e 11 01 00 	lea    0x1114e(%rip),%rax        # 532a0 <interrupt_descriptors>
   42152:	48 01 c8             	add    %rcx,%rax
   42155:	48 89 d1             	mov    %rdx,%rcx
   42158:	ba 00 00 00 00       	mov    $0x0,%edx
   4215d:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   42164:	0e 00 00 
   42167:	48 89 c7             	mov    %rax,%rdi
   4216a:	e8 2b fe ff ff       	call   41f9a <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4216f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42173:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   4217a:	76 bb                	jbe    42137 <segments_init+0x123>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   4217c:	48 c7 c0 36 00 04 00 	mov    $0x40036,%rax
   42183:	48 89 c1             	mov    %rax,%rcx
   42186:	ba 00 00 00 00       	mov    $0x0,%edx
   4218b:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   42192:	0e 00 00 
   42195:	48 89 c6             	mov    %rax,%rsi
   42198:	48 8d 05 01 13 01 00 	lea    0x11301(%rip),%rax        # 534a0 <interrupt_descriptors+0x200>
   4219f:	48 89 c7             	mov    %rax,%rdi
   421a2:	e8 f3 fd ff ff       	call   41f9a <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   421a7:	48 c7 c0 2e 00 04 00 	mov    $0x4002e,%rax
   421ae:	48 89 c1             	mov    %rax,%rcx
   421b1:	ba 00 00 00 00       	mov    $0x0,%edx
   421b6:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   421bd:	0e 00 00 
   421c0:	48 89 c6             	mov    %rax,%rsi
   421c3:	48 8d 05 a6 11 01 00 	lea    0x111a6(%rip),%rax        # 53370 <interrupt_descriptors+0xd0>
   421ca:	48 89 c7             	mov    %rax,%rdi
   421cd:	e8 c8 fd ff ff       	call   41f9a <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   421d2:	48 c7 c0 32 00 04 00 	mov    $0x40032,%rax
   421d9:	48 89 c1             	mov    %rax,%rcx
   421dc:	ba 00 00 00 00       	mov    $0x0,%edx
   421e1:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   421e8:	0e 00 00 
   421eb:	48 89 c6             	mov    %rax,%rsi
   421ee:	48 8d 05 8b 11 01 00 	lea    0x1118b(%rip),%rax        # 53380 <interrupt_descriptors+0xe0>
   421f5:	48 89 c7             	mov    %rax,%rdi
   421f8:	e8 9d fd ff ff       	call   41f9a <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   421fd:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   42204:	eb 50                	jmp    42256 <segments_init+0x242>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   42206:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42209:	83 e8 30             	sub    $0x30,%eax
   4220c:	89 c0                	mov    %eax,%eax
   4220e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   42215:	00 
   42216:	48 8d 05 ca de ff ff 	lea    -0x2136(%rip),%rax        # 400e7 <sys_int_handlers>
   4221d:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   42221:	48 89 c2             	mov    %rax,%rdx
   42224:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42227:	48 c1 e0 04          	shl    $0x4,%rax
   4222b:	48 89 c1             	mov    %rax,%rcx
   4222e:	48 8d 05 6b 10 01 00 	lea    0x1106b(%rip),%rax        # 532a0 <interrupt_descriptors>
   42235:	48 01 c8             	add    %rcx,%rax
   42238:	48 89 d1             	mov    %rdx,%rcx
   4223b:	ba 03 00 00 00       	mov    $0x3,%edx
   42240:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   42247:	0e 00 00 
   4224a:	48 89 c7             	mov    %rax,%rdi
   4224d:	e8 48 fd ff ff       	call   41f9a <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   42252:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42256:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   4225a:	76 aa                	jbe    42206 <segments_init+0x1f2>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4225c:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   42262:	48 8d 05 37 10 01 00 	lea    0x11037(%rip),%rax        # 532a0 <interrupt_descriptors>
   42269:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   4226d:	b8 28 00 00 00       	mov    $0x28,%eax
   42272:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   42276:	0f 00 d8             	ltr    %ax
   42279:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4227d:	0f 20 c0             	mov    %cr0,%rax
   42280:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   42284:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   42288:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   4228b:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   42292:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42295:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   42298:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4229b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   4229f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   422a3:	0f 22 c0             	mov    %rax,%cr0
}
   422a6:	90                   	nop
    lcr0(cr0);
}
   422a7:	90                   	nop
   422a8:	c9                   	leave  
   422a9:	c3                   	ret    

00000000000422aa <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   422aa:	f3 0f 1e fa          	endbr64 
   422ae:	55                   	push   %rbp
   422af:	48 89 e5             	mov    %rsp,%rbp
   422b2:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   422b6:	0f b7 05 43 20 01 00 	movzwl 0x12043(%rip),%eax        # 54300 <interrupts_enabled>
   422bd:	f7 d0                	not    %eax
   422bf:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   422c3:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   422c7:	0f b6 c0             	movzbl %al,%eax
   422ca:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   422d1:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422d4:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   422d8:	8b 55 f0             	mov    -0x10(%rbp),%edx
   422db:	ee                   	out    %al,(%dx)
}
   422dc:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   422dd:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   422e1:	66 c1 e8 08          	shr    $0x8,%ax
   422e5:	0f b6 c0             	movzbl %al,%eax
   422e8:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   422ef:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422f2:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   422f6:	8b 55 f8             	mov    -0x8(%rbp),%edx
   422f9:	ee                   	out    %al,(%dx)
}
   422fa:	90                   	nop
}
   422fb:	90                   	nop
   422fc:	c9                   	leave  
   422fd:	c3                   	ret    

00000000000422fe <interrupt_init>:

void interrupt_init(void) {
   422fe:	f3 0f 1e fa          	endbr64 
   42302:	55                   	push   %rbp
   42303:	48 89 e5             	mov    %rsp,%rbp
   42306:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   4230a:	66 c7 05 ed 1f 01 00 	movw   $0x0,0x11fed(%rip)        # 54300 <interrupts_enabled>
   42311:	00 00 
    interrupt_mask();
   42313:	e8 92 ff ff ff       	call   422aa <interrupt_mask>
   42318:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   4231f:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42323:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   42327:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   4232a:	ee                   	out    %al,(%dx)
}
   4232b:	90                   	nop
   4232c:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   42333:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42337:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   4233b:	8b 55 ac             	mov    -0x54(%rbp),%edx
   4233e:	ee                   	out    %al,(%dx)
}
   4233f:	90                   	nop
   42340:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   42347:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4234b:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   4234f:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   42352:	ee                   	out    %al,(%dx)
}
   42353:	90                   	nop
   42354:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   4235b:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4235f:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   42363:	8b 55 bc             	mov    -0x44(%rbp),%edx
   42366:	ee                   	out    %al,(%dx)
}
   42367:	90                   	nop
   42368:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   4236f:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42373:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   42377:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   4237a:	ee                   	out    %al,(%dx)
}
   4237b:	90                   	nop
   4237c:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   42383:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42387:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   4238b:	8b 55 cc             	mov    -0x34(%rbp),%edx
   4238e:	ee                   	out    %al,(%dx)
}
   4238f:	90                   	nop
   42390:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   42397:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4239b:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   4239f:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   423a2:	ee                   	out    %al,(%dx)
}
   423a3:	90                   	nop
   423a4:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   423ab:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423af:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   423b3:	8b 55 dc             	mov    -0x24(%rbp),%edx
   423b6:	ee                   	out    %al,(%dx)
}
   423b7:	90                   	nop
   423b8:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   423bf:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423c3:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   423c7:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   423ca:	ee                   	out    %al,(%dx)
}
   423cb:	90                   	nop
   423cc:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   423d3:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423d7:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   423db:	8b 55 ec             	mov    -0x14(%rbp),%edx
   423de:	ee                   	out    %al,(%dx)
}
   423df:	90                   	nop
   423e0:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   423e7:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423eb:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   423ef:	8b 55 f4             	mov    -0xc(%rbp),%edx
   423f2:	ee                   	out    %al,(%dx)
}
   423f3:	90                   	nop
   423f4:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   423fb:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423ff:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42403:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42406:	ee                   	out    %al,(%dx)
}
   42407:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   42408:	e8 9d fe ff ff       	call   422aa <interrupt_mask>
}
   4240d:	90                   	nop
   4240e:	c9                   	leave  
   4240f:	c3                   	ret    

0000000000042410 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   42410:	f3 0f 1e fa          	endbr64 
   42414:	55                   	push   %rbp
   42415:	48 89 e5             	mov    %rsp,%rbp
   42418:	48 83 ec 28          	sub    $0x28,%rsp
   4241c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   4241f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42423:	0f 8e 9f 00 00 00    	jle    424c8 <timer_init+0xb8>
   42429:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   42430:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42434:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42438:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4243b:	ee                   	out    %al,(%dx)
}
   4243c:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   4243d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42440:	89 c2                	mov    %eax,%edx
   42442:	c1 ea 1f             	shr    $0x1f,%edx
   42445:	01 d0                	add    %edx,%eax
   42447:	d1 f8                	sar    %eax
   42449:	05 de 34 12 00       	add    $0x1234de,%eax
   4244e:	99                   	cltd   
   4244f:	f7 7d dc             	idivl  -0x24(%rbp)
   42452:	89 c2                	mov    %eax,%edx
   42454:	89 d0                	mov    %edx,%eax
   42456:	c1 f8 1f             	sar    $0x1f,%eax
   42459:	c1 e8 18             	shr    $0x18,%eax
   4245c:	89 c1                	mov    %eax,%ecx
   4245e:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   42461:	0f b6 c0             	movzbl %al,%eax
   42464:	29 c8                	sub    %ecx,%eax
   42466:	0f b6 c0             	movzbl %al,%eax
   42469:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   42470:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42473:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42477:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4247a:	ee                   	out    %al,(%dx)
}
   4247b:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   4247c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4247f:	89 c2                	mov    %eax,%edx
   42481:	c1 ea 1f             	shr    $0x1f,%edx
   42484:	01 d0                	add    %edx,%eax
   42486:	d1 f8                	sar    %eax
   42488:	05 de 34 12 00       	add    $0x1234de,%eax
   4248d:	99                   	cltd   
   4248e:	f7 7d dc             	idivl  -0x24(%rbp)
   42491:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42497:	85 c0                	test   %eax,%eax
   42499:	0f 48 c2             	cmovs  %edx,%eax
   4249c:	c1 f8 08             	sar    $0x8,%eax
   4249f:	0f b6 c0             	movzbl %al,%eax
   424a2:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   424a9:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424ac:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   424b0:	8b 55 fc             	mov    -0x4(%rbp),%edx
   424b3:	ee                   	out    %al,(%dx)
}
   424b4:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   424b5:	0f b7 05 44 1e 01 00 	movzwl 0x11e44(%rip),%eax        # 54300 <interrupts_enabled>
   424bc:	83 c8 01             	or     $0x1,%eax
   424bf:	66 89 05 3a 1e 01 00 	mov    %ax,0x11e3a(%rip)        # 54300 <interrupts_enabled>
   424c6:	eb 11                	jmp    424d9 <timer_init+0xc9>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   424c8:	0f b7 05 31 1e 01 00 	movzwl 0x11e31(%rip),%eax        # 54300 <interrupts_enabled>
   424cf:	83 e0 fe             	and    $0xfffffffe,%eax
   424d2:	66 89 05 27 1e 01 00 	mov    %ax,0x11e27(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   424d9:	e8 cc fd ff ff       	call   422aa <interrupt_mask>
}
   424de:	90                   	nop
   424df:	c9                   	leave  
   424e0:	c3                   	ret    

00000000000424e1 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   424e1:	f3 0f 1e fa          	endbr64 
   424e5:	55                   	push   %rbp
   424e6:	48 89 e5             	mov    %rsp,%rbp
   424e9:	48 83 ec 08          	sub    $0x8,%rsp
   424ed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   424f1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   424f6:	74 14                	je     4250c <physical_memory_isreserved+0x2b>
   424f8:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   424ff:	00 
   42500:	76 11                	jbe    42513 <physical_memory_isreserved+0x32>
   42502:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   42509:	00 
   4250a:	77 07                	ja     42513 <physical_memory_isreserved+0x32>
   4250c:	b8 01 00 00 00       	mov    $0x1,%eax
   42511:	eb 05                	jmp    42518 <physical_memory_isreserved+0x37>
   42513:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42518:	c9                   	leave  
   42519:	c3                   	ret    

000000000004251a <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   4251a:	f3 0f 1e fa          	endbr64 
   4251e:	55                   	push   %rbp
   4251f:	48 89 e5             	mov    %rsp,%rbp
   42522:	48 83 ec 10          	sub    $0x10,%rsp
   42526:	89 7d fc             	mov    %edi,-0x4(%rbp)
   42529:	89 75 f8             	mov    %esi,-0x8(%rbp)
   4252c:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   4252f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42532:	c1 e0 10             	shl    $0x10,%eax
   42535:	89 c2                	mov    %eax,%edx
   42537:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4253a:	c1 e0 0b             	shl    $0xb,%eax
   4253d:	09 c2                	or     %eax,%edx
   4253f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42542:	c1 e0 08             	shl    $0x8,%eax
   42545:	09 d0                	or     %edx,%eax
}
   42547:	c9                   	leave  
   42548:	c3                   	ret    

0000000000042549 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   42549:	f3 0f 1e fa          	endbr64 
   4254d:	55                   	push   %rbp
   4254e:	48 89 e5             	mov    %rsp,%rbp
   42551:	48 83 ec 18          	sub    $0x18,%rsp
   42555:	89 7d ec             	mov    %edi,-0x14(%rbp)
   42558:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   4255b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4255e:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42561:	09 d0                	or     %edx,%eax
   42563:	0d 00 00 00 80       	or     $0x80000000,%eax
   42568:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   4256f:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42572:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42575:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42578:	ef                   	out    %eax,(%dx)
}
   42579:	90                   	nop
   4257a:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42581:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42584:	89 c2                	mov    %eax,%edx
   42586:	ed                   	in     (%dx),%eax
   42587:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   4258a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   4258d:	c9                   	leave  
   4258e:	c3                   	ret    

000000000004258f <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   4258f:	f3 0f 1e fa          	endbr64 
   42593:	55                   	push   %rbp
   42594:	48 89 e5             	mov    %rsp,%rbp
   42597:	48 83 ec 28          	sub    $0x28,%rsp
   4259b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4259e:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   425a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   425a8:	eb 73                	jmp    4261d <pci_find_device+0x8e>
        for (int slot = 0; slot != 32; ++slot) {
   425aa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   425b1:	eb 60                	jmp    42613 <pci_find_device+0x84>
            for (int func = 0; func != 8; ++func) {
   425b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   425ba:	eb 4a                	jmp    42606 <pci_find_device+0x77>
                int configaddr = pci_make_configaddr(bus, slot, func);
   425bc:	8b 55 f4             	mov    -0xc(%rbp),%edx
   425bf:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   425c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   425c5:	89 ce                	mov    %ecx,%esi
   425c7:	89 c7                	mov    %eax,%edi
   425c9:	e8 4c ff ff ff       	call   4251a <pci_make_configaddr>
   425ce:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   425d1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   425d4:	be 00 00 00 00       	mov    $0x0,%esi
   425d9:	89 c7                	mov    %eax,%edi
   425db:	e8 69 ff ff ff       	call   42549 <pci_config_readl>
   425e0:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   425e3:	8b 45 d8             	mov    -0x28(%rbp),%eax
   425e6:	c1 e0 10             	shl    $0x10,%eax
   425e9:	0b 45 dc             	or     -0x24(%rbp),%eax
   425ec:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   425ef:	75 05                	jne    425f6 <pci_find_device+0x67>
                    return configaddr;
   425f1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   425f4:	eb 35                	jmp    4262b <pci_find_device+0x9c>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   425f6:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   425fa:	75 06                	jne    42602 <pci_find_device+0x73>
   425fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42600:	74 0c                	je     4260e <pci_find_device+0x7f>
            for (int func = 0; func != 8; ++func) {
   42602:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42606:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   4260a:	75 b0                	jne    425bc <pci_find_device+0x2d>
   4260c:	eb 01                	jmp    4260f <pci_find_device+0x80>
                    break;
   4260e:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   4260f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42613:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   42617:	75 9a                	jne    425b3 <pci_find_device+0x24>
    for (int bus = 0; bus != 256; ++bus) {
   42619:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4261d:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42624:	75 84                	jne    425aa <pci_find_device+0x1b>
                }
            }
        }
    }
    return -1;
   42626:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   4262b:	c9                   	leave  
   4262c:	c3                   	ret    

000000000004262d <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   4262d:	f3 0f 1e fa          	endbr64 
   42631:	55                   	push   %rbp
   42632:	48 89 e5             	mov    %rsp,%rbp
   42635:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42639:	be 13 71 00 00       	mov    $0x7113,%esi
   4263e:	bf 86 80 00 00       	mov    $0x8086,%edi
   42643:	e8 47 ff ff ff       	call   4258f <pci_find_device>
   42648:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   4264b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4264f:	78 30                	js     42681 <poweroff+0x54>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   42651:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42654:	be 40 00 00 00       	mov    $0x40,%esi
   42659:	89 c7                	mov    %eax,%edi
   4265b:	e8 e9 fe ff ff       	call   42549 <pci_config_readl>
   42660:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42665:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42668:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4266b:	83 c0 04             	add    $0x4,%eax
   4266e:	89 45 f4             	mov    %eax,-0xc(%rbp)
   42671:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42677:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   4267b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4267e:	66 ef                	out    %ax,(%dx)
}
   42680:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42681:	48 8d 05 38 29 00 00 	lea    0x2938(%rip),%rax        # 44fc0 <memstate_colors+0xc0>
   42688:	48 89 c2             	mov    %rax,%rdx
   4268b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42690:	bf 80 07 00 00       	mov    $0x780,%edi
   42695:	b8 00 00 00 00       	mov    $0x0,%eax
   4269a:	e8 ef 23 00 00       	call   44a8e <console_printf>
 spinloop: goto spinloop;
   4269f:	eb fe                	jmp    4269f <poweroff+0x72>

00000000000426a1 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   426a1:	f3 0f 1e fa          	endbr64 
   426a5:	55                   	push   %rbp
   426a6:	48 89 e5             	mov    %rsp,%rbp
   426a9:	48 83 ec 10          	sub    $0x10,%rsp
   426ad:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   426b4:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426b8:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   426bc:	8b 55 fc             	mov    -0x4(%rbp),%edx
   426bf:	ee                   	out    %al,(%dx)
}
   426c0:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   426c1:	eb fe                	jmp    426c1 <reboot+0x20>

00000000000426c3 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   426c3:	f3 0f 1e fa          	endbr64 
   426c7:	55                   	push   %rbp
   426c8:	48 89 e5             	mov    %rsp,%rbp
   426cb:	48 83 ec 10          	sub    $0x10,%rsp
   426cf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   426d3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   426d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426da:	48 83 c0 08          	add    $0x8,%rax
   426de:	ba c0 00 00 00       	mov    $0xc0,%edx
   426e3:	be 00 00 00 00       	mov    $0x0,%esi
   426e8:	48 89 c7             	mov    %rax,%rdi
   426eb:	e8 5f 15 00 00       	call   43c4f <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   426f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426f4:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   426fb:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   426fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42701:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   42708:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   4270c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42710:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   42717:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   4271b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4271f:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   42726:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   42728:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4272c:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   42733:	00 02 00 00 
    p->display_status = 1;
   42737:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4273b:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42742:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42745:	83 e0 01             	and    $0x1,%eax
   42748:	85 c0                	test   %eax,%eax
   4274a:	74 1c                	je     42768 <process_init+0xa5>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4274c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42750:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42757:	80 cc 30             	or     $0x30,%ah
   4275a:	48 89 c2             	mov    %rax,%rdx
   4275d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42761:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42768:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4276b:	83 e0 02             	and    $0x2,%eax
   4276e:	85 c0                	test   %eax,%eax
   42770:	74 1c                	je     4278e <process_init+0xcb>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42772:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42776:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4277d:	80 e4 fd             	and    $0xfd,%ah
   42780:	48 89 c2             	mov    %rax,%rdx
   42783:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42787:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   4278e:	90                   	nop
   4278f:	c9                   	leave  
   42790:	c3                   	ret    

0000000000042791 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42791:	f3 0f 1e fa          	endbr64 
   42795:	55                   	push   %rbp
   42796:	48 89 e5             	mov    %rsp,%rbp
   42799:	48 83 ec 28          	sub    $0x28,%rsp
   4279d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   427a0:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   427a4:	78 09                	js     427af <console_show_cursor+0x1e>
   427a6:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   427ad:	7e 07                	jle    427b6 <console_show_cursor+0x25>
        cpos = 0;
   427af:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   427b6:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   427bd:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427c1:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   427c5:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   427c8:	ee                   	out    %al,(%dx)
}
   427c9:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   427ca:	8b 45 dc             	mov    -0x24(%rbp),%eax
   427cd:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   427d3:	85 c0                	test   %eax,%eax
   427d5:	0f 48 c2             	cmovs  %edx,%eax
   427d8:	c1 f8 08             	sar    $0x8,%eax
   427db:	0f b6 c0             	movzbl %al,%eax
   427de:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   427e5:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427e8:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   427ec:	8b 55 ec             	mov    -0x14(%rbp),%edx
   427ef:	ee                   	out    %al,(%dx)
}
   427f0:	90                   	nop
   427f1:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   427f8:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427fc:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42800:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42803:	ee                   	out    %al,(%dx)
}
   42804:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42805:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42808:	99                   	cltd   
   42809:	c1 ea 18             	shr    $0x18,%edx
   4280c:	01 d0                	add    %edx,%eax
   4280e:	0f b6 c0             	movzbl %al,%eax
   42811:	29 d0                	sub    %edx,%eax
   42813:	0f b6 c0             	movzbl %al,%eax
   42816:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   4281d:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42820:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42824:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42827:	ee                   	out    %al,(%dx)
}
   42828:	90                   	nop
}
   42829:	90                   	nop
   4282a:	c9                   	leave  
   4282b:	c3                   	ret    

000000000004282c <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   4282c:	f3 0f 1e fa          	endbr64 
   42830:	55                   	push   %rbp
   42831:	48 89 e5             	mov    %rsp,%rbp
   42834:	48 83 ec 20          	sub    $0x20,%rsp
   42838:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4283f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42842:	89 c2                	mov    %eax,%edx
   42844:	ec                   	in     (%dx),%al
   42845:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42848:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   4284c:	0f b6 c0             	movzbl %al,%eax
   4284f:	83 e0 01             	and    $0x1,%eax
   42852:	85 c0                	test   %eax,%eax
   42854:	75 0a                	jne    42860 <keyboard_readc+0x34>
        return -1;
   42856:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4285b:	e9 fd 01 00 00       	jmp    42a5d <keyboard_readc+0x231>
   42860:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42867:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4286a:	89 c2                	mov    %eax,%edx
   4286c:	ec                   	in     (%dx),%al
   4286d:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42870:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42874:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42877:	0f b6 05 84 1a 01 00 	movzbl 0x11a84(%rip),%eax        # 54302 <last_escape.2>
   4287e:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42881:	c6 05 7a 1a 01 00 00 	movb   $0x0,0x11a7a(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42888:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4288c:	75 11                	jne    4289f <keyboard_readc+0x73>
        last_escape = 0x80;
   4288e:	c6 05 6d 1a 01 00 80 	movb   $0x80,0x11a6d(%rip)        # 54302 <last_escape.2>
        return 0;
   42895:	b8 00 00 00 00       	mov    $0x0,%eax
   4289a:	e9 be 01 00 00       	jmp    42a5d <keyboard_readc+0x231>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4289f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   428a3:	84 c0                	test   %al,%al
   428a5:	79 64                	jns    4290b <keyboard_readc+0xdf>
        int ch = keymap[(data & 0x7F) | escape];
   428a7:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   428ab:	83 e0 7f             	and    $0x7f,%eax
   428ae:	89 c2                	mov    %eax,%edx
   428b0:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   428b4:	09 d0                	or     %edx,%eax
   428b6:	48 98                	cltq   
   428b8:	48 8d 15 21 27 00 00 	lea    0x2721(%rip),%rdx        # 44fe0 <keymap>
   428bf:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   428c3:	0f b6 c0             	movzbl %al,%eax
   428c6:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   428c9:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   428d0:	7e 2f                	jle    42901 <keyboard_readc+0xd5>
   428d2:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   428d9:	7f 26                	jg     42901 <keyboard_readc+0xd5>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   428db:	8b 45 f4             	mov    -0xc(%rbp),%eax
   428de:	2d fa 00 00 00       	sub    $0xfa,%eax
   428e3:	ba 01 00 00 00       	mov    $0x1,%edx
   428e8:	89 c1                	mov    %eax,%ecx
   428ea:	d3 e2                	shl    %cl,%edx
   428ec:	89 d0                	mov    %edx,%eax
   428ee:	f7 d0                	not    %eax
   428f0:	89 c2                	mov    %eax,%edx
   428f2:	0f b6 05 0a 1a 01 00 	movzbl 0x11a0a(%rip),%eax        # 54303 <modifiers.1>
   428f9:	21 d0                	and    %edx,%eax
   428fb:	88 05 02 1a 01 00    	mov    %al,0x11a02(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   42901:	b8 00 00 00 00       	mov    $0x0,%eax
   42906:	e9 52 01 00 00       	jmp    42a5d <keyboard_readc+0x231>
    }

    int ch = (unsigned char) keymap[data | escape];
   4290b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4290f:	0a 45 fa             	or     -0x6(%rbp),%al
   42912:	0f b6 c0             	movzbl %al,%eax
   42915:	48 98                	cltq   
   42917:	48 8d 15 c2 26 00 00 	lea    0x26c2(%rip),%rdx        # 44fe0 <keymap>
   4291e:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
   42922:	0f b6 c0             	movzbl %al,%eax
   42925:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42928:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4292c:	7e 57                	jle    42985 <keyboard_readc+0x159>
   4292e:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42932:	7f 51                	jg     42985 <keyboard_readc+0x159>
        if (modifiers & MOD_CONTROL) {
   42934:	0f b6 05 c8 19 01 00 	movzbl 0x119c8(%rip),%eax        # 54303 <modifiers.1>
   4293b:	0f b6 c0             	movzbl %al,%eax
   4293e:	83 e0 02             	and    $0x2,%eax
   42941:	85 c0                	test   %eax,%eax
   42943:	74 09                	je     4294e <keyboard_readc+0x122>
            ch -= 0x60;
   42945:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42949:	e9 0b 01 00 00       	jmp    42a59 <keyboard_readc+0x22d>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4294e:	0f b6 05 ae 19 01 00 	movzbl 0x119ae(%rip),%eax        # 54303 <modifiers.1>
   42955:	0f b6 c0             	movzbl %al,%eax
   42958:	83 e0 01             	and    $0x1,%eax
   4295b:	85 c0                	test   %eax,%eax
   4295d:	0f 94 c2             	sete   %dl
   42960:	0f b6 05 9c 19 01 00 	movzbl 0x1199c(%rip),%eax        # 54303 <modifiers.1>
   42967:	0f b6 c0             	movzbl %al,%eax
   4296a:	83 e0 08             	and    $0x8,%eax
   4296d:	85 c0                	test   %eax,%eax
   4296f:	0f 94 c0             	sete   %al
   42972:	31 d0                	xor    %edx,%eax
   42974:	84 c0                	test   %al,%al
   42976:	0f 84 dd 00 00 00    	je     42a59 <keyboard_readc+0x22d>
            ch -= 0x20;
   4297c:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42980:	e9 d4 00 00 00       	jmp    42a59 <keyboard_readc+0x22d>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42985:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4298c:	7e 30                	jle    429be <keyboard_readc+0x192>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4298e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42991:	2d fa 00 00 00       	sub    $0xfa,%eax
   42996:	ba 01 00 00 00       	mov    $0x1,%edx
   4299b:	89 c1                	mov    %eax,%ecx
   4299d:	d3 e2                	shl    %cl,%edx
   4299f:	89 d0                	mov    %edx,%eax
   429a1:	89 c2                	mov    %eax,%edx
   429a3:	0f b6 05 59 19 01 00 	movzbl 0x11959(%rip),%eax        # 54303 <modifiers.1>
   429aa:	31 d0                	xor    %edx,%eax
   429ac:	88 05 51 19 01 00    	mov    %al,0x11951(%rip)        # 54303 <modifiers.1>
        ch = 0;
   429b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   429b9:	e9 9c 00 00 00       	jmp    42a5a <keyboard_readc+0x22e>
    } else if (ch >= KEY_SHIFT) {
   429be:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   429c5:	7e 2d                	jle    429f4 <keyboard_readc+0x1c8>
        modifiers |= 1 << (ch - KEY_SHIFT);
   429c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   429ca:	2d fa 00 00 00       	sub    $0xfa,%eax
   429cf:	ba 01 00 00 00       	mov    $0x1,%edx
   429d4:	89 c1                	mov    %eax,%ecx
   429d6:	d3 e2                	shl    %cl,%edx
   429d8:	89 d0                	mov    %edx,%eax
   429da:	89 c2                	mov    %eax,%edx
   429dc:	0f b6 05 20 19 01 00 	movzbl 0x11920(%rip),%eax        # 54303 <modifiers.1>
   429e3:	09 d0                	or     %edx,%eax
   429e5:	88 05 18 19 01 00    	mov    %al,0x11918(%rip)        # 54303 <modifiers.1>
        ch = 0;
   429eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   429f2:	eb 66                	jmp    42a5a <keyboard_readc+0x22e>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   429f4:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   429f8:	7e 3f                	jle    42a39 <keyboard_readc+0x20d>
   429fa:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42a01:	7f 36                	jg     42a39 <keyboard_readc+0x20d>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42a03:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42a06:	8d 50 80             	lea    -0x80(%rax),%edx
   42a09:	0f b6 05 f3 18 01 00 	movzbl 0x118f3(%rip),%eax        # 54303 <modifiers.1>
   42a10:	0f b6 c0             	movzbl %al,%eax
   42a13:	83 e0 03             	and    $0x3,%eax
   42a16:	48 63 c8             	movslq %eax,%rcx
   42a19:	48 63 c2             	movslq %edx,%rax
   42a1c:	48 c1 e0 02          	shl    $0x2,%rax
   42a20:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
   42a24:	48 8d 05 b5 26 00 00 	lea    0x26b5(%rip),%rax        # 450e0 <complex_keymap>
   42a2b:	48 01 d0             	add    %rdx,%rax
   42a2e:	0f b6 00             	movzbl (%rax),%eax
   42a31:	0f b6 c0             	movzbl %al,%eax
   42a34:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42a37:	eb 21                	jmp    42a5a <keyboard_readc+0x22e>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42a39:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42a3d:	7f 1b                	jg     42a5a <keyboard_readc+0x22e>
   42a3f:	0f b6 05 bd 18 01 00 	movzbl 0x118bd(%rip),%eax        # 54303 <modifiers.1>
   42a46:	0f b6 c0             	movzbl %al,%eax
   42a49:	83 e0 02             	and    $0x2,%eax
   42a4c:	85 c0                	test   %eax,%eax
   42a4e:	74 0a                	je     42a5a <keyboard_readc+0x22e>
        ch = 0;
   42a50:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42a57:	eb 01                	jmp    42a5a <keyboard_readc+0x22e>
        if (modifiers & MOD_CONTROL) {
   42a59:	90                   	nop
    }

    return ch;
   42a5a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42a5d:	c9                   	leave  
   42a5e:	c3                   	ret    

0000000000042a5f <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42a5f:	f3 0f 1e fa          	endbr64 
   42a63:	55                   	push   %rbp
   42a64:	48 89 e5             	mov    %rsp,%rbp
   42a67:	48 83 ec 20          	sub    $0x20,%rsp
   42a6b:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42a72:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42a75:	89 c2                	mov    %eax,%edx
   42a77:	ec                   	in     (%dx),%al
   42a78:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42a7b:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42a82:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42a85:	89 c2                	mov    %eax,%edx
   42a87:	ec                   	in     (%dx),%al
   42a88:	88 45 eb             	mov    %al,-0x15(%rbp)
   42a8b:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42a92:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42a95:	89 c2                	mov    %eax,%edx
   42a97:	ec                   	in     (%dx),%al
   42a98:	88 45 f3             	mov    %al,-0xd(%rbp)
   42a9b:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42aa2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42aa5:	89 c2                	mov    %eax,%edx
   42aa7:	ec                   	in     (%dx),%al
   42aa8:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42aab:	90                   	nop
   42aac:	c9                   	leave  
   42aad:	c3                   	ret    

0000000000042aae <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42aae:	f3 0f 1e fa          	endbr64 
   42ab2:	55                   	push   %rbp
   42ab3:	48 89 e5             	mov    %rsp,%rbp
   42ab6:	48 83 ec 40          	sub    $0x40,%rsp
   42aba:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42abe:	89 f0                	mov    %esi,%eax
   42ac0:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42ac3:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42ac6:	8b 05 38 18 01 00    	mov    0x11838(%rip),%eax        # 54304 <initialized.0>
   42acc:	85 c0                	test   %eax,%eax
   42ace:	75 1e                	jne    42aee <parallel_port_putc+0x40>
   42ad0:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42ad7:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42adb:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42adf:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42ae2:	ee                   	out    %al,(%dx)
}
   42ae3:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42ae4:	c7 05 16 18 01 00 01 	movl   $0x1,0x11816(%rip)        # 54304 <initialized.0>
   42aeb:	00 00 00 
    }

    for (int i = 0;
   42aee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42af5:	eb 09                	jmp    42b00 <parallel_port_putc+0x52>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42af7:	e8 63 ff ff ff       	call   42a5f <delay>
         ++i) {
   42afc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42b00:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42b07:	7f 18                	jg     42b21 <parallel_port_putc+0x73>
   42b09:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42b10:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42b13:	89 c2                	mov    %eax,%edx
   42b15:	ec                   	in     (%dx),%al
   42b16:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42b19:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42b1d:	84 c0                	test   %al,%al
   42b1f:	79 d6                	jns    42af7 <parallel_port_putc+0x49>
    }
    outb(IO_PARALLEL1_DATA, c);
   42b21:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42b25:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42b2c:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42b2f:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42b33:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42b36:	ee                   	out    %al,(%dx)
}
   42b37:	90                   	nop
   42b38:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42b3f:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42b43:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42b47:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42b4a:	ee                   	out    %al,(%dx)
}
   42b4b:	90                   	nop
   42b4c:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42b53:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42b57:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42b5b:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42b5e:	ee                   	out    %al,(%dx)
}
   42b5f:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42b60:	90                   	nop
   42b61:	c9                   	leave  
   42b62:	c3                   	ret    

0000000000042b63 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42b63:	f3 0f 1e fa          	endbr64 
   42b67:	55                   	push   %rbp
   42b68:	48 89 e5             	mov    %rsp,%rbp
   42b6b:	48 83 ec 20          	sub    $0x20,%rsp
   42b6f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42b73:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42b77:	48 8d 05 30 ff ff ff 	lea    -0xd0(%rip),%rax        # 42aae <parallel_port_putc>
   42b7e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&p, 0, format, val);
   42b82:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42b86:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42b8a:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42b8e:	be 00 00 00 00       	mov    $0x0,%esi
   42b93:	48 89 c7             	mov    %rax,%rdi
   42b96:	e8 7a 13 00 00       	call   43f15 <printer_vprintf>
}
   42b9b:	90                   	nop
   42b9c:	c9                   	leave  
   42b9d:	c3                   	ret    

0000000000042b9e <log_printf>:

void log_printf(const char* format, ...) {
   42b9e:	f3 0f 1e fa          	endbr64 
   42ba2:	55                   	push   %rbp
   42ba3:	48 89 e5             	mov    %rsp,%rbp
   42ba6:	48 83 ec 60          	sub    $0x60,%rsp
   42baa:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42bae:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42bb2:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42bb6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42bba:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42bbe:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42bc2:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42bc9:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42bcd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42bd1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42bd5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42bd9:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42bdd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42be1:	48 89 d6             	mov    %rdx,%rsi
   42be4:	48 89 c7             	mov    %rax,%rdi
   42be7:	e8 77 ff ff ff       	call   42b63 <log_vprintf>
    va_end(val);
}
   42bec:	90                   	nop
   42bed:	c9                   	leave  
   42bee:	c3                   	ret    

0000000000042bef <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42bef:	f3 0f 1e fa          	endbr64 
   42bf3:	55                   	push   %rbp
   42bf4:	48 89 e5             	mov    %rsp,%rbp
   42bf7:	48 83 ec 40          	sub    $0x40,%rsp
   42bfb:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42bfe:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42c01:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42c05:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42c09:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42c0d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42c11:	48 8b 0a             	mov    (%rdx),%rcx
   42c14:	48 89 08             	mov    %rcx,(%rax)
   42c17:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42c1b:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42c1f:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42c23:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42c27:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42c2b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c2f:	48 89 d6             	mov    %rdx,%rsi
   42c32:	48 89 c7             	mov    %rax,%rdi
   42c35:	e8 29 ff ff ff       	call   42b63 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42c3a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42c3e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42c42:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42c45:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42c48:	89 c7                	mov    %eax,%edi
   42c4a:	e8 c3 1d 00 00       	call   44a12 <console_vprintf>
}
   42c4f:	c9                   	leave  
   42c50:	c3                   	ret    

0000000000042c51 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42c51:	f3 0f 1e fa          	endbr64 
   42c55:	55                   	push   %rbp
   42c56:	48 89 e5             	mov    %rsp,%rbp
   42c59:	48 83 ec 60          	sub    $0x60,%rsp
   42c5d:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42c60:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42c63:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42c67:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42c6b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42c6f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42c73:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42c7a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42c7e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42c82:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42c86:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42c8a:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42c8e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42c92:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42c95:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c98:	89 c7                	mov    %eax,%edi
   42c9a:	e8 50 ff ff ff       	call   42bef <error_vprintf>
   42c9f:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42ca2:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42ca5:	c9                   	leave  
   42ca6:	c3                   	ret    

0000000000042ca7 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42ca7:	f3 0f 1e fa          	endbr64 
   42cab:	55                   	push   %rbp
   42cac:	48 89 e5             	mov    %rsp,%rbp
   42caf:	53                   	push   %rbx
   42cb0:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42cb4:	e8 73 fb ff ff       	call   4282c <keyboard_readc>
   42cb9:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42cbc:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42cc0:	74 1c                	je     42cde <check_keyboard+0x37>
   42cc2:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42cc6:	74 16                	je     42cde <check_keyboard+0x37>
   42cc8:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42ccc:	74 10                	je     42cde <check_keyboard+0x37>
   42cce:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42cd2:	74 0a                	je     42cde <check_keyboard+0x37>
   42cd4:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42cd8:	0f 85 02 01 00 00    	jne    42de0 <check_keyboard+0x139>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42cde:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42ce5:	00 
        memset(pt, 0, PAGESIZE * 3);
   42ce6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cea:	ba 00 30 00 00       	mov    $0x3000,%edx
   42cef:	be 00 00 00 00       	mov    $0x0,%esi
   42cf4:	48 89 c7             	mov    %rax,%rdi
   42cf7:	e8 53 0f 00 00       	call   43c4f <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42cfc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d00:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42d07:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d0b:	48 05 00 10 00 00    	add    $0x1000,%rax
   42d11:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42d18:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d1c:	48 05 00 20 00 00    	add    $0x2000,%rax
   42d22:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42d29:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d2d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42d31:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d35:	0f 22 d8             	mov    %rax,%cr3
}
   42d38:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42d39:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42d40:	48 8d 05 f1 23 00 00 	lea    0x23f1(%rip),%rax        # 45138 <complex_keymap+0x58>
   42d47:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (c == 'a') {
   42d4b:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42d4f:	75 0d                	jne    42d5e <check_keyboard+0xb7>
            argument = "allocator";
   42d51:	48 8d 05 e5 23 00 00 	lea    0x23e5(%rip),%rax        # 4513d <complex_keymap+0x5d>
   42d58:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42d5c:	eb 37                	jmp    42d95 <check_keyboard+0xee>
        } else if (c == 'e') {
   42d5e:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42d62:	75 0d                	jne    42d71 <check_keyboard+0xca>
            argument = "forkexit";
   42d64:	48 8d 05 dc 23 00 00 	lea    0x23dc(%rip),%rax        # 45147 <complex_keymap+0x67>
   42d6b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42d6f:	eb 24                	jmp    42d95 <check_keyboard+0xee>
        }
        else if (c == 't'){
   42d71:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42d75:	75 0d                	jne    42d84 <check_keyboard+0xdd>
            argument = "test";
   42d77:	48 8d 05 d2 23 00 00 	lea    0x23d2(%rip),%rax        # 45150 <complex_keymap+0x70>
   42d7e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42d82:	eb 11                	jmp    42d95 <check_keyboard+0xee>
        }
        else if(c == '2'){
   42d84:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42d88:	75 0b                	jne    42d95 <check_keyboard+0xee>
            argument = "test2";
   42d8a:	48 8d 05 c4 23 00 00 	lea    0x23c4(%rip),%rax        # 45155 <complex_keymap+0x75>
   42d91:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42d95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d99:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42d9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42da2:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42da6:	76 1e                	jbe    42dc6 <check_keyboard+0x11f>
   42da8:	48 8d 05 ac 23 00 00 	lea    0x23ac(%rip),%rax        # 4515b <complex_keymap+0x7b>
   42daf:	48 89 c2             	mov    %rax,%rdx
   42db2:	be 5d 02 00 00       	mov    $0x25d,%esi
   42db7:	48 8d 05 b9 23 00 00 	lea    0x23b9(%rip),%rax        # 45177 <complex_keymap+0x97>
   42dbe:	48 89 c7             	mov    %rax,%rdi
   42dc1:	e8 33 01 00 00       	call   42ef9 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42dc6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42dca:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42dcd:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42dd1:	48 89 c3             	mov    %rax,%rbx
   42dd4:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42dd9:	e9 22 d2 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42dde:	eb 11                	jmp    42df1 <check_keyboard+0x14a>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42de0:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42de4:	74 06                	je     42dec <check_keyboard+0x145>
   42de6:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42dea:	75 05                	jne    42df1 <check_keyboard+0x14a>
        poweroff();
   42dec:	e8 3c f8 ff ff       	call   4262d <poweroff>
    }
    return c;
   42df1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42df4:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42df8:	c9                   	leave  
   42df9:	c3                   	ret    

0000000000042dfa <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42dfa:	f3 0f 1e fa          	endbr64 
   42dfe:	55                   	push   %rbp
   42dff:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42e02:	e8 a0 fe ff ff       	call   42ca7 <check_keyboard>
   42e07:	eb f9                	jmp    42e02 <fail+0x8>

0000000000042e09 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42e09:	f3 0f 1e fa          	endbr64 
   42e0d:	55                   	push   %rbp
   42e0e:	48 89 e5             	mov    %rsp,%rbp
   42e11:	48 83 ec 60          	sub    $0x60,%rsp
   42e15:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42e19:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42e1d:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42e21:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42e25:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42e29:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42e2d:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42e34:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42e38:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42e3c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42e40:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42e44:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42e49:	0f 84 87 00 00 00    	je     42ed6 <panic+0xcd>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42e4f:	48 8d 05 35 23 00 00 	lea    0x2335(%rip),%rax        # 4518b <complex_keymap+0xab>
   42e56:	48 89 c2             	mov    %rax,%rdx
   42e59:	be 00 c0 00 00       	mov    $0xc000,%esi
   42e5e:	bf 30 07 00 00       	mov    $0x730,%edi
   42e63:	b8 00 00 00 00       	mov    $0x0,%eax
   42e68:	e8 e4 fd ff ff       	call   42c51 <error_printf>
   42e6d:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42e70:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42e74:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42e78:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42e7b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42e80:	89 c7                	mov    %eax,%edi
   42e82:	e8 68 fd ff ff       	call   42bef <error_vprintf>
   42e87:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42e8a:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42e8d:	48 63 c1             	movslq %ecx,%rax
   42e90:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42e97:	48 c1 e8 20          	shr    $0x20,%rax
   42e9b:	c1 f8 05             	sar    $0x5,%eax
   42e9e:	89 ce                	mov    %ecx,%esi
   42ea0:	c1 fe 1f             	sar    $0x1f,%esi
   42ea3:	29 f0                	sub    %esi,%eax
   42ea5:	89 c2                	mov    %eax,%edx
   42ea7:	89 d0                	mov    %edx,%eax
   42ea9:	c1 e0 02             	shl    $0x2,%eax
   42eac:	01 d0                	add    %edx,%eax
   42eae:	c1 e0 04             	shl    $0x4,%eax
   42eb1:	29 c1                	sub    %eax,%ecx
   42eb3:	89 ca                	mov    %ecx,%edx
   42eb5:	85 d2                	test   %edx,%edx
   42eb7:	74 3b                	je     42ef4 <panic+0xeb>
            error_printf(cpos, 0xC000, "\n");
   42eb9:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42ebc:	48 8d 15 d0 22 00 00 	lea    0x22d0(%rip),%rdx        # 45193 <complex_keymap+0xb3>
   42ec3:	be 00 c0 00 00       	mov    $0xc000,%esi
   42ec8:	89 c7                	mov    %eax,%edi
   42eca:	b8 00 00 00 00       	mov    $0x0,%eax
   42ecf:	e8 7d fd ff ff       	call   42c51 <error_printf>
   42ed4:	eb 1e                	jmp    42ef4 <panic+0xeb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42ed6:	48 8d 05 b8 22 00 00 	lea    0x22b8(%rip),%rax        # 45195 <complex_keymap+0xb5>
   42edd:	48 89 c2             	mov    %rax,%rdx
   42ee0:	be 00 c0 00 00       	mov    $0xc000,%esi
   42ee5:	bf 30 07 00 00       	mov    $0x730,%edi
   42eea:	b8 00 00 00 00       	mov    $0x0,%eax
   42eef:	e8 5d fd ff ff       	call   42c51 <error_printf>
    }

    va_end(val);
    fail();
   42ef4:	e8 01 ff ff ff       	call   42dfa <fail>

0000000000042ef9 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42ef9:	f3 0f 1e fa          	endbr64 
   42efd:	55                   	push   %rbp
   42efe:	48 89 e5             	mov    %rsp,%rbp
   42f01:	48 83 ec 20          	sub    $0x20,%rsp
   42f05:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42f09:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42f0c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42f10:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42f14:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42f17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f1b:	48 89 c6             	mov    %rax,%rsi
   42f1e:	48 8d 05 76 22 00 00 	lea    0x2276(%rip),%rax        # 4519b <complex_keymap+0xbb>
   42f25:	48 89 c7             	mov    %rax,%rdi
   42f28:	b8 00 00 00 00       	mov    $0x0,%eax
   42f2d:	e8 d7 fe ff ff       	call   42e09 <panic>

0000000000042f32 <default_exception>:
}

void default_exception(proc* p){
   42f32:	f3 0f 1e fa          	endbr64 
   42f36:	55                   	push   %rbp
   42f37:	48 89 e5             	mov    %rsp,%rbp
   42f3a:	48 83 ec 20          	sub    $0x20,%rsp
   42f3e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42f42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f46:	48 83 c0 08          	add    $0x8,%rax
   42f4a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42f4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f52:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42f59:	48 89 c6             	mov    %rax,%rsi
   42f5c:	48 8d 05 56 22 00 00 	lea    0x2256(%rip),%rax        # 451b9 <complex_keymap+0xd9>
   42f63:	48 89 c7             	mov    %rax,%rdi
   42f66:	b8 00 00 00 00       	mov    $0x0,%eax
   42f6b:	e8 99 fe ff ff       	call   42e09 <panic>

0000000000042f70 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42f70:	55                   	push   %rbp
   42f71:	48 89 e5             	mov    %rsp,%rbp
   42f74:	48 83 ec 10          	sub    $0x10,%rsp
   42f78:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42f7c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42f7f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42f83:	78 06                	js     42f8b <pageindex+0x1b>
   42f85:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42f89:	7e 1e                	jle    42fa9 <pageindex+0x39>
   42f8b:	48 8d 05 46 22 00 00 	lea    0x2246(%rip),%rax        # 451d8 <complex_keymap+0xf8>
   42f92:	48 89 c2             	mov    %rax,%rdx
   42f95:	be 1e 00 00 00       	mov    $0x1e,%esi
   42f9a:	48 8d 05 50 22 00 00 	lea    0x2250(%rip),%rax        # 451f1 <complex_keymap+0x111>
   42fa1:	48 89 c7             	mov    %rax,%rdi
   42fa4:	e8 50 ff ff ff       	call   42ef9 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42fa9:	b8 03 00 00 00       	mov    $0x3,%eax
   42fae:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42fb1:	89 c2                	mov    %eax,%edx
   42fb3:	89 d0                	mov    %edx,%eax
   42fb5:	c1 e0 03             	shl    $0x3,%eax
   42fb8:	01 d0                	add    %edx,%eax
   42fba:	83 c0 0c             	add    $0xc,%eax
   42fbd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42fc1:	89 c1                	mov    %eax,%ecx
   42fc3:	48 d3 ea             	shr    %cl,%rdx
   42fc6:	48 89 d0             	mov    %rdx,%rax
   42fc9:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42fce:	c9                   	leave  
   42fcf:	c3                   	ret    

0000000000042fd0 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42fd0:	f3 0f 1e fa          	endbr64 
   42fd4:	55                   	push   %rbp
   42fd5:	48 89 e5             	mov    %rsp,%rbp
   42fd8:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42fdc:	48 8d 05 1d 30 01 00 	lea    0x1301d(%rip),%rax        # 56000 <kernel_pagetables>
   42fe3:	48 89 05 16 20 01 00 	mov    %rax,0x12016(%rip)        # 55000 <kernel_pagetable>
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42fea:	ba 00 50 00 00       	mov    $0x5000,%edx
   42fef:	be 00 00 00 00       	mov    $0x0,%esi
   42ff4:	48 8d 05 05 30 01 00 	lea    0x13005(%rip),%rax        # 56000 <kernel_pagetables>
   42ffb:	48 89 c7             	mov    %rax,%rdi
   42ffe:	e8 4c 0c 00 00       	call   43c4f <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   43003:	48 8d 05 f6 3f 01 00 	lea    0x13ff6(%rip),%rax        # 57000 <kernel_pagetables+0x1000>
   4300a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   4300e:	48 89 05 eb 2f 01 00 	mov    %rax,0x12feb(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   43015:	48 8d 05 e4 4f 01 00 	lea    0x14fe4(%rip),%rax        # 58000 <kernel_pagetables+0x2000>
   4301c:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   43020:	48 89 05 d9 3f 01 00 	mov    %rax,0x13fd9(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   43027:	48 8d 05 d2 5f 01 00 	lea    0x15fd2(%rip),%rax        # 59000 <kernel_pagetables+0x3000>
   4302e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   43032:	48 89 05 c7 4f 01 00 	mov    %rax,0x14fc7(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   43039:	48 8d 05 c0 6f 01 00 	lea    0x16fc0(%rip),%rax        # 5a000 <kernel_pagetables+0x4000>
   43040:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   43044:	48 89 05 bd 4f 01 00 	mov    %rax,0x14fbd(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4304b:	48 8b 05 ae 1f 01 00 	mov    0x11fae(%rip),%rax        # 55000 <kernel_pagetable>
   43052:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43058:	b9 00 00 20 00       	mov    $0x200000,%ecx
   4305d:	ba 00 00 00 00       	mov    $0x0,%edx
   43062:	be 00 00 00 00       	mov    $0x0,%esi
   43067:	48 89 c7             	mov    %rax,%rdi
   4306a:	e8 0e 02 00 00       	call   4327d <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4306f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43076:	00 
   43077:	eb 76                	jmp    430ef <virtual_memory_init+0x11f>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   43079:	48 8b 0d 80 1f 01 00 	mov    0x11f80(%rip),%rcx        # 55000 <kernel_pagetable>
   43080:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   43084:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43088:	48 89 ce             	mov    %rcx,%rsi
   4308b:	48 89 c7             	mov    %rax,%rdi
   4308e:	e8 34 06 00 00       	call   436c7 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   43093:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43097:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4309b:	74 1e                	je     430bb <virtual_memory_init+0xeb>
   4309d:	48 8d 05 61 21 00 00 	lea    0x2161(%rip),%rax        # 45205 <complex_keymap+0x125>
   430a4:	48 89 c2             	mov    %rax,%rdx
   430a7:	be 2d 00 00 00       	mov    $0x2d,%esi
   430ac:	48 8d 05 62 21 00 00 	lea    0x2162(%rip),%rax        # 45215 <complex_keymap+0x135>
   430b3:	48 89 c7             	mov    %rax,%rdi
   430b6:	e8 3e fe ff ff       	call   42ef9 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   430bb:	8b 45 f0             	mov    -0x10(%rbp),%eax
   430be:	48 98                	cltq   
   430c0:	83 e0 03             	and    $0x3,%eax
   430c3:	48 83 f8 03          	cmp    $0x3,%rax
   430c7:	74 1e                	je     430e7 <virtual_memory_init+0x117>
   430c9:	48 8d 05 58 21 00 00 	lea    0x2158(%rip),%rax        # 45228 <complex_keymap+0x148>
   430d0:	48 89 c2             	mov    %rax,%rdx
   430d3:	be 2e 00 00 00       	mov    $0x2e,%esi
   430d8:	48 8d 05 36 21 00 00 	lea    0x2136(%rip),%rax        # 45215 <complex_keymap+0x135>
   430df:	48 89 c7             	mov    %rax,%rdi
   430e2:	e8 12 fe ff ff       	call   42ef9 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   430e7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   430ee:	00 
   430ef:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   430f6:	00 
   430f7:	76 80                	jbe    43079 <virtual_memory_init+0xa9>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   430f9:	48 8b 05 00 1f 01 00 	mov    0x11f00(%rip),%rax        # 55000 <kernel_pagetable>
   43100:	48 89 c7             	mov    %rax,%rdi
   43103:	e8 03 00 00 00       	call   4310b <set_pagetable>
}
   43108:	90                   	nop
   43109:	c9                   	leave  
   4310a:	c3                   	ret    

000000000004310b <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   4310b:	f3 0f 1e fa          	endbr64 
   4310f:	55                   	push   %rbp
   43110:	48 89 e5             	mov    %rsp,%rbp
   43113:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   43117:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   4311b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4311f:	25 ff 0f 00 00       	and    $0xfff,%eax
   43124:	48 85 c0             	test   %rax,%rax
   43127:	74 1e                	je     43147 <set_pagetable+0x3c>
   43129:	48 8d 05 25 21 00 00 	lea    0x2125(%rip),%rax        # 45255 <complex_keymap+0x175>
   43130:	48 89 c2             	mov    %rax,%rdx
   43133:	be 3c 00 00 00       	mov    $0x3c,%esi
   43138:	48 8d 05 d6 20 00 00 	lea    0x20d6(%rip),%rax        # 45215 <complex_keymap+0x135>
   4313f:	48 89 c7             	mov    %rax,%rdi
   43142:	e8 b2 fd ff ff       	call   42ef9 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   43147:	48 c7 c0 9c 00 04 00 	mov    $0x4009c,%rax
   4314e:	48 89 c2             	mov    %rax,%rdx
   43151:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   43155:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43159:	48 89 ce             	mov    %rcx,%rsi
   4315c:	48 89 c7             	mov    %rax,%rdi
   4315f:	e8 63 05 00 00       	call   436c7 <virtual_memory_lookup>
   43164:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43168:	48 c7 c2 9c 00 04 00 	mov    $0x4009c,%rdx
   4316f:	48 39 d0             	cmp    %rdx,%rax
   43172:	74 1e                	je     43192 <set_pagetable+0x87>
   43174:	48 8d 05 f5 20 00 00 	lea    0x20f5(%rip),%rax        # 45270 <complex_keymap+0x190>
   4317b:	48 89 c2             	mov    %rax,%rdx
   4317e:	be 3e 00 00 00       	mov    $0x3e,%esi
   43183:	48 8d 05 8b 20 00 00 	lea    0x208b(%rip),%rax        # 45215 <complex_keymap+0x135>
   4318a:	48 89 c7             	mov    %rax,%rdi
   4318d:	e8 67 fd ff ff       	call   42ef9 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   43192:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   43196:	48 8b 0d 63 1e 01 00 	mov    0x11e63(%rip),%rcx        # 55000 <kernel_pagetable>
   4319d:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   431a1:	48 89 ce             	mov    %rcx,%rsi
   431a4:	48 89 c7             	mov    %rax,%rdi
   431a7:	e8 1b 05 00 00       	call   436c7 <virtual_memory_lookup>
   431ac:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   431b0:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   431b4:	48 39 c2             	cmp    %rax,%rdx
   431b7:	74 1e                	je     431d7 <set_pagetable+0xcc>
   431b9:	48 8d 05 18 21 00 00 	lea    0x2118(%rip),%rax        # 452d8 <complex_keymap+0x1f8>
   431c0:	48 89 c2             	mov    %rax,%rdx
   431c3:	be 40 00 00 00       	mov    $0x40,%esi
   431c8:	48 8d 05 46 20 00 00 	lea    0x2046(%rip),%rax        # 45215 <complex_keymap+0x135>
   431cf:	48 89 c7             	mov    %rax,%rdi
   431d2:	e8 22 fd ff ff       	call   42ef9 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   431d7:	48 8b 05 22 1e 01 00 	mov    0x11e22(%rip),%rax        # 55000 <kernel_pagetable>
   431de:	48 89 c2             	mov    %rax,%rdx
   431e1:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   431e5:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   431e9:	48 89 ce             	mov    %rcx,%rsi
   431ec:	48 89 c7             	mov    %rax,%rdi
   431ef:	e8 d3 04 00 00       	call   436c7 <virtual_memory_lookup>
   431f4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431f8:	48 8b 15 01 1e 01 00 	mov    0x11e01(%rip),%rdx        # 55000 <kernel_pagetable>
   431ff:	48 39 d0             	cmp    %rdx,%rax
   43202:	74 1e                	je     43222 <set_pagetable+0x117>
   43204:	48 8d 05 2d 21 00 00 	lea    0x212d(%rip),%rax        # 45338 <complex_keymap+0x258>
   4320b:	48 89 c2             	mov    %rax,%rdx
   4320e:	be 42 00 00 00       	mov    $0x42,%esi
   43213:	48 8d 05 fb 1f 00 00 	lea    0x1ffb(%rip),%rax        # 45215 <complex_keymap+0x135>
   4321a:	48 89 c7             	mov    %rax,%rdi
   4321d:	e8 d7 fc ff ff       	call   42ef9 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   43222:	48 8d 15 54 00 00 00 	lea    0x54(%rip),%rdx        # 4327d <virtual_memory_map>
   43229:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4322d:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43231:	48 89 ce             	mov    %rcx,%rsi
   43234:	48 89 c7             	mov    %rax,%rdi
   43237:	e8 8b 04 00 00       	call   436c7 <virtual_memory_lookup>
   4323c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43240:	48 8d 15 36 00 00 00 	lea    0x36(%rip),%rdx        # 4327d <virtual_memory_map>
   43247:	48 39 d0             	cmp    %rdx,%rax
   4324a:	74 1e                	je     4326a <set_pagetable+0x15f>
   4324c:	48 8d 05 4d 21 00 00 	lea    0x214d(%rip),%rax        # 453a0 <complex_keymap+0x2c0>
   43253:	48 89 c2             	mov    %rax,%rdx
   43256:	be 44 00 00 00       	mov    $0x44,%esi
   4325b:	48 8d 05 b3 1f 00 00 	lea    0x1fb3(%rip),%rax        # 45215 <complex_keymap+0x135>
   43262:	48 89 c7             	mov    %rax,%rdi
   43265:	e8 8f fc ff ff       	call   42ef9 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   4326a:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4326e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   43272:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43276:	0f 22 d8             	mov    %rax,%cr3
}
   43279:	90                   	nop
}
   4327a:	90                   	nop
   4327b:	c9                   	leave  
   4327c:	c3                   	ret    

000000000004327d <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   4327d:	f3 0f 1e fa          	endbr64 
   43281:	55                   	push   %rbp
   43282:	48 89 e5             	mov    %rsp,%rbp
   43285:	48 83 ec 50          	sub    $0x50,%rsp
   43289:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4328d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43291:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43295:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
   43299:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4329d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   432a1:	25 ff 0f 00 00       	and    $0xfff,%eax
   432a6:	48 85 c0             	test   %rax,%rax
   432a9:	74 1e                	je     432c9 <virtual_memory_map+0x4c>
   432ab:	48 8d 05 54 21 00 00 	lea    0x2154(%rip),%rax        # 45406 <complex_keymap+0x326>
   432b2:	48 89 c2             	mov    %rax,%rdx
   432b5:	be 65 00 00 00       	mov    $0x65,%esi
   432ba:	48 8d 05 54 1f 00 00 	lea    0x1f54(%rip),%rax        # 45215 <complex_keymap+0x135>
   432c1:	48 89 c7             	mov    %rax,%rdi
   432c4:	e8 30 fc ff ff       	call   42ef9 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   432c9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   432cd:	25 ff 0f 00 00       	and    $0xfff,%eax
   432d2:	48 85 c0             	test   %rax,%rax
   432d5:	74 1e                	je     432f5 <virtual_memory_map+0x78>
   432d7:	48 8d 05 3b 21 00 00 	lea    0x213b(%rip),%rax        # 45419 <complex_keymap+0x339>
   432de:	48 89 c2             	mov    %rax,%rdx
   432e1:	be 66 00 00 00       	mov    $0x66,%esi
   432e6:	48 8d 05 28 1f 00 00 	lea    0x1f28(%rip),%rax        # 45215 <complex_keymap+0x135>
   432ed:	48 89 c7             	mov    %rax,%rdi
   432f0:	e8 04 fc ff ff       	call   42ef9 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   432f5:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   432f9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   432fd:	48 01 d0             	add    %rdx,%rax
   43300:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   43304:	76 2e                	jbe    43334 <virtual_memory_map+0xb7>
   43306:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4330a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4330e:	48 01 d0             	add    %rdx,%rax
   43311:	48 85 c0             	test   %rax,%rax
   43314:	74 1e                	je     43334 <virtual_memory_map+0xb7>
   43316:	48 8d 05 0f 21 00 00 	lea    0x210f(%rip),%rax        # 4542c <complex_keymap+0x34c>
   4331d:	48 89 c2             	mov    %rax,%rdx
   43320:	be 67 00 00 00       	mov    $0x67,%esi
   43325:	48 8d 05 e9 1e 00 00 	lea    0x1ee9(%rip),%rax        # 45215 <complex_keymap+0x135>
   4332c:	48 89 c7             	mov    %rax,%rdi
   4332f:	e8 c5 fb ff ff       	call   42ef9 <assert_fail>
    if (perm & PTE_P) {
   43334:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43337:	48 98                	cltq   
   43339:	83 e0 01             	and    $0x1,%eax
   4333c:	48 85 c0             	test   %rax,%rax
   4333f:	0f 84 8c 00 00 00    	je     433d1 <virtual_memory_map+0x154>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   43345:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43349:	25 ff 0f 00 00       	and    $0xfff,%eax
   4334e:	48 85 c0             	test   %rax,%rax
   43351:	74 1e                	je     43371 <virtual_memory_map+0xf4>
   43353:	48 8d 05 f0 20 00 00 	lea    0x20f0(%rip),%rax        # 4544a <complex_keymap+0x36a>
   4335a:	48 89 c2             	mov    %rax,%rdx
   4335d:	be 69 00 00 00       	mov    $0x69,%esi
   43362:	48 8d 05 ac 1e 00 00 	lea    0x1eac(%rip),%rax        # 45215 <complex_keymap+0x135>
   43369:	48 89 c7             	mov    %rax,%rdi
   4336c:	e8 88 fb ff ff       	call   42ef9 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   43371:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43375:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43379:	48 01 d0             	add    %rdx,%rax
   4337c:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   43380:	76 1e                	jbe    433a0 <virtual_memory_map+0x123>
   43382:	48 8d 05 d4 20 00 00 	lea    0x20d4(%rip),%rax        # 4545d <complex_keymap+0x37d>
   43389:	48 89 c2             	mov    %rax,%rdx
   4338c:	be 6a 00 00 00       	mov    $0x6a,%esi
   43391:	48 8d 05 7d 1e 00 00 	lea    0x1e7d(%rip),%rax        # 45215 <complex_keymap+0x135>
   43398:	48 89 c7             	mov    %rax,%rdi
   4339b:	e8 59 fb ff ff       	call   42ef9 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   433a0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   433a4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   433a8:	48 01 d0             	add    %rdx,%rax
   433ab:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   433b1:	76 1e                	jbe    433d1 <virtual_memory_map+0x154>
   433b3:	48 8d 05 b1 20 00 00 	lea    0x20b1(%rip),%rax        # 4546b <complex_keymap+0x38b>
   433ba:	48 89 c2             	mov    %rax,%rdx
   433bd:	be 6b 00 00 00       	mov    $0x6b,%esi
   433c2:	48 8d 05 4c 1e 00 00 	lea    0x1e4c(%rip),%rax        # 45215 <complex_keymap+0x135>
   433c9:	48 89 c7             	mov    %rax,%rdi
   433cc:	e8 28 fb ff ff       	call   42ef9 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   433d1:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   433d5:	78 09                	js     433e0 <virtual_memory_map+0x163>
   433d7:	81 7d bc ff 0f 00 00 	cmpl   $0xfff,-0x44(%rbp)
   433de:	7e 1e                	jle    433fe <virtual_memory_map+0x181>
   433e0:	48 8d 05 a0 20 00 00 	lea    0x20a0(%rip),%rax        # 45487 <complex_keymap+0x3a7>
   433e7:	48 89 c2             	mov    %rax,%rdx
   433ea:	be 6d 00 00 00       	mov    $0x6d,%esi
   433ef:	48 8d 05 1f 1e 00 00 	lea    0x1e1f(%rip),%rax        # 45215 <complex_keymap+0x135>
   433f6:	48 89 c7             	mov    %rax,%rdi
   433f9:	e8 fb fa ff ff       	call   42ef9 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   433fe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43402:	25 ff 0f 00 00       	and    $0xfff,%eax
   43407:	48 85 c0             	test   %rax,%rax
   4340a:	74 1e                	je     4342a <virtual_memory_map+0x1ad>
   4340c:	48 8d 05 95 20 00 00 	lea    0x2095(%rip),%rax        # 454a8 <complex_keymap+0x3c8>
   43413:	48 89 c2             	mov    %rax,%rdx
   43416:	be 6e 00 00 00       	mov    $0x6e,%esi
   4341b:	48 8d 05 f3 1d 00 00 	lea    0x1df3(%rip),%rax        # 45215 <complex_keymap+0x135>
   43422:	48 89 c7             	mov    %rax,%rdi
   43425:	e8 cf fa ff ff       	call   42ef9 <assert_fail>

    int last_index123 = -1;
   4342a:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   43431:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   43438:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43439:	e9 ed 00 00 00       	jmp    4352b <virtual_memory_map+0x2ae>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   4343e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43442:	48 c1 e8 15          	shr    $0x15,%rax
   43446:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (cur_index123 != last_index123) {
   43449:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4344c:	3b 45 fc             	cmp    -0x4(%rbp),%eax
   4344f:	74 20                	je     43471 <virtual_memory_map+0x1f4>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   43451:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43454:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   43458:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4345c:	48 89 ce             	mov    %rcx,%rsi
   4345f:	48 89 c7             	mov    %rax,%rdi
   43462:	e8 d6 00 00 00       	call   4353d <lookup_l1pagetable>
   43467:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

            last_index123 = cur_index123;
   4346b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4346e:	89 45 fc             	mov    %eax,-0x4(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   43471:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43474:	48 98                	cltq   
   43476:	83 e0 01             	and    $0x1,%eax
   43479:	48 85 c0             	test   %rax,%rax
   4347c:	74 37                	je     434b5 <virtual_memory_map+0x238>
   4347e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43483:	74 30                	je     434b5 <virtual_memory_map+0x238>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   43485:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43489:	be 03 00 00 00       	mov    $0x3,%esi
   4348e:	48 89 c7             	mov    %rax,%rdi
   43491:	e8 da fa ff ff       	call   42f70 <pageindex>
   43496:	89 45 e8             	mov    %eax,-0x18(%rbp)
            l1pagetable->entry[index] = pa | perm;
   43499:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4349c:	48 98                	cltq   
   4349e:	48 0b 45 c8          	or     -0x38(%rbp),%rax
   434a2:	48 89 c1             	mov    %rax,%rcx
   434a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434a9:	8b 55 e8             	mov    -0x18(%rbp),%edx
   434ac:	48 63 d2             	movslq %edx,%rdx
   434af:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   434b3:	eb 5e                	jmp    43513 <virtual_memory_map+0x296>
        } else if (l1pagetable) { // if page is NOT marked present
   434b5:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   434ba:	74 2a                	je     434e6 <virtual_memory_map+0x269>
             int index = PAGEINDEX(va, 3); // Get the index for L1 page table
   434bc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434c0:	be 03 00 00 00       	mov    $0x3,%esi
   434c5:	48 89 c7             	mov    %rax,%rdi
   434c8:	e8 a3 fa ff ff       	call   42f70 <pageindex>
   434cd:	89 45 e4             	mov    %eax,-0x1c(%rbp)
            l1pagetable->entry[index] = 0 | perm;
   434d0:	8b 45 bc             	mov    -0x44(%rbp),%eax
   434d3:	48 63 c8             	movslq %eax,%rcx
   434d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434da:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   434dd:	48 63 d2             	movslq %edx,%rdx
   434e0:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   434e4:	eb 2d                	jmp    43513 <virtual_memory_map+0x296>
        } else if (perm & PTE_P) {
   434e6:	8b 45 bc             	mov    -0x44(%rbp),%eax
   434e9:	48 98                	cltq   
   434eb:	83 e0 01             	and    $0x1,%eax
   434ee:	48 85 c0             	test   %rax,%rax
   434f1:	74 20                	je     43513 <virtual_memory_map+0x296>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   434f3:	be 87 00 00 00       	mov    $0x87,%esi
   434f8:	48 8d 05 d1 1f 00 00 	lea    0x1fd1(%rip),%rax        # 454d0 <complex_keymap+0x3f0>
   434ff:	48 89 c7             	mov    %rax,%rdi
   43502:	b8 00 00 00 00       	mov    $0x0,%eax
   43507:	e8 92 f6 ff ff       	call   42b9e <log_printf>
            return -1;
   4350c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43511:	eb 28                	jmp    4353b <virtual_memory_map+0x2be>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43513:	48 81 45 d0 00 10 00 	addq   $0x1000,-0x30(%rbp)
   4351a:	00 
   4351b:	48 81 45 c8 00 10 00 	addq   $0x1000,-0x38(%rbp)
   43522:	00 
   43523:	48 81 6d c0 00 10 00 	subq   $0x1000,-0x40(%rbp)
   4352a:	00 
   4352b:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   43530:	0f 85 08 ff ff ff    	jne    4343e <virtual_memory_map+0x1c1>
        }
    }
    return 0;
   43536:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4353b:	c9                   	leave  
   4353c:	c3                   	ret    

000000000004353d <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   4353d:	f3 0f 1e fa          	endbr64 
   43541:	55                   	push   %rbp
   43542:	48 89 e5             	mov    %rsp,%rbp
   43545:	48 83 ec 40          	sub    $0x40,%rsp
   43549:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4354d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43551:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   43554:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43558:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   4355c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   43563:	e9 4f 01 00 00       	jmp    436b7 <lookup_l1pagetable+0x17a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        int index = PAGEINDEX(va, i); // Get the index for the current level
   43568:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4356b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4356f:	89 d6                	mov    %edx,%esi
   43571:	48 89 c7             	mov    %rax,%rdi
   43574:	e8 f7 f9 ff ff       	call   42f70 <pageindex>
   43579:	89 45 f0             	mov    %eax,-0x10(%rbp)
        x86_64_pageentry_t pe = pt->entry[index];
   4357c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43580:	8b 55 f0             	mov    -0x10(%rbp),%edx
   43583:	48 63 d2             	movslq %edx,%rdx
   43586:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4358a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   4358e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43592:	83 e0 01             	and    $0x1,%eax
   43595:	48 85 c0             	test   %rax,%rax
   43598:	75 6d                	jne    43607 <lookup_l1pagetable+0xca>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   4359a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4359d:	8d 48 02             	lea    0x2(%rax),%ecx
   435a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435a4:	25 ff 0f 00 00       	and    $0xfff,%eax
   435a9:	48 89 c2             	mov    %rax,%rdx
   435ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435b0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   435b6:	48 89 c6             	mov    %rax,%rsi
   435b9:	48 8d 05 58 1f 00 00 	lea    0x1f58(%rip),%rax        # 45518 <complex_keymap+0x438>
   435c0:	48 89 c7             	mov    %rax,%rdi
   435c3:	b8 00 00 00 00       	mov    $0x0,%eax
   435c8:	e8 d1 f5 ff ff       	call   42b9e <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   435cd:	8b 45 cc             	mov    -0x34(%rbp),%eax
   435d0:	48 98                	cltq   
   435d2:	83 e0 01             	and    $0x1,%eax
   435d5:	48 85 c0             	test   %rax,%rax
   435d8:	75 0a                	jne    435e4 <lookup_l1pagetable+0xa7>
                return NULL;
   435da:	b8 00 00 00 00       	mov    $0x0,%eax
   435df:	e9 e1 00 00 00       	jmp    436c5 <lookup_l1pagetable+0x188>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   435e4:	be ac 00 00 00       	mov    $0xac,%esi
   435e9:	48 8d 05 90 1f 00 00 	lea    0x1f90(%rip),%rax        # 45580 <complex_keymap+0x4a0>
   435f0:	48 89 c7             	mov    %rax,%rdi
   435f3:	b8 00 00 00 00       	mov    $0x0,%eax
   435f8:	e8 a1 f5 ff ff       	call   42b9e <log_printf>
            return NULL;
   435fd:	b8 00 00 00 00       	mov    $0x0,%eax
   43602:	e9 be 00 00 00       	jmp    436c5 <lookup_l1pagetable+0x188>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   43607:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4360b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43611:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   43617:	76 1e                	jbe    43637 <lookup_l1pagetable+0xfa>
   43619:	48 8d 05 a8 1f 00 00 	lea    0x1fa8(%rip),%rax        # 455c8 <complex_keymap+0x4e8>
   43620:	48 89 c2             	mov    %rax,%rdx
   43623:	be b1 00 00 00       	mov    $0xb1,%esi
   43628:	48 8d 05 e6 1b 00 00 	lea    0x1be6(%rip),%rax        # 45215 <complex_keymap+0x135>
   4362f:	48 89 c7             	mov    %rax,%rdi
   43632:	e8 c2 f8 ff ff       	call   42ef9 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   43637:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4363a:	48 98                	cltq   
   4363c:	83 e0 02             	and    $0x2,%eax
   4363f:	48 85 c0             	test   %rax,%rax
   43642:	74 2a                	je     4366e <lookup_l1pagetable+0x131>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   43644:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43648:	83 e0 02             	and    $0x2,%eax
   4364b:	48 85 c0             	test   %rax,%rax
   4364e:	75 1e                	jne    4366e <lookup_l1pagetable+0x131>
   43650:	48 8d 05 91 1f 00 00 	lea    0x1f91(%rip),%rax        # 455e8 <complex_keymap+0x508>
   43657:	48 89 c2             	mov    %rax,%rdx
   4365a:	be b3 00 00 00       	mov    $0xb3,%esi
   4365f:	48 8d 05 af 1b 00 00 	lea    0x1baf(%rip),%rax        # 45215 <complex_keymap+0x135>
   43666:	48 89 c7             	mov    %rax,%rdi
   43669:	e8 8b f8 ff ff       	call   42ef9 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   4366e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43671:	48 98                	cltq   
   43673:	83 e0 04             	and    $0x4,%eax
   43676:	48 85 c0             	test   %rax,%rax
   43679:	74 2a                	je     436a5 <lookup_l1pagetable+0x168>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   4367b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4367f:	83 e0 04             	and    $0x4,%eax
   43682:	48 85 c0             	test   %rax,%rax
   43685:	75 1e                	jne    436a5 <lookup_l1pagetable+0x168>
   43687:	48 8d 05 65 1f 00 00 	lea    0x1f65(%rip),%rax        # 455f3 <complex_keymap+0x513>
   4368e:	48 89 c2             	mov    %rax,%rdx
   43691:	be b6 00 00 00       	mov    $0xb6,%esi
   43696:	48 8d 05 78 1b 00 00 	lea    0x1b78(%rip),%rax        # 45215 <complex_keymap+0x135>
   4369d:	48 89 c7             	mov    %rax,%rdi
   436a0:	e8 54 f8 ff ff       	call   42ef9 <assert_fail>
        }
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   436a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436a9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   436af:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   436b3:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   436b7:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   436bb:	0f 8e a7 fe ff ff    	jle    43568 <lookup_l1pagetable+0x2b>
    }
    return pt;
   436c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   436c5:	c9                   	leave  
   436c6:	c3                   	ret    

00000000000436c7 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   436c7:	f3 0f 1e fa          	endbr64 
   436cb:	55                   	push   %rbp
   436cc:	48 89 e5             	mov    %rsp,%rbp
   436cf:	48 83 ec 50          	sub    $0x50,%rsp
   436d3:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   436d7:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   436db:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   436df:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   436e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   436e7:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   436ee:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   436ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   436f6:	eb 41                	jmp    43739 <virtual_memory_lookup+0x72>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   436f8:	8b 55 ec             	mov    -0x14(%rbp),%edx
   436fb:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   436ff:	89 d6                	mov    %edx,%esi
   43701:	48 89 c7             	mov    %rax,%rdi
   43704:	e8 67 f8 ff ff       	call   42f70 <pageindex>
   43709:	89 c2                	mov    %eax,%edx
   4370b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4370f:	48 63 d2             	movslq %edx,%rdx
   43712:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43716:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4371a:	83 e0 06             	and    $0x6,%eax
   4371d:	48 f7 d0             	not    %rax
   43720:	48 21 d0             	and    %rdx,%rax
   43723:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43727:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4372b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43731:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43735:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43739:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4373d:	7f 0c                	jg     4374b <virtual_memory_lookup+0x84>
   4373f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43743:	83 e0 01             	and    $0x1,%eax
   43746:	48 85 c0             	test   %rax,%rax
   43749:	75 ad                	jne    436f8 <virtual_memory_lookup+0x31>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   4374b:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43752:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   43759:	ff 
   4375a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   43761:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43765:	83 e0 01             	and    $0x1,%eax
   43768:	48 85 c0             	test   %rax,%rax
   4376b:	74 34                	je     437a1 <virtual_memory_lookup+0xda>
        vam.pn = PAGENUMBER(pe);
   4376d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43771:	48 c1 e8 0c          	shr    $0xc,%rax
   43775:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43778:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4377c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43782:	48 89 c2             	mov    %rax,%rdx
   43785:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43789:	25 ff 0f 00 00       	and    $0xfff,%eax
   4378e:	48 09 d0             	or     %rdx,%rax
   43791:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   43795:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43799:	25 ff 0f 00 00       	and    $0xfff,%eax
   4379e:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   437a1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   437a5:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   437a9:	48 89 10             	mov    %rdx,(%rax)
   437ac:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   437b0:	48 89 50 08          	mov    %rdx,0x8(%rax)
   437b4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   437b8:	48 89 50 10          	mov    %rdx,0x10(%rax)
   437bc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   437c0:	c9                   	leave  
   437c1:	c3                   	ret    

00000000000437c2 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   437c2:	f3 0f 1e fa          	endbr64 
   437c6:	55                   	push   %rbp
   437c7:	48 89 e5             	mov    %rsp,%rbp
   437ca:	48 83 ec 40          	sub    $0x40,%rsp
   437ce:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   437d2:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   437d5:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   437d9:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   437e0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   437e4:	78 08                	js     437ee <program_load+0x2c>
   437e6:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   437e9:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   437ec:	7c 1e                	jl     4380c <program_load+0x4a>
   437ee:	48 8d 05 0b 1e 00 00 	lea    0x1e0b(%rip),%rax        # 45600 <complex_keymap+0x520>
   437f5:	48 89 c2             	mov    %rax,%rdx
   437f8:	be 37 00 00 00       	mov    $0x37,%esi
   437fd:	48 8d 05 2c 1e 00 00 	lea    0x1e2c(%rip),%rax        # 45630 <complex_keymap+0x550>
   43804:	48 89 c7             	mov    %rax,%rdi
   43807:	e8 ed f6 ff ff       	call   42ef9 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4380c:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   4380f:	48 98                	cltq   
   43811:	48 c1 e0 04          	shl    $0x4,%rax
   43815:	48 89 c2             	mov    %rax,%rdx
   43818:	48 8d 05 01 28 00 00 	lea    0x2801(%rip),%rax        # 46020 <ramimages>
   4381f:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
   43823:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43827:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4382b:	8b 00                	mov    (%rax),%eax
   4382d:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43832:	74 1e                	je     43852 <program_load+0x90>
   43834:	48 8d 05 07 1e 00 00 	lea    0x1e07(%rip),%rax        # 45642 <complex_keymap+0x562>
   4383b:	48 89 c2             	mov    %rax,%rdx
   4383e:	be 39 00 00 00       	mov    $0x39,%esi
   43843:	48 8d 05 e6 1d 00 00 	lea    0x1de6(%rip),%rax        # 45630 <complex_keymap+0x550>
   4384a:	48 89 c7             	mov    %rax,%rdi
   4384d:	e8 a7 f6 ff ff       	call   42ef9 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43852:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43856:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4385a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4385e:	48 01 d0             	add    %rdx,%rax
   43861:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43865:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4386c:	e9 94 00 00 00       	jmp    43905 <program_load+0x143>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43871:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43874:	48 63 d0             	movslq %eax,%rdx
   43877:	48 89 d0             	mov    %rdx,%rax
   4387a:	48 c1 e0 03          	shl    $0x3,%rax
   4387e:	48 29 d0             	sub    %rdx,%rax
   43881:	48 c1 e0 03          	shl    $0x3,%rax
   43885:	48 89 c2             	mov    %rax,%rdx
   43888:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4388c:	48 01 d0             	add    %rdx,%rax
   4388f:	8b 00                	mov    (%rax),%eax
   43891:	83 f8 01             	cmp    $0x1,%eax
   43894:	75 6b                	jne    43901 <program_load+0x13f>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   43896:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43899:	48 63 d0             	movslq %eax,%rdx
   4389c:	48 89 d0             	mov    %rdx,%rax
   4389f:	48 c1 e0 03          	shl    $0x3,%rax
   438a3:	48 29 d0             	sub    %rdx,%rax
   438a6:	48 c1 e0 03          	shl    $0x3,%rax
   438aa:	48 89 c2             	mov    %rax,%rdx
   438ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438b1:	48 01 d0             	add    %rdx,%rax
   438b4:	48 8b 50 08          	mov    0x8(%rax),%rdx
   438b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438bc:	48 01 d0             	add    %rdx,%rax
   438bf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   438c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   438c6:	48 63 d0             	movslq %eax,%rdx
   438c9:	48 89 d0             	mov    %rdx,%rax
   438cc:	48 c1 e0 03          	shl    $0x3,%rax
   438d0:	48 29 d0             	sub    %rdx,%rax
   438d3:	48 c1 e0 03          	shl    $0x3,%rax
   438d7:	48 89 c2             	mov    %rax,%rdx
   438da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438de:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   438e2:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   438e6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   438ea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   438ee:	48 89 c7             	mov    %rax,%rdi
   438f1:	e8 3d 00 00 00       	call   43933 <program_load_segment>
   438f6:	85 c0                	test   %eax,%eax
   438f8:	79 07                	jns    43901 <program_load+0x13f>
                return -1;
   438fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438ff:	eb 30                	jmp    43931 <program_load+0x16f>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43901:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43905:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43909:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   4390d:	0f b7 c0             	movzwl %ax,%eax
   43910:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43913:	0f 8c 58 ff ff ff    	jl     43871 <program_load+0xaf>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   43919:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4391d:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43921:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43925:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   4392c:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43931:	c9                   	leave  
   43932:	c3                   	ret    

0000000000043933 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43933:	f3 0f 1e fa          	endbr64 
   43937:	55                   	push   %rbp
   43938:	48 89 e5             	mov    %rsp,%rbp
   4393b:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4393f:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
   43943:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
   43947:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   4394b:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4394f:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43953:	48 8b 40 10          	mov    0x10(%rax),%rax
   43957:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4395b:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   4395f:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43963:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43967:	48 01 d0             	add    %rdx,%rax
   4396a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4396e:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43972:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43976:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4397a:	48 01 d0             	add    %rdx,%rax
   4397d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43981:	48 81 65 e0 00 f0 ff 	andq   $0xfffffffffffff000,-0x20(%rbp)
   43988:	ff 

    int perms = PTE_P | PTE_W | PTE_U;
   43989:	c7 45 fc 07 00 00 00 	movl   $0x7,-0x4(%rbp)
    if ((ph->p_flags & ELF_PFLAG_WRITE) == 0){
   43990:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   43994:	8b 40 04             	mov    0x4(%rax),%eax
   43997:	83 e0 02             	and    $0x2,%eax
   4399a:	85 c0                	test   %eax,%eax
   4399c:	75 07                	jne    439a5 <program_load_segment+0x72>
        perms = PTE_P | PTE_U;
   4399e:	c7 45 fc 05 00 00 00 	movl   $0x5,-0x4(%rbp)
    }
    uintptr_t pa = 0;
   439a5:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
   439ac:	00 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   439ad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   439b1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   439b5:	eb 7d                	jmp    43a34 <program_load_segment+0x101>
        pa = find_page(p->p_pid);
   439b7:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   439bb:	8b 00                	mov    (%rax),%eax
   439bd:	0f be c0             	movsbl %al,%eax
   439c0:	89 c7                	mov    %eax,%edi
   439c2:	e8 3d ca ff ff       	call   40404 <find_page>
   439c7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   439cb:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   439cf:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   439d6:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   439da:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   439de:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   439e4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   439e9:	48 89 c7             	mov    %rax,%rdi
   439ec:	e8 8c f8 ff ff       	call   4327d <virtual_memory_map>
   439f1:	85 c0                	test   %eax,%eax
   439f3:	79 37                	jns    43a2c <program_load_segment+0xf9>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   439f5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   439f9:	8b 00                	mov    (%rax),%eax
   439fb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   439ff:	49 89 d0             	mov    %rdx,%r8
   43a02:	89 c1                	mov    %eax,%ecx
   43a04:	48 8d 05 55 1c 00 00 	lea    0x1c55(%rip),%rax        # 45660 <complex_keymap+0x580>
   43a0b:	48 89 c2             	mov    %rax,%rdx
   43a0e:	be 00 c0 00 00       	mov    $0xc000,%esi
   43a13:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43a18:	b8 00 00 00 00       	mov    $0x0,%eax
   43a1d:	e8 6c 10 00 00       	call   44a8e <console_printf>
            return -1;
   43a22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a27:	e9 1b 01 00 00       	jmp    43b47 <program_load_segment+0x214>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43a2c:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43a33:	00 
   43a34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43a38:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   43a3c:	0f 82 75 ff ff ff    	jb     439b7 <program_load_segment+0x84>
        }
    }
    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43a42:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43a46:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43a4d:	48 89 c7             	mov    %rax,%rdi
   43a50:	e8 b6 f6 ff ff       	call   4310b <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43a55:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a59:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   43a5d:	48 89 c2             	mov    %rax,%rdx
   43a60:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a64:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   43a68:	48 89 ce             	mov    %rcx,%rsi
   43a6b:	48 89 c7             	mov    %rax,%rdi
   43a6e:	e8 d6 00 00 00       	call   43b49 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43a73:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43a77:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
   43a7b:	48 89 c2             	mov    %rax,%rdx
   43a7e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a82:	be 00 00 00 00       	mov    $0x0,%esi
   43a87:	48 89 c7             	mov    %rax,%rdi
   43a8a:	e8 c0 01 00 00       	call   43c4f <memset>
    
    // update perms
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43a8f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a93:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43a97:	e9 89 00 00 00       	jmp    43b25 <program_load_segment+0x1f2>
        vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   43a9c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43aa0:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   43aa7:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   43aab:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   43aaf:	48 89 ce             	mov    %rcx,%rsi
   43ab2:	48 89 c7             	mov    %rax,%rdi
   43ab5:	e8 0d fc ff ff       	call   436c7 <virtual_memory_lookup>
        int r = virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   43aba:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   43abe:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43ac2:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43ac9:	8b 4d fc             	mov    -0x4(%rbp),%ecx
   43acc:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   43ad0:	41 89 c8             	mov    %ecx,%r8d
   43ad3:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43ad8:	48 89 c7             	mov    %rax,%rdi
   43adb:	e8 9d f7 ff ff       	call   4327d <virtual_memory_map>
   43ae0:	89 45 c4             	mov    %eax,-0x3c(%rbp)
                                  perms);
        if (r < 0){
   43ae3:	83 7d c4 00          	cmpl   $0x0,-0x3c(%rbp)
   43ae7:	79 34                	jns    43b1d <program_load_segment+0x1ea>
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43ae9:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   43aed:	8b 00                	mov    (%rax),%eax
   43aef:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   43af3:	49 89 d0             	mov    %rdx,%r8
   43af6:	89 c1                	mov    %eax,%ecx
   43af8:	48 8d 05 61 1b 00 00 	lea    0x1b61(%rip),%rax        # 45660 <complex_keymap+0x580>
   43aff:	48 89 c2             	mov    %rax,%rdx
   43b02:	be 00 c0 00 00       	mov    $0xc000,%esi
   43b07:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43b0c:	b8 00 00 00 00       	mov    $0x0,%eax
   43b11:	e8 78 0f 00 00       	call   44a8e <console_printf>
            return -1;
   43b16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b1b:	eb 2a                	jmp    43b47 <program_load_segment+0x214>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43b1d:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
   43b24:	00 
   43b25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b29:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   43b2d:	0f 82 69 ff ff ff    	jb     43a9c <program_load_segment+0x169>
        }
        }


    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43b33:	48 8b 05 c6 14 01 00 	mov    0x114c6(%rip),%rax        # 55000 <kernel_pagetable>
   43b3a:	48 89 c7             	mov    %rax,%rdi
   43b3d:	e8 c9 f5 ff ff       	call   4310b <set_pagetable>
    return 0;
   43b42:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43b47:	c9                   	leave  
   43b48:	c3                   	ret    

0000000000043b49 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43b49:	f3 0f 1e fa          	endbr64 
   43b4d:	55                   	push   %rbp
   43b4e:	48 89 e5             	mov    %rsp,%rbp
   43b51:	48 83 ec 28          	sub    $0x28,%rsp
   43b55:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b59:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43b5d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43b61:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43b65:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43b69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b6d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43b71:	eb 1c                	jmp    43b8f <memcpy+0x46>
        *d = *s;
   43b73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b77:	0f b6 10             	movzbl (%rax),%edx
   43b7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b7e:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43b80:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43b85:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43b8a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43b8f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43b94:	75 dd                	jne    43b73 <memcpy+0x2a>
    }
    return dst;
   43b96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43b9a:	c9                   	leave  
   43b9b:	c3                   	ret    

0000000000043b9c <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43b9c:	f3 0f 1e fa          	endbr64 
   43ba0:	55                   	push   %rbp
   43ba1:	48 89 e5             	mov    %rsp,%rbp
   43ba4:	48 83 ec 28          	sub    $0x28,%rsp
   43ba8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43bac:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43bb0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43bb4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43bb8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43bbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bc0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43bc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bc8:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43bcc:	73 6a                	jae    43c38 <memmove+0x9c>
   43bce:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43bd2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43bd6:	48 01 d0             	add    %rdx,%rax
   43bd9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43bdd:	73 59                	jae    43c38 <memmove+0x9c>
        s += n, d += n;
   43bdf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43be3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43be7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43beb:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43bef:	eb 17                	jmp    43c08 <memmove+0x6c>
            *--d = *--s;
   43bf1:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43bf6:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43bfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bff:	0f b6 10             	movzbl (%rax),%edx
   43c02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c06:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43c08:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c0c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43c10:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43c14:	48 85 c0             	test   %rax,%rax
   43c17:	75 d8                	jne    43bf1 <memmove+0x55>
    if (s < d && s + n > d) {
   43c19:	eb 2e                	jmp    43c49 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43c1b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c1f:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43c23:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c27:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c2b:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43c2f:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43c33:	0f b6 12             	movzbl (%rdx),%edx
   43c36:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43c38:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c3c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43c40:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43c44:	48 85 c0             	test   %rax,%rax
   43c47:	75 d2                	jne    43c1b <memmove+0x7f>
        }
    }
    return dst;
   43c49:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43c4d:	c9                   	leave  
   43c4e:	c3                   	ret    

0000000000043c4f <memset>:

void* memset(void* v, int c, size_t n) {
   43c4f:	f3 0f 1e fa          	endbr64 
   43c53:	55                   	push   %rbp
   43c54:	48 89 e5             	mov    %rsp,%rbp
   43c57:	48 83 ec 28          	sub    $0x28,%rsp
   43c5b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c5f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43c62:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43c66:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c6a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c6e:	eb 15                	jmp    43c85 <memset+0x36>
        *p = c;
   43c70:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43c73:	89 c2                	mov    %eax,%edx
   43c75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c79:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43c7b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43c80:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43c85:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43c8a:	75 e4                	jne    43c70 <memset+0x21>
    }
    return v;
   43c8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43c90:	c9                   	leave  
   43c91:	c3                   	ret    

0000000000043c92 <strlen>:

size_t strlen(const char* s) {
   43c92:	f3 0f 1e fa          	endbr64 
   43c96:	55                   	push   %rbp
   43c97:	48 89 e5             	mov    %rsp,%rbp
   43c9a:	48 83 ec 18          	sub    $0x18,%rsp
   43c9e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43ca2:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43ca9:	00 
   43caa:	eb 0a                	jmp    43cb6 <strlen+0x24>
        ++n;
   43cac:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43cb1:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43cb6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cba:	0f b6 00             	movzbl (%rax),%eax
   43cbd:	84 c0                	test   %al,%al
   43cbf:	75 eb                	jne    43cac <strlen+0x1a>
    }
    return n;
   43cc1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43cc5:	c9                   	leave  
   43cc6:	c3                   	ret    

0000000000043cc7 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43cc7:	f3 0f 1e fa          	endbr64 
   43ccb:	55                   	push   %rbp
   43ccc:	48 89 e5             	mov    %rsp,%rbp
   43ccf:	48 83 ec 20          	sub    $0x20,%rsp
   43cd3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43cd7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43cdb:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43ce2:	00 
   43ce3:	eb 0a                	jmp    43cef <strnlen+0x28>
        ++n;
   43ce5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43cea:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43cef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cf3:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43cf7:	74 0b                	je     43d04 <strnlen+0x3d>
   43cf9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cfd:	0f b6 00             	movzbl (%rax),%eax
   43d00:	84 c0                	test   %al,%al
   43d02:	75 e1                	jne    43ce5 <strnlen+0x1e>
    }
    return n;
   43d04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43d08:	c9                   	leave  
   43d09:	c3                   	ret    

0000000000043d0a <strcpy>:

char* strcpy(char* dst, const char* src) {
   43d0a:	f3 0f 1e fa          	endbr64 
   43d0e:	55                   	push   %rbp
   43d0f:	48 89 e5             	mov    %rsp,%rbp
   43d12:	48 83 ec 20          	sub    $0x20,%rsp
   43d16:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d1a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43d1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43d26:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43d2a:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43d2e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43d32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d36:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43d3a:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43d3e:	0f b6 12             	movzbl (%rdx),%edx
   43d41:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43d43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d47:	48 83 e8 01          	sub    $0x1,%rax
   43d4b:	0f b6 00             	movzbl (%rax),%eax
   43d4e:	84 c0                	test   %al,%al
   43d50:	75 d4                	jne    43d26 <strcpy+0x1c>
    return dst;
   43d52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43d56:	c9                   	leave  
   43d57:	c3                   	ret    

0000000000043d58 <strcmp>:

int strcmp(const char* a, const char* b) {
   43d58:	f3 0f 1e fa          	endbr64 
   43d5c:	55                   	push   %rbp
   43d5d:	48 89 e5             	mov    %rsp,%rbp
   43d60:	48 83 ec 10          	sub    $0x10,%rsp
   43d64:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43d68:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43d6c:	eb 0a                	jmp    43d78 <strcmp+0x20>
        ++a, ++b;
   43d6e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43d73:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43d78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d7c:	0f b6 00             	movzbl (%rax),%eax
   43d7f:	84 c0                	test   %al,%al
   43d81:	74 1d                	je     43da0 <strcmp+0x48>
   43d83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d87:	0f b6 00             	movzbl (%rax),%eax
   43d8a:	84 c0                	test   %al,%al
   43d8c:	74 12                	je     43da0 <strcmp+0x48>
   43d8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d92:	0f b6 10             	movzbl (%rax),%edx
   43d95:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d99:	0f b6 00             	movzbl (%rax),%eax
   43d9c:	38 c2                	cmp    %al,%dl
   43d9e:	74 ce                	je     43d6e <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43da0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43da4:	0f b6 00             	movzbl (%rax),%eax
   43da7:	89 c2                	mov    %eax,%edx
   43da9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43dad:	0f b6 00             	movzbl (%rax),%eax
   43db0:	38 c2                	cmp    %al,%dl
   43db2:	0f 97 c0             	seta   %al
   43db5:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43db8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dbc:	0f b6 00             	movzbl (%rax),%eax
   43dbf:	89 c1                	mov    %eax,%ecx
   43dc1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43dc5:	0f b6 00             	movzbl (%rax),%eax
   43dc8:	38 c1                	cmp    %al,%cl
   43dca:	0f 92 c0             	setb   %al
   43dcd:	0f b6 c8             	movzbl %al,%ecx
   43dd0:	89 d0                	mov    %edx,%eax
   43dd2:	29 c8                	sub    %ecx,%eax
}
   43dd4:	c9                   	leave  
   43dd5:	c3                   	ret    

0000000000043dd6 <strchr>:

char* strchr(const char* s, int c) {
   43dd6:	f3 0f 1e fa          	endbr64 
   43dda:	55                   	push   %rbp
   43ddb:	48 89 e5             	mov    %rsp,%rbp
   43dde:	48 83 ec 10          	sub    $0x10,%rsp
   43de2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43de6:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43de9:	eb 05                	jmp    43df0 <strchr+0x1a>
        ++s;
   43deb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43df0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43df4:	0f b6 00             	movzbl (%rax),%eax
   43df7:	84 c0                	test   %al,%al
   43df9:	74 0e                	je     43e09 <strchr+0x33>
   43dfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dff:	0f b6 00             	movzbl (%rax),%eax
   43e02:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e05:	38 d0                	cmp    %dl,%al
   43e07:	75 e2                	jne    43deb <strchr+0x15>
    }
    if (*s == (char) c) {
   43e09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e0d:	0f b6 00             	movzbl (%rax),%eax
   43e10:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e13:	38 d0                	cmp    %dl,%al
   43e15:	75 06                	jne    43e1d <strchr+0x47>
        return (char*) s;
   43e17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e1b:	eb 05                	jmp    43e22 <strchr+0x4c>
    } else {
        return NULL;
   43e1d:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43e22:	c9                   	leave  
   43e23:	c3                   	ret    

0000000000043e24 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43e24:	f3 0f 1e fa          	endbr64 
   43e28:	55                   	push   %rbp
   43e29:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43e2c:	8b 05 ce 71 01 00    	mov    0x171ce(%rip),%eax        # 5b000 <rand_seed_set>
   43e32:	85 c0                	test   %eax,%eax
   43e34:	75 0a                	jne    43e40 <rand+0x1c>
        srand(819234718U);
   43e36:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43e3b:	e8 24 00 00 00       	call   43e64 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43e40:	8b 05 be 71 01 00    	mov    0x171be(%rip),%eax        # 5b004 <rand_seed>
   43e46:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43e4c:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43e51:	89 05 ad 71 01 00    	mov    %eax,0x171ad(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   43e57:	8b 05 a7 71 01 00    	mov    0x171a7(%rip),%eax        # 5b004 <rand_seed>
   43e5d:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43e62:	5d                   	pop    %rbp
   43e63:	c3                   	ret    

0000000000043e64 <srand>:

void srand(unsigned seed) {
   43e64:	f3 0f 1e fa          	endbr64 
   43e68:	55                   	push   %rbp
   43e69:	48 89 e5             	mov    %rsp,%rbp
   43e6c:	48 83 ec 08          	sub    $0x8,%rsp
   43e70:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43e73:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43e76:	89 05 88 71 01 00    	mov    %eax,0x17188(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   43e7c:	c7 05 7a 71 01 00 01 	movl   $0x1,0x1717a(%rip)        # 5b000 <rand_seed_set>
   43e83:	00 00 00 
}
   43e86:	90                   	nop
   43e87:	c9                   	leave  
   43e88:	c3                   	ret    

0000000000043e89 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43e89:	f3 0f 1e fa          	endbr64 
   43e8d:	55                   	push   %rbp
   43e8e:	48 89 e5             	mov    %rsp,%rbp
   43e91:	48 83 ec 28          	sub    $0x28,%rsp
   43e95:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43e99:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43e9d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43ea0:	48 8d 05 f9 18 00 00 	lea    0x18f9(%rip),%rax        # 457a0 <upper_digits.1>
   43ea7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
   43eab:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43eaf:	79 0e                	jns    43ebf <fill_numbuf+0x36>
        digits = lower_digits;
   43eb1:	48 8d 05 08 19 00 00 	lea    0x1908(%rip),%rax        # 457c0 <lower_digits.0>
   43eb8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
   43ebc:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43ebf:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43ec4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ec8:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43ecb:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43ece:	48 63 c8             	movslq %eax,%rcx
   43ed1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ed5:	ba 00 00 00 00       	mov    $0x0,%edx
   43eda:	48 f7 f1             	div    %rcx
   43edd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ee1:	48 01 d0             	add    %rdx,%rax
   43ee4:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43ee9:	0f b6 10             	movzbl (%rax),%edx
   43eec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ef0:	88 10                	mov    %dl,(%rax)
        val /= base;
   43ef2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43ef5:	48 63 f0             	movslq %eax,%rsi
   43ef8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43efc:	ba 00 00 00 00       	mov    $0x0,%edx
   43f01:	48 f7 f6             	div    %rsi
   43f04:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43f08:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43f0d:	75 bc                	jne    43ecb <fill_numbuf+0x42>
    return numbuf_end;
   43f0f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43f13:	c9                   	leave  
   43f14:	c3                   	ret    

0000000000043f15 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43f15:	f3 0f 1e fa          	endbr64 
   43f19:	55                   	push   %rbp
   43f1a:	48 89 e5             	mov    %rsp,%rbp
   43f1d:	53                   	push   %rbx
   43f1e:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43f25:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43f2c:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43f32:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43f39:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43f40:	e9 bd 09 00 00       	jmp    44902 <printer_vprintf+0x9ed>
        if (*format != '%') {
   43f45:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f4c:	0f b6 00             	movzbl (%rax),%eax
   43f4f:	3c 25                	cmp    $0x25,%al
   43f51:	74 31                	je     43f84 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
   43f53:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f5a:	4c 8b 00             	mov    (%rax),%r8
   43f5d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f64:	0f b6 00             	movzbl (%rax),%eax
   43f67:	0f b6 c8             	movzbl %al,%ecx
   43f6a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f70:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f77:	89 ce                	mov    %ecx,%esi
   43f79:	48 89 c7             	mov    %rax,%rdi
   43f7c:	41 ff d0             	call   *%r8
            continue;
   43f7f:	e9 76 09 00 00       	jmp    448fa <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
   43f84:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43f8b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43f92:	01 
   43f93:	eb 4d                	jmp    43fe2 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
   43f95:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f9c:	0f b6 00             	movzbl (%rax),%eax
   43f9f:	0f be c0             	movsbl %al,%eax
   43fa2:	89 c6                	mov    %eax,%esi
   43fa4:	48 8d 05 f5 16 00 00 	lea    0x16f5(%rip),%rax        # 456a0 <flag_chars>
   43fab:	48 89 c7             	mov    %rax,%rdi
   43fae:	e8 23 fe ff ff       	call   43dd6 <strchr>
   43fb3:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43fb7:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43fbc:	74 34                	je     43ff2 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
   43fbe:	48 8d 15 db 16 00 00 	lea    0x16db(%rip),%rdx        # 456a0 <flag_chars>
   43fc5:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43fc9:	48 29 d0             	sub    %rdx,%rax
   43fcc:	ba 01 00 00 00       	mov    $0x1,%edx
   43fd1:	89 c1                	mov    %eax,%ecx
   43fd3:	d3 e2                	shl    %cl,%edx
   43fd5:	89 d0                	mov    %edx,%eax
   43fd7:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43fda:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fe1:	01 
   43fe2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fe9:	0f b6 00             	movzbl (%rax),%eax
   43fec:	84 c0                	test   %al,%al
   43fee:	75 a5                	jne    43f95 <printer_vprintf+0x80>
   43ff0:	eb 01                	jmp    43ff3 <printer_vprintf+0xde>
            } else {
                break;
   43ff2:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43ff3:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43ffa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44001:	0f b6 00             	movzbl (%rax),%eax
   44004:	3c 30                	cmp    $0x30,%al
   44006:	7e 67                	jle    4406f <printer_vprintf+0x15a>
   44008:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4400f:	0f b6 00             	movzbl (%rax),%eax
   44012:	3c 39                	cmp    $0x39,%al
   44014:	7f 59                	jg     4406f <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44016:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   4401d:	eb 2e                	jmp    4404d <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
   4401f:	8b 55 e8             	mov    -0x18(%rbp),%edx
   44022:	89 d0                	mov    %edx,%eax
   44024:	c1 e0 02             	shl    $0x2,%eax
   44027:	01 d0                	add    %edx,%eax
   44029:	01 c0                	add    %eax,%eax
   4402b:	89 c1                	mov    %eax,%ecx
   4402d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44034:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44038:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4403f:	0f b6 00             	movzbl (%rax),%eax
   44042:	0f be c0             	movsbl %al,%eax
   44045:	01 c8                	add    %ecx,%eax
   44047:	83 e8 30             	sub    $0x30,%eax
   4404a:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4404d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44054:	0f b6 00             	movzbl (%rax),%eax
   44057:	3c 2f                	cmp    $0x2f,%al
   44059:	0f 8e 85 00 00 00    	jle    440e4 <printer_vprintf+0x1cf>
   4405f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44066:	0f b6 00             	movzbl (%rax),%eax
   44069:	3c 39                	cmp    $0x39,%al
   4406b:	7e b2                	jle    4401f <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
   4406d:	eb 75                	jmp    440e4 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
   4406f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44076:	0f b6 00             	movzbl (%rax),%eax
   44079:	3c 2a                	cmp    $0x2a,%al
   4407b:	75 68                	jne    440e5 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
   4407d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44084:	8b 00                	mov    (%rax),%eax
   44086:	83 f8 2f             	cmp    $0x2f,%eax
   44089:	77 30                	ja     440bb <printer_vprintf+0x1a6>
   4408b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44092:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44096:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4409d:	8b 00                	mov    (%rax),%eax
   4409f:	89 c0                	mov    %eax,%eax
   440a1:	48 01 d0             	add    %rdx,%rax
   440a4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440ab:	8b 12                	mov    (%rdx),%edx
   440ad:	8d 4a 08             	lea    0x8(%rdx),%ecx
   440b0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440b7:	89 0a                	mov    %ecx,(%rdx)
   440b9:	eb 1a                	jmp    440d5 <printer_vprintf+0x1c0>
   440bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440c2:	48 8b 40 08          	mov    0x8(%rax),%rax
   440c6:	48 8d 48 08          	lea    0x8(%rax),%rcx
   440ca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440d1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440d5:	8b 00                	mov    (%rax),%eax
   440d7:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   440da:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   440e1:	01 
   440e2:	eb 01                	jmp    440e5 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
   440e4:	90                   	nop
        }

        // process precision
        int precision = -1;
   440e5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   440ec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440f3:	0f b6 00             	movzbl (%rax),%eax
   440f6:	3c 2e                	cmp    $0x2e,%al
   440f8:	0f 85 00 01 00 00    	jne    441fe <printer_vprintf+0x2e9>
            ++format;
   440fe:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44105:	01 
            if (*format >= '0' && *format <= '9') {
   44106:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4410d:	0f b6 00             	movzbl (%rax),%eax
   44110:	3c 2f                	cmp    $0x2f,%al
   44112:	7e 67                	jle    4417b <printer_vprintf+0x266>
   44114:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4411b:	0f b6 00             	movzbl (%rax),%eax
   4411e:	3c 39                	cmp    $0x39,%al
   44120:	7f 59                	jg     4417b <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44122:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   44129:	eb 2e                	jmp    44159 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
   4412b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4412e:	89 d0                	mov    %edx,%eax
   44130:	c1 e0 02             	shl    $0x2,%eax
   44133:	01 d0                	add    %edx,%eax
   44135:	01 c0                	add    %eax,%eax
   44137:	89 c1                	mov    %eax,%ecx
   44139:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44140:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44144:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4414b:	0f b6 00             	movzbl (%rax),%eax
   4414e:	0f be c0             	movsbl %al,%eax
   44151:	01 c8                	add    %ecx,%eax
   44153:	83 e8 30             	sub    $0x30,%eax
   44156:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44159:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44160:	0f b6 00             	movzbl (%rax),%eax
   44163:	3c 2f                	cmp    $0x2f,%al
   44165:	0f 8e 85 00 00 00    	jle    441f0 <printer_vprintf+0x2db>
   4416b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44172:	0f b6 00             	movzbl (%rax),%eax
   44175:	3c 39                	cmp    $0x39,%al
   44177:	7e b2                	jle    4412b <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
   44179:	eb 75                	jmp    441f0 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
   4417b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44182:	0f b6 00             	movzbl (%rax),%eax
   44185:	3c 2a                	cmp    $0x2a,%al
   44187:	75 68                	jne    441f1 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
   44189:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44190:	8b 00                	mov    (%rax),%eax
   44192:	83 f8 2f             	cmp    $0x2f,%eax
   44195:	77 30                	ja     441c7 <printer_vprintf+0x2b2>
   44197:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4419e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   441a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441a9:	8b 00                	mov    (%rax),%eax
   441ab:	89 c0                	mov    %eax,%eax
   441ad:	48 01 d0             	add    %rdx,%rax
   441b0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441b7:	8b 12                	mov    (%rdx),%edx
   441b9:	8d 4a 08             	lea    0x8(%rdx),%ecx
   441bc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441c3:	89 0a                	mov    %ecx,(%rdx)
   441c5:	eb 1a                	jmp    441e1 <printer_vprintf+0x2cc>
   441c7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441ce:	48 8b 40 08          	mov    0x8(%rax),%rax
   441d2:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441d6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441dd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441e1:	8b 00                	mov    (%rax),%eax
   441e3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   441e6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   441ed:	01 
   441ee:	eb 01                	jmp    441f1 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
   441f0:	90                   	nop
            }
            if (precision < 0) {
   441f1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   441f5:	79 07                	jns    441fe <printer_vprintf+0x2e9>
                precision = 0;
   441f7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   441fe:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   44205:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   4420c:	00 
        int length = 0;
   4420d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   44214:	48 8d 05 8b 14 00 00 	lea    0x148b(%rip),%rax        # 456a6 <flag_chars+0x6>
   4421b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
   4421f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44226:	0f b6 00             	movzbl (%rax),%eax
   44229:	0f be c0             	movsbl %al,%eax
   4422c:	83 e8 43             	sub    $0x43,%eax
   4422f:	83 f8 37             	cmp    $0x37,%eax
   44232:	0f 87 b6 03 00 00    	ja     445ee <printer_vprintf+0x6d9>
   44238:	89 c0                	mov    %eax,%eax
   4423a:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   44241:	00 
   44242:	48 8d 05 6b 14 00 00 	lea    0x146b(%rip),%rax        # 456b4 <flag_chars+0x14>
   44249:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   4424c:	48 98                	cltq   
   4424e:	48 8d 15 5f 14 00 00 	lea    0x145f(%rip),%rdx        # 456b4 <flag_chars+0x14>
   44255:	48 01 d0             	add    %rdx,%rax
   44258:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
   4425b:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   44262:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44269:	01 
            goto again;
   4426a:	eb b3                	jmp    4421f <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   4426c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44270:	74 5d                	je     442cf <printer_vprintf+0x3ba>
   44272:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44279:	8b 00                	mov    (%rax),%eax
   4427b:	83 f8 2f             	cmp    $0x2f,%eax
   4427e:	77 30                	ja     442b0 <printer_vprintf+0x39b>
   44280:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44287:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4428b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44292:	8b 00                	mov    (%rax),%eax
   44294:	89 c0                	mov    %eax,%eax
   44296:	48 01 d0             	add    %rdx,%rax
   44299:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442a0:	8b 12                	mov    (%rdx),%edx
   442a2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442a5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442ac:	89 0a                	mov    %ecx,(%rdx)
   442ae:	eb 1a                	jmp    442ca <printer_vprintf+0x3b5>
   442b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442b7:	48 8b 40 08          	mov    0x8(%rax),%rax
   442bb:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442bf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442c6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442ca:	48 8b 00             	mov    (%rax),%rax
   442cd:	eb 5c                	jmp    4432b <printer_vprintf+0x416>
   442cf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442d6:	8b 00                	mov    (%rax),%eax
   442d8:	83 f8 2f             	cmp    $0x2f,%eax
   442db:	77 30                	ja     4430d <printer_vprintf+0x3f8>
   442dd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442e4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442e8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442ef:	8b 00                	mov    (%rax),%eax
   442f1:	89 c0                	mov    %eax,%eax
   442f3:	48 01 d0             	add    %rdx,%rax
   442f6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442fd:	8b 12                	mov    (%rdx),%edx
   442ff:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44302:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44309:	89 0a                	mov    %ecx,(%rdx)
   4430b:	eb 1a                	jmp    44327 <printer_vprintf+0x412>
   4430d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44314:	48 8b 40 08          	mov    0x8(%rax),%rax
   44318:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4431c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44323:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44327:	8b 00                	mov    (%rax),%eax
   44329:	48 98                	cltq   
   4432b:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4432f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44333:	48 c1 f8 38          	sar    $0x38,%rax
   44337:	25 80 00 00 00       	and    $0x80,%eax
   4433c:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   4433f:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   44343:	74 09                	je     4434e <printer_vprintf+0x439>
   44345:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44349:	48 f7 d8             	neg    %rax
   4434c:	eb 04                	jmp    44352 <printer_vprintf+0x43d>
   4434e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44352:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   44356:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   44359:	83 c8 60             	or     $0x60,%eax
   4435c:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   4435f:	e9 cf 02 00 00       	jmp    44633 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   44364:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44368:	74 5d                	je     443c7 <printer_vprintf+0x4b2>
   4436a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44371:	8b 00                	mov    (%rax),%eax
   44373:	83 f8 2f             	cmp    $0x2f,%eax
   44376:	77 30                	ja     443a8 <printer_vprintf+0x493>
   44378:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4437f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44383:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4438a:	8b 00                	mov    (%rax),%eax
   4438c:	89 c0                	mov    %eax,%eax
   4438e:	48 01 d0             	add    %rdx,%rax
   44391:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44398:	8b 12                	mov    (%rdx),%edx
   4439a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4439d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443a4:	89 0a                	mov    %ecx,(%rdx)
   443a6:	eb 1a                	jmp    443c2 <printer_vprintf+0x4ad>
   443a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443af:	48 8b 40 08          	mov    0x8(%rax),%rax
   443b3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443b7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443be:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443c2:	48 8b 00             	mov    (%rax),%rax
   443c5:	eb 5c                	jmp    44423 <printer_vprintf+0x50e>
   443c7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ce:	8b 00                	mov    (%rax),%eax
   443d0:	83 f8 2f             	cmp    $0x2f,%eax
   443d3:	77 30                	ja     44405 <printer_vprintf+0x4f0>
   443d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443dc:	48 8b 50 10          	mov    0x10(%rax),%rdx
   443e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443e7:	8b 00                	mov    (%rax),%eax
   443e9:	89 c0                	mov    %eax,%eax
   443eb:	48 01 d0             	add    %rdx,%rax
   443ee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443f5:	8b 12                	mov    (%rdx),%edx
   443f7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443fa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44401:	89 0a                	mov    %ecx,(%rdx)
   44403:	eb 1a                	jmp    4441f <printer_vprintf+0x50a>
   44405:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4440c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44410:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44414:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4441b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4441f:	8b 00                	mov    (%rax),%eax
   44421:	89 c0                	mov    %eax,%eax
   44423:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   44427:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   4442b:	e9 03 02 00 00       	jmp    44633 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
   44430:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   44437:	e9 28 ff ff ff       	jmp    44364 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
   4443c:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   44443:	e9 1c ff ff ff       	jmp    44364 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44448:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4444f:	8b 00                	mov    (%rax),%eax
   44451:	83 f8 2f             	cmp    $0x2f,%eax
   44454:	77 30                	ja     44486 <printer_vprintf+0x571>
   44456:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4445d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44461:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44468:	8b 00                	mov    (%rax),%eax
   4446a:	89 c0                	mov    %eax,%eax
   4446c:	48 01 d0             	add    %rdx,%rax
   4446f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44476:	8b 12                	mov    (%rdx),%edx
   44478:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4447b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44482:	89 0a                	mov    %ecx,(%rdx)
   44484:	eb 1a                	jmp    444a0 <printer_vprintf+0x58b>
   44486:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4448d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44491:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44495:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4449c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444a0:	48 8b 00             	mov    (%rax),%rax
   444a3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   444a7:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   444ae:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   444b5:	e9 79 01 00 00       	jmp    44633 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
   444ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444c1:	8b 00                	mov    (%rax),%eax
   444c3:	83 f8 2f             	cmp    $0x2f,%eax
   444c6:	77 30                	ja     444f8 <printer_vprintf+0x5e3>
   444c8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444cf:	48 8b 50 10          	mov    0x10(%rax),%rdx
   444d3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444da:	8b 00                	mov    (%rax),%eax
   444dc:	89 c0                	mov    %eax,%eax
   444de:	48 01 d0             	add    %rdx,%rax
   444e1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444e8:	8b 12                	mov    (%rdx),%edx
   444ea:	8d 4a 08             	lea    0x8(%rdx),%ecx
   444ed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444f4:	89 0a                	mov    %ecx,(%rdx)
   444f6:	eb 1a                	jmp    44512 <printer_vprintf+0x5fd>
   444f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444ff:	48 8b 40 08          	mov    0x8(%rax),%rax
   44503:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44507:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4450e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44512:	48 8b 00             	mov    (%rax),%rax
   44515:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   44519:	e9 15 01 00 00       	jmp    44633 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
   4451e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44525:	8b 00                	mov    (%rax),%eax
   44527:	83 f8 2f             	cmp    $0x2f,%eax
   4452a:	77 30                	ja     4455c <printer_vprintf+0x647>
   4452c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44533:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44537:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4453e:	8b 00                	mov    (%rax),%eax
   44540:	89 c0                	mov    %eax,%eax
   44542:	48 01 d0             	add    %rdx,%rax
   44545:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4454c:	8b 12                	mov    (%rdx),%edx
   4454e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44551:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44558:	89 0a                	mov    %ecx,(%rdx)
   4455a:	eb 1a                	jmp    44576 <printer_vprintf+0x661>
   4455c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44563:	48 8b 40 08          	mov    0x8(%rax),%rax
   44567:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4456b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44572:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44576:	8b 00                	mov    (%rax),%eax
   44578:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   4457e:	e9 77 03 00 00       	jmp    448fa <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
   44583:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44587:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   4458b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44592:	8b 00                	mov    (%rax),%eax
   44594:	83 f8 2f             	cmp    $0x2f,%eax
   44597:	77 30                	ja     445c9 <printer_vprintf+0x6b4>
   44599:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445a0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445ab:	8b 00                	mov    (%rax),%eax
   445ad:	89 c0                	mov    %eax,%eax
   445af:	48 01 d0             	add    %rdx,%rax
   445b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445b9:	8b 12                	mov    (%rdx),%edx
   445bb:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445c5:	89 0a                	mov    %ecx,(%rdx)
   445c7:	eb 1a                	jmp    445e3 <printer_vprintf+0x6ce>
   445c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445d0:	48 8b 40 08          	mov    0x8(%rax),%rax
   445d4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445d8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445e3:	8b 00                	mov    (%rax),%eax
   445e5:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   445e8:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   445ec:	eb 45                	jmp    44633 <printer_vprintf+0x71e>
        default:
            data = numbuf;
   445ee:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   445f2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   445f6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   445fd:	0f b6 00             	movzbl (%rax),%eax
   44600:	84 c0                	test   %al,%al
   44602:	74 0c                	je     44610 <printer_vprintf+0x6fb>
   44604:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4460b:	0f b6 00             	movzbl (%rax),%eax
   4460e:	eb 05                	jmp    44615 <printer_vprintf+0x700>
   44610:	b8 25 00 00 00       	mov    $0x25,%eax
   44615:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44618:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   4461c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44623:	0f b6 00             	movzbl (%rax),%eax
   44626:	84 c0                	test   %al,%al
   44628:	75 08                	jne    44632 <printer_vprintf+0x71d>
                format--;
   4462a:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44631:	01 
            }
            break;
   44632:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44633:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44636:	83 e0 20             	and    $0x20,%eax
   44639:	85 c0                	test   %eax,%eax
   4463b:	74 1e                	je     4465b <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   4463d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44641:	48 83 c0 18          	add    $0x18,%rax
   44645:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44648:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4464c:	48 89 ce             	mov    %rcx,%rsi
   4464f:	48 89 c7             	mov    %rax,%rdi
   44652:	e8 32 f8 ff ff       	call   43e89 <fill_numbuf>
   44657:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   4465b:	48 8d 05 44 10 00 00 	lea    0x1044(%rip),%rax        # 456a6 <flag_chars+0x6>
   44662:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44666:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44669:	83 e0 20             	and    $0x20,%eax
   4466c:	85 c0                	test   %eax,%eax
   4466e:	74 51                	je     446c1 <printer_vprintf+0x7ac>
   44670:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44673:	83 e0 40             	and    $0x40,%eax
   44676:	85 c0                	test   %eax,%eax
   44678:	74 47                	je     446c1 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
   4467a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4467d:	25 80 00 00 00       	and    $0x80,%eax
   44682:	85 c0                	test   %eax,%eax
   44684:	74 0d                	je     44693 <printer_vprintf+0x77e>
                prefix = "-";
   44686:	48 8d 05 1a 10 00 00 	lea    0x101a(%rip),%rax        # 456a7 <flag_chars+0x7>
   4468d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   44691:	eb 7d                	jmp    44710 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44693:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44696:	83 e0 10             	and    $0x10,%eax
   44699:	85 c0                	test   %eax,%eax
   4469b:	74 0d                	je     446aa <printer_vprintf+0x795>
                prefix = "+";
   4469d:	48 8d 05 05 10 00 00 	lea    0x1005(%rip),%rax        # 456a9 <flag_chars+0x9>
   446a4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   446a8:	eb 66                	jmp    44710 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   446aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446ad:	83 e0 08             	and    $0x8,%eax
   446b0:	85 c0                	test   %eax,%eax
   446b2:	74 5c                	je     44710 <printer_vprintf+0x7fb>
                prefix = " ";
   446b4:	48 8d 05 f0 0f 00 00 	lea    0xff0(%rip),%rax        # 456ab <flag_chars+0xb>
   446bb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
   446bf:	eb 4f                	jmp    44710 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   446c1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446c4:	83 e0 20             	and    $0x20,%eax
   446c7:	85 c0                	test   %eax,%eax
   446c9:	74 46                	je     44711 <printer_vprintf+0x7fc>
   446cb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446ce:	83 e0 01             	and    $0x1,%eax
   446d1:	85 c0                	test   %eax,%eax
   446d3:	74 3c                	je     44711 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
   446d5:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   446d9:	74 06                	je     446e1 <printer_vprintf+0x7cc>
   446db:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   446df:	75 30                	jne    44711 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
   446e1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   446e6:	75 0c                	jne    446f4 <printer_vprintf+0x7df>
   446e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446eb:	25 00 01 00 00       	and    $0x100,%eax
   446f0:	85 c0                	test   %eax,%eax
   446f2:	74 1d                	je     44711 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
   446f4:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   446f8:	75 09                	jne    44703 <printer_vprintf+0x7ee>
   446fa:	48 8d 05 ac 0f 00 00 	lea    0xfac(%rip),%rax        # 456ad <flag_chars+0xd>
   44701:	eb 07                	jmp    4470a <printer_vprintf+0x7f5>
   44703:	48 8d 05 a6 0f 00 00 	lea    0xfa6(%rip),%rax        # 456b0 <flag_chars+0x10>
   4470a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4470e:	eb 01                	jmp    44711 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
   44710:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44711:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44715:	78 24                	js     4473b <printer_vprintf+0x826>
   44717:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4471a:	83 e0 20             	and    $0x20,%eax
   4471d:	85 c0                	test   %eax,%eax
   4471f:	75 1a                	jne    4473b <printer_vprintf+0x826>
            len = strnlen(data, precision);
   44721:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44724:	48 63 d0             	movslq %eax,%rdx
   44727:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4472b:	48 89 d6             	mov    %rdx,%rsi
   4472e:	48 89 c7             	mov    %rax,%rdi
   44731:	e8 91 f5 ff ff       	call   43cc7 <strnlen>
   44736:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44739:	eb 0f                	jmp    4474a <printer_vprintf+0x835>
        } else {
            len = strlen(data);
   4473b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4473f:	48 89 c7             	mov    %rax,%rdi
   44742:	e8 4b f5 ff ff       	call   43c92 <strlen>
   44747:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   4474a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4474d:	83 e0 20             	and    $0x20,%eax
   44750:	85 c0                	test   %eax,%eax
   44752:	74 20                	je     44774 <printer_vprintf+0x85f>
   44754:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44758:	78 1a                	js     44774 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
   4475a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4475d:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44760:	7e 08                	jle    4476a <printer_vprintf+0x855>
   44762:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44765:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44768:	eb 05                	jmp    4476f <printer_vprintf+0x85a>
   4476a:	b8 00 00 00 00       	mov    $0x0,%eax
   4476f:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44772:	eb 5c                	jmp    447d0 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44774:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44777:	83 e0 20             	and    $0x20,%eax
   4477a:	85 c0                	test   %eax,%eax
   4477c:	74 4b                	je     447c9 <printer_vprintf+0x8b4>
   4477e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44781:	83 e0 02             	and    $0x2,%eax
   44784:	85 c0                	test   %eax,%eax
   44786:	74 41                	je     447c9 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44788:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4478b:	83 e0 04             	and    $0x4,%eax
   4478e:	85 c0                	test   %eax,%eax
   44790:	75 37                	jne    447c9 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
   44792:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44796:	48 89 c7             	mov    %rax,%rdi
   44799:	e8 f4 f4 ff ff       	call   43c92 <strlen>
   4479e:	89 c2                	mov    %eax,%edx
   447a0:	8b 45 bc             	mov    -0x44(%rbp),%eax
   447a3:	01 d0                	add    %edx,%eax
   447a5:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   447a8:	7e 1f                	jle    447c9 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
   447aa:	8b 45 e8             	mov    -0x18(%rbp),%eax
   447ad:	2b 45 bc             	sub    -0x44(%rbp),%eax
   447b0:	89 c3                	mov    %eax,%ebx
   447b2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447b6:	48 89 c7             	mov    %rax,%rdi
   447b9:	e8 d4 f4 ff ff       	call   43c92 <strlen>
   447be:	89 c2                	mov    %eax,%edx
   447c0:	89 d8                	mov    %ebx,%eax
   447c2:	29 d0                	sub    %edx,%eax
   447c4:	89 45 b8             	mov    %eax,-0x48(%rbp)
   447c7:	eb 07                	jmp    447d0 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
   447c9:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   447d0:	8b 55 bc             	mov    -0x44(%rbp),%edx
   447d3:	8b 45 b8             	mov    -0x48(%rbp),%eax
   447d6:	01 d0                	add    %edx,%eax
   447d8:	48 63 d8             	movslq %eax,%rbx
   447db:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447df:	48 89 c7             	mov    %rax,%rdi
   447e2:	e8 ab f4 ff ff       	call   43c92 <strlen>
   447e7:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   447eb:	8b 45 e8             	mov    -0x18(%rbp),%eax
   447ee:	29 d0                	sub    %edx,%eax
   447f0:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   447f3:	eb 25                	jmp    4481a <printer_vprintf+0x905>
            p->putc(p, ' ', color);
   447f5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447fc:	48 8b 08             	mov    (%rax),%rcx
   447ff:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44805:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4480c:	be 20 00 00 00       	mov    $0x20,%esi
   44811:	48 89 c7             	mov    %rax,%rdi
   44814:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44816:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   4481a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4481d:	83 e0 04             	and    $0x4,%eax
   44820:	85 c0                	test   %eax,%eax
   44822:	75 36                	jne    4485a <printer_vprintf+0x945>
   44824:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44828:	7f cb                	jg     447f5 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
   4482a:	eb 2e                	jmp    4485a <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
   4482c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44833:	4c 8b 00             	mov    (%rax),%r8
   44836:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4483a:	0f b6 00             	movzbl (%rax),%eax
   4483d:	0f b6 c8             	movzbl %al,%ecx
   44840:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44846:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4484d:	89 ce                	mov    %ecx,%esi
   4484f:	48 89 c7             	mov    %rax,%rdi
   44852:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44855:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   4485a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4485e:	0f b6 00             	movzbl (%rax),%eax
   44861:	84 c0                	test   %al,%al
   44863:	75 c7                	jne    4482c <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
   44865:	eb 25                	jmp    4488c <printer_vprintf+0x977>
            p->putc(p, '0', color);
   44867:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4486e:	48 8b 08             	mov    (%rax),%rcx
   44871:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44877:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4487e:	be 30 00 00 00       	mov    $0x30,%esi
   44883:	48 89 c7             	mov    %rax,%rdi
   44886:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44888:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   4488c:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44890:	7f d5                	jg     44867 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
   44892:	eb 32                	jmp    448c6 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
   44894:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4489b:	4c 8b 00             	mov    (%rax),%r8
   4489e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   448a2:	0f b6 00             	movzbl (%rax),%eax
   448a5:	0f b6 c8             	movzbl %al,%ecx
   448a8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448ae:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448b5:	89 ce                	mov    %ecx,%esi
   448b7:	48 89 c7             	mov    %rax,%rdi
   448ba:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   448bd:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   448c2:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   448c6:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   448ca:	7f c8                	jg     44894 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
   448cc:	eb 25                	jmp    448f3 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
   448ce:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448d5:	48 8b 08             	mov    (%rax),%rcx
   448d8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448de:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448e5:	be 20 00 00 00       	mov    $0x20,%esi
   448ea:	48 89 c7             	mov    %rax,%rdi
   448ed:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   448ef:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   448f3:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   448f7:	7f d5                	jg     448ce <printer_vprintf+0x9b9>
        }
    done: ;
   448f9:	90                   	nop
    for (; *format; ++format) {
   448fa:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44901:	01 
   44902:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44909:	0f b6 00             	movzbl (%rax),%eax
   4490c:	84 c0                	test   %al,%al
   4490e:	0f 85 31 f6 ff ff    	jne    43f45 <printer_vprintf+0x30>
    }
}
   44914:	90                   	nop
   44915:	90                   	nop
   44916:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4491a:	c9                   	leave  
   4491b:	c3                   	ret    

000000000004491c <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4491c:	f3 0f 1e fa          	endbr64 
   44920:	55                   	push   %rbp
   44921:	48 89 e5             	mov    %rsp,%rbp
   44924:	48 83 ec 20          	sub    $0x20,%rsp
   44928:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4492c:	89 f0                	mov    %esi,%eax
   4492e:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44931:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44934:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44938:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4493c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44940:	48 8b 40 08          	mov    0x8(%rax),%rax
   44944:	48 8d 15 55 46 07 00 	lea    0x74655(%rip),%rdx        # b8fa0 <console+0xfa0>
   4494b:	48 39 d0             	cmp    %rdx,%rax
   4494e:	72 0f                	jb     4495f <console_putc+0x43>
        cp->cursor = console;
   44950:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44954:	48 8d 15 a5 36 07 00 	lea    0x736a5(%rip),%rdx        # b8000 <console>
   4495b:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
   4495f:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44963:	0f 85 82 00 00 00    	jne    449eb <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
   44969:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4496d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44971:	48 8d 15 88 36 07 00 	lea    0x73688(%rip),%rdx        # b8000 <console>
   44978:	48 29 d0             	sub    %rdx,%rax
   4497b:	48 d1 f8             	sar    %rax
   4497e:	48 89 c1             	mov    %rax,%rcx
   44981:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44988:	66 66 66 
   4498b:	48 89 c8             	mov    %rcx,%rax
   4498e:	48 f7 ea             	imul   %rdx
   44991:	48 89 d0             	mov    %rdx,%rax
   44994:	48 c1 f8 05          	sar    $0x5,%rax
   44998:	48 89 ce             	mov    %rcx,%rsi
   4499b:	48 c1 fe 3f          	sar    $0x3f,%rsi
   4499f:	48 29 f0             	sub    %rsi,%rax
   449a2:	48 89 c2             	mov    %rax,%rdx
   449a5:	48 89 d0             	mov    %rdx,%rax
   449a8:	48 c1 e0 02          	shl    $0x2,%rax
   449ac:	48 01 d0             	add    %rdx,%rax
   449af:	48 c1 e0 04          	shl    $0x4,%rax
   449b3:	48 29 c1             	sub    %rax,%rcx
   449b6:	48 89 ca             	mov    %rcx,%rdx
   449b9:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   449bc:	eb 25                	jmp    449e3 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
   449be:	8b 45 e0             	mov    -0x20(%rbp),%eax
   449c1:	83 c8 20             	or     $0x20,%eax
   449c4:	89 c6                	mov    %eax,%esi
   449c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449ca:	48 8b 40 08          	mov    0x8(%rax),%rax
   449ce:	48 8d 48 02          	lea    0x2(%rax),%rcx
   449d2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   449d6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449da:	89 f2                	mov    %esi,%edx
   449dc:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   449df:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   449e3:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   449e7:	75 d5                	jne    449be <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   449e9:	eb 24                	jmp    44a0f <console_putc+0xf3>
        *cp->cursor++ = c | color;
   449eb:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   449ef:	8b 45 e0             	mov    -0x20(%rbp),%eax
   449f2:	89 d6                	mov    %edx,%esi
   449f4:	09 c6                	or     %eax,%esi
   449f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449fa:	48 8b 40 08          	mov    0x8(%rax),%rax
   449fe:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44a02:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44a06:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a0a:	89 f2                	mov    %esi,%edx
   44a0c:	66 89 10             	mov    %dx,(%rax)
}
   44a0f:	90                   	nop
   44a10:	c9                   	leave  
   44a11:	c3                   	ret    

0000000000044a12 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44a12:	f3 0f 1e fa          	endbr64 
   44a16:	55                   	push   %rbp
   44a17:	48 89 e5             	mov    %rsp,%rbp
   44a1a:	48 83 ec 30          	sub    $0x30,%rsp
   44a1e:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44a21:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44a24:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44a28:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44a2c:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 4491c <console_putc>
   44a33:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44a37:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44a3b:	78 09                	js     44a46 <console_vprintf+0x34>
   44a3d:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44a44:	7e 07                	jle    44a4d <console_vprintf+0x3b>
        cpos = 0;
   44a46:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44a4d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44a50:	48 98                	cltq   
   44a52:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44a56:	48 8d 05 a3 35 07 00 	lea    0x735a3(%rip),%rax        # b8000 <console>
   44a5d:	48 01 d0             	add    %rdx,%rax
   44a60:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44a64:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44a68:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44a6c:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44a6f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44a73:	48 89 c7             	mov    %rax,%rdi
   44a76:	e8 9a f4 ff ff       	call   43f15 <printer_vprintf>
    return cp.cursor - console;
   44a7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44a7f:	48 8d 15 7a 35 07 00 	lea    0x7357a(%rip),%rdx        # b8000 <console>
   44a86:	48 29 d0             	sub    %rdx,%rax
   44a89:	48 d1 f8             	sar    %rax
}
   44a8c:	c9                   	leave  
   44a8d:	c3                   	ret    

0000000000044a8e <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44a8e:	f3 0f 1e fa          	endbr64 
   44a92:	55                   	push   %rbp
   44a93:	48 89 e5             	mov    %rsp,%rbp
   44a96:	48 83 ec 60          	sub    $0x60,%rsp
   44a9a:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44a9d:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44aa0:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44aa4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44aa8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44aac:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44ab0:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44ab7:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44abb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44abf:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44ac3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44ac7:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44acb:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44acf:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44ad2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44ad5:	89 c7                	mov    %eax,%edi
   44ad7:	e8 36 ff ff ff       	call   44a12 <console_vprintf>
   44adc:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44adf:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44ae2:	c9                   	leave  
   44ae3:	c3                   	ret    

0000000000044ae4 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44ae4:	f3 0f 1e fa          	endbr64 
   44ae8:	55                   	push   %rbp
   44ae9:	48 89 e5             	mov    %rsp,%rbp
   44aec:	48 83 ec 20          	sub    $0x20,%rsp
   44af0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44af4:	89 f0                	mov    %esi,%eax
   44af6:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44af9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44afc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44b00:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44b04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b08:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44b0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b10:	48 8b 40 10          	mov    0x10(%rax),%rax
   44b14:	48 39 c2             	cmp    %rax,%rdx
   44b17:	73 1a                	jae    44b33 <string_putc+0x4f>
        *sp->s++ = c;
   44b19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b1d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44b21:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44b25:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44b29:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44b2d:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44b31:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44b33:	90                   	nop
   44b34:	c9                   	leave  
   44b35:	c3                   	ret    

0000000000044b36 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44b36:	f3 0f 1e fa          	endbr64 
   44b3a:	55                   	push   %rbp
   44b3b:	48 89 e5             	mov    %rsp,%rbp
   44b3e:	48 83 ec 40          	sub    $0x40,%rsp
   44b42:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44b46:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44b4a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44b4e:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44b52:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 44ae4 <string_putc>
   44b59:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
   44b5d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b61:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44b65:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44b6a:	74 33                	je     44b9f <vsnprintf+0x69>
        sp.end = s + size - 1;
   44b6c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44b70:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44b74:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b78:	48 01 d0             	add    %rdx,%rax
   44b7b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44b7f:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44b83:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44b87:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44b8b:	be 00 00 00 00       	mov    $0x0,%esi
   44b90:	48 89 c7             	mov    %rax,%rdi
   44b93:	e8 7d f3 ff ff       	call   43f15 <printer_vprintf>
        *sp.s = 0;
   44b98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b9c:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44b9f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44ba3:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44ba7:	c9                   	leave  
   44ba8:	c3                   	ret    

0000000000044ba9 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44ba9:	f3 0f 1e fa          	endbr64 
   44bad:	55                   	push   %rbp
   44bae:	48 89 e5             	mov    %rsp,%rbp
   44bb1:	48 83 ec 70          	sub    $0x70,%rsp
   44bb5:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44bb9:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44bbd:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44bc1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44bc5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44bc9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44bcd:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44bd4:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44bd8:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44bdc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44be0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44be4:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44be8:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44bec:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44bf0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44bf4:	48 89 c7             	mov    %rax,%rdi
   44bf7:	e8 3a ff ff ff       	call   44b36 <vsnprintf>
   44bfc:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44bff:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44c02:	c9                   	leave  
   44c03:	c3                   	ret    

0000000000044c04 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44c04:	f3 0f 1e fa          	endbr64 
   44c08:	55                   	push   %rbp
   44c09:	48 89 e5             	mov    %rsp,%rbp
   44c0c:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44c10:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44c17:	eb 1a                	jmp    44c33 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
   44c19:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44c1c:	48 98                	cltq   
   44c1e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
   44c22:	48 8d 05 d7 33 07 00 	lea    0x733d7(%rip),%rax        # b8000 <console>
   44c29:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44c2f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44c33:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44c3a:	7e dd                	jle    44c19 <console_clear+0x15>
    }
    cursorpos = 0;
   44c3c:	c7 05 b6 43 07 00 00 	movl   $0x0,0x743b6(%rip)        # b8ffc <cursorpos>
   44c43:	00 00 00 
}
   44c46:	90                   	nop
   44c47:	c9                   	leave  
   44c48:	c3                   	ret    
