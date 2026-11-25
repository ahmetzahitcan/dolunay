use crate::control_unit::Instruction;
use crate::float;
use crate::illegal::Illegal;
use crate::int_utils;

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

/// One change an instruction makes to one thread, computed from the thread's
/// state before the instruction. An instruction makes zero or more.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Effect {
    WriteX { rd: u8, value: u32 },
    WriteF { rd: u8, value: u32 },
    AccumulateFflags { flags: u8 },
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Thread {
    /// The thread's integer registers.
    pub xregs: XRegs,
    /// The thread's floating-point registers.
    pub fregs: FRegs,
    /// The thread's floating-point flags.
    pub fflags: u8,
    pub thread_id: u16,
}

impl Thread {
    pub fn new(thread_id: u16) -> Thread {
        Thread {
            xregs: XRegs { values: [POISON; 31] },
            fregs: FRegs { values: [POISON; 32] },
            fflags: POISON_FFLAGS,
            thread_id,
        }
    }

    /// Evaluates the branch condition of `instruction` on this thread,
    /// returning true if the branch is taken, false if not.
    /// 
    /// Panics: If instruction is not a branch.
    pub fn eval_branch(&self, instruction: Instruction) -> bool {
        use Instruction::*;
        let x = |r: u8| self.xregs.read(r);
        match instruction {
            Beq { rs1, rs2, imm: _ } => x(rs1) == x(rs2),
            Bne { rs1, rs2, imm: _ } => x(rs1) != x(rs2),
            Blt { rs1, rs2, imm: _ } => int_utils::less_signed(x(rs1), x(rs2)) != 0,
            Bge { rs1, rs2, imm: _ } => int_utils::less_signed(x(rs1), x(rs2)) == 0,
            Bltu { rs1, rs2, imm: _ } => int_utils::less_unsigned(x(rs1), x(rs2)) != 0,
            Bgeu { rs1, rs2, imm: _ } => int_utils::less_unsigned(x(rs1), x(rs2)) == 0,
            _ => unreachable!("{instruction:?} is not a branch"),
        }
    }

    /// Evaluates a JALR instruction and returns the expected PC
    /// 
    /// Panics: If instruction is not JALR.
    pub fn eval_jalr(&self, instruction: Instruction) -> u32 {
        let Instruction::Jalr { rd: _, rs1, imm } = instruction else { unreachable!("{instruction:?} is not JALR") };
        self.xregs.read(rs1).wrapping_add(imm) & !1 // Dumb clearing of the lowest bit
    }

    /// Applies the effects `execute` computed, in order.
    pub fn commit(&mut self, effects: Vec<Effect>) {
        for effect in effects {
            match effect {
                Effect::WriteX { rd, value } => self.xregs.write(rd, value),
                Effect::WriteF { rd, value } => self.fregs.write(rd, value),
                Effect::AccumulateFflags { flags } => self.fflags |= flags,
            }
        }
    }

