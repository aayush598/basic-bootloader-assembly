; stage1_bootloader.asm
; First stage MBR bootloader using print.asm module

[BITS 16]
[ORG 0x7C00]

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov si, msg
    call print_string

    jmp $

msg db "Hello, Modular Print!", 0

%include "asm/print.asm"

times 510 - ($ - $$) db 0
dw 0xAA55
