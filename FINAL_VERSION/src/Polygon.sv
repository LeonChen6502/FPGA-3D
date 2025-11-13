module Polygon #(
    parameter HALF_EYE_ANGLE = 520
)
(
    input clk,
    input rst_n,

    //RAM interface
    output reg oReadReq,
    input iRAMBusy,
    output [19:0] oRAMAddr,
    input  [15:0] iRAMData,
    input [19:0] iRAMPointCount,
    
    //ROM interface
    output [13:0] oAddr,
    input signed [15:0] iMemData,
    input [13:0] iPointCount,

    //render settings
    input signed [15:0] iAlpha, iBeta, iGamma,
    input iUseRAM,
    input i3D,

    //render timing
    input iStart,
    output oFinish,

    //line drawing interface
    input iLineDrawRead,
    output signed [15:0] oU1, oU2, oV1, oV2,
    output oPointValid,
    output oIsRed
);

localparam S_IDLE = 0;
localparam S_MEM = 1;
localparam S_WAIT_DRAW = 2;
localparam S_RAM = 3;
localparam S_WAIT_RAM = 4;
localparam S_RAM_WAIT_DRAW = 5;

reg [13:0] dAddrCntr, qAddrCntr;
reg [3:0] dDesPtr, qDesPtr;
reg dMemReq, qMemReq;
reg [13:0] dLineCntr, qLineCntr;
reg [9:0] dState, qState;
reg signed [15:0] dPointVector [0:5]; // X1, Y1, Z1, X2, Y2, Z2
reg signed [15:0] qPointVector [0:5];
reg dTransformerStart, qTransformerStart;
reg d3D, q3D;
reg dRedblue, qRedblue;

assign oRAMAddr = {10'b0, qAddrCntr};
assign oAddr = qAddrCntr;
assign oFinish = qState == S_IDLE;
assign oIsRed = qRedblue;

// Address counter logic
always_comb begin
    dAddrCntr = qAddrCntr;
    case(qState)
        S_MEM: begin
            dAddrCntr = qAddrCntr + 1;
            if(qDesPtr == 5 && q3D && !qRedblue) begin
                dAddrCntr = qAddrCntr - qDesPtr;
            end
        end
        S_WAIT_DRAW: begin
            if(iLineDrawRead) begin
                if(!q3D) begin
                    if(qLineCntr == lPointCount-1) dAddrCntr = 0;
                end else begin
                    if(qRedblue && qLineCntr == lPointCount-1) dAddrCntr = 0;
                end
            end
        end
        S_RAM: begin
            if(!iRAMBusy) begin
                dAddrCntr = qAddrCntr + 1;
                if(qDesPtr == 5) begin
                    dAddrCntr = qAddrCntr - 2;
                    if(q3D && !qRedblue) begin
                        dAddrCntr = qAddrCntr - qDesPtr;
                    end
                end
            end
        end
        S_RAM_WAIT_DRAW: begin
            if(iLineDrawRead) begin
                if(!q3D) begin
                    if(qLineCntr == lRAMPointCount-2) dAddrCntr = 0;
                end else begin
                    if(qRedblue && qLineCntr == lRAMPointCount-2) dAddrCntr = 0;
                end
            end
        end
    endcase
end

// Destination pointer logic
always_comb begin
    dDesPtr = qDesPtr;
    case(qState)
        S_IDLE: begin
            if(iStart) dDesPtr = 0;
        end
        S_MEM: begin
            dDesPtr = qDesPtr + 1;
            if(qDesPtr == 5) dDesPtr = 0;
        end
        S_RAM: begin
            if(!iRAMBusy) begin
                dDesPtr = qDesPtr + 1;
                if(qDesPtr == 5) dDesPtr = 0;
            end
        end
    endcase
end

// RAM read request logic
always_comb begin
    oReadReq = 0;
    case(qState)
        S_RAM: begin
            if(!iRAMBusy) begin
                oReadReq = 1;
            end
        end
    endcase
end

// Line counter logic
always_comb begin
    dLineCntr = qLineCntr;
    case(qState)
        S_IDLE: begin
            if(iStart) dLineCntr = 0;
        end
        S_WAIT_DRAW: begin
            if(iLineDrawRead) begin
                if(!q3D) begin
                    if(qLineCntr != lPointCount-1) dLineCntr = qLineCntr + 1;
                    else dLineCntr = 0;
                end else begin
                    if(qRedblue) begin
                        if(qLineCntr != lPointCount-1) dLineCntr = qLineCntr + 1;
                        else dLineCntr = 0;
                    end
                end
            end
        end
        S_RAM_WAIT_DRAW: begin
            if(iLineDrawRead) begin
                if(!q3D) begin
                    if(qLineCntr != lRAMPointCount-2) dLineCntr = qLineCntr + 1;
                    else dLineCntr = 0;
                end else begin
                    if(qRedblue) begin
                        if(qLineCntr != lRAMPointCount-2) dLineCntr = qLineCntr + 1;
                        else dLineCntr = 0;
                    end
                end
            end
        end
    endcase
end

// State machine logic
always_comb begin
    dState = qState;
    case(qState)
        S_IDLE: begin
            if(iStart) begin
                if(!iUseRAM) dState = S_MEM;
                else dState = S_RAM;
            end
        end
        S_MEM: begin
            if(qDesPtr == 5) dState = S_WAIT_DRAW;
        end
        S_WAIT_DRAW: begin
            if(iLineDrawRead) begin
                if(!q3D) begin
                    if(qLineCntr != lPointCount-1) dState = S_MEM;
                    else dState = S_IDLE;
                end else begin
                    if(!qRedblue) dState = S_MEM;
                    else begin
                        if(qLineCntr != lPointCount-1) dState = S_MEM;
                        else dState = S_IDLE;
                    end
                end
            end
        end
        S_RAM: begin
            if(!iRAMBusy && qDesPtr == 5) dState = S_RAM_WAIT_DRAW;
        end
        S_RAM_WAIT_DRAW: begin
            if(iLineDrawRead) begin
                if(!q3D) begin
                    if(qLineCntr != lRAMPointCount-2) dState = S_RAM;
                    else dState = S_IDLE;
                end else begin
                    if(!qRedblue) dState = S_RAM;
                    else begin
                        if(qLineCntr != lRAMPointCount-2) dState = S_RAM;
                        else dState = S_IDLE;
                    end
                end
            end
        end
    endcase
end

// Point vector logic
always_comb begin
    for(integer i = 0; i < 6; i++) dPointVector[i] = qPointVector[i];
    case(qState)
        S_MEM: begin
            dPointVector[qDesPtr] = iMemData;
        end
        S_RAM: begin
            if(!iRAMBusy) begin
                dPointVector[qDesPtr] = iRAMData;
            end
        end
    endcase
end

// Transformer start logic
always_comb begin
    dTransformerStart = 0;
    case(qState)
        S_MEM: begin
            if(qDesPtr == 5) dTransformerStart = 1;
        end
        S_RAM: begin
            if(qDesPtr == 5 && !iRAMBusy) dTransformerStart = 1;
        end
    endcase
end

// 3D mode logic and Red/blue eye logic
always_comb begin
    d3D = q3D;
    dRedblue = qRedblue;
    case(qState)
        S_IDLE: begin
            if(iStart) begin
                d3D = i3D;
                dRedblue = 0;
            end 
        end
        S_WAIT_DRAW: begin
            if(iLineDrawRead && q3D) begin
                dRedblue = ~qRedblue;
                if(qRedblue && qLineCntr == lPointCount-1) d3D = 0;  
            end
        end
        S_RAM_WAIT_DRAW: begin
            if(iLineDrawRead && q3D) begin
                dRedblue = ~qRedblue;
                if(qRedblue && qLineCntr == lRAMPointCount-2) d3D = 0;
            end
        end
    endcase
end

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        qState <= S_IDLE;
        qAddrCntr <= 0;
        qMemReq <= 0;
        qLineCntr <= 0;
        qDesPtr <= 0;
        for(integer i = 0; i < 6; i++) begin
            qPointVector[i] <= 0;
        end
        qTransformerStart <= 0;
        q3D <= 0;
        qRedblue <= 0;
    end else begin
        qState <= dState;
        qAddrCntr <= dAddrCntr;
        qMemReq <= dMemReq;
        qLineCntr <= dLineCntr;
        qDesPtr <= dDesPtr;
        for(integer i = 0; i < 6; i++) begin
            qPointVector[i] <= dPointVector[i];
        end 
        qTransformerStart <= dTransformerStart;
        q3D <= d3D;
        qRedblue <= dRedblue;
    end
end

wire signed [15:0] gamma3DSpiced = 
    !q3D ? 
        lGamma : qRedblue ?
            lGamma - HALF_EYE_ANGLE : lGamma + HALF_EYE_ANGLE;

wire signed [15:0] lAlpha, lBeta, lGamma;
wire [13:0] lPointCount;
wire [19:0] lRAMPointCount;
PipeLatch #(.size(16*3 + 14 + 20)) angleLatch (
    .clk(clk),
    .rst_n(rst_n),

    .iStart(iStart),
    .iDone(oFinish),

    .iData({iAlpha, iBeta, iGamma, iPointCount, iRAMPointCount}),
    .oData({lAlpha, lBeta, lGamma, lPointCount, lRAMPointCount})
);

