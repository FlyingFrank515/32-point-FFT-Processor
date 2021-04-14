// ====================================================================
// Module: BUTTERFLY_R2                                                 
// 
// This is Butterfly-unit for doing radix2-FFT. where B is connected
// to the output of the shift-register (single path delay) and that A 
// is connected to the data input. 
// 
// Note: Only contain the combinational part, so the next stage should
// add the flipflop to its input to ensure the existence of full 
// access time
//
// ===================================================================
module BUTTERFLY_R2(
    input [1:0]                 state,
    input signed [18:0]         A_r,
    input signed [18:0]         A_i,
    input signed [18:0]         B_r,
    input signed [18:0]         B_i,
    input signed [9:0]          WN_r,
    input signed [9:0]          WN_i,
    
    output reg signed [18:0]    out_r,
    output reg signed [18:0]    out_i,
    output reg signed [18:0]    SR_r,
    output reg signed [18:0]    SR_i
);
    // state parameter
    parameter IDLE      = 2'b00;
    parameter FIRST     = 2'b01;
    parameter SECOND    = 2'b10;
    parameter WAITING   = 2'b11;
    
    // Wire-Reg declaration
    wire signed [29:0] mul13, mul24, mul14, mul23;
    wire signed [30:0] tempA, tempB;

    // Combinational part
    assign mul13 = B_r * WN_r;
    assign mul24 = B_i * WN_i;
    assign mul14 = B_r * WN_i;
    assign mul23 = B_i * WN_r;
    
    assign tempA = mul13 - mul24;
    assign tempB = mul14 + mul23;
    
    always@(*) begin
        case(state)          
            IDLE: begin
                out_r = 0;
                out_i = 0;
                SR_r = 0;
                SR_i = 0;
            end

            // In waiting state, we directly let A delay for N/2 cycle.
            WAITING: begin
                out_r = 0;
                out_i = 0;
                SR_r = A_r;
                SR_i = A_i;
            end
            
            // In first state, add the delayed-data with input data and output it (g)
            // Also, subtract the delayed-data from input data and 
            // let it delay for N/2 cycle (send it to shift register)
            FIRST: begin
                out_r = A_r + B_r;
                out_i = A_i + B_i;
                SR_r = A_r - B_r;
                SR_i = A_i - B_i;
            end

            // In second state, multiply delayed-data (h1~hN) with corresponding W (
            // W^0~W^(N-1)/2 and output it
            SECOND: begin
                out_r = tempA[26:8];
                out_i = tempB[26:8];
                SR_r = 0;
                SR_i = 0;
            end
            
            default: begin
                out_r = 0;
                out_i = 0;
                SR_r = 0;
                SR_i = 0;
            end

        endcase
    end

endmodule