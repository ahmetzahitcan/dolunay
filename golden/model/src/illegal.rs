use crate::float;

/// Acts the spec makes illegal, detected while executing an instruction. A run
/// that hits one ends as `illegal` (CONTRACT.md §1, guarantee 2; §4).
/// 
/// TODO: Put some debug info here!
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Illegal {
    /// rm = 101 or 110 (`float::Error::ReservedRoundingMode`).
    ReservedRoundingMode,
    /// A word that decodes to no instruction, a fetch from an unmapped
    /// address, or a field value RISC-V assigns no instruction to, such as
    /// funct3 = 011 in FSGNJ_S or FCMP_S (FINDINGS.md F7).
    IllegalInstruction,
    UnmappedAddress,
    UnalignedAccess,
    StoreToRom,
    StoreConflict
}

impl From<float::Error> for Illegal {
    fn from(e: float::Error) -> Illegal {
        match e {
            float::Error::ReservedRoundingMode => Illegal::ReservedRoundingMode,
        }
    }
}
