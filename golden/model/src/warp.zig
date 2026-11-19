const Thread = @import("Thread.zig");

pub fn Warp(comptime thread_count: usize) type {
    return struct {
        threads: [thread_count]Thread,
        warp_id: u16,

        pub fn new(warp_id: u16) Warp(thread_count) {
            return Warp{
                .threads = undefined,
                .warp_id = warp_id,
            };
        }
    };
}
