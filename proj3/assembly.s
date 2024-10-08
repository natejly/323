
.globl boo
boo:
pushq %rbp
movq %rsp, %rbp
movq %rdi, -8(%rbp)
movq %rsi, -16(%rbp)
subq $24, %rsp
movq  $12, -32(%rbp)
movq -8(%rbp), %rax
addq -32(%rbp), %rax
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
subq $104, %rsp
movq  $12, -32(%rbp)
movq -8(%rbp), %rax
addq -32(%rbp), %rax
movq %rax, -24(%rbp)
movq  $24, -48(%rbp)
movq -48(%rbp), %rdi
movq -24(%rbp), %rsi
callq boo
movq %rax, -40(%rbp)
movq -40(%rbp), %rax
subq -24(%rbp), %rax
movq %rax, -56(%rbp)
addq $104, %rsp
popq  %rbp
retq
