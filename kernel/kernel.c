// kernel.c
void kmain(void) {
    char *msg = "Olá do kernel em C!\n";
    char *p = msg;
    while (*p) {
        asm volatile (
            "mov $0x0E, %%ah\n\t"
            "mov %0, %%al\n\t"
            "int $0x10"
            :
            : "r"(*p++)
        );
    }
    for (;;) asm("hlt");
}
