#!/bin/bash
#
# Assemble one hand-written test into the image read by the RTL's IROM:
#   ./generate.sh shared_mem_test.s
#
# Expects a bare-metal RISC-V toolchain named riscv32-unknown-elf-*. Distributions
# ship other names, so provide two shims per machine, somewhere on PATH:
#
#   riscv32-unknown-elf-gcc       Fedora -> riscv64-linux-gnu-gcc
#                                 Ubuntu -> riscv64-unknown-elf-gcc
#                                 xPack  -> riscv-none-elf-gcc
#   riscv32-unknown-elf-objcopy   the matching objcopy
#
# On Windows, put the toolchain's bin on PATH from inside the shim; same shim pair
# as ss/generate.sh (see the note there about -flto and the linker plugin).
#
# Writes ../irom.mem and ../irom.coe.

cd "$(dirname "$0")" && \
riscv32-unknown-elf-gcc -march=rv32if_zicsr_zicond_zalrsc_zba_zicntr_zihpm -mabi=ilp32 -nostdlib -static -o temp.elf "$1" && \
riscv32-unknown-elf-objcopy -O binary -j .text temp.elf temp.bin && \
python3 ../bin_to_coe.py temp.bin ../irom.coe
hexdump -v -e '1/4 "%08x " "\n"' temp.bin > ../irom.mem

rm -f temp.elf temp.bin
