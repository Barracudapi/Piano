`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/07 15:22:10
// Design Name: 
// Module Name: clk1_tb
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


module clk1_tb(

    );
    
    reg clk;
    reg rst;
    wire clk_1;
    
    clock1 c1(clk, rst, clk_1);
    
    initial begin
    clk = 0;
    rst = 0;

    end
    
    s
    
endmodule
