//! Single-precision floating point as the RISC-V "F" extension defines it, on
//! IEEE 754 binary32 bit patterns: SoftFloat for arithmetic and conversions,
//! and the rest of the extension's rules around it.
//!
//! Every function is pure: its result depends only on its arguments, and it
//! returns the exception flags it raised instead of accruing them anywhere.
//! SoftFloat keeps its rounding mode and flags in thread-local globals; the
//! functions here set both before each SoftFloat call and read the flags back,
//! so nothing carries over from one call to the next.

use crate::softfloat as sf;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Error {
    /// rm = 101 or 110 (RISC-V unprivileged ISA, "F", "Floating-Point
    /// Control and Status Register").
    ReservedRoundingMode,
}

/// A result and the exception flags (`fflags` bits) the operation raised.
/// `value` is a binary32 bit pattern, or an integer for conversions to
/// integer and for comparisons.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Output {
    pub value: u32,
    pub flags: u8,
}

pub const SIGN_BIT: u32 = 0x8000_0000;
/// RISC-V unprivileged ISA, "F", "NaN Generation and Propagation".
pub const CANONICAL_NAN: u32 = 0x7FC0_0000;

const INVALID: u8 = sf::FLAG_INVALID;

pub fn is_nan(a: u32) -> bool {
    a & !SIGN_BIT > 0x7F80_0000
}

pub fn is_signaling_nan(a: u32) -> bool {
    is_nan(a) && a & 0x0040_0000 == 0
}

/// The SoftFloat rounding mode for an instruction's `rm` field (RISC-V "F",
/// "Floating-Point Control and Status Register"). There is no `frm`: rm = 111
/// selects RNE (CONTRACT.md §2).
fn rounding_mode(rm: u8) -> Result<u8, Error> {
    match rm {
        0b000 | 0b111 => Ok(sf::ROUND_NEAR_EVEN),
        0b001 => Ok(sf::ROUND_MIN_MAG),
        0b010 => Ok(sf::ROUND_MIN),
        0b011 => Ok(sf::ROUND_MAX),
        0b100 => Ok(sf::ROUND_NEAR_MAX_MAG),
        0b101 | 0b110 => Err(Error::ReservedRoundingMode),
        _ => unreachable!("rm is a 3-bit field, got {rm:#b}"),
    }
}

/// Runs a SoftFloat operation under rounding mode `rm`, with its flags
/// cleared first, and returns its result with the flags it raised.
fn call<T>(rm: u8, op: impl FnOnce() -> T) -> Result<(T, u8), Error> {
    sf::set_rounding_mode(rounding_mode(rm)?);
    sf::clear_flags();
    let r = op();
    Ok((r, sf::flags()))
}

fn call_float(rm: u8, op: impl FnOnce() -> u32) -> Result<Output, Error> {
    let (value, flags) = call(rm, op)?;
    Ok(Output { value, flags })
}

pub fn add(a: u32, b: u32, rm: u8) -> Result<Output, Error> {
    call_float(rm, || sf::f32_add(a, b))
}

pub fn sub(a: u32, b: u32, rm: u8) -> Result<Output, Error> {
    call_float(rm, || sf::f32_sub(a, b))
}

pub fn mul(a: u32, b: u32, rm: u8) -> Result<Output, Error> {
    call_float(rm, || sf::f32_mul(a, b))
}

pub fn div(a: u32, b: u32, rm: u8) -> Result<Output, Error> {
    call_float(rm, || sf::f32_div(a, b))
}

pub fn sqrt(a: u32, rm: u8) -> Result<Output, Error> {
    call_float(rm, || sf::f32_sqrt(a))
}

// The fused forms negate operands by their sign bit, so a NaN operand keeps
// its payload. FMADD: a*b + c; FMSUB: a*b - c; FNMSUB: -(a*b) + c;
// FNMADD: -(a*b) - c.

pub fn mul_add(a: u32, b: u32, c: u32, rm: u8) -> Result<Output, Error> {
    call_float(rm, || sf::f32_mul_add(a, b, c))
}

pub fn mul_sub(a: u32, b: u32, c: u32, rm: u8) -> Result<Output, Error> {
    mul_add(a, b, c ^ SIGN_BIT, rm)
}

pub fn neg_mul_sub(a: u32, b: u32, c: u32, rm: u8) -> Result<Output, Error> {
    mul_add(a ^ SIGN_BIT, b, c, rm)
}

pub fn neg_mul_add(a: u32, b: u32, c: u32, rm: u8) -> Result<Output, Error> {
    mul_add(a ^ SIGN_BIT, b, c ^ SIGN_BIT, rm)
}

