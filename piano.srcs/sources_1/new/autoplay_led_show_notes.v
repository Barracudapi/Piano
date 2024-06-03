`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 00:04:02
// Design Name: 
// Module Name: autoplay_led_show_notes
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


module autoplay_led_show_notes(
    input [4:0] note,
    output led1
    );
    assign led1 = note[0] | note[1] | note[2] | note[3] | note[4];
endmodule
