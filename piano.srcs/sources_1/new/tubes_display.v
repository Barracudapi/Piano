`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/23 15:41:05
// Design Name: 
// Module Name: tubes_display
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/22 15:01:42
// Design Name: 
// Module Name: tubes_display
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


module tubes_display(
    input clk, rst,
    input [7:0] data7, data6, data5, data4, data3, data2, data1, data0,
    output reg [7:0]seg_en,
    output reg [7:0]seg_out0, //left
    output reg [7:0]seg_out1 //right
    );
    
    reg clkout;
    reg [17:0] cnt;
    reg [2:0] scan_cnt;
    reg [7:0] datain;
    reg [7:0] seg_out;
        
    parameter period2 = 100_000;
    parameter a0=8'h00, a1=8'h01, a2=8'h02, a3=8'h03, a4=8'h04, a5=8'h05, 
    a6=8'h06, a7=8'h07, a8=8'h08, a9=8'h09, 
    aa=8'h0a, bb=8'h0b, cc=8'h0c, dd=8'h0d, ee=8'h0e, ff=8'h10,  
    gg=8'h11, hh=8'h12, ii=8'h13, jj=8'h14, kk=8'h15, ll=8'h16,mm=8'h17,
    nn=8'h18,oo=8'h19,pp=8'h1a,qq=8'h1b,rr=8'h1c,ss=8'h1d,tt=8'h1e,
    uu=8'h1f,vv=8'h20,ww=8'h21,xx=8'h22,yy=8'h23,zz=8'h24, null = 8'h25;
    
    
    always @(posedge clk, posedge rst)
    begin
        if(rst) begin
            cnt<= 0;
            clkout <= 0;
        end else if(cnt == (period2 >>1) -1) begin
            clkout <= ~clkout;
            cnt <= 0;
        end else
            cnt <= cnt +1;
    end 
    
    always @(posedge clkout, posedge rst) begin
        if(rst)
            scan_cnt <= 0;
        else begin
            if(scan_cnt == 3'd7)
                scan_cnt <= 0;
            else
                scan_cnt <= scan_cnt +1;
            end
        end
        
    always@(scan_cnt) begin
        case(scan_cnt)
            3'b000: begin seg_en = 8'h01; datain = data0;end
            3'b001: begin seg_en = 8'h02; datain = data1;end
            3'b010: begin seg_en = 8'h04; datain = data2;end
            3'b011: begin seg_en = 8'h08; datain = data3; end
            3'b100: begin seg_en = 8'h10; datain = data4; end
            3'b101: begin seg_en = 8'h20; datain = data5; end
            3'b110: begin seg_en = 8'h40; datain = data6; end
            3'b111: begin seg_en = 8'h80; datain = data7; end
            default: begin seg_en = 8'h00; datain = 4'b0; end
        endcase
    end
    
    always @(seg_en) begin
        if(seg_en <= 8'h08)
            seg_out1 = seg_out;
        else 
            seg_out0 = seg_out;
    end
    
    always @(posedge clk) begin
        case(datain)
            8'h00: seg_out = 8'b1111_1100;
            8'h01: seg_out = 8'b0110_0000;
            8'h02: seg_out = 8'b1101_1010;
            8'h03: seg_out = 8'b1111_0010;
            8'h04: seg_out = 8'b0110_0110;
            8'h05: seg_out = 8'b1011_0110;
            8'h06: seg_out = 8'b1011_1110;
            8'h07: seg_out = 8'b1110_0000;
            8'h08: seg_out = 8'b1111_1110;
            8'h09: seg_out = 8'b1110_0110;
            8'h0a: seg_out = 8'b1110_1110;
            8'h0b: seg_out = 8'b0011_1110;
            8'h0c: seg_out = 8'b0111_1010;
            8'h0d: seg_out = 8'b0111_1010;
            8'h0e: seg_out = 8'b1001_1110;
            8'h10: seg_out = 8'b1000_1110; //f
            8'h11: seg_out = 8'b1011_1100; //g
            8'h12: seg_out = 8'b0110_1110; //h
            8'h13: seg_out = 8'b0000_1000; //i
            8'h14: seg_out = 8'b0111_0000;//j
            8'h15: seg_out = 8'b0101_1110;//k
            8'h16: seg_out = 8'b0001_1100;//l
            8'h17: seg_out = 8'b1010_1010;//m
            8'h18: seg_out = 8'b0010_1010;//n
            8'h19: seg_out = 8'b0011_1010;//o
            8'h1a: seg_out = 8'b1100_1110;//p
            8'h1b: seg_out = 8'b1110_0110;//q
            8'h1c: seg_out = 8'b0000_1010;//r
            8'h1d: seg_out = 8'b1011_0110;//s
            8'h1e: seg_out = 8'b0001_1110;//t
            8'h1f: seg_out = 8'b0111_1100;//u
            8'h20: seg_out = 8'b0100_0110;//v
            8'h21: seg_out = 8'b0101_0110;//w
            8'h22: seg_out = 8'b0110_1100;//x
            8'h23: seg_out = 8'b0111_0110;//y
            8'h24: seg_out = 8'b1001_0010;//z
            default: seg_out = 0;
        endcase
    end
    
    

    
    
endmodule
