#!/bin/bash

cd "$(dirname "$0")" && \
riscv64-linux-gnu-gcc -march=rv32i_zicsr_zicond -mabi=ilp32 -nostdlib -static -o temp.elf "$1" && \
riscv64-linux-gnu-objcopy -O binary -j .text temp.elf temp.bin && \
hexdump -v -e '1/4 "%08x " "\n"' temp.bin > irom.mem

rm -f temp.elf temp.bin