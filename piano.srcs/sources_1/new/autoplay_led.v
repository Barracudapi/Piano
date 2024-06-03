`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/23 15:23:38
// Design Name: 
// Module Name: autoplay_led
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


module autoplay_led(
    input clk, rst,
    input [4:0]music,
    output reg [7:0] led,
    output reg [7:0] range
    );
    
    always@(posedge clk, negedge rst) begin
        if(~rst) begin
            range <= 0;
        end else if(music == 0) begin
            range <= 0;
        end else if(music >= 1 && music <= 7)begin
            range <= 8'b0000_0100;
        end else if(music >= 8 && music <= 14) begin
            range <= 8'b0000_0010;
        end else if(music >= 15 && music <= 21) begin
            range <= 8'b0000_0001;
        end else begin
            range <= 8'b0000_0111;
        end
    end
    
    
    always @(posedge clk, negedge rst) begin
        if(~rst) begin
            led <= 0;
        end else if(music == 0) begin
            led <= 8'b00000_000;
        end else if( music == 1 | music == 8 | music == 15) begin
            led <= 8'b01000_000;
        end else if( music == 2 | music == 9 | music == 16) begin
            led <= 8'b00100_000;
        end else if( music == 3 | music == 10 | music == 17) begin
            led <= 8'b00010_000;
        end else if( music == 4 | music == 11 | music == 18) begin
            led <= 8'b00001_000;
        end else if( music == 5 | music == 12 | music == 19) begin
            led <= 8'b00000_100;
        end else if( music == 6 | music == 13 | music == 20) begin
            led <= 8'b00000_010;
        end else if( music == 7 | music == 14 | music == 21) begin
            led <= 8'b00000_001;
        end else 
            led <= 8'b01111_111;
    end
endmodule
