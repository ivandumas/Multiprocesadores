module instmem
#(parameter SIZE = 1023)( //Scalable design to meet the need of the application and save resources
   input logic clk,rst,
	input logic [31:0] read_addr, 
   output logic [31:0] inst
);

   
   logic [31:0] mem_array [0:SIZE];

   // always_comb begin : blockName
   //     mem_array[0]=32'h0000_0000;
   //     mem_array[1]=32'h0000_0000;
   // end

   always @(posedge clk ) begin
      inst <= mem_array[read_addr];
   end
		
endmodule
