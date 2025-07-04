; print.asm
; Reusable BIOS printing functions

[BITS 16]

print_char:
    ; Input: AL = character to print
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    ret

print_string:
    ; Input: DS:SI points to null-terminated string
.print_loop:
    lodsb
    cmp al, 0
    je .done
    call print_char
    jmp .print_loop
.done:
    ret
