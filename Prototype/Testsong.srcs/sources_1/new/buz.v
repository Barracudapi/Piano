`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/25 18:39:57
// Design Name: 
// Module Name: buz
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


module buz(
input clk,
input M,
output [7:0] state,
output [4:0] m,
output B
);
 

state m2(clk,M,state, m);
music m3(clk,m,M,B);

 
 
endmodule
