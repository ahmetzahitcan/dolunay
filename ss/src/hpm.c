#include "hpm.h"
#include "simt.h"

uint64_t hpm_cycle(void) {
    uint32_t h, l;
    asm volatile(
        "csrr %0, cycleh\n"
        "csrr %1, cycle"
        : "=r" (h), "=r" (l));
    return ((uint64_t)h << 32) | l;
}

uint64_t hpm_instret(void) {
    uint32_t h, l;
    asm volatile(
        "csrr %0, instreth\n"
        "csrr %1, instret"
        : "=r" (h), "=r" (l));
    return ((uint64_t)h << 32) | l;
}

uint64_t hpm_wuinstret(void) {
    uint32_t h, l;
    asm volatile(
        "csrr %0, hpmcounter3h\n"
        "csrr %1, hpmcounter3"
        : "=r" (h), "=r" (l));
    return ((uint64_t)h << 32) | l;
}

uint64_t hpm_wtinstret(void) {
    uint32_t h, l;
    asm volatile(
        "csrr %0, hpmcounter4h\n"
        "csrr %1, hpmcounter4"
        : "=r" (h), "=r" (l));
    return ((uint64_t)h << 32) | l;
}

typedef struct {
    uint64_t wtinstret;
    uint64_t wuinstret;
} hpm_t;

volatile hpm_t *hpm_base = (hpm_t*) (0x40001000 - (sizeof(hpm_t) * WARP_COUNT));

void log_hpms(void) {
    if(simt_thread_is_leader()) {
        hpm_base[simt_warp_id()].wtinstret = hpm_wtinstret();
        hpm_base[simt_warp_id()].wuinstret = hpm_wuinstret();
    }
}