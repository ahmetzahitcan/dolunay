#include "simt.h"
#include "hpm.h"
#include "mutex.h"

#define N 16

int32_t *vec = (int32_t*) (0x40000000);

mutex_t mutex;

int32_t data;
int32_t data_idx;
int32_t read_cnt;

void producer(void) {
    for (int i = 0; i < N; i++) {
        mutex_lock(&mutex);
        data = vec[i];
        data_idx = i;
        read_cnt = 0;
        mutex_unlock(&mutex);

        while (read_cnt < GLOBAL_SIZE - 1) {
            simt_yield();
        }
    }
}

void consumer(void) {
    for (int i = 0; i < N; i++) {
        while (data_idx < i) {
            simt_yield();
        }

        if (data_idx > i) {
            vec[simt_thread_id() * N + i] = -1; // ERROR!!!
        } else {
            vec[simt_thread_id() * N + i] = data;
        }

        simt_binit(&leaf_barr[simt_warp_id()]);
        mutex_lock(&mutex);
        read_cnt++;
        mutex_unlock(&mutex);
        simt_bsync(&leaf_barr[simt_warp_id()]);
    }
}

int main(void) {
    data_idx = -1;
    
    if (simt_global_id() == 0) {
        producer();
    } else {
        consumer();
    }
}