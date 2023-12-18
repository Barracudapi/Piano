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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/14 21:31:00
// Design Name: 
// Module Name: learning_mode
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
input wire [2:0] button,
output sd,
output melody,
output reg [7:0] guide_lights,
output [7:0] seg_en,
output [7:0] seg_out0, seg_out1
    );
    `include "ppppparameters.v"
   wire [1:0] useless_state;
   reg [5:0] cnt = 6'd0;
   wire [4:0] music;    
   assign sd = 1'b1;
   wire [10:0] frequency;
   reg [7:0] prev = 0;
   reg [3:0] digit1 = 0; 
   reg [3:0] digit2 = 0;
   wire [7:0] sw_d;
    
    //learning mode has similar functions to free play except the led function which we modify in this module.
    free_play play(clk, reset, button, sw, frequency);
    generate_melody gm(.clk(clk), .frequency(frequency), .melody(melody));
    learn_song1 song1(cnt, music);
//    learn_song2 song2(cnt, music);
    scan_seg sc_seg(cnt, digit1, digit2, reset, clk, seg_en, seg_out0, seg_out1);
    
    
    //sometimes if you dont flip the switch fast enough, it glitches and cnt increments too many times. A switch debouncer is added to mitigate this issue.
    debounce debounce0(clk ,reset, sw[0], sw_d[0]);
    debounce debounce1(clk ,reset, sw[1], sw_d[1]);
    debounce debounce2(clk ,reset, sw[2], sw_d[2]);
    debounce debounce3(clk ,reset, sw[3], sw_d[3]);
    debounce debounce4(clk ,reset, sw[4], sw_d[4]);
    debounce debounce5(clk ,reset, sw[5], sw_d[5]);
    debounce debounce6(clk ,reset, sw[6], sw_d[6]);
    debounce debounce7(clk ,reset, sw[7], sw_d[7]);
    
   
        
    always @(posedge clk) begin
    if(reset) begin
        cnt = 0;
    end
     guide_lights = 8'b0000_0000;
           case(music)
           5'd1: guide_lights[0] = 1'b1;
           5'd2:guide_lights[1] = 1'b1;
           5'd3:guide_lights[2] = 1'b1;
           5'd4:guide_lights[3] = 1'b1;
           5'd5:guide_lights[4] = 1'b1;
           5'd6:guide_lights[5] = 1'b1;
           5'd7:guide_lights[6] = 1'b1;
           5'd8:guide_lights[0] = 1'b1;
           5'd9:guide_lights[1] = 1'b1;
           5'd10:guide_lights[2] = 1'b1;
           5'd11:guide_lights[3] = 1'b1;
           5'd12:guide_lights[4] = 1'b1;
           5'd13:guide_lights[5] = 1'b1;
           5'd14:guide_lights[6] = 1'b1;
           5'd15:guide_lights[0] = 1'b1;
           5'd16:guide_lights[1] = 1'b1;
           5'd17:guide_lights[2] = 1'b1;
           5'd18:guide_lights[3] = 1'b1;
           5'd19:guide_lights[4] = 1'b1;
           5'd20:guide_lights[5] = 1'b1;
           5'd21:guide_lights[6] = 1'b1;
           endcase
           //led will switch to the next light when the correct note is played with the right frequency
            if(guide_lights[0] == 1'b1) begin
            if(prev == 8'b00000000) begin
                if((sw_d[0] == 1'b1 & button == low & music == 5'd1) | sw_d[0] == 1'b1 & button == middle & music == 5'd8 | sw_d[0] == 1'b1 & button == high & music == 5'd15) begin
                    cnt <= cnt + 1;
                    guide_lights[0] <= 1'b0;
                end
                else digit1 <= digit1 +1;
                end
            end
            if(guide_lights[1] == 1'b1) begin
            if(prev == 8'b00000000) begin
                if((sw_d[1] == 1'b1 & button == low & music == 5'd2) | (sw_d[1] == 1'b1 & button == middle & music == 5'd9) | (sw_d[1] == 1'b1 & button == high & music == 5'd16)) begin
                    cnt <= cnt + 1;
                    guide_lights[1] <= 1'b0;
                    end
                    else digit1 <= digit1 +1;
                end
                end
            if(guide_lights[2] == 1'b1) begin
            if(prev == 8'b00000000) begin
                if((sw_d[2] == 1'b1 & button == low & music == 5'd3) | (sw_d[2] == 1'b1 & button == middle & music == 5'd10) | (sw_d[2] == 1'b1 & button == high & music == 5'd17)) begin
                    cnt <= cnt + 1;
                    guide_lights[2] <= 1'b0;
                    end
                    else digit1 <= digit1 +1;
                    end
                end
            if(guide_lights[3] == 1'b1) begin
            if(prev == 8'b00000000) begin
                if((sw_d[3] == 1'b1 & button == low & music == 5'd4) | (sw_d[3] == 1'b1 & button == middle & music == 5'd11) | (sw_d[3] == 1'b1 & button == high & music == 5'd18)) begin
                    cnt <= cnt + 1;
                    guide_lights[3] <= 1'b0;
                    end
                    else digit1 <= digit1 +1;
                    
                    end
                end
            if(guide_lights[4] == 1'b1) begin
            if(prev == 8'b00000000) begin
                if((sw_d[4] == 1'b1 & button == low & music == 5'd5) | (sw_d[4] == 1'b1 & button == middle & music == 5'd12) | (sw_d[4] == 1'b1 & button == high & music == 5'd19)) begin
                    cnt <= cnt + 1;
                    guide_lights[4] <= 1'b0;
                    end
                    else digit1 <= digit1 +1;
                    end
                end
            if(guide_lights[5] == 1'b1) begin
            if(prev == 8'b00000000) begin
                if((sw_d[5] == 1'b1 & button == low & music == 5'd6) | (sw_d[5] == 1'b1 & button == middle & music == 5'd13) | (sw_d[5] == 1'b1 & button == high & music == 5'd20)) begin
                    cnt <= cnt + 1;
                    guide_lights[5] <= 1'b0;
                    end
                    else digit1 <= digit1 +1;
                    end
                end
            if(guide_lights[6] == 1'b1) begin
            if(prev == 8'b00000000) begin
                if((sw_d[6] == 1'b1 & button == low & music == 5'd7) | (sw_d[6] == 1'b1 & button == middle & music == 5'd14) | (sw_d[6] == 1'b1 & button == high & music == 5'd21)) begin
                    cnt <= cnt + 1;
                    guide_lights[6] <= 1'b0;
                    end
                    else digit1 <= digit1 +1;
                    end
               end
               prev = sw_d;
               
               if(digit1 == 4'b1001) begin
                    digit2 <= digit2 +1;
                    digit1 <= 4'b0000;
               end
            end
endmodule

