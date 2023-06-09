# Makefile for assembling and running the bootloader

ASSEMBLER=nasm
ASSEMBLY_SOURCE=bootloader.asm
ASSEMBLY_OUTPUT=bootloader.bin
QEMU=qemu-system-i386

all: run

assemble:
	$(ASSEMBLER) -f bin $(ASSEMBLY_SOURCE) -o $(ASSEMBLY_OUTPUT)

run: assemble
	$(QEMU) -fda $(ASSEMBLY_OUTPUT)

clean:
	rm -f $(ASSEMBLY_OUTPUT)
