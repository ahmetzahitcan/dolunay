#pragma once

#include <stdint.h>
#include <stdbool.h>

#define CSR_XWARPID 0xcc0
#define CSR_XTHRID 0xcc1
#define CSR_XROLE 0xcc2

#define WARP_COUNT 4
#define WARP_SIZE 8

typedef uint32_t simt_barr_t __attribute__((aligned(4)));
extern simt_barr_t leaf_barr[WARP_COUNT];

void simt_binit(simt_barr_t *barr);
void simt_bsync(simt_barr_t *barr);
void simt_yield(void);
uint32_t simt_warp_id(void);
uint32_t simt_thread_id(void);
bool simt_thread_is_follower(void);
bool simt_thread_is_leader(void);
