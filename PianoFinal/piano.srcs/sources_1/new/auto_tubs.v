`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/23 15:53:13
// Design Name: 
// Module Name: auto_tubs
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


module auto_tubs(
    input clk, rst,
    input [1:0] states,
    input [1:0]counter, //selectsong
    input [4:0]music, //note
    output reg [7:0] data7, data6, data5, data4, data3, data2, data1, data0
    //data7 is the most left one, while data0 is the most right one
    );
    `include "ppppparameters.v"
    
    always @(posedge clk, negedge rst) begin
        if(~rst)begin
            data7<=a8;data6<=a8;data5<=a8;data4<=a8;
            data3<=a3;data2<=a3;data1<=a3;data0<=a3;
        end else if(states == spause) begin
            data7 <= null; data6 <= null;
            data5 <= pp;
            data4 <= aa;
            data3 <= uu;
            data2 <= ss;
            data1 <= ee;
            data0 <= null;
        end else if(states == splay) begin
            data7<=null;data6<=null;data5<=null;data4<=null;
            data3<=null;data2<=null;
            if(music == 0) begin
                data1 <= null;
            end else if(music >= 1 && music <= 7)begin
                data1 <= ll;
            end else if(music >= 8 && music <= 14) begin
                data1 <= mm;
            end else if(music >= 15 && music <= 21) begin
                data1 <= hh;
            end else begin
                data1 <= a8;
            end
            
            if(music == 0) begin
                data0 <= a0;
            end else if( music%7 == 1) begin
                data0 <= a1;
            end else if( music%7 == 2) begin
                data0 <= a2;
            end else if( music%7 == 3) begin
                data0 <= a3;
            end else if( music%7 == 4) begin
                data0 <= a4;
            end else if( music%7 == 5) begin
                data0 <= a5;
            end else if( music%7 == 6) begin
                data0 <= a6;
            end else if( music%7 == 0) begin
                data0 <= a7;
            end else 
                data0 <= a8;
        end else if(states == sstop) begin
            if(counter == 0) begin
                data7 <= null; data6 <= null;
                data5 <= ss;
                data4 <= oo;
                data3 <= nn;
                data2 <= gg;
                data1 <= a1;
                data0 <= null;
            end else if(counter == 1) begin
                data7 <= null; data6 <= null;
                data5 <= ss;
                data4 <= oo;
                data3 <= nn;
                data2 <= gg;
                data1 <= a2;
                data0 <= null;
            end else if(counter == 2) begin
                data7 <= null; data6 <= null;
                data5 <= ss;
                data4 <= oo;
                data3 <= nn;
                data2 <= gg;
                data1 <= a3;
                data0 <= null;
            end else begin
                data7<=a8;data6<=a8;data5<=a8;data4<=a8;
                data3<=a8;data2<=a8;data1<=a8;data0<=a8;
            end
        end
    end
endmodule
