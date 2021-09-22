module datapath (
    input logic clk,rst,
    input logic RegWrite,RegDst,MemRead,MemWrite,ALUSrc,MemToReg,PCSrc,Branch,
	 input logic [2:0] ALUOp,
	output logic zero,
	output logic [5:0] func, opcode
);

logic [31:0] instruction,sign_extend;
logic [25:0] pc_jmp;
logic [31:0] pc_fetch;
logic [31:0] toW_data,toA,toB,r_data2,alu_out,toMemMux;
logic [4:0] toW_reg;

pc InstructionFetch(
	.clk(clk),
	.rst(rst), 
	.PCSrc(PCSrc),
	.Branch(Branch),
    .pc_offset(sign_extend),
	.pc_jmp(pc_jmp),
	.pc(pc_fetch)
);

instmem InstructionMemory(
	.clk(clk),
	.rst(rst),
	.read_addr(pc_fetch), 
    .inst(instruction)
); 

always_comb begin : muxW_reg
    toW_reg = (RegDst) ? instruction[15:11] : instruction[20:16];
end

regmem Registers(
		.clk(clk),
		.rst(rst),
		.R_reg1(instruction[25:21]),
        .R_reg2(instruction[20:16]),
        .W_reg(toW_reg),
		.regWrite(RegWrite), //Control signal
		.W_data(toW_data),
		.R_data1(toA),
        .R_data2(r_data2)
		);

always_comb begin : signExtend
	sign_extend = (instruction[15]==0) ? {16'h0000,instruction[15:0]} : {16'hFFFF,instruction[15:0]};
end

always_comb begin : muxtoALU
    toB = (ALUSrc) ? sign_extend : r_data2;
end

alu ALU(
    .ALUOp(ALUOp), //Control signal
    .a(toA),
    .b(toB),
    .out(alu_out),
	.zero(zero)
);

datamem DataMemory (
		.clk(clk),
		.rst(rst),
		.R_addr(alu_out),
        .W_addr(alu_out),
		.readMem(MemRead),
		.writeMem(MemWrite),
		.W_data(r_data2),
		.R_data(toMemMux)
		);

always_comb begin : muxMemToReg
    toW_data = (MemToReg) ? toMemMux : alu_out;
end

always_comb begin : assignations
	opcode = instruction[31:26];
	func = instruction[5:0];
	pc_jmp = instruction[25:0];
end
    
endmodule