/// FMIN.S/FMAX.S: a NaN operand gives the other operand, two NaNs give the
/// canonical NaN, -0.0 is less than +0.0, and only a signaling NaN raises
/// invalid (RISC-V unprivileged ISA, "F", "Single-Precision Floating-Point
/// Computational Instructions").
fn min_max(a: u32, b: u32, want_max: bool) -> Output {
    let flags = if is_signaling_nan(a) || is_signaling_nan(b) { INVALID } else { 0 };
    let value = if is_nan(a) && is_nan(b) {
        CANONICAL_NAN
    } else if is_nan(a) {
        b
    } else if is_nan(b) {
        a
    } else if (a | b) & !SIGN_BIT == 0 {
        // two zeros
        if want_max { a & b } else { a | b }
    } else if sf::f32_lt_quiet(a, b) == want_max {
        b
    } else {
        a
    };
    Output { value, flags }
}

pub fn min(a: u32, b: u32) -> Output {
    min_max(a, b, false)
}

pub fn max(a: u32, b: u32) -> Output {
    min_max(a, b, true)
}

// Sign injection: a's magnitude with a sign taken from b. Raises nothing.

pub fn sgnj(a: u32, b: u32) -> u32 {
    (a & !SIGN_BIT) | (b & SIGN_BIT)
}

pub fn sgnjn(a: u32, b: u32) -> u32 {
    (a & !SIGN_BIT) | (!b & SIGN_BIT)
}

pub fn sgnjx(a: u32, b: u32) -> u32 {
    a ^ (b & SIGN_BIT)
}

// Comparisons give 1 or 0. FEQ is quiet; FLT and FLE signal on any NaN.
// SoftFloat's eq/lt/le have exactly those semantics. They do not round, so
// the rounding mode passed is irrelevant.

fn compare(op: extern "C" fn(u32, u32) -> bool, a: u32, b: u32) -> Output {
    let (r, flags) = call(0b000, || op(a, b)).expect("rm = 000 is not reserved");
    Output { value: r as u32, flags }
}

pub fn eq(a: u32, b: u32) -> Output {
    compare(sf::f32_eq, a, b)
}

pub fn lt(a: u32, b: u32) -> Output {
    compare(sf::f32_lt, a, b)
}

pub fn le(a: u32, b: u32) -> Output {
    compare(sf::f32_le, a, b)
}

/// FCLASS.S: one bit set, by the RISC-V "F" extension's "Classify" table.
pub fn classify(a: u32) -> u32 {
    let negative = a & SIGN_BIT != 0;
    let exponent = (a >> 23) & 0xFF;
    let fraction = a & 0x007F_FFFF;
    let bit = if exponent == 0xFF {
        if fraction == 0 {
            if negative { 0 } else { 7 }
        } else if is_signaling_nan(a) {
            8
        } else {
            9
        }
    } else if exponent == 0 {
        if fraction == 0 {
            if negative { 3 } else { 4 }
        } else if negative {
            2
        } else {
            5
        }
    } else if negative {
        1
    } else {
        6
    };
    1 << bit
}

// Conversions. To integer, out-of-range values and NaN saturate as RISC-V
// specifies; SoftFloat's RISCV specialization gives those values. `exact`
// makes SoftFloat raise inexact when the result was rounded.

pub fn to_i32(a: u32, rm: u8) -> Result<Output, Error> {
    let mode = rounding_mode(rm)?;
    let (r, flags) = call(rm, || sf::f32_to_i32(a, mode, true))?;
    Ok(Output { value: r as u32, flags })
}

pub fn to_u32(a: u32, rm: u8) -> Result<Output, Error> {
    let mode = rounding_mode(rm)?;
    call_float(rm, || sf::f32_to_ui32(a, mode, true))
}

pub fn from_i32(x: u32, rm: u8) -> Result<Output, Error> {
    call_float(rm, || sf::i32_to_f32(x as i32))
}

pub fn from_u32(x: u32, rm: u8) -> Result<Output, Error> {
    call_float(rm, || sf::ui32_to_f32(x))
}

#[cfg(test)]
mod tests {
    use super::*;

    // Values below are binary32 bit patterns.
    const ONE: u32 = 0x3F80_0000;
    const TWO: u32 = 0x4000_0000;
    const THREE: u32 = 0x4040_0000;
    const PLUS_ZERO: u32 = 0x0000_0000;
    const MINUS_ZERO: u32 = 0x8000_0000;
    const QUIET_NAN: u32 = 0x7FC0_0001;
    const SIGNALING_NAN: u32 = 0x7F80_0001;
    const INEXACT: u8 = sf::FLAG_INEXACT;

    fn out(value: u32, flags: u8) -> Output {
        Output { value, flags }
    }

    impl Output {
        fn exact(value: u32) -> Output {
            Output { value, flags: 0 }
        }
    }

    #[test]
    fn flags_do_not_carry_over_from_one_call_to_the_next() {
        assert_eq!(div(ONE, THREE, 0b000).unwrap().flags, INEXACT);
        assert_eq!(add(ONE, THREE, 0b000), Ok(Output::exact(0x4080_0000)));
    }

