`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/24 22:00:45
// Design Name: 
// Module Name: account
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


module account(
input clk, input reset,
input [1:0] state,
input [3:0] rating1, rating2,
input userbtn,
input updatebtn,
output reg [1:0] user,
output reg [3:0] user_rating1, user_rating2
    );
    `include "ppppparameters.v"
    reg [3:0] user0_rating1, user0_rating2;
    reg [3:0] user1_rating1, user1_rating2;
    reg [3:0] user2_rating1, user2_rating2;
    reg [3:0] user3_rating1, user3_rating2;
    
     always@(posedge clk, negedge reset) begin
              if(~reset) begin
                  user = 0;
              end 
              else if(state == evaluate) begin
              if(userbtn == 1) begin
                  case(user)
                      0: user = 1;
                      1: user = 2;
                      2: user = 3;
                      3: user = 0;
                      default: begin user = 0; end
                  endcase
              end else
                 user <= user;
          
            if(updatebtn == 1) begin
                case(user)
                    0: begin user0_rating1 <= rating1; user0_rating2 <= rating2; user_rating1 <= user0_rating1; user_rating2 <= user0_rating2; end
                    1: begin user1_rating1 <= rating1; user1_rating2 <= rating2; user_rating1 <= user1_rating1; user_rating2 <= user1_rating2; end
                    2: begin user2_rating1 <= rating1; user2_rating2 <= rating2; user_rating1 <= user2_rating1; user_rating2 <= user2_rating2; end
                    3: begin user3_rating1 <= rating1; user3_rating2 <= rating2; user_rating1 <= user3_rating1; user_rating2 <= user3_rating2; end
                    endcase
                end
            end
            end
    
    
endmodule
