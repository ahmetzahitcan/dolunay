.section .text
.include "instructions.s"

li x1, 0x3dcccccd # 0.1
li x2, 0x3e4ccccd # 0.2
li x3, 0x3e99999a # 0.3
fmv.s.x f1, x1
fmv.s.x f2, x2
fmv.s.x f3, x3
jal x9, calc
j .

.rept 100
.word 0xFFFFFFFF
.endr

calc:
fdiv.s f4, f1, f2
fadd.s f4, f1, f2
feq.s x5, f3, f4
li x6, 1
czero.eqz x7, x6, x5
csrrw x8, fflags, x0
j .
