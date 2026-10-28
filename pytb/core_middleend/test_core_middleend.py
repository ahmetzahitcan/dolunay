"""cocotb testbench for the middle end.

This is the cocotb version of tb/tb_core_middleend.sv, which is still there
and still works. The five test groups of the SystemVerilog testbench are the
five tests here.

The middle end reads its operands from the two register-file ports, dispatches
the operations to the function unit the instruction selects, and streams the
results back out. The testbench has a model of the register file, so that the
routing of an operand is observable, and it watches what the middle end
dispatches and collects.

The timing convention is the one the SystemVerilog testbenches in tb/ use:
the inputs are driven on the falling edge and the outputs are sampled on the
falling edge, so nothing races with the clock edge.
"""

from __future__ import annotations

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge

CLK_PERIOD_NS = 10

# The parameters of the design, which the model has to have. The widths of
# the signals say what the design uses, and the tests check them.
N_THREADS = 32
RLEN = 32
N_WARPS = 8
W_WARPS = 3
N_FUNCTION_UNITS = 5
W_FUNCTION_UNITS = 3
W_ROB_ADDR = 3
W_REGISTERS = 5

# The function units, in the order of function_unit_e.
FU_BJU = 0
FU_CSRR = 1
FU_ALU = 2
FU_FPU = 3
FU_LSU = 4

# The register files.
REGFILE_INT = 0
REGFILE_FLOAT = 1

# The bits of the readiness of the function units, for the override.
READY_BJU = 1 << FU_BJU
READY_CSRR = 1 << FU_CSRR
READY_ALU = 1 << FU_ALU
READY_FPU = 1 << FU_FPU

# How long to wait for the middle end to do something, in clock cycles.
TIMEOUT = 1000


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


# -----------------------------------------------------------------------------
# The model of the register file
# -----------------------------------------------------------------------------


def phys_reg_id(warp: int, regfile: int, index: int) -> int:
    """The physical register index of a register, as the design builds it."""
    return (warp << (W_REGISTERS + 1)) | (regfile << W_REGISTERS) | index


def rf_payload(index: int) -> int:
    """The data the register file gives for a physical register.

    It depends on the register, so that a mistake in the routing of an
    operand shows up.
    """
    return pack_threads(
        [(index * N_THREADS + thread) & 0xFFFFFFFF for thread in range(N_THREADS)]
    )


def expected_operand(used: bool, warp: int, regfile: int, index: int) -> int:
    """The data an operand should have.

    An operand that is not used, and x0 of the integer register file, are
    zero and are never fetched.
    """
    if not used or (index == 0 and regfile == REGFILE_INT):
        return 0
    return rf_payload(phys_reg_id(warp, regfile, index))


# -----------------------------------------------------------------------------
# An operation
# -----------------------------------------------------------------------------


class Operation:
    """One operation, as the middle end is given it."""

    def __init__(
        self,
        seq: int,
        fu_sel: int,
        rs1: tuple[bool, int, int],
        rs2: tuple[bool, int, int],
        rs3: tuple[bool, int, int],
        warp: int = 0,
        mask: int = (1 << N_THREADS) - 1,
    ) -> None:
        self.seq = seq
        self.fu_sel = fu_sel
        self.rs1 = rs1
        self.rs2 = rs2
        self.rs3 = rs3
        self.warp = warp
        self.mask = mask

    def expected(self) -> tuple[int, int, int, int]:
        """The function unit and the three operands it should get."""
        return (
            self.fu_sel,
            expected_operand(self.rs1[0], self.warp, self.rs1[1], self.rs1[2]),
            expected_operand(self.rs2[0], self.warp, self.rs2[1], self.rs2[2]),
            expected_operand(self.rs3[0], self.warp, self.rs3[1], self.rs3[2]),
        )


# -----------------------------------------------------------------------------
# The middle end
# -----------------------------------------------------------------------------


