riscv64-linux-gnu-gcc -march=rv32i_zicsr_zicond_zalrsc_zba_zicntr_zihpm -mabi=ilp32 -nostdlib -ffreestanding -static test.c crt0.s -T link.ld -O3
riscv64-linux-gnu-objdump -sd a.out