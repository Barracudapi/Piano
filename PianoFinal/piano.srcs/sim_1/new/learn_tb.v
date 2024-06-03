`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/24 17:08:23
// Design Name: 
// Module Name: learn_tb
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


module learn_tb(
    );
    reg clk, reset;
    reg [7:0] sw;
    reg [2:0] octave_sw;
    reg select_song_btn;
    reg learn_btn, evaluate_btn;
    wire sd;
    wire melody;
    wire [7:0] guide_lights;
    wire [7:0] seg_en;
    wire [7:0] seg_out0,seg_out1;
    wire [3:0] interval_led;
    wire [2:0] state_led;
    
    learn_mode lm( clk, reset,
     sw,
     octave_sw,
     select_song_btn,
     learn_btn, evaluate_btn,
     sd,
     melody,
    guide_lights,
     seg_en,
    seg_out0, seg_out1,
     interval_led,
     state_led);
     
     initial begin 
     clk = 0;
     reset = 1;
     sw = 0;
     octave_sw = 0;
     select_song_btn = 0;
     learn_btn = 0;
     evaluate_btn = 0;
     forever #5 clk = ~clk;
     end
     
     //20ms   
     
     initial fork
     #5 reset = 0;
     #15 reset = 1;
     #30 octave_sw = 3'b100;
     #35 sw = 8'b0010_0000;
     
     
     #1000 sw = 8'b0000_1000;
     #1005 octave_sw = 3'b001;
     
//     #4_000_0000 playbtn = 1;
//     #6_000_0100 playbtn = 0;
     
//     #1_0000_0000 pausebtn = 1;
//     #1_3000_0000 pausebtn = 0;
     
//     #1_5000_1000 pausebtn = 1;
//     #1_8000_0000 pausebtn = 0;
     
//     #2_0000_0000 stopbtn = 1;
//     #2_3000_0000 stopbtn = 0;
     
//     #2_5000_0000 ssbtn = 1;
//     #2_8000_0000 ssbtn = 0;
     
//     #3_0000_0000 playbtn = 1;
//     #3_3000_0000 playbtn = 0;
     
     
     join
     
     
endmodule
