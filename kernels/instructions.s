.equ xwarpid, 0xcc0
.equ xthrid, 0xcc1

.macro binit rs1, imm
    .insn i 0x0b, 0x1, x0, \rs1, \imm
.endm

.macro bsync rs1, imm
    .insn i 0x0b, 0x2, x0, \rs1, \imm
.endm

.macro yield
    .insn i 0x0b, 0x4, x0, x0, 0x0
.endm

.macro rdwuinstret rd
    csrr \rd, hpmcounter3
.endm

.macro rdwuinstreth rd
    csrr \rd, hpmcounter3h
.endm

.macro rdwtinstret rd
    csrr \rd, hpmcounter4
.endm

.macro rdwtinstreth rd
    csrr \rd, hpmcounter4h
.endm

.macro rdwtinstretu rd
    csrr \rd, hpmcounter5
.endm

.macro rdwtinstretuh rd
    csrr \rd, hpmcounter5h
.endm

