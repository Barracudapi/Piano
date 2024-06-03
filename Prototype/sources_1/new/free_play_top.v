`timescale 1ns / 1ps
/////f/////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 09:02:12
// Design Name: 
// Module Name: free_play_top
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


module free_play_top(
 input en,
 input clk, input reset,
 input wire [2:0] button,
 input [7:0] sw,
 output melody,
 output [7:0] ledsw,
 output [7:0] ledrange,
 output [7:0] seg_en,
 output [7:0]seg_outl, //left
 output [7:0]seg_outr //right
    );
     `include "ppppparameters.v"
    wire [10:0] frequency;
    wire [1:0] state;
    wire [2:0] note;

    
    free_play playy(en, clk, reset, button, sw, frequency, state, note);
    
    led lll(en,clk, reset, sw, state, ledsw, ledrange);
    
    free_tubs ft(en, clk, reset, state, note, seg_en, seg_outl, seg_outr);
    
    
    generate_melody gm(.clk(clk), .frequency(frequency), .melody(melody));
endmodule
