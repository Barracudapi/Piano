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
input wire reset,
input btn, pausebtn,
output wire melody
    ); 
    
    reg [4:0] music;
    wire [4:0] music1;
    wire [4:0]music2;
    wire [4:0]music3;
    reg [11:0] frequency;
    reg[1:0] counter;
    reg [1:0] state;
    reg pause;
    
    
    song1 s1(clk, reset, music1);
    song2 s2(clk, reset, music2);
    song3 s3(clk, reset, music3);
    
    music_to_frequency mf(clk, music, frequency);
    generate_melody gm(clk, frequency, melody);
    
    
    always @(posedge clk, negedge reset, negedge pausebtn) begin
        if(!reset) begin
            counter <= 0;
            music <= 0;
            frequency <= 0;
            pause <= 1'b0;
        end else if(pausebtn) begin
            pause <= ~pause;
        end
        else begin
            pause <= pause;
        end
        end
       
        
        
     always @(posedge clk or negedge reset) begin
     if(!reset)
        counter <= 0;
     else begin
     if(!btn)
     counter = counter + 1;
     if(counter == 4)
        counter <= 0;
     end
     case(counter)
        0: music = music1;
        1: music = music2;
        2: music = music3;
     endcase
     end         
endmodule
