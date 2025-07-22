# Gerenciador de Boot Inspirado no GRUB com Simulação via QEMU

Projeto desenvolvido como parte da disciplina **DCC403 - Sistemas Operacionais I** da **Universidade Federal de Roraima**. O objetivo é criar um gerenciador de boot simplificado, inspirado no GRUB, utilizando simulação em ambientes controlados com o QEMU.

---

## 🎯 Objetivos do Projeto

- Compreender o funcionamento básico do processo de boot.
- Simular arquiteturas x86 utilizando o QEMU.
- Implementar um gerenciador de boot utilizando Assembly (NASM) e/ou C.
- Integrar o gerenciador com um kernel simples em um sistema de arquivos virtual.
- Implementar pelo menos **uma** das funcionalidades avançadas:
  - Menu de boot com seleção interativa;
  - Leitura de arquivos FAT12 ou FAT16 para carregar o kernel;
  - Suporte a múltiplos kernels, com base na escolha do usuário.

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
  - C
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
4. **Bootloader (1º Estágio)**
   - Código simples em Assembly responsável por carregar o 2º estágio.
5. **Gerenciador de Boot (2º Estágio)**
   - Exibição de menu (se implementado);
   - Acesso a arquivos no disco (se FAT12/FAT16 implementado);
   - Carregamento de um ou mais kernels conforme seleção do usuário.
6. **Desenvolvimento do Kernel**
   - Kernel simples em C com funcionalidades mínimas, como:
     - Impressão de texto
     - Execução de loops
7. **Execução e Testes**
   - Testes usando `qemu-system-x86_64`.
8. **Documentação Técnica**
   - Descrição das decisões de projeto, funcionamento e limitações.

---

## 📂 Estrutura do Projeto

- /bootloader         --> Código do primeiro e segundo estágio
- /kernel             --> Kernel(s) simples em C
- /disk               --> Scripts de geração da imagem de disco
- /docs               --> Documentação técnica do projeto
- Makefile            --> Automação de build
- README.md           --> Documento principal do projeto
- EXECUCAO.md         --> Instruções de execução e estrutura do projeto


Projeto acadêmico da disciplina DCC403 - Sistemas Operacionais I
Universidade Federal de Roraima – Departamento de Ciência da Computação
Alunos: Ranier Sales e Anderson Silva
