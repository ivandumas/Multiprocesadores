module abs (
    input logic [8:0] resta;
    output logic [8:0] absoluto
);

assign absoluto = (­~resta[8]) ? resta: resta[8] ? -resta:'x; 
//Si el signo es positivo, tomas el valor de resta, si es negativo, tomas el valor del complemento a 2 de resta

endmodule