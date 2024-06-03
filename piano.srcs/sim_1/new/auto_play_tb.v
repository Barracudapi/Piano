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
reset = 1'b1;
ssbtn = 0;
pausebtn = 0;
stopbtn = 0;
playbtn = 1'b0;
forever #5 clk = ~clk;
end
initial fork
#10 reset = 0;
#20 reset = 1;

//we select the first song
#30 ssbtn = 1'b1;
#3_000_0000 ssbtn = 1'b0;

#4_000_0000 playbtn = 1;
#6_000_0100 playbtn = 0;

#1_0000_0000 pausebtn = 1;
#1_3000_0000 pausebtn = 0;

#1_5000_1000 pausebtn = 1;
#1_8000_0000 pausebtn = 0;

#2_0000_0000 stopbtn = 1;
#2_3000_0000 stopbtn = 0;

#2_5000_0000 ssbtn = 1;
#2_8000_0000 ssbtn = 0;

#3_0000_0000 playbtn = 1;
#3_3000_0000 playbtn = 0;





join


endmodule