    #[test]
    fn zero_div_zero_gives_the_canonical_nan_and_raises_invalid() {
        assert_eq!(div(PLUS_ZERO, PLUS_ZERO, 0b000), Ok(out(CANONICAL_NAN, INVALID)));
    }

    #[test]
    fn rm_selects_the_rounding_mode_and_101_110_are_reserved() {
        const ONE_AND_HALF: u32 = 0x3FC0_0000;
        assert_eq!(to_i32(ONE_AND_HALF, 0b000).unwrap().value, 2); // RNE
        assert_eq!(to_i32(ONE_AND_HALF, 0b001).unwrap().value, 1); // RTZ
        assert_eq!(to_i32(ONE_AND_HALF, 0b010).unwrap().value, 1); // RDN
        assert_eq!(to_i32(ONE_AND_HALF, 0b011).unwrap().value, 2); // RUP
        assert_eq!(to_i32(ONE_AND_HALF, 0b111).unwrap().value, 2); // no frm: RNE
        assert_eq!(to_i32(ONE_AND_HALF, 0b000).unwrap().flags, INEXACT);
        assert_eq!(add(ONE, ONE, 0b101), Err(Error::ReservedRoundingMode));
        assert_eq!(to_i32(ONE, 0b110), Err(Error::ReservedRoundingMode));
    }

    #[test]
    fn conversions_to_integer_saturate_and_nan_gives_the_maximum() {
        const MINUS_2_32: u32 = 0xCF80_0000;
        assert_eq!(to_i32(MINUS_2_32, 0b000), Ok(out(0x8000_0000, INVALID)));
        assert_eq!(to_u32(MINUS_2_32, 0b000), Ok(out(0, INVALID)));
        assert_eq!(to_i32(QUIET_NAN, 0b000), Ok(out(0x7FFF_FFFF, INVALID)));
        assert_eq!(to_u32(QUIET_NAN, 0b000), Ok(out(0xFFFF_FFFF, INVALID)));
    }

    #[test]
    fn conversions_from_integer() {
        assert_eq!(from_i32(0xFFFF_FFFD, 0b000), Ok(Output::exact(THREE | SIGN_BIT))); // -3
        assert_eq!(from_u32(0xFFFF_FFFD, 0b000), Ok(out(0x4F80_0000, INEXACT))); // 2^32
    }

    #[test]
    fn fused_multiply_add_and_its_negated_forms() {
        assert_eq!(mul_add(TWO, THREE, ONE, 0b000).unwrap().value, 0x40E0_0000); // 7
        assert_eq!(mul_sub(TWO, THREE, ONE, 0b000).unwrap().value, 0x40A0_0000); // 5
        assert_eq!(neg_mul_sub(TWO, THREE, ONE, 0b000).unwrap().value, 0xC0A0_0000); // -5
        assert_eq!(neg_mul_add(TWO, THREE, ONE, 0b000).unwrap().value, 0xC0E0_0000); // -7
    }

    #[test]
    fn min_max_order_the_zeros_skip_one_nan_and_signal_only_on_snan() {
        assert_eq!(min(PLUS_ZERO, MINUS_ZERO), Output::exact(MINUS_ZERO));
        assert_eq!(max(MINUS_ZERO, PLUS_ZERO), Output::exact(PLUS_ZERO));
        assert_eq!(min(QUIET_NAN, MINUS_ZERO), Output::exact(MINUS_ZERO));
        assert_eq!(max(QUIET_NAN, SIGNALING_NAN), out(CANONICAL_NAN, INVALID));
    }

    #[test]
    fn sign_injection() {
        assert_eq!(sgnj(THREE, MINUS_ZERO), THREE | SIGN_BIT);
        assert_eq!(sgnjn(THREE, MINUS_ZERO), THREE);
        assert_eq!(sgnjx(THREE | SIGN_BIT, MINUS_ZERO), THREE);
    }

    #[test]
    fn feq_is_quiet_and_flt_fle_signal_on_a_quiet_nan() {
        assert_eq!(eq(ONE, ONE), Output::exact(1));
        assert_eq!(eq(ONE, QUIET_NAN), Output::exact(0));
        assert_eq!(lt(ONE, QUIET_NAN), out(0, INVALID));
        assert_eq!(le(ONE, ONE), Output::exact(1));
    }

    #[test]
    fn classify_sets_one_bit_per_class() {
        let cases = [
            (0xFF80_0000, 0), // -inf
            (0xBF80_0000, 1), // -1.0
            (0x8000_0001, 2), // negative subnormal
            (MINUS_ZERO, 3),
            (PLUS_ZERO, 4),
            (0x0000_0001, 5), // positive subnormal
            (ONE, 6),
            (0x7F80_0000, 7), // +inf
            (SIGNALING_NAN, 8),
            (QUIET_NAN, 9),
        ];
        for (bits, class) in cases {
            assert_eq!(classify(bits), 1 << class, "classify({bits:#010x})");
        }
    }
}
