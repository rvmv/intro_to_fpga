# intro_to_fpga
Intro to intel fpga and intel Quartus prime software

# Software Prerequisites
1. Install Quartus Lite and make utility
2. For fix issues Unable to read device chain - JTAG chain broken under Ubuntu 20.04.1 LTS
 - install lib
```
sudo apt-get install libudev-dev
```
Execute
```
killall jtagd
jtagd --user-start

jtagconfig

1) USB-Blaster [3-4]
  031050DD   10M50DA(.|ES)/10M50DC
```
# Description
For get all possible comand execute make inside 00_intro_to_digital

 - make help         - show this message
 - make clean        - delete synth and simulation folders
 - make sim          - the same as sim_gui
 - make icarus       - the same as icarus_cmd
 - make synth        - clean, create the board project and run the synthesis (for default board)
 - make open         - the same as synth_gui
 - make load         - the same as synth_load
 - make sim_cmd      - run simulation in Modelsim (console mode)
 - make sim_gui      - run simulation in Modelsim (gui mode)
 - make icarus_cmd   - run simulation in Icarus Verilog (console mode)
 - make icarus_gui   - run simulation in Icarus Verilog (gui mode)
 - make synth_create - create the board project
 - make synth_build  - build the board project
 - make synth_gui    - open the board project
 - make synth_load   - program the default FPGA board
 - make board_all    - run synthesis for all the supported boards


# demo

https://youtu.be/ZetxJ7oy0NQ

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/ZetxJ7oy0NQ/0.jpg)](https://youtu.be/ZetxJ7oy0NQ)
