`timescale 1ns/10ps
`define CYCLE    10

module SORT_tb;

integer i, j, f;
    reg clk, rst, start;
    reg  signed  [15:0] input_r;
    reg  signed  [15:0] input_i;
    reg  signed  [15:0] gold_r[0;31];
    reg  signed  [15:0] gold_i[0;31];

    SORTING test(
    .clk(clk),
    .rst(rst),
    .start_sorting(start),
    .out_r(input_r),
    .out_i(input_i),
    .result_r(output_r),
    .result_i(output_i),
    );