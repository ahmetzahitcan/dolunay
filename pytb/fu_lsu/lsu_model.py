"""The reference model of the load/store unit.

This is the Python version of the model in the SystemVerilog testbench
(tb/tb_fu_lsu.sv). It does not use any of the LSU's RTL, including the read
and the write formatter, so a mistake in those is caught as well.

The model has three parts:

  * the address decode, which is the bank mapping of params_pkg,
  * the store and the load formatting, which mirror the two formatters,
  * the arbitration, which is the loop every bank serves its lowest numbered
    pending thread in and the losers are retried.

Two details of the store formatting are easy to get wrong, and both of them
look like a bug in the RTL rather than in the model:

  * a half store is replicated into *both* halves of the word, so lane 1
    gets data[15:8] and not data[7:0],
  * and a half store at alignment 2 is still replicated into both halves, so
    lane 2 gets data[7:0] and lane 3 gets data[15:8].

The model knows nothing about the packed structs of the operation and of the
result: the harness (pytb/fu_lsu/tb_fu_lsu_cocotb.sv) packs and unpacks
them, because only SystemVerilog knows where their fields are. What the
model does know is how a thread's data is laid out in a simd_data_t, which
is a packed array: thread i is in bits [i*RLEN +: RLEN].
"""

from __future__ import annotations

from enum import IntEnum
from dataclasses import dataclass, field

# -----------------------------------------------------------------------------
# The parameters of the design
# -----------------------------------------------------------------------------

RLEN = 32  # the width of a register
N_THREADS = 32  # the threads of a warp
N_SPAD_BANKS = 32  # the banks of the scratchpad
SPAD_BANK_DEPTH = 1024  # the words of a bank
ADDR_ALIGN = 4  # the bytes of a word


# -----------------------------------------------------------------------------
# The enums of the instruction
#
# The RTL has them as int enums and the harness hands them over as they are,
# so they are int enums here too.
# -----------------------------------------------------------------------------


class MemOpsize(IntEnum):
    """The size of a memory access."""

    BYTE = 0
    HALF = 1
    WORD = 2


class MemLoadstore(IntEnum):
    """What a memory access does."""

    LOAD = 0
    STORE = 1


class MemExtendmode(IntEnum):
    """How a loaded value is extended."""

    SIGN = 0
    ZERO = 1


@dataclass
class Operation:
    """One memory operation, as the LSU is given it."""

    mask: int = 0
    rs1: list[int] = field(default_factory=lambda: [0] * N_THREADS)
    rs2: list[int] = field(default_factory=lambda: [0] * N_THREADS)
    opsize: MemOpsize = MemOpsize.WORD
    imm: int = 0
    loadstore: MemLoadstore = MemLoadstore.LOAD
    extendmode: MemExtendmode = MemExtendmode.SIGN


# -----------------------------------------------------------------------------
# The threads of a simd_data_t
#
# A simd_data_t is a packed array of the threads, so thread i is in the bits
# [i*RLEN +: RLEN]. The testbench checks the widths of the signals against
# the parameters above, so that a change of them is caught.
# -----------------------------------------------------------------------------

def thread(data: int, index: int) -> int:
    """The value of one thread of a simd_data_t."""
    return (data >> (index * RLEN)) & ((1 << RLEN) - 1)


def pack_threads(values: list[int]) -> int:
    """The per thread values as one simd_data_t."""
    data = 0
    for index, value in enumerate(values):
        data |= (value & ((1 << RLEN) - 1)) << (index * RLEN)
    return data


# -----------------------------------------------------------------------------
# The address decode
#
# The word address w = addr >> 2 is split into three five bit fields, and the
# bank is their xor. This is the mapping of params_pkg (spad_bank_of and
# spad_offset_of).
# -----------------------------------------------------------------------------

W_SPAD_BANK_ADDR = 12  # $clog2(SPAD_BANK_DEPTH) + $clog2(ADDR_ALIGN)
Z_ADDR = 2  # $clog2(ADDR_ALIGN)


def spad_bank_of(addr: int) -> int:
    """The bank a byte address belongs to."""
    a = (addr >> 12) & 0x1F  # addr[16:12], the region
    b = (addr >> 7) & 0x1F  # addr[11:7]
    ell = (addr >> 2) & 0x1F  # addr[6:2], the lane
    return a ^ b ^ ell


def spad_offset_of(addr: int) -> int:
    """The position of a byte address inside its bank."""
    return (addr >> Z_ADDR) & 0x3FF


