.section	.text
.type		_start, @function
.globl		_start		
.code16

_start:
		jmp	main_prog
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

main_prog:
		cli

		# printing message
		movw	$msg_0, %si
		call	printstr

reset_floppy:
		# reset floppy disk
		movb	$0x00, %ah
		movb	$0x00, %dl
		int	$0x13
		jc	reset_floppy
		movw	$msg_1, %si
		call	printstr

		# where the kernel will be copied? - $0x1000 (see Low Memory Map)
		movw	$0x100, %ax	# take care with segmentation ;-)
		movw	%ax, %es
		xorw	%bx, %bx	

copy_kernel:
		#copying the kernel sector now
		mov	$0x02, %ah	# read from floppy
		mov	$0x02, %al	# read 2 sectors (for now, must be enough)
		mov	$0x00, %ch	# read from track 1
		mov	$0x02, %cl	# reading sector 2 (starting address of kernel)
		mov	$0x00, %dh	# head number
		mov	$0x00, %dl	# drive 0
		int	$0x13		# bios call
		jc	copy_kernel	# copying the kernel
		movw	$msg_2, %si	# printing message on the screen
		call	printstr

		mov	$0x1000, %ax
		jmp	*%ax

.include	"print.s"

msg_0:		.ascii	"Hello World of Bootloader and Kernel Land. :D\n\r\0"
msg_1:		.ascii	"Floppy Drive Reseted\n\r\0"
msg_2:		.ascii	"Kernel loaded.\n\r\0"

. = _start + 510
		.byte	0x55, 0xAA
