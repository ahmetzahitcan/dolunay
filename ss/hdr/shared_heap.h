#pragma once

#include <stdint.h>
#include <stddef.h>

// FIXME: Get these from the linker script.
#define SHARED_HEAP_BASE (0x40000000)
#define SHARED_HEAP_SIZE (64 * 1024)

void *shared_heap_alloc(size_t size);
void shared_heap_free(void *ptr);