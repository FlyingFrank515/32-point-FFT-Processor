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

f = open("each_stage.txt", "w")
stage1_o = []

f.write("stage1_output:\n")
half = int(len(pt_float)/2)
for i in range(0, half*2):
    print(i)
    if(i < half):
        temp = pt_float[i] + pt_float[i+half]
    else:
        temp = (pt_float[i-half] - pt_float[i])*e**((-1)*complex(0,1)*2*math.pi*(i-16)/32)
    print(temp)
    f.write(str(temp)+"\n")
    stage1_o.append(temp)
f.write("\n")

stage2_o = []
f.write("stage2_output:\n")
for j in range(0, 2):
    for i in range(0, 16):
        if(i < 8): 
            temp = stage1_o[i+16*j] + stage1_o[i+8+16*j]
        else:
            temp = (stage1_o[i-8+16*j] - stage1_o[i+16*j])*e**((-1)*complex(0,1)*2*math.pi*(i-8)/16)
        f.write(str(temp)+"\n")
        stage2_o.append(temp)
f.write("\n")

stage3_o = []
f.write("stage3_output:\n")
for j in range(0, 4):
    for i in range(0, 8):
        if(i < 4): 
            temp = stage2_o[i+8*j] + stage2_o[i+4+8*j]
        else:
            temp = (stage2_o[i-4+8*j] - stage2_o[i+8*j])*e**((-1)*complex(0,1)*2*math.pi*(i-4)/8)
        f.write(str(temp)+"\n")
        stage3_o.append(temp)
f.write("\n")

stage4_o = []
f.write("stage4_output:\n")
for j in range(0, 8):
    for i in range(0, 4):
        if(i < 2): 
            temp = stage3_o[i+4*j] + stage3_o[i+2+4*j]
        else:
            temp = (stage3_o[i-2+4*j] - stage3_o[i+4*j])*e**((-1)*complex(0,1)*2*math.pi*(i-2)/4)
        f.write(str(temp)+"\n")
        stage4_o.append(temp)
f.write("\n")

stage5_o = []
f.write("stage5_output:\n")
for j in range(0, 16):
    for i in range(0, 2):
        if(i < 1): 
            temp = stage4_o[i+2*j] + stage4_o[i+1+2*j]
        else:
            temp = (stage4_o[i-1+2*j] - stage4_o[i+2*j])*e**((-1)*complex(0,1)*2*math.pi*(i-1)/2)
        f.write(str(temp)+"\n")
        stage5_o.append(temp)
f.write("\n")

f.close()

