module sumB(
	input logic [7:0] abs,
	input logic [31:0] sad,
	output logic [31:0] sum
);
	
	always_comb begin
		sum = sad + abs;
	end

endmodule 