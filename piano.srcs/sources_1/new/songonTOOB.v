`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/11 22:43:11
// Design Name: 
// Module Name: songonTOOB
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


module songonTOOB(
input [1:0] counter,
output reg [7:0] tub_sel 
    );
    wire [7:0] ctrl1, ctrl2, ctrl3, ctrl4, ctrl5;
    wire [7:0] ctrl6, ctrl7, ctrl8, ctrl9, ctrl10;
    wire [7:0] ctrl11, ctrl12, ctrl13, ctrl14, ctrl15;
    wire [7:0] ctrl16, ctrl17, ctrl18, ctrl19, ctrl20;
    wire [7:0] ctrl21, ctrl22, ctrl23, ctrl24, ctrl25, ctrl26;
    parameter A = 5'b00000, B = 5'b00001, C = 5'b00010, D= 5'b00011, E = 5'b00100;
    
    TOOB a(A, 1'b1, ctrl1); TOOB b(B, 1'b1, ctrl2); TOOB c(C, 1'b1, ctrl3); TOOB d(D, 1'b1, ctrl4); TOOB e(E, 1'b1, ctrl5);
    TOOB f(A, 1'b1, ctrl6); TOOB g(B, 1'b1, ctrl7); TOOB h(C, 1'b1, ctrl8); TOOB i(D, 1'b1, ctrl9); TOOB j(E, 1'b1, ctrl10);
    TOOB k(A, 1'b1, ctrl11); TOOB l(B, 1'b1, ctrl12); TOOB m(C, 1'b1, ctrl13); TOOB n(D, 1'b1, ctrl14); TOOB o(E, 1'b1, ctrl15);
    TOOB p(A, 1'b1, ctrl16); TOOB q(B, 1'b1, ctrl17); TOOB r(C, 1'b1, ctrl18); TOOB s(D, 1'b1, ctrl19); TOOB t(E, 1'b1, ctrl20);
    TOOB u(A, 1'b1, ctrl21); TOOB v(B, 1'b1, ctrl22); TOOB w(C, 1'b1, ctrl23); TOOB x(D, 1'b1, ctrl24); TOOB y(E, 1'b1, ctrl25); TOOB z(E, 1'b1, ctrl26);
    
    always @(*) begin
        case(counter)
            2'b01: begin
                tub_sel[0] = ctrl19;
                tub_sel[1] = ctrl5;
                tub_sel[2] = ctrl4;
                tub_sel[3] = ctrl7;
                tub_sel[4] = ctrl5;
                tub_sel[5] = ctrl5;
                tub_sel[6] = ctrl5;
                tub_sel[7] = ctrl5;
            end
            2'b10: begin
                tub_sel[0] = ctrl19;
                tub_sel[1] = ctrl5;
                tub_sel[2] = ctrl4;
                tub_sel[3] = ctrl7;
                tub_sel[4] = ctrl5;
                tub_sel[5] = ctrl5;
                tub_sel[6] = ctrl5;
                tub_sel[7] = ctrl5;
            end
            2'b11: begin
                tub_sel[0] = ctrl19;
                tub_sel[1] = ctrl5;
                tub_sel[2] = ctrl4;
                tub_sel[3] = ctrl7;
                tub_sel[4] = ctrl5;
                tub_sel[5] = ctrl5;
                tub_sel[6] = ctrl5;
                tub_sel[7] = ctrl5;
            end
            default:begin
                tub_sel[0] = ctrl19;
                tub_sel[1] = ctrl5;
                tub_sel[2] = ctrl4;
                tub_sel[3] = ctrl7;
                tub_sel[4] = ctrl5;
                tub_sel[5] = ctrl5;
                tub_sel[6] = ctrl5;
                tub_sel[7] = ctrl5;
            end
            endcase
            end
            
            
endmodule
