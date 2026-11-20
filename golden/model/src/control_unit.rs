//! Instruction decode: an enum of the instructions, with their operands, and
//! `decode`.
//!
//! Started from control_unit/generate.py's output for control_unit.csv; now
//! maintained by hand. Rows for custom instructions are the previous variant's
//! encodings: placeholders until `golden/spec/` specifies them
//! (golden/CONTRACT.md §3).
//!
//! Register operands and `rm` are 5- and 3-bit fields held in a `u8`; only
//! `decode` builds them, from the bits of the word.

fn reg(word: u32, lsb: u32) -> u8 {
    ((word >> lsb) & 0x1F) as u8
}

fn funct3(word: u32) -> u8 {
    ((word >> 12) & 0x7) as u8
}

fn csr(word: u32) -> Csr {
    Csr((word >> 20) as u16)
}

/// A CSR number (bits 31:20 of a Zicsr instruction). Named values are the CSRs
/// the model knows of; any other number is still representable, and whether
/// it exists is decided when the instruction executes.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Csr(pub u16);

impl Csr {
    // RISC-V unprivileged ISA, "Zicsr", "CSR Listing" / F "Floating-Point
    // Control and Status Register".
    pub const FFLAGS: Csr = Csr(0x001);
    pub const FRM: Csr = Csr(0x002);
    pub const FCSR: Csr = Csr(0x003);
    // RISC-V unprivileged ISA, "Zicntr" / "Zihpm".
    pub const CYCLE: Csr = Csr(0xC00);
    pub const TIME: Csr = Csr(0xC01);
    pub const INSTRET: Csr = Csr(0xC02);
    pub const HPMCOUNTER3: Csr = Csr(0xC03);
    pub const HPMCOUNTER4: Csr = Csr(0xC04);
    pub const CYCLEH: Csr = Csr(0xC80);
    pub const TIMEH: Csr = Csr(0xC81);
    pub const INSTRETH: Csr = Csr(0xC82);
    pub const HPMCOUNTER3H: Csr = Csr(0xC83);
    pub const HPMCOUNTER4H: Csr = Csr(0xC84);
    // RISC-V privileged ISA, "Machine Hart ID Register".
    pub const MHARTID: Csr = Csr(0xF14);
    // Placeholders: the previous variant's custom CSRs (control_unit.csv's
    // CSR_XWARPID, CSR_XTHRID, CSR_XROLE), until `golden/spec/` specifies them.
    pub const XWARPID: Csr = Csr(0xCC0);
    pub const XTHRID: Csr = Csr(0xCC1);
    pub const XROLE: Csr = Csr(0xCC2);
}

fn sext(value: u32, bits: u32) -> u32 {
    let shift = 32 - bits;
    (((value << shift) as i32) >> shift) as u32
}

