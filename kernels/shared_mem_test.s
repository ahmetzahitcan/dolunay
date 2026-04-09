.section .text
.include "instructions.s"

start: 
    csrr x1, mhartid
    srli x2, x1, 16
    bnez x2, halt
    andi x2, x1, 0b11111110
    beqz x2, thread0_1
    andi x2, x1, 0b11111100
    beqz x2, thread2_3

others:
    li x2, 100
waste_time:
    yield
    addi x2, x2, -1
    bnez x2, waste_time
read_value:
    lw x3, 0(x0)
    lw x4, 4(x0)
halt:
    yield
    j halt

thread0_1:
    li x2, 0x0badbabe
    sw x2, 0(x0)
    j halt

thread2_3:
    li x2, 0xdeadbeef
    sw x2, 4(x0)
    j halt
