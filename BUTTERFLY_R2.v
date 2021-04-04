// ===================================================================
// Module: BUTTERFLY_R2

// This is Butterfly-unit for doing radix2-FFT.
// Note: Only contain the combinational part

// ===================================================================
module BUTTERFLY_R2(
    input [1:0]                 state,
    input signed [18:0]         A_r,
    input signed [18:0]         A_i,
    input signed [18:0]         B_r,
    input signed [18:0]         B_i,
    input signed [8:0]          WN_r,
    input signed [8:0]          WN_i,
    
    output                      valid_o, 
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
    
    // Wire Reg declaration
    wire signed [28:0] mul13, mul24, mul14, mul23;
    wire signed [29:0] tempA, tempB;

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
                valid_o = 0;
                SR_r = 0;
                SR_i = 0;
            end

            WAITING: begin
                out_r = 0;
                out_i = 0;
                valid_o = 0;
                SR_r = A_r;
                SR_i = A_i;
            end
            
            FIRST: begin
                out_r = A_r + B_r;
                out_i = A_i + B_i;
                valid_o = 1;
                SR_r = A_r - B_r;
                SR_i = A_i - B_i;
            end

            SECOND: begin
                out_r = tempA[26:8];
                out_i = tempB[26:8];
                valid_o = 1;
                SR_r = 0;
                SR_i = 0;
            end
            
            default: begin
                out_r = 0;
                out_i = 0;
                valid_o = 0;
                SR_r = 0;
                SR_i = 0;
            end

        endcase
    end

endmodule