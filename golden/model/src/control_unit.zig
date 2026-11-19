//! Instruction decode: a tagged union of the instructions, with their
//! operands, and `decode`.
//!
//! Started from control_unit/generate.py's output for control_unit.csv; now
//! maintained by hand. Rows for custom instructions are the previous variant's
//! encodings: placeholders until `golden/spec/` specifies them
//! (golden/CONTRACT.md §3).

fn reg(word: u32, comptime lsb: u5) u5 {
    return @truncate(word >> lsb);
}

fn funct3(word: u32) u3 {
    return @truncate(word >> 12);
}

fn csr(word: u32) Csr {
    return @fromBackingInt(@as(u12, @truncate(word >> 20)));
}

/// A CSR number (bits 31:20 of a Zicsr instruction). Named values are the CSRs
/// the model knows of; any other number is still representable, and whether
/// it exists is decided when the instruction executes.
pub const Csr = enum(u12) {
    // RISC-V unprivileged ISA, "Zicsr", "CSR Listing" / F "Floating-Point
    // Control and Status Register".
    fflags = 0x001,
    frm = 0x002,
    fcsr = 0x003,
    // RISC-V unprivileged ISA, "Zicntr" / "Zihpm".
    cycle = 0xC00,
    time = 0xC01,
    instret = 0xC02,
    hpmcounter3 = 0xC03,
    hpmcounter4 = 0xC04,
    cycleh = 0xC80,
    timeh = 0xC81,
    instreth = 0xC82,
    hpmcounter3h = 0xC83,
    hpmcounter4h = 0xC84,
    // RISC-V privileged ISA, "Machine Hart ID Register".
    mhartid = 0xF14,
    // Placeholders: the previous variant's custom CSRs (control_unit.csv's
    // CSR_XWARPID, CSR_XTHRID, CSR_XROLE), until `golden/spec/` specifies them.
    xwarpid = 0xCC0,
    xthrid = 0xCC1,
    xrole = 0xCC2,
    _,
};

fn sext(value: u32, comptime bits: u6) u32 {
    const shift: u5 = @intCast(32 - bits);
    return @bitCast(@as(i32, @bitCast(value << shift)) >> shift);
}

// Immediates as the RISC-V unprivileged ISA's "Immediate Encoding Variants"
// define them, sign-extended to 32 bits and held as the raw u32 pattern.
fn immI(w: u32) u32 {
    return sext(w >> 20, 12);
}
fn immS(w: u32) u32 {
    return sext(((w >> 25) << 5) | ((w >> 7) & 0x1f), 12);
}
fn immB(w: u32) u32 {
    return sext(((w >> 31) << 12) | (((w >> 7) & 0x1) << 11) |
        (((w >> 25) & 0x3f) << 5) | (((w >> 8) & 0xf) << 1), 13);
}
fn immU(w: u32) u32 {
    return w & 0xfffff000;
}
fn immJ(w: u32) u32 {
    return sext(((w >> 31) << 20) | (((w >> 12) & 0xff) << 12) |
        (((w >> 20) & 0x1) << 11) | (((w >> 21) & 0x3ff) << 1), 21);
}

