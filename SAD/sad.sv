module sad(
input logic clk,
input logic rst,
input logic go,
input logic [7:0] A_data,
input logic [7:0] B_data,
output logic [8:0] AB_addr,
output logic [31:0] sad,
output logic AB_rd
);


logic i_lt_256;
logic i_inc;
logic i_clr;
logic sum_ld;
logic sum_clr;
logic sad_reg_ld;

// FSM
controller ctl(
.clk(clk), .rst(rst), .go(go), .i_lt_256(i_lt_256), .i_inc(i_inc), .i_clr(i_clr),
.sum_ld(sum_ld), .sum_clr(sum_clr), .sad_reg_ld(sad_reg_ld), .AB_rd(AB_rd)
);	

//DataPath
datapath dth(
.rst(rst), .clk(clk), .i_inc(i_inc), .i_clr(i_clr), .sum_ld(sum_ld),
.sum_clr(sum_clr), .sad_reg_ld(sad_reg_ld), .A_data(A_data), .B_data(B_data),
.AB_addr(AB_addr), .sad(sad), .i_lt_256(i_lt_256));


		
endmodule