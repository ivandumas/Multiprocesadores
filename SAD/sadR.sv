module sadR(
	input logic rst,
	input logic clk,
	input logic sad_reg_ld,
	input logic [31:0] sumF,
	output logic [31:0] sad
	);


	always_ff @ (posedge clk)
	begin
		if (rst)
			sad <= '0;
		else if (sad_reg_ld)
			sad <= sumF;
		end

endmodule 