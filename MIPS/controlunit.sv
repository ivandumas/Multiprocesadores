typedef enum logic [2:0]
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
    //input logic  [5:0] func,
    input logic  [5:0] opcode,
    input logic zero,
    output logic RegWrite, 
    output logic RegDst, 
    output logic Branch,
    output logic ALUSrc,
    output logic [1:0 ]ALUOp,
    output logic MemRead,
    output logic MemWrite,
    output logic MemToReg,
    output logic PCSrc
);

opcodes op;

        always_ff @( posedge rst ) begin : reset
            Branch = 0;
            RegDst = 0';
            RegWrite = 0';
            ALUSrc = 0';
            ALUOp = 0';
            MemWrite = 0';
            MemRead = 0';
            MemToReg = 0';
            PCSrc = 0;
        end

	// FSM COMBINATORIAL LOGIC;   STATE TRANSITION LOGIC
		always_comb begin
            op <= opcode;
			case (op)
				RType:begin
                    Branch = 0;
                    RegDst = 1;
                    RegWrite = 1;
                    ALUSrc = 0;
                    ALUOp = 2'b00;
                    MemWrite = 0;
                    MemRead = 0;
                    MemToReg = 0;
                end
                ADDI: begin
                    Branch = 0;
                    RegDst = 0;
                    RegWrite = 1;
                    ALUSrc = 1;
                    ALUOp = 2'b01;
                    MemWrite = 0;
                    MemRead = 0;
                    MemToReg = 0;
                end
                LW: begin
                    Branch = 0;
                    RegDst = 0;
                    RegWrite = 1;
                    ALUSrc = 1;
                    ALUOp = 2'b01;
                    MemWrite = 0;
                    MemRead = 1;
                    MemToReg = 1;
                end
                SW: begin
                    Branch = 0;
                    RegDst = 0;
                    RegWrite = 0;
                    ALUSrc = 1;
                    ALUOp = 2'b01;
                    MemWrite = 1;
                    MemRead = 0;
                    MemToReg = 0;
                end
                BEQ: begin
                    Branch = 1;
                    RegDst = 0;
                    RegWrite = 0;
                    ALUSrc = 0;
                    ALUOp = 2'b10;
                    MemWrite = 0;
                    MemRead = 0;
                    MemToReg = 0;
                    PCSrc = (zero==1);
                end
                JMP: begin
                    Branch = 1;
                    RegDst = 0;
                    RegWrite = 0;
                    ALUSrc = 1;
                    ALUOp = 2'b11;
                    MemWrite = 1;
                    MemRead = 0;
                    MemToReg = 0;
                end
                default: begin
                    Branch = 0;
                    RegDst = 0;
                    RegWrite = 0;
                    ALUSrc = 0;
                    ALUOp = 2'b00;
                    MemWrite = 0;
                    MemRead = 0;
                    MemToReg = 0;
                    PCSrc = 0;
                end
			endcase
		end
    
endmodule