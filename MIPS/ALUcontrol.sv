module ALUcontrol (
    input   logic [5:0] func,
    input   logic [1:0] ALUCtrl,
    output  logic [2:0] ALUOp
);

always_comb begin : FunctionControl
    case (ALUCtrl)
        2'b00 : begin 
				case (func)
					6'b100000: ALUOp = 3'b010; //ADD
                    6'b100010: ALUOp = 3'b110; //SUB
                    6'b100100: ALUOp = 3'b000; //AND
                    6'b100101: ALUOp = 3'b001; //OR
                    6'b101010: ALUOp = 3'b111; //SLT
					default : ALUOp = 3'b000;
				endcase
				end
        2'b01 : ALUOp = 3'b010; //LW, SW
        2'b10 : ALUOp = 3'b110; //BEQ, JMP
        2'b11 : ALUOp = 3'b000; //nada
        default : ALUOp = 3'b000;
    endcase
end
    
endmodule