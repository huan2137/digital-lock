`timescale 1ms/10ps
module synckey (
  // module input and output ports ...
  input logic [16:0] in,
  input logic clk, rst,
  output logic [4:0] out,
  output logic strobe,
  output logic [3:0] reg1, reg2
);
  logic intermediate; // intermediate logic signals
  logic [7:0] register; 

  always_comb begin
    out = 5'd0; // default to avoid inferred latch
    for (int i = 0; i < 20; i++) begin
      if (in[i]) begin
        out = i[4:0];
      end
    end
  end

  // sequential logic for strobe signal
  always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
      intermediate <= 1'b0;
      strobe <= 1'b0;
    end else begin
      intermediate <= |in;
      strobe <= intermediate;
    end
  end

  // sequential logic for register
  always_ff @(posedge strobe, posedge rst) begin
    if (rst) begin
      register <= 8'b0;
    end else begin
      register <= {3'b0, out};
    end
  end

  assign reg1 = register[3:0];
  assign reg2 = register[7:4];

endmodule







