ORG 0x7C00   ; Set origin to the bootloader entry point

    ; Bootloader entry point
    JMP main   ; Jump to the main code

    ; Data section
    message db 'Hello, World!', 0   ; Message to be printed

    ; Main code section
    main:
        MOV AH, 0x0E   ; Set AH to display function
        MOV AL, 0     ; Clear AL

        ; Loop through the characters and print them
        MOV SI, message   ; Load the address of the message
    print:
        LODSB   ; Load the byte at [SI] into AL and increment SI
        OR AL, AL   ; Check if AL is zero (end of the string)
        JZ halt     ; If AL is zero, jump to the halt code
        INT 0x10   ; Call the BIOS interrupt to display the character
        JMP print  ; Jump back to the print loop

    halt:
        JMP $   ; Infinite loop to halt the execution

    TIMES 510-($-$$) DB 0   ; Fill remaining bytes with zeroes
    DW 0xAA55   ; Bootloader signature
