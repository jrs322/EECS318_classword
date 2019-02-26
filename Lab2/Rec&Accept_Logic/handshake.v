module handshake_b (E, A, R, RST, CLK);
  input A, R, RST, CLK;
  output E;
  reg E = 0;
  reg last_r = 0;
  always @ (posedge CLK) begin
    if (E == 0) begin
      if (last_r == 0 && A == 1)
        E <= 1;
      else
        E <= 0;
    end
    else
      begin
      if (RST == 1)
        begin
          E <= 0;
        end
      else
        E <= 1;
      end
    last_r = R;
  end
  initial
    begin
    $monitor("%d %b %b %b %b", 3'b100, E, A, R, RST);
    end
endmodule //handshake

module handshake_s (E, A, R, RST, CLK);
  input A, R, RST, CLK;
  output E;
  reg E;
  reg s1;
  reg s2;
  reg s3;
  reg[2:0] case1;
  reg[1:0] case2;
  initial begin
    E <= 1'b0;
    s1 <= 1'b0; s2 <= 1'b0; s3 <= 1'b0;
  end
  always @ (posedge CLK) begin
    if (RST)
      begin
        s1 <= 1'b0; s2 <= 1'b0; s3 <= 1'b0;
        case2[1:0] <= 2'b00;
      end
    else
      case2[1] <= R; case2[0] <= A;

    case1[2] <= s1; case1[1] <= s2; case1[0] <= s3;

    case (case1)
      3'b000:
        begin
          case(case2)
          2'b00 :
            begin
              s1 <= 0;
              s2 <= 0;
              s3 <= 0;
              E <= 0;
            end
          2'b01 :
            begin
              s1 <= 1;
              s2 <= 0;
              s3 <= 0;
              E <= 1;
            end
          2'b10 :
            begin
              s1 <= 0;
              s2 <= 0;
              s3 <= 1;
              E <= 0;
            end
          2'b11 :
            begin
              s1 <= 1;
              s2 <= 0;
              s3 <= 0;
              E <= 1;
            end
        endcase
      end
      3'b001: begin // first statement
	       case(case2)
          2'b00 :
            begin
              s1 <= 1;
              s2 <= 0;
              s3 <= 0;
              E <= 1;
            end
          2'b01 :
            begin
              s1 <= 1;
              s2 <= 0;
              s3 <= 0;
              E <= 1;
            end
          2'b10 :
            begin
              s1 <= 0;
              s2 <= 0;
              s3 <= 1;
              E <= 0;
            end
          2'b11 :
            begin
              s1 <= 0;
              s2 <= 1;
              s3 <= 0;
              E <= 0;
            end
      	endcase
      end
      3'b010: begin // second statement
	       case(case2)
          2'b00 :
            begin
              s1 <= 1;
              s2 <= 0;
              s3 <= 0;
              E <= 1;
            end
          2'b01 :
            begin
              s1 <= 0;
              s2 <= 1;
              s3 <= 1;
              E <= 0;
            end
          2'b10 :
            begin
 	            s1 <= 1;
	            s2 <= 0;
	            s3 <= 0;
	            E <= 1;
            end
          2'b11 :
            begin
              s1 <= 0;
              s2 <= 1;
              s3 <= 0;
              E <= 0;
            end
        endcase
	     end
        3'b011: begin // third case statement
	         case(case2)
            2'b00 :
              begin
                s1 <= 0;
                s2 <= 0;
                s3 <= 0;
                E <= 0;
              end
            2'b01 :
              begin
                s1 <= 0;
                s2 <= 1;
                s3 <= 1;
                E <= 0;
              end
            2'b10 :
              begin
	               s1 <= 1;
	               s2 <= 0;
	               s3 <= 0;
	               E <= 1;
              end
            2'b11 :
              begin
                s1 <= 1;
                s2 <= 0;
                s3 <= 0;
                E <= 1;
              end
          endcase
        end
        3'b100: begin //fourth case statement
	         case(case2)
            2'b00 : begin
              s1 <= 1;
              s2 <= 0;
              s3 <= 0;
              E <= 1;
            end
            2'b01 : begin
              s1 <= 1;
              s2 <= 0;
              s3 <= 0;
              E <= 1;
            end
            2'b10 : begin
              s1 <= 1;
              s2 <= 0;
              s3 <= 0;
              E <= 1;
            end
            2'b11 : begin
              s1 <= 1;
              s2 <= 0;
              s3 <= 0;
              E <= 1;
            end
      // end 2 bit internal cases
        endcase
      end
    // end 3 bit 100
    endcase
  // end 3 bit case statement
  end

  initial
    begin
      $monitor("%d %b %b %b %b %b %b %b %b %b", 3'b111 , E, R, A, RST, s1, s2, s3, case1, case2);
    end

endmodule //handshake_s
