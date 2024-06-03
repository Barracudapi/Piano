`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/25 16:00:46
// Design Name: 
// Module Name: store_music
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


module store_music(
    input clk,
    input [7:0] note,
    input [1:0] octave,
    output reg [4:0] music
    );
        `include "ppppparameters.v"
    always @(posedge clk) begin
        if(note == 8'b0) 
            music <= 5'b0;
        else case(octave) 
            hi:begin
                case(note) 
                    8'b0100_0000:music <= 5'd21;
                    8'b0010_0000:music <= 5'd20;
                    8'b0001_0000:music <= 5'd19;
                    8'b0000_1000:music <= 5'd18;
                    8'b0000_0100:music <= 5'd17;
                    8'b0000_0010:music <= 5'd16;
                    8'b0000_0001:music <= 5'd15;
                endcase
            end
            mi:begin
                case(note) 
                8'b0100_0000:music <= 5'd14;
                8'b0010_0000:music <= 5'd13;
                8'b0001_0000:music <= 5'd12;
                8'b0000_1000:music <= 5'd11;
                8'b0000_0100:music <= 5'd10;
                8'b0000_0010:music <= 5'd9;
                8'b0000_0001:music <= 5'd8;
            endcase
            end
            lo:begin
                case(note) 
                8'b0100_0000:music <= 5'd7;
                8'b0010_0000:music <= 5'd6;
                8'b0001_0000:music <= 5'd5;
                8'b0000_1000:music <= 5'd4;
                8'b0000_0100:music <= 5'd3;
                8'b0000_0010:music <= 5'd2;
                8'b0000_0001:music <= 5'd1;
            endcase
            end
        endcase
    
    end
endmodule
