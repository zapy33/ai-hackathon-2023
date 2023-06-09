ORG 0x1000    ; Set origin to kernel entry point

    ; Data section
    BITS 16
    image_start equ 0xA000
    image_width equ 706
    image_height equ 400
    image_width_bytes equ image_width * 3  ; Multiply by 3 (RGB)
    image_height_bytes_low equ image_height & 0xFF   ; Lower byte of image_height
    image_height_bytes_high equ (image_height >> 8) & 0xFF  ; Upper byte of image_height
    image_size equ image_width_bytes * image_height
    image_file db 'image.raw', 0

    ; Main code section
    start:
        ; Load image from file
        mov ax, 0x13         ; Set video mode 320x200x256 (mode 0x13)
        int 0x10             ; Call BIOS interrupt to set video mode

        mov si, image_file   ; Load the address of the image file
        mov ah, 0x3D         ; Open file function
        mov al, 0x00         ; Read-only mode
        xor cx, cx           ; No attributes
        int 0x21             ; Call DOS interrupt to open file

        mov bx, ax           ; Save file handle

        mov ah, 0x3F         ; Read file function
        mov eax, image_size  ; Read the entire image size into EAX
        mov edx, image_start ; Destination memory address
        int 0x21             ; Call DOS interrupt to read file

        mov ah, 0x3E         ; Close file function
        int 0x21             ; Call DOS interrupt to close file

        ; Display the image
        mov ax, 0x0003       ; Set video mode 80x25 text (mode 3)
        int 0x10             ; Call BIOS interrupt to set video mode

        xor si, si           ; Initialize source index to 0

        mov ax, 0x0A00       ; Set ES segment to 0xA000 (where image is loaded)
        mov ds, ax           ; Set DS segment to 0xA000
        mov es, ax           ; Set ES segment to 0xA000

        mov cx, image_height ; Set outer loop counter to image height

    outer_loop:
        xor di, di           ; Initialize destination index to 0
        mov dx, image_width_bytes ; Set inner loop counter to image width in bytes

    inner_loop:
        lodsb                ; Load the byte at [SI] into AL and increment SI
        stosb                ; Store the byte in AL to [ES:DI] and increment DI

        dec dx               ; Decrement inner loop counter
        jnz inner_loop       ; Jump back to inner loop if counter is not zero

        add di, 320 - image_width_bytes ; Adjust DI to next line of the screen

        dec cx               ; Decrement outer loop counter
        jnz outer_loop       ; Jump back to outer loop if counter is not zero

    end_loop:
        cli                  ; Disable interrupts
        hlt                  ; Halt the CPU

    TIMES 510-($-$$) DB 0    ; Fill remaining bytes with zeroes
    DW 0xAA55              ; Bootloader signature
