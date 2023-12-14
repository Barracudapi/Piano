`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/14 21:31:00
// Design Name: 
// Module Name: learning_mode
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


module learning_mode(
input clk, reset,
input [7:0] sw,
input wire [2:0] button,
output sd,
output melody,
output reg [7:0] guide_lights
    );
    
    `include "ppppparameters.v"
   wire [1:0] useless_state;
   reg [5:0] cnt = 0;
   wire [4:0] music;    
   assign sd = 1'b1;
   wire [10:0] frequency;
    
    free_play play(clk, reset, button, sw, frequency);
    generate_melody gm(.clk(clk), .frequency(frequency), .melody(melody));
    learn_song1 song1(cnt, music);
    
   
        
    always @(*) begin
     guide_lights = 7'b000_0000;
           case(music)
           5'd1: guide_lights[0] = 1'b1;
           5'd2:guide_lights[1] = 1'b1;
           5'd3:guide_lights[2] = 1'b1;
           5'd4:guide_lights[3] = 1'b1;
           5'd5:guide_lights[4] = 1'b1;
           5'd6:guide_lights[5] = 1'b1;
           5'd7:guide_lights[6] = 1'b1;
           5'd8:guide_lights[0] = 1'b1;
           5'd9:guide_lights[1] = 1'b1;
           5'd10:guide_lights[2] = 1'b1;
           5'd11:guide_lights[3] = 1'b1;
           5'd12:guide_lights[4] = 1'b1;
           5'd13:guide_lights[5] = 1'b1;
           5'd14:guide_lights[6] = 1'b1;
           5'd15:guide_lights[0] = 1'b1;
           5'd16:guide_lights[1] = 1'b1;
           5'd17:guide_lights[2] = 1'b1;
           5'd18:guide_lights[3] = 1'b1;
           5'd19:guide_lights[4] = 1'b1;
           5'd20:guide_lights[5] = 1'b1;
           5'd21:guide_lights[6] = 1'b1;
           endcase
        if(guide_lights[0] == 1'b1) begin
            if((sw[0] == 1'b1 & button == low & music == 5'd1) | sw[0] == 1'b1 & button == middle & music == 5'd8 | sw[0] == 1'b1 & button == high & music == 5'd15) begin
                guide_lights[0] = 1'b0;
                end
            end
            if(guide_lights[1] == 1'b1) begin
                        if((sw[1] == 1'b1 & button == low & music == 5'd2) | (sw[1] == 1'b1 & button == middle & music == 5'd9) | (sw[1] == 1'b1 & button == high & music == 5'd16)) begin
                            guide_lights[1] = 1'b0;
                            end
                        end
            if(guide_lights[2] == 1'b1) begin
                        if((sw[2] == 1'b1 & button == low & music == 5'd3) | (sw[2] == 1'b1 & button == middle & music == 5'd10) | (sw[2] == 1'b1 & button == high & music == 5'd17)) begin
                            guide_lights[2] = 1'b0;
                            end
                        end
            if(guide_lights[3] == 1'b1) begin
                        if((sw[3] == 1'b1 & button == low & music == 5'd4) | (sw[3] == 1'b1 & button == middle & music == 5'd11) | (sw[3] == 1'b1 & button == high & music == 5'd18)) begin
                            guide_lights[3] = 1'b0;
                            end
                        end
            if(guide_lights[4] == 1'b1) begin
                        if((sw[4] == 1'b1 & button == low & music == 5'd5) | (sw[4] == 1'b1 & button == middle & music == 5'd12) | (sw[4] == 1'b1 & button == high & music == 5'd19)) begin
                            guide_lights[4] = 1'b0;
                            end
                        end
            if(guide_lights[5] == 1'b1) begin
                        if((sw[5] == 1'b1 & button == low & music == 5'd6) | (sw[5] == 1'b1 & button == middle & music == 5'd13) | (sw[5] == 1'b1 & button == high & music == 5'd20)) begin
                            guide_lights[5] = 1'b0;
                            end
                        end
            if(guide_lights[6] == 1'b1) begin
                        if((sw[6] == 1'b1 & button == low & music == 5'd7) | (sw[6] == 1'b1 & button == middle & music == 5'd14) | (sw[6] == 1'b1 & button == high & music == 5'd21)) begin
                            guide_lights[6] = 1'b0;
                            end
                        end
                        end
                        
                        always @(posedge sw)
                            if(cnt < 5'b11111) 
                                cnt = cnt + 1;
                            else
                                cnt = 0;
                    
                
                                                                        
    
    
   
endmodule