class MiddleEnd:
    """The middle end, and the bookkeeping of what it dispatched."""

    def __init__(self, dut, name: str) -> None:
        self.dut = dut
        self.name = name
        self.expected: dict[tuple[int, int], Operation] = {}
        self.dispatched: set[tuple[int, int]] = set()
        self.collected: set[tuple[int, int]] = set()
        self.last_seq: dict[int, int] = {}
        self.dispatches = 0
        self.collects = 0
        self.checks = 0
        self.errors = 0
        # The addresses the write-back unit owns, for the register file model.
        self.wb_addr_a = 0
        self.wb_addr_b = 0

    # -- bookkeeping ---------------------------------------------------------

    def check(self, ok: bool, what: str) -> bool:
        """Count a check, and report it if it failed."""
        self.checks += 1
        if not ok:
            self.errors += 1
            cocotb.log.error("  FAIL: %s", what)
        return ok

    def expect(self, operation: Operation) -> None:
        """Say that an operation is expected to be dispatched."""
        self.expected[(operation.warp, operation.seq)] = operation
        self.checks += 1

    def finish(self) -> None:
        """Report the checks the test made, and fail if one of them failed."""
        cocotb.log.info(
            "%s: %d checks, %d failures, %d dispatched, %d collected",
            self.name,
            self.checks,
            self.errors,
            self.dispatches,
            self.collects,
        )
        assert self.errors == 0, (
            f"{self.name}: {self.errors} of {self.checks} checks failed"
        )

    # -- the DUT -------------------------------------------------------------

    def check_shape(self) -> None:
        """The signals have to be as wide as the model thinks they are."""
        dut = self.dut
        for what, signal, expected in (
            ("the mask", dut.me_mask, N_THREADS),
            ("the sequence number", dut.me_seq, W_ROB_ADDR),
            ("the function unit", dut.me_fu_sel, W_FUNCTION_UNITS),
            ("the register index", dut.me_rs1_idx, W_REGISTERS),
            ("the warp", dut.of_warp_id, W_WARPS),
        ):
            assert len(signal.value) == expected, (
                f"{what} is {len(signal.value)} bits wide, the model thinks it "
                f"is {expected}"
            )
        assert len(dut.rfa_data.value) == N_THREADS * RLEN, (
            f"the thread data is {len(dut.rfa_data.value)} bits wide, the "
            f"model thinks it is {N_THREADS * RLEN}"
        )

    async def reset(self) -> None:
        """Reset the middle end and the register file model."""
        dut = self.dut
        dut.me_valid.value = 0
        dut.me_seq.value = 0
        dut.me_mask.value = 0
        dut.me_pc.value = 0
        dut.me_fu_sel.value = 0
        for source in ("rs1", "rs2", "rs3"):
            getattr(dut, f"me_{source}_used").value = 0
            getattr(dut, f"me_{source}_regfile").value = 0
            getattr(dut, f"me_{source}_idx").value = 0
        dut.rfa_write_en.value = 0
        dut.rfb_write_en.value = 0
        dut.rfa_data.value = 0
        dut.rfb_data.value = 0
        dut.fu_ready_override_en.value = 0
        dut.fu_ready_override.value = 0
        dut.rst_n.value = 0
        # Every synchronous register has to see a clock edge with the reset
        # asserted, to reach a defined idle state. Sixteen cycles is what
        # the SystemVerilog testbench used (its tb_config_pkg::RST_CYCLES).
        for _ in range(16):
            await FallingEdge(dut.clk)
        dut.rst_n.value = 1
        for _ in range(2):
            await FallingEdge(dut.clk)
        self.expected.clear()
        self.dispatched.clear()
        self.collected.clear()
        self.last_seq.clear()
        self.dispatches = 0
        self.collects = 0

    # -- the model of the register file ---------------------------------------

    async def register_file(self) -> None:
        """The model of the register file.

        The data of a register depends on its address, so that a mistake in
        the routing of an operand shows up. A port that the write-back unit
        owns reads the write-back address instead.

        The data is registered, so it is one cycle behind the address: the
        address is read in the middle of a cycle, and the data is given at
        the end of it. The address is read in the middle because that is
        when it is settled — at the clock edge itself the middle end has
        already moved on to the next one.
        """
        dut = self.dut
        while True:
            await FallingEdge(dut.clk)
            index_a = (
                self.wb_addr_a
                if int(dut.rfa_write_en.value)
                else int(dut.rfa_idx.value)
            )
            index_b = (
                self.wb_addr_b
                if int(dut.rfb_write_en.value)
                else int(dut.rfb_idx.value)
            )
            await RisingEdge(dut.clk)
            if int(dut.rst_n.value):
                dut.rfa_data.value = rf_payload(index_a)
                dut.rfb_data.value = rf_payload(index_b)
            else:
                dut.rfa_data.value = 0
                dut.rfb_data.value = 0

    # -- driving -------------------------------------------------------------

    async def push(self, operation: Operation) -> None:
        """Push one operation into a warp's queue.

        The queue can be full, so the push waits for room.
        """
        dut = self.dut
        await self.tick()
        while not int(dut.me_ready.value) & (1 << operation.warp):
            await self.tick()
        dut.me_valid.value = 1 << operation.warp
        dut.me_seq.value = operation.seq
        dut.me_mask.value = operation.mask
        dut.me_pc.value = 0
        dut.me_fu_sel.value = operation.fu_sel
        for source, (used, regfile, index) in (
            ("rs1", operation.rs1),
            ("rs2", operation.rs2),
            ("rs3", operation.rs3),
        ):
            getattr(dut, f"me_{source}_used").value = used
            getattr(dut, f"me_{source}_regfile").value = regfile
            getattr(dut, f"me_{source}_idx").value = index
        await RisingEdge(dut.clk)
        dut.me_valid.value = 0

    # -- watching ------------------------------------------------------------

    def sample(self) -> None:
        """Look at what the middle end dispatched and collected this cycle.

        It is called at every falling edge, so that nothing is missed.
        """
        dut = self.dut
        if int(dut.of_dispatch.value):
            warp = int(dut.of_warp_id.value)
            seq = int(dut.of_seq.value)
            self.dispatches += 1
            self.checks += 1
            operation = self.expected.get((warp, seq))
            if operation is None:
                self.check(False, f"unexpected dispatch w={warp} seq={seq}")
                return
            if (warp, seq) in self.dispatched:
                self.check(False, f"duplicate dispatch w={warp} seq={seq}")
            fu_sel, rs1, rs2, rs3 = operation.expected()
            if int(dut.of_fu_sel.value) != fu_sel:
                self.check(
                    False,
                    f"w={warp} s={seq} wrong FU got={int(dut.of_fu_sel.value)} "
                    f"exp={fu_sel}",
                )
            if int(dut.of_rs1_data.value) != rs1:
                self.check(False, f"w={warp} s={seq} wrong rs1 data")
            if int(dut.of_rs2_data.value) != rs2:
                self.check(False, f"w={warp} s={seq} wrong rs2 data")
            if int(dut.of_rs3_data.value) != rs3:
                self.check(False, f"w={warp} s={seq} wrong rs3 data")
            if int(dut.of_mask.value) != operation.mask:
                self.check(
                    False,
                    f"w={warp} s={seq} wrong mask got={int(dut.of_mask.value):08x} "
                    f"exp={operation.mask:08x}",
                )
            last = self.last_seq.get(warp)
            if last is not None and seq <= last:
                self.check(
                    False, f"w={warp} per-warp order violated (s={seq} after {last})"
                )
            self.last_seq[warp] = seq
            self.dispatched.add((warp, seq))

        if int(dut.result_valid.value):
            warp = int(dut.result_warp_id.value)
            seq = int(dut.result_seq.value)
            self.collects += 1
            self.checks += 1
            operation = self.expected.get((warp, seq))
            if operation is None:
                self.check(False, f"unexpected collect w={warp} seq={seq}")
                return
            if (warp, seq) in self.collected:
                self.check(False, f"duplicate collect w={warp} seq={seq}")
            if int(dut.result_fu_sel.value) != operation.fu_sel:
                self.check(False, f"collect w={warp} s={seq} wrong FU")
            self.collected.add((warp, seq))

    async def tick(self) -> None:
        """Wait for the next falling edge and look at what happened.

        Every wait goes through here, so that every falling edge is looked
        at exactly once and nothing is missed or counted twice.
        """
        await FallingEdge(self.dut.clk)
        self.sample()

    async def wait_for(self, done) -> bool:
        """Wait until `done` holds, watching the middle end meanwhile.

        Returns whether it held before the timeout.
        """
        for _ in range(TIMEOUT):
            await self.tick()
            if done():
                return True
        return False

    async def wait_all_dispatched(self) -> bool:
        """Wait until every expected operation has been dispatched."""
        return await self.wait_for(lambda: set(self.expected) <= self.dispatched)

    async def wait_all_collected(self) -> bool:
        """Wait until every expected operation has been collected."""
        return await self.wait_for(lambda: set(self.expected) <= self.collected)

    async def wait_seen(self, warp: int, seq: int) -> bool:
        """Wait until a particular operation has been dispatched."""
        return await self.wait_for(lambda: (warp, seq) in self.dispatched)

    async def wait_cycles(self, cycles: int) -> None:
        """Wait for a number of cycles, watching the middle end meanwhile."""
        for _ in range(cycles):
            await self.tick()

    # -- holding the function units busy -------------------------------------

    def hold_fu_busy(self, ready: int) -> None:
        """Make the function units look busy, except for the ones in `ready`."""
        self.dut.fu_ready_override_en.value = 1
        self.dut.fu_ready_override.value = ready

    def release_fu(self) -> None:
        """Let the function units be as ready as they are."""
        self.dut.fu_ready_override_en.value = 0

    # -- the latency of the operand fetch ------------------------------------

    async def measure_latency(self, operation: Operation) -> int:
        """How many cycles an operation spends in the operand-fetch stage.

        The queueing delay is excluded, so this isolates the benefit of
        folding the shared sources.
        """
        dut = self.dut
        # Wait for the stage to go idle.
        while int(dut.of_valid.value):
            await self.tick()
        await self.tick()
        while not int(dut.me_ready.value) & (1 << operation.warp):
            await self.tick()
        await self.push(operation)
        # Wait for it to enter the stage, and for it to be dispatched. The
        # dispatch is in the same cycle as the stage becoming valid, or in a
        # later one.
        latency = 0
        entered = False
        while True:
            await self.tick()
            if entered:
                latency += 1
            if int(dut.of_dispatch.value):
                break
            if not entered and int(dut.of_valid.value):
                entered = True
        return latency


