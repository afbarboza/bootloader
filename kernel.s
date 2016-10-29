	.file	"kernel.c"
	.code16gcc
#APP
	.code16gcc
	.globl	main_kernel
#NO_APP
	.text
	.globl	main_kernel
	.type	main_kernel, @function
main_kernel:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$753664, -4(%ebp)
	movl	-4(%ebp), %eax
	movb	$72, (%eax)
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movb	$14, (%eax)
.L2:
	jmp	.L2
	.cfi_endproc
.LFE0:
	.size	main_kernel, .-main_kernel
	.ident	"GCC: (Ubuntu 6.2.0-3ubuntu11~14.04) 6.2.0 20160901"
	.section	.note.GNU-stack,"",@progbits
