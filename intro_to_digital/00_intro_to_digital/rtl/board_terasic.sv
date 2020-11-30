
module board_terasic
(
    input         CLK,
    input  [ 9:0] SW,
    input  [ 1:0] KEY,
    output [ 9:0] LED,
    output [ 7:0] HEX0,
    output [ 7:0] HEX1,
    output [ 7:0] HEX2,
    output [ 7:0] HEX3,
    output [ 7:0] HEX4,
    output [ 7:0] HEX5 
);

wire [5:0][7:0] seg;
//wire [23:0] data = { 14'b0, SW };


always_comb 
    { HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 } = seg;


//assign { HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 } = seg;

//switch_to_led sw_to_led (.SW(SW), .LEDR(LED));

//mux_2_to_1_simple mux (.SW(SW), .LEDR(LED));

//mux_2_to_1_procedural mux_procedural (.SW(SW), .LEDR(LED));

//knight_rider kr (.CLOCK_50(CLK), .LEDR(LED), .SW(SW));

  localparam WIDTH   = 64;
  localparam LSB_NUM = 22;

  wire [WIDTH-1:0] cntr;
  wire [WIDTH-1:0] cntr_down;

  clock_divider #(.DIV_POW_FASTEST (10), .DIV_POW_SLOWEST (26)) 
  
  clk_divider (
    .fast_clock( CLOCK_50  ), 
    .sel_lo(     SW[1]     ), 
    .sel_mid(    SW[2]     ), 
    .slow_clock( slow_clock)
  );
  
    counter
    #(
        .WIDTH ( WIDTH  )
    )
    counter
    (
        .clk   ( CLK    ),
        .rst_n ( KEY[0] ),
        .cntr_up  ( cntr   )
    );

    counter_down
    #(
        .WIDTH ( WIDTH  )
    )
    counter_down
    (
        .clk   ( CLK    ),
        .rst_n ( KEY[1] ),
        .cntr_down  ( cntr_down   )
    );

wire up_down_switch = SW[3];
/**
* [LSB_NUM +: 24] => [22 +: 24] => increment from start bit is 22, width = 24 so cntr_down[22,23,24,25...46] is 24 bits ?
**/
wire [23:0] data = up_down_switch ? cntr_down [LSB_NUM +: 24] : cntr [LSB_NUM +: 24];
wire [9:0] bcd;

bin2bcd #(9) bin2bcd_inst (SW, bcd);

  seven_seg_N #(6) hex 
    (
        .data   ( bcd[3:0]),
        .seg    ( seg  )
    );
	 
//summator sm (.CLOCK_50(CLK), .data(data), .seg(seg), .KEY(KEY));

endmodule

/**
 * 2^7 = 128
**/
module counter
#(
    parameter WIDTH = 32
)(
    input                    clk,
    input                    rst_n,
    output logic [WIDTH-1:0] cntr_up
);
    logic [WIDTH-1:0] cntr;
    always_ff @(posedge clk)
      if (!rst_n) cntr <= 0;
      else cntr <= cntr + 1;

    assign cntr_up = cntr;
	 
endmodule


module counter_down
#(
    parameter WIDTH = 32
)(
    input                    clk,
    input                    rst_n,
    output logic [WIDTH-1:0] cntr_down
);
    logic [WIDTH-1:0] cntr;
    always_ff @(posedge clk or negedge rst_n)
      if (!rst_n) cntr <= WIDTH-1'hf;
      else cntr <= cntr - 1;

    assign cntr_down = cntr;
	 
endmodule



module up_down_counter
#(
    parameter WIDTH = 32
)(
    input clk, 
    input reset,
    input up_down, 
    output[WIDTH-1 :0] counter
);

logic [WIDTH-1:0] counter_up_down;

always_ff @(posedge clk or posedge reset)
  begin
    if(reset)
      counter_up_down <= 4'h0;
    else if(~up_down)
      counter_up_down <= counter_up_down + 4'd1;
    else
      counter_up_down <= counter_up_down - 4'd1;
  end 

assign counter = counter_up_down;

endmodule

// parametric Verilog implementation of the double dabble binary to BCD converter
// for the complete project, see
// https://github.com/AmeerAbdelhadi/Binary-to-BCD-Converter

module bin2bcd
 #( parameter                W = 18)  // input width
  ( input      [W-1      :0] bin   ,  // binary
    output reg [W+(W-4)/3:0] bcd   ); // bcd {...,thousands,hundreds,tens,ones}

  integer i,j;

  always @(bin) begin
    for(i = 0; i <= W+(W-4)/3; i = i+1) bcd[i] = 0;     // initialize with zeros
    bcd[W-1:0] = bin;                                   // initialize with input vector
    for(i = 0; i <= W-4; i = i+1)                       // iterate on structure depth
      for(j = 0; j <= i/3; j = j+1)                     // iterate on structure width
        if (bcd[W-i+4*j -: 4] > 4)                      // if > 4
          bcd[W-i+4*j -: 4] = bcd[W-i+4*j -: 4] + 4'd3; // add 3
  end

endmodule


