import sys
from math import e
import math
import matplotlib.pyplot as plt

#------------------------------------------
round_choice = 1
#------------------------------------------
print("round_choice = %d, start simulation" %(round_choice))
string_in = sys.argv[1]
f = open(string_in, "r")
points = f.read()
f.close()
def quan(x, i):
    out = math.floor((x * 2 ** i ) + 0.5) / (2 ** i)
    return out

points_list = points.split('\n')
points_list.pop(-1)

pt_float = []

for i in points_list:
    pt_float.append(quan(float(i), 6))  # edit input fractional bit here(binary) 

#print(pt_float)

f = open("each_stage.txt", "w")
stage1_o = []

f.write("stage1_output:\n")
half = int(len(pt_float)/2)
for i in range(0, half*2):
    if(i < half):
        temp = pt_float[i] + pt_float[i+half]
    else:
        exp_real = (e**((-1)*complex(0,1)*2*math.pi*(i-16)/32)).real
        #print(exp_real)
        exp_imag = (e**((-1)*complex(0,1)*2*math.pi*(i-16)/32)).imag
        #print(exp_imag)
        #print(e**((-1)*complex(0,1)*2*math.pi*(i-16)/32))
        temp = (pt_float[i-half] - pt_float[i])*complex(quan(exp_real, 6), quan(exp_imag, 6)) # edit twiddle factor fractional bit here(binary)
        #temp = (pt_float[i-half] - pt_float[i])*e**((-1)*complex(0,1)*2*math.pi*(i-16)/32)
    
    # round 
    if(round_choice):
        #temp2 = complex(round(temp.real, 2), round(temp.imag, 2))
        temp2 = complex(quan(temp.real, 8), quan(temp.imag, 8))  # edit stage1~2 fractional bit here(binary)
        f.write(str(temp2)+"\n")
        stage1_o.append(temp2)
    else:
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
            exp_real = (e**((-1)*complex(0,1)*2*math.pi*(i-8)/16)).real
            exp_imag = (e**((-1)*complex(0,1)*2*math.pi*(i-8)/16)).imag
            #temp = (stage1_o[i-8+16*j] - stage1_o[i+16*j])*e**((-1)*complex(0,1)*2*math.pi*(i-8)/16)
            temp = (stage1_o[i-8+16*j] - stage1_o[i+16*j])*complex(quan(exp_real, 6), quan(exp_imag, 6)) # edit twiddle factor fractional bit here(binary)
        
        # round 
        if(round_choice):
            #temp2 = complex(round( temp.real , 2  ), round( temp.imag , 2  ))
            temp2 = complex(quan(temp.real, 8), quan(temp.imag, 8))  # edit stage2~3 fractional bit here(binary)
            f.write(str(temp2)+"\n")
            stage2_o.append(temp2)
        else:
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
            exp_real = (e**((-1)*complex(0,1)*2*math.pi*(i-4)/8)).real
            exp_imag = (e**((-1)*complex(0,1)*2*math.pi*(i-4)/8)).imag
            #temp = (stage2_o[i-4+8*j] - stage2_o[i+8*j])*e**((-1)*complex(0,1)*2*math.pi*(i-4)/8)
            temp = (stage2_o[i-4+8*j] - stage2_o[i+8*j])*complex(quan(exp_real, 6), quan(exp_imag, 6)) # edit twiddle factor fractional bit here(binary)
        # round 
        if(round_choice):
            #temp2 = complex(round( temp.real , 2  ), round( temp.imag , 2  ))
            temp2 = complex(quan(temp.real, 8), quan(temp.imag, 8))  # edit stage3~4 fractional bit here(binary)
            f.write(str(temp2)+"\n")
            stage3_o.append(temp2)
        else:
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
            exp_real = (e**((-1)*complex(0,1)*2*math.pi*(i-2)/4)).real
            exp_imag = (e**((-1)*complex(0,1)*2*math.pi*(i-2)/4)).imag
            #temp = (stage3_o[i-2+4*j] - stage3_o[i+4*j])*e**((-1)*complex(0,1)*2*math.pi*(i-2)/4)
            temp = (stage3_o[i-2+4*j] - stage3_o[i+4*j])*complex(quan(exp_real, 6), quan(exp_imag, 6)) # edit twiddle factor fractional bit here(binary)
        # round 
        if(round_choice):
            #temp2 = complex(round( temp.real , 2  ), round( temp.imag , 2  ))
            temp2 = complex(quan(temp.real, 8), quan(temp.imag, 8))  # edit stage4~5 fractional bit here(binary)
            f.write(str(temp2)+"\n")
            stage4_o.append(temp2)
        else:
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
            exp_real = (e**((-1)*complex(0,1)*2*math.pi*(i-1)/2)).real
            exp_imag = (e**((-1)*complex(0,1)*2*math.pi*(i-1)/2)).imag
            #temp = (stage4_o[i-1+2*j] - stage4_o[i+2*j])*e**((-1)*complex(0,1)*2*math.pi*(i-1)/2)
            temp = (stage4_o[i-1+2*j] - stage4_o[i+2*j])*complex(quan(exp_real, 6), quan(exp_imag, 6)) # edit twiddle factor fractional bit here(binary)
        
        # round 
        if(round_choice):
            #temp2 = complex(round( temp.real , 2  ), round( temp.imag , 2  ))
            temp2 = complex(quan(temp.real, 7), quan(temp.imag, 7)) # edit final fractional bit here(binary)
            f.write(str(temp2)+"\n")
            stage5_o.append(temp2)
        else:
            f.write(str(temp)+"\n")
            stage5_o.append(temp)
