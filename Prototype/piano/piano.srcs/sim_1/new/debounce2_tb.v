`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/09 02:41:32
// Design Name: 
// Module Name: debounce2_tb
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


module debounce2_tb(
    );
    reg Clk;
    reg Reset;
    reg Key;
    wire Key_Flag;
    wire Key_State;
   
    debounce2 dut(
        Clk,
        Reset,
        Key,
        Key_Flag,
        Key_State
        );
     initial Clk=0;
     always#5 Clk=!Clk;
     initial begin
     Reset=1;
     #201
     Reset=0;
     press_key(2);
     $stop;
     end
     
     reg [31:0]rand;
     task press_key;
     input [3:0]seed;
     begin
     Key=0;
     #20000000;
     repeat(5)begin
         rand={$random(seed)}%10000000;
         #rand Key=~Key;
          end
     Key=1;
     #40000000;
     repeat(5)begin
         rand={$random(seed)}%10000000;
         #rand Key=~Key;
          end
     Key=0;
     #40000000;
     end
     endtask
     
endmodule

