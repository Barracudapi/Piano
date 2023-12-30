`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/07 14:42:41
// Design Name: 
// Module Name: debounce
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


module debounce(
    input clk, rst,
    input key_in,
    output reg key_out
    );
    `include "ppppparameters.v"
    reg pos_key;
    reg neg_key;
    reg cnt_start;
    reg [21:0] cnt;
    reg [1:0]state_key;
    reg [1:0] count; //to make the time period of 1 to be 1.5periods
    reg [1:0]count_start;
    
    //clk = 100M, 20ms = 2_000_000 periods

    always @( posedge clk) begin
        state_key <= {state_key[0], key_out};
        end
    
    
    
    //only when 20ms passed, will we assign keyin to keyout
    always @( posedge clk, negedge rst) begin
        if(~rst)begin
            key_out <= 0;
            state_key <= 0;
        end else if(cnt == TIME_20MS -1)
            key_out <= key_in;
    end
    
    always @( posedge clk, negedge rst) begin
        if(~rst)
            cnt <= 22'b0;
        else if( cnt_start == 0)
            cnt <= 22'b0;
        else
            cnt <= cnt + 1;
    end
    
    always @( posedge clk, negedge rst) begin
        if(~rst)
            cnt_start <= 0;
        else if( cnt_start == 0 && key_in != key_out)
            cnt_start <= 1;
        else if(cnt == TIME_20MS -1)
            cnt_start <= 0;
    end
    

    always @(posedge clk, negedge rst) begin
        if(~rst) begin
            pos_key <= 0;
            neg_key <= 0;
            count <= 0;
            count_start <= 0;
        end else if(state_key == 2'b10) begin
            count_start <= 1;
        end else if(state_key == 2'b01) begin
             count_start <= 1;
        end
    end
endmodule
