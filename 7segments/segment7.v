module segment7(
     input A, B, C, D,
     output a,b,c,d,e,f,g
    );

    wire[3:0] Din;
    assign Din = {A,B,C,D};
    //wire[6:0] Dout;
    reg[6:0] Dout;

    always @(*)
    begin
        case (Din)
            default : Dout = 7'b100_1111; 
            0 : Dout = 7'b111_1110;
            1 : Dout = 7'b011_0000;
            2 : Dout = 7'b110_1101;
            3 : Dout = 7'b111_1001;
            4 : Dout = 7'b011_0011;
            5 : Dout = 7'b101_1011;
            6 : Dout = 7'b101_1111;
            7 : Dout = 7'b111_0000;
            8 : Dout = 7'b111_1111;
            9 : Dout = 7'b111_1011;
        endcase
    end

    assign {a,b,c,d,e,f,g} = Dout;
    
endmodule