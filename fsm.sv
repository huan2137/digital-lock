`timescale 1ms/10ps
module fsm (
  // module input and output ports ...
  input logic clk, rst,
  input logic [4:0] keyout,
  input logic [31:0] seq,
  output logic [3:0] state
);

// finite state machine code
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

state_t current_state, next_state;
assign state = current_state;

// sequential logic
always_ff @(posedge clk, posedge rst) begin
  if (rst) begin
    current_state <= INIT;
  end else begin
    current_state <= next_state;
  end
end

// next state logic
always_comb begin
  case (current_state)
    LS0: begin
      if (keyout[3:0] == seq[31:28]) begin
        next_state = LS1;
      end else begin
        next_state = ALARM;
      end
    end
    LS1: begin
      if (keyout[3:0] == seq[27:24]) begin
        next_state = LS2;
      end else begin
        next_state = ALARM;
      end
    end
    LS2: begin
      if (keyout[3:0] == seq[23:20]) begin
        next_state = LS3;
      end else begin
        next_state = ALARM;
      end
    end
    LS3: begin
      if (keyout[3:0] == seq[19:16]) begin
        next_state = LS4;
      end else begin
        next_state = ALARM;
      end
    end
    LS4: begin
      if (keyout[3:0] == seq[15:12]) begin
        next_state = LS5;
      end else begin
        next_state = ALARM;
      end
    end
    LS5: begin
      if (keyout[3:0] == seq[11:8]) begin
        next_state = LS6;
      end else begin
        next_state = ALARM;
      end
    end
    LS6: begin
      if (keyout[3:0] == seq[7:4]) begin
        next_state = LS7;
      end else begin
        next_state = ALARM;
      end
    end
    LS7: begin
      if (keyout[3:0] == seq[3:0]) begin
        next_state = OPEN;
      end else begin
        next_state = ALARM;
      end
    end
    OPEN: begin
      if (keyout == 5'd16) begin
        next_state = LS0;
      end else begin
        next_state = OPEN;
      end 
    end
    ALARM: begin
      next_state = ALARM;
    end
    INIT: begin
      if (keyout == 5'd16) begin
        next_state = LS0;
      end else begin
        next_state = INIT;
      end
    end
    default: begin
      next_state = INIT;
    end
  endcase
end

endmodule