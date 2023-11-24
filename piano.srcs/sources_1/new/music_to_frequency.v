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
    
    parameter low1 = 262, middle1 = 523, high1 = 1046,
              low2 = 294, middle2 = 587, high2 = 1175,
              low3 = 330, middle3 = 659, high3 = 1318,
              low4 = 349, middle4 = 699, high4 = 1398,
              low5 = 370, middle5 = 784, high5 = 1569,
              low6 = 440, middle6 = 880, high6 = 1762,
              low7 = 494, middle7 = 988, high7 = 1977,
              low1s = 277, middle1s = 277, high1s = 277,
              low2s = 311, middle2s = 311, high2s = 311,
              low4s = 370, middle4s = 370, high4s = 370,
              low5s = 415, middle5s = 415, high5s = 415,
              low6s = 466, middle6s = 466, high6s = 466,
              silence = 1;
    
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
