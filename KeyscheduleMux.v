`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2020 05:39:22 PM
// Design Name: 
// Module Name: KeyscheduleMux
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


module KeyscheduleMux(input [127:0] msbkey,input [127:0] lsbkey,
input[127:0] kg_feedback_msb,input[127:0] kg_feedback_lsb,input[1:0] sel,output [127:0] Keyschedule);
reg[127:0] temp;
always@(*)begin
case (sel) 
2'b00:temp<=msbkey;
2'b01:temp<=lsbkey;
2'b10:temp<=kg_feedback_msb;
2'b11:temp<=kg_feedback_lsb;
endcase
end
assign Keyschedule= temp;
endmodule
