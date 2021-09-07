module datapath (
    input logic rst,
    input logic clk,
    // controller <-> datapath interface
    input logic i_inc,
    input logic i_clr,
    input logic sum_ld,
    input logic sum_clr
    input logic sadreg_ld,
    input logic sadreg_clr,
    output logic i_lt_256,
    // pixel array interface
    input logic [7:0] A_data,
    input logic [7:0] B_data,
    output logic [8:0] AB_addr,
    // SAD final output
    input logic [31:0] sad
);

    logic [7:0] substract;
    logic [7:0] absvalue;

    always_comb begin : AB
        substract = A_data - B_data;
        absvalue = (substract[7]) ? -(substract) : substract; //does minus substract
    end

    //sum register
    logic [31:0] sumD;
    logic [31:0] sumQ;

    always_ff @(posedge clk ) begin : sumRegister
        if (sum_clr)
            sumQ <= '0;
        else if (sum_ld) 
            sumQ <= sumD;
    end

    // sad register         sumQ @ input D
    always_ff @(posedge clk ) begin : sadRegister
        if (sadreg_clr) // rst
            sad <= '0;
        else if (sadreg_ld)  //en
            sad <= sumQ;
    end

    //address counter
    logic [8:0] nxt_AB_addr;
    always_comb nxt_AB_addr = AB_addr + 1'b1;

    always_ff @(posedge clk ) begin : icounter
        if (rst|i_clr)
            AB_addr <= '0;
        else if (i_inc) 
            AB_addr <= nxt_AB_addr;
    end

    always_comb i_lt_256 = AB_addr < 256;

endmodule