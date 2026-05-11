#include "simt.h"
#include "hpm.h"

#define M 8
#define N 8
#define K 8

uint32_t *mat_a = (uint32_t*) 0x40000000;
uint32_t *mat_b = (uint32_t*) (0x40000000 + (M * N * sizeof(uint32_t)));
uint32_t *mat_x = (uint32_t*) (0x40000000 + (M * N * sizeof(uint32_t) + N * K * sizeof(uint32_t)));
uint32_t *mat_c = (uint32_t*) (0x40000000 + (M * N * sizeof(uint32_t) + N * K * sizeof(uint32_t) + M * K * sizeof(uint32_t)));

int main(void) {
    for(int i = simt_warp_id(); i < M; i += WARP_COUNT) {
        for(int j = simt_thread_id(); j < K; j += WARP_SIZE) {
            mat_c[i * K + j] = mat_x[i * K + j];
            for (int k = 0; k < N; k++) {
                mat_c[i * K + j] += mat_a[i * N + k] * mat_b[k * K + j];
            }
        }
    }
}