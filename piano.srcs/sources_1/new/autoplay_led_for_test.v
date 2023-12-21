`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/09 14:52:27
// Design Name: 
// Module Name: autoplay_led_for_test
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


module autoplay_test_states_songs(
    input clk,
    input [1:0] state,
    input [1:0] music, 
    output reg [2:0] led_state,
    output reg [2:0] select_song
    );
    
    parameter sstop = 2'b00, splay = 2'b01, spause = 2'b10;
    
    always@ (posedge clk) begin
        case(state)
            sstop: led_state = 3'b100;
            splay: led_state = 3'b010;
            spause: led_state = 3'b001;
            default: led_state = 3'b111;
        endcase
    end
    
    always@ (posedge clk) begin
        case(music)
            2'b00:select_song = 3'b100;
            2'b01:select_song = 3'b010;
            2'b10:select_song = 3'b001;
            default: select_song = 3'b111;
        endcase
    end
        
    
    
endmodule
