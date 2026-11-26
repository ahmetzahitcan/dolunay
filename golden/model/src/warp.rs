use std::iter::zip;

use indexmap::IndexMap;
use rustc_hash::FxBuildHasher;

use crate::address_space::AddressSpace;
use crate::control_unit::{self, Instruction};
use crate::geometry::{INITIAL_PC, THREADS_PER_WARP};
use crate::illegal::Illegal;
use crate::path::{Path, SplitResult};
use crate::thread::Thread;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Warp {
    pub warp_id: usize,
    blocked_paths: Vec<Path>,
    paused_paths: Vec<Path>,
    active_path: Option<Path>,
}

// Constructors
impl Warp {
    pub fn new(warp_id: usize) -> Self {
        Self { 
            warp_id,
            blocked_paths: Vec::with_capacity(THREADS_PER_WARP - 1),
            paused_paths: Vec::with_capacity(THREADS_PER_WARP - 1),
            active_path: Some(Path::new(INITIAL_PC, (0..THREADS_PER_WARP).map(|tid| Box::new(Thread::new(tid))).collect())),
        }
    }
}

// Path access methods
impl Warp {
    pub fn paths(&self) -> impl Iterator<Item = &Path> {
        assert!(self.active_path.is_some());
        self.paused_paths.iter().chain(self.active_path.iter())
    }

    pub fn paths_mut(&mut self) -> impl Iterator<Item = &mut Path> {
        assert!(self.active_path.is_some());
        self.paused_paths.iter_mut().chain(self.active_path.iter_mut())
    }

    pub fn path(&self, thread_id: usize) -> &Path {
        assert!(thread_id < THREADS_PER_WARP, "Invalid thread ID!");
        

        let paths = self.paths();
        for path in paths {
            if path.has_thread(thread_id) {
                return path;
            }
        }

        panic!("Missing thread!");
    }

    pub fn path_mut(&mut self, thread_id: usize) -> &mut Path {
        assert!(thread_id < THREADS_PER_WARP, "Invalid thread ID!");
        assert!(self.active_path.is_some());

        let paths = self.paths_mut();
        for path in paths {
            if path.has_thread(thread_id) {
                return path;
            }
        }

        panic!("Missing thread!");
    }

    pub fn active(&self) -> &Path {
        self.active_path.as_ref().unwrap()
    }

    pub fn active_mut(&mut self) -> &mut Path {
        self.active_path.as_mut().unwrap()
    }
}

// Thread access methods
impl Warp {
    pub fn thread(&self, thread_id: usize) -> &Thread {
        assert!(thread_id < THREADS_PER_WARP, "Invalid thread ID!");
        assert!(self.active_path.is_some());

        let paths = self.paths();
        for path in paths {
            if let Some(thread) = path.thread(thread_id) {
                return thread;
            }
        }

        panic!("Missing thread!");
    }

    pub fn thread_mut(&mut self, thread_id: usize) -> &mut Thread {
        assert!(thread_id < THREADS_PER_WARP, "Invalid thread ID!");
        assert!(self.active_path.is_some());

        let paths = self.paths_mut();
        for path in paths {
            if let Some(thread) = path.thread_mut(thread_id) {
                return thread;
            }
        }

        panic!("Missing thread!");
    }

    pub fn threads(&self) -> impl Iterator<Item = &Thread> {
        self.paths().flat_map(|p| p.threads())
    }

    pub fn threads_mut(&mut self) -> impl Iterator<Item = &mut Thread> {
        self.paths_mut().flat_map(|p| p.threads_mut())
    }
}

// Execution methods
impl Warp {
    /// Executes one instruction of the active path. The address space is the
    /// machine's, shared by every warp, so it is passed in, not owned.
    pub fn step(&mut self, address_space: &mut AddressSpace) -> Result<(), Illegal> {
        let mut path = self.active_path.take().unwrap();

        use Instruction::*;
        let undecoded_instruction = match address_space.load(path.pc) {
            Ok(word) => word,
            Err(err) => {
                self.active_path = Some(path);    
                return Err(err);
            },
        };
        let Some(instruction) = control_unit::decode(undecoded_instruction) else {
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
                        self.paused_paths.push(taking);
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
                    self.paused_paths.push(p);
                };
            },

