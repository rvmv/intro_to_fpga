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
# demo

https://youtu.be/ZetxJ7oy0NQ

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/ZetxJ7oy0NQ/0.jpg)](https://youtu.be/ZetxJ7oy0NQ)
