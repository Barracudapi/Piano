`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 20:31:01
// Design Name: 
// Module Name: autoplay_test_cnt
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


module autoplay_test_cnt(
    input [5:0]cnt,
    output reg led
    );
    
    always @(*) begin
        if(cnt > 0)
            led = 1'b1;
        else led = 1'b0;
    end
    
    
endmodule
