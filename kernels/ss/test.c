#include "simt.h"
#include "hpm.h"
#include "tls_heap.h"

#define ARRAY_SIZE 4096
#define TLS_ARRAY_SIZE 256

simt_barr_t barr;

int main(void) {
    simt_binit(&barr);
    uint64_t *arr = (uint64_t*)0x40000000;
    for(int i = simt_thread_id() + simt_warp_id() * WARP_SIZE; i < ARRAY_SIZE; i += WARP_COUNT * WARP_SIZE) {
        arr[i] = hpm_cycle();
    }
    simt_bsync(&barr);

    simt_binit(&barr);
    uint64_t *tls_arr = (uint64_t*)tls_heap_alloc(TLS_ARRAY_SIZE * sizeof(uint64_t));
    for(int i = 0; i < TLS_ARRAY_SIZE; i++) {
        tls_arr[i] = hpm_cycle();
    }
    simt_bsync(&barr);

    simt_binit(&barr);
    if(simt_thread_is_follower()) {
        *((uint64_t*)0x40004000) = hpm_wtinstret();
        *((uint64_t*)0x40004008) = hpm_wuinstret();
    }
    simt_bsync(&barr);
    return 0;
}