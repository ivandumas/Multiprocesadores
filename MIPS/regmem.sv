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

	always_comb begin : blockName
      mem_array[0]=32'h0000_0002;
      mem_array[1]=32'h0000_0004;
	  mem_array[2]=32'h0000_0006;
      mem_array[3]=32'h0000_0003;
	  mem_array[4]=32'h0000_0001;
      mem_array[5]=32'h0000_0008;
   end

      always_ff @(posedge clk) begin : RegMem
         if (rst) begin 
            for(i = 0; i <= SIZE; i = i+1)
               mem_array[i] <= 0;
         end 
			else if (regWrite) begin
            mem_array[W_reg] <= W_data;
         end
      end

      always_comb begin : RegRead
         if (rst) begin
            R_data1 <= 0;
            R_data2 <= 0;
         end else begin
            R_data1 <= mem_array[R_reg1];
            R_data2 <= mem_array[R_reg2];
         end
      end

		
endmodule
