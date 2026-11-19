fn shamt(amount: u32) u5 {
    return @truncate(amount);
}

pub fn shl(a: u32, amount: u32) u32 {
    return a << shamt(amount);
}

pub fn shr(a: u32, amount: u32) u32 {
    return a >> shamt(amount);
}

pub fn sra(a: u32, amount: u32) u32 {
    return @bitCast(@as(i32, @bitCast(a)) >> shamt(amount));
}

pub fn lessSigned(a: u32, b: u32) u32 {
    return @intFromBool(@as(i32, @bitCast(a)) < @as(i32, @bitCast(b)));
}

pub fn lessUnsigned(a: u32, b: u32) u32 {
    return @intFromBool(a < b);
}

const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "int_utils: shifts use the low 5 bits of the amount" {
    try expectEqual(@as(u32, 0x0000_0020), shl(0x8000_0010, 33));
    try expectEqual(@as(u32, 0x4000_0008), shr(0x8000_0010, 33));
    try expectEqual(@as(u32, 0xC000_0008), sra(0x8000_0010, 33));
    // srai's immediate as the decoder gives it: imm = 0x404 shifts by 4.
    try expectEqual(@as(u32, 0xF800_0001), sra(0x8000_0010, 0x404));
}

test "int_utils: lessSigned is signed, lessUnsigned unsigned" {
    try expectEqual(@as(u32, 1), lessSigned(0xFFFF_FFFF, 1));
    try expectEqual(@as(u32, 0), lessUnsigned(0xFFFF_FFFF, 1));
    // sltiu x, y, -1 is true for every value except 0xFFFFFFFF.
    try expectEqual(@as(u32, 1), lessUnsigned(1, 0xFFFF_FFFF));
}
