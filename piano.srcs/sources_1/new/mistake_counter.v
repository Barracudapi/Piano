`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/17 20:13:43
// Design Name: 
// Module Name: mistake_counter
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


module mistake_counter(
input [5:0] mistake,
output tub_sel,
output reg [7:0] tub_ctrl
    );
    
    reg [3:0] digit1, digit2;
    
    
    
  
    assign tub_sel = 1'b1;
    always @(*) begin
        case(digit1)
        4'b0000: tub_ctrl = 8'b11111100;
        4'b0001: tub_ctrl = 8'b01100000;
        4'b0010: tub_ctrl = 8'b11011010;
        4'b0011: tub_ctrl = 8'b11110010;
        4'b0100: tub_ctrl = 8'b01100110;
        4'b0101: tub_ctrl = 8'b10110110;
        4'b0110: tub_ctrl = 8'b10111110;
        4'b0111: tub_ctrl = 8'b11100000;
        4'b1000: tub_ctrl = 8'b11111110;
        4'b1001: tub_ctrl = 8'b11100110;
        default:
        tub_ctrl = 8'b00000000;
    endcase
    end
            
endmodule