f.write("\n")

sort_real = [0.0]*32
sort_imag = [0.0]*32

sort_real[0] = stage5_o[0].real
sort_real[16] = stage5_o[1].real
sort_real[8] = stage5_o[2].real
sort_real[24] = stage5_o[3].real
sort_real[4] = stage5_o[4].real
sort_real[20] = stage5_o[5].real
sort_real[12] = stage5_o[6].real
sort_real[28] = stage5_o[7].real
sort_real[2] = stage5_o[8].real
sort_real[18] = stage5_o[9].real
sort_real[10] = stage5_o[10].real
sort_real[26] = stage5_o[11].real
sort_real[6] = stage5_o[12].real
sort_real[22] = stage5_o[13].real
sort_real[14] = stage5_o[14].real
sort_real[30] = stage5_o[15].real
sort_real[1] = stage5_o[16].real
sort_real[17] = stage5_o[17].real
sort_real[9] = stage5_o[18].real
sort_real[25] = stage5_o[19].real
sort_real[5] = stage5_o[20].real
sort_real[21] = stage5_o[21].real
sort_real[13] = stage5_o[22].real
sort_real[29] = stage5_o[23].real
sort_real[3] = stage5_o[24].real
sort_real[19] = stage5_o[25].real
sort_real[11] = stage5_o[26].real
sort_real[27] = stage5_o[27].real
sort_real[7] = stage5_o[28].real
sort_real[23] = stage5_o[29].real
sort_real[15] = stage5_o[30].real
sort_real[31] = stage5_o[31].real

sort_imag[0] = stage5_o[0].imag
sort_imag[16] = stage5_o[1].imag
sort_imag[8] = stage5_o[2].imag
sort_imag[24] = stage5_o[3].imag
sort_imag[4] = stage5_o[4].imag
sort_imag[20] = stage5_o[5].imag
sort_imag[12] = stage5_o[6].imag
sort_imag[28] = stage5_o[7].imag
sort_imag[2] = stage5_o[8].imag
sort_imag[18] = stage5_o[9].imag
sort_imag[10] = stage5_o[10].imag
sort_imag[26] = stage5_o[11].imag
sort_imag[6] = stage5_o[12].imag
sort_imag[22] = stage5_o[13].imag
sort_imag[14] = stage5_o[14].imag
sort_imag[30] = stage5_o[15].imag
sort_imag[1] = stage5_o[16].imag
sort_imag[17] = stage5_o[17].imag
sort_imag[9] = stage5_o[18].imag
sort_imag[25] = stage5_o[19].imag
sort_imag[5] = stage5_o[20].imag
sort_imag[21] = stage5_o[21].imag
sort_imag[13] = stage5_o[22].imag
sort_imag[29] = stage5_o[23].imag
sort_imag[3] = stage5_o[24].imag
sort_imag[19] = stage5_o[25].imag
sort_imag[11] = stage5_o[26].imag
sort_imag[27] = stage5_o[27].imag
sort_imag[7] = stage5_o[28].imag
sort_imag[23] = stage5_o[29].imag
sort_imag[15] = stage5_o[30].imag
sort_imag[31] = stage5_o[31].imag

f.write("after sorting"+"\n")

for i in range(0,32):
    if (sort_imag[i] < 0):
        f.write(str(sort_real[i])+str(sort_imag[i])+"j\n")
    else:
        f.write(str(sort_real[i])+"+"+str(sort_imag[i])+"j\n")



t = range(32)
plt.plot(t,sort_real) 
plt.show() 

plt.plot(t,sort_imag) 
plt.show()

f.close()

