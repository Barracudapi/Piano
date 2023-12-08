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
reg ssbtn, pausebtn;
reg stopbtn, playbtn;
wire [5:0]cnt;
wire [4:0] music;
wire [4:0] music1;
wire melody;
wire sd;

auto_play ap(clk, reset, ssbtn, pausebtn,stopbtn, playbtn, sd, cnt, melody);

initial begin
clk = 1'b0;
reset = 1'b0;
ssbtn = 0;
pausebtn = 0;
stopbtn = 0;
playbtn = 1'b0;
forever #5 clk = ~clk;
end
initial fork
#10 ssbtn = 1'b0;
#20 ssbtn = 1'b1;
join


endmodule
