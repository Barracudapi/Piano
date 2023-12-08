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
output wire melody
    ); 
    
    //three states:stop, play, pause
    //stop: play, selectsongs
    //play: stop, pause
    //pause: pause, play, stop
    
    
    
    
    
    assign sd = 1'b1;
    
    wire [5:0]cnt;
    reg [4:0] music;
    wire [4:0] music1;
    wire [4:0]music2;
    wire [4:0]music3;
    wire [10:0] frequency;
    reg [1:0] counter;
    reg [1:0] state; //00 is stop, 01 is play and 10 is pause
    reg spause, splay, sstop; //these are states;
    wire clk1;
    wire pause, play, stop; //these are the btn after debouncing
    wire select;
    
    
    
    clock1 cl1(clk, reset, clk1);
    song1 s1(clk1, reset,cnt, music1);
    song2 s2(clk1, reset, music2);
    song3 s3(clk1, reset, music3);
    
    debounce d1(clk, reset, stopbtn, stop);
    debounce d2(clk, reset, playbtn, play);
    debounce d3(clk, reset, pausebtn, pause);
    debounce d4(clk, reset, selectsongbtn, select);
    
    //this is the state transmition among pause and play and stop
    always@(posedge clk, posedge reset) begin
        if(reset) begin
            spause <= 0;
            splay <= 0;
            sstop <= 1;
        end else if(sstop == 1 && play == 1) begin
            splay <= 1;
            sstop <= 0;
        end else if(splay == 1 && stop == 1) begin
            sstop <= 1;
            splay <= 0;
        end else if(splay ==1 && pause == 1) begin
            splay <= 0;
            spause <= 1;
        end else if( spause == 1 && stop == 1) begin
            spause <= 0;
            sstop <= 1;
        end else if( spause == 1 && play == 1) begin
            spause <= 0;
            splay <= 1;
        end else if( spause == 1 && pause == 1) begin
                spause <= 0;
                splay <= 1;
        end
    end

      
     //select songs
    always@(posedge clk, posedge reset) begin
       if(reset) begin
           counter <= 0;
           music <= 5'd0;
       end else if(sstop == 1) begin
           if(select)
               counter <= counter +1;
           else
               counter <= counter;
           if(counter == 3)
               counter <= 0;
       end
    end
     
     //if default music = music11 
     //then it means count = 0, music is music1,
     // but count = 1, it's still music 1, a bit weird, 
     //i think we need to chage it
     
     always @(counter) begin
          if(splay == 1) begin
              case(counter)
                 0: music = music1;
                 1: music = music2;
                 2: music = music3;
                 default: music <= music1;
                endcase
            end
            else
                music <= 1'b0;
      end
      
      
     
     music_to_frequency mf(clk, music, frequency);
     generate_melody gm(clk, frequency, melody);
     
endmodule
