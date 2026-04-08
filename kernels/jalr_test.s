.section .text

start:
    csrr x2, mhartid
    andi x2, x2, 0xe
    slli x2, x2, 2
    .word 0b10000000000000000000000000001011 # binit b0
    la x3, base
    add x3, x3, x2
    jalr x1, 0(x3)
    .word 0b01000000000000000000000000001011 # bwait b0
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
