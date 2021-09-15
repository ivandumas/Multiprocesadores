typedef enum logic [3:0]
{
	INIT		= 4'b0000,
	FETCH		= 4'b0001,
	DECODE		= 4'b0010,
	LOAD		= 4'b0011,
	STORE		= 4'b0100,
	ADD			= 4'b0101,
	LOC			= 4'b0110,
	SUB			= 4'b0111,
	JMZ			= 4'b1000,
	NOT			= 4'b1001,
	JMP			= 4'b1010,
	ERROR		= 4'bXXXX

} t_cntrl_fsm_state;


module controllerfsm (
	input  logic			clk,
	input  logic			rst,
	input	 logic [15:0]	instruction,
	input  logic			RF_Rp_zero, //Equal to zero signal
	output logic			PC_clr,
	output logic			PC_inc,
	output logic			PC_ld,
	output logic			I_rd,
	output logic			IR_ld,
	output logic [7:0] 	D_addr,
	output logic			D_rd,
	output logic			D_wr,
	output logic [7:0]		RF_W_data, //New control signal
	output logic			RF_s0,RF_s1, //New control signal
	output logic [3:0]	RF_W_addr,
	output logic			RF_W_wr,
	output logic [3:0]	RF_Rp_addr,
	output logic			RF_Rp_rd,
	output logic [3:0]	RF_Rq_addr,
	output logic			RF_Rq_rd,
	output logic			alu_s0,alu_s1
	);
	
	
	t_cntrl_fsm_state	state;   	// Enumerated Defined type variable for FSM states
	t_cntrl_fsm_state	nxtstate;	// Enumerated Defined type variable for FSM states
	
	logic [3:0] opcode;
	
	
	assign opcode = instruction[15:12];
	
	
	// FSM COMBINATORIAL LOGIC;   STATE TRANSITION LOGIC
		always_comb begin
			case (state)
				INIT	: nxtstate = FETCH;
				FETCH	: nxtstate = DECODE;
				DECODE: begin
							case (opcode)
								4'h0 : nxtstate = LOAD;
								4'h1 : nxtstate = STORE;
								4'h2 : nxtstate = ADD;
								4'h3 : nxtstate = LOC;
								4'h4 : nxtstate = SUB;
								4'h5 : nxtstate = JMZ;
								4'h6 : nxtstate = NOT;
								4'h7 : nxtstate = JMP;
								default : nxtstate = ERROR;
							endcase
						  end
				LOAD	: nxtstate = FETCH;
				STORE	: nxtstate = FETCH;
				ADD	: nxtstate = FETCH;
				LOC	: nxtstate = FETCH;
				SUB	: nxtstate = FETCH;
				JMZ	: nxtstate = (RF_Rp_zero) ? JMP : FETCH;
				JMP : nxtstate = FETCH;
				NOT	: nxtstate = FETCH;
				default : nxtstate = INIT;
			endcase
		end
	

	// FSM STATE REGISTER, SEQUENTIAL LOGIC
	always_ff @(posedge clk)
			state <= (rst) ? INIT : nxtstate;
	
	
	// OUTPUTS COMBINATIONAL LOGIC BASED ON STATE DECODING
	
		// Program Counter Interface
	always_comb begin 
		PC_clr = (state == INIT);
		PC_inc = (state == FETCH);
	end
	
		// Instruction Register Interface
	always_comb begin 
		IR_ld  = (state == FETCH);
		I_rd 	 = (state == FETCH);
	end
	
	// Data Memory i/f
	always_comb begin
		D_addr = ((state == LOAD) || (state == STORE)) ? instruction[7:0] : 'X;  // d
		D_rd	 = (state == LOAD)  ? 1'b1 : 'X;
		D_wr   = (state == STORE); // Data Memory Write Enable either 1 or 0  -
	end
	
	// Register File Control Signal i/f
	always_comb begin
		RF_s0		= 'X;
		RF_s1		= 'X;
		RF_W_addr	= 'X;
		RF_W_wr		= 1'b0;  // Wanted the Register File Write Enable to be 0 explicitely. 
		RF_Rp_addr	= 'X;
		RF_Rp_rd	= 'X;
		RF_Rq_addr	= 'X;
		RF_Rq_rd	= 'X;
		PC_ld		= 'X;
		case (state)
			ADD	: 	begin
							RF_Rp_addr 	= instruction[7:4];	 // rb
							RF_Rp_rd	  	= 1'b1;
							RF_s0		  	= 1'b0;
							RF_s1		  	= 1'b0;
							RF_Rq_addr 	= instruction[3:0];	 // rc
							RF_Rq_rd   	= 1'b1;
							RF_W_addr	= instruction[11:8];	 // ra
							RF_W_wr		= 1'b1;
						end
			STORE	:	begin
							RF_Rp_addr	= instruction[11:8];  // ra
							RF_Rp_rd		= 1'b1;
						end
			LOAD  :  begin
							RF_W_addr	= instruction[11:8];	 // ra
							RF_W_wr		= 1'b1;
							RF_s0		  	= 1'b1;
							RF_s1		  	= 1'b0;
						end
			LOC   :  begin
							RF_W_addr	= instruction[11:8];	 // ra
							RF_W_wr		= 1'b1;
							RF_s0		= 1'b0;
							RF_s1		= 1'b1;
						end
			SUB   :  begin
							RF_Rp_addr 	= instruction[7:4];	 // rb
							RF_Rp_rd	  	= 1'b1;
							RF_s0		  	= 1'b0;
							RF_s1			= 1'b0;
							RF_Rq_addr 	= instruction[3:0];	 // rc
							RF_Rq_rd   	= 1'b1;
							RF_W_addr	= instruction[11:8];	 // ra
							RF_W_wr		= 1'b1;
						end
			JMZ    :  begin
							RF_Rp_addr	= instruction[11:8];  // ra
							RF_Rp_rd		= 1'b1;
						end
			JMP    :  begin
							PC_ld       = 1'b1;
						end
			NOT    :  begin
							RF_W_addr	= instruction[11:8];	 // ra
							RF_W_wr		= 1'b1;
							RF_s0		= 1'b0;
							RF_s1		= 1'b0;
						end	
		endcase
	end
	
	always_comb begin
		alu_s0 = (state == ADD|state==NOT);
		alu_s1 = (state == SUB|state==NOT);
	end

	always_comb RF_W_data = (state == LOC) ? instruction[7:0] : 'X;
	
endmodule