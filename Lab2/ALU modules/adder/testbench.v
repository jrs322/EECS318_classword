//Testbench for brent kung adder

module Testbench ();
  reg[15:0] A, B;
  reg cin;
  wire[15:0] sum;
  wire co;
  log_adder a(sum,co, A, B, cin);

  initial begin
    A <= 16'b0; B <= 16'b0; cin <= 1'b0;
    #50 A <= 16'b1111111100000000; B <= 16'b0000000011111111;
    #50 A <= 16'b1010101010101010; B <= 16'b0101010101010101;
    #50 A <= 16'b0111111111111111; B <= 16'b0111111111111111;
    #50 A <= 16'b1111111111111111; B <= 16'b1111111111111111; cin = 1;
    #50 A <= 16'b0000000000000000; B <= 16'b0000000000000001; cin = 1;
    #50 A <= 16'b1111111111111111; B <= 16'b0000000000000000; cin = 1;
    #20 $finish;
  end


endmodule //Testbench for brent kung adder
