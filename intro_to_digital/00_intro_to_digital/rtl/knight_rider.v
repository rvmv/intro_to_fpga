module knight_rider #(
  parameter WIDTH = 4
)(
    input wire CLOCK_50,
    output wire [9:0] LEDR,
    input  [9:0] SW
);
  
  wire slow_clock;

  logic [WIDTH-1:0] count;
  logic count_up;
  
  //replace with pll
  clock_divider #(.DIV_POW_FASTEST (10), .DIV_POW_SLOWEST (26)) 
  clk_divider (
    .fast_clock(CLOCK_50), 
    .sel_lo(SW[0]), 
    .sel_mid(SW[1]), 
    .slow_clock(slow_clock)
  );

  always_ff @ (posedge slow_clock)
    begin
      if (count_up)
        count <= count + 1'b1;
      else
        count <= count - 1'b1;
    end

  always_ff @ (posedge slow_clock)
    begin
      if (count == 4'd8)
        count_up <= 1'b0;
      else if (count == 4'd1)
        count_up <= 1'b1;
      else
        count_up <= count_up;
    end

assign LEDR[9:0] = (1'b1 << count);

endmodule