            Lw { rd, .. } => {
                let mut err = None;
                let mut loads = Vec::with_capacity(path.size());

                for t in path.threads() {
                    let addr = t.eval_addr(instruction);
                    let word = match address_space.load(addr) {
                        Ok(word) => word,
                        Err(e) => {
                            err = Some(e);
                            break;
                        },
                    };
                    loads.push(word)
                }

                if let Some(e) = err {
                    self.active_path = Some(path);
                    return Err(e);
                }

                for (t, w) in zip(path.threads_mut(), loads ){
                    t.xregs.write(rd, w);
                }

                path.pc = path.pc.wrapping_add(4);
                self.active_path = Some(path);
            },

            Flw { .. } => todo!("FLW"),
            Lb { .. } | Lh { .. } | Lbu { .. } | Lhu { .. } => todo!("subword loads"),

            Sw { .. } => {
                let mut err = None;
                let mut pairs = IndexMap::with_capacity_and_hasher(
                    path.size(),
                    FxBuildHasher::default());

                for t in path.threads() {
                    let addr = t.eval_addr(instruction);
                    let word = t.eval_store(instruction);
                    if pairs.insert(addr, word).is_some() {
                        err = Some(Illegal::StoreConflict);
                        break;
                    }
                }

                if let Some(e) = err {
                    self.active_path = Some(path);
                    return Err(e);
                }

                let mut stores = Vec::with_capacity(pairs.len());

                for (addr, word) in pairs {
                    let store = match address_space.eval_store(addr, word) {
                        Ok(s) => s,
                        Err(e) => {
                            self.active_path = Some(path);
                            return Err(e);
                        },
                    };
                    stores.push(store);
                }

                for s in stores {
                    address_space.commit_store(s);
                }

                path.pc = path.pc.wrapping_add(4);
                self.active_path = Some(path);
            },

            Fsw { .. } => todo!("FSW"),
            Sb { .. } | Sh { .. } => todo!("stores"),
            Binit { .. } | Bsync { .. } | Yield => todo!("barriers and yield"),
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

    /// A ROM holding `words` from address 0.
    fn rom_of(words: &[u32]) -> AddressSpace {
        let mut rom = [0; ROM_SIZE];
        for (i, w) in words.iter().enumerate() {
            rom[4 * i..4 * i + 4].copy_from_slice(&w.to_le_bytes());
        }
        AddressSpace::new(rom)
    }

    // RV32I encodings (RISC-V unprivileged ISA, "Load and Store Instructions"),
    // checked against the decoder in `load_store_words_decode_as_written`.
    const LW_X6_0_X5: u32 = 0x0002A303; // lw x6, 0(x5)
    const LW_X5_0_X5: u32 = 0x0002A283; // lw x5, 0(x5)
    const SW_X6_0_X5: u32 = 0x0062A023; // sw x6, 0(x5)

    /// Where the load tests put one data word per thread, clear of the code.
    const DATA: u32 = 0x100;

    /// `code` from address 0, and at `DATA` one word per thread: thread t's
    /// word is `data_word(t)`.
    fn rom_with_data(code: &[u32]) -> AddressSpace {
        let mut words = vec![0; DATA as usize / 4 + THREADS_PER_WARP];
        words[..code.len()].copy_from_slice(code);
        for tid in 0..THREADS_PER_WARP {
            words[DATA as usize / 4 + tid] = data_word(tid);
        }
        rom_of(&words)
    }

    fn data_word(tid: usize) -> u32 {
        0xA000_0000 | tid as u32
    }

