#!/bin/bash

cd "$(dirname "$0")" && \
riscv64-unknown-elf-as -march=rv32if_zicsr_zicond_zalrsc_zba_zicntr_zihpm -mabi=ilp32 -o temp.elf "$1" && \
riscv64-unknown-elf-objcopy -O binary -j .text temp.elf temp.bin && \
python3 ../bin_to_coe.py temp.bin ../irom.coe
hexdump -v -e '1/4 "%08x " "\n"' temp.bin > ../irom.mem

rm -f temp.elf temp.bin
