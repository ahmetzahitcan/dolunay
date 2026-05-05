#include "tls_heap.h"
#include "simt.h"
#include <stddef.h>

static __thread char *tls_heap_ptr = (char *)TLS_HEAP_BASE;
static __thread size_t tls_heap_size = TLS_HEAP_SIZE;

void *tls_heap_alloc(size_t size) {
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

void tls_heap_free(void *ptr) {
    // TODO: Create a way to free memory.
    (void)ptr;
}
