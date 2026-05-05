#include "simt.h"
#include "hpm.h"
#include "tls_heap.h"

#define TLS_ARRAY_SIZE 32

__attribute__((section(".hostcom"))) volatile struct {
    uint64_t wtinstret;
    uint64_t wuinstret;
} hostcom;

simt_barr_t barr;

int main(void) {
    simt_binit(&barr);
    volatile uint64_t *tls_arr = (volatile uint64_t*)0x80000020;
    for(int i = 0; i < TLS_ARRAY_SIZE; i++) {
        tls_arr[i] = 0xdeadbeef0badbabe;
    }
    simt_bsync(&barr);

    simt_binit(&barr);
    if(simt_thread_is_follower()) {
        hostcom.wtinstret = hpm_wtinstret();
        hostcom.wuinstret = hpm_wuinstret();
    }
    simt_bsync(&barr);
    return 0;
}