    /// Computes what `instruction` does to this thread, without changing it.
    /// The warp computes every thread's effects before it commits any, so an
    /// instruction that is illegal on one thread changes none (CONTRACT.md §1,
    /// guarantee 2).
    pub fn execute(&self, pc: u32, instruction: Instruction) -> Result<Vec<Effect>, Illegal> {
        use Instruction::*;
        let x = |r: u8| self.xregs.read(r);
        let f = |r: u8| self.fregs.read(r);
        let to_x = |rd: u8, value: u32| Vec::from([Effect::WriteX { rd, value }]);
        let to_f = |rd: u8, value: u32| Vec::from([Effect::WriteF { rd, value }]);
        let float_to_x = |rd: u8, r: float::Output| {
            Vec::from([Effect::WriteX { rd, value: r.value }, Effect::AccumulateFflags { flags: r.flags }])
        };
        let float_to_f = |rd: u8, r: float::Output| {
            Vec::from([Effect::WriteF { rd, value: r.value }, Effect::AccumulateFflags { flags: r.flags }])
        };

        // Semantics from the RISC-V unprivileged ISA: RV32I "Integer
        // Computational Instructions", and Zba for SHnADD. Arithmetic wraps
        // modulo 2^32; shifts use the low 5 bits of the amount.
        Ok(match instruction {
            Add { rd, rs1, rs2 } => to_x(rd, x(rs1).wrapping_add(x(rs2))),
            Sub { rd, rs1, rs2 } => to_x(rd, x(rs1).wrapping_sub(x(rs2))),
            Sh1add { rd, rs1, rs2 } => to_x(rd, (x(rs1) << 1).wrapping_add(x(rs2))),
            Sh2add { rd, rs1, rs2 } => to_x(rd, (x(rs1) << 2).wrapping_add(x(rs2))),
            Sh3add { rd, rs1, rs2 } => to_x(rd, (x(rs1) << 3).wrapping_add(x(rs2))),
            Sll { rd, rs1, rs2 } => to_x(rd, int_utils::shl(x(rs1), x(rs2))),
            Srl { rd, rs1, rs2 } => to_x(rd, int_utils::shr(x(rs1), x(rs2))),
            Sra { rd, rs1, rs2 } => to_x(rd, int_utils::sra(x(rs1), x(rs2))),
            Slt { rd, rs1, rs2 } => to_x(rd, int_utils::less_signed(x(rs1), x(rs2))),
            Sltu { rd, rs1, rs2 } => to_x(rd, int_utils::less_unsigned(x(rs1), x(rs2))),
            Xor { rd, rs1, rs2 } => to_x(rd, x(rs1) ^ x(rs2)),
            Or { rd, rs1, rs2 } => to_x(rd, x(rs1) | x(rs2)),
            And { rd, rs1, rs2 } => to_x(rd, x(rs1) & x(rs2)),
            Addi { rd, rs1, imm } => to_x(rd, x(rs1).wrapping_add(imm)),
            Slli { rd, rs1, imm } => to_x(rd, int_utils::shl(x(rs1), imm)),
            Srli { rd, rs1, imm } => to_x(rd, int_utils::shr(x(rs1), imm)),
            Srai { rd, rs1, imm } => to_x(rd, int_utils::sra(x(rs1), imm)),
            Slti { rd, rs1, imm } => to_x(rd, int_utils::less_signed(x(rs1), imm)),
            Sltiu { rd, rs1, imm } => to_x(rd, int_utils::less_unsigned(x(rs1), imm)),
            Xori { rd, rs1, imm } => to_x(rd, x(rs1) ^ imm),
            Ori { rd, rs1, imm } => to_x(rd, x(rs1) | imm),
            Andi { rd, rs1, imm } => to_x(rd, x(rs1) & imm),
            Lui { rd, imm } => to_x(rd, imm),
            Auipc { rd, imm } => to_x(rd, pc.wrapping_add(imm)),
            CzeroEqz { rd, rs1, rs2 } => to_x(rd, if x(rs2) == 0 { 0 } else { x(rs1) }),
            CzeroNez { rd, rs1, rs2 } => to_x(rd, if x(rs2) != 0 { 0 } else { x(rs1) }),

            // RISC-V unprivileged ISA, "F" Standard Extension (float.rs).
            FaddS { rd, rs1, rs2, rm } => float_to_f(rd, float::add(f(rs1), f(rs2), rm)?),
            FsubS { rd, rs1, rs2, rm } => float_to_f(rd, float::sub(f(rs1), f(rs2), rm)?),
            FmulS { rd, rs1, rs2, rm } => float_to_f(rd, float::mul(f(rs1), f(rs2), rm)?),
            FdivS { rd, rs1, rs2, rm } => float_to_f(rd, float::div(f(rs1), f(rs2), rm)?),
            FsqrtS { rd, rs1, rm, .. } => float_to_f(rd, float::sqrt(f(rs1), rm)?),
            FmaddS { rd, rs1, rs2, rs3, rm } => float_to_f(rd, float::mul_add(f(rs1), f(rs2), f(rs3), rm)?),
            FmsubS { rd, rs1, rs2, rs3, rm } => float_to_f(rd, float::mul_sub(f(rs1), f(rs2), f(rs3), rm)?),
            FnmsubS { rd, rs1, rs2, rs3, rm } => float_to_f(rd, float::neg_mul_sub(f(rs1), f(rs2), f(rs3), rm)?),
            FnmaddS { rd, rs1, rs2, rs3, rm } => float_to_f(rd, float::neg_mul_add(f(rs1), f(rs2), f(rs3), rm)?),
            FminmaxS { rd, rs1, rs2, rm } => float_to_f(
                rd,
                match rm {
                    0b000 => float::min(f(rs1), f(rs2)),
                    0b001 => float::max(f(rs1), f(rs2)),
                    _ => return Err(Illegal::IllegalInstruction),
                },
            ),
            FsgnjS { rd, rs1, rs2, rm } => to_f(
                rd,
                match rm {
                    0b000 => float::sgnj(f(rs1), f(rs2)),
                    0b001 => float::sgnjn(f(rs1), f(rs2)),
                    0b010 => float::sgnjx(f(rs1), f(rs2)),
                    _ => return Err(Illegal::IllegalInstruction),
                },
            ),
            FcmpS { rd, rs1, rs2, rm } => float_to_x(
                rd,
                match rm {
                    0b010 => float::eq(f(rs1), f(rs2)),
                    0b001 => float::lt(f(rs1), f(rs2)),
                    0b000 => float::le(f(rs1), f(rs2)),
                    _ => return Err(Illegal::IllegalInstruction),
                },
            ),
            FclassS { rd, rs1, .. } => to_x(rd, float::classify(f(rs1))),
            FcvtWS { rd, rs1, rm } => float_to_x(rd, float::to_i32(f(rs1), rm)?),
            FcvtWuS { rd, rs1, rm } => float_to_x(rd, float::to_u32(f(rs1), rm)?),
            FcvtSW { rd, rs1, rm } => float_to_f(rd, float::from_i32(x(rs1), rm)?),
            FcvtSWu { rd, rs1, rm } => float_to_f(rd, float::from_u32(x(rs1), rm)?),
            FmvXW { rd, rs1, .. } => to_x(rd, f(rs1)),
            FmvWX { rd, rs1, .. } => to_f(rd, x(rs1)),

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
        })
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
        let mut t = Thread::new(0);
        t.xregs.values = [0; 31];
        t.fregs.values = [0; 32];
        t.fflags = 0;
        t
    }

