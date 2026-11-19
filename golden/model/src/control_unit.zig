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
    add: struct { rd: u5, rs1: u5, rs2: u5 },
    sh1add: struct { rd: u5, rs1: u5, rs2: u5 },
    sh2add: struct { rd: u5, rs1: u5, rs2: u5 },
    sh3add: struct { rd: u5, rs1: u5, rs2: u5 },
    sub: struct { rd: u5, rs1: u5, rs2: u5 },
    sll: struct { rd: u5, rs1: u5, rs2: u5 },
    slt: struct { rd: u5, rs1: u5, rs2: u5 },
    sltu: struct { rd: u5, rs1: u5, rs2: u5 },
    xor: struct { rd: u5, rs1: u5, rs2: u5 },
    srl: struct { rd: u5, rs1: u5, rs2: u5 },
    sra: struct { rd: u5, rs1: u5, rs2: u5 },
    @"or": struct { rd: u5, rs1: u5, rs2: u5 },
    @"and": struct { rd: u5, rs1: u5, rs2: u5 },

    // OP-IMM-type instructions
    addi: struct { rd: u5, rs1: u5, imm: u32 },
    slli: struct { rd: u5, rs1: u5, imm: u32 },
    slti: struct { rd: u5, rs1: u5, imm: u32 },
    sltiu: struct { rd: u5, rs1: u5, imm: u32 },
    xori: struct { rd: u5, rs1: u5, imm: u32 },
    srli: struct { rd: u5, rs1: u5, imm: u32 },
    srai: struct { rd: u5, rs1: u5, imm: u32 },
    ori: struct { rd: u5, rs1: u5, imm: u32 },
    andi: struct { rd: u5, rs1: u5, imm: u32 },

    // Branch operations
    beq: struct { rs1: u5, rs2: u5, imm: u32 },
    bne: struct { rs1: u5, rs2: u5, imm: u32 },
    blt: struct { rs1: u5, rs2: u5, imm: u32 },
    bge: struct { rs1: u5, rs2: u5, imm: u32 },
    bltu: struct { rs1: u5, rs2: u5, imm: u32 },
    bgeu: struct { rs1: u5, rs2: u5, imm: u32 },

    // Jump operations
    jal: struct { rd: u5, imm: u32 },
    jalr: struct { rd: u5, rs1: u5, imm: u32 },

    // LUI and AUIPC`
    lui: struct { rd: u5, imm: u32 },
    auipc: struct { rd: u5, imm: u32 },

    // Memory operations
    lb: struct { rd: u5, rs1: u5, imm: u32 },
    lh: struct { rd: u5, rs1: u5, imm: u32 },
    lw: struct { rd: u5, rs1: u5, imm: u32 },
    flw: struct { rd: u5, rs1: u5, rm: u3, imm: u32 },
    lbu: struct { rd: u5, rs1: u5, imm: u32 },
    lhu: struct { rd: u5, rs1: u5, imm: u32 },
    sb: struct { rs1: u5, rs2: u5, imm: u32 },
    sh: struct { rs1: u5, rs2: u5, imm: u32 },
    sw: struct { rs1: u5, rs2: u5, imm: u32 },
    fsw: struct { rs1: u5, rs2: u5, rm: u3, imm: u32 },

    // Barrier operations
    binit: struct { rs1: u5, imm: u32 },
    bsync_0: struct { rs1: u5, imm: u32 },
    yield: void,

    // CSR operations (RISC-V unprivileged ISA, "Zicsr")
    csrrw: struct { rd: u5, rs1: u5, csr: Csr },
    csrrs: struct { rd: u5, rs1: u5, csr: Csr },
    csrrc: struct { rd: u5, rs1: u5, csr: Csr },
    csrrwi: struct { rd: u5, uimm: u5, csr: Csr },
    csrrsi: struct { rd: u5, uimm: u5, csr: Csr },
    csrrci: struct { rd: u5, uimm: u5, csr: Csr },

    // FENCE operations (NOP)
    fence: void,

    // Zicond operations
    czero_eqz: struct { rd: u5, rs1: u5, rs2: u5 },
    czero_nez: struct { rd: u5, rs1: u5, rs2: u5 },

    // Done signal (slti x0, x0, 0)
    wdone: struct { imm: u32 },

    // Floating non-FMA ADDMUL
    fadd_s: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    fsub_s: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    fmul_s: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },

    // Floating FMA
    fmadd_s: struct { rd: u5, rs1: u5, rs2: u5, rs3: u5, rm: u3 },
    fmsub_s: struct { rd: u5, rs1: u5, rs2: u5, rs3: u5, rm: u3 },
    fnmsub_s: struct { rd: u5, rs1: u5, rs2: u5, rs3: u5, rm: u3 },
    fnmadd_s: struct { rd: u5, rs1: u5, rs2: u5, rs3: u5, rm: u3 },

    // Floating DIVSQRT
    fdiv_s: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    fsqrt_s: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },

    // Floating NONCOMP
    fminmax_s: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    fsgnj_s: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    fcmp_s: struct { rd: u5, rs1: u5, rs2: u5, rm: u3 },
    fclass_s: struct { rd: u5, rs1: u5, rm: u3 },

    // Floating CONV
    fcvt_w_s: struct { rd: u5, rs1: u5, rm: u3 },
    fcvt_wu_s: struct { rd: u5, rs1: u5, rm: u3 },
    fcvt_s_w: struct { rd: u5, rs1: u5, rm: u3 },
    fcvt_s_wu: struct { rd: u5, rs1: u5, rm: u3 },

    // Floating-integer move
    fmv_w_x: struct { rd: u5, rs1: u5, rm: u3 },
    fmv_x_w: struct { rd: u5, rs1: u5, rm: u3 },
};

