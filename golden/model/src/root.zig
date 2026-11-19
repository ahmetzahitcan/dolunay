//! The Dolunay golden model (`golden/CONTRACT.md`). Each file holds the tests
//! of its own code; this one only checks how SoftFloat is built.

const std = @import("std");
const softfloat = @import("softfloat");

pub const control_unit = @import("control_unit.zig");
pub const float = @import("float.zig");
pub const int_utils = @import("int_utils.zig");
pub const Thread = @import("Thread.zig");

test {
    std.testing.refAllDecls(@This());
}

// The tests below check that SoftFloat is linked and built with the RISC-V
// specialization; they say nothing about the model.

fn bits(x: softfloat.float32_t) u32 {
    return x.v;
}

test "softfloat: 1.0 + 2.0 = 3.0, exact" {
    softfloat.softfloat_exceptionFlags = 0;
    const one: softfloat.float32_t = .{ .v = 0x3F80_0000 };
    const two: softfloat.float32_t = .{ .v = 0x4000_0000 };
    try std.testing.expectEqual(@as(u32, 0x4040_0000), bits(softfloat.f32_add(one, two)));
    try std.testing.expectEqual(@as(u8, 0), softfloat.softfloat_exceptionFlags);
}

test "softfloat: 0/0 gives RISC-V's canonical NaN and raises invalid" {
    // RISC-V unprivileged ISA, "F" Standard Extension, "NaN Generation and
    // Propagation": the canonical NaN is 0x7fc00000.
    softfloat.softfloat_exceptionFlags = 0;
    const zero: softfloat.float32_t = .{ .v = 0 };
    try std.testing.expectEqual(@as(u32, 0x7FC0_0000), bits(softfloat.f32_div(zero, zero)));
    try std.testing.expectEqual(
        @as(u8, softfloat.softfloat_flag_invalid),
        softfloat.softfloat_exceptionFlags,
    );
}
