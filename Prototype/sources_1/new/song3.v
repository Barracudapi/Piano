`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/23 17:17:41
// Design Name: 
// Module Name: song1
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

//this module store the info of the song
//memory module
//input is the cnt, cnt should be incresing
//and incresing count can get the note in order(output music
module song3(
input wire clk,
input wire reset,
input wire [1:0] state,
output reg [5:0] cnt,
output reg [4:0] music
    );
    `include "ppppparameters.v"
    // 1  2  3  4  5  6  7  low rang
    // 8  9  10 11 12 13 14  middle
    // 15 16 17 18 19 20 21  high
    // 0 is silence
    //we are not going to consider sharp now
    //reg [5:0] cnt;
    

            
    always @(posedge clk)begin
    //only works when clk goes 1 or reset goes 0
        if(~reset)
        //when pressed, reset 0, delete music
            music <= 5'd0;
        else 
        if(state == spause) begin
            cnt <= cnt;
            music <= 5'b0;
        end else if(state == sstop) begin
            cnt <= 0;
            music <= 5'b0;
        end else if(state == splay) begin
            cnt <= cnt + 1;
        end
            
        //not pressed, reset 1
           case(cnt) 
                      6'd0    : begin  music <= 5'd1;  end
                      6'd1    :   begin music <= 5'd0;  end
                      6'd2    :   begin music <= 5'd1;  end
                      6'd3    :   begin music <= 5'd0;  end
                      6'd4    :   begin music <= 5'd5;  end
                      6'd5    :   begin music <= 5'd0;  end
                      6'd6    :   begin music <= 5'd5;   end
                      6'd7    :   begin music <= 5'd0;  end
                      
                      6'd8    :   begin music <= 5'd6;  end
                      6'd9    :   begin music <= 5'd0;  end
                      6'd10   :   begin music <= 5'd6;  end
                      6'd11   :   begin music <= 5'd0;  end
                      6'd12   :   begin music <= 5'd5;  end
                      6'd13   :   begin music <= 5'd0;  end
                      6'd14   :   begin music <= 5'd4;  end
                      6'd15   :   begin music <= 5'd0;  end
                      
                      6'd16   :   begin music <= 5'd4;  end
                      6'd17   :   begin music <= 5'd0;  end
                      6'd18   :   begin music <= 5'd3;  end
                      6'd19   :   begin music <= 5'd0;  end
                      6'd20   :   begin music <= 5'd3;  end
                      6'd21   :   begin music <= 5'd0;  end
                      6'd22   :   begin music <= 5'd2;  end
                      6'd23   :   begin music <= 5'd0;  end
                      
                      6'd24   :   begin music <= 5'd2;  end
                      6'd25   :   begin music <= 5'd0;  end
                      6'd26   :   begin music <= 5'd1;  end
                      6'd27   :   begin music <= 5'd1;  end
                      6'd28   :   begin music <= 5'd0;  end
                      6'd29   :   begin music <= 5'd5;  end
                      6'd30   :   begin music <= 5'd0;  end
                      6'd31   :   begin music <= 5'd5;  end
                      
                      6'd32   :   begin music <= 5'd0;  end
                      6'd33   :   begin music <= 5'd4;  end
                      6'd34   :   begin music <= 5'd0; end
                      6'd35   :   begin music <= 5'd4;  end
                      6'd36   :   begin music <= 5'd0;  end
                      6'd37   :   begin music <= 5'd3;  end
                      6'd38   :   begin music <= 5'd0;  end
                      6'd39   :   begin music <= 5'd3;  end
                      
                      6'd40   :   begin music <= 5'd0;  end
                      6'd41   :   begin music <= 5'd2;   end
                      6'd42   :   begin music <= 5'd2;  end
                      6'd43   :   begin music <= 5'd0;  end
                      6'd44   :   begin music <= 5'd5;  end
                      6'd45   :   begin music <= 5'd0;  end
                      6'd46   :   begin music <= 5'd5;  end
                      6'd47   :   begin music <= 5'd0;  end
                      
                      6'd48   :   begin music <= 5'd4;  end
                      6'd49   :   begin music <= 5'd0;  end
                      6'd50   :   begin music <= 5'd4;  end
                      6'd51   :   begin music <= 5'd0;  end
                      6'd52   :   begin music <= 5'd3;  end
                      6'd53   :   begin music <= 5'd0;  end
                      6'd54   :   begin music <= 5'd3;  end
                      6'd55   :   begin music <= 5'd0;  end
                      
                      6'd56   :   begin music <= 5'd2;  end
                      6'd57   :   begin music <= 5'd2;  end
                      6'd58   :   begin music <= 5'd1;  end
                      6'd59   :   begin music <= 5'd2;  end
                      6'd60   :   begin music <= 5'd3;  end
                      6'd61   :   begin music <= 5'd4;  end
                      6'd62   :   begin music <= 5'd5;  end
                      6'd63   :   begin music <= 5'd21;  end
                      default  :   music <= 5'd0;
            endcase
            end
 
endmodule
