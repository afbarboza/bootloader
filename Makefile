all:
	as --32 -o loader.o bootloader.s
	ld -m elf_i386 loader.o --oformat=binary -o loader.bin -Ttext 0x7C00
	dd status=noxfer conv=notrunc if=loader.bin of=floppy.flp
	qemu-system-i386 -fda floppy.flp
