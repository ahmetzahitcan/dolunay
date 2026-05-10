#include "simt.h"
#include <stdbool.h>

simt_barr_t leaf_barr[WARP_COUNT];

void simt_binit(simt_barr_t *barr) {
    asm volatile (".insn i 0x0b, 0x1, x0, %1, 0"
        : "=m" (*barr)
        : "r" (barr));
}

void simt_bsync(simt_barr_t *barr) {
    asm volatile (".insn i 0x0b, 0x2, x0, %1, 0"
        : "+m" (*barr)
        : "r" (barr)
        : "memory");
}

void simt_yield(void) {
    asm volatile (".insn i 0x0b, 0x4, x0, x0, 0" 
        : : : "memory");
}

uint32_t simt_warp_id(void) {
    uint32_t x;
    asm ("csrr %0, %1"
        : "=r" (x)
        : "i" (CSR_XWARPID));
    return x;
}

uint32_t simt_thread_id(void) {
    uint32_t x;
    asm ("csrr %0, %1"
        : "=r" (x)
        : "i" (CSR_XTHRID));
    return x;
}

uint32_t simt_global_id(void) {
    uint32_t x;
    asm ("csrr %0, mhartid"
        : "=r" (x));
    return x;
}

bool simt_thread_is_follower(void) {
    bool x;
    asm volatile ("csrr %0, %1"
        : "=r" (x)
        : "i" (CSR_XROLE));
    return x;
}

bool simt_thread_is_leader(void) {
    return !simt_thread_is_follower();
}
