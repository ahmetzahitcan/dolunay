"""cocotb testbench for the load/store unit (fu_lsu).

This replaces the SystemVerilog testbench tb/tb_fu_lsu.sv, which is still
there and still works. The reference model is pytb/fu_lsu/lsu_model.py.

The test groups are the ones of the SystemVerilog testbench:

  1. a load, one thread per bank — the easy case,
  2. a load of bytes and of halves, with sign and zero extension,
  3. all 32 threads on one bank — 32 arbitration cycles, the worst case,
  4. a store, then read it back,
  5. a byte store,
  6. randomised operations,
  7. byte and half stores across 8 offsets and all 4 alignments, with a
     read-back of every word,
  8. back-pressure: the result must be held stable while out_ready_i is low.

The randomised test is the bisection tool: the mode selects loads only,
stores only, single-threaded or word-sized, and the seed makes a failure
reproducible. Both come from the command line, see pytb/run.py.

The timing convention is the one the SystemVerilog testbenches in tb/ use:
the inputs are driven on the falling edge and the outputs are sampled on the
falling edge, so nothing races with the clock edge.
"""

from __future__ import annotations

from enum import Enum
import os
import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, with_timeout

import lsu_model as model

CLK_PERIOD_NS = 10

# How long a single wait for the DUT may take. A stuck DUT has to fail the
# test, not hang the run.
TIMEOUT_NS = 10_000

# The options of the randomised test. They are declared in testbench.toml,
# and the runner hands them over in the environment, named after the
# testbench and the option: DOLUNAY_<TESTBENCH>_<OPTION>.
TESTBENCH = os.environ.get("DOLUNAY_TESTBENCH", "fu_lsu")


def option(name: str, default: str = "") -> str:
    """The value of one of this testbench's options.

    The runner names the variable after the testbench and the option, the
    same way it does here: see option_env in pytb/run.py.
    """
    return os.environ.get(f"DOLUNAY_{TESTBENCH.upper()}_{name.upper()}", default)


class Mode(Enum):
    """What the randomised test generates.

    It is a value a person types, so it is a string enum. The values are
    listed in testbench.toml as well, and the runner refuses anything else.
    """

    MIXED = "mixed"
    LOADS = "loads"
    STORES = "stores"
    SINGLE = "single"
    WORD = "word"


MODE = Mode(option("mode", Mode.MIXED.value))
READBACK = bool(int(option("readback", "0")))
SEED = option("seed") or None


def signal_int(handle) -> int:
    """The value of a signal as an integer. An unknown bit counts as zero.

    Verilator is a two-state simulator, so this only matters for the fields
    the RTL drives with 'x, which the testbench does not look at.
    """
    try:
        return int(handle.value)
    except ValueError:
        bits = str(handle.value)
        for unknown in "xz":
            bits = bits.replace(unknown, "0")
        # A weak zero and a weak one, as Verilator resolves them.
        bits = bits.replace("L", "0").replace("H", "1")
        return int(bits, 2)


