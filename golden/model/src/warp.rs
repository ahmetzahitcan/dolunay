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
    inactive_paths: Vec<Path>,
    active_path: Option<Path>,
}

impl Warp {
    pub fn new(warp_id: u16) -> Self {
        Self { 
            warp_id,
            inactive_paths: Vec::with_capacity(THREADS_PER_WARP - 1),
            active_path: Some(Path::new(INITIAL_PC, (0..THREADS_PER_WARP).map(|tid| Box::new(Thread::new(tid as u16))).collect())),
        }
    }

    pub fn active(&self) -> &Path {
        self.active_path.as_ref().unwrap()
    }

    pub fn thread(&self, thread_id: u16) -> &Thread {
        assert!(thread_id < THREADS_PER_WARP as u16, "Invalid thread ID!");

        let pathes = self.inactive_paths.iter().chain(iter::once(self.active()));
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
                        self.inactive_paths.push(taking);
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
                let link_pc = path.pc.wrapping_add(4);

                let mut committed_paths = Vec::with_capacity(THREADS_PER_WARP);
                let mut maybe_next_path = Some(path);

                while let Some(next_path) = maybe_next_path.take() {
                    let leader_pc = next_path.leader().eval_jalr(instruction);
                    use SplitResult::*;
                    match next_path.split(|t| t.eval_jalr(instruction) == leader_pc) {
                        AllTaking(mut path) => {
                            path.pc = leader_pc;
                            committed_paths.push(path);
                        },
                        AllPassing(_) => unreachable!(),
                        Divergence { mut taking, passing } => {
                            taking.pc = leader_pc;
                            committed_paths.push(taking);

                            maybe_next_path = Some(passing);
                        },
                    }
                }

                for p in &mut committed_paths {
                    for t in p.threads_mut() {
                        t.xregs.write(rd, link_pc);
                    }
                }

                // TODO: Specify policy over which path should be the active one. pop for now.
                //       A not-unreasonable policy is leader's path. This would involve switching from Vec to VecDeque, and using pop_front

                // Using expect and rewrapping it in Some; just to make sure it is in fact valid.
                self.active_path = Some(committed_paths.pop().expect("No paths committed?!")); 
                for p in committed_paths {
                    self.inactive_paths.push(p);
                };
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
                let mut uncommitted = Vec::with_capacity(THREADS_PER_WARP);
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

    // Which new path becomes active after a split is a choice point
    // (spec/EXECUTION-MODEL.md §2), so the tests below look at every path and
    // never at which one is active.

    /// A ROM holding `words` from address 0.
    fn rom_of(words: &[u32]) -> AddressSpace {
        let mut rom = [0; ROM_SIZE];
        for (i, w) in words.iter().enumerate() {
            rom[4 * i..4 * i + 4].copy_from_slice(&w.to_le_bytes());
        }
        AddressSpace::new(rom)
    }

    fn paths(warp: &Warp) -> impl Iterator<Item = &Path> {
        warp.inactive_paths.iter().chain(warp.active_path.iter())
    }

    fn pc_of(warp: &Warp, thread_id: u16) -> u32 {
        paths(warp).find(|p| p.thread(thread_id).is_some()).unwrap().pc
    }

    /// Writes `value(thread_id)` to `x<r>` of every thread. Only for a warp
    /// whose threads are all in the active path, as they are at start-up.
    fn set_x(warp: &mut Warp, r: u8, value: impl Fn(u16) -> u32) {
        assert!(warp.inactive_paths.is_empty());
        for t in warp.active_path.as_mut().unwrap().threads_mut() {
            t.xregs.write(r, value(t.thread_id));
        }
    }

    #[test]
    fn a_branch_all_threads_agree_on_keeps_one_path() {
        let addrs = rom_of(&[
            0x00000463, // 0x0: beq x0, x0, 8   taken
            0x00000013, // 0x4: addi x0, x0, 0
            0xFE001CE3, // 0x8: bne x0, x0, -8  not taken
            0xFE005AE3, // 0xc: bge x0, x0, -12 taken
        ]);
        let mut warp = Warp::new(0);
        for expected_pc in [0x8, 0xc, 0x0] {
            warp.step(&addrs).unwrap();
            assert!(warp.inactive_paths.is_empty());
            assert_eq!(warp.active().pc, expected_pc);
        }
    }

    #[test]
    fn a_branch_threads_disagree_on_splits_the_path_by_outcome() {
        let addrs = rom_of(&[0x00029663]); // bne x5, x0, 12
        let mut warp = Warp::new(0);
        set_x(&mut warp, 5, |tid| (tid % 2) as u32);
        warp.step(&addrs).unwrap();

        assert_eq!(paths(&warp).count(), 2);
        for tid in 0..THREADS_PER_WARP as u16 {
            let expected_pc = if tid % 2 == 1 { 12 } else { 4 };
            assert_eq!(pc_of(&warp, tid), expected_pc, "thread {tid}");
        }
    }

    #[test]
    fn jalr_splits_the_path_by_target_and_links_every_thread() {
        let addrs = rom_of(&[0x008280E7]); // jalr x1, 8(x5)
        let mut warp = Warp::new(0);
        set_x(&mut warp, 5, |tid| 0x100 + 4 * (tid % 3) as u32);
        warp.step(&addrs).unwrap();

        assert_eq!(paths(&warp).count(), THREADS_PER_WARP.min(3));
        for tid in 0..THREADS_PER_WARP as u16 {
            assert_eq!(pc_of(&warp, tid), 0x108 + 4 * (tid % 3) as u32, "thread {tid}");
            assert_eq!(warp.thread(tid).xregs.read(1), 4, "thread {tid}");
        }
    }

    #[test]
    fn jalr_reads_rs1_before_linking_and_clears_bit_0_of_the_target() {
        // RISC-V unprivileged ISA, "Unconditional Jumps": the target is
        // rs1 + imm with its least-significant bit set to zero.
        let addrs = rom_of(&[0x010282E7]); // jalr x5, 16(x5)
        let mut warp = Warp::new(0);
        set_x(&mut warp, 5, |_| 0x101);
        warp.step(&addrs).unwrap();

        assert!(warp.inactive_paths.is_empty());
        assert_eq!(warp.active().pc, 0x110);
        assert_eq!(warp.thread(0).xregs.read(5), 4);
    }
}
