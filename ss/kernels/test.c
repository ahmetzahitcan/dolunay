#include "simt.h"
#include "hpm.h"
#include "tls_heap.h"

#define TLS_ARRAY_SIZE 32

simt_barr_t barriers[WARP_COUNT];

int main(void) {
    simt_barr_t *barr = &barriers[simt_warp_id()];
    simt_binit(barr);
    volatile uint64_t *tls_arr = (volatile uint64_t*)0x80000020;
    for(int i = 0; i < TLS_ARRAY_SIZE; i++) {
        tls_arr[i] = 0xdeadbeef0badbabe;
    }
    simt_bsync(barr);
}