class Lsu:
    """The load/store unit under test, and the model of it."""

    def __init__(self, dut, rng: random.Random, name: str) -> None:
        self.dut = dut
        self.rng = rng
        self.name = name
        self.seq = 0
        self.checks = 0
        self.errors = 0

        # The shadow copy of the scratchpad: 32 banks of 1024 words.
        self.mem = [
            [0] * model.SPAD_BANK_DEPTH for _ in range(model.N_SPAD_BANKS)
        ]

        # The operation the next run_op drives.
        self.op = model.Operation()
        self.stall_cycles = 0

    # -------------------------------------------------------------------------
    # Bookkeeping
    # -------------------------------------------------------------------------

    def check(self, ok: bool, what: str) -> bool:
        """Count a check, and report it if it failed."""
        self.checks += 1
        if not ok:
            self.errors += 1
            cocotb.log.error("  FAIL: %s", what)
        return ok

    def finish(self) -> None:
        """Report the checks the test made, and fail if one of them failed."""
        cocotb.log.info(
            "%s: %d checks, %d failures", self.name, self.checks, self.errors
        )
        assert self.errors == 0, (
            f"{self.name}: {self.errors} of {self.checks} checks failed"
        )

    def check_model_fits(self) -> None:
        """The model has to be a model of *this* design.

        The parameters of the design have to be the ones the model has, and
        the thread data has to be as wide as the model thinks it is. If they
        are not, the model is not a model of this design, and every check
        that follows would be meaningless — so the test stops here.
        """
        dut = self.dut
        for name, expected, actual in (
            ("RLEN", model.RLEN, signal_int(dut.param_rlen_o)),
            ("N_THREADS", model.N_THREADS, signal_int(dut.param_n_threads_o)),
            (
                "N_SPAD_BANKS",
                model.N_SPAD_BANKS,
                signal_int(dut.param_n_spad_banks_o),
            ),
            (
                "SPAD_BANK_DEPTH",
                model.SPAD_BANK_DEPTH,
                signal_int(dut.param_spad_bank_depth_o),
            ),
            ("ADDR_ALIGN", model.ADDR_ALIGN, signal_int(dut.param_addr_align_o)),
        ):
            assert expected == actual, (
                f"{name} is {actual}, the model thinks it is {expected}"
            )

        # The threads of a simd_data_t are packed, so the thread data has to
        # be as wide as the number of threads times the width of a thread.
        assert len(dut.op_mask.value) == model.N_THREADS, (
            f"the mask is {len(dut.op_mask.value)} bits wide, the model thinks "
            f"it is {model.N_THREADS}"
        )
        assert len(dut.op_rs1.value) == model.N_THREADS * model.RLEN, (
            f"the thread data is {len(dut.op_rs1.value)} bits wide, the model "
            f"thinks it is {model.N_THREADS * model.RLEN}"
        )

    # -------------------------------------------------------------------------
    # Setting the DUT up
    # -------------------------------------------------------------------------

    async def setup(self) -> None:
        """Reset the DUT and fill the scratchpad with the pattern.

        The scratchpad is filled through the init port of the harness, which
        is muxed in front of the LSU's own outputs, because cocotb cannot
        drive a wire that the RTL also drives.
        """
        dut = self.dut

        dut.rst_n.value = 0
        dut.in_valid_i.value = 0
        dut.out_ready_i.value = 1
        dut.init_mode.value = 0
        dut.init_addr.value = 0
        dut.init_wdata.value = 0
        dut.init_wen.value = 0

        # The model is a model of a particular design, so the parameters of
        # that design have to be the ones the model has. The harness gives
        # them, so that a change of one of them is caught here and not
        # somewhere in the middle of a test.
        self.check_model_fits()

        for _ in range(4):
            await FallingEdge(dut.clk)
        dut.rst_n.value = 1
        for _ in range(2):
            await FallingEdge(dut.clk)

        # Fill the scratchpad with the pattern, one offset per cycle.
        dut.init_mode.value = 1
        for offset in range(model.SPAD_BANK_DEPTH):
            addr = 0
            wdata = 0
            for bank in range(model.N_SPAD_BANKS):
                addr |= offset << (bank * (model.W_SPAD_BANK_ADDR - model.Z_ADDR))
                wdata |= model.spad_pattern(bank, offset) << (bank * model.RLEN)
                self.mem[bank][offset] = model.spad_pattern(bank, offset)
            dut.init_addr.value = addr
            dut.init_wdata.value = wdata
            dut.init_wen.value = (1 << (model.N_SPAD_BANKS * model.ADDR_ALIGN)) - 1
            # The write happens at the rising edge between the two falling
            # edges.
            await FallingEdge(dut.clk)
        dut.init_mode.value = 0
        await FallingEdge(dut.clk)

    # -------------------------------------------------------------------------
    # Driving one operation
    # -------------------------------------------------------------------------

    async def run_op(self, name: str) -> None:
        """Run one operation and compare the result against the model."""
        dut = self.dut
        op = self.op

        # What the model says the result is.
        model_cycles = model.arbitrate(op, self.mem)

        # Present the operation. The harness packs the fields into the
        # struct the LSU takes, so the testbench does not have to know where
        # they are.
        #
        # The sequence number wraps at the width of its type, which is what
        # the design does with it.
        dut.op_seq.value = self.seq & ((1 << len(dut.op_seq.value)) - 1)
        dut.op_mask.value = op.mask
        dut.op_rs1.value = model.pack_threads(op.rs1)
        dut.op_rs2.value = model.pack_threads(op.rs2)
        dut.op_imm.value = op.imm
        dut.op_mem_loadstore.value = op.loadstore
        dut.op_mem_opsize.value = op.opsize
        dut.op_mem_extendmode.value = op.extendmode
        self.seq += 1

        # It is accepted at the clock edge between the two falling edges.
        await FallingEdge(dut.clk)
        self.check(
            signal_int(dut.in_ready_o) == 1, f"{name}: the LSU was not ready"
        )
        dut.in_valid_i.value = 1
        await FallingEdge(dut.clk)
        dut.in_valid_i.value = 0

        # Wait for the result. The first falling edge above is the first
        # cycle after the operation was accepted.
        latency = 1
        while True:
            await with_timeout(FallingEdge(dut.clk), TIMEOUT_NS, "ns")
            latency += 1
            if signal_int(dut.out_valid_o):
                break

        self.check(
            latency == model_cycles + 2,
            f"{name}: latency {latency}, expected {model_cycles + 2}",
        )

        self.check(
            signal_int(dut.res_mask) == op.mask,
            f"{name}: result mask",
        )

        # The LSU must have latched the instruction of this operation. The
        # harness gives back the instruction it built and the one the LSU
        # latched, so they can be compared without knowing the layout.
        issued = signal_int(dut.op_instr)
        latched = signal_int(dut.res_instr)
        self.check(
            latched == issued,
            f"{name}: the latched instruction is not the one that was issued",
        )

        loaded = signal_int(dut.res_wb_result)

        # If the back-end is not ready, the result must be held.
        if self.stall_cycles > 0:
            dut.out_ready_i.value = 0
            held_mask = signal_int(dut.res_mask)
            held_instr = latched
            held_wb = loaded
            is_load = op.loadstore == model.MemLoadstore.LOAD
            for _ in range(self.stall_cycles):
                await FallingEdge(dut.clk)
                self.check(
                    signal_int(dut.out_valid_o) == 1,
                    f"{name}: out_valid dropped while stalled",
                )
                self.check(
                    signal_int(dut.res_mask) == held_mask
                    and signal_int(dut.res_instr) == held_instr
                    # A store has no write back data and the RTL drives it
                    # with 'x, so it is only checked for a load.
                    and (
                        not is_load
                        or signal_int(dut.res_wb_result) == held_wb
                    ),
                    f"{name}: the result changed while stalled",
                )
            dut.out_ready_i.value = 1

        # The value every thread loaded.
        if op.loadstore == model.MemLoadstore.LOAD:
            for index in range(model.N_THREADS):
                if not (op.mask >> index) & 1:
                    continue
                addr = (op.rs1[index] + op.imm) & 0xFFFFFFFF
                bank = model.spad_bank_of(addr)
                offset = model.spad_offset_of(addr)
                word = self.mem[bank][offset]
                expected = model.load_value(
                    word, addr & 3, self.op.opsize, self.op.extendmode
                )
                self.check(
                    model.thread(loaded, index) == expected,
                    f"{name}: thread {index} loaded "
                    f"{model.thread(loaded, index):08x}, expected {expected:08x} "
                    f"(addr {addr:08x} bank {bank} offset {offset} "
                    f"align {addr & 3} word {word:08x})",
                )

        # Take the result.
        await FallingEdge(dut.clk)
        dut.out_ready_i.value = 1
        await FallingEdge(dut.clk)

    async def check_word(self, bank: int, offset: int, name: str) -> None:
        """Read one word of the scratchpad back through the LSU.

        Used to find out which store went where.
        """
        saved = self.op

        self.op = model.Operation(
            mask=1,
            rs1=[model.addr_of(bank, offset)] + [0] * (model.N_THREADS - 1),
            opsize=model.MemOpsize.WORD,
            loadstore=model.MemLoadstore.LOAD,
            extendmode=model.MemExtendmode.SIGN,
        )

        await self.run_op(f"{name} readback bank {bank} offset {offset}")

        self.op = saved

    # -------------------------------------------------------------------------
    # Address generation
    # -------------------------------------------------------------------------

    def random_spad_addr(self) -> int:
        """A random address inside the scratchpad window.

        The address is a multiple of four; the alignment of the access is
        added to it by the caller.
        """
        return self.rng.randrange(0, 32768) * 4

    def random_align(self) -> int:
        """The alignment a random access of the current size uses."""
        if self.op.opsize == model.MemOpsize.BYTE:
            return self.rng.randrange(0, 4)
        if self.op.opsize == model.MemOpsize.HALF:
            return self.rng.randrange(0, 2) << 1
        return 0


