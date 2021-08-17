module segment7(
     input [3:0] bcd,
     output[6:0] seg
    );

    reg [6:0] seg;

    always @(*)
    begin
        case (bcd) //case statement
            default : seg = 7'b1111111; 
            0 : seg = 7'b1111110;
            1 : seg = 7'b0110000;
            2 : seg = 7'b1101101;
            3 : seg = 7'b1111001;
            4 : seg = 7'b0110011;
            5 : seg = 7'b1011011;
            6 : seg = 7'b1011111;
            7 : seg = 7'b1110000;
            8 : seg = 7'b1111111;
            9 : seg = 7'b1111011;
        endcase
    end
    
endmodule