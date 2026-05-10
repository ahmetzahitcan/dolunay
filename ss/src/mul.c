#include <stdint.h>
#include "simt.h"

simt_barr_t barr1[WARP_COUNT];
simt_barr_t barr2[WARP_COUNT];

__attribute__((used)) int32_t __mulsi3(int32_t a, int32_t b) {
    int32_t res = 0;

    uint32_t u_a = (uint32_t)a;
    uint32_t u_b = (uint32_t)b;

    simt_binit(&barr1[simt_warp_id()]);

    while (u_b > 0) {
        res += (u_b & 1) ? u_a : 0;
        res += (u_b & 2) ? u_a << 1 : 0;
        res += (u_b & 4) ? u_a << 2 : 0;
        res += (u_b & 8) ? u_a << 3 : 0;

        u_a <<= 4;
        u_b >>= 4;
    }

    simt_bsync(&barr1[simt_warp_id()]);
    
    return res;
}