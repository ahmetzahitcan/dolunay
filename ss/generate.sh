#!/bin/bash
#
# Build one C kernel into the image read by the RTL's IROM:  ./generate.sh vecadd.c
#
# Expects a bare-metal RISC-V toolchain named riscv32-unknown-elf-*. Distributions
# ship other names, so provide two shims per machine, somewhere on PATH:
#
#   riscv32-unknown-elf-gcc       Fedora -> riscv64-linux-gnu-gcc
#                                 Ubuntu -> riscv64-unknown-elf-gcc
#                                 xPack  -> riscv-none-elf-gcc
#   riscv32-unknown-elf-objcopy   the matching objcopy
#
# On Windows, put the toolchain's bin on PATH from inside the shim: with -flto
# the linker loads its LTO plugin from libexec, and the plugin's runtime DLLs
# are resolved through PATH.
#
# Writes ../irom.mem and ../irom.coe, plus kernel.bin and a.out here.

cd "$(dirname "$0")" && \
riscv32-unknown-elf-gcc -march=rv32i_zicsr_zicond_zalrsc_zba_zicntr_zihpm -mabi=ilp32 -nostdlib -ffreestanding -flto -static kernels/$1 crt0.s src/*.c -Ihdr -T link.ld -O3 -mbranch-cost=5 && \
riscv32-unknown-elf-objcopy -O binary a.out kernel.bin && \
python3 ../bin_to_coe.py kernel.bin ../irom.coe && \
hexdump -v -e '1/4 "%08x " "\n"' kernel.bin > ../irom.mem
