INCLUDE "link/mem.ld"

STACK_SIZE = 0x1000;

SECTIONS
{
    .text :
    {
        . = ALIGN(4);
        KEEP(*(.vecs*))
        *(.text*)
        *(.rodata*)
        . = ALIGN(4);
    } > FLASH

    .bss (NOLOAD) :
    {
        . = ALIGN(4);
        _bss_start = .;
        *(COMMON)
        *(.bss*)
        . = ALIGN(4);
        _bss_end = .;
    } > RAM

    .data :
    {
        . = ALIGN(4);
        _data_start = .;
        *(.data*)
        . = ALIGN(4);
        _data_end = .;
    } > RAM AT > FLASH

    _data_lma = LOADADDR(.data);

    .stack (NOLOAD):
    {
        . = ALIGN(8);
        _stack_start = .;
        . = . + STACK_SIZE;
        . = ALIGN(8);
        _stack_end = .;
    } > RAM
}