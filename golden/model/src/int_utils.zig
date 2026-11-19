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
