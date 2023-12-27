`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/14 09:34:39
// Design Name: 
// Module Name: check_dif_tb
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


module tbcheckdif();
reg clk, rst, x;
wire z;

checkdif dut(clk, rst, x, z);

initial #160 $finish; 
initial begin
$monitor ("%d %d %d %d", clk, rst, x, z);
#0 clk = 1'b1;
#0 rst = 1'b1;
forever #5 clk = ~clk;
end

initial fork
x = 1'b0;
#6 rst = 1'b0;
#12 x = 1'b1;
#48 x = 1'b0;
#88 x = 1'b1;
#128 x = 1'b0;
#148 x = 1'b1;
join
endmodule