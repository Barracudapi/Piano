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
    input en,
    input clk, rst,
    input [2:0]button,
    input [7:0]sw,
    output reg [10:0] frequency,
    output reg [1:0]state,
    output reg [2:0]note
    );
    
    //00high 01middle 10low
    reg [2:0]range;
    `include "ppppparameters.v";
    wire hb, mb, lb;
    
    
    debounce2 h(clk, rst,button[2], hb);
    debounce2 m(clk, rst, button[1], mb);
    debounce2 l(clk, rst, button[0], lb);
    

    
    always@(posedge clk, negedge rst) begin
        if(~rst) begin
            state <= mi;
        end else if(en) begin
         if(hb == 1)
            state <= hi;
        else if(mb == 1)
            state <= mi;
        else if(lb == 1)
            state <= lo;
    end
    end
    
    //when button is pressed, change the range
    always @(state) begin
        case(state)
            hi: range = high;
            mi: range = middle;
            lo: range = low;
        endcase
    end
    
    //when sw is turned on/off
    //calculate the frequency
    always @(posedge clk) begin
        if(en) begin
        case(sw) 
            8'b0100_0000: begin
                note <= 8'd7;
                case(range)
                    high: frequency = high7;
                    middle: frequency = middle7;
                    low: frequency = low7;
                    endcase
                end
           8'b0010_0000: begin
                note <= 8'd6;
                case(range)
                    high: frequency = high6;
                    middle: frequency = middle6;
                    low: frequency = low6;                     
                    endcase
                end
           8'b0001_0000: begin
                note <= 8'd5;
                case(range)
                    high: frequency = high5;
                    middle: frequency = middle5;
                    low: frequency = low5;
                    endcase
                end
            8'b0000_1000: begin
                note <= 8'd4;
                case(range)
                    high: frequency = high4;
                    middle: frequency = middle4;
                    low: frequency = low4;
                    endcase
                end
          8'b0000_0100: begin
                note <= 8'd3;      
                case(range)
                    high: frequency = high3;
                    middle: frequency = middle3;
                    low: frequency = low3;
                    endcase
                end
            8'b0000_0010: begin
                note <= 8'd2;
                case(range)
                    high: frequency = high2;
                    middle: frequency = middle2;
                    low: frequency = low2;
                    endcase
                end
             8'b0000_0001: begin
                note <= 8'd1;
                case(range)
                    high: frequency = high1;
                    middle: frequency = middle1;
                    low: frequency = low1;
                    endcase
                end
           default: begin
            frequency = silence;
            note <= 8'd0;
            end
           endcase
        end
    end
    
endmodule
