module icounter(
	input logic rst,
	input logic clk,
	input logic i_clr,
	input logic i_inc,
	output logic [8:0] AB_addr
);

	always_ff @ (posedge clk)
		if (rst|i_clr)
			AB_addr <= 9'b0;
		else if (i_inc)
			AB_addr <= AB_addr + 1'b1;
		else 
			AB_addr <= AB_addr;

endmodule 