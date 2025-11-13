module Divider (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire [15:0] numerator,
    input  wire [15:0] denominator,
    output      [15:0] q016_result,
    output reg  done
);

reg [3:0] state, next_state;
reg [31:0] dividend, next_dividend;
reg [15:0] divisor, next_divisor;
reg [15:0] quotient, next_quotient;
reg [5:0] count, next_count;

assign q016_result = next_quotient;

localparam IDLE  = 4'd0,
            INIT  = 4'd1,
            DIV   = 4'd2,
            DONE  = 4'd3;

always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            dividend <= 0;
            divisor <= 0;
            quotient <= 0;
            count <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            dividend <= next_dividend;
            divisor <= next_divisor;
            quotient <= next_quotient;
            count <= next_count;
            done <= (next_state == DONE);
        end
    end

always @(*) begin
        next_state = state;
        next_dividend = dividend;
        next_divisor = divisor;
        next_quotient = quotient;
        next_count = count;

        case (state)
            IDLE: begin
                if (start) begin
                    // Scale numerator by 2^16 (<< 16)
                    next_dividend = {numerator, 16'b0};
                    next_divisor = denominator;
                    next_quotient = 0;
                    next_count = 16;
                    next_state = DIV;
                end
            end

            DIV: begin
                next_dividend = next_dividend << 1;
                if (next_dividend[31:16] >= divisor) begin
                    next_dividend[31:16] = next_dividend[31:16] - divisor;
                    next_quotient = (quotient << 1) | 1'b1;
                end else begin
                    next_quotient = quotient << 1;
                end
                next_count = count - 1;
                if (count == 1)
                    next_state = DONE;
            end

            DONE: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule