; ====================================================================
; kernel1.asm - Kernel em assembly de 16 bits
; ====================================================================

bits 16
org 0x0 ; O linker irá mapear para o endereço de carregamento

_start:
    ; Configura os registradores de segmento para o segmento de código
    ; O linker script e o bootloader garantem que o código esteja em 0x1000
    mov ax, 0x1000
    mov ds, ax
    mov es, ax
    mov ss, ax

    ; Configura o stack pointer
    mov sp, 0xFFFE

    ; Limpa a tela antes de imprimir (opcional, mas bom para consistência)
    mov ax, 0x03
    int 0x10

    ; Exibe a mensagem do kernel
    mov si, kernel_message
    call print_string

    ; Loop infinito para parar a execução
    hlt

print_string:
    ; Configura ES para o segmento de memória de vídeo (0xB800)
    mov ax, 0xB800
    mov es, ax
    
    ; Define DI como o offset inicial para a memória de vídeo
    xor di, di

.print_loop:
    ; Carrega o próximo caractere da string em DS:SI para AL
    lodsb

    ; Verifica se eh o terminador nulo da string
    or al, al
    jz .done

    ; Escreve o caractere na memória de vídeo
    mov [es:di], al

    ; Escreve o atributo de cor (Branco sobre preto)
    mov byte [es:di + 1], 0x0F

    ; Avanca o ponteiro da tela para a proxima posicao (2 bytes: caractere + cor)
    add di, 2
    
    jmp .print_loop

.done:
    ret


; ====================================================================
; Dados
; ====================================================================

kernel_message db 'Kernel 2 carregado com sucesso!', 0x0D, 0x0A, 0