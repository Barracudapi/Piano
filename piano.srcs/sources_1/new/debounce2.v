`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/09 01:16:17
// Design Name: 
// Module Name: debounce2
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


module debounce2(
    input clk,
    input rst,
    input key,
    output reg key_pflag //when the key is pressed
    );
    wire key_flag; //when the key is pressed/ released
    reg key_state; //the wave after debouncing
    reg key_rflag; //when the key is released
    assign key_flag = (key_pflag | key_rflag);
    reg [1:0] r_key; //
    
    //every posclk, rkey1 is the last state, rkey0 is the current key(state
    always@(posedge clk)
        r_key <= {r_key[0], key};
    
    
    wire pos_key;
    wire neg_key;
    
    //neg_key: last state is 1, next state is 0
    //pos_key: last state is 0, next state is 1
    assign neg_key = (r_key == 2'b10);
    assign pos_key = (r_key == 2'b01);
    
    reg[21:0] cnt;
    reg[1:0] state;
    
    //idle is when the key is always 0
    //p_filter is when the first posedge of key comes
    //wait_r is to wait for the negedge
    //n_filter is when the first negedge of key comes
    parameter idle = 2'b00, p_filter = 2'b01, wait_r = 2'b10, n_filter = 2'b11;
    parameter TIME = 2_000_000;
    
    
    //transition among 4 states( the scripts is on the paper
    always@(posedge clk, negedge rst) begin
        if(~rst) begin
            state <= idle;
            cnt <= 0;
            key_pflag <= 0;
            key_rflag <= 0;
            key_state <= 0;
        end else begin
            case(state)
                idle: begin
                    key_rflag <= 0;
                    if(pos_key)
                        state <= p_filter;
                    else
                        state <= idle;
                end
                p_filter: begin
                    if(cnt < TIME -1) begin
                        if(neg_key) begin
                            state <= idle;
                            cnt <= 0;
                        end else
                            cnt <= cnt +1;
                    end else if(cnt >= TIME -1) begin
                        key_pflag <= 1;
                        state <= wait_r;
                        cnt <= 0;  
                        key_state <= 1;
                    end
                end
                wait_r: begin
                    key_pflag <= 0;
                    if(neg_key)
                        state <= n_filter;
                    else
                        state <= wait_r;
                end
                n_filter: begin
                if(cnt < TIME -1) begin
                    if(pos_key) begin
                        state <= wait_r;
                        cnt <= 0;
                    end else
                        cnt <= cnt +1;
                end else if(cnt >= TIME -1) begin
                    key_rflag <= 1;
                    state <= idle;
                    cnt <= 0;
                    key_state <= 0;
                end 
            end
        endcase
    end
end
            
endmodule
