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

int main(void) {
    for(int i = simt_warp_id(); i < M; i += WARP_COUNT) {
        for(int j = simt_thread_id(); j < K; j += WARP_SIZE) {
            hostcom.mat_c[i][j] = hostcom.mat_x[i][j];
            for (int k = 0; k < N; k++) {
                hostcom.mat_c[i][j] += hostcom.mat_a[i][k] * hostcom.mat_b[k][j];
            }
        }
    }
}