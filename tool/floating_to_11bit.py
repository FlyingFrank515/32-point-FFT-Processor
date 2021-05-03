from __future__ import division
import math
import sys

def twos_comp(x):
    output = ''
    i = 10
    # 6 bit in front, 5 bit behind
    front = 6
    exp = 2**(front-2)
    if x >= 0:
        output = output + '0'
    else:
        output = output + '1'
        x = x + 2*exp

    while(i > 0):
        if(i == 5):
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

string_in = sys.argv[1]
f = open(string_in, "r")
points = f.read()
f.close()

# for i in points
points_list = points.split('\n')
points_list.pop(-1)


pt_float = []

for i in points_list:
    pt_float.append(float(i))

pt_final = []

string_out = string_in[0:-6] + "_11bit" + string_in[-6:]
f = open(string_out, 'w')
for i in pt_float:
    pt_final.append(twos_comp(i))
    f.write(pt_final[-1])

f.close()


