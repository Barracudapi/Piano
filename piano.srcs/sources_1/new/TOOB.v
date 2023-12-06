`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 23:21:20
// Design Name: 
// Module Name: TOOB
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


module TOOB(
input [7:0] tob,
output tub_sel,
output [7:0] tub_control
    );
    
    assign tub_sel = 1'b1;
    assign tub_control = tob;
endmodule
