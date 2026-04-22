.section .text
.include "instructions.s"

csrr x3, xwarpid

li x1, 0x40004000
sh2add x1, x3, x1
binit x1, 0

csrr x2, xthrid
bnez x2, finish

la x4, msg
la x8, msg_end
sh2add x5, x3, x4
li x6, 0x40000000
sh2add x6, x3, x6

loop:
    lw x7, 0(x5)
    sw x7, 0(x6)
    addi x5, x5, 16
    addi x6, x6, 16
    bgeu x5, x8, finish
    j loop

finish:
    bsync x1, 0
    j .

msg: .asciz "Hello Microblaze from Dolunay!"
msg_end:
