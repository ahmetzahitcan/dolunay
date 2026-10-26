"""cocotb testbench for the example DUT (pytb/demo/demo.sv).

This is the smallest testbench that shows how a testbench of this project is
written: the clock and the reset, the valid/ready handshake in both
directions, and the back-pressure on the response.

The timing convention is the one the SystemVerilog testbenches in tb/ use:
the inputs are driven on the falling edge and the outputs are sampled on the
falling edge, so nothing races with the clock edge.
"""

from __future__ import annotations

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge

CLK_PERIOD_NS = 10


async def setup(dut) -> None:
    """Start the clock and reset the DUT."""
    # In cocotb 2.x the clock starts itself: start() schedules the driver
    # task and returns it, so it must not be handed to start_soon() as well.
    Clock(dut.clk, CLK_PERIOD_NS, unit="ns").start()

    dut.rst_n.value = 0
    dut.in_valid_i.value = 0
    dut.in_data_i.value = 0
    dut.out_ready_i.value = 1
    for _ in range(2):
        await FallingEdge(dut.clk)
    dut.rst_n.value = 1
    await FallingEdge(dut.clk)


async def request(dut, data: int) -> int:
    """Send a request and return the data of the answer.

    The request is driven on a falling edge and released on the falling edge
    after the clock edge that accepted it, so it is presented for exactly one
    cycle and can never be accepted twice.
    """
    await FallingEdge(dut.clk)
    dut.in_data_i.value = data
    dut.in_valid_i.value = 1

    # in_ready_o only changes at a rising edge, so the value seen here is the
    # one the DUT will use at the next rising edge.
    while not int(dut.in_ready_o.value):
        await FallingEdge(dut.clk)

    await RisingEdge(dut.clk)  # the request is accepted at this edge
    await FallingEdge(dut.clk)  # the answer is presented in this cycle
    dut.in_valid_i.value = 0  # the request was taken, release it

    while not int(dut.out_valid_o.value):
        await FallingEdge(dut.clk)
    return int(dut.out_data_o.value)


@cocotb.test(timeout_time=10, timeout_unit="us")
async def test_after_the_reset(dut):
    """After the reset the DUT is idle and ready for a request."""
    await setup(dut)

    assert int(dut.out_valid_o.value) == 0, "no answer may be pending"
    assert int(dut.in_ready_o.value) == 1, "the DUT must accept a request"


@cocotb.test(timeout_time=10, timeout_unit="us")
async def test_a_request_is_answered(dut):
    """A request is answered with the data of the request."""
    await setup(dut)

    assert await request(dut, 0x5A) == 0x5A, "the answer must echo the request"

    # The answer is taken at the next rising edge, and only then is the DUT
    # ready for the next request.
    await RisingEdge(dut.clk)
    await FallingEdge(dut.clk)
    assert int(dut.in_ready_o.value) == 1, "the DUT must accept a request"


@cocotb.test(timeout_time=10, timeout_unit="us")
async def test_the_answer_is_held(dut):
    """The answer is held while the back-end is not ready."""
    await setup(dut)

    # The back-end is not ready, so the DUT must not take a new request and
    # must hold the answer it has.
    dut.out_ready_i.value = 0

    await FallingEdge(dut.clk)
    dut.in_data_i.value = 0xA5
    dut.in_valid_i.value = 1
    await RisingEdge(dut.clk)  # the request is accepted at this edge
    await FallingEdge(dut.clk)  # the answer is presented in this cycle
    dut.in_valid_i.value = 0

    for _ in range(3):
        assert int(dut.out_valid_o.value) == 1, "the answer must stay valid"
        assert int(dut.out_data_o.value) == 0xA5, "the answer must not change"
        assert int(dut.in_ready_o.value) == 0, "the DUT must not accept a request"
        await FallingEdge(dut.clk)

    # The back-end takes the answer, and the DUT is ready again.
    dut.out_ready_i.value = 1
    await RisingEdge(dut.clk)
    await FallingEdge(dut.clk)
    assert int(dut.out_valid_o.value) == 0, "the answer must be cleared once taken"
    assert int(dut.in_ready_o.value) == 1, "the DUT must accept a request"
