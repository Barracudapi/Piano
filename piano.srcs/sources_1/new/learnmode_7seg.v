`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/24 14:18:14
// Design Name: 
// Module Name: learnmode_7seg
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


module learnmode_7seg(
input clk, reset, [1:0] state,  [2:0] octave, [2:0] interval, [1:0] score, [3:0] digit1, [3:0] digit2, [1:0] user,
input [3:0] user_rating1, user_rating2, rating1, rating2,
output reg [7:0] data7, data6, data5, data4, data3, data2, data1, data0
    );
    `include "ppppparameters.v"
    
    always @(posedge clk) begin
        if(state == learn) begin
            case(octave)
                low: data7 <= ll;
                middle: data7 <= mm;
                high: data7 <= hh;
            default: data7 <= ll;
            endcase
            
            case(interval)
                1: data6 <= a1;
                2: data6 <= a2;
                3: data6 <= a3;
                4: data6 <= a4;
                default: data6 <= null;
                endcase
                
                
                data5<= null;
                data4<=null;
                data3<=null;
                data2<=null;
                
                case(digit2)
                    0: data1 <= a0;
                    1: data1 <= a1;
                    2:data1 <= a2;
                    3:data1 <= a3;
                    4:data1 <= a4;
                    5:data1 <= a5;
                    6:data1 <= a6;
                    7:data1 <= a7;
                    8:data1 <= a8;
                    9:data1 <= a9;
                    default: data1 <= a0;
                endcase
                
                case(digit1)
                    0: data0 <= a0;
                    1: data0 <= a1;
                    2:data0 <= a2;
                    3:data0 <= a3;
                    4:data0 <= a4;
                    5:data0 <= a5;
                    6:data0 <= a6;
                    7:data0 <= a7;
                    8:data0 <= a8;
                    9:data0 <= a9;
                    default: data0 <= aa;
                endcase
            end
                else if(state == finish) begin
                case(score)
                    0: begin
                    data7 <= ff;
                    data6 <= aa;
                    data5 <= ii;
                    data4 <= ll;
                    end
                    1: begin
                    data7 <= oo;
                    data6 <= kk;
                    data5 <= aa;
                    data4 <= yy;
                    end
                    2: begin
                    data7 <= gg;
                    data6 <= oo;
                    data5 <= oo;
                    data4 <= dd;
                    end
                    3: begin
                    data7 <= pp;
                    data6 <= ee;
                    data5 <= rr;
                    data4 <= ff;
                    data3 <= ee;
//                    data2 <= cc;
//                    data1 <= tt;
                    end
                    default: data7<= null;
                endcase
                
//                if(score !== 3) begin
                case(rating2)
                    0: data1 <= a0;
                    1: data1 <= a1;
                    2:data1 <= a2;
                    3:data1 <= a3;
                    4:data1 <= a4;
                    5:data1 <= a5;
                    6:data1 <= a6;
                    7:data1 <= a7;
                    8:data1 <= a8;
                    9:data1 <= a9;
                    default: data1 <= a0;
                    endcase
//                    end
                    
                    case(rating1)
                    0: data0 <= a0;
                    1: data0 <= a1;
                    2:data0 <= a2;
                    3:data0 <= a3;
                    4:data0 <= a4;
                    5:data0 <= a5;
                    6:data0 <= a6;
                    7:data0 <= a7;
                    8:data0 <= a8;
                    9:data0 <= a9;
                    default: data0 <= aa;
                    endcase
                end
                
                else if(state == evaluate) begin
                    data7 <= uu;
                    data6 <= ss;
                    data5 <= ee;
                    data4 <= rr;
                    case(user)
                    0: data3 <= a1;
                    1: data3 <= a2;
                    2: data3 <= a3;
                    3: data3 <= a4;
                    default: data3<= null;
                    endcase
                    
                    data2 <= null;
                    
                     case(user_rating2)
                           0: data1 <= a0;
                           1: data1 <= a1;
                           2:data1 <= a2;
                           3:data1 <= a3;
                           4:data1 <= a4;
                           5:data1 <= a5;
                           6:data1 <= a6;
                           7:data1 <= a7;
                           8:data1 <= a8;
                           9:data1 <= a9;
                           default: data1 <= aa;
                           endcase 
                           
                   case(user_rating1)
                           0: data0 <= a0;
                           1: data0 <= a1;
                           2:data0 <= a2;
                           3:data0 <= a3;
                           4:data0 <= a4;
                           5:data0 <= a5;
                           6:data0 <= a6;
                           7:data0 <= a7;
                           8:data0 <= a8;
                           9:data0 <= a9;
                           default: data0 <= aa;
                           endcase
                end
            end
endmodule


                  
