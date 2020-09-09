`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2020 09:42:23 AM
// Design Name: 
// Module Name: control
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


module control(input clk,input rst,input start,output selmixcol,
output seldata,
output [1:0] selkeyschedule,
output selmsb,sellsb,
output [3:0] roundcount );
parameter IDLE  = 3'b111,ROUND0 = 3'b000,ROUND1 = 3'b001,ROUND2_13 = 3'b010,FINALROUND=3'b011 ;
reg[3:0] count;
reg[3:0] CS;
reg[3:0] NS;
reg temp_selmixcol,temp_seldata,temp_selmsb,temp_sellsb;
reg[1:0] temp_selkeyschedule;
always @ (posedge clk,posedge rst)
begin  
if (rst == 1'b1) begin
    CS <=IDLE;
    count<=0;
    end
   else begin
    CS <= NS;
    count<=count+1;
    end
 end
always@(CS,start,count) begin
case(CS)
IDLE: if(start==1)begin
        NS<=ROUND0;
        end
        else
        NS<=IDLE;
ROUND0: NS<=ROUND1;       
ROUND1: NS<=ROUND2_13;
ROUND2_13: if(count==13)
            NS<=FINALROUND;
            else
            NS<=ROUND2_13;
FINALROUND: NS<=IDLE;
endcase
end
always@(CS,count) begin 
case (CS)
IDLE:   begin
 temp_selmsb<=0;
 temp_sellsb<=0;
 temp_selmixcol<=0;
 temp_seldata<=0;
 temp_selkeyschedule<=0;
end 
ROUND0: begin  
    count<=0;
    temp_selmsb<=0;
    temp_sellsb<=0;
    temp_seldata<=0; 
    temp_selmixcol<=0;   
    temp_selkeyschedule=0;
    end 
ROUND1: begin  
    temp_selmsb<=0;
    temp_sellsb<=0;
    temp_seldata<=1; 
    temp_selmixcol<=0;   
    temp_selkeyschedule=1;
    end
ROUND2_13: begin  
    temp_seldata<=1; 
    temp_selmixcol<=0; 
    if(count[0]==0) begin
     temp_selkeyschedule=2;
     end else begin
        temp_selkeyschedule=3;
        end
    temp_selmsb<=1;
    if(count==2)begin
    temp_sellsb<=0;
    end
    else begin
    temp_sellsb<=1;
    end
    end      
FINALROUND: begin  
    temp_seldata<=1; 
    temp_selmixcol<=1;   
    temp_selkeyschedule=2;
    temp_selmsb<=1;
    temp_sellsb<=1;  
    end
default: begin  
    temp_seldata<=0; 
    temp_selmixcol<=0;   
    temp_selkeyschedule=0;  
    temp_selmsb<=0;
    temp_sellsb<=0;
    end
endcase
end
assign roundcount=count;  
assign seldata=temp_seldata; 
assign selmixcol = temp_selmixcol;   
assign selkeyschedule = temp_selkeyschedule;  
assign selmsb=temp_selmsb;
assign sellsb=temp_sellsb;
endmodule
