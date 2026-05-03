#pragma once

#include "simt.h"
#include "stdint.h"
#include "stddef.h"

// TODO: Separate implementation and declaration.

// FIXME: Get these from the linker script.
#define TLS_HEAP_BASE (0x80000000)
#define TLS_HEAP_SIZE (64 * 1024)

static __thread char *tls_heap_ptr = (char *)TLS_HEAP_BASE;
static __thread size_t tls_heap_size = TLS_HEAP_SIZE;

static void *tls_heap_alloc(size_t size) {
    void *ret;
    simt_binit(&leaf_barr[simt_warp_id()]);
    if(size > tls_heap_size) {
        ret = NULL;
    } else {
        ret = (void *)tls_heap_ptr;
        tls_heap_ptr += size;
        tls_heap_size -= size;
    }
    simt_bsync(&leaf_barr[simt_warp_id()]);
    return ret;
}

static void tls_heap_free(void *ptr) {
    // TODO: Create a way to free memory.
    (void)ptr;
}