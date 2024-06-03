`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/11 21:35:07
// Design Name: 
// Module Name: toob_sim
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


module toob_sim(
    );
    reg clk;
    reg [1:0] counter;
    wire tub_sel;
    wire [7:0] tub_control;
    
    TOOB tb(clk, counter, tub_sel, tub_control);
    
    initial begin
    counter = 2'b00;
    forever #5 clk = ~clk;
    end
    initial fork
    #50 counter = 2'b01;
    #100 counter = 2'b10;
    #220 counter = 2'b11;
    #250 $finish;
    join
endmodule
