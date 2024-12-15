`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #10;
  end

  // Wire up the inputs and outputs:
  reg clk;`timescale 1ns / 1ps

module fir_core_core_fsm_tb;

  // Inputs
  reg clk;
  reg rst;
  reg Shift_Accum_Loop_C_0_tr0;
  reg [7:0] x_rsc_dat; // Assuming 8-bit data for simplicity
  reg [7:0] input_0, input_1, input_2, input_3, input_4;
  reg [2:0] sel; // Selector for the inputs

  // Outputs
  wire [7:0] fsm_output;
  wire [7:0] y_rsc_dat;
  wire y_triosy_lz, x_triosy_lz;

  // Instantiate the Unit Under Test (UUT)
  fir_core_core_fsm uut (
    .clk(clk),
    .rst(rst),
    .Shift_Accum_Loop_C_0_tr0(Shift_Accum_Loop_C_0_tr0),
    .x_rsc_dat(x_rsc_dat),
    .input_0(input_0),
    .input_1(input_1),
    .input_2(input_2),
    .input_3(input_3),
    .input_4(input_4),
    .sel(sel),
    .fsm_output(fsm_output),
    .y_rsc_dat(y_rsc_dat),
    .y_triosy_lz(y_triosy_lz),
    .x_triosy_lz(x_triosy_lz)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 ns clock period
  end

  // Test sequence
  initial begin
    // Initialize inputs
    rst = 1;
    Shift_Accum_Loop_C_0_tr0 = 0;
    x_rsc_dat = 0;
    input_0 = 8'h00;
    input_1 = 8'h01;
    input_2 = 8'h02;
    input_3 = 8'h03;
    input_4 = 8'h04;
    sel = 3'b000;

    // Reset sequence
    #10 rst = 0;

    // Apply test vectors
    #10 Shift_Accum_Loop_C_0_tr0 = 1;
        sel = 3'b001;
        x_rsc_dat = 8'hAA;
    #10 sel = 3'b010;
    #10 sel = 3'b011;
    #10 sel = 3'b100;
    #10 sel = 3'b101;

    // Wait and finish
    #100 $stop;
  end

endmodule

  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;


   supply1 VPWR;
   supply0 VGND;
   
  // Replace tt_um_example with your module name:
  tt_um_Richard28277 user_project (

      // Include power ports for the Gate Level test:
   `ifdef GL_TEST
     .VPWR(VPWR),
     .VGND(VGND),
   `endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

endmodule
