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
input select_song_btn,
input learn_btn, evaluate_btn,
output sd,
output melody,
output reg [7:0] guide_lights,
output [7:0] seg_en,
output [7:0] seg_out0, seg_out1,
output reg [3:0] interval_led,
output reg [2:0] state_led
    );
    `include "ppppparameters.v"
   reg [1:0] state;
   reg [5:0] cnt = 6'd0;
   reg [5:0] cnt_checker = 6'd0;
   reg [4:0] music;
   wire [4:0] music1;
   wire [4:0] music2;
   assign sd = 1'b1;
   wire [10:0] frequency;
   reg [7:0] prev = 0;
   reg [3:0] digit1 = 0; 
   reg [3:0] digit2 = 0;
   reg [3:0] temp = 0;
   wire [7:0] sw_d;
   reg [2:0] interval;
   wire [2:0] interval1;
   wire [2:0] interval2;
   reg [1:0] song_choice = 2'b00;
   wire select_song_octave_swd;
   reg [2:0] octave;
   wire clk_1sec;
   reg [2:0] countdown;
   reg correct_note = 0;
   reg [4:0] music_holder;
   reg [7:0] guide_lights_holder;
   wire learn_button, evaluate_button;
   reg counter_for_sss;
   reg [1:0] sss_shift;
   wire select;
   reg [7:0] data7, data6, data5, data4, data3, data2, data1, data0;
    //learning mode has similar functions to free play except the led function which we modify in this module.
    free_play play(clk, reset, octave_sw, sw, frequency);
    generate_melody gm(.clk(clk), .frequency(frequency), .melody(melody));
    learn_song1 song1(cnt, music1, interval1);
    learn_song2 song2(cnt, music2, interval2);
    //scan_seg sc_seg(digit1, digit2, interval, octave, cnt, reset, clk, seg_en, seg_out0, seg_out1);
    tubes_display tb(clk, ~reset, data7, ee, ll, ll, oo, a8, a8, a8, seg_en, seg_out1, seg_out0);
    clock2(clk, reset, clk_1sec);
    
    
    //sometimes if you dont flip the switch fast enough, it glitches and cnt increments too many times. A switch debouncer for each switch is added to mitigate this issue.
    debounce debounce0(clk ,reset, sw[0], sw_d[0]);
    debounce debounce1(clk ,reset, sw[1], sw_d[1]);
    debounce debounce2(clk ,reset, sw[2], sw_d[2]);
    debounce debounce3(clk ,reset, sw[3], sw_d[3]);
    debounce debounce4(clk ,reset, sw[4], sw_d[4]);
    debounce debounce5(clk ,reset, sw[5], sw_d[5]);
    debounce debounce6(clk ,reset, sw[6], sw_d[6]);
    debounce debounce7(clk ,reset, sw[7], sw_d[7]);
    
    
debounce2 ssdebounce(clk, reset, select_song_btn, select);

 always @(posedge clk, negedge reset) begin
        if(~reset)
            sss_shift <= 2'b00;
        else
            sss_shift <= {sss_shift[0], counter_for_sss};
    end
    
    always @(posedge clk) begin
        case(octave)
            low: data7 <= ll;
            middle: data7 <= mm;
            high: data7 <= hh;
        default: data7 <= ll;
        endcase
        end
    //////////////////////////////////////////////////////////////////////
    //state machine for learn mode
    debounce learnbutton(clk, reset, learn_btn, learn_button);
    debounce evalbutton(clk, reset, evaluate_btn, evaluate_button);
    always@(posedge clk, negedge reset) begin
            if(~reset) begin
                state <= learn;
            end else begin
                case(state)
                    learn: begin
                        state_led <= 3'b001;
                        if(cnt >= 5)
                            state <= finish;
                            end
                    finish: begin
                        state_led <= 3'b010;
                        if(learn_button == 1)
                            state <= learn;
                        else if(evaluate_button == 1)
                            state <= evaluate;
                            end
                    evaluate:
                    begin
                        state_led <= 3'b100;
                        if(learn_button == 1)
                            state <= learn;
                            end
                            default: state <= finish;
                endcase
            end
        end
    
   
        
     always @(posedge clk, negedge reset) begin
       if(~reset) begin
           cnt <= 0;
           temp <= 0;
           digit1 <= 0;
           digit2 <= 0;
       end
       else if(state == learn) begin
            if(sss_shift[1] ^ sss_shift[0]) begin
            cnt <= 0;
            guide_lights <= 8'b0000_0000;
        end else begin  
        
      guide_lights <= 8'b0000_0000;
      case(music)
           5'd1: begin guide_lights[0] <= 1'b1; octave <= low; end
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
//                if(sw_d == guide_lights & octave == octave_sw & digit1 != temp) begin digit1 <= digit1; end
//                else begin if(sw_d !== not_playing_note & cnt == cnt_checker) digit1 <= digit1 + 1; end
                
//                if(sw_d ==not_playing_note) begin temp <= digit1; cnt_checker <= cnt; end
                
//                if(digit1 == 4'b1010) begin
//                    digit2 <= digit2 +1;
//                    digit1 <= 4'b0000;
//               end
                    
            end
            end
            end
            
            always @(sw_d) begin
                if(sw_d != guide_lights | (octave != octave_sw & sw_d == not_playing_note)) begin
                     if(digit1 == 4'd9) begin
                         digit1 <= 4'd0;
                         digit2 <= digit2 + 1;
                   end else digit1 <= digit1 + 1;
               end
           end
           
           always@(posedge clk, negedge reset) begin
                       if(~reset) begin
                           counter_for_sss = 0;
                       end else if(select == 1) begin
                           case(counter_for_sss)
                               0: counter_for_sss = 1;
                               1: counter_for_sss = 0;
                           endcase
                       end else
                           counter_for_sss <= counter_for_sss;
                   end
                   
                   always @(posedge clk, negedge reset) begin
                         if(~reset) begin
                             music <= 5'b0;
                         end else begin
                           case(counter_for_sss)
                                0: begin music <= music1; interval <= interval1; end
                                1: begin music <= music2; interval <= interval2; end
                                default: begin music <= music1; interval <= interval1;end
                               endcase
                           end
                     end
                     
             always @(posedge clk) begin
                if(guide_lights_holder == sw_d & octave == low & (music_holder == 5'd1 | music_holder == 5'd2 | music_holder == 5'd3 | music_holder == 5'd4 | music_holder == 5'd5 | music_holder == 5'd6 | music_holder == 5'd7))  correct_note <= 1'b1;
                else if(guide_lights_holder == sw_d & octave == middle & (music_holder == 5'd8 | music_holder == 5'd9 | music_holder == 5'd10 | music_holder == 5'd11 | music_holder == 5'd12 | music_holder == 5'd13 | music_holder == 5'd14))  correct_note <= 1'b1;
                else if(guide_lights_holder == sw_d & octave == high & (music_holder == 5'd15 | music_holder == 5'd16 | music_holder == 5'd17 | music_holder == 5'd18 | music_holder == 5'd19 | music_holder == 5'd20 | music_holder == 5'd21))  correct_note <= 1'b1;
                else correct_note <= 1'b0;
                    end
                    
            always @(posedge clk_1sec) begin
                if(sw_d == not_playing_note) begin
                    countdown<=interval;
                    music_holder <= music;
                    case(countdown)
                    1: interval_led <= 4'b1000;
                    2: interval_led <= 4'b1100;
                    3: interval_led <= 4'b1110;
                    4: begin interval_led <= 4'b1111;end
                    default:
                    interval_led <= 4'b0000;
                    endcase
                    end
                else begin
                    countdown <= countdown - 1;
                    case(countdown)
                        1: interval_led <= 4'b1000;
                        2: interval_led <= 4'b1100;
                        3: interval_led <= 4'b1110;
                        4: begin interval_led <= 4'b1111;end
                        default:
                        interval_led <= 4'b0000;
                        endcase
                        if(countdown == 0) begin music_holder <= music; countdown<=interval; end
                        end
                    end
endmodule
