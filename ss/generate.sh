riscv64-linux-gnu-gcc -march=rv32i_zicsr_zicond_zalrsc_zba_zicntr_zihpm -mabi=ilp32 -nostdlib -ffreestanding -flto -static kernels/$1 crt0.s src/*.c -Ihdr -T link.ld -O3 -mbranch-cost=5 && \
riscv64-linux-gnu-objcopy -O binary a.out kernel.bin && \
python3 ../bin_to_coe.py kernel.bin ../irom.coe && \
hexdump -v -e '1/4 "%08x " "\n"' kernel.bin > ../irom.mem