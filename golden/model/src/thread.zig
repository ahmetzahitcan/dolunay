const std = @import("std");
const softfloat = @import("softfloat");
const control_unit = @import("control_unit.zig");
const float = @import("float.zig");
const int_utils = @import("int_utils.zig");

/// Acts the spec makes illegal, detected while executing one instruction. The
/// caller reports them as the `illegal` termination (CONTRACT.md §1, §4).
pub const Illegal = float.Error || error{
    /// A field value RISC-V assigns no instruction to, such as funct3 = 011
    /// in FSGNJ_S or FCMP_S (FINDINGS.md F7).
    IllegalInstruction,
};

const XRegs = struct {
    const REG_COUNT = 32;
    values: [REG_COUNT - 1]u32,

    pub fn read(self: *const XRegs, r: u5) u32 {
        return if (r == 0) 0 else self.values[r - 1];
    }

    pub fn write(self: *XRegs, r: u5, value: u32) void {
        if (r != 0) self.values[r - 1] = value;
    }
};

const FRegs = struct {
    const REG_COUNT = 32;
    values: [REG_COUNT]u32,

    pub fn read(self: *const FRegs, r: u5) u32 {
        return self.values[r];
    }

    pub fn write(self: *FRegs, r: u5, value: u32) void {
        self.values[r] = value;
    }
};

