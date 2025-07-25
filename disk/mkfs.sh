#!/usr/bin/env bash
set -e

# Cria uma imagem de 1.44MB preenchida com zeros
dd if=/dev/zero of=disk.img bs=512 count=2880
