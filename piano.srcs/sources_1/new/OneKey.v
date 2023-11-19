`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/19 14:22:12
// Design Name: 
// Module Name: OneKey
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


module OneKey(
input clk,
input reset,
output reg key_on_out,
output reg key_off_out,
input key_gpio_in
    );
    wire pos_edge, neg_edge;
    
    localparam    IDLE = 4'b0001,
               negEdge = 4'b0010,
                  Down = 4'b0100,
               posEdge = 4'b1000
 
endmodule