    /// The address thread t uses in the store tests. A debug slot is the only
    /// address a store can succeed on until the scratchpad exists; that test
    /// goes with the debug unit.
    const DEBUG_BASE: u32 = 0xFFFF_FF00;

    #[test]
    fn load_store_words_decode_as_written() {
        use control_unit::decode;
        use Instruction::{Lw, Sw};
        assert_eq!(decode(LW_X6_0_X5), Some(Lw { rd: 6, rs1: 5, imm: 0 }));
        assert_eq!(decode(LW_X5_0_X5), Some(Lw { rd: 5, rs1: 5, imm: 0 }));
        assert_eq!(decode(SW_X6_0_X5), Some(Sw { rs1: 5, rs2: 6, imm: 0 }));
    }

    #[test]
    fn lw_gives_each_thread_the_word_at_its_own_address() {
        let mut addrs = rom_with_data(&[LW_X6_0_X5]);
        let addrs_before = addrs.clone();
        let mut warp = Warp::new(0);
        for t in warp.threads_mut() {
            t.xregs.write(5, DATA + 4 * t.thread_id as u32);
        }
        warp.step(&mut addrs).unwrap();

        assert_eq!(warp.paths().count(), 1);
        assert_eq!(warp.active().pc, 4);
        for tid in 0..THREADS_PER_WARP {
            assert_eq!(warp.thread(tid).xregs.read(6), data_word(tid), "thread {tid}");
        }
        assert_eq!(addrs, addrs_before);
    }

    #[test]
    fn lw_reads_every_address_before_writing_rd() {
        // rd = rs1: each thread's address comes from its x5 before the load.
        let mut addrs = rom_with_data(&[LW_X5_0_X5]);
        let mut warp = Warp::new(0);
        for t in warp.threads_mut() {
            t.xregs.write(5, DATA + 4 * t.thread_id as u32);
        }
        warp.step(&mut addrs).unwrap();

        for tid in 0..THREADS_PER_WARP {
            assert_eq!(warp.thread(tid).xregs.read(5), data_word(tid), "thread {tid}");
        }
    }

    #[test]
    fn threads_may_load_the_same_address() {
        // Only stores conflict (CONTRACT.md §2, "Store conflicts are illegal").
        let mut addrs = rom_with_data(&[LW_X6_0_X5]);
        let mut warp = Warp::new(0);
        for t in warp.threads_mut() {
            t.xregs.write(5, DATA);
        }
        warp.step(&mut addrs).unwrap();

        for tid in 0..THREADS_PER_WARP {
            assert_eq!(warp.thread(tid).xregs.read(6), data_word(0), "thread {tid}");
        }
    }

    /// Steps a warp whose threads all hold `addr(t)` in x5 and `t` in x6, and
    /// checks that the step is `expected` and changes nothing (CONTRACT.md §1,
    /// guarantee 2).
    fn assert_illegal_and_unchanged(instruction: u32, addr: impl Fn(usize) -> u32, expected: Illegal) {
        let mut addrs = rom_with_data(&[instruction]);
        let addrs_before = addrs.clone();
        let mut warp = Warp::new(0);
        for t in warp.threads_mut() {
            t.xregs.write(5, addr(t.thread_id));
            t.xregs.write(6, t.thread_id as u32);
        }
        let before = warp.clone();

        assert_eq!(warp.step(&mut addrs), Err(expected));
        assert_eq!(warp, before);
        assert_eq!(addrs, addrs_before);
    }

    // In the tests below only the last thread breaks the rule, so an illegal
    // act on any one thread of the path is enough.
    const LAST: usize = THREADS_PER_WARP - 1;

    #[test]
    fn an_unaligned_lw_changes_nothing() {
        let addr = |tid| DATA + 4 * tid as u32 + (tid == LAST) as u32;
        assert_illegal_and_unchanged(LW_X6_0_X5, addr, Illegal::UnalignedAccess);
    }

