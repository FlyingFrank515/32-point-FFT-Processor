// ===================================================================
// Module: SR16
// 
// This is shift register of stage-1. (Used as the single path delay)
// 
// ===================================================================
module SR16(
    input                   clk,
    input                   rst,
    input [8:0]             in_r, //(6,3)
    input [8:0]             in_i, //(6,3)
    
    output [8:0]            out_r,//(6,3)
    output [8:0]            out_i //(6,3)
);
    // change LENGTH here to set up the length of this shift register
    //=================================================

                    parameter LENGTH = 16;

    //=================================================
    
    integer i;
    reg [8:0] r_bus [LENGTH-1:0];
    reg [8:0] i_bus [LENGTH-1:0];
    
    assign out_r = r_bus[0];
    assign out_i = i_bus[0];

    always@ (posedge clk or negedge rst) begin
        if(!rst) begin
            for(i = 0; i < LENGTH; i = i+1) begin
                r_bus[i] <= 0;
                i_bus[i] <= 0;
            end
        end
        else begin
            r_bus[LENGTH-1] <= in_r;
            i_bus[LENGTH-1] <= in_i;
            
            for(i = 0; i < (LENGTH-1); i = i+1) begin
                r_bus[i] <= r_bus[i+1];
                i_bus[i] <= i_bus[i+1];
            end
        end
    end

endmodule