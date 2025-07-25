OUTPUT_FORMAT("elf32-i386")
ENTRY(kmain)

SECTIONS {
  . = 0x00100000;      /* endereço virtual de carga (ajuste ao seu carregador) */
  .text : { *(.text) }
  .rodata : { *(.rodata) }
  .data : { *(.data) }
  .bss : { *(.bss COMMON) }
}