async def start(dut, rng: random.Random, name: str) -> Lsu:
    """Start the clock, reset the DUT and fill the scratchpad."""
    # In cocotb 2.x the clock starts itself: start() schedules the driver
    # task and returns it, so it must not be handed to start_soon() as well.
    Clock(dut.clk, CLK_PERIOD_NS, unit="ns").start()
    lsu = Lsu(dut, rng, name)
    await lsu.setup()
    return lsu


def make_rng() -> random.Random:
    """The random generator of the randomised test.

    The seed is printed, so that a failure can be reproduced.
    """
    if SEED is not None:
        seed = int(SEED)
    else:
        seed = random.randrange(0, 1 << 32)
    cocotb.log.info("seed: %d", seed)
    return random.Random(seed)


# -----------------------------------------------------------------------------
# The test groups
# -----------------------------------------------------------------------------

@cocotb.test(timeout_time=1000, timeout_unit="us")
async def test_load_one_thread_per_bank(dut):
    """A load with no bank conflicts: one thread per bank."""
    lsu = await start(dut, random.Random(0), "test 1")

    lsu.op.loadstore = model.MemLoadstore.LOAD
    lsu.op.opsize = model.MemOpsize.WORD
    lsu.op.extendmode = model.MemExtendmode.SIGN
    lsu.op.imm = 0
    lsu.op.mask = (1 << model.N_THREADS) - 1
    for index in range(model.N_THREADS):
        # One word per bank: bank = A^B^L, so take the address from the
        # bank number directly.
        lsu.op.rs1[index] = (index << 12) & 0xFFFFFFFF
        lsu.op.rs2[index] = 0

    await lsu.run_op("test 1")

    lsu.finish()


