module instmem
#(parameter SIZE = 63)( //Scalable design to meet the need of the application and save resources
   input logic clk,rst,
	input logic [31:0] read_addr, 
   output logic [31:0] inst
);

   integer i;
   logic [31:0] mem_array [0:SIZE];

   always_comb begin : blockName
      mem_array[0]=32'h018A5020;
      mem_array[1]=32'h0000_0000;
   end

   always_ff @(posedge clk ) begin : InstructionMemory
      if (rst) begin
         for(i = 0; i <= SIZE; i = i+1)
            mem_array[i] <= 0;
         inst <= 0;
      end 
      else begin
         inst <= mem_array[read_addr];
      end
   end
		
endmodule
