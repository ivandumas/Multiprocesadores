module mips (
    input clk,rst
);

logic RegWrite,ALUOp,RegDst,MemRead,MemWrite,ALUSrc,MemToReg,PCSrc,zero,ALUCtrl;
logic [5:0] func, opcode;

datapath Datapath(
    .clk(clk),
    .rst(rst),
    .*
);

controlunit ControlUnit(
    .clk(clk),
    .rst(rst),
    .*
);

ALUcontrol ALUControl(
    .*
);

endmodule