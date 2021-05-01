from __future__ import division
import math
import sys
import matplotlib.pyplot as plt

def double(x):
    # total i+1 bit, behind . :j, front of . : i+1-j
    i = 17
    j = 8
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

for i in points_list:
    pt_real.append(double(i[:18]))
    pt_imag.append(double(i[19:]))

string_out = string_in[0:-4] + "_double" + string_in[-4:]
f = open(string_out, "w")
i = 0
while(i<len(pt_real)):
    if(pt_imag[i]<0):
        f.write(str(pt_real[i]) + str(pt_imag[i]) + "i" + '\n')
    else:
        f.write(str(pt_real[i]) + "+" + str(pt_imag[i]) + "i" + '\n')
    i += 1

sort_real = [0.0]*32
sort_imag = [0.0]*32

sort_real[31] = pt_real[0]
sort_real[15] = pt_real[1]
sort_real[7] = pt_real[2]
sort_real[23] = pt_real[3]
sort_real[3] = pt_real[4]
sort_real[19] = pt_real[5]
sort_real[11] = pt_real[6]
sort_real[27] = pt_real[7]
sort_real[1] = pt_real[8]
sort_real[17] = pt_real[9]
sort_real[9] = pt_real[10]
sort_real[25] = pt_real[11]
sort_real[5] = pt_real[12]
sort_real[21] = pt_real[13]
sort_real[13] = pt_real[14]
sort_real[29] = pt_real[15]
sort_real[0] = pt_real[16]
sort_real[16] = pt_real[17]
sort_real[8] = pt_real[18]
sort_real[24] = pt_real[19]
sort_real[4] = pt_real[20]
sort_real[20] = pt_real[21]
sort_real[12] = pt_real[22]
sort_real[28] = pt_real[23]
sort_real[2] = pt_real[24]
sort_real[18] = pt_real[25]
sort_real[10] = pt_real[26]
sort_real[26] = pt_real[27]
sort_real[6] = pt_real[28]
sort_real[22] = pt_real[29]
sort_real[14] = pt_real[30]
sort_real[30] = pt_real[31]

sort_imag[31] = pt_imag[0]
sort_imag[15] = pt_imag[1]
sort_imag[7] = pt_imag[2]
sort_imag[23] = pt_imag[3]
sort_imag[3] = pt_imag[4]
sort_imag[19] = pt_imag[5]
sort_imag[11] = pt_imag[6]
sort_imag[27] = pt_imag[7]
sort_imag[1] = pt_imag[8]
sort_imag[17] = pt_imag[9]
sort_imag[9] = pt_imag[10]
sort_imag[25] = pt_imag[11]
sort_imag[5] = pt_imag[12]
sort_imag[21] = pt_imag[13]
sort_imag[13] = pt_imag[14]
sort_imag[29] = pt_imag[15]
sort_imag[0] = pt_imag[16]
sort_imag[16] = pt_imag[17]
sort_imag[8] = pt_imag[18]
sort_imag[24] = pt_imag[19]
sort_imag[4] = pt_imag[20]
sort_imag[20] = pt_imag[21]
sort_imag[12] = pt_imag[22]
sort_imag[28] = pt_imag[23]
sort_imag[2] = pt_imag[24]
sort_imag[18] = pt_imag[25]
sort_imag[10] = pt_imag[26]
sort_imag[26] = pt_imag[27]
sort_imag[6] = pt_imag[28]
sort_imag[22] = pt_imag[29]
sort_imag[14] = pt_imag[30]
sort_imag[30] = pt_imag[31]

t = range(32)
plt.plot(t,sort_real) 
plt.show() 

plt.plot(t,sort_imag) 
plt.show() 

f.close()
