MEMORY
{
    IROM (rx) : ORIGIN = 0x00000000, LENGTH = 4K
    HCOM (rw) : ORIGIN = 0x40000000, LENGTH = 1K
    WRAM (rw) : ORIGIN = 0x40000400, LENGTH = 15K
    TLS  (rw) : ORIGIN = 0x80000000, LENGTH = 1K
}

ENTRY(_start)

SECTIONS
{
    .text.init : ALIGN(4)
    {
        *(.text.init)
        . = ALIGN(4);
    } > IROM

    .text : ALIGN(4)
    {
        *(.text*)
        . = ALIGN(4);
    } > IROM

    .rodata : ALIGN(4)
    {
        *(.rodata*)
        . = ALIGN(4);
    } > IROM

    .hostcom (NOLOAD) : ALIGN(4)
    {
        *(.hostcom*)
        . = ALIGN(4);
    } > HCOM
    
    . = ORIGIN(HCOM) + LENGTH(HCOM) - SIZEOF(.hpmdata);

    .hpmdata : ALIGN(4)
    {
        *(.hpmdata*)
        . = ALIGN(4);
    } > HCOM

    /* The 'AT' ensures the data is physically in ROM so we can copy it */
    .data : ALIGN(4)
    {
        _sdata = .;
        PROVIDE(__global_pointer$ = . + 0x800);
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } > WRAM AT > IROM
    _sidata = LOADADDR(.data); /* The address in ROM where .data starts */

    .bss : ALIGN(4)
    {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } > WRAM

    .tdata : ALIGN(4)
    {
        _stdata = .;
        *(.tdata*)
        . = ALIGN(4);
        _etdata = .;
    } > TLS AT > IROM
    _sitdata = LOADADDR(.tdata);

    .tbss : ALIGN(4)
    {
        _stbss = .;
        *(.tbss*)
        . = ALIGN(4);
        _etbss = .;
    } > TLS

    .stack : ALIGN(4)
    {
        _stack_bottom = .;
        . = ORIGIN(TLS) + LENGTH(TLS);  /* push to end of TLS */
        _stack_top = .;
    } > TLS

    ASSERT(_start == ORIGIN(IROM), "_start is not at the entry point.")
    ASSERT((_stack_top - _stack_bottom >= 64), "Stack too small after TLS data.")
    ASSERT((LOADADDR(.tdata) + SIZEOF(.tdata) <= ORIGIN(IROM) + LENGTH(IROM)), "IROM overflow.")
}