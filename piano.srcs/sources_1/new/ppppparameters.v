`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 17:06:01
// Design Name: 
// Module Name: ppppparameters
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


        //the frequency of each note
parameter low1 = 262, middle1 = 523, high1 = 1046,
          low2 = 294, middle2 = 587, high2 = 1175,
          low3 = 330, middle3 = 659, high3 = 1318,
          low4 = 349, middle4 = 699, high4 = 1398,
          low5 = 370, middle5 = 784, high5 = 1569,
          low6 = 440, middle6 = 880, high6 = 1762,
          low7 = 494, middle7 = 988, high7 = 1977,
          low1s = 277, middle1s = 277, high1s = 277,
          low2s = 311, middle2s = 311, high2s = 311,
          low4s = 370, middle4s = 370, high4s = 370,
          low5s = 415, middle5s = 415, high5s = 415,
          low6s = 466, middle6s = 466, high6s = 466,
          silence = 1;

    //the range
    parameter high=3'b100, middle=3'b010, low=3'b001;
    
    //1 / the frequency of clk
    parameter N = 100_000_000;
    
    //no buttons are playing a note
    parameter not_playing_note = 8'b00000000;
    
    //learn mode states
    parameter learn = 2'b00, finish = 2'b01, evaluate = 2'b10;
    
    //seven segment tube display
     parameter period2 = 100_000;
       parameter a0=8'h00, a1=8'h01, a2=8'h02, a3=8'h03, a4=8'h04, a5=8'h05, 
       a6=8'h06, a7=8'h07, a8=8'h08, a9=8'h09, 
       aa=8'h0a, bb=8'h0b, cc=8'h0c, dd=8'h0d, ee=8'h0e, ff=8'h10,  
       gg=8'h11, hh=8'h12, ii=8'h13, jj=8'h14, kk=8'h15, ll=8'h16,mm=8'h17,
       nn=8'h18,oo=8'h19,pp=8'h1a,qq=8'h1b,rr=8'h1c,ss=8'h1d,tt=8'h1e,
       uu=8'h1f,vv=8'h20,ww=8'h21,xx=8'h22,yy=8'h23,zz=8'h24, null = 8'h25;
       
   //Interval parameter
   parameter one = 3'b001, two = 3'b010, three = 3'b011, four = 3'b100;
   
   //song_length
   parameter s1_length = 6'd42, s2_length = 6'd57;
   
   //clock2 parameter
    
    parameter idle_learn = 2'b11;
