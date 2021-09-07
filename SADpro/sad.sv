module sad_top (
    input logic rst,
    input logic clk,
    //datapath
    input logic [7:0] A_data,
    input logic [7:0] B_data,
    output logic [8:0] AB_adrr,
    output logic [31:0] sad
    //controller
    input logic go,
    output logic AB_rd
);

logic i_inc;
logic i_clr;
logic sum_ld;
logic sum_clr;
logic sad_reg_ld;
logic sad_reg_clr;
logic i_lt_256;

    datapath    saddpath    (.*); // (.*) solo funciona si declaraste exactamente los mismos nombres, no sirve pa los cablecitos.
    controller  sadfsm      (.*);

endmodule