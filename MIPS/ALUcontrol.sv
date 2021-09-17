module ALUcontrol (
    input   logic [5:0] func,
    input   logic [1:0] ALUCtrl,
    output  logic [2:0] ALUOp
);

always_comb begin : FunctionControl
    case (ALUCtrl)
        2'b00 : begin 
				case (func)
					5'b00000: ALUOp = 3'b000;
					default : ALUOp = 3'b000;
				endcase
				end
        2'b01 : ALUOp = 3'b000;
        2'b10 : ALUOp = 3'b000;
        2'b11 : ALUOp = 3'b000;
        default : ALUOp = 3'b000;
    endcase
end
    
endmodule