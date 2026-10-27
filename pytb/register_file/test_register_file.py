"""cocotb testbench for the SIMD register file.

This is the cocotb version of tb/tb_register_file.sv, which is still there
and still works. The ten spec sections of the SystemVerilog testbench are
the ten tests here.

The register file is a pool of N_PHYS_REGS registers per thread, with two
identical read/write ports. A port presents one address, one per-thread
write-enable mask and one write-data vector, and returns the register at
that address. The read is registered, so the data appears one cycle after
the address was presented, and a port that writes the address it reads in
the same cycle returns the value from before the write.

The timing convention is the one the SystemVerilog testbenches in tb/ use:
the inputs are driven on the falling edge and the outputs are sampled on the
falling edge, so nothing races with the clock edge.
"""

from __future__ import annotations

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge

CLK_PERIOD_NS = 10

# The parameters of the design, which the model has to have. The tests check
# the widths of the signals against them, so that a change of one of them is
# caught.
N_THREADS = 32
RLEN = 32
N_PHYS_REGS = 512  # N_WARPS * N_REGFILES * N_REGISTERS
W_PHYS_REGS = (N_PHYS_REGS - 1).bit_length()  # $clog2(N_PHYS_REGS)

ALL_THREADS = (1 << N_THREADS) - 1


# -----------------------------------------------------------------------------
# The threads of a simd_data_t
#
# A simd_data_t is a packed array of the threads, so thread i is in the bits
# [i*RLEN +: RLEN].
# -----------------------------------------------------------------------------


def thread_value(data: int, index: int) -> int:
    """The value of one thread of a simd_data_t."""
    return (data >> (index * RLEN)) & ((1 << RLEN) - 1)


def pack_threads(values: list[int]) -> int:
    """The per thread values as one simd_data_t."""
    data = 0
    for index, value in enumerate(values):
        data |= (value & ((1 << RLEN) - 1)) << (index * RLEN)
    return data


def make_pattern(tag: int) -> int:
    """A per thread pattern: the value is {tag, thread index}."""
    return pack_threads([(tag << 16) | index for index in range(N_THREADS)])


def merge(mask: int, new: int, old: int) -> int:
    """The result of writing `new` under the write-enable `mask` over `old`.

    The threads whose write-enable is off keep the value they had.
    """
    data = 0
    for index in range(N_THREADS):
        value = (
            thread_value(new, index)
            if (mask >> index) & 1
            else thread_value(old, index)
        )
        data |= value << (index * RLEN)
    return data


def expect_simd(got: int, expected: int, what: str) -> None:
    """Check that two thread vectors are the same."""
    for index in range(N_THREADS):
        if thread_value(got, index) != thread_value(expected, index):
            raise AssertionError(
                f"{what} (thread {index}: expected "
                f"{thread_value(expected, index):08x}, "
                f"got {thread_value(got, index):08x})"
            )


# -----------------------------------------------------------------------------
# Driving the register file
# -----------------------------------------------------------------------------


