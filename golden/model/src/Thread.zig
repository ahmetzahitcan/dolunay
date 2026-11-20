const std = @import("std");
const softfloat = @import("softfloat");
const control_unit = @import("control_unit.zig");
const float = @import("float.zig");
const int_utils = @import("int_utils.zig");

const Thread = @This();

/// Acts the spec makes illegal, detected while executing one instruction. The
/// caller reports them as the `illegal` termination (CONTRACT.md §1, §4).
///
/// TODO: Move these somewhere else.
pub const Illegal = float.Error || error{
    /// A field value RISC-V assigns no instruction to, such as funct3 = 011
    /// in FSGNJ_S or FCMP_S (FINDINGS.md F7).
    IllegalInstruction,
};

pub const XRegs = struct {
    const reg_count = 32;
    values: [reg_count - 1]u32,

    pub fn read(self: *const XRegs, r: u5) u32 {
        return if (r == 0) 0 else self.values[r - 1];
    }

    pub fn write(self: *XRegs, r: u5, value: u32) void {
        if (r != 0) self.values[r - 1] = value;
    }
};

pub const FRegs = struct {
    const reg_count = 32;
    values: [reg_count]u32,

    pub fn read(self: *const FRegs, r: u5) u32 {
        return self.values[r];
    }

    pub fn write(self: *FRegs, r: u5, value: u32) void {
        self.values[r] = value;
    }
};

/// The thread's integer registers.
xregs: XRegs,

/// The thread's floating-point registers.
fregs: FRegs,

/// The thread's floating-point flags.
fflags: u8,

/// Warp ID
warp_id: u16,

/// Thread ID
thread_id: u16,

pub fn new(warp_id: u16, thread_id: u16) Thread {
    return Thread{
        .xregs = undefined,
        .fregs = undefined,
        .fflags = undefined,
        .warp_id = warp_id,
        .thread_id = thread_id,
    };
}

/// Writes a floating-point result to f[rd] and accrues its flags.
fn retireFloatF(self: *Thread, rd: u5, r: float.Result) void {
    self.fregs.write(rd, r.value);
    self.fflags |= r.flags;
}

/// Writes an integer result of a floating-point instruction to x[rd] and
/// accrues its flags.
fn retireFloatX(self: *Thread, rd: u5, r: float.Result) void {
    self.xregs.write(rd, r.value);
    self.fflags |= r.flags;
}

