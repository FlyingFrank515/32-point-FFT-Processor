module SORTING(
    clk,
    rst,
    start_sorting,
    out_r,
    out_i,
    result_r,
    result_i
);

integer               i;
input                 clk, rst, start_sorting;
reg                   sort, next_sort;
reg            [4:0]  count, next_count;
input  signed  [15:0] out_r;
input  signed  [15:0] out_i;
output signed  [15:0] result_r[0:31];
output signed  [15:0] result_i[0:31];
reg  signed    [15:0] prev_out_r;
reg  signed    [15:0] prev_out_i;
reg  signed    [15:0] next_result_r[0:31];
reg  signed    [15:0] next_result_i[0:31];

initial begin
    count = 0;
end
always@(posedge start_sorting) begin
    sort = 1'b1;
end

always@(*) begin
    next_sort = sort;
    next_count = count;
    if(next_sort) begin
        case(next_count)
            5'd0 : begin
                next_result_r[31] = prev_out_r;
                next_result_i[31] = prev_out_i;
            end
            5'd1 : begin
                next_result_r[15] = prev_out_r;
                next_result_i[15] = prev_out_i;
            end
            5'd2 : begin
                next_result_r[7] = prev_out_r;
                next_result_i[7] = prev_out_i;
            end
            5'd3 : begin
                next_result_r[23] = prev_out_r;
                next_result_i[23] = prev_out_i;
            end
            5'd4 : begin
                next_result_r[3] = prev_out_r;
                next_result_i[3] = prev_out_i;
            end
            5'd5 : begin
                next_result_r[19] = prev_out_r;
                next_result_i[19] = prev_out_i;
            end
            5'd6 : begin
                next_result_r[11] = prev_out_r;
                next_result_i[11] = prev_out_i;
            end
            5'd7 : begin
                next_result_r[27] = prev_out_r;
                next_result_i[27] = prev_out_i;
            end
            5'd8 : begin
                next_result_r[1] = prev_out_r;
                next_result_i[1] = prev_out_i;
            end
            5'd9 : begin
                next_result_r[17] = prev_out_r;
                next_result_i[17] = prev_out_i;
            end
            5'd10 : begin
                next_result_r[9] = prev_out_r;
                next_result_i[9] = prev_out_i;
            end
            5'd11 : begin
                next_result_r[25] = prev_out_r;
                next_result_i[25] = prev_out_i;
            end
            5'd12 : begin
                next_result_r[5] = prev_out_r;
                next_result_i[5] = prev_out_i;
            end
            5'd13 : begin
                next_result_r[21] = prev_out_r;
                next_result_i[21] = prev_out_i;
            end
            5'd14 : begin
                next_result_r[13] = prev_out_r;
                next_result_i[13] = prev_out_i;
            end
            5'd15 : begin
                next_result_r[29] = prev_out_r;
                next_result_i[29] = prev_out_i;
            end
            5'd16 : begin
                next_result_r[0] = prev_out_r;
                next_result_i[0] = prev_out_i;
            end
            5'd17 : begin
                next_result_r[16] = prev_out_r;
                next_result_i[16] = prev_out_i;
            end
            5'd18 : begin
                next_result_r[8] = prev_out_r;
                next_result_i[8] = prev_out_i;
            end
            5'd19 : begin
                next_result_r[24] = prev_out_r;
                next_result_i[24] = prev_out_i;
            end
            5'd20 : begin
                next_result_r[4] = prev_out_r;
                next_result_i[4] = prev_out_i;
            end
            5'd21 : begin
                next_result_r[20] = prev_out_r;
                next_result_i[20] = prev_out_i;
            end
            5'd22 : begin
                next_result_r[12] = prev_out_r;
                next_result_i[12] = prev_out_i;
            end
            5'd23 : begin
                next_result_r[28] = prev_out_r;
                next_result_i[28] = prev_out_i;
            end
            5'd24 : begin
                next_result_r[2] = prev_out_r;
                next_result_i[2] = prev_out_i;
            end
            5'd25 : begin
                next_result_r[18] = prev_out_r;
                next_result_i[18] = prev_out_i;
            end
            5'd26 : begin
                next_result_r[10] = prev_out_r;
                next_result_i[10] = prev_out_i;
            end
            5'd27 : begin
                next_result_r[26] = prev_out_r;
                next_result_i[26] = prev_out_i;
            end
            5'd28 : begin
                next_result_r[6] = prev_out_r;
                next_result_i[6] = prev_out_i;
            end
            5'd29 : begin
                next_result_r[22] = prev_out_r;
                next_result_i[22] = prev_out_i;
            end
            5'd30 : begin
                next_result_r[14] = prev_out_r;
                next_result_i[14] = prev_out_i;
            end
            5'd31 : begin
                next_result_r[30] = prev_out_r;
                next_result_i[30] = prev_out_i;
                next_sort = 0;
            end
        endcase
    end
end

always@(posedge clk or negedge rst) begin
    if(~rst)begin
        prev_out_r <= 0;
        prev_out_i <= 0;
        for (i = 0; i < 31; i = i+1) begin
            result_r[i] <= 0;
            result_i[i] <= 0;
        end
        sort <= 0;
        count <= 0;
    end
    else begin
        prev_out_r <= out_r;
        prev_out_i <= out_i;
        for (i = 0; i < 31; i = i+1) begin
            result_r[i] <= next_result_r[i];
            result_i[i] <= prev_out_i[i];
        end
        sort <= next_sort;
        count <= next_count + 1;
    end
end
endmodule