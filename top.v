`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2020 12:54:20 PM
// Design Name: 
// Module Name: top
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


module top(input[127:0]Datain,input[255:0]Key,input clk,input rst,input start,output[127:0] CipherText );
reg[127:0] datain_DFF;
wire[127:0] rnddata;
wire selectdata;
wire selmsb,sellsb;
wire[127:0] outmuxdata_input_ark;
wire[127:0] outmuxkeyschedule_input_ark;
//wire[127:0] outkeygeneration_input_KeyscheduleMux;
wire [1:0] selkeyschedule;
wire[127:0] outark_input_sb;
reg [127:0] CipherText;////d/fdf/d/f/df
wire [127:0] outsb_input_sr;
wire [127:0] outsr_input_mc;
wire [127:0] outmc_input_mux_finalrnd;
wire selectmix;
wire [3:0] count;
wire [127:0] keyout_msb;
wire [127:0] keyout_lsb;
wire [127:0] out_mux_srcup;
wire [127:0] out_mux_srclo;


inputMux inmux1(.datain(datain_DFF),.rnddata(rnddata),.sel(selectdata),.dataout(outmuxdata_input_ark));

KeyscheduleMux keymux1(.msbkey(Key[255:128]),.lsbkey(Key[127:0])
,.kg_feedback_msb(keyout_msb)
,.kg_feedback_lsb(keyout_lsb)
,.sel(selkeyschedule),.Keyschedule(outmuxkeyschedule_input_ark));

inputMux a0(.datain(Key[255:128]),.rnddata(keyout_msb),.sel(selmsb),.dataout(out_mux_srcup));
inputMux a1(.datain(Key[127:0]),.rnddata(keyout_lsb),.sel(sellsb),.dataout(out_mux_srclo));

Keyschedule ks(.rc(count),.srcup(out_mux_srcup),.srclo(out_mux_srclo),.clk(clk),.keyoutup(keyout_msb),.keyoutlo(keyout_lsb));

Addroundkey ark1(.data(outmuxdata_input_ark),.roundkey(outmuxkeyschedule_input_ark)
,.dataout(outark_input_sb));



subbytes sb1 (.data(CipherText),.sb(outsb_input_sr));


ShiftRows sr1 (.sb(outsb_input_sr),.sr(outsr_input_mc));


Mixcolumns mc1(.data(outsr_input_mc),.mc(outmc_input_mux_finalrnd));

inputMux muxfinalrnd(.datain(outmc_input_mux_finalrnd),.rnddata(outsr_input_mc),.sel(selectmix),.dataout(rnddata));


control con1 (.clk(clk),.rst(rst),.start(start),.selmixcol(selectmix),.seldata(selectdata)
,.selkeyschedule(selkeyschedule),.roundcount(count),.selmsb(selmsb),.sellsb(sellsb));




always@(posedge clk,posedge rst) begin
    if(rst==1) begin
    CipherText<=0;
    datain_DFF<=0;
    end
    else begin
    CipherText<=outark_input_sb;
    datain_DFF<=Datain;
    end   
end


endmodule
