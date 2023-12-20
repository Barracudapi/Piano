`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/18 14:25:14
// Design Name: 
// Module Name: light_7seg_ego1
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


module light_7seg_ego1(
input [3:0] sw, output reg[7:0] seg_out, output [7:0] seg_en
    );
    assign seg_en = 8'hff;
    always @(*)
        case(sw)
            4'h0: seg_out = 8'b1111_1100;
            4'h1: seg_out = 8'b0110_0000;
            4'h2: seg_out = 8'b1101_1010;
            4'h3: seg_out = 8'b1111_0010;
            4'h4: seg_out = 8'b0110_0110;
            4'h5: seg_out = 8'b1011_0110;
            4'h6: seg_out = 8'b1011_1110;
            4'h7: seg_out = 8'b1110_0000;
            4'h8: seg_out = 8'b1111_1110;
            4'h9: seg_out = 8'b1110_0110;
            4'ha: seg_out = 8'b1110_1110;
            4'hb: seg_out = 8'b0011_1110;
            4'hc: seg_out = 8'b0111_1010;
            4'hd: seg_out = 8'b1001_1110;
            4'he: seg_out = 8'b1000_1110;
            default:
            seg_out = 8'b0000_0001;
            endcase
endmodule
