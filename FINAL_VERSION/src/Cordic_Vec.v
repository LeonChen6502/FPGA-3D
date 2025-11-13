module Cordic_Vec(
    input clk,
    input rst_n,

    input iStart,
    input signed [15:0] iAngle,
    input signed [15:0] iX,
    input signed [15:0] iY,

    output signed [15:0] oX,
    output signed [15:0] oY,

    output oDone
);

parameter signed [15:0] cordic_gain = 16'd19898; // Approx 0.607252 in Q1.15 format

reg [15:0] angleReduced, xReduced, yReduced;

// pre-rotate the vector if the angle is out of the first quadrant
always @(*) begin
    angleReduced = iAngle[13:0];
    case(iAngle[15:14])
        2'b00: begin // angle is in the first quadrant
            xReduced = iX;
            yReduced = iY;
        end
        2'b01: begin // angle is in the second quadrant
            xReduced = -iY;
            yReduced = iX;
        end
        2'b10: begin // angle is in the third quadrant
            xReduced = -iX;
            yReduced = -iY;
        end
        2'b11: begin // angle is in the first quadrant
            xReduced = iY;
            yReduced = -iX;
        end
    endcase
end


Cordic_Vec_Core core (
    .clk(clk),
    .rst_n(rst_n),
    .start(iStart),
    .angle(angleReduced),
    .x_in(xReduced),
    .y_in(yReduced),
    .cos_out(xCore),
    .sin_out(yCore),
    .done(doneCore),
    .busy(busyCore)
);

wire doneCore, busyCore;
wire signed [16:0] xCore, yCore;
reg done;
reg signed [31:0] xScaled, yScaled;

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        xScaled <= 0;
        yScaled <= 0;
    end else begin
        xScaled <= xCore*cordic_gain;
        yScaled <= yCore*cordic_gain;
        done <= doneCore;
    end
end

assign oDone = done;
assign oX = xScaled[30:15];
assign oY = yScaled[30:15];

endmodule