wire done1;
wire signed [15:0] u1, v1;
Transformer point1 (
    .clk(clk),
    .rst_n(rst_n),

    .iStart(qTransformerStart),
    .oDone(done1),

    .iX(qPointVector[0]<<<3),
    .iY(qPointVector[1]<<<3),
    .iZ(qPointVector[2]<<<3),

    .oX(u1),
    .oY(v1),

    .iAlpha(lAlpha),
    .iBeta(lBeta),
    .iGamma(gamma3DSpiced)
);

wire done2;
wire signed [15:0] u2, v2;
Transformer point2 (
    .clk(clk),
    .rst_n(rst_n),

    .iStart(qTransformerStart),
    .oDone(done2),

    .iX(qPointVector[3]<<<3),
    .iY(qPointVector[4]<<<3),
    .iZ(qPointVector[5]<<<3),

    .oX(u2),
    .oY(v2),

    .iAlpha(lAlpha),
    .iBeta(lBeta),
    .iGamma(gamma3DSpiced)
);

wire queueFull1;
PipeLatch #(.size(16*2)) pointQueue1 (
    .clk(clk),
    .rst_n(rst_n),

    .iStart(done1),
    .iDone(iLineDrawRead),

    .iData({u1>>>3, v1>>>3}),
    .oData({oU1, oV1}),
    .oLocked(queueFull1)
);

wire queueFull2;
PipeLatch #(.size(16*2)) pointQueue2 (
    .clk(clk),
    .rst_n(rst_n),

    .iStart(done2),
    .iDone(iLineDrawRead),

    .iData({u2>>>3, v2>>>3}),
    .oData({oU2, oV2}),
    .oLocked(queueFull2)
);

assign oPointValid = queueFull1 & queueFull2;

endmodule