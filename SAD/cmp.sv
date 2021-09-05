module cmp (
    input logic [8:0] A;
    input logic [8:0] B;
    output logic lt;
);

assign (A < B) ? lt = 1 : lt = 0;

endmodule