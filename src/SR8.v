module SHIFTREG_8(
    input                   clk,
    input                   rst,
    input [14:0]            in_r,
    input [14:0]            in_i,
    output [14:0]           out_r,
    output [14:0]           out_i,
);
    // change LENGTH here to set up the length of this shift register
    //=================================================

                    parameter LENGTH = 8;

    //=================================================
    
    integer i;
    reg [14:0] r_bus [LENGTH-1:0];
    reg [14:0] i_bus [LENGTH-1:0];
    
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