pub fn step(self: *Thread, pc: u32, instruction: control_unit.Instruction) Illegal!void {
    // Semantics from the RISC-V unprivileged ISA: RV32I "Integer
    // Computational Instructions", and Zba for SHnADD. Arithmetic wraps
    // modulo 2^32; shifts use the low 5 bits of the amount.
    switch (instruction) {
        .add => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) +% self.xregs.read(i.rs2)),
        .sub => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) -% self.xregs.read(i.rs2)),
        .sh1add => |i| self.xregs.write(i.rd, (self.xregs.read(i.rs1) << 1) +% self.xregs.read(i.rs2)),
        .sh2add => |i| self.xregs.write(i.rd, (self.xregs.read(i.rs1) << 2) +% self.xregs.read(i.rs2)),
        .sh3add => |i| self.xregs.write(i.rd, (self.xregs.read(i.rs1) << 3) +% self.xregs.read(i.rs2)),
        .sll => |i| self.xregs.write(i.rd, int_utils.shl(self.xregs.read(i.rs1), self.xregs.read(i.rs2))),
        .srl => |i| self.xregs.write(i.rd, int_utils.shr(self.xregs.read(i.rs1), self.xregs.read(i.rs2))),
        .sra => |i| self.xregs.write(i.rd, int_utils.sra(self.xregs.read(i.rs1), self.xregs.read(i.rs2))),
        .slt => |i| self.xregs.write(i.rd, int_utils.lessSigned(self.xregs.read(i.rs1), self.xregs.read(i.rs2))),
        .sltu => |i| self.xregs.write(i.rd, int_utils.lessUnsigned(self.xregs.read(i.rs1), self.xregs.read(i.rs2))),
        .xor => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) ^ self.xregs.read(i.rs2)),
        .@"or" => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) | self.xregs.read(i.rs2)),
        .@"and" => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) & self.xregs.read(i.rs2)),
        .addi => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) +% i.imm),
        .slli => |i| self.xregs.write(i.rd, int_utils.shl(self.xregs.read(i.rs1), i.imm)),
        .srli => |i| self.xregs.write(i.rd, int_utils.shr(self.xregs.read(i.rs1), i.imm)),
        .srai => |i| self.xregs.write(i.rd, int_utils.sra(self.xregs.read(i.rs1), i.imm)),
        .slti => |i| self.xregs.write(i.rd, int_utils.lessSigned(self.xregs.read(i.rs1), i.imm)),
        .sltiu => |i| self.xregs.write(i.rd, int_utils.lessUnsigned(self.xregs.read(i.rs1), i.imm)),
        .xori => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) ^ i.imm),
        .ori => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) | i.imm),
        .andi => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) & i.imm),
        .lui => |i| self.xregs.write(i.rd, i.imm),
        .auipc => |i| self.xregs.write(i.rd, pc +% i.imm),
        .czero_eqz => |i| self.xregs.write(i.rd, if (self.xregs.read(i.rs2) == 0) 0 else self.xregs.read(i.rs1)),
        .czero_nez => |i| self.xregs.write(i.rd, if (self.xregs.read(i.rs2) != 0) 0 else self.xregs.read(i.rs1)),

        // RISC-V unprivileged ISA, "F" Standard Extension (float.zig).
        .fadd_s => |i| self.retireFloatF(i.rd, try float.add(self.fregs.read(i.rs1), self.fregs.read(i.rs2), i.rm)),
        .fsub_s => |i| self.retireFloatF(i.rd, try float.sub(self.fregs.read(i.rs1), self.fregs.read(i.rs2), i.rm)),
        .fmul_s => |i| self.retireFloatF(i.rd, try float.mul(self.fregs.read(i.rs1), self.fregs.read(i.rs2), i.rm)),
        .fdiv_s => |i| self.retireFloatF(i.rd, try float.div(self.fregs.read(i.rs1), self.fregs.read(i.rs2), i.rm)),
        .fsqrt_s => |i| self.retireFloatF(i.rd, try float.sqrt(self.fregs.read(i.rs1), i.rm)),
        .fmadd_s => |i| self.retireFloatF(i.rd, try float.mulAdd(self.fregs.read(i.rs1), self.fregs.read(i.rs2), self.fregs.read(i.rs3), i.rm)),
        .fmsub_s => |i| self.retireFloatF(i.rd, try float.mulSub(self.fregs.read(i.rs1), self.fregs.read(i.rs2), self.fregs.read(i.rs3), i.rm)),
        .fnmsub_s => |i| self.retireFloatF(i.rd, try float.negMulSub(self.fregs.read(i.rs1), self.fregs.read(i.rs2), self.fregs.read(i.rs3), i.rm)),
        .fnmadd_s => |i| self.retireFloatF(i.rd, try float.negMulAdd(self.fregs.read(i.rs1), self.fregs.read(i.rs2), self.fregs.read(i.rs3), i.rm)),
        .fminmax_s => |i| self.retireFloatF(i.rd, switch (i.rm) {
            0b000 => float.min(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
            0b001 => float.max(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
            else => return error.IllegalInstruction,
        }),
        .fsgnj_s => |i| self.fregs.write(i.rd, switch (i.rm) {
            0b000 => float.sgnj(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
            0b001 => float.sgnjn(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
            0b010 => float.sgnjx(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
            else => return error.IllegalInstruction,
        }),
        .fcmp_s => |i| self.retireFloatX(i.rd, switch (i.rm) {
            0b010 => float.eq(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
            0b001 => float.lt(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
            0b000 => float.le(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
            else => return error.IllegalInstruction,
        }),
        .fclass_s => |i| self.xregs.write(i.rd, float.classify(self.fregs.read(i.rs1))),
        .fcvt_w_s => |i| self.retireFloatX(i.rd, try float.toI32(self.fregs.read(i.rs1), i.rm)),
        .fcvt_wu_s => |i| self.retireFloatX(i.rd, try float.toU32(self.fregs.read(i.rs1), i.rm)),
        .fcvt_s_w => |i| self.retireFloatF(i.rd, try float.fromI32(self.xregs.read(i.rs1), i.rm)),
        .fcvt_s_wu => |i| self.retireFloatF(i.rd, try float.fromU32(self.xregs.read(i.rs1), i.rm)),
        .fmv_x_w => |i| self.xregs.write(i.rd, self.fregs.read(i.rs1)),
        .fmv_w_x => |i| self.fregs.write(i.rd, self.xregs.read(i.rs1)),

        .csrrw, .csrrs, .csrrc, .csrrwi, .csrrsi, .csrrci => @panic("not implemented yet"),

        // These instructions must be dealt within the warp!
        .beq, .bne, .blt, .bge, .bltu, .bgeu => unreachable,
        .jal, .jalr => unreachable,
        .lb, .lh, .lw, .lbu, .lhu, .flw => unreachable,
        .sb, .sh, .sw, .fsw => unreachable,
        .binit, .bsync_0, .yield => unreachable,
        .fence => unreachable,
        .wdone => unreachable,
    }
}

fn testThread() Thread {
    var t = Thread.new(0, 0);
    t.xregs.values = @splat(0);
    t.fregs.values = @splat(0);
    t.fflags = 0;
    return t;
}

// Instruction semantics are tested next to the pure functions that compute
// them (int_utils.zig, float.zig); these tests cover what Thread adds: the
// registers, `pc`, accruing `fflags`, and illegal acts.

const expectEqual = std.testing.expectEqual;
const expectError = std.testing.expectError;

test "thread: x0 reads as zero and ignores writes" {
    var t = testThread();
    try t.step(0, .{ .addi = .{ .rd = 0, .rs1 = 0, .imm = 5 } });
    try expectEqual(@as(u32, 0), t.xregs.read(0));
    try t.step(0, .{ .addi = .{ .rd = 1, .rs1 = 0, .imm = 7 } });
    try expectEqual(@as(u32, 7), t.xregs.read(1));
}

test "thread: AUIPC adds the immediate to pc, wrapping" {
    var t = testThread();
    try t.step(0xFFFF_F000, .{ .auipc = .{ .rd = 1, .imm = 0x0000_2000 } });
    try expectEqual(@as(u32, 0x0000_1000), t.xregs.read(1));
}

test "thread: fflags accrue across instructions" {
    var t = testThread();
    t.fregs.write(1, 0x3F80_0000); // 1.0
    t.fregs.write(2, 0x4040_0000); // 3.0
    try t.step(0, .{ .fdiv_s = .{ .rd = 3, .rs1 = 1, .rs2 = 2, .rm = 0b000 } }); // inexact
    try t.step(0, .{ .fadd_s = .{ .rd = 4, .rs1 = 1, .rs2 = 2, .rm = 0b000 } }); // exact
    try expectEqual(@as(u32, 0x4080_0000), t.fregs.read(4));
    try expectEqual(@as(u8, softfloat.softfloat_flag_inexact), t.fflags);
}

test "thread: illegal acts return an error" {
    var t = testThread();
    try expectError(error.ReservedRoundingMode, t.step(0, .{ .fadd_s = .{ .rd = 1, .rs1 = 1, .rs2 = 1, .rm = 0b101 } }));
    try expectError(error.IllegalInstruction, t.step(0, .{ .fsgnj_s = .{ .rd = 1, .rs1 = 1, .rs2 = 1, .rm = 0b011 } }));
    try expectError(error.IllegalInstruction, t.step(0, .{ .fcmp_s = .{ .rd = 1, .rs1 = 1, .rs2 = 1, .rm = 0b011 } }));
    try expectError(error.IllegalInstruction, t.step(0, .{ .fminmax_s = .{ .rd = 1, .rs1 = 1, .rs2 = 1, .rm = 0b010 } }));
}

test "thread: FMV moves bits between register files without conversion" {
    var t = testThread();
    const signaling_nan: u32 = 0x7F80_0001;
    t.xregs.write(1, signaling_nan);
    try t.step(0, .{ .fmv_w_x = .{ .rd = 1, .rs1 = 1, .rm = 0b000 } });
    try t.step(0, .{ .fmv_x_w = .{ .rd = 2, .rs1 = 1, .rm = 0b000 } });
    try expectEqual(signaling_nan, t.xregs.read(2));
    try expectEqual(@as(u8, 0), t.fflags);
}
