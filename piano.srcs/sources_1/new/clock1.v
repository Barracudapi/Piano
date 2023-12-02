`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/02 17:40:03
// Design Name: 
// Module Name: clock1
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


module clock1(
input wire clk,
input wire reset,
output reg clk_1
    );
    reg [31:0] div_cnt;
    always @(posedge clk) begin
    if(reset == 0) begin
        div_cnt <= 32'd0;
    end
    else if(div_cnt == 32'd100_000_000) begin
        div_cnt <= 0;
    end
    else begin
        div_cnt <= div_cnt + 1;
    end
end

    always @(posedge clk) begin
        if(reset == 0) begin
            clk_1 <= 0;
    end
    else if (div_cnt == 32'd50_000_000) begin
        clk_1 <= 1;
    end
    else if(div_cnt == 32'd100_000_000) begin
        clk_1 <= 0;
    end
end
endmodule
