MEMORY
{
    IROM (rx)  : ORIGIN = 0x00000000, LENGTH = 4K
    WRAM (rw) : ORIGIN = 0x40000000, LENGTH = 16K
    TLS  (rw)  : ORIGIN = 0x80000000, LENGTH = 4K
}

SECTIONS
{
    .text : { *(.text*) } > IROM

    /* The 'AT' ensures the data is physically in ROM so we can copy it */
    .data : 
    {
        _sdata = .;
        *(.data*)
        _edata = .;
    } > WRAM AT > IROM
    _sidata = LOADADDR(.data); /* The address in ROM where .data starts */

    .tdata :
    {
        _stdata = .;
        *(.tdata*)
        _etdata = .;
    } > TLS AT > IROM
    _sitdata = LOADADDR(.tdata);
}