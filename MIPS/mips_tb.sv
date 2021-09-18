module mips_tb();

	reg clk;
	reg rst;
	
	mips MIPS_final(
	.clk(clk),
	.rst(rst)
	);
	
	initial begin
	clk = 0;
	rst = 1;
	
	#100
	rst = 0;
	
	end
	
	
	initial begin
	
		repeat(1000)
		#5 clk = ~clk;
		
	end
	
endmodule
