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
    reg [31:0]period;
    reg [31:0]counter;
    reg pwm;
    
    `include "ppppparameters.v";
    
    initial begin
    pwm = 0;
    end
    
    //how long will different pitches last
    //higher frequency -> shorter lasting time
    always@(frequency) begin
    if(frequency == 1)
        period = 1;
    else
        period = N / (2 * frequency);
    end
    
    //counter is to count how many clk cycles it will last
    //if counter < lasting time it means it's not time to change yet
    //when counter >= lasting time, it means it's time to move on to the next pitch
    always@(posedge clk) begin
        if(counter < period || period == 1) begin
            counter  <= counter + 1;
        end
        else begin
            pwm = ~pwm;
            counter <= 0;
        end
    end
    //when pitch change, melody get reverse
    //to generate a square wave
    assign melody = pwm;
endmodule
