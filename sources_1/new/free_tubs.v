`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/24 22:20:05
// Design Name: 
// Module Name: free_tubs
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


module free_tubs(
    input en,
    input clk, rst,
    input [1:0]state,
    input [2:0] note,
    output [7:0] seg_en,
    output [7:0]seg_outl, //left
    output [7:0]seg_outr //right
    );
    reg [7:0]data7, data6, data5, data4, data3, data2, data1, data0;
    `include "ppppparameters.v"
    
    always@(posedge clk, negedge rst)begin
        if(~rst)begin
            data7<=null;data6<=null;data5<=null;data4<=null;
            data3<=null;data2<=null;data1<=null;data0<=null;
        end else if(en) begin
            data7 <= ff; 
            data6 <= pp;
            data5 <= null;
            data4 <= null;
            data3 <= null;
            data2 <= null;
            if(note != 0)begin
            case(state)
                hi:data1<= hh;
                mi:data1<= mm;
                lo:data1<= ll;
                default: data1 <= a0;
            endcase
            end else data1 <= null;
            case(note)
                1:data0 <=a1;
                2:data0 <=a2;
                3:data0 <=a3;
                4:data0 <=a4;
                5:data0 <=a5;
                6:data0 <=a6;
                7:data0 <=a7;
                default: data0 <= a0;
            endcase
        end
    end
    
    tubes_display td(clk, ~rst, data7, data6, data5, data4, data3, data2, data1, data0,
            seg_en, seg_outl, seg_outr);
endmodule