/// Decodes `w`, or returns null when no row matches. Rows are tried most
/// fixed bits first, so the most specific match wins (golden/CONTRACT.md §3).
pub fn decode(w: u32) ?Instruction {
    if (w & 0xffffffff == 0x0000400b) return .{ .yield = {} };
    if (w & 0xffffffff == 0x00002013) return .{ .wdone = .{ .imm = immI(w) } };
    if (w & 0xfff0707f == 0xe0001053) return .{ .fclass_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0707f == 0xf0000053) return .{ .fmv_w_x = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0707f == 0xe0000053) return .{ .fmv_x_w = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0007f == 0x58000053) return .{ .fsqrt_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0xfff0007f == 0xc0000053) return .{ .fcvt_w_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0007f == 0xc0100053) return .{ .fcvt_wu_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0007f == 0xd0000053) return .{ .fcvt_s_w = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfff0007f == 0xd0100053) return .{ .fcvt_s_wu = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w) } };
    if (w & 0xfe00707f == 0x00000033) return .{ .add = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x20002033) return .{ .sh1add = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x20004033) return .{ .sh2add = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x20006033) return .{ .sh3add = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x40000033) return .{ .sub = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00001033) return .{ .sll = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00002033) return .{ .slt = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00003033) return .{ .sltu = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00004033) return .{ .xor = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00005033) return .{ .srl = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x40005033) return .{ .sra = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00006033) return .{ .@"or" = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00007033) return .{ .@"and" = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x00001013) return .{ .slli = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0xfe00707f == 0x00005013) return .{ .srli = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0xfe00707f == 0x40005013) return .{ .srai = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0xfe00707f == 0x0e005033) return .{ .czero_eqz = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00707f == 0x0e007033) return .{ .czero_nez = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20) } };
    if (w & 0xfe00607f == 0x28000053) return .{ .fminmax_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0x00007fff == 0x0000100b) return .{ .binit = .{ .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x00007fff == 0x0000200b) return .{ .bsync_0 = .{ .rs1 = reg(w, 15), .imm = immI(w) } };
    // funct3 = 011 is not a RISC-V encoding (FINDINGS.md F7).
    if (w & 0xfe00407f == 0x20000053 and funct3(w) != 0b011) return .{ .fsgnj_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    // funct3 = 011 is not a RISC-V encoding (FINDINGS.md F7).
    if (w & 0xfe00407f == 0xa0000053 and funct3(w) != 0b011) return .{ .fcmp_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0xfe00007f == 0x00000053) return .{ .fadd_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0xfe00007f == 0x08000053) return .{ .fsub_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0xfe00007f == 0x10000053) return .{ .fmul_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0xfe00007f == 0x18000053) return .{ .fdiv_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w) } };
    if (w & 0x0000707f == 0x00000013) return .{ .addi = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00002013) return .{ .slti = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00003013) return .{ .sltiu = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00004013) return .{ .xori = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00006013) return .{ .ori = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00007013) return .{ .andi = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00000063) return .{ .beq = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00001063) return .{ .bne = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00004063) return .{ .blt = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00005063) return .{ .bge = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00006063) return .{ .bltu = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00007063) return .{ .bgeu = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immB(w) } };
    if (w & 0x0000707f == 0x00000067) return .{ .jalr = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00000003) return .{ .lb = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00001003) return .{ .lh = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00002003) return .{ .lw = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00002007) return .{ .flw = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rm = funct3(w), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00004003) return .{ .lbu = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00005003) return .{ .lhu = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .imm = immI(w) } };
    if (w & 0x0000707f == 0x00000023) return .{ .sb = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immS(w) } };
    if (w & 0x0000707f == 0x00001023) return .{ .sh = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immS(w) } };
    if (w & 0x0000707f == 0x00002023) return .{ .sw = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .imm = immS(w) } };
    if (w & 0x0000707f == 0x00002027) return .{ .fsw = .{ .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rm = funct3(w), .imm = immS(w) } };
    if (w & 0x0000707f == 0x0000000f) return .{ .fence = {} };
    // SYSTEM (1110011) with funct3 001/010/011, 101/110/111 (Zicsr). funct3
    // 000 and 100 are not CSR accesses and do not decode here.
    if (w & 0x0000707f == 0x00001073) return .{ .csrrw = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0000707f == 0x00002073) return .{ .csrrs = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0000707f == 0x00003073) return .{ .csrrc = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0000707f == 0x00005073) return .{ .csrrwi = .{ .rd = reg(w, 7), .uimm = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0000707f == 0x00006073) return .{ .csrrsi = .{ .rd = reg(w, 7), .uimm = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0000707f == 0x00007073) return .{ .csrrci = .{ .rd = reg(w, 7), .uimm = reg(w, 15), .csr = csr(w) } };
    if (w & 0x0600007f == 0x00000043) return .{ .fmadd_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rs3 = reg(w, 27), .rm = funct3(w) } };
    if (w & 0x0600007f == 0x00000047) return .{ .fmsub_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rs3 = reg(w, 27), .rm = funct3(w) } };
    if (w & 0x0600007f == 0x0000004b) return .{ .fnmsub_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rs3 = reg(w, 27), .rm = funct3(w) } };
    if (w & 0x0600007f == 0x0000004f) return .{ .fnmadd_s = .{ .rd = reg(w, 7), .rs1 = reg(w, 15), .rs2 = reg(w, 20), .rs3 = reg(w, 27), .rm = funct3(w) } };
    if (w & 0x0000007f == 0x0000006f) return .{ .jal = .{ .rd = reg(w, 7), .imm = immJ(w) } };
    if (w & 0x0000007f == 0x00000037) return .{ .lui = .{ .rd = reg(w, 7), .imm = immU(w) } };
    if (w & 0x0000007f == 0x00000017) return .{ .auipc = .{ .rd = reg(w, 7), .imm = immU(w) } };
    return null;
}

