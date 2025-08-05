# Diretórios
SRC_DIR := kernel
BOOT_DIR := bootloader
BUILD_DIR := build
DISK_DIR := disk

# Arquivos de origem
MBR_ASM := $(BOOT_DIR)/mbr.asm
KERNEL1_ASM := $(SRC_DIR)/kernel1.asm
KERNEL2_ASM := $(SRC_DIR)/kernel2.asm
KERNEL3_ASM := $(SRC_DIR)/kernel3.asm

# Arquivos de saída
MBR_BIN := $(BUILD_DIR)/mbr.bin
KERNEL1_BIN := $(BUILD_DIR)/kernel1.bin
KERNEL2_BIN := $(BUILD_DIR)/kernel2.bin
KERNEL3_BIN := $(BUILD_DIR)/kernel3.bin
DISK_IMG := $(DISK_DIR)/disk.img

# Criação dos diretórios de build, se não existirem
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
$(DISK_DIR):
	mkdir -p $(DISK_DIR)

# Comando padrão
default: $(DISK_IMG)

# Criação da imagem de disco
$(DISK_IMG): $(MBR_BIN) $(KERNEL1_BIN) $(KERNEL2_BIN) $(KERNEL3_BIN) | $(DISK_DIR)
	@echo "Criando imagem de disco..."
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	dd if=$(MBR_BIN) of=$(DISK_IMG) bs=512 seek=0 conv=notrunc
	dd if=$(KERNEL1_BIN) of=$(DISK_IMG) bs=512 seek=2 conv=notrunc
	dd if=$(KERNEL2_BIN) of=$(DISK_IMG) bs=512 seek=3 conv=notrunc
	dd if=$(KERNEL3_BIN) of=$(DISK_IMG) bs=512 seek=4 conv=notrunc

# Compilação do MBR
$(MBR_BIN): $(MBR_ASM) | $(BUILD_DIR)
	@echo "Compilando MBR..."
	nasm -f bin -o $@ $<

# Compilação do Kernel em Assembly
$(KERNEL1_BIN): $(KERNEL1_ASM) | $(BUILD_DIR)
	@echo "Compilando Kernel 1..."
	nasm -f bin -o $@ $<

$(KERNEL2_BIN): $(KERNEL2_ASM) | $(BUILD_DIR)
	@echo "Compilando Kernel 2..."
	nasm -f bin -o $@ $<

$(KERNEL3_BIN): $(KERNEL3_ASM) | $(BUILD_DIR)
	@echo "Compilando Kernel 3..."
	nasm -f bin -o $@ $<

# Limpeza
clean:
	@echo "Limpando arquivos..."
	rm -f $(BUILD_DIR)/*.bin $(DISK_IMG)