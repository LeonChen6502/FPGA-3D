module PipeLatch #(
    parameter size = 8
)(
    input clk,
    input rst_n,

    input iStart,
    input iDone,

    input [size-1:0] iData,
    output [size-1:0] oData,
    output oLocked
);

reg lock;
reg [size-1:0] data;
assign oData = data;
assign oLocked = lock;

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        lock <= 0;
        data <= 0;
    end else begin
        if(!lock) begin
            lock <= iStart;
            data <= iData;
        end else begin
            if(iDone) begin
                lock <= iStart;
                data <= iData;
            end else begin
                lock <= 1;
                data <= data;
            end
        end
    end
end

endmodule