    #[test]
    fn an_unmapped_lw_changes_nothing() {
        let addr = |tid| if tid == LAST { ROM_SIZE as u32 } else { DATA + 4 * tid as u32 };
        assert_illegal_and_unchanged(LW_X6_0_X5, addr, Illegal::UnmappedAddress);
    }

    #[test]
    fn a_store_conflict_changes_nothing() {
        // The last thread stores to thread 0's address. Their values differ.
        let addr = |tid| DEBUG_BASE + 4 * if tid == LAST { 0 } else { tid as u32 };
        assert_illegal_and_unchanged(SW_X6_0_X5, addr, Illegal::StoreConflict);
    }

    #[test]
    fn a_store_conflict_is_illegal_whatever_the_values() {
        // Every thread stores the same value to the same address.
        let mut addrs = rom_with_data(&[SW_X6_0_X5]);
        let mut warp = Warp::new(0);
        for t in warp.threads_mut() {
            t.xregs.write(5, DEBUG_BASE);
            t.xregs.write(6, 7);
        }
        let before = warp.clone();

        if THREADS_PER_WARP > 1 {
            assert_eq!(warp.step(&mut addrs), Err(Illegal::StoreConflict));
            assert_eq!(warp, before);
        }
    }

    #[test]
    fn a_sw_to_rom_changes_nothing() {
        let addr = |tid| if tid == LAST { DATA } else { DEBUG_BASE + 4 * tid as u32 };
        assert_illegal_and_unchanged(SW_X6_0_X5, addr, Illegal::StoreToRom);
    }

    #[test]
    fn an_unaligned_sw_changes_nothing() {
        let addr = |tid| DEBUG_BASE + 4 * tid as u32 + 2 * (tid == LAST) as u32;
        assert_illegal_and_unchanged(SW_X6_0_X5, addr, Illegal::UnalignedAccess);
    }

    #[test]
    fn an_unmapped_sw_changes_nothing() {
        let addr = |tid| if tid == LAST { ROM_SIZE as u32 } else { DEBUG_BASE + 4 * tid as u32 };
        assert_illegal_and_unchanged(SW_X6_0_X5, addr, Illegal::UnmappedAddress);
    }

    #[test]
    fn a_sw_to_distinct_addresses_steps_the_path() {
        let mut addrs = rom_with_data(&[SW_X6_0_X5]);
        let addrs_before = addrs.clone();
        let mut warp = Warp::new(0);
        for t in warp.threads_mut() {
            t.xregs.write(5, DEBUG_BASE + 4 * t.thread_id as u32);
            t.xregs.write(6, t.thread_id as u32);
        }
        warp.step(&mut addrs).unwrap();

        assert_eq!(warp.paths().count(), 1);
        assert_eq!(warp.active().pc, 4);
        assert_eq!(addrs, addrs_before);
    }

    #[test]
    fn a_basic_warp_run() {
        // The first and the last thread, so the test holds for any geometry.
        const LAST: usize = THREADS_PER_WARP - 1;
        let mut addrs = rom_of(&[
            0x00000393, // addi x7, x0, 0
            0x00138393, // addi x7, x7, 1
            0xFFDFF0EF, // jal x1, -4
        ]);
        let addrs_before = addrs.clone();

        let mut warp = Warp::new(0);
        warp.step(&mut addrs).unwrap();
        assert_eq!(warp.active().pc, 4);
        assert_eq!(warp.thread(0).xregs.read(7), 0);
        assert_eq!(warp.thread(LAST).xregs.read(7), 0);

        for i in 1..1_000_000u32 {
            warp.step(&mut addrs).unwrap();
            warp.step(&mut addrs).unwrap();
            assert_eq!(warp.active().pc, 4);
            assert_eq!(warp.thread(0).xregs.read(1), 12);
            assert_eq!(warp.thread(LAST).xregs.read(1), 12);
            assert_eq!(warp.thread(0).xregs.read(7), i);
            assert_eq!(warp.thread(LAST).xregs.read(7), i);
        }
        assert_eq!(addrs, addrs_before);
    }

