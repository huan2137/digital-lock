`timescale 1ms/10ps
module synckey_tb;
  logic clk, reset, strobe;
  logic [16:0] tb_in;
  logic [4:0] tb_out, expected_output;
  logic [3:0] reg1, reg2;

  synckey synckey_DUT (.in(tb_in), .clk(clk), .rst(reset), .out(tb_out), .strobe(strobe), .reg1(reg1), .reg2(reg2));
  
  // clock always runs
  always begin
    #1
    clk = ~clk;
  end

  // task for resetting
  task toggle_reset();
    reset = 1; #4;
    reset = 0; #4;
  endtask

  task compare(int expected, int actual); 
  begin
    if (expected == actual) begin
      $display("PASSED test case (expected = actual = %d)", expected);
    end else begin
      $display("FAILED test case \n expected = %d, actual = %d", expected, actual);
    end
  end
  endtask

  initial begin
    // dump signals to see them in waveform
    $dumpfile("waves/synckey.vcd");
    $dumpvars(0, synckey_tb);

    // initialize inputs
    clk = '0;
    tb_in = '0;
    expected_output = '0;

    // power on reset
    $display("power on reset test case\n");
    toggle_reset();
    expected_output = 0;
    @(posedge clk);
    @(posedge clk);
    compare(expected_output, tb_out);

    // normal operation
    $display("\n\nnormal operation\n");
    toggle_reset();
    for (int i = 1; i < 17; i++) begin
      expected_output = i - 1;
      @(posedge clk);
      @(negedge clk);
      compare(expected_output, tb_out);
      tb_in = 1 << i;
      @(posedge clk);
      @(negedge clk);
      tb_in = 0;
    end

    // mid operation reset
    $display("\n\nmid operation reset test case\n");
    toggle_reset();
    tb_in = 17'd32;
    expected_output = 5;
    @(posedge clk);
    @(posedge clk);
    compare(expected_output, tb_out);
    #10
    toggle_reset();
    expected_output = 5;
    @(posedge clk);
    @(posedge clk);
    compare(expected_output, tb_out);

    // finish the simulation
    #1 
    $finish;
  end
endmodule






