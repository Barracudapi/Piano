`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/25 15:22:35
// Design Name: 
// Module Name: recording
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


module recording(
    input en,
    input clk, rst,
    input [7:0] sw,
    input btn_up,
    input btn_center,
    input btn_left,
    input btn_down, 
    
    output reg [7:0] led,
    output reg [7:0] range,
    output reg pwm,
    output reg [7:0] seg_en,
    output reg [7:0]seg_outl, //left
    output reg [7:0]seg_outr //right
    );
    //a music array to note down the note 5bit each 100 in total
    //translate input into music numbers
    //a counter to counter how long each note is, use 0.1clk
    //a clk divider, 0.1s
    //state machine: idle, record, play
    //when sw change, start to count, back to 0000_0000, note
    `include "ppppparameters.v"
//     `include "array_packer.vh"
//     `include "array_packer2.vh"
     
    assign sd = 1'b1;
    wire note0,note1,note2,note3,
    note4,note5,note6,note7;
    wire n0,n1,n2,n3,
        n4,n5,n6,n7;
    wire note77, note66, note55, note44, 
    note33, note22, note11, note00;
    debounce2 s0(clk, rst, sw[0], note0);
    debounce2 s1(clk, rst, sw[1], note1);
    debounce2 s2(clk, rst, sw[2], note2);
    debounce2 s3(clk, rst, sw[3], note3);
    debounce2 s4(clk, rst, sw[4], note4);
    debounce2 s5(clk, rst, sw[5], note5);
    debounce2 s6(clk, rst, sw[6], note6);
    debounce2 s7(clk, rst, sw[7], note7);
    
    debounce3 ss0(clk, rst, sw[0], n0);
    debounce3 ss1(clk, rst, sw[1], n1);
    debounce3 ss2(clk, rst, sw[2], n2);
    debounce3 ss3(clk, rst, sw[3], n3);
    debounce3 ss4(clk, rst, sw[4], n4);
    debounce3 ss5(clk, rst, sw[5], n5);
    debounce3 ss6(clk, rst, sw[6], n6);
    debounce3 ss7(clk, rst, sw[7], n7);
    
    debounce s00(clk, rst, sw[0], note00);
    debounce s11(clk, rst, sw[1], note11);
    debounce s22(clk, rst, sw[2], note22);
    debounce s33(clk, rst, sw[3], note33);
    debounce s44(clk, rst, sw[4], note44);
    debounce s55(clk, rst, sw[5], note55);
    debounce s66(clk, rst, sw[6], note66);
    debounce s77(clk, rst, sw[7], note77);
    
    wire [7:0] note = {note7, note6, note5, note4, note3, note2, note1, note0};
    wire [7:0] note_de1 = {note77, note66, note55, note44, note33, note22, note11, note00};
    wire [7:0] note_de2 = {n0,n1,n2,n3,n4,n5,n6,n7};
    
    
    
    
    reg [1:0]state;
    reg [6:0] cnt;
    reg [4:0] music [99:0];
    reg [3:0] interval [99:0];
    reg [1:0]octave;
    wire [4:0] music1;
    
//    wire [499:0] music_packed;
//     `PACK_ARRAY(500,1,music, music_packed)
     
//    wire [399:0] interval_packed;
//    `PACK_ARRAY2(400,1,interval, interval_packed)
   
    
    
    wire up, center, down, left;
    
    reg [3:0] counter;//0.1
    reg [31:0] count;
    reg count_start;
    
    debounce2 h(clk, rst,btn_up, up);
    debounce2 m(clk, rst, btn_center, center);
    debounce2 l(clk, rst, btn_down, down);
    debounce2 left_btn(clk, rst, btn_left, left);
    
    //0.1s is 100_000_000 =>1000_00
    //count == 100_000_00
    
    
    //wire [7:0]led1,led2, ledrange1,ledrange2;
    reg [7:0]led2,ledrange2;
    wire [7:0]led1, ledrange1;
    
    wire pwm1, pwm2;
    
    wire [7:0] seg_en1, seg_outl1, seg_outr1, 
    seg_en2, seg_outl2, seg_outr2;
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    
    //state machine(a extension of free play
    always@(posedge clk, negedge rst) begin
        if(~rst)
            state <= idle;
        else if(en)begin
            case(state)
                idle:begin
                    led <= 8'b01010101;
                    range <= 8'b01010101;
                    pwm <= 1;
                    seg_en <= 0;
                    seg_outl <= 0;
                    seg_outr <= 0;
                    if(up == 1)
                        state <= record;
                    else if(down == 1)
                        state <= play;
                    else
                        state <= state;
                end
                record:begin
                    led <= led1;
                    range <= ledrange1;
                    pwm <= pwm1;
                    seg_en <= seg_en1;
                    seg_outl <= seg_outl1;
                    seg_outr <= seg_outr1;
                    if(left == 1)
                        state <= idle;
                    else if(cnt == 100)
                        state <= idle;
                    else
                        state <= state;
                end
                play:begin
                    led <= led2;
                    range <= ledrange2;
                    pwm <= pwm2;
