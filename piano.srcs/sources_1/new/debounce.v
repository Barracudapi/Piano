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
    
    reg cnt_start;
    reg [21:0] cnt;
    
    //clk = 100M, 20ms = 2_000_000 periods
    parameter TIME_20MS = 2_000_000;
    
    //only when 20ms passed, will we assign keyin to keyout
    always @( posedge clk, posedge rst) begin
        if(rst)
            key_out <= 0;
        else if(cnt == TIME_20MS -1)
            key_out <= key_in;
    end
    
    always @( posedge clk, posedge rst) begin
        if(rst)
            cnt <= 22'b0;
        else if( cnt_start == 0)
            cnt <= 22'b0;
        else
            cnt <= cnt +1;
    end
    
    always @( posedge clk, posedge rst) begin
        if(rst)
            cnt_start <= 0;
        else if( cnt_start == 0 && key_in != key_out)
            cnt_start <= 1;
        else if(cnt == TIME_20MS -1)
            cnt_start <= 0;
    end
    
    
    
    
    
endmodule