def addr_of(bank: int, offset: int) -> int:
    """The address of a (bank, offset) in the scratchpad.

    The bank mapping is a permutation, so it can be inverted.
    """
    b = (offset >> 5) & 0x1F
    ell = offset & 0x1F
    a = (bank & 0x1F) ^ b ^ ell
    return (a << 12) | (b << 7) | (ell << 2)


# -----------------------------------------------------------------------------
# The store formatting
# -----------------------------------------------------------------------------

def store_wen(opsize: MemOpsize, align: int) -> int:
    """The byte enables a store of the given size and alignment writes.

    This mirrors mem_write_formatter, but it is written out again here so
    that a mistake in the formatter is caught.
    """
    if opsize == MemOpsize.BYTE:
        return 1 << align
    if opsize == MemOpsize.HALF:
        if align == 0:
            return 0b0011
        if align == 2:
            return 0b1100
        return 0
    return 0b1111


def store_byte(opsize: MemOpsize, data: int, lane: int) -> int:
    """The byte a store of the given size writes into the given lane.

    A byte store replicates the byte into every lane. A half store puts the
    half into the two lanes, and the formatter replicates the half into both
    halves of the word, so lane 2 gets the same byte as lane 0. A word store
    keeps the word as it is.
    """
    if opsize == MemOpsize.BYTE:
        return data & 0xFF
    if opsize == MemOpsize.HALF:
        return (data >> ((lane % 2) * 8)) & 0xFF
    return (data >> (lane * 8)) & 0xFF


# -----------------------------------------------------------------------------
# The load formatting
# -----------------------------------------------------------------------------

def load_value(
    word: int, align: int, opsize: MemOpsize, extendmode: MemExtendmode
) -> int:
    """The value a load of the given size and alignment produces.

    This mirrors mem_read_formatter.
    """
    byte_v = (word >> (align * 8)) & 0xFF
    if align == 0:
        half_v = word & 0xFFFF
    elif align == 2:
        half_v = (word >> 16) & 0xFFFF
    else:
        half_v = 0
    word_v = word & 0xFFFFFFFF if align == 0 else 0

    if opsize == MemOpsize.BYTE:
        value, width = byte_v, 8
    elif opsize == MemOpsize.HALF:
        value, width = half_v, 16
    else:
        value, width = word_v, 32

    if width == RLEN:
        return value & 0xFFFFFFFF
    if extendmode == MemExtendmode.SIGN and (value >> (width - 1)) & 1:
        value |= ((1 << (RLEN - width)) - 1) << width
    return value & 0xFFFFFFFF


# -----------------------------------------------------------------------------
# The arbitration
# -----------------------------------------------------------------------------

def arbitrate(op: Operation, mem: list[list[int]]) -> int:
    """The arbitration, and the stores it performs.

    Every bank serves its lowest numbered pending thread in every cycle, and
    the threads that lost are retried in the following cycles. The number of
    cycles the operation takes is therefore the largest number of threads
    that land on any one bank.

    The shadow copy of the scratchpad is updated with the stores, in the
    order the LSU performs them: the threads of a bank are served in
    increasing thread number, so a later thread overwrites an earlier one.
    """
    per_bank: list[list[int]] = [[] for _ in range(N_SPAD_BANKS)]
    for index in range(N_THREADS):
        if (op.mask >> index) & 1:
            addr = (op.rs1[index] + op.imm) & 0xFFFFFFFF
            per_bank[spad_bank_of(addr)].append(index)

    cycles = max((len(threads) for threads in per_bank), default=0)

    if op.loadstore == MemLoadstore.STORE:
        for bank, threads in enumerate(per_bank):
            for index in threads:
                addr = (op.rs1[index] + op.imm) & 0xFFFFFFFF
                offset = spad_offset_of(addr)
                wen = store_wen(op.opsize, addr & (ADDR_ALIGN - 1))
                word = mem[bank][offset]
                for lane in range(ADDR_ALIGN):
                    if (wen >> lane) & 1:
                        byte = store_byte(op.opsize, op.rs2[index], lane)
                        word = (word & ~(0xFF << (lane * 8))) | (byte << (lane * 8))
                mem[bank][offset] = word

    return cycles


# -----------------------------------------------------------------------------
# The initial pattern of the scratchpad
# -----------------------------------------------------------------------------

def spad_pattern(bank: int, offset: int) -> int:
    """The word a bank holds at an offset before the test starts.

    Every byte depends on both the bank and the offset, so a routing
    mistake shows up.
    """
    return ((bank << 24) | (offset << 8) | ((bank + offset) & 0xFF)) & 0xFFFFFFFF
