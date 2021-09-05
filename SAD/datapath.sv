module datapath(
    input logic i_inc,
    input logic i_clr,
    input logic sum_ld,
    input logic sum_clr,
    input logic sadreg_ld,
    input logic sadreg_clr,
    input logic [8:0] A_data,
    input logic [8:0] B_data,
    output logic i_lt_256,
    output logic [8:0] AB_addr
    output logic [31:0] sad
);

logic [8:0] i_cnt = 9'd0;
logic [31:0] sumreg_in;
logic [31:0] sumreg_out = 32'h00000000;
logic [8:0] resta_out, abs_out;


cmp compare (.A(i_cnt),.B(9'd256),.lt(i_lt_256)); //Comparador i vs 256
A_B resta(.A(A_data),.B(B_data),.resta(resta_out)); //Resta de A y B
abs absolut(.resta(resta_out),.absoluto(abs_out)); //Absoluto de la resta
sumador suma(.absoluto(abs_out),.sumreg_out(sumreg_out),.result(sumreg_in)); //Suma absoluto + registro de suma

//Contador de eventos "i"
    always_ff @( posedge clk ) begin : i
        if (i_clr) i_cnt <= 9'd0;
        else if(i_inc) i_cnt <= i_cnt + 1;
        else i_cnt <= i_cnt;
        AB_addr <= i_cnt;
    end

//Registro de suma
    always_ff @( posedge clk ) begin : sumreg
        if (sum_clr) sumreg_out <= 32'h00000000;
        else if(sum_ld) sumreg_out <= sumreg_in;
        else sumreg_out <= sumreg_out;
    end

//Registro de SAD
    always_ff @( posedge clk ) begin : sadreg
        if (sadreg_clr) sad <= 32'h00000000;
        else if(sadreg_ld) sad <= sumreg_out;
        else sad <= sad;
    end


end module