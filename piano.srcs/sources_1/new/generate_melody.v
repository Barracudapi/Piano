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
    input frequency,
    output reg melody = 0
    );
    reg [31:0]lasting_time;
    reg [31:0]counter;
    reg pitch_change;
    parameter N = 1_0000_0000;
    
    //how long will different pitches last
    //higher frequency -> shorter lasting time
    always@(frequency) begin
    if(frequency == 1)
        lasting_time = 1;
    else
        lasting_time = N / (2*frequency);
    end
    
    //counter is to count how many clk cycles it will last
    //if counter < lasting time it means it's not time to change yet
    //when counter >= lasting time, it means it's time to move on to the next pitch
    always@(posedge clk) begin
        if(counter < lasting_time) begin
            counter  <= counter +1;
            pitch_change <= 0;
        end
        else begin
            counter <= 0;
            pitch_change <= 1;
        end
    end
    
    //when pitch change, melody get reverse
    //to generate a square wave
    always@(posedge pitch_change) 
        melody = ~melody;
    
    
    
    
endmodule
