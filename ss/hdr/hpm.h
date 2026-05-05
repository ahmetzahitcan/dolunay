#pragma once

#include <stdint.h>

uint64_t hpm_cycle(void);
uint64_t hpm_instret(void);
uint64_t hpm_wuinstret(void);
uint64_t hpm_wtinstret(void);