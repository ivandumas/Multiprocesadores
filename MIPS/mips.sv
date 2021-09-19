module mips (
    input clk,rst
);

logic RegWrite,RegDst,MemRead,MemWrite,ALUSrc,MemToReg,PCSrc,zero,Branch;
logic [2:0] ALUOp;
logic [1:0] ALUCtrl;
logic [5:0] func, opcode;

datapath Datapath(.*);

controlunit ControlUnit(.*);

ALUcontrol ALUControl(.*);

endmodule