class RegisterFile:
    """The register file, and the way it is driven."""

    def __init__(self, dut) -> None:
        self.dut = dut

    async def reset(self) -> None:
        """Clear the inputs and let the simulation-only init finish.

        The register file initialises its registers to a pattern for the
        first two clock edges, so that a register that is never written is
        not X.
        """
        dut = self.dut
        dut.porta_idx_i.value = 0
        dut.porta_write_en_mask_i.value = 0
        dut.porta_write_data_i.value = 0
        dut.portb_idx_i.value = 0
        dut.portb_write_en_mask_i.value = 0
        dut.portb_write_data_i.value = 0

        for _ in range(4):
            await RisingEdge(dut.clk)
        await FallingEdge(dut.clk)

    def check_shape(self) -> None:
        """The signals have to be as wide as the model thinks they are."""
        dut = self.dut
        assert len(dut.porta_idx_i.value) == W_PHYS_REGS, (
            f"the index is {len(dut.porta_idx_i.value)} bits wide, the model "
            f"thinks it is {W_PHYS_REGS}"
        )
        assert len(dut.porta_write_en_mask_i.value) == N_THREADS, (
            f"the write-enable mask is {len(dut.porta_write_en_mask_i.value)} "
            f"bits wide, the model thinks it is {N_THREADS}"
        )
        assert len(dut.porta_write_data_i.value) == N_THREADS * RLEN, (
            f"the thread data is {len(dut.porta_write_data_i.value)} bits wide, "
            f"the model thinks it is {N_THREADS * RLEN}"
        )

    async def read_a(self, index: int) -> int:
        """Read a register on port A."""
        dut = self.dut
        await FallingEdge(dut.clk)
        dut.porta_idx_i.value = index
        dut.porta_write_en_mask_i.value = 0
        await FallingEdge(dut.clk)
        return int(dut.porta_data_o.value)

    async def read_b(self, index: int) -> int:
        """Read a register on port B."""
        dut = self.dut
        await FallingEdge(dut.clk)
        dut.portb_idx_i.value = index
        dut.portb_write_en_mask_i.value = 0
        await FallingEdge(dut.clk)
        return int(dut.portb_data_o.value)

    async def write_a(self, index: int, mask: int, data: int) -> None:
        """Write a register on port A."""
        dut = self.dut
        await FallingEdge(dut.clk)
        dut.porta_idx_i.value = index
        dut.porta_write_en_mask_i.value = mask
        dut.porta_write_data_i.value = data
        await RisingEdge(dut.clk)
        await FallingEdge(dut.clk)
        dut.porta_write_en_mask_i.value = 0

    async def write_b(self, index: int, mask: int, data: int) -> None:
        """Write a register on port B."""
        dut = self.dut
        await FallingEdge(dut.clk)
        dut.portb_idx_i.value = index
        dut.portb_write_en_mask_i.value = mask
        dut.portb_write_data_i.value = data
        await RisingEdge(dut.clk)
        await FallingEdge(dut.clk)
        dut.portb_write_en_mask_i.value = 0

    async def readwrite_a(self, index: int, mask: int, data: int) -> int:
        """Write a register and read it in the same cycle on port A.

        Returns the value the read gave, which is the one from before the
        write.
        """
        dut = self.dut
        await FallingEdge(dut.clk)
        dut.porta_idx_i.value = index
        dut.porta_write_en_mask_i.value = mask
        dut.porta_write_data_i.value = data
        await FallingEdge(dut.clk)
        value = int(dut.porta_data_o.value)
        dut.porta_write_en_mask_i.value = 0
        return value

    async def readwrite_b(self, index: int, mask: int, data: int) -> int:
        """Write a register and read it in the same cycle on port B.

        Returns the value the read gave, which is the one from before the
        write.
        """
        dut = self.dut
        await FallingEdge(dut.clk)
        dut.portb_idx_i.value = index
        dut.portb_write_en_mask_i.value = mask
        dut.portb_write_data_i.value = data
        await FallingEdge(dut.clk)
        value = int(dut.portb_data_o.value)
        dut.portb_write_en_mask_i.value = 0
        return value

    async def read_both(self, index_a: int, index_b: int) -> tuple[int, int]:
        """Read two registers, one on each port, in the same cycle."""
        dut = self.dut
        await FallingEdge(dut.clk)
        dut.porta_idx_i.value = index_a
        dut.portb_idx_i.value = index_b
        dut.porta_write_en_mask_i.value = 0
        dut.portb_write_en_mask_i.value = 0
        await FallingEdge(dut.clk)
        return int(dut.porta_data_o.value), int(dut.portb_data_o.value)

    async def write_both(
        self,
        index_a: int,
        mask_a: int,
        data_a: int,
        index_b: int,
        mask_b: int,
        data_b: int,
    ) -> None:
        """Write two registers, one on each port, in the same cycle."""
        dut = self.dut
        await FallingEdge(dut.clk)
        dut.porta_idx_i.value = index_a
        dut.porta_write_en_mask_i.value = mask_a
        dut.porta_write_data_i.value = data_a
        dut.portb_idx_i.value = index_b
        dut.portb_write_en_mask_i.value = mask_b
        dut.portb_write_data_i.value = data_b
        await RisingEdge(dut.clk)
        await FallingEdge(dut.clk)
        dut.porta_write_en_mask_i.value = 0
        dut.portb_write_en_mask_i.value = 0


async def setup(dut) -> RegisterFile:
    """Start the clock and reset the register file."""
    # In cocotb 2.x the clock starts itself: start() schedules the driver
    # task and returns it, so it must not be handed to start_soon() as well.
    Clock(dut.clk, CLK_PERIOD_NS, unit="ns").start()
    register_file = RegisterFile(dut)
    register_file.check_shape()
    await register_file.reset()
    return register_file


