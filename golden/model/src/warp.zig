const Thread = @import("Thread.zig");

pub fn Warp(comptime threadCount: usize) type {
    return struct {
        threads: [threadCount]Thread,
        warpId: u16,

        pub fn new(warpId: u16) Warp(threadCount) {
            return Warp{
                .threads = undefined,
                .warpId = warpId,
            };
        }
    };
}
