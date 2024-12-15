`timescale 1ns / 1ps

module fir_tb;

  // Inputs
  reg clk;
  reg rst;
  reg [31:0] x_rsc_dat;

  // Outputs
  wire [31:0] y_rsc_dat;
  wire y_triosy_lz;
  wire x_triosy_lz;

  // Instantiate the FIR module
  fir uut (
    .clk(clk),
    .rst(rst),
    .x_rsc_dat(x_rsc_dat),
    .x_triosy_lz(x_triosy_lz),
    .y_rsc_dat(y_rsc_dat),
    .y_triosy_lz(y_triosy_lz)
  );

  // Clock Generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz clock
  end

  // Reset Sequence
  initial begin
    rst = 1;
    #15 rst = 0;
  end

  // Input Stimulus
  initial begin
    x_rsc_dat = 0;

    // Wait for reset
    @(negedge rst);

    // Apply test data
    repeat (10) begin
      @(posedge clk);
      x_rsc_dat = $random; // Replace with known test vectors if needed
    end

    // End Simulation
    #100 $stop;
  end

  // Output Monitoring
  always @(posedge clk) begin
    $display("At time %0t: Input = %h, Output = %h", $time, x_rsc_dat, y_rsc_dat);
  end

endmodule