async def start(dut, name: str) -> MiddleEnd:
    """Start the clock, reset the middle end and model the register file."""
    # In cocotb 2.x the clock starts itself: start() schedules the driver
    # task and returns it, so it must not be handed to start_soon() as well.
    Clock(dut.clk, CLK_PERIOD_NS, unit="ns").start()
    middle_end = MiddleEnd(dut, name)
    middle_end.check_shape()
    await middle_end.reset()
    # The model of the register file runs for as long as the test does: the
    # task is cancelled with the test.
    cocotb.start_soon(middle_end.register_file())
    return middle_end


# -----------------------------------------------------------------------------
# The test groups
# -----------------------------------------------------------------------------


@cocotb.test(timeout_time=1000, timeout_unit="us")
async def test_operand_fetch_and_dispatch(dut):
    """1. The operand fetch and the dispatch datapath.

    Every operation is dispatched to the function unit its instruction
    selects, with the right operands and the right warp id, and it comes back
    out of the result stream exactly once.
    """
    middle_end = await start(dut, "test 1")

    # w0: rs1, rs2 (I) -> ALU
    operation = Operation(
        0, FU_ALU, (True, REGFILE_INT, 5), (True, REGFILE_INT, 7),
        (False, REGFILE_INT, 0), warp=0,
    )
    middle_end.expect(operation)
    await middle_end.push(operation)

    # w0: rs1(F), rs2=x0, rs3(F) -> ALU
    operation = Operation(
        1, FU_ALU, (True, REGFILE_FLOAT, 2), (True, REGFILE_INT, 0),
        (True, REGFILE_FLOAT, 3), warp=0,
    )
    middle_end.expect(operation)
    await middle_end.push(operation)

    # w1: rs1, rs2 (I) -> BJU
    operation = Operation(
        0, FU_BJU, (True, REGFILE_INT, 1), (True, REGFILE_INT, 2),
        (False, REGFILE_INT, 0), warp=1,
    )
    middle_end.expect(operation)
    await middle_end.push(operation)

    # w1: rs1 only -> CSRR
    operation = Operation(
        1, FU_CSRR, (True, REGFILE_INT, 9), (False, REGFILE_INT, 0),
        (False, REGFILE_INT, 0), warp=1,
    )
    middle_end.expect(operation)
    await middle_end.push(operation)

    # w2: rs1, rs2, rs3 (F) -> FPU
    operation = Operation(
        0, FU_FPU, (True, REGFILE_FLOAT, 1), (True, REGFILE_FLOAT, 2),
        (True, REGFILE_FLOAT, 3), warp=2,
    )
    middle_end.expect(operation)
    await middle_end.push(operation)

    # w3: no operands -> ALU
    operation = Operation(
        0, FU_ALU, (False, REGFILE_INT, 0), (False, REGFILE_INT, 0),
        (False, REGFILE_INT, 0), warp=3,
    )
    middle_end.expect(operation)
    await middle_end.push(operation)

    assert await middle_end.wait_all_dispatched(), "not all the ops were dispatched"
    assert await middle_end.wait_all_collected(), "not all the ops were collected"

    middle_end.finish()


