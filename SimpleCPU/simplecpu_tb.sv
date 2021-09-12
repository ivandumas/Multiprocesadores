`timescale 1ns / 1ps
module simplecpu_tb;

	// Inputs
	logic clk;
	logic rst;
	logic [9:0] pc;
	
	integer i;
	logic [31:0] dmem [0:127];
	logic [15:0] randdata;
	// Instantiate the Unit Under Test (UUT)
	simplecpu uut (
		.clk(clk), 
		.rst(rst),
		.pc(pc)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#11;
      		rst = 0; 
		
		// INIT 
		//for ( i=0 ; i<32 ;i = i + 1)begin
			//uut.dpt.registros.mem[i] = i;
			//end
			
		for ( i=0 ; i<256 ;i = i + 1) begin
			randdata = $random();
			uut.datamemory.mem_array[i] = {8'h0,randdata[7:0]};  
			end	
			
		uut.instmem.mem_array[0] = 16'b0000_0001_00000001;
		uut.instmem.mem_array[1] = 16'b0000_0010_00000010;
		uut.instmem.mem_array[2] = 16'b0000_0011_00000011;
		uut.instmem.mem_array[3] = 16'b0000_0100_00000100;
		uut.instmem.mem_array[4] = 16'b0000_0101_00000101;
		uut.instmem.mem_array[5] = 16'b0000_0110_00000110;
		uut.instmem.mem_array[6] = 16'b0000_0111_00000111;
		uut.instmem.mem_array[7] = 16'b0000_0001_00001000;
		uut.instmem.mem_array[8] = 16'b0000_0010_00001001;
		uut.instmem.mem_array[9] = 16'b0000_0011_00001010;
		uut.instmem.mem_array[10] = 16'b0000_0100_00001011;
		uut.instmem.mem_array[11] = 16'b0000_0101_00001100;
		uut.instmem.mem_array[12] = 16'b0000_0110_00001101;
		uut.instmem.mem_array[13] = 16'b0000_0111_00001110;
		uut.instmem.mem_array[14] = 16'b0010_0001_0010_0011;
		uut.instmem.mem_array[15] = 16'b0010_0100_0101_0110;


		
		#20000

		for ( i=0 ; i<256 ;i = i + 1)begin
			dmem[i] = uut.datamemory.mem_array[i];
		end	
	
	// DUMP del log
	
		$writememh("regbank.hex", uut.execunit.RegBank.mem);
		$writememh("memory.hex", dmem);
		
		
			
	// CHECKER
	//		for ( i=0 ; i<132 ;i = i + 1)begin
	//			error = error + (uut.dpt.registros.mem[i] != tb_regbank[i]);
	//		end	
	
	$finish();
	
	end
      
   always forever #2 clk = ~clk;		

/*
   intial begin
	
       while (1) begin   
   		// reference model
		
		logic 	[16:0] tb_regbank [16:0];	
		logic	[15:0] tb_instruction;
			
			//  monitor para leer la instrucción
			if(uut.instmem.ren)
				tb_instruction = uut.instmem.data_out;


			opcode = tb_instruction[15:12];
			result_ptr = (inst_type) == R ? tb_instruction[20:15] : tb_instruction[26:21];
			
			case ( opcode ) begin
				add: tb_result = tb_a + tb_b;
				sub: tb_result = tb_a - tb_b; 			
			endcase
	
				tb_regbank[result_ptr] = tb_result;
      end
   
   end
*/   
 endmodule


