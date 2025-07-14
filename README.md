# SystemVerilog Digital Lock

Designed a digital lock system in SystemVerilog and prototyped it on the ICE40HX8K FPGA. The lock features reprogrammable 8 digit passwords, an alarm state, and a user-friendly interface.
    
The lock is implemented using a finite state machine consisting of 11 states (8 password digits, init, alarm, and open). The system uses a strobe-driven encoder to detect valid button presses, updating an internal register only on synchronized events. The password is stored in a custom module that accepts overflow based on the FSM state. Output is shown in real-time on seven-segment displays with a decoder.

An FSM testbench was written to verify correct FSM behavior, and a synckey testbench was written to verify strobe timing, and proper reset handling under various button inputs. Each testbench tests for power-on reset, normal operation, and mid-operation reset.
