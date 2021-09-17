module regmem 
#(parameter SIZE = 31) //Scalable design to meet the need of the application and save resources (even though 32 reg is standard)
(
		input  logic 		clk,
		input  logic   		rst,
		input  logic [4:0]  R_reg1,R_reg2,W_reg,
		input  logic 		regWrite,
		input  logic [31:0]	W_data,
		output logic [31:0]	R_data1,R_data2
		);
	
	integer i;

  logic [31:0] mem_array [0:SIZE];

      always_ff @(posedge clk)
         begin
            if (rst)
				for(i = 0; i <= SIZE; i = i+1)
					mem_array[i] <= 0;
			else if (regWrite)
                mem_array[W_reg] <= W_data;
         end
		
		always_comb 
        begin
            R_data1 = mem_array[R_reg1];
            R_data2 = mem_array[R_reg2];
        end

		
endmodule
