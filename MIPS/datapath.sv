module datapath (
    input logic clk,rst,
    input logic RegWrite,AluOp,RegDst,MemRead,MemWrite,AluSrc,MemToReg

);

logic [31:0] instruction;
logic [11:0] pc_fetch;
logic [31:0] toW_data,toA,toB,r_data2,alu_out,toMemMux;
logic [4:0] toW_reg;

pc InstFetch(
	.clk(clk),
	.pc(pc_fetch)
);

instmem IntructionMemory(
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

always_comb begin : muxtoALU
    toB = (AluSrc) ? {16'h0000,instruction[15:0]} : r_data2;
end

alu ALU(
    .aluOp(AluOp), //Control signal
    .a(toA),
    .b(toB),
    .out(alu_out)
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
    toW_data = (MemToReg) ? alu_out : toMemMux;
end
    
endmodule