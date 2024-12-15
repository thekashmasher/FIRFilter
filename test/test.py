import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_fir_fsm(dut):
    """
    Test FSM transitions for the FIR Filter core FSM.
    """

    # Start a clock with a 10 ns period (100 MHz)
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Apply reset
    dut.rst.value = 1
    dut.Shift_Accum_Loop_C_0_tr0.value = 0
    await Timer(20, units="ns")  # Wait 2 clock cycles
    dut.rst.value = 0  # Release reset

    # Log initial state
    cocotb.log.info(f"Initial FSM output: {dut.fsm_output.value}")

    # Test state transition
    cocotb.log.info("Testing state transitions...")
    dut.Shift_Accum_Loop_C_0_tr0.value = 1
    await RisingEdge(dut.clk)

    # Assert FSM transitioned correctly
    assert dut.fsm_output.value == 1, "FSM did not transition to expected state!"

    # Deactivate the trigger and check behavior
    dut.Shift_Accum_Loop_C_0_tr0.value = 0
    await RisingEdge(dut.clk)

    cocotb.log.info("FSM testing completed successfully.")
