#pragma once

#include <stdint.h>

static inline uint64_t hpm_cycle(void) {
    uint32_t h, l;
    asm volatile(
        "csrr %0, cycleh\n"
        "csrr %1, cycle"
        : "=r" (h), "=r" (l));
    return ((uint64_t)h << 32) | l;
}

static inline uint64_t hpm_instret(void) {
    uint32_t h, l;
    asm volatile(
        "csrr %0, instreth\n"
        "csrr %1, instret"
        : "=r" (h), "=r" (l));
    return ((uint64_t)h << 32) | l;
}

static inline uint64_t hpm_wuinstret(void) {
    uint32_t h, l;
    asm volatile(
        "csrr %0, hpmcounter3h\n"
        "csrr %1, hpmcounter3"
        : "=r" (h), "=r" (l));
    return ((uint64_t)h << 32) | l;
}

static inline uint64_t hpm_wtinstret(void) {
    uint32_t h, l;
    asm volatile(
        "csrr %0, hpmcounter4h\n"
        "csrr %1, hpmcounter4"
        : "=r" (h), "=r" (l));
    return ((uint64_t)h << 32) | l;
}