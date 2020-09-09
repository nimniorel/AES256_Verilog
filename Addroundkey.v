`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2020 05:29:10 PM
// Design Name: 
// Module Name: Addroundkey
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


module Addroundkey(input [127:0] data,input [127:0] roundkey,
output [127:0] dataout);
assign dataout=data^roundkey;
endmodule
