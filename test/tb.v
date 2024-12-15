`timescale 1ns / 1ps

module tb_fir;
  reg clk;
  reg rst;
  reg [31:0] x_in;
  wire [31:0] y_out;

  // DUT Instance
  fir uut (
    .clk(clk),
    .rst(rst),
    .x_rsc_dat(x_in),
    .y_rsc_dat(y_out)
  );

  // Clock Generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 ns clock period
  end

  // Stimulus
  initial begin
    rst = 1; 
    x_in = 0;
    #20; 
    rst = 0; 
    #10;
    x_in = 32'h00000001; #10;
    x_in = 32'h00000002; #10;
    x_in = 32'h00000003; #10;
    x_in = 32'h00000004; #10;
    x_in = 32'h00000005; #10;

    #50;
    $finish;
  end

  // Dump Waveform
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb_fir);
  end
endmodule
