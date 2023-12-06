`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 22:11:33
// Design Name: 
// Module Name: Display_Decoder_Auto
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


module Display_Decoder_Auto(
    input [1:0] counter,
    output [7:0] seg_en, 
    output reg [7:0] tub_control [7:0]
    );
    
    wire [7:0] charDisplay [6:0];
    
    parameter S= 8'b10110110, O = 8'b11111100, N = 8'b11101100, G = 8'b11110110, one = 8'b01100000, two = 8'b11011010, three = 8'b11110010, dot = 8'b00000001;
    TOOB tob0(S,1, charDisplay[0]);
    TOOB tob1(0, 1, charDisplay[1]);
    TOOB tob2(N, 1, charDisplay[2]);
    TOOB tob3(G, 1, charDisplay[3]);
    TOOB tob4(one,1, charDisplay[4]);
    TOOB tob5(two,1, charDisplay[5]);
    TOOB tob6(three,1, charDisplay[6]);
    TOOB tob7(dot, 1, charDisplay[7]);
    
    always @* begin
        case(counter)
            2'b01: begin
                tub_control[0] = charDisplay[0];
                tub_control[1] = charDisplay[1];
                tub_control[2] = charDisplay[2];
                tub_control[3] = charDisplay[3];
                tub_control[4] = charDisplay[4];
            end
            2'b10: begin
                tub_control[0] = charDisplay[0];
                tub_control[1] = charDisplay[1];
                tub_control[2] = charDisplay[2];
                tub_control[3] = charDisplay[3];
                tub_control[4] = charDisplay[5];
            end
            2'b11: begin
                tub_control[0] = charDisplay[0];
                tub_control[1] = charDisplay[1];
                tub_control[2] = charDisplay[2];
                tub_control[3] = charDisplay[3];
                tub_control[4] = charDisplay[6];
            end
            default:
            begin
                tub_control[0] = charDisplay[2];
                tub_control[1] = charDisplay[1];
                tub_control[2] = charDisplay[0];
                tub_control[3] = charDisplay[1];
                tub_control[4] = charDisplay[2];
                tub_control[5] = charDisplay[3];
                tub_control[6] = charDisplay[2];
                tub_control[7] = charDisplay[1];
            end
            endcase
            end
            
endmodule
