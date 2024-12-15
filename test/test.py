import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_fir_core_core_fsm(dut):
    """ Test the FIR core FSM functionality """

    # Generate clock
    clock = Clock(dut.clk, 10, units="ns")  # 10ns period
    cocotb.start_soon(clock.start())

    # Initialize inputs
    dut.rst.value = 1
    dut.Shift_Accum_Loop_C_0_tr0.value = 0
    dut.x_rsc_dat.value = 0
    dut.input_0.value = 0
    dut.input_1.value = 1
    dut.input_2.value = 2
    dut.input_3.value = 3
    dut.input_4.value = 4
    dut.sel.value = 0

    # Apply reset
    await Timer(20, units="ns")  # Wait 20ns
    dut.rst.value = 0

    # Apply test vectors
    await Timer(10, units="ns")
    dut.Shift_Accum_Loop_C_0_tr0.value = 1
    dut.sel.value = 1
    dut.x_rsc_dat.value = 0xAA

    await Timer(10, units="ns")
    dut.sel.value = 2

    await Timer(10, units="ns")
    dut.sel.value = 3

    await Timer(10, units="ns")
    dut.sel.value = 4

    await Timer(10, units="ns")
    dut.sel.value = 5

    # Wait and observe
    await Timer(100, units="ns")
