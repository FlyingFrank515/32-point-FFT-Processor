module SORTING(
    input                   clk,
    input                   rst,
    input                   start_sorting,
    input  signed [15:0]    out_r,
    input  signed [15:0]    out_i,
    output signed [15:0]    result_r[0;31],
    output signed [15:0]    result_i[0:31],
);

integer             i;
reg                 sort, next_sort;
reg          [4:0]  count, next_count;
reg  signed  [15:0] next_out_r;
reg  signed  [15:0] next_out_i;
reg  signed  [15:0] next_result_r[0:31];
reg  signed  [15:0] next_result_i[0:31];

count = 5'd0;
if(start_sorting)sort = 1;
always@(*) begin
    next_sort = sort;
    next_count = count;
    if(next_sort) begin
        case(next_count)
            5'd0 : begin
                next_result_r[31] = next_out_r;
                next_result_i[31] = next_out_i;
            end
            5'd1 : begin
                next_result_r[15] = next_out_r;
                next_result_i[15] = next_out_i;
            end
            5'd2 : begin
                next_result_r[7] = next_out_r;
                next_result_i[7] = next_out_i;
            end
            5'd3 : begin
                next_result_r[23] = next_out_r;
                next_result_i[23] = next_out_i;
            end
            5'd4 : begin
                next_result_r[3] = next_out_r;
                next_result_i[3] = next_out_i;
            end
            5'd5 : begin
                next_result_r[19] = next_out_r;
                next_result_i[19] = next_out_i;
            end
            5'd6 : begin
                next_result_r[11] = next_out_r;
                next_result_i[11] = next_out_i;
            end
            5'd7 : begin
                next_result_r[27] = next_out_r;
                next_result_i[27] = next_out_i;
            end
            5'd8 : begin
                next_result_r[1] = next_out_r;
                next_result_i[1] = next_out_i;
            end
            5'd9 : begin
                next_result_r[17] = next_out_r;
                next_result_i[17] = next_out_i;
            end
            5'd10 : begin
                next_result_r[9] = next_out_r;
                next_result_i[9] = next_out_i;
            end
            5'd11 : begin
                next_result_r[25] = next_out_r;
                next_result_i[25] = next_out_i;
            end
            5'd12 : begin
                next_result_r[5] = next_out_r;
                next_result_i[5] = next_out_i;
            end
            5'd13 : begin
                next_result_r[21] = next_out_r;
                next_result_i[21] = next_out_i;
            end
            5'd14 : begin
                next_result_r[13] = next_out_r;
                next_result_i[13] = next_out_i;
            end
            5'd15 : begin
                next_result_r[29] = next_out_r;
                next_result_i[29] = next_out_i;
            end
            5'd16 : begin
                next_result_r[0] = next_out_r;
                next_result_i[0] = next_out_i;
            end
            5'd17 : begin
                next_result_r[16] = next_out_r;
                next_result_i[16] = next_out_i;
            end
            5'd18 : begin
                next_result_r[8] = next_out_r;
                next_result_i[8] = next_out_i;
            end
            5'd19 : begin
                next_result_r[24] = next_out_r;
                next_result_i[24] = next_out_i;
            end
            5'd20 : begin
                next_result_r[4] = next_out_r;
                next_result_i[4] = next_out_i;
            end
            5'd21 : begin
                next_result_r[20] = next_out_r;
                next_result_i[20] = next_out_i;
            end
            5'd22 : begin
                next_result_r[12] = next_out_r;
                next_result_i[12] = next_out_i;
            end
            5'd23 : begin
                next_result_r[28] = next_out_r;
                next_result_i[28] = next_out_i;
            end
            5'd24 : begin
                next_result_r[2] = next_out_r;
                next_result_i[2] = next_out_i;
            end
            5'd25 : begin
                next_result_r[18] = next_out_r;
                next_result_i[18] = next_out_i;
            end
            5'd26 : begin
                next_result_r[10] = next_out_r;
                next_result_i[10] = next_out_i;
            end
            5'd27 : begin
                next_result_r[26] = next_out_r;
                next_result_i[26] = next_out_i;
            end
            5'd28 : begin
                next_result_r[6] = next_out_r;
                next_result_i[6] = next_out_i;
            end
            5'd29 : begin
                next_result_r[22] = next_out_r;
                next_result_i[22] = next_out_i;
            end
            5'd30 : begin
                next_result_r[14] = next_out_r;
                next_result_i[14] = next_out_i;
            end
            5'd31 : begin
                next_result_r[30] = next_out_r;
                next_result_i[30] = next_out_i;
                next_sort = 0;
            end
        next_count++;
    end
end

always@(posedge clk or negedge rst) begin
    if(~rst)begin
        next_out_r <= 0;
        next_out_i <= 0;
        for (i = 0; i < 31; i++) begin
            result_r[i] <= 0;
            result_i[i] <= 0;
        end
        sort <= 0;
        count <= 0;
    end
    else begin
        next_out_r <= out_r;
        next_out_i <= out_i;
        for (i = 0; i < 31; i++) begin
            result_r[i] <= next_result_r[i];
            result_i[i] <= next_out_i[i];
        end
        sort <= next_sort;
        count <= next_count;
    end
end