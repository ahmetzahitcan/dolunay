#include "simt.h"
#include "hpm.h"

#define N 64

uint32_t *vec_out = (uint32_t*) (0x40000000);
uint32_t *vec_x = (uint32_t*) (0x40000000 + (N * sizeof(uint32_t)));
uint32_t *vec_y = (uint32_t*) (0x40000000 + (N * sizeof(uint32_t) * 2));
uint32_t *scalar_a = (uint32_t*) (0x40000000 + (N * sizeof(uint32_t) * 3));

int main(void) {
    for(int i = simt_global_id(); i < N; i += GLOBAL_SIZE) {
        vec_out[i] = (*scalar_a) * vec_x[i] + vec_y[i];
    }
}