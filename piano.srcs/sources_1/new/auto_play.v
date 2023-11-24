`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/23 15:23:20
// Design Name: 
// Module Name: auto_play
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


module auto_play(
input wire clk,
input wire [1:0] state,
output wire frequency
    );
    parameter  IDLE = 2'b00,
                PLAY= 2'b01,
                RESET= 2'b11;
    
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
    
    always @(posedge clk) begin
        case(state) 
            PLAY: begin
                song <= song + 1;
                
            
            end   
        
endmodule
