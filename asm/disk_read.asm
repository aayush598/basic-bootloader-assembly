; disk_read.asm
; Read one sector from disk using BIOS INT 13h

[BITS 16]

read_sector:
    ; Inputs:
    ;   ES:BX -> destination address
    ;   DL    -> drive number (0x00 = floppy, 0x80 = HDD)
    ;   CH    -> cylinder number (0-1023)
    ;   DH    -> head number
    ;   CL    -> sector number (1-63)
    ; Outputs:
    ;   CF set on failure

    mov ah, 0x02        ; BIOS read sector
    mov al, 0x01        ; Read 1 sector
    ; ES:BX is already set by caller
    int 0x13
    jc .fail            ; Jump if carry flag set (error)
    ret

.fail:
    ; Print "Disk Read Error"
    mov si, read_error_msg
    call print_string
    jmp $

read_error_msg db "Disk Read Error", 0
