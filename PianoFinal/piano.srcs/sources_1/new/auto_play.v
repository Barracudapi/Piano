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

//changed
module auto_play(
input en,
input wire clk,rst,
input selectsongbtn, pausebtn,
input stopbtn, playbtn,
output wire melody,
output [7:0]seg_en,
output [7:0]seg_outl, //left
output [7:0]seg_outr, //right
output [7:0] led,//the led to indicate note
output [7:0] range //led to indicate range
    ); 
    `include "ppppparameters.v"
    //three states:stop, play, pause
    //stop: play, selectsongs
    //play: stop, pause
    //pause: pause, play, stop
    
    
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
    wire pause, play1, stop; //these are the btn after debouncing
    wire select;
    reg [1:0] music_flag;
    
    wire [7:0]data7, data6, data5, data4, data3, data2, data1, data0;
    
    
//    autoplay1_test_cnt m1(cnt, led2);
//    autoplay1_test_states_songs m2(clk, state, counter, led_state, select_song);
//    autoplay1_test_note m3(music, led); 
//    autoplay1_test_note m4(music1, led3); 
//    scan_led_hex_disp m5(clk, reset,4'b0, 4'b0,
//    {0,0,cnt[5], cnt[4]}, {cnt[3], cnt[2], cnt[1], cnt[0]}, 4'b0, an, seeg);   
    
    
    
    
    clock1 cl1(clk, rst, clk1);
    song1 s1(clk1, rst,state, cnt, music1);
    song2 s2(clk1, rst, music2);
    song3 s3(clk1, rst, music3);
    
    debounce2 d1(clk, rst, stopbtn, stop);
    debounce2 d2(clk, rst, playbtn, play1);
    debounce2 d3(clk, rst, pausebtn, pause);
    debounce2 d4(clk, rst, selectsongbtn, select);
    
    autoplay_led ledd(clk, rst, music, led, range);
    auto_tubs getdata(clk, rst, state, counter, music, 
        data7, data6, data5, data4, data3, data2, data1, data0);
    tubes_display td(clk, ~rst, data7, data6, data5, data4, data3, data2, data1, data0,
        seg_en, seg_outl, seg_outr);
    
    //this is the state transmition among pause and play1 and stop
    always@(posedge clk, negedge rst) begin
        if(~rst) begin
            state <= sstop;
        end else if(en) begin
            case(state)
                sstop:
                    if(play1 == 1)
                        state <= splay;
                splay:
                    if(stop == 1)
                        state <= sstop;
                    else if(pause == 1)
                        state <= spause;
                spause:
                    if(stop == 1)
                        state <= sstop;
                    else if(play1 == 1)
                        state <= splay;
                    else if(pause == 1)
                        state <= splay;
            endcase
        end
    end

    
    
    always@(posedge clk, negedge rst) begin
        if(~rst) begin
            counter = 0;
        end else if(en) begin
            if(state == sstop && select == 1) begin
            case(counter)
                0: counter = 2'b01;
                1: counter = 2'b10;
                2: counter = 2'b00;
            endcase
        end else
            counter <= counter;
        end
    end
     
//     if default music = music11 
//     then it means count = 0, music is music1,
//      but count = 1, it's still music 1, a bit weird, 
//     i think we need to chage it
     
     always @(posedge clk or negedge rst) begin
          if(~rst) begin
              music <= 5'b0;
          end else if(en) begin
            if(state == splay) begin
              case(counter)
                 0: begin music <= music2; music_flag <= 2'b00; end
                 1: begin music <= music1; music_flag <= 2'b01; end
                 2: begin music <= music3; music_flag <= 2'b10; end
                 default: begin music <= music2; music_flag <= 2'b00;end
                endcase
            end
            else
                music <= 5'b0;
            end
      end
      
      
     music_to_frequency mf(clk, music, frequency);
     generate_melody gm(clk, frequency, melody);
     
endmodule
