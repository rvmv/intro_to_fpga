set_global_assignment -name NUM_PARALLEL_PROCESSORS ALL
set_global_assignment -name TOP_LEVEL_ENTITY board_terasic

set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/board_terasic.sv
set_global_assignment -name VERILOG_FILE       ../rtl/switch_to_led.v
set_global_assignment -name VERILOG_FILE       ../rtl/mux_2_to_1.v

set_global_assignment -name SYSTEMVERILOG_FILE       ../rtl/clock_divider.sv
set_global_assignment -name SYSTEMVERILOG_FILE       ../rtl/knight_rider.sv
set_global_assignment -name SYSTEMVERILOG_FILE       ../rtl/summator.sv

#set_global_assignment -name VERILOG_FILE       ../rtl/seven_seg_digit.v
#set_global_assignment -name VERILOG_FILE       ../rtl/seven_seg_6.v
#set_global_assignment -name VERILOG_FILE       ../rtl/counter.v
