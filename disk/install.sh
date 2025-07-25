#!/usr/bin/env bash
set -e

# Setor 0 — MBR
dd if=../bootloader/mbr.bin of=disk.img bs=512 seek=0 conv=notrunc

# Setor 1 — Stage2
dd if=../bootloader/stage2.bin of=disk.img bs=512 seek=1 conv=notrunc

# Setor 2 em diante — Kernel
dd if=../kernel/kernel.bin of=disk.img bs=512 seek=2 conv=notrunc
