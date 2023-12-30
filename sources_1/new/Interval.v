`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/22 23:01:31
// Design Name: 
// Module Name: Interval
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


module Interval(
input [2:0] countdown,
input correct_note,
input clk, reset,
input [2:0] interval,
output reg [3:0] interval_led
    );
    
    always @(posedge clk) begin
            case(countdown)
                1: interval_led <= 4'b1000;
                2: interval_led <= 4'b1100;
                3: interval_led <= 4'b1110;
                4: begin interval_led <= 4'b1111;end
                default:
                interval_led <= 4'b0000;
                endcase
        end
endmodule
