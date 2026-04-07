.section .text

li x15, 0x80000000
# csrr x8, mhartid
li x8, 0x0badbabe
sw x8, 0(x15)
lb x1, 0(x15)
lbu x2, 1(x15)
lb x3, 2(x15)
lbu x4, 3(x15)
sb x1, 4(x15)
sb x2, 5(x15)
sb x3, 6(x15)
sb x4, 7(x15)
lh x5, 0(x15)
lhu x6, 2(x15)
sh x5, 8(x15)
sh x6, 10(x15)
j .
