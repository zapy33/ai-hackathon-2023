ORG 0x1000

jmp main

; Kernel code goes here...

main:
    ; Set video mode (mode 13h - 320x200 pixels, 256 colors)
    mov ax, 0x0013
    int 0x10

    ; Draw a white pixel at the top-left corner
    mov ax, 0x0C01   ; Function: Set pixel
    mov cx, 1        ; X-coordinate (1)
    mov dx, 1        ; Y-coordinate (1)
    mov bh, 0        ; Color attribute (blue)
    int 0x10

    ; Infinite loop
    jmp $

times 510-($-$$) db 0
dw 0xAA55