@cocotb.test(timeout_time=1000, timeout_unit="us")
async def test_operand_fetch_queue_back_pressure(dut):
    """2. The operand-fetch queue applies back-pressure.

    With the function units held busy, the queue fills up and the middle end
    stops accepting operations, and it drains once the units are free again.
    """
    middle_end = await start(dut, "test 2")

    middle_end.hold_fu_busy(0)

    for seq in range(3):
        operation = Operation(
            seq,
            FU_ALU,
            (True, REGFILE_INT, 3 + 2 * seq),
            (True, REGFILE_INT, 4 + 2 * seq),
            (False, REGFILE_INT, 0),
            warp=0,
        )
        middle_end.expect(operation)
        await middle_end.push(operation)

    # The queue is full now, so the middle end is not ready for more.
    await middle_end.wait_cycles(1)
    middle_end.check(
        not int(dut.me_ready.value) & 1,
        "the middle end should not be ready when the queue is full",
    )

    middle_end.release_fu()
    assert await middle_end.wait_all_dispatched(), "the ops did not drain"
    assert await middle_end.wait_all_collected(), "the ops did not collect"

    middle_end.finish()


@cocotb.test(timeout_time=1000, timeout_unit="us")
async def test_port_a_write_gating(dut):
    """3. A register-file port that the write-back unit owns defers the read.

    The operation must not be dispatched while port A is busy, and it is
    dispatched once port A is free.
    """
    middle_end = await start(dut, "test 3")

    # The write-back unit owns port A.
    dut.rfa_write_en.value = 1
    middle_end.wb_addr_a = phys_reg_id(6, REGFILE_INT, 30)

    operation = Operation(
        0, FU_ALU, (True, REGFILE_INT, 5), (True, REGFILE_INT, 7),
        (False, REGFILE_INT, 0), warp=0,
    )
    middle_end.expect(operation)
    await middle_end.push(operation)

    # Hold port A busy for a while: the operation must not be dispatched.
    middle_end.check(
        (0, 0) not in middle_end.dispatched,
        "the op was dispatched while the rs2 read was blocked",
    )

    # Free port A.
    dut.rfa_write_en.value = 0
    assert await middle_end.wait_all_dispatched(), "the op did not dispatch"
    assert await middle_end.wait_all_collected(), "the op did not collect"

    middle_end.finish()


