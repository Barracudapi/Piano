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
       1:q=47773; //523.3HZ��do
       2:q=42567; //587.3HZ ��ri          
       3:q=37919; //659.3HZ ��mi        
       4:q=35790; //698.5HZ ��fa
       5:q=31887; //784HZ ��so      
       6:q=28409; //880HZ ��la            
       7:q=25308; //987.8HZ ��xi
       8:q=23914; //1045.4HZ ��do      
       9:q=21282; //1174.7HZ ��ri         
       10:q=18960; //1318.5HZ ��mi
       11:q=17904; //1396.3HZ ��fa         
       12:q=15943; //1568HZ ��so           
       13:q=14204; //1760HZ ��la              
       14:q=12655; //1975.5HZ ��xi          
       15:q=95565; //261.6HZ ��do
       16:q=85120; //293.7HZ ��ri           
       17:q=75849; //329.6HZ ��mi 
       18:q=71592; //349.2HZ ��fa               
       19:q=63775; //392HZ ��so                  
       20:q=56818; //440HZ ��la              
       21:q=50617; //493.9HZ ��xi                                   
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
