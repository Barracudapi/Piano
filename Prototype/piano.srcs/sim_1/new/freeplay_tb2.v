`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 12:28:12
// Design Name: 
// Module Name: freeplay_tb2
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


module freeplay_tb2(
    );
    reg [2:0]button;
    reg [7:0]sw;
    wire [10:0] frequency;
    
    free_play tb(button, sw, frequency);
       
       initial begin
       button = 3'b001;
       end
        initial fork
        #100 sw = 8'b00000001;
        join
endmodule
