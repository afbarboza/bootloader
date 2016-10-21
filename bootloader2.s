.code16
.section	.text
.globl		main
main:
		jmp	_start
		.byte	144
		.ascii	"HelloWorld OS"
		.word	512
		.byte	1
		.word	1
		.byte	2
		.word	224
		.word	2880
		.byte	0xF0
		.word	9
		.word	18
		.word	2
		.long	0
		.byte	0
		.byte	0
		.byte	0x29
		.long	0x12345678
		.ascii	"Hello World"
		.ascii	"FAT12	"

_start:
		sti
		movw	$0x0, %ax
		movw	%ax, %ss
		movw	%ax, %ds
		movw	%ax, %es
		movw	$string, %si

loop:
		movb	$0xE, %ah
		movb	(%si), %al
		cmpb	$0, %al
		je	done
		int	$0x10
		addw	$1, %si
		jmp	loop

done:		mov	$0x1000, %ax
		jmp	*%ax

string:
		.ascii	"Hello World of Bootloader and Kernel Land. :D "
		.byte	0
		.fill	0x1FE - (. - main), 1, 0
		.byte	0x55, 0xAA
