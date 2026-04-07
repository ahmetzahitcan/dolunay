.section .text

LI x8, 0x0badbabe
SW x8, 0(x0)
LB x1, 0(x0)
LBU x2, 1(x0)
LB x3, 2(x0)
LBU x4, 3(x0)
SB x1, 4(x0)
SB x2, 5(x0)
SB x3, 6(x0)
SB x4, 7(x0)
LH x5, 0(x0)
LHU x6, 2(x0)
SH x5, 8(x0)
SH x6, 10(x0)
JAL x0, .
