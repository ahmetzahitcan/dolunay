use std::iter::{self, zip};

use crate::address_space::{self, AddressSpace};
use crate::control_unit::{self, Instruction};
use crate::geometry::{INITIAL_PC, THREADS_PER_WARP};
use crate::illegal::Illegal;
use crate::path::{Path, SplitResult};
use crate::thread::Thread;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Warp {
    pub warp_id: u16,
    inactive_pathes: Vec<Path>,
    active_path: Option<Path>,
}

impl Warp {
    pub fn new(warp_id: u16) -> Self {
        Self { 
            warp_id,
            inactive_pathes: Vec::with_capacity(THREADS_PER_WARP - 1),
            active_path: Some(Path::new(INITIAL_PC, (0..THREADS_PER_WARP).map(|tid| Thread::new(warp_id, tid as u16)))),
        }
    }

    pub fn active(&self) -> &Path {
        self.active_path.as_ref().unwrap()
    }

    pub fn thread(&self, thread_id: u16) -> &Thread {
        assert!(thread_id < THREADS_PER_WARP as u16, "Invalid thread ID!");

        let pathes = self.inactive_pathes.iter().chain(iter::once(self.active()));
        for path in pathes {
            if let Some(thread) = path.thread(thread_id) {
                return thread;
            }
        }

        panic!("Missing thread!");
    }

    /// Executes one instruction of the active path. The address space is the
    /// machine's, shared by every warp, so it is passed in, not owned.
    pub fn step(&mut self, addrs: &AddressSpace) -> Result<(), Illegal> {
        let mut path = self.active_path.take().unwrap();

        use Instruction::*;
        let word = match addrs.load(path.pc) {
            Ok(word) => word,
            Err(address_space::Error::UnalignedAccess) => unreachable!("pc {:#010x} is not aligned", path.pc),
            Err(address_space::Error::UnmappedAddress) => {
                self.active_path = Some(path);    
                return Err(Illegal::IllegalInstruction)
            },
        };
        let Some(instruction) = control_unit::decode(word) else {
            self.active_path = Some(path);    
            return Err(Illegal::IllegalInstruction)
        };
        match instruction {
            // These instructions must be dealt with within the warp!
            Beq { imm, .. } | 
            Bne { imm, .. } | 
            Blt { imm, .. } | 
            Bge { imm, .. } | 
            Bltu { imm, .. } | 
            Bgeu { imm, .. } => {
                let taking_pc = path.pc.wrapping_add(imm);
                let passing_pc = path.pc.wrapping_add(4);
                use SplitResult::*;
                match path.split(|t| t.eval_branch(instruction)) {
                    AllTaking(mut p) => {
                        p.pc = taking_pc;
                        self.active_path = Some(p);
                    },
                    AllPassing(mut p) => {
                        p.pc = passing_pc;
                        self.active_path = Some(p);
                    },
                    Divergence { mut taking, mut passing } => {
                        taking.pc = taking_pc;
                        passing.pc = passing_pc;

                        // TODO: Specify policy over which path should be the active one. passing for now.
                        self.inactive_pathes.push(taking);
                        self.active_path = Some(passing);
                    },
                }
            },
            Jal { rd, imm } => {
                let new_pc = path.pc.wrapping_add(imm);
                let link_pc = path.pc.wrapping_add(4);
                for thread in path.threads_mut() {
                    thread.xregs.write(rd, link_pc);
                }
                path.pc = new_pc;
                self.active_path = Some(path);
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
                let mut error = None;
                let mut uncommitted = Vec::new();
                for t in path.threads() {
                    let effects = match t.execute(path.pc, instruction) {
                        Ok(x) => x,
                        Err(e) => {
                            error = Some(e);
                            break;
                        },
                    };
                    uncommitted.push(effects)
                }

                if let Some(err) = error {
                    self.active_path = Some(path);
                    return Err(err);
                } 

                for (thread, effects) in zip(path.threads_mut(), uncommitted) {
                    thread.commit(effects);
                }

                path.pc = path.pc.wrapping_add(4);
                self.active_path = Some(path);
            }
        }
        assert!(self.active_path.is_some());
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
        assert_eq!(warp.active().pc, 4);
        assert_eq!(warp.thread(0).xregs.read(7), 0);
        assert_eq!(warp.thread(LAST).xregs.read(7), 0);

        for i in 1..1_000_000u32 {
            warp.step(&addrs).unwrap();
            warp.step(&addrs).unwrap();
            assert_eq!(warp.active().pc, 4);
            assert_eq!(warp.thread(0).xregs.read(1), 12);
            assert_eq!(warp.thread(LAST).xregs.read(1), 12);
            assert_eq!(warp.thread(0).xregs.read(7), i);
            assert_eq!(warp.thread(LAST).xregs.read(7), i);
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
