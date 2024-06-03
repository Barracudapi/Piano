`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/23 17:17:07
// Design Name: 
// Module Name: led
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


module led(
input en,
input clk, rst,
input  [7:0] sw,
input  [1:0] state,
output reg [7:0] ledsw,
output reg [7:0] ledrange
    );
   
   always@(posedge clk, negedge rst) begin
        if(~rst) begin
            ledrange <= 8'b0;
        end else if(en) begin
            case(state)
                hi:ledrange <= 8'b0000_0100;
                mi:ledrange <= 8'b0000_0010;
                lo:ledrange <= 8'b0000_0001;
                default:ledrange <= 8'b0000_0000;
            endcase
        end
    end
    
    always @(sw) begin
        ledsw = sw;       
   end
   
   
endmodule
