from __future__ import division
import math
import sys

def double(x):
    # total i+1 bit, behind . :j, front of . : i+1-j
    i = 16
    j = 7
    k = i - j
    exp = 0.5**j
    out = 0
    while(i>0):
        if(x[i]=='1'):
            out += exp
        exp = exp * 2
        i = i - 1
    if(x[0]=='1'):
        out -= 2**k
    return out

string_in = sys.argv[1]
f = open(string_in, "r")
points = f.read()
f.close()

points_list = points.split('\n')
points_list.pop(-1)

pt_real = []
pt_imag = []

for i in range(len(points_list)):
    if i<32:
        pt_real.append(double(points_list[i]))
    else:
        pt_imag.append(double(points_list[i]))

string_out = string_in[0:-4] + "_double" + string_in[-4:]
f = open(string_out, "w")
i = 0
while(i<len(pt_real)):
    if(pt_imag[i]<0):
        f.write(str(pt_real[i]) + str(pt_imag[i]) + "i" + '\n')
    else:
        f.write(str(pt_real[i]) + "+" + str(pt_imag[i]) + "i" + '\n')
    i += 1
f.close()
