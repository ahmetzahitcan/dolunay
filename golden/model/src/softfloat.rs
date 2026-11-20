//! Berkeley SoftFloat, through `c/softfloat_shim.c`: binary32 values as their
//! bit patterns, and the thread-local rounding mode and exception flags.
//!
//! Only `float.rs` calls this module. The constants are copies of
//! `softfloat.h`'s; a test below checks each against the header's value.

// softfloat.h, "Software floating-point rounding mode".
pub const ROUND_NEAR_EVEN: u8 = 0;
pub const ROUND_MIN_MAG: u8 = 1;
pub const ROUND_MIN: u8 = 2;
pub const ROUND_MAX: u8 = 3;
pub const ROUND_NEAR_MAX_MAG: u8 = 4;

// softfloat.h, "Software floating-point exception flags". They are the
// RISC-V `fflags` bits (RISC-V unprivileged ISA, "F", "Floating-Point Control
// and Status Register"): NX, UF, OF, DZ, NV.
pub const FLAG_INEXACT: u8 = 0x01;
pub const FLAG_UNDERFLOW: u8 = 0x02;
pub const FLAG_OVERFLOW: u8 = 0x04;
pub const FLAG_INFINITE: u8 = 0x08;
pub const FLAG_INVALID: u8 = 0x10;

// Every function below is a plain computation or an access to the calling
// host thread's own SoftFloat state, so none has a safety precondition.
unsafe extern "C" {
    #[link_name = "dolunay_sf_set_rounding_mode"]
    pub safe fn set_rounding_mode(mode: u8);
    #[link_name = "dolunay_sf_clear_flags"]
    pub safe fn clear_flags();
    #[link_name = "dolunay_sf_flags"]
    pub safe fn flags() -> u8;

    #[link_name = "dolunay_f32_add"]
    pub safe fn f32_add(a: u32, b: u32) -> u32;
    #[link_name = "dolunay_f32_sub"]
    pub safe fn f32_sub(a: u32, b: u32) -> u32;
    #[link_name = "dolunay_f32_mul"]
    pub safe fn f32_mul(a: u32, b: u32) -> u32;
    #[link_name = "dolunay_f32_div"]
    pub safe fn f32_div(a: u32, b: u32) -> u32;
    #[link_name = "dolunay_f32_sqrt"]
    pub safe fn f32_sqrt(a: u32) -> u32;
    #[link_name = "dolunay_f32_mulAdd"]
    pub safe fn f32_mul_add(a: u32, b: u32, c: u32) -> u32;

    #[link_name = "dolunay_f32_eq"]
    pub safe fn f32_eq(a: u32, b: u32) -> bool;
    #[link_name = "dolunay_f32_lt"]
    pub safe fn f32_lt(a: u32, b: u32) -> bool;
    #[link_name = "dolunay_f32_le"]
    pub safe fn f32_le(a: u32, b: u32) -> bool;
    #[link_name = "dolunay_f32_lt_quiet"]
    pub safe fn f32_lt_quiet(a: u32, b: u32) -> bool;

    #[link_name = "dolunay_f32_to_i32"]
    pub safe fn f32_to_i32(a: u32, mode: u8, exact: bool) -> i32;
    #[link_name = "dolunay_f32_to_ui32"]
    pub safe fn f32_to_ui32(a: u32, mode: u8, exact: bool) -> u32;
    #[link_name = "dolunay_i32_to_f32"]
    pub safe fn i32_to_f32(a: i32) -> u32;
    #[link_name = "dolunay_ui32_to_f32"]
    pub safe fn ui32_to_f32(a: u32) -> u32;
}

#[cfg(test)]
mod tests {
    use super::*;

    unsafe extern "C" {
        safe static dolunay_sf_round_near_even: u8;
        safe static dolunay_sf_round_minMag: u8;
        safe static dolunay_sf_round_min: u8;
        safe static dolunay_sf_round_max: u8;
        safe static dolunay_sf_round_near_maxMag: u8;
        safe static dolunay_sf_flag_inexact: u8;
        safe static dolunay_sf_flag_underflow: u8;
        safe static dolunay_sf_flag_overflow: u8;
        safe static dolunay_sf_flag_infinite: u8;
        safe static dolunay_sf_flag_invalid: u8;
    }

    #[test]
    fn constants_match_softfloat_h() {
        assert_eq!(ROUND_NEAR_EVEN, dolunay_sf_round_near_even);
        assert_eq!(ROUND_MIN_MAG, dolunay_sf_round_minMag);
        assert_eq!(ROUND_MIN, dolunay_sf_round_min);
        assert_eq!(ROUND_MAX, dolunay_sf_round_max);
        assert_eq!(ROUND_NEAR_MAX_MAG, dolunay_sf_round_near_maxMag);
        assert_eq!(FLAG_INEXACT, dolunay_sf_flag_inexact);
        assert_eq!(FLAG_UNDERFLOW, dolunay_sf_flag_underflow);
        assert_eq!(FLAG_OVERFLOW, dolunay_sf_flag_overflow);
        assert_eq!(FLAG_INFINITE, dolunay_sf_flag_infinite);
        assert_eq!(FLAG_INVALID, dolunay_sf_flag_invalid);
    }

    // The tests below check that SoftFloat is linked and built with the
    // RISC-V specialization; they say nothing about the model.

    #[test]
    fn one_plus_two_is_three_exactly() {
        clear_flags();
        assert_eq!(f32_add(0x3F80_0000, 0x4000_0000), 0x4040_0000);
        assert_eq!(flags(), 0);
    }

    #[test]
    fn zero_div_zero_is_the_canonical_nan_and_raises_invalid() {
        // RISC-V unprivileged ISA, "F" Standard Extension, "NaN Generation and
        // Propagation": the canonical NaN is 0x7fc00000.
        clear_flags();
        assert_eq!(f32_div(0, 0), 0x7FC0_0000);
        assert_eq!(flags(), FLAG_INVALID);
    }

    /// The state is `_Thread_local` (build.rs), so `cargo test`'s host threads
    /// cannot see each other's flags or rounding mode. Each host thread runs
    /// an operation whose flags it knows and checks it reads back exactly those.
    #[test]
    fn state_is_per_host_thread() {
        let handles: Vec<_> = (0..8u8)
            .map(|t| {
                std::thread::spawn(move || {
                    let mut wrong = 0u32;
                    for _ in 0..100_000 {
                        set_rounding_mode(t % 5);
                        clear_flags();
                        let expected = if t % 2 == 0 {
                            f32_div(0x3F80_0000, 0); // 1/0
                            FLAG_INFINITE
                        } else {
                            f32_add(0x3F80_0000, 0x3F80_0000); // exact
                            0
                        };
                        if flags() != expected {
                            wrong += 1;
                        }
                    }
                    wrong
                })
            })
            .collect();
        let wrong: u32 = handles.into_iter().map(|h| h.join().unwrap()).sum();
        assert_eq!(wrong, 0, "{wrong} operations saw another host thread's flags");
    }
}
