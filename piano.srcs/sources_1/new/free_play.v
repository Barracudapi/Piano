`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/20 14:13:57
// Design Name: 
// Module Name: free_play
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


module free_play(
    input [2:0]button,
    input [7:0]sw,
    output reg [10:0] frequency
    );
    reg [2:0]range;
    
    //these are the frequency of teach pitch
//    parameter low1 = 262, low2 = 294, low3 = 330,
//    low4 = 349, low5 = 370, low6 = 440,  low7 = 494;
//    parameter low1s = 277, low2s = 311, low4s = 370, low5s = 415, low6s = 466;
    
//    parameter middle1 = 523, middle2 = 587, middle3 = 659,middle4 = 699, 
//    middle5 = 784, middle6 = 880,  middle7 = 988;
//    parameter middle1s = 277, middle2s = 311, middle4s = 370, middle5s = 415, middle6s = 466;
    
//    parameter high1 = 1046, high2 = 1175, high3 = 1318,
//    high4 = 1398, high5 = 1569, high6 = 1762,  high7 = 1977;
//    parameter high1s = 277, high2s = 311, high4s = 370, high5s = 415, high6s = 466;
    
//    parameter silence = 1;

        //these are the frequency of each pitch
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
    
    //when button is pressed, change the range
    always @(button) begin
        case(button)
            high: range = high;
            middle: range = middle;
            low: range = low;
        endcase
    end
    
    //when sw is turned on/off
    //calculate the frequency
    always @(sw) begin
        case(sw) 
            8'b0100_0000: 
                case(range)
                    high: frequency = high7;
                    middle: frequency = middle7;
                    low: frequency = low7;
                    endcase
           8'b0010_0000: 
                case(range)
                    high: frequency = high6;
                    middle: frequency = middle6;
                    low: frequency = low6;
                    endcase
           8'b1010_0000: 
                case(range)
                    high: frequency = high6s;
                    middle: frequency = middle6s;
                    low: frequency = low6s;                                       
                    endcase
           8'b0001_0000: 
                case(range)
                    high: frequency = high5;
                    middle: frequency = middle5;
                    low: frequency = low5;
                    endcase
           8'b1001_0000: 
                case(range)
                    high: frequency = high5s;
                    middle: frequency = middle5s;
                    low: frequency = low5s;
                    endcase
            8'b0000_1000: 
                case(range)
                    high: frequency = high4;
                    middle: frequency = middle4;
                    low: frequency = low4;
                    endcase
           8'b1000_1000: 
                case(range)
                    high: frequency = high4;
                    middle: frequency = middle4;
                    low: frequency = low4;
                    endcase    
          8'b0000_0100:       
                case(range)
                    high: frequency = high3;
                    middle: frequency = middle3;
                    low: frequency = low3;
                    endcase
            8'b0000_0010: 
                case(range)
                    high: frequency = high2;
                    middle: frequency = middle2;
                    low: frequency = low2;
                    endcase
           8'b1000_0010: 
                case(range)
                    high: frequency = high2s;
                    middle: frequency = middle2s;
                    low: frequency = low2s;   
                    endcase   
             8'b0000_0001: 
                case(range)
                    high: frequency = high1;
                    middle: frequency = middle1;
                    low: frequency = low1;
                    endcase
           8'b1000_0001: 
                case(range)
                    high: frequency = high1s;
                    middle: frequency = middle1s;
                    low: frequency = low1s; 
                    endcase       
           default: frequency = silence;
           endcase
    
    end
    
endmodule
