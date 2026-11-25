//! The machine's geometry. Every other module reads it from here and assumes
//! nothing about its value (AGENTS.md §4).
//!
//! Geometry is undecided (CONTRACT.md §2). The value below is a placeholder,
//! carried over from the Zig skeleton, until it is.

/// Threads per warp. Placeholder.
pub const THREADS_PER_WARP: usize = 32;

// Warps per machine. Placeholder.
pub const WARPS_PER_MACHINE: usize = 32;

// Initial PC value.
pub const INITIAL_PC: u32 = 0;