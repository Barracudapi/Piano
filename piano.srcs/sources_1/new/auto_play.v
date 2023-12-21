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
output wire melody,
output [2:0] led_state,
output [2:0] select_song,
output led
    ); 
    
    //three states:stop, play, pause
    //stop: play, selectsongs
    //play: stop, pause
    //pause: pause, play, stop
    
    
    autoplay_led_show_notes m1(music, led);
    
    
    assign sd = 1'b1;
    
    wire [5:0]cnt;
    reg [4:0] music;
    wire [4:0] music1;
    wire [4:0]music2;
    wire [4:0]music3;
    wire [10:0] frequency;
    reg [1:0] counter;
    reg [1:0] state; //00 is stop, 01 is play and 10 is pause
    //reg spause, splay, sstop; //these are states;
    wire clk1;
    wire pause, play, stop; //these are the btn after debouncing
    wire select;
    reg [1:0] music_flag;
    
    parameter sstop = 2'b00, splay = 2'b01, spause = 2'b10;
    
    autoplay_led_for_test ledd(clk, state, counter, led_state, select_song);
    
    clock1 cl1(clk, reset, clk1);
    song1 s1(clk1, reset,state, cnt, music1);
    song2 s2(clk1, reset, music2);
    song3 s3(clk1, reset, music3);
    
    debounce2 d1(clk, reset, stopbtn, stop);
    debounce2 d2(clk, reset, playbtn, play);
    debounce2 d3(clk, reset, pausebtn, pause);
    debounce2 d4(clk, reset, selectsongbtn, select);
    
    //this is the state transmition among pause and play and stop
    always@(posedge clk, negedge reset) begin
        if(~reset) begin
            state <= sstop;
        end else begin
            case(state)
                sstop:
                    if(play == 1)
                        state <= splay;
                splay:
                    if(stop == 1)
                        state <= sstop;
                    else if(pause == 1)
                        state <= spause;
                spause:
                    if(stop == 1)
                        state <= sstop;
                    else if(play == 1)
                        state <= splay;
                    else if(pause == 1)
                        state <= splay;
            endcase
        end
    end

    
    
    always@(posedge clk, negedge reset) begin
        if(~reset) begin
            counter = 0;
        end else if(state == sstop && select == 1) begin
            case(counter)
                0: counter = 2'b01;
                1: counter = 2'b10;
                2: counter = 2'b00;
            endcase
        end else
            counter <= counter;
    end
     
     //if default music = music11 
     //then it means count = 0, music is music1,
     // but count = 1, it's still music 1, a bit weird, 
     //i think we need to chage it
     
     always @(posedge clk, negedge reset) begin
          if(~reset) begin
              music <= 5'b0;
          end else if(state == splay) begin
              case(counter)
                 0: begin music = music2; music_flag = 2'b00; end
                 1: begin music = music1; music_flag = 2'b01; end
                 2: begin music = music3; music_flag = 2'b10; end
                 default: begin music <= music2; music_flag = 2'b00;end
                endcase
            end
            else
                music <= 1'b0;
      end
      
      
     
     music_to_frequency mf(clk, music, frequency);
     generate_melody gm(clk, frequency, melody);
     
endmodule
