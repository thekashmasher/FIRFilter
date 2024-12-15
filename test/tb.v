`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Dump signals to VCD file
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Declare inputs and outputs
  reg clk;
  reg rst;
  reg Shift_Accum_Loop_C_0_tr0;
  wire [2:0] fsm_output;

  // Instantiate the FSM module
  fir_core_core_fsm dut (
    .clk(clk),
    .rst(rst),
    .fsm_output(fsm_output),
    .Shift_Accum_Loop_C_0_tr0(Shift_Accum_Loop_C_0_tr0)
  );

  // Clock generation
  always #5 clk = ~clk; // 10 ns clock period (100 MHz)

  // Test sequence
  initial begin
    // Initialize signals
    clk = 0;
    rst = 1;
    Shift_Accum_Loop_C_0_tr0 = 0;

    // Apply reset
    #10 rst = 0;

    // Test state transitions
    #20 Shift_Accum_Loop_C_0_tr0 = 1;  // Trigger state transition
    #10 Shift_Accum_Loop_C_0_tr0 = 0;  // Release trigger
    #20 Shift_Accum_Loop_C_0_tr0 = 1;  // Another state transition test
    #30 $finish;
  end

endmodule
