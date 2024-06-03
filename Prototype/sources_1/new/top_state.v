`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/29 12:26:16
// Design Name: 
// Module Name: top_state
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


module top_state(
    input clk, rst,
    input btn_up,
    input btn_center,
    input btn_left,
    input btn_right,
    input btn_down,
   
   input [7:0] seg_en2, seg_sel_l2, seg_sel_r2,
   seg_en3, seg_sel_l3, seg_sel_r3,
   seg_en4, seg_sel_l4, seg_sel_r4,
   seg_en5, seg_sel_l5, seg_sel_r5,
       
   input [7:0] bg_led3, sm_led3 ,
   bg_led2, sm_led2,
   bg_led4, sm_led4,
    bg_led5, sm_led5,
    
   input pwm2, pwm3, pwm4, pwm5,
   
   output reg en_auto, en_free, en_learn, en_record, en_top,
   output reg [7:0] bg_led,
   output reg [7:0] sm_led,
   output reg [7:0] seg_en,
   output reg [7:0] seg_sel_l,
   output reg [7:0] seg_sel_r,
   output reg pwm,
   output sd
    );
    
    assign sd = 1'b1;
    
    wire up, center, down, left, right;
    
    debounce2 c(clk, rst, btn_center, center);
    debounce2 r(clk, rst, btn_right, right);
    
    reg [2:0] state;
    reg [2:0]counter;
    
    wire bg_led1, sm_led1, pwm1;
    wire [7:0] seg_en1, seg_sel_l1, seg_sel_r1;
    
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
    
        show_mode sm(en_top, clk, rst,counter, 
                        seg_en1, seg_sel_l1, seg_sel_r1);
    
endmodule
