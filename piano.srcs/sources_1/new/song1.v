`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/23 17:17:41
// Design Name: 
// Module Name: song1
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


module song1(
input wire clk,
input wire reset,
input wire [5:0] cnt,
output reg [4:0] music
    );
    always @(posedge clk or negedge reset)begin
        if(reset == 1'b0)
            music <= 5'd0;
        else
            case(cnt) 
            
            
            
            endcase
            end
 
endmodule
