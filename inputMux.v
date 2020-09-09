`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2020 05:55:25 PM
// Design Name: 
// Module Name: inputMux
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


module inputMux(input[127:0] datain,input[127:0] rnddata,
input sel,output [127:0] dataout );
assign dataout = sel ? rnddata:datain;


endmodule
