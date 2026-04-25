.section .text
.include "instructions.s"

li x1, 0x40000000
sw x0, 0(x1)

csrr x4, xwarpid
sh2add x4, x4, x1
binit x4, 4

# Atomic increments, implemented via LR/SC
loop:
    lr.w x2, (x1)
    addi x2, x2, 1
    sc.w x3, x2, (x1)
    bnez x3, loop
    
bsync x4, 4
j .
