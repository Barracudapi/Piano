`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 09:11:47
// Design Name: 
// Module Name: freeplay_tb
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


module freeplay_tb( );
    reg reset;
    reg clk_div;
    reg [2:0]button;
    reg [7:0]sw;
    wire melody;
    

    free_play_top tb(clk_div, reset, button, sw, melody);
    
    initial begin
    clk_div = 1'b0;
    reset = 1'b1;
    button = 3'b001;
    forever #5 clk_div = ~clk_div;
    end
    initial fork
     #0 sw = 8'b00000001;
    join
endmodule
