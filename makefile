# Makefile

.PHONY: all clean run

all: kernel.bin

clean:
	rm -f kernel.bin

run: kernel.bin
	qemu-system-i386 -fda kernel.bin

kernel.bin: bootloader.asm kernel.asm
	nasm -f bin -o kernel.bin bootloader.asm