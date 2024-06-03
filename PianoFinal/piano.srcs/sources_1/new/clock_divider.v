`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 08:50:44
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
input clk, 
input reset,
output clk_div
    );
    
    //100MHZ is too fast for human perception. We need to make it last longer with a clock divider.
    // I think this module slows it down to about 1 second
    reg [31:0] cnt_first, cnt_second;
    parameter TIME_1S = 1_000_000_00;
    always @(posedge clk or posedge reset)
        if(reset)
            cnt_first <= 32'd0;
        else if(cnt_first == TIME_1S)
            cnt_first <= 32'd0;
        else
            cnt_first <= cnt_first + 1'b1;
            
    always @(posedge clk or posedge reset)
        if(reset)
            cnt_second <= 32'd0;
        else if(cnt_second == TIME_1S)
            cnt_second <= 32'd0;
        else if(cnt_first ==  TIME_1S)
            cnt_second <= cnt_second + 1'b1;
        else
            cnt_second <= cnt_second + 1;
            
    assign clk_div = cnt_second ==  TIME_1S;
endmodule
