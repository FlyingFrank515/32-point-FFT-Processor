from __future__ import division
import math

def twos_comp(x):
    output = ''
    i = 13
    exp = 16
    if x >= 0:
        output = output + '0'
    else:
        output = output + '1'
        x = x + 32

    while(i > 0):
        if(i == 8):
            output = output + '_'
        if(x >= exp):
            x = x - exp
            output = output + '1'
        else:
            output = output + '0'
        exp = exp / 2
        i = i - 1
    output = output + '\n'
    return output

f = open("input_1.txt", "r")
points = f.read()

# for i in points
points_list = points.split('\n')
points_list.pop(-1)

pt_int = []

for i in points_list:
    pt_int.append(float(i))

pt_final = []

f = open('input_14bit_1', 'w')
for i in pt_int:
    pt_final.append(twos_comp(i))
    f.write(pt_final[-1])

f.close()