// Immediates as the RISC-V unprivileged ISA's "Immediate Encoding Variants"
// define them, sign-extended to 32 bits and held as the raw u32 pattern.
fn imm_i(w: u32) -> u32 {
    sext(w >> 20, 12)
}
fn imm_s(w: u32) -> u32 {
    sext(((w >> 25) << 5) | ((w >> 7) & 0x1f), 12)
}
fn imm_b(w: u32) -> u32 {
    sext(
        ((w >> 31) << 12) | (((w >> 7) & 0x1) << 11) | (((w >> 25) & 0x3f) << 5) | (((w >> 8) & 0xf) << 1),
        13,
    )
}
fn imm_u(w: u32) -> u32 {
    w & 0xfffff000
}
fn imm_j(w: u32) -> u32 {
    sext(
        ((w >> 31) << 20) | (((w >> 12) & 0xff) << 12) | (((w >> 20) & 0x1) << 11) | (((w >> 21) & 0x3ff) << 1),
        21,
    )
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Instruction {
    // OP-type instructions
    Add { rd: u8, rs1: u8, rs2: u8 },
    Sh1add { rd: u8, rs1: u8, rs2: u8 },
    Sh2add { rd: u8, rs1: u8, rs2: u8 },
    Sh3add { rd: u8, rs1: u8, rs2: u8 },
    Sub { rd: u8, rs1: u8, rs2: u8 },
    Sll { rd: u8, rs1: u8, rs2: u8 },
    Slt { rd: u8, rs1: u8, rs2: u8 },
    Sltu { rd: u8, rs1: u8, rs2: u8 },
    Xor { rd: u8, rs1: u8, rs2: u8 },
    Srl { rd: u8, rs1: u8, rs2: u8 },
    Sra { rd: u8, rs1: u8, rs2: u8 },
    Or { rd: u8, rs1: u8, rs2: u8 },
    And { rd: u8, rs1: u8, rs2: u8 },

    // OP-IMM-type instructions
    Addi { rd: u8, rs1: u8, imm: u32 },
    Slli { rd: u8, rs1: u8, imm: u32 },
    Slti { rd: u8, rs1: u8, imm: u32 },
    Sltiu { rd: u8, rs1: u8, imm: u32 },
    Xori { rd: u8, rs1: u8, imm: u32 },
    Srli { rd: u8, rs1: u8, imm: u32 },
    Srai { rd: u8, rs1: u8, imm: u32 },
    Ori { rd: u8, rs1: u8, imm: u32 },
    Andi { rd: u8, rs1: u8, imm: u32 },

    // Branch operations
    Beq { rs1: u8, rs2: u8, imm: u32 },
    Bne { rs1: u8, rs2: u8, imm: u32 },
    Blt { rs1: u8, rs2: u8, imm: u32 },
    Bge { rs1: u8, rs2: u8, imm: u32 },
    Bltu { rs1: u8, rs2: u8, imm: u32 },
    Bgeu { rs1: u8, rs2: u8, imm: u32 },

    // Jump operations
    Jal { rd: u8, imm: u32 },
    Jalr { rd: u8, rs1: u8, imm: u32 },

    // LUI and AUIPC
    Lui { rd: u8, imm: u32 },
    Auipc { rd: u8, imm: u32 },

    // Memory operations
    Lb { rd: u8, rs1: u8, imm: u32 },
    Lh { rd: u8, rs1: u8, imm: u32 },
    Lw { rd: u8, rs1: u8, imm: u32 },
    Flw { rd: u8, rs1: u8, rm: u8, imm: u32 },
    Lbu { rd: u8, rs1: u8, imm: u32 },
    Lhu { rd: u8, rs1: u8, imm: u32 },
    Sb { rs1: u8, rs2: u8, imm: u32 },
    Sh { rs1: u8, rs2: u8, imm: u32 },
    Sw { rs1: u8, rs2: u8, imm: u32 },
    Fsw { rs1: u8, rs2: u8, rm: u8, imm: u32 },

    // Barrier operations
    Binit { rs1: u8, imm: u32 },
    Bsync0 { rs1: u8, imm: u32 },
    Yield,

    // CSR operations (RISC-V unprivileged ISA, "Zicsr")
    Csrrw { rd: u8, rs1: u8, csr: Csr },
    Csrrs { rd: u8, rs1: u8, csr: Csr },
    Csrrc { rd: u8, rs1: u8, csr: Csr },
    Csrrwi { rd: u8, uimm: u8, csr: Csr },
    Csrrsi { rd: u8, uimm: u8, csr: Csr },
    Csrrci { rd: u8, uimm: u8, csr: Csr },

    // FENCE operations (NOP)
    Fence,

    // Zicond operations
    CzeroEqz { rd: u8, rs1: u8, rs2: u8 },
    CzeroNez { rd: u8, rs1: u8, rs2: u8 },

    // Done signal (slti x0, x0, 0)
    Wdone { imm: u32 },

    // Floating non-FMA ADDMUL
    FaddS { rd: u8, rs1: u8, rs2: u8, rm: u8 },
    FsubS { rd: u8, rs1: u8, rs2: u8, rm: u8 },
    FmulS { rd: u8, rs1: u8, rs2: u8, rm: u8 },

    // Floating FMA
    FmaddS { rd: u8, rs1: u8, rs2: u8, rs3: u8, rm: u8 },
    FmsubS { rd: u8, rs1: u8, rs2: u8, rs3: u8, rm: u8 },
    FnmsubS { rd: u8, rs1: u8, rs2: u8, rs3: u8, rm: u8 },
    FnmaddS { rd: u8, rs1: u8, rs2: u8, rs3: u8, rm: u8 },

    // Floating DIVSQRT
    FdivS { rd: u8, rs1: u8, rs2: u8, rm: u8 },
    FsqrtS { rd: u8, rs1: u8, rs2: u8, rm: u8 },

    // Floating NONCOMP
    FminmaxS { rd: u8, rs1: u8, rs2: u8, rm: u8 },
    FsgnjS { rd: u8, rs1: u8, rs2: u8, rm: u8 },
    FcmpS { rd: u8, rs1: u8, rs2: u8, rm: u8 },
    FclassS { rd: u8, rs1: u8, rm: u8 },

    // Floating CONV
    FcvtWS { rd: u8, rs1: u8, rm: u8 },
    FcvtWuS { rd: u8, rs1: u8, rm: u8 },
    FcvtSW { rd: u8, rs1: u8, rm: u8 },
    FcvtSWu { rd: u8, rs1: u8, rm: u8 },

    // Floating-integer move
    FmvWX { rd: u8, rs1: u8, rm: u8 },
    FmvXW { rd: u8, rs1: u8, rm: u8 },
}

/// Decodes `w`, or returns `None` when no row matches. Rows are tried most
/// fixed bits first, so the most specific match wins (golden/CONTRACT.md §3).
pub fn decode(w: u32) -> Option<Instruction> {
    use Instruction::*;

    if w & 0xffffffff == 0x0000400b {
        return Some(Yield);
    }
    if w & 0xffffffff == 0x00002013 {
        return Some(Wdone { imm: imm_i(w) });
    }
    if w & 0xfff0707f == 0xe0001053 {
        return Some(FclassS { rd: reg(w, 7), rs1: reg(w, 15), rm: funct3(w) });
    }
    if w & 0xfff0707f == 0xf0000053 {
        return Some(FmvWX { rd: reg(w, 7), rs1: reg(w, 15), rm: funct3(w) });
    }
    if w & 0xfff0707f == 0xe0000053 {
        return Some(FmvXW { rd: reg(w, 7), rs1: reg(w, 15), rm: funct3(w) });
    }
    if w & 0xfff0007f == 0x58000053 {
        return Some(FsqrtS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rm: funct3(w) });
    }
    if w & 0xfff0007f == 0xc0000053 {
        return Some(FcvtWS { rd: reg(w, 7), rs1: reg(w, 15), rm: funct3(w) });
    }
    if w & 0xfff0007f == 0xc0100053 {
        return Some(FcvtWuS { rd: reg(w, 7), rs1: reg(w, 15), rm: funct3(w) });
    }
    if w & 0xfff0007f == 0xd0000053 {
        return Some(FcvtSW { rd: reg(w, 7), rs1: reg(w, 15), rm: funct3(w) });
    }
    if w & 0xfff0007f == 0xd0100053 {
        return Some(FcvtSWu { rd: reg(w, 7), rs1: reg(w, 15), rm: funct3(w) });
    }
    if w & 0xfe00707f == 0x00000033 {
        return Some(Add { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x20002033 {
        return Some(Sh1add { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x20004033 {
        return Some(Sh2add { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x20006033 {
        return Some(Sh3add { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x40000033 {
        return Some(Sub { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x00001033 {
        return Some(Sll { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x00002033 {
        return Some(Slt { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x00003033 {
        return Some(Sltu { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x00004033 {
        return Some(Xor { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x00005033 {
        return Some(Srl { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x40005033 {
        return Some(Sra { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x00006033 {
        return Some(Or { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x00007033 {
        return Some(And { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x00001013 {
        return Some(Slli { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0xfe00707f == 0x00005013 {
        return Some(Srli { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0xfe00707f == 0x40005013 {
        return Some(Srai { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0xfe00707f == 0x0e005033 {
        return Some(CzeroEqz { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00707f == 0x0e007033 {
        return Some(CzeroNez { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20) });
    }
    if w & 0xfe00607f == 0x28000053 {
        return Some(FminmaxS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rm: funct3(w) });
    }
    if w & 0x00007fff == 0x0000100b {
        return Some(Binit { rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x00007fff == 0x0000200b {
        return Some(Bsync0 { rs1: reg(w, 15), imm: imm_i(w) });
    }
    // funct3 = 011 is not a RISC-V encoding (FINDINGS.md F7).
    if w & 0xfe00407f == 0x20000053 && funct3(w) != 0b011 {
        return Some(FsgnjS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rm: funct3(w) });
    }
    // funct3 = 011 is not a RISC-V encoding (FINDINGS.md F7).
    if w & 0xfe00407f == 0xa0000053 && funct3(w) != 0b011 {
        return Some(FcmpS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rm: funct3(w) });
    }
    if w & 0xfe00007f == 0x00000053 {
        return Some(FaddS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rm: funct3(w) });
    }
    if w & 0xfe00007f == 0x08000053 {
        return Some(FsubS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rm: funct3(w) });
    }
    if w & 0xfe00007f == 0x10000053 {
        return Some(FmulS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rm: funct3(w) });
    }
    if w & 0xfe00007f == 0x18000053 {
        return Some(FdivS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rm: funct3(w) });
    }
    if w & 0x0000707f == 0x00000013 {
        return Some(Addi { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00002013 {
        return Some(Slti { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00003013 {
        return Some(Sltiu { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00004013 {
        return Some(Xori { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00006013 {
        return Some(Ori { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00007013 {
        return Some(Andi { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00000063 {
        return Some(Beq { rs1: reg(w, 15), rs2: reg(w, 20), imm: imm_b(w) });
    }
    if w & 0x0000707f == 0x00001063 {
        return Some(Bne { rs1: reg(w, 15), rs2: reg(w, 20), imm: imm_b(w) });
    }
    if w & 0x0000707f == 0x00004063 {
        return Some(Blt { rs1: reg(w, 15), rs2: reg(w, 20), imm: imm_b(w) });
    }
    if w & 0x0000707f == 0x00005063 {
        return Some(Bge { rs1: reg(w, 15), rs2: reg(w, 20), imm: imm_b(w) });
    }
    if w & 0x0000707f == 0x00006063 {
        return Some(Bltu { rs1: reg(w, 15), rs2: reg(w, 20), imm: imm_b(w) });
    }
    if w & 0x0000707f == 0x00007063 {
        return Some(Bgeu { rs1: reg(w, 15), rs2: reg(w, 20), imm: imm_b(w) });
    }
    if w & 0x0000707f == 0x00000067 {
        return Some(Jalr { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00000003 {
        return Some(Lb { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00001003 {
        return Some(Lh { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00002003 {
        return Some(Lw { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00002007 {
        return Some(Flw { rd: reg(w, 7), rs1: reg(w, 15), rm: funct3(w), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00004003 {
        return Some(Lbu { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00005003 {
        return Some(Lhu { rd: reg(w, 7), rs1: reg(w, 15), imm: imm_i(w) });
    }
    if w & 0x0000707f == 0x00000023 {
        return Some(Sb { rs1: reg(w, 15), rs2: reg(w, 20), imm: imm_s(w) });
    }
    if w & 0x0000707f == 0x00001023 {
        return Some(Sh { rs1: reg(w, 15), rs2: reg(w, 20), imm: imm_s(w) });
    }
    if w & 0x0000707f == 0x00002023 {
        return Some(Sw { rs1: reg(w, 15), rs2: reg(w, 20), imm: imm_s(w) });
    }
    if w & 0x0000707f == 0x00002027 {
        return Some(Fsw { rs1: reg(w, 15), rs2: reg(w, 20), rm: funct3(w), imm: imm_s(w) });
    }
    if w & 0x0000707f == 0x0000000f {
        return Some(Fence);
    }
    // SYSTEM (1110011) with funct3 001/010/011, 101/110/111 (Zicsr). funct3
    // 000 and 100 are not CSR accesses and do not decode here.
    if w & 0x0000707f == 0x00001073 {
        return Some(Csrrw { rd: reg(w, 7), rs1: reg(w, 15), csr: csr(w) });
    }
    if w & 0x0000707f == 0x00002073 {
        return Some(Csrrs { rd: reg(w, 7), rs1: reg(w, 15), csr: csr(w) });
    }
    if w & 0x0000707f == 0x00003073 {
        return Some(Csrrc { rd: reg(w, 7), rs1: reg(w, 15), csr: csr(w) });
    }
    if w & 0x0000707f == 0x00005073 {
        return Some(Csrrwi { rd: reg(w, 7), uimm: reg(w, 15), csr: csr(w) });
    }
    if w & 0x0000707f == 0x00006073 {
        return Some(Csrrsi { rd: reg(w, 7), uimm: reg(w, 15), csr: csr(w) });
    }
    if w & 0x0000707f == 0x00007073 {
        return Some(Csrrci { rd: reg(w, 7), uimm: reg(w, 15), csr: csr(w) });
    }
    if w & 0x0600007f == 0x00000043 {
        return Some(FmaddS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rs3: reg(w, 27), rm: funct3(w) });
    }
    if w & 0x0600007f == 0x00000047 {
        return Some(FmsubS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rs3: reg(w, 27), rm: funct3(w) });
    }
    if w & 0x0600007f == 0x0000004b {
        return Some(FnmsubS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rs3: reg(w, 27), rm: funct3(w) });
    }
    if w & 0x0600007f == 0x0000004f {
        return Some(FnmaddS { rd: reg(w, 7), rs1: reg(w, 15), rs2: reg(w, 20), rs3: reg(w, 27), rm: funct3(w) });
    }
    if w & 0x0000007f == 0x0000006f {
        return Some(Jal { rd: reg(w, 7), imm: imm_j(w) });
    }
    if w & 0x0000007f == 0x00000037 {
        return Some(Lui { rd: reg(w, 7), imm: imm_u(w) });
    }
    if w & 0x0000007f == 0x00000017 {
        return Some(Auipc { rd: reg(w, 7), imm: imm_u(w) });
    }
    None
}

#[cfg(test)]
mod tests {
    // The words below are encoded by hand from the RISC-V unprivileged ISA's
    // instruction formats; they test what control_unit.rs makes of them.

    use super::Instruction::*;
    use super::*;

    #[test]
    fn r_type_add_x1_x2_x3() {
        assert_eq!(decode(0x003100B3), Some(Add { rd: 1, rs1: 2, rs2: 3 }));
    }

    #[test]
    fn i_type_addi_x1_x0_minus_1() {
        assert_eq!(decode(0xFFF00093), Some(Addi { rd: 1, rs1: 0, imm: 0xFFFF_FFFF }));
    }

    #[test]
    fn s_type_sw_x2_minus_4_x1() {
        assert_eq!(decode(0xFE20AE23), Some(Sw { rs1: 1, rs2: 2, imm: 0xFFFF_FFFC }));
    }

    #[test]
    fn b_type_beq_x1_x2_minus_4() {
        assert_eq!(decode(0xFE208EE3), Some(Beq { rs1: 1, rs2: 2, imm: 0xFFFF_FFFC }));
    }

    #[test]
    fn u_type_lui_x1_0x12345() {
        assert_eq!(decode(0x123450B7), Some(Lui { rd: 1, imm: 0x1234_5000 }));
    }

    #[test]
    fn j_type_jal_x0_minus_8() {
        assert_eq!(decode(0xFF9FF06F), Some(Jal { rd: 0, imm: 0xFFFF_FFF8 }));
    }

    #[test]
    fn r4_type_fmadd_s_f1_f2_f3_f4() {
        assert_eq!(decode(0x203100C3), Some(FmaddS { rd: 1, rs1: 2, rs2: 3, rs3: 4, rm: 0 }));
    }

    #[test]
    fn fcvt_w_s_x1_f2_mixes_register_files() {
        assert_eq!(decode(0xC00100D3), Some(FcvtWS { rd: 1, rs1: 2, rm: 0 }));
    }

    #[test]
    fn the_more_specific_of_two_overlapping_patterns_wins() {
        // slti x0, x0, 0 matches both SLTI and the CSV's WDONE row.
        assert_eq!(decode(0x00002013), Some(Wdone { imm: 0 }));
        assert_eq!(decode(0x00002093), Some(Slti { rd: 1, rs1: 0, imm: 0 }));
    }

    #[test]
    fn a_16_bit_encoding_decodes_to_nothing() {
        assert_eq!(decode(0x0000_0001), None);
    }

    #[test]
    fn csrr_x1_mhartid_is_csrrs_with_rs1_x0() {
        assert_eq!(decode(0xF14020F3), Some(Csrrs { rd: 1, rs1: 0, csr: Csr::MHARTID }));
    }

    #[test]
    fn csrrwi_x0_fflags_5_carries_the_immediate() {
        assert_eq!(decode(0x0012D073), Some(Csrrwi { rd: 0, uimm: 5, csr: Csr::FFLAGS }));
    }

    #[test]
    fn an_unnamed_csr_number_still_decodes() {
        assert_eq!(decode(0x7C0020F3), Some(Csrrs { rd: 1, rs1: 0, csr: Csr(0x7C0) }));
    }

    #[test]
    fn ecall_system_funct3_000_is_not_a_csr_access() {
        assert_eq!(decode(0x0000_0073), None);
    }

    #[test]
    fn fsgnj_and_fcmp_with_funct3_011_do_not_decode() {
        // fsgnj-like and feq-like words with funct3 = 011 (FINDINGS.md F7).
        assert_eq!(decode(0x2020B0D3), None);
        assert_eq!(decode(0xA020B0D3), None);
    }
}
