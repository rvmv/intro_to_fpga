
# create modelsim working library
vlib work

# compile all the Verilog sources
vlog     ../rtl/*.v
vlog -sv ../rtl/*.sv 
vlog -sv ../tb/testbench.sv 

# open the testbench module for simulation
vsim testbench

# add all testbench signals to time diagram
# add wave sim:/testbench/*
add wave -r *

# run the simulation
run -all

# expand the signals time diagram
wave zoom full
