//! Single-precision floating point as the RISC-V "F" extension defines it, on
//! IEEE 754 binary32 bit patterns: SoftFloat for arithmetic and conversions,
//! and the rest of the extension's rules around it.
//!
//! Every function is pure: its result depends only on its arguments, and it
//! returns the exception flags it raised instead of accruing them anywhere.
//! SoftFloat keeps its rounding mode and flags in thread-local globals; the
//! functions here set both before each SoftFloat call and read the flags back,
//! so nothing carries over from one call to the next.

const std = @import("std");
const softfloat = @import("softfloat");

pub const Error = error{
    /// rm = 101 or 110 (RISC-V unprivileged ISA, "F", "Floating-Point
    /// Control and Status Register").
    ReservedRoundingMode,
};

/// A result and the exception flags (`fflags` bits) the operation raised.
/// `value` is a binary32 bit pattern, or an integer for conversions to
/// integer and for comparisons.
pub const Result = struct {
    value: u32,
    flags: u8 = 0,
};

pub const sign_bit: u32 = 0x8000_0000;
/// RISC-V unprivileged ISA, "F", "NaN Generation and Propagation".
pub const canonical_nan: u32 = 0x7FC0_0000;

const invalid: u8 = softfloat.softfloat_flag_invalid;

pub fn isNaN(a: u32) bool {
    return a & ~sign_bit > 0x7F80_0000;
}

pub fn isSignalingNaN(a: u32) bool {
    return isNaN(a) and a & 0x0040_0000 == 0;
}

/// The SoftFloat rounding mode for an instruction's `rm` field (RISC-V "F",
/// "Floating-Point Control and Status Register"). There is no `frm`: rm = 111
/// selects RNE (CONTRACT.md §2).
fn roundingMode(rm: u3) Error!u8 {
    return switch (rm) {
        0b000, 0b111 => softfloat.softfloat_round_near_even,
        0b001 => softfloat.softfloat_round_minMag,
        0b010 => softfloat.softfloat_round_min,
        0b011 => softfloat.softfloat_round_max,
        0b100 => softfloat.softfloat_round_near_maxMag,
        0b101, 0b110 => error.ReservedRoundingMode,
    };
}

fn binary32(bits: u32) softfloat.float32_t {
    return .{ .v = bits };
}

/// Calls a SoftFloat function under rounding mode `rm`, with its flags
/// cleared first, and returns its result with the flags it raised.
fn call(rm: u3, comptime func: anytype, args: anytype) Error!struct { @typeInfo(@TypeOf(func)).@"fn".return_type.?, u8 } {
    softfloat.softfloat_roundingMode = try roundingMode(rm);
    softfloat.softfloat_exceptionFlags = 0;
    const r = @call(.auto, func, args);
    return .{ r, softfloat.softfloat_exceptionFlags };
}

fn callFloat(rm: u3, comptime func: anytype, args: anytype) Error!Result {
    const r, const flags = try call(rm, func, args);
    return .{ .value = r.v, .flags = flags };
}

pub fn add(a: u32, b: u32, rm: u3) Error!Result {
    return callFloat(rm, softfloat.f32_add, .{ binary32(a), binary32(b) });
}

pub fn sub(a: u32, b: u32, rm: u3) Error!Result {
    return callFloat(rm, softfloat.f32_sub, .{ binary32(a), binary32(b) });
}

pub fn mul(a: u32, b: u32, rm: u3) Error!Result {
    return callFloat(rm, softfloat.f32_mul, .{ binary32(a), binary32(b) });
}

pub fn div(a: u32, b: u32, rm: u3) Error!Result {
    return callFloat(rm, softfloat.f32_div, .{ binary32(a), binary32(b) });
}

pub fn sqrt(a: u32, rm: u3) Error!Result {
    return callFloat(rm, softfloat.f32_sqrt, .{binary32(a)});
}

// The fused forms negate operands by their sign bit, so a NaN operand keeps
// its payload. FMADD: a*b + c; FMSUB: a*b - c; FNMSUB: -(a*b) + c;
// FNMADD: -(a*b) - c.

pub fn mulAdd(a: u32, b: u32, c: u32, rm: u3) Error!Result {
    return callFloat(rm, softfloat.f32_mulAdd, .{ binary32(a), binary32(b), binary32(c) });
}

pub fn mulSub(a: u32, b: u32, c: u32, rm: u3) Error!Result {
    return mulAdd(a, b, c ^ sign_bit, rm);
}

pub fn negMulSub(a: u32, b: u32, c: u32, rm: u3) Error!Result {
    return mulAdd(a ^ sign_bit, b, c, rm);
}

pub fn negMulAdd(a: u32, b: u32, c: u32, rm: u3) Error!Result {
    return mulAdd(a ^ sign_bit, b, c ^ sign_bit, rm);
}

