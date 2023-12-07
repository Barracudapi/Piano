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
input selectsongbtn, pausebtn,
input stopbtn, playbtn,
output sd,
output wire [5:0]cnt,
output wire melody
    ); 
    
    //three states:stop, play, pause
    //stop: play, selectsongs
    //play: stop, pause
    //pause: pause, play, stop
    
    
    
    assign sd = 1'b1;
    
    reg [4:0] music;
    wire [4:0] music1;
    wire [4:0]music2;
    wire [4:0]music3;
    wire [10:0] frequency;
    reg[1:0] counter;
    reg [1:0] state;
    reg pause;
    wire clk1;
    
    
    
    clock1 cl1(clk, clk1);
    song1 s1(clk1, reset,cnt, music1);
    song2 s2(clk1, reset, music2);
    song3 s3(clk1, reset, music3);

    
    always @(posedge clk, posedge reset) begin
        if(reset) begin
            counter <= 0;
            music <= 0;
            pause <= 1'b0;
        end else if(pausebtn) begin
            pause <= ~pause;
        end
        else begin
            pause <= pause;
        end
        end
      
     
     always @(posedge clk or posedge reset) begin
     counter <= 0;
        if(reset)
            counter <= 0;
        else begin
            if(selectsongbtn)
            counter <= counter + 1;
            else
                counter <= counter;
            if(counter == 4)
            counter <= 0;
        end
     end  
     
     always @(counter) begin
          case(counter)
             1: music = music1;
             2: music = music2;
             3: music = music3;
             default: music <= music1;
          endcase
      end
            
     
     music_to_frequency mf(clk, music1, frequency);
     generate_melody gm(clk, frequency, melody);
     
endmodule
