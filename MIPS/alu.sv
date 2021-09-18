module alu (
    input logic [2:0] ALUOp,
    input logic [31:0] a,b,
    output logic [31:0] out,
    output logic zero
);

logic [31:0] res;

always_comb begin : ALU
    case (ALUOp)
        3'b000 : res = a & b;
        3'b001 : res = a | b;
        3'b010 : res = a + b;
        3'b110 : res = a - b;
        3'b111 : res = (a < b) ? 32'h0000_0001 : 32'h0000_0000;
        default: res = 32'hzzzz_zzzz;
    endcase
end

always_comb begin
    zero <= (res == '0) ? 1 : 0;
    out <= res;
end
    
endmodule