//                    seg_en <= seg_en2;
//                    seg_outl <= seg_outl2;
//                    seg_outr <= seg_outr2;
                    seg_en <= 8'b0000_0001;
                    seg_outl <= seg_outl2;
                    seg_outr <= 8'b1111_1111;
                    if(left == 1)
                        state <= idle;
//                    else if(up == 1)
//                        state <= pause;
                end
//                pause:begin
//                    led <= 0;
//                    range <= 0;
//                    pwm <= 1;
//                    seg_en <= seg_en2;
//                    seg_outl <= seg_outl2;
//                    seg_outr <= seg_outr2;
//                    if(left == 1)
//                        state <= idle;
//                    else if(center == 1)
//                        state <= play;
//                end
            endcase
        end
    end
    
    /////////////////////////////////////////////////////////////////////////////
    //recording state
    //get octave from buttons
    always@(posedge clk, negedge rst) begin
        if(~rst) begin
            octave <= mi;
        end else if(up == 1)
            octave <= hi;
        else if(center == 1)
            octave <= mi;
        else if(down == 1)
            octave <= lo;
    end
    
    
    //when note is not 0(sw on), cnt note +1
    always @(posedge clk, negedge rst) begin
        if(~rst)
            cnt <= 7'b0;
        else if( state == record)begin
            if(note > 0) 
            cnt <= cnt + 2;
            else cnt <= cnt;
        end
    end
    
    //i am not sure about this part
    //this part what i wanna do is at the posedge of sw change
    //the counter start to count
    //i think you are more experienced in it
    always@(note_de1) begin
        if(note_de1 == 8'b0) begin //when note goes back to 0000_oooo
            count_start = 1'b0;
        end else if(note_de1 > 0 && state == record)begin
            count_start = 1'b1;
        end
    end
    
    
    
    integer i;
    //count == 100_000_00
     always @(posedge clk, negedge rst) begin
        if(~rst) begin
            count <= 32'b0;
            counter <= 0;
            interval[0] <= 1;
            for( i = 0; i < 100; i = i+1) begin
                music[i] <= 0;
                interval[i] <= 0;
            end
        end else if(en) begin
        if(state == idle && up == 1) begin
            for( i = 0; i < 100; i = i+1) begin
                        music[i] <= 0;
                        interval[i] <= 0;
                    end
        end    
        if(state == record) begin
            if(count >= 100_000_00) begin
                counter <= counter +1;
                count <= 0;
            end else if(count_start) 
            count <= count + 1;
            end
            
            if(count_start) begin
            music[cnt] <= music1;
            music[cnt + 1] <= 0; end
             else if(note == 8'b0)
            counter <= 16'b0;
                
                
            if(note_de2)begin
                if(count < 100_000_00 & counter == 0) begin
                    interval[cnt] <= 1;
                end else begin
                    interval[cnt] <= counter;
                end
                counter <= 0;
            end
        end
    end

    
    ///////////////////////////////////////////////////////////////////////////////////////
    //reading
     //reading part
        reg clkout;
         reg [31:0] cnt_clk; //the get the clkout
         reg [5:0] cnt_note;
         reg [3:0] cnt_interval;
         
         reg [4:0] music0;
         
         parameter period3 = 200_000_00;
         //parameter period3 = 100_0000;
         //build a .1s clk
             always @(posedge clk, negedge rst)
         begin
             if(~rst) begin
                 cnt_clk<= 0;
                 clkout <= 0;
             end else if(cnt_clk == (period3 >>1) -1) begin
                 clkout <= ~clkout;
                 cnt_clk <= 0;
             end else
                 cnt_clk <= cnt_clk +1;
                 led2[0] <= cnt_clk;
         end 
        
         
         
         always @(posedge clkout, negedge rst) begin
             if(~rst) begin
                 music0 <= 5'b0;
                 cnt_note <= 0;
                 cnt_interval <= 0;
             end else if(en) begin
                if(state == play) begin
                music0 <= music[cnt_note];
                 led2[7] <= 1;
                 if(music[cnt_note] == 0) begin  
                     cnt_interval <= cnt_interval + 2;
                     led2[1] <= 1;
                     end
                 if(cnt_interval < interval[cnt_note] & music[cnt_note] !== 0)begin
                     cnt_interval <= cnt_interval + 1;
                     led2[1] <= 1;
                 end else if(cnt_interval == interval[cnt_note])begin
                    cnt_note <= cnt_note + 1;
                    cnt_interval <= 0;
                 end 
             end 
//             else if(state == pause) begin
//                     cnt_note <= cnt_note;
//                     music0 <= 5'b0;
//                     led2[3] <= 1;
//             end 
             else if(state == idle | state == record) begin
                 music0 <= 5'b0;
             end
             end
         end
         
         wire [11:0]frequency;
         
         music_to_frequency mtf(clk, music0, frequency);
         generate_melody gm(clk, frequency, pwm2);
         //autoplay_led al(clk, rst, music0, led2, ledrange2);
         
         free_play_top fpt(1,clk,rst,{btn_up, btn_center, btn_down},sw,pwm1,led1,ledrange1,seg_en1,seg_outl1, seg_outr1);
         store_music sm(clk, sw, octave, music1);

endmodule
