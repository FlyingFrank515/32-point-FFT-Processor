// ===================================================================
// Module: FFT (top)

// This is the 32-point FFT circuits
// This module uses signed fixed point representation
// input: 14-bit(integer part: 6-bit/ fractional part: 8-bit) 
// output: 19-bit(integer part: 11-bit/ fractional part: 8-bit)  

// pipelined design: all inputs and outputs are tramsmitted one by one
// ===================================================================

module FFT(
    input                   clk,
    input                   rst,
    input                   valid_i,
    input signed [13:0]     x_r,
    
    output                  finish,
    output                  busy,
    output signed [18:0]    X_r,
    output signed [18:0]    X_i
);
endmodule