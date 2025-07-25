# Ferramentas
NASM    := nasm
GCC     := gcc
LD      := ld
OBJCOPY := objcopy

# Alvo principal
all: disk/disk.img

# 1. Compila o MBR (512 bytes)
bootloader/mbr.bin: bootloader/mbr.asm bootloader/common.asm
	$(NASM) -f bin bootloader/mbr.asm -o bootloader/mbr.bin

# 2. Compila o Stage2
bootloader/stage2.bin: bootloader/stage2.asm bootloader/common.asm
	$(NASM) -f bin bootloader/stage2.asm -o bootloader/stage2.bin

# 3. Compila o kernel em formato ELF e depois binário
kernel/kernel.o: kernel/kernel.c
	$(GCC) -ffreestanding -m32 -c kernel/kernel.c -o kernel/kernel.o

kernel/kernel.elf: kernel/kernel.o kernel/linker.ld
	$(LD) -m elf_i386 -T kernel/linker.ld -o kernel/kernel.elf kernel/kernel.o

kernel/kernel.bin: kernel/kernel.elf
	$(OBJCOPY) -O binary kernel/kernel.elf kernel/kernel.bin

# 4. Cria e instala a imagem de disco
disk/disk.img: bootloader/mbr.bin bootloader/stage2.bin kernel/kernel.bin
	cd disk && ./mkfs.sh
	cd disk && ./install.sh

# 5. Limpa tudo
clean:
	rm -f bootloader/*.bin kernel/*.o kernel/*.elf kernel/*.bin disk/disk.img

.PHONY: all clean