@cocotb.test(timeout_time=1000, timeout_unit="us")
async def test_warp_selector_priority(dut):
    """4. The warp selector prefers a warp whose function unit is ready.

    With the branch unit and the ALU ready and the CSR unit not, the branch
    warp and the ALU warp go and the CSR warp waits.
    """
    middle_end = await start(dut, "test 4")

    # Hold everything, so that the warps pile up in their queues.
    middle_end.hold_fu_busy(0)

    # w1 BJU, w2 ALU, w3 CSRR.
    for warp, fu_sel, first in ((1, FU_BJU, 1), (2, FU_ALU, 3), (3, FU_CSRR, 5)):
        operation = Operation(
            0,
            fu_sel,
            (True, REGFILE_INT, first),
            (True, REGFILE_INT, first + 1),
            (False, REGFILE_INT, 0),
            warp=warp,
        )
        middle_end.expect(operation)
        await middle_end.push(operation)

    # The branch unit and the ALU are ready, the CSR unit is not.
    middle_end.hold_fu_busy(READY_BJU | READY_ALU)
    assert await middle_end.wait_seen(2, 0), "the ALU warp did not dispatch"
    middle_end.check(
        (1, 0) in middle_end.dispatched, "the branch warp did not dispatch first"
    )
    middle_end.check(
        (3, 0) not in middle_end.dispatched,
        "the CSR warp dispatched although its function unit was busy",
    )

    # Now let the CSR unit be ready too.
    middle_end.hold_fu_busy(READY_BJU | READY_ALU | READY_CSRR)
    assert await middle_end.wait_all_dispatched(), "the ops did not drain"
    assert await middle_end.wait_all_collected(), "the ops did not collect"

    middle_end.release_fu()

    middle_end.finish()


