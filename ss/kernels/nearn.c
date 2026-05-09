#include "simt.h"
#include "hpm.h"
#include "mutex.h"

#define ARRAY_SIZE 128
#define DIM_COUNT 4

__attribute__((section(".hostcom"))) volatile struct {
    uint32_t dataset[ARRAY_SIZE][DIM_COUNT];
    uint32_t query[DIM_COUNT];
    uint32_t result_idx;
    uint32_t result_dist;
} hostcom;

__attribute__((section(".hpmdata"))) volatile struct {
    uint64_t wtinstret;
    uint64_t wuinstret;
} hpmdata;

mutex_t mutex;
simt_barr_t barriers[WARP_COUNT];
simt_barr_t barriers2[WARP_COUNT];

int main(void) {
    simt_barr_t *barr = &barriers[simt_warp_id()];
    simt_barr_t *barr2 = &barriers2[simt_warp_id()];

    uint32_t query[DIM_COUNT];
    for(int i = 0; i < DIM_COUNT; i++) {
        query[i] = hostcom.query[i];
    } 

    simt_binit(barr);
    uint32_t best_dist = 0xFFFFFFFF;
    uint32_t best_query_idx;
    
    for(int i = simt_global_id(); i < ARRAY_SIZE; i += GLOBAL_SIZE) {
        uint32_t dist = 0;
        for(int j = 0; j < DIM_COUNT; j++) {
            uint32_t diff = hostcom.dataset[i][j] - query[j];
            dist += diff * diff;
        }
        simt_binit(barr2);
        if(dist < best_dist) {
            best_dist = dist;
            best_query_idx = i;
        }
        simt_bsync(barr2);
    }

    mutex_lock(&mutex);
    if(best_dist < hostcom.result_dist) {
        hostcom.result_dist = best_dist;
        hostcom.result_idx = best_query_idx;
    }
    mutex_unlock(&mutex);
    simt_bsync(barr);

    simt_binit(barr);
    if(simt_thread_is_follower()) {
        hpmdata.wtinstret = hpm_wtinstret();
        hpmdata.wuinstret = hpm_wuinstret();
    }
    simt_bsync(barr);
    return 0;
}