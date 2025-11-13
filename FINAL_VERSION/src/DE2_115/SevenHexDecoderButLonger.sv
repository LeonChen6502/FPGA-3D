module SevenHexDecoderButLonger (
    input        [4:0] i_bin,       // 5-bit binary input
    output logic [6:0] o_seven_ten, // Seven segment display for tens place
    output logic [6:0] o_seven_one  // Seven segment display for ones place
);

/* Seven segment display mappings for digits 0-9 */
parameter D0 = 7'b1000000;
parameter D1 = 7'b1111001;
parameter D2 = 7'b0100100;
parameter D3 = 7'b0110000;
parameter D4 = 7'b0011001;
parameter D5 = 7'b0010010;
parameter D6 = 7'b0000010;
parameter D7 = 7'b1011000;
parameter D8 = 7'b0000000;
parameter D9 = 7'b0010000;

always_comb begin
    // Decode tens and ones from the 5-bit binary input
    case(i_bin / 10)   // Tens place
        3'd0: o_seven_ten = D0;
        3'd1: o_seven_ten = D1;
        3'd2: o_seven_ten = D2;
        3'd3: o_seven_ten = D3;
        3'd4: o_seven_ten = D4;
        3'd5: o_seven_ten = D5;
        3'd6: o_seven_ten = D6;
        3'd7: o_seven_ten = D7;
        3'd8: o_seven_ten = D8;
        3'd9: o_seven_ten = D9;
        default: o_seven_ten = D0; // Default for safety
    endcase
    
    case(i_bin % 10)   // Ones place
        4'd0: o_seven_one = D0;
        4'd1: o_seven_one = D1;
        4'd2: o_seven_one = D2;
        4'd3: o_seven_one = D3;
        4'd4: o_seven_one = D4;
        4'd5: o_seven_one = D5;
        4'd6: o_seven_one = D6;
        4'd7: o_seven_one = D7;
        4'd8: o_seven_one = D8;
        4'd9: o_seven_one = D9;
        default: o_seven_one = D0; // Default for safety
    endcase
end

endmodule