pub const Thread = struct {
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

    pub fn execute(self: *Thread, pc: u32, instruction: control_unit.Instruction) Illegal!void {
        // Semantics from the RISC-V unprivileged ISA: RV32I "Integer
        // Computational Instructions", and Zba for SHnADD. Arithmetic wraps
        // modulo 2^32; shifts use the low 5 bits of the amount.
        switch (instruction) {
            .ADD => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) +% self.xregs.read(i.rs2)),
            .SUB => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) -% self.xregs.read(i.rs2)),
            .SH1ADD => |i| self.xregs.write(i.rd, (self.xregs.read(i.rs1) << 1) +% self.xregs.read(i.rs2)),
            .SH2ADD => |i| self.xregs.write(i.rd, (self.xregs.read(i.rs1) << 2) +% self.xregs.read(i.rs2)),
            .SH3ADD => |i| self.xregs.write(i.rd, (self.xregs.read(i.rs1) << 3) +% self.xregs.read(i.rs2)),
            .SLL => |i| self.xregs.write(i.rd, int_utils.shl(self.xregs.read(i.rs1), self.xregs.read(i.rs2))),
            .SRL => |i| self.xregs.write(i.rd, int_utils.shr(self.xregs.read(i.rs1), self.xregs.read(i.rs2))),
            .SRA => |i| self.xregs.write(i.rd, int_utils.sra(self.xregs.read(i.rs1), self.xregs.read(i.rs2))),
            .SLT => |i| self.xregs.write(i.rd, int_utils.lessSigned(self.xregs.read(i.rs1), self.xregs.read(i.rs2))),
            .SLTU => |i| self.xregs.write(i.rd, int_utils.lessUnsigned(self.xregs.read(i.rs1), self.xregs.read(i.rs2))),
            .XOR => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) ^ self.xregs.read(i.rs2)),
            .OR => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) | self.xregs.read(i.rs2)),
            .AND => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) & self.xregs.read(i.rs2)),
            .ADDI => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) +% i.imm),
            .SLLI => |i| self.xregs.write(i.rd, int_utils.shl(self.xregs.read(i.rs1), i.imm)),
            .SRLI => |i| self.xregs.write(i.rd, int_utils.shr(self.xregs.read(i.rs1), i.imm)),
            .SRAI => |i| self.xregs.write(i.rd, int_utils.sra(self.xregs.read(i.rs1), i.imm)),
            .SLTI => |i| self.xregs.write(i.rd, int_utils.lessSigned(self.xregs.read(i.rs1), i.imm)),
            .SLTIU => |i| self.xregs.write(i.rd, int_utils.lessUnsigned(self.xregs.read(i.rs1), i.imm)),
            .XORI => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) ^ i.imm),
            .ORI => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) | i.imm),
            .ANDI => |i| self.xregs.write(i.rd, self.xregs.read(i.rs1) & i.imm),
            .LUI => |i| self.xregs.write(i.rd, i.imm),
            .AUIPC => |i| self.xregs.write(i.rd, pc +% i.imm),
            .CZERO_EQZ => |i| self.xregs.write(i.rd, if (self.xregs.read(i.rs2) == 0) 0 else self.xregs.read(i.rs1)),
            .CZERO_NEZ => |i| self.xregs.write(i.rd, if (self.xregs.read(i.rs2) != 0) 0 else self.xregs.read(i.rs1)),

            // RISC-V unprivileged ISA, "F" Standard Extension (float.zig).
            .FADD_S => |i| self.retireFloatF(i.rd, try float.add(self.fregs.read(i.rs1), self.fregs.read(i.rs2), i.rm)),
            .FSUB_S => |i| self.retireFloatF(i.rd, try float.sub(self.fregs.read(i.rs1), self.fregs.read(i.rs2), i.rm)),
            .FMUL_S => |i| self.retireFloatF(i.rd, try float.mul(self.fregs.read(i.rs1), self.fregs.read(i.rs2), i.rm)),
            .FDIV_S => |i| self.retireFloatF(i.rd, try float.div(self.fregs.read(i.rs1), self.fregs.read(i.rs2), i.rm)),
            .FSQRT_S => |i| self.retireFloatF(i.rd, try float.sqrt(self.fregs.read(i.rs1), i.rm)),
            .FMADD_S => |i| self.retireFloatF(i.rd, try float.mulAdd(self.fregs.read(i.rs1), self.fregs.read(i.rs2), self.fregs.read(i.rs3), i.rm)),
            .FMSUB_S => |i| self.retireFloatF(i.rd, try float.mulSub(self.fregs.read(i.rs1), self.fregs.read(i.rs2), self.fregs.read(i.rs3), i.rm)),
            .FNMSUB_S => |i| self.retireFloatF(i.rd, try float.negMulSub(self.fregs.read(i.rs1), self.fregs.read(i.rs2), self.fregs.read(i.rs3), i.rm)),
            .FNMADD_S => |i| self.retireFloatF(i.rd, try float.negMulAdd(self.fregs.read(i.rs1), self.fregs.read(i.rs2), self.fregs.read(i.rs3), i.rm)),
            .FMINMAX_S => |i| self.retireFloatF(i.rd, switch (i.rm) {
                0b000 => float.min(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
                0b001 => float.max(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
                else => return error.IllegalInstruction,
            }),
            .FSGNJ_S => |i| self.fregs.write(i.rd, switch (i.rm) {
                0b000 => float.sgnj(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
                0b001 => float.sgnjn(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
                0b010 => float.sgnjx(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
                else => return error.IllegalInstruction,
            }),
            .FCMP_S => |i| self.retireFloatX(i.rd, switch (i.rm) {
                0b010 => float.eq(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
                0b001 => float.lt(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
                0b000 => float.le(self.fregs.read(i.rs1), self.fregs.read(i.rs2)),
                else => return error.IllegalInstruction,
            }),
            .FCLASS_S => |i| self.xregs.write(i.rd, float.classify(self.fregs.read(i.rs1))),
            .FCVT_W_S => |i| self.retireFloatX(i.rd, try float.toI32(self.fregs.read(i.rs1), i.rm)),
            .FCVT_WU_S => |i| self.retireFloatX(i.rd, try float.toU32(self.fregs.read(i.rs1), i.rm)),
            .FCVT_S_W => |i| self.retireFloatF(i.rd, try float.fromI32(self.xregs.read(i.rs1), i.rm)),
            .FCVT_S_WU => |i| self.retireFloatF(i.rd, try float.fromU32(self.xregs.read(i.rs1), i.rm)),
            .FMV_X_W => |i| self.xregs.write(i.rd, self.fregs.read(i.rs1)),
            .FMV_W_X => |i| self.fregs.write(i.rd, self.xregs.read(i.rs1)),

            // These instructions must be dealt within the warp!
            .BEQ, .BNE, .BLT, .BGE, .BLTU, .BGEU => unreachable,
            .JAL, .JALR => unreachable,
            .LB, .LH, .LW, .LBU, .LHU, .FLW => unreachable,
            .SB, .SH, .SW, .FSW => unreachable,
            .BINIT, .BSYNC_0, .YIELD => unreachable,
            .FENCE => unreachable,
            .WDONE => unreachable,

            else => @panic("not implemented yet"),
        }
    }
};

fn testThread() Thread {
    var t = Thread.new(0, 0);
    t.xregs = @splat(0);
    t.fregs = @splat(.{ .v = 0 });
    t.fflags = 0;
    return t;
}

const expectEqual = std.testing.expectEqual;

test "thread: add and sub wrap modulo 2^32" {
    var t = testThread();
    t.xregs.write(1, 0xFFFF_FFFF);
    t.xregs.write(2, 2);
    try t.execute(0, .{ .ADD = .{ .rd = 3, .rs1 = 1, .rs2 = 2 } });
    try expectEqual(@as(u32, 1), t.xregs.read(3));
    try t.execute(0, .{ .SUB = .{ .rd = 3, .rs1 = 2, .rs2 = 1 } });
    try expectEqual(@as(u32, 3), t.xregs.read(3));
}

test "thread: x0 reads as zero and ignores writes" {
    var t = testThread();
    try t.execute(0, .{ .ADDI = .{ .rd = 0, .rs1 = 0, .imm = 5 } });
    try expectEqual(@as(u32, 0), t.xregs.read(0));
    try t.execute(0, .{ .ADDI = .{ .rd = 1, .rs1 = 0, .imm = 7 } });
    try expectEqual(@as(u32, 7), t.xregs.read(1));
}

test "thread: SHnADD shifts rs1, then adds rs2" {
    var t = testThread();
    t.xregs.write(1, 3);
    t.xregs.write(2, 100);
    try t.execute(0, .{ .SH1ADD = .{ .rd = 3, .rs1 = 1, .rs2 = 2 } });
    try expectEqual(@as(u32, 106), t.xregs.read(3));
    try t.execute(0, .{ .SH3ADD = .{ .rd = 3, .rs1 = 1, .rs2 = 2 } });
    try expectEqual(@as(u32, 124), t.xregs.read(3));
}

test "thread: shifts use the low 5 bits of the amount" {
    var t = testThread();
    t.xregs.write(1, 0x8000_0010);
    t.xregs.write(2, 33); // shifts by 1
    try t.execute(0, .{ .SLL = .{ .rd = 3, .rs1 = 1, .rs2 = 2 } });
    try expectEqual(@as(u32, 0x0000_0020), t.xregs.read(3));
    try t.execute(0, .{ .SRL = .{ .rd = 3, .rs1 = 1, .rs2 = 2 } });
    try expectEqual(@as(u32, 0x4000_0008), t.xregs.read(3));
    try t.execute(0, .{ .SRA = .{ .rd = 3, .rs1 = 1, .rs2 = 2 } });
    try expectEqual(@as(u32, 0xC000_0008), t.xregs.read(3));
    // srai x3, x1, 4: imm = 0x404, as the decoder gives it.
    try t.execute(0, .{ .SRAI = .{ .rd = 3, .rs1 = 1, .imm = 0x404 } });
    try expectEqual(@as(u32, 0xF800_0001), t.xregs.read(3));
}

test "thread: SLT is signed, SLTU and SLTIU unsigned" {
    var t = testThread();
    t.xregs.write(1, 0xFFFF_FFFF); // -1
    t.xregs.write(2, 1);
    try t.execute(0, .{ .SLT = .{ .rd = 3, .rs1 = 1, .rs2 = 2 } });
    try expectEqual(@as(u32, 1), t.xregs.read(3));
    try t.execute(0, .{ .SLTU = .{ .rd = 3, .rs1 = 1, .rs2 = 2 } });
    try expectEqual(@as(u32, 0), t.xregs.read(3));
    // sltiu x3, x2, -1: true for every value except 0xFFFFFFFF.
    try t.execute(0, .{ .SLTIU = .{ .rd = 3, .rs1 = 2, .imm = 0xFFFF_FFFF } });
    try expectEqual(@as(u32, 1), t.xregs.read(3));
    try t.execute(0, .{ .SLTI = .{ .rd = 3, .rs1 = 2, .imm = 0xFFFF_FFFF } });
    try expectEqual(@as(u32, 0), t.xregs.read(3));
}

test "thread: logical immediates use the sign-extended immediate" {
    var t = testThread();
    t.xregs.write(1, 0x1234_5678);
    try t.execute(0, .{ .XORI = .{ .rd = 2, .rs1 = 1, .imm = 0xFFFF_FFFF } });
    try expectEqual(@as(u32, 0xEDCB_A987), t.xregs.read(2));
    try t.execute(0, .{ .ANDI = .{ .rd = 2, .rs1 = 1, .imm = 0xFFFF_FF00 } });
    try expectEqual(@as(u32, 0x1234_5600), t.xregs.read(2));
    try t.execute(0, .{ .ORI = .{ .rd = 2, .rs1 = 1, .imm = 0x0000_000F } });
    try expectEqual(@as(u32, 0x1234_567F), t.xregs.read(2));
}

// Floating-point values below are IEEE 754 binary32 bit patterns.
const one: u32 = 0x3F80_0000;
const two: u32 = 0x4000_0000;
const three: u32 = 0x4040_0000;
const plus_zero: u32 = 0x0000_0000;
const minus_zero: u32 = 0x8000_0000;
const quiet_nan: u32 = 0x7FC0_0001;
const signaling_nan: u32 = 0x7F80_0001;
const invalid: u8 = softfloat.softfloat_flag_invalid;
const inexact: u8 = softfloat.softfloat_flag_inexact;

test "thread: FADD.S adds, and fflags accrue" {
    var t = testThread();
    t.fregs.write(1, one);
    t.fregs.write(2, two);
    try t.execute(0, .{ .FADD_S = .{ .rd = 3, .rs1 = 1, .rs2 = 2, .rm = 0b111 } });
    try expectEqual(three, t.fregs.read(3));
    try expectEqual(@as(u8, 0), t.fflags);
    // 1/3 is inexact; the flag stays set after an exact operation.
    try t.execute(0, .{ .FDIV_S = .{ .rd = 4, .rs1 = 1, .rs2 = 3, .rm = 0b000 } });
    try t.execute(0, .{ .FADD_S = .{ .rd = 5, .rs1 = 1, .rs2 = 2, .rm = 0b000 } });
    try expectEqual(inexact, t.fflags);
}

test "thread: 0/0 gives the canonical NaN and raises invalid" {
    var t = testThread();
    try t.execute(0, .{ .FDIV_S = .{ .rd = 1, .rs1 = 0, .rs2 = 0, .rm = 0b000 } });
    try expectEqual(float.canonical_nan, t.fregs.read(1));
    try expectEqual(invalid, t.fflags);
}

test "thread: rm 101 and 110 are illegal" {
    var t = testThread();
    try std.testing.expectError(error.ReservedRoundingMode, t.execute(0, .{ .FADD_S = .{ .rd = 1, .rs1 = 1, .rs2 = 1, .rm = 0b101 } }));
    try std.testing.expectError(error.ReservedRoundingMode, t.execute(0, .{ .FCVT_W_S = .{ .rd = 1, .rs1 = 1, .rm = 0b110 } }));
}

test "thread: the rounding mode reaches the operation" {
    var t = testThread();
    t.fregs.write(1, 0x3FC0_0000); // 1.5
    try t.execute(0, .{ .FCVT_W_S = .{ .rd = 1, .rs1 = 1, .rm = 0b000 } }); // RNE
    try expectEqual(@as(u32, 2), t.xregs.read(1));
    try t.execute(0, .{ .FCVT_W_S = .{ .rd = 1, .rs1 = 1, .rm = 0b001 } }); // RTZ
    try expectEqual(@as(u32, 1), t.xregs.read(1));
    try t.execute(0, .{ .FCVT_W_S = .{ .rd = 1, .rs1 = 1, .rm = 0b010 } }); // RDN
    try expectEqual(@as(u32, 1), t.xregs.read(1));
    try t.execute(0, .{ .FCVT_W_S = .{ .rd = 1, .rs1 = 1, .rm = 0b011 } }); // RUP
    try expectEqual(@as(u32, 2), t.xregs.read(1));
    try expectEqual(inexact, t.fflags);
}

test "thread: out-of-range conversions saturate, NaN converts to the maximum" {
    var t = testThread();
    t.fregs.write(1, 0xCF80_0000); // -2^32
    try t.execute(0, .{ .FCVT_W_S = .{ .rd = 1, .rs1 = 1, .rm = 0b000 } });
    try expectEqual(@as(u32, 0x8000_0000), t.xregs.read(1));
    try t.execute(0, .{ .FCVT_WU_S = .{ .rd = 1, .rs1 = 1, .rm = 0b000 } });
    try expectEqual(@as(u32, 0), t.xregs.read(1));
    t.fregs.write(2, quiet_nan);
    try t.execute(0, .{ .FCVT_W_S = .{ .rd = 1, .rs1 = 2, .rm = 0b000 } });
    try expectEqual(@as(u32, 0x7FFF_FFFF), t.xregs.read(1));
    try t.execute(0, .{ .FCVT_WU_S = .{ .rd = 1, .rs1 = 2, .rm = 0b000 } });
    try expectEqual(@as(u32, 0xFFFF_FFFF), t.xregs.read(1));
    try expectEqual(invalid, t.fflags);
}

test "thread: integer to float conversions" {
    var t = testThread();
    t.xregs.write(1, 0xFFFF_FFFD); // -3, or 4294967293 unsigned
    try t.execute(0, .{ .FCVT_S_W = .{ .rd = 1, .rs1 = 1, .rm = 0b000 } });
    try expectEqual(three | float.sign_bit, t.fregs.read(1));
    try t.execute(0, .{ .FCVT_S_WU = .{ .rd = 2, .rs1 = 1, .rm = 0b000 } });
    try expectEqual(@as(u32, 0x4F80_0000), t.fregs.read(2)); // rounds to 2^32
    try expectEqual(inexact, t.fflags);
}

test "thread: fused multiply-add and its negated forms" {
    var t = testThread();
    t.fregs.write(1, two);
    t.fregs.write(2, three);
    t.fregs.write(3, one);
    try t.execute(0, .{ .FMADD_S = .{ .rd = 4, .rs1 = 1, .rs2 = 2, .rs3 = 3, .rm = 0b000 } }); // 2*3 + 1 = 7
    try expectEqual(@as(u32, 0x40E0_0000), t.fregs.read(4));
    try t.execute(0, .{ .FMSUB_S = .{ .rd = 4, .rs1 = 1, .rs2 = 2, .rs3 = 3, .rm = 0b000 } }); // 2*3 - 1 = 5
    try expectEqual(@as(u32, 0x40A0_0000), t.fregs.read(4));
    try t.execute(0, .{ .FNMSUB_S = .{ .rd = 4, .rs1 = 1, .rs2 = 2, .rs3 = 3, .rm = 0b000 } }); // -(2*3) + 1 = -5
    try expectEqual(@as(u32, 0xC0A0_0000), t.fregs.read(4));
    try t.execute(0, .{ .FNMADD_S = .{ .rd = 4, .rs1 = 1, .rs2 = 2, .rs3 = 3, .rm = 0b000 } }); // -(2*3) - 1 = -7
    try expectEqual(@as(u32, 0xC0E0_0000), t.fregs.read(4));
}

test "thread: FMIN.S/FMAX.S order the zeros and skip a NaN" {
    var t = testThread();
    t.fregs.write(1, plus_zero);
    t.fregs.write(2, minus_zero);
    t.fregs.write(3, quiet_nan);
    t.fregs.write(4, signaling_nan);
    try t.execute(0, .{ .FMINMAX_S = .{ .rd = 5, .rs1 = 1, .rs2 = 2, .rm = 0b000 } });
    try expectEqual(minus_zero, t.fregs.read(5));
    try t.execute(0, .{ .FMINMAX_S = .{ .rd = 5, .rs1 = 2, .rs2 = 1, .rm = 0b001 } });
    try expectEqual(plus_zero, t.fregs.read(5));
    try t.execute(0, .{ .FMINMAX_S = .{ .rd = 5, .rs1 = 3, .rs2 = 2, .rm = 0b000 } });
    try expectEqual(minus_zero, t.fregs.read(5));
    try expectEqual(@as(u8, 0), t.fflags); // a quiet NaN raises nothing
    try t.execute(0, .{ .FMINMAX_S = .{ .rd = 5, .rs1 = 3, .rs2 = 4, .rm = 0b001 } });
    try expectEqual(float.canonical_nan, t.fregs.read(5));
    try expectEqual(invalid, t.fflags);
}

test "thread: sign injection" {
    var t = testThread();
    t.fregs.write(1, three);
    t.fregs.write(2, minus_zero);
    try t.execute(0, .{ .FSGNJ_S = .{ .rd = 3, .rs1 = 1, .rs2 = 2, .rm = 0b000 } });
    try expectEqual(three | float.sign_bit, t.fregs.read(3));
    try t.execute(0, .{ .FSGNJ_S = .{ .rd = 3, .rs1 = 1, .rs2 = 2, .rm = 0b001 } });
    try expectEqual(three, t.fregs.read(3));
    try t.execute(0, .{ .FSGNJ_S = .{ .rd = 3, .rs1 = 3, .rs2 = 2, .rm = 0b010 } });
    try expectEqual(three | float.sign_bit, t.fregs.read(3));
}

test "thread: FEQ.S is quiet, FLT.S signals on a quiet NaN" {
    var t = testThread();
    t.fregs.write(1, one);
    t.fregs.write(2, quiet_nan);
    try t.execute(0, .{ .FCMP_S = .{ .rd = 1, .rs1 = 1, .rs2 = 1, .rm = 0b010 } });
    try expectEqual(@as(u32, 1), t.xregs.read(1));
    try t.execute(0, .{ .FCMP_S = .{ .rd = 1, .rs1 = 1, .rs2 = 2, .rm = 0b010 } });
    try expectEqual(@as(u32, 0), t.xregs.read(1));
    try expectEqual(@as(u8, 0), t.fflags);
    try t.execute(0, .{ .FCMP_S = .{ .rd = 1, .rs1 = 1, .rs2 = 2, .rm = 0b001 } });
    try expectEqual(@as(u32, 0), t.xregs.read(1));
    try expectEqual(invalid, t.fflags);
}

test "thread: FCLASS.S sets one bit per class" {
    var t = testThread();
    const cases = [_]struct { bits: u32, class: u5 }{
        .{ .bits = 0xFF80_0000, .class = 0 }, // -inf
        .{ .bits = 0xBF80_0000, .class = 1 }, // -1.0
        .{ .bits = 0x8000_0001, .class = 2 }, // negative subnormal
        .{ .bits = minus_zero, .class = 3 },
        .{ .bits = plus_zero, .class = 4 },
        .{ .bits = 0x0000_0001, .class = 5 }, // positive subnormal
        .{ .bits = one, .class = 6 },
        .{ .bits = 0x7F80_0000, .class = 7 }, // +inf
        .{ .bits = signaling_nan, .class = 8 },
        .{ .bits = quiet_nan, .class = 9 },
    };
    for (cases) |c| {
        t.fregs.write(1, c.bits);
        try t.execute(0, .{ .FCLASS_S = .{ .rd = 1, .rs1 = 1, .rm = 0b001 } });
        try expectEqual(@as(u32, 1) << c.class, t.xregs.read(1));
    }
}

test "thread: FMV moves bits without conversion" {
    var t = testThread();
    t.xregs.write(1, signaling_nan);
    try t.execute(0, .{ .FMV_W_X = .{ .rd = 1, .rs1 = 1, .rm = 0b000 } });
    try expectEqual(signaling_nan, t.fregs.read(1));
    try t.execute(0, .{ .FMV_X_W = .{ .rd = 2, .rs1 = 1, .rm = 0b000 } });
    try expectEqual(signaling_nan, t.xregs.read(2));
    try expectEqual(@as(u8, 0), t.fflags);
}

test "thread: an unassigned funct3 is illegal" {
    var t = testThread();
    try std.testing.expectError(error.IllegalInstruction, t.execute(0, .{ .FSGNJ_S = .{ .rd = 1, .rs1 = 1, .rs2 = 1, .rm = 0b011 } }));
    try std.testing.expectError(error.IllegalInstruction, t.execute(0, .{ .FCMP_S = .{ .rd = 1, .rs1 = 1, .rs2 = 1, .rm = 0b011 } }));
    try std.testing.expectError(error.IllegalInstruction, t.execute(0, .{ .FMINMAX_S = .{ .rd = 1, .rs1 = 1, .rs2 = 1, .rm = 0b010 } }));
}
