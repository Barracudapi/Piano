`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/22 00:05:12
// Design Name: 
// Module Name: tubs_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tubs_tb(
    );
    
//    reg [2:0] interval;
//    //input [5:0] note_cnt,
//    reg [3:0] digit1, digit2;
    //input [3:0] sw,
    reg rst_n, clk;
    wire [7:0] seg_en; //select which tubs to light up
    wire [7:0] seg_out0; //left
    wire [7:0] seg_out1;//right
    
    scan_seg dut(3'd2, 4'd9, 4'd 3, rst_n, clk, scan_seg, seg_out0, seg_out1);
    
    initial begin
    rst_n = 1;
    clk = 1;
    forever #5 clk = ~clk;
    end
    
    initial fork
    #2000_0000 rst_n = 0;
    #2000_2000 rst_n = 1;
    join
    
    
    
    
endmodule
