`timescale 1ms/10ps
module sequence_sr (
  // module input and output ports ...
  input logic clk, rst, 
  input logic [3:0] en,
  input logic [4:0] in,
  output logic [31:0] out
);
  always_ff @(posedge clk, posedge rst)
    if (rst) begin
      out <= 32'd0;
    end else if (en == 4'd10 && in != 5'd16) begin
      out <= {out[27:0], in[3:0]};
    end else begin
      out <= out;
    end

endmodule