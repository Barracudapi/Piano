`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/23 15:23:20
// Design Name: 
// Module Name: auto_play
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


module auto_play(
input wire clk,
input wire rst,
input wire [1:0] state,
input wire [3:0] select_songs,
output wire frequency
    );
    parameter  IDLE = 2'b00,
                PLAY= 2'b01,
                RESET= 2'b11;
    parameter  song1 = 3'b001,
                song2= 3'b010,
                song3= 3'b100;        
    
    reg [4:0] music;
    
//   generate
//      if (select_songs == song1) begin
//        song1 s1(clk, rst, music);
//      end else if (select_songs == song2) begin
//        song2 s2(clk, rst, music);
//      end else if (select_songs == song3) begin
//        song3 s3(clk, rst, music);
//      end
//  endgenerate


//i dont know how to instantiate them 
    
    always @(*) begin
        case(state) 
            PLAY: begin
            
            end
            RESET:begin
            
            end
            IDLE:begin
            
            end
            endcase
        end
        
      
          
        
endmodule
