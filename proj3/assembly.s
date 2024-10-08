
.globl boo
boo:
pushq %rbp
movq %rsp, %rbp
movq %rdi, -8(%rbp)
movq %rsi, -16(%rbp)
subq $24, %rsp
movq  $12, -24(%rbp)
movq -8(%rbp), %rax
addq -24(%rbp), %rax
movq %rax, %rbx
addq $24, %rsp
popq  %rbp
retq

.globl foo
foo:
pushq %rbp
movq %rsp, %rbp
movq %rdi, -8(%rbp)
movq %rsi, -16(%rbp)
subq $72, %rsp
movq  $12, -24(%rbp)
movq -8(%rbp), %rax
addq -24(%rbp), %rax
movq %rax, %rbx
addq $72, %rsp
popq  %rbp
retq
