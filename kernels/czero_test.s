.section .text
.include "instructions.s"

csrr x2, xwarpid
csrr x3, xthrid
li x4, 1
czero.nez x5, x4, x2
czero.nez x6, x4, x3
or x7, x5, x6
li x1, 0x0
li x8, 0x15a48032
czero.nez x11, x8, x7
add x1, x1, x11
li x9, 0xdeadbeef
czero.eqz x12, x9, x2
add x1, x1, x12
li x10, 0x0badc0de
czero.eqz x13, x10, x3
add x1, x1, x13
wdone
j .

# xwarpid=0 and xthrid=0 -> x1 = 0x0
# xwarpid=0 and xthrid!=0 -> x1 = 0x0 + 0x0badc0de = 0x0badc0de
# xwarpid!=0 and xthrid=0 -> x1 = 0x0 + 0xdeadbeef = 0xdeadbeef
# xwarpid!=0 and xthrid!=0 -> x1 = 0x0 + 0x0badc0de + 0xdeadbeef + 0x15a48032 = 0xffffffff
