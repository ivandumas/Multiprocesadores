module sad (
	input  logic [8:0]	A_data,
    input  logic [8:0]	B_data,
	input  logic 			go,
    input  logic 			clk,
    input  logic 			rst,
    output  logic [9:0]		AB_addr,
    output  logic 			AB_rd,
	output logic [31:0]  	sad);


    controller control(.go(go),.i_lt_256(i_lt_256),.AB_rd(AB),
i_inc,
i_clr,
sum_ld,
sum_clr,
sadreg_ld,
sadreg_clr);

 
endmodule
