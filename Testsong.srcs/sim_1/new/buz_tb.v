`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/25 18:40:33
// Design Name: 
// Module Name: buz_tb
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


module buz_tb(
);
reg sclk, M;
wire b;
wire [7:0]state;
wire [4:0]m;


buz dut(sclk, M, state, m, b);
initial begin
M = 1'b1;
sclk = 1'b0;
forever #5 sclk = ~sclk;
end

endmodule
