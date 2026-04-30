#pragma once

#include <stdint.h>

#define CSR_XWARPID 0xcc0
#define CSR_XTHRID 0xcc1
#define CSR_XROLE 0xcc2

#define WARP_COUNT 4
#define WARP_SIZE 8

typedef uint32_t simt_barr_t __attribute__((aligned(4)));

static inline void simt_binit(simt_barr_t *barr) {
    asm volatile (".insn i 0x0b, 0x1, x0, %1, 0"
        : "=m" (*barr)
        : "r" (barr));
}

static inline void simt_bsync(simt_barr_t *barr) {
    asm volatile (".insn i 0x0b, 0x2, x0, %1, 0"
        : "+m" (*barr)
        : "r" (barr)
        : "memory");
}

static inline void simt_yield(void) {
    asm volatile (".insn i 0x0b, 0x4, x0, x0, 0" 
        : : : "memory");
}

static inline uint32_t simt_warp_id(void) {
    uint32_t x;
    asm ("csrr %0, %1"
        : "=r" (x)
        : "i" (CSR_XWARPID));
    return x;
}

static inline uint32_t simt_thread_id(void) {
    uint32_t x;
    asm ("csrr %0, %1"
        : "=r" (x)
        : "i" (CSR_XTHRID));
    return x;
}

static inline bool simt_thread_is_follower(void) {
    bool x;
    asm volatile ("csrr %0, %1"
        : "=r" (x)
        : "i" (CSR_XROLE));
    return x;
}

static inline bool simt_thread_is_leader(void) {
    return !simt_thread_is_leader();
}


