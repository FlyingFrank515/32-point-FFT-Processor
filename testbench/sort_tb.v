`timescale 1ns/10ps
`define CYCLE    10

module SORT_tb;

integer i, j, f;
    reg clk, rst, start, finish, stop;
    reg          [15:0] before [0:31];
    reg  signed  [15:0] input_r;
    reg  signed  [15:0] input_i;
    reg  signed  [15:0] gold_r[0:31];
    reg  signed  [15:0] gold_i[0:31];
    reg  signed  [15:0] output_r[0:31];
    reg  signed  [15:0] output_i[0:31];


    SORTING test(
    .clk(clk),
    .rst(rst),
    .start_sorting(start),
    .out_r(input_r),
    .out_i(input_i),
    .result_r(output_r),
    .result_i(output_i)
    );

    initial	begin
        $readmemb ("sorting_test.txt",  before);
        f = $fopen("sorting_result.txt","w");
    end

    initial begin
        clk         = 1'b1;
        stop        = 1'b0;
        finish      = 1'b0;
        rst         = 1'b1;  
        start       = 1'b0;
        #2.5 rst=1'b0;         
        #2.5 rst=1'b1;
        start       = 1'b1;

    end

    always begin #(`CYCLE/2) clk = ~clk; end

    initial begin
        $dumpfile("sort.fsdb");
        $dumpvars;
    end

    always @(negedge clk)begin
        if(i < 32) begin
            start = 1; 
            input_r = before[i][31:16];
            input_i = before[i][15:0];
            i = i+1;      
        end
        else begin
            finish = 1'b1;
        end
        
    end

    always @(negedge clk)begin
        if(finish) begin
            $fwrite(f,"%b/%b\n", output_r, output_i);
            stop = 1'b1;
        end

    end

    always @(posedge stop)begin
        $fclose(f);
        $finish;
    end
endmodule