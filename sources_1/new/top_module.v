`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/24 16:27:05
// Design Name: 
// Module Name: top_module
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

//this is the top module of piano proj
//state machine

module top_module(
    input clk, rst,
    input btn_up,
    input btn_center,
    input btn_left,
    input btn_right,
    input btn_down,
    input [7:0] bg_sw,
    input [7:0] sm_sw,
    
    output [7:0] bg_led,
    output [7:0] sm_led,
    output [7:0] seg_en,
    output [7:0] seg_sel_l,
    output [7:0] seg_sel_r,
    output pwm,
    output sd
    );
    
    assign sd = 1'b1;
    
    `include "ppppparameters.v"
    
    wire en_auto, en_free, en_learn, en_record, en_top;
    
    wire [7:0] seg_en1, seg_sel_l1, seg_sel_r1, 
    seg_en2, seg_sel_l2, seg_sel_r2,
    seg_en3, seg_sel_l3, seg_sel_r3,
    seg_en4, seg_sel_l4, seg_sel_r4,
    seg_en5, seg_sel_l5, seg_sel_r5;
        
    wire [7:0] bg_led1, sm_led1,bg_led3, sm_led3,bg_led2, sm_led2,bg_led4, sm_led4, bg_led5, sm_led5;
    wire pwm1, pwm2, pwm3, pwm4, pwm5;
    

    auto_play m1(en_auto, clk, rst, btn_left, btn_center, btn_down, btn_up,
                pwm2, seg_en2, seg_sel_l2, seg_sel_r2, bg_led2[7:0], sm_led2[2:0]);
                
    free_play_top m2(en_free, clk, rst, {btn_up, btn_center, btn_down}, bg_sw, 
                pwm3, bg_led3, sm_led3,seg_en3, seg_sel_l3, seg_sel_r3);
                
    learn_mode m3(en_learn, clk, rst, bg_sw, btn_up,btn_center, btn_down, btn_left, 
                pwm4, bg_led4, seg_en4,seg_sel_r4,seg_sel_l4,sm_led4[7:4], sm_led4[2:0]);
                
    recording m4(en_record, clk, rst, bg_sw, btn_up, btn_center, btn_left, btn_down,
                bg_led5, sm_led5, pwm5, seg_en5, seg_sel_l5, seg_sel_r5);
                
    top_state ts(clk, rst, btn_up, btn_center, btn_left, btn_right, btn_down,
               seg_en2, seg_sel_l2, seg_sel_r2,
               seg_en3, seg_sel_l3, seg_sel_r3,
               seg_en4, seg_sel_l4, seg_sel_r4,
               seg_en5, seg_sel_l5, seg_sel_r5,
               bg_led3, sm_led3 ,bg_led2, sm_led2, bg_led4, sm_led4,bg_led5, sm_led5,
               pwm2, pwm3, pwm4, pwm5,
               
               en_auto, en_free, en_learn, en_record, en_top,bg_led,sm_led,
               seg_en,seg_sel_l,seg_sel_r,pwm,sd);
        
endmodule
