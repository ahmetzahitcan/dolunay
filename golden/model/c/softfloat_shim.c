/* The model's interface to Berkeley SoftFloat (src/softfloat.rs).

   Two things Rust cannot do directly. It cannot name SoftFloat's
   _Thread_local rounding mode and flags, so they are reached through
   functions here. And SoftFloat's int_fast32_t and uint_fast32_t are 64 bits
   wide on Linux but 32 on Windows, so every function here takes and returns
   fixed-width integers: binary32 values as their bit patterns. */

#include <stdbool.h>
#include <stdint.h>
#include "platform.h"
#include "softfloat.h"

static float32_t f(uint32_t bits) {
    float32_t r;
    r.v = bits;
    return r;
}

void dolunay_sf_set_rounding_mode(uint8_t mode) { softfloat_roundingMode = mode; }
void dolunay_sf_clear_flags(void) { softfloat_exceptionFlags = 0; }
uint8_t dolunay_sf_flags(void) { return softfloat_exceptionFlags; }

uint32_t dolunay_f32_add(uint32_t a, uint32_t b) { return f32_add(f(a), f(b)).v; }
uint32_t dolunay_f32_sub(uint32_t a, uint32_t b) { return f32_sub(f(a), f(b)).v; }
uint32_t dolunay_f32_mul(uint32_t a, uint32_t b) { return f32_mul(f(a), f(b)).v; }
uint32_t dolunay_f32_div(uint32_t a, uint32_t b) { return f32_div(f(a), f(b)).v; }
uint32_t dolunay_f32_sqrt(uint32_t a) { return f32_sqrt(f(a)).v; }
uint32_t dolunay_f32_mulAdd(uint32_t a, uint32_t b, uint32_t c) { return f32_mulAdd(f(a), f(b), f(c)).v; }

bool dolunay_f32_eq(uint32_t a, uint32_t b) { return f32_eq(f(a), f(b)); }
bool dolunay_f32_lt(uint32_t a, uint32_t b) { return f32_lt(f(a), f(b)); }
bool dolunay_f32_le(uint32_t a, uint32_t b) { return f32_le(f(a), f(b)); }
bool dolunay_f32_lt_quiet(uint32_t a, uint32_t b) { return f32_lt_quiet(f(a), f(b)); }

/* The RISCV specialization saturates out-of-range results to the 32-bit
   range, so the narrowing casts below are exact. */
int32_t dolunay_f32_to_i32(uint32_t a, uint8_t mode, bool exact) { return (int32_t) f32_to_i32(f(a), mode, exact); }
uint32_t dolunay_f32_to_ui32(uint32_t a, uint8_t mode, bool exact) { return (uint32_t) f32_to_ui32(f(a), mode, exact); }
uint32_t dolunay_i32_to_f32(int32_t a) { return i32_to_f32(a).v; }
uint32_t dolunay_ui32_to_f32(uint32_t a) { return ui32_to_f32(a).v; }

/* softfloat.h's constants, so src/softfloat.rs can check its copies. */
const uint8_t dolunay_sf_round_near_even = softfloat_round_near_even;
const uint8_t dolunay_sf_round_minMag = softfloat_round_minMag;
const uint8_t dolunay_sf_round_min = softfloat_round_min;
const uint8_t dolunay_sf_round_max = softfloat_round_max;
const uint8_t dolunay_sf_round_near_maxMag = softfloat_round_near_maxMag;
const uint8_t dolunay_sf_flag_inexact = softfloat_flag_inexact;
const uint8_t dolunay_sf_flag_underflow = softfloat_flag_underflow;
const uint8_t dolunay_sf_flag_overflow = softfloat_flag_overflow;
const uint8_t dolunay_sf_flag_infinite = softfloat_flag_infinite;
const uint8_t dolunay_sf_flag_invalid = softfloat_flag_invalid;
