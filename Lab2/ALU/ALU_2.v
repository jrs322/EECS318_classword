

module ALU (C_out, ovrflow, carry, A_in, B_in, ALU_cmd);
  //in:out
  input[15:0] A_in, B_in;
  input[4:0] ALU_cmd;
  output[15:0] C_out;
  output ovrflow, carry;

  //wires:regs
  wire[1:0] cmd_type;
  wire[2:0] cmd_op;
  reg cin, ovrflow, carry;
  reg[3:0] shift_amt;
  reg[15:0] adder_in1, adder_in2, C_temp, C_out;
  wire[15:0] adder_sum;
  wire adder_co;
  //assign
  assign cmd_type[1:0] = ALU_cmd[4:3];
  assign cmd_op[2:0] = ALU_cmd[2:0];

  //contiuous adder
  log_adder alu_add(adder_sum, adder_co, adder_in1, adder_in2, cin);
  //begin case statements for ALU
  always @ (ALU_cmd or A_in or B_in)
    begin
      case(cmd_type)
        2'b00: begin //adder stuff
                case(cmd_op)
                  3'b000: begin // signed addition
                            adder_in1 <= A_in;
                            adder_in2 <= B_in;
                            cin <= 1'b0;
                            #20 C_out <= adder_sum; carry <= adder_co;
                            ovrflow <= ((adder_in1[15] == adder_in2[15]) && (C_temp[15] != adder_in1[15]));
                          end
                  3'b001: begin //unsigned addition
                            adder_in1 <= A_in;
                            adder_in2 <= B_in;
                            cin <= 1'b0;
                            #10 C_out <= adder_sum; carry <= adder_co; ovrflow <= 1'b0;
                          end
                  3'b010: begin //signed subtraction
                            cin = 1'b1;
                            adder_in1 <= A_in;
                            adder_in2 <= ~B_in;
                            #10 C_out <= adder_sum; carry <= adder_co;
                            ovrflow <= ((adder_in1[15] == adder_in2[15]) && (C_temp[15] != adder_in1[15]));
                          end
                  3'b011: begin //unisgned subtraction
                            cin = 1'b1;
                            adder_in1 <= A_in;
                            adder_in2 <= ~B_in;
                            #10 C_out <= adder_sum; carry <= adder_co; ovrflow <= 0;
                          end
                  3'b100: begin //signed increment
                            cin = 1'b1;
                            adder_in1 <= A_in;
                            adder_in2 <= 16'b0;
                            #10 C_out <= adder_sum; carry <= adder_co;
                            ovrflow <= ((adder_in1[15] == adder_in2[15]) && (C_temp[15] != adder_in1[15]));
                          end
                  3'b101: begin //signed decrement
                            cin = 1'b0;
                            adder_in1 <= A_in;
                            adder_in2 <= 16'b1111111111111111;
                            #10 C_out <= adder_sum; carry <= adder_co;
                            ovrflow <= ((adder_in1[15] == adder_in2[15]) && (C_temp[15] != adder_in1[15]));
                          end

                  default: C_out <= 16'bz;

                endcase
               end
        2'b01: begin //logic stuff
                carry <= 1'b0;
                ovrflow <= 1'b0;
                case(cmd_op)
                  3'b000: C_out = A_in & B_in;//and
                  3'b001: C_out = A_in | B_in;//or
                  3'b010: C_out = A_in ^ B_in;//xor
                  3'b100: C_out <= A_in & B_in;//not

                  default: C_out <= 16'bz;

                endcase
               end
        2'b11: begin //shifting stuff
                shift_amt <= B_in[3:0];
		            C_temp <= A_in;
                carry <= 1'b0;
                ovrflow <= 1'b0;
                case(cmd_op)
                  3'b000: C_out <= C_temp << shift_amt;
                  3'b001: C_out <= C_temp >> shift_amt;
                  3'b010: C_out <= C_temp <<< shift_amt;
                  3'b100: C_out <= C_temp >>> shift_amt;

                  default: C_out <= 16'bz;

                endcase
               end
        2'b10: begin //conditional stuff begins here
                carry <= 1'b0;
                ovrflow <= 1'b0;
                case(cmd_op)
                  3'b000: begin
                            if (A_in <= B_in)
                              C_out = 16'b01;
                            else
                              C_out = 16'b0;
                          end
                  3'b001: begin
                            if (A_in < B_in)
                              C_out = 16'b01;
                            else
                              C_out = 16'b0;
                          end
                  3'b010: begin
                            if (A_in >= B_in)
                              C_out = 16'b01;
                            else
                              C_out = 16'b0;
                          end
                  3'b011: begin
                            if (A_in > B_in)
                              C_out = 16'b01;
                            else
                              C_out = 16'b0;
                          end
                  3'b100: begin
                            if (A_in == B_in)
                              C_out = 16'b01;
                            else
                              C_out = 16'b0;
                          end
                  3'b101: begin
                            if (A_in != B_in)
                              C_out = 16'b01;
                            else
                              C_out = 16'b0;
                          end

                  default: C_out <= 16'bz;

                endcase
               end
        default: C_out <= 16'bz;  // default for CMD_type
      endcase
    end

    initial begin
      $monitor("%d %d %b %b %b %b %b", $time, {carry, C_out}, {carry, C_out}, ovrflow, A_in, B_in, ALU_cmd);
    end

endmodule
