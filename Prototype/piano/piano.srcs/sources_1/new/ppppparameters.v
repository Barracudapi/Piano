`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 17:06:01
// Design Name: 
// Module Name: ppppparameters
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


        //the frequency of each note
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

    //the range
    parameter high=3'b100, middle=3'b010, low=3'b001;
    
    //1 / the frequency of clk
    parameter N = 100_000_000;
    
    
