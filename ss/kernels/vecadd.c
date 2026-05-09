#include "simt.h"
#include "hpm.h"

#define N 64

__attribute__((section(".hostcom"))) volatile struct {
    uint32_t vec_out[N];
    uint32_t vec_x[N];
    uint32_t vec_y[N];
} hostcom;

__attribute__((section(".hpmdata"))) volatile struct {
    uint64_t wtinstret;
    uint64_t wuinstret;
} hpmdata;

simt_barr_t barriers[WARP_COUNT];

int main(void) {
    simt_barr_t *barr = &barriers[simt_warp_id()];
    simt_binit(barr);
    for(int i = simt_global_id(); i < N; i += GLOBAL_SIZE) {
        hostcom.vec_out[i] = hostcom.vec_x[i] + hostcom.vec_y[i];
    }
    simt_bsync(barr);

    simt_binit(barr);
    if(simt_thread_is_follower()) {
        hpmdata.wtinstret = hpm_wtinstret();
        hpmdata.wuinstret = hpm_wuinstret();
    }
    simt_bsync(barr);
    return 0;
}