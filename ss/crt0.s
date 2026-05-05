.include "../asm-kernels/instructions.s"
.equ WARP_COUNT, 4

.section .text.init
.global _start

_start:
    # Get warp id
    csrr s1, xwarpid

    # Initialize stack
    la sp, _stack_top

    # Copy globals into WRAM
    la t0, _sidata
    sh2add t0, s1, t0
    la t1, _sdata
    sh2add t1, s1, t1
    la t2, _edata
    1:
        bgeu t1, t2, 2f
        lw t3, 0(t0)
        sw t3, 0(t1)
        addi t0, t0, 4*WARP_COUNT
        addi t1, t1, 4*WARP_COUNT
        j 1b
    2:

    # Clear BSS
    la t0, _sbss
    sh2add t0, s1, t0
    la t1, _ebss
    1:
        bgeu t0, t1, 2f
        sw zero, 0(t0)
        addi t0, t0, 4*WARP_COUNT
        j 1b
    2:

    # Copy thread-local globals into TLS
    la t0, _sitdata
    la t1, _stdata
    la t2, _etdata
    1:
        bgeu t1, t2, 2f
        lw t3, 0(t0)
        sw t3, 0(t1)
        addi t0, t0, 4
        addi t1, t1, 4
        j 1b
    2:

    # Clear TBSS
    la t0, _stbss
    la t1, _etbss
    1:
        bgeu t0, t1, 2f
        sw zero, 0(t0)
        addi t0, t0, 4
        j 1b
    2:

    # Call main
    la s0, barrs
    sh2add s0, s1, s0
    binit s0, 0
    call main
    bsync s0, 0

    # Halt
    wdone
    j .

.section .bss.crt0_barrs
barrs: .zero (4 * WARP_COUNT)
