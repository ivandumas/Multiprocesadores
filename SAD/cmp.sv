module cmp(
	input logic [8:0] AB_addr,
	output logic i_lt_256
);

	always_comb begin
		i_lt_256 = 9'h100 > AB_addr;
	end

endmodule