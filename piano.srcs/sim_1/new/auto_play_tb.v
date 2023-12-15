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
reg [2:0] select;
reg pausebtn;
reg stopbtn, playbtn;
wire sd;
wire melody;


auto_play ap(clk, reset, select, pausebtn,stopbtn, playbtn, sd, melody);

initial begin
clk = 1'b0;
reset = 1'b0;
select = 0;
pausebtn = 0;
stopbtn = 0;
playbtn = 1'b0;
forever #5 clk = ~clk;
end
initial fork
#10 reset = 1;
#20 reset = 0;

//we select the first song
#30 select = 3'b100;
#1_500_0000 select = 3'b010;

#4_000_0000 playbtn = 1;
#6_000_0100 playbtn = 0;

#7_000_0000 pausebtn = 1;
#9_300_0000 pausebtn = 0;









join


endmodule
