#pragma once

#include <stdint.h>
#include <stddef.h>

// FIXME: Get these from the linker script.
#define TLS_HEAP_BASE (0x80000000)
#define TLS_HEAP_SIZE (64 * 1024)

void *tls_heap_alloc(size_t size);
void tls_heap_free(void *ptr);