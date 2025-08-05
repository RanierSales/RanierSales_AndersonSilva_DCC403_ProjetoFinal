# 🧠 Projeto Final - Sistema Operacional Simples

Este projeto é um sistema operacional minimalista, escrito em Assembly, que consolidou a lógica do bootloader em um único estágio (MBR) e implementou kernels interativos.

## 📁 Estrutura do Projeto

```
Projeto_Final_SO/
├── bootloader/
│   └── mbr.asm         # Bootloader (Estágio Único) com menu e carregamento
├── kernel/
│   ├── kernel1.asm     # Kernel interativo 1
│   ├── kernel2.asm     # Kernel interativo 2
│   └── kernel3.asm     # Kernel interativo 3
├── disk/
│   └── disk.img        # Imagem final do disco (1.44MB)
├── Makefile
├── EXECUCAO.md         # (Este arquivo)
└── README.md
```

## ⚙️ Compilação

Para compilar todo o projeto, execute:

```bash
make clean && make && make default
```

Esse comando realiza:

- Compilação do MBR (mbr.asm) usando nasm.  
- Compilação dos kernels (kernel1.asm, kernel2.asm, kernel3.asm) usando nasm.  
- Criação da imagem de disco (disk.img).  
- Instalação do MBR e dos kernels nos setores corretos do disco.

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

1. **MBR (mbr.asm):**
   - É carregado automaticamente pela BIOS no endereço 0x7C00.
   - Exibe um menu interativo com as opções de kernel.
   - Carrega o kernel selecionado pelo usuário do disco para o endereço 0x1000:0000 e o executa.

2. **Kernel (kernelX.asm):**
   - Um programa simples em Assembly que exibe uma mensagem de boas-vindas.
   - Apresenta um prompt (`> `) para o usuário.
   - Lê a entrada do teclado e, se o comando `poweroff` for digitado, desliga o QEMU.

## 📌 Requisitos

- nasm  
- qemu  
- make  

## 👨‍💻 Autores

- [Ranier Sales](https://github.com/RanierSales)
- [Anderson Silva](https://github.com/Moab76)