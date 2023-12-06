`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/24 15:12:09
// Design Name: 
// Module Name: music_to_frequency
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


module music_to_frequency(
    input clk,
    input [4:0] music,
    output reg [11:0]frequency
    );
    
    `include "ppppparameters.v";
    
    
    always @* begin
        case(music)
        5'd0 : frequency = silence;
        
        5'd1 : frequency = low1;
        5'd2 : frequency = low2;
        5'd3 : frequency = low3;
        5'd4 : frequency = low4;
        5'd5 : frequency = low5;
        5'd6 : frequency = low6;
        5'd7 : frequency = low7;

        5'd8 : frequency = middle1;
        5'd9 : frequency = middle2;
        5'd10 : frequency = middle3;
        5'd11 : frequency = middle4;
        5'd12 : frequency = middle5;
        5'd13 : frequency = middle6;
        5'd14 : frequency = middle7;

        5'd15 : frequency = high1;
        5'd16 : frequency = high2;
        5'd17 : frequency = high3;
        5'd18 : frequency = high4;
        5'd19 : frequency = high5;
        5'd20 : frequency = high6;
        5'd21 : frequency = high7;
        default: frequency = silence;
        endcase              
     end 
     
     
     
endmodule
