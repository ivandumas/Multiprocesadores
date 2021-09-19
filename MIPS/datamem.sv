module datamem 
#(parameter SIZE = 1023)( //Scalable design to meet the need of the application and save resources
		input  logic 		clk,
		input  logic   		rst,
		input  logic [9:0] R_addr,W_addr,
		input  logic 		readMem,
		input  logic		writeMem,
		input  logic [31:0]	W_data,
		output logic [31:0]	R_data
		);

  logic [31:0] mem_array [0:SIZE];

      always_ff @(posedge clk)
         begin
              if (writeMem)
                   mem_array[W_addr] <= W_data;
         end
		
		always_comb R_data = readMem ? mem_array[R_addr] : 'Z;

		
endmodule
