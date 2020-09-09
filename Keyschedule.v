`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2020 03:24:53 PM
// Design Name: 
// Module Name: Keyschedule
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

module Keyschedule(input [3:0] rc,// round count
input [127:0]srcup,// prev key matrix
input [127:0]srclo,
input clk,
output [127:0] keyoutup,
output [127:0] keyoutlo);//round key
reg [127:0] tempup;
reg [127:0] templo;
 
   wire [31:0] w0,w1,w2,w3,w4,w5,w6,w7,tem,temroot;// tem root in sbox(rootword(w3)
   reg [31:0] keytemp0,keytemp1,keytemp2,keytemp3,keytemp4,keytemp5,keytemp6,keytemp7;
                 
       assign w0 = srcup[127:96];
       assign w1 = srcup[95:64];
       assign w2 = srcup[63:32];
       assign w3 = srcup[31:0];
       assign w4 = srclo[127:96];
       assign w5 = srclo[95:64];
       assign w6 = srclo[63:32];
       assign w7 = srclo[31:0];
       
always@(*)begin 
        //if(rc[0]==1)begin // even round but delayd by 1
            keytemp0 <= w0 ^ temroot ^ rcon(rc);
            keytemp1 <= w0 ^ temroot ^ rcon(rc)^ w1;
            keytemp2 <= w0 ^ temroot ^ rcon(rc)^ w1 ^ w2;
            keytemp3 <= w0 ^ temroot ^ rcon(rc)^ w1 ^ w2 ^ w3;
           // end 
      //  else begin // odd round but delayd by 1
            keytemp4 <= w4 ^ tem ;
            keytemp5 <= w4 ^ tem ^ w5;
            keytemp6 <= w4 ^ tem ^  w5 ^ w6;
            keytemp7 <= w4 ^ tem ^  w5 ^ w6 ^ w7;
       // end
       end
   always@(posedge clk) begin
   if(rc[0]==1)
   tempup<={keytemp0,keytemp1,keytemp2,keytemp3};
   else
   templo<={keytemp4,keytemp5,keytemp6,keytemp7};
   end
       sbox a1(.a(w7[23:16]),.c(temroot[31:24]));
       sbox a2(.a(w7[15:8]),.c(temroot[23:16]));
       sbox a3(.a(w7[7:0]),.c(temroot[15:8]));
       sbox a4(.a(w7[31:24]),.c(temroot[7:0]));
       
       sbox a5(.a(w3[31:24]),.c(tem[31:24]));
       sbox a6(.a(w3[23:16]),.c(tem[23:16]));
       sbox a7(.a(w3[15:8]),.c(tem[15:8]));
       sbox a8(.a(w3[7:0]),.c(tem[7:0]));
       
      assign keyoutup=tempup;
      assign keyoutlo=templo;
     function [31:0]	rcon; // rcon constant look-up table
      input	[3:0]	rc;
      case(rc)	
         4'h1: rcon=32'h01_00_00_00;
         4'h3: rcon=32'h02_00_00_00;
         4'h5: rcon=32'h04_00_00_00;
         4'h7: rcon=32'h08_00_00_00;
         4'h9: rcon=32'h10_00_00_00;
         4'hB: rcon=32'h20_00_00_00;
         4'hD: rcon=32'h40_00_00_00;
         default: rcon=32'h00_00_00_00;
       endcase

     endfunction

endmodule

