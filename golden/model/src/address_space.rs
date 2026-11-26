use crate::illegal::Illegal;

const ROM_ADDRESS: u32 = 0x0000_0000;
pub const ROM_SIZE: usize = 4096; // 4 KiB

fn debug_slot(address: u32) -> u8 {
    assert!((0xFFFF_FF00..0xFFFF_FFFF).contains(&address));
    ((address & 0xFC) >> 2) as u8
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Region {
    Rom,
    Unmapped,

    /// A debug unit that will be removed. Not part of the spec!
    Debug,
}

impl Region {
    fn of(address: u32) -> Self {
        if (ROM_ADDRESS..ROM_ADDRESS + ROM_SIZE as u32).contains(&address) {
            Self::Rom
        } else if (0xFFFF_FF00..0xFFFF_FFFF).contains(&address) {
            Self::Debug
        } else {
            Self::Unmapped
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Store {
    region: Region,
    address: u32,
    word: u32,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct AddressSpace {
    rom: [u8; ROM_SIZE],
}

/// The little-endian word at `offset` (RISC-V unprivileged ISA, "Memory").
fn read_int(buffer: &[u8], offset: usize) -> u32 {
    u32::from_le_bytes(buffer[offset..offset + 4].try_into().unwrap())
}

impl AddressSpace {
    pub fn new(rom: [u8; ROM_SIZE]) -> AddressSpace {
        AddressSpace { rom }
    }

    pub fn load(&self, address: u32) -> Result<u32, Illegal> {
        if address % 4 != 0 {
            return Err(Illegal::UnalignedAccess);
        }

        match Region::of(address) {
            Region::Rom => Ok(read_int(&self.rom, (address - ROM_ADDRESS) as usize)),
            Region::Debug => {
                let slot = debug_slot(address);
                println!("Load from debug slot {slot}, returning 0");
                Ok(0)
            },
            Region::Unmapped => Err(Illegal::UnmappedAddress),
        }
    }
    
    pub fn eval_store(&self, address: u32, word: u32) -> Result<Store, Illegal> {
        if address % 4 != 0 {
            return Err(Illegal::UnalignedAccess);
        }

        let region = Region::of(address);
        match region {
            Region::Rom => Err(Illegal::StoreToRom),
            Region::Debug => Ok(Store { region, address, word }),
            Region::Unmapped => Err(Illegal::UnmappedAddress),
        }
    }

    pub fn commit_store(&mut self, store: Store) {
        debug_assert_eq!(store.region, Region::of(store.address));

        match store.region {
            Region::Debug => {
                let word = store.word;
                let slot = debug_slot(store.address);
                println!("Store word 0x{word:X} into debug slot {slot}");
            },

            _ => unreachable!()
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn load() {
        let mut rom = [0; ROM_SIZE];
        rom[..4].copy_from_slice(&[0x01, 0x02, 0x03, 0x04]);
        let address_space = AddressSpace::new(rom);

        assert_eq!(address_space.load(0x0000_0000), Ok(0x04030201));
        assert_eq!(address_space.load(0x0000_0001), Err(Illegal::UnalignedAccess));
        assert_eq!(address_space.load(0x0000_1000), Err(Illegal::UnmappedAddress));
        assert_eq!(address_space.load(0x0001_0000), Err(Illegal::UnmappedAddress));
    }
}
