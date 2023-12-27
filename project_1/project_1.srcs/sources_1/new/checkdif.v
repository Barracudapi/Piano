`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/14 09:10:39
// Design Name: 
// Module Name: check_dif
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


module checkdif(
input clk, rst,
input x,
output reg z
    );
    reg ten, twenty;
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            z <= 1'b0;
            end
        else if(!rst) begin
            if((x == 1'b0 & ten == 1'b0 & twenty == 1'b1) | (x == 1'b1 & ten == 1'b1 & twenty == 1'b0)) begin
                z <= 1'b1;
                end
            else begin
                z <= 1'b0;
                end
                twenty = ten;
                ten = x;
            end
            end
        
endmodule