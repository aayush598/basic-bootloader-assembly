[BITS 16]
[ORG 0x7C00]

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; Display message
    mov si, msg
    call print_string

    ; Setup ES:BX = 0x0000:0500
    mov ax, 0x0000
    mov es, ax
    mov bx, 0x0500

    ; Read sector 2 (CH=0, CL=2, DH=0)
    mov dl, 0x00     ; Floppy (for QEMU)
    mov ch, 0x00     ; Cylinder
    mov cl, 0x02     ; Sector number (1-based)
    mov dh, 0x00     ; Head
    call read_sector

    ; Print what was loaded at 0x0500 (assume string at start of sector)
    mov si, 0x0500
    call print_string

    jmp $

msg db "Reading sector 2...", 0

%include "asm/print.asm"
%include "asm/disk_read.asm"

times 510 - ($ - $$) db 0
dw 0xAA55
