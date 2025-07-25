org 0x7C00
bits 16

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    sti

    ; Salva o drive de boot passado em DL
    mov [boot_drive], dl

    ; Imprime "Booting..."
    mov si, msg_boot
    call print

    ; Carrega Stage2 (setor 2) para 0x0000:0x0600
    mov ah, 0x02        ; Função BIOS: ler setores
    mov al, 1           ; Quantidade: 1 setor
    mov ch, 0           ; Cilindro 0
    mov cl, 2           ; Setor 2 (MBR é setor 1)
    mov dh, 0           ; Cabeça 0
    mov dl, [boot_drive] ; Drive de boot
    mov bx, 0x0600      ; Offset do destino
    int 0x13            ; Chamada BIOS: ler setor
    jc disk_error       ; Se falhou, pula pro erro

    jmp 0x0000:0x0600   ; Executa o Stage2

disk_error:
    mov si, msg_diskerr
    call print
    cli
    hlt

; -------------------------------
; Imprime string terminada em 0
print:
    mov ah, 0x0E        ; Teletype output
.print_loop:
    lodsb               ; Carrega próximo caractere de SI em AL
    or al, al           ; Testa fim da string (AL == 0?)
    jz .done
    int 0x10            ; BIOS: exibe caractere
    jmp .print_loop
.done:
    ret

; -------------------------------
; Dados
boot_drive db 0
msg_boot    db 'Booting...', 0
msg_diskerr db 'Erro ao ler disco!', 0

; Preenche até 510 bytes
times 510 - ($ - $$) db 0
dw 0xAA55   ; Assinatura de boot
