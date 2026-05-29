import tailights_pkg::*;

module ucsbece152a_fsm(
  input logic clk;
  input logic rst_n;
  
  input logic left_i;
  input logic right_i;
  input logic hazard_i;
  
  output state_t state_o;
  output logic[5:0] pattern_o;
);
  
  state_t state_d, state_q= S000_000;
  assign state_o= state_q;
  
  //Solve
  
  
endmodule
