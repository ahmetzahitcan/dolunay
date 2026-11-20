const AddressSpace = @This();
const std = @import("std");

pub const Error = error{
    UnmappedAddress,
    UnalignedAccess,
};

const rom_address = 0x0000_0000;
const rom_size = 4096; // 4 KiB

rom: [rom_size]u8,

pub fn new(rom: [rom_size]u8) AddressSpace {
    return .{ .rom = rom };
}

inline fn readInt(buffer: []const u8, address: u32) u32 {
    return std.mem.readInt(u32, buffer[address..][0..4], .little);
}

pub fn load(self: *AddressSpace, address: u32) Error!u32 {
    if (address % 4 != 0) {
        return Error.UnalignedAccess;
    }

    if (address >= rom_address and address < rom_address + rom_size) {
        return readInt(&self.rom, address - rom_address);
    } else {
        return Error.UnmappedAddress;
    }
}

test "AddressSpace.load" {
    var rom: [rom_size]u8 = undefined;
    rom[0] = 0x01;
    rom[1] = 0x02;
    rom[2] = 0x03;
    rom[3] = 0x04;
    var address_space = AddressSpace.new(rom);

    try std.testing.expectEqual(address_space.load(0x0000_0000) catch unreachable, 0x04030201);
    try std.testing.expectError(Error.UnalignedAccess, address_space.load(0x0000_0001));
    try std.testing.expectError(Error.UnmappedAddress, address_space.load(0x0000_1000));
    try std.testing.expectError(Error.UnmappedAddress, address_space.load(0x0001_0000));
}
