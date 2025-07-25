org 0x0600      ; gravado pelo MBR em 0x0000:0x0600
bits 16

start:
    ; limpar tela
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; exibir opções
    mov si, opt1
    call print
    mov si, opt2
    call print

menu_loop:
    mov ah, 0x00
    int 0x16
    cmp al, '1'
    je load_kernel
    cmp al, '2'
    je other
    jmp menu_loop

load_kernel:
    ; …. seu código de carregar kernel (ou hlt por enquanto)
    hlt

other:
    hlt

; — rotina de print — (pode vir do common.asm)
print:
    mov ah, 0x0E
.next:
    lodsb
    or al, al
    jz .done
    int 0x10
    jmp .next
.done:
    ret

opt1 db '1) Carregar kernel',0x0D,0x0A,0
opt2 db '2) Outra opção',0x0D,0x0A,0

; completar até 512 bytes
times 512-($-$$) db 0
