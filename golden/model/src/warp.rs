use crate::address_space::{self, AddressSpace};
use crate::control_unit::{self, Instruction};
use crate::illegal::Illegal;
use crate::path::PathManager;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Warp {
    pub warp_id: u16,
    path_man: PathManager,
}

impl Warp {
    pub fn new(warp_id: u16) -> Warp {
        Warp { warp_id, path_man: PathManager::new(warp_id) }
    }

    /// Executes one instruction of the active path. The address space is the
    /// machine's, shared by every warp, so it is passed in, not owned.
    pub fn step(&mut self, addrs: &AddressSpace) -> Result<(), Illegal> {
        use Instruction::*;
        let word = match addrs.load(self.path_man.pc) {
            Ok(word) => word,
            Err(address_space::Error::UnalignedAccess) => unreachable!("pc {:#010x} is not aligned", self.path_man.pc),
            Err(address_space::Error::UnmappedAddress) => return Err(Illegal::IllegalInstruction),
        };
        let instruction = control_unit::decode(word).ok_or(Illegal::IllegalInstruction)?;
        match instruction {
            // These instructions must be dealt with within the warp!
            Beq { imm, .. } | 
            Bne { imm, .. } | 
            Blt { imm, .. } | 
            Bge { imm, .. } | 
            Bltu { imm, .. } | 
            Bgeu { imm, .. } => {
                let taking_pc = self.path_man.pc.wrapping_add(imm);
                let passing_pc = self.path_man.pc.wrapping_add(4);
                self.path_man.split(|t| t.eval_branch(instruction), taking_pc, passing_pc);
            },
            Jal { rd, imm } => {
                let new_pc = self.path_man.pc.wrapping_add(imm);
                let link_pc = self.path_man.pc.wrapping_add(4);
                for thread in self.path_man.active_mut() {
                    thread.xregs.write(rd, link_pc);
                }
                self.path_man.pc = new_pc;
            }
            Jalr { rd, .. } => {
                todo!("jalr")
            },
            Lb { .. } | Lh { .. } | Lw { .. } | Lbu { .. } | Lhu { .. } | Flw { .. } => todo!("loads"),
            Sb { .. } | Sh { .. } | Sw { .. } | Fsw { .. } => todo!("stores"),
            Binit { .. } | Bsync0 { .. } | Yield => todo!("barriers and yield"),
            Fence => todo!("fence"),
            Wdone { .. } => todo!("wdone"),

            // All other instructions are executed by each thread of the active
            // path. Every thread's effect is computed from the state before
            // the instruction, and none is committed unless all succeed: an
            // instruction that is illegal on any thread of the path has no
            // effect (CONTRACT.md §1, guarantee 2).
            _ => {
                let mut uncommitted = Vec::new();
                for t in self.path_man.active() {
                    uncommitted.push((t.thread_id, t.execute(self.path_man.pc, instruction)?))
                }

                for item in uncommitted {
                    let (tid, effects) = item;
                    self.path_man.thread_mut(tid).commit(effects);
                }

                self.path_man.pc = self.path_man.pc.wrapping_add(4);
            }
        }
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::{address_space::ROM_SIZE, geometry::THREADS_PER_WARP};

    #[test]
    fn a_basic_warp_run() {
        // The first and the last thread, so the test holds for any geometry.
        const LAST: u16 = (THREADS_PER_WARP - 1) as u16;
        let mut rom = [0; ROM_SIZE];
        rom[0..4].copy_from_slice(&[0x93, 0x03, 0x00, 0x00]); // addi x7, x0, 0
        rom[4..8].copy_from_slice(&[0x93, 0x83, 0x13, 0x00]); // addi x7, x7, 1
        rom[8..12].copy_from_slice(&[0xef, 0xf0, 0xdf, 0xff]); // jal x1, -4
        let addrs = AddressSpace::new(rom);

        let mut warp = Warp::new(0);
        warp.step(&addrs).unwrap();
        assert_eq!(warp.path_man.pc, 4);
        assert_eq!(warp.path_man.thread(0).xregs.read(7), 0);
        assert_eq!(warp.path_man.thread(LAST).xregs.read(7), 0);

        for i in 1..1_000_000u32 {
            warp.step(&addrs).unwrap();
            warp.step(&addrs).unwrap();
            assert_eq!(warp.path_man.pc, 4);
            assert_eq!(warp.path_man.thread(0).xregs.read(1), 12);
            assert_eq!(warp.path_man.thread(LAST).xregs.read(1), 12);
            assert_eq!(warp.path_man.thread(0).xregs.read(7), i);
            assert_eq!(warp.path_man.thread(LAST).xregs.read(7), i);
        }
    }

    #[test]
    fn an_illegal_instruction_changes_nothing() {
        let mut rom = [0; ROM_SIZE];
        rom[0..4].copy_from_slice(&[0xd3, 0xd0, 0x10, 0x00]); // fadd.s f1, f1, f1 with rm = 101
        let addrs = AddressSpace::new(rom);

        let mut warp = Warp::new(0);
        let before = warp.clone();
        assert_eq!(warp.step(&addrs), Err(Illegal::ReservedRoundingMode));
        assert_eq!(warp, before);
    }
}
