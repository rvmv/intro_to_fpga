module knight_rider (
    input wire CLOCK_50,
    output wire [9:0] LEDR
);
  
  wire slow_clock;

  reg [3:0] count;
  reg count_up;
  
  clock_divider #(22) u0 (
    .fast_clock(CLOCK_50),
	  .slow_clock(slow_clock)
  );

  always @ (posedge slow_clock)
    begin
      if (count_up)
        count <= count + 1'b1;
      else
        count <= count - 1'b1;
    end

  always @ (posedge slow_clock)
    begin
      if (count == 9)
        count_up <= 1'b0;
      else if (count == 0)
        count_up <= 1'b1;
      else
        count_up <= count_up;
    end

assign LEDR[9:0] = (1'b1 << count);

endmodule
