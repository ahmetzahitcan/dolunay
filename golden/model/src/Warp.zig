const control_unit = @import("control_unit.zig");

const Thread = @import("Thread.zig");
const Warp = @This();

pub const thread_count = 32;

threads: [thread_count]Thread,
warp_id: u16,

pub fn new(warp_id: u16) Warp {
    var result = .{
        .threads = undefined,
        .warp_id = warp_id,
    };
    for (0..thread_count) |i| {
        result.threads[i] = Thread.new(warp_id, i);
    }
    return result;
}

pub fn step(self: *Warp, pc: u32, instruction: control_unit.Instruction) Thread.Illegal!void {
    for (self.threads) |*thread| {
        try thread.step(pc, instruction);
    }
}
