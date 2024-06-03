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


module recording_tubs(
    input clk, rst,
    input [1:0] states,
    input [4:0]music, //note
    output [7:0]seg_en0,
    output [7:0]seg_outl0, //left
    output [7:0]seg_outr0, //right
    output [7:0]seg_en2,
    output [7:0]seg_outl2, //left
    output [7:0]seg_outr2 //right
    );
    
    `include "ppppparameters.v"
    
    reg [7:0] data7, data6, data5, data4, data3, data2, data1, data0;
    reg [7:0] data8, data9, data10, data11, data12, data13, data14, data15;
    
    always @(posedge clk, negedge rst) begin
        if(~rst)begin
            data7<=null;data6<=null;data5<=null;data4<=null;
            data3<=null;data2<=null;data1<=null;data0<=null;
            data8<= null; data9<=null; data10<= null; data11<=null;
            data12<=null; data13<=null; data14<=null; data15<=null;
        end else if(states == idle) begin
            data7 <= rr; data6 <= cc;
            data5 <= dd;
            data4 <= null;
            data3 <= pp;
            data2 <= ll;
            data1 <= aa;
            data0 <= yy;
            
            
        end else if(states == play) begin
            data14<=pp;data13<=ll;data12<=aa;data11<=yy;
            data10<=null;data9<=null;
            if(music == 0) begin
                data8 <= null;
            end else if(music >= 1 && music <= 7)begin
                data8 <= ll;
            end else if(music >= 8 && music <= 14) begin
                data8 <= mm;
            end else if(music >= 15 && music <= 21) begin
                data8 <= hh;
            end else begin
                data8 <= null;
            end
            
            if(music == 0) begin
                data7 <= a0;
            end else if( music%7 == 1) begin
                data7 <= a1;
            end else if( music%7 == 2) begin
                data7 <= a2;
            end else if( music%7 == 3) begin
                data7 <= a3;
            end else if( music%7 == 4) begin
                data7 <= a4;
            end else if( music%7 == 5) begin
                data7 <= a5;
            end else if( music%7 == 6) begin
                data7 <= a6;
            end else if( music%7 == 0) begin
                data7 <= a7;
            end else 
                data7 <= null;
        end 
    end
    
    tubes_display td(clk, ~rst, data7, data6, data5, data4, data3, data2, data1, data0,
            seg_en0, seg_outl0, seg_outr0);
    tubes_display td2(clk, ~rst, data14, data13, data12, data11, data10, data9, data8, data7,
                        seg_en2, seg_outl2, seg_outr2);
    
    
    
endmodule