/// FMIN.S/FMAX.S: a NaN operand gives the other operand, two NaNs give the
/// canonical NaN, -0.0 is less than +0.0, and only a signaling NaN raises
/// invalid (RISC-V unprivileged ISA, "F", "Single-Precision Floating-Point
/// Computational Instructions").
fn minMax(a: u32, b: u32, comptime want_max: bool) Result {
    const flags: u8 = if (isSignalingNaN(a) or isSignalingNaN(b)) invalid else 0;
    const value = if (isNaN(a) and isNaN(b))
        canonical_nan
    else if (isNaN(a))
        b
    else if (isNaN(b))
        a
    else if ((a | b) & ~sign_bit == 0) // two zeros
        (if (want_max) a & b else a | b)
    else if (softfloat.f32_lt_quiet(binary32(a), binary32(b)) == want_max)
        b
    else
        a;
    return .{ .value = value, .flags = flags };
}

pub fn min(a: u32, b: u32) Result {
    return minMax(a, b, false);
}

pub fn max(a: u32, b: u32) Result {
    return minMax(a, b, true);
}

// Sign injection: a's magnitude with a sign taken from b. Raises nothing.

pub fn sgnj(a: u32, b: u32) u32 {
    return (a & ~sign_bit) | (b & sign_bit);
}

pub fn sgnjn(a: u32, b: u32) u32 {
    return (a & ~sign_bit) | (~b & sign_bit);
}

pub fn sgnjx(a: u32, b: u32) u32 {
    return a ^ (b & sign_bit);
}

// Comparisons give 1 or 0. FEQ is quiet; FLT and FLE signal on any NaN.
// SoftFloat's eq/lt/le have exactly those semantics. They do not round, so
// the rounding mode passed is irrelevant.

fn compare(comptime func: anytype, a: u32, b: u32) Result {
    const r, const flags = call(0b000, func, .{ binary32(a), binary32(b) }) catch unreachable;
    return .{ .value = @intFromBool(r), .flags = flags };
}

pub fn eq(a: u32, b: u32) Result {
    return compare(softfloat.f32_eq, a, b);
}

pub fn lt(a: u32, b: u32) Result {
    return compare(softfloat.f32_lt, a, b);
}

pub fn le(a: u32, b: u32) Result {
    return compare(softfloat.f32_le, a, b);
}

/// FCLASS.S: one bit set, by the RISC-V "F" extension's "Classify" table.
pub fn classify(a: u32) u32 {
    const negative = a & sign_bit != 0;
    const exponent = (a >> 23) & 0xFF;
    const fraction = a & 0x007F_FFFF;
    const bit: u5 = if (exponent == 0xFF)
        if (fraction == 0) (if (negative) 0 else 7) else if (isSignalingNaN(a)) 8 else 9
    else if (exponent == 0)
        if (fraction == 0) (if (negative) 3 else 4) else (if (negative) 2 else 5)
    else if (negative) 1 else 6;
    return @as(u32, 1) << bit;
}

// Conversions. To integer, out-of-range values and NaN saturate as RISC-V
// specifies; SoftFloat's RISCV specialization gives those values. `exact`
// makes SoftFloat raise inexact when the result was rounded.

pub fn toI32(a: u32, rm: u3) Error!Result {
    const r, const flags = try call(rm, softfloat.f32_to_i32, .{ binary32(a), try roundingMode(rm), true });
    const value: i32 = @intCast(r);
    return .{ .value = @bitCast(value), .flags = flags };
}

pub fn toU32(a: u32, rm: u3) Error!Result {
    const r, const flags = try call(rm, softfloat.f32_to_ui32, .{ binary32(a), try roundingMode(rm), true });
    return .{ .value = @intCast(r), .flags = flags };
}

pub fn fromI32(x: u32, rm: u3) Error!Result {
    return callFloat(rm, softfloat.i32_to_f32, .{@as(i32, @bitCast(x))});
}

pub fn fromU32(x: u32, rm: u3) Error!Result {
    return callFloat(rm, softfloat.ui32_to_f32, .{x});
}

test "float: flags do not carry over from one call to the next" {
    const one: u32 = 0x3F80_0000;
    const three: u32 = 0x4040_0000;
    const third = try div(one, three, 0b000);
    try std.testing.expectEqual(@as(u8, softfloat.softfloat_flag_inexact), third.flags);
    const four = try add(one, three, 0b000);
    try std.testing.expectEqual(Result{ .value = 0x4080_0000, .flags = 0 }, four);
}

test "float: comparisons ignore the caller's rounding mode" {
    // A reserved rm cannot reach compare: eq/lt/le take none.
    try std.testing.expectEqual(Result{ .value = 1 }, le(0x3F80_0000, 0x3F80_0000));
}
