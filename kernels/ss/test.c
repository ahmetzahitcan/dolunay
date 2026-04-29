#include "simt.h"
#include "hpm.h"

#define ARRAY_SIZE 4096

simt_barr_t barr;

int main(void) {
    simt_binit(&barr);
    uint64_t *arr = (uint64_t*)0x40000000;
    for(int i = simt_thread_id() + simt_warp_id() * WARP_SIZE; i < ARRAY_SIZE; i += WARP_COUNT * WARP_SIZE) {
        arr[i] = hpm_cycle();
    }
    simt_bsync(&barr);
    return 0;
}