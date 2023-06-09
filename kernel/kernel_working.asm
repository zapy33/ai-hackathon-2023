ORG 0x1000

jmp main

; Kernel code goes here...

main:
    mov ah, 0x0E  ; Function: Teletype output
    mov al, 'H'   ; Character to display
    int 0x10      ; BIOS interrupt to display character

    mov al, 'e'
    int 0x10

    mov al, 'l'
    int 0x10

    mov al, 'l'
    int 0x10

    mov al, 'o'
    int 0x10

    mov al, ' '
    int 0x10

    mov al, 'w'
    int 0x10

    mov al, 'o'
    int 0x10

    mov al, 'r'
    int 0x10

    mov al, 'l'
    int 0x10

    mov al, 'd'
    int 0x10

    mov al, '!'
    int 0x10

    ; Infinite loop
    jmp $

times 510-($-$$) db 0
dw 0xAA55
