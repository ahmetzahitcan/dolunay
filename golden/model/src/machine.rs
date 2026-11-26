use std::array;

use crate::{address_space::AddressSpace, geometry::WARPS_PER_MACHINE, illegal::Illegal, warp::Warp};

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Machine {
    warps: [Warp; WARPS_PER_MACHINE],
    address_space: AddressSpace,
}

// Constructors
impl Machine {
    pub fn new(address_space: AddressSpace) -> Self {
        Self {
            warps: array::from_fn(|wid| Warp::new(wid)),
            address_space,
        }
    }
}

// Step functions
impl Machine {
    /// Steps through warps in order using an iterator of warp IDs. 
    /// If error occurs, returns the error and the warp ID that triggered it.
    /// Any warps after the erring warp are not stepped.
    pub fn step_with(&mut self, warp_ids: impl IntoIterator<Item = usize>) -> Result<(), (usize, Illegal)> {
        for wid in warp_ids.into_iter() {
            self.warps[wid as usize].step(&mut self.address_space).map_err(|e| (wid, e))?;
        }
        Ok(())
    } 

    /// Steps one warp. If error occurs, returns the error.
    pub fn step_one(&mut self, warp_id: usize) -> Result<(), Illegal> {
        self.warps[warp_id as usize].step(&mut self.address_space)
    }

    /// Steps all warps in order of lowest ID to highest ID.
    /// If error occurs, returns the error and the warp ID that triggered it.
    /// Any warps after the erring warp are not stepped.
    pub fn step_all(&mut self) -> Result<(), (usize, Illegal)> {
        self.step_with(0..WARPS_PER_MACHINE)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::address_space::ROM_SIZE;

    // Every warp starts at INITIAL_PC and runs the same program, so a warp's
    // PC tells how many steps it has taken. LAST is the last warp, so the
    // tests hold for any geometry with at least two warps.
    const LAST: usize = WARPS_PER_MACHINE - 1;
    const NOP: u32 = 0x00000013; // addi x0, x0, 0

    /// A ROM holding `words` from address 0.
    fn rom_of(words: &[u32]) -> AddressSpace {
        let mut rom = [0; ROM_SIZE];
        for (i, w) in words.iter().enumerate() {
            rom[4 * i..4 * i + 4].copy_from_slice(&w.to_le_bytes());
        }
        AddressSpace::new(rom)
    }

    fn pc_of(machine: &Machine, warp_id: usize) -> u32 {
        machine.warps[warp_id as usize].active().pc
    }

    #[test]
    fn step_one_steps_only_that_warp() {
        let mut machine = Machine::new(rom_of(&[NOP]));
        let addrs_before = machine.address_space.clone();
        machine.step_one(LAST).unwrap();

        for wid in 0..WARPS_PER_MACHINE {
            let expected_pc = if wid == LAST { 4 } else { 0 };
            assert_eq!(pc_of(&machine, wid), expected_pc, "warp {wid}");
        }
        assert_eq!(machine.address_space, addrs_before);
    }

    #[test]
    fn step_with_steps_a_warp_once_per_occurrence() {
        let mut machine = Machine::new(rom_of(&[NOP, NOP]));
        let addrs_before = machine.address_space.clone();
        machine.step_with([0, LAST, 0]).unwrap();

        for wid in 0..WARPS_PER_MACHINE {
            let expected_pc = match wid { 0 => 8, LAST => 4, _ => 0 };
            assert_eq!(pc_of(&machine, wid), expected_pc, "warp {wid}");
        }
        assert_eq!(machine.address_space, addrs_before);
    }

    #[test]
    fn step_all_steps_every_warp_once() {
        let mut machine = Machine::new(rom_of(&[NOP]));
        let addrs_before = machine.address_space.clone();
        machine.step_all().unwrap();

        for wid in 0..WARPS_PER_MACHINE {
            assert_eq!(pc_of(&machine, wid), 4, "warp {wid}");
        }
        assert_eq!(machine.address_space, addrs_before);
    }

    #[test]
    fn step_with_stops_at_an_illegal_step_and_names_its_warp() {
        let mut machine = Machine::new(rom_of(&[
            NOP,
            0x0010D0D3, // fadd.s f1, f1, f1 with rm = 101
        ]));
        let addrs_before = machine.address_space.clone();
        machine.step_one(LAST).unwrap();
        let last_before = machine.warps[LAST as usize].clone();

        assert_eq!(machine.step_with([0, LAST, 0]), Err((LAST, Illegal::ReservedRoundingMode)));
        // Warp 0's first step stands; its second is never taken, and the
        // illegal step changes nothing.
        assert_eq!(pc_of(&machine, 0), 4);
        assert_eq!(machine.warps[LAST as usize], last_before);
        assert_eq!(machine.address_space, addrs_before);
    }
}