// The words below are encoded by hand from the RISC-V unprivileged ISA's
// instruction formats; they test what control_unit.zig makes of them.

const std = @import("std");

fn expectDecode(expected: Instruction, word: u32) !void {
    try std.testing.expectEqual(@as(?Instruction, expected), decode(word));
}

test "control_unit: R-type, add x1, x2, x3" {
    try expectDecode(.{ .add = .{ .rd = 1, .rs1 = 2, .rs2 = 3 } }, 0x003100B3);
}

test "control_unit: I-type, addi x1, x0, -1" {
    try expectDecode(.{ .addi = .{ .rd = 1, .rs1 = 0, .imm = 0xFFFF_FFFF } }, 0xFFF00093);
}

test "control_unit: S-type, sw x2, -4(x1)" {
    try expectDecode(.{ .sw = .{ .rs1 = 1, .rs2 = 2, .imm = 0xFFFF_FFFC } }, 0xFE20AE23);
}

test "control_unit: B-type, beq x1, x2, -4" {
    try expectDecode(.{ .beq = .{ .rs1 = 1, .rs2 = 2, .imm = 0xFFFF_FFFC } }, 0xFE208EE3);
}

test "control_unit: U-type, lui x1, 0x12345" {
    try expectDecode(.{ .lui = .{ .rd = 1, .imm = 0x1234_5000 } }, 0x123450B7);
}

