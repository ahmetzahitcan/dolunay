.section .text
.include "instructions.s"

li x3, 0x40000000
csrr x4, xwarpid
sh2add x3, x4, x3
binit x3, 0
li x1, -1
_loop:
    addi x1, x1, 1
    csrr x2, xrole
    bnez x2, _loop
bsync x3, 0
wdone
j .
