
# 🧠 Projeto Final - Sistema Operacional Simples

Este projeto é um sistema operacional minimalista escrito em Assembly e C. Ele possui um bootloader dividido em duas fases (MBR e Stage2), além de um kernel básico.

## 📁 Estrutura do Projeto

```
Projeto_Final_SO/
├── bootloader/
│   ├── mbr.asm         # Bootloader (MBR - Stage 1)
│   └── stage2.asm      # Menu interativo (Stage 2)
├── kernel/
│   ├── kernel.c        # Código-fonte do kernel
│   ├── linker.ld       # Script de linkagem
├── disk/
│   ├── mkfs.sh         # Cria a imagem vazia do disco
│   ├── install.sh      # Instala os binários no disco
│   └── disk.img        # Imagem final do disco (1.44MB)
├── Makefile
├── EXECUCAO.md         # (Este arquivo)
└── README.md
```

## ⚙️ Compilação

Para compilar todo o projeto, execute:

```bash
make clean && make
```

Esse comando realiza:

- Compilação do MBR (`mbr.asm`) e Stage2 (`stage2.asm`) usando `nasm`
- Compilação do `kernel.c` com `gcc` e `ld`
- Conversão do ELF para binário com `objcopy`
- Criação e formatação do disco com `mkfs.sh`
- Instalação de todos os binários no `disk.img` com `install.sh`

## 🏃 Execução

Para testar o sistema com o QEMU, use:

```bash
qemu-system-x86_64 -drive format=raw,file=disk/disk.img,if=ide -boot order=c
```

Ou para sistemas 32 bits:

```bash
qemu-system-i386 -drive format=raw,file=disk/disk.img,if=ide -boot order=c
```

## 🔁 Fluxo de Boot

1. **MBR (mbr.asm)**:
   - É carregado automaticamente pela BIOS no endereço `0x7C00`.
   - Mostra "Booting..."
   - Carrega o Stage2 (setor 2) para `0x0600` e o executa.

2. **Stage2 (stage2.asm)**:
   - Exibe um menu com duas opções.
   - Ao pressionar `1`, o sistema carrega o kernel ou executa um `hlt`.
   - `2` é outra opção reservada (também faz `hlt` por padrão).

3. **Kernel (kernel.c)**:
   - Um programa simples em C com suporte básico a texto (exibe "Olá do Kernel!" ou similar).
   - Compilado em formato binário plano (`.bin`), executado em modo protegido (em desenvolvimento futuro).

## 📌 Requisitos

- `nasm`
- `gcc` com suporte a `-m32` (instale `gcc-multilib`)
- `qemu`
- `make`

## 👨‍💻 Autores

- Ranier Sales  
- Anderson Silva