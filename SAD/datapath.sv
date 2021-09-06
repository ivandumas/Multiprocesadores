module datapath(
	input logic rst,
	input logic clk,
	input logic i_inc,
	input logic i_clr,
	input logic sum_ld,
	input logic sum_clr,
	input logic sad_reg_ld,
	input logic [7:0] A_data,
	input logic [7:0] B_data,
	output logic [8:0] AB_addr,
	output logic [31:0] sad,
	output logic i_lt_256
);

 // Counter i
icounter count(.rst(rst), .clk(clk), .i_clr(i_clr), .i_inc(i_inc), .AB_addr(AB_addr));
			
// Comparer
cmp comp(.AB_addr(AB_addr), .i_lt_256(i_lt_256));
	
// Absolute Difference
logic [7:0] diff;
AB_abs abab(.A_data(A_data), .B_data(B_data), .abs(abs));

// Sum Block
logic [31:0] sum;
logic [31:0] sumF;
sumB smB(.abs(abs), .sad(sad), .sum(sum));
sumR smR(.rst(rst), .clk(clk), .sum_clr(sum_clr), .sum_ld(sum_ld), .sum(sum), .sumF(sumF));

// SAD Register
sadR saR(.rst(rst), .clk(clk), .sad_reg_ld(sad_reg_ld),.sumF(sumF), .sad(sad));

		
endmodule