`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/25 19:25:23
// Design Name: 
// Module Name: auto_play_tb
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


module auto_play_tb(
);

reg clk;
reg reset;
reg btn, pausebtn;
wire [5:0]cnt;
wire [4:0] music;
wire [4:0] music1;
wire melody;

auto_play ap(clk, reset, btn, pausebtn, cnt, music, music1, melody);

initial begin
clk = 1'b0;
reset = 1'b1;
btn = 1'b1;
pausebtn = 1'b1;
forever #5 clk = ~clk;
end
initial fork
#10 btn = 1'b0;
#20 btn = 1'b1;
join


endmodule
