	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 4
	.globl	_boo                            ; -- Begin function boo
	.p2align	2
_boo:                                   ; @boo
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	str	x0, [sp, #56]
	str	x1, [sp, #48]
	mov	x8, #12
	str	x8, [sp, #40]
	mov	x8, #24
	str	x8, [sp, #32]
	ldr	x8, [sp, #56]
	ldr	x9, [sp, #40]
	add	x8, x8, x9
	str	x8, [sp, #24]
	ldr	x8, [sp, #48]
	ldr	x9, [sp, #32]
	mul	x8, x8, x9
	str	x8, [sp, #16]
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #24]
	subs	x8, x8, x9
	str	x8, [sp, #8]
	ldr	x0, [sp, #24]
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_foo                            ; -- Begin function foo
	.p2align	2
_foo:                                   ; @foo
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	mov	x8, #12
	stur	x8, [x29, #-24]
	mov	x8, #24
	str	x8, [sp, #32]
	ldur	x8, [x29, #-8]
	ldur	x9, [x29, #-24]
	add	x8, x8, x9
	str	x8, [sp, #24]
	ldr	x0, [sp, #32]
	ldr	x1, [sp, #24]
	bl	_boo
	str	x0, [sp, #16]
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #24]
	subs	x8, x8, x9
	str	x8, [sp, #8]
	ldr	x0, [sp, #8]
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
