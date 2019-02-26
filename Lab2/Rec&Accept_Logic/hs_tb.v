module Testbench();
  reg R_b, A_b, RST_b, CLK;
  reg R_s, A_s, RST_s;
  wire E_b, E_s;

  //handshake_b circuit1(E_b, A_b, R_b, RST_b, CLK); //E, A, R, RST, CLK
  handshake_s circuit2(E_s, A_s, R_s, RST_s, CLK); //E, A, R, RST, CLK

  initial
    begin
      CLK <= 1'b1;
      R_b <= 1'b0; R_s <= 1'b0;
      A_b <= 1'b0; A_s <= 1'b0;
      RST_b <= 1'b0; RST_s <= 1'b0;
      // begin test of cycle
      #10 R_b <=1'b1; R_s <= 1'b1;
      #10 A_s <=1'b1; A_b <= 1'b1;
      #10 R_b <=1'b0; R_b <= 1'b0;
      #10 A_b <=1'b0; A_s <= 1'b0;
      #20 A_b <= 1'b1; A_s <= 1'b1;
      #10 R_b <= 1'b1; R_s <= 1'b1;
      #50 RST_b <= 1'b1; RST_s <= 1'b1;
      #200 $finish;
    end

  always
    begin
      #5 CLK = ~CLK;
    end
endmodule
