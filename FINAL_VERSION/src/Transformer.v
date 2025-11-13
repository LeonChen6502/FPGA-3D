module Transformer#(
    parameter CAMERA_DISTANCE = 1120 <<< 3, // the distance of the camera to the front Z clip plane
    parameter BOX_SIZE = 600 <<< 3
)(
    input clk,
    input rst_n,
    
    input iStart,
    output oDone,

    input signed [15:0] iAlpha,
    input signed [15:0] iBeta,
    input signed [15:0] iGamma,

    input signed [15:0] iX,
    input signed [15:0] iY,
    input signed [15:0] iZ,

    output signed [15:0] oX,
    output signed [15:0] oY
);

wire rotateDone;
wire signed [15:0] U, V, W;

Cordic_3d rotater (
    .clk(clk),
    .rst_n(rst_n),
    .iStart(iStart),
    .iX(iX),
    .iY(iY),
    .iZ(iZ),
    .oX(U),
    .oY(V),
    .oZ(W),
    .iAlpha(iAlpha),
    .iBeta(iBeta),
    .iGamma(iGamma),
    .oDone(rotateDone)
);

Perspective #(
    .BOX_SIZE(BOX_SIZE),
    .CAMERA_DISTANCE(CAMERA_DISTANCE)
) projector (
    .clk(clk),
    .rst_n(rst_n),
    .iStart(rotateDone),
    .oDone(oDone),
    .iX(U),
    .iY(V),
    .iZ(W),
    .oX(oX),
    .oY(oY)
);


endmodule