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
input [1:0] learn_state,
input [3:0] digit1,
input [3:0] digit2,
input [2:0] interval,
input [2:0] octave,
input [5:0] note_cnt,
input [3:0] sw, output reg[7:0] seg_out, output [7:0] seg_en
    );
    `include "ppppparameters.v"
    assign seg_en = 8'hff;
    always @(*)
    if(learn_state == learn) begin
        case(sw)
            4'h0:
            case(digit1) 
                0: seg_out = 8'b1111_1100;
                1: seg_out = 8'b0110_0000;
                2: seg_out = 8'b1101_1010;
                3: seg_out = 8'b1111_0010;
                4: seg_out = 8'b0110_0110;
                5: seg_out = 8'b1011_0110;
                6: seg_out = 8'b1011_1110;
                7: seg_out = 8'b1110_0000;
                8: seg_out = 8'b1111_1110;
                9: seg_out = 8'b1110_0110;
                default:
                seg_out = 8'b0000_0000;
                endcase
            4'h1: 
            case(digit2) 
                0: seg_out = 8'b1111_1100;
                1: seg_out = 8'b0110_0000;
                2: seg_out = 8'b1101_1010;
                3: seg_out = 8'b1111_0010;
                4: seg_out = 8'b0110_0110;
                5: seg_out = 8'b1011_0110;
                6: seg_out = 8'b1011_1110;
                7: seg_out = 8'b1110_0000;
                8: seg_out = 8'b1111_1110;
                9: seg_out = 8'b1110_0110;
                default:
                seg_out = 8'b0000_0000;
                endcase
            4'h2: seg_out = 8'b0000_0000;
            4'h3: seg_out = 8'b0000_0000;
            4'h4: seg_out = 8'b0000_0000;
            4'h5: seg_out = 8'b0000_0000;
            4'h6:
            case(interval)
            1: seg_out = 8'b0110_0000; //1
            2: seg_out = 8'b1101_1010; //2
            3: seg_out = 8'b1111_0010; //3
            4: seg_out = 8'b0110_0110; //4
            default: seg_out = 8'b0000_0000;
            endcase
            4'h7: 
            case(octave)
            low: seg_out = 8'b0001_1100; //L
            middle: seg_out = 8'b1010_1010; //M
            high: seg_out = 8'b0110_1110; //H
            default: seg_out = 8'b0000_0000;
            endcase
            default:
            seg_out = 8'b0000_0001;
            endcase
            end
    else if(learn_state == finish) begin
            case(sw)
            4'h0:
            case(digit1) 
                0: seg_out = 8'b1111_1100;
                1: seg_out = 8'b0110_0000;
                2: seg_out = 8'b1101_1010;
                3: seg_out = 8'b1111_0010;
                4: seg_out = 8'b0110_0110;
                5: seg_out = 8'b1011_0110;
                6: seg_out = 8'b1011_1110;
                7: seg_out = 8'b1110_0000;
                8: seg_out = 8'b1111_1110;
                9: seg_out = 8'b1110_0110;
                default:
                seg_out = 8'b0000_0000;
                endcase
            4'h1: 
            case(digit2) 
                0: seg_out = 8'b1111_1100;
                1: seg_out = 8'b0110_0000;
                2: seg_out = 8'b1101_1010;
                3: seg_out = 8'b1111_0010;
                4: seg_out = 8'b0110_0110;
                5: seg_out = 8'b1011_0110;
                6: seg_out = 8'b1011_1110;
                7: seg_out = 8'b1110_0000;
                8: seg_out = 8'b1111_1110;
                9: seg_out = 8'b1110_0110;
                default:
                seg_out = 8'b0000_0000;
                endcase
            4'h2: seg_out = 8'b0000_0000;
            4'h3: seg_out = 8'b0000_0000;
            4'h4: seg_out = 8'b0000_0000;
            4'h5: seg_out = 8'b0000_0000;
            4'h6:
            case(interval)
            1: seg_out = 8'b0110_0000; //1
            2: seg_out = 8'b1101_1010; //2
            3: seg_out = 8'b1111_0010; //3
            4: seg_out = 8'b0110_0110; //4
            default: seg_out = 8'b0000_0000;
            endcase
            4'h7: 
            case(octave)
            low: seg_out = 8'b0001_1100; //L
            middle: seg_out = 8'b1010_1010; //M
            high: seg_out = 8'b0110_1110; //H
            default: seg_out = 8'b0000_0000;
            endcase
            default:
            seg_out = 8'b0000_0001;
            endcase
            end
endmodule
