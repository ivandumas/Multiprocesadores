module datamux (
    logic input [15:0] a,b,c,
    logic input s0,s1,
    logic output [15:0] out
);

	// MUX Behavioral Description
	always_comb begin : 3to1mux
        case ({s1,s0})
            0'b00 : out <= a;
            0'b01 : out <= b;
            0'b10 : out <= c;
            default : out <= 0';
            default: 
        endcase
    end
    
endmodule