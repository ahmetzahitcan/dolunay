use crate::address_space::{self, AddressSpace};
use crate::control_unit::{self, Instruction};
use crate::geometry::THREADS_PER_WARP;
use crate::illegal::Illegal;
use crate::thread::{Effect, Thread};

/// A path's number within its warp.
type PathId = u8;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ThreadManager {
    threads: [Thread; THREADS_PER_WARP],
    paths: [PathId; THREADS_PER_WARP],
    active_path: PathId,
}

impl ThreadManager {
    pub fn new(warp_id: u16) -> ThreadManager {
        ThreadManager {
            threads: std::array::from_fn(|i| Thread::new(warp_id, i as u16)),
            paths: [0; THREADS_PER_WARP],
            active_path: 0,
        }
    }

    /// The threads on `path`, or every thread when `path` is `None`.
    fn on_path(&mut self, path: Option<PathId>) -> impl Iterator<Item = &mut Thread> {
        self.threads
            .iter_mut()
            .zip(self.paths)
            .filter(move |&(_, p)| path.is_none_or(|path| p == path))
            .map(|(thread, _)| thread)
    }

    #[allow(dead_code)]
    pub fn all(&mut self) -> impl Iterator<Item = &mut Thread> {
        self.on_path(None)
    }

    pub fn active(&mut self) -> impl Iterator<Item = &mut Thread> {
        self.on_path(Some(self.active_path))
    }

    /// The indices of the active path's threads, in thread order.
    pub fn active_indices(&self) -> impl Iterator<Item = usize> {
        (0..THREADS_PER_WARP).filter(|&i| self.paths[i] == self.active_path)
    }

    #[allow(dead_code)]
    pub fn friends(&mut self, thread_id: u16) -> impl Iterator<Item = &mut Thread> {
        self.on_path(Some(self.paths[thread_id as usize]))
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Warp {
    pub warp_id: u16,
    pub pc: u32,
    pub threads: ThreadManager,
}

impl Warp {
    pub fn new(warp_id: u16) -> Warp {
        Warp { warp_id, pc: 0, threads: ThreadManager::new(warp_id) }
    }

    /// Executes one instruction of the active path. The address space is the
    /// machine's, shared by every warp, so it is passed in, not owned.
    pub fn step(&mut self, addrs: &AddressSpace) -> Result<(), Illegal> {
        use Instruction::*;
        let word = match addrs.load(self.pc) {
            Ok(word) => word,
            Err(address_space::Error::UnalignedAccess) => unreachable!("pc {:#010x} is not aligned", self.pc),
            Err(address_space::Error::UnmappedAddress) => return Err(Illegal::IllegalInstruction),
        };
        let instruction = control_unit::decode(word).ok_or(Illegal::IllegalInstruction)?;
        match instruction {
            // These instructions must be dealt with within the warp!
            Beq { .. } | Bne { .. } | Blt { .. } | Bge { .. } | Bltu { .. } | Bgeu { .. } => todo!("branches"),
            Jal { rd, imm } => {
                // RISC-V unprivileged ISA, RV32I "Unconditional Jumps": the
                // target and the link are computed modulo 2^32.
                let new_pc = self.pc.wrapping_add(imm);
                let link_pc = self.pc.wrapping_add(4);
                for thread in self.threads.active() {
                    thread.xregs.write(rd, link_pc);
                }
                self.pc = new_pc;
            }
            Jalr { .. } => todo!("jalr"),
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
                let effects_lists = self
                    .threads
                    .active_indices()
                    .map(|i| Ok((i, self.threads.threads[i].execute(self.pc, instruction)?)))
                    .collect::<Result<Vec<(usize, Vec<Effect>)>, Illegal>>()?;
                for (i, effects) in effects_lists {
                    self.threads.threads[i].commit(effects);
                }
                self.pc = self.pc.wrapping_add(4);
            }
        }
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::address_space::ROM_SIZE;

    #[test]
    fn a_basic_warp_run() {
        // The first and the last thread, so the test holds for any geometry.
        const LAST: usize = THREADS_PER_WARP - 1;
        let mut rom = [0; ROM_SIZE];
        rom[0..4].copy_from_slice(&[0x93, 0x03, 0x00, 0x00]); // addi x7, x0, 0
        rom[4..8].copy_from_slice(&[0x93, 0x83, 0x13, 0x00]); // addi x7, x7, 1
        rom[8..12].copy_from_slice(&[0xef, 0xf0, 0xdf, 0xff]); // jal x1, -4
        let addrs = AddressSpace::new(rom);

        let mut warp = Warp::new(0);
        warp.step(&addrs).unwrap();
        assert_eq!(warp.pc, 4);
        assert_eq!(warp.threads.threads[0].xregs.read(7), 0);
        assert_eq!(warp.threads.threads[LAST].xregs.read(7), 0);

        for i in 1..1_000_000u32 {
            warp.step(&addrs).unwrap();
            warp.step(&addrs).unwrap();
            assert_eq!(warp.pc, 4);
            assert_eq!(warp.threads.threads[0].xregs.read(1), 12);
            assert_eq!(warp.threads.threads[LAST].xregs.read(1), 12);
            assert_eq!(warp.threads.threads[0].xregs.read(7), i);
            assert_eq!(warp.threads.threads[LAST].xregs.read(7), i);
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