@cocotb.test(timeout_time=1000, timeout_unit="us")
async def test_load_bytes_and_halves(dut):
    """The same load, but of a byte and of a half."""
    lsu = await start(dut, random.Random(0), "test 2")

    lsu.op.loadstore = model.MemLoadstore.LOAD
    lsu.op.mask = (1 << model.N_THREADS) - 1

    lsu.op.opsize = model.MemOpsize.BYTE
    lsu.op.extendmode = model.MemExtendmode.ZERO
    for index in range(model.N_THREADS):
        lsu.op.rs1[index] = ((index << 12) & 0xFFFFFFFF) | (index % 4)
    await lsu.run_op("test 2")

    lsu.op.opsize = model.MemOpsize.HALF
    lsu.op.extendmode = model.MemExtendmode.SIGN
    for index in range(model.N_THREADS):
        lsu.op.rs1[index] = ((index << 12) & 0xFFFFFFFF) | (2 * (index % 2))
    await lsu.run_op("test 2b")

    lsu.finish()


@cocotb.test(timeout_time=1000, timeout_unit="us")
async def test_all_threads_on_one_bank(dut):
    """All 32 threads on one bank: 32 arbitration cycles, the worst case."""
    lsu = await start(dut, random.Random(0), "test 3")

    lsu.op.loadstore = model.MemLoadstore.LOAD
    lsu.op.opsize = model.MemOpsize.WORD
    lsu.op.extendmode = model.MemExtendmode.SIGN
    lsu.op.imm = 0
    lsu.op.mask = (1 << model.N_THREADS) - 1
    for index in range(model.N_THREADS):
        # All threads read word 0 of bank 0.
        lsu.op.rs1[index] = 0
        lsu.op.rs2[index] = 0

    await lsu.run_op("test 3")

    lsu.finish()


