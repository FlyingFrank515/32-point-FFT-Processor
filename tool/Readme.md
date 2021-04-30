# Tool Usage #

## matlab code ##

   input: 32-point signal x in line-5, which is based on t from 0 to 31

   output: 32-point fft result of x

   After running this matlab code, we obtain two txt file: 

   (1) input_k.txt (2) output_k.txt

   (k is to be altered in .m code)

   In these two files, the data are stored as doubles.

## python code ##

### floating point to 8bit input ###

   command: python floating_to_8bit.py  [input_file_name]

​	input: txt files from matlab containing doubles

   output: txt files containing 8 bit fixed-point data

​	ex: python floating_to_8bit input_1.txt

​	The program will read data from "input_1.txt" and output data to a file name "input**_8bit**_1.txt" 

### 16bit fixed point to complex ###

command: python 16bit_fixed_to_double.py  [input_file_name]

​	input: txt files from testbench containing 16bit fixed point data (real/imag part)

   output: txt files containing complex data

​	ex: python 16bit_fixed_to_double.py ../stage1_o.txt

​	The program will read data from "../stage1_o.txt" and output data to a file name "../stage1_o**_double**.txt" 

### each_stage.py ###

command: python each_stage.py [input_file_name]

input: txt file of input pattern(floating point)

output: txt files containing serial out of each stage