`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/25 18:39:06
// Design Name: 
// Module Name: music
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


module music(
 
 input clk,
 input [4:0] m,
 input M,
 output reg B=0 
    );
   integer q=0;
   integer p=0; 
    
   
   always@(posedge clk)
   begin
      case(m)
       1:q=47773; //523.3HZ中do
       2:q=42567; //587.3HZ 中ri          
       3:q=37919; //659.3HZ 中mi        
       4:q=35790; //698.5HZ 中fa
       5:q=31887; //784HZ 中so      
       6:q=28409; //880HZ 中la            
       7:q=25308; //987.8HZ 中xi
       8:q=23914; //1045.4HZ 高do      
       9:q=21282; //1174.7HZ 高ri         
       10:q=18960; //1318.5HZ 高mi
       11:q=17904; //1396.3HZ 高fa         
       12:q=15943; //1568HZ 高so           
       13:q=14204; //1760HZ 高la              
       14:q=12655; //1975.5HZ 高xi          
       15:q=95565; //261.6HZ 低do
       16:q=85120; //293.7HZ 低ri           
       17:q=75849; //329.6HZ 低mi 
       18:q=71592; //349.2HZ 低fa               
       19:q=63775; //392HZ 低so                  
       20:q=56818; //440HZ 低la              
       21:q=50617; //493.9HZ 低xi                                   
     endcase    
 end
 
 always@(posedge clk)      
   begin
         if((p>=q)&M) 
         begin
         p=0; B=~B;
         end
         else if(M)
         p=p+1;
         else 
         B=0;         
   end 
            
endmodule
