module VGA #(
    //parameter dependant on the refresh rate and the clock rate
    // see: http://www.tinyvga.com/vga-timing
    parameter hRes = 800,
    parameter hFrontPorch = 40,
    parameter hSyncPulse = 128,
    parameter hBackPorch = 88,

    parameter vRes = 600,
    parameter vFrontPorch = 1,
    parameter vSyncPulse = 4,
    parameter vBackPorch = 23,

    parameter countWidth = 11
)(
    input iClk,
    input iRst_n,

    input [7:0] iRed,
    input [7:0] iGreen,
    input [7:0] iBlue,
    output [countWidth-1:0] oHCoordinate,
    output [countWidth-1:0] oVCoordinate,

    output oClk,
    output oBlank_n,
    output oSync_n,
    output [7:0] oRed,
    output [7:0] oGreen,
    output [7:0] oBlue,
    output oHsync,
    output oVsync
);

localparam hPeriod = hRes + hFrontPorch + hSyncPulse + hBackPorch;
localparam vPeriod = vRes + vFrontPorch + vSyncPulse + vBackPorch;

reg [countWidth-1:0] dHCount, qHCount;
reg [countWidth-1:0] dVCount, qVCount;

wire blanking = qHCount > hRes - 1 || qVCount > vRes - 1;
wire hSyncing = qHCount >= hRes+hFrontPorch && qHCount < hRes+hFrontPorch+hSyncPulse;
wire vSyncing = qVCount >= vRes+vFrontPorch && qVCount < vRes+vFrontPorch+vSyncPulse;

assign oClk = iClk;
assign oRed = iRed;
assign oGreen = iGreen;
assign oBlue = iBlue;
assign oBlank_n = ~blanking;
assign oHsync = ~hSyncing;
assign oVsync = ~vSyncing;
assign oSync_n = 1'b0;

assign oHCoordinate = qHCount < hRes ? qHCount : hRes - 1;
assign oVCoordinate = qVCount < vRes ? qVCount : vRes - 1;


always @(*) begin
    dHCount = qHCount >= hPeriod-1 ? 0 : qHCount + 1;
    if(qHCount == hPeriod-1)
        dVCount = qVCount >= vPeriod-1 ? 0 : qVCount + 1;
    else 
        dVCount = qVCount;
end

always @(posedge iClk, negedge iRst_n) begin
    if(!iRst_n) begin
        qVCount <= 0;
        qHCount <= 0;
    end else begin
        qHCount <= dHCount;
        qVCount <= dVCount;
    end
end

endmodule