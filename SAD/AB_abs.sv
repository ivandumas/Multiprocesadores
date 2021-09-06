module AB_abs (
    input logic [7:0] A_data,
    input logic [7:0] B_data,
    output logic [7:0] abs
);

	always_comb 
		begin
			if (A_data > B_data)
				abs = A_data - B_data;
			else
				abs = B_data - A_data;
		end

endmodule 