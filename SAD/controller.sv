typedef enum logic [2:0]
{
	S0		= 3'b000,
	S1		= 3'b001,
	S2	    = 3'b010,
	S3		= 3'b011,
	S4		= 3'b100
	ERROR		= 3'bXXX

} t_cntrl_fsm_state;

module controller (
	input  logic 			go,
    input  logic 			i_lt_256,
    output  logic 			AB_rd,
    output  logic 			i_inc,
    output  logic 			i_clr,
    output  logic 			sum_ld,
    output  logic 			sum_clr,
    output  logic 			sadreg_ld,
    output  logic 			sadreg_clr);

    t_cntrl_fsm_state	state;   	// Enumerated Defined type variable for FSM states
	t_cntrl_fsm_state	next;	// Enumerated Defined type variable for FSM states

// CAMBIOS DE MAQUINA DE ESTADOS
		always_comb begin
			case (state)
                S0: case(go) //Si go = 1 pasa al siguiente estado
                    1 : next = S1; 
                    0 : next = S0;
                    default : next = ERROR:
                endcase
                S1: next = S2; //Se va solito
                S2: case(i_lt_256) //Si (i < 256)==True pasa al siguiente estado, si no, se brinca al S4.
                    1 : next = S3; 
                    0 : next = S4;
                    default : next = ERROR:
                endcase
                S3: next = S2; //Se va solito
                S4: next = S0; //Se va solito
                default : next = S0
			endcase
		end

	// PARA CAMBIAR DE ESTADO O RESETEAR
	always_ff @(posedge clk)
			state <= (rst) ? S0) : next;
    
// MAQUINA DE ESTADOS
		always_comb begin
			case (state)
                S1: sum_clr = 1;
                    i_clr = 1;
                S3: sum_ld = 1;
                    AB_rd = 1;
                    i_inc = 1;
                S4: sadreg_ld = 1;
			endcase
		end

 
endmodule