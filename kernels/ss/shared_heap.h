#pragma once

#include "simt.h"
#include "stdint.h"
#include "stddef.h"
#include "mutex.h"

// TODO: Separate implementation and declaration.

// FIXME: Get these from the linker script.
#define SHARED_HEAP_BASE (0x40000000)
#define SHARED_HEAP_SIZE (64 * 1024)

static char *shared_heap_ptr = (char *)SHARED_HEAP_BASE;
static size_t shared_heap_size = SHARED_HEAP_SIZE;

static mutex_t shared_heap_lock = 0;
static simt_barr_t barr[WARP_COUNT];
static void *return_value[WARP_COUNT];

static void *shared_heap_alloc(size_t size) {
    simt_binit(&barr[simt_warp_id()]);
    
    if(simt_thread_is_leader()) {
        if(size > shared_heap_size) {
            return_value[simt_warp_id()] = NULL;
        } else {
            mutex_lock(&shared_heap_lock);
            return_value[simt_warp_id()] = (void *)shared_heap_ptr;
            shared_heap_ptr += size;
            shared_heap_size -= size;
            mutex_unlock(&shared_heap_lock);
        }
    }
    simt_bsync(&barr[simt_warp_id()]);
    return return_value[simt_warp_id()];
}

static void shared_heap_free(void *ptr) {
    // TODO: Create a way to free memory.
    (void)ptr;
}