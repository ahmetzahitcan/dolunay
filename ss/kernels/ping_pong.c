#include "simt.h"
#include "hpm.h"

uint32_t *accumulators = (uint32_t*) 0x40000000;

void ping(uint32_t *acc) {
    while (*acc < 128) {
        if (*acc % 2 == 0) {
            (*acc)++;
        } else {
            simt_yield();
        }
    }
}

void pong(uint32_t *acc) {
    while (*acc < 128) {
        if (*acc % 2 == 1) {
            (*acc)++;
        } else {
            simt_yield();
        }
    }
}

int main(void) {
    int acc_count_per_warp = (WARP_SIZE / 2);
    for (int i = 0; i < acc_count_per_warp; i++) {
        accumulators[simt_warp_id() * acc_count_per_warp + i] = 0;
    }

    int thrid = simt_thread_id();
    int accid = (thrid >> 1) + (simt_warp_id() * acc_count_per_warp);
    
    if (thrid % 2 == 0) {
        ping(accumulators + accid);
    } else {
        pong(accumulators + accid);
    }
}