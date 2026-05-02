#pragma once
#include <stdint.h>

// 0 = Unlocked, 1 = Locked
typedef uint32_t mutex_t;

void mutex_lock(mutex_t *lock);
void mutex_unlock(mutex_t *lock);