module datamux (
    input logic [15:0] a,b,c,
    input logic s0,s1,
    output logic [15:0] out
);
	// MUX Behavioral Description
	always_comb begin : Threeto1mux
        case ({s1,s0})
            0'b00 : out <= a;
            0'b01 : out <= b;
            0'b10 : out <= c;
            default : out <= '0;
        endcase
    end
    
endmodule