    #[test]
    fn an_illegal_instruction_changes_nothing() {
        let mut addrs = rom_of(&[0x0010D0D3]); // fadd.s f1, f1, f1 with rm = 101
        let addrs_before = addrs.clone();

        let mut warp = Warp::new(0);
        let before = warp.clone();
        assert_eq!(warp.step(&mut addrs), Err(Illegal::ReservedRoundingMode));
        assert_eq!(warp, before);
        assert_eq!(addrs, addrs_before);
    }

    // Which new path becomes active after a split is a choice point
    // (spec/EXECUTION-MODEL.md §2), so the tests below look at every path and
    // never at which one is active.

    #[test]
    fn a_branch_all_threads_agree_on_keeps_one_path() {
        let mut addrs = rom_of(&[
            0x00000463, // 0x0: beq x0, x0, 8   taken
            0x00000013, // 0x4: addi x0, x0, 0
            0xFE001CE3, // 0x8: bne x0, x0, -8  not taken
            0xFE005AE3, // 0xc: bge x0, x0, -12 taken
        ]);
        let addrs_before = addrs.clone();
        let mut warp = Warp::new(0);
        for expected_pc in [0x8, 0xc, 0x0] {
            warp.step(&mut addrs).unwrap();
            assert_eq!(warp.paths().count(), 1);
            assert_eq!(warp.active().pc, expected_pc);
        }
        assert_eq!(addrs, addrs_before);
    }

    #[test]
    fn a_branch_threads_disagree_on_splits_the_path_by_outcome() {
        let mut addrs = rom_of(&[0x00029663]); // bne x5, x0, 12
        let addrs_before = addrs.clone();
        let mut warp = Warp::new(0);
        for t in warp.threads_mut() {
            t.xregs.write(5, (t.thread_id % 2) as u32);
        }
        warp.step(&mut addrs).unwrap();

        assert_eq!(warp.paths().count(), 2);
        for tid in 0..THREADS_PER_WARP {
            let expected_pc = if tid % 2 == 1 { 12 } else { 4 };
            assert_eq!(warp.path(tid).pc, expected_pc, "thread {tid}");
        }
        assert_eq!(addrs, addrs_before);
    }

    #[test]
    fn jalr_splits_the_path_by_target_and_links_every_thread() {
        let mut addrs = rom_of(&[0x008280E7]); // jalr x1, 8(x5)
        let addrs_before = addrs.clone();
        let mut warp = Warp::new(0);
        for t in warp.threads_mut() {
            t.xregs.write(5, 0x100 + 4 * (t.thread_id % 3) as u32);
        }
        warp.step(&mut addrs).unwrap();

        assert_eq!(warp.paths().count(), THREADS_PER_WARP.min(3));
        for tid in 0..THREADS_PER_WARP {
            assert_eq!(warp.path(tid).pc, 0x108 + 4 * (tid % 3) as u32, "thread {tid}");
            assert_eq!(warp.thread(tid).xregs.read(1), 4, "thread {tid}");
        }
        assert_eq!(addrs, addrs_before);
    }

    #[test]
    fn jalr_reads_rs1_before_linking_and_clears_bit_0_of_the_target() {
        // RISC-V unprivileged ISA, "Unconditional Jumps": the target is
        // rs1 + imm with its least-significant bit set to zero.
        let mut addrs = rom_of(&[0x010282E7]); // jalr x5, 16(x5)
        let addrs_before = addrs.clone();
        let mut warp = Warp::new(0);
        for t in warp.threads_mut() {
            t.xregs.write(5, 0x101);
        }
        warp.step(&mut addrs).unwrap();

        assert_eq!(warp.paths().count(), 1);
        assert_eq!(warp.active().pc, 0x110);
        assert_eq!(warp.thread(0).xregs.read(5), 4);
        assert_eq!(addrs, addrs_before);
    }
}
