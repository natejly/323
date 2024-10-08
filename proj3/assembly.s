
.globl bar
bar:
pushq %rbp
movq %rsp, %rbp
movq %rdi, -8(%rbp)
subq $24, %rsp
movq  $5, -24(%rbp)
movq -8(%rbp), %rax
addq -24(%rbp), %rax
movq %rax, -24(%rbp)
addq $24, %rsp
popq  %rbp
retq

.globl foo
foo:
pushq %rbp
movq %rsp, %rbp
movq %rdi, -8(%rbp)
movq %rsi, -16(%rbp)
subq $48, %rsp
callq bar
movq %rax, -24(%rbp)
movq  $5, -40(%rbp)
movq -40(%rbp), %rax
idivq -24(%rbp), %rax
movq %rax, -40(%rbp)
addq $48, %rsp
popq  %rbp
retq
