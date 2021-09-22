typedef enum logic [5:0]
{
	RType       =       6'h00,
    ADDI        =       6'h08,
    LW          =       6'h23,
    SW          =       6'h2B,
    BEQ         =       6'h04,
    JMP         =       6'h02
} opcodes;

module controlunit (
    input logic clk,rst,
    //input logic  [5:0] func, // in this design the func part of the instruction is received by the ALU-controller
    input logic [5:0] opcode,
    input logic zero,
    output logic RegDst,
    output logic Branch,
    output logic MemRead,
    output logic MemToReg,
    output logic [1:0]ALUCtrl,
    output logic MemWrite,
    output logic ALUSrc,
    output logic RegWrite,
    output logic PCSrc
);


opcodes op;

	// Control Signals
		always_comb begin
		Branch      = '0; //Initial values
		RegDst      = 'X;
		RegWrite    = 'X;
		ALUSrc      = 'X;
		ALUCtrl     = 2'b00;
		MemWrite    = 'X;
		MemRead     = 'X;
		MemToReg    = 'X;
		PCSrc       = '0;
				
			case (opcode)
					RType: begin
                        Branch    = 1'b0;
                        RegDst    = 1'b1;
                        RegWrite  = 1'b1;
                        ALUSrc    = 1'b0;
                        ALUCtrl   = 2'b00;
                        MemWrite  = 1'b0;
                        MemRead   = 1'b0;
                        MemToReg  = 1'b0;
					end
                    ADDI: begin
                        Branch  = 1'b0;
                        RegDst  = 1'b0;
                        RegWrite = 1'b1;
                        ALUSrc = 1'b1;
                        ALUCtrl = 2'b01;
                        MemWrite = 1'b0;
                        MemRead = 1'b0;
                        MemToReg = 1'b0;
                    end
                    LW: begin
                        Branch = 1'b0;
                        RegDst = 1'b0;
                        RegWrite = 1'b1;
                        ALUSrc = 1'b1;
                        ALUCtrl = 2'b01;
                        MemWrite = 1'b0;
                        MemRead = 1'b1;
                        MemToReg = 1'b1;
                    end
                    SW: begin
                        Branch = 1'b0;
                        RegDst = 1'b0;
                        RegWrite = 1'b0;
                        ALUSrc = 1'b1;
                        ALUCtrl = 2'b01;
                        MemWrite = 1'b1;
                        MemRead = 1'b0;
                        MemToReg = 1'b0;
                    end
                    BEQ: begin
                        RegDst = 1'b0;
                        RegWrite = 1'b0;
                        ALUSrc = 1'b0;
                        ALUCtrl = 2'b10;
                        MemWrite = 1'b0;
                        MemRead = 1'b0;
                        MemToReg = 1'b0;
                        PCSrc = 1'b0;
                        Branch = (zero=='1);
                    end
                    JMP: begin
                        PCSrc = 1'b1;
                        RegDst = 1'b0;
                        RegWrite = 1'b0;
                        ALUSrc = 1'b1;
                        ALUCtrl = 2'b10;
                        MemWrite = 1'b0;
                        MemRead = 1'b0;
                        MemToReg = 1'b0;
                    end
                    default: begin
                        Branch = 1'b0;
                        RegDst = 1'b0;
                        RegWrite = 1'b0;
                        ALUSrc = 1'b0;
                        ALUCtrl = 2'b00;
                        MemWrite = 1'b0;
                        MemRead = 1'b0;
                        MemToReg = 1'b0;
                        PCSrc = 1'b0;
                    end
			endcase
		end
    
endmodule