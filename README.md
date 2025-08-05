# Gerenciador de Boot Inspirado no GRUB com Simulação via QEMU

Projeto desenvolvido como parte da disciplina **DCC403 - Sistemas Operacionais I** da **Universidade Federal de Roraima**. O objetivo é criar um gerenciador de boot simplificado, inspirado no GRUB, utilizando simulação em ambientes controlados com o QEMU.

---

## 🎯 Objetivos do Projeto

- Compreender o funcionamento básico do processo de boot.
- Simular arquiteturas x86 utilizando o QEMU.
- **Implementar um gerenciador de boot em um único estágio** (MBR), consolidando a lógica de menu e carregamento de kernel.
- Integrar o gerenciador com um kernel simples em um sistema de arquivos virtual.
- Implementar as seguintes funcionalidades avançadas:
  - Menu de boot com seleção interativa no MBR.
  - Suporte a múltiplos kernels, com base na escolha do usuário.
  - **Kernel interativo** que aceita comandos, como o 'poweroff'.

---

## ⚙️ Tecnologias e Ferramentas Utilizadas

- **Ambiente**: Linux (ou WSL para Windows)
- **Ferramentas**:
  - [QEMU](https://www.qemu.org/)
  - [NASM](https://www.nasm.us/)
  - GCC
  - `dd`, `mkfs.fat`, `mount`, `losetup`, `objcopy`
- **Linguagens**:
  - Assembly (NASM)
- **Conceitos relevantes**:
  - Endereçamento de memória
  - MBR (Master Boot Record)
  - Interrupções
  - Chamadas de BIOS

---

## 🧱 Etapas do Projeto

1. **Estudo Teórico**
   - Revisão sobre o processo de boot e funcionamento do GRUB.
2. **Configuração do Ambiente**
   - Instalação das ferramentas e do QEMU.
3. **Criação da Imagem de Disco**
   - Criação de imagem com MBR e sistema de arquivos FAT12/FAT16.
4. **Bootloader (Estágio Único)**
   - Código do MBR em Assembly responsável por exibir um menu de seleção e carregar o kernel diretamente.
5. **Desenvolvimento do Kernel**
   - Kernel simples em Assembly com funcionalidades interativas, como:
     - Impressão de texto
     - Leitura de comandos do usuário
     - Execução de comandos como 'poweroff'
6. **Execução e Testes**
   - Testes usando `qemu-system-x86_64`.
7. **Documentação Técnica**
   - Descrição das decisões de projeto, funcionamento e limitações.

---

## 📂 Estrutura do Projeto

- /bootloader         --> Código do Master Boot Record (MBR)
- /kernel             --> Kernel(s) simples em Assembly
- /disk               --> Disco que será gerado o Bootload
- /docs               --> Documentação técnica do projeto
- Makefile            --> Automação de build
- README.md           --> Documento principal do projeto
- EXECUCAO.md         --> Instruções de execução e estrutura do projeto


Projeto acadêmico da disciplina DCC403 - Sistemas Operacionais I
Universidade Federal de Roraima – Departamento de Ciência da Computação
Alunos: [Ranier Sales](https://github.com/RanierSales) e [Anderson Silva](https://github.com/Moab76)