    /// Executes and commits one instruction, as the warp does for each thread.
    fn step(t: &mut Thread, pc: u32, instruction: Instruction) -> Result<(), Illegal> {
        let effects = t.execute(pc, instruction)?;
        t.commit(effects);
        Ok(())
    }

    #[test]
    fn x0_reads_as_zero_and_ignores_writes() {
        let mut t = test_thread();
        step(&mut t, 0, Addi { rd: 0, rs1: 0, imm: 5 }).unwrap();
        assert_eq!(t.xregs.read(0), 0);
        step(&mut t, 0, Addi { rd: 1, rs1: 0, imm: 7 }).unwrap();
        assert_eq!(t.xregs.read(1), 7);
    }

    #[test]
    fn auipc_adds_the_immediate_to_pc_wrapping() {
        let mut t = test_thread();
        step(&mut t, 0xFFFF_F000, Auipc { rd: 1, imm: 0x0000_2000 }).unwrap();
        assert_eq!(t.xregs.read(1), 0x0000_1000);
    }

    #[test]
    fn fflags_accrue_across_instructions() {
        let mut t = test_thread();
        t.fregs.write(1, 0x3F80_0000); // 1.0
        t.fregs.write(2, 0x4040_0000); // 3.0
        step(&mut t, 0, FdivS { rd: 3, rs1: 1, rs2: 2, rm: 0b000 }).unwrap(); // inexact
        step(&mut t, 0, FaddS { rd: 4, rs1: 1, rs2: 2, rm: 0b000 }).unwrap(); // exact
        assert_eq!(t.fregs.read(4), 0x4080_0000);
        assert_eq!(t.fflags, softfloat::FLAG_INEXACT);
    }

    #[test]
    fn illegal_acts_return_an_error() {
        let t = test_thread();
        assert_eq!(t.execute(0, FaddS { rd: 1, rs1: 1, rs2: 1, rm: 0b101 }), Err(Illegal::ReservedRoundingMode));
        assert_eq!(t.execute(0, FsgnjS { rd: 1, rs1: 1, rs2: 1, rm: 0b011 }), Err(Illegal::IllegalInstruction));
        assert_eq!(t.execute(0, FcmpS { rd: 1, rs1: 1, rs2: 1, rm: 0b011 }), Err(Illegal::IllegalInstruction));
        assert_eq!(t.execute(0, FminmaxS { rd: 1, rs1: 1, rs2: 1, rm: 0b010 }), Err(Illegal::IllegalInstruction));
    }

    #[test]
    fn execute_does_not_change_the_thread() {
        let mut t = test_thread();
        t.fregs.write(1, 0x3F80_0000); // 1.0
        t.fregs.write(2, 0x4040_0000); // 3.0
        let before = t.clone();
        let effects = t.execute(0, FdivS { rd: 3, rs1: 1, rs2: 2, rm: 0b000 }).unwrap();
        assert_eq!(t, before);
        assert_eq!(effects.len(), 2);
        assert_eq!(effects[0], Effect::WriteF { rd: 3, value: 0x3EAA_AAAB });
        assert_eq!(effects[1], Effect::AccumulateFflags { flags: softfloat::FLAG_INEXACT });
    }

    #[test]
    fn fmv_moves_bits_between_register_files_without_conversion() {
        let mut t = test_thread();
        const SIGNALING_NAN: u32 = 0x7F80_0001;
        t.xregs.write(1, SIGNALING_NAN);
        step(&mut t, 0, FmvWX { rd: 1, rs1: 1, rm: 0b000 }).unwrap();
        step(&mut t, 0, FmvXW { rd: 2, rs1: 1, rm: 0b000 }).unwrap();
        assert_eq!(t.xregs.read(2), SIGNALING_NAN);
        assert_eq!(t.fflags, 0);
    }

    #[test]
    fn new_threads_hold_the_poison_pattern() {
        let t = Thread::new(0);
        assert_eq!(t.xregs.read(0), 0);
        assert_eq!(t.xregs.read(1), POISON);
        assert_eq!(t.fregs.read(0), POISON);
        assert_eq!(t.fflags, POISON_FFLAGS);
    }
}
