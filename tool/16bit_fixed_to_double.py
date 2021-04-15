from __future__ import division
import math
import sys

def double(x):
    i = 15
    exp = 0.5**6
    out = 0
    while(i>0):
        if(x[i]=='1'):
            out += exp
        exp = exp * 2
        i = i - 1
    if(x[0]=='1'):
        out -= 512
    return out

string_in = sys.argv[1]
f = open(string_in, "r")
points = f.read()
f.close()

points_list = points.split('\n')
points_list.pop(-1)

pt_real = []
pt_imag = []

for i in points_list:
    pt_real.append(double(i[:16]))
    pt_imag.append(double(i[17:]))

string_out = string_in[0:-4] + "_double" + string_in[-4:]
f = open(string_out, "w")
i = 0
while(i<len(pt_real)):
    f.write(str(pt_real[i]) + "+" + str(pt_imag[i]) + "i" + '\n')
    i += 1
f.close()
