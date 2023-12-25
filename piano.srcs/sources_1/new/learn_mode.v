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
input learn_btn, evaluate_btn, userbtn, updatebtn,
output sd,
output melody,
output reg [7:0] guide_lights,
output [7:0] seg_en,
output [7:0] seg_out0, seg_out1,
output reg [3:0] interval_led,
output reg [2:0] state_led
    );
    `include "ppppparameters.v"
   reg [1:0] state; //learn mode states
   reg [5:0] cnt = 6'd0; //music count
   reg [4:0] music;
   wire [4:0] music1, music2;
   assign sd = 1'b1;
   wire [10:0] frequency;
   reg [7:0] prev = 0; //previous combination of switches
   reg [3:0] digit1 = 0, digit2 = 0; //digit1 is the mistake in the ones position, digit2 is mistakes in the tens position
   reg [3:0] temp = 0;
   wire [7:0] sw_d, sw_d2; //sw_d is debounced key, sw_d2 is to debounce it so that it only returns one period of the clock cycle
   reg [2:0] interval; //length of each note to play
   wire [2:0] interval1;
   wire [2:0] interval2;
   reg [2:0] octave; //pitch of the note
   wire clk_1sec; //a one second clock to time the interval
   reg [2:0] countdown; //countdown the interval to 0
   reg [7:0] guide_lights_holder;//holds previous combination of guide_lights
   wire learn_button, evaluate_button, userbtnd, updatebtnd;
   reg counter_for_sss;
   reg [1:0] sss_shift;
   wire select; //select songs
   wire [7:0] data7, data6, data5, data4, data3, data2, data1, data0; //seven segment tube display
   reg [1:0] score; //will display "fail", "okay", "good" and "perfect"
   reg [5:0] mistakes;//increments everytime a wrong key is played
   reg [3:0] rating1, rating2;//rating1 is the rating in the ones position, rating2 is rating in the tens position
   wire [3:0] user_rating1, user_rating2;
   wire [1:0] user;
   
   
    //learning mode has similar functions to free play except the led function which we modify in this module.
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    free_play play(clk, reset, octave_sw, sw, frequency);
    generate_melody gm(.clk(clk), .frequency(frequency), .melody(melody));
    learn_song1 song1(cnt, music1, interval1);
    learn_song2 song2(cnt, music2, interval2);  
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tubes_display tb(clk, ~reset, data7, data6, data5, data4, data3, data2, data1, data0, seg_en, seg_out1, seg_out0);
    learnmode_7seg l7(clk, reset, state, octave, interval, score, digit1, digit2, user, user_rating1, user_rating2, rating1, rating2, data7, data6, data5, data4, data3, data2, data1, data0);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    clock2 c2(clk, reset, clk_1sec);
    account acc(clk, reset, state, rating1, rating2, userbtnd, updatebtnd, user, user_rating1, user_rating2);
    
    
    //sometimes if you dont flip the switch fast enough, it glitches and cnt increments too many times. A switch debouncer for each switch is added to mitigate this issue.
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        debounce debounce0(clk ,reset, sw[0], sw_d[0]);
        debounce debounce1(clk ,reset, sw[1], sw_d[1]);
        debounce debounce2(clk ,reset, sw[2], sw_d[2]);
        debounce debounce3(clk ,reset, sw[3], sw_d[3]);
        debounce debounce4(clk ,reset, sw[4], sw_d[4]);
        debounce debounce5(clk ,reset, sw[5], sw_d[5]);
        debounce debounce6(clk ,reset, sw[6], sw_d[6]);
        debounce debounce7(clk ,reset, sw[7], sw_d[7]);
        debounce learnbutton(clk, reset, learn_btn, learn_button);
        debounce evalbutton(clk, reset, evaluate_btn, evaluate_button);
        debounce2 debounce20(clk ,reset, sw[0], sw_d2[0]);
        debounce2 debounce21(clk ,reset, sw[1], sw_d2[1]);
        debounce2 debounce22(clk ,reset, sw[2], sw_d2[2]);
        debounce2 debounce23(clk ,reset, sw[3], sw_d2[3]);
        debounce2 debounce24(clk ,reset, sw[4], sw_d2[4]);
        debounce2 debounce25(clk ,reset, sw[5], sw_d2[5]);
        debounce2 debounce26(clk ,reset, sw[6], sw_d2[6]);
        debounce2 debounce27(clk ,reset, sw[7], sw_d2[7]);
        debounce2 ssdebounce(clk, reset, select_song_btn, select);
        debounce2 user_btn(clk, reset, userbtn, userbtnd);
        debounce2 update_btn(clk,reset,updatebtn, updatebtnd);
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    always @(posedge clk, negedge reset) begin
            if(~reset)
                sss_shift <= 2'b00;
            else
                sss_shift <= {sss_shift[0], counter_for_sss};
        end
    

    //state machine for learn mode
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    always@(posedge clk, negedge reset) begin
            if(~reset) begin
                state <= learn;
            end else begin
                case(state)
                    learn: begin
                        state_led <= 3'b001;
                        if(cnt >= 5)
                            state <= finish;
                            
                        if(evaluate_button == 1)
                                state<= evaluate;
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
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
      //we move to the next note on these conditions: (1) the switch and octave is flipped corresponding to the correct music and (2) if the previous combination of switches are all down 
     /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
     always @(posedge clk, negedge reset) begin
       if(~reset) begin
           cnt <= 0;
           temp <= 0;
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
            end
            end
            end
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            
            //Function to count mistake. When the key pattern is different from the guide_light pattern or if they are the same but different octave, we +1 mistake. Rating also drops.
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            always @(posedge clk) begin
                if(~reset) begin digit1 <= 0; digit2 <= 0; guide_lights_holder <= guide_lights; end
                else begin
                if(sw_d2 == 8'b00000001| sw_d2 == 8'b00000010 | sw_d2 == 8'b00000100 | sw_d2 == 8'b00001000   | sw_d2 == 8'b00010000 |sw_d2 == 8'b00100000 | sw_d2 == 8'b01000000) begin
                if((sw_d !== guide_lights_holder | (sw_d == guide_lights_holder & octave !== octave_sw)) & sw_d !== not_playing_note) begin
                if(guide_lights_holder == guide_lights) begin
                    if(digit1 == 4'd9) begin
                        digit1 <= 4'd0;
                        digit2 <= digit2 + 1;
                        end
                    else begin 
                    digit1 <= digit1 + 1;  
//                    if(rating1 == 0) begin rating1 <= 4'd9; rating2<= rating2 - 1; end
//                    else rating1 <= rating1 - 1;
                    end
                    guide_lights_holder <= 8'b0000_0000;
                    end
                end
                end
                if(sw_d == not_playing_note)begin guide_lights_holder <= guide_lights; end
            end
            end
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            
            //Function to change songs. Everytime we press the select button, counter_for_sss simply gets the other value. We then give music the value depending on the state.
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////         
            
            //Function to visually show the user how long to play the note. Each clock period is roughly 0.67seconds. We only count down when a key is playing.
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////        
            always @(posedge clk_1sec) begin
                if(sw_d == not_playing_note) begin
                    countdown<=interval;
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
                        if(countdown == 0) begin countdown<=interval; end
                        end
                    end
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    
            //Function to combine digit1 and digit2 to mistakes. We then assign a score depending on your range of mistakes.
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////        
            always @(posedge clk) begin
                mistakes <= 10 * digit2 + digit1;
                if(14 - digit1 < 10) begin rating1 <= 14 - digit1; end
                else rating1 <= 4 - digit1;
                if(digit1 > 4) begin
                    rating2 <= 6 - digit2 + 1;
                    end
                else rating2 <= 6- digit2;
                
                if(mistakes == 6'd0) begin score <= 3; end
                else if(mistakes == 5'd1 | mistakes == 5'd2 | mistakes == 5'd3 | mistakes == 5'd4 | mistakes == 5'd5) begin score <= 2; end
                else if(mistakes == 5'd6  | mistakes == 5'd7 | mistakes == 5'd8 | mistakes == 5'd9) begin score <= 1; end
                else begin score <= 0; end
                end
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
                
                
            
endmodule