//! The Dolunay golden model (`golden/CONTRACT.md`). A skeleton: its only
//! architectural code is the decoder that `control_unit/generate.py` emits.

const std = @import("std");
const softfloat = @import("softfloat");

pub const control_unit = @import("control_unit.zig");
pub const float = @import("float.zig");
pub const thread = @import("thread.zig");

test {
    std.testing.refAllDecls(@This());
}

// The tests below check that SoftFloat is linked and built with the RISC-V
// specialization; they say nothing about the model.

fn bits(x: softfloat.float32_t) u32 {
    return x.v;
}

test "softfloat: 1.0 + 2.0 = 3.0, exact" {
    softfloat.softfloat_exceptionFlags = 0;
    const one: softfloat.float32_t = .{ .v = 0x3F80_0000 };
    const two: softfloat.float32_t = .{ .v = 0x4000_0000 };
    try std.testing.expectEqual(@as(u32, 0x4040_0000), bits(softfloat.f32_add(one, two)));
    try std.testing.expectEqual(@as(u8, 0), softfloat.softfloat_exceptionFlags);
}

test "softfloat: 0/0 gives RISC-V's canonical NaN and raises invalid" {
    // RISC-V unprivileged ISA, "F" Standard Extension, "NaN Generation and
    // Propagation": the canonical NaN is 0x7fc00000.
    softfloat.softfloat_exceptionFlags = 0;
    const zero: softfloat.float32_t = .{ .v = 0 };
    try std.testing.expectEqual(@as(u32, 0x7FC0_0000), bits(softfloat.f32_div(zero, zero)));
    try std.testing.expectEqual(
        @as(u8, softfloat.softfloat_flag_invalid),
        softfloat.softfloat_exceptionFlags,
    );
}

// The words below are encoded by hand from the RISC-V unprivileged ISA's
// instruction formats; they test what control_unit.zig makes of them.

const Instruction = control_unit.Instruction;

fn expectDecode(expected: Instruction, word: u32) !void {
    try std.testing.expectEqual(@as(?Instruction, expected), control_unit.decode(word));
}

test "control_unit: R-type, add x1, x2, x3" {
    try expectDecode(.{ .ADD = .{ .rd = 1, .rs1 = 2, .rs2 = 3 } }, 0x003100B3);
}

test "control_unit: I-type, addi x1, x0, -1" {
    try expectDecode(.{ .ADDI = .{ .rd = 1, .rs1 = 0, .imm = 0xFFFF_FFFF } }, 0xFFF00093);
}

test "control_unit: S-type, sw x2, -4(x1)" {
    try expectDecode(.{ .SW = .{ .rs1 = 1, .rs2 = 2, .imm = 0xFFFF_FFFC } }, 0xFE20AE23);
}

test "control_unit: B-type, beq x1, x2, -4" {
    try expectDecode(.{ .BEQ = .{ .rs1 = 1, .rs2 = 2, .imm = 0xFFFF_FFFC } }, 0xFE208EE3);
}

test "control_unit: U-type, lui x1, 0x12345" {
    try expectDecode(.{ .LUI = .{ .rd = 1, .imm = 0x1234_5000 } }, 0x123450B7);
}

test "control_unit: J-type, jal x0, -8" {
    try expectDecode(.{ .JAL = .{ .rd = 0, .imm = 0xFFFF_FFF8 } }, 0xFF9FF06F);
}

test "control_unit: R4-type, fmadd.s f1, f2, f3, f4" {
    try expectDecode(.{ .FMADD_S = .{ .rd = 1, .rs1 = 2, .rs2 = 3, .rs3 = 4, .rm = 0 } }, 0x203100C3);
}

test "control_unit: fcvt.w.s x1, f2 mixes register files" {
    try expectDecode(.{ .FCVT_W_S = .{ .rd = 1, .rs1 = 2, .rm = 0 } }, 0xC00100D3);
}

test "control_unit: the more specific of two overlapping patterns wins" {
    // slti x0, x0, 0 matches both SLTI and the CSV's WDONE row.
    try expectDecode(.{ .WDONE = .{ .imm = 0 } }, 0x00002013);
    try expectDecode(.{ .SLTI = .{ .rd = 1, .rs1 = 0, .imm = 0 } }, 0x00002093);
}

test "control_unit: a 16-bit encoding decodes to nothing" {
    try std.testing.expectEqual(@as(?Instruction, null), control_unit.decode(0x0000_0001));
}

test "control_unit: csrr x1, mhartid is CSRRS with rs1 = x0" {
    try expectDecode(.{ .CSRRS = .{ .rd = 1, .rs1 = 0, .csr = .mhartid } }, 0xF14020F3);
}

test "control_unit: csrrwi x0, fflags, 5 carries the immediate" {
    try expectDecode(.{ .CSRRWI = .{ .rd = 0, .uimm = 5, .csr = .fflags } }, 0x0012D073);
}

test "control_unit: an unnamed CSR number still decodes" {
    try expectDecode(.{ .CSRRS = .{ .rd = 1, .rs1 = 0, .csr = @fromBackingInt(0x7C0) } }, 0x7C0020F3);
}

test "control_unit: ecall (SYSTEM, funct3 = 000) is not a CSR access" {
    try std.testing.expectEqual(@as(?Instruction, null), control_unit.decode(0x0000_0073));
}

test "control_unit: FSGNJ and FCMP with funct3 = 011 do not decode" {
    // fsgnj-like and feq-like words with funct3 = 011 (FINDINGS.md F7).
    try std.testing.expectEqual(@as(?Instruction, null), control_unit.decode(0x2020B0D3));
    try std.testing.expectEqual(@as(?Instruction, null), control_unit.decode(0xA020B0D3));
}
