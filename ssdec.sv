`timescale 1ms/10ps
module ssdec (
  // module input and output ports ...
  input logic [3:0] in,
  input logic enable,
  output logic [6:0] out
);
  
  always_comb begin
    out = 7'd0;
    if(enable) begin  
      case(in)
        4'd0: begin out = 7'b0111111; end
        4'd1: begin out = 7'b0000110; end
        4'd2: begin out = 7'b1011011; end
        4'd3: begin out = 7'b1001111; end
        4'd4: begin out = 7'b1100110; end
        4'd5: begin out = 7'b1101101; end
        4'd6: begin out = 7'b1111101; end
        4'd7: begin out = 7'b0000111; end
        4'd8: begin out = 7'b1111111; end
        4'd9: begin out = 7'b1100111; end
        4'd10: begin out = 7'b1110111; end
        4'd11: begin out = 7'b1111100; end
        4'd12: begin out = 7'b0111001; end
        4'd13: begin out = 7'b1011110; end
        4'd14: begin out = 7'b1111001; end
        4'd15: begin out = 7'b1110001; end
      endcase
    end
  end
endmodule







