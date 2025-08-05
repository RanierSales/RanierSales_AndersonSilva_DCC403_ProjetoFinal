; ====================================================================
; mbr.asm - Bootloader Master com gerenciamento de kernel
; ====================================================================

org 0x7C00
bits 16

start:
    ; Salva o drive de boot passado pela BIOS em DL
    mov [boot_drive], dl
    
    ; Inicializa os registradores de segmento
    cli
    xor ax, ax
    mov es, ax
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00
    sti
    
    ; Limpa a tela
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; Exibe o menu
    mov si, msg_title
    call print
    mov si, opt1
    call print
    mov si, opt2
    call print
    mov si, opt3
    call print

menu_loop:
    mov ah, 0x00
    int 0x16

    cmp al, '1'
    je load_kernel1
    cmp al, '2'
    je load_kernel2
    cmp al, '3'
    je load_kernel3
    
    jmp menu_loop

; ====================================================================
; Rotinas de Carregamento CHS para setores próximos
; ====================================================================

load_kernel1:
    mov ah, 0x02
    mov al, 10
    mov ch, 0
    mov cl, 3
    mov dh, 0
    mov dl, [boot_drive]
    mov bx, 0x1000
    mov es, bx
    xor bx, bx
    int 0x13
    jc disk_error
    jmp 0x1000:0000

load_kernel2:
    mov ah, 0x02
    mov al, 10
    mov ch, 0
    mov cl, 4
    mov dh, 0
    mov dl, [boot_drive]
    mov bx, 0x1000
    mov es, bx
    xor bx, bx
    int 0x13
    jc disk_error
    jmp 0x1000:0000

load_kernel3:
    mov ah, 0x02
    mov al, 10
    mov ch, 0
    mov cl, 5
    mov dh, 0
    mov dl, [boot_drive]
    mov bx, 0x1000
    mov es, bx
    xor bx, bx
    int 0x13
    jc disk_error
    jmp 0x1000:0000

; ====================================================================
; Funções Utilitárias e Dados
; ====================================================================
disk_error:
    mov si, msg_fail
    call print
    hlt

print:
    mov ah, 0x0E
.print_loop:
    lodsb
    or al, al
    jz .done
    int 0x10
    jmp .print_loop
.done:
    ret

boot_drive  db 0

msg_title   db 'Selecione o Kernel para boot:', 0x0D, 0x0A, 0
opt1        db '1) Kernel Padrao (CHS C0 H0 S2)', 0x0D, 0x0A, 0
opt2        db '2) Kernel Alternativo (CHS C0 H0 S3)', 0x0D, 0x0A, 0
opt3        db '3) Kernel Diagnostico (CHS C0 H0 S4)', 0x0D, 0x0A, 0
msg_fail    db 'Erro ao carregar o kernel.', 0x0D, 0x0A, 0

; Assinatura de boot
times 510-($-$$) db 0
dw 0xAA55