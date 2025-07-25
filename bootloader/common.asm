; Rotina de impressão BIOS (teletipo) usada tanto no MBR quanto no Stage2
; Exporte o símbolo para que o linker (nos estágios em flat‑bin) o situe corretamente
print:
    mov ah, 0x0E
.print_next:
    lodsb
    or al, al
    jz .print_ret
    int 0x10
    jmp .print_next
.print_ret:
ret
