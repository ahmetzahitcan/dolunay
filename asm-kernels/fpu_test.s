.section .text
.include "instructions.s"

li x1, 0x40a00000
li x2, 0x40200000
fadd.s x3, x1, x2
li x4, 0x40f00000
sub x5, x3, x4
li x6, 1
czero.nez x7, x6, x5
wdone
j .
