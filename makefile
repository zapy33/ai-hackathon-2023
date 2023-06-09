# Makefile for building bootloader and kernel

# Compiler and flags
NASM = nasm
NASMFLAGS = -f bin

# File names
BOOTLOADER_SRC = bootloader/bootloader.asm
BOOTLOADER_BIN = bootloader/bootloader.bin

KERNEL_SRC = kernel/kernel.asm
KERNEL_BIN = kernel/kernel.bin

IMAGE_BIN = image.bin

# Build rules
all: $(IMAGE_BIN)

$(IMAGE_BIN): $(BOOTLOADER_BIN) $(KERNEL_BIN)
	cat $(BOOTLOADER_BIN) $(KERNEL_BIN) > $(IMAGE_BIN)

$(BOOTLOADER_BIN): $(BOOTLOADER_SRC)
	$(NASM) $(NASMFLAGS) -o $(BOOTLOADER_BIN) $(BOOTLOADER_SRC)

$(KERNEL_BIN): $(KERNEL_SRC)
	$(NASM) $(NASMFLAGS) -o $(KERNEL_BIN) $(KERNEL_SRC)

clean:
	rm -f $(BOOTLOADER_BIN) $(KERNEL_BIN) $(IMAGE_BIN)