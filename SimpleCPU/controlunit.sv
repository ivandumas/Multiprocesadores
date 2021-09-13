module controlunit (
	input  logic			clk,
	input  logic 			rst,
	input	 logic [15:0]	inst,
	output logic [15:0]	progcntr,
	output logic			fetch,
	output logic [7:0]	D_addr,
	output logic 			D_rd,
	output logic			D_wr,
	output logic			RF_s,
	output logic [7:0] 	Val_cons,
	output logic			RF_cons,
	output logic			RF_ext,
	output logic [3:0]	RF_W_addr,
	output logic			RF_W_wr,
	output logic [3:0]	RF_Rp_addr,
	output logic			RF_Rp_rd,
	output logic [3:0]	RF_Rq_addr,
	output logic 			RF_Rq_rd,
	input  logic         RF_Rp_zero,
	output logic [7:0] 	RF_W_data,
	output logic 			alu_s0
	);
	
	
	logic 			up;
	logic				ld;
	logic				clr;
	logic [15:0]	instruction_reg;
	logic				PC_ld;//Señal agregar PC+offset
	
	// Program Counter Hardware description
	// This always statement describes a register with a combinatorial incrementer at the 'D' input
	
	always_ff @ (posedge clk)
		if (rst|clr)
			progcntr <= '0;
		else if (up)
			progcntr <= progcntr + 1'b1;
		else if (PC_ld)
			progcntr <= progcntr + instruction_reg[7:0] - 1'b1;
		 
	always_ff @ (posedge clk)
		if (rst)
			instruction_reg <= '0;
		else if (ld)
			instruction_reg <= inst;
			
	always_ff @(posedge clk)
	    RF_W_data <= instruction_reg[7:0];
	
	
	controllerfsm fsm (
								.clk			(clk),
								.rst			(rst),
								.instruction(instruction_reg),
								.PC_clr		(clr),
								.PC_inc		(up),
								.I_rd			(fetch),
								.IR_ld		(ld),
								.D_addr		(D_addr),
								.D_rd			(D_rd),
								.D_wr			(D_wr),
								.RF_s			(RF_s),
								.RF_W_addr	(RF_W_addr),
								.RF_W_wr		(RF_W_wr),
								.RF_Rp_addr	(RF_Rp_addr),
								.RF_Rp_rd	(RF_Rp_rd),
								.RF_Rq_addr	(RF_Rq_addr),
								.RF_Rq_rd	(RF_Rq_rd),
								.Val_cons	(Val_cons),
								.RF_cons		(RF_cons),
								.RF_ext		(RF_ext),
								.RF_Rp_zero	(RF_Rp_zero),
								.PC_ld		(PC_ld),
								.alu_s0		(alu_s0)
							);
								
	
endmodule
