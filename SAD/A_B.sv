module A_B (
    input logic [8:0] A,
    input logic [8:0] B,
    output logic [8:0] resta);
);

assign resta = A - B;

endmodule