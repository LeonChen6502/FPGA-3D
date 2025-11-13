`timescale 1ns / 1ps

module receiver_decoder (
    input        i_clk,
    input        i_rst_n,
    input        i_reading_enable,  // when enabled (1), the decoder will stop writeing to SRAM
    input        i_Rx_DV,
    input  [7:0] i_Rx_Byte,

    // output       o_werite_enable, // Write enable signal for SRAM
	 output [20:0] o_point_count,
    output [19:0] o_SRAM_ADDR,
    inout  [15:0] io_SRAM_DQ,
    output        o_SRAM_WE_N,
    output        o_SRAM_CE_N,
    output        o_SRAM_OE_N,
    output        o_SRAM_LB_N,
    output        o_SRAM_UB_N
);
    parameter S_IDLE       = 0; // Idle state, waiting for data, start when receive 0xFF;
    parameter S_RECIVE     = 1; // Receiving data, when i_Rx_DV is high, shift data in data_received 
    parameter S_WAIT       = 2; // Waiting for next byte. when i_reading_enable is high, go to write state
    parameter S_WRITE_RAM  = 3;

    logic [2:0] state_r, state_w;
    logic [19:0] addr, addr_w;
    logic [47:0] data_wrtie_r, data_wrtie_w;
    logic [15:0] data_write; // Data to be written to SRAM
    logic [7:0] data_received;
    logic [3:0] counter_r, counter_w;
    logic flag1_r, flag1_w; 
	 logic [20:0] point_count_r, point_count_w;

    assign o_SRAM_ADDR = addr;
    assign io_SRAM_DQ  = (state_r == S_WRITE_RAM) ? data_write : 16'dz; // sram_dq as output
    // assign data_play   = (state_r != S_WRITE_RAM) ? io_SRAM_DQ : 16'd0; // sram_dq as input

    assign o_SRAM_WE_N = (state_r == S_WRITE_RAM) ? 1'b0 : 1'b1;
    assign o_SRAM_CE_N = 1'b0;
    assign o_SRAM_OE_N = 1'b0;
    assign o_SRAM_LB_N = 1'b0;
    assign o_SRAM_UB_N = 1'b0;
	 assign o_point_count = point_count_r;

    // Sequential block registers the next-state signals.
    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            state_r      <= S_IDLE;
            addr         <= 20'd0;
            data_wrtie_r <= 32'd0;
            counter_r    <= 4'd0;
            flag1_r      <= 1'b1; // Reset flag
				point_count_r <= 21'd0;
        end else begin
            state_r      <= state_w;
            addr         <= addr_w;
            data_wrtie_r <= data_wrtie_w;
            counter_r    <= counter_w;
            flag1_r      <= flag1_w; // Update flag
				point_count_r <= point_count_w;
        end
    end

    // Combinational block to compute next state logic.
    always_comb begin
        // Default assignments: propagate current values to next–state signals.
        addr_w       = addr;
        data_wrtie_w = data_wrtie_r;
        counter_w    = counter_r;
        state_w      = state_r;
        flag1_w      = flag1_r;   // Default: hold the flag
		  point_count_w = point_count_r;
        // (data_received is only temporary within each branch.)
        
        case (state_r)
            S_IDLE: begin
                if (i_Rx_DV) begin
                    // data_received = i_Rx_Byte;
                    if (i_Rx_Byte == 8'hFF) begin // Assuming 0x0A as the start byte
                        // addr_w       = 20'd0;  // Reset address for new data
                        counter_w    = 4'd0;   // Reset counter
                        data_wrtie_w = 32'd0;  // Reset data for new transfer
                        state_w      = S_RECIVE; // Move to receive state
                    end else begin
                        state_w = S_IDLE; // Stay in idle if not start byte
                    end
                end else begin
                    state_w = S_IDLE; // Stay in idle if no data received
                end
            end
            
            S_RECIVE: begin
                if (i_Rx_DV) begin
                    if (flag1_r) begin 
                        flag1_w = 1'b0; // Reset flag after first byte
                        // data_received = i_Rx_Byte;
                        // Shift in the newly received byte
                        data_wrtie_w = (data_wrtie_r << 8) | i_Rx_Byte;
                        counter_w    = counter_r + 1;
                    end else begin
                        flag1_w = 1'b0; // Even if not the first, flag gets reset
                    end
                    if (counter_r == 4'd5)
                        state_w = S_WAIT;
                    else
                        state_w = S_RECIVE;
                end else begin
                    state_w = S_RECIVE; // Stay in receive state if no data
                    flag1_w = 1'b1; // Set flag to indicate waiting for next byte
                end
            end
            
            S_WAIT: begin
                if (i_reading_enable) begin
                    counter_w = 4'd0;   // Reset counter for writing
                    state_w   = S_WRITE_RAM;
                end else begin
                    state_w = S_WAIT;
                end
            end
            
            S_WRITE_RAM: begin
                // Write lower 16 bits first, then upper 16 bits.
                if (counter_r == 0) begin 
                    addr_w     = addr + 1; // Increment address for next write
                    counter_w  = counter_r + 1; // Increment counter
                    state_w    = S_WRITE_RAM; // Stay in write state
                end else if (counter_r == 1) begin
                    addr_w     = addr + 1; // Increment address for next write
                    counter_w  = counter_r + 1; // Increment counter
                    state_w    = S_WRITE_RAM;  // Go back to idle state
                end else if (counter_r == 2) begin
                    addr_w     = addr + 1; // Increment address for next write
                    counter_w  = counter_r + 1; // Increment counter
                    state_w    = S_WRITE_RAM;  // Go back to idle state
						  
						  point_count_w = point_count_r + 1;

                end else begin
                    // Fallback to idle
                    state_w = S_IDLE;
                end
            end
            
            default: state_w = S_IDLE; // Fallback to idle state
        endcase
    end
	 
	 always_comb begin
			data_write = data_wrtie_r[15:0];
			if (counter_r == 0) begin 
			  data_write = data_wrtie_r[15:0];
			end else if (counter_r == 1) begin
			  data_write = data_wrtie_r[31:16]; // Write the next 16 bits
		   end else if (counter_r == 2) begin
			  data_write = data_wrtie_r[47:32]; // Write the next 16 bits
		   end
	 end

endmodule