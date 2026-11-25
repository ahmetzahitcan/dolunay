use std::array;

use crate::{address_space::AddressSpace, geometry::WARPS_PER_MACHINE, illegal::Illegal, warp::Warp};

pub struct Machine {
    warps: [Warp; WARPS_PER_MACHINE],
    address_space: AddressSpace,
}

// Constructors
impl Machine {
    pub fn new(address_space: AddressSpace) -> Self {
        Self {
            warps: array::from_fn(|wid| Warp::new(wid as u16)),
            address_space,
        }
    }
}

// Step functions
impl Machine {
    /// Steps through warps. Warps are selected using an iterator of warp IDs. If error occurs, returns the error and the warp ID that triggered it.
    pub fn step_with(&mut self, warp_ids: impl IntoIterator<Item = u16>) -> Result<(), (u16, Illegal)> {
        for wid in warp_ids.into_iter() {
            self.warps[wid as usize].step(&mut self.address_space).map_err(|e| (wid, e))?;
        }
        Ok(())
    } 

    /// Steps one warp. If error occurs, returns the error.
    pub fn step_one(&mut self, warp_id: u16) -> Result<(), Illegal> {
        self.warps[warp_id as usize].step(&mut self.address_space)
    }

    /// Steps all warps. If error occurs, returns the error and the warp ID that triggered it.
    pub fn step_all(&mut self) -> Result<(), (u16, Illegal)> {
        self.step_with((0 as u16)..(WARPS_PER_MACHINE as u16))
    }
}