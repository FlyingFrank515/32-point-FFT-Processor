`timescale 1ns/10ps
`define CYCLE    10           	         // Modify your clock period here

`include "STAGE1.v"             

// module STAGE1(
//     input                   clk,
//     input                   rst,
//     input                   valid_i,
//     input signed [18:0]     data_in_r,
//     input signed [18:0]     data_in_i,

//     output                  valid_o;
//     output signed [18:0]    data_out_r,
//     output signed [18:0]    data_out_i,
// );

module STAGE1_tb;
    
    integer i;
    reg clk, rst, valid, stop;
    reg [18:0] before_ff [0:31];
    reg [18:0] data_in_r;
    wire [18:0] data_out_i, data_out_r;
    wire finish;

    STAGE1 test(
        .clk(clk),
        .rst(rst),
        .valid_i(valid),
        .data_in_r(data_in_r),
        .data_in_i(19'd0),

        .valid_o(finish),
        .data_out_r(data_out_r),
        .data_out_i(data_out_i)
    );     

    initial	$readmemb ("input_19bit_1.txt",  before_ff);

    initial begin
        clk         = 1'b1;
        rst         = 1'b1;  
        valid       = 1'b0;
        stop        = 1'b0;
        i           = 0;
        #2.5 rst=1'b0;         
        #2.5 rst=1'b1;

    end

    always begin #(`CYCLE/2) clk = ~clk; end

    initial begin
        $dumpfile("stage1.fsdb");
        $dumpvars;
    end

    always @(negedge clk)begin
        if(i < 32) begin
            valid = 1; 
            data_in_r = before_ff[i];
            i = i+1;      
        end
        else if(i < 51) begin
            data_in_r = 0;
            i = i+1;
        end
        else begin
            data_in_r = 0;
            stop = 1;
        end
    end

    always @(posedge stop)begin
        $finish;
    end

    // always @(posedge clk)begin
        
    //     if(dataout !== out_temp && out_temp!==16'h0000) begin
    //         $display("ERROR at %d:output %h !=expect %h ",pattern_num-2, dataout, out_temp);
    // 	    $fdisplay(out_f,"ERROR at %d:output %h !=expect %h ",pattern_num-2, dataout, out_temp);
    //         err = err + 1 ;
    //     end
    //     pattern_num = pattern_num + 1; 
    //     if(pattern_num === OUT_LENGTH)  over = 1'b1;
    // end

    // initial begin
    //       @(posedge stop)      
    //       if(over) begin
    //          $display("---------------------------------------------\n");
    //          if (err == 0)  begin
    //             $display("All data have been generated successfully!\n");
    // 			$display("You will get 80 score in this RTL!\n");
    //             $display("-------------------PASS-------------------\n");
    //          end
    //          else begin
    //             $display("There are %d errors!\n", err);
    // 			$display("You will get %d score in this RTL!\n", 80-err);
    // 		 end
    //             $display("---------------------------------------------\n");
    //       end
    //       else begin
    //         $display("---------------------------------------------\n");
    //         $display("Error!!! There is no any data output ...!\n");
    //         $display("-------------------FAIL-------------------\n");
    //         $display("---------------------------------------------\n");
    //       end
    //       $finish;
    // end
   
endmodule









