use crate::control_unit::Instruction;
use crate::float;
use crate::int_utils;

/// Acts the spec makes illegal, detected while executing one instruction. The
/// caller reports them as the `illegal` termination (CONTRACT.md §1, §4).
///
/// TODO: Move these somewhere else.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Illegal {
    /// rm = 101 or 110 (`float::Error::ReservedRoundingMode`).
    ReservedRoundingMode,
    /// A field value RISC-V assigns no instruction to, such as funct3 = 011
    /// in FSGNJ_S or FCMP_S (FINDINGS.md F7).
    IllegalInstruction,
}

impl From<float::Error> for Illegal {
    fn from(e: float::Error) -> Illegal {
        match e {
            float::Error::ReservedRoundingMode => Illegal::ReservedRoundingMode,
        }
    }
}

/// The start-up state is unspecified: CONTRACT.md has no rule for it yet.
/// Until it has, registers hold the pattern Zig's `undefined` holds in debug
/// builds, so a test that reads a register before writing it sees an
/// obviously wrong value.
const POISON: u32 = 0xAAAA_AAAA;
const POISON_FFLAGS: u8 = 0xAA;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct XRegs {
    /// x1..x31; x0 is not stored.
    values: [u32; 31],
}

impl XRegs {
    pub fn read(&self, r: u8) -> u32 {
        if r == 0 { 0 } else { self.values[r as usize - 1] }
    }

