ORG 0x7C00

jmp start

; Bootloader code goes here...

start:
    ; Set up segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; Load the kernel into memory
    mov ah, 0x02           ; Function: Read disk sectors
    mov al, 1              ; Number of sectors to read
    mov ch, 0x00           ; Cylinder number
    mov dh, 0x00           ; Head number
    mov cl, 0x02           ; Sector number
    mov dl, 0x00           ; Drive number (0x00 for floppy disk)
    mov bx, kernel_start   ; Address where the kernel is loaded
    int 0x13               ; BIOS interrupt to read disk sectors

    ; Jump to the kernel
    jmp 0x0000:kernel_start

; Define constants
kernel_start equ 0x1000

; Bootloader code continues...

times 510-($-$$) db 0
dw 0xAA55
