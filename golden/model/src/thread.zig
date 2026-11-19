const softfloat = @import("softfloat");
const control_unit = @import("control_unit.zig");

const XREG_COUNT = 32;
const FREG_COUNT = 32;

pub const Thread = struct {
    /// The thread's integer registers.
    xregs: [XREG_COUNT]u32,

    /// The thread's floating-point registers.
    fregs: [FREG_COUNT]softfloat.float32_t,

    /// The thread's floating-point flags.
    fflags: u8,

    /// Warp ID
    warp_id: u32,

    /// Thread ID
    thread_id: u32,

    fn new(warp_id: u32, thread_id: u32) Thread {
        return Thread{
            .xregs = undefined,
            .fregs = undefined,
            .fflags = undefined,
            .warp_id = warp_id,
            .thread_id = thread_id,
        };
    }

    fn execute(self: *Thread, instruction: control_unit.Instruction) void {
        switch (instruction) {
            .ADD => |inst| {
                const src1 = self.xregs[inst.rs1];
                const src2 = self.xregs[inst.rs2];
                const result = src1 + src2;
                self.xregs[inst.rd] = result;
            },
            .SUB => |inst| {
                const src1 = self.xregs[inst.rs1];
                const src2 = self.xregs[inst.rs2];
                const result = src1 - src2;
                self.xregs[inst.rd] = result;
            },
            // Add more instruction cases as needed
            else => {},
        }
    }
};
