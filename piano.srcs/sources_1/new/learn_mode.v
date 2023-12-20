@ -1,185 +1,202 @@
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/17 22:12:50
// Design Name: 
// Module Name: learn_mode
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



module learn_mode(
input clk, reset,
input [7:0] sw,
input wire [2:0] octave_sw,
output sd,
output melody,
output reg [7:0] guide_lights,
output [7:0] seg_en,
output [7:0] seg_out0, seg_out1
    );
    `include "ppppparameters.v"
   wire [1:0] useless_state;
   reg [5:0] cnt = 6'd0;
   reg [5:0] cnt_checker = 6'd0;
   wire [4:0] music;
   assign sd = 1'b1;
   wire [10:0] frequency;
   reg [7:0] prev = 0;
   reg [3:0] digit1 = 0; 
   reg [3:0] digit2 = 0;
   reg [3:0] temp = 0;
   wire [7:0] sw_d;
   wire [2:0] interval;
   reg [1:0] song_choice = 2'b00;
   wire select_song_octave_swd;
   reg [2:0] octave;
    
    //learning mode has similar functions to free play except the led function which we modify in this module.
    free_play play(clk, reset, octave_sw, sw, frequency);
    generate_melody gm(.clk(clk), .frequency(frequency), .melody(melody));
    learn_song1 song1(cnt, music, interval);
//    learn_song2 song2(cnt2, music2, interval2);
    scan_seg sc_seg(interval, cnt, digit1, digit2, reset, clk, seg_en, seg_out0, seg_out1);
    
    
    //sometimes if you dont flip the switch fast enough, it glitches and cnt increments too many times. A switch debouncer for each switch is added to mitigate this issue.
    debounce debounce0(clk ,reset, sw[0], sw_d[0]);
    debounce debounce1(clk ,reset, sw[1], sw_d[1]);
    debounce debounce2(clk ,reset, sw[2], sw_d[2]);
    debounce debounce3(clk ,reset, sw[3], sw_d[3]);
    debounce debounce4(clk ,reset, sw[4], sw_d[4]);
    debounce debounce5(clk ,reset, sw[5], sw_d[5]);
    debounce debounce6(clk ,reset, sw[6], sw_d[6]);
    debounce debounce7(clk ,reset, sw[7], sw_d[7]);
    
    
//    debounce song_choice_octave_sw_debouncer(clk, reset, select_song_octave_sw, select_song_octave_swd);      
//        always@(select_song_octave_swd) begin      
//            if(select_song_octave_swd == 1) begin
//                song_choice <= song_choice +1;
//                case(song_choice)
//                    1: begin
//                            cnt <= cnt1;
//                            music <= music1;
//                            interval <= interval1;
//                        end
//                    2: begin
//                            cnt <= cnt2;
//                            music <= music2;
//                            interval <= interval2;
//                        end
//                    default: song_choice <= 2'b01;
//                endcase
//            end else
//                song_choice <= song_choice;
//            end
    
   
        
    always @(posedge clk) begin
    if(reset) begin
        cnt = 0;
        temp = 0;
        digit1 = 0;
        digit2 = 0;
    end
     guide_lights = 8'b0000_0000;
           case(music)
           5'd1: begin guide_lights[0] = 1'b1; octave <= low; end
           5'd2: begin guide_lights[1] <= 1'b1; octave <= low; end
           5'd3:begin guide_lights[2] <= 1'b1; octave <= low; end
           5'd4:begin guide_lights[3] <= 1'b1; octave <= low; end
           5'd5:begin guide_lights[4] <= 1'b1; octave <= low; end
           5'd6:begin guide_lights[5] <= 1'b1; octave <= low; end
           5'd7:begin guide_lights[6] <= 1'b1; octave <= low; end
           5'd8:begin guide_lights[0] <= 1'b1; octave <= middle; end
           5'd9:begin guide_lights[1] <= 1'b1; octave <= middle; end
           5'd10:begin guide_lights[2] <= 1'b1; octave <= middle; end
           5'd11:begin guide_lights[3] <= 1'b1; octave <= middle; end
           5'd12:begin guide_lights[4] <= 1'b1; octave <= middle; end
           5'd13:begin guide_lights[5] <= 1'b1; octave <= middle; end
           5'd14:begin guide_lights[6] <= 1'b1; octave <= middle; end
           5'd15:begin guide_lights[0] <= 1'b1; octave <= high; end
           5'd16:begin guide_lights[1] <= 1'b1; octave <= high; end
           5'd17:begin guide_lights[2] <= 1'b1; octave <= high; end
           5'd18:begin guide_lights[3] <= 1'b1; octave <= high; end
           5'd19:begin guide_lights[4] <= 1'b1; octave <= high; end
           5'd20:begin guide_lights[5] <= 1'b1; octave <= high; end
           5'd21:begin guide_lights[6] <= 1'b1; octave <= high; end
           default:
           guide_lights = 8'b0000_0000;
           endcase
          
           //led will switch to the next light when the correct note is played with the right frequency
            if(guide_lights[0] == 1'b1) begin
            if(prev == not_playing_note) begin
                if((sw_d[0] == 1'b1 & octave_sw == low & music == 5'd1) | sw_d[0] == 1'b1 & octave_sw == middle & music == 5'd8 | sw_d[0] == 1'b1 & octave_sw == high & music == 5'd15) begin
                    cnt <= cnt + 1;
                    guide_lights[0] <= 1'b0;
                end
                end
            end
            if(guide_lights[1] == 1'b1) begin
            if(prev == not_playing_note) begin
                if((sw_d[1] == 1'b1 & octave_sw == low & music == 5'd2) | (sw_d[1] == 1'b1 & octave_sw == middle & music == 5'd9) | (sw_d[1] == 1'b1 & octave_sw == high & music == 5'd16)) begin
                    cnt <= cnt + 1;
                    guide_lights[1] <= 1'b0;
                    end
                end
                end
            if(guide_lights[2] == 1'b1) begin
            if(prev == not_playing_note) begin
                if((sw_d[2] == 1'b1 & octave_sw == low & music == 5'd3) | (sw_d[2] == 1'b1 & octave_sw == middle & music == 5'd10) | (sw_d[2] == 1'b1 & octave_sw == high & music == 5'd17)) begin
                    cnt <= cnt + 1;
                    guide_lights[2] <= 1'b0;
                    end
                    end
                end
            if(guide_lights[3] == 1'b1) begin
            if(prev == not_playing_note) begin
                if((sw_d[3] == 1'b1 & octave_sw == low & music == 5'd4) | (sw_d[3] == 1'b1 & octave_sw == middle & music == 5'd11) | (sw_d[3] == 1'b1 & octave_sw == high & music == 5'd18)) begin
                    cnt <= cnt + 1;
                    guide_lights[3] <= 1'b0;
                    end
                    end
                end
            if(guide_lights[4] == 1'b1) begin
            if(prev == not_playing_note) begin
                if((sw_d[4] == 1'b1 & octave_sw == low & music == 5'd5) | (sw_d[4] == 1'b1 & octave_sw == middle & music == 5'd12) | (sw_d[4] == 1'b1 & octave_sw == high & music == 5'd19)) begin
                    cnt <= cnt + 1;
                    guide_lights[4] <= 1'b0;
                    end
                    end
                end
            if(guide_lights[5] == 1'b1) begin
            if(prev == not_playing_note) begin
                if((sw_d[5] == 1'b1 & octave_sw == low & music == 5'd6) | (sw_d[5] == 1'b1 & octave_sw == middle & music == 5'd13) | (sw_d[5] == 1'b1 & octave_sw == high & music == 5'd20)) begin
                    cnt <= cnt + 1;
                    guide_lights[5] <= 1'b0;
                    end
                    end
                end
            if(guide_lights[6] == 1'b1) begin
            if(prev == not_playing_note) begin
                if((sw_d[6] == 1'b1 & octave_sw == low & music == 5'd7) | (sw_d[6] == 1'b1 & octave_sw == middle & music == 5'd14) | (sw_d[6] == 1'b1 & octave_sw == high & music == 5'd21)) begin
                    cnt <= cnt + 1;
                    guide_lights[6] <= 1'b0;
                    end
                    end
               end
               
               prev <= sw_d;
               
//                if(sw_d !== guide_lights & sw_d !== not_playing_note & digit1 == temp) begin digit1 <= digit1 +1; end
//                else if(sw_d == guide_lights & octave !== octave_sw & sw_d !== not_playing_note & digit1 == temp & cnt_checker == cnt) begin digit1 <= digit1 + 1; end
//                else digit1 <= digit1;
                if(sw_d == guide_lights & octave == octave_sw & digit1 != temp) begin digit1 <= digit1; end
                else begin digit1 <= digit1 + 1; end
                
                if(sw_d ==not_playing_note) begin temp <= digit1; cnt_checker <= cnt; end
                
                if(digit1 == 4'b1010) begin
                    digit2 <= digit2 +1;
                    digit1 <= 4'b0000;
               end
            end
endmodule
