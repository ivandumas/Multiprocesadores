module instmem(
	input logic [31:0] read_addr, 
   output logic [31:0] inst
);

   
   logic [31:0] mem_array [0:1023];

   // always_comb begin : blockName
   //     mem_array[0]=32'h0000_0000;
   //     mem_array[1]=32'h0000_0000;
   // end
   
   always_comb inst = mem_array[read_addr];
		
endmodule
