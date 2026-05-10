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

mutex_t mutex;
simt_barr_t barriers[WARP_COUNT];

int main(void) {
    simt_barr_t *barr = &barriers[simt_warp_id()];

    uint32_t query[DIM_COUNT];
    for(int i = 0; i < DIM_COUNT; i++) {
        query[i] = hostcom.query[i];
    } 

    uint32_t best_dist = 0xFFFFFFFF;
    uint32_t best_query_idx;
    
    for(int i = simt_global_id(); i < ARRAY_SIZE; i += GLOBAL_SIZE) {
        uint32_t dist = 0;
        for(int j = 0; j < DIM_COUNT; j++) {
            uint32_t diff = hostcom.dataset[i][j] - query[j];
            dist += diff * diff;
        }
        simt_binit(barr);
        if(dist < best_dist) {
            best_dist = dist;
            best_query_idx = i;
        }
        simt_bsync(barr);
    }

    mutex_lock(&mutex);
    if(best_dist < hostcom.result_dist) {
        hostcom.result_dist = best_dist;
        hostcom.result_idx = best_query_idx;
    }
    mutex_unlock(&mutex);
}