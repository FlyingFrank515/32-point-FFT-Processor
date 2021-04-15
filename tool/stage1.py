import sys
from math import e
import math

string_in = sys.argv[1]
f = open(string_in, "r")
points = f.read()
f.close()

points_list = points.split('\n')
points_list.pop(-1)

pt_float = []

for i in points_list:
    pt_float.append(float(i))

# print(pt_float)

f = open("answer.txt", "w")

half = int(len(pt_float)/2)
for i in range(0, half*2):
    print(i)
    if(i < half):
        temp = pt_float[i] + pt_float[i+half]
    else:
        temp = (pt_float[i-half] - pt_float[i])*e**((-1)*complex(0,1)*2*math.pi*(i-half)/half)
    f.write(str(temp)+"\n")
f.close()