@cocotb.test(timeout_time=1000, timeout_unit="us")
async def test_store_then_read_back(dut):
    """A store, then read it back."""
    lsu = await start(dut, random.Random(0), "test 4")

    lsu.op.mask = (1 << model.N_THREADS) - 1
    lsu.op.imm = 0

    lsu.op.loadstore = model.MemLoadstore.STORE
    lsu.op.opsize = model.MemOpsize.WORD
    lsu.op.extendmode = model.MemExtendmode.SIGN
    for index in range(model.N_THREADS):
        lsu.op.rs1[index] = (index << 12) & 0xFFFFFFFF
        lsu.op.rs2[index] = 0x10000000 + index
    await lsu.run_op("test 4a")

    lsu.op.loadstore = model.MemLoadstore.LOAD
    await lsu.run_op("test 4b")

    lsu.finish()


@cocotb.test(timeout_time=1000, timeout_unit="us")
async def test_byte_store(dut):
    """A byte store into the pattern."""
    lsu = await start(dut, random.Random(0), "test 5")

    lsu.op.mask = (1 << model.N_THREADS) - 1
    lsu.op.imm = 0

    lsu.op.loadstore = model.MemLoadstore.STORE
    lsu.op.opsize = model.MemOpsize.BYTE
    lsu.op.extendmode = model.MemExtendmode.SIGN
    for index in range(model.N_THREADS):
        lsu.op.rs1[index] = ((index << 12) & 0xFFFFFFFF) | (index % 4)
        lsu.op.rs2[index] = 0x000000A0 + index
    await lsu.run_op("test 5a")

    lsu.op.loadstore = model.MemLoadstore.LOAD
    await lsu.run_op("test 5b")

    lsu.finish()