test "control_unit: J-type, jal x0, -8" {
    try expectDecode(.{ .jal = .{ .rd = 0, .imm = 0xFFFF_FFF8 } }, 0xFF9FF06F);
}

test "control_unit: R4-type, fmadd.s f1, f2, f3, f4" {
    try expectDecode(.{ .fmadd_s = .{ .rd = 1, .rs1 = 2, .rs2 = 3, .rs3 = 4, .rm = 0 } }, 0x203100C3);
}

test "control_unit: fcvt.w.s x1, f2 mixes register files" {
    try expectDecode(.{ .fcvt_w_s = .{ .rd = 1, .rs1 = 2, .rm = 0 } }, 0xC00100D3);
}

test "control_unit: the more specific of two overlapping patterns wins" {
    // slti x0, x0, 0 matches both SLTI and the CSV's WDONE row.
    try expectDecode(.{ .wdone = .{ .imm = 0 } }, 0x00002013);
    try expectDecode(.{ .slti = .{ .rd = 1, .rs1 = 0, .imm = 0 } }, 0x00002093);
}

test "control_unit: a 16-bit encoding decodes to nothing" {
    try std.testing.expectEqual(@as(?Instruction, null), decode(0x0000_0001));
}

test "control_unit: csrr x1, mhartid is CSRRS with rs1 = x0" {
    try expectDecode(.{ .csrrs = .{ .rd = 1, .rs1 = 0, .csr = .mhartid } }, 0xF14020F3);
}

test "control_unit: csrrwi x0, fflags, 5 carries the immediate" {
    try expectDecode(.{ .csrrwi = .{ .rd = 0, .uimm = 5, .csr = .fflags } }, 0x0012D073);
}

test "control_unit: an unnamed CSR number still decodes" {
    try expectDecode(.{ .csrrs = .{ .rd = 1, .rs1 = 0, .csr = @fromBackingInt(0x7C0) } }, 0x7C0020F3);
}

test "control_unit: ecall (SYSTEM, funct3 = 000) is not a CSR access" {
    try std.testing.expectEqual(@as(?Instruction, null), decode(0x0000_0073));
}

test "control_unit: FSGNJ and FCMP with funct3 = 011 do not decode" {
    // fsgnj-like and feq-like words with funct3 = 011 (FINDINGS.md F7).
    try std.testing.expectEqual(@as(?Instruction, null), decode(0x2020B0D3));
    try std.testing.expectEqual(@as(?Instruction, null), decode(0xA020B0D3));
}
