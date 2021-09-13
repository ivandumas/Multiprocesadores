module alu (
    input logic [2:0] aluOp,
    input logic [31:0] a,b,
    output logic [31:0] out
);

always_comb begin : AluMux
    case (aluOp)
        3'b000 : out <= a & b;
        3'b001 : out <= a | b;
        3'b010 : out <= a + b;
        3'b110 : out <= a - b;
        3'b111 : out <= (a < b) ? 32'h0000_0001 : 32'h0000_0000;
        default: out <= 32'hzzzz_zzzz;
    endcase
end
    
endmodule