    pub fn write(&mut self, r: u8, value: u32) {
        if r != 0 {
            self.values[r as usize - 1] = value;
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FRegs {
    values: [u32; 32],
}

impl FRegs {
    pub fn read(&self, r: u8) -> u32 {
        self.values[r as usize]
    }

    pub fn write(&mut self, r: u8, value: u32) {
        self.values[r as usize] = value;
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Thread {
    /// The thread's integer registers.
    pub xregs: XRegs,
    /// The thread's floating-point registers.
    pub fregs: FRegs,
    /// The thread's floating-point flags.
    pub fflags: u8,
    pub warp_id: u16,
    pub thread_id: u16,
}

impl Thread {
    pub fn new(warp_id: u16, thread_id: u16) -> Thread {
        Thread {
            xregs: XRegs { values: [POISON; 31] },
            fregs: FRegs { values: [POISON; 32] },
            fflags: POISON_FFLAGS,
            warp_id,
            thread_id,
        }
    }

    /// Writes a floating-point result to f[rd] and accrues its flags.
    fn retire_float_f(&mut self, rd: u8, r: float::Output) {
        self.fregs.write(rd, r.value);
        self.fflags |= r.flags;
    }

    /// Writes an integer result of a floating-point instruction to x[rd] and
    /// accrues its flags.
    fn retire_float_x(&mut self, rd: u8, r: float::Output) {
        self.xregs.write(rd, r.value);
        self.fflags |= r.flags;
    }

    pub fn step(&mut self, pc: u32, instruction: Instruction) -> Result<(), Illegal> {
        use Instruction::*;
        let x = |t: &Thread, r: u8| t.xregs.read(r);
        let f = |t: &Thread, r: u8| t.fregs.read(r);

        // Semantics from the RISC-V unprivileged ISA: RV32I "Integer
        // Computational Instructions", and Zba for SHnADD. Arithmetic wraps
        // modulo 2^32; shifts use the low 5 bits of the amount.
        match instruction {
            Add { rd, rs1, rs2 } => self.xregs.write(rd, x(self, rs1).wrapping_add(x(self, rs2))),
            Sub { rd, rs1, rs2 } => self.xregs.write(rd, x(self, rs1).wrapping_sub(x(self, rs2))),
            Sh1add { rd, rs1, rs2 } => self.xregs.write(rd, (x(self, rs1) << 1).wrapping_add(x(self, rs2))),
            Sh2add { rd, rs1, rs2 } => self.xregs.write(rd, (x(self, rs1) << 2).wrapping_add(x(self, rs2))),
            Sh3add { rd, rs1, rs2 } => self.xregs.write(rd, (x(self, rs1) << 3).wrapping_add(x(self, rs2))),
            Sll { rd, rs1, rs2 } => self.xregs.write(rd, int_utils::shl(x(self, rs1), x(self, rs2))),
            Srl { rd, rs1, rs2 } => self.xregs.write(rd, int_utils::shr(x(self, rs1), x(self, rs2))),
            Sra { rd, rs1, rs2 } => self.xregs.write(rd, int_utils::sra(x(self, rs1), x(self, rs2))),
            Slt { rd, rs1, rs2 } => self.xregs.write(rd, int_utils::less_signed(x(self, rs1), x(self, rs2))),
            Sltu { rd, rs1, rs2 } => self.xregs.write(rd, int_utils::less_unsigned(x(self, rs1), x(self, rs2))),
            Xor { rd, rs1, rs2 } => self.xregs.write(rd, x(self, rs1) ^ x(self, rs2)),
            Or { rd, rs1, rs2 } => self.xregs.write(rd, x(self, rs1) | x(self, rs2)),
            And { rd, rs1, rs2 } => self.xregs.write(rd, x(self, rs1) & x(self, rs2)),
            Addi { rd, rs1, imm } => self.xregs.write(rd, x(self, rs1).wrapping_add(imm)),
            Slli { rd, rs1, imm } => self.xregs.write(rd, int_utils::shl(x(self, rs1), imm)),
            Srli { rd, rs1, imm } => self.xregs.write(rd, int_utils::shr(x(self, rs1), imm)),
            Srai { rd, rs1, imm } => self.xregs.write(rd, int_utils::sra(x(self, rs1), imm)),
            Slti { rd, rs1, imm } => self.xregs.write(rd, int_utils::less_signed(x(self, rs1), imm)),
            Sltiu { rd, rs1, imm } => self.xregs.write(rd, int_utils::less_unsigned(x(self, rs1), imm)),
            Xori { rd, rs1, imm } => self.xregs.write(rd, x(self, rs1) ^ imm),
            Ori { rd, rs1, imm } => self.xregs.write(rd, x(self, rs1) | imm),
            Andi { rd, rs1, imm } => self.xregs.write(rd, x(self, rs1) & imm),
            Lui { rd, imm } => self.xregs.write(rd, imm),
            Auipc { rd, imm } => self.xregs.write(rd, pc.wrapping_add(imm)),
            CzeroEqz { rd, rs1, rs2 } => self.xregs.write(rd, if x(self, rs2) == 0 { 0 } else { x(self, rs1) }),
            CzeroNez { rd, rs1, rs2 } => self.xregs.write(rd, if x(self, rs2) != 0 { 0 } else { x(self, rs1) }),

            // RISC-V unprivileged ISA, "F" Standard Extension (float.rs).
            FaddS { rd, rs1, rs2, rm } => self.retire_float_f(rd, float::add(f(self, rs1), f(self, rs2), rm)?),
            FsubS { rd, rs1, rs2, rm } => self.retire_float_f(rd, float::sub(f(self, rs1), f(self, rs2), rm)?),
            FmulS { rd, rs1, rs2, rm } => self.retire_float_f(rd, float::mul(f(self, rs1), f(self, rs2), rm)?),
            FdivS { rd, rs1, rs2, rm } => self.retire_float_f(rd, float::div(f(self, rs1), f(self, rs2), rm)?),
            FsqrtS { rd, rs1, rm, .. } => self.retire_float_f(rd, float::sqrt(f(self, rs1), rm)?),
            FmaddS { rd, rs1, rs2, rs3, rm } => {
                self.retire_float_f(rd, float::mul_add(f(self, rs1), f(self, rs2), f(self, rs3), rm)?)
            }
            FmsubS { rd, rs1, rs2, rs3, rm } => {
                self.retire_float_f(rd, float::mul_sub(f(self, rs1), f(self, rs2), f(self, rs3), rm)?)
            }
            FnmsubS { rd, rs1, rs2, rs3, rm } => {
                self.retire_float_f(rd, float::neg_mul_sub(f(self, rs1), f(self, rs2), f(self, rs3), rm)?)
            }
            FnmaddS { rd, rs1, rs2, rs3, rm } => {
                self.retire_float_f(rd, float::neg_mul_add(f(self, rs1), f(self, rs2), f(self, rs3), rm)?)
            }
            FminmaxS { rd, rs1, rs2, rm } => {
                let (a, b) = (f(self, rs1), f(self, rs2));
                let r = match rm {
                    0b000 => float::min(a, b),
                    0b001 => float::max(a, b),
                    _ => return Err(Illegal::IllegalInstruction),
                };
                self.retire_float_f(rd, r)
            }
            FsgnjS { rd, rs1, rs2, rm } => {
                let (a, b) = (f(self, rs1), f(self, rs2));
                let r = match rm {
                    0b000 => float::sgnj(a, b),
                    0b001 => float::sgnjn(a, b),
                    0b010 => float::sgnjx(a, b),
                    _ => return Err(Illegal::IllegalInstruction),
                };
                self.fregs.write(rd, r)
            }
            FcmpS { rd, rs1, rs2, rm } => {
                let (a, b) = (f(self, rs1), f(self, rs2));
                let r = match rm {
                    0b010 => float::eq(a, b),
                    0b001 => float::lt(a, b),
                    0b000 => float::le(a, b),
                    _ => return Err(Illegal::IllegalInstruction),
                };
                self.retire_float_x(rd, r)
            }
            FclassS { rd, rs1, .. } => self.xregs.write(rd, float::classify(f(self, rs1))),
            FcvtWS { rd, rs1, rm } => self.retire_float_x(rd, float::to_i32(f(self, rs1), rm)?),
            FcvtWuS { rd, rs1, rm } => self.retire_float_x(rd, float::to_u32(f(self, rs1), rm)?),
            FcvtSW { rd, rs1, rm } => self.retire_float_f(rd, float::from_i32(x(self, rs1), rm)?),
            FcvtSWu { rd, rs1, rm } => self.retire_float_f(rd, float::from_u32(x(self, rs1), rm)?),
            FmvXW { rd, rs1, .. } => self.xregs.write(rd, f(self, rs1)),
            FmvWX { rd, rs1, .. } => self.fregs.write(rd, x(self, rs1)),

            Csrrw { .. } | Csrrs { .. } | Csrrc { .. } | Csrrwi { .. } | Csrrsi { .. } | Csrrci { .. } => {
                todo!("CSR instructions")
            }

            // These instructions must be dealt with within the warp!
            Beq { .. } | Bne { .. } | Blt { .. } | Bge { .. } | Bltu { .. } | Bgeu { .. }
            | Jal { .. } | Jalr { .. }
            | Lb { .. } | Lh { .. } | Lw { .. } | Lbu { .. } | Lhu { .. } | Flw { .. }
            | Sb { .. } | Sh { .. } | Sw { .. } | Fsw { .. }
            | Binit { .. } | Bsync0 { .. } | Yield
            | Fence
            | Wdone { .. } => unreachable!("{instruction:?} is executed by the warp"),
        }
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    // Instruction semantics are tested next to the pure functions that compute
    // them (int_utils.rs, float.rs); these tests cover what Thread adds: the
    // registers, `pc`, accruing `fflags`, and illegal acts.

    use super::*;
    use crate::control_unit::Instruction::*;
    use crate::softfloat;

    fn test_thread() -> Thread {
        let mut t = Thread::new(0, 0);
        t.xregs.values = [0; 31];
        t.fregs.values = [0; 32];
        t.fflags = 0;
        t
    }

    #[test]
    fn x0_reads_as_zero_and_ignores_writes() {
        let mut t = test_thread();
        t.step(0, Addi { rd: 0, rs1: 0, imm: 5 }).unwrap();
        assert_eq!(t.xregs.read(0), 0);
        t.step(0, Addi { rd: 1, rs1: 0, imm: 7 }).unwrap();
        assert_eq!(t.xregs.read(1), 7);
    }

    #[test]
    fn auipc_adds_the_immediate_to_pc_wrapping() {
        let mut t = test_thread();
        t.step(0xFFFF_F000, Auipc { rd: 1, imm: 0x0000_2000 }).unwrap();
        assert_eq!(t.xregs.read(1), 0x0000_1000);
    }

    #[test]
    fn fflags_accrue_across_instructions() {
        let mut t = test_thread();
        t.fregs.write(1, 0x3F80_0000); // 1.0
        t.fregs.write(2, 0x4040_0000); // 3.0
        t.step(0, FdivS { rd: 3, rs1: 1, rs2: 2, rm: 0b000 }).unwrap(); // inexact
        t.step(0, FaddS { rd: 4, rs1: 1, rs2: 2, rm: 0b000 }).unwrap(); // exact
        assert_eq!(t.fregs.read(4), 0x4080_0000);
        assert_eq!(t.fflags, softfloat::FLAG_INEXACT);
    }

    #[test]
    fn illegal_acts_return_an_error() {
        let mut t = test_thread();
        assert_eq!(t.step(0, FaddS { rd: 1, rs1: 1, rs2: 1, rm: 0b101 }), Err(Illegal::ReservedRoundingMode));
        assert_eq!(t.step(0, FsgnjS { rd: 1, rs1: 1, rs2: 1, rm: 0b011 }), Err(Illegal::IllegalInstruction));
        assert_eq!(t.step(0, FcmpS { rd: 1, rs1: 1, rs2: 1, rm: 0b011 }), Err(Illegal::IllegalInstruction));
        assert_eq!(t.step(0, FminmaxS { rd: 1, rs1: 1, rs2: 1, rm: 0b010 }), Err(Illegal::IllegalInstruction));
    }

    #[test]
    fn fmv_moves_bits_between_register_files_without_conversion() {
        let mut t = test_thread();
        const SIGNALING_NAN: u32 = 0x7F80_0001;
        t.xregs.write(1, SIGNALING_NAN);
        t.step(0, FmvWX { rd: 1, rs1: 1, rm: 0b000 }).unwrap();
        t.step(0, FmvXW { rd: 2, rs1: 1, rm: 0b000 }).unwrap();
        assert_eq!(t.xregs.read(2), SIGNALING_NAN);
        assert_eq!(t.fflags, 0);
    }

    #[test]
    fn new_threads_hold_the_poison_pattern() {
        let t = Thread::new(0, 0);
        assert_eq!(t.xregs.read(0), 0);
        assert_eq!(t.xregs.read(1), POISON);
        assert_eq!(t.fregs.read(0), POISON);
        assert_eq!(t.fflags, POISON_FFLAGS);
    }
}
