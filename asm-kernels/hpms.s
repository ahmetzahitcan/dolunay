.section .text
.include "instructions.s"

.macro spin time
    li x31, \time
    addi x31, x31, -1
    bnez x31, .-4
.endm

rdcycle x11
rdcycleh x16
rdtime x12
rdtimeh x17
rdinstret x13
rdinstreth x18
rdwtinstret x14
rdwtinstreth x19
rdwuinstret x15
rdwuinstreth x20

spin 100000

rdcycle x21
rdcycleh x26
rdtime x22
rdtimeh x27
rdinstret x23
rdinstreth x28
rdwtinstret x24
rdwtinstreth x29
rdwuinstret x25
rdwuinstreth x30

sub x1, x21, x11
sub x6, x26, x16
sub x2, x22, x12
sub x7, x27, x17
sub x3, x23, x13
sub x8, x28, x18
sub x4, x24, x14
sub x9, x29, x19
sub x5, x25, x15
sub x10, x30, x20

wdone
j .
