CC	:= gcc-6
CFLAGS	:= -Wall -Werror -nostdlib -nostdinc -ffreestanding -Wall -Werror -m16 -S

all:
	gcc-6 -c -m16 -Wall -Werror kernel.c
	ld -melf_i386 -static -Tlinker.ld -nostdlib --nmagic -o kernel.elf kernel.o
	objcopy -O binary kernel.elf kernel.bin
	as --32 bootloader.s -o loader.o
	ld -m elf_i386 -nostdlib -N -Ttext 7C00 loader.o -o loader.elf
	objcopy -O binary loader.elf loader.bin
	dd status=noxfer conv=notrunc if=loader.bin of=floppy.flp
	dd if=kernel.bin of=floppy.flp seek=1 count=1 bs=512
	qemu-system-i386 -monitor stdio -fda floppy.flp

git:
	git add *.s *.c *.h Makefile *.ld
