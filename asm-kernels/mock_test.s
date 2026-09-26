.section .text
.include "instructions.s"

li x1, 0x3fc00000 # 1.5
li x2, 0x3f400000 # 0.75
li x3, 0xbfa00000 # -1.25
fmv.s.x f1, x1
fmv.s.x f2, x2
fmv.s.x f3, x3
fdiv.s f4, f1, f2
fmadd.s f4, f1, f2, f3 # -0.125 (be000000)
fmv.x.s x4, f4
li x5, 0xbe000000
sub x5, x5, x4
li x6, 1
czero.nez x7, x6, x5
