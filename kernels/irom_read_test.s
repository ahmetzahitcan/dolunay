.section .text
.include "instructions.s"

start:
    lla x1, target
    lw x2, 0(x1)
    lh x3, 2(x1)
    lb x4, 3(x1)
    sw x2, 4(x1) # since this is targeting IROM, it's a NOP
    j .
    
target:
    .word 0x12345678
