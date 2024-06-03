`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
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
 input clk, input reset,
 input wire [2:0] button,
 input [7:0] sw,
 output sd,
 output melody,
 output [7:0] ledsw,
 output [2:0] ledrange
    );
    
    assign sd = 1'b1;
    wire clk_div;
    
    wire [10:0] frequency;
   
//    clock_divider clock(
//        .clk(clk),
//        .reset(reset),
//        .clk_div(clk_div)
//    );

    free_play play(clk, reset, button, sw, frequency);
    
    led(sw, button, ledsw, ledrange);
    
    
    generate_melody gm(.clk(clk), .frequency(frequency), .melody(melody));
endmodule
