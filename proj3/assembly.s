
.globl foo
foo:
pushq %rbp
movq %rsp, %rbp
movq %rdi, -8(%rbp)
movq %rsi, -16(%rbp)
subq $144, %rsp
movq -8(%rbp), %rax
addq -16(%rbp), %rax
movq %rax, -24(%rbp)
movq  $3, -40(%rbp)
movq -24(%rbp), %rax
subq -40(%rbp), %rax
movq %rax, -32(%rbp)
movq -32(%rbp), %rax
imulq -24(%rbp), %rax
movq %rax, -48(%rbp)
movq  $2, -64(%rbp)
movq -48(%rbp), %rax
xorq %rdx, %rdx
idivq -64(%rbp), %rax
movq %rax, -56(%rbp)
negq %rax
movq %rax, -72(%rbp)
movq  $2, -88(%rbp)
movq -72(%rbp), %rax
shr $2, %rax
movq %rax, -80(%rbp)
addq $144, %rsp
popq  %rbp
retq
