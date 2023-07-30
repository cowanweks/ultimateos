[BITS 16]
[ORG 0x7c00]

section .text

%include "asm/kernel.asm"

_boot_start:
    mov ah, 0x0e
    mov al, [_msg + esi]
    int 0x10
    add esi, 1
    cmp byte [_msg + esi], 0
    jne _boot_start
    
_msg db "Booting into Ultimate OS", 0

times 510 - ($ -$$) db 0
dw 0xAA55