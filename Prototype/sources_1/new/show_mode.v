`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/24 19:42:00
// Design Name: 
// Module Name: show_mode
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


module show_mode(
    input en,
    input clk, rst,
    input [2:0]state,
    output [7:0]seg_en,
    output [7:0]seg_outl, //left
    output [7:0]seg_outr //right
    );
    `include "ppppparameters.v"
    
    reg [7:0] data7, data6, data5, data4, data3, data2, data1, data0;
    
    //displays the top module's various modes
    always@(posedge clk) begin
        if(en) begin
        case(state)
            menu:begin
                data7 <= null; 
                data6 <= null;
                data5 <= pp;
                data4 <= ii;
                data3 <= aa;
                data2 <= nn;
                data1 <= oo;
                data0 <= null;
            end
            auto:begin
                data7 <= aa; 
                data6 <= uu;
                data5 <= tt;
                data4 <= oo;
                data3 <= pp;
                data2 <= ll;
                data1 <= aa;
                data0 <= yy;
            end
            learning: begin
                data7 <= null; 
                data6 <= null;
                data5 <= ll;
                data4 <= ee;
                data3 <= aa;
                data2 <= rr;
                data1 <= nn;
                data0 <= null;
            end
            free: begin
                data7 <= ff; 
                data6 <= rr;
                data5 <= ee;
                data4 <= ee;
                data3 <= pp;
                data2 <= ll;
                data1 <= aa;
                data0 <= yy;
            end
            rcd: begin
                data7 <= null; 
                data6 <= rr;
                data5 <= ee;
                data4 <= cc;
                data3 <= oo;
                data2 <= rr;
                data1 <= dd;
                data0 <= null;
            end
            default:begin
                data7 <= null; 
                data6 <= null;
                data5 <= null;
                data4 <= null;
                data3 <= null;
                data2 <= null;
                data1 <= null;
                data0 <= null;
            end
        endcase
        end
    end
    
    tubes_display td(clk, ~rst, data7, data6, data5, data4, data3, data2, data1, data0,
            seg_en, seg_outl, seg_outr);
endmodule