@cocotb.test(timeout_time=100000, timeout_unit="us")
async def test_random_operations(dut):
    """2000 randomised operations.

    The mode selects which operations are generated, which is useful to tell
    a load problem from a store problem:

      mixed   loads and stores mixed (the default)
      loads   loads only
      stores  stores only
      single  single threaded
      word    word sized
    """
    lsu = await start(dut, make_rng(), "test 6")

    cocotb.log.info("randomised operations, mode %s", MODE)

    for iteration in range(2000):
        if MODE is Mode.LOADS:
            lsu.op.loadstore = model.MemLoadstore.LOAD
        elif MODE is Mode.STORES:
            lsu.op.loadstore = model.MemLoadstore.STORE
        else:
            lsu.op.loadstore = (
                model.MemLoadstore.LOAD
                if lsu.rng.randrange(0, 2) == 0
                else model.MemLoadstore.STORE
            )
        lsu.op.opsize = (
            model.MemOpsize.WORD
            if MODE is Mode.WORD
            else lsu.rng.choice(list(model.MemOpsize))
        )
        lsu.op.extendmode = lsu.rng.choice(list(model.MemExtendmode))
        lsu.op.imm = 0

        # A random mask.
        lsu.op.mask = 0
        for index in range(model.N_THREADS):
            if lsu.rng.randrange(0, 4) != 0:
                lsu.op.mask |= 1 << index
        if lsu.op.mask == 0:
            lsu.op.mask = 1
        if MODE is Mode.SINGLE:
            lsu.op.mask = 1 << lsu.rng.randrange(0, model.N_THREADS)

        # The addresses: sometimes spread out, sometimes on one bank.
        case = lsu.rng.randrange(0, 4)
        for index in range(model.N_THREADS):
            if case == 0:
                # One thread per bank.
                lsu.op.rs1[index] = (index << 12) & 0xFFFFFFFF
            elif case == 1:
                # All on one bank.
                lsu.op.rs1[index] = 0
            elif case == 2:
                # All on the same address.
                lsu.op.rs1[index] = 0
            else:
                # Spread out.
                lsu.op.rs1[index] = lsu.random_spad_addr()
            lsu.op.rs1[index] |= lsu.random_align()

        for index in range(model.N_THREADS):
            lsu.op.rs2[index] = lsu.rng.getrandbits(model.RLEN)

        await lsu.run_op(f"random {iteration}")

        # Read back the words the operation touched, so that a store that
        # went to the wrong place is caught right away.
        if READBACK:
            for index in range(model.N_THREADS):
                if (lsu.op.mask >> index) & 1:
                    addr = (lsu.op.rs1[index] + lsu.op.imm) & 0xFFFFFFFF
                    await lsu.check_word(
                        model.spad_bank_of(addr),
                        model.spad_offset_of(addr),
                        f"random {iteration}",
                    )

    lsu.finish()


@cocotb.test(timeout_time=10000, timeout_unit="us")
async def test_byte_and_half_stores(dut):
    """Byte and half stores across 8 offsets and all 4 alignments.

    Every word is read back, because this is where a store that went to the
    wrong place, or that wrote the wrong bytes, shows up.
    """
    lsu = await start(dut, random.Random(0), "test 7")

    lsu.op.loadstore = model.MemLoadstore.STORE
    lsu.op.extendmode = model.MemExtendmode.ZERO
    lsu.op.imm = 0
    lsu.op.mask = (1 << model.N_THREADS) - 1

    for offset in range(8):
        for align in range(4):
            # One thread per bank, each storing at the same offset but a
            # different alignment.
            for index in range(model.N_THREADS):
                lsu.op.rs1[index] = model.addr_of(index, offset) | align
                lsu.op.rs2[index] = 0xA0 + index
            # The size has to go with the alignment: a half may only be
            # stored at alignment 0 or 2 and a word only at alignment 0, and
            # anything else is 'x in the formatters. A byte may be stored at
            # any alignment, so it covers the two odd ones.
            lsu.op.opsize = (
                model.MemOpsize.HALF if align % 2 == 0 else model.MemOpsize.BYTE
            )
            await lsu.run_op(f"test 7 o{offset} a{align}")
            for index in range(model.N_THREADS):
                await lsu.check_word(
                    index, offset, f"test 7 o{offset} a{align}"
                )

    lsu.finish()


@cocotb.test(timeout_time=1000, timeout_unit="us")
async def test_back_pressure(dut):
    """The result is held stable while the back-end is not ready."""
    lsu = await start(dut, random.Random(0), "test 8")

    lsu.op.loadstore = model.MemLoadstore.LOAD
    lsu.op.opsize = model.MemOpsize.WORD
    lsu.op.extendmode = model.MemExtendmode.SIGN
    lsu.op.imm = 0
    lsu.op.mask = (1 << model.N_THREADS) - 1
    for index in range(model.N_THREADS):
        lsu.op.rs1[index] = (index << 12) & 0xFFFFFFFF
        lsu.op.rs2[index] = 0

    lsu.stall_cycles = 5
    await lsu.run_op("test 8")
    lsu.stall_cycles = 0

    lsu.finish()
