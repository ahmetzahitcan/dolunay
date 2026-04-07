.section .text

start: 
    csrr x1, mhartid
    bnez x1, others
thread0:
    li x2, 0x0badbabe
    sw x2, 0(x0)
    j .
others:
    li x2, 100
waste_time:
    addi x2, x2, -1
    bnez x2, waste_time
read_value:
    lw x3, 0(x0)
    j .
