# Tool Usage #

## matlab code ##

   input: 32-point signal x in line-5, which is based on t from 0 to 31

   output: 32-point fft result of x

   After running this matlab code, we obtain two txt file: 

   (1) input_k.txt (2) output_k.txt

   (k is to be altered in .m code)

   In these two files, the data are stored as doubles.

## python code ##

   command: python floating_to_14bit.py  [input_file_name]
   /python floating_to_19bit.py  [input_file_name]

​	input: txt files from matlab containing doubles

   output: txt files containing 14/19 bit fixed-point data

​	ex: python floating_to_14bit input_1.txt

​	The program will read data from "input_1.txt" and output data to a file name "input**_14bit**_1.txt" 