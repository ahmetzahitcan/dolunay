csrr x1, mhartid
li x2, 0xdeadbeef
czero.eqz x3, x2, x1
czero.nez x4, x2, x1
j .
