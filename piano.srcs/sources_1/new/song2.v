`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/23 17:17:52
// Design Name: 
// Module Name: song2
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


module song2(
input wire clk,
input wire reset,
output reg [4:0] music
    );
    
    reg [5:0] cnt;
    
    always @(posedge clk or negedge reset)begin
        if(reset == 1'b0)
            music <= 5'd0;
        else
        cnt <= cnt +1;
            case(cnt) 
            
            
            
            endcase
            end
 
endmodule
