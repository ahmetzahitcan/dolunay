const std = @import("std");
const control_unit = @import("control_unit.zig");

const AddressSpace = @import("AddressSpace.zig");
const Thread = @import("Thread.zig");
const Warp = @This();

const ThreadManager = struct {
    const thread_count = 32;
    const upath = u5;

    const Threads = struct {
        master: *ThreadManager,
        filter: upath,
        where: usize,

        fn new(master: *ThreadManager, filter: upath) Threads {
            return Threads{
                .master = master,
                .filter = filter,
                .where = 0,
            };
        }

        fn next(self: *Threads) ?*Thread {
            while (self.where < thread_count) {
                const i = self.where;
                self.where += 1;
                if (self.filter == -1 or self.master.paths[i] == self.filter) {
                    return &self.master.threads[i];
                }
            }
            return null;
        }
    };

    threads: [thread_count]Thread,
    paths: [thread_count]upath,
    active_path: upath,

    pub fn new(warp_id: u16) ThreadManager {
        var result = ThreadManager{
            .threads = undefined,
            .paths = undefined,
            .active_path = 0,
        };
        for (0..thread_count) |i| {
            result.threads[i] = Thread.new(warp_id, @truncate(i));
            result.paths[i] = 0;
        }
        return result;
    }

    pub fn all(self: *ThreadManager) Threads {
        return Threads.new(self, -1);
    }

    pub fn active(self: *ThreadManager) Threads {
        return Threads.new(self, self.active_path);
    }

    pub fn friends(self: *ThreadManager, thread_id: u16) Threads {
        return Threads.new(self, self.paths[thread_id]);
    }
};

warp_id: u16,
pc: u32,
threads: ThreadManager,
addrs: AddressSpace,

pub fn new(warp_id: u16, addrs: AddressSpace) Warp {
    return .{
        .threads = ThreadManager.new(warp_id),
        .warp_id = warp_id,
        .pc = 0,
        .addrs = addrs,
    };
}

pub fn step(self: *Warp) Thread.Illegal!void {
    const instruction =
        control_unit.decode(self.addrs.load(self.pc) catch |err| switch (err) {
            AddressSpace.Error.UnalignedAccess => unreachable,
            AddressSpace.Error.UnmappedAddress => return Thread.Illegal.IllegalInstruction,
        }) orelse return Thread.Illegal.IllegalInstruction;
    switch (instruction) {
        // These instructions must be dealt within the warp!
        .beq, .bne, .blt, .bge, .bltu, .bgeu => @panic("not yet implemented"),
        .jal => |i| {
            const new_pc = self.pc + i.imm;
            const link_pc = self.pc + 4;
            for (self.threads.active()) |*thread| {
                thread.xregs.write(i.rd, link_pc);
            }
            self.pc = new_pc;
        },
        .jalr => @panic("not yet implemented"),
        .lb, .lh, .lw, .lbu, .lhu, .flw => @panic("not yet implemented"),
        .sb, .sh, .sw, .fsw => @panic("not yet implemented"),
        .binit, .bsync_0, .yield => @panic("not yet implemented"),
        .fence => @panic("not yet implemented"),
        .wdone => @panic("not yet implemented"),

        // All other instructions are executed by each thread in the warp.
        else => {
            for (self.threads.active()) |*thread| {
                try thread.step(self.pc, instruction);
            }
            self.pc += 4;
        },
    }
}

test "a basic warp run" {
    var rom: [4096]u8 = undefined;

    rom[0] = 0x93; // addi x7, x0, 0
    rom[1] = 0x03;
    rom[2] = 0x00;
    rom[3] = 0x00;

    rom[4] = 0x93; // addi x7, x7, 1
    rom[5] = 0x83;
    rom[6] = 0x13;
    rom[7] = 0x00;

    rom[8] = 0xef; // jal x1, -4
    rom[9] = 0xf0;
    rom[10] = 0xdf;
    rom[11] = 0xff;

    var warp = Warp.new(0, AddressSpace.new(rom));
    try warp.step() catch unreachable;
    try std.testing.expectEqual(warp.pc, 4);
    try std.testing.expectEqual(warp.threads.threads[0].xregs.read(7), 0);
    try std.testing.expectEqual(warp.threads.threads[1].xregs.read(7), 0);

    for (1..1_000_000) |i| {
        try warp.step() catch unreachable;
        try warp.step() catch unreachable;
        try std.testing.expectEqual(warp.pc, 4);
        try std.testing.expectEqual(warp.threads.threads[0].xregs.read(1), 12);
        try std.testing.expectEqual(warp.threads.threads[1].xregs.read(1), 12);
        try std.testing.expectEqual(warp.threads.threads[0].xregs.read(7), i);
        try std.testing.expectEqual(warp.threads.threads[1].xregs.read(7), i);
    }
}
