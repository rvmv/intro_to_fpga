module clock_divider
#(
  parameter DIV_POW_FASTEST = 1,
  parameter DIV_POW_SLOWEST = 26
)(
  input        fast_clock,
  input        sel_lo,
  input        sel_mid,
  output logic slow_clock
);

// 50 MHz / 2 ** 26 = 0.75 Hz
// 50 MHz / 2 ** 22 = 11 Hz
// 50 MHz / 2 ** 21 = 25 Hz

logic [DIV_POW_SLOWEST - 1: 0] counter;

always_ff @(posedge fast_clock)
  counter <= counter + 1'b1;


always_ff @(posedge fast_clock)
  slow_clock <= sel_lo  ? counter [DIV_POW_SLOWEST - 1] : 
                sel_mid ? counter [DIV_POW_SLOWEST - 5] :
                          counter [DIV_POW_FASTEST - 1] ;


endmodule