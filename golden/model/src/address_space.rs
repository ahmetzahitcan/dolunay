#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Error {
    UnmappedAddress,
    UnalignedAccess,
}

const ROM_ADDRESS: u32 = 0x0000_0000;
pub const ROM_SIZE: usize = 4096; // 4 KiB

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

    pub fn load(&self, address: u32) -> Result<u32, Error> {
        if address % 4 != 0 {
            return Err(Error::UnalignedAccess);
        }

        if (ROM_ADDRESS..ROM_ADDRESS + ROM_SIZE as u32).contains(&address) {
            Ok(read_int(&self.rom, (address - ROM_ADDRESS) as usize))
        } else {
            Err(Error::UnmappedAddress)
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
        assert_eq!(address_space.load(0x0000_0001), Err(Error::UnalignedAccess));
        assert_eq!(address_space.load(0x0000_1000), Err(Error::UnmappedAddress));
        assert_eq!(address_space.load(0x0001_0000), Err(Error::UnmappedAddress));
    }
}
