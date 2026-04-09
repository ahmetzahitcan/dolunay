.section .text
.include "instructions.s"

start:
    csrr x2, mhartid
    srli x31, x2, 16
    slli x31, x31, 2
    andi x2, x2, 0xe
    slli x2, x2, 2
    binit x31, 0x0
    la x3, base
    add x3, x3, x2
    jalr x1, 0(x3)
    bsync x31, 0x0
    j .

base:
    li x4, 0x123
    jr x1
    li x4, 0x456
    jr x1
    li x4, 0x789
    jr x1
    li x4, 0x159
    jr x1

    li x4, 0x357
    jr x1
    li x4, 0x147
    jr x1
    li x4, 0x258
    jr x1
    li x4, 0x369
    jr x1
