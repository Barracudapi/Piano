`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/20 09:01:43
// Design Name: 
// Module Name: generate_melody
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


module generate_melody(
    input clk,
    input [10:0]frequency,
    output wire melody
    );
    reg [31:0]lasting_time;
    reg [31:0]counter;
    reg pitch_change;
    
    `include "ppppparameters.v";
    
    initial begin
    pitch_change = 0;
    end
    
    //how long will different pitches last
    //higher frequency -> shorter lasting time
    always@(frequency) begin
    if(frequency == 1)
        lasting_time = 1;
    else
        lasting_time = N / (2 * frequency);
    end
    
    //counter is to count how many clk cycles it will last
    //if counter < lasting time it means it's not time to change yet
    //when counter >= lasting time, it means it's time to move on to the next pitch
    always@(posedge clk) begin
        if(counter < lasting_time || lasting_time == 1) begin
            counter  <= counter + 1;
        end
        else begin
            pitch_change = ~pitch_change;
            counter <= 0;
        end
    end
    //when pitch change, melody get reverse
    //to generate a square wave
    assign melody = pitch_change;
endmodule
