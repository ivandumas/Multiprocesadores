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
			
		uut.instmem.mem_array[0] = 16'h0005;
		uut.instmem.mem_array[1] = 16'h0106;
		uut.instmem.mem_array[2] = 16'h0207;
		uut.instmem.mem_array[3] = 16'h2001;
		uut.instmem.mem_array[4] = 16'h2002;
		uut.instmem.mem_array[5] = 16'h1005;
		uut.instmem.mem_array[6] = 16'hFFFF;
		uut.instmem.mem_array[7] = 16'hFFFF;

		
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
			
			//  monitor para leer la instrucci�n
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


