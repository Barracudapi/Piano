`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/11 21:22:45
// Design Name: 
// Module Name: TOOB
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


module TOOB(
input [4:0] symbol,
output tub_sel,
output reg [7:0] tub_control
    );
    assign tub_sel = 1'b1;
    
    always @(*) begin
        case(symbol)
        5'b00000: tub_control = 8'b11101110;
         5'b00001: tub_control = 8'b00111110;
         5'b00010: tub_control = 8'b10011100;
         5'b00011: tub_control = 8'b01111010;
         5'b00100: tub_control = 8'b10011110;
        default:
        tub_control = 8'b00000000;
        endcase
        end
endmodule
