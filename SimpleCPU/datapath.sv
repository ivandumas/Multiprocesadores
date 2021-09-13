module datapath (
	input  logic			clk,
	input  logic 			rst,
	input  logic			RF_s,
	input  logic [3:0]	RF_W_addr,
	input  logic			RF_W_wr,
	input  logic [3:0]	RF_Rp_addr,
	input  logic			RF_Rp_rd,
	input  logic [3:0]	RF_Rq_addr,
	input  logic 			RF_Rq_rd,
	input  logic 			alu_s0,
	input  logic [15:0]	DM_Din,
<<<<<<< HEAD
	input  logic [7:0]	Val_cons,
	input  logic			RF_cons,
	input  logic			RF_ext,
	output logic         RF_Rp_zero,
=======
>>>>>>> parent of 501942d (six instruction first commit)
	output logic [15:0]	Rp_data
	);

	
	logic [15:0]	muxout;	
	logic [15:0]	valCte;//Señal cargar valor cte
	logic [15:0]	negative;//Señal negar el valor
	
	
	//logic [15:0]	Rp_data;  // Already declared in the Module Output Pin port 
	logic [15:0]	Rq_data;
	logic [15:0]	alu_res;
	
<<<<<<< HEAD
	
		// MUX Behavioral Description
		always_comb muxout = RF_s ? DM_Din : alu_res;
		always_comb valCte = RF_cons ? Val_cons : muxout;
		always_comb negative = RF_ext ? ~valCte+1'b1 : valCte;
		always_comb RF_Rp_zero=~(16'b0| Rp_data);
=======
		// MUX Behavioral Description
		always_comb muxout = RF_s ? DM_Din : alu_res;
		
>>>>>>> parent of 501942d (six instruction first commit)
	
	
	rf	RegBank	(
		.clk(clk),					// input clk
		.rst(rst),					// input reset
		.W_data(negative),			// input Register File Write Port  (Data)
		.W_addr(RF_W_addr),		// input Register File Write Port  (Register Address)
		.W_wr(RF_W_wr),			// input Register File Write Port  (Write Enable)
		.Rp_addr(RF_Rp_addr),	// input Register File Read Port A (Register A we want to read)
		.Rp_rd(RF_Rp_rd),			// input Register File Read Port A (Register A data read out enable)
		.Rq_addr(RF_Rq_addr),	// input Register File Read Port B (Register B we want to read)
		.Rq_rd(RF_Rq_rd),			// input Register File Read Port B (Register B data read out enable)
		.Rp_data(Rp_data),		// output Register File Read Data out PortA
		.Rq_data(Rq_data)			// output Register File Read Data out PortB
		);

		
	alu  ALU (
		.A(Rp_data),
		.B(Rq_data),
		.s0(alu_s0),
		.OUT(alu_res)
		);


endmodule