# -----------------------------------------------------------------------------
# The spec sections
# -----------------------------------------------------------------------------


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_a_port_b_write_is_seen_by_both_ports(dut):
    """A. A write on port B is seen by both ports."""
    register_file = await setup(dut)

    pattern = make_pattern(0x1111)
    await register_file.write_b(5, ALL_THREADS, pattern)
    expect_simd(
        await register_file.read_a(5),
        pattern,
        "port A reads the value written by port B",
    )
    expect_simd(
        await register_file.read_b(5),
        pattern,
        "port B reads the value written by port B",
    )


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_b_port_a_write_is_seen_by_both_ports(dut):
    """B. A write on port A is seen by both ports."""
    register_file = await setup(dut)

    pattern = make_pattern(0x2222)
    await register_file.write_a(7, ALL_THREADS, pattern)
    expect_simd(
        await register_file.read_a(7),
        pattern,
        "port A reads the value written by port A",
    )
    expect_simd(
        await register_file.read_b(7),
        pattern,
        "port B reads the value written by port A",
    )


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_c_index_zero_is_an_ordinary_register(dut):
    """C. Index 0 is an ordinary register, with no special zero handling."""
    register_file = await setup(dut)

    pattern = make_pattern(0xABCD)
    await register_file.write_a(0, ALL_THREADS, pattern)
    expect_simd(
        await register_file.read_a(0),
        pattern,
        "port A reads index 0 back (no zero forcing)",
    )
    expect_simd(
        await register_file.read_b(0),
        pattern,
        "port B reads index 0 back (no zero forcing)",
    )


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_d_read_before_write_on_port_b(dut):
    """D. A read and a write to the same register on port B in one cycle gives
    the value from before the write."""
    register_file = await setup(dut)

    old = make_pattern(0x0A0A)
    new = make_pattern(0x0B0B)
    await register_file.write_b(9, ALL_THREADS, old)
    expect_simd(
        await register_file.readwrite_b(9, ALL_THREADS, new),
        old,
        "the same-cycle port B read returns the pre-write value",
    )
    expect_simd(
        await register_file.read_b(9),
        new,
        "the port B value updates on the next read",
    )


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_e_read_before_write_on_port_a(dut):
    """E. A read and a write to the same register on port A in one cycle gives
    the value from before the write."""
    register_file = await setup(dut)

    old = make_pattern(0x1C1C)
    new = make_pattern(0x1D1D)
    await register_file.write_a(10, ALL_THREADS, old)
    expect_simd(
        await register_file.readwrite_a(10, ALL_THREADS, new),
        old,
        "the same-cycle port A read returns the pre-write value",
    )
    expect_simd(
        await register_file.read_a(10),
        new,
        "the port A value updates on the next read",
    )


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_f_per_thread_write_masking(dut):
    """F. A thread whose write-enable is off keeps the value it had.

    The masking is done through both ports, so that a masking bug on
    either of them is caught.
    """
    register_file = await setup(dut)

    baseline = make_pattern(0xAAAA)
    new = make_pattern(0x3333)

    # Only the lower half of the threads is written.
    mask_low = (1 << (N_THREADS // 2)) - 1

    # Through port A.
    await register_file.write_b(11, ALL_THREADS, baseline)
    await register_file.write_a(11, mask_low, new)
    expect_simd(
        await register_file.read_b(11),
        merge(mask_low, new, baseline),
        "only the unmasked threads keep the old value (port A)",
    )

    # And through port B.
    await register_file.write_b(12, ALL_THREADS, baseline)
    await register_file.write_b(12, mask_low, new)
    expect_simd(
        await register_file.read_a(12),
        merge(mask_low, new, baseline),
        "only the unmasked threads keep the old value (port B)",
    )


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_g_the_top_index_works(dut):
    """G. The last register of the pool can be addressed."""
    register_file = await setup(dut)

    top = N_PHYS_REGS - 1
    pattern = make_pattern(0x7777)
    await register_file.write_b(top, ALL_THREADS, pattern)
    expect_simd(
        await register_file.read_a(top),
        pattern,
        "port A reads the top index back",
    )
    expect_simd(
        await register_file.read_b(top),
        pattern,
        "port B reads the top index back",
    )


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_h_distinct_indices_are_independent(dut):
    """H. Two registers hold their own values."""
    register_file = await setup(dut)

    low = make_pattern(0x4444)
    high = make_pattern(0x5555)
    await register_file.write_b(20, ALL_THREADS, low)
    await register_file.write_b(21, ALL_THREADS, high)
    expect_simd(
        await register_file.read_a(20), low, "index 20 holds its own value"
    )
    expect_simd(
        await register_file.read_a(21), high, "index 21 holds its own value"
    )


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_i_the_ports_read_independent_indices(dut):
    """I. The two ports read two different registers in the same cycle."""
    register_file = await setup(dut)

    low = make_pattern(0x4444)
    high = make_pattern(0x5555)
    await register_file.write_b(20, ALL_THREADS, low)
    await register_file.write_b(21, ALL_THREADS, high)

    got_a, got_b = await register_file.read_both(20, 21)
    expect_simd(got_a, low, "port A reads index 20 in a shared cycle")
    expect_simd(got_b, high, "port B reads index 21 in a shared cycle")


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_j_both_ports_write_distinct_indices(dut):
    """J. The two ports write two different registers in the same cycle."""
    register_file = await setup(dut)

    low = make_pattern(0x6666)
    high = make_pattern(0x8888)
    await register_file.write_both(30, ALL_THREADS, low, 31, ALL_THREADS, high)
    expect_simd(
        await register_file.read_a(30), low, "the port A index holds its value"
    )
    expect_simd(
        await register_file.read_b(31), high, "the port B index holds its value"
    )
