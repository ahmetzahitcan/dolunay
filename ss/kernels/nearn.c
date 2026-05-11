#include "simt.h"
#include "hpm.h"
#include "mutex.h"

#define ARRAY_SIZE 128
#define DIM_COUNT 4

int32_t *dataset = (int32_t*) 0x40000000;
int32_t *query = (int32_t*) (0x40000000 + (ARRAY_SIZE * DIM_COUNT * sizeof(int32_t)));
uint32_t *result_idx = (uint32_t*) (0x40000000 + (ARRAY_SIZE * DIM_COUNT * sizeof(int32_t) + DIM_COUNT * sizeof(int32_t)));
uint32_t *result_dist = (uint32_t*) (0x40000000 + (ARRAY_SIZE * DIM_COUNT * sizeof(int32_t) + DIM_COUNT * sizeof(int32_t) + sizeof(uint32_t)));

mutex_t mutex;
simt_barr_t barriers[WARP_COUNT];

int main(void) {
    simt_barr_t *barr = &barriers[simt_warp_id()];

    *result_dist = 0xFFFFFFFF;
    
    int32_t q[DIM_COUNT];
    for(int i = 0; i < DIM_COUNT; i++) {
        q[i] = query[i];
    } 

    uint32_t best_dist = 0xFFFFFFFF;
    uint32_t best_query_idx;
    
    for(int i = simt_global_id(); i < ARRAY_SIZE; i += GLOBAL_SIZE) {
        uint32_t dist = 0;
        for(int j = 0; j < DIM_COUNT; j++) {
            int32_t diff = dataset[i*DIM_COUNT + j] - q[j];
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
    if (best_dist < *result_dist) {
        *result_dist = best_dist;
        *result_idx = best_query_idx;
    } else if (best_dist == *result_dist) {
        if (best_query_idx < *result_idx) {
            *result_idx = best_query_idx;
        }
    }
    mutex_unlock(&mutex);
}