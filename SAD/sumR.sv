module sumR(
	input logic rst,
	input logic clk,
	input logic sum_clr,
	input logic sum_ld,
	input logic [31:0] sum,
	output logic [31:0] sumF
);

	always_ff @ (posedge clk)
	begin
		if (rst|sum_clr)
			sumF <= '0;
		else if (sum_ld)
			sumF <= sum;
		//else
			//sumF <= sumF;
	end

endmodule 