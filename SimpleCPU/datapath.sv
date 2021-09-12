module datapath (
	input  logic			clk,
	input  logic 			rst,
	input  logic 			RF_W_data,
	input  logic			RF_s1,RF_s0,
	input  logic [3:0]	RF_W_addr,
	input  logic			RF_W_wr,
	input  logic [3:0]	RF_Rp_addr,
	input  logic			RF_Rp_rd,
	input  logic [3:0]	RF_Rq_addr,
	input  logic 			RF_Rq_rd,
	input  logic 			alu_s0,alu_s1
	input  logic [15:0]	DM_Din,
	output logic [15:0]	Rp_data,
	output logic 		RF_Rp_zero
	);

	
	logic [15:0]	muxout;
	//logic [15:0]	Rp_data;  // Already declared in the Module Output Pin port 
	logic [15:0]	Rq_data;
	logic [15:0]	alu_res;
	logic [15:0]	Rp_data_signal;

	datamux Datamux (
		.a(alu_res),
		.b(Rq_data),
		.c(RF_W_data),
		.s0(RF_s0),
		.s1(RF_s1),
		.out(muxout)
	);
		
	
	rf	RegBank	(
		.clk(clk),					// input clk
		.rst(rst),					// input reset
		.W_data(muxout),			// input Register File Write Port  (Data)
		.W_addr(RF_W_addr),		// input Register File Write Port  (Register Address)
		.W_wr(RF_W_wr),			// input Register File Write Port  (Write Enable)
		.Rp_addr(RF_Rp_addr),	// input Register File Read Port A (Register A we want to read)
		.Rp_rd(RF_Rp_rd),			// input Register File Read Port A (Register A data read out enable)
		.Rq_addr(RF_Rq_addr),	// input Register File Read Port B (Register B we want to read)
		.Rq_rd(RF_Rq_rd),			// input Register File Read Port B (Register B data read out enable)
		.Rp_data(Rp_data_signal),		// output Register File Read Data out PortA
		.Rq_data(Rq_data)			// output Register File Read Data out PortB
		);

		
	alu  ALU (
		.A(Rp_data),
		.B(Rq_data),
		.s0(alu_s0),
		.s1(alu_s1),
		.OUT(alu_res)
		);

		always_comb RF_Rp_zero <= (Rp_data_signal==0') ? 1 : 0;


endmodule