module ROM #(
    parameter addrWidth = 11
)(
    input [addrWidth-1:0] hAddr,
    input [addrWidth-1:0] vAddr,

    output [7:0] oRed,
    output [7:0] oGreen,
    output [7:0] oBlue
);

reg [7:0] red, green, blue;
assign oRed = red;
assign oGreen = green;
assign oBlue = blue;

task black;
    begin
        red = 8'HA3;
        green = 8'HB1;
        blue = 8'H8A;
    end
endtask


task white;
    begin
        red = 8'HDA;
        green = 8'HD7;
        blue = 8'HC0;
    end
endtask

always @(*) begin
    black();
    if(hAddr == 300 || hAddr == 400) begin
        if(vAddr <= 400 && vAddr >= 300) white();
    end else if (hAddr == 350 || hAddr == 450) begin
        if(vAddr <= 350 && vAddr >= 250) white();
    end else if (hAddr >= 350 && hAddr <= 450) begin
        if(vAddr == 350 || vAddr == 250) white();
	 end else if(hAddr >= 300 && hAddr <= 400) begin
        if(vAddr == 400 || vAddr == 300) white();
		  end
end

endmodule