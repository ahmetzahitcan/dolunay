const thread = @import("thread.zig");

pub fn Warp(comptime threadCount: usize) type {
    return struct {
        threads: [threadCount]thread.Thread,
        warpId: u16,

        pub fn new(warpId: u16) Warp(threadCount) {
            return Warp{
                .threads = undefined,
                .warpId = warpId,
            };
        }
    };
}
