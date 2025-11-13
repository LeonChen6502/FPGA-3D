module DE2_115 (
    // Clock Inputs
    input  CLOCK_50,
    input  CLOCK2_50,
    input  CLOCK3_50,
    input  ENETCLK_25,
    input  SMA_CLKIN,
    output SMA_CLKOUT,

    // LEDs
    output [ 8:0] LEDG,
    output [17:0] LEDR,

    // Keys and Switches
    input [ 3:0] KEY,
    input [17:0] SW,

    // 7-Segment Displays
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3,
    output [6:0] HEX4,
    output [6:0] HEX5,
    output [6:0] HEX6,
    output [6:0] HEX7,

    // LCD
    output LCD_BLON,
    inout [7:0] LCD_DATA,
    output LCD_EN,
    output LCD_ON,
    output LCD_RS,
    output LCD_RW,

    // UART
    output UART_CTS,
    input  UART_RTS,
    input  UART_RXD,
    output UART_TXD,

    // PS2
    inout PS2_CLK,
    inout PS2_DAT,
    inout PS2_CLK2,
    inout PS2_DAT2,

    // SD Card
    output SD_CLK,
    inout SD_CMD,
    inout [3:0] SD_DAT,
    input SD_WP_N,

    // VGA
    output [7:0] VGA_B,
    output VGA_BLANK_N,
    output VGA_CLK,
    output [7:0] VGA_G,
    output VGA_HS,
    output [7:0] VGA_R,
    output VGA_SYNC_N,
    output VGA_VS,

    // Audio
    input  AUD_ADCDAT,
    inout  AUD_ADCLRCK,
    inout  AUD_BCLK,
    output AUD_DACDAT,
    inout  AUD_DACLRCK,
    output AUD_XCK,

    // I2C
    output EEP_I2C_SCLK,
    inout  EEP_I2C_SDAT,
    output I2C_SCLK,
    inout  I2C_SDAT,

    // Ethernet
    output ENET0_GTX_CLK,
    input ENET0_INT_N,
    output ENET0_MDC,
    input ENET0_MDIO,
    output ENET0_RST_N,
    input ENET0_RX_CLK,
    input ENET0_RX_COL,
    input ENET0_RX_CRS,
    input [3:0] ENET0_RX_DATA,
    input ENET0_RX_DV,
    input ENET0_RX_ER,
    input ENET0_TX_CLK,
    output [3:0] ENET0_TX_DATA,
    output ENET0_TX_EN,
    output ENET0_TX_ER,
    input ENET0_LINK100,
    output ENET1_GTX_CLK,
    input ENET1_INT_N,
    output ENET1_MDC,
    input ENET1_MDIO,
    output ENET1_RST_N,
    input ENET1_RX_CLK,
    input ENET1_RX_COL,
    input ENET1_RX_CRS,
    input [3:0] ENET1_RX_DATA,
    input ENET1_RX_DV,
    input ENET1_RX_ER,
    input ENET1_TX_CLK,
    output [3:0] ENET1_TX_DATA,
    output ENET1_TX_EN,
    output ENET1_TX_ER,
    input ENET1_LINK100,

    // TV Decoder
    input TD_CLK27,
    input [7:0] TD_DATA,
    input TD_HS,
    output TD_RESET_N,
    input TD_VS,

    // USB OTG
    inout [15:0] OTG_DATA,
    output [1:0] OTG_ADDR,
    output OTG_CS_N,
    output OTG_WR_N,
    output OTG_RD_N,
    input OTG_INT,
    output OTG_RST_N,

    // IRDA
    input IRDA_RXD,

    // DRAM
    output [12:0] DRAM_ADDR,
    output [1:0] DRAM_BA,
    output DRAM_CAS_N,
    output DRAM_CKE,
    output DRAM_CLK,
    output DRAM_CS_N,
    inout [31:0] DRAM_DQ,
    output [3:0] DRAM_DQM,
    output DRAM_RAS_N,
    output DRAM_WE_N,

    // SRAM
    output [19:0] SRAM_ADDR,
    output SRAM_CE_N,
    inout [15:0] SRAM_DQ,
    output SRAM_LB_N,
    output SRAM_OE_N,
    output SRAM_UB_N,
    output SRAM_WE_N,

    // Flash
    output [22:0] FL_ADDR,
    output FL_CE_N,
    inout [7:0] FL_DQ,
    output FL_OE_N,
    output FL_RST_N,
    input FL_RY,
    output FL_WE_N,
    output FL_WP_N,

    // GPIO
    inout [35:0] GPIO,

    // HSMC
    input HSMC_CLKIN_P1,
    input HSMC_CLKIN_P2,
    input HSMC_CLKIN0,
    output HSMC_CLKOUT_P1,
    output HSMC_CLKOUT_P2,
    output HSMC_CLKOUT0,
    inout [3:0] HSMC_D,
    input [16:0] HSMC_RX_D_P,
    output [16:0] HSMC_TX_D_P,

    // Expansion IO
    inout [6:0] EX_IO
);

  // --- Parameters ---
  localparam Period = 3000;
  parameter FPSPeriod = 600000;
  localparam HALF_SECOND = 32'd20_000_000;

  // --- Clock Signals ---
  logic CLK_12M, CLK_100K, CLK_800K;
  wire clk_100mhz, clk_40mhz, pll_locked;

  // --- Reset ---
  wire sys_reset_n = KEY[0];

  // --- PLL Generation ---
  assign AUD_XCK = CLK_12M;
  Altpll pll0 (
      .clk_clk(CLOCK_50),
      .reset_reset_n(KEY[0]),
      .altpll_12m_clk(CLK_12M),
      .altpll_100k_clk(CLK_100K),
      .altpll_800k_clk(CLK_800K)
  );
  assign clk_100mhz = CLK_100K;
  assign clk_40mhz  = CLK_12M;

  // --- Rotation Signal Generator ---
  reg [31:0] prescaler, prescaler2;
  reg signed [15:0] angle, angle2;
  always @(posedge clk_40mhz, negedge sys_reset_n) begin
    if (!sys_reset_n) begin
      prescaler <= 31'd0;
      angle <= 0;
    end else if (GPIO[32] || GPIO[35]) begin
      if (prescaler >= Period - 1) begin
        prescaler <= 0;
		  if(GPIO[35]) angle <= angle == 31'H7FFFF ? -31'H8000 : angle + 1;
		  else 			angle <= angle == -31'H8000 ? 31'H7FFFF : angle - 1;
      end else begin
        prescaler <= prescaler + 1;
      end
    end
  end
  always @(posedge clk_40mhz, negedge sys_reset_n) begin
    if (!sys_reset_n) begin
      prescaler2 <= 31'd0;
      angle2 <= 0;
    end else if (GPIO[33] || GPIO[34]) begin
      if (prescaler2 >= Period - 1) begin
        prescaler2 <= 0;
        if(GPIO[34]) angle2 <= angle2 == 31'H7FFFF ? -31'H8000 : angle2 + 1;
		  else			angle2 <= angle2 == -31'H8000 ? 31'H7FFFF : angle2 - 1;
      end else begin
        prescaler2 <= prescaler2 + 1;
      end
    end
  end

  // --- Refresh Tick Generator ---
  reg [31:0] FPSPrescaler;
  reg start;
  always @(posedge clk_40mhz, negedge sys_reset_n) begin
    if (!sys_reset_n) begin
      FPSPrescaler <= 31'd0;
      start <= 0;
    end else if (FPSPrescaler >= FPSPeriod - 1) begin
      FPSPrescaler <= 0;
      start <= 1;
    end else begin
      FPSPrescaler <= FPSPrescaler + 1;
      start <= 0;
    end
  end

  // --- Scaling Signal Generator ---
  reg [31:0] ScalePrescaler;
  reg signed [15:0] scale;
  always @(posedge clk_40mhz, negedge sys_reset_n) begin
    if (!sys_reset_n) begin
      ScalePrescaler <= 31'd0;
      scale <= 31'H7FFFF;
    end else if (SW[15] || SW[14]) begin
      if (ScalePrescaler >= Period - 1) begin
        ScalePrescaler <= 0;
		  if(SW[15]) scale <= scale == 31'H7FFFF ? 31'H7FFFF : scale + 1;
		  else 			scale <= scale == 31'H2000 ? 31'H2000 : scale - 1;
      end else begin
        ScalePrescaler <= ScalePrescaler + 1;
      end
    end
  end
  
  // --- 3D Transformation ---
  wire signed [15:0] beta = -16'd10000;
  wire signed [15:0] gamma = -16'd0;
  wire signed [15:0] x_out1, x_out2, y_out1, y_out2;
  wire [13:0] addrLine;
  wire signed [15:0] dataLine;
  wire signed [31:0] scaledData = dataLine * scale;
  wire signed [31:0] scaledRAM = SRAM_DQ * scale;
  wire reading_enable, newPairExist, feederIdle, isRed;
  reg lineBufRead;
  wire [19:0] feeder_ram_addr;
  wire [20:0] RAMPointCount;

  Polygon feeder (
      .clk(clk_40mhz),
      .rst_n(sys_reset_n),
      .oAddr(addrLine),
      .iMemData(scaledData[30:15]),
      .iPointCount(471),
      .oReadReq(reading_enable),
      .iRAMBusy(~SRAM_WE_N),
      .oRAMAddr(feeder_ram_addr),
      .iRAMData(scaledRAM[30:15]),
      .iRAMPointCount(RAMPointCount),
      .iAlpha(angle),
      .iBeta(angle2),
      .iGamma(gamma),
      .i3D(SW[17]),
      .iUseRAM(SW[16]),
      .iStart(start),
      .oFinish(feederIdle),
      .iLineDrawRead(lineBufRead),
      .oU1(x_out1),
      .oU2(x_out2),
      .oV1(y_out1),
      .oV2(y_out2),
      .oPointValid(newPairExist),
      .oIsRed(isRed)
  );

  wire [9:0] x1_screen = x_out1 + $signed(400);
  wire [9:0] x2_screen = x_out2 + $signed(400);
  wire [9:0] y1_screen = $signed(300) - y_out1;
  wire [9:0] y2_screen = $signed(300) - y_out2;

  LineROM Rom (
      .iAddr(addrLine),
      .oData(dataLine)
  );

  // --- Animation FSM ---
  // 控制 framebuffer_top 的訊號
  reg fb_draw_go = 1'b0;
  reg fb_clear_go = 1'b0;
  reg [9:0] fb_stax, fb_stay, fb_endx, fb_endy;
  reg [3:0] fb_color_in;
  wire fb_drawing_busy;
  // Double buffer control signals
  reg fb_swap_buffers = 1'b0;
  wire fb_swap_complete;

  // Timer
  reg [31:0] timer_counter = 0;
  reg line_select = 1'b0;  // 0: 第一條線, 1: 第二條線

  // 繪圖狀態機的狀態定義
  localparam S_IDLE                 = 4'd0,
             S_CLEAR_SETUP          = 4'd1,
             S_CLEAR_TRIGGER        = 4'd2,
             S_CLEAR_WAIT           = 4'd3,
             S_DRAW_LINE_SETUP      = 4'd4,
             S_DRAW_LINE_TRIGGER    = 4'd5,
             S_DRAW_LINE_WAIT       = 4'd6,
             S_SWAP_BUFFER_TRIGGER  = 4'd7,
             S_SWAP_BUFFER_WAIT     = 4'd8,
             S_WAIT_TIMER           = 4'd9;
  reg [3:0] anim_state = S_IDLE;
  reg [31:0] timeout_counter = 0;
  reg timeout_flag = 0;

  /*Breath Color Params*/
  reg [3:0] frame_color = 4'h9;  // Initial color (e.g., bright red)
  reg [7:0] breath_color_freq = '0;
  reg [15:0] dummy_counter = 0;
  reg [17:0] longer_dummy_counter = 0;
  reg [7:0] BREATHE_FREQ_FAST = 0;
  reg [7:0] BREATHE_FREQ_SMOOTH = 0;
  reg BREATHE_DIRECTION = 1;

  always @(posedge clk_40mhz or negedge sys_reset_n) begin
    if (!sys_reset_n) begin
      // 初始化狀態
      anim_state        <= S_IDLE;
      fb_draw_go        <= 1'b0;
      fb_clear_go       <= 1'b0;
      fb_swap_buffers   <= 1'b0;
      fb_stax           <= 10'd0;
      fb_stay           <= 10'd0;
      fb_endx           <= 10'd800;
      fb_endy           <= 10'd600;
      fb_color_in       <= 4'hF;
      timeout_counter   <= 0;
      timeout_flag      <= 0;
      timer_counter     <= 0;
      line_select       <= 1'b0;
      lineBufRead       <= 1'b0;
      breath_color_freq <= '0;
      dummy_counter    <= '0;
      longer_dummy_counter <= '0;
      BREATHE_FREQ_FAST <= 0;
      BREATHE_FREQ_SMOOTH <= 0;
      BREATHE_DIRECTION <= 1;
    end else begin
      // 預設將 go 訊號設為低電位
      fb_draw_go <= 1'b0;
      fb_clear_go <= 1'b0;
      fb_swap_buffers <= 1'b0;

      /*BREATHE FAST*/
      dummy_counter <= dummy_counter + 1;
      longer_dummy_counter <= longer_dummy_counter + 1;
      if (dummy_counter == 3000) BREATHE_FREQ_FAST <= BREATHE_FREQ_FAST + 1;
      else BREATHE_FREQ_FAST <= BREATHE_FREQ_FAST;
      
      /*BREATHE SMOOTH*/
      if (longer_dummy_counter == 3000) begin
        if (BREATHE_DIRECTION) begin
          if(BREATHE_FREQ_SMOOTH == 8'hFF) begin // Moving Upward
            BREATHE_DIRECTION <= 0;  // Reverse direction
            BREATHE_FREQ_SMOOTH <= BREATHE_FREQ_SMOOTH - 1;
          end else BREATHE_FREQ_SMOOTH <= BREATHE_FREQ_SMOOTH + 1;
        end else
          if (BREATHE_FREQ_SMOOTH == 8'h00) begin // Moving Downward
            BREATHE_DIRECTION <= 1;  // Reverse 
            BREATHE_FREQ_SMOOTH <= BREATHE_FREQ_SMOOTH + 1;
          end else BREATHE_FREQ_SMOOTH <= BREATHE_FREQ_SMOOTH - 1;
      end
      else BREATHE_FREQ_SMOOTH <= BREATHE_FREQ_SMOOTH;

      case (anim_state)
        S_IDLE: begin
          timeout_counter <= 0;
          timeout_flag <= 0;
          timer_counter <= 0;
          // 開始清除畫面
          anim_state <= S_CLEAR_SETUP;
        end

        // --- 清除畫面 ---
        S_CLEAR_SETUP: begin
          anim_state <= S_CLEAR_TRIGGER;
        end

        S_CLEAR_TRIGGER: begin
          fb_clear_go <= 1'b1;
          if (buffer_top_state_debug == 0) begin
            anim_state <= S_CLEAR_WAIT;
            timeout_counter <= 0;
          end
        end

        S_CLEAR_WAIT: begin
          timeout_counter <= timeout_counter + 1;
          if (buffer_top_state_debug != 0) begin
            anim_state <= S_DRAW_LINE_SETUP;
          end else if (timeout_counter > 32'd10000000000) begin
            // If timeout
            timeout_flag <= 1;
            anim_state   <= S_IDLE;
          end
        end

        // --- 畫線 ---
        S_DRAW_LINE_SETUP: begin
          if (newPairExist == 1'b1) begin
            // 第一條線：左上到右下
            fb_stax     <= x1_screen;
            fb_stay     <= y1_screen;
            fb_endx     <= x2_screen;
            fb_endy     <= y2_screen;
            // *** MODIFICATION START: Use frame_color for drawing ***
            fb_color_in <= SW[0] ? 3'b111 : (isRed ? 3'b100 : 3'b001);  // 白色
            // *** MODIFICATION END ***
            anim_state  <= S_DRAW_LINE_TRIGGER;
            lineBufRead <= 1'b1;
          end else begin
            // 第二條線：右上到左下
            fb_stax     <= fb_stax;
            fb_stay     <= fb_stay;
            fb_endx     <= fb_endx;
            fb_endy     <= fb_endy;
            fb_color_in <= fb_color_in;  // 黃色
            anim_state  <= anim_state;
          end
        end

        S_DRAW_LINE_TRIGGER: begin
          fb_draw_go  <= 1'b1;
          lineBufRead <= 1'b0;
          if (fb_drawing_busy) begin
            anim_state <= S_DRAW_LINE_WAIT;
            timeout_counter <= 0;
          end
        end

        /*Modified to fit DOUBLE BUFFER*/
        S_DRAW_LINE_WAIT: begin
          timeout_counter <= timeout_counter + 1;
          if (!fb_drawing_busy) begin
            if (feederIdle & ~newPairExist) begin
              // 畫完後，交換緩衝區
              anim_state <= S_SWAP_BUFFER_TRIGGER;
            end else begin
              anim_state <= S_DRAW_LINE_SETUP;
            end
          end else if (timeout_counter > 32'd10000000) begin
            // 超時處理
            timeout_flag <= 1;
            anim_state   <= S_IDLE;
          end
        end

        // --- 交換緩衝區 ---
        S_SWAP_BUFFER_TRIGGER: begin
          fb_swap_buffers <= 1'b1;
          anim_state <= S_SWAP_BUFFER_WAIT;
        end

        S_SWAP_BUFFER_WAIT: begin
          breath_color_freq <= breath_color_freq + 1;
          if (fb_swap_complete) begin
            frame_color <= (breath_color_freq == 32) ? (frame_color + 1):(frame_color); // Update color for the next frame
            anim_state <= S_WAIT_TIMER;
            timer_counter <= 0;
          end
        end

        // --- 等待 0.5 秒 ---
        S_WAIT_TIMER: begin
          //                timer_counter <= timer_counter + 1;
          //                if (timer_counter >= HALF_SECOND) begin
          // 切換到另一條線
          line_select <= ~line_select;
          timer_counter <= 0;
          // 回到清除畫面
          anim_state <= S_CLEAR_SETUP;
          //                end
        end

        default: begin
          anim_state <= S_IDLE;
        end
      endcase
    end
  end

  // LED 狀態指示
  assign LEDG[0] = !fb_drawing_busy;  // 綠燈亮表示 framebuffer 空閒
  assign LEDR[0] = fb_drawing_busy;  // 紅燈亮表示 framebuffer 忙碌
  assign LEDG[1] = (anim_state == S_IDLE);  // 綠燈亮表示系統處於閒置狀態
  assign LEDR[1] = timeout_flag;  // 紅燈亮表示發生超時
  assign LEDG[2] = line_select;  // 綠燈顯示目前顯示哪條線
  // ================================================================================================= //



  /*DEBUG*/
  reg [1:0] buffer_top_state_debug;
  /*Frambuffer Top Controller with Double Buffer*/
  assign VGA_CLK = clk_40mhz;
  wire [7:0] fb_rgb_out;
  framebuffer_top_double fb_robot_inst (
      // Clocks & Reset
      .clk_sys(clk_100mhz),
      .clk_vga(clk_40mhz),
      .reset  (!sys_reset_n), // framebuffer_top 使用高電位重置

      // Control Signals
      .draw_go(fb_draw_go),
      .clear_screen_go(fb_clear_go),
      .swap_buffers(fb_swap_buffers),
      .swap_complete(fb_swap_complete),
      .stax(fb_stax),
      .stay(fb_stay),
      .endx(fb_endx),
      .endy(fb_endy),
      .color_in(fb_color_in),
      .drawing_busy(fb_drawing_busy),

      // VGA Output
      .hsync(VGA_HS),
      .vsync(VGA_VS),
      .blank_n(VGA_BLANK_N),
      .rgb_out(fb_rgb_out),
      /*DEBUG*/
      .SW1(SW[1]),
      .SW2(SW[2]),
      .buffer_top_state_debug(buffer_top_state_debug)
  );

  /*OUTPUT: VGA Output with Breathing Effect*/
  wire [7:0] breathe_val = SW[4] ? (8'hFF - BREATHE_FREQ_SMOOTH) : SW[3] ? (8'hFF - BREATHE_FREQ_FAST) : 8'hFF;                       // 常亮
  assign VGA_R = fb_rgb_out[2] ? breathe_val : 8'h00;
  assign VGA_G = fb_rgb_out[1] ? breathe_val : 8'h00;
  assign VGA_B = fb_rgb_out[0] ? breathe_val : 8'h00;

  /*7-segment Display*/
  // assign HEX0 = 7'h7F;
  // assign HEX1 = 7'h7F; 
  assign HEX2  = 7'h7F;
  assign HEX3  = 7'h7F;
  assign HEX4  = 7'h7F;
  assign HEX5  = 7'h7F;
  assign HEX6  = 7'h7F;
  assign HEX7  = 7'h7F;
  SevenHexDecoder seven_dec_draw_state (
      .i_hex(anim_state),
      .o_seven_ten(HEX1),
      .o_seven_one(HEX0)
  );
  /*7-segment Display*/

  //==============================================================================
  // UART scanner receiver
  //==============================================================================

  assign UART_RXD_1 = GPIO[9];  // Connect UART RXD to GPIO[0] for testing

  logic [7:0] RX_Byte;
  logic Rx_DV;
  logic [2:0] receiver_state;
  receiver receiver_one (
      //.i_Clock(CLOCK_40M),
      .i_Clock(clk_40mhz),
      .i_Rx_Serial(UART_RXD_1),
      .o_Rx_DV(Rx_DV),
      .o_Rx_Byte(RX_Byte)
  );

  // Example reading enable signal (use SW[0] or another source as needed)
  wire [19:0] rec_dec_ram_addr;
  receiver_decoder rec_dec (
      .i_clk(clk_40mhz),
      .i_rst_n(KEY[0]),
      .i_reading_enable(~reading_enable),
      .i_Rx_DV(Rx_DV),
      .i_Rx_Byte(RX_Byte),
      .o_SRAM_ADDR(rec_dec_ram_addr),
      .io_SRAM_DQ(SRAM_DQ),
      .o_SRAM_WE_N(SRAM_WE_N),
      .o_SRAM_CE_N(SRAM_CE_N),
      .o_SRAM_OE_N(SRAM_OE_N),
      .o_SRAM_LB_N(SRAM_LB_N),
      .o_SRAM_UB_N(SRAM_UB_N),
      .o_point_count(RAMPointCount)
  );

  assign SRAM_ADDR = ~SRAM_WE_N ? rec_dec_ram_addr : feeder_ram_addr;

endmodule

////////////////////////////////////////////////////////////////////////////////
//
//               繪圖機器人核心模組 (從這裡開始是函式庫)
//
////////////////////////////////////////////////////////////////////////////////

//==============================================================================
//
//                 Framebuffer Top-Level Module with Double Buffer
//
//==============================================================================
module framebuffer_top_double #(
    parameter WIDTH    = 800,
    parameter HEIGHT   = 600,
    parameter DW       = 3,
    parameter BG_COLOR = 3'h0
) (
    input wire clk_sys,
    input wire clk_vga,
    input wire reset,
    input wire draw_go,
    input wire clear_screen_go,
    input wire swap_buffers,
    output reg swap_complete,
    input wire [$clog2(WIDTH)-1:0] stax,
    input wire [$clog2(HEIGHT)-1:0] stay,
    input wire [$clog2(WIDTH)-1:0] endx,
    input wire [$clog2(HEIGHT)-1:0] endy,
    input wire [DW-1:0] color_in,
    output wire drawing_busy,
    output wire hsync,
    output wire vsync,
    output wire blank_n,
    output wire [DW-1:0] rgb_out,

    /*DEBUG*/
    input wire SW1,
    input wire SW2,
    output wire [1:0] buffer_top_state_debug
);
  /*Params*/
  localparam [1:0] STATE_CLEARING = 2'd0, STATE_READY = 2'd1, STATE_DRAWING = 2'd2, STATE_DRAWING_EXTEND = 2'd3;
  (*keep*) reg [1:0] current_state = STATE_CLEARING;
  localparam ADDR_BITS = $clog2(WIDTH * HEIGHT);

  // Double buffer control
  reg active_buffer = 1'b0;  // 0: buffer0 is active (displayed), 1: buffer1 is active
  reg swap_pending = 1'b0;
  wire vsync_edge;
  reg vsync_prev = 1'b0;

  // Buffer 0 signals
  reg vram0_wr_en = 1'b0;
  reg [ADDR_BITS-1:0] vram0_wr_addr = 0;
  reg [DW-1:0] vram0_wr_data = 0;
  wire [ADDR_BITS-1:0] vram0_rd_addr;
  wire [DW-1:0] vram0_rd_q;

  // Buffer 1 signals  
  reg vram1_wr_en = 1'b0;
  reg [ADDR_BITS-1:0] vram1_wr_addr = 0;
  reg [DW-1:0] vram1_wr_data = 0;
  wire [ADDR_BITS-1:0] vram1_rd_addr;
  wire [DW-1:0] vram1_rd_q;

  // Common write signals (write to inactive buffer)
  reg vram_wr_en = 1'b0;
  reg [ADDR_BITS-1:0] vram_wr_addr = 0;
  reg [DW-1:0] vram_wr_data = 0;

  (*keep*) reg [ADDR_BITS-1:0] clear_addr_cnt = 0;

  /*DEBUG*/
  wire clear_done = (clear_addr_cnt == (WIDTH * HEIGHT - 1));
  // wire clear_done = (clear_addr_cnt == (100 - 1));

  wire linedraw_wr;
  wire [ADDR_BITS-1:0] linedraw_addr;
  wire linedraw_busy;
  reg linedraw_go_reg = 1'b0;
  assign drawing_busy = (current_state == STATE_DRAWING || current_state == STATE_DRAWING_EXTEND);

  /*DEBUG*/
  assign buffer_top_state_debug = current_state;
  reg [1:0] line_draw_state_debug;

  // Visual Effect
  reg [2:0] color_changer = '0;

  // VSync edge detection for buffer swap
  always @(posedge clk_vga or posedge reset) begin
    if (reset) begin
      vsync_prev <= 1'b0;
    end else begin
      vsync_prev <= vsync;
    end
  end
  assign vsync_edge = vsync && !vsync_prev;  // Positive edge of vsync

  // Buffer swap logic
  always @(posedge clk_vga or posedge reset) begin
    if (reset) begin
      active_buffer <= 1'b0;
      swap_pending  <= 1'b0;
      swap_complete <= 1'b0;
    end else begin
      swap_complete <= 1'b0;

      if (swap_buffers && !swap_pending) begin
        swap_pending <= 1'b1;
      end

      if (swap_pending && vsync_edge) begin
        active_buffer <= ~active_buffer;
        swap_pending  <= 1'b0;
        swap_complete <= 1'b1;
      end
    end
  end

  // Route write signals to inactive buffer
  always @(*) begin
    if (active_buffer == 1'b0) begin
      // Buffer 0 is active (displayed), write to buffer 1
      vram0_wr_en   = 1'b0;
      vram0_wr_addr = 0;
      vram0_wr_data = 0;

      vram1_wr_en   = vram_wr_en;
      vram1_wr_addr = vram_wr_addr;
      vram1_wr_data = vram_wr_data;
    end else begin
      // Buffer 1 is active (displayed), write to buffer 0
      vram0_wr_en   = vram_wr_en;
      vram0_wr_addr = vram_wr_addr;
      vram0_wr_data = vram_wr_data;

      vram1_wr_en   = 1'b0;
      vram1_wr_addr = 0;
      vram1_wr_data = 0;
    end
  end
  reg [3:0] busy_extend_counter;
  /*FSM*/
  always @(posedge clk_sys or posedge reset) begin
    if (reset) begin
      current_state <= STATE_CLEARING;
      clear_addr_cnt <= 0;
      linedraw_go_reg <= 1'b0;
      busy_extend_counter <= '0;
    end else begin
      linedraw_go_reg <= 1'b0;
      case (current_state)

        STATE_CLEARING:
        if (clear_done) current_state <= STATE_READY;
        else clear_addr_cnt <= clear_addr_cnt + 1;

        STATE_READY:
        if (clear_screen_go) begin
          current_state  <= STATE_CLEARING;
          clear_addr_cnt <= 0;
        end else if (draw_go) begin
          linedraw_go_reg <= 1'b1;
          if (linedraw_busy) current_state <= STATE_DRAWING;
          else current_state <= current_state;
        end

        STATE_DRAWING:
        if (!linedraw_busy) begin
          current_state <= STATE_DRAWING_EXTEND;
          busy_extend_counter <= 0;
        end

        STATE_DRAWING_EXTEND: begin
          busy_extend_counter <= busy_extend_counter + 1;
          if (busy_extend_counter == 3) current_state <= STATE_READY;
        end

        default: current_state <= STATE_CLEARING;
      endcase
    end
  end

  always @(posedge clk_sys or posedge reset) begin
    if (reset) begin
      vram_wr_en <= 1'b0;
    end else begin
      // Default to no-write for safety
      vram_wr_en <= 1'b0;

      case (current_state)
        STATE_CLEARING: begin
          vram_wr_en   <= 1'b1;
          vram_wr_addr <= clear_addr_cnt;
          vram_wr_data <= BG_COLOR;
        end
        STATE_DRAWING: begin
          vram_wr_en <= linedraw_wr;
          vram_wr_addr <= linedraw_addr;
          // Use the constant value as per your test for maximum stability.
          // You can later change this back to `latched_color_in`.
          color_changer <= color_changer + 1;
          vram_wr_data <= (SW1) ? (color_changer) : color_in;
        end
      endcase
    end
  end


  /* Instantiate Modules */
  // Two VRAM buffers
  framebuffer_vram #(
      .WIDTH(WIDTH),
      .HEIGHT(HEIGHT),
      .DW(DW)
  ) vram0_inst (
      .wr_clk(clk_sys),
      .wr_en(vram0_wr_en),
      .wr_addr(vram0_wr_addr),
      .wr_d(vram0_wr_data),
      .rd_clk(clk_vga),
      .rd_addr(vram0_rd_addr),
      .rd_q(vram0_rd_q)
  );

  framebuffer_vram #(
      .WIDTH(WIDTH),
      .HEIGHT(HEIGHT),
      .DW(DW)
  ) vram1_inst (
      .wr_clk(clk_sys),
      .wr_en(vram1_wr_en),
      .wr_addr(vram1_wr_addr),
      .wr_d(vram1_wr_data),
      .rd_clk(clk_vga),
      .rd_addr(vram1_rd_addr),
      .rd_q(vram1_rd_q)
  );

  // VGA controller with buffer selection
  vga_controller_800x600_double #(
      .DW(DW)
  ) vga_inst (
      .clk_vga(clk_vga),
      .reset(reset),
      .hsync(hsync),
      .vsync(vsync),
      .blank_n(blank_n),
      .rgb_out(rgb_out),
      .rd_addr0(vram0_rd_addr),
      .rgb_in0(vram0_rd_q),
      .rd_addr1(vram1_rd_addr),
      .rgb_in1(vram1_rd_q),
      .active_buffer(active_buffer)
  );

  modified_linedraw #(
      .WIDTH (WIDTH),
      .HEIGHT(HEIGHT)
  ) linedraw_inst (
      .pclk(clk_sys),
      .go(linedraw_go_reg),
      .stax(stax),
      .stay(stay),
      .endx(endx),
      .endy(endy),
      .busy(linedraw_busy),
      .wr(linedraw_wr),
      .addr(linedraw_addr),
      .line_draw_state_debug(line_draw_state_debug),
      .dash_function(SW2)
  );
endmodule

//==============================================================================
// VGA Controller for 800x600 @ 60Hz with Double Buffer Support
//==============================================================================
module vga_controller_800x600_double #(
    parameter DW = 8
) (
    input wire clk_vga,
    input wire reset,
    output reg hsync,
    output reg vsync,
    output wire blank_n,
    output wire [DW-1:0] rgb_out,
    output wire [$clog2(800*600)-1:0] rd_addr0,
    input wire [DW-1:0] rgb_in0,
    output wire [$clog2(800*600)-1:0] rd_addr1,
    input wire [DW-1:0] rgb_in1,
    input wire active_buffer
);

  localparam H_DISPLAY=800, H_FP=40, H_SP=128, H_BP=88, H_TOTAL=H_DISPLAY+H_FP+H_SP+H_BP;
  localparam V_DISPLAY=600, V_FP=1,  V_SP=4,  V_BP=23, V_TOTAL=V_DISPLAY+V_FP+V_SP+V_BP;
  localparam H_SYNC_START = H_DISPLAY + H_FP, H_SYNC_END = H_SYNC_START + H_SP;
  localparam V_SYNC_START = V_DISPLAY + V_FP, V_SYNC_END = V_SYNC_START + V_SP;
  reg [10:0] h_count = 0, v_count = 0;


  always @(posedge clk_vga or posedge reset)
    if (reset) {h_count, v_count} <= 0;
    else begin
      if (h_count == H_TOTAL - 1) begin
        h_count <= 0;
        if (v_count == V_TOTAL - 1) v_count <= 0;
        else v_count <= v_count + 1;
      end else h_count <= h_count + 1;
    end
  always @(posedge clk_vga or posedge reset)
    if (reset) {hsync, vsync} <= 1;
    else begin
      hsync <= ~((h_count >= H_SYNC_START) && (h_count < H_SYNC_END));
      vsync <= ~((v_count >= V_SYNC_START) && (v_count < V_SYNC_END));
    end
  assign blank_n = (h_count < H_DISPLAY) && (v_count < V_DISPLAY);

  // Generate read address for both buffers
  wire [$clog2(800*600)-1:0] rd_addr = v_count * H_DISPLAY + h_count;
  assign rd_addr0 = rd_addr;
  assign rd_addr1 = rd_addr;

  // Select which buffer to display
  wire [DW-1:0] selected_rgb = (active_buffer == 1'b0) ? rgb_in0 : rgb_in1;
  assign rgb_out = blank_n ? selected_rgb : 8'h00;
endmodule

//==============================================================================
//
//               Modified Linedraw Module (Robust Version with Timeout)
//
//==============================================================================
module modified_linedraw #(
    parameter WIDTH  = 800,
    parameter HEIGHT = 600
) (
    input wire go,
    output wire busy,  /*synthesis keep*/
    input wire [$clog2(WIDTH)-1:0] stax,
    input wire [$clog2(HEIGHT)-1:0] stay,
    input wire [$clog2(WIDTH)-1:0] endx,
    input wire [$clog2(HEIGHT)-1:0] endy,
    output wire wr,  /*synthesis keep*/
    output wire [$clog2(WIDTH*HEIGHT)-1:0] addr,
    input wire pclk,

    /*BEGUG*/
    output wire [1:0] line_draw_state_debug,
    input dash_function

);

  // State definition
  localparam [1:0] IDLE = 2'd0, RUN = 2'd1, DONE = 2'd2;

  localparam X_BITS = $clog2(WIDTH);
  localparam Y_BITS = $clog2(HEIGHT);
  localparam DASH_PERIOD = 4'd7;
  // State register
  reg [1:0] state;
  /*DEBUG*/
  assign line_draw_state_debug = state;
  reg [4:0] dash_counter = '0;
  reg dash_enable = 1'b0;
  always @(posedge pclk) begin
      dash_counter <= dash_counter + 1;
      if (dash_counter == DASH_PERIOD - 1) begin
		  dash_counter <= 0;
        dash_enable <= ~dash_enable;
      end
  end

  // Position and error registers - 增加位寬以避免溢出
  reg signed [X_BITS+1:0] err;
  reg signed [  X_BITS:0] x;
  reg signed [  Y_BITS:0] y;

  // Wire declarations for algorithm - 所有 signed 信號增加 1 bit
  wire signed [X_BITS:0] x0, x1, deltax, dx, next_x, xa, xb;
  wire signed [Y_BITS:0] y0, y1, deltay, dy, next_y, ya, yb;
  wire signed [X_BITS+1:0] err_next, err1, err2, e2;

  wire in_loop, right, down, complete, e2_lt_dx, e2_gt_dy  /*synthesis keep*/;

  // FSM
  always @(posedge pclk) begin
    case (state)
      IDLE:
      if (go) state <= RUN;
      else state <= IDLE;

      RUN:
      if (complete) state <= DONE;
      else state <= RUN;

      DONE:
      if (go) state <= RUN;
      else state <= IDLE;

      default: state <= IDLE;
    endcase
  end

  // Line Drawing Algorithm

  // Data Path for dx, dy, right, down
  assign x0 = {1'b0, stax};
  assign x1 = {1'b0, endx};
  assign deltax = x1 - x0;
  assign right = ~deltax[X_BITS];  // 檢查最高位（符號位）
  assign dx = (!right) ? (-deltax) : (deltax);

  assign y0 = {1'b0, stay};
  assign y1 = {1'b0, endy};
  assign deltay = y1 - y0;
  assign down = ~deltay[Y_BITS];  // 檢查最高位（符號位）
  assign dy = (down) ? (-deltay) : (deltay);

  // Data Path for Error
  assign e2 = err << 1;
  assign e2_gt_dy = (e2 > dy) ? 1'b1 : 1'b0;
  assign e2_lt_dx = (e2 < dx) ? 1'b1 : 1'b0;
  assign err1 = e2_gt_dy ? (err + dy) : err;
  assign err2 = e2_lt_dx ? (err1 + dx) : err1;
  assign err_next = (in_loop) ? err2 : (dx + dy);
  assign in_loop = (state == RUN);

  // Data Path for X and Y
  assign next_x = (in_loop) ? xb : x0;
  assign xb = e2_gt_dy ? xa : x;
  assign xa = right ? (x + 1) : (x - 1);

  assign next_y = (in_loop) ? yb : y0;
  assign yb = e2_lt_dx ? ya : y;
  assign ya = down ? (y + 1) : (y - 1);

  // Complete when we reach the end point
  assign complete = ((x == x1) && (y == y1) || x > WIDTH - 1 || y > HEIGHT - 1);

  // Update position and error registers
  always @(posedge pclk) begin
    err <= err_next;
    x   <= next_x;
    y   <= next_y;
  end

  // Output assignments
  assign busy = in_loop;
  assign wr   = (dash_function) ? (in_loop && dash_enable) : in_loop;
  assign addr = y[Y_BITS-1:0] * WIDTH + x[X_BITS-1:0];

endmodule


//==============================================================================
// Dual-Port Framebuffer VRAM
//==============================================================================
module framebuffer_vram #(
    parameter WIDTH = 800,
    parameter HEIGHT = 240,
    parameter DW = 8,
    parameter ADDR_BITS = $clog2(WIDTH * HEIGHT)
) (
    input wire wr_clk,
    input wire wr_en,
    input wire [ADDR_BITS-1:0] wr_addr,
    input wire [DW-1:0] wr_d,
    input wire rd_clk,
    input wire [ADDR_BITS-1:0] rd_addr,
    output reg [DW-1:0] rd_q
);
  reg [DW-1:0] ram[0:(WIDTH*HEIGHT)-1];
  always @(posedge wr_clk) if (wr_en) ram[wr_addr] <= wr_d;
  always @(posedge rd_clk) rd_q <= ram[rd_addr];

endmodule
