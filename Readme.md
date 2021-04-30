# 32-point Fast Fourier Transform Processor #

This is the final Project of IC Design LAB, 2021 Spring.

## Introduction of FFT ###

Fast Fourier transform can be used to do the fourier transform of decimal signal in short time, which is one important part of digital signal processing. Relevant application includes Speech processing, video processing, Spectrum analying ...etc. However, it need a great amount of computation. So, we can use hardware to design the processor for FFT.

## 32-point DIF Radix-2 FFT ##

Radix-2 FFT is the algorithm that cut DFT into small computation units. (cut length N DFT into two length N/2 DFT). Using Radix-2 FFT with butterfly computation unit can improve the time complexity from O(N^2) to O(nlgn). There are two ways to do the cut: DIT(decimation in time) and DIF(decimation in frequency). We decided to use the latter. 

We can use shift registers to design single path delay, which make us be able to use adder more efficiently. In addition, The transmission of data is pipelined instead of transmitting in parallel, this way can reduce the area sharpely. In the end, One sorter is needed to organize the data after Fourier transform.

## Software TODO ##
1. Use python (floating point) to verify whether the alogrithm is right (use hardware-like computation)
2. change floating point in python to fixed-point gradually
3. Determine the accuracy in verilog and implement it (how many bits in fractional part ??)
4. Sorting may be wrong, check it!

## Hardware TODO ##
1. In transmitting data between stages, use more bits. However, round to less bit after final stage.
2. Sorting (bit-reversal) has to output real-part and imaginary part one by one (not together)
3. Twiddle factor may have more bit (ensure accuracy).
4. Sorting may be wrong, check it!
