module test_tx();
  reg CLEAR, CLK, SEL, WRITE, SENT;
  reg[7:0] PWDATA;
  wire TXINTR, EMPTY;
  wire[7:0] TXDATA;

  TXFIFO txfifo(TXDATA, TXINTR ,CLEAR, CLK, PWDATA, SEL, WRITE, SENT);


  initial begin
    CLEAR <= 1'b0; CLK <= 1'b1; SEL <= 1'b1;
    WRITE <= 1'b1; PWDATA <= 8'b00010001; SENT <= 1'b0;
    #40 WRITE = 1'b0; SENT <= 1'b1;
    #70 CLEAR = 1'b1;
    #20 $finish;
  end

  always
    #5 CLK = ~CLK;
endmodule
