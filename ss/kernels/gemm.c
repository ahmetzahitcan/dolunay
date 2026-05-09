#include "simt.h"
#include "hpm.h"

#define M 16
#define N 16
#define K 16

__attribute__((section(".hostcom"))) volatile struct {
    uint32_t mat_a[M][N];
    uint32_t mat_b[N][K];
    uint32_t mat_x[M][K];
    uint32_t mat_c[M][K];
} hostcom;

__attribute__((section(".hpmdata"))) volatile struct {
    uint64_t wtinstret;
    uint64_t wuinstret;
} hpmdata;

simt_barr_t barriers[WARP_COUNT];

int main(void) {
    simt_barr_t *barr = &barriers[simt_warp_id()];
    simt_binit(barr);
    for(int i = simt_warp_id(); i < M; i += WARP_COUNT) {
        for(int j = simt_thread_id(); j < K; j += WARP_SIZE) {
            hostcom.mat_c[i][j] = hostcom.mat_x[i][j];
            for (int k = 0; k < N; k++) {
                hostcom.mat_c[i][j] += hostcom.mat_a[i][k] * hostcom.mat_b[k][j];
            }
        }
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