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
    
    output reg [7:0] bg_led,
    output reg [7:0] sm_led,
    output reg [7:0] seg_en,
    output reg [7:0] seg_sel_l,
    output reg [7:0] seg_sel_r,
    output reg pwm,
    output sd
    );
    
    assign sd = 1'b1;
    
    `include "ppppparameters.v"
    
    reg [2:0] state;
    wire up, center, down, left, right;
    reg en_auto, en_free, en_learn, en_record;
    reg en_top;
    reg [2:0]counter;
    
    wire [7:0] seg_en1, seg_sel_l1, seg_sel_r1, 
    seg_en2, seg_sel_l2, seg_sel_r2,
    seg_en3, seg_sel_l3, seg_sel_r3,
    seg_en4, seg_sel_l4, seg_sel_r4,
    seg_en5, seg_sel_l5, seg_sel_r5;
        
    wire [7:0] bg_led1, sm_led1,bg_led3, sm_led3,bg_led2, sm_led2,bg_led4, sm_led4, bg_led5, sm_led5;
    wire pwm1, pwm2, pwm3, pwm4, pwm5;
    
    
    debounce2 c(clk, rst, btn_center, center);
    debounce2 r(clk, rst, btn_right, right);
    //debounce2 l(clk, rst, btn_left, left);
    
    assign bg_led1 = 8'b0;
    assign sm_led1 = 8'b0;
    assign pwm1 = 1;
    

    
    always@(posedge clk, negedge rst)begin
        if(~rst) begin
            state <= menu;
            en_top <=1'b1;
            en_auto <= 1'b0;
            en_free <= 1'b0;
            en_learn <= 1'b0;
            en_record <= 1'b0;
        end else if(counter == 0) begin
            state <= menu;
            en_top <=1'b1;
            en_auto <= 1'b0;
            en_free <= 1'b0;
            en_learn <= 1'b0;
            en_record <= 1'b0;
        end else if(right == 1)begin
                if(state == menu) begin
                    if(counter == 1) begin
                        state <= auto;
                        en_auto <= 1'b1;
                        en_free <= 1'b0;
                        en_learn <= 1'b0;
                        en_record <= 1'b0;
                    end else if(counter == 2) begin
                        state <= free;
                        en_auto <= 1'b0;
                        en_free <= 1'b1;
                        en_learn <= 1'b0;
                        en_record <= 1'b0;
                    end else if(counter == 3) begin
                        state <= learning;
                        en_auto <= 1'b0;
                        en_free <= 1'b0;
                        en_learn <= 1'b1;
                        en_record <= 1'b0;
                    end else if(counter == 4) begin
                        state <= rcd;
                        en_auto <= 1'b0;
                        en_free <= 1'b0;
                        en_learn <= 1'b0;
                        en_record <= 1'b1;
                    end
                    en_top <= 1'b0;
                end else begin
                    state <= menu;
                    en_top <=1'b1;
                    en_auto <= 1'b0;
                    en_free <= 1'b0;
                    en_learn <= 1'b0;
                end
            end
    end
    
    
    
    always@(posedge clk, negedge rst)begin
        if(~rst) begin
            counter <= 0;
        end else if(en_top) begin
             if(counter == 5)
                counter <= 0;
            else if(en_top == 1 & center == 1'b1)
                counter <= counter +1;
            else if(left)
                counter <= 0;
            else
                counter <= counter;
        end
    end    
    
    always @(posedge clk) begin
            case(state)
                menu:begin
                bg_led <= bg_led1;
                sm_led <= sm_led1;
                seg_en <= seg_en1;
                seg_sel_l <= seg_sel_l1;
                seg_sel_r <= seg_sel_r1;
                pwm <= pwm1;
                end
                auto: begin
                bg_led <= bg_led2;
                sm_led <= sm_led2;
                seg_en <= seg_en2;
                seg_sel_l <= seg_sel_l2;
                seg_sel_r <= seg_sel_r2;
                pwm <= pwm2;
                end
                free: begin
                bg_led <= bg_led3;
                sm_led <= sm_led3;
                seg_en <= seg_en3;
                seg_sel_l <= seg_sel_l3;
                seg_sel_r <= seg_sel_r3;
                pwm <= pwm3;
                end
                learning:begin
                bg_led <= bg_led4;
                sm_led <= sm_led4;
                seg_en <= seg_en4;
                seg_sel_l <= seg_sel_l4;
                seg_sel_r <= seg_sel_r4;
                pwm <= pwm4;
                end
                rcd: begin
                bg_led <= bg_led5;
                sm_led <= sm_led5;
                seg_en <= seg_en5;
                seg_sel_l <= seg_sel_l5;
                seg_sel_r <= seg_sel_r5;
                pwm <= pwm5;
                end
            endcase
    end
    

        
    show_mode sm(en_top, clk, rst,counter, seg_en1, seg_sel_l1, seg_sel_r1);
    auto_play m1(en_auto, clk, rst, btn_left, btn_center, btn_down, btn_up,
                pwm2, seg_en2, seg_sel_l2, seg_sel_r2, bg_led2[7:0], sm_led2[2:0]);
    free_play_top m2(en_free, clk, rst, {btn_up, btn_center, btn_down}, bg_sw, 
                pwm3, bg_led3, sm_led3,seg_en3, seg_sel_l3, seg_sel_r3);
    learn_mode m3(en_learn, clk, rst, bg_sw, btn_up,
                btn_center, btn_down, btn_left, 
                pwm4, bg_led4, seg_en4,seg_sel_r4,seg_sel_l4,sm_led4[7:4], sm_led4[2:0]);
    recording m4(en_record, clk, rst, bg_sw, btn_up, btn_center, btn_left, btn_down,
                bg_led5, sm_led5, pwm5, seg_en5, seg_sel_l5, seg_sel_r5);
    
    
    
    
                
        
    
        
endmodule