pub const Instruction = union(enum) {
    // OP-type instructions
    ADD: struct { rd: u5, rs1: u5, rs2: u5 },
    SH1ADD: struct { rd: u5, rs1: u5, rs2: u5 },
    SH2ADD: struct { rd: u5, rs1: u5, rs2: u5 },
    SH3ADD: struct { rd: u5, rs1: u5, rs2: u5 },
    SUB: struct { rd: u5, rs1: u5, rs2: u5 },
    SLL: struct { rd: u5, rs1: u5, rs2: u5 },
    SLT: struct { rd: u5, rs1: u5, rs2: u5 },
    SLTU: struct { rd: u5, rs1: u5, rs2: u5 },
    XOR: struct { rd: u5, rs1: u5, rs2: u5 },
    SRL: struct { rd: u5, rs1: u5, rs2: u5 },
    SRA: struct { rd: u5, rs1: u5, rs2: u5 },
    OR: struct { rd: u5, rs1: u5, rs2: u5 },
    AND: struct { rd: u5, rs1: u5, rs2: u5 },

    // OP-IMM-type instructions
    ADDI: struct { rd: u5, rs1: u5, imm: u32 },
    SLLI: struct { rd: u5, rs1: u5, imm: u32 },
    SLTI: struct { rd: u5, rs1: u5, imm: u32 },
    SLTIU: struct { rd: u5, rs1: u5, imm: u32 },
    XORI: struct { rd: u5, rs1: u5, imm: u32 },
    SRLI: struct { rd: u5, rs1: u5, imm: u32 },
    SRAI: struct { rd: u5, rs1: u5, imm: u32 },
    ORI: struct { rd: u5, rs1: u5, imm: u32 },
    ANDI: struct { rd: u5, rs1: u5, imm: u32 },

    // Branch operations
    BEQ: struct { rs1: u5, rs2: u5, imm: u32 },
    BNE: struct { rs1: u5, rs2: u5, imm: u32 },
    BLT: struct { rs1: u5, rs2: u5, imm: u32 },
    BGE: struct { rs1: u5, rs2: u5, imm: u32 },
    BLTU: struct { rs1: u5, rs2: u5, imm: u32 },
    BGEU: struct { rs1: u5, rs2: u5, imm: u32 },

    // Jump operations
    JAL: struct { rd: u5, imm: u32 },
    JALR: struct { rd: u5, rs1: u5, imm: u32 },

    // LUI and AUIPC`
    LUI: struct { rd: u5, imm: u32 },
    AUIPC: struct { rd: u5, imm: u32 },

    // Memory operations
    LB: struct { rd: u5, rs1: u5, imm: u32 },
    LH: struct { rd: u5, rs1: u5, imm: u32 },
    LW: struct { rd: u5, rs1: u5, imm: u32 },
    FLW: struct { rd: u5, rs1: u5, rm: u3, imm: u32 },
    LBU: struct { rd: u5, rs1: u5, imm: u32 },
    LHU: struct { rd: u5, rs1: u5, imm: u32 },
    SB: struct { rs1: u5, rs2: u5, imm: u32 },
    SH: struct { rs1: u5, rs2: u5, imm: u32 },
    SW: struct { rs1: u5, rs2: u5, imm: u32 },
    FSW: struct { rs1: u5, rs2: u5, rm: u3, imm: u32 },

    // LR/SC
    // LR, 00010??_00000_?????_010_?????_01011, lr.w $d, ($1), x, I, I, x, x, OP1, x, RS1, x, NEVER, 1, MEM, 0, 0, 0, 1, LOAD, WORD, x, x, 0, 1, 0, 0, 0, x, x, x, x, x
    // SC, 00011??_?????_?????_010_?????_01011, sc.w $d, $2, ($1), x, I, I, I, x, OP1, x, RS1, x, NEVER, 1, SC, 0, 0, 0, 1, STORE, WORD, RS2, x, 0, 0, 1, 0, 0, x, x, x, x, x

    // Barrier operations
    BINIT: struct { rs1: u5, imm: u32 },
    BSYNC_0: struct { rs1: u5, imm: u32 },
    YIELD: void,

    // CSR operations (RISC-V unprivileged ISA, "Zicsr")
    CSRRW: struct { rd: u5, rs1: u5, csr: Csr },
    CSRRS: struct { rd: u5, rs1: u5, csr: Csr },
    CSRRC: struct { rd: u5, rs1: u5, csr: Csr },
    CSRRWI: struct { rd: u5, uimm: u5, csr: Csr },
    CSRRSI: struct { rd: u5, uimm: u5, csr: Csr },
    CSRRCI: struct { rd: u5, uimm: u5, csr: Csr },

    // FENCE operations (NOP)
    FENCE: void,

    // Zicond operations
    CZERO_EQZ: struct { rd: u5, rs1: u5, rs2: u5 },
    CZERO_NEZ: struct { rd: u5, rs1: u5, rs2: u5 },

    // Done signal (slti x0, x0, 0)
    WDONE: struct { imm: u32 },

    // Floating non-FMA ADDMUL
    FADD_S: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    FSUB_S: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    FMUL_S: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },

    // Floating FMA
    FMADD_S: struct { rd: u5, rs1: u5, rs2: u5, rs3: u5, rm: u3 },
    FMSUB_S: struct { rd: u5, rs1: u5, rs2: u5, rs3: u5, rm: u3 },
    FNMSUB_S: struct { rd: u5, rs1: u5, rs2: u5, rs3: u5, rm: u3 },
    FNMADD_S: struct { rd: u5, rs1: u5, rs2: u5, rs3: u5, rm: u3 },

    // Floating DIVSQRT
    FDIV_S: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    FSQRT_S: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },

    // Floating NONCOMP
    FMINMAX_S: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    FSGNJ_S: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    FCMP_S: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    FCLASS_S: struct { rd: u5, rs1: u5, rm: u3 },

    // Floating CONV
    FCVT_W_S: struct { rd: u5, rs1: u5, rm: u3 },
    FCVT_WU_S: struct { rd: u5, rs1: u5, rm: u3 },
    FCVT_S_W: struct { rd: u5, rs1: u5, rm: u3 },
    FCVT_S_WU: struct { rd: u5, rs1: u5, rm: u3 },

    // Floating-integer move
    FMV_W_X: struct { rd: u5, rs1: u5, rm: u3 },
    FMV_X_W: struct { rd: u5, rs1: u5, rm: u3 },
};

