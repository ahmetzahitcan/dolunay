"""cocotb testbench for the mock LSU (cocotb/rtl/mock_lsu.sv).

This is the smoke test for the cocotb flow. It exercises the things every
cocotb testbench in this project will need:

  * starting the clock and driving the reset,
  * the valid/ready handshake in both directions,
  * back-pressure: the result must be held stable while out_ready_i is low,
  * writing a word and reading it back.

The timing convention is the one the SystemVerilog testbenches in tb/ use:
the inputs are driven on the falling edge and the outputs are sampled on the
falling edge, so nothing races with the clock edge.
"""

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge, RisingEdge, with_timeout

CLK_PERIOD_NS = 10
MEM_BYTES = 16  # the mock's address space

# How long the testbench waits for the DUT before it gives up. A stuck DUT
# should fail the test, not hang the run.
TIMEOUT_NS = 1000


def sig(dut, name: str) -> int:
    """Read a signal as a plain integer."""
    return int(getattr(dut, name).value)


def start_clock(dut) -> Clock:
    """Start the clock.

    In cocotb 2.x the clock starts itself: start() schedules the driver task
    and returns it, so it must not be handed to start_soon() as well.
    """
    clock = Clock(dut.clk, CLK_PERIOD_NS, unit="ns")
    clock.start()
    return clock


async def reset_dut(dut) -> None:
    """Hold the DUT in reset for a few cycles, then release it."""
    dut.rst_n.value = 0
    dut.in_valid_i.value = 0
    dut.in_addr_i.value = 0
    dut.in_wdata_i.value = 0
    dut.in_we_i.value = 0
    dut.out_ready_i.value = 0

    await ClockCycles(dut.clk, 4)
    dut.rst_n.value = 1
    await FallingEdge(dut.clk)


async def request(dut, addr: int, wdata: int = 0, we: int = 0) -> int:
    """Send a request and return the data of the result it produces.

    The request is driven on a falling edge and released on the falling edge
    after the clock edge that accepted it, so it is presented for exactly one
    cycle and can never be accepted twice.
    """
    await FallingEdge(dut.clk)
    dut.in_addr_i.value = addr
    dut.in_wdata_i.value = wdata
    dut.in_we_i.value = we
    dut.in_valid_i.value = 1

    # in_ready_o only changes at a rising edge, so the value seen here is the
    # one the DUT will use at the next rising edge.
    while not sig(dut, "in_ready_o"):
        await with_timeout(FallingEdge(dut.clk), TIMEOUT_NS, "ns")

    await RisingEdge(dut.clk)  # the request is accepted at this edge
    await FallingEdge(dut.clk)  # the result is presented in this cycle
    dut.in_valid_i.value = 0  # the request was taken, release it

    while not sig(dut, "out_valid_o"):
        await with_timeout(FallingEdge(dut.clk), TIMEOUT_NS, "ns")
    return sig(dut, "out_rdata_o")


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_reset_state(dut):
    """After reset the mock is idle and ready for a request."""
    start_clock(dut)
    await reset_dut(dut)

    assert sig(dut, "out_valid_o") == 0, "no result may be pending after reset"
    assert sig(dut, "in_ready_o") == 1, "the mock must accept a request after reset"


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_store_then_load(dut):
    """A stored word reads back with the same value."""
    start_clock(dut)
    await reset_dut(dut)

    dut.out_ready_i.value = 1

    stored = await request(dut, addr=3, wdata=0xDEADBEEF, we=1)
    assert stored == 0xDEADBEEF, f"a store must echo its data, got {stored:#x}"

    loaded = await request(dut, addr=3, we=0)
    assert loaded == 0xDEADBEEF, f"the stored word must read back, got {loaded:#x}"


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_read_of_untouched_word(dut):
    """A word that was never written reads as zero."""
    start_clock(dut)
    await reset_dut(dut)

    dut.out_ready_i.value = 1

    loaded = await request(dut, addr=MEM_BYTES - 1, we=0)
    assert loaded == 0, f"an untouched word must read as zero, got {loaded:#x}"


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_back_to_back_transactions(dut):
    """A request may be issued in the cycle after the previous one is taken."""
    start_clock(dut)
    await reset_dut(dut)

    dut.out_ready_i.value = 1

    for i in range(4):
        addr = i % MEM_BYTES
        value = 0x1000 + i

        stored = await request(dut, addr=addr, wdata=value, we=1)
        assert stored == value, f"store {i}: got {stored:#x}, expected {value:#x}"

        loaded = await request(dut, addr=addr, we=0)
        assert loaded == value, f"load {i}: got {loaded:#x}, expected {value:#x}"


@cocotb.test(timeout_time=100, timeout_unit="us")
async def test_backpressure_holds_the_result(dut):
    """While out_ready_i is low the result is held, and no new request is taken."""
    start_clock(dut)
    await reset_dut(dut)

    # The consumer is not ready, so the mock must stall.
    dut.out_ready_i.value = 0

    held = await request(dut, addr=7, wdata=0x12345678, we=0)
    assert sig(dut, "out_valid_o") == 1, "the result must be presented"
    assert held == 0, f"an untouched word must read as zero, got {held:#x}"

    # The result must stay put, and the mock must not accept anything else.
    for _ in range(5):
        await FallingEdge(dut.clk)
        assert sig(dut, "out_valid_o") == 1, "the result must stay valid"
        assert sig(dut, "out_rdata_o") == held, "the result data must not change"
        assert sig(dut, "in_ready_o") == 0, "the mock must not accept a request"

    # Let the consumer take the result.
    dut.out_ready_i.value = 1
    await RisingEdge(dut.clk)
    await FallingEdge(dut.clk)
    assert sig(dut, "out_valid_o") == 0, "the result must be cleared once taken"
    assert sig(dut, "in_ready_o") == 1, "the mock must accept a request again"
