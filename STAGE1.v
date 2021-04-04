// ===================================================================
// Module: STAGE1

// Combine CTRL16, radix2, SR16

// ===================================================================
`include "BUTTERFLY_R2.v"
`include "SR16.v"
`include "CTRL16.v"

module STAGE1(
    input                   clk,
    input                   rst,
    input                   valid_i,
    input signed [18:0]     data_in_r,
    input signed [18:0]     data_in_i,

    output                  valid_o;
    output signed [18:0]    data_out_r,
    output signed [18:0]    data_out_i,
);
    // Wire Reg declaration
    wire [1:0] state_bus;
    wire [8:0] WN_r_bus, WN_i_bus;
    wire [18:0] SR_r_bus, SR_i_bus;
    wire [18:0] FB_r_bus, FB_i_bus;
    wire [18:0] data_r_bus, data_i_bus;
    
    CTRL16 Control_unit(
        .clk(clk),
        .rst(rst),
        .valid_i(valid_i),
        .data_in_r(data_in_r),
        .data_in_i(data_in_i),

        .state(state_bus),
        .data_out_r(data_r_bus),
        .data_out_i(data_i_bus),
        .WN_r(WN_r_bus),
        .WN_i(WN_i_bus)
    );
    
    SR16 shiftregister(
        .clk(clk),
        .rst(rst),
        .in_r(SR_r_bus),
        .in_i(SR_i_bus),
        
        .out_r(FB_r_bus),
        .out_i(FB_i_bus)
    );

    BUTTERFLY_R2 butterfly(
        .state(state_bus),
        .A_r(data_r_bus),
        .A_i(data_i_bus),
        .B_r(FB_r_bus),
        .B_i(FB_i_bus),
        .WN_r(WN_r_bus),
        .WN_i(WN_i_bus),

        .valid_o(valid_o),
        .osut_r(data_out_r),
        .out_i(data_out_i),
        .SR_r(SR_r_bus),
        .SR_i(SR_i_bus)
    );

endmodule