@cocotb.test(timeout_time=1000, timeout_unit="us")
async def test_shared_source_alias_folding(dut):
    """5. The operand fetch folds the sources that are the same register.

    Two operations that read the same register twice are fetched in fewer
    cycles than one that reads three different ones.
    """
    middle_end = await start(dut, "test 5")

    float = REGFILE_FLOAT

    async def latency_of(seq, rs1, rs2, rs3) -> int:
        operation = Operation(seq, FU_ALU, rs1, rs2, rs3, warp=0)
        middle_end.expect(operation)
        return await middle_end.measure_latency(operation)

    # Three distinct sources: the baseline.
    distinct = await latency_of(
        0, (True, float, 1), (True, float, 2), (True, float, 3)
    )
    # rs1 == rs2.
    rs1_rs2 = await latency_of(
        1, (True, float, 4), (True, float, 4), (True, float, 6)
    )
    # rs1 == rs3.
    rs1_rs3 = await latency_of(
        2, (True, float, 7), (True, float, 8), (True, float, 7)
    )
    # rs2 == rs3.
    rs2_rs3 = await latency_of(
        3, (True, float, 9), (True, float, 10), (True, float, 10)
    )
    # All three the same.
    all_same = await latency_of(
        4, (True, float, 11), (True, float, 11), (True, float, 11)
    )
    # One source and two distinct ones: they have the same latency.
    one = await latency_of(
        5, (True, float, 12), (False, REGFILE_INT, 0), (False, REGFILE_INT, 0)
    )
    two = await latency_of(
        6, (True, float, 13), (True, float, 14), (False, REGFILE_INT, 0)
    )

    cocotb.log.info(
        "  OF latency (cycles): 1src=%d 2src=%d 3distinct=%d rs1=rs2:%d "
        "rs1=rs3:%d rs2=rs3:%d all:%d",
        one, two, distinct, rs1_rs2, rs1_rs3, rs2_rs3, all_same,
    )

    middle_end.check(one == two, "1-source and 2-source should have the same latency")
    middle_end.check(rs1_rs2 < distinct, "rs1==rs2 did not shorten the operand fetch")
    middle_end.check(rs1_rs3 < distinct, "rs1==rs3 did not shorten the operand fetch")
    middle_end.check(rs2_rs3 < distinct, "rs2==rs3 did not shorten the operand fetch")
    middle_end.check(all_same < distinct, "all-same did not shorten the operand fetch")

    assert await middle_end.wait_all_collected(), "the ops did not collect"

    middle_end.finish()
