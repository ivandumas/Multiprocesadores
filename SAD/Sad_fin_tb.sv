module Sad_fin_tb(); 
  
	logic go;
	logic rst;
	logic clk;
	logic [8:0]A;
	logic [8:0]B;
	logic [8:0] AB_addr;
	logic AB_rd;
	logic [31:0] sad;
	///////
  logic [15:0] memA [255:0];
  logic [15:0] memB [255:0];
  integer i;
  
  sad uut(.A_data(A), .B_data(B), .go(go), .clk(clk),.rst(rst), .AB_addr(AB_addr),.AB_rd(AB_rd),.sad(sad));
  
  initial begin

  clk=0;
  rst=1;
  for(i = 0; i<256; i = i + 1) begin
      memA[i] = $random;
      memB[i] = memA[i];
  end  

  #10;
  
  memA[1] = 100;
  memB[1] = 60;
  
  memA[2] = 40;
  memB[2] = 100;
  
  memA[3] = -2;
  memB[3] = 2;
 
  memA[4] = 40;
  memB[4] = 20;
  
  memA[5] = 60;
  memB[5] = 0;
  
  memA[6] = 0;
  memB[6] = -1;
  
  memA[7] = -50;
  memB[7] = -25;
  
  memA[8] = 50;
  memB[8] = -25;
  
  memA[9] = -69;
  memB[9] = -0;
  
  #10
  rst = 0;
  #30;
	 
  go = 1;
  #30;
  
  go = 0;
  #30;
end  

initial begin
 forever #5 clk  = ~clk;
end
 
	// BFM   Pixel Array
always_comb begin
  A = memA[AB_addr];
  B = memB[AB_addr];
end
 
	// Reference model
	logic [ 4:0] addr_ref;
	logic [15:0] A_ref;
	logic [15:0] B_ref;
	logic [15:0] ABS_ref;
	logic [31:0] SAD_ref;
	
initial begin

	wait(go);
	addr_ref = 0;
	SAD_ref  = 0;
	ABS_ref  = 0;

	
	while (addr_ref < 16) begin // Change to 256 once you have confidence in your design
    A_ref = memA[addr_ref];
		B_ref = memB[addr_ref];
		ABS_ref = A_ref - B_ref;
		ABS_ref = ABS_ref[15] ? ~ABS_ref + 1 : ABS_ref;
		SAD_ref += ABS_ref;
		addr_ref = addr_ref + 1;
		@(clk); // rise
		@(clk); // fall
	end
	
end
 
endmodule

