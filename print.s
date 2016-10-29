.code16
.globl		printstr
.type		printstr, @function
printstr:
/**
 * prints out a string.
 * si - the addres of the string to be printed.
 */
printstr:
        pusha
        movb    $0x0E, %ah
.L0:    movb    (%si), %al
        cmpb    $0, %al
        jz      .L1
        int     $0x10
        #incb    %si
	add	$1, %si
        jmp     .L0
.L1:    popa
        ret
