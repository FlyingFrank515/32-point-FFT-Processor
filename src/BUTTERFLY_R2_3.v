// ====================================================================
// Module: BUTTERFLY_R2_3                                               
// 
// This is Butterfly-unit for doing radix2-FFT. where B is connected
// to the output of the shift-register (single path delay) and that A 
// is connected to the data input. 
// 
// Note: Only contain the combinational part, so the next stage should
// add the flipflop to its input to ensure the existence of full 
// access time
// 
// A, B, out, SR : 10-bit integer, 6-bit fractional
// WN            : 2-bit  integer, 6-bit fractional
// ===================================================================
module BUTTERFLY_R2_3(
    input [1:0]                 state,
    input signed [14:0]         A_r,
    input signed [14:0]         A_i,
    input signed [15:0]         B_r,
    input signed [15:0]         B_i,
    input [1:0]                 WN,
    
    output reg signed [15:0]    out_r,
    output reg signed [15:0]    out_i,
    output reg signed [15:0]    SR_r,
    output reg signed [15:0]    SR_i
);
    // state parameter
    parameter IDLE      = 2'b00;
    parameter FIRST     = 2'b01;
    parameter SECOND    = 2'b10;
    parameter WAITING   = 2'b11;

    // WN parameter
    parameter ZERO      = 2'b00;
    parameter ONE       = 2'b01;
    parameter TWO       = 2'b10;
    parameter THREE     = 2'b11;
    
    // Wire-Reg declaration
    wire [15:0] B_r_neg, B_i_neg;
    
    assign B_r_neg = ~B_r + 1;
    assign B_i_neg = ~B_i + 1;
    
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
                SR_r = {A_r[14], A_r};
                SR_i = {A_i[14], A_i};
            end
            
            // In first state, add the delayed-data with input data and output it (g)
            // Also, subtract the delayed-data from input data and 
            // let it delay for N/2 cycle (send it to shift register)
            FIRST: begin
                out_r = $signed({A_r[14], A_r}) + B_r;
                out_i = $signed({A_i[14], A_i}) + B_i;
                SR_r = B_r - $signed({A_r[14], A_r}); // B:from delay, A: from input
                SR_i = B_i - $signed({A_i[14], A_i});
            end

            // In second state, multiply delayed-data (h1~hN) with corresponding W (
            // W^0~W^(N-1)/2 and output it
            SECOND: begin
                case(WN)
                    ZERO: begin
                        out_r = B_r;
                        out_i = B_i;
                    end
                    ONE: begin
                        out_r = B_i;
                        out_i = B_r_neg;
                    end
                    TWO: begin
                        out_r = B_r_neg;
                        out_i = B_i_neg;
                    end
                    THREE: begin
                        out_r = B_i_neg;
                        out_i = B_r;
                    end
                    default: begin
                        out_r = B_i_neg;
                        out_i = B_r;
                    end
                endcase
                SR_r = {A_r[14], A_r};
                SR_i = {A_i[14], A_i};
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