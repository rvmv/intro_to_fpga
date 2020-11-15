module clock_divider
#(
  parameter COUNTER_SIZE = 5,
  parameter COUNTER_MAX_COUNT = (2 ** COUNTER_SIZE) - 1
)(
  input fast_clock,
  output slow_clock
);

reg [COUNTER_SIZE - 1:0] count;

always @(posedge fast_clock)
  begin
    if (count == COUNTER_MAX_COUNT)
      count <= 0;
    else
      count <= count + 1'b1;
  end

assign slow_clock = count[COUNTER_SIZE-1];

endmodule
