module segment7(
     input [3:0] bcd,
     output[6:0] out
    );

    reg [6:0] out;

    always @(*)
    begin
        case (bcd)
            default : out = 7'b1111111; 
            0 : out = 7'b1111110;
            1 : out = 7'b0110000;
            2 : out = 7'b1101101;
            3 : out = 7'b1111001;
            4 : out = 7'b0110011;
            5 : out = 7'b1011011;
            6 : out = 7'b1011111;
            7 : out = 7'b1110000;
            8 : out = 7'b1111111;
            9 : out = 7'b1111011;
        endcase
    end
    
endmodule