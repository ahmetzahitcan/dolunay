.section .text

start: 
    csrr x1, mhartid
    srli x2, x1, 16
    bnez x2, halt
    andi x2, x1, 0xff
    bnez x2, others
thread0:
    li x2, 0x0badbabe
    sw x2, 0(x0)
    .word 0b00100000000000000000000000001011 # yield
others:
    li x2, 100
waste_time:
    addi x2, x2, -1
    bnez x2, waste_time
read_value:
    lw x3, 0(x0)
halt:
    j halt
