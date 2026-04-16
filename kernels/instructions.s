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
