`timescale 1 ns / 100 ps

module top_tb;

// input and output test signals
bit clk, reset;

localparam t    = 20;
localparam Tmax = 300;
localparam WIDTH = 8;

initial begin
  clk <= 0;
  forever 
    #(t/2) clk <= ~clk;
end

initial begin
  reset <= 'b0;
  repeat(3) @(posedge clk);
  reset <= 'b1;
end

logic [31:0] cnt_from_dut;

counter DUT (
    .clk      ( clk          ),
    .rst_n    ( reset        ),
    .cntr_up  ( cnt_from_dut )
);

// test duration
initial begin
  repeat(Tmax) @(posedge clk);
  $finish;
end

  initial $monitor ("%5t value=%3d %8b", $time, cnt_from_dut, cnt_from_dut);
  initial $dumpvars;
endmodule 
