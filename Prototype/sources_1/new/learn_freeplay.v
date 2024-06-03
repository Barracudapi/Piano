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


module learn_freeplay(
    input clk, reset,
    input [2:0]button,
    input [7:0]sw,
    output reg [10:0] frequency
    );
    `include "ppppparameters.v"
    reg [2:0]range;
    
    //when button is pressed, change the range
    always @(posedge clk) begin
        case(button)
            high: range <= high;
            middle: range <= middle;
            low: range <= low;
        endcase
    end
    
    //when sw is turned on/off
    //calculate the frequency
    always @(posedge clk) begin
        case(sw) 
            8'b0100_0000: 
                case(range)
                    high: frequency <= high7;
                    middle: frequency <= middle7;
                    low: frequency <= low7;
                    endcase
           8'b0010_0000: 
                case(range)
                    high: frequency <= high6;
                    middle: frequency <= middle6;
                    low: frequency <= low6;
                    endcase
           8'b1010_0000: 
                case(range)
                    high: frequency <= high6s;
                    middle: frequency <= middle6s;
                    low: frequency <= low6s;                                       
                    endcase
           8'b0001_0000: 
                case(range)
                    high: frequency <= high5;
                    middle: frequency <= middle5;
                    low: frequency <= low5;
                    endcase
           8'b1001_0000: 
                case(range)
                    high: frequency <= high5s;
                    middle: frequency <= middle5s;
                    low: frequency <= low5s;
                    endcase
            8'b0000_1000: 
                case(range)
                    high: frequency <= high4;
                    middle: frequency <= middle4;
                    low: frequency <= low4;
                    endcase
           8'b1000_1000: 
                case(range)
                    high: frequency <= high4;
                    middle: frequency <= middle4;
                    low: frequency <= low4;
                    endcase    
          8'b0000_0100:       
                case(range)
                    high: frequency <= high3;
                    middle: frequency <= middle3;
                    low: frequency <= low3;
                    endcase
            8'b0000_0010: 
                case(range)
                    high: frequency <= high2;
                    middle: frequency <= middle2;
                    low: frequency <= low2;
                    endcase
           8'b1000_0010: 
                case(range)
                    high: frequency <= high2s;
                    middle: frequency <= middle2s;
                    low: frequency <= low2s;   
                    endcase   
             8'b0000_0001: 
                case(range)
                    high: frequency <= high1;
                    middle: frequency <= middle1;
                    low: frequency <= low1;
                    endcase
           8'b1000_0001: 
                case(range)
                    high: frequency <= high1s;
                    middle: frequency <= middle1s;
                    low: frequency <= low1s; 
                    endcase       
           default: frequency <= silence;
           endcase
    
    end
    
endmodule
