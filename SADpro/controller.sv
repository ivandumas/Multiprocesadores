typedef enum logic [2:0]
{
	S0		= 3'b000,
	S1		= 3'b001,
	S2		= 3'b010,
	S3		= 3'b011,
	S4		= 3'b100,
	ERROR		= 3'bXXX
} controller_states;

module controller (
	input  logic 			clk,
	input  logic 			rst,
	input  logic 			go,
   input  logic 			i_lt_256,
   output  logic 			AB_rd,
   output  logic 			i_inc,
   output  logic 			i_clr,
   output  logic 			sum_ld,
   output  logic 			sum_clr,
   output  logic 			sad_reg_ld
);

controller_states state;
controller_states next;

// State Transition Logic
	always_comb begin
		case (state)
            S0: next = go ? S1 : S0;
            S1: next = S2; 
            S2: next = i_lt_256 ? S3 : S4;
            S3: next = S2; 
            S4: next = S0; 
            ERROR: next = S0;
            default : next = S0;
		endcase
	end

    //State Register
	always_ff @(posedge clk)
		begin
			state <= (rst) ? S0 : next;
		end

    //FSM Outputs ... state based
	always_comb 
        begin
        sum_clr   = state == S1;
        i_clr 	  = state == S1;
        sum_ld 	  = state == S3;
        AB_rd 	  = state == S3;
        i_inc 	  = state == S3;
        sad_reg_ld = state == S4;
        // case (state)
        //     S1: begin sum_clr = 1;
        //         i_clr = 1;end
        //     S3: begin sum_ld = 1;
        //         AB_rd = 1;
        //         i_inc = 1; end
        //     S4: sad_reg_ld = 1;
        // endcase
        end


endmodule