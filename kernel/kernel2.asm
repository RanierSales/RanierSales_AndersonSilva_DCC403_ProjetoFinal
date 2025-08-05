; ====================================================================
; kernel1.asm - Kernel interativo para desligar com 'poweroff'
; ====================================================================

bits 16
org 0x0

; ====================================================================
; Ponto de Entrada do Kernel
; ====================================================================
_start:
    ; Configura os registradores de segmento para o segmento de código
    mov ax, 0x1000
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0xFFFE

    ; Limpa a tela
    mov ax, 0x03
    int 0x10

    ; Exibe a mensagem de inicialização
    mov si, kernel_message
    call print_string

; ====================================================================
; Loop Principal do Kernel
; ====================================================================
main_loop:
    ; Exibe o prompt '>'
    mov si, prompt_message
    call print_string
    
    ; Define o buffer de entrada e le a linha
    mov di, input_buffer
    call read_line

    ; Compara a entrada com o comando 'poweroff'
    mov si, poweroff_command
    mov di, input_buffer
    call compare_strings
    
    cmp ax, 0
    jne .not_poweroff

    ; Se as strings sao iguais, desliga o sistema
    call shutdown_qemu
    
.not_poweroff:
    mov si, invalid_command_message
    call print_string
    
    ; Volta para o loop principal
    jmp main_loop

; ====================================================================
; Rotina de Leitura de Linha
; Lê do teclado, exibe os caracteres na tela e armazena em um buffer
; ====================================================================
read_line:
    mov cx, 255 ; Limite de caracteres para o buffer
.read_loop:
    mov ah, 0x00 ; Funcao BIOS: ler caractere
    int 0x16     ; Espera por um caractere

    cmp al, 0x0D ; Verifica se a tecla Enter foi pressionada
    je .done_read
    
    cmp al, 0x08 ; Verifica se a tecla Backspace foi pressionada
    je .handle_backspace

    mov ah, 0x0E ; Funcao BIOS: exibir caractere
    int 0x10
    
    mov [di], al
    inc di
    loop .read_loop
    
    jmp .read_loop

.handle_backspace:
    cmp di, input_buffer
    je .read_loop
    
    dec di
    mov byte [di], 0
    
    mov ah, 0x0E
    mov al, 0x08 ; Caractere Backspace
    int 0x10
    
    mov al, ' '
    int 0x10
    
    mov al, 0x08
    int 0x10
    
    jmp .read_loop

.done_read:
    mov byte [di], 0 ; Termina a string com um byte nulo
    mov si, newline
    call print_string
    ret

; ====================================================================
; Rotina de Comparação de Strings
; Compara a string em DS:SI com a string em ES:DI
; Retorna AX = 0 se forem iguais, != 0 se forem diferentes
; ====================================================================
compare_strings:
    push si
    push di
    push cx
    xor ax, ax
.compare_loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne .not_equal
    cmp al, 0
    je .equal_check
    inc si
    inc di
    jmp .compare_loop
.not_equal:
    mov ax, 1
    jmp .done_compare
.equal_check:
    cmp bl, 0
    jne .not_equal
.done_compare:
    pop cx
    pop di
    pop si
    ret

; ====================================================================
; Funções Utilitárias e de Desligamento
; ====================================================================
print_string:
    mov ah, 0x0E
.print_loop:
    lodsb
    or al, al
    jz .done
    int 0x10
    jmp .print_loop
.done:
    ret

shutdown_qemu:
    mov dx, 0x604
    mov ax, 0x2000
    out dx, ax
    jmp $ ; Fallback loop

; ====================================================================
; Dados
; ====================================================================
kernel_message          db 'Kernel 2 carregado com sucesso!', 0x0D, 0x0A, 0
prompt_message          db '> ', 0
poweroff_command        db 'poweroff', 0
invalid_command_message db 'Comando invalido!', 0x0D, 0x0A, 0
newline                 db 0x0D, 0x0A, 0
input_buffer            times 256 db 0