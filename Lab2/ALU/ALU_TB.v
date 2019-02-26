
module Testbench();
  reg[15:0] A, B;
  reg[4:0] alu_code;
  wire[15:0] C;
  wire of, co;
  ALU risc(C, of , co , A, B, alu_code);
  initial
    begin
    //arithmetic
      $display("This is adder operations: \n");
      alu_code[4:0] <= 5'b00001;
      //Test unsigned addition
      A <= 16'b0; B <= 16'b0;
      #50 A <= 16'b100111000100; B <= 16'b11101010011000; // 2500 + 15000
      #50 A <= 16'b1111111111111111; B <= 16'b1111111111111111;
      //Test unsigned subtraction
      #10 A <= 16'b0; B <= 16'b0;
      #10 alu_code[2:0] <= 3'b011;
      #10 A <= 16'b1111101000000000; B <= 16'b111110100000000; //64000 - 32000
      #10 A <= 16'b1111111111111111; B <= 16'b1111111111111111;
      //Test signed addition
      #10 A <= 16'b0; B <= 16'b0;
      #10 alu_code[2:0] <= 3'b000;
      #10 A <= 16'b1111111000001100; B <= 16'b111110100; //-500 + 500
      #10 B <= 16'b1110111001101100; B <= 16'b1110111001101100; //-4500 + -4500
      //Test signed subtraction
      #10 A <= 16'b0; B <= 16'b0;
      #10 alu_code[2:0] <= 3'b010;
      #10 A <= 16'b1111111011010100; B <= 16'b111110100; //-300 - 500
      #10 A <= 16'b10111011100; B <= 16'b1111101000100100; //1500 - -1500
      //Test increment
      #10 A <= 16'b0; B <= 16'b0;
      #10 alu_code[2:0] <= 3'b100;
      #10 A <= 16'b1111111111111111;
      #10 A <= 16'b0000000000000000;
      //Test decrement
      #10 A <= 16'b0; B <= 16'b0;
      #10 alu_code[2:0] <= 3'b101;
      #10 A <= 16'b0;
      #10 A <= 16'b1111111100000000;

      //logic
      $display("This is logic operations: \n");
      #10 A <= 16'b0; alu_code[4:3] <= 2'b01;
      //and
      alu_code[2:0] <= 3'b000;
      #10 A <= 16'b1010000011110000; B <= 16'b1010000011110000;
      #10 A <= 16'b0; B <= 16'b01;
      //or
      #10 alu_code[2:0] <= 3'b001;
      A <= 16'b0111; B <= 16'b1000;
      #10 A <= 16'b0; B <= 16'b0;
      //xor
      #10 alu_code[2:0] <= 3'b010;
      #10 A <= 16'b1010; B <= 16'b0101;
      #10 A <= 16'b1111; B <= 16'b1111;
      //not
      #10 alu_code[2:0] <= 3'b100;
      A <= 16'b0;
      #10 A <= 16'b1111111111111111;
      #10 A <= 16'b0000111100001111;
      //shift operation
      $display("This is shift operations: \n");
      #10 A <= 16'b0; B <= 16'b0; alu_code[4:3] <= 2'b11;
      // L shift left
      alu_code[2:0] <= 3'b000;
      #10 A <= 16'b1; B <= 16'b1111;
      // L shift right
      #10 alu_code[4:3] <= 3'b001; A <= 16'b1000000000000000;
      // A shift left
      #10 alu_code[4:3] <= 3'b010; A <= 16'b1111;
      // A shift right
      #10 alu_code[4:3] <= 3'b100; A <= 16'b10001111;
      //conditional
      $display("This is conditional Logic: \n");
      #10 alu_code <= 5'b10000;
      $display("This is conditional Logic: A <= B \n");
      // A <= B
      A <= 16'b111110100; B <= 16'b111000010;
      #10 A <= 16'b111000010; B <= 16'b111110100;
      #10 B <= 16'b111000010;
      // A < B
      $display("This is conditional Logic: A < B \n");
      #10 alu_code[2:0] <= 3'b001;
      A <= 16'b1111110111101000; B <= 16'b1010111111001000;
      #10 B <= 16'b1111110111101000; A <= 16'b1010111111001000;
      $display("This is conditional Logic: A >= B \n");
      // A >= B
      #10 alu_code[2:0] <= 3'b010;
      A <= 16'b1111110111101000; B <= 16'b1010111111001000;
      #10 B <= 16'b1111110111101000; A <= 16'b1010111111001000;
      #10 A <= 16'b1111110111101000;
      // A > B
      $display("This is conditional Logic: A > B \n");
      #10 alu_code[2:0] <= 3'b011;
      A <= 16'b1111110111101000; B <= 16'b1010111111001000;
      #10 B <= 16'b1111110111101000; A <= 16'b1010111111001000;
      // A == B
      $display("This is conditional Logic: A == B\n");
      #10 alu_code[2:0] <= 3'b100;
      A <= 16'b0; B <= 16'b01;
      #10 B <= 16'b0;
      // A != B
      $display("This is conditional Logic: A != B \n");
      #10 alu_code[2:0] <= 3'b101;
      A <= 16'b0; B <= 16'b01;
      #10 B <= 16'b0;
      #1000 $finish;
    end


endmodule
