`timescale 1ns / 1ps
module mips_tb;

	logic clk;
	logic rst;
	
	mips MIPS_final(
	.clk(clk),
	.rst(rst)
	);
	
	initial begin
	clk = 0;
	rst = 1;
	
	#3;
    rst = 0;

		//Cargar datos a los registros
	  MIPS_final.Datapath.Registers.mem_array[0]=32'h0000_0002;
      MIPS_final.Datapath.Registers.mem_array[1]=32'h0000_0004;
	  MIPS_final.Datapath.Registers.mem_array[2]=32'h0000_0006;
      MIPS_final.Datapath.Registers.mem_array[3]=32'h0000_0003;
	  MIPS_final.Datapath.Registers.mem_array[4]=32'h0000_0001;
      MIPS_final.Datapath.Registers.mem_array[5]=32'h0000_0008;


		//Cargar instrucciones
	  MIPS_final.Datapath.InstructionMemory.mem_array[0]=32'h000821020; // suma r2 = r4 + r2
	  MIPS_final.Datapath.InstructionMemory.mem_array[1]=32'h000821020;
	  MIPS_final.Datapath.InstructionMemory.mem_array[2]=32'h000821020;
	  MIPS_final.Datapath.InstructionMemory.mem_array[3]=32'h000821020;
	  MIPS_final.Datapath.InstructionMemory.mem_array[4]=32'h000821020;
	  MIPS_final.Datapath.InstructionMemory.mem_array[5]=32'h000821020;
	  MIPS_final.Datapath.InstructionMemory.mem_array[6]=32'h000821020;
	  MIPS_final.Datapath.InstructionMemory.mem_array[7]=32'hFFFF_FFFF;
	  MIPS_final.Datapath.InstructionMemory.mem_array[8]=32'hFFFF_FFFF;
	  MIPS_final.Datapath.InstructionMemory.mem_array[9]=32'hFFFF_FFFF;
	  MIPS_final.Datapath.InstructionMemory.mem_array[10]=32'hFFFF_FFFF;
	
	end
	
	
	always forever #1 clk = ~clk;
	
endmodule
