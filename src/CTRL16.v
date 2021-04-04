// ===================================================================
// Module: CTRL16
// 
// This is control-unit for 1st stage Butterfly unit
// Function:
//      1. Determine the input of the butterfly-unit
//      2. Give the exp(-j*2pi*n/N) to BUtterfly unit
//      3. Control the input and the mux before/after the shift register
//
// ===================================================================
module CTRL16(
    input                       clk,
    input                       rst,
    input                       valid_i,
    input signed [18:0]         data_in_r,
    input signed [18:0]         data_in_i,
    
    output reg [1:0]            state,
    output reg signed [18:0]    data_out_r,
    output reg signed [18:0]    data_out_i,
    output reg signed [8:0]     WN_r,
    output reg signed [8:0]     WN_i,
);
    
    // state parameter
    parameter IDLE      = 2'b00;
    parameter FIRST     = 2'b01;
    parameter SECOND    = 2'b10;
    parameter WAITING   = 2'b11;

    // Wire Reg declaration
    reg [8:0] count, next_count;
    reg [1:0] next_state;
    
    // Combinational part
    always@(*) begin
        next_count = count;
        next_state = state;
        case(state)
            IDLE: begin
                next_count = 0;
                if(valid_i) begin
                    next_state = WAITING;
                    next_count = count + 1;
                end
            end
            WAITING: begin
                next_count = count + 1;
                if(count == 16) begin
                    next_state = FIRST;
                end
            end
            FIRST: begin
                next_count = count + 1;
                if(count == 32) begin
                    next_state = SECOND;
                end
            end
            SECOND: begin
                next_count = count + 1;
                case(count)
                    33: begin

                    end
                    34: begin
                        
                    end
                    35: begin
                        
                    end
                    36: begin
                        
                    end
                    37: begin
                        
                    end
                    38: begin
                        
                    end
                    39: begin
                        
                    end
                    40: begin
                        
                    end
                    41: begin
                        
                    end
                    42: begin
                        
                    end
                    43: begin
                        
                    end
                    44: begin
                        
                    end
                    45: begin
                        
                    end
                    46: begin
                        
                    end
                    47: begin
                        
                    end
                    48: begin
                        
                    end
                endcase
                if(count == 48) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Sequential part
    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            state <= IDLE;
            count <= 0;
            data_out_r <= 0;
            data_out_i <= 0;
        end
        else begin
            state <= next_state;
            count <= next_count;
            data_out_r <= data_in_r;
            data_out_i <= data_in_i;
        end
    end
endmodule