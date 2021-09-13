module ALUcontrol (
    input logic [5:0] func,
    input logic [1:0] ALUOp,
    output logic [2:0] ALUCtrl
);

always_comb begin : FunctionControl
    case (ALUOp)
        2'b00 : begin 
				case (func)
					5'b00000: ALUCtrl = 3'b000;
					default : ALUCtrl = 3'b000;
				endcase
				end
        2'b01 : ALUCtrl = 3'b000;
        2'b10 : ALUCtrl = 3'b000;
        2'b11 : ALUCtrl = 3'b000;
        default : ALUCtrl = 3'b000;
    endcase
end
    
endmodule