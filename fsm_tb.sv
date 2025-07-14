`timescale 1ms/1ps
module fsm_tb;
  logic clk, reset;
  logic [4:0] keyout;
  logic [31:0] seq;
  logic [3:0] state;

  fsm fsm_DUT (.clk(clk), .rst(reset), .keyout(keyout), .seq(seq), .state(state));

  typedef enum logic [3:0] {
    LS0 = 0,
    LS1 = 1,
    LS2 = 2,
    LS3 = 3,
    LS4 = 4,
    LS5 = 5,
    LS6 = 6,
    LS7 = 7,
    OPEN = 8,
    ALARM = 9,
    INIT = 10
  } state_t;

  state_t expected_state;

  assign seq = 32'h12345678;

  // clock always runs
  always begin
    #1
    clk = ~clk;
  end

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
    $dumpfile("waves/fsm.vcd");
    $dumpvars(0, fsm_tb);

    // initialize variables
    clk = 0;
    keyout = '0;
    expected_state = INIT;

    // power on reset
    $display("power on reset test case\n");
    toggle_reset();
    expected_state = INIT;
    compare(expected_state, state);

    // user presses lock button
    $display("\n\nlocking test case\n");
    toggle_reset();
    keyout = 5'd16;
    expected_state = LS0;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    // regular operation
    $display("\n\nregular operation\n");
    keyout = 5'h1;
    expected_state = LS1;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    keyout = 5'h2;
    expected_state = LS2;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    keyout = 5'h3;
    expected_state = LS3;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    keyout = 5'h4;
    expected_state = LS4;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    keyout = 5'h5;
    expected_state = LS5;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    keyout = 5'h6;
    expected_state = LS6;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    keyout = 5'h7;
    expected_state = LS7;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    keyout = 5'h8;
    expected_state = OPEN;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    #4
    keyout = 5'd16;
    expected_state = LS0;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    // alarm state
    $display("\n\npurposeful alarm toggle\n");
    keyout = 5'h1;
    expected_state = LS1;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    keyout = 5'h2;
    expected_state = LS2;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    keyout = 5'h6;
    expected_state = ALARM;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    // mid operation reset
    $display("\n\nmid operation reset");
    toggle_reset();

    keyout = 5'd16;
    expected_state = LS0;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    keyout = 5'h1;
    expected_state = LS1;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    toggle_reset();
    expected_state = INIT;
    @(posedge clk);
    @(negedge clk);
    compare(expected_state, state);

    // finish the simulation
    #1 
    $finish;

  end

endmodule








