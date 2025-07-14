`timescale 1ms/10ps
module display (
  // module input and output ports ...
  input logic [3:0] state,
  input logic [31:0] seq,
  output logic [63:0] ss,
  output logic red, green, blue
);
  // intermediate logic signals
  logic [63:0] dis_seq;

  // call ssdec instances for displaying passcode
  ssdec ssdec7 (.in(seq[31:28]), .enable(1'b1), .out(dis_seq[62:56]));
  ssdec ssdec6 (.in(seq[27:24]), .enable(1'b1), .out(dis_seq[54:48]));
  ssdec ssdec5 (.in(seq[23:20]), .enable(1'b1), .out(dis_seq[46:40]));
  ssdec ssdec4 (.in(seq[19:16]), .enable(1'b1), .out(dis_seq[38:32]));
  ssdec ssdec3 (.in(seq[15:12]), .enable(1'b1), .out(dis_seq[30:24]));
  ssdec ssdec2 (.in(seq[11:8]), .enable(1'b1), .out(dis_seq[22:16]));
  ssdec ssdec1 (.in(seq[7:4]), .enable(1'b1), .out(dis_seq[14:8]));
  ssdec ssdec0 (.in(seq[3:0]), .enable(1'b1), .out(dis_seq[6:0]));

  // combinational logic
  always_comb begin
    red = 1'b0;
    green = 1'b0;
    blue = 1'b0;
    
    case(state)

      4'd0: begin ss = {1'b1, 63'd0}; blue = 1'b1; end
      4'd1: begin ss = {8'd0, 1'b1, 55'd0}; blue = 1'b1; end
      4'd2: begin ss = {16'd0, 1'b1, 47'd0}; blue = 1'b1; end
      4'd3: begin ss = {24'd0, 1'b1, 39'd0}; blue = 1'b1; end
      4'd4: begin ss = {32'd0, 1'b1, 31'd0}; blue = 1'b1; end
      4'd5: begin ss = {40'd0, 1'b1, 23'd0}; blue = 1'b1; end
      4'd6: begin ss = {48'd0, 1'b1, 15'd0}; blue = 1'b1; end
      4'd7: begin ss = {56'd0, 1'b1, 7'd0}; blue = 1'b1; end

      4'd8: begin 
        ss = {32'b0, 8'b00111111, 8'b01110011, 8'b01111001, 8'b00110111};
        green = 1'b1;
      end

      4'd9: begin
        ss = {8'b00111001, 8'b01110111, 8'b00111000, 8'b00111000, 8'd0, 8'b01100111, 8'b00000110, 8'b00000110};
        red = 1'b1;
      end

      4'd10: begin
        red = 1'b0;
        green = 1'b0;
        blue = 1'b0;
        ss = dis_seq;
      end

      default: begin ss = dis_seq; end
    
    endcase
  end

endmodule







