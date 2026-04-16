.section .text
.include "instructions.s"

start:
    csrr x2, xthrid
    csrr x31, xwarpid
    li x30, 0x40000000
    sh2add x31, x31, x30
    andi x2, x2, 0xe
    lla x3, base
    sh2add x3, x2, x3
    binit x31, 0x0
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