/// Decodes `w`, or returns null when no row matches. Rows are tried most
/// fixed bits first, so the most specific match wins (golden/CONTRACT.md §3).
pub fn decode(w: u32) ?Instruction {
    if (w & 0xffffffff == 0x0000400b) return .{ .YIELD = {} };
    if (w & 0xffffffff == 0x00002013) return .{ .WDONE = .{ .imm = immI(w) } };
    if (w & 0xfff0707f == 0xe0001053) return .{ .FCLASS_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0707f == 0xf0000053) return .{ .FMV_W_X = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0707f == 0xe0000053) return .{ .FMV_X_W = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0007f == 0x58000053) return .{ .FSQRT_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0xfff0007f == 0xc0000053) return .{ .FCVT_W_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0007f == 0xc0100053) return .{ .FCVT_WU_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0007f == 0xd0000053) return .{ .FCVT_S_W = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0007f == 0xd0100053) return .{ .FCVT_S_WU = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfe00707f == 0x00000033) return .{ .ADD = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x20002033) return .{ .SH1ADD = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x20004033) return .{ .SH2ADD = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x20006033) return .{ .SH3ADD = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x40000033) return .{ .SUB = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00001033) return .{ .SLL = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00002033) return .{ .SLT = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00003033) return .{ .SLTU = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00004033) return .{ .XOR = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00005033) return .{ .SRL = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x40005033) return .{ .SRA = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00006033) return .{ .OR = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00007033) return .{ .AND = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00001013) return .{ .SLLI = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0xfe00707f == 0x00005013) return .{ .SRLI = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0xfe00707f == 0x40005013) return .{ .SRAI = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0xfe00707f == 0x0e005033) return .{ .CZERO_EQZ = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x0e007033) return .{ .CZERO_NEZ = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00607f == 0x28000053) return .{ .FMINMAX_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0x00007fff == 0x0000100b) return .{ .BINIT = .{ .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x00007fff == 0x0000200b) return .{ .BSYNC_0 = .{ .rs1 = reg(w, 15), .imm = immI(w) } };
    // funct3 = 011 is not a RISC-V encoding (FINDINGS.md F7).
    if (w & 0xfe00407f == 0x20000053 and funct3(w) != 0b011) return .{ .FSGNJ_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    // funct3 = 011 is not a RISC-V encoding (FINDINGS.md F7).
    if (w & 0xfe00407f == 0xa0000053 and funct3(w) != 0b011) return .{ .FCMP_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0xfe00007f == 0x00000053) return .{ .FADD_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0xfe00007f == 0x08000053) return .{ .FSUB_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0xfe00007f == 0x10000053) return .{ .FMUL_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0xfe00007f == 0x18000053) return .{ .FDIV_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0x0000707f == 0x00000013) return .{ .ADDI = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00002013) return .{ .SLTI = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00003013) return .{ .SLTIU = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00004013) return .{ .XORI = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00006013) return .{ .ORI = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00007013) return .{ .ANDI = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00000063) return .{ .BEQ = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00001063) return .{ .BNE = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00004063) return .{ .BLT = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00005063) return .{ .BGE = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00006063) return .{ .BLTU = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00007063) return .{ .BGEU = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00000067) return .{ .JALR = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00000003) return .{ .LB = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00001003) return .{ .LH = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00002003) return .{ .LW = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00002007) return .{ .FLW = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00004003) return .{ .LBU = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00005003) return .{ .LHU = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00000023) return .{ .SB = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immS(w) } };
    if (w & 0x0000707f == 0x00001023) return .{ .SH = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immS(w) } };
    if (w & 0x0000707f == 0x00002023) return .{ .SW = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immS(w) } };
    if (w & 0x0000707f == 0x00002027) return .{ .FSW = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w), .imm = immS(w) } };
    if (w & 0x0000707f == 0x0000000f) return .{ .FENCE = {} };
    // SYSTEM (1110011) with funct3 001/010/011, 101/110/111 (Zicsr). funct3
    // 000 and 100 are not CSR accesses and do not decode here.
    if (w & 0x0000707f == 0x00001073) return .{ .CSRRW = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0000707f == 0x00002073) return .{ .CSRRS = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0000707f == 0x00003073) return .{ .CSRRC = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0000707f == 0x00005073) return .{ .CSRRWI = .{ .rd = reg(w, 7), .uimm = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0000707f == 0x00006073) return .{ .CSRRSI = .{ .rd = reg(w, 7), .uimm = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0000707f == 0x00007073) return .{ .CSRRCI = .{ .rd = reg(w, 7), .uimm = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0600007f == 0x00000043) return .{ .FMADD_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rs3 = reg(w, 27), .rm = funct3(w) } };
    if (w & 0x0600007f == 0x00000047) return .{ .FMSUB_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rs3 = reg(w, 27), .rm = funct3(w) } };
    if (w & 0x0600007f == 0x0000004b) return .{ .FNMSUB_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rs3 = reg(w, 27), .rm = funct3(w) } };
    if (w & 0x0600007f == 0x0000004f) return .{ .FNMADD_S = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rs3 = reg(w, 27), .rm = funct3(w) } };
    if (w & 0x0000007f == 0x0000006f) return .{ .JAL = .{ .rd = reg(w, 7), .imm = immJ(w) } };
    if (w & 0x0000007f == 0x00000037) return .{ .LUI = .{ .rd = reg(w, 7), .imm = immU(w) } };
    if (w & 0x0000007f == 0x00000017) return .{ .AUIPC = .{ .rd = reg(w, 7), .imm = immU(w) } };
    return null;
}
