module pc (
	input logic clk, rst, PCSrc
    input logic [11:0] pc_offset,
	output logic [11:0] pc
);

logic [10:0] pc_d,pc_q,pc_inc;
logic [11:0] offshift;

always_comb begin : PCoffset
    offshift = pc_offset << 2; //Shift left 2 positions (to multiply by 4)
end

always_comb begin : ADD
    pc_inc  = pc_q + 4;
end

always_comb begin : mux
    pc_d = (PCSrc) ? (offshift + pc_inc) : pc_inc;
end

always_ff @( posedge clk ) begin : PC
    pc_q <= pc_d;
end

always_comb pc = pc_q;
    
endmodule