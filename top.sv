`timescale 1ms/10ps
module top (
  // I/O ports
  input  logic hz100, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // UART ports
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);
  // intermediate logic signals
  logic strobeclk;
  logic [3:0] reg1_top, reg2_top, fsm_state
  logic [4:0] synckey_top;
  logic [31:0] seq_top;

  // module instantiations
  synckey synckey_top (.in(pb[16:0]), .clk(hz100), .rst(reset), .out(synckey_top), .strobe(strobeclk), .reg1(reg1_top), .reg2(reg2_top));
  fsm fsm_top (.clk(strobeclk), .rst(reset), .keyout(synckey_top), .seq(seq_top), .state(fsm_state));
  sequence_sr seq_top (.clk(strobeclk), .rst(reset), .en(fsm_state), .in(synckey_top), .out(seq_out));
  display display_top (.state(fsm_state), .seq(seq_top), .ss({ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0}), .red(red), .green(green), .blue(blue));

endmodule




