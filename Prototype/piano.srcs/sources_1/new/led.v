`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/23 17:17:07
// Design Name: 
// Module Name: led
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


module led(
input  [7:0] sw,
input  [2:0] range,
output reg [7:0] ledsw,
output reg [2:0] ledrange
    );
   
   always@(sw, range) begin
    ledsw = sw;
    ledrange = range;
    end
   
endmodule
