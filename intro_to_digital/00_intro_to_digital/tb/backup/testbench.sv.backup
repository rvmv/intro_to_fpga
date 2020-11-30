`timescale 1 ns / 100 ps

module testbench;
 // input and output test signals
    reg        [2:0] a;
    reg        [2:0] b;
    reg        sel;
    wire [2:0] y;

     // creating the instance of the module we want to test
    b3_mux_2_1_case dut
    (
        .d0  ( a       ),
        .d1  ( b       ),
        .sel ( sel     ),
        .M   ( y       ) 
    );

    initial
        begin
            a = 1'b0;
            b = 1'b1;
            #5;
            sel = 1'b0;     // sel change to 0; a -> y
            #10;
            sel = 1'b1;     // sel change to 1; b -> y
            #10
            b = 1'b0;		// b change; y changes too. sel == 1'b1
            #5
            b = 1'b1;
            #5;            // pause
            $finish();
        end
    // do at the beginning of the simulation
    // print signal values on every change
    initial 
        $monitor("a=%b b=%b sel=%b y=%b", a,   b,   sel,   y,   );
    // do at the beginning of the simulation
    initial 
        $dumpvars;  //iverilog dump init


endmodule
