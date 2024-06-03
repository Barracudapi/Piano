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
wire sd;
wire melody;


auto_play ap(clk, reset, ssbtn, pausebtn,stopbtn, playbtn, sd, melody);

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
#10 reset = 1;
#20 reset = 0;

//we select the first song
#30 ssbtn = 1'b1;
#3_000_0000 ssbtn = 1'b0;

#4_000_0000 playbtn = 1;
#6_000_0100 playbtn = 0;

#15_0000_0000 pausebtn = 1;
#15_3000_0000 pausebtn = 0;

#16_0000_0000 pausebtn = 1;
#16_3000_0000 pausebtn = 0;

#17_0000_0000 ssbtn = 1;
#17_3000_0000 ssbtn = 0;





join


endmodule
