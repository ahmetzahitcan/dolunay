//! RV32I integer operations that are more than one Rust operator.

/// The shift amount: the low 5 bits of the operand (RISC-V unprivileged ISA,
/// RV32I, "Integer Computational Instructions").
fn shamt(amount: u32) -> u32 {
    amount & 0x1F
}

pub fn shl(a: u32, amount: u32) -> u32 {
    a << shamt(amount)
}

pub fn shr(a: u32, amount: u32) -> u32 {
    a >> shamt(amount)
}

pub fn sra(a: u32, amount: u32) -> u32 {
    ((a as i32) >> shamt(amount)) as u32
}

pub fn less_signed(a: u32, b: u32) -> u32 {
    ((a as i32) < (b as i32)) as u32
}

pub fn less_unsigned(a: u32, b: u32) -> u32 {
    (a < b) as u32
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn shifts_use_the_low_5_bits_of_the_amount() {
        assert_eq!(shl(0x8000_0010, 33), 0x0000_0020);
        assert_eq!(shr(0x8000_0010, 33), 0x4000_0008);
        assert_eq!(sra(0x8000_0010, 33), 0xC000_0008);
        // srai's immediate as the decoder gives it: imm = 0x404 shifts by 4.
        assert_eq!(sra(0x8000_0010, 0x404), 0xF800_0001);
    }

    #[test]
    fn less_signed_is_signed_and_less_unsigned_unsigned() {
        assert_eq!(less_signed(0xFFFF_FFFF, 1), 1);
        assert_eq!(less_unsigned(0xFFFF_FFFF, 1), 0);
        // sltiu x, y, -1 is true for every value except 0xFFFFFFFF.
        assert_eq!(less_unsigned(1, 0xFFFF_FFFF), 1);
    }
}
